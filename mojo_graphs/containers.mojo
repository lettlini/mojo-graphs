"""
This file contains "container" types that are meant to be used as the underlying
representations of graphs
"""
from memory import memset_zero


fn sub2ind(M: AdjMatrix, i: Int, j: Int) raises -> Int:
    """Calculates the linear index from subscript (i,j) for an AdjMatrix."""
    let linear_index: Int

    # check if subscript is valid
    if (i < 0 or i >= M.rows) or (j < 0 or j >= M.columns):
        raise Error("OutOfBoundsError")

    else:
        if M.is_symmetric():
            if j > i:
                linear_index = j + (i * M.rows - i * (i + 1) // 2)
            else:
                linear_index = i + (j * M.rows - j * (j + 1) // 2)
        else:
            return i + M.rows * j

        return linear_index


struct AdjMatrix:
    """
    Type for storing the adjacency matrix of a graph.

    If created as a symmetric matrix only the lower triangular matrix is stored in memory.
    """

    var _data: DTypePointer[DType.bool]
    var rows: Int
    var columns: Int
    var _memnumels: Int  # number of elements actually stored in memory
    var _numels: Int  # number of ACCESSIBLE elements
    var _symmetric: Bool

    fn __init__(inout self, rows: Int, cols: Int, symmetric: Bool = False):
        self.rows = rows
        self.columns = cols
        self._numels = rows * cols

        if symmetric:
            self._memnumels = rows * (rows + 1) // 2
        else:
            self._memnumels = rows * cols

        self._data = DTypePointer[DType.bool].alloc(self._memnumels)
        memset_zero(self._data, self._memnumels)

    fn __getitem__(self, i: Int, j: Int) raises -> Bool:
        return self[sub2ind(self, i, j)]

    fn __getitem__(self, i: Int) raises -> Bool:
        if i > self._memnumels - 1:
            raise Error("OutOfBoundsError")

        return self._data.load(i)

    fn __setitem__(self, i: Int, j: Int, value: Bool) raises:
        self[sub2ind(self, i, j)] = value

    fn __setitem__(self, i: Int, value: Bool) raises:
        if i > self._memnumels - 1:
            raise Error("OutOfBoundsError")

        self._data.store(i, value)

    fn is_symmetric(self) -> Bool:
        return self._symmetric

    fn dump(self) raises:
        """Print values."""
        let maxchars: Int = 5
        let currentel: Bool

        print_no_newline("[")

        for i in range(self.rows):
            if i > 0:
                print_no_newline(" ")
            print_no_newline("[")
            for j in range(self.columns):
                currentel = self[i, j]

                if j == self.columns - 1:
                    if i == self.rows - 1:
                        print(currentel, "]]")
                    else:
                        print(currentel, "], ")
                else:
                    if currentel:
                        print_no_newline(" ")
                    print_no_newline(String(currentel), ", ")

    fn __del__(owned self):
        # free memory on end of lifetime
        self._data.free()

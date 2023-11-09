"""
This file contains "container" types that are meant to be used as the underlying
representations of graphs
"""
from memory import memset_zero


fn sub2ind(M: SymmetricMatrix, i: Int, j: Int) raises -> Int:
    """Calculates the linear index from subscript for a SymmetricMatrix."""
    let linear_index: Int

    # check if subscript is valid
    if i > M.rows - 1 or j > M.rows - 1:
        raise Error("OutOfBoundsError")

    if j > i:
        linear_index = j + (i * M.rows - i * (i + 1) // 2)
    else:
        linear_index = i + (j * M.rows - j * (j + 1) // 2)

    return linear_index


struct SymmetricMatrix:
    """
    Type for efficiently storing symmetric matrices saving memory by only
    allocating memory for the lower triangular matrix.

    This type can be used for representing the adjacency matrix of simple graphs
    """

    var data: DTypePointer[DType.bool]
    var rows: Int
    var columns: Int
    var num_elements: Int

    fn __init__(inout self, rows: Int):
        self.num_elements = rows * (rows + 1) // 2
        self.rows = rows
        self.columns = rows
        self.data = DTypePointer[DType.bool].alloc(self.num_elements)
        memset_zero(self.data, self.num_elements)

    fn __getitem__(self, i: Int, j: Int) raises -> Bool:
        return self[sub2ind(self, i, j)]

    fn __getitem__(self, i: Int) raises -> Bool:
        if i > self.num_elements - 1:
            raise Error("OutOfBoundsError")

        return self.data.load(i)

    fn __setitem__(self, i: Int, j: Int, value: Bool) raises:
        self[sub2ind(self, i, j)] = value

    fn __setitem__(self, i: Int, value: Bool) raises:
        if i > self.num_elements - 1:
            raise Error("OutOfBoundsError")

        self.data.store(i, value)

    fn dump(self) raises:
        print_no_newline("[")
        for i in range(self.rows):
            print_no_newline("[")
            for j in range(self.columns):
                print_no_newline(String(self[i,j]), ", ")
            print("],")
        print("]")

    fn __del__(owned self):
        # free memory on end of lifetime
        self.data.free()

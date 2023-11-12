"""
Basic Unit Testing

test cases:
-----------
1. `test_sub2ind`: test sub2ind function
2. `test_dump`: check output of dump() functions
3. `test_symmetric_matrix`: check if SymmetricMatrix is initialized properly
"""

from testing import assert_equal

from mojo_graphs import SymmetricMatrix, sub2ind

fn test_sub2ind() raises:
    """Checks that sub2ind works correctly."""

    print_no_newline("test_sub2ind: \t")

    let testMatrix:SymmetricMatrix = SymmetricMatrix(5)

    _ = assert_equal(sub2ind(testMatrix, 0, 0), 0)
    print_no_newline(".")
    _ = assert_equal(sub2ind(testMatrix, 1, 0), 1)
    print_no_newline(".")
    _ = assert_equal(sub2ind(testMatrix, 1, 1), 5)
    print_no_newline(".")
    _ = assert_equal(sub2ind(testMatrix, 4, 1), 8)
    print_no_newline(".")

    for i in range(testMatrix.rows):
        for j in range(testMatrix.columns):
            if assert_equal(sub2ind(testMatrix, i, j), sub2ind(testMatrix, j, i)):
                print_no_newline(".")
            else:
                raise Error("Test Case failed!")
    put_new_line()

fn test_dump() raises:
    let testMatrix: SymmetricMatrix = SymmetricMatrix(10)
    testMatrix.dump()

fn main() raises:
    # run all unit tests
    test_dump()
    test_sub2ind()

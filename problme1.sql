START

    // Declare the maximum size for the array that will hold the binary tree
    CONSTANT MAX_SIZE = 100

    // Initialize an array called 'tree' of size MAX_SIZE to store the tree nodes
    // Initially, each position in the array is filled with '-' to represent empty spots
    DECLARE array 'tree[MAX_SIZE]' and set all elements to '-'

    // Function to find the index of a node in the tree array
    FUNCTION findNodeIndex(node):
        FOR each element 'i' from 0 to MAX_SIZE - 1:
            IF tree[i] equals node:
                RETURN i  // Node found, return its index
        END FOR
        RETURN -1  // Node not found, return -1
    END FUNCTION

    // Function to read tree data from a file and store it in the tree array
    FUNCTION buildTreeFromFile(filename):
        // Try to open the file
        OPEN file with 'filename' for reading
        IF file cannot be opened:
            PRINT "Error: Could not open file"
            RETURN

        // Initialize the tree array to '-' (empty) in all positions
        FOR each element 'i' from 0 to MAX_SIZE - 1:
            SET tree[i] to '-'

        // Read parent-child relationships from the file
        WHILE file has more lines:
            READ 'parent', 'leftChild', 'rightChild' from the current line

            // Find the index of the parent in the tree array
            SET parentIndex to findNodeIndex(parent)

            // If the parent is not already in the tree, add it to the next available spot
            IF parentIndex equals -1:
                FOR each element 'i' from 0 to MAX_SIZE - 1:
                    IF tree[i] equals '-':  // Find the first available empty spot
                        SET tree[i] to parent  // Add the parent to this spot
                        SET parentIndex to i  // Store the parent's index
                        BREAK  // Stop searching once the parent is added

            // Add the left child to the correct spot in the array
            IF leftChild is not 'Z':  // 'Z' represents an empty node
                SET tree[2 * parentIndex + 1] to leftChild  // Place left child at 2 * parentIndex + 1

            // Add the right child to the correct spot in the array
            IF rightChild is not 'Z':  // 'Z' represents an empty node
                SET tree[2 * parentIndex + 2] to rightChild  // Place right child at 2 * parentIndex + 2

        CLOSE the file
    END FUNCTION

    // Function to print the tree stored in the array
    FUNCTION printTreeArray():
        PRINT "Binary tree in array representation:"
        FOR each element 'i' from 0 to MAX_SIZE - 1:
            IF tree[i] is not '-':  // Only print the non-empty nodes
                PRINT "Index i: " + tree[i]
    END FUNCTION

    // Function to find and print the parent of a given node
    FUNCTION findParent(node):
        // Find the index of the given node
        SET nodeIndex to findNodeIndex(node)

        // If the node is not found in the tree, print an error message
        IF nodeIndex equals -1:
            PRINT node + " not found in the tree."
            RETURN

        // If the node is at index 0, it is the root, and has no parent
        IF nodeIndex equals 0:
            PRINT node + " is the root of the tree."
            RETURN

        // Calculate the parent's index (formula: (nodeIndex - 1) / 2)
        SET parentIndex to (nodeIndex - 1) / 2

        // Print the parent node
        PRINT "The parent of " + node + " is " + tree[parentIndex]
    END FUNCTION

    // Main Function to execute the entire process
    FUNCTION main():
        PRINT "Enter the input file name:"
        INPUT filename  // Get the filename from the user

        // Call the function to build the tree from the file
        CALL buildTreeFromFile(filename)

        // Call the function to print the binary tree stored in the array
        CALL printTreeArray()

        // Ask the user to enter a node to find its parent
        DECLARE continueSearch as 'y'
        WHILE continueSearch equals 'y':
            PRINT "Enter a node to find its parent:"
            INPUT node
            CALL findParent(node)

            PRINT "More nodes to search? (y/n):"
            INPUT continueSearch
    END FUNCTION

END

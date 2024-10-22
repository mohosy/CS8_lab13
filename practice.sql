START

  // Define a structure for representing a node in a binary tree
  DEFINE STRUCTURE Node with:
      - data: a character to store the node's value (like 'A', 'B', etc.)
      - left: a pointer to the left child (initially this will be null)
      - right: a pointer to the right child (initially this will be null)

  // This function creates a new node when a value is passed to it
  FUNCTION Node(value):
      SET data = value        // Assign the passed character to the node's data
      SET left = null         // Initially, the node has no left child
      SET right = null        // Initially, the node has no right child
  END FUNCTION

  // Function to perform in-order traversal of the binary tree
  // In-order means visiting the left subtree first, then the root node, and finally the right subtree
  FUNCTION inorderTraversal(root):
      IF root is not null:                 // If the current node exists (is not null)
          CALL inorderTraversal(root.left) // Recursively visit the left subtree
          PRINT root.data                  // After visiting the left, print the current node's value
          CALL inorderTraversal(root.right)// Recursively visit the right subtree
      END IF
  END FUNCTION

  // Function to perform pre-order traversal of the binary tree
  // Pre-order means visiting the root node first, then the left subtree, and finally the right subtree
  FUNCTION preorderTraversal(root):
      IF root is not null:                 // If the current node exists (is not null)
          PRINT root.data                  // First, print the current node's value
          CALL preorderTraversal(root.left)// Then, recursively visit the left subtree
          CALL preorderTraversal(root.right)// Finally, recursively visit the right subtree
      END IF
  END FUNCTION

  // Function to perform post-order traversal of the binary tree
  // Post-order means visiting the left subtree first, then the right subtree, and finally the root node
  FUNCTION postorderTraversal(root):
      IF root is not null:                 // If the current node exists (is not null)
          CALL postorderTraversal(root.left)// Recursively visit the left subtree
          CALL postorderTraversal(root.right)// Recursively visit the right subtree
          PRINT root.data                  // After both subtrees are visited, print the current node's value
      END IF
  END FUNCTION

  // Function to build a binary tree from a queue of input characters
  // The queue will contain characters to be inserted into the tree, with '-' representing no node
  FUNCTION buildTreeFromQueue(inputQueue):
      IF inputQueue is empty:              // If there are no more elements in the queue
          RETURN null                      // Return an empty tree (no nodes)

      // Create the root node using the first character in the queue
      SET root = CREATE new Node(inputQueue.front) // The first character becomes the root node
      REMOVE the first element from inputQueue      // Remove that character from the queue

      // We need a queue to keep track of nodes that still need children
      INITIALIZE nodeQueue as empty                // A queue to manage nodes level by level
      ADD root to nodeQueue                        // Add the root to the node queue

      // Continue building the tree as long as there are more elements in inputQueue
      WHILE inputQueue is not empty:
          // Get the next node from the nodeQueue (this is the parent node)
          SET currentNode = nodeQueue.front        // The parent node to add children to
          REMOVE the first node from nodeQueue     // Remove the parent from the node queue

          // Process the left child of currentNode
          IF inputQueue is not empty:
              SET leftValue = inputQueue.front     // Get the next character from inputQueue
              REMOVE the first element from inputQueue
              IF leftValue is not '-':             // If the left value is not a dash (meaning it’s a valid node)
                  SET currentNode.left = CREATE new Node(leftValue) // Create a left child
                  ADD currentNode.left to nodeQueue // Add this new left child to the node queue

          // Process the right child of currentNode
          IF inputQueue is not empty:
              SET rightValue = inputQueue.front    // Get the next character from inputQueue
              REMOVE the first element from inputQueue
              IF rightValue is not '-':            // If the right value is not a dash (meaning it’s a valid node)
                  SET currentNode.right = CREATE new Node(rightValue) // Create a right child
                  ADD currentNode.right to nodeQueue // Add this new right child to the node queue

      // Once the entire tree is built, return the root node
      RETURN root
  END FUNCTION

  // Main function to handle user input, file reading, tree building, and traversals
  MAIN FUNCTION:
      PRINT "Enter the input file name: "  // Ask the user to provide the name of the input file
      INPUT filename                      // Store the provided filename

      // Try to open the input file using the provided filename
      OPEN inputFile using filename
      IF inputFile cannot be opened:       // If the file cannot be opened (perhaps it doesn't exist)
          PRINT "Error: Could not open file." // Inform the user of the error
          EXIT program                      // Stop the program

      // Initialize an empty queue to store the input characters
      INITIALIZE inputQueue as empty

      // Read characters from the input file, one by one
      WHILE there are characters left in inputFile:
          READ character from inputFile    // Read the next character
          ADD character to inputQueue      // Add the character to the queue

      CLOSE inputFile                      // Close the file after reading all characters

      // Build the binary tree using the characters in inputQueue
      SET root = CALL buildTreeFromQueue(inputQueue)

      // If the tree is empty (no nodes were added), inform the user and exit
      IF root is null:
          PRINT "The tree is empty."       // Let the user know the tree couldn't be built
          EXIT program

      // Perform an in-order traversal of the binary tree
      PRINT "In-order traversal: "
      CALL inorderTraversal(root)          // Visit nodes in the left-root-right order
      PRINT a newline                      // Move to the next line after traversal

      // Perform a pre-order traversal of the binary tree
      PRINT "Pre-order traversal: "
      CALL preorderTraversal(root)         // Visit nodes in the root-left-right order
      PRINT a newline

      // Perform a post-order traversal of the binary tree
      PRINT "Post-order traversal: "
      CALL postorderTraversal(root)        // Visit nodes in the left-right-root order
      PRINT a newline

  END FUNCTION

END

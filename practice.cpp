#include <iostream>
#include <fstream>  // For file handling
#include <queue>    // For building the binary tree level-wise
using namespace std;

//cange this code so that instead of putting it in a queue, put it in a linked list and then make the tree
const int MAX = 100; 
// Define the structure for a binary tree node
struct Node {
    char data;
    Node* left;
    Node* right;

    // Constructor to create a new node
    Node(char value) {
        data = value;
        left = nullptr;
        right = nullptr;
    }
};

// In-order traversal (Left, Root, Right)
void inorder(Node* root) {
    if (root != nullptr) {
        inorder(root->left);  // Visit left subtree
        cout << root->data << " ";  // Visit node
        inorder(root->right);  // Visit right subtree
    }
}

// Pre-order traversal (Root, Left, Right)
void preorder(Node* root) {
    if (root != nullptr) {
        cout << root->data << " ";  // Visit node
        preorder(root->left);  // Visit left subtree
        preorder(root->right);  // Visit right subtree
    }
}

// Post-order traversal (Left, Right, Root)
void postorder(Node* root) {
    if (root != nullptr) {
        postorder(root->left);  // Visit left subtree
        postorder(root->right);  // Visit right subtree
        cout << root->data << " ";  // Visit node
    }
}

// Function to build the tree from a list of characters
Node* buildTreeFromInput(queue<char>& inputQueue) {
    if (inputQueue.empty()) return nullptr;

    Node* root = new Node(inputQueue.front());
    inputQueue.pop();
    queue<Node*> nodeQueue;
    nodeQueue.push(root);

    while (!inputQueue.empty()) {
        Node* currentNode = nodeQueue.front();
        nodeQueue.pop();

        // Add left child
        if (!inputQueue.empty()) {
            char leftData = inputQueue.front();
            inputQueue.pop();
            if (leftData != '-') {  // Use '-' to represent no node
                currentNode->left = new Node(leftData);
                nodeQueue.push(currentNode->left);
            }
        }

        // Add right child
        if (!inputQueue.empty()) {
            char rightData = inputQueue.front();
            inputQueue.pop();
            if (rightData != '-') {  // Use '-' to represent no node
                currentNode->right = new Node(rightData);
                nodeQueue.push(currentNode->right);
            }
        }
    }

    return root;
}

int main() {
    string filename;
    cout << "Enter the input file name: ";
    cin >> filename;

    ifstream inputFile(filename);
    if (!inputFile) {
        cerr << "Error opening file!" << endl;
        return 1;
    }

    // Read characters from file and add them to a queue
    queue<char> inputQueue;
    char ch;
    while (inputFile >> ch) {
        inputQueue.push(ch);
    }

    inputFile.close();

    // Build the binary tree from the input
    Node* root = buildTreeFromInput(inputQueue);

    if (root == nullptr) {
        cout << "Tree is empty!" << endl;
        return 1;
    }

    // Perform in-order traversal
    cout << "In-order traversal: ";
    inorder(root);
    cout << endl;

    // Perform pre-order traversal
    cout << "Pre-order traversal: ";
    preorder(root);
    cout << endl;

    // Perform post-order traversal
    cout << "Post-order traversal: ";
    postorder(root);
    cout << endl;

    return 0;
}

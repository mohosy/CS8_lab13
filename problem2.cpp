#include <iostream>
#include <fstream>
#include <string>
using namespace std;

struct TreeNode {
    char data;
    TreeNode* left;
    TreeNode* right;
    TreeNode(char value) : data(value), left(nullptr), right(nullptr) {}
};

TreeNode* findNode(TreeNode* root, char value) {
    if (!root || root->data == value)
        return root;
    
    TreeNode* leftResult = findNode(root->left, value);
    if (leftResult)
        return leftResult;

    return findNode(root->right, value);
}

TreeNode* buildTreeFromFile(string filename) {
    ifstream file(filename);
    if (!file) {
        cerr << "Error opening file!" << endl;
        return nullptr;
    }

    TreeNode* root = nullptr;
    char parent, leftChild, rightChild;

    while (file >> parent >> leftChild >> rightChild) {
        if (!root) {
            root = new TreeNode(parent); 
        }

        TreeNode* parentNode = findNode(root, parent);

        if (leftChild != 'Z') {
            parentNode->left = new TreeNode(leftChild);
        }

        if (rightChild != 'Z') {
            parentNode->right = new TreeNode(rightChild);
        }
    }

    file.close();
    return root;
}

void preOrder(TreeNode* root) {
    if (root) {
        cout << root->data << " ";
        preOrder(root->left);
        preOrder(root->right);
    }
}

void inOrder(TreeNode* root) {
    if (root) {
        inOrder(root->left);
        cout << root->data << " ";
        inOrder(root->right);
    }
}

void postOrder(TreeNode* root) {
    if (root) {
        postOrder(root->left);
        postOrder(root->right);
        cout << root->data << " ";
    }
}



int main() {
    string filename;
    cout << "Enter the input file name: ";
    cin >> filename;

    TreeNode* root = buildTreeFromFile(filename);

    if (root) {
        cout << "< Pre-order traversal >" << endl; 
        preOrder(root);
        cout << endl;

        cout << "< In-order traversal >" << endl; 
        inOrder(root);
        cout << endl;

        cout << "< Post-order traversal >" << endl; 
        postOrder(root);
        cout << endl;


    return 0;
}   
}   

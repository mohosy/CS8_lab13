#include <iostream>
#include <fstream>
#include <string>
#include <iomanip> 
using namespace std;

const int MAX = 100;  
int nodeCount = 0; 
char tree[MAX];      

int findNodeIndex(char node) {
    for (int i = 0; i < MAX; i++) {
        if (tree[i] == node) {
            return i;
        }
    }
    return -1;  
}

void buildTreeFromFile(string filename) {
    ifstream file(filename);
    if (!file) {
        cerr << "Error opening file!" << endl;
        return;
    }

    for (int i = 0; i < MAX; i++) {
        tree[i] = '-';  
    }

    char parent, leftChild, rightChild;
    
    while (file >> parent >> leftChild >> rightChild) {
        int pIndex = findNodeIndex(parent);

        if (pIndex == -1) {
            for (int i = 0; i < MAX; i++) {
                if (tree[i] == '-') {
                    tree[i] = parent;
                    pIndex = i;
                    nodeCount++; 
                    break;
                }
            }
        }

        if (leftChild != 'Z') {  
            tree[2 * pIndex + 1] = leftChild;
        }

        if (rightChild != 'Z') { 
            tree[2 * pIndex + 2] = rightChild;
        }
        nodeCount++;  
    }

    file.close();
}

void printTreeArray() {
    cout << "< binary tree in array" << endl;
    for (int i = 0; i < MAX; i++) {
        if (tree[i] != '-') {
            cout << setw(2) << i << " | " << tree[i] << endl;
        } else if (tree[i] == '-' && i <= 2 * nodeCount){ 
            cout << setw(2) << i << " | " << endl; 
        }
    }
}

void findParent(char node) {
    int nodeIndex = findNodeIndex(node);

    if (nodeIndex == -1) {
        cout << node << " not found in the tree." << endl;
        return;
    }

    if (nodeIndex == 0) {
        cout << node << " is the root of the tree." << endl;
        return;
    }

    int parentIndex = (nodeIndex - 1) / 2;
    cout << "The parent of " << node << " is " << tree[parentIndex] << endl;
}

int main() {
    string filename; 
    cout << "Enter the input file name: "; 
    cin >> filename; 
    
    buildTreeFromFile(filename); 

    printTreeArray();              

    char node;
    char response; 
    do{ 
        cout << "Enter a node to find its parent: ";
        cin >> node;
        findParent(node);

        cout << "Again? (y/n): "; 
        cin >> response; 
    } while(response != 'n' || response != 'N'); 

    return 0;
}

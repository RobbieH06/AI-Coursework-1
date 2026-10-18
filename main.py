import sys

#Creates a dictionary of peers for each cell
def cellPeers(): 
    peers = {}

    for row in range(9):
        for col in range(9):
            cell = (row, col)
            rowPeers = [(row,c) for c in range(9) if c != col]
            colPeers = [(r,col) for r in range(9) if r != row]
            boxPeers = [(r,c) for r in range(row//3*3, row//3*3+3) for c in range(col//3*3, col//3*3+3) if (r,c) != cell]
            peers[cell] = set(rowPeers + colPeers + boxPeers)
    return peers

Peers = cellPeers()

#Loads Sudoku puzzle from a txt file
def loadPuzzle(directory):
    puzzle = []
    try:
        with open(directory, 'r') as sudoku:
            for line in sudoku:
                line = line.strip()
                if len(line) != 9 or not all(c in '0123456789' for c in line):
                    raise ValueError("Invalid puzzle format")
                puzzle.append([int(cell) for cell in line])

    except FileNotFoundError:
        print(f"Error: File '{directory}' not found.")
        sys.exit(1)

    return puzzle

        
        

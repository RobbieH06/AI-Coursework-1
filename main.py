

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

def loadPuzzle()
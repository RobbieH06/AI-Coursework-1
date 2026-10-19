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
                line = line.split()
                if len(line) != 9 or not all(c in '0123456789' for c in line):
                    raise ValueError("Invalid puzzle format")
                puzzle.append([int(cell) for cell in line])

    except FileNotFoundError:
        print(f"Error: File '{directory}' not found.")
        sys.exit(1)

    return puzzle

#Assigns a number to a cell and update the peers' domains
def assignNum(domains, cell, assigned, num):
    domains[cell] = {num}
    assigned.add(cell)
    for peer in Peers[cell]:
        if num in domains[peer]:
            domains[peer].remove(num)
            if not domains[peer]:
                return False
    return True

#Parses the grid and initializes the domains and assigned cells
def parse(grid):
    domains = {(row, col): set(range(1, 10)) for row in range(9) for col in range(9)}
    assigned = set()
    for i in range(9):
        for j in range(9):
            if grid[i][j] != 0:
                if not assignNum(domains, (i, j), assigned, grid[i][j]):
                    return None, None
    return domains, assigned

#Solves the sudoku using backtracking and MRV heuristic
def solve(domains, assigned, stats, useMRV=True):
    if len(assigned) == 81:
        return domains

    unassigned = [cell for cell in domains if cell not in assigned]

    if useMRV:
        cell = min(unassigned, key=lambda x: len(domains[x]))
    else:
        cell = unassigned[0]

    for num in sorted(domains[cell]):
        stats['attempts'] += 1
        newDomains = {c: set(domains[c]) for c in domains}
        newAssigned = set(assigned)
        if assignNum(newDomains, cell, newAssigned, num):
            result = solve(newDomains, newAssigned, stats, useMRV)
            if result:
                return result

    return None

#Solves the sudoku and returns the solved sudoku with the number of attempts taken
def solveSudoku(grid, useMRV=True):
    domains, assigned = parse(grid)
    stats = {'attempts': 0}
    if domains is None:
        return None, stats

    return solve(domains, assigned, stats, useMRV), stats

#Shows the solved sudoku in a reable format
def showPuzzle(domains):
    for row in range(9):
        print(" ".join(str(next(iter(domains[(row, col)]))) for col in range(9)))


#Loads the sudoku puzzle from a file, solves it and shows the solution with thye number of attempts
def main():
    if len(sys.argv) != 2:
        print("Usage: python main.py <puzzle_file>")
        sys.exit(1)

    puzzle_file = sys.argv[1]
    grid = loadPuzzle(puzzle_file)
    solution, stats = solveSudoku(grid, useMRV=True)

    if solution:
        print("Solved Sudoku Puzzle:")
        showPuzzle(solution)
        print(f"Number of attempts: {stats['attempts']}")
    else:
        print("No solution found.")

#Runs the program
if __name__ == "__main__":
    main()
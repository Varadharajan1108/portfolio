class State:
    def __init__(self, board, queens):
        self.board = board
        self.queens = queens

    def is_valid(self):
        # Check if the queens are in non-attacking positions
        for i in range(self.queens):
            for j in range(i + 1, self.queens):
                if (
                    self.board[i] == self.board[j]
                    or abs(self.board[i] - self.board[j]) == j - i
                ):
                    return False
        return True


def solve_n_queens_bfs(n):
    initial_state = State([-1] * n, 0)
    queue = [initial_state]
    visited_states = set()
    visited_states.add(tuple(initial_state.board))

    while queue:
        current_state = queue.pop(0)

        if current_state.queens == n:
            # Found a solution
            print(current_state.board)
            return

        for i in range(n):
            next_board = current_state.board[:]
            next_board[current_state.queens] = i
            next_queens = current_state.queens + 1
            next_state = State(next_board, next_queens)

            if next_state.is_valid() and tuple(next_state.board) not in visited_states:
                queue.append(next_state)
                visited_states.add(tuple(next_state.board))
                print(next_state.board)


# Solve the 4-queens problem
solve_n_queens_bfs(4)
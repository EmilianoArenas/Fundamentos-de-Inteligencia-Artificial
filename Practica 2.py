import copy
import tkinter as tk
from tkinter import messagebox
from PIL import Image, ImageTk
import time
from collections import deque

# Clase para manejar el estado del tablero
class State:
    def __init__(self, board, movement='n', parent=None):
        self.board = copy.deepcopy(board)
        self.movement = movement
        self.parent = parent
        self.posI, self.posJ = self.find_empty_tile()

    def find_empty_tile(self):
        for i in range(4):
            for j in range(4):
                if self.board[i][j] == 0:
                    return i, j

    def get_neighbors(self):
        neighbors = []
        moves = {'u': (-1, 0), 'd': (1, 0), 'l': (0, -1), 'r': (0, 1)}
        for move, (di, dj) in moves.items():
            ni, nj = self.posI + di, self.posJ + dj
            if 0 <= ni < 4 and 0 <= nj < 4:
                new_board = copy.deepcopy(self.board)
                new_board[self.posI][self.posJ], new_board[ni][nj] = new_board[ni][nj], new_board[self.posI][self.posJ]
                neighbors.append(State(new_board, movement=move, parent=self))
        return neighbors

    def is_goal(self, goal):
        return self.board == goal

    def is_equal(self, other):
        return self.board == other.board

    def path_from_root(self):
        path = []
        current = self
        while current.parent is not None:
            path.append(current.movement)
            current = current.parent
        return path[::-1]  # Invertir la lista para mostrar el camino correcto

# Clase para manejar la interfaz gráfica del puzzle
class PuzzleApp(tk.Tk):
    def __init__(self, start_board, goal_board, img_path):
        super().__init__()
        self.start_board = start_board
        self.goal_board = goal_board
        self.tiles = {}  # Mapa de piezas y sus imágenes
        self.empty_tile = None
        self.buttons = [[None for _ in range(4)] for _ in range(4)]
        self.path = ""
        self.init_images(img_path)
        self.create_board()
        self.create_buttons()

    def init_images(self, img_path):
        full_image = Image.open(img_path)
        for i in range(4):
            for j in range(4):
                if i == 3 and j == 3:
                    self.empty_tile = Image.new('RGB', (125, 125), color='white')
                else:
                    tile = full_image.crop((j * 125, i * 125, (j + 1) * 125, (i + 1) * 125))
                    self.tiles[i * 4 + j + 1] = ImageTk.PhotoImage(tile)
        self.empty_tile = ImageTk.PhotoImage(self.empty_tile)

    def create_board(self):
        for i in range(4):
            for j in range(4):
                value = self.start_board[i][j]
                button = tk.Button(self, image=self.empty_tile if value == 0 else self.tiles[value], width=125, height=125)
                button.grid(row=i, column=j)
                self.buttons[i][j] = button
        self.update()

    def create_buttons(self):
        # Crear los botones para resolver con BFS y DFS
        bfs_button = tk.Button(self, text="Solve BFS", command=self.solve_bfs, bg="lightblue", width=10)
        bfs_button.grid(row=4, column=0, columnspan=2)

        dfs_button = tk.Button(self, text="Solve DFS", command=self.solve_dfs, bg="lightgreen", width=10)
        dfs_button.grid(row=4, column=2, columnspan=2)

    def update_board(self, state):
        for i in range(4):
            for j in range(4):
                value = state.board[i][j]
                self.buttons[i][j].config(image=self.empty_tile if value == 0 else self.tiles[value])
        self.update()

    def solve_bfs(self):
        self.path = ""
        initial_state = State(self.start_board)
        goal_state = State(self.goal_board)
        queue = deque([initial_state])
        visited = []

        total_nodes = 0
        total_iterations = 0
        start_time = time.time()  # Iniciar tiempo de ejecución

        while queue:
            current_state = queue.popleft()
            total_iterations += 1

            if current_state.is_goal(goal_state.board):
                self.path = current_state.path_from_root()
                elapsed_time = time.time() - start_time  # Finalizar tiempo de ejecución
                self.show_results(elapsed_time, total_nodes, total_iterations)
                self.animate_solution(self.path)
                return

            visited.append(current_state)
            for neighbor in current_state.get_neighbors():
                total_nodes += 1
                if not any(neighbor.is_equal(state) for state in visited):
                    queue.append(neighbor)

        messagebox.showinfo("Puzzle", "Solution not found!")

    def solve_dfs(self):
        self.path = ""
        initial_state = State(self.start_board)
        goal_state = State(self.goal_board)
        stack = [initial_state]
        visited = []

        total_nodes = 0
        total_iterations = 0
        start_time = time.time()  # Iniciar tiempo de ejecución

        while stack:
            current_state = stack.pop()
            total_iterations += 1

            if current_state.is_goal(goal_state.board):
                self.path = current_state.path_from_root()
                elapsed_time = time.time() - start_time  # Finalizar tiempo de ejecución
                self.show_results(elapsed_time, total_nodes, total_iterations)
                self.animate_solution(self.path)
                return

            visited.append(current_state)
            for neighbor in current_state.get_neighbors():
                total_nodes += 1
                if not any(neighbor.is_equal(state) for state in visited):
                    stack.append(neighbor)

        messagebox.showinfo("Puzzle", "Solution not found!")

    def animate_solution(self, path):
        moves = {'u': (-1, 0), 'd': (1, 0), 'l': (0, -1), 'r': (0, 1)}
        for move in path:
            self.update()
            i, j = self.find_empty_tile()
            di, dj = moves[move]
            ni, nj = i + di, j + dj
            self.start_board[i][j], self.start_board[ni][nj] = self.start_board[ni][nj], self.start_board[i][j]
            self.update_board(State(self.start_board))
            time.sleep(0.5)

    def find_empty_tile(self):
        for i in range(4):
            for j in range(4):
                if self.start_board[i][j] == 0:
                    return i, j
        return None

    def show_results(self, elapsed_time, total_nodes, total_iterations):
        messagebox.showinfo(
            "Resultados",
            f"Tiempo de ejecución: {elapsed_time:.2f} segundos\n"
            f"Nodos generados: {total_nodes}\n"
            f"Iteraciones totales: {total_iterations}"
        )

# Estado inicial y meta
start = [[2, 3, 0, 4], [1, 6, 7, 8], [5, 10, 15, 11], [9, 13, 14, 12]]
goal = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 0]]

# Crear la app
app = PuzzleApp(start, goal, "tiger1.jpg")
app.title("15-Puzzle Solver")
app.geometry("500x550")
app.mainloop()

import random

# Показываем доску
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
print(board[0] + " | " + board[1] + " | " + board[2])
print("--+---+--")
print(board[3] + " | " + board[4] + " | " + board[5])
print("--+---+--")
print(board[6] + " | " + board[7] + " | " + board[8])

# Проверка на победу
def check_if_win():
    if board[0] == board[1] == board[2] != " ":
        return board[0]
    if board[3] == board[4] == board[5] != " ":
        return board[3]
    if board[6] == board[7] == board[8] != " ":
        return board[6]
    if board[0] == board[3] == board[6] != " ":
        return board[0]
    if board[1] == board[4] == board[7] != " ":
        return board[1]
    if board[2] == board[5] == board[8] != " ":
        return board[2]
    if board[0] == board[4] == board[8] != " ":
        return board[0]
    if board[2] == board[4] == board[6] != " ":
        return board[2]
    if " " not in board:
        return "Tie"
    return False

# Минимакс для бота
def minimax(is_max):
    result = check_if_win()
    if result == bot:
        return 10
    if result == user:
        return -10
    if result == "Tie":
        return 0

    if is_max:
        best = -100
        for i in range(9):
            if board[i] == " ":
                board[i] = bot
                score = minimax(False)
                board[i] = " "
                if score > best:
                    best = score
        return best
    else:
        best = 100
        for i in range(9):
            if board[i] == " ":
                board[i] = user
                score = minimax(True)
                board[i] = " "
                if score < best:
                    best = score
        return best

# Ход бота
def bot_move():
    best_score = -100
    move = 0
    for i in range(9):
        if board[i] == " ":
            board[i] = bot
            score = minimax(False)
            board[i] = " "
            if score > best_score:
                best_score = score
                move = i
    return move

# Выбираем, кто за что играет
colors = ["X", "O"]
user = random.choice(colors)
if user == "X":
    bot = "O"
else:
    bot = "X"

print("Ты играешь за " + user + ", бот за " + bot + "!")

# Кто ходит первым
if random.randint(0, 1) == 0:
    print("Ты ходишь первым!")
    turn = "user"
else:
    print("Бот ходит первым!")
    turn = "bot"

# Основной цикл игры
if turn == "bot":
    board[bot_move()] = bot
    print(board[0] + " | " + board[1] + " | " + board[2])
    print("--+---+--")
    print(board[3] + " | " + board[4] + " | " + board[5])
    print("--+---+--")
    print(board[6] + " | " + board[7] + " | " + board[8])

while True:
    if turn == "user":
        move = int(input("Твой ход (1-9): ")) - 1
        if board[move] != " ":
            print("Там уже занято, попробуй ещё раз!")
            continue
        board[move] = user
        print(board[0] + " | " + board[1] + " | " + board[2])
        print("--+---+--")
        print(board[3] + " | " + board[4] + " | " + board[5])
        print("--+---+--")
        print(board[6] + " | " + board[7] + " | " + board[8])
        
        result = check_if_win()
        if result:
            if result == user:
                print("Ты победил!")
            elif result == bot:
                print("Бот победил!")
            else:
                print("Ничья!")
            break
        
        turn = "bot"
    
    if turn == "bot":
        board[bot_move()] = bot
        print(board[0] + " | " + board[1] + " | " + board[2])
        print("--+---+--")
        print(board[3] + " | " + board[4] + " | " + board[5])
        print("--+---+--")
        print(board[6] + " | " + board[7] + " | " + board[8])
        
        result = check_if_win()
        if result:
            if result == user:
                print("Ты победил!")
            elif result == bot:
                print("Бот победил!")
            else:
                print("Ничья!")
            break
        
        turn = "user"
import tkinter as tk
from tkinter import messagebox
import psycopg2

# Параметри підключення до бази даних
DB_PARAMS = {
    "dbname": "your_database",
    "user": "your_user",
    "password": "your_password",
    "host": "your_host",
    "port": "your_port"  # Зазвичай 5432
}


# Функція для запису даних у базу
def save_to_db():
    surname = entry_surname.get()
    name = entry_name.get()
    mental_state = entry_mental.get()

    if not surname or not name or not mental_state.isdigit():
        messagebox.showerror("Помилка", "Будь ласка, введіть коректні дані")
        return

    mental_state = int(mental_state)
    if not (1 <= mental_state <= 10):
        messagebox.showerror("Помилка", "Оцінка ментального стану має бути від 1 до 10")
        return

    try:
        connection = psycopg2.connect(**DB_PARAMS)
        cursor = connection.cursor()

        # Створення таблиці, якщо її немає
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS survey (
                id SERIAL PRIMARY KEY,
                surname VARCHAR(50),
                name VARCHAR(50),
                mental_state INTEGER
            )
        """)

        # Вставка даних
        cursor.execute("INSERT INTO survey (surname, name, mental_state) VALUES (%s, %s, %s)",
                       (surname, name, mental_state))
        connection.commit()

        messagebox.showinfo("Успіх", "Дані збережено!")

    except psycopg2.DatabaseError as e:
        messagebox.showerror("Помилка бази даних", str(e))
    finally:
        cursor.close()
        connection.close()


# Графічний інтерфейс
root = tk.Tk()
root.title("Опитувальник")

tk.Label(root, text="Прізвище:").pack()
entry_surname = tk.Entry(root)
entry_surname.pack()

tk.Label(root, text="Ім'я:").pack()
entry_name = tk.Entry(root)
entry_name.pack()

tk.Label(root, text="Оцініть ваш ментальний стан (1-10):").pack()
entry_mental = tk.Entry(root)
entry_mental.pack()

tk.Button(root, text="Зберегти", command=save_to_db).pack()

root.mainloop()
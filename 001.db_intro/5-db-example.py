import psycopg2

# Підключення до бази (припустимо, ви створили БД school)
conn = psycopg2.connect(
    dbname="school",
    user="postgres",
    password="your_password",
    host="localhost",
    port="5432"
)
cur = conn.cursor()

# 1. Створення таблиці (один раз)
cur.execute("""
CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    name TEXT,
    grade INT
)
""")
conn.commit()

# 2. Додавання даних
cur.execute("INSERT INTO students (name, grade) VALUES (%s, %s)", ("Alice", 90))
cur.execute("INSERT INTO students (name, grade) VALUES (%s, %s)", ("Bob", 75))
conn.commit()

# 3. Пошук (ось тут магія SQL!)
cur.execute("SELECT * FROM students WHERE name = %s", ("Bob",))
print("Знайдено:", cur.fetchone())

# 4. Оновлення
cur.execute("UPDATE students SET grade = %s WHERE name = %s", (95, "Bob"))
conn.commit()

# 5. Видалення
cur.execute("DELETE FROM students WHERE name = %s", ("Alice",))
conn.commit()

cur.close()
conn.close()

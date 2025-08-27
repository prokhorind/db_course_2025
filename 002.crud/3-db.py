import psycopg2

def connect():
    return psycopg2.connect(
        dbname="school",
        user="postgres",
        password="your_password",  # замініть на свій пароль
        host="localhost",
        port="5432"
    )

# ---------- CRUD ----------
def add_student():
    conn = connect()
    cur = conn.cursor()
    name = input("Введіть ім'я студента: ")
    grade = int(input("Введіть оцінку: "))
    cur.execute("INSERT INTO students (name, grade) VALUES (%s, %s)", (name, grade))
    conn.commit()
    cur.close()
    conn.close()
    print("✅ Студента додано!")

def show_students():
    conn = connect()
    cur = conn.cursor()
    cur.execute("SELECT * FROM students")
    rows = cur.fetchall()
    if not rows:
        print("❌ Немає студентів")
    else:
        for row in rows:
            print(row)
    cur.close()
    conn.close()

def update_student():
    conn = connect()
    cur = conn.cursor()
    student_id = int(input("Введіть ID студента для оновлення: "))
    new_grade = int(input("Нова оцінка: "))
    cur.execute("UPDATE students SET grade = %s WHERE id = %s", (new_grade, student_id))
    conn.commit()
    cur.close()
    conn.close()
    print("✅ Дані оновлено!")

def delete_student():
    conn = connect()
    cur = conn.cursor()
    student_id = int(input("Введіть ID студента для видалення: "))
    cur.execute("DELETE FROM students WHERE id = %s", (student_id,))
    conn.commit()
    cur.close()
    conn.close()
    print("✅ Студента видалено!")

# ---------- Меню ----------
def menu():
    while True:
        print("\n--- Меню (POSTGRESQL) ---")
        print("1. Додати студента")
        print("2. Показати всіх студентів")
        print("3. Оновити оцінку")
        print("4. Видалити студента")
        print("0. Вийти")

        choice = input("Ваш вибір: ")

        if choice == "1":
            add_student()
        elif choice == "2":
            show_students()
        elif choice == "3":
            update_student()
        elif choice == "4":
            delete_student()
        elif choice == "0":
            break
        else:
            print("❌ Невірний вибір!")

menu()

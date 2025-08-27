import json
import os

FILENAME = "students.json"

# ---------- Функції для роботи з файлом ----------
def load_students():
    if not os.path.exists(FILENAME):
        return []
    with open(FILENAME, "r") as f:
        return json.load(f)

def save_students(students):
    with open(FILENAME, "w") as f:
        json.dump(students, f, indent=4)

# ---------- CRUD ----------
def add_student():
    students = load_students()
    new_id = len(students) + 1
    name = input("Введіть ім'я студента: ")
    grade = int(input("Введіть оцінку: "))
    students.append({"id": new_id, "name": name, "grade": grade})
    save_students(students)
    print("✅ Студента додано!")

def show_students():
    students = load_students()
    if not students:
        print("❌ Немає студентів")
    else:
        for s in students:
            print(s)

def update_student():
    students = load_students()
    student_id = int(input("Введіть ID студента для оновлення: "))
    new_grade = int(input("Нова оцінка: "))
    for s in students:
        if s["id"] == student_id:
            s["grade"] = new_grade
    save_students(students)
    print("✅ Дані оновлено!")

def delete_student():
    students = load_students()
    student_id = int(input("Введіть ID студента для видалення: "))
    students = [s for s in students if s["id"] != student_id]
    save_students(students)
    print("✅ Студента видалено!")


# ---------- Меню ----------
def menu():
    while True:
        print("\n--- Меню (ФАЙЛ) ---")
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

# ---------- Оперативна пам'ять ----------
students = []

# ---------- CRUD ----------
def add_student():
    new_id = len(students) + 1
    name = input("Введіть ім'я студента: ")
    grade = int(input("Введіть оцінку: "))
    students.append({"id": new_id, "name": name, "grade": grade})
    print("✅ Студента додано!")

def show_students():
    if not students:
        print("❌ Немає студентів")
    else:
        for s in students:
            print(s)

def update_student():
    student_id = int(input("Введіть ID студента для оновлення: "))
    new_grade = int(input("Нова оцінка: "))
    for s in students:
        if s["id"] == student_id:
            s["grade"] = new_grade
            print("✅ Дані оновлено!")
            return
    print("❌ Студента з таким ID не знайдено")

def delete_student():
    student_id = int(input("Введіть ID студента для видалення: "))
    global students
    if any(s["id"] == student_id for s in students):
        students = [s for s in students if s["id"] != student_id]
        print("✅ Студента видалено!")
    else:
        print("❌ Студента з таким ID не знайдено")


# ---------- Меню ----------
def menu():
    while True:
        print("\n--- Меню (ОПЕРАТИВНА ПАМ'ЯТЬ) ---")
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

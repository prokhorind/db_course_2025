
# Урок: CRUD операції в Python

Цей урок демонструє, як працювати зі студентами за допомогою CRUD операцій (Create, Read, Update, Delete) у трьох різних підходах:

1. **Зберігання в оперативній пам'яті**
2. **Зберігання у файлі (JSON)**
3. **Зберігання у PostgreSQL**

---

## 1. CRUD в оперативній пам’яті

Дані зберігаються лише під час роботи програми у змінній `students`.

**Переваги:**
- Швидка робота
- Простота реалізації

**Недоліки:**
- Дані зникають після закриття програми

**Код прикладу:**  
```python
students = []

def add_student():
    new_id = len(students) + 1
    name = input("Введіть ім'я студента: ")
    grade = int(input("Введіть оцінку: "))
    students.append({"id": new_id, "name": name, "grade": grade})
    print("✅ Студента додано!")
```

---

## 2. CRUD з файлом (JSON)

Дані зберігаються у файлі `students.json`, що дозволяє зберегти інформацію між запусками.

**Переваги:**
- Дані зберігаються після завершення програми
- Простота реалізації

**Недоліки:**
- Може сповільнюватися при великій кількості записів
- Менш надійно для великих проектів

**Код прикладу:**  
```python
import json
import os

FILENAME = "students.json"

def load_students():
    if not os.path.exists(FILENAME):
        return []
    with open(FILENAME, "r") as f:
        return json.load(f)

def save_students(students):
    with open(FILENAME, "w") as f:
        json.dump(students, f, indent=4)
```

---

## 3. CRUD у PostgreSQL

Дані зберігаються у реляційній базі даних PostgreSQL. Для цього використовується бібліотека `psycopg2`.

**Переваги:**
- Надійне зберігання великих обсягів даних
- Можливість складних запитів і фільтрів

**Недоліки:**
- Потрібна установка бази даних
- Складніша реалізація для початківців

**Приклад коду:**  
```python
import psycopg2

conn = psycopg2.connect(
    dbname="your_db", user="user", password="password", host="localhost", port="5432"
)
cursor = conn.cursor()

def add_student():
    name = input("Введіть ім'я студента: ")
    grade = int(input("Введіть оцінку: "))
    cursor.execute("INSERT INTO students (name, grade) VALUES (%s, %s)", (name, grade))
    conn.commit()
    print("✅ Студента додано!")

cursor.close()
conn.close()
```

---

## Висновки

- **Оперативна пам’ять:** швидко та просто, але дані не зберігаються після закриття.
- **Файл JSON:** зберігає дані між запусками, простий спосіб для невеликих програм.
- **PostgreSQL:** надійне і масштабоване рішення, підходить для великих проектів.

import json

# Дані
students = [
    {"id": 1, "name": "Alice", "grade": 90},
    {"id": 2, "name": "Bob", "grade": 75}
]

# Зберегли у файл
with open("students.json", "w") as f:
    json.dump(students, f)

# Завантажили з файлу
with open("students.json", "r") as f:
    loaded_students = json.load(f)

print("Прочитано з файлу:", loaded_students)

import json

# Завантаження даних з файлу
with open("students.json", "r") as f:
    students = json.load(f)

# Хочемо знайти студента за ім'ям
name_to_find = "Bob"

found = None
for s in students:
    if s["name"] == name_to_find:
        found = s
        break

if found:
    print("Знайдено:", found)
else:
    print("Не знайдено")

#Пошук = повний перебір
#Якщо мільйон студентів → це дуже довго
#Видалити чи змінити дані = знову перезаписувати файл
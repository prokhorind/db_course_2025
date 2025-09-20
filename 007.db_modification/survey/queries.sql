-- 1. Середнє значення ментального стану
SELECT AVG(mental_state) AS average_mental_state FROM survey;

-- 2. Топ-3 найпоширеніші оцінки ментального стану
SELECT mental_state, COUNT(*) AS count
FROM survey
GROUP BY mental_state
ORDER BY count DESC
LIMIT 3;

-- 3. Кількість респондентів з оцінкою вище середнього
SELECT COUNT(*)
FROM survey
WHERE mental_state > (SELECT AVG(mental_state) FROM survey);
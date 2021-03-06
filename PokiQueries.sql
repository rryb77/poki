-- 1. What grades are stored in the database?
SELECT * AS "Grades"
FROM Grade g;


-- 2. What emotions may be associated with a poem?
SELECT * AS "Emotions"
FROM  Emotion e;


-- 3. How many poems are in the database?
SELECT COUNT(p.id) AS "Total Poems"
FROM Poem p;


-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT DISTINCT TOP 76 a.Name
FROM Author a
ORDER BY a.Name ASC;


-- 5. Starting with the above query, add the grade of each of the authors.
SELECT DISTINCT TOP 76 a.Name, g.Name
FROM Author a
	LEFT JOIN Grade g ON a.GradeId = g.Id
ORDER BY a.Name ASC;


-- 6. Starting with the above query, add the recorded gender of each of the authors.
SELECT DISTINCT TOP 76 a.Name, g.Name, ge.Name
FROM Author a
	LEFT JOIN Grade g ON a.GradeId = g.Id
	LEFT JOIN Gender ge ON a.GenderId = ge.Id
ORDER BY a.Name ASC;


-- 7. What is the total number of words in all poems in the database?
SELECT SUM(p.WordCount) AS "Word Count"
FROM Poem p;


-- 8. Which poem has the fewest characters?
SELECT top 1 p.Title, p.CharCount
FROM Poem p
WHERE p.CharCount > 0
ORDER BY p.CharCount ASC


-- 9. How many authors are in the third grade?
SELECT COUNT(*) AS "# of 3rd Graders"
FROM Author a
	LEFT JOIN Grade g ON a.GradeId = g.Id
WHERE g.Id = 3


-- 10. How many authors are in the first, second or third grades?
SELECT COUNT(*)
FROM Author a
	LEFT JOIN Grade g ON a.GradeId = g.Id
WHERE g.Id = 3 OR g.id = 2 OR g.id = 1


-- 11. What is the total number of poems written by fourth graders?
SELECT COUNT(*)
FROM Poem p
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Grade g ON a.GradeId = g.id
WHERE g.id = 4


-- 12. How many poems are there per grade?
SELECT g.id AS "Grade #", COUNT(p.Id) AS "Poems Per Grade"
FROM Poem p
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Grade g ON a.GradeId = g.id
GROUP BY g.Id ORDER BY g.Id ASC


-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT g.id AS "Grade #", COUNT(a.Id) AS "Authors Per Grade"
FROM Author a
	LEFT JOIN Grade g ON a.GradeId = g.id
GROUP BY g.Id ORDER BY g.Id ASC


-- 14. What is the title of the poem that has the most words?
SELECT top 1 p.Title, p.WordCount
FROM Poem p
ORDER BY p.WordCount DESC


-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT top 1 COUNT(p.id) AS "Poem Count", a.Name AS "Author"
FROM Author a
	LEFT JOIN Poem p ON a.Id = p.AuthorId
GROUP BY a.Name ORDER BY COUNT(p.id) DESC


-- 16. How many poems have an emotion of sadness?
SELECT COUNT(p.id) as "Poem Count", e.Name AS "Emotion"
FROM Poem p
	LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.id
GROUP BY e.Name, e.id
HAVING e.Id = 3


-- 17. How many poems are not associated with any emotion?
SELECT COUNT(p.id) as "Poem Count"
FROM Poem p
	LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.id
GROUP BY e.Name, e.id
HAVING e.Name IS NULL


-- 18. Which emotion is associated with the least number of poems?
SELECT top 1 COUNT(p.id) as "Poem Count", e.Name AS "Emotion"
FROM Poem p
	LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.id
GROUP BY e.Name, e.id
HAVING e.Name IS NOT NULL
ORDER BY COUNT(p.id) ASC


-- 19. Which grade has the largest number of poems with an emotion of joy?
SELECT top 1 COUNT(p.id) as "Joy Poem Count", g.Name AS "Grade"
FROM Poem p
	LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Grade g ON a.GradeId = g.Id
GROUP BY e.Name, e.Id, g.Name
HAVING e.Name IS NOT NULL AND e.Id = 4
ORDER BY COUNT(p.Id) ASC


-- 20. Which gender has the least number of poems with an emotion of fear?
SELECT top 1 COUNT(p.id) as "Fear Poem Count", ge.Name AS "Gender"
FROM Poem p
	LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Gender ge ON a.GenderId = ge.Id
WHERE e.Id = 3
GROUP BY ge.Name
ORDER BY COUNT(p.Id) ASC
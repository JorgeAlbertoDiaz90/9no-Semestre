USE  moodle;

#1
SELECT count(*) FROM moodle.mdl_user;
Select * from mdl_user;
#2
Select count(*) from moodle.mdl_course;
#3
Select count(*) from moodle.mdl_course_categories;
select * from moodle.mdl_course_categories;
#4
SELECT fullname as Curso,count(*) as Cantidad FROM mdl_enrol 
INNER JOIN mdl_user_enrolments ON mdl_enrol.id = mdl_user_enrolments.enrolid 
INNER JOIN mdl_course ON mdl_enrol.courseid = mdl_course.id GROUP BY courseid;

#5
SELECT * FROM moodle.mdl_files;
SELECT * FROM moodle.mdl_resource;
SELECT * FROM moodle.mdl_context;

#6
SELECT fullname as Curso,firstname, lastname FROM `mdl_enrol` 
INNER JOIN mdl_user_enrolments ON mdl_enrol.id = mdl_user_enrolments.enrolid 
INNER JOIN mdl_course ON mdl_enrol.courseid = mdl_course.id 
INNER JOIN mdl_user ON mdl_user_enrolments.userid = mdl_course.id 
WHERE mdl_course.id = 2; -- fullname = 'Curso de Ejemplo 1';

#7
SELECT mdl_assign.name FROM mdl_assign
WHERE mdl_assign.course=2;

Select * from mdl_assign;
Select * from mdl_assign_grades;

#8
SELECT mdl_assign_grades.grade, name FROM `mdl_assign_grades` 
INNER JOIN mdl_assign ON mdl_assign.id = mdl_assign_grades.assignment 
WHERE mdl_assign.id = 1 AND mdl_assign.course = 2;

SELECT ag.grade, c.fullname AS Nombre_Curso, a.name AS Nombre_Asignacion
FROM mdl_assign_grades ag
INNER JOIN mdl_assign a ON a.id = ag.assignment
INNER JOIN mdl_course c ON c.id = a.course
WHERE a.name = 'Primera tarea' AND c.fullname = 'Curso de Ejemplo 1';


# 9
SELECT mdl_quiz.id, mdl_quiz.name FROM `mdl_quiz`
WHERE mdl_quiz.course=2;

#10
SELECT  mdl_user.firstname, mdl_user.lastname,mdl_quiz_grades.grade FROM mdl_quiz_grades
INNER JOIN mdl_user ON mdl_user.id = mdl_quiz_grades.userid
INNER JOIN mdl_quiz ON mdl_quiz.id = mdl_quiz_grades.quiz
WHERE mdl_quiz.id = 1 AND mdl_quiz.course = 2;

#11
SELECT AVG( mdl_quiz_grades.grade) AS Promedio FROM mdl_quiz_grades 
INNER JOIN mdl_quiz ON mdl_quiz_grades.quiz = mdl_quiz.id 
INNER JOIN mdl_course ON mdl_quiz.course = mdl_course.id 
INNER JOIN mdl_user ON mdl_quiz_grades.userid = mdl_user.id 
WHERE mdl_quiz.id = 1 AND mdl_course.id=2;



#Consulta 17/04/2024
#Consulta 1
SELECT COUNT(*) AS cantidad FROM mdl_user_info_data AS mi 
INNER JOIN mdl_user_info_field AS mif ON mif.id = mi.fieldid 
INNER JOIN mdl_user AS u ON u.id = mi.userid
WHERE mi.fieldid = 1 AND mi.data ="Mujer";

# Consulta 2 Forarenos
SELECT COUNT(*) AS cantidad 
FROM mdl_user_info_data AS mi1 
INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
INNER JOIN mdl_user AS u ON u.id = mi1.userid
WHERE (mi1.fieldid = 1 AND mi1.data = "Hombre") -- Condición para hombres
AND (mi2.fieldid = 2 AND mi2.data = 1); -- Condición para foráneos

#Consulta 3
SELECT COUNT(*) AS cantidad 
    FROM mdl_user_info_data AS mi1 
    INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
    INNER JOIN mdl_user AS u ON u.id = mi1.userid
    WHERE (mi1.fieldid = 1 AND mi1.data = "Mujer")
    AND (mi2.fieldid = 2 AND mi2.data = 1);
    
#Consulta 4
SELECT COUNT(*) AS cantidad 
    FROM mdl_user_info_data AS mi1 
    INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
    INNER JOIN mdl_user AS u ON u.id = mi1.userid
    WHERE (mi1.fieldid = 1 AND mi1.data = "No binario")
    AND (mi2.fieldid = 2 AND mi2.data = 1);

SELECT u.firstname, u.lastname, c.fullname AS curso,
    MAX(CASE WHEN ui1.fieldid = 1 THEN ui1.data END) AS genero,
    MAX(CASE WHEN ui2.fieldid = 3 THEN ui2.data END) AS ncontrol,
    CASE MAX(CASE WHEN ui3.fieldid = 2 THEN ui3.data END)
        WHEN 1 THEN 'Es foráneo'
        WHEN 0 THEN 'No es foráneo'
        ELSE 'Desconocido'
    END AS foraneo
FROM mdl_role_assignments AS ra
INNER JOIN mdl_user AS u ON ra.userid = u.id
INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
INNER JOIN mdl_course AS c ON ctx.instanceid = c.id
LEFT JOIN mdl_user_info_data AS ui1 ON u.id = ui1.userid AND ui1.fieldid = 1
LEFT JOIN mdl_user_info_data AS ui2 ON u.id = ui2.userid AND ui2.fieldid = 3
LEFT JOIN mdl_user_info_data AS ui3 ON u.id = ui3.userid AND ui3.fieldid = 2
WHERE  ra.roleid = 5
    AND c.id = 2-- Reemplaza 2 con el ID del curso deseado
GROUP BY u.id, u.firstname, u.lastname, c.fullname;


#Consultas 17/04/2024
#Consulta 1
SELECT COUNT(*) AS cantidad FROM mdl_user_info_data AS mi 
INNER JOIN mdl_user_info_field AS mif ON mif.id = mi.fieldid 
INNER JOIN mdl_user AS u ON u.id = mi.userid
WHERE mi.fieldid = 1 AND mi.data ="Mujer";

# Consulta 2 Forarenos
SELECT COUNT(*) AS cantidad 
FROM mdl_user_info_data AS mi1 
INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
INNER JOIN mdl_user AS u ON u.id = mi1.userid
WHERE (mi1.fieldid = 1 AND mi1.data = "Hombre") -- Condición para hombres
AND (mi2.fieldid = 2 AND mi2.data = 1); -- Condición para foráneos

#Consulta 3
SELECT COUNT(*) AS cantidad 
    FROM mdl_user_info_data AS mi1 
    INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
    INNER JOIN mdl_user AS u ON u.id = mi1.userid
    WHERE (mi1.fieldid = 1 AND mi1.data = "Mujer")
    AND (mi2.fieldid = 2 AND mi2.data = 1);
    
#Consulta 4
SELECT COUNT(*) AS cantidad 
    FROM mdl_user_info_data AS mi1 
    INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
    INNER JOIN mdl_user AS u ON u.id = mi1.userid
    WHERE (mi1.fieldid = 1 AND mi1.data = "No binario")
    AND (mi2.fieldid = 2 AND mi2.data = 1);

#Consulta 5
SELECT u.firstname, u.lastname, c.fullname AS curso,
    MAX(CASE WHEN ui1.fieldid = 1 THEN ui1.data END) AS genero,
    MAX(CASE WHEN ui2.fieldid = 3 THEN ui2.data END) AS ncontrol,
    CASE MAX(CASE WHEN ui3.fieldid = 2 THEN ui3.data END)
        WHEN 1 THEN 'Es foráneo'
        WHEN 0 THEN 'No es foráneo'
        ELSE 'Desconocido'
    END AS foraneo
FROM mdl_role_assignments AS ra
INNER JOIN mdl_user AS u ON ra.userid = u.id
INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
INNER JOIN mdl_course AS c ON ctx.instanceid = c.id
LEFT JOIN mdl_user_info_data AS ui1 ON u.id = ui1.userid AND ui1.fieldid = 1
LEFT JOIN mdl_user_info_data AS ui2 ON u.id = ui2.userid AND ui2.fieldid = 3
LEFT JOIN mdl_user_info_data AS ui3 ON u.id = ui3.userid AND ui3.fieldid = 2
WHERE ctx.contextlevel = 50
    AND ra.roleid = 5
    AND c.id = 7-- Reemplaza 2 con el ID del curso deseado
GROUP BY u.id, u.firstname, u.lastname, c.fullname;

#Consultas 18/04/2024
# Consulta 16
SELECT c.category AS Categoria, 
       c.fullname AS Nombre_Curso,
       FROM_UNIXTIME(c.startdate) AS Fecha_Inicio,
       FROM_UNIXTIME(c.enddate) AS Fecha_Finalizacion,
       (SELECT CONCAT(u.firstname, ' ', u.lastname) 
        FROM mdl_user AS u
        INNER JOIN mdl_role_assignments AS ra ON u.id = ra.userid
        INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
        INNER JOIN mdl_course AS c2 ON ctx.instanceid = c2.id
        WHERE ra.roleid = 3
        AND c2.id = c.id) AS Profesor,
        (SELECT COUNT(distinct u.id)
         FROM mdl_user as u
         INNER JOIN mdl_role_assignments as ra on u.id = ra.userid
         INNER JOIN mdl_context as ctx on ra.contextid = ctx.id
         INNER JOIN mdl_course as c2 on ctx.instanceid = c2.id
         where ra.roleid = 5 and c2.id = c.id ) as Numero_Alumnos
FROM mdl_course AS c; -- Id curso

# Consulta 17
SELECT c.category AS Categoria, c.fullname AS Nombre_Curso
FROM mdl_course AS c WHERE c.category = 4;

#Consulta 18
SELECT u.id as ID,CONCAT(u.firstname, ' ', u.lastname) AS Profesor, c.category AS Categoria, c.fullname AS Nombre_Curso,
    FROM_UNIXTIME(c.startdate) AS Fecha_Inicio,
    FROM_UNIXTIME(c.enddate) AS Fecha_Finalizacion
FROM mdl_user AS u
INNER JOIN mdl_role_assignments AS ra ON u.id = ra.userid
INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
INNER JOIN mdl_course AS c ON ctx.instanceid = c.id
WHERE ra.roleid = 3 #And u.id =2
ORDER BY ID,Profesor, Categoria, Nombre_Curso;

SELECT u.id AS ID, CONCAT(u.firstname, ' ', u.lastname) AS Profesor, c.category AS Categoria, c.fullname AS Nombre_Curso,
    FROM_UNIXTIME(c.startdate) AS Fecha_Inicio,
    FROM_UNIXTIME(c.enddate) AS Fecha_Finalizacion
FROM mdl_user AS u
INNER JOIN mdl_role_assignments AS ra ON u.id = ra.userid
INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
INNER JOIN mdl_course AS c ON ctx.instanceid = c.id
WHERE ra.roleid = 3 AND u.id = 2 -- Reemplaza 2 con el ID del profesor deseado
ORDER BY ID, Profesor, Categoria, Nombre_Curso;

# Consulta 19
SELECT u.id AS ID,CONCAT(u.firstname, ' ', u.lastname) AS Profesor, c.category AS Categoria, c.fullname AS Nombre_Curso,
    FROM_UNIXTIME(c.startdate) AS Fecha_Inicio, FROM_UNIXTIME(c.enddate) AS Fecha_Finalizacion
FROM mdl_user AS u
INNER JOIN mdl_role_assignments AS ra ON u.id = ra.userid
INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
INNER JOIN mdl_course AS c ON ctx.instanceid = c.id
WHERE ra.roleid = 3
    AND MONTH(FROM_UNIXTIME(c.startdate)) = 2 -- Cambiamos l numero por el mes que queramos (una lista para los filtros basicamente)
ORDER BY ID, Profesor, Categoria, Nombre_Curso;

#Consulta 20
SELECT COUNT(*) AS cantidad FROM mdl_user_info_data AS mi1 
INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
INNER JOIN mdl_user AS u ON u.id = mi1.userid
INNER JOIN mdl_role_assignments AS ra ON u.id = ra.userid
INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
INNER JOIN mdl_course AS c ON ctx.instanceid = c.id
WHERE (mi1.fieldid = 1 AND mi1.data = "Mujer") -- Condición para hombres
AND (mi2.fieldid = 2 AND mi2.data = 1)
AND ra.roleid = 5 -- Id para los alumnos y "3" para los profesores. En este caso es estatico en "5"
AND c.id = 1;  -- Id del curso

#Consultas 21
SELECT COUNT(*) AS cantidad 
FROM mdl_user_info_data AS mi1 
INNER JOIN mdl_user_info_data AS mi2 ON mi1.userid = mi2.userid 
INNER JOIN mdl_user AS u ON u.id = mi1.userid
INNER JOIN mdl_role_assignments AS ra ON u.id = ra.userid
INNER JOIN mdl_context AS ctx ON ra.contextid = ctx.id
INNER JOIN mdl_course AS c ON ctx.instanceid = c.id
WHERE (mi1.fieldid = 1 AND mi1.data = "Hombre") -- Condición para hombres
AND (mi2.fieldid = 2 AND mi2.data = 1) -- Condición para participantes en el curso
AND ra.roleid = 5 -- Condición para rol de profesor
AND c.id = 8 -- Id del curso
AND MONTH(FROM_UNIXTIME(c.startdate)) = 3; -- Condición para mes específico (cambiar el número según el mes deseado)

#Consulta 22
SELECT COUNT(*) AS Cantidad_Cursos FROM mdl_course 
WHERE MONTH(FROM_UNIXTIME(startdate)) = 2;

#Otra forma de hacerla. Pero aqui se mandan los meses y el total x cada mes
SELECT MONTH(FROM_UNIXTIME(startdate)) AS Mes, COUNT(*) AS Cantidad_Cursos
FROM mdl_course GROUP BY Mes ORDER BY Mes;




select * from mdl_role;
select * from mdl_role_assignments;
select * from mdl_context;
    



    

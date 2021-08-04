-- 1. Usuario registrado o Nuevo
-- 2. Mostramos los libros . Necesitas otro libro más ? max 5 y min 1.
-- 3. Registro de prestamo
DROP PROCEDURE sp_registrarPrestamo;
DELIMITER //
CREATE PROCEDURE sp_registrarPrestamo(
    IN idUsuario INT,
    IN idLibro1 INT,
    IN idLibro2 INT,
    IN idLibro3 INT,
    IN idLibro4 INT,
    IN idLibro5 INT
)
BEGIN
    -- Registro del pedido
    INSERT INTO prestamo (id_Usuario,Date_prestamo, activo) 
    VALUES (idUsuario,current_timestamp(),1);
    -- Declaro una variable 
    SET @id_Prestamo = (SELECT last_insert_id());
    
    -- Registro del detalle
    INSERT INTO detalle_prestamo (id_Libro, id_Prestamo)
    VALUES (idLibro1, @id_Prestamo);
    
    -- Registro del detalle de Libro 2
    IF idLibro2 IS NOT NULL THEN
		INSERT INTO detalle_prestamo (id_Libro, id_Prestamo)
		VALUES (idLibro2, @id_Prestamo);
    END IF;
    IF idLibro3 IS NOT NULL THEN
		INSERT INTO detalle_prestamo (id_Libro, id_Prestamo)
		VALUES (idLibro3, @id_Prestamo);
    END IF;
    IF idLibro4 IS NOT NULL THEN
		INSERT INTO detalle_prestamo (id_Libro, id_Prestamo)
		VALUES (idLibro4, @id_Prestamo);
    END IF;
    IF idLibro5 IS NOT NULL THEN
		INSERT INTO detalle_prestamo (id_Libro, id_Prestamo)
		VALUES (idLibro5, @id_Prestamo);
    END IF;
    
END//

-- Consulta de Cabecera Prestamo
-- Nombre de la persona
-- Numero prestamo
-- Correo
-- Fecha del Prestamo
DROP PROCEDURE sp_consultarCabeceraPrestamoReporte
DELIMITER //
CREATE PROCEDURE sp_consultarCabeceraPrestamoReporte(
    IN idPrestamo INT
)
BEGIN 
    SELECT Pre.Id_Prestamo, Per.FirstName, Per.LastName, Usr.Email, Pre.Date_prestamo FROM prestamo AS Pre
    INNER JOIN usuario AS Usr
    ON Usr.id_Usuario = Pre.id_Usuario
    INNER JOIN persona AS Per
    ON Per.id_Persona = Usr.Id_Persona
    WHERE Pre.Id_Prestamo = idPrestamo;

END//

-- Consulta de Detalle de Prestamo
-- Nombre de la persona
-- Numero prestamo
-- Correo
-- Fecha del Prestamo
DROP PROCEDURE sp_consultarDetallePrestamoReporte
DELIMITER //
CREATE PROCEDURE sp_consultarDetallePrestamoReporte(
    IN idPrestamo INT
)
BEGIN 
    SELECT L.Title FROM detalle_prestamo AS DP
    INNER JOIN Libro AS L
    ON L.id_Libro = DP.Id_Libro
    WHERE DP.Id_Prestamo = idPrestamo;
END//
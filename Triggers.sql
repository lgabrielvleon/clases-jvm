CREATE TABLE categoria_log (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    accion varchar(255) NOT NULL,
    date_created timestamp
);

-- Trigger previo al insert
DELIMITER //
CREATE TRIGGER categoria_log_trigger BEFORE INSERT ON categoria
FOR EACH ROW BEGIN
    INSERT INTO categoria_log (accion, date_created) values ('INSERT', CURRENT_TIMESTAMP());
END;//


-- Trigger después del insert

DELIMITER //
CREATE TRIGGER categoria_log_trigger_after AFTER INSERT ON categoria
FOR EACH ROW BEGIN
    INSERT INTO categoria_log (accion, date_created) values ('INSERT-AFTER', CURRENT_TIMESTAMP());
END;//


-- Trigger previo al update
DELIMITER //
CREATE TRIGGER categoria_UPDATE_trigger BEFORE UPDATE ON categoria
FOR EACH ROW BEGIN
    INSERT INTO categoria_log (accion, date_created) values ('UPDATE', CURRENT_TIMESTAMP());
END;//


-- Trigger después del update

DELIMITER //
CREATE TRIGGER categoria_UPDATE_trigger_after AFTER UPDATE ON categoria
FOR EACH ROW BEGIN
    INSERT INTO categoria_log (accion, date_created) values ('UPDATE-AFTER', CURRENT_TIMESTAMP());
END;//

-- Eliminar un Trigger

DROP TRIGGER categoria_UPDATE_trigger;
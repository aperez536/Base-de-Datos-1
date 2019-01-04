CREATE table auditoria(
cHuevoObtenido int,
cGallinaMuerta int,
cant float,
tipo_alimento varchar(45),
cuil varchar(45),
nombreUser varchar(45),
fecha_suceso datetime

)

DELIMITER //
CREATE TRIGGER OBTENERDATOSANTESDEACUATILIZAR BEFORE UPDATE ON  galponero
FOR EACH ROW
BEGIN
insert into auditoria(cHuevoObtenido ,cGallinaMuerta ,cant ,tipo_alimento ,cuil ,nombreUser ,fecha_suceso )
Values (old.cantidadhuevosObtenidos, old.cantidadGaMuerta, old.cantidad, old.tipo_alimento, old.cuil, CURRENT_USER, NOW());

END ; //
DELIMITER ;
DELIMITER //
CREATE TRIGGER OBTENERDATOSELIMINACIONGALPONERO BEFORE DELETE ON  galponero
FOR EACH ROW
BEGIN
insert into auditoria(cHuevoObtenido ,cGallinaMuerta ,cant ,tipo_alimento ,cuil ,nombreUser ,fecha_suceso )
Values (old.cantidadhuevosObtenidos, old.cantidadGaMuerta, old.cantidad, old.tipo_alimento, old.cuil, CURRENT_USER, NOW());

END ; //
DELIMITER ;

DROP TRIGGER OBTENERDATOSINSERTANDODATOSGALPONERO;

DELIMITER //
CREATE TRIGGER OBTENERDATOSINSERTANDODATOSGALPONERO AFTER INSERT ON  galponero
FOR EACH ROW
BEGIN
insert into auditoria(cHuevoObtenido ,cGallinaMuerta ,cant ,tipo_alimento ,cuil ,nombreUser ,fecha_suceso )
Values (NEW.cantidadhuevosObtenidos, NEW.cantidadGaMuerta, NEW.cantidad, NEW.tipo_alimento, NEW.cuil, CURRENT_USER, NOW());

END ; //
DELIMITER ;

DROP TRIGGER OBTENERDATOSINSERTANDODATOSGALPONERO;

call  MODIFICARGALPONERO(4,2,700,'MEZCLA GALLINA',11111111111);
call ALTAGALPONERO(4,12,7020,'MEZCLA GALLINA',22222222222);
CALL BAJAGALPONERO(22222222222)


SELECT * FROM auditoria;
SELECT * FROM galponero;
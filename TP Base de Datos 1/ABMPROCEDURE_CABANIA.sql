/* cabaña genetica galponero*/
SELECT * FROM CABAÑA;
/* ALTA CABAÑA*/
DELIMITER //
CREATE PROCEDURE ALTACABAÑA($RAZON_SOCIAL VARCHAR(45), $CUIT VARCHAR(11),
$CALLE VARCHAR(45), $NUMERO INT, $LOCALIDAD VARCHAR(45),$PROVINCIA VARCHAR(45))
BEGIN
    if(TRAERCABAÑA($CUIT) = 1) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'YA EXISTE EL CLIENTE';
	END IF;
	INSERT INTO cabaña(razon_social,cuit,calle,numero,localidad,provincia) values
	($RAZON_SOCIAL,$CUIT,$CALLE,$NUMERO,$LOCALIDAD,$PROVINCIA);
END //;
DELIMITER ;
DROP PROCEDURE ALTACABAÑA;    

CALL ALTACABAÑA("LA GALLINERA","12312312311","AVENIDA CORDOBA",1232,"LANUS","BUENOS AIRES");
/*TRAER CABAÑA */

DELIMITER $$
CREATE FUNCTION TRAERCABAÑA($CUIT VARCHAR(11)) RETURNS INT
BEGIN
	IF (SELECT cuit from cabaña where cuit = $CUIT) THEN
		RETURN 1;
	END IF;
	RETURN 0;
END ;$$
DELIMITER ;

/* MODIFICACION CABAÑA*/
DROP PROCEDURE MODIFICACIONCABAÑA;
DELIMITER //
CREATE PROCEDURE MODIFICACIONCABAÑA($RAZON_SOCIAL VARCHAR(45), $CUIT VARCHAR(11),
$CALLE VARCHAR(45), $NUMERO INT, $LOCALIDAD VARCHAR(45),$PROVINCIA VARCHAR(45))
BEGIN
   if(TRAERCABAÑA($CUIT) = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'NO EXISTE LA CABAÑA A MODIFICAR';
    ELSE
		UPDATE cabaña SET
		razon_social = $RAZON_SOCIAL,
		calle = $CALLE,
		numero = $NUMERO,
		localidad = $LOCALIDAD,
		provincia = $PROVINCIA
		WHERE cuit = $CUIT;
    END IF;
END //;
    DELIMITER ;
    
CALL MODIFICACIONCABAÑA("LA GALLINA","12312312311","9 DE JULIO",1022,"LANUS","BUENOS AIRES");
/* BAJA CABAÑA*/
DROP PROCEDURE BAJACABAÑA;
DELIMITER //
CREATE PROCEDURE BAJACABAÑA($CUIT VARCHAR(11))
BEGIN
	if(TRAERCABAÑA($CUIT) = 0) THEN
		SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'NO EXISTE LA CABAÑA A ELIMINAR';
	END IF;
	DELETE FROM cabaña where cuit = $CUIT ;
END //;
DELIMITER ;
CALL BAJACABAÑA('12312312311');

create index prov on cabaña(provincia);
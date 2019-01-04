DELIMITER //
CREATE FUNCTION TRAERPRODUCTO($ID_PRODUCTO INT) RETURNS INT 
BEGIN
	IF(SELECT id_producto FROM producto WHERE id_producto = $ID_PRODUCTO) THEN
		RETURN 1;
	END IF;
    RETURN 0;
END//;
DELIMITER ;

DROP FUNCTION TRAERPRODUCTO;

DELIMITER //
CREATE PROCEDURE ALTAPRODUCTO($NOMBRE VARCHAR(45), $PRECIO_VENTA FLOAT, $CANTIDADHUEVO INT, $ID_PRODUCTO INT ,$ID_GRANJA INT)
BEGIN
	IF(TRAERPRODUCTO($ID_PRODUCTO) = 1 ) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = ' YA EXISTE EL PRODUCTO ';
	ELSE IF(TRAERGRANJA($ID_GRANJA) = 0) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = ' NO EXISTE LA GRANJA ';
	ELSE
    INSERT INTO producto(nombre, precio_venta, cantidadHuevo, id_producto,id_granja) VALUES ($NOMBRE, $PRECIO_VENTA, $CANTIDADHUEVO, $ID_PRODUCTO,$ID_GRANJA);
	END IF;
    END IF;
END //;
DELIMITER ; 

DELIMITER //
CREATE PROCEDURE MODIFICARPRODUCTO($NOMBRE VARCHAR(45), $PRECIO_VENTA FLOAT, $CANTIDADHUEVO INT, $ID_PRODUCTO INT,$ID_GRANJA INT)
BEGIN
	IF(TRAERPRODUCTO($ID_PRODUCTO) = 0 ) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NO EXISTE EL PRODUCTO A MODIFICAR';
	ELSE IF(TRAERGRANJA($ID_GRANJA) = 0) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = ' NO EXISTE LA GRANJA ';
	ELSE
    UPDATE producto SET
    nombre = $NOMBRE  ,
    precio_venta= $PRECIO_VENTA ,
    cantidadHuevo = $CANTIDADHUEVO,
    id_granja = $ID_GRANJA
    WHERE id_producto = $ID_PRODUCTO;
    END IF;
    END IF;

END //;
DELIMITER ; 

DELIMITER //
CREATE PROCEDURE BAJAPRODUCTO($ID_PRODUCTO INT)
BEGIN
	IF ( TRAERPRODUCTO($ID_PRODUCTO) = 0) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NO EIXSTE EL PRODUCTO A ELIMINAR';
	END IF;
	delete FROM producto where producto.id_producto = $ID_PRODUCTO;
END//;
DELIMITER ;

DROP PROCEDURE MODIFICARPRODUCTO;
DROP PROCEDURE ALTAPRODUCTO;
DROP PROCEDURE BAJAPRODUCTO;

SELECT * FROM producto;
CALL ALTAPRODUCTO('GASEOSA',44,15,1,1);
CALL MODIFICARPRODUCTO('COCA',45,20,1,1);
call BAJAPRODUCTO(1);

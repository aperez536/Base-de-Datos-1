-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`cabaña`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cabaña` (
  `razon_social` VARCHAR(45) NOT NULL,
  `cuit` VARCHAR(11) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT(11) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cuit`),
  INDEX `prov` (`provincia` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `localidad` VARCHAR(11) NOT NULL,
  `cuit` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`cuit`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`galponero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`galponero` (
  `cantidadhuevosObtenidos` INT(11) NOT NULL,
  `cantidadGaMuerta` INT(11) NOT NULL,
  `cantidad` FLOAT NOT NULL,
  `tipo_alimento` VARCHAR(45) NOT NULL,
  `cuil` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`cuil`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`galpon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`galpon` (
  `idgalpon` INT(11) NOT NULL,
  `cantidad_gallinas` INT(11) NULL DEFAULT NULL,
  `cabaña_cuit` VARCHAR(11) NOT NULL,
  `galponero_cuil` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idgalpon`),
  INDEX `fk_galpon_cabaña1_idx` (`cabaña_cuit` ASC),
  INDEX `fk_galpon_galponero1_idx` (`galponero_cuil` ASC),
  CONSTRAINT `fk_galpon_cabaña1`
    FOREIGN KEY (`cabaña_cuit`)
    REFERENCES `mydb`.`cabaña` (`cuit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_galpon_galponero1`
    FOREIGN KEY (`galponero_cuil`)
    REFERENCES `mydb`.`galponero` (`cuil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`genetica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`genetica` (
  `idgenetica` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `cabaña_cuit` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idgenetica`),
  INDEX `fk_genetica_cabaña1_idx` (`cabaña_cuit` ASC),
  CONSTRAINT `fk_genetica_cabaña1`
    FOREIGN KEY (`cabaña_cuit`)
    REFERENCES `mydb`.`cabaña` (`cuit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`granja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`granja` (
  `nombre` VARCHAR(45) NOT NULL,
  `idGranja` INT(11) NOT NULL,
  `cabaña_cuit` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idGranja`),
  INDEX `fk_granja_cabaña1_idx` (`cabaña_cuit` ASC),
  CONSTRAINT `fk_granja_cabaña1`
    FOREIGN KEY (`cabaña_cuit`)
    REFERENCES `mydb`.`cabaña` (`cuit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`plantel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`plantel` (
  `idplantel` INT(11) NOT NULL,
  `edad` INT(11) NOT NULL,
  `genetica_gallina` INT(11) NOT NULL,
  `fecha_Entrada` DATETIME NOT NULL,
  `precioCompra` FLOAT NOT NULL,
  `galpon_idgalpon` INT(11) NOT NULL,
  PRIMARY KEY (`idplantel`),
  INDEX `fk_plantel_galpon1_idx` (`galpon_idgalpon` ASC),
  INDEX `genetica1_idx` (`genetica_gallina` ASC),
  INDEX `algo` (`edad` ASC, `fecha_Entrada` ASC),
  CONSTRAINT `fk_plantel_galpon1`
    FOREIGN KEY (`galpon_idgalpon`)
    REFERENCES `mydb`.`galpon` (`idgalpon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `genetica1`
    FOREIGN KEY (`genetica_gallina`)
    REFERENCES `mydb`.`genetica` (`idgenetica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `nombre` VARCHAR(45) NOT NULL,
  `precio_venta` FLOAT NOT NULL,
  `cantidadHuevo` INT(11) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  `id_granja` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_Producto_granja1_idx` (`id_producto` ASC),
  INDEX `fk_id_granja` (`id_granja` ASC),
  CONSTRAINT `fk_id_granja`
    FOREIGN KEY (`id_granja`)
    REFERENCES `mydb`.`granja` (`idGranja`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venta` (
  `granja_idGranja` INT(11) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `cliente_cuit` VARCHAR(11) NOT NULL,
  `idproducto` INT(11) NOT NULL,
  PRIMARY KEY (`granja_idGranja`, `cliente_cuit`),
  INDEX `fk_granja_has_cliente_cliente1_idx` (`cliente_cuit` ASC),
  INDEX `fk_granja_has_cliente_granja_idx` (`granja_idGranja` ASC),
  INDEX `productos_idx` (`idproducto` ASC),
  CONSTRAINT `fk_granja_has_cliente_cliente1`
    FOREIGN KEY (`cliente_cuit`)
    REFERENCES `mydb`.`cliente` (`cuit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_granja_has_cliente_granja`
    FOREIGN KEY (`granja_idGranja`)
    REFERENCES `mydb`.`granja` (`idGranja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `productos`
    FOREIGN KEY (`idproducto`)
    REFERENCES `mydb`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `mydb` ;

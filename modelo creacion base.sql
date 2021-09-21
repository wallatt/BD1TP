-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`consecionaria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`consecionaria` ;

CREATE TABLE IF NOT EXISTS `mydb`.`consecionaria` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `FechaDeVenta` DATETIME NULL DEFAULT NULL,
  `FechaDeEntrega` DATETIME NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `consecionaria_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_pedido_consecionaria`
    FOREIGN KEY (`consecionaria_Id`)
    REFERENCES `mydb`.`consecionaria` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`linea_montaje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`linea_montaje` ;

CREATE TABLE IF NOT EXISTS `mydb`.`linea_montaje` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Codigo` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`modelo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`modelo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`modelo` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `linea_montaje_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_modelo_linea_montaje1`
    FOREIGN KEY (`linea_montaje_Id`)
    REFERENCES `mydb`.`linea_montaje` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`pedido_detalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pedido_detalle` ;

CREATE TABLE IF NOT EXISTS `mydb`.`pedido_detalle` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `modelo_Id` INT(11) NOT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `pedido_Id` INT(11) NOT NULL,
  `modelo_Id1` INT(11) NOT NULL,
  PRIMARY KEY (`Id`, `modelo_Id`),
  CONSTRAINT `fk_pedido_detalle_pedido1`
    FOREIGN KEY (`pedido_Id`)
    REFERENCES `mydb`.`pedido` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_detalle_modelo1`
    FOREIGN KEY (`modelo_Id1`)
    REFERENCES `mydb`.`modelo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`automovil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`automovil` ;

CREATE TABLE IF NOT EXISTS `mydb`.`automovil` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Chasis` VARCHAR(45) NULL DEFAULT NULL,
  `FechaInicio` DATETIME NULL DEFAULT NULL,
  `FechaFin` DATETIME NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `pedido_detalle_Id` INT(11) NOT NULL,
  `pedido_detalle_modelo_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_automovil_pedido_detalle1`
    FOREIGN KEY (`pedido_detalle_Id` , `pedido_detalle_modelo_Id`)
    REFERENCES `mydb`.`pedido_detalle` (`Id` , `modelo_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`estacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`estacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`estacion` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `OrdenEstacion` INT(11) NULL DEFAULT NULL,
  `TareaDeterminada` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `linea_montaje_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_estacion_linea_montaje1`
    FOREIGN KEY (`linea_montaje_Id`)
    REFERENCES `mydb`.`linea_montaje` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`automovil_estacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`automovil_estacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`automovil_estacion` (
  `FechaIngresoEstacion` DATETIME NULL DEFAULT NULL,
  `FechaEgresoEstacion` DATETIME NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `estacion_Id` INT(11) NOT NULL,
  `automovil_Id` INT(11) NOT NULL,
  CONSTRAINT `fk_automovil_estacion_estacion1`
    FOREIGN KEY (`estacion_Id`)
    REFERENCES `mydb`.`estacion` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_automovil_estacion_automovil1`
    FOREIGN KEY (`automovil_Id`)
    REFERENCES `mydb`.`automovil` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`unidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`unidad` ;

CREATE TABLE IF NOT EXISTS `mydb`.`unidad` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminar` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`insumos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`insumos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`insumos` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `Cantidad` INT(11) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` VARCHAR(45) NULL DEFAULT NULL,
  `unidad_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_insumos_unidad1`
    FOREIGN KEY (`unidad_Id`)
    REFERENCES `mydb`.`unidad` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`insumo_estacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`insumo_estacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`insumo_estacion` (
  `CantidadConsumida` INT(11) NULL DEFAULT NULL,
  `UnidadConsumida` INT(11) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `estacion_Id` INT(11) NOT NULL,
  `insumos_Id` INT(11) NOT NULL,
  PRIMARY KEY (`insumos_Id`, `estacion_Id`),
  CONSTRAINT `fk_insumo_estacion_estacion1`
    FOREIGN KEY (`estacion_Id`)
    REFERENCES `mydb`.`estacion` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_estacion_insumos1`
    FOREIGN KEY (`insumos_Id`)
    REFERENCES `mydb`.`insumos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`proveedor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`proveedor` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `CUIT` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`proveedor_insumos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`proveedor_insumos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`proveedor_insumos` (
  `Precio` INT(11) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `insumos_Id` INT(11) NOT NULL,
  `proveedor_Id` INT(11) NOT NULL,
  CONSTRAINT `fk_proveedor_insumos_insumos1`
    FOREIGN KEY (`insumos_Id`)
    REFERENCES `mydb`.`insumos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_insumos_proveedor1`
    FOREIGN KEY (`proveedor_Id`)
    REFERENCES `mydb`.`proveedor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

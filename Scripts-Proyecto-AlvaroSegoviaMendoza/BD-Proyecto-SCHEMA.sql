-- MySQL Script generated by MySQL Workbench
-- Wed Apr  2 11:54:09 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Departamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `idDepartamento` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Ubicación` VARCHAR(45) NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Empleado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Empleado` (
  `idEmpleado` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Salario` VARCHAR(45) NULL,
  `Tipo` VARCHAR(45) NULL,
  `Stack` VARCHAR(45) NULL,
  `Jefe_idEmpleado` INT NOT NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_Empleado_Empleado_idx` (`Jefe_idEmpleado` ASC) VISIBLE,
  INDEX `fk_Empleado_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Empleado`
    FOREIGN KEY (`Jefe_idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `mydb`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Teléfono` VARCHAR(45) NULL,
  `Correo` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proyecto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Proyecto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Proyecto` (
  `idProyecto` INT NOT NULL,
  `Tema` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `idEmpleado_Coordinador` INT NOT NULL,
  `fecha_inicio` DATETIME NULL,
  `fecha_fin` DATETIME NULL,
  `presupuesto` VARCHAR(45) NULL,
  PRIMARY KEY (`idProyecto`),
  INDEX `fk_Proyecto_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Proyecto_Empleado1_idx` (`idEmpleado_Coordinador` ASC) VISIBLE,
  CONSTRAINT `fk_Proyecto_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proyecto_Empleado1`
    FOREIGN KEY (`idEmpleado_Coordinador`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tareas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tareas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tareas` (
  `Orden_tarea` INT NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Nivel_dificultad` VARCHAR(45) NULL,
  `Proyecto_idProyecto` INT NOT NULL,
  `num_horas_completar` VARCHAR(45) NULL,
  `fecha` DATETIME NULL,
  `estado_pedido` ENUM('TO DO', 'EN CURSO', 'DONE') NULL,
  PRIMARY KEY (`Proyecto_idProyecto`, `Orden_tarea`),
  INDEX `fk_Tareas_Proyecto1_idx` (`Proyecto_idProyecto` ASC) VISIBLE,
  CONSTRAINT `fk_Tareas_Proyecto1`
    FOREIGN KEY (`Proyecto_idProyecto`)
    REFERENCES `mydb`.`Proyecto` (`idProyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asignación_Tareas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Asignación_Tareas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Asignación_Tareas` (
  `Orden_tarea` INT NOT NULL,
  `idProyecto` INT NOT NULL,
  `idEmpleado` INT NOT NULL,
  `Num_horas_reales` VARCHAR(45) NULL,
  PRIMARY KEY (`Orden_tarea`, `idProyecto`, `idEmpleado`),
  INDEX `fk_Tareas_has_Empleado_Empleado1_idx` (`idEmpleado` ASC) VISIBLE,
  INDEX `fk_Tareas_has_Empleado_Tareas1_idx` (`Orden_tarea` ASC, `idProyecto` ASC) VISIBLE,
  CONSTRAINT `fk_Tareas_has_Empleado_Tareas1`
    FOREIGN KEY (`Orden_tarea` , `idProyecto`)
    REFERENCES `mydb`.`Tareas` (`Orden_tarea` , `Proyecto_idProyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tareas_has_Empleado_Empleado1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trabajan_proyectos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Trabajan_proyectos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Trabajan_proyectos` (
  `Empleado_idEmpleado` INT NOT NULL,
  `Proyecto_idProyecto` INT NOT NULL,
  `Fecha_inicio` VARCHAR(45) NULL,
  `Fecha_fin` VARCHAR(45) NULL,
  PRIMARY KEY (`Empleado_idEmpleado`, `Proyecto_idProyecto`),
  INDEX `fk_Empleado_has_Proyecto_Proyecto1_idx` (`Proyecto_idProyecto` ASC) VISIBLE,
  INDEX `fk_Empleado_has_Proyecto_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_has_Proyecto_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_has_Proyecto_Proyecto1`
    FOREIGN KEY (`Proyecto_idProyecto`)
    REFERENCES `mydb`.`Proyecto` (`idProyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

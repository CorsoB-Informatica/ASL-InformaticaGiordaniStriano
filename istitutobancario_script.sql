-- MySQL Workbench Synchronization
-- Generated: 2016-12-07 10:35
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Classe 5B

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE IF NOT EXISTS `istitutobancario`.`Filiale` (
  `idFiliale` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `città` VARCHAR(45) NULL DEFAULT NULL,
  `saldo_euro` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idFiliale`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `istitutobancario`.`Conto corrente` (
  `Num_Conto` INT(11) NOT NULL AUTO_INCREMENT,
  `Saldo_euro_positivo` DOUBLE NULL DEFAULT NULL,
  `Cliente_Codice fiscale` VARCHAR(16) NULL DEFAULT NULL,
  `Cliente_Filiale_idFiliale` INT(11) NULL DEFAULT NULL,
  `Filiale_idFiliale` INT(11) NOT NULL,
  PRIMARY KEY (`Num_Conto`, `Filiale_idFiliale`),
  INDEX `fk_Conto corrente_Filiale1_idx` (`Filiale_idFiliale` ASC),
  CONSTRAINT `fk_Conto corrente_Filiale1`
    FOREIGN KEY (`Filiale_idFiliale`)
    REFERENCES `istitutobancario`.`Filiale` (`idFiliale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `istitutobancario`.`Cliente` (
  `Codice fiscale` VARCHAR(16) NULL DEFAULT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `cognome` VARCHAR(45) NULL DEFAULT NULL,
  `indirizzo` VARCHAR(45) NULL DEFAULT NULL,
  `numero_telefonico` VARCHAR(45) NULL DEFAULT NULL,
  `Filiale_idFiliale` INT(11) NOT NULL,
  `Prestito_Codice cliente` INT(11) NOT NULL,
  PRIMARY KEY (`Codice fiscale`, `Filiale_idFiliale`, `Prestito_Codice cliente`),
  INDEX `fk_Cliente_Prestito1_idx` (`Prestito_Codice cliente` ASC),
  CONSTRAINT `fk_Cliente_Prestito1`
    FOREIGN KEY (`Prestito_Codice cliente`)
    REFERENCES `istitutobancario`.`Prestito` (`Codice_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `istitutobancario`.`Prestito` (
  `Codice_cliente` INT(11) NOT NULL,
  `Somma_euro` INT(11) NOT NULL,
  `Codice_matricola` INT(11) NOT NULL,
  `Codice_ufficio` INT(11) NOT NULL,
  `Data apertura` DATE NOT NULL,
  `Data_estinzione` DATE NULL DEFAULT NULL,
  `Prestitocol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Codice_cliente`),
  INDEX `codice_ufficio_idx` (`Codice_ufficio` ASC),
  CONSTRAINT `codice_ufficio`
    FOREIGN KEY (`Codice_ufficio`)
    REFERENCES `istitutobancario`.`Filiale` (`idFiliale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `istitutobancario`.`Cliente_has_Conto corrente` (
  `Cliente_Codice fiscale` VARCHAR(16) NOT NULL,
  `Cliente_Filiale_idFiliale` INT(11) NOT NULL,
  `Cliente_Prestito_Codice cliente` INT(11) NOT NULL,
  `Conto corrente_N°Conto` INT(11) NOT NULL,
  PRIMARY KEY (`Cliente_Codice fiscale`, `Cliente_Filiale_idFiliale`, `Cliente_Prestito_Codice cliente`, `Conto corrente_N°Conto`),
  INDEX `fk_Cliente_has_Conto corrente_Conto corrente1_idx` (`Conto corrente_N°Conto` ASC),
  INDEX `fk_Cliente_has_Conto corrente_Cliente1_idx` (`Cliente_Codice fiscale` ASC, `Cliente_Filiale_idFiliale` ASC, `Cliente_Prestito_Codice cliente` ASC),
  CONSTRAINT `fk_Cliente_has_Conto corrente_Cliente1`
    FOREIGN KEY (`Cliente_Codice fiscale` , `Cliente_Filiale_idFiliale` , `Cliente_Prestito_Codice cliente`)
    REFERENCES `istitutobancario`.`Cliente` (`Codice fiscale` , `Filiale_idFiliale` , `Prestito_Codice cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Conto corrente_Conto corrente1`
    FOREIGN KEY (`Conto corrente_N°Conto`)
    REFERENCES `istitutobancario`.`Conto corrente` (`Num_Conto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

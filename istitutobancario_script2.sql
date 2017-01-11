-- MySQL Workbench Synchronization
-- Generated: 2017-01-11 10:22
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Classe 5B

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP TABLE IF EXISTS `istitutobancario`.`conto_corrente` ;

DROP TABLE IF EXISTS `istitutobancario`.`cliente_has_conto corrente` ;

CREATE TABLE IF NOT EXISTS `istitutobancario`.`Conto_corrente` (
  `Num_Conto` INT(11) NOT NULL AUTO_INCREMENT,
  `Saldo_euro_positivo` DOUBLE NULL DEFAULT NULL,
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

ALTER TABLE `istitutobancario`.`Cliente` 
DROP COLUMN `Prestito_Codice cliente`,
DROP COLUMN `Filiale_idFiliale`,
CHANGE COLUMN `Codice fiscale` `Codice_fiscale` VARCHAR(16) NULL DEFAULT NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`Codice_fiscale`),
DROP INDEX `fk_Cliente_Prestito1_idx` ;

ALTER TABLE `istitutobancario`.`Prestito` 
CHANGE COLUMN `Codice_cliente` `Codice_prestito` INT(11) NOT NULL ,
CHANGE COLUMN `Data apertura` `Data_apertura` DATE NOT NULL ,
ADD COLUMN `Cliente_Codice fiscale` VARCHAR(16) NOT NULL AFTER `Data_estinzione`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`Codice_prestito`, `Cliente_Codice fiscale`),
ADD INDEX `fk_Prestito_Cliente1_idx` (`Cliente_Codice fiscale` ASC);

CREATE TABLE IF NOT EXISTS `istitutobancario`.`Conto_corrente_has_Cliente` (
  `Conto_corrente_Num_Conto` INT(11) NOT NULL,
  `Conto_corrente_Filiale_idFiliale` INT(11) NOT NULL,
  `Cliente_Codice_fiscale` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Conto_corrente_Num_Conto`, `Conto_corrente_Filiale_idFiliale`, `Cliente_Codice_fiscale`),
  INDEX `fk_Conto_corrente_has_Cliente_Cliente1_idx` (`Cliente_Codice_fiscale` ASC),
  INDEX `fk_Conto_corrente_has_Cliente_Conto_corrente1_idx` (`Conto_corrente_Num_Conto` ASC, `Conto_corrente_Filiale_idFiliale` ASC),
  CONSTRAINT `fk_Conto_corrente_has_Cliente_Conto_corrente1`
    FOREIGN KEY (`Conto_corrente_Num_Conto` , `Conto_corrente_Filiale_idFiliale`)
    REFERENCES `istitutobancario`.`Conto_corrente` (`Num_Conto` , `Filiale_idFiliale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Conto_corrente_has_Cliente_Cliente1`
    FOREIGN KEY (`Cliente_Codice_fiscale`)
    REFERENCES `istitutobancario`.`Cliente` (`Codice_fiscale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



ALTER TABLE `istitutobancario`.`Prestito` 
ADD CONSTRAINT `fk_Prestito_Cliente1`
  FOREIGN KEY (`Cliente_Codice fiscale`)
  REFERENCES `istitutobancario`.`Cliente` (`Codice_fiscale`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

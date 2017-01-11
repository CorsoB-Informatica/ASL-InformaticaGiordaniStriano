-- MySQL Workbench Synchronization
-- Generated: 2017-01-11 10:47
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Classe 5B

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


DROP TABLE IF EXISTS `istitutobancario`.`conto_corrente` ;

ALTER TABLE `istitutobancario`.`Cliente` 
DROP COLUMN `Codice_fiscale`,
ADD COLUMN `Codice_fiscale` VARCHAR(16) NULL DEFAULT NULL FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`Codice_fiscale`);

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


ALTER TABLE `istitutobancario`.`Prestito` 
DROP COLUMN `Data_apertura`,
DROP COLUMN `Codice_ufficio`,
DROP COLUMN `Codice_prestito`,
ADD COLUMN `Codice_prestito` INT(11) NOT NULL FIRST,
ADD COLUMN `Data_apertura` DATE NOT NULL AFTER `Codice_matricola`,
ADD COLUMN `Filiale_idFiliale` INT(11) NOT NULL AFTER `Cliente_Codice fiscale`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`Codice_prestito`, `Cliente_Codice fiscale`, `Filiale_idFiliale`),
ADD INDEX `fk_Prestito_Cliente1_idx` (`Cliente_Codice fiscale` ASC),
ADD INDEX `fk_Prestito_Filiale1_idx` (`Filiale_idFiliale` ASC),
DROP INDEX `fk_Prestito_Cliente1_idx` ,
DROP INDEX `codice_ufficio_idx` ;

ALTER TABLE `istitutobancario`.`Conto_corrente_has_Cliente` 
DROP COLUMN `Cliente_Codice_fiscale`,
ADD COLUMN `Cliente_Codice_fiscale` VARCHAR(16) NOT NULL AFTER `Conto_corrente_Filiale_idFiliale`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`Conto_corrente_Num_Conto`, `Conto_corrente_Filiale_idFiliale`, `Cliente_Codice_fiscale`),
ADD INDEX `fk_Conto_corrente_has_Cliente_Cliente1_idx` (`Cliente_Codice_fiscale` ASC),
ADD INDEX `fk_Conto_corrente_has_Cliente_Conto_corrente1_idx` (`Conto_corrente_Num_Conto` ASC, `Conto_corrente_Filiale_idFiliale` ASC),
DROP INDEX `fk_Conto_corrente_has_Cliente_Conto_corrente1_idx` ,
DROP INDEX `fk_Conto_corrente_has_Cliente_Cliente1_idx` ;

ALTER TABLE `istitutobancario`.`Prestito` 
ADD CONSTRAINT `fk_Prestito_Filiale1`
  FOREIGN KEY (`Filiale_idFiliale`)
  REFERENCES `istitutobancario`.`Filiale` (`idFiliale`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `istitutobancario`.`Conto_corrente_has_Cliente` 
ADD CONSTRAINT `fk_Conto_corrente_has_Cliente_Cliente1`
  FOREIGN KEY (`Cliente_Codice_fiscale`)
  REFERENCES `istitutobancario`.`Cliente` (`Codice_fiscale`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

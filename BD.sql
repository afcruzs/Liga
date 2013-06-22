SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `entrenador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `entrenador` ;

CREATE  TABLE IF NOT EXISTS `entrenador` (
  `id_entrenador` INT NOT NULL AUTO_INCREMENT ,
  `telefono_entrenador` VARCHAR(45) NULL ,
  `experiencia_entrenador` INT NULL DEFAULT 0 ,
  `apellidos_entrenador` VARCHAR(45) NOT NULL,
  `nombres_entrenador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_entrenador`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_Entrenador_UNIQUE` ON `entrenador` (`id_entrenador` ASC) ;


-- -----------------------------------------------------
-- Table `equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `equipo` ;

CREATE  TABLE IF NOT EXISTS `equipo` (
  `id_equipo` INT NOT NULL AUTO_INCREMENT,
  `ciudad_equipo` VARCHAR(45) NULL ,
  `nombre_equipo` VARCHAR(45) UNIQUE NOT NULL,
  PRIMARY KEY (`id_equipo`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id:Equipo_UNIQUE` ON `equipo` (`id_equipo` ASC) ;


-- -----------------------------------------------------
-- Table `historico_entrenadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `historico_entrenadores` ;

CREATE  TABLE IF NOT EXISTS `historico_entrenadores` (
  `id_entrenador` INT NOT NULL ,
  `id_equipo` INT NOT NULL ,
  `salario_historico_entrenadores` DOUBLE NOT NULL ,
  `año_historico_entrenadores` INT NOT NULL ,
  `director_historico_entrenadores` TINYINT(1) NOT NULL ,
  CONSTRAINT `id_entrenador_historico_entrenadores`
    FOREIGN KEY (`id_entrenador` )
    REFERENCES `entrenador` (`id_entrenador` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id:id_equipo_UNIQUE` ON `historico_entrenadores` (`id_equipo` ASC) ;
-- -----------------------------------------------------
-- Table `jugador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jugador` ;

CREATE  TABLE IF NOT EXISTS `jugador` (
  `id_jugador` INT NOT NULL AUTO_INCREMENT,
  `nacionalidad_jugador` VARCHAR(45) NOT NULL ,
  `edad_jugador` INT NULL ,
  `apellidos_jugador` VARCHAR(45),
  `nombres_jugador` VARCHAR(45),
  PRIMARY KEY (`id_jugador`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_jugador_UNIQUE` ON `jugador` (`id_jugador` ASC) ;


-- -----------------------------------------------------
-- Table `historico_jugadores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `_historico_jugadores` ;

CREATE  TABLE IF NOT EXISTS `historico_jugadores` (
  `id_jugador` INT NOT NULL ,
  `id_equipo` INT NOT NULL ,
  `año_historico_jugadores` INT NOT NULL ,
  `numero_historico_jugadores` INT NOT NULL ,
  CONSTRAINT `id_jugador_historico_jugadores`
    FOREIGN KEY (`id_jugador` )
    REFERENCES `jugador` (`id_jugador` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_equipo_historico_jugadores`
    FOREIGN KEY (`id_equipo` )
    REFERENCES `equipo` (`id_equipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_jugador_idx` ON `historico_jugadores` (`id_jugador` ASC) ;

CREATE INDEX `id_equipo_idx` ON `historico_jugadores` (`id_equipo` ASC) ;


-- -----------------------------------------------------
-- Table `historico_equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `historico_equipo` ;

CREATE  TABLE IF NOT EXISTS `historico_equipo` (
  `id_historico_equipo` INT NOT NULL AUTO_INCREMENT ,
  `año_historico_equipo` INT NULL ,
  `id_equipo` INT NOT NULL ,
  PRIMARY KEY (`id_historico_equipo`) ,
  CONSTRAINT `id_equipo_historico_equipo`
    FOREIGN KEY (`id_equipo` )
    REFERENCES `equipo` (`id_equipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_historico_UNIQUE` ON `historico_equipo` (`id_historico_equipo` ASC) ;

CREATE UNIQUE INDEX `id_equipo_UNIQUE` ON `historico_equipo` (`id_equipo` ASC) ;


-- -----------------------------------------------------
-- Table `arbitro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `arbitro` ;

CREATE  TABLE IF NOT EXISTS `arbitro` (
  `id_arbitro` INT NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_arbitro`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_arbitro_UNIQUE` ON `arbitro` (`id_arbitro` ASC) ;


-- -----------------------------------------------------
-- Table `campeonato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `campeonato` ;

CREATE  TABLE IF NOT EXISTS `campeonato` (
  `id_campeonato` INT NOT NULL ,
  `año` INT NOT NULL ,
  `semestre` INT NOT NULL ,
  PRIMARY KEY (`id_campeonato`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_campeonato_UNIQUE` ON `campeonato` (`id_campeonato` ASC) ;

CREATE UNIQUE INDEX `año_UNIQUE` ON `campeonato` (`año` ASC) ;


-- -----------------------------------------------------
-- Table `partido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `partido` ;

CREATE  TABLE IF NOT EXISTS `partido` (
  `id_partido` INT NOT NULL ,
  `fecha_partido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ciudad_partido` VARCHAR(45) NOT NULL ,
  `estadio` VARCHAR(45) NOT NULL ,
  `goles_local` INT NOT NULL ,
  `goles_visitante` INT NOT NULL ,
  `id_local` INT NOT NULL ,
  `id_visitante` INT NOT NULL ,
  `id_arbitro` INT NOT NULL ,
  `id_campeonato` INT NOT NULL ,
  PRIMARY KEY (`id_partido`) ,
  CONSTRAINT `id_local_partido`
    FOREIGN KEY (`id_local` )
    REFERENCES `equipo` (`id_equipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_visitante_partido`
    FOREIGN KEY (`id_visitante` )
    REFERENCES `equipo` (`id_equipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_arbitro_partido`
    FOREIGN KEY (`id_arbitro` )
    REFERENCES `arbitro` (`id_arbitro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_campeonato_partido`
    FOREIGN KEY (`id_campeonato` )
    REFERENCES `campeonato` (`id_campeonato` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_partido_UNIQUE` ON `partido` (`id_partido` ASC) ;

CREATE INDEX `id_local_idx` ON `partido` (`id_local` ASC) ;

CREATE INDEX `id_visitante_idx` ON `partido` (`id_visitante` ASC) ;

CREATE INDEX `id_arbitro_idx` ON `partido` (`id_arbitro` ASC) ;

CREATE UNIQUE INDEX `id_campeonato_UNIQUE` ON `partido` (`id_campeonato` ASC) ;


-- -----------------------------------------------------
-- Table `gol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gol` ;

CREATE  TABLE IF NOT EXISTS `gol` (
  `id_gol` INT NOT NULL ,
  `minuto` INT NOT NULL ,
  `id_partido` INT NOT NULL ,
  `id_jugador` INT NOT NULL ,
  PRIMARY KEY (`id_gol`) ,
  CONSTRAINT `id_partido_gol`
    FOREIGN KEY (`id_partido` )
    REFERENCES `partido` (`id_partido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_jugador_gol`
    FOREIGN KEY (`id_jugador` )
    REFERENCES `jugador` (`id_jugador` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_partido_UNIQUE` ON `gol` (`id_partido` ASC) ;

CREATE INDEX `id_jugador_idx` ON `gol` (`id_jugador` ASC) ;


-- -----------------------------------------------------
-- Table `posiciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `posiciones` ;

CREATE  TABLE IF NOT EXISTS `posiciones` (
  `posicion` INT NOT NULL,
  `puntaje` INT NOT NULL ,
  `id_campeonato` INT NOT NULL ,
  `id_equipo` INT NOT NULL ,
  CONSTRAINT `id_campeonato_posiciones`
    FOREIGN KEY (`id_campeonato` )
    REFERENCES `campeonato` (`id_campeonato` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_equipo_posiciones`
    FOREIGN KEY (`id_equipo` )
    REFERENCES `equipo` (`id_equipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_campeonato_idx` ON `posiciones` (`id_campeonato` ASC) ;

CREATE INDEX `id_equipo_idx` ON `posiciones` (`id_equipo` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

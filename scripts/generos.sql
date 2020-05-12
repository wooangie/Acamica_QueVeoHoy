
CREATE TABLE `peliculas`.`genero` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


ALTER TABLE `peliculas`.`pelicula` 
ADD COLUMN `genero_id` INT NULL AFTER `trama`;


ALTER TABLE `peliculas`.`pelicula` 
ADD INDEX `pelicula-genero_idx` (`genero_id` ASC) VISIBLE;
ALTER TABLE `peliculas`.`pelicula` 
ADD CONSTRAINT `pelicula-genero`
  FOREIGN KEY (`genero_id`)
  REFERENCES `peliculas`.`genero` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

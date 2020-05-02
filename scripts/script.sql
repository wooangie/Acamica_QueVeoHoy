#creación de BBDD
CREATE DATABASE peliculas;

#ingreso a BBDD
USE peliculas;


#creación de tabla película
CREATE TABLE pelicula(
    id INT NOT NULL auto_increment,
    titulo VARCHAR(100) NOT NULL,
    duracion INT,
    director VARCHAR(400),
    anio INT,
    fecha_lanzamiento DATE,
    puntuacion INT,
    poster VARCHAR(300),
    trama VARCHAR(700),
    PRIMARY KEY (id)
);


#creación de tabla género
CREATE TABLE genero(
    id INT NOT NULL auto_increment,
    nombre VARCHAR (30),
    PRIMARY KEY (id)
);


#Se agrega la columna genero_id a la tabla película
ALTER TABLE pelicula 
ADD COLUMN genero_id INT NOT NULL;


#Se crea la FK que relaciona las tablas película y género
ALTER TABLE `peliculas`.`genero` 
ADD CONSTRAINT `genero_id`
  FOREIGN KEY (`id`)
  REFERENCES `peliculas`.`pelicula` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


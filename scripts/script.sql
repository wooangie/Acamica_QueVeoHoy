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


# Se agrega la información de la tabla pelicula con el comando source


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


# Se agrega la información de la tabla genero con el comando source

#creación de tabla actor
CREATE TABLE actor(
    id INT NOT NULL auto_increment,
    nombre VARCHAR (70),
    PRIMARY KEY (id)
);

#creación de tabla actor_pelicula que vincula las tablas actor y película
CREATE TABLE actor_pelicula(
    id INT NOT NULL auto_increment,
    actor_id INT NOT NULL,
    pelicula_id INT NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE `peliculas`.`actor_pelicula` 
ADD INDEX `id_idx` (`actor_id` ASC) VISIBLE;
;
ALTER TABLE `peliculas`.`actor_pelicula` 
ADD CONSTRAINT `id`
  FOREIGN KEY (`actor_id`)
  REFERENCES `peliculas`.`actor` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

#Creo la FK para relacionar las tablas actor_pelicula con actor
ALTER TABLE actor_pelicula 
ADD FOREIGN KEY (actor_id) REFERENCES actor(id);

#Creo la FK para relacionar las tablas actor_pelicula con pelicula
ALTER TABLE actor_pelicula 
ADD FOREIGN KEY (pelicula_id) REFERENCES pelicula(id);

#Corro el script para llenar la tabla de actores


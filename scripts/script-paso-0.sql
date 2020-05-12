
CREATE DATABASE peliculas;

USE peliculas;


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





CREATE TABLE genero(
    id INT NOT NULL auto_increment,
    nombre VARCHAR (30),
    PRIMARY KEY (id)
);



ALTER TABLE pelicula
ADD COLUMN genero_id INT;



ALTER TABLE `peliculas`.`genero` 
ADD CONSTRAINT `genero_id`
  FOREIGN KEY (`id`)
  REFERENCES `peliculas`.`pelicula` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;



CREATE TABLE actor(
    id INT NOT NULL auto_increment,
    nombre VARCHAR (70),
    PRIMARY KEY (id)
);


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

ALTER TABLE actor_pelicula 
ADD FOREIGN KEY (actor_id) REFERENCES actor(id);


ALTER TABLE actor_pelicula 
ADD FOREIGN KEY (pelicula_id) REFERENCES pelicula(id);



ALTER TABLE `que-veo-hoy`.`actor`  CHANGE COLUMN `nombre` `nombre_actor` VARCHAR(70) NULL DEFAULT NULL ;
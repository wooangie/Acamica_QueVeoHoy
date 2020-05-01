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
ADD COLUMN genero_id INT NOT NULL;

ALTER TABLE pelicula 
ADD FOREIGN KEY (genero_id) REFERENCES genero(id);
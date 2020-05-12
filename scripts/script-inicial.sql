CREATE DATABASE peliculas;
USE peliculas;

CREATE TABLE pelicula(
    id  INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    duracion INT,
    director VARCHAR(400) NOT NULL,
    anio INT,
    fecha_lanzamiento DATE,
    puntuacion INT,
    poster VARCHAR(300),
    trama VARCHAR(700),
    PRIMARY KEY (id));

    
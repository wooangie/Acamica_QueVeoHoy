var con = require ('../lib/conexionbd');

/*
//función que trae todas las películas de la guía 1
function traerPelis(req, res){
    let sql = 'SELECT * FROM pelicula'
    con.query(sql, function (error, resultado, fields){
        if(error) {
            console.log ('Hubo un error en la consulta', error.message);
            return res.status(404).send ('Hubo un error en la consulta');
        }
        
        var response = {
            'peliculas': resultado
        }
        console.log ('Se enviaron todas las películas');
        res.send (JSON.stringify(response));
    });
};*/


//función que trae todas las películas según filtros de la guía 2
function traerPelisFiltradas(req, res){
    let anio = req.query.anio;
    let titulo = req.query.titulo;
    let genero_id = req.query.genero;
    let columna_orden = req.query.columna_orden;
    let tipo_orden = req.query.tipo_orden;
    let pagina = req.query.pagina;
    let cantidad = 20;
    
    let sqlParcial = 'SELECT * FROM pelicula '

    //armo la query para los filtros de anio, título y/o género
    if(anio || titulo || genero_id){
        sqlParcial += 'WHERE '

        if (anio) {
            sqlParcial += 'anio = ' + anio;
        };
    
        if (titulo) {
            if(anio) {
                sqlParcial += ' and '
            };
            sqlParcial += 'titulo LIKE "%' + titulo +'%"';
        };

        if (genero_id){
            if (anio || titulo) {
                sqlParcial += ' and '
            };
            sqlParcial += 'genero_id = ' + genero_id;
        };
    };

    //sumo a la query el orden (que siempre viene por default) por columna y tipo
    sqlParcial += ' ORDER BY ' + columna_orden + ' ' + tipo_orden + ' LIMIT ' + (pagina-1)*cantidad + ',' + cantidad;

    console.log (sqlParcial);
    con.query(sqlParcial, function (error, resultado, fields){
        if(error) {
            console.log ('Error en la consulta: ', error.message);
            return res.status(404).send ('Hubo un error en la consulta');
        };

        var response = {
            'peliculas': resultado
        };
        console.log ('Se enviaron todas las películas filtradas');
        res.send (JSON.stringify(response));
    });
};




function traerGeneros(req, res){
    let sql = 'SELECT * FROM genero'
    con.query(sql, function (error, resultado, fields){
        if(error) {
            console.log ('Error en la consulta: ', error.message);
            return res.status(404).send ('Hubo un error en la consulta');
        }
        console.log (resultado);
        var response = {
            'generos': resultado
        }
        res.send (JSON.stringify(response));
    });
};


function mostrarPeli(req, res){
    let idPelicula = req.params.id;
    //Con esta query traigo toda la información de la peli y de los actores
    //Con este SQL obtengo el género pero no los actores (me da undefined)
    //let sql = 'SELECT * FROM actor JOIN actor_pelicula ON actor_id = actor.id JOIN pelicula ON pelicula_id = pelicula.id JOIN genero ON genero_id = genero.id WHERE pelicula.id = ' + idPelicula;
    let sql = 'SELECT * FROM pelicula JOIN genero ON pelicula.genero_id = genero.id JOIN actor_pelicula ON actor_pelicula.pelicula_id = pelicula.id JOIN actor ON actor.id = actor_pelicula.actor_id WHERE pelicula.id =' +idPelicula
    //Con este SQL obtengo el array de actores pero me ingresa el primero por género y me aparece actores como undefined
    //let sql = 'SELECT * FROM pelicula JOIN genero ON genero_id = genero.id JOIN actor_pelicula ON pelicula_id = pelicula.id JOIN actor on actor_id = actor.id WHERE pelicula.id = ' + idPelicula;

    con.query(sql, function(error, resultado, fields){
        if(error) {
            console.log ('Error en la consulta: ', error.message);
            return res.status(404).send ('Hubo un error en la consulta');
        }

        console.log(resultado);
        let pelicula = resultado[0];
        let genero = resultado[0].nombre;
        //Pendiente: Hay que crear un array de actores (Ahora sale como undefined en el front, porque dentro del array de actores sólo están sus ids y no sus nombres).
        let actores = [];
        for (let i = 0; i < resultado.length; i++) {
            actores.push(resultado[i].nombre);
            }
        

        console.log (actores) ;           
        let resultadoGenero = resultado[0].nombre_genero;

        let response = {
            'pelicula': resultado[0],
            'actores': resultado,
            'genero': resultadoGenero
        };
        res.send (JSON.stringify(response));
    });
};

function recomendarPeli(req, res){
    let genero = req.query.genero;
    let anio_inicio = req.query.anio_inicio;
    let anio_fin = req.query.anio_fin;
    let puntuacion = req.query.puntuacion;
    console.log (genero, anio_inicio, anio_fin, puntuacion);

    let filtrosRecomendacion = [];
    //Hay que hacer una query parcial con condicionales porque cada categoría manda parámetros diferentes.
    let queryParcial = 'SELECT * FROM genero JOIN pelicula ON genero_id = genero.id'
    
    if (genero || anio_inicio || anio_fin || puntuacion) queryParcial += ' where ';

    if (genero) {
        queryParcial += 'genero.nombre_genero = "' + genero +'"';
    }

    if (anio_inicio) {
        if(genero) queryParcial += ' and ';
        queryParcial += 'pelicula.anio >= ' + anio_inicio;
    }

    if (anio_fin) {
        if(genero || anio_inicio) queryParcial += ' and ';
        queryParcial += 'pelicula.anio <= '+ anio_fin;
    }

    if (puntuacion) {
        if(genero || anio_inicio || anio_fin) queryParcial += ' and ';
        queryParcial += 'pelicula.puntuacion > ' + puntuacion
    }
    console.log (queryParcial);
    con.query(queryParcial, function (error, resultado, fields){
        if(error) {
            console.log ('Error en la consulta: ', error.message);
            return res.status(404).send ('Hubo un error en la consulta');
        }
        
        var response = {
            'peliculas': resultado
        }
        res.send (JSON.stringify(response));
    });

};

module.exports = {
    //traerPelis: traerPelis,
    traerPelisFiltradas: traerPelisFiltradas,
    traerGeneros: traerGeneros,
    mostrarPeli: mostrarPeli,
    recomendarPeli: recomendarPeli,
};
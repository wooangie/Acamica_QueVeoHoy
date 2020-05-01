var con = require ('../lib/conexionbd');

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
        res.send (JSON.stringify(response));
    });
};

module.exports = {
    traerPelis: traerPelis,
};
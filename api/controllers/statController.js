const pool = require('../database/database');

// Récupérer le top 5 des loisirs les mieux notés
exports.getTopLoisir = async (req, res) => {
    try{
        const loisir = await pool.query('SELECT loisir.id, loisir.titre, notation.note, loisir.category_id, category.nom AS category_nom FROM loisir JOIN notation ON loisir.id = notation.loisir_id JOIN category ON loisir.category_id = category.id ORDER BY note DESC LIMIT 5');
        res.status(200).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

exports.getTopLoisirByCategory = async (req, res) => {
    try{
        console.log(req.params.id);
        const loisir = await pool.query('SELECT loisir.category_id, loisir.id, loisir.titre, notation.note, category.nom AS category_nom FROM loisir JOIN notation ON loisir.id = notation.loisir_id JOIN category ON loisir.category_id = category.id WHERE loisir.category_id = ? ORDER BY note DESC LIMIT 5', [req.params.id]);
        res.status(200).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

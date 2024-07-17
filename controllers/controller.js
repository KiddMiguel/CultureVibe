const pool = require('../database/database');


exports.getLoisir = async (req, res) => {
    try{
        const loisir = await pool.query('SELECT * FROM loisir');
        res.status(200).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

exports.getLoisirById = async (req, res) => {
    try{
        const loisir = await pool.query('SELECT * FROM loisir WHERE id = ?', [req.params.id]);
        res.status(200).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

exports.createLoisir = async (req, res) => {
    try{
        const currentDate = new Date().toISOString().split('T')[0];
        const loisir = await pool.query('INSERT INTO loisir (titre, description, date_publication, image, category_id) VALUES (?, ?, ?, ?, ?) RETURNING *', [req.body.titre, req.body.description, currentDate, req.body.image, req.body.category_id]);
        res.status(201).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

// Notation
exports.createNotation = async (req, res) => {
    try{
        const currentDate = new Date().toISOString().split('T')[0];
        const loisir = await pool.query('INSERT INTO notation (note, loisir_id, date_notation) VALUES (?, ?, ?) RETURNING *', [req.body.note, req.body.loisir_id, currentDate]);
        res.status(201).json(loisir.rows);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

exports.getNotation = async (req, res) => {
    try{
        const loisir = await pool.query('SELECT * FROM notation WHERE loisir_id = ?', [req.params.id]);
        res.status(200).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

// CATEGORY

exports.getCategory = async (req, res) => {
    try{
        const loisir = await pool.query('SELECT * FROM category');
        res.status(200).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

exports.getCategoryById = async (req, res) => {
    try{
        const loisir = await pool.query('SELECT * FROM category WHERE id = ?', [req.params.id]);
        res.status(200).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};

exports.createCategory = async (req, res) => {
    try{
        const loisir = await pool.query('INSERT INTO category (nom) VALUES (?) RETURNING *', [req.body.nom]);
        res.status(201).json(loisir);
    }catch(err){
        res.status(400).json({message: err.message});
    }
};
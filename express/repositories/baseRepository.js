const pool = require('../db/pool');
const {Model} = require("sequelize");

class BaseRepository {
  constructor(model) {
    this.model = model;
    this.pool = pool;
  }

  async query(sql, params) {
    const client = await this.pool.connect();
    try {
      const result = await client.query(sql, params);
      return result.rows;
    } finally {
      client.release();
    }
  }

  async findById(id) {
    return await this.model.findByPk(id);
  }

  async merge(data = {}) {
    if (data.id) {
      const entity = await this.model.findByPk(data.id);
      if (entity) {
        return await entity.update(data,
          {
            where: {id: data.id},
          });
      }
    }
    return await this.model.create(data);
  }
}

module.exports = BaseRepository;

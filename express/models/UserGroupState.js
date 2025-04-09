const { Sequelize, DataTypes, Model } = require('sequelize');
const sequelize = require('../db/db');

class Usergroupstate extends Model {}
Usergroupstate.init({
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    label: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
  }, {
    sequelize,
    modelName: 'Usergroupstate',
    tableName: 'usergroupstate',
    underscored: true,
    timestamps: false
  })

module.exports = Usergroupstate;

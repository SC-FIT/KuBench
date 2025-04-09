const {Sequelize, DataTypes, Model} = require('sequelize');
const sequelize = require('../db/db');

class User extends Model {
}

User.init({
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false,
  },
  groupId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'group_id'
  },
  stateId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'state_id'
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  surname: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  login: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  passwd: {
    type: DataTypes.STRING,
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  phone: {
    type: DataTypes.STRING,
  },
  isDsmAdmin: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'is_dsm_admin'
  },
  isGroupAdmin: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'is_group_admin'
  },
  isPlanner: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'is_planner'
  },
  isSupportTech: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'is_support_tech'
  },
  photo: {
    type: DataTypes.STRING,
  },
}, {
  sequelize,
  modelName: 'User',
  tableName: '"user"',
  underscored: true,
  timestamps: false
});

module.exports = User;

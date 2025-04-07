const {DataTypes, Model} = require('sequelize');
const sequelize = require('../db/db');

class Group extends Model {
}

Group.init({
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  name: {
    type: DataTypes.STRING,
  },
  contractSigned: {
    type: DataTypes.DATE, // Use DATE for dates and times
  },
  contractNumber: {
    type: DataTypes.INTEGER,
  },
  instituteName: {
    type: DataTypes.STRING,
  },
  instituteAddressName: {
    type: DataTypes.STRING,
  },
  instituteAddressNumber: {
    type: DataTypes.STRING,
  },
  institutePostalCode: {
    type: DataTypes.STRING,
  },
  province: {
    type: DataTypes.STRING,
  },
  city: {
    type: DataTypes.STRING,
  },
  country: {
    type: DataTypes.STRING,
  },
  vat: {
    type: DataTypes.STRING,
  },
  institutePhone: {
    type: DataTypes.STRING,
  },
  instituteEmail: {
    type: DataTypes.STRING,
  },
  stateId: {
    type: DataTypes.INTEGER,
  },
  priority: {
    type: DataTypes.FLOAT,
  },
}, {
  sequelize,
  modelName: 'Group',
  tableName: '"group"',
  underscored: true, // Use snake_case for column names
  timestamps: false // Assuming you don't have createdAt/updatedAt fields
});

module.exports = Group;

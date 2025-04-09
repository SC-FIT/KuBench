const BaseRepository = require("./baseRepository");
const UserGroupState = require('../models/UserGroupState');

class UserGroupStateRepository extends BaseRepository {
  constructor() {
    super(UserGroupState);
  }
}

module.exports = new UserGroupStateRepository();

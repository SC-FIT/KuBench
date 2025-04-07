const userRepository = require('../repositories/userRepository');

class UserService {
  constructor() {
    this.userRepository = userRepository;
  }

  async complexSelect() {
    return this.userRepository.complexSelect();
  }
}

module.exports = new UserService();

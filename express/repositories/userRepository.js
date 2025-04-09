const pool = require('../db/pool');
const BaseRepository = require("./baseRepository");
const User = require('../models/User');

class UserRepository extends BaseRepository {
  constructor() {
    super(User);
  }

  async complexSelect() {
    const query = `
        SELECT u.id AS user_id,
               g.name AS group_name,
               g.contract_number,
               g.institute_name,
               g.institute_address_name,
               g.city,
               u.name,
               u.surname,
               u.login,
               u.email,
               u.phone,
               s.label AS status_name,
               u.is_dsm_admin,
               u.is_group_admin,
               u.is_planner,
               u.is_support_tech,
               u.photo
        FROM public."user" u
                 JOIN public.usergroupstate s ON u.state_id = s.id
                 JOIN public."group" g ON u.group_id = g.id
    `;

    return await this.query(query);
  }
}

module.exports = new UserRepository();

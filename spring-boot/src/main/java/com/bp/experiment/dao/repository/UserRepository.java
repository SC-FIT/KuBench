package com.bp.experiment.dao.repository;

import java.util.List;
import java.util.Map;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.bp.experiment.dao.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

     @Query(
            value = """
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
                       FROM ((public."user" u
                         JOIN public.usergroupstate s ON ((u.state_id = s.id)))
                         JOIN public."group" g ON ((u.group_id = g.id)))
                    """,
            nativeQuery = true)
    List<Map<String, Object>> complexSelectTest();
}
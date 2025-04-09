package com.bp.experiment.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.bp.experiment.dao.model.Usergroupstate;

@Repository
public interface UsergroupstateRepository extends JpaRepository<Usergroupstate, Integer> {
}
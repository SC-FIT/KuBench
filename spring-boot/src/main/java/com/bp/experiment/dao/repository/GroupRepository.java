package com.bp.experiment.dao.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.bp.experiment.dao.model.Group;

@Repository
public interface GroupRepository extends JpaRepository<Group, Integer> {
}
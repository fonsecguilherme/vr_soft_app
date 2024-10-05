package com.academic.api.repositories;

import com.academic.api.models.StudentModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentsRepository extends JpaRepository<StudentModel, Long> {
}

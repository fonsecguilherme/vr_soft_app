package com.academic.api.repositories;

import com.academic.api.models.CourseModel;
import com.academic.api.models.CourseStudentModel;
import com.academic.api.models.StudentModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface EnrollRepository extends JpaRepository<CourseStudentModel, Long> {
    Optional<CourseStudentModel> findByAlunoAndCurso(StudentModel aluno, CourseModel curso);
}

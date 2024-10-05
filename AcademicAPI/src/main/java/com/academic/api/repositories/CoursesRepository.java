package com.academic.api.repositories;

import com.academic.api.models.CourseModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CoursesRepository extends JpaRepository<CourseModel, Long> {
}

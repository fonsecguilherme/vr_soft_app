package com.academic.api.controllers;

import com.academic.api.dtos.CourseDTO;
import com.academic.api.models.CourseModel;
import com.academic.api.models.CourseStudentModel;
import com.academic.api.models.StudentModel;
import com.academic.api.repositories.CoursesRepository;
import com.academic.api.repositories.EnrollRepository;
import com.academic.api.repositories.StudentsRepository;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/enroll")
public class EnrollController {
    final CoursesRepository coursesRepository;
    final StudentsRepository studentsRepository;
    final EnrollRepository enrollRepository;

    public EnrollController(CoursesRepository coursesRepository, StudentsRepository studentsRepository, EnrollRepository enrollRepository) {
        this.coursesRepository = coursesRepository;
        this.studentsRepository = studentsRepository;
        this.enrollRepository = enrollRepository;
    }

    @PostMapping("/assign_student")
    public ResponseEntity<Object> assignStudent(@RequestParam Long courseId, @RequestParam Long studentId) {
        Optional<CourseModel> courseModelOptional = coursesRepository.findById(courseId);
        Optional<StudentModel> studentModelOptional = studentsRepository.findById(studentId);

        if (courseModelOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não foi encontrado um curso cadastrado com este id");
        }

        if (studentModelOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não foi encontrado um estudante cadastrado com este id");
        }

        var courseStudentModel = new CourseStudentModel();

        courseStudentModel.setAluno(studentModelOptional.get());
        courseStudentModel.setCurso(courseModelOptional.get());

        return ResponseEntity.status(HttpStatus.OK).body(enrollRepository.save(courseStudentModel));
    }

    @DeleteMapping("/remove_student")
    public ResponseEntity<Object> removeStudent(@RequestParam Long courseId, @RequestParam Long studentId) {
        Optional<CourseModel> courseModelOptional = coursesRepository.findById(courseId);
        Optional<StudentModel> studentModelOptional = studentsRepository.findById(studentId);

        if (courseModelOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não foi encontrado um curso cadastrado com este id");
        }

        if (studentModelOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não foi encontrado um estudante cadastrado com este id");
        }

        Optional<CourseStudentModel> enrollmentOptional = enrollRepository.findByAlunoAndCurso(
                studentModelOptional.get(), courseModelOptional.get());

        if (enrollmentOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("O aluno não está matriculado neste curso.");
        }

        enrollRepository.delete(enrollmentOptional.get());

        return ResponseEntity.status(HttpStatus.OK).body("Aluno removido do curso com sucesso.");
    }
}

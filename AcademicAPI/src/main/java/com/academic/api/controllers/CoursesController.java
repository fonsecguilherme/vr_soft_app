package com.academic.api.controllers;

import com.academic.api.dtos.CourseDTO;
import com.academic.api.models.CourseModel;
import com.academic.api.repositories.CoursesRepository;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/courses")
public class CoursesController {
    final CoursesRepository repository;

    public CoursesController(CoursesRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/get_all")
    public ResponseEntity<Object> getAllCourses() {
        return ResponseEntity.status(HttpStatus.OK).body(repository.findAll());
    }

    @PostMapping("/save")
    public ResponseEntity<Object> save(@RequestBody @Valid CourseDTO courseDTO) {
        var courseModel = new CourseModel();
        BeanUtils.copyProperties(courseDTO, courseModel);
        return ResponseEntity.status(HttpStatus.CREATED).body(repository.save(courseModel));
    }

    @PutMapping("/update_by_id")
    public ResponseEntity<Object> save(@RequestParam Long id, @RequestBody @Valid CourseDTO courseDTO) {
        Optional<CourseModel> courseModelOptional = repository.findById(id);

        if (courseModelOptional.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body("Não foi encontrado um curso cadastrado com este id");
        }

        var courseModel = new CourseModel();
        BeanUtils.copyProperties(courseDTO, courseModel);
        courseModel.setCodigo(courseModelOptional.get().getCodigo());

        return ResponseEntity.status(HttpStatus.OK).body(repository.save(courseModel));
    }

    @DeleteMapping("/delete_by_id")
    public ResponseEntity<Object> delete(@RequestParam Long id) {
        Optional<CourseModel> courseModelOptional = repository.findById(id);
        boolean studentNotLinkedToCourse;

        if (courseModelOptional.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body("Não foi encontrado um curso cadastrado com este id");
        }

        if (!courseModelOptional.get().getAlunos().isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.CONFLICT)
                    .body("Não é possível excluir o curso porque existem alunos matriculados.");
        }

        repository.delete(courseModelOptional.get());

        return ResponseEntity.status(HttpStatus.OK).body("Curso excluído com sucesso");
    }
}

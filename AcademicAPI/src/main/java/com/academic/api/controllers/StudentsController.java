package com.academic.api.controllers;

import com.academic.api.dtos.StudentDTO;
import com.academic.api.models.StudentModel;
import com.academic.api.repositories.StudentsRepository;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/students")
public class StudentsController {
    final StudentsRepository repository;

    public StudentsController(StudentsRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/get_all")
    public ResponseEntity<Object> getAllStudents() {
        return ResponseEntity.status(HttpStatus.OK).body(repository.findAll());
    }

    @PostMapping("/save")
    public ResponseEntity<Object> save(@RequestBody @Valid StudentDTO studentDTO) {
        var studentModel = new StudentModel();
        BeanUtils.copyProperties(studentDTO, studentModel);
        return ResponseEntity.status(HttpStatus.CREATED).body(repository.save(studentModel));
    }

    @PutMapping("/update_by_id")
    public ResponseEntity<Object> save(@RequestParam Long id, @RequestBody @Valid StudentDTO studentDTO) {
        Optional<StudentModel> studentModelOptional = repository.findById(id);

        if (studentModelOptional.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body("Não foi encontrado um estudante cadastrado com este id");
        }

        var studentModel = new StudentModel();
        BeanUtils.copyProperties(studentDTO, studentModel);
        studentModel.setCodigo(studentModelOptional.get().getCodigo());

        return ResponseEntity.status(HttpStatus.OK).body(repository.save(studentModel));
    }

    @DeleteMapping("/delete_by_id")
    public ResponseEntity<Object> delete(@RequestParam Long id) {
        Optional<StudentModel> studentModelOptional = repository.findById(id);

        if (studentModelOptional.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body("Não foi encontrado um estudante cadastrado com este id");
        }

        if (!studentModelOptional.get().getCursos().isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.CONFLICT)
                    .body("Não é possível excluir o estudante porque ele está matriculado em um ou mais cursos.");
        }

        repository.delete(studentModelOptional.get());

        return ResponseEntity.status(HttpStatus.OK).body("Estudante excluído com sucesso");
    }
}

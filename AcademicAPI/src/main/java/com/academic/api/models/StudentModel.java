package com.academic.api.models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "aluno")
public class StudentModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long codigo;

    @Column(nullable = false, length = 50)
    private String nome;

    @OneToMany(mappedBy = "aluno", cascade = CascadeType.ALL)
    @JsonBackReference
    private List<CourseStudentModel> cursos;
}

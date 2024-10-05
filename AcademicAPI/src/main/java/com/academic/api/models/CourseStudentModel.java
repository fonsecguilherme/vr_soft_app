package com.academic.api.models;

import com.academic.api.models.CourseModel;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "curso_aluno")
public class CourseStudentModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long codigo;

    @ManyToOne
    @JoinColumn(name = "codigo_curso")
    private CourseModel curso;

    @ManyToOne
    @JoinColumn(name = "codigo_aluno")
    private StudentModel aluno;
}

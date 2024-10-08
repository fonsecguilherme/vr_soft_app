package com.academic.api.models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "curso")
public class CourseModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long codigo;

    @Column(nullable = false, length = 50)
    private String descricao;

    @Column(nullable = false)
    @JsonBackReference
    private String ementa;

    @OneToMany(mappedBy = "curso", cascade = CascadeType.ALL)
//    @OneToMany(mappedBy = "curso")
    @JsonBackReference
    private List<CourseStudentModel> alunos;
}

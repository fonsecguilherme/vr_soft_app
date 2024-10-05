package com.academic.api.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseDTO {
    @NotBlank
    @NotEmpty
    private String descricao;

    @NotBlank
    @NotEmpty
    private String ementa;
}

package com.academic.api.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StudentDTO {
    @NotBlank
    @NotEmpty
    private String nome;
}

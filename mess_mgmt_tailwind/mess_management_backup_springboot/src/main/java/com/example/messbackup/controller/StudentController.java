package com.example.messbackup.controller;

import com.example.messbackup.model.Student;
import com.example.messbackup.repository.StudentRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentController {
    private final StudentRepository repo;
    public StudentController(StudentRepository repo){this.repo = repo;}

    @GetMapping
    public List<Student> all(){ return repo.findAll(); }

    @PostMapping
    public Student create(@RequestBody Student s){ return repo.save(s); }

    @GetMapping("/{id}")
    public Student get(@PathVariable Long id){ return repo.findById(id).orElse(null); }
}

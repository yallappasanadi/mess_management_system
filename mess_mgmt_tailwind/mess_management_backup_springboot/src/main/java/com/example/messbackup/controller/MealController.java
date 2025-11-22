package com.example.messbackup.controller;

import com.example.messbackup.model.Meal;
import com.example.messbackup.repository.MealRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/meals")
public class MealController {
    private final MealRepository repo;
    public MealController(MealRepository repo){this.repo = repo;}

    @GetMapping
    public List<Meal> all(){ return repo.findAll(); }

    @PostMapping
    public Meal add(@RequestBody Meal m){ return repo.save(m); }
}

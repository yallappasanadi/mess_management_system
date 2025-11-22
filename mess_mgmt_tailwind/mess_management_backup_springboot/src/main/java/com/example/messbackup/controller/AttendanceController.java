package com.example.messbackup.controller;

import com.example.messbackup.model.Attendance;
import com.example.messbackup.repository.AttendanceRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/attendance")
public class AttendanceController {
    private final AttendanceRepository repo;
    public AttendanceController(AttendanceRepository repo){this.repo = repo;}

    @GetMapping
    public List<Attendance> all(){ return repo.findAll(); }

    @PostMapping
    public Attendance add(@RequestBody Attendance a){ return repo.save(a); }
}

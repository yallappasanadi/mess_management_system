package com.example.messbackup.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Attendance {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Student student;

    @ManyToOne
    private Meal meal;

    private LocalDateTime entryTime;
    private LocalDateTime exitTime;

    // getters/setters
    public Long getId(){return id;}
    public void setId(Long id){this.id = id;}
    public Student getStudent(){return student;}
    public void setStudent(Student student){this.student = student;}
    public Meal getMeal(){return meal;}
    public void setMeal(Meal meal){this.meal = meal;}
    public LocalDateTime getEntryTime(){return entryTime;}
    public void setEntryTime(LocalDateTime entryTime){this.entryTime = entryTime;}
    public LocalDateTime getExitTime(){return exitTime;}
    public void setExitTime(LocalDateTime exitTime){this.exitTime = exitTime;}
}

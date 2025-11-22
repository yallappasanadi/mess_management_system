package com.example.messbackup;

import com.example.messbackup.model.Attendance;
import com.example.messbackup.model.Meal;
import com.example.messbackup.model.Student;
import com.example.messbackup.repository.AttendanceRepository;
import com.example.messbackup.repository.MealRepository;
import com.example.messbackup.repository.StudentRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class DataLoader implements CommandLineRunner {

    private final StudentRepository studentRepo;
    private final MealRepository mealRepo;
    private final AttendanceRepository attendanceRepo;

    public DataLoader(StudentRepository studentRepo, MealRepository mealRepo, AttendanceRepository attendanceRepo){
        this.studentRepo = studentRepo;
        this.mealRepo = mealRepo;
        this.attendanceRepo = attendanceRepo;
    }

    @Override
    public void run(String... args) throws Exception {
        // sample students
        Student s1 = new Student(); s1.setRollNo("CS2025-01"); s1.setName("Yallappa M Sanadi"); s1.setCourse("CSE"); s1.setStatus("present"); studentRepo.save(s1);
        Student s2 = new Student(); s2.setRollNo("CS2025-02"); s2.setName("Priya K"); s2.setCourse("ECE"); s2.setStatus("present"); studentRepo.save(s2);
        Student s3 = new Student(); s3.setRollNo("CS2025-03"); s3.setName("Rahul S"); s3.setCourse("MECH"); s3.setStatus("absent"); studentRepo.save(s3);

        // meals
        Meal m1 = new Meal(); m1.setName("Breakfast"); m1.setCost(30.0); mealRepo.save(m1);
        Meal m2 = new Meal(); m2.setName("Lunch"); m2.setCost(65.0); mealRepo.save(m2);

        // attendance
        Attendance a1 = new Attendance(); a1.setStudent(s1); a1.setMeal(m2); a1.setEntryTime(LocalDateTime.now().minusHours(5)); a1.setExitTime(LocalDateTime.now().minusHours(1)); attendanceRepo.save(a1);
    }
}

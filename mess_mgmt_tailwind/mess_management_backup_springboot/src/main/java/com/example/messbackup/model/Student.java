package com.example.messbackup.model;

import javax.persistence.*;

@Entity
public class Student {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String rollNo;
    private String name;
    private String course;
    private String roomNo;
    private String phone;
    private String email;
    private String status; // present/absent

    // getters and setters
    public Long getId(){return id;}
    public void setId(Long id){this.id = id;}
    public String getRollNo(){return rollNo;}
    public void setRollNo(String rollNo){this.rollNo = rollNo;}
    public String getName(){return name;}
    public void setName(String name){this.name = name;}
    public String getCourse(){return course;}
    public void setCourse(String course){this.course = course;}
    public String getRoomNo(){return roomNo;}
    public void setRoomNo(String roomNo){this.roomNo = roomNo;}
    public String getPhone(){return phone;}
    public void setPhone(String phone){this.phone = phone;}
    public String getEmail(){return email;}
    public void setEmail(String email){this.email = email;}
    public String getStatus(){return status;}
    public void setStatus(String status){this.status = status;}
}

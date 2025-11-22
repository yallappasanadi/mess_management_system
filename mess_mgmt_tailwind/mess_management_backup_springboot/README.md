Mess Management - Spring Boot backup (serves frontend + APIs)

How to run:
1. Install Java 17 and Maven.
2. From project root run: mvn spring-boot:run
3. Open http://localhost:8080/ to see the frontend served by Spring Boot.
4. APIs:
   GET /api/students
   GET /api/meals
   GET /api/attendance

Local resume file (for reference): /mnt/data/Yallappa_Sanadi(New).pdf

Note: The frontend files are placed under src/main/resources/static so they are served by Spring Boot as static content.

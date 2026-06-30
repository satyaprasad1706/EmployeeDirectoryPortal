# Employee Directory Portal

A modern, web-based Employee Directory Portal designed for administrators and employees. The project demonstrates a complete automated CI/CD pipeline using **Maven**, **Jenkins**, and **Apache Tomcat**, integrated with a **MySQL** database.

---

## 🛠️ Tech Stack & Architecture

* **Backend Logic:** Java 17 (Jakarta EE Namespace)
* **Web Layer:** Servlets & JSP
* **Templates & Styling:** Bootstrap 5, FontAwesome, Vanilla CSS
* **Database:** MySQL (automatic BCrypt password migrations on startup)
* **Build Automation:** Apache Maven 3.x
* **Continuous Integration/Deployment:** Jenkins (Declarative Pipeline with SCM Polling)
* **Servlet Container:** Apache Tomcat 10.x+

---

## 📂 Project Structure

```
EmployeeDirectoryPortal/
├── pom.xml                  # Maven Project Object Model
├── Jenkinsfile              # Jenkins Declarative CI/CD Pipeline
├── sql/
│   └── schema.sql           # Database schema initialization
├── src/
│   ├── main/
│   │   ├── java/com/employee/
│   │   │   ├── controller/   # Web Servlets (Login, Dashboard, Profile, etc.)
│   │   │   ├── dao/          # Database Access Objects
│   │   │   ├── model/        # Data Models (Employee, Admin, Department)
│   │   │   └── util/         # Connection management & BCrypt utilities
│   │   ├── resources/
│   │   │   └── db.properties # Database connection settings
│   │   └── webapp/           # JSP Pages & styling assets (CSS)
│   └── test/
│       └── java/com/employee/# Unit testing suite (JUnit)
```

---

## 🚀 Setup & Local Deployment

### 1. Database Configuration (MySQL)
1. Open your MySQL client and run the database initialization script:
   ```sql
   SOURCE sql/schema.sql;
   ```
2. Open `src/main/resources/db.properties` and verify your MySQL connection credentials:
   ```properties
   db.url=jdbc:mysql://localhost:3306/employee_db
   db.username=YOUR_USERNAME
   db.password=YOUR_PASSWORD
   ```

### 2. Manual Compile & Package
To compile, test, and build the WAR package locally:
```bash
mvn clean package
```
Copy the generated `target/EmployeeDirectoryPortal.war` into your Tomcat `webapps/` folder.

---

## 🤖 CI/CD Automation (Jenkins & Tomcat)

The project includes a `Jenkinsfile` configuring SCM polling every **1 minute**. 

### 1. Tomcat Environment Config
Ensure the environment variable `CATALINA_HOME` is set to your Tomcat installation path on the host computer:
* **Example Variable:** `CATALINA_HOME = C:\path\to\tomcat`

### 2. Jenkins Pipeline Setup
1. Create a new **Pipeline** job in Jenkins.
2. In the configuration, set the definition to **Pipeline script from SCM**.
3. Set SCM to **Git** and enter the repository URL:
   `https://github.com/satyaprasad1706/EmployeeDirectoryPortal.git`
4. Set Branch to `*/main` and Script Path to `Jenkinsfile`.
5. Trigger the build manually once to initialize SCM polling.

---

## 🔑 Login Credentials

| Role | Username (Login ID) | Password | Features Accessible |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `admin123` | Directory CRUD, Search, Analytics, Departments, Attendance, Reports, Settings |
| **Employee**| *Any employee email* | `password123`| Read-only My Profile, Personal Attendance, Settings |

---

## 👥 Authors & Contributors
* **Developer:** satyaprasad1706
* **Email:** satyaprasad1706@gmail.com

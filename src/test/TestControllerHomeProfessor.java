package test;

import bean.ProfessorBean;
import bean.StudentBean;
import database.ProfessorDao;
import database.StudentDao;
import database.query.ProfessorQuery;
import model.*;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import register.ProfessorRegister;
import utils.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

class TestControllerHomeProfessor {

    private static final String geo = "Geografia";
    private Argument arg = new Argument(9999, "test selenium", geo, "4B", 10);
    private int matricola = 1234;
    private Date d = new Date();
    private Grades g = new Grades(1234, "Matematica", 8, "orale", 9999, "Macchina", d);
    private Homework hmw = new Homework(9999, "3B", geo, "Compito 1", d);
    private Absences a = new Absences(1234, "Assenza", d, 0);
    private String classe = "3B";
    private String materia = geo;
    private static final String ERR = "Error";
    private MonthFactory mf = new MonthFactory();


    private Statement mycreateStatement() throws SQLException {
        Statement stmt = null;
        try {
            String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver);

            String password = "password";
            String userName = "root";
            String url = "jdbc:mysql://localhost:3306/project12?serverTimezone=Europe/Rome";
            Connection con = DriverManager.getConnection(url, userName, password);

            stmt =  con.createStatement();
        } catch (Exception e) {
            return null;
        }finally {

            stmt.close();
        }
        return null;
    }


    @Test
    void saveArg() throws Exception {


        Statement stmt = mycreateStatement();

        int result = ProfessorQuery.saveNewArg(stmt, 9999, "4B", "test slemium", geo, 11);
        Assertions.assertTrue(result > 0);
    }

    @Test
     void validateProfessor() throws ToastException {

        Professor p;
        ProfessorBean pb = null;

        try {
            p = ProfessorDao.validate(9999,"pass");

            Assertions.assertNotNull(p);
        } catch (CustomSQLException | CustomException e) {
            throw new ToastException("Login Error",e.getMessage());
        } catch(Exception e){
            throw new ToastException(ERR,e.getMessage());
        }

    }


    @Test
     void getFullRegister() throws ToastException {

        Month m = mf.createMonth(2,2020);
        ProfessorRegister register = new ProfessorRegister();
        register.setCurrentClass(classe);
        register.setCurrentMatter(materia);
        register.setCurrentMonth(m);
        try {
            List<Student> allUserForClass = ProfessorDao.getClasse(classe);
            List<StudentBean> allStudentsBean = new ArrayList<>();
            assert allUserForClass != null;
            for (Student s : allUserForClass) {
                StudentBean sb = new StudentBean();
                sb.setLastname(s.getLastname());
                sb.setName(s.getName());
                sb.setMatricola(s.getMatricola());
                sb.setClasse(s.getClasse());
                allStudentsBean.add(sb);
            }

            allStudentsBean.sort((s1, s2) -> s1.getLastname().compareToIgnoreCase(s2.getLastname()));
            for (StudentBean u : allStudentsBean) {

                List<Grades> temp = register.getMyGrades(u.getMatricola(), m, materia);
                List<Absences> temp2 = register.getAbsences(u.getMatricola(), m);

                if (temp != null) {
                    List<Grades> grades = new ArrayList<>(temp);
                    u.setGrades(grades);
                }
                if (temp2 != null) {
                    List<Absences> absences = new ArrayList<>(temp2);
                    u.setAbsences(absences);
                }


            }
            register.setStudents(allStudentsBean);
            Assertions.assertTrue(register.getStudents().size() >0 );

        } catch (Exception e) {
                throw new ToastException(ERR,"Test fails");
        }
    }
    @Test
    public void save() throws ToastException {
        int result = 0;
        try {
            Statement stmt = mycreateStatement();
            result = ProfessorQuery.saveNewGrades(stmt, g);
        } catch ( SQLException e) {
            throw new ToastException(ERR, e.getMessage());
        }
        Assertions.assertTrue(result > 0);
    }

    @Test
    public void removehmw() throws ToastException {
        int result = 0;
        try {
            Statement stmt = mycreateStatement();
            result = ProfessorQuery.deleteHomework(stmt, hmw.getDescription());

        } catch (SQLException e) {
            throw new ToastException(ERR, e.getMessage());
        }

        Assertions.assertTrue(result > 0);
// non funziona poiche' non esistono homework con description = "Compito 1"
    }

    @Test
    public void saveAbsence() throws ToastException{
        int result = 0;
        try{
            Statement stmt = mycreateStatement();
            result = ProfessorQuery.saveNewAbsences(stmt, a);

        } catch (SQLException e) {
            throw new ToastException(ERR, e.getMessage());
        }

        Assertions.assertTrue(result > 0);

    }

    // Stefan Huma 0257597
        @Test
        void verifyPin() throws ToastException {

            String realPin;
            int id = 1234;
            String pin = "00070";

            try {
                realPin = StudentDao.getPin(id);
                Assertions.assertEquals(true, pin.equals(realPin));

            } catch (CustomSQLException | CustomException e) {
                throw new ToastException(ERR, e.getMessage());


            }
        }

    @Test
     void getMonth() {

        MonthFactory mof = new MonthFactory();
        Month m = null;

        int yearInt = Integer.parseInt("2020");

        int index = Integer.parseInt("4");
        m = mof.createMonth(index, yearInt);

        Assertions.assertNotNull(m);
    }

    @Test
    void deleteAbsence() throws Exception {

        int dayIndex = 10;
        int monthIndex = 2;
        int year = 2020;
        InputController inputCntl = new InputController();
        Date date = inputCntl.generateDate(dayIndex, monthIndex, year);
        int result = ProfessorDao.deleteAbsence(matricola, date);
        Assertions.assertTrue(result > 0);

    }

}
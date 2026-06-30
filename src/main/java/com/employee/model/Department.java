package com.employee.model;

public class Department {
    private String name;
    private String headOfDept;
    private int headcount;
    private String iconClass;

    public Department() {
    }

    public Department(String name, String headOfDept, int headcount, String iconClass) {
        this.name = name;
        this.headOfDept = headOfDept;
        this.headcount = headcount;
        this.iconClass = iconClass;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHeadOfDept() {
        return headOfDept;
    }

    public void setHeadOfDept(String headOfDept) {
        this.headOfDept = headOfDept;
    }

    public int getHeadcount() {
        return headcount;
    }

    public void setHeadcount(int headcount) {
        this.headcount = headcount;
    }

    public String getIconClass() {
        return iconClass;
    }

    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }
}

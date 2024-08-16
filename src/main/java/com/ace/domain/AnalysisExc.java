package com.ace.domain;

import java.util.Date;

public class AnalysisExc {
    private Integer id;
    private String groupName;
    private String columName;
    private String penName;
    private String penGb;
    private Date date;

    // Getters and Setters for all fields

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getColumName() {
        return columName;
    }

    public void setColumName(String columName) {
        this.columName = columName;
    }

    public String getPenName() {
        return penName;
    }

    public void setPenName(String penName) {
        this.penName = penName;
    }

    public String getPenGb() {
        return penGb;
    }

    public void setPenGb(String penGb) {
        this.penGb = penGb;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}

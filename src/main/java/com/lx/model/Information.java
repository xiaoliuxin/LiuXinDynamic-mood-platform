package com.lx.model;

public class Information {
    private String info;
    private User user;

    public Information (){super();}

    public Information(User user) {
        this.user = user;
    }

    public Information(String info) {
        this.info = info;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}

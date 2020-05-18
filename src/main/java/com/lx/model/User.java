package com.lx.model;


import java.util.List;

public class User {

    private Integer userid;//用户id

    private String username;//用户名

    private String password;//密码

    private String headImg;//头像

    private String content;//个签

    private Integer level;//等级

    private Integer coin;//投币

    private Integer exp;//经验值

    private List<Video> videos;//视频

    private Follow follow;//粉丝

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getHeadImg() { return headImg; }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }


    public String getContent() {
        return content;
    }


    public void setContent(String content) {
        this.content = content;
    }


    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getCoin() {
        return coin;
    }


    public void setCoin(Integer coin) {
        this.coin = coin;
    }

    public Integer getExp() {
        return exp;
    }

    public void setExp(Integer exp) {
        this.exp = exp;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public Follow getFollow() {
        return follow;
    }

    public void setFollow(Follow follow) {
        this.follow = follow;
    }


    @Override
    public String toString() {
        return "User{" +
                "userid=" + userid +
                ", videos=" + videos +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", headImg='" + headImg + '\'' +
                ", content='" + content + '\'' +
                ", level=" + level +
                ", coin=" + coin +
                ", exp=" + exp +
                '}';
    }
}
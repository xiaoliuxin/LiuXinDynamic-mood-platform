package com.lx.service;

import com.lx.model.Video;

import java.util.List;

public interface VideoService {
    List <Video> list();
    Video selectByPrimaryKey(Integer vid);
    List<Video> rank_list();
    int praise(Integer vid);
    int giveCoin(Integer vid);
    int Contribution(Video video);
    List<Video> selectVideoByType(Integer typeId);
    int update_vname_type(String vname , Integer typeId,Integer vid);
    int deleteByPrimaryKey(Integer vid);
    int Subtract_praise(Integer vid);
}

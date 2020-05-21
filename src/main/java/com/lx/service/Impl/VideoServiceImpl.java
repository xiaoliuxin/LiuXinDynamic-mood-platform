package com.gph.service.Impl;

import com.gph.dao.VideoMapper;
import com.gph.model.Video;
import com.gph.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VideoServiceImpl implements VideoService {

    @Autowired
    private VideoMapper videoMapper;

    @Override
    public List<Video> list() {
        return videoMapper.list();
    }

    @Override
    public Video selectByPrimaryKey(Integer vid) {
        return videoMapper.selectByPrimaryKey(vid);
    }

    @Override
    public List<Video> rank_list() {
        return videoMapper.rank_list();
    }

    @Override
    public int praise(Integer vid) {
        return videoMapper.praise(vid);
    }

    @Override
    public int giveCoin(Integer vid) {
        return videoMapper.giveCoin(vid);
    }

    @Override
    public int Contribution(Video video) {
        return videoMapper.Contribution(video);
    }

    @Override
    public List<Video> selectVideoByType(Integer typeId) {
        return videoMapper.selectVideoByType(typeId);
    }

    @Override
    public int update_vname_type(String vname, Integer typeId, Integer vid) {
        return videoMapper.update_vname_type(vname,typeId,vid);
    }

    @Override
    public int deleteByPrimaryKey(Integer vid) {
        return videoMapper.deleteByPrimaryKey(vid);
    }

    @Override
    public int Subtract_praise(Integer vid) {
        return videoMapper.Subtract_praise(vid);
    }

}

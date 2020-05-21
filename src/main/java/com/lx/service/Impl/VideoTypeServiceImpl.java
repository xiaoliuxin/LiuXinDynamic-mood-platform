package com.gph.service.Impl;

import com.gph.dao.VideoTypeMapper;
import com.gph.model.VideoType;
import com.gph.service.VideoTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VideoTypeServiceImpl implements VideoTypeService {
    @Autowired
    private VideoTypeMapper videoTypeMapper;

    @Override
    public VideoType selectByPrimaryKey(Integer typeId) {
        return videoTypeMapper.selectByPrimaryKey(typeId);
    }

    @Override
    public List<VideoType> selectAll() {
        return videoTypeMapper.selectAll();
    }
}

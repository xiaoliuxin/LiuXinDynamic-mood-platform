package com.gph.service.Impl;

import com.gph.dao.UserCollectVideoMapper;
import com.gph.model.UserCollectVideo;
import com.gph.service.UserCollectVideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserCollectVideoServiceImpl implements UserCollectVideoService {
    @Autowired
    private UserCollectVideoMapper userCollectVideoMapper;


    @Override
    public Integer user_collect_video_count(Integer vid) {
        return userCollectVideoMapper.user_collect_video_count(vid);
    }

    @Override
    public Integer if_collect(Integer userid, Integer vid) {
        return userCollectVideoMapper.if_collect(userid,vid);
    }

    @Override
    public int collect(UserCollectVideo record) {
        return userCollectVideoMapper.collect(record);
    }

    @Override
    public List<UserCollectVideo> user_collect_videos(Integer userid) {
        return userCollectVideoMapper.user_collect_videos(userid);
    }

    @Override
    public Integer cancel_collect(Integer userid, Integer vid) {
        return userCollectVideoMapper.cancel_collect(userid,vid);
    }
}

package com.gph.service.Impl;

import com.gph.dao.FollowMapper;
import com.gph.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FollowServiceImpl implements FollowService {
    @Autowired
    private FollowMapper followMapper;

    @Override
    public Integer fan_count(Integer follow_id) {
        return followMapper.fan_count(follow_id);
    }

    @Override
    public Integer follow_count(Integer userid) {
        return followMapper.follow_count(userid);
    }

    @Override
    public int follow_user(Integer userid, Integer followId) {
        return followMapper.follow_user(userid,followId);
    }

    @Override
    public Integer select_if_follow(Integer userid, Integer followId) {
        return followMapper.select_if_follow(userid,followId);
    }

    @Override
    public int cancel_follow(Integer userid, Integer followId) {
        return followMapper.cancel_follow(userid,followId);
    }
}

package com.lx.service;

import org.springframework.stereotype.Service;

public interface FollowService {
    Integer fan_count(Integer follow_id);
    Integer follow_count(Integer userid);
    int follow_user(Integer userid,Integer followId);
    Integer select_if_follow(Integer userid,Integer followId);
    int cancel_follow(Integer userid,Integer followId);
}

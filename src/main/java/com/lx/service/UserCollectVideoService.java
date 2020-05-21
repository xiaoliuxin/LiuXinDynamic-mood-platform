package com.lx.service;

import com.lx.model.UserCollectVideo;

import java.util.List;

public interface UserCollectVideoService {
    Integer user_collect_video_count(Integer vid);
    Integer if_collect(Integer userid,Integer vid);
    int collect(UserCollectVideo record);
    List<UserCollectVideo> user_collect_videos(Integer userid);
    Integer cancel_collect(Integer userid,Integer vid);
}

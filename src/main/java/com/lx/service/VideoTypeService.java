lx com.lx.service;

import com.lx.model.VideoType;

import java.util.List;

public interface VideoTypeService {
    VideoType selectByPrimaryKey(Integer typeId);
    List<VideoType> selectAll();
}

package com.lx.dao;

import com.lx.model.Video;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface VideoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table video
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer vid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table video
     *
     * @mbggenerated
     */
    int insert(Video record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table video
     *
     * @mbggenerated
     */
    int insertSelective(Video record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table video
     *
     * @mbggenerated
     */
    Video selectByPrimaryKey(Integer vid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table video
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Video record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table video
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Video record);

    List <Video> list();

    List<Video> rank_list();

    int praise(Integer vid);

    int Subtract_praise(Integer vid);

    int giveCoin(Integer vid);

    int Contribution(Video video);

    List<Video> selectVideoByType(Integer typeId);

    int update_vname_type(@Param("vname")String vname , @Param("typeId")Integer typeId,@Param("vid")Integer vid);


}
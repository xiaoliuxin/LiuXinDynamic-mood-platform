package com.lx.dao;

import com.lx.model.Message;

import java.util.List;

public interface MessageMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated
     */
    int insert(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table message
     *
     * @mbggenerated
     */
    int insertSelective(Message record);

    List<Message> selectMessByVid(Integer vid);

    int sendMess(Message record);

    int deleteMess(Integer messId);
}
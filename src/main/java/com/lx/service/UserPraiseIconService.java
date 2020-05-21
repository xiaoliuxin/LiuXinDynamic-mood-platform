lx com.gph.service;


public interface UserPraiseIconService {
    int praised(Integer userid,Integer vid);

    int Cancel_praised(Integer userid,Integer vid);

    Integer if_praised(Integer userid, Integer vid);
    int add_praise_tab(Integer statePraise, Integer userid , Integer vid);


    int giveCoined( Integer userid , Integer vid); //投币

    Integer if_giveCoin( Integer userid, Integer vid);//判断是否投币

    int add_Coin_tab( Integer stateIcon, Integer userid , Integer vid); //加入投币记录


}

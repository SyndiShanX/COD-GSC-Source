/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\init_cp_mp.gsc
***********************************************/

init() {
  setDvar("_encstr_BEF80B3DEB91A709E3A5D7AF1D", 1);
  setDvar("_encstr_AB840B539C2A6905C9C43D2815", 1);
  anim_init();
  hud_init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    killstreak_init();

  equipment_init();
  perk_init();
  player_init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    vehicle_init();

  game_init();
  spawn_init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    emp_init();

  execution_init();
  entity_init();
  weapons_init();
  damage_init();
  sound_init();
  flares_init();
  shellshock_init();
  bots_init();
  outline_init();
  game_utility_init();
  rank_init();
  _id_14599();
  supers_init();
  gamescore_init();
  pers_init();
  dlog_init();
  getanglesfromsurfacenormal();
  _id_13A9E();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8E8912DB5025E567C1D0B4B0F6693FB73BE8C222", scripts\mp\utility\game::runleanthreadmode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0", scripts\mp\utility\game::lpcfeaturegated);
}

anim_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B68305BA601B07", "_encstr_91360C90E16F51DD2379A28FE580", scripts\mp\anim::anim_player_solo);
}

hud_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88190486BA32", "_encstr_83C20B6E437BBB6A0E63B0E686", scripts\mp\hud_message::showsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18", scripts\mp\hud_util::teamplayercardsplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF", scripts\mp\hud_message::showerrormessage);
}

killstreak_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C5055208731B", scripts\mp\killstreaks\init_mp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23", scripts\mp\utility\killstreak::addtoactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084", scripts\mp\matchdata::logkillstreakevent);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8A490FD94B675969A5C6D89B3A39CA165B", scripts\mp\killstreaks\killstreaks::givekillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B", scripts\mp\utility\killstreak::killstreak_make_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD", scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8", scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF", scripts\mp\utility\killstreak::killstreak_set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B", scripts\mp\utility\killstreak::maxvehiclesallowed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1", scripts\mp\utility\killstreak::currentactivevehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B", scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071", scripts\mp\killstreaks\killstreaks::killstreakhit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2", scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005", scripts\mp\utility\weapon::iskillstreakweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9F8150DE578FB9851B708B9AF43D029220AFD8EFF8257", scripts\mp\utility\killstreak::dodamagetokillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9B521F42FB58EDE38D8D6BA2F0C7FF63C075CDF31BB8F5CF2D63124A18A90F1A40", scripts\mp\utility\killstreak::removefromactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9321A075FDE4B51A11F9170EB0323FDC9C0E5F6A73867FB4BDBBA59", scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB", scripts\mp\killstreaks\mapselect::getselectmappoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656", scripts\mp\killstreaks\mapselect::startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_820E1D2BED4847BA4CC538CC3B68B1A213E2A29CA0378D704E93C25ABA3BF2", scripts\mp\utility\killstreak::setkillstreakcontrolpriority);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0", scripts\mp\killstreaks\killstreaks::_id_14019);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8CFC16C55190EE6B0DAFFAF3F1DFF72290CB5B4CC1507307", scripts\mp\killstreaks\killstreaks::_id_14018);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8D85132BDECDEFA83B1EBF78435B6B4D630FB11BE3", scripts\mp\events::_id_128B3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7", _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbulletpenetration);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8E65136B88A3B4EDC330C74B3236E3C191E981E522", _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1D313E8CA2CDA49BAB3ECD4858794AC161B86B219", scripts\mp\juggernaut::changecirclestateatlowtime);
}

equipment_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_88C5055208731B", scripts\mp\equipment\throwing_knife_mp::throwing_knife_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553", scripts\mp\equipment::takeequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019", scripts\mp\equipment::giveequipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D8516C9550B77083D13DB0832457BEF714BB4D9176042EF", scripts\mp\equipment::getequipmenttableinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8F731006D0383723E08387EFE31FCA75707B", scripts\mp\equipment::allow_equipment);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_B2231AB32BD18AB85D2D07DAB29BE8252BCC194EBDB5752B16E0DEE6", scripts\mp\equipment::getequipmentreffromweapon);
}

entity_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3", scripts\mp\utility\entity::touchingbadtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9B560FC8B236165E51B9D111CA36568E59", scripts\mp\utility\script::delayentdelete);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9267184F4F1D15E3361864D0C49D474580990B65EA01883A4DE2", scripts\mp\utility\entity::istouchingboundstrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9BBD0F018F51B5CB4590429ADDA67F6A80", _encstr_B61624E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247681AABB108A76E69176AD678FCF23A::triggereliminatedoverlay);
}

perk_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA", scripts\mp\utility\perk::_hasperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD", scripts\mp\utility\perk::removeperk);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5", scripts\mp\utility\perk::giveperk);
}

player_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_979D0FE291986D039BF5BF53DBB10A84C8", scripts\mp\utility\player::setusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B864110E58F8B1EB6D271F0B67B6C2E57BE307", scripts\mp\utility\player::clearusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A1750E827BBDD74450E7625D9B304BF7", scripts\mp\utility\player::isusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B2680F276E71EB3A2703FFBBA1636F5123", scripts\mp\utility\player::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A37014CC4ECACA3DB268B7374793B7C6372259135DD9", scripts\mp\utility\player::ai_offhandfiremanager);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AC5D131B65CD2A0258E4BD8538512FD21DFDB74B0F", scripts\mp\utility\player::_freezelookcontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC", scripts\mp\utility\print::printgameaction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8C140CAFEF2FC261305972B65549", scripts\mp\utility\player::isplayerads);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516", scripts\mp\utility\points::giveunifiedpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B807125285B0A9B80472F441202DC7F76301A797", scripts\mp\utility\player::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60", scripts\mp\utility\player::hideminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43", scripts\mp\utility\player::showminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53", scripts\mp\utility\player::getplayersinradius);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56", scripts\mp\utility\player::allow_gesture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56", scripts\mp\utility\player::isreallyalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AD3610BA61F59FCBD03D8B957F2895CB957B", scripts\mp\utility\player::getstancecenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_93E50D674D73B7EB3398D28A7117A2", scripts\mp\utility\player::round_smoke_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_9A3518F86AC669487FC4188CA16BF131ACA33899621EB9803BEB", scripts\mp\class::zombierespawning);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8ACE16618DA287E3384F90A0E345D8E108F26DF6E6EB47CB", scripts\mp\teams::lookupcurrentoperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_958014B1BDDE6DEAC1A7E8D056E43DE02B2785E8DEC9", scripts\mp\teams::lookupotheroperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_87850E106B0CBDECEF034DD6FC175061", scripts\mp\utility\player::unset_relic_trex);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8F7A18C5ACC333A18477C1B04FB3DB0FEBD647CF458AE7CB756B", scripts\mp\class::disableclassswapallowed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB", scripts\mp\utility\player::isfriendly);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_ABCD195A3714C6162FB2939E3725B93A598D86D085C68DACCD3B95", _encstr_A99F256E1B4EB4C1E8E697DA38CBB30BD6AC3ABC0E569B7931E4BE5BC2E0865ACD1DB917B3DCB1::updatematchstatushintonnoflag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8463164B976BEB44DB13CA52011B3A4FE506D3C5B8F1FFCA", scripts\mp\equipment\binoculars::get_surface_point);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_99E91506C96A0BC2A122215D97489BCA21EF92C0686FA2", scripts\mp\equipment\binoculars::_encstr_99E91506C96A0BC2A122215D97489BCA23EF92C0686FA2);
}

host_migration_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_88A41A9B8FFFDC1DBA88B1854B25CAC3F89F353FB4339A1B7FFF7BB8", scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_B1BA1DD3A7AAFBAB631250B01F2BE054F88496E1DF9A5D3833CD7799A32E27", scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

vehicle_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_88C5055208731B", scripts\mp\vehicles\vehicle_mp::vehicle_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B", scripts\mp\utility\killstreak::incrementfauxvehiclecount);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A", scripts\mp\utility\killstreak::decrementfauxvehiclecount);
}

game_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8431130BB3EFE811D5E17870BAAED7858F4683F53C", scripts\mp\utility\game::iskillstreakdenied);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0", scripts\mp\utility\game::lpcfeaturegated);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_AFA91575E1F8CD92A54B4B1F2B406909204F2D7E3A2882", scripts\mp\objidpoolmanager::objective_unpin_player);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_A9670B5AB9D489A3352C8E6C1A", scripts\mp\utility\game::ismlgmatch);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", scripts\mp\utility\game::unset_relic_grounded);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB", scripts\mp\utility\game::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_A13E0F3BCAE8A9D5263AB0B595515E0756", scripts\mp\utility\game::round_vehicle_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC", scripts\mp\utility\teams::getenemyteams);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_A15C0D845DEBD4A95C1AC0F93236A3", scripts\mp\utility\game::getotherteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8FE20C82D819FB7FC9699CB1FD91", scripts\mp\utility\teams::getteamdata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841", scripts\mp\objidpoolmanager::createobjective);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8171181E82557B0575B7C210B55711AA646DBD6DA409557F7DF3", scripts\mp\objidpoolmanager::createobjective_engineer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057", scripts\mp\objidpoolmanager::requestobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924", scripts\mp\objidpoolmanager::returnobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_848616BBDB20527C20A8256BC090BFCB8973730B5F568A3B", scripts\mp\movers::handle_moving_platforms);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_B8FC12989F6F28E7BBAFD64545934550C29FE991", scripts\mp\outofbounds::registerentforoob);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8AA50991E565083EF82F9D", scripts\mp\outofbounds::clearoob);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_AA040F90179FF90B9ADA8907F0E153A1ED", scripts\mp\utility\teams::isgameplayteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_BA7714A8BBFD7D30A2DFA8F8B94296071895313315B7", scripts\mp\utility\game::getgametypenumlives);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53", scripts\mp\utility\teams::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_9B511E42FB086CF705E96BA0904FC3264053DAEB29D033BBB601829A393F271C", scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_9223223995D9A5DCE8AC2741360B2F2B27324E58B559AAC1320BE82B1A0B1BC6980B8DB5", scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361", scripts\mp\battlechatter_mp::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820", scripts\mp\utility\print::tutorialprint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_867915EEB52D987CB928C30CF92A443C9D43D3F34B6BB6", scripts\mp\utility\game::setovertimelimitdvar);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_B2BA0E90FAB3215877B4EFF9B907411D", scripts\mp\gamelogic::gethostplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8B711228CE176F916F0B082BEBE4DF3D8F3B596A", _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::disableannouncer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_A75F0924F92F312DBDBA88", scripts\mp\flags::gameflag);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8C0C1084B359B742F821E7033510CBFEA01B", scripts\mp\outofbounds::unset_relic_rocket_kill_ammo);
}

spawn_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B", scripts\mp\spawnlogic::addspawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E8A06F7D987435E", "_encstr_8285169C2BB6DB6759A9E00BBB7388B0E6CE5927D2BDE6B2", scripts\mp\spawnlogic::removespawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E8A06F7D987435E", "_encstr_AAED17502BCAC109F75E158F26CFF18DE072E088A0DD0B2397", scripts\mp\spawnlogic::isspawndangerzonealive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E8A06F7D987435E", "_encstr_A5921E820114982F5891A0D19BBD4369081BC8512F7E76FB1343031F58B17260", scripts\mp\spawnlogic::influencepoint_getcodehandlefromscripthandle);
}

emp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_88C5055208731B", scripts\mp\emp_debuff_mp::emp_debuff_init);
}

execution_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B1100A561EACC6AB3AB47BCD", "_encstr_88C5055208731B", scripts\mp\execution_mp::execution_mp_init);
}

weapons_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_B1870D0FE8B1C262638EEB22F05D59", scripts\mp\weapons::enableburnfx);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AC7F0ED86A22C349BB7536A55A8BF5F9", scripts\mp\weapons::disableburnfx);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_88CE0F4F718B3D408FE0B45E0DBAC6E9BB", scripts\mp\utility\weapon::_launchgrenade);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A1400A6BC2E0AB951683B7B9", scripts\mp\utility\weapon::mapweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_880612DC365BD70912CF58E8D76C63F362DF45DE", scripts\mp\equipment\gas_grenade::gas_createtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695", scripts\mp\utility\weapon::relic_nuketimer_globalthread);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AA501282FAD89F4D8863A73A7B97D251D9B60568", scripts\mp\utility\weapon::getweaponrootname);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_97F718A5B9680A1AA093D26B85395EF49CD456B1DB37230B39F2", scripts\mp\utility\weapon::iscacprimaryorsecondary);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF", scripts\mp\utility\weapon::attachmentmap_tobase);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AFD81716A3470BD8D0B556B9A329B99A958D2B36A316988DAC", scripts\mp\utility\weapon::carriedpunchcard);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_B2201A392BB5C238508E47C2B11ADA56738E412CC995E6A3E4C2DA56", scripts\mp\utility\weapon::_id_12BBB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_8A18169BA045FFF37024F7E4CD1FE785B168016318E9B717", scripts\mp\weapons::savetogglescopestates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_939A0EC23B2BEB6BF863594958C4C51B", scripts\mp\weapons::savealtstates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A58D144BD3C9E18380AE216BF7F91F41F85EF11FC368", scripts\mp\weapons::updatesavedaltstate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A99A17DD18FB41992F39F8B0E28563DF4FBFE75D53C309D117", scripts\mp\weapons::updatetogglescopestate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_BDC20FECB21DAE560B07B7CD3A93EDD51C", scripts\mp\utility\weapon::getweapongroup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1", scripts\mp\utility\weapon::runpubliceventoftype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_8C07101FB3D8AB173783627AEF1F739C7013", scripts\mp\utility\weapon::russianletter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_8BAB0D671B7B1205123A885C12915F", _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type);
}

damage_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_84C817B29003834F7B7D8BAF8EA36FCF61704A9A60B57BAB91", scripts\mp\damage::enqueuecorpsetablefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8CF17F18B73B76D2BBA77EDF37386196B6AFE4A8D50E8FA1B", scripts\mp\damage::dequeuecorpsetablefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA", scripts\mp\damagefeedback::updatedamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24", scripts\mp\damage::onkillstreakkilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_A2CC1636B7B3051D1D1636DA2B27D25AC636E6A39C95C2DA", scripts\mp\damage::logattackerkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_A23615C3AE1239608DF3D0B84FA71925CAD74D5E067AEF", scripts\mp\damage::handledamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8E609117E235AB3F8F877", scripts\mp\utility\damage::_suicide);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_87FE0CE0F3BF3BC10FD6957BA04F", scripts\mp\damagefeedback::hudicontype);
}

sound_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361", scripts\mp\battlechatter_mp::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8260069BDBBACD46", "_encstr_93111DB2997323F390A07B1F78AB95EADF357C6E71871ACF5829735F38A15A", scripts\mp\utility\dialog::playkillstreakdialogonplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9", scripts\mp\battlechatter_mp::_id_1274C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8260069BDBBACD46", "_encstr_8AD1186F4D42A32421F358A8FB52B9CB4ABB667DAF3A5B081FC7", scripts\mp\utility\dialog::playkillstreakusedialog);
}

flares_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4", scripts\mp\killstreaks\flares::flares_handleincomingstinger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6", scripts\mp\killstreaks\flares::flares_reducereserves);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB", scripts\mp\killstreaks\flares::flares_deploy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB", scripts\mp\killstreaks\flares::flares_playfx);
}

shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015", scripts\mp\shellshock::artillery_earthquake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_92761D6280DB958F894DA795579303DC1BAB8A3A50EB4B03C0AE699C7B5823", scripts\mp\shellshock::grenade_earthquakeatposition);
}

bots_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9B9B05A21F601A", "_encstr_954B1A76B28ED79C583719BDDA7D7B57E8372D8C59D71DC2933BCAE8", scripts\mp\bots\bots_killstreaks_remote_vehicle::get_random_outside_target);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9B9B05A21F601A", "_encstr_9BFA11317B1DD789F623E5AF2D37AF91AC1646", scripts\mp\bots\bots_killstreaks_remote_vehicle::bot_body_is_dead);
}

outline_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA", scripts\mp\utility\outline::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_974217BDCBC00CCA609B5FFBFB1EE27D391072CA40B0D1C246", scripts\mp\utility\outline::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075", scripts\mp\utility\outline::outlineenableforteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_86DA1A34AEC8F4AB47D8A53795ACB459BBDADEC8B21B8A730B2663B2", scripts\mp\utility\outline::_hudoutlineviewmodelenable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_A5D21B0DEAC89ED547C696DC95659659BB6BDB91CAB188D2B90BC4C656", scripts\mp\utility\outline::_hudoutlineviewmodeldisable);
}

game_utility_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88220D9C76FAE3CE55CB5868A78CC2", "_encstr_88C5055208731B", scripts\mp\utility\game_utility_mp::game_utility_mp_init);
}

rank_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5", scripts\mp\rank::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F", scripts\mp\rank::giverankxp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3", scripts\mp\rank::scoreeventpopup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_8F1A19CF152BEBC645C80981119B7D8B60075C49BDB3BB0D29A052", scripts\mp\rank::getrankxpmultipliertotal);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_ACA81EE76F689B61FB01B0CB7A69034FE96755602BCB08B1F14D5AE10AC59389", scripts\mp\rank::registerpublicevent);
}

_id_14599() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_911E0B43B819331743309A1E4A", "_encstr_95391FA11885072B29019F807A21E098B66F7D85507B8229289BCB1DE11823AFD0", scripts\mp\weaponrank::getweaponrankxpmultipliertotal);
}

supers_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2", scripts\mp\supers::givesuperpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9", scripts\mp\supers::superusefinished);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_BD9E15AF55CB1EB3C3D5D017DF80C8F036807FED08DF04", scripts\mp\supers::getsuperpointsneeded);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_826B166310C589B9786A118FF71BCF8363A012FA706B1B0A", scripts\mp\supers::hide_plunderboxes);
}

gamescore_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A7220A9F3B90A7CFB6E0334A", "_encstr_869E12CD6AE23780AC77C87853A69D4FABD4C655", scripts\mp\gamescore::trackdebuffassist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A7220A9F3B90A7CFB6E0334A", "_encstr_A50414ABE6E893858D5B885613D59999A0E69B2DCDD1", scripts\mp\gamescore::untrackdebuffassist);
}

pers_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E", scripts\mp\utility\stats::incpersstat);
}

dlog_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8A6705191B7B76", "_encstr_8703140952578998E3C06745F997A8D58B5B60737A8B", scripts\mp\analyticslog::logevent_fieldupgradeexpired);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8A6705191B7B76", "_encstr_9BBE1203BB08753F4D33D29AF83D4BAA88358594", scripts\mp\analyticslog::logevent_killstreakexpired);
}

getanglesfromsurfacenormal() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_BA871030B65C6DB33AB26DCBEC4A2CB162C4", scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8", scripts\cp\vehicles\vehicle_compass_cp::_id_12032);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_8492109210F704EBD8E63C3285018F47D5D8", scripts\cp\vehicles\vehicle_compass_cp::_id_1204A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_83DD143DBD0AF8F5C74291386A37A0B02724B38B25B2", scripts\cp\vehicles\vehicle_compass_cp::_id_12C6E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_92B3146AAD7A42AB56187721804350F281D1FC7DC12A", scripts\cp\vehicles\vehicle_compass_cp::_id_1383B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_923B13D7F1A013534829E5ED4190BF9A9563170765", scripts\cp\vehicles\vehicle_compass_cp::_id_138D5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_87AF07C852A26B705F", scripts\cp\vehicles\vehicle_compass_cp::_id_12061);
}

_id_13A9E() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E570DE81A168BBE8F14D3591153A2", "_encstr_88C5055208731B", scripts\mp\utility\teams::_id_13A9F);
}
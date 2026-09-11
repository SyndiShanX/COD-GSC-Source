/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_speed\mp_m_speed_create_script.gsc
*******************************************************************/

function main(var_0, var_1) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("mp_m_speed_create_script")) {
    return;
  }

  scripts\engine\utility::flag_init("mp_m_speed_create_script");
  var_2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var_0, var_1, var_2);

  if(!scripts\cp\so_trigger::cs_is_starttime()) {
    scripts\cp\so_trigger::endcreatescript(var_2);
    return;
  }
}

function cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1)) {
    var_1 = "stk";
  }

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "mp_m_speed_create_script");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  thread createstructs(level, var_2, var_1);
  thread createtriggers(level, var_2, var_1);

  if(istrue(var_0)) {
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "mp_m_speed_create_script");
    return;
  }

  scripts\cp\so_trigger::wait_for_flags(var_2, "mp_m_speed_create_script");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01_dirt_a";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-355.9, 1522.4, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-332, 1556, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-576, 1384, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-384, 1436, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-256, 1740, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-384, 1436, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-976, 1412, 216), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-256, 1616, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-256, 1740, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-256, 1616, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-316, 1804, 208), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-392, 1496, 88), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-892, 1468, 88), (0, 75, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-316, 1552, 88), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-316, 1804, 88), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-908, 1424, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-392, 1496, 208), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-576, 1384, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-568, 1330, 208), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-628, 1504, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-384, 1316, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-332, 1556, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-628, 1270, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-568, 1444, 208), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-628, 1504, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-956, 1424, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-568, 1444, 88), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-1036, 1472, 216), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-316, 1552, 208), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-892, 1468, 208), (0, 75, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-628, 1270, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-932, 1424, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-976, 1412, 88), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-956, 1424, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-384, 1316, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-1036, 1472, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-908, 1424, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-932, 1424, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "player128x128x8";
  var_0[[var_3]](var_4, var_1, var_2, (-568, 1330, 88), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01_dirt_a";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-603.9, 1305.9, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01_dirt_a";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-604.6, 1465.6, 72), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01_dirt_a";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-933.6, 1389.1, 74), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01";
  var_4.occluder = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-1013.1, 1437.1, 74), (0, 177.67, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01";
  var_4.occluder = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-355.9, 1522.4, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01";
  var_4.occluder = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-604.6, 1465.6, 72), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01";
  var_4.occluder = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-603.9, 1305.9, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01";
  var_4.occluder = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-933.6, 1389.1, 74), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01";
  var_4.occluder = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-929.4, 1440.6, 74), (0, 83.58, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01_dirt_a";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-1013.1, 1437.1, 74), (0, 177.67, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "cosecho_barrier_01_dirt_a";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-929.4, 1440.6, 74), (0, 83.58, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

function createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}
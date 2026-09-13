/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_13b292f93b86d410.gsc
***********************************************/

main(_id_D118031DB9B990AA, _id_CDDA4278F5259F6D) {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("mp_m_speed_create_script")) {
    return;
  }
  scripts\engine\utility::flag_init("mp_m_speed_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_D118031DB9B990AA, _id_CDDA4278F5259F6D, s, "mp_m_speed_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_D118031DB9B990AA, _id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "stk";

  s scripts\common\create_script_utility::strike_setup_arrays(_id_CDDA4278F5259F6D, "mp_m_speed_create_script");
  scripts\common\create_script_utility::cs_init_flags(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread createtriggers(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);

  if(istrue(_id_D118031DB9B990AA))
    level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_m_speed_create_script");
  else
    scripts\common\create_script_utility::wait_for_flags(s, "mp_m_speed_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01_dirt_a";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-355.9, 1522.4, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-332, 1556, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-576, 1384, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-384, 1436, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-256, 1740, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-384, 1436, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-976, 1412, 216), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-256, 1616, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-256, 1740, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-256, 1616, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-316, 1804, 208), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-392, 1496, 88), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-892, 1468, 88), (0, 75, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-316, 1552, 88), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-316, 1804, 88), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-908, 1424, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-392, 1496, 208), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-576, 1384, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-568, 1330, 208), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-628, 1504, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-384, 1316, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-332, 1556, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-628, 1270, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-568, 1444, 208), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-628, 1504, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-956, 1424, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-568, 1444, 88), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1036, 1472, 216), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-316, 1552, 208), (0, 0, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-892, 1468, 208), (0, 75, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-628, 1270, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-932, 1424, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-976, 1412, 88), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-956, 1424, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-384, 1316, 208), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1036, 1472, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-908, 1424, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-932, 1424, 88), (0, 270, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "player128x128x8";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-568, 1330, 88), (0, 180, 90), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01_dirt_a";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-603.9, 1305.9, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01_dirt_a";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-604.6, 1465.6, 72), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01_dirt_a";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-933.6, 1389.1, 74), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01";
  s.occluder = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1013.1, 1437.1, 74), (0, 177.67, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01";
  s.occluder = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-355.9, 1522.4, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01";
  s.occluder = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-604.6, 1465.6, 72), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01";
  s.occluder = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-603.9, 1305.9, 72), (0, 356.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01";
  s.occluder = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-933.6, 1389.1, 74), (0, 176.5, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01";
  s.occluder = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-929.4, 1440.6, 74), (0, 83.58, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01_dirt_a";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1013.1, 1437.1, 74), (0, 177.67, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "cosecho_barrier_01_dirt_a";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-929.4, 1440.6, 74), (0, 83.58, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_structs_complete");
}

createtriggers(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_triggers_complete");
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_dd309a6e2fb4250.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_saba_truckwar_vehiclestructs_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_saba_truckwar_vehiclestructs_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_saba_truckwar_vehiclestructs_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_saba_truckwar_vehiclestructs_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_saba_truckwar_vehiclestructs_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9810, -52270, 728.41), (0, 79.76, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-856.5, -50914.5, 212.23), (0, 157.49, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-11444.5, -48660, 263.97), (0, 337.49, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-26456.5, -52165, 243.97), (0, 67.49, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-39922, -41465.5, 451.93), (0, 12.44, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-24167, -38731.5, 566.58), (0, 145.26, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-35487, -27478.5, 305.5), (0, 145.26, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-53941.5, -16194, 305.5), (0, 10.69, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-23758.5, -22113.5, 390.77), (0, 92.61, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-19499.5, -5020, 219), (0, 2.61, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-33246, -3695, 2738.5), (0, 26.72, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-26806, 7968.5, 2071.11), (0, 355.6, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-49028, -1560, 752.7), (0, 71.15, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-52187, 18758.5, 1122.87), (0, 290.37, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-36136, 20858.5, -363.37), (0, 6.67, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-20641.5, 15413.5, -420.99), (0, 96.67, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-26304, 30744, -242.56), (0, 15.67, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5805, 25592.5, 78.12), (0, 35.99, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7778.5, 52260, 294.1), (0, 292.05, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (8493, 40539, 305), (0, 325.16, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (27445, 31484.5, 773.71), (0, 268.82, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9479, 26809.5, 306), (0, 268.82, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (3065.5, 16153, 506.1), (0, 88.82, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15661, 9663.5, 310.74), (0, 124, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (29018.5, 18797, 310.74), (0, 174.09, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6142, 6867.5, 365.1), (0, 219.1, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4933.5, -11106, 4591.5), (0, 39.1, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3426, -25001, 4184.77), (0, 129.1, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9561.5, -11152.5, 2425.19), (0, 129.1, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13055, -33896, 521.95), (0, 174.36, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1762, -34808, 809.39), (0, 14.9, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9344.5, -23494, 1162.48), (0, 355.41, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (16956, -38242.5, 904.95), (0, 24.63, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (32423, -41965.5, 254.22), (0, 24.63, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31731, -29936, 394.22), (0, 24.63, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (32743, -14108.5, 572.22), (0, 204.63, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (43753, -1130, 848.78), (0, 114.64, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (22575.5, -52386.5, 616.5), (0, 142.68, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (25255.5, 2787.5, 226), (0, 166.46, 0), "mp_truckwar_team_start_spawn");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "saba_truckwar";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (16845, -13729.5, 2929.46), (0, 76.46, 0), "mp_truckwar_team_start_spawn");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}
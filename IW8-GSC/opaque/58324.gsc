/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58324.gsc
***********************************************/

bot_item_matches_purpose() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::bot_landing_spots);
  bot_known_flag_carrier_loc();
  bot_killstreak_setup_func();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_BDC80A5437EAD749519A6068", _calloutmarkerping_isvehicleoccupiedbyenemy::bot_get_stored_custom_classes);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_99BF1103D0D4179DFB42DB03358B930DBDB7A1", ::bot_is_protecting_hq_zone);
  level.restoreweaponstates = scripts\mp\utility\player::getplayersinradius;
  level.little_bird_mg_mp_initspawning = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::little_bird_mg_mp_initmines;
  level._id_13352 = scripts\mp\hud_message::showerrormessage;
  level._id_11A22 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21;
  level.br_pickups_init = scripts\mp\hud_message::showsplash;
  level.br_movingcirclemovedistmin = scripts\mp\utility\perk::_hasperk;
  level.br_pickupdenyalreadyhaveplatepouch = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag;
  level.br_movingcirclegulagcloseoffset = scripts\mp\utility\points::sec_sys_struct_1;
  level.bot_shotguns = _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::get_unique_id;
  level.phase_one_combat = getdvarint("_encstr_99731FBB361DFE7D51D9E8130BC0EF29BDA243A88DE9B583F7FF056FCE70E9A310", 1);
}

bot_known_flag_carrier_loc() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
  var_0.areplayersnear = 60;
  var_1 = getdvarfloat("_encstr_8A58156B32CB50C8EFAF0D2BABD2C80C136901D1AADFFB", 45);

  if(var_1 >= 0)
    var_0._id_12CA1 = var_1;
}

bot_killstreak_setup_func() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

bot_landing_spots(var_0, var_1) {
  var_2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_0, var_1);
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068");
  var_4 = isDefined(var_3) && isDefined(var_3._id_12CA1);

  if(isDefined(var_2) && (istrue(level.phase_one_combat) || var_4))
    var_2.ondeathrespawn = ::bot_koth_think;

  return var_2;
}

bot_koth_think() {
  thread bot_last_loadout_num();
}

bot_last_loadout_num() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_1.ref = var_0.ref;
  var_1.rallypointhealth = var_0.rallypointhealth;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_BDC80A5437EAD749519A6068", var_1, var_2);
}

bot_is_protecting_hq_zone(var_0, var_1, var_2, var_3, var_4) {
  var_0 _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::_id_141FF(var_3.team);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58325.gsc
***********************************************/

startdisabled() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::startfightvo);
  startenemyhelis();
  started_breach_process();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_BE820B53A080CF0245ADFC77B7", _calloutmarkerping_onpingchallenge::start_trap_room_combat);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_99BF1103D0D4179DFB42DB03358B930DBDB7A1", ::startdeliveries);
  level.startpayloadpunish = scripts\mp\utility\perk::_hasperk;
}

startenemyhelis() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
  var_0.areplayersnear = 60;
}

started_breach_process() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

startfightvo(var_0, var_1) {
  var_2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::startexfilchoppers;

  return var_2;
}

startexfilchoppers() {
  thread startfontscale();
}

startfontscale() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_1.ref = var_0.ref;
  var_1.rallypointhealth = var_0.rallypointhealth;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_BE820B53A080CF0245ADFC77B7", var_1, var_2);
}

startdeliveries(var_0, var_1, var_2, var_3, var_4) {
  var_0 _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::_id_141FF(var_3.team);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58325.gsc
***********************************************/

function startdisabled() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_indigo", "spawnCallback", &startfightvo);
  startenemyhelis();
  started_breach_process();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("veh_indigo", &_calloutmarkerping_onpingchallenge::start_trap_room_combat);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_indigo", "endEnterInternal", &startdeliveries);
  level.startpayloadpunish = &scripts\mp\utility\perk::_hasperk;
}

function startenemyhelis() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_indigo", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
  var_0.areplayersnear = 60;
}

function started_breach_process() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("veh_indigo", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

function startfightvo(var_0, var_1) {
  var_2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &startexfilchoppers;
  }

  return var_2;
}

function startexfilchoppers() {
  thread startfontscale();
}

function startfontscale() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_1.ref = var_0.ref;
  var_1.rallypointhealth = var_0.rallypointhealth;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("veh_indigo", var_1, var_2);
}

function startdeliveries(var_0, var_1, var_2, var_3, var_4) {
  var_0 scripts\mp\gametypes\arm::ref_141ff(var_3.team);
}
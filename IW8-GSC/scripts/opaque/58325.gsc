/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58325.gsc
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
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_indigo", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
  var0.areplayersnear = 60;
}

function started_breach_process() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("veh_indigo", 1);
  var0.frontextents = 165;
  var0.backextents = 168;
  var0.leftextents = 57;
  var0.rightextents = 57;
  var0.bottomextents = 35;
  var0.distancetobottom = 50;
  var0.loscheckoffset = (0, 0, 70);
}

function startfightvo(var0, var1) {
  var2 = _calloutmarkerping_onpingchallenge::start_silo_jump_menu(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &startexfilchoppers;
  }

  return var2;
}

function startexfilchoppers() {
  thread startfontscale();
}

function startfontscale() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var1.ref = var0.ref;
  var1.rallypointhealth = var0.rallypointhealth;
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("veh_indigo", var1, var2);
}

function startdeliveries(var0, var1, var2, var3, var4) {
  var0 scripts\mp\gametypes\arm::ref_141ff(var3.team);
}
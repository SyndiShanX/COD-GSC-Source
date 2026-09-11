/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58321.gsc
***********************************************/

function get_last_stand_id() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_mg", "spawnCallback", &get_length_from_table);
  cargo_truck_mp_initmines();
  cargo_truck_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("cargo_truck_mg", &_calloutmarkerping_isdropcrate::get_gunshot_alias);
}

function cargo_truck_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_mg", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function cargo_truck_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cargo_truck_mg", 1);
  var0.frontextents = 165;
  var0.backextents = 168;
  var0.leftextents = 57;
  var0.rightextents = 57;
  var0.bottomextents = 35;
  var0.distancetobottom = 50;
  var0.loscheckoffset = (0, 0, 70);
}

function get_length_from_table(var0, var1) {
  var2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &get_least_used_node_close_to_pos;
  }

  return var2;
}

function get_least_used_node_close_to_pos() {
  thread cargo_truck_mp_waitandspawn();
}

function cargo_truck_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("cargo_truck_mg", var1, var2);
}
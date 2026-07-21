/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\technical_mp.gsc
***********************************************/

technical_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::technical_mp_spawncallback);
  technical_mp_initmines();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_84D70A6B2BEF3C9B30A67164", scripts\cp_mp\vehicles\technical::technical_explode);
}

technical_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

technical_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_84D70A6B2BEF3C9B30A67164", 1);
  var_0.frontextents = 90;
  var_0.backextents = 115;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
  var_0.loscheckoffset = (0, 0, 37);
}

technical_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\technical::technical_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::technical_mp_ondeathrespawncallback;

  return var_2;
}

technical_mp_ondeathrespawncallback() {
  thread technical_mp_waitandspawn();
}

technical_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_1.ref = var_0.ref;
  var_1.rallypointhealth = var_0.rallypointhealth;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_84D70A6B2BEF3C9B30A67164", var_1, var_2);

  if(isDefined(var_3)) {
    if(isDefined(var_1.ref) && istrue(level.userallypointvehicles) && level.userallypointvehicles != 2) {
      var_3.ref = var_1.ref;
      var_3.maxhealth = int(max(var_3.maxhealth, var_1.rallypointhealth));
      var_3.health = var_3.maxhealth;
      scripts\mp\rally_point::rallypointvehicle_activate(var_3);
    }
  }
}
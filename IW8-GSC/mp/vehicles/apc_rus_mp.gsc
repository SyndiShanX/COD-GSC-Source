/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\apc_rus_mp.gsc
***********************************************/

apc_rus_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::apc_rus_mp_spawncallback);
  apc_rus_mp_initmines();
  apc_rus_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_86510C82737817CD40B38B720A15", scripts\cp_mp\vehicles\apc_rus::apc_rus_explode);
}

apc_rus_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_86510C82737817CD40B38B720A15", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
  var_0.areplayersnear = 180;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
    var_0._id_12CA1 = level.c4_obj_and_progress_clear;
}

apc_rus_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_86510C82737817CD40B38B720A15", 1);
  var_0.frontextents = 115;
  var_0.backextents = 110;
  var_0.leftextents = 61;
  var_0.rightextents = 61;
  var_0.bottomextents = 25;
  var_0.distancetobottom = 40;
  var_0.loscheckoffset = (0, 0, 50);
}

apc_rus_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\apc_rus::apc_rus_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::apc_rus_mp_ondeathrespawncallback;

  return var_2;
}

apc_rus_mp_ondeathrespawncallback() {
  thread apc_rus_mp_waitandspawn();
}

apc_rus_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_1.ref = var_0.ref;
  var_1.rallypointhealth = var_0.rallypointhealth;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_86510C82737817CD40B38B720A15", var_1, var_2);

  if(isDefined(var_3)) {
    if(isDefined(var_1.ref) && istrue(level.userallypointvehicles) && level.userallypointvehicles != 2) {
      var_3.ref = var_1.ref;
      var_3.maxhealth = int(max(var_3.maxhealth, var_1.rallypointhealth));
      var_3.health = var_3.maxhealth;
      scripts\mp\rally_point::rallypointvehicle_activate(var_3);
    }
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\apc_rus_mp.gsc
***********************************************/

function apc_rus_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "spawnCallback", &apc_rus_mp_spawncallback);
  apc_rus_mp_initmines();
  apc_rus_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("apc_russian", &scripts\cp_mp\vehicles\apc_rus::apc_rus_explode);
}

function apc_rus_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("apc_russian", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
  var0.areplayersnear = 180;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var0.ref_12ca1 = level.c4_obj_and_progress_clear;
    return;
  }
}

function apc_rus_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("apc_russian", 1);
  var0.frontextents = 115;
  var0.backextents = 110;
  var0.leftextents = 61;
  var0.rightextents = 61;
  var0.bottomextents = 25;
  var0.distancetobottom = 40;
  var0.loscheckoffset = (0, 0, 50);
}

function apc_rus_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\apc_rus::apc_rus_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &apc_rus_mp_ondeathrespawncallback;
  }

  return var2;
}

function apc_rus_mp_ondeathrespawncallback() {
  thread apc_rus_mp_waitandspawn();
}

function apc_rus_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var1.ref = var0.ref;
  var1.rallypointhealth = var0.rallypointhealth;
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("apc_russian", var1, var2);

  if(isDefined(var3)) {
    if(isDefined(var1.ref) && istrue(level.userallypointvehicles) && level.userallypointvehicles != 2) {
      var3.ref = var1.ref;
      var3.maxhealth = int(max(var3.maxhealth, var1.rallypointhealth));
      var3.health = var3.maxhealth;
      scripts\mp\rally_point::rallypointvehicle_activate(var3);
      return;
    }

    return;
  }
}
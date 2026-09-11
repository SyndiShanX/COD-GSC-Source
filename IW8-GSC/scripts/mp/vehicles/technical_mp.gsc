/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\technical_mp.gsc
************************************************/

function technical_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "spawnCallback", &technical_mp_spawncallback);
  technical_mp_initmines();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("technical", &scripts\cp_mp\vehicles\technical::technical_explode);
}

function technical_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("technical", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function technical_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("technical", 1);
  var0.frontextents = 90;
  var0.backextents = 115;
  var0.leftextents = 38;
  var0.rightextents = 38;
  var0.bottomextents = 20;
  var0.distancetobottom = 35;
  var0.loscheckoffset = (0, 0, 37);
}

function technical_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\technical::technical_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &technical_mp_ondeathrespawncallback;
  }

  return var2;
}

function technical_mp_ondeathrespawncallback() {
  thread technical_mp_waitandspawn();
}

function technical_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var1.ref = var0.ref;
  var1.rallypointhealth = var0.rallypointhealth;
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("technical", var1, var2);

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
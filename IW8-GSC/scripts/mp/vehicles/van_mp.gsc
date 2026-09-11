/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\van_mp.gsc
***********************************************/

function van_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("van", "spawnCallback", &van_mp_spawncallback);
  van_mp_initmines();
  van_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("van", &scripts\cp_mp\vehicles\van::van_explode);
}

function van_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("van", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function van_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("van", 1);
  var0.frontextents = 117;
  var0.backextents = 105;
  var0.leftextents = 42;
  var0.rightextents = 42;
  var0.bottomextents = 12;
  var0.distancetobottom = 27;
  var0.loscheckoffset = (0, 0, 55);
}

function van_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\van::van_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &van_mp_ondeathrespawncallback;
  }

  return var2;
}

function van_mp_ondeathrespawncallback() {
  thread van_mp_waitandspawn();
}

function van_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("van", var1, var2);
}
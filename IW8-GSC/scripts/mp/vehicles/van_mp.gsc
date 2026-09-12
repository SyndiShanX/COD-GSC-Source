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
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("van", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function van_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("van", 1);
  var_0.frontextents = 117;
  var_0.backextents = 105;
  var_0.leftextents = 42;
  var_0.rightextents = 42;
  var_0.bottomextents = 12;
  var_0.distancetobottom = 27;
  var_0.loscheckoffset = (0, 0, 55);
}

function van_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\van::van_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &van_mp_ondeathrespawncallback;
  }

  return var_2;
}

function van_mp_ondeathrespawncallback() {
  thread van_mp_waitandspawn();
}

function van_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("van", var_1, var_2);
}
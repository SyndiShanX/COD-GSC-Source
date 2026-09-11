/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\cop_car_mp.gsc
***********************************************/

function cop_car_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "spawnCallback", &cop_car_mp_spawncallback);
  cop_car_mp_initmines();
  cop_car_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("cop_car", &scripts\cp_mp\vehicles\cop_car::cop_car_explode);
}

function cop_car_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cop_car", 1);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cop_car");
  var_0.class = "medium_light";
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function cop_car_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cop_car", 1);
  var_0.frontextents = 92;
  var_0.backextents = 95;
  var_0.leftextents = 30;
  var_0.rightextents = 30;
  var_0.bottomextents = 10;
  var_0.distancetobottom = 25;
  var_0.loscheckoffset = (0, 0, 37);
}

function cop_car_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &cop_car_mp_ondeathrespawncallback;
  }

  return var_2;
}

function cop_car_mp_ondeathrespawncallback() {
  thread cop_car_mp_waitandspawn();
}

function cop_car_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("cop_car", var_1, var_2);
}
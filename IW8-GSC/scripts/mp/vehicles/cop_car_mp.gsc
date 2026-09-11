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
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cop_car", 1);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("cop_car");
  var0.class = "medium_light";
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function cop_car_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cop_car", 1);
  var0.frontextents = 92;
  var0.backextents = 95;
  var0.leftextents = 30;
  var0.rightextents = 30;
  var0.bottomextents = 10;
  var0.distancetobottom = 25;
  var0.loscheckoffset = (0, 0, 37);
}

function cop_car_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &cop_car_mp_ondeathrespawncallback;
  }

  return var2;
}

function cop_car_mp_ondeathrespawncallback() {
  thread cop_car_mp_waitandspawn();
}

function cop_car_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("cop_car", var1, var2);
}
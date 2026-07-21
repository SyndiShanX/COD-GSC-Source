/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\cop_car_mp.gsc
***********************************************/

cop_car_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::cop_car_mp_spawncallback);
  cop_car_mp_initmines();
  cop_car_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_8FE608B268BFF756987D", scripts\cp_mp\vehicles\cop_car::cop_car_explode);
}

cop_car_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8FE608B268BFF756987D", 1);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_8FE608B268BFF756987D");
  var_0.class = "_encstr_A37E0DDAAC8C4B5D5BAF1B2DD91AA3";
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

cop_car_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_8FE608B268BFF756987D", 1);
  var_0.frontextents = 92;
  var_0.backextents = 95;
  var_0.leftextents = 30;
  var_0.rightextents = 30;
  var_0.bottomextents = 10;
  var_0.distancetobottom = 25;
  var_0.loscheckoffset = (0, 0, 37);
}

cop_car_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\cop_car::cop_car_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::cop_car_mp_ondeathrespawncallback;

  return var_2;
}

cop_car_mp_ondeathrespawncallback() {
  thread cop_car_mp_waitandspawn();
}

cop_car_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_8FE608B268BFF756987D", var_1, var_2);
}
/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\cargo_truck_susp_mp.gsc
*******************************************************/

cargo_truck_susp_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "spawnCallback", ::cargo_truck_susp_mp_spawncallback);
  cargo_truck_susp_mp_initmines();
  cargo_truck_susp_mp_initspawning();
  _id_0AC1::_id_1022A("cargo_truck_susp", scripts\cp_mp\vehicles\cargo_truck_susp::cargo_truck_susp_explode);
}

cargo_truck_susp_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

cargo_truck_susp_mp_initmines() {
  var_0 = _id_09E2::_id_10144("cargo_truck_susp", 1);
  var_0._id_5FDC = 165;
  var_0._id_2093 = 168;
  var_0._id_919A = 57;
  var_0._id_C862 = 57;
  var_0._id_2954 = 35;
  var_0._id_4B96 = 50;
  var_0._id_98A0 = (0, 0, 70);
}

cargo_truck_susp_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\cargo_truck_susp::cargo_truck_susp_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::cargo_truck_susp_mp_ondeathrespawncallback;
  }

  return var_2;
}

cargo_truck_susp_mp_ondeathrespawncallback() {
  thread cargo_truck_susp_mp_waitandspawn();
}

cargo_truck_susp_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("cargo_truck_susp", var_1, var_2);
}
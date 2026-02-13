/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\open_jeep_mp.gsc
*************************************************/

open_jeep_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "spawnCallback", ::open_jeep_mp_spawncallback);
  openjeep_mp_initmines();
  open_jeep_mp_initspawning();
  _id_0AC1::_id_1022A("open_jeep", scripts\cp_mp\vehicles\open_jeep::open_jeep_explode);
}

open_jeep_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
}

openjeep_mp_initmines() {
  var_0 = _id_09E2::_id_10144("open_jeep", 1);
  var_0._id_5FDC = 90;
  var_0._id_2093 = 115;
  var_0._id_919A = 38;
  var_0._id_C862 = 38;
  var_0._id_2954 = 20;
  var_0._id_4B96 = 35;
  var_0._id_98A0 = (0, -8, 50);
}

open_jeep_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\open_jeep::open_jeep_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::open_jeep_mp_ondeathrespawncallback;
  }

  return var_2;
}

open_jeep_mp_ondeathrespawncallback() {
  thread open_jeep_mp_waitandspawn();
}

open_jeep_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("open_jeep", var_1, var_2);
}
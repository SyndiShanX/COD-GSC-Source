/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3097.gsc
**************************************/

_id_5CC5() {
  self._id_5CC3 = spawnStruct();
  self._id_5CC3._id_1E2D = 1;
  thread _id_1970();
}

_id_1970() {
  self endon("terminate_ai_threads");
  self endon("death");

  for(;;) {
    _id_136C9();

    if(!_id_FF26()) {
      continue;
    }
    wait(randomfloatrange(1, 3));

    if(self._id_AEDF.locked)
      _id_51FA();
  }
}

_id_FF26() {
  if(randomint(100) < 100 * level._id_D127._id_68AB._id_5BE3)
    return 1;
  else
    return 0;
}

_id_51FA() {
  var_0 = (1500, 0, 0);
  var_1 = spawnVehicle("veh_mil_air_un_jackal_02", "player_attack_drone_anchor", "jackal_un", level._id_D127.origin + rotatevector(var_0, level._id_D127.angles), level._id_D127.angles);
  _id_0BDC::_id_1994(level._id_D127, var_0, 200, 1.0, 500, 1.0);
}

_id_136C9() {
  self endon("terminate_ai_threads");
  self endon("death");
  self waittill("player_is_locked");
}
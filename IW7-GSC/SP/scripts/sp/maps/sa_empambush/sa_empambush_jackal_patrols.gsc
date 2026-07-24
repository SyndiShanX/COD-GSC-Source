/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_empambush\sa_empambush_jackal_patrols.gsc
************************************************************************/

_id_963E() {
  var_0 = getcsplineidarray("jackal_carrier_patrol");
  var_1 = getcsplineidarray("jackal_carrier_spotlight_patrol");
  var_2 = scripts\sp\utility::_id_8200("carrier_patrol_jackal", "targetname");
  level._id_C9AA = scripts\engine\utility::getStructArray("spotlight_sweep", "targetname");
  level._id_C988 = [];
  level._id_C988["standard"] = [];
  level._id_C988["spotlight"] = [];

  foreach(var_4 in var_0) {
    wait(randomfloat(3.0));
    var_2.origin = getcsplinepointposition(var_4, 0);
    var_5 = var_2 scripts\sp\utility::_id_10808();
    var_5 setModel("veh_mil_air_ca_jackal_drone_space_periph");
    scripts\engine\utility::waitframe();
    var_5 _id_0BDC::_id_19A0(1);
    var_5 thread _id_0BDC::_id_A1EF(var_4);
    var_5 thread _id_A5FC("emp_set");
    level._id_C988["standard"][level._id_C988["standard"].size] = var_5;
  }

  foreach(var_4 in var_1) {
    wait(randomfloat(3.0));
    var_2.origin = getcsplinepointposition(var_4, 0);
    var_5 = var_2 scripts\sp\utility::_id_10808();
    var_5 setModel("veh_mil_air_ca_jackal_drone_space_periph");
    scripts\engine\utility::waitframe();
    var_5 _id_0BDC::_id_19A0(1);
    var_5 _id_0BDC::_id_A1EF(var_4);
    var_5 thread _id_10A88(level._id_C9AA);
    var_5 thread _id_A5FC("emp_set");
    level._id_C988["spotlight"][level._id_C988["spotlight"].size] = var_5;
  }
}

_id_A5FC(var_0) {
  self endon("death");
  level waittill(var_0);
  self delete();
}

_id_10A88(var_0) {
  self endon("death");

  for(;;)
    _id_0F0F::_id_E801(var_0);
}
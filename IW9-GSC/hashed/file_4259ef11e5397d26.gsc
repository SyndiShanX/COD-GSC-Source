/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4259ef11e5397d26.gsc
***********************************************/

main() {
  thread _id_EB2293B70441DBD1();
}

_id_EB2293B70441DBD1() {
  level waittill("scriptables_ready");
  level._id_095AEBCC57E23EDE = spawnStruct();
  level._id_095AEBCC57E23EDE._id_96DCF9646FEFF0E6 = getentitylessscriptablearray("gas_light_switch", "script_noteworthy");
  level._id_095AEBCC57E23EDE._id_AE5E779B4B6119DE = getentitylessscriptablearray("fan_light_switch", "script_noteworthy");
  level._id_095AEBCC57E23EDE._id_62E604471CC34A17 = getentitylessscriptablearray("door_light_switch", "script_noteworthy");
  _id_F16C69AF355C40FB();
}

_id_F16C69AF355C40FB() {
  level._id_095AEBCC57E23EDE._id_30E7E06B222E209E = [];
  level._id_095AEBCC57E23EDE._id_30E7E06B222E209E[0] = getentitylessscriptablearray("platform1_light_switch", "script_noteworthy");
  level._id_095AEBCC57E23EDE._id_30E7E06B222E209E[1] = getentitylessscriptablearray("platform2_light_switch", "script_noteworthy");
  level._id_095AEBCC57E23EDE._id_30E7E06B222E209E[2] = getentitylessscriptablearray("platform3_light_switch", "script_noteworthy");
}

_id_6A27C9C7590D9DA8(state) {
  if(!isDefined(level._id_095AEBCC57E23EDE._id_96DCF9646FEFF0E6)) {
    return;
  }
  if(state > 3) {
    return;
  }
  _id_53709E15B972FF84 = "state" + scripts\engine\utility::string(state);

  foreach(light_switch in level._id_095AEBCC57E23EDE._id_96DCF9646FEFF0E6)
  light_switch setscriptablepartstate("base", _id_53709E15B972FF84);
}

_id_F3F4B8824C7FF680(state) {
  if(!isDefined(level._id_095AEBCC57E23EDE._id_AE5E779B4B6119DE)) {
    return;
  }
  if(state > 2) {
    return;
  }
  _id_53709E15B972FF84 = "state" + scripts\engine\utility::string(state);

  foreach(light_switch in level._id_095AEBCC57E23EDE._id_AE5E779B4B6119DE)
  light_switch setscriptablepartstate("base", _id_53709E15B972FF84);
}

_id_E28646C2F17F9535(state) {
  if(!isDefined(level._id_095AEBCC57E23EDE._id_62E604471CC34A17)) {
    return;
  }
  if(state > 2) {
    return;
  }
  _id_53709E15B972FF84 = "state" + scripts\engine\utility::string(state);

  foreach(light_switch in level._id_095AEBCC57E23EDE._id_62E604471CC34A17)
  light_switch setscriptablepartstate("base", _id_53709E15B972FF84);
}

_id_EA1AB6036EC27A06(state, index) {
  if(!isDefined(level._id_095AEBCC57E23EDE._id_30E7E06B222E209E) && !isDefined(level._id_095AEBCC57E23EDE._id_30E7E06B222E209E[index])) {
    return;
  }
  if(state > 2) {
    return;
  }
  _id_53709E15B972FF84 = "state" + scripts\engine\utility::string(state);

  foreach(light_switch in level._id_095AEBCC57E23EDE._id_30E7E06B222E209E[index])
  light_switch setscriptablepartstate("base", _id_53709E15B972FF84);
}

_id_E63A4681058E4596() {
  level endon("game_ended");
  _id_88A1E444BE76C8BC = getEntArray("trap_room_to_silo_light", "targetname");
  level waittill("breakout_wall_b_wall_blown");

  foreach(light in _id_88A1E444BE76C8BC)
  light setlightintensity(0.0);
}
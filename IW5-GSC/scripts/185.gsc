/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\185.gsc
**************************************/

_id_1944(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(level._id_1945[var_0])) {
    _id_1947(var_1);
    return 0;
  }

  if(level._id_1708[var_1] == var_0) {
    return 0;
  }
  level._id_1708[var_1] = var_0;
  _id_1946(var_0, var_1);
  return 1;
}

_id_1946(var_0, var_1) {
  if(level.player maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    return;
  }
  maps\_audio::_id_1570(var_0, var_1);
}

_id_1947(var_0) {
  level._id_1708[var_0] = "";
  level.player deactivateeq(var_0);
}

_id_1948(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }
  var_3 = 0.05;
  var_4 = var_2 / var_3;
  var_5 = 1 / var_4;

  for(var_6 = 0; var_6 <= 1; var_6 = var_6 + var_5) {
    level.player seteqlerp(var_6, var_0);
    wait(var_3);
  }

  level.player seteqlerp(1, var_0);
}

_id_1949(var_0) {
  if(level.player maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    return;
  }
  maps\_audio_reverb::_id_1465(var_0);
}

_id_194A() {
  maps\_audio_reverb::_id_146B();
}

_id_194B(var_0, var_1, var_2) {
  maps\_audio::_id_1466("ambientDelay called, this is deprecated! Use new preset string tables.");
}

_id_194C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  maps\_audio::_id_1466("ambientEvent called, this is deprecated! Use new preset string tables.");
}

_id_194D(var_0) {
  maps\_audio::_id_1466("ambientEventStart called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
  maps\_utility::_id_194E(var_0);
}

_id_194F(var_0) {
  maps\_audio::_id_1466("start_ambient_event called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
  maps\_utility::_id_194E(var_0);
}

_id_1950(var_0, var_1, var_2, var_3) {
  maps\_utility::_id_1951(var_0, var_1, var_3, var_2);
}
/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\audio.gsc
********************************/

init_audio() {
  if(!isDefined(level.audio)) {
    level.audio = spawnStruct();
  }

  init_reverb();
  level.onplayerconnectaudioinit = ::onplayerconnectaudioinit;
}

onplayerconnectaudioinit() {
  apply_reverb("default");
}

init_reverb() {
  add_reverb("default", "generic", 0.15, 0.9, 2);
}

add_reverb(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  is_roomtype_valid(param_01);
  var_05["roomtype"] = param_01;
  var_05["wetlevel"] = param_02;
  var_05["drylevel"] = param_03;
  var_05["fadetime"] = param_04;
  level.audio.reverb_settings[param_00] = var_05;
}

is_roomtype_valid(param_00) {}

apply_reverb(param_00) {
  if(!isDefined(level.audio.reverb_settings[param_00])) {
    var_01 = level.audio.reverb_settings["default"];
    return;
  }

  var_01 = level.audio.reverb_settings[var_01];
}
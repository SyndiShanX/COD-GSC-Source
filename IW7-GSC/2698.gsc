/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2698.gsc
***************************************/

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

add_reverb(var_00, var_01, var_02, var_03, var_04) {
  var_05 = [];
  is_roomtype_valid(var_01);
  var_5["roomtype"] = var_01;
  var_5["wetlevel"] = var_02;
  var_5["drylevel"] = var_03;
  var_5["fadetime"] = var_04;
  level.audio.reverb_settings[var_00] = var_05;
}

is_roomtype_valid(var_00) {}

apply_reverb(var_00) {
  if(!isDefined(level.audio.reverb_settings[var_00])) {
    var_01 = level.audio.reverb_settings["default"];
  }
  else {
    var_01 = level.audio.reverb_settings[var_00];
  }
}
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

add_reverb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  is_roomtype_valid(var_1);
  var_5["roomtype"] = var_1;
  var_5["wetlevel"] = var_2;
  var_5["drylevel"] = var_3;
  var_5["fadetime"] = var_4;
  level.audio.reverb_settings[var_0] = var_5;
}

is_roomtype_valid(var_0) {}

apply_reverb(var_0) {
  if(!isDefined(level.audio.reverb_settings[var_0])) {
    var_1 = level.audio.reverb_settings["default"];
    return;
  }

  var_1 = level.audio.reverb_settings[var_1];
}
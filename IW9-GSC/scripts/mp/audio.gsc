/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\audio.gsc
***********************************************/

init_audio() {
  if(!isDefined(level.audio))
    level.audio = spawnStruct();

  _id_7AB5B649FA408138::_id_6DCA6F439CA0A74F();
  init_reverb();
  level.onplayerconnectaudioinit = ::onplayerconnectaudioinit;
}

onplayerconnectaudioinit() {
  apply_reverb("default");

  if(getdvarint("scr_thirdperson") == 1)
    setglobalsoundcontext("thirdpersonmode", "on");
}

init_reverb() {
  add_reverb("default", "generic", 0.15, 0.9, 2);
}

add_reverb(name, type, _id_70E492A54C3CA6A3, _id_1549D7DB07806DF8, _id_F69BA8D7B96E8326) {
  _id_382BDA769DA38BC9 = [];
  is_roomtype_valid(type);
  _id_382BDA769DA38BC9["roomtype"] = type;
  _id_382BDA769DA38BC9["wetlevel"] = _id_70E492A54C3CA6A3;
  _id_382BDA769DA38BC9["drylevel"] = _id_1549D7DB07806DF8;
  _id_382BDA769DA38BC9["fadetime"] = _id_F69BA8D7B96E8326;
  level.audio.reverb_settings[name] = _id_382BDA769DA38BC9;
}

is_roomtype_valid(type) {}

apply_reverb(name) {
  if(!isDefined(level.audio.reverb_settings[name]))
    _id_382BDA769DA38BC9 = level.audio.reverb_settings["default"];
  else
    _id_382BDA769DA38BC9 = level.audio.reverb_settings[name];
}
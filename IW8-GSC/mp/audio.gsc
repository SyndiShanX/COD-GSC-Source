/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\audio.gsc
***********************************************/

init_audio() {
  if(!isDefined(level.audio))
    level.audio = spawnStruct();

  init_reverb();
  level.onplayerconnectaudioinit = ::onplayerconnectaudioinit;
  var_0 = scripts\mp\utility\game::unset_relic_grounded();
  var_1 = isDefined(level.script) && (level.script == "_encstr_A3930F8FD35F7A396BA3D6614DF1A0B245" || isstartstr(level.script, "_encstr_A75F0921E8E7B14BBF3AC8"));
  var_2 = var_0 || var_1;

  if(istrue(var_2))
    scripts\mp\utility\sound::besttime("_encstr_91030D1A87EA2B9F3DA965D049D36A");
}

onplayerconnectaudioinit() {
  var_0 = scripts\mp\utility\game::unset_relic_grounded();
  var_1 = level.mapname == "_encstr_A3930F8FD35F7A396BA3D6614DF1A0B245" || isstartstr(level.mapname, "_encstr_A75F0921E8E7B14BBF3AC8");
  var_2 = var_0 || var_1;

  if(istrue(var_0))
    self.nosuspensemusic = 1;

  if(istrue(var_2)) {
    self setsoundsubmix("_encstr_83D50E61A8A7331531AAD8C81253C1AB");
    self setclientdvar("_encstr_8D5C0BE469D4278A26B4137A27", "_encstr_934C0218");
  } else
    self setclientdvar("_encstr_8D5C0BE469D4278A26B4137A27", "_encstr_934C0218");

  apply_reverb("_encstr_8B1608EC43B8D647A113");
}

init_reverb() {
  add_reverb("_encstr_8B1608EC43B8D647A113", "_encstr_979608DF73C8E70B73A1", 0.15, 0.9, 2);
}

add_reverb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  is_roomtype_valid(var_1);
  var_5["_encstr_93F80993DBBDADD12F1CB2"] = var_1;
  var_5["_encstr_B4DE09EE2BE863563BCA63"] = var_2;
  var_5["_encstr_81590957E2235B13536AED"] = var_3;
  var_5["_encstr_93E009A78F89123C6038CF"] = var_4;
  level.audio.reverb_settings[var_0] = var_5;
}

is_roomtype_valid(var_0) {}

apply_reverb(var_0) {
  if(!isDefined(level.audio.reverb_settings[var_0]))
    var_1 = level.audio.reverb_settings["_encstr_8B1608EC43B8D647A113"];
  else
    var_1 = level.audio.reverb_settings[var_0];
}
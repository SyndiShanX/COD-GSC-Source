/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\audio.gsc
***********************************************/

function init_audio() {
  if(!isDefined(level.audio)) {
    level.audio = spawnStruct();
  }

  init_reverb();
  level.onplayerconnectaudioinit = &onplayerconnectaudioinit;
  var_0 = scripts\mp\utility\game::unset_relic_grounded();
  var_1 = isDefined(level.script) && (level.script == "mp_firingrange" || isstartstr(level.script, "mp_audio"));
  var_2 = var_0 || var_1;

  if(istrue(var_2)) {
    scripts\mp\utility\sound::besttime("common_mp_s4");
    return;
  }
}

function onplayerconnectaudioinit() {
  var_0 = scripts\mp\utility\game::unset_relic_grounded();
  var_1 = level.mapname == "mp_firingrange" || isstartstr(level.mapname, "mp_audio");
  var_2 = var_0 || var_1;

  if(istrue(var_0)) {
    self.nosuspensemusic = 1;
  }

  if(istrue(var_2)) {
    self setsoundsubmix("mp_wz_default");
    self setclientdvar("NKSNTLKLON", "0");
  } else {
    self setclientdvar("NKSNTLKLON", "0");
  }

  apply_reverb("default");
}

function init_reverb() {
  add_reverb("default", "generic", 0.15, 0.9, 2);
}

function add_reverb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  is_roomtype_valid(var_1);
  GscBinSkip0(0x2e, "roomtype", var_1);
}

function is_roomtype_valid(var_0) {}

function apply_reverb(var_0) {
  if(!isDefined(level.audio.reverb_settings[var_0])) {
    var_1 = level.audio.reverb_settings["default"];
    return;
  }

  var_1 = level.audio.reverb_settings[var_1];
}
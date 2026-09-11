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
  var0 = scripts\mp\utility\game::unset_relic_grounded();
  var1 = isDefined(level.script) && (level.script == "mp_firingrange" || isstartstr(level.script, "mp_audio"));
  var2 = var0 || var1;

  if(istrue(var2)) {
    scripts\mp\utility\sound::besttime("common_mp_s4");
    return;
  }
}

function onplayerconnectaudioinit() {
  var0 = scripts\mp\utility\game::unset_relic_grounded();
  var1 = level.mapname == "mp_firingrange" || isstartstr(level.mapname, "mp_audio");
  var2 = var0 || var1;

  if(istrue(var0)) {
    self.nosuspensemusic = 1;
  }

  if(istrue(var2)) {
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

function add_reverb(var0, var1, var2, var3, var4) {
  var5 = [];
  is_roomtype_valid(var1);
  GscBinSkip0(0x2e, "roomtype", var1);
}

function is_roomtype_valid(var0) {}

function apply_reverb(var0) {
  if(!isDefined(level.audio.reverb_settings[var0])) {
    var1 = level.audio.reverb_settings["default"];
    return;
  }

  var1 = level.audio.reverb_settings[var1];
}
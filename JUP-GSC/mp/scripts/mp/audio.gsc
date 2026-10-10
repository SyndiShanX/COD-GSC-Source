/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\audio.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\sound;
#namespace audio;

function init_audio() {
  if(!isDefined(level.audio)) {
    level.audio = spawnStruct();
  }

  snd_init();
  init_reverb();
  level.onplayerconnectaudioinit = &onplayerconnectaudioinit;
}

function onplayerconnectaudioinit() {
  apply_reverb("default");

  if(getdvarint(@ "scr_thirdperson") == 1) {
    setglobalsoundcontext("thirdpersonmode", "on");
  }

  self setsoundsubmix("hit_indicator_hipfire");
}

function init_reverb() {
  add_reverb("default", "generic", 0.15, 0.9, 2);
}

function add_reverb(name, type, wetlevel, drylevel, fadetime) {
  assert(isDefined(type));
  assert(isDefined(wetlevel));
  assert(isDefined(drylevel));
  reverb = [];
  is_roomtype_valid(type);
  reverb["roomtype"] = type;
  reverb["wetlevel"] = wetlevel;
  reverb["drylevel"] = drylevel;
  reverb["fadetime"] = fadetime;
  level.audio.reverb_settings[name] = reverb;
}

function is_roomtype_valid(type) {
  switch (type) {
    case #"hash_cb77b3d8a372e08":
    case #"hash_fc258a369439547":
    case #"hash_1b4f1c09bc30f8b7":
    case #"hash_1c5d5131b5fa462e":
    case #"hash_3d9ccd28b21cb88e":
    case #"hash_3e5e0a1ebaebcc7d":
    case #"hash_3f9f17c1662d120a":
    case #"hash_4bdd565aad97d89e":
    case #"hash_4d3e369017db8fda":
    case #"hash_5ff8e011d5b9d1c8":
    case #"hash_67c4c671ba316fb9":
    case #"hash_6929fc3845c34be3":
    case #"hash_8944a3af59c61e8b":
    case #"hash_8a6d0b4f5207c46b":
    case #"hash_9e7f75efc4013b79":
    case #"hash_a1800029963e0fb8":
    case #"hash_af68187c92c7fbc0":
    case #"hash_afe4256f96628234":
    case #"hash_b445759ac0026f01":
    case #"hash_c16009bb5fe873b1":
    case #"hash_dc295829b4ceffa2":
    case #"hash_de1caed68cb47987":
    case #"hash_e991ce5bbbefabf9":
    case #"hash_ed5b5dc2ce86f143":
    case #"hash_f1a23e97c35685da":
    case #"hash_f67bf6cfc4a6bc7a":
      return;
    default:
      assertmsg(type + "<dev string:x150>");
      break;
  }
}

function apply_reverb(name) {
  if(!isDefined(level.audio.reverb_settings[name])) {
    reverb = level.audio.reverb_settings["default"];
    return;
  }

  reverb = level.audio.reverb_settings[name];
}
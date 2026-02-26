/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_gold.csc
***********************************************/

#using script_430de98794e456b;
#using script_49d775adf53f3e10;
#using script_4c3ae065d31d9544;
#using script_50a657242c20890c;
#using script_6243781aa5394e62;
#using script_68732f44626820ed;
#using script_7785d936148d9f8;
#using script_791ecf7869b6b24f;
#using script_7d8e141380aa3f06;
#using script_a28cfdb7ec79c28;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_gold_main_quest;
#using scripts\zm\zm_gold_pap_quest;
#using scripts\zm\zm_gold_util;
#using scripts\zm\zm_gold_ww_quest;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_utility;
#namespace zm_gold;

function autoexec opt_in() {
  level.aat_in_use = 1;
  system::ignore(#"hash_36cdf1547e49b57a");
  zm_intel::function_88645994(#"hash_1367b294390f3ba9", #"hash_6aeeb56daf9669c5", #"hash_483da168d7c978d9", #"hash_7ad762022f44fb97", #"hash_37b19a33841ec0fa");
}

function event_handler[level_init] main(eventstruct) {
  clientfield::register_clientuimodel("player_lives", #"zm_hud", #"player_lives", 1, 2, "int", undefined, 0, 0);
  clientfield::register("toplayer", "" + # "hash_697cae64fbcf81f8", 1, 1, "int", &function_6c117bd1, 0, 0);
  clientfield::register("world", "" + # "hash_7d7dcebcb0511b14", 1, 1, "int", &function_84e68eed, 0, 0);
  clientfield::register("world", "" + # "hash_5368b2aa337a0ec3", 16000, 2, "int", &function_36f11a86, 0, 0);
  clientfield::register("world", "" + # "hash_4c60439fcb3b4056", 16000, 1, "int", &function_d03c22c, 0, 0);
  level.setupcustomcharacterexerts = &setup_personality_character_exerts;
  level.var_d0ab70a2 = # "hash_466c279241bfbf7c";
  level.var_a7c8e7d7 = 1;
  setDvar(#"hash_5e3c0f05d2935beb", 1);
  setDvar(#"hash_190c5373848fa8e6", 1);
  load::main();
  namespace_f7b3ed9::init();
  zm_gold_pap_quest::init();
  namespace_2a67e53::init();
  zm_gold_util::init();
  zm_gold_ww_quest::init();
  zm_gold_main_quest::init();
  namespace_36ebd7e4::init();
  namespace_47809ab2::init();
  namespace_e5d0906e::init();
  namespace_c4d353e7::init();
  namespace_8dac58da::init();
  util::waitforclient(0);
  setsoundcontext("dark_aether", "inactive");
  namespace_8dac58da::function_dcf22669();
  zm_ping::function_5ae4a10c(#"hash_1625d9b97f824726", "orda_end_boss_gold", #"hash_5df52c0e133d3e52", #"hash_73fd41d7b25c7854", undefined, undefined, -700);
  zm_ping::function_5ae4a10c(#"hash_3a0f3a6dbef0284a", "orda_assault_boss_gold", #"hash_5df52c0e133d3e52", #"hash_73fd41d7b25c7854", undefined, undefined, -50);
  level thread function_1493eabf();
}

function function_1493eabf() {
  level waittill(#"sndunlockeesong");
  function_2cca7b47(0, #"musictrack_zm_gold_ee");
}

function setup_personality_character_exerts() {
  level.exert_sounds[1][#"playerbreathinsound"] = "vox_plr_1_exert_sniper_hold";
  level.exert_sounds[2][#"playerbreathinsound"] = "vox_plr_2_exert_sniper_hold";
  level.exert_sounds[3][#"playerbreathinsound"] = "vox_plr_3_exert_sniper_hold";
  level.exert_sounds[4][#"playerbreathinsound"] = "vox_plr_4_exert_sniper_hold";
  level.exert_sounds[1][#"playerbreathoutsound"] = "vox_plr_1_exert_sniper_exhale";
  level.exert_sounds[2][#"playerbreathoutsound"] = "vox_plr_2_exert_sniper_exhale";
  level.exert_sounds[3][#"playerbreathoutsound"] = "vox_plr_3_exert_sniper_exhale";
  level.exert_sounds[4][#"playerbreathoutsound"] = "vox_plr_4_exert_sniper_exhale";
  level.exert_sounds[1][#"playerbreathgaspsound"] = "vox_plr_1_exert_sniper_gasp";
  level.exert_sounds[2][#"playerbreathgaspsound"] = "vox_plr_2_exert_sniper_gasp";
  level.exert_sounds[3][#"playerbreathgaspsound"] = "vox_plr_3_exert_sniper_gasp";
  level.exert_sounds[4][#"playerbreathgaspsound"] = "vox_plr_4_exert_sniper_gasp";
  level.exert_sounds[1][#"meleeswipesoundplayer"] = "vox_plr_1_exert_punch_give";
  level.exert_sounds[2][#"meleeswipesoundplayer"] = "vox_plr_2_exert_punch_give";
  level.exert_sounds[3][#"meleeswipesoundplayer"] = "vox_plr_3_exert_punch_give";
  level.exert_sounds[4][#"meleeswipesoundplayer"] = "vox_plr_4_exert_punch_give";
}

function function_6c117bd1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_f58e42ae(fieldname, 1);
    return;
  }

  function_f58e42ae(fieldname, 0);
}

function function_4fd00e1f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!isDefined(level.var_3630f9c0)) {
    level.var_3630f9c0 = [];
  }

  var_47c85523 = self getentitynumber();
  var_e534cbe9 = 0;

  if(isDefined(level.var_3630f9c0[var_47c85523][fieldname])) {
    killfx(fieldname, level.var_3630f9c0[var_47c85523][fieldname]);
    level.var_3630f9c0[var_47c85523][fieldname] = undefined;
    var_e534cbe9 = 1;
  }

  if(bwastimejump > 0) {
    if(!var_e534cbe9) {
      self playSound(fieldname, #"hash_79a78504d4dbaf3f");
    }

    if(self zm_utility::function_f8796df3(fieldname)) {
      if(bwastimejump == 1) {
        str_fx = # "hash_679d39e5fd4eae19";
      } else if(bwastimejump == 2) {
        str_fx = # "hash_1581235a1b9b6071";
      }

      if(viewmodelhastag(fieldname, "tag_flashlight")) {
        level.var_3630f9c0[var_47c85523][fieldname] = playviewmodelfx(fieldname, str_fx, "tag_flashlight");
      }

      if(!isDefined(level.var_3630f9c0[var_47c85523][fieldname])) {
        level.var_3630f9c0[var_47c85523][fieldname] = playviewmodelfx(fieldname, str_fx, "<dev string:x38>");
      }
    } else {
      if(bwastimejump == 1) {
        str_fx = # "hash_153f56ac9d13a399";
      } else if(bwastimejump == 2) {
        str_fx = # "hash_626d3f491b870eb1";
      }

      level.var_3630f9c0[var_47c85523][fieldname] = util::playFXOnTag(fieldname, str_fx, self, "tag_flashlight");
    }

    if(self == function_5c10bd79(fieldname)) {
      util::function_8eb5d4b0(3500, 0);
    }

    return;
  }

  if(var_e534cbe9) {
    self playSound(fieldname, #"hash_13715035b161a0c3");
  }

  if(self == function_5c10bd79(fieldname)) {
    util::function_8eb5d4b0(3500, 2.5);
  }
}

function function_84e68eed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_30b095e = getent(fieldname, "phase_wall_01", "targetname");
  var_de143f71 = getent(fieldname, "phase_wall_02", "targetname");

  if(bwastimejump) {
    var_30b095e playrenderoverridebundle(#"hash_4f98e06b5af6e109");
    var_30b095e function_78233d29(#"hash_4f98e06b5af6e109", "", "Scale", 1);
    var_de143f71 playrenderoverridebundle(#"hash_581f8b6e6995c9c7");
    var_de143f71 function_78233d29(#"hash_581f8b6e6995c9c7", "", "Scale", 1);
    return;
  }

  var_30b095e stoprenderoverridebundle(#"hash_4f98e06b5af6e109");
  var_de143f71 stoprenderoverridebundle(#"hash_581f8b6e6995c9c7");
}

function private function_36f11a86(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  fx_pos = struct::get("cm_pos", "targetname");

  if(bwasdemojump == 1) {
    if(isDefined(level.var_86248265)) {
      stopfx(fieldname, level.var_86248265);
    }

    level.var_78a0366b = playFX(fieldname, #"hash_475a4f50991bd21b", fx_pos.origin, anglesToForward(fx_pos.angles));
    return;
  }

  if(bwasdemojump == 2) {
    if(isDefined(level.var_78a0366b)) {
      stopfx(fieldname, level.var_78a0366b);
    }

    level.var_86248265 = playFX(fieldname, #"hash_5620a6bb92498dcf", fx_pos.origin, anglesToForward(fx_pos.angles));
    return;
  }

  if(isDefined(level.var_86248265)) {
    stopfx(fieldname, level.var_86248265);
  }

  if(isDefined(level.var_78a0366b)) {
    stopfx(fieldname, level.var_78a0366b);
  }
}

function private function_d03c22c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_39b48ddb = struct::get("mq_flsh_lgt_pos", "targetname");
  var_928e2c6a = struct::get("mq_stm_pos", "targetname");

  if(bwasdemojump == 1) {
    level.var_86248265 = playFX(fieldname, #"hash_5cca0097f7a9cd6f", var_39b48ddb.origin, var_39b48ddb.angles);
    playFX(fieldname, #"hash_4434a88296cb704a", var_928e2c6a.origin, var_928e2c6a.angles);
    playSound(fieldname, #"hash_395c68a4d926cb0f", var_928e2c6a.origin);
    return;
  }

  if(isDefined(level.var_86248265)) {
    stopfx(fieldname, level.var_86248265);
  }
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_silver.csc
***********************************************/

#using script_22a36cbdf7e3bd31;
#using script_2c5f2d4e7aa698c4;
#using script_2c6e6e28dd66dcc4;
#using script_60793766a26de8df;
#using script_6243781aa5394e62;
#using script_68732f44626820ed;
#using script_7975a13c504d62ab;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_silver_main_quest;
#using scripts\zm\zm_silver_pap_quest;
#using scripts\zm\zm_silver_sound;
#using scripts\zm\zm_silver_util;
#using scripts\zm\zm_silver_ww_quest;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_intel;
#namespace zm_silver;

function autoexec opt_in() {
  level.aat_in_use = 1;
  level.var_5470be1c = 1;
  zm_intel::function_88645994(#"hash_1650c04a5db4ba64", #"hash_69f1546764fcc948", #"hash_44becc3958fa81a2", #"hash_549a6693186d47cc", #"hash_3c7bf14c75b291f9");
}

function event_handler[level_init] main(eventstruct) {
  clientfield::register_clientuimodel("player_lives", #"zm_hud", #"player_lives", 1, 2, "int", undefined, 0, 0);
  clientfield::register("toplayer", "" + # "minimap_underground", 1, 1, "int", &minimap_underground, 0, 0);
  clientfield::register("toplayer", "" + # "music_underscore", 1, 2, "int", &zm_silver_sound::function_2f3017ad, 0, 0);
  clientfield::register("world", "" + # "hash_5e38b0496d9664bb", 1, 3, "int", &function_ce2c0029, 0, 0);
  clientfield::register("world", "" + # "hash_2690e69916d071d9", 1, 1, "int", &function_49d2af47, 0, 0);
  clientfield::register("toplayer", "" + # "interact_rumble_small", 1, 1, "counter", &interact_rumble_small, 0, 0);
  clientfield::register("toplayer", "" + # "hash_7a769c728c89b6b5", 1, 1, "counter", &function_83c1bbf4, 0, 0);
  clientfield::register("toplayer", "" + # "hash_20d620050345e82", 6000, 1, "int", &function_f16e4af0, 0, 0);
  setsoundcontext("dark_aether", "inactive");
  function_5ea2c6e3("mute_blizzard", 1, 1);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  level.setupcustomcharacterexerts = &setup_personality_character_exerts;
  level.var_a396a670 = 1;
  setDvar(#"player_shallowwaterwadescale", 1);
  setDvar(#"player_waistwaterwadescale", 1);
  setDvar(#"player_deepwaterwadescale", 1);
  setDvar(#"hash_5e3c0f05d2935beb", 1);
  setsaveddvar(#"hash_235cfa4e56938e9c", 100);
  namespace_812a8849::init();
  zm_silver_pap_quest::init_clientfield();
  zm_silver_ww_quest::init();
  zm_silver_main_quest::init();
  zm_silver_util::init();
  zm_silver_sound::init();
  namespace_45690bb8::init();
  load::main();
  util::function_89a98f85();
  namespace_812a8849::function_dcf22669();
}

function function_f16e4af0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setsaveddvar(#"vt_reset", 1);
}

function setup_personality_character_exerts() {
  level.exert_sounds[1][# "playerbreathinsound"] = "vox_plr_1_exert_sniper_hold";
  level.exert_sounds[2][# "playerbreathinsound"] = "vox_plr_2_exert_sniper_hold";
  level.exert_sounds[3][# "playerbreathinsound"] = "vox_plr_3_exert_sniper_hold";
  level.exert_sounds[4][# "playerbreathinsound"] = "vox_plr_4_exert_sniper_hold";
  level.exert_sounds[1][# "playerbreathoutsound"] = "vox_plr_1_exert_sniper_exhale";
  level.exert_sounds[2][# "playerbreathoutsound"] = "vox_plr_2_exert_sniper_exhale";
  level.exert_sounds[3][# "playerbreathoutsound"] = "vox_plr_3_exert_sniper_exhale";
  level.exert_sounds[4][# "playerbreathoutsound"] = "vox_plr_4_exert_sniper_exhale";
  level.exert_sounds[1][# "playerbreathgaspsound"] = "vox_plr_1_exert_sniper_gasp";
  level.exert_sounds[2][# "playerbreathgaspsound"] = "vox_plr_2_exert_sniper_gasp";
  level.exert_sounds[3][# "playerbreathgaspsound"] = "vox_plr_3_exert_sniper_gasp";
  level.exert_sounds[4][# "playerbreathgaspsound"] = "vox_plr_4_exert_sniper_gasp";
  level.exert_sounds[1][# "meleeswipesoundplayer"] = "vox_plr_1_exert_punch_give";
  level.exert_sounds[2][# "meleeswipesoundplayer"] = "vox_plr_2_exert_punch_give";
  level.exert_sounds[3][# "meleeswipesoundplayer"] = "vox_plr_3_exert_punch_give";
  level.exert_sounds[4][# "meleeswipesoundplayer"] = "vox_plr_4_exert_punch_give";
}

function minimap_underground(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_f58e42ae(fieldname, 1);
    return;
  }

  function_f58e42ae(fieldname, 0);
}

function on_localplayer_spawned(localclientnum) {
  var_337eb9fb = self clientfield::get_to_player("" + # "minimap_underground");
  function_f58e42ae(localclientnum, var_337eb9fb);
}

function function_ce2c0029(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 0:
      var_92d85419 = 1;
      var_312d65d1 = 8;
      var_68f7ce2e = 1;
      e_player = getlocalplayers()[fieldname];
      e_player thread function_33593a44(fieldname, var_312d65d1, var_68f7ce2e);
      level notify(#"hash_1f7ec9fe70a9f7a6");
      var_2de789b = 0.1;
      var_2d090e03 = 0.5;
      e_player thread function_65490f35(fieldname, var_2de789b, var_2d090e03);
      function_5ea2c6e3("mute_blizzard", 30, 1);
      break;
    case 1:
      var_92d85419 = 1;
      var_312d65d1 = 1;
      var_68f7ce2e = 8;
      e_player = getlocalplayers()[fieldname];
      e_player thread function_33593a44(fieldname, var_312d65d1, var_68f7ce2e);
      level notify(#"hash_1f7ec9fe70a9f7a6");
      var_2de789b = 0.5;
      var_2d090e03 = 0.1;
      e_player thread function_65490f35(fieldname, var_2de789b, var_2d090e03);
      function_ed62c9c2("mute_blizzard", 30);
      break;
    case 2:
      level notify(#"dog_round_start");
      level notify(#"hash_1f7ec9fe70a9f7a6");
      e_player = getlocalplayers()[fieldname];
      var_2de789b = 0.1;
      var_2d090e03 = 0.5;
      e_player thread function_65490f35(fieldname, var_2de789b, var_2d090e03);
      function_5ea2c6e3("mute_blizzard", 8, 1);
      break;
    case 3:
      function_be93487f(fieldname, 9, 0, 0, 0, 1);
      level notify(#"hash_2c882601b007c0f6");
      level notify(#"hash_1f7ec9fe70a9f7a6");
      e_player = getlocalplayers()[fieldname];
      var_2de789b = 0.1;
      var_2d090e03 = 0.1;
      e_player thread function_65490f35(fieldname, var_2de789b, var_2d090e03);
      function_ed62c9c2("mute_blizzard", 8);
      level.var_25fd57f3 = 0;
      level.var_653fb8f8 = 1;
      break;
    case 5:
      e_player = getlocalplayers()[fieldname];
      var_2de789b = 0.5;
      var_2d090e03 = 0.5;
      e_player thread function_65490f35(fieldname, var_2de789b, var_2d090e03);
      break;
  }
}

function private function_65490f35(localclientnum, var_2de789b, var_2d090e03, n_time = 30) {
  level endon(#"hash_1f7ec9fe70a9f7a6");
  n_blend = n_time;

  while(true) {
    if(var_2de789b > var_2d090e03) {
      var_2de789b = var_2d090e03 + (var_2de789b - var_2d090e03) * n_blend / n_time;
    } else {
      var_2de789b = var_2d090e03 - (var_2d090e03 - var_2de789b) * n_blend / n_time;
    }

    playfxoncamera(localclientnum, #"hash_23d6b62d29256be");
    wait var_2de789b;
    n_blend -= var_2de789b;
  }
}

function private function_33593a44(localclientnum, var_312d65d1, var_68f7ce2e, n_time = 30) {
  self notify("631b2f6e33ea09d6");
  self endon("631b2f6e33ea09d6");
  level endon(#"dog_round_start", #"hash_2c882601b007c0f6");
  n_blend = 0;
  n_increment = 1 / n_time / 0.016;

  if(var_312d65d1 == 1 && var_68f7ce2e == 8) {
    while(n_blend < 1) {
      function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 1 - n_blend, 0, 0, n_blend);
      n_blend += n_increment;
      level.var_25fd57f3 = 1 - n_blend;
      level.var_653fb8f8 = n_blend;
      wait 0.016;
    }

    return;
  }

  if(var_312d65d1 == 8 && var_68f7ce2e == 1) {
    while(n_blend < 1) {
      function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, n_blend, 0, 0, 1 - n_blend);
      n_blend += n_increment;
      level.var_25fd57f3 = n_blend;
      level.var_653fb8f8 = 1 - n_blend;
      wait 0.016;
    }

    level.var_25fd57f3 = undefined;
    level.var_653fb8f8 = undefined;
  }
}

function function_49d2af47(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    forcestreamxmodel(#"p9_fxanim_zm_ndu_essence_bomb_body_mod");
    return;
  }

  stopforcestreamingxmodel(#"p9_fxanim_zm_ndu_essence_bomb_body_mod");
}

function interact_rumble_small(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, #"hash_4d00b479eeadce8d");
  }
}

function function_83c1bbf4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, #"hash_a8e842ba4e72dc5");
  }
}
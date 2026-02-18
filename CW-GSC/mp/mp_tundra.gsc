/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_tundra.gsc
***********************************************/

#using script_67ce8e728d8f37ba;
#using script_72d96920f15049b8;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_tundra;

function autoexec function_7defddbd() {
  str_gametype = util::get_game_type();

  if(str_gametype === # "vip" || str_gametype === # "zsurvival") {
    setgametypesetting(#"hash_3a15393c2e90e121", 1);
  }
}

function event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
  killstreaks::function_8c83a621("straferun", #"hash_32c02123dd00c261");
}

function event_handler[level_init] main(eventstruct) {
  level.levelkothdisable = [];
  level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (-898, 2710, 180), 0, 50, 150);
  level.levelwardisable = [];
  level.levelwardisable[level.levelwardisable.size] = spawn("trigger_radius", (-898, 2710, 180), 0, 50, 150);
  str_gametype = util::get_game_type();

  if(!function_559de4b9(str_gametype)) {
    hidemiscmodels("5v5_asset_boundary");
  } else {
    level.var_633063a5 = 1;
  }

  if(str_gametype === "zsurvival") {
    level.var_b8c0d7a2 = 3500;
    level.var_e6b49685 = 3000;
  }

  function_8993980();
  namespace_66d6aa44::function_3f3466c9();
  killstreaks::function_257a5f13("straferun", 60);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  callback::on_game_playing(&on_game_playing);
  callback::on_end_game(&on_end_game);
  load::main();
  compass::setupminimap("");
  setDvar(#"hash_7b06b8037c26b99b", 150);
  level flag::wait_till("first_player_spawned");
  level thread function_e33449fd();
  level thread function_29584e41();
  function_e8fa58f2();
  function_564698fd();
}

function function_e8fa58f2() {
  hidemiscmodels("magicbox_zbarrier");
  hidemiscmodels("hordehunt_corpses_1");
  hidemiscmodels("hordehunt_corpses_2");
}

function function_564698fd() {
  gametype = function_be90acca(util::get_game_type());

  if(gametype === "zsurvival") {
    level.var_29cfe9dd = 0;
    namespace_e8c18978::function_d887d24d("chopper_gunner_vol_tundra_1");
    namespace_e8c18978::function_d887d24d("chopper_gunner_vol_tundra_2");
    level flag::set(#"hash_3070ff342f14b371");
  }
}

function function_8993980() {
  str_gametype = util::get_game_type();

  if(str_gametype == "vip") {
    var_87e54151 = getEntArray("script_vehicle", "classname");

    foreach(var_59cf64fa in var_87e54151) {
      if(!isDefined(var_59cf64fa.scriptvehicletype) || var_59cf64fa.scriptvehicletype == "player_tank") {
        var_59cf64fa delete();
      }
    }
  }
}

function on_game_playing() {
  str_gametype = util::get_game_type();

  if(function_559de4b9(str_gametype)) {
    hidemiscmodels("turret_model");
    exploder::exploder("fxexp_tundra_6v6");
    return;
  }

  var_5b84b22c = getEntArray("tundra_oob_clip", "targetname");

  foreach(var_ec7dad0 in var_5b84b22c) {
    if(isDefined(var_ec7dad0)) {
      var_ec7dad0 delete();
    }
  }

  var_3359f998 = arraycombine(getEntArray("5v5_asset_boundary", "targetname"), getEntArray("5v5_asset_boundary", "script_noteworthy"), 0, 0);

  foreach(var_8da7cb3 in var_3359f998) {
    if(isDefined(var_8da7cb3)) {
      var_8da7cb3 delete();
    }
  }

  exploder::exploder("exp_lgt_12v12");
}

function function_559de4b9(str_gametype) {
  a_tokens = strtok(str_gametype, "_");

  switch (a_tokens[0]) {
    case # "koth":
    case # "sas":
    case # "spy":
    case # "prop":
    case # "control":
    case # "dm":
    case # "sd":
    case # "conf":
    case # "scream":
    case # "oic":
    case # "dom":
    case # "dropkick":
    case # "gun":
    case # "tdm":
    case # "clean":
    case # "infect":
      var_f710be30 = 1;
      break;
    default:
      var_f710be30 = 0;
      break;
  }

  return var_f710be30;
}

function on_end_game() {
  if(getdvarint(#"hash_5cfa659178399dc6", 0)) {
    level scene::function_1e327c20(array("cin_mp_tundra_outro_cia", "cin_mp_tundra_outro_kgb"));
  }
}

function function_e33449fd() {
  rope_bridge_trig = getent("rope_bridge_trig", "targetname");
  rope_bridge_trig callback::on_trigger(&function_95ec9598);
}

function function_95ec9598(var_3a72e7b7) {
  player = var_3a72e7b7.activator;

  if(isDefined(self) && isalive(player) && !is_true(self.activated) && player function_64fefea()) {
    level endon(#"game_ended");
    scene = struct::get(#"hash_2467352290a052f7", "scriptbundlename");
    bridge = scene.scene_ents[# "prop 1"];
    self.activated = 1;
    level thread scene::play(#"hash_2467352290a052f7", "Shot 2");

    while(self function_86072b19()) {
      waitframe(1);
    }

    bridge waittill(#"loop_done", #"death");

    if(function_acf0ca42() && !function_86072b19()) {
      level thread scene::stop(#"hash_2467352290a052f7");
    } else if(!function_acf0ca42()) {
      level thread scene::play(#"hash_2467352290a052f7", "Shot 1");
    }

    self.activated = 0;
  }
}

function function_86072b19() {
  foreach(player in getplayers()) {
    if(isalive(player) && isDefined(self) && player istouching(self) && player function_64fefea()) {
      return true;
    }
  }

  return false;
}

function function_acf0ca42() {
  foreach(player in getplayers()) {
    if(isalive(player) && isDefined(self) && player istouching(self)) {
      return true;
    }
  }

  return false;
}

function function_64fefea() {
  if(self getvelocity() === (0, 0, 0)) {
    return false;
  }

  return true;
}

function function_29584e41() {
  level flag::wait_till(#"item_world_reset");

  if(util::get_game_type() !== # "spy") {
    var_94c44cac = getdynentarray("spy_special_weapon_stash");
    var_de285f77 = getdynentarray("spy_ammo_stash");
    var_ffd6a2d3 = getdynentarray("spy_equipment_stash");
    var_3c1644b6 = arraycombine(var_94c44cac, var_de285f77);
    var_3c1644b6 = arraycombine(var_3c1644b6, var_ffd6a2d3);

    foreach(dynent in var_3c1644b6) {
      setdynentstate(dynent, 3);
    }
  }
}
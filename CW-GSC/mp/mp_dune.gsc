/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_dune.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace mp_dune;

function autoexec function_7defddbd() {
  str_gametype = util::get_game_type();

  if(str_gametype === # "vip" || str_gametype === # "zsurvival") {
    setgametypesetting(#"hash_3a15393c2e90e121", 1);
  }
}

function event_handler[level_init] main(eventstruct) {
  clientfield::register("toplayer", "" + # "hash_5e463693d1dbcf1c", 1, 1, "int");
  level thread function_7f639bc1();
  function_19c4a6dc();
  load::main();
  compass::setupminimap("");
  level.var_d41618f6 = &function_53147f52;
  level.var_adc813e2 = &function_10eb2d4b;
  level.var_a93e4b60 = &function_53147f52;
  level.var_be43874e = &function_10eb2d4b;

  if(getdvarint(#"hash_3c861ebd76fd24eb", 0) != 0) {
    level.var_a0b75cfd = 1;
  }

  level.var_4c887efb = spawnStruct();
  level.var_4c887efb.origin = (0, -50000, -2500);
  level.var_4c887efb.angles = (0, 0, 0);
  function_e8fa58f2();
  level callback::add_callback(#"hash_540f54ade63017ea", &function_54d03b3c);
}

function private function_54d03b3c(eventstruct) {
  setgametypesetting(#"hash_3a15393c2e90e121", 0);
}

function function_19c4a6dc() {
  str_gametype = function_be90acca(util::get_game_type());

  if(str_gametype === "zsurvival") {
    clientfield::register("toplayer", "" + # "hash_732e76418cbd8453", 1, 1, "int");
    level.var_b8c0d7a2 = 5000;
    level.var_e6b49685 = 3000;
    setDvar(#"hash_7b06b8037c26b99b", 200);
    a_models = getEntArray("dune_fav", "targetname");

    foreach(ent in a_models) {
      ent connectpaths();
      ent ghost();
      ent delete();
    }

    hidemiscmodels("dune_fav");
    level thread survival_fire_hazard();
    return;
  }

  hidemiscmodels("magicbox_zbarrier");
  hidemiscmodels("sv_doorblockers");
}

function survival_fire_hazard() {
  var_89a60e8a = struct::get("survival_fire_hazard");

  if(isDefined(var_89a60e8a)) {
    var_8248ec4d = spawn("trigger_radius", var_89a60e8a.origin, 0, int(var_89a60e8a.radius), int(var_89a60e8a.height));
    var_8248ec4d callback::on_trigger(&function_3867e5d3);
  }
}

function function_3867e5d3(eventstruct) {
  player = eventstruct.activator;

  if(!isPlayer(player) || player flag::get(#"hash_1e29d85de876dce8")) {
    return;
  }

  player.var_bb61ee3d = self;
  player flag::set(#"hash_1e29d85de876dce8");
}

function function_e8fa58f2() {
  hidemiscmodels("sv_holdout_aetherfungus");
  hidemiscmodels("defend_corpses_1");
  hidemiscmodels("defend_corpses_2");
  hidemiscmodels("defend_corpses_3");
  hidemiscmodels("hvt_mechz_corpses");
  hidemiscmodels("hvt_mimic_corpses");
  hidemiscmodels("hvt_raz_corpses");
  hidemiscmodels("hvt_steiner_corpses");
  hidemiscmodels("payload_teleport_corpses");
  hidemiscmodels("payload_noteleport_corpses");
  hidemiscmodels("retrieval_corpses");
  hidemiscmodels("secure_corpses");
  hidemiscmodels("hordehunt_corpses_1");
  hidemiscmodels("hordehunt_corpses_2");
  hidemiscmodels("fishing_setup");
  hidemiscmodels("transport_corpses");
}

function function_7f639bc1() {
  level endon(#"game_ended");
  var_f7d8aaa7 = strtok("koth10v10 vip conf10v10 dom10v10 tdm10v10 war12v12 zonslaught zonslaught_lotto_loadouts zsurvival", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_f7d8aaa7, gametype)) {
    array::delete_all(getEntArray("12v12_bounds", "targetname"));
    hidemiscmodels("12v12_bounds");
    hidemiscmodels("pole_turret");
    hidemiscmodels("zipline_flags");
    callback::function_900862de(&function_900862de);
    callback::function_be4cb7fe(&function_be4cb7fe);
    level flag::wait_till("first_player_spawned");
    return;
  } else {
    level.var_633063a5 = 1;
  }

  array::run_all(getEntArray("12v12_navmesh_cutout", "targetname"), &disconnectpaths, undefined, 0);
  array::delete_all(getEntArray("6v6_bounds", "targetname"));
  hidemiscmodels("6v6_bounds");
  level flag::wait_till("first_player_spawned");
}

function function_53147f52(player) {
  player clientfield::set_to_player("" + # "hash_5e463693d1dbcf1c", 1);
}

function function_10eb2d4b(player) {
  str_gametype = function_be90acca(util::get_game_type());

  if(str_gametype === "zsurvival") {
    player clientfield::set_to_player("" + # "hash_732e76418cbd8453", 1);
    return;
  }

  player clientfield::set_to_player("" + # "hash_5e463693d1dbcf1c", 0);
}

function function_900862de() {
  hidemiscmodels("6v6_bounds");
}

function function_be4cb7fe() {
  showmiscmodels("6v6_bounds");
}
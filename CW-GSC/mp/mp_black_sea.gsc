/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_black_sea.gsc
***********************************************/

#using script_67ce8e728d8f37ba;
#using script_72d96920f15049b8;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#namespace mp_black_sea;

function autoexec function_7defddbd() {
  str_gametype = util::get_game_type();

  if(str_gametype === # "vip" || str_gametype === # "zsurvival") {
    setgametypesetting(#"hash_3a15393c2e90e121", 1);
  }
}

function event_handler[level_init] main(eventstruct) {
  clientfield::register("vehicle", "" + # "hash_51d1d2a4c63ed960", 1, 1, "int");
  callback::on_vehicle_spawned(&on_vehicle_spawned);
  callback::on_game_playing(&on_game_playing);
  namespace_66d6aa44::function_3f3466c9();
  killstreaks::function_257a5f13("straferun", 40);
  killstreaks::function_257a5f13("helicopter_comlink", 75);
  scene::function_497689f6("cin_mp_blacksea_intro_cia", "helicopter", "tag_probe_cabin", "prb_tn_us_heli_lg_cabin");
  scene::function_497689f6("cin_mp_blacksea_intro_cia", "helicopter", "tag_probe_cockpit", "prb_tn_us_heli_lg_cockpit");
  scene::add_scene_func(#"cin_mp_blacksea_intro_kgb", &function_c628239e, "play");
  level thread function_7f639bc1();
  load::main();
  compass::setupminimap("");
  level thread function_29584e41();

  if(function_be90acca(util::get_game_type()) !== # "zsurvival") {
    hidemiscmodels("magicbox_zbarrier");
  }

  level thread function_e8fa58f2();
  level callback::add_callback(#"hash_540f54ade63017ea", &function_54d03b3c);
  str_gametype = util::get_game_type();

  if(str_gametype === # "zsurvival") {
    level.var_d3b056a7 = 1;
  }
}

function private function_54d03b3c(eventstruct) {
  setgametypesetting(#"hash_3a15393c2e90e121", 0);
}

function on_vehicle_spawned() {
  if(isvehicle(self) && is_true(self.break_glass)) {
    self util::break_glass();
  }
}

function on_game_playing() {
  function_c0e7257();
}

function function_c0e7257() {
  var_286f8241 = getent("fire_trigger_hurt", "targetname");

  if(isDefined(var_286f8241)) {
    var_286f8241 callback::on_trigger(&function_6691af0e);
  }
}

function function_6691af0e(var_252cfb75) {
  activator = var_252cfb75.activator;

  if(isvehicle(activator) && isalive(activator)) {
    activator dodamage(self.dmg, activator.origin);
  }
}

function function_7f639bc1() {
  level endon(#"game_ended");
  var_f7d8aaa7 = strtok("koth10v10 ctf vip conf10v10 dom10v10 tdm10v10 war12v12 zsurvival", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_f7d8aaa7, gametype)) {
    level.var_633063a5 = 1;
    array::delete_all(getEntArray("12v12_bounds", "targetname"));
    hidemiscmodels("12v12_bounds");
    hidemiscmodels("pole_turret");
    hidemiscmodels("zipline_flags");
    level flag::wait_till("first_player_spawned");
    exploder::exploder("fxexp_main_ship_oil_fire_level");
    return;
  }

  array::run_all(getEntArray("12v12_navmesh_cutout", "targetname"), &disconnectpaths, undefined, 0);
  array::delete_all(getEntArray("6v6_bounds", "targetname"));
  hidemiscmodels("6v6_bounds");
  level flag::wait_till("first_player_spawned");
  exploder::exploder("exp_lgt_12v12");
  exploder::exploder("fxexp_main_ship_oil_fire_level");
}

function function_c628239e(a_ents) {
  self notify("17f7b6813feb7577");
  self endon("17f7b6813feb7577");
  var_a6eece5c = a_ents[# "raft"];
  var_a6eece5c endon(#"death");
  var_a6eece5c waittill(#"hash_c29a94baff41fde");
  var_a6eece5c clientfield::set("" + # "hash_51d1d2a4c63ed960", 1);
  var_a6eece5c waittill(#"hash_1ecf339bfbbacc60");
  var_a6eece5c clientfield::set("" + # "hash_51d1d2a4c63ed960", 0);
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
  hidemiscmodels("hordehunt_corpses_3");
  hidemiscmodels("fishing_setup");
}
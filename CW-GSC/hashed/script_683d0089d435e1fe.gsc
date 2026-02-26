/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_683d0089d435e1fe.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using script_2d443451ce681a;
#using script_61fee52bb750ac99;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_371f22ea;

function start(str_objective) {}

function main(str_objective, var_50cc0d4f) {
  level thread namespace_d9b153b9::start_outro(var_50cc0d4f);
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_c26b0bc0() {
  level flag::init("bridge_path_completed");
  level flag::init("flag_bridge_path_zipline_start");
  level flag::init("flag_bridge_path_zipline_done");
  level flag::init("flag_bridge_path_zipline_vo_done");
  level flag::init("flag_bridge_jumper");
}

function function_a08d5cab() {
  level flag::clear("flag_bridge_path_complete");
  level flag::clear("flag_bridge_path_memory_start");
  level flag::clear("flag_bridge_path_backtrack");
  level flag::clear("flag_bridge_path_zipline_vo");
  level flag::clear("flag_bridge_path_zipline_start");
  level flag::clear("flag_bridge_path_on_bridge");
  level flag::clear("flag_bridge_crossed");
  level flag::clear("flag_bridge_path_overlook");
  level flag::clear("flag_pre_village_vo");
}

function bridge_path() {
  level endon(#"start_outro");
  var_c79d614f = "bridge_path";
  level thread function_2b388cee(var_c79d614f);
  level thread function_6620854c(var_c79d614f);
}

function function_898195a8() {
  level notify(#"hash_1314cbd25bca805d");
}

function function_2b388cee(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  vo_array = [];
  vo_array[0] = "vox_cp_prsn_14500_adlr_surebellyoucomm_54";
  vo_array[1] = "vox_cp_prsn_14300_adlr_sticktotherepor_17";
  level thread namespace_d9b153b9::function_47e52704("flag_bridge_jumper", "struct_bridge_jump_teleport", vo_array);
  level thread function_63b20868();

  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 >= 2) {
    level thread function_462674();
  }

  level flag::wait_till("flag_" + var_c79d614f);
  level.var_3f5c80c8 = "bridge_path";
  level function_364f9974();
  level childthread function_898195a8();
  level childthread function_b9c10ace();
  level childthread function_5a197a91(var_c79d614f);

  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 1) {
    level childthread function_e9d11934();
  }

  if(level.var_731c10af.paths[var_c79d614f].count == 0) {
    function_25c21ed3();
  } else if(level.var_731c10af.paths[var_c79d614f].count == 1) {
    function_25c21ed3();
  } else if(level.var_731c10af.paths[var_c79d614f].count == 2) {
    function_393dc5ca();
  } else if(level.var_731c10af.paths[var_c79d614f].count >= 3) {
    function_25c21ed3();
  }

  namespace_d9b153b9::function_e106e062(var_c79d614f);
  var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
  str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f + "_" + level.var_731c10af.paths[var_c79d614f].count;
  bb::function_cd497743(str, level.player);
  level flag::wait_till("flag_bridge_path_complete");
  level notify(#"hash_4dc1bd447e15018a");
  level flag::set(var_c79d614f + "_completed");
}

function function_63b20868() {
  var_10a2363b = level.player stats::get_stat_global("cp_dark_prisoner");

  if(isDefined(var_10a2363b) && var_10a2363b == 1) {
    return;
  }

  level flag::wait_till("flag_bridge_jumper");
  level.player stats::function_dad108fa(#"cp_dark_prisoner", 1);
}

function function_462674() {
  level endon(#"visit_restart");
  level endon(#"start_outro");

  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 2) {
    level flag::clear("flag_bridge_path_rob");
    level flag::clear("flag_bridge_path_rob_2");
  }

  level thread function_bedf680d();

  if(!level flag::get("flag_bridge_path_rob")) {
    level thread namespace_d9b153b9::function_1e281213("mdl_mem_hallway_bridge", 4, "flag_bridge_path_rob", "render_texture_switch", "flag_in_end_path", "flag_mem_hallway_bridge");
    level thread namespace_b6fe1dbe::function_823f75e6();
  }
}

function function_bedf680d() {
  if(!level flag::get("flag_bridge_path_rob_2")) {
    level thread namespace_d9b153b9::function_1e281213("mdl_mem_hallway_bridge_2", 4, "flag_bridge_path_rob_2", "render_texture_switch", "flag_in_end_path", "flag_mem_hallway_bridge_2");
    level thread namespace_b6fe1dbe::function_aaf2474b();
    level flag::wait_till("flag_bridge_path_rob_2");
    wait 1;
    level thread namespace_d9b153b9::function_b96db417("bridge_path_rob_light");
  }
}

function function_364f9974() {
  level flag::clear("flag_adler_bridge_fork_disappear");
  level flag::clear("flag_bridge_path_zipline_start");
  level flag::clear("flag_bridge_path_zipline_done");
  level flag::clear("flag_bridge_path_zipline_vo_done");
}

function function_6620854c(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level flag::wait_till("flag_bridge_path_memory_start");

  if(level.var_731c10af.var_e15e5b51.size == 2) {
    scene::add_scene_func("scene_pri_frozen_fight_bridge", &function_3170191d);
    thread scene::play("scene_frozen_fight_bridge");
    level flag::set("flag_bridge_frozen_battle_heli");
    level thread exploder::exploder("bridge_frozen_battle");
    level thread namespace_b6fe1dbe::function_20018404();
    level thread bridge_frozen_battle_heli();
  }

  thread function_dfbf6c10();
}

function function_3170191d(a_ents) {
  foreach(ent in a_ents) {
    if(!isDefined(ent)) {
      continue;
    }

    ent thread namespace_d9b153b9::function_7428d519();
    ent clientfield::set("toggle_bone_constraint", 1);
    ent setnosunshadow();
  }

  var_9fc6bf6f = a_ents[#"ally2"];

  if(isDefined(var_9fc6bf6f)) {
    if(var_9fc6bf6f.model != "c_t9_usa_redshirt_02") {
      var_9fc6bf6f namespace_d9b153b9::function_b0ea272("c_t9_usa_redshirt_02");
    }
  }

  var_34348dcd = a_ents[#"hash_690ae0194ed71cc4"];

  if(isDefined(var_34348dcd)) {
    var_34348dcd thread namespace_d9b153b9::function_e361b981(#"ar_damage_t9");
  }

  var_41ef2942 = a_ents[#"hash_690ae1194ed71e77"];

  if(isDefined(var_41ef2942)) {
    var_41ef2942 thread namespace_d9b153b9::function_e361b981(#"ar_damage_t9");
  }

  var_a6aef2c0 = a_ents[#"hash_690ade194ed7195e"];

  if(isDefined(var_a6aef2c0)) {
    var_a6aef2c0 thread namespace_d9b153b9::function_e361b981(#"ar_damage_t9");
  }
}

function bridge_frozen_battle_heli() {
  level endon(#"flag_in_end_path");
  wait 1;
  bridge_frozen_battle_heli = getent("bridge_frozen_battle_heli", "targetname");

  if(!isDefined(bridge_frozen_battle_heli)) {
    while(!isDefined(bridge_frozen_battle_heli)) {
      bridge_frozen_battle_heli = getent("bridge_frozen_battle_heli", "targetname");
      wait 0.5;
    }
  }

  if(isDefined(bridge_frozen_battle_heli)) {
    bridge_frozen_battle_heli setnosunshadow();
  }
}

function function_dfbf6c10() {
  level flag::wait_till("flag_in_end_path");
  level notify(#"hash_135069eaafe77dc0");
  scene::stop("scene_frozen_fight_bridge");
  level scene::delete_scene_spawned_ents("scene_frozen_fight_bridge");
  level flag::clear("flag_bridge_frozen_battle_heli");
  level thread exploder::kill_exploder("bridge_frozen_battle");
}

function function_2a29619c() {
  self.health = 1;
  self.var_c681e4c1 = 1;
}

function function_25c21ed3() {
  var_736f7cf8 = vehicle::simple_spawn_and_drive("bridge_heligroup1");

  foreach(heli in var_736f7cf8) {
    heli setrotorspeed(1);
  }

  var_736f7cf8[0] thread namespace_b6fe1dbe::function_280d83da();
  var_736f7cf8[1] thread namespace_b6fe1dbe::function_3dd3af66();
  var_736f7cf8[2] thread namespace_b6fe1dbe::function_8444bc3b();
  var_736f7cf8[0] playrumblelooponentity("cp_nam_prisoner_heli_flyby");
  var_736f7cf8[1] playrumblelooponentity("cp_nam_prisoner_heli_flyby");
  var_736f7cf8[2] playrumblelooponentity("cp_nam_prisoner_heli_flyby");
}

function function_393dc5ca() {
  var_73567cca = vehicle::simple_spawn_and_drive("bridge_heligroup3");

  foreach(heli in var_73567cca) {
    heli setrotorspeed(1);
  }

  var_73567cca[0] thread namespace_b6fe1dbe::function_9b2e941d();
  var_73567cca[1] thread namespace_b6fe1dbe::function_a6eaab95();
  var_73567cca[2] thread namespace_b6fe1dbe::function_49b6f127();
  var_73567cca[0] playrumblelooponentity("cp_nam_prisoner_heli_flyby");
  var_73567cca[1] playrumblelooponentity("cp_nam_prisoner_heli_flyby");
  var_73567cca[2] playrumblelooponentity("cp_nam_prisoner_heli_flyby");
}

function function_5a197a91(var_c79d614f) {
  level endon(#"hash_4dc1bd447e15018a");
  level flag::wait_till("flag_bridge_path_zipline_vo");
  level childthread function_9e133c64();
  level childthread function_9e985d7f();

  if(level.var_baa7cf92 == "caves") {
    if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 2) {
      dialogue::radio("vox_cp_prsn_08500_adlr_belltakethezipl_9e");
    } else {
      dialogue::radio("vox_cp_prsn_02700_adlr_theziplinenearb_3e");
    }
  } else if(level.var_baa7cf92 == "village") {
    level thread function_1077143c();
    dialogue::radio("vox_cp_prsn_05500_adlr_youmentionedcro_04");
  } else if(level.var_baa7cf92 == "sniper_overlook") {
    level thread function_1077143c();
    dialogue::radio("vox_cp_prsn_08500_adlr_reportshadthebu_0b");
  }

  level flag::wait_till("flag_bridge_crossed");

  if(level.var_baa7cf92 == "caves") {
    thread namespace_b6fe1dbe::function_1e0e9b39(var_c79d614f);

    if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 2) {
      dialogue::radio("vox_cp_prsn_08500_adlr_bellgobacktothe_9f");
    } else {
      dialogue::radio("vox_cp_prsn_02700_adlr_bellturnbackand_dd");
    }

    return;
  }

  if(level.var_baa7cf92 == "village") {
    thread namespace_b6fe1dbe::function_34830cda(var_c79d614f);
    thread namespace_b6fe1dbe::function_4a9b10a8();
    dialogue::radio("vox_cp_prsn_05500_adlr_attheforkyoufol_73");
    return;
  }

  if(level.var_baa7cf92 == "sniper_overlook") {
    thread namespace_b6fe1dbe::function_34830cda(var_c79d614f);
    dialogue::radio("vox_cp_prsn_08500_adlr_youwentleftatth_17");
  }
}

function function_48800705(var_c79d614f) {
  level endon(#"flag_bridge_crossed");
  level flag::wait_till("flag_bridge_path_on_bridge");

  if(level.var_baa7cf92 == "caves") {
    thread namespace_b6fe1dbe::function_1e0e9b39(var_c79d614f);

    if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 2) {
      dialogue::radio("vox_cp_prsn_08500_adlr_bellturnarounda_a7");
      return;
    }

    dialogue::radio("vox_cp_prsn_02700_adlr_bellyoudidntcro_e8");
  }
}

function function_22390791() {
  level flag::wait_till("flag_bridge_path_overlook");

  if(level.var_baa7cf92 == "village") {
    dialogue::radio("vox_cp_prsn_05500_adlr_bellyoudidntjus_6c");
  }
}

function function_b9c10ace() {
  level flag::wait_till("flag_bridge_crossed");

  if(level.var_731c10af.paths[#"village"].count == 0) {
    level flag::wait_till_any(array("flag_village", "flag_sniper_overlook"));
  }
}

function function_9e133c64() {
  level endon(#"hash_4dc1bd447e15018a");
  level flag::wait_till("flag_bridge_path_zipline_done");
  wait 1.75;
  level flag::set("flag_bridge_path_zipline_vo_done");
}

function function_1077143c() {
  level endon(#"hash_4dc1bd447e15018a");
  level flag::wait_till("flag_bridge_path_zipline_start");

  if(level.var_baa7cf92 == "village") {
    dialogue::radio("vox_cp_prsn_05500_adlr_bellyourreportd_18");
  } else if(level.var_baa7cf92 == "sniper_overlook") {
    dialogue::radio("vox_cp_prsn_08500_adlr_goddammitbellwe_c8");
  }

  level flag::set("flag_bridge_path_zipline_vo_done");
}

function function_9e985d7f() {
  level endon(#"hash_4dc1bd447e15018a");
  level flag::wait_till("flag_bridge_path_backtrack");

  if(isDefined(level.var_731c10af.var_42659717) && (level.var_731c10af.var_42659717 == 0 || level.var_731c10af.var_42659717 == 1)) {}
}

function function_b6dc2ea2() {
  level flag::wait_till("flag_bridge_path_complete");

  if(level.var_baa7cf92 == "village" && !level flag::get("flag_bridge_path_zipline_start") && level flag::get("flag_sniper_overlook")) {}
}

function function_e9d11934() {
  str_name = util::function_875955a();

  if(str_name == "sims") {
    var_ef191d3c = spawner::simple_spawn_single("ally_park_bridge");
    var_7ac9696f = spawner::simple_spawn_single("ally_lazar_bridge");
    a_e_allies = array(var_ef191d3c, var_7ac9696f);
  } else if(str_name == "lazar") {
    var_ef191d3c = spawner::simple_spawn_single("ally_park_bridge");
    a_e_allies = array(var_ef191d3c);
  } else if(str_name == "park") {
    var_7ac9696f = spawner::simple_spawn_single("ally_lazar_bridge");
    a_e_allies = array(var_7ac9696f);
  }

  level thread scene::init("scene_lost_companion", a_e_allies);
  level flag::wait_till_any(array("flag_adler_bridge_fork_disappear", "flag_in_end_path"));

  if(!level flag::get("flag_in_end_path")) {
    level thread scene::play("scene_lost_companion", "shot 2", a_e_allies);
    childthread function_7a3d38d9(a_e_allies);

    while(isDefined(a_e_allies[0]) && a_e_allies[0] getanimtime(a_e_allies[0].str_current_anim) < 0.9) {
      waitframe(1);
    }
  }

  level scene::stop("scene_lost_companion");
  level scene::delete_scene_spawned_ents("scene_lost_companion");
  waitframe(1);
  function_1eaaceab(a_e_allies);

  foreach(var_ac85c33a in a_e_allies) {
    if(isDefined(var_ac85c33a)) {
      util::stop_magic_bullet_shield(var_ac85c33a);
    }

    waitframe(1);

    if(isDefined(var_ac85c33a)) {
      var_ac85c33a delete();
    }
  }
}

function function_7a3d38d9(a_e_allies) {
  var_469f12b5 = undefined;

  while(true) {
    foreach(var_ac85c33a in a_e_allies) {
      if(!isalive(var_ac85c33a)) {
        return;
      }

      f_distance = distance2d(var_ac85c33a.origin, level.player.origin);

      if(f_distance < 500) {
        var_469f12b5 = var_ac85c33a;
        break;
      }
    }

    if(isDefined(var_469f12b5)) {
      break;
    }

    waitframe(1);
  }

  if(isDefined(var_469f12b5.str_current_anim)) {
    f_time = var_469f12b5 getanimtime(var_469f12b5.str_current_anim);

    foreach(var_ac85c33a in a_e_allies) {
      var_ac85c33a.n_script_anim_rate = 10;
    }

    namespace_b6fe1dbe::function_df93683a();
    level scene::play_from_time("scene_lost_companion", "shot 2", a_e_allies, f_time);
  }

  level thread namespace_d9b153b9::function_57eac84a();
}
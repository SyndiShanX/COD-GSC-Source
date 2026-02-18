/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_cb7714d0f6591d7.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using script_2d443451ce681a;
#using script_61fee52bb750ac99;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_nam_prisoner_rat_tunnels;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\smart_bundle;
#using scripts\cp_common\util;
#namespace namespace_6020b123;

function start(str_objective) {}

function main(str_objective, var_50cc0d4f) {
  level thread namespace_d9b153b9::start_outro(var_50cc0d4f);
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_c26b0bc0() {
  level flag::init("river_path_completed");
}

function function_a08d5cab() {
  level flag::clear("flag_river_path");
  level flag::clear("flag_river_path_memory_start");
  level flag::clear("flag_river_progression");
  level flag::clear("flag_caves_path");
  level flag::clear("flag_rat_tunnels_path");
  level flag::clear("flag_rat_tunnels_field");
  level flag::clear("flag_open_rat_tunnels");
  level flag::clear("flag_river_ladder");
  level flag::clear("flag_river_ladder_approach");
  level flag::clear("flag_river_ladder_top");
  level flag::clear("flag_adler_river_disappear");
  level flag::clear("flag_adler_rat_tunnels_disappear");
}

function river_path() {
  level endon(#"start_outro");
  var_c79d614f = "river_path";
  level thread function_76ef45a9(var_c79d614f);
  level thread function_9c53d200(var_c79d614f);
}

function function_7b5ef878() {
  level notify(#"waterfall_end_vo");
}

function function_76ef45a9(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  vo_array = [];
  vo_array[0] = "vox_cp_prsn_14300_adlr_sticktotherepor_17";
  vo_array[1] = "vox_cp_prsn_14500_adlr_surebellyoucomm_54";
  level thread namespace_d9b153b9::function_47e52704("flag_river_jumper", "struct_river_jump_teleport", vo_array);

  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 >= 2) {
    level thread function_7beef866();
  }

  level flag::wait_till("flag_" + var_c79d614f);
  level.var_3f5c80c8 = "river_path";

  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 1) {
    level thread function_a517e48c();
  }

  thread function_7b5ef878();
  function_384b4a52(var_c79d614f);
  namespace_d9b153b9::function_e106e062(var_c79d614f);
  level flag::set(var_c79d614f + "_completed");
  var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
  str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f + "_" + level.var_731c10af.paths[var_c79d614f].count;
  bb::function_cd497743(str, level.player);
}

function function_7beef866() {
  level endon(#"visit_restart");
  level endon(#"start_outro");

  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 2) {
    level flag::clear("flag_river_path_rob");
  }

  if(!level flag::get("flag_river_path_rob")) {
    level thread namespace_d9b153b9::function_1e281213("mdl_mem_hallway_river", 4, "flag_river_path_rob", "render_texture_switch", "flag_in_end_path", "flag_mem_hallway_river");
    level thread namespace_b6fe1dbe::function_e4de9155();
    level flag::wait_till("flag_river_path_rob");
    wait 1;
    level thread namespace_d9b153b9::function_b96db417("river_path_rob_light");
  }
}

function function_384b4a52(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level childthread function_34a64026(var_c79d614f);
  level childthread function_d5b16935(var_c79d614f);
  level childthread function_cca4aa65(var_c79d614f);
  level childthread function_1db0a952();

  if(!level flag::get("flag_rat_tunnels")) {
    level childthread cp_nam_prisoner_rat_tunnels::function_4b429874("rat_tunnels");
  }
}

function function_34a64026(var_c79d614f) {
  level endon(#"hash_411bceb4b6375aff");

  if(level flag::get("flag_bridge_path_zipline_start")) {
    level flag::wait_till("flag_bridge_path_zipline_vo_done");

    if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
      level thread dialogue::radio("vox_cp_prsn_05500_adlr_goddammitbellwh_f0");
    }

    level flag::set("flag_bridge_path_complete");
  }

  if(level.var_baa7cf92 == "caves") {
    level flag::wait_till("flag_river_ladder");
    wait 1;
    dialogue::radio("vox_cp_prsn_02200_adlr_youheardrussian_c8");
    var_5d7cba12 = struct::get("struct_lookat_caves", "targetname");
    var_cccff3af = (2630, 3920, -231);
    wait 1;
    playsoundatposition("vox_cp_prsn_29500_rms1_c5", var_cccff3af);
    wait 6;
    playsoundatposition("vox_cp_prsn_29500_rms1_report_9d", var_cccff3af);
    wait 3;
    playsoundatposition("vox_cp_prsn_29500_rms2_entryissecuresi_70", var_cccff3af);
  } else if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
    level flag::wait_till("flag_river_progression");
    thread namespace_b6fe1dbe::function_1e0e9b39(var_c79d614f);

    if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 2) {
      dialogue::radio("vox_cp_prsn_08200_adlr_bellusetheladde_f0");
    } else {
      dialogue::radio("vox_cp_prsn_05200_adlr_bellgobackandcl_3b");
    }
  }

  struct_lookat_caves = struct::get("struct_lookat_caves", "targetname");
  level.player childthread namespace_d9b153b9::function_d683b544(&function_14dbdc61, struct_lookat_caves.origin);
  struct_lookat_beach = struct::get("struct_lookat_beach", "targetname");
  level.player childthread namespace_d9b153b9::function_d683b544(&function_f3e42700, struct_lookat_beach.origin);
  struct_lookat_firepit = struct::get("struct_lookat_firepit", "targetname");
  level.player childthread namespace_d9b153b9::function_d683b544(&function_cec783b5, struct_lookat_firepit.origin);
}

function function_14dbdc61() {}

function function_f3e42700() {}

function function_cec783b5() {
  dialogue::radio("vox_cp_prsn_14300_adlr_asovietstatuein_b6");
}

function function_d5b16935(var_c79d614f) {
  level endon(#"hash_411bceb4b6375aff");
  level flag::wait_till("flag_caves_path");

  if(level.var_baa7cf92 == "caves") {
    thread namespace_b6fe1dbe::function_34830cda(var_c79d614f);
    thread namespace_b6fe1dbe::function_19123a4f();
  }
}

function function_cca4aa65(var_c79d614f) {
  level endon(#"hash_411bceb4b6375aff");
  level flag::wait_till("flag_rat_tunnels_path");
  thread namespace_b6fe1dbe::function_1e0e9b39(var_c79d614f);

  if(level.var_baa7cf92 == "caves") {
    dialogue::radio("vox_cp_prsn_02200_adlr_nobellyoufoundt_ae");
    return;
  }

  if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
    dialogue::radio("vox_cp_prsn_08200_adlr_bellthebunkeris_3a");
  }
}

function function_1db0a952() {
  level endon(#"hash_411bceb4b6375aff");
  level flag::wait_till("flag_river_ladder");

  if(level.var_baa7cf92 == "caves") {
    level flag::wait_till("flag_river_ladder_approach");
    dialogue::radio("vox_cp_prsn_02200_adlr_bellineedyoutot_53");
    level flag::wait_till("flag_river_ladder_top");
    dialogue::radio("vox_cp_prsn_02200_adlr_bellsstartingto_5f");
    return;
  }

  if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
    dialogue::radio("vox_cp_prsn_05200_adlr_bellyounoticeda_44");
  }
}

function function_a517e48c() {}

function function_5dece0a6() {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level endon(#"hash_6298f1ecb0e7b6ba");

  if(level.var_731c10af.paths[# "rat_tunnels"].count == 1) {
    a_ents = [];
    a_ents[# "hatch"] = getent("rat_tunnel_hatch", "targetname");
    level thread scene::init("scene_pri_rat_tunnel_reveal", a_ents);
    return;
  }

  a_ents = [];
  a_ents[# "hatch"] = getent("rat_tunnel_hatch", "targetname");
  level thread scene::init("scene_pri_rat_tunnel_reveal", a_ents);
  level flag::wait_till("flag_open_rat_tunnels");
  level thread scene::play("scene_pri_rat_tunnel_reveal", a_ents);
  thread function_81c9b145(a_ents);
}

function function_81c9b145(a_ents) {
  level endon(#"hash_411bceb4b6375aff");
}

function function_9c53d200(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level flag::wait_till("flag_river_path_memory_start");

  if(level.var_731c10af.var_e15e5b51.size == 2) {
    scene::add_scene_func("scene_pri_frozen_fight_creek", &function_d915ae1b);
    thread scene::play("scene_frozen_fight_creek");
    level thread exploder::exploder("river_frozen_battle");
  }

  thread function_d90c1d8a();
}

function function_d915ae1b(a_ents) {
  foreach(ent in a_ents) {
    if(!isDefined(ent)) {
      continue;
    }

    ent thread namespace_d9b153b9::function_7428d519();

    if(isDefined(ent.classname) && ent.classname != "script_model") {
      ent clientfield::set("toggle_bone_constraint", 1);
    }

    ent setnosunshadow();
  }

  var_34348dcd = a_ents[# "hash_690ae0194ed71cc4"];

  if(isDefined(var_34348dcd)) {
    var_34348dcd thread namespace_d9b153b9::function_e361b981(#"ar_damage_t9");
  }

  var_41ef2942 = a_ents[# "hash_690ae1194ed71e77"];

  if(isDefined(var_41ef2942)) {
    var_41ef2942 thread namespace_d9b153b9::function_e361b981(#"ar_damage_t9");
  }

  var_7c6f9e42 = a_ents[# "hash_690adf194ed71b11"];

  if(isDefined(var_7c6f9e42)) {
    var_7c6f9e42 thread namespace_d9b153b9::function_e361b981(#"ar_damage_t9");
  }
}

function function_d90c1d8a() {
  level flag::wait_till("flag_in_end_path");
  level notify(#"hash_135069eaafe77dc0");
  scene::stop("scene_frozen_fight_creek");
  level scene::delete_scene_spawned_ents("scene_frozen_fight_creek");
  level thread exploder::kill_exploder("river_frozen_battle");
}

function function_3d2d64ea() {
  self.health = 1;
  self.var_c681e4c1 = 1;
}
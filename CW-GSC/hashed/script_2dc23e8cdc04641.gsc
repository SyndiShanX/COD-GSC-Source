/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2dc23e8cdc04641.gsc
***********************************************/

#using script_237e957844a8197c;
#using script_5991d6501121591f;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_nic_revolucion_fx;
#using scripts\cp_common\achievements;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\killstreaks\cp\ac130;
#using scripts\killstreaks\killstreaks_shared;
#namespace namespace_379d0dc2;

function private autoexec __init__system__() {
  system::register(#"exfil", &_preload, undefined, undefined, undefined);
}

function private _preload() {
  clientfield::register("toplayer", "skyhook_speedblur", 1, 1, "int");
}

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_rooftop_struct");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_rooftop_struct");
  level.park.ignoreall = 0;
  level.park.script_accuracy = 0.5;
  level.park colors::disable();
  park_exfil_node = getnode("park_exfil_node", "targetname");
  level.park setgoal(park_exfil_node);
  level.lazar.ignoreall = 0;
  level.lazar.script_accuracy = 0.5;
  level.lazar colors::disable();
  var_cb77324d = getnode("rooftop_lazar_node", "targetname");
  level.lazar setgoal(var_cb77324d);
  level flag::set("flg_turn_on_rooftop_kill_volume");
  level thread namespace_a789f8ae::function_ba3f106b("exfil");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("enemies");
  level.lazar setthreatbiasgroup("allies");
  level.park setthreatbiasgroup("allies");
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  hms_util::function_eaa0342e("rooftop_containment_warnings", "rooftop_containment_fails");
  savegame::checkpoint_save();
  namespace_232ddc52::music("13.1_rooftop");
  level thread function_5a5ce08a();
  level.var_c0c8b6a5 = 1;
  level.var_106f184b = struct::get("pilot_dialogue_exfil", "targetname");
  level.var_106f184b.var_a8f26c65 = array("vox_cp_cbcr_02500_pilo_bullseye_73", "vox_cp_cbcr_02500_pilo_firing_8d", "vox_cp_cbcr_02500_pilo_goodeffectgoode_a8", "vox_cp_cbcr_02500_pilo_goodimpact_55", "vox_cp_cbcr_02500_pilo_thatsahit_13");
  level.park.script_accuracy = 0.5;
  level.lazar.script_accuracy = 0.5;
  setthreatbias("allies", "enemies", 200);
  level thread function_68558af9();
  var_93e04a30 = spawner::simple_spawn_single("rooftop_defend_wave_3_1_rpg_1", &function_d210173f, "exfil_rpg_inital_pos_1", "exfil_rpg_target_1");
  wait randomfloatrange(0.5, 1);
  var_ed087c7f = spawner::simple_spawn_single("rooftop_defend_wave_3_1_rpg_2", &function_d210173f, "exfil_rpg_inital_pos_2", "exfil_rpg_target_2");
  wait randomfloatrange(0.5, 1);
  var_b7b711dd = spawner::simple_spawn_single("rooftop_defend_wave_3_1_rpg_3", &function_d210173f, "exfil_rpg_inital_pos_3", "exfil_rpg_target_3");
  var_bf311605 = array(var_93e04a30, var_ed087c7f, var_b7b711dd);
  wait 5;
  level flag::wait_till_timeout(5, "flg_rpg_volly_done");
  park_exfil_node = getnode("park_exfil_node", "targetname");
  level.park setgoal(park_exfil_node);
  wait randomfloatrange(1, 2);
  var_db9245a6 = spawner::simple_spawn("rooftop_defend_wave_3_2");
  wait randomfloatrange(1, 2);
  var_b3e00a8c = spawner::simple_spawn("rooftop_defend_wave_3_3");
  var_b9943a82 = spawner::simple_spawn("rooftop_defend_wave_2_2");
  wait randomfloatrange(1, 1.5);
  var_9bc52185 = spawner::simple_spawn("rooftop_defend_wave_2_3");
  var_b9290093 = arraycombine(var_bf311605, var_db9245a6);
  var_b9290093 = arraycombine(var_b9290093, var_b3e00a8c);
  var_b9290093 = arraycombine(var_b9290093, var_b9943a82);
  var_b9290093 = arraycombine(var_b9290093, var_9bc52185);

  foreach(guy in var_b9290093) {
    if(isalive(guy)) {
      guy setthreatbiasgroup("enemies");
    }
  }

  foreach(guy in var_b9290093) {
    if(isalive(guy)) {
      guy.script_accuracy = 0.1;
    }
  }

  wait 2;
  level flag::set("flg_ac130_ready");
  var_12ca8919 = spawner::simple_spawn("rooftop_defend_mortar_fodder_1");
  var_45146dac = spawner::simple_spawn("rooftop_defend_mortar_fodder_2");
  var_e18ea69e = spawner::simple_spawn("rooftop_defend_mortar_fodder_3");
  var_bc5fb0c = spawner::simple_spawn("rooftop_defend_mortar_fodder_4");
  var_b9290093 = arraycombine(var_b9290093, var_12ca8919);
  var_b9290093 = arraycombine(var_b9290093, var_45146dac);
  var_b9290093 = arraycombine(var_b9290093, var_e18ea69e);
  var_b9290093 = arraycombine(var_b9290093, var_bc5fb0c);

  foreach(guy in var_b9290093) {
    if(isalive(guy)) {
      guy setthreatbiasgroup("enemies");
    }
  }

  level flag::wait_till("flg_give_ac130_prompt");
  level.player.ignoreme = 1;
  level flag::set("flg_mortar_ready");
  level.player thread function_29758311();
  wait 6;
  var_c1a1f81e = spawner::simple_spawn("rooftop_defend_ac130_fodder_1");
  var_b3f15cbd = spawner::simple_spawn("rooftop_defend_ac130_fodder_2");
  var_cd182301 = arraycombine(var_c1a1f81e, var_b3f15cbd);
  level flag::wait_till("flg_ac130_active");
  var_bd8e9ff7 = getent("rooftop_damage_trigger_1", "targetname");
  var_49fe9e2a = struct::get("ac130_damage_fx_1", "targetname");
  var_cab83a4a = getent("rooftop_damage_trigger_2", "targetname");
  var_5c45c2b8 = struct::get("ac130_damage_fx_2", "targetname");
  var_18ffd6d8 = getent("rooftop_damage_trigger_3", "targetname");
  var_a34ad0c5 = struct::get("ac130_damage_fx_3", "targetname");
  var_cb6b3b9c = getent("rooftop_damage_trigger_4", "targetname");
  var_588a3b41 = struct::get("ac130_damage_fx_4", "targetname");
  var_1922d70a = getent("rooftop_damage_trigger_5", "targetname");
  var_30f16c10 = struct::get("ac130_damage_fx_5", "targetname");
  level thread function_501002d8(var_bd8e9ff7, var_49fe9e2a);
  level thread function_501002d8(var_cab83a4a, var_5c45c2b8);
  level thread function_501002d8(var_18ffd6d8, var_a34ad0c5);
  level thread function_501002d8(var_cb6b3b9c, var_588a3b41);
  level thread function_501002d8(var_1922d70a, var_30f16c10);
  wait 6;

  foreach(guy in var_b9290093) {
    if(isDefined(guy) && isalive(guy)) {
      guy thread function_4abb5b73();
    }
  }

  level flag::wait_till("flg_ac130_done");

  foreach(guy in var_cd182301) {
    if(isDefined(guy) && isalive(guy)) {
      guy thread function_4abb5b73();
    }
  }

  callback::remove_on_actor_killed(&function_2bc3e89c);
  savegame::checkpoint_save();
  level flag::wait_till("flg_setup_exfil");
  scene::add_scene_func("scene_rev_5050_rtp_extract", &function_e6e98d21, "choice_loop");
  level thread namespace_a789f8ae::function_fe8c8150();
  var_f70b5923 = getnode("rooftop_park_node", "targetname");
  level.lazar setgoal(var_f70b5923);
  level.player.ignoreme = 0;
  level flag::wait_till("flg_park_skyhook_ready");
  level thread function_fd1be627();
  level.player.takedown.disabled = 1;
  level flag::wait_till("flg_skyhook_ready");
  level thread function_ac6f37f4();
  level thread namespace_a789f8ae::function_28cf7333();
}

function function_2bc3e89c(params) {
  level.var_6df062d7++;

  if(level.var_6df062d7 >= 25) {
    hms_util::print("<dev string:x4a>");

    level.player achievements::give_achievement(#"cp_achievement_everyone");
    callback::remove_on_actor_killed(&function_2bc3e89c);
  }

  if(level.var_c0c8b6a5) {
    level thread function_4189d2e2();
  }
}

function function_4189d2e2() {
  level.var_c0c8b6a5 = 0;
  s_line = array::function_a3b0f814(level.var_106f184b.var_a8f26c65, 0);

  if(level.var_106f184b.var_a8f26c65.size > 0) {
    level.var_106f184b hms_util::dialogue(s_line, 1);
  } else {
    return;
  }

  wait randomfloatrange(3, 4.5);
  level.var_c0c8b6a5 = 1;
}

function function_4abb5b73() {
  self endon(#"death");
  vol_fallback = getent("a_wave_catch_all_enemies_fallback", "targetname");
  self setgoal(vol_fallback);
  self waittill(#"goal");

  if(isalive(self)) {
    self deletedelay();
  }
}

function function_d210173f(var_3c97f36d, var_5442a320) {
  self endon(#"death");
  self val::set(#"hash_722c2bad015d62bc", "ignoreall", 1);
  self spawner::go_to_struct(struct::get(var_3c97f36d, "targetname"));
  self waittill(#"goal");
  self thread ai::shoot_at_target("normal", getent(var_5442a320, "targetname"), "tag_origin", 10, 100, 1);
  self waittill(#"shoot");
  self ai::stop_shoot_at_target();
  self val::set(#"hash_722c2bad015d62bc", "ignoreall", 0);
  level flag::set("flg_rpg_volly_done");
}

function function_5f668630(a_ents) {
  level flag::set(#"flg_park_skyhook_ready");
}

function function_8e61cf6d(a_ents) {
  level flag::set(#"flg_lazar_skyhook_ready");
}

function function_fd1be627() {
  var_3f8b5025 = struct::get("s_obj_exfil", "targetname");
  objectives::function_4eb5c04a("obj_skyhook", var_3f8b5025.origin, #"hash_1434d5e6bc8057d2");
  var_37827744 = struct::get("skyhook_interact_org", "targetname");
  var_37827744 util::create_cursor_hint(undefined, undefined, #"hash_1a19c2c28f3d349d", 100, undefined, undefined, undefined, 500);
  var_37827744 prompts::function_cf884581(#"use", -30);
  var_37827744 prompts::function_5698d1c9(#"use", 30);
  level flag::set("flg_skyhook_ready");
  var_37827744 waittill(#"trigger");
  namespace_232ddc52::music("14.0_airhook");
  level flag::set("flg_skyhook_interacted");
  level.player thread function_d564f5b8();
  level namespace_a789f8ae::function_23334bfb();
}

function function_d564f5b8() {
  self endon(#"death");
  var_9c77c444 = struct::get("smoke_fx_org", "targetname");
  self waittill(#"hash_bf5bfd22f483570");
  effect = getstatuseffect("blurred");
  self status_effect::status_effect_apply(effect, getweapon(#"launcher_standard_t9"), self, undefined, 11000);
  playFX(level._effect[#"hash_7527861319d5e820"], var_9c77c444.origin);
  snd::client_msg("audio_rpg_aftermath_debris_fires");
}

function function_f60e249b(s_info) {
  return s_info.player istouching(self.var_99aeff0);
}

function function_5a5ce08a() {
  level endon(#"death");
  level endon(#"flg_choice_made");

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(0);
  }

  var_7cb820ce = struct::get("ai_mason_radio", "targetname");
  level.lazar hms_util::dialogue("vox_cp_cbcr_01900_lazr_imgettinglowona_74", undefined, "allies", "Lazar");
  level.park hms_util::dialogue("vox_cp_cbcr_01900_park_oneminutestayfo_33", undefined, "allies", "Park");
  level.park hms_util::dialogue("vox_cp_cbcr_01900_park_tellyouwhatwhen_7b", undefined, "allies", "Park");
  level.lazar hms_util::dialogue("vox_cp_cbcr_01900_lazr_nowthatssomethi_d9", undefined, "allies", "Lazar");
  level flag::wait_till("flg_ac130_ready");
  level.var_106f184b hms_util::dialogue("vox_cp_cbcr_02400_pilo_groundteamthisi_3b", 1);
  level.park hms_util::dialogue("vox_cp_cbcr_02400_park_thatwouldbemuch_87", undefined, "allies", "Park");
  level.var_106f184b thread hms_util::dialogue("vox_cp_cbcr_02400_pilo_rogerthathelpis_a0", 1);
  level flag::set("flg_give_ac130_prompt");
  level flag::wait_till("flg_ac130_active");
  level.park hms_util::dialogue("vox_cp_cbcr_02400_park_groundteamtosky_03", undefined, "allies", "Park");
  level.var_106f184b hms_util::dialogue("vox_cp_cbcr_02400_pilo_rogerthatcleari_1c", 1);
  level flag::wait_till("flg_ac130_done");
  level.var_106f184b hms_util::dialogue("vox_cp_cbcr_02400_pilo_groundteamweonl_30", 1);
  level.park hms_util::dialogue("vox_cp_cbcr_02400_park_copythatskyhook_c1", undefined, "allies", "Park");
  var_f70b5923 = getnode("rooftop_park_node", "targetname");
  level.lazar setgoal(var_f70b5923);
  level.lazar hms_util::dialogue("vox_cp_cbcr_01900_lazr_icanseetheplane_a9");
  level flag::set("flg_setup_exfil");
}

function function_866ea46f() {
  level endon(#"flg_choice_made", #"flg_no_choice");
  level flag::wait_till("flg_choice_nags");
  level.lazar thread hms_util::dialogue("vox_cp_cbcr_02000_lazr_aggghhmylegs_39");
  level flag::wait_till("flg_nearing_exfil");

  hms_util::print("<dev string:x72>");

  level.park thread hms_util::dialogue("vox_cp_cbcr_02000_park_pleasetimeisrun_4c", undefined, "allies", "Park");
  level.lazar hms_util::dialogue("vox_cp_cbcr_02000_lazr_quickly_03", undefined, "allies", "Lazar");
}

function function_99eade0f() {
  level.player endon(#"death");
  level endon(#"flg_skyhook_interacted");
  wait 3;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01900_park_bellhookin_94");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01900_park_belltheskyhook_35");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01900_park_bellhookintothe_ec");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01900_park_moveitbellthepl_ab");
  var_ffbbfc35[4] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01900_park_bellhurryup_2b");
  var_ffbbfc35[5] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01900_park_bellwedonthavem_f8");

  while(true) {
    hms_util::vo_knockout_manager("cuban_hook_in_nags", var_ffbbfc35);
    wait 4;
  }
}

function function_e2262e44() {
  level flag::wait_till("flg_exfil_explosion_hit");
  wait 7.5;
  level.var_106f184b hms_util::dialogue("vox_cp_cbcr_02000_pilo_groundhogwehave_78", 1, "allies", "Pilot");
  level flag::set("flg_pilot_talked");
  level.var_106f184b hms_util::dialogue("vox_cp_cbcr_02000_pilo_9_4d", 1, "allies", "Pilot");
  level.var_106f184b thread hms_util::dialogue("vox_cp_cbcr_02000_pilo_pickupin8765_a5", 1, "allies", "Pilot");
  wait 2;
  level flag::set("flg_nearing_exfil");
  level.var_106f184b hms_util::dialogue("vox_cp_cbcr_02000_pilo_4321_f2", 1, "allies", "Pilot");
}

function function_e6e98d21(a_ents) {
  var_74e225bb = struct::get("exfil_choose_lazar");
  var_74e225bb util::create_cursor_hint(undefined, undefined, #"hash_234a4924902e7f54", 1000, 2, &function_6edd5850);
  var_74e225bb prompts::function_44d7831a(#"use", 1);
  var_74e225bb prompts::function_b95d71cd(#"use", 15);
  var_74e225bb prompts::function_2557566(#"use", 10);
  var_74e225bb prompts::function_1a5e1da6(#"use", 1, level.lazar);
  var_e2d370cc = struct::get("exfil_choose_park");
  var_e2d370cc util::create_cursor_hint(undefined, undefined, #"hash_6a6f310d70076147", 1000, 2, &function_4c0cb050);
  var_e2d370cc prompts::function_44d7831a(#"use", 1);
  var_e2d370cc prompts::function_b95d71cd(#"use", 15);
  var_e2d370cc prompts::function_2557566(#"use", 10);
  var_e2d370cc prompts::function_1a5e1da6(#"use", 1, level.park);
  level thread function_b35624bf();
}

function function_b35624bf() {
  level endon(#"hash_111283e0a76017f6");
  wait 13;
  var_e2d370cc = struct::get("exfil_choose_park");
  var_74e225bb = struct::get("exfil_choose_lazar");
  var_e2d370cc util::remove_cursor_hint();
  var_74e225bb util::remove_cursor_hint();
  level flag::set("flg_no_choice");
  namespace_232ddc52::music("14.3_airhook_fail");
  level thread namespace_a789f8ae::function_d4b87197();
  wait 3.5;
  level.player clientfield::set_to_player("skyhook_speedblur", 1);
  wait 0.5;
  level.player playrumblelooponentity("fallwind_loop_fast");
  level.player player_decision::function_ff7e19cb(2);
  level waittill(#"hash_a70f40cee5c3f00");
  level.player clientfield::set_to_player("skyhook_speedblur", 0);
  player_decision::function_8c0836dd(0);
  skipto::function_1c2dfc20("cp_ger_hub_post_cuba");
}

function function_6edd5850(s_info) {
  level notify(#"hash_111283e0a76017f6");
  level flag::set("flg_choice_made");
  namespace_232ddc52::music("14.2_airhook_lazar");
  var_79964af3 = struct::get("exfil_choose_park");
  var_79964af3 util::remove_cursor_hint();
  level thread namespace_a789f8ae::function_5bbd4049();
  wait 8;
  level.player clientfield::set_to_player("skyhook_speedblur", 1);
  wait 0.5;
  level.player playrumblelooponentity("fallwind_loop_fast");
  player_decision::function_ff7e19cb(1);
  function_bfdf76e6(1);
  level waittill(#"hash_a70f40cee5c3f00");
  level.player clientfield::set_to_player("skyhook_speedblur", 0);
  player_decision::function_8c0836dd(2);
  player_decision::function_8c0836dd(0);
  skipto::function_1c2dfc20("cp_ger_hub_post_cuba");
}

function function_e179de40() {
  level endon(#"hash_a70f40cee5c3f00");
  level flag::wait_till("flg_saved_lazar");
  wait 7;
  var_10489ce6 = spawner::simple_spawn("exfil_ally_killers");

  foreach(guy in var_10489ce6) {
    guy thread ai::shoot_at_target("normal", getent("exfil_killers_shoot_at_skyhook", "targetname"), "tag_origin", 10, 100, 1);
  }
}

function function_4c0cb050(s_info) {
  level notify(#"hash_111283e0a76017f6");
  level flag::set("flg_choice_made");
  namespace_232ddc52::music("14.1_airhook_park");
  var_79964af3 = struct::get("exfil_choose_lazar");
  var_79964af3 util::remove_cursor_hint();
  level thread namespace_a789f8ae::function_67b48edc();
  wait 11.5;
  level.player clientfield::set_to_player("skyhook_speedblur", 1);
  wait 0.5;
  level.player playrumblelooponentity("fallwind_loop_fast");
  player_decision::function_ff7e19cb(0);
  function_bfdf76e6(0);
  level waittill(#"hash_a70f40cee5c3f00");
  level.player clientfield::set_to_player("skyhook_speedblur", 0);
  player_decision::function_8c0836dd(1);
  player_decision::function_8c0836dd(0);
  skipto::function_1c2dfc20("cp_ger_hub_post_cuba");
}

function function_bfdf76e6(var_25d15bed) {
  persistent = savegame::function_6440b06b(#"persistent");

  if(var_25d15bed) {
    level.player stats::function_505387a6(#"hash_4450cbdb180d702", #"hash_38712d5dfff8ad31", 1);
    persistent.var_d3b4c6d6 = 1;
  } else {
    level.player stats::function_505387a6(#"hash_4450cbdb180d702", #"hash_5e8b1deaf714af9b", 1);
    persistent.var_dd5d7d77 = 1;
  }

  var_6685b283 = persistent.var_d3b4c6d6 === 1 || level.player stats::function_e3eb9a8b(#"hash_4450cbdb180d702", #"hash_38712d5dfff8ad31");
  var_9cb802f6 = persistent.var_dd5d7d77 === 1 || level.player stats::function_e3eb9a8b(#"hash_4450cbdb180d702", #"hash_5e8b1deaf714af9b");

  if(var_6685b283 && var_9cb802f6) {
    level.player stats::function_dad108fa(#"hash_7aecba645ac8f6af", 1);
  }
}

function function_442dca4f() {
  level endon(#"hash_a70f40cee5c3f00");
  level flag::wait_till("flg_saved_park");
  wait 10;
  var_10489ce6 = spawner::simple_spawn("exfil_ally_killers");

  foreach(guy in var_10489ce6) {
    guy thread ai::shoot_at_target("normal", getent("exfil_killers_shoot_at_skyhook", "targetname"), "tag_origin", 10, 100, 1);
  }
}

function function_cc48b106() {
  level endon(#"flg_choice_made");
  var_e8a9ad8 = struct::get_array("wave_3_smoke", "targetname");

  foreach(var_10ed23ba in var_e8a9ad8) {
    e_grenade = level.player magicgrenadeplayer(getweapon(#"willy_pete"), var_10ed23ba.origin, (0, 0, 0));
    e_grenade.var_3791d005 = 0;
    wait randomfloatrange(0.5, 1);
  }
}

function function_ac6f37f4() {
  level endon(#"flg_ac130_active");
  level endon(#"flg_skyhook_interacted");
  wait 3;
  var_6e1d93e1 = spawner::simple_spawn("exfil_skyhook_guys_1");
  var_ee2b13fe = spawner::simple_spawn("exfil_skyhook_guys_2");
  var_d81b9fd6 = arraycombine(var_6e1d93e1, var_ee2b13fe);

  foreach(guy in var_d81b9fd6) {
    if(isalive(guy)) {
      guy.script_accuracy = 0.2;
    }
  }

  wait 10;

  foreach(guy in var_d81b9fd6) {
    if(isalive(guy)) {
      guy.script_accuracy = 0.4;
    }
  }

  wait 8;

  foreach(guy in var_d81b9fd6) {
    if(isalive(guy)) {
      guy.script_accuracy = 0.7;
    }
  }

  wait 5;

  foreach(guy in var_d81b9fd6) {
    if(isalive(guy)) {
      guy.script_accuracy = 20;
    }
  }

  wait 5;

  foreach(guy in var_d81b9fd6) {
    if(isalive(guy)) {
      guy.script_accuracy = 1000;
    }
  }
}

function function_68558af9() {
  level endon(#"flg_ac130_done");
  var_77b3f074 = getent("back_left_gl_splash_trig", "targetname");
  var_81d24c08 = struct::get("gl_splash_damage_origin", "targetname");

  while(true) {
    var_a516b962 = var_77b3f074 waittill(#"damage");

    if(var_a516b962.weapon == getweapon(#"hash_c21b61b32a5d972")) {
      break;
    }
  }

  radiusdamage(var_81d24c08.origin, 500, 1000, 200, level.player, "MOD_EXPLOSIVE");
}

function function_29758311() {
  level endon(#"hash_5dfc215255b7bf4");
  level.var_dab73f4a = 1;
  self notifyonplayercommand("ac130_support", "+actionslot 4");
  self thread util::show_hint_text(#"hash_28625d21da426e88", 0, "ac130_support", 8);
  self waittilltimeout(8, #"ac130_support");
  level thread function_e1201e79();
  level thread function_353a1ac4();
  level.var_6df062d7 = 0;
  callback::on_actor_killed(&function_2bc3e89c);
  level flag::set("flg_ac130_active");
  snd::client_msg("audio_ac130_started");
  level.player val::set(#"hash_5b59d8b239c4c3f4", "takedamage", 0);
  weap = getweapon("ac130");

  if(isDefined(weap)) {
    self giveweapon(weap);
    self switchtoweapon(weap);
    wait 0.3;
  }

  namespace_8bcd067b::function_1c110d7a(getent("ac130_center_point", "targetname").origin, 8000, 8000 * (cos(60), sin(60), 0));
  self killstreaks::give("ac130");
  self killstreaks::usekillstreak("ac130", 0);
  self thread function_d057152("veh_t9_mil_us_air_gunship_cp_nic_rev");

  if(isDefined(weap)) {
    wait 4;
    self takeweapon(weap);
  }

  wait 15;
  level scene::init("scene_rev_5045a_rtp_balloon_defend");
  waitframe(1);

  if(level.player istouching(level.park)) {
    var_d9445fa5 = (level.player.origin[0], level.park.origin[1] - 32, level.player.origin[2]);
    level.player setorigin(var_d9445fa5);
  }

  wait 2;
  level flag::set("flg_ac130_done");
  snd::client_msg("audio_ac130_stopped");
  cp_nic_revolucion_fx::function_bf0e01f7();
  level.player val::reset(#"hash_5b59d8b239c4c3f4", "takedamage");
}

function function_d057152(model) {
  self notify("19faab47e0833f0b");
  self endon("19faab47e0833f0b");

  while(!isDefined(level.ac130)) {
    waitframe(1);
  }

  level.ac130 setModel(model);
}

function function_501002d8(damage_trigger, fx_struct) {
  level endon(#"flg_ac130_done");

  while(true) {
    var_7b1b5529 = damage_trigger waittill(#"damage");

    if(var_7b1b5529.mod === "MOD_PROJECTILE_SPLASH") {
      playFX(level._effect[#"hash_711a6d544750ccfb"], fx_struct.origin + (0, 0, 50));
      break;
    }
  }
}

function function_e1201e79() {
  level endon(#"flg_ac130_done");
  damage_trigger = getent("ac130_player_killed_volume", "targetname");

  while(true) {
    var_7b1b5529 = damage_trigger waittill(#"damage");

    if(var_7b1b5529.attacker === level.player) {
      util::missionfailedwrapper(#"hash_7a06af99487afaec");
    }
  }
}

function function_353a1ac4() {
  level endon(#"flg_ac130_done");
  damage_trigger = getent("ac130_player_shot_balloon_volume", "targetname");
  var_9d262a11 = (40, 40, -10);
  level thread function_b8f67d09(damage_trigger.origin + var_9d262a11);

  while(true) {
    var_7b1b5529 = damage_trigger waittill(#"damage");

    if(var_7b1b5529.attacker === level.player) {
      util::missionfailedwrapper(#"hash_6375a3b33d847442");
    }
  }
}

function private function_b8f67d09(origin) {
  highlight_ent = util::spawn_model("tag_origin", origin, (0, 0, 0));
  setsaveddvar(#"hash_31ce52f5659190ee", highlight_ent getentitynumber());
  level waittill(#"flg_ac130_done");
  setsaveddvar(#"hash_31ce52f5659190ee", -1);
  highlight_ent delete();
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x8c>");

  level.player stoprumble("fallwind_loop_fast");
}
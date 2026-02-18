/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6daaa06aadd7d155.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_290b454abd681dd4;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_52da18c20f45c56a;
#using script_7409560e3a0c9884;
#using script_eb1a9e047313195;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\evac;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\killstreaks\cp\ac130;
#using scripts\killstreaks\killstreaks_shared;
#namespace namespace_19fc4094;

function function_4b8cec86(var_d3440450) {
  level flag::set("tundra_intro_done");
  level flag::set("player_is_rappelling");
  level flag::set("player_rappel_done");
  level flag::set("flag_picture_vo_finished");
  level battlechatter::function_2ab9360b(1);
  level thread namespace_ba979a10::setup_allies();
  level.var_85b00b2b = undefined;
  waitframe(1);
  level.woods thread namespace_ba979a10::function_c70f5d3();
  level thread namespace_ba979a10::function_d6af6077();
  level thread namespace_ba979a10::function_7fe34c6e();
}

function outro_main(var_d3440450, var_50cc0d4f) {
  level flag::wait_till("level_is_go");
  player = getplayers()[0];
  level notify(#"hash_146b46855a0f35b8");
  level flag::set("flag_spawn_motor_pool_enemies");
  level flag::set("flag_spawn_radar_enemies");
  level flag::set("flag_spawn_fuel_depot_enemies");
  level.var_9090a594 = # "hash_62df17fd9f467834";
  level.var_5bb760e8 = # "hash_375f464aa679494f";
  level.var_fe86dfc1 = 1;
  level.var_5e56e2a8 = 2048;
  level.var_5fc12b72 = 10;
  level.var_dd0b1f89 = 15;
  level.var_f7ac00e1 = # "hash_5ce979f55b4f6483";
  level.var_24f69721 = "scene_sm_tundra_heli_load";
  level thread function_8416099b();
  player thread function_df7926cc(var_50cc0d4f);
  level flag::wait_till("continue_evac_outro");
  player thread evac::main(player.origin, "start_evac_heli_infil", undefined, 2);
  player thread function_29758311();
  level thread function_8b371bd3();
  level thread function_45a92388();
  level thread function_619efcd8();
  level waittill(#"evac_helicopter_board_trigger");
  objectives::complete("exfil");

  if(player_decision::function_e40c7d56() == 3) {
    player stats::function_dad108fa(#"hash_7af2992eebf41338", 1);
  }

  level.player.oobdisabled = 1;
  wait 6;
  thread util::screen_fade_out(3);
  snd::client_msg(#"hash_305dcf2b80864ec");
  wait 3;
  safehouse = skipto::function_6914f647();
  skipto = skipto::function_547ca7d2(safehouse);
  skipto::function_1c2dfc20(safehouse, skipto);
  level waittill(#"never");
}

function function_8416099b() {
  level endon(#"continue_evac_outro");
  waitframe(1);
  level util::delay(40, undefined, &flag::set, "continue_evac_outro");

  while(true) {
    if(!flag::get("evac_player_left_building")) {
      break;
    }

    if(level flag::get("smoke_tossed")) {
      break;
    }

    waitframe(1);
  }

  level flag::set("continue_evac_outro");
}

function init_flags() {}

function cleanup(name, starting, direct, player) {}

function function_40ceace8() {
  if(is_true(level.player getnoncheckpointdata("thrown_smoke_hint"))) {
    wait 3;
    return;
  }

  wait 1;
  level.player freezecontrols(1);
  hint_tutorial::function_4c2d4fc4(#"hash_16785e69a5ae33b8", #"hash_2d09e9a82cb227f8");
  hint_tutorial::pause();
  wait 0.1;
  level.player freezecontrols(0);
  level.player setnoncheckpointdata("thrown_smoke_hint", 1);
}

function function_8b371bd3() {
  player = getplayers()[0];
  level flag::wait_till("smoke_tossed");
  player dialogue::queue("vox_cp_rcir_01300_masn_smokeout_98");
  wait 1;
  dialogue::radio("vox_cp_rcir_01300_pilo_choppersjustafe_d3");
  level thread function_13a1ac05();
  wait 4;
  level.woods dialogue::radio("vox_cp_rcir_01300_wood_looksharpmoreon_c2");
  wait 10;
  level.woods dialogue::radio("vox_cp_rcir_01300_wood_redsincoming_23");
  wait 10;
  level.woods dialogue::radio("vox_cp_rcir_01300_wood_itsanassholepar_d7");
  wait 15;
  dialogue::radio("vox_cp_rcir_01300_pilo_hangonimnearlyt_7e");
  wait 10;
  dialogue::radio("vox_cp_rcir_01300_pilo_eyesonsmoketouc_46");
  level flag::wait_till("flag_evac_stop_smoke");
  dialogue::radio("vox_cp_rcir_01300_wood_aboutfuckingtim_f2");
  level.woods dialogue::radio("vox_cp_rcir_01300_wood_movingtomyexfil_b4");

  if(!level flag::get("evac_helicopter_board_trigger")) {
    level.woods dialogue::radio("vox_cp_rcir_01300_wood_dontfuckingforg_c0");
  }

  if(!level flag::get("evac_helicopter_board_trigger")) {
    level.woods dialogue::radio("vox_cp_rcir_01300_wood_illseeyouinafew_fe");
  }

  level waittill(#"evac_helicopter_board_trigger");
  dialogue::radio("vox_cp_rcir_01300_wood_niceworkdownthe_ea");
  dialogue::radio("vox_cp_rcir_01300_wood_ithinkperseusis_49");
}

function function_13a1ac05() {
  wait 10;
  level flag::set("ac130_allowed");
}

function function_619efcd8() {
  level endon(#"evac_helicopter_board_trigger");
  level flag::wait_till("evac_chopper_landed");
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_rcir_01300_wood_letsgohomeslice_bc";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01300_wood_getonthedamncho_27";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01300_wood_moveyourasssowe_fc";
  speaker[speaker.size] = level.woods;
  wait 25;
  i = 0;

  while(!level flag::get("evac_helicopter_board_trigger")) {
    speaker[i] dialogue::queue("" + nags[i]);
    i++;

    if(i >= nags.size) {
      i = 0;
    }

    wait 25;
  }
}

function function_45a92388() {
  level endon(#"hash_5dfc215255b7bf4");
  level endon(#"ac130_support_used");
  level thread function_d78fcf75();
  level flag::wait_till("ac130_allowed");
  dialogue::radio("vox_cp_rcir_01300_cmnd_masonwehaveairs_f0");
  wait 0.5;
  dialogue::radio("vox_cp_rcir_01300_cmnd_callitinifyoune_c3");
  wait 15;
  level.woods dialogue::radio("vox_cp_rcir_01300_wood_tangoseverywher_e3");
  wait 15;
  level.woods dialogue::radio("vox_cp_rcir_01300_wood_mightwanttocall_14");
}

function function_d78fcf75() {
  player = getplayers()[0];
  level flag::wait_till("ac130_support_used");
  player dialogue::queue("vox_cp_rcir_01300_masn_senditin_9f");
  dialogue::radio("vox_cp_rcir_01300_pilo_rogerthat_fe");
  level.woods dialogue::queue("vox_cp_rcir_01300_wood_timetorainsomep_19");
}

function function_de351837() {
  level endon(#"smoke_tossed");
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_rcir_01300_cmnd_masonwecantbrin_1f";
  speaker[speaker.size] = level.woods;
  nags[nags.size] = "vox_cp_rcir_01300_cmnd_whatsyoursituat_19";
  speaker[speaker.size] = level.woods;
  wait 20;
  i = 0;

  while(!level flag::get("smoke_tossed")) {
    speaker[i] dialogue::queue("" + nags[i]);
    i++;

    if(i >= nags.size) {
      i = 0;
    }

    wait 15;
  }
}

function function_503fd35b() {
  self endon(#"stop_smoke_throw_hint");
  self waittill(#"hash_338ed48ff527b98c");
  wait 0.5;
  waittime = 8;

  while(true) {
    self thread util::show_hint_text(#"hash_8626041b4a29d", 0, "stop_smoke_throw_hint", waittime);
    wait waittime * 2;
  }
}

function function_b8b78cfa() {
  self endon(#"stop_smoke_throw_hint");
  secondaryoffhand = getweapon(#"willy_pete");
  self giveweapon(secondaryoffhand);
  self setweaponammoclip(secondaryoffhand, 1);
  self setweaponammostock(secondaryoffhand, 1);
  self switchtooffhand(secondaryoffhand);
  self notify(#"hash_338ed48ff527b98c");
}

function function_df7926cc(var_50cc0d4f) {
  if(var_50cc0d4f) {
    wait 4;
  }

  level flag::wait_till("flag_picture_vo_finished");
  self thread function_503fd35b();
  self notifyonplayercommand("evac_smoke_out", "+actionslot 1");
  self notifyonplayercommand("evac_smoke_out", "+actionslot 1");
  function_40ceace8();
  thread savegame::checkpoint_save(1);

  if(self gamepadusedlast()) {
    self notifyonplayercommand("evac_smoke_out", "+actionslot 1");
  } else {
    self notifyonplayercommand("evac_smoke_out", "+actionslot 3");
  }

  thread function_b8b78cfa();
  level thread function_de351837();

  while(true) {
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;

    if(grenade.model == # "wpn_t9_eqp_smoke_grenade_projectile") {
      break;
    }
  }

  self notify(#"stop_smoke_throw_hint");
  grenade makegrenadedud();
  ret = grenade waittilltimeout(10, ["death", #"projectile_impact", #"explode"]);
  level.var_a16d9e19 = grenade.origin;
  evac::function_d1e14c76(level.var_a16d9e19);
  e_vol = getent("volume_evac_loc", "targetname");

  if(isDefined(e_vol) && isDefined(level.var_dc8cac2a)) {
    e_vol.origin = level.var_a16d9e19;
    level.var_dc8cac2a[level.var_dc8cac2a.size] = e_vol;
  }

  self util::delay(1, undefined, &flag::set, "start_evac_heli_infil");
  wait 2;
  level flag::set("smoke_tossed");
  level thread namespace_c1cfab6c::function_ac85ea08();
  level thread function_c32ef30a();
}

function function_c32ef30a() {
  level waittill(#"evac_chopper_landed");
  level.var_85b00b2b = # "hash_73070752ddd02cad";
  level flag::set("woods_pause_overwatch");
  savegame::checkpoint_save(1);
  level thread namespace_ba979a10::function_7094e60a();
  level thread evac::function_ec8bba3b("evac_heli_kill");
  level thread namespace_ba979a10::function_fe17f833();
  level flag::wait_till("evac_helicopter_board_trigger");
  level thread namespace_ae270045::function_5e3101b2();
}

function function_29758311() {
  level endon(#"hash_5dfc215255b7bf4");
  level endon(#"flag_evac_exfil_ready");
  level flag::wait_till("ac130_allowed");
  self notifyonplayercommand("ac130_support", "+actionslot 3");
  self thread util::show_hint_text(#"hash_61be2df0c12c63bb", 0, "ac130_support", 10);
  self waittill(#"ac130_support");

  if(self flag::get("in_action")) {
    level action_utility::function_396e2076();
    self flag::wait_till_clear("in_action");
  }

  level flag::set("ac130_support_used");
  thread function_f0b82c4a(level.player.origin);
  weap = getweapon("ac130");

  if(isDefined(weap)) {
    self giveweapon(weap);
    self switchtoweapon(weap);
    level.var_dd0b1f89 = 8;
    level flag::set("evac_start_next_wave");
    level.player playrumbleonentity(#"damage_light");
    wait 0.3;
    level.var_dd0b1f89 = 15;
  } else {
    level.player playrumbleonentity(#"damage_light");
    level flag::set("evac_start_next_wave");
  }

  level.player val::set(#"hash_7645d8013148a52a", "takedamage", 0);
  level.player thread function_9c5feec7(weap);
  namespace_8bcd067b::function_1c110d7a(level.player getorigin(), 8000);
  self killstreaks::give("ac130");
  self killstreaks::usekillstreak("ac130", 0);

  if(isDefined(weap)) {}

  ret = self waittill(#"gunner_left", #"hash_b7f6494fbf8dd9d");
}

function function_f0b82c4a(org) {
  var_c85f2d8e = ["tundra_ac130_fb_veh1", "tundra_ac130_fb_veh2", "tundra_ac130_fb_veh3"];
  vehs = [];
  var_6eacda7b = struct::get("bunker_center_struct", "targetname");

  if(isDefined(var_6eacda7b) && distance2d(var_6eacda7b.origin, org) < 1024) {
    foreach(var_af1a2359 in var_c85f2d8e) {
      vehs[vehs.size] = vehicle::simple_spawn_single_and_drive(var_af1a2359);
      waitframe(1);
    }
  }
}

function function_9c5feec7(weap) {
  var_a80e07df = 25;

  if(isDefined(level.ac130.killstreak_duration)) {
    var_a80e07df = level.ac130.killstreak_duration / 1000 + 2;
  }

  self waittilltimeout(var_a80e07df, #"gunner_left", #"hash_b7f6494fbf8dd9d");

  if(getaiteamarray("axis").size < 7) {
    level flag::set("evac_start_next_wave");

    iprintln("<dev string:x38>");
  }

  wait 2;
  level.player val::reset(#"hash_7645d8013148a52a", "takedamage");

  if(isDefined(weap)) {
    wait 4;
    self takeweapon(weap);
  }
}
/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_vengeance_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\voice\voice_vengeance;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\music_shared;
#using scripts\shared\stealth;
#using scripts\shared\stealth_vo;
#using scripts\shared\util_shared;
#namespace cp_mi_sing_vengeance_sound;

function main() {
  voice_vengeance::init_voice();
  clientfield::register("toplayer", "slowmo_duck_active", 1, 2, "int");
  level.music_ent = spawn("script_origin", (0, 0, 0));
  thread function_36f2421a();
  level thread function_13172f06();
  level thread function_6ab7f285();
}

function function_6ab7f285() {
  level waittill("hash_dcd7454a");
  util::clientnotify("sndCafe");
  level thread function_bf4fd572();
  level waittill("hash_654ba091");
  util::clientnotify("sndCafeEnd");
}

function function_bf4fd572() {
  level waittill("scene_skip_sequence_started");
  util::clientnotify("sndCafeOR");
}

function function_4368969a() {}

function apartment_init() {
  stealth::function_76c2ffe4("unaware");
}

function function_7be69db9() {
  stealth::function_76c2ffe4("unaware");
}

function function_749aad88() {
  stealth::function_76c2ffe4("unaware");
  level thread namespace_9fd035::function_e18f629a();
}

function function_34d7007d() {}

function garage_init() {
  level thread namespace_9fd035::function_f64b08fb();
  level thread namespace_9fd035::function_46333a8a();
}

function function_d56e8ba6() {
  thread function_9d83fdd3("mus_combat", 1, 3);
}

function function_1fc1836b() {
  thread function_9d83fdd3("mus_medium", 1, 3);
}

function function_1a02fe3() {
  thread function_9d83fdd3("mus_stealth_high_temp", 1);
}

function intro_complete() {
  stealth::function_76c2ffe4("unaware");
}

function function_6dcacaf4() {
  playsoundatposition("evt_intro_trucks_by", (18398, -4638, 324));
}

function function_677a24e2() {
  playsoundatposition("evt_apt_upstairs_fight", (19517, -5375, 475));
  playsoundatposition("evt_apt_int_panic_1", (19517, -5375, 475));
  wait(2);
  playsoundatposition("evt_apt_win_gunfire_1", (19517, -5375, 475));
}

function function_13172f06() {
  trigger = getent("trigger_wood_creak", "targetname");
  if(!isdefined(trigger)) {
    return;
  }
  trigger waittill("trigger");
  playsoundatposition("evt_apt_wood_creak", (19421, -5113, 347));
}

function function_afc6fda4() {
  playsoundatposition("evt_apt_upstairs_thud", (19536, -5447, 467));
  playsoundatposition("evt_apt_int_panic_2", (19517, -5375, 475));
}

function function_57ec1ad7() {
  playsoundatposition("evt_apt_int_panic_3", (19517, -5375, 475));
}

function takedown_scene() {
  playerlist = getplayers();
  foreach(player in playerlist) {
    thread function_a66aea7e(player);
    thread function_fe8ea4c4(player);
  }
  level.ai_hendricks waittill("takedown_start");
  thread function_4f84abfa();
  level.ai_hendricks waittill("start_slowmo");
  thread function_a339da70();
}

function function_a66aea7e(player) {
  player endon("death");
  player endon("disconnect");
  player waittill("hash_b8988b75");
  if(!isdefined(player.anim_debug_name)) {
    return;
  }
  if(player.anim_debug_name == "player 1") {
    player playsoundtoplayer("evt_takedown_setup_player1", player);
  } else {
    if(player.anim_debug_name == "player 2") {
      player playsoundtoplayer("evt_takedown_setup_player2", player);
    } else {
      if(player.anim_debug_name == "player 3") {
        player playsoundtoplayer("evt_takedown_setup_player3", player);
      } else if(player.anim_debug_name == "player 4") {
        player playsoundtoplayer("evt_takedown_setup_player4", player);
      }
    }
  }
}

function function_fe8ea4c4(player) {
  player endon("death");
  player endon("disconnect");
  level.ai_hendricks waittill("takedown_start");
  if(!isdefined(player.anim_debug_name)) {
    return;
  }
  if(player.anim_debug_name == "player 1") {
    player playsoundtoplayer("evt_takedown_player1_slide", player);
    player playsoundtoplayer("evt_takedown_player1_foley", player);
    player playsoundtoplayer("evt_takedown_player1", player);
  } else {
    if(player.anim_debug_name == "player 2") {
      player playsoundtoplayer("evt_takedown_player2_foley", player);
      player playsoundtoplayer("evt_takedown_player2", player);
    } else {
      if(player.anim_debug_name == "player 3") {
        player playsoundtoplayer("evt_takedown_player3_foley", player);
        player playsoundtoplayer("evt_takedown_player3", player);
      } else if(player.anim_debug_name == "player 4") {
        player playsoundtoplayer("evt_takedown_player4_foley", player);
        player playsoundtoplayer("evt_takedown_player4", player);
      }
    }
  }
}

function function_4f84abfa() {
  thread function_9430961e(1.5);
  stealth::function_862e861f(1.5);
  playerlist = getplayers();
  foreach(player in playerlist) {
    player playsoundtoplayer("evt_takedown_slowmo_01", player);
    player playsoundtoplayer("evt_takedown_hendricks_shot_low", player);
  }
  playsoundatposition("evt_takedown_hendricks_shot", (20387, -4854, 401));
  level thread namespace_9fd035::function_fedfbdb0();
  wait(0.6);
  playsoundatposition("veh_siege_bot_disable", (20692, -4683, 224));
}

function function_a339da70() {
  playerlist = getplayers();
  foreach(player in playerlist) {
    player playsoundtoplayer("evt_takedown_slowmo_02", player);
    player clientfield::set_to_player("slowmo_duck_active", 1);
  }
}

function function_69fc18eb() {
  playerlist = getplayers();
  foreach(player in playerlist) {
    player playsoundtoplayer("evt_takedown_slowmo_exit", player);
    player clientfield::set_to_player("slowmo_duck_active", 0);
  }
  thread function_9d83fdd3("mus_combat", 1);
  level waittill("hash_3d3af5a5");
  function_9430961e(3);
  stealth::function_76c2ffe4("unaware");
}

function takedown_siegebot(siege) {
  siege waittill("hash_76ee36bc");
  playsoundatposition("evt_siegebot_death_anim", siege.origin);
  playsoundatposition("evt_siegebot_powerdown", siege.origin);
}

function function_68da61d9() {
  playsoundatposition("evt_civ_running", (20892, -2913, 204));
  wait(1.2);
  playsoundatposition("wpn_sfb_fire_npc", (20971, -2670, 187));
}

function function_b3768e28() {
  wait(0.5);
  playsoundatposition("amb_alley_ambient_expl", (22979, 1285, 162));
}

function function_2afbdce() {
  playsoundatposition("amb_alley_gate_rattle", (22103, 1982, 135));
}

function function_10de79ba() {
  function_9430961e(3);
  wait(3);
  function_9d83fdd3("mus_stealth_high_temp", 1);
}

function function_af95bc45() {
  thread function_a2c917e3();
  wait(2.9);
  function_9430961e(0.25);
  playsoundatposition("evt_quad_tank_approach", (-18946, -17409, 151));
}

function function_a2c917e3() {
  playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, 151));
  wait(1);
  playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, 151));
  wait(1);
  playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, 151));
  wait(1);
  playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, 151));
}

function function_5bd9fe4() {
  wait(0.5);
  playsoundatposition("evt_quad_tank_enter", (-18946, -17409, 151));
  level thread namespace_9fd035::function_8d18c8bc();
  level flag::wait_till("quad_tank_dead");
  level thread namespace_9fd035::function_fa2e45b8();
}

function function_a34878f1(player) {
  player playlocalsound("dst_rock_quake");
}

function backdraft(org) {
  playsoundatposition("amb_fire_burst", org);
  ent = spawn("script_origin", org);
  ent playloopsound("amb_fire_medium");
}

function function_c4ece2ab() {
  playsoundatposition("dst_rock_quake_big", (-19005, -12018, 119));
  wait(1);
  playsoundatposition("evt_stairwell_shake_02", (-19005, -12018, 119));
  playsoundatposition("evt_stairwell_shake_04", (-18981, -11953, 95));
  wait(0.25);
  playsoundatposition("evt_stairwell_shake_03", (-19022, -12075, 102));
  wait(0.35);
  playsoundatposition("evt_stairwell_shake_01", (-18923, -12014, 14));
}

function function_47d9d5db() {
  stealth_vo::function_5714528b("enemy_right", "hend_on_your_right_1");
  stealth_vo::function_5714528b("enemy_left", "hend_on_your_left_1");
  stealth_vo::function_5714528b("enemy_ahead", "hend_tango_directly_ahead_1");
  stealth_vo::function_5714528b("enemy_behind", "hend_tango_behind_you_1");
  stealth_vo::function_5714528b("enemy_above", "hend_enemy_above_you_1");
  stealth_vo::function_5714528b("enemy_below", "hend_below_you_1");
  stealth_vo::function_5714528b("good_kill", "hend_good_kill_1");
  stealth_vo::function_5714528b("good_kill_bullet", "hend_nice_shot_1");
  stealth_vo::function_5714528b("good_kill_impressive", "hend_impressive_0");
  stealth_vo::function_5714528b("close_call", "hend_that_was_close_1");
  stealth_vo::function_5714528b("investigating", "hend_they_re_looking_arou_1");
  stealth_vo::function_5714528b("investigating", "hend_get_outta_sight_1");
  stealth_vo::function_5714528b("investigating", "hend_you_spooked_em_hid_1");
  stealth_vo::function_5714528b("returning", "hend_you_re_clear_threat_0");
  stealth_vo::function_5714528b("returning", "hend_all_clear_they_re_m_1");
  stealth_vo::function_5714528b("spotted", "hend_kill_em_quick_0");
  stealth_vo::function_5714528b("spotted", "hend_take_em_down_quick_1");
  stealth_vo::function_5714528b("spotted_sniper", "hend_sniper_spotted_you_1");
  stealth_vo::function_5714528b("spotted_sniper", "hend_snipers_on_the_roofs_1");
  stealth_vo::function_5714528b("spotted_drone", "hend_drone_has_you_target_1");
  stealth_vo::function_5714528b("spotted_drone", "hend_drone_is_tracking_yo_1");
  stealth_vo::function_5714528b("careful", "hend_easy_wait_till_no_o_1");
  stealth_vo::function_5714528b("careful_hack", "hend_that_drone_could_be_1");
  stealth_vo::function_5714528b("careful_hunter", "hend_don_t_even_think_abo_1");
  stealth_vo::function_5714528b("careful_tricky", "hend_that_s_too_tricky_i_0");
  stealth::function_8bb61d8e("unaware", "mus_stealth_low_temp");
  stealth::function_8bb61d8e("low_alert", "mus_stealth_high_temp");
  stealth::function_8bb61d8e("high_alert", "mus_stealth_high_temp");
  stealth::function_8bb61d8e("combat", "mus_highalert_temp");
}

function function_9d83fdd3(alias, is_loop, var_aa56a49b) {
  if(is_loop) {
    fade = 0;
    if(isdefined(var_aa56a49b)) {
      fade = var_aa56a49b;
    }
    level.music_ent playloopsound(alias, fade);
  } else {
    foreach(player in getplayers()) {
      player playsoundtoplayer(alias, player);
    }
  }
}

function function_9430961e(fade) {
  level.music_ent stoploopsound(fade);
}

function function_36f2421a() {}

function function_6fd5af18() {
  level waittill("hash_126ce70b");
  iprintlnbold("anim1 started");
}

function function_e1dd1e53() {
  level waittill("hash_a06577d0");
  iprintlnbold("anim2 started");
}

function function_bbdaa3ea() {
  level waittill("hash_c667f239");
  iprintlnbold("anim3 started");
}

#namespace namespace_9fd035;

function function_973b77f9() {
  music::setmusicstate("none");
}

function function_7dc66faa() {
  music::setmusicstate("igc_1_intro");
}

function function_d4c52995() {
  music::setmusicstate("tension_loop");
}

function function_fedfbdb0() {
  music::setmusicstate("igc_2_zipline");
}

function function_9b52c0fa() {
  music::setmusicstate("skirmish");
}

function function_e18f629a() {
  wait(3);
  music::setmusicstate("tension_loop_2");
}

function function_862430bd() {
  music::setmusicstate("igc_3_open_door");
}

function function_791dd03() {
  music::setmusicstate("tension_loop_3");
}

function function_fa2e45b8() {
  music::setmusicstate("battle_1");
}

function function_c270e327() {
  wait(3);
  music::setmusicstate("igc_4_goh");
}

function function_8d18c8bc() {
  music::setmusicstate("quad_battle");
}

function function_58779b4() {
  music::setmusicstate("sniper_battle");
}

function function_46333a8a() {
  music::setmusicstate("battle_3");
}

function function_83763d08() {
  music::setmusicstate("igc_5_statue");
}

function function_b83aa9c5() {
  music::setmusicstate("battle_4");
}

function function_c8bfdb76() {
  wait(1);
  music::setmusicstate("igc_6_outro");
}

function function_14592f48() {
  music::setmusicstate("dyn_battle");
}

function function_e6a33cb1() {
  music::setmusicstate("rachael_underscore");
}

function function_dad71f51(state) {
  level endon("hash_d3bbbf2c");
  if(isdefined(state)) {
    music::setmusicstate(state);
  }
  level thread function_484281f1();
  while (true) {
    level flag::wait_till_any(array("stealth_combat", "stealth_alert", "stealth_discovered"));
    wait(0.05);
    if(level flag::get("stealth_discovered")) {
      level flag::wait_till_clear("stealth_discovered");
    } else {
      if(level flag::get("stealth_combat")) {
        wait(0.5);
        if(level flag::get("stealth_combat")) {
          wait(5);
        }
      } else if(level flag::get("stealth_alert")) {
        wait(0.5);
        if(level flag::get("stealth_alert")) {
          music::setmusicstate("dyn_aware");
          wait(1);
        }
      }
    }
    wait(0.05);
  }
}

function function_f64b08fb(state) {
  level notify("hash_d3bbbf2c");
  if(isdefined(state)) {
    music::setmusicstate(state);
  }
}

function function_484281f1() {
  level endon("hash_d3bbbf2c");
  while (true) {
    level flag::wait_till_clear_all(array("stealth_combat", "stealth_alert", "stealth_discovered"));
    wait(2);
    if(level flag::get("stealth_combat") || level flag::get("stealth_alert") || level flag::get("stealth_discovered")) {
      continue;
    }
    music::setmusicstate("tension_loop_2");
  }
}

function function_6c2fa1d0() {
  wait(1);
  playsoundatposition("mus_assassination_stinger", (0, 0, 0));
}
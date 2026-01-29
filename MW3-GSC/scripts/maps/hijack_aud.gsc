/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_aud.gsc
***************************************/

main() {
  maps\_audio::_id_16F4();
  maps\_audio::_id_1735("default");
  maps\_audio::_id_156E("med_occlusion");
  maps\_audio::_id_1740("rvn");
  _id_4ED4();
  _id_4ED3();
  _id_447D();
  _id_496E();
  _id_447F();
  _id_447E();
  _id_447C();
  maps\_audio_mix_manager::_id_1517("mix_hijack_global");
  _id_4ED6();
}

_id_4ED3() {
  common_scripts\utility::flag_init("stop_kitchen");
  common_scripts\utility::flag_init("stop_jet_falling");
  common_scripts\utility::flag_init("up_prezerog_rumble");
  common_scripts\utility::flag_init("conf_room_explosion1_go");
  common_scripts\utility::flag_init("conf_room_c4_plant_go");
  common_scripts\utility::flag_init("conf_room_explosion2_go");
  common_scripts\utility::flag_init("conf_room_shots_go");
  common_scripts\utility::flag_init("stop_typing_sound");
  common_scripts\utility::flag_init("stop_news_broadcast");
  common_scripts\utility::flag_init("turbine_exploded");
  common_scripts\utility::flag_init("kill_sirens");
  common_scripts\utility::flag_init("makarov_slow");
  common_scripts\utility::flag_init("player_dead");
}

_id_4ED4() {
  level._id_58A0 = 0;
  level._id_58A1 = 0;
  level._id_58A2 = 0;
  level._id_58A3 = 0;
  level._id_58A4 = 0;
  level._id_58A5 = 0;
  level._id_58A6 = 0;
  level._id_58A7 = 0;
  level._id_58A8 = 0;
  level._id_58A9 = 0;
  level._id_58AA = 0;
  level._id_58AB = 0;
  level._id_58AC = 0;
  level._id_58AD = 0;
  level._id_58AE = 0;
  level._id_58AF = 0;
  level._id_58B0 = 0;
  level._id_58B1 = 0;
}

_id_447D() {}

_id_496E() {}

_id_447F() {}

_id_447E() {}

_id_447C() {
  maps\_audio_mix_manager::_id_1509("mix_hijack_global");
  maps\_audio_mix_manager::_id_1509("bassline_mix");
  maps\_audio_mix_manager::_id_1509("debate_pre_breach_mix");
  maps\_audio_mix_manager::_id_1509("debate_checkpoint_mix");
  maps\_audio_mix_manager::_id_1509("door_breach_mix");
  maps\_audio_mix_manager::_id_1509("debate_post_breach_mix");
  maps\_audio_mix_manager::_id_1509("turb_mix");
  maps\_audio_mix_manager::_id_1509("zero_g_mix");
  maps\_audio_mix_manager::_id_1509("zero_g_ramp_mix");
  maps\_audio_mix_manager::_id_1509("post_zero_g_mix");
  maps\_audio_mix_manager::_id_1509("lowerlev_mix");
  maps\_audio_mix_manager::_id_1509("command_room_mix");
  maps\_audio_mix_manager::_id_1509("cargo_room_mix");
  maps\_audio_mix_manager::_id_1509("pre_crash_mix");
  maps\_audio_mix_manager::_id_1509("pre_crash_duck_mix");
  maps\_audio_mix_manager::_id_1509("crash_mix");
  maps\_audio_mix_manager::_id_1509("crash_breached_mix");
  maps\_audio_mix_manager::_id_1509("crash_death_mix");
  maps\_audio_mix_manager::_id_1509("ground_internal_mix");
  maps\_audio_mix_manager::_id_1509("ground_external_mix");
  maps\_audio_mix_manager::_id_1509("end_mix");
  maps\_audio_mix_manager::_id_1509("makarov_mix");
  maps\_audio_mix_manager::_id_1509("end_fade_mix");
  maps\_audio_mix_manager::_id_1509("debate_room_expl1_mix");
  maps\_audio_mix_manager::_id_1509("zero_g_moan_mix");
  maps\_audio_mix_manager::_id_1509("zero_g_bodyslam_mix");
  maps\_audio_mix_manager::_id_1509("lowerlev_roll_mix");
  maps\_audio_mix_manager::_id_1509("exterior_reveal_mix");
  maps\_audio_mix_manager::_id_1509("combat_explosion_mix");
  maps\_audio_mix_manager::_id_1509("kill_vo_mix");
}

_id_4ED6() {
  maps\_audio::_id_174C(::_id_58B2);
  maps\_audio::_id_174C(::_id_448C);
}

_id_58B2(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "start_airplane":
    case "default":
      thread _id_3FB6();
      maps\_audio_zone_manager::_id_156C("jet_normal_zone");
      thread _id_58E8();
      thread _id_58B3();
      thread _id_58B4();
      thread _id_58BC();
      break;
    case "debate":
      maps\_audio_zone_manager::_id_156C("debate_checkpoint_zone");
      thread _id_58E8();
      thread _id_58B3();
      break;
    case "start_pre_zero_g":
      maps\_audio_zone_manager::_id_156C("jet_turb_zone");
      thread _id_58D4();
      level._id_58A2 = 1;
      break;
    case "start_lower_level_combat":
      maps\_audio_zone_manager::_id_156C("jet_post_zero_g_zone");
      maps\_audio_music::_id_15A7("hijk_mx_lowerdeck_shootout");
      thread _id_58E7();
      thread _id_58E6();
      level._id_58A1 = 1;
      level._id_58A2 = 1;
      break;
    case "start_crash":
      maps\_audio_zone_manager::_id_156C("jet_command_room_zone");
      maps\_audio_music::_id_15A7("hijk_mx_lowerdeck_shootout");
      break;
    case "start_tarmac":
      maps\_audio_zone_manager::_id_156C("ground_internal_zone");
      level._id_58A5 = 1;
      thread _id_5914();
      break;
    case "start_tarmac_2":
      maps\_audio_zone_manager::_id_156C("ground_external_zone");
      level._id_58A5 = 1;
      level._id_58A8 = 1;
      level._id_58A7 = 1;
      thread _id_592C();
      break;
    case "start_post_tarmac":
      maps\_audio_zone_manager::_id_156C("ground_external_zone");
      level._id_58A5 = 1;
      level._id_58A8 = 1;
      break;
    case "start_end_scene":
      maps\_audio_zone_manager::_id_156C("ground_external_zone");
      level._id_58A5 = 1;
      level._id_58A8 = 1;
      level._id_58AF = 1;
      level._id_58B0 = 1;
      maps\_audio_music::_id_15A7("hijk_tarmac_combat_cp");
      thread _id_593A();
      thread _id_593B();
      thread _id_593C();
      thread _id_593D();
      thread _id_593E();
      thread _id_5937();
      break;
    case "intro_door1_open":
      var_3 = getent("intro_door1", "targetname");
      common_scripts\utility::play_sound_in_space("hijk_door1open", var_3.origin);
      break;
    case "pres_drops_paper":
      thread _id_58B9();
      break;
    case "hijk_cart_moves":
      thread _id_58BB();
      break;
    case "keypad":
      thread _id_58C0();
      break;
    case "hijk_agent_espresso":
      thread _id_58C1();
      break;
    case "start_news":
      thread _id_58C2();
      break;
    case "debate_door_close":
      thread _id_58C3();
      break;
    case "debate_room_start":
      if(level._id_58A2 == 0) {
        maps\_audio_zone_manager::_id_156C("debate_pre_breach_zone");
        level._id_58A2 = 1;
      }

      break;
    case "stop_news":
      common_scripts\utility::flag_set("stop_news_broadcast");
      thread _id_58C5();
      break;
    case "start_typing":
      thread _id_58BE();
      thread _id_58BF();
      break;
    case "conf_room_shots":
      common_scripts\utility::flag_set("conf_room_shots_go");
      common_scripts\utility::flag_set("stop_typing_sound");
      thread _id_58F3();
      thread _id_58EB();
      thread _id_58F1();
      thread _id_58C8();
      thread _id_58CA();
      break;
    case "conf_room_explosion1":
      common_scripts\utility::flag_set("conf_room_explosion1_go");
      break;
    case "seatbeltsign":
      thread _id_58EA();
      break;
    case "rumble_foley":
      thread _id_58CD();
      thread _id_58CE();
      thread _id_58CC();
      break;
    case "conf_room_plant_c4":
      common_scripts\utility::flag_set("conf_room_c4_plant_go");
      break;
    case "conf_room_explosion2":
      common_scripts\utility::flag_set("conf_room_explosion2_go");
      break;
    case "lets_kick_ass":
      thread _id_58CF();
      break;
    case "pre_turbulence_ready":
      level._id_58A0 = 1;
      break;
    case "pre_turbulence_start":
      if(level._id_58A0 == 1) {
        thread _id_58FE();
        level._id_58A0 = 0;
      }

      break;
    case "turbulence_start":
      if(level._id_58A1 == 0) {
        thread _id_58D3();
        level._id_58A1 = 1;
      }

      break;
    case "hallway_lurch":
      thread _id_58D0(var_1);
      break;
    case "hijk_agent_stumblehit":
      thread _id_58D1();
      break;
    case "failing_engine":
      if(level._id_58A3 == 0) {
        thread _id_58F8();
        maps\_audio::aud_send_msg("turbulence_start");
        level._id_58A3 = 1;
      }

      break;
    case "rumble":
      thread _id_58F6();
      thread _id_58BD();
      break;
    case "rumble_boom":
      thread _id_58F7();
      break;
    case "zero_g_doorway":
      if(level._id_58AD == 0) {
        thread _id_58F9();
        level._id_58AD = 1;
      }

      break;
    case "zero_g_start":
      thread _id_58D5();
      common_scripts\utility::flag_set("up_prezerog_rumble");
      break;
    case "zero_g_bodyslam1":
      thread _id_58DC();
      thread _id_58DD();
      break;
    case "zero_g_bodyslam2":
      thread _id_58DE();
      thread _id_58DF();
      break;
    case "zero_g_bodyslam3":
      thread _id_58E0();
      thread _id_58E1();
      break;
    case "zero_g_bodyslam4":
      thread _id_58E2();
      thread _id_58E3();
      thread _id_58E4();
      break;
    case "zero_g_debris_crash":
      thread _id_58E5();
      break;
    case "turbine_wind_a":
      thread _id_58F9();
      break;
    case "turbine_wind_b":
      thread _id_58FA();
      break;
    case "turbine_wind_c":
      thread _id_58FC();
      break;
    case "jet_roll_v01":
      thread _id_58FF();
      break;
    case "jet_roll_v02":
      thread _id_5900();
      thread _id_5902();
      break;
    case "jet_post_zero_g":
      maps\_audio_zone_manager::_id_156C("jet_post_zero_g_zone");
      break;
    case "jet_lowerlev_occlusion1":
      maps\_audio_zone_manager::_id_156C("jet_lowerlev_zone");
      break;
    case "jet_lowerlev_occlusion2":
      maps\_audio_zone_manager::_id_156C("jet_command_room_zone");
      break;
    case "cargo_room_zone_on":
      thread _id_5901();
      break;
    case "jet_lowerlev_occlusion3":
      maps\_audio_zone_manager::_id_156C("pre_crash_zone");
      break;
    case "suitcase_prop_sound_impact":
      var_4 = spawn("script_origin", level.player.origin);
      var_4 linkto(level.player);
      var_4 playSound("hijk_luggage_fall", "soundone");
      var_4 waittill("sounddone");
      var_4 delete();
      break;
    case "approaching_ground":
      maps\_audio_zone_manager::_id_156C("pre_crash_zone");
      thread _id_5903();
      break;
    case "pre_crash_door":
      thread _id_5904();
      break;
    case "crash_sequence":
      thread _id_5905();
      thread _id_590B();
      thread _id_590C();
      break;
    case "crash_explosion":
      thread _id_5906();
      break;
    case "crash_chunk_breaks_away":
      thread _id_5908();
      break;
    case "tower_impact":
      thread _id_590A();
      break;
    case "crash_death":
      thread _id_5910();
      break;
    case "agent_scream":
      var_5 = var_1;
      thread _id_590F(var_5);
      break;
    case "crash_sequence_turbine":
      thread _id_5911();
      break;
    case "crash_sequence_end":
      if(level._id_58A5 == 0) {
        thread _id_5912();
        thread _id_5915();
        thread _id_5913();
        level._id_58A5 = 1;
      }

      break;
    case "debris_shift1":
      thread _id_5916();
      break;
    case "debris_shift2":
      thread _id_5917();
      break;
    case "debris_shift3":
      thread _id_5918();
      break;
    case "debris_shift4":
      thread _id_5919();
      break;
    case "debris_shift5":
      thread _id_591A();
      break;
    case "debris_shift6":
      thread _id_591B();
      break;
    case "debris_shift7":
      thread _id_591C();
      break;
    case "debris_shift8":
      thread _id_591D();
      break;
    case "debris_shift9":
      thread _id_591E();
      break;
    case "debris_shift10":
      thread _id_591F();
      break;
    case "debris_shift11":
      thread _id_5920();
      break;
    case "debris_shift12":
      thread _id_5921();
      break;
    case "debris_shift13":
      thread _id_5922();
      break;
    case "debris_shift14":
      thread _id_5923();
      break;
    case "debris_shift15":
      thread _id_5924();
      break;
    case "debris_shift16":
      thread _id_5925();
      break;
    case "debris_shift17":
      thread _id_5926();
      break;
    case "plate_shift1":
      thread _id_5927();
      break;
    case "plate_shift2":
      thread _id_5928();
      break;
    case "music_reveal_exterior":
      if(level._id_58AB == 0) {
        thread _id_5929();
        level._id_58AB = 1;
      }

      break;
    case "ground_external_start":
      maps\_audio_zone_manager::_id_156C("ground_external_zone");

      if(level._id_58A6 == 0) {
        thread _id_5932();
        level._id_58A6 = 1;
      }

      break;
    case "wreck_exit_expl":
      thread _id_592A();
      break;
    case "wing_settle":
      if(level._id_58AC == 0) {
        thread _id_592B();
        level._id_58AC = 1;
      }

      break;
    case "engine_pre_explosion":
      if(level._id_58A8 == 0) {
        thread _id_592C();
        level._id_58A8 = 1;
      }

      break;
    case "engine_explosion":
      thread _id_592D();
      break;
    case "flare_gun":
      thread _id_592E();
      break;
    case "random_tail_expl":
      if(level._id_58AF == 0) {
        thread _id_5930();

      }
      break;
    case "ground_internal_start":
      maps\_audio_zone_manager::_id_156C("ground_internal_zone");
      break;
    case "tarmac_shift":
      if(level._id_58A7 == 0) {
        thread _id_5931();
        level._id_58A7 = 1;
      }

      break;
    case "fighter_jet_pass_ground":
      thread _id_5932();
      break;
    case "tarmac_dist_fire":
      if(level._id_58AE == 0) {
        thread _id_5933();
        level._id_58AE = 1;
      }

      break;
    case "tarmac_combat_music":
      thread _id_5934();
      break;
    case "first_suv":
      thread _id_5935();
      break;
    case "player_entered_end_area":
      maps\_audio_zone_manager::_id_156C("end_zone");
      thread _id_4F96();

      if(level._id_58B0 == 0) {
        thread _id_593A();
        thread _id_593B();
        thread _id_593C();
        thread _id_593D();
        level._id_58B0 = 1;
      }

      break;
    case "suv_explosion":
      thread _id_5938();
      break;
    case "end_heli_approach":
      thread _id_5939();
      break;
    case "makarov_slow":
      thread _id_593F();
      thread _id_0165();
      thread _id_5940();
      thread _id_5941();
      break;
    case "commander_shot":
      thread _id_0112();
      break;
    case "player_shot":
      thread _id_7D15();
      break;
    case "blackout":
      thread blackout();
      break;
    default:
      maps\_audio::_id_177E("payback_aud_msg_handler() unhandled message: " + var_0);
      var_2 = 0;
      break;
  }

  return var_2;
}

_id_448C(var_0, var_1) {
  var_2 = 1;

  if(getsubstr(var_0, 0, 4) != "mus_") {
    return 0;

  }
  level notify("kill_other_music");
  level endon("kill_other_music");

  switch (var_0) {
    case "mus_intro":
      wait 1.9333;
      break;
  }

  return var_2;
}

_id_3FB6() {
  wait 3.0;
  maps\_audio_music::_id_15A7("hijk_mx_levelstart");
}

_id_58B3() {
  var_0 = spawn("script_origin", (-28544, 13648, 7360));
  var_0 scalevolume(0);
  var_0 playLoopSound("hijk_jet_rumble_02");
  wait 0.01;
  var_0 scalevolume(0.9, 6);
  var_1 = spawn("script_origin", (-28544, 11920, 7360));
  var_1 scalevolume(0.1, 0);
  var_1 playLoopSound("hijk_jet_rumble_02");
  wait 0.01;
  var_1 scalevolume(0.9, 6);
}

_id_58B4() {
  wait 0.5;
  level._id_58B5.audio = spawn("script_origin", level._id_58B5.origin);
  level._id_58B5.audio linkto(level._id_58B5);
  level._id_58B5.audio playLoopSound("hijk_jet_engine_intro_lfe");
  level._id_58B5.audio scalevolume(0.2);
  var_0 = spawn("script_origin", (-31000, 15536, 7360));
  var_1 = (-28000, 15536, 7360);
  var_0 playLoopSound("hijk_jet_engine_intro");
  var_0 scalevolume(0.2);
  wait 4.5;
  var_0 moveto(var_1, 30.0);
  wait 3;
  level._id_58B5.audio scalevolume(1, 10);
  var_0 scalevolume(1, 10);
  wait 8.0;
  level._id_58B6.audio = spawn("script_origin", level._id_58B6.origin);
  level._id_58B6.audio linkto(level._id_58B6);
  level._id_58B6.audio playSound("hijk_jet_by_pullup");
  wait 5.0;
  var_0 scalevolume(0.707, 8);
  wait 9.0;
  level._id_58B5.audio playSound("hijk_jet_by_takeoff");
  wait 2;
  level._id_58B5.audio scalevolume(0, 1);
  level._id_58B6.audio playSound("hijk_jet_by_takeoff");
  wait 3;
  var_0 scalevolume(0, 8);
  common_scripts\utility::flag_wait("second_migs");
  thread _id_58B7();
  var_0 scalevolume(0, 2.5);
  wait 3;
  var_0 delete();
}

_id_58B7() {
  wait 0.5;
  level._id_58B8.audio = spawn("script_origin", level._id_58B8.origin);
  level._id_58B8.audio linkto(level._id_58B8);
  level._id_58B8.audio playSound("hijk_hallway_flyby");
}

_id_58B9() {
  wait 6.5;
  level._id_58BA playSound("hijk_pres_paper");
}

_id_58BB() {
  wait 0.25;
  var_0 = spawn("script_origin", (-29306, 12786, 7346));
  var_0 playSound("hijk_agent_cart");
}

_id_58BC() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1, 0);
  wait 0.01;
  var_0 scalevolume(1, 2);
  var_0 playLoopSound("hijk_radio_com_intro");
  wait 17.5;
  level.player playSound("hijk_radio_com_intro_out");
  maps\_audio::_id_15F3(var_0, 0.1);
}

_id_58BD() {
  wait 0;
  var_0 = spawn("script_origin", (-29044, 12678, 7346));
  var_0 playSound("hijk_turb_glasses");
}

_id_58BE() {
  wait 1;
  var_0 = spawn("script_origin", (-28513, 12804, 7318));
  var_0 playLoopSound("hijk_lapt_typing");
  common_scripts\utility::flag_wait("stop_typing_sound");
  var_0 stoploopsound("hijk_lapt_typing");
}

_id_58BF() {
  var_0 = spawn("script_origin", (-28320, 12784, 7312));
  wait 15.5;
  var_0 playSound("hijk_debate_bump_01");
  wait 5;
  var_0 playSound("hijk_debate_bump_02");
  wait 4;
  var_0 delete();
}

_id_58C0() {
  wait 11;
  var_0 = spawn("script_origin", (-28832, 12784, 7344));
  var_0 playSound("hijk_keypad");
  wait 2;
  var_0 delete();
}

_id_58C1() {
  wait 15;
  var_0 = spawn("script_origin", (-29072, 12678, 7332));
  var_0 playLoopSound("hijk_agent_espresso");
  common_scripts\utility::flag_wait("stop_kitchen");
  maps\_audio::_id_15F3(var_0, 1);
}

_id_58C2() {
  var_0 = spawn("script_origin", (-28354, 12820, 7390));
  var_0 playSound("hijack_tvb_worldmarkets");
  common_scripts\utility::flag_wait("stop_news_broadcast");
  maps\_audio::_id_15F3(var_0, 0.01);
}

_id_58C3() {
  level._id_58C4 playSound("hijk_door3close");
  common_scripts\utility::flag_set("stop_kitchen");
}

_id_58C5() {
  wait 4;
  level._id_58BA playSound("chair_enter");
  wait 0.5;
  level._id_58C6 playSound("chair_enter");
  wait 2;
  level._id_58C7 playSound("chair_enter");
}

_id_58C8() {
  wait 3;
  level._id_58C9 playSound("hijk_agent_dash1");
}

_id_58CA() {
  wait 2;
  level._id_58CB playSound("hijk_agent_dash2");
  wait 2;
  level._id_58CB playSound("hijk_agent_coverup");
}

_id_58CC() {
  wait 2;
  level._id_58C9 playSound("hijk_agent_dash3");
}

_id_58CD() {
  wait 1;
  level._id_58C9 playSound("hijk_agent_blastfall1");
}

_id_58CE() {
  wait 0;
  level._id_58CB playSound("hijk_agent_blastfall2");
  wait 3;
}

_id_58CF() {
  wait 1.5;
  maps\_audio_music::_id_15A7("hijk_pre_breach");
}

_id_58D0(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  thread _id_58F6();
  thread _id_58FD();

  if(var_0) {
    var_1 playSound("hijk_zero_g_bigshake");

  }
  var_1 playSound("hijk_tilt_stress_01");
}

_id_58D1() {
  wait 1;
  level._id_58D2 playSound("hijk_agent_stumblehit");
}

_id_58D3() {
  maps\_audio_zone_manager::_id_156C("jet_turb_zone");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_2 = spawn("script_origin", (0, 0, 0));
  wait 1;
  var_0 scalevolume(0.1, 0);
  var_1 scalevolume(0.1, 0);
  var_2 scalevolume(0.1, 0);
  wait 0.2;
  var_0 playLoopSound("pre_zero_g_rumble");
  var_1 playLoopSound("loop_jet_tilt");
  var_2 playLoopSound("hijk_hallway_rattle");
  wait 0.2;
  var_0 scalevolume(0.4, 12);
  var_1 scalevolume(1, 20);
  var_2 scalevolume(1, 10);
  common_scripts\utility::flag_wait("up_prezerog_rumble");
  var_0 scalevolume(1, 10);
  maps\_audio::_id_15F3(var_2, 1.0);
  maps\_audio::_id_15F3(var_1, 2.0);
  wait 20;
  var_0 scalevolume(0, 8.0);
  thread _id_58E6();
  wait 9;
  var_0 delete();
}

_id_58D4() {
  maps\_audio_zone_manager::_id_156C("jet_turb_zone");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0 playLoopSound("pre_zero_g_rumble");
  var_1 playLoopSound("loop_jet_tilt");
  var_0 scalevolume(0.4, 0);
  var_1 scalevolume(1, 0);
  common_scripts\utility::flag_wait("up_prezerog_rumble");
  var_0 scalevolume(1, 10);
  maps\_audio::_id_15F3(var_1, 2.0);
  wait 15;
  maps\_audio::_id_15F3(var_0, 4.0);
  wait 12;
  thread _id_58E6();
}

_id_58D5() {
  maps\_audio_music::_id_15A8(6);
  thread _id_58D8();
  maps\_audio_zone_manager::_id_156C("jet_zero_g_zone");
  var_0 = spawn("script_origin", (0, 0, 0));
  thread _id_58D6();
  var_0 playSound("hijk_zero_g_start");
  var_0 playSound("hijk_zero_g_winding");
  thread _id_58D7();
  wait 8;
  maps\_audio_zone_manager::_id_156C("jet_zero_g_ramp_zone");
  wait 12;
  thread _id_58FC();
  wait 4;
  thread _id_58E7();
  maps\_audio_zone_manager::_id_156C("jet_post_zero_g_zone");
  maps\_audio_music::_id_15A7("hijk_mx_lowerdeck_shootout");
}

_id_58D6() {
  wait 10;
  var_0 = spawn("script_origin", (0, 0, 0));
  wait 0.1;
  var_0 scalevolume(0.1, 0);
  wait 0.1;
  var_0 playLoopSound("hijk_lfe_drone");
  wait 0.1;
  var_0 scalevolume(1, 10);
  wait 8;
  var_0 scalepitch(1.2, 2);
  wait 2;
  var_0 scalepitch(0.5, 4);
  wait 2;
  var_0 scalevolume(0, 4);
  wait 4.1;
  var_0 stoploopsound("hijk_lfe_drone");
  wait 0.1;
  var_0 delete();
}

_id_58D7() {
  wait 2;
  common_scripts\utility::play_sound_in_space("hijk_briefcase_impact", (-27328, 12688, 7360));
}

_id_58D8() {
  wait 2.3;
  thread _id_58DA();
  wait 12.0;
  thread _id_58DB();
}

_id_58D9() {
  level.player playSound("hijk_tilt_moan_01");
  wait 0.3;
  thread _id_562D("zero_g_moan_mix", 0.4, 0.1, 0.8);
}

_id_58DA() {
  level.player playSound("hijk_tilt_moan_02");
  wait 0.3;
  thread _id_562D("zero_g_moan_mix", 0.4, 0.1, 0.8);
}

_id_58DB() {
  level.player playSound("hijk_tilt_moan_03");
  wait 0.3;
  thread _id_562D("zero_g_moan_mix", 0.4, 0.1, 0.8);
}

_id_58DC() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (-27568, 12848, 7318));
  var_0 playSound("hijk_zero_g_bigshake");
  wait 0.5;
  var_1 playSound("hijk_misc_sm_debris");
}

_id_58DD() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.2;
  level.player playSound("hijk_props_debris");
}

_id_58DE() {
  thread _id_562D("zero_g_bodyslam_mix", 0, 0.1, 1.0);
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (-27552, 12688, 7318));
  var_0 playSound("hijk_body_slam");
  wait 0.5;
  var_1 playSound("hijk_misc_sm_debris");
}

_id_58DF() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.3;
  level.player playSound("hijk_props_debris");
}

_id_58E0() {
  thread _id_562D("zero_g_bodyslam_mix", 0, 0.1, 1.0);
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (-27392, 12688, 7318));
  var_0 playSound("hijk_body_slam");
  wait 0.5;
  var_1 playSound("hijk_misc_sm_debris");
}

_id_58E1() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.3;
  level.player playSound("hijk_props_debris");
}

_id_58E2() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (-27440, 12768, 7318));
  var_2 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("hijk_body_slam");
  wait 1;
  var_1 playSound("hijk_misc_sm_debris");
  var_2 playLoopSound("pre_zero_g_rumble");
  wait 0.2;
  var_2 scalevolume(0.1, 0);
  wait 5;
  var_2 scalevolume(1, 4);
  wait 4;
  var_2 scalevolume(0, 10);
  wait 11;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_58E3() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.2;
  level.player playSound("hijk_props_debris");
  wait 6;
  level.player playSound("hijk_props_debris");
  level.player playSound("hijk_props_debris");
}

_id_58E4() {
  wait 5.0;
  level.player playSound("hijk_tilt_stress_02");
}

_id_58E5() {
  var_0 = spawn("script_origin", (0, 0, 0));
  wait 0.2;
  var_0 playSound("hijk_zero_g_debris_crash");
  thread _id_562D("zero_g_bodyslam_last_mix", 0, 0.3, 1.0);
  wait 2;
  var_0 delete();
}

_id_58E6() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1, 0);
  wait 0.2;
  var_0 playLoopSound("pre_zero_g_rumble");
  wait 0.2;
  var_0 scalevolume(0.707, 9);
  wait 10;
  var_0 scalevolume(0, 12.0);
  wait 13;
  var_0 delete();
}

_id_58E7() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1, 0);
  var_1 scalevolume(0.1, 0);
  wait 0.01;
  var_0 scalevolume(1, 5);
  var_1 scalevolume(1, 5);
  wait 0.05;
  var_0 playLoopSound("hijk_jet_falling_l_2d");
  var_1 playLoopSound("hijk_jet_falling_r_2d");
  common_scripts\utility::flag_wait("stop_jet_falling");
  var_0 scalevolume(1);
  var_1 scalevolume(1);
  wait 0.01;
  var_0 scalevolume(0, 8);
  var_1 scalevolume(0, 8);
  wait 0.05;
  var_0 delete();
  var_1 delete();
}

_id_58E8() {
  var_0 = spawn("script_origin", (-28352, 12740, 7328));
  var_1 = spawn("script_origin", (0, 0, 0));
  level._id_16F5._id_58E9 = var_0;
  var_0 maps\_audio::_id_170B("hijk_conf_shots_3d");
  common_scripts\utility::flag_wait("conf_room_shots_go");
  var_0 playSound("hijk_conf_shots_3d");
  var_1 playSound("hijk_conf_shots_2d");
  wait 13;
  maps\_audio::_id_170F("hijk_conf_shots_3d");
}

_id_58EA() {
  wait 1.7;
  var_0 = spawn("script_origin", (-28352, 12740, 7328));
  var_0 playSound("hijk_seatbelt_bell");
  wait 5;
  var_0 delete();
}

_id_58EB() {
  var_0 = spawn("script_origin", (-28368, 12880, 7328));
  var_1 = spawn("script_origin", (-28368, 12672, 7328));
  var_2 = spawn("script_origin", (-28672, 12656, 7328));
  var_3 = spawn("script_origin", (-28576, 12784, 7328));
  level._id_16F5._id_58EC = var_0;
  level._id_16F5._id_58ED = var_1;
  var_0 maps\_audio::_id_170B("hijk_c4_distant_l");
  var_1 maps\_audio::_id_170B("hijk_c4_distant_r");
  common_scripts\utility::flag_wait("conf_room_explosion1_go");
  thread _id_58F0();
  var_0 playSound("hijk_c4_distant_l");
  wait 0.05;
  var_1 playSound("hijk_c4_distant_r");
  wait 0.1;
  var_2 playSound("hijk_bottles_break");
  var_3 playSound("hijk_table_rattle");
  thread _id_58EE();
  thread _id_58EF();
  var_4 = spawn("script_origin", (0, 0, 0));
  var_4 scalevolume(0.1, 0);
  wait 0.2;
  var_4 playLoopSound("pre_zero_g_rumble");
  wait 0.2;
  var_4 scalevolume(0.6, 1);
  wait 2;
  var_4 scalevolume(0, 6.0);
  wait 7;
  var_4 delete();
  maps\_audio::_id_170F("hijk_c4_distant_l");
  maps\_audio::_id_170F("hijk_c4_distant_r");
}

_id_58EE() {
  wait 1.2;
  common_scripts\utility::play_sound_in_space("hijk_desk_debris_01", (-28480, 12736, 7328));
}

_id_58EF() {
  wait 1.05;
  common_scripts\utility::play_sound_in_space("hijk_desk_debris_02", (-28704, 12736, 7328));
}

_id_58F0() {
  thread _id_562D("debate_room_expl1_mix", 0, 0.8, 2);
}

_id_58F1() {
  var_0 = spawn("script_origin", (-28352, 12740, 7328));
  level._id_16F5._id_58F2 = var_0;
  var_0 maps\_audio::_id_170B("hijk_c4_plant");
  common_scripts\utility::flag_wait("conf_room_c4_plant_go");
  wait 2.5;
  var_0 playSound("hijk_c4_plant");
  wait 8;
  maps\_audio::_id_170F("hijk_c4_plant");
  var_0 delete();
}

_id_58F3() {
  var_0 = spawn("script_origin", (-28352, 12768, 7328));
  var_1 = spawn("script_origin", (-28352, 12704, 7328));
  var_2 = spawn("script_origin", (-28624, 12784, 7328));
  var_3 = spawn("script_origin", (-28496, 12784, 7328));
  var_4 = spawn("script_origin", (0, 0, 0));
  var_5 = spawn("script_origin", (-28784, 12848, 7390));
  level._id_16F5._id_58F4 = var_0;
  level._id_16F5._id_58F5 = var_1;
  var_0 maps\_audio::_id_170B("hijk_c4_door_l");
  var_1 maps\_audio::_id_170B("hijk_c4_door_r");
  common_scripts\utility::flag_wait("conf_room_explosion2_go");
  maps\_audio_zone_manager::_id_156C("door_breach_zone");
  var_0 playSound("hijk_c4_door_l");
  var_4 playSound("hijk_c4_blast_wave");
  level.player playSound("hijk_tonal_door_breach_01");
  wait 0.1;
  var_1 playSound("hijk_c4_door_r");
  var_3 playSound("hijk_table_debris2");
  wait 0.1;
  var_2 playSound("hijk_table_debris1");
  wait 0.1;
  var_5 playSound("hijk_display_break");
  wait 1.6;
  maps\_audio_zone_manager::_id_156C("debate_post_breach_zone");
  wait 4;
  maps\_audio::_id_170F("hijk_c4_door_l");
  maps\_audio::_id_170F("hijk_c4_door_r");
  wait 3;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

_id_58F6() {
  level.player playSound("hijk_turbulence_2d");
}

_id_58F7() {
  level.player playSound("hijk_turbulence_lg_2d");
  level.player playSound("hijk_explosion_lg_lfe");
}

_id_58F8() {
  var_0 = spawn("script_origin", (-28544, 13648, 7360));
  var_0 playSound("hijk_failing_engine");
  common_scripts\utility::flag_wait("up_prezerog_rumble");
  var_0 scalevolume(0, 4);
  wait 10;
  var_0 delete();
}

_id_58F9() {
  var_0 = spawn("script_origin", (-28128, 13536, 7072));
  var_1 = spawn("script_origin", (-28144, 12032, 7072));
  var_2 = spawn("script_origin", (-30096, 12784, 7072));
  wait(randomintrange(0, 3));
  var_0 playSound("hijk_turbine_wind_v01");
  wait(randomintrange(0, 3));
  var_1 playSound("hijk_turbine_wind_v02");
  wait(randomintrange(0, 3));
  var_2 playSound("hijk_turbine_wind_v03");
  wait 25;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_58FA() {
  var_0 = spawn("script_origin", (-28128, 13536, 7072));
  var_1 = spawn("script_origin", (-28144, 12032, 7072));
  var_2 = spawn("script_origin", (-30096, 12784, 7072));
  thread _id_58FB();
  wait(randomintrange(0, 2));
  var_0 playSound("hijk_turbine_wind_fast_v02");
  wait(randomintrange(0, 2));
  var_1 playSound("hijk_turbine_wind_fast_v01");
  wait(randomintrange(0, 2));
  var_2 playSound("hijk_turbine_wind_fast_v03");
  wait 4;
  maps\_audio::aud_send_msg("jet_lowerlev_occlusion3");
  var_0 playSound("hijk_turbine_wind_v01");
  var_1 playSound("hijk_turbine_wind_v02");
  var_2 playSound("hijk_turbine_wind_v03");
  wait 8;
  maps\_audio::_id_15F3(var_0, 4.0);
  maps\_audio::_id_15F3(var_1, 4.0);
  maps\_audio::_id_15F3(var_2, 4.0);
}

_id_58FB() {
  wait 2;
  common_scripts\utility::play_sound_in_space("hijk_ladder_fall", (-28688, 12896, 7168));
}

_id_58FC() {
  var_0 = spawn("script_origin", (-28128, 13536, 7072));
  var_1 = spawn("script_origin", (-28144, 12032, 7072));
  var_2 = spawn("script_origin", (-30096, 12784, 7072));
  var_0 playSound("hijk_turbine_wind_v03");
  wait(randomintrange(0, 1));
  var_1 playSound("hijk_turbine_wind_v02");
  wait(randomintrange(0, 1));
  var_2 playSound("hijk_turbine_wind_v01");
  wait 25;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_58FD() {
  var_0 = spawn("script_origin", (-28128, 13536, 7072));
  var_1 = spawn("script_origin", (-28144, 12032, 7072));
  var_2 = spawn("script_origin", (-30096, 12784, 7072));
  var_0 playSound("hijk_turbine_wind_fast_v03");
  var_1 playSound("hijk_turbine_wind_fast_v02");
  var_2 playSound("hijk_turbine_wind_fast_v01");
  wait 25;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_58FE() {
  var_0 = spawn("script_origin", (-28128, 13536, 7072));
  var_1 = spawn("script_origin", (-28144, 12032, 7072));
  var_2 = spawn("script_origin", (-30096, 12784, 7072));
  var_0 playSound("hijk_turbine_wind_v03");
  var_1 playSound("hijk_turbine_wind_v02");
  var_2 playSound("hijk_turbine_wind_v01");
  wait 25;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_58FF() {
  var_0 = spawn("script_origin", (-27472, 12784, 7184));
  var_1 = spawn("script_origin", (-27536, 12912, 7184));
  var_2 = spawn("script_origin", (-27616, 12672, 7216));
  level.player playSound("hijk_jet_roll_v01");
  thread _id_562D("lowerlev_roll_mix", 0.1, 0.5, 1.5);
  wait 2;
  var_0 playSound("hijk_bottles_break");
  wait 0.5;
  var_1 playSound("hijk_table_rattle");
  wait 0.8;
  var_2 playSound("hijk_bar_bottles_break");
  wait 6;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_5900() {
  var_0 = spawn("script_origin", (-28640, 12912, 7168));
  var_1 = spawn("script_origin", (-28640, 12688, 7168));
  level.player playSound("hijk_jet_roll_v02");
  thread _id_562D("lowerlev_roll_mix", 0.1, 0.5, 1.5);
  wait 2;
  var_0 playSound("hijk_box_tumble_l");
  var_1 playSound("hijk_box_tumble_r");
  wait 8;
  var_0 delete();
  var_1 delete();
}

_id_5901() {
  wait 8;
  maps\_audio_zone_manager::_id_156C("jet_cargo_room_zone");
}

_id_5902() {
  var_0 = spawn("script_origin", (-28556, 12899, 7178));
  wait 2.5;
  var_0 playSound("hijk_props_tanks");
  wait 2.5;
  var_0 playSound("hijk_props_tankroll");
  wait 8;
  var_0 delete();
}

_id_5903() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("shot_jet_tilt");
  wait 4;
  var_1 playSound("hijk_turbine_wind_2d_l");
  var_1 playSound("hijk_turbine_wind_2d_r");
}

_id_5904() {
  var_0 = spawn("script_origin", (-28954, 12781, 7179));
  wait 1;
  var_0 playSound("hijk_precrash_door");
  wait 2.5;
  var_0 delete();
}

_id_5905(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_2 = spawn("script_origin", (0, 0, 0));
  var_3 = spawn("script_origin", (0, 0, 0));
  var_4 = spawn("script_origin", (0, 0, 0));
  var_1 playSound("hijk_zero_g_bigshake");
  var_2 playSound("hijk_turbulence_2d");
  var_2 playSound("hijk_jet_crash_leadin");
  wait 0.5;
  wait 0.6;
  var_2 playSound("hijk_turbulence_2d");
  wait 1.5;
  common_scripts\utility::flag_set("stop_jet_falling");
  maps\_audio_music::_id_15A8(3);
  wait 2.83;
  maps\_audio_zone_manager::_id_156C("pre_crash_duck_zone");
  wait 0.3;
  var_2 playSound("hijk_jet_crash_tires");
  maps\_audio_zone_manager::_id_156C("jet_crash_zone");
  var_2 playSound("hijk_jet_crash_hitground");
  wait 0.47;
  var_2 playSound("hijk_explosion_lfe");
  var_4 playLoopSound("loop_lfe_shake");
  thread _id_590D();
  wait 2.4;
  thread _id_590E();
  var_3 playSound("hijk_jet_scrape2_lr");
  wait 2.03;
  maps\_audio_zone_manager::_id_156C("jet_crash_breached_zone");
  wait 3;
  var_2 playSound("hijk_jet_crash_pitchfx");
  wait 2;
  maps\_audio::_id_15F3(var_3, 2.0);
  wait 0.5;
  var_2 playSound("hijk_crash_flyingdebris_01");
  wait 1.9;
  var_2 playSound("hijk_jet_tailcrunch1");
  wait 1.57;
  var_2 playSound("hijk_jet_tailcrunch2");
  wait 0.4;
  var_2 playSound("hijk_jet_crash_trees");
  wait 5.2;
  var_4 stoploopsound("loop_lfe_shake");
}

_id_5906() {
  level._id_5907 thread maps\_utility::play_sound_on_entity("hijk_crash_left_fire");
}

_id_5908() {
  level._id_5909 thread maps\_utility::play_sound_on_entity("hijk_crash_chunk");
}

_id_590A() {
  thread _id_562D("tower_impact_mix", 0, 0.3, 1);
  level.player thread maps\_utility::play_sound_on_entity("hijk_tower_lfe");
  level.player thread maps\_utility::play_sound_on_entity("hijk_tower_impact");
}

_id_590B() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.5;
  level.player playSound("hijk_props_debris");
  wait 0.5;
  level.player playSound("hijk_props_debris");
  wait 5;
  level.player playSound("hijk_crashprops_group");
  wait 0.5;
  level.player playSound("hijk_crashprops_group");
  wait 0.5;
  level.player playSound("hijk_crashprops_group");
}

_id_590C() {
  wait 6.5;
  level.player playSound("hijk_crash_terror_bodyfall");
  level.player playSound("hijk_crash_terror_gundrop1");
  wait 0.5;
  level.player playSound("hijk_crash_terror_bodyfall");
  wait 0.5;
  level.player playSound("hijk_crash_terror_bodyfall");
}

_id_590D() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("shot_jet_fire");
}

_id_590E() {
  var_0 = spawn("script_origin", (-24140, 15908, 4000));
  wait 3.6;
  var_0 playSound("hijk_jet_separation");
  var_0 playSound("hijk_jet_separation_s");
}

_id_590F(var_0) {
  var_1 = var_0;
  wait 17.75;
  var_1 playSound("hijk_agent_slipscream");
}

_id_5910() {
  maps\_audio_zone_manager::_id_156C("jet_crash_death_zone");
  level.player playSound("hijk_crash_death");
}

_id_5911() {
  if(level._id_58A5 == 0) {
    var_0 = spawn("script_origin", (8384, 4064, 288));
    var_1 = spawn("script_origin", (8928, 4064, 144));
    wait 2.8;
    var_0 playSound("hijk_incoming_turbine");
    wait 1.9;
    level.player playSound("hijk_post_crash_blackout");
    wait 0.2;
    level.player playSound("hijk_jet_turbine_impact");
    level.player playSound("hijk_explosion_lfe");
    var_1 playSound("hijk_turbine_stop");
    level.player playSound("hijk_zero_g_stop");
    wait 0.2;
    thread _id_562D("post_crash_blackout_mix", 0.7, 8, 6);
    wait 14;
    level.player playSound("hijk_wake_up_reveal");
  }
}

_id_5912() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("hijk_jet_crash_end");
  var_0 playSound("hijk_jet_impact");
  wait 0.1;
  var_0 playSound("hijk_explosion_lfe");
  var_0 playSound("hijk_jet_impact");
  wait 0.2;
  var_0 playSound("hijk_jet_impact");
  var_0 playSound("hijk_explosion_lfe");
  wait 2.5;
  var_0 playSound("hijk_jet_crash_fire_end");
}

_id_5913() {
  wait 22;
  maps\_audio_music::_id_15A7("hijk_mx_crash_aftermath");
}

_id_5914() {
  maps\_audio_music::_id_15A7("hijk_mx_crash_aftermath");
}

_id_5915() {
  wait 15;
  level._id_58D2 playSound("hijk_debris_move1");
  wait 2;
  level._id_58D2 playSound("hijk_debris_move2");
  wait 2;
  level._id_58D2 playSound("hijk_debris_move3");
  wait 6;
}

_id_5916() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9008, 4016, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9008, 4016, 208));
    level._id_58A9 = 0;
  }
}

_id_5917() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (8992, 3856, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (8992, 3856, 208));
    level._id_58A9 = 0;
  }
}

_id_5918() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9152, 4000, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9152, 4000, 208));
    level._id_58A9 = 0;
  }
}

_id_5919() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9136, 3856, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9136, 3856, 208));
    level._id_58A9 = 0;
  }
}

_id_591A() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9280, 3984, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9280, 3984, 208));
    level._id_58A9 = 0;
  }
}

_id_591B() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9264, 3824, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9264, 3824, 208));
    level._id_58A9 = 0;
  }
}

_id_591C() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9408, 3968, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9408, 3968, 208));
    level._id_58A9 = 0;
  }
}

_id_591D() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9376, 3792, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9376, 3792, 208));
    level._id_58A9 = 0;
  }
}

_id_591E() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9552, 3936, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9552, 3936, 208));
    level._id_58A9 = 0;
  }
}

_id_591F() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9520, 3792, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9520, 3792, 208));
    level._id_58A9 = 0;
  }
}

_id_5920() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9680, 3920, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9680, 3920, 208));
    level._id_58A9 = 0;
  }
}

_id_5921() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9664, 3760, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9664, 3760, 208));
    level._id_58A9 = 0;
  }
}

_id_5922() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9808, 3888, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9808, 3888, 80));
    level._id_58A9 = 0;
  }
}

_id_5923() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9888, 3760, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9888, 3760, 80));
    level._id_58A9 = 0;
  }
}

_id_5924() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10032, 3856, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10032, 3856, 80));
    level._id_58A9 = 0;
  }
}

_id_5925() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9824, 3824, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9824, 3824, 80));
    level._id_58A9 = 0;
  }
}

_id_5926() {
  if(level._id_58A9 == 0) {
    level._id_58A9 = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10096, 3712, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10096, 3712, 80));
    level._id_58A9 = 0;
  }
}

_id_5927() {
  if(level._id_58AA == 0) {
    level._id_58AA = 1;
    common_scripts\utility::play_sound_in_space("shot_plate_shift", (9472, 3856, 128));
    level._id_58AA = 0;
  }
}

_id_5928() {
  if(level._id_58AA == 0) {
    level._id_58AA = 1;
    common_scripts\utility::play_sound_in_space("shot_plate_shift", (9200, 3856, 128));
    level._id_58AA = 0;
  }
}

_id_5929() {
  wait 0.5;
  level.player playSound("hijk_reveal_exterior");
  thread _id_562D("exterior_reveal_mix", 2.0, 8.0, 8.0);
  wait 2;
  maps\_audio_music::_id_15A8(3);
}

_id_592A() {
  var_0 = spawn("script_origin", (3488, 4272, 2096));
  var_0 playSound("hijk_wreck_expl");
  wait 0.3;
  level.player playSound("hijk_wreck_expl_bg");
  wait 10;
  var_0 delete();
}

_id_592B() {
  common_scripts\utility::play_sound_in_space("hijk_wing_settle", (9472, 3504, 100));
}

_id_592C() {
  var_0 = spawn("script_origin", (8672, 4128, 144));
  var_0 scalevolume(0);
  wait 0.2;
  var_0 scalevolume(1, 7);
  var_0 playLoopSound("hijk_engine_fire");

  while(!common_scripts\utility::flag("turbine_exploded")) {
    var_0 playSound("hijk_engine_sputter");
    common_scripts\utility::exploder("engine_sputter");
    wait(randomfloatrange(0.4, 2.5));
  }

  wait 0.2;
  var_0 stoploopsound("hijk_engine_fire");
  wait 0.2;
  var_0 delete();
}

_id_592D() {
  var_0 = spawn("script_origin", (8688, 4128, 368));
  var_1 = spawn("script_origin", (7952, 4256, 368));
  var_2 = spawn("script_origin", (8448, 4208, 368));
  var_3 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("hijk_engine_sputter");
  var_0 playSound("hijk_engine_expl");
  var_3 playSound("hijk_engine_expl_bg");
  common_scripts\utility::flag_set("turbine_exploded");
  wait 0.5;
  var_3 playSound("hijk_eng_expl_debris_2d");
  wait 0.5;
  var_1 playSound("hijk_engine_expl_debris_l");
  var_2 playSound("hijk_engine_expl_debris_r");
  wait 1.1;
  level._id_58D2 playSound("hijack_cmd_ugh");
  wait 0.4;
  var_3 playSound("hijk_dist_tail2_expl_bg");
  wait 15;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

_id_592E() {
  common_scripts\utility::play_sound_in_space("hijk_flare", (10256, 5968, 1000));
}

_id_592F() {
  if(level._id_1F19 != "end_scene") {
    level._id_55CA playSound("hijk_heli_approach");
  }
}

_id_5930() {
  var_0 = spawn("script_origin", (8512, 6986, 368));
  var_0 playSound("hijk_tail_pre_expl");
  wait 6;
  var_0 delete();
}

_id_5931() {
  var_0 = spawn("script_origin", (9648, 3904, 192));
  var_1 = spawn("script_origin", (9600, 3856, 210));
  var_2 = spawn("script_origin", (9824, 3648, 192));
  level.player playSound("hijk_tarmac_shift");
  wait 1;
  var_0 playSound("hijk_tarmac_debris");
  wait 1.3;
  var_1 playSound("hijk_tarmac_pipe");
  wait 3.2;
  var_0 playSound("hijk_tarmac_crates_fall");
  wait 5.5;
  var_2 playSound("hijk_tarmac_crates_fall_dist");
  wait 8;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_5932() {
  var_0 = spawn("script_origin", (10176, -304, 2096));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("hijk_fighter_pass_ground");
  wait 2;
  var_1 playSound("hijk_fighter_pass_ground_lfe");
  wait 25;
  var_0 delete();
  var_1 delete();
}

_id_5933() {
  level endon("stop_tarmac_dist_fire");
  var_0 = spawn("script_origin", (10720, 7840, 600));

  for(;;) {
    var_0 playSound("hijk_tarmac_ambiguns");
    wait(randomfloatrange(0.5, 1.5));
  }
}

_id_5934() {
  if(level._id_58AF == 0) {
    level.player playSound("hijk_reveal_ground_combat");
    maps\_audio_music::_id_15A8(2);
    wait 5;
    maps\_audio_music::_id_15A7("hijk_tarmac_combat");
    level._id_58AF = 1;
  }
}

_id_5935() {
  var_0 = spawn("script_origin", (9792, 7200, 210));
  var_0 playSound("hijk_suv_stop_01");
  thread _id_5936();
  maps\_audio_zone_manager::_id_156C("post_tarmac_combat_zone");
  wait 8;
  level notify("stop_tarmac_dist_fire");
  var_0 delete();
}

_id_5936() {
  wait 40;
  var_0 = spawn("script_origin", (6048, 8480, 500));
  var_0 scalevolume(0);
  wait 0.2;
  var_0 playLoopSound("hijk_siren_mayhem");
  wait 0.2;
  var_0 scalevolume(1, 50);
  common_scripts\utility::flag_wait("kill_sirens");
  var_0 stoploopsound("hijk_siren_mayhem");
  var_0 delete();
}

_id_5937() {
  var_0 = spawn("script_origin", (6048, 8480, 500));
  var_0 playLoopSound("hijk_siren_mayhem");
  common_scripts\utility::flag_wait("kill_sirens");
  var_0 scalevolume(0, 4);
  wait 5;
  var_0 stoploopsound("hijk_siren_mayhem");
  var_0 delete();
}

_id_4F96() {
  var_0 = spawn("script_origin", (10816, 4960, 192));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_2 = spawn("script_origin", (0, 0, 0));
  common_scripts\utility::flag_wait("makarov_slow");
  wait 0.6;
  var_0 playSound("hijk_heli_shot");
  maps\_audio_music::_id_15A7("hijk_makarov_reveal", 5);
  wait 0.5;
  level._id_55CA stoploopsound();
  var_0 scalevolume(0.891, 0.1);
  var_1 scalevolume(0.1, 0);
  var_2 scalevolume(0.1, 0);
  wait 0.2;
  var_1 playLoopSound("hijk_end_fire");
  var_2 playLoopSound("pre_zero_g_rumble");
  wait 0.2;
  var_0 scalevolume(0.63, 8);
  var_1 scalevolume(0.354, 8);
  var_2 scalevolume(0.446, 12);
  common_scripts\utility::flag_wait("player_dead");
  wait 0.3;
  maps\_audio_music::_id_15A8(0.1);
  var_0 scalevolume(0, 0.25);
  var_1 scalevolume(0, 0.25);
  var_2 scalevolume(0, 0.25);
  thread _id_562D("kill_vo_mix", 0.25, 10, 10);
  wait 0.3;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_5938() {
  thread _id_562D("combat_explosion_mix", 0.1, 0.8, 1.0);
}

_id_5939() {
  level._id_55CA playSound("hijk_heli_approach_close");
}

_id_593A() {
  level endon("door_used");
  wait 8;
  var_0 = spawn("script_origin", (10336, 5808, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

_id_593B() {
  level endon("door_used");
  wait 10;
  var_0 = spawn("script_origin", (9680, 5008, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

_id_593C() {
  level endon("door_used");
  wait 12;
  var_0 = spawn("script_origin", (9712, 4128, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

_id_593D() {
  level endon("door_used");
  wait 14;
  var_0 = spawn("script_origin", (11088, 3184, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

_id_593E() {
  level endon("door_used");
  wait 7;

  for(;;) {
    wait(randomfloatrange(0.5, 4));
    level.player playSound("hijk_bulletwhiz");
  }
}

_id_593F() {
  wait 1.25;
  var_0 = spawn("script_origin", (10816, 4960, 192));
  var_0 playSound("hijk_makarov_gunshot");
  common_scripts\utility::flag_set("kill_sirens");
  thread _id_562D("kill_vo_mix", 0.25, 4, 4);
}

_id_0165() {
  wait 1.5;
  maps\_audio_music::_id_15A8(2);
  wait 0.5;
  maps\_audio_zone_manager::_id_156C("makarov_zone");
  wait 1.3;
  common_scripts\utility::flag_set("makarov_slow");
}

_id_5940() {
  wait 5.35;
  level.player playSound("hijk_end_scene_p1");
}

_id_5941() {
  wait 9.55;
  level.player playSound("hijk_end_scene_p2");
  wait 1.32;
  level._id_58D2 playSound("hijack_fso1_moan");
  wait 2;
  wait 1.97;
  level.player playSound("hijk_end_scene_p4");
  wait 11.87;
  level.player playSound("hijk_end_scene_p5");
  wait 2.99;
  level.player playSound("hijk_end_scene_p6");
  wait 4.1;
  level.player playSound("hijk_end_scene_p7");
  wait 4.64;
  common_scripts\utility::flag_set("player_dead");
  wait 1;
  maps\_audio_zone_manager::_id_156C("end_fade_zone");
}

_id_0112() {
  level.player playSound("hijk_end_scene_p3");
}

_id_7D15() {
  level.player playSound("hijk_end_scene_p8");
}

blackout() {
  var_0 = spawn("script_origin", (0, 0, 0));
  wait 4.38;
  var_0 playSound("hijk_blackout_v01");
  wait 9.0;
  var_0 playSound("hijk_blackout_v02");
  wait 6.0;
  var_0 playSound("hijk_blackout_v03");
}

_id_5942() {
  if(isDefined(level._id_5943)) {
    level._id_5943 stoploopsound();

  }
  if(!isDefined(level._id_55CA)) {
    level._id_55CA = spawn("script_origin", level._id_5943.origin);
    level._id_55CA linkto(level._id_5943, "tag_origin", (0, 0, 64), (0, 0, 0));
  }

  thread _id_592F();

  if(!isDefined(level._id_55CA._id_5624)) {
    level._id_55CA._id_5624 = 1;
    level._id_55CA playLoopSound("chopper_main");
    var_0 = 0.05;

    while(isDefined(level._id_55CA)) {
      level._id_55CA _id_562B(var_0, 80, 0.890899, 1.25992, 1.0, 8192, 2.0, 12);
      wait(var_0);
      waittillframeend;

      if(isDefined(self._id_5607) && isDefined(self._id_5607.enabled) && !level._id_55CA.enabled) {
        break;
      }
    }
  }
}

_id_5944() {
  if(isDefined(level._id_5943)) {
    level._id_5943 stoploopsound();

  }
  if(!isDefined(level._id_55CA)) {
    level._id_55CA = spawn("script_origin", level._id_5943.origin);
    level._id_55CA linkto(level._id_5943, "tag_origin", (0, 0, 64), (0, 0, 0));
  }

  if(!isDefined(level._id_55CA._id_5624)) {
    level._id_55CA._id_5624 = 1;
    level._id_55CA playLoopSound("chopper_main");
    var_0 = 0.05;

    while(isDefined(level._id_55CA)) {
      level._id_55CA _id_562B(var_0, 80, 0.890899, 1.25992, 1.0, 8192, 2.0, 12);
      wait(var_0);
      waittillframeend;

      if(isDefined(self._id_5607) && isDefined(self._id_5607.enabled) && !level._id_55CA.enabled) {
        break;
      }
    }
  }
}

_id_562D(var_0, var_1, var_2, var_3) {
  maps\_audio_mix_manager::_id_1517(var_0, var_1);
  wait(var_2);
  maps\_audio_mix_manager::_id_1520(var_0, var_3);
}

_id_5945(var_0, var_1) {
  maps\_audio::_id_1570(var_0, 0);
  wait(var_1);
  maps\_audio::_id_172B(0);
}

_id_5946(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_5947(var_0, var_3, var_4, var_5, var_6, var_7, var_8, 1, var_9);
  wait(var_0 + var_1);
  _id_5947(var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0, var_9);
}

_id_5947(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isarray(var_1)) {
    for(var_9 = 0; var_9 < var_1.size; var_9++) {
      level.player seteq(var_1[var_9], 0, 0, "lowpass", 0, 20000, 1);
      level.player seteq(var_1[var_9], 1, var_2, var_3, var_4, var_5, var_6);
    }
  } else {
    level.player seteq(var_1, 0, 0, "lowpass", 0, 20000, 1);
    level.player seteq(var_1, 1, var_2, var_3, var_4, var_5, var_6);
  }

  level.player seteqlerp(0, var_7);
  thread _id_5948(var_0, var_7, var_8);
}

_id_5948(var_0, var_1, var_2) {
  var_3 = 0.05;
  var_4 = var_0 / var_3;
  var_5 = 1.0 / var_4;
  var_6 = 0;

  while(var_6 <= 1) {
    level.player seteqlerp(var_6, var_1);
    var_6 = var_6 + var_5;
    wait(var_3);
  }

  level.player seteqlerp(1, var_1);

  if(isDefined(var_2)) {
    maps\_audio::_id_156E(var_2);
  }
}

_id_562B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(isDefined(self) && !isDefined(self._id_5607)) {
    self._id_5607 = spawnStruct();

  }
  if(!isDefined(level._id_0113)) {
    level._id_0113 = 1;

  }
  if(!isDefined(level._id_0114)) {
    level._id_0114 = 0;

  }
  if(level._id_0113 == 1) {
    if(isDefined(self) && !isDefined(self._id_5607.enabled)) {
      self._id_5607.enabled = 1;

    }
    if(isDefined(self) && isDefined(self._id_5607) && isDefined(self._id_5607.enabled) && self._id_5607.enabled) {
      if(isDefined(self) && !isDefined(self._id_5607._id_562C)) {
        self._id_5607._id_562C = self.origin;

      }
      self._id_5607.velocity = (self.origin - self._id_5607._id_562C) / 2;

      if(isDefined(self) && isDefined(self._id_5607.velocity)) {
        var_8 = vectornormalize(level.player.origin - self.origin);
        var_9 = vectordot(self._id_5607.velocity, var_8);
        var_10 = var_9;

        if(!isDefined(var_5) || var_5 <= 0) {
          var_11 = 1;
        } else {
          var_12 = distance(level.player.origin, self.origin);
          var_13 = var_5;
          var_14 = 0;
          var_15 = var_6;
          var_16 = (var_15 - var_14) / (var_13 - (0 - var_13));
          var_17 = clamp(var_12, 0 - var_13, var_13);
          var_11 = var_14 + (var_17 - (0 - var_13)) * var_16;
          var_10 = var_10 * var_11;
        }

        var_18 = (var_3 - var_2) / (var_1 - (0 - var_1));
        var_19 = clamp(var_10, 0 - var_1, var_1);
        var_20 = var_2 + (var_19 - (0 - var_1)) * var_18;

        if(!isDefined(var_4) || var_4 <= 0) {
          var_4 = 1;

        }
        var_21 = var_20 * var_4;

        if(isDefined(var_21)) {
          self setpitch(var_21, var_0);

        }
        if(level._id_0114 == 1) {
          var_22 = 0.75;
          var_23 = 0.25;
          var_24 = 0.25;
          var_25 = 0.666666;
          var_26 = 2;

          if(isDefined(var_7)) {
            var_26 = var_7;

          }
          var_27 = (0, 0, 128);
          var_28 = "doppler():: " + var_10 + " pitch: " + var_21;
        }

        if(level._id_0114 == 2) {}
      }

      if(isDefined(self)) {
        self._id_5607._id_562C = self.origin;
      }
    }
  }
}
/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_aud.gsc
***************************************/

main() {
  maps\_audio::aud_init();
  maps\_audio::aud_set_timescale("default");
  maps\_audio::aud_set_occlusion("med_occlusion");
  maps\_audio::set_stringtable_mapname("rvn");
  aud_init_globals();
  aud_init_flags();
  aud_launch_threads();
  aud_launch_loops();
  aud_create_level_envelop_arrays();
  aud_add_note_track_data();
  aud_precache_presets();
  maps\_audio_mix_manager::mm_add_submix("mix_hijack_global");
  aud_register_handlers();
}

aud_init_flags() {
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

aud_init_globals() {
  level.bpreturbready = 0;
  level.bturbstarted = 0;
  level.bdebatestarted = 0;
  level.bfailingengineplayed = 0;
  level.bjetfallingstarted = 0;
  level.bcrashsequenceendplayed = 0;
  level.bfighterpassed = 0;
  level.btarmacshiftplayed = 0;
  level.bpreexplosionplayed = 0;
  level.bdebriswait = 0;
  level.bplatewait = 0;
  level.bmusicrevealextplayed = 0;
  level.bwingsettleplayed = 0;
  level.bzgdoorwaystarted = 0;
  level.btarmacdistfireplayed = 0;
  level.bposttarmaccombattrig = 0;
  level.bambigunsplaying = 0;
  level.last_death_index = 0;
}

aud_launch_threads() {}

aud_launch_loops() {}

aud_create_level_envelop_arrays() {}

aud_add_note_track_data() {}

aud_precache_presets() {
  maps\_audio_mix_manager::mm_precache_preset("mix_hijack_global");
  maps\_audio_mix_manager::mm_precache_preset("bassline_mix");
  maps\_audio_mix_manager::mm_precache_preset("debate_pre_breach_mix");
  maps\_audio_mix_manager::mm_precache_preset("debate_checkpoint_mix");
  maps\_audio_mix_manager::mm_precache_preset("door_breach_mix");
  maps\_audio_mix_manager::mm_precache_preset("debate_post_breach_mix");
  maps\_audio_mix_manager::mm_precache_preset("turb_mix");
  maps\_audio_mix_manager::mm_precache_preset("zero_g_mix");
  maps\_audio_mix_manager::mm_precache_preset("zero_g_ramp_mix");
  maps\_audio_mix_manager::mm_precache_preset("post_zero_g_mix");
  maps\_audio_mix_manager::mm_precache_preset("lowerlev_mix");
  maps\_audio_mix_manager::mm_precache_preset("command_room_mix");
  maps\_audio_mix_manager::mm_precache_preset("cargo_room_mix");
  maps\_audio_mix_manager::mm_precache_preset("pre_crash_mix");
  maps\_audio_mix_manager::mm_precache_preset("pre_crash_duck_mix");
  maps\_audio_mix_manager::mm_precache_preset("crash_mix");
  maps\_audio_mix_manager::mm_precache_preset("crash_breached_mix");
  maps\_audio_mix_manager::mm_precache_preset("crash_death_mix");
  maps\_audio_mix_manager::mm_precache_preset("ground_internal_mix");
  maps\_audio_mix_manager::mm_precache_preset("ground_external_mix");
  maps\_audio_mix_manager::mm_precache_preset("end_mix");
  maps\_audio_mix_manager::mm_precache_preset("makarov_mix");
  maps\_audio_mix_manager::mm_precache_preset("end_fade_mix");
  maps\_audio_mix_manager::mm_precache_preset("debate_room_expl1_mix");
  maps\_audio_mix_manager::mm_precache_preset("zero_g_moan_mix");
  maps\_audio_mix_manager::mm_precache_preset("zero_g_bodyslam_mix");
  maps\_audio_mix_manager::mm_precache_preset("lowerlev_roll_mix");
  maps\_audio_mix_manager::mm_precache_preset("exterior_reveal_mix");
  maps\_audio_mix_manager::mm_precache_preset("combat_explosion_mix");
  maps\_audio_mix_manager::mm_precache_preset("kill_vo_mix");
}

aud_register_handlers() {
  maps\_audio::aud_register_msg_handler(::hijack_aud_msg_handler);
  maps\_audio::aud_register_msg_handler(::music_msg_handler);
}

hijack_aud_msg_handler(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "start_airplane":
    case "default":
      thread intro_music();
      maps\_audio_zone_manager::azm_start_zone("jet_normal_zone");
      thread conf_room_shots_prime();
      thread jet_rumble();
      thread migs_1();
      thread radio_com_intro();
      break;
    case "debate":
      maps\_audio_zone_manager::azm_start_zone("debate_checkpoint_zone");
      thread conf_room_shots_prime();
      thread jet_rumble();
      break;
    case "start_pre_zero_g":
      maps\_audio_zone_manager::azm_start_zone("jet_turb_zone");
      thread pre_zero_g_rumble_cp();
      level.bdebatestarted = 1;
      break;
    case "start_lower_level_combat":
      maps\_audio_zone_manager::azm_start_zone("jet_post_zero_g_zone");
      maps\_audio_music::mus_play("hijk_mx_lowerdeck_shootout");
      thread jet_falling_2d();
      thread post_zero_g_rumble();
      level.bturbstarted = 1;
      level.bdebatestarted = 1;
      break;
    case "start_crash":
      maps\_audio_zone_manager::azm_start_zone("jet_command_room_zone");
      maps\_audio_music::mus_play("hijk_mx_lowerdeck_shootout");
      break;
    case "start_tarmac":
      maps\_audio_zone_manager::azm_start_zone("ground_internal_zone");
      level.bcrashsequenceendplayed = 1;
      thread music_cue_postcrash_cp();
      break;
    case "start_tarmac_2":
      maps\_audio_zone_manager::azm_start_zone("ground_external_zone");
      level.bcrashsequenceendplayed = 1;
      level.bpreexplosionplayed = 1;
      level.btarmacshiftplayed = 1;
      thread engine_pre_explosion();
      break;
    case "start_post_tarmac":
      maps\_audio_zone_manager::azm_start_zone("ground_external_zone");
      level.bcrashsequenceendplayed = 1;
      level.bpreexplosionplayed = 1;
      break;
    case "start_end_scene":
      maps\_audio_zone_manager::azm_start_zone("ground_external_zone");
      level.bcrashsequenceendplayed = 1;
      level.bpreexplosionplayed = 1;
      level.bposttarmaccombattrig = 1;
      level.bambigunsplaying = 1;
      maps\_audio_music::mus_play("hijk_tarmac_combat_cp");
      thread ambiguns1();
      thread ambiguns2();
      thread ambiguns3();
      thread ambiguns4();
      thread ambiguns5();
      thread siren_mayhem_cp();
      break;
    case "intro_door1_open":
      var_3 = getEnt("intro_door1", "targetname");
      common_scripts\utility::play_sound_in_space("hijk_door1open", var_3.origin);
      break;
    case "pres_drops_paper":
      thread paper_drop();
      break;
    case "hijk_cart_moves":
      thread hijk_cart_moves();
      break;
    case "keypad":
      thread keypad();
      break;
    case "hijk_agent_espresso":
      thread hijk_agent_espresso();
      break;
    case "start_news":
      thread news_broadcast();
      break;
    case "debate_door_close":
      thread debate_door_close();
      break;
    case "debate_room_start":
      if(level.bdebatestarted == 0) {
        maps\_audio_zone_manager::azm_start_zone("debate_pre_breach_zone");
        level.bdebatestarted = 1;
      }

      break;
    case "stop_news":
      common_scripts\utility::flag_set("stop_news_broadcast");
      thread chairs_and_props();
      break;
    case "start_typing":
      thread typing_sound();
      thread debate_bumps();
      break;
    case "conf_room_shots":
      common_scripts\utility::flag_set("conf_room_shots_go");
      common_scripts\utility::flag_set("stop_typing_sound");
      thread conf_room_explosion2_prime();
      thread conf_room_explosion1_prime();
      thread conf_room_c4_plant_prime();
      thread agent_1_dash();
      thread agent_2_dash();
      break;
    case "conf_room_explosion1":
      common_scripts\utility::flag_set("conf_room_explosion1_go");
      break;
    case "seatbeltsign":
      thread seatbeltsign();
      break;
    case "rumble_foley":
      thread agent_1_rumble_foley();
      thread agent_2_rumble_foley();
      thread agent_1_back();
      break;
    case "conf_room_plant_c4":
      common_scripts\utility::flag_set("conf_room_c4_plant_go");
      break;
    case "conf_room_explosion2":
      common_scripts\utility::flag_set("conf_room_explosion2_go");
      break;
    case "lets_kick_ass":
      thread pre_breach_music_cue();
      break;
    case "pre_turbulence_ready":
      level.bpreturbready = 1;
      break;
    case "pre_turbulence_start":
      if(level.bpreturbready == 1) {
        thread turbine_wind_e();
        level.bpreturbready = 0;
      }

      break;
    case "turbulence_start":
      if(level.bturbstarted == 0) {
        thread pre_zero_g_rumble();
        level.bturbstarted = 1;
      }

      break;
    case "hallway_lurch":
      thread hallway_lurch(var_1);
      break;
    case "hijk_agent_stumblehit":
      thread hijk_agent_stumblehit();
      break;
    case "failing_engine":
      if(level.bfailingengineplayed == 0) {
        thread failing_engine();
        maps\_audio::aud_send_msg("turbulence_start");
        level.bfailingengineplayed = 1;
      }

      break;
    case "rumble":
      thread turbulence_2d();
      thread kitchen_rattle();
      break;
    case "rumble_boom":
      thread turbulence_2d_boom();
      break;
    case "zero_g_doorway":
      if(level.bzgdoorwaystarted == 0) {
        thread turbine_wind_a();
        level.bzgdoorwaystarted = 1;
      }

      break;
    case "zero_g_start":
      thread zero_g_start();
      common_scripts\utility::flag_set("up_prezerog_rumble");
      break;
    case "zero_g_bodyslam1":
      thread zero_g_bodyslam1();
      thread props_debris1();
      break;
    case "zero_g_bodyslam2":
      thread zero_g_bodyslam2();
      thread props_debris2();
      break;
    case "zero_g_bodyslam3":
      thread zero_g_bodyslam3();
      thread props_debris3();
      break;
    case "zero_g_bodyslam4":
      thread zero_g_bodyslam4();
      thread props_debris4();
      thread zero_g_end_stress();
      break;
    case "zero_g_debris_crash":
      thread zero_g_debris_crash();
      break;
    case "turbine_wind_a":
      thread turbine_wind_a();
      break;
    case "turbine_wind_b":
      thread turbine_wind_b();
      break;
    case "turbine_wind_c":
      thread turbine_wind_c();
      break;
    case "jet_roll_v01":
      thread jet_roll_v01();
      break;
    case "jet_roll_v02":
      thread jet_roll_v02();
      thread metal_tanks();
      break;
    case "jet_post_zero_g":
      maps\_audio_zone_manager::azm_start_zone("jet_post_zero_g_zone");
      break;
    case "jet_lowerlev_occlusion1":
      maps\_audio_zone_manager::azm_start_zone("jet_lowerlev_zone");
      break;
    case "jet_lowerlev_occlusion2":
      maps\_audio_zone_manager::azm_start_zone("jet_command_room_zone");
      break;
    case "cargo_room_zone_on":
      thread cargo_room_zone_on();
      break;
    case "jet_lowerlev_occlusion3":
      maps\_audio_zone_manager::azm_start_zone("pre_crash_zone");
      break;
    case "suitcase_prop_sound_impact":
      var_4 = spawn("script_origin", level.player.origin);
      var_4 linkTo(level.player);
      var_4 playSound("hijk_luggage_fall", "soundone");
      var_4 waittill("sounddone");
      var_4 delete();
      break;
    case "approaching_ground":
      maps\_audio_zone_manager::azm_start_zone("pre_crash_zone");
      thread approaching_ground();
      break;
    case "pre_crash_door":
      thread pre_crash_door();
      break;
    case "crash_sequence":
      thread crash_sequence();
      thread crash_props();
      thread crash_badguys_bodyfalls();
      break;
    case "crash_explosion":
      thread crash_explosion();
      break;
    case "crash_chunk_breaks_away":
      thread crash_chunk_breaks_away();
      break;
    case "tower_impact":
      thread tower_impact();
      break;
    case "crash_death":
      thread crash_death();
      break;
    case "agent_scream":
      var_5 = var_1;
      thread crazy_guy_goes_flying(var_5);
      break;
    case "crash_sequence_turbine":
      thread crash_sequence_turbine();
      break;
    case "crash_sequence_end":
      if(level.bcrashsequenceendplayed == 0) {
        thread crash_sequence_end();
        thread commander_clears_debris();
        thread music_cue_postcrash();
        level.bcrashsequenceendplayed = 1;
      }

      break;
    case "debris_shift1":
      thread debris_shift1();
      break;
    case "debris_shift2":
      thread debris_shift2();
      break;
    case "debris_shift3":
      thread debris_shift3();
      break;
    case "debris_shift4":
      thread debris_shift4();
      break;
    case "debris_shift5":
      thread debris_shift5();
      break;
    case "debris_shift6":
      thread debris_shift6();
      break;
    case "debris_shift7":
      thread debris_shift7();
      break;
    case "debris_shift8":
      thread debris_shift8();
      break;
    case "debris_shift9":
      thread debris_shift9();
      break;
    case "debris_shift10":
      thread debris_shift10();
      break;
    case "debris_shift11":
      thread debris_shift11();
      break;
    case "debris_shift12":
      thread debris_shift12();
      break;
    case "debris_shift13":
      thread debris_shift13();
      break;
    case "debris_shift14":
      thread debris_shift14();
      break;
    case "debris_shift15":
      thread debris_shift15();
      break;
    case "debris_shift16":
      thread debris_shift16();
      break;
    case "debris_shift17":
      thread debris_shift17();
      break;
    case "plate_shift1":
      thread plate_shift1();
      break;
    case "plate_shift2":
      thread plate_shift2();
      break;
    case "music_reveal_exterior":
      if(level.bmusicrevealextplayed == 0) {
        thread music_reveal_exterior();
        level.bmusicrevealextplayed = 1;
      }

      break;
    case "ground_external_start":
      maps\_audio_zone_manager::azm_start_zone("ground_external_zone");

      if(level.bfighterpassed == 0) {
        thread fighter_jet_pass_ground();
        level.bfighterpassed = 1;
      }

      break;
    case "wreck_exit_expl":
      thread wreck_exit_explosion();
      break;
    case "wing_settle":
      if(level.bwingsettleplayed == 0) {
        thread wing_settle();
        level.bwingsettleplayed = 1;
      }

      break;
    case "engine_pre_explosion":
      if(level.bpreexplosionplayed == 0) {
        thread engine_pre_explosion();
        level.bpreexplosionplayed = 1;
      }

      break;
    case "engine_explosion":
      thread engine_explosion();
      break;
    case "flare_gun":
      thread flare_gun();
      break;
    case "random_tail_expl":
      if(level.bposttarmaccombattrig == 0) {
        thread random_tail_expl();
      }
      break;
    case "ground_internal_start":
      maps\_audio_zone_manager::azm_start_zone("ground_internal_zone");
      break;
    case "tarmac_shift":
      if(level.btarmacshiftplayed == 0) {
        thread tarmac_shift();
        level.btarmacshiftplayed = 1;
      }

      break;
    case "fighter_jet_pass_ground":
      thread fighter_jet_pass_ground();
      break;
    case "tarmac_dist_fire":
      if(level.btarmacdistfireplayed == 0) {
        thread tarmac_dist_fire();
        level.btarmacdistfireplayed = 1;
      }

      break;
    case "tarmac_combat_music":
      thread tarmac_combat_music();
      break;
    case "first_suv":
      thread first_suv();
      break;
    case "player_entered_end_area":
      maps\_audio_zone_manager::azm_start_zone("end_zone");
      thread heli();

      if(level.bambigunsplaying == 0) {
        thread ambiguns1();
        thread ambiguns2();
        thread ambiguns3();
        thread ambiguns4();
        level.bambigunsplaying = 1;
      }

      break;
    case "suv_explosion":
      thread suv_explosion();
      break;
    case "end_heli_approach":
      thread end_area_chopper_begin();
      break;
    case "makarov_slow":
      thread heli_door();
      thread makarov_slow();
      thread end_scene_foley1();
      thread end_scene_foley2();
      break;
    case "commander_shot":
      thread commander_shot();
      break;
    case "player_shot":
      thread player_shot();
      break;
    case "blackout":
      thread blackout();
      break;
    default:
      maps\_audio::aud_print("payback_aud_msg_handler() unhandled message: " + var_0);
      var_2 = 0;
      break;
  }

  return var_2;
}

music_msg_handler(var_0, var_1) {
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

intro_music() {
  wait 3.0;
  maps\_audio_music::mus_play("hijk_mx_levelstart");
}

jet_rumble() {
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

migs_1() {
  wait 0.5;
  level.jet_1a.audio = spawn("script_origin", level.jet_1a.origin);
  level.jet_1a.audio linkTo(level.jet_1a);
  level.jet_1a.audio playLoopSound("hijk_jet_engine_intro_lfe");
  level.jet_1a.audio scalevolume(0.2);
  var_0 = spawn("script_origin", (-31000, 15536, 7360));
  var_1 = (-28000, 15536, 7360);
  var_0 playLoopSound("hijk_jet_engine_intro");
  var_0 scalevolume(0.2);
  wait 4.5;
  var_0 moveTo(var_1, 30.0);
  wait 3;
  level.jet_1a.audio scalevolume(1, 10);
  var_0 scalevolume(1, 10);
  wait 8.0;
  level.jet_1b.audio = spawn("script_origin", level.jet_1b.origin);
  level.jet_1b.audio linkTo(level.jet_1b);
  level.jet_1b.audio playSound("hijk_jet_by_pullup");
  wait 5.0;
  var_0 scalevolume(0.707, 8);
  wait 9.0;
  level.jet_1a.audio playSound("hijk_jet_by_takeoff");
  wait 2;
  level.jet_1a.audio scalevolume(0, 1);
  level.jet_1b.audio playSound("hijk_jet_by_takeoff");
  wait 3;
  var_0 scalevolume(0, 8);
  common_scripts\utility::flag_wait("second_migs");
  thread migs_2();
  var_0 scalevolume(0, 2.5);
  wait 3;
  var_0 delete();
}

migs_2() {
  wait 0.5;
  level.jet_2b.audio = spawn("script_origin", level.jet_2b.origin);
  level.jet_2b.audio linkTo(level.jet_2b);
  level.jet_2b.audio playSound("hijk_hallway_flyby");
}

paper_drop() {
  wait 6.5;
  level.president playSound("hijk_pres_paper");
}

hijk_cart_moves() {
  wait 0.25;
  var_0 = spawn("script_origin", (-29306, 12786, 7346));
  var_0 playSound("hijk_agent_cart");
}

radio_com_intro() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1, 0);
  wait 0.01;
  var_0 scalevolume(1, 2);
  var_0 playLoopSound("hijk_radio_com_intro");
  wait 17.5;
  level.player playSound("hijk_radio_com_intro_out");
  maps\_audio::aud_fade_out_and_delete(var_0, 0.1);
}

kitchen_rattle() {
  wait 0;
  var_0 = spawn("script_origin", (-29044, 12678, 7346));
  var_0 playSound("hijk_turb_glasses");
}

typing_sound() {
  wait 1;
  var_0 = spawn("script_origin", (-28513, 12804, 7318));
  var_0 playLoopSound("hijk_lapt_typing");
  common_scripts\utility::flag_wait("stop_typing_sound");
  var_0 stoploopsound("hijk_lapt_typing");
}

debate_bumps() {
  var_0 = spawn("script_origin", (-28320, 12784, 7312));
  wait 15.5;
  var_0 playSound("hijk_debate_bump_01");
  wait 5;
  var_0 playSound("hijk_debate_bump_02");
  wait 4;
  var_0 delete();
}

keypad() {
  wait 11;
  var_0 = spawn("script_origin", (-28832, 12784, 7344));
  var_0 playSound("hijk_keypad");
  wait 2;
  var_0 delete();
}

hijk_agent_espresso() {
  wait 15;
  var_0 = spawn("script_origin", (-29072, 12678, 7332));
  var_0 playLoopSound("hijk_agent_espresso");
  common_scripts\utility::flag_wait("stop_kitchen");
  maps\_audio::aud_fade_out_and_delete(var_0, 1);
}

news_broadcast() {
  var_0 = spawn("script_origin", (-28354, 12820, 7390));
  var_0 playSound("hijack_tvb_worldmarkets");
  common_scripts\utility::flag_wait("stop_news_broadcast");
  maps\_audio::aud_fade_out_and_delete(var_0, 0.01);
}

debate_door_close() {
  level.door3 playSound("hijk_door3close");
  common_scripts\utility::flag_set("stop_kitchen");
}

chairs_and_props() {
  wait 4;
  level.president playSound("chair_enter");
  wait 0.5;
  level.advisor playSound("chair_enter");
  wait 2;
  level.polit_1 playSound("chair_enter");
}

agent_1_dash() {
  wait 3;
  level.intro_agent2 playSound("hijk_agent_dash1");
}

agent_2_dash() {
  wait 2;
  level.hero_agent_01 playSound("hijk_agent_dash2");
  wait 2;
  level.hero_agent_01 playSound("hijk_agent_coverup");
}

agent_1_back() {
  wait 2;
  level.intro_agent2 playSound("hijk_agent_dash3");
}

agent_1_rumble_foley() {
  wait 1;
  level.intro_agent2 playSound("hijk_agent_blastfall1");
}

agent_2_rumble_foley() {
  wait 0;
  level.hero_agent_01 playSound("hijk_agent_blastfall2");
  wait 3;
}

pre_breach_music_cue() {
  wait 1.5;
  maps\_audio_music::mus_play("hijk_pre_breach");
}

hallway_lurch(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  thread turbulence_2d();
  thread turbine_wind_d();

  if(var_0) {
    var_1 playSound("hijk_zero_g_bigshake");
  }
  var_1 playSound("hijk_tilt_stress_01");
}

hijk_agent_stumblehit() {
  wait 1;
  level.commander playSound("hijk_agent_stumblehit");
}

pre_zero_g_rumble() {
  maps\_audio_zone_manager::azm_start_zone("jet_turb_zone");
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
  maps\_audio::aud_fade_out_and_delete(var_2, 1.0);
  maps\_audio::aud_fade_out_and_delete(var_1, 2.0);
  wait 20;
  var_0 scalevolume(0, 8.0);
  thread post_zero_g_rumble();
  wait 9;
  var_0 delete();
}

pre_zero_g_rumble_cp() {
  maps\_audio_zone_manager::azm_start_zone("jet_turb_zone");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0 playLoopSound("pre_zero_g_rumble");
  var_1 playLoopSound("loop_jet_tilt");
  var_0 scalevolume(0.4, 0);
  var_1 scalevolume(1, 0);
  common_scripts\utility::flag_wait("up_prezerog_rumble");
  var_0 scalevolume(1, 10);
  maps\_audio::aud_fade_out_and_delete(var_1, 2.0);
  wait 15;
  maps\_audio::aud_fade_out_and_delete(var_0, 4.0);
  wait 12;
  thread post_zero_g_rumble();
}

zero_g_start() {
  maps\_audio_music::mus_stop(6);
  thread zero_g_tilt_moan_sequence();
  maps\_audio_zone_manager::azm_start_zone("jet_zero_g_zone");
  var_0 = spawn("script_origin", (0, 0, 0));
  thread zero_g_lfe();
  var_0 playSound("hijk_zero_g_start");
  var_0 playSound("hijk_zero_g_winding");
  thread briefcase_impact();
  wait 8;
  maps\_audio_zone_manager::azm_start_zone("jet_zero_g_ramp_zone");
  wait 12;
  thread turbine_wind_c();
  wait 4;
  thread jet_falling_2d();
  maps\_audio_zone_manager::azm_start_zone("jet_post_zero_g_zone");
  maps\_audio_music::mus_play("hijk_mx_lowerdeck_shootout");
}

zero_g_lfe() {
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

briefcase_impact() {
  wait 2;
  common_scripts\utility::play_sound_in_space("hijk_briefcase_impact", (-27328, 12688, 7360));
}

zero_g_tilt_moan_sequence() {
  wait 2.3;
  thread tilt_moan_02();
  wait 12.0;
  thread tilt_moan_03();
}

tilt_moan_01() {
  level.player playSound("hijk_tilt_moan_01");
  wait 0.3;
  thread mm_add_submix_oneshot("zero_g_moan_mix", 0.4, 0.1, 0.8);
}

tilt_moan_02() {
  level.player playSound("hijk_tilt_moan_02");
  wait 0.3;
  thread mm_add_submix_oneshot("zero_g_moan_mix", 0.4, 0.1, 0.8);
}

tilt_moan_03() {
  level.player playSound("hijk_tilt_moan_03");
  wait 0.3;
  thread mm_add_submix_oneshot("zero_g_moan_mix", 0.4, 0.1, 0.8);
}

zero_g_bodyslam1() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (-27568, 12848, 7318));
  var_0 playSound("hijk_zero_g_bigshake");
  wait 0.5;
  var_1 playSound("hijk_misc_sm_debris");
}

props_debris1() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.2;
  level.player playSound("hijk_props_debris");
}

zero_g_bodyslam2() {
  thread mm_add_submix_oneshot("zero_g_bodyslam_mix", 0, 0.1, 1.0);
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (-27552, 12688, 7318));
  var_0 playSound("hijk_body_slam");
  wait 0.5;
  var_1 playSound("hijk_misc_sm_debris");
}

props_debris2() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.3;
  level.player playSound("hijk_props_debris");
}

zero_g_bodyslam3() {
  thread mm_add_submix_oneshot("zero_g_bodyslam_mix", 0, 0.1, 1.0);
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (-27392, 12688, 7318));
  var_0 playSound("hijk_body_slam");
  wait 0.5;
  var_1 playSound("hijk_misc_sm_debris");
}

props_debris3() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.3;
  level.player playSound("hijk_props_debris");
}

zero_g_bodyslam4() {
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

props_debris4() {
  wait 0;
  level.player playSound("hijk_props_debris");
  wait 0.2;
  level.player playSound("hijk_props_debris");
  wait 6;
  level.player playSound("hijk_props_debris");
  level.player playSound("hijk_props_debris");
}

zero_g_end_stress() {
  wait 5.0;
  level.player playSound("hijk_tilt_stress_02");
}

zero_g_debris_crash() {
  var_0 = spawn("script_origin", (0, 0, 0));
  wait 0.2;
  var_0 playSound("hijk_zero_g_debris_crash");
  thread mm_add_submix_oneshot("zero_g_bodyslam_last_mix", 0, 0.3, 1.0);
  wait 2;
  var_0 delete();
}

post_zero_g_rumble() {
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

jet_falling_2d() {
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

conf_room_shots_prime() {
  var_0 = spawn("script_origin", (-28352, 12740, 7328));
  var_1 = spawn("script_origin", (0, 0, 0));
  level.aud.loc_3d = var_0;
  var_0 maps\_audio::aud_prime_stream("hijk_conf_shots_3d");
  common_scripts\utility::flag_wait("conf_room_shots_go");
  var_0 playSound("hijk_conf_shots_3d");
  var_1 playSound("hijk_conf_shots_2d");
  wait 13;
  maps\_audio::aud_release_stream("hijk_conf_shots_3d");
}

seatbeltsign() {
  wait 1.7;
  var_0 = spawn("script_origin", (-28352, 12740, 7328));
  var_0 playSound("hijk_seatbelt_bell");
  wait 5;
  var_0 delete();
}

conf_room_explosion1_prime() {
  var_0 = spawn("script_origin", (-28368, 12880, 7328));
  var_1 = spawn("script_origin", (-28368, 12672, 7328));
  var_2 = spawn("script_origin", (-28672, 12656, 7328));
  var_3 = spawn("script_origin", (-28576, 12784, 7328));
  level.aud.loc_left = var_0;
  level.aud.loc_right = var_1;
  var_0 maps\_audio::aud_prime_stream("hijk_c4_distant_l");
  var_1 maps\_audio::aud_prime_stream("hijk_c4_distant_r");
  common_scripts\utility::flag_wait("conf_room_explosion1_go");
  thread conf_room_expl1_submix();
  var_0 playSound("hijk_c4_distant_l");
  wait 0.05;
  var_1 playSound("hijk_c4_distant_r");
  wait 0.1;
  var_2 playSound("hijk_bottles_break");
  var_3 playSound("hijk_table_rattle");
  thread desk_debris_01();
  thread desk_debris_02();
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
  maps\_audio::aud_release_stream("hijk_c4_distant_l");
  maps\_audio::aud_release_stream("hijk_c4_distant_r");
}

desk_debris_01() {
  wait 1.2;
  common_scripts\utility::play_sound_in_space("hijk_desk_debris_01", (-28480, 12736, 7328));
}

desk_debris_02() {
  wait 1.05;
  common_scripts\utility::play_sound_in_space("hijk_desk_debris_02", (-28704, 12736, 7328));
}

conf_room_expl1_submix() {
  thread mm_add_submix_oneshot("debate_room_expl1_mix", 0, 0.8, 2);
}

conf_room_c4_plant_prime() {
  var_0 = spawn("script_origin", (-28352, 12740, 7328));
  level.aud.loc = var_0;
  var_0 maps\_audio::aud_prime_stream("hijk_c4_plant");
  common_scripts\utility::flag_wait("conf_room_c4_plant_go");
  wait 2.5;
  var_0 playSound("hijk_c4_plant");
  wait 8;
  maps\_audio::aud_release_stream("hijk_c4_plant");
  var_0 delete();
}

conf_room_explosion2_prime() {
  var_0 = spawn("script_origin", (-28352, 12768, 7328));
  var_1 = spawn("script_origin", (-28352, 12704, 7328));
  var_2 = spawn("script_origin", (-28624, 12784, 7328));
  var_3 = spawn("script_origin", (-28496, 12784, 7328));
  var_4 = spawn("script_origin", (0, 0, 0));
  var_5 = spawn("script_origin", (-28784, 12848, 7390));
  level.aud.c4_l = var_0;
  level.aud.c4_r = var_1;
  var_0 maps\_audio::aud_prime_stream("hijk_c4_door_l");
  var_1 maps\_audio::aud_prime_stream("hijk_c4_door_r");
  common_scripts\utility::flag_wait("conf_room_explosion2_go");
  maps\_audio_zone_manager::azm_start_zone("door_breach_zone");
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
  maps\_audio_zone_manager::azm_start_zone("debate_post_breach_zone");
  wait 4;
  maps\_audio::aud_release_stream("hijk_c4_door_l");
  maps\_audio::aud_release_stream("hijk_c4_door_r");
  wait 3;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

turbulence_2d() {
  level.player playSound("hijk_turbulence_2d");
}

turbulence_2d_boom() {
  level.player playSound("hijk_turbulence_lg_2d");
  level.player playSound("hijk_explosion_lg_lfe");
}

failing_engine() {
  var_0 = spawn("script_origin", (-28544, 13648, 7360));
  var_0 playSound("hijk_failing_engine");
  common_scripts\utility::flag_wait("up_prezerog_rumble");
  var_0 scalevolume(0, 4);
  wait 10;
  var_0 delete();
}

turbine_wind_a() {
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

turbine_wind_b() {
  var_0 = spawn("script_origin", (-28128, 13536, 7072));
  var_1 = spawn("script_origin", (-28144, 12032, 7072));
  var_2 = spawn("script_origin", (-30096, 12784, 7072));
  thread ladder_fall();
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
  maps\_audio::aud_fade_out_and_delete(var_0, 4.0);
  maps\_audio::aud_fade_out_and_delete(var_1, 4.0);
  maps\_audio::aud_fade_out_and_delete(var_2, 4.0);
}

ladder_fall() {
  wait 2;
  common_scripts\utility::play_sound_in_space("hijk_ladder_fall", (-28688, 12896, 7168));
}

turbine_wind_c() {
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

turbine_wind_d() {
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

turbine_wind_e() {
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

jet_roll_v01() {
  var_0 = spawn("script_origin", (-27472, 12784, 7184));
  var_1 = spawn("script_origin", (-27536, 12912, 7184));
  var_2 = spawn("script_origin", (-27616, 12672, 7216));
  level.player playSound("hijk_jet_roll_v01");
  thread mm_add_submix_oneshot("lowerlev_roll_mix", 0.1, 0.5, 1.5);
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

jet_roll_v02() {
  var_0 = spawn("script_origin", (-28640, 12912, 7168));
  var_1 = spawn("script_origin", (-28640, 12688, 7168));
  level.player playSound("hijk_jet_roll_v02");
  thread mm_add_submix_oneshot("lowerlev_roll_mix", 0.1, 0.5, 1.5);
  wait 2;
  var_0 playSound("hijk_box_tumble_l");
  var_1 playSound("hijk_box_tumble_r");
  wait 8;
  var_0 delete();
  var_1 delete();
}

cargo_room_zone_on() {
  wait 8;
  maps\_audio_zone_manager::azm_start_zone("jet_cargo_room_zone");
}

metal_tanks() {
  var_0 = spawn("script_origin", (-28556, 12899, 7178));
  wait 2.5;
  var_0 playSound("hijk_props_tanks");
  wait 2.5;
  var_0 playSound("hijk_props_tankroll");
  wait 8;
  var_0 delete();
}

approaching_ground() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("shot_jet_tilt");
  wait 4;
  var_1 playSound("hijk_turbine_wind_2d_l");
  var_1 playSound("hijk_turbine_wind_2d_r");
}

pre_crash_door() {
  var_0 = spawn("script_origin", (-28954, 12781, 7179));
  wait 1;
  var_0 playSound("hijk_precrash_door");
  wait 2.5;
  var_0 delete();
}

crash_sequence(var_0) {
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
  maps\_audio_music::mus_stop(3);
  wait 2.83;
  maps\_audio_zone_manager::azm_start_zone("pre_crash_duck_zone");
  wait 0.3;
  var_2 playSound("hijk_jet_crash_tires");
  maps\_audio_zone_manager::azm_start_zone("jet_crash_zone");
  var_2 playSound("hijk_jet_crash_hitground");
  wait 0.47;
  var_2 playSound("hijk_explosion_lfe");
  var_4 playLoopSound("loop_lfe_shake");
  thread jet_fire();
  wait 2.4;
  thread separation();
  var_3 playSound("hijk_jet_scrape2_lr");
  wait 2.03;
  maps\_audio_zone_manager::azm_start_zone("jet_crash_breached_zone");
  wait 3;
  var_2 playSound("hijk_jet_crash_pitchfx");
  wait 2;
  maps\_audio::aud_fade_out_and_delete(var_3, 2.0);
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

crash_explosion() {
  level.crash_explosion_origin thread maps\_utility::play_sound_on_entity("hijk_crash_left_fire");
}

crash_chunk_breaks_away() {
  level.crash_breakaway_chunk thread maps\_utility::play_sound_on_entity("hijk_crash_chunk");
}

tower_impact() {
  thread mm_add_submix_oneshot("tower_impact_mix", 0, 0.3, 1);
  level.player thread maps\_utility::play_sound_on_entity("hijk_tower_lfe");
  level.player thread maps\_utility::play_sound_on_entity("hijk_tower_impact");
}

crash_props() {
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

crash_badguys_bodyfalls() {
  wait 6.5;
  level.player playSound("hijk_crash_terror_bodyfall");
  level.player playSound("hijk_crash_terror_gundrop1");
  wait 0.5;
  level.player playSound("hijk_crash_terror_bodyfall");
  wait 0.5;
  level.player playSound("hijk_crash_terror_bodyfall");
}

jet_fire() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("shot_jet_fire");
}

separation() {
  var_0 = spawn("script_origin", (-24140, 15908, 4000));
  wait 3.6;
  var_0 playSound("hijk_jet_separation");
  var_0 playSound("hijk_jet_separation_s");
}

crazy_guy_goes_flying(var_0) {
  var_1 = var_0;
  wait 17.75;
  var_1 playSound("hijk_agent_slipscream");
}

crash_death() {
  maps\_audio_zone_manager::azm_start_zone("jet_crash_death_zone");
  level.player playSound("hijk_crash_death");
}

crash_sequence_turbine() {
  if(level.bcrashsequenceendplayed == 0) {
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
    thread mm_add_submix_oneshot("post_crash_blackout_mix", 0.7, 8, 6);
    wait 14;
    level.player playSound("hijk_wake_up_reveal");
  }
}

crash_sequence_end() {
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

music_cue_postcrash() {
  wait 22;
  maps\_audio_music::mus_play("hijk_mx_crash_aftermath");
}

music_cue_postcrash_cp() {
  maps\_audio_music::mus_play("hijk_mx_crash_aftermath");
}

commander_clears_debris() {
  wait 15;
  level.commander playSound("hijk_debris_move1");
  wait 2;
  level.commander playSound("hijk_debris_move2");
  wait 2;
  level.commander playSound("hijk_debris_move3");
  wait 6;
}

debris_shift1() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9008, 4016, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9008, 4016, 208));
    level.bdebriswait = 0;
  }
}

debris_shift2() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (8992, 3856, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (8992, 3856, 208));
    level.bdebriswait = 0;
  }
}

debris_shift3() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9152, 4000, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9152, 4000, 208));
    level.bdebriswait = 0;
  }
}

debris_shift4() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9136, 3856, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9136, 3856, 208));
    level.bdebriswait = 0;
  }
}

debris_shift5() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9280, 3984, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9280, 3984, 208));
    level.bdebriswait = 0;
  }
}

debris_shift6() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9264, 3824, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9264, 3824, 208));
    level.bdebriswait = 0;
  }
}

debris_shift7() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9408, 3968, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9408, 3968, 208));
    level.bdebriswait = 0;
  }
}

debris_shift8() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9376, 3792, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9376, 3792, 208));
    level.bdebriswait = 0;
  }
}

debris_shift9() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9552, 3936, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9552, 3936, 208));
    level.bdebriswait = 0;
  }
}

debris_shift10() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9520, 3792, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9520, 3792, 208));
    level.bdebriswait = 0;
  }
}

debris_shift11() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9680, 3920, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9680, 3920, 208));
    level.bdebriswait = 0;
  }
}

debris_shift12() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9664, 3760, 208));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9664, 3760, 208));
    level.bdebriswait = 0;
  }
}

debris_shift13() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9808, 3888, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9808, 3888, 80));
    level.bdebriswait = 0;
  }
}

debris_shift14() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9888, 3760, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9888, 3760, 80));
    level.bdebriswait = 0;
  }
}

debris_shift15() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10032, 3856, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10032, 3856, 80));
    level.bdebriswait = 0;
  }
}

debris_shift16() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9824, 3824, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (9824, 3824, 80));
    level.bdebriswait = 0;
  }
}

debris_shift17() {
  if(level.bdebriswait == 0) {
    level.bdebriswait = 1;
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10096, 3712, 80));
    common_scripts\utility::play_sound_in_space("shot_debris_shift", (10096, 3712, 80));
    level.bdebriswait = 0;
  }
}

plate_shift1() {
  if(level.bplatewait == 0) {
    level.bplatewait = 1;
    common_scripts\utility::play_sound_in_space("shot_plate_shift", (9472, 3856, 128));
    level.bplatewait = 0;
  }
}

plate_shift2() {
  if(level.bplatewait == 0) {
    level.bplatewait = 1;
    common_scripts\utility::play_sound_in_space("shot_plate_shift", (9200, 3856, 128));
    level.bplatewait = 0;
  }
}

music_reveal_exterior() {
  wait 0.5;
  level.player playSound("hijk_reveal_exterior");
  thread mm_add_submix_oneshot("exterior_reveal_mix", 2.0, 8.0, 8.0);
  wait 2;
  maps\_audio_music::mus_stop(3);
}

wreck_exit_explosion() {
  var_0 = spawn("script_origin", (3488, 4272, 2096));
  var_0 playSound("hijk_wreck_expl");
  wait 0.3;
  level.player playSound("hijk_wreck_expl_bg");
  wait 10;
  var_0 delete();
}

wing_settle() {
  common_scripts\utility::play_sound_in_space("hijk_wing_settle", (9472, 3504, 100));
}

engine_pre_explosion() {
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

engine_explosion() {
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
  level.commander playSound("hijack_cmd_ugh");
  wait 0.4;
  var_3 playSound("hijk_dist_tail2_expl_bg");
  wait 15;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

flare_gun() {
  common_scripts\utility::play_sound_in_space("hijk_flare", (10256, 5968, 1000));
}

heli_approach() {
  if(level.start_point != "end_scene") {
    level.chopper_audio playSound("hijk_heli_approach");
  }
}

random_tail_expl() {
  var_0 = spawn("script_origin", (8512, 6986, 368));
  var_0 playSound("hijk_tail_pre_expl");
  wait 6;
  var_0 delete();
}

tarmac_shift() {
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

fighter_jet_pass_ground() {
  var_0 = spawn("script_origin", (10176, -304, 2096));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("hijk_fighter_pass_ground");
  wait 2;
  var_1 playSound("hijk_fighter_pass_ground_lfe");
  wait 25;
  var_0 delete();
  var_1 delete();
}

tarmac_dist_fire() {
  level endon("stop_tarmac_dist_fire");
  var_0 = spawn("script_origin", (10720, 7840, 600));

  for(;;) {
    var_0 playSound("hijk_tarmac_ambiguns");
    wait(randomfloatrange(0.5, 1.5));
  }
}

tarmac_combat_music() {
  if(level.bposttarmaccombattrig == 0) {
    level.player playSound("hijk_reveal_ground_combat");
    maps\_audio_music::mus_stop(2);
    wait 5;
    maps\_audio_music::mus_play("hijk_tarmac_combat");
    level.bposttarmaccombattrig = 1;
  }
}

first_suv() {
  var_0 = spawn("script_origin", (9792, 7200, 210));
  var_0 playSound("hijk_suv_stop_01");
  thread siren_mayhem();
  maps\_audio_zone_manager::azm_start_zone("post_tarmac_combat_zone");
  wait 8;
  level notify("stop_tarmac_dist_fire");
  var_0 delete();
}

siren_mayhem() {
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

siren_mayhem_cp() {
  var_0 = spawn("script_origin", (6048, 8480, 500));
  var_0 playLoopSound("hijk_siren_mayhem");
  common_scripts\utility::flag_wait("kill_sirens");
  var_0 scalevolume(0, 4);
  wait 5;
  var_0 stoploopsound("hijk_siren_mayhem");
  var_0 delete();
}

heli() {
  var_0 = spawn("script_origin", (10816, 4960, 192));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_2 = spawn("script_origin", (0, 0, 0));
  common_scripts\utility::flag_wait("makarov_slow");
  wait 0.6;
  var_0 playSound("hijk_heli_shot");
  maps\_audio_music::mus_play("hijk_makarov_reveal", 5);
  wait 0.5;
  level.chopper_audio stoploopsound();
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
  maps\_audio_music::mus_stop(0.1);
  var_0 scalevolume(0, 0.25);
  var_1 scalevolume(0, 0.25);
  var_2 scalevolume(0, 0.25);
  thread mm_add_submix_oneshot("kill_vo_mix", 0.25, 10, 10);
  wait 0.3;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

suv_explosion() {
  thread mm_add_submix_oneshot("combat_explosion_mix", 0.1, 0.8, 1.0);
}

end_area_chopper_begin() {
  level.chopper_audio playSound("hijk_heli_approach_close");
}

ambiguns1() {
  level endon("door_used");
  wait 8;
  var_0 = spawn("script_origin", (10336, 5808, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

ambiguns2() {
  level endon("door_used");
  wait 10;
  var_0 = spawn("script_origin", (9680, 5008, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

ambiguns3() {
  level endon("door_used");
  wait 12;
  var_0 = spawn("script_origin", (9712, 4128, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

ambiguns4() {
  level endon("door_used");
  wait 14;
  var_0 = spawn("script_origin", (11088, 3184, 600));

  for(;;) {
    wait(randomfloatrange(2, 5));
    var_0 playSound("hijk_end_scene_ambiguns");
  }
}

ambiguns5() {
  level endon("door_used");
  wait 7;

  for(;;) {
    wait(randomfloatrange(0.5, 4));
    level.player playSound("hijk_bulletwhiz");
  }
}

heli_door() {
  wait 1.25;
  var_0 = spawn("script_origin", (10816, 4960, 192));
  var_0 playSound("hijk_makarov_gunshot");
  common_scripts\utility::flag_set("kill_sirens");
  thread mm_add_submix_oneshot("kill_vo_mix", 0.25, 4, 4);
}

makarov_slow() {
  wait 1.5;
  maps\_audio_music::mus_stop(2);
  wait 0.5;
  maps\_audio_zone_manager::azm_start_zone("makarov_zone");
  wait 1.3;
  common_scripts\utility::flag_set("makarov_slow");
}

end_scene_foley1() {
  wait 5.35;
  level.player playSound("hijk_end_scene_p1");
}

end_scene_foley2() {
  wait 9.55;
  level.player playSound("hijk_end_scene_p2");
  wait 1.32;
  level.commander playSound("hijack_fso1_moan");
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
  maps\_audio_zone_manager::azm_start_zone("end_fade_zone");
}

commander_shot() {
  level.player playSound("hijk_end_scene_p3");
}

player_shot() {
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

loop_chopper_makarov_flyover() {
  if(isDefined(level.makarov_heli)) {
    level.makarov_heli stoploopsound();
  }
  if(!isDefined(level.chopper_audio)) {
    level.chopper_audio = spawn("script_origin", level.makarov_heli.origin);
    level.chopper_audio linkTo(level.makarov_heli, "tag_origin", (0, 0, 64), (0, 0, 0));
  }

  thread heli_approach();

  if(!isDefined(level.chopper_audio._id_5624)) {
    level.chopper_audio._id_5624 = 1;
    level.chopper_audio playLoopSound("chopper_main");
    var_0 = 0.05;

    while(isDefined(level.chopper_audio)) {
      level.chopper_audio tick_doppler(var_0, 80, 0.890899, 1.25992, 1.0, 8192, 2.0, 12);
      wait(var_0);
      waittillframeend;

      if(isDefined(self._doppler) && isDefined(self._doppler.enabled) && !level.chopper_audio.enabled) {
        break;
      }
    }
  }
}

loop_chopper_makarov() {
  if(isDefined(level.makarov_heli)) {
    level.makarov_heli stoploopsound();
  }
  if(!isDefined(level.chopper_audio)) {
    level.chopper_audio = spawn("script_origin", level.makarov_heli.origin);
    level.chopper_audio linkTo(level.makarov_heli, "tag_origin", (0, 0, 64), (0, 0, 0));
  }

  if(!isDefined(level.chopper_audio._id_5624)) {
    level.chopper_audio._id_5624 = 1;
    level.chopper_audio playLoopSound("chopper_main");
    var_0 = 0.05;

    while(isDefined(level.chopper_audio)) {
      level.chopper_audio tick_doppler(var_0, 80, 0.890899, 1.25992, 1.0, 8192, 2.0, 12);
      wait(var_0);
      waittillframeend;

      if(isDefined(self._doppler) && isDefined(self._doppler.enabled) && !level.chopper_audio.enabled) {
        break;
      }
    }
  }
}

mm_add_submix_oneshot(var_0, var_1, var_2, var_3) {
  maps\_audio_mix_manager::mm_add_submix(var_0, var_1);
  wait(var_2);
  maps\_audio_mix_manager::mm_clear_submix(var_0, var_3);
}

filter_oneshot(var_0, var_1) {
  maps\_audio::aud_set_filter(var_0, 0);
  wait(var_1);
  maps\_audio::aud_clear_filter(0);
}

aud_fade_eq_hold(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  aud_fade_eq(var_0, var_3, var_4, var_5, var_6, var_7, var_8, 1, var_9);
  wait(var_0 + var_1);
  aud_fade_eq(var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0, var_9);
}

aud_fade_eq(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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
  thread audx_filter_fade_internal(var_0, var_7, var_8);
}

audx_filter_fade_internal(var_0, var_1, var_2) {
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
    maps\_audio::aud_set_occlusion(var_2);
  }
}

tick_doppler(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(isDefined(self) && !isDefined(self._doppler)) {
    self._doppler = spawnStruct();
  }
  if(!isDefined(level.snd_dopplerscript)) {
    level.snd_dopplerscript = 1;
  }
  if(!isDefined(level.snd_dopplerscriptdebug)) {
    level.snd_dopplerscriptdebug = 0;
  }
  if(level.snd_dopplerscript == 1) {
    if(isDefined(self) && !isDefined(self._doppler.enabled)) {
      self._doppler.enabled = 1;
    }
    if(isDefined(self) && isDefined(self._doppler) && isDefined(self._doppler.enabled) && self._doppler.enabled) {
      if(isDefined(self) && !isDefined(self._doppler._id_562C)) {
        self._doppler._id_562C = self.origin;
      }
      self._doppler.velocity = (self.origin - self._doppler._id_562C) / 2;

      if(isDefined(self) && isDefined(self._doppler.velocity)) {
        var_8 = vectorNormalize(level.player.origin - self.origin);
        var_9 = vectordot(self._doppler.velocity, var_8);
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
        if(level.snd_dopplerscriptdebug == 1) {
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

        if(level.snd_dopplerscriptdebug == 2) {}
      }

      if(isDefined(self)) {
        self._doppler._id_562C = self.origin;
      }
    }
  }
}
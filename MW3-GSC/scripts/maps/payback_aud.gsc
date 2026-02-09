/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_aud.gsc
****************************************/

main() {
  maps\_audio::_id_16F4();
  maps\_audio::_id_1735("default");
  maps\_audio::_id_156E("soft_occlusion");
  maps\_audio::_id_1740("rvn");
  _id_4ED3();
  _id_4ED4();
  _id_447D();
  _id_496E();
  _id_447F();
  _id_447E();
  _id_447C();
  maps\_audio_mix_manager::_id_1517("mix_payback_global");
  thread _id_562A();
  _id_4ED6();
}

_id_4ED3() {
  common_scripts\utility::flag_init("aud_door_slowmo_exit");
  common_scripts\utility::flag_init("aud_player_rappel");
  common_scripts\utility::flag_init("beach_music_climax");
  common_scripts\utility::flag_init("stop_beach_music");
  common_scripts\utility::flag_init("constr_sand_sweeten_done");
  common_scripts\utility::flag_init("chopper_hit_primed_now_go");
}

_id_4ED4() {
  level._id_16F5._id_55BC = 0;
  level._id_16F5._id_55BD = 1;
  level._id_16F5._id_55BE = 0;
  level._id_16F5._id_55BF = 0;
  level._id_16F5._id_55C0 = 18;
  level._id_16F5._id_55C1 = 0;
  level._id_55C3 = 0;
  level._id_16F5._id_0324 = 0;
  level._id_16F5._id_008C = 0;
  level._id_16F5._id_55C4 = 0;
  level._id_16F5._id_55C5 = [];

  for(var_0 = 0; var_0 < 4; var_0++) {
    level._id_16F5._id_55C5[var_0] = spawn("script_origin", (0, 0, 0));
  }
}

_id_447D() {
  thread _id_561B();
}

_id_496E() {
  thread _id_4988();
  level._id_16F5._id_55C6 = spawn("script_origin", (105, -1451, 540));
  level._id_16F5._id_55C6 playLoopSound("loop_iron_gate");
  level._id_16F5._id_55C7 = spawn("script_origin", (1401, -4909, 542));
  level._id_16F5._id_55C7 playLoopSound("loop_iron_gate");
  maps\_audio_dynamic_ambi::_id_149F("pybk_sstorm_flare", (232, -3823, 484), "sandstorm_flare", 1800, 1.0);
  maps\_audio_dynamic_ambi::_id_149F("pybk_sstorm_flare", (1696, -11160, -20), "sandstorm_flare2", 900, 1.0);
}

_id_447F() {}

_id_447E() {
  anim._id_1E72["aud_primevo_payback_pri_targetbuilding"] = ::_id_562E;
  anim._id_1E72["aud_primevo_payback_mct_dragourfeet"] = ::_id_562E;
  anim._id_1E72["aud_primevo_payback_wrb_insane"] = ::_id_562E;
  anim._id_1E72["aud_primevo_payback_wrb_volk"] = ::_id_562E;
  anim._id_1E72["aud_primevo_payback_wrb_paris"] = ::_id_562E;
  anim._id_1E72["aud_primevo_payback_wrb_wait"] = ::_id_562E;
  anim._id_1E72["aud_primevo_payback_mct_goingtodonow"] = ::_id_562E;
  anim._id_1E72["aud_primevo_payback_pri_softenhim"] = ::_id_562E;
  anim._id_1E72["aud_warrabe_shutup"] = ::_id_55FC;
}

_id_447C() {
  maps\_audio_mix_manager::_id_1509("mix_intro_mute");
  maps\_audio_mix_manager::_id_1509("mix_payback_global");
  maps\_audio_mix_manager::_id_1509("mix_hl_scripted");
  maps\_audio_mix_manager::_id_1509("mix_intro");
  maps\_audio_mix_manager::_id_1509("mix_intro_incar");
  maps\_audio_mix_manager::_id_1509("mix_intro_chopperby");
  maps\_audio_mix_manager::_id_1509("mix_intro_gatecrash");
  maps\_audio_mix_manager::_id_1509("mix_start_compound");
  maps\_audio_mix_manager::_id_1509("mix_compound_outer");
  maps\_audio_mix_manager::_id_1509("mix_chopper_gunner");
  maps\_audio_mix_manager::_id_1509("mix_chopper_explosion");
  maps\_audio_mix_manager::_id_1509("mix_breach_mute_vo");
  maps\_audio_mix_manager::_id_1509("mix_prebreach");
  maps\_audio_mix_manager::_id_1509("mix_breach");
  maps\_audio_mix_manager::_id_1509("mix_int_interrogation");
  maps\_audio_mix_manager::_id_1509("mix_interrogation");
  maps\_audio_mix_manager::_id_1509("mix_interrogate_mask");
  maps\_audio_mix_manager::_id_1509("mix_beach");
  maps\_audio_mix_manager::_id_1509("mix_ambush_music");
  maps\_audio_mix_manager::_id_1509("mix_ambush_ambemi");
  maps\_audio_mix_manager::_id_1509("mix_ambush_veh");
  maps\_audio_mix_manager::_id_1509("mix_ambush_chopper");
  maps\_audio_mix_manager::_id_1509("mix_ambush_mayhem");
  maps\_audio_mix_manager::_id_1509("mix_ambush_kill_vo");
  maps\_audio_mix_manager::_id_1509("mix_chase");
  maps\_audio_mix_manager::_id_1509("mix_constr_ext");
  maps\_audio_mix_manager::_id_1509("mix_construction_wallfall");
  maps\_audio_mix_manager::_id_1509("mix_constr_int");
  maps\_audio_mix_manager::_id_1509("mix_construction_roof");
  maps\_audio_mix_manager::_id_1509("mix_chopper_crash");
  maps\_audio_mix_manager::_id_1509("mix_chopper_static");
  maps\_audio_mix_manager::_id_1509("mix_construction_rappel");
  maps\_audio_mix_manager::_id_1509("mix_construction_crash");
  maps\_audio_mix_manager::_id_1509("mix_construction_chopper_debris");
  maps\_audio_mix_manager::_id_1509("mix_sandstorm");
  maps\_audio_mix_manager::_id_1509("mix_sandstorm_market_tear");
  maps\_audio_mix_manager::_id_1509("mix_sandstorm_watertower_fall");
  maps\_audio_mix_manager::_id_1509("mix_rescue");
  maps\_audio_mix_manager::_id_1509("mix_escape");
  maps\_audio_mix_manager::_id_1509("mix_escape_jeepenter");
  maps\_audio_mix_manager::_id_1509("mix_escape_jeep");
  maps\_audio_mix_manager::_id_1509("mix_pybk_outro");
  maps\_audio_mix_manager::_id_1509("kill_vo_mix");
}

_id_4ED6() {
  maps\_audio::_id_174C(::_id_55C8);
  maps\_audio::_id_174C(::_id_448C);
}

_id_55C8(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "default":
      thread _id_55CD();
      _id_55ED();
      break;
    case "start_compound":
      _id_55ED();
      break;
    case "s1_outer_compound":
      maps\_audio_zone_manager::_id_156C("zone_exterior_compound");
      _id_448B("mus_intro_trunc");
      thread _id_55E1();
      break;
    case "s1_main_compound":
      maps\_audio_zone_manager::_id_156C("zone_exterior_compound");
      break;
    case "s1_interrogation":
      maps\_audio_zone_manager::_id_156C("zone_interior_compound");
      level._id_16F5._id_55BC = 0;
      break;
    case "s2_city":
      level._id_16F5._id_55BC = 0;
      maps\_audio_zone_manager::_id_156C("zone_exterior_beach");
      _id_448B("mus_beach");
      break;
    case "s2_postambush":
      maps\_audio_zone_manager::_id_156C("zone_exterior_city");
      thread _id_5600();
      _id_448B("mus_ambush");
      level._id_16F5._id_55BC = 0;
      break;
    case "s2_construction":
      maps\_audio_zone_manager::_id_156C("zone_exterior_construction");
      level._id_16F5._id_55BC = 0;
      break;
    case "s2_rappel":
      wait 0.1;
      maps\_audio_zone_manager::_id_156C("zone_interior_construction");
      maps\_audio_music::_id_15A7("pybk_mx_construction_r");
      level._id_16F5._id_55BC = 0;
      break;
    case "s2_sandstorm":
      _id_448B("mus_sandstorm");
      level._id_16F5._id_55BC = 0;
      break;
    case "s3_rescue":
      maps\_audio_zone_manager::_id_156C("zone_exterior_crashsite");
      level._id_16F5._id_55BC = 0;
      break;
    case "s3_escape":
      maps\_audio_zone_manager::_id_156C("zone_exterior_crashsite");
      level._id_16F5._id_55BC = 0;
      thread _id_5619();
      break;
    case "s3_exfil":
      level._id_16F5._id_55BC = 0;
      break;
    case "enter_compound":
      var_3 = var_1;
      break;
    case "exit_compound":
      var_4 = var_1;
      break;
    case "trigger_city_exterior":
      break;
    case "trigger_city_interior":
      break;
    case "trigger_compound_exterior":
      break;
    case "trigger_compound_interior":
      break;
    case "trigger_construction_exterior":
      maps\_audio_zone_manager::_id_156C("zone_exterior_construction");
      break;
    case "trigger_construction_interior":
      maps\_audio_zone_manager::_id_156C("zone_interior_construction");
      break;
    case "trigger_sandstorm_exterior":
      break;
    case "trigger_sandstorm_interior":
      break;
    case "enter_city":
      var_3 = var_1;
      break;
    case "exit_city":
      var_4 = var_1;
      break;
    case "enter_construction":
      var_3 = var_1;
      break;
    case "exit_construction":
      var_4 = var_1;
      break;
    case "enter_sandstorm":
      var_3 = var_1;
      break;
    case "exit_sandstorm":
      var_4 = var_1;
      break;
    case "intro_black_begin":
      thread _id_55CF();
      break;
    case "player_slamzoom_prime":
      level._id_16F5._id_55C9 = spawn("script_origin", (0, 0, 0));
      level._id_16F5._id_55C9 thread maps\_audio::_id_170B("intro_jeep_player");
      break;
    case "player_slamzoom":
      wait 0.05;
      thread _id_55CE();
      level.player playSound("player_slamzoom");
      var_5 = level._id_16F5._id_55C9 maps\_audio::_id_170D("intro_jeep_player");
      thread _id_562D("mix_intro_incar", 0.25, 8, 0.25);
      level._id_16F5._id_55C9 playSound("intro_jeep_player");
      thread maps\_audio::_id_1783(level._id_16F5._id_55C9);
      break;
    case "intro_hummer_ride":
      _id_448B("mus_intro");
      break;
    case "intro_civies_run_by":
      thread _id_55D1(var_1);
      break;
    case "s1_chopper_by":
      thread _id_55D2();
      break;
    case "start_lfe_loop":
      break;
    case "s1_chopper_missiles":
      thread _id_55D3();
      break;
    case "intro_rockets_hit":
      if(!level._id_16F5._id_55BE) {
        thread _id_55BE();
        level._id_16F5._id_55BE = 1;
        thread _id_562D("mix_hl_scripted", 0.05, 0.5, 1);
        thread common_scripts\utility::play_sound_in_space("pybk_chopper_missile_hit_1", (-1555, 1516, 235));
        wait 0.3;
        thread common_scripts\utility::play_sound_in_space("pybk_chopper_missile_hit_2", (-1555, 1516, 235));
        wait 0.6;
        thread common_scripts\utility::play_sound_in_space("pybk_chopper_missile_hit_3", (-1555, 1516, 235));
        wait 1;
        thread common_scripts\utility::play_sound_in_space("pybk_chopper_missile_hit_4", (-1555, 1516, 235));
        wait 0.7;
        thread common_scripts\utility::play_sound_in_space("pybk_chopper_missile_hit_5", (-1555, 1516, 235));
      }

      break;
    case "missile_fired":
      break;
    case "aud_gatecrash_mix":
      thread _id_55D4();
      thread _id_55E1();
      maps\_audio_zone_manager::_id_156C("zone_exterior_compound");
      break;
    case "s1_gate_crash":
      thread _id_55E7();
      break;
    case "postgate_shot_01":
      _id_448B("mus_intro_trunc");
      level.player playSound("pybk_pri_shotsweet");
      break;
    case "postgate_shot_02":
      level._id_4877 playSound("pybk_pri_shotsweet");
      break;
    case "postgate_shot_03":
      level.player playSound("pybk_pri_shotsweet");
      break;
    case "mortar_fire":
      var_6 = var_1;
      thread common_scripts\utility::play_sound_in_space("mortar_fire", var_6);
      break;
    case "mortar_incoming":
      var_6 = var_1;
      var_6 = var_6 + (0, 0, 96);
      thread _id_55E3(var_6);
      break;
    case "mortar_impact_dirt":
      var_6 = var_1;
      var_6 = var_6 + (0, 0, 48);
      thread _id_55E4(var_6);
      thread _id_55E6(var_6);
      break;
    case "mortar_impact_water":
      var_6 = var_1;
      var_6 = var_6 + (0, 0, 48);
      thread _id_55E5(var_6);
      break;
    case "player_chopper_enable":
      _id_55E8();
      break;
    case "player_chopper_disable":
      _id_55EC();
      wait 0.5;
      maps\_audio_zone_manager::_id_156C("zone_exterior_compound");
      break;
    case "player_chopper_aborted":
      wait 0.5;
      _id_008D();
      wait 0.5;
      maps\_audio_zone_manager::_id_156C("zone_exterior_compound");
      break;
    case "start_compound_music":
      _id_448B("mus_compound");
      break;
    case "compound_chopperby":
      thread _id_55EE();
      break;
    case "soap_over_balcony":
      var_7 = var_1;
      thread _id_55EF(var_7);
      break;
    case "pre_breach":
      thread _id_562D("mix_prebreach", 0.5, 2.5, 0.5);
      thread _id_55F0();
      break;
    case "breach_start":
      thread _id_55F1();
      thread _id_55F3();
      level.player playSound("db_sub_drop_slo_01");
      level.player playSound("db_impact_hit_01");
      break;
    case "breach_end":
      common_scripts\utility::flag_set("aud_door_slowmo_exit");
      break;
    case "gasmask_on_player":
      _id_55F9();
      break;
    case "mix_interrogation":
      _id_55F5();
      thread _id_55F2();
      break;
    case "gasmask_off_player":
      _id_55FA();
      break;
    case "gas_can_popped":
      var_8 = spawn("script_origin", (3808, 4608, 448));
      var_9 = (4032, 4784, 418);
      wait 0.8;
      var_8 playSound("pybk_gas_can", "sounddone");
      var_8 moveto(var_9, 0.5);
      var_8 waittill("sounddone");
      var_8 delete();
      break;
    case "city_pre_ambush":
      thread _id_55FD();
      break;
    case "play_rpg_explode":
      thread _id_5628(var_1);
      break;
    case "start_rpg_listener":
      thread _id_5626();
      break;
    case "city_ambush_01_sniper":
      var_10 = var_1;
      thread common_scripts\utility::play_sound_in_space("pybk_weap_sniper_fire_3d", var_10);
      thread _id_562D("mix_ambush_kill_vo", 0.05, 3, 1);
      maps\_audio_mix_manager::_id_1517("mix_ambush_ambemi", 0.05);
      maps\_audio_mix_manager::_id_1517("mix_ambush_veh", 0.05);
      thread _id_562D("mix_ambush_music", 0.25, 4, 0.25);
      wait 0.5;
      maps\_audio_music::_id_15A8(0.1);
      maps\_audio_music::_id_15A7("pybk_mx_ambushhit");
      wait 1.5;
      thread common_scripts\utility::play_sound_in_space("pybk_ambush_debris", (2736, 2160, 560));
      break;
    case "city_ambush_02_bullet":
      var_11 = var_1;
      var_11 thread maps\_utility::play_sound_on_tag("bullet_large_flesh", "j_head");
      break;
    case "city_ambush_03_chopper":
      maps\_audio_mix_manager::_id_1520("mix_ambush_veh", 5);
      level.chopper scalepitch(1.0, 5.0);
      break;
    case "city_ambush_04_mayhem":
      maps\_audio_mix_manager::_id_1520("mix_ambush_ambemi", 3);
      thread common_scripts\utility::play_sound_in_space("pybk_ambush_left", (2608, 2112, 600));
      thread common_scripts\utility::play_sound_in_space("pybk_ambush_right", (2704, 2112, 600));
      wait 0.5;
      _id_448B("mus_ambush");
      level._id_16F5._id_55BC = 1;
      level.chopper playSound("ambush_chopper_away");
      break;
    case "city_car_roll":
      thread _id_5601(var_1);
      break;
    case "city_car_explosion":
      var_12 = var_1;
      var_12 playSound("car_explode");
      break;
    case "siren_wail_1":
      break;
    case "siren_wail_2":
      break;
    case "stop_ambush_music":
      if(level._id_16F5._id_55BC) {
        level._id_16F5._id_55BC = 0;
        maps\_audio_music::_id_15A8(9);
      }

      break;
    case "wall_collapse":
      var_13 = var_1;
      thread _id_5602(var_13);
      break;
    case "scaffolding_collapse":
      thread common_scripts\utility::play_sound_in_space("shot_wood_by_3d", (-608, 176, 992));
      break;
    case "studwall_collapse":
      wait 0.35;
      common_scripts\utility::play_sound_in_space("pybk_studs_and_barrels", var_1 + (0, 0, 64));
      break;
    case "aud_crate_falls":
      thread _id_5605();
      break;
    case "chopper_prime":
      thread _id_560E();
      break;
    case "chopper_play_static":
      thread _id_560F();
      break;
    case "chopper_hit_by_rpg":
      thread _id_5606();
      break;
    case "chopper_crash":
      break;
    case "rappel_npc":
      var_14 = var_1;
      wait 1.333;
      var_14 playSound("pybk_rappel_npc");
      break;
    case "rappel_player":
      level._id_55CA scalepitch(0.707107, 15.0);
      _id_5612();
      break;
    case "sandstorm_start":
      thread _id_5614();
      break;
    case "sandstorm_light":
      break;
    case "sandstorm_medium":
      maps\_audio_zone_manager::_id_156C("zone_exterior_city_sandstorm_light");
      maps\_audio::aud_send_msg("sandstorm_transition_v01");
      break;
    case "sandstorm_hard":
      break;
    case "sandstorm_blackout":
      break;
    case "sandstorm_extreme":
      break;
    case "sandstorm_transition_v01":
      thread _id_5604();
      level.player playSound("pybk_sandstorm_wave_v01");
      level.player playSound("pybk_sandstorm_wave_v01_rears");
      break;
    case "sandstorm_transition_v02":
      common_scripts\utility::flag_set("constr_sand_sweeten_done");
      level.player playSound("pybk_sandstorm_wave_v02");
      level.player playSound("pybk_sandstorm_wave_v02_rears");
      break;
    case "sandstorm_aftermath":
      maps\_audio_zone_manager::_id_156C("zone_exterior_city_sandstorm_light");
      break;
    case "sandstorm_none":
      maps\_audio_zone_manager::_id_156C("zone_exterior_city");
      break;
    case "construction_topfloor":
      break;
    case "sandstorm_market_tear":
      thread _id_5613(var_1);
      break;
    case "sandstorm_watertower_fall":
      var_15 = var_1;
      thread _id_562D("mix_sandstorm_watertower_fall", 2, 4, 1.25);
      var_15 common_scripts\utility::play_sound_in_space("pybk_watertower_fall", (-475, -4036, 660));
      break;
    case "sandstorm_shanty_enter":
      if(level._id_16F5._id_55CB == 0) {
        maps\_audio_zone_manager::_id_156C("zone_interior_sandstorm");
      }
      break;
    case "sandstorm_shanty_exit":
      break;
    case "flare_audio_start":
      var_16 = var_1;
      level._id_16F5._id_55CC = spawn("script_origin", var_16);
      level._id_16F5._id_55CC playSound("road_flare_start", "sounddone");
      thread maps\_audio::_id_1783(level._id_16F5._id_55CC);
      maps\_audio_dynamic_ambi::_id_149F("pybk_sstorm_flare", var_16, "sandstorm_flare", 900, 1.0);
      break;
    case "roof_tear":
      if(level._id_16F5._id_55CB == 0) {
        level._id_16F5._id_55CB = 1;
        wait 3;
      }

      break;
    case "payback_scaffolding_collapse":
      thread _id_5618(var_1);
      break;
    case "mus_rescue_start_nikolai_music":
      break;
    case "mus_rescue_music_day_saved":
      break;
    case "set_pre_rescue_mix":
      level.player setchannelvolume("weapon_mid", 0, 0);
      break;
    case "begin_npc_weapon_audio_hack":
      var_17 = getaiarray("allies");
      var_18 = getaiarray("axis");

      for(var_19 = 0; var_19 < var_17.size; var_19++) {
        thread _id_561C(var_17[var_19]);
      }
      for(var_19 = 0; var_19 < var_18.size; var_19++) {
        thread _id_561D(var_18[var_19]);
      }
      break;
    case "nikolai_pickup":
      thread _id_562D("mix_nikolai_pickup", 0.3, 5, 1);
      thread _id_561A();
      break;
    case "soap_hood_slide":
      thread _id_561F(var_1);
      break;
    case "outro_slide_start":
      thread _id_562D("mix_rescue_slide", 1.25, 5.5, 1);
      thread _id_5620();
      break;
    case "outro_player_in_jeep":
      maps\_audio_zone_manager::_id_156C("zone_exterior_escjeep");
      thread _id_5621();
      thread _id_562D("mix_escape_jeepenter", 0.15, 1.5, 0.15);
      break;
    case "magic_bullet_fire":
      thread _id_561E(var_1);
      break;
    default:
      maps\_audio::_id_177E("payback_aud_msg_handler() unhandled message: " + var_0);
      var_2 = 0;
      break;
  }

  return var_2;
}

_id_448B(var_0, var_1) {
  thread _id_448C(var_0, var_1);
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
    case "mus_intro_trunc":
      maps\_audio_music::_id_15A7("pybk_mx_intro_compound");
      break;
    case "mus_compound":
      if(level._id_16F5._id_55BD) {
        level._id_16F5._id_55BC = 0;
        maps\_audio_music::_id_15A7("pybk_mx_compound");
      }

      break;
    case "mus_door_breached":
      maps\_audio_music::_id_15A8(0.25);
      break;
    case "mus_beach":
      thread _id_008F();
      break;
    case "mus_beach_vol_up":
      break;
    case "mus_ambush":
      maps\_audio_music::_id_15A7("pybk_mx_ambush");
      break;
    case "mus_construction":
      maps\_audio_music::_id_15A7("pybk_mx_construction");
      break;
    case "mus_start_chopper_stinger":
      maps\_audio_music::_id_15A8(0.5);
      break;
    case "mus_rappel":
      maps\_audio_music::_id_15A8(10);
      break;
    case "mus_sandstorm":
      maps\_audio_music::_id_15A8(10);
      break;
    case "mus_nikolai":
      thread _id_5619();
      break;
    case "mus_rescue_start_finale_music":
      thread _id_5622();
      break;
    default:
      maps\_audio::_id_177E("music_msg_handler() unhandled message: " + var_0);
      var_2 = 0;
      break;
  }

  return var_2;
}

_id_55CD() {
  maps\_audio_mix_manager::_id_1517("mix_intro_mute", 0.0);
}

_id_55CE() {
  maps\_audio_mix_manager::_id_1520("mix_intro_mute", 1.0);
}

_id_55CF() {
  wait 0.05;
  waittillframeend;
  level._id_16F5._id_55D0 = spawn("script_origin", (0, 0, 0));
  level._id_16F5._id_55D0 thread maps\_audio::_id_170B("pybk_mx_intro");
  wait 1.25;
  var_0 = level._id_16F5._id_55D0 maps\_audio::_id_170D("pybk_mx_intro");
  wait 1;
  level._id_16F5._id_55D0 playSound("pybk_mx_intro", "sounddone");
  thread maps\_audio::_id_1783(level._id_16F5._id_55D0);
}

_id_55D1(var_0) {
  wait 2;
  var_0 playSound("shot_walla_african_v01");
}

_id_55D2() {
  thread _id_562D("mix_intro_chopperby", 3.0, 6.0, 6.0);
  level.chopper playSound("intro_heli_flyby");
}

_id_55BE() {
  wait 0.1;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playSound("pybk_intro_lfe", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_55D3() {
  level.chopper playSound("pybk_chopper_missile");
}

_id_55D4() {
  wait 8;
  thread _id_562D("mix_intro_gatecrash", 0.25, 2, 0.25);
}

_id_55D5() {
  wait 6.35;
  level._id_4877 playSound("jeep_player_shift");
  wait 10.832;
  level._id_16F5._id_55D6 = spawn("script_origin", (0, 0, 0));
  level._id_16F5._id_55D6 playSound("intro_jeep_player_end", "sounddone");
  thread maps\_audio::_id_1783(level._id_16F5._id_55D6);
  level._id_16F5._id_55D7 = spawn("script_origin", (0, 0, 0));
  level._id_16F5._id_55D7 playSound("jeep_player_skid", "sounddone");
  thread maps\_audio::_id_1783(level._id_16F5._id_55D7);
  wait 11.783;
  level.player playSound("jeep_player_skid_end");
  level.player playSound("pybk_gate_crash_02");
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playSound("pybk_chopper_down_lfe", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
  level._id_55D8 delete();
  level._id_55D9 delete();
}

_id_55DA() {
  level._id_55DB = gettime();
  var_0 = 0.2511;
  var_1 = 0.5011;
  var_2 = 1.29684;
  var_3 = 1.0;
  var_4 = 4.0;
  var_5 = 0.5;
  wait 0.25;
  level._id_55DC playLoopSound("jeep_throttle");
  level._id_55DD playLoopSound("jeep_idle");
  wait 0.05;
  waittillframeend;
  level._id_55DC setpitch(var_3);
  level._id_55DD setpitch(var_3);
  level._id_55DC setvolume(0.001);
  level._id_55DD setvolume(0.001);
  wait 0.05;
  waittillframeend;
  level._id_55DC setpitch(var_2, var_4);
  level._id_55DD setpitch(var_2, var_4);
  level._id_55DC setvolume(var_1, var_4);
  level._id_55DD setvolume(var_0, var_4);
  wait(var_4);
  waittillframeend;
  level._id_55DC setpitch(var_3, var_5);
  level._id_55DD setpitch(var_3, var_5);
  level._id_55DC setvolume(var_0, 0.125);
  level._id_55DD setvolume(var_1, 0.25);
  wait(var_5);
  waittillframeend;
  level._id_55DC setpitch(var_2, var_4);
  level._id_55DD setpitch(var_2, var_4);
  level._id_55DC setvolume(var_1, 0.25);
  level._id_55DD setvolume(var_0, 0.125);
  wait(var_4);
  waittillframeend;
  level._id_55DC setpitch(var_3, var_5);
  level._id_55DD setpitch(var_3, var_5);
  level._id_55DC setvolume(var_0, 0.125);
  level._id_55DD setvolume(var_1, 0.25);
  wait(var_5);
  waittillframeend;
  level._id_55DC setpitch(var_2, var_4);
  level._id_55DD setpitch(var_2, var_4);
  level._id_55DC setvolume(var_1, 0.25);
  level._id_55DD setvolume(var_0, 0.125);
  wait 2.05;
  level._id_55DE playSound("jeep_splash_shore");
  wait 1.95;
  waittillframeend;
  level._id_55DC setpitch(var_3, var_5);
  level._id_55DD setpitch(var_3, var_5);
  level._id_55DC setvolume(var_0, 0.125);
  level._id_55DD setvolume(var_1, 0.25);
  wait(var_5);
  waittillframeend;
  var_6 = 2.0;
  var_7 = 1.41421;
  level._id_55DC setpitch(var_7, var_6);
  level._id_55DD setpitch(var_7, var_6);
  level._id_55DC setvolume(var_1, 0.25);
  level._id_55DD setvolume(var_0, 0.125);
  wait(var_6);
  waittillframeend;
  var_8 = 1.0;
  var_9 = 1.0;
  level._id_55DC setpitch(var_9, var_8);
  level._id_55DD setpitch(var_9, var_8);
  level._id_55DC setvolume(var_0, 0.125);
  level._id_55DD setvolume(var_1, 0.25);
  wait(var_8);
  waittillframeend;
  thread maps\_audio::_id_15D7("jeep_skid_v01", level._id_55DC, "oneshot");
  var_10 = 0.707107;
  var_11 = 0.1;
  level._id_55DC setpitch(var_10, var_11);
  level._id_55DD setpitch(var_10, var_11);
  level._id_55DC setvolume(var_0, 0.125);
  level._id_55DD setvolume(var_1, 0.25);
  wait(var_11);
  waittillframeend;
  var_12 = 10.75;
  var_13 = var_7;
  level._id_55DC setpitch(var_13, var_12);
  level._id_55DD setpitch(var_13, var_12);
  level._id_55DC setvolume(var_1, 0.25);
  level._id_55DD setvolume(var_0, 0.125);
  wait(var_12);
  waittillframeend;
  level._id_55DE playSound("pybk_gate_crash_01");
  var_14 = 3.0;
  level._id_55DC scalepitch(0.5, var_14);
  level._id_55DD scalepitch(0.5, var_14);
  level._id_55DC scalevolume(0.01, var_14);
  level._id_55DD scalevolume(0.063, var_14);
  wait(var_14);
  waittillframeend;
  level._id_55DC stoploopsound();
  level._id_55DD stoploopsound();
  wait 0.05;
  waittillframeend;
  level._id_55DC delete();
  level._id_55DD delete();
}

_id_55DF() {
  if(isDefined(level._id_55E0)) {
    level._id_55E0 stoploopsound();
  }
  if(isDefined(level._id_55DE)) {
    level._id_55DE stoploopsound();
  }
  level._id_55D8 = spawn("script_origin", level.player.origin);
  level._id_55D8 linkto(level.player);
  level._id_55D9 = spawn("script_origin", level.player.origin);
  level._id_55D9 linkto(level.player);
  var_0 = (72, 0, 48);
  level._id_55DC = spawn("script_origin", level._id_55DE.origin);
  level._id_55DC linkto(level._id_55DE, "tag_origin", var_0, (0, 0, 0));
  level._id_55DD = spawn("script_origin", level._id_55DE.origin);
  level._id_55DD linkto(level._id_55DE, "tag_origin", var_0, (0, 0, 0));
  level._id_55D8 thread _id_55D5();
  level._id_55DC thread _id_55DA();
}

_id_55E1() {
  wait 8;
  var_0 = (1296, 4544, 427);
  var_1 = ["payback_mrc3_mortarteams", "payback_mrc3_destroy", "payback_mrc3_mainhouse", "payback_mrc3_gunemplacements", "payback_mrc3_reinforcements", "payback_mrc1_alltroops"];
  var_2 = 2.5;
  var_3 = 25;
  var_4 = 1;
  var_5 = 0;

  while(!common_scripts\utility::flag("upper_compound_upper_buildings_hotzone")) {
    if(var_5 < 6) {
      level thread common_scripts\utility::play_sound_in_space(var_1[var_5], var_0);
      var_5++;
    }

    for(var_6 = 0; var_6 < var_2; var_6 = var_6 + var_4) {
      _id_55E2();
      wait(var_4);
    }

    for(var_6 = 0; var_6 < randomint(var_3); var_6 = var_6 + var_4) {
      _id_55E2();
      wait(var_4);
    }
  }

  level.player seteqlerp(0, 1);
}

_id_55E2() {
  level.player seteq("bulletwhizby", 1, 0, "bell", 3, 2000 + randomint(5000), 4.5);
  level.player seteq("bulletimpact", 1, 0, "bell", 2, 1500 + randomint(3000), 4.5);
  level.player seteqlerp(1, 1);
}

_id_55E3(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playSound("mortar_incoming", var_0);
  wait 3;
  waittillframeend;
  var_1 delete();
}

_id_55E4(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playSound("mortar_explosion_dirt", var_0);
  wait 8;
  waittillframeend;
  var_1 delete();
}

_id_55E5(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playSound("mortar_explosion_water", var_0);
  wait 8;
  waittillframeend;
  var_1 delete();
}

_id_55E6(var_0) {
  var_1 = 800;
  var_2 = distance(level.player.origin, var_0);

  if(var_2 < var_1) {
    var_3 = clamp(var_2 / var_1, 0.0, 1.0);
    maps\_audio_mix_manager::_id_1519("mix_compound_mortar", "mix_compound_outer", "mortar_blend", 0, 0.5);
    maps\_audio_mix_manager::_id_151A("mortar_blend", var_3, 0.5);
    wait 0.6;
    maps\_audio_mix_manager::_id_151A("mortar_blend", 1, 1);
  }
}

_id_55E7() {
  wait 3;
  var_0 = spawn("script_origin", (64, 5632, 900));
  var_0 playSound("pybk_attack_siren");
  wait 30;
  var_0 delete();
}

_id_55E8() {
  wait 1.5;
  level.player playSound("player_chopper_enter");
  level._id_16F5._id_55E9 = maps\_audio_zone_manager::_id_1578();
  maps\_audio_zone_manager::_id_156C("zone_interior_chopper");
  level._id_16F5._id_008C = 1;
  var_0 = level.player getcurrentweapon();

  if(var_0 == "remote_chopper_gunner" || var_0 == level._id_55EA) {
    wait 0.05;
    thread maps\_audio::_id_1739();
    wait 0.05;
    waittillframeend;

    if(!isDefined(level._id_55EB)) {
      level._id_55EB = spawn("script_origin", level.player.origin);
      level._id_55EB linkto(level.player);
      maps\_audio::_id_1788(level._id_55EB, "pybk_chopper_interior", 1.0, 1.0, 1);
    }

    maps\_audio_mix_manager::_id_1517("mix_chopper_gunner");
    thread _id_008E();
  }
}

_id_55EC() {
  wait 0.1;
  level.player playSound("player_slamzoom");

  if(isDefined(level._id_55EB)) {
    maps\_audio::_id_15F3(level._id_55EB, 0.5);
  }
  if(isDefined(level._id_16F5._id_55E9)) {
    maps\_audio_zone_manager::_id_156C(level._id_16F5._id_55E9);
  }
  maps\_audio_dynamic_ambi::_id_14A9("pybk_chopperpings", 0.1);
  wait 0.5;
  waittillframeend;

  if(isDefined(level._id_55EB)) {
    level._id_55EB delete();
  }
  thread maps\_audio::_id_173A();
  maps\_audio_mix_manager::_id_1520("mix_chopper_gunner");
  level._id_16F5._id_008C = 0;
}

_id_008D() {
  wait 0.1;

  if(isDefined(level._id_55EB)) {
    maps\_audio::_id_15F3(level._id_55EB, 0.5);
  }
  if(isDefined(level._id_16F5._id_55E9)) {
    maps\_audio_zone_manager::_id_156C(level._id_16F5._id_55E9);
  }
  maps\_audio_dynamic_ambi::_id_14A9("pybk_chopperpings", 0.1);
  wait 0.5;
  waittillframeend;

  if(isDefined(level._id_55EB)) {
    level._id_55EB delete();
  }
  thread maps\_audio::_id_173A();
  maps\_audio_mix_manager::_id_1520("mix_chopper_gunner");
  level._id_16F5._id_008C = 0;
}

_id_008E() {
  while(level._id_16F5._id_008C) {
    var_0 = getaiarray("axis");

    if(var_0.size < 5) {
      if(isDefined(level._id_16F5._id_55E9)) {
        maps\_audio_zone_manager::_id_156C(level._id_16F5._id_55E9);
      }
      maps\_audio_dynamic_ambi::_id_14A9("pybk_chopperpings", 0.5);
    }

    wait 2;
  }
}

_id_55ED() {}

_id_55EE() {
  wait 0.3;
  level.chopper playSound("comp_heli_flyby");
}

_id_55EF(var_0) {
  wait 1.25;
  var_0 thread maps\_audio::_id_170B("pybk_deathfall");
  wait 1.5;
  var_0 playSound("pybk_deathfall");
}

_id_4988() {
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("music", 0);
  soundsettimescalefactor("local", 0.25);
  soundsettimescalefactor("local3", 0.25);
  soundsettimescalefactor("weapon", 0.15);
  soundsettimescalefactor("grondo2d", 0);
  soundsettimescalefactor("bulletimpact", 0);
  soundsettimescalefactor("bulletflesh1", 0);
  soundsettimescalefactor("bulletflesh2", 0);
  soundsettimescalefactor("bulletwhizby", 0);
}

_id_55F0() {
  var_0 = spawn("script_origin", level.player.origin);
  wait 0.6;
  var_0 playSound("detpack_plant_arming", "sounddone");
  thread maps\_audio::_id_1783(var_0);
}

_id_55F1() {
  thread maps\_audio::_id_17B1(::_id_55F8, ::_id_55F7);
  thread maps\_audio_mix_manager::_id_1517("mix_breach");
  thread maps\_audio_zone_manager::_id_156C("zone_breach_slowmo", 0.05);
  var_0 = spawn("script_origin", level.player.origin);
  var_1 = spawn("script_origin", level.player.origin);
  var_0 playLoopSound("surreal_hi_lp");
  var_1 playLoopSound("surreal_lo_lp");
  common_scripts\utility::flag_wait("aud_door_slowmo_exit");
  thread maps\_audio::_id_17B3();
  thread _id_55FB();
  thread maps\_audio_mix_manager::_id_1520("mix_breach");
  var_0 playSound("db_fast_forward");
  wait 0.5;
  thread maps\_audio_zone_manager::_id_156C("zone_interrogation_room");
  wait 0.05;
  var_0 scalevolume(0.0, 0.1);
  wait 0.05;
  var_1 scalevolume(0.0, 0.1);
  wait 0.05;
  var_1 delete();
  wait 0.2;
  var_0 delete();
}

_id_55F2() {
  wait 4;
  thread common_scripts\utility::play_sound_in_space("evt_boxes_tumble02", (3856, 4464, 445));
  thread common_scripts\utility::play_sound_in_space("evt_boxes_tumble01", (3856, 4560, 445));
}

_id_55F3() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(var_2.model != "body_warlord") {
      thread _id_55F4(var_2);
    }
  }
}

_id_55F4(var_0) {
  while(!common_scripts\utility::flag("aud_door_slowmo_exit")) {
    var_0 waittill("death");
    wait 0.65;

    if(common_scripts\utility::flag("aud_door_slowmo_exit")) {
      wait 0.5;

      if(isDefined(var_0)) {
        var_0 playSound("pybk_body_breach");
      }
    } else if(isDefined(var_0)) {
      var_0 playSound("pybk_body_slomo");
    }
    break;
  }
}

_id_55F5() {
  thread _id_562D("mix_interrogation", 0.5, 40, 0.5);
}

_id_49D6(var_0, var_1, var_2, var_3, var_4) {
  level.player playSound("slowmo_bullet_whoosh");
}

_id_55F6(var_0) {
  switch (var_0) {
    default:
      break;
  }
}

_id_55F7(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_16F5._id_49D9)) {
    level._id_16F5._id_49D9 = 0;
  }
  var_5 = gettime();

  if(var_5 - level._id_16F5._id_49D9 > 200) {
    level._id_16F5._id_49D9 = var_5;
    level.player playSound("db_bullet_whoosh");
  }
}

_id_55F8(var_0) {
  switch (var_0) {
    default:
      break;
  }
}

_id_55F9() {
  level.player playSound("pybk_mask_on_plr");
}

_id_55FA() {
  level.player playSound("pybk_mask_off_plr");
}

_id_55FB() {
  maps\_audio_music::_id_15A7("pybk_mx_kruger");
}

_id_55FC(var_0, var_1) {
  thread _id_562D("kill_vo_mix", 0.05, 2, 0.05);
}

_id_008F() {
  wait 4;
  maps\_audio_music::_id_15A7("pybk_mx_beach");
}

_id_55FD() {
  wait 6;
  _id_562D("mix_pre_ambush", 1.5, 0.5, 0.5);
  wait 0.5;
  common_scripts\utility::flag_set("stop_beach_music");
}

_id_5600() {
  while(!common_scripts\utility::flag("end_streets_combat")) {
    _id_55E2();
    wait 1;
  }

  level.player seteqlerp(0, 1);
}

_id_5601(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_2 = spawn("script_origin", var_0.origin);
  var_2 linkto(var_0);
  thread _id_562D("mix_streets_car", 0.5, 4, 0.5);
  var_0 playLoopSound("pybk_car_roll_down");
  wait 3.5;
  var_0 stoploopsound();
  var_1 stoploopsound();
  wait 0.25;
  var_1 delete();
  var_2 delete();
}

_id_5602(var_0) {
  var_1 = var_0 + (0, 0, 96);
  wait 0.5;
  thread _id_562D("mix_construction_wallfall", 1, 3.5, 0.5);
  level._id_16F5._id_5603 = spawn("script_origin", (0, 0, 0));
  level._id_16F5._id_5603 playSound("pybk_wallfall_quad", "sounddone");
  thread maps\_audio::_id_1783(level._id_16F5._id_5603);
  wait 2.152;
  thread common_scripts\utility::play_sound_in_space("pybk_wallfall_lfe_dip", var_0);
  wait 1.323;
  thread common_scripts\utility::play_sound_in_space("pybk_wallfall_hit01", var_0);
  wait 0.746;
  thread common_scripts\utility::play_sound_in_space("pybk_wallfall_hit02", var_0);
  _id_448B("mus_construction");
}

_id_5604() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 scalevolume(0.1, 0);
  wait 0.01;
  var_0 scalevolume(1, 2);
  var_0 playLoopSound("pybk_construct_quad_f");
  common_scripts\utility::flag_wait("constr_sand_sweeten_done");
  maps\_audio::_id_15F3(var_0, 2.0);
  thread _id_560E();
}

_id_5605() {
  thread common_scripts\utility::play_sound_in_space("pybk_crate_falls", (-720, -896, 992));
  thread common_scripts\utility::play_sound_in_space("pybk_crate_falls_2", (-720, -896, 992));
}

_id_5606() {
  thread _id_562D("mix_construction_chopper_rpg_blast", 0.1, 0.75, 0.25);
  maps\_audio_mix_manager::_id_1517("mix_chopper_crash", 0.5);

  if(isDefined(level._id_55CA)) {
    if(isDefined(level._id_55CA._id_5607) && isDefined(level._id_55CA._id_5607.enabled)) {
      level._id_55CA._id_5607.enabled = 0;
    }
    level._id_55CA stoploopsound();
    level._id_5608 = spawn("script_origin", level._id_55CA.origin);
    level._id_5608 linkto(level._id_55CA);
    level._id_5609 = spawn("script_origin", level._id_55CA.origin);
    level._id_5609 linkto(level._id_55CA);
    level._id_560A = spawn("script_origin", level._id_55CA.origin);
    level._id_560A linkto(level._id_55CA);
    level._id_560B = spawn("script_origin", level._id_55CA.origin);
    level._id_560B linkto(level._id_55CA);
    level._id_560C = spawn("script_origin", level._id_55CA.origin);
    level._id_560C linkto(level._id_55CA);
    level._id_560D = spawn("script_origin", level._id_55CA.origin);
    level._id_560D linkto(level._id_55CA);
    maps\_audio_music::_id_15A8();
    level._id_5608 playSound("mortar_explosion_dirt");
    common_scripts\utility::flag_set("chopper_hit_primed_now_go");
    level._id_560B playLoopSound("chopper_main_damaged");
    level._id_5608 playSound("pybk_chopper_hit");
    wait 4;
    level._id_560C playSound("pybk_chopper_down2");
    level._id_560D scalevolume(0.1, 0);
    wait 4;
    level._id_560D playLoopSound("pybk_chopper_down_hold");
    wait 0.1;
    level._id_560D scalevolume(1.0, 3.0);
    wait 7.5;
    level._id_560D scalevolume(0, 2.0);
    wait 2.1;
    level._id_560D delete();
  } else {}
}

_id_560E() {
  level._id_560A = spawn("script_origin", level._id_55CA.origin);
  level._id_560A linkto(level._id_55CA);
  level._id_560A maps\_audio::_id_170B("pybk_chopper_down");
  common_scripts\utility::flag_wait("chopper_hit_primed_now_go");
  level._id_560A playSound("pybk_chopper_down");
}

_id_560F() {
  var_0 = level.player getcurrentweapon();

  if(var_0 == "remote_chopper_gunner" || var_0 == level._id_55EA) {
    level.player playSound("pybk_chopper_static");
    thread _id_562D("mix_chopper_static", 0.15, 4, 1);
  }
}

_id_5610() {
  wait 7;
  level._id_560C scalevolume(0, 4);
  wait 1.5;
  level._id_560C delete();
}

_id_5611() {
  wait 5;
  level._id_560B scalevolume(0, 4);
  wait 1.5;
  level._id_560B delete();
}

_id_5612() {
  maps\_audio::aud_send_msg("sandstorm_transition_v02");
  level._id_5609 playSound("pybk_chopper_rappel2");
  wait 0.5;
  maps\_audio_mix_manager::_id_1520("mix_chopper_crash", 0.5);
  thread _id_562D("mix_construction_rappel", 0.15, 3, 1.5);
  level.player playSound("pybk_rappel_player");
  thread _id_5611();
  thread _id_5610();
  level._id_5608 scalepitch(0.707107, 3.0);
  thread maps\_audio::_id_1783(level._id_5608);
  wait 1;
  level._id_5608 playSound("pybk_chopper_end");
  wait 9;
  level._id_5608 delete();
  level._id_5609 delete();
}

_id_5613(var_0) {
  thread _id_562D("mix_sandstorm_market_tear", 1.0, 2.8, 1.0);
  var_1 = spawn("script_origin", var_0 gettagorigin("J_Default3_vtx_210_"));
  var_1 linkto(var_0, "J_Default3_vtx_210_", (0, 0, 0), (0, 0, 0));
  var_1 playSound("pybk_market_tear", "sounddone");
  var_1 waittill("sounddone");
  var_1 delete();
}

_id_5614() {
  thread _id_5615();
  thread _id_5616();
  thread _id_5617();
}

_id_5615() {
  var_0 = 3;
  var_1 = 7;
  var_2 = ["zone_sandstorm_01", "zone_sandstorm_02", "zone_sandstorm_03", "zone_sandstorm_04"];
  var_3 = randomint(var_2.size);
  maps\_audio_zone_manager::_id_156C(var_2[var_3]);

  while(!common_scripts\utility::flag("sandstorm_section_end")) {
    var_4 = randomint(var_2.size);

    if(var_4 == var_3) {
      var_4 = var_4 + 1;

      if(var_4 == var_2.size) {
        var_4 = 0;
      }
    }

    if(randomint(10) < 4) {
      wait(randomintrange(3, 7));

      if(common_scripts\utility::flag("sandstorm_section_end")) {
        break;
      }

      maps\_audio_zone_manager::_id_156C(var_2[var_4], 3);
      wait(randomintrange(3, 7));

      if(common_scripts\utility::flag("sandstorm_section_end")) {
        break;
      }

      maps\_audio_zone_manager::_id_156C(var_2[var_3], 3);
    } else {
      wait(randomintrange(var_0, var_1));

      if(common_scripts\utility::flag("sandstorm_section_end")) {
        break;
      }

      wait(randomintrange(var_0, var_1));

      if(common_scripts\utility::flag("sandstorm_section_end")) {
        break;
      }

      wait(randomintrange(var_0, var_1));

      if(common_scripts\utility::flag("sandstorm_section_end")) {
        break;
      }

      wait(randomintrange(var_0, var_1));

      if(common_scripts\utility::flag("sandstorm_section_end")) {
        break;
      }

      wait(randomintrange(var_0, var_1));

      if(common_scripts\utility::flag("sandstorm_section_end")) {
        break;
      }

      maps\_audio_zone_manager::_id_156C(var_2[var_4], 6);
    }

    var_3 = var_4;
  }

  wait 5;
  maps\_audio::_id_172B();
  maps\_audio_zone_manager::_id_156C("zone_exterior_crashsite", 5);
}

_id_5616() {
  var_0 = 5;
  var_1 = 15;
  var_2 = ["filter_sandstorm_01", "filter_sandstorm_02", "filter_sandstorm_03", "filter_sandstorm_04", "filter_sandstorm_05"];
  var_3 = randomint(var_2.size);
  maps\_audio::_id_1570(var_2[var_3]);

  while(!common_scripts\utility::flag("sandstorm_section_end")) {
    var_4 = randomint(var_2.size);

    if(var_4 == var_3) {
      var_4 = var_4 + 1;

      if(var_4 == var_2.size) {
        var_4 = 0;
      }
    }

    wait(randomintrange(var_0, var_1));
    maps\_audio::_id_1570(var_2[var_4]);
    var_3 = var_4;
  }
}

_id_5617() {
  var_0 = 0.5;
  var_1 = 0.1;
  var_2 = 6;
  var_3 = 3;
  var_4 = 2;
  var_5 = 0.5;
  var_6 = 15;
  var_7 = 6;

  while(!common_scripts\utility::flag("sandstorm_section_end")) {
    var_8 = spawn("script_origin", level.player.origin);
    var_8 playLoopSound("pybk_sandstorm_rumble");
    var_9 = randomfloatrange(var_1, var_0 + 1);
    var_8 setvolume(0);
    wait 0.1;
    var_10 = randomfloatrange(var_3, var_2 + 1);
    var_8 scalevolume(var_9, var_10);
    wait(var_10);
    wait(randomfloatrange(var_5, var_4 + 1));
    var_11 = randomfloatrange(var_3, var_2 + 1);
    var_8 scalevolume(0, var_11);
    wait(var_11 + 0.02);
    var_8 stoploopsound();
    wait 0.1;
    var_8 delete();
    wait(randomfloatrange(var_7, var_6 + 1));
  }
}

_id_5618(var_0) {
  var_1 = spawn("script_origin", (1167, -4717, 542));
  thread _id_562D("mix_sandstorm_scaffold_collapse", 0.2, 1.7, 0.5);
  level.player playSound("pybk_scaffolding_whip");
  wait 1;
  var_1 playSound("pybk_scaffolding_collapse", "sounddone");
  var_1 playSound("pybk_scaffolding_collapse");
  var_1 moveto((1074, -4275, 550), 1.5);
  var_1 waittill("sounddone");
  var_1 delete();
}

_id_5619() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("pybk_mx_rescue_intro", "sounddone");
  thread maps\_audio::_id_1783(var_0);
  wait 3.466;
  maps\_audio_music::_id_15A7("pybk_mx_rescue");
}

_id_561A() {
  var_0 = spawn("script_origin", level.player.origin);
  wait 0.45;
  var_0 playSound("evt_nikolai_pickup", "sounddone");
  thread maps\_audio::_id_1783(var_0);
}

_id_561B() {
  maps\_audio_dynamic_ambi::_id_149F("pybk_chopper_fire", (-224, -8160, 464), "damb_chopper_fire", 5000, 1.0);
}

_id_561C(var_0) {
  while(isalive(var_0)) {
    var_0 waittill("shooting");
    var_0 maps\_utility::play_sound_on_entity("pybk_weap_m4carbine_fire_npc");
  }
}

_id_561D(var_0) {
  while(isalive(var_0)) {
    var_0 waittill("shooting");
    thread _id_561E(var_0.origin);
  }
}

_id_561E(var_0) {
  if(level._id_16F5._id_55C1 < level._id_16F5._id_55C0) {
    level._id_16F5._id_55C1 = level._id_16F5._id_55C1 + 1;
    var_1 = spawn("script_origin", var_0);
    var_1 playSound("pybk_weap_ak47_fire_npc", "sounddone");
    var_1 waittill("sounddone");
    var_1 delete();
    level._id_16F5._id_55C1 = level._id_16F5._id_55C1 - 1;
  }
}

_id_561F(var_0) {
  level._id_54E0 playSound("soap_car_jump");
}

_id_5620() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playSound("evt_downhill_slide", "sounddone");
  thread maps\_audio::_id_1783(var_0);
}

_id_5621() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playSound("outro_jeep_depart", "sounddone");
  thread maps\_audio::_id_1783(var_0);
  wait 8;
  thread _id_562D("mix_pybk_outro", 8, 20, 0.25);
}

_id_5622() {
  wait 1;
  maps\_audio_music::_id_15A7("pybk_mx_escape");
}

_id_5623() {
  if(isDefined(level.chopper)) {
    level.chopper stoploopsound();
  }
  if(!isDefined(level._id_55CA)) {
    level._id_55CA = spawn("script_origin", level.chopper.origin);
    level._id_55CA linkto(level.chopper, "tag_origin", (0, 0, 64), (0, 0, 0));
  } else {
    level._id_55CA unlink();
    level._id_55CA moveto(level.chopper.origin, 0.05);
    level._id_55CA linkto(level.chopper, "tag_flare", (0, 0, 0), (0, 0, 0));
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

_id_5625() {
  if(!isDefined(level.chopper)) {
    if(isDefined(level._id_55CA._id_5607) && isDefined(level._id_55CA._id_5607.enabled)) {
      level._id_55CA._id_5607.enabled = 0;
    }
    waittillframeend;
    var_0 = 15.0;
    level._id_55CA scalevolume(0.0, var_0);
    level._id_55CA scalepitch(0.793701, var_0);
    wait(var_0);
    waittillframeend;
    level._id_55CA delete();
    level._id_55CA = undefined;
  } else {}
}

_id_5626() {
  var_0 = getaiarray("axis");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.weapon == "rpg") {
      thread _id_5627(var_2);
    }
  }
}

_id_5627(var_0) {
  while(isalive(var_0)) {
    var_0 waittill("missile_fire", var_1, var_2);
    _id_5628(var_1);
  }
}

_id_5628(var_0) {
  var_0 waittill("death");

  if(isDefined(var_0)) {
    common_scripts\utility::play_sound_in_space("pybk_rocket_explosion", var_0.origin);
  }
}

_id_5629() {
  self endon("death");
  self playSound("pybk_rpg");
  var_0 = 0.05;

  for(;;) {
    if(isDefined(self)) {
      _id_562B(var_0, 80, 0.707107, 2.0, 1.0, 6144, 3.0, 4);
    } else {
      break;
    }
    wait(var_0);
    waittillframeend;
  }
}

_id_562A() {
  var_0 = 0.05;

  for(;;) {
    var_1 = getEntArray("rocket", "classname");
    var_2 = 0;

    foreach(var_4 in var_1) {
      var_2++;
      var_5 = "UNDEFINED";

      if(isDefined(var_4.model)) {
        var_5 = var_4.model;
      }
      if(isDefined(var_4.model) && var_4.model == "projectile_tag") {
        continue;
      }
      if(!isDefined(var_4._id_5607)) {
        var_4 thread _id_5629();
      }
    }

    wait(var_0);
    waittillframeend;
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
          self scalepitch(var_21, var_0);
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

        if(level._id_0114 == 2) {
          iprintln("tick_doppler():: " + var_10 + " pitch: " + var_21);
        }
      }

      if(isDefined(self)) {
        self._id_5607._id_562C = self.origin;
      }
    }
  }
}

_id_562D(var_0, var_1, var_2, var_3) {
  maps\_audio_mix_manager::_id_1517(var_0, var_1);
  wait(var_2);
  maps\_audio_mix_manager::_id_1520(var_0, var_3);
}

_id_562E(var_0, var_1) {
  var_2 = getsubstr(var_0, 12);
  level._id_16F5._id_55C5[level._id_16F5._id_55C4] thread maps\_audio::_id_170B(var_2);
  wait 0.5;
  level._id_16F5._id_55C4 = level._id_16F5._id_55C4 + 1;

  if(level._id_16F5._id_55C4 == level._id_16F5._id_55C5.size) {
    level._id_16F5._id_55C4 = 0;
  }
}
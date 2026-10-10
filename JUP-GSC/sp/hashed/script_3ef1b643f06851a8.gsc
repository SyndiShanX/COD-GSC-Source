/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3ef1b643f06851a8.gsc
*************************************************/

#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace namespace_13c788fbb37cd80e;

function main() {
  level flag_init("cctv_zoom_lp_playing");
}

function function_9c034a6965fbe730() {
  level.player setsoundsubmix("sp_jup_surg_level_fadein");
  level waittill("audio_level_fade_in");
  level.player clearsoundsubmix("sp_jup_surg_level_fadein", 1.5);
}

function function_22a5aeaa16ae2674() {
  level.player playSound("scn_jup_surge_0010_igc_intro_lr");
  level.player setsoundsubmix("sp_jup_surg_intro_igc");
  wait 12;
  level.player clearsoundsubmix("sp_jup_surg_intro_igc", 0.1);
}

function function_e678c1b9d8a8282f() {
  level.player setsoundsubmix("sp_jup_surg_park_mix", 0.25);
  level waittill("audio_stop_park_submix");
  level.player clearsoundsubmix("sp_jup_surg_park_mix", 0.25);
}

function function_8cda09587d813459() {
  thread play_loopsound_in_space("surge_walla_two_women_talking_cafe", (-463, 271, 80));
  thread play_loopsound_in_space("surge_walla_woman_child_fence", (-576, -178, 63));
  thread play_loopsound_in_space("surge_walla_man_woman_coworkers", (-203, 367, 80));
  thread play_loopsound_in_space("surge_walla_two_women_talking_inlaws", (79, 510, 80));
  thread play_loopsound_in_space("surge_walla_two_men_one_woman_talking", (148, 650, 63));
  thread play_loopsound_in_space("surge_walla_man_woman_merch_vendor", (324, -60, 63));
  thread play_loopsound_in_space("surge_walla_carousel_crowd", (261, 334, 80));
  thread play_loopsound_in_space("surge_walla_man_woman_street_performer", (619, 87, 80));
}

function function_a73e8acab82e7f57() {
  level endon("cctv_enabled");
  level thread function_df0cdbc9398425e3();
  var_2ef371bd964a1690 = (640, -2368, 30);
  wait randomfloatrange(5, 7);
  level.player play_sound_in_space("amb_emt_surge_boat_horn_dist", var_2ef371bd964a1690);
  level waittill("audio_boat_interval_start");
  wait randomfloatrange(15, 20);

  while(true) {
    level.player play_sound_in_space("amb_emt_surge_boat_horn_dist", var_2ef371bd964a1690);
    wait randomfloatrange(30, 40);
  }
}

function function_df0cdbc9398425e3() {
  level endon("cctv_enabled");
  level.player endon("death");
  var_6a7107ab3f9b4515 = (214, 728, 187);

  while(true) {
    wait randomfloatrange(8, 18);
    play_sound_in_space("amb_elm_surg_street_traffic_park_distant", var_6a7107ab3f9b4515);
  }
}

function function_a91261b17ab0252f() {
  thread play_loop_sound_on_tag("amb_emt_surge_dog_pant_lp", "j_head");
  level waittill("audio_dog_interact_started");
  self notify("stop sound" + "amb_emt_surge_dog_pant_lp");
  wait 3;
  thread play_loop_sound_on_tag("amb_emt_surge_dog_pant_lp", "j_head");
  level waittill("audio_dog_setup_end");
  self notify("stop sound" + "amb_emt_surge_dog_pant_lp");
}

function function_13f19307aff9756d() {
  wait 3;
  flag_set("flg_park_hacker_phone_ringing");
  level.ai_hacker play_sound_on_tag("jup_surge_0150_park_call_enter_civ_cellphone_ring_01", "j_wrist_ri");
}

function function_d4b414285f705106() {
  level notify("audio_stop_park_submix");
  var_d4b414285f705106 = level.player spawn_script_origin();
  level.player playSound("scn_jup_surge_computer_room_typing");
  var_d4b414285f705106 playLoopSound("amb_surge_int_computer_room_lr");
  level.player setsoundsubmix("surg_ghost_office", 0.25);
  level waittill("cctv_enabled");
  var_d4b414285f705106 stoploopsound("amb_surge_int_computer_room_lr");
  level.player clearsoundsubmix("surg_ghost_office", 0.25);
  waitframe();
  var_d4b414285f705106 delete();
}

function function_ad005b37ad2132c0() {
  level endon("cctv_end");
  level endon("death");
  var_215c491624c432aa = level.player spawn_script_origin();

  while(true) {
    current_input = level.player getleftsticky();
    var_69827f897cf8a221 = abs(current_input);
    pitch = math::factor_value(1, 1.05, var_69827f897cf8a221);

    if(current_input > 0 && !flag("CCTV_rewind_active") && level.current_cam.fov < 70) {
      var_215c491624c432aa stoploopsound("surg_cctv_zoom_out");
      var_215c491624c432aa playLoopSound("surg_cctv_zoom_in");
      var_215c491624c432aa scalepitch(pitch, 1);
      level flag_set("cctv_zoom_lp_playing");

      if(level.current_cam.fov == 20) {
        var_215c491624c432aa stoploopsound("surg_cctv_zoom_in");
        var_215c491624c432aa scalepitch(1, 0.1);
      } else {
        waitframe();
      }
    }

    if(current_input < 0 && !flag("CCTV_rewind_active") && level.current_cam.fov > 20) {
      var_215c491624c432aa stoploopsound("surg_cctv_zoom_in");
      var_215c491624c432aa playLoopSound("surg_cctv_zoom_out");
      var_215c491624c432aa scalepitch(pitch, 1);
      level flag_set("cctv_zoom_lp_playing");

      if(level.current_cam.fov == 70) {
        var_215c491624c432aa stoploopsound("surg_cctv_zoom_out");
        var_215c491624c432aa scalepitch(1, 0.1);
      } else {
        waitframe();
      }
    }

    if(current_input == 0 && !flag("CCTV_rewind_active") && flag("cctv_zoom_lp_playing")) {
      var_215c491624c432aa stoploopsound("surg_cctv_zoom_in");
      var_215c491624c432aa stoploopsound("surg_cctv_zoom_out");
      var_215c491624c432aa scalepitch(1, 0.1);
    }

    if(current_input != 0 && !flag("CCTV_rewind_active") && flag("cctv_zoom_lp_playing")) {
      waitframe();
      continue;
    }

    waitframe();
  }
}

function function_8a715a3ebbf310bf() {
  soundsettimescalefactorfromtable("cctv_rr_ff");
  level flag_wait("cctv_end");
  soundsettimescalefactorfromtable("default");
}

function function_7af3cb8cecca9321() {
  level endon("cctv_end");
  level endon("death");
  var_742c22a6b29fc4c = level.player spawn_script_origin();
  thread function_366bf1ca89007283();

  while(true) {
    if(flag("CCTV_rewind_active")) {
      var_742c22a6b29fc4c playLoopSound("surg_cctv_rewind_ff_lr");
      level flag_set("cctv_rr_ff_lp_playing");
    }

    if(flag("CCTV_rewind_active") && flag("cctv_rr_ff_lp_playing")) {
      waitframe();
      continue;
    }

    var_742c22a6b29fc4c stoploopsound("surg_cctv_rewind_ff_lr");
    flag_clear("cctv_rr_ff_lp_playing");
    level notify("audio_stop_cctv_vehicle_pitching");
    waitframe();
  }
}

function function_366bf1ca89007283() {
  level endon("cctv_end");
  level endon("death");
  var_8db027531de50841 = level.player spawn_script_origin();

  while(true) {
    level waittill("rewind_scene_paused");
    var_8db027531de50841 playLoopSound("amb_surge_int_cctv_pause_lr");
    level.player setsoundsubmix("surg_cctv_pause_mix");
    level waittill_any("rewind_scene_reverse", "rewind_scene_play", "rewind_scene_increase");
    var_8db027531de50841 stoploopsound("amb_surge_int_cctv_pause_lr");
    level.player clearsoundsubmix("surg_cctv_pause_mix");
    waitframe();
  }
}

function function_4fdee4e4c1a6ce64() {
  if(!isDefined(self.car_sfx)) {
    self.car_sfx = spawn("script_origin", self.origin);
    self.car_sfx linkTo(self);
    self.car_sfx playLoopSound("evt_surg_streets_car_idle_lp");
    self.car_sfx thread cctv_vehicle_pitching();
  }
}

function function_e45ac94927cc7a6d() {
  if(!isDefined(self.truck_sfx)) {
    self.truck_sfx = spawn("script_origin", self.origin);
    self.truck_sfx linkTo(self);
    self.truck_sfx playLoopSound("evt_surg_streets_truck_idle_lp");
    self.truck_sfx thread cctv_vehicle_pitching();
  }
}

function function_bf738267dd44f324() {
  if(!isDefined(self.bus_sfx)) {
    self.bus_sfx = spawn("script_origin", self.origin);
    self.bus_sfx linkTo(self);
    self.bus_sfx playLoopSound("evt_surg_streets_bus_idle_lp");
    self.bus_sfx thread cctv_vehicle_pitching();
  }
}

function cctv_vehicle_pitching() {
  level endon("cctv_end");
  level endon("death");

  while(true) {
    level flag_wait("cctv_rr_ff_lp_playing");
    self scalepitch(4, 0.1);
    level waittill("audio_stop_cctv_vehicle_pitching");
    self scalepitch(1, 0.1);
  }
}

function function_44b25cf8de40e4bb() {
  play_sound_in_space("evt_surg_streets_gate_open", (4472, 6025, 40));
}

function function_8fa4383f3a35c772() {
  wait 2.5;
  level.player playSound("amb_evt_rat_scurry");
}

function function_5c7a5076b09507de() {
  var_947987ad2a170c59 = spawn_script_origin((5091, 6594, 59));
  var_947987ad2a170c59 playLoopSound("evt_surg_tunnel_vehicle1_prelude_lp");
  flag_wait("flg_streets_tunnel_veh_1_start");
  level.player setsoundsubmix("surg_tunnel_veh_prelude_fadeout", 2);
  wait 2.5;
  var_947987ad2a170c59 stopsounds();
  waitframe();
  var_947987ad2a170c59 delete();
  level.player clearsoundsubmix("surg_tunnel_veh_prelude_fadeout");
}

function function_7f2cde5f148ca05c() {
  self playSound("evt_surg_tunnel_vehicle1_driveup");
  wait 2;
  self playLoopSound("evt_surg_tunnel_vehicle1_idle");
  thread tunnel_vehicle_mute();
  level flag_set("tunnel_vehicles_idles_on");
}

function function_e5597b017c10114d() {
  self playSound("evt_surg_tunnel_vehicle2_driveup");
  wait 2;
  self playLoopSound("evt_surg_tunnel_vehicle2_idle");
}

function function_e44c25dd889b0abe() {
  self playSound("evt_surg_tunnel_vehicle3_driveup");
  wait 3;
  self playLoopSound("evt_surg_tunnel_vehicle3_idle");
}

function function_adbe6b0424057259(var_c46a67c186f533a2, var_c46a66c186f5316f) {
  if(!flag("tunnel_vehicles_idles_on")) {
    var_c46a67c186f533a2 playLoopSound("evt_surg_tunnel_vehicle1_idle");
    var_c46a66c186f5316f playLoopSound("evt_surg_tunnel_vehicle2_idle");
    thread tunnel_vehicle_mute();
    return;
  }

  return;
}

function tunnel_vehicle_mute() {
  trigger_wait_targetname("notify_tunnel_vehicle_mute");
  level.player setsoundsubmix("surg_hideout_veh_mute", 7);
  flag_wait("flg_hideout_cqc_stairwell_enemies_dead");
  level.player clearsoundsubmix("surg_hideout_veh_mute");
}

function function_99852192d1d4e1ee() {
  var_54552d9895fc2b3e = level.player spawn_script_origin();
  waitframe();
  level.player playSound("scn_jup_surge_0300_hideout_showdown_igc_lr");
  level.player setsoundsubmix("sp_jup_surg_ghost_cctv_room", 0.25);
  var_54552d9895fc2b3e playLoopSound("amb_surge_int_computer_room_lr");
  wait 9.1;
  var_54552d9895fc2b3e stoploopsound("amb_surge_int_computer_room_lr");
  level.player clearsoundsubmix("sp_jup_surg_ghost_cctv_room", 0.25);
  waitframe();
  var_54552d9895fc2b3e delete();
}

function function_3aca5a4f5765dcfd() {
  play_sound_in_space("evt_surge_overground_train_by_engine", (4040, 5518, 244));
}

function function_fefb488747b65ddd() {
  level flag_set("flg_audio_chunnel_amb_duck_started");
  level.player setsoundsubmix("surg_hideout_amb_mute", 0.25);
  level waittill("audio_chunnel_post_cctv_amb_duck");
  wait 6.8;
  level.player clearsoundsubmix("surg_hideout_amb_mute", 0.25);
}

function function_b61e1ad458f02511() {
  level waittill("audio_chunnel_intro_igc_started");

  if(level flag("flg_audio_chunnel_amb_duck_started")) {
    return;
  }

  level flag_set("flg_audio_chunnel_amb_duck_started");
  level.player setsoundsubmix("surg_hideout_amb_mute", 0);
  wait 9;
  level.player clearsoundsubmix("surg_hideout_amb_mute", 0.25);
}

function function_cfaed15dafc0d676() {
  level.player setsoundsubmix("sp_jup_surg_hideout_bink", 0.5);
  level flag_wait("scene_0340_cctv_done");
  level.player clearsoundsubmix("sp_jup_surg_hideout_bink", 0.25);
}

function function_1cf5c48c5eadd2eb() {
  level.player playSound("scn_jup_surge_0400_chunnel_intro_lr");
}

function function_976cfc1a562856ac() {
  level.player setsoundsubmix("surg_intro_train_driveby", 0);
  level waittill("audio_intro_train_mute_clear");
  level.player clearsoundsubmix("surg_intro_train_driveby", 0.5);
}

function function_8b2295f5369ece6d() {
  level.player setsoundsubmix("surg_vents_train_mute", 0);
  level.player setsoundsubmix("sp_jup_surg_chunnel_vents_mix", 3);
  level waittill("audio_vent_train_mute_clear");
  level.player clearsoundsubmix("surg_vents_train_mute", 0.5);
  level.player clearsoundsubmix("sp_jup_surg_chunnel_vents_mix", 0.5);
}

function function_2c3b2fadd33defc1() {
  wait 2.5;
  level.player playSound("evt_surge_first_train_by_amb_tease_lr");
}

function function_8f124209027f31a8() {
  wait 0.35;
  thread play_sound_in_space("evt_ob_obj_acv_button_press", (-51486, 58176, 92));
}

function function_9dc9264d67991d91() {
  var_bf546cf0eefbea62 = spawn_script_origin((-51526, 58265, 150));
  var_bf546cf0eefbea62 scalevolume(1, 0);
  var_bf546cf0eefbea62 playSound("evt_surge_rolling_door_move");
  wait 3.5;
  var_bf546cf0eefbea62 scalevolume(0, 0.2);
  thread play_sound_in_space("evt_surge_rolling_door_close_stop", var_bf546cf0eefbea62.origin);
}

function function_9dc9234d679916f8() {
  var_bf546bf0eefbe82f = spawn_script_origin((-51628, 58431, 150));
  var_bf546bf0eefbe82f scalevolume(1, 0);
  var_bf546bf0eefbe82f playSound("evt_surge_rolling_door_move");
  wait 3.5;
  var_bf546bf0eefbe82f scalevolume(0, 0.2);
  thread play_sound_in_space("evt_surge_rolling_door_close_stop", var_bf546bf0eefbe82f.origin);
}

function function_a1d01f5ecd7c3c5e() {
  utility::flag_wait("flg_crossover_intro_juggernaut_spawned");
  level.player playSound("mus_jup_surg_d156_juggernaut_stinger");
  level.player setsoundsubmix("sp_jup_surg_jugg_stinger_sfx");
  level.player setsoundsubmix("sp_jup_surg_jugg_stinger_mus");
}

function function_700df35a6a18c420() {
  level.player setsoundsubmix("sp_jup_surg_chunnel_finale_mix", 0);
  level waittill("audio_makarov_train_start");
  level.player clearsoundsubmix("sp_jup_surg_chunnel_finale_mix", 0);
}

function function_33f9e1adaa635e0e() {
  level endon("audio_stop_shellshock_bomb_beep");
  thread function_e445846fa54ee9f1();

  while(true) {
    if(!flag("flg_start_third_fight")) {
      wait 1.1;
      thread play_sound_in_space("evt_surge_interior_bomb_beep_exterior", (-54921, 61914, 80));
      continue;
    }

    wait 0.28;
    thread play_sound_in_space("evt_surge_interior_bomb_beep_exterior", (-54921, 61914, 80));
  }
}

function function_e445846fa54ee9f1() {
  var_9dc188eecaa22ac9 = spawn_script_origin((-54888, 61910, 22));
  var_20a393beabd2736b = spawn_script_origin((-54957, 61891, 22));
  var_4962eabab273cb88 = spawn_script_origin((-54054, 60331, 494));
  var_9dc188eecaa22ac9 thread play_loop_sound_on_entity("evt_surge_bomb_exterior_fan_01_lp");
  var_20a393beabd2736b thread play_loop_sound_on_entity("evt_surge_bomb_exterior_fan_01_lp");
  var_4962eabab273cb88 thread play_loop_sound_on_entity("evt_surge_bomb_exterior_fan_02_lp");
  level waittill("audio_bomb_stopped");
  wait 0.25;
  var_9dc188eecaa22ac9 thread stop_loop_sound_on_entity("evt_surge_bomb_exterior_fan_01_lp");
  var_20a393beabd2736b thread stop_loop_sound_on_entity("evt_surge_bomb_exterior_fan_01_lp");
  var_4962eabab273cb88 thread stop_loop_sound_on_entity("evt_surge_bomb_exterior_fan_02_lp");
  wait 0.25;
  var_9dc188eecaa22ac9 delete();
  var_20a393beabd2736b delete();
  var_4962eabab273cb88 delete();
}

function function_a81df2b9565dd07d() {
  level.player playSound("evt_jup_surge_bomb_disarm_pre_shots");
}

function function_77dfe79e4f33c2f3() {
  level.player setsoundsubmix("sp_jup_surg_soap_death_shellshock", 0);
  level notify("audio_stop_shellshock_bomb_beep");
  thread function_8a3b1f447498bb90();
  wait 5;
  level.player clearsoundsubmix("sp_jup_surg_soap_death_shellshock", 2);
}

function function_8a3b1f447498bb90() {
  level.player endon("death");
  level.var_4c5d8ac7eaad0c1e = spawn_script_origin((-54921, 61914, 80));
  level.var_4c5d8ac7eaad0c1e thread function_7e77ce5358006d5a();

  while(!flag("flg_bomb_defused")) {
    wait 0.18;
    level.var_4c5d8ac7eaad0c1e playSound("evt_surge_interior_bomb_beep_exterior_fast");
  }

  level notify("audio_bomb_stopped");
  play_sound_in_space("evt_surge_bomb_power_down", (-54921, 61914, 80));
  level.var_4c5d8ac7eaad0c1e delete();
}

function function_7e77ce5358006d5a() {
  level flag_wait("flg_outro_enter_complete");
  wait 4;
  self scalepitch(2, 40);
}

function function_6ec4e95f104d9902() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 thread scene::function_8207074e79f22926(level.player, "audio_shellshock_duck_start", "plr");
  var_13f0578e0f5cbd02 thread scene::function_8207074e79f22926(level.player, "audio_shellshock_duck_end", "plr");
  thread function_9b1c1183b8a83ecf();
  level.player playSound("scn_jup_surge_0900_igc_defuse_scene_lr");
  level.player waittill("audio_shellshock_duck_start");
  level.player setsoundsubmix("sp_jup_surg_finale_shellshock_duck", 1);
  level.player waittill("audio_shellshock_duck_end");
  level.player clearsoundsubmix("sp_jup_surg_finale_shellshock_duck", 2);
}

function function_9b1c1183b8a83ecf() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 thread scene::function_8207074e79f22926(level.player, "audio_mute_gunshot_start", "soap");
  var_13f0578e0f5cbd02 thread scene::function_8207074e79f22926(level.player, "audio_mute_gunshot_end", "soap");
  level.player waittill("audio_mute_gunshot_start");
  level.player setsoundsubmix("sp_jup_surg_makarov_shot_duck", 1);
  level.player waittill("audio_mute_gunshot_end");
  level.player clearsoundsubmix("sp_jup_surg_makarov_shot_duck");
}

function function_168481f8f9fc75() {
  level.player playSound("scn_jup_surge_1000_igc_outro_scene_lr");
  thread function_3d3d837762af2425();
}

function function_cee9774af8aa6e9() {
  level.player setsoundsubmix("sp_jup_surge_bomb_train_fade");
  waitframe();
  level.player clearsoundsubmix("sp_jup_surge_bomb_train_fade");
}

function function_3d3d837762af2425() {
  level.player setsoundsubmix("surg_final_train_by_duck");
  wait 23;
  level.player playSound("scn_jup_surge_1000_igc_outro_final_train_lr");
}

function function_449926a23c0a742b() {
  level.player setsoundsubmix("sp_jup_surg_level_fade_out", 2);
}
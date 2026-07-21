/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_trucks.gsc
************************************************/

proxywar_trucks_precache() {
  precachemodel("hat_accessory_gas_mask_01");
  precachemodel("hat_gasmask");
  precachemodel("veh8_civ_lnd_decho_static_dst_black");
  precachemodel("proxywar_decho_dst_black");
}

proxywar_trucks_flags() {
  scripts\engine\utility::flag_init("approaching_rear_exit_door");
  scripts\engine\utility::flag_init("reached_rear_exit_door");
  scripts\engine\utility::flag_init("start_truck_convoy");
  scripts\engine\utility::flag_init("driver_ready");
  scripts\engine\utility::flag_init("driver_occupied");
  scripts\engine\utility::flag_init("player_entered_truck");
  scripts\engine\utility::flag_init("reached_warehouse_rear_exterior");
  scripts\engine\utility::flag_init("suicide_truck_hit");
  scripts\engine\utility::flag_init("suicide_truck_scene_start");
  scripts\engine\utility::flag_init("done_call_shotgun");
  scripts\engine\utility::flag_init("proxywar_lights_end_explosion");
}

proxywar_trucks_hints() {}

proxywar_trucks_objectives() {}

proxywar_trucks_spawnfuncs() {}

proxywar_trucks_init() {
  level.truck1 = getEnt("truck1", "targetname");
  level.truck1.animname = "truck1";
  level.truck1 scripts\common\anim::setanimtree();
  level.truck1 scripts\common\vehicle::godon();
  level.truck1.headlights = getEntArray("suv_a_head_lights", "targetname");

  foreach(var_1 in level.truck1.headlights)
  var_1 linkTo(level.truck1);

  level.truck1.taillights = getEntArray("suv_a_tail_lights", "targetname");

  foreach(var_1 in level.truck1.taillights)
  var_1 linkTo(level.truck1);

  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_a_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_a_tail_lights");
  level.truck2 = getEnt("truck2", "targetname");
  level.truck2.animname = "truck2";
  level.truck2 scripts\common\anim::setanimtree();
  level.truck2 scripts\common\vehicle::godon();
  level.truck2.headlights = getEntArray("suv_b_head_lights", "targetname");

  foreach(var_1 in level.truck2.headlights)
  var_1 linkTo(level.truck2);

  level.truck2.taillights = getEntArray("suv_b_tail_lights", "targetname");

  foreach(var_1 in level.truck2.taillights)
  var_1 linkTo(level.truck2);

  level.truck2.interiorlight = getEnt("suv_b_dome_light", "targetname");
  level.truck2.interiorlight linkTo(level.truck2);
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_tail_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_dome_light");
  level.truck3 = getEnt("truck3", "targetname");
  level.truck3.animname = "truck3";
  level.truck3 scripts\common\anim::setanimtree();
  level.truck3 scripts\common\vehicle::godon();
  level.truck3.tarp = getEnt("truck3_tarp", "targetname");
  level.truck3.tarp linkTo(level.truck3, "tag_body_animate");
  level.truck3.clip = getEnt("truck3_clip", "targetname");
  level.truck3.clip linkTo(level.truck3);
  level.truck3.headlights = getEntArray("truck_head_lights", "targetname");

  foreach(var_1 in level.truck3.headlights)
  var_1 linkTo(level.truck3);

  level.truck3.taillights = getEntArray("truck_tail_lights", "targetname");

  foreach(var_1 in level.truck3.taillights)
  var_1 linkTo(level.truck3);

  level.truck3.interiorlight = getEnt("truck_dome_light", "targetname");
  level.truck3.interiorlight linkTo(level.truck3);
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_tail_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_dome_light");
  level.truck3.barrels = getEntArray("truck3_chemical_barrels", "targetname");

  foreach(var_14 in level.truck3.barrels)
  var_14 linkTo(level.truck3);
}

trucks_convoy_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams(0);
  scripts\engine\sp\utility::set_start_location("start_trucks_convoy", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  scripts\engine\utility::flag_set("finished_swabbing_vo");
  level thread alpha1_wait_for_player();
}

trucks_convoy_main() {
  scripts\engine\sp\utility::autosave_by_name("trucks_convoy");
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_exit_trucks", "targetname").origin, &"PROXYWAR/OBJ_SECURE_DSC", &"PROXYWAR/OBJ_SECURE_LBL");
  level.player clearsoundsubmix("sp_npc_steps_down", 10.0);
  setthreatbias("axis", "allies", 10000);
  level.player.ignoreme = 1;
  level.player scripts\sp\player::set_player_ignore_random_bullet_damage(1);
  var_0 = scripts\engine\utility::getStruct("convoy_ref", "targetname");
  scripts\engine\utility::flag_wait("approaching_rear_exit_door");
  level.pullinref notify("end_pre_idle");
  level thread turn_trucks_on();
  level thread truck_convoy();
  scripts\engine\utility::flag_wait("driver_ready");
  var_1 = scripts\engine\utility::getStruct("enter_truck_interact", "targetname");
  var_1 thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"PROXYWAR/ENTER", 0, 800, 0);
  var_1 waittill("trigger");
  scripts\engine\utility::flag_set("player_entered_truck");
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::mus_truck_leave();
  level thread hide_names();
  level notify("kill_flashlight");
  level thread scripts\sp\maps\proxywar\proxywar_util.gsc::kill_flashlight();
  var_0 scripts\sp\player_rig::link_player_to_rig("convoy_rollout", "stand", 1, 0.5, 0, 45, 45, 15, 30, 1);

  if(scripts\engine\utility::flag("driver_occupied")) {
    scripts\engine\utility::flag_waitopen("driver_occupied");
    waitframe();
  }

  level.player scripts\engine\utility::delaycall(1.7, ::lerpfovscalefactor, 0, 1);
  level.pullinref notify("end_gate_idle");
  level.pullinref notify("end_bravo2_gate_idle");
  level thread open_facility_exit();
  var_0 thread trucks_sniper_suicide_truck();
  level.pullinref thread scripts\common\anim::anim_loop([level.alpha1, level.bravo3, level.truck3], "trucks_approach_gate_idle", "end_bravo2_gate_idle");
  var_0 thread scripts\common\anim::anim_single([level.player_rig, level.bravo1, level.bravo2, level.truck1, level.truck2], "convoy_rollout");
  level.player playSound("scn_proxy_plr_in_jeep_drive_off_lr");
  wait 18;
  level thread wait_rpg_impact();
  level.player playSound("scn_proxy_rpg_in_explodes_lr");
  level.player scripts\engine\utility::delaycall(3.2, ::playsound, "scn_proxy_rpg_shock");
  scripts\engine\utility::exploder("end_rpg");
  scripts\engine\utility::exploder("end_truck_aftermath");
  level.player enableinvulnerability();
  level waittill("slam_to_black");
  level thread scripts\sp\utility::context_melee_enable(0);
  thread scripts\sp\hud_util::fade_out(0);
}

alpha1_wait_for_player() {
  level endon("approaching_rear_exit_door");
  level.pullinref = scripts\engine\utility::getStruct("pull_in_ref", "targetname");
  level.discovergasref = scripts\engine\utility::getStruct("discover_gas_ref", "targetname");
  level.discovergasref notify("end_discover_idle");
  level.pullinref thread scripts\common\anim::anim_loop_solo(level.alpha1, "trucks_approach_gate_pre_idle", "end_pre_idle");
  scripts\engine\utility::flag_wait("finished_swabbing");
  scripts\engine\utility::flag_wait("finished_swabbing_vo");

  for(;;) {
    level.pullinref notify("end_pre_idle");
    level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wdg_nag_exit();
    level.pullinref scripts\common\anim::anim_single_solo(level.alpha1, "trucks_approach_gate_pre_idle_nag");
    level.pullinref thread scripts\common\anim::anim_loop_solo(level.alpha1, "trucks_approach_gate_pre_idle", "end_pre_idle");
    wait 12;
  }
}

turn_trucks_on() {
  wait 1;
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("suv_b_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("suv_b_tail_lights");
  wait 0.5;
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("suv_a_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("suv_a_tail_lights");
  wait 3.5;
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("truck_dome_light");
  wait 5;
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_dome_light");
  thread audio_big_truck_turn_on_idle();
  wait 3;
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("truck_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("truck_tail_lights");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_headlight_mkilo23_nolight"), level.truck3, "tag_light_front_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_headlight_mkilo23_nolight"), level.truck3, "tag_light_front_right");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_mkilo23_nolight"), level.truck3, "tag_light_back_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_mkilo23_nolight"), level.truck3, "tag_light_back_right");
  visionsetnaked("proxywar_hero", 0.5);
}

audio_big_truck_turn_on_idle() {
  thread scripts\engine\utility::play_sound_in_space("scn_proxy_truck3_startup", (-2490, 15, 271));
  level.truck3_idle = spawn("script_origin", (-2490, 15, 271));
  wait 0.35;
  level.truck3_idle thread scripts\engine\sp\utility::sound_fade_in("scn_proxy_truck3_idle", 1.0, 1.0, 1);
  scripts\engine\utility::flag_wait("player_entered_truck");
  level.truck3_idle scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);
}

truck_convoy() {
  level endon("player_entered_truck");
  var_0 = [level.alpha1, level.bravo1, level.bravo3, level.truck1, level.truck2, level.truck3];
  level.bravo2 thread bravo2_truck_convoy();
  level.pullinref scripts\common\anim::anim_single(var_0, "trucks_approach_gate");
  level.pullinref thread scripts\common\anim::anim_loop(var_0, "trucks_approach_gate_idle", "end_gate_idle");
}

bravo2_truck_convoy() {
  level.bravo1 playSound("scn_proxy_jeep1_start_in");
  level.bravo2 playSound("scn_proxy_jeep2_start_in");
  scripts\engine\utility::delaythread(7.0, ::audio_jeep1_idle);
  scripts\engine\utility::delaythread(7.0, ::audio_jeep2_idle);
  level.pullinref scripts\common\anim::anim_single_solo(self, "trucks_approach_gate");
  level.pullinref thread scripts\common\anim::anim_loop_solo(self, "trucks_approach_gate_idle", "end_bravo2_gate_idle");

  while(!scripts\engine\utility::flag("player_entered_truck")) {
    if(level.truck2 scripts\engine\math::is_point_on_right(level.player.origin)) {
      level.pullinref notify("end_bravo2_gate_idle");
      scripts\engine\utility::flag_set("driver_occupied");

      if(!scripts\engine\utility::flag("done_call_shotgun")) {
        scripts\engine\utility::flag_set("done_call_shotgun");
        level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_ts_call_shotgun();
      }

      level.pullinref scripts\common\anim::anim_single_solo(self, "trucks_approach_gate_nag");
      level.pullinref thread scripts\common\anim::anim_loop_solo(self, "trucks_approach_gate_idle", "end_bravo2_gate_idle");
      scripts\engine\utility::flag_clear("driver_occupied");
      wait 10;
    }

    waitframe();
  }
}

audio_jeep1_idle() {
  level.bravo1_idle = spawn("script_origin", level.bravo1.origin);
  level.bravo1_idle thread scripts\engine\sp\utility::sound_fade_in("scn_proxy_jeep1_idle", 1.0, 1.0, 1);
  scripts\engine\utility::flag_wait("player_entered_truck");
  level.bravo1_idle scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);
}

audio_jeep2_idle() {
  level.bravo2_idle = spawn("script_origin", level.bravo2.origin);
  level.bravo2_idle thread scripts\engine\sp\utility::sound_fade_in("scn_proxy_jeep2_idle", 1.0, 1.0, 1);
  scripts\engine\utility::flag_wait("player_entered_truck");
  level.bravo2_idle scripts\engine\sp\utility::sound_fade_and_delete(5.0, 1);
}

hide_names() {
  wait 4;

  foreach(var_1 in level.alpha_and_bravo_team) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 scripts\engine\sp\utility::name_hide();
  }
}

open_facility_exit() {
  level.leftexitgate1 = getEnt("left_exit_gate_1", "targetname");
  level.leftexitgate2 = getEnt("left_exit_gate_2", "targetname");
  level.rightexitgate1 = getEnt("right_exit_gate_1", "targetname");
  level.rightexitgate2 = getEnt("right_exit_gate_2", "targetname");
  level.leftexitgate1 thread scripts\sp\maps\proxywar\proxywar_util.gsc::move_to_point_with_angles(3.5, scripts\engine\utility::getStruct("left_exit_gate_open_1", "targetname").origin, scripts\engine\utility::getStruct("left_exit_gate_open_1", "targetname").angles, undefined, 2, 1);
  level.leftexitgate2 thread scripts\sp\maps\proxywar\proxywar_util.gsc::move_to_point_with_angles(3.5, scripts\engine\utility::getStruct("left_exit_gate_open_1", "targetname").origin, scripts\engine\utility::getStruct("left_exit_gate_open_2", "targetname").angles, undefined, 2, 1);
  level.rightexitgate1 thread scripts\sp\maps\proxywar\proxywar_util.gsc::move_to_point_with_angles(3.25, scripts\engine\utility::getStruct("right_exit_gate_open_1", "targetname").origin, scripts\engine\utility::getStruct("right_exit_gate_open_1", "targetname").angles, undefined, 2, 1);
  level.rightexitgate2 thread scripts\sp\maps\proxywar\proxywar_util.gsc::move_to_point_with_angles(3.25, scripts\engine\utility::getStruct("right_exit_gate_open_2", "targetname").origin, scripts\engine\utility::getStruct("right_exit_gate_open_2", "targetname").angles, undefined, 2, 1);
}

trucks_sniper_suicide_truck() {
  scripts\engine\utility::flag_set("suicide_truck_scene_start");
  var_0 = scripts\engine\sp\utility::spawn_anim_model("suicide_truck");
  var_0 scripts\engine\utility::delaycall(9.7, ::playsound, "scn_proxy_burning_car_in");
  thread scripts\common\anim::anim_single_solo(var_0, "convoy_rollout");
  var_0 scripts\engine\utility::delaycall(13.25, ::playsound, "scn_proxy_burning_car_impact");
  level waittill("suicide_truck_explosion");
  level.player playSound("scn_proxy_jeep1_explodes_lr");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("proxywar_lights_end_explosion");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_tail_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("tower_lights");
  scripts\engine\utility::flag_set("proxywar_lights_end_explosion");
  scripts\engine\utility::flag_set("suicide_truck_hit");
  visionsetnaked("proxywar_hero", 0.5);
}

wait_rpg_impact() {
  wait 3;
  level.player shellshock("explosion_proxywar", 5);
}

trucks_convoy_catchup() {
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_exit_trucks", "targetname").origin, &"PROXYWAR/OBJ_SECURE_DSC", &"PROXYWAR/OBJ_SECURE_LBL");
  var_0 = scripts\engine\utility::getStruct("convoy_ref", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("suicide_truck");
  var_0 scripts\common\anim::anim_last_frame_solo(level.truck1, "convoy_rollout");
  var_0 scripts\common\anim::anim_last_frame_solo(var_1, "convoy_rollout");
  scripts\engine\utility::flag_set("suicide_truck_hit");
}

trucks_stolen_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams(0);
  scripts\engine\sp\utility::set_start_location("start_trucks_retreat", scripts\engine\utility::array_combine([level.player], [level.alpha1]));

  foreach(var_1 in level.alpha_and_bravo_team) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 scripts\engine\sp\utility::name_hide();
  }

  var_3 = scripts\engine\utility::getStruct("wake_up_ref", "targetname");
  var_3 scripts\sp\player_rig::link_player_to_rig("trucks_stolen", "stand", 0, undefined, 0, 0, 0, 0, 0, 1);
  level.leftexitgate1 = getEnt("left_exit_gate_1", "targetname");
  level.leftexitgate1.origin = scripts\engine\utility::getStruct("left_exit_gate_open_1", "targetname").origin;
  level.leftexitgate2 = getEnt("left_exit_gate_2", "targetname");
  level.leftexitgate2.origin = scripts\engine\utility::getStruct("left_exit_gate_open_2", "targetname").origin;
  level.rightexitgate1 = getEnt("right_exit_gate_1", "targetname");
  level.rightexitgate1.origin = scripts\engine\utility::getStruct("right_exit_gate_open_1", "targetname").origin;
  level.rightexitgate2 = getEnt("right_exit_gate_2", "targetname");
  level.rightexitgate2.origin = scripts\engine\utility::getStruct("right_exit_gate_open_2", "targetname").origin;
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("proxywar_lights_end_explosion");
}

trucks_stolen_main() {
  scripts\engine\sp\utility::autosave_by_name("trucks_retreat");
  level.player thread scripts\sp\player::focusdisable();
  level.player lerpviewangleclamp(0.1, 0, 0, 20, 20, 10, 10);
  level.bravo1 delete();
  level.bravo2 delete();
  wait 3;
  level.player setclienttriggeraudiozone("proxy_ending", 3.0);
  thread audio_truck3_wake_up_and_away();
  var_0 = 0.5;
  thread scripts\sp\hud_util::fade_in(var_0);
  scripts\engine\utility::delaythread(var_0 * 2, scripts\sp\hud_util::fade_out, var_0);
  scripts\engine\utility::delaythread(var_0 * 4, scripts\sp\hud_util::fade_in, var_0);
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::mus_hadir_discover();
  level.player.bodydouble = scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_third_person_alex();
  level.player.bodydouble hide();
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::end_sequence_dof();
  scripts\engine\utility::exploder("player_truck_fire");
  level.hadir = getspawner("hadir", "script_animname") scripts\engine\sp\utility::spawn_ai(1);
  level.hadir thread trucks_retreat_setup_actor(0, 0);
  level.fakeaq = getspawner("fake_aq", "script_animname") scripts\engine\sp\utility::spawn_ai(1);
  level.fakeaq thread trucks_retreat_setup_actor(1);
  level.player.gasmask = scripts\engine\sp\utility::spawn_anim_model("player_gasmask");
  var_1 = [level.hadir, level.fakeaq, level.truck2, level.truck3, level.player.gasmask, level.player_rig];
  var_2 = scripts\engine\utility::getStruct("wake_up_ref", "targetname");
  var_2 scripts\common\anim::anim_first_frame(var_1, "trucks_stolen");
  var_3 = scripts\engine\sp\utility::spawn_anim_model("windshield", level.truck2.origin, level.truck2.angles);
  level.truck2 setModel("veh8_civ_lnd_decho_static_dst_black");
  level thread wait_show_cinematic_bars();
  level.og_zplanes = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 1000");
  level.alpha1 thread alpha1_final_scene(var_2);
  level.bravo1 thread bravo3_final_scene(var_2);
  level thread wait_play_end_bink();
  var_2 thread scripts\common\anim::anim_single(var_1, "trucks_stolen");
  var_2 scripts\common\anim::anim_single_solo(level.player.bodydouble, "trucks_stolen");
  var_2 thread scripts\common\anim::anim_last_frame_solo(level.player.bodydouble, "trucks_stolen");
  var_2 thread scripts\common\anim::anim_last_frame_solo(level.player_rig, "trucks_stolen");
  setsaveddvar("OMNONNMOTP", level.og_zplanes);
}

audio_truck3_wake_up_and_away() {
  level.truck3_idle = spawn("script_origin", (-2696, -435, 178));
  wait 2;
  level.truck3_idle scripts\engine\sp\utility::sound_fade_in("scn_proxy_truck3_idle_wake_up_lp", 1.0, 3.0, 1);
  level waittill("audio_truck3_driving_off");
  level.truck3_idle scripts\engine\sp\utility::sound_fade_and_delete(3.0, 1);
}

alpha1_final_scene(var_0) {
  var_0 scripts\common\anim::anim_single_solo(level.alpha1, "trucks_stolen");
  level.alpha1.a.nodeath = 1;
  level.alpha1.noragdoll = 1;
  level.alpha1 scripts\common\ai::stop_magic_bullet_shield();
  level.alpha1.allowdeath = 1;
  level.alpha1 scripts\engine\sp\utility::die();
}

bravo3_final_scene(var_0) {
  var_0 scripts\common\anim::anim_single_solo(level.bravo3, "trucks_stolen");
  level.bravo3 delete();
}

trucks_retreat_setup_actor(var_0, var_1) {
  if(var_0)
    self attach("hat_gasmask");

  if(!isDefined(var_1))
    var_1 = 1;

  scripts\engine\sp\utility::name_hide();
  self.ignoreall = 1;
  self.ignoreme = 1;

  if(var_1) {
    var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
    scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  }
}

wait_show_cinematic_bars() {
  level waittill("show_cinematic_bars");
  level.player scripts\engine\utility::delaycall(18.0, ::setclienttriggeraudiozone, "fade_to_black_minus_scripted5_music_and_dx", 10.0);
  hidecinematicletterboxing(3.0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level thread check_skip_outro();
}

check_skip_outro(var_0) {
  var_1 = scripts\sp\utility::userskip_wait();

  if(var_1) {
    level.endmission_bink_skip = undefined;
    setsaveddvar("OMNONNMOTP", level.og_zplanes);
    scripts\engine\sp\utility::nextmission();
  }
}

wait_play_end_bink() {
  var_0 = scripts\sp\endmission::getlevelindex(level.script);
  var_1 = var_0 + 1;
  var_2 = scripts\sp\endmission::getlevelbink(var_1);
  level.endmission_bink_skip = 1;
  level waittill("play_bink");
  scripts\engine\utility::delaythread(1.9, ::audio_fade_out_over_bink);
  cinematicingame(var_2, 0, 0, 0, 0, 0, 1);
  wait 2;
  setsaveddvar("OMNONNMOTP", level.og_zplanes);
  scripts\engine\sp\utility::nextmission();
}

audio_fade_out_over_bink() {
  level.player setclienttriggeraudiozone("fade_to_black", 0.3);
}

trucks_stolen_catchup() {}
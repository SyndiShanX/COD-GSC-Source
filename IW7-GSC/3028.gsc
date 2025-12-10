/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3028.gsc
***************************************/

func_A298() {
  if(isDefined(level.func_A3B9))
    self[[level.func_A3B9.func_375D.func_444F]]();
}

func_9640() {
  func_F8A5();
  func_FA3D();
  func_0BDC::func_19B8();

  if(func_0BDC::func_9CF5())
    func_0BDC::func_F43D("player");
  else if(isDefined(self.func_C0B0) && self.func_C0B0)
    func_0BDC::func_F43D("null");
  else if(self.model == "tag_origin")
    func_0BDC::func_F43D("null");
  else if(issubstr(self.classname, "jackal_fake"))
    func_0BDC::func_F43D("fake");
  else
    func_0BDC::func_F43D("ai");

  self.func_5960 = 1;
  self setneargoalnotifydist(128.0);

  if(isDefined(self.target)) {
    var_00 = scripts\engine\utility::getstruct(self.target, "targetname");

    if(isDefined(var_00)) {
      return;
    }
    var_01 = _getcsplineidarray(self.target);

    if(isDefined(var_01)) {
      return;
    }
    return;
  }
}

func_F8A5() {
  self.func_9B4C = level.vehicle.func_116CE.func_155C[self.classname];
}

func_FA3D() {
  self.func_9CB8 = level.vehicle.func_116CE.func_F216[self.classname];
}

func_A329(var_00) {
  if(getdvarint("jackalHandbrakeMode"))
    level.player allowads(0);

  level.player func_0BCE::func_A2B2(self, undefined, var_00);
  level.player setorigin((100000, 100000, 100000));
  level.player.func_D409 = self;
  _setsaveddvar("spaceship_disableViewModelNotetracks", 1);
}

func_A2D9() {
  _setsaveddvar("spaceship_disableViewModelNotetracks", 0);

  if(getdvarint("jackalHandbrakeMode"))
    level.player allowads(1);

  setomnvar("ui_jackal_hide_follow_pip", 1);
  level.player func_0BCE::func_A2B1(self);
}

func_10492() {
  var_00 = spawnStruct();
  var_0.func_B8F9 = "sp";
  var_0.dvarfuncs = ::dvarfuncs;
  var_0.init = ::func_9640;
  func_0BCE::main(var_00);
  func_104AB();
  func_104A5();
  func_10496();
  func_10498();
  func_104A7();
  func_104A8();

  if(level.func_A056.func_B323) {
    func_104A4();
    func_ABD7();
  }
}

func_ABD7() {
  level.func_A056.func_3A02 = func_0BD5::func_3A02;
  level.func_A056.func_11543 = func_0BDC::func_105DB;
  level.func_A056.func_11540 = func_0BDC::func_105DA;
  level.func_A056.func_1151D = func_0BDC::func_105D2;
  level.func_A056.func_F389 = func_0BDC::func_F389;
  level.func_A056.func_B81C = func_0BD5::func_B81C;
  level.func_A056.func_A16E = func_0BDC::func_A16E;
  level.func_A056.func_A16D = func_0BDC::func_A2DF;
  level.func_A056.func_20A9 = func_0BDC::func_A079;
}

func_10496() {
  level.player scripts\sp\utility::func_65E0("flag_player_landing_enabled");
  level.player scripts\sp\utility::func_65E0("flag_player_has_jackal");
  level.player scripts\sp\utility::func_65E0("flag_player_is_flying");
  level.player scripts\sp\utility::func_65E0("flag_takeoff_cooldown");
  level.player scripts\sp\utility::func_65E0("flag_player_is_landing");
  level.player scripts\sp\utility::func_65E0("disable_jackal_missiles");
  level.player scripts\sp\utility::func_65E0("disable_jackal_mode_switch");
  level.player scripts\sp\utility::func_65E0("disable_jackal_emp");
  level.player scripts\sp\utility::func_65E0("disable_jackal_juke");
  level.player scripts\sp\utility::func_65E0("disable_jackal_flares");
  level.player scripts\sp\utility::func_65E0("disable_jackal_dogfight");
  level.player scripts\sp\utility::func_65E0("disable_jackal_guns");
  level.player scripts\sp\utility::func_65E0("disable_jackal_weapon_switch");
  level.player scripts\sp\utility::func_65E0("disable_jackal_ads");
  level.player scripts\sp\utility::func_65E0("disable_jackal_roll");
  level.player scripts\sp\utility::func_65E0("disable_jackal_quickturn");
  level.player scripts\sp\utility::func_65E0("disable_jackal_HUD_horizon");
  level.player scripts\sp\utility::func_65E0("disable_jackal_lockon");
  level.player scripts\sp\utility::func_65E0("disable_jackal_pilot_assist");
  level.player scripts\sp\utility::func_65E0("disable_jackal_overheat");
  level.player scripts\sp\utility::func_65E0("disable_jackal_targetAid");
  level.player scripts\sp\utility::func_65E0("disable_jackal_targetAid_update");
  level.player scripts\sp\utility::func_65E0("disable_jackal_map_boundary_autoturn");
  level.player scripts\sp\utility::func_65E0("disable_jackal_map_boundary_warning");
  level.player scripts\sp\utility::func_65E0("disable_jackal_map_boundary_push");
  level.player scripts\sp\utility::func_65E0("disable_jackal_cockpit_VO");
  level.player scripts\sp\utility::func_65E0("disable_jackal_damage_vision_distortion");
  level.player scripts\sp\utility::func_65E0("jackal_cockpit_VO");
  level.player scripts\sp\utility::func_65E0("jackal_force_mode");
  level.player scripts\sp\utility::func_65E0("jackal_autoboost");
  level.player scripts\sp\utility::func_65E0("flag_player_dismounting");
  level.player scripts\sp\utility::func_65E0("jackal_hud_on");
  level.player scripts\sp\utility::func_65E0("jackal_enemy_homing_missile_allowed");
  level.player scripts\sp\utility::func_65E0("jackal_enemy_homing_missile_allowed_hyperaggressive");
  scripts\engine\utility::flag_init("flag_trip_new_hover_speed");
  scripts\engine\utility::flag_init("flag_trip_new_fly_speed");
  scripts\engine\utility::flag_init("flag_trip_new_juke_speed");
  scripts\engine\utility::flag_init("flag_trip_new_boost_scale");
  scripts\engine\utility::flag_init("flag_trip_new_turn_scale");
  scripts\engine\utility::flag_init("flag_player_on_runway");
  scripts\engine\utility::flag_init("player_jackal_drone_dock");
  scripts\engine\utility::flag_init("jackal_missile_drone_primed");
  scripts\engine\utility::flag_init("jackal_missile_drone_active");
  scripts\engine\utility::flag_init("jackal_taking_off");
  scripts\engine\utility::flag_init("jackal_reving_hint");
  scripts\engine\utility::flag_init("jackal_launching_hint");
  scripts\engine\utility::flag_init("jackal_ads_hint");
  scripts\engine\utility::flag_init("jackal_lockon_hint");
  scripts\engine\utility::flag_init("jackal_brake_hint");
  scripts\engine\utility::flag_init("jackal_boost_hint");
  scripts\engine\utility::flag_init("jackal_weapon_switch_hint");
  scripts\engine\utility::flag_init("jackal_land_hint");
  scripts\engine\utility::flag_init("jackal_juke_hint");
  scripts\engine\utility::flag_init("jackal_flare_hint");
  scripts\engine\utility::flag_init("jackal_noflare_hint");
  scripts\engine\utility::flag_init("jackal_missile_hint");
  scripts\engine\utility::flag_init("jackal_missile_lock_hint");
  scripts\engine\utility::flag_init("jackal_lose_lock_hint");
  scripts\engine\utility::flag_init("jackal_supply_drop_hint");
  scripts\engine\utility::flag_init("jackal_runway_hint");
  scripts\engine\utility::flag_init("jackal_runway_landing_active");
  scripts\engine\utility::flag_init("jackal_runway_first_attempt");
  scripts\engine\utility::flag_init("jackal_return_to_battle_hint");
  scripts\engine\utility::flag_init("jackal_sees_ret_for_landing");
  scripts\engine\utility::flag_init("jackal_can_takeoff");
  scripts\engine\utility::flag_init("jackal_hint_ret_launch");
  scripts\engine\utility::flag_init("jackal_hint_ret_return");
  scripts\engine\utility::flag_init("jackal_hint_ret_reapproach");
  scripts\engine\utility::flag_init("jackal_dogfight_hint");
  scripts\engine\utility::flag_init("jackal_missile_tutorial");
  scripts\engine\utility::flag_init("jackal_find_lockon");
  scripts\engine\utility::flag_init("jackal_landing_drone_detached");
  scripts\engine\utility::flag_init("jackal_landing_active");
  scripts\engine\utility::flag_init("jackal_landing_never_launch_drone");

  if(!scripts\engine\utility::flag_exist("flag_jackal_in_landingzone"))
    scripts\engine\utility::flag_init("flag_jackal_in_landingzone");
}

func_10498() {
  scripts\sp\utility::func_16EB("jackal_mount_hint", &"JACKAL_MOUNT", ::func_A217);
  scripts\sp\utility::func_16EB("jackal_supply_drop", &"JACKAL_MARK_DROPZONE", ::func_A220);
  scripts\sp\utility::func_16EB("jackal_takeoff", &"JACKAL_TAKEOFF", ::func_A221);
  scripts\sp\utility::func_16EB("jackal_launch_rev", &"JACKAL_LAUNCH_REV", ::func_A21D);
  scripts\sp\utility::func_16EB("jackal_launch_rev_pc", &"JACKAL_LAUNCH_REV_PC", ::func_A21D);
  scripts\sp\utility::func_16EB("jackal_launch_start", &"JACKAL_LAUNCH_START", ::func_A222);
  scripts\sp\utility::func_16EB("jackal_ads", &"JACKAL_ADS", ::func_A209);
  scripts\sp\utility::func_16EB("jackal_lockon", &"JACKAL_LOCKON", ::func_A213);
  scripts\sp\utility::func_16EB("jackal_brake", &"JACKAL_BRAKE", ::func_A20C);
  scripts\sp\utility::func_16EB("jackal_boost", &"JACKAL_BOOST", ::func_A20B);
  scripts\sp\utility::func_16EB("jackal_land", &"JACKAL_LAND", ::func_A211);
  scripts\sp\utility::func_16EB("jackal_landing_scan", &"JACKAL_LANDING_SCAN", ::func_A212);
  scripts\sp\utility::func_16EB("jackal_strike", &"JACKAL_STRIKE", ::func_A21F);
  scripts\sp\utility::func_16EB("jackal_assault", &"JACKAL_ASSAULT", ::func_A20A);
  scripts\sp\utility::func_16EB("jackal_weapon_switch", &"JACKAL_WEAP_SWITCH", ::func_A223);
  scripts\sp\utility::func_16EB("jackal_missile", &"JACKAL_MISSILE", ::func_A215);
  scripts\sp\utility::func_16EB("jackal_missile_lock", &"JACKAL_MISSILE_LOCK", ::func_A216);
  scripts\sp\utility::func_16EB("jackal_find_lockon", &"JACKAL_FIND_LOCKON", ::func_A20E);
  scripts\sp\utility::func_16EB("jackal_lose_lock", &"JACKAL_LOSE_LOCK", ::func_A214);
  scripts\sp\utility::func_16EB("jackal_juke_hint", &"JACKAL_JUKE_HINT", ::func_A210);
  scripts\sp\utility::func_16EB("jackal_flare_hint", &"JACKAL_FLARE_HINT", ::func_A20F);
  scripts\sp\utility::func_16EB("jackal_runway_hint", &"JACKAL_LAND_RUNWAY", ::func_A21E);
  scripts\sp\utility::func_16EB("jackal_runway_hint_inverted", &"JACKAL_LAND_RUNWAY_INVERTED", ::func_A21E);
  scripts\sp\utility::func_16EB("jackal_return_to_battle", &"JACKAL_RETURN_TO_BATTLE", ::func_A21C);
  scripts\sp\utility::func_16EB("jackal_launch_retribution", &"JACKAL_RET_LAUNCH", ::func_A219);
  scripts\sp\utility::func_16EB("jackal_return_to_ret", &"JACKAL_HINT_RETURN", ::func_A21B);
  scripts\sp\utility::func_16EB("jackal_hint_ret_reapproach", &"JACKAL_HINT_REAAPROACH", ::func_A21A);
  scripts\sp\utility::func_16EB("jackal_hint_ret_approach", &"JACKAL_HINT_APPROACH", ::func_A218);
  scripts\sp\utility::func_16EB("jackal_dogfight_hint", &"JACKAL_DOGFIGHT", ::func_A20D);
}

func_75E7(var_00, var_01) {
  var_02 = "";

  if(var_00 == "axis")
    var_02 = "_enemy";

  level._effect[var_00 + "_rearThrustBoost"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_boost.vfx");
  level._effect[var_00 + "_rearThrustMax"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_fly_atmosphere.vfx");
  level._effect[var_00 + "_rearThrustMax_space"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_fly_space.vfx");
  level._effect[var_00 + "_rearThrustIdle"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_idle_atmosphere.vfx");
  level._effect[var_00 + "_rearThrustIdle_space"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_idle_space.vfx");
  level._effect[var_00 + "_vtolThrustCenter"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_vtol_center.vfx");
  level._effect[var_00 + "_vtolThrustSide"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_vtol_side.vfx");

  if(var_02 == "") {
    level._effect[var_00 + "_rearThrustLaunch_med"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_launch_child_med.vfx");
    level._effect[var_00 + "_rearThrustLaunch_lrg"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_launch_child_lrg.vfx");
    level._effect[var_00 + "_rearThrustLaunch_panels_blow_med"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_bottom_burst.vfx");
    level._effect[var_00 + "_rearThrustLaunch_charge_lrg"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_launch_charge_lrg.vfx");
  }

  level._effect["allies_winglight"] = loadfx("vfx\iw7\core\vehicle\global\vfx_acraft_light_wingtip_blue_blink.vfx");
  level._effect["axis_winglight"] = loadfx("vfx\iw7\core\vehicle\global\vfx_acraft_light_wingtip_orange_blink.vfx");
  level._effect["allies_taillight"] = loadfx("vfx\iw7\core\vehicle\global\vfx_acraft_light_wingtip_blue.vfx");
  level._effect["axis_taillight"] = loadfx("vfx\iw7\core\vehicle\global\vfx_acraft_light_wingtip_orange.vfx");
  level._effect["allies_bellylight"] = loadfx("vfx\iw7\core\vehicle\global\vfx_acraft_light_white_blink.vfx");
  level._effect["axis_bellylight"] = loadfx("vfx\iw7\core\vehicle\global\vfx_acraft_light_red_blink.vfx");
  level._effect["jackal_boost_speed"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_boost_speed.vfx");
  level._effect["fighter_spaceship_damage_med_linger"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_hit_damage_linger.vfx");
  level._effect["fighter_spaceship_dying_init"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_damage.vfx");
  level._effect["fighter_spaceship_dying"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_dying_01.vfx");
  level._effect["fighter_spaceship_explosion"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_01.vfx");
  level._effect["fighter_spaceship_explosion_space"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_01.vfx");
  level._effect["fighter_spaceship_explosion_cheap"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_01_cheap.vfx");
  level._effect["fighter_spaceship_explosion_ground"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_ground.vfx");
  level._effect["jackal_debris_impact"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_windshield_reflect.vfx");
  level._effect[var_00 + "_spaceship_explosion"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_death_01.vfx");
  level._effect[var_00 + "_spaceship_explosion_space"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_death_01.vfx");
  level._effect[var_00 + "_spaceship_explosion_cheap"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_death_01_cheap.vfx");
  level._effect[var_00 + "_spaceship_explosion_hov"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_death_hover_01.vfx");
  level._effect[var_00 + "_spaceship_explosion_hov_space"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_death_hover_01.vfx");
  level._effect["fighter_spaceship_damage_med_hov_trail"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_hit_hov_damage_linger.vfx");
  level._effect["fighter_spaceship_explosion_hov_space"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_hover_01.vfx");
  level._effect["fighter_spaceship_explosion_hov"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_hover_01.vfx");
  level._effect["fighter_spaceship_damage_med"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_hit_damage.vfx");
  level._effect["jackal_impact_target"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_player_impact.vfx");
  level._effect["jackal_impact_target_large"] = loadfx("vfx\iw7\core\impact\veh_bullet_explode\vfx_imp_vbexp_vul.vfx");
  level._effect["weapon_drone_counterthrust_exhaust"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_counterthrust_exhaust.vfx");
  level._effect["weapon_drone_counterthrust"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_counterthrust.vfx");
  level._effect["weapon_drone_thrust_small"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_thrust_small.vfx");
  level._effect["weapon_drone_thrust_small_out"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_thrust_small_out.vfx");
  level._effect["weapon_drone_thrust_big"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_thrust_big.vfx");
  level._effect["weapon_drone_thrust_med"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_thrust_med.vfx");
  level._effect["weapon_drone_pod_open"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_pod_open.vfx");
  level._effect["weapon_drone_pod_trail"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\weapon_drone_pod_trail.vfx");
  level._effect["landing_drone_light_top"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_drone_light_top.vfx");
  level._effect["landing_drone_light_top_blink"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_drone_light_top_blink.vfx");
  level._effect["landing_drone_light_top_off"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_drone_light_top_off.vfx");
  level._effect["landing_pad_lights"] = loadfx("vfx\iw7\core\light\landingpad\vfx_lp_green_blink.vfx");
  level._effect["landing_pad_marker"] = loadfx("vfx\core\vehicles\vfx_jackal_landing_pad_marker.vfx");
  level._effect["landing_pad_marker_pulse"] = loadfx("vfx\core\vehicles\vfx_jackal_landing_pad_marker_pulse.vfx");
  level._effect["landing_pad_confirmed"] = loadfx("vfx\core\vehicles\vfx_jackal_landing_pad_marker_confirmed.vfx");
  level._effect["jackal_runway_hangar_light"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_runway_hangar_light.vfx");
  level._effect["jackal_runway_segment"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_runway_segment_2.vfx");
  level._effect["jackal_runway_segment_start"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_runway_segment_start.vfx");
  level._effect["jackal_runway_segment_end"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_runway_segment_end.vfx");
  level._effect["jackal_runway_arrows"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_runway_arrows.vfx");
  level._effect["jackal_runway_arrow_end"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_runway_arrow_end.vfx");
  level._effect["jackal_runway_hoop"] = loadfx("vfx\iw7\core\vehicle\jackal\drone\landing_runway_hoop.vfx");
  level._effect["jet_missile_imp_water"] = loadfx("vfx\old\space_fighter\vfx_jet_missile_imp_water.vfx");
  level._effect["jet_missile_imp_generic"] = loadfx("vfx\iw7\core\expl\weap\missile\vfx_missile_small_exp.vfx");
  level._effect["jet_missile_imp_generic_zg"] = loadfx("vfx\iw7\core\expl\weap\missile\vfx_missile_small_exp_zg.vfx");
  level._effect["jet_missile_imp_airburst"] = loadfx("vfx\iw7\levels\moon\vfx_jet_missile_imp_generic_moon_premature.vfx");
  level._effect["jackal_missile_tag"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_missile_tag.vfx");
  level._effect["missile_flare_generic"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_player_missile.vfx");
  level._effect["jackal_enemy_locking"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_enemy_locking.vfx");
  level._effect["jackal_flare_decoy"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_flare_decoy.vfx");
  level._effect["jackal_flare_decoy_plr"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_flare_decoy_plr.vfx");
  level._effect["jackal_flare_impact_plr"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_flare_impact_plr.vfx");
  level._effect["jackal_flare_fizzle_plr"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_flare_fizzle_plr.vfx");
  level._effect["jackal_primary_energy"] = loadfx("vfx\core\beam\jackal\vfx_jackal_primary_beam.vfx");
  level._effect["jackal_dogfight_cam"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_dogfight_cam_particles.vfx");
  level._effect["fake_follow_jackal_tracer"] = loadfx("vfx\core\projectile\jackal\vfx_core_projectile_jackal_ai_modern_tail_fake.vfx");
  level._effect["30mm_flash"] = loadfx("vfx\core\muzflash\jackal\vfx_core_flash_jackal_30mm.vfx");

  if(!isDefined(level.func_A1E3))
    level.func_A1E3 = [];

  if(var_00 == "axis") {
    level.func_A1E3[var_00 + "_rear_thrusters"] = ["tag_thrust_rear1"];
    level.func_A1E3[var_00 + "_launch_boosters_sml"] = [];
    level.func_A1E3[var_00 + "_launch_boosters_med"] = [];
    level.func_A1E3[var_00 + "_launch_boosters_lrg"] = [];
  } else if(var_00 == "allies") {
    level.func_A1E3[var_00 + "_rear_thrusters"] = ["tag_thrust_rear_LE", "tag_thrust_rear_RI"];
    level.func_A1E3[var_00 + "_launch_boosters_med"] = ["j_rocket_booster_rear_left1", "j_rocket_booster_rear_right1"];
    level.func_A1E3[var_00 + "_launch_boosters_lrg"] = ["j_rocket_booster_rear_left2", "j_rocket_booster_rear_right2"];
  }

  if(issubstr(var_01, "_moon")) {
    level._effect[var_00 + "_rearThrustBoost"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_boost.vfx");
    level._effect[var_00 + "_rearThrustMax"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_fly_atmosphere.vfx");
    level._effect[var_00 + "_rearThrustMax_space"] = loadfx("vfx\iw7\levels\sa_moon\vfx_sa_moon_jackal" + var_02 + "_rear_thrust_fly_space.vfx");
    level._effect[var_00 + "_rearThrustIdle"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_idle_atmosphere.vfx");
    level._effect[var_00 + "_rearThrustIdle_space"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_rear_thrust_idle_space.vfx");
    level._effect[var_00 + "_vtolThrustCenter"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_vtol_center.vfx");
    level._effect[var_00 + "_vtolThrustSide"] = loadfx("vfx\iw7\core\vehicle\jackal" + var_02 + "\vfx_jackal" + var_02 + "_vtol_side.vfx");
    level._effect["fighter_spaceship_explosion_space"] = loadfx("vfx\iw7\levels\sa_moon\vfx_sa_moon_jackal_death_intro.vfx");
  }

  if(level.func_A056.func_B323) {
    level._effect["vfx_jackal_cockpit_decomp"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_cockpit_decomp.vfx");
    level._effect["vfx_jackal_cockpit_canopy"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_cockpit_canopy.vfx");
    level._effect["missile_flare_short"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_player_missile_short.vfx");
    level._effect["cockpit_death_explo"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_interior_emp_imp.vfx");
    level._effect["cockpit_death_explo_huge"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_interior_death_explo_huge.vfx");
    level._effect["cockpit_dying_flames"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_interior_dying_fire.vfx");
    level._effect["cockpit_damage_sparks"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_interior_damage_sparks.vfx");
    level._effect["cockpit_damage_sparks_med"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_interior_damage_sparks_med.vfx");
    level._effect["cockpit_damage_sparks_lrg"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_interior_damage_sparks_lrg.vfx");
    level._effect["cockpit_light_monitor_mid"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_mid.vfx");
    level._effect["cockpit_light_monitor_l"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_l.vfx");
    level._effect["cockpit_light_monitor_r"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_r.vfx");
    level._effect["cockpit_light_monitor_boot_mid"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_boot_mid.vfx");
    level._effect["cockpit_light_monitor_boot_l"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_boot_l.vfx");
    level._effect["cockpit_light_monitor_boot_r"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_boot_r.vfx");
    level._effect["cockpit_light_monitor_alarm_mid"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_alarm_mid.vfx");
    level._effect["cockpit_light_monitor_alarm_l"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_alarm_l.vfx");
    level._effect["cockpit_light_monitor_alarm_r"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_alarm_r.vfx");
    level._effect["cockpit_light_monitor_incoming_mid"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_incoming_mid.vfx");
    level._effect["cockpit_light_monitor_incoming_l"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_incoming_l.vfx");
    level._effect["cockpit_light_monitor_incoming_r"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_light_monitor_incoming_r.vfx");
    level._effect["cockpit_light_side"] = loadfx("vfx\iw7\core\vehicle\jackal\cockpit\vfx_jkl_cockpit_spot_sides.vfx");
  }
}

#using_animtree("jackal");

func_31A1() {
  level.func_A065["evasion"] = [ % jackal_vehicle_evade_01, % jackal_vehicle_evade_02, % jackal_vehicle_evade_03, % jackal_vehicle_evade_04, % jackal_vehicle_evade_05, % jackal_vehicle_evade_06, % jackal_vehicle_evade_07, % jackal_vehicle_evade_08];
  level.func_A065["evasion_overlay"] = % jackal_evade_overlay;
  level.func_A065["evasion"] = scripts\engine\utility::array_randomize(level.func_A065["evasion"]);
}

func_104A7() {
  level.func_A056.func_A82D = [];
  level.func_A056.func_1632 = [];
  var_00 = getEntArray("jackal_landingzone", "targetname");

  foreach(var_02 in var_00) {
    var_03 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_04 = scripts\engine\utility::spawn_tag_origin();
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4.targetname = var_3.targetname;
    var_4.func_1270F = var_02;
    var_4.tag_origin = scripts\engine\utility::spawn_tag_origin();
    var_4.tag_origin.origin = var_4.origin;
    var_4.tag_origin.angles = var_4.angles;

    if(isDefined(var_3.script_noteworthy))
      var_4.script_noteworthy = var_3.script_noteworthy;

    if(isDefined(var_3.func_EE10))
      var_4.func_EE10 = var_3.func_EE10;

    var_03 = undefined;
    var_05 = undefined;

    if(isDefined(var_2.script_noteworthy)) {
      var_05 = getent(var_2.script_noteworthy, "targetname");

      if(isDefined(var_05)) {
        if(issubstr(var_5.classname, "_vehicle"))
          var_05 = scripts\sp\utility::func_7D40(var_2.script_noteworthy, "targetname");

        var_02 getrankxp();
        var_02 _meth_8314();
        var_02 linkto(var_05);
        var_04 linkto(var_05);
        var_4.tag_origin linkto(var_05);
      }
    }

    level.func_A056.func_A82D = scripts\engine\utility::array_add(level.func_A056.func_A82D, var_04);
    var_4.lights = [];
    var_06 = scripts\engine\utility::getstructarray(var_4.targetname, "target");

    foreach(var_08 in var_06) {
      if(var_8.script_parameters == "landing_pad_light") {
        var_09 = scripts\engine\utility::spawn_tag_origin();
        var_9.origin = var_8.origin;

        if(isDefined(var_05))
          var_09 linkto(var_05);

        var_4.lights = scripts\engine\utility::array_add(var_4.lights, var_09);
      }
    }

    var_4.enabled = 0;
    var_4.func_B36C = 0;
    func_0BDC::func_6211(var_04, 1);
  }

  func_0BDC::func_A06A(1);
}

func_104A8() {
  var_00 = getEntArray("jackal_cockpit_probe", "targetname");

  if(var_0.size == 0)
    return;
  else
    level.func_A056.func_DE59 = var_0[0];
}

init_location() {}

dvarfuncs(var_00, var_01) {
  _setsaveddvar(var_00, var_01);
}

func_10499() {}

func_104A5() {
  precacheitem("spaceship_ai_30mm_projectile");
  precacheitem("spaceship_ai_energy_projectile");
  precacheitem("magic_spaceship_30mm_projectile");
  precacheitem("magic_spaceship_30mm_projectile_fake");
  precacheitem("spaceship_homing_missile");
  precacheitem("spaceship_forward_missile");
  precacheitem("spaceship_scripted_miniflak");
  precacheitem("spaceship_scripted_locked_enemy_bullets");
  precacheshader("overlay_static");
  precacherumble("steady_rumble");
  precachestring(&"JACKAL_DOGFIGHT");
  precachestring(&"JACKAL_JACKAL");
  precachestring(&"JACKAL_SDF_DESTROYER");
  precachestring(&"JACKAL_RETRIBUTION");
  precachestring(&"JACKAL_AJAK");
  precachestring(&"JACKAL_ACE_SKELTER");
  precachestring(&"JACKAL_R7_SKELTER");
  precachestring(&"JACKAL_R16_SKELTER");
  precachestring(&"JACKAL_TURRET");
  precachestring(&"JACKAL_MMT38_WHIPLASH");
  precachestring(&"JACKAL_30MM_GRUNION");
  precachestring(&"JACKAL_76MM_DSM");
  precachestring(&"JACKAL_20MM_OST");
  precachestring(&"JACKAL_R28_TASKMASTER");
  precachestring(&"JACKAL_ENGINE");
  precachestring(&"JACKAL_SHIELD");
  precachestring(&"JACKAL_ENEMY");
  precachemodel("veh_mil_air_un_jackal_missile_coll");
  precachemodel("veh_mil_air_un_jackal_02_panels");
}

func_104A4() {
  precachevehicle("jackal_un_landing");
  precachemodel("veh_mil_air_un_support_drone");
  precachemodel("veh_mil_air_un_support_drone_pod");
  precachemodel("veh_mil_air_un_landing_drone");
  precachemodel("vm_hero_protagonist_helmet");
  precachemodel("viewmodel_base_animated");
  precacheshader("hud_jackal_overlay_damage");
}

func_104AB() {
  precacheitem("spaceship_disabled_guns");
  precacheitem("spaceship_cannon_projectile");
  precacheitem("spaceship_cleaver_projectile");
  precacheitem("spaceship_anvil_projectile");
  precacheitem("spaceship_30mm_projectile");
  precacheitem("spaceship_30mm_growler");
  precacheitem("spaceship_30mm_slow");
  precacheitem("spaceship_cannon_projectile_weapupgrade");
  precacheitem("spaceship_cleaver_projectile_weapupgrade");
  precacheitem("spaceship_anvil_projectile_weapupgrade");
  precacheitem("spaceship_30mm_projectile_weapupgrade");
  precacheitem("spaceship_30mm_growler_weapupgrade");
  precacheitem("spaceship_30mm_slow_weapupgrade");
  precacheitem("spaceship_forward_missile");
  precacheitem("spaceship_homing_missile");
}

func_A220() {
  return !scripts\engine\utility::flag("jackal_supply_drop_hint") || isDefined(level.func_10260);
}

func_A217() {
  return !scripts\engine\utility::flag("flag_mount_jackal") || level.player.func_C53F;
}

func_A221() {
  return level.player gettimeremainingpercentage() || isDefined(level.func_D127.func_7294);
}

func_A21D() {
  return !scripts\engine\utility::flag("jackal_reving_hint");
}

func_A222() {
  return !scripts\engine\utility::flag("jackal_launching_hint");
}

func_A209() {
  return !scripts\engine\utility::flag("jackal_ads_hint");
}

func_A213() {
  return !scripts\engine\utility::flag("jackal_lockon_hint");
}

func_A20A() {
  if(!isDefined(level.func_D127))
    return 1;

  if(level.func_D127.spaceship_mode == "hover")
    return 1;
  else
    return 0;
}

func_A21F() {
  if(!isDefined(level.func_D127))
    return 1;

  if(level.func_D127.spaceship_mode == "fly")
    return 1;
  else
    return 0;
}

func_A223() {
  return !scripts\engine\utility::flag("jackal_weapon_switch_hint");
}

func_A210() {
  return !scripts\engine\utility::flag("jackal_juke_hint");
}

func_A20F() {
  return !scripts\engine\utility::flag("jackal_flare_hint");
}

func_A20C() {
  return !scripts\engine\utility::flag("jackal_brake_hint");
}

func_A20B() {
  return !scripts\engine\utility::flag("jackal_boost_hint");
}

func_A211() {
  return !scripts\engine\utility::flag("jackal_land_hint");
}

func_A21E() {
  return !scripts\engine\utility::flag("jackal_runway_hint");
}

func_A212() {
  return !scripts\engine\utility::flag("jackal_landing_scan_hint");
}

func_A215() {
  return !scripts\engine\utility::flag("jackal_missile_hint");
}

func_A214() {
  return !scripts\engine\utility::flag("jackal_lose_lock_hint");
}

func_A216() {
  return !scripts\engine\utility::flag("jackal_missile_lock_hint");
}

func_A20E() {
  return !scripts\engine\utility::flag("jackal_find_lockon");
}

func_A21C() {
  return !scripts\engine\utility::flag("jackal_return_to_battle_hint");
}

func_A219() {
  return !scripts\engine\utility::flag("jackal_hint_ret_launch");
}

func_A21B() {
  return !scripts\engine\utility::flag("jackal_hint_ret_return");
}

func_A21A() {
  return !scripts\engine\utility::flag("jackal_hint_ret_reapproach");
}

func_A218() {
  return !scripts\engine\utility::flag("jackal_hint_ret_reapproach");
}

func_A20D() {
  return !scripts\engine\utility::flag("jackal_dogfight_hint");
}
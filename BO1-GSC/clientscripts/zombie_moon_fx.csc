/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_moon_fx.csc
********************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;
#include clientscripts\_music;

main() {
  precache_createfx_fx();
  clientscripts\createfx\zombie_moon_fx::main();
  clientscripts\_fx::reportNumEffects();
  footsteps();
  disableFX = GetDvarInt(#"disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }
  level thread clientscripts\_zombiemode::init_perk_machines_fx();
  level thread fog_triggers_setup();
  level thread airlock_fx_init();
  level thread breach_receiving_fx();
  level thread breach_labs_lower_fx();
  level thread breach_labs_upper_fx();
  level thread power_on_spinning_lights();
}

fog_triggers_setup() {
  waitforclient(0);
  wait(3);
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    level thread moon_fog_triggers_init(i);
  }
}

footsteps() {}
airlock_fx_init() {
  waitforallclients();
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread airlock_fx(i);
  }
}

airlock_fx(localClientNum) {
  level waittill("power_on");
  airlock_fx = getEntArray(localClientNum, "airlock_jambs_fx", "targetname");
  for(i = 0; i < airlock_fx.size; i++) {
    forwardVec = VectorNormalize(anglesToForward(airlock_fx[i].angles));
    playFX(localClientNum, level._effect["airlock_fx"], airlock_fx[i].origin, forwardVec);
  }
}

precache_scripted_fx() {
  level._effect["switch_sparks"] = loadfx("env/electrical/fx_elec_wire_spark_burst");
  level._effect["zapper_light_ready"] = loadfx("misc/fx_zombie_zapper_light_green");
  level._effect["zapper_light_notready"] = loadfx("misc/fx_zombie_zapper_light_red");
  level._effect["wire_sparks_oneshot"] = loadfx("env/electrical/fx_elec_wire_spark_dl_oneshot");
  level._effect["airlock_fx"] = loadfx("maps/zombie_moon/fx_moon_airlock_door_forcefield");
  level._effect["eye_glow"] = LoadFx("misc/fx_zombie_eye_single");
  level._effect["headshot"] = LoadFX("impacts/fx_flesh_hit");
  level._effect["headshot_nochunks"] = LoadFX("misc/fx_zombie_bloodsplat");
  level._effect["bloodspurt"] = LoadFX("misc/fx_zombie_bloodspurt");
  level._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  level._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
  level._effect["jump_pad_active"] = loadfx("maps/zombie_moon/fx_moon_jump_pad_on");
  level._effect["glass_impact"] = loadfx("maps/zombie_moon/fx_moon_break_window");
  level._effect["fx_weak_sauce_trail"] = loadfx("maps/zombie_temple/fx_ztem_weak_sauce_trail");
  level._effect["soul_swap_trail"] = loadfx("maps/zombie_moon/fx_moon_soul_swap");
  level._effect["vrill_glow"] = LoadFX("maps/zombie_moon/fx_moon_vril_glow");
  level._effect["rise_billow_lg"] = loadFx("maps/zombie_moon/fx_moon_body_dirt_billowing");
  level._effect["rise_dust_lg"] = loadfx("maps/zombie_moon/fx_moon_body_dust_falling");
  level._effect["rise_burst_lg"] = loadFx("maps/zombie_moon/fx_moon_hand_dirt_burst");
  level._effect["exca_beam"] = loadfx("maps/zombie_moon/fx_digger_light_beam");
  level._effect["exca_blink"] = loadfx("maps/zombie_moon/fx_beacon_light_red");
  level._effect["digger_treadfx_fwd"] = loadfx("maps/zombie_moon/fx_digger_treadfx_fwd");
  level._effect["digger_treadfx_bkwd"] = loadfx("maps/zombie_moon/fx_digger_treadfx_rev");
  level._effect["panel_on"] = loadfx("maps/zombie_moon/fx_moon_digger_panel_on");
  level._effect["panel_off"] = loadfx("maps/zombie_moon/fx_moon_digger_panel_off");
  level._effect["lght_marker_flare"] = Loadfx("maps/zombie/fx_zombie_coast_marker_fl");
  level._effect["test_spin_fx"] = LoadFX("env/light/fx_light_warning");
  level._effect["blue_eyes"] = LoadFX("misc/fx_zombie_eye_single_blue");
  level._effect["osc_button_glow"] = LoadFX("maps/zombie_moon/fx_moon_button_console_glow");
}

precache_createfx_fx() {
  level._effect["fx_mp_fog_xsm_int"] = Loadfx("maps/mp_maps/fx_mp_fog_xsm_int");
  level._effect["fx_moon_fog_spawn_closet"] = Loadfx("maps/zombie_moon/fx_moon_fog_spawn_closet");
  level._effect["fx_zmb_fog_thick_300x300"] = Loadfx("maps/zombie/fx_zmb_fog_thick_300x300");
  level._effect["fx_zmb_fog_thick_600x600"] = Loadfx("maps/zombie/fx_zmb_fog_thick_600x600");
  level._effect["fx_moon_fog_canyon"] = Loadfx("maps/zombie_moon/fx_moon_fog_canyon");
  level._effect["fx_moon_vent_wall_mist"] = Loadfx("maps/zombie_moon/fx_moon_vent_wall_mist");
  level._effect["fx_dust_motes_blowing"] = Loadfx("env/debris/fx_dust_motes_blowing");
  level._effect["fx_zmb_coast_sparks_int_runner"] = Loadfx("maps/zombie/fx_zmb_coast_sparks_int_runner");
  level._effect["fx_moon_floodlight_narrow"] = Loadfx("maps/zombie_moon/fx_moon_floodlight_narrow");
  level._effect["fx_moon_floodlight_wide"] = Loadfx("maps/zombie_moon/fx_moon_floodlight_wide");
  level._effect["fx_moon_tube_light"] = Loadfx("maps/zombie_moon/fx_moon_tube_light");
  level._effect["fx_moon_lamp_glow"] = Loadfx("maps/zombie_moon/fx_moon_lamp_glow");
  level._effect["fx_moon_trap_switch_light_glow"] = Loadfx("maps/zombie_moon/fx_moon_trap_switch_light_glow");
  level._effect["fx_moon_teleporter_beam"] = Loadfx("maps/zombie_moon/fx_moon_teleporter_beam");
  level._effect["fx_moon_teleporter_start"] = Loadfx("maps/zombie_moon/fx_moon_teleporter_start");
  level._effect["fx_moon_teleporter_pad_start"] = Loadfx("maps/zombie_moon/fx_moon_teleporter_pad_start");
  level._effect["fx_moon_teleporter2_beam"] = Loadfx("maps/zombie_moon/fx_moon_teleporter2_beam");
  level._effect["fx_moon_teleporter2_pad_start"] = Loadfx("maps/zombie_moon/fx_moon_teleporter2_pad_start");
  level._effect["fx_moon_pyramid_egg"] = Loadfx("maps/zombie_moon/fx_moon_pyramid_egg");
  level._effect["fx_moon_pyramid_drop"] = Loadfx("maps/zombie_moon/fx_moon_pyramid_drop");
  level._effect["fx_moon_pyramid_opening"] = Loadfx("maps/zombie_moon/fx_moon_pyramid_opening");
  level._effect["fx_moon_ceiling_cave_dust"] = Loadfx("maps/zombie_moon/fx_moon_ceiling_cave_dust");
  level._effect["fx_moon_ceiling_cave_collapse"] = Loadfx("maps/zombie_moon/fx_moon_ceiling_cave_collapse");
  level._effect["fx_moon_digger_dig_dust"] = Loadfx("maps/zombie_moon/fx_moon_digger_dig_dust");
  level._effect["fx_moon_airlock_hatch_forcefield"] = Loadfx("maps/zombie_moon/fx_moon_airlock_hatch_forcefield");
  level._effect["fx_moon_biodome_ceiling_breach"] = Loadfx("maps/zombie_moon/fx_moon_biodome_ceiling_breach");
  level._effect["fx_moon_biodome_breach_dirt"] = Loadfx("maps/zombie_moon/fx_moon_biodome_breach_dirt");
  level._effect["fx_moon_breach_debris_room_os"] = Loadfx("maps/zombie_moon/fx_moon_breach_debris_room_os");
  level._effect["fx_moon_breach_debris_out_os"] = Loadfx("maps/zombie_moon/fx_moon_breach_debris_out_os");
  level._effect["fx_earth_destroyed"] = Loadfx("maps/zombie_moon/fx_earth_destroyed");
  level._effect["fx_quad_vent_break"] = LoadFX("maps/zombie/fx_zombie_crawler_vent_break");
}

power_on_spinning_lights() {
  level waittill("power_on");
}

trap_fx_monitor(name, side, trap_type) {
  while(1) {
    level waittill(name);
    points = getstructarray(name, "targetname");
    for(i = 0; i < points.size; i++) {
      points[i] thread electric_trap_fx(name, side, trap_type);
    }
  }
}

breach_receiving_fx() {
  level waittill("Az1");
  clientscripts\_fx::activate_exploder(300);
  if(level.power_on == false) {
    level waittill("ZPO");
  }
  level notify("sl0");
}

breach_labs_lower_fx() {
  level waittill("Az4a");
  clientscripts\_fx::activate_exploder(320);
  if(level.power_on == false) {
    level waittill("ZPO");
  }
  level notify("sl5");
  level notify("sl6");
}

breach_labs_upper_fx() {
  level waittill("Az4b");
  clientscripts\_fx::activate_exploder(340);
  if(level.power_on == false) {
    level waittill("ZPO");
  }
  level notify("sl4");
}

electric_trap_fx(name, side, trap_type) {
  ang = self.angles;
  forward = anglesToForward(ang);
  up = anglestoup(ang);
  if(isDefined(self.loopFX)) {
    for(i = 0; i < self.loopFX.size; i++) {
      self.loopFX[i] delete();
    }
    self.loopFX = [];
  }
  if(!isDefined(self.loopFX)) {
    self.loopFX = [];
  }
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    switch (trap_type) {
      case "electric":
        self.loopFX[i] = SpawnFx(i, level._effect["zapper"], self.origin, 0, forward, up);
        break;
      default:
      case "fire":
        self.loopFX[i] = SpawnFx(i, level._effect["fire_trap_med"], self.origin, 0, forward, up);
        break;
    }
    triggerfx(self.loopFX[i]);
  }
  level waittill(side + "off");
  for(i = 0; i < self.loopFX.size; i++) {
    self.loopFX[i] delete();
  }
  self.loopFX = [];
}

moon_fog_triggers_init(localClientNum) {
  exterior_array = getEntArray(localClientNum, "zombie_moonExterior", "targetname");
  array_thread(exterior_array, ::fog_trigger, ::moon_exterior_fog_change);
  moon_interior_array = getEntArray(localClientNum, "zombie_moonInterior", "targetname");
  array_thread(moon_interior_array, ::fog_trigger, ::moon_interior_fog_change);
  moon_biodome_array = getEntArray(localClientNum, "zombie_moonBiodome", "targetname");
  array_thread(moon_biodome_array, ::fog_trigger, ::moon_biodome_fog_change);
  moon_biodome_array = getEntArray(localClientNum, "zombie_moonTunnels", "targetname");
  array_thread(moon_biodome_array, ::fog_trigger, ::moon_tunnels_fog_change);
  nml_array = getEntArray(localClientNum, "zombie_nmlVision", "targetname");
  if(isDefined(nml_array) && nml_array.size > 0) {
    array_thread(nml_array, ::fog_trigger, ::moon_nml_fog_change);
  }
}

fog_trigger(change_func) {
  while(1) {
    self waittill("trigger", who);
    if(who IsLocalPlayer()) {
      self thread trigger_thread(who, change_func);
    }
  }
}

Moon_Exterior_Fog_Change(Ent_Player) {
  if(!isDefined(ent_player)) {
    return;
  }
  local_clientnum = ent_player GetLocalClientNumber();
  ent_player endon("entityshutdown");
  start_dist = 2098.71;
  half_dist = 1740.12;
  half_height = 1332.23;
  base_height = 576.887;
  fog_r = 0.0196078;
  fog_g = 0.0235294;
  fog_b = 0.0352941;
  fog_scale = 4.1367;
  sun_col_r = 0.247;
  sun_col_g = 0.235;
  sun_col_b = 0.160;
  sun_dir_x = 0.796421;
  sun_dir_y = 0.425854;
  sun_dir_z = 0.429374;
  sun_start_ang = 0;
  sun_stop_ang = 55;
  time = 0;
  max_fog_opacity = 0.95;
  setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  sunlight = 8;
  sundirection = (-16.28, 56.06, 0);
  suncolor = (0.655, 0.768, 0.817);
  SetSavedDvar("r_lightTweakSunLight", sunlight);
  SetSavedDvar("r_lightTweakSunDirection", sundirection);
  SetSavedDvar("sm_sunSampleSizeNear", "1.8");
  SetSavedDvar("r_skyColorTemp", (6400));
  if(!isDefined(ent_player._previous_vision)) {
    ent_player._previous_vision = "zme";
  }
  new_vision = "zme";
  ent_player clientscripts\zombie_moon_fx::moon_vision_set(ent_player._previous_vision, new_vision, local_clientnum, self.script_int);
  ent_player._previous_vision = "zme";
}

moon_interior_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  local_clientnum = ent_player GetLocalClientNumber();
  ent_player endon("entityshutdown");
  start_dist = 2098.71;
  half_dist = 1740.12;
  half_height = 1332.23;
  base_height = 576.887;
  fog_r = 0.0196078;
  fog_g = 0.0235294;
  fog_b = 0.0352941;
  fog_scale = 4.1367;
  sun_col_r = 0.247;
  sun_col_g = 0.235;
  sun_col_b = 0.160;
  sun_dir_x = 0.796421;
  sun_dir_y = 0.425854;
  sun_dir_z = 0.429374;
  sun_start_ang = 0;
  sun_stop_ang = 55;
  time = 0;
  max_fog_opacity = 0.95;
  setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  sunlight = 8;
  sundirection = (-16.28, 56.06, 0);
  suncolor = (0.655, 0.768, 0.817);
  SetSavedDvar("r_lightTweakSunLight", sunlight);
  SetSavedDvar("r_lightTweakSunDirection", sundirection);
  SetSavedDvar("sm_sunSampleSizeNear", ".8");
  SetSavedDvar("r_skyColorTemp", (6400));
  if(!isDefined(ent_player._previous_vision)) {
    ent_player._previous_vision = "zmi";
  }
  new_vision = "zmi";
  ent_player clientscripts\zombie_moon_fx::moon_vision_set(ent_player._previous_vision, new_vision, local_clientnum, self.script_int);
  ent_player._previous_vision = "zmi";
}

moon_biodome_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  local_clientnum = ent_player GetLocalClientNumber();
  ent_player endon("entityshutdown");
  start_dist = 65.3744;
  half_dist = 860.241;
  half_height = 35.1158;
  base_height = 116.637;
  fog_r = 0.117647;
  fog_g = 0.137255;
  fog_b = 0.101961;
  fog_scale = 2.96282;
  sun_col_r = 0.341176;
  sun_col_g = 0.231373;
  sun_col_b = 0.141176;
  sun_dir_x = 0.315232;
  sun_dir_y = 0.132689;
  sun_dir_z = -0.939693;
  sun_start_ang = 0;
  sun_stop_ang = 44.4323;
  time = 0;
  max_fog_opacity = 0.836437;
  setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  sunlight = 1.13;
  sundirection = (-33.34, -38.56, 0);
  SetSavedDvar("r_lightTweakSunLight", sunlight);
  SetSavedDvar("r_lightTweakSunDirection", sundirection);
  SetSavedDvar("sm_sunSampleSizeNear", "2");
  SetSavedDvar("r_sky_intensity_factor0", 2);
  SetSavedDvar("r_sky_intensity_useDebugValues", true);
  SetSavedDvar("r_skyColorTemp", (3600));
  SetSavedDvar("r_lightGridEnableTweaks", 1);
  SetSavedDvar("r_lightGridIntensity", 1.25);
  SetSavedDvar("r_lightGridContrast", .45);
  if(!isDefined(ent_player._previous_vision)) {
    ent_player._previous_vision = "zmb";
  }
  new_vision = "zmb";
  ent_player clientscripts\zombie_moon_fx::moon_vision_set(ent_player._previous_vision, new_vision, local_clientnum, self.script_int);
  ent_player._previous_vision = "zmb";
}

moon_tunnels_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  local_clientnum = ent_player GetLocalClientNumber();
  ent_player endon("entityshutdown");
  start_dist = 1413.46;
  half_dist = 4300.81;
  half_height = 32.2476;
  base_height = -238.873;
  fog_r = 0.192157;
  fog_g = 0.137255;
  fog_b = 0.180392;
  fog_scale = 3.2984;
  sun_col_r = 0.34902;
  sun_col_g = 0.129412;
  sun_col_b = 0.219608;
  sun_dir_x = 0.954905;
  sun_dir_y = 0.280395;
  sun_dir_z = 0.0976461;
  sun_start_ang = 0;
  sun_stop_ang = 0;
  time = 0;
  max_fog_opacity = 0.22;
  setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  if(!isDefined(ent_player._previous_vision)) {
    ent_player._previous_vision = "zmt";
  }
  new_vision = "zmt";
  ent_player clientscripts\zombie_moon_fx::moon_vision_set(ent_player._previous_vision, new_vision, local_clientnum, self.script_int);
  ent_player._previous_vision = "zmt";
  SetSavedDvar("r_skyColorTemp", (6400));
}

moon_nml_fog_change(ent_player) {
  if(!isDefined(ent_player) || (isDefined(level._dte_done) && level._dte_done)) {
    return;
  }
  local_clientnum = ent_player GetLocalClientNumber();
  ent_player endon("entityshutdown");
  start_dist = 1662.13;
  half_dist = 18604.1;
  half_height = 2618.86;
  base_height = -5373.56;
  fog_r = 0.764706;
  fog_g = 0.505882;
  fog_b = 0.231373;
  fog_scale = 5;
  sun_col_r = 0.8;
  sun_col_g = 0.435294;
  sun_col_b = 0.101961;
  sun_dir_x = 0.796421;
  sun_dir_y = 0.425854;
  sun_dir_z = 0.429374;
  sun_start_ang = 0;
  sun_stop_ang = 45.87;
  time = 0;
  max_fog_opacity = 0.72;
  sunlight = 5;
  sundirection = (-16, 56.06, 0);
  suncolor = (.924, .775, .651);
  SetSavedDvar("sm_sunSampleSizeNear", "1.18");
  if(!isDefined(ent_player._previous_vision)) {
    ent_player._previous_vision = "zmh";
  }
  new_vision = "zmh";
  ent_player clientscripts\zombie_moon_fx::moon_vision_set(ent_player._previous_vision, new_vision, local_clientnum, self.script_int);
  ent_player._previous_vision = "zmh";
  setVolFogForClient(local_clientnum, start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
  setClientDvar("r_lightTweakSunLight", sunlight);
  setClientDvar("r_lightTweakSunColor", suncolor);
  setClientDvar("r_lightTweakSunDirection", sundirection);
  SetSavedDvar("r_skyColorTemp", (6400));
}

moon_vision_set(str_vision_old, str_vision_new, int_clientnum, int_trans) {
  if(str_vision_old == str_vision_new) {
    return;
  }
  if(isDefined(str_vision_old)) {
    remove_vision = clientscripts\zombie_moon::moon_vision_set_choice(str_vision_old);
    clientscripts\_zombiemode::zombie_vision_set_remove(remove_vision[0], 0, int_clientnum);
  }
  if(isDefined(int_trans)) {
    trans_time = int_trans;
  } else {
    trans_time = 0;
  }
  start_vision = clientscripts\zombie_moon::moon_vision_set_choice(str_vision_new);
  clientscripts\_zombiemode::zombie_vision_set_apply(start_vision[0], start_vision[1], trans_time, int_clientnum);
}
/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_fx.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace zm_moon_fx;

function main() {
  precache_createfx_fx();
  precache_scripted_fx();
  disablefx = getdvarint("disable_fx");
  if(!isdefined(disablefx) || disablefx <= 0) {
    precache_scripted_fx();
  }
  level thread fog_triggers_setup();
  level thread airlock_fx_init();
  level thread power_on_spinning_lights();
}

function fog_triggers_setup() {
  util::waitforclient(0);
  wait(3);
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    level thread moon_fog_triggers_init(i);
  }
}

function airlock_fx_init() {
  util::waitforallclients();
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    players[i] thread airlock_fx(i);
  }
}

function airlock_fx(localclientnum) {
  level waittill("power_on");
  var_2043fd45 = struct::get_array("s_airlock_jambs_fx", "targetname");
  for (i = 0; i < var_2043fd45.size; i++) {
    if(isdefined(var_2043fd45[i].script_vector)) {
      forwardvec = vectornormalize(anglestoforward(var_2043fd45[i].script_vector));
    } else {
      forwardvec = vectornormalize(anglestoforward(var_2043fd45[i].angles));
    }
    playfx(localclientnum, level._effect["airlock_fx"], var_2043fd45[i].origin, forwardvec);
  }
}

function precache_scripted_fx() {
  level._effect["switch_sparks"] = "env/electrical/fx_elec_wire_spark_burst";
  level._effect["zapper_fx"] = "maps/zombie/fx_zombie_zapper_powerbox_on";
  level._effect["zapper_wall"] = "maps/zombie/fx_zombie_zapper_wall_control_on";
  level._effect["elec_trail_one_shot"] = "maps/zombie/fx_zombie_elec_trail_oneshot";
  level._effect["wire_sparks_oneshot"] = "electrical/fx_elec_wire_spark_dl_oneshot";
  level._effect["airlock_fx"] = "dlc5/moon/fx_moon_airlock_door_forcefield";
  level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
  level._effect["headshot"] = "impacts/fx_flesh_hit";
  level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
  level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
  level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
  level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
  level._effect["fx_weak_sauce_trail"] = "dlc5/zmb_weapon/fx_staff_charge_souls";
  level._effect["soul_swap_trail"] = "dlc5/moon/fx_moon_soul_swap";
  level._effect["vrill_glow"] = "dlc5/moon/fx_moon_vril_glow";
  level._effect["rise_billow_lg"] = "dlc5/moon/fx_moon_body_dirt_billowing";
  level._effect["rise_dust_lg"] = "dlc5/moon/fx_moon_body_dust_falling";
  level._effect["rise_burst_lg"] = "dlc5/moon/fx_moon_hand_dirt_burst";
  level._effect["exca_beam"] = "dlc5/moon/fx_digger_light_beam";
  level._effect["exca_blink"] = "dlc5/moon/fx_beacon_light_red";
  level._effect["exca_blink_blue"] = "dlc5/moon/fx_beacon_light_blue";
  level._effect["exca_body_all"] = "dlc5/moon/fx_digger_body_all";
  level._effect["exca_arm_all"] = "dlc5/moon/fx_digger_arm_beacons_all";
  level._effect["digger_treadfx_fwd"] = "dlc5/moon/fx_digger_treadfx_fwd";
  level._effect["digger_treadfx_bkwd"] = "dlc5/moon/fx_digger_treadfx_rev";
  level._effect["panel_on"] = "dlc5/moon/fx_moon_digger_panel_on";
  level._effect["panel_off"] = "dlc5/moon/fx_moon_digger_panel_off";
  level._effect["test_spin_fx"] = "env/light/fx_light_warning";
  level._effect["blue_eyes"] = "dlc5/zmhd/fx_zombie_eye_single_blue";
  level._effect["jump_pad_active"] = "dlc5/moon/fx_moon_jump_pad_on";
  level._effect["jump_pad_jump"] = "dlc5/moon/fx_moon_jump_pad_pulse";
  level._effect["perk_machine_light_yellow"] = "dlc5/zmhd/fx_wonder_fizz_light_yellow";
  level._effect["perk_machine_light_red"] = "dlc5/zmhd/fx_wonder_fizz_light_red";
  level._effect["perk_machine_light_green"] = "dlc5/zmhd/fx_wonder_fizz_light_green";
}

function precache_createfx_fx() {
  level._effect["fx_mp_fog_xsm_int"] = "maps/zombie_old/fx_mp_fog_xsm_int";
  level._effect["fx_moon_fog_spawn_closet"] = "maps/zombie_moon/fx_moon_fog_spawn_closet";
  level._effect["fx_zmb_fog_thick_300x300"] = "maps/zombie/fx_zmb_fog_thick_300x300";
  level._effect["fx_zmb_fog_thick_600x600"] = "maps/zombie/fx_zmb_fog_thick_600x600";
  level._effect["fx_moon_fog_canyon"] = "maps/zombie_moon/fx_moon_fog_canyon";
  level._effect["fx_moon_vent_wall_mist"] = "maps/zombie_moon/fx_moon_vent_wall_mist";
  level._effect["fx_dust_motes_blowing"] = "env/debris/fx_dust_motes_blowing";
  level._effect["fx_zmb_coast_sparks_int_runner"] = "maps/zombie/fx_zmb_coast_sparks_int_runner";
  level._effect["fx_moon_floodlight_narrow"] = "maps/zombie_moon/fx_moon_floodlight_narrow";
  level._effect["fx_moon_floodlight_wide"] = "maps/zombie_moon/fx_moon_floodlight_wide";
  level._effect["fx_moon_tube_light"] = "maps/zombie_moon/fx_moon_tube_light";
  level._effect["fx_moon_lamp_glow"] = "maps/zombie_moon/fx_moon_lamp_glow";
  level._effect["fx_moon_trap_switch_light_glow"] = "maps/zombie_moon/fx_moon_trap_switch_light_glow";
  level._effect["fx_moon_teleporter_beam"] = "maps/zombie_moon/fx_moon_teleporter_beam";
  level._effect["fx_moon_teleporter_start"] = "maps/zombie_moon/fx_moon_teleporter_start";
  level._effect["fx_moon_teleporter_pad_start"] = "maps/zombie_moon/fx_moon_teleporter_pad_start";
  level._effect["fx_moon_teleporter2_beam"] = "maps/zombie_moon/fx_moon_teleporter2_beam";
  level._effect["fx_moon_teleporter2_pad_start"] = "maps/zombie_moon/fx_moon_teleporter2_pad_start";
  level._effect["fx_moon_pyramid_egg"] = "maps/zombie_moon/fx_moon_pyramid_egg";
  level._effect["fx_moon_pyramid_drop"] = "maps/zombie_moon/fx_moon_pyramid_drop";
  level._effect["fx_moon_pyramid_opening"] = "maps/zombie_moon/fx_moon_pyramid_opening";
  level._effect["fx_moon_ceiling_cave_dust"] = "maps/zombie_moon/fx_moon_ceiling_cave_dust";
  level._effect["fx_moon_ceiling_cave_collapse"] = "maps/zombie_moon/fx_moon_ceiling_cave_collapse";
  level._effect["fx_moon_digger_dig_dust"] = "maps/zombie_moon/fx_moon_digger_dig_dust";
  level._effect["fx_moon_airlock_hatch_forcefield"] = "maps/zombie_moon/fx_moon_airlock_hatch_forcefield";
  level._effect["fx_moon_biodome_ceiling_breach"] = "maps/zombie_moon/fx_moon_biodome_ceiling_breach";
  level._effect["fx_moon_biodome_breach_dirt"] = "maps/zombie_moon/fx_moon_biodome_breach_dirt";
  level._effect["fx_moon_breach_debris_room_os"] = "maps/zombie_moon/fx_moon_breach_debris_room_os";
  level._effect["fx_moon_breach_debris_out_os"] = "maps/zombie_moon/fx_moon_breach_debris_out_os";
  level._effect["fx_earth_destroyed"] = "maps/zombie_moon/fx_earth_destroyed";
  level._effect["lght_marker_flare"] = "dlc5/zmhd/fx_zombie_coast_marker_fl";
  level._effect["fx_quad_vent_break"] = "maps/zombie/fx_zombie_crawler_vent_break";
}

function power_on_spinning_lights() {
  level waittill("power_on");
}

function trap_fx_monitor(name, side, trap_type) {
  while (true) {
    level waittill(name);
    points = struct::get_array(name, "targetname");
    for (i = 0; i < points.size; i++) {
      points[i] thread electric_trap_fx(name, side, trap_type);
    }
  }
}

function breach_receiving_fx() {
  exploder::exploder("fxexp_300 ");
  if(!level clientfield::get("zombie_power_on")) {
    level util::waittill_any("power_on", "pwr", "ZPO");
  }
  level notify("sl0");
}

function breach_labs_lower_fx() {
  exploder::exploder("fxexp_320");
  if(!level clientfield::get("zombie_power_on")) {
    level util::waittill_any("power_on", "pwr", "ZPO");
  }
  level notify("sl5");
  level notify("sl6");
}

function breach_labs_upper_fx() {
  exploder::exploder("fxexp_340");
  if(!level clientfield::get("zombie_power_on")) {
    level util::waittill_any("power_on", "pwr", "ZPO");
  }
  level notify("sl4");
}

function electric_trap_fx(name, side, trap_type) {
  ang = self.angles;
  forward = anglestoforward(ang);
  up = anglestoup(ang);
  if(isdefined(self.loopfx)) {
    for (i = 0; i < self.loopfx.size; i++) {
      self.loopfx[i] delete();
    }
    self.loopfx = [];
  }
  if(!isdefined(self.loopfx)) {
    self.loopfx = [];
  }
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    switch (trap_type) {
      case "electric": {
        self.loopfx[i] = spawnfx(i, level._effect["zapper"], self.origin, 0, forward, up);
        break;
      }
      case "fire":
      default: {
        self.loopfx[i] = spawnfx(i, level._effect["fire_trap_med"], self.origin, 0, forward, up);
        break;
      }
    }
    triggerfx(self.loopfx[i]);
  }
  level waittill(side + "off");
  for (i = 0; i < self.loopfx.size; i++) {
    self.loopfx[i] delete();
  }
  self.loopfx = [];
}

function moon_fog_triggers_init(localclientnum) {
  exterior_array = getentarray(localclientnum, "zombie_moonExterior", "targetname");
  array::thread_all(exterior_array, & fog_trigger, & moon_exterior_fog_change);
  moon_interior_array = getentarray(localclientnum, "zombie_moonInterior", "targetname");
  array::thread_all(moon_interior_array, & fog_trigger, & moon_interior_fog_change);
  moon_biodome_array = getentarray(localclientnum, "zombie_moonBiodome", "targetname");
  array::thread_all(moon_biodome_array, & fog_trigger, & moon_biodome_fog_change);
  moon_biodome_array = getentarray(localclientnum, "zombie_moonTunnels", "targetname");
  array::thread_all(moon_biodome_array, & fog_trigger, & moon_tunnels_fog_change);
  nml_array = getentarray(localclientnum, "zombie_nmlVision", "targetname");
  if(isdefined(nml_array) && nml_array.size > 0) {
    array::thread_all(nml_array, & fog_trigger, & moon_nml_fog_change);
  }
}

function fog_trigger(change_func) {
  while (true) {
    self waittill("trigger", who);
    if(who islocalplayer()) {
      self thread util::trigger_thread(who, change_func);
    }
  }
}

function moon_exterior_fog_change(ent_player) {
  if(!isdefined(ent_player)) {
    return;
  }
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
  sun_col_b = 0.16;
  sun_dir_x = 0.796421;
  sun_dir_y = 0.425854;
  sun_dir_z = 0.429374;
  sun_start_ang = 0;
  sun_stop_ang = 55;
  time = 0;
  max_fog_opacity = 0.95;
  setclientvolumetricfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
}

function moon_interior_fog_change(ent_player) {
  if(!isdefined(ent_player)) {
    return;
  }
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
  sun_col_b = 0.16;
  sun_dir_x = 0.796421;
  sun_dir_y = 0.425854;
  sun_dir_z = 0.429374;
  sun_start_ang = 0;
  sun_stop_ang = 55;
  time = 0;
  max_fog_opacity = 0.95;
  setclientvolumetricfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
}

function moon_biodome_fog_change(ent_player) {
  if(!isdefined(ent_player)) {
    return;
  }
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
  setclientvolumetricfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
}

function moon_tunnels_fog_change(ent_player) {
  if(!isdefined(ent_player)) {
    return;
  }
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
  setclientvolumetricfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
}

function moon_nml_fog_change(ent_player) {
  if(!isdefined(ent_player) || (isdefined(level._dte_done) && level._dte_done)) {
    return;
  }
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
  setclientvolumetricfog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
}
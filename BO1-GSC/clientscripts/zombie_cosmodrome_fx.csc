/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_cosmodrome_fx.csc
**************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;
#include clientscripts\_music;

main() {
  clientscripts\createfx\zombie_cosmodrome_fx::main();
  clientscripts\_fx::reportNumEffects();
  footsteps();
  precache_scripted_fx();
  precache_util_fx();
  precache_createfx_fx();
  level thread trap_fx_monitor("fire_trap_group1", "f1", "fire");
  level thread trap_fx_monitor("fire_trap_group2", "f2", "fire");
  level thread trap_fx_monitor("rocket_trap_group1", "r1", "fire");
  level thread trap_fx_monitor("rocket_trap_group2", "r2", "fire");
  level thread level_fog_init();
  disableFX = GetDvarInt(#"disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }
  level thread clientscripts\_zombiemode::init_perk_machines_fx();
  level thread lander_dock_lights_red();
  level thread lander_dock_lights_green();
}

footsteps() {}
precache_util_fx() {}
level_fog_init() {
  start_dist = 2013.52;
  half_dist = 2400.04;
  half_height = 640.408;
  base_height = 805;
  fog_r = 0.054902;
  fog_g = 0.0862;
  fog_b = 0.0862;
  fog_scale = 3.29585;
  sun_col_r = 0.341176;
  sun_col_g = 0.368627;
  sun_col_b = 0.388235;
  sun_dir_x = -0.492497;
  sun_dir_y = 0.584479;
  sun_dir_z = 0.64485;
  sun_start_ang = 14.832;
  sun_stop_ang = 113.6;
  time = 0;
  max_fog_opacity = 1;
  setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
}

precache_scripted_fx() {
  level._effect["zombie_power_switch"] = loadfx("maps/zombie/fx_zombie_power_switch");
  level._effect["zapper_light_ready"] = loadfx("misc/fx_zombie_zapper_light_green");
  level._effect["zapper_light_notready"] = loadfx("misc/fx_zombie_zapper_light_red");
  level._effect["eye_glow"] = LoadFx("misc/fx_zombie_eye_single");
  level._effect["zombie_eye_glow"] = level._effect["eye_glow"];
  level._effect["monkey_eye_glow"] = LoadFx("maps/zombie/fx_zmb_monkey_eyes");
  level._effect["fire_trap_cosmo"] = Loadfx("maps/zombie/fx_zmb_cosmo_trap_fire_md");
  level._effect["zapper"] = loadfx("misc/fx_zombie_electric_trap");
  level._effect["wire_spark"] = loadfx("maps/zombie/fx_zombie_wire_spark");
  level._effect["soul_spark"] = loadfx("maps/zombie/fx_zmb_blackhole_zombie_death");
  level._effect["headshot"] = LoadFX("impacts/fx_flesh_hit");
  level._effect["headshot_nochunks"] = LoadFX("misc/fx_zombie_bloodsplat");
  level._effect["bloodspurt"] = LoadFX("misc/fx_zombie_bloodspurt");
  level._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  level._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
  level._effect["lander_green_left"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_green_lft");
  level._effect["lander_green_right"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_green");
  level._effect["lander_red_left"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_red_lft");
  level._effect["lander_red_right"] = loadfx("maps/zombie/fx_zmb_csm_lander_pad_red");
  level._effect["lander_green"] = loadfx("maps/zombie/fx_zmb_csm_lander_post_green");
  level._effect["lander_red"] = loadfx("maps/zombie/fx_zmb_csm_lander_post_red");
  level._effect["rocket_blast_trail"] = loadfx("maps/zombie/fx_russian_rocket_exhaust_zmb");
  level._effect["rocket_exp_1"] = loadfx("maps/zombie/fx_zmb_csm_rocket_exp");
  level._effect["lunar_lander_thruster_bellow"] = loadfx("maps/zombie/fx_zombie_lunar_lander_thruster_bellow");
  level._effect["lunar_lander_thruster_leg"] = loadfx("maps/zombie/fx_zombie_lunar_lander_thruster_leg");
  level._effect["debris_trail"] = loadfx("maps/flashpoint/fx_exp_rocket_debris_trail");
  level._effect["debris_hit"] = loadfx("maps/zombie/fx_zombie_ape_spawn_dust");
  level._effect["mig_trail"] = loadfx("trail/fx_geotrail_jet_contrail");
  level._effect["panel_green"] = LoadFX("maps/zombie/fx_zmb_csm_lander_panel_green");
  level._effect["panel_red"] = LoadFX("maps/zombie/fx_zmb_csm_lander_panel_red");
  level._effect["centrifuge_warning_light"] = LoadFX("maps/zombie/fx_zmb_light_centrifuge_top");
  level._effect["centrifuge_light_spark"] = LoadFX("maps/zombie/fx_zombie_centrifuge_spark");
  level._effect["centrifuge_start_steam"] = LoadFX("maps/zombie/fx_zmb_csm_centrifuge_steam_blst");
  level._effect["test_spin_fx"] = LoadFX("env/light/fx_light_warning");
  level._effect["monkey_spawn"] = loadfx("maps/zombie/fx_zombie_ape_spawn_dust");
  level._effect["monkey_trail"] = loadfx("maps/zombie/fx_zombie_ape_spawn_trail");
}

precache_createfx_fx() {
  level._effect["fx_tower_light_glow"] = loadfx("maps/flashpoint/fx_tower_light_glow");
  level._effect["fx_zombie_rocket_trap_heat_glow"] = loadfx("maps/zombie/fx_zombie_rocket_trap_heat_glow");
  level._effect["fx_zombie_nuke_distant"] = loadfx("maps/zombie/fx_zombie_nuke_distant");
  level._effect["fx_zmb_water_spray_leak_sm"] = loadfx("maps/zombie/fx_zmb_water_spray_leak_sm");
  level._effect["fx_zmb_pipe_steam_md"] = loadfx("maps/zombie/fx_zmb_pipe_steam_md");
  level._effect["fx_zmb_pipe_steam_md_runner"] = loadfx("maps/zombie/fx_zmb_pipe_steam_md_runner");
  level._effect["fx_zmb_steam_hallway_md"] = loadfx("maps/zombie/fx_zmb_steam_hallway_md");
  level._effect["fx_zmb_fog_lit_overhead_amber"] = loadfx("maps/zombie/fx_zmb_fog_lit_overhead_amber");
  level._effect["fx_zmb_fog_thick_300x300"] = loadfx("maps/zombie/fx_zmb_fog_thick_300x300");
  level._effect["fx_zmb_fog_thick_600x600"] = loadfx("maps/zombie/fx_zmb_fog_thick_600x600");
  level._effect["fx_zmb_fog_thick_1200x1200"] = loadfx("maps/zombie/fx_zmb_fog_thick_1200x1200");
  level._effect["fx_zmb_fog_dropdown"] = loadfx("maps/zombie/fx_zmb_fog_dropdown");
  level._effect["fx_zmb_fog_interior_md"] = loadfx("maps/zombie/fx_zmb_fog_interior_md");
  level._effect["fx_zmb_fog_lit_overhead"] = loadfx("maps/zombie/fx_zmb_fog_lit_overhead");
  level._effect["fx_zmb_light_floodlight_bright"] = loadfx("maps/zombie/fx_zmb_light_floodlight_bright");
  level._effect["fx_zmb_light_fluorescent_tube"] = loadfx("maps/zombie/fx_zmb_light_fluorescent_tube");
  level._effect["fx_zmb_light_incandescent"] = loadfx("maps/zombie/fx_zmb_light_incandescent");
  level._effect["fx_zmb_light_square_white"] = loadfx("maps/zombie/fx_zmb_light_square_white");
  level._effect["fx_zmb_light_cagelight01"] = loadfx("maps/zombie/fx_zmb_csm_light_cagelight01");
  level._effect["fx_zmb_light_flashlight"] = loadfx("maps/zombie/fx_zmb_light_flashlight");
  level._effect["fx_light_dust_motes_xsm"] = loadfx("env/light/fx_light_dust_motes_xsm");
  level._effect["fx_zmb_booster_condensation"] = loadfx("maps/zombie/fx_zmb_booster_condensation");
  level._effect["fx_zmb_elec_spark_burst_loop"] = loadfx("maps/zombie/fx_zmb_elec_spark_burst_loop");
  level._effect["fx_zmb_fire_sm_smolder"] = loadfx("maps/zombie/fx_zmb_fire_sm_smolder");
  level._effect["fx_fire_line_xsm"] = loadfx("env/fire/fx_fire_line_xsm");
  level._effect["fx_fire_line_sm"] = loadfx("env/fire/fx_fire_line_sm");
  level._effect["fx_fire_wall_back_sm"] = loadfx("env/fire/fx_fire_wall_back_sm");
  level._effect["fx_fire_destruction_lg"] = loadfx("env/fire/fx_fire_destruction_lg");
  level._effect["fx_zmb_smk_linger_lit"] = loadfx("maps/zombie/fx_zmb_smk_linger_lit");
  level._effect["fx_zmb_smk_plume_md_wht_wispy"] = loadfx("maps/zombie/fx_zmb_smk_plume_md_wht_wispy");
  level._effect["fx_smk_fire_md_black"] = loadfx("env/smoke/fx_smk_fire_md_black");
  level._effect["fx_ship_smk_fire_xlg_black"] = loadfx("maps/underwaterbase/fx_ship_smk_fire_xlg_black");
  level._effect["fx_zmb_pad_light"] = loadfx("maps/zombie/fx_zmb_csm_rocket_pad_light");
  level._effect["fx_zmb_gantry_coolant_md"] = loadfx("maps/zombie/fx_zmb_gantry_coolant_md");
  level._effect["fx_elec_terminal"] = loadfx("maps/zombie/fx_zmb_elec_terminal_arc");
  level._effect["fx_zmb_elec_terminal_bridge"] = loadfx("maps/zombie/fx_zmb_elec_terminal_bridge");
  level._effect["fx_zmb_russian_rocket_smk"] = loadfx("maps/zombie/fx_zmb_russian_rocket_smk");
}

trap_fx_monitor(name, loc, trap_type) {
  structs = getstructarray(name, "targetname");
  points = [];
  for(i = 0; i < structs.size; i++) {
    if(!isDefined(structs[i].model)) {
      points[points.size] = structs[i];
    }
  }
  while(1) {
    level waittill(loc + "1");
    for(i = 0; i < points.size; i++) {
      points[i] thread trap_play_fx(loc, trap_type);
    }
  }
}

trap_play_fx(loc, trap_type) {
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
  fx_name = "";
  if(isDefined(self.script_string)) {
    fx_name = self.script_string;
  } else {
    switch (trap_type) {
      case "electric":
        fx_name = "zapper";
        break;
      default:
      case "fire":
        fx_name = "fire_trap_cosmo";
        break;
    }
  }
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    self.loopFX[i] = SpawnFx(i, level._effect[fx_name], self.origin, 0, forward, up);
    triggerfx(self.loopFX[i]);
  }
  level waittill(loc + "0");
  for(i = 0; i < self.loopFX.size; i++) {
    self.loopFX[i] delete();
  }
  self.loopFX = [];
}

lander_dock_lights_red() {
  while(1) {
    level waittill("L_R");
    toggle_lander_lights("red");
  }
}

lander_dock_lights_green() {
  while(1) {
    level waittill("L_G");
    toggle_lander_lights("green");
  }
}

toggle_lander_lights(color) {
  right_fx = level._effect["lander_green_right"];
  left_fx = level._effect["lander_green_left"];
  if(color == "red") {
    right_fx = level._effect["lander_red_right"];
    left_fx = level._effect["lander_red_left"];
  }
  players = getLocalPlayers();
  for(x = 0; x < players.size; x++) {
    doors1 = getEntArray(x, "centrifuge_zip_door", "targetname");
    doors2 = getEntArray(x, "base_entry_zip_door", "targetname");
    doors3 = getEntArray(x, "storage_zip_door", "targetname");
    doors4 = getEntArray(x, "catwalk_zip_door", "targetname");
    doorsa = array_combine(doors1, doors2);
    doorsb = array_combine(doors3, doors4);
    all_doors = array_combine(doorsa, doorsb);
    for(i = 0; i < all_doors.size; i++) {
      if(all_doors[i].model == "p_zom_lander_doors_right") {
        if(isDefined(all_doors[i].fx)) {
          StopFX(x, all_doors[i].fx);
        }
        all_doors[i].fx = playFXOnTag(x, right_fx, all_doors[i], "tag_origin");
      } else if(all_doors[i].model == "p_zom_lander_doors_left") {
        if(isDefined(all_doors[i].fx)) {
          StopFX(x, all_doors[i].fx);
        }
        all_doors[i].fx = playFXOnTag(x, left_fx, all_doors[i], "tag_origin");
      }
    }
  }
}
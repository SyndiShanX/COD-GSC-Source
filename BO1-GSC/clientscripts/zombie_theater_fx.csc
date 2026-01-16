/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_theater_fx.csc
***********************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;
#include clientscripts\_music;

main() {
  clientscripts\createfx\zombie_theater_fx::main();
  clientscripts\_fx::reportNumEffects();
  precache_util_fx();
  precache_createfx_fx();
  disableFX = GetDvarInt(#"disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }
  level thread clientscripts\_zombiemode::init_perk_machines_fx();
  level thread trap_fx_monitor("dressing_room_trap", "e4", "electric");
  level thread trap_fx_monitor("vip_room_trap", "e2", "electric");
  level thread trap_fx_monitor("foyer_room_trap", "e1", "electric");
  level thread trap_fx_monitor("control_room_trap", "e3", "electric");
  level thread trap_fx_monitor("crematorium_room_trap", "f1", "fire");
  level thread light_model_swap("smodel_light_electric", "lights_indlight_on");
  level thread dog_start_monitor();
  level thread dog_stop_monitor();
  level thread level_fog_init();
  level thread projector_screen_fx();
}

precache_util_fx() {}
precache_scripted_fx() {
  level._effect["eye_glow"] = LoadFx("misc/fx_zombie_eye_single");
  level._effect["boxlight_light_ready"] = loadfx("maps/zombie/fx_zombie_theater_lightboard_green");
  level._effect["boxlight_light_notready"] = loadfx("maps/zombie/fx_zombie_theater_lightboard_red");
  level._effect["theater_projector_beam"] = loadfx("maps/zombie/fx_zombie_theater_projector_beam");
  level._effect["projector_screen_0"] = LoadFX("maps/zombie/fx_zombie_theater_screen_0");
  level._effect["ps1"] = LoadFX("maps/zombie/fx_zombie_theater_screen_1");
  level._effect["ps2"] = LoadFX("maps/zombie/fx_zombie_theater_screen_2");
  level._effect["ps3"] = LoadFX("maps/zombie/fx_zombie_theater_screen_3");
  level._effect["headshot"] = LoadFX("impacts/fx_flesh_hit");
  level._effect["headshot_nochunks"] = LoadFX("misc/fx_zombie_bloodsplat");
  level._effect["bloodspurt"] = LoadFX("misc/fx_zombie_bloodspurt");
  level._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  level._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
}

precache_createfx_fx() {
  level._effect["fx_mp_smoke_thick_indoor"] = loadfx("maps/zombie/fx_mp_smoke_thick_indoor");
  level._effect["fx_mp_smoke_amb_indoor_misty"] = loadfx("maps/zombie/fx_zombie_theater_smoke_amb_indoor");
  level._effect["fx_smoke_smolder_md_gry"] = loadfx("maps/zombie/fx_smoke_smolder_md_gry");
  level._effect["fx_smk_smolder_sm"] = loadfx("env/smoke/fx_smk_smolder_sm");
  level._effect["fx_mp_smoke_crater"] = loadfx("maps/zombie/fx_mp_smoke_crater");
  level._effect["fx_mp_smoke_sm_slow"] = loadfx("maps/zombie/fx_mp_smoke_sm_slow");
  level._effect["fx_mp_fog_low"] = loadfx("maps/zombie/fx_mp_fog_low");
  level._effect["fx_zombie_theater_fog_lg"] = loadfx("maps/zombie/fx_zombie_theater_fog_lg");
  level._effect["fx_zombie_theater_fog_xlg"] = loadfx("maps/zombie/fx_zombie_theater_fog_xlg");
  level._effect["fx_mp_fog_ground_md"] = loadfx("maps/mp_maps/fx_mp_fog_ground_md");
  level._effect["fx_water_drip_light_long"] = loadfx("env/water/fx_water_drip_light_long");
  level._effect["fx_water_drip_light_short"] = loadfx("env/water/fx_water_drip_light_short");
  level._effect["fx_mp_ray_light_sm"] = loadfx("env/light/fx_light_godray_overcast_sm");
  level._effect["fx_mp_ray_light_md"] = loadfx("maps/zombie/fx_mp_ray_overcast_md");
  level._effect["fx_mp_ray_light_lg"] = loadfx("maps/zombie/fx_light_godray_overcast_lg");
  level._effect["fx_mp_dust_motes"] = loadfx("maps/zombie/fx_mp_ray_motes_lg");
  level._effect["fx_mp_dust_mote_pcloud_sm"] = loadfx("maps/zombie/fx_mp_dust_mote_pcloud_sm");
  level._effect["fx_mp_dust_mote_pcloud_md"] = loadfx("maps/zombie/fx_mp_dust_mote_pcloud_md");
  level._effect["fx_mp_pipe_steam"] = loadfx("env/smoke/fx_pipe_steam_md");
  level._effect["fx_mp_pipe_steam_random"] = loadfx("maps/zombie/fx_mp_pipe_steam_random");
  level._effect["fx_mp_fumes_vent_sm_int"] = loadfx("maps/mp_maps/fx_mp_fumes_vent_sm_int");
  level._effect["fx_mp_fumes_vent_xsm_int"] = loadfx("maps/mp_maps/fx_mp_fumes_vent_xsm_int");
  level._effect["fx_mp_elec_spark_burst_xsm_thin_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_xsm_thin_runner");
  level._effect["fx_mp_elec_spark_burst_sm_runner"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_sm_runner");
  level._effect["fx_mp_light_lamp"] = loadfx("maps/zombie/fx_mp_light_lamp");
  level._effect["fx_mp_light_corona_cool"] = loadfx("maps/zombie/fx_mp_light_corona_cool");
  level._effect["fx_mp_light_corona_bulb_ceiling"] = loadfx("maps/zombie/fx_mp_light_corona_bulb_ceiling");
  level._effect["fx_pent_tinhat_light"] = LoadFX("maps/pentagon/fx_pent_tinhat_light");
  level._effect["fx_light_floodlight_bright"] = loadfx("maps/zombie/fx_zombie_light_floodlight_bright");
  level._effect["fx_light_overhead_sm_amber"] = loadfx("maps/zombie/fx_zombie_overhead_sm_amber");
  level._effect["fx_light_overhead_sm_amber_flkr"] = loadfx("maps/zombie/fx_zombie_overhead_sm_amber_flkr");
  level._effect["fx_light_overhead_sm_blue"] = loadfx("maps/zombie/fx_zombie_overhead_sm_blu");
  level._effect["fx_light_overhead_sm_blue_flkr"] = loadfx("maps/zombie/fx_zombie_overhead_sm_blu_flkr");
  level._effect["fx_mp_birds_circling"] = loadfx("maps/zombie/fx_mp_birds_circling");
  level._effect["fx_mp_insects_lantern"] = loadfx("maps/zombie/fx_mp_insects_lantern");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_insects_maggots"] = loadfx("bio/insects/fx_insects_maggots_sm");
  level._effect["fx_insects_moths_light_source"] = loadfx("bio/insects/fx_insects_moths_light_source");
  level._effect["fx_insects_moths_light_source_md"] = loadfx("bio/insects/fx_insects_moths_light_source_md");
  level._effect["fx_pent_movie_projector"] = LoadFX("maps/pentagon/fx_pent_movie_projector");
  level._effect["fx_zombie_light_theater_blue"] = LoadFX("maps/zombie/fx_zombie_light_theater_blue");
  level._effect["fx_zombie_light_theater_green"] = LoadFX("maps/zombie/fx_zombie_light_theater_green");
  level._effect["fx_zombie_theater_projector_beam"] = loadfx("maps/zombie/fx_zombie_theater_projector_beam");
  level._effect["fx_zombie_theater_projector_screen"] = loadfx("maps/zombie/fx_zombie_theater_projection_screen");
  level._effect["fx_transporter_beam"] = loadfx("maps/zombie/fx_transporter_beam");
  level._effect["fx_transporter_pad_start"] = loadfx("maps/zombie/fx_transporter_pad_start");
  level._effect["fx_transporter_start"] = loadfx("maps/zombie/fx_transporter_start");
  level._effect["fx_transporter_ambient"] = loadfx("maps/zombie/fx_transporter_ambient");
  level._effect["fx_zombie_mainframe_beam"] = loadfx("maps/zombie/fx_zombie_mainframe_beam");
  level._effect["fx_zombie_mainframe_flat"] = loadfx("maps/zombie/fx_zombie_mainframe_flat");
  level._effect["fx_zombie_mainframe_flat_start"] = loadfx("maps/zombie/fx_zombie_mainframe_flat_start");
  level._effect["fx_zombie_mainframe_beam_start"] = loadfx("maps/zombie/fx_zombie_mainframe_beam_start");
  level._effect["fx_zombie_flashback_theater"] = loadfx("maps/zombie/fx_zombie_flashback_theater");
  level._effect["fx_zombie_difference"] = loadfx("maps/zombie/fx_zombie_difference");
  level._effect["fx_zombie_heat_sink"] = loadfx("maps/zombie/fx_zombie_heat_sink");
  level._effect["zapper"] = loadfx("misc/fx_zombie_electric_trap");
  level._effect["switch_sparks"] = loadfx("env/electrical/fx_elec_wire_spark_burst");
  level._effect["fire_trap_med"] = loadfx("maps/zombie/fx_zombie_fire_trap_med");
  level._effect["fx_quad_roof_break"] = loadfx("maps/zombie/fx_zombie_crawler_roof_break");
  level._effect["fx_quad_roof_break_theater"] = loadfx("maps/zombie/fx_zombie_crawler_roof_theater");
  level._effect["fx_quad_dust_roof"] = loadfx("maps/zombie/fx_zombie_crawler_dust_roof");
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
  forward = anglestoforward(ang);
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
        fx_name = "fire_trap_med";
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

light_model_swap(name, model) {
  level waittill("pl1");
  players = getLocalPlayers();
  for(p = 0; p < players.size; p++) {
    lamps = GetEntArray(p, name, "targetname");
    for(i = 0; i < lamps.size; i++) {
      lamps[i] setModel(model);
    }
  }
}

projector_screen_fx() {
  projector_struct = getstruct("struct_theater_projector_beam", "targetname");
  projector_ang = projector_struct.angles;
  projector_up = AnglesToUp(projector_ang);
  projector_forward = AnglesToForward(projector_ang);
  screen_struct = getstruct("struct_theater_screen", "targetname");
  screen_ang = screen_struct.angles;
  screen_up = AnglesToUp(screen_ang);
  screen_forward = AnglesToForward(screen_ang);
  projector_struct.screen_beam = [];
  projector_struct.vid = [];
  if(!isDefined(screen_struct.script_string)) {
    screen_struct.script_string = "ps0";
  }
  level waittill("sip");
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    projector_struct.screen_beam[i] = spawn(i, projector_struct.origin, "script_model");
    projector_struct.screen_beam[i].angles = projector_struct.angles;
    projector_struct.screen_beam[i] setModel("tag_origin");
    PlayFXOnTag(i, level._effect["theater_projector_beam"], projector_struct.screen_beam[i], "tag_origin");
  }
  for(i = 0; i < players.size; i++) {
    projector_struct.vid[i] = spawn(i, screen_struct.origin, "script_model");
    projector_struct.vid[i].angles = screen_struct.angles;
    projector_struct.vid[i] setModel("tag_origin");
    PlayFXOnTag(i, level._effect["projector_screen_0"], projector_struct.vid[i], "tag_origin");
  }
  projector_reel_change_init(projector_struct);
}

projector_reel_change_init(struct_projector) {
  level thread projector_reel_swap(struct_projector, "ps1");
  level thread projector_reel_swap(struct_projector, "ps2");
  level thread projector_reel_swap(struct_projector, "ps3");
}

projector_reel_swap(struct_screen, str_clientnotify) {
  level waittill(str_clientnotify);
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(struct_screen.vid[i])) {
      PlayFXOnTag(i, level._effect[str_clientnotify], struct_screen.vid[i], "tag_origin");
    }
  }
}

dog_start_monitor() {
  while(1) {
    level waittill("dog_start");
    start_dist = 0;
    half_dist = 302.622;
    half_height = 306.395;
    base_height = 344.622;
    fog_r = 0.458824;
    fog_g = 0.556863;
    fog_b = 0.619608;
    fog_scale = 1;
    sun_col_r = 0.243137;
    sun_col_g = 0.270588;
    sun_col_b = 0.270588;
    sun_dir_x = 0.291692;
    sun_dir_y = -0.720765;
    sun_dir_z = 0.628819;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 7;
    max_fog_opacity = 0.65;
    setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}

dog_stop_monitor() {
  while(1) {
    level waittill("dog_stop");
    start_dist = 155.625;
    half_dist = 2332.79;
    half_height = 677.241;
    base_height = 23.2733;
    fog_r = 0.639216;
    fog_g = 0.639216;
    fog_b = 0.639216;
    fog_scale = 1;
    sun_col_r = 0.243137;
    sun_col_g = 0.270588;
    sun_col_b = 0.270588;
    sun_dir_x = 0.291692;
    sun_dir_y = -0.720765;
    sun_dir_z = 0.628819;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 7;
    max_fog_opacity = 1;
    setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}

level_fog_init() {
  start_dist = 155.625;
  half_dist = 2332.79;
  half_height = 677.241;
  base_height = 23.2733;
  fog_r = 0.639216;
  fog_g = 0.639216;
  fog_b = 0.639216;
  fog_scale = 1;
  sun_col_r = 0.243137;
  sun_col_g = 0.270588;
  sun_col_b = 0.270588;
  sun_dir_x = 0.291692;
  sun_dir_y = -0.720765;
  sun_dir_z = 0.628819;
  sun_start_ang = 0;
  sun_stop_ang = 0;
  time = 0.1;
  max_fog_opacity = 1;
  setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
    sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
    sun_stop_ang, time, max_fog_opacity);
}
/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_coast_fx.csc
*********************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;
#include clientscripts\_music;

main() {
  clientscripts\createfx\zombie_coast_fx::main();
  clientscripts\_fx::reportNumEffects();
  footsteps();
  precache_scripted_fx();
  precache_util_fx();
  precache_createfx_fx();
  disableFX = GetDvarInt(#"disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }
  level thread manage_player_rain();
  level thread clientscripts\_zombiemode::init_perk_machines_fx();
  level.blizzard = false;
}

footsteps() {}
precache_util_fx() {}
precache_scripted_fx() {
  level._effect["eye_glow"] = LoadFx("misc/fx_zombie_eye_single");
  level._effect["player_rain"] = loadfx("maps/zombie/fx_zombie_coast_snow_oneshot");
  level._effect["headshot"] = LoadFX("impacts/fx_flesh_hit");
  level._effect["headshot_nochunks"] = LoadFX("misc/fx_zombie_bloodsplat");
  level._effect["bloodspurt"] = LoadFX("misc/fx_zombie_bloodspurt");
  level._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  level._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
  level._effect["buff_electrified"] = LoadFX("maps/zombie/fx_zmb_coast_electrified_torso");
  level._effect["lighthouse_morse_code"] = LoadFX("maps/zombie/fx_zmb_coast_morse_code");
  level._effect["waterfreeze"] = LoadFX("maps/zombie/fx_zmb_coast_waterfreeze_lower_body");
  level._effect["flare"] = LoadFX("maps/zombie/fx_zmb_coast_flare");
  level._effect["flare_no_dlight"] = LoadFX("maps/zombie/fx_zmb_coast_flare_no_dlight");
}

precache_createfx_fx() {
  level._effect["fx_zombie_boss_water_intro"] = loadfx("maps/zombie/fx_zombie_boss_water_intro");
  level._effect["fx_zombie_boss_water_boil"] = loadfx("maps/zombie/fx_zombie_boss_water_boil");
  level._effect["fx_zombie_boss_water_boil_sm"] = loadfx("maps/zombie/fx_zombie_boss_water_boil_sm");
  level._effect["fx_zmb_coast_spotlight_main"] = loadfx("maps/zombie/fx_zmb_coast_spotlight_main");
  level._effect["fx_zmb_coast_spotlight_burst"] = loadfx("maps/zombie/fx_zmb_coast_spotlight_burst");
  level._effect["fx_fire_line_xsm"] = loadfx("env/fire/fx_fire_line_xsm");
  level._effect["fx_zmb_coast_sparks_int_runner"] = loadfx("maps/zombie/fx_zmb_coast_sparks_int_runner");
  level._effect["fx_zmb_coast_packapunch"] = loadfx("maps/zombie/fx_zmb_coast_packapunch");
  level._effect["fx_zmb_coast_packapunch_rising"] = loadfx("maps/zombie/fx_zmb_coast_packapunch_rising");
  level._effect["fx_zmb_coast_spotlight_packapunch"] = loadfx("maps/zombie/fx_zmb_coast_spotlight_packapunch");
  level._effect["fx_zmb_coast_spotlight_pap_202"] = loadfx("maps/zombie/fx_zmb_coast_spotlight_pap_202");
  level._effect["fx_zmb_coast_ray_moon_md"] = loadfx("maps/zombie/fx_zmb_coast_ray_moon_md");
  level._effect["fx_zmb_coast_ray_moon_lg"] = loadfx("maps/zombie/fx_zmb_coast_ray_moon_lg");
  level._effect["fx_zmb_coast_light_floodlight"] = loadfx("maps/zombie/fx_zmb_coast_light_floodlight");
  level._effect["fx_zmb_coast_light_tinhat_cage"] = loadfx("maps/zombie/fx_zmb_coast_light_tinhat_cage");
  level._effect["fx_zmb_coast_perk_dlight"] = loadfx("maps/zombie/fx_zmb_coast_perk_dlight");
  level._effect["fx_light_bulb_incandescent_red"] = loadfx("env/light/fx_light_bulb_incandescent_red");
  level._effect["fx_light_bulb_incandescent"] = loadfx("env/light/fx_light_bulb_incandescent");
  level._effect["fx_zmb_coast_light_lantern"] = loadfx("maps/zombie/fx_zmb_coast_light_lantern");
  level._effect["zombie_coast_snow_med"] = loadfx("maps/zombie/fx_zombie_coast_snow_med");
  level._effect["fx_zmb_coast_blizzard_med"] = loadfx("maps/zombie/fx_zmb_coast_blizzard_med");
  level._effect["fx_zmb_coast_snow_gust_xsm"] = loadfx("maps/zombie/fx_zmb_coast_snow_gust_xsm");
  level._effect["fx_zmb_coast_snow_gust_sml"] = loadfx("maps/zombie/fx_zmb_coast_snow_gust_sml");
  level._effect["fx_zmb_coast_snow_gust_med"] = loadfx("maps/zombie/fx_zmb_coast_snow_gust_med");
  level._effect["fx_zmb_coast_snow_gust_vertical"] = loadfx("maps/zombie/fx_zmb_coast_snow_gust_vertical");
  level._effect["fx_zmb_coast_snow_window"] = loadfx("maps/zombie/fx_zmb_coast_snow_window");
  level._effect["fx_zmb_coast_snowfall_entrance_lrg"] = loadfx("maps/zombie/fx_zmb_coast_snowfall_entrance_lrg");
  level._effect["fx_zmb_coast_snowfall_ledge"] = loadfx("maps/zombie/fx_zmb_coast_snowfall_ledge");
  level._effect["fx_zmb_coast_cloud_1"] = loadfx("maps/zombie/fx_zmb_coast_cloud_1");
  level._effect["fx_zmb_coast_cloud_2"] = loadfx("maps/zombie/fx_zmb_coast_cloud_2");
  level._effect["fx_zmb_coast_lightning_burst"] = loadfx("maps/zombie/fx_zmb_coast_lightning_burst");
  level._effect["fx_zmb_coast_lightning_d_light"] = loadfx("maps/zombie/fx_zmb_coast_lightning_d_light");
  level._effect["fx_lightning_flash_single_md"] = loadfx("env/weather/fx_lightning_flash_single_md");
  level._effect["fx_zmb_coast_lightning_intro_xlg"] = loadfx("maps/zombie/fx_zmb_coast_lightning_intro_xlg");
  level._effect["fx_zmb_coast_interior_fog"] = loadfx("maps/zombie/fx_zmb_coast_interior_fog");
  level._effect["fx_zmb_coast_corridor_fog"] = loadfx("maps/zombie/fx_zmb_coast_corridor_fog");
  level._effect["fx_zmb_coast_offshore_fog_1"] = loadfx("maps/zombie/fx_zmb_coast_offshore_fog_1");
  level._effect["fx_zmb_coast_beam_submarine"] = loadfx("maps/zombie/fx_zmb_coast_beam_submarine");
  level._effect["fx_zmb_coast_beam_vert_shaft"] = loadfx("maps/zombie/fx_zmb_coast_beam_vert_shaft");
  level._effect["fx_zmb_coast_sacrifice_flash"] = loadfx("maps/zombie/fx_zmb_coast_sacrifice_flash");
  level._effect["fx_zmb_coast_vault_door_glow"] = loadfx("maps/zombie/fx_zmb_coast_vault_door_glow");
  level._effect["fx_zmb_coast_dest_fuse_box"] = loadfx("maps/zombie/fx_zmb_coast_dest_fuse_box");
}

manage_player_rain() {
  while(1) {
    time = RandomFloat(10, 30);
    thread start_player_rain();
    realwait(time);
    level notify("stop_player_rain");
    time = RandomFloat(10, 30);
    realwait(time);
  }
}

start_player_rain() {
  level endon("stop_player_rain");
  players = getLocalPlayers();
  while(1) {
    if(isDefined(players[0])) {
      playFXOnTag(0, level._effect["player_rain"], players[0], "tag_origin");
    }
    realwait(0.3);
  }
  realwait(0.05);
}

coast_fog_triggers_init(localClientNum) {
  lighthouse_array = getEntArray(localClientNum, "lighthouseFog_interior", "targetname");
  array_thread(lighthouse_array, ::fog_trigger, ::lighthouse_fog_change, 1);
  shipfront_array = getEntArray(localClientNum, "shipFrontDeck_interior", "targetname");
  array_thread(shipfront_array, ::fog_trigger, ::shipfront_fog_change, 2);
  shipback_array = getEntArray(localClientNum, "shipMedium_interior", "targetname");
  array_thread(shipback_array, ::fog_trigger, ::shipback_fog_change, 3);
  shipback_array = getEntArray(localClientNum, "shipIce_interior", "targetname");
  array_thread(shipback_array, ::fog_trigger, ::shipIce_fog_change, 4);
  exterior_array = getEntArray(localClientNum, "exteriorfog_trigger", "targetname");
  array_thread(exterior_array, ::fog_trigger, ::exterior_fog_change, 0);
}

fog_trigger(change_func, inside_val) {
  while(1) {
    self waittill("trigger", who);
    who.inside = inside_val;
    if(who IsLocalPlayer()) {
      self thread trigger_thread(who, change_func);
    }
  }
}

exterior_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  ent_player endon("entityshutdown");
  if(level.blizzard == true) {
    start_dist = 120;
    half_dist = 250;
    half_height = 700.242;
    base_height = 976.119;
    fog_r = 0.137255;
    fog_g = 0.192157;
    fog_b = 0.239216;
    fog_scale = 7;
    sun_col_r = 0.760784;
    sun_col_g = 0.796079;
    sun_col_b = 0.807843;
    sun_dir_x = -0.862899;
    sun_dir_y = 0.264579;
    sun_dir_z = 0.430586;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 10;
    max_fog_opacity = 1;
    setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}

lighthouse_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  ent_player endon("entityshutdown");
  if(level.blizzard == true) {
    start_dist = 251.982;
    half_dist = 700;
    half_height = 697.379;
    base_height = 1000.6;
    fog_r = 0.235294;
    fog_g = 0.290196;
    fog_b = 0.337255;
    fog_scale = 10;
    sun_col_r = 0.760784;
    sun_col_g = 0.796079;
    sun_col_b = 0.807843;
    sun_dir_x = -0.862899;
    sun_dir_y = 0.264579;
    sun_dir_z = 0.430586;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 10;
    max_fog_opacity = 0.97;
    setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}

shipfront_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  ent_player endon("entityshutdown");
  if(level.blizzard == true) {
    start_dist = 80;
    half_dist = 1700;
    half_height = 697.379;
    base_height = 1000.6;
    fog_r = 0.235294;
    fog_g = 0.290196;
    fog_b = 0.337255;
    fog_scale = 10;
    sun_col_r = 0.760784;
    sun_col_g = 0.796079;
    sun_col_b = 0.807843;
    sun_dir_x = -0.862899;
    sun_dir_y = 0.264579;
    sun_dir_z = 0.430586;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 10;
    max_fog_opacity = 0.97;
    setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}

shipback_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  ent_player endon("entityshutdown");
  if(level.blizzard == true) {
    start_dist = 251.982;
    half_dist = 700;
    half_height = 697.379;
    base_height = 1000.6;
    fog_r = 0.235294;
    fog_g = 0.290196;
    fog_b = 0.337255;
    fog_scale = 10;
    sun_col_r = 0.760784;
    sun_col_g = 0.796079;
    sun_col_b = 0.807843;
    sun_dir_x = -0.862899;
    sun_dir_y = 0.264579;
    sun_dir_z = 0.430586;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 10;
    max_fog_opacity = 0.97;
    setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}

shipIce_fog_change(ent_player) {
  if(!isDefined(ent_player)) {
    return;
  }
  ent_player endon("entityshutdown");
  if(level.blizzard == true) {
    start_dist = 220;
    half_dist = 2300;
    half_height = 697.379;
    base_height = 1000.6;
    fog_r = 0.235294;
    fog_g = 0.290196;
    fog_b = 0.337255;
    fog_scale = 10;
    sun_col_r = 0.760784;
    sun_col_g = 0.796079;
    sun_col_b = 0.807843;
    sun_dir_x = -0.862899;
    sun_dir_y = 0.264579;
    sun_dir_z = 0.430586;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 10;
    max_fog_opacity = 0.97;
    setVolFogForClient(ent_player GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}

coast_fog_blizzard(localClientNum, set, newEnt) {
  if(!self isLocalPlayer()) {
    return;
  }
  if(!isDefined(self GetLocalClientNumber())) {
    return;
  }
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    level.blizzard = true;
    if(isDefined(self.inside) && self.inside == 1) {
      println("*** Client :(fog) blizzard started while inside lighthouse");
      lighthouse_fog_change(self);
    } else if(isDefined(self.inside) && self.inside == 2) {
      println("*** Client :(fog) blizzard started while inside shipfront");
      shipfront_fog_change(self);
    } else if(isDefined(self.inside) && self.inside == 3) {
      println("*** Client :(fog) blizzard started while inside shipback");
      shipback_fog_change(self);
    } else if(isDefined(self.inside) && self.inside == 4) {
      println("*** Client :(fog) blizzard started while inside shipback");
      shipIce_fog_change(self);
    } else {
      println("*** Client :(fog) blizzard started while outside");
      exterior_fog_change(self);
    }
  } else {
    level.blizzard = false;
    start_dist = 500;
    half_dist = 1700;
    half_height = 697.379;
    base_height = 1000.6;
    fog_r = 0.235294;
    fog_g = 0.290196;
    fog_b = 0.337255;
    fog_scale = 10;
    sun_col_r = 0.760784;
    sun_col_g = 0.796079;
    sun_col_b = 0.807843;
    sun_dir_x = -0.862899;
    sun_dir_y = 0.264579;
    sun_dir_z = 0.430586;
    sun_start_ang = 0;
    sun_stop_ang = 0;
    time = 10;
    max_fog_opacity = 1;
    setVolFogForClient(self GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
      sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
      sun_stop_ang, time, max_fog_opacity);
  }
}
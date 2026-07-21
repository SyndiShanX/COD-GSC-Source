/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\embassy\embassy_lighting.gsc
************************************************/

main() {
  precachemodel("me_lighting_fixtures_commercial_fluorescent_sign_01_off");
  scripts\engine\utility::flag_init("bpg_combat_closet_fire_trigger");
  scripts\engine\utility::flag_init("heli_crash_light_flicker");
  scripts\engine\utility::flag_init("sun_shadow");
  scripts\engine\utility::flag_init("heli_door");
  scripts\engine\utility::flag_init("garage_shadow_distcull");
  scripts\engine\utility::flag_init("spot_dist_cull_field");
  scripts\engine\utility::flag_init("lt_offices");
  scripts\engine\utility::flag_init("lt_stairwell_upper");
  scripts\engine\utility::flag_init("lt_stairwell_lower");
  scripts\engine\utility::flag_init("lt_bpg_metal_detectors");
  scripts\engine\utility::flag_init("lt_bpg_scene");
  scripts\engine\utility::flag_init("lt_bpg_scene_exit");
  scripts\engine\utility::flag_init("lt_truck_office_enter");
  scripts\engine\utility::flag_init("lt_truck_office");
  scripts\engine\utility::flag_init("lt_bpg_combat");
  scripts\engine\utility::flag_init("lt_basement");
  scripts\engine\utility::flag_init("lt_saferoom");
  scripts\engine\utility::flag_init("lt_garage");
  scripts\engine\utility::flag_init("lt_garage_exit");
  scripts\engine\utility::flag_init("lt_alley_heli_crash");
  scripts\engine\utility::flag_init("lt_alley_enter");
  scripts\engine\utility::flag_init("lt_alley");
  scripts\engine\utility::flag_init("lt_triage_scene");
  scripts\engine\utility::flag_init("lt_compound_residence");
  scripts\engine\utility::flag_init("lt_compound_residence_exit");
  scripts\engine\utility::flag_init("offices_level_04_strobe");
  scripts\engine\utility::flag_init("bpg_metal_detectors_strobe");
  scripts\engine\utility::flag_init("bpg_truck_office_warning_light");
  thread all_lights_off();
  thread garage_door_lights_off();
  thread field_lights();
  init_tree_fire_light();
  thread setup_stair_b();
  thread bpg_combat_window_exterior_light_on_and_off();
  thread spotcull_mortar_and_triage();
  thread mortar_wave_settings();
  thread heli_crash_fire_lights();
  thread offices();
  thread stairwell_upper();
  thread stairwell_lower();
  thread bpg_metal_detectors();
  thread bpg_scene();
  thread bpg_scene_exit();
  thread truck_office_enter();
  thread truck_office();
  thread bpg_combat();
  thread basement();
  thread saferoom();
  thread garage();
  thread garage_exit();
  thread alley_heli_crash();
  thread alley_enter();
  thread alley();
  thread compound_residence();
  thread compound_residence_exit();
  thread mortar_moment();
  thread triage_scene();
  scripts\engine\sp\utility::post_load_precache(::post_load);
}

post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  thread lighting_setup_dvars();
}

lighting_setup_dvars() {
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  setsaveddvar("LTQMSPKRKO", 6);
  level.spotupdatelimit = getdvarint("LTQMSPKRKO");
  setsaveddvar("MROOOROPKL", 8);
  level.roundrobinlimit = getdvarint("MROOOROPKL");
  setsaveddvar("LKOLRONRNQ", 750);
  level.spotdistcull = getdvarint("LKOLRONRNQ");
  setsaveddvar("MNQKPNLOPT", 1);
  setsaveddvar("NRSOTSLSSO", 1);
}

lt_truck_crash_start() {
  thread truck_wreck_mb();
  thread truck_wreck_vision();
  level.truck_crash_wall_hole_light setlightintensity(70.0);
  scripts\engine\utility::flag_set("bpg_truck_office_warning_light");
}

truck_wreck_mb() {
  scripts\engine\sp\utility::motion_blur_enable(2.5, 1);
  wait 2.0;
  scripts\engine\sp\utility::motion_blur_enable(1, 1, 1);
}

truck_wreck_vision() {
  visionsetnaked("embassy_offices_bpg_truck_wreck", 1.25);
  wait 25;
  visionsetnaked("", 10);
}

green_beam_pickup() {
  thread green_beam_fade_on_lighting();
  setsaveddvar("MPOKKOPMTN", "32 64 128 256");
  visionsetnaked("embassy_green_beam_pickup", 0.5);
  level.green_beam thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 20, undefined, undefined, "j_gun");
  wait 4;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 20, undefined, undefined, "tag_eye");
  wait 11.5;
  thread green_beam_fade_off_lighting();
  wait 2.5;
  visionsetnaked("", 0.5);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

green_beam_fade_on_lighting() {
  level.fade_time = 1.0;
  level.fill_max_intensity = 0.09;
  level.rim_max_intensity = 0.5;
  level.green_beam_fill_light thread lerp_value_fill(0, level.fill_max_intensity, level.fade_time);
  level.green_beam_rim_light thread lerp_value_rim(0, level.rim_max_intensity, level.fade_time);
}

green_beam_fade_off_lighting() {
  level.green_beam_fill_light thread lerp_value_fill(level.fill_max_intensity, 0, level.fade_time);
  level.green_beam_rim_light thread lerp_value_rim(level.rim_max_intensity, 0, level.fade_time);
}

lerp_value_fill(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.02;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.green_beam_fill_light setlightintensity(var_0);
      wait(var_4);
    }
  }
}

lerp_value_rim(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.02;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.green_beam_rim_light setlightintensity(var_0);
      wait(var_4);
    }
  }
}

bpg_combat_window_exterior_light_on_and_off() {
  var_0 = getEnt("bpg_combat_window_exterior_light_01", "targetname");
  var_1 = getEnt("bpg_combat_window_exterior_light_02", "targetname");
  var_0 setlightintensity(0.0);
  var_1 setlightintensity(0.0);

  if(getDvar("LLQQOPKTKM") == "1") {
    var_0 setlightintensity(1.5);
    var_1 setlightintensity(1.5);
    return;
  }

  var_2 = getEnt("trigger_bpg_combat_window_light_on", "targetname");
  var_2 waittill("trigger");
  var_0 setlightintensity(1.5);
  var_1 setlightintensity(1.5);
  var_2 = getEnt("trigger_bpg_combat_window_light_off", "targetname");
  var_2 waittill("trigger");
  var_0 setlightintensity(0.0);
  var_1 setlightintensity(0.0);
}

all_lights_off() {
  level.saferoom_fill_light = getEnt("saferoom_fill_light", "targetname");
  level.saferoom_fill_light setlightintensity(0.0);
  level.saferoom_rim_light = getEnt("saferoom_rim_light", "targetname");
  level.saferoom_rim_light setlightintensity(0.0);
  level.wolfdoor_key_light = getEnt("wolfdoor_key", "targetname");
  level.wolfdoor_key_light setlightintensity(0.0);
  level.mortar_moment_painters_light = getEnt("mortar_moment_painters_light", "targetname");
  level.mortar_moment_painters_light setlightintensity(0.0);
  level.alley_heli_crash_lgt_1 = getEnt("alley_heli_crash_lgt_1", "targetname");
  level.alley_heli_crash_lgt_1 setlightintensity(0.0);
  level.alley_heli_crash_lgt_2 = getEnt("alley_heli_crash_lgt_2", "targetname");
  level.alley_heli_crash_lgt_2 setlightintensity(0.0);
  level.saferoom_kyle_fill_light = getEnt("saferoom_kyle_fill_light", "targetname");
  level.saferoom_kyle_fill_light setlightintensity(0.0);
  level.saferoom_kyle_rim_light = getEnt("saferoom_kyle_rim_light", "targetname");
  level.saferoom_kyle_rim_light setlightintensity(0.0);
  level.green_beam_fill_light = getEnt("price_green_beam_fill_light", "targetname");
  level.green_beam_fill_light setlightintensity(0.0);
  level.green_beam_rim_light = getEnt("price_green_beam_rim_light", "targetname");
  level.green_beam_rim_light setlightintensity(0.0);
  level.truck_crash_wall_hole_light = getEnt("truck_crash_wall_hole_light", "targetname");
  level.truck_crash_wall_hole_light setlightintensity(0.0);
  level.roof_heli_crash_explosion_light_01 = getEnt("roof_heli_crash_explosion_light_01", "targetname");
  level.roof_heli_crash_explosion_light_01 setlightintensity(0.0);
  var_0 = getEnt("roof_heli_crash_fire_light_01", "targetname");
  var_0 setlightintensity(0.0);
  var_1 = getEnt("stair_b_car_fire_light_01", "targetname");
  var_1 setlightintensity(0.0);
  level.bpg_car_fire_light = getEnt("bpg_scene_car_fire_light_01", "targetname");
  level.bpg_car_fire_light setlightintensity(0.0);

  if(getDvar("LLQQOPKTKM") == "1") {
    level.bpg_car_fire_light setlightintensity(40.0);
    return;
  }
}

heli_crash_fire_lights() {
  level.heli_crash_lights = getEntArray("heli_crash_fire_lgt", "targetname");

  foreach(var_1 in level.heli_crash_lights) {
    var_1.og_intensity = var_1 getlightintensity();
    var_1 setlightintensity(0.0);
  }

  scripts\engine\utility::flag_wait("heli_crash_light_flicker");

  foreach(var_1 in level.heli_crash_lights)
  var_1 setlightintensity(var_1.og_intensity);
}

lt_infil_helicopter_start() {
  thread setup_infil_lights();
  setsaveddvar("MPOKKOPMTN", "64 192 320 512");
  setsaveddvar("LKOLRONRNQ", 450);
  waitframe();
  visionsetnaked("embassy_infil_heli", 0);
  level.player enablephysicaldepthoffieldscripting();
  level.kyle thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 20, undefined, undefined, "tag_eye", undefined, 1);
  wait 3.5;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 4, undefined, undefined, "tag_eye", undefined, 1);
  wait 3;
  level.kyle thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 4, undefined, undefined, "tag_eye", undefined, 1);
  wait 2;
  scripts\engine\utility::flag_set("heli_door");
  setsaveddvar("MPOKKOPMTN", "128 768 1280 2048");
  visionsetnaked("embassy_infil", 0.5);
  wait 0.5;
  level thread scripts\engine\sp\utility::dof_enable(2.2, 3000, 4.0, 2.0, undefined, undefined);
  wait 16;
  level thread scripts\engine\sp\utility::dof_enable(2.2, 18, 1.0, 1.0, undefined, undefined);
  wait 2.8;
  level thread scripts\engine\sp\utility::dof_enable(2.2, 3000, 4.0, 2.0, undefined, undefined);
  level waittill("rocket_hit");
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 8, undefined, undefined, "tag_eye", [level.player], 1);
  scripts\engine\sp\utility::motion_blur_enable(2, 1);
  thread rocket_hit_blur();
  level waittill("spawn_hat");
  wait 2.75;
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  level.infil_heli thread scripts\engine\sp\utility::dof_enable_autofocus(4.0, 10, 10, undefined, "tag_origin", [level.player], 1);
  wait 2;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, 10, undefined, "tag_origin", [level.player], 1);
  scripts\engine\utility::delaythread(0.5, ::start_roof_heli_crash_fire_flicker);
  thread stop_roof_heli_crash_fire_flicker();
  scripts\engine\utility::delaythread(1.5, ::roof_heli_explosion_light);
  scripts\engine\utility::delaythread(1.5, ::roof_heli_explosion_vision);
  scripts\engine\utility::delaythread(1.5, ::roof_heli_explosion_crash_light_flicker);
  wait 4;
  scripts\engine\sp\utility::motion_blur_enable(1, 1, 1);
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 2.0, 2.0, undefined, "tag_eye", [level.player], 1);
  level.player.rig castshadows();
  wait 17.5;
  thread scripts\engine\sp\utility::dof_enable(8, 15, 5.0, 5.0, undefined, undefined);
  wait 1;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
  level.player.rig dontcastshadows();
  setsaveddvar("NPONLLLSPL", 0.26);
}

lt_embassy_roof_start() {
  thread roof_heli_explosion_crash_light_flicker();
  thread start_roof_heli_crash_fire_flicker();
}

rocket_hit_blur() {
  setblur(0.5, 0.5);
  wait 0.5;
  setblur(0.0, 0.75);
}

roof_heli_explosion_vision() {
  visionsetnaked("embassy_offices_level_roof_heli_explosion", 0.25);
  wait 1.25;
  visionsetnaked("", 2.5);
}

roof_heli_explosion_light() {
  setsaveddvar("LKOLRONRNQ", 750);
  var_0 = 40.0;
  var_1 = 0.15;
  var_2 = 1.0;
  level.roof_heli_crash_explosion_light_01 = getEnt("roof_heli_crash_explosion_light_01", "targetname");
  level.roof_heli_crash_explosion_light_01 thread lerp_value_heli_crash(0, var_0, var_1);
  wait 0.15;
  level.roof_heli_crash_explosion_light_01 lerp_value_heli_crash(var_0, 0, var_2);
  wait 1.0;
}

roof_heli_explosion_crash_light_flicker() {
  scripts\engine\utility::flag_set("heli_crash_light_flicker");
}

setup_infil_lights() {
  if(isDefined(level.infil_heli))
    waitframe();
  else {
    level.infil_heli = getEnt("delivery_copter", "targetname");
    level.infil_heli scripts\engine\sp\utility::assign_animtree("infil_heli");
  }

  level.infil_heli_rim_light = getEnt("infil_heli_rim_light", "targetname");
  level.infil_heli_rim_light setlightintensity(0.3);
  level.infil_heli_rim_light setlightradius(200);
  level.infil_heli_rim_light setlightfovrange(70, 20);
  level.infil_heli_rim_light setlightcolor((1, 0.388, 0.16));
  level.infil_heli_rim_light linkTo(level.infil_heli, "tag_light_cargo01", (-5, 6, 0), (30, 120, 0));
  level.infil_heli_kyle_light = getEnt("infil_heli_kyle_light", "targetname");
  level.infil_heli_kyle_light setlightintensity(0.02);
  level.infil_heli_kyle_light setlightradius(60);
  level.infil_heli_kyle_light setlightfovrange(60, 20);
  level.infil_heli_kyle_light setlightcolor((0.74, 1, 0.85));
  level.infil_heli_kyle_light linkTo(level.infil_heli, "tag_guy4", (0, 0, 0), (-53, -98, 0));
  level.infil_heli_fill_light = getEnt("infil_heli_fill_light", "targetname");
  level.infil_heli_fill_light setlightintensity(3.0);
  level.infil_heli_fill_light setlightradius(150);
  level.infil_heli_fill_light setlightfovrange(50, 30);
  level.infil_heli_fill_light setlightcolor((0.49, 0.964, 1));
  level.infil_heli_fill_light linkTo(level.infil_heli, "side_door_r_jnt", (-25, 5, 0), (0, 80, 0));
  level.infil_heli_cockpit_light = getEnt("infil_heli_cockpit_light", "targetname");
  level.infil_heli_cockpit_light setlightintensity(0.01);
  level.infil_heli_cockpit_light setlightradius(150);
  level.infil_heli_cockpit_light setlightfovrange(110, 80);
  level.infil_heli_cockpit_light setlightcolor((0.258, 0.827, 1));
  level.infil_heli_cockpit_light linkTo(level.infil_heli, "tag_light_cockpit01", (47, 0, -35), (-125, 0, 0));
  level.infil_heli_exterior_light = getEnt("infil_heli_exterior_light", "targetname");
  level.infil_heli_exterior_light setlightradius(210);
  level.infil_heli_exterior_light setlightfovrange(68, 65);
  level.infil_heli_exterior_light setlightcolor((0.9, 1, 0.9));
  level.infil_heli_exterior_light linkTo(level.infil_heli, "tag_origin", (-30, 80, 0), (59, -30, 0));
  thread kill_lights();
  wait 9;
  level.infil_heli_kyle_light setlightintensity(0.0);
  wait 2;
  level.infil_heli_kyle_light delete();
}

kill_lights() {
  level waittill("price_lands");
  wait 3;
  level.infil_heli_rim_light setlightintensity(0.0);
  level.infil_heli_fill_light setlightintensity(0.0);
  level.infil_heli_cockpit_light setlightintensity(0.0);
  level.infil_heli_exterior_light setlightintensity(0.0);
  wait 2;
  level.infil_heli_rim_light delete();
  level.infil_heli_fill_light delete();
  level.infil_heli_cockpit_light delete();
  level.infil_heli_exterior_light delete();
  scripts\engine\utility::flag_clear("heli_door");
}

start_roof_heli_crash_fire_flicker() {
  var_0 = getEnt("roof_heli_crash_fire_light_01", "targetname");
  var_0 setlightcolor((1, 0.45, 0.05));
  var_0 setlightintensity(0.025);
  var_0 setlightfovrange(120, 4);
  var_0 setlightradius(210);
  var_0 thread fire_flicker_roof_heli_crash();
}

stop_roof_heli_crash_fire_flicker() {
  var_0 = getEnt("roof_heli_crash_fire_light_01", "targetname");
  var_1 = getEnt("roof_heli_crash_fire_light_01_off", "targetname");
  var_1 waittill("trigger");
  var_0 notify("stop_fire_flicker_roof_heli_crash");
  var_0 setlightintensity(0.0);
}

setup_stair_b() {
  wait 1;

  while(!scripts\engine\utility::flag_exist("stair_b"))
    waitframe();

  if(!scripts\sp\starts::is_after_start("infil_stairwell")) {
    scripts\engine\utility::flag_wait("stair_b");
    thread start_stair_b_car_fire_flicker();
    thread stop_stair_b_car_fire_flicker();
  }
}

start_stair_b_car_fire_flicker() {
  var_0 = getEnt("stair_b_car_fire_light_01", "targetname");
  var_0 setlightcolor((1, 0.517, 0.176));
  var_0 setlightintensity(10);
  var_0 setlightfovrange(110, 20);
  var_0 setlightradius(550);
  var_0 thread fire_flicker_stair_b_car();
}

stop_stair_b_car_fire_flicker() {
  var_0 = getEnt("stair_b_car_fire_light_01", "targetname");
  var_1 = getEnt("stair_b_car_fire_light_01_off", "targetname");
  var_1 waittill("trigger");
  var_0 notify("stop_fire_flicker_stair_b_car");
  var_0 setlightintensity(0.0);
}

start_bpg_metal_detector_fire_flicker() {
  var_0 = getEnt("bpg_metal_detector_fire_light_01", "targetname");
  var_0 setlightintensity(0.0);
  var_1 = getEnt("bpg_metal_detector_fire_light_01_on", "targetname");
  var_1 waittill("trigger");
  var_0 thread fire_flicker_bpg_metal_detector();
  var_1 = getEnt("bpg_metal_detector_fire_light_01_off", "targetname");
  var_1 waittill("trigger");
  var_0 notify("stop_fire_flicker_bpg_metal_detector");
  var_0 setlightintensity(0.0);
}

setup_bpg_metal_detector_fire_flicker() {
  var_0 = getEnt("bpg_metal_detector_fire_light_01", "targetname");
  var_0 setlightcolor((1, 0.2, 0));
  var_0 setlightintensity(35);
}

flare_light() {
  waitframe();
  var_0 = 200;
  var_1 = 2;
  var_2 = 5;
  var_3 = level.flare_light getlightradius();

  if(scripts\engine\utility::flag("sniper_roof_start"))
    var_0 = 120;

  if(scripts\engine\utility::flag("wave_4_end"))
    var_0 = 60;

  if(scripts\engine\utility::flag("wave_5_house_end"))
    var_0 = 30;

  if(isDefined(level.flare_light.intensity))
    var_0 = level.flare_light.intensity;

  level.flare_light setlightcolor((1, 0.95, 1.25));
  level.flare_light setlightradius(level.flare_light getlightradius() * 0.9);
  level.flare_light setlightfovrange(120, 40);
  level.flare_light thread lerp_value(0, var_0, var_1);
  level.flare_light thread flicker_flare(var_1, var_0, var_2);
  wait(level.flare_lifetime - var_2);
  level.flare_light lerp_value(var_0, 0, var_2);
  level.flare_light setlightradius(var_3);
}

setup_bpg_combat() {}

flare_light_up() {
  waitframe();
  var_0 = 70.0;
  var_1 = 1.5;
  var_2 = 3;
  level.flare_light_up setlightcolor((0.7, 0.925, 1.25));
  level.flare_light_up setlightradius(450);
  level.flare_light_up thread lerp_value_up(0, var_0, var_1);
  level.flare_light_up thread flicker_flare_up(var_1, var_0, var_2);
  wait(level.flare_lifetime - var_2);
  level.flare_light_up lerp_value_up(var_0, 0, var_2);
}

field_lights() {
  var_0 = getEnt("field_street_lamps_1", "targetname");
  var_1 = getEnt("field_street_lamps_2", "targetname");
  var_2 = getEnt("field_street_lamps_3", "targetname");
  var_3 = getEnt("field_street_lamps_4", "targetname");
  var_4 = [var_0, var_1, var_2, var_3];

  foreach(var_6 in var_4)
  var_6 setlightintensity(20);
}

init_tree_fire_light() {
  var_0 = getEnt("tree_fire_light", "targetname");
  var_0.angles = var_0.angles + (-30, 45, 0);
  var_0 setlightcolor((1, 0.682, 0.352));
  var_0 setlightintensity(0);
}

start_tree_fire_flicker() {
  var_0 = getEnt("tree_fire_light", "targetname");
  var_0 setlightintensity(10);
  var_0 setlightradius(var_0 getlightradius() / 1.5);
  var_0 thread fire_flicker();
}

fire_flicker_bpg_car() {
  thread setup_bpg_car_fire_flicker();
  self endon("death");
  self endon("stop_fire_flicker_bpg_car");
  self.og_origin = self.origin;
  var_0 = 10;
  var_1 = 0.05;
  var_2 = 0.2;
  var_3 = 0;
  var_4 = [];
  var_4["intensity"] = create_light_setting("intensity", self getlightintensity(), 0.125, 1, 0.05, 0.25, ::setlightintensity);
  var_4["color"] = create_light_setting("color", self getlightcolor(), 0.25, 1, 0.05, 0.25, ::setlightcolor);

  for(;;) {
    waitframe();

    if(gettime() > var_3) {
      var_5 = randomfloatrange(var_1, var_2);
      var_3 = gettime() + var_5 * 1000;
    }

    var_6 = 0;

    foreach(var_9, var_8 in var_4) {
      lerp_light_setting(var_8);
      var_6++;
    }
  }
}

setup_bpg_car_fire_flicker() {
  level.bpg_car_fire_light setlightintensity(40);
}

fire_flicker_bpg_metal_detector() {
  thread setup_bpg_metal_detector_fire_flicker();
  self endon("death");
  self endon("stop_fire_flicker_bpg_metal_detector");
  self.og_origin = self.origin;
  var_0 = 2;
  var_1 = 0.1;
  var_2 = 0.2;
  var_3 = 0;
  var_4 = [];
  var_4["intensity"] = create_light_setting_bpg("intensity", self getlightintensity(), 0.1, 1.5, 0.02, 0.25, ::setlightintensity);
  var_4["color"] = create_light_setting_bpg("color", self getlightcolor(), 0.25, 1, 0.05, 0.25, ::setlightcolor);

  for(;;) {
    waitframe();

    if(gettime() > var_3) {
      var_5 = randomfloatrange(var_1, var_2);
      var_3 = gettime() + var_5 * 1000;
    }

    var_6 = 0;

    foreach(var_9, var_8 in var_4) {
      lerp_light_setting_bpg(var_8);
      var_6++;
    }
  }
}

create_light_setting_bpg(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.ogval = var_1;
  var_7.nextval = var_7.ogval;
  var_7.prevval = var_7.ogval;
  var_7.value = var_1;
  var_7.minscale = var_2;
  var_7.maxscale = var_3;
  var_7.mintime = var_4;
  var_7.maxtime = var_5;
  var_7.func = var_6;
  var_7.count = 0;
  var_7.count_total = 0;
  return var_7;
}

lerp_light_setting_bpg(var_0) {
  if(var_0.count == var_0.count_total) {
    var_0.count_total = int(randomfloatrange(var_0.mintime, var_0.maxtime) * 20);
    var_0.count = 0;
    var_0.nextval = var_0.ogval * randomfloatrange(var_0.minscale, var_0.maxscale);
    var_0.prevval = var_0.value;
  }

  var_0.value = scripts\engine\math::lerp(var_0.prevval, var_0.nextval, var_0.count / var_0.count_total);
  self call[[var_0.func]](var_0.value);
  var_0.count++;
}

fire_flicker_roof_heli_crash() {
  self endon("death");
  self endon("stop_fire_flicker_roof_heli_crash");
  self.og_origin = self.origin;
  var_0 = 10;
  var_1 = 0.05;
  var_2 = 0.2;
  var_3 = 0;
  var_4 = [];
  var_4["intensity"] = create_light_setting("intensity", self getlightintensity(), 0.125, 1, 0.05, 0.25, ::setlightintensity);
  var_4["color"] = create_light_setting("color", self getlightcolor(), 0.25, 1, 0.05, 0.25, ::setlightcolor);
  var_4["range"] = create_light_setting("range", self getlightradius(), 0.9, 1, 0.05, 0.15, ::setlightradius);

  for(;;) {
    waitframe();

    if(gettime() > var_3) {
      var_5 = var_0 * randomfloatrange(-1, 1);
      var_6 = var_0 * randomfloatrange(-1, 1);
      var_7 = var_0 * randomfloatrange(-1, 1);
      var_8 = self.og_origin + (var_5, var_6, var_7);
      var_9 = randomfloatrange(var_1, var_2);
      var_3 = gettime() + var_9 * 1000;
      self moveTo(var_8, var_9);
    }

    var_10 = 0;

    foreach(var_13, var_12 in var_4) {
      lerp_light_setting(var_12);
      var_10++;
    }
  }
}

fire_flicker_stair_b_car() {
  self endon("death");
  self endon("stop_fire_flicker_stair_b_car");
  self.og_origin = self.origin;
  var_0 = 10;
  var_1 = 0.05;
  var_2 = 0.2;
  var_3 = 0;
  var_4 = [];
  var_4["intensity"] = create_light_setting("intensity", self getlightintensity(), 0.125, 1, 0.05, 0.25, ::setlightintensity);
  var_4["color"] = create_light_setting("color", self getlightcolor(), 0.25, 1, 0.05, 0.25, ::setlightcolor);
  var_4["range"] = create_light_setting("range", self getlightradius(), 0.9, 1, 0.05, 0.15, ::setlightradius);

  for(;;) {
    waitframe();

    if(gettime() > var_3) {
      var_5 = randomfloatrange(var_1, var_2);
      var_3 = gettime() + var_5 * 1000;
    }

    var_6 = 0;

    foreach(var_9, var_8 in var_4) {
      lerp_light_setting(var_8);
      var_6++;
    }
  }
}

fire_flicker() {
  self endon("death");
  self endon("stop_fire_flicker");
  self.og_origin = self.origin;
  var_0 = 10;
  var_1 = 0.05;
  var_2 = 0.2;
  var_3 = 0;
  var_4 = [];
  var_4["intensity"] = create_light_setting("intensity", self getlightintensity(), 0.1, 1, 0.1, 0.25, ::setlightintensity);
  var_4["color"] = create_light_setting("color", self getlightcolor(), 0.25, 1, 0.05, 0.25, ::setlightcolor);
  var_4["range"] = create_light_setting("range", self getlightradius(), 0.9, 1, 0.05, 0.15, ::setlightradius);

  for(;;) {
    waitframe();

    if(gettime() > var_3) {
      var_5 = var_0 * randomfloatrange(-1, 1);
      var_6 = var_0 * randomfloatrange(-1, 1);
      var_7 = var_0 * randomfloatrange(-1, 1);
      var_8 = self.og_origin + (var_5, var_6, var_7);
      var_9 = randomfloatrange(var_1, var_2);
      var_3 = gettime() + var_9 * 1000;
      self moveTo(var_8, var_9);
    }

    var_10 = 0;

    foreach(var_13, var_12 in var_4) {
      lerp_light_setting(var_12);
      var_10++;
    }
  }
}

create_light_setting(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.ogval = var_1;
  var_7.nextval = var_7.ogval;
  var_7.prevval = var_7.ogval;
  var_7.value = var_1;
  var_7.minscale = var_2;
  var_7.maxscale = var_3;
  var_7.mintime = var_4;
  var_7.maxtime = var_5;
  var_7.func = var_6;
  var_7.count = 0;
  var_7.count_total = 0;
  return var_7;
}

lerp_light_setting(var_0) {
  if(var_0.count == var_0.count_total) {
    var_0.count_total = int(randomfloatrange(var_0.mintime, var_0.maxtime) * 20);

    if(var_0.count_total == 0)
      var_0.count_total = 1;

    var_0.count = 0;
    var_0.nextval = var_0.ogval * randomfloatrange(var_0.minscale, var_0.maxscale);
    var_0.prevval = var_0.value;
  }

  var_0.value = scripts\engine\math::lerp(var_0.prevval, var_0.nextval, var_0.count / var_0.count_total);
  self call[[var_0.func]](var_0.value);
  var_0.count++;
}

fade_tree_fire_out(var_0) {
  var_1 = getEnt("tree_fire_light", "targetname");
  var_1 notify("stop_fire_flicker");
  var_0 = 4;
  var_2 = var_0 * 20;
  var_3 = var_1 getlightintensity() / var_2;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    waitframe();
    var_1 setlightintensity(var_1 getlightintensity() - var_3);
  }

  var_1 setlightintensity(0);
}

lerp_value(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.05;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.flare_light setlightintensity(var_0);
      wait(var_4);
    }
  }
}

lerp_value_up(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.05;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.flare_light_up setlightintensity(var_0);
      wait(var_4);
    }
  }
}

lerp_value_heli_crash(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.05;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.roof_heli_crash_explosion_light_01 setlightintensity(var_0);
      wait(var_4);
    }
  }
}

flicker_flare(var_0, var_1, var_2) {
  wait(var_0);

  while(level.flare_countdown > var_2) {
    level.flare_light setlightintensity(randomfloatrange(var_1 / 4, var_1));
    waitframe();
  }
}

flicker_flare_up(var_0, var_1, var_2) {
  wait(var_0);

  while(level.flare_countdown > var_2) {
    level.flare_light_up setlightintensity(randomfloatrange(var_1 / 8, var_1));
    waitframe();
  }
}

garage_door_lights_off() {
  var_0 = getEnt("cafe_light_01", "targetname");
  var_1 = getEnt("cafe_light_01_off", "targetname");
  var_1 hide();
  var_2 = getEnt("garage_door_closed_lights_01", "targetname");
  var_3 = getEnt("garage_door_closed_lights_02", "targetname");
  var_4 = getEnt("garage_door_closed_lights_03", "targetname");
  var_5 = getEnt("garage_door_closed_lights_04", "targetname");
  var_6 = getEnt("garage_door_closed_lights_05", "targetname");
  var_7 = getEnt("garage_door_closed_lights_06", "targetname");
  var_8 = getEnt("garage_door_closed_lights_07", "targetname");
  var_9 = getEntArray("garage_door_closed_lights", "targetname");
  level waittill("garage_door_closed");
  wait 2.0;
  var_2 setlightintensity(0.0);
  wait 1.0;
  var_3 setlightintensity(0.0);
  var_0 hide();
  var_1 show();
  wait 2.0;
  var_4 setlightintensity(0.0);
  wait 0.5;
  var_5 setlightintensity(0.0);
  wait 0.5;
  var_6 setlightintensity(0.0);
  wait 0.25;
  var_7 setlightintensity(0.0);
  wait 0.1;
  var_8 setlightintensity(0.0);

  foreach(var_11 in var_9)
  var_11 setlightintensity(0.0);

  garage_model_swap("cafe_sign_light", "me_lighting_fixtures_commercial_fluorescent_sign_01_off");
}

garage_model_swap(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 setModel(var_1);
}

vision_set_init() {
  if(scripts\sp\starts::is_after_start("infil_saferoom") && !scripts\sp\starts::is_after_start("cctv_02")) {
    wait 0.2;
    visionsetnaked("embassy_cctv_01", 0.05);
  }

  if(scripts\sp\starts::is_after_start("residence_arrival") && !scripts\sp\starts::is_after_start("mortar"))
    wait 0.2;
}

vision_set_manager() {
  wait 1;

  if(!scripts\sp\starts::is_after_start("trucks"))
    scripts\engine\utility::flag_wait("rooftops_approach");

  visionsetnaked("embassy_field", 3);

  if(!scripts\sp\starts::is_after_start("trucks"))
    scripts\engine\utility::flag_wait("roof_compromised");

  visionsetnaked("", 0);
  iprintln("general_vision");
}

spotcull_mortar_and_triage() {
  for(;;) {
    scripts\engine\utility::flag_wait("spot_dist_cull_field");
    setsaveddvar("LKOLRONRNQ", 900);
    setsaveddvar("LTQMSPKRKO", 4);
    setsaveddvar("MROOOROPKL", 6);
    scripts\engine\utility::flag_waitopen("spot_dist_cull_field");
    setsaveddvar("LKOLRONRNQ", level.spotdistcull);
    setsaveddvar("LTQMSPKRKO", level.spotupdatelimit);
    setsaveddvar("MROOOROPKL", level.roundrobinlimit);
    waitframe();
  }
}

offices() {
  level endon("lt_bpg_scene");

  for(;;) {
    if(scripts\engine\utility::flag("lt_stairwell_upper"))
      scripts\engine\utility::flag_waitopen("lt_stairwell_upper");

    scripts\engine\utility::flag_wait("lt_offices");
    scripts\engine\utility::flag_set("offices_level_04_strobe");
    setsaveddvar("LKOLRONRNQ", 680);
    setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
    scripts\engine\utility::flag_waitopen("lt_offices");
    scripts\engine\utility::flag_clear("offices_level_04_strobe");
    waitframe();
  }
}

stairwell_upper() {
  level endon("lt_bpg_scene_exit");

  for(;;) {
    if(scripts\engine\utility::flag("lt_stairwell_lower"))
      scripts\engine\utility::flag_waitopen("lt_stairwell_lower");

    scripts\engine\utility::flag_wait("lt_stairwell_upper");
    setsaveddvar("LKOLRONRNQ", 1000);
    scripts\engine\utility::flag_waitopen("lt_stairwell_upper");
    waitframe();
  }
}

stairwell_lower() {
  level endon("lt_bpg_scene_exit");

  for(;;) {
    if(scripts\engine\utility::flag("lt_stairwell_upper"))
      scripts\engine\utility::flag_waitopen("lt_stairwell_upper");

    scripts\engine\utility::flag_wait("lt_stairwell_lower");
    setsaveddvar("LKOLRONRNQ", 420);
    scripts\engine\utility::flag_waitopen("lt_stairwell_lower");
    waitframe();
  }
}

bpg_metal_detectors() {
  level endon("lt_truck_office_enter");

  for(;;) {
    if(scripts\engine\utility::flag("lt_bpg_scene"))
      scripts\engine\utility::flag_waitopen("lt_bpg_scene");

    scripts\engine\utility::flag_wait("lt_bpg_metal_detectors");
    setsaveddvar("LKOLRONRNQ", 350);
    scripts\engine\utility::flag_set("bpg_metal_detectors_strobe");
    scripts\engine\utility::flag_waitopen("lt_bpg_metal_detectors");
    scripts\engine\utility::flag_clear("bpg_metal_detectors_strobe");
    waitframe();
  }
}

bpg_scene() {
  level endon("lt_truck_office_enter");

  for(;;) {
    if(scripts\engine\utility::flag("lt_bpg_scene_exit"))
      scripts\engine\utility::flag_waitopen("lt_bpg_scene_exit");

    scripts\engine\utility::flag_wait("lt_bpg_scene");
    setsaveddvar("LKOLRONRNQ", 400);
    setsaveddvar("LTQMSPKRKO", 7);
    setsaveddvar("MROOOROPKL", 9);
    level.bpg_car_fire_light thread fire_flicker_bpg_car();
    scripts\engine\utility::flag_waitopen("lt_bpg_scene");
    level.bpg_car_fire_light notify("stop_fire_flicker_bpg_car");
    level.bpg_car_fire_light setlightintensity(0.0);
    waitframe();
  }
}

bpg_scene_exit() {
  level endon("lt_truck_office_enter");

  for(;;) {
    if(scripts\engine\utility::flag("lt_bpg_scene"))
      scripts\engine\utility::flag_waitopen("lt_bpg_scene");

    scripts\engine\utility::flag_wait("lt_bpg_scene_exit");
    setsaveddvar("LKOLRONRNQ", level.spotdistcull);
    setsaveddvar("LTQMSPKRKO", level.spotupdatelimit);
    setsaveddvar("MROOOROPKL", level.roundrobinlimit);
    scripts\engine\utility::flag_waitopen("lt_bpg_scene_exit");
    waitframe();
  }
}

truck_office_enter() {
  for(;;) {
    level endon("lt_basement");

    if(scripts\engine\utility::flag("lt_truck_office"))
      scripts\engine\utility::flag_waitopen("lt_truck_office");

    scripts\engine\utility::flag_wait("lt_truck_office_enter");
    setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
    setsaveddvar("LKOLRONRNQ", level.spotdistcull);
    setsaveddvar("LTQMSPKRKO", level.spotupdatelimit);
    setsaveddvar("MROOOROPKL", level.roundrobinlimit);
    scripts\engine\utility::flag_waitopen("lt_truck_office_enter");
    waitframe();
  }
}

truck_office() {
  for(;;) {
    level endon("lt_basement");

    if(scripts\engine\utility::flag("lt_truck_office_enter"))
      scripts\engine\utility::flag_waitopen("lt_truck_office_enter");

    scripts\engine\utility::flag_wait("lt_truck_office");
    setsaveddvar("LKOLRONRNQ", 700);
    setsaveddvar("MPOKKOPMTN", "64 128 256 512");
    setsaveddvar("LTQMSPKRKO", 5);
    setsaveddvar("MROOOROPKL", 6);
    scripts\engine\utility::flag_waitopen("lt_truck_office");
    waitframe();
  }
}

bpg_combat() {
  for(;;) {
    level endon("lt_basement");

    if(scripts\engine\utility::flag("lt_truck_office"))
      scripts\engine\utility::flag_waitopen("lt_truck_office");

    scripts\engine\utility::flag_wait("lt_bpg_combat");
    setsaveddvar("LKOLRONRNQ", 400);
    setsaveddvar("MPOKKOPMTN", "64 128 256 512");
    setsaveddvar("LTQMSPKRKO", 5);
    setsaveddvar("MROOOROPKL", 7);
    scripts\engine\utility::flag_waitopen("lt_bpg_combat");
    waitframe();
  }
}

basement() {
  for(;;) {
    level endon("lt_saferoom");

    if(scripts\engine\utility::flag("lt_bpg_combat"))
      scripts\engine\utility::flag_waitopen("lt_bpg_combat");

    scripts\engine\utility::flag_wait("lt_basement");
    setsaveddvar("LKOLRONRNQ", 300);
    setsaveddvar("MPOKKOPMTN", "64 128 256 512");
    setsaveddvar("LTQMSPKRKO", 4);
    setsaveddvar("MROOOROPKL", 6);
    scripts\engine\utility::flag_waitopen("lt_basement");
    waitframe();
  }
}

saferoom() {
  for(;;) {
    level endon("lt_garage_exit");

    if(scripts\engine\utility::flag("lt_basement"))
      scripts\engine\utility::flag_waitopen("lt_basement");

    scripts\engine\utility::flag_wait("lt_saferoom");
    setsaveddvar("LKOLRONRNQ", 250);
    setsaveddvar("MPOKKOPMTN", "64 128 256 512");
    setsaveddvar("LTQMSPKRKO", 4);
    setsaveddvar("MROOOROPKL", 6);
    scripts\engine\utility::flag_waitopen("lt_saferoom");
    waitframe();
  }
}

garage() {
  for(;;) {
    level endon("lt_garage_exit");

    if(scripts\engine\utility::flag("lt_saferoom"))
      scripts\engine\utility::flag_waitopen("lt_saferoom");

    scripts\engine\utility::flag_wait("lt_garage");
    setsaveddvar("NKKPQSTMRL", 3);
    setsaveddvar("LKOLRONRNQ", 800);
    setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
    setsaveddvar("LTQMSPKRKO", 6);
    setsaveddvar("MROOOROPKL", 8);
    scripts\engine\utility::flag_waitopen("lt_garage");
    setsaveddvar("NKKPQSTMRL", 1);
    waitframe();
  }
}

garage_exit() {
  for(;;) {
    if(scripts\engine\utility::flag("lt_garage"))
      scripts\engine\utility::flag_waitopen("lt_garage");

    scripts\engine\utility::flag_wait("lt_garage_exit");
    setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
    setsaveddvar("LKOLRONRNQ", level.spotdistcull);
    setsaveddvar("LTQMSPKRKO", level.spotupdatelimit);
    setsaveddvar("MROOOROPKL", level.roundrobinlimit);
    scripts\engine\utility::flag_waitopen("lt_garage_exit");
    waitframe();
  }
}

alley_heli_crash() {
  for(;;) {
    scripts\engine\utility::flag_wait("lt_alley_heli_crash");
    start_alley_heli_crash_lgt_fire_flicker();
    level.alley_heli_crash_lgt_2 setlightintensity(10.0);
    scripts\engine\utility::flag_waitopen("lt_alley_heli_crash");
    level.alley_heli_crash_lgt_1 notify("stop_fire_flicker_alley_heli_crash");
    level.alley_heli_crash_lgt_1 setlightintensity(0.0);
    level.alley_heli_crash_lgt_2 setlightintensity(0.0);
    waitframe();
  }
}

alley_enter() {
  for(;;) {
    scripts\engine\utility::flag_wait("lt_alley_enter");
    setsaveddvar("LKOLRONRNQ", level.spotdistcull);
    setsaveddvar("LTQMSPKRKO", level.spotupdatelimit);
    setsaveddvar("MROOOROPKL", level.roundrobinlimit);
    scripts\engine\utility::flag_waitopen("lt_alley_enter");
    waitframe();
  }
}

alley() {
  for(;;) {
    if(scripts\engine\utility::flag("lt_alley_enter"))
      scripts\engine\utility::flag_waitopen("lt_alley_enter");

    scripts\engine\utility::flag_wait("lt_alley");
    setsaveddvar("LKOLRONRNQ", 450);
    scripts\engine\utility::flag_waitopen("lt_alley");
    waitframe();
  }
}

compound_residence() {
  for(;;) {
    if(scripts\engine\utility::flag("lt_alley"))
      scripts\engine\utility::flag_waitopen("lt_alley");

    scripts\engine\utility::flag_wait("lt_compound_residence");
    setsaveddvar("LKOLRONRNQ", 700);
    scripts\engine\utility::flag_waitopen("lt_compound_residence");
    waitframe();
  }
}

compound_residence_exit() {
  for(;;) {
    if(scripts\engine\utility::flag("lt_compound_residence"))
      scripts\engine\utility::flag_waitopen("lt_compound_residence");

    scripts\engine\utility::flag_wait("lt_compound_residence_exit");
    setsaveddvar("LKOLRONRNQ", level.spotdistcull);
    scripts\engine\utility::flag_waitopen("lt_compound_residence_exit");
    waitframe();
  }
}

triage_scene() {
  for(;;) {
    scripts\engine\utility::flag_wait("lt_triage_scene");
    setsaveddvar("LKOLRONRNQ", 300);
    scripts\engine\utility::flag_waitopen("lt_triage_scene");
    setsaveddvar("LKOLRONRNQ", level.spotdistcull);
    waitframe();
  }
}

mortar_wave_settings() {
  while(!scripts\engine\utility::flag_exist("front_1"))
    waitframe();

  scripts\engine\utility::flag_wait("front_1");
  setsaveddvar("MPOKKOPMTN", "256 768 1280 2048");
  scripts\engine\utility::flag_wait("front_2");
  setsaveddvar("MPOKKOPMTN", "128 420 880 1300");
  scripts\engine\utility::flag_wait("front_3");
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
}

mortar_building_attack_lighting(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  setsaveddvar("LKOLRONRNQ", 1250);
  visionsetnaked("embassy_mortar_building_attack", var_0);
}

compound_return_lighting(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  setsaveddvar("LKOLRONRNQ", 1250);
  visionsetnaked("embassy_compound_return", var_0);
}

lt_escape_start() {
  thread escape_start_fade_on_lighting();
  setsaveddvar("MPOKKOPMTN", "32 64 128 256");

  while(!isDefined(level.kyle))
    waitframe();

  level.kyle scripts\engine\sp\utility::dof_enable_autofocus(2.8, 50, undefined, undefined, "tag_eye");
  wait 2.5;
  level thread scripts\engine\sp\utility::dof_enable(2.8, 150, 4, 2.0, undefined, undefined);
  wait 1.0;
  thread escape_start_fade_off_lighting();
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  wait 1.0;
  level thread scripts\engine\sp\utility::dof_disable();
}

escape_start_fade_on_lighting() {
  level.fade_time = 1.0;
  level.fill_max_intensity = 0.075;
  level.rim_max_intensity = 2.0;
  level.saferoom_kyle_fill_light thread escape_lerp_value_fill(0, level.fill_max_intensity, level.fade_time);
  level.saferoom_kyle_rim_light thread escape_lerp_value_rim(0, level.rim_max_intensity, level.fade_time);
}

escape_start_fade_off_lighting() {
  level.saferoom_kyle_fill_light thread escape_lerp_value_fill(level.fill_max_intensity, 0, level.fade_time);
  level.saferoom_kyle_rim_light thread escape_lerp_value_rim(level.rim_max_intensity, 0, level.fade_time);
}

escape_lerp_value_fill(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.02;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.saferoom_kyle_fill_light setlightintensity(var_0);
      wait(var_4);
    }
  }

  level.saferoom_kyle_fill_light setlightintensity(var_1);
}

escape_lerp_value_rim(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.02;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      level.saferoom_kyle_rim_light setlightintensity(var_0);
      wait(var_4);
    }
  }

  level.saferoom_kyle_rim_light setlightintensity(var_1);
}

boost_moment_dof() {
  level.hadir thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 20, undefined, undefined, "tag_eye", undefined, 1);
  wait 7;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

lt_garage_keycard() {
  level.stacy thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 20, undefined, undefined, "tag_eye", undefined, 1);
  wait 2.8;
  level.ap_gar_meetup.keycard thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 20, undefined, undefined, "tag_origin", undefined, 1);
  wait 2.2;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

lt_safehouse_mic() {
  level.cctv_mic thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 20, undefined, undefined, "j_talk_button", undefined, 1);
  wait 3.0;
  visionsetnaked("embassy_blend_to_cctv", 0.5);
  wait 0.5;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

sun_disable() {
  setsuncolorandintensity(0.0);
  waitframe();
  waitframe();
  setsaveddvar("MQRQQONQSL", 0);
}

sun_enable() {
  setsaveddvar("MQRQQONQSL", 1);
  waitframe();
  setsuncolorandintensity(0.0045);
}

start_alley_heli_crash_lgt_fire_flicker() {
  level.alley_heli_crash_lgt_1 setlightintensity(10.0);
  level.alley_heli_crash_lgt_1 setlightfovrange(110, 90);
  level.alley_heli_crash_lgt_1 setlightradius(700);
  level.alley_heli_crash_lgt_1 thread fire_flicker_alley_heli_crash();
}

fire_flicker_alley_heli_crash() {
  self endon("death");
  self endon("stop_fire_flicker_alley_heli_crash");
  self.og_origin = self.origin;
  var_0 = 10;
  var_1 = 0.05;
  var_2 = 0.2;
  var_3 = 0;
  var_4 = [];
  var_4["intensity"] = create_light_setting("intensity", self getlightintensity(), 0.125, 1, 0.05, 0.25, ::setlightintensity);
  var_4["color"] = create_light_setting("color", self getlightcolor(), 0.25, 1, 0.05, 0.25, ::setlightcolor);

  for(;;) {
    waitframe();

    if(gettime() > var_3) {
      var_5 = randomfloatrange(var_1, var_2);
      var_3 = gettime() + var_5 * 1000;
    }

    var_6 = 0;

    foreach(var_9, var_8 in var_4) {
      lerp_light_setting(var_8);
      var_6++;
    }
  }
}

mortar_moment() {
  while(!scripts\engine\utility::flag_exist("roof_compromised"))
    waitframe();

  level.mortar_moment_painters_light setlightintensity(0.5);
  scripts\engine\utility::flag_wait("roof_compromised");
  level.mortar_moment_painters_light setlightintensity(0.0);
  var_0 = getEnt("mortar_moment_painters_light_fixture", "targetname");
  var_0 hide();
}

wolf_door_light() {
  setsaveddvar("LKOLRONRNQ", 100);
  setsaveddvar("LTQMSPKRKO", level.spotupdatelimit);
  setsaveddvar("MROOOROPKL", level.roundrobinlimit);
  level.wolfdoor_key_light thread generic_lerp_value(0.0, 0.3, 1.0, level.wolfdoor_key_light);
}

lt_saferoom_wolf_on() {
  level.saferoom_fill_light setlightintensity(0.07);
  level.saferoom_rim_light setlightintensity(0.03);
}

lt_saferoom_wolf_off() {
  level.saferoom_fill_light thread generic_lerp_value(0.07, 0, 1.0, level.saferoom_fill_light);
  level.saferoom_rim_light thread generic_lerp_value(0.03, 0, 1.0, level.saferoom_rim_light);
}

generic_lerp_value(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = 0.02;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    for(var_7 = var_4 / var_6; var_6; var_6--) {
      var_0 = max(var_0 + var_7, 0);
      var_3 setlightintensity(var_0);
      wait(var_5);
    }
  }

  var_3 setlightintensity(var_1);
}
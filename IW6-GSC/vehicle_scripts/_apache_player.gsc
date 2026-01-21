/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache_player.gsc
**********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("apache_player", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_drive(%apache_cockpit_rotor, undefined, 0);
  maps\_vehicle::build_life(10000, 5000, 15000);
  maps\_vehicle::build_is_helicopter();
  maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/heli_dust_default", 0);
  maps\_vehicle::build_turret("apache_pilot_turret", "tag_barrel", "vehicle_apache_iw6_mg", undefined, "manual", undefined, 20, 0);
  _precache();
  _fx();
  _flags();
  common_scripts\utility::create_lock("add_apache_target_lock", 4);
}

init_local() {
  self.originheightoffset = 162;
  _init();
  self dontcastshadows();
}

_precache() {
  precachedigitaldistortcodeassets();
  precachemodel("apache_cockpit_player");
  precachemodel("apache_cockpit_player_pipe");
  precacherumble("heavygun_fire");
  precacherumble("damage_heavy");
  precacherumble("damage_light");
  precacherumble("minigun_rumble");
  vehicle_scripts\_apache_player_targeting::_precache();
  vehicle_scripts\_chopper_player_missile_defense::_precache();
  vehicle_scripts\_apache_player_pilot::_precache();
  vehicle_scripts\_apache_player_audio::_precache();
  maps\_utility::post_load_precache(vehicle_scripts\_apache_player_difficulty::difficulty);
}

_flags() {
  common_scripts\utility::flag_init("FLAG_apache_crashing");
}

_fx() {
  level._effect["apache_player_dlight_red_flicker"] = loadfx("fx/_requests/apache/dlight_red_flicker");
  level._effect["apache_player_cockpit_smoke"] = loadfx("fx/_requests/apache/cockpit_smoke");
  level._effect["apache_player_cockpit_sparks_v1"] = loadfx("fx/_requests/apache/cockpit_sparks_v1");
  level._effect["apache_player_cockpit_sparks_v2"] = loadfx("fx/_requests/apache/cockpit_sparks_v2");
  level._effect["apache_player_cockpit_explosion"] = loadfx("fx/_requests/apache/cockpit_explosion");
  level._effect["apache_player_cockpit_pipe_hiss"] = loadfx("vfx/moments/oil_rocks/heli_pipe_snap");
}

enable_treadfx() {
  maps\_treadfx::setallvehiclefx("player", "fx/treadfx/heli_dust_default");
  maps\_treadfx::setvehiclefx("player", "water", "fx/treadfx/heli_water");
  maps\_treadfx::setvehiclefx("player", "snow", "fx/treadfx/heli_snow_default");
  maps\_treadfx::setvehiclefx("player", "slush", "fx/treadfx/heli_snow_default");
  maps\_treadfx::setvehiclefx("player", "ice", "fx/treadfx/heli_snow_default");
}

_start(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  self.heli = var_3;
  var_0.riding_heli = self;
  var_3.owner = var_0;
  var_3.vehicle = self;
  var_3.cover_warnings_disabled = level.cover_warnings_disabled;
  var_3.treadfx_maxheight = level.treadfx_maxheight;
  var_3.g_friendlynamedist = getdvarint("g_friendlyNameDist");
  var_3.hud_showstance = getdvarint("hud_showStance");
  var_3.compass = getdvarint("compass");
  var_3.ammocounterhide = getdvarint("ammoCounterHide");
  var_3.hud_fade_ammodisplay = getdvarfloat("hud_fade_ammodisplay");
  var_3.hud_fade_stance = getdvarfloat("hud_fade_stance");
  var_3.friendlyfire_max_participation = level.friendlyfire["max_participation"];
  level.friendlyfire["max_participation"] = 1750;
  var_3.targeting = vehicle_scripts\_apache_player_targeting::_init(var_0);
  var_3.pilot = vehicle_scripts\_apache_player_pilot::_init(self, var_0);
  var_3.audio = vehicle_scripts\_apache_player_audio::_init(self, var_0);
  var_3.missiledefense = vehicle_scripts\_chopper_player_missile_defense::_init(self, var_0, var_2);
  var_3.cockpit_tubes = spawn("script_model", self.origin);
  var_3.cockpit_tubes.angles = self.angles;
  var_3.cockpit_tubes setModel("apache_cockpit_player_pipe");
  var_3.cockpit_tubes linkto(self, "tag_origin");
  level.cover_warnings_disabled = 1;
  level.treadfx_maxheight = 9000;
  setsaveddvar("g_friendlyNameDist", 150000);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("hud_fade_ammodisplay", "0.1");
  setsaveddvar("hud_fade_stance", "0.1");
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("compass", 1);
  setsaveddvar("sm_spotenable", 0);
  var_3 maps\_utility::ent_flag_init("FLAG_sprinting");
  var_3 maps\_utility::ent_flag_init("FLAG_pilot_active");
  var_3 maps\_utility::ent_flag_init("FLAG_gunCamera_active");
  var_0 maps\_utility::ent_flag_init("FLAG_apache_player_move_up");
  var_0 maps\_utility::ent_flag_init("FLAG_apache_player_used_move_up");
  var_0 maps\_utility::ent_flag_init("FLAG_apache_player_move_down");
  var_0 maps\_utility::ent_flag_init("FLAG_apache_player_used_move_down");
  var_0 maps\_utility::ent_flag_init("FLAG_apache_pilot_active");
  var_0 maps\_utility::ent_flag_init("FLAG_apache_gunCamera_active");
  maps\_vehicle::aircraft_wash();
  var_3 maps\_utility::ent_flag_set("FLAG_pilot_active");
  var_3.owner maps\_utility::ent_flag_set("FLAG_apache_pilot_active");
  thread monitormachinegun();
  thread monitorhealth();
  thread monitorcockpitanims();
  thread monitorsprint();
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0);

  if(var_1) {
    thread monitormoveup();
    thread monitormovedown();
    removealtituedmesh();
  } else
    thread monitoraltitude();

  var_3.targeting thread vehicle_scripts\_apache_player_targeting::_start();
  var_3.missiledefense thread vehicle_scripts\_chopper_player_missile_defense::_start();
  var_3.pilot vehicle_scripts\_apache_player_pilot::_start(!var_1);
  var_3.audio vehicle_scripts\_apache_player_audio::_start();
  var_3.fov_orig = 65;
  var_0 maps\_utility::lerpfov_saved(65, 0.1);
  var_3.pitch_offset_ground = 25.0;
  var_3.pitch_offset_mid = 12.0;
  var_3.pitch_offset_air = 9.0;
  setsaveddvar("vehHelicopterPitchOffset", var_3.pitch_offset_ground);
  var_3.pitch_max = 10.0;
  setsaveddvar("vehHelicopterMaxPitch", var_3.pitch_max);
  setsaveddvar("vehHelicopterSoftCollisions", 1);
  setsaveddvar("vehHelicopterControlSystem", 1);
  setsaveddvar("vehHelicopterDecelerationFwd", 1.0);
  setsaveddvar("vehHelicopterMaxAccel", 60);
  setsaveddvar("vehHelicopterMaxSpeed", 120);
  setsaveddvar("vehHelicopterMaxYawAccel", 700.0);
  setsaveddvar("vehHelicopterMaxYawRate", 120.0);
  setsaveddvar("vehHelicopterPitchLock", 0);
  setsaveddvar("vehHelicopterTiltFromLook", 0.0);
  setsaveddvar("vehHelicopterTiltFromLookRate", 0.0);
  setsaveddvar("vehHelicopterTiltSpeed", 1.2);
  setsaveddvar("vehHelicopterTiltFromFwdAndYaw", 50);
  setsaveddvar("vehHelicopterTiltFromFwdAndYaw_VelAtMaxTilt", 0.8);

  if(var_1) {
    setsaveddvar("vehHelicopterControlsAltitude", 3);
    setsaveddvar("vehHelicopterLookaheadTime", 1.0);
    setsaveddvar("vehHelicopterMaxAccelVertical", 90.0);
    setsaveddvar("vehHelicopterMaxSpeedVertical", 65.0);
  } else {
    setsaveddvar("vehHelicopterControlsAltitude", 4);
    setsaveddvar("vehHelicopterLookaheadTime", 0.4);
    setsaveddvar("vehHelicopterMaxAccelVertical", 200.0);
    setsaveddvar("vehHelicopterMaxSpeedVertical", 300.0);
  }

  var_0 disableweaponswitch();
  var_0 allowcrouch(0);
  var_0 allowprone(0);
  var_0 allowjump(0);
  var_0 setplayerangles((0, self.angles[1], 0));
  var_0 maps\_utility::player_mount_vehicle(self);
  level.disablegrenadetracking = 1;
  level.disablegeardrop = 1;
  level.disablemonitorflash = 1;
  thread _battlechatter_off();
  thread setaishootoverride();
  maps\_friendlyfire::apply_friendly_fire_damage_modifier(0.1);
}

setaishootoverride() {
  anim.shootenemywrapper_func = ::overrideaishot;
  anim.shootposwrapper_func = ::shootposwrapper;
}

overrideaishot(var_0) {
  self.a.lastshoottime = gettime();
  self notify("shooting");
  shootblankorrpg(self.enemy.origin, var_0);
}

shootposwrapper(var_0, var_1) {
  self.a.lastshoottime = gettime();

  if(!isDefined(var_1))
    var_1 = 1;

  self notify("shooting");
  shootblankorrpg(var_0, var_1);
}

shootblankorrpg(var_0, var_1) {
  if(weaponclass(self.weapon) == "rocketlauncher")
    self shoot(1, var_0, var_1);
  else
    self shootblank(1, var_0, var_1);
}

_battlechatter_off() {
  waittillframeend;
  thread maps\_utility::battlechatter_off();
  animscripts\battlechatter::disablebattlechatter();
}

_battlechatter_on() {
  thread maps\_utility::battlechatter_on();
  animscripts\battlechatter::enablebattlechatter();
}

setmaxheight_overtime(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 = max(var_1, 0.05);
    var_2 = getdvarfloat("vehHelicopterMaxAltitude");

    for(var_3 = 0; var_3 < var_1; var_3 = var_3 + 0.05) {
      setsaveddvar("vehHelicopterMaxAltitude", var_2 + var_3 / var_1 * (var_0 - var_2));
      wait 0.05;
    }
  } else
    setsaveddvar("vehHelicopterMaxAltitude", var_0);
}

setminheight_overtime(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 = max(var_1, 0.05);
    var_2 = getdvarfloat("vehHelicopterMinAltitude");

    for(var_3 = 0; var_3 < var_1; var_3 = var_3 + 0.05) {
      setsaveddvar("vehHelicopterMinAltitude", var_2 + var_3 / var_1 * (var_0 - var_2));
      wait 0.05;
    }
  } else
    setsaveddvar("vehHelicopterMinAltitude", var_0);
}

_end() {
  if(maps\_utility::ent_flag_exist("ENT_FLAG_heli_destroyed") && maps\_utility::ent_flag("ENT_FLAG_heli_destroyed")) {
    return;
  }
  var_0 = self.heli;
  var_1 = var_0.owner;
  self notify("LISTEN_heli_end");
  var_0 notify("LISTEN_heli_end");
  var_0.targeting vehicle_scripts\_apache_player_targeting::_end();
  var_0.missiledefense vehicle_scripts\_chopper_player_missile_defense::_destroy();
  var_0.pilot vehicle_scripts\_apache_player_pilot::_destroy();
  var_0.audio vehicle_scripts\_apache_player_audio::_destroy();
  var_0.cockpit_tubes delete();
  monitorhealth_damagestates_cleanup();
  level.cover_warnings_disabled = var_0.cover_warnings_disabled;
  level.treadfx_maxheight = var_0.treadfx_maxheight;

  if(isDefined(var_0.g_friendlynamedist))
    setsaveddvar("g_friendlyNameDist", var_0.g_friendlynamedist);

  if(isDefined(var_0.hud_showstance))
    setsaveddvar("hud_showStance", var_0.hud_showstance);

  if(isDefined(var_0.compass))
    setsaveddvar("compass", var_0.compass);

  if(isDefined(var_0.ammocounterhide))
    setsaveddvar("ammoCounterHide", var_0.ammocounterhide);

  if(isDefined(var_0.hud_fade_ammodisplay))
    setsaveddvar("hud_fade_ammodisplay", var_0.hud_fade_ammodisplay);

  if(isDefined(var_0.hud_fade_stance))
    setsaveddvar("hud_fade_stance", var_0.hud_fade_stance);

  level.friendlyfire["max_participation"] = var_0.friendlyfire_max_participation;

  if(isDefined(var_0.fov_orig)) {
    var_1 maps\_utility::lerpfov_saved(var_0.fov_orig, 1.05);
    var_0.fov_orig = undefined;
  }

  var_1 enableweaponswitch();
  var_1 allowcrouch(1);
  var_1 allowprone(1);
  var_1 allowjump(1);
  self notify("stop_kicking_up_dust");
  var_1 maps\_utility::ent_flag_clear("FLAG_apache_player_move_up", 1);
  var_1 maps\_utility::ent_flag_clear("FLAG_apache_player_used_move_up", 1);
  var_1 maps\_utility::ent_flag_clear("FLAG_apache_player_move_down", 1);
  var_1 maps\_utility::ent_flag_clear("FLAG_apache_player_used_move_down", 1);
  var_1 maps\_utility::ent_flag_clear("FLAG_apache_pilot_active", 1);
  var_1 maps\_utility::ent_flag_clear("FLAG_apache_gunCamera_active", 1);
  var_1 maps\_utility::player_dismount_vehicle();
  level.autosave_check_override = undefined;
  level.disablegrenadetracking = undefined;
  level.disablegeardrop = undefined;
  level.disablemonitorflash = undefined;
  self delete();
  thread _battlechatter_on();
  anim.shootenemywrapper_func = animscripts\utility::shootenemywrapper_shootnotify;
  anim.shootposwrapper_func = animscripts\utility::shootposwrapper;
  setsaveddvar("sm_spotenable", 1);
  maps\_friendlyfire::remove_friendly_fire_damage_modifier();
}

monitor_pilotandguncameraswitch() {
  self endon("LISTEN_heli_end");
  var_0 = self.heli;
  var_1 = var_0.pilot;
  var_2 = var_0.guncamera;
  var_3 = var_0.missiledefense;
  var_4 = var_0.owner;
  var_4 notifyonplayercommand("LISTEN_pilotAndGunCameraSwitch", "+usereload");
  var_0 maps\_utility::ent_flag_set("FLAG_pilot_active");
  var_4 maps\_utility::ent_flag_set("FLAG_apache_pilot_active");

  for(;;) {
    var_4 waittill("LISTEN_pilotAndGunCameraSwitch");
    var_4 thread maps\_utility::play_sound_on_entity("apache_pilot_guncamera_switch");
    var_4 maps\_hud_util::fade_out();
    wait 0.2;
    var_1 vehicle_scripts\_apache_player_pilot::_end();
    var_0 maps\_utility::ent_flag_clear("FLAG_pilot_active");
    var_4 maps\_utility::ent_flag_clear("FLAG_apache_pilot_active");
    var_0 maps\_utility::ent_flag_set("FLAG_gunCamera_active");
    var_4 maps\_utility::ent_flag_set("FLAG_apache_gunCamera_active");
    var_3 vehicle_scripts\_chopper_player_missile_defense::hud_update();
    var_4 maps\_hud_util::fade_in();
    var_4 waittill("LISTEN_pilotAndGunCameraSwitch");
    var_4 thread maps\_utility::play_sound_on_entity("apache_pilot_guncamera_switch");
    var_4 maps\_hud_util::fade_out();
    wait 0.2;
    var_0 maps\_utility::ent_flag_clear("FLAG_gunCamera_active");
    var_4 maps\_utility::ent_flag_clear("FLAG_apache_gunCamera_active");
    var_1 vehicle_scripts\_apache_player_pilot::_start();
    var_0 maps\_utility::ent_flag_set("FLAG_pilot_active");
    var_4 maps\_utility::ent_flag_set("FLAG_apache_pilot_active");
    var_3 vehicle_scripts\_chopper_player_missile_defense::hud_update();
    var_4 maps\_hud_util::fade_in();
  }
}

monitorsprint() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  self endon("LISTEN_heli_end");
  var_1 notifyonplayercommand("LISTEN_sprinting_start", "+sprint_zoom");
  var_1 notifyonplayercommand("LISTEN_sprinting_stop", "-sprint_zoom");
  var_1 notifyonplayercommand("LISTEN_sprinting_start", "+sprint");
  var_1 notifyonplayercommand("LISTEN_sprinting_stop", "-sprint");
  var_1 notifyonplayercommand("LISTEN_sprinting_start", "+breath_sprint");
  var_1 notifyonplayercommand("LISTEN_sprinting_stop", "-breath_sprint");
  var_2 = gettime();

  for(;;) {
    var_1 waittill("LISTEN_sprinting_start");
    var_0 maps\_utility::ent_flag_set("FLAG_sprinting");
    setsaveddvar("vehHelicopterMaxSpeed", 160);
    setsaveddvar("vehHelicopterMaxAccel", 180);
    var_1 common_scripts\utility::waittill_notify_or_timeout("LISTEN_sprinting_stop", 4.0);
    var_0 maps\_utility::ent_flag_clear("FLAG_sprinting");
    setsaveddvar("vehHelicopterMaxSpeed", 120);
    setsaveddvar("vehHelicopterMaxAccel", 60);
    wait 4.0;
  }
}

monitormachinegun() {
  var_0 = self.heli.owner;
  var_1 = self.mgturret[0];
  var_1 hide();
  self endon("LISTEN_heli_end");
  common_scripts\utility::flag_wait("introscreen_complete");
  thread monitormachinegun_onstop();
  var_2 = 0;

  for(;;) {
    wait 0.05;
    var_3 = var_0 attackbuttonpressed() && !var_1.overheated;

    if(var_2 == var_3) {
      continue;
    }
    var_2 = var_3;

    if(var_2) {
      var_0 playrumblelooponentity("minigun_rumble");
      continue;
    }

    var_0 stoprumble("minigun_rumble");
  }
}

monitormachinegun_onstop() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  self waittill("LISTEN_heli_end");
  var_1 stoprumble("minigun_rumble");
}

monitormoveup() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  self endon("LISTEN_heli_end");
  var_1 notifyonplayercommand("LISTEN_apache_player_start_move_up", "+smoke");
  var_1 notifyonplayercommand("LISTEN_apache_player_stop_move_up", "-smoke");

  for(;;) {
    var_1 waittill("LISTEN_apache_player_start_move_up");
    var_1 maps\_utility::ent_flag_set("FLAG_apache_player_move_up");
    var_1 maps\_utility::ent_flag_set("FLAG_apache_player_used_move_up");
    var_1 waittill("LISTEN_apache_player_stop_move_up");
    var_1 maps\_utility::ent_flag_clear("FLAG_apache_player_move_up");
  }
}

monitormovedown() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  self endon("LISTEN_heli_end");
  var_1 notifyonplayercommand("LISTEN_apache_player_start_move_down", "+toggleads_throw");
  var_1 notifyonplayercommand("LISTEN_apache_player_start_move_down", "+speed_throw");
  var_1 notifyonplayercommand("LISTEN_apache_player_start_move_down", "+speed");
  var_1 notifyonplayercommand("LISTEN_apache_player_start_move_down", "+ads_akimbo_accessible");
  var_1 notifyonplayercommand("LISTEN_apache_player_stop_move_down", "-toggleads_throw");
  var_1 notifyonplayercommand("LISTEN_apache_player_stop_move_down", "-speed_throw");
  var_1 notifyonplayercommand("LISTEN_apache_player_stop_move_down", "-speed");
  var_1 notifyonplayercommand("LISTEN_apache_player_stop_move_down", "-ads_akimbo_accessible");

  for(;;) {
    var_1 waittill("LISTEN_apache_player_start_move_down");
    var_1 maps\_utility::ent_flag_set("FLAG_apache_player_move_down");
    var_1 maps\_utility::ent_flag_set("FLAG_apache_player_used_move_down");
    var_1 waittill("LISTEN_apache_player_stop_move_down");
    var_1 maps\_utility::ent_flag_clear("FLAG_apache_player_move_down");
  }
}

removealtituedmesh() {
  var_0 = getEntArray("apache_player_mesh", "targetname");
  common_scripts\utility::array_call(var_0, ::delete);
}

monitoraltitude() {
  disable_altitude_control();
  self endon("monitor_altitude_disable");
  self endon("LISTEN_heli_end");
  var_0 = common_scripts\utility::getstruct("struct_altitude_trace_start", "targetname");
  var_1 = common_scripts\utility::getstruct("struct_altitude_offset", "targetname");
  var_2 = common_scripts\utility::getstruct("struct_altitude_trace_end", "targetname");
  var_3 = common_scripts\utility::getstruct("struct_altitude_default", "targetname");

  if(!isDefined(var_3) || !isDefined(var_1) || !isDefined(var_0) || !isDefined(var_2)) {
    return;
  }
  var_4 = var_1.origin[2] - var_3.origin[2];
  var_5 = var_1.origin[2];
  var_6 = var_0.origin[2];
  var_7 = var_2.origin[2];
  var_8 = getEntArray("apache_player_mesh", "targetname");
  var_9 = (0, 0, var_4);

  foreach(var_11 in var_8) {
    if(!isDefined(var_11.altitude_adjusted)) {
      var_11.origin = var_11.origin + var_9;
      var_11.altitude_adjusted = 1;
    }
  }

  var_13 = -1;

  for(;;) {
    var_14 = (self.origin[0], self.origin[1], var_6);
    var_15 = (self.origin[0], self.origin[1], var_7);
    var_16 = bulletTrace(var_14, var_15, 0);
    var_17 = var_16["position"][2];

    if(abs(var_17 - var_15[2]) <= 0.2)
      var_17 = var_5;

    if(var_13 != var_17) {
      var_13 = var_17;
      var_18 = var_17 - var_4;

      if(isDefined(self.alt_override))
        var_18 = max(var_18, self.alt_override);

      setsaveddvar("vehHelicopterMinAltitude", var_18);
      setsaveddvar("vehHelicopterMaxAltitude", var_18);
    }

    wait 0.05;
  }
}

get_altitude_min() {
  var_0 = common_scripts\utility::getstruct("struct_altitude_offset", "targetname");
  var_1 = common_scripts\utility::getstruct("struct_altitude_trace_end", "targetname");
  var_2 = common_scripts\utility::getstruct("struct_altitude_default", "targetname");
  return var_2.origin[2] - (var_0.origin[2] - var_1.origin[2]);
}

disable_altitude_control() {
  self notify("monitor_altitude_disable");
}

enable_altitude_control() {
  thread monitoraltitude();
}

altitude_override_over_time(var_0, var_1) {
  self notify("altitude_min_override");
  self endon("altitude_min_override");
  self endon("LISTEN_heli_end");

  if(isDefined(var_1) && var_1 > 0) {
    if(!isDefined(self.alt_override))
      self.alt_override = get_altitude_min();

    var_1 = max(var_1, 0.05);
    var_2 = self.alt_override;

    for(var_3 = 0; var_3 <= var_1; var_3 = var_3 + 0.05) {
      self.alt_override = var_2 + var_3 / var_1 * (var_0 - var_2);
      wait 0.05;
    }
  }

  self.alt_override = var_0;
  return 1;
}

altitude_min_override(var_0, var_1) {
  altitude_override_over_time(var_0, var_1);
}

altitude_min_override_remove(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    var_1 = get_altitude_min();
    var_2 = altitude_override_over_time(var_1, var_0);

    if(isDefined(var_2) && var_2) {
      self.alt_override = undefined;
      return;
    }
  } else
    self.alt_override = undefined;
}

#using_animtree("script_model");

monitorcockpitanims() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  self endon("LISTEN_heli_end");
  self endon("ENT_FLAG_heli_destroyed");
  var_0.cockpit_tubes.jiggle_disabled = [];
  var_0.cockpit_tubes.jiggle_disabled["ALL"] = 0;
  var_0.cockpit_tubes.jiggle_disabled["RIGHT"] = 0;
  var_0.cockpit_tubes.jiggle_disabled["LEFT"] = 0;
  childthread monitorcockpitanims_ondamage();
  var_0.cockpit_tubes.anims_curr = [];
  var_0.cockpit_tubes.anims_curr["ALL"] = undefined;
  var_0.cockpit_tubes.anims_curr["RIGHT"] = undefined;
  var_0.cockpit_tubes.anims_curr["LEFT"] = undefined;
  var_2 = 0.25 * getdvarfloat("vehHelicopterMaxSpeed");
  var_3 = 0.5 * getdvarfloat("vehHelicopterMaxSpeed");
  var_4 = 1.0 * getdvarfloat("vehHelicopterMaxSpeed");
  var_5 = ["ALL", "RIGHT", "LEFT"];

  for(;;) {
    var_6 = [];
    var_7 = var_0.vehicle vehicle_getspeed();

    if(var_7 <= var_2) {
      var_6["ALL"] = % apache_cockpit_idle_at_rest;
      var_6["RIGHT"] = % apache_cockpit_tube_right_at_rest;
      var_6["LEFT"] = % apache_cockpit_tube_left_at_rest;
    } else if(var_7 <= var_3) {
      var_6["ALL"] = % apache_cockpit_idle_moving_slow;
      var_6["RIGHT"] = % apache_cockpit_tube_right_moving_slow;
      var_6["LEFT"] = % apache_cockpit_tube_left_moving_slow;
    } else if(var_7 <= var_4) {
      var_6["ALL"] = % apache_cockpit_idle_moving_fast;
      var_6["RIGHT"] = % apache_cockpit_tube_right_moving_fast;
      var_6["LEFT"] = % apache_cockpit_tube_left_moving_fast;
    } else {
      var_6["ALL"] = undefined;
      var_6["RIGHT"] = undefined;
      var_6["LEFT"] = undefined;
    }

    if(isDefined(var_6["ALL"]) && (!isDefined(var_0.cockpit_tubes.anims_curr["ALL"]) || var_0.cockpit_tubes.anims_curr["ALL"] != var_6["ALL"])) {
      var_0.cockpit_tubes useanimtree(#animtree);

      foreach(var_9 in var_5) {
        if(!var_0.cockpit_tubes.jiggle_disabled[var_9]) {
          if(isDefined(var_0.cockpit_tubes.anims_curr[var_9]))
            var_0.cockpit_tubes clearanim(var_0.cockpit_tubes.anims_curr[var_9], 0.2);

          if(isDefined(var_6[var_9]))
            var_0.cockpit_tubes setanim(var_6[var_9], 1, 0.2, 1.0);
        }
      }

      var_0.cockpit_tubes.anims_curr["ALL"] = var_6["ALL"];
      var_0.cockpit_tubes.anims_curr["RIGHT"] = var_6["RIGHT"];
      var_0.cockpit_tubes.anims_curr["LEFT"] = var_6["LEFT"];
    }

    wait 0.25;
  }
}

monitorcockpitanims_ondamage() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = ["RIGHT", "LEFT"];

  while(var_7.size > 0) {
    var_8 = undefined;

    for(;;) {
      self waittill("LISTEN_apache_damage_state_enter", var_8);

      if(var_8 == "health_none") {
        break;
      }
    }

    var_9 = var_7[randomint(var_7.size)];
    var_7 = common_scripts\utility::array_remove(var_7, var_9);

    if(!var_0.cockpit_tubes.jiggle_disabled[var_9]) {
      var_0.cockpit_tubes clearanim(var_0.cockpit_tubes.anims_curr[var_9], 0.5);
      var_0.cockpit_tubes.jiggle_disabled[var_9] = 1;
    }

    if(var_9 == "RIGHT") {
      var_2 = % apache_cockpit_tube_right_whip_in;
      var_3 = % apache_cockpit_tube_right_whip;
      var_4 = % apache_cockpit_tube_right_whip_out;
      var_5 = % apache_cockpit_tube_right_idle;
      var_6 = "r_innertubeend_jnt";
    } else if(var_9 == "LEFT") {
      var_2 = % apache_cockpit_tube_left_whip_in;
      var_3 = % apache_cockpit_tube_left_whip;
      var_4 = % apache_cockpit_tube_left_whip_out;
      var_5 = % apache_cockpit_tube_left_idle;
      var_6 = "l_innertubeend_jnt";
    }

    childthread monitorcockpitanims_tube_whip(var_2, var_3, var_4, var_5, var_6);
  }
}

monitorcockpitanims_tube_whip(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.heli;
  var_6 = var_5.owner;
  playFXOnTag(common_scripts\utility::getfx("apache_player_cockpit_pipe_hiss"), var_5.cockpit_tubes, var_4);
  var_5.cockpit_tubes thread maps\_utility::play_loop_sound_on_tag("apache_player_tube_hiss", var_4, 1);
  var_5.cockpit_tubes setanim(var_0, 1, 0.5, 1.0);
  var_7 = getanimlength(var_0);
  wait(var_7 - min(0.5, var_7 * 0.1));
  var_5.cockpit_tubes clearanim(var_0, 0.5);
  var_5.cockpit_tubes setanim(var_1, 1, 0.5, 1.0);
  var_7 = getanimlength(var_1);
  wait 1.0;
  var_5.cockpit_tubes clearanim(var_1, 0.5);
  var_5.cockpit_tubes setanim(var_2, 1, 0.5, 1.0);
  var_7 = getanimlength(var_2);
  wait(var_7 - min(0.5, var_7 * 0.1));
  var_5.cockpit_tubes clearanim(var_2, 0.5);
  stopFXOnTag(common_scripts\utility::getfx("apache_player_cockpit_pipe_hiss"), var_5.cockpit_tubes, var_4);
  var_5.cockpit_tubes notify("stop soundapache_player_tube_hiss");
  var_5.cockpit_tubes setanim(var_3, 1, 0.5, 1.0);
}

monitorhealth() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  self endon("LISTEN_heli_end");
  self endon("ENT_FLAG_heli_destroyed");
  apache_health_init(100000);
  maps\_vehicle::godon();
  maps\_utility::ent_flag_init("ENT_FLAG_heli_damaged");
  maps\_utility::ent_flag_init("ENT_FLAG_heli_health_state_finished");
  maps\_utility::ent_flag_init("ENT_FLAG_heli_destroyed");
  thread monitorhealth_ondamage();
  thread monitorhealth_ondeath();
  thread monitorhealth_damagestates();
  var_2 = 0;
  var_3 = "STATE_FULL";

  for(;;) {
    common_scripts\utility::waittill_any("ENT_FLAG_heli_damaged", "ENT_FLAG_heli_health_state_finished");
    waittillframeend;

    if(maps\_utility::ent_flag("ENT_FLAG_heli_health_state_finished")) {
      var_3 = apache_health_state_next(var_3);
      childthread apache_health_state_think(var_3);
      var_2 = 0;
      maps\_utility::ent_flag_clear("ENT_FLAG_heli_health_state_finished");
    }

    if(maps\_utility::ent_flag("ENT_FLAG_heli_damaged")) {
      apache_health_adjust(-1 * self.apache_dmg_recent);
      var_2 = var_2 + self.apache_dmg_recent;
      var_4 = undefined;

      switch (var_3) {
        case "STATE_REGEN":
        case "STATE_PAIN":
        case "STATE_FULL":
          if(apache_health_get() == 0)
            var_4 = "STATE_INVULN";
          else
            var_4 = "STATE_PAIN";

          break;
        case "STATE_INVULN":
          break;
        case "STATE_VULN":
          if(var_2 / apache_health_max_get() >= 0.15) {
            maps\_utility::ent_flag_set("ENT_FLAG_heli_destroyed");
            common_scripts\utility::flag_set("FLAG_apache_crashing");
          }

          break;
      }

      if(isDefined(var_4)) {
        var_3 = var_4;
        childthread apache_health_state_think(var_3);
        var_2 = 0;
      }

      self.apache_dmg_recent = 0;
      maps\_utility::ent_flag_clear("ENT_FLAG_heli_damaged");
    }
  }
}

apache_health_state_think(var_0) {
  self notify("apache_health_state_think_new");
  self endon("apache_health_state_think_new");
  self endon("LISTEN_heli_end");

  switch (var_0) {
    case "STATE_FULL":
      level waittill("forever");
      break;
    case "STATE_PAIN":
      wait 3.0;
      break;
    case "STATE_INVULN":
      wait 1.0;
      break;
    case "STATE_VULN":
      wait 4.0;
      break;
    case "STATE_REGEN":
      if(apache_health_pct_get() < 0.4)
        apache_health_pct_set(0.4);

      var_1 = int(max((apache_health_max_get() - apache_health_get()) / 200.0, 1));

      while(!apache_health_at_max()) {
        wait 0.05;
        apache_health_adjust(var_1);
      }

      break;
    default:
      break;
  }

  maps\_utility::ent_flag_set("ENT_FLAG_heli_health_state_finished");
}

apache_health_state_next(var_0) {
  var_1 = "";

  switch (var_0) {
    case "STATE_FULL":
      break;
    case "STATE_VULN":
    case "STATE_PAIN":
      var_1 = "STATE_REGEN";
      break;
    case "STATE_INVULN":
      var_1 = "STATE_VULN";
      break;
    case "STATE_REGEN":
      var_1 = "STATE_FULL";
      break;
    default:
      break;
  }

  return var_1;
}

monitorhealth_ondamage() {
  self endon("LISTEN_heli_end");
  var_0 = self.heli;
  var_1 = var_0.owner;
  self.apache_dmg_recent = 0;
  self.apache_dmg_time = gettime();
  var_2 = int(max(level.apache_player_difficulty.dmg_bullet_pct * apache_health_max_get(), 1));
  var_3 = int(max(level.apache_player_difficulty.dmg_projectile_pct * apache_health_max_get(), 1));

  for(;;) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(!isDefined(var_5)) {
      continue;
    }
    if(getteam() == var_5 getteam()) {
      continue;
    }
    if(!isDefined(var_8)) {
      continue;
    }
    var_14 = gettime();

    if(var_8 == "MOD_RIFLE_BULLET" || var_8 == "MOD_PISTOL_BULLET") {
      var_15 = common_scripts\utility::ter_op(isai(var_5), 15, 1);

      if(var_14 - self.apache_dmg_time <= level.apache_player_difficulty.dmg_bullet_delay_between_msec * var_15) {
        continue;
      }
      if(apache_health_pct_get() <= level.apache_player_difficulty.dmg_player_health_adjust_chance) {
        var_16 = level.apache_player_difficulty.dmg_player_speed_evade_min_pct * getdvarfloat("vehHelicopterMaxSpeed");
        var_17 = level.apache_player_difficulty.dmg_player_speed_evade_max_pct * getdvarfloat("vehHelicopterMaxSpeed");
        var_18 = clamp(self vehicle_getspeed(), var_17, var_16);
        var_19 = 1 - (var_18 - var_17) / (var_16 - var_17);
        var_20 = level.apache_player_difficulty.dmg_bullet_chance_player_evade + (level.apache_player_difficulty.dmg_bullet_chance_player_static - level.apache_player_difficulty.dmg_bullet_chance_player_static) * var_19;

        if(randomfloat(1.0) >= var_20)
          continue;
      }
    }

    if(common_scripts\utility::cointoss())
      self playSound("apache_impact");

    var_21 = undefined;

    switch (var_8) {
      case "MOD_RIFLE_BULLET":
      case "MOD_PISTOL_BULLET":
      case "MOD_EXPLOSIVE":
        var_21 = var_2;
        break;
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        var_21 = var_3;
        level.lastplayerapachedamage = gettime();
        break;
      default:
        var_21 = var_2;
        break;
    }

    if(isDefined(var_13) && var_13 == "hind_turret")
      var_21 = var_2;

    self.apache_dmg_time = var_14;
    self.apache_dmg_recent = var_21;
    maps\_utility::ent_flag_set("ENT_FLAG_heli_damaged");
  }
}

monitorhealth_ondeath_fx() {
  self endon("LISTEN_heli_end");
  var_0 = self.heli;
  var_1 = var_0.owner;
  var_2 = self;
  playFXOnTag(common_scripts\utility::getfx("apache_player_dlight_red_flicker"), var_2, "tag_dial3");
  var_2 hidepart("tag_glass_damage");
  var_2 hidepart("tag_glass_damage1");
  var_2 showpart("tag_glass_damage2");
  var_2 thread maps\_utility::play_sound_on_tag("apache_player_glass_crack_lrg", "tag_glass_damage1");
  var_1 digitaldistortsetparams(0.4, 1.0);
}

monitorhealth_ondeath() {
  self endon("LISTEN_heli_end");
  var_0 = common_scripts\utility::waittill_any_return("death", "ENT_FLAG_heli_destroyed");

  if(var_0 == "ENT_FLAG_heli_destroyed") {
    monitorhealth_damagestates_cleanup();
    monitorhealth_ondeath_fx();
    thread maps\_vehicle_code::death_firesound("apache_player_dying_alarm");
    self notify("LISTEN_pilot_death");
    wait 0.5;
    var_1 = 2.0;
    thread monitorhealth_ondeath_apache_crash();
    thread monitorhealth_ondeath_player_feedback(var_1);
    thread maps\_vehicle_code::death_firesound("apache_player_dying_loop");
    common_scripts\utility::waittill_any_timeout_no_endon_death(var_1, "crash_done");
  }

  if(isDefined(level.lastplayerapachedamage) && gettime() - level.lastplayerapachedamage < 4000)
    maps\_player_death::grenade_death_hint(&"OILROCKS_KILLED_BY_MISSILE", &"OILROCKS_HINT_APACHE_FLARES");
  else
    setdvar("ui_deadquote", "");

  maps\_utility::missionfailedwrapper();
}

monitorhealth_ondeath_apache_crash() {
  var_0 = self.heli;
  var_1 = var_0.owner;
  self.perferred_crash_location = spawnStruct();
  self.perferred_crash_location.script_parameters = "direct";
  self.perferred_crash_location.radius = 60;

  if(self vehicle_getspeed() > 40)
    self vehicle_setspeedimmediate(40);

  var_2 = 600;
  var_3 = bulletTrace(self.origin - 160, self.origin - (0, 0, var_2), 0, self);

  if(var_3["fraction"] > 0.98)
    self.perferred_crash_location.origin = self.origin - (0, 0, var_2);
  else
    self.perferred_crash_location.origin = self.origin + (0, 0, var_2);

  maps\_vehicle_code::helicopter_crash_move();
}

monitorhealth_ondeath_player_feedback(var_0) {
  var_1 = self.heli;
  var_2 = var_1.owner;
  var_2 enabledeathshield(1);
  var_2 playrumblelooponentity("damage_heavy");

  for(;;) {
    var_2 dodamage(40, var_2.origin);
    earthquake(0.3, 1.0, var_2.origin, 512);
    var_3 = max(min(var_0 * 0.5, 1.0), 0.25);
    var_0 = var_0 - var_3;
    wait(var_3);
  }
}

monitorhealth_damagestates_cleanup() {
  var_0 = self;
  var_1 = self.heli;

  foreach(var_3 in var_1.damage_states)
  var_3 damage_state_clear(0);

  var_0 damage_state_tag_ent_clear_all();
}

monitorhealth_damagestates() {
  self endon("LISTEN_heli_end");
  var_0 = self.heli;
  var_1 = var_0.owner;
  self hidepart("tag_glass_damage1");
  self hidepart("tag_glass_damage2");
  self hidepart("tag_dial1");
  var_0.damage_states = [];
  var_2 = damage_state_build(0.01, self, 0.2, 1.0, 0.275, 1.0, 750);
  var_2 damage_state_notify_add("health_none");
  var_2 damage_state_fx_add("apache_player_cockpit_smoke", "tag_front", 0);
  var_2 damage_state_fx_add("apache_player_dlight_red_flicker", "tag_dial4", 0);
  var_2 damage_state_fx_add("apache_player_cockpit_sparks_v2", "tag_cable_up_front_left", 0);
  var_2 damage_state_fx_add("apache_player_cockpit_sparks_v2", "tag_cable_up_right", 0);
  var_2 damage_state_prt_add("tag_glass_damage1", 1, "tag_glass_damage", 2, "apache_player_glass_crack_sml");
  var_2 damage_state_prt_add("tag_glass_damage2", 1, "tag_glass_damage1", 3, "apache_player_glass_crack_lrg");
  var_2 damage_state_prt_add("tag_dial1", 0, "tag_dial_on", 1);
  var_2 damage_state_snd_add("apache_player_damaged_alarm", "tag_player", 0, 1);
  var_0.damage_states[var_0.damage_states.size] = var_2;
  var_2 = damage_state_build(0.25, self, 0.1, 1.0, 0.2, 1.0, 1000);
  var_2 damage_state_fx_add("apache_player_cockpit_smoke", "tag_front", 0);
  var_2 damage_state_fx_add("apache_player_cockpit_sparks_v1", "tag_cable_up_front_left", 0);
  var_2 damage_state_fx_add("apache_player_cockpit_sparks_v1", "tag_cable_up_right", 0);
  var_2 damage_state_prt_add("tag_dial1", 0, "tag_dial_on", 1);
  var_2 damage_state_snd_add("apache_player_damaged_25_percent_alarm", "tag_player", 0, 1);
  var_0.damage_states[var_0.damage_states.size] = var_2;
  var_2 = damage_state_build(0.55, self, 0.05, 1.0, 0.15, 1.0, 1300);
  var_2 damage_state_fx_add("apache_player_cockpit_smoke", "tag_front", 0);
  var_2 damage_state_fx_add("apache_player_cockpit_sparks_v1", "tag_cable_up_front_left", 0);
  var_2 damage_state_snd_add("apache_player_damaged_55_percent_alarm", "tag_player", 0, 1);
  var_0.damage_states[var_0.damage_states.size] = var_2;
  var_2 = damage_state_build(0.85, self, 0.025, 1.0, 0.1, 1.0, 1500);
  var_2 damage_state_snd_add("apache_player_damaged_85_percent_alarm", "tag_player", 0, 1);
  var_0.damage_states[var_0.damage_states.size] = var_2;
  var_2 = damage_state_build(1.0, self, 0.0, 1.0, 0.0, 0.0, 0.0);
  var_0.damage_states[var_0.damage_states.size] = var_2;
  var_0.damage_states = common_scripts\utility::array_sort_by_handler(var_0.damage_states, ::damage_state_health_pct_get);
  var_5 = damage_state_choose(var_0.damage_states, apache_health_pct_get());
  var_5 damage_state_apply(0, 1);
  var_6 = apache_health_pct_get();
  var_7 = gettime();

  for(;;) {
    self waittill("apache_player_health_updated");
    waittillframeend;
    var_8 = apache_health_pct_get();
    var_9 = damage_state_choose(var_0.damage_states, var_8);

    if(var_8 < var_6 || var_8 <= 0) {
      var_10 = var_9 damage_state_quake(var_7);

      if(var_10)
        var_7 = gettime();
    }

    var_6 = var_8;

    if(var_9 == var_5) {
      continue;
    }
    if(var_9.health_pct < var_5.health_pct) {
      for(var_11 = var_0.damage_states.size - 1; var_11 >= 0; var_11--) {
        var_2 = var_0.damage_states[var_11];

        if(var_2 == var_9) {
          break;
        }

        var_2 damage_state_apply(1);
      }
    }

    var_5 damage_state_clear(1);
    var_5 damage_state_notify_send_exit();
    var_9 damage_state_apply(0);
    var_9 damage_state_notify_send_enter();
    var_5 = var_9;
  }
}

damage_state_choose(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_1 <= var_4.health_pct) {
      var_2 = var_4;
      break;
    }
  }

  return var_2;
}

damage_state_build(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.health_pct = var_0;
  var_7.perm_on = 0;
  var_7.temp_on = 0;
  var_7.distort_pct = var_2;
  var_7.distort_time = var_3;
  var_7.quake_scale = var_4;
  var_7.quake_time = var_5;
  var_7.quake_interval_msec = var_6;
  var_7.vehicle = var_1;
  var_7.notify_msg = undefined;
  var_7.fx_array = [];
  var_7.prt_array = [];
  var_7.snd_array = [];
  return var_7;
}

damage_state_apply(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in self.fx_array) {
    if(var_3["perm"] && self.perm_on) {
      continue;
    }
    if(!var_3["perm"] && (var_0 || self.temp_on)) {
      continue;
    }
    damage_state_play_fx_on_tag(var_3);
  }

  foreach(var_7, var_6 in self.prt_array) {
    if(var_6["perm"] && var_6["activations"] <= 0) {
      continue;
    }
    if(!var_6["perm"] && (var_0 || var_6["activations"] <= 0)) {
      continue;
    }
    self.prt_array[var_7]["activations"]--;

    if(self.prt_array[var_7]["activations"] > 0) {
      continue;
    }
    if(isDefined(var_6["tag_hide"]))
      self.vehicle hidepart(var_6["tag_hide"]);

    self.vehicle showpart(var_6["tag_show"]);

    if(isDefined(var_6["sound"]))
      self.vehicle thread maps\_utility::play_sound_on_tag(var_6["sound"], var_6["tag_show"]);
  }

  foreach(var_9 in self.snd_array) {
    if(var_9["perm"] && self.perm_on) {
      continue;
    }
    if(!var_9["perm"] && (var_0 || self.temp_on)) {
      continue;
    }
    if(var_9["loop"]) {
      self.vehicle thread maps\_utility::play_loop_sound_on_tag(var_9["alias"], var_9["tag"], 1, 1);
      continue;
    }

    self.vehicle thread maps\_utility::play_sound_on_tag(var_9["alias"], var_9["tag"]);
  }

  if(!var_1 && !var_0 && isDefined(self.distort_pct) && isDefined(self.distort_time))
    self.vehicle.heli.owner digitaldistortsetparams(self.distort_pct, self.distort_time);

  if(!self.perm_on)
    self.perm_on = 1;

  if(!var_0 && !self.temp_on)
    self.temp_on = 1;
}

damage_state_clear(var_0) {
  foreach(var_2 in self.fx_array) {
    if(var_2["perm"] && (var_0 || !self.perm_on)) {
      continue;
    }
    if(!var_2["perm"] && !self.temp_on) {
      continue;
    }
    damage_state_stop_fx_on_tag(var_2);
  }

  foreach(var_6, var_5 in self.prt_array) {
    if(var_5["perm"] && (var_0 || var_5["activations"] > 0)) {
      continue;
    }
    if(!var_5["perm"] && var_5["activations"] > 0) {
      continue;
    }
    self.prt_array[var_6]["activations"]++;

    if(isDefined(var_5["tag_hide"]))
      self.vehicle showpart(var_5["tag_hide"]);

    self.vehicle hidepart(var_5["tag_show"]);
  }

  foreach(var_8 in self.snd_array) {
    if(!var_8["loop"]) {
      continue;
    }
    if(var_8["perm"] && (var_0 || !self.perm_on)) {
      continue;
    }
    if(!var_8["perm"] && !self.temp_on) {
      continue;
    }
    self.vehicle notify("stop sound" + var_8["alias"]);
  }

  if(isDefined(self.distort_pct) && isDefined(self.distort_time))
    self.vehicle.heli.owner digitaldistortsetparams(0.0, 0.0);

  if(self.perm_on && !var_0)
    self.perm_on = 0;

  if(self.temp_on)
    self.temp_on = 0;
}

damage_state_quake(var_0) {
  var_1 = 0;

  if(self.quake_scale > 0 && gettime() - var_0 >= self.quake_interval_msec) {
    earthquake(self.quake_scale, self.quake_time, self.vehicle.heli.owner.origin, 1024);
    self.vehicle.heli.owner playrumbleonentity("damage_light");
    var_1 = 1;
  }

  return var_1;
}

damage_state_health_pct_get() {
  return self.health_pct;
}

damage_state_fx_add(var_0, var_1, var_2) {
  var_3 = [];
  var_3["fx"] = var_0;
  var_3["tag"] = var_1;
  var_3["perm"] = var_2;
  self.fx_array[self.fx_array.size] = var_3;
}

damage_state_prt_add(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["tag_show"] = var_0;
  var_5["perm"] = var_1;

  if(isDefined(var_2))
    var_5["tag_hide"] = var_2;

  var_5["activations"] = common_scripts\utility::ter_op(isDefined(var_3), int(max(var_3, 1)), 1);

  if(isDefined(var_4))
    var_5["sound"] = var_4;

  self.prt_array[self.prt_array.size] = var_5;
}

damage_state_snd_add(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["alias"] = var_0;
  var_4["tag"] = var_1;
  var_4["perm"] = var_2;
  var_4["loop"] = var_3;
  self.snd_array[self.snd_array.size] = var_4;
}

damage_state_notify_add(var_0) {
  self.notify_msg = var_0;
}

damage_state_notify_send_enter() {
  if(isDefined(self.notify_msg))
    self.vehicle notify("LISTEN_apache_damage_state_enter", self.notify_msg);
}

damage_state_notify_send_exit() {
  if(isDefined(self.notify_msg))
    self.vehicle notify("LISTEN_apache_damage_state_exit", self.notify_msg);
}

damage_state_tag_ent_get(var_0) {
  if(!isDefined(self.vehicle.damage_state_tag_ents))
    self.vehicle.damage_state_tag_ents = [];

  if(!isDefined(self.vehicle.damage_state_tag_ents[var_0])) {
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = self.vehicle gettagorigin(var_0);
    var_1.angles = self.vehicle gettagangles(var_0);
    var_1 linkto(self.vehicle, var_0);
    self.vehicle.damage_state_tag_ents[var_0] = var_1;
  }

  return self.vehicle.damage_state_tag_ents[var_0];
}

damage_state_tag_ent_clear_all() {
  if(isDefined(self.damage_state_tag_ents)) {
    foreach(var_1 in self.damage_state_tag_ents)
    var_1 delete();

    self.damage_state_tag_ents = undefined;
  }
}

damage_state_play_fx_on_tag(var_0) {
  var_1 = damage_state_tag_ent_get(var_0["tag"]);
  playFXOnTag(common_scripts\utility::getfx(var_0["fx"]), var_1, "tag_origin");
}

damage_state_stop_fx_on_tag(var_0) {
  var_1 = damage_state_tag_ent_get(var_0["tag"]);
  stopFXOnTag(common_scripts\utility::getfx(var_0["fx"]), var_1, "tag_origin");
}

apache_health_init(var_0, var_1) {
  self.apache_health = var_0;
  self.apache_health_max = common_scripts\utility::ter_op(isDefined(var_1), var_1, var_0);
}

apache_health_get() {
  return self.apache_health;
}

apache_health_pct_get() {
  return apache_health_get() / apache_health_max_get();
}

apache_health_at_max() {
  return apache_health_get() >= apache_health_max_get();
}

apache_health_set(var_0) {
  var_1 = common_scripts\utility::ter_op(isDefined(self.apache_health_min), self.apache_health_min, 0);
  self.apache_health = int(clamp(var_0, var_1, apache_health_max_get()));
  self notify("apache_player_health_updated");
}

apache_health_pct_set(var_0) {
  apache_health_set(apache_health_max_get() * var_0);
}

apache_health_pct_min_set(var_0) {
  self.apache_health_min = int(apache_health_max_get() * var_0);
}

apache_health_pct_min_clear() {
  self.apache_health_min = undefined;
}

apache_health_adjust(var_0) {
  var_1 = apache_health_get() + var_0;
  apache_health_set(var_1);
}

apache_health_max_get() {
  return self.apache_health_max;
}

apache_health_max_set(var_0) {
  self.apache_health_max = var_0;
}

hud_addandshowtargets(var_0, var_1) {
  common_scripts\utility::lock("add_apache_target_lock");
  self.heli.targeting vehicle_scripts\_apache_player_targeting::hud_addtargets(var_0, var_1);
  self.heli.targeting vehicle_scripts\_apache_player_targeting::hud_showtargets(var_0);
  common_scripts\utility::unlock("add_apache_target_lock");
}

hud_addtargets(var_0, var_1) {
  self.heli.targeting vehicle_scripts\_apache_player_targeting::hud_addtargets(var_0, var_1);
}

hud_showtargets(var_0) {
  self.heli.targeting vehicle_scripts\_apache_player_targeting::hud_showtargets(var_0);
}

hud_hidetargets(var_0) {
  self.heli.targeting vehicle_scripts\_apache_player_targeting::hud_hidetargets(var_0);
}

hud_color_ally() {
  return vehicle_scripts\_apache_player_targeting::hud_color_ally();
}

hud_set_target_locked(var_0) {
  vehicle_scripts\_apache_player_targeting::hud_set_target_locked(var_0);
}

hud_set_target_default(var_0) {
  vehicle_scripts\_apache_player_targeting::hud_set_target_default(var_0);
}

getteam() {
  if(isturret(self) && isDefined(self.script_team))
    return self.script_team;

  if(maps\_vehicle::isvehicle() && isDefined(self.script_team))
    return self.script_team;

  if(isDefined(self.team))
    return self.team;

  return "none";
}

isturret(var_0) {
  return isDefined(var_0) && isDefined(var_0.classname) && issubstr(var_0.classname, "turret");
}
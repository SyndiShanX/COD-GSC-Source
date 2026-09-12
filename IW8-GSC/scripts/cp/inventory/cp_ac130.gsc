/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\inventory\cp_ac130.gsc
***********************************************/

function init() {
  level._effect["angel_flare_geotrail"] = loadfx("fx/smoke/angel_flare_geotrail");
  level._effect["angel_flare_swirl"] = loadfx("fx/smoke/angel_flare_swirl_runner");
  level._effect["clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_view_clouds.vfx");
  level._effect["beacon"] = loadfx("vfx/misc/ir_beacon_coop");
  level._effect["ac130_explode"] = loadfx("vfx/core/expl/aerial_explosion_large");
  level._effect["ac130_light_red"] = loadfx("vfx/core/vehicles/aircraft_light_wingtip_red");
  level._effect["ac130_light_white_blink"] = loadfx("vfx/core/vehicles/aircraft_light_white_blink");
  level._effect["ac130_light_red_blink"] = loadfx("vfx/core/vehicles/aircraft_light_red_blink");
  level._effect["camera_shutter"] = loadfx("vfx/iw8_mp/killstreak/vfx_ui_camera_shutter.vfx");
  level._effect["coop_muzzleflash_105mm"] = loadfx("vfx/core/muzflash/ac130_105mm");
  level._effect["coop_muzzleflash_40mm"] = loadfx("vfx/core/muzflash/ac130_40mm");
  level.radioforcedtransmissionqueue = [];
  level.enemieskilledintimewindow = 0;
  level.lastradiotransmission = gettime();
  level.color["white"] = (1, 1, 1);
  level.color["red"] = (1, 0, 0);
  level.color["blue"] = (0.1, 0.3, 1);
  level.cosine = [];
  level.cosine["45"] = cos(45);
  level.cosine["5"] = cos(5);
  level.physicssphereradius["ac130_25mm_mp"] = 60;
  level.physicssphereradius["ac130_40mm_mp"] = 600;
  level.physicssphereradius["ac130_105mm_mp"] = 1000;
  level.physicssphereforce["ac130_25mm_mp"] = 0;
  level.physicssphereforce["ac130_40mm_mp"] = 3;
  level.physicssphereforce["ac130_105mm_mp"] = 6;
  level.weaponreloadtime["ac130_25mm_mp"] = 2;
  level.weaponreloadtime["ac130_40mm_mp"] = 3.5;
  level.weaponreloadtime["ac130_105mm_mp"] = 5.5;
  level.ac130_speed["move"] = 1000;
  level.ac130_speed["moving_platform"] = 5000;
  level.ac130_speed["rotate"] = 70;
  scripts\engine\utility::flag_init("allow_context_sensative_dialog");
  scripts\engine\utility::flag_set("allow_context_sensative_dialog");
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = level.mapcenter;

  if(var_0.size) {
    var_1 = scripts\cp\cp_globallogic::findboxcenter(var_0[0].origin, var_0[1].origin);
  }

  if(isDefined(level.ac130_location)) {
    var_1 = level.ac130_location;
  }

  level.ac130 = spawn("script_model", var_1);
  level.ac130 setModel("tag_origin");
  level.ac130.angles = (0, 115, 0);
  level.ac130.owner = undefined;
  level.ac130.thermal_vision = "ac130_thermal_mp";
  level.ac130.enhanced_vision = "ac130_enhanced_mp";
  level.ac130.targetname = "ac130rig_script_model";
  level.ac130 hide();
  level.ac130inuse = 0;
  thread rotateplane(level.ac130, "on");
  level.ac130_activate_function = &scripts\cp_mp\killstreaks\gunship::tryusegunship;
  level.ac130queue = [];
  init_ac130_vo();
}

function ac130activatefunc(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("ac130", var_0);
  thread tryuseac130(var_1);
}

function forceac130onplayernow(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("ac130", var_0);
  var_2 = "ks_remote_device_mp";
  var_0 scripts\cp\utility::_giveweapon(var_2, 0, 0, 1);
  var_3 = int(tablelookup("mp/killstreaktable.csv", 1, var_1.streakname, 0));
  var_0 setclientomnvar("ui_remote_control_sequence", var_3);
  var_4 = var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_2);
  var_0 scripts\cp\utility::setusingremote(var_1.streakname);
  var_0 notify("ks_freeze_end");
  var_0 setclientomnvar("ui_remote_control_sequence", 0);
  var_0 scripts\cp\utility::clearusingremote();
  var_0 scripts\cp_mp\utility\killstreak_utility::stoptabletscreen();

  if(isDefined(var_2)) {
    var_0 takeweapon(var_2);
  }

  var_0 setclientomnvar("ui_remote_control_sequence", 0);
  var_5 = ac130_startuse(var_0, var_1);

  if(!istrue(var_5)) {
    return 0;
  }
}

function spawn_ambient_ac130(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("ac130", var_0);
  var_2 = ac130_spawn(var_0, var_1);
  return var_2;
}

function weapongivenac130(var_0) {}

function init_ac130_vo() {
  game["dialog"]["ac130_intro"] = "ac130_intro";
  game["dialog"]["ac130_105mm_reloaded"] = "ac130_reload_105mm";
  game["dialog"]["ac130_40mm_reloaded"] = "ac130_reload_40mm";
  game["dialog"]["ac130_25mm_reloaded"] = "ac130_reload_25mm";
  game["dialog"]["ac130_bad_hit"] = "ac130_bad_hit";
  game["dialog"]["ac130_good_hit"] = "ac130_good_hit";
  game["dialog"]["ac130_taking_damage_light"] = "ac130_damage_reaction_light";
  game["dialog"]["ac130_taking_damage_medium"] = "ac130_damage_reaction_medium";
  game["dialog"]["ac130_taking_damage_heavy"] = "ac130_damage_reaction_heavy";
  game["dialog"]["ac130_crashing"] = "ac130_crash";
  game["dialog"]["ac130_flares"] = "ac130_launch_flares";
  game["dialog"]["ac130_missile_lock"] = "ac130_missile_lock";
  game["dialog"]["ac130_multi_spotted"] = "ac130_multi_enemy_spotted";
  game["dialog"]["ac130_single_spotted"] = "ac130_single_enemy_spotted";
  game["dialog"]["ac130_refuel"] = "ac130_refuel";
}

function tryuseac130(var_0) {
  if(isDefined(level.ac130player) || level.ac130inuse) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_1 = scripts\cp\cp_drone_strike::playremotesequence(var_0);

  if(!var_1) {
    self notify("killstreak_finished_with_weapon_" + var_0.weaponname);
    return 0;
  }

  var_1 = ac130_startuse(self, var_0);

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level.ac130player) || istrue(level.ac130inuse)) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  foreach(var_3 in level.players) {
    if(var_3 != self) {
      var_3 thread scripts\cp\cp_hud_message::showsplash("cp_used_ac130", undefined, self);
    }
  }

  level.ac130inuse = 1;
  level notify("ac130InUse", self);
  return var_1;
}

function init_sounds() {
  level.scr_sound["foo"]["bar"] = "";
  add_context_sensitive_dialog("ai", "in_sight", 0, "ac130_fco_moreenemy");
  add_context_sensitive_dialog("ai", "in_sight", 1, "ac130_fco_getthatguy");
  add_context_sensitive_dialog("ai", "in_sight", 2, "ac130_fco_guymovin");
  add_context_sensitive_dialog("ai", "in_sight", 3, "ac130_fco_getperson");
  add_context_sensitive_dialog("ai", "in_sight", 4, "ac130_fco_guyrunnin");
  add_context_sensitive_dialog("ai", "in_sight", 5, "ac130_fco_gotarunner");
  add_context_sensitive_dialog("ai", "in_sight", 6, "ac130_fco_backonthose");
  add_context_sensitive_dialog("ai", "in_sight", 7, "ac130_fco_gonnagethim");
  add_context_sensitive_dialog("ai", "in_sight", 8, "ac130_fco_personnelthere");
  add_context_sensitive_dialog("ai", "in_sight", 9, "ac130_fco_nailthoseguys");
  add_context_sensitive_dialog("ai", "in_sight", 11, "ac130_fco_lightemup");
  add_context_sensitive_dialog("ai", "in_sight", 12, "ac130_fco_takehimout");
  add_context_sensitive_dialog("ai", "in_sight", 14, "ac130_plt_yeahcleared");
  add_context_sensitive_dialog("ai", "in_sight", 15, "ac130_plt_copysmoke");
  add_context_sensitive_dialog("ai", "in_sight", 16, "ac130_fco_rightthere");
  add_context_sensitive_dialog("ai", "in_sight", 17, "ac130_fco_tracking");
  add_context_sensitive_dialog("ai", "in_sight", 0, "ac130_fco_getthatguy");
  add_context_sensitive_dialog("ai", "in_sight", 1, "ac130_fco_guymovin");
  add_context_sensitive_dialog("ai", "in_sight", 2, "ac130_fco_getperson");
  add_context_sensitive_dialog("ai", "in_sight", 3, "ac130_fco_guyrunnin");
  add_context_sensitive_dialog("ai", "in_sight", 4, "ac130_fco_gotarunner");
  add_context_sensitive_dialog("ai", "in_sight", 5, "ac130_fco_backonthose");
  add_context_sensitive_dialog("ai", "in_sight", 6, "ac130_fco_gonnagethim");
  add_context_sensitive_dialog("ai", "in_sight", 7, "ac130_fco_nailthoseguys");
  add_context_sensitive_dialog("ai", "in_sight", 8, "ac130_fco_lightemup");
  add_context_sensitive_dialog("ai", "in_sight", 9, "ac130_fco_takehimout");
  add_context_sensitive_dialog("ai", "in_sight", 10, "ac130_plt_yeahcleared");
  add_context_sensitive_dialog("ai", "in_sight", 11, "ac130_plt_copysmoke");
  add_context_sensitive_dialog("ai", "in_sight", 0, "ac130_fco_moreenemy");
  add_context_sensitive_dialog("ai", "in_sight", 1, "ac130_fco_getthatguy");
  add_context_sensitive_dialog("ai", "in_sight", 2, "ac130_fco_guymovin");
  add_context_sensitive_dialog("ai", "in_sight", 3, "ac130_fco_getperson");
  add_context_sensitive_dialog("ai", "in_sight", 4, "ac130_fco_guyrunnin");
  add_context_sensitive_dialog("ai", "in_sight", 5, "ac130_fco_gotarunner");
  add_context_sensitive_dialog("ai", "in_sight", 6, "ac130_fco_backonthose");
  add_context_sensitive_dialog("ai", "in_sight", 7, "ac130_fco_gonnagethim");
  add_context_sensitive_dialog("ai", "in_sight", 8, "ac130_fco_personnelthere");
  add_context_sensitive_dialog("ai", "in_sight", 9, "ac130_fco_nailthoseguys");
  add_context_sensitive_dialog("ai", "in_sight", 11, "ac130_fco_lightemup");
  add_context_sensitive_dialog("ai", "in_sight", 12, "ac130_fco_takehimout");
  add_context_sensitive_dialog("ai", "in_sight", 14, "ac130_plt_yeahcleared");
  add_context_sensitive_dialog("ai", "in_sight", 15, "ac130_plt_copysmoke");
  add_context_sensitive_dialog("ai", "in_sight", 16, "ac130_fco_rightthere");
  add_context_sensitive_dialog("ai", "in_sight", 17, "ac130_fco_tracking");
  add_context_sensitive_dialog("ai", "wounded_crawl", 0, "ac130_fco_movingagain");
  add_context_sensitive_timeout("ai", "wounded_crawl", undefined, 6);
  add_context_sensitive_dialog("ai", "wounded_pain", 0, "ac130_fco_doveonground");
  add_context_sensitive_dialog("ai", "wounded_pain", 1, "ac130_fco_knockedwind");
  add_context_sensitive_dialog("ai", "wounded_pain", 2, "ac130_fco_downstillmoving");
  add_context_sensitive_dialog("ai", "wounded_pain", 3, "ac130_fco_gettinbackup");
  add_context_sensitive_dialog("ai", "wounded_pain", 4, "ac130_fco_yepstillmoving");
  add_context_sensitive_dialog("ai", "wounded_pain", 5, "ac130_fco_stillmoving");
  add_context_sensitive_timeout("ai", "wounded_pain", undefined, 12);
  add_context_sensitive_dialog("weapons", "105mm_ready", 0, "ac130_gnr_gunready1");
  add_context_sensitive_dialog("weapons", "105mm_fired", 0, "ac130_gnr_shot1");
  add_context_sensitive_dialog("plane", "rolling_in", 0, "ac130_plt_rollinin");
  add_context_sensitive_dialog("explosion", "secondary", 0, "ac130_nav_secondaries1");
  add_context_sensitive_timeout("explosion", "secondary", undefined, 7);
  add_context_sensitive_dialog("kill", "single", 0, "ac130_plt_gottahurt");
  add_context_sensitive_dialog("kill", "single", 1, "ac130_fco_iseepieces");
  add_context_sensitive_dialog("kill", "single", 2, "ac130_fco_oopsiedaisy");
  add_context_sensitive_dialog("kill", "single", 3, "ac130_fco_goodkill");
  add_context_sensitive_dialog("kill", "single", 4, "ac130_fco_yougothim");
  add_context_sensitive_dialog("kill", "single", 5, "ac130_fco_yougothim2");
  add_context_sensitive_dialog("kill", "single", 6, "ac130_fco_thatsahit");
  add_context_sensitive_dialog("kill", "single", 7, "ac130_fco_directhit");
  add_context_sensitive_dialog("kill", "single", 8, "ac130_fco_rightontarget");
  add_context_sensitive_dialog("kill", "single", 9, "ac130_fco_okyougothim");
  add_context_sensitive_dialog("kill", "single", 10, "ac130_fco_within2feet");
  add_context_sensitive_dialog("kill", "small_group", 0, "ac130_fco_nice");
  add_context_sensitive_dialog("kill", "small_group", 1, "ac130_fco_directhits");
  add_context_sensitive_dialog("kill", "small_group", 2, "ac130_fco_iseepieces");
  add_context_sensitive_dialog("kill", "small_group", 3, "ac130_fco_goodkill");
  add_context_sensitive_dialog("kill", "small_group", 4, "ac130_fco_yougothim");
  add_context_sensitive_dialog("kill", "small_group", 5, "ac130_fco_yougothim2");
  add_context_sensitive_dialog("kill", "small_group", 6, "ac130_fco_thatsahit");
  add_context_sensitive_dialog("kill", "small_group", 7, "ac130_fco_directhit");
  add_context_sensitive_dialog("kill", "small_group", 8, "ac130_fco_rightontarget");
  add_context_sensitive_dialog("kill", "small_group", 9, "ac130_fco_okyougothim");
  add_context_sensitive_dialog("misc", "action", 0, "ac130_fco_tracking");
  add_context_sensitive_timeout("misc", "action", 0, 70);
  add_context_sensitive_dialog("misc", "action", 1, "ac130_fco_moreenemy");
  add_context_sensitive_timeout("misc", "action", 1, 80);
  add_context_sensitive_dialog("misc", "action", 2, "ac130_random");
  add_context_sensitive_timeout("misc", "action", 2, 55);
  add_context_sensitive_dialog("misc", "action", 3, "ac130_fco_rightthere");
  add_context_sensitive_timeout("misc", "action", 3, 100);
}

function add_context_sensitive_dialog(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.scr_sound[var_0]) || !isDefined(level.scr_sound[var_0][var_1]) || !isDefined(level.scr_sound[var_0][var_1][var_2])) {
    level.scr_sound[var_0][var_1][var_2] = spawnStruct();
    level.scr_sound[var_0][var_1][var_2].played = 0;
    level.scr_sound[var_0][var_1][var_2].sounds = [];
  }

  var_4 = level.scr_sound[var_0][var_1][var_2].sounds.size;
  level.scr_sound[var_0][var_1][var_2].sounds[var_4] = var_3;
}

function add_context_sensitive_timeout(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.context_sensative_dialog_timeouts)) {
    level.context_sensative_dialog_timeouts = [];
  }

  var_4 = 0;

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0])) {
    var_4 = 1;
  } else if(!isDefined(level.context_sensative_dialog_timeouts[var_0][var_1])) {
    var_4 = 1;
  }

  if(var_4) {
    level.context_sensative_dialog_timeouts[var_0][var_1] = spawnStruct();
  }

  if(isDefined(var_2)) {
    level.context_sensative_dialog_timeouts[var_0][var_1].groups = [];
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)] = spawnStruct();
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["timeoutDuration"] = var_3 * 1000;
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["lastPlayed"] = var_3 * -1000;
    return;
  }

  level.context_sensative_dialog_timeouts[var_0][var_1].v["timeoutDuration"] = var_3 * 1000;
  level.context_sensative_dialog_timeouts[var_0][var_1].v["lastPlayed"] = var_3 * -1000;
}

function ac130_monitormanualplayerexit(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  var_0 endon("disconnect");
  thread scripts\cp\utility::allowridekillstreakplayerexit();
  self waittill("killstreakExit");
  thread ac130_leave(var_0);
}

function ac130_startuse(var_0, var_1) {
  self endon("ac130player_removed");

  if(isDefined(level.ac130player)) {
    return false;
  }

  var_2 = ac130_spawn(var_0, var_1);

  if(!isDefined(var_2)) {
    return false;
  }

  if(getdvarint("camera_thirdPerson")) {
    var_0 scripts\cp\utility::setthirdpersondof(0);
  }

  var_0.gunship = var_2;
  thread ac130_attachgunner(var_2);
  thread ac130_watchchangeweapons(var_2);
  thread ac130_watchweaponfired(var_2);
  thread ac130_watchdamage(var_2);

  if(!istrue(var_0.no_ac130_timeout)) {
    thread ac130_watchtimeout(var_2);
  }

  thread ac130_watchowner(var_2);
  thread ac130_playpilotfx(var_2);
  thread ac130_monitormanualplayerexit(var_2);
  var_0 scripts\cp\utility::setusingremote(var_1.streakname);
  return true;
}

function ac130_returnplayer(var_0, var_1) {
  var_0 notify("ac130player_removed");
  level notify("ac130player_removed");

  if(isDefined(var_0) && !istrue(var_1)) {
    var_0 setclientomnvar("ui_ac130_hud", 0);
    var_0 stoploopsound();
    var_0 visionsetkillstreakforplayer("");
    var_0 unlink();

    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\cp\utility::setthirdpersondof(1);
    }

    if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_0 scripts\cp\cp_weapons::_switchtoweapon(var_0.lastdroppableweaponobj);
    }

    var_2 = undefined;

    if(!isDefined(var_2) || !var_2) {
      var_0 scripts\cp\cp_weapons::_takeweapon("ac130_105mm_mp");
      var_0 scripts\cp\cp_weapons::_takeweapon("ac130_40mm_mp");
      var_0 scripts\cp\cp_weapons::_takeweapon("ac130_25mm_mp");
      var_0 scripts\common\utility::allow_weapon_switch(1);
    }

    if(isDefined(var_0.ac130_cloudsfx)) {
      var_0.ac130_cloudsfx delete();
    }

    var_0 thread scripts\cp\cp_drone_strike::stopremotesequence();
  }

  if(isDefined(self.enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
  }

  if(isDefined(self.friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
  }

  level.ac130inuse = 0;
  var_0 scripts\cp\utility::clearusingremote();
}

function ac130_watchdamage(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = undefined;

    if(isDefined(level.teambased) && isPlayer(var_2) && var_2.team == self.team && (!isDefined(var_11) || !var_11)) {
      continue;
    }

    if(var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    self.wasdamaged = 1;

    if(isPlayer(var_2)) {}

    if(isDefined(var_2.owner) && isPlayer(var_2.owner)) {}

    var_12 = 0;
    self.damagetaken += var_12;
    var_13 = self.maxhealth - self.damagetaken;
    var_0 setclientomnvar("ui_killstreak_health", var_13 / self.maxhealth);

    if(self.damagetaken >= self.maxhealth) {
      if(isPlayer(var_2)) {}

      thread ac130_crash(5, var_0);
    }
  }
}

function ac130_watchtimeout(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(self.timeout);
  thread ac130_leave(var_0);
}

function ac130_leave(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self unlink();
  var_1 = self.angles;
  var_2 = anglesToForward(var_1);
  ac130_returnplayer(var_0, 0);
  self moveTo(self.origin + var_2 * 50000, 10, 5);
  ac130_waittilldestination(self.origin + var_2 * 50000);
  ac130_removeplane();
}

function ac130_waittilldestination(var_0) {
  while(isDefined(self) && self.origin != var_0) {
    waitframe();
  }
}

function ac130_watchowner(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  var_1 = var_0 scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  var_2 = 0;

  if(istrue(var_1) && var_1 == "disconnect") {
    var_2 = 1;
  }

  thread ac130_crash(5, var_0);
}

function ac130_spawn(var_0, var_1) {
  if(isDefined(level.ac130_gunship)) {
    return level.ac130_gunship;
  }

  var_2 = spawn("script_model", level.ac130.origin);
  var_2 setModel("veh8_mil_air_acharlie130");
  var_2 setCanDamage(1);
  var_2.maxhealth = 1000;
  var_2.health = 99999;
  var_2.owner = var_0;
  var_2.team = var_0.team;
  var_2.timeout = 40;
  var_2.flaresreservecount = 2;
  var_2.streakinfo = var_1;
  var_2 scriptmoveroutline();
  var_2 scriptmoverthermal();
  var_4 = randomint(360);
  var_5 = 5000;
  var_6 = cos(var_4) * var_5;
  var_7 = sin(var_4) * var_5;
  var_8 = 10000;
  var_9 = vectorNormalize((var_6, var_7, var_8));
  var_9 *= var_8;
  var_2 linkTo(level.ac130, "tag_origin", var_9, (0, var_4 + 90, 0));
  level notify("matchrecording_plane", var_2);
  level.ac130_gunship = var_2;
  return var_2;
}

function debugview() {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

function ac130_updateoverlaycoords(var_0) {
  level endon("ac130player_removed");
  self endon("ac130player_removed");
  wait 0.05;
  thread ac130_updateplanemodelcoords(var_0);
  thread ac130_updateplayerpositioncoords();
  thread ac130_updateaimingcoords();
}

function ac130_updateplanemodelcoords(var_0) {
  level endon("ac130player_removed");
  self endon("ac130player_removed");

  for(;;) {
    self setclientomnvar("ui_ac130_coord1_posx", int(var_0.origin[0]));
    self setclientomnvar("ui_ac130_coord1_posy", int(var_0.origin[1]));
    self setclientomnvar("ui_ac130_coord1_posz", int(var_0.origin[2]));
    wait 0.5;
  }
}

function ac130_updateplayerpositioncoords() {
  level endon("ac130player_removed");
  self endon("ac130player_removed");
  waitframe();
  self setclientomnvar("ui_ac130_coord2_posx", int(self.origin[0]));
  self setclientomnvar("ui_ac130_coord2_posy", int(self.origin[1]));
  self setclientomnvar("ui_ac130_coord2_posz", int(self.origin[2]));
}

function ac130_updateaimingcoords() {
  self endon("ac130player_removed");

  for(;;) {
    var_0 = self getvieworigin();
    var_1 = var_0 + anglesToForward(self getplayerangles()) * 15000;
    var_2 = physicstrace(var_0, var_1);
    self setclientomnvar("ui_ac130_coord3_posx", int(var_2[0]));
    self setclientomnvar("ui_ac130_coord3_posy", int(var_2[1]));
    self setclientomnvar("ui_ac130_coord3_posz", int(var_2[2]));
    wait 0.1;
  }
}

function ac130shellshock() {
  self endon("ac130player_removed");
  level endon("post_effects_disabled");
  var_0 = 5;

  for(;;) {
    self shellshock("ac130", var_0);
    wait var_0;
  }
}

function rotateplane(var_0, var_1) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(var_1 == "on") {
    var_2 = 10;
    var_3 = level.ac130_speed["rotate"] / 360 * var_2;
    var_0 rotateYaw(level.ac130.angles[2] + var_2, var_3, var_3, 0);

    for(;;) {
      var_0 rotateYaw(360, level.ac130_speed["rotate"]);
      wait level.ac130_speed["rotate"];
    }

    return;
  }

  if(var_1 == "off") {
    var_4 = 10;
    var_3 = level.ac130_speed["rotate"] / 360 * var_4;
    var_0 rotateYaw(level.ac130.angles[2] + var_4, var_3, 0, var_3);
    return;
  }
}

function ac130_attachgunner(var_0) {
  self endon("death");
  var_0 scripts\cp\utility::_giveweapon("ac130_105mm_mp");
  var_0 scripts\cp\utility::_giveweapon("ac130_40mm_mp");
  var_0 scripts\cp\utility::_giveweapon("ac130_25mm_mp");
  var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate("ac130_105mm_mp");
  waitframe();
  self.camera = spawn("script_model", self.origin);
  self.camera setModel("tag_player");
  self.camera.angles = vectortoangles(level.ac130.origin - self.camera.origin);
  self.camera linkTo(self);

  if(isbot(var_0)) {
    var_0 cameralinkTo(self.camera, "tag_player");
    return;
  }

  var_0 playerlinkweaponviewtodelta(self.camera, "tag_player", 1, 100, 100, 25, 90, 0);
  var_0 playerlinkedsetviewznear(0);
  var_0 visionsetkillstreakforplayer("ac130_color");
  var_0 setplayerangles(self.camera.angles);
  var_0 setclientomnvar("ui_ac130_hud", 1);
  var_0 setclientomnvar("ui_ac130_105mm_ammo", var_0 getweaponammoclip("ac130_105mm_mp"));
  var_0 setclientomnvar("ui_ac130_40mm_ammo", var_0 getweaponammoclip("ac130_40mm_mp"));
  var_0 setclientomnvar("ui_ac130_25mm_ammo", var_0 getweaponammoclip("ac130_25mm_mp"));
  var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
  var_0 setclientomnvar("ui_killstreak_health", self.maxhealth);
  var_2 = [];

  foreach(var_4 in level.characters) {
    if(level.teambased && var_4.team == self.team) {
      continue;
    }

    if(var_4 == self.owner) {
      continue;
    }

    if(var_2.size >= 20) {
      continue;
    }

    var_2 = var_4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var_2, self.owner, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, self.owner, self.owner);
  thread ac130_updateoverlaycoords(var_0);
}

function ac130_watchchangeweapons(var_0) {
  self endon("death");
  var_0 endon("ac130player_removed");
  level endon("ac130player_removed");
  var_2 = ["ac130_105mm_mp", "ac130_40mm_mp", "ac130_25mm_mp"];
  var_0 scripts\common\utility::allow_weapon_switch(0);

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("ac130_switch_weapon", "+weapnext");
    var_0 setclientomnvar("ui_ac130_weapon", 3);
  }

  var_3 = 3;

  for(;;) {
    var_0 waittill("ac130_switch_weapon");
    var_4 = var_0 getcurrentweapon();
    var_5 = var_4;

    foreach(var_7 in var_2) {
      if(var_4.basename == var_7) {
        var_8 = var_9 + 1;

        if(var_8 > var_2.size - 1) {
          var_8 = 0;
        }

        var_5 = var_2[var_8];
        break;
      }
    }

    var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate(var_5);
    var_3--;

    if(var_3 == 0) {
      var_3 = 3;
    }

    var_0 setclientomnvar("ui_ac130_weapon", var_3);
    playfxontagforclients(scripts\engine\utility::getfx("camera_shutter"), var_0, "tag_eye", var_0);
    thread ac130_playfocalfx();
  }
}

function ac130_playfocalfx() {
  self endon("disconnect");
  self notify("changing_ac130_dof");
  self endon("changing_ac130_dof");
  setdof_ac130_zoom();
  wait 0.5;
  setdof_ac130();
}

function ac130_watchweaponimpact(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6, var_7);
  var_8 = spawn("script_model", var_0.origin);
  var_8 setModel("ks_ac130_target_mp");
  var_8.angles = vectortoangles(var_7);
  var_8 linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_8 setotherent(self);
  var_9 = "on";
  var_8 setscriptablepartstate(var_0.weapon_name, var_9, 0);

  if(isDefined(self)) {
    var_0 detonate();
  } else {
    var_0 delete();
  }

  var_10 = var_8.origin;
  var_11 = getmissileexplscale(var_0.weapon_name);
  var_12 = 0.75;
  var_13 = getmissileexplradius(var_0.weapon_name);
  thread deleteaftertime(var_8);
}

function getmissileexplscale(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1 = 0.75;
      break;
    case "ac130_40mm_mp":
      var_1 = 0.5;
      break;
    case "ac130_25mm_mp":
      var_1 = 0.15;
      break;
  }

  return var_1;
}

function getmissileexplradius(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1 = 2000;
      break;
    case "ac130_40mm_mp":
      var_1 = 1300;
      break;
    case "ac130_25mm_mp":
      var_1 = 700;
      break;
  }

  return var_1;
}

function setdof_ac130() {
  self.usingcustomdof = 1;
  scripts\cp\utility::_setdof_internal(10, 80, 1000, 1000, 7, 0);
}

function setdof_ac130_zoom() {
  self.usingcustomdof = 1;
  scripts\cp\utility::_setdof_internal(10, 80, 1000, 6500, 10, 5);
}

function ac130_watchweaponfired(var_0) {
  self endon("death");
  level endon("ac130player_removed");
  var_0 endon("ac130player_removed");
  thread ac130_track105mmmissile(var_0);

  for(;;) {
    var_0 waittill("missile_fire", var_2);
    var_3 = var_0 getcurrentweapon();
    var_4 = var_0 getweaponammoclip(var_3);

    switch (var_3.basename) {
      case "ac130_105mm_mp":
        earthquake(0.2, 1, self.origin, 1000);
        var_0 setclientomnvar("ui_ac130_105mm_ammo", var_4);
        break;
      case "ac130_40mm_mp":
        earthquake(0.1, 0.5, self.origin, 1000);
        var_0 setclientomnvar("ui_ac130_40mm_ammo", var_4);
        break;
      case "ac130_25mm_mp":
        var_0 setclientomnvar("ui_ac130_25mm_ammo", var_4);
        break;
    }

    if(var_4 == 0) {
      thread ac130_weaponreload(var_0);
    }

    thread ac130_watchweaponimpact(var_0, var_2);
  }
}

function ac130_track105mmmissile(var_0) {
  self endon("death");
  level endon("ac130player_removed");
  var_0 endon("ac130player_removed");

  for(;;) {
    var_0 waittill("missile_fire", var_1, var_2);

    if(var_2.basename == "ac130_105mm_mp") {
      thread ac130_watch105mmexplosion(var_1, self);
    }
  }
}

function ac130_watch105mmexplosion(var_0, var_1) {
  level endon("ac130player_removed");
  var_1 endon("ac130player_removed");
  var_1 endon("disconnect");
  self waittill("death");
  earthquake(0.125, 0.5, var_0.origin, 1000);
  var_1 visionsetkillstreakforplayer("ac130_color_glitch");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var_1 visionsetkillstreakforplayer("ac130_color");
}

function ac130_weaponreload(var_0) {
  self endon("ac130player_removed");
  level endon("ac130player_removed");
  var_1 = getac130weaponrootname(var_0);
  self playlocalsound(var_1 + "_mp_reload");
  ac130_waitforweaponreloadtime(var_0, var_1);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_1 + "_reloaded");
  var_2 = weaponmaxammo(var_0);
  self setweaponammoclip(var_0, var_2);
  self setclientomnvar("ui_" + var_1 + "_ammo", var_2);
}

function ac130_waitforweaponreloadtime(var_0, var_1) {
  var_2 = level.weaponreloadtime[var_0.basename];
  self setclientomnvar("ui_" + var_1 + "_reloadtime", gettime() + int(var_2 * 1000));

  for(;;) {
    wait 0.05;
    var_2 -= 0.05;

    if(var_2 <= 0) {
      break;
    }
  }
}

function getac130weaponrootname(var_0) {
  var_1 = 0;
  var_2 = var_0.basename;
  var_3 = strtok(var_2, "_");
  return var_3[var_1] + "_" + var_3[var_1 + 1];
}

function playsound25mm() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("ac130player_removed");
  self endon("reset_25mm");
  var_0 = self getcurrentweapon();

  for(;;) {
    self waittill("weapon_fired");
    self stoplocalsound("ac130iw6_25mm_fire_loop_cooldown");
    self playLoopSound("ac130iw6_25mm_fire_loop");

    while(self attackButtonPressed() && self getweaponammoclip(var_0)) {
      waitframe();
    }

    self stoploopsound();
    self playlocalsound("ac130iw6_25mm_fire_loop_cooldown");
  }
}

function thermalvision() {
  self endon("ac130player_removed");
  self thermalvisionon();
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 1);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self visionsetthermalforplayer(level.ac130.thermal_vision, 0.62);
  self.lastvisionsetthermal = level.ac130.thermal_vision;
  self setclientdvar("ui_ac130_thermal", 1);
}

function ac130_playpilotfx(var_0) {
  self endon("death");
  self endon("leaving");
  var_0.ac130_cloudsfx = spawn("script_model", var_0 getEye());
  var_0.ac130_cloudsfx setModel("tag_origin");
  var_0.ac130_cloudsfx linkTo(var_0, "tag_eye");
  waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("clouds"), var_0.ac130_cloudsfx, "tag_origin", var_0);
}

function gun_fired_and_ready_105mm() {
  self endon("ac130player_removed");
  level notify("gun_fired_and_ready_105mm");
  level endon("gun_fired_and_ready_105mm");
  wait 0.5;

  if(randomint(2) == 0) {
    thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_fired");
  }

  wait 5;
  thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_ready");
}

function shotfired() {
  self endon("ac130player_removed");

  for(;;) {
    self waittill("projectile_impact", var_0, var_1, var_2);

    if(issubstr(tolower(var_0.basename), "105")) {
      earthquake(0.4, 1, var_1, 3500);
      self setclientomnvar("ui_ac130_darken", 1);
    } else if(issubstr(tolower(var_0.basename), "40")) {
      earthquake(0.2, 0.5, var_1, 2000);
    }

    if(scripts\cp\utility::getintproperty("ac130_ragdoll_deaths", 0)) {
      thread shotfiredphysicssphere(var_1, var_0.basename);
    }

    waitframe();
  }
}

function shotfiredphysicssphere(var_0, var_1) {
  wait 0.1;
  physicsexplosionsphere(var_0, level.physicssphereradius[var_1], level.physicssphereradius[var_1] / 2, level.physicssphereforce[var_1]);
}

function add_beacon_effect() {
  self endon("death");
  var_0 = 0.75;
  wait randomfloat(3);

  for(;;) {
    if(level.ac130player) {
      playfxontagforclients(level._effect["beacon"], self, "j_spine4", level.ac130player);
    }

    wait var_0;
  }
}

function context_sensative_dialog() {
  thread enemy_killed_thread();
  thread context_sensative_dialog_guy_in_sight();
  thread context_sensative_dialog_guy_crawling();
  thread context_sensative_dialog_guy_pain();
  thread context_sensative_dialog_secondary_explosion_vehicle();
  thread context_sensative_dialog_kill_thread();
  thread context_sensative_dialog_locations();
  thread context_sensative_dialog_filler();
}

function context_sensative_dialog_guy_in_sight() {
  self endon("ac130player_removed");

  for(;;) {
    if(context_sensative_dialog_guy_in_sight_check()) {
      thread context_sensative_dialog_play_random_group_sound("ai", "in_sight");
    }

    wait randomfloatrange(1, 3);
  }
}

function context_sensative_dialog_guy_in_sight_check() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(var_2.team == level.ac130player.team) {
      continue;
    }

    if(var_2.team == "spectator") {
      continue;
    }

    var_0 = var_2;
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(var_0[var_4])) {
      continue;
    }

    if(!isalive(var_0[var_4])) {
      continue;
    }

    if(scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var_0[var_4].origin, level.cosine["5"])) {
      return true;
    }

    wait 0.05;
  }

  return false;
}

function context_sensative_dialog_guy_crawling() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_crawling", var_0);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_crawl");
  }
}

function context_sensative_dialog_guy_pain() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_pain", var_0);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_pain");
  }
}

function context_sensative_dialog_secondary_explosion_vehicle() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("player_destroyed_car", var_0, var_1);
    wait 1;
    thread context_sensative_dialog_play_random_group_sound("explosion", "secondary");
  }
}

function enemy_killed_thread() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_killed", var_0);
    thread context_sensative_dialog_kill(var_0, level.ac130player);
  }
}

function context_sensative_dialog_kill(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  if(!isPlayer(var_1)) {
    return;
  }

  level.enemieskilledintimewindow++;
  level notify("enemy_killed");
}

function context_sensative_dialog_kill_thread() {
  self endon("ac130player_removed");
  var_0 = 1;

  for(;;) {
    level waittill("enemy_killed");
    wait var_0;
    var_1 = "kill";
    var_2 = undefined;

    if(level.enemieskilledintimewindow >= 2) {
      var_2 = "small_group";
    } else {
      var_2 = "single";

      if(randomint(3) != 1) {
        level.enemieskilledintimewindow = 0;
        continue;
      }
    }

    level.enemieskilledintimewindow = 0;
    thread context_sensative_dialog_play_random_group_sound(var_1, var_2, 1);
  }
}

function context_sensative_dialog_locations() {
  scripts\engine\utility::array_thread(getEntArray("context_dialog_car", "targetname"), &context_sensative_dialog_locations_add_notify_event, "car");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_truck", "targetname"), &context_sensative_dialog_locations_add_notify_event, "truck");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_building", "targetname"), &context_sensative_dialog_locations_add_notify_event, "building");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_wall", "targetname"), &context_sensative_dialog_locations_add_notify_event, "wall");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_field", "targetname"), &context_sensative_dialog_locations_add_notify_event, "field");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_road", "targetname"), &context_sensative_dialog_locations_add_notify_event, "road");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_church", "targetname"), &context_sensative_dialog_locations_add_notify_event, "church");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_ditch", "targetname"), &context_sensative_dialog_locations_add_notify_event, "ditch");
  thread context_sensative_dialog_locations_thread();
}

function context_sensative_dialog_locations_thread() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("context_location", var_0);

    if(!isDefined(var_0)) {
      continue;
    }

    if(!scripts\engine\utility::flag("allow_context_sensative_dialog")) {
      continue;
    }

    thread context_sensative_dialog_play_random_group_sound("location", var_0);
    wait 5 + randomfloat(10);
  }
}

function context_sensative_dialog_locations_add_notify_event(var_0) {
  self endon("ac130player_removed");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }

    if(!isDefined(var_1.team) || var_1.team != "axis") {
      continue;
    }

    level notify("context_location", var_0);
    wait 5;
  }
}

function context_sensative_dialog_vehiclespawn(var_0) {
  if(var_0.script_team != "axis") {
    return;
  }

  thread context_sensative_dialog_vehicledeath(var_0);
  var_0 endon("death");

  while(!scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var_0.origin, level.cosine["45"])) {
    wait 0.5;
  }

  context_sensative_dialog_play_random_group_sound("vehicle", "incoming");
}

function context_sensative_dialog_vehicledeath(var_0) {
  var_0 waittill("death");
  thread context_sensative_dialog_play_random_group_sound("vehicle", "death");
}

function context_sensative_dialog_filler() {
  self endon("ac130player_removed");

  for(;;) {
    if(isDefined(level.radio_in_use) && level.radio_in_use == 1) {
      level waittill("radio_not_in_use");
    }

    var_0 = gettime();

    if(var_0 - level.lastradiotransmission >= 3000) {
      level.lastradiotransmission = var_0;
      thread context_sensative_dialog_play_random_group_sound("misc", "action");
    }

    wait 0.25;
  }
}

function context_sensative_dialog_play_random_group_sound(var_0, var_1, var_2) {
  level endon("ac130player_removed");

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!scripts\engine\utility::flag("allow_context_sensative_dialog")) {
    if(var_2) {
      scripts\engine\utility::flag_wait("allow_context_sensative_dialog");
    } else {
      return;
    }
  }

  var_3 = undefined;
  var_4 = randomint(level.scr_sound[var_0][var_1].size);

  if(level.scr_sound[var_0][var_1][var_4].played == 1) {
    for(var_5 = 0; var_5 < level.scr_sound[var_0][var_1].size; var_5++) {
      var_4++;

      if(var_4 >= level.scr_sound[var_0][var_1].size) {
        var_4 = 0;
      }

      if(level.scr_sound[var_0][var_1][var_4].played == 1) {
        continue;
      }

      var_3 = var_4;
      break;
    }

    if(!isDefined(var_3)) {
      for(var_5 = 0; var_5 < level.scr_sound[var_0][var_1].size; var_5++) {
        level.scr_sound[var_0][var_1][var_5].played = 0;
      }

      var_3 = randomint(level.scr_sound[var_0][var_1].size);
    }
  } else {
    var_3 = var_4;
  }

  if(context_sensative_dialog_timedout(var_0, var_1, var_3)) {
    return;
  }

  level.scr_sound[var_0][var_1][var_3].played = 1;
  var_6 = randomint(level.scr_sound[var_0][var_1][var_3].size);
  playsoundoverradio(level.scr_sound[var_0][var_1][var_3].sounds[var_6], var_2);
}

function context_sensative_dialog_timedout(var_0, var_1, var_2) {
  if(!isDefined(level.context_sensative_dialog_timeouts)) {
    return false;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0])) {
    return false;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0][var_1])) {
    return false;
  }

  if(isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].groups) && isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)])) {
    var_3 = gettime();

    if(var_3 - level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["lastPlayed"] < level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["timeoutDuration"]) {
      return true;
    }

    level.context_sensative_dialog_timeouts[var_0][var_1].groups[scripts\engine\utility::string(var_2)].v["lastPlayed"] = var_3;
  } else if(isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].v)) {
    var_3 = gettime();

    if(var_3 - level.context_sensative_dialog_timeouts[var_0][var_1].v["lastPlayed"] < level.context_sensative_dialog_timeouts[var_0][var_1].v["timeoutDuration"]) {
      return true;
    }

    level.context_sensative_dialog_timeouts[var_0][var_1].v["lastPlayed"] = var_3;
  }

  return false;
}

function playsoundoverradio(var_0, var_1, var_2) {
  if(!isDefined(level.radio_in_use)) {
    level.radio_in_use = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_2 *= 1000;
  var_3 = gettime();
  var_4 = 0;
  var_4 = playaliasoverradio(var_0);

  if(var_4) {
    return;
  }

  if(!var_1) {
    return;
  }

  level.radioforcedtransmissionqueue[level.radioforcedtransmissionqueue.size] = var_0;

  while(!var_4) {
    if(level.radio_in_use) {
      level waittill("radio_not_in_use");
    }

    if(var_2 > 0 && gettime() - var_3 > var_2) {
      break;
    }

    if(!isDefined(level.ac130player)) {
      break;
    }

    var_4 = playaliasoverradio(level.radioforcedtransmissionqueue[0]);

    if(!level.radio_in_use && isDefined(level.ac130player) && !var_4) {}
  }

  level.radioforcedtransmissionqueue = scripts\engine\utility::array_remove_index(level.radioforcedtransmissionqueue, 0);
}

function playaliasoverradio(var_0) {
  if(level.radio_in_use) {
    return false;
  }

  if(!isDefined(level.ac130player)) {
    return false;
  }

  level.radio_in_use = 1;
  level.ac130player playlocalsound(var_0);
  wait 4;
  level.radio_in_use = 0;
  level.lastradiotransmission = gettime();
  level notify("radio_not_in_use");
  return true;
}

function handleincomingmissiles() {
  level endon("game_ended");
  thread flares_monitor(level.ac130.planemodel);
}

function flares_monitor(var_0) {
  self.flaresreservecount = var_0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
  thread ks_airsuperiority_handleincoming();
}

function playflarefx(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    thread ac130_playflares();
    wait randomfloatrange(0.1, 0.25);
  }
}

function deployflares(var_0) {
  self playSound("ac130iw6_flare_burst");

  if(!isDefined(var_0)) {
    var_1 = spawn("script_origin", level.ac130.planemodel.origin);
    var_1.angles = level.ac130.planemodel.angles;
    var_1 movegravity((0, 0, 0), 5);
    thread playflarefx(10);
    self.flareslive[self.flareslive.size] = var_1;
    thread deleteaftertime(var_1);
    return var_1;
  }

  thread playflarefx(5);
}

function flares_getnumleft(var_0) {
  return var_0.flaresreservecount;
}

function flares_areavailable(var_0) {
  flares_cleanflareslivearray(var_0);
  return var_0.flaresreservecount > 0 || var_0.flareslive.size > 0;
}

function flares_getflarereserve(var_0) {
  var_0.flaresreservecount--;
  var_1 = deployflares(var_0);
  return var_1;
}

function flares_cleanflareslivearray(var_0) {
  var_0.flareslive = scripts\engine\utility::array_removeundefined(var_0.flareslive);
}

function flares_getflarelive(var_0) {
  flares_cleanflareslivearray(var_0);
  var_1 = undefined;

  if(var_0.flareslive.size > 0) {
    var_1 = var_0.flareslive[var_0.flareslive.size - 1];
  }

  return var_1;
}

function ks_laserguidedmissile_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    level waittill("laserGuidedMissiles_incoming", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }

    thread ks_watch_death_stop_sound(level.ac130player, self);

    foreach(var_4 in var_1) {
      if(isvalidmissile(var_4)) {
        thread ks_laserguidedmissile_monitorproximity(level, var_4, var_0, var_0.team);
      }
    }
  }
}

function ks_laserguidedmissile_monitorproximity(var_0, var_1, var_2, var_3) {
  var_3 endon("death");
  var_0 endon("death");
  var_0 endon("missile_targetChanged");

  while(flares_areavailable(var_3)) {
    if(!isDefined(var_3) || !isvalidmissile(var_0)) {
      break;
    }

    var_4 = var_3 getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_4) < 4000000) {
      var_5 = flares_getflarelive(var_3);

      if(!isDefined(var_5)) {
        var_5 = flares_getflarereserve(var_3);
      }

      var_0 missile_settargetEnt(var_5);
      var_0 notify("missile_pairedWithFlare");
      level.ac130player stoplocalsound("missile_incoming");
      break;
    }

    waitframe();
  }
}

function ks_airsuperiority_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    self waittill("targeted_by_incoming_missile", var_0);

    if(!isDefined(var_0)) {
      continue;
    }

    thread ks_watch_death_stop_sound(level.ac130player, self);

    foreach(var_2 in var_0) {
      if(isvalidmissile(var_2)) {
        thread ks_airsuperiority_monitorproximity(var_2);
      }
    }
  }
}

function ks_airsuperiority_monitorproximity(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(var_0)) {
      break;
    }

    var_1 = self getpointinbounds(0, 0, 0);

    if(distancesquared(var_0.origin, var_1) < 4000000) {
      var_2 = flares_getflarelive(self);

      if(!isDefined(var_2) && self.flaresreservecount > 0) {
        var_2 = flares_getflarereserve(self);
      }

      if(isDefined(var_2)) {
        var_0 missile_settargetEnt(var_2);
        var_0 notify("missile_pairedWithFlare");
        level.ac130player stoplocalsound("missile_incoming");
        break;
      }
    }

    waitframe();
  }
}

function ks_watch_death_stop_sound(var_0, var_1) {
  self endon("disconnect");
  var_0 waittill("death");
  self stoplocalsound(var_1);
}

function deleteaftertime(var_0) {
  wait var_0;
  self delete();
}

function ac130_crash(var_0, var_1) {
  self notify("crashing");
  self.crashed = 1;
  ac130_returnplayer(var_1, 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  ac130_removeplane();
}

function ac130_removeplane() {
  if(isDefined(self.camera)) {
    self.camera delete();
  }

  level.ac130_gunship = undefined;
  self delete();
}

function ac130_playflares() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("angel_flare_rig");
  var_0.origin = self gettagorigin("tag_flash_flares");
  var_0.angles = self gettagangles("tag_flash_flares");
  var_0.angles = (var_0.angles[0], var_0.angles[1] + 180, var_0.angles[2] + -90);
  var_1 = level._effect["angel_flare_geotrail"];
  var_0 scriptmodelplayanim("ac130_angel_flares0" + randomint(3) + 1);
  wait 0.1;
  playFXOnTag(var_1, var_0, "flare_left_top");
  playFXOnTag(var_1, var_0, "flare_right_top");
  wait 0.05;
  playFXOnTag(var_1, var_0, "flare_left_bot");
  playFXOnTag(var_1, var_0, "flare_right_bot");
  wait 3;
  stopFXOnTag(var_1, var_0, "flare_left_top");
  stopFXOnTag(var_1, var_0, "flare_right_top");
  stopFXOnTag(var_1, var_0, "flare_left_bot");
  stopFXOnTag(var_1, var_0, "flare_right_bot");
  var_0 delete();
}

function objectivewmdthink(var_0) {
  var_1 = 0;

  while(!var_1) {
    var_1 = istargetinreticle(level.objective_nuke, 70, 50);
    wait 0.5;
  }
}

function istargetinreticle(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [var_0.origin];

  if(isPlayer(var_0)) {
    var_4 = [var_0.origin, var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_eye")];
  }

  foreach(var_6 in var_4) {
    if(self worldpointinreticle_circle(var_6, var_1, var_2)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}
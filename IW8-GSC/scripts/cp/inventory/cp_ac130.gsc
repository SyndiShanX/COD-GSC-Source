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
  var0 = getEntArray("minimap_corner", "targetname");
  var1 = level.mapcenter;

  if(var0.size) {
    var1 = scripts\cp\cp_globallogic::findboxcenter(var0[0].origin, var0[1].origin);
  }

  if(isDefined(level.ac130_location)) {
    var1 = level.ac130_location;
  }

  level.ac130 = spawn("script_model", var1);
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

function ac130activatefunc(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("ac130", var0);
  thread tryuseac130(var1);
}

function forceac130onplayernow(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("ac130", var0);
  var2 = "ks_remote_device_mp";
  var0 scripts\cp\utility::_giveweapon(var2, 0, 0, 1);
  var3 = int(tablelookup("mp/killstreaktable.csv", 1, var1.streakname, 0));
  var0 setclientomnvar("ui_remote_control_sequence", var3);
  var4 = var0 scripts\cp\cp_weapons::switchtoweaponreliable(var2);
  var0 scripts\cp\utility::setusingremote(var1.streakname);
  var0 notify("ks_freeze_end");
  var0 setclientomnvar("ui_remote_control_sequence", 0);
  var0 scripts\cp\utility::clearusingremote();
  var0 scripts\cp_mp\utility\killstreak_utility::stoptabletscreen();

  if(isDefined(var2)) {
    var0 takeweapon(var2);
  }

  var0 setclientomnvar("ui_remote_control_sequence", 0);
  var5 = ac130_startuse(var0, var1);

  if(!istrue(var5)) {
    return 0;
  }
}

function spawn_ambient_ac130(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("ac130", var0);
  var2 = ac130_spawn(var0, var1);
  return var2;
}

function weapongivenac130(var0) {}

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

function tryuseac130(var0) {
  if(isDefined(level.ac130player) || level.ac130inuse) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var1 = scripts\cp\cp_drone_strike::playremotesequence(var0);

  if(!var1) {
    self notify("killstreak_finished_with_weapon_" + var0.weaponname);
    return 0;
  }

  var1 = ac130_startuse(self, var0);

  if(!istrue(var1)) {
    return 0;
  }

  if(isDefined(level.ac130player) || istrue(level.ac130inuse)) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  foreach(var3 in level.players) {
    if(var3 != self) {
      var3 thread scripts\cp\cp_hud_message::showsplash("cp_used_ac130", undefined, self);
    }
  }

  level.ac130inuse = 1;
  level notify("ac130InUse", self);
  return var1;
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

function add_context_sensitive_dialog(var0, var1, var2, var3) {
  if(!isDefined(level.scr_sound[var0]) || !isDefined(level.scr_sound[var0][var1]) || !isDefined(level.scr_sound[var0][var1][var2])) {
    level.scr_sound[var0][var1][var2] = spawnStruct();
    level.scr_sound[var0][var1][var2].played = 0;
    level.scr_sound[var0][var1][var2].sounds = [];
  }

  var4 = level.scr_sound[var0][var1][var2].sounds.size;
  level.scr_sound[var0][var1][var2].sounds[var4] = var3;
}

function add_context_sensitive_timeout(var0, var1, var2, var3) {
  if(!isDefined(level.context_sensative_dialog_timeouts)) {
    level.context_sensative_dialog_timeouts = [];
  }

  var4 = 0;

  if(!isDefined(level.context_sensative_dialog_timeouts[var0])) {
    var4 = 1;
  } else if(!isDefined(level.context_sensative_dialog_timeouts[var0][var1])) {
    var4 = 1;
  }

  if(var4) {
    level.context_sensative_dialog_timeouts[var0][var1] = spawnStruct();
  }

  if(isDefined(var2)) {
    level.context_sensative_dialog_timeouts[var0][var1].groups = [];
    level.context_sensative_dialog_timeouts[var0][var1].groups[scripts\engine\utility::string(var2)] = spawnStruct();
    level.context_sensative_dialog_timeouts[var0][var1].groups[scripts\engine\utility::string(var2)].v["timeoutDuration"] = var3 * 1000;
    level.context_sensative_dialog_timeouts[var0][var1].groups[scripts\engine\utility::string(var2)].v["lastPlayed"] = var3 * -1000;
    return;
  }

  level.context_sensative_dialog_timeouts[var0][var1].v["timeoutDuration"] = var3 * 1000;
  level.context_sensative_dialog_timeouts[var0][var1].v["lastPlayed"] = var3 * -1000;
}

function ac130_monitormanualplayerexit(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  var0 endon("disconnect");
  thread scripts\cp\utility::allowridekillstreakplayerexit();
  self waittill("killstreakExit");
  thread ac130_leave(var0);
}

function ac130_startuse(var0, var1) {
  self endon("ac130player_removed");

  if(isDefined(level.ac130player)) {
    return false;
  }

  var2 = ac130_spawn(var0, var1);

  if(!isDefined(var2)) {
    return false;
  }

  if(getdvarint("NOSLRNTRKL")) {
    var0 scripts\cp\utility::setthirdpersondof(0);
  }

  var0.gunship = var2;
  thread ac130_attachgunner(var2);
  thread ac130_watchchangeweapons(var2);
  thread ac130_watchweaponfired(var2);
  thread ac130_watchdamage(var2);

  if(!istrue(var0.no_ac130_timeout)) {
    thread ac130_watchtimeout(var2);
  }

  thread ac130_watchowner(var2);
  thread ac130_playpilotfx(var2);
  thread ac130_monitormanualplayerexit(var2);
  var0 scripts\cp\utility::setusingremote(var1.streakname);
  return true;
}

function ac130_returnplayer(var0, var1) {
  var0 notify("ac130player_removed");
  level notify("ac130player_removed");

  if(isDefined(var0) && !istrue(var1)) {
    var0 setclientomnvar("ui_ac130_hud", 0);
    var0 stoploopsound();
    var0 visionsetkillstreakforplayer("");
    var0 unlink();

    if(getdvarint("NOSLRNTRKL")) {
      var0 scripts\cp\utility::setthirdpersondof(1);
    }

    if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var0 scripts\cp\cp_weapons::_switchtoweapon(var0.lastdroppableweaponobj);
    }

    var2 = undefined;

    if(!isDefined(var2) || !var2) {
      var0 scripts\cp\cp_weapons::_takeweapon("ac130_105mm_mp");
      var0 scripts\cp\cp_weapons::_takeweapon("ac130_40mm_mp");
      var0 scripts\cp\cp_weapons::_takeweapon("ac130_25mm_mp");
      var0 scripts\common\utility::allow_weapon_switch(1);
    }

    if(isDefined(var0.ac130_cloudsfx)) {
      var0.ac130_cloudsfx delete();
    }

    var0 thread scripts\cp\cp_drone_strike::stopremotesequence();
  }

  if(isDefined(self.enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
  }

  if(isDefined(self.friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
  }

  level.ac130inuse = 0;
  var0 scripts\cp\utility::clearusingremote();
}

function ac130_watchdamage(var0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    var11 = undefined;

    if(isDefined(level.teambased) && isPlayer(var2) && var2.team == self.team && (!isDefined(var11) || !var11)) {
      continue;
    }

    if(var5 == "MOD_RIFLE_BULLET" || var5 == "MOD_PISTOL_BULLET" || var5 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    self.wasdamaged = 1;

    if(isPlayer(var2)) {}

    if(isDefined(var2.owner) && isPlayer(var2.owner)) {}

    var12 = 0;
    self.damagetaken += var12;
    var13 = self.maxhealth - self.damagetaken;
    var0 setclientomnvar("ui_killstreak_health", var13 / self.maxhealth);

    if(self.damagetaken >= self.maxhealth) {
      if(isPlayer(var2)) {}

      thread ac130_crash(5, var0);
    }
  }
}

function ac130_watchtimeout(var0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(self.timeout);
  thread ac130_leave(var0);
}

function ac130_leave(var0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self unlink();
  var1 = self.angles;
  var2 = anglesToForward(var1);
  ac130_returnplayer(var0, 0);
  self moveTo(self.origin + var2 * 50000, 10, 5);
  ac130_waittilldestination(self.origin + var2 * 50000);
  ac130_removeplane();
}

function ac130_waittilldestination(var0) {
  while(isDefined(self) && self.origin != var0) {
    waitframe();
  }
}

function ac130_watchowner(var0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  var1 = var0 scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  var2 = 0;

  if(istrue(var1) && var1 == "disconnect") {
    var2 = 1;
  }

  thread ac130_crash(5, var0);
}

function ac130_spawn(var0, var1) {
  if(isDefined(level.ac130_gunship)) {
    return level.ac130_gunship;
  }

  var2 = spawn("script_model", level.ac130.origin);
  var2 setModel("veh8_mil_air_acharlie130");
  var2 setCanDamage(1);
  var2.maxhealth = 1000;
  var2.health = 99999;
  var2.owner = var0;
  var2.team = var0.team;
  var2.timeout = 40;
  var2.flaresreservecount = 2;
  var2.streakinfo = var1;
  var2 scriptmoveroutline();
  var2 scriptmoverthermal();
  var4 = randomint(360);
  var5 = 5000;
  var6 = cos(var4) * var5;
  var7 = sin(var4) * var5;
  var8 = 10000;
  var9 = vectorNormalize((var6, var7, var8));
  var9 *= var8;
  var2 linkTo(level.ac130, "tag_origin", var9, (0, var4 + 90, 0));
  level notify("matchrecording_plane", var2);
  level.ac130_gunship = var2;
  return var2;
}

function debugview() {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

function ac130_updateoverlaycoords(var0) {
  level endon("ac130player_removed");
  self endon("ac130player_removed");
  wait 0.05;
  thread ac130_updateplanemodelcoords(var0);
  thread ac130_updateplayerpositioncoords();
  thread ac130_updateaimingcoords();
}

function ac130_updateplanemodelcoords(var0) {
  level endon("ac130player_removed");
  self endon("ac130player_removed");

  for(;;) {
    self setclientomnvar("ui_ac130_coord1_posx", int(var0.origin[0]));
    self setclientomnvar("ui_ac130_coord1_posy", int(var0.origin[1]));
    self setclientomnvar("ui_ac130_coord1_posz", int(var0.origin[2]));
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
    var0 = self getvieworigin();
    var1 = var0 + anglesToForward(self getplayerangles()) * 15000;
    var2 = physicstrace(var0, var1);
    self setclientomnvar("ui_ac130_coord3_posx", int(var2[0]));
    self setclientomnvar("ui_ac130_coord3_posy", int(var2[1]));
    self setclientomnvar("ui_ac130_coord3_posz", int(var2[2]));
    wait 0.1;
  }
}

function ac130shellshock() {
  self endon("ac130player_removed");
  level endon("post_effects_disabled");
  var0 = 5;

  for(;;) {
    self shellshock("ac130", var0);
    wait var0;
  }
}

function rotateplane(var0, var1) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(var1 == "on") {
    var2 = 10;
    var3 = level.ac130_speed["rotate"] / 360 * var2;
    var0 rotateYaw(level.ac130.angles[2] + var2, var3, var3, 0);

    for(;;) {
      var0 rotateYaw(360, level.ac130_speed["rotate"]);
      wait level.ac130_speed["rotate"];
    }

    return;
  }

  if(var1 == "off") {
    var4 = 10;
    var3 = level.ac130_speed["rotate"] / 360 * var4;
    var0 rotateYaw(level.ac130.angles[2] + var4, var3, 0, var3);
    return;
  }
}

function ac130_attachgunner(var0) {
  self endon("death");
  var0 scripts\cp\utility::_giveweapon("ac130_105mm_mp");
  var0 scripts\cp\utility::_giveweapon("ac130_40mm_mp");
  var0 scripts\cp\utility::_giveweapon("ac130_25mm_mp");
  var0 scripts\cp\cp_weapons::_switchtoweaponimmediate("ac130_105mm_mp");
  waitframe();
  self.camera = spawn("script_model", self.origin);
  self.camera setModel("tag_player");
  self.camera.angles = vectortoangles(level.ac130.origin - self.camera.origin);
  self.camera linkTo(self);

  if(isbot(var0)) {
    var0 cameralinkTo(self.camera, "tag_player");
    return;
  }

  var0 playerlinkweaponviewtodelta(self.camera, "tag_player", 1, 100, 100, 25, 90, 0);
  var0 playerlinkedsetviewznear(0);
  var0 visionsetkillstreakforplayer("ac130_color");
  var0 setplayerangles(self.camera.angles);
  var0 setclientomnvar("ui_ac130_hud", 1);
  var0 setclientomnvar("ui_ac130_105mm_ammo", var0 getweaponammoclip("ac130_105mm_mp"));
  var0 setclientomnvar("ui_ac130_40mm_ammo", var0 getweaponammoclip("ac130_40mm_mp"));
  var0 setclientomnvar("ui_ac130_25mm_ammo", var0 getweaponammoclip("ac130_25mm_mp"));
  var0 setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
  var0 setclientomnvar("ui_killstreak_health", self.maxhealth);
  var2 = [];

  foreach(var4 in level.characters) {
    if(level.teambased && var4.team == self.team) {
      continue;
    }

    if(var4 == self.owner) {
      continue;
    }

    if(var2.size >= 20) {
      continue;
    }

    var2 = var4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var2, self.owner, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, self.owner, self.owner);
  thread ac130_updateoverlaycoords(var0);
}

function ac130_watchchangeweapons(var0) {
  self endon("death");
  var0 endon("ac130player_removed");
  level endon("ac130player_removed");
  var2 = ["ac130_105mm_mp", "ac130_40mm_mp", "ac130_25mm_mp"];
  var0 scripts\common\utility::allow_weapon_switch(0);

  if(!isai(var0)) {
    var0 notifyonplayercommand("ac130_switch_weapon", "+weapnext");
    var0 setclientomnvar("ui_ac130_weapon", 3);
  }

  var3 = 3;

  for(;;) {
    var0 waittill("ac130_switch_weapon");
    var4 = var0 getcurrentweapon();
    var5 = var4;

    foreach(var7 in var2) {
      if(var4.basename == var7) {
        var8 = var9 + 1;

        if(var8 > var2.size - 1) {
          var8 = 0;
        }

        var5 = var2[var8];
        break;
      }
    }

    var0 scripts\cp\cp_weapons::_switchtoweaponimmediate(var5);
    var3--;

    if(var3 == 0) {
      var3 = 3;
    }

    var0 setclientomnvar("ui_ac130_weapon", var3);
    playfxontagforclients(scripts\engine\utility::getfx("camera_shutter"), var0, "tag_eye", var0);
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

function ac130_watchweaponimpact(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  var0 waittill("missile_stuck", var2, var3, var4, var5, var6, var7);
  var8 = spawn("script_model", var0.origin);
  var8 setModel("ks_ac130_target_mp");
  var8.angles = vectortoangles(var7);
  var8 linkTo(var0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var8 setotherent(self);
  var9 = "on";
  var8 setscriptablepartstate(var0.weapon_name, var9, 0);

  if(isDefined(self)) {
    var0 detonate();
  } else {
    var0 delete();
  }

  var10 = var8.origin;
  var11 = getmissileexplscale(var0.weapon_name);
  var12 = 0.75;
  var13 = getmissileexplradius(var0.weapon_name);
  thread deleteaftertime(var8);
}

function getmissileexplscale(var0) {
  var1 = 1;

  switch (var0) {
    case "ac130_105mm_mp":
      var1 = 0.75;
      break;
    case "ac130_40mm_mp":
      var1 = 0.5;
      break;
    case "ac130_25mm_mp":
      var1 = 0.15;
      break;
  }

  return var1;
}

function getmissileexplradius(var0) {
  var1 = 1;

  switch (var0) {
    case "ac130_105mm_mp":
      var1 = 2000;
      break;
    case "ac130_40mm_mp":
      var1 = 1300;
      break;
    case "ac130_25mm_mp":
      var1 = 700;
      break;
  }

  return var1;
}

function setdof_ac130() {
  self.usingcustomdof = 1;
  scripts\cp\utility::_setdof_internal(10, 80, 1000, 1000, 7, 0);
}

function setdof_ac130_zoom() {
  self.usingcustomdof = 1;
  scripts\cp\utility::_setdof_internal(10, 80, 1000, 6500, 10, 5);
}

function ac130_watchweaponfired(var0) {
  self endon("death");
  level endon("ac130player_removed");
  var0 endon("ac130player_removed");
  thread ac130_track105mmmissile(var0);

  for(;;) {
    var0 waittill("missile_fire", var2);
    var3 = var0 getcurrentweapon();
    var4 = var0 getweaponammoclip(var3);

    switch (var3.basename) {
      case "ac130_105mm_mp":
        earthquake(0.2, 1, self.origin, 1000);
        var0 setclientomnvar("ui_ac130_105mm_ammo", var4);
        break;
      case "ac130_40mm_mp":
        earthquake(0.1, 0.5, self.origin, 1000);
        var0 setclientomnvar("ui_ac130_40mm_ammo", var4);
        break;
      case "ac130_25mm_mp":
        var0 setclientomnvar("ui_ac130_25mm_ammo", var4);
        break;
    }

    if(var4 == 0) {
      thread ac130_weaponreload(var0);
    }

    thread ac130_watchweaponimpact(var0, var2);
  }
}

function ac130_track105mmmissile(var0) {
  self endon("death");
  level endon("ac130player_removed");
  var0 endon("ac130player_removed");

  for(;;) {
    var0 waittill("missile_fire", var1, var2);

    if(var2.basename == "ac130_105mm_mp") {
      thread ac130_watch105mmexplosion(var1, self);
    }
  }
}

function ac130_watch105mmexplosion(var0, var1) {
  level endon("ac130player_removed");
  var1 endon("ac130player_removed");
  var1 endon("disconnect");
  self waittill("death");
  earthquake(0.125, 0.5, var0.origin, 1000);
  var1 visionsetkillstreakforplayer("ac130_color_glitch");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  var1 visionsetkillstreakforplayer("ac130_color");
}

function ac130_weaponreload(var0) {
  self endon("ac130player_removed");
  level endon("ac130player_removed");
  var1 = getac130weaponrootname(var0);
  self playlocalsound(var1 + "_mp_reload");
  ac130_waitforweaponreloadtime(var0, var1);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var1 + "_reloaded");
  var2 = weaponmaxammo(var0);
  self setweaponammoclip(var0, var2);
  self setclientomnvar("ui_" + var1 + "_ammo", var2);
}

function ac130_waitforweaponreloadtime(var0, var1) {
  var2 = level.weaponreloadtime[var0.basename];
  self setclientomnvar("ui_" + var1 + "_reloadtime", gettime() + int(var2 * 1000));

  for(;;) {
    wait 0.05;
    var2 -= 0.05;

    if(var2 <= 0) {
      break;
    }
  }
}

function getac130weaponrootname(var0) {
  var1 = 0;
  var2 = var0.basename;
  var3 = strtok(var2, "_");
  return var3[var1] + "_" + var3[var1 + 1];
}

function playsound25mm() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("ac130player_removed");
  self endon("reset_25mm");
  var0 = self getcurrentweapon();

  for(;;) {
    self waittill("weapon_fired");
    self stoplocalsound("ac130iw6_25mm_fire_loop_cooldown");
    self playLoopSound("ac130iw6_25mm_fire_loop");

    while(self attackButtonPressed() && self getweaponammoclip(var0)) {
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

function ac130_playpilotfx(var0) {
  self endon("death");
  self endon("leaving");
  var0.ac130_cloudsfx = spawn("script_model", var0 getEye());
  var0.ac130_cloudsfx setModel("tag_origin");
  var0.ac130_cloudsfx linkTo(var0, "tag_eye");
  waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("clouds"), var0.ac130_cloudsfx, "tag_origin", var0);
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
    self waittill("projectile_impact", var0, var1, var2);

    if(issubstr(tolower(var0.basename), "105")) {
      earthquake(0.4, 1, var1, 3500);
      self setclientomnvar("ui_ac130_darken", 1);
    } else if(issubstr(tolower(var0.basename), "40")) {
      earthquake(0.2, 0.5, var1, 2000);
    }

    if(scripts\cp\utility::getintproperty("ac130_ragdoll_deaths", 0)) {
      thread shotfiredphysicssphere(var1, var0.basename);
    }

    waitframe();
  }
}

function shotfiredphysicssphere(var0, var1) {
  wait 0.1;
  physicsexplosionsphere(var0, level.physicssphereradius[var1], level.physicssphereradius[var1] / 2, level.physicssphereforce[var1]);
}

function add_beacon_effect() {
  self endon("death");
  var0 = 0.75;
  wait randomfloat(3);

  for(;;) {
    if(level.ac130player) {
      playfxontagforclients(level._effect["beacon"], self, "j_spine4", level.ac130player);
    }

    wait var0;
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
  var0 = [];

  foreach(var2 in level.players) {
    if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(var2.team == level.ac130player.team) {
      continue;
    }

    if(var2.team == "spectator") {
      continue;
    }

    var0 = var2;
  }

  for(var4 = 0; var4 < var0.size; var4++) {
    if(!isDefined(var0[var4])) {
      continue;
    }

    if(!isalive(var0[var4])) {
      continue;
    }

    if(scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var0[var4].origin, level.cosine["5"])) {
      return true;
    }

    wait 0.05;
  }

  return false;
}

function context_sensative_dialog_guy_crawling() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_crawling", var0);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_crawl");
  }
}

function context_sensative_dialog_guy_pain() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_pain", var0);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_pain");
  }
}

function context_sensative_dialog_secondary_explosion_vehicle() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("player_destroyed_car", var0, var1);
    wait 1;
    thread context_sensative_dialog_play_random_group_sound("explosion", "secondary");
  }
}

function enemy_killed_thread() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_killed", var0);
    thread context_sensative_dialog_kill(var0, level.ac130player);
  }
}

function context_sensative_dialog_kill(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  if(!isPlayer(var1)) {
    return;
  }

  level.enemieskilledintimewindow++;
  level notify("enemy_killed");
}

function context_sensative_dialog_kill_thread() {
  self endon("ac130player_removed");
  var0 = 1;

  for(;;) {
    level waittill("enemy_killed");
    wait var0;
    var1 = "kill";
    var2 = undefined;

    if(level.enemieskilledintimewindow >= 2) {
      var2 = "small_group";
    } else {
      var2 = "single";

      if(randomint(3) != 1) {
        level.enemieskilledintimewindow = 0;
        continue;
      }
    }

    level.enemieskilledintimewindow = 0;
    thread context_sensative_dialog_play_random_group_sound(var1, var2, 1);
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
    level waittill("context_location", var0);

    if(!isDefined(var0)) {
      continue;
    }

    if(!scripts\engine\utility::flag("allow_context_sensative_dialog")) {
      continue;
    }

    thread context_sensative_dialog_play_random_group_sound("location", var0);
    wait 5 + randomfloat(10);
  }
}

function context_sensative_dialog_locations_add_notify_event(var0) {
  self endon("ac130player_removed");

  for(;;) {
    self waittill("trigger", var1);

    if(!isDefined(var1)) {
      continue;
    }

    if(!isDefined(var1.team) || var1.team != "axis") {
      continue;
    }

    level notify("context_location", var0);
    wait 5;
  }
}

function context_sensative_dialog_vehiclespawn(var0) {
  if(var0.script_team != "axis") {
    return;
  }

  thread context_sensative_dialog_vehicledeath(var0);
  var0 endon("death");

  while(!scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var0.origin, level.cosine["45"])) {
    wait 0.5;
  }

  context_sensative_dialog_play_random_group_sound("vehicle", "incoming");
}

function context_sensative_dialog_vehicledeath(var0) {
  var0 waittill("death");
  thread context_sensative_dialog_play_random_group_sound("vehicle", "death");
}

function context_sensative_dialog_filler() {
  self endon("ac130player_removed");

  for(;;) {
    if(isDefined(level.radio_in_use) && level.radio_in_use == 1) {
      level waittill("radio_not_in_use");
    }

    var0 = gettime();

    if(var0 - level.lastradiotransmission >= 3000) {
      level.lastradiotransmission = var0;
      thread context_sensative_dialog_play_random_group_sound("misc", "action");
    }

    wait 0.25;
  }
}

function context_sensative_dialog_play_random_group_sound(var0, var1, var2) {
  level endon("ac130player_removed");

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!scripts\engine\utility::flag("allow_context_sensative_dialog")) {
    if(var2) {
      scripts\engine\utility::flag_wait("allow_context_sensative_dialog");
    } else {
      return;
    }
  }

  var3 = undefined;
  var4 = randomint(level.scr_sound[var0][var1].size);

  if(level.scr_sound[var0][var1][var4].played == 1) {
    for(var5 = 0; var5 < level.scr_sound[var0][var1].size; var5++) {
      var4++;

      if(var4 >= level.scr_sound[var0][var1].size) {
        var4 = 0;
      }

      if(level.scr_sound[var0][var1][var4].played == 1) {
        continue;
      }

      var3 = var4;
      break;
    }

    if(!isDefined(var3)) {
      for(var5 = 0; var5 < level.scr_sound[var0][var1].size; var5++) {
        level.scr_sound[var0][var1][var5].played = 0;
      }

      var3 = randomint(level.scr_sound[var0][var1].size);
    }
  } else {
    var3 = var4;
  }

  if(context_sensative_dialog_timedout(var0, var1, var3)) {
    return;
  }

  level.scr_sound[var0][var1][var3].played = 1;
  var6 = randomint(level.scr_sound[var0][var1][var3].size);
  playsoundoverradio(level.scr_sound[var0][var1][var3].sounds[var6], var2);
}

function context_sensative_dialog_timedout(var0, var1, var2) {
  if(!isDefined(level.context_sensative_dialog_timeouts)) {
    return false;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[var0])) {
    return false;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[var0][var1])) {
    return false;
  }

  if(isDefined(level.context_sensative_dialog_timeouts[var0][var1].groups) && isDefined(level.context_sensative_dialog_timeouts[var0][var1].groups[scripts\engine\utility::string(var2)])) {
    var3 = gettime();

    if(var3 - level.context_sensative_dialog_timeouts[var0][var1].groups[scripts\engine\utility::string(var2)].v["lastPlayed"] < level.context_sensative_dialog_timeouts[var0][var1].groups[scripts\engine\utility::string(var2)].v["timeoutDuration"]) {
      return true;
    }

    level.context_sensative_dialog_timeouts[var0][var1].groups[scripts\engine\utility::string(var2)].v["lastPlayed"] = var3;
  } else if(isDefined(level.context_sensative_dialog_timeouts[var0][var1].v)) {
    var3 = gettime();

    if(var3 - level.context_sensative_dialog_timeouts[var0][var1].v["lastPlayed"] < level.context_sensative_dialog_timeouts[var0][var1].v["timeoutDuration"]) {
      return true;
    }

    level.context_sensative_dialog_timeouts[var0][var1].v["lastPlayed"] = var3;
  }

  return false;
}

function playsoundoverradio(var0, var1, var2) {
  if(!isDefined(level.radio_in_use)) {
    level.radio_in_use = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var2 *= 1000;
  var3 = gettime();
  var4 = 0;
  var4 = playaliasoverradio(var0);

  if(var4) {
    return;
  }

  if(!var1) {
    return;
  }

  level.radioforcedtransmissionqueue[level.radioforcedtransmissionqueue.size] = var0;

  while(!var4) {
    if(level.radio_in_use) {
      level waittill("radio_not_in_use");
    }

    if(var2 > 0 && gettime() - var3 > var2) {
      break;
    }

    if(!isDefined(level.ac130player)) {
      break;
    }

    var4 = playaliasoverradio(level.radioforcedtransmissionqueue[0]);

    if(!level.radio_in_use && isDefined(level.ac130player) && !var4) {}
  }

  level.radioforcedtransmissionqueue = scripts\engine\utility::array_remove_index(level.radioforcedtransmissionqueue, 0);
}

function playaliasoverradio(var0) {
  if(level.radio_in_use) {
    return false;
  }

  if(!isDefined(level.ac130player)) {
    return false;
  }

  level.radio_in_use = 1;
  level.ac130player playlocalsound(var0);
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

function flares_monitor(var0) {
  self.flaresreservecount = var0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
  thread ks_airsuperiority_handleincoming();
}

function playflarefx(var0) {
  for(var1 = 0; var1 < var0; var1++) {
    thread ac130_playflares();
    wait randomfloatrange(0.1, 0.25);
  }
}

function deployflares(var0) {
  self playSound("ac130iw6_flare_burst");

  if(!isDefined(var0)) {
    var1 = spawn("script_origin", level.ac130.planemodel.origin);
    var1.angles = level.ac130.planemodel.angles;
    var1 movegravity((0, 0, 0), 5);
    thread playflarefx(10);
    self.flareslive[self.flareslive.size] = var1;
    thread deleteaftertime(var1);
    return var1;
  }

  thread playflarefx(5);
}

function flares_getnumleft(var0) {
  return var0.flaresreservecount;
}

function flares_areavailable(var0) {
  flares_cleanflareslivearray(var0);
  return var0.flaresreservecount > 0 || var0.flareslive.size > 0;
}

function flares_getflarereserve(var0) {
  var0.flaresreservecount--;
  var1 = deployflares(var0);
  return var1;
}

function flares_cleanflareslivearray(var0) {
  var0.flareslive = scripts\engine\utility::array_removeundefined(var0.flareslive);
}

function flares_getflarelive(var0) {
  flares_cleanflareslivearray(var0);
  var1 = undefined;

  if(var0.flareslive.size > 0) {
    var1 = var0.flareslive[var0.flareslive.size - 1];
  }

  return var1;
}

function ks_laserguidedmissile_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(flares_areavailable(self)) {
    level waittill("laserGuidedMissiles_incoming", var0, var1, var2);

    if(!isDefined(var2) || var2 != self) {
      continue;
    }

    thread ks_watch_death_stop_sound(level.ac130player, self);

    foreach(var4 in var1) {
      if(isvalidmissile(var4)) {
        thread ks_laserguidedmissile_monitorproximity(level, var4, var0, var0.team);
      }
    }
  }
}

function ks_laserguidedmissile_monitorproximity(var0, var1, var2, var3) {
  var3 endon("death");
  var0 endon("death");
  var0 endon("missile_targetChanged");

  while(flares_areavailable(var3)) {
    if(!isDefined(var3) || !isvalidmissile(var0)) {
      break;
    }

    var4 = var3 getpointinbounds(0, 0, 0);

    if(distancesquared(var0.origin, var4) < 4000000) {
      var5 = flares_getflarelive(var3);

      if(!isDefined(var5)) {
        var5 = flares_getflarereserve(var3);
      }

      var0 missile_settargetEnt(var5);
      var0 notify("missile_pairedWithFlare");
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
    self waittill("targeted_by_incoming_missile", var0);

    if(!isDefined(var0)) {
      continue;
    }

    thread ks_watch_death_stop_sound(level.ac130player, self);

    foreach(var2 in var0) {
      if(isvalidmissile(var2)) {
        thread ks_airsuperiority_monitorproximity(var2);
      }
    }
  }
}

function ks_airsuperiority_monitorproximity(var0) {
  self endon("death");
  var0 endon("death");

  for(;;) {
    if(!isDefined(self) || !isvalidmissile(var0)) {
      break;
    }

    var1 = self getpointinbounds(0, 0, 0);

    if(distancesquared(var0.origin, var1) < 4000000) {
      var2 = flares_getflarelive(self);

      if(!isDefined(var2) && self.flaresreservecount > 0) {
        var2 = flares_getflarereserve(self);
      }

      if(isDefined(var2)) {
        var0 missile_settargetEnt(var2);
        var0 notify("missile_pairedWithFlare");
        level.ac130player stoplocalsound("missile_incoming");
        break;
      }
    }

    waitframe();
  }
}

function ks_watch_death_stop_sound(var0, var1) {
  self endon("disconnect");
  var0 waittill("death");
  self stoplocalsound(var1);
}

function deleteaftertime(var0) {
  wait var0;
  self delete();
}

function ac130_crash(var0, var1) {
  self notify("crashing");
  self.crashed = 1;
  ac130_returnplayer(var1, 0);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var0);
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
  var0 = spawn("script_model", self.origin);
  var0 setModel("angel_flare_rig");
  var0.origin = self gettagorigin("tag_flash_flares");
  var0.angles = self gettagangles("tag_flash_flares");
  var0.angles = (var0.angles[0], var0.angles[1] + 180, var0.angles[2] + -90);
  var1 = level._effect["angel_flare_geotrail"];
  var0 scriptmodelplayanim("ac130_angel_flares0" + randomint(3) + 1);
  wait 0.1;
  playFXOnTag(var1, var0, "flare_left_top");
  playFXOnTag(var1, var0, "flare_right_top");
  wait 0.05;
  playFXOnTag(var1, var0, "flare_left_bot");
  playFXOnTag(var1, var0, "flare_right_bot");
  wait 3;
  stopFXOnTag(var1, var0, "flare_left_top");
  stopFXOnTag(var1, var0, "flare_right_top");
  stopFXOnTag(var1, var0, "flare_left_bot");
  stopFXOnTag(var1, var0, "flare_right_bot");
  var0 delete();
}

function objectivewmdthink(var0) {
  var1 = 0;

  while(!var1) {
    var1 = istargetinreticle(level.objective_nuke, 70, 50);
    wait 0.5;
  }
}

function istargetinreticle(var0, var1, var2) {
  var3 = 0;
  var4 = [var0.origin];

  if(isPlayer(var0)) {
    var4 = [var0.origin, var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_eye")];
  }

  foreach(var6 in var4) {
    if(self worldpointinreticle_circle(var6, var1, var2)) {
      var3 = 1;
      break;
    }
  }

  return var3;
}
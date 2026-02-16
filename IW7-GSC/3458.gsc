/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3458.gsc
**************************************/

init() {
  level.ac130_use_duration = 40;
  angelflareprecache();
  level._effect["cloud"] = loadfx("vfx\misc\ac130_cloud");
  level._effect["beacon"] = loadfx("vfx\misc\ir_beacon_coop");
  level._effect["ac130_explode"] = loadfx("vfx\core\expl\aerial_explosion_ac130_coop");
  level._effect["ac130_flare"] = loadfx("vfx\misc\flares_cobra");
  level._effect["ac130_light_red"] = loadfx("vfx\core\vehicles\aircraft_light_wingtip_red");
  level._effect["ac130_light_white_blink"] = loadfx("vfx\core\vehicles\aircraft_light_white_blink");
  level._effect["ac130_light_red_blink"] = loadfx("vfx\core\vehicles\aircraft_light_red_blink");
  level._effect["ac130_engineeffect"] = loadfx("vfx\misc\jet_engine_ac130");
  level._effect["coop_muzzleflash_105mm"] = loadfx("vfx\core\muzflash\ac130_105mm");
  level._effect["coop_muzzleflash_40mm"] = loadfx("vfx\core\muzflash\ac130_40mm");
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
  level.physicssphereforce["ac130_40mm_mp"] = 3.0;
  level.physicssphereforce["ac130_105mm_mp"] = 6.0;
  level.weaponreloadtime["ac130_25mm_mp"] = 1.5;
  level.weaponreloadtime["ac130_40mm_mp"] = 3.0;
  level.weaponreloadtime["ac130_105mm_mp"] = 5.0;
  level.ac130_speed["move"] = 250;
  level.ac130_speed["rotate"] = 70;
  scripts\engine\utility::flag_init("allow_context_sensative_dialog");
  scripts\engine\utility::flag_set("allow_context_sensative_dialog");
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = (0, 0, 0);

  if(var_0.size) {
    var_1 = scripts\mp\spawnlogic::findboxcenter(var_0[0].origin, var_0[1].origin);
  }

  level.ac130 = spawn("script_model", var_1);
  level.ac130 setModel("c130_zoomRig");
  level.ac130.angles = (0, 115, 0);
  level.ac130.owner = undefined;
  level.ac130.thermal_vision = "ac130_thermal_mp";
  level.ac130.enhanced_vision = "ac130_enhanced_mp";
  level.ac130.targetname = "ac130rig_script_model";
  level.ac130 hide();
  level.ac130inuse = 0;
  thread rotateplane("on");
  thread ac130_spawn();
  thread onplayerconnect();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("ac130", ::tryuseac130);
  level.ac130queue = [];
}

tryuseac130(var_0, var_1) {
  if(isDefined(level.ac130player) || level.ac130inuse) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility\game::isusingremote()) {
    return 0;
  }

  if(scripts\mp\utility\game::iskillstreakdenied()) {
    return 0;
  }

  scripts\mp\utility\game::setusingremote("ac130");
  var_2 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_1);

  if(var_2 != "success") {
    if(var_2 != "disconnect") {
      scripts\mp\utility\game::clearusingremote();
    }

    return 0;
  }

  var_2 = setac130player(self);

  if(isDefined(var_2) && var_2) {
    level.ac130.planemodel.crashed = undefined;
    level.ac130inuse = 1;
  } else {
    scripts\mp\utility\game::clearusingremote();
  }

  return isDefined(var_2) && var_2;
}

init_sounds() {
  level.scr_sound["foo"]["bar"] = "";
  add_context_sensative_dialog("ai", "in_sight", 0, "ac130_fco_moreenemy");
  add_context_sensative_dialog("ai", "in_sight", 1, "ac130_fco_getthatguy");
  add_context_sensative_dialog("ai", "in_sight", 2, "ac130_fco_guymovin");
  add_context_sensative_dialog("ai", "in_sight", 3, "ac130_fco_getperson");
  add_context_sensative_dialog("ai", "in_sight", 4, "ac130_fco_guyrunnin");
  add_context_sensative_dialog("ai", "in_sight", 5, "ac130_fco_gotarunner");
  add_context_sensative_dialog("ai", "in_sight", 6, "ac130_fco_backonthose");
  add_context_sensative_dialog("ai", "in_sight", 7, "ac130_fco_gonnagethim");
  add_context_sensative_dialog("ai", "in_sight", 8, "ac130_fco_personnelthere");
  add_context_sensative_dialog("ai", "in_sight", 9, "ac130_fco_nailthoseguys");
  add_context_sensative_dialog("ai", "in_sight", 11, "ac130_fco_lightemup");
  add_context_sensative_dialog("ai", "in_sight", 12, "ac130_fco_takehimout");
  add_context_sensative_dialog("ai", "in_sight", 14, "ac130_plt_yeahcleared");
  add_context_sensative_dialog("ai", "in_sight", 15, "ac130_plt_copysmoke");
  add_context_sensative_dialog("ai", "in_sight", 16, "ac130_fco_rightthere");
  add_context_sensative_dialog("ai", "in_sight", 17, "ac130_fco_tracking");
  add_context_sensative_dialog("ai", "in_sight", 0, "ac130_fco_getthatguy");
  add_context_sensative_dialog("ai", "in_sight", 1, "ac130_fco_guymovin");
  add_context_sensative_dialog("ai", "in_sight", 2, "ac130_fco_getperson");
  add_context_sensative_dialog("ai", "in_sight", 3, "ac130_fco_guyrunnin");
  add_context_sensative_dialog("ai", "in_sight", 4, "ac130_fco_gotarunner");
  add_context_sensative_dialog("ai", "in_sight", 5, "ac130_fco_backonthose");
  add_context_sensative_dialog("ai", "in_sight", 6, "ac130_fco_gonnagethim");
  add_context_sensative_dialog("ai", "in_sight", 7, "ac130_fco_nailthoseguys");
  add_context_sensative_dialog("ai", "in_sight", 8, "ac130_fco_lightemup");
  add_context_sensative_dialog("ai", "in_sight", 9, "ac130_fco_takehimout");
  add_context_sensative_dialog("ai", "in_sight", 10, "ac130_plt_yeahcleared");
  add_context_sensative_dialog("ai", "in_sight", 11, "ac130_plt_copysmoke");
  add_context_sensative_dialog("ai", "in_sight", 0, "ac130_fco_moreenemy");
  add_context_sensative_dialog("ai", "in_sight", 1, "ac130_fco_getthatguy");
  add_context_sensative_dialog("ai", "in_sight", 2, "ac130_fco_guymovin");
  add_context_sensative_dialog("ai", "in_sight", 3, "ac130_fco_getperson");
  add_context_sensative_dialog("ai", "in_sight", 4, "ac130_fco_guyrunnin");
  add_context_sensative_dialog("ai", "in_sight", 5, "ac130_fco_gotarunner");
  add_context_sensative_dialog("ai", "in_sight", 6, "ac130_fco_backonthose");
  add_context_sensative_dialog("ai", "in_sight", 7, "ac130_fco_gonnagethim");
  add_context_sensative_dialog("ai", "in_sight", 8, "ac130_fco_personnelthere");
  add_context_sensative_dialog("ai", "in_sight", 9, "ac130_fco_nailthoseguys");
  add_context_sensative_dialog("ai", "in_sight", 11, "ac130_fco_lightemup");
  add_context_sensative_dialog("ai", "in_sight", 12, "ac130_fco_takehimout");
  add_context_sensative_dialog("ai", "in_sight", 14, "ac130_plt_yeahcleared");
  add_context_sensative_dialog("ai", "in_sight", 15, "ac130_plt_copysmoke");
  add_context_sensative_dialog("ai", "in_sight", 16, "ac130_fco_rightthere");
  add_context_sensative_dialog("ai", "in_sight", 17, "ac130_fco_tracking");
  add_context_sensative_dialog("ai", "wounded_crawl", 0, "ac130_fco_movingagain");
  add_context_sensative_timeout("ai", "wounded_crawl", undefined, 6);
  add_context_sensative_dialog("ai", "wounded_pain", 0, "ac130_fco_doveonground");
  add_context_sensative_dialog("ai", "wounded_pain", 1, "ac130_fco_knockedwind");
  add_context_sensative_dialog("ai", "wounded_pain", 2, "ac130_fco_downstillmoving");
  add_context_sensative_dialog("ai", "wounded_pain", 3, "ac130_fco_gettinbackup");
  add_context_sensative_dialog("ai", "wounded_pain", 4, "ac130_fco_yepstillmoving");
  add_context_sensative_dialog("ai", "wounded_pain", 5, "ac130_fco_stillmoving");
  add_context_sensative_timeout("ai", "wounded_pain", undefined, 12);
  add_context_sensative_dialog("weapons", "105mm_ready", 0, "ac130_gnr_gunready1");
  add_context_sensative_dialog("weapons", "105mm_fired", 0, "ac130_gnr_shot1");
  add_context_sensative_dialog("plane", "rolling_in", 0, "ac130_plt_rollinin");
  add_context_sensative_dialog("explosion", "secondary", 0, "ac130_nav_secondaries1");
  add_context_sensative_timeout("explosion", "secondary", undefined, 7);
  add_context_sensative_dialog("kill", "single", 0, "ac130_plt_gottahurt");
  add_context_sensative_dialog("kill", "single", 1, "ac130_fco_iseepieces");
  add_context_sensative_dialog("kill", "single", 2, "ac130_fco_oopsiedaisy");
  add_context_sensative_dialog("kill", "single", 3, "ac130_fco_goodkill");
  add_context_sensative_dialog("kill", "single", 4, "ac130_fco_yougothim");
  add_context_sensative_dialog("kill", "single", 5, "ac130_fco_yougothim2");
  add_context_sensative_dialog("kill", "single", 6, "ac130_fco_thatsahit");
  add_context_sensative_dialog("kill", "single", 7, "ac130_fco_directhit");
  add_context_sensative_dialog("kill", "single", 8, "ac130_fco_rightontarget");
  add_context_sensative_dialog("kill", "single", 9, "ac130_fco_okyougothim");
  add_context_sensative_dialog("kill", "single", 10, "ac130_fco_within2feet");
  add_context_sensative_dialog("kill", "small_group", 0, "ac130_fco_nice");
  add_context_sensative_dialog("kill", "small_group", 1, "ac130_fco_directhits");
  add_context_sensative_dialog("kill", "small_group", 2, "ac130_fco_iseepieces");
  add_context_sensative_dialog("kill", "small_group", 3, "ac130_fco_goodkill");
  add_context_sensative_dialog("kill", "small_group", 4, "ac130_fco_yougothim");
  add_context_sensative_dialog("kill", "small_group", 5, "ac130_fco_yougothim2");
  add_context_sensative_dialog("kill", "small_group", 6, "ac130_fco_thatsahit");
  add_context_sensative_dialog("kill", "small_group", 7, "ac130_fco_directhit");
  add_context_sensative_dialog("kill", "small_group", 8, "ac130_fco_rightontarget");
  add_context_sensative_dialog("kill", "small_group", 9, "ac130_fco_okyougothim");
  add_context_sensative_dialog("misc", "action", 0, "ac130_fco_tracking");
  add_context_sensative_timeout("misc", "action", 0, 70);
  add_context_sensative_dialog("misc", "action", 1, "ac130_fco_moreenemy");
  add_context_sensative_timeout("misc", "action", 1, 80);
  add_context_sensative_dialog("misc", "action", 2, "ac130_random");
  add_context_sensative_timeout("misc", "action", 2, 55);
  add_context_sensative_dialog("misc", "action", 3, "ac130_fco_rightthere");
  add_context_sensative_timeout("misc", "action", 3, 100);
}

add_context_sensative_dialog(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\teams::getteamvoiceprefix("allies") + var_3;
  var_4 = scripts\mp\teams::getteamvoiceprefix("axis") + var_3;

  if(!isDefined(level.scr_sound[var_0]) || !isDefined(level.scr_sound[var_0][var_1]) || !isDefined(level.scr_sound[var_0][var_1][var_2])) {
    level.scr_sound[var_0][var_1][var_2] = spawnStruct();
    level.scr_sound[var_0][var_1][var_2].played = 0;
    level.scr_sound[var_0][var_1][var_2].sounds = [];
  }

  var_5 = level.scr_sound[var_0][var_1][var_2].sounds.size;
  level.scr_sound[var_0][var_1][var_2].sounds[var_5] = var_3;
}

add_context_sensative_timeout(var_0, var_1, var_2, var_3) {
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
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[string(var_2)] = spawnStruct();
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[string(var_2)].v["timeoutDuration"] = var_3 * 1000;
    level.context_sensative_dialog_timeouts[var_0][var_1].groups[string(var_2)].v["lastPlayed"] = var_3 * -1000;
  } else {
    level.context_sensative_dialog_timeouts[var_0][var_1].v["timeoutDuration"] = var_3 * 1000;
    level.context_sensative_dialog_timeouts[var_0][var_1].v["lastPlayed"] = var_3 * -1000;
  }
}

play_sound_on_entity(var_0) {
  scripts\mp\utility\game::play_sound_on_tag(var_0);
}

array_remove_nokeys(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1) {
      var_2[var_2.size] = var_0[var_3];
    }
  }

  return var_2;
}

string(var_0) {
  return "" + var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
  }
}

deleteonac130playerremoved() {
  level waittill("ac130player_removed");
  self delete();
}

monitormanualplayerexit() {
  level endon("game_ended");
  level endon("ac130player_removed");
  self endon("disconnect");
  level.ac130 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  level.ac130 waittill("killstreakExit");

  if(isDefined(level.ac130.owner)) {
    level thread removeac130player(level.ac130.owner, 0);
  }
}

setac130player(var_0) {
  self endon("ac130player_removed");

  if(isDefined(level.ac130player)) {
    return 0;
  }

  init_sounds();
  level.ac130player = var_0;
  level.ac130.owner = var_0;
  level.ac130.planemodel show();
  level.ac130.planemodel thread playac130effects();
  level.ac130.incomingmissile = 0;
  level.ac130.planemodel playLoopSound("veh_ac130iw6_ext_dist");
  level.ac130.planemodel thread damagetracker();
  thread handleincomingmissiles();
  level.ac130.planemodel thermaldrawenable();
  var_1 = spawnplane(var_0, "script_model", level.ac130.planemodel.origin, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy");
  var_1 notsolid();
  var_1 linkto(level.ac130, "tag_player", (0, 80, 32), (0, -90, 0));
  var_1 thread deleteonac130playerremoved();
  thread scripts\mp\utility\game::teamplayercardsplash("used_ac130", var_0);
  var_0 thread waitsetthermal(1.0);
  var_0 thread scripts\mp\utility\game::reinitializethermal(level.ac130.planemodel);

  if(getdvarint("camera_thirdPerson")) {
    var_0 scripts\mp\utility\game::setthirdpersondof(0);
  }

  var_0 scripts\mp\utility\game::_giveweapon("ac130_105mm_mp");
  var_0 scripts\mp\utility\game::_giveweapon("ac130_40mm_mp");
  var_0 scripts\mp\utility\game::_giveweapon("ac130_25mm_mp");
  var_0 scripts\mp\utility\game::_switchtoweapon("ac130_105mm_mp");
  var_0 thread removeac130playeraftertime(level.ac130_use_duration * var_0.killstreakscaler);
  var_0 setclientomnvar("ui_ac130_hud", 1);
  var_0 thread overlay_coords();
  var_0 setblurforplayer(1.2, 0);
  var_0 thread attachplayer(var_0);
  var_0 thread changeweapons();
  var_0 thread weaponfiredthread();
  var_0 thread context_sensative_dialog();
  var_0 thread shotfired();
  var_0 thread clouds();

  if(isbot(self)) {
    self.vehicle_controlling = level.ac130;
    var_0 thread ac130_control_bot_aiming();
  }

  var_0 thread watchhostmigrationfinishedinit();
  var_0 thread removeac130playerondisconnect();
  var_0 thread removeac130playeronchangeteams();
  var_0 thread removeac130playeronspectate();
  var_0 thread removeac130playeroncrash();
  var_0 thread removeac130playerongamecleanup();
  var_0 thread monitormanualplayerexit();
  thread ac130_altscene();
  return 1;
}

initac130hud() {
  self setclientomnvar("ui_ac130_hud", 1);
  scripts\engine\utility::waitframe();
  scripts\mp\utility\game::_switchtoweapon("ac130_105mm_mp");
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_weapon", 0);
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_105mm_ammo", self getweaponammoclip("ac130_105mm_mp"));
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_40mm_ammo", self getweaponammoclip("ac130_40mm_mp"));
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_25mm_ammo", self getweaponammoclip("ac130_25mm_mp"));
  scripts\engine\utility::waitframe();
  thread overlay_coords();
}

watchhostmigrationfinishedinit() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    initac130hud();
  }
}

waitsetthermal(var_0) {
  self endon("disconnect");
  level endon("ac130player_removed");
  wait(var_0);
  self visionsetthermalforplayer(game["thermal_vision"], 0);
  self thermalvisionfofoverlayon();
  thread thermalvision();
}

playac130effects() {
  wait 0.05;
  playFXOnTag(level._effect["ac130_light_red_blink"], self, "tag_light_belly");
  playFXOnTag(level._effect["ac130_engineeffect"], self, "tag_body");
  wait 0.5;
  playFXOnTag(level._effect["ac130_light_white_blink"], self, "tag_light_tail");
  playFXOnTag(level._effect["ac130_light_red"], self, "tag_light_top");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_light_L_wing");
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_light_R_wing");
}

ac130_altscene() {
  foreach(var_1 in level.players) {
    if(var_1 != level.ac130player && var_1.team == level.ac130player.team) {
      var_1 thread scripts\mp\utility\game::setaltsceneobj(level.ac130.cameramodel, "tag_origin", 20);
    }
  }
}

removeac130playerongameend() {
  self endon("ac130player_removed");
  level waittill("game_ended");
  level thread removeac130player(self, 0);
}

removeac130playerongamecleanup() {
  self endon("ac130player_removed");
  level waittill("game_cleanup");
  level thread removeac130player(self, 0);
}

removeac130playerondeath() {
  self endon("ac130player_removed");
  self waittill("death");
  level thread removeac130player(self, 0);
}

removeac130playeroncrash() {
  self endon("ac130player_removed");
  level.ac130.planemodel waittill("crashing");
  level thread removeac130player(self, 0);
}

removeac130playerondisconnect() {
  self endon("ac130player_removed");
  self waittill("disconnect");
  level thread removeac130player(self, 1);
}

removeac130playeronchangeteams() {
  self endon("ac130player_removed");
  self waittill("joined_team");
  level thread removeac130player(self, 0);
}

removeac130playeronspectate() {
  self endon("ac130player_removed");
  scripts\engine\utility::waittill_any("joined_spectators", "spawned");
  level thread removeac130player(self, 0);
}

removeac130playeraftertime(var_0) {
  self endon("ac130player_removed");
  var_1 = var_0;
  self setclientomnvar("ui_ac130_use_time", var_1 * 1000 + gettime());
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  self setclientomnvar("ui_ac130_use_time", 0);
  level thread removeac130player(self, 0);
}

removeac130player(var_0, var_1) {
  var_0 notify("ac130player_removed");
  level notify("ac130player_removed");
  level.ac130.cameramodel notify("death");
  waittillframeend;

  if(!var_1) {
    var_0 scripts\mp\utility\game::clearusingremote();
    var_0 stopolcalsound("missile_incoming");
    var_0 stoploopsound();
    var_0 show();
    var_0 unlink();

    if(isbot(var_0)) {
      var_0 controlsunlink();
      var_0 cameraunlink();
      var_0.vehicle_controlling = undefined;
    }

    var_0 thermalvisionoff();
    var_0 thermalvisionfofoverlayoff();
    var_0 visionsetthermalforplayer(level.ac130.thermal_vision, 0);
    var_0.lastvisionsetthermal = level.ac130.thermal_vision;
    var_0 setblurforplayer(0, 0);

    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility\game::setthirdpersondof(1);
    }

    var_2 = scripts\mp\utility\game::getkillstreakweapon("ac130");
    var_0 scripts\mp\utility\game::_takeweapon(var_2);
    var_0 scripts\mp\utility\game::_takeweapon("ac130_105mm_mp");
    var_0 scripts\mp\utility\game::_takeweapon("ac130_40mm_mp");
    var_0 scripts\mp\utility\game::_takeweapon("ac130_25mm_mp");
    var_0 setclientomnvar("ui_ac130_hud", 0);
  }

  removefromlittlebirdlist();
  wait 0.5;
  level.ac130.planemodel playSound("veh_ac130iw6_ext_dist_fade");
  wait 0.5;
  level.ac130player = undefined;
  level.ac130.planemodel hide();
  level.ac130.planemodel stoploopsound();

  if(isDefined(level.ac130.planemodel.crashed)) {
    level.ac130inuse = 0;
    return;
  }

  var_3 = spawn("script_model", level.ac130.planemodel gettagorigin("tag_origin"));
  var_3.angles = level.ac130.planemodel.angles;
  var_3 setModel("vehicle_y_8_gunship_mp");
  var_4 = var_3.origin + anglestoright(var_3.angles) * 20000;
  var_4 = var_4 + (0, 0, 10000);
  var_3 thread playac130effects();
  var_3 moveto(var_4, 40.0, 0.0, 0.0);
  var_5 = (0, var_3.angles[1], -20);
  var_3 rotateto(var_5, 30, 1, 1);
  var_3 thread deployflares(1);
  wait 5.0;
  var_3 thread deployflares(1);
  wait 5.0;
  var_3 thread deployflares(1);
  level.ac130inuse = 0;
  wait 30.0;
  var_3 delete();
}

removefromlittlebirdlist() {
  var_0 = level.ac130.planemodel getentitynumber();
  level.littlebirds[var_0] = undefined;
}

damagetracker() {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  self.health = 999999;
  self.maxhealth = 1000;
  self.damagetaken = 0;
  self.team = level.ac130player.team;
  scripts\mp\killstreaks\helicopter::addtolittlebirdlist();
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(level.ac130player) && level.teambased && isPlayer(var_1) && var_1.team == level.ac130player.team && !isDefined(level.nukedetonated)) {
      continue;
    }
    if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }
    self.wasdamaged = 1;
    var_10 = var_0;

    if(isPlayer(var_1)) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback("ac130");
    }

    scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_9, level.ac130);

    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1.owner scripts\mp\damagefeedback::updatedamagefeedback("ac130");
    }

    self.damagetaken = self.damagetaken + var_10;

    if(self.damagetaken >= self.maxhealth) {
      if(isPlayer(var_1)) {
        thread scripts\mp\utility\game::teamplayercardsplash("callout_destroyed_ac130", var_1);
        var_1 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_9, 400);
        var_1 notify("destroyed_killstreak");
      }

      level thread crashplane(10.0);
    }
  }
}

ac130_spawn() {
  wait 0.05;
  var_0 = spawn("script_model", level.ac130 gettagorigin("tag_player"));
  var_0 setModel("vehicle_y_8_gunship_mp");
  var_0.targetname = "vehicle_y_8_gunship_mp";
  var_0 setCanDamage(1);
  var_0.maxhealth = 1000;
  var_0.health = var_0.maxhealth;
  var_0 linkto(level.ac130, "tag_player", (0, 80, 32), (-25, 0, 0));
  level.ac130.planemodel = var_0;
  level.ac130.planemodel hide();
  var_1 = spawn("script_model", level.ac130 gettagorigin("tag_player"));
  var_1 setModel("tag_origin");
  var_1 hide();
  var_1.targetname = "ac130CameraModel";
  var_1 linkto(level.ac130, "tag_player", (0, 0, 32), (5, 0, 0));
  level.ac130.cameramodel = var_1;
}

overlay_coords() {
  self endon("ac130player_removed");
  wait 0.05;
  thread updateplanemodelcoords();
  thread updateaimingcoords();
}

updateplanemodelcoords() {
  self endon("ac130player_removed");

  for(;;) {
    self setclientomnvar("ui_ac130_coord1_posx", abs(level.ac130.planemodel.origin[0]));
    self setclientomnvar("ui_ac130_coord1_posy", abs(level.ac130.planemodel.origin[1]));
    self setclientomnvar("ui_ac130_coord1_posz", abs(level.ac130.planemodel.origin[2]));
    wait 0.5;
  }
}

updateplayerpositioncoords() {
  self endon("ac130player_removed");
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_coord2_posx", abs(self.origin[0]));
  self setclientomnvar("ui_ac130_coord2_posy", abs(self.origin[1]));
  self setclientomnvar("ui_ac130_coord2_posz", abs(self.origin[2]));
}

updateaimingcoords() {
  self endon("ac130player_removed");

  for(;;) {
    var_0 = self getEye();
    var_1 = self getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * 15000;
    var_4 = _physicstrace(var_0, var_3);
    self setclientomnvar("ui_ac130_coord3_posx", abs(var_4[0]));
    self setclientomnvar("ui_ac130_coord3_posy", abs(var_4[1]));
    self setclientomnvar("ui_ac130_coord3_posz", abs(var_4[2]));
    wait 0.1;
  }
}

ac130shellshock() {
  self endon("ac130player_removed");
  level endon("post_effects_disabled");
  var_0 = 5;

  for(;;) {
    self shellshock("ac130", var_0);
    wait(var_0);
  }
}

rotateplane(var_0) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(var_0 == "on") {
    var_1 = 10;
    var_2 = level.ac130_speed["rotate"] / 360 * var_1;
    level.ac130 rotateyaw(level.ac130.angles[2] + var_1, var_2, var_2, 0);

    for(;;) {
      level.ac130 rotateyaw(360, level.ac130_speed["rotate"]);
      wait(level.ac130_speed["rotate"]);
    }
  } else if(var_0 == "off") {
    var_3 = 10;
    var_2 = level.ac130_speed["rotate"] / 360 * var_3;
    level.ac130 rotateyaw(level.ac130.angles[2] + var_3, var_2, 0, var_2);
  }
}

attachplayer(var_0) {
  if(isbot(var_0)) {
    var_0 cameralinkto(level.ac130, "tag_player");
  }

  self getwholescenedurationmax(level.ac130.cameramodel, "tag_player", 1.0, 35, 35, 35, 35);
  self setplayerangles(level.ac130 gettagangles("tag_player"));
}

changeweapons() {
  self endon("ac130player_removed");
  wait 0.05;
  self enableweapons();
  self enableweaponswitch();
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_105mm_ammo", self getweaponammoclip("ac130_105mm_mp"));
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_40mm_ammo", self getweaponammoclip("ac130_40mm_mp"));
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_25mm_ammo", self getweaponammoclip("ac130_25mm_mp"));

  for(;;) {
    self waittill("weapon_change", var_0);
    thread play_sound_on_entity("ac130iw6_weapon_switch");
    self notify("reset_25mm");
    self stoploopsound("ac130iw6_25mm_fire_loop");

    switch (var_0) {
      case "ac130_105mm_mp":
        self setclientomnvar("ui_ac130_weapon", 0);
        break;
      case "ac130_40mm_mp":
        self setclientomnvar("ui_ac130_weapon", 1);
        break;
      case "ac130_25mm_mp":
        self setclientomnvar("ui_ac130_weapon", 2);
        thread playsound25mm();
        break;
    }
  }
}

weaponfiredthread() {
  self endon("ac130player_removed");

  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();

    switch (var_0) {
      case "ac130_105mm_mp":
        thread gun_fired_and_ready_105mm();
        earthquake(0.2, 1, level.ac130.planemodel.origin, 1000);
        self setclientomnvar("ui_ac130_105mm_ammo", self getweaponammoclip(var_0));
        break;
      case "ac130_40mm_mp":
        earthquake(0.1, 0.5, level.ac130.planemodel.origin, 1000);
        self setclientomnvar("ui_ac130_40mm_ammo", self getweaponammoclip(var_0));
        break;
      case "ac130_25mm_mp":
        self setclientomnvar("ui_ac130_25mm_ammo", self getweaponammoclip(var_0));
        break;
    }

    if(self getweaponammoclip(var_0)) {
      continue;
    }
    thread weaponreload(var_0);
  }
}

weaponreload(var_0) {
  self endon("ac130player_removed");
  wait(level.weaponreloadtime[var_0]);
  self setweaponammoclip(var_0, 9999);

  switch (var_0) {
    case "ac130_105mm_mp":
      self setclientomnvar("ui_ac130_105mm_ammo", self getweaponammoclip(var_0));
      break;
    case "ac130_40mm_mp":
      self setclientomnvar("ui_ac130_40mm_ammo", self getweaponammoclip(var_0));
      break;
    case "ac130_25mm_mp":
      self setclientomnvar("ui_ac130_25mm_ammo", self getweaponammoclip(var_0));
      break;
  }

  if(self getcurrentweapon() == var_0) {
    scripts\mp\utility\game::_takeweapon(var_0);
    scripts\mp\utility\game::_giveweapon(var_0);
    scripts\mp\utility\game::_switchtoweapon(var_0);
  }
}

playsound25mm() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("ac130player_removed");
  self endon("reset_25mm");
  var_0 = self getcurrentweapon();

  for(;;) {
    self waittill("weapon_fired");
    self stopolcalsound("ac130iw6_25mm_fire_loop_cooldown");
    self playLoopSound("ac130iw6_25mm_fire_loop");

    while(self attackButtonPressed() && self getweaponammoclip(var_0)) {
      wait 0.05;
    }

    self stoploopsound();
    self playlocalsound("ac130iw6_25mm_fire_loop_cooldown");
  }
}

ac130_control_bot_aiming() {
  self endon("ac130player_removed");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  var_7 = 0;

  for(;;) {
    var_8 = 0;
    var_9 = 0;

    if(isDefined(var_1) && var_1.health <= 0 && gettime() - var_1.deathtime < 2000) {
      var_8 = 1;
      var_9 = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var_8 = 1;
      var_1 = self.enemy;
      var_10 = var_1.origin;
      var_0 = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var_7 = 0;
        var_9 = 1;
        var_11 = gettime();
      } else {
        var_7 = var_7 + 0.05;

        if(var_7 > 5.0) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      if(isDefined(var_0)) {
        var_2 = var_0;
      }

      if(var_9 && (scripts\mp\bots\bots_killstreaks_remote_vehicle::bot_body_is_dead() || distancesquared(var_2, level.ac130.origin) > level.physicssphereradius["ac130_105mm_mp"] * level.physicssphereradius["ac130_105mm_mp"])) {
        self botpressbutton("attack");
      }

      if(gettime() > var_4 + 500) {
        var_12 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_13 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_14 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_5 = (150 * var_12, 150 * var_13, 150 * var_14);
        var_4 = gettime();
      }

      var_2 = var_2 + var_5;
    } else if(gettime() > var_3) {
      var_3 = gettime() + randomintrange(1000, 2000);
      var_2 = scripts\mp\bots\bots_killstreaks_remote_vehicle::get_random_outside_target();
    }

    self botlookatpoint(var_2, 0.2, "script_forced");
    wait 0.05;
  }
}

thermalvision() {
  self endon("ac130player_removed");
  self thermalvisionon();
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 1);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self visionsetthermalforplayer(level.ac130.thermal_vision, 0.62);
  self.lastvisionsetthermal = level.ac130.thermal_vision;
  self setclientdvar("ui_ac130_thermal", 1);
}

clouds() {
  self endon("ac130player_removed");
  wait 6;
  clouds_create();

  for(;;) {
    wait(randomfloatrange(40, 80));
    clouds_create();
  }
}

clouds_create() {
  if(isDefined(level.playerweapon) && issubstr(tolower(level.playerweapon), "25")) {
    return;
  }
  playfxontagforclients(level._effect["cloud"], level.ac130, "tag_player", level.ac130player);
}

gun_fired_and_ready_105mm() {
  self endon("ac130player_removed");
  level notify("gun_fired_and_ready_105mm");
  level endon("gun_fired_and_ready_105mm");
  wait 0.5;

  if(randomint(2) == 0) {
    thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_fired");
  }

  wait 5.0;
  thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_ready");
}

shotfired() {
  self endon("ac130player_removed");

  for(;;) {
    self waittill("projectile_impact", var_0, var_1, var_2);

    if(issubstr(tolower(var_0), "105")) {
      earthquake(0.4, 1.0, var_1, 3500);
      self setclientomnvar("ui_ac130_darken", 1);
    } else if(issubstr(tolower(var_0), "40")) {
      earthquake(0.2, 0.5, var_1, 2000);
    }

    if(scripts\mp\utility\game::getintproperty("ac130_ragdoll_deaths", 0)) {
      thread shotfiredphysicssphere(var_1, var_0);
    }

    wait 0.05;
  }
}

shotfiredphysicssphere(var_0, var_1) {
  wait 0.1;
  physicsexplosionsphere(var_0, level.physicssphereradius[var_1], level.physicssphereradius[var_1] / 2, level.physicssphereforce[var_1]);
}

add_beacon_effect() {
  self endon("death");
  var_0 = 0.75;
  wait(randomfloat(3.0));

  for(;;) {
    if(level.ac130player) {
      playfxontagforclients(level._effect["beacon"], self, "j_spine4", level.ac130player);
    }

    wait(var_0);
  }
}

context_sensative_dialog() {
  thread enemy_killed_thread();
  thread context_sensative_dialog_guy_in_sight();
  thread context_sensative_dialog_guy_crawling();
  thread context_sensative_dialog_guy_pain();
  thread context_sensative_dialog_secondary_explosion_vehicle();
  thread context_sensative_dialog_kill_thread();
  thread context_sensative_dialog_locations();
  thread context_sensative_dialog_filler();
}

context_sensative_dialog_guy_in_sight() {
  self endon("ac130player_removed");

  for(;;) {
    if(context_sensative_dialog_guy_in_sight_check()) {
      thread context_sensative_dialog_play_random_group_sound("ai", "in_sight");
    }

    wait(randomfloatrange(1, 3));
  }
}

context_sensative_dialog_guy_in_sight_check() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_2)) {
      continue;
    }
    if(var_2.team == level.ac130player.team) {
      continue;
    }
    if(var_2.team == "spectator") {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(var_0[var_4])) {
      continue;
    }
    if(!isalive(var_0[var_4])) {
      continue;
    }
    if(scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var_0[var_4].origin, level.cosine["5"])) {
      return 1;
    }

    wait 0.05;
  }

  return 0;
}

context_sensative_dialog_guy_crawling() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_crawling", var_0);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_crawl");
  }
}

context_sensative_dialog_guy_pain() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_pain", var_0);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_pain");
  }
}

context_sensative_dialog_secondary_explosion_vehicle() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("player_destroyed_car", var_0, var_1);
    wait 1;
    thread context_sensative_dialog_play_random_group_sound("explosion", "secondary");
  }
}

enemy_killed_thread() {
  self endon("ac130player_removed");

  for(;;) {
    level waittill("ai_killed", var_0);
    thread context_sensative_dialog_kill(var_0, level.ac130player);
  }
}

context_sensative_dialog_kill(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  level.enemieskilledintimewindow++;
  level notify("enemy_killed");
}

context_sensative_dialog_kill_thread() {
  self endon("ac130player_removed");
  var_0 = 1;

  for(;;) {
    level waittill("enemy_killed");
    wait(var_0);
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

context_sensative_dialog_locations() {
  scripts\engine\utility::array_thread(getEntArray("context_dialog_car", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "car");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_truck", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "truck");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_building", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "building");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_wall", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "wall");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_field", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "field");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_road", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "road");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_church", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "church");
  scripts\engine\utility::array_thread(getEntArray("context_dialog_ditch", "targetname"), ::context_sensative_dialog_locations_add_notify_event, "ditch");
  thread context_sensative_dialog_locations_thread();
}

context_sensative_dialog_locations_thread() {
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
    wait(5 + randomfloat(10));
  }
}

context_sensative_dialog_locations_add_notify_event(var_0) {
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

context_sensative_dialog_vehiclespawn(var_0) {
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

context_sensative_dialog_vehicledeath(var_0) {
  var_0 waittill("death");
  thread context_sensative_dialog_play_random_group_sound("vehicle", "death");
}

context_sensative_dialog_filler() {
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

context_sensative_dialog_play_random_group_sound(var_0, var_1, var_2) {
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

context_sensative_dialog_timedout(var_0, var_1, var_2) {
  if(!isDefined(level.context_sensative_dialog_timeouts)) {
    return 0;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0])) {
    return 0;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[var_0][var_1])) {
    return 0;
  }

  if(isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].groups) && isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].groups[string(var_2)])) {
    var_3 = gettime();

    if(var_3 - level.context_sensative_dialog_timeouts[var_0][var_1].groups[string(var_2)].v["lastPlayed"] < level.context_sensative_dialog_timeouts[var_0][var_1].groups[string(var_2)].v["timeoutDuration"]) {
      return 1;
    }

    level.context_sensative_dialog_timeouts[var_0][var_1].groups[string(var_2)].v["lastPlayed"] = var_3;
  } else if(isDefined(level.context_sensative_dialog_timeouts[var_0][var_1].v)) {
    var_3 = gettime();

    if(var_3 - level.context_sensative_dialog_timeouts[var_0][var_1].v["lastPlayed"] < level.context_sensative_dialog_timeouts[var_0][var_1].v["timeoutDuration"]) {
      return 1;
    }

    level.context_sensative_dialog_timeouts[var_0][var_1].v["lastPlayed"] = var_3;
  }

  return 0;
}

playsoundoverradio(var_0, var_1, var_2) {
  if(!isDefined(level.radio_in_use)) {
    level.radio_in_use = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_2 = var_2 * 1000;
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

  level.radioforcedtransmissionqueue = scripts\mp\utility\game::array_remove_index(level.radioforcedtransmissionqueue, 0);
}

playaliasoverradio(var_0) {
  if(level.radio_in_use) {
    return 0;
  }

  if(!isDefined(level.ac130player)) {
    return 0;
  }

  level.radio_in_use = 1;

  if(self.team == "allies" || self.team == "axis") {
    var_0 = scripts\mp\teams::getteamvoiceprefix(self.team) + var_0;
    level.ac130player playlocalsound(var_0);
  }

  wait 4.0;
  level.radio_in_use = 0;
  level.lastradiotransmission = gettime();
  level notify("radio_not_in_use");
  return 1;
}

debug_circle(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = cos(var_10) * var_1;
    var_12 = sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  if(isDefined(var_4)) {
    wait(var_4);
  }

  thread debug_circle_drawlines(var_8, var_2, var_3, var_5, var_0);
}

debug_circle_drawlines(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_3 = 0;
  }

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_5 + 1 >= var_0.size) {
      var_7 = var_0[0];
    } else {
      var_7 = var_0[var_5 + 1];
    }

    thread debug_line(var_6, var_7, var_1, var_2);

    if(var_3) {
      thread debug_line(var_4, var_6, var_1, var_2);
    }
  }
}

debug_line(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (1, 1, 1);
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    wait 0.05;
  }
}

handleincomingmissiles() {
  level endon("game_ended");
  level.ac130.planemodel thread flares_monitor(1);
}

flares_monitor(var_0) {
  self.flaresreservecount = var_0;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
  thread ks_airsuperiority_handleincoming();
}

playflarefx(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    thread angel_flare();
    wait(randomfloatrange(0.1, 0.25));
  }
}

deployflares(var_0) {
  self playSound("ac130iw6_flare_burst");

  if(!isDefined(var_0)) {
    var_1 = spawn("script_origin", level.ac130.planemodel.origin);
    var_1.angles = level.ac130.planemodel.angles;
    var_1 movegravity((0, 0, 0), 5.0);
    thread playflarefx(10);
    self.flareslive[self.flareslive.size] = var_1;
    var_1 thread deleteaftertime(5.0);
    return var_1;
  } else {
    thread playflarefx(5);
  }
}

flares_getnumleft(var_0) {
  return var_0.flaresreservecount;
}

flares_areavailable(var_0) {
  flares_cleanflareslivearray(var_0);
  return var_0.flaresreservecount > 0 || var_0.flareslive.size > 0;
}

flares_getflarereserve(var_0) {
  var_0.flaresreservecount--;
  var_1 = var_0 deployflares();
  return var_1;
}

flares_cleanflareslivearray(var_0) {
  var_0.flareslive = scripts\engine\utility::array_removeundefined(var_0.flareslive);
}

flares_getflarelive(var_0) {
  flares_cleanflareslivearray(var_0);
  var_1 = undefined;

  if(var_0.flareslive.size > 0) {
    var_1 = var_0.flareslive[var_0.flareslive.size - 1];
  }

  return var_1;
}

ks_laserguidedmissile_handleincoming() {
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
    level.ac130player playlocalsound("missile_incoming");
    level.ac130player thread ks_watch_death_stop_sound(self, "missile_incoming");

    foreach(var_4 in var_1) {
      if(isvalidmissile(var_4)) {
        level thread ks_laserguidedmissile_monitorproximity(var_4, var_0, var_0.team, var_2);
      }
    }
  }
}

ks_laserguidedmissile_monitorproximity(var_0, var_1, var_2, var_3) {
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

      var_0 missile_settargetent(var_5);
      var_0 notify("missile_pairedWithFlare");
      level.ac130player stopolcalsound("missile_incoming");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

ks_airsuperiority_handleincoming() {
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
    level.ac130player playlocalsound("missile_incoming");
    level.ac130player thread ks_watch_death_stop_sound(self, "missile_incoming");

    foreach(var_2 in var_0) {
      if(isvalidmissile(var_2)) {
        thread ks_airsuperiority_monitorproximity(var_2);
      }
    }
  }
}

ks_airsuperiority_monitorproximity(var_0) {
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
        var_0 missile_settargetent(var_2);
        var_0 notify("missile_pairedWithFlare");
        level.ac130player stopolcalsound("missile_incoming");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

ks_watch_death_stop_sound(var_0, var_1) {
  self endon("disconnect");
  var_0 waittill("death");
  self stopolcalsound(var_1);
}

deleteaftertime(var_0) {
  wait(var_0);
  self delete();
}

crashplane(var_0) {
  level.ac130.planemodel notify("crashing");
  level.ac130.planemodel.crashed = 1;
  playFXOnTag(level._effect["ac130_explode"], level.ac130.planemodel, "tag_deathfx");
  wait 0.25;
  level.ac130.planemodel hide();
}

angelflareprecache() {
  level._effect["angel_flare_geotrail"] = loadfx("fx\smoke\angel_flare_geotrail");
  level._effect["angel_flare_swirl"] = loadfx("fx\smoke\angel_flare_swirl_runner");
}

angel_flare() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("angel_flare_rig");
  var_0.origin = self gettagorigin("tag_flash_flares");
  var_0.angles = self gettagangles("tag_flash_flares");
  var_0.angles = (var_0.angles[0], var_0.angles[1] + 180, var_0.angles[2] + -90);
  var_1 = level._effect["angel_flare_geotrail"];
  var_0 scriptmodelplayanim("ac130_angel_flares0" + (randomint(3) + 1));
  wait 0.1;
  playFXOnTag(var_1, var_0, "flare_left_top");
  playFXOnTag(var_1, var_0, "flare_right_top");
  wait 0.05;
  playFXOnTag(var_1, var_0, "flare_left_bot");
  playFXOnTag(var_1, var_0, "flare_right_bot");
  wait 3.0;
  stopFXOnTag(var_1, var_0, "flare_left_top");
  stopFXOnTag(var_1, var_0, "flare_right_top");
  stopFXOnTag(var_1, var_0, "flare_left_bot");
  stopFXOnTag(var_1, var_0, "flare_right_bot");
  var_0 delete();
}
/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\ac130.gsc
********************************************/

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
  level.physicssphereforce["ac130_40mm_mp"] = 3;
  level.physicssphereforce["ac130_105mm_mp"] = 6;
  level.weaponreloadtime["ac130_25mm_mp"] = 1.5;
  level.weaponreloadtime["ac130_40mm_mp"] = 3;
  level.weaponreloadtime["ac130_105mm_mp"] = 5;
  level.ac130_speed["move"] = 250;
  level.ac130_speed["rotate"] = 70;
  scripts\engine\utility::flag_init("allow_context_sensative_dialog");
  scripts\engine\utility::flag_set("allow_context_sensative_dialog");
  var_00 = getEntArray("minimap_corner", "targetname");
  var_01 = (0, 0, 0);
  if(var_00.size) {
    var_01 = scripts\mp\spawnlogic::findboxcenter(var_00[0].origin, var_00[1].origin);
  }

  level.ac130 = spawn("script_model", var_01);
  level.ac130 setModel("c130_zoomRig");
  level.ac130.angles = (0, 115, 0);
  level.ac130.triggerportableradarping = undefined;
  level.ac130.thermal_vision = "ac130_thermal_mp";
  level.ac130.enhanced_vision = "ac130_enhanced_mp";
  level.ac130.var_336 = "ac130rig_script_model";
  level.ac130 hide();
  level.ac130inuse = 0;
  thread rotateplane("on");
  thread ac130_spawn();
  thread onplayerconnect();
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("ac130", ::tryuseac130);
  level.ac130queue = [];
}

tryuseac130(param_00, param_01) {
  if(isDefined(level.ac130player) || level.ac130inuse) {
    self iprintlnbold( & "KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility::isusingremote()) {
    return 0;
  }

  if(scripts\mp\utility::iskillstreakdenied()) {
    return 0;
  }

  scripts\mp\utility::setusingremote("ac130");
  var_02 = scripts\mp\killstreaks\_killstreaks::initridekillstreak(param_01);
  if(var_02 != "success") {
    if(var_02 != "disconnect") {
      scripts\mp\utility::clearusingremote();
    }

    return 0;
  }

  var_02 = setac130player(self);
  if(isDefined(var_02) && var_02) {
    level.ac130.planemodel.crashed = undefined;
    level.ac130inuse = 1;
  } else {
    scripts\mp\utility::clearusingremote();
  }

  return isDefined(var_02) && var_02;
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

add_context_sensative_dialog(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\teams::getteamvoiceprefix("allies") + param_03;
  var_04 = scripts\mp\teams::getteamvoiceprefix("axis") + param_03;
  if(!isDefined(level.scr_sound[param_00]) || !isDefined(level.scr_sound[param_00][param_01]) || !isDefined(level.scr_sound[param_00][param_01][param_02])) {
    level.scr_sound[param_00][param_01][param_02] = spawnStruct();
    level.scr_sound[param_00][param_01][param_02].played = 0;
    level.scr_sound[param_00][param_01][param_02].sounds = [];
  }

  var_05 = level.scr_sound[param_00][param_01][param_02].sounds.size;
  level.scr_sound[param_00][param_01][param_02].sounds[var_05] = param_03;
}

add_context_sensative_timeout(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.context_sensative_dialog_timeouts)) {
    level.context_sensative_dialog_timeouts = [];
  }

  var_04 = 0;
  if(!isDefined(level.context_sensative_dialog_timeouts[param_00])) {
    var_04 = 1;
  } else if(!isDefined(level.context_sensative_dialog_timeouts[param_00][param_01])) {
    var_04 = 1;
  }

  if(var_04) {
    level.context_sensative_dialog_timeouts[param_00][param_01] = spawnStruct();
  }

  if(isDefined(param_02)) {
    level.context_sensative_dialog_timeouts[param_00][param_01].groups = [];
    level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)] = spawnStruct();
    level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["timeoutDuration"] = param_03 * 1000;
    level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["lastPlayed"] = param_03 * -1000;
    return;
  }

  level.context_sensative_dialog_timeouts[param_00][param_01].v["timeoutDuration"] = param_03 * 1000;
  level.context_sensative_dialog_timeouts[param_00][param_01].v["lastPlayed"] = param_03 * -1000;
}

play_sound_on_entity(param_00) {
  scripts\mp\utility::play_sound_on_tag(param_00);
}

array_remove_nokeys(param_00, param_01) {
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    if(param_00[var_03] != param_01) {
      var_02[var_02.size] = param_00[var_03];
    }
  }

  return var_02;
}

string(param_00) {
  return "" + param_00;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");
}

deleteonac130playerremoved() {
  level waittill("ac130player_removed");
  self delete();
}

monitormanualplayerexit() {
  level endon("game_ended");
  level endon("ac130player_removed");
  self endon("disconnect");
  level.ac130 thread scripts\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
  level.ac130 waittill("killstreakExit");
  if(isDefined(level.ac130.triggerportableradarping)) {
    level thread removeac130player(level.ac130.triggerportableradarping, 0);
  }
}

setac130player(param_00) {
  self endon("ac130player_removed");
  if(isDefined(level.ac130player)) {
    return 0;
  }

  init_sounds();
  level.ac130player = param_00;
  level.ac130.triggerportableradarping = param_00;
  level.ac130.planemodel show();
  level.ac130.planemodel thread playac130effects();
  level.ac130.incomingmissile = 0;
  level.ac130.planemodel playLoopSound("veh_ac130iw6_ext_dist");
  level.ac130.planemodel thread damagetracker();
  thread handleincomingmissiles();
  level.ac130.planemodel thermaldrawenable();
  var_01 = spawnplane(param_00, "script_model", level.ac130.planemodel.origin, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy");
  var_01 notsolid();
  var_01 linkto(level.ac130, "tag_player", (0, 80, 32), (0, -90, 0));
  var_01 thread deleteonac130playerremoved();
  thread scripts\mp\utility::teamplayercardsplash("used_ac130", param_00);
  param_00 thread waitsetthermal(1);
  param_00 thread scripts\mp\utility::reinitializethermal(level.ac130.planemodel);
  if(getdvarint("camera_thirdPerson")) {
    param_00 scripts\mp\utility::setthirdpersondof(0);
  }

  param_00 scripts\mp\utility::_giveweapon("ac130_105mm_mp");
  param_00 scripts\mp\utility::_giveweapon("ac130_40mm_mp");
  param_00 scripts\mp\utility::_giveweapon("ac130_25mm_mp");
  param_00 scripts\mp\utility::_switchtoweapon("ac130_105mm_mp");
  param_00 thread removeac130playeraftertime(level.ac130_use_duration * param_00.killstreakscaler);
  param_00 setclientomnvar("ui_ac130_hud", 1);
  param_00 thread overlay_coords();
  param_00 setblurforplayer(1.2, 0);
  param_00 thread attachplayer(param_00);
  param_00 thread changeweapons();
  param_00 thread weaponfiredthread();
  param_00 thread context_sensative_dialog();
  param_00 thread shotfired();
  param_00 thread clouds();
  if(isbot(self)) {
    self.vehicle_controlling = level.ac130;
    param_00 thread ac130_control_bot_aiming();
  }

  param_00 thread watchhostmigrationfinishedinit();
  param_00 thread removeac130playerondisconnect();
  param_00 thread removeac130playeronchangeteams();
  param_00 thread removeac130playeronspectate();
  param_00 thread removeac130playeroncrash();
  param_00 thread removeac130playerongamecleanup();
  param_00 thread monitormanualplayerexit();
  thread ac130_altscene();
  return 1;
}

initac130hud() {
  self setclientomnvar("ui_ac130_hud", 1);
  scripts\engine\utility::waitframe();
  scripts\mp\utility::_switchtoweapon("ac130_105mm_mp");
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

waitsetthermal(param_00) {
  self endon("disconnect");
  level endon("ac130player_removed");
  wait(param_00);
  self visionsetthermalforplayer(game["thermal_vision"], 0);
  self thermalvisionfofoverlayon();
  thread thermalvision();
}

playac130effects() {
  wait(0.05);
  playFXOnTag(level._effect["ac130_light_red_blink"], self, "tag_light_belly");
  playFXOnTag(level._effect["ac130_engineeffect"], self, "tag_body");
  wait(0.5);
  playFXOnTag(level._effect["ac130_light_white_blink"], self, "tag_light_tail");
  playFXOnTag(level._effect["ac130_light_red"], self, "tag_light_top");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_light_L_wing");
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_light_R_wing");
}

ac130_altscene() {
  foreach(var_01 in level.players) {
    if(var_01 != level.ac130player && var_01.team == level.ac130player.team) {
      var_01 thread scripts\mp\utility::setaltsceneobj(level.ac130.cameramodel, "tag_origin", 20);
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
  scripts\engine\utility::waittill_any_3("joined_spectators", "spawned");
  level thread removeac130player(self, 0);
}

removeac130playeraftertime(param_00) {
  self endon("ac130player_removed");
  var_01 = param_00;
  self setclientomnvar("ui_ac130_use_time", var_01 * 1000 + gettime());
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);
  self setclientomnvar("ui_ac130_use_time", 0);
  level thread removeac130player(self, 0);
}

removeac130player(param_00, param_01) {
  param_00 notify("ac130player_removed");
  level notify("ac130player_removed");
  level.ac130.cameramodel notify("death");
  waittillframeend;
  if(!param_01) {
    param_00 scripts\mp\utility::clearusingremote();
    param_00 stoplocalsound("missile_incoming");
    param_00 stoploopsound();
    param_00 show();
    param_00 unlink();
    if(isbot(param_00)) {
      param_00 controlsunlink();
      param_00 cameraunlink();
      param_00.vehicle_controlling = undefined;
    }

    param_00 thermalvisionoff();
    param_00 thermalvisionfofoverlayoff();
    param_00 visionsetthermalforplayer(level.ac130.thermal_vision, 0);
    param_00.lastvisionsetthermal = level.ac130.thermal_vision;
    param_00 setblurforplayer(0, 0);
    if(getdvarint("camera_thirdPerson")) {
      param_00 scripts\mp\utility::setthirdpersondof(1);
    }

    var_02 = scripts\mp\utility::getkillstreakweapon("ac130");
    param_00 scripts\mp\utility::_takeweapon(var_02);
    param_00 scripts\mp\utility::_takeweapon("ac130_105mm_mp");
    param_00 scripts\mp\utility::_takeweapon("ac130_40mm_mp");
    param_00 scripts\mp\utility::_takeweapon("ac130_25mm_mp");
    param_00 setclientomnvar("ui_ac130_hud", 0);
  }

  removefromlittlebirdlist();
  wait(0.5);
  level.ac130.planemodel playSound("veh_ac130iw6_ext_dist_fade");
  wait(0.5);
  level.ac130player = undefined;
  level.ac130.planemodel hide();
  level.ac130.planemodel stoploopsound();
  if(isDefined(level.ac130.planemodel.crashed)) {
    level.ac130inuse = 0;
    return;
  }

  var_03 = spawn("script_model", level.ac130.planemodel gettagorigin("tag_origin"));
  var_03.angles = level.ac130.planemodel.angles;
  var_03 setModel("vehicle_y_8_gunship_mp");
  var_04 = var_03.origin + anglestoright(var_03.angles) * 20000;
  var_04 = var_04 + (0, 0, 10000);
  var_03 thread playac130effects();
  var_03 moveto(var_04, 40, 0, 0);
  var_05 = (0, var_03.angles[1], -20);
  var_03 rotateto(var_05, 30, 1, 1);
  var_03 thread deployflares(1);
  wait(5);
  var_03 thread deployflares(1);
  wait(5);
  var_03 thread deployflares(1);
  level.ac130inuse = 0;
  wait(30);
  var_03 delete();
}

removefromlittlebirdlist() {
  var_00 = level.ac130.planemodel getentitynumber();
  level.littlebirds[var_00] = undefined;
}

damagetracker() {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("ac130player_removed");
  self.health = 999999;
  self.maxhealth = 1000;
  self.var_E1 = 0;
  self.team = level.ac130player.team;
  scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  self.attractor = missile_createattractorent(self, 1000, 4096);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(isDefined(level.ac130player) && level.teambased && isplayer(var_01) && var_01.team == level.ac130player.team && !isDefined(level.nukedetonated)) {
      continue;
    }

    if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    self.wasdamaged = 1;
    var_0A = var_00;
    if(isplayer(var_01)) {
      var_01 scripts\mp\damagefeedback::updatedamagefeedback("ac130");
    }

    scripts\mp\killstreaks\_killstreaks::killstreakhit(var_01, var_09, level.ac130);
    if(isDefined(var_01.triggerportableradarping) && isplayer(var_01.triggerportableradarping)) {
      var_01.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("ac130");
    }

    self.var_E1 = self.var_E1 + var_0A;
    if(self.var_E1 >= self.maxhealth) {
      if(isplayer(var_01)) {
        thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_ac130", var_01);
        var_01 thread scripts\mp\utility::giveunifiedpoints("kill", var_09, 400);
        var_01 notify("destroyed_killstreak");
      }

      level thread crashplane(10);
    }
  }
}

ac130_spawn() {
  wait(0.05);
  var_00 = spawn("script_model", level.ac130 gettagorigin("tag_player"));
  var_00 setModel("vehicle_y_8_gunship_mp");
  var_00.var_336 = "vehicle_y_8_gunship_mp";
  var_00 setCanDamage(1);
  var_00.maxhealth = 1000;
  var_00.health = var_00.maxhealth;
  var_00 linkto(level.ac130, "tag_player", (0, 80, 32), (-25, 0, 0));
  level.ac130.planemodel = var_00;
  level.ac130.planemodel hide();
  var_01 = spawn("script_model", level.ac130 gettagorigin("tag_player"));
  var_01 setModel("tag_origin");
  var_01 hide();
  var_01.var_336 = "ac130CameraModel";
  var_01 linkto(level.ac130, "tag_player", (0, 0, 32), (5, 0, 0));
  level.ac130.cameramodel = var_01;
}

overlay_coords() {
  self endon("ac130player_removed");
  wait(0.05);
  thread updateplanemodelcoords();
  thread updateaimingcoords();
}

updateplanemodelcoords() {
  self endon("ac130player_removed");
  for(;;) {
    self setclientomnvar("ui_ac130_coord1_posx", abs(level.ac130.planemodel.origin[0]));
    self setclientomnvar("ui_ac130_coord1_posy", abs(level.ac130.planemodel.origin[1]));
    self setclientomnvar("ui_ac130_coord1_posz", abs(level.ac130.planemodel.origin[2]));
    wait(0.5);
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
    var_00 = self getEye();
    var_01 = self getplayerangles();
    var_02 = anglesToForward(var_01);
    var_03 = var_00 + var_02 * 15000;
    var_04 = physicstrace(var_00, var_03);
    self setclientomnvar("ui_ac130_coord3_posx", abs(var_04[0]));
    self setclientomnvar("ui_ac130_coord3_posy", abs(var_04[1]));
    self setclientomnvar("ui_ac130_coord3_posz", abs(var_04[2]));
    wait(0.1);
  }
}

ac130shellshock() {
  self endon("ac130player_removed");
  level endon("post_effects_disabled");
  var_00 = 5;
  for(;;) {
    self shellshock("ac130", var_00);
    wait(var_00);
  }
}

rotateplane(param_00) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");
  if(param_00 == "on") {
    var_01 = 10;
    var_02 = level.ac130_speed["rotate"] / 360 * var_01;
    level.ac130 rotateyaw(level.ac130.angles[2] + var_01, var_02, var_02, 0);
    for(;;) {
      level.ac130 rotateyaw(360, level.ac130_speed["rotate"]);
      wait(level.ac130_speed["rotate"]);
    }

    return;
  }

  if(param_00 == "off") {
    var_03 = 10;
    var_02 = level.ac130_speed["rotate"] / 360 * var_03;
    level.ac130 rotateyaw(level.ac130.angles[2] + var_03, var_02, 0, var_02);
  }
}

attachplayer(param_00) {
  if(isbot(param_00)) {
    param_00 cameralinkto(level.ac130, "tag_player");
  }

  self playerlinkweaponviewtodelta(level.ac130.cameramodel, "tag_player", 1, 35, 35, 35, 35);
  self setplayerangles(level.ac130 gettagangles("tag_player"));
}

changeweapons() {
  self endon("ac130player_removed");
  wait(0.05);
  self enableweapons();
  self enableweaponswitch();
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_105mm_ammo", self getweaponammoclip("ac130_105mm_mp"));
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_40mm_ammo", self getweaponammoclip("ac130_40mm_mp"));
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_ac130_25mm_ammo", self getweaponammoclip("ac130_25mm_mp"));
  for(;;) {
    self waittill("weapon_change", var_00);
    thread play_sound_on_entity("ac130iw6_weapon_switch");
    self notify("reset_25mm");
    self stoploopsound("ac130iw6_25mm_fire_loop");
    switch (var_00) {
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
    var_00 = self getcurrentweapon();
    switch (var_00) {
      case "ac130_105mm_mp":
        thread gun_fired_and_ready_105mm();
        earthquake(0.2, 1, level.ac130.planemodel.origin, 1000);
        self setclientomnvar("ui_ac130_105mm_ammo", self getweaponammoclip(var_00));
        break;

      case "ac130_40mm_mp":
        earthquake(0.1, 0.5, level.ac130.planemodel.origin, 1000);
        self setclientomnvar("ui_ac130_40mm_ammo", self getweaponammoclip(var_00));
        break;

      case "ac130_25mm_mp":
        self setclientomnvar("ui_ac130_25mm_ammo", self getweaponammoclip(var_00));
        break;
    }

    if(self getweaponammoclip(var_00)) {
      continue;
    }

    thread weaponreload(var_00);
  }
}

weaponreload(param_00) {
  self endon("ac130player_removed");
  wait(level.weaponreloadtime[param_00]);
  self setweaponammoclip(param_00, 9999);
  switch (param_00) {
    case "ac130_105mm_mp":
      self setclientomnvar("ui_ac130_105mm_ammo", self getweaponammoclip(param_00));
      break;

    case "ac130_40mm_mp":
      self setclientomnvar("ui_ac130_40mm_ammo", self getweaponammoclip(param_00));
      break;

    case "ac130_25mm_mp":
      self setclientomnvar("ui_ac130_25mm_ammo", self getweaponammoclip(param_00));
      break;
  }

  if(self getcurrentweapon() == param_00) {
    scripts\mp\utility::_takeweapon(param_00);
    scripts\mp\utility::_giveweapon(param_00);
    scripts\mp\utility::_switchtoweapon(param_00);
  }
}

playsound25mm() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("ac130player_removed");
  self endon("reset_25mm");
  var_00 = self getcurrentweapon();
  for(;;) {
    self waittill("weapon_fired");
    self stoplocalsound("ac130iw6_25mm_fire_loop_cooldown");
    self playLoopSound("ac130iw6_25mm_fire_loop");
    while(self attackbuttonpressed() && self getweaponammoclip(var_00)) {
      wait(0.05);
    }

    self stoploopsound();
    self playlocalsound("ac130iw6_25mm_fire_loop_cooldown");
  }
}

ac130_control_bot_aiming() {
  self endon("ac130player_removed");
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = 0;
  var_04 = 0;
  var_05 = undefined;
  var_06 = self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy") / 2;
  var_07 = 0;
  for(;;) {
    var_08 = 0;
    var_09 = 0;
    if(isDefined(var_01) && var_01.health <= 0 && gettime() - var_01.deathtime < 2000) {
      var_08 = 1;
      var_09 = 1;
    } else if(isalive(self.isnodeoccupied) && self botcanseeentity(self.isnodeoccupied) || gettime() - self lastknowntime(self.isnodeoccupied) <= 300) {
      var_08 = 1;
      var_01 = self.isnodeoccupied;
      var_0A = var_01.origin;
      var_00 = self.isnodeoccupied.origin;
      if(self botcanseeentity(self.isnodeoccupied)) {
        var_07 = 0;
        var_09 = 1;
        var_0B = gettime();
      } else {
        var_07 = var_07 + 0.05;
        if(var_07 > 5) {
          var_08 = 0;
        }
      }
    }

    if(var_08) {
      if(isDefined(var_00)) {
        var_02 = var_00;
      }

      if(var_09 && scripts\mp\bots\_bots_killstreaks_remote_vehicle::bot_body_is_dead() || distancesquared(var_02, level.ac130.origin) > level.physicssphereradius["ac130_105mm_mp"] * level.physicssphereradius["ac130_105mm_mp"]) {
        self botpressbutton("attack");
      }

      if(gettime() > var_04 + 500) {
        var_0C = randomfloatrange(-1 * var_06 / 2, var_06 / 2);
        var_0D = randomfloatrange(-1 * var_06 / 2, var_06 / 2);
        var_0E = randomfloatrange(-1 * var_06 / 2, var_06 / 2);
        var_05 = (150 * var_0C, 150 * var_0D, 150 * var_0E);
        var_04 = gettime();
      }

      var_02 = var_02 + var_05;
    } else if(gettime() > var_03) {
      var_03 = gettime() + randomintrange(1000, 2000);
      var_02 = scripts\mp\bots\_bots_killstreaks_remote_vehicle::get_random_outside_target();
    }

    self botlookatpoint(var_02, 0.2, "script_forced");
    wait(0.05);
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
  wait(6);
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
  wait(0.5);
  if(randomint(2) == 0) {
    thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_fired");
  }

  wait(5);
  thread context_sensative_dialog_play_random_group_sound("weapons", "105mm_ready");
}

shotfired() {
  self endon("ac130player_removed");
  for(;;) {
    self waittill("projectile_impact", var_00, var_01, var_02);
    if(issubstr(tolower(var_00), "105")) {
      earthquake(0.4, 1, var_01, 3500);
      self setclientomnvar("ui_ac130_darken", 1);
    } else if(issubstr(tolower(var_00), "40")) {
      earthquake(0.2, 0.5, var_01, 2000);
    }

    if(scripts\mp\utility::getintproperty("ac130_ragdoll_deaths", 0)) {
      thread shotfiredphysicssphere(var_01, var_00);
    }

    wait(0.05);
  }
}

shotfiredphysicssphere(param_00, param_01) {
  wait(0.1);
  physicsexplosionsphere(param_00, level.physicssphereradius[param_01], level.physicssphereradius[param_01] / 2, level.physicssphereforce[param_01]);
}

add_beacon_effect() {
  self endon("death");
  var_00 = 0.75;
  wait(randomfloat(3));
  for(;;) {
    if(level.ac130player) {
      playfxontagforclients(level._effect["beacon"], self, "j_spine4", level.ac130player);
    }

    wait(var_00);
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
  var_00 = [];
  foreach(var_02 in level.players) {
    if(!scripts\mp\utility::isreallyalive(var_02)) {
      continue;
    }

    if(var_02.team == level.ac130player.team) {
      continue;
    }

    if(var_02.team == "spectator") {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  for(var_04 = 0; var_04 < var_00.size; var_04++) {
    if(!isDefined(var_00[var_04])) {
      continue;
    }

    if(!isalive(var_00[var_04])) {
      continue;
    }

    if(scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), var_00[var_04].origin, level.cosine["5"])) {
      return 1;
    }

    wait(0.05);
  }

  return 0;
}

context_sensative_dialog_guy_crawling() {
  self endon("ac130player_removed");
  for(;;) {
    level waittill("ai_crawling", var_00);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_crawl");
  }
}

context_sensative_dialog_guy_pain() {
  self endon("ac130player_removed");
  for(;;) {
    level waittill("ai_pain", var_00);
    thread context_sensative_dialog_play_random_group_sound("ai", "wounded_pain");
  }
}

context_sensative_dialog_secondary_explosion_vehicle() {
  self endon("ac130player_removed");
  for(;;) {
    level waittill("player_destroyed_car", var_00, var_01);
    wait(1);
    thread context_sensative_dialog_play_random_group_sound("explosion", "secondary");
  }
}

enemy_killed_thread() {
  self endon("ac130player_removed");
  for(;;) {
    level waittill("ai_killed", var_00);
    thread context_sensative_dialog_kill(var_00, level.ac130player);
  }
}

context_sensative_dialog_kill(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  if(!isplayer(param_01)) {
    return;
  }

  level.enemieskilledintimewindow++;
  level notify("enemy_killed");
}

context_sensative_dialog_kill_thread() {
  self endon("ac130player_removed");
  var_00 = 1;
  for(;;) {
    level waittill("enemy_killed");
    wait(var_00);
    var_01 = "kill";
    var_02 = undefined;
    if(level.enemieskilledintimewindow >= 2) {
      var_02 = "small_group";
    } else {
      var_02 = "single";
      if(randomint(3) != 1) {
        level.enemieskilledintimewindow = 0;
        continue;
      }
    }

    level.enemieskilledintimewindow = 0;
    thread context_sensative_dialog_play_random_group_sound(var_01, var_02, 1);
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
    level waittill("context_location", var_00);
    if(!isDefined(var_00)) {
      continue;
    }

    if(!scripts\engine\utility::flag("allow_context_sensative_dialog")) {
      continue;
    }

    thread context_sensative_dialog_play_random_group_sound("location", var_00);
    wait(5 + randomfloat(10));
  }
}

context_sensative_dialog_locations_add_notify_event(param_00) {
  self endon("ac130player_removed");
  for(;;) {
    self waittill("trigger", var_01);
    if(!isDefined(var_01)) {
      continue;
    }

    if(!isDefined(var_01.team) || var_01.team != "axis") {
      continue;
    }

    level notify("context_location", param_00);
    wait(5);
  }
}

context_sensative_dialog_vehiclespawn(param_00) {
  if(param_00.script_team != "axis") {
    return;
  }

  thread context_sensative_dialog_vehicledeath(param_00);
  param_00 endon("death");
  while(!scripts\engine\utility::within_fov(level.ac130player getEye(), level.ac130player getplayerangles(), param_00.origin, level.cosine["45"])) {
    wait(0.5);
  }

  context_sensative_dialog_play_random_group_sound("vehicle", "incoming");
}

context_sensative_dialog_vehicledeath(param_00) {
  param_00 waittill("death");
  thread context_sensative_dialog_play_random_group_sound("vehicle", "death");
}

context_sensative_dialog_filler() {
  self endon("ac130player_removed");
  for(;;) {
    if(isDefined(level.radio_in_use) && level.radio_in_use == 1) {
      level waittill("radio_not_in_use");
    }

    var_00 = gettime();
    if(var_00 - level.lastradiotransmission >= 3000) {
      level.lastradiotransmission = var_00;
      thread context_sensative_dialog_play_random_group_sound("misc", "action");
    }

    wait(0.25);
  }
}

context_sensative_dialog_play_random_group_sound(param_00, param_01, param_02) {
  level endon("ac130player_removed");
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!scripts\engine\utility::flag("allow_context_sensative_dialog")) {
    if(param_02) {
      scripts\engine\utility::flag_wait("allow_context_sensative_dialog");
    } else {
      return;
    }
  }

  var_03 = undefined;
  var_04 = randomint(level.scr_sound[param_00][param_01].size);
  if(level.scr_sound[param_00][param_01][var_04].played == 1) {
    for(var_05 = 0; var_05 < level.scr_sound[param_00][param_01].size; var_05++) {
      var_04++;
      if(var_04 >= level.scr_sound[param_00][param_01].size) {
        var_04 = 0;
      }

      if(level.scr_sound[param_00][param_01][var_04].played == 1) {
        continue;
      }

      var_03 = var_04;
      break;
    }

    if(!isDefined(var_03)) {
      for(var_05 = 0; var_05 < level.scr_sound[param_00][param_01].size; var_05++) {
        level.scr_sound[param_00][param_01][var_05].played = 0;
      }

      var_03 = randomint(level.scr_sound[param_00][param_01].size);
    }
  } else {
    var_03 = var_04;
  }

  if(context_sensative_dialog_timedout(param_00, param_01, var_03)) {
    return;
  }

  level.scr_sound[param_00][param_01][var_03].played = 1;
  var_06 = randomint(level.scr_sound[param_00][param_01][var_03].size);
  playsoundoverradio(level.scr_sound[param_00][param_01][var_03].sounds[var_06], param_02);
}

context_sensative_dialog_timedout(param_00, param_01, param_02) {
  if(!isDefined(level.context_sensative_dialog_timeouts)) {
    return 0;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[param_00])) {
    return 0;
  }

  if(!isDefined(level.context_sensative_dialog_timeouts[param_00][param_01])) {
    return 0;
  }

  if(isDefined(level.context_sensative_dialog_timeouts[param_00][param_01].groups) && isDefined(level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)])) {
    var_03 = gettime();
    if(var_03 - level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["lastPlayed"] < level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["timeoutDuration"]) {
      return 1;
    }

    level.context_sensative_dialog_timeouts[param_00][param_01].groups[string(param_02)].v["lastPlayed"] = var_03;
  } else if(isDefined(level.context_sensative_dialog_timeouts[param_00][param_01].v)) {
    var_03 = gettime();
    if(var_03 - level.context_sensative_dialog_timeouts[param_00][param_01].v["lastPlayed"] < level.context_sensative_dialog_timeouts[param_00][param_01].v["timeoutDuration"]) {
      return 1;
    }

    level.context_sensative_dialog_timeouts[param_00][param_01].v["lastPlayed"] = var_03;
  }

  return 0;
}

playsoundoverradio(param_00, param_01, param_02) {
  if(!isDefined(level.radio_in_use)) {
    level.radio_in_use = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  param_02 = param_02 * 1000;
  var_03 = gettime();
  var_04 = 0;
  var_04 = playaliasoverradio(param_00);
  if(var_04) {
    return;
  }

  if(!param_01) {
    return;
  }

  level.radioforcedtransmissionqueue[level.radioforcedtransmissionqueue.size] = param_00;
  while(!var_04) {
    if(level.radio_in_use) {
      level waittill("radio_not_in_use");
    }

    if(param_02 > 0 && gettime() - var_03 > param_02) {
      break;
    }

    if(!isDefined(level.ac130player)) {
      break;
    }

    var_04 = playaliasoverradio(level.radioforcedtransmissionqueue[0]);
    if(!level.radio_in_use && isDefined(level.ac130player) && !var_04) {}
  }

  level.radioforcedtransmissionqueue = scripts\mp\utility::array_remove_index(level.radioforcedtransmissionqueue, 0);
}

playaliasoverradio(param_00) {
  if(level.radio_in_use) {
    return 0;
  }

  if(!isDefined(level.ac130player)) {
    return 0;
  }

  level.radio_in_use = 1;
  if(self.team == "allies" || self.team == "axis") {
    param_00 = scripts\mp\teams::getteamvoiceprefix(self.team) + param_00;
    level.ac130player playlocalsound(param_00);
  }

  wait(4);
  level.radio_in_use = 0;
  level.lastradiotransmission = gettime();
  level notify("radio_not_in_use");
  return 1;
}

debug_circle(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = 16;
  var_07 = 360 / var_06;
  var_08 = [];
  for(var_09 = 0; var_09 < var_06; var_09++) {
    var_0A = var_07 * var_09;
    var_0B = cos(var_0A) * param_01;
    var_0C = sin(var_0A) * param_01;
    var_0D = param_00[0] + var_0B;
    var_0E = param_00[1] + var_0C;
    var_0F = param_00[2];
    var_08[var_08.size] = (var_0D, var_0E, var_0F);
  }

  if(isDefined(param_04)) {
    wait(param_04);
  }

  thread debug_circle_drawlines(var_08, param_02, param_03, param_05, param_00);
}

debug_circle_drawlines(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_04)) {
    param_03 = 0;
  }

  for(var_05 = 0; var_05 < param_00.size; var_05++) {
    var_06 = param_00[var_05];
    if(var_05 + 1 >= param_00.size) {
      var_07 = param_00[0];
    } else {
      var_07 = param_00[var_05 + 1];
    }

    thread debug_line(var_06, var_07, param_01, param_02);
    if(param_03) {
      thread debug_line(param_04, var_06, param_01, param_02);
    }
  }
}

debug_line(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = (1, 1, 1);
  }

  for(var_04 = 0; var_04 < param_02 * 20; var_04++) {
    wait(0.05);
  }
}

handleincomingmissiles() {
  level endon("game_ended");
  level.ac130.planemodel thread flares_monitor(1);
}

flares_monitor(param_00) {
  self.flaresreservecount = param_00;
  self.flareslive = [];
  thread ks_laserguidedmissile_handleincoming();
  thread ks_airsuperiority_handleincoming();
}

playflarefx(param_00) {
  for(var_01 = 0; var_01 < param_00; var_01++) {
    thread angel_flare();
    wait(randomfloatrange(0.1, 0.25));
  }
}

deployflares(param_00) {
  self playSound("ac130iw6_flare_burst");
  if(!isDefined(param_00)) {
    var_01 = spawn("script_origin", level.ac130.planemodel.origin);
    var_01.angles = level.ac130.planemodel.angles;
    var_01 movegravity((0, 0, 0), 5);
    thread playflarefx(10);
    self.flareslive[self.flareslive.size] = var_01;
    var_01 thread deleteaftertime(5);
    return var_01;
  }

  thread playflarefx(5);
}

flares_getnumleft(param_00) {
  return param_00.flaresreservecount;
}

flares_areavailable(param_00) {
  flares_cleanflareslivearray(param_00);
  return param_00.flaresreservecount > 0 || param_00.flareslive.size > 0;
}

flares_getflarereserve(param_00) {
  param_00.flaresreservecount--;
  var_01 = param_00 deployflares();
  return var_01;
}

flares_cleanflareslivearray(param_00) {
  param_00.flareslive = scripts\engine\utility::array_removeundefined(param_00.flareslive);
}

flares_getflarelive(param_00) {
  flares_cleanflareslivearray(param_00);
  var_01 = undefined;
  if(param_00.flareslive.size > 0) {
    var_01 = param_00.flareslive[param_00.flareslive.size - 1];
  }

  return var_01;
}

ks_laserguidedmissile_handleincoming() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");
  while(flares_areavailable(self)) {
    level waittill("laserGuidedMissiles_incoming", var_00, var_01, var_02);
    if(!isDefined(var_02) || var_02 != self) {
      continue;
    }

    level.ac130player playlocalsound("missile_incoming");
    level.ac130player thread ks_watch_death_stop_sound(self, "missile_incoming");
    foreach(var_04 in var_01) {
      if(isvalidmissile(var_04)) {
        level thread ks_laserguidedmissile_monitorproximity(var_04, var_00, var_00.team, var_02);
      }
    }
  }
}

ks_laserguidedmissile_monitorproximity(param_00, param_01, param_02, param_03) {
  param_03 endon("death");
  param_00 endon("death");
  param_00 endon("missile_targetChanged");
  while(flares_areavailable(param_03)) {
    if(!isDefined(param_03) || !isvalidmissile(param_00)) {
      break;
    }

    var_04 = param_03 getpointinbounds(0, 0, 0);
    if(distancesquared(param_00.origin, var_04) < 4000000) {
      var_05 = flares_getflarelive(param_03);
      if(!isDefined(var_05)) {
        var_05 = flares_getflarereserve(param_03);
      }

      param_00 missile_settargetent(var_05);
      param_00 notify("missile_pairedWithFlare");
      level.ac130player stoplocalsound("missile_incoming");
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
    self waittill("targeted_by_incoming_missile", var_00);
    if(!isDefined(var_00)) {
      continue;
    }

    level.ac130player playlocalsound("missile_incoming");
    level.ac130player thread ks_watch_death_stop_sound(self, "missile_incoming");
    foreach(var_02 in var_00) {
      if(isvalidmissile(var_02)) {
        thread ks_airsuperiority_monitorproximity(var_02);
      }
    }
  }
}

ks_airsuperiority_monitorproximity(param_00) {
  self endon("death");
  param_00 endon("death");
  for(;;) {
    if(!isDefined(self) || !isvalidmissile(param_00)) {
      break;
    }

    var_01 = self getpointinbounds(0, 0, 0);
    if(distancesquared(param_00.origin, var_01) < 4000000) {
      var_02 = flares_getflarelive(self);
      if(!isDefined(var_02) && self.flaresreservecount > 0) {
        var_02 = flares_getflarereserve(self);
      }

      if(isDefined(var_02)) {
        param_00 missile_settargetent(var_02);
        param_00 notify("missile_pairedWithFlare");
        level.ac130player stoplocalsound("missile_incoming");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

ks_watch_death_stop_sound(param_00, param_01) {
  self endon("disconnect");
  param_00 waittill("death");
  self stoplocalsound(param_01);
}

deleteaftertime(param_00) {
  wait(param_00);
  self delete();
}

crashplane(param_00) {
  level.ac130.planemodel notify("crashing");
  level.ac130.planemodel.crashed = 1;
  playFXOnTag(level._effect["ac130_explode"], level.ac130.planemodel, "tag_deathfx");
  wait(0.25);
  level.ac130.planemodel hide();
}

angelflareprecache() {
  level._effect["angel_flare_geotrail"] = loadfx("fx\smoke\angel_flare_geotrail");
  level._effect["angel_flare_swirl"] = loadfx("fx\smoke\angel_flare_swirl_runner");
}

angel_flare() {
  var_00 = spawn("script_model", self.origin);
  var_00 setModel("angel_flare_rig");
  var_00.origin = self gettagorigin("tag_flash_flares");
  var_00.angles = self gettagangles("tag_flash_flares");
  var_00.angles = (var_00.angles[0], var_00.angles[1] + 180, var_00.angles[2] + -90);
  var_01 = level._effect["angel_flare_geotrail"];
  var_00 scriptmodelplayanim("ac130_angel_flares0" + randomint(3) + 1);
  wait(0.1);
  playFXOnTag(var_01, var_00, "flare_left_top");
  playFXOnTag(var_01, var_00, "flare_right_top");
  wait(0.05);
  playFXOnTag(var_01, var_00, "flare_left_bot");
  playFXOnTag(var_01, var_00, "flare_right_bot");
  wait(3);
  stopFXOnTag(var_01, var_00, "flare_left_top");
  stopFXOnTag(var_01, var_00, "flare_right_top");
  stopFXOnTag(var_01, var_00, "flare_left_bot");
  stopFXOnTag(var_01, var_00, "flare_right_bot");
  var_00 delete();
}
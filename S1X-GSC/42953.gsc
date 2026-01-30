/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42953.gsc
**************************************/

init() {
  level._effect["orbital_laser_clouds"] = loadfx("vfx/unique/vfx_odin_parallax_clouds");
  level._effect["orbital_laser_warmup"] = loadfx("vfx/beam/orbital_laser_warmup");
  level._effect["orbital_laser_warmup_water"] = loadfx("vfx/beam/orbital_laser_water_boiling");
  level._effect["orbital_laser_warmup_wide"] = loadfx("vfx/beam/orbital_laser_warmup_large");
  level._effect["orbital_laser_warmup_wide_water"] = loadfx("vfx/beam/orbital_laser_water_boiling");
  level._effect["orbital_laser_warmup_lightshow"] = loadfx("vfx/beam/orbital_laser_warmup_lightshow");
  level._effect["orbital_laser_warmup_lightshow_water"] = loadfx("vfx/beam/orbital_laser_water_boiling");
  level._effect["orbital_laser_warmup_lightshow_wide"] = loadfx("vfx/beam/orbital_laser_warmup_lightshow_large");
  level._effect["orbital_laser_warmup_lightshow_wide_water"] = loadfx("vfx/beam/orbital_laser_water_boiling");
  level._effect["orbital_laser_fire"] = loadfx("vfx/beam/orbital_laser_fire_small");
  level._effect["orbital_laser_fire_water"] = loadfx("vfx/beam/orbital_laser_water_sm");
  level._effect["orbital_laser_fire_wide"] = loadfx("vfx/beam/orbital_laser_fire_large");
  level._effect["orbital_laser_fire_wide_water"] = loadfx("vfx/beam/orbital_laser_water_sm");
  level._effect["orbital_laser_fire_lightshow"] = loadfx("vfx/beam/orbital_laser_fire_lightshow");
  level._effect["orbital_laser_fire_lightshow_water"] = loadfx("vfx/beam/orbital_laser_water_sm");
  level._effect["orbital_laser_fire_lightshow_wide"] = loadfx("vfx/beam/orbital_laser_fire_lightshow_large");
  level._effect["orbital_laser_fire_lightshow_wide_water"] = loadfx("vfx/beam/orbital_laser_water_sm");
  level._effect["orbital_laser_ending"] = loadfx("vfx/beam/orbital_laser_ending");
  level._effect["orbital_laser_ending_water"] = loadfx("vfx/beam/orbital_laser_water_aftermath");
  level._effect["orbital_laser_beam"] = loadfx("vfx/beam/orbital_laser_lightbeam");
  level._effect["orbital_laser_beam_wide"] = loadfx("vfx/beam/orbital_laser_lightbeam_lg");
  level._effect["orbital_laser_beam_lightshow"] = loadfx("vfx/beam/orbital_laser_lightbeam_lightshow");
  level._effect["orbital_laser_beam_lightshow_wide"] = loadfx("vfx/beam/orbital_laser_lightbeam_lightshow_lg");
  level._effect["orbital_laser_smoldering"] = loadfx("vfx/beam/orbital_laser_smoldering");
  level._effect["orbital_laser_death"] = loadfx("vfx/beam/orbital_laser_lightbeam_burnmark");
  level._orbital_strike_setting = [];
  level._orbital_strike_setting = spawnStruct();
  level._orbital_strike_setting.vehicle = "orbital_laser_strike_mp";
  level._orbital_strike_setting.helitype = "OrbitalStrike";
  level._orbital_strike_setting.maxhealth = 9999999;
  level.killstreakfuncs["orbital_strike_laser"] = ::tryuseorbitalstrike;
  level.killstreakwieldweapons["orbital_laser_fov_mp"] = "orbital_strike_laser";

  if(!isDefined(level.orbital_lasers)) {
    level.orbital_lasers = [];
  }

  if(level.teambased) {
    level.orbital_laser_axis = 0;
    level.orbital_laser_allies = 0;
  }

  level.orbitallaseroverrides = spawnStruct();
  level.orbitallaseroverrides.spawnheight = undefined;
  level.orbitallaseroverrides.spawnpoint = undefined;

  if(isDefined(level.orbitallaseroverridefunc)) {
    [[level.orbitallaseroverridefunc]]();
  }
}

tryuseorbitalstrike(var_0, var_1) {
  if(checkorbitallaserusage()) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed()) {
    self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
    return 0;
  }

  maps\mp\_utility::incrementfauxvehiclecount();
  var_2 = undefined;

  if(level.teambased) {
    var_2 = self.team;
    setorbitallaserforteam(var_2, 1);
  }

  var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak("orbital_strike");

  if(var_3 != "success") {
    maps\mp\_utility::decrementfauxvehiclecount();

    if(level.teambased) {
      setorbitallaserforteam(var_2, 0);
    }

    return 0;
  }

  if(isDefined(level.ishorde) && level.ishorde && self.killstreakindexweapon == 1) {
    self notify("used_horde_orbital");
  }

  maps\mp\_utility::setusingremote("orbital_strike");
  var_3 = setuporbitalstrike(var_0, var_1);
  maps\mp\_matchdata::logkillstreakevent("orbital_strike", self.origin);
  return var_3;
}

checkorbitallaserusage() {
  if(level.teambased) {
    if(self.team == "allies") {
      return level.orbital_laser_allies;
    } else {
      return level.orbital_laser_axis;
    }
  } else {
    return level.orbital_lasers.size >= 2;
  }
}

setorbitallaserforteam(var_0, var_1) {
  if(var_0 == "allies") {
    level.orbital_laser_allies = var_1;
  } else {
    level.orbital_laser_axis = var_1;
  }
}

orbitalstrikesetupdelay(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  waitframe();
  var_0 thermaldrawdisable();
}

setuporbitalstrike(var_0, var_1) {
  playeraddnotifycommands();
  var_2 = findbestspawnlocation();
  var_3 = spawnhelicopter(self, var_2.origin, (0, 0, 0), level._orbital_strike_setting.vehicle, "tag_origin");

  if(!isDefined(var_3)) {
    return 0;
  }

  thread orbitalstrikesetupdelay(var_3);
  level.orbital_lasers = common_scripts\utility::array_add(level.orbital_lasers, var_3);
  var_3.modules = var_1;
  var_3.vehicletype = "orbital_strike";
  var_3.lifeid = var_0;
  var_3.team = self.pers["team"];
  var_3.pers["team"] = self.pers["team"];
  var_3.owner = self;
  var_3.maxhealth = level._orbital_strike_setting.maxhealth;
  var_3.zoffset = (0, 0, 0);
  var_3.targeting_delay = level.heli_targeting_delay;
  var_3.primarytarget = undefined;
  var_3.secondarytarget = undefined;
  var_3.attacker = undefined;
  var_3.cloakstate = 0;
  var_3.numcharges = 1;

  if(common_scripts\utility::array_contains(var_3.modules, "orbital_strike_laser_burst1")) {
    var_3.numcharges++;
  }

  if(common_scripts\utility::array_contains(var_3.modules, "orbital_strike_laser_burst2")) {
    var_3.numcharges++;
  }

  var_3.widebeam = common_scripts\utility::array_contains(var_3.modules, "orbital_strike_laser_width");
  var_3.beams = common_scripts\utility::array_contains(var_3.modules, "orbital_strike_laser_beam");
  var_3.fireduration = 6;

  if(common_scripts\utility::array_contains(var_3.modules, "orbital_strike_laser_duration")) {
    var_3.fireduration = var_3.fireduration * 1.5;
  }

  self.controllingorbitallaser = 1;
  thread monitororbitalstriketimeout(var_3);
  thread monitororbitalstrikedeath(var_3);
  thread monitorplayerdisconnect(var_3);
  thread monitorplayerteamchange(var_3);
  thread monitorgameended(var_3);
  thread playercontrolorbitalstrike(var_3);
  thread watchallplayerdeath(var_3, self);
  thread onplayerconnect(var_3, self);
  return 1;
}

onplayerconnect(var_0, var_1) {
  var_1 endon("OrbitalStrikeStreakComplete");
  var_1 endon("disconnect");
  var_0 endon("death");
  var_0 endon("PossessHoldTimeComplete");
  var_0 endon("leaving");

  for(;;) {
    level waittill("connected", var_2);
    var_2 thread waitforlaserdeath(var_0, var_1);
  }
}

zoomslam(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 3000));
  var_1.angles = vectortoangles((0, 0, 1));
  var_1 setModel("tag_origin");
  var_1 thread waitanddelete(5);
  var_2 = common_scripts\utility::array_add(maps\mp\_utility::get_players_watching(), self);

  foreach(var_4 in var_2) {
    var_4 setclientomnvar("cam_scene_name", "odin_zoom_down");
    var_4 setclientomnvar("cam_scene_lead", var_0 getentitynumber());
    var_4 setclientomnvar("cam_scene_support", var_1 getentitynumber());
    var_4 playlocalsound("vulcan_hud_transition");
    var_4 thread clouds(var_0);
  }
}

clouds(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_model", var_0.origin + (0, 0, -1000));
  var_1.angles = vectortoangles((0, 0, 1));
  var_1 setModel("tag_origin");
  var_1 thread waitanddelete(5);
  playfxontagforclients(level._effect["orbital_laser_clouds"], var_1, "tag_origin", self);
}

waitanddelete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

turnonandhideorbitalhud() {
  self setclientomnvar("ui_orbital_laser", 1);
  self setclientomnvar("ui_orbital_laser_mode", 0);
  self setclientomnvar("ui_orbital_laser_charge", 0);
  self setclientomnvar("ui_orbital_laser_bursts", 0);
  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

showorbitalstrikehud(var_0) {
  thread activatethermal();
  self setclientomnvar("ui_orbital_laser_mode", 1);
  self setclientomnvar("ui_orbital_laser_bursts", var_0.numcharges);
  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

orbitalstrikebeginchargeup(var_0, var_1) {
  self endon("disconnect");
  self endon("OrbitalStrikeStreakComplete");
  var_2 = gettime() + var_1 * 1000;
  self setclientomnvar("ui_orbital_laser_charge", var_2);
  self setclientomnvar("ui_orbital_laser_mode", 1);
  self playrumbleonentity("orbital_laser_charge");
  playwarmupsounds(var_0, 0);
  wait 0.1;
  playwarmupeffects(var_0);
}

orbitalstrikchargeupspeedup(var_0, var_1) {
  var_2 = gettime() + var_1 * 1000;
  self setclientomnvar("ui_orbital_laser_charge", var_2);
  self stoprumble("orbital_laser_charge");
  self playrumbleonentity("orbital_laser_charge_quick");
  playwarmupsounds(var_0, 1);
}

orbitalstrikechargeupcomplete(var_0) {
  self setclientomnvar("ui_orbital_laser_charge", 0);
  self stoprumble("orbital_laser_charge");
  self stoprumble("orbital_laser_charge_quick");
  self playrumblelooponentity("orbital_laser_fire");
}

createorbitaltimer(var_0, var_1) {
  var_2 = gettime() + var_1 * 1000;
  thread orbitalstrikebeginchargeup(var_0, var_1);
  maps\mp\_utility::waitfortimeornotify(var_1, "StartFire");
  var_3 = var_2 - gettime();

  if(var_3 > 2500) {
    orbitalstrikchargeupspeedup(var_0, 1.1);
    wait 1.1;
  } else {
    stopwarmupsounds(var_0);
  }

  orbitalstrikechargeupcomplete(var_0);
}

hidefirehud(var_0) {
  self setclientomnvar("ui_orbital_laser_mode", 2);
}

sethudnumbursts(var_0) {
  self setclientomnvar("ui_orbital_laser_bursts", var_0.numcharges);
}

getorbitallaserzheight() {
  if(isDefined(level.orbitallaseroverrides.spawnheight)) {
    return level.orbitallaseroverrides.spawnheight;
  }

  var_0 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
  var_1 = var_0.origin[2] + 1024;

  if(isDefined(level.airstrikeoverrides) && isDefined(level.airstrikeoverrides.spawnheight)) {
    var_1 = var_1 + level.airstrikeoverrides.spawnheight;
  }

  return var_1;
}

findbestspawnlocation() {
  if(!isDefined(self.strikespawnpoint)) {
    self.strikespawnpoint = spawnStruct();
  }

  var_0 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
  var_1 = getorbitallaserzheight();
  var_2 = level.mapcenter;

  if(isDefined(level.orbitallaseroverrides.spawnpoint)) {
    var_2 = level.orbitallaseroverrides.spawnpoint;
  }

  self.strikespawnpoint.origin = var_2 + (0, 0, var_1);
  self.strikespawnpoint.angles = (0, self.angles[1], 0);
  return self.strikespawnpoint;
}

monitororbitalstrikesafearea(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  thread maps\mp\killstreaks\_aerial_utility::playerhandleboundarystatic(var_0, "OrbitalStrikeStreakComplete");
  var_0 waittill("outOfBounds");
  wait 2;
  var_0 notify("leaving");
}

playercontrolorbitalstrike(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  thread maps\mp\_utility::freezecontrolswrapper(1);
  thread monitororbitalstrikesafearea(var_0);
  maps\mp\_utility::playersaveangles();
  wait 0.45;
  thread setvulcanvisionandlightsetpermap(0.5);
  zoomslam(var_0);
  turnonandhideorbitalhud();
  wait 1.5;
  maps\mp\killstreaks\_aerial_utility::playershowfullstatic();
  thread maps\mp\_utility::freezecontrolswrapper(0);
  maps\mp\_utility::_giveweapon("orbital_laser_fov_mp");
  self switchtoweapon("orbital_laser_fov_mp");
  common_scripts\utility::_disableweaponswitch();
  self unlink();
  var_0 sethoverparams(0, 0, 0);
  var_0 setjitterparams((0, 0, 0), 0, 0);
  thread leaveorbitalstrikeearly(var_0);
  thread playinteriorsound(var_0);
  self setangles((0, 0, 0));
  self remotecontrolvehicle(var_0);
  wait 0.05;
  self cameralinkto(var_0, "tag_origin");
  wait 0.55;
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  var_0.killcamstarttime = gettime();
  showorbitalstrikehud(var_0);
  thread weaponsetup(var_0);
}

setplayerstance() {
  if(self getstance() == "prone") {
    self setstance("crouch");
  }
}

leaveorbitalstrikeearly(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 endon("death");
  var_1 = 5;

  for(;;) {
    self waittill("ToggleControlState");
    thread cancelpossessbuttonpressmonitor();
    self.holdingleavebutton = 1;

    for(var_2 = 0; var_2 <= var_1; var_2++) {
      wait 0.1;

      if(self.holdingleavebutton == 1 && var_2 == var_1) {
        var_0 notify("PossessHoldTimeComplete");
        continue;
      }

      if(self.holdingleavebutton == 0) {
        break;
      }
    }
  }
}

cancelpossessbuttonpressmonitor() {
  self endon("OrbitalStrikeStreakComplete");
  self endon("PossessHoldTimeComplete");
  self waittill("ToggleControlCancel");
  self.holdingleavebutton = 0;
}

activatethermal() {
  self setshadowrendering(0);
  self thermalvisionfofoverlayon();
  self setblurforplayer(1.1, 0);
  var_0 = 0.125;
  var_1 = 8500;
  var_2 = 0.125;
  var_3 = 5500;
  var_4 = 20;
  var_5 = 30;
  thread maps\mp\killstreaks\_aerial_utility::thermalvision("OrbitalStrikeStreakComplete", var_0, var_1, var_2, var_3, var_4, var_5);
}

playinteriorsound(var_0) {
  var_1 = common_scripts\utility::array_add(maps\mp\_utility::get_players_watching(), self);

  if(isDefined(var_0)) {
    var_0 thread maps\mp\_utility::playloopsoundtoplayers("vulcan_interior_loop_plr", undefined, var_1);
  }

  common_scripts\utility::waittill_any("OrbitalStrikeStreakComplete");

  if(isDefined(var_0)) {
    var_0 common_scripts\utility::stop_loop_sound_on_entity("vulcan_interior_loop_plr");
  }
}

weaponlistenforstopfire(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_1 = gettime() + var_0.fireduration * 1000;
  self setclientomnvar("ui_orbital_laser_fire", var_1);
  wait(var_0.fireduration);
  self setclientomnvar("ui_orbital_laser_fire", 0);
  var_0 notify("stop_charge");
}

getlaserradius(var_0) {
  if(var_0.widebeam) {
    return 256;
  } else {
    return 128;
  }
}

weaponsetup(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = anglestoright(var_0.angles);
  var_3 = var_0 gettagorigin("tag_origin") + var_1 * 30;
  var_4 = (0, 0, -1);
  var_5 = var_3 + var_4 * 5000;
  var_6 = bulletTrace(var_3, var_5, 0, var_0);
  var_7 = var_6["position"];
  var_8 = getlaserradius(var_0);
  var_0.weaponlinker = spawn("script_model", var_3);
  var_0.weaponlinker setModel("generic_prop_raven");
  var_0.weaponlinker linktosynchronizedparent(var_0, "tag_origin");
  var_9 = var_7;
  var_10 = vectortoangles(var_9 - var_3);
  var_11 = spawn("script_model", var_3);
  var_11 setModel("tag_origin");
  var_11.angles = var_10;
  var_11 linktosynchronizedparent(var_0.weaponlinker, "tag_origin");
  var_0.weapontag01 = var_11;
  var_12 = spawn("script_model", var_9);
  var_12.angles = (-90, 0, 0);
  var_12 setModel("tag_origin");
  var_12 setotherent(var_11);
  var_12 show();
  var_0.weapontag01.targetedent = var_12;

  if(var_0.beams) {
    var_9 = var_7 + var_1 * var_8;
    var_10 = vectortoangles(var_9 - var_3);
    var_13 = spawn("script_model", var_3);
    var_13 setModel("tag_origin");
    var_13.angles = var_10;
    var_13 linktosynchronizedparent(var_0.weaponlinker, "j_prop_1");
    var_0.weapontag02 = var_13;
    var_14 = spawn("script_model", var_9);
    var_14.angles = (-90, 0, 0);
    var_14 setModel("tag_origin");
    var_14 setotherent(var_13);
    var_14 show();
    var_0.weapontag02.targetedent = var_14;
    var_15 = sin(60) * var_8;
    var_16 = cos(60) * var_8;
    var_9 = var_7 - var_1 * var_16 + var_2 * var_15;
    var_10 = vectortoangles(var_9 - var_3);
    var_17 = spawn("script_model", var_3);
    var_17 setModel("tag_origin");
    var_17.angles = var_10;
    var_17 linktosynchronizedparent(var_0.weaponlinker, "j_prop_1");
    var_0.weapontag03 = var_17;
    var_18 = spawn("script_model", var_9);
    var_18.angles = (-90, 0, 0);
    var_18 setModel("tag_origin");
    var_18 setotherent(var_17);
    var_18 show();
    var_0.weapontag03.targetedent = var_18;
    var_9 = var_7 - var_1 * var_16 - var_2 * var_15;
    var_10 = vectortoangles(var_9 - var_3);
    var_19 = spawn("script_model", var_3);
    var_19 setModel("tag_origin");
    var_19.angles = var_10;
    var_19 linktosynchronizedparent(var_0.weaponlinker, "j_prop_1");
    var_0.weapontag04 = var_19;
    var_20 = spawn("script_model", var_9);
    var_20.angles = (-90, 0, 0);
    var_20 setModel("tag_origin");
    var_20 setotherent(var_19);
    var_20 show();
    var_0.weapontag04.targetedent = var_20;
  }

  thread spinthelasers(var_0);
  thread monitororbitalstrikeweapon(var_0);
}

deleteweaponmodels(var_0) {
  if(isDefined(var_0.weapontag01)) {
    var_0.weapontag01.targetedent delete();
    var_0.weapontag01 delete();

    if(var_0.beams) {
      var_0.weapontag02.targetedent delete();
      var_0.weapontag02 delete();
      var_0.weapontag03.targetedent delete();
      var_0.weapontag03 delete();
      var_0.weapontag04.targetedent delete();
      var_0.weapontag04 delete();
    }
  }

  if(isDefined(var_0.weaponlinker)) {
    var_0.weaponlinker delete();
  }
}

spinthelasers(var_0) {
  var_0.weaponlinker scriptmodelplayanim("mp_generic_prop_spin", "hello");
}

monitororbitalstrikeweapon(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 clearturrettarget();
  wait 1;
  var_1 = 6;

  while(var_0.numcharges > 0) {
    createorbitaltimer(var_0, var_1);
    var_0.numcharges--;
    sethudnumbursts(var_0);
    thread weaponlistenforstopfire(var_0);
    hidefirehud(var_0);
    laserweapon(var_0);
    wait 0.1;
  }

  var_0 notify("done");
}

oneshotsoundonmovingent(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 5.0;
  }

  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  var_2 linktosynchronizedparent(self);
  var_2 playSound(var_0);
  var_2 thread waitanddelete(var_1);
}

oneshotsoundonstationaryent(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 5.0;
  }

  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  var_2 playSound(var_0);
  var_2 thread waitanddelete(var_1);
}

startlasersounds(var_0) {
  var_0.playingloopfiresounds = 1;
  var_1 = common_scripts\utility::array_add(maps\mp\_utility::get_players_watching(), self);
  var_0.weapontag01.targetedent thread common_scripts\utility::play_loop_sound_on_entity("vulcan_beam_loop_npc");
  var_0.weapontag01.targetedent thread common_scripts\utility::play_loop_sound_on_entity("vulcan_impact_loop_npc");
  var_0.weapontag01.targetedent oneshotsoundonmovingent("vulcan_shot_snap_npc");
  var_0.weapontag01.targetedent oneshotsoundonmovingent("vulcan_shot_tail_npc");
  var_2 = "vulcan_std_beam_loop_plr";

  if(var_0.beams) {
    var_2 = "vulcan_lshow_beam_loop_plr";
  } else if(var_0.widebeam) {
    var_2 = "vulcan_wide_beam_loop_plr";
  }

  var_0 thread maps\mp\_utility::playloopsoundtoplayers("vulcan_beam_loop_plr", undefined, var_1);
  var_0 thread maps\mp\_utility::playloopsoundtoplayers(var_2, undefined, var_1);
  var_3 = "vulcan_shot_snap_plr";

  if(var_0.beams) {
    var_3 = "vulcan_shot_snap_lshow_plr";
  } else if(var_0.widebeam) {
    var_3 = "vulcan_shot_snap_wide_plr";
  }

  self playlocalsound(var_3);
  self playlocalsound("vulcan_shot_tail_plr");
}

stoplasersounds(var_0) {
  if(isDefined(var_0.weapontag01)) {
    var_0.weapontag01.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_beam_loop_npc");
    var_0.weapontag01.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_impact_loop_npc");

    if(var_0.beams) {
      var_0.weapontag02.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_beam_loop_npc");
      var_0.weapontag02.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_impact_loop_npc");
      var_0.weapontag03.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_beam_loop_npc");
      var_0.weapontag03.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_impact_loop_npc");
      var_0.weapontag04.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_beam_loop_npc");
      var_0.weapontag04.targetedent common_scripts\utility::stop_loop_sound_on_entity("vulcan_impact_loop_npc");
    }
  }

  var_1 = "vulcan_std_beam_loop_plr";

  if(var_0.widebeam) {
    var_1 = "vulcan_wide_beam_loop_plr";
  }

  var_0 common_scripts\utility::stop_loop_sound_on_entity("vulcan_beam_loop_plr");
  var_0 common_scripts\utility::stop_loop_sound_on_entity(var_1);

  if(isDefined(var_0.playingloopfiresounds) && var_0.playingloopfiresounds) {
    var_0.playingloopfiresounds = 0;

    if(isDefined(var_0.weapontag01)) {
      var_0.weapontag01.targetedent oneshotsoundonstationaryent("vulcan_beam_stop_npc");

      if(var_0.beams) {
        var_0.weapontag02.targetedent oneshotsoundonstationaryent("vulcan_beam_stop_npc");
        var_0.weapontag03.targetedent oneshotsoundonstationaryent("vulcan_beam_stop_npc");
        var_0.weapontag04.targetedent oneshotsoundonstationaryent("vulcan_beam_stop_npc");
      }
    }

    if(self.controllingorbitallaser) {
      var_2 = 1;

      if(isDefined(self) && var_2) {
        self playlocalsound("vulcan_beam_stop_plr");
      }
    }
  }
}

laserweapon(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  stopwarmupeffects(var_0);
  waitframe();
  waitframe();
  thread firelaserbeam(var_0);
  thread laserpilotquake(var_0);
  thread lasersurfacequake(var_0);
  thread laserdophysics(var_0);
  thread laserdodamge(var_0);
  self setremotehelicopterthrottlescale(0.3);
  var_0 waittill("stop_charge");
  self setremotehelicopterthrottlescale(1.0);
}

laserdodamge(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 endon("death");
  var_0 endon("PossessHoldTimeComplete");
  var_0 endon("leaving");
  var_0 endon("stop_charge");
  var_1 = getlaserradius(var_0);

  for(;;) {
    var_0 radiusdamage(var_0.weapontag01.targetedent.origin + (0, 0, 8), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");

    if(isDefined(level.ishorde) && level.ishorde && isDefined(level.flying_attack_drones)) {
      foreach(var_3 in level.flying_attack_drones) {
        if(var_3.origin[2] > var_0.weapontag01.targetedent.origin[2] && distance2dsquared(var_3.origin, var_0.weapontag01.targetedent.origin) < int(var_1 * var_1 / 9)) {
          var_3 dodamage(90, var_0.weapontag01.targetedent.origin, self, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
        }
      }
    }

    if(var_0.beams) {
      var_0 radiusdamage(var_0.weapontag02.targetedent.origin + (0, 0, 8), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
      var_0 radiusdamage(var_0.weapontag03.targetedent.origin + (0, 0, 8), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
      var_0 radiusdamage(var_0.weapontag04.targetedent.origin + (0, 0, 8), var_1, 90, 90, self, "MOD_TRIGGER_HURT", "orbital_laser_fov_mp");
    }

    glassradiusdamage(var_0.weapontag01.targetedent.origin + (0, 0, 32), var_1 * 2, 200, 200);

    if(var_0.beams) {
      glassradiusdamage(var_0.weapontag02.targetedent.origin + (0, 0, 32), var_1 * 2, 200, 200);
      glassradiusdamage(var_0.weapontag03.targetedent.origin + (0, 0, 32), var_1 * 2, 200, 200);
      glassradiusdamage(var_0.weapontag04.targetedent.origin + (0, 0, 32), var_1 * 2, 200, 200);
    }

    wait 0.15;
  }
}

watchallplayerdeath(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 thread waitforlaserdeath(var_0, var_1);
  }
}

waitforlaserdeath(var_0, var_1) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 endon("death");
  var_0 endon("PossessHoldTimeComplete");
  var_0 endon("leaving");

  for(;;) {
    self waittill("death", var_2, var_3, var_4);

    if(isDefined(var_4) && isDefined(var_2) && var_2 == var_1 && var_4 == "orbital_laser_fov_mp") {
      var_5 = 10;

      for(var_6 = 0; var_6 < var_5; var_6++) {
        wait 0.05;

        if(isDefined(self) && isDefined(self.body)) {
          playFXOnTag(level._effect["orbital_laser_death"], self.body, "tag_origin");
          break;
        }
      }
    }

    wait 0.05;
  }
}

laserdophysics(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 endon("death");
  var_0 endon("PossessHoldTimeComplete");
  var_0 endon("leaving");
  var_0 endon("stop_charge");
  var_1 = getlaserradius(var_0);
  var_2 = 2;

  for(;;) {
    var_3 = randomfloatrange(0.65, 0.8);
    var_4 = randomintrange(-180, 180);
    var_5 = (var_0.weapontag01.targetedent.angles[0] * var_3, var_4, var_4);
    var_6 = anglesToForward(var_5);
    physicsexplosionsphere(var_0.weapontag01.targetedent.origin + (0, 0, 1), var_1, 96, var_2);
    wait 0.4;
  }
}

firelaserbeam(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 endon("death");
  playfireeffects(var_0);
  playbeameffects(var_0);
  startlasersounds(var_0);
  var_0 waittill("stop_charge");

  if(isDefined(var_0)) {
    stopfireeffects(var_0);
    stopbeameffects(var_0);
    stoplasersounds(var_0);
  }
}

laserpilotquake(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 endon("death");
  var_0 endon("stop_weapon");
  var_0 endon("stop_charge");
  var_1 = 0.25;
  earthquake(0.07, var_1, var_0.origin, 256);
  wait(var_1);
}

lasersurfacequake(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 endon("death");
  var_0 endon("stop_weapon");
  var_0 endon("stop_charge");
  var_1 = 0.25;
  earthquake(0.5, var_1, var_0.weapontag01.targetedent.origin + (0, 0, 16), 384);
  wait(var_1);
}

playeffectongroundent(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");
  var_3 = self isgroundentoverwater();

  if(var_3) {
    playFXOnTag(var_1, self, "tag_origin");
  } else {
    playFXOnTag(var_0, self, "tag_origin");
  }

  for(;;) {
    var_4 = var_3;
    var_3 = self isgroundentoverwater();

    if(var_3 != var_4) {
      if(var_3) {
        stopFXOnTag(var_0, self, "tag_origin");
        playFXOnTag(var_1, self, "tag_origin");
      } else {
        stopFXOnTag(var_1, self, "tag_origin");
        playFXOnTag(var_0, self, "tag_origin");
      }
    }

    var_5 = common_scripts\utility::waittill_notify_or_timeout_return(var_2, 0.05);

    if(!isDefined(var_5) || var_5 != "timeout") {
      break;
    }
  }

  if(var_3) {
    stopFXOnTag(var_1, self, "tag_origin");
  } else {
    stopFXOnTag(var_0, self, "tag_origin");
  }
}

playwarmupeffects(var_0) {
  var_1 = "stop_warmup_fx";
  var_2 = getwarmupeffect(var_0);
  var_3 = getwarmupeffect(var_0, 1);
  var_0.weapontag01.targetedent thread playeffectongroundent(var_2, var_3, var_1);

  if(var_0.beams) {
    var_4 = getwarmuplightshoweffect(var_0);
    var_5 = getwarmuplightshoweffect(var_0, 1);
    var_0.weapontag02.targetedent thread playeffectongroundent(var_4, var_5, var_1);
    var_0.weapontag03.targetedent thread playeffectongroundent(var_4, var_5, var_1);
    var_0.weapontag04.targetedent thread playeffectongroundent(var_4, var_5, var_1);
  }
}

stopwarmupeffects(var_0) {
  var_1 = "stop_warmup_fx";

  if(isDefined(var_0.weapontag01)) {
    var_0.weapontag01.targetedent notify(var_1);

    if(var_0.beams) {
      var_0.weapontag02.targetedent notify(var_1);
      var_0.weapontag03.targetedent notify(var_1);
      var_0.weapontag04.targetedent notify(var_1);
    }
  }
}

getwarmupeffect(var_0, var_1) {
  var_2 = "orbital_laser_warmup";

  if(var_0.widebeam) {
    var_2 = var_2 + "_wide";
  }

  if(isDefined(var_1) && var_1) {
    var_2 = var_2 + "_water";
  }

  return common_scripts\utility::getfx(var_2);
}

getwarmuplightshoweffect(var_0, var_1) {
  var_2 = "orbital_laser_warmup_lightshow";

  if(var_0.widebeam) {
    var_2 = var_2 + "_wide";
  }

  if(isDefined(var_1) && var_1) {
    var_2 = var_2 + "_water";
  }

  return common_scripts\utility::getfx(var_2);
}

playwarmupsounds(var_0, var_1) {
  stopwarmupsounds(var_0);
  var_2 = "vulcan_charge_start_npc";
  var_3 = "vulcan_charge_start_plr";

  if(var_1) {
    var_2 = "vulcan_charge_up_npc";
    var_3 = "vulcan_charge_up_plr";
  }

  var_0.weapontag01.targetedent playsoundonmovingent(var_2);

  if(var_0.beams) {
    var_0.weapontag02.targetedent playsoundonmovingent(var_2);
    var_0.weapontag03.targetedent playsoundonmovingent(var_2);
    var_0.weapontag04.targetedent playsoundonmovingent(var_2);
  }

  self playlocalsound(var_3);
}

stopwarmupsounds(var_0) {
  if(isDefined(var_0.weapontag01)) {
    var_0.weapontag01.targetedent stopsounds();

    if(var_0.beams) {
      var_0.weapontag02.targetedent stopsounds();
      var_0.weapontag03.targetedent stopsounds();
      var_0.weapontag04.targetedent stopsounds();
    }
  }

  if(isDefined(self)) {
    self stoplocalsound("vulcan_charge_start_plr");
    self stoplocalsound("vulcan_charge_up_plr");
  }
}

playfireeffects(var_0) {
  var_1 = "stop_fire_fx";
  var_2 = getfireeffect(var_0);
  var_3 = getfireeffect(var_0, 1);
  var_4 = getfirelightshoweffect(var_0);
  var_5 = getfirelightshoweffect(var_0, 1);

  if(var_0.beams) {
    var_0.weapontag01.targetedent thread playeffectongroundent(var_4, var_5, var_1);
    var_0.weapontag02.targetedent thread playeffectongroundent(var_4, var_5, var_1);
    var_0.weapontag03.targetedent thread playeffectongroundent(var_4, var_5, var_1);
    var_0.weapontag04.targetedent thread playeffectongroundent(var_4, var_5, var_1);
  } else {
    var_0.weapontag01.targetedent thread playeffectongroundent(var_2, var_3, var_1);
  }
}

stopfireeffects(var_0) {
  var_1 = "stop_fire_fx";

  if(isDefined(var_0.weapontag01)) {
    var_0.weapontag01.targetedent notify(var_1);

    if(var_0.beams) {
      var_0.weapontag02.targetedent notify(var_1);
      var_0.weapontag03.targetedent notify(var_1);
      var_0.weapontag04.targetedent notify(var_1);
    }

    playlaserendingeffect(var_0);
  }
}

playlaserendingeffect(var_0) {
  var_1 = var_0.weapontag01.targetedent;

  if(var_1 isgroundentoverwater()) {
    playFX(level._effect["orbital_laser_ending_water"], var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
  } else {
    playFX(level._effect["orbital_laser_ending"], var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
  }
}

getfireeffect(var_0, var_1) {
  var_2 = "orbital_laser_fire";

  if(var_0.widebeam) {
    var_2 = var_2 + "_wide";
  }

  if(isDefined(var_1) && var_1) {
    var_2 = var_2 + "_water";
  }

  return common_scripts\utility::getfx(var_2);
}

getfirelightshoweffect(var_0, var_1) {
  var_2 = "orbital_laser_fire_lightshow";

  if(var_0.widebeam) {
    var_2 = var_2 + "_wide";
  }

  if(isDefined(var_1) && var_1) {
    var_2 = var_2 + "_water";
  }

  return common_scripts\utility::getfx(var_2);
}

playbeameffects(var_0) {
  var_1 = getbeameffect(var_0);
  playFXOnTag(var_1, var_0.weapontag01.targetedent, "tag_origin");

  if(var_0.beams) {
    var_2 = getlightshowbeameffect(var_0);
    playFXOnTag(var_2, var_0.weapontag02.targetedent, "tag_origin");
    playFXOnTag(var_2, var_0.weapontag03.targetedent, "tag_origin");
    playFXOnTag(var_2, var_0.weapontag04.targetedent, "tag_origin");
  }
}

stopbeameffects(var_0) {
  var_1 = getbeameffect(var_0);
  waitframe();

  if(isDefined(var_0.weapontag01)) {
    stopFXOnTag(var_1, var_0.weapontag01.targetedent, "tag_origin");

    if(var_0.beams) {
      var_2 = getlightshowbeameffect(var_0);
      stopFXOnTag(var_2, var_0.weapontag02.targetedent, "tag_origin");
      stopFXOnTag(var_2, var_0.weapontag03.targetedent, "tag_origin");
      stopFXOnTag(var_2, var_0.weapontag04.targetedent, "tag_origin");
    }
  }
}

playlingereffects(var_0) {
  playFXOnTag("orbital_laser_smoldering", var_0.weapontag01.targetedent, "tag_origin");
}

getbeameffect(var_0) {
  var_1 = "orbital_laser_beam";

  if(var_0.widebeam) {
    var_1 = var_1 + "_wide";
  }

  return common_scripts\utility::getfx(var_1);
}

getlightshowbeameffect(var_0) {
  var_1 = "orbital_laser_beam_lightshow";

  if(var_0.widebeam) {
    var_1 = var_1 + "_wide";
  }

  return common_scripts\utility::getfx(var_1);
}

orbitalstriketimer(var_0, var_1) {
  self endon("disconnect");
  self endon("OrbitalStrikeStreakComplete");
  wait(var_0);
  var_1 notify("leaving");
}

monitororbitalstrikedeath(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  self endon("OrbitalStrikeStreakComplete");
  var_0 waittill("death", var_1, var_2, var_3);
  var_0 maps\mp\gametypes\_damage::onkillstreakkilled(var_1, var_3, var_2, var_0.health + 1, "vulcan_destroyed", undefined, undefined, 1);
  var_0 notify("finish_death");
}

monitororbitalstriketimeout(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  var_0 common_scripts\utility::waittill_any("leaving", "crashing", "PossessHoldTimeComplete", "done", "finish_death");
  thread orbitalstrikecleanup(var_0);
}

givecontrolback(var_0) {
  if(isDefined(var_0) && isDefined(var_0.weapontag01)) {
    var_0.weapontag01.targetedent setotherent(undefined);

    if(var_0.beams) {
      var_0.weapontag02.targetedent setotherent(undefined);
      var_0.weapontag03.targetedent setotherent(undefined);
      var_0.weapontag04.targetedent setotherent(undefined);
    }
  }

  self setclientomnvar("ui_orbital_laser_charge", 0);
  self setclientomnvar("ui_orbital_laser_mode", 0);
  self setclientomnvar("ui_orbital_laser_bursts", 0);
  self setclientomnvar("ui_orbital_laser_fire", 0);
  self setclientomnvar("ui_orbital_laser", 0);
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
  self takeweapon("orbital_laser_fov_mp");

  if(self.disabledweaponswitch > 0) {
    common_scripts\utility::_enableweaponswitch();
  }

  self setblurforplayer(0, 0);
  self setshadowrendering(1);
  maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(self);
  self thermalvisionfofoverlayoff();
  self remotecontrolvehicleoff();
  self controlsunlink();
  self cameraunlink();

  if(maps\mp\_utility::isusingremote()) {
    maps\mp\_utility::clearusingremote();
  }

  thread delaycontrol();
  thread removevulcanvisionandlightsetpermap(0.5);

  if(getdvarint("camera_thirdPerson")) {
    maps\mp\_utility::setthirdpersondof(1);
  }

  maps\mp\_utility::playerrestoreangles();
  self notify("player_control_strike_over");
}

delaycontrol() {
  self freezecontrols(1);
  wait 0.5;
  self freezecontrols(0);
}

monitorplayerdisconnect(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  self waittill("disconnect");
  thread orbitalstrikecleanup(var_0, 1);
}

monitorplayerteamchange(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  common_scripts\utility::waittill_either("joined_team", "joined_spectators");
  thread orbitalstrikecleanup(var_0);
}

monitorgameended(var_0) {
  self endon("OrbitalStrikeStreakComplete");
  level waittill("game_ended");
  thread orbitalstrikecleanup(var_0);
}

orbitalstrikecleanup(var_0, var_1) {
  self notify("OrbitalStrikeStreakComplete");
  waittillframeend;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!var_1) {
    self.controllingorbitallaser = 0;
    givecontrolback(var_0);
    playerremovenotifycommands();
  }

  level.orbital_lasers = common_scripts\utility::array_remove(level.orbital_lasers, var_0);

  if(level.teambased) {
    setorbitallaserforteam(var_0.team, 0);
  }

  stopwarmupsounds(var_0);
  stoplasersounds(var_0);
  stopwarmupeffects(var_0);
  stopfireeffects(var_0);
  stopbeameffects(var_0);
  deleteweaponmodels(var_0);
  var_0 delete();
  maps\mp\_utility::decrementfauxvehiclecount();
  waitframe();

  if(isDefined(self)) {
    self stoprumble("orbital_laser_charge");
    self stoprumble("orbital_laser_charge_quick");
  }

  waitframe();

  if(isDefined(self)) {
    self stoprumble("orbital_laser_fire");
  }
}

playeraddnotifycommands() {
  if(!isbot(self)) {
    self notifyonplayercommand("SwitchVisionMode", "+actionslot 1");
    self notifyonplayercommand("ToggleControlState", "+activate");
    self notifyonplayercommand("ToggleControlCancel", "-activate");
    self notifyonplayercommand("ToggleControlState", "+usereload");
    self notifyonplayercommand("ToggleControlCancel", "-usereload");
    self notifyonplayercommand("StartFire", "+attack");
    self notifyonplayercommand("StartFire", "+attack_akimbo_accessible");
  }
}

playerremovenotifycommands() {
  if(!isbot(self)) {
    self notifyonplayercommandremove("SwitchVisionMode", "+actionslot 1");
    self notifyonplayercommandremove("ToggleControlState", "+activate");
    self notifyonplayercommandremove("ToggleControlCancel", "-activate");
    self notifyonplayercommandremove("ToggleControlState", "+usereload");
    self notifyonplayercommandremove("ToggleControlCancel", "-usereload");
    self notifyonplayercommandremove("StartFire", "+attack");
    self notifyonplayercommandremove("StartFire", "+attack_akimbo_accessible");
  }
}

setvulcanvisionandlightsetpermap(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  self endon("OrbitalStrikeStreakComplete");
  wait(var_0);

  if(isDefined(level.vulcanvisionset)) {
    self setclienttriggervisionset(level.vulcanvisionset, 0);
  }

  if(isDefined(level.vulcanlightset)) {
    self lightsetforplayer(level.vulcanlightset);
  }

  maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

removevulcanvisionandlightsetpermap(var_0) {
  self setclienttriggervisionset("", var_0);
  self lightsetforplayer("");
  maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}
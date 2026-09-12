/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\helicopter_pilot.gsc
*******************************************************/

function init() {
  level.heli_pilot = [];
  level.helipilotsettings = [];
  level.helipilotsettings["heli_pilot"] = spawnStruct();
  level.helipilotsettings["heli_pilot"].timeout = 60;
  level.helipilotsettings["heli_pilot"].maxhealth = 2000;
  level.helipilotsettings["heli_pilot"].streakname = "heli_pilot";
  level.helipilotsettings["heli_pilot"].vehicleinfo = "heli_pilot_mp";
  level.helipilotsettings["heli_pilot"].modelbase = "vehicle_aas_72x_killstreak";
  level.helipilotsettings["heli_pilot"].teamsplash = "used_heli_pilot";
  helipilot_setairstartnodes();
  level.heli_pilot_mesh = scripts\cp_mp\utility\game_utility::getlocaleent("heli_pilot_mesh");

  if(!isDefined(level.heli_pilot_mesh)) {} else {
    level.heli_pilot_mesh.origin += scripts\mp\utility\killstreak::gethelipilotmeshoffset();
  }

  var_0 = spawnStruct();
  var_0.scorepopup = "destroyed_helo_pilot";
  var_0.vodestroyed = undefined;
  var_0.callout = "callout_destroyed_helo_pilot";
  var_0.samdamagescale = 0.09;
  var_0.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_pilot"] = var_0;
}

function tryusehelipilot(var_0, var_1) {
  var_2 = "heli_pilot";
  var_3 = 1;

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  } else if(exceededmaxhelipilots(self.team)) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_3 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var_4 = createhelipilot(var_2);

  if(!isDefined(var_4)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return 0;
  }

  level.heli_pilot[self.team] = var_4;
  var_5 = starthelipilot(var_4);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return var_5;
}

function exceededmaxhelipilots(var_0) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level.heli_pilot[var_0]) || isDefined(level.heli_pilot[scripts\mp\utility\game::getotherteam(var_0)[0]])) {
      return 1;
    }

    return 0;
  }

  if(isDefined(level.heli_pilot[var_0])) {
    return 1;
  }

  return 0;
}

function watchhostmigrationfinishedinit(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    var_0 setclientomnvar("ui_heli_pilot", 1);
  }
}

function createhelipilot(var_0) {
  var_1 = helipilot_getcloseststartnode(self.origin);
  var_2 = helipilot_getlinkedstruct(var_1);
  var_3 = vectortoangles(var_2.origin - var_1.origin);
  var_4 = anglesToForward(self.angles);
  var_5 = var_2.origin + var_4 * -100;
  var_6 = var_1.origin;
  var_7 = spawnhelicopter(self, var_6, var_3, level.helipilotsettings[var_0].vehicleinfo, level.helipilotsettings[var_0].modelbase);

  if(!isDefined(var_7)) {
    return;
  }

  var_7 makevehiclesolidcapsule(18, -9, 18);
  var_7 scripts\mp\utility\killstreak::addtolittlebirdlist(var_7 getentitynumber());
  var_7 thread scripts\mp\utility\killstreak::removefromlittlebirdlistondeath(var_7 getentitynumber());
  var_7.maxhealth = level.helipilotsettings[var_0].maxhealth;
  var_7.speed = 40;
  var_7.owner = self;
  var_7 setotherent(self);
  var_7.team = self.team;
  var_7.helitype = "littlebird";
  var_7.helipilottype = "heli_pilot";
  var_7 setmaxpitchroll(45, 45);
  var_7 vehicle_setspeed(var_7.speed, 40, 40);
  var_7 setyawspeed(120, 60);
  var_7 setneargoalnotifydist(32);
  var_7 sethoverparams(100, 100, 100);
  var_7 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var_7.targetpos = var_5;
  var_7.currentnode = var_2;
  var_7.attract_strength = 10000;
  var_7.attract_range = 150;
  var_7.attractor = missile_createattractorent(var_7, var_7.attract_strength, var_7.attract_range);
  var_7 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("heli_pilot");
  thread helipilot_lightfx();
  thread helipilot_watchtimeout();
  thread helipilot_watchownerloss();
  thread helipilot_watchroundend();
  thread helipilot_watchobjectivecam();
  thread helipilot_watchdeath();
  thread watchhostmigrationfinishedinit(var_7);
  var_7.owner scripts\common\utility::ref_13e0a(level.ref_11b2a, level.helipilotsettings[var_7.helipilottype].streakname, var_7.targetpos);
  return var_7;
}

function helipilot_lightfx() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_nose");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail2");
}

function starthelipilot(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  scripts\mp\utility\player::setusingremote(var_0.helipilottype);

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\player::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  var_0 thread scripts\mp\killstreaks\flares::ks_setup_manual_flares(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread watchintrocleared(var_0);
  scripts\mp\utility\player::_freezecontrols(1);
  var_1 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_0.helipilottype);

  if(var_1 != "success") {
    if(!scripts\common\utility::is_weapon_allowed()) {
      scripts\common\utility::allow_weapon(1);
    }

    var_0 notify("death");
    return false;
  }

  scripts\mp\utility\player::_freezecontrols(0);
  var_2 = scripts\mp\utility\killstreak::gethelipilottraceoffset();
  var_3 = var_0.currentnode.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() + var_2;
  var_4 = var_0.currentnode.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() - var_2;
  var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, undefined, 0, 0, 1);

  if(isDefined(var_5["entity"])) {}

  var_6 = var_5["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + (0, 0, 250);
  var_7 = spawn("script_origin", var_6);
  self remotecontrolvehicle(var_0);
  thread heligotostartposition(var_0);
  thread helipilot_watchads();
  level thread scripts\mp\hud_util::teamplayercardsplash(level.helipilotsettings[var_0.helipilottype].teamsplash, self);
  var_0.killcament = spawn("script_origin", self getvieworigin());
  return true;
}

function heligotostartposition(var_0) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(var_0);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  var_0 delete();
}

function watchintrocleared(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_0 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self, self, "outline_nodepth_cyan", "killstreak");
  removeoutline(var_1, var_0);

  foreach(var_3 in level.participants) {
    if(!scripts\mp\utility\player::isreallyalive(var_3) || var_3.sessionstate != "playing") {
      continue;
    }

    if(scripts\mp\utility\player::isenemy(var_3)) {
      if(!var_3 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
        var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "outline_nodepth_orange", "killstreak");
        removeoutline(var_3, var_1, var_0);
        continue;
      }

      thread watchforperkremoval(var_3);
    }
  }

  thread watchplayersspawning();
  thread watchearlyexit(var_0);
}

function watchforperkremoval(var_0) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0.owner, "outline_nodepth_orange", "killstreak");
  removeoutline(var_1, var_0);
}

function watchplayersspawning() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(var_0.sessionstate == "playing" && self.owner scripts\mp\utility\player::isenemy(var_0)) {
      thread watchforperkremoval(var_0);
    }
  }
}

function removeoutline(var_0, var_1) {
  thread heliremoveoutline(var_0, var_1);
  thread playerremoveoutline(var_0, var_1);
}

function heliremoveoutline(var_0, var_1) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = ["leaving", "death"];
  var_1 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);

  if(isDefined(self)) {
    scripts\mp\utility\outline::outlinedisable(var_0, self);
    self notify("outline_removed");
    return;
  }
}

function playerremoveoutline(var_0, var_1) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = ["death"];
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\mp\utility\outline::outlinedisable(var_0, self);
  self notify("outline_removed");
}

function helipilot_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(isDefined(self.owner)) {
    helipilot_endride(self.owner, self);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread scripts\mp\killstreaks\helicopter::lbonkilled();
}

function helipilot_watchobjectivecam() {
  level endon("game_ended");
  self endon("gone");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level waittill("objective_cam");
  thread scripts\mp\killstreaks\helicopter::lbonkilled();

  if(isDefined(self.owner)) {
    helipilot_endride(self.owner, self);
    return;
  }
}

function helipilot_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  var_0 = level.helipilotsettings[self.helipilottype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread helipilot_leave();
}

function helipilot_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  thread helipilot_leave();
}

function helipilot_watchroundend() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level scripts\engine\utility::ref_143a5("round_end_finished", "game_ended");
  thread helipilot_leave();
}

function helipilot_leave() {
  self endon("death");
  self notify("leaving");

  if(isDefined(self.owner)) {
    helipilot_endride(self.owner, self);
  }

  var_0 = self.origin + (0, 0, 850);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_0);
  self waittill("goal");
  var_0 += anglesToForward(self.angles) * 15000;
  var_1 = spawn("script_origin", var_0);

  if(isDefined(var_1)) {
    self setlookatent(var_1);
    thread wait_and_delete(var_1);
  }

  self setvehgoalpos(var_0);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\helicopter::removelittlebird();
}

function wait_and_delete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait var_0;
  self delete();
}

function helipilot_endride(var_0) {
  if(isDefined(var_0)) {
    self setclientomnvar("ui_heli_pilot", 0);
    var_0 notify("end_remote");

    if(scripts\mp\utility\player::isusingremote()) {
      scripts\mp\utility\player::clearusingremote();
    }

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }

    self remotecontrolvehicleoff(var_0);
    self setplayerangles(self.restoreangles);
    thread helipilot_freezebuffer();
    return;
  }
}

function helipilot_freezebuffer() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_freezecontrols(1);
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0);
}

function helipilot_watchads() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    if(isDefined(self.owner)) {
      if(self.owner adsButtonPressed()) {
        if(!var_0) {
          self.owner setclientomnvar("ui_heli_pilot", 2);
          var_0 = 1;
        }
      } else if(var_0) {
        self.owner setclientomnvar("ui_heli_pilot", 1);
        var_0 = 0;
      }
    }

    wait 0.1;
  }
}

function helipilot_setairstartnodes() {
  level.air_start_nodes = scripts\engine\utility::getStructArray("chopper_boss_path_start", "targetname");
}

function helipilot_getlinkedstruct(var_0) {
  if(isDefined(var_0.script_linkto)) {
    var_1 = var_0 scripts\engine\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getStruct(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

function helipilot_getcloseststartnode(var_0) {
  var_1 = undefined;
  var_2 = 999999;

  foreach(var_4 in level.air_start_nodes) {
    var_5 = distance(var_4.origin, var_0);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

function watchearlyexit(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("leaving");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("killstreakExit");
  thread helipilot_leave();
}
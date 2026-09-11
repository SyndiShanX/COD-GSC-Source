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

  var0 = spawnStruct();
  var0.scorepopup = "destroyed_helo_pilot";
  var0.vodestroyed = undefined;
  var0.callout = "callout_destroyed_helo_pilot";
  var0.samdamagescale = 0.09;
  var0.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_pilot"] = var0;
}

function tryusehelipilot(var0, var1) {
  var2 = "heli_pilot";
  var3 = 1;

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  } else if(exceededmaxhelipilots(self.team)) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var3 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var4 = createhelipilot(var2);

  if(!isDefined(var4)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return 0;
  }

  level.heli_pilot[self.team] = var4;
  var5 = starthelipilot(var4);

  if(!isDefined(var5)) {
    var5 = 0;
  }

  return var5;
}

function exceededmaxhelipilots(var0) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level.heli_pilot[var0]) || isDefined(level.heli_pilot[scripts\mp\utility\game::getotherteam(var0)[0]])) {
      return 1;
    }

    return 0;
  }

  if(isDefined(level.heli_pilot[var0])) {
    return 1;
  }

  return 0;
}

function watchhostmigrationfinishedinit(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    var0 setclientomnvar("ui_heli_pilot", 1);
  }
}

function createhelipilot(var0) {
  var1 = helipilot_getcloseststartnode(self.origin);
  var2 = helipilot_getlinkedstruct(var1);
  var3 = vectortoangles(var2.origin - var1.origin);
  var4 = anglesToForward(self.angles);
  var5 = var2.origin + var4 * -100;
  var6 = var1.origin;
  var7 = spawnhelicopter(self, var6, var3, level.helipilotsettings[var0].vehicleinfo, level.helipilotsettings[var0].modelbase);

  if(!isDefined(var7)) {
    return;
  }

  var7 makevehiclesolidcapsule(18, -9, 18);
  var7 scripts\mp\utility\killstreak::addtolittlebirdlist(var7 getentitynumber());
  var7 thread scripts\mp\utility\killstreak::removefromlittlebirdlistondeath(var7 getentitynumber());
  var7.maxhealth = level.helipilotsettings[var0].maxhealth;
  var7.speed = 40;
  var7.owner = self;
  var7 setotherent(self);
  var7.team = self.team;
  var7.helitype = "littlebird";
  var7.helipilottype = "heli_pilot";
  var7 setmaxpitchroll(45, 45);
  var7 vehicle_setspeed(var7.speed, 40, 40);
  var7 setyawspeed(120, 60);
  var7 setneargoalnotifydist(32);
  var7 sethoverparams(100, 100, 100);
  var7 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var7.targetpos = var5;
  var7.currentnode = var2;
  var7.attract_strength = 10000;
  var7.attract_range = 150;
  var7.attractor = missile_createattractorent(var7, var7.attract_strength, var7.attract_range);
  var7 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("heli_pilot");
  thread helipilot_lightfx();
  thread helipilot_watchtimeout();
  thread helipilot_watchownerloss();
  thread helipilot_watchroundend();
  thread helipilot_watchobjectivecam();
  thread helipilot_watchdeath();
  thread watchhostmigrationfinishedinit(var7);
  var7.owner scripts\common\utility::ref_13e0a(level.ref_11b2a, level.helipilotsettings[var7.helipilottype].streakname, var7.targetpos);
  return var7;
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

function starthelipilot(var0) {
  level endon("game_ended");
  var0 endon("death");
  scripts\mp\utility\player::setusingremote(var0.helipilottype);

  if(getdvarint("NOSLRNTRKL")) {
    scripts\mp\utility\player::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  var0 thread scripts\mp\killstreaks\flares::ks_setup_manual_flares(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread watchintrocleared(var0);
  scripts\mp\utility\player::_freezecontrols(1);
  var1 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var0.helipilottype);

  if(var1 != "success") {
    if(!scripts\common\utility::is_weapon_allowed()) {
      scripts\common\utility::allow_weapon(1);
    }

    var0 notify("death");
    return false;
  }

  scripts\mp\utility\player::_freezecontrols(0);
  var2 = scripts\mp\utility\killstreak::gethelipilottraceoffset();
  var3 = var0.currentnode.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() + var2;
  var4 = var0.currentnode.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset() - var2;
  var5 = scripts\engine\trace::_bullet_trace(var3, var4, 0, undefined, 0, 0, 1);

  if(isDefined(var5["entity"])) {}

  var6 = var5["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + (0, 0, 250);
  var7 = spawn("script_origin", var6);
  self remotecontrolvehicle(var0);
  thread heligotostartposition(var0);
  thread helipilot_watchads();
  level thread scripts\mp\hud_util::teamplayercardsplash(level.helipilotsettings[var0.helipilottype].teamsplash, self);
  var0.killcament = spawn("script_origin", self getvieworigin());
  return true;
}

function heligotostartposition(var0) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(var0);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  var0 delete();
}

function watchintrocleared(var0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var0 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  var1 = scripts\mp\utility\outline::outlineenableforplayer(self, self, "outline_nodepth_cyan", "killstreak");
  removeoutline(var1, var0);

  foreach(var3 in level.participants) {
    if(!scripts\mp\utility\player::isreallyalive(var3) || var3.sessionstate != "playing") {
      continue;
    }

    if(scripts\mp\utility\player::isenemy(var3)) {
      if(!var3 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
        var1 = scripts\mp\utility\outline::outlineenableforplayer(var3, self, "outline_nodepth_orange", "killstreak");
        removeoutline(var3, var1, var0);
        continue;
      }

      thread watchforperkremoval(var3);
    }
  }

  thread watchplayersspawning();
  thread watchearlyexit(var0);
}

function watchforperkremoval(var0) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  var1 = scripts\mp\utility\outline::outlineenableforplayer(self, var0.owner, "outline_nodepth_orange", "killstreak");
  removeoutline(var1, var0);
}

function watchplayersspawning() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    level waittill("player_spawned", var0);

    if(var0.sessionstate == "playing" && self.owner scripts\mp\utility\player::isenemy(var0)) {
      thread watchforperkremoval(var0);
    }
  }
}

function removeoutline(var0, var1) {
  thread heliremoveoutline(var0, var1);
  thread playerremoveoutline(var0, var1);
}

function heliremoveoutline(var0, var1) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var2 = ["leaving", "death"];
  var1 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var2);

  if(isDefined(self)) {
    scripts\mp\utility\outline::outlinedisable(var0, self);
    self notify("outline_removed");
    return;
  }
}

function playerremoveoutline(var0, var1) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var2 = ["death"];
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var2);
  scripts\mp\utility\outline::outlinedisable(var0, self);
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
  var0 = level.helipilotsettings[self.helipilottype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
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

  var0 = self.origin + (0, 0, 850);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var0);
  self waittill("goal");
  var0 += anglesToForward(self.angles) * 15000;
  var1 = spawn("script_origin", var0);

  if(isDefined(var1)) {
    self setlookatent(var1);
    thread wait_and_delete(var1);
  }

  self setvehgoalpos(var0);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\helicopter::removelittlebird();
}

function wait_and_delete(var0) {
  self endon("death");
  level endon("game_ended");
  wait var0;
  self delete();
}

function helipilot_endride(var0) {
  if(isDefined(var0)) {
    self setclientomnvar("ui_heli_pilot", 0);
    var0 notify("end_remote");

    if(scripts\mp\utility\player::isusingremote()) {
      scripts\mp\utility\player::clearusingremote();
    }

    if(getdvarint("NOSLRNTRKL")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }

    self remotecontrolvehicleoff(var0);
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
  var0 = 0;

  for(;;) {
    if(isDefined(self.owner)) {
      if(self.owner adsButtonPressed()) {
        if(!var0) {
          self.owner setclientomnvar("ui_heli_pilot", 2);
          var0 = 1;
        }
      } else if(var0) {
        self.owner setclientomnvar("ui_heli_pilot", 1);
        var0 = 0;
      }
    }

    wait 0.1;
  }
}

function helipilot_setairstartnodes() {
  level.air_start_nodes = scripts\engine\utility::getStructArray("chopper_boss_path_start", "targetname");
}

function helipilot_getlinkedstruct(var0) {
  if(isDefined(var0.script_linkto)) {
    var1 = var0 scripts\engine\utility::get_links();

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = scripts\engine\utility::getStruct(var1[var2], "script_linkname");

      if(isDefined(var3)) {
        return var3;
      }
    }
  }

  return undefined;
}

function helipilot_getcloseststartnode(var0) {
  var1 = undefined;
  var2 = 999999;

  foreach(var4 in level.air_start_nodes) {
    var5 = distance(var4.origin, var0);

    if(var5 < var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  return var1;
}

function watchearlyexit(var0) {
  level endon("game_ended");
  var0 endon("death");
  self endon("leaving");
  var0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var0 waittill("killstreakExit");
  thread helipilot_leave();
}
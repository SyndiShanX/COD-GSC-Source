/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helicopter_pilot.gsc
********************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("heli_pilot", ::func_128E7);
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
  level.heli_pilot_mesh = getent("heli_pilot_mesh", "targetname");
  if(!isDefined(level.heli_pilot_mesh)) {} else {
    level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility::gethelipilotmeshoffset();
  }

  var_0 = spawnStruct();
  var_0.scorepopup = "destroyed_helo_pilot";
  var_0.vodestroyed = undefined;
  var_0.callout = "callout_destroyed_helo_pilot";
  var_0.samdamagescale = 0.09;
  var_0.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_pilot"] = var_0;
}

func_128E7(var_0, var_1) {
  var_2 = "heli_pilot";
  var_3 = 1;
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  } else if(func_68C1(self.team)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_3 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_4 = func_49D2(var_2);
  if(!isDefined(var_4)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  level.heli_pilot[self.team] = var_4;
  var_5 = func_10DA3(var_4);
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return var_5;
}

func_68C1(var_0) {
  if(level.gametype == "dm") {
    if(isDefined(level.heli_pilot[var_0]) || isDefined(level.heli_pilot[level.otherteam[var_0]])) {
      return 1;
    }

    return 0;
  }

  if(isDefined(level.heli_pilot[var_0])) {
    return 1;
  }

  return 0;
}

watchhostmigrationfinishedinit(var_0) {
  var_0 endon("killstreak_disowned");
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("host_migration_end");
    var_0 setclientomnvar("ui_heli_pilot", 1);
  }
}

func_49D2(var_0) {
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
  var_7 scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  var_7 thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_7.maxhealth = level.helipilotsettings[var_0].maxhealth;
  var_7.getclosestpointonnavmesh3d = 40;
  var_7.owner = self;
  var_7 setotherent(self);
  var_7.team = self.team;
  var_7.helitype = "littlebird";
  var_7.helipilottype = "heli_pilot";
  var_7 setmaxpitchroll(45, 45);
  var_7 vehicle_setspeed(var_7.getclosestpointonnavmesh3d, 40, 40);
  var_7 givelastonteamwarning(120, 60);
  var_7 setneargoalnotifydist(32);
  var_7 sethoverparams(100, 100, 100);
  var_7 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var_7.targetpos = var_5;
  var_7.var_4BF7 = var_2;
  var_7.attract_strength = 10000;
  var_7.attract_range = 150;
  var_7.attractor = missile_createattractorent(var_7, var_7.attract_strength, var_7.attract_range);
  var_7 thread scripts\mp\killstreaks\_helicopter::heli_damage_monitor("heli_pilot");
  var_7 thread helipilot_lightfx();
  var_7 thread helipilot_watchtimeout();
  var_7 thread helipilot_watchownerloss();
  var_7 thread helipilot_watchroundend();
  var_7 thread helipilot_watchobjectivecam();
  var_7 thread helipilot_watchdeath();
  var_7 thread watchhostmigrationfinishedinit(self);
  var_7.owner scripts\mp\matchdata::logkillstreakevent(level.helipilotsettings[var_7.helipilottype].streakname, var_7.targetpos);
  return var_7;
}

helipilot_lightfx() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_nose");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail2");
}

func_10DA3(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  scripts\mp\utility::setusingremote(var_0.helipilottype);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  var_0 thread scripts\mp\killstreaks\_flares::func_A730(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread watchintrocleared(var_0);
  scripts\mp\utility::freezecontrolswrapper(1);
  var_1 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_0.helipilottype);
  if(var_1 != "success") {
    if(isDefined(self.disabledweapon) && self.disabledweapon) {
      scripts\engine\utility::allow_weapon(1);
    }

    var_0 notify("death");
    return 0;
  }

  scripts\mp\utility::freezecontrolswrapper(0);
  var_2 = scripts\mp\utility::gethelipilottraceoffset();
  var_3 = var_0.var_4BF7.origin + scripts\mp\utility::gethelipilotmeshoffset() + var_2;
  var_4 = var_0.var_4BF7.origin + scripts\mp\utility::gethelipilotmeshoffset() - var_2;
  var_5 = bulletTrace(var_3, var_4, 0, undefined, 0, 0, 1);
  if(!isDefined(var_5["entity"])) {}

  var_6 = var_5["position"] - scripts\mp\utility::gethelipilotmeshoffset() + (0, 0, 250);
  var_7 = spawn("script_origin", var_6);
  self remotecontrolvehicle(var_0);
  var_0 thread heligotostartposition(var_7);
  var_0 thread helipilot_watchads();
  level thread scripts\mp\utility::teamplayercardsplash(level.helipilotsettings[var_0.helipilottype].teamsplash, self);
  var_0.killcament = spawn("script_origin", self getvieworigin());
  return 1;
}

heligotostartposition(var_0) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(var_0);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  var_0 delete();
}

watchintrocleared(var_0) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_0 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  var_1 = scripts\mp\utility::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  removeoutline(var_1, var_0);
  foreach(var_3 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_3) || var_3.sessionstate != "playing") {
      continue;
    }

    if(scripts\mp\utility::isenemy(var_3)) {
      if(!var_3 scripts\mp\utility::_hasperk("specialty_noplayertarget")) {
        var_1 = scripts\mp\utility::outlineenableforplayer(var_3, "orange", self, 0, 0, "killstreak");
        var_3 removeoutline(var_1, var_0);
        continue;
      }

      var_3 thread watchforperkremoval(var_0);
    }
  }

  var_0 thread watchplayersspawning();
  thread watchearlyexit(var_0);
}

watchforperkremoval(var_0) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  var_1 = scripts\mp\utility::outlineenableforplayer(self, "orange", var_0.owner, 0, 0, "killstreak");
  removeoutline(var_1, var_0);
}

watchplayersspawning() {
  self endon("leaving");
  self endon("death");
  for(;;) {
    level waittill("player_spawned", var_0);
    if(var_0.sessionstate == "playing" && self.owner scripts\mp\utility::isenemy(var_0)) {
      var_0 thread watchforperkremoval(self);
    }
  }
}

removeoutline(var_0, var_1) {
  thread heliremoveoutline(var_0, var_1);
  thread playerremoveoutline(var_0, var_1);
}

heliremoveoutline(var_0, var_1) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = ["leaving", "death"];
  var_1 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  if(isDefined(self)) {
    scripts\mp\utility::outlinedisable(var_0, self);
    self notify("outline_removed");
  }
}

playerremoveoutline(var_0, var_1) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = ["death"];
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\mp\utility::outlinedisable(var_0, self);
  self notify("outline_removed");
}

helipilot_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  if(isDefined(self.owner)) {
    self.owner helipilot_endride(self);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread scripts\mp\killstreaks\_helicopter::lbonkilled();
}

helipilot_watchobjectivecam() {
  level endon("game_ended");
  self endon("gone");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level waittill("objective_cam");
  thread scripts\mp\killstreaks\_helicopter::lbonkilled();
  if(isDefined(self.owner)) {
    self.owner helipilot_endride(self);
  }
}

helipilot_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  var_0 = level.helipilotsettings[self.helipilottype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread helipilot_leave();
}

helipilot_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  thread helipilot_leave();
}

helipilot_watchroundend() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level scripts\engine\utility::waittill_any("round_end_finished", "game_ended");
  thread helipilot_leave();
}

helipilot_leave() {
  self endon("death");
  self notify("leaving");
  if(isDefined(self.owner)) {
    self.owner helipilot_endride(self);
  }

  var_0 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
  var_1 = self.origin + (0, 0, var_0);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_1);
  self waittill("goal");
  var_1 = var_1 + anglesToForward(self.angles) * 15000;
  var_2 = spawn("script_origin", var_1);
  if(isDefined(var_2)) {
    self setlookatent(var_2);
    var_2 thread wait_and_delete(3);
  }

  self setvehgoalpos(var_1);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\_helicopter::removelittlebird();
}

wait_and_delete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

helipilot_endride(var_0) {
  if(isDefined(var_0)) {
    self setclientomnvar("ui_heli_pilot", 0);
    var_0 notify("end_remote");
    if(scripts\mp\utility::isusingremote()) {
      scripts\mp\utility::clearusingremote();
    }

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }

    self remotecontrolvehicleoff(var_0);
    self setplayerangles(self.restoreangles);
    thread helipilot_freezebuffer();
  }
}

helipilot_freezebuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility::freezecontrolswrapper(1);
  wait(0.5);
  scripts\mp\utility::freezecontrolswrapper(0);
}

helipilot_watchads() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  var_0 = 0;
  for(;;) {
    if(isDefined(self.owner)) {
      if(self.owner adsbuttonpressed()) {
        if(!var_0) {
          self.owner setclientomnvar("ui_heli_pilot", 2);
          var_0 = 1;
        }
      } else if(var_0) {
        self.owner setclientomnvar("ui_heli_pilot", 1);
        var_0 = 0;
      }
    }

    wait(0.1);
  }
}

helipilot_setairstartnodes() {
  level.air_start_nodes = scripts\engine\utility::getstructarray("chopper_boss_path_start", "targetname");
}

helipilot_getlinkedstruct(var_0) {
  if(isDefined(var_0.script_linkto)) {
    var_1 = var_0 scripts\engine\utility::get_links();
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getstruct(var_1[var_2], "script_linkname");
      if(isDefined(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

helipilot_getcloseststartnode(var_0) {
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

watchearlyexit(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("leaving");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("killstreakExit");
  var_0 thread helipilot_leave();
}
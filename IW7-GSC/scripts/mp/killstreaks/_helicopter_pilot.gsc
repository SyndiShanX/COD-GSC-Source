/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_helicopter_pilot.gsc
********************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("heli_pilot", ::func_128E7);
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

  var_00 = spawnStruct();
  var_00.scorepopup = "destroyed_helo_pilot";
  var_00.vodestroyed = undefined;
  var_00.callout = "callout_destroyed_helo_pilot";
  var_00.samdamagescale = 0.09;
  var_00.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_pilot"] = var_00;
}

func_128E7(param_00, param_01) {
  var_02 = "heli_pilot";
  var_03 = 1;
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  } else if(func_68C1(self.team)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_03 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_04 = func_49D2(var_02);
  if(!isDefined(var_04)) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  level.heli_pilot[self.team] = var_04;
  var_05 = func_10DA3(var_04);
  if(!isDefined(var_05)) {
    var_05 = 0;
  }

  return var_05;
}

func_68C1(param_00) {
  if(level.gametype == "dm") {
    if(isDefined(level.heli_pilot[param_00]) || isDefined(level.heli_pilot[level.otherteam[param_00]])) {
      return 1;
    }

    return 0;
  }

  if(isDefined(level.heli_pilot[param_00])) {
    return 1;
  }

  return 0;
}

watchhostmigrationfinishedinit(param_00) {
  param_00 endon("killstreak_disowned");
  param_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("host_migration_end");
    param_00 setclientomnvar("ui_heli_pilot", 1);
  }
}

func_49D2(param_00) {
  var_01 = helipilot_getcloseststartnode(self.origin);
  var_02 = helipilot_getlinkedstruct(var_01);
  var_03 = vectortoangles(var_02.origin - var_01.origin);
  var_04 = anglesToForward(self.angles);
  var_05 = var_02.origin + var_04 * -100;
  var_06 = var_01.origin;
  var_07 = spawnhelicopter(self, var_06, var_03, level.helipilotsettings[param_00].vehicleinfo, level.helipilotsettings[param_00].modelbase);
  if(!isDefined(var_07)) {
    return;
  }

  var_07 makevehiclesolidcapsule(18, -9, 18);
  var_07 scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  var_07 thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_07.maxhealth = level.helipilotsettings[param_00].maxhealth;
  var_07.getclosestpointonnavmesh3d = 40;
  var_07.triggerportableradarping = self;
  var_07 setotherent(self);
  var_07.team = self.team;
  var_07.helitype = "littlebird";
  var_07.helipilottype = "heli_pilot";
  var_07 setmaxpitchroll(45, 45);
  var_07 vehicle_setspeed(var_07.getclosestpointonnavmesh3d, 40, 40);
  var_07 givelastonteamwarning(120, 60);
  var_07 setneargoalnotifydist(32);
  var_07 sethoverparams(100, 100, 100);
  var_07 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var_07.targetpos = var_05;
  var_07.var_4BF7 = var_02;
  var_07.attract_strength = 10000;
  var_07.attract_range = 150;
  var_07.attractor = missile_createattractorent(var_07, var_07.attract_strength, var_07.attract_range);
  var_07 thread scripts\mp\killstreaks\_helicopter::heli_damage_monitor("heli_pilot");
  var_07 thread helipilot_lightfx();
  var_07 thread helipilot_watchtimeout();
  var_07 thread helipilot_watchownerloss();
  var_07 thread helipilot_watchroundend();
  var_07 thread helipilot_watchobjectivecam();
  var_07 thread helipilot_watchdeath();
  var_07 thread watchhostmigrationfinishedinit(self);
  var_07.triggerportableradarping scripts\mp\matchdata::logkillstreakevent(level.helipilotsettings[var_07.helipilottype].streakname, var_07.targetpos);
  return var_07;
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

func_10DA3(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  scripts\mp\utility::setusingremote(param_00.helipilottype);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  param_00 thread scripts\mp\killstreaks\_flares::func_A730(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread watchintrocleared(param_00);
  scripts\mp\utility::freezecontrolswrapper(1);
  var_01 = scripts\mp\killstreaks\_killstreaks::initridekillstreak(param_00.helipilottype);
  if(var_01 != "success") {
    if(isDefined(self.disabledweapon) && self.disabledweapon) {
      scripts\engine\utility::allow_weapon(1);
    }

    param_00 notify("death");
    return 0;
  }

  scripts\mp\utility::freezecontrolswrapper(0);
  var_02 = scripts\mp\utility::gethelipilottraceoffset();
  var_03 = param_00.var_4BF7.origin + scripts\mp\utility::gethelipilotmeshoffset() + var_02;
  var_04 = param_00.var_4BF7.origin + scripts\mp\utility::gethelipilotmeshoffset() - var_02;
  var_05 = bulletTrace(var_03, var_04, 0, undefined, 0, 0, 1);
  if(!isDefined(var_05["entity"])) {}

  var_06 = var_05["position"] - scripts\mp\utility::gethelipilotmeshoffset() + (0, 0, 250);
  var_07 = spawn("script_origin", var_06);
  self remotecontrolvehicle(param_00);
  param_00 thread heligotostartposition(var_07);
  param_00 thread helipilot_watchads();
  level thread scripts\mp\utility::teamplayercardsplash(level.helipilotsettings[param_00.helipilottype].teamsplash, self);
  param_00.killcament = spawn("script_origin", self getvieworigin());
  return 1;
}

heligotostartposition(param_00) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(param_00);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  param_00 delete();
}

watchintrocleared(param_00) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  param_00 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  var_01 = scripts\mp\utility::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  removeoutline(var_01, param_00);
  foreach(var_03 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_03) || var_03.sessionstate != "playing") {
      continue;
    }

    if(scripts\mp\utility::isenemy(var_03)) {
      if(!var_03 scripts\mp\utility::_hasperk("specialty_noplayertarget")) {
        var_01 = scripts\mp\utility::outlineenableforplayer(var_03, "orange", self, 0, 0, "killstreak");
        var_03 removeoutline(var_01, param_00);
        continue;
      }

      var_03 thread watchforperkremoval(param_00);
    }
  }

  param_00 thread watchplayersspawning();
  thread watchearlyexit(param_00);
}

watchforperkremoval(param_00) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  var_01 = scripts\mp\utility::outlineenableforplayer(self, "orange", param_00.triggerportableradarping, 0, 0, "killstreak");
  removeoutline(var_01, param_00);
}

watchplayersspawning() {
  self endon("leaving");
  self endon("death");
  for(;;) {
    level waittill("player_spawned", var_00);
    if(var_00.sessionstate == "playing" && self.triggerportableradarping scripts\mp\utility::isenemy(var_00)) {
      var_00 thread watchforperkremoval(self);
    }
  }
}

removeoutline(param_00, param_01) {
  thread heliremoveoutline(param_00, param_01);
  thread playerremoveoutline(param_00, param_01);
}

heliremoveoutline(param_00, param_01) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_02 = ["leaving", "death"];
  param_01 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_02);
  if(isDefined(self)) {
    scripts\mp\utility::outlinedisable(param_00, self);
    self notify("outline_removed");
  }
}

playerremoveoutline(param_00, param_01) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_02 = ["death"];
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_02);
  scripts\mp\utility::outlinedisable(param_00, self);
  self notify("outline_removed");
}

helipilot_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping helipilot_endride(self);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread scripts\mp\killstreaks\_helicopter::lbonkilled();
}

helipilot_watchobjectivecam() {
  level endon("game_ended");
  self endon("gone");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  level waittill("objective_cam");
  thread scripts\mp\killstreaks\_helicopter::lbonkilled();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping helipilot_endride(self);
  }
}

helipilot_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  var_00 = level.helipilotsettings[self.helipilottype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  thread helipilot_leave();
}

helipilot_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread helipilot_leave();
}

helipilot_watchroundend() {
  self endon("death");
  self endon("leaving");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping endon("joined_team");
  self.triggerportableradarping endon("joined_spectators");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended");
  thread helipilot_leave();
}

helipilot_leave() {
  self endon("death");
  self notify("leaving");
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping helipilot_endride(self);
  }

  var_00 = scripts\mp\killstreaks\_airdrop::getflyheightoffset(self.origin);
  var_01 = self.origin + (0, 0, var_00);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_01);
  self waittill("goal");
  var_01 = var_01 + anglesToForward(self.angles) * 15000;
  var_02 = spawn("script_origin", var_01);
  if(isDefined(var_02)) {
    self setlookatent(var_02);
    var_02 thread wait_and_delete(3);
  }

  self setvehgoalpos(var_01);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\_helicopter::removelittlebird();
}

wait_and_delete(param_00) {
  self endon("death");
  level endon("game_ended");
  wait(param_00);
  self delete();
}

helipilot_endride(param_00) {
  if(isDefined(param_00)) {
    self setclientomnvar("ui_heli_pilot", 0);
    param_00 notify("end_remote");
    if(scripts\mp\utility::isusingremote()) {
      scripts\mp\utility::clearusingremote();
    }

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }

    self remotecontrolvehicleoff(param_00);
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
  var_00 = 0;
  for(;;) {
    if(isDefined(self.triggerportableradarping)) {
      if(self.triggerportableradarping adsbuttonpressed()) {
        if(!var_00) {
          self.triggerportableradarping setclientomnvar("ui_heli_pilot", 2);
          var_00 = 1;
        }
      } else if(var_00) {
        self.triggerportableradarping setclientomnvar("ui_heli_pilot", 1);
        var_00 = 0;
      }
    }

    wait(0.1);
  }
}

helipilot_setairstartnodes() {
  level.air_start_nodes = scripts\engine\utility::getstructarray("chopper_boss_path_start", "targetname");
}

helipilot_getlinkedstruct(param_00) {
  if(isDefined(param_00.script_linkto)) {
    var_01 = param_00 scripts\engine\utility::get_links();
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_03 = scripts\engine\utility::getstruct(var_01[var_02], "script_linkname");
      if(isDefined(var_03)) {
        return var_03;
      }
    }
  }

  return undefined;
}

helipilot_getcloseststartnode(param_00) {
  var_01 = undefined;
  var_02 = 999999;
  foreach(var_04 in level.air_start_nodes) {
    var_05 = distance(var_04.origin, param_00);
    if(var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

watchearlyexit(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  self endon("leaving");
  param_00 thread scripts\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
  param_00 waittill("killstreakExit");
  param_00 thread helipilot_leave();
}
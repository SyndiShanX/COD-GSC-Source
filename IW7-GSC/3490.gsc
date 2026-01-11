/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3490.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("heli_pilot", ::func_128E7);
  level.heli_pilot = [];
  level.helipilotsettings = [];
  level.helipilotsettings["heli_pilot"] = spawnStruct();
  level.helipilotsettings["heli_pilot"].timeout = 60.0;
  level.helipilotsettings["heli_pilot"].maxhealth = 2000;
  level.helipilotsettings["heli_pilot"].streakname = "heli_pilot";
  level.helipilotsettings["heli_pilot"].vehicleinfo = "heli_pilot_mp";
  level.helipilotsettings["heli_pilot"].modelbase = "vehicle_aas_72x_killstreak";
  level.helipilotsettings["heli_pilot"].teamsplash = "used_heli_pilot";
  helipilot_setairstartnodes();
  level.heli_pilot_mesh = getent("heli_pilot_mesh", "targetname");

  if(!isDefined(level.heli_pilot_mesh)) {} else
    level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility\game::gethelipilotmeshoffset();

  var_00 = spawnStruct();
  var_0.scorepopup = "destroyed_helo_pilot";
  var_0.vodestroyed = undefined;
  var_0.callout = "callout_destroyed_helo_pilot";
  var_0.samdamagescale = 0.09;
  var_0.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_pilot"] = var_00;
}

func_128E7(var_00, var_01) {
  var_02 = "heli_pilot";
  var_03 = 1;

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }
  else if(func_68C1(self.team)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_03 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
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

func_68C1(var_00) {
  if(level.gametype == "dm") {
    if(isDefined(level.heli_pilot[var_00]) || isDefined(level.heli_pilot[level.otherteam[var_00]])) {
      return 1;
    }
    else {
      return 0;
    }
  } else if(isDefined(level.heli_pilot[var_00]))
    return 1;
  else {
    return 0;
  }
}

watchhostmigrationfinishedinit(var_00) {
  var_00 endon("killstreak_disowned");
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    var_00 setclientomnvar("ui_heli_pilot", 1);
  }
}

func_49D2(var_00) {
  var_01 = helipilot_getcloseststartnode(self.origin);
  var_02 = helipilot_getlinkedstruct(var_01);
  var_03 = vectortoangles(var_2.origin - var_1.origin);
  var_04 = anglesToForward(self.angles);
  var_05 = var_2.origin + var_04 * -100;
  var_06 = var_1.origin;
  var_07 = spawnhelicopter(self, var_06, var_03, level.helipilotsettings[var_00].vehicleinfo, level.helipilotsettings[var_00].modelbase);

  if(!isDefined(var_07)) {
    return;
  }
  var_07 makevehiclesolidcapsule(18, -9, 18);
  var_07 scripts\mp\killstreaks\helicopter::addtolittlebirdlist();
  var_07 thread scripts\mp\killstreaks\helicopter::func_E111();
  var_7.maxhealth = level.helipilotsettings[var_00].maxhealth;
  var_7.speed = 40;
  var_7.owner = self;
  var_07 setotherent(self);
  var_7.team = self.team;
  var_7.helitype = "littlebird";
  var_7.helipilottype = "heli_pilot";
  var_07 setmaxpitchroll(45, 45);
  var_07 vehicle_setspeed(var_7.speed, 40, 40);
  var_07 setyawspeed(120, 60);
  var_07 setneargoalnotifydist(32);
  var_07 sethoverparams(100, 100, 100);
  var_07 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var_7.targetpos = var_05;
  var_7.func_4BF7 = var_02;
  var_7.attract_strength = 10000;
  var_7.attract_range = 150;
  var_7.attractor = missile_createattractorent(var_07, var_7.attract_strength, var_7.attract_range);
  var_07 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("heli_pilot");
  var_07 thread helipilot_lightfx();
  var_07 thread helipilot_watchtimeout();
  var_07 thread helipilot_watchownerloss();
  var_07 thread helipilot_watchroundend();
  var_07 thread helipilot_watchobjectivecam();
  var_07 thread helipilot_watchdeath();
  var_07 thread watchhostmigrationfinishedinit(self);
  var_7.owner scripts\mp\matchdata::logkillstreakevent(level.helipilotsettings[var_7.helipilottype].streakname, var_7.targetpos);
  return var_07;
}

helipilot_lightfx() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_nose");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail2");
}

func_10DA3(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  scripts\mp\utility\game::setusingremote(var_0.helipilottype);

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  var_00 thread scripts\mp\killstreaks\flares::func_A730(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread watchintrocleared(var_00);
  scripts\mp\utility\game::freezecontrolswrapper(1);
  var_01 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_0.helipilottype);

  if(var_01 != "success") {
    if(isDefined(self.disabledweapon) && self.disabledweapon) {
      scripts\engine\utility::allow_weapon(1);
    }

    var_00 notify("death");
    return 0;
  }

  scripts\mp\utility\game::freezecontrolswrapper(0);
  var_02 = scripts\mp\utility\game::gethelipilottraceoffset();
  var_03 = var_0.func_4BF7.origin + (scripts\mp\utility\game::gethelipilotmeshoffset() + var_02);
  var_04 = var_0.func_4BF7.origin + (scripts\mp\utility\game::gethelipilotmeshoffset() - var_02);
  var_05 = bulletTrace(var_03, var_04, 0, undefined, 0, 0, 1);

  if(!isDefined(var_5["entity"])) {}

  var_06 = var_5["position"] - scripts\mp\utility\game::gethelipilotmeshoffset() + (0, 0, 250);
  var_07 = spawn("script_origin", var_06);
  self remotecontrolvehicle(var_00);
  var_00 thread heligotostartposition(var_07);
  var_00 thread helipilot_watchads();
  level thread scripts\mp\utility\game::teamplayercardsplash(level.helipilotsettings[var_0.helipilottype].teamsplash, self);
  var_0.killcament = spawn("script_origin", self getvieworigin());
  return 1;
}

heligotostartposition(var_00) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(var_00);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  var_00 delete();
}

watchintrocleared(var_00) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_00 endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  var_01 = scripts\mp\utility\game::outlineenableforplayer(self, "cyan", self, 0, 0, "killstreak");
  removeoutline(var_01, var_00);

  foreach(var_03 in level.participants) {
    if(!scripts\mp\utility\game::isreallyalive(var_03) || var_3.sessionstate != "playing") {
      continue;
    }
    if(scripts\mp\utility\game::isenemy(var_03)) {
      if(!var_03 scripts\mp\utility\game::_hasperk("specialty_noplayertarget")) {
        var_01 = scripts\mp\utility\game::outlineenableforplayer(var_03, "orange", self, 0, 0, "killstreak");
        var_03 removeoutline(var_01, var_00);
        continue;
      }

      var_03 thread watchforperkremoval(var_00);
    }
  }

  var_00 thread watchplayersspawning();
  thread watchearlyexit(var_00);
}

watchforperkremoval(var_00) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  var_01 = scripts\mp\utility\game::outlineenableforplayer(self, "orange", var_0.owner, 0, 0, "killstreak");
  removeoutline(var_01, var_00);
}

watchplayersspawning() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    level waittill("player_spawned", var_00);

    if(var_0.sessionstate == "playing" && self.owner scripts\mp\utility\game::isenemy(var_00)) {
      var_00 thread watchforperkremoval(self);
    }
  }
}

removeoutline(var_00, var_01) {
  thread heliremoveoutline(var_00, var_01);
  thread playerremoveoutline(var_00, var_01);
}

heliremoveoutline(var_00, var_01) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_02 = ["leaving", "death"];
  var_01 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_02);

  if(isDefined(self)) {
    scripts\mp\utility\game::outlinedisable(var_00, self);
    self notify("outline_removed");
  }
}

playerremoveoutline(var_00, var_01) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  var_02 = ["death"];
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_02);
  scripts\mp\utility\game::outlinedisable(var_00, self);
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

  thread scripts\mp\killstreaks\helicopter::lbonkilled();
}

helipilot_watchobjectivecam() {
  level endon("game_ended");
  self endon("gone");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level waittill("objective_cam");
  thread scripts\mp\killstreaks\helicopter::lbonkilled();

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
  var_00 = level.helipilotsettings[self.helipilottype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
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

  var_00 = scripts\mp\killstreaks\airdrop::getflyheightoffset(self.origin);
  var_01 = self.origin + (0, 0, var_00);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_01);
  self waittill("goal");
  var_01 = var_01 + anglesToForward(self.angles) * 15000;
  var_02 = spawn("script_origin", var_01);

  if(isDefined(var_02)) {
    self setlookatent(var_02);
    var_02 thread wait_and_delete(3.0);
  }

  self setvehgoalpos(var_01);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\helicopter::removelittlebird();
}

wait_and_delete(var_00) {
  self endon("death");
  level endon("game_ended");
  wait(var_00);
  self delete();
}

helipilot_endride(var_00) {
  if(isDefined(var_00)) {
    self setclientomnvar("ui_heli_pilot", 0);
    var_00 notify("end_remote");

    if(scripts\mp\utility\game::isusingremote()) {
      scripts\mp\utility\game::clearusingremote();
    }

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility\game::setthirdpersondof(1);
    }

    self remotecontrolvehicleoff(var_00);
    self setplayerangles(self.restoreangles);
    thread helipilot_freezebuffer();
  }
}

helipilot_freezebuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility\game::freezecontrolswrapper(1);
  wait 0.5;
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

helipilot_watchads() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  var_00 = 0;

  for(;;) {
    if(isDefined(self.owner)) {
      if(self.owner adsbuttonpressed()) {
        if(!var_00) {
          self.owner setclientomnvar("ui_heli_pilot", 2);
          var_00 = 1;
        }
      } else if(var_00) {
        self.owner setclientomnvar("ui_heli_pilot", 1);
        var_00 = 0;
      }
    }

    wait 0.1;
  }
}

helipilot_setairstartnodes() {
  level.air_start_nodes = scripts\engine\utility::getstructarray("chopper_boss_path_start", "targetname");
}

helipilot_getlinkedstruct(var_00) {
  if(isDefined(var_0.script_linkto)) {
    var_01 = var_00 scripts\engine\utility::get_links();

    for(var_02 = 0; var_02 < var_1.size; var_2++) {
      var_03 = scripts\engine\utility::getstruct(var_1[var_02], "script_linkname");

      if(isDefined(var_03)) {
        return var_03;
      }
    }
  }

  return undefined;
}

helipilot_getcloseststartnode(var_00) {
  var_01 = undefined;
  var_02 = 999999;

  foreach(var_04 in level.air_start_nodes) {
    var_05 = distance(var_4.origin, var_00);

    if(var_05 < var_02) {
      var_01 = var_04;
      var_02 = var_05;
    }
  }

  return var_01;
}

watchearlyexit(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  self endon("leaving");
  var_00 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_00 waittill("killstreakExit");
  var_00 thread helipilot_leave();
}
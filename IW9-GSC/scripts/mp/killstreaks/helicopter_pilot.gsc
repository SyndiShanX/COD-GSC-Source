/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\helicopter_pilot.gsc
*******************************************************/

init() {
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
  level.heli_pilot_mesh = scripts\cp_mp\utility\game_utility::getlocaleent("heli_pilot_mesh");

  if(!isDefined(level.heli_pilot_mesh)) {} else
    level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset();

  config = spawnStruct();
  config.scorepopup = "destroyed_helo_pilot";
  config.vodestroyed = undefined;
  config.callout = "callout_destroyed_helo_pilot";
  config.samdamagescale = 0.09;
  config.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_pilot"] = config;
}

tryusehelipilot(lifeid, streakname) {
  helipilottype = "heli_pilot";
  _id_4440147083ABAF0A = 1;

  if(isDefined(self.underwater) && self.underwater)
    return 0;
  else if(exceededmaxhelipilots(self.team)) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + _id_4440147083ABAF0A >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  heli = createhelipilot(helipilottype);

  if(!isDefined(heli)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return 0;
  }

  level.heli_pilot[self.team] = heli;
  result = starthelipilot(heli);

  if(!isDefined(result))
    result = 0;

  return result;
}

exceededmaxhelipilots(team) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level.heli_pilot[team]) || isDefined(level.heli_pilot[scripts\mp\utility\game::getotherteam(team)[0]]))
      return 1;
    else
      return 0;
  } else if(isDefined(level.heli_pilot[team]))
    return 1;
  else
    return 0;
}

watchhostmigrationfinishedinit(player) {
  player endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    player setclientomnvar("ui_heli_pilot", 1);
  }
}

createhelipilot(helipilottype) {
  _id_0071306135050DE8 = helipilot_getcloseststartnode(self.origin);
  _id_D6EB01B1DC33FFDC = helipilot_getlinkedstruct(_id_0071306135050DE8);
  startang = vectortoangles(_id_D6EB01B1DC33FFDC.origin - _id_0071306135050DE8.origin);
  forward = anglesToForward(self.angles);
  targetpos = _id_D6EB01B1DC33FFDC.origin + forward * -100;
  startpos = _id_0071306135050DE8.origin;
  heli = spawnhelicopter(self, startpos, startang, level.helipilotsettings[helipilottype].vehicleinfo, level.helipilotsettings[helipilottype].modelbase);

  if(!isDefined(heli)) {
    return;
  }
  heli makevehiclesolidcapsule(18, -9, 18);
  heli scripts\mp\utility\killstreak::addtolittlebirdlist(heli getentitynumber());
  heli thread scripts\mp\utility\killstreak::removefromlittlebirdlistondeath(heli getentitynumber());
  heli.maxhealth = level.helipilotsettings[helipilottype].maxhealth;
  heli.speed = 40;
  heli.owner = self;
  heli setotherent(self);
  heli.team = self.team;
  heli.helitype = "littlebird";
  heli.helipilottype = "heli_pilot";
  heli setmaxpitchroll(45, 45);
  heli vehicle_setspeed(heli.speed, 40, 40);
  heli setyawspeed(120, 60);
  heli setneargoalnotifydist(32);
  heli sethoverparams(100, 100, 100);
  heli scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  heli.targetpos = targetpos;
  heli.currentnode = _id_D6EB01B1DC33FFDC;
  heli.attract_strength = 10000;
  heli.attract_range = 150;
  heli.attractor = missile_createattractorent(heli, heli.attract_strength, heli.attract_range);
  heli thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("heli_pilot");
  heli thread helipilot_lightfx();
  heli thread helipilot_watchtimeout();
  heli thread helipilot_watchownerloss();
  heli thread helipilot_watchroundend();
  heli thread helipilot_watchobjectivecam();
  heli thread helipilot_watchdeath();
  heli thread watchhostmigrationfinishedinit(self);
  heli.owner scripts\common\utility::trycall(level.matchdata_logkillstreakevent, level.helipilotsettings[heli.helipilottype].streakname, heli.targetpos);
  return heli;
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

starthelipilot(heli) {
  level endon("game_ended");
  heli endon("death");
  scripts\mp\utility\player::setusingremote(heli.helipilottype);

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\player::setthirdpersondof(0);

  self.restoreangles = self.angles;
  heli thread scripts\mp\killstreaks\flares::ks_setup_manual_flares(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread watchintrocleared(heli);
  scripts\mp\utility\player::_freezecontrols(1, undefined, "heliStartRide");
  result = scripts\mp\killstreaks\killstreaks::initridekillstreak(heli.helipilottype);

  if(result != "success") {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ride_killstreak");
    heli notify("death");
    return 0;
  }

  scripts\mp\utility\player::_freezecontrols(0, undefined, "heliStartRide");
  _id_5985D426AA39D205 = scripts\mp\utility\killstreak::gethelipilottraceoffset();
  tracestart = heli.currentnode.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() + _id_5985D426AA39D205);
  _id_8B39E5984DA1FFAF = heli.currentnode.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() - _id_5985D426AA39D205);
  _id_1F0571D36D0DF95B = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 0, undefined, 0, 0, 1);

  if(!isDefined(_id_1F0571D36D0DF95B["entity"])) {}

  targetorigin = _id_1F0571D36D0DF95B["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + (0, 0, 250);
  targetnode = spawn("script_origin", targetorigin);
  self remotecontrolvehicle(heli);
  heli thread heligotostartposition(targetnode);
  heli thread helipilot_watchads();
  level thread scripts\mp\hud_util::teamplayercardsplash(level.helipilotsettings[heli.helipilottype].teamsplash, self);
  heli.killcament = spawn("script_origin", self getvieworigin());
  return 1;
}

heligotostartposition(targetnode) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(targetnode);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  targetnode delete();
}

watchintrocleared(heli) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  heli endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  id = scripts\mp\utility\outline::outlineenableforplayer(self, self, "outline_nodepth_cyan", "killstreak");
  removeoutline(id, heli);

  foreach(player in level.participants) {
    if(!scripts\mp\utility\player::isreallyalive(player) || player.sessionstate != "playing") {
      continue;
    }
    if(scripts\cp_mp\utility\player_utility::isenemy(player)) {
      if(!player scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
        id = scripts\mp\utility\outline::outlineenableforplayer(player, self, "outline_nodepth_orange", "killstreak");
        player removeoutline(id, heli);
        continue;
      }

      player thread watchforperkremoval(heli);
    }
  }

  heli thread watchplayersspawning();
  thread watchearlyexit(heli);
}

watchforperkremoval(heli) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  id = scripts\mp\utility\outline::outlineenableforplayer(self, heli.owner, "outline_nodepth_orange", "killstreak");
  removeoutline(id, heli);
}

watchplayersspawning() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    level waittill("player_spawned", player);

    if(player.sessionstate == "playing" && self.owner scripts\cp_mp\utility\player_utility::isenemy(player))
      player thread watchforperkremoval(self);
  }
}

removeoutline(id, heli) {
  thread heliremoveoutline(id, heli);
  thread playerremoveoutline(id, heli);
}

heliremoveoutline(id, heli) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  _id_819382A0FC083B42 = ["leaving", "death"];
  heli scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_819382A0FC083B42);

  if(isDefined(self)) {
    scripts\mp\utility\outline::outlinedisable(id, self);
    self notify("outline_removed");
  }
}

playerremoveoutline(id, heli) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  _id_819382A0FC083B42 = ["death"];
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_819382A0FC083B42);
  scripts\mp\utility\outline::outlinedisable(id, self);
  self notify("outline_removed");
}

helipilot_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(isDefined(self.owner))
    self.owner helipilot_endride(self);

  if(isDefined(self.killcament))
    self.killcament delete();

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

  if(isDefined(self.owner))
    self.owner helipilot_endride(self);
}

helipilot_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  timeout = level.helipilotsettings[self.helipilottype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timeout);
  thread helipilot_leave();
}

helipilot_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread helipilot_leave();
}

helipilot_watchroundend() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level scripts\engine\utility::waittill_any_2("round_end_finished", "game_ended");
  thread helipilot_leave();
}

helipilot_leave() {
  self endon("death");
  self notify("leaving");

  if(isDefined(self.owner))
    self.owner helipilot_endride(self);

  targetpos = self.origin + (0, 0, 850);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(targetpos);
  self waittill("goal");
  targetpos = targetpos + anglesToForward(self.angles) * 15000;
  _id_60347FD2432F3A63 = spawn("script_origin", targetpos);

  if(isDefined(_id_60347FD2432F3A63)) {
    self setlookatent(_id_60347FD2432F3A63);
    _id_60347FD2432F3A63 thread wait_and_delete(3.0);
  }

  self setvehgoalpos(targetpos);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\helicopter::removelittlebird();
}

wait_and_delete(waittime) {
  self endon("death");
  level endon("game_ended");
  wait(waittime);
  self delete();
}

helipilot_endride(heli) {
  if(isDefined(heli)) {
    self setclientomnvar("ui_heli_pilot", 0);
    heli notify("end_remote");

    if(scripts\mp\utility\player::isusingremote())
      scripts\mp\utility\player::clearusingremote();

    if(getdvarint("camera_thirdPerson"))
      scripts\mp\utility\player::setthirdpersondof(1);

    self remotecontrolvehicleoff(heli);
    self setplayerangles(self.restoreangles);
    thread helipilot_freezebuffer();
  }
}

helipilot_freezebuffer() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_freezecontrols(1, undefined, "heliEndRide");
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0, undefined, "heliEndRide");
}

helipilot_watchads() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  _id_48F5A6465CACB79C = 0;

  for(;;) {
    if(isDefined(self.owner)) {
      if(self.owner adsButtonPressed()) {
        if(!_id_48F5A6465CACB79C) {
          self.owner setclientomnvar("ui_heli_pilot", 2);
          _id_48F5A6465CACB79C = 1;
        }
      } else if(_id_48F5A6465CACB79C) {
        self.owner setclientomnvar("ui_heli_pilot", 1);
        _id_48F5A6465CACB79C = 0;
      }
    }

    wait 0.1;
  }
}

helipilot_setairstartnodes() {
  level.air_start_nodes = scripts\engine\utility::getStructArray("chopper_boss_path_start", "targetname");
}

helipilot_getlinkedstruct(struct) {
  if(isDefined(struct.script_linkto)) {
    _id_B11F91C17FEEAB8F = struct scripts\engine\utility::get_links();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B11F91C17FEEAB8F.size; _id_AC0E594AC96AA3A8++) {
      ent = scripts\engine\utility::getStruct(_id_B11F91C17FEEAB8F[_id_AC0E594AC96AA3A8], "script_linkname");

      if(isDefined(ent))
        return ent;
    }
  }

  return undefined;
}

helipilot_getcloseststartnode(pos) {
  _id_D6EB01B1DC33FFDC = undefined;
  _id_C1DA30005A22582B = 999999;

  foreach(loc in level.air_start_nodes) {
    _id_A2FBFA1AC218A716 = distance(loc.origin, pos);

    if(_id_A2FBFA1AC218A716 < _id_C1DA30005A22582B) {
      _id_D6EB01B1DC33FFDC = loc;
      _id_C1DA30005A22582B = _id_A2FBFA1AC218A716;
    }
  }

  return _id_D6EB01B1DC33FFDC;
}

watchearlyexit(heli) {
  level endon("game_ended");
  heli endon("death");
  self endon("leaving");
  heli thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  heli waittill("killstreakExit");
  heli thread helipilot_leave();
}
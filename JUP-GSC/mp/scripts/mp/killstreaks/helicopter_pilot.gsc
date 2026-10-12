/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\helicopter_pilot.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\killstreaks\helicopter;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace helicopter_pilot;

function init() {
  assertmsg("<dev string:x1c>");
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

  if(!isDefined(level.heli_pilot_mesh)) {
    println("<dev string:x7b>" + level.script);
  } else {
    level.heli_pilot_mesh.origin += gethelipilotmeshoffset();
  }

  config = spawnStruct();
  config.scorepopup = "destroyed_helo_pilot";
  config.vodestroyed = undefined;
  config.callout = "callout_destroyed_helo_pilot";
  config.samdamagescale = 0.09;
  config.enginevfxtag = "tag_engine_right";
  level.heliconfigs["heli_pilot"] = config;

  setdevdvarifuninitialized(@ "hash_9d27a693c0c7d81b", 60);
}

function tryusehelipilot(lifeid, streakname) {
  helipilottype = "heli_pilot";
  var_4440147083abaf0a = 1;

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  } else if(exceededmaxhelipilots(self.team)) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + var_4440147083abaf0a >= maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  incrementfauxvehiclecount();
  heli = createhelipilot(helipilottype);

  if(!isDefined(heli)) {
    decrementfauxvehiclecount();
    return 0;
  }

  level.heli_pilot[self.team] = heli;
  result = starthelipilot(heli);

  if(!isDefined(result)) {
    result = 0;
  }

  return result;
}

function exceededmaxhelipilots(team) {
  if(getgametype() == "dm") {
    if(isDefined(level.heli_pilot[team]) || isDefined(level.heli_pilot[getotherteam(team)[0]])) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  if(isDefined(level.heli_pilot[team])) {
    return 1;
  }

  return 0;
}

function watchhostmigrationfinishedinit(player) {
  player endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");
    player setclientomnvar("ui_heli_pilot", 1);
  }
}

function createhelipilot(helipilottype) {
  closeststartnode = helipilot_getcloseststartnode(self.origin);
  closestnode = helipilot_getlinkedstruct(closeststartnode);
  startang = vectortoangles(closestnode.origin - closeststartnode.origin);
  forward = anglesToForward(self.angles);
  targetpos = closestnode.origin + forward * -100;
  startpos = closeststartnode.origin;
  heli = spawnhelicopter(self, startpos, startang, level.helipilotsettings[helipilottype].vehicleinfo, level.helipilotsettings[helipilottype].modelbase);

  if(!isDefined(heli)) {
    return;
  }

  heli makevehiclesolidcapsule(18, -9, 18);
  heli addtolittlebirdlist(heli getentitynumber());
  heli thread removefromlittlebirdlistondeath(heli getentitynumber());
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
  heli.currentnode = closestnode;
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
  heli.owner utility::trycall(level.matchdata_logkillstreakevent, level.helipilotsettings[heli.helipilottype].streakname, heli.targetpos);
  return heli;
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

function starthelipilot(heli) {
  level endon("game_ended");
  heli endon("death");
  setusingremote(heli.helipilottype);

  if(getdvarint(@ "camera_thirdperson")) {
    setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  heli thread scripts\mp\killstreaks\flares::ks_setup_manual_flares(2, "+smoke", "ui_heli_pilot_flare_ammo", "ui_heli_pilot_warn");
  thread watchintrocleared(heli);
  _freezecontrols(1, undefined, "heliStartRide");
  result = scripts\mp\killstreaks\killstreaks::initridekillstreak(heli.helipilottype);

  if(result != "success") {
    val::reset_all("ride_killstreak");
    heli notify("death");
    return false;
  }

  _freezecontrols(0, undefined, "heliStartRide");
  traceoffset = gethelipilottraceoffset();
  tracestart = heli.currentnode.origin + gethelipilotmeshoffset() + traceoffset;
  traceend = heli.currentnode.origin + gethelipilotmeshoffset() - traceoffset;
  traceresult = scripts\engine\trace::_bullet_trace(tracestart, traceend, 0, undefined, 0, 0, 1);

  if(!isDefined(traceresult["entity"])) {
    thread drawsphere(traceresult["<dev string:xac>"] - gethelipilotmeshoffset(), 32, 10000, (1, 0, 0));
    thread drawsphere(heli.currentnode.origin, 16, 10000, (0, 1, 0));
    thread drawline(tracestart - gethelipilotmeshoffset(), traceend - gethelipilotmeshoffset(), 10000, (0, 0, 1));

    assertmsg("<dev string:xb8>");
  }

  targetorigin = traceresult["position"] - gethelipilotmeshoffset() + (0, 0, 250);
  targetnode = spawn("script_origin", targetorigin);
  self remotecontrolvehicle(heli);
  heli thread heligotostartposition(targetnode);
  heli thread helipilot_watchads();
  level thread teamplayercardsplash(level.helipilotsettings[heli.helipilottype].teamsplash, self);
  heli.killcament = spawn("script_origin", self getvieworigin());
  return true;
}

function heligotostartposition(targetnode) {
  self endon("death");
  level endon("game_ended");
  self remotecontrolvehicletarget(targetnode);
  self waittill("goal_reached");
  self remotecontrolvehicletargetoff();
  targetnode delete();
}

function watchintrocleared(heli) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  heli endon("death");
  self waittill("intro_cleared");
  self setclientomnvar("ui_heli_pilot", 1);
  id = outlineenableforplayer(self, self, "outline_nodepth_cyan", "killstreak");
  removeoutline(id, heli);

  foreach(player in level.participants) {
    if(!isreallyalive(player) || player.sessionstate != "playing") {
      continue;
    }

    if(scripts\cp_mp\utility\player_utility::isenemy(player)) {
      if(!player _hasperk("specialty_noplayertarget")) {
        id = outlineenableforplayer(player, self, "outline_nodepth_orange", "killstreak");
        player removeoutline(id, heli);
        continue;
      }

      player thread watchforperkremoval(heli);
    }
  }

  heli thread watchplayersspawning();
  thread watchearlyexit(heli);
}

function watchforperkremoval(heli) {
  self notify("watchForPerkRemoval");
  self endon("watchForPerkRemoval");
  self endon("death");
  self waittill("removed_specialty_noplayertarget");
  id = outlineenableforplayer(self, heli.owner, "outline_nodepth_orange", "killstreak");
  removeoutline(id, heli);
}

function watchplayersspawning() {
  self endon("leaving");
  self endon("death");

  while(true) {
    level waittill("player_spawned", player);

    if(player.sessionstate == "playing" && self.owner scripts\cp_mp\utility\player_utility::isenemy(player)) {
      player thread watchforperkremoval(self);
    }
  }
}

function removeoutline(id, heli) {
  thread heliremoveoutline(id, heli);
  thread playerremoveoutline(id, heli);
}

function heliremoveoutline(id, heli) {
  self notify("heliRemoveOutline");
  self endon("heliRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  wait_array = ["leaving", "death"];
  heli waittill_any_in_array_return_no_endon_death(wait_array);

  if(isDefined(self)) {
    outlinedisable(id, self);
    self notify("outline_removed");
  }
}

function playerremoveoutline(id, heli) {
  self notify("playerRemoveOutline");
  self endon("playerRemoveOutline");
  self endon("outline_removed");
  self endon("disconnect");
  level endon("game_ended");
  wait_array = ["death"];
  waittill_any_in_array_return_no_endon_death(wait_array);
  outlinedisable(id, self);
  self notify("outline_removed");
}

function helipilot_watchdeath() {
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

function helipilot_watchobjectivecam() {
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

function helipilot_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  timeout = level.helipilotsettings[self.helipilottype].timeout;

  timeout = getdvarfloat(@ "hash_9d27a693c0c7d81b");

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timeout);
  thread helipilot_leave();
}

function helipilot_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread helipilot_leave();
}

function helipilot_watchroundend() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level waittill_any_2("round_end_finished", "game_ended");
  thread helipilot_leave();
}

function helipilot_leave() {
  self endon("death");
  self notify("leaving");

  if(isDefined(self.owner)) {
    self.owner helipilot_endride(self);
  }

  targetpos = self.origin + (0, 0, 850);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(targetpos);
  self waittill("goal");
  targetpos += anglesToForward(self.angles) * 15000;
  endent = spawn("script_origin", targetpos);

  if(isDefined(endent)) {
    self setlookatent(endent);
    endent thread wait_and_delete(3);
  }

  self setvehgoalpos(targetpos);
  self waittill("goal");
  self notify("gone");
  scripts\mp\killstreaks\helicopter::removelittlebird();
}

function wait_and_delete(waittime) {
  self endon("death");
  level endon("game_ended");
  wait waittime;
  self delete();
}

function helipilot_endride(heli) {
  if(isDefined(heli)) {
    self setclientomnvar("ui_heli_pilot", 0);
    heli notify("end_remote");

    if(isusingremote()) {
      clearusingremote();
    }

    if(getdvarint(@ "camera_thirdperson")) {
      setthirdpersondof(1);
    }

    self remotecontrolvehicleoff(heli);
    self setplayerangles(self.restoreangles);
    thread helipilot_freezebuffer();
  }
}

function helipilot_freezebuffer() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _freezecontrols(1, undefined, "heliEndRide");
  wait 0.5;
  _freezecontrols(0, undefined, "heliEndRide");
}

function helipilot_watchads() {
  self endon("leaving");
  self endon("death");
  level endon("game_ended");
  already_set = 0;

  while(true) {
    if(isDefined(self.owner)) {
      if(self.owner adsButtonPressed()) {
        if(!already_set) {
          self.owner setclientomnvar("ui_heli_pilot", 2);
          already_set = 1;
        }
      } else if(already_set) {
        self.owner setclientomnvar("ui_heli_pilot", 1);
        already_set = 0;
      }
    }

    wait 0.1;
  }
}

function helipilot_setairstartnodes() {
  level.air_start_nodes = getStructArray("chopper_boss_path_start", "targetname");
}

function helipilot_getlinkedstruct(struct) {
  if(isDefined(struct.script_linkto)) {
    linknames = struct get_links();

    for(i = 0; i < linknames.size; i++) {
      ent = getStruct(linknames[i], "script_linkname");

      if(isDefined(ent)) {
        return ent;
      }
    }
  }

  return undefined;
}

function helipilot_getcloseststartnode(pos) {
  closestnode = undefined;
  closestdistance = 999999;

  foreach(loc in level.air_start_nodes) {
    nodedistance = distance(loc.origin, pos);

    if(nodedistance < closestdistance) {
      closestnode = loc;
      closestdistance = nodedistance;
    }
  }

  return closestnode;
}

function watchearlyexit(heli) {
  level endon("game_ended");
  heli endon("death");
  self endon("leaving");
  heli thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  heli waittill("killstreakExit");
  heli thread helipilot_leave();
}
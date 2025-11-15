/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_planemortar.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_challenges;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_satellite;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#namespace planemortar;

function init() {
  level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
  clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int");
  killstreaks::register("planemortar", "planemortar", "killstreak_planemortar", "planemortar_used", & usekillstreakplanemortar, 1);
  killstreaks::register_strings("planemortar", & "MP_EARNED_PLANEMORTAR", & "KILLSTREAK_PLANEMORTAR_NOT_AVAILABLE", & "MP_WAR_PLANEMORTAR_INBOUND", & "MP_WAR_PLANEMORTAR_INBOUND_NEAR_YOUR_POSITION", & "KILLSTREAK_PLANEMORTAR_HACKED");
  killstreaks::register_dialog("planemortar", "mpl_killstreak_planemortar", "planeMortarDialogBundle", "planeMortarPilotDialogBundle", "friendlyPlaneMortar", "enemyPlaneMortar", "enemyPlaneMortarMultiple", "friendlyPlaneMortarHacked", "enemyPlaneMortarHacked", "requestPlaneMortar");
  killstreaks::set_team_kill_penalty_scale("planemortar", level.teamkillreducedpenalty);
}

function usekillstreakplanemortar(hardpointtype) {
  if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
    return false;
  }
  result = self selectplanemortarlocation(hardpointtype);
  if(!isDefined(result) || !result) {
    return false;
  }
  return true;
}

function waittill_confirm_location() {
  self endon("emp_jammed");
  self endon("emp_grenaded");
  self waittill("confirm_location", location);
  return location;
}

function selectplanemortarlocation(hardpointtype) {
  self beginlocationmortarselection("map_mortar_selector", 800, "map_mortar_selector_done");
  self.selectinglocation = 1;
  self thread airsupport::endselectionthink();
  locations = [];
  if(!isDefined(self.pers["mortarRadarUsed"]) || !self.pers["mortarRadarUsed"]) {
    self thread singleradarsweep();
    otherteam = util::getotherteam(self.team);
    globallogic_audio::leader_dialog("enemyPlaneMortarUsed", otherteam);
  }
  for(i = 0; i < 3; i++) {
    location = self waittill_confirm_location();
    if(!isDefined(self)) {
      return 0;
    }
    if(!isDefined(location)) {
      self.pers["mortarRadarUsed"] = 1;
      self notify("cancel_selection");
      return 0;
    }
    locations[i] = location;
  }
  if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
    self.pers["mortarRadarUsed"] = 1;
    self notify("cancel_selection");
    return 0;
  }
  self.pers["mortarRadarUsed"] = 0;
  return self airsupport::finishhardpointlocationusage(locations, & useplanemortar);
}

function waitplaybacktime(soundalias) {
  self endon("death");
  self endon("disconnect");
  playbacktime = soundgetplaybacktime(soundalias);
  if(playbacktime >= 0) {
    waittime = playbacktime * 0.001;
    wait(waittime);
  } else {
    wait(1);
  }
  self notify(soundalias);
}

function singleradarsweep() {
  self endon("disconnect");
  self endon("cancel_selection");
  wait(0.5);
  self playlocalsound("mpl_killstreak_satellite");
  if(level.teambased) {
    has_satellite = satellite::hassatellite(self.team);
  } else {
    has_satellite = satellite::hassatellite(self.entnum);
  }
  if(self.hasspyplane == 0 && !has_satellite && !level.forceradar) {
    self thread doradarsweep();
  }
}

function doradarsweep() {
  self setclientuivisibilityflag("g_compassShowEnemies", 1);
  wait(0.2);
  self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

function useplanemortar(positions) {
  team = self.team;
  killstreak_id = self killstreakrules::killstreakstart("planemortar", team, 0, 1);
  if(killstreak_id == -1) {
    return false;
  }
  self killstreaks::play_killstreak_start_dialog("planemortar", team, killstreak_id);
  self.planemortarpilotindex = killstreaks::get_random_pilot_index("planemortar");
  self killstreaks::play_pilot_dialog("arrive", "planemortar", undefined, self.planemortarpilotindex);
  self addweaponstat(getweapon("planemortar"), "used", 1);
  self thread planemortar_watchforendnotify(team, killstreak_id);
  self thread doplanemortar(positions, team, killstreak_id);
  return true;
}

function doplanemortar(positions, team, killstreak_id) {
  self endon("emp_jammed");
  self endon("disconnect");
  yaw = randomintrange(0, 360);
  odd = 0;
  wait(1.25);
  foreach(position in positions) {
    level spawning::create_enemy_influencer("artillery", position, team);
    self thread dobombrun(position, yaw, team);
    if(odd == 0) {
      yaw = (yaw + 35) % 360;
    } else {
      yaw = (yaw + 290) % 360;
    }
    odd = (odd + 1) % 2;
    wait(0.8);
  }
  self notify("planemortarcomplete");
  wait(1);
  self thread plane_mortar_bda_dialog();
}

function plane_mortar_bda_dialog() {
  if(isDefined(self.planemortarbda)) {
    if(self.planemortarbda === 1) {
      bdadialog = "kill1";
    } else {
      if(self.planemortarbda === 2) {
        bdadialog = "kill2";
      } else {
        if(self.planemortarbda === 3) {
          bdadialog = "kill3";
        } else if(isDefined(self.planemortarbda) && self.planemortarbda > 3) {
          bdadialog = "killMultiple";
        }
      }
    }
    self killstreaks::play_pilot_dialog(bdadialog, "planemortar", undefined, self.planemortarpilotindex);
    if(battlechatter::dialog_chance("taacomPilotKillConfirmChance")) {
      self killstreaks::play_taacom_dialog_response("killConfirmed", "planemortar", undefined, self.planemortarpilotindex);
    } else {
      self globallogic_audio::play_taacom_dialog("confirmHit");
    }
  } else {
    killstreaks::play_pilot_dialog("killNone", "planemortar", undefined, self.planemortarpilotindex);
    globallogic_audio::play_taacom_dialog("confirmMiss");
  }
  self.planemortarbda = undefined;
}

function planemortar_watchforendnotify(team, killstreak_id) {
  self util::waittill_any("disconnect", "joined_team", "joined_spectators", "planemortarcomplete", "emp_jammed");
  planemortar_killstreakstop(team, killstreak_id);
}

function planemortar_killstreakstop(team, killstreak_id) {
  killstreakrules::killstreakstop("planemortar", team, killstreak_id);
}

function dobombrun(position, yaw, team) {
  self endon("emp_jammed");
  player = self;
  angles = (0, yaw, 0);
  direction = anglesToForward(angles);
  height = airsupport::getminimumflyheight() + 2000;
  position = (position[0], position[1], height);
  startpoint = position + (vectorscale(direction, -12000));
  endpoint = position + vectorscale(direction, 18000);
  height = airsupport::getnoflyzoneheightcrossed(startpoint, endpoint, height);
  startpoint = (startpoint[0], startpoint[1], height);
  position = (position[0], position[1], height);
  endpoint = (endpoint[0], endpoint[1], height);
  plane = spawnplane(self, "script_model", startpoint);
  plane.team = team;
  plane.targetname = "plane_mortar";
  plane.owner = self;
  plane endon("delete");
  plane endon("death");
  plane thread planewatchforemp(self);
  plane.angles = angles;
  plane setModel("veh_t7_mil_vtol_fighter_mp");
  plane setenemymodel("veh_t7_mil_vtol_fighter_mp_dark");
  plane clientfield::set("planemortar_contrail", 1);
  plane clientfield::set("enemyvehicle", 1);
  plane playSound("mpl_lightning_flyover_boom");
  plane setdrawinfrared(1);
  plane.killcament = spawn("script_model", (plane.origin + vectorscale((0, 0, 1), 700)) + (vectorscale(direction, -1500)));
  plane.killcament util::deleteaftertime(2 * 3);
  plane.killcament.angles = (15, yaw, 0);
  plane.killcament.starttime = gettime();
  plane.killcament linkto(plane);
  start = (position[0], position[1], plane.origin[2]);
  impact = bulletTrace(start, start + (vectorscale((0, 0, -1), 100000)), 1, plane);
  plane moveto(endpoint, (2 * 5) / 4, 0, 0);
  plane.killcament thread followbomb(plane, position, direction, impact, player);
  wait(2 / 2);
  if(isDefined(self)) {
    self thread dropbomb(plane, position);
  }
  wait((2 * 3) / 4);
  plane plane_cleanupondeath();
}

function followbomb(plane, position, direction, impact, player) {
  player endon("emp_jammed");
  wait((2 * 5) / 12);
  plane.killcament unlink();
  plane.killcament moveto((impact["position"] + vectorscale((0, 0, 1), 1000)) + (vectorscale(direction, -600)), 0.8, 0, 0.2);
}

function lookatexplosion(bomb) {
  while(isDefined(self) && isDefined(bomb)) {
    angles = vectortoangles(vectornormalize(bomb.origin - self.origin));
    self.angles = (max(angles[0], 15), angles[1], angles[2]);
    wait(0.05);
  }
}

function planewatchforemp(owner) {
  self endon("delete");
  self endon("death");
  self waittill("emp_deployed", attacker);
  thread planeawardscoreevent(attacker, self);
  self plane_cleanupondeath();
}

function planeawardscoreevent(attacker, plane) {
  attacker endon("disconnect");
  attacker notify("planeawardscoreevent_singleton");
  attacker endon("planeawardscoreevent_singleton");
  waittillframeend();
  if(isDefined(attacker) && (!isDefined(plane.owner) || plane.owner util::isenemyplayer(attacker))) {
    challenges::destroyedaircraft(attacker, getweapon("emp"), 0);
    scoreevents::processscoreevent("destroyed_plane_mortar", attacker, plane.owner, getweapon("emp"));
    attacker challenges::addflyswatterstat(getweapon("emp"), plane);
  }
}

function plane_cleanupondeath() {
  self delete();
}

function dropbomb(plane, bombposition) {
  if(!isDefined(plane.owner)) {
    return;
  }
  targets = getplayers();
  foreach(target in targets) {
    if(plane.owner util::isenemyplayer(target) && distance2dsquared(target.origin, bombposition) < 250000) {
      if(bullettracepassed((target.origin[0], target.origin[1], plane.origin[2]), target.origin, 0, plane)) {
        bombposition = target.origin;
        break;
      }
    }
  }
  bombposition = (bombposition[0], bombposition[1], plane.origin[2]);
  bomb = self launchbomb(getweapon("planemortar"), bombposition, vectorscale((0, 0, -1), 5000));
  bomb.soundmod = "heli";
  bomb playSound("mpl_lightning_bomb_incoming");
  bomb.killcament = plane.killcament;
  plane.killcament thread lookatexplosion(bomb);
}
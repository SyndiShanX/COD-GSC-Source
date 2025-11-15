/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\planemortar_shared.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;

#namespace planemortar;

init_shared() {
  if(!isDefined(level.planemortar_shared)) {
    level.planemortar_shared = {};
    airsupport::init_shared();
    level.planemortarexhaustfx = "killstreaks/fx8_mortar_jet_thrusters";
    level.var_913789d7 = "killstreaks/fx8_mortar_jet_contrails";
    clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int");
  }
}

usekillstreakplanemortar(hardpointtype) {
  if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
    return false;
  }

  result = self selectplanemortarlocation(hardpointtype);

  if(!isDefined(result) || !result) {
    return false;
  }

  return true;
}

waittill_confirm_location() {
  self endon(#"emp_jammed", #"emp_grenaded");
  waitresult = self waittill(#"confirm_location");
  return waitresult.position;
}

function_a3cb6b44() {
  self beginlocationmortarselection("map_mortar_selector", 800, "map_mortar_selector_done", "map_mortar_selector_radius");
}

selectplanemortarlocation(hardpointtype) {
  if(isDefined(level.var_30264985)) {
    waitresult = self waittill(#"weapon_change", #"weapon_change_complete");
  }

  self airsupport::function_9e2054b0(&function_a3cb6b44);
  locations = [];

  if(!isDefined(self.pers[#"mortarradarused"]) || !self.pers[#"mortarradarused"]) {
    self thread singleradarsweep();
  }

  if(isDefined(level.var_269fec2)) {
    self[[level.var_269fec2]]();
  }

  for(i = 0; i < 3; i++) {
    location = self airsupport::waitforlocationselection();

    if(!isDefined(self)) {
      return 0;
    }

    if(!isDefined(location.origin)) {
      self.pers[#"mortarradarused"] = 1;
      self notify(#"cancel_selection");
      return 0;
    }

    locations[i] = location;
  }

  if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
    self.pers[#"mortarradarused"] = 1;
    self notify(#"cancel_selection");
    return 0;
  }

  self.pers[#"mortarradarused"] = 0;
  return self airsupport::function_83904681(locations, &useplanemortar, "planemortar");
}

waitplaybacktime(soundalias) {
  self endon(#"death", #"disconnect");
  playbacktime = soundgetplaybacktime(soundalias);

  if(playbacktime >= 0) {
    waittime = playbacktime * 0.001;
    wait waittime;
  } else {
    wait 1;
  }

  self notify(soundalias);
}

singleradarsweep() {
  self endon(#"disconnect", #"cancel_selection");
  wait 0.5;
  self playlocalsound(#"mpl_killstreak_satellite");

  if(self.hasspyplane == 0 && !level.forceradar) {
    self thread doradarsweep();
  }
}

doradarsweep() {
  self setclientuivisibilityflag("g_compassShowEnemies", 1);
  wait 0.2;
  self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

useplanemortar(positions, killstreak_id) {
  team = self.team;
  self.planemortarpilotindex = killstreaks::get_random_pilot_index("planemortar");
  self killstreaks::play_pilot_dialog("arrive", "planemortar", undefined, self.planemortarpilotindex);
  self thread planemortar_watchforendnotify(team, killstreak_id);
  self thread doplanemortar(positions, team, killstreak_id);
  return true;
}

doplanemortar(positions, team, killstreak_id) {
  self endon(#"emp_jammed", #"disconnect");
  yaw = randomintrange(0, 360);
  odd = 0;
  wait 1;

  foreach(position in positions) {
    level influencers::create_enemy_influencer("artillery", position.origin, team);
    self thread dobombrun(position.origin, yaw, team);

    if(odd == 0) {
      yaw = (yaw + 35) % 360;
    } else {
      yaw = (yaw + 290) % 360;
    }

    odd = (odd + 1) % 2;
    wait 0.8;
  }

  self notify(#"planemortarcomplete");
  wait 1;

  if(isDefined(level.plane_mortar_bda_dialog)) {
    self thread[[level.plane_mortar_bda_dialog]]();
  }
}

planemortar_watchforendnotify(team, killstreak_id) {
  self waittill(#"disconnect", #"joined_team", #"joined_spectators", #"planemortarcomplete", #"emp_jammed");
  planemortar_killstreakstop(team, killstreak_id);
}

planemortar_killstreakstop(team, killstreak_id) {
  killstreakrules::killstreakstop("planemortar", team, killstreak_id);
}

dobombrun(position, yaw, team) {
  self endon(#"emp_jammed");
  player = self;
  angles = (0, yaw, 0);
  direction = anglesToForward(angles);
  height = airsupport::getminimumflyheight() + 2000 + randomfloatrange(-200, 200);
  position = (position[0] + randomfloat(30), position[1] + randomfloat(30), height);
  startpoint = position + vectorscale(direction, -12000);
  endpoint = position + vectorscale(direction, 18000);
  height = airsupport::getnoflyzoneheightcrossed(startpoint, endpoint, height);
  height += randomfloatrange(-200, 200);
  startpoint = (startpoint[0], startpoint[1], height);
  position = (position[0], position[1], height);
  endpoint = (endpoint[0], endpoint[1], height);
  plane = spawn("script_model", startpoint);
  plane.weapon = getweapon("planemortar");
  plane setweapon(plane.weapon);
  plane.team = team;
  plane setteam(team);
  plane.targetname = "plane_mortar";
  plane setowner(self);
  plane.owner = self;
  plane endon(#"delete", #"death");
  plane thread planewatchforemp(self);
  plane.angles = angles;
  plane setModel("veh_t8_mil_air_jet_fighter_mp_light");
  plane setenemymodel("veh_t8_mil_air_jet_fighter_mp_dark");
  plane clientfield::set("planemortar_contrail", 1);
  plane clientfield::set("enemyvehicle", 1);
  plane playSound(#"mpl_lightning_flyover_boom");
  plane setdrawinfrared(1);
  plane.killcament = spawn("script_model", plane.origin + (0, 0, 700) + vectorscale(direction, -1500));
  plane.killcament util::deleteaftertime(2 * 3);
  plane.killcament.angles = (15, yaw, 0);
  plane.killcament.starttime = gettime();
  plane.killcament linkto(plane);
  start = (position[0], position[1], plane.origin[2]);
  impact = bulletTrace(start, start + (0, 0, -100000), 1, plane);
  plane moveto(endpoint, 2 * 5 / 4, 0, 0);
  plane.killcament thread followbomb(plane, position, direction, impact, player);
  wait 2 / 2;

  if(isDefined(self)) {
    self thread dropbomb(plane, position);
  }

  wait 2 * 3 / 4;
  plane plane_cleanupondeath();
}

followbomb(plane, position, direction, impact, player) {
  player endon(#"emp_jammed");
  wait 2 * 5 / 12;
  plane.killcament unlink();
  plane.killcament moveto(impact[#"position"] + (0, 0, 1000) + vectorscale(direction, -600), 0.8, 0, 0.2);
}

lookatexplosion(bomb) {
  while(isDefined(self) && isDefined(bomb)) {
    angles = vectortoangles(vectornormalize(bomb.origin - self.origin));
    self.angles = (max(angles[0], 15), angles[1], angles[2]);
    waitframe(1);
  }
}

planewatchforemp(owner) {
  self endon(#"delete", #"death");
  waitresult = self waittill(#"emp_deployed");

  if(isDefined(level.planeawardscoreevent)) {
    thread[[level.planeawardscoreevent]](waitresult.attacker, self);
  }

  self plane_cleanupondeath();
}

plane_cleanupondeath() {
  self delete();
}

dropbomb(plane, bombposition) {
  if(!isDefined(plane.owner)) {
    return;
  }

  z = bombposition[2];
  targets = getplayers();

  foreach(target in targets) {
    if(plane.owner util::isenemyplayer(target) && distance2dsquared(target.origin, bombposition) < 250000) {
      if(bullettracepassed((target.origin[0], target.origin[1], plane.origin[2]), target.origin, 0, plane)) {
        bombposition = target.origin;
        break;
      }
    }
  }

  bombposition = (bombposition[0], bombposition[1], z - 100);
  bomb = self magicmissile(getweapon("planemortar"), bombposition, (0, 0, -5000));
  bomb.soundmod = "heli";
  bomb playSound(#"mpl_lightning_bomb_incoming");
  bomb.killcament = plane.killcament;
  plane.killcament thread lookatexplosion(bomb);
}
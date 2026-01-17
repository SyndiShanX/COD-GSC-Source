/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_counteruav.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_helicopter;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_satellite;
#using scripts\mp\teams\_teams;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_heatseekingmissile;
#using scripts\shared\weapons\_weaponobjects;
#namespace counteruav;

function init() {
  level.activecounteruavs = [];
  level.counter_uav_positions = generaterandompoints(20);
  level.counter_uav_position_index = [];
  level.counter_uav_offsets = buildoffsetlist((0, 0, 0), 3, 450, 450);
  if(level.teambased) {
    foreach(team in level.teams) {
      level.activecounteruavs[team] = 0;
      level.counter_uav_position_index[team] = 0;
      level thread movementmanagerthink(team);
    }
  } else {
    level.activecounteruavs = [];
  }
  level.activeplayercounteruavs = [];
  level.counter_uav_entities = [];
  if(tweakables::gettweakablevalue("killstreak", "allowcounteruav")) {
    killstreaks::register("counteruav", "counteruav", "killstreak_counteruav", "counteruav_used", &activatecounteruav);
    killstreaks::register_strings("counteruav", &"KILLSTREAK_EARNED_COUNTERUAV", &"KILLSTREAK_COUNTERUAV_NOT_AVAILABLE", &"KILLSTREAK_COUNTERUAV_INBOUND", undefined, &"KILLSTREAK_COUNTERUAV_HACKED");
    killstreaks::register_dialog("counteruav", "mpl_killstreak_radar", "counterUavDialogBundle", "counterUavPilotDialogBundle", "friendlyCounterUav", "enemyCounterUav", "enemyCounterUavMultiple", "friendlyCounterUavHacked", "enemyCounterUavHacked", "requestCounterUav", "threatCounterUav");
  }
  clientfield::register("toplayer", "counteruav", 1, 1, "int");
  level thread watchcounteruavs();
  callback::on_connect(&onplayerconnect);
  callback::on_spawned(&onplayerspawned);
  callback::on_joined_team(&onplayerjoinedteam);
  if(getdvarint("")) {
    level thread waitanddebugdrawoffsetlist();
  }
}

function onplayerconnect() {
  self.entnum = self getentitynumber();
  if(!level.teambased) {
    level.activecounteruavs[self.entnum] = 0;
    level.counter_uav_position_index[self.entnum] = 0;
    self thread movementmanagerthink(self.entnum);
  }
  level.activeplayercounteruavs[self.entnum] = 0;
}

function onplayerspawned() {
  if(self enemycounteruavactive()) {
    self clientfield::set_to_player("counteruav", 1);
  } else {
    self clientfield::set_to_player("counteruav", 0);
  }
}

function generaterandompoints(count) {
  points = [];
  for(i = 0; i < count; i++) {
    point = airsupport::getrandommappoint((isDefined(level.cuav_map_x_offset) ? level.cuav_map_x_offset : 0), (isDefined(level.cuav_map_y_offset) ? level.cuav_map_y_offset : 0), (isDefined(level.cuav_map_x_percentage) ? level.cuav_map_x_percentage : 0.5), (isDefined(level.cuav_map_y_percentage) ? level.cuav_map_y_percentage : 0.5));
    minflyheight = airsupport::getminimumflyheight();
    point = point + (0, 0, minflyheight + (isDefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000));
    points[i] = point;
  }
  return points;
}

function movementmanagerthink(teamorentnum) {
  while(true) {
    level waittill("counter_uav_updated");
    activecount = 0;
    while(level.activecounteruavs[teamorentnum] > 0) {
      if(activecount == 0) {
        activecount = level.activecounteruavs[teamorentnum];
      }
      currentindex = level.counter_uav_position_index[teamorentnum];
      newindex = currentindex;
      while(newindex == currentindex) {
        newindex = randomintrange(0, 20);
      }
      destination = level.counter_uav_positions[newindex];
      level.counter_uav_position_index[teamorentnum] = newindex;
      level notify("counter_uav_move_" + teamorentnum);
      wait(5 + randomintrange(5, 10));
    }
  }
}

function getcurrentposition(teamorentnum) {
  baseposition = level.counter_uav_positions[level.counter_uav_position_index[teamorentnum]];
  offset = level.counter_uav_offsets[self.cuav_offset_index];
  return baseposition + offset;
}

function assignfirstavailableoffsetindex() {
  self.cuav_offset_index = getfirstavailableoffsetindex();
  maintaincouteruaventities();
}

function getfirstavailableoffsetindex() {
  available_offsets = [];
  for(i = 0; i < level.counter_uav_offsets.size; i++) {
    available_offsets[i] = 1;
  }
  foreach(cuav in level.counter_uav_entities) {
    if(isDefined(cuav)) {
      available_offsets[cuav.cuav_offset_index] = 0;
    }
  }
  for(i = 0; i < available_offsets.size; i++) {
    if(available_offsets[i]) {
      return i;
    }
  }
  util::warning("");
  return 0;
}

function maintaincouteruaventities() {
  for(i = level.counter_uav_entities.size; i >= 0; i--) {
    if(!isDefined(level.counter_uav_entities[i])) {
      arrayremoveindex(level.counter_uav_entities, i);
    }
  }
}

function waitanddebugdrawoffsetlist() {
  level endon("game_ended");
  wait(10);
  debugdrawoffsetlist();
}

function debugdrawoffsetlist() {
  baseposition = level.counter_uav_positions[0];
  foreach(offset in level.counter_uav_offsets) {
    util::debug_sphere(baseposition + offset, 24, (0.95, 0.05, 0.05), 0.75, 9999999);
  }
}

function buildoffsetlist(startoffset, depth, offset_x, offset_y) {
  offsets = [];
  for(col = 0; col < depth; col++) {
    itemcount = math::pow(2, col);
    startingindex = itemcount - 1;
    for(i = 0; i < itemcount; i++) {
      x = offset_x * col;
      y = 0;
      if(itemcount > 1) {
        y = i * offset_y;
        total_y = offset_y * startingindex;
        y = y - (total_y / 2);
      }
      offsets[startingindex + i] = startoffset + (x, y, 0);
    }
  }
  return offsets;
}

function activatecounteruav() {
  if(self killstreakrules::iskillstreakallowed("counteruav", self.team) == 0) {
    return false;
  }
  killstreak_id = self killstreakrules::killstreakstart("counteruav", self.team);
  if(killstreak_id == -1) {
    return false;
  }
  counteruav = spawncounteruav(self, killstreak_id);
  if(!isDefined(counteruav)) {
    return false;
  }
  counteruav setscale(1);
  counteruav clientfield::set("enemyvehicle", 1);
  counteruav.killstreak_id = killstreak_id;
  counteruav thread killstreaks::waittillemp(&destroycounteruavbyemp);
  counteruav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
  counteruav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
  counteruav thread util::waittillendonthreaded("death", &destroycounteruav, "delete", "leaving");
  counteruav setCanDamage(1);
  counteruav thread killstreaks::monitordamage("counteruav", 700, &destroycounteruav, 700 * 0.5, &onlowhealth, 0, undefined, 1);
  counteruav playLoopSound("veh_uav_engine_loop", 1);
  counteruav thread listenformove();
  self killstreaks::play_killstreak_start_dialog("counteruav", self.team, killstreak_id);
  counteruav killstreaks::play_pilot_dialog_on_owner("arrive", "counteruav", killstreak_id);
  counteruav thread killstreaks::player_killstreak_threat_tracking("counteruav");
  self addweaponstat(getweapon("counteruav"), "used", 1);
  return true;
}

function hackedprefunction(hacker) {
  cuav = self;
  cuav resetactivecounteruav();
}

function spawncounteruav(owner, killstreak_id) {
  minflyheight = airsupport::getminimumflyheight();
  cuav = spawnvehicle("veh_counteruav_mp", airsupport::getmapcenter() + (0, 0, minflyheight + (isDefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000)), (0, 0, 0), "counteruav");
  cuav assignfirstavailableoffsetindex();
  cuav killstreaks::configure_team("counteruav", killstreak_id, owner, undefined, undefined, &configureteampost);
  cuav killstreak_hacking::enable_hacking("counteruav", &hackedprefunction, undefined);
  cuav.targetname = "counteruav";
  killstreak_detect::killstreaktargetset(cuav);
  cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", undefined, 1);
  cuav.maxhealth = 700;
  cuav.health = 99999;
  cuav.rocketdamage = 700 + 1;
  cuav setdrawinfrared(1);
  if(!isDefined(level.counter_uav_entities)) {
    level.counter_uav_entities = [];
  } else if(!isarray(level.counter_uav_entities)) {
    level.counter_uav_entities = array(level.counter_uav_entities);
  }
  level.counter_uav_entities[level.counter_uav_entities.size] = cuav;
  return cuav;
}

function configureteampost(owner, ishacked) {
  cuav = self;
  if(ishacked == 0) {
    cuav teams::hidetosameteam();
  } else {
    cuav setvisibletoall();
  }
  cuav thread teams::waituntilteamchangesingleton(owner, "CUAV_watch_team_change", &onteamchange, self.entnum, "death", "leaving", "crashing");
  cuav addactivecounteruav();
}

function listenformove() {
  self endon("death");
  self endon("leaving");
  while(true) {
    self thread counteruavmove();
    level util::waittill_any("counter_uav_move_" + self.team, "counter_uav_move_" + self.ownerentnum);
  }
}

function counteruavmove() {
  self endon("death");
  self endon("leaving");
  level endon("counter_uav_move_" + self.team);
  destination = (0, 0, 0);
  if(level.teambased) {
    destination = self getcurrentposition(self.team);
  } else {
    destination = self getcurrentposition(self.ownerentnum);
  }
  lookangles = vectortoangles(destination - self.origin);
  rotationaccelerationduration = 0.5 * 0.2;
  rotationdecelerationduration = 0.5 * 0.2;
  travelaccelerationduration = 5 * 0.2;
  traveldecelerationduration = 5 * 0.2;
  self setvehgoalpos(destination, 1, 0);
}

function playFX(name) {
  self endon("death");
  wait(0.1);
  if(isDefined(self)) {
    playFXOnTag(name, self, "tag_origin");
  }
}

function onlowhealth(attacker, weapon) {
  self.is_damaged = 1;
  params = level.killstreakbundle["counteruav"];
  if(isDefined(params.fxlowhealth)) {
    playFXOnTag(params.fxlowhealth, self, "tag_origin");
  }
}

function onteamchange(entnum, event) {
  destroycounteruav(undefined, undefined);
}

function onplayerjoinedteam() {
  hideallcounteruavstosameteam();
}

function ontimeout() {
  self.leaving = 1;
  self killstreaks::play_pilot_dialog_on_owner("timeout", "counteruav");
  self airsupport::leave(5);
  wait(5);
  self removeactivecounteruav();
  target_remove(self);
  self delete();
}

function ontimecheck() {
  self killstreaks::play_pilot_dialog_on_owner("timecheck", "counteruav", self.killstreak_id);
}

function destroycounteruavbyemp(attacker, arg) {
  destroycounteruav(attacker, getweapon("emp"));
}

function destroycounteruav(attacker, weapon) {
  if(self.leaving !== 1) {
    self killstreaks::play_destroyed_dialog_on_owner("counteruav", self.killstreak_id);
  }
  attacker = self[[level.figure_out_attacker]](attacker);
  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    challenges::destroyedaircraft(attacker, weapon, 0);
    scoreevents::processscoreevent("destroyed_counter_uav", attacker, self.owner, weapon);
    luinotifyevent(&"player_callout", 2, &"KILLSTREAK_DESTROYED_COUNTERUAV", attacker.entnum);
    attacker challenges::addflyswatterstat(weapon, self);
  }
  self playSound("evt_helicopter_midair_exp");
  self removeactivecounteruav();
  if(target_istarget(self)) {
    target_remove(self);
  }
  self thread deletecounteruav();
}

function deletecounteruav() {
  self notify("crashing");
  params = level.killstreakbundle["counteruav"];
  if(isDefined(params.ksexplosionfx) && isDefined(self)) {
    self thread playFX(params.ksexplosionfx);
  }
  wait(0.1);
  if(isDefined(self)) {
    self setModel("tag_origin");
  }
  wait(0.2);
  if(isDefined(self)) {
    self notify("delete");
    self delete();
  }
}

function enemycounteruavactive() {
  if(level.teambased) {
    foreach(team in level.teams) {
      if(team == self.team) {
        continue;
      }
      if(teamhasactivecounteruav(team)) {
        return true;
      }
    }
  } else {
    enemies = self teams::getenemyplayers();
    foreach(player in enemies) {
      if(player hasactivecounteruav()) {
        return true;
      }
    }
  }
  return false;
}

function hasactivecounteruav() {
  return level.activecounteruavs[self.entnum] > 0;
}

function teamhasactivecounteruav(team) {
  return level.activecounteruavs[team] > 0;
}

function hasindexactivecounteruav(team_or_entnum) {
  return level.activecounteruavs[team_or_entnum] > 0;
}

function addactivecounteruav() {
  if(level.teambased) {
    level.activecounteruavs[self.team]++;
    foreach(team in level.teams) {
      if(team == self.team) {
        continue;
      }
      if(satellite::hassatellite(team)) {
        self.owner challenges::blockedsatellite();
      }
    }
  } else {
    level.activecounteruavs[self.ownerentnum]++;
    keys = getarraykeys(level.activecounteruavs);
    for(i = 0; i < keys.size; i++) {
      if(keys[i] == self.ownerentnum) {
        continue;
      }
      if(satellite::hassatellite(keys[i])) {
        self.owner challenges::blockedsatellite();
        break;
      }
    }
  }
  level.activeplayercounteruavs[self.ownerentnum]++;
  level notify("counter_uav_updated");
}

function removeactivecounteruav() {
  cuav = self;
  cuav resetactivecounteruav();
  cuav killstreakrules::killstreakstop("counteruav", self.originalteam, self.killstreak_id);
}

function resetactivecounteruav() {
  if(level.teambased) {
    level.activecounteruavs[self.team]--;
    assert(level.activecounteruavs[self.team] >= 0);
    if(level.activecounteruavs[self.team] < 0) {
      level.activecounteruavs[self.team] = 0;
    }
  } else if(isDefined(self.owner)) {
    assert(isDefined(self.ownerentnum));
    if(!isDefined(self.ownerentnum)) {
      self.ownerentnum = self.owner getentitynumber();
    }
    level.activecounteruavs[self.ownerentnum]--;
    assert(level.activecounteruavs[self.ownerentnum] >= 0);
    if(level.activecounteruavs[self.ownerentnum] < 0) {
      level.activecounteruavs[self.ownerentnum] = 0;
    }
  }
  level.activeplayercounteruavs[self.ownerentnum]--;
  level notify("counter_uav_updated");
}

function watchcounteruavs() {
  while(true) {
    level waittill("counter_uav_updated");
    foreach(player in level.players) {
      if(player enemycounteruavactive()) {
        player clientfield::set_to_player("counteruav", 1);
        continue;
      }
      player clientfield::set_to_player("counteruav", 0);
    }
  }
}

function hideallcounteruavstosameteam() {
  foreach(counteruav in level.counter_uav_entities) {
    if(isDefined(counteruav)) {
      counteruav teams::hidetosameteam();
    }
  }
}
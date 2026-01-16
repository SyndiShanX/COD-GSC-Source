/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_remotemissile.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace remotemissile;

function init() {
  level.rockets = [];
  killstreaks::register("remote_missile", "remote_missile", "killstreak_remote_missile", "remote_missle_used", & tryusepredatormissile, 1);
  killstreaks::register_alt_weapon("remote_missile", "remote_missile_missile");
  killstreaks::register_alt_weapon("remote_missile", "remote_missile_bomblet");
  killstreaks::register_strings("remote_missile", & "KILLSTREAK_EARNED_REMOTE_MISSILE", & "KILLSTREAK_REMOTE_MISSILE_NOT_AVAILABLE", & "KILLSTREAK_REMOTE_MISSILE_INBOUND", undefined, & "KILLSTREAK_REMOTE_MISSILE_HACKED");
  killstreaks::register_dialog("remote_missile", "mpl_killstreak_cruisemissile", "remoteMissileDialogBundle", "remoteMissilePilotDialogBundle", "friendlyRemoteMissile", "enemyRemoteMissile", "enemyRemoteMissileMultiple", "friendlyRemoteMissileHacked", "enemyRemoteMissileHacked", "requestRemoteMissile");
  killstreaks::set_team_kill_penalty_scale("remote_missile", level.teamkillreducedpenalty);
  killstreaks::override_entity_camera_in_demo("remote_missile", 1);
  clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int");
  clientfield::register("missile", "remote_missile_fired", 1, 2, "int");
  level.missilesforsighttraces = [];
  level.missileremotedeployfx = "killstreaks/fx_predator_trigger";
  level.missileremotelaunchvert = 18000;
  level.missileremotelaunchhorz = 7000;
  level.missileremotelaunchtargetdist = 1500;
  visionset_mgr::register_info("visionset", "remote_missile_visionset", 1, 110, 16, 1, & visionset_mgr::ramp_in_out_thread_per_player, 0);
}

function remote_missile_game_end_think(rocket, team, killstreak_id) {
  self endon("remotemissle_killstreak_done");
  level waittill("game_ended");
  self thread player_missile_end(rocket, 1, 1, team, killstreak_id);
  self notify("remotemissle_killstreak_done");
}

function tryusepredatormissile(lifeid) {
  waterdepth = self depthofplayerinwater();
  if(!self isonground() || self util::isusingremote() || waterdepth > 2 || self killstreaks::is_killstreak_start_blocked()) {
    self iprintlnbold(&"KILLSTREAK_REMOTE_MISSILE_NOT_USABLE");
    return 0;
  }
  team = self.team;
  killstreak_id = self killstreakrules::killstreakstart("remote_missile", team, 0, 1);
  if(killstreak_id == -1) {
    return 0;
  }
  self.remotemissilepilotindex = killstreaks::get_random_pilot_index("remote_missile");
  returnvar = _fire(lifeid, self, team, killstreak_id);
  return returnvar;
}

function getbestspawnpoint(remotemissilespawnpoints) {
  validenemies = [];
  foreach(spawnpoint in remotemissilespawnpoints) {
    spawnpoint.validplayers = [];
    spawnpoint.spawnscore = 0;
  }
  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    if(player.team == "spectator") {
      continue;
    }
    bestdistance = 999999999;
    bestspawnpoint = undefined;
    foreach(spawnpoint in remotemissilespawnpoints) {
      spawnpoint.validplayers[spawnpoint.validplayers.size] = player;
      potentialbestdistance = distance2dsquared(spawnpoint.targetent.origin, player.origin);
      if(potentialbestdistance <= bestdistance) {
        bestdistance = potentialbestdistance;
        bestspawnpoint = spawnpoint;
      }
    }
    bestspawnpoint.spawnscore = bestspawnpoint.spawnscore + 2;
  }
  bestspawn = remotemissilespawnpoints[0];
  foreach(spawnpoint in remotemissilespawnpoints) {
    foreach(player in spawnpoint.validplayers) {
      spawnpoint.spawnscore = spawnpoint.spawnscore + 1;
      if(bullettracepassed(player.origin + vectorscale((0, 0, 1), 32), spawnpoint.origin, 0, player)) {
        spawnpoint.spawnscore = spawnpoint.spawnscore + 3;
      }
      if(spawnpoint.spawnscore > bestspawn.spawnscore) {
        bestspawn = spawnpoint;
        continue;
      }
      if(spawnpoint.spawnscore == bestspawn.spawnscore) {
        if(math::cointoss()) {
          bestspawn = spawnpoint;
        }
      }
    }
  }
  return bestspawn;
}

function drawline(start, end, timeslice, color) {
  drawtime = int(timeslice * 20);
  for (time = 0; time < drawtime; time++) {
    line(start, end, color, 0, 1);
    wait(0.05);
  }
}

function _fire(lifeid, player, team, killstreak_id) {
  remotemissilespawnarray = getentarray("remoteMissileSpawn", "targetname");
  foreach(spawn in remotemissilespawnarray) {
    if(isdefined(spawn.target)) {
      spawn.targetent = getent(spawn.target, "targetname");
    }
  }
  if(remotemissilespawnarray.size > 0) {
    remotemissilespawn = player getbestspawnpoint(remotemissilespawnarray);
  } else {
    remotemissilespawn = undefined;
  }
  if(isdefined(remotemissilespawn)) {
    startpos = remotemissilespawn.origin;
    targetpos = remotemissilespawn.targetent.origin;
    vector = vectornormalize(startpos - targetpos);
    startpos = (vector * level.missileremotelaunchvert) + targetpos;
  } else {
    upvector = (0, 0, level.missileremotelaunchvert);
    backdist = level.missileremotelaunchhorz;
    targetdist = level.missileremotelaunchtargetdist;
    forward = anglestoforward(player.angles);
    startpos = (player.origin + upvector) + ((forward * backdist) * -1);
    targetpos = player.origin + (forward * targetdist);
  }
  self util::setusingremote("remote_missile");
  self util::freeze_player_controls(1);
  player disableweaponcycling();
  result = self killstreaks::init_ride_killstreak("qrdrone");
  if(result != "success" || level.gameended) {
    if(result != "disconnect") {
      player util::freeze_player_controls(0);
      player killstreaks::clear_using_remote();
      player enableweaponcycling();
      killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
    }
    return false;
  }
  rocket = magicbullet(getweapon("remote_missile_missile"), startpos, targetpos, player);
  rocket.forceonemissile = 1;
  forceanglevector = vectornormalize(targetpos - startpos);
  rocket.angles = vectortoangles(forceanglevector);
  rocket.targetname = "remote_missile";
  rocket killstreaks::configure_team("remote_missile", killstreak_id, self, undefined, undefined, undefined);
  rocket killstreak_hacking::enable_hacking("remote_missile", undefined, & hackedpostfunction);
  killstreak_detect::killstreaktargetset(rocket);
  rocket.hackedhealthupdatecallback = & hackedhealthupdate;
  rocket clientfield::set("enemyvehicle", 1);
  rocket thread handledamage();
  player linktomissile(rocket, 1, 1);
  rocket.owner = player;
  rocket.killcament = player;
  player thread cleanupwaiter(rocket, player.team, killstreak_id);
  visionset_mgr::activate("visionset", "remote_missile_visionset", player, 0, 90000, 0);
  player setmodellodbias((isdefined(level.remotemissile_lod_bias) ? level.remotemissile_lod_bias : 12));
  self clientfield::set_to_player("fog_bank_2", 1);
  self clientfield::set("operating_predator", 1);
  self killstreaks::play_killstreak_start_dialog("remote_missile", self.pers["team"], killstreak_id);
  self addweaponstat(getweapon("remote_missile"), "used", 1);
  rocket thread setup_rockect_map_icon();
  rocket thread watch_missile_kill_z();
  rocket missile_sound_play(player);
  rocket thread missile_brake_timeout_watch();
  rocket thread missile_sound_impact(player, 3750);
  player thread missile_sound_boost(rocket);
  player thread missile_deploy_watch(rocket);
  player thread remote_missile_game_end_think(rocket, player.team, killstreak_id);
  player thread watch_missile_death(rocket, player.team, killstreak_id);
  player thread sndwatchexplo();
  rocket spawning::create_entity_enemy_influencer("small_vehicle", rocket.team);
  player util::freeze_player_controls(0);
  player waittill("remotemissle_killstreak_done");
  return true;
}

function hackedhealthupdate(hacker) {}

function hackedpostfunction(hacker) {
  rocket = self;
  hacker missile_deploy(rocket, 1);
}

function setup_rockect_map_icon() {
  self endon("death");
  wait(0.1);
  self clientfield::set("remote_missile_fired", 1);
}

function watch_missile_kill_z() {
  if(!isdefined(level.remotemissile_kill_z)) {
    return;
  }
  rocket = self;
  kill_z = level.remotemissile_kill_z;
  rocket endon("remotemissle_killstreak_done");
  rocket endon("death");
  while (rocket.origin[2] > kill_z) {
    wait(0.1);
  }
  rocket detonate();
}

function watch_missile_death(rocket, team, killstreak_id) {
  self endon("remotemissle_killstreak_done");
  rocket waittill("death");
  self thread player_missile_end(rocket, 1, 1, team, killstreak_id);
  self thread remotemissile_bda_dialog();
  self notify("remotemissle_killstreak_done");
}

function player_missile_end(rocket, performplayerkillstreakend, unlink, team, killstreak_id) {
  self notify("player_missile_end_singleton");
  self endon("player_missile_end_singleton");
  if(isalive(rocket)) {
    rocket spawning::remove_influencers();
    rocket clientfield::set("remote_missile_fired", 0);
    rocket delete();
  }
  self notify("snd1stpersonexplo");
  if(isdefined(self)) {
    self thread destroy_missile_hud();
    if(isdefined(performplayerkillstreakend) && performplayerkillstreakend) {
      self playrumbleonentity("grenade_rumble");
      if(level.gameended == 0) {
        self sendkillstreakdamageevent(600);
      }
      if(isdefined(rocket)) {
        rocket hide();
      }
    }
    self clientfield::set("operating_predator", 0);
    self clientfield::set_to_player("fog_bank_2", 0);
    visionset_mgr::deactivate("visionset", "remote_missile_visionset", self);
    self setmodellodbias(0);
    if(unlink) {
      self unlinkfrommissile();
    }
    self notify("remotemissile_done");
    self util::freeze_player_controls(0);
    self killstreaks::clear_using_remote();
    self enableweaponcycling();
    killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
  }
}

function missile_brake_timeout_watch() {
  rocket = self;
  player = rocket.owner;
  self endon("death");
  self waittill("missile_brake");
  rocket playsound("wpn_remote_missile_brake_npc");
  player playlocalsound("wpn_remote_missile_brake_plr");
  wait(1.5);
  if(isdefined(self)) {
    self setmissilebrake(0);
  }
}

function stopondeath(snd) {
  self waittill("death");
  if(isdefined(snd)) {
    snd delete();
  }
}

function cleanupwaiter(rocket, team, killstreak_id) {
  self endon("remotemissle_killstreak_done");
  self util::waittill_any("joined_team", "joined_spectators", "disconnect");
  self thread player_missile_end(rocket, 0, 0, team, killstreak_id);
  self notify("remotemissle_killstreak_done");
}

function handledamage() {
  self endon("death");
  self endon("deleted");
  self setcandamage(1);
  self.health = 99999;
  for (;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, tagname, modelname, partname, weapon);
    if(isdefined(attacker) && isdefined(self.owner)) {
      if(self.owner util::isenemyplayer(attacker)) {
        challenges::destroyedaircraft(attacker, weapon, 1);
        attacker challenges::addflyswatterstat(weapon, self);
        scoreevents::processscoreevent("destroyed_remote_missile", attacker, self.owner, weapon);
        attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
      }
      self.owner sendkillstreakdamageevent(int(damage));
    }
    self spawning::remove_influencers();
    self detonate();
  }
}

function staticeffect(duration) {
  self endon("disconnect");
  staticbg = newclienthudelem(self);
  staticbg.horzalign = "fullscreen";
  staticbg.vertalign = "fullscreen";
  staticbg setshader("white", 640, 480);
  staticbg.archive = 1;
  staticbg.sort = 10;
  staticbg.immunetodemogamehudsettings = 1;
  static = newclienthudelem(self);
  static.horzalign = "fullscreen";
  static.vertalign = "fullscreen";
  static.archive = 1;
  static.sort = 20;
  static.immunetodemogamehudsettings = 1;
  self clientfield::set("remote_killstreak_static", 1);
  wait(duration);
  self clientfield::set("remote_killstreak_static", 0);
  static destroy();
  staticbg destroy();
}

function rocket_cleanupondeath() {
  entitynumber = self getentitynumber();
  level.rockets[entitynumber] = self;
  self waittill("death");
  level.rockets[entitynumber] = undefined;
}

function missile_sound_play(player) {
  self.snd_first = spawn("script_model", self.origin);
  self.snd_first setmodel("tag_origin");
  self.snd_first linkto(self);
  self.snd_first setinvisibletoall();
  self.snd_first setvisibletoplayer(player);
  self.snd_first playloopsound("wpn_remote_missile_loop_plr", 0.5);
  self thread stopondeath(self.snd_first);
  self.snd_third = spawn("script_model", self.origin);
  self.snd_third setmodel("tag_origin");
  self.snd_third linkto(self);
  self.snd_third setvisibletoall();
  self.snd_third setinvisibletoplayer(player);
  self.snd_third playloopsound("wpn_remote_missile_loop_npc", 0.2);
  self thread stopondeath(self.snd_third);
}

function missile_sound_boost(rocket) {
  self endon("remotemissile_done");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self waittill("missile_boost");
  rocket playsound("wpn_remote_missile_fire_boost_npc");
  rocket.snd_third playloopsound("wpn_remote_missile_boost_npc");
  self playlocalsound("wpn_remote_missile_fire_boost_plr");
  rocket.snd_first playloopsound("wpn_remote_missile_boost_plr");
  self playrumbleonentity("sniper_fire");
  if((rocket.origin[2] - self.origin[2]) > 4000) {
    rocket notify("stop_impact_sound");
    rocket thread missile_sound_impact(self, 6250);
  }
}

function missile_sound_impact(player, distance) {
  self endon("death");
  self endon("stop_impact_sound");
  player endon("disconnect");
  player endon("remotemissile_done");
  player endon("joined_team");
  player endon("joined_spectators");
  for (;;) {
    if((self.origin[2] - player.origin[2]) < distance) {
      self playsound("wpn_remote_missile_inc");
      return;
    }
    wait(0.05);
  }
}

function sndwatchexplo() {
  self endon("remotemissle_killstreak_done");
  self endon("remotemissile_done");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("disconnect");
  self endon("bomblets_deployed");
  self waittill("snd1stpersonexplo");
  self playlocalsound("wpn_remote_missile_explode_plr");
}

function missile_sound_deploy_bomblets() {
  self.snd_first playloopsound("wpn_remote_missile_loop_plr", 0.5);
}

function getvalidtargets(rocket, trace, max_targets) {
  pixbeginevent("remotemissile_getVTs_header");
  targets = [];
  forward = anglestoforward(rocket.angles);
  rocketz = rocket.origin[2];
  mapcenterz = level.mapcenter[2];
  diff = mapcenterz - rocketz;
  ratio = diff / forward[2];
  aimtarget = rocket.origin + (forward * ratio);
  rocket.aimtarget = aimtarget;
  pixendevent();
  pixbeginevent("remotemissile_getVTs_enemies");
  enemies = self getenemies();
  foreach(player in enemies) {
    if(!isplayer(player)) {
      continue;
    }
    if(player.ignoreme === 1) {
      continue;
    }
    if(distance2dsquared(player.origin, aimtarget) < 360000 && !player hasperk("specialty_nokillstreakreticle")) {
      if(trace) {
        if(bullettracepassed(player.origin + vectorscale((0, 0, 1), 60), player.origin + vectorscale((0, 0, 1), 180), 0, player)) {
          targets[targets.size] = player;
        }
      } else {
        targets[targets.size] = player;
      }
      if(targets.size >= max_targets) {
        return targets;
      }
    }
  }
  dogs = getentarray("attack_dog", "targetname");
  foreach(dog in dogs) {
    if(dog.team != self.team && distance2dsquared(dog.origin, aimtarget) < 360000) {
      if(trace) {
        if(bullettracepassed(dog.origin + vectorscale((0, 0, 1), 60), dog.origin + vectorscale((0, 0, 1), 180), 0, dog)) {
          targets[targets.size] = dog;
        }
      } else {
        targets[targets.size] = dog;
      }
      if(targets.size >= max_targets) {
        return targets;
      }
    }
  }
  tanks = getentarray("talon", "targetname");
  foreach(tank in tanks) {
    if(tank.team != self.team && distance2dsquared(tank.origin, aimtarget) < 360000) {
      if(trace) {
        if(bullettracepassed(tank.origin + vectorscale((0, 0, 1), 60), tank.origin + vectorscale((0, 0, 1), 180), 0, tank)) {
          targets[targets.size] = tank;
        }
      } else {
        targets[targets.size] = tank;
      }
      if(targets.size >= max_targets) {
        return targets;
      }
    }
  }
  turrets = getentarray("auto_turret", "classname");
  foreach(turret in turrets) {
    if(turret.team != self.team && distance2dsquared(turret.origin, aimtarget) < 360000) {
      if(trace) {
        if(bullettracepassed(turret.origin + vectorscale((0, 0, 1), 60), turret.origin + vectorscale((0, 0, 1), 180), 0, turret)) {
          targets[targets.size] = turret;
        }
      } else {
        targets[targets.size] = turret;
      }
      if(targets.size >= max_targets) {
        return targets;
      }
    }
  }
  pixendevent();
  return targets;
}

function create_missile_hud(rocket) {
  self.missile_target_icons = [];
  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    if(level.teambased && player.team == self.team) {
      continue;
    }
    index = player.clientid;
    self.missile_target_icons[index] = newclienthudelem(self);
    self.missile_target_icons[index].x = 0;
    self.missile_target_icons[index].y = 0;
    self.missile_target_icons[index].z = 0;
    self.missile_target_icons[index].alpha = 0;
    self.missile_target_icons[index].archived = 1;
    self.missile_target_icons[index] setshader("hud_remote_missile_target", 175, 175);
    self.missile_target_icons[index] setwaypoint(0);
    self.missile_target_icons[index].hidewheninmenu = 1;
    self.missile_target_icons[index].immunetodemogamehudsettings = 1;
  }
  for (i = 0; i < 3; i++) {
    self.missile_target_other[i] = newclienthudelem(self);
    self.missile_target_other[i].x = 0;
    self.missile_target_other[i].y = 0;
    self.missile_target_other[i].z = 0;
    self.missile_target_other[i].alpha = 0;
    self.missile_target_other[i].archived = 1;
    self.missile_target_other[i] setshader("hud_remote_missile_target", 175, 175);
    self.missile_target_other[i] setwaypoint(0);
    self.missile_target_other[i].hidewheninmenu = 1;
    self.missile_target_other[i].immunetodemogamehudsettings = 1;
  }
  rocket.iconindexother = 0;
  self thread targeting_hud_think(rocket);
}

function destroy_missile_hud() {
  if(isdefined(self.missile_target_icons)) {
    foreach(player in level.players) {
      if(player == self) {
        continue;
      }
      index = player.clientid;
      if(isdefined(self.missile_target_icons[index])) {
        self.missile_target_icons[index] destroy();
      }
    }
  }
  if(isdefined(self.missile_target_other)) {
    for (i = 0; i < 3; i++) {
      if(isdefined(self.missile_target_other[i])) {
        self.missile_target_other[i] destroy();
      }
    }
  }
}

function targeting_hud_think(rocket) {
  self endon("disconnect");
  self endon("remotemissile_done");
  rocket endon("death");
  level endon("game_ended");
  targets = self getvalidtargets(rocket, 1, 6);
  framessincetargetscan = 0;
  while (true) {
    foreach(icon in self.missile_target_icons) {
      icon.alpha = 0;
    }
    framessincetargetscan++;
    if(framessincetargetscan > 5) {
      targets = self getvalidtargets(rocket, 1, 6);
      framessincetargetscan = 0;
    }
    if(targets.size > 0) {
      foreach(target in targets) {
        if(isdefined(target) == 0) {
          continue;
        }
        if(isplayer(target)) {
          if(isalive(target)) {
            index = target.clientid;
            assert(isdefined(index));
            self.missile_target_icons[index].x = target.origin[0];
            self.missile_target_icons[index].y = target.origin[1];
            self.missile_target_icons[index].z = target.origin[2] + 47;
            self.missile_target_icons[index].alpha = 1;
          }
          continue;
        }
        if(!isdefined(target.missileiconindex)) {
          target.missileiconindex = rocket.iconindexother;
          rocket.iconindexother = (rocket.iconindexother + 1) % 3;
        }
        index = target.missileiconindex;
        self.missile_target_other[index].x = target.origin[0];
        self.missile_target_other[index].y = target.origin[1];
        self.missile_target_other[index].z = target.origin[2];
        self.missile_target_other[index].alpha = 1;
      }
    }
    wait(0.1);
  }
}

function missile_deploy_watch(rocket) {
  self endon("disconnect");
  self endon("remotemissile_done");
  rocket endon("remotemissile_bomblets_launched");
  rocket endon("death");
  level endon("game_ended");
  wait(0.25);
  self thread create_missile_hud(rocket);
  while (true) {
    if(self attackbuttonpressed()) {
      self thread missile_deploy(rocket, 0);
    } else {
      wait(0.05);
    }
  }
}

function missile_deploy(rocket, hacked) {
  rocket notify("remotemissile_bomblets_launched");
  waitframes = 2;
  explosionradius = 0;
  targets = self getvalidtargets(rocket, 0, 6);
  if(targets.size > 0) {
    foreach(target in targets) {
      self thread fire_bomblet(rocket, explosionradius, target, waitframes);
      waitframes++;
    }
  }
  if((rocket.origin[2] - self.origin[2]) > 4000) {
    rocket notify("stop_impact_sound");
  }
  if(hacked == 1) {
    rocket.originalowner thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
    self notify("remotemissile_done");
  }
  rocket clientfield::set("remote_missile_fired", 2);
  for (i = targets.size; i < 6; i++) {
    self thread fire_random_bomblet(rocket, explosionradius, i % 6, waitframes);
    waitframes++;
  }
  playfx(level.missileremotedeployfx, rocket.origin, anglestoforward(rocket.angles));
  self playlocalsound("mpl_rc_exp");
  self playrumbleonentity("sniper_fire");
  earthquake(0.2, 0.2, rocket.origin, 200);
  rocket hide();
  rocket setmissilecoasting(1);
  if(hacked == 0) {
    self thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
  }
  rocket missile_sound_deploy_bomblets();
  self thread bomblet_camera_waiter(rocket);
  self notify("bomblets_deployed");
  if(hacked == 1) {
    rocket notify("death");
  }
}

function bomblet_camera_waiter(rocket) {
  self endon("disconnect");
  self endon("remotemissile_done");
  rocket endon("death");
  level endon("game_ended");
  delay = getdvarfloat("scr_rmbomblet_camera_delaytime", 1);
  self waittill("bomblet_exploded");
  wait(delay);
  rocket notify("death");
  self notify("remotemissile_done");
}

function setup_bomblet_map_icon() {
  self endon("death");
  wait(0.1);
  self clientfield::set("remote_missile_bomblet_fired", 1);
  self clientfield::set("enemyvehicle", 1);
}

function setup_bomblet(bomb) {
  bomb.team = self.team;
  bomb setteam(self.team);
  bomb thread setup_bomblet_map_icon();
  bomb.killcament = self;
  bomb thread bomblet_explostion_waiter(self);
}

function fire_bomblet(rocket, explosionradius, target, waitframes) {
  origin = rocket.origin;
  targetorigin = target.origin + vectorscale((0, 0, 1), 50);
  wait(waitframes * 0.05);
  if(isdefined(rocket)) {
    origin = rocket.origin;
  }
  bomb = magicbullet(getweapon("remote_missile_bomblet"), origin, targetorigin, self, target, vectorscale((0, 0, 1), 30));
  setup_bomblet(bomb);
}

function fire_random_bomblet(rocket, explosionradius, quadrant, waitframes) {
  origin = rocket.origin;
  angles = rocket.angles;
  owner = rocket.owner;
  aimtarget = rocket.aimtarget;
  wait(waitframes * 0.05);
  angle = randomintrange(10 + (60 * quadrant), 50 + (60 * quadrant));
  radius = randomintrange(200, 700);
  x = min(radius, 550) * cos(angle);
  y = min(radius, 550) * sin(angle);
  bomb = magicbullet(getweapon("remote_missile_bomblet"), origin, aimtarget + (x, y, 0), self);
  setup_bomblet(bomb);
}

function cleanup_bombs(bomb) {
  player = self;
  bomb endon("death");
  player util::waittill_any("joined_team", "joined_spectators", "disconnect");
  if(isdefined(bomb)) {
    bomb clientfield::set("remote_missile_bomblet_fired", 0);
    bomb delete();
  }
}

function bomblet_explostion_waiter(player) {
  player thread cleanup_bombs(self);
  player endon("disconnect");
  player endon("remotemissile_done");
  player endon("death");
  level endon("game_ended");
  self waittill("death");
  player notify("bomblet_exploded");
}

function remotemissile_bda_dialog() {
  if(isdefined(self.remotemissilebda)) {
    if(self.remotemissilebda === 1) {
      bdadialog = "kill1";
    } else {
      if(self.remotemissilebda === 2) {
        bdadialog = "kill2";
      } else {
        if(self.remotemissilebda === 3) {
          bdadialog = "kill3";
        } else if(isdefined(self.remotemissilebda) && self.remotemissilebda > 3) {
          bdadialog = "killMultiple";
        }
      }
    }
    self killstreaks::play_pilot_dialog(bdadialog, "remote_missile", undefined, self.remotemissilepilotindex);
    self globallogic_audio::play_taacom_dialog("confirmHit");
  } else {
    killstreaks::play_pilot_dialog("killNone", "remote_missile", undefined, self.remotemissilepilotindex);
    globallogic_audio::play_taacom_dialog("confirmMiss");
  }
  self.remotemissilebda = undefined;
}
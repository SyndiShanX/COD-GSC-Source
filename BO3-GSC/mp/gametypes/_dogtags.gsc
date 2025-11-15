/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_dogtags.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_spectating;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\objpoints_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace dogtags;

function init() {
  level.antiboostdistance = getgametypesetting("antiBoostDistance");
  level.dogtags = [];
}

function spawn_dog_tag(victim, attacker, on_use_function, objectives_for_attacker_and_victim_only) {
  if(isDefined(level.dogtags[victim.entnum])) {
    playFX("ui/fx_kill_confirmed_vanish", level.dogtags[victim.entnum].curorigin);
    level.dogtags[victim.entnum] notify("reset");
  } else {
    visuals[0] = spawn("script_model", (0, 0, 0));
    visuals[0] setModel(victim getenemydogtagmodel());
    visuals[1] = spawn("script_model", (0, 0, 0));
    visuals[1] setModel(victim getfriendlydogtagmodel());
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level.dogtags[victim.entnum] = gameobjects::create_use_object("any", trigger, visuals, vectorscale((0, 0, 1), 16));
    level.dogtags[victim.entnum] gameobjects::set_use_time(0);
    level.dogtags[victim.entnum].onuse = & onuse;
    level.dogtags[victim.entnum].custom_onuse = on_use_function;
    level.dogtags[victim.entnum].victim = victim;
    level.dogtags[victim.entnum].victimteam = victim.team;
    level thread clear_on_victim_disconnect(victim);
    victim thread team_updater(level.dogtags[victim.entnum]);
    foreach(team in level.teams) {
      objective_add(level.dogtags[victim.entnum].objid[team], "invisible", (0, 0, 0));
      objective_icon(level.dogtags[victim.entnum].objid[team], "waypoint_dogtags");
      objective_team(level.dogtags[victim.entnum].objid[team], team);
      if(team == attacker.team) {
        objective_setcolor(level.dogtags[victim.entnum].objid[team], & "EnemyOrange");
        continue;
      }
      objective_setcolor(level.dogtags[victim.entnum].objid[team], & "FriendlyBlue");
    }
  }
  pos = victim.origin + vectorscale((0, 0, 1), 14);
  level.dogtags[victim.entnum].curorigin = pos;
  level.dogtags[victim.entnum].trigger.origin = pos;
  level.dogtags[victim.entnum].visuals[0].origin = pos;
  level.dogtags[victim.entnum].visuals[1].origin = pos;
  level.dogtags[victim.entnum].visuals[0] dontinterpolate();
  level.dogtags[victim.entnum].visuals[1] dontinterpolate();
  level.dogtags[victim.entnum] gameobjects::allow_use("any");
  level.dogtags[victim.entnum].visuals[0] thread show_to_team(level.dogtags[victim.entnum], attacker.team);
  level.dogtags[victim.entnum].visuals[1] thread show_to_enemy_teams(level.dogtags[victim.entnum], attacker.team);
  level.dogtags[victim.entnum].attacker = attacker;
  level.dogtags[victim.entnum].attackerteam = attacker.team;
  level.dogtags[victim.entnum].unreachable = undefined;
  level.dogtags[victim.entnum].tacinsert = 0;
  foreach(team in level.teams) {
    if(isDefined(level.dogtags[victim.entnum].objid[team])) {
      objective_position(level.dogtags[victim.entnum].objid[team], pos);
      objective_state(level.dogtags[victim.entnum].objid[team], "active");
    }
  }
  if(objectives_for_attacker_and_victim_only) {
    objective_setinvisibletoall(level.dogtags[victim.entnum].objid[attacker.team]);
    if(isplayer(attacker)) {
      objective_setvisibletoplayer(level.dogtags[victim.entnum].objid[attacker.team], attacker);
    }
    objective_setinvisibletoall(level.dogtags[victim.entnum].objid[victim.team]);
    if(isplayer(victim)) {
      objective_setvisibletoplayer(level.dogtags[victim.entnum].objid[victim.team], victim);
    }
  }
  level.dogtags[victim.entnum] thread bounce();
  level notify("dogtag_spawned");
}

function show_to_team(gameobject, show_team) {
  self show();
  foreach(team in level.teams) {
    self hidefromteam(team);
  }
  self showtoteam(show_team);
}

function show_to_enemy_teams(gameobject, friend_team) {
  self show();
  foreach(team in level.teams) {
    self showtoteam(team);
  }
  self hidefromteam(friend_team);
}

function onuse(player) {
  self.visuals[0] playSound("mpl_killconfirm_tags_pickup");
  tacinsertboost = 0;
  if(player.team != self.attackerteam) {
    player addplayerstat("KILLSDENIED", 1);
    player recordgameevent("return");
    if(self.victim == player) {
      if(self.tacinsert == 0) {
        event = "retrieve_own_tags";
      } else {
        tacinsertboost = 1;
      }
    } else {
      event = "kill_denied";
    }
    if(!tacinsertboost) {
      player.pers["killsdenied"]++;
      player.killsdenied = player.pers["killsdenied"];
    }
  } else {
    event = "kill_confirmed";
    player addplayerstat("KILLSCONFIRMED", 1);
    player recordgameevent("capture");
    if(isDefined(self.attacker) && self.attacker != player) {
      self.attacker onpickup("teammate_kill_confirmed");
    }
  }
  if(!tacinsertboost && isDefined(player)) {
    player onpickup(event);
  }
  [[self.custom_onuse]](player);
  self reset_tags();
}

function reset_tags() {
  self.attacker = undefined;
  self.unreachable = undefined;
  self notify("reset");
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.curorigin = vectorscale((0, 0, 1), 1000);
  self.trigger.origin = vectorscale((0, 0, 1), 1000);
  self.visuals[0].origin = vectorscale((0, 0, 1), 1000);
  self.visuals[1].origin = vectorscale((0, 0, 1), 1000);
  self.tacinsert = 0;
  self gameobjects::allow_use("none");
  foreach(team in level.teams) {
    objective_state(self.objid[team], "invisible");
  }
}

function onpickup(event) {
  scoreevents::processscoreevent(event, self);
}

function clear_on_victim_disconnect(victim) {
  level endon("game_ended");
  guid = victim.entnum;
  victim waittill("disconnect");
  if(isDefined(level.dogtags[guid])) {
    level.dogtags[guid] gameobjects::allow_use("none");
    playFX("ui/fx_kill_confirmed_vanish", level.dogtags[guid].curorigin);
    level.dogtags[guid] notify("reset");
    wait(0.05);
    if(isDefined(level.dogtags[guid])) {
      foreach(team in level.teams) {
        objective_delete(level.dogtags[guid].objid[team]);
      }
      level.dogtags[guid].trigger delete();
      for(i = 0; i < level.dogtags[guid].visuals.size; i++) {
        level.dogtags[guid].visuals[i] delete();
      }
      level.dogtags[guid] notify("deleted");
      level.dogtags[guid] = undefined;
    }
  }
}

function on_spawn_player() {
  if(level.rankedmatch || level.leaguematch) {
    if(isDefined(self.tacticalinsertiontime) && (self.tacticalinsertiontime + 100) > gettime()) {
      mindist = level.antiboostdistance;
      mindistsqr = mindist * mindist;
      distsqr = distancesquared(self.origin, level.dogtags[self.entnum].curorigin);
      if(distsqr < mindistsqr) {
        level.dogtags[self.entnum].tacinsert = 1;
      }
    }
  }
}

function team_updater(tags) {
  level endon("game_ended");
  self endon("disconnect");
  while(true) {
    self waittill("joined_team");
    tags.victimteam = self.team;
    tags reset_tags();
  }
}

function time_out(victim) {
  level endon("game_ended");
  victim endon("disconnect");
  self notify("timeout");
  self endon("timeout");
  level hostmigration::waitlongdurationwithhostmigrationpause(30);
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.curorigin = vectorscale((0, 0, 1), 1000);
  self.trigger.origin = vectorscale((0, 0, 1), 1000);
  self.visuals[0].origin = vectorscale((0, 0, 1), 1000);
  self.visuals[1].origin = vectorscale((0, 0, 1), 1000);
  self.tacinsert = 0;
  self gameobjects::allow_use("none");
}

function bounce() {
  level endon("game_ended");
  self endon("reset");
  bottompos = self.curorigin;
  toppos = self.curorigin + vectorscale((0, 0, 1), 12);
  while(true) {
    self.visuals[0] moveto(toppos, 0.5, 0.15, 0.15);
    self.visuals[0] rotateyaw(180, 0.5);
    self.visuals[1] moveto(toppos, 0.5, 0.15, 0.15);
    self.visuals[1] rotateyaw(180, 0.5);
    wait(0.5);
    self.visuals[0] moveto(bottompos, 0.5, 0.15, 0.15);
    self.visuals[0] rotateyaw(180, 0.5);
    self.visuals[1] moveto(bottompos, 0.5, 0.15, 0.15);
    self.visuals[1] rotateyaw(180, 0.5);
    wait(0.5);
  }
}

function checkallowspectating() {
  self endon("disconnect");
  wait(0.05);
  spectating::update_settings();
}

function should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isalive(self)) {
    return false;
  }
  if(isDefined(self.switching_teams)) {
    return false;
  }
  if(isDefined(attacker) && attacker == self) {
    return false;
  }
  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team) {
    return false;
  }
  if(isDefined(attacker) && (!isDefined(attacker.team) || attacker.team == "free") && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
    return false;
  }
  return true;
}

function onusedogtag(player) {
  if(player.pers["team"] == self.victimteam) {
    player.pers["rescues"]++;
    player.rescues = player.pers["rescues"];
    if(isDefined(self.victim)) {
      if(!level.gameended) {
        self.victim thread dt_respawn();
      }
    }
  }
}

function dt_respawn() {
  self thread waittillcanspawnclient();
}

function waittillcanspawnclient() {
  for(;;) {
    wait(0.05);
    if(isDefined(self) && (self.sessionstate == "spectator" || !isalive(self))) {
      self.pers["lives"] = 1;
      self thread[[level.spawnclient]]();
      continue;
    }
    return;
  }
}
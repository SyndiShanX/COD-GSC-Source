/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dogtags.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\util_shared;

#namespace dogtags;

init() {
  level.antiboostdistance = getgametypesetting(#"antiboostdistance");
  level.dogtags = [];
  callback::on_spawned(&on_spawn_player);
}

spawn_dog_tag(victim, attacker, on_use_function, objectives_for_attacker_and_victim_only) {
  if(isDefined(level.dogtags[victim.entnum])) {
    playFX("ui/fx_kill_confirmed_vanish", level.dogtags[victim.entnum].curorigin);
    level.dogtags[victim.entnum] notify(#"reset");
    var_5ee49ea8 = victim getspecialistindex();

    if(var_5ee49ea8 != level.dogtags[victim.entnum].var_5ee49ea8) {
      level.dogtags[victim.entnum].var_5ee49ea8 = var_5ee49ea8;
      level.dogtags[victim.entnum].visuals[0] setModel(victim getenemydogtagmodel());
      level.dogtags[victim.entnum].visuals[1] setModel(victim getfriendlydogtagmodel());
    }
  } else {
    visuals[0] = spawn("script_model", (0, 0, 0));
    visuals[0] setModel(victim getenemydogtagmodel());
    visuals[1] = spawn("script_model", (0, 0, 0));
    visuals[1] setModel(victim getfriendlydogtagmodel());
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level.dogtags[victim.entnum] = gameobjects::create_use_object(victim.team, trigger, visuals, (0, 0, 16), #"conf_dogtags");
    level.dogtags[victim.entnum] gameobjects::set_use_time(0);
    level.dogtags[victim.entnum].onuse = &onuse;
    level.dogtags[victim.entnum].custom_onuse = on_use_function;
    level.dogtags[victim.entnum].victim = victim;
    level.dogtags[victim.entnum].victimteam = victim.team;
    level.dogtags[victim.entnum].var_5ee49ea8 = victim getspecialistindex();
    level thread clear_on_victim_disconnect(victim);
    victim thread team_updater(level.dogtags[victim.entnum]);
  }

  pos = victim.origin + (0, 0, 14);
  level.dogtags[victim.entnum].curorigin = pos;
  level.dogtags[victim.entnum].trigger.origin = pos;
  level.dogtags[victim.entnum].visuals[0].origin = pos;
  level.dogtags[victim.entnum].visuals[1].origin = pos;
  level.dogtags[victim.entnum].visuals[0] dontinterpolate();
  level.dogtags[victim.entnum].visuals[1] dontinterpolate();
  level.dogtags[victim.entnum] gameobjects::allow_use(#"any");
  level.dogtags[victim.entnum].visuals[0] thread show_to_team(level.dogtags[victim.entnum], attacker.team);
  level.dogtags[victim.entnum].visuals[1] thread show_to_enemy_teams(level.dogtags[victim.entnum], attacker.team);
  level.dogtags[victim.entnum].attacker = attacker;
  level.dogtags[victim.entnum].attackerteam = attacker.team;
  level.dogtags[victim.entnum].unreachable = undefined;
  level.dogtags[victim.entnum].tacinsert = 0;

  if(isDefined(level.dogtags[victim.entnum].objectiveid)) {
    objective_setposition(level.dogtags[victim.entnum].objectiveid, pos);
    objective_setstate(level.dogtags[victim.entnum].objectiveid, "active");
  }

  if(objectives_for_attacker_and_victim_only) {
    objective_setinvisibletoall(level.dogtags[victim.entnum].objectiveid);

    if(isplayer(attacker)) {
      objective_setvisibletoplayer(level.dogtags[victim.entnum].objectiveid, attacker);
    }

    if(isplayer(victim)) {
      objective_setvisibletoplayer(level.dogtags[victim.entnum].objectiveid, victim);
    }
  }

  level.dogtags[victim.entnum] thread bounce();
  level notify(#"dogtag_spawned");
}

show_to_team(gameobject, show_team) {
  self show();

  foreach(team, _ in level.teams) {
    self hidefromteam(team);
  }

  self showtoteam(show_team);
}

show_to_enemy_teams(gameobject, friend_team) {
  self show();

  foreach(team, _ in level.teams) {
    self showtoteam(team);
  }

  self hidefromteam(friend_team);
}

onuse(player) {
  if(!isDefined(player) || !isDefined(self)) {
    return;
  }

  if(isDefined(self.visuals[0])) {
    self.visuals[0] playsoundtoplayer(#"hash_59915eb03bb56417", player);
    self.visuals[0] playsoundtoallbutplayer(#"mpl_killconfirm_tags_pickup", player);
  }

  tacinsertboost = 0;

  if(util::function_fbce7263(player.team, self.attackerteam)) {
    player stats::function_dad108fa(#"killsdenied", 1);
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
      player.pers[#"killsdenied"]++;
      player.killsdenied = player.pers[#"killsdenied"];
    }
  } else {
    event = "kill_confirmed";
    player stats::function_dad108fa(#"killsconfirmed", 1);
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

reset_tags() {
  self.attacker = undefined;
  self.unreachable = undefined;
  self notify(#"reset");
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  self.visuals[1].origin = (0, 0, 1000);
  self.tacinsert = 0;
  self gameobjects::allow_use(#"none");
  objective_setstate(self.objectiveid, "invisible");
}

onpickup(event) {
  scoreevents::processscoreevent(event, self, undefined, undefined);
}

clear_on_victim_disconnect(victim) {
  level endon(#"game_ended");
  guid = victim.entnum;
  victim waittill(#"disconnect");

  if(isDefined(level.dogtags[guid])) {
    level.dogtags[guid] gameobjects::allow_use(#"none");
    playFX("ui/fx_kill_confirmed_vanish", level.dogtags[guid].curorigin);
    level.dogtags[guid] notify(#"reset");
    waitframe(1);

    if(isDefined(level.dogtags[guid])) {
      objective_delete(level.dogtags[guid].objectiveid);
      level.dogtags[guid].trigger delete();

      for(i = 0; i < level.dogtags[guid].visuals.size; i++) {
        level.dogtags[guid].visuals[i] delete();
      }

      level.dogtags[guid] notify(#"deleted");
      level.dogtags[guid] = undefined;
    }
  }
}

on_spawn_player() {
  if(!(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn)) {
    return;
  }

  if(level.rankedmatch || level.leaguematch) {
    if(isDefined(self.tacticalinsertiontime) && self.tacticalinsertiontime + 100 > gettime()) {
      mindist = level.antiboostdistance;
      mindistsqr = mindist * mindist;
      distsqr = distancesquared(self.origin, level.dogtags[self.entnum].curorigin);

      if(distsqr < mindistsqr) {
        level.dogtags[self.entnum].tacinsert = 1;
      }
    }
  }
}

team_updater(tags) {
  level endon(#"game_ended");
  self endon(#"disconnect");

  while(true) {
    self waittill(#"joined_team");
    tags.victimteam = self.team;
    tags reset_tags();
  }
}

time_out(victim) {
  level endon(#"game_ended");
  victim endon(#"disconnect");
  self notify(#"timeout");
  self endon(#"timeout");
  level hostmigration::waitlongdurationwithhostmigrationpause(30);
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  self.visuals[1].origin = (0, 0, 1000);
  self.tacinsert = 0;
  self gameobjects::allow_use(#"none");
}

bounce() {
  level endon(#"game_ended");
  self endon(#"reset");
  bottompos = self.curorigin;
  toppos = self.curorigin + (0, 0, 12);

  while(true) {
    self.visuals[0] moveto(toppos, 0.5, 0.15, 0.15);
    self.visuals[0] rotateyaw(180, 0.5);
    self.visuals[1] moveto(toppos, 0.5, 0.15, 0.15);
    self.visuals[1] rotateyaw(180, 0.5);
    wait 0.5;
    self.visuals[0] moveto(bottompos, 0.5, 0.15, 0.15);
    self.visuals[0] rotateyaw(180, 0.5);
    self.visuals[1] moveto(bottompos, 0.5, 0.15, 0.15);
    self.visuals[1] rotateyaw(180, 0.5);
    wait 0.5;
  }
}

checkallowspectating() {
  self endon(#"disconnect");
  waitframe(1);
  spectating::update_settings();
}

should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
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

  if(isDefined(attacker) && (!isDefined(attacker.team) || attacker.team == "free") && (attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn")) {
    return false;
  }

  return true;
}

onusedogtag(player) {
  if(player.pers[#"team"] == self.victimteam) {
    player.pers[#"rescues"]++;
    player.rescues = player.pers[#"rescues"];

    if(isDefined(self.victim)) {
      if(!level.gameended) {
        self.victim thread dt_respawn();
      }
    }
  }
}

dt_respawn() {
  self thread waittillcanspawnclient();
}

waittillcanspawnclient() {
  for(;;) {
    wait 0.05;

    if(isDefined(self) && (self.sessionstate == "spectator" || !isalive(self))) {
      self.pers[#"lives"] = 1;
      self thread[[level.spawnclient]]();
      continue;
    }

    return;
  }
}
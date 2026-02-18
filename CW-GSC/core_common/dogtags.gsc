/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\dogtags.gsc
***********************************************/

#using script_7a8059ca02b7b09e;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
#namespace dogtags;

function init() {
  level.antiboostdistance = getgametypesetting(#"antiboostdistance");
  level.var_70e5d775 = getgametypesetting(#"hash_45b6991b1456a440");
  level.dogtags = [];
  level.var_f9800416 = getdvarint(#"hash_686978f3ee15ce69", 0);
  callback::on_spawned(&on_spawn_player);
  callback::on_player_killed(&on_player_killed);
  gameobjects::function_ad0c0995(&function_1d8e2a5b);
  clientfield::register("scriptmover", "dogtag_flag", 1, 2, "int");
  clientfield::register("scriptmover", "dogtag_clientnum", 20000, 5, "int");
}

function private function_bf06b7aa(victim, attacker, on_use_function, var_f75dca66, var_78bc5595) {
  dogtag = function_afe6cbc4(attacker);

  if(isDefined(dogtag)) {
    return dogtag;
  }

  if(is_true(getgametypesetting("dogTagPooling"))) {
    arrayremovevalue(level.dogtags, undefined, 0);
    poolsize = isDefined(getgametypesetting("dogTagPoolSize")) ? getgametypesetting("dogTagPoolSize") : 0;

    if(poolsize > 0 && level.dogtags.size > poolsize) {
      level.dogtags[0] reset_tags();
    }
  } else {
    arrayremovevalue(level.dogtags, undefined, 1);
  }

  visuals = [];

  if(is_true(var_f75dca66)) {
    trigger = spawn("trigger_radius_use", (0, 0, 0), 0, 80, 80);
    trigger usetriggerrequirelookat();
    trigger setcursorhint("HINT_ACTIVATE");
  } else {
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  }

  if(!level.var_f9800416) {
    trigger.var_a865c2cd = 0;
  }

  objectivename = isDefined(level.var_febab1ea) ? level.var_febab1ea : # "conf_dogtags";
  dogtag = gameobjects::create_use_object(attacker.team, trigger, visuals, (0, 0, 0), objectivename);
  trigger.dogtag = dogtag;
  dogtag gameobjects::set_use_time(0);
  dogtag.onuse = &onuse;
  dogtag.custom_onuse = on_use_function;
  dogtag.victim = attacker;
  dogtag.victimteam = attacker.team;
  dogtag.var_5ee49ea8 = attacker getspecialistindex();
  dogtag clientfield::set("dogtag_clientnum", attacker getentitynumber() + 1);

  if(level.var_70e5d775 === 1) {
    dogtag gameobjects::set_flags(1);
  }

  if(!is_true(var_78bc5595)) {
    level thread clear_on_victim_disconnect(attacker);
    attacker thread team_updater(dogtag);
  }

  if(is_true(getgametypesetting("dogTagPooling"))) {
    level.dogtags[level.dogtags.size] = dogtag;
  } else {
    level.dogtags[attacker getentitynumber()] = dogtag;
  }

  return dogtag;
}

function private function_329adc0f(dogtag) {
  dogtag gameobjects::allow_use(#"group_none");
  playFX("ui/fx_kill_confirmed_vanish", dogtag.curorigin);
  dogtag notify(#"reset");
  waitframe(1);

  if(isDefined(dogtag)) {
    if(isDefined(dogtag.objectiveid)) {
      objective_delete(dogtag.objectiveid);
    }

    if(isDefined(dogtag.var_2581d0d)) {
      dogtag.var_2581d0d deletedelay();
    }

    dogtag notify(#"deleted");
    dogtag gameobjects::destroy_object(1);

    if(!is_true(getgametypesetting("dogTagPooling"))) {
      arrayremovevalue(level.dogtags, undefined, 1);
      return;
    }

    arrayremovevalue(level.dogtags, undefined, 0);
  }
}

function private function_afe6cbc4(victim) {
  if(is_true(getgametypesetting("dogTagPooling"))) {
    return;
  }

  return level.dogtags[victim getentitynumber()];
}

function spawn_dog_tag(victim, attacker, on_use_function, objectives_for_attacker_and_victim_only, posoffset, var_f75dca66, var_1c1cfb90, var_78bc5595) {
  dogtag = function_afe6cbc4(victim);

  if(isDefined(dogtag)) {
    playFX("ui/fx_kill_confirmed_vanish", dogtag.curorigin);
    dogtag notify(#"reset");
    dogtag dontinterpolate();
    var_5ee49ea8 = victim getspecialistindex();

    if(var_5ee49ea8 != dogtag.var_5ee49ea8) {
      dogtag.var_5ee49ea8 = var_5ee49ea8;
    }

    if(isDefined(dogtag.var_2581d0d)) {
      dogtag.var_2581d0d delete();
      dogtag.var_2581d0d = undefined;
    }
  } else {
    dogtag = function_bf06b7aa(victim, attacker, on_use_function, var_f75dca66, var_78bc5595);
  }

  dogtag gameobjects::allow_use(#"group_all");
  baseoffset = (0, 0, 14);
  pos = victim.origin + baseoffset;

  if(isvec(posoffset)) {
    pos += posoffset;
  }

  dogtag.origin = pos;
  dogtag.curorigin = pos;
  dogtag.trigger.origin = pos;
  dogtag function_9b289986(dogtag.var_5ee49ea8);
  dogtag.team = victim.team;
  dogtag.attacker = attacker;
  dogtag.attackerteam = attacker.team;
  dogtag.unreachable = undefined;
  dogtag.tacinsert = 0;
  dogtag.var_d3faea9b = var_1c1cfb90;

  if(level.var_70e5d775 === 1) {
    dogtag playLoopSound(#"hash_68969eb52942d6a4");
  }

  if((isDefined(getgametypesetting("dogTagTimeOut")) ? getgametypesetting("dogTagTimeOut") : 0) > 0) {
    dogtag thread time_out(victim);
  }

  if(isDefined(dogtag.objectiveid)) {
    objective_setstate(dogtag.objectiveid, "active");
    objective_setteam(dogtag.objectiveid, victim.team);
    objective_setposition(dogtag.objectiveid, pos);
  }

  if(isDefined(dogtag.objectiveid) && objectives_for_attacker_and_victim_only) {
    objective_setinvisibletoall(dogtag.objectiveid);

    if(isPlayer(attacker)) {
      objective_setvisibletoplayer(dogtag.objectiveid, attacker);
    }

    if(isPlayer(victim)) {
      objective_setvisibletoplayer(dogtag.objectiveid, victim);
    }
  }

  playerinvehicle = victim isinvehicle() && !victim getvehicleoccupied() isremotecontrol();
  playerinwater = victim depthinwater() > abs(victim.origin[2] - pos[2]) && !playerinvehicle;
  var_f5ac9ac4 = victim oob::istouchinganyoobtrigger() || !victim oob::function_323d32db();

  if(!playerinwater && !var_f5ac9ac4 && !is_true(level.var_239d1e6a)) {
    dogtag function_78a745d7(pos, victim);
  } else {
    dogtag function_b2a61c9d();
  }

  level notify(#"dogtag_spawned");
  return dogtag;
}

function private function_9b289986(index = 0) {
  self function_209d6da2(index);
}

function function_78a745d7(var_561c6e7c, var_5bb2a7e9) {
  dropangles = (-60, randomint(360), 0);
  force = anglesToForward(dropangles) * randomfloatrange(150, 220);
  self.var_2581d0d = var_5bb2a7e9 magicmissile(getweapon(#"dogtag_drop"), var_561c6e7c, force);
  self.var_2581d0d setModel(#"tag_origin");
  self.var_2581d0d hide();
  self.var_2581d0d notsolid();
  self thread function_b9937933();
  self thread function_924c73e6();
  self clientfield::set("dogtag_flag", 1);
}

function function_b2a61c9d() {
  if(self clientfield::get("dogtag_flag") == 2) {
    self clientfield::set("dogtag_flag", 3);
    return;
  }

  self clientfield::set("dogtag_flag", 2);
}

function function_b9937933() {
  level endon(#"game_ended");
  self endon(#"reset");
  self.var_2581d0d endon(#"death", #"stationary");

  while(true) {
    if(!isDefined(self.var_2581d0d)) {
      return;
    }

    if(self depthinwater() > 0) {
      self.trigger.origin = self.var_2581d0d.origin;
      self.var_2581d0d notify(#"stationary");
      return;
    }

    if(self.var_2581d0d oob::istouchinganyoobtrigger() || !self.var_2581d0d oob::function_323d32db() || self.var_2581d0d gameobjects::is_touching_any_trigger_key_value("trigger_hurt", "classname", self.trigger.origin[2], self.trigger.origin[2] + 32)) {
      self.trigger.origin = self.var_2581d0d.origin;
      self.var_2581d0d notify(#"stationary");
      return;
    }

    self.trigger.origin = self.var_2581d0d.origin;
    waitframe(1);
  }
}

function function_924c73e6() {
  level endon(#"game_ended");
  self endon(#"reset");
  self.var_2581d0d endon(#"death");
  self.var_2581d0d waittill(#"stationary");
  self.trigger.origin = self.var_2581d0d.origin;
  self.origin = self.trigger.origin;
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.objectiveid)) {
    objective_setposition(self.objectiveid, self.origin);
  }

  self function_b2a61c9d();

  if(isDefined(self.var_2581d0d)) {
    self.var_2581d0d delete();
    self.var_2581d0d = undefined;
  }
}

function onuse(player) {
  if(!isDefined(player) || !isDefined(self)) {
    return;
  }

  if(player haspart("j_head") && !is_true(level.var_46b16649)) {
    if(level.var_70e5d775 === 1) {
      player playsoundontag(#"hash_792564c36f9555aa", "j_head");
    } else {
      player playsoundontag("mpl_killconfirm_tags_pickup", "j_head");
    }
  }

  if(!is_true(level.var_ccf9686a)) {
    tacinsertboost = 0;

    if(!util::function_fbce7263(player.team, self.victimteam)) {
      player stats::function_dad108fa(#"killsdenied", 1);
      player recordgameevent("return");
      level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
        #player: player, #eventtype: # "return"});
      event = "kill_denied";

      if(self.victim == player) {
        if(self.tacinsert == 0) {
          event = "retrieve_own_tags";
        } else {
          tacinsertboost = 1;
        }
      }

      if(!tacinsertboost) {
        player.pers[# "killsdenied"]++;
        player.killsdenied = player.pers[# "killsdenied"];
      }
    } else {
      event = "kill_confirmed";

      if(util::function_fbce7263(player.team, self.attackerteam)) {
        event = "squad_confirmed_kill_stolen";
      }

      player stats::function_dad108fa(#"killsconfirmed", 1);
      player recordgameevent("capture");
      level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
        #player: player, #eventtype: # "capture"});

      if(isDefined(self.attacker) && self.attacker != player && !util::function_fbce7263(player.team, self.attacker.team)) {
        self.attacker onpickup("teammate_kill_confirmed");
      }
    }

    if(!tacinsertboost && isDefined(player)) {
      player onpickup(event);
    }
  }

  if(isDefined(self.custom_onuse)) {
    [[self.custom_onuse]](player);
  }

  self reset_tags();
}

function reset_tags() {
  if(is_true(self.var_d3faea9b)) {
    return;
  }

  self.attacker = undefined;
  self.unreachable = 1;
  self notify(#"reset");
  self.curorigin = (0, 0, 5000);
  self.trigger.origin = (0, 0, 5000);
  self.tacinsert = 0;
  self gameobjects::allow_use(#"group_none");

  if(level.var_70e5d775 === 1) {
    self stoploopsound();
  }

  self clientfield::set("dogtag_flag", 0);

  if(isDefined(self.var_2581d0d)) {
    self.var_2581d0d deletedelay();
    self.var_2581d0d = undefined;
  }

  if(isDefined(self.objectiveid)) {
    objective_setstate(self.objectiveid, "invisible");
  }

  if(is_true(getgametypesetting("dogTagPooling"))) {
    thread function_329adc0f(self);
  }
}

function onpickup(event) {
  scoreevents::processscoreevent(event, self, undefined, undefined);
}

function clear_on_victim_disconnect(victim) {
  level endon(#"game_ended");
  guid = victim getentitynumber();
  victim waittill(#"disconnect");
  dogtag = function_afe6cbc4(victim);

  if(!isDefined(dogtag)) {
    return;
  }

  function_329adc0f(dogtag);
}

function on_spawn_player() {
  if(!(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn)) {
    return;
  }

  if(level.rankedmatch || level.leaguematch) {
    if(isDefined(self.tacticalinsertiontime) && self.tacticalinsertiontime + 100 > gettime()) {
      mindist = level.antiboostdistance;
      mindistsqr = mindist * mindist;
      dogtag = function_afe6cbc4(self);

      if(!isDefined(dogtag)) {
        return;
      }

      distsqr = distancesquared(self.origin, dogtag.curorigin);

      if(distsqr < mindistsqr) {
        dogtag.tacinsert = 1;
      }
    }
  }
}

function on_player_killed(params) {
  self endon(#"disconnect");

  if(is_true(level.droppedtagrespawn) && squad_spawn::function_d072f205()) {
    self squad_spawn::function_5f976259();

    var_f26d6aa7 = getdvarint(#"hash_40b119703c5fa11e", 0);

    if(var_f26d6aa7 > 0) {
      wait var_f26d6aa7;
      self dt_respawn();
    }
  }
}

function function_1d8e2a5b(activator) {
  if(isPlayer(activator) && activator isinvehicle()) {
    vehicle = activator getvehicleoccupied();
  }

  if(!isDefined(vehicle)) {
    return 0;
  }

  return vehicle.settings.var_a6f70f60;
}

function team_updater(tags) {
  level endon(#"game_ended");
  self endon(#"disconnect");

  while(true) {
    self waittill(#"joined_team");
    tags.victimteam = self.team;
    tags reset_tags();
  }
}

function time_out(victim) {
  level endon(#"game_ended");
  victim endon(#"disconnect");
  self notify(#"timeout");
  self endon(#"timeout", #"death", #"reset");
  timeout = isDefined(getgametypesetting("dogTagTimeOut")) ? getgametypesetting("dogTagTimeOut") : 0;
  level hostmigration::waitlongdurationwithhostmigrationpause(timeout);

  if(!isDefined(self)) {
    return;
  }

  self reset_tags();
}

function checkallowspectating() {
  self endon(#"disconnect");
  waitframe(1);
  spectating::update_settings();
}

function should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isalive(self)) {
    return false;
  }

  if(isDefined(self.switching_teams)) {
    return false;
  }

  if(isDefined(deathanimduration) && deathanimduration == self) {
    return false;
  }

  if(level.teambased && isDefined(deathanimduration) && isDefined(deathanimduration.team) && deathanimduration.team == self.team) {
    return false;
  }

  if(isDefined(deathanimduration) && (!isDefined(deathanimduration.team) || deathanimduration.team == # "none") && (deathanimduration.classname == "trigger_hurt" || deathanimduration.classname == "worldspawn")) {
    return false;
  }

  return true;
}

function onusedogtag(player) {
  if(player.pers[# "team"] == self.victimteam) {
    player.pers[# "rescues"]++;

    if(isDefined(self.victim)) {
      if(!level.gameended) {
        self.victim thread dt_respawn();
      }
    }

    return;
  }

  if(is_true(level.var_d0252074) && isDefined(self.victim)) {
    self.victim squad_spawn::function_44c6679();
  }
}

function dt_respawn() {
  if(is_true(level.var_d0252074)) {
    self.pers[# "lives"] = 1;
    self squad_spawn::function_6a7e8977();
    self squad_spawn::function_250e04e5();
    return;
  }

  self thread waittillcanspawnclient();
}

function waittillcanspawnclient() {
  for(;;) {
    wait 0.05;

    if(isDefined(self) && (self.sessionstate == "spectator" || !isalive(self))) {
      self.pers[# "lives"] = 1;
      self thread[[level.spawnclient]]();
      continue;
    }

    return;
  }
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1373.gsc
**************************************/

_id_4268() {
  _id_425C();
  thread _id_4269();
}

_id_4269() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    maps\_utility::_id_1654("_stealth_enabled");
    self waittill("enemy");

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    if(!isalive(self.enemy)) {
      continue;
    }
    if(!maps\_stealth_utility::_id_4208()) {
      if(!_id_426B(self.enemy)) {
        continue;
      }
    } else {
      maps\_stealth_threat_enemy::_id_4264("attack");

    }
    thread _id_426C();
    wait 10;

    while(isDefined(self.enemy) && maps\_utility::_id_1008("_stealth_enabled")) {
      var_0 = gettime() - self lastknowntime(self.enemy);

      if(20000 > var_0) {
        wait((20000 - var_0) * 0.001);
        continue;
      }

      if(distance(self.origin, self.enemy.origin) > self.enemy.maxvisibledist) {
        break;
      }

      wait 0.5;
    }

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    if(isDefined(self.enemy)) {
      maps\_stealth_shared_utilities::_id_41EC(self.enemy, 0);

    }
    self clearenemy();
    maps\_stealth_threat_enemy::_id_4264("reset");
  }
}

_id_426A(var_0) {
  if(maps\_utility::_id_1008("_stealth_bad_event_listener") || var_0._id_0B6E._id_41ED._id_41EE[self.unique_id] > self._id_0B6E._id_41ED._id_4262._id_4263) {
    maps\_stealth_threat_enemy::_id_4264("attack");
    return 1;
  }

  return 0;
}

_id_426B(var_0) {
  if(!isDefined(var_0._id_0B6E)) {
    return 1;

  }
  if(!isDefined(var_0._id_0B6E._id_41ED._id_41EE[self.unique_id])) {
    var_0._id_0B6E._id_41ED._id_41EE[self.unique_id] = 0;

  }
  for(;;) {
    var_0._id_0B6E._id_41ED._id_41EE[self.unique_id]++;

    if(_id_426A(var_0)) {
      return 1;

    }
    var_1 = var_0._id_0B6E._id_41ED._id_41EE[self.unique_id];
    maps\_stealth_threat_enemy::_id_4264("warning" + var_1);
    thread maps\_stealth_shared_utilities::_id_41EC(var_0);
    _id_4270(var_0);

    if(gettime() - self lastknowntime(var_0) > 500) {
      self clearenemy();
      return 0;
    }
  }
}

_id_426C() {
  self endon("death");
  self endon("pain_death");
  var_0 = self.enemy;
  self._id_0F9F = undefined;
  self[[self._id_0B6E._id_41ED._id_426D]]();

  if(isDefined(var_0)) {
    level._id_0B6E._id_1124._id_426E[self._id_204F] = var_0;

  }
  maps\_stealth_shared_utilities::_id_41DD("_stealth_spotted");
}

_id_426F() {
  wait 2.25;
}

_id_4270(var_0) {
  if(maps\_stealth_utility::_id_4271() || maps\_utility::_id_1008("_stealth_bad_event_listener")) {
    return;
  }
  var_1 = distance(self.origin, var_0.origin) * 0.0005;
  var_2 = level._id_0B6E._id_41ED._id_4272 + var_1;
  maps\_stealth_shared_utilities::_id_41D6("WARNING time = " + var_2);
  level endon(maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted"));
  self endon("_stealth_bad_event_listener");
  wait(var_2);
}

_id_4273(var_0) {
  self endon("death");

  for(;;) {
    self waittill(var_0, var_1, var_2);

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    if(maps\_utility::_id_133C("_stealth_behavior_asleep") && maps\_utility::_id_1008("_stealth_behavior_asleep")) {
      continue;
    }
    maps\_utility::_id_13DC("_stealth_bad_event_listener");
  }
}

_id_4274() {
  self endon("death");

  for(;;) {
    maps\_utility::_id_1654("_stealth_bad_event_listener");
    wait 0.65;
    maps\_utility::_id_13DE("_stealth_bad_event_listener");
  }
}

_id_4275(var_0, var_1) {
  maps\_utility::_id_13DE("_stealth_normal");
  self._id_0B6E._id_41ED._id_0EFE._id_4276[var_0] = var_1;
  self notify("event_awareness", var_0);
  level notify("event_awareness", var_0);
}

_id_4277(var_0) {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    self waittill(var_0, var_1, var_2);

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    switch (var_0) {
      case "awareness_alert_level":
        break;
      case "ai_event":
        if(!isDefined(self._id_0B6E._id_41ED._id_0EFE._id_4278[var_1])) {
          continue;
        }
        if(var_1 == "bulletwhizby" && (!isDefined(var_2.team) || var_2.team == self.team)) {
          continue;
        }
      default:
        maps\_stealth_shared_utilities::_id_41DD("_stealth_event");
        level thread _id_427A(self._id_204F);
        break;
    }

    _id_4275(var_1, var_2);
    waittillframeend;
  }
}

_id_4279(var_0) {
  self endon("death");
  self endon("pain_death");
  self._id_0B6E._id_41ED._id_0EFE._id_4276[var_0] = 1;

  for(;;) {
    self waittill(var_0, var_1);

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    maps\_stealth_shared_utilities::_id_41DD("_stealth_event");
    level thread _id_427A(self._id_204F);
    _id_4275(var_0, var_1);
    waittillframeend;
  }
}

_id_427A(var_0) {
  var_1 = "enemy_event_handle_clear:" + var_0 + " Proc";
  var_2 = "enemy_event_handle_clear:" + var_0 + " Cleared";
  level notify(var_1);
  level endon(var_1);
  wait 2;
  var_3 = maps\_stealth_shared_utilities::_id_41E1(var_0);

  if(var_3.size) {
    level maps\_utility::_id_09C9(maps\_utility::_id_2748, var_3, "event_awareness_waitclear_ai");
    level maps\_utility::_id_275A(var_1);
    level maps\_utility::_id_1DB1(maps\_utility::_id_1DAA, var_2);
    level thread maps\_utility::_id_275B();
    common_scripts\utility::array_thread(var_3, ::_id_427B, var_1);
    level waittill(var_2);
  }

  maps\_stealth_shared_utilities::_id_41E0("_stealth_event", var_0);
}

_id_427B(var_0) {
  level endon(var_0);
  _id_427C();
  self notify("event_awareness_waitclear_ai");
}

_id_427C() {
  self endon("death");
  waittillframeend;
  var_0 = 0;

  if(isDefined(self._id_1008["_stealth_behavior_first_reaction"])) {
    var_0 = maps\_utility::_id_1008("_stealth_behavior_first_reaction");

  }
  var_1 = 0;

  if(isDefined(self._id_1008["_stealth_behavior_reaction_anim"])) {
    var_0 = maps\_utility::_id_1008("_stealth_behavior_reaction_anim");

  }
  if(!var_0 && !var_1) {
    return;
  }
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "death");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "going_back");
  maps\_utility::_id_09CB();
  self endon("goal");
  var_2 = common_scripts\utility::array_combine(getaiarray("allies"), level.players);
  var_3 = level._id_0B6E._id_41ED._id_4221["hidden"]["crouch"];
  var_4 = var_3 * var_3;
  var_5 = 1;

  if(var_5) {
    var_5 = 0;

    foreach(var_7 in var_2) {
      if(distancesquared(self.origin, var_7.origin) < var_4) {
        continue;
      }
      var_5 = 1;
    }

    wait 1;
  }
}

_id_427D(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;

  for(;;) {
    if(!isalive(self)) {
      return;
    }
    self waittill(var_0, var_4, var_5);

    if(isalive(self) && !maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    switch (var_0) {
      case "death":
        var_2 = var_4;
        break;
      case "damage":
        var_2 = var_5;
        break;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    if(isplayer(var_2) || isDefined(var_2.team) && var_2.team != var_3) {
      break;
    }
  }

  if(!isDefined(self)) {
    return;
  }
  var_6 = getaispeciesarray("bad_guys", "all");
  var_7 = int(level._id_0B6E._id_41ED._id_425D[var_1][level._id_0B6E._id_41ED._id_4220]);

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    if(!isalive(var_6[var_8])) {
      continue;
    }
    if(!isDefined(var_6[var_8]._id_0B6E)) {
      continue;
    }
    if(distance(var_6[var_8].origin, self.origin) > var_7) {
      continue;
    }
    if(var_6[var_8] maps\_utility::_id_133C("_stealth_behavior_asleep") && var_6[var_8] maps\_utility::_id_1008("_stealth_behavior_asleep")) {
      continue;
    }
    var_6[var_8] maps\_utility::_id_13DC("_stealth_bad_event_listener");
  }
}

_id_425C() {
  self clearenemy();
  self._id_0B6E = spawnStruct();
  self._id_0B6E._id_41ED = spawnStruct();
  maps\_utility::_id_1402("_stealth_enabled");
  maps\_utility::_id_13DC("_stealth_enabled");
  maps\_utility::_id_1402("_stealth_normal");
  maps\_utility::_id_13DC("_stealth_normal");
  maps\_utility::_id_1402("_stealth_attack");
  maps\_stealth_shared_utilities::_id_41D9("_stealth_spotted");
  maps\_stealth_shared_utilities::_id_41D9("_stealth_event");
  maps\_stealth_shared_utilities::_id_41D9("_stealth_found_corpse");
  maps\_stealth_shared_utilities::_id_41DA();

  if(!isDefined(level._id_0B6E._id_41D0.sound["spotted"][self._id_204F])) {
    level._id_0B6E._id_41D0.sound["spotted"][self._id_204F] = 0;

  }
  self._id_0B6E._id_41ED._id_4262 = spawnStruct();
  self._id_0B6E._id_41ED._id_4262._id_4263 = 0;
  _id_4280();
  _id_427E();
}

_id_427E() {
  maps\_utility::_id_1402("_stealth_bad_event_listener");
  self._id_0B6E._id_41ED._id_0EFE = spawnStruct();
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  thread _id_4273("ai_event");
  thread _id_427D("damage", "ai_eventDistPain");
  thread _id_427D("death", "ai_eventDistDeath");
  thread _id_4274();
  self._id_0B6E._id_41ED._id_0EFE._id_4276 = [];
  self._id_0B6E._id_41ED._id_0EFE._id_4278 = [];
  self._id_0B6E._id_41ED._id_0EFE._id_4278["bulletwhizby"] = 1;
  self._id_0B6E._id_41ED._id_0EFE._id_4278["projectile_impact"] = 1;
  self._id_0B6E._id_41ED._id_0EFE._id_4278["gunshot_teammate"] = 1;
  self._id_0B6E._id_41ED._id_0EFE._id_4278["grenade danger"] = 1;
  thread _id_4277("ai_event");
  thread _id_4277("awareness_alert_level");
  thread _id_4277("awareness_corpse");
}

_id_427F(var_0) {
  self._id_0B6E._id_41ED._id_426D = var_0;
}

_id_4280() {
  self._id_0B6E._id_41ED._id_426D = ::_id_426F;
}
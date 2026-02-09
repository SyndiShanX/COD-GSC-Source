/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1372.gsc
**************************************/

_id_4249() {
  _id_425C();
  thread _id_424A();
}

_id_424A() {
  self endon("death");
  self endon("pain_death");

  if(self.type == "dog") {
    thread _id_424C();
  }
  for(;;) {
    self waittill("_stealth_enemy_alert_level_change", var_0);

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    _id_424B(var_0);
  }
}

_id_424B(var_0) {
  maps\_utility::_id_13DC("_stealth_enemy_alert_level_action");
  var_1 = var_0;

  if(issubstr(var_0, "warning")) {
    var_1 = "warning";
  }
  switch (var_1) {
    case "warning":
      thread _id_4251(var_0);
      break;
    case "attack":
      thread _id_4256();
      break;
    case "reset":
      thread _id_424F();
      break;
  }
}

_id_424C() {
  self endon("death");
  self endon("pain_death");

  if(!maps\_utility::_id_1008("_stealth_behavior_asleep")) {
    return;
  }
  _id_424D();
  wait 0.5;
  maps\_utility::delaythread(0.6, maps\_utility::_id_13DE, "_stealth_behavior_asleep");
  self.ignoreall = 0;
}

_id_424D() {
  self endon("pain");
  self endon("enemy");
  common_scripts\utility::array_thread(level.players, ::_id_424E, self, 128);

  for(;;) {
    self waittill("event_awareness", var_0);

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    if(var_0 == "heard_scream" || var_0 == "bulletwhizby" || var_0 == "projectile_impact" || var_0 == "explode") {
      return;
    }
  }
}

_id_424E(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!var_0 maps\_utility::_id_1008("_stealth_behavior_asleep")) {
    return;
  }
  var_0 endon("_stealth_behavior_asleep");
  var_2 = var_1 * var_1;

  while(distancesquared(self.origin, var_0.origin) > var_2 && maps\_utility::_id_1008("_stealth_enabled")) {
    wait 0.1;
  }
  var_0.ignoreall = 0;
  var_0.favoriteenemy = self;
  wait 0.1;
  var_0.favoriteenemy = undefined;
}

_id_424F() {
  self endon("_stealth_enemy_alert_level_change");
  self endon("enemy_awareness_reaction");
  self endon("death");
  self endon("pain_death");
  maps\_stealth_utility::_id_41CD();
  maps\_stealth_shared_utilities::_id_41EF();
  maps\_utility::_id_13DE("_stealth_enemy_alert_level_action");

  if(isDefined(self._id_0B6E._id_423A._id_4250)) {
    maps\_utility::_id_13DE("_stealth_saw_corpse");
    maps\_utility::_id_13DE("_stealth_found_corpse");
  }

  maps\_utility::_id_13DE("_stealth_attack");
  maps\_utility::_id_13DC("_stealth_normal");
  var_0 = maps\_stealth_shared_utilities::_id_41D2("threat", "reset");
  self thread[[var_0]]();
}

_id_4251(var_0) {
  var_1 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  self endon("_stealth_enemy_alert_level_change");
  level endon(var_1);
  self endon("death");
  self endon("pain_death");
  maps\_stealth_shared_utilities::_id_41F0();
  maps\_stealth_shared_utilities::_id_41EF();
  var_2 = maps\_stealth_shared_utilities::_id_41D2("threat", var_0);
  self[[var_2]]();
  _id_425A();
}

_id_4252(var_0) {
  var_1 = self.fovcosine;
  self.fovcosine = 0.1;
  maps\_utility::_id_26FA("_stealth_look_around");
  wait(var_0);
  maps\_utility::_id_26FC();
  self.fovcosine = var_1;
}

_id_4253() {
  self endon("death");
  wait 0.25;

  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    maps\_stealth_shared_utilities::_id_41FD("huh");
    thread maps\_stealth_shared_utilities::_id_41F7();
  } else {
    thread maps\_stealth_shared_utilities::_id_41F5();
  }
}

_id_4254() {
  if(!isDefined(self.enemy)) {
    return;
  }
  thread _id_4253();

  if(isDefined(self._id_2050)) {
    if(self.type != "dog") {
      var_0 = "a";

      if(common_scripts\utility::cointoss()) {
        var_0 = "b";
      }
      maps\_utility::_id_140B("_stealth_patrol_search_" + var_0, 1);
    } else {
      maps\_utility::_id_2080();
      self._id_23DB = 1;
    }

    self._id_117F = 1;
    self._id_1199 = 1;
  } else if(self.type == "dog") {
    maps\_utility::_id_2080();
    self._id_23DB = 1;
    self._id_117F = 1;
    self._id_1199 = 1;
  }

  var_1 = vectornormalize(self.enemy.origin - self.origin);
  var_2 = distance(self.enemy.origin, self.origin);
  var_2 = var_2 * 0.25;
  var_2 = clamp(var_2, 64, 128);
  var_1 = var_1 * var_2;
  var_3 = self.origin + var_1 + (0, 0, 16);
  var_4 = var_3 + (0, 0, -96);
  var_3 = physicstrace(var_3, var_4);

  if(var_3 == var_4) {
    return;
  }
  maps\_utility::_id_13DC("_stealth_override_goalpos");
  self setgoalpos(var_3);
  self.goalradius = 64;
  common_scripts\utility::waittill_notify_or_timeout("goal", 2);

  if(!self isingoal(self.origin)) {
    self._id_0CE5 = var_3 + (0, 0, 64);
  }
  _id_4252(10);
  self._id_0CE5 = undefined;
}

_id_4255() {
  if(!isDefined(self.enemy)) {
    return;
  }
  thread _id_4253();

  if(self.type != "dog") {
    maps\_utility::_id_140B("_stealth_patrol_cqb");
  } else {
    maps\_utility::_id_140C();
    self._id_206F = 1;
    self._id_23DB = 1;
  }

  self._id_117F = 0;
  self._id_1199 = 0;
  var_0 = self.enemy.origin;
  var_1 = distance(var_0, self.origin);
  maps\_utility::_id_13DC("_stealth_override_goalpos");
  self setgoalpos(var_0);
  self.goalradius = var_1 * 0.5;
  self waittill("goal");

  if(self.type != "dog") {
    var_2 = "_stealth_patrol_search_a";

    if(common_scripts\utility::cointoss()) {
      var_2 = "_stealth_patrol_search_b";
    }
    maps\_utility::_id_140B(var_2, 1);
  } else {
    maps\_anim::_id_11CC(self, "gravity", "_stealth_dog_stop");
    maps\_utility::_id_2080();
  }

  self setgoalpos(var_0);
  self.goalradius = 64;
  self._id_117F = 1;
  self._id_1199 = 1;
  self waittill("goal");
  _id_4252(15);

  if(self.type != "dog") {
    var_2 = "a";

    if(randomint(100) > 50) {
      var_2 = "b";
    }
    maps\_utility::_id_140B("_stealth_patrol_search_" + var_2, 1);
  } else {
    maps\_utility::_id_2080();
    self._id_23DB = undefined;
  }
}

_id_4256() {
  self endon("death");
  self endon("pain_death");
  self endon("_stealth_enemy_alert_level_change");
  self notify("endNewEnemyReactionAnim");
  self notify("movemode");
  self._id_117F = 0;
  self._id_1199 = 0;
  maps\_stealth_shared_utilities::_id_41F0();
  maps\_utility::_id_13DC("_stealth_attack");
  var_0 = maps\_stealth_shared_utilities::_id_41D2("threat", "attack");
  self[[var_0]]();
}

_id_4257() {
  thread maps\_stealth_shared_utilities::_id_41F8(self.origin);

  if(isDefined(self._id_1830)) {
    thread maps\_spawner::_id_21A0();
  } else {
    _id_4258();
  }
}

_id_4258() {
  var_0 = 2048;
  self.goalradius = var_0;

  if(isDefined(self._id_4259) && self._id_4259 == 1) {
    return;
  }
  self endon("death");
  maps\_utility::_id_13DC("_stealth_override_goalpos");

  while(isDefined(self.enemy) && maps\_utility::_id_1008("_stealth_enabled")) {
    self setgoalpos(self.enemy.origin);
    self.goalradius = var_0;

    if(var_0 > 600) {
      var_0 = var_0 * 0.75;
    } else {
      return;
    }
    wait 15;

    if(isDefined(self._id_4259) && self._id_4259 == 1) {
      return;
    }
  }
}

_id_425A() {
  _id_4260("reset");
  maps\_utility::_id_13DE("_stealth_enemy_alert_level_action");

  if(maps\_utility::_id_133C("_stealth_saw_corpse")) {
    maps\_utility::_id_13DB("_stealth_saw_corpse");
  }
  wait 0.05;

  if(maps\_utility::_id_133C("_stealth_found_corpse")) {
    maps\_utility::_id_13DB("_stealth_found_corpse");
  }
  maps\_utility::_id_13DC("_stealth_normal");
  var_0 = maps\_stealth_shared_utilities::_id_41D2("threat", "normal");
  self[[var_0]]();
}

_id_425B() {
  thread maps\_stealth_shared_utilities::_id_41F6();
  maps\_stealth_shared_utilities::_id_41E4();
}

_id_425C() {
  _id_425E();
  _id_4267();
  self._id_0B6E._id_423A._id_0AD9 = 1;
  self._id_4259 = 1;
  self.alertlevel = "noncombat";
  self.newenemyreactiondistsq = squared(level._id_0B6E._id_41ED._id_425D["ai_eventDistFootstepSprint"]["hidden"]);
}

_id_425E() {
  var_0 = [];
  var_0["reset"] = ::_id_425B;
  var_0["warning1"] = ::_id_4254;
  var_0["warning2"] = ::_id_4255;
  var_0["attack"] = ::_id_4257;
  var_0["normal"] = ::_id_425B;

  if(!isDefined(level._id_0B6E._id_41ED._id_425F)) {
    level._id_0B6E._id_41ED._id_425F = [];
    level._id_0B6E._id_41ED._id_425F["reset"] = "noncombat";
    level._id_0B6E._id_41ED._id_425F["warning"] = "alert";
    level._id_0B6E._id_41ED._id_425F["attack"] = "combat";
  }

  _id_4261(var_0);
}

_id_4260(var_0) {
  self.alertlevel = level._id_0B6E._id_41ED._id_425F[var_0];
}

_id_4261(var_0) {
  self._id_0B6E._id_41D0._id_41D1["threat"] = [];

  if(!isDefined(var_0["reset"])) {
    var_0["reset"] = ::_id_425B;
  }
  if(!isDefined(var_0["attack"])) {
    var_0["attack"] = ::_id_4257;
  }
  if(!isDefined(var_0["normal"])) {
    var_0["normal"] = ::_id_425B;
  }
  foreach(var_3, var_2 in var_0) {}
  maps\_stealth_shared_utilities::_id_41CF("threat", var_3, var_2);

  self._id_0B6E._id_41ED._id_4262._id_4263 = var_0.size - 3;
}

_id_4264(var_0) {
  self notify("_stealth_enemy_alert_level_change", var_0);

  if(!isDefined(self._id_0B6E._id_423A._id_0AD9)) {
    self.goalradius = level._id_2070;
    return;
  }

  if(issubstr(var_0, "warning")) {
    var_0 = "warning";
  }
  _id_4260(var_0);
  self notify("awareness_alert_level", var_0);
}

_id_4265() {
  var_0 = [];
  var_0["reset"] = _id_055B::_id_423F;
  var_0["warning"] = _id_055B::_id_423F;

  if(self.type == "dog") {
    var_0["attack"] = _id_055B::_id_4241;
  } else {
    var_0["attack"] = _id_055B::_id_423E;
  }
  return var_0;
}

_id_4266(var_0) {
  var_1 = _id_4265();

  if(!isDefined(var_0["reset"])) {
    var_0["reset"] = var_1["reset"];
  }
  if(!isDefined(var_0["warning"])) {
    var_0["warning"] = var_1["warning"];
  }
  if(!isDefined(var_0["attack"])) {
    var_0["attack"] = var_1["attack"];
  }
  foreach(var_4, var_3 in var_0) {}
  maps\_stealth_shared_utilities::_id_41CF("animation", var_4, var_3);
}

_id_4267() {
  var_0 = _id_4265();
  _id_4266(var_0);
}
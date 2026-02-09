/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1377.gsc
**************************************/

_id_428A() {
  _id_425C();
  thread _id_4299();
  thread _id_428B();
}

_id_428B() {
  self endon("death");
  self endon("pain_death");
  thread _id_428C();

  for(;;) {
    self waittill("_stealth_saw_corpse");

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    _id_428E();
  }
}

_id_428C() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  var_1 = maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");
  self endon("death");
  self endon("pain_death");

  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);

  for(;;) {
    maps\_utility::_id_1654("_stealth_enabled");

    if(maps\_utility::_id_133C("_stealth_behavior_asleep")) {
      maps\_utility::_id_13DB("_stealth_behavior_asleep");
    }
    maps\_stealth_utility::_id_428D();

    if(!maps\_utility::_id_1008("_stealth_enabled")) {
      continue;
    }
    while(maps\_stealth_utility::_id_4271()) {
      if(!maps\_utility::_id_1008("_stealth_enabled")) {
        break;
      }

      _id_4290();
      level waittill(var_1);
    }
  }
}

_id_428E() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  var_1 = maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");

  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  self endon("attack");
  level endon(var_1);

  for(;;) {
    maps\_utility::_id_13DB("_stealth_enemy_alert_level_action");
    _id_428F();
    self waittill("normal");
  }
}

_id_428F() {
  maps\_stealth_shared_utilities::_id_41F0();
  self endon("enemy_alert_level_change");
  thread maps\_stealth_shared_utilities::_id_41F5();
  maps\_utility::_id_13DC("_stealth_running_to_corpse");
  maps\_utility::_id_13DC("_stealth_override_goalpos");
  var_0 = self._id_0B6E._id_41D0._id_41D1["corpse"];
  self[[var_0["saw"]]]();
}

_id_4290() {
  maps\_stealth_shared_utilities::_id_41F0();

  if(!maps\_utility::_id_1008("_stealth_found_corpse")) {
    self notify("awareness_corpse", "heard_corpse", (0, 0, 0));
  }
  maps\_stealth_shared_utilities::_id_41EB();

  if(self.type == "dog") {
    maps\_utility::_id_13DC("_stealth_override_goalpos");
  }
  thread _id_4291();
  var_0 = self._id_0B6E._id_41D0._id_41D1["corpse"];
  self[[var_0["found"]]]();
}

_id_4291() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");
  level endon(var_0);
  waittillframeend;
  self endon("enemy_awareness_reaction");
  maps\_stealth_utility::_id_4292();
  maps\_utility::_id_13DC("_stealth_normal");
  var_1 = self._id_0B6E._id_41D0._id_41D1["corpse"];
  self thread[[var_1["reset"]]]();
}

_id_4293() {
  self._id_117F = 0;
  self._id_1199 = 0;

  if(self.type != "dog") {
    maps\_utility::_id_140B("_stealth_combat_jog");
  } else {
    maps\_utility::_id_140C();
    self._id_23DB = 1;
    self._id_206F = 1;
  }

  self.goalradius = 80;
  self setgoalpos(self._id_0B6E._id_41ED._id_4250.origin);
}

_id_4294() {
  if(self.type == "dog") {
    self setgoalpos(self.origin);
    return;
  }

  var_0 = maps\_stealth_shared_utilities::_id_41F3(level._id_0B6E._id_41ED._id_4250._id_4295, 512, 40);

  if(!isDefined(var_0)) {
    return;
  }
  thread maps\_stealth_shared_utilities::_id_41F2(var_0);
}

_id_4296() {
  self endon("death");
  wait(randomfloatrange(0, 5));
  maps\_stealth_shared_utilities::_id_41EF();
  maps\_stealth_threat_enemy::_id_4264("reset");
}

_id_4297(var_0) {
  var_1 = maps\_utility::_id_2608(var_0);
  var_2 = distance(var_1.origin, var_0);

  if(var_2 < 150) {
    return 1;
  }
  if(var_2 > level._id_0B6E._id_41ED._id_4250._id_4298) {
    return 0;
  }
  return sighttracepassed(var_0 + (0, 0, 48), var_1 getEye(), 0, var_1);
}

_id_4299() {
  self endon("death");
  self endon("pain_death");
  thread _id_42A1();

  for(;;) {
    if(maps\_utility::_id_133C("_stealth_behavior_asleep")) {
      maps\_utility::_id_13DB("_stealth_behavior_asleep");
    }
    maps\_utility::_id_1654("_stealth_enabled");

    while(!maps\_stealth_utility::_id_4208() && !maps\_utility::_id_1008("_stealth_attack")) {
      var_0 = 0;
      var_1 = 0;
      var_2 = undefined;
      var_3 = undefined;
      var_4 = _id_42A9();

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_2 = var_4[var_5];

        if(isDefined(var_2._id_1E33)) {
          continue;
        }
        if(!isDefined(level._id_429A)) {
          if(!_id_4297(var_2.origin)) {
            continue;
          }
        }

        var_6 = distancesquared(self.origin, var_2.origin);

        if(self.type != "dog") {
          var_3 = level._id_0B6E._id_41ED._id_4250._id_429B;
        } else {
          var_3 = level._id_0B6E._id_41ED._id_4250._id_429C;
        }
        if(var_6 < var_3) {
          var_0 = 1;
          break;
        }

        if(isDefined(self._id_0B6E._id_41ED._id_4250._id_429D)) {
          if(self._id_0B6E._id_41ED._id_4250._id_429D == var_2) {
            continue;
          }
          var_7 = distancesquared(self.origin, self._id_0B6E._id_41ED._id_4250._id_429D.origin);

          if(var_7 <= var_6) {
            continue;
          }
        }

        if(var_6 > level._id_0B6E._id_41ED._id_4250._id_429E) {
          continue;
        }
        if(var_6 < level._id_0B6E._id_41ED._id_4250._id_429F) {
          if(self cansee(var_2)) {
            var_1 = 1;
            break;
          }
        }

        var_8 = self gettagangles("tag_eye");
        var_9 = self getEye();
        var_10 = anglesToForward(var_8);
        var_11 = vectornormalize(var_2.origin - var_9);

        if(vectordot(var_10, var_11) > 0.55) {
          if(self cansee(var_2)) {
            var_1 = 1;
            break;
          }
        }
      }

      if(var_0) {
        if(!maps\_utility::_id_1008("_stealth_found_corpse")) {
          maps\_utility::_id_13DC("_stealth_found_corpse");
        } else {
          self notify("_stealth_found_corpse");
        }
        maps\_utility::_id_13DE("_stealth_saw_corpse");
        thread _id_42A3(var_2);
        self notify("awareness_corpse", "found_corpse", var_2);
      } else if(var_1) {
        self._id_0B6E._id_41ED._id_4250._id_429D = var_2;
        self._id_0B6E._id_41ED._id_4250.origin = var_2.origin;

        if(!maps\_utility::_id_1008("_stealth_saw_corpse")) {
          maps\_utility::_id_13DC("_stealth_saw_corpse");
        } else {
          self notify("_stealth_saw_corpse");
        }
        level notify("_stealth_saw_corpse");
        self notify("awareness_corpse", "saw_corpse", var_2);
      }

      wait 0.5;
    }

    _id_42A0();
    maps\_stealth_utility::_id_41CD();
    maps\_utility::_id_13DB("_stealth_attack");
  }
}

_id_42A0() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");

  while(common_scripts\utility::flag(var_0)) {
    var_1 = _id_42A9();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isDefined(var_3._id_1E33)) {
        continue;
      }
      var_4 = distancesquared(self.origin, var_3.origin);

      if(self.type != "dog") {
        var_5 = level._id_0B6E._id_41ED._id_4250._id_429B;
      } else {
        var_5 = level._id_0B6E._id_41ED._id_4250._id_429C;
      }
      if(var_4 < var_5) {
        var_3 setcorpseremovetimer(10);
        var_3._id_1E33 = 1;
      }
    }

    wait 0.5;
  }
}

_id_42A1() {
  self endon("death");
  self endon("pain_death");
  var_0 = maps\_stealth_utility::_id_4216();

  for(;;) {
    level waittill(var_0);

    if(!maps\_stealth_utility::_id_4271()) {
      continue;
    }
    _id_42A2();
  }
}

_id_42A2() {
  var_0 = undefined;

  if(isDefined(self.enemy)) {
    var_0 = self.enemy;
  } else {
    var_0 = common_scripts\utility::random(level.players);
  }
  if(!isDefined(var_0._id_0B6E._id_41ED._id_41EE[self.unique_id])) {
    var_0._id_0B6E._id_41ED._id_41EE[self.unique_id] = 0;
  }
  if(var_0._id_0B6E._id_41ED._id_41EE[self.unique_id] < self._id_0B6E._id_41ED._id_4262._id_4263) {
    var_0._id_0B6E._id_41ED._id_41EE[self.unique_id]++;
    thread maps\_stealth_shared_utilities::_id_41EC(var_0);
  }
}

_id_42A3(var_0) {
  self endon("death");
  level._id_0B6E._id_41ED._id_4250._id_4295 = var_0.origin;
  var_0 setcorpseremovetimer(level._id_0B6E._id_41ED._id_4250._id_42A4);
  var_0._id_1E33 = 1;

  if(self.type == "dog" && maps\_utility::_id_133C("_stealth_behavior_reaction_anim_in_progress")) {
    wait 0.1;
    maps\_utility::_id_13DB("_stealth_behavior_reaction_anim_in_progress");
    wait 0.5;
  } else {
    wait 2;
  }
  thread maps\_stealth_shared_utilities::_id_41FB();
  wait 2;
  var_1 = maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");

  if(!maps\_stealth_utility::_id_4271()) {
    maps\_stealth_shared_utilities::_id_41DD("_stealth_found_corpse");
  } else {
    level notify(var_1);
  }
  thread _id_42A5();
}

_id_42A5() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");
  var_1 = self._id_204F;
  level endon(var_0);
  maps\_utility::_id_2636(maps\_stealth_shared_utilities::_id_41E1(var_1), undefined, level._id_0B6E._id_41ED._id_4250._id_42A4);
  thread maps\_stealth_shared_utilities::_id_41E0("_stealth_found_corpse", var_1);
}

_id_425C() {
  self._id_0B6E._id_41ED._id_4250 = spawnStruct();
  self._id_0B6E._id_41ED._id_4250._id_429D = undefined;
  maps\_utility::_id_1402("_stealth_saw_corpse");
  maps\_utility::_id_1402("_stealth_found_corpse");
  _id_42A7();
  _id_42A6();
  self._id_0B6E._id_423A._id_4250 = 1;
}

_id_42A6() {
  if(self.type == "dog") {
    maps\_stealth_shared_utilities::_id_41CF("animation", "heard_corpse", _id_055B::_id_4241);
    maps\_stealth_shared_utilities::_id_41CF("animation", "saw_corpse", _id_055B::_id_4245);
    maps\_stealth_shared_utilities::_id_41CF("animation", "found_corpse", _id_055B::_id_4248);
    maps\_stealth_shared_utilities::_id_41CF("animation", "howl", _id_055B::_id_4246);
  } else {
    maps\_stealth_shared_utilities::_id_41CF("animation", "heard_corpse", _id_055B::_id_4240);
    maps\_stealth_shared_utilities::_id_41CF("animation", "saw_corpse", _id_055B::_id_4244);
    maps\_stealth_shared_utilities::_id_41CF("animation", "found_corpse", _id_055B::_id_4247);
  }
}

_id_42A7() {
  var_0 = [];
  var_0["saw"] = ::_id_4293;
  var_0["found"] = ::_id_4294;
  var_0["reset"] = ::_id_4296;
  _id_42A8(var_0);
}

_id_42A8(var_0) {
  foreach(var_3, var_2 in var_0) {}
  maps\_stealth_shared_utilities::_id_41CF("corpse", var_3, var_2);
}

_id_42A9() {
  if(isDefined(level._id_0B6E._id_41ED._id_4250._id_42AA)) {
    return [[level._id_0B6E._id_41ED._id_4250._id_42AA]]();
  }
  return getcorpsearray();
}
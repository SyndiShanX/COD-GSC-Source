/****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states.gsc
****************************************************************************/

_id_528A() {
  _id_0547::_id_7BD0("zombie_attack_tower_lever", ::_id_767A, ::_id_767B, 3.75);
  _id_0547::_id_7BD0("zombie_idle_at_tower", ::_id_767C, ::_id_767D, 3.25);
}

_id_8601(var_0) {
  _id_85A9();
  self._id_9ACD = "attacking point";
  thread _id_0547::_id_7D1A("zombie_attack_tower_lever", [var_0]);
}

_id_85A9() {
  if(common_scripts\utility::_id_562E(self._id_0C29) || !isDefined(self._id_0C29)) {
    self._id_0C2A = 1;
    self._id_0C29 = 0;
  }
}

_id_85AA() {
  if(common_scripts\utility::_id_562E(self._id_0C2A)) {
    self._id_0C2A = undefined;
    self._id_0C29 = 1;
  }
}

_id_767A(var_0) {
  _id_7679(var_0, "zombie_attack_tower_lever");
}

_id_767B(var_0) {
  _id_85AA();
  self notify("clear_tower_behavior");
}

_id_8602(var_0) {
  self._id_9ACD = "idling at tower";
  thread _id_0547::_id_7D1A("zombie_idle_at_tower", [var_0]);
}

_id_767C(var_0) {
  thread _id_7679(var_0, "idle_noncombat");
}

_id_767D() {
  self notify("clear_tower_behavior");
}

_id_8603(var_0) {
  _id_85A9();
  self._id_9ACD = "travel to attack";
  self._id_6941 = 1;
  thread _id_84E7(var_0);
}

_id_8604(var_0) {
  self._id_9ACD = "travel to idle";
  self._id_6941 = 1;
  thread _id_84E8(var_0);
}

_id_23A0() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2))
      var_2 _id_8605();
  }

  foreach(var_5 in level._id_08CB)
  maps\mp\mp_zombie_nest_special_event_creator_interface::_id_23C4(var_5);
}

_id_8605(var_0) {
  _id_85AA();
  self._id_6941 = 0;
  self._id_9B61 = undefined;
  self._id_60D0 = undefined;
  self notify("clear_tower_behavior");

  if(!common_scripts\utility::_id_562E(var_0))
    self._id_9ACD = "not interested";
  else
    self._id_9ACD = "ignore the tower";
}

_id_9BCF(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0._id_9B61)) {
    var_4 = var_0._id_9B61;
    var_4._id_65FB = var_1;
    var_0 _id_8605();
    var_1 _id_8603(var_4);
    var_3 = 1;
  }

  return var_3;
}

_id_84E7(var_0) {
  self endon("death");
  self endon("clear_tower_behavior");
  self._id_9B61 = var_0;
  _id_A658(var_0, 32, 0);
  _id_8601(var_0);
}

_id_84E8(var_0) {
  self endon("death");
  self endon("clear_tower_behavior");
  _id_A658(var_0, 32, 0);
  _id_8602(var_0);
}

_id_24E4() {
  var_0 = _id_0547::_id_408F();
  var_1 = getdvarint("scr_zombieactivatehudoutline_tower", 0);

  foreach(var_3 in var_0) {
    if(common_scripts\utility::_id_562E(var_3._id_5539)) {
      continue;
    }
    if(!isDefined(var_3._id_9ACD))
      var_4 = "";
    else
      var_4 = var_3._id_9ACD;

    var_3 _meth_83FF();

    switch (var_4) {
      case "not interested":
        if(var_1 == 3)
          var_3 _meth_83FE(0, 0);

        break;
      case "travel to idle":
        if(var_1 == 3)
          var_3 _meth_83FE(0, 0);

        break;
      case "travel to attack":
        if(var_1 >= 2)
          var_3 _meth_83FE(2, 0);

        break;
      case "idling at tower":
        if(var_1 == 3)
          var_3 _meth_83FE(0, 0);

        break;
      case "attacking point":
        if(var_1 >= 1)
          var_3 _meth_83FE(1, 0);

        break;
      case "ignore the tower":
        if(var_1 == 3)
          var_3 _meth_83FE(1, 0);

        break;
    }
  }
}

_id_250A(var_0) {}

_id_7714() {}

_id_A7F2() {
  return isDefined(self._id_9ACD) && (self._id_9ACD == "travel to attack" || self._id_9ACD == "attacking point");
}

_id_A7F4() {
  return isDefined(self._id_9ACD) && (self._id_9ACD == "travel to idle" || self._id_9ACD == "idling at tower");
}

_id_7679(var_0, var_1) {
  self endon("death");
  self endon("clear_tower_behavior_handled");
  thread _id_49A2(level._id_7AC8);
  self.angles = var_0.angles;
  self setOrigin(var_0.origin);
  maps\mp\mp_zombie_nest_ee_util::_id_8579(var_0.angles);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "tower_objective");
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1, undefined, 1);

  for(;;) {
    if(common_scripts\utility::_id_562E(self._id_2FDA)) {
      _id_8605(1);
      break;
    }

    var_3 = maps\mp\mp_zombie_nest_ee_util::_id_7AC3(var_2);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_3, 1.0, "scripted_anim");
  }
}

_id_3E77() {
  return !(_id_053C::_id_AB86() || _id_053C::_id_5686());
}

_id_561E() {
  return common_scripts\utility::_id_562E(self._id_561D);
}

_id_5629() {
  return common_scripts\utility::_id_562E(self._id_98EF) || common_scripts\utility::_id_562E(self._id_AC06);
}

_id_9E0E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = maps\mp\mp_zombie_nest_special_event_creator_interface::_id_9959();

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = common_scripts\utility::random(var_1);

    if(maps\mp\mp_zombie_nest_special_event_creator_interface::_id_ABD2(var_0[var_6])) {
      continue;
    }
    if(var_0[var_6] _id_A7F2()) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_0[var_6]._id_60D0)) {
      continue;
    }
    if(!var_0[var_6] _id_0547::_id_4B2C()) {
      continue;
    }
    if(!var_0[var_6] _id_5552(var_3)) {
      continue;
    }
    if(var_0[var_6] _id_561C()) {
      continue;
    }
    if(isDefined(var_7)) {
      var_8 = _id_412A(var_7);
      var_9 = _id_AB87(var_0[var_6], var_8, var_7);
      var_10 = 0;

      if(isDefined(var_9))
        var_10 = _id_9BCF(var_9, var_0[var_6], var_7);

      if(!var_10 && _id_1172(var_1) && !_id_AC05(var_8, var_4))
        _id_9E10(var_0[var_6], var_7);
    }
  }

  if(var_5) {
    var_0 = _id_0547::_id_408F();

    foreach(var_12 in var_0) {
      if(!var_12 _id_A7F2())
        var_12 _id_8605();
    }
  }
}

_id_5552(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(self._id_0A4B) && self._id_0A4B == var_0[var_1])
      return 1;
  }

  return 0;
}

_id_7C0F(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    for(var_4 = 0; var_4 < var_0[var_3]._id_AB4E.size; var_4++) {
      var_5 = var_0[var_3]._id_AB4E[var_4]._id_65FB;

      if(isDefined(var_5) && isalive(var_5)) {
        if(var_5 _id_3E77()) {
          if(var_5 _id_561C() || common_scripts\utility::_id_562E(var_5._id_2FDA) || !var_5 _id_5552(var_1)) {
            if(common_scripts\utility::_id_562E(var_5._id_2FDA) || !var_5 _id_5552(var_1))
              var_5 _id_8605(1);
            else if(var_5 _id_561C())
              var_5 _id_8605();

            var_5 notify("is_tower_battle_distracted");
            var_0[var_3]._id_AB4E[var_4] _id_23D5();
          } else {
            var_5 notify("is_tower_battle_focused");
            var_5 _id_8419(var_0[var_3]._id_AB4E[var_4]);
          }

          continue;
        }

        var_5 notify("is_tower_battle_distracted");
        var_2 = 1;
      }
    }
  }

  return var_2;
}

_id_561C() {
  return _id_5629() || _id_561E();
}

_id_A658(var_0, var_1, var_2) {
  while(distance(var_0.origin, self.origin) > var_1)
    wait 0.1;
}

_id_49A2(var_0) {
  self endon("death");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    thread _id_A645(var_0[var_1]);

  self waittill("tower_behavior_cancel_reason_found");
  self notify("clear_tower_behavior_handled");
  _id_8605();
  waitframe();
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "tower_objective");
  self _meth_83A2(0);
  self _meth_839D("gravity");
}

_id_A645(var_0) {
  self endon("tower_behavior_cancel_reason_found");
  self endon("death");
  self waittill(var_0);
  self notify("tower_behavior_cancel_reason_found");
}

_id_AB87(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(isDefined(var_1[var_4]._id_9ACD) && common_scripts\utility::_id_562E(var_1[var_4]._id_9ACD != "attacking point") && distance(var_0.origin, var_2.origin) < distance(var_1[var_4].origin, var_2.origin))
      return var_1[var_4];
  }

  return undefined;
}

_id_A63F() {
  var_0 = 1;

  while(var_0) {
    var_1 = _id_0547::_id_408F();
    var_0 = 0;

    foreach(var_3 in var_1) {
      if(!var_3 _id_3E77()) {
        var_0 = 1;
        break;
      }
    }

    wait 0.125;
  }
}

_id_10DB(var_0, var_1) {
  var_2 = _id_459C(var_1);
  var_2._id_65FB = var_0;
  var_0._id_9B61 = var_2;
  var_0 _id_8604(var_2);
}

_id_AC05(var_0, var_1) {
  return !(var_0.size < var_1);
}

_id_9E10(var_0, var_1) {
  var_2 = _id_9E0B(var_1);

  if(isDefined(var_2))
    _id_10CD(var_0, var_2, self);
}

_id_ABF5(var_0) {
  return !(var_0 _id_A7F4() || var_0 _id_A7F2());
}

_id_1172(var_0) {
  return var_0.size > 0;
}

_id_50A4() {
  return isDefined(self._id_9ACD) && common_scripts\utility::_id_562E(self._id_9ACD == "ignore the tower");
}

_id_8419(var_0) {
  if(!isDefined(self._id_9ACD) || !(self._id_9ACD == "travel to attack" || self._id_9ACD == "attacking point"))
    _id_8603(var_0);
}

_id_23D5() {
  self._id_65FB = undefined;
}

_id_412A(var_0) {
  var_1 = 0;
  var_2 = [];

  for(var_3 = 0; var_3 < var_0._id_AB4E.size; var_3++) {
    var_4 = var_0._id_AB4E[var_3]._id_65FB;

    if(isDefined(var_4) && isalive(var_4))
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
  }

  return var_2;
}

_id_8F14(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance(var_0, var_3.origin) < var_1)
      return 1;
  }

  return 0;
}

_id_425A(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = _id_0547::_id_4090(var_0[var_3]);
    var_2 = common_scripts\utility::_id_0F73(var_2, var_4);
  }

  var_2 = common_scripts\utility::_id_40B0(var_1, var_2);
  return var_2;
}

_id_4082(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2] maps\mp\mp_zombie_nest_ee_util::_id_442B();

    if(isDefined(var_3))
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_0[var_2]);
  }

  return var_1;
}

_id_10CD(var_0, var_1, var_2) {
  if(!_id_7590(var_0, var_1._id_7588._id_AB4E)) {
    var_0._id_9B61 = var_1._id_9110;
    var_0._id_60D0 = 1;
    var_1._id_9110._id_65FB = var_0;
  }
}

_id_52DD(var_0) {
  for(var_1 = 0; var_1 < self.size; var_1++) {
    var_2 = var_0._id_38C4["objectiveHealth"];
    self[var_1]._id_AB4E = common_scripts\utility::_id_46B7(self[var_1].target, "targetname");

    for(var_3 = 0; var_3 < self[var_1]._id_AB4E.size; var_3++) {
      self[var_1]._id_AB4E[var_3]._id_38B2 = var_0._id_38C3;
      self[var_1]._id_AB4E[var_3]._id_69A5 = 0;
    }

    self[var_1]._id_28FC = 0;
    self[var_1]._id_28FF = var_2;
    self[var_1]._id_6057 = var_2;

    if(isDefined(self[var_1]._id_65E8)) {
      foreach(var_5 in self[var_1]._id_65E8) {
        var_6 = common_scripts\utility::_id_4461(var_5.origin, var_0._id_ABEA._id_1176, 250);

        if(isDefined(var_6))
          var_5._id_65DE = var_6;
      }
    }
  }
}

_id_459C(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] maps\mp\mp_zombie_nest_ee_util::_id_996A())
      return var_0[var_1];
  }

  return common_scripts\utility::random(var_0);
}

_id_7590(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] _id_7591(var_0))
      return 1;
  }

  return 0;
}

_id_7591(var_0) {
  return isDefined(self._id_65FB) && isalive(self._id_65FB) && self._id_65FB == var_0;
}

_id_9E0B(var_0) {
  var_1 = spawnStruct();
  var_1._id_7588 = var_0;
  var_1._id_9110 = var_1._id_7588 maps\mp\mp_zombie_nest_ee_util::_id_442B();

  if(isDefined(var_1._id_7588) && isDefined(var_1._id_9110))
    return var_1;
  else
    return undefined;
}
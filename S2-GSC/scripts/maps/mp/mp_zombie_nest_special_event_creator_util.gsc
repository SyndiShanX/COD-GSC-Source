/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_special_event_creator_util.gsc
*************************************************************************/

_id_2C2C(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(isDefined(var_5.getnegotiationnextnode)) {
      var_5._id_68A2 = 0;
      var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
    }
  }

  var_0 thread _id_2D33(var_3);
  var_7 = maps\mp\agents\_agent_utility::_id_43FD("all");
  var_7 = common_scripts\utility::array_randomize(var_7);

  foreach(var_9 in var_7) {
    if(!var_9 maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_A7F2()) {
      var_9 notify("lose_focus");
      var_9._id_1924 = undefined;
      var_9._id_8BA3 = 0;
      var_9._id_9966 = 0;
      continue;
    }

    var_9._id_8BA3 = 1;

    if(common_scripts\utility::_id_562E(var_9._id_9966)) {
      continue;
    }
    if(isDefined(var_9._id_1924)) {
      continue;
    }
    if(!isDefined(var_9._id_0A4B)) {
      continue;
    }
    if(var_9._id_000A == level._id_746E) {
      continue;
    }
    if(var_9._id_0A4B != "zombie_generic" && var_9._id_0A4B != "zombie_berserker") {
      continue;
    }
    if(var_9 _id_0547::_id_53DC()) {
      continue;
    }
    var_10 = distance(var_9.origin, var_0._id_ABEA._id_38B7);

    if(var_10 < var_1) {
      continue;
    }
    var_9 thread _id_20C6(var_3, var_0._id_ABEA._id_38B7);
  }
}

_id_4DED(var_0) {
  self endon("stop_sould_bucket_leak");

  for(;;) {
    var_1 = 0;

    while(!var_1) {
      var_2 = self._id_AC2C;
      wait(var_0);

      if(self._id_AC2C <= var_2)
        var_1 = 1;
    }

    _id_35FC();
  }
}

_id_35FC() {
  self endon("stop_sould_bucket_leak");
  level endon(self._id_695B);

  while(self._id_AC2C > 0) {
    self._id_AC2C--;
    wait 0.25;
  }

  self._id_AC2C = 0;
}

_id_9408() {
  self notify("stop_sould_bucket_leak");
}

_id_2B65(var_0, var_1) {}

_id_2D33(var_0) {
  level waittill("tower battle reset despawners");
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1) {
    var_3._id_1924 = undefined;
    var_3._id_8BA3 = 0;
  }

  level notify("tower battle reset despawners done");
}

_id_20C6(var_0, var_1) {
  self endon("death");
  self._id_9966 = 1;
  wait(randomint(4) + 1);

  if(!isDefined(self._id_0A4B) || !isalive(self)) {
    return;
  }
  if(_id_0547::_id_4B2C() && !common_scripts\utility::_id_562E(self._id_4B9F))
    _id_ABE1();

  var_2 = _id_410B(var_0);
  self._id_1924 = var_2;
  var_2._id_68A2++;
  thread _id_2B79(var_2);
  thread _id_9E20();
  self._id_9966 = 0;
}

_id_410B(var_0) {
  var_1 = common_scripts\utility::_id_40B0(self.origin, var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2]._id_68A2 <= 4 && _abs(var_1[var_2].origin[2] - self.origin[2]) < 256)
      return var_1[var_2];
  }

  return var_1[0];
}

_id_2B79(var_0) {
  level endon("tower battle reset despawners");
  self waittill("death");
  var_0._id_68A2--;
  var_0 notify("despawner used");
}

_id_9E20() {
  self endon("death");
  self endon("lose_focus");
  var_0 = self._id_0A4B;

  while(isalive(self) && isDefined(self._id_1924) && distance(self.origin, self._id_1924.origin) > 48)
    wait 0.1;

  self suicide();
  self._id_1924 = undefined;

  if(_id_0547::_id_0796()) {
    var_1 = _id_055A::_id_4696(var_0, 0, 0, maps\mp\mp_zombie_nest_special_event_creator_interface::_id_405B());
    var_2 = _id_054D::_id_90BA(var_0, var_1, "tower_respawn");
  }
}

_id_ABE1() {
  self endon("death");
  self._id_4B9F = 1;
  var_0 = "board_taunt";
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0, undefined, 1);

  if(isDefined(var_1)) {
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1.0, "taunt_anim");
    self scragentsetscripted(0);
  }
}

_id_93F8(var_0) {
  var_0._id_7B8C notify(var_0._id_38C3);
}

_id_27CE(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 + 1 < var_0.size; var_2 = var_2 + 2) {
    for(var_3 = 0; var_3 < var_0[var_2 + 1]; var_3++)
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_0[var_2]);
  }

  return common_scripts\utility::array_randomize(var_1);
}

_id_11B2(var_0) {
  level notify("attack_spots_display_start");

  switch (var_0.size) {
    case 2:
      _id_8A06(var_0[0], "a");
      _id_8A06(var_0[1], "b");
      _setomnvar("ui_zm_waypoint_ents_type", 2);
      break;
    case 1:
      _id_8A06(var_0[0], "a");
      _setomnvar("ui_zm_waypoint_ents_type", 1);
      break;
    default:
      break;
  }
}

_id_8A06(var_0, var_1) {
  var_0._id_3012 = "ui_zm_waypoint_ent_" + var_1;
  var_0._id_3013 = "ui_zm_waypoint_float_" + var_1;
  var_0 setModel("tag_origin");
  var_0 show();
  _setomnvar(var_0._id_3012, var_0 getentitynumber());
  _setomnvar(var_0._id_3013, 1.0);
}

_id_11B4(var_0) {
  foreach(var_2 in var_0) {
    var_3 = clamp(var_2._id_28FF / var_2._id_6057, 0.0, 1.0);
    _setomnvar(var_2._id_3013, var_3);
  }
}

_id_11B1(var_0) {
  foreach(var_2 in var_0)
  _setomnvar(var_2._id_3013, -1.0);
}

_id_11B3(var_0) {
  foreach(var_2 in var_0)
  _setomnvar(var_2._id_3013, -1.0);
}

_id_11B0(var_0) {
  level endon("attack_spots_display_start");
  wait 1.5;
  _setomnvar("ui_zm_waypoint_ents_type", 0);
}

_id_11BE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_7 = self._id_1170 _id_9E11(var_4._id_38C4["objectiveTime"], var_1, var_0);
  var_8 = isDefined(var_7);
  return var_8;
}

_id_9E11(var_0, var_1, var_2) {
  var_3 = 0.5;
  var_4 = var_2;

  for(var_5 = 0; var_5 < var_4.size; var_5++)
    var_4[var_5] endon(var_1._id_39D1);

  _id_A6AF(var_0, var_3);
  var_4 _id_695C(var_1._id_94D4);
  return 1;
}

_id_695C(var_0) {
  for(var_1 = 0; var_1 < self.size; var_1++)
    self[var_1] notify(var_0);
}

_id_A6AF(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0; var_2 = var_2 + var_1)
    wait(var_1);
}

_id_45BC() {
  var_0 = 0;
  var_1 = _id_0547::_id_408F();

  foreach(var_3 in var_1) {
    if(isalive(var_3) && isDefined(var_3._id_9ACD) && var_3._id_9ACD == "attacking point" && _distance2dsquared(var_3.origin, self.origin) < 4096)
      var_0++;
  }

  return var_0;
}

_id_600B() {
  if(level.players.size > 1) {
    var_0 = maps\mp\mp_zombie_nest_special_event_creator_interface::_id_9959();
    var_1 = maps\mp\mp_zombie_nest_special_event_creator_interface::_id_55C0();
    return var_0 && !var_1;
  } else
    return !maps\mp\mp_zombie_nest_special_event_creator_interface::_id_55C0();
}
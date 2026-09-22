/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1383.gsc
**************************************/

init() {
  level._id_0A41["zombie_heavy"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_heavy"]["think"] = ::_id_ABC8;
  level._id_0A41["zombie_heavy"]["on_damaged"] = ::_id_ABC4;
  level._id_0A41["zombie_heavy"]["on_damaged_finished"] = ::_id_ABC5;
  level._id_0A41["zombie_heavy"]["move_mode"] = ::_id_ABC3;
  level._id_0A41["zombie_heavy"]["ragdoll_overrides"] = ::_id_ABC6;
  level._id_0A41["zombie_heavy"]["is_hit_weak_point"] = ::_id_ABC0;
  level._id_0A41["zombie_heavy"]["tesla_delayed_dmg"] = ::zombie_heavy_tesla_delayed_dmg;
  var_0 = "default look";
  var_1 = spawnStruct();
  var_1._id_0A4B = "zombie_heavy";
  var_1._id_0EAE = "zombie_animclass";
  var_1._id_0879 = "zombie_generic";
  var_1._id_5ED2[var_0]["whole_body"] = "zom_follower_base";
  var_1._id_4C12 = 10;
  var_1._id_60E2 = 65;
  var_1._id_2F9B = 1;
  var_1._id_8302 = 75;
  var_1._id_8303 = 15;
  var_1.parenttype = "zombie_generic";
  var_1.suppressive_fire_speed_multiplier = 0.5;
  var_1.tacklebycharge = 1;
  var_1.knockbyravensword = 1;
  var_1.energyhold = 1;
  var_1.energyholdsecondary = 0;
  var_1.energyholdpain = 4;
  var_1.throwable = 0;

  if(isDefined(level._id_62AB)) {
    var_1 = [[level._id_62AB]](var_1);
  }

  _id_0547::_id_0A52(var_1, "zombie_heavy");
  _id_0547::_id_7BD0("heavy_charge", _id_0547::zombie_charge_run, undefined, 2.5, _id_0547::zombie_charge_cleanup);
}

_id_408E() {
  return _id_0547::_id_4090("zombie_heavy");
}

_id_4305() {
  return 1;
}

_id_ABC2() {
  self endon("death");
  self endon("stalk_change");
  childthread _id_0547::zombie_monitor_ignored_stalkee(self._id_915D);
  var_0 = self._id_915D common_scripts\utility::waittill_any_return("death", "bleedout", "disconnect", "shouldBeIgnored");
  self._id_915D = undefined;
  _id_ABBE();
}

_id_ABC7(var_0) {
  if(_id_0547::_id_5565(var_0, self._id_915D)) {
    return;
  }
  self notify("stalk_change");
  waitframe();
  self._id_915D = var_0;
  self agentsetfavoriteenemy(var_0);

  if(isDefined(var_0)) {
    thread _id_ABC2();
  }
}

_id_ABDB() {
  self endon("death");

  for(;;) {
    var_0 = common_scripts\utility::_id_A717("attack_hit", "attack_miss");
    level notify("follower swing", self gettagorigin("J_Wrist_RI"), 64);
    var_1 = spawnStruct();
    var_1._id_2434 = 37;
    var_1._id_60C1 = 55;
    var_1._id_3A20 = 82;
    var_1._id_1B70 = 160;

    foreach(var_3 in _id_0547::_id_408F()) {
      var_4 = _id_0547::_id_0A51(var_3._id_0A4B);
      var_5 = isDefined(var_4) && common_scripts\utility::_id_562E(var_4.tacklebymelee);

      if(var_3 == self || !var_5 || !maps\mp\agents\humanoid\_humanoid_melee::_id_11AF(var_3) || var_3 maps\mp\agents\humanoid\_humanoid_util::_id_56BC()) {
        continue;
      }
      var_6 = var_3 _id_0547::_id_43EF(var_1, distance(self.origin, var_3.origin));
      _id_0547::_id_7D1B(self, var_3, var_6);
    }
  }
}

_id_ABBE() {
  _id_0547::disableoffhandsecondaryweapons();

  if(isDefined(self._id_3043)) {
    return;
  }
  self._id_66AC = 10;
  common_scripts\utility::_id_379A("zombie_passive");
}

_id_ABC6() {
  return 0.3;
}

_id_ABC8() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  self _meth_85A1("zombie_heavy");

  if(!common_scripts\utility::_id_562E(level.iszombiesshotgun)) {
    self._id_6816 = 1;
  }

  self._id_2FA4 = 0;
  self._id_915D = undefined;
  self._id_6EB0 = 350;
  self._id_78D7 = 0;
  self._id_6099 = self.maxhealth / 4;
  self._id_60E4 = 1.5;
  self._id_5542 = 0;
  self._id_55AB = 1;
  _id_0566::_id_ABB5();
  thread _id_ABDB();
  thread zombie_heavy_grudge_think();
  _id_0547::_id_86C8(100);
  _id_0547::_id_86C7(100);
  var_0 = 0;

  for(;;) {
    wait(var_0);
    var_0 = 0.2;

    if(!self._id_5542) {
      if(_id_053C::_id_4F8C()) {
        continue;
      }
    }

    if(isDefined(self.custom_think_mode)) {
      self[[self.custom_think_mode]]();
      continue;
    }

    if(common_scripts\utility::_id_562E(self._id_57C0)) {
      continue;
    }
    if(self._id_5542) {
      _id_0547::zombie_charge_cleanup(self._id_645E);
    }

    if(_id_053C::_id_4F84()) {
      continue;
    }
    if(!_id_0547::_id_4B2C() && _id_053C::_id_4F9A()) {
      continue;
    }
    var_2 = undefined;
    var_3 = undefined;
    var_4 = _id_053C::_id_4F88();

    if(var_4.size) {
      var_2 = var_4[0];
      var_3 = distance(self.origin, var_2.origin);
    }

    if(isDefined(self._id_915D)) {
      if(_id_0547::_id_577E(self._id_915D)) {
        self._id_28D2 = undefined;
        _id_ABBE();
        continue;
      } else if(isDefined(var_2) && var_3 < 300 && var_3 + 100 < distance(self.origin, self._id_915D.origin)) {
        _id_ABC7(var_2);
        continue;
      }
    } else if(isDefined(var_2)) {
      _id_ABC7(var_2);
      continue;
    }

    if(_id_053C::_id_4F9B(1)) {
      continue;
    }
    if(_id_053C::_id_4F9A()) {
      continue;
    }
    _id_053C::_id_0647();
  }
}

_id_ABBF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_5) || !isDefined(var_6) || !isDefined(var_7)) {
    return 0;
  }

  if(var_7 != "torso_upper" && var_7 != "torso_lower") {
    return 0;
  }

  var_9 = self gettagangles("j_spineupper");
  var_10 = anglestoright(var_9);
  return vectordot(var_10, var_6) > 0;
}

_id_ABC4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_8 == "right_hand") {
    var_2 = 0;
  }

  if(_id_ABBF(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_10)) {
    if(isDefined(var_4) && var_4 != "MOD_MELEE") {
      var_2 = var_2 * 4;
    } else {
      self._id_14EB = 1;
    }
  } else if(var_8 == "head" && var_5 != "panzerschreck_zm" && !issubstr(var_5, "fliegerfaust") && !issubstr(var_5, "tesla") && var_5 != "raven_sword_zm" && !issubstr(var_5, "razergun") && !issubstr(var_5, "throwingknife"))
    var_2 = var_2 * 0.8;
  else if(var_5 != "panzerschreck_zm" && !issubstr(var_5, "fliegerfaust") && !issubstr(var_5, "tesla") && var_5 != "raven_sword_zm" && !issubstr(var_5, "razergun") && !issubstr(var_5, "throwingknife")) {
    var_2 = var_2 * 0.6;
  }

  if(var_5 == "bazooka_zm") {
    var_2 = self.maxhealth;
  }

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

zombie_heavy_set_grudge(var_0) {
  zombie_heavy_interrupt_grudge();
  self endon("death");
  self endon("grudge_started");
  self.grudgetarget = var_0;
  common_scripts\utility::_id_A70D(14, var_0, "death", var_0, "disconnect");
  self.grudgetarget = undefined;
}

zombie_heavy_interrupt_grudge() {
  self notify("grudge_end");
  self.grudgetarget = undefined;
}

zombie_heavy_grudge_think() {
  for(;;) {
    wait 0.5;

    if(!isDefined(self.grudgetarget)) {
      continue;
    }
    if(_id_0547::is_in_scripted_state("heavy_charge")) {
      zombie_heavy_interrupt_grudge();
      continue;
    }

    if(!zombie_heavy_charge_allowed()) {
      continue;
    }
    if(_id_0547::has_scripted_state_queued("heavy_charge")) {
      continue;
    }
    if(zombie_heavy_valid_charge_target(self.grudgetarget)) {
      _id_ABB7(self.grudgetarget);
      level._id_5B1B = gettime();
    }
  }
}

zombie_heavy_valid_charge_target(var_0) {
  if(isPlayer(var_0) && _issentient(var_0) && self agentcanseesentient(var_0) && _id_0547::_id_1F5B(self.origin, var_0.origin) && common_scripts\utility::_id_0F79(_id_053C::_id_4F88(), var_0)) {
    return 1;
  }

  return 0;
}

zombie_heavy_charge_allowed() {
  return !isDefined(level._id_5B1B) || gettime() - level._id_5B1B > 700.0;
}

_id_ABC5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(self._id_78D7 < self._id_6099) {
    self._id_78D7 = self._id_78D7 + var_2;
  }

  if(self._id_78D7 >= self._id_6099 && zombie_heavy_charge_allowed() && zombie_heavy_valid_charge_target(var_1) && (!isDefined(self._id_3043) || !maps\mp\agents\humanoid\_humanoid_util::_id_8BAE()) && !isDefined(self._id_1927) && (!_id_053C::_id_5686() || !common_scripts\utility::_id_0F79(self._id_983C, var_1)) && !common_scripts\utility::_id_562E(self._id_57C0)) {
    _id_ABB7(var_1);
    self._id_78D7 = 0;
    level._id_5B1B = gettime();
  }

  _id_054D::_id_6BD3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_ABC3() {
  if(!isDefined(self._id_64C4)) {
    self._id_64C4 = 1;
  }

  self._id_64C2 = self._id_64C4 * _id_054D::_id_4440();
  return "walk";
}

_id_ABB7(var_0) {
  var_1 = spawnStruct();
  var_1.player = var_0;
  var_1._id_7462 = var_0.origin;
  var_1.end_notify = "heavy_end_charge";
  var_1.scripted_state = "heavy_charge";
  var_1.stop_run_state_name = "fol_attack_charge";
  var_1.react_state_name = "fol_pain_charge_react";
  var_1.run_state_name = "fol_run_charge";
  var_1.react_anim_rate = 1;
  var_1.extra_lunge_radius = 100;
  var_1.trigger_lerp_deg = 25;
  var_1.trigger_nolerp_deg = 50;
  var_1._id_9DAA = 202;
  var_1.turn_smoothing_thread = _id_0547::zombie_charge_turn_smoothing_thread;
  var_1.initial_turn_deg = 200;
  var_1.initial_turn_secs = 0.1;
  var_1.initial_turn_speed = 0.169;
  var_1._id_2434 = 37;
  var_1._id_60C1 = 55;
  var_1._id_3A20 = 82;
  var_1._id_1B70 = 160;
  thread _id_0547::_id_7D1A("heavy_charge", [var_1], 0.5);
}

_id_ABC0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(_id_ABBF(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
    return 1;
  }

  return 0;
}

zombie_heavy_tesla_delayed_dmg(var_0, var_1, var_2) {
  if(common_scripts\utility::_id_562E(var_1)) {
    var_0 = maps\mp\gametypes\zombies::_id_1E59();
  }

  if(isDefined(var_2)) {
    var_0 = var_2;
  }

  return var_0;
}
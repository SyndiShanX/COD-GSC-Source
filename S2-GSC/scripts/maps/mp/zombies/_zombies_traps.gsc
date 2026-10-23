/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_traps.gsc
******************************************************/

init() {
  level._effect["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange");
  level._effect["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink");
  level.trap_state_models = [];
  level.trap_state_models["default"] = [];
  level._id_9CD1 = [];
  level._id_9CD1["ready_to_active"] = "s2_gj_zom_drop_gate_lever_move_down";
  level._id_9CD1["active_to_cooldown"] = "s2_gj_zom_drop_gate_lever_down_idle";
  level._id_9CD1["cooldown_to_active"] = "s2_gj_zom_drop_gate_lever_up_idle";
  level.trap_state_func["no_power"] = ::trap_state_no_power;
  level.trap_state_func["ready"] = ::trap_state_ready;
  level.trap_state_func["active"] = ::trap_state_active;
  level.trap_state_func["cooldown"] = ::trap_state_cooldown;
  level.trap_state_func["deactivate"] = ::trap_state_deactivate;
  level.laser_alarm_started = 0;
  level._id_08C8 = [];
  level thread _id_A8EB();
  level.traps = common_scripts\utility::getstructarray("zombie_trap", "targetname");
  common_scripts\utility::_id_0FB2(level.traps, ::trap_init);
}

_id_9C9E(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "trap_rnd":
      var_1 = 1000;
      break;
    case "trap_roof":
      var_1 = 1000;
      break;
    case "trap_med":
      var_1 = 1000;
      break;
    case "trap_aagun":
      var_1 = 500;
      break;
    case "trap_catacombs":
      var_1 = 1000;
      break;
    case "trap_firewell":
      var_1 = 500;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

_id_9CA6(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "trap_rnd":
      var_1 = 20;
      break;
    case "trap_roof":
      var_1 = 20;
      break;
    case "trap_med":
      var_1 = 20;
      break;
    case "trap_aagun":
      var_1 = 20;
      break;
    case "trap_catacombs":
      var_1 = 20;
      break;
    case "trap_firewell":
      var_1 = 5;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

_id_9C9C(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "trap_rnd":
      var_1 = 30;
      break;
    case "trap_roof":
      var_1 = 30;
      break;
    case "trap_med":
      var_1 = 30;
      break;
    case "trap_aagun":
      var_1 = 30;
      break;
    case "trap_catacombs":
      var_1 = 30;
      break;
    case "trap_firewell":
      var_1 = 20;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

_id_438E() {
  return 25;
}

trap_init(var_0, var_1, var_2, var_3) {
  var_4 = self._id_0165;
  var_5 = _id_9C9E(var_4);

  if(var_5 > 0) {
    self.cost = var_5;
  } else if(isDefined(self.setanimknobrestart)) {
    self.cost = self.setanimknobrestart;
  } else {
    self.cost = 500;
  }

  var_6 = _id_9C9C(var_4);

  if(var_6 > 0) {
    self._id_264F = var_6;
  } else if(isDefined(self.setlookatent)) {
    self._id_264F = int(self.setlookatent);
  } else {
    self._id_264F = 40;
  }

  if(!common_scripts\utility::_id_562E(var_0)) {
    _id_10BB();
  } else {
    _id_10BC(var_1, var_2, var_3);
  }

  self.state = "none";

  if(trap_requires_power()) {
    trap_set_state("no_power");
  } else {
    trap_set_state("ready");
  }
}

_id_7BFB(var_0) {
  _id_0559::_id_7BE2(self, var_0.trigger, var_0._id_9CBB);
}

_id_10BC(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    thread trap_activate_trigger(var_4);
    thread trap_trigger_hint(var_4);
  }

  foreach(var_7 in var_1) {
    thread trap_fx_ready(var_7);
  }

  foreach(var_10 in var_2) {
    thread trap_activate_model(var_10);
    self.modelent = var_10;
  }
}

_id_10BB() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_2 = common_scripts\utility::_id_0F73(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4._id_0165)) {
      continue;
    }
    switch (var_4._id_0165) {
      case "activate_model":
        thread trap_activate_model(var_4);
        self.modelent = var_4;
        break;
      case "activate":
        thread trap_activate_trigger(var_4);
        thread trap_trigger_hint(var_4);
        break;
      case "laser":
        thread trap_laser(var_4);
        break;
      case "fx_ready":
        thread trap_fx_ready(var_4);
        break;
      case "damage":
        thread trap_damage_trigger(var_4, 0);
        break;
      case "damage_over_time":
        thread trap_damage_trigger(var_4, 1);
        break;
      case "fx_trap":
        thread trap_state_fx(var_4);
        break;
      case "fx_trap_move":
        thread trap_fx_move(var_4);
        break;
      case "distraction":
        thread trap_distraction(var_4);
        break;
      case "zomboni":
        thread trap_zomboni(var_4);
        break;
      default:
        break;
    }
  }
}

register_trap_state_models(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = "default";
  }

  if(!isDefined(level.trap_state_models[var_4])) {
    level.trap_state_models[var_4] = [];
  }

  level.trap_state_models[var_4]["no_power"] = var_0;
  level.trap_state_models[var_4]["ready"] = var_1;
  level.trap_state_models[var_4]["active"] = var_2;
  level.trap_state_models[var_4]["cooldown"] = var_3;
  level.trap_state_models[var_4]["deactivate"] = var_0;
}

get_trap_time() {
  return 20;
}

trap_requires_power() {
  return isDefined(self.setgoalnode);
}

trap_has_power() {
  if(trap_requires_power()) {
    return common_scripts\utility::flag(self.setgoalnode);
  }

  return 1;
}

trap_set_state(var_0) {
  thread _id_0732(var_0);
}

_id_0732(var_0) {
  self notify(var_0);

  if(var_0 != self.state) {
    self notify("trap_state_change", var_0);
  }

  self.state = var_0;
  self thread[[level.trap_state_func[var_0]]]();
}

trap_state_no_power() {
  self endon("trap_state_change");

  if(!trap_has_power()) {
    common_scripts\utility::flag_wait(self.setgoalnode);
  }

  trap_set_state("ready");
}

trap_state_deactivate() {
  self endon("trap_state_change");
  self waittill("trap_reactivated");

  if(!trap_has_power()) {
    common_scripts\utility::flag_wait(self.setgoalnode);
  }

  trap_set_state("ready");
}

trap_state_ready() {
  self endon("trap_state_change");

  for(;;) {
    self waittill("trap_trigger", var_0, var_1);

    if(var_1 == "token") {
      var_0 maps\mp\gametypes\zombies::spendtoken(self.tokencost);
    } else {
      var_2 = self.cost;

      if(isDefined(level.penaltycostincrease)) {
        for(var_3 = 0; var_3 < level.penaltycostincrease; var_3++) {
          var_2 = _id_0547::getincreasedcost(var_2);
        }
      }

      if(!var_0 maps\mp\gametypes\zombies::attempttobuy(var_2)) {
        var_0 thread _id_054E::_id_0695("needmoney");
        continue;
      }

      _id_0547::_id_4AE4(var_0, "trap", var_2, "none", "none");
    }

    var_0.trapuses++;
    var_0 thread _id_054E::moneyspend();
    trap_activate(var_0, 0);
    break;
  }
}

trap_activate(var_0, var_1) {
  if(!var_1) {
    _id_0555::issprinting("use_trap", var_0);

    if(isDefined(level._id_AAFE)) {
      level thread[[level._id_AAFE]](self, var_0);
    }
  }

  self._id_0117 = var_0;
  trap_set_state("active");
}

_id_9CA3() {
  self.deactivated = 1;
  trap_set_state("deactivate");
}

_id_9CBD() {
  self.deactivated = undefined;
  self notify("trap_reactivated");
}

trap_state_active() {
  self endon("trap_state_change");
  self endon("active");
  trap_state_active_wait();

  if(trap_has_power()) {
    trap_set_state("cooldown");
  } else {
    trap_set_state("no_power");
  }
}

trap_state_active_wait() {
  if(isDefined(self.trap_active_end_notify)) {
    self waittill(self.trap_active_end_notify);
  } else {
    var_0 = _id_9CA6(self._id_0165);

    if(var_0 > 0) {
      var_1 = var_0;
    } else if(isDefined(self.script_duration)) {
      var_1 = self.script_duration;
    } else {
      var_1 = get_trap_time();
    }

    wait(var_1);
  }
}

trap_state_cooldown() {
  self endon("trap_state_change");
  var_0 = self._id_264F;

  if(isDefined(level.trapcooldowntime)) {
    var_0 = level.trapcooldowntime;
  }

  wait(var_0);

  if(trap_has_power()) {
    trap_set_state("ready");
  } else {
    trap_set_state("no_power");
  }
}

trap_activate_model(var_0) {
  var_1 = "default";

  for(;;) {
    self waittill("trap_state_change", var_2);
    var_3 = level.trap_state_models[var_1][var_2];

    if(isDefined(var_3)) {
      var_0 setModel(var_3);
    }

    if(var_2 == "active") {
      var_0 thread _id_9CB7();
    }
  }
}

_id_9CB7() {
  if(isDefined(level._id_9CD1["ready_to_active"])) {
    self scriptmodelplayanim(level._id_9CD1["ready_to_active"]);
    wait 0.766667;
  }

  if(isDefined(level._id_9CD1["active_to_cooldown"])) {
    self scriptmodelplayanim(level._id_9CD1["active_to_cooldown"]);
    wait 1;
  }

  if(isDefined(level._id_9CD1["cooldown_to_active"])) {
    self scriptmodelplayanim(level._id_9CD1["cooldown_to_active"]);
  }
}

trap_activate_trigger(var_0) {
  for(;;) {
    [var_2, var_3] = var_0 _id_0547::waittilltriggerortokenuse();
    self notify("trap_trigger", var_2, var_3);
  }
}

trap_trigger_hint(var_0) {
  var_1 = self._id_0165;
  var_2 = undefined;

  if(1) {
    var_2 = _id_0552::_id_7BFC(var_0);
  }

  var_3 = spawnStruct();
  var_3._id_9CBB = var_1;
  var_3.trigger = var_0;
  level thread maps\mp\_utility::_id_6F74(::_id_7BFB, var_3);

  for(;;) {
    self waittill("trap_state_change", var_4);

    if(1) {
      var_2._id_6642 = 1;
    }

    switch (var_4) {
      case "no_power":
        if(0) {
          var_0 setHintString(&"ZOMBIES_REQUIRES_POWER");
          var_0 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
          var_0 _id_0547::tokenhintstring(0);
        }

        if(1) {
          var_2._id_9CCA = 0;
          var_2.interact_disabled = 1;
        }

        break;
      case "active":
        if(0) {
          var_0 setHintString(&"ZOMBIES_EMPTY_STRING");
          var_0 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
          var_0 _id_0547::tokenhintstring(0);
        }

        if(1) {
          var_2._id_9CCA = 1;
          var_2.interact_disabled = 1;
        }

        break;
      case "cooldown":
        if(0) {
          if(isDefined(self.hint_strings)) {
            var_0 setHintString(self.hint_strings["hint_cooldown"]);
          } else {
            var_0 setHintString(&"ZOMBIES_TRAP_COOLDOWN");
          }

          var_0 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
          var_0 _id_0547::tokenhintstring(0);
        }

        if(1) {
          var_2._id_9C9B = 0;

          if(isDefined(self.hint_strings)) {
            var_2._id_9C9B = self.hint_strings["hint_cooldown_ref"];
          }

          var_2._id_9CCA = 2;
          var_2.interact_disabled = 1;
        }

        break;
      case "ready":
        var_5 = self.cost;

        if(isDefined(level.penaltycostincrease)) {
          for(var_6 = 0; var_6 < level.penaltycostincrease; var_6++) {
            var_5 = _id_0547::getincreasedcost(var_5);
          }
        }

        if(0) {
          if(isDefined(self.hint_strings)) {
            var_0 setHintString(self.hint_strings["hint_ready"]);
          } else {
            var_0 setHintString(&"ZOMBIES_TRAP_BUY_GENERIC");
          }

          var_0 setsecondaryhintstring(_id_0547::_id_4474(var_5));
          var_0 _id_0547::tokenhintstring(1);
        }

        if(1) {
          var_2._id_9CBE = 0;

          if(isDefined(self.hint_strings)) {
            var_2._id_9CBE = self.hint_strings["hint_ready_ref"];
          }

          var_2._id_9CCA = 3;
          var_2._id_9C9D = var_5;
          var_2.interact_disabled = undefined;
        }

        break;
      case "deactivate":
        if(0) {
          var_0 setHintString(&"ZOMBIES_REQUIRES_POWER");
          var_0 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
        }

        if(1) {
          var_2._id_9CCA = 4;
        }

        break;
      default:
        break;
    }
  }
}

trap_fx_move(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.start_origin = var_1.origin;
  var_1.start_angles = var_1.angles;
  var_1 setModel("tag_origin");
  var_1.movelist = [];
  var_2 = [];

  if(isDefined(var_0.target)) {
    var_3 = getEntArray(var_0.target, "targetname");
    var_4 = common_scripts\utility::getstructarray(var_0.target, "targetname");
    var_2 = common_scripts\utility::_id_0F73(var_3, var_4);
  }

  foreach(var_6 in var_2) {
    if(!isDefined(var_6._id_0165)) {
      continue;
    }
    switch (var_6._id_0165) {
      case "damage_over_time":
      case "damage":
        var_6 enablelinkTo();
        var_6 linkTo(var_1);
        thread trap_damage_trigger(var_6, var_6._id_0165 == "damage_over_time", "fx_trap_move");
        break;
      case "moveto":
        var_1 trap_laser_move_list(var_6);
        break;
      default:
        break;
    }
  }

  for(;;) {
    self waittill("trap_state_change", var_8);
    thread trap_play_fx(var_1, var_8, var_0);

    switch (var_8) {
      case "active":
        thread trap_laser_move(var_1);
        break;
      default:
        break;
    }
  }
}

trap_play_fx(var_0, var_1, var_2) {
  if(isDefined(var_0.currentfx)) {
    _id_0547::stopfxontagnetwork(var_0.currentfx, var_0, "tag_origin");
    var_0.currentfx = undefined;
    wait 0.5;
  }

  var_3 = var_2.setlookatent + "_" + var_1;

  if(common_scripts\utility::fxexists(var_3)) {
    var_0.currentfx = common_scripts\utility::getfx(var_3);
  }

  if(isDefined(var_0.currentfx)) {
    _id_0547::playfxontagnetwork(var_0.currentfx, var_0, "tag_origin");
  }
}

trap_laser_move_list(var_0) {
  while(isDefined(var_0)) {
    self.movelist[self.movelist.size] = var_0;

    if(isDefined(var_0.target)) {
      var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
      continue;
    }

    var_0 = undefined;
  }
}

trap_laser(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.start_origin = var_1.origin;
  var_1.start_angles = var_1.angles;
  var_1 setModel("tag_laser");
  var_1.movelist = [];
  var_2 = [];

  if(isDefined(var_0.target)) {
    var_3 = getEntArray(var_0.target, "targetname");
    var_4 = common_scripts\utility::getstructarray(var_0.target, "targetname");
    var_2 = common_scripts\utility::_id_0F73(var_3, var_4);
  }

  foreach(var_6 in var_2) {
    if(!isDefined(var_6._id_0165)) {
      continue;
    }
    switch (var_6._id_0165) {
      case "damage_over_time":
      case "damage":
        var_6 enablelinkTo();
        var_6 linkTo(var_1);
        thread trap_damage_trigger(var_6, var_6._id_0165 == "damage_over_time", "laser");
        break;
      case "moveto":
        var_1 trap_laser_move_list(var_6);
        break;
      default:
        break;
    }
  }

  for(;;) {
    self waittill("trap_state_change", var_8);

    switch (var_8) {
      case "deactivate":
      case "cooldown":
      case "no_power":
        var_1 stoploopsound("trap_laser_loop");
        var_1 playSound("trap_laser_stop");
        var_1 laseroff();
        break;
      case "active":
        thread trap_laser_move(var_1);
        thread trap_laser_color(var_1);
        break;
      default:
        break;
    }
  }
}

trap_laser_color(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_1 = "trap_warning_zm";

  if(isDefined(level.zmblasertrapwarningcustom)) {
    var_1 = level.zmblasertrapwarningcustom;
  }

  var_2 = "trap_zm";

  if(isDefined(level.zmblasertrapcustom)) {
    var_2 = level.zmblasertrapcustom;
  }

  var_0 laseron(var_1);
  var_3 = spawn("script_origin", var_0.origin);
  thread trap_laser_alarm_start(var_3);
  wait 3;
  thread trap_laser_alarm_stop(var_3);
  var_0 laseron(var_2);
  var_0 playSound("trap_laser_start");
  var_0 playLoopSound("trap_laser_loop");
}

trap_laser_alarm_start(var_0) {
  if(level.laser_alarm_started == 0) {
    level.laser_alarm_started = 1;

    if(isDefined(var_0)) {
      var_0 playLoopSound("trap_laser_alarm");
    }
  } else {}
}

trap_laser_alarm_stop(var_0) {
  level.laser_alarm_started = 0;

  if(isDefined(var_0)) {
    var_0 stoploopsound("trap_laser_alarm");
    var_0 delete();
  }
}

trap_laser_move(var_0) {
  self endon("trap_state_change");

  if(!var_0.movelist.size) {
    return;
  }
  var_1 = 60;
  var_2 = 15;
  var_0.origin = var_0.start_origin;
  var_0.angles = var_0.start_angles;
  var_3 = 0;

  for(;;) {
    var_4 = var_0.movelist[var_3];
    var_5 = 0;
    var_6 = distance(var_0.origin, var_4.origin);

    if(var_6 > 0) {
      var_5 = var_6 / var_1;
    }

    var_7 = 0;

    if(isDefined(var_4.angles)) {
      for(var_8 = 0; var_8 < 3; var_8++) {
        var_9 = _abs(_angleclamp(var_0.angles[var_8]) - _angleclamp(var_4.angles[var_8])) > 0.01;

        if(var_9) {
          var_7 = 0.5 * _anglesdelta(var_0.angles, var_4.angles);
          break;
        }
      }
    }

    if(!var_5 && var_7) {
      var_5 = var_7 / var_2;
    }

    if(var_6 > 0) {
      var_0 moveTo(var_4.origin, var_5);
    }

    if(var_7 > 0) {
      var_0 rotateTo(var_4.angles, var_5);
    }

    if(var_5 > 0) {
      wait(var_5);
    }

    var_3++;
    var_3 = var_3 % var_0.movelist.size;
  }
}

trap_fx_ready(var_0) {
  var_1 = undefined;

  for(;;) {
    self waittill("trap_state_change", var_2);

    switch (var_2) {
      case "no_power":
        if(isDefined(var_1)) {
          var_1 delete();
        }

        break;
      case "deactivate":
        if(isDefined(var_1)) {
          var_1 delete();
        }

        break;
      case "ready":
        if(isDefined(var_1)) {
          var_1 delete();
        }

        var_1 = _spawnfx(common_scripts\utility::getfx("trap_ready"), var_0.origin);
        _triggerfx(var_1);
        break;
      case "active":
        if(isDefined(var_1)) {
          var_1 delete();
        }

        var_1 = _spawnfx(common_scripts\utility::getfx("trap_not_ready"), var_0.origin);
        _triggerfx(var_1);
        break;
      default:
        break;
    }
  }
}

trap_damage_trigger(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  for(;;) {
    self waittill("active");
    trap_damage_trigger_watch(var_0, var_1, var_2);
  }
}

trap_damage_trigger_watch(var_0, var_1, var_2) {
  self endon("cooldown");
  self endon("no_power");
  self endon("ready");
  self endon("deactivate");
  var_3 = 1;
  var_4 = 5;

  if(var_2 == "fx_trap_move") {
    var_4 = 3;
  }

  var_5 = var_4 / var_3;

  if(isDefined(var_0.setanimknobrestart)) {
    var_5 = var_5 * var_0.setanimknobrestart;
  }

  var_6 = 50;

  if(isDefined(var_0.setanimknobrestart)) {
    var_6 = var_6 / var_0.setanimknobrestart;
  }

  var_7 = gettime();
  var_8 = "trap_zm_mp";

  if(isDefined(level.zmcustomdamagetriggerweapon)) {
    var_8 = self[[level.zmcustomdamagetriggerweapon]](var_0, var_1, var_2);
  }

  for(;;) {
    var_0 waittill("trigger", var_9);
    var_10 = (var_9.origin[0], var_9.origin[1], var_0.origin[2]);

    if(isPlayer(var_9)) {
      if(isDefined(var_0.setlookatent) && var_0.setlookatent == "no_player_damage") {
        continue;
      }
      if(isDefined(var_9.nexttrapdamage) && var_9.nexttrapdamage > gettime()) {
        continue;
      }
      if(var_7 + 3000 > gettime()) {
        continue;
      }
      var_9.nexttrapdamage = gettime() + 200;

      if(isDefined(level.modplayertrapdmg) && isDefined(var_0.setanimknobrestart)) {
        var_9.nexttrapdamage = gettime() + 200 * var_0.setanimknobrestart;
      }

      var_9 dodamage(var_6, var_9.origin);
      continue;
    }

    if(isDefined(var_9._id_000A) && var_9._id_000A == level.playerteam) {
      if(isDefined(var_0.setlookatent) && var_0.setlookatent == "no_player_damage") {
        continue;
      }
      if(isDefined(var_9.nexttrapdamage) && var_9.nexttrapdamage > gettime()) {
        continue;
      }
      if(var_7 + 3000 > gettime()) {
        continue;
      }
      var_9.nexttrapdamage = gettime() + 200;
      var_9 dodamage(var_6 * 0.5, var_9.origin);
      continue;
    }

    var_11 = trap_damage_trigger_location(var_9, var_10);

    if(var_1) {
      if(!isDefined(var_9.maxhealth)) {
        continue;
      }
      if(isDefined(var_9.nexttrapdot) && var_9.nexttrapdot > gettime()) {
        continue;
      }
      var_9.nexttrapdot = gettime() + int(1000 / var_4);
      var_12 = "MOD_TRIGGER_HURT";

      if(isDefined(var_0.setanimknobrestart)) {
        var_12 = "MOD_IMPACT";
      }

      var_13 = int(var_9.maxhealth / var_5);

      if(var_9 _id_0547::istrapresistant()) {
        var_13 = var_13 * 0.1;
      }

      if(_id_0547::_id_5565(self._id_0165, "trap_rnd")) {
        var_9 mark_electrified();
        var_9 dodamage(var_13, var_10, level._id_9CC0, level._id_9CC0, var_12, var_8, var_11);
      } else
        var_9 dodamage(var_13, var_10, self._id_0117, self._id_0117, var_12, var_8, var_11);
    } else {
      var_13 = var_9.health;

      if(var_9 _id_0547::istrapresistant()) {
        var_13 = var_13 * 0.2;
      }

      var_9 thread mark_electrified();

      if(_id_0547::_id_5565(self._id_0165, "trap_rnd")) {
        var_9 dodamage(var_13, var_10, level._id_9CC0, level._id_9CC0, "MOD_TRIGGER_HURT", var_8, var_11);
      } else {
        var_9 dodamage(var_13, var_10, self._id_0117, self._id_0117, "MOD_TRIGGER_HURT", var_8, var_11);
      }
    }
  }
}

mark_electrified() {
  self notify("new_mark_electrified");
  self endon("new_mark_electrified");
  self endon("death");
  self.iselectrified = 1;
  childthread unset_zombie_electrified();
}

unset_zombie_electrified() {
  wait 5;
  self.iselectrified = 0;
}

trap_damage_trigger_location(var_0, var_1) {
  var_2 = var_1[2] - var_0.origin[2];

  if(var_2 < 32) {
    return common_scripts\utility::random(["right_leg_upper", "left_leg_upper"]);
  } else if(var_2 < 60) {
    return common_scripts\utility::random(["left_arm_upper", "right_arm_upper"]);
  } else {
    return common_scripts\utility::random(["head", "neck"]);
  }
}

isexplosivetrap(var_0) {
  return isDefined(var_0) && var_0 == "zombie_trap_barrel";
}

trap_state_fx(var_0) {
  var_1 = undefined;

  for(;;) {
    self waittill("trap_state_change", var_2);

    if(isDefined(var_1)) {
      var_1 delete();
    }

    var_3 = var_0.setlookatent + "_" + var_2;

    if(common_scripts\utility::fxexists(var_3)) {
      var_1 = common_scripts\utility::getfx(var_3);
    }

    if(isDefined(var_1)) {
      var_1 = _spawnfx(var_1, var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
      _triggerfx(var_1);
    }

    thread audio_trap_fx(var_3, var_1, var_0.origin);
  }
}

_id_9CC7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::getstructarray(var_0, "script_noteworthy");

  foreach(var_7 in var_5) {
    if(!isDefined(var_7.hint_strings)) {
      var_7.hint_strings = [];
    }

    if(0) {
      var_7.hint_strings["hint_ready"] = var_1;
      var_7.hint_strings["hint_cooldown"] = var_2;
    }

    if(1 && (isDefined(var_3) || isDefined(var_4))) {
      var_8 = isDefined(var_3);
      var_9 = isDefined(var_4);
      var_7.hint_strings["hint_ready_ref"] = 0;
      var_7.hint_strings["hint_cooldown_ref"] = 0;
      var_10 = _tablegetrowcount("mp/zombieCustomTrapInteract.csv");

      for(var_11 = 0; var_11 < var_10; var_11++) {
        var_12 = _tablelookupbyrow("mp/zombieCustomTrapInteract.csv", var_11, 1);

        if(var_8 && var_12 == var_3) {
          var_7.hint_strings["hint_ready_ref"] = int(_tablelookupbyrow("mp/zombieCustomTrapInteract.csv", var_11, 0));
          var_8 = 0;
        } else if(var_9 && var_12 == var_4) {
          var_7.hint_strings["hint_cooldown_ref"] = int(_tablelookupbyrow("mp/zombieCustomTrapInteract.csv", var_11, 0));
          var_9 = 0;
        }

        if(!var_8 && !var_9) {
          break;
        }
      }
    }
  }
}

trap_setup_custom_function(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstructarray(var_0, "script_noteworthy");

  foreach(var_7, var_5 in var_3) {
    var_5 thread trap_custom_function_think(var_1, var_2);
  }
}

trap_custom_function_think(var_0, var_1) {
  var_2 = self;

  for(;;) {
    var_2 waittill("trap_state_change", var_3);

    if(var_3 == var_0) {
      thread[[var_1]](var_2);
    }
  }
}

trap_distraction(var_0) {
  for(;;) {
    self waittill("active");
    var_1 = spawn("script_model", var_0.origin);
    var_1.groundpos = var_1.origin;
    var_1.team = level.playerteam;

    if(isDefined(var_0.setlookatent)) {
      if(_func_30D(var_0.setlookatent)) {
        var_1.maxdistsqr = _squared(int(var_0.setlookatent));
      }
    }

    if(isDefined(var_0.setanimknobrestart)) {
      var_1.maxcount = var_0.setanimknobrestart;
    }

    var_1.istrap = 1;
    var_1._id_0A54 = 0;
    level notify("trap_lure_activated", var_1);
    level._id_08C8[level._id_08C8.size] = var_1;
    common_scripts\utility::waittill_any("cooldown", "no_power", "ready", "deactivate");

    if(!isDefined(var_1)) {
      continue;
    }
    level._id_08C8 = common_scripts\utility::_id_0F93(level._id_08C8, var_1);
    var_1 delete();
  }
}

_id_A8EB() {
  for(;;) {
    level waittill("spawned_agent", var_0);

    if(isDefined(var_0._id_000A) && isDefined(level.playerteam) && var_0._id_000A == level.playerteam) {
      continue;
    }
    var_0 thread _id_AC6B();
  }
}

_id_AC6B() {
  self endon("death");

  for(;;) {
    while(level._id_08C8.size > 0) {
      var_0 = undefined;

      foreach(var_2 in level._id_08C8) {
        if(!_id_21CB(var_2)) {
          continue;
        }
        var_3 = _distance2dsquared(var_2.origin, self.origin);

        if(isDefined(var_2.maxdistsqr)) {
          var_4 = var_2.maxdistsqr;
        } else {
          var_4 = 2250000;
        }

        if(var_3 < var_4) {
          var_0 = var_2;
          break;
        }
      }

      if(isDefined(var_0)) {
        self.distractiondrone = var_0;
        self.distractiondronebadpathcount = 0;

        if(isDefined(var_0._id_0A54)) {
          var_0._id_0A54++;
          thread _id_5F51(var_0);
        }

        var_0 common_scripts\utility::waittill_any("death", "stop");
        self.distractiondrone = undefined;
        waittillframeend;
        continue;
      }

      self.distractiondrone = undefined;
      waitframe();
    }

    level waittill("trap_lure_activated");
  }
}

_id_5F51(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0._id_0A54--;
  }
}

_id_21CB(var_0) {
  if(!isDefined(var_0.istrap) || !var_0.istrap) {
    return 1;
  }

  var_1 = 4;

  if(isDefined(var_0.maxcount)) {
    var_1 = var_0.maxcount;
  }

  if(var_0._id_0A54 > var_1) {
    return 0;
  }

  if(_id_0547::istrapresistant()) {
    return 0;
  }

  return 1;
}

audio_trap_fx(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_3) && _soundexists(var_3)) {
    if(isDefined(var_1)) {
      _id_046C::snd_play_linked(var_3, var_1);
    } else {
      _id_046C::snd_play_in_space(var_3, var_2);
    }
  }

  var_4 = var_0 + "_lp";

  if(isDefined(var_4) && _soundexists(var_4)) {
    if(isDefined(var_1)) {
      _id_046C::snd_play_linked_loop(var_4, var_1, 0.25);
    }
  }
}

trap_zomboni_track_last_safe_origin() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread player_track_last_safe_origin();
  }
}

player_track_last_safe_origin() {
  self endon("disconnect");
  thread player_track_last_unresolved_collision_time();

  for(;;) {
    if(self.last_unresolved_collision_time < gettime()) {
      self.last_safe_origin = self.origin;
    }

    waitframe();
  }
}

player_track_last_unresolved_collision_time() {
  self.last_unresolved_collision_time = 0;

  for(;;) {
    self waittill("unresolved_collision");
    self.last_unresolved_collision_time = gettime();
  }
}

trap_zomboni(var_0) {
  if(!isDefined(level.zomboni_init)) {
    _precachempanim("zombie_ark_zomboni_trap");
    level.zomboni_init = 1;
    _createthreatbiasgroup("zomboni");
    level._effect["chompy_churn"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_churn");
    level._effect["chompy_lights"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_lights");
    level thread trap_zomboni_track_last_safe_origin();
  }

  self.trap_active_end_notify = "zomboni_done";
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("vehicle_ind_zomboni_ai");
  var_1.angles = var_0.angles;
  var_1.linegunignore = 1;
  var_1 makeentitysentient(level.playerteam);
  var_1 setthreatbiasgroup("zomboni");
  var_1.attack_locs = [];
  var_2 = 40;
  var_3 = 150;
  var_4 = 45;
  var_5 = [["tag_zom_attach_1", "left"], ["tag_zom_attach_2", "right"], ["tag_zom_attach_3", "rear"]];

  foreach(var_12, var_7 in var_5) {
    var_8 = var_7[0];
    var_9 = var_7[1];
    var_10 = var_1 gettagorigin(var_8);
    var_11 = spawn("script_model", var_10);
    var_11.angles = var_1 gettagangles(var_8);
    var_11 setModel("tag_origin");
    var_11 linkTo(var_1, var_8);
    var_11.grab_radius = var_2;
    var_11.jump_radius = var_3;
    var_11.attack_radius = var_4;
    var_11.attack_name = var_9;
    var_11._id_0E18 = var_12;
    var_1.attack_locs[var_1.attack_locs.size] = var_11;
    thread trap_zomboni_attack_ent_debug(var_11);
  }

  var_1.iszomboni = 1;
  var_13 = getEntArray(var_0.target, "targetname");
  var_14 = common_scripts\utility::getstructarray(var_0.target, "targetname");
  var_15 = common_scripts\utility::_id_0F73(var_13, var_14);
  var_1.doors = [];

  foreach(var_17 in var_15) {
    if(!isDefined(var_17._id_0165)) {
      continue;
    }
    switch (var_17._id_0165) {
      case "clip":
        var_17.unresolved_collision_func = ::trap_zomboni_unresolved_collision;
        var_17.zomboni = var_1;
        var_1.clip = var_17;
        var_17 linkTo(var_1);
        break;
      case "kill_trigger":
        var_17 enablelinkTo();
        var_17 linkTo(var_1);
        var_1.killtrigger = var_17;
        break;
      case "door":
        var_17.close_origin = var_17.origin;
        var_17.open_origin = var_17.close_origin + (0, 0, 60);
        var_1.doors[var_1.doors.size] = var_17;
        break;
      default:
        break;
    }
  }

  while(!_threatbiasgroupexists("zombies")) {
    waitframe();
  }

  for(;;) {
    _setignoremegroup("zomboni", "zombies");
    self waittill("active");
    var_1.isstopped = 0;
    _playFXOnTag(common_scripts\utility::getfx("chompy_lights"), var_1, "tag_body");
    var_1 scriptmodelplayanimdeltamotionfrompos("zombie_ark_zomboni_trap", var_0.origin, var_0.angles, "zomboni_anim");
    thread trap_zomboni_notetracks(var_1);
    thread trap_zomboni_zombies_attack(var_1);
    _setthreatbias("zomboni", "zombies", 2000);
    thread trap_zomboni_kill_zone(var_1);
    var_1 waittill("end");
    self notify("zomboni_done");
    _killfxontag(common_scripts\utility::getfx("chompy_lights"), var_1, "tag_body");
    var_1 scriptmodelclearanim();
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }
}

trap_zomboni_show_unresoloved_collision_locs(var_0) {
  self endon("zomboni_done");

  for(;;) {
    var_1 = trap_zomboni_get_unresolved_collision_locs(var_0);

    foreach(var_3 in var_1) {}

    waitframe();
  }
}

trap_zomboni_get_unresolved_collision_locs(var_0, var_1) {
  var_2 = [];
  var_3 = [(-16, 16, 56), (0, 16, 56), (18, 16, 56), (-16, -22, 56), (0, -22, 56), (18, -22, 56), (-16, -60, 56), (0, -60, 56), (18, -60, 56)];
  var_4 = _getEnt("zomboni_room_volume", "targetname");
  var_5 = var_0 gettagorigin("body_animate_jnt");
  var_5 = (var_5[0], var_5[1], var_0.origin[2]);

  foreach(var_7 in var_3) {
    var_8 = spawnStruct();
    var_8.origin = var_5 + _rotatevector(var_7, var_0.angles + (0, -90, 0));

    if(!isDefined(var_4) || !_ispointinvolume(var_8.origin, var_4)) {
      var_2[var_2.size] = var_8;
    }
  }

  var_10 = _getnodesinradius(var_5, 200, 0, 100);
  var_11 = anglesToForward(var_0.angles);

  foreach(var_13 in var_10) {
    var_14 = vectorNormalize(var_13.origin - var_5);

    if(vectordot(var_11, var_14) < 0) {
      var_2[var_2.size] = var_13;
    }
  }

  if(isDefined(var_1)) {
    var_8 = spawnStruct();
    var_8.origin = var_1.last_safe_origin;
    var_2[var_2.size] = var_8;
  }

  return var_2;
}

trap_zomboni_unresolved_collision(var_0) {
  self.unresolved_collision_nodes = trap_zomboni_get_unresolved_collision_locs(self.zomboni, var_0);
  _id_0488::unresolved_collision_nearest_node(var_0, 0);
}

trap_zomboni_attack_ent_debug(var_0) {
  level.trap_zomboni_attack_ent_debug = 0;

  for(;;) {
    waitframe();

    if(!common_scripts\utility::_id_562E(level.trap_zomboni_attack_ent_debug)) {
      continue;
    }
    var_1 = var_0.attacker;
    var_2 = (1, 1, 0);
    var_3 = (1, 1, 1);

    if(isDefined(var_1)) {
      var_2 = (1, 0, 0);
      var_3 = (1, 0, 0);
    }

    maps\mp\bots\_bots_util::bot_draw_circle(var_0.origin, var_0.grab_radius, var_2, 0, 16);
    maps\mp\bots\_bots_util::bot_draw_circle(var_0.origin, var_0.jump_radius, var_3, 0, 16);
  }
}

trap_zomboni_stop(var_0) {
  self endon("zomboni_done");

  if(!isDefined(var_0.clip)) {
    return;
  }
  for(;;) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      var_4 = var_3 getgroundentity();

      if(isDefined(var_4) && var_4 == var_0.clip) {
        var_1 = 1;
        break;
      }
    }

    if(var_1 && !var_0.isstopped) {
      var_0 setshadowrendering(1);
      var_0.isstopped = 1;
    } else if(!var_1 && var_0.isstopped) {
      var_0 setshadowrendering(0);
      var_0.isstopped = 0;
    }

    waitframe();
  }
}

trap_zomboni_is_any_player_on_zomboni(var_0) {
  foreach(var_2 in level.players) {
    if(trap_zomboni_is_player_on_zomboni(var_2, var_0)) {
      return 1;
    }
  }

  return 0;
}

trap_zomboni_is_player_on_zomboni(var_0, var_1) {
  var_2 = var_0 getgroundentity();

  if(!isDefined(var_2)) {
    return 0;
  }

  return var_2 == var_1.clip;
}

trap_zomboni_zombies_attack(var_0) {
  self endon("zomboni_done");
  var_0.jumpon_enabled = 0;

  foreach(var_2 in var_0.attack_locs) {
    var_2.attacker = undefined;
    var_2.nexttimer = 0;
  }

  for(;;) {
    waitframe();

    if(!var_0.jumpon_enabled) {
      continue;
    }
    foreach(var_5 in maps/_lights()) {
      if(isDefined(var_5.nextzombonijumpontime) && var_5.nextzombonijumpontime > gettime()) {
        continue;
      }
      var_5.nextzombonijumpontime = gettime() + _randomintrange(1, 5) * 50;

      if(!isalive(var_5)) {
        continue;
      }
      if(isPlayer(var_5)) {
        continue;
      }
      if(!var_5 _id_0547::has_entered_game()) {
        continue;
      }
      if(!_isscriptedagent(var_5) || var_5._id_0A4B == "zombie_dog") {
        continue;
      }
      if(var_5 _id_0547::istrapresistant()) {
        continue;
      }
      if(var_5 maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
        continue;
      }
      if(!isDefined(var_5._id_0088)) {
        continue;
      }
      if(var_5._id_0088 != var_0) {
        if(!isPlayer(var_5._id_0088)) {
          continue;
        }
        if(!trap_zomboni_is_player_on_zomboni(var_5._id_0088, var_0)) {
          continue;
        }
      }

      var_6 = undefined;
      var_7 = undefined;

      foreach(var_2 in var_0.attack_locs) {
        if(isDefined(var_2.attacker)) {
          continue;
        }
        if(var_2.nexttimer > gettime()) {
          continue;
        }
        var_9 = anglesToForward(var_2.angles);
        var_10 = var_2.jump_radius * var_2.jump_radius;
        var_11 = anglesToForward(var_5.angles);

        if(vectordot(var_11, var_9) < 0.1) {
          continue;
        }
        var_12 = vectorNormalize(var_0.origin - var_5.origin);

        if(vectordot(var_12, var_11) < 0.1) {
          continue;
        }
        var_13 = distancesquared(var_2.origin, var_5.origin);

        if(var_13 < var_10) {
          if(!isDefined(var_6) || var_13 < var_7) {
            var_6 = var_2;
            var_7 = var_13;
          }
        }
      }

      if(isDefined(var_6)) {
        thread trap_zomboni_zombie_attack(var_0, var_5, var_6);
      }
    }
  }
}

trap_zomboni_assign_attack_ent(var_0, var_1, var_2) {
  var_1.attacker = var_2;
  common_scripts\utility::waittill_any_ents(self, "zomboni_done", var_2, "death");
  var_1.nexttimer = gettime() + _randomintrange(1000, 3000);
  var_1.attacker = undefined;
}

trap_zomboni_zombie_attack(var_0, var_1, var_2) {
  var_1 endon("death");
  thread trap_zomboni_assign_attack_ent(var_0, var_2, var_1);
  var_1 scragentsetscripted(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "AttackZomboni");
  var_1 scragentsetphysicsmode("noclip");
  trap_zomboni_zombie_attack_anims(var_0, var_1, var_2);
  var_1 scragentsetscripted(0);
  var_1 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "AttackZomboni");
}

trap_zomboni_zombie_attack_anims(var_0, var_1, var_2) {
  self endon("zomboni_done");
  var_1.zomboni = var_0;
  var_1.attack_ent = var_2;
  var_3 = "zomboni_attack_get_on";
  var_4 = 0.67;
  var_5 = distance(var_1.origin, var_2.origin);

  if(var_5 > var_2.grab_radius) {
    var_3 = "zomboni_attack_leap_on";
  }

  var_6 = var_2._id_0E18;
  var_1 scragentsetanimscale(0, 1);
  var_1 scragentsynchronizeanims(var_4, var_4, var_2, "tag_origin");
  var_1 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_3, var_6, 1.0, "scripted_anim");
  var_1 scragentsetanimscale(1, 1);

  for(;;) {
    var_3 = "zomboni_attack_zomboni";

    if(trap_zomboni_is_any_player_on_zomboni(var_0)) {
      var_3 = "zomboni_attack_player";
    }

    var_6 = var_2._id_0E18;
    var_1 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_3, var_6, 1.0, "scripted_anim", undefined, ::trap_zomboni_zombie_attack_notetracks);
    var_3 = "zomboni_attack_idle";
    var_6 = var_2._id_0E18;
    var_1 maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_3, var_6, 1.0);
    wait(_randomfloatrange(1.0, 2.5));
  }
}

trap_zomboni_zombie_attack_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "hit":
      var_4 = [];

      foreach(var_6 in level.players) {
        var_7 = var_6 getgroundentity();

        if(isDefined(var_7) && var_7 == self.zomboni.clip) {
          var_8 = _distance2d(self.attack_ent.origin, var_6.origin);

          if(var_8 < self.attack_ent.attack_radius) {
            var_4[var_4.size] = var_6;
          }
        }
      }

      foreach(var_6 in var_4) {
        self notify("attack_hit", var_6, var_6.origin);
        var_11 = 0;

        if(isDefined(self.meleedamage)) {
          var_11 = self.meleedamage;
        }

        if(isalive(var_6)) {
          maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(var_6, var_11, "MOD_IMPACT");
        }
      }

      break;
    default:
      break;
  }
}

trap_zomboni_notetracks(var_0) {
  self endon("zomboni_done");

  for(;;) {
    var_0 waittill("zomboni_anim", var_1);

    switch (var_1) {
      case "door_open":
        foreach(var_3 in var_0.doors) {
          trap_zomboni_door_open(var_3, 1.0);
        }

        break;
      case "door_close":
        foreach(var_3 in var_0.doors) {
          trap_zomboni_door_close(var_3, 1.0);
        }

        break;
      case "tag_hood_left":
        self notify("tag_hood_left");
        break;
      case "end":
        var_0 notify("end");
        break;
      case "enable_jumpon":
        var_0.jumpon_enabled = 1;

        foreach(var_8 in var_0.attack_locs) {
          var_8.nexttimer = gettime() + _randomintrange(0, 2000);
        }

        break;
      case "disable_jumpon":
        var_0.jumpon_enabled = 0;
        break;
      case "damage_rear":
      case "damage_left":
      case "damage_right":
      case "damage_sides":
        thread trap_zomboni_damage_jumpons(var_0, var_1);
        break;
      default:
        break;
    }
  }
}

trap_zomboni_damage_jumpons(var_0, var_1) {
  var_2 = [];
  var_2["damage_left"] = ["left"];
  var_2["damage_right"] = ["right"];
  var_2["damage_rear"] = ["rear"];
  var_2["damage_sides"] = ["left", "right"];
  var_3 = var_2[var_1];

  foreach(var_5 in var_3) {
    foreach(var_7 in var_0.attack_locs) {
      if(isDefined(var_7.attacker) && var_7.attack_name == var_5) {
        var_8 = var_7.attacker;
        var_8 dodamage(var_8.health, var_8.origin, self._id_0117, var_0, "MOD_TRIGGER_HURT", "trap_zm_mp");
      }
    }
  }
}

trap_zomboni_animated_distraction_update(var_0) {
  self endon("zomboni_done");
  self endon("tag_hood_left");
  wait 2;

  for(;;) {
    var_1 = var_0 gettagorigin("tag_hood");
    thread trap_zomboni_animated_distraction(var_1, 7);
    wait 3;
  }
}

trap_zomboni_animated_distraction(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.groundpos = var_0;
  var_2.team = level.playerteam;
  var_2.maxdistsqr = 640000;
  var_2.maxcount = 6;
  var_2.istrap = 1;
  var_2._id_0A54 = 0;
  var_2._id_08BE = 1;
  level notify("distraction_drone_activated", var_2);
  level.zdd_active[level.zdd_active.size] = var_2;
  wait(var_1);
  level.zdd_active = common_scripts\utility::_id_0F93(level.zdd_active, var_2);
  var_2._id_08BE = 0;
  var_2 notify("stop");
}

trap_zomboni_door_open(var_0, var_1) {
  var_0 moveTo(var_0.open_origin, var_1);
}

trap_zomboni_door_close(var_0, var_1) {
  var_0 moveTo(var_0.close_origin, var_1);
}

trap_zomboni_kill_zone(var_0) {
  self endon("zomboni_done");

  for(;;) {
    var_0.killtrigger waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }
    if(var_1 _id_0547::istrapresistant()) {
      continue;
    }
    if(isDefined(var_1.nexttrapdamage) && var_1.nexttrapdamage > gettime()) {
      continue;
    }
    if(var_0.isstopped) {
      continue;
    }
    var_1.nexttrapdamage = gettime() + 200;

    if(isPlayer(var_1)) {
      var_1 dodamage(10, var_1.origin, undefined, var_0);
      continue;
    }

    thread trap_zomboni_play_churn_fx(var_0);

    if(!_isscriptedagent(var_1) || var_1._id_0A4B == "zombie_dog") {
      var_1 dodamage(var_1.health, var_1.origin, self._id_0117, var_0, "MOD_TRIGGER_HURT", "trap_zm_mp");
      continue;
    }

    trap_zomboni_try_zombie_death_anim(var_0, var_1);
  }
}

trap_zomboni_play_churn_fx(var_0) {
  var_0 notify("play_churn_fx");
  var_0 endon("play_churn_fx");

  if(!common_scripts\utility::_id_562E(var_0.churn_fx)) {
    _playFXOnTag(common_scripts\utility::getfx("chompy_churn"), var_0, "tag_body");
  }

  var_0.churn_fx = 1;
  wait 5;
  var_0.churn_fx = 0;
  _stopFXOnTag(common_scripts\utility::getfx("chompy_churn"), var_0, "tag_body");
}

trap_zomboni_try_zombie_death_anim(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1.zomboni_death)) {
    return 1;
  }

  if(var_1 maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return 0;
  }

  thread trap_zomboni_zombie_death_anim(var_0, var_1);
  return 1;
}

trap_zomboni_zombie_death_anim(var_0, var_1) {
  var_1 notify("killanimscript");
  var_1.zomboni_death = 1;
  var_1 scragentsetanimmode("anim deltas");
  var_1 scragentsetanimscale(1, 1);
  var_1 scragentsetphysicsmode("noclip");
  var_2 = _angleclamp180(var_0.angles[1] - var_1.angles[1]);
  var_3 = "zomboni_trap_victim";
  var_4 = var_1 getanimentrycount(var_3);
  var_5 = 0;

  if(_abs(var_2) < 45) {
    var_5 = 3;

    if(var_4 > 3 && common_scripts\utility::cointoss()) {
      var_5 = 4;
    }
  } else if(var_2 < 135)
    var_5 = 2;
  else if(var_2 > -135) {
    var_5 = 1;
  }

  var_6 = undefined;
  var_7 = undefined;
  var_8 = ["tag_zom_align_center", "tag_zom_align_right", "tag_zom_align_left"];

  foreach(var_10 in var_8) {
    var_11 = var_0 gettagorigin(var_10);
    var_12 = _distance2d(var_11, var_1.origin);

    if(!isDefined(var_6) || var_12 < var_7) {
      var_6 = var_10;
      var_7 = var_12;
    }
  }

  var_1.godmode = 1;
  var_1 scragentsetscripted(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "SynchronizedAnim");
  var_1 scragentsetphysicsmode("noclip");
  var_1 scragentsynchronizeanims(0.5, 0.5, var_0, var_6);
  var_1 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_3, var_5, 1.0, "scripted_anim", undefined, ::trap_zomboni_zombie_death_notetracks);
  var_1.godmode = 0;
  var_1._id_1DEB = 1;
  var_1 dodamage(var_1.health, var_1.origin, self._id_0117, var_0, "MOD_TRIGGER_HURT", "trap_zm_mp");
}

trap_zomboni_zombie_death_notetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "remove_head":
      var_4 = _id_0541::locationtobodypart("head");
      _id_0541::mutilate(self.missingbodyparts | var_4, 1, 1, (0, 0, 1), 0);
      break;
    case "remove_arms":
      var_5 = _id_0541::locationtobodypart("right_arm_lower");
      var_6 = _id_0541::locationtobodypart("left_arm_lower");
      var_7 = common_scripts\utility::random([var_5, var_6, var_5 | var_6]);
      _id_0541::mutilate(self.missingbodyparts | var_7, 1, 1, (0, 0, 1), 0);
      break;
    case "remove_legs":
      var_8 = _id_0541::locationtobodypart("right_leg_lower");
      var_9 = _id_0541::locationtobodypart("left_leg_lower");
      var_10 = common_scripts\utility::random([var_8, var_9, var_8 | var_9]);
      _id_0541::mutilate(self.missingbodyparts | var_10, 1, 1, (0, 0, 1), 0);
      break;
    default:
      break;
  }
}

trap_zomboni_process_path(var_0, var_1) {
  var_0.path_nodes = [];
  var_0.notify_path_nodes = [];
  var_2 = var_1.origin;
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;
  var_6 = undefined;

  while(isDefined(var_1)) {
    var_7 = trap_zomboni_path_get_linked_ents(var_1);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9._id_0165)) {
        continue;
      }
      switch (var_9._id_0165) {
        case "door":
          var_9.close_origin = var_9.origin;
          var_9.open_origin = var_9.close_origin + (0, 0, 60);
          break;
        case "distraction":
          var_9._id_08BE = 0;
          break;
        default:
          break;
      }
    }

    var_11 = var_0 getattachpos(var_1)[0];

    if((!isDefined(var_4) || distance(var_4.origin, var_11) > 400) && distance(var_2, var_11) > 300) {
      var_1.distraction = spawnStruct();
      var_1.distraction.origin = var_11;
      var_4 = var_1.distraction;
    }

    if(isDefined(var_6)) {
      var_5 = var_5 + distance(var_1.origin, var_6.origin);
    }

    var_1.pathdist = var_5;
    var_0.path_nodes[var_0.path_nodes.size] = var_1;

    if(isDefined(var_1._id_0165)) {
      var_1.notes = strtok(var_1._id_0165, ",");
      var_0.notify_path_nodes[var_0.notify_path_nodes.size] = var_1;

      foreach(var_13 in var_1.notes) {
        switch (var_13) {
          case "door_close":
            var_3 = !var_3;
            break;
          default:
            break;
        }
      }
    }

    if(isDefined(var_1.target)) {
      var_6 = var_1;
      var_1 = _getvehiclenode(var_1.target, "targetname");
      continue;
    }

    break;
  }

  var_0.pathdist = var_5;
}

trap_zomboni_path_node_passed(var_0, var_1) {
  self endon("zomboni_done");
  var_1 waittill("trigger");
  var_1 notify("passed", var_0);
  var_0 notify("passed_node", var_1);
  var_1._id_6EAA = 1;
}

trap_zomboni_path_notify(var_0, var_1) {
  self endon("zomboni_done");

  for(;;) {
    var_1 waittill("trigger");

    foreach(var_3 in var_1.notes) {
      switch (var_3) {
        case "door_open":
          var_4 = 1;
          var_0 zomboni_stop();
          var_5 = trap_zomboni_path_get_linked_ents(var_1, "door");

          foreach(var_7 in var_5) {
            thread trap_zomboni_door_open(var_7, var_4);
          }

          wait(var_4);
          var_0 zomboni_resume();
          break;
        case "door_close":
          var_9 = 1;
          var_5 = trap_zomboni_path_get_linked_ents(var_1, "door");

          foreach(var_7 in var_5) {
            thread trap_zomboni_door_close(var_7, var_9);
          }

          break;
        case "end":
          var_0 notify("end");
          break;
        default:
          break;
      }
    }
  }
}

trap_zomboni_distraction(var_0, var_1) {
  var_2 = 2000;

  if(var_0.pathdist > var_2) {
    for(;;) {
      var_1 waittill("passed_node", var_3);

      if(var_0.pathdist - var_3.pathdist < var_2) {
        break;
      }
    }
  }

  self.groundpos = self.origin;
  self.team = level.playerteam;
  self.maxdistsqr = 640000;
  self.maxcount = 6;
  self.istrap = 1;
  self._id_0A54 = 0;
  self._id_08BE = 1;
  level notify("distraction_drone_activated", self);
  level.zdd_active[level.zdd_active.size] = self;
  var_0 waittill("passed");
  level.zdd_active = common_scripts\utility::_id_0F93(level.zdd_active, self);
  self._id_08BE = 0;
  self notify("stop");
}

trap_zomboni_path_get_linked_ents(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0.script_exploder)) {
    var_3 = strtok(var_0.script_exploder, " ");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = _getEnt(var_3[var_4], "script_linkname");

      if(isDefined(var_5)) {
        if(!isDefined(var_1) || isDefined(var_5._id_0165) && var_5._id_0165 == var_1) {
          var_2[var_2.size] = var_5;
        }
      }
    }
  }

  return var_2;
}

zomboni_stop() {
  self vehicle_setspeed(0, 100, 100);
}

zomboni_resume() {
  self resumespeed(100);
}

_id_0904(var_0) {
  if(!isDefined(level._id_6667)) {
    level._id_6667 = [];
  }

  level._id_6667 common_scripts\utility::_id_0972(level._id_6667, var_0);
}
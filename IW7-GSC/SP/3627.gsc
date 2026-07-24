/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3627.gsc
**************************************/

_id_C32F() {
  precacheitem("offhandshield");
  precacheitem("offhandshield_up1");
  precachestring(&"EQUIPMENT_SHIELD_MELEE_HINT");
  level.player scripts\sp\utility::_id_65E0("player_retract_shield_active");
  level.player._id_C337 = spawnStruct();
  level.player._id_C337._id_260E = 0;
  level.player._id_C337.active = 0;
  level.player._id_C337._id_9936 = 0;
  level.player._id_C337._id_B620 = 0;
  level._id_7649["shield_ping"] = loadfx("vfx/iw7/core/equipment/offhandshield/vfx_shield_ping.vfx");
  scripts\sp\utility::_id_9187("shield", 200, ::_id_FC8B);
  level.player._id_C337._id_CB8F = spawnStruct();
  level.player._id_C337._id_CB8F.interval = 5;
  level.player._id_C337._id_CB8F._id_56E8 = getdvarint("offhandshield_sweepRange");
  level.player._id_C337._id_CB8F.time = getdvarint("offhandshield_sweepTime");
  level.player._id_C337._id_CB8F.speed = level.player._id_C337._id_CB8F._id_56E8 / level.player._id_C337._id_CB8F.time;
  level._id_6DD1 = 1;
  scripts\sp\utility::_id_16EB("shield_recharge", &"WEAPON_HELP_SHIELD_RECHARGE");
  scripts\sp\utility::_id_16EB("shield_recharge_remind", &"WEAPON_HELP_SHIELD_RECHARGE");
}

_id_C334() {
  self endon("death");
  self endon("secondary_equipment_change");
  childthread _id_C330();
  childthread _id_DDD3();
  childthread _id_DDD4();
  thread offhand_shield_unequip_think();

  for(;;) {
    self waittill("offhandshield_deploy");

    if(scripts\engine\utility::is_true(self._id_9DD2) || scripts\engine\utility::is_true(self._id_939E)) {
      wait 0.05;
      continue;
    }

    thread on_deploy();
    self waittill("offhandshield_retract");

    if(scripts\sp\utility::_id_65DB("player_retract_shield_active")) {
      thread on_retract();
    }
  }
}

offhand_shield_unequip_think() {
  self endon("death");
  self waittill("secondary_equipment_change");

  if(scripts\sp\utility::_id_65DB("player_retract_shield_active")) {
    thread on_retract();
  }
}

on_deploy() {
  self endon("offhandshield_on_retract");
  self notify("offhandshield_on_deploy");
  scripts\engine\utility::allow_usability(0);
  thread _id_DBE4();
  scripts\sp\utility::_id_65E1("player_retract_shield_active");
  scripts\engine\utility::flag_set("secondary_equipment_in_use");
  level.player._id_C337.active = 1;
  setomnvar("ui_offhandshield_in_use", 1);
  setomnvar("ui_wrist_pc", 6);

  if(!level.player._id_C337._id_9936) {
    setsaveddvar("offhandShield_outlineMode", 2);
    thread _id_CB92();
  } else
    setsaveddvar("offhandShield_outlineMode", 1);

  thread _id_C32D(1);
  scripts\sp\utility::_id_1C49(0);
  level.player thread scripts\anim\battlechatter_ai::_id_67CF("offhandshield");
  wait 0.2;
  thread scripts\sp\utility::_id_9199("shield", 1);
  wait 0.4;
  thread _id_B594();
}

on_retract() {
  self endon("offhandshield_on_deploy");
  self notify("offhandshield_on_retract");
  level.player._id_C337.active = 0;
  thread _id_C32D(0);
  scripts\sp\utility::_id_65DD("player_retract_shield_active");
  scripts\engine\utility::flag_clear("secondary_equipment_in_use");
  scripts\sp\utility::_id_1C49(1);
  setomnvar("ui_offhandshield_in_use", 0);
  setomnvar("ui_wrist_pc", 1);
  scripts\engine\utility::allow_usability(1);
  wait 0.15;
  scripts\sp\utility::_id_9199("shield", 0);
}

_id_DBE4() {
  self endon("offhandshield_on_retract");

  for(;;) {
    self waittill("melee");
    thread _id_0B1D::_id_DBDB(self getEye() + anglesToForward(self getplayerangles()) * 25, 0.098);
  }
}

_id_DDD3() {
  if(isDefined(level.player._id_C337._id_54C2)) {
    return;
  }
  while(level.player _meth_84D0() > getdvarfloat("offhandshield_minenergyfordeploy")) {
    wait 0.15;
  }

  scripts\sp\utility::_id_56BE("shield_recharge", 3);
  level.player._id_C337._id_54C2 = 1;
}

_id_DDD4() {
  for(;;) {
    level.player waittill("secondary_equipment_pressed");

    if(level.player _meth_84D0() < getdvarfloat("offhandshield_minenergyfordeploy")) {
      scripts\sp\utility::_id_56BE("shield_recharge_remind", 3);
      wait 3;
    }
  }
}

_id_B594() {
  if(!level.player._id_C337.active) {
    return;
  }
  if(isDefined(level.player._id_C337._id_28B5)) {
    return;
  }
  if(level.player._id_C337._id_B620 > 5) {
    return;
  }
  level.player._id_C337._id_B620++;
  level.player._id_C337._id_28B5 = 1;
  var_0 = scripts\sp\hud_util::createfontstring("objective", 1.25);
  var_0 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, 116);
  var_0.alpha = 1;
  var_0 settext(&"EQUIPMENT_SHIELD_MELEE_HINT");
  _id_13746(1);
  var_1 = 0.25;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 destroy();
  level.player._id_C337._id_28B5 = undefined;
}

_id_13746(var_0) {
  self endon("offhandshield_retract");
  wait(var_0);
}

_id_C330() {
  var_0 = level.player _meth_84CF() * 0.25;

  for(;;) {
    var_1 = level.player _meth_84D0();

    if(var_1 <= var_0 && self._id_C337.active) {
      thread scripts\engine\utility::play_loop_sound_on_entity("retract_shield_energy_alarm");
      childthread _id_C339(var_0);

      while(self _meth_84D0() < var_0 && self._id_C337.active) {
        wait 0.05;
      }

      self notify("stop soundretract_shield_energy_alarm");
    }

    wait 0.05;
  }
}

_id_C339(var_0) {
  if(isDefined(self._id_C337._id_FC8E)) {
    return;
  }
  self._id_C337._id_FC8E = 1;

  while(self _meth_84D0() < var_0) {
    wait 0.05;
  }

  scripts\sp\utility::play_sound_on_entity("retract_shield_ready");
  self._id_C337._id_FC8E = undefined;
}

_id_C32D(var_0) {
  if(var_0 && !level.player._id_C337._id_260E) {
    level.player._id_C337._id_260E = 1;
    level.player thread scripts\engine\utility::play_loop_sound_on_entity("retract_shield_energy_hum");
  } else if(!var_0 && level.player._id_C337._id_260E) {
    level.player._id_C337._id_260E = 0;
    level.player notify("stop soundretract_shield_energy_hum");
  }
}

_id_CB92(var_0) {
  self endon("offhandshield_retract");
  var_1 = 1;
  var_2 = [];
  wait 0.15;

  for(;;) {
    level.player._id_C337._id_CB8F.interval = 5;
    var_2 = scripts\engine\utility::array_remove_array(var_2, var_2);
    var_3 = getaiarray();

    if(isDefined(level.player._id_C337._id_6A48)) {
      var_3 = scripts\engine\utility::array_combine(var_3, level._id_C337._id_6A48);
    }

    foreach(var_5 in var_3) {
      var_6 = distance(var_5.origin, self.origin);

      if(var_6 > level.player._id_C337._id_CB8F._id_56E8) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
        continue;
      }

      if(var_5.ignoreme) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
        continue;
      }

      var_5._id_D028 = var_6;
    }

    if(!var_3.size) {
      wait(level.player._id_C337._id_CB8F.interval);
      continue;
    }

    var_8 = scripts\sp\utility::_id_78BB(self.origin, var_3, level.player._id_C337._id_CB8F._id_56E8);
    var_9 = scripts\sp\utility::_id_79B3(self.origin, var_3);
    var_10 = distance2d(level.player.origin, var_8.origin) / level.player._id_C337._id_CB8F.speed;

    if(!isDefined(var_8)) {
      wait(level.player._id_C337._id_CB8F.interval);
      continue;
    }

    if(var_8._id_D028 <= level.player._id_C337._id_CB8F._id_56E8) {
      if(var_8._id_D028 <= level.player._id_C337._id_CB8F.time * 0.5) {
        level.player._id_C337._id_CB8F.interval = level.player._id_C337._id_CB8F.interval * 0.5;
      } else if(var_8._id_D028 <= level.player._id_C337._id_CB8F.time * 0.75) {
        level.player._id_C337._id_CB8F.interval = level.player._id_C337._id_CB8F.interval * 0.75;
      }
    }

    if(level.player._id_C337._id_CB8F.interval < var_1) {
      level.player._id_C337._id_CB8F.interval = var_1;
    }

    if(var_3.size && level._id_6DD1) {
      level._id_6DD1 = 0;
      level notify("first_pinged_ents");
    }

    doping();
    scripts\engine\utility::array_thread([var_8, var_9], ::_id_CB94, level.player._id_C337._id_CB8F.speed);
    var_11 = 1;
    var_12 = level.player._id_C337._id_CB8F.interval - var_11;

    if(var_12 > var_11) {
      wait(var_12);
      continue;
    }

    wait(var_11);
  }
}

doping() {
  thread scripts\sp\utility::play_sound_on_entity("retract_shield_tracker_pulse");
  self _meth_854F();
}

_id_CB94(var_0) {
  self endon("death");
  var_1 = distance2d(level.player.origin, self.origin) / var_0;
  var_1 = var_1 / 1000;
  wait(var_1);
  thread _id_CB95(var_1);
}

_id_CB95(var_0) {
  if(!isalive(self)) {
    return;
  }
  var_1 = scripts\sp\math::_id_C097(0.1, 1, var_0);
  var_2 = scripts\sp\math::_id_6A8E(1.1, 0.8, var_1);

  if(issentient(self)) {
    var_3 = self getEye();
  } else {
    var_3 = self.origin;
  }

  var_4 = spawn("script_origin", var_3);
  var_4 playSound("retract_shield_tracker_3d_target", "sounddone");
  var_4 _meth_8277(var_2);
  var_4 waittill("sounddone");
  var_4 delete();
}

_id_C76C(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = getaiarray();
  var_3 = getspawnerarray();

  if(var_0) {
    scripts\engine\utility::array_thread(var_2, ::_id_C76A);

    if(var_3.size) {
      scripts\sp\utility::_id_22C7(var_3, ::_id_C76A);
    }
  } else {
    scripts\engine\utility::array_thread(var_2, ::_id_C769);

    if(var_3.size) {
      scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_E08B, ::_id_C76A);
    }
  }
}

_id_C76A() {
  if(isDefined(self._id_FC9D)) {
    return;
  }
  self._id_FC9D = 1;

  if(isDefined(self.team) && self.team == "allies") {
    scripts\sp\utility::_id_9196(3, 0, 1, "shield");
  } else {
    scripts\sp\utility::_id_9196(1, 0, 1, "shield");
  }
}

_id_C769() {
  self._id_FC9D = undefined;
  scripts\sp\utility::_id_9193("shield");
  self notify("shield_hudoutline_off");
}

_id_C77F() {
  setsaveddvar("r_hudoutlineWidth", "1");
  setsaveddvar("r_hudoutlineFillColor0", "0.8 0.8 0.8 1");
  setsaveddvar("r_hudoutlineOccludedOutlineColor", "0.8 0.8 0.8 1");
  setsaveddvar("r_hudoutlineOccludedInteriorColor", "0.5 0.5 0.5 1");
  setsaveddvar("r_hudoutlineOccludedInlineColor", "0.5 0.5 0.5 1");
  setsaveddvar("r_hudoutlineFillColor1", "0.8 0.8 0.8 .2");
  setsaveddvar("r_hudOutlineOccludedColorFromFill", "1");
}

_id_FC8B() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor1"] = "0 0 0 1";
  var_0["r_hudoutlineFillColor0"] = "0.8 0.8 0.8 1";
  var_0["r_hudoutlineOccludedOutlineColor"] = "0.8 0.8 0.8 1";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 .2";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 .5";
  var_0["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 .2";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_C780(var_0) {
  _id_AB81(1);

  if(isDefined(var_0)) {
    wait(var_0);
  }

  _id_AB81(0);
}

_id_AB81(var_0) {
  var_1 = scripts\engine\utility::ter_op(var_0, 0.1, 1);
  var_2 = 0.05;
  var_3 = "0.8 0.8 0.8 ";
  var_4 = "0.5 0.5 0.5 ";

  for(var_5 = 1; var_5 < 11; var_5++) {
    setsaveddvar("r_hudoutlineFillColor0", var_3 + var_1 + "");
    setsaveddvar("r_hudoutlineOccludedOutlineColor", var_3 + var_1 + "");
    setsaveddvar("r_hudoutlineOccludedInteriorColor", var_4 + var_1 + "");

    if(var_0 && var_5 < 2) {
      setsaveddvar("r_hudoutlineFillColor1", var_3 + var_1 + "");
    } else if(!var_0 && var_5 > 2) {
      setsaveddvar("r_hudoutlineFillColor1", var_3 + var_1 + "");
    }

    setsaveddvar("r_hudoutlineOccludedInlineColor", var_4 + var_1 + "");

    if(var_0) {
      var_1 = scripts\engine\utility::ter_op(var_5 == 9, 1, var_1 + 0.1);
    } else {
      var_1 = scripts\engine\utility::ter_op(var_5 == 9, 0, var_1 - 0.1);
    }

    wait(var_2);
  }

  wait(var_2);
}
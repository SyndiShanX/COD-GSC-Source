/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3627.gsc
************************/

func_C32F() {
  precacheitem("offhandshield");
  precacheitem("offhandshield_up1");
  precachestring(&"EQUIPMENT_SHIELD_MELEE_HINT");
  level.player scripts\sp\utility::func_65E0("player_retract_shield_active");
  level.player.var_C337 = spawnStruct();
  level.player.var_C337.var_260E = 0;
  level.player.var_C337.var_19 = 0;
  level.player.var_C337.var_9936 = 0;
  level.player.var_C337.var_B620 = 0;
  level.var_7649["shield_ping"] = loadfx("vfx\iw7\core\equipment\offhandshield\vfx_shield_ping.vfx");
  scripts\sp\utility::func_9187("shield", 200, ::func_FC8B);
  level.player.var_C337.var_CB8F = spawnStruct();
  level.player.var_C337.var_CB8F.queuedialog = 5;
  level.player.var_C337.var_CB8F.var_56E8 = getdvarint("offhandshield_sweepRange");
  level.player.var_C337.var_CB8F.time = getdvarint("offhandshield_sweepTime");
  level.player.var_C337.var_CB8F.getclosestpointonnavmesh3d = level.player.var_C337.var_CB8F.var_56E8 / level.player.var_C337.var_CB8F.time;
  level.var_6DD1 = 1;
  scripts\sp\utility::func_16EB("shield_recharge", &"WEAPON_HELP_SHIELD_RECHARGE");
  scripts\sp\utility::func_16EB("shield_recharge_remind", &"WEAPON_HELP_SHIELD_RECHARGE");
}

func_C334() {
  self endon("death");
  self endon("secondary_equipment_change");
  childthread func_C330();
  childthread func_DDD3();
  childthread func_DDD4();
  thread offhand_shield_unequip_think();
  for(;;) {
    self waittill("offhandshield_deploy");
    if(scripts\engine\utility::istrue(self.var_9DD2) || scripts\engine\utility::istrue(self.var_939E)) {
      wait(0.05);
      continue;
    }

    thread on_deploy();
    self waittill("offhandshield_retract");
    if(scripts\sp\utility::func_65DB("player_retract_shield_active")) {
      thread on_retract();
    }
  }
}

offhand_shield_unequip_think() {
  self endon("death");
  self waittill("secondary_equipment_change");
  if(scripts\sp\utility::func_65DB("player_retract_shield_active")) {
    thread on_retract();
  }
}

on_deploy() {
  self endon("offhandshield_on_retract");
  self notify("offhandshield_on_deploy");
  scripts\engine\utility::allow_usability(0);
  thread func_DBE4();
  scripts\sp\utility::func_65E1("player_retract_shield_active");
  scripts\engine\utility::flag_set("secondary_equipment_in_use");
  level.player.var_C337.var_19 = 1;
  setomnvar("ui_offhandshield_in_use", 1);
  setomnvar("ui_wrist_pc", 6);
  if(!level.player.var_C337.var_9936) {
    setsaveddvar("offhandShield_outlineMode", 2);
    thread func_CB92();
  } else {
    setsaveddvar("offhandShield_outlineMode", 1);
  }

  thread func_C32D(1);
  scripts\sp\utility::func_1C49(0);
  level.player thread scripts\anim\battlechatter_ai::func_67CF("offhandshield");
  wait(0.2);
  thread scripts\sp\utility::func_9199("shield", 1);
  wait(0.4);
  thread func_B594();
}

on_retract() {
  self endon("offhandshield_on_deploy");
  self notify("offhandshield_on_retract");
  level.player.var_C337.var_19 = 0;
  thread func_C32D(0);
  scripts\sp\utility::func_65DD("player_retract_shield_active");
  scripts\engine\utility::flag_clear("secondary_equipment_in_use");
  scripts\sp\utility::func_1C49(1);
  setomnvar("ui_offhandshield_in_use", 0);
  setomnvar("ui_wrist_pc", 1);
  scripts\engine\utility::allow_usability(1);
  wait(0.15);
  scripts\sp\utility::func_9199("shield", 0);
}

func_DBE4() {
  self endon("offhandshield_on_retract");
  for(;;) {
    self waittill("melee");
    thread scripts\sp\detonategrenades::func_DBDB(self getEye() + anglesToForward(self getplayerangles()) * 25, 0.098);
  }
}

func_DDD3() {
  if(isDefined(level.player.var_C337.var_54C2)) {
    return;
  }

  while(level.player _meth_84D0() > getdvarfloat("offhandshield_minenergyfordeploy")) {
    wait(0.15);
  }

  scripts\sp\utility::func_56BE("shield_recharge", 3);
  level.player.var_C337.var_54C2 = 1;
}

func_DDD4() {
  for(;;) {
    level.player waittill("secondary_equipment_pressed");
    if(level.player _meth_84D0() < getdvarfloat("offhandshield_minenergyfordeploy")) {
      scripts\sp\utility::func_56BE("shield_recharge_remind", 3);
      wait(3);
    }
  }
}

func_B594() {
  if(!level.player.var_C337.var_19) {
    return;
  }

  if(isDefined(level.player.var_C337.var_28B5)) {
    return;
  }

  if(level.player.var_C337.var_B620 > 5) {
    return;
  }

  level.player.var_C337.var_B620++;
  level.player.var_C337.var_28B5 = 1;
  var_0 = scripts\sp\hud_util::createfontstring("objective", 1.25);
  var_0 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, 116);
  var_0.alpha = 1;
  var_0 settext(&"EQUIPMENT_SHIELD_MELEE_HINT");
  func_13746(1);
  var_1 = 0.25;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 destroy();
  level.player.var_C337.var_28B5 = undefined;
}

func_13746(var_0) {
  self endon("offhandshield_retract");
  wait(var_0);
}

func_C330() {
  var_0 = level.player _meth_84CF() * 0.25;
  for(;;) {
    var_1 = level.player _meth_84D0();
    if(var_1 <= var_0 && self.var_C337.var_19) {
      thread scripts\engine\utility::play_loop_sound_on_entity("retract_shield_energy_alarm");
      childthread func_C339(var_0);
      while(self _meth_84D0() < var_0 && self.var_C337.var_19) {
        wait(0.05);
      }

      self notify("stop soundretract_shield_energy_alarm");
    }

    wait(0.05);
  }
}

func_C339(var_0) {
  if(isDefined(self.var_C337.var_FC8E)) {
    return;
  }

  self.var_C337.var_FC8E = 1;
  while(self _meth_84D0() < var_0) {
    wait(0.05);
  }

  scripts\sp\utility::play_sound_on_entity("retract_shield_ready");
  self.var_C337.var_FC8E = undefined;
}

func_C32D(var_0) {
  if(var_0 && !level.player.var_C337.var_260E) {
    level.player.var_C337.var_260E = 1;
    level.player thread scripts\engine\utility::play_loop_sound_on_entity("retract_shield_energy_hum");
    return;
  }

  if(!var_0 && level.player.var_C337.var_260E) {
    level.player.var_C337.var_260E = 0;
    level.player notify("stop soundretract_shield_energy_hum");
  }
}

func_CB92(var_0) {
  self endon("offhandshield_retract");
  var_1 = 1;
  var_2 = [];
  wait(0.15);
  for(;;) {
    level.player.var_C337.var_CB8F.queuedialog = 5;
    var_2 = scripts\engine\utility::array_remove_array(var_2, var_2);
    var_3 = getaiarray();
    if(isDefined(level.player.var_C337.var_6A48)) {
      var_3 = scripts\engine\utility::array_combine(var_3, level.var_C337.var_6A48);
    }

    foreach(var_5 in var_3) {
      var_6 = distance(var_5.origin, self.origin);
      if(var_6 > level.player.var_C337.var_CB8F.var_56E8) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
        continue;
      }

      if(var_5.ignoreme) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
        continue;
      }

      var_5.var_D028 = var_6;
    }

    if(!var_3.size) {
      wait(level.player.var_C337.var_CB8F.queuedialog);
      continue;
    }

    var_8 = scripts\sp\utility::func_78BB(self.origin, var_3, level.player.var_C337.var_CB8F.var_56E8);
    var_9 = scripts\sp\utility::func_79B3(self.origin, var_3);
    var_0A = distance2d(level.player.origin, var_8.origin) / level.player.var_C337.var_CB8F.getclosestpointonnavmesh3d;
    if(!isDefined(var_8)) {
      wait(level.player.var_C337.var_CB8F.queuedialog);
      continue;
    }

    if(var_8.var_D028 <= level.player.var_C337.var_CB8F.var_56E8) {
      if(var_8.var_D028 <= level.player.var_C337.var_CB8F.time * 0.5) {
        level.player.var_C337.var_CB8F.queuedialog = level.player.var_C337.var_CB8F.queuedialog * 0.5;
      } else if(var_8.var_D028 <= level.player.var_C337.var_CB8F.time * 0.75) {
        level.player.var_C337.var_CB8F.queuedialog = level.player.var_C337.var_CB8F.queuedialog * 0.75;
      }
    }

    if(level.player.var_C337.var_CB8F.queuedialog < var_1) {
      level.player.var_C337.var_CB8F.queuedialog = var_1;
    }

    if(var_3.size && level.var_6DD1) {
      level.var_6DD1 = 0;
      level notify("first_pinged_ents");
    }

    doping();
    scripts\engine\utility::array_thread([var_8, var_9], ::func_CB94, level.player.var_C337.var_CB8F.getclosestpointonnavmesh3d);
    var_0B = 1;
    var_0C = level.player.var_C337.var_CB8F.queuedialog - var_0B;
    if(var_0C > var_0B) {
      wait(var_0C);
      continue;
    }

    wait(var_0B);
  }
}

doping() {
  thread scripts\sp\utility::play_sound_on_entity("retract_shield_tracker_pulse");
  self _meth_854F();
}

func_CB94(var_0) {
  self endon("death");
  var_1 = distance2d(level.player.origin, self.origin) / var_0;
  var_1 = var_1 / 1000;
  wait(var_1);
  thread func_CB95(var_1);
}

func_CB95(var_0) {
  if(!isalive(self)) {
    return;
  }

  var_1 = scripts\sp\math::func_C097(0.1, 1, var_0);
  var_2 = scripts\sp\math::func_6A8E(1.1, 0.8, var_1);
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

func_C76C(var_0, var_1) {
  self endon("death");
  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = getaiarray();
  var_3 = getspawnerarray();
  if(var_0) {
    scripts\engine\utility::array_thread(var_2, ::func_C76A);
    if(var_3.size) {
      scripts\sp\utility::func_22C7(var_3, ::func_C76A);
      return;
    }

    return;
  }

  scripts\engine\utility::array_thread(var_2, ::func_C769);
  if(var_3.size) {
    scripts\engine\utility::array_thread(var_3, ::scripts\sp\utility::func_E08B, ::func_C76A);
  }
}

func_C76A() {
  if(isDefined(self.var_FC9D)) {
    return;
  }

  self.var_FC9D = 1;
  if(isDefined(self.team) && self.team == "allies") {
    scripts\sp\utility::func_9196(3, 0, 1, "shield");
    return;
  }

  scripts\sp\utility::func_9196(1, 0, 1, "shield");
}

func_C769() {
  self.var_FC9D = undefined;
  scripts\sp\utility::func_9193("shield");
  self notify("shield_hudoutline_off");
}

func_C77F() {
  setsaveddvar("r_hudoutlineWidth", "1");
  setsaveddvar("r_hudoutlineFillColor0", "0.8 0.8 0.8 1");
  setsaveddvar("r_hudoutlineOccludedOutlineColor", "0.8 0.8 0.8 1");
  setsaveddvar("r_hudoutlineOccludedInteriorColor", "0.5 0.5 0.5 1");
  setsaveddvar("r_hudoutlineOccludedInlineColor", "0.5 0.5 0.5 1");
  setsaveddvar("r_hudoutlineFillColor1", "0.8 0.8 0.8 .2");
  setsaveddvar("r_hudOutlineOccludedColorFromFill", "1");
}

func_FC8B() {
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

func_C780(var_0) {
  func_AB81(1);
  if(isDefined(var_0)) {
    wait(var_0);
  }

  func_AB81(0);
}

func_AB81(var_0) {
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
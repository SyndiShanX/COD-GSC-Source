/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_tower_battle.gsc
**************************************************************/

main() {
  level._id_7AC8 = ["clear_tower_behavior", "is_tower_battle_distracted"];
  thread maps\mp\mp_zombie_nest_ee_tower_battle_zombie_states::_id_528A();
  common_scripts\utility::flag_init("flag_fuse_entered_correct");
  common_scripts\utility::flag_init("aud_stop_rod_movement_sounds");
  _id_52ED();
}

_id_170D() {
  var_0 = 1;
  level thread _id_27CD("inner_spire", "nest_ee_fuse_piece_lift", ["tower_outter_attack_point_center"], "inner objective success", "inner objective fail", var_0, ["inner_spire_lever"], "5 Right Hand fuses", ::_id_6B47);
}

_id_1715() {
  var_0 = 2;
  level thread _id_27CD("outter_spire", "nest_ee_fuse_outter_objectives", ["tower_outter_attack_point_left", "tower_outter_attack_point_right"], "outter objective success", "outter objective fail", var_0, ["outter_spire_left_lever", "outter_spire_right_lever"], "5 Right Hand fuses", ::_id_6B60);
}

_id_6B47() {
  level thread _id_2E7C();
  _id_0557::_id_782D("5 Right Hand fuses", "lift center rod");
}

_id_6B60() {
  _id_0557::_id_782D("5 Right Hand fuses", "lift outter rods");
}

_id_27CD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_46ED(var_0, var_1, var_2);
  var_10 = _id_86D9(var_3, var_4, var_5, var_6);
  _id_8A37("5 Right Hand fuses", var_10["machine_targetnames"]);
  var_9["main_trigger"] _id_52FA(var_10["machine_targetnames"]);
  var_11 = common_scripts\utility::_id_46B5("tower_attack_on_deck_positions_struct", "targetname");
  var_12 = spawnStruct();
  var_12._id_7B8C = var_12;
  var_12._id_38C3 = "zombie_tower_rumble_" + var_10["battleID"];
  var_12._id_38C4 = _id_46EE(var_10["battleID"]);
  maps\mp\mp_zombie_nest_special_event_creator::_id_3135(::_id_A69B, var_9["main_trigger"], var_9["attack_positions"], var_10["battleID"], var_10["notifications"], var_9["activation_triggers"], "zone1_4_bridge_tower", var_11.origin, ::_id_6A77, ::_id_6A76, ::_id_6A78, var_12, ::_id_6A7D, "tower_attack_on_deck_positions_struct");
  [[var_8]]();
}

_id_6A77(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B5("tower_battle_sfx_top", "targetname");
  var_3 thread _id_0378::_id_8D74("aud_tower_alarm");

  foreach(var_5 in var_0)
  var_5._id_08BC = level._id_A980;

  if(!var_1) {
    if(var_2 == 1)
      _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_FIRST_LIGHTNING_ROD");
    else if(var_2 == 2)
      _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_TWO_LIGHTNING_RODS");
  }
}

_id_6A78(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B5("tower_battle_sfx_top", "targetname");
  var_3 thread _id_0378::_id_8D74("aud_tower_alarm_stop");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_tower_battle", get_lowest_attack_spot_health(var_1));

  foreach(var_5 in var_0._id_65E8) {
    var_5 _id_A180(5, 1, 0);
    var_5 _id_A180(5, 1, 2);
  }

  foreach(var_8 in var_0._id_65E8) {
    if(isDefined(var_8._id_65DE) && isDefined(var_8._id_65DE._id_299D))
      var_8._id_65DE._id_299D delete();
  }

  var_0._id_65E8[0] thread _id_0378::_id_8D74("aud_tower_machine_move_stop");

  foreach(var_11 in var_2) {
    if(isDefined(var_11._id_4D91))
      _id_0559::_id_2D8E(var_11._id_4D91);
  }
}

get_lowest_attack_spot_health(var_0) {
  var_1 = 999;

  foreach(var_3 in var_0) {
    if(var_3._id_28FF < var_1)
      var_1 = var_3._id_28FF;
  }

  return var_1;
}

_id_6A76(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B5("tower_battle_sfx_top", "targetname");
  var_2 thread _id_0378::_id_8D74("aud_tower_alarm_stop");

  foreach(var_4 in var_0._id_65E8) {
    var_4 _id_A180(5, 0, 0);
    var_4 _id_A180(5, 0, 2);
  }

  var_0._id_65E8[0] thread _id_0378::_id_8D74("aud_tower_machine_destroyed");

  foreach(var_7 in level.players) {
    if(distance(var_7.origin, var_1[0].origin) < 300)
      var_7 maps\mp\_utility::_id_2CED(4, _id_0367::_id_8E3C, "lightningrodbroke");
  }

  _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_LIGHTNING_RESET");
}

_id_6A7D(var_0, var_1, var_2) {
  if(!isDefined(level._id_9B19))
    level._id_9B19 = 0;

  if(var_2 && !level._id_9B19) {
    foreach(var_4 in level.players) {
      if(_id_0547::_id_577E(var_4)) {
        continue;
      }
      if(distance(var_4.origin, var_0.origin) < 300) {
        var_4 thread _id_0367::_id_8E3C("rodmachineassault");
        level._id_9B19 = 1;
      }
    }
  }

  var_0 thread _id_A0E2(var_0._id_28FF, var_1);
  var_0 thread _id_0378::_id_8D74("aud_tower_machine_dmg_state", var_0._id_28FF, var_1);
}

_id_46EE(var_0) {
  var_0 = var_0 - 1;
  var_1 = var_0 * 5;
  var_2 = [];
  var_3 = "mp/zombieSpecialEnemyWaves.csv";
  var_2["respawnExclusionRadius"] = _id_0547::_id_9470(_func_1AE(var_3, var_1, 4));
  var_2["objectiveTime"] = _id_0547::_id_9470(_func_1AE(var_3, var_1, 5));
  var_2["objectiveHealth"] = _id_0547::_id_9470(_func_1AE(var_3, var_1, 6));
  var_2["zombieObjectiveMax"] = _id_0547::_id_9470(_func_1AE(var_3, var_1, 7));
  var_2["objectiveHealthSolo"] = _id_0547::_id_9470(_func_1AE(var_3, var_1, 9));
  return var_2;
}

_id_A0E2(var_0, var_1) {
  if(var_0 <= var_1 && var_0 > var_1 * 0.75) {
    return;
  }
  if(var_0 <= var_1 * 0.75 && var_0 > var_1 * 0.5) {
    if(self._id_28FC != 1) {
      if(isDefined(self._id_299D))
        self._id_299D delete();

      var_2 = anglesToForward(self.angles);
      self._id_299D = _func_14B(level._effect["zmb_ee_fuse_dmg_lt"], self.origin, var_2);
      _func_14C(self._id_299D);
      self._id_28FC = 1;
    }
  } else if(var_0 <= var_1 * 0.5 && var_0 > var_1 * 0.25) {
    if(self._id_28FC != 2) {
      if(isDefined(self._id_299D))
        self._id_299D delete();

      var_2 = anglesToForward(self.angles);
      self._id_299D = _func_14B(level._effect["zmb_ee_fuse_dmg_med"], self.origin, var_2);
      _func_14C(self._id_299D);
      self._id_28FC = 2;
    }
  } else if(var_0 <= var_1 * 0.25 && var_0 > 0) {
    if(self._id_28FC != 3) {
      if(isDefined(self._id_299D))
        self._id_299D delete();

      var_2 = anglesToForward(self.angles);
      self._id_299D = _func_14B(level._effect["zmb_ee_fuse_dmg_hvy"], self.origin, var_2);
      _func_14C(self._id_299D);
      self._id_28FC = 3;
    }
  } else if(var_0 <= 0) {
    if(self._id_28FC != 4) {
      if(isDefined(self._id_299D))
        self._id_299D delete();

      var_2 = anglesToForward(self.angles);
      self._id_299D = _func_14B(common_scripts\utility::_id_44F5("ee_fuse_blowout"), self.origin, var_2);
      _func_14C(self._id_299D);
      self._id_28FC = 4;
    }
  } else {}
}

_id_8A37(var_0, var_1) {
  if(1) {
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++)
      var_2[var_3] = _func_18E(var_1[var_3], "targetname");

    var_4 = _id_0557::_id_782F(undefined, var_2);
    _id_0557::_id_781D(var_0, var_4);
  }
}

_id_8A36(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_94D4 = var_0;
  var_2._id_39D1 = var_1;
  return var_2;
}

_id_A69B(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(!isDefined(var_6._id_57A4))
      var_4 = 0;

    if(!isDefined(var_6._id_4D91))
      var_6._id_4D91 = _id_0559::_id_7BE3(var_6, "lightning_rod");

    var_6 _meth_80CE(&"ZOMBIE_NEST_LIFT_RODS");
    var_7 = common_scripts\utility::_id_4461(var_6.origin, var_2);
    var_6 thread _id_A6C0(var_4, var_7);
  }

  var_9 = 0;
  var_10 = undefined;

  while(var_9 < var_0.size) {
    level waittill("ee trigger was repaired", var_3, var_6);
    var_10 = var_3;

    if(common_scripts\utility::_id_0F79(var_0, var_6))
      var_9++;
  }

  foreach(var_6 in var_0)
  var_6._id_65E7 _id_A180(3);
}

_id_A6AE(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_08BC))
      return;
  }

  foreach(var_2 in var_0) {
    var_2 common_scripts\utility::_id_9DA3();
    var_2 _meth_80CE(&"ZOMBIE_NEST_MACHINE_COOLING");
    var_2 _meth_80CF(&"ZOMBIES_EMPTY_STRING");
  }

  while(var_0[0]._id_08BC == level._id_A980)
    wait 1;
}

_id_2EA5(var_0) {
  var_0 thread _id_0367::_id_8E3C("lightningrodmachine");
}

_id_46EF(var_0) {
  var_0 = var_0 - 1;
  var_1 = var_0 * 5;
  var_2 = "mp/zombieSpecialEnemyWaves.csv";
  var_3 = _id_0547::_id_9470(_func_1AE(var_2, var_1, 8));
  return var_3;
}

_id_8A05() {
  self._id_1170 = _func_18E(self.target, "targetname");
  self._id_1170._id_834D = getEntArray(self._id_1170.target, "targetname");
  self._id_1170._id_65F7 = self;
}

_id_4ADA(var_0) {
  foreach(var_2 in var_0)
  var_2 _id_A180(0);
}

_id_A6C0(var_0, var_1) {
  common_scripts\utility::_id_9DA3();
  self._id_57A4 = 0;
  self._id_65E7 _id_A180(0);
  var_2 = undefined;

  while(!self._id_57A4) {
    self waittill("trigger", var_2);
    self._id_65E7 thread _id_0378::_id_8D74("aud_tower_machine_use");

    if(isDefined(var_1._id_299D))
      var_1._id_299D delete();

    if(var_0 == 0 || var_2 maps\mp\gametypes\zombies::_id_11C2(var_0)) {
      self._id_28D5 = 0;
      self._id_57A4 = 1;
    }
  }

  self._id_65E7 _id_A180(1);
  common_scripts\utility::_id_9D9F();
  level notify("ee trigger was repaired", var_2, self);
}

_id_A181(var_0) {
  switch (var_0) {
    case 0:
      thread _id_64AA(0);
      _id_9EC7();
      break;
    case 1:
      thread _id_64AA(1);
      thread _id_9EC6();
      break;
    case 2:
      thread _id_64AC(0);
      break;
    case 3:
      thread _id_64AC(1);
      thread _id_0378::_id_8D74("aud_tower_machine_move_strt");
      break;
    case 4:
      thread _id_64AC(2);
      break;
    case 5:
      break;
  }
}

#using_animtree("animated_props_zombies");

_id_64AA(var_0) {
  self notify("lever state change");
  self endon("lever state change");
  self _meth_8277();

  switch (var_0) {
    case 0:
      self _meth_8276("zmb_tower_elec_lever_reverse");
      wait(_func_065(%zmb_tower_elec_lever_reverse));
      self _meth_8276("zmb_tower_elec_lever_idle");
      break;
    case 1:
      self _meth_8276("zmb_tower_elec_lever_pull");
      wait(_func_065(%zmb_tower_elec_lever_pull));
      self _meth_8276("zmb_tower_elec_lever_pull_idle");
      break;
  }
}

_id_64AC(var_0) {
  self notify("lightning rod state change");
  self._id_65E6 notify("lightning rod state change");
  self endon("lightning rod state change");
  var_1 = self._id_65E6;

  if(!isDefined(var_1._id_7EC4)) {
    var_1._id_7EC4 = undefined;
    var_1._id_7EC2 = undefined;
    var_1._id_7EC7 = undefined;
    var_1._id_7EC6 = 0;
    var_1._id_7EC3 = 0;
    var_1._id_7EBE = 0;
    var_1._id_7EC0 = "zmb_tower_rod_idle_bottom";

    if(self.targetname == "inner_spire_lever") {
      var_1._id_7EC4 = "zmb_tower_rod_mid_up";
      var_1._id_7EC2 = "zmb_tower_rod_mid_down";
      var_1._id_7EC7 = "zmb_tower_rod_mid_idle_top";
      var_1._id_7EC6 = _func_065(%zmb_tower_rod_mid_up);
      var_1._id_7EC3 = _func_065(%zmb_tower_rod_mid_down);
    } else {
      var_1._id_7EC4 = "zmb_tower_rod_up";
      var_1._id_7EC2 = "zmb_tower_rod_down";
      var_1._id_7EC7 = "zmb_tower_rod_idle_top";
      var_1._id_7EC6 = _func_065(%zmb_tower_rod_up);
      var_1._id_7EC3 = _func_065(%zmb_tower_rod_down);
    }
  }

  var_1 _meth_8277();

  switch (var_0) {
    case 0:
      if(isDefined(var_1._id_7EC5))
        var_1._id_7EBF = var_1._id_7EC5 * var_1._id_7EC3;
      else
        var_1._id_7EBF = var_1._id_7EC3;

      var_1._id_7EBE = var_1._id_7EC3 - var_1._id_7EBF;
      var_1 _meth_8276(var_1._id_7EC2, "", var_1._id_7EBE, 1, 1);
      wait(var_1._id_7EC3 - var_1._id_7EBE - 0.333333);
      var_1 thread _id_0378::_id_8D74("aud_tower_machine_crash");
      wait 0.333333;
      var_1 _meth_8276(var_1._id_7EC0);
      var_1 notify("lightning rod state change complete");
      _id_9EC7();
      break;
    case 1:
      var_1 _meth_8276(var_1._id_7EC4);
      var_1._id_7EBE = 0;
      var_1 thread _id_7EC8();
      wait(var_1._id_7EC6);
      var_1 _meth_8276(var_1._id_7EC7);
      var_1 notify("lightning rod state change complete");
      _id_9EC8();
      break;
    case 2:
      var_1 _meth_8276(var_1._id_7EC0);
      var_1 notify("lightning rod state change complete");
      break;
  }
}

_id_7EC8() {
  self endon("lightning rod state change complete");
  self endon("lightning rod state change");
  var_0 = gettime();

  for(;;) {
    var_1 = (gettime() - var_0) / 1000.0;
    self._id_7EC5 = (self._id_7EBE + var_1) / self._id_7EC6;
    wait 0.1;
  }
}

_id_9EC7() {
  self _meth_8050("TAG_LIGHT_ON", self.model);
  self _meth_8053("TAG_LIGHT_OFF", self.model);
}

_id_9EC6() {
  self._id_65E6 endon("lightning rod state change complete");

  for(;;) {
    self _meth_8050("TAG_LIGHT_ON", self.model);
    self _meth_8053("TAG_LIGHT_OFF", self.model);
    wait 0.75;
    self _meth_8050("TAG_LIGHT_OFF", self.model);
    self _meth_8053("TAG_LIGHT_ON", self.model);
    wait 0.75;
  }
}

_id_9EC8() {
  self _meth_8050("TAG_LIGHT_OFF", self.model);
  self _meth_8053("TAG_LIGHT_ON", self.model);
}

_id_8A4B() {
  var_0 = _func_18E("nest_ee_fuse_piece_lift", "targetname");
  level notify("flag_fuse_entered_correct");
  var_0 _id_8A05();
  return var_0;
}

_id_2E7C() {
  wait 3;
  var_0 = _func_18E("inner_spire", "targetname");

  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      if(_func_0E1(var_2.origin, var_0.origin) < 750)
        var_2 thread _id_0367::_id_8E3C("lightningrodpart2");
    }
  }
}

_id_A180(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    thread _id_A181(var_0);
  else if(var_1)
    thread _id_A181(var_0);
  else
    thread _id_A181(var_2);
}

_id_52FA(var_0) {
  var_1 = [];
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = _func_18E(var_0[var_3], "targetname");
    var_4._id_65E6 = _func_18E(var_4.target, "targetname");
    _id_5DA3(var_4._id_65E6.target, var_4);
    var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
  }

  self._id_65E8 = var_1;
  _id_4ADA(var_1);
}

_id_5DA3(var_0, var_1) {
  var_2 = _func_18E(var_0, "targetname");
  var_2._id_65DA = var_1;
}

_id_52ED() {
  var_0 = _func_18E("nest_ee_fuse_piece_lift", "targetname");
  var_0 common_scripts\utility::_id_9D9F();
  var_0 _meth_80CE(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  var_0 thread _id_2EB2();
  var_0._id_65E7 = _func_18E("inner_spire_lever", "targetname");
  var_0._id_65E7._id_65E6 = _func_18E(var_0._id_65E7.target, "targetname");
  var_0._id_65E7 _id_A180(0);
  var_0._id_65E7 _id_A180(4);
  var_1 = getEntArray("nest_ee_fuse_outter_objectives", "targetname");

  foreach(var_3 in var_1) {
    var_3 _meth_80CE(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
    var_3 thread _id_2EB2();
    var_3._id_65E7 = _func_18E(var_3.target, "targetname");
    var_3._id_65E7._id_65E6 = _func_18E(var_3._id_65E7.target, "targetname");
    var_3._id_65E7 _id_A180(0);
    var_3._id_65E7 _id_A180(4);
  }
}

_id_2EB2() {
  level endon("flag_fuse_entered_correct");
  level endon("nest_ee_fuses_complete");

  for(;;) {
    self waittill("trigger", var_0);

    if(_id_0557::_id_783E("5 Right Hand fuses", "fuse matching start")) {
      break;
    }

    if(common_scripts\utility::_id_562E(var_0._id_3072))
      continue;
    else {
      var_1 = var_0 _id_0367::_id_8E3D("lightningrodmachine");

      if(isDefined(var_1))
        var_0._id_3072 = 1;
    }
  }
}

_id_46ED(var_0, var_1, var_2) {
  var_3 = [];
  var_3["main_trigger"] = _id_8A4B();
  var_3["activation_triggers"] = getEntArray(var_1, "targetname");
  var_3["lightning_rods"] = getEntArray(var_0, "targetname");
  var_3["attack_positions"] = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_3["attack_positions"][var_4] = _func_18E(var_2[var_4], "targetname");
    var_3["attack_positions"][var_4]._id_AC6A = common_scripts\utility::_id_46B7(var_3["attack_positions"][var_4].target, "targetname");
  }

  return var_3;
}

_id_86D9(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["notifications"] = spawnStruct();
  var_4["notifications"]._id_94D4 = var_0;
  var_4["notifications"]._id_39D1 = var_1;
  var_4["battleID"] = var_2;
  var_4["machine_targetnames"] = var_3;
  return var_4;
}
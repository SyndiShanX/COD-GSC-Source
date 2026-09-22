/**************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades.gsc
**************************************************************************/

main() {
  common_scripts\utility::flag_init("flag_nest_hc_ee_death_assembled");
  common_scripts\utility::flag_init("flag_nest_hc_ee_moon_assembled");
  common_scripts\utility::flag_init("flag_nest_hc_ee_blood_assembled");
  common_scripts\utility::flag_init("flag_nest_hc_ee_storm_assembled");
  _id_0557::_id_4BC9("tesla gun upgraded", "upgrading tesla gun", "CONST_HC_ANALYTICS_TESLA_GUNS_UPGRADED");
  var_4 = [];
  var_4 = maps\mp\mp_zombie_nest_ee_workbench::_id_536D();
  var_4["death weapon trig"] thread _id_7B96("death_raven_hc_ee", ::_id_7A87, "trap_catacombs", "zombie_exploder", "teslagun_zm_death", "uber_reciever_gate_1", "flag_nest_hc_ee_death_assembled", "r.death uber get", "r.death uber fill", "r.death tesla built");
  var_4["moon weapon trig"] thread _id_7B96("moon_raven_hc_ee", ::_id_7A8B, "trap_roof", "zombie_generic", "teslagun_zm_moon", "uber_reciever_gate_3", "flag_nest_hc_ee_moon_assembled", "r.moon uber get", "r.moon uber fill", "r.moon tesla built");
  var_4["blood weapon trig"] thread _id_7B96("blood_raven_hc_ee", ::_id_7A89, "trap_med", "zombie_berserker", "teslagun_zm_blood", "uber_reciever_gate_2", "flag_nest_hc_ee_blood_assembled", "r.blood uber get", "r.blood uber fill", "r.blood tesla built");
  var_4["storm weapon trig"] thread _id_7B96("storm_raven_hc_ee", ::_id_7A8A, "trap_rnd", "zombie_heavy", "teslagun_zm_storm", "uber_reciever_gate_4", "flag_nest_hc_ee_storm_assembled", "r.storm uber get", "r.storm uber fill", "r.storm tesla built");
  thread _id_7A8E();
  thread completedeathreward();
  thread completestormreward();
  thread completebloodreward();
  thread completemoonreward();
}

_id_7B96(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_0557::_id_4BC9(var_7);
  _id_0557::_id_4BC9(var_8);
  _id_0557::_id_4BC9(var_9);
  maps\mp\mp_zombie_nest_ee_workbench::_id_AA75();
  var_10 = undefined;
  var_11 = undefined;
  var_12 = common_scripts\utility::_id_46B5(var_0, "targetname");
  var_12._id_9C92 = common_scripts\utility::_id_46B5(var_2, "script_noteworthy");
  var_12._id_9CD6 = common_scripts\utility::_id_44BE(var_2 + "_uber_collector", "targetname");
  var_13 = common_scripts\utility::_id_44BE(var_12.target, "targetname");
  var_14 = _getscriptablearray(var_2 + "_uber_collector", "targetname");
  var_15 = var_14[0];
  var_16 = [];
  var_16["raven_uber_trap_deposit_alter"] = var_15;
  var_16["raven_uber_trap_deposit_alter"] maps\mp\mp_zombie_nest_hilt_altar_reciever::_id_84DB();
  var_17 = common_scripts\utility::_id_46B5(var_12.target + "_trap_reciever", "targetname");
  var_13 = common_scripts\utility::_id_0F6F(var_13, var_17);
  var_13 = common_scripts\utility::_id_0F73(var_13, var_12._id_9CD6);

  foreach(var_19 in var_13) {
    if(!isDefined(var_19._id_0165)) {
      continue;
    }
    switch (var_19._id_0165) {
      case "cover_model":
        var_16[var_19._id_0165] = var_19;
        break;
      case "tesla_fuse_box":
        var_16[var_19._id_0165] = var_19;
        break;
      case "fuse_pickup":
        var_16[var_19._id_0165] = var_19;
        var_16[var_19._id_0165] hide();
        break;
      case "fuse_pickup_offset":
        var_16[var_19._id_0165] = var_19;
        break;
      case "raven_uber_trap_deposit":
        var_16[var_19._id_0165] = var_19;
        var_16[var_19._id_0165]._id_3E3C = common_scripts\utility::_id_46B5(var_16[var_19._id_0165].targetname + "_forge", "targetname");
        var_16[var_19._id_0165]._id_65D5 = var_0;
        break;
      case "raven_uber_trap_deposit_trig":
        var_16[var_19._id_0165] = var_19;
        break;
      case "raven_trap_pickup_trig_offset":
        var_16[var_19._id_0165] = var_19;
        break;
      case "hint_light":
        var_16[var_19._id_0165] = var_19;
        break;
      case "success_light_1":
        var_16[var_19._id_0165] = var_19;
        break;
      case "success_light_2":
        var_16[var_19._id_0165] = var_19;
        break;
      case "success_light_3":
        var_16[var_19._id_0165] = var_19;
        break;
      case "zombie_spawner":
        var_16[var_19._id_0165] = var_19;
        break;
      default:
        break;
    }
  }

  var_21 = [];
  var_21[0] = var_16["success_light_1"];
  var_21[1] = var_16["success_light_2"];
  var_21[2] = var_16["success_light_3"];
  var_16["hint_light"] thread _id_9870(var_2, var_3, var_12._id_9CD6);
  var_22 = _getEnt(var_16["raven_uber_trap_deposit"]._id_3E3C.target, "targetname");
  var_23 = _getEnt(var_16["raven_uber_trap_deposit"]._id_3E3C.target, "targetname");
  var_24 = _getEnt(var_5, "targetname");
  var_25 = _getEnt(var_23.target, "targetname");
  var_25 hide();

  if(!isDefined(level._id_7A86)) {
    level._id_7A86 = [];
  }

  level._id_7A86 = common_scripts\utility::_id_0F6F(level._id_7A86, var_23);
  var_12._id_9C92._id_579D = 0;
  var_12._id_9C92 thread _id_A6C1(var_3, var_2, var_16["raven_uber_trap_deposit"], var_16["raven_uber_trap_deposit_alter"], var_21, var_0);

  if(!isDefined(level._id_7A85)) {
    level._id_7A85 = [];
  }

  level._id_7A85 = common_scripts\utility::_id_0F6F(level._id_7A85, var_24);
  var_24 thread _id_3622(var_23, "5 Right Hand fuses", "lift outter rods");

  if(0) {
    common_scripts\utility::_id_3C9F(_id_0557::_id_7838("4 cart", "head to com"));
  }

  var_26 = var_12[[var_1]](var_16);
  var_27 = var_26[0];
  var_28 = var_26[1];
  var_16["raven_uber_trap_deposit_alter"] thread maps\mp\mp_zombie_nest_hilt_altar_reciever::_id_84DC();
  _id_8F6E(var_27, var_28, _id_4703(var_0), _id_4702(var_0), var_0);
  var_12._id_9C92._id_9FE5 = _id_9FE9(var_12, var_16["raven_uber_trap_deposit"], var_16["raven_uber_trap_deposit_trig"], _id_4702(var_0), var_0);
  _id_0557::_id_4BC8(var_7);
  var_12._id_9C92._id_579D = 1;
  var_12._id_9C92 waittill("raven_trap_complete");
  _id_0557::_id_4BC8(var_8);
  var_12._id_9C92._id_9FE5 hide();
  var_29 = _id_0585::_id_8F7E(var_12._id_9C92._id_9FE5.origin, _id_4703(var_0), _id_4702(var_0), var_16["raven_trap_pickup_trig_offset"].origin, var_0);
  var_16["raven_uber_trap_deposit_trig"] common_scripts\utility::_id_9D9F();
  var_23 setHintString(&"ZOMBIE_NEST_PLACE_UBER");
  var_23 _meth_8660(1, var_16["raven_uber_trap_deposit"]._id_3E3C.origin);
  var_12._id_9C92._id_9FE5._id_65E3 delete();
  var_12._id_9C92._id_9FE5.origin = var_16["raven_uber_trap_deposit"]._id_3E3C.origin;
  var_11 = undefined;

  while(!isDefined(var_11) || !var_11 _id_0585::_id_9E12(var_0)) {
    var_23 waittill("trigger", var_11);
  }

  var_12._id_9C92._id_9FE5 show();
  var_23 setHintString(&"ZOMBIE_NEST_UBER_TRANSFER");
  var_16["main_trigger"] = var_23;
  var_30["battleID"] = 3;
  var_30["event_origin"] = var_16["main_trigger"].origin;
  var_30["notifications"] = spawnStruct();
  var_30["notifications"]._id_94D4 = "hc_raven_" + var_0 + "_success";
  var_30["notifications"]._id_39D1 = "hc_raven_" + var_0 + "_fail";
  var_16["activation_triggers"] = [var_23];
  var_16["attack_positions"] = _getEnt(var_25.target, "targetname");
  var_31 = spawnStruct();
  var_31._id_7B8C = var_16["main_trigger"];
  var_31._id_38C3 = "zombie_" + var_0 + "_rumble";
  var_31._id_38C4 = [];
  var_31._id_38C4["respawnExclusionRadius"] = 5000;
  var_31._id_38C4["objectiveTime"] = 70;
  var_31._id_38C4["objectiveHealth"] = 100;
  var_31._id_38C4["zombieObjectiveMax"] = 3;
  var_31._id_38C4["objectiveHealthSolo"] = 125;
  var_16["main_trigger"]._id_1170 = var_16["attack_positions"];
  var_32 = _getEnt("rnd_forge_machine_parts", "targetname");
  var_16["main_trigger"]._id_65E8 = [var_32];

  if(var_0 == "moon_raven_hc_ee" || var_0 == "storm_raven_hc_ee") {
    var_33 = "rnd_attack_on_deck_positions_struct";
  } else {
    var_33 = "med_attack_on_deck_positions_struct";
  }

  if(!isDefined(level.raven_forge_active)) {
    level.raven_forge_active = 0;
  }

  maps\mp\mp_zombie_nest_special_event_creator::_id_3135(::_id_A6A4, var_16["main_trigger"], [var_16["attack_positions"]], var_30["battleID"], var_30["notifications"], var_16["activation_triggers"], var_16["main_trigger"]._id_0165, var_30["event_origin"], ::_id_6A77, ::_id_6A76, ::_id_6A78, var_31, ::_id_6A7D, var_33);
  var_23 delete();

  if(!isDefined(level._id_3E3B) || !isDefined(level._id_5981)) {
    maps\mp\mp_zombie_nest_ee_util::_id_8A53();
  }

  var_34 = level._id_3E3B;

  if(var_0 == "death_raven_hc_ee" || var_0 == "blood_raven_hc_ee") {
    var_34 = level._id_5981;
    thread maps\mp\mp_zombie_nest_ee_util::_id_08B0();
    level waittill("med_create_ww_part");
  } else if(var_0 == "moon_raven_hc_ee" || var_0 == "storm_raven_hc_ee") {
    var_34 = level._id_3E3B;
    thread maps\mp\mp_zombie_nest_ee_util::_id_08B6();
    level waittill("rnd_show_ww_part");
    var_34._id_6FC2 show();
    level waittill("rnd_create_ww_part");
  }

  var_11 = var_34 maps\mp\mp_zombie_nest_ee_util::_id_8BEC();

  if(!isDefined(level._id_AACA[var_4])) {
    level._id_AACA[var_4] = maps\mp\mp_zombie_nest_ee_workbench::_id_AA7D(var_4, self);
  }

  var_35 = [0, undefined];

  while(!var_35[0]) {
    var_35 = maps\mp\mp_zombie_nest_ee_util::_id_745D(level._id_AACA[var_4]._id_48F2.origin, 250, 128);
    wait 1;
  }

  maps\mp\mp_zombie_nest_ee_workbench::_id_AA7A(level._id_AACA[var_4]);
  common_scripts\utility::_id_9DA3();
  self setHintString(maps\mp\mp_zombie_nest_ee_workbench::_id_AA71(var_4));
  var_36 = "";
  var_11 = undefined;

  while(!issubstr(var_36, "teslagun_zm")) {
    self waittill("trigger", var_11);
    var_36 = var_11 getcurrentweapon();

    if(!issubstr(var_36, "teslagun_zm")) {
      var_11 iprintlnbold(&"ZOMBIE_NEST_ASSEMBLE_WW_REQUIRES");
    }
  }

  var_11 _id_0586::_id_0790(var_11 getcurrentweapon());
  var_37 = var_11 getweaponlistprimaries();

  if(var_37.size > 0) {
    var_11 switchtoweapon(var_37[0]);
  }

  self setHintString(&"ZOMBIE_NEST_ASSEMBLING_WW");
  level._id_AACA[var_4] maps\mp\mp_zombie_nest_ee_workbench::_id_AA73();
  self setHintString(maps\mp\mp_zombie_nest_ee_workbench::_id_AA72(var_4));
  level._id_AACA[var_4] thread maps\mp\mp_zombie_nest_ee_workbench::_id_AA76();
  _id_0557::_id_4BC8(var_9);
  _id_0557::_id_4BC8("tesla gun upgraded");

  if(isDefined(var_6) && common_scripts\utility::_id_3C83(var_6)) {
    common_scripts\utility::flag_set(var_6);
  }
}

_id_7A8E() {
  common_scripts\utility::_id_3CA0("flag_nest_hc_ee_storm_assembled", "flag_nest_hc_ee_moon_assembled", "flag_nest_hc_ee_death_assembled", "flag_nest_hc_ee_blood_assembled");
  maps\mp\gametypes\zombies::_id_47A8("ZM_TESLA_CHALLENGE");
}

_id_3622(var_0, var_1, var_2) {
  var_0 common_scripts\utility::_id_9D9F();
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_idle");
  _id_A64D(var_1, var_2);
  _id_6C01();
  var_0 common_scripts\utility::_id_9DA3();
}

_id_8F6E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.origin;
  var_0 hide();
  var_6 = _id_0585::_id_8F7E(var_5, var_2, var_3, undefined, var_4);
  var_7 = var_1.origin - var_0.origin;
  var_8 = _sqrt(_abs(var_7[2] * 2 / 800));
  var_9 = 1 / var_8;
  var_10 = var_7 * (var_9, var_9, 0);
  var_6 movegravity(var_10, var_8);
  var_6 rotateTo(var_1.angles, var_8);
  wait(var_8);
  var_6.origin = var_1.origin;
}

_id_6A77(var_0, var_1, var_2) {
  foreach(var_4 in level._id_7A86) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 common_scripts\utility::_id_9D9F();
  }

  foreach(var_7 in level._id_7A85) {
    var_7 thread _id_2441();
  }
}

_id_6A76(var_0, var_1) {
  var_2 = level._id_A980;

  while(level._id_A980 <= var_2) {
    wait 5;
  }

  foreach(var_4 in level._id_7A86) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 common_scripts\utility::_id_9DA3();
  }

  level.raven_forge_active = 0;

  foreach(var_7 in level._id_7A85) {
    var_7 thread _id_6C01();
  }
}

_id_6A78(var_0, var_1, var_2) {
  var_3 = level._id_A980;

  while(level._id_A980 <= var_3) {
    wait 5;
  }

  level.raven_forge_active = 0;

  foreach(var_5 in level._id_7A86) {
    var_5 common_scripts\utility::_id_9DA3();
  }

  foreach(var_8 in level._id_7A85) {
    var_8 thread _id_6C01();
  }
}

_id_6A7D(var_0, var_1, var_2) {}

_id_A6A4(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(!isDefined(var_6._id_57A4)) {
      var_4 = 0;
    }

    var_6._id_57A4 = 0;
    var_6 thread _id_A6C0(var_4);
  }

  var_8 = 0;
  var_9 = undefined;

  while(var_8 < var_0.size) {
    level waittill("ee trigger was repaired", var_3, var_6);
    var_9 = var_3;

    if(common_scripts\utility::_id_0F79(var_0, var_6)) {
      var_8++;
    }
  }
}

_id_A6C0(var_0) {
  common_scripts\utility::_id_9DA3();
  var_1 = undefined;

  while(!self._id_57A4) {
    self waittill("trigger", var_1);

    if(common_scripts\utility::_id_562E(level.raven_forge_active)) {
      continue;
    } else {
      level.raven_forge_active = 1;
    }

    if(var_0 == 0 || var_1 maps\mp\gametypes\zombies::_id_11C2(var_0)) {
      self._id_28D5 = 0;
      self._id_57A4 = 1;
    }
  }

  common_scripts\utility::_id_9D9F();
  level notify("ee trigger was repaired", var_1, self);
}

_id_42ED(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "blood":
      var_1 = "flag_nest_hc_ee_blood_assembled";
      break;
    case "death":
      var_1 = "flag_nest_hc_ee_death_assembled";
      break;
    case "storm":
      var_1 = "flag_nest_hc_ee_storm_assembled";
      break;
    case "moon":
      var_1 = "flag_nest_hc_ee_moon_assembled";
      break;
    default:
      break;
  }

  return var_1;
}

_id_9870(var_0, var_1, var_2) {
  var_3 = _id_45CA(var_1);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = spawn("script_model", self.origin);
  var_6 setModel("tag_origin");
  var_7 = spawnStruct();
  var_7._id_5764 = 0;
  var_8 = self.origin;

  for(;;) {
    var_9 = _id_440B();
    var_10 = 0;

    for(var_11 = 0; var_11 < var_9.size; var_11++) {
      if(distance(self.origin, var_9[var_11].origin) < 256 && isDefined(var_9[var_11]._id_0A4B) && var_9[var_11]._id_0A4B == var_1) {
        var_10 = common_scripts\utility::_id_98E7(var_10 < var_4, var_10 + 1, var_4);
      }
    }

    if(var_10 == var_4 && !common_scripts\utility::_id_562E(var_7._id_5764)) {
      var_7._id_5764 = 1;
      maps\mp\mp_zombie_nest_hilt_altar_reciever::_id_84D6();
    } else if(common_scripts\utility::_id_562E(var_7._id_5764)) {
      var_7._id_5764 = 0;
      maps\mp\mp_zombie_nest_hilt_altar_reciever::_id_84D5();
    }

    wait 0.5;
  }
}

_id_440B() {
  var_0 = maps\mp\agents\_agent_utility::_id_43FD("all");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3._id_000A == level._id_746E) {
      continue;
    }
    if(isalive(var_3)) {
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
    }
  }

  return var_1;
}

_id_4703(var_0) {
  var_1 = &"ZOMBIE_NEST_PICKUP_UBER_DEATH";

  switch (var_0) {
    case "moon_raven_hc_ee":
      var_1 = &"ZOMBIE_NEST_PICKUP_UBER_MOON";
      break;
    case "death_raven_hc_ee":
      var_1 = &"ZOMBIE_NEST_PICKUP_UBER_DEATH";
      break;
    case "blood_raven_hc_ee":
      var_1 = &"ZOMBIE_NEST_PICKUP_UBER_BLOOD";
      break;
    case "storm_raven_hc_ee":
      var_1 = &"ZOMBIE_NEST_PICKUP_UBER_STORM";
      break;
  }

  return var_1;
}

_id_4702(var_0) {
  var_1 = "zmb_gp_uber_01";

  switch (var_0) {
    case "moon_raven_hc_ee":
      var_1 = "zmb_gp_uber_01_moon";
      break;
    case "death_raven_hc_ee":
      var_1 = "zmb_gp_uber_01_death";
      break;
    case "blood_raven_hc_ee":
      var_1 = "zmb_gp_uber_01_blood";
      break;
    case "storm_raven_hc_ee":
      var_1 = "zmb_gp_uber_01_storm";
      break;
  }

  return var_1;
}

_id_A6B0(var_0) {
  for(var_1 = undefined; !isDefined(var_1) || var_1 != var_0; var_1 = var_2) {
    self waittill("player_used", var_2);
  }
}

_id_902C(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2.targetname = var_1 + "_uber_receiver";

  if(isDefined(var_0.angles)) {
    var_2.angles = var_0.angles;
  }

  var_2 setModel("zmb_gp_uber_01");
  _playFXOnTag(level._effect[var_1 + "_uber"], var_2, "tag_origin");
  return var_2;
}

_id_44EB(var_0) {
  var_1 = "";

  switch (var_0) {
    case "forge_rnd":
      var_1 = "ww_part_01_pickup";
      break;
    case "forge_med":
      var_1 = "ww_part_02_pickup";
      break;
    default:
      break;
  }

  var_2 = _getEnt(var_1, "targetname");
  return var_2._id_7AC4;
}

_id_9FE9(var_0, var_1, var_2, var_3, var_4) {
  var_2 setHintString(&"ZOMBIE_NEST_PLACE_UBER");
  var_5 = undefined;

  while(!isDefined(var_5) || !var_5 _id_0585::_id_9E12(var_4)) {
    var_2 waittill("trigger", var_5);
  }

  var_6 = spawn("script_model", var_1.origin);
  var_6 setModel(var_3);
  var_6._id_65E4 = var_1;
  var_2 common_scripts\utility::_id_9D9F();
  return var_6;
}

_id_A64D(var_0, var_1) {
  level endon("open all forge uber doors");
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838(var_0, var_1));
}

#using_animtree("animated_props_zombies");

_id_6C01() {
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_up");
  _id_0378::_id_8D74("aud_compartment_door_open");
  wait(_getanimlength(%zmb_forge_electric_coil_shutter_up));
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_up_idle", "shutter_up");
}

_id_2441() {
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_down");
  _id_0378::_id_8D74("aud_compartment_door_close");
  wait(_getanimlength(%zmb_forge_electric_coil_shutter_down));
  self scriptmodelplayanim("zmb_forge_electric_coil_shutter_idle", "shutter_down");
}

_id_7A8A(var_0) {
  if(!0) {
    if(0) {
      while(!isDefined(level.players) || distance(level.players[0].origin, var_0["tesla_fuse_box"].origin) > 256) {
        wait 0.1;
      }

      var_0["zombie_spawner"] thread _id_902D();
    }

    var_0["cover_model"] setCanDamage(1);
    var_1 = 0;

    while(!var_1) {
      level waittill("objective_zombie_exploder_detonation", var_2, var_3);
      var_4 = _getEnt(var_0["fuse_pickup"].target, "targetname");

      if(distance(var_4.origin, var_2) <= 150) {
        var_1 = 1;
      }
    }
  }

  var_0["cover_model"] thread _id_1806();
  var_5 = _getEnt(var_0["fuse_pickup"].target, "targetname");
  var_6 = var_0["fuse_pickup"];
  return [var_5, var_6];
}

_id_7A87(var_0) {
  if(0) {
    while(!isDefined(level.players) || distance(level.players[0].origin, var_0["cover_model"].origin) > 256) {
      wait 0.1;
    }

    var_0["zombie_spawner"] thread _id_9064();
  }

  var_0["fuse_pickup"] hide();
  _id_A6A2(var_0["cover_model"]);
  var_0["cover_model"] thread _id_1806();
  var_1 = _getEnt(var_0["fuse_pickup"].target, "targetname");
  var_2 = var_0["fuse_pickup"];
  return [var_1, var_2];
}

_id_1806() {
  _id_0378::_id_8D74("blow_open_uber_concealment_door");
  level thread common_scripts\_exploder::_id_088E(239);
  self setModel("zmb_objective_panel_door_dmg_01");
  self.origin = self.origin + (0, 0, 64);
  self movegravity(-200 * vectorNormalize(common_scripts\utility::_id_3D5C(anglesToForward(self.angles))) + (0, 0, 50), 1);
  self rotateby((360, 360, 360), 1);
}

_id_7A8B(var_0) {
  var_0["fuse_pickup"] hide();
  _id_A6C3(var_0);
  var_0["cover_model"] scriptmodelplayanim("zmb_breakable_statue_bursting", "statue_burst");
  playFX(level._effect["zmb_hc_statue"], var_0["cover_model"].origin);
  var_0["cover_model"] _id_0378::_id_8D74("aud_break_statue");
  var_0["fuse_pickup"] show();
  var_0["fuse_pickup"] maps\mp\mp_zombie_nest_ee_util::_id_A725("teslagun_zm");
  var_1 = common_scripts\utility::_id_46B5(var_0["fuse_pickup"].target, "targetname");
  var_2 = var_0["fuse_pickup"];
  var_3 = var_1;
  var_2 hide();
  return [var_2, var_3];
}

_id_7A88(var_0) {
  level endon("raven up skip");
  _id_A6A3(var_0["cover_model"]);
  var_0["cover_model"] hide();

  if(!1) {
    maps\mp\mp_zombie_nest_ee_util::_id_A6CE(var_0["tesla_fuse_box"]);
  }

  var_1 = var_0["fuse_pickup"] _id_A6B9(&"ZOMBIE_NEST_PICKUP_UBER", (0, 0, 32));
  return var_1;
}

_id_7A89(var_0) {
  level endon("raven up skip");
  var_1 = 0;
  var_2 = _getEnt("raven_blood_challenge_lights_start", "targetname");
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  var_2 setCanDamage(1);
  var_2 maps\mp\mp_zombie_nest_ee_util::_id_A725("teslagun_zm");
  _playFXOnTag(common_scripts\utility::_id_44F5("temp_hc_challenge_indicator_lights"), var_3, "tag_origin");
  var_3 linktosynchronizedparent(var_2);
  var_4 = maps\mp\mp_zombie_nest_ee_util::_id_44C8(var_2.target, 1);
  var_2._id_775E = 0;
  _id_0378::_id_8D74("tesla_hc_energy_lamp_loop_on", var_2.origin);
  waitframe();

  while(var_2._id_775E < var_4.size) {
    var_2.origin = var_4[var_2._id_775E].origin;
    var_2 thread _id_39EA(6);
    var_2 waittill("trigger");

    if(var_2._id_775E >= 0) {
      _id_0378::_id_8D74("tesla_hc_energy_lamp_destruct", var_2.origin);
    }

    var_2._id_775E++;
    wait 0.15;
  }

  _id_0378::_id_8D74("tesla_hc_energy_lamp_loop_off", var_2.origin);
  _stopFXOnTag(common_scripts\utility::_id_44F5("temp_hc_challenge_indicator_lights"), var_3, "tag_origin");
  var_6 = _getEnt(var_0["fuse_pickup"].target, "targetname");
  var_2.origin = var_6.origin;
  var_7 = _getEnt(var_0["fuse_pickup"].target, "targetname");
  var_8 = var_0["fuse_pickup"];
  return [var_7, var_8];
}

_id_39EA(var_0) {
  self endon("trigger");
  wait(var_0);
  self._id_775E = -1;
  self notify("trigger");
}

_id_A6A3(var_0) {
  level endon("raven up skip");
  var_0 setCanDamage(1);

  for(var_1 = ""; var_1 != "MOD_GRENADE_SPLASH" && var_1 != "MOD_IMPACT" && var_1 != "MOD_EXPLOSIVE"; var_1 = var_6) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6);
  }
}

_id_45CA(var_0) {
  var_1 = 5;
  var_2 = 3;

  switch (var_0) {
    case "zombie_berserker":
      var_1 = 5;
      var_2 = 3;
      break;
    case "zombie_heavy":
      var_1 = 2;
      var_2 = 2;
      break;
    case "zombie_exploder":
      var_1 = 2;
      var_2 = 2;
      break;
    case "zombie_fireman":
      var_1 = 1;
      var_2 = 1;
      break;
    default:
      break;
  }

  return [var_1, var_2];
}

_id_6FEE(var_0) {
  if(!common_scripts\utility::_id_562E(var_0._id_2EE3)) {
    var_0._id_2EE3 = 1;
    self notify("zombie trap killed", var_0._id_0A4B, var_0.origin);
    waitframe();
  }
}

_id_A6C1(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("raven hc skip trap collection for " + var_1);
  var_6 = 3;
  var_7 = 0;
  var_8 = _id_45CA(var_0);
  var_9 = var_8[0];
  var_10 = var_8[1];
  var_11 = 0;
  var_12 = 0;
  self._id_9CB0 = 0;
  var_13 = undefined;
  var_3 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::vehphys_getvelocity(1);
  var_3 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::vehphys_getvelocity(2);
  var_3 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::vehphys_getvelocity(3);

  while(var_12 < var_10) {
    self._id_9CB0 = 0;
    var_13 = _id_A667();

    if(!isDefined(var_13)) {
      var_13 = "not zombie";
    }

    if(var_13 == var_0 || var_0 == "zombie_any") {
      var_11 = _id_9E1E(var_13, var_9, var_6);
    }

    if(common_scripts\utility::_id_562E(var_11)) {
      if(!self._id_579D) {
        playFX(level._effect["zmb_receiver_charge_lost"], var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
        continue;
      }

      playFX(level._effect["zmb_receiver_charge_pnt"], var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
      _id_0378::_id_8D74("aud_battery_electrocute");
      var_11 = undefined;
      var_12++;

      if(isDefined(self._id_9FE5._id_65E3)) {
        self._id_9FE5._id_65E3 delete();
      }

      self._id_9FE5._id_65E3 = _id_0547::_id_8FBA(self._id_9FE5._id_65E4, var_5 + "_uber_stg_" + var_12);
      _triggerfx(self._id_9FE5._id_65E3);
      var_4 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::_id_84DD(var_12);
    }
  }

  self notify("raven_trap_complete");
  playFX(level._effect["zmb_receiver_full"], var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
}

_id_A667() {
  self waittill("zombie trap killed", var_0, var_1);
  return var_0;
}

_id_9E1E(var_0, var_1, var_2) {
  self endon("uber timeout");
  thread _id_9FE8(var_2);
  self._id_9CB0 = 1;

  while(self._id_9CB0 < var_1) {
    var_3 = _id_A667();

    if(!isDefined(var_3)) {
      var_3 = "not zombie";
    }

    if(var_3 == var_0 || var_0 == "zombie_any") {
      self._id_9CB0++;
    }
  }

  return 1;
}

_id_9FE8(var_0) {
  wait(var_0);
  self notify("uber timeout");
}

_id_A6C3(var_0) {
  var_1 = var_0["cover_model"];
  var_2 = var_0["fuse_pickup"];
  level endon("raven up skip");
  var_1._id_8C80 = 1;
  _id_057E::_id_0984(var_1, var_1, ::_id_6BA2);
  var_1 waittill("sentry_damage");
}

_id_6BA2(var_0, var_1) {
  var_0 notify("sentry_damage");
}

_id_902D() {
  for(;;) {
    var_0 = _id_054D::_id_90BA("zombie_exploder", self, "storm raven test", 0, 1, 1);
    wait 5;
  }
}

_id_9064() {
  for(;;) {
    var_0 = _id_054D::_id_90BA("zombie_heavy", self, "storm raven test", 0, 1, 1);
    wait 5;
  }
}

_id_A6A2(var_0) {
  self endon("follower striked");
  level endon("raven up skip");
  var_1 = 0;

  while(!var_1) {
    level waittill("follower swing", var_2, var_3);

    if(distance(var_0.origin, var_2) < var_3) {
      var_1 = 1;
    }
  }
}

_id_A6B9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  self show();

  if(isDefined(var_2)) {
    _id_0547::_id_AC41(var_0, undefined, var_2);
  } else {
    _id_0547::_id_AC41(var_0, var_1);
  }

  var_4 = "";
  var_5 = undefined;

  while(!isDefined(var_3) && var_4 == "" || isDefined(var_3) && var_4 != var_3) {
    self waittill("player_used", var_5);
    var_4 = var_5 getcurrentweapon();

    if(isDefined(var_3) && var_4 != var_3) {
      var_5 iprintln("need wonder weap to skip");
    }
  }

  _id_0547::_id_AC40();
  self delete();
  return var_5;
}

completedeathreward() {
  common_scripts\utility::_id_3C9F("flag_nest_hc_ee_death_assembled");

  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("deathraven");
  }
}

completebloodreward() {
  common_scripts\utility::_id_3C9F("flag_nest_hc_ee_blood_assembled");

  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("bloodraven");
  }
}

completestormreward() {
  common_scripts\utility::_id_3C9F("flag_nest_hc_ee_storm_assembled");

  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("stormraven");
  }
}

completemoonreward() {
  common_scripts\utility::_id_3C9F("flag_nest_hc_ee_moon_assembled");

  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("moonraven");
  }
}
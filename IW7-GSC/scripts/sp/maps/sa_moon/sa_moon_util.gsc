/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_util.gsc
****************************************************/

_id_C0B3() {
  var_0 = getEntArray("rotating_roid", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 notsolid();
  }

  var_4 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_4)) {
    scripts\engine\utility::array_call(var_4, ::notsolid);
  }

  var_0 = getEntArray("tube", "script_noteworthy");

  foreach(var_6 in var_0) {
    var_7 = getEntArray(var_6.target, "targetname");

    if(isDefined(var_7)) {
      foreach(var_2 in var_7) {
        var_2 notsolid();
      }
    }
  }
}

_id_8EA5() {
  for(var_0 = 1; var_0 <= 6; var_0++) {
    _id_8E79("animated_missile_port" + var_0);
    _id_8E79("animated_missile_star" + var_0);
    scripts\engine\utility::waitframe();
  }

  var_1 = getEntArray("rotating_roid", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 notify("stopRotating");
    var_3 delete();
  }

  var_5 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_5)) {
    scripts\engine\utility::array_call(var_5, ::delete);
  }

  var_1 = getEntArray("damage_destroyer_vista", "targetname");

  foreach(var_3 in var_1) {
    var_3 notify("stopRotating");
    var_3 delete();
  }

  var_8 = getEntArray("large_maintenance_door_left", "targetname");

  foreach(var_10 in var_8) {
    var_11 = var_10 scripts\engine\utility::get_target_array();

    foreach(var_13 in var_11) {
      var_13 delete();
    }
  }

  var_16 = getEntArray("large_maintenance_door_right", "targetname");

  foreach(var_10 in var_16) {
    var_11 = var_10 scripts\engine\utility::get_target_array();

    foreach(var_13 in var_11) {
      var_13 delete();
    }
  }

  var_1 = getEntArray("space_small_movers", "targetname");

  foreach(var_3 in var_1) {
    var_3 notify("stopRotating");
    var_3 delete();
  }

  var_1 = getEntArray("tube", "script_noteworthy");

  foreach(var_24 in var_1) {
    var_25 = getEntArray(var_24.target, "targetname");

    if(isDefined(var_25)) {
      foreach(var_3 in var_25) {
        var_3 notify("stopRotating");
        var_3 delete();
      }
    }

    var_24 notify("stopRotating");
    var_24 delete();
  }

  var_29 = _id_0F31::_id_7EDE();

  foreach(var_24 in var_29) {
    var_25 = getEntArray(var_24.target, "targetname");

    if(isDefined(var_25)) {
      foreach(var_3 in var_25) {
        var_3 notify("stopRotating");
        var_3 delete();
      }
    }

    var_24 notify("stopRotating");
    var_24 delete();
  }

  var_34 = _id_8004();

  foreach(var_24 in var_34) {
    var_25 = getEntArray(var_24.target, "targetname");

    if(isDefined(var_25)) {
      foreach(var_3 in var_25) {
        var_3 notify("stopRotating");
        var_3 delete();
      }
    }

    var_24 notify("stopRotating");
    var_24 delete();
  }
}

_id_8E79(var_0) {
  var_0 = getEnt(var_0, "script_noteworthy");
  var_0 delete();
}

_id_8004() {
  var_0 = getEntArray("objectBrushNoGrapple", "targetname");
  return var_0;
}

_id_405F() {
  foreach(var_1 in level._id_1D0A._id_FE2D) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1 delete();
    }
  }

  foreach(var_1 in level._id_26EB._id_FE2D) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1 delete();
    }
  }

  if(isDefined(level._id_118A8)) {
    level._id_118A8 _id_0BB6::_id_39E1();
    level._id_118A8 _id_0BB8::_id_39C5();

    if(isDefined(level._id_118A8._id_4074)) {
      foreach(var_6 in level._id_118A8._id_4074) {
        if(isDefined(var_6)) {
          var_6 delete();
        }
      }

      level._id_118A8._id_4074 = [];
    }

    level._id_118A8 delete();
  }
}

#using_animtree("generic_human");

_id_13EF7() {
  level._id_126C9 = scripts\engine\utility::getStructArray("zg_traversal", "script_noteworthy");

  foreach(var_1 in level._id_126C9) {
    var_1._id_1FC9 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  }

  level._id_EC85["generic"]["hm_zg_red_exposed_traversal_step_01"] = % hm_zg_red_exposed_traversal_step_01;
}

_id_13EF8() {
  level endon("zerog_combat_space_end");

  for(;;) {
    var_0 = getaiarray("axis");
    var_1 = [];

    foreach(var_3 in var_0) {
      if(var_3.space) {
        var_1[var_1.size] = var_3;
      }
    }

    if(var_1.size > 0) {
      var_5 = scripts\engine\utility::random(var_0);

      if(isDefined(var_5) && isalive(var_5)) {
        var_6 = var_5 _id_0F34::_id_13E86(5.0);
      }

      var_5.ignoreall = 0;
    }

    wait 5.0;
  }
}

_id_A127() {
  wait 0.25;
  level._id_26EB = spawnStruct();
  level._id_26EB thread _id_0F0E::_id_B2D9("axis_jackals", 6, -1, "intro_jackals_done", undefined, 0, "zerog_combat_space_end");
  scripts\engine\utility::waitframe();
  level._id_1D0A = spawnStruct();
  level._id_1D0A thread _id_0F0E::_id_B2D9("ally_jackal", 6, -1, undefined, 1, 0, "zerog_combat_space_end");
  wait 3;

  foreach(var_1 in level._id_1D0A._id_FE2D) {
    if(isDefined(var_1)) {
      var_1 _id_0BDC::_id_A324("veh_mil_air_un_jackal_drone_atmos_periph");
    }
  }

  foreach(var_1 in level._id_26EB._id_FE2D) {
    if(isDefined(var_1)) {
      var_1 _id_0BDC::_id_A324("veh_mil_air_un_jackal_drone_atmos_periph");
    }
  }
}

_id_3970() {
  wait 0.05;
  var_0 = _id_0F0E::_id_88BE(undefined, 1, "tigris", undefined, 6, 1, "cannon_large_lock_ca,1,1,amb_turret_l_1,amb_turret_l_2,amb_turret_m_1,amb_turret_m_2,amb_turret_r_1,amb_turret_r_2", 1);
  level._id_118A8 = var_0;
  level notify("tigris_spawned");
  wait 8;
  level._id_3965 thread _id_0BB6::_id_39F0(undefined, undefined, 1, 1);
  wait 2;
  level._id_118A8 unlink();
  var_1 = getvehiclenode("tigris_path1", "targetname");
  var_0 scripts\sp\vehicle::_id_2471(var_1);
}

_id_10626() {
  var_0 = [];
  var_0[var_0.size] = getEnt("sa01_ethan", "targetname");
  var_0[var_0.size] = getEnt("sa01_salter", "targetname");
  var_0[var_0.size] = getEnt("sa01_omar", "targetname");

  foreach(var_2 in var_0) {
    var_2.count = 99;
    var_2 scripts\sp\utility::_id_1747(::_id_F8B2);
  }

  level._id_6754 = scripts\sp\utility::_id_107EA("sa01_ethan", 1);
  level._id_6754 thread _id_0F16::isfirstarmageddonmeteorhit("iw7_ake", "primary");
  level._id_EA2C = scripts\sp\utility::_id_107EA("sa01_salter", 1);
  level._id_EA2C thread _id_0F16::isfirstarmageddonmeteorhit("iw7_m8+m8scope_sp", "primary", "iw7_m4");
  level._id_C47F = scripts\sp\utility::_id_107EA("sa01_omar", 1);
  level._id_C47F thread _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
  level.allies = [level._id_6754, level._id_EA2C, level._id_C47F];
  scripts\engine\utility::flag_set("allies_spawned");
}

_id_10628(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      var_1[var_1.size] = getEnt(var_3, "targetname");
    }
  } else {
    var_1[var_1.size] = getEnt("sa01_ethan_zerog", "targetname");
    var_1[var_1.size] = getEnt("sa01_salter_zerog", "targetname");
    var_1[var_1.size] = getEnt("sa01_omar_zerog", "targetname");
  }

  foreach(var_6 in var_1) {
    var_6 scripts\sp\utility::_id_1747(::_id_F8B2);
  }

  if(!isDefined(level._id_1C24)) {
    level._id_1C24 = [];
  }

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(var_3 == "sa01_ethan_zerog") {
        level._id_679E = scripts\sp\utility::_id_107EA("sa01_ethan_zerog", 1);
        level._id_1C24[level._id_1C24.size] = level._id_679E;
        level._id_679E thread _id_0F16::isfirstarmageddonmeteorhit("iw7_ake", "primary");
        continue;
      }

      if(var_3 == "sa01_salter_zerog") {
        level._id_EAFE = scripts\sp\utility::_id_107EA("sa01_salter_zerog", 1);
        level._id_1C24[level._id_1C24.size] = level._id_EAFE;
        level._id_EAFE thread _id_0F16::isfirstarmageddonmeteorhit("iw7_m8+m8scope_sp", "primary", "iw7_m4");
        continue;
      }

      if(var_3 == "sa01_omar_zerog") {
        level._id_C49F = scripts\sp\utility::_id_107EA("sa01_omar_zerog", 1);
        level._id_1C24[level._id_1C24.size] = level._id_C49F;
        level._id_C49F thread _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
        continue;
      }

      level._id_1C24[level._id_1C24.size] = ::scripts\sp\utility::_id_107EA(var_3, 1);
    }
  } else {
    level._id_679E = scripts\sp\utility::_id_107EA("sa01_ethan_zerog", 1);
    level._id_679E thread _id_0F16::isfirstarmageddonmeteorhit("iw7_ake", "primary");
    level._id_EAFE = scripts\sp\utility::_id_107EA("sa01_salter_zerog", 1);
    level._id_EAFE thread _id_0F16::isfirstarmageddonmeteorhit("iw7_m8+m8scope_sp", "primary", "iw7_m4");
    level._id_C49F = scripts\sp\utility::_id_107EA("sa01_omar_zerog", 1);
    level._id_C49F thread _id_0F16::isfirstarmageddonmeteorhit("iw7_crb", "primary");
    level._id_1C24 = [level._id_679E, level._id_EAFE, level._id_C49F];
  }

  scripts\engine\utility::flag_set("allies_spawned_zerog");
}

_id_F8B2() {
  if(self.script_noteworthy == "ethan") {
    self._id_1FBB = "ethan";
    scripts\sp\utility::_id_B14F();
    scripts\sp\utility::_id_F3B5("b");
  }

  if(self.script_noteworthy == "salter") {
    self._id_1FBB = "salter";
    scripts\sp\utility::_id_B14F();
    scripts\sp\utility::_id_F3B5("g");
  }

  if(self.script_noteworthy == "omar") {
    self._id_1FBB = "omar";
    scripts\sp\utility::_id_B14F();
    scripts\sp\utility::_id_F3B5("r");
  }
}

_id_1919(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::_id_13754(var_0, var_1, var_3);
  scripts\engine\utility::flag_set(var_2);
}

_id_E352(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  var_5 = var_4 scripts\sp\utility::_id_77E3("axis");
  var_6 = getEnt(var_1, "targetname");

  foreach(var_8 in var_5) {
    if(isDefined(var_8) && isalive(var_8)) {
      if(isDefined(var_2) && isDefined(var_3)) {
        wait(randomfloatrange(var_2, var_3));
      }

      var_8._id_72C7 = 0;
      var_8.fixednode = 0;
      var_8.pathrandompercent = randomintrange(75, 100);
      var_8 _meth_82F1(var_6);
    }
  }
}

_id_FA71() {
  var_0 = getEntArray("turret_targets", "targetname");

  foreach(var_2 in var_0) {
    var_2 linkTo(level._id_68FF);
  }

  return var_0;
}

_id_F979(var_0, var_1) {
  self notify("setup_fake_grapple_point");
  self endon("setup_fake_grapple_point");
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin);
  _id_0F35::_id_FB25(1, 1, 1);
  level.player _meth_8501(var_3);

  for(;;) {
    level.player waittill("spacejump_takeoff", var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_1)) {
      if(isDefined(var_8) && var_8 == var_3) {
        scripts\engine\utility::flag_set(var_1);
        var_9 = level.player scripts\engine\utility::waittill_any_return("spacejump_land", "spacegrapple_cancel");
        scripts\engine\utility::flag_clear(var_1);

        if(var_9 == "spacejump_land") {
          if(var_8 == var_3) {
            level.player _meth_8502();
            var_3 delete();
            return;
          }
        }
      }

      continue;
    }

    level.player _meth_8502();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_9716(var_0) {
  var_1 = [];
  var_1["sa_hangar_vol"] = "sa_hangar_start";
  var_1["sa_armory_room_vol"] = "sa_armory_start";
  var_1["sa_hubstern_vol"] = "sa_hubstern_start";
  var_1["sa_hubbow_vol"] = "sa_hubbow_start";
  var_1["sa_bridge_vol"] = "sa_bridge_start";
  var_1["sa_bridge_com_vol"] = "sa_bridge_com_start";
  var_1["sa_barracks_vol"] = "sa_barracks_start";
  var_1["sa_sternport_rooma_vol"] = "sa_sternport_rooma_start";
  var_1["sa_sternport_roomb_vol"] = "sa_sternport_roomb_start";
  var_1["sac_hubstern_port_vol"] = "sac_hubstern_port_start";
  var_1["sac_portlower_vol"] = "sac_portlower_start";
  var_1["sac_bowlower_vol"] = "sac_bowlower_start";
  var_2 = [];
  var_2["sa_hangar_vol"] = "hot";
  var_2["sa_armory_room_vol"] = "hot";
  var_2["sa_hubstern_vol"] = "hot";
  var_2["sa_hubbow_vol"] = "hot";
  var_2["sa_bridge_vol"] = "hot";
  var_2["sa_bridge_com_vol"] = "hot";
  var_2["sa_barracks_vol"] = "hot";
  var_2["sa_sternport_rooma_vol"] = "hot";
  var_2["sa_sternport_roomb_vol"] = "hot";
  var_2["sac_hubstern_port_vol"] = "hot";
  var_2["sac_portlower_vol"] = "hot";
  var_2["sac_bowlower_vol"] = "hot";
  var_3 = [];
  var_3["sa_hangar_vol"] = "sa_hangar_combat_vol";
  var_3["sa_armory_room_vol"] = "sa_armory_combat_vol";
  var_3["sa_hubstern_vol"] = "sa_hubstern_combat_vol";
  var_3["sa_hubbow_vol"] = "sa_hubbow_combat_vol";
  var_3["sa_bridge_vol"] = "sa_bridge_combat_vol";
  var_3["sa_bridge_com_vol"] = "sa_bridge_com_combat_vol";
  var_3["sa_barracks_vol"] = "sa_barracks_combat_vol";
  var_3["sa_sternport_rooma_vol"] = "sa_sternport_rooma_combat_vol";
  var_3["sa_sternport_roomb_vol"] = "sa_sternport_roomb_combat_vol";
  var_3["sac_hubstern_port_vol"] = "sac_hubstern_port_combat_vol";
  var_3["sac_portlower_vol"] = "sac_portlower_combat_vol";
  var_3["sac_bowlower_vol"] = "sac_bowlower_combat_vol";
  _id_0F0C::_id_E9E4(var_1, var_2, var_3, ::_id_79F8, ::_id_7B73);
}

_id_79F8(var_0) {
  var_1 = [];

  switch (var_0) {
    default:
      break;
  }

  return var_1;
}

_id_7B73(var_0) {
  var_1 = [];

  switch (var_0) {
    default:
      break;
  }

  return var_1;
}

_id_1723(var_0, var_1, var_2, var_3) {
  if(!scripts\sp\utility::_id_C268(var_0)) {
    objective_add(scripts\sp\utility::_id_C264(var_0), var_1, var_2);

    if(!isDefined(var_3)) {
      thread _id_0F16::_id_C278(scripts\sp\utility::_id_C264(var_0));
    }
  }
}

_id_12DFB(var_0, var_1, var_2) {
  if(scripts\sp\utility::_id_C268(var_0)) {
    objective_position(scripts\sp\utility::_id_C264(var_0), var_1);

    if(!isDefined(var_2)) {
      thread _id_0F16::_id_C278(scripts\sp\utility::_id_C264(var_0));
    }
  }
}

_id_119C1(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  while(!scripts\engine\utility::flag(var_3)) {
    var_5 = distancesquared(level.player.origin, var_1);

    if(var_4 && var_5 >= var_2) {
      var_4 = 0;
      objective_state_nomessage(var_0, "current");
    } else if(!var_4 && var_5 < var_2) {
      var_4 = 1;
      objective_state_nomessage(var_0, "active");
    }

    wait 0.05;
  }
}

_id_E9CA(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    setsaveddvar("cg_helmetLinearVelocityToAngleRate", (0.4, 0.4, 1));
    setsaveddvar("cg_helmetViewSwayRate", -0.1);
  } else {
    setsaveddvar("cg_helmetLinearVelocityToAngleRate", (1.2, 1.2, 2));
    setsaveddvar("cg_helmetViewSwayRate", -0.3);
  }

  level thread _id_E9C7(var_0);
}

_id_E9C7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(level.player.helmet)) {
    if(scripts\sp\utility::_id_93A6()) {
      level.player.helmet = level._id_10964.helmet;
    } else {
      level _id_0E4B::_id_8E04(1);
    }
  }

  if(getDvar("createfx") != "") {
    return;
  }
  if(getdvarint("no_helmet") == 0 || getdvarint("no_helmet") == 2) {
    if(!scripts\sp\utility::_id_93A6()) {
      level _id_0E4B::_id_8E06();
    }

    if(isDefined(level.player.helmet) && getdvarint("no_helmet") == 0) {
      if(var_0) {
        level.player.helmet setModel("vm_hero_protagonist_helmet_zerog_empty");
      } else {
        level.player.helmet setModel("vm_hero_protagonist_helmet_zerog");
      }
    }
  }
}

_id_88E9(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait(var_1);

  if(isDefined(var_2)) {
    wait(var_2);
  }

  scripts\engine\utility::exploder(var_0);
}

_id_8E92(var_0) {
  var_1 = getEntArray("interior_float_models", "script_noteworthy");

  if(var_0 == 1) {
    foreach(var_3 in var_1) {
      var_3 hide();
    }
  } else {
    foreach(var_3 in var_1) {
      var_3 show();
    }
  }

  var_7 = getEntArray("exfil_jprops", "targetname");

  if(var_0 == 1) {
    foreach(var_9 in var_7) {
      var_9 hide();
    }
  } else {
    foreach(var_9 in var_7) {
      var_9 show();
    }
  }

  var_13 = getEntArray("cargo_bay_props", "targetname");

  if(var_0 == 1) {
    foreach(var_15 in var_13) {
      var_15 hide();
    }
  } else {
    foreach(var_15 in var_13) {
      var_15 show();
    }
  }

  var_19 = getEntArray("bollard_barrier_lights", "targetname");

  if(var_0 == 1) {
    foreach(var_21 in var_19) {
      var_21 hide();
    }
  } else {
    foreach(var_21 in var_19) {
      var_21 show();
    }
  }

  var_25 = getEnt("cargobay_door_left", "targetname");

  if(var_0 == 1) {
    var_25 hide();
  } else {
    var_25 show();
  }

  var_26 = getEnt("cargobay_door_right", "targetname");

  if(var_0 == 1) {
    var_26 hide();
  } else {
    var_26 show();
  }
}

_id_5141() {
  level._id_30CB delete();
  var_0 = getEnt("bridge_console_cracks", "targetname");
  var_0 delete();
}

_id_515E() {
  var_0 = getEntArray("interior_float_models", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  var_4 = getEntArray("exfil_jprops", "targetname");

  foreach(var_6 in var_4) {
    var_6 delete();
  }

  var_8 = getEntArray("cargo_bay_props", "targetname");

  foreach(var_10 in var_8) {
    var_10 delete();
  }

  var_12 = getEntArray("bollard_barrier_lights", "targetname");

  foreach(var_14 in var_12) {
    var_14 delete();
  }

  var_16 = getEnt("cargobay_door_left", "targetname");
  var_16 delete();
  var_17 = getEnt("cargobay_door_right", "targetname");
  var_17 delete();
}

_id_13EF9(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    scripts\engine\utility::waitframe();
  }

  thread _id_0A2F::_id_13E80(var_0, 1);
}

_id_E9C8() {
  scripts\engine\utility::flag_wait("zg_hull_start");
  thread _id_0F36::_id_12AB4("zero_g_end");
}

_id_8899(var_0, var_1) {
  level.player playgestureviewmodel("ges_radio", undefined, 1);
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player scripts\sp\utility::_id_D2D1(var_0, var_1);
  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_autoreload(0);
}

_id_8897(var_0) {
  level.player playSound("ges_plr_radio_off");
  level.player stopgestureviewmodel("ges_radio", var_0);
  level.player scripts\sp\utility::_id_D2CA(1);
  level.player scripts\engine\utility::allow_ads(1);
  level.player scripts\engine\utility::allow_reload(1);
  level.player scripts\engine\utility::allow_autoreload(1);
}

#using_animtree("jackal");

_id_871D() {
  self _meth_849F(0);
  self _meth_848F(1);
  self _meth_82B0(%jackal_vehicle_weap_primary_drop, 1);
}

_id_A32B() {
  _id_0BDC::_id_A144();
  self setModel("veh_mil_air_un_jackal_02_player_sa_moon");
  self dontcastshadows();
}

_id_51A1() {
  self endon("death");
  level.player scripts\sp\utility::_id_65E8("zero_gravity");

  if(isDefined(self)) {
    self delete();
  }
}

_id_12BBE() {
  if(!scripts\engine\utility::flag("cargobay_door_close")) {
    thread scripts\sp\utility::_id_1264E("sa_moon_hallway_tr");
    level._id_3A94 show();
    level notify("command_ammo_crate");
  }
}
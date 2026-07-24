/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4267.gsc
**************************************/

_id_ADAD(var_0, var_1, var_2) {
  [[var_1]]();
  var_3 = _id_9835(var_0);
  _id_DE95(var_0, var_3);
  [[var_2]](var_3);
}

_id_404E(var_0) {
  if(isDefined(level._id_1D6B) && isDefined(level._id_1D6B[var_0])) {
    foreach(var_2 in level._id_1D6B[var_0]) {
      if(isarray(var_2)) {
        foreach(var_4 in var_2) {
          _id_0EFB::_id_FDBA(var_4);
        }

        continue;
      }

      _id_0EFB::_id_FDBA(var_2);
    }

    level._id_1D6B[var_0] = undefined;
  }
}

_id_780D(var_0, var_1) {
  if(!isDefined(level._id_1D6B)) {
    return undefined;
  }

  if(isDefined(var_1) && isDefined(level._id_1D6B[var_1])) {
    if(isDefined(level._id_1D6B[var_1][var_0])) {
      return level._id_1D6B[var_1][var_0];
    } else {
      return undefined;
    }
  } else {
    foreach(var_3 in level._id_1D6B) {
      foreach(var_5 in var_3) {
        if(isDefined(var_5._id_1DCA) && var_5._id_1DCA == var_0) {
          return var_5;
        }
      }
    }
  }

  return undefined;
}

_id_9835(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_2 = _id_1062F(var_1);
  return var_2;
}

_id_1062F(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = _id_7C8B(var_4.script_parameters);
    var_6 = _id_7C87(var_4.script_parameters);
    var_7 = _id_0EF8::_id_FDFC(var_5, var_4, "cheap", undefined, undefined, undefined, undefined, var_6);
    var_7._id_1D77 = var_4.animation;
    var_7._id_1EEF = var_4;

    if(isDefined(var_4.script_index)) {
      var_7.index = var_4.script_index;
    }

    if(isDefined(var_4.script_noteworthy)) {
      var_8 = var_4.script_noteworthy;
    } else {
      var_2++;
      var_8 = var_4.targetname + "_auto_" + var_2;
    }

    var_7._id_A594 = var_8;
    var_1[var_8] = _id_1753(var_7, var_1[var_8]);
  }

  return var_1;
}

_id_7C8B(var_0) {
  var_1 = "spawner_interior";

  if(isDefined(var_0)) {
    switch (var_0) {
      case "bandaged":
        var_1 = "spawner_bandaged";
        break;
      case "bandaged_male":
        var_1 = "spawner_bandaged_male";
        break;
      case "bandaged_female":
        var_1 = "spawner_bandaged_female";
        break;
      case "marine":
        var_1 = "spawner_marine";
        break;
      case "marine_male":
        var_1 = "spawner_marine";
        break;
      case "marine_casual":
        var_1 = "spawner_marine_casual";
        break;
      case "marine_casual_male":
        var_1 = "spawner_marine_casual";
        break;
      case "marine_casual_female":
        var_1 = "spawner_marine_casual";
        break;
      case "pilot":
        var_1 = "spawner_pilot";
        break;
      case "crew":
        var_1 = "spawner_interior";
        break;
      case "medic":
        var_1 = "spawner_medic";
        break;
      case "mech":
        var_1 = "spawner_mech";
        break;
      case "mech_male":
        var_1 = "spawner_mech";
        break;
      case "mech_female":
        var_1 = "spawner_mech";
        break;
      case "mech_tools":
        var_1 = "spawner_mech_tools";
        break;
      case "flightdeck":
        var_1 = "spawner_flightdeck";
        break;
      case "flightdeck_green":
        var_1 = "spawner_flightdeck_maintenance";
        break;
      case "flightdeck_blue":
        var_1 = "spawner_flightdeck_handler";
        break;
      case "flightdeck_purple":
        var_1 = "spawner_flightdeck_fuel";
        break;
      case "flightdeck_red":
        var_1 = "spawner_flightdeck_ordnance";
        break;
      case "flightdeck_brown":
        var_1 = "spawner_flightdeck_plane_captain";
        break;
      default:
        var_1 = "spawner_interior";
    }
  }

  return var_1;
}

_id_7C87(var_0) {
  if(isDefined(var_0)) {
    var_1 = strtok(var_0, "_");

    if(var_1[var_1.size - 1] == "male" || var_1[var_1.size - 1] == "female") {
      return var_1[var_1.size - 1];
    }
  }

  return undefined;
}

_id_1753(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_0.index)) {
    if(!isarray(var_1)) {
      var_1 = _id_45E9(var_1, var_0);
      return var_1;
    } else {
      var_2 = _id_780E(var_0, var_1);
      var_1[var_2] = var_0;
      return var_1;
    }
  } else
    return var_0;
}

_id_45E9(var_0, var_1) {
  var_2 = [];
  var_3 = _id_780E(var_0, var_2);
  var_2[var_3] = var_0;
  var_4 = _id_780E(var_1, var_2);
  var_2[var_4] = var_1;
  return var_2;
}

_id_780E(var_0, var_1) {
  if(isDefined(var_0.index) && !isDefined(var_1[var_0.index])) {
    return var_0.index;
  } else {
    return _id_79B8(var_1);
  }
}

_id_79B8(var_0) {
  for(var_1 = 0; var_1 == var_1; var_1++) {
    if(!isDefined(var_0[var_1])) {
      return var_1;
    }
  }
}

_id_DE95(var_0, var_1) {
  if(!isDefined(level._id_1D6B)) {
    level._id_1D6B = [];
  }

  level._id_1D6B[var_0] = var_1;
}

_id_1F5E(var_0, var_1, var_2, var_3) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");

  if(isDefined(var_2)) {
    scripts\engine\utility::flag_wait(var_2);
  }

  if(isDefined(var_3)) {
    if(var_3) {
      _id_137C5();
    }
  }

  wait(var_0);
  _id_9867();

  if(isDefined(self._id_1D77)) {
    if(_id_9E86(self._id_1D77)) {
      _id_CC81(self._id_1D77, var_0, var_1);
    } else {
      _id_CC7C(self._id_1D77, var_0, var_1);
      _id_404F();
    }
  }
}

_id_CC81(var_0, var_1, var_2) {
  self._id_1EEF thread scripts\sp\anim::_id_1ECC(self, var_0);
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, _id_7DC7(var_0), var_2);
  play_looping_skit_anim(var_2);
}

_id_CC7C(var_0, var_1, var_2) {
  var_3 = getanimlength(scripts\sp\utility::_id_7DC1(var_0));
  self._id_1EEF thread scripts\sp\anim::_id_1EC7(self, var_0);

  if(var_2 > 0) {
    scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_0), var_2);
  }

  _id_CE0E(var_2);
  wait(var_3 - var_2 * var_3);
}

_id_404F() {
  _id_40C4();
  _id_0EFB::_id_FDBA(self);
}

_id_9E86(var_0) {
  if(isDefined(level._id_EC85[self._id_1FBB][var_0])) {
    if(isarray(level._id_EC85[self._id_1FBB][var_0])) {
      return 1;
    } else {
      return 0;
    }
  } else {}
}

_id_7DC7(var_0) {
  return level._id_EC85[self._id_1FBB][var_0][0];
}

_id_9867() {
  self._id_DA9E = _id_781D(self._id_1D77);

  if(self._id_DA9E.size > 0) {
    self._id_DA9C = _id_1063B(self._id_DA9E);
  }
}

_id_781D(var_0) {
  var_1 = [];

  if(!isDefined(var_0)) {
    return var_1;
  }

  var_2 = getarraykeys(level._id_EC8C);

  foreach(var_4 in var_2) {
    if(isstring(var_4)) {
      if(_id_2288(level._id_EC85[var_4], var_0)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
      }
    }
  }

  return var_1;
}

_id_2288(var_0, var_1) {
  if(!isarray(var_0)) {
    return 0;
  }

  var_2 = getarraykeys(var_0);

  foreach(var_4 in var_2) {
    if(isstring(var_4)) {
      if(var_4 == var_1) {
        return 1;
      }
    }
  }

  return 0;
}

_id_1063B(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = scripts\engine\utility::array_add(var_1, scripts\sp\utility::_id_10639(var_3));
  }

  return var_1;
}

play_looping_skit_anim(var_0) {
  if(isDefined(self._id_DA9C)) {
    foreach(var_2 in self._id_DA9C) {
      self._id_1EEF thread scripts\sp\anim::_id_1EEA(var_2, self._id_1D77, "stop_loop");
      var_2 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_2 _id_7DC7(self._id_1D77), var_0);
      thread _id_DB7A(var_2, self);
    }
  }
}

_id_CE0E(var_0) {
  if(isDefined(self._id_DA9C)) {
    foreach(var_2 in self._id_DA9C) {
      self._id_1EEF thread scripts\sp\anim::_id_1F35(var_2, self._id_1D77);

      if(var_0 > 0) {
        var_2 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_2 scripts\sp\utility::_id_7DC1(self._id_1D77), var_0);
      }
    }
  }
}

_id_40C4() {
  if(isDefined(self._id_DA9C)) {
    foreach(var_1 in self._id_DA9C) {
      var_1 delete();
    }
  }
}

_id_DB7A(var_0, var_1) {
  var_1 waittill("death");
  var_0 delete();
}

_id_CC87(var_0, var_1, var_2, var_3) {
  self endon("death");
  self._id_F272 = _id_8113();
  _id_9867();
  _id_CC81(self._id_F272["start"], 0, var_1);

  if(isDefined(var_2)) {
    scripts\engine\utility::flag_wait(var_2);
  }

  if(isDefined(var_3)) {
    if(var_3) {
      _id_137C5();
    }
  }

  wait(var_0);
  self._id_1EEF notify("stop_loop");
  level._id_EC89[self._id_1FBB][self._id_1D77] = 1.5;
  _id_CC7C(self._id_1D77, var_0, 0);
  _id_CC81(self._id_F272["end"], 0, var_1);
}

_id_8113() {
  if(isDefined(self._id_1EEF.script_side)) {
    var_0 = strtok(self._id_1EEF.script_side, ",");
    var_1 = [];

    if(isDefined(var_0[0]) && isDefined(var_0[1])) {
      var_1["start"] = var_0[0];
      var_1["end"] = var_0[1];
    } else {}

    return var_1;
  } else {}
}

_id_137C5() {
  var_0 = 0;

  while(var_0 == 0) {
    wait 0.05;

    if(level.player scripts\sp\utility::_id_D637(self.origin)) {
      var_0 = 1;
    }
  }
}

_id_300C() {
  if(!scripts\engine\utility::flag_exist("allow_bridge_ffa_move")) {
    scripts\engine\utility::flag_init("allow_bridge_ffa_move");
  }

  scripts\engine\utility::flag_set("allow_bridge_ffa_move");

  if(!scripts\engine\utility::flag_exist("bridge_ffa_in_transit")) {
    scripts\engine\utility::flag_init("bridge_ffa_in_transit");
  }

  _id_300B();
  _id_300E();

  if(!scripts\engine\utility::flag_exist("setup_sceneblock_anims") || !scripts\engine\utility::flag("setup_sceneblock_anims")) {
    _id_0B6A::_id_EBE9();
  }

  _id_0EFB::_id_FE05();
  level._id_FD6E._id_300A = [];
  level._id_FD6E._id_300A["tablet"] = getEnt("greaseboard_tablet", "targetname");
  level._id_FD6E._id_300A["tablet"]._id_1FBB = "greaseboard_tablet";
  level._id_FD6E._id_300A["tablet"] scripts\sp\anim::_id_F64A();
  _id_0EFB::_id_EFDB("grease") thread scripts\sp\anim::_id_1EC3(level._id_FD6E._id_300A["tablet"], "shipcrib_bridge_greaseboard_idle_01");
  level._id_FD6E._id_300A["locations"] = ["nav1", "nav3", "nav5", "radiation", "grease", "sysend", "drop"];
  level._id_FD6E._id_300A["taken"] = [];
}

#using_animtree("generic_human");

_id_300B() {
  level._id_EC85["generic"]["shipcrib_bridge_radiation_station_idle_01"] = % shipcrib_bridge_radiation_station_idle_01;
  level._id_EC85["generic"]["shipcrib_bridge_radiation_station_idle_02"] = % shipcrib_bridge_radiation_station_idle_02;
  level._id_EC85["generic"]["shipcrib_bridge_greaseboard_idle_start_03"] = % shipcrib_bridge_greaseboard_idle_start_03;
  level._id_EC85["generic"]["shipcrib_bridge_greaseboard_idle_03"][0] = % shipcrib_bridge_greaseboard_idle_03;
  level._id_EC85["generic"]["shipcrib_bridge_greaseboard_idle_end_03"] = % shipcrib_bridge_greaseboard_idle_end_03;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_idle_01"][0] = % shipcrib_bridge_hustle_wdw_to_obs_idle_01;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_trav_01"] = % shipcrib_bridge_hustle_wdw_to_obs_trav_01;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_idle_02"][0] = % shipcrib_bridge_hustle_wdw_to_obs_idle_02;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_trav_02"] = % shipcrib_bridge_hustle_wdw_to_obs_trav_02;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_idle_01"][0] = % shipcrib_bridge_hustle_grs_to_rad_idle_01;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_trav_01"] = % shipcrib_bridge_hustle_grs_to_rad_trav_01;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_idle_02"][0] = % shipcrib_bridge_hustle_grs_to_rad_idle_02;
  level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_trav_02"] = % shipcrib_bridge_hustle_grs_to_rad_trav_02;
}

#using_animtree("script_model");

_id_300E() {
  level._id_EC87["greaseboard_tablet"] = #animtree;
  level._id_EC8C["greaseboard_tablet"] = "p7_desk_metal_military_03_tablet";
  level._id_EC85["greaseboard_tablet"]["shipcrib_bridge_greaseboard_idle_01"] = % shipcrib_bridge_greaseboard_tablet_idle_01;
  level._id_EC85["greaseboard_tablet"]["shipcrib_bridge_greaseboard_idle_02"] = % shipcrib_bridge_greaseboard_tablet_idle_02;
  level._id_EC85["greaseboard_tablet"]["shipcrib_bridge_greaseboard_tablet_idle_start_03"] = % shipcrib_bridge_greaseboard_tablet_idle_start_03;
  level._id_EC85["greaseboard_tablet"]["shipcrib_bridge_greaseboard_tablet_idle_03"][0] = % shipcrib_bridge_greaseboard_tablet_idle_03;
  level._id_EC85["greaseboard_tablet"]["shipcrib_bridge_greaseboard_tablet_idle_end_03"] = % shipcrib_bridge_greaseboard_tablet_idle_end_03;
}

_id_300D() {
  self endon("death");
  self endon("stop_ffa");
  scripts\sp\interaction_manager::_id_11048();
  wait 0.75;
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = _id_0EF1::_id_789F("generic_female_03");
  thread _id_0EE5::_id_202D(undefined, "shipcrib_unf3_sir", var_1);

  for(;;) {
    var_0 thread scripts\sp\anim::_id_1ECC(self, "shipcrib_bridge_hustle_wdw_to_obs_idle_01", "stop_obs_loop");
    wait(getanimlength(level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_idle_01"][0]) * float(randomintrange(2, 4)));
    var_2 = scripts\anim\utility::_id_7DC6(level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_trav_01"]);

    for(;;) {
      if(scripts\engine\utility::flag("allow_bridge_ffa_move") && distance2d(level.player.origin, var_2) >= 150.0) {
        break;
      }

      wait 0.05;
    }

    var_0 notify("stop_obs_loop");
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_bridge_hustle_wdw_to_obs_trav_01");
    var_0 thread scripts\sp\anim::_id_1ECC(self, "shipcrib_bridge_hustle_wdw_to_obs_idle_02", "stop_obs_loop");
    wait(getanimlength(level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_idle_02"][0]) * float(randomintrange(2, 4)));
    var_2 = scripts\anim\utility::_id_7DC6(level._id_EC85["generic"]["shipcrib_bridge_hustle_wdw_to_obs_trav_02"]);

    for(;;) {
      if(scripts\engine\utility::flag("allow_bridge_ffa_move") && distance2d(level.player.origin, var_2) >= 150.0) {
        break;
      }

      wait 0.05;
    }

    var_0 notify("stop_obs_loop");
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_bridge_hustle_wdw_to_obs_trav_02");
    wait 0.05;
  }
}

_id_300F() {
  self endon("death");
  self endon("stop_ffa");
  scripts\sp\interaction_manager::_id_11048();
  wait 0.75;
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = _id_0EF1::_id_789F("generic_male_02");
  thread _id_0EE5::_id_202D(undefined, "shipcrib_un2_weregoodheresi", var_1);
  self attach("p7_desk_metal_military_03_tablet", "tag_accessory_left", 1);

  for(;;) {
    var_0 thread scripts\sp\anim::_id_1ECC(self, "shipcrib_bridge_hustle_grs_to_rad_idle_02", "stop_rad_loop");
    wait(getanimlength(level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_idle_02"][0]) * float(randomintrange(9, 12)));
    var_2 = scripts\anim\utility::_id_7DC6(level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_trav_02"]);

    for(;;) {
      if(scripts\engine\utility::flag("allow_bridge_ffa_move") && distance2d(self.origin, level.player.origin) >= 200.0 && distance2d(level.player.origin, var_2) >= 150.0) {
        break;
      }

      wait 0.05;
    }

    var_0 notify("stop_rad_loop");
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_bridge_hustle_grs_to_rad_trav_02");
    var_0 thread scripts\sp\anim::_id_1ECC(self, "shipcrib_bridge_hustle_grs_to_rad_idle_01", "stop_rad_loop");
    wait(getanimlength(level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_idle_01"][0]) * float(randomintrange(9, 12)));
    var_2 = scripts\anim\utility::_id_7DC6(level._id_EC85["generic"]["shipcrib_bridge_hustle_grs_to_rad_trav_01"]);

    for(;;) {
      if(scripts\engine\utility::flag("allow_bridge_ffa_move") && distance2d(self.origin, level.player.origin) >= 200.0 && distance2d(level.player.origin, var_2) >= 150.0) {
        break;
      }

      wait 0.05;
    }

    var_0 notify("stop_rad_loop");
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_bridge_hustle_grs_to_rad_trav_01");
    wait 0.05;
  }
}

_id_300A() {
  self endon("death");
  self endon("stop_ffa");
  var_0 = ["shipcrib_bridge_radiation_station_idle_01", "shipcrib_bridge_radiation_station_idle_02"];

  while(!scripts\engine\utility::flag("allow_bridge_ffa_move") || scripts\engine\utility::flag("bridge_ffa_in_transit") || distance2dsquared(self.origin, level.player.origin) <= squared(200.0)) {
    wait 0.05;
  }

  scripts\sp\interaction_manager::_id_11048();
  var_1 = undefined;

  for(;;) {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_2 = _id_0EF1::_id_789F("generic_female_03");
      thread _id_0EE5::_id_202D(undefined, "shipcrib_unf3_sir", var_2);
    } else {
      var_3 = _id_0EF1::_id_789F("generic_male_02");
      thread _id_0EE5::_id_202D(undefined, "shipcrib_un2_weregoodheresi", var_3);
    }

    var_4 = _id_787E();
    var_5 = level._id_FD6E._id_300A["locations"][var_4];
    var_1 = _id_0EFB::_id_EFDB(var_5);
    var_1 notify("stop_loop");
    var_6 = randomint(2);

    while(!scripts\engine\utility::flag("allow_bridge_ffa_move") || scripts\engine\utility::flag("bridge_ffa_in_transit") || distance2d(self.origin, level.player.origin) <= 200.0 || distance2d(level.player.origin, var_1.origin) <= 150.0) {
      wait 0.05;
    }

    if(var_5 == "radiation") {
      scripts\engine\utility::flag_set("bridge_ffa_in_transit");
      self.script_pushable = 1;
      _id_0B6A::_id_EC0A(var_1);
      self.script_pushable = 0;
      scripts\engine\utility::flag_clear("bridge_ffa_in_transit");
      self.a.movement = "stop";
      var_7 = var_1;
      var_1 scripts\sp\anim::_id_1EC7(self, var_0[var_6]);

      while(!scripts\engine\utility::flag("allow_bridge_ffa_move") || scripts\engine\utility::flag("bridge_ffa_in_transit") || distance2d(self.origin, level.player.origin) <= 200.0 || distance2d(level.player.origin, var_1.origin) <= 150.0) {
        var_1 scripts\sp\anim::_id_1EC7(self, var_0[var_6]);
        wait 0.05;
      }
    } else if(var_5 == "grease") {
      scripts\engine\utility::flag_set("bridge_ffa_in_transit");
      self.script_pushable = 1;
      _id_0B6A::_id_EC0A(var_1);
      self.script_pushable = 0;
      scripts\engine\utility::flag_clear("bridge_ffa_in_transit");
      wait 0.05;
      self.a.movement = "stop";
      var_7 = var_1;
      var_7 thread scripts\sp\anim::_id_1EC7(self, "shipcrib_bridge_greaseboard_idle_start_03");
      var_7 scripts\sp\anim::_id_1F35(level._id_FD6E._id_300A["tablet"], "shipcrib_bridge_greaseboard_tablet_idle_start_03");
      var_7 thread scripts\sp\anim::_id_1ECC(self, "shipcrib_bridge_greaseboard_idle_03", "stop_loop");
      var_7 thread scripts\sp\anim::_id_1EEA(level._id_FD6E._id_300A["tablet"], "shipcrib_bridge_greaseboard_tablet_idle_03", "stop_loop");
      wait(getanimlength(level._id_EC85["generic"]["shipcrib_bridge_greaseboard_idle_03"][0]));

      while(!scripts\engine\utility::flag("allow_bridge_ffa_move") || scripts\engine\utility::flag("bridge_ffa_in_transit") || distance2d(self.origin, level.player.origin) <= 200.0 || distance2d(level.player.origin, var_1.origin) <= 150.0) {
        wait 0.05;
      }

      var_7 notify("stop_loop");
      var_7 thread scripts\sp\anim::_id_1F35(level._id_FD6E._id_300A["tablet"], "shipcrib_bridge_greaseboard_tablet_idle_end_03");
      var_7 scripts\sp\anim::_id_1EC7(self, "shipcrib_bridge_greaseboard_idle_end_03");
    } else {
      scripts\engine\utility::flag_set("bridge_ffa_in_transit");
      self.script_pushable = 1;
      _id_0B6A::_id_EC0B(var_1, "shipcrib_stand_console", undefined, 1, 0);
      self.script_pushable = 0;
      scripts\engine\utility::flag_clear("bridge_ffa_in_transit");

      if(isDefined(self.gender) && issubstr(self.gender, "female")) {
        thread scripts\sp\interaction::_id_CD50("opsmap_comms_react");
      } else {
        thread scripts\sp\interaction::_id_CD50("standing_console_simple");
      }

      wait(randomfloatrange(5, 10));

      while(!scripts\engine\utility::flag("allow_bridge_ffa_move") || scripts\engine\utility::flag("bridge_ffa_in_transit") || distance2d(self.origin, level.player.origin) <= 200.0 || distance2d(level.player.origin, var_1.origin) <= 150.0) {
        wait 0.05;
      }
    }

    thread _id_0EE5::_id_10FC4();
    level thread _id_4137(var_4);
  }
}

print_check_ffa_conditions(var_0) {
  for(;;) {
    var_1 = "Allow Bridge FFA Move = " + scripts\engine\utility::flag("allow_bridge_ffa_move");
    var_2 = "Bridge FFA In Transit = " + scripts\engine\utility::flag("bridge_ffa_in_transit");
    var_3 = "Distance To Player = " + distance2d(self.origin, level.player.origin);

    if(isDefined(var_0)) {
      var_4 = "Player Distance To Dest = " + distance2d(level.player.origin, var_0.origin);
    } else {
      var_4 = "Player Distance To Dest = no ent";
    }

    var_5 = self gettagorigin("j_head") + anglestoup(self.angles) * 10;
    var_6 = self gettagorigin("j_head") + anglestoup(self.angles) * 20;
    var_7 = self gettagorigin("j_head") + anglestoup(self.angles) * 30;
    var_8 = self gettagorigin("j_head") + anglestoup(self.angles) * 40;

    if(isDefined(var_0)) {}

    wait 0.05;
  }
}

_id_787E() {
  self endon("stop_ffa");

  for(;;) {
    var_0 = randomint(level._id_FD6E._id_300A["locations"].size);
    var_1 = level._id_FD6E._id_300A["locations"][var_0];

    if(isDefined(self.gender) && issubstr(self.gender, "female") && (var_1 == "radiation" || var_1 == "grease")) {
      wait 0.05;
      continue;
    }

    var_2 = _id_0EFB::_id_EFDB(var_1);

    if(distance2d(var_2.origin, level.player.origin) >= 200.0) {
      if(!scripts\engine\utility::array_contains(level._id_FD6E._id_300A["taken"], var_1)) {
        level._id_FD6E._id_300A["taken"] = ::scripts\engine\utility::array_add(level._id_FD6E._id_300A["taken"], var_1);

        foreach(var_4 in level._id_FD6E._id_300A["locations"]) {
          var_5 = _id_0EFB::_id_EFDB(var_4);

          if(distance2d(var_2.origin, var_5.origin) <= 100.0 && var_4 != var_1) {
            level._id_FD6E._id_300A["taken"] = ::scripts\engine\utility::array_add(level._id_FD6E._id_300A["taken"], var_4);
          }
        }

        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  return var_0;
}

_id_4137(var_0) {
  wait 1.0;
  var_1 = level._id_FD6E._id_300A["locations"][var_0];
  var_2 = _id_0EFB::_id_EFDB(var_1);
  level._id_FD6E._id_300A["taken"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_300A["taken"], var_1);

  foreach(var_4 in level._id_FD6E._id_300A["taken"]) {
    var_5 = _id_0EFB::_id_EFDB(var_4);

    if(distance2d(var_2.origin, var_5.origin) <= 100.0) {
      level._id_FD6E._id_300A["taken"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_300A["taken"], var_4);
    }
  }
}

_id_906A() {
  scripts\engine\utility::flag_clear("allow_bridge_ffa_move");
}

_id_1C3D() {
  scripts\engine\utility::flag_set("allow_bridge_ffa_move");
}
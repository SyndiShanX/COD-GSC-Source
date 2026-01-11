/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3007.gsc
************************/

func_B1C7(param_00, param_01, param_02) {
  lib_0BBC::main(param_00, param_01, param_02);
  func_7598();
  precachemodel("veh_mil_air_un_dropship_seat");
  precachemodel("veh_mil_air_un_dropship_seat_wm");
  setdvarifuninitialized("debug_dropship_lights", 0);
}

func_10A89() {
  waittillframeend;
  self setlightintensity(0);
}

func_5DFE() {
  var_00 = spawnStruct();
  var_00.var_1CCB = [];
  var_00.var_1D34 = [];
  var_00.var_10871 = "_player_dropship";
  var_00.var_1325F = "dropship_player_parts";
  var_00.var_1325C = "col_dropship";
  return var_00;
}

func_106B8(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = gettime();
  if(!isDefined(level.var_5D9A)) {
    level.var_5D9A = [];
  }

  if(!isDefined(param_05)) {
    param_05 = func_5DFE();
  }

  if(!isDefined(level.var_5AFF)) {
    func_5E63();
  }

  if(isDefined(param_00)) {
    var_07 = param_05.var_10871;
    param_05.var_10871 = param_00;
    if(var_07 != param_00) {
      var_08 = getent(var_07, "targetname");
      if(isDefined(var_08)) {
        var_08 delete();
      }
    }
  } else {
    param_00 = param_05.var_10871;
  }

  level.var_5D9A[param_00] = param_05;
  var_09 = undefined;
  var_0A = getEntArray(param_00, "targetname");
  var_0B = var_0A[0];
  if(isDefined(param_03)) {
    param_05.var_1CCB = param_03;
  }

  if(isDefined(param_04)) {
    param_05.var_1D34 = param_04;
  }

  if(isDefined(var_0B.script_noteworthy) && var_0B.script_noteworthy == param_05.var_1325F) {
    var_0B.script_noteworthy = undefined;
  }

  var_0B.var_C1 = 1;
  var_09 = scripts\sp\vehicle_code::func_1444(var_0B);
  param_05.var_1087A = var_0B.origin;
  param_05.var_10875 = var_0B.angles;
  var_09.var_4D94.partnerheli = [];
  var_09.var_4D94.var_10871 = param_00;
  var_09.var_4D94.var_127C9 = [];
  var_09.var_4D94.var_10DED = [];
  var_09.var_4D94.var_421E = [];
  var_09.var_4D94.var_11596 = [];
  var_09.var_4D94.fx = [];
  var_09.var_4D94.fx["cabin_lights"] = [];
  var_09.var_4D94.fx["weapon_lights"] = [];
  var_09.var_4D94.fx["damage"] = [];
  var_09.var_4D94.turrets = [];
  var_09.var_4D94.var_13CC3 = [];
  var_09.var_4D94.var_2E = [];
  var_09.var_4D94.var_C743 = [];
  var_09.var_4D94.var_C744 = [];
  var_09.var_4D94.var_4348 = undefined;
  var_09.var_4D94.var_6A4B = [];
  var_09.var_4D94.var_D30A = undefined;
  var_09.var_4D94.var_1E3D = [];
  var_09.var_4D94.doors = [];
  var_09.var_4D94.var_4D6C = spawnStruct();
  var_09.var_4D94.var_1BE9 = [];
  var_09.var_4D94.var_DE56 = [];
  var_09.var_4D94.lights = [];
  var_09.var_4D94.lights["int"] = [];
  var_09.var_4D94.lights["ext"] = [];
  var_09.var_4D94.var_AC8F = [];
  var_09.var_4D94.var_AC8F["loading"] = "";
  var_09.var_4D94.var_AC8F["tactical"] = "";
  var_09.var_4D94.var_AC8F["emergency"] = "";
  var_09.var_4D94.var_AC8E = [];
  var_09.var_4D94.var_AC8E["loading"] = ::func_F451;
  var_09.var_4D94.var_13060 = [];
  var_09.var_4D94.var_F08B = [];
  var_09.var_4D94.var_F08C = [];
  var_09 scripts\sp\utility::func_65E0("player_in_dropship");
  var_09 scripts\sp\utility::func_65E0("damage_system_active");
  var_09 scripts\sp\utility::func_65E0("player_dropship_ready");
  var_09 scripts\sp\utility::func_65E0("player_dropship_seats_ready");
  foreach(var_10, var_0D in scripts\engine\utility::getstructarray(param_05.var_1325F, "script_noteworthy")) {
    var_0E = var_0D scripts\engine\utility::spawn_tag_origin();
    if(isDefined(var_0D.script_index)) {
      var_0E.script_index = var_0D.script_index;
    }

    if(isDefined(var_0D.var_EE52)) {
      var_0E.var_EE52 = var_0D.var_EE52;
    }

    if(isDefined(var_0D.target)) {
      var_0E.target = var_0D.target;
    }

    if(isDefined(var_0D.var_336)) {
      var_0E.var_336 = var_0D.var_336;
      if(issubstr(var_0E.var_336, "dropship_origin")) {
        if(issubstr(var_0E.var_336, "light")) {
          var_09.var_4D94.var_AD3E = var_0E;
        } else if(issubstr(var_0E.var_336, "reflection")) {
          var_09.var_4D94.var_AD3F = var_0E;
        } else {
          var_09.var_4D94.linkpoint = var_0E;
        }

        continue;
      } else if(issubstr(var_0E.var_336, param_05.var_1325C)) {
        var_09.var_4D94.var_AD3D = var_0E;
        continue;
      } else if(issubstr(var_0E.var_336, "starts")) {
        var_0E.var_981A = var_0E.angles;
        if(isDefined(var_0E.var_EE52)) {
          var_09.var_4D94.var_10DED[var_0E.var_EE52] = var_0E;
        } else if(isDefined(var_0E.script_index)) {
          var_09.var_4D94.var_10DED[var_0E.script_index] = var_0E;
        } else {}
      } else if(issubstr(var_0E.var_336, "ammo_cache_interact")) {
        var_09.var_4D94.var_1E3D = scripts\engine\utility::array_add(var_09.var_4D94.var_1E3D, var_0E);
      } else if(issubstr(var_0E.var_336, "weapon_light")) {
        var_0F = spawnStruct();
        var_0F.var_C264 = var_0E;
        var_0F.physics_setgravitydynentscalar = "tag_origin";
        var_0F.name = "dropship_weapon_light";
        var_09.var_4D94.fx["weapon_lights"] = ::scripts\engine\utility::array_add(var_09.var_4D94.fx["weapon_lights"], var_0F);
      } else if(issubstr(var_0E.var_336, "fx_damage")) {
        var_0F = spawnStruct();
        var_0F.var_C264 = var_0E;
        var_0F.physics_setgravitydynentscalar = "tag_origin";
        if(!isDefined(var_09.var_4D94.fx["damage"][var_0E.var_EE52])) {
          var_09.var_4D94.fx["damage"][var_0E.var_EE52] = [];
        }

        var_09.var_4D94.fx["damage"][var_0E.var_EE52] = ::scripts\engine\utility::array_add(var_09.var_4D94.fx["damage"][var_0E.var_EE52], var_0F);
      } else {
        var_09.var_4D94.var_C743 = scripts\engine\utility::array_add(var_09.var_4D94.var_C743, var_0E);
      }
    } else {
      var_09.var_4D94.var_C743 = scripts\engine\utility::array_add(var_09.var_4D94.var_C743, var_0E);
    }

    var_09.var_4D94.partnerheli = scripts\engine\utility::array_add(var_09.var_4D94.partnerheli, var_0E);
  }

  foreach(var_0D in getEntArray(param_05.var_1325F, "script_noteworthy")) {
    if(issubstr(var_0D.classname, "info_player_start")) {
      continue;
    }

    if(issubstr(var_0D.classname, "trigger")) {
      if(!isDefined(var_0D.var_AD47) || var_0D.var_AD47 == 0) {
        var_0D enablelinkto();
        var_0D _meth_8314();
        var_0D.var_AD47 = 1;
      }

      if(issubstr(var_0D.classname, "flag")) {
        if(isDefined(var_0D.var_ED9A) && !scripts\engine\utility::flag_exist(var_0D.var_ED9A)) {
          scripts\engine\utility::flag_init(var_0D.var_ED9A);
        }
      }

      if(isDefined(var_0D.var_336) && var_0D.var_336 == "player_trig") {
        var_09.var_4D94.var_D30A = var_0D;
      }

      var_09.var_4D94.var_127C9 = scripts\engine\utility::array_add(var_09.var_4D94.var_127C9, var_0D);
    } else if(issubstr(var_0D.classname, "light")) {
      if(var_0D.classname != "info_null") {
        var_09 func_F9C8(var_0D, param_05);
      }
    } else if(issubstr(var_0D.classname, "reflection")) {
      var_09.var_4D94.var_DE56[var_09.var_4D94.var_DE56.size] = var_0D;
    } else if(issubstr(var_0D.classname, "weapon")) {
      var_0D show();
      var_09.var_4D94.var_13CC3 = scripts\engine\utility::array_add(var_09.var_4D94.var_13CC3, var_0D);
    } else if(isDefined(var_0D.script_parameters) && issubstr(var_0D.script_parameters, "extra_collision")) {
      var_0D solid();
      var_09.var_4D94.var_6A4B = scripts\engine\utility::array_add(var_09.var_4D94.var_6A4B, var_0D);
      var_09.var_4D94.var_1BE9 = scripts\engine\utility::array_add(var_09.var_4D94.var_1BE9, var_0D);
    } else if(isDefined(var_0D.var_336)) {
      if(var_0D.var_336 == "delete_on_firstframeend") {
        continue;
      }

      if(issubstr(var_0D.var_336, "col_door")) {
        var_0D solid();
        switch (var_0D.var_336) {
          case "col_door_left":
            var_09.var_4D94.var_5A13.var_4348 = var_0D;
            var_09.var_4D94.var_5A13.var_4348 linkto(var_09, var_09.var_4D94.var_5A13.physics_setgravitydynentscalar);
            var_09.var_4D94.var_5A13.var_4284 = 1;
            break;

          case "col_door_right":
            var_09.var_4D94.var_5A27.var_4348 = var_0D;
            var_09.var_4D94.var_5A27.var_4348 linkto(var_09, var_09.var_4D94.var_5A27.physics_setgravitydynentscalar);
            var_09.var_4D94.var_5A27.var_4284 = 1;
            break;

          case "col_door_back":
            var_09.var_4D94.var_5A01.var_4348 = var_0D;
            var_09.var_4D94.var_5A01.var_4348 linkto(var_09, var_09.var_4D94.var_5A01.physics_setgravitydynentscalar);
            var_09.var_4D94.var_5A01.var_4284 = 1;
            break;

          default:
            break;
        }

        var_09.var_4D94.var_1BE9 = scripts\engine\utility::array_add(var_09.var_4D94.var_1BE9, var_0D);
      } else if(issubstr(var_0D.var_336, param_05.var_1325C) && var_0D.classname == "script_brushmodel") {
        if(isDefined(var_0D.var_EE52) && issubstr(var_0D.var_EE52, "col_seat")) {
          var_12 = strtok(var_0D.var_EE52, "_");
          var_13 = var_12[2] + "_" + var_12[3];
          var_14 = scripts\engine\utility::spawn_tag_origin(var_09 gettagorigin("tag_seat_" + var_13), var_09 gettagangles("tag_seat_" + var_13));
          var_14.var_4348 = var_0D;
          var_0D linkto(var_14);
          var_09.var_4D94.var_F08C[var_13] = var_14;
          var_0D connectpaths();
          var_0D notsolid();
        } else {
          var_09.var_4D94.var_4348 = var_0D;
          var_09.var_4D94.var_4348 solid();
        }

        var_09.var_4D94.var_1BE9 = scripts\engine\utility::array_add(var_09.var_4D94.var_1BE9, var_0D);
      } else if(issubstr(var_0D.var_336, "player_turret")) {
        var_15 = var_0D;
        if(isDefined(var_15.script_parameters)) {
          var_15.name = var_15.script_parameters;
        } else {
          var_15.name = var_15.var_336;
        }

        foreach(var_0E in getEntArray(var_15.target, "targetname")) {
          if(var_0E.var_EE52 == "pos_home") {
            var_15.var_D69D = var_0E;
          } else if(var_0E.var_EE52 == "pos_front") {
            var_15.var_D69C = var_0E;
          } else if(var_0E.var_EE52 == "pos_right") {
            var_15.var_D6A3 = var_0E;
          } else if(var_0E.var_EE52 == "pos_left") {
            var_15.var_D69F = var_0E;
          } else if(var_0E.var_EE52 == "pos_dismount") {
            var_15.var_D69B = var_0E;
          }

          var_0E setModel("tag_origin");
        }

        var_15.var_32D9 = var_15.var_D69B;
        var_15.var_BCDA = var_15.var_D69D scripts\engine\utility::spawn_tag_origin();
        var_15.var_BCDA linkto(var_15.var_D69D, "tag_origin", (0, 0, 0), (0, 0, 0));
        var_15 linkto(var_15.var_BCDA);
        if(!var_15 scripts\sp\utility::func_65DF("ent_flag_turret_detach")) {
          var_15 scripts\sp\utility::func_65E0("ent_flag_turret_detach");
        }

        if(!var_15 scripts\sp\utility::func_65DF("ent_flag_turret_mounted")) {
          var_15 scripts\sp\utility::func_65E0("ent_flag_turret_mounted");
        }

        if(!var_15 scripts\sp\utility::func_65DF("ent_flag_turret_moving")) {
          var_15 scripts\sp\utility::func_65E0("ent_flag_turret_moving");
        }

        var_09.var_4D94.turrets[var_15.name] = var_15;
        var_0D = var_15.var_BCDA;
      } else if(issubstr(var_0D.var_336, "vol_dropship_damage")) {
        var_09.var_4D94.var_4D6C.var_4348 = var_0D;
        var_0D makeentitysentient("allies");
        var_0D setCanDamage(1);
        var_0D setCanRadiusDamage(1);
        if(!threatbiasgroupexists("player_dropship")) {
          createthreatbiasgroup("player_dropship");
        }

        var_0D give_zombies_perk("player_dropship");
      } else {
        var_09.var_4D94.var_C744 = scripts\engine\utility::array_add(var_09.var_4D94.var_C744, var_0D);
      }
    } else {
      var_0D show();
      var_09.var_4D94.var_C744 = scripts\engine\utility::array_add(var_09.var_4D94.var_C744, var_0D);
    }

    if(!isDefined(var_0D.var_336) || !issubstr(var_0D.var_336, "no_link")) {
      var_09.var_4D94.partnerheli = scripts\engine\utility::array_add(var_09.var_4D94.partnerheli, var_0D);
    }
  }

  if(var_09.var_4D94.partnerheli.size == 0) {
    return;
  }

  var_09.var_981A = var_09.var_4D94.linkpoint.angles;
  foreach(var_0D in var_09.var_4D94.partnerheli) {
    if(isDefined(var_09.var_4D94.var_AD3E) && issubstr(var_0D.classname, "light")) {
      var_0D linkto(var_09.var_4D94.var_AD3E);
      continue;
    }

    if(isDefined(var_09.var_4D94.var_AD3F) && issubstr(var_0D.classname, "reflection")) {
      var_0D linkto(var_09.var_4D94.var_AD3F);
      continue;
    }

    if(isDefined(var_09.var_4D94.var_AD3D) && issubstr(var_0D.classname, "script_brushmodel") && isDefined(var_0D.var_336) && var_0D.var_336 == param_05.var_1325C) {
      var_0D linkto(var_09.var_4D94.var_AD3D);
      continue;
    }

    var_0D linkto(var_09.var_4D94.linkpoint);
  }

  var_1B = undefined;
  if(scripts\sp\utility::hastag(var_09.model, "tag_origin")) {
    var_1B = "tag_origin";
  } else {
    var_1B = var_09.model;
  }

  if(isDefined(var_09.var_4D94.var_AD3E)) {
    var_09.var_4D94.var_AD3E linkto(var_09, var_1B, (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(var_09.var_4D94.var_AD3F)) {
    var_09.var_4D94.var_AD3F linkto(var_09, var_1B, (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(var_09.var_4D94.var_AD3D)) {
    var_09.var_4D94.var_AD3D linkto(var_09, var_1B, (0, 0, 0), (0, 0, 0));
  }

  var_09.var_4D94.linkpoint linkto(var_09, var_1B, (0, 0, 0), (0, 0, 0));
  var_09 func_10CB0();
  if(isDefined(var_09.var_4D94.var_4D6C.var_4348)) {
    var_09 func_10C25();
  }

  var_09 scripts\engine\utility::delaythread(0.05, ::func_10C28);
  var_09 thread func_F4B4("straps", "light");
  var_09 scripts\sp\vehicle::playgestureviewmodel();
  var_09 notsolid();
  var_09.var_4D94 thread func_1224(var_09);
  if(isDefined(param_02)) {
    var_09 scripts\engine\utility::delaythread(0.05, ::func_138FB, param_02);
  }

  if(isDefined(param_03)) {
    for(var_1C = 0; var_1C < param_03.size; var_1C++) {
      if(isDefined(param_04) && isDefined(param_04[var_1C])) {
        var_1D = param_04[var_1C];
      } else {
        var_1D = var_09 func_DC9E();
      }

      var_09.var_4D94.var_2E = scripts\engine\utility::array_add(var_09.var_4D94.var_2E, param_03[var_1C]);
      if(isai(param_03[var_1C])) {
        param_03[var_1C] scripts\engine\utility::delaythread(0.05, ::scripts\sp\utility::func_11624, var_09.var_4D94.var_10DED[var_1D]);
      }

      var_09.var_4D94.var_13060[var_1D] = 1;
    }

    wait(0.1);
  }

  if(isDefined(param_01)) {
    var_09 thread func_5EC6(param_01);
  }

  while(gettime() - var_06 == 0) {
    scripts\engine\utility::waitframe();
  }

  var_09 scripts\sp\utility::func_65E1("player_dropship_ready");
  return var_09;
}

func_F9C8(param_00, param_01) {
  if(isDefined(param_00.var_5E34)) {
    return;
  }

  if(!isDefined(param_00.var_EDFF)) {
    return;
  }

  if(!isDefined(param_00.var_EE00)) {
    return;
  }

  param_00.var_5E34 = 0;
  var_02 = tolower(param_00.var_EDFF);
  var_03 = tolower(param_00.var_EE00);
  var_02 = strtok(var_02, " ");
  var_03 = strtok(var_03, " ");
  var_02 = strtok(var_02[0], "_");
  var_03 = strtok(var_03[0], "_");
  var_04 = var_02[0];
  var_05 = var_02[1];
  if(isDefined(self.var_4D94.lights[var_04])) {
    if(!isDefined(self.var_4D94.lights[var_04][var_05])) {
      self.var_4D94.lights[var_04][var_05] = [];
    }

    self.var_4D94.lights[var_04][var_05] = ::scripts\engine\utility::array_add(self.var_4D94.lights[var_04][var_05], param_00);
  }
}

func_106BA(param_00, param_01, param_02, param_03) {
  var_04 = ["left_cockpit", "right_cockpit"];
  var_05 = ["left_01", "left_02", "left_03", "left_04", "left_05", "left_06", "right_01", "right_02", "right_03", "right_04", "right_05", "right_06"];
  var_06 = ["middle_01", "middle_02", "middle_03", "middle_04"];
  foreach(var_08 in var_05) {
    func_106B9(var_08);
  }

  if(isDefined(param_00) && param_00) {
    foreach(var_08 in var_06) {
      func_106B9(var_08, param_02);
    }
  } else if(isDefined(param_02) && param_02) {
    foreach(var_08 in var_06) {
      func_DFFC(var_08);
    }
  }

  if(isDefined(param_01) && param_01) {
    foreach(var_08 in var_04) {
      func_106B9(var_08, param_03);
    }
  } else if(isDefined(param_03) && param_03) {
    foreach(var_08 in var_04) {
      func_DFFC(var_08);
    }
  }

  scripts\sp\utility::func_65E1("player_dropship_seats_ready");
}

func_106B9(param_00, param_01) {
  if(!isDefined(self.var_4D94.var_F08B[param_00])) {
    self.var_4D94.var_F08B[param_00] = spawnStruct();
  }

  var_02 = "tag_seat_" + param_00;
  self.var_4D94.var_F08B[param_00] = ::scripts\sp\utility::func_10639("dropship_seat");
  self.var_4D94.var_F08B[param_00] linkto(self, var_02, (0, 0, 0), (0, 0, 0));
  self.var_4D94.var_F08B[param_00].var_1FBB = "dropship_seat_" + param_00;
  self.var_4D94.var_F08B[param_00] glinton(#animtree);
  if(isDefined(param_01) && param_01) {
    func_DFFC(param_00);
    return;
  }

  if(isDefined(self.var_4D94.var_F08C[param_00])) {
    self.var_4D94.var_F08C[param_00].var_4348 disconnectpaths();
    self.var_4D94.var_F08C[param_00].var_4348 solid();
    self.var_4D94.var_F08C[param_00] linkto(self.var_4D94.var_F08B[param_00], "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

func_DFFC(param_00) {
  if(!isDefined(self.var_4D94.var_F08C[param_00])) {
    return;
  }

  self.var_4D94.var_F08C[param_00].var_4348 delete();
  var_01 = self.var_4D94.var_F08C[param_00];
  self.var_4D94.var_F08C = scripts\sp\utility::func_22B2(self.var_4D94.var_F08C, param_00);
  var_01 delete();
}

func_F37F(param_00) {
  var_01 = func_796D(param_00);
  var_01 setModel("veh_mil_air_un_dropship_seat");
  return var_01;
}

func_796E(param_00) {
  if(isDefined(param_00) && param_00) {
    return getarraykeys(self.var_4D94.var_F08B);
  }

  return self.var_4D94.var_F08B;
}

func_796D(param_00) {
  return self.var_4D94.var_F08B[param_00];
}

func_F596(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = func_796E(1);
  }

  param_01 = scripts\engine\utility::ter_op(isarray(param_01), param_01, [param_01]);
  foreach(var_03 in param_01) {
    var_04 = func_796D(var_03);
    if(isDefined(var_04.var_3748)) {
      self thread[[var_04.var_3748]]();
    }

    switch (param_00) {
      case "on":
        var_04 func_13C5();
        break;

      case "off":
        var_04 func_13C4();
        break;

      case "on_random":
        var_04 scripts\engine\utility::delaythread(randomfloatrange(0, 1), ::func_13C5);
        break;

      default:
        break;
    }
  }
}

func_13C5() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_dsp_screen_glow"), self, "TAG_SCREEN");
}

func_13C4() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_dsp_screen_glow"), self, "TAG_SCREEN");
}

func_5EC1(param_00) {
  param_00 func_414A();
  var_01 = param_00 func_78DC();
  var_01.var_110B9 = 1;
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_02.origin = var_01.var_1087A;
  var_02.angles = var_01.var_10875;
  param_00 giveweaponpassives(param_00.var_4D94.linkpoint, var_02);
  teleportscene();
  var_02 delete();
  scripts\engine\utility::waitframe();
  param_00 delete();
  return var_01;
}

func_5E71(param_00, param_01, param_02, param_03) {
  return func_106B8(param_00.var_10871, param_01, undefined, param_02, param_03, param_00);
}

func_78DC() {
  return level.var_5D9A[self.var_4D94.var_10871];
}

func_5D92(param_00, param_01) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_02 = getent(param_00, "targetname");
  if(isDefined(var_02)) {
    var_02 delete();
  }

  var_03 = getEntArray(param_01, "script_noteworthy");
  var_04 = [];
  foreach(var_06 in var_03) {
    if(isDefined(var_06)) {
      if(issubstr(var_06.classname, "light")) {
        var_06 setlightintensity(0);
      }

      if(issubstr(var_06.classname, "trigger")) {
        var_04[var_04.size] = var_06;
      }

      if(isDefined(var_06.var_EE52) && issubstr(var_06.var_EE52, "col_seat")) {
        var_04[var_04.size] = var_06;
      }
    }
  }

  scripts\sp\utility::func_228A(var_04);
}

func_1224(param_00) {
  param_00 waittill("death");
  var_01 = level.var_5D9A[self.var_10871];
  var_02 = var_01.var_110B9;
  scripts\engine\utility::array_call(self.var_10DED, ::delete);
  self.var_10DED = undefined;
  scripts\sp\utility::func_228A(self.var_421E);
  scripts\sp\utility::func_228A(self.var_11596);
  scripts\sp\utility::func_228A(self.var_C743);
  scripts\sp\utility::func_228A(self.var_9A62);
  func_1243(self.parts);
  func_1243(self.var_F08B);
  func_1243(self.fx);
  func_1243(self.turrets);
  func_1243(self.var_EF3C);
  self.linkpoint delete();
  self.var_2E = undefined;
  func_1243(self.lights);
  if(isDefined(self.var_7333)) {
    self.var_7333 delete();
  }

  if(isDefined(self.var_101B7)) {
    self.var_101B7 delete();
  }

  if(isDefined(self.var_101B6)) {
    self.var_101B6 delete();
  }

  if(isDefined(self.var_10A97)) {
    self.var_10A97 delete();
  }

  if(!isDefined(var_02)) {
    scripts\sp\utility::func_228A(self.var_127C9);
    self.var_4348 notsolid();
    scripts\sp\utility::func_228A(self.var_6A4B);
    self.var_13CC3 = scripts\engine\utility::array_removeundefined(self.var_13CC3);
    scripts\sp\utility::func_228A(self.var_13CC3);
    if(isDefined(self.var_5A13.var_4348)) {
      self.var_5A13.var_4348 notsolid();
    }

    if(isDefined(self.var_5A27.var_4348)) {
      self.var_5A27.var_4348 notsolid();
    }

    if(isDefined(self.var_5A01.var_4348)) {
      self.var_5A01.var_4348 notsolid();
    }

    scripts\sp\utility::func_228A(self.var_C744);
  } else {
    self.var_13CC3 = scripts\engine\utility::array_removeundefined(self.var_13CC3);
    foreach(var_04 in self.var_13CC3) {
      var_04 hide();
    }

    self.var_C744 = scripts\engine\utility::array_removeundefined(self.var_C744);
    foreach(var_07 in self.var_C744) {
      var_07 hide();
    }
  }

  self.partnerheli = undefined;
}

func_1243(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isarray(param_00)) {
    foreach(var_02 in param_00) {
      if(!isDefined(var_02)) {
        continue;
      }

      func_1243(var_02);
    }

    return;
  }

  if(isDefined(param_00.classname) && issubstr(param_00.classname, "light")) {
    param_00 setlightintensity(0);
    return;
  }

  if(isDefined(param_00.var_C264) && !isstruct(param_00.var_C264) && isDefined(param_00.var_C264.model) && param_00.var_C264.model == "tag_origin") {
    param_00.var_C264 delete();
  }

  if(!isstruct(param_00)) {
    param_00 delete();
  }
}

func_1101E(param_00) {
  self notify("stop_monitor_player_in_dropship");
  if(scripts\engine\utility::istrue(level.player._meth_84B1) && isDefined(param_00) && param_00) {
    return;
  }

  level.player setworldupreference(undefined);
}

func_10CB0() {
  thread func_B98D();
}

func_B98D() {
  func_1101E();
  self endon("death");
  self.var_4D94.var_D30A endon("death");
  self endon("stop_monitor_player_in_dropship");
  thread func_11883();
  for(;;) {
    self.var_4D94.var_D30A waittill("trigger", var_00);
    if(var_00 != level.player) {
      continue;
    }

    scripts\sp\utility::func_65E1("player_in_dropship");
    func_B256();
    self notify("player_exited_dropship");
    scripts\sp\utility::func_65DD("player_in_dropship");
  }
}

func_11883() {
  self endon("death");
  self.var_4D94.var_D30A endon("death");
  self endon("stop_thrusters_on_off");
  var_00 = 0;
  for(;;) {
    if(isDefined(self.var_1025A) && self.var_1025A) {
      if(scripts\sp\utility::func_65DB("inside_dropship_disable_effects")) {
        scripts\sp\utility::func_65DD("inside_dropship_disable_effects");
      }

      wait(0.2);
      continue;
    }

    if(level.player istouching(self.var_4D94.var_D30A)) {
      if(!scripts\sp\utility::func_65DB("inside_dropship_disable_effects")) {
        scripts\sp\utility::func_65E1("inside_dropship_disable_effects");
      }
    } else if(scripts\sp\utility::func_65DB("inside_dropship_disable_effects")) {
      scripts\sp\utility::func_65DD("inside_dropship_disable_effects");
    }

    wait(0.2);
  }
}

func_B255() {
  self endon("death");
  self endon("player_exited_dropship");
  level.player setworldupreference(self);
  for(;;) {
    physics_setgravity(anglestoup(self.angles) * -1);
    wait(0.1);
  }
}

func_B256() {
  self endon("death");
  self endon("player_exited_dropship");
  var_00 = 0;
  self.var_4F08 = 0;
  for(;;) {
    var_01 = level.player getmovingplatformparent();
    if(level.player islinked()) {
      var_01 = level.player getlinkedparent();
    }

    if(isDefined(var_01) && doentitiessharehierarchy(var_01, self.var_4D94.var_4348)) {
      break;
    }

    if(self.var_4F08 == 0) {
      self.var_4F08++;
    }

    scripts\engine\utility::waitframe();
  }

  level.player setworldupreference(self.var_4D94.var_4348);
  var_00 = 1;
  for(;;) {
    var_01 = level.player getmovingplatformparent();
    if(!level.player islinked()) {
      if(isDefined(var_01) && doentitiessharehierarchy(var_01, self.var_4D94.var_4348)) {
        if(!var_00) {
          var_00 = 1;
          level.player setworldupreference(self.var_4D94.var_4348);
          var_02 = 0;
        }
      } else if(var_00) {
        var_00 = 0;
        level.player setworldupreference(undefined);
        return;
      }
    }

    wait(0.15);
  }
}

func_D8FB(param_00) {
  var_01 = undefined;
  for(;;) {
    var_01 = param_00 getlinkedparent();
    if(!isDefined(var_01)) {
      return;
    }

    iprintln(var_01.model);
    param_00 = var_01;
    scripts\engine\utility::waitframe();
  }
}

func_10C27() {
  level.var_5D6C endon("stop_dropship_fall_kill");
  level.var_5D6C waittill("player_exited_dropship");
  setomnvar("ui_death_hint", 6);
  scripts\sp\utility::func_B8D1();
}

func_10FE3() {
  level.var_5D6C notify("stop_dropship_fall_kill");
}

func_5E63() {
  level.var_5AFF = 1;
  func_5DFC();
  func_5E98();
  func_5E62();
  func_7598();
}

func_5DFC() {
  level.var_EC85["generic"]["dropship_sit_idle"][0] = % xodus_robot_02_sit_idle;
  level.var_EC85["generic"]["dropship_chair_enter_ai"] = % dropship_chair_enter_ai;
  level.var_EC85["generic"]["dropship_chair_idle_ai"][0] = % dropship_chair_idle_ai;
  level.var_EC85["generic"]["dropship_chair_exit_ai"] = % dropship_chair_exit_ai;
}

func_5E98() {
  level.var_EC87["dropship_seat"] = #animtree;
  level.var_EC8C["dropship_seat"] = "veh_mil_air_un_dropship_seat_wm";
  level.var_EC85["dropship_seat_left_cockpit"]["dropship_chair_enter_ai"] = % dropship_chair_enter_ai_chair;
  level.var_EC85["dropship_seat_right_cockpit"]["dropship_chair_enter_player"] = % dropship_chair_enter_player_chair;
  level.var_EC85["dropship_seat_left_cockpit"]["dropship_chair_exit_ai"] = % dropship_chair_exit_ai_chair;
  level.var_EC85["dropship_seat_right_cockpit"]["dropship_chair_exit_player"] = % dropship_chair_exit_player_chair;
}

func_5E62() {
  level.var_EC85["player_rig"]["dropship_chair_enter_player"] = % dropship_chair_enter_player;
  level.var_EC85["player_rig"]["dropship_chair_idle_player"][0] = % dropship_chair_idle_player;
  level.var_EC85["player_rig"]["dropship_chair_exit_player"] = % dropship_chair_exit_player;
}

func_F452(param_00, param_01) {
  wait(0.1);
  if(!isDefined(self.var_4D94.var_AC8F[param_00])) {
    return;
  }

  if(!isDefined(self.var_4D94.lights["int"][param_01])) {
    return;
  }

  self.var_4D94.var_AC8F[param_00] = param_01;
  if(isDefined(self.var_4D94.var_AC8E[param_00])) {
    self.var_4D94.var_AC8E[param_01] = self.var_4D94.var_AC8E[param_00];
    self.var_4D94.var_AC8E[param_00] = undefined;
  }
}

func_F458(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  func_F456("loading");
  if(!isDefined(param_02) || !param_02) {
    func_F454(0, "ext", "running");
  }

  if(isDefined(param_01)) {
    wait(param_01);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(param_00, "int", "loading");
  if(isDefined(self.var_4D94.var_AC8E["loading"])) {
    thread[[self.var_4D94.var_AC8E["loading"]]](param_00);
  }
}

func_F451(param_00) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  if(param_00) {
    scripts\engine\utility::array_call(getscriptablearray("dropship_cabin_lights_" + self.var_6A0B, "targetname"), ::setscriptablepartstate, "onoff", "on");
    return;
  }

  scripts\engine\utility::array_call(getscriptablearray("dropship_cabin_lights_" + self.var_6A0B, "targetname"), ::setscriptablepartstate, "onoff", "off");
}

func_F459(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  func_F456("tactical");
  func_F454(1, "ext", "running");
  if(isDefined(param_01)) {
    wait(param_01);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(param_00, "int", "tactical");
}

func_F457(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  func_F456("emergency");
  func_F454(1, "ext", "running");
  if(isDefined(param_01)) {
    wait(param_01);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(param_00, "int", "emergency");
}

func_F45A(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(isDefined(param_01)) {
    wait(param_01);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(param_00, "ext", "turbulence");
}

func_F456(param_00) {
  param_00 = scripts\engine\utility::ter_op(!isDefined(param_00), [], param_00);
  param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  foreach(var_02 in getarraykeys(self.var_4D94.lights["int"])) {
    if(param_00.size > 0) {
      if(isDefined(scripts\engine\utility::array_find(param_00, var_02))) {
        continue;
      }
    }

    if(isDefined(self.var_4D94.var_AC8E[var_02])) {
      thread[[self.var_4D94.var_AC8E[var_02]]](0);
    }

    func_F454(0, "int", var_02);
  }

  scripts\engine\utility::waitframe();
}

func_F455(param_00) {
  param_00 = scripts\engine\utility::ter_op(!isDefined(param_00), [], param_00);
  param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  foreach(var_02 in getarraykeys(self.var_4D94.lights["ext"])) {
    if(param_00.size > 0) {
      if(isDefined(scripts\engine\utility::array_find(param_00, var_02))) {
        continue;
      }
    }

    func_F454(0, "ext", var_02);
  }

  scripts\engine\utility::waitframe();
}

func_F454(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  param_01 = tolower(param_01);
  param_02 = tolower(param_02);
  if(isDefined(self.var_4D94.var_AC8F[param_02]) && self.var_4D94.var_AC8F[param_02] != "") {
    param_02 = self.var_4D94.var_AC8F[param_02];
  }

  if(!isDefined(self.var_4D94.lights[param_01][param_02])) {
    return;
  }

  if(param_00) {
    level notify(param_01 + "_" + param_02 + "_on");
    return;
  }

  level notify(param_01 + "_" + param_02 + "_off");
}

func_7A8A() {
  return getarraykeys(self.var_4D94.lights["int"]);
}

func_7A89() {
  return getarraykeys(self.var_4D94.lights["ext"]);
}

func_F453(param_00, param_01, param_02) {
  param_00 = tolower(param_00);
  param_01 = tolower(param_01);
  if(!isDefined(self.var_4D94.lights[param_00][param_01])) {
    return;
  }

  for(var_03 = 0; var_03 < self.var_4D94.lights[param_00][param_01].size; var_03++) {
    self.var_4D94.lights[param_00][param_01][var_03].var_99E6 = self.var_4D94.lights[param_00][param_01][var_03].var_99E6 * param_02;
  }
}

func_4CBD() {
  level.player notifyonplayercommand("int_next", "+actionslot 1");
  level.player notifyonplayercommand("int_prev", "+actionslot 2");
  level.player notifyonplayercommand("ext_next", "+actionslot 3");
  level.player notifyonplayercommand("ext_prev", "+actionslot 4");
  level.var_4B84 = 0;
  level.var_4B73 = 0;
  if(isDefined(self.var_4D94.lights["int"]) && self.var_4D94.lights["int"].size > 0) {
    thread func_4CC3();
    thread func_4CC2();
    thread func_4CBF();
  }

  if(isDefined(self.var_4D94.lights["ext"]) && self.var_4D94.lights["ext"].size > 0) {
    thread func_4CC1();
    thread func_4CC0();
    thread func_4CBE();
  }
}

func_4CC3() {
  var_00 = getarraykeys(self.var_4D94.lights["int"]);
  for(;;) {
    level.player waittill("int_next");
    if(level.var_4B84 < var_00.size - 1) {
      level.var_4B84++;
    } else {
      level.var_4B84 = 0;
    }

    func_F456();
    switch (var_00[level.var_4B84]) {
      case "loading":
        func_F458(1);
        break;

      case "emergency":
        func_F457(1);
        break;

      case "tactical":
        func_F459(1);
        break;

      default:
        func_F454(1, "int", var_00[level.var_4B84]);
        break;
    }
  }
}

func_4CC2() {
  var_00 = getarraykeys(self.var_4D94.lights["int"]);
  for(;;) {
    level.player waittill("int_prev");
    if(level.var_4B84 > 0) {
      level.var_4B84--;
    } else {
      level.var_4B84 = var_00.size - 1;
    }

    func_F456();
    switch (var_00[level.var_4B84]) {
      case "loading":
        func_F458(1);
        break;

      case "emergency":
        func_F457(1);
        break;

      case "tactical":
        func_F459(1);
        break;

      default:
        func_F454(1, "int", var_00[level.var_4B84]);
        break;
    }
  }
}

func_4CC1() {
  var_00 = getarraykeys(self.var_4D94.lights["ext"]);
  for(;;) {
    level.player waittill("ext_next");
    if(level.var_4B73 < var_00.size - 1) {
      level.var_4B73++;
    } else {
      level.var_4B73 = 0;
    }

    func_F455();
    func_F454(1, "ext", var_00[level.var_4B73]);
  }
}

func_4CC0() {
  var_00 = getarraykeys(self.var_4D94.lights["ext"]);
  for(;;) {
    level.player waittill("ext_prev");
    if(level.var_4B73 > 0) {
      level.var_4B73--;
    } else {
      level.var_4B73 = var_00.size - 1;
    }

    func_F455();
    func_F454(1, "ext", var_00[level.var_4B73]);
  }
}

func_4CBF() {
  for(;;) {
    for(;;) {
      if(level.player meleebuttonpressed()) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    func_F456();
    scripts\engine\utility::waitframe();
  }
}

func_4CBE() {
  for(;;) {
    for(;;) {
      if(level.player _meth_8439()) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    func_F455();
    scripts\engine\utility::waitframe();
  }
}

func_138FB(param_00) {
  func_3D6B(param_00);
  level.player setorigin(self.var_4D94.var_10DED[param_00].origin);
  level.player setplayerangles(self.var_4D94.var_10DED[param_00].angles);
  self.var_4D94.var_13060[param_00] = 1;
}

func_DC9E() {
  foreach(var_01 in getarraykeys(self.var_4D94.var_10DED)) {
    if(!isDefined(self.var_4D94.var_10DED[var_01].used)) {
      self.var_4D94.var_10DED[var_01].used = 1;
      return var_01;
    }
  }

  return 0;
}

func_3D6B(param_00) {}

func_796F(param_00) {
  func_3D6B(param_00);
  return self.var_4D94.var_10DED[param_00];
}

func_5EC6(param_00, param_01) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  if(isDefined(param_01)) {
    level.player playerlinktoabsolute(self.var_4D94.var_10DED[param_01], "tag_origin");
    scripts\engine\utility::waitframe();
    level.player unlink();
  }

  var_02 = param_00;
  if(isstring(param_00)) {
    var_02 = func_129F(param_00);
  }

  var_03 = var_02 scripts\engine\utility::spawn_tag_origin();
  self.var_4D94.var_2E = scripts\sp\utility::func_DFEB(self.var_4D94.var_2E);
  foreach(var_05 in self.var_4D94.var_2E) {
    var_05 giveweaponpassives(self, var_03);
  }

  self giveweaponpassives(self, var_03);
  teleportscene();
  scripts\engine\utility::waitframe();
  var_03 delete();
}

func_5E04(param_00, param_01, param_02) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(isstring(param_00)) {
    param_00 = func_129F(param_00);
  } else if(isvector(param_00)) {
    param_00 = scripts\engine\utility::spawn_tag_origin(param_00);
    thread func_11D1(param_00);
  }

  self setvehgoalpos(param_00.origin, param_01);
  if(param_02) {
    var_03 = (0, 0, 0);
    if(isDefined(param_00.angles)) {
      var_03 = param_00.angles;
    }

    func_F37E(var_03[1]);
  }
}

func_11D1(param_00) {
  param_00 endon("death");
  scripts\engine\utility::waittill_any_3("dropship_new_behavior", "newpath", "death");
  param_00 delete();
}

func_5E02(param_00) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  thread func_122E(param_00);
}

func_122E(param_00) {
  var_01 = param_00;
  if(isstring(param_00)) {
    var_01 = func_129F(param_00);
  }

  if(scripts\sp\vehicle::func_9E2C()) {
    scripts\sp\vehicle::func_1321A(var_01);
    self notify("finished_path");
    return;
  }

  scripts\sp\vehicle::func_2471(var_01);
}

func_129F(param_00) {
  var_01 = scripts\engine\utility::getstruct(param_00, "targetname");
  if(!isDefined(var_01)) {
    var_01 = getvehiclenode(param_00, "targetname");
  }

  if(!isDefined(var_01)) {
    var_01 = getent(param_00, "targetname");
  }

  return var_01;
}

func_5DBE(param_00, param_01) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  self endon("dropship_new_behavior");
  var_02 = self.origin + anglesToForward(self.angles) * 1000000;
  self vehicle_setspeed(param_00);
  self setmaxpitchroll(0, 0);
  self setvehgoalpos(var_02);
  if(isDefined(param_01)) {
    wait(param_01);
    self setvehgoalpos(self.origin);
  }
}

func_D118() {
  var_00 = 500;
  if(!isDefined(self.var_A9C7)) {
    self.var_A9C7 = gettime();
  }

  if(level.player istouching(self.var_4D94.var_D30A)) {
    self.var_A9C7 = gettime();
  }

  if(gettime() - self.var_A9C7 >= var_00) {
    return 0;
  }

  return 1;
}

func_F37E(param_00) {
  self notify("stop_lookat");
  self endon("dropship_new_behavior");
  self endon("stop_lookat");
  self endon("death");
  if(isstring(param_00)) {
    param_00 = func_129F(param_00).angles[1];
  }

  childthread func_1234(param_00);
}

func_1234(param_00) {
  for(;;) {
    self settargetyaw(param_00);
    scripts\engine\utility::waitframe();
  }
}

func_F37D(param_00, param_01, param_02, param_03, param_04) {
  self notify("stop_lookat");
  self endon("stop_lookat");
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = "forward";
  }

  var_05 = param_00;
  if(isstring(param_00)) {
    var_05 = func_129F(param_00);
  } else if(isvector(param_00)) {
    var_05 = scripts\engine\utility::spawn_tag_origin(param_00);
    thread func_11D2(var_05);
    var_05 endon("death");
  } else {
    param_00 endon("death");
  }

  var_06 = (0, 0, 0);
  if(isDefined(param_02)) {
    var_06 = anglesToForward(param_00.angles) * param_02;
  }

  var_07 = (0, 0, 0);
  if(isDefined(param_03)) {
    var_07 = anglestoright(param_00.angles) * param_03;
  }

  var_08 = (0, 0, 0);
  if(isDefined(param_04)) {
    var_08 = anglestoup(param_00.angles) * param_04;
  }

  switch (param_01) {
    case "f":
    case "forward":
      break;

    case "l":
    case "left":
      childthread func_1232(var_05, var_06, var_07, var_08);
      break;

    case "r":
    case "right":
      childthread func_1233(var_05, var_06, var_07, var_08);
      break;

    case "b":
    case "back":
      childthread func_1231(var_05, var_06, var_07, var_08);
      break;

    default:
      break;
  }
}

func_1232(param_00, param_01, param_02, param_03) {
  for(;;) {
    self settargetyaw(vectortoangles(anglestoright(vectortoangles(self.origin - param_00.origin + param_01 + param_02 + param_03)) * -1)[1]);
    scripts\engine\utility::waitframe();
  }
}

func_1233(param_00, param_01, param_02, param_03) {
  for(;;) {
    self settargetyaw(vectortoangles(anglestoright(vectortoangles(self.origin - param_00.origin + param_01 + param_02 + param_03)))[1]);
    scripts\engine\utility::waitframe();
  }
}

func_1231(param_00, param_01, param_02, param_03) {
  for(;;) {
    self settargetyaw(vectortoangles(self.origin - param_00.origin + param_01 + param_02 + param_03)[1]);
    scripts\engine\utility::waitframe();
  }
}

func_11D2(param_00) {
  param_00 endon("death");
  scripts\engine\utility::waittill_any_3("stop_lookat", "death");
  param_00 delete();
}

func_414A() {
  self getplayerkillstreakcombatmode();
  if(isDefined(self.var_101B5)) {
    self.var_101B5 unlink();
  }

  self notify("stop_lookat");
}

func_5EBF() {
  self notify("dropship_new_behavior");
  var_00 = self.origin + anglesToForward(self.angles) * self.var_37A * 10;
  self vehicle_setspeed(1);
  self setvehgoalpos(var_00, 1);
}

func_F4B4(param_00, param_01) {
  if(!isDefined(self.var_4D94.parts_map)) {
    self.var_4D94.parts_map = [];
    level.var_EC87["dropship_player_straps"] = #animtree;
    level.var_EC85["dropship_player_straps"]["light0"] = % vh_dropship_strap_idle_light_01;
    level.var_EC85["dropship_player_straps"]["light1"] = % vh_dropship_strap_idle_light_02;
    level.var_EC85["dropship_player_straps"]["heavy0"] = % vh_dropship_strap_idle_heavy_01;
    level.var_EC85["dropship_player_straps"]["heavy1"] = % vh_dropship_strap_idle_heavy_02;
    level.var_EC89["dropship_player_straps"]["light0"] = 1;
    level.var_EC89["dropship_player_straps"]["light1"] = 1;
    level.var_EC89["dropship_player_straps"]["heavy0"] = 1;
    level.var_EC89["dropship_player_straps"]["heavy1"] = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = self.var_4D94.parts_map[param_00];
  }

  self.var_4D94.parts_map[param_00] = param_01;
  foreach(var_03 in self.var_4D94.parts[param_00]) {
    if(!isDefined(var_03.var_92E2)) {
      var_03.var_92E2["light"] = [0, 1];
      var_03.var_92E2["heavy"] = [0, 1];
      var_03.var_92E5["light"] = var_03.var_92E2["light"];
      var_03.var_92E5["heavy"] = var_03.var_92E2["heavy"];
      var_03 scripts\sp\utility::func_23B7("dropship_player_" + param_00);
      var_03.var_92DD = 1;
    }

    var_03.var_1FBD notify("stop_delay_thread");
    if(scripts\engine\utility::istrue(var_03.var_92DD)) {
      var_03.var_1FBD scripts\sp\utility::func_50E4(randomfloatrange(0, 1), ::func_1179, var_03, param_01);
      continue;
    }

    var_03.var_1FBD childthread func_1179(var_03, param_01);
  }
}

func_1179(param_00, param_01) {
  self notify("stop_anim_loop_dropship");
  self endon("stop_anim_loop_dropship");
  param_00 endon("death");
  var_02 = 0.8;
  var_03 = 1.2;
  for(;;) {
    if(param_00.var_92E5[param_01].size == 0) {
      param_00.var_92E5[param_01] = param_00.var_92E2[param_01];
    }

    var_04 = scripts\engine\utility::random(param_00.var_92E5[param_01]);
    param_00.var_92E2 = scripts\sp\utility::array_remove_index(param_00.var_92E2, var_04);
    var_05 = param_01 + var_04;
    var_06 = param_00 scripts\sp\utility::func_7DC1(param_01 + var_04);
    var_07 = 3;
    var_08 = randomfloatrange(var_02, var_03);
    if(param_00.var_92DD) {
      param_00.var_92DD = 0;
      var_07 = 0;
      param_00 animscripted(param_01 + var_04, self.origin, self.angles, var_06);
    } else {
      param_00 setanimknob(var_06, 1, var_07, var_08);
    }

    wait(getanimlength(var_06) - var_07);
  }
}

func_F4B3(param_00, param_01, param_02) {
  foreach(var_04 in self.var_4D94.parts[param_00]) {
    var_04.var_1FBD notify(param_00 + "idle");
    var_04.var_1FBD notify("stop_delay_thread");
    var_04.var_1FBD scripts\sp\anim::func_1F35(var_04, param_01, param_02);
    thread func_F4B4(param_00);
  }
}

func_1237(param_00, param_01) {
  self endon(param_01);
  for(;;) {
    self give_attacker_kill_rewards(param_00, 1);
    wait(getanimlength(param_00));
  }
}

func_10C28(param_00) {
  if(isDefined(param_00)) {
    param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  }

  if(!isDefined(param_00) || !isDefined(param_00[0]) || param_00[0] == "all") {
    param_00 = self.var_4D94.turrets;
  }

  foreach(var_02 in param_00) {
    if(var_02.classname == "script_model") {
      thread func_123F(var_02);
      continue;
    }

    thread func_123E(var_02);
  }
}

func_10FE4(param_00) {
  if(isDefined(param_00)) {
    param_00 = scripts\engine\utility::ter_op(!isarray(param_00), [param_00], param_00);
  }

  if(!isDefined(param_00) || !isDefined(param_00[0]) || param_00[0] == "all") {
    param_00 = self.var_4D94.turrets;
  }

  foreach(var_02 in param_00) {
    var_02 notify("stop_dropship_player_turret_think");
    var_02.var_32D9 lib_0E46::func_DFE3();
  }
}

func_5E6E() {
  foreach(var_01 in self.var_4D94.turrets) {
    thread func_1239(var_01);
  }
}

func_1239(param_00) {
  param_00 scripts\sp\utility::func_65E1("ent_flag_turret_detach");
  if(!param_00 scripts\sp\utility::func_65DB("ent_flag_turret_mounted")) {
    param_00.var_32D9 lib_0E46::func_48C4("tag_origin", (0, 0, 32), 0.25, undefined, undefined, 64);
    param_00.var_32D9 waittill("trigger");
  } else {
    param_00 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
    self notify("off_turret");
    level.player unlink();
    thread func_B98D();
    level.player setorigin(param_00.var_D69B.origin);
    level.player takeallweapons();
    level.player allowcrouch(1);
    level.player allowprone(1);
    level.player notify("ammo_hack_off");
    level.player scripts\sp\utility::func_E2CF("railgun");
    level.player _meth_81DE(level.player.var_C3BF, 1);
  }

  if(level.player hasweapon("iw7_railgunprojectile")) {
    param_00 scripts\sp\utility::func_65DD("ent_flag_turret_detach");
    return;
  }

  param_00 notify("stop_dropship_player_turret_think");
  self.var_4D94.turrets = scripts\engine\utility::array_remove(self.var_4D94.turrets, param_00);
  param_00.var_BCDA delete();
  param_00 delete();
  level.player giveweapon("iw7_railgunprojectile");
  level.player switchtoweaponimmediate("iw7_railgunprojectile");
}

func_123E(param_00) {
  self endon("death");
  param_00 endon("death");
  param_00 notify("stop_dropship_player_turret_think");
  param_00 endon("stop_dropship_player_turret_think");
  level.player notifyonplayercommand("useButton", "+usereload");
  param_00 scripts\sp\utility::func_65DD("ent_flag_turret_moving");
  param_00 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
  param_00 scripts\sp\utility::func_65DD("ent_flag_turret_detach");
  for(;;) {
    param_00 waittill("trigger");
    param_00 scripts\sp\utility::func_65E1("ent_flag_turret_mounted");
    param_00 waittill("turret_deactivate");
    self notify("off_turret");
    level.player setorigin(param_00.var_D69B.origin);
  }
}

func_123F(param_00) {
  self endon("death");
  param_00 notify("stop_dropship_player_turret_think");
  param_00.var_32D9 lib_0E46::func_DFE3();
  param_00 endon("stop_dropship_player_turret_think");
  param_00.var_BCDA endon("death");
  level.player notifyonplayercommand("useButton", "+usereload");
  param_00 scripts\sp\utility::func_65DD("ent_flag_turret_moving");
  param_00 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
  param_00 scripts\sp\utility::func_65DD("ent_flag_turret_detach");
  for(;;) {
    param_00.var_32D9 lib_0E46::func_48C4("tag_origin", (0, 0, 45), 0.25, undefined, undefined, 64);
    param_00.var_32D9 waittill("trigger");
    if(param_00 scripts\sp\utility::func_65DB("ent_flag_turret_detach")) {
      continue;
    }

    param_00 hide();
    func_123A(param_00, 0.25);
    param_00 scripts\sp\utility::func_65E1("ent_flag_turret_mounted");
    level.player scripts\sp\utility::func_110A8("railgun");
    level.player takeallweapons();
    level.player giveweapon("iw7_railgunprojectilehackturret");
    level.player switchtoweaponimmediate("iw7_railgunprojectilehackturret");
    level.player setstance("stand");
    level.player allowcrouch(0);
    level.player allowprone(0);
    level.player childthread func_1E31();
    level.player.var_C3BF = getdvarint("cg_fov");
    level.player _meth_81DE(80, 0.5);
    wait(1);
    while(!level.player usebuttonpressed()) {
      scripts\engine\utility::waitframe();
    }

    param_00 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
    self notify("off_turret");
    level.player unlink();
    thread func_B98D();
    param_00 show();
    level.player setorigin(param_00.var_D69B.origin);
    level.player takeallweapons();
    level.player allowcrouch(1);
    level.player allowprone(1);
    level.player notify("ammo_hack_off");
    level.player scripts\sp\utility::func_E2CF("railgun");
    level.player _meth_81DE(level.player.var_C3BF, 1);
    wait(1);
  }
}

func_1E31() {
  self endon("ammo_hack_off");
  if(!isDefined(self) || self == level || self.var_9F != "player") {
    var_00 = level.player;
  } else {
    var_00 = self;
  }

  for(;;) {
    wait(0.5);
    var_01 = var_00 getcurrentweapon();
    if(var_01 != "none") {
      var_02 = var_00 getfractionmaxammo(var_01);
      if(var_02 < 0.2) {
        var_00 givemaxammo(var_01);
      }
    }

    var_03 = var_00 getcurrentoffhand();
    if(var_03 != "none") {
      var_02 = var_00 getfractionmaxammo(var_03);
      if(var_02 < 0.4) {
        var_00 givemaxammo(var_03);
      }
    }
  }
}

func_123A(param_00, param_01) {
  level.player freezecontrols(1);
  level.player playerlinktoblend(param_00.var_BCDA, "tag_origin", param_01);
  wait(param_01);
  level.player playerlinktodelta(param_00.var_BCDA, "tag_origin", 0, 65, 65, 5, 65);
  level.player freezecontrols(0);
}

func_123B(param_00) {
  self endon("off_turret");
  param_00.var_4B9F = param_00.var_D69D;
  param_00.var_1E77 = 0.5 * scripts\engine\utility::anglebetweenvectors(param_00.var_D69F.origin - param_00.var_D69D.origin, param_00.var_D69C.origin - param_00.var_D69D.origin);
  for(;;) {
    param_00 scripts\sp\utility::func_65E8("ent_flag_turret_moving");
    var_01 = level.player getnormalizedmovement();
    if(param_00.var_4B9F == param_00.var_D69D) {
      if(var_01[0] > 0 && param_00 func_123C(param_00.var_D69C, param_00.var_1E77)) {
        param_00 func_123D(param_00.var_D69C);
      } else if(var_01[0] > 0 && param_00 func_123C(param_00.var_D6A3, param_00.var_1E77)) {
        param_00 func_123D(param_00.var_D6A3);
      } else if(var_01[0] > 0 && param_00 func_123C(param_00.var_D69F, param_00.var_1E77)) {
        param_00 func_123D(param_00.var_D69F);
      }
    } else if(param_00.var_4B9F == param_00.var_D69C) {
      if(var_01[0] < 0) {
        param_00 func_123D(param_00.var_D69D);
      } else if(var_01[1] > 0) {
        param_00 func_123D(param_00.var_D6A3);
      } else if(var_01[1] < 0) {
        param_00 func_123D(param_00.var_D69F);
      } else if(var_01[0] > 0 && param_00 func_123C(param_00.var_D6A3)) {
        param_00 func_123D(param_00.var_D6A3);
      } else if(var_01[0] > 0 && param_00 func_123C(param_00.var_D69F)) {
        param_00 func_123D(param_00.var_D69F);
      }
    } else if(param_00.var_4B9F == param_00.var_D69F) {
      if(var_01[0] < 0) {
        param_00 func_123D(param_00.var_D69D);
      } else if(var_01[1] > 0) {
        param_00 func_123D(param_00.var_D69C);
      } else if(var_01[0] > 0 && param_00 func_123C(param_00.var_D6A3)) {
        param_00 func_123D(param_00.var_D6A3);
      }
    } else if(param_00.var_4B9F == param_00.var_D6A3) {
      if(var_01[0] < 0) {
        param_00 func_123D(param_00.var_D69D);
      } else if(var_01[1] < 0) {
        param_00 func_123D(param_00.var_D69C);
      } else if(var_01[0] > 0 && param_00 func_123C(param_00.var_D69F)) {
        param_00 func_123D(param_00.var_D69F);
      }
    } else {}

    scripts\engine\utility::waitframe();
  }
}

func_123C(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 360;
  }

  var_02 = vectortoangles(param_00.origin - self.var_4B9F.origin);
  var_03 = abs(angleclamp180(level.player.angles[1]) - angleclamp180(var_02[1]));
  if(abs(angleclamp180(level.player.angles[1]) - angleclamp180(var_02[1])) < param_01) {
    return 1;
  }

  return 0;
}

func_123D(param_00) {
  if(self.var_4B9F == param_00) {
    return;
  }

  var_01 = 10;
  scripts\sp\utility::func_65E1("ent_flag_turret_moving");
  level.player lerpviewangleclamp(0.5, 0.5, 0, 0, 0, 0, 0);
  var_02 = 0;
  while(var_02 < 0.55) {
    var_03 = var_02 / 0.5;
    var_04 = 3 * squared(var_03) - 2 * var_03 * var_03 * var_03;
    var_05 = param_00.origin - self.var_4B9F.origin * var_04;
    var_06 = (func_1E7A(0, param_00, var_04), func_1E7A(1, param_00, var_04), func_1E7A(2, param_00, var_04));
    self.var_BCDA.origin = self.var_4B9F.origin + var_05;
    self.var_BCDA.angles = var_06;
    self.var_BCDA linkto(self.var_D69D);
    scripts\engine\utility::waitframe();
    var_02 = var_02 + 0.05;
  }

  level.player lerpviewangleclamp(0, 0, 0, 45, 45, 90, 90);
  self.var_4B9F = param_00;
  scripts\sp\utility::func_65DD("ent_flag_turret_moving");
}

func_1E7A(param_00, param_01, param_02) {
  var_03 = angleclamp(param_01.angles[param_00]) - angleclamp(self.var_4B9F.angles[param_00]) * param_02;
  var_04 = angleclamp(self.var_4B9F.angles[param_00]) + var_03;
  return var_04;
}

func_4F2C(param_00) {
  self endon("death");
  for(;;) {
    if(isDefined(param_00.var_D69D)) {}

    if(isDefined(param_00.var_D69C)) {}

    if(isDefined(param_00.var_D69F)) {}

    if(isDefined(param_00.var_D6A3)) {}

    if(isDefined(param_00.var_D69B)) {}

    if(isDefined(param_00.var_BCDA)) {}

    if(isDefined(param_00.var_32D9)) {}

    scripts\engine\utility::waitframe();
  }
}

func_4ECD(param_00) {
  while(isDefined(self)) {
    if(isDefined(param_00)) {
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_7C3C(param_00) {
  return self.var_4D94.var_F08B[param_00];
}

func_7CA0(param_00) {
  return self.var_4D94.var_10DED[param_00];
}

func_10C25(param_00) {
  self endon("death");
  self notify("stop_dropship_damage_think");
  self endon("stop_dropship_damage_think");
  if(!scripts\sp\utility::func_65DB("damage_system_active")) {
    func_1223();
  }

  childthread func_11C5();
  if(isDefined(self.var_4D94.var_4D6C.var_4348) && !isDefined(param_00) || !param_00) {
    self.var_4D94.var_4D6C.var_4348 childthread func_11BD();
  }

  func_F328("none");
}

func_10FE1() {
  self notify("stop_dropship_damage_think");
  scripts\sp\utility::func_65DD("damage_system_active");
}

func_F328(param_00, param_01) {
  self.var_4D94.var_4D6C.var_BF2E = param_00;
  if(isDefined(param_01) && param_01) {
    self.var_4D94.var_4D6C.var_7258 = 1;
  }

  self notify("change_damage_state");
}

func_CCE4(param_00) {
  if(isarray(param_00)) {
    foreach(var_02 in param_00) {
      thread scripts\engine\utility::play_loop_sound_on_entity(var_02, (0, 0, 128));
      self.var_4D94.var_4D6C.sounds = scripts\engine\utility::array_add(self.var_4D94.var_4D6C.sounds, var_02);
    }

    return;
  }

  thread scripts\engine\utility::play_loop_sound_on_entity(param_00, (0, 0, 128));
  self.var_4D94.var_4D6C.sounds = scripts\engine\utility::array_add(self.var_4D94.var_4D6C.sounds, param_00);
}

func_10FDA() {
  foreach(var_01 in self.var_4D94.var_4D6C.sounds) {
    scripts\engine\utility::stop_loop_sound_on_entity(var_01);
  }

  self.var_4D94.var_4D6C.var_4BB3 = [];
}

func_7598() {
  level._effect["dropship_interior_light_a"] = loadfx("vfx\iw7\_requests\prisoner\pnr_dropship_interior_light_a");
  level._effect["dropship_interior_light_red"] = loadfx("vfx\iw7\_requests\prisoner\pnr_dropship_interior_light_red");
  level._effect["dropship_weapon_light"] = loadfx("vfx\iw7\_requests\prisoner\pnr_dropship_weapon_light_a");
  level._effect["dropship_sparks_a"] = loadfx("vfx\level\las_vegas\vfx_dmg_heli_sparks");
  level._effect["dropship_steam_a"] = loadfx("vfx\iw7\_requests\dropship\dsp_damage_steam");
  level._effect["vfx_dropship_damage_debris_01"] = loadfx("vfx\iw7\core\vehicle\dropship\vfx_dropship_damage_debris_01.vfx");
  level._effect["vfx_dropship_damage_light"] = loadfx("vfx\iw7\core\vehicle\dropship\vfx_dropship_damage_light.vfx");
  level._effect["vfx_dropship_smoke_burst_01"] = loadfx("vfx\iw7\core\vehicle\dropship\vfx_dropship_smoke_burst_01.vfx");
  level._effect["vfx_dropship_smoke_cabin_01"] = loadfx("vfx\iw7\core\vehicle\dropship\vfx_dropship_smoke_cabin_01.vfx");
  level._effect["vfx_dropship_sparks"] = loadfx("vfx\iw7\core\vehicle\dropship\vfx_dropship_sparks.vfx");
  level._effect["vfx_dropship_steamvent"] = loadfx("vfx\iw7\core\vehicle\dropship\vfx_dropship_steamvent.vfx");
  level._effect["vfx_drpshp_reentry"] = loadfx("vfx\iw7\core\vehicle\dropship\reentry\vfx_drpshp_reentry.vfx");
  level._effect["vfx_dsp_screen_glow"] = loadfx("vfx\iw7\core\vehicle\dropship\vfx_dsp_screen_glow.vfx");
}

func_1223() {
  scripts\sp\utility::func_65E1("damage_system_active");
  self.var_4D94.var_4D6C.var_C8 = undefined;
  self.var_4D94.var_4D6C.sounds = [];
  if(!isDefined(self.var_4D94.fx["damage"]["cabin_smoke"])) {
    var_00 = spawnStruct();
    var_00.name = "vfx_dropship_smoke_cabin_01";
    var_00.var_C264 = scripts\engine\utility::spawn_tag_origin();
    var_00.var_C264 linkto(self, "tag_origin", (0, 0, 64), (0, 0, 0));
    var_00.physics_setgravitydynentscalar = "tag_origin";
    self.var_4D94.fx["damage"]["cabin_smoke"] = var_00;
  }
}

func_11BD() {
  var_00 = 100;
  self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
}

func_11C5() {
  for(;;) {
    self waittill("change_damage_state");
    var_00 = self.var_4D94.var_4D6C.var_BF2E;
    if(isDefined(self.var_4D94.var_4D6C.var_7258) && !self.var_4D94.var_4D6C.var_7258 && isDefined(self.var_4D94.var_4D6C.var_C8) && var_00 == self.var_4D94.var_4D6C.var_C8) {
      self.var_4D94.var_4D6C.var_7258 = undefined;
      continue;
    }

    func_10FDD("damage");
    func_10FDD("cabin_lights");
    func_10FDA();
    self.var_4D94.var_4D6C.var_C8 = var_00;
    switch (self.var_4D94.var_4D6C.var_C8) {
      case "none":
        func_11C4();
        break;

      case "low":
        func_11C1();
        break;

      case "medium":
        func_11C2();
        break;

      case "high":
        func_11BF();
        break;

      case "death":
        break;

      default:
        break;
    }

    self notify("change_damage_state_done");
  }
}

func_11C4() {
  func_F459(1);
}

func_11C1() {
  func_F45A(1);
  func_CCEA("damage", "corner", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 15, 100, "dropship_spark_small");
  func_CCEA("damage", "wall", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 15, 100, "dropship_player_glass_crack");
}

func_11C2() {
  func_10FDA();
  func_F457(1);
  childthread func_11C3();
  func_CCEA("damage", "ceiling", "vfx_dropship_steamvent", 5, 30);
  func_CCEA("damage", "floor_temp", "vfx_dropship_smoke_cabin_01", 1);
  func_CCEA("damage", "corner", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 5, 30, "dropship_spark_small");
  func_CCEA("damage", "wall", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 5, 30, "dropship_player_glass_crack");
  func_CCE4("dropship_alarm_damage_1");
}

func_11C3() {
  self endon("change_damage_state");
  for(;;) {
    var_00 = randomfloatrange(0.3, 0.4);
    var_01 = randomfloatrange(0.1, 1);
    var_02 = randomfloatrange(0.1, 0.3);
    level.player _meth_8291(var_02, var_02, var_02, var_01, var_01 * 0.25, var_01 * 0.25, 0, 15, 15, 15);
    wait(var_01);
  }
}

func_11BF() {
  func_10FDA();
  func_F457(1);
  childthread func_11C0();
  for(var_00 = 0; var_00 < 40; var_00++) {
    scripts\engine\utility::delaythread(randomfloat(1), ::func_CCE8, "damage", "ceiling", "vfx_dropship_steamvent");
  }

  func_CCEA("damage", "floor_temp", "vfx_dropship_smoke_cabin_01", 0.25);
  func_CCEA("damage", "corner", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 1, 3, "dropship_player_glass_crack");
  func_CCEA("damage", "wall", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 1, 3, "dropship_spark_small");
  func_CCE4(["dropship_player_damaged_95_percent_alarm", "dropship_player_tube_hiss"]);
}

func_11C0() {
  self endon("change_damage_state");
  for(;;) {
    var_00 = randomfloatrange(0.3, 3);
    var_01 = randomfloatrange(0.1, 1);
    var_02 = randomfloatrange(0.1, 1 * var_00);
    level.player _meth_8291(var_02, var_02, var_02, var_01, var_01 * 0.25, var_01 * 0.25, 0, 15, 15, 15);
    wait(var_01);
  }
}

func_11BE() {
  self endon("change_damage_state");
  for(;;) {
    func_10FDD("cabin_lights");
    func_CCE8("cabin_lights", undefined, "dropship_interior_light_a");
    wait(0.5);
    func_10FDD("cabin_lights");
    func_CCE8("cabin_lights", undefined, ["dropship_interior_light_red", "vfx_dropship_damage_light"]);
    wait(0.5);
  }
}

func_F2CA(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(param_00) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_drpshp_reentry"), self, "tag_origin");
    return;
  }

  if(!param_00) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_drpshp_reentry"), self, "tag_origin");
  }
}

func_CCE8(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  if(isDefined(param_00)) {}

  if(isDefined(param_01)) {}

  if(isDefined(param_01)) {
    func_1244(self.var_4D94.fx[param_00][param_01], ::func_CCE5, param_02, param_03, param_04);
  } else if(isDefined(param_00)) {
    func_1244(self.var_4D94.fx[param_00], ::func_CCE5, param_02, param_03, param_04);
  } else {
    func_1244(self.var_4D94.fx, ::func_CCE5, param_02, param_03, param_04);
  }

  var_05 = 2;
  if(isarray(param_02)) {
    var_05 = param_02.size;
  }

  wait(0.05 * var_05);
}

func_CCE7(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(isDefined(param_00)) {}

  if(isDefined(param_01)) {}

  if(isDefined(param_01)) {
    func_1244(self.var_4D94.fx[param_00][param_01], ::func_CCE6, param_02, param_03);
    return;
  }

  if(isDefined(param_00)) {
    func_1244(self.var_4D94.fx[param_00], ::func_CCE6, param_02, param_03);
    return;
  }

  func_1244(self.var_4D94.fx, ::func_CCE6, param_02, param_03);
}

func_CCE6(param_00, param_01) {
  self endon("death");
  self endon("stop_dps_fx");
  self notify("stop_dps_fx_flicker");
  self endon("stop_dps_fx_flicker");
  if(!isDefined(param_00)) {
    param_00 = 0.05;
  }

  if(!isDefined(param_01)) {
    param_01 = param_00 + 0.05;
  }

  for(;;) {
    wait(randomfloatrange(param_00, param_01));
    func_10FDB(undefined, 1);
    wait(0.1);
    func_CCE5(self.var_4B78);
  }
}

func_CCEA(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  if(isDefined(param_00)) {}

  if(isDefined(param_01)) {}

  if(isDefined(param_01)) {
    func_1244(self.var_4D94.fx[param_00][param_01], ::func_CCE9, param_02, param_03, param_04, param_05, param_06);
    return;
  }

  if(isDefined(param_00)) {
    func_1244(self.var_4D94.fx[param_00], ::func_CCE9, param_02, param_03, param_04, param_05, param_06);
    return;
  }

  func_1244(self.var_4D94.fx, ::func_CCE9, param_02, param_03, param_04, param_05, param_06);
}

func_CCE9(param_00, param_01, param_02, param_03, param_04) {
  var_05 = "";
  if(isDefined(param_00)) {
    if(isarray(param_00)) {
      foreach(var_07 in param_00) {
        var_05 = var_05 + var_07;
      }
    } else {
      var_05 = param_00;
    }
  }

  self endon("death");
  self endon("stop_dps_fx" + var_05);
  self endon("stop_dps_fx");
  self notify("stop_dps_fx_loop");
  self endon("stop_dps_fx_loop");
  if(!isDefined(param_01)) {
    param_01 = 0.05;
  }

  if(!isDefined(param_02)) {
    param_02 = param_01 + 0.05;
  }

  wait(randomfloatrange(0, param_02 * 0.5));
  for(;;) {
    func_CCE5(param_00, param_03, param_04);
    wait(randomfloatrange(param_01, param_02));
  }
}

func_CCE5(param_00, param_01, param_02) {
  self endon("death");
  if(!isDefined(param_00)) {
    param_00 = self.name;
  }

  if(!isDefined(self.var_4B78)) {
    self.var_4B78 = [];
  }

  if(isarray(param_00)) {
    foreach(var_04 in param_00) {
      playFXOnTag(scripts\engine\utility::getfx(var_04), self.var_C264, self.physics_setgravitydynentscalar);
      if(!isDefined(scripts\engine\utility::array_find(self.var_4B78, var_04))) {
        self.var_4B78 = scripts\engine\utility::array_add(self.var_4B78, var_04);
      }

      scripts\engine\utility::waitframe();
    }
  } else {
    playFXOnTag(scripts\engine\utility::getfx(param_00), self.var_C264, self.physics_setgravitydynentscalar);
    if(!isDefined(scripts\engine\utility::array_find(self.var_4B78, param_00))) {
      self.var_4B78 = scripts\engine\utility::array_add(self.var_4B78, param_00);
    }
  }

  if(isDefined(param_01)) {
    var_06 = 0;
    if(isDefined(param_02)) {
      var_06 = 1;
    }

    if(isarray(param_01)) {
      if(var_06) {
        foreach(var_08 in param_01) {
          self.var_C264 childthread scripts\engine\utility::play_loop_sound_on_entity(param_01);
          if(param_02 > 0) {
            self.var_C264 scripts\sp\utility::func_50E4(param_02, ::scripts\engine\utility::stop_loop_sound_on_entity, param_01);
          }
        }

        return;
      }

      foreach(var_08 in param_02) {
        self.var_C264 childthread scripts\sp\utility::play_sound_on_entity(param_01);
      }

      return;
    }

    if(var_0A) {
      self.var_C264 childthread scripts\engine\utility::play_loop_sound_on_entity(var_06);
      if(var_08 > 0) {
        self.var_C264 scripts\sp\utility::func_50E4(var_08, ::scripts\engine\utility::stop_loop_sound_on_entity, var_06);
        return;
      }

      return;
    }

    self.var_C264 childthread scripts\sp\utility::play_sound_on_entity(var_06);
    return;
  }
}

func_10FDD(param_00, param_01, param_02) {
  if(isDefined(param_00)) {}

  if(isDefined(param_01)) {}

  if(isDefined(param_01)) {
    func_1244(self.var_4D94.fx[param_00][param_01], ::func_10FDB, param_02);
  } else if(isDefined(param_00)) {
    func_1244(self.var_4D94.fx[param_00], ::func_10FDB, param_02);
  } else {
    func_1244(self.var_4D94.fx, ::func_10FDB, param_02);
  }

  var_03 = 2;
  if(isarray(param_02)) {
    var_03 = param_02.size;
  }

  wait(0.05 * var_03);
}

func_10FDB(param_00, param_01) {
  var_02 = "";
  if(isDefined(param_00)) {
    if(isarray(param_00)) {
      foreach(var_04 in param_00) {
        var_02 = var_02 + var_04;
      }
    } else {
      var_02 = param_00;
    }
  }

  if(!isDefined(param_01) || !param_01) {
    self notify("stop_dps_fx" + var_02);
  }

  if(!isDefined(param_00)) {
    if(isDefined(self.var_4B78)) {
      foreach(var_07 in self.var_4B78) {
        stopFXOnTag(scripts\engine\utility::getfx(var_07), self.var_C264, self.physics_setgravitydynentscalar);
        scripts\engine\utility::waitframe();
      }
    }

    if(!isDefined(param_01) || !param_01) {
      self.var_4B78 = [];
    }

    return;
  }

  if(isarray(param_00)) {
    foreach(var_0A in param_00) {
      stopFXOnTag(scripts\engine\utility::getfx(var_0A), self.var_C264, self.physics_setgravitydynentscalar);
      if(isDefined(self.var_4B78) && isDefined(scripts\engine\utility::array_find(self.var_4B78, var_0A))) {
        self.var_4B78 = scripts\engine\utility::array_remove(self.var_4B78, var_0A);
      }

      scripts\engine\utility::waitframe();
    }

    return;
  }

  stopFXOnTag(scripts\engine\utility::getfx(param_00), self.var_C264, self.physics_setgravitydynentscalar);
  if(isDefined(self.var_4B78) && isDefined(scripts\engine\utility::array_find(self.var_4B78, param_00))) {
    self.var_4B78 = scripts\engine\utility::array_remove(self.var_4B78, param_00);
  }
}

func_10FDC() {
  self notify("stop_dps_fx_flicker");
}

func_1244(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_00)) {
    return;
  }

  if(isarray(param_00)) {
    foreach(var_0B in param_00) {
      if(!isDefined(var_0B)) {
        continue;
      }

      childthread func_1244(var_0B, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    }

    return;
  }

  if(isDefined(param_09)) {
    param_00 childthread[[param_01]](param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    return;
  }

  if(isDefined(param_08)) {
    param_00 childthread[[param_01]](param_02, param_03, param_04, param_05, param_06, param_07, param_08);
    return;
  }

  if(isDefined(param_07)) {
    param_00 childthread[[param_01]](param_02, param_03, param_04, param_05, param_06, param_07);
    return;
  }

  if(isDefined(param_06)) {
    param_00 childthread[[param_01]](param_02, param_03, param_04, param_05, param_06);
    return;
  }

  if(isDefined(param_05)) {
    param_00 childthread[[param_01]](param_02, param_03, param_04, param_05);
    return;
  }

  if(isDefined(param_04)) {
    param_00 childthread[[param_01]](param_02, param_03, param_04);
    return;
  }

  if(isDefined(param_03)) {
    param_00 childthread[[param_01]](param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    param_00 childthread[[param_01]](param_02);
    return;
  }

  param_00 childthread[[param_01]]();
}

func_11B5() {}
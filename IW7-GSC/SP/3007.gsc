/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3007.gsc
*********************************************/

func_B1C7(var_0, var_1, var_2) {
  lib_0BBC::main(var_0, var_1, var_2);
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
  var_0 = spawnStruct();
  var_0.var_1CCB = [];
  var_0.var_1D34 = [];
  var_0.var_10871 = "_player_dropship";
  var_0.var_1325F = "dropship_player_parts";
  var_0.var_1325C = "col_dropship";
  return var_0;
}

func_106B8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime();
  if(!isDefined(level.var_5D9A)) {
    level.var_5D9A = [];
  }

  if(!isDefined(var_5)) {
    var_5 = func_5DFE();
  }

  if(!isDefined(level.var_5AFF)) {
    func_5E63();
  }

  if(isDefined(var_0)) {
    var_7 = var_5.var_10871;
    var_5.var_10871 = var_0;
    if(var_7 != var_0) {
      var_8 = getent(var_7, "targetname");
      if(isDefined(var_8)) {
        var_8 delete();
      }
    }
  } else {
    var_0 = var_5.var_10871;
  }

  level.var_5D9A[var_0] = var_5;
  var_9 = undefined;
  var_10 = getEntArray(var_0, "targetname");
  var_11 = var_10[0];
  if(isDefined(var_3)) {
    var_5.var_1CCB = var_3;
  }

  if(isDefined(var_4)) {
    var_5.var_1D34 = var_4;
  }

  if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == var_5.var_1325F) {
    var_11.script_noteworthy = undefined;
  }

  var_11.var_C1 = 1;
  var_9 = scripts\sp\vehicle_code::func_1444(var_11);
  var_5.var_1087A = var_11.origin;
  var_5.var_10875 = var_11.angles;
  var_9.var_4D94.partnerheli = [];
  var_9.var_4D94.var_10871 = var_0;
  var_9.var_4D94.var_127C9 = [];
  var_9.var_4D94.var_10DED = [];
  var_9.var_4D94.var_421E = [];
  var_9.var_4D94.var_11596 = [];
  var_9.var_4D94.fx = [];
  var_9.var_4D94.fx["cabin_lights"] = [];
  var_9.var_4D94.fx["weapon_lights"] = [];
  var_9.var_4D94.fx["damage"] = [];
  var_9.var_4D94.turrets = [];
  var_9.var_4D94.var_13CC3 = [];
  var_9.var_4D94.var_2E = [];
  var_9.var_4D94.var_C743 = [];
  var_9.var_4D94.var_C744 = [];
  var_9.var_4D94.var_4348 = undefined;
  var_9.var_4D94.var_6A4B = [];
  var_9.var_4D94.var_D30A = undefined;
  var_9.var_4D94.var_1E3D = [];
  var_9.var_4D94.doors = [];
  var_9.var_4D94.var_4D6C = spawnStruct();
  var_9.var_4D94.var_1BE9 = [];
  var_9.var_4D94.var_DE56 = [];
  var_9.var_4D94.lights = [];
  var_9.var_4D94.lights["int"] = [];
  var_9.var_4D94.lights["ext"] = [];
  var_9.var_4D94.var_AC8F = [];
  var_9.var_4D94.var_AC8F["loading"] = "";
  var_9.var_4D94.var_AC8F["tactical"] = "";
  var_9.var_4D94.var_AC8F["emergency"] = "";
  var_9.var_4D94.var_AC8E = [];
  var_9.var_4D94.var_AC8E["loading"] = ::func_F451;
  var_9.var_4D94.var_13060 = [];
  var_9.var_4D94.var_F08B = [];
  var_9.var_4D94.var_F08C = [];
  var_9 scripts\sp\utility::func_65E0("player_in_dropship");
  var_9 scripts\sp\utility::func_65E0("damage_system_active");
  var_9 scripts\sp\utility::func_65E0("player_dropship_ready");
  var_9 scripts\sp\utility::func_65E0("player_dropship_seats_ready");
  foreach(var_10, var_13 in scripts\engine\utility::getStructArray(var_5.var_1325F, "script_noteworthy")) {
    var_14 = var_13 scripts\engine\utility::spawn_tag_origin();
    if(isDefined(var_13.script_index)) {
      var_14.script_index = var_13.script_index;
    }

    if(isDefined(var_13.var_EE52)) {
      var_14.var_EE52 = var_13.var_EE52;
    }

    if(isDefined(var_13.target)) {
      var_14.target = var_13.target;
    }

    if(isDefined(var_13.var_336)) {
      var_14.var_336 = var_13.var_336;
      if(issubstr(var_14.var_336, "dropship_origin")) {
        if(issubstr(var_14.var_336, "light")) {
          var_9.var_4D94.var_AD3E = var_14;
        } else if(issubstr(var_14.var_336, "reflection")) {
          var_9.var_4D94.var_AD3F = var_14;
        } else {
          var_9.var_4D94.linkpoint = var_14;
        }

        continue;
      } else if(issubstr(var_14.var_336, var_5.var_1325C)) {
        var_9.var_4D94.var_AD3D = var_14;
        continue;
      } else if(issubstr(var_14.var_336, "starts")) {
        var_14.var_981A = var_14.angles;
        if(isDefined(var_14.var_EE52)) {
          var_9.var_4D94.var_10DED[var_14.var_EE52] = var_14;
        } else if(isDefined(var_14.script_index)) {
          var_9.var_4D94.var_10DED[var_14.script_index] = var_14;
        }
      } else if(issubstr(var_14.var_336, "ammo_cache_interact")) {
        var_9.var_4D94.var_1E3D = scripts\engine\utility::array_add(var_9.var_4D94.var_1E3D, var_14);
      } else if(issubstr(var_14.var_336, "weapon_light")) {
        var_15 = spawnStruct();
        var_15.var_C264 = var_14;
        var_15.physics_setgravitydynentscalar = "tag_origin";
        var_15.name = "dropship_weapon_light";
        var_9.var_4D94.fx["weapon_lights"] = ::scripts\engine\utility::array_add(var_9.var_4D94.fx["weapon_lights"], var_15);
      } else if(issubstr(var_14.var_336, "fx_damage")) {
        var_15 = spawnStruct();
        var_15.var_C264 = var_14;
        var_15.physics_setgravitydynentscalar = "tag_origin";
        if(!isDefined(var_9.var_4D94.fx["damage"][var_14.var_EE52])) {
          var_9.var_4D94.fx["damage"][var_14.var_EE52] = [];
        }

        var_9.var_4D94.fx["damage"][var_14.var_EE52] = ::scripts\engine\utility::array_add(var_9.var_4D94.fx["damage"][var_14.var_EE52], var_15);
      } else {
        var_9.var_4D94.var_C743 = scripts\engine\utility::array_add(var_9.var_4D94.var_C743, var_14);
      }
    } else {
      var_9.var_4D94.var_C743 = scripts\engine\utility::array_add(var_9.var_4D94.var_C743, var_14);
    }

    var_9.var_4D94.partnerheli = scripts\engine\utility::array_add(var_9.var_4D94.partnerheli, var_14);
  }

  foreach(var_13 in getEntArray(var_5.var_1325F, "script_noteworthy")) {
    if(issubstr(var_13.classname, "info_player_start")) {
      continue;
    }

    if(issubstr(var_13.classname, "trigger")) {
      if(!isDefined(var_13.var_AD47) || var_13.var_AD47 == 0) {
        var_13 enablelinkto();
        var_13 func_8314();
        var_13.var_AD47 = 1;
      }

      if(issubstr(var_13.classname, "flag")) {
        if(isDefined(var_13.var_ED9A) && !scripts\engine\utility::flag_exist(var_13.var_ED9A)) {
          scripts\engine\utility::flag_init(var_13.var_ED9A);
        }
      }

      if(isDefined(var_13.var_336) && var_13.var_336 == "player_trig") {
        var_9.var_4D94.var_D30A = var_13;
      }

      var_9.var_4D94.var_127C9 = scripts\engine\utility::array_add(var_9.var_4D94.var_127C9, var_13);
    } else if(issubstr(var_13.classname, "light")) {
      if(var_13.classname != "info_null") {
        var_9 func_F9C8(var_13, var_5);
      }
    } else if(issubstr(var_13.classname, "reflection")) {
      var_9.var_4D94.var_DE56[var_9.var_4D94.var_DE56.size] = var_13;
    } else if(issubstr(var_13.classname, "weapon")) {
      var_13 show();
      var_9.var_4D94.var_13CC3 = scripts\engine\utility::array_add(var_9.var_4D94.var_13CC3, var_13);
    } else if(isDefined(var_13.script_parameters) && issubstr(var_13.script_parameters, "extra_collision")) {
      var_13 solid();
      var_9.var_4D94.var_6A4B = scripts\engine\utility::array_add(var_9.var_4D94.var_6A4B, var_13);
      var_9.var_4D94.var_1BE9 = scripts\engine\utility::array_add(var_9.var_4D94.var_1BE9, var_13);
    } else if(isDefined(var_13.var_336)) {
      if(var_13.var_336 == "delete_on_firstframeend") {
        continue;
      }

      if(issubstr(var_13.var_336, "col_door")) {
        var_13 solid();
        switch (var_13.var_336) {
          case "col_door_left":
            var_9.var_4D94.var_5A13.var_4348 = var_13;
            var_9.var_4D94.var_5A13.var_4348 linkto(var_9, var_9.var_4D94.var_5A13.physics_setgravitydynentscalar);
            var_9.var_4D94.var_5A13.var_4284 = 1;
            break;

          case "col_door_right":
            var_9.var_4D94.var_5A27.var_4348 = var_13;
            var_9.var_4D94.var_5A27.var_4348 linkto(var_9, var_9.var_4D94.var_5A27.physics_setgravitydynentscalar);
            var_9.var_4D94.var_5A27.var_4284 = 1;
            break;

          case "col_door_back":
            var_9.var_4D94.var_5A01.var_4348 = var_13;
            var_9.var_4D94.var_5A01.var_4348 linkto(var_9, var_9.var_4D94.var_5A01.physics_setgravitydynentscalar);
            var_9.var_4D94.var_5A01.var_4284 = 1;
            break;

          default:
            break;
        }

        var_9.var_4D94.var_1BE9 = scripts\engine\utility::array_add(var_9.var_4D94.var_1BE9, var_13);
      } else if(issubstr(var_13.var_336, var_5.var_1325C) && var_13.classname == "script_brushmodel") {
        if(isDefined(var_13.var_EE52) && issubstr(var_13.var_EE52, "col_seat")) {
          var_12 = strtok(var_13.var_EE52, "_");
          var_13 = var_12[2] + "_" + var_12[3];
          var_14 = scripts\engine\utility::spawn_tag_origin(var_9 gettagorigin("tag_seat_" + var_13), var_9 gettagangles("tag_seat_" + var_13));
          var_14.var_4348 = var_13;
          var_13 linkto(var_14);
          var_9.var_4D94.var_F08C[var_13] = var_14;
          var_13 connectpaths();
          var_13 notsolid();
        } else {
          var_9.var_4D94.var_4348 = var_13;
          var_9.var_4D94.var_4348 solid();
        }

        var_9.var_4D94.var_1BE9 = scripts\engine\utility::array_add(var_9.var_4D94.var_1BE9, var_13);
      } else if(issubstr(var_13.var_336, "player_turret")) {
        var_15 = var_13;
        if(isDefined(var_15.script_parameters)) {
          var_15.name = var_15.script_parameters;
        } else {
          var_15.name = var_15.var_336;
        }

        foreach(var_14 in getEntArray(var_15.target, "targetname")) {
          if(var_14.var_EE52 == "pos_home") {
            var_15.var_D69D = var_14;
          } else if(var_14.var_EE52 == "pos_front") {
            var_15.var_D69C = var_14;
          } else if(var_14.var_EE52 == "pos_right") {
            var_15.var_D6A3 = var_14;
          } else if(var_14.var_EE52 == "pos_left") {
            var_15.var_D69F = var_14;
          } else if(var_14.var_EE52 == "pos_dismount") {
            var_15.var_D69B = var_14;
          }

          var_14 setModel("tag_origin");
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

        var_9.var_4D94.turrets[var_15.name] = var_15;
        var_13 = var_15.var_BCDA;
      } else if(issubstr(var_13.var_336, "vol_dropship_damage")) {
        var_9.var_4D94.var_4D6C.var_4348 = var_13;
        var_13 makeentitysentient("allies");
        var_13 setCanDamage(1);
        var_13 setCanRadiusDamage(1);
        if(!threatbiasgroupexists("player_dropship")) {
          createthreatbiasgroup("player_dropship");
        }

        var_13 give_zombies_perk("player_dropship");
      } else {
        var_9.var_4D94.var_C744 = scripts\engine\utility::array_add(var_9.var_4D94.var_C744, var_13);
      }
    } else {
      var_13 show();
      var_9.var_4D94.var_C744 = scripts\engine\utility::array_add(var_9.var_4D94.var_C744, var_13);
    }

    if(!isDefined(var_13.var_336) || !issubstr(var_13.var_336, "no_link")) {
      var_9.var_4D94.partnerheli = scripts\engine\utility::array_add(var_9.var_4D94.partnerheli, var_13);
    }
  }

  if(var_9.var_4D94.partnerheli.size == 0) {
    return;
  }

  var_9.var_981A = var_9.var_4D94.linkpoint.angles;
  foreach(var_13 in var_9.var_4D94.partnerheli) {
    if(isDefined(var_9.var_4D94.var_AD3E) && issubstr(var_13.classname, "light")) {
      var_13 linkto(var_9.var_4D94.var_AD3E);
      continue;
    }

    if(isDefined(var_9.var_4D94.var_AD3F) && issubstr(var_13.classname, "reflection")) {
      var_13 linkto(var_9.var_4D94.var_AD3F);
      continue;
    }

    if(isDefined(var_9.var_4D94.var_AD3D) && issubstr(var_13.classname, "script_brushmodel") && isDefined(var_13.var_336) && var_13.var_336 == var_5.var_1325C) {
      var_13 linkto(var_9.var_4D94.var_AD3D);
      continue;
    }

    var_13 linkto(var_9.var_4D94.linkpoint);
  }

  var_1B = undefined;
  if(scripts\sp\utility::hastag(var_9.model, "tag_origin")) {
    var_1B = "tag_origin";
  } else {
    var_1B = var_9.model;
  }

  if(isDefined(var_9.var_4D94.var_AD3E)) {
    var_9.var_4D94.var_AD3E linkto(var_9, var_1B, (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(var_9.var_4D94.var_AD3F)) {
    var_9.var_4D94.var_AD3F linkto(var_9, var_1B, (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(var_9.var_4D94.var_AD3D)) {
    var_9.var_4D94.var_AD3D linkto(var_9, var_1B, (0, 0, 0), (0, 0, 0));
  }

  var_9.var_4D94.linkpoint linkto(var_9, var_1B, (0, 0, 0), (0, 0, 0));
  var_9 func_10CB0();
  if(isDefined(var_9.var_4D94.var_4D6C.var_4348)) {
    var_9 func_10C25();
  }

  var_9 scripts\engine\utility::delaythread(0.05, ::func_10C28);
  var_9 thread func_F4B4("straps", "light");
  var_9 scripts\sp\vehicle::playgestureviewmodel();
  var_9 notsolid();
  var_9.var_4D94 thread func_1224(var_9);
  if(isDefined(var_2)) {
    var_9 scripts\engine\utility::delaythread(0.05, ::func_138FB, var_2);
  }

  if(isDefined(var_3)) {
    for(var_1C = 0; var_1C < var_3.size; var_1C++) {
      if(isDefined(var_4) && isDefined(var_4[var_1C])) {
        var_1D = var_4[var_1C];
      } else {
        var_1D = var_9 func_DC9E();
      }

      var_9.var_4D94.var_2E = scripts\engine\utility::array_add(var_9.var_4D94.var_2E, var_3[var_1C]);
      if(isai(var_3[var_1C])) {
        var_3[var_1C] scripts\engine\utility::delaythread(0.05, scripts\sp\utility::func_11624, var_9.var_4D94.var_10DED[var_1D]);
      }

      var_9.var_4D94.var_13060[var_1D] = 1;
    }

    wait(0.1);
  }

  if(isDefined(var_1)) {
    var_9 thread func_5EC6(var_1);
  }

  while(gettime() - var_6 == 0) {
    scripts\engine\utility::waitframe();
  }

  var_9 scripts\sp\utility::func_65E1("player_dropship_ready");
  return var_9;
}

func_F9C8(var_0, var_1) {
  if(isDefined(var_0.var_5E34)) {
    return;
  }

  if(!isDefined(var_0.var_EDFF)) {
    return;
  }

  if(!isDefined(var_0.var_EE00)) {
    return;
  }

  var_0.var_5E34 = 0;
  var_2 = tolower(var_0.var_EDFF);
  var_3 = tolower(var_0.var_EE00);
  var_2 = strtok(var_2, " ");
  var_3 = strtok(var_3, " ");
  var_2 = strtok(var_2[0], "_");
  var_3 = strtok(var_3[0], "_");
  var_4 = var_2[0];
  var_5 = var_2[1];
  if(isDefined(self.var_4D94.lights[var_4])) {
    if(!isDefined(self.var_4D94.lights[var_4][var_5])) {
      self.var_4D94.lights[var_4][var_5] = [];
    }

    self.var_4D94.lights[var_4][var_5] = ::scripts\engine\utility::array_add(self.var_4D94.lights[var_4][var_5], var_0);
  }
}

func_106BA(var_0, var_1, var_2, var_3) {
  var_4 = ["left_cockpit", "right_cockpit"];
  var_5 = ["left_01", "left_02", "left_03", "left_04", "left_05", "left_06", "right_01", "right_02", "right_03", "right_04", "right_05", "right_06"];
  var_6 = ["middle_01", "middle_02", "middle_03", "middle_04"];
  foreach(var_8 in var_5) {
    func_106B9(var_8);
  }

  if(isDefined(var_0) && var_0) {
    foreach(var_8 in var_6) {
      func_106B9(var_8, var_2);
    }
  } else if(isDefined(var_2) && var_2) {
    foreach(var_8 in var_6) {
      func_DFFC(var_8);
    }
  }

  if(isDefined(var_1) && var_1) {
    foreach(var_8 in var_4) {
      func_106B9(var_8, var_3);
    }
  } else if(isDefined(var_3) && var_3) {
    foreach(var_8 in var_4) {
      func_DFFC(var_8);
    }
  }

  scripts\sp\utility::func_65E1("player_dropship_seats_ready");
}

func_106B9(var_0, var_1) {
  if(!isDefined(self.var_4D94.var_F08B[var_0])) {
    self.var_4D94.var_F08B[var_0] = spawnStruct();
  }

  var_2 = "tag_seat_" + var_0;
  self.var_4D94.var_F08B[var_0] = ::scripts\sp\utility::func_10639("dropship_seat");
  self.var_4D94.var_F08B[var_0] linkto(self, var_2, (0, 0, 0), (0, 0, 0));
  self.var_4D94.var_F08B[var_0].var_1FBB = "dropship_seat_" + var_0;
  self.var_4D94.var_F08B[var_0] glinton(#animtree);
  if(isDefined(var_1) && var_1) {
    func_DFFC(var_0);
    return;
  }

  if(isDefined(self.var_4D94.var_F08C[var_0])) {
    self.var_4D94.var_F08C[var_0].var_4348 disconnectpaths();
    self.var_4D94.var_F08C[var_0].var_4348 solid();
    self.var_4D94.var_F08C[var_0] linkto(self.var_4D94.var_F08B[var_0], "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

func_DFFC(var_0) {
  if(!isDefined(self.var_4D94.var_F08C[var_0])) {
    return;
  }

  self.var_4D94.var_F08C[var_0].var_4348 delete();
  var_1 = self.var_4D94.var_F08C[var_0];
  self.var_4D94.var_F08C = scripts\sp\utility::func_22B2(self.var_4D94.var_F08C, var_0);
  var_1 delete();
}

func_F37F(var_0) {
  var_1 = func_796D(var_0);
  var_1 setModel("veh_mil_air_un_dropship_seat");
  return var_1;
}

func_796E(var_0) {
  if(isDefined(var_0) && var_0) {
    return getarraykeys(self.var_4D94.var_F08B);
  }

  return self.var_4D94.var_F08B;
}

func_796D(var_0) {
  return self.var_4D94.var_F08B[var_0];
}

func_F596(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = func_796E(1);
  }

  var_1 = scripts\engine\utility::ter_op(isarray(var_1), var_1, [var_1]);
  foreach(var_3 in var_1) {
    var_4 = func_796D(var_3);
    if(isDefined(var_4.var_3748)) {
      self thread[[var_4.var_3748]]();
    }

    switch (var_0) {
      case "on":
        var_4 func_13C5();
        break;

      case "off":
        var_4 func_13C4();
        break;

      case "on_random":
        var_4 scripts\engine\utility::delaythread(randomfloatrange(0, 1), ::func_13C5);
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

func_5EC1(var_0) {
  var_0 func_414A();
  var_1 = var_0 func_78DC();
  var_1.var_110B9 = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_1.var_1087A;
  var_2.angles = var_1.var_10875;
  var_0 giveweaponpassives(var_0.var_4D94.linkpoint, var_2);
  teleportscene();
  var_2 delete();
  scripts\engine\utility::waitframe();
  var_0 delete();
  return var_1;
}

func_5E71(var_0, var_1, var_2, var_3) {
  return func_106B8(var_0.var_10871, var_1, undefined, var_2, var_3, var_0);
}

func_78DC() {
  return level.var_5D9A[self.var_4D94.var_10871];
}

func_5D92(var_0, var_1) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_2 = getent(var_0, "targetname");
  if(isDefined(var_2)) {
    var_2 delete();
  }

  var_3 = getEntArray(var_1, "script_noteworthy");
  var_4 = [];
  foreach(var_6 in var_3) {
    if(isDefined(var_6)) {
      if(issubstr(var_6.classname, "light")) {
        var_6 setlightintensity(0);
      }

      if(issubstr(var_6.classname, "trigger")) {
        var_4[var_4.size] = var_6;
      }

      if(isDefined(var_6.var_EE52) && issubstr(var_6.var_EE52, "col_seat")) {
        var_4[var_4.size] = var_6;
      }
    }
  }

  scripts\sp\utility::func_228A(var_4);
}

func_1224(var_0) {
  var_0 waittill("death");
  var_1 = level.var_5D9A[self.var_10871];
  var_2 = var_1.var_110B9;
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

  if(!isDefined(var_2)) {
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
    foreach(var_4 in self.var_13CC3) {
      var_4 hide();
    }

    self.var_C744 = scripts\engine\utility::array_removeundefined(self.var_C744);
    foreach(var_7 in self.var_C744) {
      var_7 hide();
    }
  }

  self.partnerheli = undefined;
}

func_1243(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2)) {
        continue;
      }

      func_1243(var_2);
    }

    return;
  }

  if(isDefined(var_0.classname) && issubstr(var_0.classname, "light")) {
    var_0 setlightintensity(0);
    return;
  }

  if(isDefined(var_0.var_C264) && !isstruct(var_0.var_C264) && isDefined(var_0.var_C264.model) && var_0.var_C264.model == "tag_origin") {
    var_0.var_C264 delete();
  }

  if(!isstruct(var_0)) {
    var_0 delete();
  }
}

func_1101E(var_0) {
  self notify("stop_monitor_player_in_dropship");
  if(scripts\engine\utility::istrue(level.player.func_84B1) && isDefined(var_0) && var_0) {
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
    self.var_4D94.var_D30A waittill("trigger", var_0);
    if(var_0 != level.player) {
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
  var_0 = 0;
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
  var_0 = 0;
  self.var_4F08 = 0;
  for(;;) {
    var_1 = level.player getmovingplatformparent();
    if(level.player islinked()) {
      var_1 = level.player getlinkedparent();
    }

    if(isDefined(var_1) && doentitiessharehierarchy(var_1, self.var_4D94.var_4348)) {
      break;
    }

    if(self.var_4F08 == 0) {
      self.var_4F08++;
    }

    scripts\engine\utility::waitframe();
  }

  level.player setworldupreference(self.var_4D94.var_4348);
  var_0 = 1;
  for(;;) {
    var_1 = level.player getmovingplatformparent();
    if(!level.player islinked()) {
      if(isDefined(var_1) && doentitiessharehierarchy(var_1, self.var_4D94.var_4348)) {
        if(!var_0) {
          var_0 = 1;
          level.player setworldupreference(self.var_4D94.var_4348);
          var_2 = 0;
        }
      } else if(var_0) {
        var_0 = 0;
        level.player setworldupreference(undefined);
        return;
      }
    }

    wait(0.15);
  }
}

func_D8FB(var_0) {
  var_1 = undefined;
  for(;;) {
    var_1 = var_0 getlinkedparent();
    if(!isDefined(var_1)) {
      return;
    }

    iprintln(var_1.model);
    var_0 = var_1;
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

func_F452(var_0, var_1) {
  wait(0.1);
  if(!isDefined(self.var_4D94.var_AC8F[var_0])) {
    return;
  }

  if(!isDefined(self.var_4D94.lights["int"][var_1])) {
    return;
  }

  self.var_4D94.var_AC8F[var_0] = var_1;
  if(isDefined(self.var_4D94.var_AC8E[var_0])) {
    self.var_4D94.var_AC8E[var_1] = self.var_4D94.var_AC8E[var_0];
    self.var_4D94.var_AC8E[var_0] = undefined;
  }
}

func_F458(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  func_F456("loading");
  if(!isDefined(var_2) || !var_2) {
    func_F454(0, "ext", "running");
  }

  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(var_0, "int", "loading");
  if(isDefined(self.var_4D94.var_AC8E["loading"])) {
    thread[[self.var_4D94.var_AC8E["loading"]]](var_0);
  }
}

func_F451(var_0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  if(var_0) {
    scripts\engine\utility::array_call(getscriptablearray("dropship_cabin_lights_" + self.var_6A0B, "targetname"), ::setscriptablepartstate, "onoff", "on");
    return;
  }

  scripts\engine\utility::array_call(getscriptablearray("dropship_cabin_lights_" + self.var_6A0B, "targetname"), ::setscriptablepartstate, "onoff", "off");
}

func_F459(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  func_F456("tactical");
  func_F454(1, "ext", "running");
  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(var_0, "int", "tactical");
}

func_F457(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  func_F456("emergency");
  func_F454(1, "ext", "running");
  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(var_0, "int", "emergency");
}

func_F45A(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    scripts\engine\utility::waitframe();
  }

  func_F454(var_0, "ext", "turbulence");
}

func_F456(var_0) {
  var_0 = scripts\engine\utility::ter_op(!isDefined(var_0), [], var_0);
  var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  foreach(var_2 in getarraykeys(self.var_4D94.lights["int"])) {
    if(var_0.size > 0) {
      if(isDefined(scripts\engine\utility::array_find(var_0, var_2))) {
        continue;
      }
    }

    if(isDefined(self.var_4D94.var_AC8E[var_2])) {
      thread[[self.var_4D94.var_AC8E[var_2]]](0);
    }

    func_F454(0, "int", var_2);
  }

  scripts\engine\utility::waitframe();
}

func_F455(var_0) {
  var_0 = scripts\engine\utility::ter_op(!isDefined(var_0), [], var_0);
  var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  foreach(var_2 in getarraykeys(self.var_4D94.lights["ext"])) {
    if(var_0.size > 0) {
      if(isDefined(scripts\engine\utility::array_find(var_0, var_2))) {
        continue;
      }
    }

    func_F454(0, "ext", var_2);
  }

  scripts\engine\utility::waitframe();
}

func_F454(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = tolower(var_1);
  var_2 = tolower(var_2);
  if(isDefined(self.var_4D94.var_AC8F[var_2]) && self.var_4D94.var_AC8F[var_2] != "") {
    var_2 = self.var_4D94.var_AC8F[var_2];
  }

  if(!isDefined(self.var_4D94.lights[var_1][var_2])) {
    return;
  }

  if(var_0) {
    level notify(var_1 + "_" + var_2 + "_on");
    return;
  }

  level notify(var_1 + "_" + var_2 + "_off");
}

func_7A8A() {
  return getarraykeys(self.var_4D94.lights["int"]);
}

func_7A89() {
  return getarraykeys(self.var_4D94.lights["ext"]);
}

func_F453(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  if(!isDefined(self.var_4D94.lights[var_0][var_1])) {
    return;
  }

  for(var_3 = 0; var_3 < self.var_4D94.lights[var_0][var_1].size; var_3++) {
    self.var_4D94.lights[var_0][var_1][var_3].var_99E6 = self.var_4D94.lights[var_0][var_1][var_3].var_99E6 * var_2;
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
  var_0 = getarraykeys(self.var_4D94.lights["int"]);
  for(;;) {
    level.player waittill("int_next");
    if(level.var_4B84 < var_0.size - 1) {
      level.var_4B84++;
    } else {
      level.var_4B84 = 0;
    }

    func_F456();
    switch (var_0[level.var_4B84]) {
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
        func_F454(1, "int", var_0[level.var_4B84]);
        break;
    }
  }
}

func_4CC2() {
  var_0 = getarraykeys(self.var_4D94.lights["int"]);
  for(;;) {
    level.player waittill("int_prev");
    if(level.var_4B84 > 0) {
      level.var_4B84--;
    } else {
      level.var_4B84 = var_0.size - 1;
    }

    func_F456();
    switch (var_0[level.var_4B84]) {
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
        func_F454(1, "int", var_0[level.var_4B84]);
        break;
    }
  }
}

func_4CC1() {
  var_0 = getarraykeys(self.var_4D94.lights["ext"]);
  for(;;) {
    level.player waittill("ext_next");
    if(level.var_4B73 < var_0.size - 1) {
      level.var_4B73++;
    } else {
      level.var_4B73 = 0;
    }

    func_F455();
    func_F454(1, "ext", var_0[level.var_4B73]);
  }
}

func_4CC0() {
  var_0 = getarraykeys(self.var_4D94.lights["ext"]);
  for(;;) {
    level.player waittill("ext_prev");
    if(level.var_4B73 > 0) {
      level.var_4B73--;
    } else {
      level.var_4B73 = var_0.size - 1;
    }

    func_F455();
    func_F454(1, "ext", var_0[level.var_4B73]);
  }
}

func_4CBF() {
  for(;;) {
    for(;;) {
      if(level.player meleeButtonPressed()) {
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
      if(level.player func_8439()) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    func_F455();
    scripts\engine\utility::waitframe();
  }
}

func_138FB(var_0) {
  func_3D6B(var_0);
  level.player setorigin(self.var_4D94.var_10DED[var_0].origin);
  level.player setplayerangles(self.var_4D94.var_10DED[var_0].angles);
  self.var_4D94.var_13060[var_0] = 1;
}

func_DC9E() {
  foreach(var_1 in getarraykeys(self.var_4D94.var_10DED)) {
    if(!isDefined(self.var_4D94.var_10DED[var_1].used)) {
      self.var_4D94.var_10DED[var_1].used = 1;
      return var_1;
    }
  }

  return 0;
}

func_3D6B(var_0) {}

func_796F(var_0) {
  func_3D6B(var_0);
  return self.var_4D94.var_10DED[var_0];
}

func_5EC6(var_0, var_1) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  if(isDefined(var_1)) {
    level.player playerlinktoabsolute(self.var_4D94.var_10DED[var_1], "tag_origin");
    scripts\engine\utility::waitframe();
    level.player unlink();
  }

  var_2 = var_0;
  if(isstring(var_0)) {
    var_2 = func_129F(var_0);
  }

  var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
  self.var_4D94.var_2E = scripts\sp\utility::func_DFEB(self.var_4D94.var_2E);
  foreach(var_5 in self.var_4D94.var_2E) {
    var_5 giveweaponpassives(self, var_3);
  }

  self giveweaponpassives(self, var_3);
  teleportscene();
  scripts\engine\utility::waitframe();
  var_3 delete();
}

func_5E04(var_0, var_1, var_2) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(isstring(var_0)) {
    var_0 = func_129F(var_0);
  } else if(isvector(var_0)) {
    var_0 = scripts\engine\utility::spawn_tag_origin(var_0);
    thread func_11D1(var_0);
  }

  self setvehgoalpos(var_0.origin, var_1);
  if(var_2) {
    var_3 = (0, 0, 0);
    if(isDefined(var_0.angles)) {
      var_3 = var_0.angles;
    }

    func_F37E(var_3[1]);
  }
}

func_11D1(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any("dropship_new_behavior", "newpath", "death");
  var_0 delete();
}

func_5E02(var_0) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  thread func_122E(var_0);
}

func_122E(var_0) {
  var_1 = var_0;
  if(isstring(var_0)) {
    var_1 = func_129F(var_0);
  }

  if(scripts\sp\vehicle::func_9E2C()) {
    scripts\sp\vehicle::func_1321A(var_1);
    self notify("finished_path");
    return;
  }

  scripts\sp\vehicle::func_2471(var_1);
}

func_129F(var_0) {
  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");
  if(!isDefined(var_1)) {
    var_1 = getvehiclenode(var_0, "targetname");
  }

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "targetname");
  }

  return var_1;
}

func_5DBE(var_0, var_1) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  self endon("dropship_new_behavior");
  var_2 = self.origin + anglesToForward(self.angles) * 1000000;
  self vehicle_setspeed(var_0);
  self setmaxpitchroll(0, 0);
  self setvehgoalpos(var_2);
  if(isDefined(var_1)) {
    wait(var_1);
    self setvehgoalpos(self.origin);
  }
}

func_D118() {
  var_0 = 500;
  if(!isDefined(self.var_A9C7)) {
    self.var_A9C7 = gettime();
  }

  if(level.player istouching(self.var_4D94.var_D30A)) {
    self.var_A9C7 = gettime();
  }

  if(gettime() - self.var_A9C7 >= var_0) {
    return 0;
  }

  return 1;
}

func_F37E(var_0) {
  self notify("stop_lookat");
  self endon("dropship_new_behavior");
  self endon("stop_lookat");
  self endon("death");
  if(isstring(var_0)) {
    var_0 = func_129F(var_0).angles[1];
  }

  childthread func_1234(var_0);
}

func_1234(var_0) {
  for(;;) {
    self settargetyaw(var_0);
    scripts\engine\utility::waitframe();
  }
}

func_F37D(var_0, var_1, var_2, var_3, var_4) {
  self notify("stop_lookat");
  self endon("stop_lookat");
  self endon("death");
  if(!isDefined(var_1)) {
    var_1 = "forward";
  }

  var_5 = var_0;
  if(isstring(var_0)) {
    var_5 = func_129F(var_0);
  } else if(isvector(var_0)) {
    var_5 = scripts\engine\utility::spawn_tag_origin(var_0);
    thread func_11D2(var_5);
    var_5 endon("death");
  } else {
    var_0 endon("death");
  }

  var_6 = (0, 0, 0);
  if(isDefined(var_2)) {
    var_6 = anglesToForward(var_0.angles) * var_2;
  }

  var_7 = (0, 0, 0);
  if(isDefined(var_3)) {
    var_7 = anglestoright(var_0.angles) * var_3;
  }

  var_8 = (0, 0, 0);
  if(isDefined(var_4)) {
    var_8 = anglestoup(var_0.angles) * var_4;
  }

  switch (var_1) {
    case "f":
    case "forward":
      break;

    case "l":
    case "left":
      childthread func_1232(var_5, var_6, var_7, var_8);
      break;

    case "r":
    case "right":
      childthread func_1233(var_5, var_6, var_7, var_8);
      break;

    case "b":
    case "back":
      childthread func_1231(var_5, var_6, var_7, var_8);
      break;

    default:
      break;
  }
}

func_1232(var_0, var_1, var_2, var_3) {
  for(;;) {
    self settargetyaw(vectortoangles(anglestoright(vectortoangles(self.origin - var_0.origin + var_1 + var_2 + var_3)) * -1)[1]);
    scripts\engine\utility::waitframe();
  }
}

func_1233(var_0, var_1, var_2, var_3) {
  for(;;) {
    self settargetyaw(vectortoangles(anglestoright(vectortoangles(self.origin - var_0.origin + var_1 + var_2 + var_3)))[1]);
    scripts\engine\utility::waitframe();
  }
}

func_1231(var_0, var_1, var_2, var_3) {
  for(;;) {
    self settargetyaw(vectortoangles(self.origin - var_0.origin + var_1 + var_2 + var_3)[1]);
    scripts\engine\utility::waitframe();
  }
}

func_11D2(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any("stop_lookat", "death");
  var_0 delete();
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
  var_0 = self.origin + anglesToForward(self.angles) * self.var_37A * 10;
  self vehicle_setspeed(1);
  self setvehgoalpos(var_0, 1);
}

func_F4B4(var_0, var_1) {
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

  if(!isDefined(var_1)) {
    var_1 = self.var_4D94.parts_map[var_0];
  }

  self.var_4D94.parts_map[var_0] = var_1;
  foreach(var_3 in self.var_4D94.parts[var_0]) {
    if(!isDefined(var_3.var_92E2)) {
      var_3.var_92E2["light"] = [0, 1];
      var_3.var_92E2["heavy"] = [0, 1];
      var_3.var_92E5["light"] = var_3.var_92E2["light"];
      var_3.var_92E5["heavy"] = var_3.var_92E2["heavy"];
      var_3 scripts\sp\utility::func_23B7("dropship_player_" + var_0);
      var_3.var_92DD = 1;
    }

    var_3.var_1FBD notify("stop_delay_thread");
    if(scripts\engine\utility::istrue(var_3.var_92DD)) {
      var_3.var_1FBD scripts\sp\utility::func_50E4(randomfloatrange(0, 1), ::func_1179, var_3, var_1);
      continue;
    }

    var_3.var_1FBD childthread func_1179(var_3, var_1);
  }
}

func_1179(var_0, var_1) {
  self notify("stop_anim_loop_dropship");
  self endon("stop_anim_loop_dropship");
  var_0 endon("death");
  var_2 = 0.8;
  var_3 = 1.2;
  for(;;) {
    if(var_0.var_92E5[var_1].size == 0) {
      var_0.var_92E5[var_1] = var_0.var_92E2[var_1];
    }

    var_4 = scripts\engine\utility::random(var_0.var_92E5[var_1]);
    var_0.var_92E2 = scripts\sp\utility::array_remove_index(var_0.var_92E2, var_4);
    var_5 = var_1 + var_4;
    var_6 = var_0 scripts\sp\utility::func_7DC1(var_1 + var_4);
    var_7 = 3;
    var_8 = randomfloatrange(var_2, var_3);
    if(var_0.var_92DD) {
      var_0.var_92DD = 0;
      var_7 = 0;
      var_0 animscripted(var_1 + var_4, self.origin, self.angles, var_6);
    } else {
      var_0 setanimknob(var_6, 1, var_7, var_8);
    }

    wait(getanimlength(var_6) - var_7);
  }
}

func_F4B3(var_0, var_1, var_2) {
  foreach(var_4 in self.var_4D94.parts[var_0]) {
    var_4.var_1FBD notify(var_0 + "idle");
    var_4.var_1FBD notify("stop_delay_thread");
    var_4.var_1FBD scripts\sp\anim::func_1F35(var_4, var_1, var_2);
    thread func_F4B4(var_0);
  }
}

func_1237(var_0, var_1) {
  self endon(var_1);
  for(;;) {
    self give_attacker_kill_rewards(var_0, 1);
    wait(getanimlength(var_0));
  }
}

func_10C28(var_0) {
  if(isDefined(var_0)) {
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  }

  if(!isDefined(var_0) || !isDefined(var_0[0]) || var_0[0] == "all") {
    var_0 = self.var_4D94.turrets;
  }

  foreach(var_2 in var_0) {
    if(var_2.classname == "script_model") {
      thread func_123F(var_2);
      continue;
    }

    thread func_123E(var_2);
  }
}

func_10FE4(var_0) {
  if(isDefined(var_0)) {
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);
  }

  if(!isDefined(var_0) || !isDefined(var_0[0]) || var_0[0] == "all") {
    var_0 = self.var_4D94.turrets;
  }

  foreach(var_2 in var_0) {
    var_2 notify("stop_dropship_player_turret_think");
    var_2.var_32D9 lib_0E46::func_DFE3();
  }
}

func_5E6E() {
  foreach(var_1 in self.var_4D94.turrets) {
    thread func_1239(var_1);
  }
}

func_1239(var_0) {
  var_0 scripts\sp\utility::func_65E1("ent_flag_turret_detach");
  if(!var_0 scripts\sp\utility::func_65DB("ent_flag_turret_mounted")) {
    var_0.var_32D9 lib_0E46::func_48C4("tag_origin", (0, 0, 32), 0.25, undefined, undefined, 64);
    var_0.var_32D9 waittill("trigger");
  } else {
    var_0 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
    self notify("off_turret");
    level.player unlink();
    thread func_B98D();
    level.player setorigin(var_0.var_D69B.origin);
    level.player takeallweapons();
    level.player allowcrouch(1);
    level.player allowprone(1);
    level.player notify("ammo_hack_off");
    level.player scripts\sp\utility::func_E2CF("railgun");
    level.player func_81DE(level.player.var_C3BF, 1);
  }

  if(level.player hasweapon("iw7_railgunprojectile")) {
    var_0 scripts\sp\utility::func_65DD("ent_flag_turret_detach");
    return;
  }

  var_0 notify("stop_dropship_player_turret_think");
  self.var_4D94.turrets = scripts\engine\utility::array_remove(self.var_4D94.turrets, var_0);
  var_0.var_BCDA delete();
  var_0 delete();
  level.player giveweapon("iw7_railgunprojectile");
  level.player switchtoweaponimmediate("iw7_railgunprojectile");
}

func_123E(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 notify("stop_dropship_player_turret_think");
  var_0 endon("stop_dropship_player_turret_think");
  level.player notifyonplayercommand("useButton", "+usereload");
  var_0 scripts\sp\utility::func_65DD("ent_flag_turret_moving");
  var_0 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
  var_0 scripts\sp\utility::func_65DD("ent_flag_turret_detach");
  for(;;) {
    var_0 waittill("trigger");
    var_0 scripts\sp\utility::func_65E1("ent_flag_turret_mounted");
    var_0 waittill("turret_deactivate");
    self notify("off_turret");
    level.player setorigin(var_0.var_D69B.origin);
  }
}

func_123F(var_0) {
  self endon("death");
  var_0 notify("stop_dropship_player_turret_think");
  var_0.var_32D9 lib_0E46::func_DFE3();
  var_0 endon("stop_dropship_player_turret_think");
  var_0.var_BCDA endon("death");
  level.player notifyonplayercommand("useButton", "+usereload");
  var_0 scripts\sp\utility::func_65DD("ent_flag_turret_moving");
  var_0 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
  var_0 scripts\sp\utility::func_65DD("ent_flag_turret_detach");
  for(;;) {
    var_0.var_32D9 lib_0E46::func_48C4("tag_origin", (0, 0, 45), 0.25, undefined, undefined, 64);
    var_0.var_32D9 waittill("trigger");
    if(var_0 scripts\sp\utility::func_65DB("ent_flag_turret_detach")) {
      continue;
    }

    var_0 hide();
    func_123A(var_0, 0.25);
    var_0 scripts\sp\utility::func_65E1("ent_flag_turret_mounted");
    level.player scripts\sp\utility::func_110A8("railgun");
    level.player takeallweapons();
    level.player giveweapon("iw7_railgunprojectilehackturret");
    level.player switchtoweaponimmediate("iw7_railgunprojectilehackturret");
    level.player setstance("stand");
    level.player allowcrouch(0);
    level.player allowprone(0);
    level.player childthread func_1E31();
    level.player.var_C3BF = getdvarint("cg_fov");
    level.player func_81DE(80, 0.5);
    wait(1);
    while(!level.player useButtonPressed()) {
      scripts\engine\utility::waitframe();
    }

    var_0 scripts\sp\utility::func_65DD("ent_flag_turret_mounted");
    self notify("off_turret");
    level.player unlink();
    thread func_B98D();
    var_0 show();
    level.player setorigin(var_0.var_D69B.origin);
    level.player takeallweapons();
    level.player allowcrouch(1);
    level.player allowprone(1);
    level.player notify("ammo_hack_off");
    level.player scripts\sp\utility::func_E2CF("railgun");
    level.player func_81DE(level.player.var_C3BF, 1);
    wait(1);
  }
}

func_1E31() {
  self endon("ammo_hack_off");
  if(!isDefined(self) || self == level || self.var_9F != "player") {
    var_0 = level.player;
  } else {
    var_0 = self;
  }

  for(;;) {
    wait(0.5);
    var_1 = var_0 getcurrentweapon();
    if(var_1 != "none") {
      var_2 = var_0 getfractionmaxammo(var_1);
      if(var_2 < 0.2) {
        var_0 givemaxammo(var_1);
      }
    }

    var_3 = var_0 getcurrentoffhand();
    if(var_3 != "none") {
      var_2 = var_0 getfractionmaxammo(var_3);
      if(var_2 < 0.4) {
        var_0 givemaxammo(var_3);
      }
    }
  }
}

func_123A(var_0, var_1) {
  level.player freezecontrols(1);
  level.player playerlinktoblend(var_0.var_BCDA, "tag_origin", var_1);
  wait(var_1);
  level.player playerlinktodelta(var_0.var_BCDA, "tag_origin", 0, 65, 65, 5, 65);
  level.player freezecontrols(0);
}

func_123B(var_0) {
  self endon("off_turret");
  var_0.var_4B9F = var_0.var_D69D;
  var_0.var_1E77 = 0.5 * scripts\engine\utility::anglebetweenvectors(var_0.var_D69F.origin - var_0.var_D69D.origin, var_0.var_D69C.origin - var_0.var_D69D.origin);
  for(;;) {
    var_0 scripts\sp\utility::func_65E8("ent_flag_turret_moving");
    var_1 = level.player getnormalizedmovement();
    if(var_0.var_4B9F == var_0.var_D69D) {
      if(var_1[0] > 0 && var_0 func_123C(var_0.var_D69C, var_0.var_1E77)) {
        var_0 func_123D(var_0.var_D69C);
      } else if(var_1[0] > 0 && var_0 func_123C(var_0.var_D6A3, var_0.var_1E77)) {
        var_0 func_123D(var_0.var_D6A3);
      } else if(var_1[0] > 0 && var_0 func_123C(var_0.var_D69F, var_0.var_1E77)) {
        var_0 func_123D(var_0.var_D69F);
      }
    } else if(var_0.var_4B9F == var_0.var_D69C) {
      if(var_1[0] < 0) {
        var_0 func_123D(var_0.var_D69D);
      } else if(var_1[1] > 0) {
        var_0 func_123D(var_0.var_D6A3);
      } else if(var_1[1] < 0) {
        var_0 func_123D(var_0.var_D69F);
      } else if(var_1[0] > 0 && var_0 func_123C(var_0.var_D6A3)) {
        var_0 func_123D(var_0.var_D6A3);
      } else if(var_1[0] > 0 && var_0 func_123C(var_0.var_D69F)) {
        var_0 func_123D(var_0.var_D69F);
      }
    } else if(var_0.var_4B9F == var_0.var_D69F) {
      if(var_1[0] < 0) {
        var_0 func_123D(var_0.var_D69D);
      } else if(var_1[1] > 0) {
        var_0 func_123D(var_0.var_D69C);
      } else if(var_1[0] > 0 && var_0 func_123C(var_0.var_D6A3)) {
        var_0 func_123D(var_0.var_D6A3);
      }
    } else if(var_0.var_4B9F == var_0.var_D6A3) {
      if(var_1[0] < 0) {
        var_0 func_123D(var_0.var_D69D);
      } else if(var_1[1] < 0) {
        var_0 func_123D(var_0.var_D69C);
      } else if(var_1[0] > 0 && var_0 func_123C(var_0.var_D69F)) {
        var_0 func_123D(var_0.var_D69F);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_123C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 360;
  }

  var_2 = vectortoangles(var_0.origin - self.var_4B9F.origin);
  var_3 = abs(angleclamp180(level.player.angles[1]) - angleclamp180(var_2[1]));
  if(abs(angleclamp180(level.player.angles[1]) - angleclamp180(var_2[1])) < var_1) {
    return 1;
  }

  return 0;
}

func_123D(var_0) {
  if(self.var_4B9F == var_0) {
    return;
  }

  var_1 = 10;
  scripts\sp\utility::func_65E1("ent_flag_turret_moving");
  level.player lerpviewangleclamp(0.5, 0.5, 0, 0, 0, 0, 0);
  var_2 = 0;
  while(var_2 < 0.55) {
    var_3 = var_2 / 0.5;
    var_4 = 3 * squared(var_3) - 2 * var_3 * var_3 * var_3;
    var_5 = var_0.origin - self.var_4B9F.origin * var_4;
    var_6 = (func_1E7A(0, var_0, var_4), func_1E7A(1, var_0, var_4), func_1E7A(2, var_0, var_4));
    self.var_BCDA.origin = self.var_4B9F.origin + var_5;
    self.var_BCDA.angles = var_6;
    self.var_BCDA linkto(self.var_D69D);
    scripts\engine\utility::waitframe();
    var_2 = var_2 + 0.05;
  }

  level.player lerpviewangleclamp(0, 0, 0, 45, 45, 90, 90);
  self.var_4B9F = var_0;
  scripts\sp\utility::func_65DD("ent_flag_turret_moving");
}

func_1E7A(var_0, var_1, var_2) {
  var_3 = angleclamp(var_1.angles[var_0]) - angleclamp(self.var_4B9F.angles[var_0]) * var_2;
  var_4 = angleclamp(self.var_4B9F.angles[var_0]) + var_3;
  return var_4;
}

func_4F2C(var_0) {
  self endon("death");
  for(;;) {
    if(isDefined(var_0.var_D69D)) {}

    if(isDefined(var_0.var_D69C)) {}

    if(isDefined(var_0.var_D69F)) {}

    if(isDefined(var_0.var_D6A3)) {}

    if(isDefined(var_0.var_D69B)) {}

    if(isDefined(var_0.var_BCDA)) {}

    if(isDefined(var_0.var_32D9)) {}

    scripts\engine\utility::waitframe();
  }
}

func_4ECD(var_0) {
  while(isDefined(self)) {
    if(isDefined(var_0)) {
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_7C3C(var_0) {
  return self.var_4D94.var_F08B[var_0];
}

func_7CA0(var_0) {
  return self.var_4D94.var_10DED[var_0];
}

func_10C25(var_0) {
  self endon("death");
  self notify("stop_dropship_damage_think");
  self endon("stop_dropship_damage_think");
  if(!scripts\sp\utility::func_65DB("damage_system_active")) {
    func_1223();
  }

  childthread func_11C5();
  if(isDefined(self.var_4D94.var_4D6C.var_4348) && !isDefined(var_0) || !var_0) {
    self.var_4D94.var_4D6C.var_4348 childthread func_11BD();
  }

  func_F328("none");
}

func_10FE1() {
  self notify("stop_dropship_damage_think");
  scripts\sp\utility::func_65DD("damage_system_active");
}

func_F328(var_0, var_1) {
  self.var_4D94.var_4D6C.var_BF2E = var_0;
  if(isDefined(var_1) && var_1) {
    self.var_4D94.var_4D6C.var_7258 = 1;
  }

  self notify("change_damage_state");
}

func_CCE4(var_0) {
  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      thread scripts\engine\utility::play_loop_sound_on_entity(var_2, (0, 0, 128));
      self.var_4D94.var_4D6C.sounds = scripts\engine\utility::array_add(self.var_4D94.var_4D6C.sounds, var_2);
    }

    return;
  }

  thread scripts\engine\utility::play_loop_sound_on_entity(var_0, (0, 0, 128));
  self.var_4D94.var_4D6C.sounds = scripts\engine\utility::array_add(self.var_4D94.var_4D6C.sounds, var_0);
}

func_10FDA() {
  foreach(var_1 in self.var_4D94.var_4D6C.sounds) {
    scripts\engine\utility::stop_loop_sound_on_entity(var_1);
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
    var_0 = spawnStruct();
    var_0.name = "vfx_dropship_smoke_cabin_01";
    var_0.var_C264 = scripts\engine\utility::spawn_tag_origin();
    var_0.var_C264 linkto(self, "tag_origin", (0, 0, 64), (0, 0, 0));
    var_0.physics_setgravitydynentscalar = "tag_origin";
    self.var_4D94.fx["damage"]["cabin_smoke"] = var_0;
  }
}

func_11BD() {
  var_0 = 100;
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

func_11C5() {
  for(;;) {
    self waittill("change_damage_state");
    var_0 = self.var_4D94.var_4D6C.var_BF2E;
    if(isDefined(self.var_4D94.var_4D6C.var_7258) && !self.var_4D94.var_4D6C.var_7258 && isDefined(self.var_4D94.var_4D6C.var_C8) && var_0 == self.var_4D94.var_4D6C.var_C8) {
      self.var_4D94.var_4D6C.var_7258 = undefined;
      continue;
    }

    func_10FDD("damage");
    func_10FDD("cabin_lights");
    func_10FDA();
    self.var_4D94.var_4D6C.var_C8 = var_0;
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
    var_0 = randomfloatrange(0.3, 0.4);
    var_1 = randomfloatrange(0.1, 1);
    var_2 = randomfloatrange(0.1, 0.3);
    level.player func_8291(var_2, var_2, var_2, var_1, var_1 * 0.25, var_1 * 0.25, 0, 15, 15, 15);
    wait(var_1);
  }
}

func_11BF() {
  func_10FDA();
  func_F457(1);
  childthread func_11C0();
  for(var_0 = 0; var_0 < 40; var_0++) {
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
    var_0 = randomfloatrange(0.3, 3);
    var_1 = randomfloatrange(0.1, 1);
    var_2 = randomfloatrange(0.1, 1 * var_0);
    level.player func_8291(var_2, var_2, var_2, var_1, var_1 * 0.25, var_1 * 0.25, 0, 15, 15, 15);
    wait(var_1);
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

func_F2CA(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_drpshp_reentry"), self, "tag_origin");
    return;
  }

  if(!var_0) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_drpshp_reentry"), self, "tag_origin");
  }
}

func_CCE8(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1)) {
    func_1244(self.var_4D94.fx[var_0][var_1], ::func_CCE5, var_2, var_3, var_4);
  } else if(isDefined(var_0)) {
    func_1244(self.var_4D94.fx[var_0], ::func_CCE5, var_2, var_3, var_4);
  } else {
    func_1244(self.var_4D94.fx, ::func_CCE5, var_2, var_3, var_4);
  }

  var_5 = 2;
  if(isarray(var_2)) {
    var_5 = var_2.size;
  }

  wait(0.05 * var_5);
}

func_CCE7(var_0, var_1, var_2, var_3) {
  self endon("death");
  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1)) {
    func_1244(self.var_4D94.fx[var_0][var_1], ::func_CCE6, var_2, var_3);
    return;
  }

  if(isDefined(var_0)) {
    func_1244(self.var_4D94.fx[var_0], ::func_CCE6, var_2, var_3);
    return;
  }

  func_1244(self.var_4D94.fx, ::func_CCE6, var_2, var_3);
}

func_CCE6(var_0, var_1) {
  self endon("death");
  self endon("stop_dps_fx");
  self notify("stop_dps_fx_flicker");
  self endon("stop_dps_fx_flicker");
  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0 + 0.05;
  }

  for(;;) {
    wait(randomfloatrange(var_0, var_1));
    func_10FDB(undefined, 1);
    wait(0.1);
    func_CCE5(self.var_4B78);
  }
}

func_CCEA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1)) {
    func_1244(self.var_4D94.fx[var_0][var_1], ::func_CCE9, var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_0)) {
    func_1244(self.var_4D94.fx[var_0], ::func_CCE9, var_2, var_3, var_4, var_5, var_6);
    return;
  }

  func_1244(self.var_4D94.fx, ::func_CCE9, var_2, var_3, var_4, var_5, var_6);
}

func_CCE9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "";
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_7 in var_0) {
        var_5 = var_5 + var_7;
      }
    } else {
      var_5 = var_0;
    }
  }

  self endon("death");
  self endon("stop_dps_fx" + var_5);
  self endon("stop_dps_fx");
  self notify("stop_dps_fx_loop");
  self endon("stop_dps_fx_loop");
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_2)) {
    var_2 = var_1 + 0.05;
  }

  wait(randomfloatrange(0, var_2 * 0.5));
  for(;;) {
    func_CCE5(var_0, var_3, var_4);
    wait(randomfloatrange(var_1, var_2));
  }
}

func_CCE5(var_0, var_1, var_2) {
  self endon("death");
  if(!isDefined(var_0)) {
    var_0 = self.name;
  }

  if(!isDefined(self.var_4B78)) {
    self.var_4B78 = [];
  }

  if(isarray(var_0)) {
    foreach(var_4 in var_0) {
      playFXOnTag(scripts\engine\utility::getfx(var_4), self.var_C264, self.physics_setgravitydynentscalar);
      if(!isDefined(scripts\engine\utility::array_find(self.var_4B78, var_4))) {
        self.var_4B78 = scripts\engine\utility::array_add(self.var_4B78, var_4);
      }

      scripts\engine\utility::waitframe();
    }
  } else {
    playFXOnTag(scripts\engine\utility::getfx(var_0), self.var_C264, self.physics_setgravitydynentscalar);
    if(!isDefined(scripts\engine\utility::array_find(self.var_4B78, var_0))) {
      self.var_4B78 = scripts\engine\utility::array_add(self.var_4B78, var_0);
    }
  }

  if(isDefined(var_1)) {
    var_6 = 0;
    if(isDefined(var_2)) {
      var_6 = 1;
    }

    if(isarray(var_1)) {
      if(var_6) {
        foreach(var_8 in var_1) {
          self.var_C264 childthread scripts\engine\utility::play_loop_sound_on_entity(var_1);
          if(var_2 > 0) {
            self.var_C264 scripts\sp\utility::func_50E4(var_2, scripts\engine\utility::stop_loop_sound_on_entity, var_1);
          }
        }

        return;
      }

      foreach(var_8 in var_2) {
        self.var_C264 childthread scripts\sp\utility::play_sound_on_entity(var_1);
      }

      return;
    }

    if(var_10) {
      self.var_C264 childthread scripts\engine\utility::play_loop_sound_on_entity(var_6);
      if(var_8 > 0) {
        self.var_C264 scripts\sp\utility::func_50E4(var_8, scripts\engine\utility::stop_loop_sound_on_entity, var_6);
        return;
      }

      return;
    }

    self.var_C264 childthread scripts\sp\utility::play_sound_on_entity(var_6);
    return;
  }
}

func_10FDD(var_0, var_1, var_2) {
  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1)) {
    func_1244(self.var_4D94.fx[var_0][var_1], ::func_10FDB, var_2);
  } else if(isDefined(var_0)) {
    func_1244(self.var_4D94.fx[var_0], ::func_10FDB, var_2);
  } else {
    func_1244(self.var_4D94.fx, ::func_10FDB, var_2);
  }

  var_3 = 2;
  if(isarray(var_2)) {
    var_3 = var_2.size;
  }

  wait(0.05 * var_3);
}

func_10FDB(var_0, var_1) {
  var_2 = "";
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_4 in var_0) {
        var_2 = var_2 + var_4;
      }
    } else {
      var_2 = var_0;
    }
  }

  if(!isDefined(var_1) || !var_1) {
    self notify("stop_dps_fx" + var_2);
  }

  if(!isDefined(var_0)) {
    if(isDefined(self.var_4B78)) {
      foreach(var_7 in self.var_4B78) {
        stopFXOnTag(scripts\engine\utility::getfx(var_7), self.var_C264, self.physics_setgravitydynentscalar);
        scripts\engine\utility::waitframe();
      }
    }

    if(!isDefined(var_1) || !var_1) {
      self.var_4B78 = [];
    }

    return;
  }

  if(isarray(var_0)) {
    foreach(var_10 in var_0) {
      stopFXOnTag(scripts\engine\utility::getfx(var_10), self.var_C264, self.physics_setgravitydynentscalar);
      if(isDefined(self.var_4B78) && isDefined(scripts\engine\utility::array_find(self.var_4B78, var_10))) {
        self.var_4B78 = scripts\engine\utility::array_remove(self.var_4B78, var_10);
      }

      scripts\engine\utility::waitframe();
    }

    return;
  }

  stopFXOnTag(scripts\engine\utility::getfx(var_0), self.var_C264, self.physics_setgravitydynentscalar);
  if(isDefined(self.var_4B78) && isDefined(scripts\engine\utility::array_find(self.var_4B78, var_0))) {
    self.var_4B78 = scripts\engine\utility::array_remove(self.var_4B78, var_0);
  }
}

func_10FDC() {
  self notify("stop_dps_fx_flicker");
}

func_1244(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isarray(var_0)) {
    foreach(var_11 in var_0) {
      if(!isDefined(var_11)) {
        continue;
      }

      childthread func_1244(var_11, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    return;
  }

  if(isDefined(var_9)) {
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    return;
  }

  if(isDefined(var_8)) {
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    return;
  }

  if(isDefined(var_7)) {
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
    return;
  }

  if(isDefined(var_6)) {
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_5)) {
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    var_0 childthread[[var_1]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    var_0 childthread[[var_1]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    var_0 childthread[[var_1]](var_2);
    return;
  }

  var_0 childthread[[var_1]]();
}

func_11B5() {}
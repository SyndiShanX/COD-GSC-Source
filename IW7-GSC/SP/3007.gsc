/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3007.gsc
**************************************/

_id_B1C7(var_0, var_1, var_2) {
  _id_0BBC::main(var_0, var_1, var_2);
  _id_7598();
  precachemodel("veh_mil_air_un_dropship_seat");
  precachemodel("veh_mil_air_un_dropship_seat_wm");
  setdvarifuninitialized("debug_dropship_lights", 0);
}

_id_10A89() {
  waittillframeend;
  self setlightintensity(0);
}

_id_5DFE() {
  var_0 = spawnStruct();
  var_0._id_1CCB = [];
  var_0._id_1D34 = [];
  var_0._id_10871 = "_player_dropship";
  var_0._id_1325F = "dropship_player_parts";
  var_0._id_1325C = "col_dropship";
  return var_0;
}

_id_106B8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime();

  if(!isDefined(level._id_5D9A))
    level._id_5D9A = [];

  if(!isDefined(var_5))
    var_5 = _id_5DFE();

  if(!isDefined(level._id_5AFF))
    _id_5E63();

  if(isDefined(var_0)) {
    var_7 = var_5._id_10871;
    var_5._id_10871 = var_0;

    if(var_7 != var_0) {
      var_8 = getEnt(var_7, "targetname");

      if(isDefined(var_8))
        var_8 delete();
    }
  } else
    var_0 = var_5._id_10871;

  level._id_5D9A[var_0] = var_5;
  var_9 = undefined;
  var_10 = getEntArray(var_0, "targetname");
  var_11 = var_10[0];

  if(isDefined(var_3))
    var_5._id_1CCB = var_3;

  if(isDefined(var_4))
    var_5._id_1D34 = var_4;

  if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == var_5._id_1325F)
    var_11.script_noteworthy = undefined;

  var_11.count = 1;
  var_9 = scripts\sp\vehicle_code::_id_1444(var_11);
  var_5._id_1087A = var_11.origin;
  var_5._id_10875 = var_11.angles;
  var_9._id_4D94.partnerheli = [];
  var_9._id_4D94._id_10871 = var_0;
  var_9._id_4D94._id_127C9 = [];
  var_9._id_4D94._id_10DED = [];
  var_9._id_4D94._id_421E = [];
  var_9._id_4D94._id_11596 = [];
  var_9._id_4D94.fx = [];
  var_9._id_4D94.fx["cabin_lights"] = [];
  var_9._id_4D94.fx["weapon_lights"] = [];
  var_9._id_4D94.fx["damage"] = [];
  var_9._id_4D94.turrets = [];
  var_9._id_4D94._id_13CC3 = [];
  var_9._id_4D94.allies = [];
  var_9._id_4D94._id_C743 = [];
  var_9._id_4D94._id_C744 = [];
  var_9._id_4D94._id_4348 = undefined;
  var_9._id_4D94._id_6A4B = [];
  var_9._id_4D94._id_D30A = undefined;
  var_9._id_4D94._id_1E3D = [];
  var_9._id_4D94.doors = [];
  var_9._id_4D94._id_4D6C = spawnStruct();
  var_9._id_4D94._id_1BE9 = [];
  var_9._id_4D94._id_DE56 = [];
  var_9._id_4D94.lights = [];
  var_9._id_4D94.lights["int"] = [];
  var_9._id_4D94.lights["ext"] = [];
  var_9._id_4D94._id_AC8F = [];
  var_9._id_4D94._id_AC8F["loading"] = "";
  var_9._id_4D94._id_AC8F["tactical"] = "";
  var_9._id_4D94._id_AC8F["emergency"] = "";
  var_9._id_4D94._id_AC8E = [];
  var_9._id_4D94._id_AC8E["loading"] = ::_id_F451;
  var_9._id_4D94._id_13060 = [];
  var_9._id_4D94._id_F08B = [];
  var_9._id_4D94._id_F08C = [];
  var_9 scripts\sp\utility::_id_65E0("player_in_dropship");
  var_9 scripts\sp\utility::_id_65E0("damage_system_active");
  var_9 scripts\sp\utility::_id_65E0("player_dropship_ready");
  var_9 scripts\sp\utility::_id_65E0("player_dropship_seats_ready");

  foreach(var_13 in scripts\engine\utility::getStructArray(var_5._id_1325F, "script_noteworthy")) {
    var_14 = var_13 scripts\engine\utility::spawn_tag_origin();

    if(isDefined(var_13.script_index))
      var_14.script_index = var_13.script_index;

    if(isDefined(var_13._id_EE52))
      var_14._id_EE52 = var_13._id_EE52;

    if(isDefined(var_13.target))
      var_14.target = var_13.target;

    if(isDefined(var_13.targetname)) {
      var_14.targetname = var_13.targetname;

      if(issubstr(var_14.targetname, "dropship_origin")) {
        if(issubstr(var_14.targetname, "light"))
          var_9._id_4D94._id_AD3E = var_14;
        else if(issubstr(var_14.targetname, "reflection"))
          var_9._id_4D94._id_AD3F = var_14;
        else
          var_9._id_4D94.linkpoint = var_14;

        continue;
      } else if(issubstr(var_14.targetname, var_5._id_1325C)) {
        var_9._id_4D94._id_AD3D = var_14;
        continue;
      } else if(issubstr(var_14.targetname, "starts")) {
        var_14._id_981A = var_14.angles;

        if(isDefined(var_14._id_EE52))
          var_9._id_4D94._id_10DED[var_14._id_EE52] = var_14;
        else if(isDefined(var_14.script_index))
          var_9._id_4D94._id_10DED[var_14.script_index] = var_14;
        else {}
      } else if(issubstr(var_14.targetname, "ammo_cache_interact"))
        var_9._id_4D94._id_1E3D = scripts\engine\utility::array_add(var_9._id_4D94._id_1E3D, var_14);
      else if(issubstr(var_14.targetname, "weapon_light")) {
        var_15 = spawnStruct();
        var_15._id_C264 = var_14;
        var_15.tag = "tag_origin";
        var_15.name = "dropship_weapon_light";
        var_9._id_4D94.fx["weapon_lights"] = scripts\engine\utility::array_add(var_9._id_4D94.fx["weapon_lights"], var_15);
      } else if(issubstr(var_14.targetname, "fx_damage")) {
        var_15 = spawnStruct();
        var_15._id_C264 = var_14;
        var_15.tag = "tag_origin";

        if(!isDefined(var_9._id_4D94.fx["damage"][var_14._id_EE52]))
          var_9._id_4D94.fx["damage"][var_14._id_EE52] = [];

        var_9._id_4D94.fx["damage"][var_14._id_EE52] = scripts\engine\utility::array_add(var_9._id_4D94.fx["damage"][var_14._id_EE52], var_15);
      } else
        var_9._id_4D94._id_C743 = scripts\engine\utility::array_add(var_9._id_4D94._id_C743, var_14);
    } else
      var_9._id_4D94._id_C743 = scripts\engine\utility::array_add(var_9._id_4D94._id_C743, var_14);

    var_9._id_4D94.partnerheli = scripts\engine\utility::array_add(var_9._id_4D94.partnerheli, var_14);
  }

  foreach(var_13 in getEntArray(var_5._id_1325F, "script_noteworthy")) {
    if(issubstr(var_13.classname, "info_player_start")) {
      continue;
    }
    if(issubstr(var_13.classname, "trigger")) {
      if(!isDefined(var_13._id_AD47) || var_13._id_AD47 == 0) {
        var_13 enablelinkTo();
        var_13 _meth_8314();
        var_13._id_AD47 = 1;
      }

      if(issubstr(var_13.classname, "flag")) {
        if(isDefined(var_13._id_ED9A) && !scripts\engine\utility::flag_exist(var_13._id_ED9A))
          scripts\engine\utility::flag_init(var_13._id_ED9A);
      }

      if(isDefined(var_13.targetname) && var_13.targetname == "player_trig")
        var_9._id_4D94._id_D30A = var_13;

      var_9._id_4D94._id_127C9 = scripts\engine\utility::array_add(var_9._id_4D94._id_127C9, var_13);
    } else if(issubstr(var_13.classname, "light")) {
      if(var_13.classname != "info_null")
        var_9 _id_F9C8(var_13, var_5);
    } else if(issubstr(var_13.classname, "reflection"))
      var_9._id_4D94._id_DE56[var_9._id_4D94._id_DE56.size] = var_13;
    else if(issubstr(var_13.classname, "weapon")) {
      var_13 show();
      var_9._id_4D94._id_13CC3 = scripts\engine\utility::array_add(var_9._id_4D94._id_13CC3, var_13);
    } else if(isDefined(var_13.script_parameters) && issubstr(var_13.script_parameters, "extra_collision")) {
      var_13 solid();
      var_9._id_4D94._id_6A4B = scripts\engine\utility::array_add(var_9._id_4D94._id_6A4B, var_13);
      var_9._id_4D94._id_1BE9 = scripts\engine\utility::array_add(var_9._id_4D94._id_1BE9, var_13);
    } else if(isDefined(var_13.targetname)) {
      if(var_13.targetname == "delete_on_firstframeend") {
        continue;
      }
      if(issubstr(var_13.targetname, "col_door")) {
        var_13 solid();

        switch (var_13.targetname) {
          case "col_door_left":
            var_9._id_4D94._id_5A13._id_4348 = var_13;
            var_9._id_4D94._id_5A13._id_4348 linkTo(var_9, var_9._id_4D94._id_5A13.tag);
            var_9._id_4D94._id_5A13._id_4284 = 1;
            break;
          case "col_door_right":
            var_9._id_4D94._id_5A27._id_4348 = var_13;
            var_9._id_4D94._id_5A27._id_4348 linkTo(var_9, var_9._id_4D94._id_5A27.tag);
            var_9._id_4D94._id_5A27._id_4284 = 1;
            break;
          case "col_door_back":
            var_9._id_4D94._id_5A01._id_4348 = var_13;
            var_9._id_4D94._id_5A01._id_4348 linkTo(var_9, var_9._id_4D94._id_5A01.tag);
            var_9._id_4D94._id_5A01._id_4284 = 1;
            break;
          default:
        }

        var_9._id_4D94._id_1BE9 = scripts\engine\utility::array_add(var_9._id_4D94._id_1BE9, var_13);
      } else if(issubstr(var_13.targetname, var_5._id_1325C) && var_13.classname == "script_brushmodel") {
        if(isDefined(var_13._id_EE52) && issubstr(var_13._id_EE52, "col_seat")) {
          var_18 = strtok(var_13._id_EE52, "_");
          var_19 = var_18[2] + "_" + var_18[3];
          var_20 = scripts\engine\utility::spawn_tag_origin(var_9 gettagorigin("tag_seat_" + var_19), var_9 gettagangles("tag_seat_" + var_19));
          var_20._id_4348 = var_13;
          var_13 linkTo(var_20);
          var_9._id_4D94._id_F08C[var_19] = var_20;
          var_13 connectpaths();
          var_13 notsolid();
        } else {
          var_9._id_4D94._id_4348 = var_13;
          var_9._id_4D94._id_4348 solid();
        }

        var_9._id_4D94._id_1BE9 = scripts\engine\utility::array_add(var_9._id_4D94._id_1BE9, var_13);
      } else if(issubstr(var_13.targetname, "player_turret")) {
        var_21 = var_13;

        if(isDefined(var_21.script_parameters))
          var_21.name = var_21.script_parameters;
        else
          var_21.name = var_21.targetname;

        foreach(var_14 in getEntArray(var_21.target, "targetname")) {
          if(var_14._id_EE52 == "pos_home")
            var_21._id_D69D = var_14;
          else if(var_14._id_EE52 == "pos_front")
            var_21._id_D69C = var_14;
          else if(var_14._id_EE52 == "pos_right")
            var_21._id_D6A3 = var_14;
          else if(var_14._id_EE52 == "pos_left")
            var_21._id_D69F = var_14;
          else if(var_14._id_EE52 == "pos_dismount")
            var_21._id_D69B = var_14;

          var_14 setModel("tag_origin");
        }

        var_21._id_32D9 = var_21._id_D69B;
        var_21._id_BCDA = var_21._id_D69D scripts\engine\utility::spawn_tag_origin();
        var_21._id_BCDA linkTo(var_21._id_D69D, "tag_origin", (0, 0, 0), (0, 0, 0));
        var_21 linkTo(var_21._id_BCDA);

        if(!var_21 scripts\sp\utility::_id_65DF("ent_flag_turret_detach"))
          var_21 scripts\sp\utility::_id_65E0("ent_flag_turret_detach");

        if(!var_21 scripts\sp\utility::_id_65DF("ent_flag_turret_mounted"))
          var_21 scripts\sp\utility::_id_65E0("ent_flag_turret_mounted");

        if(!var_21 scripts\sp\utility::_id_65DF("ent_flag_turret_moving"))
          var_21 scripts\sp\utility::_id_65E0("ent_flag_turret_moving");

        var_9._id_4D94.turrets[var_21.name] = var_21;
        var_13 = var_21._id_BCDA;
      } else if(issubstr(var_13.targetname, "vol_dropship_damage")) {
        var_9._id_4D94._id_4D6C._id_4348 = var_13;
        var_13 makeentitysentient("allies");
        var_13 setCanDamage(1);
        var_13 setCanRadiusDamage(1);

        if(!threatbiasgroupexists("player_dropship"))
          createthreatbiasgroup("player_dropship");

        var_13 setthreatbiasgroup("player_dropship");
      } else
        var_9._id_4D94._id_C744 = scripts\engine\utility::array_add(var_9._id_4D94._id_C744, var_13);
    } else {
      var_13 show();
      var_9._id_4D94._id_C744 = scripts\engine\utility::array_add(var_9._id_4D94._id_C744, var_13);
    }

    if(!isDefined(var_13.targetname) || !issubstr(var_13.targetname, "no_link"))
      var_9._id_4D94.partnerheli = scripts\engine\utility::array_add(var_9._id_4D94.partnerheli, var_13);
  }

  if(var_9._id_4D94.partnerheli.size == 0) {
    return;
  }
  var_9._id_981A = var_9._id_4D94.linkpoint.angles;

  foreach(var_13 in var_9._id_4D94.partnerheli) {
    if(isDefined(var_9._id_4D94._id_AD3E) && issubstr(var_13.classname, "light")) {
      var_13 linkTo(var_9._id_4D94._id_AD3E);
      continue;
    }

    if(isDefined(var_9._id_4D94._id_AD3F) && issubstr(var_13.classname, "reflection")) {
      var_13 linkTo(var_9._id_4D94._id_AD3F);
      continue;
    }

    if(isDefined(var_9._id_4D94._id_AD3D) && issubstr(var_13.classname, "script_brushmodel") && isDefined(var_13.targetname) && var_13.targetname == var_5._id_1325C) {
      var_13 linkTo(var_9._id_4D94._id_AD3D);
      continue;
    }

    var_13 linkTo(var_9._id_4D94.linkpoint);
  }

  var_27 = undefined;

  if(scripts\sp\utility::hastag(var_9.model, "tag_origin"))
    var_27 = "tag_origin";
  else
    var_27 = var_9.model;

  if(isDefined(var_9._id_4D94._id_AD3E))
    var_9._id_4D94._id_AD3E linkTo(var_9, var_27, (0, 0, 0), (0, 0, 0));

  if(isDefined(var_9._id_4D94._id_AD3F))
    var_9._id_4D94._id_AD3F linkTo(var_9, var_27, (0, 0, 0), (0, 0, 0));

  if(isDefined(var_9._id_4D94._id_AD3D))
    var_9._id_4D94._id_AD3D linkTo(var_9, var_27, (0, 0, 0), (0, 0, 0));

  var_9._id_4D94.linkpoint linkTo(var_9, var_27, (0, 0, 0), (0, 0, 0));
  var_9 _id_10CB0();

  if(isDefined(var_9._id_4D94._id_4D6C._id_4348))
    var_9 _id_10C25();

  var_9 scripts\engine\utility::delaythread(0.05, ::_id_10C28);
  var_9 thread _id_F4B4("straps", "light");
  var_9 scripts\sp\vehicle::_id_8441();
  var_9 notsolid();
  var_9._id_4D94 thread _id_1224(var_9);

  if(isDefined(var_2))
    var_9 scripts\engine\utility::delaythread(0.05, ::_id_138FB, var_2);

  if(isDefined(var_3)) {
    for(var_28 = 0; var_28 < var_3.size; var_28++) {
      if(isDefined(var_4) && isDefined(var_4[var_28]))
        var_29 = var_4[var_28];
      else
        var_29 = var_9 _id_DC9E();

      var_9._id_4D94.allies = scripts\engine\utility::array_add(var_9._id_4D94.allies, var_3[var_28]);

      if(isai(var_3[var_28]))
        var_3[var_28] scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_11624, var_9._id_4D94._id_10DED[var_29]);

      var_9._id_4D94._id_13060[var_29] = 1;
    }

    wait 0.1;
  }

  if(isDefined(var_1))
    var_9 thread _id_5EC6(var_1);

  while(gettime() - var_6 == 0)
    scripts\engine\utility::waitframe();

  var_9 scripts\sp\utility::_id_65E1("player_dropship_ready");
  return var_9;
}

_id_F9C8(var_0, var_1) {
  if(isDefined(var_0._id_5E34)) {
    return;
  }
  if(!isDefined(var_0._id_EDFF)) {
    return;
  }
  if(!isDefined(var_0._id_EE00)) {
    return;
  }
  var_0._id_5E34 = 0;
  var_2 = tolower(var_0._id_EDFF);
  var_3 = tolower(var_0._id_EE00);
  var_2 = strtok(var_2, " ");
  var_3 = strtok(var_3, " ");
  var_2 = strtok(var_2[0], "_");
  var_3 = strtok(var_3[0], "_");
  var_4 = var_2[0];
  var_5 = var_2[1];

  if(isDefined(self._id_4D94.lights[var_4])) {
    if(!isDefined(self._id_4D94.lights[var_4][var_5]))
      self._id_4D94.lights[var_4][var_5] = [];

    self._id_4D94.lights[var_4][var_5] = scripts\engine\utility::array_add(self._id_4D94.lights[var_4][var_5], var_0);
  } else {}
}

_id_106BA(var_0, var_1, var_2, var_3) {
  var_4 = ["left_cockpit", "right_cockpit"];
  var_5 = ["left_01", "left_02", "left_03", "left_04", "left_05", "left_06", "right_01", "right_02", "right_03", "right_04", "right_05", "right_06"];
  var_6 = ["middle_01", "middle_02", "middle_03", "middle_04"];

  foreach(var_8 in var_5)
  _id_106B9(var_8);

  if(isDefined(var_0) && var_0) {
    foreach(var_8 in var_6)
    _id_106B9(var_8, var_2);
  } else if(isDefined(var_2) && var_2) {
    foreach(var_8 in var_6)
    _id_DFFC(var_8);
  }

  if(isDefined(var_1) && var_1) {
    foreach(var_8 in var_4)
    _id_106B9(var_8, var_3);
  } else if(isDefined(var_3) && var_3) {
    foreach(var_8 in var_4)
    _id_DFFC(var_8);
  }

  scripts\sp\utility::_id_65E1("player_dropship_seats_ready");
}

#using_animtree("script_model");

_id_106B9(var_0, var_1) {
  if(!isDefined(self._id_4D94._id_F08B[var_0]))
    self._id_4D94._id_F08B[var_0] = spawnStruct();

  var_2 = "tag_seat_" + var_0;
  self._id_4D94._id_F08B[var_0] = scripts\sp\utility::_id_10639("dropship_seat");
  self._id_4D94._id_F08B[var_0] linkTo(self, var_2, (0, 0, 0), (0, 0, 0));
  self._id_4D94._id_F08B[var_0]._id_1FBB = "dropship_seat_" + var_0;
  self._id_4D94._id_F08B[var_0] _meth_83D0(#animtree);

  if(isDefined(var_1) && var_1)
    _id_DFFC(var_0);
  else if(isDefined(self._id_4D94._id_F08C[var_0])) {
    self._id_4D94._id_F08C[var_0]._id_4348 disconnectPaths();
    self._id_4D94._id_F08C[var_0]._id_4348 solid();
    self._id_4D94._id_F08C[var_0] linkTo(self._id_4D94._id_F08B[var_0], "tag_origin", (0, 0, 0), (0, 0, 0));
  }
}

_id_DFFC(var_0) {
  if(!isDefined(self._id_4D94._id_F08C[var_0])) {
    return;
  }
  self._id_4D94._id_F08C[var_0]._id_4348 delete();
  var_1 = self._id_4D94._id_F08C[var_0];
  self._id_4D94._id_F08C = scripts\sp\utility::_id_22B2(self._id_4D94._id_F08C, var_0);
  var_1 delete();
}

_id_F37F(var_0) {
  var_1 = _id_796D(var_0);
  var_1 setModel("veh_mil_air_un_dropship_seat");
  return var_1;
}

_id_796E(var_0) {
  if(isDefined(var_0) && var_0)
    return getarraykeys(self._id_4D94._id_F08B);

  return self._id_4D94._id_F08B;
}

_id_796D(var_0) {
  return self._id_4D94._id_F08B[var_0];
}

_id_F596(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_796E(1);

  var_1 = scripts\engine\utility::ter_op(isarray(var_1), var_1, [var_1]);

  foreach(var_3 in var_1) {
    var_4 = _id_796D(var_3);

    if(isDefined(var_4._id_3748))
      self thread[[var_4._id_3748]]();

    switch (var_0) {
      case "on":
        var_4 _id_13C5();
        break;
      case "off":
        var_4 _id_13C4();
        break;
      case "on_random":
        var_4 scripts\engine\utility::delaythread(randomfloatrange(0, 1), ::_id_13C5);
        break;
      default:
    }
  }
}

_id_13C5() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_dsp_screen_glow"), self, "TAG_SCREEN");
}

_id_13C4() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_dsp_screen_glow"), self, "TAG_SCREEN");
}

_id_5EC1(var_0) {
  var_0 _id_414A();
  var_1 = var_0 _id_78DC();
  var_1._id_110B9 = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_1._id_1087A;
  var_2.angles = var_1._id_10875;
  var_0 _meth_83BA(var_0._id_4D94.linkpoint, var_2);
  teleportscene();
  var_2 delete();
  scripts\engine\utility::waitframe();
  var_0 delete();
  return var_1;
}

_id_5E71(var_0, var_1, var_2, var_3) {
  return _id_106B8(var_0._id_10871, var_1, undefined, var_2, var_3, var_0);
}

_id_78DC() {
  return level._id_5D9A[self._id_4D94._id_10871];
}

_id_5D92(var_0, var_1) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_2 = getEnt(var_0, "targetname");

  if(isDefined(var_2))
    var_2 delete();

  var_3 = getEntArray(var_1, "script_noteworthy");
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6)) {
      if(issubstr(var_6.classname, "light"))
        var_6 setlightintensity(0);

      if(issubstr(var_6.classname, "trigger"))
        var_4[var_4.size] = var_6;

      if(isDefined(var_6._id_EE52) && issubstr(var_6._id_EE52, "col_seat"))
        var_4[var_4.size] = var_6;
    }
  }

  scripts\sp\utility::_id_228A(var_4);
}

_id_1224(var_0) {
  var_0 waittill("death");
  var_1 = level._id_5D9A[self._id_10871];
  var_2 = var_1._id_110B9;
  scripts\engine\utility::array_call(self._id_10DED, ::delete);
  self._id_10DED = undefined;
  scripts\sp\utility::_id_228A(self._id_421E);
  scripts\sp\utility::_id_228A(self._id_11596);
  scripts\sp\utility::_id_228A(self._id_C743);
  scripts\sp\utility::_id_228A(self._id_9A62);
  _id_1243(self.parts);
  _id_1243(self._id_F08B);
  _id_1243(self.fx);
  _id_1243(self.turrets);
  _id_1243(self._id_EF3C);
  self.linkpoint delete();
  self.allies = undefined;
  _id_1243(self.lights);

  if(isDefined(self._id_7333))
    self._id_7333 delete();

  if(isDefined(self._id_101B7))
    self._id_101B7 delete();

  if(isDefined(self._id_101B6))
    self._id_101B6 delete();

  if(isDefined(self._id_10A97))
    self._id_10A97 delete();

  if(!isDefined(var_2)) {
    scripts\sp\utility::_id_228A(self._id_127C9);
    self._id_4348 notsolid();
    scripts\sp\utility::_id_228A(self._id_6A4B);
    self._id_13CC3 = scripts\engine\utility::array_removeundefined(self._id_13CC3);
    scripts\sp\utility::_id_228A(self._id_13CC3);

    if(isDefined(self._id_5A13._id_4348))
      self._id_5A13._id_4348 notsolid();

    if(isDefined(self._id_5A27._id_4348))
      self._id_5A27._id_4348 notsolid();

    if(isDefined(self._id_5A01._id_4348))
      self._id_5A01._id_4348 notsolid();

    scripts\sp\utility::_id_228A(self._id_C744);
  } else {
    self._id_13CC3 = scripts\engine\utility::array_removeundefined(self._id_13CC3);

    foreach(var_4 in self._id_13CC3)
    var_4 hide();

    self._id_C744 = scripts\engine\utility::array_removeundefined(self._id_C744);

    foreach(var_7 in self._id_C744)
    var_7 hide();
  }

  self.partnerheli = undefined;
}

_id_1243(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2)) {
        continue;
      }
      _id_1243(var_2);
    }
  } else {
    if(isDefined(var_0.classname) && issubstr(var_0.classname, "light")) {
      var_0 setlightintensity(0);
      return;
    }

    if(isDefined(var_0._id_C264) && !isstruct(var_0._id_C264) && isDefined(var_0._id_C264.model) && var_0._id_C264.model == "tag_origin")
      var_0._id_C264 delete();

    if(!isstruct(var_0))
      var_0 delete();
  }
}

_id_1101E(var_0) {
  self notify("stop_monitor_player_in_dropship");

  if(scripts\engine\utility::is_true(level.player._id_84B1) && isDefined(var_0) && var_0) {
    return;
  }
  level.player setworldupreference(undefined);
}

_id_10CB0() {
  thread _id_B98D();
}

_id_B98D() {
  _id_1101E();
  self endon("death");
  self._id_4D94._id_D30A endon("death");
  self endon("stop_monitor_player_in_dropship");
  thread _id_11883();

  for(;;) {
    self._id_4D94._id_D30A waittill("trigger", var_0);

    if(var_0 != level.player) {
      continue;
    }
    scripts\sp\utility::_id_65E1("player_in_dropship");
    _id_B256();
    self notify("player_exited_dropship");
    scripts\sp\utility::_id_65DD("player_in_dropship");
  }
}

_id_11883() {
  self endon("death");
  self._id_4D94._id_D30A endon("death");
  self endon("stop_thrusters_on_off");
  var_0 = 0;

  for(;;) {
    if(isDefined(self._id_1025A) && self._id_1025A) {
      if(scripts\sp\utility::_id_65DB("inside_dropship_disable_effects"))
        scripts\sp\utility::_id_65DD("inside_dropship_disable_effects");

      wait 0.2;
      continue;
    }

    if(level.player istouching(self._id_4D94._id_D30A)) {
      if(!scripts\sp\utility::_id_65DB("inside_dropship_disable_effects"))
        scripts\sp\utility::_id_65E1("inside_dropship_disable_effects");
    } else if(scripts\sp\utility::_id_65DB("inside_dropship_disable_effects"))
      scripts\sp\utility::_id_65DD("inside_dropship_disable_effects");

    wait 0.2;
  }
}

_id_B255() {
  self endon("death");
  self endon("player_exited_dropship");
  level.player setworldupreference(self);

  for(;;) {
    physics_setgravity(anglestoup(self.angles) * -1);
    wait 0.1;
  }
}

_id_B256() {
  self endon("death");
  self endon("player_exited_dropship");
  var_0 = 0;
  self._id_4F08 = 0;

  for(;;) {
    var_1 = level.player getmovingplatformparent();

    if(level.player islinked())
      var_1 = level.player getlinkedparent();

    if(isDefined(var_1) && doentitiessharehierarchy(var_1, self._id_4D94._id_4348)) {
      break;
    }

    if(self._id_4F08 == 0)
      self._id_4F08++;

    scripts\engine\utility::waitframe();
  }

  level.player setworldupreference(self._id_4D94._id_4348);
  var_0 = 1;

  for(;;) {
    var_1 = level.player getmovingplatformparent();

    if(!level.player islinked()) {
      if(isDefined(var_1) && doentitiessharehierarchy(var_1, self._id_4D94._id_4348)) {
        if(!var_0) {
          var_0 = 1;
          level.player setworldupreference(self._id_4D94._id_4348);
          var_2 = 0;
        }
      } else if(var_0) {
        var_0 = 0;
        level.player setworldupreference(undefined);
        return;
      }
    }

    wait 0.15;
  }
}

_id_D8FB(var_0) {
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

_id_10C27() {
  level._id_5D6C endon("stop_dropship_fall_kill");
  level._id_5D6C waittill("player_exited_dropship");
  setomnvar("ui_death_hint", 6);
  scripts\sp\utility::_id_B8D1();
}

_id_10FE3() {
  level._id_5D6C notify("stop_dropship_fall_kill");
}

_id_5E63() {
  level._id_5AFF = 1;
  _id_5DFC();
  _id_5E98();
  _id_5E62();
  _id_7598();
}

#using_animtree("generic_human");

_id_5DFC() {
  level._id_EC85["generic"]["dropship_sit_idle"][0] = % xodus_robot_02_sit_idle;
  level._id_EC85["generic"]["dropship_chair_enter_ai"] = % dropship_chair_enter_ai;
  level._id_EC85["generic"]["dropship_chair_idle_ai"][0] = % dropship_chair_idle_ai;
  level._id_EC85["generic"]["dropship_chair_exit_ai"] = % dropship_chair_exit_ai;
}

#using_animtree("script_model");

_id_5E98() {
  level._id_EC87["dropship_seat"] = #animtree;
  level._id_EC8C["dropship_seat"] = "veh_mil_air_un_dropship_seat_wm";
  level._id_EC85["dropship_seat_left_cockpit"]["dropship_chair_enter_ai"] = % dropship_chair_enter_ai_chair;
  level._id_EC85["dropship_seat_right_cockpit"]["dropship_chair_enter_player"] = % dropship_chair_enter_player_chair;
  level._id_EC85["dropship_seat_left_cockpit"]["dropship_chair_exit_ai"] = % dropship_chair_exit_ai_chair;
  level._id_EC85["dropship_seat_right_cockpit"]["dropship_chair_exit_player"] = % dropship_chair_exit_player_chair;
}

#using_animtree("player");

_id_5E62() {
  level._id_EC85["player_rig"]["dropship_chair_enter_player"] = % dropship_chair_enter_player;
  level._id_EC85["player_rig"]["dropship_chair_idle_player"][0] = % dropship_chair_idle_player;
  level._id_EC85["player_rig"]["dropship_chair_exit_player"] = % dropship_chair_exit_player;
}

_id_F452(var_0, var_1) {
  wait 0.1;

  if(!isDefined(self._id_4D94._id_AC8F[var_0])) {
    return;
  }
  if(!isDefined(self._id_4D94.lights["int"][var_1])) {
    return;
  }
  self._id_4D94._id_AC8F[var_0] = var_1;

  if(isDefined(self._id_4D94._id_AC8E[var_0])) {
    self._id_4D94._id_AC8E[var_1] = self._id_4D94._id_AC8E[var_0];
    self._id_4D94._id_AC8E[var_0] = undefined;
  }
}

_id_F458(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 1;

  _id_F456("loading");

  if(!isDefined(var_2) || !var_2)
    _id_F454(0, "ext", "running");

  if(isDefined(var_1))
    wait(var_1);
  else
    scripts\engine\utility::waitframe();

  _id_F454(var_0, "int", "loading");

  if(isDefined(self._id_4D94._id_AC8E["loading"]))
    thread[[self._id_4D94._id_AC8E["loading"]]](var_0);
}

_id_F451(var_0) {
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(var_0)
    scripts\engine\utility::array_call(getscriptablearray("dropship_cabin_lights_" + self._id_6A0B, "targetname"), ::setscriptablepartstate, "onoff", "on");
  else
    scripts\engine\utility::array_call(getscriptablearray("dropship_cabin_lights_" + self._id_6A0B, "targetname"), ::setscriptablepartstate, "onoff", "off");
}

_id_F459(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1;

  _id_F456("tactical");
  _id_F454(1, "ext", "running");

  if(isDefined(var_1))
    wait(var_1);
  else
    scripts\engine\utility::waitframe();

  _id_F454(var_0, "int", "tactical");
}

_id_F457(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1;

  _id_F456("emergency");
  _id_F454(1, "ext", "running");

  if(isDefined(var_1))
    wait(var_1);
  else
    scripts\engine\utility::waitframe();

  _id_F454(var_0, "int", "emergency");
}

_id_F45A(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(isDefined(var_1))
    wait(var_1);
  else
    scripts\engine\utility::waitframe();

  _id_F454(var_0, "ext", "turbulence");
}

_id_F456(var_0) {
  var_0 = scripts\engine\utility::ter_op(!isDefined(var_0), [], var_0);
  var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);

  foreach(var_2 in getarraykeys(self._id_4D94.lights["int"])) {
    if(var_0.size > 0) {
      if(isDefined(scripts\engine\utility::array_find(var_0, var_2)))
        continue;
    }

    if(isDefined(self._id_4D94._id_AC8E[var_2]))
      thread[[self._id_4D94._id_AC8E[var_2]]](0);

    _id_F454(0, "int", var_2);
  }

  scripts\engine\utility::waitframe();
}

_id_F455(var_0) {
  var_0 = scripts\engine\utility::ter_op(!isDefined(var_0), [], var_0);
  var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);

  foreach(var_2 in getarraykeys(self._id_4D94.lights["ext"])) {
    if(var_0.size > 0) {
      if(isDefined(scripts\engine\utility::array_find(var_0, var_2)))
        continue;
    }

    _id_F454(0, "ext", var_2);
  }

  scripts\engine\utility::waitframe();
}

_id_F454(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = tolower(var_1);
  var_2 = tolower(var_2);

  if(isDefined(self._id_4D94._id_AC8F[var_2]) && self._id_4D94._id_AC8F[var_2] != "")
    var_2 = self._id_4D94._id_AC8F[var_2];

  if(!isDefined(self._id_4D94.lights[var_1][var_2])) {
    return;
  }
  if(var_0)
    level notify(var_1 + "_" + var_2 + "_on");
  else
    level notify(var_1 + "_" + var_2 + "_off");
}

_id_7A8A() {
  return getarraykeys(self._id_4D94.lights["int"]);
}

_id_7A89() {
  return getarraykeys(self._id_4D94.lights["ext"]);
}

_id_F453(var_0, var_1, var_2) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);

  if(!isDefined(self._id_4D94.lights[var_0][var_1])) {
    return;
  }
  for(var_3 = 0; var_3 < self._id_4D94.lights[var_0][var_1].size; var_3++)
    self._id_4D94.lights[var_0][var_1][var_3]._id_99E6 = self._id_4D94.lights[var_0][var_1][var_3]._id_99E6 * var_2;
}

_id_4CBD() {
  level.player notifyonplayercommand("int_next", "+actionslot 1");
  level.player notifyonplayercommand("int_prev", "+actionslot 2");
  level.player notifyonplayercommand("ext_next", "+actionslot 3");
  level.player notifyonplayercommand("ext_prev", "+actionslot 4");
  level._id_4B84 = 0;
  level._id_4B73 = 0;

  if(isDefined(self._id_4D94.lights["int"]) && self._id_4D94.lights["int"].size > 0) {
    thread _id_4CC3();
    thread _id_4CC2();
    thread _id_4CBF();
  }

  if(isDefined(self._id_4D94.lights["ext"]) && self._id_4D94.lights["ext"].size > 0) {
    thread _id_4CC1();
    thread _id_4CC0();
    thread _id_4CBE();
  }
}

_id_4CC3() {
  var_0 = getarraykeys(self._id_4D94.lights["int"]);

  for(;;) {
    level.player waittill("int_next");

    if(level._id_4B84 < var_0.size - 1)
      level._id_4B84++;
    else
      level._id_4B84 = 0;

    _id_F456();

    switch (var_0[level._id_4B84]) {
      case "loading":
        _id_F458(1);
        break;
      case "emergency":
        _id_F457(1);
        break;
      case "tactical":
        _id_F459(1);
        break;
      default:
        _id_F454(1, "int", var_0[level._id_4B84]);
    }
  }
}

_id_4CC2() {
  var_0 = getarraykeys(self._id_4D94.lights["int"]);

  for(;;) {
    level.player waittill("int_prev");

    if(level._id_4B84 > 0)
      level._id_4B84--;
    else
      level._id_4B84 = var_0.size - 1;

    _id_F456();

    switch (var_0[level._id_4B84]) {
      case "loading":
        _id_F458(1);
        break;
      case "emergency":
        _id_F457(1);
        break;
      case "tactical":
        _id_F459(1);
        break;
      default:
        _id_F454(1, "int", var_0[level._id_4B84]);
    }
  }
}

_id_4CC1() {
  var_0 = getarraykeys(self._id_4D94.lights["ext"]);

  for(;;) {
    level.player waittill("ext_next");

    if(level._id_4B73 < var_0.size - 1)
      level._id_4B73++;
    else
      level._id_4B73 = 0;

    _id_F455();
    _id_F454(1, "ext", var_0[level._id_4B73]);
  }
}

_id_4CC0() {
  var_0 = getarraykeys(self._id_4D94.lights["ext"]);

  for(;;) {
    level.player waittill("ext_prev");

    if(level._id_4B73 > 0)
      level._id_4B73--;
    else
      level._id_4B73 = var_0.size - 1;

    _id_F455();
    _id_F454(1, "ext", var_0[level._id_4B73]);
  }
}

_id_4CBF() {
  for(;;) {
    for(;;) {
      if(level.player meleeButtonPressed()) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    _id_F456();
    scripts\engine\utility::waitframe();
  }
}

_id_4CBE() {
  for(;;) {
    for(;;) {
      if(level.player _meth_8439()) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    _id_F455();
    scripts\engine\utility::waitframe();
  }
}

_id_138FB(var_0) {
  _id_3D6B(var_0);
  level.player setOrigin(self._id_4D94._id_10DED[var_0].origin);
  level.player setplayerangles(self._id_4D94._id_10DED[var_0].angles);
  self._id_4D94._id_13060[var_0] = 1;
}

_id_DC9E() {
  foreach(var_1 in getarraykeys(self._id_4D94._id_10DED)) {
    if(!isDefined(self._id_4D94._id_10DED[var_1].used)) {
      self._id_4D94._id_10DED[var_1].used = 1;
      return var_1;
    }
  }

  return 0;
}

_id_3D6B(var_0) {}

_id_796F(var_0) {
  _id_3D6B(var_0);
  return self._id_4D94._id_10DED[var_0];
}

_id_5EC6(var_0, var_1) {
  self notify("dropship_new_behavior");
  self notify("newpath");

  if(isDefined(var_1)) {
    level.player _meth_823B(self._id_4D94._id_10DED[var_1], "tag_origin");
    scripts\engine\utility::waitframe();
    level.player unlink();
  }

  var_2 = var_0;

  if(isstring(var_0))
    var_2 = _id_129F(var_0);

  var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
  self._id_4D94.allies = scripts\sp\utility::_id_DFEB(self._id_4D94.allies);

  foreach(var_5 in self._id_4D94.allies)
  var_5 _meth_83BA(self, var_3);

  self _meth_83BA(self, var_3);
  teleportscene();
  scripts\engine\utility::waitframe();
  var_3 delete();
}

_id_5E04(var_0, var_1, var_2) {
  self notify("dropship_new_behavior");
  self notify("newpath");

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(isstring(var_0))
    var_0 = _id_129F(var_0);
  else if(isvector(var_0)) {
    var_0 = scripts\engine\utility::spawn_tag_origin(var_0);
    thread _id_11D1(var_0);
  }

  self setvehgoalpos(var_0.origin, var_1);

  if(var_2) {
    var_3 = (0, 0, 0);

    if(isDefined(var_0.angles))
      var_3 = var_0.angles;

    _id_F37E(var_3[1]);
  }
}

_id_11D1(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any("dropship_new_behavior", "newpath", "death");
  var_0 delete();
}

_id_5E02(var_0) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  thread _id_122E(var_0);
}

_id_122E(var_0) {
  var_1 = var_0;

  if(isstring(var_0))
    var_1 = _id_129F(var_0);

  if(scripts\sp\vehicle::_id_9E2C()) {
    scripts\sp\vehicle::_id_1321A(var_1);
    self notify("finished_path");
  } else
    scripts\sp\vehicle::_id_2471(var_1);
}

_id_129F(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1))
    var_1 = getvehiclenode(var_0, "targetname");

  if(!isDefined(var_1))
    var_1 = getEnt(var_0, "targetname");

  return var_1;
}

_id_5DBE(var_0, var_1) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  self endon("dropship_new_behavior");
  var_2 = self.origin + anglesToForward(self.angles) * 1000000.0;
  self vehicle_setspeed(var_0);
  self setmaxpitchroll(0, 0);
  self setvehgoalpos(var_2);

  if(isDefined(var_1)) {
    wait(var_1);
    self setvehgoalpos(self.origin);
  }
}

_id_D118() {
  var_0 = 500;

  if(!isDefined(self._id_A9C7))
    self._id_A9C7 = gettime();

  if(level.player istouching(self._id_4D94._id_D30A))
    self._id_A9C7 = gettime();

  if(gettime() - self._id_A9C7 >= var_0)
    return 0;

  return 1;
}

_id_F37E(var_0) {
  self notify("stop_lookat");
  self endon("dropship_new_behavior");
  self endon("stop_lookat");
  self endon("death");

  if(isstring(var_0))
    var_0 = _id_129F(var_0).angles[1];

  childthread _id_1234(var_0);
}

_id_1234(var_0) {
  for(;;) {
    self settargetyaw(var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_F37D(var_0, var_1, var_2, var_3, var_4) {
  self notify("stop_lookat");
  self endon("stop_lookat");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = "forward";

  var_5 = var_0;

  if(isstring(var_0))
    var_5 = _id_129F(var_0);
  else if(isvector(var_0)) {
    var_5 = scripts\engine\utility::spawn_tag_origin(var_0);
    thread _id_11D2(var_5);
    var_5 endon("death");
  } else
    var_0 endon("death");

  var_6 = (0, 0, 0);

  if(isDefined(var_2))
    var_6 = anglesToForward(var_0.angles) * var_2;

  var_7 = (0, 0, 0);

  if(isDefined(var_3))
    var_7 = anglestoright(var_0.angles) * var_3;

  var_8 = (0, 0, 0);

  if(isDefined(var_4))
    var_8 = anglestoup(var_0.angles) * var_4;

  switch (var_1) {
    case "f":
    case "forward":
      break;
    case "l":
    case "left":
      childthread _id_1232(var_5, var_6, var_7, var_8);
      break;
    case "r":
    case "right":
      childthread _id_1233(var_5, var_6, var_7, var_8);
      break;
    case "back":
    case "b":
      childthread _id_1231(var_5, var_6, var_7, var_8);
      break;
    default:
  }
}

_id_1232(var_0, var_1, var_2, var_3) {
  for(;;) {
    self settargetyaw(vectortoangles(anglestoright(vectortoangles(self.origin - (var_0.origin + var_1 + var_2 + var_3))) * -1)[1]);
    scripts\engine\utility::waitframe();
  }
}

_id_1233(var_0, var_1, var_2, var_3) {
  for(;;) {
    self settargetyaw(vectortoangles(anglestoright(vectortoangles(self.origin - (var_0.origin + var_1 + var_2 + var_3))))[1]);
    scripts\engine\utility::waitframe();
  }
}

_id_1231(var_0, var_1, var_2, var_3) {
  for(;;) {
    self settargetyaw(vectortoangles(self.origin - (var_0.origin + var_1 + var_2 + var_3))[1]);
    scripts\engine\utility::waitframe();
  }
}

_id_11D2(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any("stop_lookat", "death");
  var_0 delete();
}

_id_414A() {
  self clearlookatent();

  if(isDefined(self._id_101B5))
    self._id_101B5 unlink();

  self notify("stop_lookat");
}

_id_5EBF() {
  self notify("dropship_new_behavior");
  var_0 = self.origin + anglesToForward(self.angles) * self.veh_speed * 10.0;
  self vehicle_setspeed(1);
  self setvehgoalpos(var_0, 1);
}

#using_animtree("vehicles");

_id_F4B4(var_0, var_1) {
  if(!isDefined(self._id_4D94.parts_map)) {
    self._id_4D94.parts_map = [];
    level._id_EC87["dropship_player_straps"] = #animtree;
    level._id_EC85["dropship_player_straps"]["light0"] = % vh_dropship_strap_idle_light_01;
    level._id_EC85["dropship_player_straps"]["light1"] = % vh_dropship_strap_idle_light_02;
    level._id_EC85["dropship_player_straps"]["heavy0"] = % vh_dropship_strap_idle_heavy_01;
    level._id_EC85["dropship_player_straps"]["heavy1"] = % vh_dropship_strap_idle_heavy_02;
    level._id_EC89["dropship_player_straps"]["light0"] = 1;
    level._id_EC89["dropship_player_straps"]["light1"] = 1;
    level._id_EC89["dropship_player_straps"]["heavy0"] = 1;
    level._id_EC89["dropship_player_straps"]["heavy1"] = 1;
  }

  if(!isDefined(var_1))
    var_1 = self._id_4D94.parts_map[var_0];

  self._id_4D94.parts_map[var_0] = var_1;

  foreach(var_3 in self._id_4D94.parts[var_0]) {
    if(!isDefined(var_3._id_92E2)) {
      var_3._id_92E2["light"] = [0, 1];
      var_3._id_92E2["heavy"] = [0, 1];
      var_3._id_92E5["light"] = var_3._id_92E2["light"];
      var_3._id_92E5["heavy"] = var_3._id_92E2["heavy"];
      var_3 scripts\sp\utility::_id_23B7("dropship_player_" + var_0);
      var_3._id_92DD = 1;
    }

    var_3._id_1FBD notify("stop_delay_thread");

    if(scripts\engine\utility::is_true(var_3._id_92DD)) {
      var_3._id_1FBD scripts\sp\utility::_id_50E4(randomfloatrange(0, 1), ::_id_1179, var_3, var_1);
      continue;
    }

    var_3._id_1FBD childthread _id_1179(var_3, var_1);
  }
}

_id_1179(var_0, var_1) {
  self notify("stop_anim_loop_dropship");
  self endon("stop_anim_loop_dropship");
  var_0 endon("death");
  var_2 = 0.8;
  var_3 = 1.2;

  for(;;) {
    if(var_0._id_92E5[var_1].size == 0)
      var_0._id_92E5[var_1] = var_0._id_92E2[var_1];

    var_4 = scripts\engine\utility::random(var_0._id_92E5[var_1]);
    var_0._id_92E2 = scripts\sp\utility::array_remove_index(var_0._id_92E2, var_4);
    var_5 = var_1 + var_4;
    var_6 = var_0 scripts\sp\utility::_id_7DC1(var_1 + var_4);
    var_7 = 3;
    var_8 = randomfloatrange(var_2, var_3);

    if(var_0._id_92DD) {
      var_0._id_92DD = 0;
      var_7 = 0;
      var_0 animScripted(var_1 + var_4, self.origin, self.angles, var_6);
    } else
      var_0 setanimknob(var_6, 1, var_7, var_8);

    wait(getanimlength(var_6) - var_7);
  }
}

_id_F4B3(var_0, var_1, var_2) {
  foreach(var_4 in self._id_4D94.parts[var_0]) {
    var_4._id_1FBD notify(var_0 + "idle");
    var_4._id_1FBD notify("stop_delay_thread");
    var_4._id_1FBD scripts\sp\anim::_id_1F35(var_4, var_1, var_2);
    thread _id_F4B4(var_0);
  }
}

_id_1237(var_0, var_1) {
  self endon(var_1);

  for(;;) {
    self _meth_82A2(var_0, 1);
    wait(getanimlength(var_0));
  }
}

_id_10C28(var_0) {
  if(isDefined(var_0))
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);

  if(!isDefined(var_0) || !isDefined(var_0[0]) || var_0[0] == "all")
    var_0 = self._id_4D94.turrets;

  foreach(var_2 in var_0) {
    if(var_2.classname == "script_model") {
      thread _id_123F(var_2);
      continue;
    }

    thread _id_123E(var_2);
  }
}

_id_10FE4(var_0) {
  if(isDefined(var_0))
    var_0 = scripts\engine\utility::ter_op(!isarray(var_0), [var_0], var_0);

  if(!isDefined(var_0) || !isDefined(var_0[0]) || var_0[0] == "all")
    var_0 = self._id_4D94.turrets;

  foreach(var_2 in var_0) {
    var_2 notify("stop_dropship_player_turret_think");
    var_2._id_32D9 _id_0E46::_id_DFE3();
  }
}

_id_5E6E() {
  foreach(var_1 in self._id_4D94.turrets)
  thread _id_1239(var_1);
}

_id_1239(var_0) {
  var_0 scripts\sp\utility::_id_65E1("ent_flag_turret_detach");

  if(!var_0 scripts\sp\utility::_id_65DB("ent_flag_turret_mounted")) {
    var_0._id_32D9 _id_0E46::_id_48C4("tag_origin", (0, 0, 32), 0.25, undefined, undefined, 64);
    var_0._id_32D9 waittill("trigger");
  } else {
    var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_mounted");
    self notify("off_turret");
    level.player unlink();
    thread _id_B98D();
    level.player setOrigin(var_0._id_D69B.origin);
    level.player takeallweapons();
    level.player allowcrouch(1);
    level.player allowprone(1);
    level.player notify("ammo_hack_off");
    level.player scripts\sp\utility::_id_E2CF("railgun");
    level.player _meth_81DE(level.player._id_C3BF, 1);
  }

  if(level.player hasweapon("iw7_railgunprojectile")) {
    var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_detach");
    return;
  }

  var_0 notify("stop_dropship_player_turret_think");
  self._id_4D94.turrets = scripts\engine\utility::array_remove(self._id_4D94.turrets, var_0);
  var_0._id_BCDA delete();
  var_0 delete();
  level.player giveweapon("iw7_railgunprojectile");
  level.player switchtoweaponimmediate("iw7_railgunprojectile");
}

_id_123E(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 notify("stop_dropship_player_turret_think");
  var_0 endon("stop_dropship_player_turret_think");
  level.player notifyonplayercommand("useButton", "+usereload");
  var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_moving");
  var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_mounted");
  var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_detach");

  for(;;) {
    var_0 waittill("trigger");
    var_0 scripts\sp\utility::_id_65E1("ent_flag_turret_mounted");
    var_0 waittill("turret_deactivate");
    self notify("off_turret");
    level.player setOrigin(var_0._id_D69B.origin);
  }
}

_id_123F(var_0) {
  self endon("death");
  var_0 notify("stop_dropship_player_turret_think");
  var_0._id_32D9 _id_0E46::_id_DFE3();
  var_0 endon("stop_dropship_player_turret_think");
  var_0._id_BCDA endon("death");
  level.player notifyonplayercommand("useButton", "+usereload");
  var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_moving");
  var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_mounted");
  var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_detach");

  for(;;) {
    var_0._id_32D9 _id_0E46::_id_48C4("tag_origin", (0, 0, 45), 0.25, undefined, undefined, 64);
    var_0._id_32D9 waittill("trigger");

    if(var_0 scripts\sp\utility::_id_65DB("ent_flag_turret_detach")) {
      continue;
    }
    var_0 hide();
    _id_123A(var_0, 0.25);
    var_0 scripts\sp\utility::_id_65E1("ent_flag_turret_mounted");
    level.player scripts\sp\utility::_id_110A8("railgun");
    level.player takeallweapons();
    level.player giveweapon("iw7_railgunprojectilehackturret");
    level.player switchtoweaponimmediate("iw7_railgunprojectilehackturret");
    level.player setstance("stand");
    level.player allowcrouch(0);
    level.player allowprone(0);
    level.player childthread _id_1E31();
    level.player._id_C3BF = getdvarint("cg_fov");
    level.player _meth_81DE(80, 0.5);
    wait 1;

    while(!level.player useButtonPressed())
      scripts\engine\utility::waitframe();

    var_0 scripts\sp\utility::_id_65DD("ent_flag_turret_mounted");
    self notify("off_turret");
    level.player unlink();
    thread _id_B98D();
    var_0 show();
    level.player setOrigin(var_0._id_D69B.origin);
    level.player takeallweapons();
    level.player allowcrouch(1);
    level.player allowprone(1);
    level.player notify("ammo_hack_off");
    level.player scripts\sp\utility::_id_E2CF("railgun");
    level.player _meth_81DE(level.player._id_C3BF, 1);
    wait 1;
  }
}

_id_1E31() {
  self endon("ammo_hack_off");

  if(!isDefined(self) || self == level || self.code_classname != "player")
    var_0 = level.player;
  else
    var_0 = self;

  for(;;) {
    wait 0.5;
    var_1 = var_0 getcurrentweapon();

    if(var_1 != "none") {
      var_2 = var_0 getfractionmaxammo(var_1);

      if(var_2 < 0.2)
        var_0 givemaxammo(var_1);
    }

    var_3 = var_0 getcurrentoffhand();

    if(var_3 != "none") {
      var_2 = var_0 getfractionmaxammo(var_3);

      if(var_2 < 0.4)
        var_0 givemaxammo(var_3);
    }
  }
}

_id_123A(var_0, var_1) {
  level.player freezecontrols(1);
  level.player _meth_823C(var_0._id_BCDA, "tag_origin", var_1);
  wait(var_1);
  level.player playerlinktodelta(var_0._id_BCDA, "tag_origin", 0, 65, 65, 5, 65);
  level.player freezecontrols(0);
}

_id_123B(var_0) {
  self endon("off_turret");
  var_0._id_4B9F = var_0._id_D69D;
  var_0._id_1E77 = 0.5 * scripts\engine\utility::anglebetweenvectors(var_0._id_D69F.origin - var_0._id_D69D.origin, var_0._id_D69C.origin - var_0._id_D69D.origin);

  for(;;) {
    var_0 scripts\sp\utility::_id_65E8("ent_flag_turret_moving");
    var_1 = level.player getnormalizedmovement();

    if(var_0._id_4B9F == var_0._id_D69D) {
      if(var_1[0] > 0 && var_0 _id_123C(var_0._id_D69C, var_0._id_1E77))
        var_0 _id_123D(var_0._id_D69C);
      else if(var_1[0] > 0 && var_0 _id_123C(var_0._id_D6A3, var_0._id_1E77))
        var_0 _id_123D(var_0._id_D6A3);
      else if(var_1[0] > 0 && var_0 _id_123C(var_0._id_D69F, var_0._id_1E77))
        var_0 _id_123D(var_0._id_D69F);
    } else if(var_0._id_4B9F == var_0._id_D69C) {
      if(var_1[0] < 0)
        var_0 _id_123D(var_0._id_D69D);
      else if(var_1[1] > 0)
        var_0 _id_123D(var_0._id_D6A3);
      else if(var_1[1] < 0)
        var_0 _id_123D(var_0._id_D69F);
      else if(var_1[0] > 0 && var_0 _id_123C(var_0._id_D6A3))
        var_0 _id_123D(var_0._id_D6A3);
      else if(var_1[0] > 0 && var_0 _id_123C(var_0._id_D69F))
        var_0 _id_123D(var_0._id_D69F);
    } else if(var_0._id_4B9F == var_0._id_D69F) {
      if(var_1[0] < 0)
        var_0 _id_123D(var_0._id_D69D);
      else if(var_1[1] > 0)
        var_0 _id_123D(var_0._id_D69C);
      else if(var_1[0] > 0 && var_0 _id_123C(var_0._id_D6A3))
        var_0 _id_123D(var_0._id_D6A3);
    } else if(var_0._id_4B9F == var_0._id_D6A3) {
      if(var_1[0] < 0)
        var_0 _id_123D(var_0._id_D69D);
      else if(var_1[1] < 0)
        var_0 _id_123D(var_0._id_D69C);
      else if(var_1[0] > 0 && var_0 _id_123C(var_0._id_D69F))
        var_0 _id_123D(var_0._id_D69F);
    } else {}

    scripts\engine\utility::waitframe();
  }
}

_id_123C(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 360;

  var_2 = vectortoangles(var_0.origin - self._id_4B9F.origin);
  var_3 = abs(angleclamp180(level.player.angles[1]) - angleclamp180(var_2[1]));

  if(abs(angleclamp180(level.player.angles[1]) - angleclamp180(var_2[1])) < var_1)
    return 1;

  return 0;
}

_id_123D(var_0) {
  if(self._id_4B9F == var_0) {
    return;
  }
  var_1 = 10.0;
  scripts\sp\utility::_id_65E1("ent_flag_turret_moving");
  level.player lerpviewangleclamp(0.5, 0.5, 0, 0, 0, 0, 0);

  for(var_2 = 0; var_2 < 0.55; var_2 = var_2 + 0.05) {
    var_3 = var_2 / 0.5;
    var_4 = 3 * squared(var_3) - 2 * (var_3 * var_3 * var_3);
    var_5 = (var_0.origin - self._id_4B9F.origin) * var_4;
    var_6 = (_id_1E7A(0, var_0, var_4), _id_1E7A(1, var_0, var_4), _id_1E7A(2, var_0, var_4));
    self._id_BCDA.origin = self._id_4B9F.origin + var_5;
    self._id_BCDA.angles = var_6;
    self._id_BCDA linkTo(self._id_D69D);
    scripts\engine\utility::waitframe();
  }

  level.player lerpviewangleclamp(0, 0, 0, 45, 45, 90, 90);
  self._id_4B9F = var_0;
  scripts\sp\utility::_id_65DD("ent_flag_turret_moving");
}

_id_1E7A(var_0, var_1, var_2) {
  var_3 = (angleclamp(var_1.angles[var_0]) - angleclamp(self._id_4B9F.angles[var_0])) * var_2;
  var_4 = angleclamp(self._id_4B9F.angles[var_0]) + var_3;
  return var_4;
}

_id_4F2C(var_0) {
  self endon("death");

  for(;;) {
    if(isDefined(var_0._id_D69D)) {}

    if(isDefined(var_0._id_D69C)) {}

    if(isDefined(var_0._id_D69F)) {}

    if(isDefined(var_0._id_D6A3)) {}

    if(isDefined(var_0._id_D69B)) {}

    if(isDefined(var_0._id_BCDA)) {}

    if(isDefined(var_0._id_32D9)) {}

    scripts\engine\utility::waitframe();
  }
}

_id_4ECD(var_0) {
  while(isDefined(self)) {
    if(isDefined(var_0)) {} else {}

    scripts\engine\utility::waitframe();
  }
}

_id_7C3C(var_0) {
  return self._id_4D94._id_F08B[var_0];
}

_id_7CA0(var_0) {
  return self._id_4D94._id_10DED[var_0];
}

_id_10C25(var_0) {
  self endon("death");
  self notify("stop_dropship_damage_think");
  self endon("stop_dropship_damage_think");

  if(!scripts\sp\utility::_id_65DB("damage_system_active"))
    _id_1223();

  childthread _id_11C5();

  if(isDefined(self._id_4D94._id_4D6C._id_4348) && (!isDefined(var_0) || !var_0))
    self._id_4D94._id_4D6C._id_4348 childthread _id_11BD();

  _id_F328("none");
}

_id_10FE1() {
  self notify("stop_dropship_damage_think");
  scripts\sp\utility::_id_65DD("damage_system_active");
}

_id_F328(var_0, var_1) {
  self._id_4D94._id_4D6C._id_BF2E = var_0;

  if(isDefined(var_1) && var_1)
    self._id_4D94._id_4D6C._id_7258 = 1;

  self notify("change_damage_state");
}

_id_CCE4(var_0) {
  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      thread scripts\engine\utility::play_loop_sound_on_entity(var_2, (0, 0, 128));
      self._id_4D94._id_4D6C.sounds = scripts\engine\utility::array_add(self._id_4D94._id_4D6C.sounds, var_2);
    }
  } else {
    thread scripts\engine\utility::play_loop_sound_on_entity(var_0, (0, 0, 128));
    self._id_4D94._id_4D6C.sounds = scripts\engine\utility::array_add(self._id_4D94._id_4D6C.sounds, var_0);
  }
}

_id_10FDA() {
  foreach(var_1 in self._id_4D94._id_4D6C.sounds)
  scripts\engine\utility::stop_loop_sound_on_entity(var_1);

  self._id_4D94._id_4D6C._id_4BB3 = [];
}

_id_7598() {
  level._effect["dropship_interior_light_a"] = loadfx("vfx/iw7/_requests/prisoner/pnr_dropship_interior_light_a");
  level._effect["dropship_interior_light_red"] = loadfx("vfx/iw7/_requests/prisoner/pnr_dropship_interior_light_red");
  level._effect["dropship_weapon_light"] = loadfx("vfx/iw7/_requests/prisoner/pnr_dropship_weapon_light_a");
  level._effect["dropship_sparks_a"] = loadfx("vfx/level/las_vegas/vfx_dmg_heli_sparks");
  level._effect["dropship_steam_a"] = loadfx("vfx/iw7/_requests/dropship/dsp_damage_steam");
  level._effect["vfx_dropship_damage_debris_01"] = loadfx("vfx/iw7/core/vehicle/dropship/vfx_dropship_damage_debris_01.vfx");
  level._effect["vfx_dropship_damage_light"] = loadfx("vfx/iw7/core/vehicle/dropship/vfx_dropship_damage_light.vfx");
  level._effect["vfx_dropship_smoke_burst_01"] = loadfx("vfx/iw7/core/vehicle/dropship/vfx_dropship_smoke_burst_01.vfx");
  level._effect["vfx_dropship_smoke_cabin_01"] = loadfx("vfx/iw7/core/vehicle/dropship/vfx_dropship_smoke_cabin_01.vfx");
  level._effect["vfx_dropship_sparks"] = loadfx("vfx/iw7/core/vehicle/dropship/vfx_dropship_sparks.vfx");
  level._effect["vfx_dropship_steamvent"] = loadfx("vfx/iw7/core/vehicle/dropship/vfx_dropship_steamvent.vfx");
  level._effect["vfx_drpshp_reentry"] = loadfx("vfx/iw7/core/vehicle/dropship/reentry/vfx_drpshp_reentry.vfx");
  level._effect["vfx_dsp_screen_glow"] = loadfx("vfx/iw7/core/vehicle/dropship/vfx_dsp_screen_glow.vfx");
}

_id_1223() {
  scripts\sp\utility::_id_65E1("damage_system_active");
  self._id_4D94._id_4D6C._id_00C8 = undefined;
  self._id_4D94._id_4D6C.sounds = [];

  if(!isDefined(self._id_4D94.fx["damage"]["cabin_smoke"])) {
    var_0 = spawnStruct();
    var_0.name = "vfx_dropship_smoke_cabin_01";
    var_0._id_C264 = scripts\engine\utility::spawn_tag_origin();
    var_0._id_C264 linkTo(self, "tag_origin", (0, 0, 64), (0, 0, 0));
    var_0.tag = "tag_origin";
    self._id_4D94.fx["damage"]["cabin_smoke"] = var_0;
  }
}

_id_11BD() {
  var_0 = 100;

  for(;;)
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_11C5() {
  for(;;) {
    self waittill("change_damage_state");
    var_0 = self._id_4D94._id_4D6C._id_BF2E;

    if(isDefined(self._id_4D94._id_4D6C._id_7258) && !self._id_4D94._id_4D6C._id_7258 && (isDefined(self._id_4D94._id_4D6C._id_00C8) && var_0 == self._id_4D94._id_4D6C._id_00C8)) {
      self._id_4D94._id_4D6C._id_7258 = undefined;
      continue;
    }

    _id_10FDD("damage");
    _id_10FDD("cabin_lights");
    _id_10FDA();
    self._id_4D94._id_4D6C._id_00C8 = var_0;

    switch (self._id_4D94._id_4D6C._id_00C8) {
      case "none":
        _id_11C4();
        break;
      case "low":
        _id_11C1();
        break;
      case "medium":
        _id_11C2();
        break;
      case "high":
        _id_11BF();
        break;
      case "death":
        break;
      default:
    }

    self notify("change_damage_state_done");
  }
}

_id_11C4() {
  _id_F459(1);
}

_id_11C1() {
  _id_F45A(1);
  _id_CCEA("damage", "corner", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 15, 100, "dropship_spark_small");
  _id_CCEA("damage", "wall", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 15, 100, "dropship_player_glass_crack");
}

_id_11C2() {
  _id_10FDA();
  _id_F457(1);
  childthread _id_11C3();
  _id_CCEA("damage", "ceiling", "vfx_dropship_steamvent", 5, 30);
  _id_CCEA("damage", "floor_temp", "vfx_dropship_smoke_cabin_01", 1);
  _id_CCEA("damage", "corner", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 5, 30, "dropship_spark_small");
  _id_CCEA("damage", "wall", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 5, 30, "dropship_player_glass_crack");
  _id_CCE4("dropship_alarm_damage_1");
}

_id_11C3() {
  self endon("change_damage_state");

  for(;;) {
    var_0 = randomfloatrange(0.3, 0.4);
    var_1 = randomfloatrange(0.1, 1);
    var_2 = randomfloatrange(0.1, 0.3);
    level.player _meth_8291(var_2, var_2, var_2, var_1, var_1 * 0.25, var_1 * 0.25, 0, 15, 15, 15);
    wait(var_1);
  }
}

_id_11BF() {
  _id_10FDA();
  _id_F457(1);
  childthread _id_11C0();

  for(var_0 = 0; var_0 < 40; var_0++)
    scripts\engine\utility::delaythread(randomfloat(1), ::_id_CCE8, "damage", "ceiling", "vfx_dropship_steamvent");

  _id_CCEA("damage", "floor_temp", "vfx_dropship_smoke_cabin_01", 0.25);
  _id_CCEA("damage", "corner", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 1, 3, "dropship_player_glass_crack");
  _id_CCEA("damage", "wall", ["vfx_dropship_smoke_burst_01", "dropship_sparks_a", "vfx_dropship_sparks"], 1, 3, "dropship_spark_small");
  _id_CCE4(["dropship_player_damaged_95_percent_alarm", "dropship_player_tube_hiss"]);
}

_id_11C0() {
  self endon("change_damage_state");

  for(;;) {
    var_0 = randomfloatrange(0.3, 3);
    var_1 = randomfloatrange(0.1, 1);
    var_2 = randomfloatrange(0.1, 1 * var_0);
    level.player _meth_8291(var_2, var_2, var_2, var_1, var_1 * 0.25, var_1 * 0.25, 0, 15, 15, 15);
    wait(var_1);
  }
}

_id_11BE() {
  self endon("change_damage_state");

  for(;;) {
    _id_10FDD("cabin_lights");
    _id_CCE8("cabin_lights", undefined, "dropship_interior_light_a");
    wait 0.5;
    _id_10FDD("cabin_lights");
    _id_CCE8("cabin_lights", undefined, ["dropship_interior_light_red", "vfx_dropship_damage_light"]);
    wait 0.5;
  }
}

_id_F2CA(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0)
    playFXOnTag(scripts\engine\utility::getfx("vfx_drpshp_reentry"), self, "tag_origin");
  else if(!var_0)
    stopFXOnTag(scripts\engine\utility::getfx("vfx_drpshp_reentry"), self, "tag_origin");
}

_id_CCE8(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1))
    _id_1244(self._id_4D94.fx[var_0][var_1], ::_id_CCE5, var_2, var_3, var_4);
  else if(isDefined(var_0))
    _id_1244(self._id_4D94.fx[var_0], ::_id_CCE5, var_2, var_3, var_4);
  else
    _id_1244(self._id_4D94.fx, ::_id_CCE5, var_2, var_3, var_4);

  var_5 = 2;

  if(isarray(var_2))
    var_5 = var_2.size;

  wait(0.05 * var_5);
}

_id_CCE7(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1))
    _id_1244(self._id_4D94.fx[var_0][var_1], ::_id_CCE6, var_2, var_3);
  else if(isDefined(var_0))
    _id_1244(self._id_4D94.fx[var_0], ::_id_CCE6, var_2, var_3);
  else
    _id_1244(self._id_4D94.fx, ::_id_CCE6, var_2, var_3);
}

_id_CCE6(var_0, var_1) {
  self endon("death");
  self endon("stop_dps_fx");
  self notify("stop_dps_fx_flicker");
  self endon("stop_dps_fx_flicker");

  if(!isDefined(var_0))
    var_0 = 0.05;

  if(!isDefined(var_1))
    var_1 = var_0 + 0.05;

  for(;;) {
    wait(randomfloatrange(var_0, var_1));
    _id_10FDB(undefined, 1);
    wait 0.1;
    _id_CCE5(self._id_4B78);
  }
}

_id_CCEA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1))
    _id_1244(self._id_4D94.fx[var_0][var_1], ::_id_CCE9, var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_0))
    _id_1244(self._id_4D94.fx[var_0], ::_id_CCE9, var_2, var_3, var_4, var_5, var_6);
  else
    _id_1244(self._id_4D94.fx, ::_id_CCE9, var_2, var_3, var_4, var_5, var_6);
}

_id_CCE9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "";

  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_8, var_7 in var_0)
      var_5 = var_5 + var_7;
    } else
      var_5 = var_0;
  }

  self endon("death");
  self endon("stop_dps_fx" + var_5);
  self endon("stop_dps_fx");
  self notify("stop_dps_fx_loop");
  self endon("stop_dps_fx_loop");

  if(!isDefined(var_1))
    var_1 = 0.05;

  if(!isDefined(var_2))
    var_2 = var_1 + 0.05;

  wait(randomfloatrange(0, var_2 * 0.5));

  for(;;) {
    _id_CCE5(var_0, var_3, var_4);
    wait(randomfloatrange(var_1, var_2));
  }
}

_id_CCE5(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = self.name;

  if(!isDefined(self._id_4B78))
    self._id_4B78 = [];

  if(isarray(var_0)) {
    foreach(var_4 in var_0) {
      playFXOnTag(scripts\engine\utility::getfx(var_4), self._id_C264, self.tag);

      if(!isDefined(scripts\engine\utility::array_find(self._id_4B78, var_4)))
        self._id_4B78 = scripts\engine\utility::array_add(self._id_4B78, var_4);

      scripts\engine\utility::waitframe();
    }
  } else {
    playFXOnTag(scripts\engine\utility::getfx(var_0), self._id_C264, self.tag);

    if(!isDefined(scripts\engine\utility::array_find(self._id_4B78, var_0)))
      self._id_4B78 = scripts\engine\utility::array_add(self._id_4B78, var_0);
  }

  if(isDefined(var_1)) {
    var_6 = 0;

    if(isDefined(var_2))
      var_6 = 1;

    if(isarray(var_1)) {
      if(var_6) {
        foreach(var_8 in var_1) {
          self._id_C264 childthread scripts\engine\utility::play_loop_sound_on_entity(var_1);

          if(var_2 > 0)
            self._id_C264 scripts\sp\utility::_id_50E4(var_2, scripts\engine\utility::stop_loop_sound_on_entity, var_1);
        }

        return;
      }

      foreach(var_8 in var_1)
      self._id_C264 childthread scripts\sp\utility::play_sound_on_entity(var_1);

      return;
    } else if(var_6) {
      self._id_C264 childthread scripts\engine\utility::play_loop_sound_on_entity(var_1);

      if(var_2 > 0)
        self._id_C264 scripts\sp\utility::_id_50E4(var_2, scripts\engine\utility::stop_loop_sound_on_entity, var_1);
    } else
      self._id_C264 childthread scripts\sp\utility::play_sound_on_entity(var_1);
  }
}

_id_10FDD(var_0, var_1, var_2) {
  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  if(isDefined(var_1))
    _id_1244(self._id_4D94.fx[var_0][var_1], ::_id_10FDB, var_2);
  else if(isDefined(var_0))
    _id_1244(self._id_4D94.fx[var_0], ::_id_10FDB, var_2);
  else
    _id_1244(self._id_4D94.fx, ::_id_10FDB, var_2);

  var_3 = 2;

  if(isarray(var_2))
    var_3 = var_2.size;

  wait(0.05 * var_3);
}

_id_10FDB(var_0, var_1) {
  var_2 = "";

  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_5, var_4 in var_0)
      var_2 = var_2 + var_4;
    } else
      var_2 = var_0;
  }

  if(!isDefined(var_1) || !var_1)
    self notify("stop_dps_fx" + var_2);

  if(!isDefined(var_0)) {
    if(isDefined(self._id_4B78)) {
      foreach(var_7 in self._id_4B78) {
        stopFXOnTag(scripts\engine\utility::getfx(var_7), self._id_C264, self.tag);
        scripts\engine\utility::waitframe();
      }
    }

    if(!isDefined(var_1) || !var_1)
      self._id_4B78 = [];
  } else {
    if(isarray(var_0)) {
      foreach(var_10 in var_0) {
        stopFXOnTag(scripts\engine\utility::getfx(var_10), self._id_C264, self.tag);

        if(isDefined(self._id_4B78) && isDefined(scripts\engine\utility::array_find(self._id_4B78, var_10)))
          self._id_4B78 = scripts\engine\utility::array_remove(self._id_4B78, var_10);

        scripts\engine\utility::waitframe();
      }

      return;
    }

    stopFXOnTag(scripts\engine\utility::getfx(var_0), self._id_C264, self.tag);

    if(isDefined(self._id_4B78) && isDefined(scripts\engine\utility::array_find(self._id_4B78, var_0)))
      self._id_4B78 = scripts\engine\utility::array_remove(self._id_4B78, var_0);
  }
}

_id_10FDC() {
  self notify("stop_dps_fx_flicker");
}

_id_1244(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isarray(var_0)) {
    foreach(var_11 in var_0) {
      if(!isDefined(var_11)) {
        continue;
      }
      childthread _id_1244(var_11, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  } else if(isDefined(var_9))
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isDefined(var_8))
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_7))
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    var_0 childthread[[var_1]](var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    var_0 childthread[[var_1]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    var_0 childthread[[var_1]](var_2, var_3);
  else if(isDefined(var_2))
    var_0 childthread[[var_1]](var_2);
  else
    var_0 childthread[[var_1]]();
}

_id_11B5() {}
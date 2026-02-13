/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1847.gsc
*************************************************/

_id_3D19() {
  level thread _id_1D0F();
}

init() {
  if(!scripts\engine\utility::_id_5C0C("init_interaction_done")) {
    scripts\engine\utility::_id_5C11("init_interaction_done");
  }

  if(scripts\engine\utility::_id_5C0C("strike_init_done")) {
    scripts\engine\utility::_id_5C24("strike_init_done");
  }

  level._id_8393 = [];
  level._id_835D = [];
  level._id_146C = scripts\engine\utility::getstructarray("interaction", "targetname");
  level._id_417B = level._id_146C;
  level._id_10CFC = ::_id_459E;
  level thread _id_8386();

  if(isDefined(level._id_60F2)) {
    [[level._id_60F2]]();
  }

  if(isDefined(level._id_47DE)) {
    [[level._id_47DE]]();
  }

  if(scripts\engine\utility::_id_5C0C("interactions_initialized")) {
    scripts\engine\utility::_id_5C1B("interactions_initialized");
  }

  if(isDefined(level._id_10D22)) {
    [[level._id_10D22]]();
  }

  if(isDefined(level._id_3E54)) {
    [[level._id_3E54]]();
  }

  if(isDefined(level._id_804C)) {
    level[[level._id_804C]]();
  }

  waitframe();

  foreach(var_1 in level._id_417B) {
    var_1._id_7D67 = 1;

    if(!isDefined(var_1.angles)) {
      var_1.angles = (0, 0, 0);
    }

    var_1._id_EEE8 = [];

    if(!isDefined(var_1._id_CE18)) {
      var_1._id_CE18 = "default";
    }

    if(var_1._id_CE18 == "requires_power") {
      var_1._id_C588 = 1;
      var_1._id_BAD8 = 0;
      var_1._id_BA97 = _id_6363(var_1);
    } else {
      var_1._id_C588 = 0;
      var_1._id_BAD8 = 0;
    }

    if(isDefined(var_1._id_039B) && isDefined(level._id_8393[var_1._id_039B]) && istrue(level._id_8393[var_1._id_039B]._id_8656)) {
      _id_06F4::_id_1167(var_1);
    }
  }

  if(getdvarint("#x35eeed5987402f833", 0) == 0) {
    level thread _id_4FED();
  }

  var_3 = getarraykeys(level._id_8393);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(level._id_8393[var_3[var_4]]._id_7F8B)) {
      var_5 = scripts\engine\utility::getstructarray(var_3[var_4], "script_noteworthy");
      level thread[[level._id_8393[var_3[var_4]]._id_7F8B]](var_5);
    }
  }

  foreach(var_1 in level._id_417B) {
    if(isDefined(var_1._id_039B) && isDefined(level._id_8393[var_1._id_039B]) && istrue(level._id_8393[var_1._id_039B].disable_model)) {
      continue;
    }
    if(isDefined(var_1._id_CDC1)) {
      if(isDefined(var_1.target)) {
        var_7 = scripts\engine\utility::getstructarray(var_1.target, "targetname");

        foreach(var_9 in var_7) {
          if(!isDefined(var_9._id_039B) || tolower(var_9._id_039B) != "scenenode" && tolower(var_9._id_039B) != "manual_script_model") {
            thread _id_E30C(var_1, var_9);
          }
        }

        continue;
      }

      if(isDefined(var_1._id_039B) && tolower(var_1._id_039B) != "scenenode") {
        thread _id_E30C(var_1, var_1);
      }
    }
  }

  scripts\engine\utility::_id_5C1B("init_interaction_done");

  foreach(var_13 in level.players) {
    var_14 = var_13 getcurrentweapon();

    if(isDefined(level._id_10C9F) && isDefined(var_14)) {
      self._id_10CBC = [level._id_10C9F][getcompleteweaponname(var_14)];
    }
  }
}

_id_4FED() {
  if(!scripts\engine\utility::_id_5C0C("wall_buy_setup_done")) {
    scripts\engine\utility::_id_5C11("wall_buy_setup_done");
  }

  if(!scripts\engine\utility::_id_5C00("wall_buy_setup_done")) {
    scripts\engine\utility::_id_5C24("wall_buy_setup_done");
  }

  foreach(var_1 in level._id_146C) {
    if(isDefined(var_1._id_722E) && var_1._id_722E == "locOverride") {
      continue;
    }
    var_2 = scripts\engine\utility::_id_5000(var_1.origin, 10, -200);
    var_1.origin = var_2 + (0, 0, 1);
  }
}

_id_6363(var_0) {
  var_1 = getEntArray("spawn_volume", "targetname");

  foreach(var_3 in var_1) {
    if(_func_011A(var_0.origin, var_3)) {
      if(isDefined(var_3.basename)) {
        return var_3.basename;
      }
    }
  }

  return undefined;
}

_id_62FF() {
  if(isDefined(level._id_118A[self.basename])) {
    var_0 = [];

    foreach(var_2 in level._id_118A[self.basename]) {
      var_0[var_0.size] = level._id_E246[var_2];
    }

    return var_0;
  }

  return [];
}

_id_85FC(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0._id_118A)) {
    return 0;
  }

  foreach(var_2 in var_0._id_118A) {
    if(!var_2._id_0026) {
      continue;
    }
    if(self istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_C2F7(var_0) {
  var_0 waittill("disconnect");
  self._id_7D7E = 0;
  self notify("interaction_ent_released");
}

_id_1D0F() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0._id_8388 = var_0 _id_6679();

    if(!isDefined(var_0._id_8388)) {
      iprintlnbold("NO TRIGGER FOUND!");
    }

    _id_C5C3();
    _id_D1A5(undefined);
    var_0._id_8388 makeunusable();
    var_0 thread _id_C2FA();
    var_0 thread _id_B502();
    var_0 thread _id_B503();
  }
}

_id_B503() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    scripts\engine\utility::waittill_any_3("weapon_switch_started", "weapon_change", "weaponchange");
    _id_C1A2();
  }
}

_id_6679() {
  if(isDefined(self._id_8388)) {
    return self._id_8388;
  } else {
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel("tag_origin");
    var_0._id_7D7E = 1;
    var_0 thread scripts\cp\utility::_id_477D(self);
    return var_0;
  }
}

_id_C2FA() {
  var_0 = self._id_8388;
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  var_0._id_7D7E = 0;
}

_id_C266(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;
  var_13 = undefined;
  var_14 = undefined;
  var_15 = undefined;

  if(!isDefined(var_5)) {
    var_5 = "duration_short";
  }

  var_16 = spawnStruct();
  var_16._id_039B = var_0;
  var_16._id_7965 = var_1;
  var_16._id_E3FF = var_12;
  var_16._id_F8A0 = var_13;
  var_16._id_0F07 = var_2;
  var_16._id_523F = 1;
  var_16._id_4A9D = 1;
  var_16._id_3D91 = 0;
  var_16._id_C588 = var_14;
  var_16._id_7F8B = var_3;
  var_16._id_3108 = undefined;
  var_16._id_A53D = var_4;
  var_16._id_FE5D = var_5;
  var_16._id_8656 = var_6;
  var_16._id_796E = var_7;
  var_16.hinttype = undefined;
  var_16.hint_type_func = undefined;
  level._id_8393[var_0] = var_16;
  var_17 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");

  if(scripts\engine\utility::is_equal(var_8, 1)) {
    level thread add_interaction_markers(var_17, var_0, var_9, var_11);
  }

  if(isDefined(var_10)) {
    level thread set_custom_search_distance_on_structs(var_17, var_10);
  }

  _id_0FE3(var_17);

  if(isDefined(var_3)) {
    if(scripts\engine\utility::_id_5C0C("interactions_initialized") && scripts\engine\utility::_id_5C00("interactions_initialized")) {
      level thread[[var_3]](var_17);

      if(istrue(var_6)) {
        foreach(var_16 in var_17) {
          _id_06F4::_id_1167(var_16);
        }
      }
    }
  }
}

addinteractionstruct(var_0, var_1, var_2, var_3) {
  var_4 = [var_0];

  if(scripts\engine\utility::is_equal(var_1, 1)) {
    level thread add_interaction_marker_internal(var_0, var_0._id_039B, var_2);
  }

  if(isDefined(var_3)) {
    var_0._id_425E = var_3;
  }

  level._id_417B = scripts\cp\utility::_id_1B8C(level._id_417B, var_0);
}

_id_10C8(var_0, var_1) {
  level._id_8393[var_0]._id_8383 = var_1;
}

_id_10C9(var_0, var_1) {
  level._id_8393[var_0]._id_838B = var_1;
}

addinteractionhinttypecallback(var_0, var_1) {
  level._id_8393[var_0].hint_type_func = var_1;
}

_id_0FE3(var_0) {
  level._id_417B = scripts\engine\utility::array_combine(level._id_417B, var_0);
  level._id_417B = scripts\engine\utility::_id_1BC1(level._id_417B);
}

_id_8391(var_0) {
  return istrue(level._id_8393[var_0._id_039B]._id_A53D);
}

_id_C1EE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  _id_C266(var_0, var_3, var_4, var_7, var_9, var_10);
}

_id_C5C3() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_8388)) {
      _id_78BE(var_1);
    }
  }
}

_id_78BE(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      var_0._id_8388 _meth_80E0(var_0);
      continue;
    }

    var_0._id_8388 disableplayeruse(var_2);
  }
}

_id_10E01(var_0, var_1) {
  for(;;) {
    thread scripts\engine\utility::_id_4EF3(var_1.origin, 12, 12, var_1.angles, (1, 1, 0), 0, 1);
    wait 0.05;
  }
}

_id_B502() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");

  if(scripts\engine\utility::_id_5C0C("init_interaction_done")) {
    scripts\engine\utility::_id_5C24("init_interaction_done");
  } else {
    while(!isDefined(level._id_417B)) {
      wait 1;
    }
  }

  var_0 = 5184;
  var_1 = 9216;
  var_2 = 2304;

  for(;;) {
    if(isDefined(level._id_8394)) {
      if(isDefined(self._id_8F31)) {
        _id_C5C1();
      }

      level waittill("interactions_disabled_toggled");
      continue;
    }

    var_4 = undefined;
    level._id_417B = scripts\engine\utility::_id_1BD1(level._id_417B, 1);
    var_5 = _func_0204(level._id_417B, self.origin);

    foreach(var_7 in self._id_4A8B) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
    }

    if(var_5.size == 0 || istrue(self._id_4668) || !isDefined(var_5[0])) {
      self notify("starting_interaction_search");

      if(isDefined(self._id_8F31)) {
        _id_C5C1();
      }

      wait 0.05;
      continue;
    }

    var_9 = var_5[0];

    if(!isDefined(var_4) && distancesquared(var_9.origin, self.origin) <= var_0) {
      var_4 = var_9;
    }

    if(!isDefined(var_4) && isDefined(level._id_DA74)) {
      if(distancesquared(var_9.origin, self.origin) <= var_1) {
        var_4 = var_9;
      }

      if(isDefined(var_4) && ![[level._id_DA74]](var_4)) {
        var_4 = undefined;
      }
    } else if(!isDefined(var_4) && isDefined(var_9._id_425E)) {
      if(distance(var_9.origin, self.origin) <= var_9._id_425E) {
        var_4 = var_9;
      }
    } else if(!isDefined(var_4) && isDefined(var_9.search_2d_dist)) {
      if(distance2d(var_9.origin, self.origin) <= var_9.search_2d_dist) {
        var_4 = var_9;
      }
    }

    if(!isDefined(var_4) || !scripts\engine\utility::array_contains(level._id_417B, var_4)) {
      _id_C5C1();
      continue;
    }

    if(!_id_3106(var_4)) {
      _id_C5C1();
      continue;
    }

    if(!isDefined(self._id_8F31) || self._id_8F31 == var_4 && _id_8360(var_4) || self._id_8F31 != var_4) {
      _id_D25E(var_4);
    } else if(self._id_8F31 == var_4 && _id_836F(var_4) && !istrue(self._id_4668)) {
      _id_D25E(var_4, 0);
    }

    wait 0.05;
  }
}

_id_5C8E() {
  self endon("window_trap_placed");
  self endon("death");

  if(!isDefined(self._id_A472)) {
    self._id_A472 = gettime() + 2500;
  } else if(gettime() < self._id_A472) {
    return;
  }
  self._id_A472 = gettime() + 2500;
  wait 1.5;
}

_id_3106(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(istrue(self._id_87A7)) {
    return 0;
  }

  if(istrue(var_0._id_4A88) || !scripts\cp\utility::_id_1A57() || self _meth_8507()) {
    return 0;
  }

  if(istrue(var_0._id_1FC1)) {
    return 0;
  }

  if(self secondaryoffhandbuttonpressed() || self _meth_81EF() || self fragbuttonpressed()) {
    return 0;
  }

  if(!self isonground()) {
    return 0;
  }

  if(!isDefined(var_0._id_039B)) {
    thread _id_44F6(var_0, "interaction_struct Struct at: " + var_0.origin + " does not have a .script_noteworthy defined.");
    return 0;
  }

  if(!isDefined(level._id_8393[var_0._id_039B])) {
    thread _id_44F6(var_0, "interaction_struct Struct at: " + var_0.origin + " with .script_noteworthy: " + var_0._id_039B + " has not been registered as an interaction_struct");
    return 0;
  }

  return 1;
}

_id_44F6(var_0, var_1) {}

_id_C5C1() {
  self endon("disconnect");
  wait 0.2;
  self._id_8388 makeunusable();
  _id_D1A5(undefined);
  self._id_8388 _meth_84D9("hide");
}

_id_D25E(var_0, var_1) {
  if(istrue(self._id_8388._id_4AC0)) {
    return;
  }
  self notify("set_interaction_point");
  self._id_8388 dontinterpolate();
  _id_D1A5(var_0);
  var_2 = self getEye();
  self._id_8388.origin = (var_0.origin[0], var_0.origin[1], var_2[2]);

  if(_id_8391(var_0)) {
    level thread[[level._id_8393[var_0._id_039B]._id_0F07]](var_0, self);
    return;
  }

  if(!isDefined(level._id_8393[var_0._id_039B]._id_E3FF)) {
    level._id_8393[var_0._id_039B]._id_E3FF = "null";
  }

  var_3 = level._id_8393[var_0._id_039B]._id_E3FF;
  var_4 = undefined;

  if(_id_836F(var_0)) {
    if(!scripts\cp\cp_weapon::_id_752E(var_0._id_039B)) {
      var_5 = _id_6E7B(var_0._id_039B);
      var_6 = _id_6E6F(var_0._id_039B);
      self._id_8388 _meth_8557(var_5, var_6);
    }
  } else if(_id_8365(var_0)) {
    var_7 = strtok(var_0.name, "_");
    var_8 = int(var_7[1]);
    self._id_8388 _meth_8557(var_8);
  } else if(_id_8368(var_0)) {
    var_9 = _id_6AD3(var_0._id_CD99);

    switch (var_0._id_039B) {
      case "seq_button":
        self._id_8388 _meth_8557(var_9);
        break;
    }
  } else if(_id_8361(var_0)) {
    var_9 = _id_68B2(level._id_41B2[0]);
    var_10 = _id_68B2(level._id_41B2[1]);
    var_11 = _id_6BB1(level._id_41B2[2]);

    switch (var_0._id_039B) {
      case "chess_piece_selection":
        self._id_8388 _meth_8557(var_9);
        break;
      case "chess_puzzle_alphabet":
        self._id_8388 _meth_8557(var_10);
        break;
      case "chess_puzzle_number":
        self._id_8388 _meth_8557(var_11);
        break;
    }
  } else if(_id_836A(var_0)) {
    if(isDefined(level._id_D369)) {
      [[level._id_D369]](var_0, self);
    }
  } else if(_id_8370(var_0))
    _id_D449(var_0, self);
  else if(_id_836D(var_0)) {
    self._id_8388.origin = (var_0.origin[0], var_0.origin[1], var_2[2] - 15);
  }

  var_12 = scripts\cp\utility::_id_459B(level._id_8393[var_0._id_039B]._id_796E, 0) || istrue(var_0._id_796E);

  if(var_12) {
    self._id_8388 _meth_84D9("show");
  } else {
    self._id_8388 _meth_84D9("hide");
  }

  _id_D25F(self._id_8388, var_0);

  if(!isDefined(var_1)) {
    thread _id_1071E(var_0);
  }

  self._id_8388 makeuseable();
}

_id_D1A5(var_0) {
  if(isDefined(self._id_8F31)) {
    var_1 = level._id_8393[self._id_8F31._id_039B]._id_838B;

    if(isDefined(var_1)) {
      level thread[[var_1]](self._id_8F31, self);
    }
  }

  self._id_8F31 = var_0;

  if(isDefined(var_0)) {
    var_2 = level._id_8393[var_0._id_039B]._id_8383;

    if(isDefined(var_2)) {
      level thread[[var_2]](var_0, self);
    }
  }
}

_id_6AD3(var_0) {
  if(getdvarint("#x36fb4e6ec37cf91fb", 0) != 0) {
    switch (var_0) {
      case "A":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/STABILIZE_PRESSURE_X1";
      case "B":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/STABILIZE_PRESSURE_X2";
      case "C":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X1";
      case "D":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X2";
      case "E":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/MIX_GAUGE_X2_TO_X1";
      case "F":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_X1";
      case "G":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_X2";
      case "H":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DEPLOY_READINGS";
      case "I":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/MIX_GAUGE_X1_TO_X2";
      case "J":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DISPLAY_READINGS";
    }
  }

  if(getdvarint("#x3d7ee43fe439de2ae", 0) != 0) {
    switch (var_0) {
      case "A":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/SW_POLE_X1";
      case "B":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/SW_POLE_X2";
      case "C":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X1";
      case "D":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/INCREMENT_X2";
      case "E":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RESET_GAUGES";
      case "F":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_INCR_X1";
      case "G":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_INCR_X2";
      case "H":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/LOCK_FUEL_VALS";
      case "I":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/RANDOMIZE";
      case "J":
        return &"CP_RAID_COMPLEX_JUGG_MAZE/DISPLAY_READINGS";
    }
  }

  switch (var_0) {
    case "A":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/A";
    case "B":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/B";
    case "C":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/C";
    case "D":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/D";
    case "E":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/E";
    case "F":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/F";
    case "G":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/G";
    case "H":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/H";
    case "I":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/I";
    case "J":
      return &"CP_RAID_COMPLEX_JUGG_MAZE/J";
  }
}

_id_68B2(var_0) {
  switch (var_0) {
    case "A":
      return &"CP_LAB/A";
    case "B":
      return &"CP_LAB/B";
    case "C":
      return &"CP_LAB/C";
    case "D":
      return &"CP_LAB/D";
    case "E":
      return &"CP_LAB/E";
    case "F":
      return &"CP_LAB/F";
    case "G":
      return &"CP_LAB/G";
    case "H":
      return &"CP_LAB/H";
    case "R":
      return &"CP_LAB/ROOK";
    case "N":
      return &"CP_LAB/KNIGHT";
    case "Q":
      return &"CP_LAB/QUEEN";
    case "K":
      return &"CP_LAB/KING";
    case "P":
      return &"CP_LAB/PAWN";
  }
}

_id_6BB1(var_0) {
  switch (var_0) {
    case "1":
      return &"CP_LAB/1";
    case "2":
      return &"CP_LAB/2";
    case "3":
      return &"CP_LAB/3";
    case "4":
      return &"CP_LAB/4";
    case "5":
      return &"CP_LAB/5";
    case "6":
      return &"CP_LAB/6";
    case "7":
      return &"CP_LAB/7";
    case "8":
      return &"CP_LAB/8";
  }
}

_id_D449(var_0, var_1) {
  var_2 = _id_684A(var_0);
  self._id_8388 _meth_8557(var_2);
}

_id_684A(var_0) {
  switch (var_0.name) {
    case "s4_ar_stango44":
      return &"s4_ar_stango44";
  }
}

_id_6E7B(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = scripts\cp\utility::_id_6902(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  switch (var_1) {
    default:
      if(isDefined(level._id_4263)) {
        return [[level._id_4263]](var_1, var_0);
        return;
      }

      return &"CP_ZMB_INTERACTIONS/GENERIC_WEAPON";
      return;
  }
}

_id_6E6F(var_0) {
  return int(level._id_8393[var_0]._id_3D91);
}

_id_D25F(var_0, var_1) {
  var_2 = _id_6521(var_1, self);

  if(isDefined(var_2)) {
    self._id_8388 sethintstring(var_2);
  }

  if(_id_8371(var_1)) {
    if(isDefined(var_2) && !_func_0121(var_2)) {
      var_3 = self getcurrentweapon();
      var_4 = scripts\cp\cp_weapon::_id_683D(var_3);
      var_5 = _id_6E7B(var_3);
      var_6 = 0;

      if(var_2 == &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON" || var_2 == &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_GENERIC") {
        self._id_8388 _meth_8557(var_5, var_6);
      }
    }
  } else if(_id_836D(var_1) || istrue(level._id_8393[var_1._id_039B].hintstring_show_cost)) {
    if(isDefined(var_2) && !_func_0121(var_2)) {
      var_6 = level._id_8393[var_1._id_039B]._id_3D91;
      self._id_8388 _meth_8557(var_6);
    }
  } else
    self._id_8388 setusefov(160);

  if(isDefined(level._id_8393[var_1._id_039B]._id_FE72)) {
    self._id_8388 setusefov(level._id_8393[var_1._id_039B]._id_FE72);
  }

  var_7 = scripts\cp\utility::_id_459B(level._id_8393[var_1._id_039B]._id_FE5D, "duration_none");

  if(isDefined(level._id_8393[var_1._id_039B].override_interaction_use_duration_func)) {
    var_7 = int([[level._id_8393[var_1._id_039B].override_interaction_use_duration_func]](var_1, self));
  }

  self._id_8388 setuseholdduration(var_7);
  var_8 = scripts\cp\utility::_id_459B(level._id_8393[var_1._id_039B].hinttype, "HINT_NOICON");

  if(isDefined(level._id_8393[var_1._id_039B].hint_type_func)) {
    var_8 = [[level._id_8393[var_1._id_039B].hint_type_func]](var_1, self);
  }

  self._id_8388 setcursorhint(var_8);
  self._id_8388 _meth_83A1(1);

  if(isDefined(level._id_838A)) {
    [[level._id_838A]](var_0, var_1, var_2);
  }
}

_id_6521(var_0, var_1) {
  if(isDefined(level._id_8393[var_0._id_039B]._id_7965)) {
    return [[level._id_8393[var_0._id_039B]._id_7965]](var_0, var_1);
  }

  if(isDefined(var_0._id_3D11)) {
    if(isDefined(level._id_835D[var_0._id_039B + "_cooldown"])) {
      return level._id_835D[var_0._id_039B + "_cooldown"];
    }

    return &"COOP_INTERACTIONS/COOLDOWN";
  }

  if(istrue(var_0._id_C588) && !istrue(var_0._id_BAD8)) {
    return &"COOP_INTERACTIONS/REQUIRES_POWER";
  }

  if(_id_836F(var_0)) {
    if(!scripts\cp\utility::_id_3D1D("wall_buys")) {
      return undefined;
    }
  }

  if(!isDefined(level._id_835D[var_0._id_039B])) {
    return "";
  }

  return level._id_835D[var_0._id_039B];
}

_id_1071E(var_0) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");

  for(;;) {
    self._id_8388 waittill("trigger", var_1);

    if(!_id_836E(var_0, var_1)) {
      wait 0.1;
      continue;
    }

    var_0._id_F615 = 1;
    var_0 thread _id_46B9();
    var_2 = level._id_8393[var_0._id_039B]._id_3D91;

    if(!isDefined(level._id_8393[var_0._id_039B]._id_E3FF)) {
      level._id_8393[var_0._id_039B]._id_E3FF = "null";
    }

    if(isDefined(level._id_8393[var_0._id_039B]._id_3108)) {
      if(![[level._id_8393[var_0._id_039B]._id_3108]](var_0, var_1)) {
        wait 0.1;
        continue;
      }
    } else if(var_0._id_039B == "lost_and_found") {
      if(!istrue(self._id_75CE)) {
        wait 0.1;
        continue;
      }

      if(isDefined(self._id_98A9) && self._id_98A9 != var_0) {
        wait 0.1;
        continue;
      }

      if(scripts\cp\utility::_id_89AE() || istrue(level._id_AB30)) {
        var_2 = 0;
      }
    } else if(_id_8371(var_0)) {
      if(scripts\cp\utility::_id_857B()) {
        wait 0.1;
        continue;
      }

      var_3 = var_1 getcurrentweapon();
      level._id_BC6B = var_1 getcurrentweapon();
      var_4 = scripts\cp\cp_weapon::_id_683D(var_3);

      if(istrue(var_1._id_7530) || istrue(level._id_B15A)) {
        if(var_4 - 1 == level._id_AE11) {
          _id_8385(var_0, &"COOP_INTERACTIONS/UPGRADE_MAXED");
          wait 0.1;
          continue;
        } else {
          _id_8385(var_0, &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL");
          wait 0.1;
          continue;
        }
      } else if(scripts\cp\cp_weapon::_id_3101(var_3)) {} else {
        _id_8385(var_0, &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL");
        wait 0.1;
        continue;
      }
    } else if(_id_836F(var_0)) {
      if(scripts\cp\utility::_id_8722()) {
        wait 0.1;
        continue;
      }

      var_5 = var_1 getcurrentweapon();
      var_6 = scripts\cp\utility::_id_6902(var_5);

      if(scripts\cp\cp_weapon::_id_752E(var_0._id_039B)) {
        if(!_id_30E5(var_0._id_039B)) {
          _id_8385(var_0, &"COOP_GAME_PLAY/AMMO_MAX");
          wait 0.1;
          continue;
        } else {
          var_7 = scripts\cp\utility::_id_6CE3(var_0._id_039B);
          var_4 = scripts\cp\cp_weapon::_id_683D(var_7);

          if(var_4 > 1) {
            var_2 = 4500;
          } else {
            var_2 = var_2 * 0.5;
          }
        }
      }
    } else if(_id_8363(var_0)) {
      if(!isDefined(var_1._id_4167) && var_0._id_1F8A > 0) {
        level notify("interaction", "purchase_denied", level._id_8393[var_0._id_039B], self);
        wait 0.1;
        continue;
      }
    } else if(_id_8366(var_0)) {
      if(var_1._id_3267 == 2) {
        _id_8385(var_0, &"COOP_INTERACTIONS/NO_MORE_CARDS_OWNED");
        wait 0.1;
        continue;
      }

      if(self._id_3267 == 1) {
        var_2 = level._id_5F05;
      } else {
        var_2 = level._id_5F04;
      }
    }

    if(isDefined(level._id_8393[var_0._id_039B]._id_3D92)) {
      var_2 = int([[level._id_8393[var_0._id_039B]._id_3D92]](var_0, var_1, var_2));
    }

    if(!_id_30E6(var_0, var_2, level._id_8393[var_0._id_039B]._id_E3FF)) {
      level notify("interaction", "purchase_denied", level._id_8393[var_0._id_039B], self);

      if(isDefined(var_0._id_CE18) && var_0._id_CE18 == "tickets") {
        _id_8385(var_0, &"CP_ZMB_INTERACTIONS/NEED_TICKETS");
        thread _id_076F::_id_F72D("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else {
        thread _id_076F::_id_F72D("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        var_1 playlocalsound("zmb_ui_purchase_deny");
        var_1 _id_0720::_id_BEC0("insufficient_funds", 1);
        _id_8385(var_0, &"COOP_INTERACTIONS/NEED_MONEY");
      }

      wait 0.1;
      continue;
    }

    if(var_0._id_039B == "atm_withdrawal") {
      if(isDefined(level._id_1D5C)) {
        if(level._id_1D5B < level._id_1D5C) {
          _id_8385(var_0, &"COOP_INTERACTIONS/NEED_MONEY");
          wait 0.1;
          continue;
        }
      }
    }

    thread _id_8379(var_0);

    if(_id_836F(var_0)) {
      level notify("interaction", var_0.name, undefined, self);
    } else {
      level notify("interaction", "purchase", level._id_8393[var_0._id_039B], self);
    }

    var_8 = level._id_8393[var_0._id_039B]._id_E3FF;
    thread _id_ED96(var_2, var_8);
    level thread[[level._id_8393[var_0._id_039B]._id_0F07]](var_0, self);
    _id_837A(var_0);
    var_0._id_F615 = undefined;
    return;
  }
}

_id_B30D(var_0, var_1) {
  var_2 = var_0._id_039B;
  var_3 = getweaponbasename(var_2);

  switch (var_3) {
    default:
      break;
  }
}

_id_30E5(var_0) {
  var_1 = self getweaponslistall();
  var_2 = undefined;
  var_3 = undefined;
  var_4 = scripts\cp\utility::_id_6CE3(var_0);

  foreach(var_6 in var_1) {
    var_3 = scripts\cp\utility::_id_6CE3(var_6);

    if(var_3 == var_4) {
      var_2 = var_6;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_8 = self getweaponammostock(var_2);
    var_9 = weaponmaxammo(var_2);
    var_10 = _id_0946::_id_BBF1();
    var_11 = int(var_10 * var_9);

    if(var_8 < var_11) {
      return 1;
    } else if(weaponmaxammo(var_2) == weaponclipsize(var_2) && self getweaponammoclip(var_2) < weaponclipsize(var_2)) {
      return 1;
    } else {
      return 0;
    }
  }

  return 1;
}

_id_8379(var_0) {
  self endon("disconnect");

  if(_id_8360(var_0)) {
    return;
  }
  if(_id_8364(var_0)) {
    return;
  }
  if(_id_835F(var_0)) {
    return;
  }
  if(_id_8361(var_0)) {
    return;
  }
  scripts\cp\utility::_id_1567(0);
  wait 1.5;

  if(!scripts\cp\utility::_id_1A57()) {
    scripts\cp\utility::_id_1567(1);
  }
}

_id_46B9() {
  wait 0.25;
  self._id_F615 = undefined;
}

_id_1160(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    _id_1037(var_3);
  }
}

_id_C4AB(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    _id_C3C5(var_3);
  }
}

_id_C3C5(var_0) {
  var_0 notify("remove_from_current_interaction_list");
  var_0._id_7D67 = 0;

  if(scripts\engine\utility::array_contains(level._id_417B, var_0)) {
    level._id_417B = scripts\engine\utility::array_remove(level._id_417B, var_0);
  }

  _id_06F4::_id_FBC9();
}

_id_1037(var_0) {
  var_0 notify("add_to_current_interaction_list");
  var_0._id_7D67 = 1;

  if(!scripts\engine\utility::array_contains(level._id_417B, var_0)) {
    level._id_417B = scripts\engine\utility::array_add(level._id_417B, var_0);
  }

  _id_06F4::_id_FBC9();
}

_id_C3C6(var_0, var_1) {
  var_0 notify("remove_from_current_interaction_list_for_player_" + var_1.name);

  if(!scripts\engine\utility::array_contains(var_1._id_4A8B, var_0)) {
    var_1._id_4A8B = scripts\engine\utility::array_add(var_1._id_4A8B, var_0);
  }

  _id_06F4::_id_FBCA(var_1);
}

_id_1038(var_0, var_1) {
  var_0 notify("add_to_current_interaction_list_for_player_" + var_1.name);

  if(scripts\engine\utility::array_contains(var_1._id_4A8B, var_0)) {
    var_1._id_4A8B = scripts\engine\utility::array_remove(var_1._id_4A8B, var_0);
  }

  _id_06F4::_id_FBCA(var_1);
}

_id_30E6(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::array_contains(level._id_417B, var_0)) {
    return 0;
  }

  if(scripts\cp\utility::_id_8941()) {
    return 1;
  }

  if(isDefined(var_0._id_CDA6) && var_0._id_CDA6 == "afterlife") {
    return 1;
  }

  if(isDefined(var_1)) {
    var_4 = var_1;
  } else {
    var_4 = level._id_8393[var_0._id_039B]._id_3D91;
  }

  if(_id_836F(var_0)) {
    var_5 = var_0._id_039B;

    if(var_0._id_CE18 == "tickets") {
      if(self hasweapon(var_5)) {
        return 0;
      }

      self._id_8B35 = var_0._id_039B;
      level._id_F464 = randomint(100);
    }

    var_6 = weaponmaxammo(var_0._id_039B);
    var_7 = _id_0946::_id_BBF1();
    var_8 = int(var_7 * var_6);
    var_9 = self getweaponammostock(var_5);

    if(var_9 >= var_8) {
      return 0;
    }
  }

  if(_id_074E::_id_B4C5(var_4, var_2)) {
    return 1;
  }

  return 0;
}

_id_ED96(var_0, var_1) {
  if(scripts\cp\utility::_id_8941()) {
    return;
  }
  _id_074E::_id_ED93(var_0, 1, var_1);
}

_id_DAAF(var_0) {
  if(!isDefined(var_0)) {}

  switch (var_0) {
    case "bleedoutPenalty":
    case "wondercard_machine":
    case "atm":
      return 0;
    default:
      return 1;
  }
}

_id_68BC(var_0, var_1) {
  var_2 = level._id_8393[var_0._id_039B]._id_3D91;
  var_3 = scripts\cp\utility::_id_6CE3(var_0._id_039B);
  var_4 = var_1 getcurrentweapon();
  var_5 = weaponmaxammo(var_4);
  var_6 = var_1 _id_0946::_id_BBF1();
  var_7 = int(var_6 * var_5);
  var_8 = var_1 getweaponammostock(var_4);
  var_9 = self getweaponslistall();

  foreach(var_11 in var_9) {
    var_12 = scripts\cp\utility::_id_6CE3(var_11);

    if(var_12 == scripts\cp\utility::_id_6CE3(var_0._id_039B)) {
      var_13 = var_11;
      var_8 = self getweaponammostock(var_13);
      var_5 = weaponmaxammo(var_13);
      var_7 = int(var_6 * var_5);
    }
  }

  if(var_0._id_CE18 == "tickets") {
    return level._id_835D[var_0._id_039B];
  }

  switch (var_2) {
    case 250:
      return &"CP_ZMB_INTERACTIONS/TICKETS_AMMO";
    case 1500:
    case 1250:
    case 1000:
    case 500:
      return &"COOP_INTERACTIONS/PURCHASE_AMMO";
    default:
      return &"COOP_INTERACTIONS/PURCHASE_AMMO";
  }
}

_id_459E(var_0, var_1) {
  if(var_1 scripts\cp\cp_weapon::_id_752E(var_0._id_039B)) {
    return _id_68BC(var_0, var_1);
  }

  return undefined;
}

_id_8386() {
  level endon("game_ended");

  for(;;) {
    level waittill("interaction", var_0, var_1, var_2);

    switch (var_0) {
      case "wall_buy":
        if(isDefined(var_2._id_BE31)) {
          if(_func_0205("purchase_ammo")) {
            var_2 scripts\cp\utility::_id_B877("purchase_ammo");
          }
        } else if(_func_0205("purchase_weapon"))
          var_2 scripts\cp\utility::_id_B877("purchase_weapon");

        break;
      case "purchase":
        var_3 = _id_6523(var_1, var_2);

        if(isDefined(var_3) && _func_0205(var_3)) {
          var_2 scripts\cp\utility::_id_B877(var_3);
        }

        break;
      case "purchase_denied":
        var_2 scripts\cp\utility::_id_B877("purchase_deny");
        break;
    }
  }
}

_id_6523(var_0, var_1) {
  var_2 = [];

  switch (var_0._id_039B) {
    case "secure_window":
      return undefined;
    case "lost_and_found":
      var_2 = ["lost_and_found_purchase"];
      break;
    case "blackhole_trap":
    case "scrambler":
    case "interaction_discoballtrap":
    case "beamtrap":
    case "rockettrap":
      var_2 = ["trap_control_panel_purchase"];
      break;
    case "sliding_door":
    case "debris":
      var_2 = ["purchase_door"];
      break;
    case "team_door_switch":
      var_2 = ["purchase_door"];
      break;
    case "atm_deposit":
      var_2 = ["atm_deposit"];
      break;
    case "atm_withdrawal":
      var_2 = ["atm_withdrawal"];
      break;
    case "repair_kevin":
    case "souvenir_pickup":
    case "kevin_battery":
    case "kevin_head":
      var_2 = ["zmb_item_pickup"];
      break;
    case "medium_ticket_prize":
    case "small_ticket_prize":
    case "iw7_forgefreeze_zm+forgefreezealtfire":
    case "zfreeze_semtex_mp":
      var_2 = ["purchase_ticket"];
      break;
    case "large_ticket_prize":
      var_2 = ["ark_purchase"];
      break;
    case "ark_quest_station":
      var_2 = ["ark_turn_in"];
      break;
    default:
      var_2 = ["ark_turn_in"];
      break;
  }

  if(!var_2.size) {
    return undefined;
  }

  return scripts\engine\utility::random(var_2);
}

_id_837A(var_0) {
  if(!isDefined(var_0._id_BA13)) {
    return;
  }
  if(isDefined(level._id_837B)) {
    level thread[[level._id_837B]](var_0, self);
    return;
  }
}

_id_836D(var_0) {
  return var_0._id_039B == "trap_electric" || var_0._id_039B == "trap_firebarrel";
}

_id_835F(var_0) {
  return var_0._id_039B == "atm_withdrawal" || var_0._id_039B == "atm_deposit";
}

_id_8372(var_0) {
  return var_0._id_039B == "secure_window";
}

_id_8363(var_0) {
  return var_0._id_039B == "crafting_station";
}

_id_8367(var_0) {
  return var_0._id_039B == "power_bioSpike" || var_0._id_039B == "power_c4";
}

_id_836A(var_0) {
  return var_0._id_039B == "PvPvE_weapon_pickup";
}

_id_8370(var_0) {
  return var_0._id_039B == "weaponPickup";
}

_id_8366(var_0) {
  return var_0._id_039B == "jaroslav_machine";
}

_id_838E(var_0) {
  return istrue(var_0._id_C588) && !var_0._id_BAD8;
}

_id_836E(var_0, var_1) {
  if(var_1 _meth_8507()) {
    return 0;
  }

  if(var_1 _meth_81CF()) {
    return 0;
  }

  if(isDefined(var_0._id_F615)) {
    return 0;
  }

  if(!scripts\engine\utility::array_contains(level._id_417B, var_0)) {
    return 0;
  }

  if(istrue(var_0._id_ACA3)) {
    level notify("player_accessed_interaction_on_cooldown", var_1);
    return 0;
  }

  if(istrue(var_0._id_7D7E)) {
    return 0;
  }

  if(_id_838E(var_0)) {
    level notify("player_accessed_nonpowered_interaction", var_1);

    if(isDefined(var_0._id_AFC8) && _func_0205("perk_machine_deny")) {
      var_1 playlocalsound("perk_machine_deny");
    } else {
      var_1 scripts\cp\utility::_id_B877("zmb_ui_purchase_deny");
    }

    return 0;
  }

  if(isDefined(var_0._id_3D11)) {
    level notify("player_accessed_interaction_on_cooldown", var_1);
    return 0;
  }

  if(scripts\engine\utility::array_contains(var_1._id_4A8B, var_0)) {
    return 0;
  }

  return 1;
}

_id_8365(var_0) {
  return var_0._id_039B == "sequence_interaction";
}

_id_8368(var_0) {
  return var_0._id_039B == "seq_button";
}

_id_8361(var_0) {
  return var_0._id_039B == "chess_piece_selection" || var_0._id_039B == "chess_puzzle_alphabet" || var_0._id_039B == "chess_puzzle_number";
}

_id_8371(var_0) {
  return var_0._id_039B == "weapon_upgrade";
}

_id_836F(var_0) {
  if(isDefined(var_0.name)) {
    return var_0.name == "wall_buy";
  } else {
    return 0;
  }
}

_id_8360(var_0) {
  return isDefined(var_0._id_8797) && var_0._id_8797;
}

_id_8364(var_0) {
  return var_0._id_039B == "debris_350" || var_0._id_039B == "debris_750" || var_0._id_039B == "debris_1000" || var_0._id_039B == "debris_1250" || var_0._id_039B == "debris_1500" || var_0._id_039B == "debris_2000" || var_0._id_039B == "1v1_stairway_door" || var_0._id_039B == "1v1_exit_door" || var_0._id_039B == "team_door_switch" || var_0._id_039B == "team_door";
}

_id_836B(var_0) {
  return var_0._id_039B == "power_door_sliding" || var_0._id_039B == "team_door_switch" || var_0._id_039B == "1v1_stairway_door" || var_0._id_039B == "1v1_exit_door" || var_0._id_039B == "team_door";
}

_id_8362(var_0) {
  return var_0._id_039B == "chi_0" || var_0._id_039B == "chi_1" || var_0._id_039B == "chi_2";
}

_id_836C(var_0) {
  return var_0._id_039B == "small_ticket_prize" || var_0._id_039B == "medium_ticket_prize" || var_0._id_039B == "arcade_counter_grenade" || var_0._id_039B == "arcade_counter_ammo" || var_0._id_039B == "large_ticket_prize" || var_0._id_039B == "zfreeze_semtex_mp" || var_0._id_039B == "iw7_forgefreeze_zm+forgefreezealtfire" || var_0._id_039B == "gold_teeth";
}

_id_8385(var_0, var_1, var_2, var_3) {
  thread _id_835A(var_0, var_1, var_2, var_3);
}

_id_835A(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level notify("interaction", "purchase_denied", level._id_8393[var_0._id_039B], self);
  self._id_4668 = 1;
  self._id_8388 sethintstring(var_1);
  wait 1;
  self._id_4668 = undefined;
  _id_D25F(self._id_8388, var_0);
}

_id_8355(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_0._id_039B, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_4.target == var_0.target) {
      var_4._id_3D11 = 1;
    }
  }

  if(istrue(level._id_3D08)) {
    wait 1;
  } else {
    level scripts\engine\utility::_id_108A7(var_1, "override_cooldowns");
  }

  foreach(var_4 in var_2) {
    if(var_4.target == var_0.target) {
      var_4._id_3D11 = undefined;
    }
  }

  level refresh_all_players_interaction(var_2);
}

refresh_all_players_interaction(var_0) {
  var_1 = 5184;

  foreach(var_3 in level.players) {
    foreach(var_5 in var_0) {
      if(distancesquared(var_3.origin, var_5.origin) >= var_1) {
        continue;
      }
      var_3 _id_C1A2();
    }
  }
}

_id_C1A2() {
  self notify("stop_interaction_logic");
  _id_D1A5(undefined);

  if(isDefined(self._id_8388)) {
    self._id_8388 sethintstring("");
  }
}

_id_4A68() {
  var_0 = scripts\engine\utility::getstructarray("interaction", "targetname");

  foreach(var_2 in var_0) {
    if(_id_836F(var_2) || _id_8367(var_2) || _id_836C(var_2) || isDefined(var_2._id_CE18) && var_2._id_CE18 == "tickets") {
      var_2._id_4A88 = 1;
      continue;
    }
  }
}

set_custom_search_distance_on_structs(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2]._id_425E = var_1;
  }
}

add_interaction_markers(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    add_interaction_marker_internal(var_0[var_4], var_1, var_2, var_3);
  }
}

add_interaction_marker_internal(var_0, var_1, var_2, var_3) {
  var_4 = instantiate_interaction_marker_params(var_0, var_1, var_2, var_3);
  var_0.markerlabel = var_1;
  var_0.instanceindex = _id_0987::add_instanced_objective_marker(var_0.markerlabel, var_4);
}

instantiate_interaction_marker_params(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_E747 = "active";
  var_4._id_96CF = var_0.origin;

  if(isDefined(var_2)) {
    var_4._id_7C3B = var_2;
  } else {
    var_4._id_7C3B = "icon_waypoint_objective_general";
  }

  var_4.minimapiconsize = "icon_regular";

  if(istrue(var_3)) {
    var_4.hideonminimapwhenclipped = 0;
  } else {
    var_4.hideonminimapwhenclipped = 1;
  }

  var_4.setbackground = 1;
  return var_4;
}

_id_E30C(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("interactions_initialized");

  if(isDefined(var_0._id_CDC1)) {
    var_2 = spawn("script_model", var_1.origin);

    if(isDefined(var_1.angles)) {
      var_2.angles = var_1.angles;
    }

    var_2 setModel(var_0._id_CDC1);

    if(isDefined(var_0._id_EEE8)) {
      var_0._id_EEE8[var_0._id_EEE8.size] = var_2;
    }
  }
}
/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\colors.gsc
*********************************/

init_colors() {
  if(!scripts\engine\utility::add_init_script("colors", ::init_colors)) {
    return;
  }

  scripts\engine\utility::flag_init("respawn_friendlies");
}

func_957E() {
  var_00 = getallnodes();
  scripts\engine\utility::flag_init("player_looks_away_from_spawner");
  scripts\engine\utility::flag_init("friendly_spawner_locked");
  level.var_22DD = [];
  level.var_22DD["axis"] = [];
  level.var_22DD["allies"] = [];
  level.var_22DF = [];
  level.var_22DF["axis"] = [];
  level.var_22DF["allies"] = [];
  var_01 = [];
  var_01 = scripts\engine\utility::array_combine(var_01, getEntArray("trigger_multiple", "code_classname"));
  var_01 = scripts\engine\utility::array_combine(var_01, getEntArray("trigger_radius", "code_classname"));
  var_01 = scripts\engine\utility::array_combine(var_01, getEntArray("trigger_once", "code_classname"));
  level.var_43A0 = [];
  level.var_43A0["allies"] = "allies";
  level.var_43A0["axis"] = "axis";
  level.var_43A0["team3"] = "axis";
  level.var_43A0["neutral"] = "neutral";
  var_02 = getEntArray("info_volume", "code_classname");
  foreach(var_04 in var_00) {
    if(isDefined(var_04.var_ED33)) {
      var_04 func_171E(var_04.var_ED33, "allies");
    }

    if(isDefined(var_04.var_ED34)) {
      var_04 func_171E(var_04.var_ED34, "axis");
    }
  }

  foreach(var_07 in var_02) {
    if(isDefined(var_07.var_ED33)) {
      var_07 func_178C(var_07.var_ED33, "allies");
    }

    if(isDefined(var_07.var_ED34)) {
      var_07 func_178C(var_07.var_ED34, "axis");
    }
  }

  foreach(var_0A in var_01) {
    if(isDefined(var_0A.var_ED33)) {
      var_0A thread func_12757(var_0A.var_ED33, "allies");
    }

    if(isDefined(var_0A.var_ED34)) {
      var_0A thread func_12757(var_0A.var_ED34, "axis");
    }
  }

  level.var_439B = [];
  func_16B5("BAD NODE");
  func_16B5("Cover Stand");
  func_16B5("Cover Crouch");
  func_16B5("Cover Prone");
  func_16B5("Cover Crouch Window");
  func_16B5("Cover Right");
  func_16B5("Cover Left");
  func_16B5("Cover Wide Left");
  func_16B5("Cover Wide Right");
  func_16B5("Conceal Stand");
  func_16B5("Conceal Crouch");
  func_16B5("Conceal Prone");
  func_16B5("Reacquire");
  func_16B5("Balcony");
  func_16B5("Scripted");
  func_16B5("Begin");
  func_16B5("End");
  func_16B5("Turret");
  func_1729("Ambush");
  func_1729("Guard");
  func_1729("Path");
  func_1729("Path 3D");
  func_1729("Exposed");
  func_1729("Exposed 3D");
  func_1729("Cover 3D");
  func_1729("Cover Stand 3D");
  func_16B5("Begin 3D");
  func_16B5("End 3D");
  level.var_43A8 = [];
  level.var_43A8[level.var_43A8.size] = "r";
  level.var_43A8[level.var_43A8.size] = "b";
  level.var_43A8[level.var_43A8.size] = "y";
  level.var_43A8[level.var_43A8.size] = "c";
  level.var_43A8[level.var_43A8.size] = "g";
  level.var_43A8[level.var_43A8.size] = "p";
  level.var_43A8[level.var_43A8.size] = "o";
  level.var_43A3["red"] = "r";
  level.var_43A3["r"] = "r";
  level.var_43A3["blue"] = "b";
  level.var_43A3["b"] = "b";
  level.var_43A3["yellow"] = "y";
  level.var_43A3["y"] = "y";
  level.var_43A3["cyan"] = "c";
  level.var_43A3["c"] = "c";
  level.var_43A3["green"] = "g";
  level.var_43A3["g"] = "g";
  level.var_43A3["purple"] = "p";
  level.var_43A3["p"] = "p";
  level.var_43A3["orange"] = "o";
  level.var_43A3["o"] = "o";
  level.var_4BE0 = [];
  level.var_4BE0["allies"] = [];
  level.var_4BE0["axis"] = [];
  level.var_A95D = [];
  level.var_A95D["allies"] = [];
  level.var_A95D["axis"] = [];
  foreach(var_0D in level.var_43A8) {
    level.var_22E0["allies"][var_0D] = [];
    level.var_22E0["axis"][var_0D] = [];
    level.var_4BE0["allies"][var_0D] = undefined;
    level.var_4BE0["axis"][var_0D] = undefined;
  }

  thread func_CFD2();
  var_0F = getspawnerteamarray("allies");
  level.var_11AE = [];
  foreach(var_11 in var_0F) {
    level.var_11AE[var_11.classname] = var_11;
  }
}

func_45ED() {
  self.var_EDAD = level.var_43A3[self.var_EDAD];
}

func_19CE(param_00) {
  if(isDefined(self.var_EDAD)) {
    func_45ED();
    self.var_4BDF = param_00;
    var_01 = self.var_EDAD;
    level.var_22E0[func_7CE4()][var_01] = ::scripts\engine\utility::array_add(level.var_22E0[func_7CE4()][var_01], self);
    thread _meth_8467();
  }
}

_meth_8467() {
  if(!isDefined(self.var_4BDF)) {
    return;
  }

  var_00 = level.var_22DD[func_7CE4()][self.var_4BDF];
  func_AB3A();
  if(!isalive(self)) {
    return;
  }

  if(!scripts\sp\utility::func_8B6C()) {
    return;
  }

  if(!isDefined(var_00)) {
    var_01 = level.var_22DF[func_7CE4()][self.var_4BDF];
    func_F21B(var_01, self.var_4BDF);
    return;
  }

  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    if(isalive(var_03.var_43A2) && !isplayer(var_03.var_43A2)) {
      continue;
    }

    thread func_19E1(var_03);
    thread decrementcolorusers(var_03);
    return;
  }

  func_C002();
}

func_C002() {}

func_78D2() {
  var_00 = [];
  var_00[var_00.size] = "r";
  var_00[var_00.size] = "b";
  var_00[var_00.size] = "y";
  var_00[var_00.size] = "c";
  var_00[var_00.size] = "g";
  var_00[var_00.size] = "p";
  var_00[var_00.size] = "o";
  return var_00;
}

func_22AE(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_01[var_03] = 1;
  }

  var_05 = [];
  foreach(var_08, var_07 in var_01) {
    var_05[var_05.size] = var_08;
  }

  return var_05;
}

func_78D9(param_00, param_01) {
  return func_78D7(param_00, param_01);
}

func_78D7(param_00, param_01) {
  var_02 = strtok(param_00, " ");
  var_02 = func_22AE(var_02);
  var_03 = [];
  var_04 = [];
  var_05 = [];
  var_06 = func_78D2();
  foreach(var_08 in var_02) {
    var_09 = undefined;
    foreach(var_09 in var_06) {
      if(issubstr(var_08, var_09)) {
        break;
      }
    }

    if(!func_43A4(param_01, var_08)) {
      continue;
    }

    var_04[var_09] = var_08;
    var_03[var_03.size] = var_09;
    var_05[var_05.size] = var_08;
  }

  var_02 = var_05;
  var_0D = [];
  var_0D["colorCodes"] = var_02;
  var_0D["colorCodesByColorIndex"] = var_04;
  var_0D["colors"] = var_03;
  return var_0D;
}

func_43A4(param_00, param_01) {
  if(isDefined(level.var_22DD[param_00][param_01])) {
    return 1;
  }

  return isDefined(level.var_22DF[param_00][param_01]);
}

func_12757(param_00, param_01) {
  self endon("death");
  for(;;) {
    self waittill("trigger");
    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    func_78D8(param_00, param_01);
    if(isDefined(self.var_EE6C) && self.var_EE6C) {
      thread func_12732();
    }
  }
}

func_12732() {
  var_00 = [];
  var_01[0] = self;
  while(var_01.size) {
    var_02 = [];
    foreach(var_04 in var_01) {
      var_00[var_00.size] = var_04;
      if(!isDefined(var_04.var_336)) {
        continue;
      }

      var_05 = getEntArray(var_04.var_336, "target");
      foreach(var_07 in var_05) {
        var_02[var_02.size] = var_07;
      }

      var_05 = undefined;
    }

    var_01 = [];
    foreach(var_0B in var_02) {
      if(!isDefined(var_0B.var_ED33) && !isDefined(var_0B.var_ED34)) {
        continue;
      }

      var_01[var_01.size] = var_0B;
    }
  }

  scripts\sp\utility::func_228A(var_00);
}

func_159B(param_00) {
  if(param_00 == "allies") {
    thread func_78D8(self.var_ED33, param_00);
    return;
  }

  thread func_78D8(self.var_ED34, param_00);
}

func_78D8(param_00, param_01) {
  var_02 = func_78D9(param_00, param_01);
  var_03 = var_02["colorCodes"];
  var_04 = var_02["colorCodesByColorIndex"];
  var_05 = var_02["colors"];
  func_159A(var_03, var_05, param_01, var_04);
}

func_159A(param_00, param_01, param_02, param_03) {
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    if(!isDefined(level.var_22DE[param_02][param_00[var_04]])) {
      continue;
    }

    level.var_22DE[param_02][param_00[var_04]] = ::scripts\engine\utility::array_removeundefined(level.var_22DE[param_02][param_00[var_04]]);
    for(var_05 = 0; var_05 < level.var_22DE[param_02][param_00[var_04]].size; var_05++) {
      level.var_22DE[param_02][param_00[var_04]][var_05].var_4BDF = param_00[var_04];
    }
  }

  foreach(var_07 in param_01) {
    level.var_22E0[param_02][var_07] = ::scripts\sp\utility::func_22B9(level.var_22E0[param_02][var_07]);
    level.var_A95D[param_02][var_07] = level.var_4BE0[param_02][var_07];
    level.var_4BE0[param_02][var_07] = param_03[var_07];
  }

  var_0B = [];
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    if(func_EB12(param_02, param_01[var_04])) {
      continue;
    }

    var_0C = param_00[var_04];
    if(!isDefined(level.var_22DC[param_02][var_0C])) {
      continue;
    }

    var_0B[var_0C] = func_9F85(var_0C, param_01[var_04], param_02);
  }

  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    var_0C = param_00[var_04];
    if(!isDefined(var_0B[var_0C])) {
      continue;
    }

    if(func_EB12(param_02, param_01[var_04])) {
      continue;
    }

    if(!isDefined(level.var_22DC[param_02][var_0C])) {
      continue;
    }

    func_9F83(var_0C, param_01[var_04], param_02, var_0B[var_0C]);
  }
}

func_EB12(param_00, param_01) {
  if(!isDefined(level.var_A95D[param_00][param_01])) {
    return 0;
  }

  return level.var_A95D[param_00][param_01] == level.var_4BE0[param_00][param_01];
}

func_D968(param_00, param_01) {
  if(issubstr(param_00.var_ED33, param_01)) {
    self.var_4709[self.var_4709.size] = param_00;
    return;
  }

  self.var_4708[self.var_4708.size] = param_00;
}

func_D969(param_00, param_01) {
  if(issubstr(param_00.var_ED34, param_01)) {
    self.var_4709[self.var_4709.size] = param_00;
    return;
  }

  self.var_4708[self.var_4708.size] = param_00;
}

func_D967(param_00, param_01) {
  self.var_4708[self.var_4708.size] = param_00;
}

func_D982(param_00, param_01) {
  self.var_C961[self.var_C961.size] = param_00;
}

func_D923(param_00, param_01, param_02) {
  var_03 = level.var_22DD[param_00][param_01];
  var_04 = spawnStruct();
  var_04.var_C961 = [];
  var_04.var_4708 = [];
  var_04.var_4709 = [];
  var_05 = isDefined(level.var_A95D[param_00][param_02]);
  for(var_06 = 0; var_06 < var_03.size; var_06++) {
    var_07 = var_03[var_06];
    var_04[[level.var_439B[var_07.type][var_05][param_00]]](var_07, level.var_A95D[param_00][param_02]);
  }

  var_04.var_4708 = scripts\engine\utility::array_randomize(var_04.var_4708);
  var_08 = [];
  var_03 = [];
  foreach(var_0A, var_07 in var_04.var_4708) {
    if(isDefined(var_07.var_ED38)) {
      var_08[var_08.size] = var_07;
      var_03[var_0A] = undefined;
      continue;
    }

    var_03[var_03.size] = var_07;
  }

  for(var_06 = 0; var_06 < var_04.var_4709.size; var_06++) {
    var_03[var_03.size] = var_04.var_4709[var_06];
  }

  for(var_06 = 0; var_06 < var_04.var_C961.size; var_06++) {
    var_03[var_03.size] = var_04.var_C961[var_06];
  }

  foreach(var_07 in var_08) {
    var_03[var_03.size] = var_07;
  }

  level.var_22DD[param_00][param_01] = var_03;
}

func_7BDA(param_00, param_01, param_02) {
  return level.var_22DD[param_00][param_01];
}

func_78D6(param_00, param_01) {
  return level.var_22DF[param_00][param_01];
}

func_9F85(param_00, param_01, param_02) {
  level.var_22DC[param_02][param_00] = ::scripts\sp\utility::func_22B9(level.var_22DC[param_02][param_00]);
  var_03 = level.var_22DC[param_02][param_00];
  var_03 = scripts\engine\utility::array_combine(var_03, level.var_22E0[param_02][param_01]);
  var_04 = [];
  foreach(var_06 in var_03) {
    if(isDefined(var_06.var_4BDF) && var_06.var_4BDF == param_00) {
      continue;
    }

    var_04[var_04.size] = var_06;
  }

  var_03 = var_04;
  if(!var_03.size) {
    return;
  }

  scripts\engine\utility::array_thread(var_03, ::func_AB3A);
  return var_03;
}

func_F21B(param_00, param_01) {
  self notify("stop_color_move");
  self.var_4BDF = param_01;
  if(isDefined(param_00.target)) {
    var_02 = getnode(param_00.target, "targetname");
    if(isDefined(var_02)) {
      self give_more_perk(var_02);
    }
  }

  self.logstring = 0;
  self _meth_82F1(param_00);
}

func_9F83(param_00, param_01, param_02, param_03) {
  var_04 = param_03;
  var_05 = [];
  if(isDefined(level.var_22DD[param_02][param_00])) {
    func_D923(param_02, param_00, param_01);
    var_05 = func_7BDA(param_02, param_00, param_01);
  } else {
    var_06 = func_78D6(param_02, param_00);
    scripts\engine\utility::array_thread(param_03, ::func_F21B, var_06, param_00);
  }

  var_07 = 0;
  var_08 = param_03.size;
  for(var_09 = 0; var_09 < var_05.size; var_09++) {
    var_0A = var_05[var_09];
    if(isalive(var_0A.var_43A2)) {
      continue;
    }

    var_0B = scripts\engine\utility::getclosest(var_0A.origin, param_03);
    param_03 = scripts\engine\utility::array_remove(param_03, var_0B);
    var_0B func_1142E(var_0A, param_00, self, var_07);
    var_07++;
    if(!param_03.size) {
      return;
    }
  }
}

func_1142E(param_00, param_01, param_02, param_03) {
  self notify("stop_color_move");
  self.var_4BDF = param_01;
  thread func_D966(param_00, param_02, param_03);
}

func_CFD2() {
  for(;;) {
    var_00 = undefined;
    if(!isDefined(level.player.target_getindexoftarget)) {
      wait(0.05);
      continue;
    }

    var_01 = level.player.target_getindexoftarget.var_43A2;
    var_00 = level.player.target_getindexoftarget;
    var_00.var_43A2 = level.player;
    for(;;) {
      if(!isDefined(level.player.target_getindexoftarget)) {
        break;
      }

      if(level.player.target_getindexoftarget != var_00) {
        break;
      }

      wait(0.05);
    }

    var_00.var_43A2 = undefined;
    var_00 func_4398();
  }
}

func_4398() {
  if(isDefined(self.var_ED33)) {
    func_439A(self.var_ED33, "allies");
  }

  if(isDefined(self.var_ED34)) {
    func_439A(self.var_ED34, "axis");
  }
}

func_439A(param_00, param_01) {
  if(isDefined(self.var_43A2)) {
    return;
  }

  var_02 = strtok(param_00, " ");
  var_02 = func_22AE(var_02);
  scripts\engine\utility::array_levelthread(var_02, ::func_4399, param_01);
}

func_4399(param_00, param_01) {
  var_02 = param_00[0];
  if(!isDefined(level.var_4BE0[param_01][var_02])) {
    return;
  }

  if(level.var_4BE0[param_01][var_02] != param_00) {
    return;
  }

  var_03 = scripts\sp\utility::func_79C8(param_01, var_02);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_05 = var_03[var_04];
    if(var_05 func_C2D2(param_00)) {
      continue;
    }

    var_05 func_1142E(self, param_00);
    return;
  }
}

func_C2D2(param_00) {
  if(!isDefined(self.var_4BDF)) {
    return 0;
  }

  return self.var_4BDF == param_00;
}

func_19E1(param_00) {
  self endon("death");
  self endon("stop_color_move");
  func_BE08();
  thread func_19E0(param_00);
}

func_19E0(param_00) {
  self notify("stop_going_to_node");
  func_F3D2(param_00);
  var_01 = level.var_22DF[func_7CE4()][self.var_4BDF];
  if(isDefined(self.var_ED27)) {
    thread func_3A57(param_00, var_01);
  }
}

func_F3D2(param_00) {
  if(isDefined(self.var_43A9)) {
    self thread[[self.var_43A9]](param_00);
  }

  if(isDefined(self.var_11B0)) {
    thread scripts\sp\anim::func_1F32(self, self.var_11B0);
    self.var_11B0 = undefined;
  }

  if(isDefined(self.var_43AB)) {
    self thread[[self.var_43AB]](param_00);
  } else {
    self give_more_perk(param_00);
  }

  if(func_9CFA(param_00)) {
    thread func_72C8(param_00);
  } else if(isDefined(param_00.fgetarg) && param_00.fgetarg > 0) {
    self.objective_playermask_showto = param_00.fgetarg;
  }

  var_01 = level.var_22DF[func_7CE4()][self.var_4BDF];
  if(isDefined(var_01)) {
    self give_laststand(var_01);
  } else {
    self getplayerheadmodel();
  }

  if(isDefined(param_00.lookupsoundlength)) {
    self.lookupsoundlength = param_00.lookupsoundlength;
    return;
  }

  if(isDefined(level.var_6E02)) {
    self.lookupsoundlength = level.var_6E02;
    return;
  }

  self.lookupsoundlength = 64;
}

func_9CFA(param_00) {
  if(!isDefined(self.var_EDB0)) {
    return 0;
  }

  if(!self.var_EDB0) {
    return 0;
  }

  if(!isDefined(param_00.lookupsoundlength)) {
    return 0;
  }

  if(self.logstring) {
    return 0;
  }

  return 1;
}

func_72C8(param_00) {
  self endon("death");
  self endon("stop_going_to_node");
  self.objective_playermask_showto = param_00.lookupsoundlength;
  scripts\engine\utility::waittill_either("goal", "damage");
  if(isDefined(param_00.fgetarg) && param_00.fgetarg > 0) {
    self.objective_playermask_showto = param_00.fgetarg;
  }
}

func_3A57(param_00, param_01) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread func_DDF9(param_00);
  for(;;) {
    func_13689(param_00, param_01);
    func_12FAD(param_00, param_01);
    self.logstring = 1;
    func_F3D2(param_00);
  }
}

func_DDF9(param_00) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.logstring = 1;
  func_F3D2(param_00);
}

func_12FAD(param_00, param_01) {
  self give_mp_super_weapon(self.origin);
  self.objective_playermask_showto = 1024;
  self.logstring = 0;
  if(isDefined(param_01)) {
    for(;;) {
      wait(1);
      if(self _meth_81A8(param_00.origin, self.lookupsoundlength)) {
        continue;
      }

      if(self getteamfallbackspawnpoints(param_01)) {
        continue;
      }

      return;
    }

    return;
  }

  for(;;) {
    if(!func_9E6E(param_00.origin, self.lookupsoundlength)) {
      return;
    }

    wait(1);
  }
}

func_9E6E(param_00, param_01) {
  var_02 = getaiarray("axis");
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(distance2d(var_02[var_03].origin, param_00) < param_01) {
      return 1;
    }
  }

  return 0;
}

func_13689(param_00, param_01) {
  if(isDefined(param_01)) {
    for(;;) {
      if(self _meth_81A8(param_00.origin, self.lookupsoundlength)) {
        return;
      }

      if(self getteamfallbackspawnpoints(param_01)) {
        return;
      }

      wait(1);
    }

    return;
  }

  for(;;) {
    if(func_9E6E(param_00.origin, self.lookupsoundlength)) {
      return;
    }

    wait(1);
  }
}

func_BE08() {
  if(!isDefined(self.target_getindexoftarget)) {
    return 0;
  }

  if(isDefined(self.var_ED35)) {
    wait(self.var_ED35);
    return 1;
  }

  return self.target_getindexoftarget scripts\sp\utility::script_delay();
}

func_D966(param_00, param_01, param_02) {
  thread decrementcolorusers(param_00);
  self endon("stop_color_move");
  self endon("death");
  if(isDefined(param_01)) {
    param_01 scripts\sp\utility::script_delay();
  }

  if(!func_BE08()) {
    if(isDefined(param_02)) {
      wait(param_02 * randomfloatrange(0.2, 0.35));
    }
  }

  func_19E0(param_00);
  self.var_439C = param_00;
  for(;;) {
    self waittill("node_taken", var_03);
    if(isplayer(var_03)) {
      wait(0.05);
    }

    param_00 = func_7860();
    if(isDefined(param_00)) {
      if(isalive(self.var_4397.var_43A2) && self.var_4397.var_43A2 == self) {
        self.var_4397.var_43A2 = undefined;
      }

      self.var_4397 = param_00;
      param_00.var_43A2 = self;
      func_19E0(param_00);
    }
  }
}

func_785F() {
  var_00 = level.var_4BE0[func_7CE4()][self.var_EDAD];
  var_01 = func_7BDA(func_7CE4(), var_00, self.var_EDAD);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(!isalive(var_01[var_02].var_43A2)) {
      return var_01[var_02];
    }
  }
}

func_7860() {
  var_00 = level.var_4BE0[func_7CE4()][self.var_EDAD];
  var_01 = func_7BDA(func_7CE4(), var_00, self.var_EDAD);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] == self.var_4397) {
      continue;
    }

    if(!isalive(var_01[var_02].var_43A2)) {
      return var_01[var_02];
    }
  }
}

func_D987(param_00) {
  self endon("stopScript");
  self endon("death");
  if(isDefined(self.target_getindexoftarget)) {
    return;
  }

  if(distance(param_00.origin, self.origin) < 32) {
    func_DD19(param_00);
    return;
  }

  var_01 = gettime();
  func_135E3(1);
  var_02 = gettime();
  if(var_02 - var_01 >= 1000) {
    func_DD19(param_00);
  }
}

func_135E3(param_00) {
  self endon("killanimscript");
  wait(param_00);
}

func_DD19(param_00) {
  var_01 = getaiarray();
  var_02 = undefined;
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    if(!isDefined(var_01[var_03].target_getindexoftarget)) {
      continue;
    }

    if(var_01[var_03].target_getindexoftarget != param_00) {
      continue;
    }

    var_01[var_03] notify("eject_from_my_node");
    wait(1);
    self notify("eject_from_my_node");
    return 1;
  }

  return 0;
}

decrementcolorusers(param_00) {
  param_00.var_43A2 = self;
  self.var_4397 = param_00;
  self endon("stop_color_move");
  self waittill("death");
  self.var_4397.var_43A2 = undefined;
}

func_43A7(param_00) {
  for(var_01 = 0; var_01 < level.var_43A8.size; var_01++) {
    if(param_00 == level.var_43A8[var_01]) {
      return 1;
    }
  }

  return 0;
}

func_178C(param_00, param_01) {
  var_02 = strtok(param_00, " ");
  var_02 = func_22AE(var_02);
  foreach(var_04 in var_02) {
    level.var_22DF[param_01][var_04] = self;
    level.var_22DC[param_01][var_04] = [];
    level.var_22DE[param_01][var_04] = [];
  }
}

func_171E(param_00, param_01) {
  self.var_43A2 = undefined;
  var_02 = strtok(param_00, " ");
  var_02 = func_22AE(var_02);
  foreach(var_04 in var_02) {
    if(isDefined(level.var_22DD[param_01]) && isDefined(level.var_22DD[param_01][var_04])) {
      level.var_22DD[param_01][var_04] = ::scripts\engine\utility::array_add(level.var_22DD[param_01][var_04], self);
      continue;
    }

    level.var_22DD[param_01][var_04][0] = self;
    level.var_22DC[param_01][var_04] = [];
    level.var_22DE[param_01][var_04] = [];
  }
}

func_AB3A() {
  if(!isDefined(self.var_4397)) {
    return;
  }

  if(isDefined(self.var_4397.var_43A2) && self.var_4397.var_43A2 == self) {
    self.var_4397.var_43A2 = undefined;
  }

  self.var_4397 = undefined;
  self notify("stop_color_move");
}

func_7E3A() {
  var_00 = [];
  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    var_00["team"] = "axis";
    var_00["colorTeam"] = self.var_ED34;
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    var_00["team"] = "allies";
    var_00["colorTeam"] = self.var_ED33;
  }

  if(!isDefined(var_00["colorTeam"])) {
    var_00 = undefined;
  }

  return var_00;
}

func_E16F() {
  var_00 = func_7E3A();
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = var_00["team"];
  var_02 = var_00["colorTeam"];
  var_03 = strtok(var_02, " ");
  var_03 = func_22AE(var_03);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    level.var_22DE[var_01][var_03[var_04]] = ::scripts\engine\utility::array_remove(level.var_22DE[var_01][var_03[var_04]], self);
  }
}

func_16B5(param_00) {
  level.var_439B[param_00][1]["allies"] = ::func_D968;
  level.var_439B[param_00][1]["axis"] = ::func_D969;
  level.var_439B[param_00][0]["allies"] = ::func_D967;
  level.var_439B[param_00][0]["axis"] = ::func_D967;
}

func_1729(param_00) {
  level.var_439B[param_00][1]["allies"] = ::func_D982;
  level.var_439B[param_00][0]["allies"] = ::func_D982;
  level.var_439B[param_00][1]["axis"] = ::func_D982;
  level.var_439B[param_00][0]["axis"] = ::func_D982;
}

func_43AC(param_00, param_01) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_02 = func_10735(param_00, param_01);
  if(isDefined(level.var_73F1)) {
    var_02 thread[[level.var_73F1]]();
  }

  var_02 thread func_43AA();
}

func_43AA() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");
  if(isDefined(self.var_E198)) {
    return;
  }

  self.var_E198 = 1;
  var_00 = self.classname;
  var_01 = self.var_EDAD;
  waittillframeend;
  if(isalive(self)) {
    self waittill("death");
  }

  var_02 = level.var_4B58;
  if(!isDefined(self.var_EDAD)) {
    return;
  }

  thread func_43AC(var_00, self.var_EDAD);
  if(isDefined(self) && isDefined(self.var_EDAD)) {
    var_01 = self.var_EDAD;
  }

  if(isDefined(self) && isDefined(self.origin)) {
    var_03 = self.origin;
  }

  for(;;) {
    if(func_78CE(var_01, var_02) == "none") {
      return;
    }

    var_04 = scripts\sp\utility::func_79C8("allies", var_02[var_01]);
    if(!isDefined(level.var_4392)) {
      var_04 = scripts\sp\utility::func_E0AF(var_04, var_00);
    }

    if(!var_04.size) {
      wait(2);
      continue;
    }

    var_05 = scripts\engine\utility::getclosest(level.player.origin, var_04);
    waittillframeend;
    if(!isalive(var_05)) {
      continue;
    }

    var_05 scripts\sp\utility::func_F3B5(var_01);
    if(isDefined(level.var_73DF)) {
      var_05[[level.var_73DF]](var_01);
    }

    var_01 = var_02[var_01];
  }
}

func_78CE(param_00, param_01) {
  if(!isDefined(param_00)) {
    return "none";
  }

  if(!isDefined(param_01)) {
    return "none";
  }

  if(!isDefined(param_01[param_00])) {
    return "none";
  }

  return param_01[param_00];
}

func_73E7() {
  level.var_73E1 = 1;
  var_00 = 0;
  for(;;) {
    for(;;) {
      if(!func_E289()) {
        break;
      }

      wait(0.05);
    }

    wait(1);
    if(!isDefined(level.respawn_threshold)) {
      continue;
    }

    var_01 = level.player.origin - level.respawn_threshold;
    if(length(var_01) < 200) {
      func_D286();
      continue;
    }

    var_02 = anglesToForward((0, level.player getplayerangles()[1], 0));
    var_03 = vectornormalize(var_01);
    var_04 = vectordot(var_02, var_03);
    if(var_04 < 0.2) {
      func_D286();
      continue;
    }

    var_00++;
    if(var_00 < 3) {
      continue;
    }

    scripts\engine\utility::flag_set("player_looks_away_from_spawner");
  }
}

func_78D4(param_00) {
  if(isDefined(param_00)) {
    if(!isDefined(level.var_11AE[param_00])) {
      var_01 = getspawnerteamarray("allies");
      foreach(var_03 in var_01) {
        if(var_03.classname != param_00) {
          continue;
        }

        level.var_11AE[param_00] = var_03;
        break;
      }
    }
  }

  if(!isDefined(param_00)) {
    var_03 = scripts\engine\utility::random(level.var_11AE);
    if(!isDefined(var_03)) {
      var_01 = [];
      foreach(var_06, var_03 in level.var_11AE) {
        if(isDefined(var_03)) {
          var_01[var_06] = var_03;
        }
      }

      level.var_11AE = var_01;
      return scripts\engine\utility::random(level.var_11AE);
    }

    return var_06;
  }

  return level.var_11AE[var_06];
}

func_E289() {
  if(isDefined(level.var_E288)) {
    return 0;
  }

  return scripts\engine\utility::flag("respawn_friendlies");
}

func_13692() {
  if(scripts\engine\utility::flag("player_looks_away_from_spawner")) {
    return;
  }

  level endon("player_looks_away_from_spawner");
  for(;;) {
    if(func_E289()) {
      return;
    }

    wait(0.05);
  }
}

func_10735(param_00, param_01) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_02 = undefined;
  for(;;) {
    if(!func_E289()) {
      if(!isDefined(level.var_73E1)) {
        thread func_73E7();
      }

      for(;;) {
        func_13692();
        scripts\engine\utility::flag_waitopen("friendly_spawner_locked");
        if(scripts\engine\utility::flag("player_looks_away_from_spawner") || func_E289()) {
          break;
        }
      }

      scripts\engine\utility::flag_set("friendly_spawner_locked");
    }

    var_03 = func_78D4(param_00);
    var_03.var_C1 = 1;
    var_04 = var_03.origin;
    var_03.origin = level.respawn_threshold;
    var_02 = var_03 _meth_8393();
    var_03.origin = var_04;
    if(scripts\sp\utility::func_106ED(var_02)) {
      thread func_AEE0();
      wait(1);
      continue;
    }

    level notify("reinforcement_spawned", var_02);
    break;
  }

  for(;;) {
    if(!isDefined(param_01)) {
      break;
    }

    if(func_78CE(param_01, level.var_4B58) == "none") {
      break;
    }

    param_01 = level.var_4B58[param_01];
  }

  if(isDefined(param_01)) {
    var_02 scripts\sp\utility::func_F3B5(param_01);
  }

  thread func_AEE0();
  return var_02;
}

func_AEE0() {
  scripts\engine\utility::flag_set("friendly_spawner_locked");
  if(isDefined(level.var_73E0)) {
    [[level.var_73E0]]();
  } else {
    wait(2);
  }

  scripts\engine\utility::flag_clear("friendly_spawner_locked");
}

func_D286() {
  var_00 = 0;
  scripts\engine\utility::flag_clear("player_looks_away_from_spawner");
}

func_A5C7() {
  scripts\engine\utility::flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  var_00 = getaiarray();
  scripts\engine\utility::array_thread(var_00, ::func_E07E);
}

func_E07E() {
  self.var_E198 = undefined;
}

func_7CE4(param_00) {
  if(isDefined(self.team) && !isDefined(param_00)) {
    param_00 = self.team;
  }

  return level.var_43A0[param_00];
}
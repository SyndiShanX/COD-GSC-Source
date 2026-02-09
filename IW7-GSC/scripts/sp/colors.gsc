/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\colors.gsc
*********************************************/

init_colors() {
  if(!scripts\engine\utility::add_init_script("colors", ::init_colors)) {
    return;
  }

  scripts\engine\utility::flag_init("respawn_friendlies");
}

func_957E() {
  var_0 = getallnodes();
  scripts\engine\utility::flag_init("player_looks_away_from_spawner");
  scripts\engine\utility::flag_init("friendly_spawner_locked");
  level.var_22DD = [];
  level.var_22DD["axis"] = [];
  level.var_22DD["allies"] = [];
  level.var_22DF = [];
  level.var_22DF["axis"] = [];
  level.var_22DF["allies"] = [];
  var_1 = [];
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("trigger_multiple", "code_classname"));
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("trigger_radius", "code_classname"));
  var_1 = scripts\engine\utility::array_combine(var_1, getEntArray("trigger_once", "code_classname"));
  level.var_43A0 = [];
  level.var_43A0["allies"] = "allies";
  level.var_43A0["axis"] = "axis";
  level.var_43A0["team3"] = "axis";
  level.var_43A0["neutral"] = "neutral";
  var_2 = getEntArray("info_volume", "code_classname");
  foreach(var_4 in var_0) {
    if(isDefined(var_4.var_ED33)) {
      var_4 func_171E(var_4.var_ED33, "allies");
    }

    if(isDefined(var_4.var_ED34)) {
      var_4 func_171E(var_4.var_ED34, "axis");
    }
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_7.var_ED33)) {
      var_7 func_178C(var_7.var_ED33, "allies");
    }

    if(isDefined(var_7.var_ED34)) {
      var_7 func_178C(var_7.var_ED34, "axis");
    }
  }

  foreach(var_10 in var_1) {
    if(isDefined(var_10.var_ED33)) {
      var_10 thread func_12757(var_10.var_ED33, "allies");
    }

    if(isDefined(var_10.var_ED34)) {
      var_10 thread func_12757(var_10.var_ED34, "axis");
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
  foreach(var_13 in level.var_43A8) {
    level.var_22E0["allies"][var_13] = [];
    level.var_22E0["axis"][var_13] = [];
    level.var_4BE0["allies"][var_13] = undefined;
    level.var_4BE0["axis"][var_13] = undefined;
  }

  thread func_CFD2();
  var_15 = getspawnerteamarray("allies");
  level.var_11AE = [];
  foreach(var_11 in var_15) {
    level.var_11AE[var_11.classname] = var_11;
  }
}

func_45ED() {
  self.var_EDAD = level.var_43A3[self.var_EDAD];
}

func_19CE(var_0) {
  if(isDefined(self.var_EDAD)) {
    func_45ED();
    self.var_4BDF = var_0;
    var_1 = self.var_EDAD;
    level.var_22E0[func_7CE4()][var_1] = ::scripts\engine\utility::array_add(level.var_22E0[func_7CE4()][var_1], self);
    thread func_8467();
  }
}

func_8467() {
  if(!isDefined(self.var_4BDF)) {
    return;
  }

  var_0 = level.var_22DD[func_7CE4()][self.var_4BDF];
  func_AB3A();
  if(!isalive(self)) {
    return;
  }

  if(!scripts\sp\utility::func_8B6C()) {
    return;
  }

  if(!isDefined(var_0)) {
    var_1 = level.var_22DF[func_7CE4()][self.var_4BDF];
    func_F21B(var_1, self.var_4BDF);
    return;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    if(isalive(var_3.var_43A2) && !isPlayer(var_3.var_43A2)) {
      continue;
    }

    thread func_19E1(var_3);
    thread decrementcolorusers(var_3);
    return;
  }

  func_C002();
}

func_C002() {}

func_78D2() {
  var_0 = [];
  var_0[var_0.size] = "r";
  var_0[var_0.size] = "b";
  var_0[var_0.size] = "y";
  var_0[var_0.size] = "c";
  var_0[var_0.size] = "g";
  var_0[var_0.size] = "p";
  var_0[var_0.size] = "o";
  return var_0;
}

func_22AE(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_1[var_3] = 1;
  }

  var_5 = [];
  foreach(var_8, var_7 in var_1) {
    var_5[var_5.size] = var_8;
  }

  return var_5;
}

func_78D9(var_0, var_1) {
  return func_78D7(var_0, var_1);
}

func_78D7(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = func_22AE(var_2);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = func_78D2();
  foreach(var_8 in var_2) {
    var_9 = undefined;
    foreach(var_9 in var_6) {
      if(issubstr(var_8, var_9)) {
        break;
      }
    }

    if(!func_43A4(var_1, var_8)) {
      continue;
    }

    var_4[var_9] = var_8;
    var_3[var_3.size] = var_9;
    var_5[var_5.size] = var_8;
  }

  var_2 = var_5;
  var_13 = [];
  var_13["colorCodes"] = var_2;
  var_13["colorCodesByColorIndex"] = var_4;
  var_13["colors"] = var_3;
  return var_13;
}

func_43A4(var_0, var_1) {
  if(isDefined(level.var_22DD[var_0][var_1])) {
    return 1;
  }

  return isDefined(level.var_22DF[var_0][var_1]);
}

func_12757(var_0, var_1) {
  self endon("death");
  for(;;) {
    self waittill("trigger");
    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    func_78D8(var_0, var_1);
    if(isDefined(self.var_EE6C) && self.var_EE6C) {
      thread func_12732();
    }
  }
}

func_12732() {
  var_0 = [];
  var_1[0] = self;
  while(var_1.size) {
    var_2 = [];
    foreach(var_4 in var_1) {
      var_0[var_0.size] = var_4;
      if(!isDefined(var_4.var_336)) {
        continue;
      }

      var_5 = getEntArray(var_4.var_336, "target");
      foreach(var_7 in var_5) {
        var_2[var_2.size] = var_7;
      }

      var_5 = undefined;
    }

    var_1 = [];
    foreach(var_11 in var_2) {
      if(!isDefined(var_11.var_ED33) && !isDefined(var_11.var_ED34)) {
        continue;
      }

      var_1[var_1.size] = var_11;
    }
  }

  scripts\sp\utility::func_228A(var_0);
}

func_159B(var_0) {
  if(var_0 == "allies") {
    thread func_78D8(self.var_ED33, var_0);
    return;
  }

  thread func_78D8(self.var_ED34, var_0);
}

func_78D8(var_0, var_1) {
  var_2 = func_78D9(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];
  func_159A(var_3, var_5, var_1, var_4);
}

func_159A(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(level.var_22DE[var_2][var_0[var_4]])) {
      continue;
    }

    level.var_22DE[var_2][var_0[var_4]] = ::scripts\engine\utility::array_removeundefined(level.var_22DE[var_2][var_0[var_4]]);
    for(var_5 = 0; var_5 < level.var_22DE[var_2][var_0[var_4]].size; var_5++) {
      level.var_22DE[var_2][var_0[var_4]][var_5].var_4BDF = var_0[var_4];
    }
  }

  foreach(var_7 in var_1) {
    level.var_22E0[var_2][var_7] = ::scripts\sp\utility::func_22B9(level.var_22E0[var_2][var_7]);
    level.var_A95D[var_2][var_7] = level.var_4BE0[var_2][var_7];
    level.var_4BE0[var_2][var_7] = var_3[var_7];
  }

  var_11 = [];
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(func_EB12(var_2, var_1[var_4])) {
      continue;
    }

    var_12 = var_0[var_4];
    if(!isDefined(level.var_22DC[var_2][var_12])) {
      continue;
    }

    var_11[var_12] = func_9F85(var_12, var_1[var_4], var_2);
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_12 = var_0[var_4];
    if(!isDefined(var_11[var_12])) {
      continue;
    }

    if(func_EB12(var_2, var_1[var_4])) {
      continue;
    }

    if(!isDefined(level.var_22DC[var_2][var_12])) {
      continue;
    }

    func_9F83(var_12, var_1[var_4], var_2, var_11[var_12]);
  }
}

func_EB12(var_0, var_1) {
  if(!isDefined(level.var_A95D[var_0][var_1])) {
    return 0;
  }

  return level.var_A95D[var_0][var_1] == level.var_4BE0[var_0][var_1];
}

func_D968(var_0, var_1) {
  if(issubstr(var_0.var_ED33, var_1)) {
    self.var_4709[self.var_4709.size] = var_0;
    return;
  }

  self.var_4708[self.var_4708.size] = var_0;
}

func_D969(var_0, var_1) {
  if(issubstr(var_0.var_ED34, var_1)) {
    self.var_4709[self.var_4709.size] = var_0;
    return;
  }

  self.var_4708[self.var_4708.size] = var_0;
}

func_D967(var_0, var_1) {
  self.var_4708[self.var_4708.size] = var_0;
}

func_D982(var_0, var_1) {
  self.var_C961[self.var_C961.size] = var_0;
}

func_D923(var_0, var_1, var_2) {
  var_3 = level.var_22DD[var_0][var_1];
  var_4 = spawnStruct();
  var_4.var_C961 = [];
  var_4.var_4708 = [];
  var_4.var_4709 = [];
  var_5 = isDefined(level.var_A95D[var_0][var_2]);
  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = var_3[var_6];
    var_4[[level.var_439B[var_7.type][var_5][var_0]]](var_7, level.var_A95D[var_0][var_2]);
  }

  var_4.var_4708 = scripts\engine\utility::array_randomize(var_4.var_4708);
  var_8 = [];
  var_3 = [];
  foreach(var_10, var_7 in var_4.var_4708) {
    if(isDefined(var_7.var_ED38)) {
      var_8[var_8.size] = var_7;
      var_3[var_10] = undefined;
      continue;
    }

    var_3[var_3.size] = var_7;
  }

  for(var_6 = 0; var_6 < var_4.var_4709.size; var_6++) {
    var_3[var_3.size] = var_4.var_4709[var_6];
  }

  for(var_6 = 0; var_6 < var_4.var_C961.size; var_6++) {
    var_3[var_3.size] = var_4.var_C961[var_6];
  }

  foreach(var_7 in var_8) {
    var_3[var_3.size] = var_7;
  }

  level.var_22DD[var_0][var_1] = var_3;
}

func_7BDA(var_0, var_1, var_2) {
  return level.var_22DD[var_0][var_1];
}

func_78D6(var_0, var_1) {
  return level.var_22DF[var_0][var_1];
}

func_9F85(var_0, var_1, var_2) {
  level.var_22DC[var_2][var_0] = ::scripts\sp\utility::func_22B9(level.var_22DC[var_2][var_0]);
  var_3 = level.var_22DC[var_2][var_0];
  var_3 = scripts\engine\utility::array_combine(var_3, level.var_22E0[var_2][var_1]);
  var_4 = [];
  foreach(var_6 in var_3) {
    if(isDefined(var_6.var_4BDF) && var_6.var_4BDF == var_0) {
      continue;
    }

    var_4[var_4.size] = var_6;
  }

  var_3 = var_4;
  if(!var_3.size) {
    return;
  }

  scripts\engine\utility::array_thread(var_3, ::func_AB3A);
  return var_3;
}

func_F21B(var_0, var_1) {
  self notify("stop_color_move");
  self.var_4BDF = var_1;
  if(isDefined(var_0.target)) {
    var_2 = getnode(var_0.target, "targetname");
    if(isDefined(var_2)) {
      self give_more_perk(var_2);
    }
  }

  self.logstring = 0;
  self func_82F1(var_0);
}

func_9F83(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_5 = [];
  if(isDefined(level.var_22DD[var_2][var_0])) {
    func_D923(var_2, var_0, var_1);
    var_5 = func_7BDA(var_2, var_0, var_1);
  } else {
    var_6 = func_78D6(var_2, var_0);
    scripts\engine\utility::array_thread(var_3, ::func_F21B, var_6, var_0);
  }

  var_7 = 0;
  var_8 = var_3.size;
  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    var_10 = var_5[var_9];
    if(isalive(var_10.var_43A2)) {
      continue;
    }

    var_11 = scripts\engine\utility::getclosest(var_10.origin, var_3);
    var_3 = scripts\engine\utility::array_remove(var_3, var_11);
    var_11 func_1142E(var_10, var_0, self, var_7);
    var_7++;
    if(!var_3.size) {
      return;
    }
  }
}

func_1142E(var_0, var_1, var_2, var_3) {
  self notify("stop_color_move");
  self.var_4BDF = var_1;
  thread func_D966(var_0, var_2, var_3);
}

func_CFD2() {
  for(;;) {
    var_0 = undefined;
    if(!isDefined(level.player.node)) {
      wait(0.05);
      continue;
    }

    var_1 = level.player.node.var_43A2;
    var_0 = level.player.node;
    var_0.var_43A2 = level.player;
    for(;;) {
      if(!isDefined(level.player.node)) {
        break;
      }

      if(level.player.node != var_0) {
        break;
      }

      wait(0.05);
    }

    var_0.var_43A2 = undefined;
    var_0 func_4398();
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

func_439A(var_0, var_1) {
  if(isDefined(self.var_43A2)) {
    return;
  }

  var_2 = strtok(var_0, " ");
  var_2 = func_22AE(var_2);
  scripts\engine\utility::array_levelthread(var_2, ::func_4399, var_1);
}

func_4399(var_0, var_1) {
  var_2 = var_0[0];
  if(!isDefined(level.var_4BE0[var_1][var_2])) {
    return;
  }

  if(level.var_4BE0[var_1][var_2] != var_0) {
    return;
  }

  var_3 = scripts\sp\utility::func_79C8(var_1, var_2);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];
    if(var_5 func_C2D2(var_0)) {
      continue;
    }

    var_5 func_1142E(self, var_0);
    return;
  }
}

func_C2D2(var_0) {
  if(!isDefined(self.var_4BDF)) {
    return 0;
  }

  return self.var_4BDF == var_0;
}

func_19E1(var_0) {
  self endon("death");
  self endon("stop_color_move");
  func_BE08();
  thread func_19E0(var_0);
}

func_19E0(var_0) {
  self notify("stop_going_to_node");
  func_F3D2(var_0);
  var_1 = level.var_22DF[func_7CE4()][self.var_4BDF];
  if(isDefined(self.var_ED27)) {
    thread func_3A57(var_0, var_1);
  }
}

func_F3D2(var_0) {
  if(isDefined(self.var_43A9)) {
    self thread[[self.var_43A9]](var_0);
  }

  if(isDefined(self.var_11B0)) {
    thread scripts\sp\anim::func_1F32(self, self.var_11B0);
    self.var_11B0 = undefined;
  }

  if(isDefined(self.var_43AB)) {
    self thread[[self.var_43AB]](var_0);
  } else {
    self give_more_perk(var_0);
  }

  if(func_9CFA(var_0)) {
    thread func_72C8(var_0);
  } else if(isDefined(var_0.fgetarg) && var_0.fgetarg > 0) {
    self.objective_playermask_showto = var_0.fgetarg;
  }

  var_1 = level.var_22DF[func_7CE4()][self.var_4BDF];
  if(isDefined(var_1)) {
    self give_laststand(var_1);
  } else {
    self getplayerheadmodel();
  }

  if(isDefined(var_0.lookupsoundlength)) {
    self.lookupsoundlength = var_0.lookupsoundlength;
    return;
  }

  if(isDefined(level.var_6E02)) {
    self.lookupsoundlength = level.var_6E02;
    return;
  }

  self.lookupsoundlength = 64;
}

func_9CFA(var_0) {
  if(!isDefined(self.var_EDB0)) {
    return 0;
  }

  if(!self.var_EDB0) {
    return 0;
  }

  if(!isDefined(var_0.lookupsoundlength)) {
    return 0;
  }

  if(self.logstring) {
    return 0;
  }

  return 1;
}

func_72C8(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self.objective_playermask_showto = var_0.lookupsoundlength;
  scripts\engine\utility::waittill_either("goal", "damage");
  if(isDefined(var_0.fgetarg) && var_0.fgetarg > 0) {
    self.objective_playermask_showto = var_0.fgetarg;
  }
}

func_3A57(var_0, var_1) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread func_DDF9(var_0);
  for(;;) {
    func_13689(var_0, var_1);
    func_12FAD(var_0, var_1);
    self.logstring = 1;
    func_F3D2(var_0);
  }
}

func_DDF9(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.logstring = 1;
  func_F3D2(var_0);
}

func_12FAD(var_0, var_1) {
  self give_mp_super_weapon(self.origin);
  self.objective_playermask_showto = 1024;
  self.logstring = 0;
  if(isDefined(var_1)) {
    for(;;) {
      wait(1);
      if(self func_81A8(var_0.origin, self.lookupsoundlength)) {
        continue;
      }

      if(self getteamfallbackspawnpoints(var_1)) {
        continue;
      }

      return;
    }

    return;
  }

  for(;;) {
    if(!func_9E6E(var_0.origin, self.lookupsoundlength)) {
      return;
    }

    wait(1);
  }
}

func_9E6E(var_0, var_1) {
  var_2 = getaiarray("axis");
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distance2d(var_2[var_3].origin, var_0) < var_1) {
      return 1;
    }
  }

  return 0;
}

func_13689(var_0, var_1) {
  if(isDefined(var_1)) {
    for(;;) {
      if(self func_81A8(var_0.origin, self.lookupsoundlength)) {
        return;
      }

      if(self getteamfallbackspawnpoints(var_1)) {
        return;
      }

      wait(1);
    }

    return;
  }

  for(;;) {
    if(func_9E6E(var_0.origin, self.lookupsoundlength)) {
      return;
    }

    wait(1);
  }
}

func_BE08() {
  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.var_ED35)) {
    wait(self.var_ED35);
    return 1;
  }

  return self.node scripts\sp\utility::script_delay();
}

func_D966(var_0, var_1, var_2) {
  thread decrementcolorusers(var_0);
  self endon("stop_color_move");
  self endon("death");
  if(isDefined(var_1)) {
    var_1 scripts\sp\utility::script_delay();
  }

  if(!func_BE08()) {
    if(isDefined(var_2)) {
      wait(var_2 * randomfloatrange(0.2, 0.35));
    }
  }

  func_19E0(var_0);
  self.var_439C = var_0;
  for(;;) {
    self waittill("node_taken", var_3);
    if(isPlayer(var_3)) {
      wait(0.05);
    }

    var_0 = func_7860();
    if(isDefined(var_0)) {
      if(isalive(self.var_4397.var_43A2) && self.var_4397.var_43A2 == self) {
        self.var_4397.var_43A2 = undefined;
      }

      self.var_4397 = var_0;
      var_0.var_43A2 = self;
      func_19E0(var_0);
    }
  }
}

func_785F() {
  var_0 = level.var_4BE0[func_7CE4()][self.var_EDAD];
  var_1 = func_7BDA(func_7CE4(), var_0, self.var_EDAD);
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2].var_43A2)) {
      return var_1[var_2];
    }
  }
}

func_7860() {
  var_0 = level.var_4BE0[func_7CE4()][self.var_EDAD];
  var_1 = func_7BDA(func_7CE4(), var_0, self.var_EDAD);
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == self.var_4397) {
      continue;
    }

    if(!isalive(var_1[var_2].var_43A2)) {
      return var_1[var_2];
    }
  }
}

func_D987(var_0) {
  self endon("stopScript");
  self endon("death");
  if(isDefined(self.node)) {
    return;
  }

  if(distance(var_0.origin, self.origin) < 32) {
    func_DD19(var_0);
    return;
  }

  var_1 = gettime();
  func_135E3(1);
  var_2 = gettime();
  if(var_2 - var_1 >= 1000) {
    func_DD19(var_0);
  }
}

func_135E3(var_0) {
  self endon("killanimscript");
  wait(var_0);
}

func_DD19(var_0) {
  var_1 = getaiarray();
  var_2 = undefined;
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!isDefined(var_1[var_3].node)) {
      continue;
    }

    if(var_1[var_3].node != var_0) {
      continue;
    }

    var_1[var_3] notify("eject_from_my_node");
    wait(1);
    self notify("eject_from_my_node");
    return 1;
  }

  return 0;
}

decrementcolorusers(var_0) {
  var_0.var_43A2 = self;
  self.var_4397 = var_0;
  self endon("stop_color_move");
  self waittill("death");
  self.var_4397.var_43A2 = undefined;
}

func_43A7(var_0) {
  for(var_1 = 0; var_1 < level.var_43A8.size; var_1++) {
    if(var_0 == level.var_43A8[var_1]) {
      return 1;
    }
  }

  return 0;
}

func_178C(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = func_22AE(var_2);
  foreach(var_4 in var_2) {
    level.var_22DF[var_1][var_4] = self;
    level.var_22DC[var_1][var_4] = [];
    level.var_22DE[var_1][var_4] = [];
  }
}

func_171E(var_0, var_1) {
  self.var_43A2 = undefined;
  var_2 = strtok(var_0, " ");
  var_2 = func_22AE(var_2);
  foreach(var_4 in var_2) {
    if(isDefined(level.var_22DD[var_1]) && isDefined(level.var_22DD[var_1][var_4])) {
      level.var_22DD[var_1][var_4] = ::scripts\engine\utility::array_add(level.var_22DD[var_1][var_4], self);
      continue;
    }

    level.var_22DD[var_1][var_4][0] = self;
    level.var_22DC[var_1][var_4] = [];
    level.var_22DE[var_1][var_4] = [];
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
  var_0 = [];
  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    var_0["team"] = "axis";
    var_0["colorTeam"] = self.var_ED34;
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    var_0["team"] = "allies";
    var_0["colorTeam"] = self.var_ED33;
  }

  if(!isDefined(var_0["colorTeam"])) {
    var_0 = undefined;
  }

  return var_0;
}

func_E16F() {
  var_0 = func_7E3A();
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0["team"];
  var_2 = var_0["colorTeam"];
  var_3 = strtok(var_2, " ");
  var_3 = func_22AE(var_3);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    level.var_22DE[var_1][var_3[var_4]] = ::scripts\engine\utility::array_remove(level.var_22DE[var_1][var_3[var_4]], self);
  }
}

func_16B5(var_0) {
  level.var_439B[var_0][1]["allies"] = ::func_D968;
  level.var_439B[var_0][1]["axis"] = ::func_D969;
  level.var_439B[var_0][0]["allies"] = ::func_D967;
  level.var_439B[var_0][0]["axis"] = ::func_D967;
}

func_1729(var_0) {
  level.var_439B[var_0][1]["allies"] = ::func_D982;
  level.var_439B[var_0][0]["allies"] = ::func_D982;
  level.var_439B[var_0][1]["axis"] = ::func_D982;
  level.var_439B[var_0][0]["axis"] = ::func_D982;
}

func_43AC(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = func_10735(var_0, var_1);
  if(isDefined(level.var_73F1)) {
    var_2 thread[[level.var_73F1]]();
  }

  var_2 thread func_43AA();
}

func_43AA() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");
  if(isDefined(self.var_E198)) {
    return;
  }

  self.var_E198 = 1;
  var_0 = self.classname;
  var_1 = self.var_EDAD;
  waittillframeend;
  if(isalive(self)) {
    self waittill("death");
  }

  var_2 = level.var_4B58;
  if(!isDefined(self.var_EDAD)) {
    return;
  }

  thread func_43AC(var_0, self.var_EDAD);
  if(isDefined(self) && isDefined(self.var_EDAD)) {
    var_1 = self.var_EDAD;
  }

  if(isDefined(self) && isDefined(self.origin)) {
    var_3 = self.origin;
  }

  for(;;) {
    if(func_78CE(var_1, var_2) == "none") {
      return;
    }

    var_4 = scripts\sp\utility::func_79C8("allies", var_2[var_1]);
    if(!isDefined(level.var_4392)) {
      var_4 = scripts\sp\utility::func_E0AF(var_4, var_0);
    }

    if(!var_4.size) {
      wait(2);
      continue;
    }

    var_5 = scripts\engine\utility::getclosest(level.player.origin, var_4);
    waittillframeend;
    if(!isalive(var_5)) {
      continue;
    }

    var_5 scripts\sp\utility::func_F3B5(var_1);
    if(isDefined(level.var_73DF)) {
      var_5[[level.var_73DF]](var_1);
    }

    var_1 = var_2[var_1];
  }
}

func_78CE(var_0, var_1) {
  if(!isDefined(var_0)) {
    return "none";
  }

  if(!isDefined(var_1)) {
    return "none";
  }

  if(!isDefined(var_1[var_0])) {
    return "none";
  }

  return var_1[var_0];
}

func_73E7() {
  level.var_73E1 = 1;
  var_0 = 0;
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

    var_1 = level.player.origin - level.respawn_threshold;
    if(length(var_1) < 200) {
      func_D286();
      continue;
    }

    var_2 = anglesToForward((0, level.player getplayerangles()[1], 0));
    var_3 = vectornormalize(var_1);
    var_4 = vectordot(var_2, var_3);
    if(var_4 < 0.2) {
      func_D286();
      continue;
    }

    var_0++;
    if(var_0 < 3) {
      continue;
    }

    scripts\engine\utility::flag_set("player_looks_away_from_spawner");
  }
}

func_78D4(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level.var_11AE[var_0])) {
      var_1 = getspawnerteamarray("allies");
      foreach(var_3 in var_1) {
        if(var_3.classname != var_0) {
          continue;
        }

        level.var_11AE[var_0] = var_3;
        break;
      }
    }
  }

  if(!isDefined(var_0)) {
    var_3 = scripts\engine\utility::random(level.var_11AE);
    if(!isDefined(var_3)) {
      var_1 = [];
      foreach(var_6, var_3 in level.var_11AE) {
        if(isDefined(var_3)) {
          var_1[var_6] = var_3;
        }
      }

      level.var_11AE = var_1;
      return scripts\engine\utility::random(level.var_11AE);
    }

    return var_6;
  }

  return level.var_11AE[var_6];
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

func_10735(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = undefined;
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

    var_3 = func_78D4(var_0);
    var_3.var_C1 = 1;
    var_4 = var_3.origin;
    var_3.origin = level.respawn_threshold;
    var_2 = var_3 func_8393();
    var_3.origin = var_4;
    if(scripts\sp\utility::func_106ED(var_2)) {
      thread func_AEE0();
      wait(1);
      continue;
    }

    level notify("reinforcement_spawned", var_2);
    break;
  }

  for(;;) {
    if(!isDefined(var_1)) {
      break;
    }

    if(func_78CE(var_1, level.var_4B58) == "none") {
      break;
    }

    var_1 = level.var_4B58[var_1];
  }

  if(isDefined(var_1)) {
    var_2 scripts\sp\utility::func_F3B5(var_1);
  }

  thread func_AEE0();
  return var_2;
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
  var_0 = 0;
  scripts\engine\utility::flag_clear("player_looks_away_from_spawner");
}

func_A5C7() {
  scripts\engine\utility::flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  var_0 = getaiarray();
  scripts\engine\utility::array_thread(var_0, ::func_E07E);
}

func_E07E() {
  self.var_E198 = undefined;
}

func_7CE4(var_0) {
  if(isDefined(self.team) && !isDefined(var_0)) {
    var_0 = self.team;
  }

  return level.var_43A0[var_0];
}
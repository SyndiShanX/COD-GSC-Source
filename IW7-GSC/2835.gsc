/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2835.gsc
***************************************/

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
  level.func_22DD = [];
  level.func_22DD["axis"] = [];
  level.func_22DD["allies"] = [];
  level.func_22DF = [];
  level.func_22DF["axis"] = [];
  level.func_22DF["allies"] = [];
  var_01 = [];
  var_01 = scripts\engine\utility::array_combine(var_01, getEntArray("trigger_multiple", "code_classname"));
  var_01 = scripts\engine\utility::array_combine(var_01, getEntArray("trigger_radius", "code_classname"));
  var_01 = scripts\engine\utility::array_combine(var_01, getEntArray("trigger_once", "code_classname"));
  level.func_43A0 = [];
  level.func_43A0["allies"] = "allies";
  level.func_43A0["axis"] = "axis";
  level.func_43A0["team3"] = "axis";
  level.func_43A0["neutral"] = "neutral";
  var_02 = getEntArray("info_volume", "code_classname");

  foreach(var_04 in var_00) {
    if(isDefined(var_4.func_ED33)) {
      var_04 func_171E(var_4.func_ED33, "allies");
    }

    if(isDefined(var_4.func_ED34)) {
      var_04 func_171E(var_4.func_ED34, "axis");
    }
  }

  foreach(var_07 in var_02) {
    if(isDefined(var_7.func_ED33)) {
      var_07 func_178C(var_7.func_ED33, "allies");
    }

    if(isDefined(var_7.func_ED34)) {
      var_07 func_178C(var_7.func_ED34, "axis");
    }
  }

  foreach(var_10 in var_01) {
    if(isDefined(var_10.func_ED33)) {
      var_10 thread func_12757(var_10.func_ED33, "allies");
    }

    if(isDefined(var_10.func_ED34)) {
      var_10 thread func_12757(var_10.func_ED34, "axis");
    }
  }

  level.func_439B = [];
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
  level.func_43A8 = [];
  level.func_43A8[level.func_43A8.size] = "r";
  level.func_43A8[level.func_43A8.size] = "b";
  level.func_43A8[level.func_43A8.size] = "y";
  level.func_43A8[level.func_43A8.size] = "c";
  level.func_43A8[level.func_43A8.size] = "g";
  level.func_43A8[level.func_43A8.size] = "p";
  level.func_43A8[level.func_43A8.size] = "o";
  level.func_43A3["red"] = "r";
  level.func_43A3["r"] = "r";
  level.func_43A3["blue"] = "b";
  level.func_43A3["b"] = "b";
  level.func_43A3["yellow"] = "y";
  level.func_43A3["y"] = "y";
  level.func_43A3["cyan"] = "c";
  level.func_43A3["c"] = "c";
  level.func_43A3["green"] = "g";
  level.func_43A3["g"] = "g";
  level.func_43A3["purple"] = "p";
  level.func_43A3["p"] = "p";
  level.func_43A3["orange"] = "o";
  level.func_43A3["o"] = "o";
  level.func_4BE0 = [];
  level.func_4BE0["allies"] = [];
  level.func_4BE0["axis"] = [];
  level.func_A95D = [];
  level.func_A95D["allies"] = [];
  level.func_A95D["axis"] = [];

  foreach(var_13 in level.func_43A8) {
    level.func_22E0["allies"][var_13] = [];
    level.func_22E0["axis"][var_13] = [];
    level.func_4BE0["allies"][var_13] = undefined;
    level.func_4BE0["axis"][var_13] = undefined;
  }

  thread func_CFD2();
  var_15 = _getspawnerteamarray("allies");
  level.func_11AE = [];

  foreach(var_17 in var_15) {
  level.func_11AE[var_17.classname] = var_17;
  }
}

func_45ED() {
  self.func_EDAD = level.func_43A3[self.func_EDAD];
}

func_19CE(var_00) {
  if(isDefined(self.func_EDAD)) {
    func_45ED();
    self.func_4BDF = var_00;
    var_01 = self.func_EDAD;
    level.func_22E0[func_7CE4()][var_01] = ::scripts\engine\utility::array_add(level.func_22E0[func_7CE4()][var_01], self);
    thread _meth_8467();
    return;
  }
}

_meth_8467() {
  if(!isDefined(self.func_4BDF)) {
    return;
  }
  var_00 = level.func_22DD[func_7CE4()][self.func_4BDF];
  func_AB3A();

  if(!isalive(self)) {
    return;
  }
  if(!scripts\sp\utility::func_8B6C()) {
    return;
  }
  if(!isDefined(var_00)) {
    var_01 = level.func_22DF[func_7CE4()][self.func_4BDF];
    func_F21B(var_01, self.func_4BDF);
    return;
  }

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_03 = var_0[var_02];

    if(isalive(var_3.func_43A2) && !isplayer(var_3.func_43A2)) {
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
  var_0[var_0.size] = "r";
  var_0[var_0.size] = "b";
  var_0[var_0.size] = "y";
  var_0[var_0.size] = "c";
  var_0[var_0.size] = "g";
  var_0[var_0.size] = "p";
  var_0[var_0.size] = "o";
  return var_00;
}

func_22AE(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
  var_1[var_03] = 1;
  }

  var_05 = [];

  foreach(var_08, var_07 in var_01) {
  var_5[var_5.size] = var_08;
  }

  return var_05;
}

func_78D9(var_00, var_01) {
  return func_78D7(var_00, var_01);
}

func_78D7(var_00, var_01) {
  var_02 = strtok(var_00, " ");
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

    if(!func_43A4(var_01, var_08)) {
      continue;
    }
    var_4[var_09] = var_08;
    var_3[var_3.size] = var_09;
    var_5[var_5.size] = var_08;
  }

  var_02 = var_05;
  var_13 = [];
  var_13["colorCodes"] = var_02;
  var_13["colorCodesByColorIndex"] = var_04;
  var_13["colors"] = var_03;
  return var_13;
}

func_43A4(var_00, var_01) {
  if(isDefined(level.func_22DD[var_00][var_01])) {
    return 1;
  }

  return isDefined(level.func_22DF[var_00][var_01]);
}

func_12757(var_00, var_01) {
  self endon("death");

  for(;;) {
    self waittill("trigger");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    func_78D8(var_00, var_01);

    if(isDefined(self.func_EE6C) && self.func_EE6C) {
      thread func_12732();
    }
  }
}

func_12732() {
  var_00 = [];
  var_1[0] = self;

  while(var_1.size) {
    var_02 = [];

    foreach(var_04 in var_01) {
      var_0[var_0.size] = var_04;

      if(!isDefined(var_4.targetname)) {
        continue;
      }
      var_05 = getEntArray(var_4.targetname, "target");

      foreach(var_07 in var_05) {
      var_2[var_2.size] = var_07;
      }

      var_05 = undefined;
    }

    var_01 = [];

    foreach(var_11 in var_02) {
      if(!isDefined(var_11.func_ED33) && !isDefined(var_11.func_ED34)) {
        continue;
      }
      var_1[var_1.size] = var_11;
    }
  }

  scripts\sp\utility::func_228A(var_00);
}

func_159B(var_00) {
  if(var_00 == "allies") {
    thread func_78D8(self.func_ED33, var_00);
  }
  else {
    thread func_78D8(self.func_ED34, var_00);
  }
}

func_78D8(var_00, var_01) {
  var_02 = func_78D9(var_00, var_01);
  var_03 = var_2["colorCodes"];
  var_04 = var_2["colorCodesByColorIndex"];
  var_05 = var_2["colors"];
  func_159A(var_03, var_05, var_01, var_04);
}

func_159A(var_00, var_01, var_02, var_03) {
  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    if(!isDefined(level.func_22DE[var_02][var_0[var_04]])) {
      continue;
    }
    level.func_22DE[var_02][var_0[var_04]] = ::scripts\engine\utility::array_removeundefined(level.func_22DE[var_02][var_0[var_04]]);

    for(var_05 = 0; var_05 < level.func_22DE[var_02][var_0[var_04]].size; var_5++) {
      level.func_22DE[var_02][var_0[var_04]][var_05].func_4BDF = var_0[var_04];
    }
  }

  foreach(var_07 in var_01) {
    level.func_22E0[var_02][var_07] = ::scripts\sp\utility::func_22B9(level.func_22E0[var_02][var_07]);
    level.func_A95D[var_02][var_07] = level.func_4BE0[var_02][var_07];
    level.func_4BE0[var_02][var_07] = var_3[var_07];
  }

  var_11 = [];

  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    if(func_EB12(var_02, var_1[var_04])) {
      continue;
    }
    var_12 = var_0[var_04];

    if(!isDefined(level.func_22DC[var_02][var_12])) {
      continue;
    }
    var_11[var_12] = func_9F85(var_12, var_1[var_04], var_02);
  }

  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    var_12 = var_0[var_04];

    if(!isDefined(var_11[var_12])) {
      continue;
    }
    if(func_EB12(var_02, var_1[var_04])) {
      continue;
    }
    if(!isDefined(level.func_22DC[var_02][var_12])) {
      continue;
    }
    func_9F83(var_12, var_1[var_04], var_02, var_11[var_12]);
  }
}

func_EB12(var_00, var_01) {
  if(!isDefined(level.func_A95D[var_00][var_01])) {
    return 0;
  }

  return level.func_A95D[var_00][var_01] == level.func_4BE0[var_00][var_01];
}

func_D968(var_00, var_01) {
  if(issubstr(var_0.func_ED33, var_01)) {
    self.func_4709[self.func_4709.size] = var_00;
  }
  else {
    self.func_4708[self.func_4708.size] = var_00;
  }
}

func_D969(var_00, var_01) {
  if(issubstr(var_0.func_ED34, var_01)) {
    self.func_4709[self.func_4709.size] = var_00;
  }
  else {
    self.func_4708[self.func_4708.size] = var_00;
  }
}

func_D967(var_00, var_01) {
  self.func_4708[self.func_4708.size] = var_00;
}

func_D982(var_00, var_01) {
  self.func_C961[self.func_C961.size] = var_00;
}

func_D923(var_00, var_01, var_02) {
  var_03 = level.func_22DD[var_00][var_01];
  var_04 = spawnStruct();
  var_4.func_C961 = [];
  var_4.func_4708 = [];
  var_4.func_4709 = [];
  var_05 = isDefined(level.func_A95D[var_00][var_02]);

  for(var_06 = 0; var_06 < var_3.size; var_6++) {
    var_07 = var_3[var_06];
    var_04[[level.func_439B[var_7.type][var_05][var_00]]](var_07, level.func_A95D[var_00][var_02]);
  }

  var_4.func_4708 = scripts\engine\utility::array_randomize(var_4.func_4708);
  var_08 = [];
  var_03 = [];

  foreach(var_10, var_07 in var_4.func_4708) {
    if(isDefined(var_7.func_ED38)) {
      var_8[var_8.size] = var_07;
      var_3[var_10] = undefined;
      continue;
    }

    var_3[var_3.size] = var_07;
  }

  for(var_06 = 0; var_06 < var_4.func_4709.size; var_6++) {
    var_3[var_3.size] = var_4.func_4709[var_06];
  }

  for(var_06 = 0; var_06 < var_4.func_C961.size; var_6++) {
    var_3[var_3.size] = var_4.func_C961[var_06];
  }

  foreach(var_07 in var_08) {
  var_3[var_3.size] = var_07;
  }

  level.func_22DD[var_00][var_01] = var_03;
}

func_7BDA(var_00, var_01, var_02) {
  return level.func_22DD[var_00][var_01];
}

func_78D6(var_00, var_01) {
  return level.func_22DF[var_00][var_01];
}

func_9F85(var_00, var_01, var_02) {
  level.func_22DC[var_02][var_00] = ::scripts\sp\utility::func_22B9(level.func_22DC[var_02][var_00]);
  var_03 = level.func_22DC[var_02][var_00];
  var_03 = scripts\engine\utility::array_combine(var_03, level.func_22E0[var_02][var_01]);
  var_04 = [];

  foreach(var_06 in var_03) {
    if(isDefined(var_6.func_4BDF) && var_6.func_4BDF == var_00) {
      continue;
    }
    var_4[var_4.size] = var_06;
  }

  var_03 = var_04;

  if(!var_3.size) {
    return;
  }
  scripts\engine\utility::array_thread(var_03, ::func_AB3A);
  return var_03;
}

func_F21B(var_00, var_01) {
  self notify("stop_color_move");
  self.func_4BDF = var_01;

  if(isDefined(var_0.target)) {
    var_02 = getnode(var_0.target, "targetname");

    if(isDefined(var_02)) {
      self give_more_perk(var_02);
    }
  }

  self.fixednode = 0;
  self _meth_82F1(var_00);
}

func_9F83(var_00, var_01, var_02, var_03) {
  var_04 = var_03;
  var_05 = [];

  if(isDefined(level.func_22DD[var_02][var_00])) {
    func_D923(var_02, var_00, var_01);
    var_05 = func_7BDA(var_02, var_00, var_01);
  } else {
    var_06 = func_78D6(var_02, var_00);
    scripts\engine\utility::array_thread(var_03, ::func_F21B, var_06, var_00);
  }

  var_07 = 0;
  var_08 = var_3.size;

  for(var_09 = 0; var_09 < var_5.size; var_9++) {
    var_10 = var_5[var_09];

    if(isalive(var_10.func_43A2)) {
      continue;
    }
    var_11 = scripts\engine\utility::getclosest(var_10.origin, var_03);
    var_03 = scripts\engine\utility::array_remove(var_03, var_11);
    var_11 func_1142E(var_10, var_00, self, var_07);
    var_7++;

    if(!var_3.size) {
      return;
    }
  }
}

func_1142E(var_00, var_01, var_02, var_03) {
  self notify("stop_color_move");
  self.func_4BDF = var_01;
  thread func_D966(var_00, var_02, var_03);
}

func_CFD2() {
  for(;;) {
    var_00 = undefined;

    if(!isDefined(level.player.node)) {
      wait 0.05;
      continue;
    }

    var_01 = level.player.node.func_43A2;
    var_00 = level.player.node;
    var_0.func_43A2 = level.player;

    for(;;) {
      if(!isDefined(level.player.node)) {
        break;
      }
      if(level.player.node != var_00) {
        break;
      }
      wait 0.05;
    }

    var_0.func_43A2 = undefined;
    var_00 func_4398();
  }
}

func_4398() {
  if(isDefined(self.func_ED33)) {
    func_439A(self.func_ED33, "allies");
  }

  if(isDefined(self.func_ED34)) {
    func_439A(self.func_ED34, "axis");
  }
}

func_439A(var_00, var_01) {
  if(isDefined(self.func_43A2)) {
    return;
  }
  var_02 = strtok(var_00, " ");
  var_02 = func_22AE(var_02);
  scripts\engine\utility::array_levelthread(var_02, ::func_4399, var_01);
}

func_4399(var_00, var_01) {
  var_02 = var_0[0];

  if(!isDefined(level.func_4BE0[var_01][var_02])) {
    return;
  }
  if(level.func_4BE0[var_01][var_02] != var_00) {
    return;
  }
  var_03 = scripts\sp\utility::func_79C8(var_01, var_02);

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    var_05 = var_3[var_04];

    if(var_05 func_C2D2(var_00)) {
      continue;
    }
    var_05 func_1142E(self, var_00);
    return;
  }
}

func_C2D2(var_00) {
  if(!isDefined(self.func_4BDF)) {
    return 0;
  }

  return self.func_4BDF == var_00;
}

func_19E1(var_00) {
  self endon("death");
  self endon("stop_color_move");
  func_BE08();
  thread func_19E0(var_00);
}

func_19E0(var_00) {
  self notify("stop_going_to_node");
  func_F3D2(var_00);
  var_01 = level.func_22DF[func_7CE4()][self.func_4BDF];

  if(isDefined(self.func_ED27)) {
    thread func_3A57(var_00, var_01);
  }
}

func_F3D2(var_00) {
  if(isDefined(self.func_43A9)) {
    self thread[[self.func_43A9]](var_00);
  }

  if(isDefined(self.func_11B0)) {
    thread scripts\sp\anim::func_1F32(self, self.func_11B0);
    self.func_11B0 = undefined;
  }

  if(isDefined(self.func_43AB)) {
    self thread[[self.func_43AB]](var_00);
  }
  else {
    self give_more_perk(var_00);
  }

  if(func_9CFA(var_00)) {
    thread func_72C8(var_00);
  }
  else if(isDefined(var_0.radius) && var_0.radius > 0) {
    self.goalradius = var_0.radius;
  }

  var_01 = level.func_22DF[func_7CE4()][self.func_4BDF];

  if(isDefined(var_01)) {
    self give_laststand(var_01);
  }
  else {
    self getplayerheadmodel();
  }

  if(isDefined(var_0.fixednodesaferadius)) {
    self.fixednodesaferadius = var_0.fixednodesaferadius;
  }
  else if(isDefined(level.func_6E02)) {
    self.fixednodesaferadius = level.func_6E02;
  }
  else {
    self.fixednodesaferadius = 64;
  }
}

func_9CFA(var_00) {
  if(!isDefined(self.func_EDB0)) {
    return 0;
  }

  if(!self.func_EDB0) {
    return 0;
  }

  if(!isDefined(var_0.fixednodesaferadius)) {
    return 0;
  }

  if(self.fixednode) {
    return 0;
  }
  else {
    return 1;
  }
}

func_72C8(var_00) {
  self endon("death");
  self endon("stop_going_to_node");
  self.goalradius = var_0.fixednodesaferadius;
  scripts\engine\utility::waittill_either("goal", "damage");

  if(isDefined(var_0.radius) && var_0.radius > 0) {
    self.goalradius = var_0.radius;
  }
}

func_3A57(var_00, var_01) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread func_DDF9(var_00);

  for(;;) {
    func_13689(var_00, var_01);
    func_12FAD(var_00, var_01);
    self.fixednode = 1;
    func_F3D2(var_00);
  }
}

func_DDF9(var_00) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = 1;
  func_F3D2(var_00);
}

func_12FAD(var_00, var_01) {
  self give_mp_super_weapon(self.origin);
  self.goalradius = 1024;
  self.fixednode = 0;

  if(isDefined(var_01)) {
    for(;;) {
      wait 1;

      if(self _meth_81A8(var_0.origin, self.fixednodesaferadius)) {
        continue;
      }
      if(self getteamfallbackspawnpoints(var_01)) {
        continue;
      }
      return;
    }
  } else {
    for(;;) {
      if(!func_9E6E(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

func_9E6E(var_00, var_01) {
  var_02 = _getaiarray("axis");

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    if(distance2d(var_2[var_03].origin, var_00) < var_01) {
      return 1;
    }
  }

  return 0;
}

func_13689(var_00, var_01) {
  if(isDefined(var_01)) {
    for(;;) {
      if(self _meth_81A8(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      if(self getteamfallbackspawnpoints(var_01)) {
        return;
      }
      wait 1;
    }
  } else {
    for(;;) {
      if(func_9E6E(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

func_BE08() {
  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.func_ED35)) {
    wait(self.func_ED35);
    return 1;
  }

  return self.node scripts\sp\utility::script_delay();
}

func_D966(var_00, var_01, var_02) {
  thread decrementcolorusers(var_00);
  self endon("stop_color_move");
  self endon("death");

  if(isDefined(var_01)) {
    var_01 scripts\sp\utility::script_delay();
  }

  if(!func_BE08()) {
    if(isDefined(var_02)) {
      wait(var_02 * randomfloatrange(0.2, 0.35));
    }
  }

  func_19E0(var_00);
  self.func_439C = var_00;

  for(;;) {
    self waittill("node_taken", var_03);

    if(isplayer(var_03)) {
      wait 0.05;
    }

    var_00 = func_7860();

    if(isDefined(var_00)) {
      if(isalive(self.func_4397.func_43A2) && self.func_4397.func_43A2 == self) {
        self.func_4397.func_43A2 = undefined;
      }

      self.func_4397 = var_00;
      var_0.func_43A2 = self;
      func_19E0(var_00);
    }
  }
}

func_785F() {
  var_00 = level.func_4BE0[func_7CE4()][self.func_EDAD];
  var_01 = func_7BDA(func_7CE4(), var_00, self.func_EDAD);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(!isalive(var_1[var_02].func_43A2)) {
      return var_1[var_02];
    }
  }
}

func_7860() {
  var_00 = level.func_4BE0[func_7CE4()][self.func_EDAD];
  var_01 = func_7BDA(func_7CE4(), var_00, self.func_EDAD);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(var_1[var_02] == self.func_4397) {
      continue;
    }
    if(!isalive(var_1[var_02].func_43A2)) {
      return var_1[var_02];
    }
  }
}

func_D987(var_00) {
  self endon("stopScript");
  self endon("death");

  if(isDefined(self.node)) {
    return;
  }
  if(distance(var_0.origin, self.origin) < 32) {
    func_DD19(var_00);
    return;
  }

  var_01 = gettime();
  func_135E3(1);
  var_02 = gettime();

  if(var_02 - var_01 >= 1000) {
    func_DD19(var_00);
  }
}

func_135E3(var_00) {
  self endon("killanimscript");
  wait(var_00);
}

func_DD19(var_00) {
  var_01 = _getaiarray();
  var_02 = undefined;

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    if(!isDefined(var_1[var_03].node)) {
      continue;
    }
    if(var_1[var_03].node != var_00) {
      continue;
    }
    var_1[var_03] notify("eject_from_my_node");
    wait 1;
    self notify("eject_from_my_node");
    return 1;
  }

  return 0;
}

decrementcolorusers(var_00) {
  var_0.func_43A2 = self;
  self.func_4397 = var_00;
  self endon("stop_color_move");
  self waittill("death");
  self.func_4397.func_43A2 = undefined;
}

func_43A7(var_00) {
  for(var_01 = 0; var_01 < level.func_43A8.size; var_1++) {
    if(var_00 == level.func_43A8[var_01]) {
      return 1;
    }
  }

  return 0;
}

func_178C(var_00, var_01) {
  var_02 = strtok(var_00, " ");
  var_02 = func_22AE(var_02);

  foreach(var_04 in var_02) {
    level.func_22DF[var_01][var_04] = self;
    level.func_22DC[var_01][var_04] = [];
    level.func_22DE[var_01][var_04] = [];
  }
}

func_171E(var_00, var_01) {
  self.func_43A2 = undefined;
  var_02 = strtok(var_00, " ");
  var_02 = func_22AE(var_02);

  foreach(var_04 in var_02) {
    if(isDefined(level.func_22DD[var_01]) && isDefined(level.func_22DD[var_01][var_04])) {
      level.func_22DD[var_01][var_04] = ::scripts\engine\utility::array_add(level.func_22DD[var_01][var_04], self);
      continue;
    }

    level.func_22DD[var_01][var_04][0] = self;
    level.func_22DC[var_01][var_04] = [];
    level.func_22DE[var_01][var_04] = [];
  }
}

func_AB3A() {
  if(!isDefined(self.func_4397)) {
    return;
  }
  if(isDefined(self.func_4397.func_43A2) && self.func_4397.func_43A2 == self) {
    self.func_4397.func_43A2 = undefined;
  }

  self.func_4397 = undefined;
  self notify("stop_color_move");
}

func_7E3A() {
  var_00 = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    var_0["team"] = "axis";
    var_0["colorTeam"] = self.func_ED34;
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    var_0["team"] = "allies";
    var_0["colorTeam"] = self.func_ED33;
  }

  if(!isDefined(var_0["colorTeam"])) {
    var_00 = undefined;
  }

  return var_00;
}

func_E16F() {
  var_00 = func_7E3A();

  if(!isDefined(var_00)) {
    return;
  }
  var_01 = var_0["team"];
  var_02 = var_0["colorTeam"];
  var_03 = strtok(var_02, " ");
  var_03 = func_22AE(var_03);

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    level.func_22DE[var_01][var_3[var_04]] = ::scripts\engine\utility::array_remove(level.func_22DE[var_01][var_3[var_04]], self);
  }
}

func_16B5(var_00) {
  level.func_439B[var_00][1]["allies"] = ::func_D968;
  level.func_439B[var_00][1]["axis"] = ::func_D969;
  level.func_439B[var_00][0]["allies"] = ::func_D967;
  level.func_439B[var_00][0]["axis"] = ::func_D967;
}

func_1729(var_00) {
  level.func_439B[var_00][1]["allies"] = ::func_D982;
  level.func_439B[var_00][0]["allies"] = ::func_D982;
  level.func_439B[var_00][1]["axis"] = ::func_D982;
  level.func_439B[var_00][0]["axis"] = ::func_D982;
}

func_43AC(var_00, var_01) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_02 = func_10735(var_00, var_01);

  if(isDefined(level.func_73F1)) {
    var_02 thread[[level.func_73F1]]();
  }

  var_02 thread func_43AA();
}

func_43AA() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");

  if(isDefined(self.func_E198)) {
    return;
  }
  self.func_E198 = 1;
  var_00 = self.classname;
  var_01 = self.func_EDAD;
  waittillframeend;

  if(isalive(self)) {
    self waittill("death");
  }

  var_02 = level.func_4B58;

  if(!isDefined(self.func_EDAD)) {
    return;
  }
  thread func_43AC(var_00, self.func_EDAD);

  if(isDefined(self) && isDefined(self.func_EDAD)) {
    var_01 = self.func_EDAD;
  }

  if(isDefined(self) && isDefined(self.origin)) {
    var_03 = self.origin;
  }

  for(;;) {
    if(func_78CE(var_01, var_02) == "none") {
      return;
    }
    var_04 = scripts\sp\utility::func_79C8("allies", var_2[var_01]);

    if(!isDefined(level.func_4392)) {
      var_04 = scripts\sp\utility::func_E0AF(var_04, var_00);
    }

    if(!var_4.size) {
      wait 2;
      continue;
    }

    var_05 = scripts\engine\utility::getclosest(level.player.origin, var_04);
    waittillframeend;

    if(!isalive(var_05)) {
      continue;
    }
    var_05 scripts\sp\utility::func_F3B5(var_01);

    if(isDefined(level.func_73DF)) {
      var_05[[level.func_73DF]](var_01);
    }

    var_01 = var_2[var_01];
  }
}

func_78CE(var_00, var_01) {
  if(!isDefined(var_00)) {
    return "none";
  }

  if(!isDefined(var_01)) {
    return "none";
  }

  if(!isDefined(var_1[var_00])) {
    return "none";
  }

  return var_1[var_00];
}

func_73E7() {
  level.func_73E1 = 1;
  var_00 = 0;

  for(;;) {
    for(;;) {
      if(!func_E289()) {
        break;
      }
      wait 0.05;
    }

    wait 1;

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

    var_0++;

    if(var_00 < 3) {
      continue;
    }
    scripts\engine\utility::flag_set("player_looks_away_from_spawner");
  }
}

func_78D4(var_00) {
  if(isDefined(var_00)) {
    if(!isDefined(level.func_11AE[var_00])) {
      var_01 = _getspawnerteamarray("allies");

      foreach(var_03 in var_01) {
        if(var_3.classname != var_00) {
          continue;
        }
        level.func_11AE[var_00] = var_03;
        break;
      }
    }
  }

  if(!isDefined(var_00)) {
    var_03 = scripts\engine\utility::random(level.func_11AE);

    if(!isDefined(var_03)) {
      var_01 = [];

      foreach(var_06, var_03 in level.func_11AE) {
        if(isDefined(var_03)) {
          var_1[var_06] = var_03;
        }
      }

      level.func_11AE = var_01;
      return scripts\engine\utility::random(level.func_11AE);
    }

    return var_03;
  }

  return level.func_11AE[var_00];
}

func_E289() {
  if(isDefined(level.func_E288)) {
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
    wait 0.05;
  }
}

func_10735(var_00, var_01) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_02 = undefined;

  for(;;) {
    if(!func_E289()) {
      if(!isDefined(level.func_73E1)) {
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

    var_03 = func_78D4(var_00);
    var_3.count = 1;
    var_04 = var_3.origin;
    var_3.origin = level.respawn_threshold;
    var_02 = var_03 _meth_8393();
    var_3.origin = var_04;

    if(scripts\sp\utility::func_106ED(var_02)) {
      thread func_AEE0();
      wait 1;
      continue;
    }

    level notify("reinforcement_spawned", var_02);
    break;
  }

  for(;;) {
    if(!isDefined(var_01)) {
      break;
    }
    if(func_78CE(var_01, level.func_4B58) == "none") {
      break;
    }
    var_01 = level.func_4B58[var_01];
  }

  if(isDefined(var_01)) {
    var_02 scripts\sp\utility::func_F3B5(var_01);
  }

  thread func_AEE0();
  return var_02;
}

func_AEE0() {
  scripts\engine\utility::flag_set("friendly_spawner_locked");

  if(isDefined(level.func_73E0)) {
    [[level.func_73E0]]();
  }
  else {
    wait 2;
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
  var_00 = _getaiarray();
  scripts\engine\utility::array_thread(var_00, ::func_E07E);
}

func_E07E() {
  self.func_E198 = undefined;
}

func_7CE4(var_00) {
  if(isDefined(self.team) && !isDefined(var_00)) {
    var_00 = self.team;
  }

  return level.func_43A0[var_00];
}
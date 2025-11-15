/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2586.gsc
************************/

asm_globalinit() {
  if(isDefined(level.asm)) {
    return;
  }

  anim.asm = [];
}

func_230B(param_00, param_01) {
  asm_globalinit();
  level.asm[param_00] = spawnStruct();
  level.asm[param_00].var_9881 = param_01;
  level.asm[param_00].states = [];
  level.asm[param_00].var_F281 = [];
  anim.var_DEF5 = param_00;
}

func_232E(param_00) {
  return isDefined(level.asm) && isDefined(level.asm[param_00]);
}

func_2327() {
  anim.var_DEF5 = undefined;
  anim.var_DEF7 = undefined;
}

func_2373(param_00, param_01) {
  level.asm[level.var_DEF5].var_F281[param_00] = param_01;
}

func_2374(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F, param_10, param_11, param_12, param_13, param_14, param_15) {
  var_16 = level.asm[level.var_DEF5];
  var_16.states[param_00] = spawnStruct();
  var_16.states[param_00].var_7048 = param_01;
  var_16.states[param_00].var_E88A = param_02;
  var_16.states[param_00].var_71C5 = param_03;
  var_16.states[param_00].var_71D2 = param_04;
  var_16.states[param_00].var_116FB = param_05;
  var_16.states[param_00].var_71A5 = param_06;
  var_16.states[param_00].var_7DC8 = param_07;
  var_16.states[param_00].transitions = [];
  var_16.states[param_00].magicbullet = param_08;
  var_16.states[param_00].var_10B53 = param_09;
  var_16.states[param_00].var_6A8B = param_0B;
  var_16.states[param_00].var_C87F = param_0C;
  var_16.states[param_00].var_C87C = param_0D;
  var_16.states[param_00].var_4E6D = param_0E;
  var_16.states[param_00].var_4E54 = param_0F;
  var_16.states[param_00].var_D773 = param_10;
  var_16.states[param_00].var_D772 = param_11;
  var_16.states[param_00].var_116FA = param_12;
  var_16.states[param_00].var_C704 = param_13;
  var_16.states[param_00].var_1FBA = param_14;
  var_16.states[param_00].var_C94B = param_15;
  var_16.states[param_00].var_111AC = param_0A;
  anim.var_DEF7 = param_00;
}

func_2375(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = level.asm[level.var_DEF5];
  var_07 = spawnStruct();
  var_07.var_2B93 = param_01;
  var_07.var_71D1 = param_02;
  var_07.var_100B1 = param_03;
  var_07.var_11A1A = param_00;
  var_06.states[level.var_DEF7].transitions[var_06.states[level.var_DEF7].transitions.size] = var_07;
}

asm_fireephemeralevent(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_7686 = gettime();
  var_03.name = param_01;
  var_03.params = param_02;
  if(!isDefined(self.var_1198.var_2329[param_00])) {
    self.var_1198.var_2329[param_00] = [];
  }

  self.var_1198.var_2329[param_00][self.var_1198.var_2329[param_00].size] = var_03;
  if(isDefined(self.var_1198.asm_ephemeral_event_watchlist[param_00]) && self.var_1198.asm_ephemeral_event_watchlist[param_00] == param_01) {
    self.var_3135.var_72EB = 1;
    self.var_1198.asm_ephemeral_event_watchlist[param_00] = undefined;
  }
}

func_2351(param_00, param_01) {
  var_02 = level.asm[param_00];
  self.var_164D[param_00] = spawnStruct();
  self.var_164D[param_00].var_4BC0 = undefined;
  if(param_01) {
    self.var_164D[param_00].var_2F3C = 1;
  }

  foreach(var_04 in var_02.var_F281) {
    self thread[[var_04]](param_00);
  }

  func_238A(param_00, var_02.var_9881, 0);
}

func_234E() {
  self.var_1198 = spawnStruct();
  self.var_1198.var_527D = "stand";
  self.var_1198.asm_events = [];
  self.var_1198.var_2329 = [];
  self.var_1198.asm_ephemeral_event_watchlist = [];
  self.var_1198.breload = 0;
  self.var_1198.var_2AA6 = 0;
  self.var_1198.movetype = "combat";
  self.var_1198.animscriptedactive = 0;
  self.var_1198.alwaysrunforward = 0;
  self.var_1198.var_444A = 0;
}

asm_clearevents(param_00) {
  if(isDefined(self.var_1198.asm_events[param_00])) {
    self.var_1198.asm_events[param_00] = undefined;
  }
}

func_2388(param_00, param_01, param_02, param_03) {
  self notify(param_01 + "_finished");
  asm_fireevent(param_01, "ASM_Finished");
  if(isDefined(param_02.var_71D2)) {
    self[[param_02.var_71D2]](param_00, param_01, param_03);
  }

  if(isDefined(param_02.var_116FA)) {
    asm_fireephemeralevent(param_02.var_116FA, "end");
  }
}

func_2387(param_00) {
  var_01 = level.asm[param_00];
  var_02 = self.var_164D[param_00].var_4BC0;
  func_2388(param_00, var_02, var_01.states[var_02], var_01.states[var_02].var_116FB);
  self.var_164D[param_00] = undefined;
}

func_238A(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = level.asm[param_00];
  var_07 = var_06.states[param_01];
  var_08 = self.var_164D[param_00];
  var_08.var_10E23 = var_08.var_4BC0;
  var_08.var_4BC0 = param_01;
  asm_clearevents(param_01);
  self.asm.var_4E6E = undefined;
  var_09 = var_07.var_111AC;
  var_0A = undefined;
  if(isDefined(var_08.var_10E23)) {
    var_0A = var_06.states[var_08.var_10E23].var_111AC;
    if(isDefined(var_0A)) {
      foreach(var_0C in var_0A) {
        if(!isDefined(var_09) || !scripts\engine\utility::array_contains(var_09, var_0C)) {
          func_2387(var_0C);
        }
      }
    }
  }

  if(isDefined(self.var_7195)) {
    self[[self.var_7195]](var_07);
  }

  self[[self.var_718F]](var_07);
  if(isDefined(var_08.var_2F3C) && var_08.var_2F3C) {
    self.var_34 = isDefined(var_07.var_C87F);
  }

  var_0E = undefined;
  if(isDefined(param_05)) {
    var_0E = param_05;
  } else if(isDefined(var_07.var_E88A)) {
    var_0E = var_07.var_E88A;
  }

  self thread[[var_07.var_7048]](param_00, param_01, param_02, var_0E);
  if(isDefined(self.var_718D)) {
    self[[self.var_718D]](param_00, var_08.var_10E23, param_01, param_02);
  }

  if(isDefined(self.var_718E)) {
    self[[self.var_718E]](param_00, param_01);
  }

  if(isDefined(var_07.var_111AC)) {
    foreach(var_0C in var_07.var_111AC) {
      if(!isDefined(var_0A) || !scripts\engine\utility::array_contains(var_0A, var_0C)) {
        func_2351(var_0C, 0);
      }
    }
  }
}

func_2341(param_00, param_01) {
  if(isDefined(level.asm[param_00].states[param_01].var_71C5)) {
    return level.asm[param_00].states[param_01].var_71C5;
  }

  return undefined;
}

func_231E(param_00, param_01, param_02) {
  if(isDefined(self.asm.var_4E6E)) {
    var_03 = self.asm.var_4E6E.var_10E2C;
    var_04 = self.asm.var_4E6E.params;
  } else {
    var_03 = var_03.var_4E6D;
    var_04 = param_02.var_4E54;
  }

  var_05 = level.asm[param_00].states[var_03];
  func_2388(param_00, param_02, param_01, param_01.var_116FB);
  var_06 = var_03;
  if(isDefined(var_05.var_C94B) && var_05.var_C94B) {
    var_07 = func_2310(param_00, var_03, 1);
    var_06 = var_07[0];
    var_08 = var_07[1];
  }

  func_238A(param_00, var_06, 0.2, undefined, undefined, var_04);
}

func_231B(param_00, param_01) {
  var_02 = self.var_164D[param_00];
  if(!isDefined(var_02.var_4BC0)) {
    return 0;
  }

  var_03 = level.asm[param_00].states[var_02.var_4BC0].magicbullet;
  if(isDefined(var_03) && scripts\engine\utility::array_contains(var_03, param_01)) {
    return 1;
  }

  return 0;
}

func_2384(param_00, param_01, param_02) {
  var_03 = self.var_164D[param_00];
  var_04 = level.asm[param_00].states[param_01].magicbullet;
  if(isDefined(var_04) && scripts\engine\utility::array_contains(var_04, param_02)) {
    return 1;
  }

  return 0;
}

asm_fireevent_internal(param_00, param_01, param_02) {
  if(!isDefined(self.var_1198.asm_events[param_00])) {
    self.var_1198.asm_events[param_00] = [];
  }

  var_03 = func_233F(param_00, param_01);
  if(!isDefined(var_03)) {
    var_03 = spawnStruct();
  }

  var_03.var_7686 = gettime();
  var_03.params = param_02;
  self.var_1198.asm_events[param_00][param_01] = var_03;
  asm_fireephemeralevent(param_00, param_01, param_02);
}

asm_fireevent(param_00, param_01, param_02) {
  asm_fireevent_internal(param_00, param_01, param_02);
  if(param_01 == "anim_will_finish" || param_01 == "finish") {
    param_01 = "end";
    asm_fireevent_internal(param_00, param_01);
  }
}

asm_addephemeraleventtowatchlist(param_00, param_01) {
  self.var_1198.asm_ephemeral_event_watchlist[param_00] = param_01;
}

asm_ephemeraleventfired(param_00, param_01, param_02) {
  if(isDefined(self.var_1198.var_2329[param_00])) {
    foreach(var_04 in self.var_1198.var_2329[param_00]) {
      if(var_04.name == param_01) {
        return 1;
      }
    }
  }

  if(!isDefined(param_02) || param_02) {
    asm_addephemeraleventtowatchlist(param_00, param_01);
  }

  return 0;
}

func_232C(param_00, param_01) {
  var_02 = func_233F(param_00, param_01);
  if(isDefined(var_02)) {
    if(var_02.var_7686 >= gettime() - 50) {
      return 1;
    }
  }

  return 0;
}

func_233F(param_00, param_01) {
  if(!isDefined(self.var_1198.asm_events[param_00])) {
    return undefined;
  }

  foreach(var_04, var_03 in self.var_1198.asm_events[param_00]) {
    if(var_04 == param_01) {
      return var_03;
    }
  }

  return undefined;
}

func_233E(param_00, param_01) {
  if(!isDefined(self.var_1198.var_2329[param_00]) || self.var_1198.var_2329[param_00].size == 0) {
    return undefined;
  }

  foreach(var_03 in self.var_1198.var_2329[param_00]) {
    if(var_03.name == param_01) {
      return var_03;
    }
  }

  return undefined;
}

func_2314() {
  self.var_1198.var_2329 = [];
}

asm_shouldpowerdown(param_00, param_01) {
  if(!isDefined(self.bpowerdown) || !self.bpowerdown) {
    return 0;
  }

  if(isDefined(self.asm.bpowereddown) && self.asm.bpowereddown) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    return 0;
  }

  if(isDefined(self.var_1198.btraversing)) {
    return 0;
  }

  if(isDefined(self.melee)) {
    return 0;
  }

  return 1;
}

func_2325(param_00, param_01, param_02) {
  var_03 = 1;
  var_04 = param_01.var_D773;
  if(!isDefined(var_04)) {
    var_04 = "powerdown_default";
  }

  func_2388(param_00, param_02, param_01, param_01.var_116FB);
  func_238A(param_00, var_04, var_03, undefined, undefined, param_01.var_D772);
}

asm_isinstate(param_00) {
  foreach(var_02 in self.var_164D) {
    if(var_02.var_4BC0 == param_00) {
      return 1;
    }
  }

  return 0;
}

func_232B(param_00, param_01) {
  if(!isDefined(self.var_1198.asm_events[param_00]) || self.var_1198.asm_events[param_00].size == 0) {
    return 0;
  }

  foreach(var_04, var_03 in self.var_1198.asm_events[param_00]) {
    if(var_04 == param_01) {
      return 1;
    }
  }

  return 0;
}

func_68B0(param_00, param_01, param_02, param_03) {
  return func_232B(param_01, param_03);
}

func_666F(param_00, param_01, param_02, param_03) {
  return asm_ephemeraleventfired(param_01, param_03);
}

func_2310(param_00, param_01, param_02) {
  var_03 = level.asm[param_00];
  var_04 = level.asm[param_00].states[param_01];
  foreach(var_06 in var_04.transitions) {
    var_07 = var_06.var_11A1A;
    var_08 = self[[var_06.var_71D1]](param_00, param_01, var_07, var_06.var_100B1);
    if(var_08) {
      var_09 = level.asm[param_00].states[var_06.var_11A1A];
      var_0A = var_06.var_2B93;
      if(!isDefined(var_0A)) {
        var_0A = 0.2;
      }

      if(isDefined(var_09.var_C94B) && var_09.var_C94B) {
        var_0B = func_2310(param_00, var_07, 1);
        var_07 = var_0B[0];
        var_0A = var_0B[1];
      }

      if(isDefined(var_07)) {
        if(!param_02) {
          func_2388(param_00, param_01, var_04, var_04.var_116FB);
          func_238A(param_00, var_07, var_0A);
        }

        return [var_07, var_0A];
      }
    }
  }

  return [undefined, undefined];
}

asm_setstate(param_00, param_01) {
  foreach(var_0A, var_03 in self.var_164D) {
    var_04 = var_03.var_4BC0;
    var_05 = level.asm[var_0A].states[var_04];
    var_06 = level.asm[var_0A].states[param_00];
    if(!isDefined(var_06)) {
      continue;
    }

    var_07 = param_00;
    if(isDefined(var_06.var_C94B) && var_06.var_C94B) {
      var_08 = func_2310(var_0A, param_00, 1);
      var_07 = var_08[0];
      var_09 = var_08[1];
      if(!isDefined(var_07)) {
        continue;
      }
    }

    func_2388(var_0A, var_04, var_05, var_05.var_116FB);
    func_238A(var_0A, var_07, 0.2, undefined, undefined, param_01);
  }
}

func_2389() {
  var_00 = self.var_164D[self.asmname].var_4BC0;
  var_01 = level.asm[self.asmname].states[var_00];
  if(isDefined(self.var_7194)) {
    if(self[[self.var_7194]](self.asmname, var_01)) {
      func_231E(self.asmname, var_01, var_00);
      return;
    }
  }

  if(asm_shouldpowerdown(self.asmname, var_01)) {
    func_2325(self.asmname, var_01, var_00);
    return;
  }

  var_03 = 0;
  foreach(var_09, var_05 in self.var_164D) {
    var_00 = var_05.var_4BC0;
    var_06 = func_2310(var_09, var_00, 0);
    var_07 = var_06[0];
    var_08 = var_06[1];
    if(isDefined(var_07)) {
      var_03 = 1;
    }

    if(var_03) {
      return;
    }
  }
}

func_6A18(param_00, param_01, param_02, param_03) {
  if(weaponclass(self.var_394) == "pistol") {
    if(weaponclass(self.primaryweapon) != "mg" && weaponclass(self.primaryweapon) != "rocketlauncher" && weaponclass(self.primaryweapon) != "pistol") {
      return 0;
    }
  }

  return func_BCE7(param_00, param_01, param_02, param_03);
}

func_BCE7(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03) && asm_getdemeanor() != param_03) {
    return 0;
  }

  return scripts\asm\asm_bb::bb_moverequested() && distancesquared(self.vehicle_getspawnerarray, self.origin) > 4;
}

func_C17F(param_00, param_01, param_02, param_03) {
  return !func_BCE7(param_00, param_01, param_02, param_03);
}

func_BCE8(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    var_04 = self[[self.var_71A6]]();
    if(var_04 != param_03) {
      return 0;
    }
  }

  return func_BCE7(param_00, param_01, param_02, undefined);
}

func_9E41(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(isarray(param_03)) {
    var_04 = param_03[0];
  } else {
    var_04 = param_03;
  }

  if(scripts\asm\asm_bb::bb_isincombat() != var_04) {
    return 0;
  }

  var_05 = undefined;
  if(isarray(param_03) && isDefined(param_03[1])) {
    var_05 = param_03[1];
  }

  return func_BCE7(param_00, param_01, param_02, var_05);
}

asm_getdemeanor() {
  if(asm_getdemeanor()) {
    return "frantic";
  } else if(scripts\asm\asm_bb::bb_isfrantic()) {
    return "combat";
  } else if(isDefined(self.demeanoroverride) && self.demeanoroverride == "cqb" && !isDefined(self.objective_position)) {
    return "cqb";
  }

  return self.var_1198.movetype;
}

asm_updatefrantic() {
  if(!isDefined(self.vehicle_getspawnerarray) || distancesquared(self.origin, self.vehicle_getspawnerarray) > 4096) {
    self.asm.var_7360 = scripts\asm\asm_bb::bb_isfrantic();
  }
}

asm_getdemeanor() {
  return self.asm.var_7360;
}

asm_iscrawlmelee() {
  return isDefined(self.asm.crawlmelee);
}

asm_setcrawlmelee(param_00) {
  self.asm.crawlmelee = param_00;
}

asm_setdemeanoranimoverride(param_00, param_01, param_02) {
  self.asm.animoverrides[param_00][param_01] = param_02;
}

asm_cleardemeanoranimoverride(param_00, param_01) {
  if(asm_hasdemeanoranimoverride(param_00, param_01)) {
    self.asm.animoverrides[param_00][param_01] = undefined;
  }
}

asm_hasdemeanoranimoverride(param_00, param_01) {
  return isDefined(self.asm.animoverrides[param_00]) && isDefined(self.asm.animoverrides[param_00][param_01]);
}

asm_getdemeanoranimoverride(param_00, param_01) {
  return self.asm.animoverrides[param_00][param_01];
}

asm_getcurrentstate(param_00) {
  var_01 = self.var_164D[param_00];
  return var_01.var_4BC0;
}

asm_hasalias(param_00, param_01) {
  return self[[self.var_7192]](param_00, param_01);
}

asm_lookupanimfromalias(param_00, param_01) {
  return self[[self.var_7193]](param_00, param_01);
}

asm_getallanimindicesforalias(param_00, param_01, param_02) {
  return self[[self.var_7190]](param_00, param_01, param_02);
}

func_235C(param_00, param_01, param_02, param_03) {
  var_04 = "";
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  if(param_02) {
    if(func_232C(param_01, "pass_left")) {
      var_05 = var_04 + "left";
    } else if(func_232C(param_02, "pass_right")) {
      var_05 = var_05 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_05 = var_05 + "right";
    } else {
      var_05 = var_05 + "left";
    }
  } else {
    var_05 = var_05;
  }

  if(asm_hasalias(param_01, var_05 + param_00)) {
    return asm_lookupanimfromalias(param_01, var_05 + param_00);
  }

  if(var_04 != var_05 && asm_hasalias(param_01, var_04 + param_00)) {
    return asm_lookupanimfromalias(param_01, var_04 + param_00);
  }

  return undefined;
}

func_237B(param_00) {
  if(getdvarint("ai_iw7", 0) == 1) {
    self.moveplaybackrate = param_00;
    return;
  }

  self.moveplaybackrate = param_00;
}

asm_getmoveplaybackrate() {
  return self.moveplaybackrate;
}

func_231D(param_00, param_01, param_02, param_03) {
  var_04 = level.asm[param_00].states[param_02];
  self.asm.var_DCC7 = undefined;
  var_05 = 0;
  for(var_06 = 0; var_06 < var_04.transitions.size; var_06++) {
    var_07 = var_04.transitions[var_06].var_100B1;
    var_08 = var_07[1];
    for(var_09 = var_06 - 1; var_09 >= 0; var_09--) {}

    var_0A = 1;
    if(var_07.size > 2) {
      var_0A = var_07[3];
    }

    var_05 = var_05 + var_0A;
  }

  var_0B = randomfloat(var_05);
  var_0C = undefined;
  for(var_06 = 0; var_06 < var_04.transitions.size; var_06++) {
    var_0D = var_04.transitions[var_06];
    var_07 = var_0D.var_100B1;
    var_0C = var_07[1];
    var_0A = 1;
    if(var_07.size > 2) {
      var_0A = var_07[3];
    }

    if(var_0B < var_0A) {
      break;
    } else {
      var_0B = var_0B - var_0A;
    }
  }

  self.asm.var_DCC7 = param_00 + "_" + param_02 + "_" + var_0C;
  return 1;
}

func_230C(param_00, param_01, param_02, param_03) {
  var_04 = param_00 + "_" + param_01 + "_" + param_03[1];
  return var_04 == self.asm.var_DCC7;
}

asm_getcurrentstatename(param_00) {
  return self.var_164D[param_00].var_4BC0;
}
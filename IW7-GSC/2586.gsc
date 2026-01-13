/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2586.gsc
*********************************************/

asm_globalinit() {
  if(isDefined(level.asm)) {
    return;
  }

  anim.asm = [];
}

func_230B(var_0, var_1) {
  asm_globalinit();
  level.asm[var_0] = spawnStruct();
  level.asm[var_0].var_9881 = var_1;
  level.asm[var_0].states = [];
  level.asm[var_0].var_F281 = [];
  anim.var_DEF5 = var_0;
}

func_232E(var_0) {
  return isDefined(level.asm) && isDefined(level.asm[var_0]);
}

func_2327() {
  anim.var_DEF5 = undefined;
  anim.var_DEF7 = undefined;
}

func_2373(var_0, var_1) {
  level.asm[level.var_DEF5].var_F281[var_0] = var_1;
}

func_2374(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, param_10, param_11, param_12, param_13, param_14, param_15) {
  var_16 = level.asm[level.var_DEF5];
  var_16.states[var_0] = spawnStruct();
  var_16.states[var_0].var_7048 = var_1;
  var_16.states[var_0].var_E88A = var_2;
  var_16.states[var_0].var_71C5 = var_3;
  var_16.states[var_0].var_71D2 = var_4;
  var_16.states[var_0].var_116FB = var_5;
  var_16.states[var_0].var_71A5 = var_6;
  var_16.states[var_0].var_7DC8 = var_7;
  var_16.states[var_0].transitions = [];
  var_16.states[var_0].magicbullet = var_8;
  var_16.states[var_0].var_10B53 = var_9;
  var_16.states[var_0].var_6A8B = var_0B;
  var_16.states[var_0].var_C87F = var_0C;
  var_16.states[var_0].var_C87C = var_0D;
  var_16.states[var_0].var_4E6D = var_0E;
  var_16.states[var_0].var_4E54 = var_0F;
  var_16.states[var_0].var_D773 = param_10;
  var_16.states[var_0].var_D772 = param_11;
  var_16.states[var_0].var_116FA = param_12;
  var_16.states[var_0].var_C704 = param_13;
  var_16.states[var_0].var_1FBA = param_14;
  var_16.states[var_0].var_C94B = param_15;
  var_16.states[var_0].var_111AC = var_0A;
  anim.var_DEF7 = var_0;
}

func_2375(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.asm[level.var_DEF5];
  var_7 = spawnStruct();
  var_7.var_2B93 = var_1;
  var_7.var_71D1 = var_2;
  var_7.var_100B1 = var_3;
  var_7.var_11A1A = var_0;
  var_6.states[level.var_DEF7].transitions[var_6.states[level.var_DEF7].transitions.size] = var_7;
}

asm_fireephemeralevent(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.var_7686 = gettime();
  var_3.name = var_1;
  var_3.params = var_2;
  if(!isDefined(self._blackboard.var_2329[var_0])) {
    self._blackboard.var_2329[var_0] = [];
  }

  self._blackboard.var_2329[var_0][self._blackboard.var_2329[var_0].size] = var_3;
  if(isDefined(self._blackboard.asm_ephemeral_event_watchlist[var_0]) && self._blackboard.asm_ephemeral_event_watchlist[var_0] == var_1) {
    self.bt.var_72EB = 1;
    self._blackboard.asm_ephemeral_event_watchlist[var_0] = undefined;
  }
}

func_2351(var_0, var_1) {
  var_2 = level.asm[var_0];
  self.var_164D[var_0] = spawnStruct();
  self.var_164D[var_0].var_4BC0 = undefined;
  if(var_1) {
    self.var_164D[var_0].var_2F3C = 1;
  }

  foreach(var_4 in var_2.var_F281) {
    self thread[[var_4]](var_0);
  }

  func_238A(var_0, var_2.var_9881, 0);
}

func_234E() {
  self._blackboard = spawnStruct();
  self._blackboard.var_527D = "stand";
  self._blackboard.asm_events = [];
  self._blackboard.var_2329 = [];
  self._blackboard.asm_ephemeral_event_watchlist = [];
  self._blackboard.breload = 0;
  self._blackboard.var_2AA6 = 0;
  self._blackboard.movetype = "combat";
  self._blackboard.animscriptedactive = 0;
  self._blackboard.alwaysrunforward = 0;
  self._blackboard.var_444A = 0;
}

asm_clearevents(var_0) {
  if(isDefined(self._blackboard.asm_events[var_0])) {
    self._blackboard.asm_events[var_0] = undefined;
  }
}

func_2388(var_0, var_1, var_2, var_3) {
  self notify(var_1 + "_finished");
  asm_fireevent(var_1, "ASM_Finished");
  if(isDefined(var_2.var_71D2)) {
    self[[var_2.var_71D2]](var_0, var_1, var_3);
  }

  if(isDefined(var_2.var_116FA)) {
    asm_fireephemeralevent(var_2.var_116FA, "end");
  }
}

func_2387(var_0) {
  var_1 = level.asm[var_0];
  var_2 = self.var_164D[var_0].var_4BC0;
  func_2388(var_0, var_2, var_1.states[var_2], var_1.states[var_2].var_116FB);
  self.var_164D[var_0] = undefined;
}

func_238A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.asm[var_0];
  var_7 = var_6.states[var_1];
  var_8 = self.var_164D[var_0];
  var_8.var_10E23 = var_8.var_4BC0;
  var_8.var_4BC0 = var_1;
  asm_clearevents(var_1);
  self.asm.var_4E6E = undefined;
  var_9 = var_7.var_111AC;
  var_0A = undefined;
  if(isDefined(var_8.var_10E23)) {
    var_0A = var_6.states[var_8.var_10E23].var_111AC;
    if(isDefined(var_0A)) {
      foreach(var_0C in var_0A) {
        if(!isDefined(var_9) || !scripts\engine\utility::array_contains(var_9, var_0C)) {
          func_2387(var_0C);
        }
      }
    }
  }

  if(isDefined(self.var_7195)) {
    self[[self.var_7195]](var_7);
  }

  self[[self.var_718F]](var_7);
  if(isDefined(var_8.var_2F3C) && var_8.var_2F3C) {
    self.var_34 = isDefined(var_7.var_C87F);
  }

  var_0E = undefined;
  if(isDefined(var_5)) {
    var_0E = var_5;
  } else if(isDefined(var_7.var_E88A)) {
    var_0E = var_7.var_E88A;
  }

  self thread[[var_7.var_7048]](var_0, var_1, var_2, var_0E);
  if(isDefined(self.var_718D)) {
    self[[self.var_718D]](var_0, var_8.var_10E23, var_1, var_2);
  }

  if(isDefined(self.var_718E)) {
    self[[self.var_718E]](var_0, var_1);
  }

  if(isDefined(var_7.var_111AC)) {
    foreach(var_0C in var_7.var_111AC) {
      if(!isDefined(var_0A) || !scripts\engine\utility::array_contains(var_0A, var_0C)) {
        func_2351(var_0C, 0);
      }
    }
  }
}

func_2341(var_0, var_1) {
  if(isDefined(level.asm[var_0].states[var_1].var_71C5)) {
    return level.asm[var_0].states[var_1].var_71C5;
  }

  return undefined;
}

func_231E(var_0, var_1, var_2) {
  if(isDefined(self.asm.var_4E6E)) {
    var_3 = self.asm.var_4E6E.var_10E2C;
    var_4 = self.asm.var_4E6E.params;
  } else {
    var_3 = var_3.var_4E6D;
    var_4 = var_2.var_4E54;
  }

  var_5 = level.asm[var_0].states[var_3];
  func_2388(var_0, var_2, var_1, var_1.var_116FB);
  var_6 = var_3;
  if(isDefined(var_5.var_C94B) && var_5.var_C94B) {
    var_7 = func_2310(var_0, var_3, 1);
    var_6 = var_7[0];
    var_8 = var_7[1];
  }

  func_238A(var_0, var_6, 0.2, undefined, undefined, var_4);
}

func_231B(var_0, var_1) {
  var_2 = self.var_164D[var_0];
  if(!isDefined(var_2.var_4BC0)) {
    return 0;
  }

  var_3 = level.asm[var_0].states[var_2.var_4BC0].magicbullet;
  if(isDefined(var_3) && scripts\engine\utility::array_contains(var_3, var_1)) {
    return 1;
  }

  return 0;
}

func_2384(var_0, var_1, var_2) {
  var_3 = self.var_164D[var_0];
  var_4 = level.asm[var_0].states[var_1].magicbullet;
  if(isDefined(var_4) && scripts\engine\utility::array_contains(var_4, var_2)) {
    return 1;
  }

  return 0;
}

asm_fireevent_internal(var_0, var_1, var_2) {
  if(!isDefined(self._blackboard.asm_events[var_0])) {
    self._blackboard.asm_events[var_0] = [];
  }

  var_3 = func_233F(var_0, var_1);
  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
  }

  var_3.var_7686 = gettime();
  var_3.params = var_2;
  self._blackboard.asm_events[var_0][var_1] = var_3;
  asm_fireephemeralevent(var_0, var_1, var_2);
}

asm_fireevent(var_0, var_1, var_2) {
  asm_fireevent_internal(var_0, var_1, var_2);
  if(var_1 == "anim_will_finish" || var_1 == "finish") {
    var_1 = "end";
    asm_fireevent_internal(var_0, var_1);
  }
}

asm_addephemeraleventtowatchlist(var_0, var_1) {
  self._blackboard.asm_ephemeral_event_watchlist[var_0] = var_1;
}

asm_ephemeraleventfired(var_0, var_1, var_2) {
  if(isDefined(self._blackboard.var_2329[var_0])) {
    foreach(var_4 in self._blackboard.var_2329[var_0]) {
      if(var_4.name == var_1) {
        return 1;
      }
    }
  }

  if(!isDefined(var_2) || var_2) {
    asm_addephemeraleventtowatchlist(var_0, var_1);
  }

  return 0;
}

func_232C(var_0, var_1) {
  var_2 = func_233F(var_0, var_1);
  if(isDefined(var_2)) {
    if(var_2.var_7686 >= gettime() - 50) {
      return 1;
    }
  }

  return 0;
}

func_233F(var_0, var_1) {
  if(!isDefined(self._blackboard.asm_events[var_0])) {
    return undefined;
  }

  foreach(var_4, var_3 in self._blackboard.asm_events[var_0]) {
    if(var_4 == var_1) {
      return var_3;
    }
  }

  return undefined;
}

func_233E(var_0, var_1) {
  if(!isDefined(self._blackboard.var_2329[var_0]) || self._blackboard.var_2329[var_0].size == 0) {
    return undefined;
  }

  foreach(var_3 in self._blackboard.var_2329[var_0]) {
    if(var_3.name == var_1) {
      return var_3;
    }
  }

  return undefined;
}

func_2314() {
  self._blackboard.var_2329 = [];
}

asm_shouldpowerdown(var_0, var_1) {
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

  if(isDefined(self._blackboard.btraversing)) {
    return 0;
  }

  if(isDefined(self.melee)) {
    return 0;
  }

  return 1;
}

func_2325(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = var_1.var_D773;
  if(!isDefined(var_4)) {
    var_4 = "powerdown_default";
  }

  func_2388(var_0, var_2, var_1, var_1.var_116FB);
  func_238A(var_0, var_4, var_3, undefined, undefined, var_1.var_D772);
}

asm_isinstate(var_0) {
  foreach(var_2 in self.var_164D) {
    if(var_2.var_4BC0 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_232B(var_0, var_1) {
  if(!isDefined(self._blackboard.asm_events[var_0]) || self._blackboard.asm_events[var_0].size == 0) {
    return 0;
  }

  foreach(var_4, var_3 in self._blackboard.asm_events[var_0]) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

func_68B0(var_0, var_1, var_2, var_3) {
  return func_232B(var_1, var_3);
}

func_666F(var_0, var_1, var_2, var_3) {
  return asm_ephemeraleventfired(var_1, var_3);
}

func_2310(var_0, var_1, var_2) {
  var_3 = level.asm[var_0];
  var_4 = level.asm[var_0].states[var_1];
  foreach(var_6 in var_4.transitions) {
    var_7 = var_6.var_11A1A;
    var_8 = self[[var_6.var_71D1]](var_0, var_1, var_7, var_6.var_100B1);
    if(var_8) {
      var_9 = level.asm[var_0].states[var_6.var_11A1A];
      var_0A = var_6.var_2B93;
      if(!isDefined(var_0A)) {
        var_0A = 0.2;
      }

      if(isDefined(var_9.var_C94B) && var_9.var_C94B) {
        var_0B = func_2310(var_0, var_7, 1);
        var_7 = var_0B[0];
        var_0A = var_0B[1];
      }

      if(isDefined(var_7)) {
        if(!var_2) {
          func_2388(var_0, var_1, var_4, var_4.var_116FB);
          func_238A(var_0, var_7, var_0A);
        }

        return [var_7, var_0A];
      }
    }
  }

  return [undefined, undefined];
}

asm_setstate(var_0, var_1) {
  foreach(var_0A, var_3 in self.var_164D) {
    var_4 = var_3.var_4BC0;
    var_5 = level.asm[var_0A].states[var_4];
    var_6 = level.asm[var_0A].states[var_0];
    if(!isDefined(var_6)) {
      continue;
    }

    var_7 = var_0;
    if(isDefined(var_6.var_C94B) && var_6.var_C94B) {
      var_8 = func_2310(var_0A, var_0, 1);
      var_7 = var_8[0];
      var_9 = var_8[1];
      if(!isDefined(var_7)) {
        continue;
      }
    }

    func_2388(var_0A, var_4, var_5, var_5.var_116FB);
    func_238A(var_0A, var_7, 0.2, undefined, undefined, var_1);
  }
}

func_2389() {
  var_0 = self.var_164D[self.asmname].var_4BC0;
  var_1 = level.asm[self.asmname].states[var_0];
  if(isDefined(self.var_7194)) {
    if(self[[self.var_7194]](self.asmname, var_1)) {
      func_231E(self.asmname, var_1, var_0);
      return;
    }
  }

  if(asm_shouldpowerdown(self.asmname, var_1)) {
    func_2325(self.asmname, var_1, var_0);
    return;
  }

  var_3 = 0;
  foreach(var_9, var_5 in self.var_164D) {
    var_0 = var_5.var_4BC0;
    var_6 = func_2310(var_9, var_0, 0);
    var_7 = var_6[0];
    var_8 = var_6[1];
    if(isDefined(var_7)) {
      var_3 = 1;
    }

    if(var_3) {
      return;
    }
  }
}

func_6A18(var_0, var_1, var_2, var_3) {
  if(weaponclass(self.var_394) == "pistol") {
    if(weaponclass(self.primaryweapon) != "mg" && weaponclass(self.primaryweapon) != "rocketlauncher" && weaponclass(self.primaryweapon) != "pistol") {
      return 0;
    }
  }

  return func_BCE7(var_0, var_1, var_2, var_3);
}

func_BCE7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && asm_getdemeanor() != var_3) {
    return 0;
  }

  return scripts\asm\asm_bb::bb_moverequested() && distancesquared(self.vehicle_getspawnerarray, self.origin) > 4;
}

func_C17F(var_0, var_1, var_2, var_3) {
  return !func_BCE7(var_0, var_1, var_2, var_3);
}

func_BCE8(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = self[[self.var_71A6]]();
    if(var_4 != var_3) {
      return 0;
    }
  }

  return func_BCE7(var_0, var_1, var_2, undefined);
}

func_9E41(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(isarray(var_3)) {
    var_4 = var_3[0];
  } else {
    var_4 = var_3;
  }

  if(scripts\asm\asm_bb::bb_isincombat() != var_4) {
    return 0;
  }

  var_5 = undefined;
  if(isarray(var_3) && isDefined(var_3[1])) {
    var_5 = var_3[1];
  }

  return func_BCE7(var_0, var_1, var_2, var_5);
}

asm_getdemeanor() {
  if(asm_getdemeanor()) {
    return "frantic";
  } else if(scripts\asm\asm_bb::bb_isfrantic()) {
    return "combat";
  } else if(isDefined(self.demeanoroverride) && self.demeanoroverride == "cqb" && !isDefined(self.objective_position)) {
    return "cqb";
  }

  return self._blackboard.movetype;
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

asm_setcrawlmelee(var_0) {
  self.asm.crawlmelee = var_0;
}

asm_setdemeanoranimoverride(var_0, var_1, var_2) {
  self.asm.animoverrides[var_0][var_1] = var_2;
}

asm_cleardemeanoranimoverride(var_0, var_1) {
  if(asm_hasdemeanoranimoverride(var_0, var_1)) {
    self.asm.animoverrides[var_0][var_1] = undefined;
  }
}

asm_hasdemeanoranimoverride(var_0, var_1) {
  return isDefined(self.asm.animoverrides[var_0]) && isDefined(self.asm.animoverrides[var_0][var_1]);
}

asm_getdemeanoranimoverride(var_0, var_1) {
  return self.asm.animoverrides[var_0][var_1];
}

asm_getcurrentstate(var_0) {
  var_1 = self.var_164D[var_0];
  return var_1.var_4BC0;
}

asm_hasalias(var_0, var_1) {
  return self[[self.var_7192]](var_0, var_1);
}

asm_lookupanimfromalias(var_0, var_1) {
  return self[[self.var_7193]](var_0, var_1);
}

asm_getallanimindicesforalias(var_0, var_1, var_2) {
  return self[[self.var_7190]](var_0, var_1, var_2);
}

func_235C(var_0, var_1, var_2, var_3) {
  var_4 = "";
  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  if(var_2) {
    if(func_232C(var_1, "pass_left")) {
      var_5 = var_4 + "left";
    } else if(func_232C(var_2, "pass_right")) {
      var_5 = var_5 + "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_5 = var_5 + "right";
    } else {
      var_5 = var_5 + "left";
    }
  } else {
    var_5 = var_5;
  }

  if(asm_hasalias(var_1, var_5 + var_0)) {
    return asm_lookupanimfromalias(var_1, var_5 + var_0);
  }

  if(var_4 != var_5 && asm_hasalias(var_1, var_4 + var_0)) {
    return asm_lookupanimfromalias(var_1, var_4 + var_0);
  }

  return undefined;
}

func_237B(var_0) {
  if(getdvarint("ai_iw7", 0) == 1) {
    self.moveplaybackrate = var_0;
    return;
  }

  self.moveplaybackrate = var_0;
}

asm_getmoveplaybackrate() {
  return self.moveplaybackrate;
}

func_231D(var_0, var_1, var_2, var_3) {
  var_4 = level.asm[var_0].states[var_2];
  self.asm.var_DCC7 = undefined;
  var_5 = 0;
  for(var_6 = 0; var_6 < var_4.transitions.size; var_6++) {
    var_7 = var_4.transitions[var_6].var_100B1;
    var_8 = var_7[1];
    for(var_9 = var_6 - 1; var_9 >= 0; var_9--) {}

    var_0A = 1;
    if(var_7.size > 2) {
      var_0A = var_7[3];
    }

    var_5 = var_5 + var_0A;
  }

  var_0B = randomfloat(var_5);
  var_0C = undefined;
  for(var_6 = 0; var_6 < var_4.transitions.size; var_6++) {
    var_0D = var_4.transitions[var_6];
    var_7 = var_0D.var_100B1;
    var_0C = var_7[1];
    var_0A = 1;
    if(var_7.size > 2) {
      var_0A = var_7[3];
    }

    if(var_0B < var_0A) {
      break;
    } else {
      var_0B = var_0B - var_0A;
    }
  }

  self.asm.var_DCC7 = var_0 + "_" + var_2 + "_" + var_0C;
  return 1;
}

func_230C(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + "_" + var_1 + "_" + var_3[1];
  return var_4 == self.asm.var_DCC7;
}

asm_getcurrentstatename(var_0) {
  return self.var_164D[var_0].var_4BC0;
}
/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2590.gsc
************************/

func_234D(param_00, param_01) {
  scripts\asm\asm::func_234E();
  if(param_01 == "hero_salter" || param_01 == "hero_boats") {
    scripts\asm\asm_bb::func_2984(1);
  }

  self.asm = spawnStruct();
  self.asm.archetype = param_01;
  self.asm.animoverrides = [];
  self.asm.var_7360 = 0;
  self.var_164D = [];
  self.asmname = param_00;
  self.var_718D = ::func_230D;
  self.var_7195 = ::func_238D;
  self.var_718E = ::func_230E;
  self.var_718F = ::func_230F;
  self.var_7194 = ::func_2382;
  self.var_7193 = ::func_235B;
  self.var_7192 = ::func_2348;
  self.var_7191 = ::asm_getallanimsforstate;
  self.var_7190 = ::asm_getallanimsforalias;
  scripts\asm\asm::func_2351(param_00, 1);
}

func_2382(param_00, param_01) {
  if(!isDefined(param_01.var_4E6D)) {
    return 0;
  }

  return !isalive(self);
}

func_12EE7(param_00) {
  if(self.var_E0 && !isDefined(self.var_55BF)) {
    var_01 = 1500;
    if(!isDefined(self.a.var_A9C8)) {
      self.a.var_A9C8 = 0;
    }

    if(!isDefined(self.damageshieldcounter) || gettime() - self.a.var_A9C8 > var_01) {
      self.damageshieldcounter = randomintrange(2, 3);
    }

    if(isDefined(self.sethalfresparticles) && distancesquared(self.origin, self.sethalfresparticles.origin) < squared(512)) {
      self.damageshieldcounter = 0;
    }

    if(self.damageshieldcounter > 0) {
      self.damageshieldcounter--;
    }
  }

  if(isDefined(param_00)) {
    self.damagedsubpart = param_00;
    return;
  }

  self.damagedsubpart = undefined;
}

func_1004C() {
  if(isDefined(self.var_71D0)) {
    return self[[self.var_71D0]]();
  }

  return func_1004D();
}

func_1004D() {
  var_00 = 4096;
  if(self.a.var_5605) {
    return 0;
  }

  if(isDefined(self.vehicle_getspawnerarray) && self pathdisttogoal() < var_00) {
    return 0;
  }

  return 1;
}

func_51B8() {
  self endon("terminate_ai_threads");
  self waittill("entitydeleted");
  foreach(var_01 in self.var_164D) {
    var_02 = var_01.var_4BC0;
    self notify(var_02 + "_finished");
  }

  self notify("terminate_ai_threads");
}

func_C879() {
  if(1) {
    func_12EE7();
    if(!func_1004C()) {
      if(isDefined(self.script) && self.script == "pain") {
        self notify("killanimscript");
      }

      return;
    }

    var_00 = 0;
    foreach(var_09, var_02 in self.var_164D) {
      var_03 = var_02.var_4BC0;
      var_04 = level.asm[var_09].states[var_03];
      if(!isDefined(var_04.var_C87F)) {
        continue;
      }

      var_05 = level.asm[var_09].states[var_04.var_C87F];
      scripts\asm\asm::func_2388(var_09, var_03, var_04, var_04.var_116FB);
      var_06 = var_04.var_C87F;
      if(isDefined(var_05.var_C94B) && var_05.var_C94B) {
        var_07 = scripts\asm\asm::func_2310(var_09, var_04.var_C87F, 1);
        var_06 = var_07[0];
        var_08 = var_07[1];
      }

      scripts\asm\asm::func_238A(var_09, var_06, 0.05, undefined, undefined, var_04.var_C87C);
      if(isDefined(self.unittype) && self.unittype == "c6") {
        self playSound("shield_death_c6_1");
      }

      var_00 = 1;
    }

    if(!var_00 && self.script == "pain") {
      self notify("killanimscript");
    }
  }

  self endon("killanimscript");
  self waittill("Hellfreezesover");
}

traversehandler() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("traverse_begin", var_00, var_01);
    if(1) {
      var_02 = self.asmname;
      var_03 = level.asm[var_02];
      if(!func_234B(self.asm.archetype, var_00)) {
        var_00 = "traverse_external";
      }

      var_04 = self.var_164D[var_02].var_4BC0;
      var_05 = var_03.states[var_04];
      if(var_04 == "traversal_orient") {
        continue;
      }

      scripts\asm\asm::func_2388(var_02, var_04, var_05, var_05.var_116FB);
      scripts\asm\asm::func_238A(var_02, var_00, 0.2, undefined, undefined, undefined);
    }
  }
}

func_111A9() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("damage_subpart", var_00);
    foreach(var_02 in var_00) {
      func_12EE7(var_02.spawnscriptitem);
      if(!func_1004C()) {
        if(isDefined(self.script) && self.script == "pain") {
          self notify("killanimscript");
        }

        continue;
      }

      var_03 = 0;
      foreach(var_0C, var_05 in self.var_164D) {
        var_06 = var_05.var_4BC0;
        var_07 = level.asm[var_0C].states[var_06];
        if(!isDefined(var_07.var_C87F)) {
          continue;
        }

        var_08 = level.asm[var_0C].states[var_07.var_C87F];
        scripts\asm\asm::func_2388(var_0C, var_06, var_07, var_07.var_116FB);
        var_09 = var_07.var_C87F;
        if(isDefined(var_08.var_C94B) && var_08.var_C94B) {
          var_0A = scripts\asm\asm::func_2310(var_0C, var_07.var_C87F, 1);
          var_09 = var_0A[0];
          var_0B = var_0A[1];
        }

        scripts\asm\asm::func_238A(var_0C, var_09, 0.05, undefined, undefined, var_07.var_C87C);
        var_03 = 1;
      }

      if(!var_03 && self.script == "pain") {
        self notify("killanimscript");
      }
    }
  }
}

func_237F(param_00) {
  switch (param_00) {
    case "face node":
      var_01 = 1024;
      if(scripts\engine\utility::actor_is3d()) {
        var_02 = self.angles;
        if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_01) {
          var_02 = scripts\asm\shared_utility::getnodeforwardangles(self.target_getindexoftarget);
        }

        self orientmode("face angle 3d", var_02);
      } else {
        var_03 = self.angles[1];
        if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_01) {
          var_03 = scripts\asm\shared_utility::getnodeforwardyaw(self.target_getindexoftarget);
        }

        self orientmode("face angle", var_03);
      }
      break;

    case "face current":
      self orientmode("face angle 3d", self.angles);
      break;

    default:
      self orientmode(param_00);
      break;
  }
}

func_237E(param_00) {
  self animmode(param_00, 0);
}

func_230E(param_00, param_01) {
  if(scripts\asm\asm::func_231B(param_00, "gesture")) {
    func_2381(param_00, param_01);
  }
}

func_238D(param_00) {
  if(isDefined(param_00.var_10B53) && param_00.var_10B53 != "") {
    if(param_00.var_10B53 != "prone" && self.a.pose != param_00.var_10B53) {
      scripts\anim\utility::exitpronewrapper(1);
    }

    self.a.pose = param_00.var_10B53;
    scripts\asm\asm_bb::bb_requestsmartobject(param_00.var_10B53);
  }
}

func_230D(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm::func_231B(param_00, "aim")) {
    func_2380(param_00, param_02, param_03);
  }
}

func_2326(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_01;
  if(isDefined(param_04)) {
    var_05 = param_04;
  }

  self waittill(var_05, var_06);
  if(!isDefined(var_06)) {
    var_06 = ["undefined"];
  }

  if(!isarray(var_06)) {
    var_06 = [var_06];
  }

  var_07 = undefined;
  foreach(var_09 in var_06) {
    scripts\asm\asm::asm_fireevent(param_01, var_09);
    var_0A = scripts\anim\notetracks::handlenotetrack(var_09, var_05, param_02, param_03);
    if(!isDefined(var_0A)) {
      var_0A = func_2344(param_00, var_09, param_01);
    }

    if(isDefined(var_0A)) {
      var_07 = var_0A;
    }
  }

  return var_07;
}

func_2344(param_00, param_01, param_02) {
  if(func_238B(param_01)) {
    return;
  }

  switch (param_01) {
    case "start_aim":
      var_03 = level.asm[param_00].states[param_02];
      if(isDefined(var_03.magicbullet) && scripts\engine\utility::array_contains(var_03.magicbullet, "notetrackAim")) {
        func_2380(param_00, param_02, 0.2);
      }
      break;
  }
}

func_238B(param_00) {
  if(!scripts\engine\utility::string_starts_with(param_00, "ds ")) {
    return 0;
  }

  var_01 = 3;
  self.asm.var_4E6E = spawnStruct();
  var_01 = var_01 + 1;
  var_02 = "";
  while(var_01 < param_00.size && param_00[var_01] != "]") {
    var_02 = var_02 + param_00[var_01];
    var_01 = var_01 + 1;
  }

  self.asm.var_4E6E.var_10E2C = var_02;
  var_01 = var_01 + 1;
  if(var_01 < param_00.size) {
    var_01 = var_01 + 2;
    var_03 = "";
    while(var_01 < param_00.size && param_00[var_01] != "]") {
      var_03 = var_03 + param_00[var_01];
      var_01 = var_01 + 1;
    }

    self.asm.var_4E6E.params = var_03;
  }

  return 1;
}

func_2324(param_00, param_01, param_02) {
  self endon(param_00);
  wait(param_02);
  self notify(param_01);
}

func_2323(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_01 + "_timeout";
  var_06 = param_01 + "_endHelper";
  self endon(var_05);
  thread func_2324(var_06, var_05, param_02);
  var_07 = func_231F(param_00, param_01, param_03, param_04);
  self notify(var_06);
  return var_07;
}

func_231F(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  for(;;) {
    var_06 = func_2326(param_00, param_01, param_02, param_03, param_04);
    if(isDefined(var_06)) {
      if(param_05 && !scripts\asm\asm::func_232B(param_01, "end")) {
        scripts\asm\asm::asm_fireevent(param_01, "end");
      }

      return var_06;
    }
  }
}

func_2322(param_00, param_01, param_02, param_03) {
  for(;;) {
    self waittill(param_01, var_04);
    if(!isDefined(var_04)) {
      var_04 = ["undefined"];
    }

    if(!isarray(var_04)) {
      var_04 = [var_04];
    }

    var_05 = undefined;
    foreach(var_07 in var_04) {
      var_08 = [
        [param_02]
      ](param_01, var_07, param_03);
      if(isDefined(var_08) && var_08) {
        continue;
      }

      scripts\asm\asm::asm_fireevent(param_01, var_07);
      var_09 = scripts\anim\notetracks::handlenotetrack(var_07, param_01, undefined, undefined);
      if(isDefined(var_09)) {
        var_05 = var_09;
      }
    }

    if(isDefined(var_05)) {
      return var_05;
    }
  }
}

func_2320(param_00, param_01, param_02, param_03) {
  var_04 = param_01 + "_note_loop_end";
  self endon(var_04);
  var_05 = getanimlength(param_02);
  thread func_2321(var_04, param_01 + "_finished", var_05);
  func_231F(param_00, param_01, param_03);
  self notify(var_04);
}

func_2321(param_00, param_01, param_02) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(param_00);
  self endon(param_01);
  wait(param_02);
  self notify(param_00);
}

func_2309(param_00) {
  return animhasnotetrack(param_00, "facial_override");
}

func_2318() {
  if(self.var_6A8B != "filler") {
    var_00 = func_2356("Knobs", "head");
    self clearanim(var_00, 0.2);
    self.facialidx = undefined;
  }
}

func_2376() {
  var_00 = self.asmname;
  var_01 = self.var_164D[var_00].var_4BC0;
  if(var_01 == "AnimScripted") {
    return;
  }

  func_2369(var_00, var_01, undefined);
}

func_2369(param_00, param_01, param_02) {
  if(param_00 != self.asmname) {
    return;
  }

  if(isDefined(level.asm[param_00].states[param_01].var_6A8B)) {
    func_236B(param_02, level.asm[param_00].states[param_01].var_6A8B, self.facialidx);
    return;
  }

  func_2318();
  self.asm.var_6A86 = "";
}

func_236B(param_00, param_01, param_02) {
  if(!scripts\asm\asm::asm_hasalias("Knobs", "head")) {
    return;
  }

  var_03 = func_2356("Knobs", "head");
  if(!scripts\sp\utility::isfacialstateallowed("asm")) {
    return;
  }

  if(isDefined(param_00) && func_2309(param_00)) {
    return;
  }

  if(!isDefined(self.asm.var_6A86)) {
    self.asm.var_6A86 = "";
  }

  scripts\sp\utility::func_F6FE("asm");
  if(self.asm.var_6A86 != param_01 || self _meth_8103(var_03) < 1) {
    self.asm.var_6A86 = param_01;
    var_04 = "facial_" + param_01;
    var_05 = scripts\asm\asm::asm_lookupanimfromalias("facial_animation", var_04);
    var_03 = func_2356("Knobs", "head");
    if(isDefined(var_05)) {
      self setanimknob(var_05, 1, 0.1, 1);
      self give_attacker_kill_rewards(var_03, 5, 0.1);
    }
  }
}

func_236A(param_00) {
  self endon("death");
  var_01 = "";
  if(isDefined(self.asm)) {
    var_01 = self.asm.archetype;
  }

  if(isDefined(self.var_1FA8)) {
    var_01 = self.var_1FA8;
  }

  if(!scripts\sp\utility::isfacialstateallowed("asm") && param_00 != "facial_death") {
    return;
  }

  if(var_01 != "") {
    scripts\sp\utility::func_F6FE("asm");
    var_02 = _func_2EF(var_01, "facial_animation", param_00, 0);
    if(param_00 == "facial_death") {
      if(isDefined(self.var_6A84)) {
        if(self.var_6A84 == param_00) {
          if(isDefined(self.var_6A83)) {
            var_02 = self.var_6A83;
          }
        }
      }
    }

    if(isDefined(var_02)) {
      self setanimknob(var_02, 1, 0.267, 1);
      self.var_6A83 = var_02;
      self.var_6A84 = param_00;
    }
  }
}

func_236C(param_00) {
  var_01 = "soldier";
  var_02 = _func_2EF(var_01, "facial_animation", "facial_death", 0);
  if(isDefined(var_02)) {
    param_00 setanimknob(var_02, 1, 0, 0);
  }
}

func_234F() {
  self endon("death");
  var_00 = 0;
  var_01 = 0;
  var_02 = func_2356("Knobs", "body");
  var_03 = 0;
  var_04 = 0;
  for(;;) {
    var_05 = self _meth_853F(var_02);
    var_06 = var_05[0] - var_00;
    var_07 = var_06 > 0.001 - var_06 < -0.001;
    if(var_07 != var_03) {
      if(var_07 > 0) {
        var_00 = var_05[0];
        var_03 = var_07;
        wait(0.1);
        func_234C("left");
        continue;
      }

      if(var_07 < 0) {
        var_00 = var_05[0];
        var_03 = var_07;
        func_2319("left");
        continue;
      }
    }

    var_00 = var_05[0];
    var_03 = var_07;
    var_08 = var_05[1] - var_01;
    var_09 = var_08 > 0.001 - var_08 < -0.001;
    if(var_09 != var_04) {
      if(var_09 > 0) {
        var_01 = var_05[1];
        var_04 = var_09;
        wait(0.1);
        func_234C("right");
        continue;
      }

      if(var_09 < 0) {
        var_01 = var_05[1];
        var_04 = var_09;
        func_2319("right");
        continue;
      }
    }

    var_01 = var_05[1];
    var_04 = var_09;
    wait(0.05);
  }
}

func_234C(param_00) {
  var_01 = scripts\anim\utility::func_7DA1();
  if(var_01 == "none") {
    func_2319(param_00);
  }

  func_236D(param_00);
}

func_236D(param_00) {
  var_01 = scripts\anim\utility::func_7DA1();
  if(var_01 == "none") {
    return;
  }

  var_02 = "ik_finger_pose_r";
  var_03 = "ik_fingers_r";
  var_04 = getweaponbasename(var_01);
  if(param_00 == "left") {
    var_02 = "ik_finger_pose_l";
    var_03 = "ik_fingers_l";
    var_05 = getweaponattachments(var_01);
    if(isDefined(var_05)) {
      if(scripts\engine\utility::array_contains(var_05, "foregrip")) {
        var_04 = "foregrip";
      }
    }
  }

  if(!func_234B(self.asm.archetype, var_02)) {
    return;
  }

  if(!isDefined(var_04) || !scripts\asm\asm::asm_hasalias(var_02, var_04)) {
    if(!isDefined(var_04)) {
      var_04 = "UNDEFINED";
    }

    return;
  }

  var_06 = scripts\asm\asm::asm_lookupanimfromalias(var_02, var_04);
  var_07 = func_2356("Knobs", var_03);
  self give_attacker_kill_rewards(var_07, 10, 0.3, 1);
  self give_attacker_kill_rewards(var_06, 1, 0.3, 1);
}

func_2319(param_00) {
  var_01 = "ik_fingers_l";
  if(param_00 == "right") {
    var_01 = "ik_fingers_r";
  }

  if(!scripts\asm\asm::asm_hasalias("Knobs", var_01)) {
    return;
  }

  var_02 = func_2356("Knobs", var_01);
  self clearanim(var_02, 0.3, 1);
}

func_2355() {
  var_00 = scripts\anim\utility::func_7DA1();
  var_01 = getweaponbasename(var_00);
  var_02 = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];
  if(isDefined(var_01) && scripts\engine\utility::array_contains(var_02, var_01)) {
    return 1;
  }

  return 0;
}

func_236E() {
  func_231A();
  var_00 = scripts\asm\asm::asm_lookupanimfromalias("Visor", "helmet_visor_up");
  if(self.asm.var_DC48 == 1) {
    self give_attacker_kill_rewards(var_00, 1, 0, 1);
    return;
  }

  var_01 = scripts\asm\asm::asm_lookupanimfromalias("Visor", "helmet_visor_down");
  self give_attacker_kill_rewards(var_01, 1, 0, 1);
  wait(getanimlength(var_01) - 0.1);
  func_231A();
}

func_231A() {
  var_00 = func_2356("Knobs", "visor");
  self clearanim(var_00, 0);
}

asm_getaimlimitset(param_00, param_01, param_02) {
  return archetypegetaliases(param_00, param_01);
}

func_235E(param_00, param_01, param_02, param_03) {
  var_04 = asm_getaimlimitset(param_00, param_01);
  var_05 = 0;
  var_06 = undefined;
  var_07 = -1;
  if(isDefined(param_02)) {
    var_07 = param_02.size;
  }

  if(!isDefined(var_04)) {
    return undefined;
  }

  foreach(var_0A in var_04) {
    if(var_07 < 0 || getsubstr(var_0A, 0, var_07) == param_02) {
      var_05 = var_05 + 1;
      var_0B = 1 / var_05;
      if(randomfloat(1) <= var_0B) {
        var_06 = var_0A;
      }
    }
  }

  return var_06;
}

func_235D(param_00, param_01, param_02) {
  return func_235E(self.asm.archetype, param_00, param_01, param_02);
}

func_2357(param_00, param_01, param_02) {
  var_03 = undefined;
  if(isDefined(self.var_1FA8)) {
    var_03 = archetypegetalias(param_00, param_01, param_02, 0);
  } else {
    var_03 = archetypegetalias(param_00, param_01, param_02, scripts\asm\asm::asm_getdemeanor());
  }

  if(isDefined(var_03)) {
    return var_03.var_47;
  }

  return undefined;
}

func_2356(param_00, param_01) {
  if(isDefined(self.var_1FA8)) {
    var_02 = func_2357(self.var_1FA8, param_00, param_01);
  } else {
    var_02 = func_2357(self.asm.archetype, param_01, var_02);
  }

  return var_02;
}

func_2305(param_00, param_01, param_02) {
  var_03 = archetypegetalias(param_00, param_01, param_02, scripts\asm\asm::asm_getdemeanor());
  if(isDefined(var_03)) {
    return 1;
  }

  return 0;
}

func_2359(param_00, param_01, param_02) {
  return _func_2EF(param_00, param_01, param_02, scripts\asm\asm::asm_getdemeanor());
}

func_235B(param_00, param_01) {
  var_02 = func_2359(self.asm.archetype, param_00, param_01);
  return var_02;
}

func_234B(param_00, param_01) {
  if(archetypeassetloaded(param_00)) {
    return _func_2F1(param_00, param_01);
  }

  return 0;
}

func_2348(param_00, param_01) {
  var_02 = func_2357(self.asm.archetype, param_00, param_01);
  return isDefined(var_02);
}

asm_getallanimsforalias(param_00, param_01, param_02) {
  var_03 = archetypegetalias(param_00, param_01, param_02, 1);
  if(!isDefined(var_03)) {
    return undefined;
  }

  var_04 = var_03.var_47;
  if(!isarray(var_04)) {
    var_04 = [var_04];
  }

  var_05 = archetypegetalias(param_00, param_01, param_02, 0);
  var_06 = var_05.var_47;
  if(!isarray(var_06)) {
    var_06 = [var_06];
  }

  foreach(var_08 in var_06) {
    if(!scripts\engine\utility::array_contains(var_04, var_08)) {
      var_04[var_04.size] = var_08;
    }
  }

  return var_04;
}

asm_getallanimsforstate(param_00, param_01) {
  var_02 = level.asm[param_00].states[param_01].var_71A5;
  var_03 = level.asm[param_00].states[param_01].var_7DC8;
  var_04 = self[[var_02]](param_00, param_01, var_03);
  return var_04;
}

func_2342() {
  return func_2356("Knobs", "root");
}

asm_getbodyknob() {
  return func_2356("Knobs", "body");
}

func_235F(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  var_05 = asm_getbodyknob();
  self clearanim(var_05, param_02);
  if(isDefined(param_04) && param_04) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_06 = func_2356("Knobs", "move");
      self _meth_84F2(var_06);
    }
  }

  var_07 = undefined;
  var_08 = scripts\asm\asm::func_2341(param_00, param_01);
  var_09 = 0.2;
  var_0A = isDefined(param_04) && param_04;
  for(;;) {
    var_0B = asm_getallanimsforstate(param_00, param_01);
    if(isDefined(param_04) && param_04) {
      param_03 = scripts\asm\asm::asm_getmoveplaybackrate();
      self _meth_84F1(param_03);
    }

    if(isDefined(var_07) && var_07 != var_0B) {
      self clearanim(var_07, param_02);
    }

    if(self _meth_8103(var_0B) > 0) {
      self _meth_82E1(param_01, var_0B, 1, param_02, param_03);
    } else {
      self _meth_82EA(param_01, var_0B, 1, param_02, param_03);
    }

    func_2369(param_00, param_01, var_0B);
    var_0C = getanimlength(var_0B);
    if(var_0C <= 0.05) {
      return;
    }

    var_0D = undefined;
    var_0E = param_03;
    while(!isDefined(var_0D)) {
      var_0D = func_2323(param_00, param_01, var_09, var_08);
      if(!isDefined(var_0D) && var_0A) {
        param_03 = scripts\asm\asm::asm_getmoveplaybackrate();
        if(param_03 != var_0E) {
          self _meth_84F1(param_03);
          self _meth_82B1(var_0B, param_03);
        }
      }
    }

    var_07 = var_0B;
  }
}

func_2368(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  var_05 = asm_getallanimsforstate(param_00, param_01);
  self clearanim(asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_05, 1, param_02, 1);
  func_2369(param_00, param_01, var_05);
  var_06 = func_2322(param_00, param_01, param_03, param_04);
  if(var_06 == "end") {
    if(!scripts\asm\asm::func_232B(param_01, "end")) {
      scripts\asm\asm::asm_fireevent(param_01, "end");
    }

    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }
}

func_2366(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  var_03 = asm_getallanimsforstate(param_00, param_01);
  self clearanim(asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_03, 1, param_02, 1);
  func_2369(param_00, param_01, var_03);
  var_04 = func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
}

func_2364(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  var_03 = asm_getallanimsforstate(param_00, param_01);
  self clearanim(asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_03, 1, param_02, 1);
  func_2369(param_00, param_01, var_03);
  var_04 = func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  if(var_04 == "code_move") {
    var_04 = func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  }

  if(var_04 == "end") {
    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }
}

func_2363(param_00, param_01, param_02, param_03) {
  var_04 = asm_getallanimsforstate(param_00, param_01);
  var_05 = isDefined(param_03) && param_03 == "limited";
  if(var_05) {
    self _meth_82E6(param_01, var_04, 1, param_02, 1);
  } else {
    self _meth_82E7(param_01, var_04, 1, param_02, 1);
  }

  func_2369(param_00, param_01, var_04);
  func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
}

func_2361(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = asm_getbodyknob();
  var_05 = isDefined(param_03) && param_03 == "limited";
  for(;;) {
    var_06 = asm_getallanimsforstate(param_00, param_01);
    if(var_04 != var_06) {
      if(var_05) {
        self _meth_82E6(param_01, var_06, 1, param_02, 1);
      } else {
        self _meth_82E7(param_01, var_06, 1, param_02, 1);
      }

      var_04 = var_06;
    }

    thread func_2362(param_01, var_06, var_05);
    func_2369(param_00, param_01, var_06);
    func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
    self notify(param_01 + "additive_cancel");
  }
}

func_2362(param_00, param_01, param_02) {
  self endon(param_00 + "_finished");
  self endon(param_00 + "additive_cancel");
  while(isDefined(param_01)) {
    wait(0.2);
    if(param_02) {
      self _meth_82E8(param_00, param_01, 1, 0, 1);
      continue;
    }

    self _meth_82E1(param_00, param_01, 1, 0, 1);
  }
}

func_2377(param_00) {
  if(isDefined(param_00["left"])) {
    self.setmatchdatadef = param_00["left"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.setmatchdatadef = 56;
  } else {
    self.setmatchdatadef = 45;
  }

  if(isDefined(param_00["right"])) {
    self.setdevdvar = param_00["right"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.setdevdvar = -56;
  } else {
    self.setdevdvar = -45;
  }

  if(isDefined(param_00["up"])) {
    self.var_368 = param_00["up"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.var_368 = -65;
  } else {
    self.var_368 = -45;
  }

  if(isDefined(param_00["down"])) {
    self.isbot = param_00["down"];
    return;
  }

  if(scripts\engine\utility::actor_is3d()) {
    self.isbot = 65;
    return;
  }

  self.isbot = 45;
}

asm_generichandler(param_00, param_01) {
  if(!isDefined(level.var_1A43[param_00])) {
    return "default";
  }

  if(!isDefined(level.var_1A43[param_00][param_01])) {
    return "default";
  }

  return level.var_1A43[param_00][param_01];
}

func_237D(param_00, param_01) {
  if(isDefined(self.var_9322) && self.var_9322) {
    return;
  }

  var_02 = asm_generichandler(param_00, param_01);
  if(!isDefined(level.var_43FE[param_00])) {
    func_2377([]);
    return;
  }

  var_03 = scripts\asm\asm::asm_getdemeanor();
  if(var_03 && isDefined(level.var_7361[param_00][var_02])) {
    func_2377(level.var_7361[param_00][var_02]);
    return;
  } else if(isDefined(level.var_43FE[param_00][var_02])) {
    func_2377(level.var_43FE[param_00][var_02]);
    return;
  }

  func_2377([]);
}

func_2380(param_00, param_01, param_02, param_03, param_04) {
  var_05 = scripts\engine\utility::weaponclass(self.var_394);
  if(var_05 == "none") {
    return;
  }

  if(scripts\asm\asm::asm_hasalias(param_01, "aim_1")) {
    return;
  }

  if(!scripts\asm\asm::asm_hasalias(param_01, var_05 + "_aim_8")) {
    var_05 = "rifle";
  }

  func_237D(param_00, param_01);
  var_06 = var_05 + "_aim_5";
  var_07 = undefined;
  if((!isDefined(param_03) || param_03) && scripts\asm\asm::asm_hasalias(param_01, var_06)) {
    var_07 = func_235B(param_01, var_05 + "_aim_5");
  }

  self _meth_82A9(func_235B(param_01, var_05 + "_aim_8"), 1, param_02);
  self _meth_82A9(func_235B(param_01, var_05 + "_aim_2"), 1, param_02);
  self _meth_82A9(func_235B(param_01, var_05 + "_aim_4"), 1, param_02);
  self _meth_82A9(func_235B(param_01, var_05 + "_aim_6"), 1, param_02);
  if(isDefined(var_07)) {
    self _meth_82AC(var_07, 1, param_02);
  }

  if(scripts\asm\asm::asm_hasalias(param_01, "aim_root")) {
    self give_attacker_kill_rewards(func_235B(param_01, "aim_root"), 1, param_02);
  } else if(scripts\asm\asm::asm_hasalias("Knobs", "aim_root")) {
    self give_attacker_kill_rewards(func_235B("Knobs", "aim_root"), 1, param_02);
  }

  var_08 = func_2348(param_01, "aim_knob_2");
  if(var_08) {
    self notify("StopCleanupAimKnobs");
    self.asm.var_11A90.var_1A1D = func_235B(param_01, "aim_knob_2");
    self.asm.var_11A90.var_1A1F = func_235B(param_01, "aim_knob_4");
    self.asm.var_11A90.var_1A22 = func_235B(param_01, "aim_knob_6");
    self.asm.var_11A90.var_1A24 = func_235B(param_01, "aim_knob_8");
    if(isDefined(var_07)) {
      self.asm.var_11A90.var_1A21 = func_235B(param_01, "aim_knob_5");
    }

    thread func_2312(param_01);
  }

  lib_0A2B::func_11AFD();
}

func_2381(param_00, param_01) {
  var_02 = scripts\asm\asm::asm_getdemeanor();
  self.asm.var_77C1.var_77A6 = func_235B("gesture", "gesture_move_up");
  self.asm.var_77C1.var_778C = func_235B("gesture", "gesture_armup");
  self.asm.var_77C1.var_77A8 = func_235B("gesture", "gesture_on_me");
  self.asm.var_77C1.var_77A0 = func_235B("gesture", "gesture_hold");
  self.asm.var_77C1.var_7795 = func_235B("gesture", "gesture_fallback_up");
  self.asm.var_77C1.var_7794 = func_235B("gesture", "gesture_fallback_down");
  if(var_02 == "casual") {
    self.asm.var_77C1.var_77AA = func_235B("gesture_point", "gesture_point_center");
    self.asm.var_77C1.var_77AC = func_235B("gesture_point", "gesture_point_left");
    self.asm.var_77C1.var_77AE = func_235B("gesture_point", "gesture_point_right");
    self.asm.var_77C1.var_77AF = func_235B("gesture_point", "gesture_point_up");
    self.asm.var_77C1.var_77AB = func_235B("gesture_point", "gesture_point_down");
    self.asm.var_77C1.var_77B6 = func_235B("gesture", "gesture_shrug_anim");
    self.asm.var_77C1.var_778F = func_235B("gesture", "gesture_cross_anim");
    self.asm.var_77C1.var_77A7 = func_235B("gesture", "gesture_nod_anim");
    self.asm.var_77C1.var_77B5 = func_235B("gesture", "gesture_shake_head_anim");
    self.asm.var_77C1.var_77B4 = func_235B("gesture", "gesture_salute_anim");
    self.asm.var_77C1.var_77BF = func_235B("gesture", "gesture_wave_anim");
    self.asm.var_77C1.var_77BE = func_235B("gesture", "gesture_wait_anim");
    return;
  }

  if(var_02 == "casual_gun") {
    self.asm.var_77C1.var_77AA = func_235B("gesture_point", "gesture_casual_gun_point_center");
    self.asm.var_77C1.var_77AC = func_235B("gesture_point", "gesture_casual_gun_point_left");
    self.asm.var_77C1.var_77AE = func_235B("gesture_point", "gesture_casual_gun_point_right");
    self.asm.var_77C1.var_77AF = func_235B("gesture_point", "gesture_casual_gun_point_up");
    self.asm.var_77C1.var_77AB = func_235B("gesture_point", "gesture_casual_gun_point_down");
    self.asm.var_77C1.var_77B6 = func_235B("gesture", "gesture_gun_shrug_anim");
    self.asm.var_77C1.var_778F = func_235B("gesture", "gesture_gun_cross_anim");
    self.asm.var_77C1.var_77A7 = func_235B("gesture", "gesture_gun_nod_anim");
    self.asm.var_77C1.var_77B5 = func_235B("gesture", "gesture_gun_shake_head_anim");
    self.asm.var_77C1.var_77B4 = func_235B("gesture", "gesture_gun_salute_anim");
    self.asm.var_77C1.var_77BF = func_235B("gesture", "gesture_gun_wave_anim");
    self.asm.var_77C1.var_77BE = func_235B("gesture", "gesture_gun_wait_anim");
    return;
  }

  self.asm.var_77C1.var_77AA = func_235B("gesture_point", "gesture_gun_point_center");
  self.asm.var_77C1.var_77AC = func_235B("gesture_point", "gesture_gun_point_left");
  self.asm.var_77C1.var_77AE = func_235B("gesture_point", "gesture_gun_point_right");
  self.asm.var_77C1.var_77AF = func_235B("gesture_point", "gesture_gun_point_up");
  self.asm.var_77C1.var_77AB = func_235B("gesture_point", "gesture_gun_point_down");
  self.asm.var_77C1.var_77B6 = func_235B("gesture", "gesture_gun_shrug_anim");
  self.asm.var_77C1.var_778F = func_235B("gesture", "gesture_gun_cross_anim");
  self.asm.var_77C1.var_77A7 = func_235B("gesture", "gesture_gun_nod_anim");
  self.asm.var_77C1.var_77B5 = func_235B("gesture", "gesture_gun_shake_head_anim");
  self.asm.var_77C1.var_77B4 = func_235B("gesture", "gesture_gun_salute_anim");
  self.asm.var_77C1.var_77BF = func_235B("gesture", "gesture_gun_wave_anim");
  self.asm.var_77C1.var_77BE = func_235B("gesture", "gesture_gun_wait_anim");
}

func_2313(param_00, param_01) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  scripts\engine\utility::waittill_any_timeout_1(param_01, param_00 + "_finished");
  func_2311();
}

func_2312(param_00) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  self waittill(param_00 + "_finished");
  func_2311();
}

func_2311() {
  if(!isDefined(self.asm.var_11A90)) {
    return;
  }

  self.asm.var_11A90.var_1A1D = undefined;
  self.asm.var_11A90.var_1A1F = undefined;
  self.asm.var_11A90.var_1A22 = undefined;
  self.asm.var_11A90.var_1A24 = undefined;
  self.asm.var_11A90.var_1A21 = undefined;
}

func_238E(param_00, param_01, param_02) {
  self endon(param_01 + "_finished");
  var_03 = 0;
  while(!var_03) {
    self waittill(param_01, var_04);
    if(!isarray(var_04)) {
      var_04 = [var_04];
    }

    foreach(var_06 in var_04) {
      if(var_06 == "start_aim") {
        func_2380(param_00, param_01, param_02);
        var_03 = 1;
        break;
      }
    }
  }
}

func_230A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self.asmname;
  var_08 = self.var_164D[var_07].var_4BC0;
  var_09 = level.asm[var_07].states[var_08];
  scripts\asm\asm::func_2388(var_07, var_08, var_09, var_09.var_116FB);
  scripts\asm\asm::func_238A(var_07, "AnimScripted", 0.2);
}

func_2386() {
  self givescorefortrophyblocks();
}

func_2307(param_00, param_01) {
  if(getdvarint("ai_iw7", 0) == 0) {
    if(!isDefined(param_01)) {
      self animcustom(param_00);
    } else {
      self animcustom(param_00, param_01);
    }

    return;
  }

  scripts\asm\asm_bb::bb_setanimscripted();
  self.asm.var_1FAC = param_01;
  self animcustom(param_00, ::func_2308);
  var_02 = self.asmname;
  var_03 = self.var_164D[var_02].var_4BC0;
  var_04 = level.asm[var_02].states[var_03];
  scripts\asm\asm::func_2388(var_02, var_03, var_04, var_04.var_116FB);
  scripts\asm\asm::func_238A(var_02, "AnimScripted", 0.2);
}

func_2308() {
  scripts\asm\asm_bb::bb_clearanimscripted();
  if(!isDefined(self.asm.var_1FAC)) {
    return;
  }

  self[[self.asm.var_1FAC]]();
  self.asm.var_1FAC = undefined;
}

func_2385() {
  self notify("killanimscript");
}

func_230F(param_00) {
  if(isDefined(param_00.var_C704)) {
    func_237F(param_00.var_C704);
  }

  if(isDefined(param_00.var_1FBA)) {
    func_237E(param_00.var_1FBA);
  }
}

func_9F70(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_E2)) {
    if(self.var_E2 == "none") {
      return 0;
    }

    if(scripts\sp\utility::func_9DB4("emp")) {
      return 1;
    }

    if(scripts\sp\utility::func_9DB4("iw7_sonic")) {
      return 1;
    }

    if(func_FFBD()) {
      return 1;
    }
  }

  return 0;
}

func_9F4C(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_DE) && self.var_DE == "MOD_IMPACT") {
    return 0;
  }

  if(scripts\sp\utility::func_9DB4("emp")) {
    return 1;
  }

  if(self.unittype == "c6" || self.unittype == "c8") {
    if(scripts\sp\utility::func_9DB4("iw7_sonic") && scripts\sp\utility::func_9FFE(self.var_E2)) {
      return 1;
    }
  }

  if(scripts\sp\utility::func_9DB4("iw7_atomizer") && self.var_DE != "MOD_MELEE" && self.health <= 0) {
    return 1;
  }

  return 0;
}

func_D521() {
  if(scripts\sp\utility::func_9DB4("iw7_sonic") && scripts\sp\utility::func_9FFE(self.var_E2)) {
    playFXOnTag(level.var_7649["soldier_shock"], self, "j_knee_ri");
    playFXOnTag(level.var_7649["soldier_shock"], self, "j_shoulder_ri");
  }
}

func_9DB5(param_00, param_01, param_02, param_03) {
  var_04 = self.var_E1;
  if(isDefined(self.var_C873)) {
    var_04 = self.var_C873;
  }

  if(scripts\sp\utility::func_9DB4("iw7_sonic") && self.var_DE != "MOD_MELEE" && var_04 >= 75) {
    return 1;
  }

  return 0;
}

func_FFBD() {
  if(self.var_DE == "MOD_MELEE") {
    return 0;
  }

  if(!isDefined(self.var_E2)) {
    return 0;
  }

  if(self.var_E2 == "none") {
    return 0;
  }

  var_00 = getweaponbasename(self.var_E2);
  if(!isDefined(var_00)) {
    return 0;
  }

  if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.team) && isDefined(self.team) && self.sethalfresparticles.team == self.team) {
    return 0;
  }

  return var_00 == "iw7_atomizer";
}

func_7E5A() {
  var_00 = -1 * self.var_DC;
  var_01 = anglesToForward(self.angles);
  var_02 = vectordot(var_01, var_00);
  if(var_02 > 0.707) {
    return "front";
  }

  if(var_02 < -0.707) {
    return "back";
  }

  var_03 = vectorcross(var_01, var_00);
  if(var_03[2] > 0) {
    return "left";
  }

  return "right";
}

func_7F08() {
  var_00 = -1 * self.var_DC;
  var_01 = anglesToForward(self.angles);
  var_02 = vectordot(var_01, var_00);
  if(var_02 < -0.5) {
    return 1;
  }

  return 0;
}
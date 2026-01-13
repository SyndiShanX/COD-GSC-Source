/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2590.gsc
************************/

func_234D(var_0, var_1) {
  scripts\asm\asm::func_234E();
  if(var_1 == "hero_salter" || var_1 == "hero_boats") {
    scripts\asm\asm_bb::func_2984(1);
  }

  self.asm = spawnStruct();
  self.asm.archetype = var_1;
  self.asm.animoverrides = [];
  self.asm.var_7360 = 0;
  self.var_164D = [];
  self.asmname = var_0;
  self.var_718D = ::func_230D;
  self.var_7195 = ::func_238D;
  self.var_718E = ::func_230E;
  self.var_718F = ::func_230F;
  self.var_7194 = ::func_2382;
  self.var_7193 = ::func_235B;
  self.var_7192 = ::func_2348;
  self.var_7191 = ::asm_getallanimsforstate;
  self.var_7190 = ::asm_getallanimsforalias;
  scripts\asm\asm::func_2351(var_0, 1);
}

func_2382(var_0, var_1) {
  if(!isDefined(var_1.var_4E6D)) {
    return 0;
  }

  return !isalive(self);
}

func_12EE7(var_0) {
  if(self.var_E0 && !isDefined(self.var_55BF)) {
    var_1 = 1500;
    if(!isDefined(self.a.var_A9C8)) {
      self.a.var_A9C8 = 0;
    }

    if(!isDefined(self.damageshieldcounter) || gettime() - self.a.var_A9C8 > var_1) {
      self.damageshieldcounter = randomintrange(2, 3);
    }

    if(isDefined(self.sethalfresparticles) && distancesquared(self.origin, self.sethalfresparticles.origin) < squared(512)) {
      self.damageshieldcounter = 0;
    }

    if(self.damageshieldcounter > 0) {
      self.damageshieldcounter--;
    }
  }

  if(isDefined(var_0)) {
    self.damagedsubpart = var_0;
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
  var_0 = 4096;
  if(self.a.var_5605) {
    return 0;
  }

  if(isDefined(self.vehicle_getspawnerarray) && self pathdisttogoal() < var_0) {
    return 0;
  }

  return 1;
}

func_51B8() {
  self endon("terminate_ai_threads");
  self waittill("entitydeleted");
  foreach(var_1 in self.var_164D) {
    var_2 = var_1.var_4BC0;
    self notify(var_2 + "_finished");
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

    var_0 = 0;
    foreach(var_9, var_2 in self.var_164D) {
      var_3 = var_2.var_4BC0;
      var_4 = level.asm[var_9].states[var_3];
      if(!isDefined(var_4.var_C87F)) {
        continue;
      }

      var_5 = level.asm[var_9].states[var_4.var_C87F];
      scripts\asm\asm::func_2388(var_9, var_3, var_4, var_4.var_116FB);
      var_6 = var_4.var_C87F;
      if(isDefined(var_5.var_C94B) && var_5.var_C94B) {
        var_7 = scripts\asm\asm::func_2310(var_9, var_4.var_C87F, 1);
        var_6 = var_7[0];
        var_8 = var_7[1];
      }

      scripts\asm\asm::func_238A(var_9, var_6, 0.05, undefined, undefined, var_4.var_C87C);
      if(isDefined(self.unittype) && self.unittype == "c6") {
        self playSound("shield_death_c6_1");
      }

      var_0 = 1;
    }

    if(!var_0 && self.script == "pain") {
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
    self waittill("traverse_begin", var_0, var_1);
    if(1) {
      var_2 = self.asmname;
      var_3 = level.asm[var_2];
      if(!func_234B(self.asm.archetype, var_0)) {
        var_0 = "traverse_external";
      }

      var_4 = self.var_164D[var_2].var_4BC0;
      var_5 = var_3.states[var_4];
      if(var_4 == "traversal_orient") {
        continue;
      }

      scripts\asm\asm::func_2388(var_2, var_4, var_5, var_5.var_116FB);
      scripts\asm\asm::func_238A(var_2, var_0, 0.2, undefined, undefined, undefined);
    }
  }
}

func_111A9() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("damage_subpart", var_0);
    foreach(var_2 in var_0) {
      func_12EE7(var_2.spawnscriptitem);
      if(!func_1004C()) {
        if(isDefined(self.script) && self.script == "pain") {
          self notify("killanimscript");
        }

        continue;
      }

      var_3 = 0;
      foreach(var_0C, var_5 in self.var_164D) {
        var_6 = var_5.var_4BC0;
        var_7 = level.asm[var_0C].states[var_6];
        if(!isDefined(var_7.var_C87F)) {
          continue;
        }

        var_8 = level.asm[var_0C].states[var_7.var_C87F];
        scripts\asm\asm::func_2388(var_0C, var_6, var_7, var_7.var_116FB);
        var_9 = var_7.var_C87F;
        if(isDefined(var_8.var_C94B) && var_8.var_C94B) {
          var_0A = scripts\asm\asm::func_2310(var_0C, var_7.var_C87F, 1);
          var_9 = var_0A[0];
          var_0B = var_0A[1];
        }

        scripts\asm\asm::func_238A(var_0C, var_9, 0.05, undefined, undefined, var_7.var_C87C);
        var_3 = 1;
      }

      if(!var_3 && self.script == "pain") {
        self notify("killanimscript");
      }
    }
  }
}

func_237F(var_0) {
  switch (var_0) {
    case "face node":
      var_1 = 1024;
      if(scripts\engine\utility::actor_is3d()) {
        var_2 = self.angles;
        if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_1) {
          var_2 = scripts\asm\shared_utility::getnodeforwardangles(self.target_getindexoftarget);
        }

        self orientmode("face angle 3d", var_2);
      } else {
        var_3 = self.angles[1];
        if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_1) {
          var_3 = scripts\asm\shared_utility::getnodeforwardyaw(self.target_getindexoftarget);
        }

        self orientmode("face angle", var_3);
      }
      break;

    case "face current":
      self orientmode("face angle 3d", self.angles);
      break;

    default:
      self orientmode(var_0);
      break;
  }
}

func_237E(var_0) {
  self animmode(var_0, 0);
}

func_230E(var_0, var_1) {
  if(scripts\asm\asm::func_231B(var_0, "gesture")) {
    func_2381(var_0, var_1);
  }
}

func_238D(var_0) {
  if(isDefined(var_0.var_10B53) && var_0.var_10B53 != "") {
    if(var_0.var_10B53 != "prone" && self.a.pose != var_0.var_10B53) {
      scripts\anim\utility::exitpronewrapper(1);
    }

    self.a.pose = var_0.var_10B53;
    scripts\asm\asm_bb::bb_requestsmartobject(var_0.var_10B53);
  }
}

func_230D(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::func_231B(var_0, "aim")) {
    func_2380(var_0, var_2, var_3);
  }
}

func_2326(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;
  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  self waittill(var_5, var_6);
  if(!isDefined(var_6)) {
    var_6 = ["undefined"];
  }

  if(!isarray(var_6)) {
    var_6 = [var_6];
  }

  var_7 = undefined;
  foreach(var_9 in var_6) {
    scripts\asm\asm::asm_fireevent(var_1, var_9);
    var_0A = scripts\anim\notetracks::handlenotetrack(var_9, var_5, var_2, var_3);
    if(!isDefined(var_0A)) {
      var_0A = func_2344(var_0, var_9, var_1);
    }

    if(isDefined(var_0A)) {
      var_7 = var_0A;
    }
  }

  return var_7;
}

func_2344(var_0, var_1, var_2) {
  if(func_238B(var_1)) {
    return;
  }

  switch (var_1) {
    case "start_aim":
      var_3 = level.asm[var_0].states[var_2];
      if(isDefined(var_3.magicbullet) && scripts\engine\utility::array_contains(var_3.magicbullet, "notetrackAim")) {
        func_2380(var_0, var_2, 0.2);
      }
      break;
  }
}

func_238B(var_0) {
  if(!scripts\engine\utility::string_starts_with(var_0, "ds ")) {
    return 0;
  }

  var_1 = 3;
  self.asm.var_4E6E = spawnStruct();
  var_1 = var_1 + 1;
  var_2 = "";
  while(var_1 < var_0.size && var_0[var_1] != "]") {
    var_2 = var_2 + var_0[var_1];
    var_1 = var_1 + 1;
  }

  self.asm.var_4E6E.var_10E2C = var_2;
  var_1 = var_1 + 1;
  if(var_1 < var_0.size) {
    var_1 = var_1 + 2;
    var_3 = "";
    while(var_1 < var_0.size && var_0[var_1] != "]") {
      var_3 = var_3 + var_0[var_1];
      var_1 = var_1 + 1;
    }

    self.asm.var_4E6E.params = var_3;
  }

  return 1;
}

func_2324(var_0, var_1, var_2) {
  self endon(var_0);
  wait(var_2);
  self notify(var_1);
}

func_2323(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  var_6 = var_1 + "_endHelper";
  self endon(var_5);
  thread func_2324(var_6, var_5, var_2);
  var_7 = func_231F(var_0, var_1, var_3, var_4);
  self notify(var_6);
  return var_7;
}

func_231F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  for(;;) {
    var_6 = func_2326(var_0, var_1, var_2, var_3, var_4);
    if(isDefined(var_6)) {
      if(var_5 && !scripts\asm\asm::func_232B(var_1, "end")) {
        scripts\asm\asm::asm_fireevent(var_1, "end");
      }

      return var_6;
    }
  }
}

func_2322(var_0, var_1, var_2, var_3) {
  for(;;) {
    self waittill(var_1, var_4);
    if(!isDefined(var_4)) {
      var_4 = ["undefined"];
    }

    if(!isarray(var_4)) {
      var_4 = [var_4];
    }

    var_5 = undefined;
    foreach(var_7 in var_4) {
      var_8 = [
        [var_2]
      ](var_1, var_7, var_3);
      if(isDefined(var_8) && var_8) {
        continue;
      }

      scripts\asm\asm::asm_fireevent(var_1, var_7);
      var_9 = scripts\anim\notetracks::handlenotetrack(var_7, var_1, undefined, undefined);
      if(isDefined(var_9)) {
        var_5 = var_9;
      }
    }

    if(isDefined(var_5)) {
      return var_5;
    }
  }
}

func_2320(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + "_note_loop_end";
  self endon(var_4);
  var_5 = getanimlength(var_2);
  thread func_2321(var_4, var_1 + "_finished", var_5);
  func_231F(var_0, var_1, var_3);
  self notify(var_4);
}

func_2321(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_0);
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

func_2309(var_0) {
  return animhasnotetrack(var_0, "facial_override");
}

func_2318() {
  if(self.var_6A8B != "filler") {
    var_0 = func_2356("Knobs", "head");
    self clearanim(var_0, 0.2);
    self.facialidx = undefined;
  }
}

func_2376() {
  var_0 = self.asmname;
  var_1 = self.var_164D[var_0].var_4BC0;
  if(var_1 == "AnimScripted") {
    return;
  }

  func_2369(var_0, var_1, undefined);
}

func_2369(var_0, var_1, var_2) {
  if(var_0 != self.asmname) {
    return;
  }

  if(isDefined(level.asm[var_0].states[var_1].var_6A8B)) {
    func_236B(var_2, level.asm[var_0].states[var_1].var_6A8B, self.facialidx);
    return;
  }

  func_2318();
  self.asm.var_6A86 = "";
}

func_236B(var_0, var_1, var_2) {
  if(!scripts\asm\asm::asm_hasalias("Knobs", "head")) {
    return;
  }

  var_3 = func_2356("Knobs", "head");
  if(!scripts\sp\utility::isfacialstateallowed("asm")) {
    return;
  }

  if(isDefined(var_0) && func_2309(var_0)) {
    return;
  }

  if(!isDefined(self.asm.var_6A86)) {
    self.asm.var_6A86 = "";
  }

  scripts\sp\utility::func_F6FE("asm");
  if(self.asm.var_6A86 != var_1 || self _meth_8103(var_3) < 1) {
    self.asm.var_6A86 = var_1;
    var_4 = "facial_" + var_1;
    var_5 = scripts\asm\asm::asm_lookupanimfromalias("facial_animation", var_4);
    var_3 = func_2356("Knobs", "head");
    if(isDefined(var_5)) {
      self setanimknob(var_5, 1, 0.1, 1);
      self give_attacker_kill_rewards(var_3, 5, 0.1);
    }
  }
}

func_236A(var_0) {
  self endon("death");
  var_1 = "";
  if(isDefined(self.asm)) {
    var_1 = self.asm.archetype;
  }

  if(isDefined(self.var_1FA8)) {
    var_1 = self.var_1FA8;
  }

  if(!scripts\sp\utility::isfacialstateallowed("asm") && var_0 != "facial_death") {
    return;
  }

  if(var_1 != "") {
    scripts\sp\utility::func_F6FE("asm");
    var_2 = _func_2EF(var_1, "facial_animation", var_0, 0);
    if(var_0 == "facial_death") {
      if(isDefined(self.var_6A84)) {
        if(self.var_6A84 == var_0) {
          if(isDefined(self.var_6A83)) {
            var_2 = self.var_6A83;
          }
        }
      }
    }

    if(isDefined(var_2)) {
      self setanimknob(var_2, 1, 0.267, 1);
      self.var_6A83 = var_2;
      self.var_6A84 = var_0;
    }
  }
}

func_236C(var_0) {
  var_1 = "soldier";
  var_2 = _func_2EF(var_1, "facial_animation", "facial_death", 0);
  if(isDefined(var_2)) {
    var_0 setanimknob(var_2, 1, 0, 0);
  }
}

func_234F() {
  self endon("death");
  var_0 = 0;
  var_1 = 0;
  var_2 = func_2356("Knobs", "body");
  var_3 = 0;
  var_4 = 0;
  for(;;) {
    var_5 = self _meth_853F(var_2);
    var_6 = var_5[0] - var_0;
    var_7 = var_6 > 0.001 - var_6 < -0.001;
    if(var_7 != var_3) {
      if(var_7 > 0) {
        var_0 = var_5[0];
        var_3 = var_7;
        wait(0.1);
        func_234C("left");
        continue;
      }

      if(var_7 < 0) {
        var_0 = var_5[0];
        var_3 = var_7;
        func_2319("left");
        continue;
      }
    }

    var_0 = var_5[0];
    var_3 = var_7;
    var_8 = var_5[1] - var_1;
    var_9 = var_8 > 0.001 - var_8 < -0.001;
    if(var_9 != var_4) {
      if(var_9 > 0) {
        var_1 = var_5[1];
        var_4 = var_9;
        wait(0.1);
        func_234C("right");
        continue;
      }

      if(var_9 < 0) {
        var_1 = var_5[1];
        var_4 = var_9;
        func_2319("right");
        continue;
      }
    }

    var_1 = var_5[1];
    var_4 = var_9;
    wait(0.05);
  }
}

func_234C(var_0) {
  var_1 = scripts\anim\utility::func_7DA1();
  if(var_1 == "none") {
    func_2319(var_0);
  }

  func_236D(var_0);
}

func_236D(var_0) {
  var_1 = scripts\anim\utility::func_7DA1();
  if(var_1 == "none") {
    return;
  }

  var_2 = "ik_finger_pose_r";
  var_3 = "ik_fingers_r";
  var_4 = getweaponbasename(var_1);
  if(var_0 == "left") {
    var_2 = "ik_finger_pose_l";
    var_3 = "ik_fingers_l";
    var_5 = getweaponattachments(var_1);
    if(isDefined(var_5)) {
      if(scripts\engine\utility::array_contains(var_5, "foregrip")) {
        var_4 = "foregrip";
      }
    }
  }

  if(!func_234B(self.asm.archetype, var_2)) {
    return;
  }

  if(!isDefined(var_4) || !scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    if(!isDefined(var_4)) {
      var_4 = "UNDEFINED";
    }

    return;
  }

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
  var_7 = func_2356("Knobs", var_3);
  self give_attacker_kill_rewards(var_7, 10, 0.3, 1);
  self give_attacker_kill_rewards(var_6, 1, 0.3, 1);
}

func_2319(var_0) {
  var_1 = "ik_fingers_l";
  if(var_0 == "right") {
    var_1 = "ik_fingers_r";
  }

  if(!scripts\asm\asm::asm_hasalias("Knobs", var_1)) {
    return;
  }

  var_2 = func_2356("Knobs", var_1);
  self clearanim(var_2, 0.3, 1);
}

func_2355() {
  var_0 = scripts\anim\utility::func_7DA1();
  var_1 = getweaponbasename(var_0);
  var_2 = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];
  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_2, var_1)) {
    return 1;
  }

  return 0;
}

func_236E() {
  func_231A();
  var_0 = scripts\asm\asm::asm_lookupanimfromalias("Visor", "helmet_visor_up");
  if(self.asm.var_DC48 == 1) {
    self give_attacker_kill_rewards(var_0, 1, 0, 1);
    return;
  }

  var_1 = scripts\asm\asm::asm_lookupanimfromalias("Visor", "helmet_visor_down");
  self give_attacker_kill_rewards(var_1, 1, 0, 1);
  wait(getanimlength(var_1) - 0.1);
  func_231A();
}

func_231A() {
  var_0 = func_2356("Knobs", "visor");
  self clearanim(var_0, 0);
}

asm_getaimlimitset(var_0, var_1, var_2) {
  return archetypegetaliases(var_0, var_1);
}

func_235E(var_0, var_1, var_2, var_3) {
  var_4 = asm_getaimlimitset(var_0, var_1);
  var_5 = 0;
  var_6 = undefined;
  var_7 = -1;
  if(isDefined(var_2)) {
    var_7 = var_2.size;
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  foreach(var_0A in var_4) {
    if(var_7 < 0 || getsubstr(var_0A, 0, var_7) == var_2) {
      var_5 = var_5 + 1;
      var_0B = 1 / var_5;
      if(randomfloat(1) <= var_0B) {
        var_6 = var_0A;
      }
    }
  }

  return var_6;
}

func_235D(var_0, var_1, var_2) {
  return func_235E(self.asm.archetype, var_0, var_1, var_2);
}

func_2357(var_0, var_1, var_2) {
  var_3 = undefined;
  if(isDefined(self.var_1FA8)) {
    var_3 = archetypegetalias(var_0, var_1, var_2, 0);
  } else {
    var_3 = archetypegetalias(var_0, var_1, var_2, scripts\asm\asm::asm_getdemeanor());
  }

  if(isDefined(var_3)) {
    return var_3.var_47;
  }

  return undefined;
}

func_2356(var_0, var_1) {
  if(isDefined(self.var_1FA8)) {
    var_2 = func_2357(self.var_1FA8, var_0, var_1);
  } else {
    var_2 = func_2357(self.asm.archetype, var_1, var_2);
  }

  return var_2;
}

func_2305(var_0, var_1, var_2) {
  var_3 = archetypegetalias(var_0, var_1, var_2, scripts\asm\asm::asm_getdemeanor());
  if(isDefined(var_3)) {
    return 1;
  }

  return 0;
}

func_2359(var_0, var_1, var_2) {
  return _func_2EF(var_0, var_1, var_2, scripts\asm\asm::asm_getdemeanor());
}

func_235B(var_0, var_1) {
  var_2 = func_2359(self.asm.archetype, var_0, var_1);
  return var_2;
}

func_234B(var_0, var_1) {
  if(archetypeassetloaded(var_0)) {
    return _func_2F1(var_0, var_1);
  }

  return 0;
}

func_2348(var_0, var_1) {
  var_2 = func_2357(self.asm.archetype, var_0, var_1);
  return isDefined(var_2);
}

asm_getallanimsforalias(var_0, var_1, var_2) {
  var_3 = archetypegetalias(var_0, var_1, var_2, 1);
  if(!isDefined(var_3)) {
    return undefined;
  }

  var_4 = var_3.var_47;
  if(!isarray(var_4)) {
    var_4 = [var_4];
  }

  var_5 = archetypegetalias(var_0, var_1, var_2, 0);
  var_6 = var_5.var_47;
  if(!isarray(var_6)) {
    var_6 = [var_6];
  }

  foreach(var_8 in var_6) {
    if(!scripts\engine\utility::array_contains(var_4, var_8)) {
      var_4[var_4.size] = var_8;
    }
  }

  return var_4;
}

asm_getallanimsforstate(var_0, var_1) {
  var_2 = level.asm[var_0].states[var_1].var_71A5;
  var_3 = level.asm[var_0].states[var_1].var_7DC8;
  var_4 = self[[var_2]](var_0, var_1, var_3);
  return var_4;
}

func_2342() {
  return func_2356("Knobs", "root");
}

asm_getbodyknob() {
  return func_2356("Knobs", "body");
}

func_235F(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = asm_getbodyknob();
  self clearanim(var_5, var_2);
  if(isDefined(var_4) && var_4) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_6 = func_2356("Knobs", "move");
      self _meth_84F2(var_6);
    }
  }

  var_7 = undefined;
  var_8 = scripts\asm\asm::func_2341(var_0, var_1);
  var_9 = 0.2;
  var_0A = isDefined(var_4) && var_4;
  for(;;) {
    var_0B = asm_getallanimsforstate(var_0, var_1);
    if(isDefined(var_4) && var_4) {
      var_3 = scripts\asm\asm::asm_getmoveplaybackrate();
      self _meth_84F1(var_3);
    }

    if(isDefined(var_7) && var_7 != var_0B) {
      self clearanim(var_7, var_2);
    }

    if(self _meth_8103(var_0B) > 0) {
      self _meth_82E1(var_1, var_0B, 1, var_2, var_3);
    } else {
      self _meth_82EA(var_1, var_0B, 1, var_2, var_3);
    }

    func_2369(var_0, var_1, var_0B);
    var_0C = getanimlength(var_0B);
    if(var_0C <= 0.05) {
      return;
    }

    var_0D = undefined;
    var_0E = var_3;
    while(!isDefined(var_0D)) {
      var_0D = func_2323(var_0, var_1, var_9, var_8);
      if(!isDefined(var_0D) && var_0A) {
        var_3 = scripts\asm\asm::asm_getmoveplaybackrate();
        if(var_3 != var_0E) {
          self _meth_84F1(var_3);
          self _meth_82B1(var_0B, var_3);
        }
      }
    }

    var_7 = var_0B;
  }
}

func_2368(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = asm_getallanimsforstate(var_0, var_1);
  self clearanim(asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_5, 1, var_2, 1);
  func_2369(var_0, var_1, var_5);
  var_6 = func_2322(var_0, var_1, var_3, var_4);
  if(var_6 == "end") {
    if(!scripts\asm\asm::func_232B(var_1, "end")) {
      scripts\asm\asm::asm_fireevent(var_1, "end");
    }

    thread scripts\asm\asm::func_2310(var_0, var_1, 0);
  }
}

func_2366(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = asm_getallanimsforstate(var_0, var_1);
  self clearanim(asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_3, 1, var_2, 1);
  func_2369(var_0, var_1, var_3);
  var_4 = func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_2364(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = asm_getallanimsforstate(var_0, var_1);
  self clearanim(asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_3, 1, var_2, 1);
  func_2369(var_0, var_1, var_3);
  var_4 = func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  if(var_4 == "code_move") {
    var_4 = func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  }

  if(var_4 == "end") {
    thread scripts\asm\asm::func_2310(var_0, var_1, 0);
  }
}

func_2363(var_0, var_1, var_2, var_3) {
  var_4 = asm_getallanimsforstate(var_0, var_1);
  var_5 = isDefined(var_3) && var_3 == "limited";
  if(var_5) {
    self _meth_82E6(var_1, var_4, 1, var_2, 1);
  } else {
    self _meth_82E7(var_1, var_4, 1, var_2, 1);
  }

  func_2369(var_0, var_1, var_4);
  func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
}

func_2361(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = asm_getbodyknob();
  var_5 = isDefined(var_3) && var_3 == "limited";
  for(;;) {
    var_6 = asm_getallanimsforstate(var_0, var_1);
    if(var_4 != var_6) {
      if(var_5) {
        self _meth_82E6(var_1, var_6, 1, var_2, 1);
      } else {
        self _meth_82E7(var_1, var_6, 1, var_2, 1);
      }

      var_4 = var_6;
    }

    thread func_2362(var_1, var_6, var_5);
    func_2369(var_0, var_1, var_6);
    func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
    self notify(var_1 + "additive_cancel");
  }
}

func_2362(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  self endon(var_0 + "additive_cancel");
  while(isDefined(var_1)) {
    wait(0.2);
    if(var_2) {
      self _meth_82E8(var_0, var_1, 1, 0, 1);
      continue;
    }

    self _meth_82E1(var_0, var_1, 1, 0, 1);
  }
}

func_2377(var_0) {
  if(isDefined(var_0["left"])) {
    self.setmatchdatadef = var_0["left"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.setmatchdatadef = 56;
  } else {
    self.setmatchdatadef = 45;
  }

  if(isDefined(var_0["right"])) {
    self.setdevdvar = var_0["right"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.setdevdvar = -56;
  } else {
    self.setdevdvar = -45;
  }

  if(isDefined(var_0["up"])) {
    self.var_368 = var_0["up"];
  } else if(scripts\engine\utility::actor_is3d()) {
    self.var_368 = -65;
  } else {
    self.var_368 = -45;
  }

  if(isDefined(var_0["down"])) {
    self.isbot = var_0["down"];
    return;
  }

  if(scripts\engine\utility::actor_is3d()) {
    self.isbot = 65;
    return;
  }

  self.isbot = 45;
}

asm_generichandler(var_0, var_1) {
  if(!isDefined(level.var_1A43[var_0])) {
    return "default";
  }

  if(!isDefined(level.var_1A43[var_0][var_1])) {
    return "default";
  }

  return level.var_1A43[var_0][var_1];
}

func_237D(var_0, var_1) {
  if(isDefined(self.var_9322) && self.var_9322) {
    return;
  }

  var_2 = asm_generichandler(var_0, var_1);
  if(!isDefined(level.var_43FE[var_0])) {
    func_2377([]);
    return;
  }

  var_3 = scripts\asm\asm::asm_getdemeanor();
  if(var_3 && isDefined(level.var_7361[var_0][var_2])) {
    func_2377(level.var_7361[var_0][var_2]);
    return;
  } else if(isDefined(level.var_43FE[var_0][var_2])) {
    func_2377(level.var_43FE[var_0][var_2]);
    return;
  }

  func_2377([]);
}

func_2380(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::weaponclass(self.var_394);
  if(var_5 == "none") {
    return;
  }

  if(scripts\asm\asm::asm_hasalias(var_1, "aim_1")) {
    return;
  }

  if(!scripts\asm\asm::asm_hasalias(var_1, var_5 + "_aim_8")) {
    var_5 = "rifle";
  }

  func_237D(var_0, var_1);
  var_6 = var_5 + "_aim_5";
  var_7 = undefined;
  if((!isDefined(var_3) || var_3) && scripts\asm\asm::asm_hasalias(var_1, var_6)) {
    var_7 = func_235B(var_1, var_5 + "_aim_5");
  }

  self _meth_82A9(func_235B(var_1, var_5 + "_aim_8"), 1, var_2);
  self _meth_82A9(func_235B(var_1, var_5 + "_aim_2"), 1, var_2);
  self _meth_82A9(func_235B(var_1, var_5 + "_aim_4"), 1, var_2);
  self _meth_82A9(func_235B(var_1, var_5 + "_aim_6"), 1, var_2);
  if(isDefined(var_7)) {
    self _meth_82AC(var_7, 1, var_2);
  }

  if(scripts\asm\asm::asm_hasalias(var_1, "aim_root")) {
    self give_attacker_kill_rewards(func_235B(var_1, "aim_root"), 1, var_2);
  } else if(scripts\asm\asm::asm_hasalias("Knobs", "aim_root")) {
    self give_attacker_kill_rewards(func_235B("Knobs", "aim_root"), 1, var_2);
  }

  var_8 = func_2348(var_1, "aim_knob_2");
  if(var_8) {
    self notify("StopCleanupAimKnobs");
    self.asm.var_11A90.var_1A1D = func_235B(var_1, "aim_knob_2");
    self.asm.var_11A90.var_1A1F = func_235B(var_1, "aim_knob_4");
    self.asm.var_11A90.var_1A22 = func_235B(var_1, "aim_knob_6");
    self.asm.var_11A90.var_1A24 = func_235B(var_1, "aim_knob_8");
    if(isDefined(var_7)) {
      self.asm.var_11A90.var_1A21 = func_235B(var_1, "aim_knob_5");
    }

    thread func_2312(var_1);
  }

  lib_0A2B::func_11AFD();
}

func_2381(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_getdemeanor();
  self.asm.var_77C1.var_77A6 = func_235B("gesture", "gesture_move_up");
  self.asm.var_77C1.var_778C = func_235B("gesture", "gesture_armup");
  self.asm.var_77C1.var_77A8 = func_235B("gesture", "gesture_on_me");
  self.asm.var_77C1.var_77A0 = func_235B("gesture", "gesture_hold");
  self.asm.var_77C1.var_7795 = func_235B("gesture", "gesture_fallback_up");
  self.asm.var_77C1.var_7794 = func_235B("gesture", "gesture_fallback_down");
  if(var_2 == "casual") {
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

  if(var_2 == "casual_gun") {
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

func_2313(var_0, var_1) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  scripts\engine\utility::waittill_any_timeout_1(var_1, var_0 + "_finished");
  func_2311();
}

func_2312(var_0) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  self waittill(var_0 + "_finished");
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

func_238E(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 0;
  while(!var_3) {
    self waittill(var_1, var_4);
    if(!isarray(var_4)) {
      var_4 = [var_4];
    }

    foreach(var_6 in var_4) {
      if(var_6 == "start_aim") {
        func_2380(var_0, var_1, var_2);
        var_3 = 1;
        break;
      }
    }
  }
}

func_230A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self.asmname;
  var_8 = self.var_164D[var_7].var_4BC0;
  var_9 = level.asm[var_7].states[var_8];
  scripts\asm\asm::func_2388(var_7, var_8, var_9, var_9.var_116FB);
  scripts\asm\asm::func_238A(var_7, "AnimScripted", 0.2);
}

func_2386() {
  self givescorefortrophyblocks();
}

func_2307(var_0, var_1) {
  if(getdvarint("ai_iw7", 0) == 0) {
    if(!isDefined(var_1)) {
      self animcustom(var_0);
    } else {
      self animcustom(var_0, var_1);
    }

    return;
  }

  scripts\asm\asm_bb::bb_setanimscripted();
  self.asm.var_1FAC = var_1;
  self animcustom(var_0, ::func_2308);
  var_2 = self.asmname;
  var_3 = self.var_164D[var_2].var_4BC0;
  var_4 = level.asm[var_2].states[var_3];
  scripts\asm\asm::func_2388(var_2, var_3, var_4, var_4.var_116FB);
  scripts\asm\asm::func_238A(var_2, "AnimScripted", 0.2);
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

func_230F(var_0) {
  if(isDefined(var_0.var_C704)) {
    func_237F(var_0.var_C704);
  }

  if(isDefined(var_0.var_1FBA)) {
    func_237E(var_0.var_1FBA);
  }
}

func_9F70(var_0, var_1, var_2, var_3) {
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

func_9F4C(var_0, var_1, var_2, var_3) {
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

func_9DB5(var_0, var_1, var_2, var_3) {
  var_4 = self.var_E1;
  if(isDefined(self.var_C873)) {
    var_4 = self.var_C873;
  }

  if(scripts\sp\utility::func_9DB4("iw7_sonic") && self.var_DE != "MOD_MELEE" && var_4 >= 75) {
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

  var_0 = getweaponbasename(self.var_E2);
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.team) && isDefined(self.team) && self.sethalfresparticles.team == self.team) {
    return 0;
  }

  return var_0 == "iw7_atomizer";
}

func_7E5A() {
  var_0 = -1 * self.var_DC;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);
  if(var_2 > 0.707) {
    return "front";
  }

  if(var_2 < -0.707) {
    return "back";
  }

  var_3 = vectorcross(var_1, var_0);
  if(var_3[2] > 0) {
    return "left";
  }

  return "right";
}

func_7F08() {
  var_0 = -1 * self.var_DC;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);
  if(var_2 < -0.5) {
    return 1;
  }

  return 0;
}
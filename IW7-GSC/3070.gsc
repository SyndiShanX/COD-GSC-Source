/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3070.gsc
*********************************************/

func_97F9(var_0) {
  self.var_719D = ::func_EF29;
  self.var_71A1 = ::func_EF2B;
  lib_0A15::setupdestructibledoors();
  if(!isDefined(level.var_5667["c6"])) {
    level.var_5667["c6"] = [];
  }

  self.var_10264 = 1;
  return level.success;
}

func_EF29(var_0) {
  var_1 = 1;
  switch (var_0.updategamerprofileall) {
    case "head":
      break;

    case "right_leg":
    case "left_leg":
      var_1 = 1;
      break;
  }

  lib_0A0B::func_98C9(var_0.updategamerprofileall);
  if(self._blackboard.scriptableparts[var_0.updategamerprofileall].state == "dismember") {
    return;
  }

  if(var_1) {
    var_2 = "dmg_" + var_0.spawnscriptitem;
    lib_0A0B::func_F592(var_0.updategamerprofileall, var_2);
  }

  switch (var_0.updategamerprofileall) {
    case "torso":
      func_11A13();
      break;
  }
}

func_EF2B(var_0) {
  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    return;
  }

  var_1 = 1;
  switch (var_0.updategamerprofileall) {
    case "head":
      func_5666();
      lib_0A0B::func_98C9(var_0.updategamerprofileall);
      lib_0A0B::func_F592(var_0.updategamerprofileall, "dismember");
      break;

    case "right_arm":
      if(lib_0A0B::func_2040()) {
        var_1 = 0;
      } else if(isDefined(self getspectatepoint())) {
        var_1 = 0;
      }

      func_5675();
      break;

    case "left_arm":
      if(lib_0A0B::func_2040()) {
        var_1 = 0;
      } else if(isDefined(self getspectatepoint())) {
        var_1 = 0;
      }

      func_5668();
      break;

    case "right_leg":
    case "left_leg":
      if(isDefined(self.disablecoverarrivalsonly)) {
        return;
      } else if(isDefined(self getspectatepoint())) {
        var_1 = 0;
      }

      if(lib_0A0B::func_2040()) {
        var_1 = 0;
      }

      func_566B();
      break;

    case "torso":
      break;

    default:
      break;
  }

  func_EF2C(var_0.updategamerprofileall, var_1);
}

func_EF2C(var_0, var_1) {
  lib_0A0B::func_98C9(var_0);
  if(lib_0A0B::func_7C35(var_0) == "dismember") {
    return;
  }

  if(isDefined(self.bt.var_55CF)) {
    return;
  }

  lib_0A0B::func_F6C9(var_0);
  thread lib_0A0B::func_F592(var_0, "dismember", 0.05);
  if(isDefined(self.var_2023) && self.var_2023 != "get_up" && self.var_2023 != "fall") {
    return;
  }

  if(isDefined(self.bt.var_55CE)) {
    return;
  }

  if(var_1) {
    scripts\asm\asm::asm_setstate("dismember");
  }
}

func_566D() {
  self.var_87F6 = 0;
  self func_8504(0);
  self.var_BC = "no_cover";
  self.objective_state_nomessage = 0;
}

func_5666() {
  if(isDefined(self.bt.var_55CE)) {
    return;
  }

  func_566D();
  self.bt.cannotmelee = 1;
  scripts\asm\asm_bb::bb_setheadless(1);
  func_3EDD();
}

func_5668() {
  if(!isDefined(self.var_B5DB) || lib_0A0B::func_E52D()) {
    self.bt.cannotmelee = 1;
  }

  self.var_C08B = 1;
  if(lib_0A0B::func_E52D() && !isDefined(self.bt.var_5661)) {
    self.bt.var_5661 = 2;
  }

  func_11A13();
}

func_5675() {
  if(isDefined(self.bt.var_55CE)) {
    return;
  }

  func_566D();
  if(!isDefined(self.var_B5DB) || lib_0A0B::func_AB53()) {
    self.bt.cannotmelee = 1;
  }

  var_0 = self.weapon != "none";
  if(isDefined(self.var_C05C)) {
    self.iscinematicplaying = 0;
    self.var_C05C = undefined;
  }

  scripts\anim\shared::func_5D19();
  if(isDefined(self.var_E282)) {
    self.var_C05C = 1;
    self.var_E282 = undefined;
  }

  if(lib_0A0B::func_2040()) {
    self.bt.var_5661 = 0;
    return;
  }

  if(func_D3E4()) {
    self setscriptablepartstate("torso_overload_fx", "overload");
    func_E1B1(3000);
    self.bt.var_5661 = 0;
    return;
  }

  if(var_0 || lib_0A0B::func_AB53()) {
    scripts\asm\asm_bb::bb_setselfdestruct(1);
    self.bt.var_5661 = 2;
    return;
  }
}

func_566B() {
  if(isDefined(self.bt.var_55CE)) {
    return;
  }

  func_566D();
  if(lib_0A0B::func_2040()) {
    return;
  }

  if(isDefined(self.bt.var_5661)) {
    switch (self.bt.var_5661) {
      case 2:
      case 1:
      case 0:
        break;
    }
  }

  if(isDefined(self.var_2A8F)) {
    self.bt.var_5661 = 2;
    self func_8321();
    return;
  }

  var_0 = 0;
  var_1 = 1;
  var_2 = [];
  if(lib_0BFD::func_9DA0(0)) {
    var_2[var_2.size] = var_0;
  }

  var_3 = scripts\asm\asm_bb::bb_getcovernode();
  if(isDefined(var_3) && distancesquared(var_3.origin, self.origin) < 144 && isDefined(self.enemy)) {
    var_4 = self.enemy.origin - self.origin;
    var_5 = anglesToForward(var_3.angles);
    if(vectordot(var_5, var_4) < 0.5) {
      var_2[var_2.size] = var_1;
    }
  } else {
    var_2[var_2.size] = var_1;
  }

  if(var_2.size == 0) {
    var_2[0] = var_1;
  }

  var_6 = var_2[randomint(var_2.size)] == var_0;
  if(var_6) {
    self func_8321();
    scripts\anim\shared::func_5D19();
    scripts\asm\asm_bb::func_2977(1);
    self.bt.var_5661 = 6;
    return;
  }

  self.bt.var_FEDB = "full";
  self.bt.var_FED8 = 1;
  self.bt.var_5661 = 5;
}

func_11A13() {
  if(isDefined(self.bt.var_11A14)) {
    return;
  }

  if(isDefined(self.bt.var_5615)) {
    return;
  }

  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }

  if(randomint(100) > level.var_33BB) {
    return;
  }

  if(distancesquared(self.origin, level.player.origin) < 65536) {
    return;
  }

  var_0 = ["right_arm", "left_arm", "right_leg", "left_leg", "head"];
  foreach(var_2 in var_0) {
    if(!isDefined(self._blackboard.scriptableparts[var_2])) {
      continue;
    }

    if(self._blackboard.scriptableparts[var_2].state == "dismember") {
      return;
    }
  }

  self.bt.var_11A14 = 1;
  var_4 = ["right_arm", "right_leg", "left_leg"];
  var_5 = [3, 1, 1];
  var_6 = func_7D77(var_5);
  var_2 = var_4[var_6];
  self func_847D(var_2);
}

func_8BE3(var_0) {
  if(!isDefined(self.bt.var_5661)) {
    return level.failure;
  }

  return level.success;
}

func_D3E4() {
  var_0 = squared(196);
  if(distancesquared(self.origin, level.player.origin) <= var_0) {
    return 1;
  }

  return 0;
}

func_E1B1(var_0) {
  if(isDefined(self.bt.var_3126)) {
    return;
  }

  self.bt.var_3126 = 1;
  self.bt.var_F1FE = var_0;
}

func_41DA() {
  if(isDefined(self.bt.var_3126)) {
    self.bt.var_3127 = 1;
  }

  self.bt.var_3126 = undefined;
  self.bt.var_F1FE = undefined;
}

func_10072(var_0) {
  if(isDefined(self.bt.var_3126)) {
    return level.success;
  }

  return level.failure;
}

func_F1FC(var_0) {
  var_1 = gettime();
  if(self.bt.var_F1FE > 0) {
    thread func_F1F5(self.bt.var_F1FE * 0.001);
  } else {
    if(isDefined(self.bt.var_F1F7)) {
      self.bt.var_F1F7 stoploopsound();
    }

    if(self.unittype == "c8") {
      self playSound("c8_destruct_preexplode");
    } else {
      self playSound("c6_destruct_preexplode");
    }

    self.bt.var_F1FE = 500;
  }

  self.bt.instancedata[var_0] = var_1 + self.bt.var_F1FE;
}

func_F1FB(var_0) {
  var_1 = gettime();
  if(isDefined(self.bt.var_3127)) {
    self.bt.var_3127 = undefined;
    return level.failure;
  }

  if(isDefined(self.melee) && isDefined(self.melee.var_29B4)) {
    return level.running;
  }

  if(var_1 < self.bt.instancedata[var_0]) {
    return level.running;
  }

  return level.success;
}

func_5AA5(var_0) {
  self func_8481(self.origin);
  self.var_6D = 64;
  self.bt.var_3125 = 1;
  anim thread[[self.bt.var_71CC]](self);
}

func_5AA4(var_0) {
  return level.running;
}

func_9F3F(var_0) {
  if(isDefined(self.bt.var_3125)) {
    return level.running;
  }

  return level.failure;
}

func_9F42(var_0) {
  if(self.bt.var_5661 == 0) {
    return level.success;
  }

  return level.failure;
}

func_F20C(var_0) {
  func_E1B1(0);
}

func_F20B(var_0) {
  return level.running;
}

func_E1B2(var_0) {
  if(isDefined(self.bt.var_3128)) {
    return;
  }

  self.bt.var_3128 = 1;
  self.bt.var_F210 = var_0;
}

func_41DB() {
  self.bt.var_3128 = undefined;
  self.bt.var_F210 = undefined;
}

func_10074(var_0) {
  if(isDefined(self.bt.var_3128)) {
    return level.success;
  }

  return level.failure;
}

func_F20F(var_0) {
  var_1 = gettime();
  self.bt.instancedata[var_0] = var_1 + self.bt.var_F210;
}

func_F20E(var_0) {
  var_1 = gettime();
  if(isDefined(self.melee) && isDefined(self.melee.var_29B4)) {
    self.bt.var_3128 = undefined;
    return level.failure;
  }

  if(var_1 < self.bt.instancedata[var_0]) {
    return level.running;
  }

  return level.success;
}

func_5AA6(var_0) {
  self func_81D0();
  return level.running;
}

func_9F40(var_0) {
  if(self.bt.var_5661 == 1) {
    return level.success;
  }

  return level.failure;
}

func_F201(var_0) {
  var_1 = gettime();
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].var_BFB5 = var_1;
  self.bt.instancedata[var_0].var_BFA1 = var_1 + 1000;
  self.noturnanims = 1;
  self.precacheleaderboards = 1;
  func_E1B1(randomintrange(4000, 7000));
}

func_9FF2(var_0, var_1) {
  if(self == var_0) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(isDefined(var_0.a) && isDefined(var_0.a.var_58DA)) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > var_1) {
    return 0;
  }

  if(var_0.ignoreme) {
    return 0;
  }

  return 1;
}

func_F202(var_0) {
  var_1 = gettime();
  if(var_1 >= self.bt.instancedata[var_0].var_BFB5) {
    var_2 = 1000000;
    var_3 = 100;
    self.bt.instancedata[var_0].var_BFA1 = var_1 + 500;
    self.bt.instancedata[var_0].var_BFB5 = var_1 + randomintrange(1000, 4000);
    var_4 = undefined;
    var_5 = getaiarray(self.team);
    if(var_5.size > 0) {
      var_5 = sortbydistance(var_5, self.origin);
      var_6 = [];
      foreach(var_8 in var_5) {
        if(func_9FF2(var_8, var_2)) {
          var_6[var_6.size] = var_8;
        }
      }

      if(var_6.size > 0) {
        var_10 = var_6[randomint(var_6.size)];
        var_11 = vectornormalize(self.origin - var_10.origin);
        var_4 = var_10.origin + var_11 * var_3;
        var_4 = getclosestpointonnavmesh(var_4, self);
      }
    }

    if(!isDefined(var_4)) {
      var_4 = getrandomnavpoint(self.origin, 1000);
    }

    self getplayerforguid();
    self.var_6D = var_3;
    self func_8481(var_4);
  } else if(var_1 >= self.bt.instancedata[var_0].var_BFA1) {
    if(self.badpath || !isDefined(self.vehicle_getspawnerarray)) {
      func_E1B1(1000);
    }
  }

  return level.running;
}

func_F6C7() {
  self.bt.var_5661 = 2;
}

func_9F41(var_0) {
  if(self.bt.var_5661 == 2) {
    return level.success;
  }

  return level.failure;
}

func_F207(var_0) {
  var_1 = gettime();
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].var_BFB5 = var_1;
  self.bt.instancedata[var_0].var_BFA1 = var_1 + 1000;
  self.noturnanims = 1;
  self.precacheleaderboards = 1;
  self setscriptablepartstate("torso_overload_fx", "overload");
}

func_F209(var_0) {
  var_1 = gettime();
  if(var_1 >= self.bt.instancedata[var_0].var_BFB5) {
    var_2 = undefined;
    if(isalive(self.enemy)) {
      var_2 = self.enemy;
    } else {
      if(self.team == "axis") {
        var_3 = "allies";
      } else {
        var_3 = "axis";
      }

      var_4 = getaiarray(var_3);
      if(var_3 == "allies") {
        var_4[var_4.size] = level.player;
      }

      var_5 = [];
      foreach(var_7 in var_4) {
        if(func_9FF2(var_7, 4194304)) {
          var_5[var_5.size] = var_7;
        }
      }

      if(var_5.size > 0) {
        var_5 = sortbydistance(var_5, self.origin);
        var_2 = var_5[0];
      }
    }

    if(isDefined(var_2)) {
      self.bt.instancedata[var_0].var_BFA1 = var_1 + 1000;
      self.bt.instancedata[var_0].var_BFB5 = var_1 + 3000;
      self.objective_playermask_showto = 80;
      self.bt.var_F1EE = var_2;
      self func_8482(var_2);
    }
  } else if(var_1 >= self.bt.instancedata[var_0].var_BFA1) {
    if(self.badpath || !isDefined(self.vehicle_getspawnerarray)) {
      func_E1B1(1000);
    }
  }

  return level.running;
}

func_F206(var_0) {
  if(isDefined(self.bt.var_F1EE)) {
    return level.success;
  }

  return level.failure;
}

func_F205(var_0) {
  var_1 = 1;
  var_2 = 180;
  if(lib_0A0B::func_2040()) {
    var_2 = 145;
  }

  var_3 = distance(self.origin, self.bt.var_F1EE.origin);
  var_4 = var_3 / var_2 + var_1;
  thread func_F1F5(var_4);
  var_5 = gettime();
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].var_10D7A = var_5 + 500;
  self.bt.instancedata[var_0].var_11064 = var_5 + 500 + var_4 * 1000;
}

func_F203(var_0) {
  var_1 = gettime();
  if(var_1 < self.bt.instancedata[var_0].var_10D7A) {
    return level.running;
  }

  if(var_1 >= self.bt.instancedata[var_0].var_11064) {
    return level.success;
  }

  if(!isalive(self.bt.var_F1EE)) {
    return level.success;
  }

  var_2 = 9216;
  if(isDefined(self.seekselfdestructradiussq)) {
    var_2 = self.seekselfdestructradiussq;
  }

  if(distancesquared(self.origin, self.bt.var_F1EE.origin) <= var_2) {
    return level.success;
  }

  return level.running;
}

func_F204(var_0) {
  self.bt.instancedata[var_0] = undefined;
  if(isDefined(self.bt.var_F1F7)) {
    self.bt.var_F1F7 stoploopsound();
  }
}

func_F208(var_0) {
  self func_8481(self.origin);
  self.var_6D = 24;
  self.bt.var_5661 = 0;
  return level.success;
}

func_9E21(var_0) {
  if(self.bt.var_5661 == 3 || self.bt.var_5661 == 4) {
    return level.success;
  }

  return level.failure;
}

func_8C53(var_0) {
  func_E1B1(randomintrange(5000, 10000));
  self.bt.instancedata[var_0] = gettime();
  self func_82B1(lib_0A1E::func_2342(), 1.5);
  self.objective_playermask_showto = 1000;
  self.team = "team3";
  self.precacheleaderboards = 0;
  self func_8481(self.origin);
  self.var_6D = 500;
  self.ignoreme = 1;
  self.var_2894 = 2;
  thread func_8C93();
}

func_8C54(var_0) {
  var_1 = gettime();
  if(var_1 >= self.bt.instancedata[var_0]) {
    self func_80EC();
    self.bt.instancedata[var_0] = var_1 + randomintrange(2000, 3000);
  }

  return level.running;
}

func_9FB8(var_0) {
  if(self.bt.var_5661 == 5) {
    return level.success;
  }

  return level.failure;
}

func_9D9F(var_0) {
  if(self.bt.var_5661 == 6) {
    return level.success;
  }

  return level.failure;
}

isnondismemberedmeleevsplayer(var_0) {
  if(!isDefined(self.melee)) {
    return level.failure;
  }

  if(!isDefined(self.melee.target)) {
    return level.failure;
  }

  if(!isPlayer(self.melee.target)) {
    return level.failure;
  }

  if(isDefined(self.bt.var_5661) && self.bt.var_5661 == 6) {
    return level.failure;
  }

  return level.success;
}

func_12F13(var_0) {
  var_1 = gettime();
  if(isDefined(self.bt.var_F1F9) && var_1 < self.bt.var_F1F9) {
    return level.running;
  }

  if(isDefined(self.bt.var_F1F8) && self.bt.var_F1F8 == 2) {
    return level.running;
  }

  if(isalive(self.enemy)) {
    var_2 = self.enemy;
  } else {
    if(self.team == "axis") {
      var_3 = "allies";
    } else {
      var_3 = "axis";
    }

    var_4 = getaiarray(var_3);
    if(var_3 == "allies") {
      var_4[var_4.size] = level.player;
    }

    var_5 = [];
    foreach(var_7 in var_4) {
      if(!isalive(var_7)) {
        continue;
      }

      if(isDefined(var_7.a) && isDefined(var_7.a.var_58DA)) {
        continue;
      }

      if(var_7.ignoreme) {
        continue;
      }

      var_5[var_5.size] = var_7;
    }

    var_5 = sortbydistance(var_5, self.origin);
    var_2 = var_5[0];
  }

  if(isDefined(var_2)) {
    self.bt.var_F1F9 = var_1 + 3000;
    self.objective_playermask_showto = 80;
    self.bt.var_F1EE = var_2;
    self func_8482(var_2);
    thread func_F1F8();
  }

  return level.running;
}

func_F1F8() {
  self endon("death");
  if(isDefined(self.bt.var_F1F8)) {
    return;
  }

  self setscriptablepartstate("torso_overload_fx", "overload");
  self.bt.var_F1F8 = 1;
  if(isDefined(self.bt.var_F1EE)) {
    var_0 = 1;
    var_1 = 180;
    var_2 = distance(self.origin, self.bt.var_F1EE.origin);
    var_3 = var_2 / var_1 + var_0;
    thread func_F1F5(var_3);
    wait(0.5);
    var_4 = squared(96);
    var_5 = gettime() + var_3 * 1000;
    for(;;) {
      wait(0.05);
      if(!isalive(self.bt.var_F1EE)) {
        break;
      }

      if(distancesquared(self.origin, self.bt.var_F1EE.origin) <= var_4) {
        break;
      }

      if(gettime() >= var_5) {
        break;
      }
    }
  }

  if(isDefined(self.bt.var_F1F7)) {
    self.bt.var_F1F7 stoploopsound();
  }

  if(self.unittype == "c8") {
    self playSound("c8_destruct_preexplode", "pre_explode_sound");
  } else {
    self playSound("c6_destruct_preexplode", "pre_explode_sound");
  }

  self.var_6D = 16;
  self func_8481(self.origin);
  scripts\asm\asm_bb::func_2972();
  wait(0.5);
  anim thread[[self.bt.var_71CC]](self);
}

func_F1F5(var_0) {
  if(isDefined(self.bt.var_F1F7)) {
    return;
  }

  if(isDefined(self.bt.var_4889)) {
    self stoploopsound();
  }

  self.bt.var_F1F7 = spawn("script_origin", self.origin + (0, 0, 30));
  self.bt.var_F1F7 linkto(self);
  self.bt.var_F1F7 thread func_F1F6(self, var_0);
}

func_F1F6(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  var_2 = "c6";
  if(var_0.unittype == "c8") {
    var_2 = "c8";
  }

  self playSound(var_2 + "_destruct_initiate");
  var_3 = gettime() + 1000;
  while(gettime() < var_3) {
    if(!isalive(var_0)) {
      self delete();
      return;
    }

    wait(0.05);
  }

  if(var_0 scripts\asm\asm_bb::bb_iscrawlmelee()) {
    self playLoopSound(var_2 + "_destruct_crawl_loop");
  } else if(var_0.unittype == "c6" && var_0 scripts\asm\asm_bb::func_293E() || isDefined(var_0.bt.var_12A74)) {
    self playLoopSound(var_2 + "_destruct_crawl_loop");
  } else {
    self playLoopSound(var_2 + "_destruct_run_loop");
  }

  var_1 = max(var_1, 5);
  self func_8277(2, var_1 - 1);
  if(isalive(var_0)) {
    var_0 waittill("death");
  }

  self delete();
}

func_F1F1(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.bt.var_F1F4)) {
    return;
  }

  var_4 = var_0.origin;
  var_0.bt.var_F1F4 = 1;
  var_0 scripts\anim\shared::func_5D1A();
  if(!isDefined(self.var_C05C)) {
    wait(0.1);
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 250;
  }

  if(!isDefined(var_2)) {
    var_2 = 170;
  }

  if(!isDefined(var_3)) {
    var_3 = 20;
  }

  if(isDefined(var_0.bt.var_F200)) {
    var_2 = var_2 * var_0.bt.var_F200;
    var_3 = var_3 * var_0.bt.var_F200;
  }

  if(!isDefined(var_0.asm.var_2F3B)) {
    foreach(var_9, var_6 in var_0.var_4D5D) {
      if(var_9 == "head") {
        var_7 = "destruct";
      } else {
        var_8 = var_0 lib_0A0B::func_7C35(var_9);
        if(var_8 == "dismember") {
          continue;
        }

        if(issubstr(var_8, "_both")) {
          var_8 = "dmg_both";
        }

        var_7 = "destruct_" + var_8;
      }

      var_0 setscriptablepartstate(var_9, var_7);
    }
  }

  radiusdamage(var_4 + (0, 0, 32), var_1, var_2, var_3, var_0);
  physicsexplosionsphere(var_4, 400, 50, 1);
  earthquake(2, 0.3, var_4, 400);
  if(isDefined(var_0.var_4E46)) {
    var_0[[var_0.var_4E46]]();
  }

  var_0 thread func_F1ED();
  var_10 = spawn("script_origin", var_4);
  var_10 playSound("c6_destruct", "sounddone");
  var_10 playSound("generic_explodeath_c6_1");
  var_10 waittill("sounddone");
  var_10 delete();
}

func_F1ED() {
  if(!isDefined(self)) {
    return;
  }

  wait(0.05);
  self delete();
}

func_12A76(var_0) {
  if(isDefined(self.bt.var_F1F4)) {
    return level.success;
  }

  thread func_5671();
  if(!isDefined(self.bt.var_12A74)) {
    self.bt.var_12A74 = 1;
  }

  if(isDefined(self.bt.var_3126)) {
    var_1 = 1;
  } else if(isDefined(self.bt.var_3128)) {
    var_1 = 0;
  } else {
    var_1 = randomint(100) > 75;
  }

  if(var_1) {
    func_E1B1(randomintrange(3000, 7000));
  } else {
    func_E1B2(randomintrange(10000, 15000));
  }

  return level.success;
}

func_12A75(var_0) {
  if(!isDefined(self.enemy)) {
    return level.failure;
  }

  var_1 = distance2dsquared(self.origin, self.enemy.origin);
  if(var_1 > 1296) {
    return level.failure;
  }

  func_41DA();
  func_E1B1(randomintrange(2000, 3000));
  self.bt.var_5661 = 0;
  return level.success;
}

func_F20D(var_0, var_1) {
  var_2 = gettime();
  if(!isDefined(self.bt.var_F20D)) {
    var_3 = randomintrange(var_0, var_1);
    self.bt.var_F20D = var_2 + var_3;
  } else if(var_2 >= self.bt.var_F20D) {
    self func_81D0();
    return 1;
  }

  return 0;
}

func_5671() {
  self endon("death");
  if(isDefined(self.bt.var_5672)) {
    return;
  }

  self.bt.var_5672 = 1;
  wait(randomfloatrange(1, 3));
  var_0 = "right_leg";
  if(lib_0A0B::func_7C35(var_0) == "dismember") {
    var_0 = "left_leg";
    if(lib_0A0B::func_7C35(var_0) == "dismember") {
      return;
    }
  }

  self func_847D(var_0);
}

func_9E7B(var_0) {
  if(lib_0A0B::func_2040()) {
    return level.success;
  }

  return level.failure;
}

func_9EA3(var_0) {
  if(lib_0A0B::func_2EE1()) {
    return level.success;
  }

  return level.failure;
}

func_3EDD() {
  if(isDefined(self.bt.var_5661)) {
    switch (self.bt.var_5661) {
      case 2:
      case 1:
      case 0:
        break;
    }
  }

  if(!isDefined(self.bt.var_8C94)) {
    if(isDefined(self.var_DE) && self.var_DE == "MOD_MELEE") {
      self.bt.var_8C94 = "selfdestruct";
      self.bt.var_5661 = 0;
    } else {
      var_0[0] = "selfdestruct";
      var_1[0] = 1;
      var_0[1] = "selfdestruct_running";
      var_1[1] = 3;
      if(!lib_0A0B::func_E52D()) {
        var_0[2] = "shootrandomly";
        var_1[2] = 3;
      }

      if(isDefined(level.var_A998)) {
        foreach(var_4, var_3 in var_0) {
          if(var_3 == level.var_A998) {
            var_1[var_4] = var_1[var_4] - randomfloatrange(1, 5);
            var_1[var_4] = max(var_1[var_4], 0.2);
            break;
          }
        }
      }

      var_5 = func_7D77(var_1);
      self.bt.var_8C94 = var_0[var_5];
      switch (var_5) {
        case 0:
          self.bt.var_5661 = 0;
          break;

        case 1:
          self.bt.var_5661 = 1;
          break;

        case 2:
          self.bt.var_5661 = 4;
          break;
      }
    }

    anim.var_A998 = self.bt.var_8C94;
    scripts\asm\asm_bb::func_297B("haywire");
    if(self.bt.var_8C94 == "selfdestruct_running") {
      scripts\asm\asm_bb::func_297B("haywire_walk");
    }
  }
}

func_7D77(var_0) {
  var_1 = var_0.size;
  if(var_1 == 1) {
    return var_0[0];
  }

  var_2 = randomint(var_1);
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_4 = var_4 + var_0[var_6];
  }

  var_7 = randomfloat(var_4);
  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_5 = var_5 + var_0[var_6];
    if(var_7 >= var_5) {
      continue;
    }

    var_2 = var_6;
    break;
  }

  return var_2;
}

func_F1F9(var_0, var_1) {
  if(isDefined(self.bt.var_F1F4)) {
    return 1;
  }

  var_2 = gettime();
  if(!isDefined(self.bt.var_F1F9)) {
    var_3 = randomintrange(var_0, var_1);
    self.bt.var_F1F9 = var_2 + var_3;
    thread func_F1F5(var_3 * 0.001);
  } else if(var_2 >= self.bt.var_F1F9) {
    self.var_6D = 64;
    self func_8481(self.origin);
    anim thread[[self.bt.var_71CC]](self);
    return 1;
  }

  return 0;
}

func_8C93() {
  self.var_33F = 500;
  self give_zombies_perk("team3");
  self.objective_playermask_showto = 500;
  setthreatbias("allies", "team3", -2000);
  setthreatbias("axis", "team3", 1000);
  self endon("death");
  wait(2);
  self.ignoreme = 0;
}

func_DCAA(var_0, var_1) {
  if(!isDefined(self.bt.var_DCAB)) {
    self.bt.var_DCAB = gettime() + randomintrange(var_0, var_1);
    return;
  }

  if(gettime() < self.bt.var_DCAB) {
    return;
  }

  self.bt.var_DCAB = gettime() + randomintrange(var_0, var_1);
  var_2 = ["left_arm", "right_arm", "left_leg", "right_leg", "torso"];
  var_3 = var_2[randomint(var_2.size)];
  var_4 = ["upper", "lower"];
  var_5 = var_4[randomint(var_4.size)];
  self func_850B(30, var_3, var_5);
}

func_4D64(var_0, var_1) {
  self endon("death");
  if(!isDefined(var_0)) {
    var_0 = 0.2;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  var_2 = ["left_arm", "right_arm", "left_leg", "right_leg", "torso"];
  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 = randomintrange(3, 5);
  var_4 = 0;
  while(var_4 < var_2.size - 1) {
    var_5 = lib_0A0B::func_7C35(var_2[var_4]);
    var_4++;
    if(var_5 == "dismember") {
      continue;
    }

    var_6 = undefined;
    if(var_5 == "normal") {
      if(scripts\engine\utility::cointoss()) {
        var_6 = "upper";
      } else {
        var_6 = "lower";
      }
    } else if(var_5 == "dmg_lower") {
      var_6 = "upper";
    } else if(var_5 == "dmg_upper") {
      var_6 = "upper";
    }

    wait(randomfloatrange(var_0, var_1));
    if(isDefined(var_6)) {
      self func_850B(50, var_2[var_4], var_6);
    }
  }
}
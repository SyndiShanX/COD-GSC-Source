/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3069.gsc
*********************************************/

func_488D() {
  self.meleerangesq = 9216;
  self.meleechargedist = 1000;
  self.meleechargedistvsplayer = 1000;
  self.var_B627 = 36;
  self.meleeactorboundsradius = 32;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = ::func_9DA2;
}

func_9DA0(var_0) {
  if(isDefined(self.dontmelee)) {
    return 0;
  }

  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(isDefined(self.enemy.dontmelee)) {
    return 0;
  }

  if(isDefined(self._stealth) && !scripts\aitypes\melee::canmeleeduringstealth()) {
    return 0;
  }

  if(isDefined(var_0) && var_0) {
    return 1;
  }

  if(scripts\aitypes\melee::func_9DD1()) {
    return 0;
  }

  return 1;
}

func_9D9F(var_0) {
  if(!scripts\asm\asm_bb::bb_iscrawlmelee()) {
    return level.failure;
  }

  return level.success;
}

func_487C(var_0) {
  if(randomint(100) < 25) {
    lib_0BFE::func_E1B1(randomintrange(3000, 8000));
  } else {
    lib_0BFE::func_E1B2(randomintrange(3000, 8000));
  }

  thread lib_0BFE::func_5671();
  func_488D();
  return level.success;
}

func_487B() {
  lib_0BFE::func_41DA();
  lib_0BFE::func_41DB();
  lib_0BFE::func_F6C7();
}

func_FFDD(var_0) {
  if(!func_9DA0(0)) {
    func_487B();
    return level.failure;
  }

  if(![[self.fnismeleevalid]](self.enemy, 0)) {
    func_487B();
    return level.failure;
  }

  return level.success;
}

func_4881(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].var_3E30 = gettime() + 100;
  self.bt.instancedata[var_0].timeout = gettime() + 4000;
  self.bt.instancedata[var_0].var_6572 = self.enemy.origin;
  self.melee.var_2AC7 = 1;
  self.melee.var_2AC6 = 1;
  self.var_B651 = 1;
  if(scripts\asm\asm_bb::bb_isselfdestruct() && isDefined(self.bt.var_F1F7)) {
    self.bt.var_F1F7 stoploopsound();
    self.bt.var_F1F7 playLoopSound("c6_mvmt_crawl_loop_vocal");
    return;
  }

  self playLoopSound("c6_mvmt_crawl_loop_vocal");
}

func_487A(var_0) {
  self.melee.var_29B4 = 1;
  return level.success;
}

func_488C(var_0) {
  if(lib_0A0B::func_2EE1()) {
    if(!isDefined(self.bt.var_487E)) {
      self.bt.var_487E = 1;
      self.var_6D = 16;
      self func_8481(self.origin);
      thread lib_0BFE::func_F1F8();
    }

    return level.running;
  }

  return level.success;
}

func_9DA2(var_0, var_1) {
  if(scripts\aitypes\melee::ismeleevalid_common(var_0, var_1) == 0) {
    return 0;
  }

  if(var_1) {
    if(scripts\anim\utility_common::isusingsidearm()) {
      return 0;
    }
  }

  if(isDefined(self.objective_position) && self.objective_additionalcurrent == 1) {
    return 0;
  }

  if(isDefined(var_0.var_5951) || isDefined(var_0.ignoreme) && var_0.ignoreme) {
    return 0;
  }

  if(!isai(var_0) && !isPlayer(var_0)) {
    return 0;
  }

  if(isDefined(self.var_B5DD) && isDefined(var_0.var_B5DD)) {
    return 0;
  }

  if((isDefined(self.var_B5DD) && isDefined(var_0.var_B14F)) || isDefined(var_0.var_B5DD) && isDefined(self.var_B14F)) {
    return 0;
  }

  if(isai(var_0)) {
    if(var_0 func_81A6()) {
      return 0;
    }

    if(var_0 scripts\sp\utility::func_58DA() || var_0.var_EB) {
      return 0;
    }

    if(self.getcsplinepointtargetname != "none" || var_0.getcsplinepointtargetname != "none") {
      return 0;
    }

    if(var_0.unittype != "soldier" && var_0.unittype != "c6" && var_0.unittype != "c6i") {
      return 0;
    }
  }

  if(isPlayer(var_0)) {
    var_2 = var_0 getstance();
  } else {
    var_2 = var_1.a.pose;
  }

  if(var_2 != "stand" && var_2 != "crouch") {
    return 0;
  }

  if(isDefined(self.var_B14F) && isDefined(var_0.var_B14F)) {
    return 0;
  }

  if(isDefined(var_0.objective_position)) {
    return 0;
  }

  return 1;
}
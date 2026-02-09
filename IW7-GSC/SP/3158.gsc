/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3158.gsc
*********************************************/

func_98CC(var_0, var_1, var_2, var_3) {
  self._blackboard.shootstate = scripts\asm\asm::asm_getcurrentstate(self.asmname);
}

func_FFC9(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::func_291C()) {
    return 0;
  }

  return scripts\asm\asm::func_232B(var_1, "burst_delay_finished");
}

func_8981(var_0) {
  self endon(var_0 + "_finished");
  func_32BE();
  scripts\asm\asm::asm_fireevent(var_0, "burst_delay_finished");
}

func_FE76(var_0, var_1, var_2, var_3) {
  thread func_8981(var_1);
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  lib_0A1E::func_2361(var_0, var_1, var_2, var_3);
}

func_10002(var_0, var_1, var_2, var_3) {
  if(!func_10081(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  return 0;
}

func_10081(var_0, var_1, var_2, var_3) {
  if(!scripts\anim\utility_common::isasniper()) {
    return 0;
  }

  if(lib_0A2B::func_9F60()) {
    return 0;
  }

  return 1;
}

func_10080(var_0, var_1, var_2, var_3) {
  if(!scripts\anim\utility_common::isasniper()) {
    return func_FFC9(var_0, var_1, var_2, var_3);
  }

  if(lib_0A2B::func_9F60()) {
    return 0;
  }

  if(!func_FFC9(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  return 1;
}

func_FE75(var_0, var_1, var_2, var_3) {
  thread func_8981(var_1);
  if(scripts\anim\utility_common::isasniper()) {
    return;
  }

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  lib_0A1E::func_2361(var_0, var_1, var_2, var_3);
}

func_FE58(var_0, var_1, var_2, var_3) {
  thread func_8981(var_1);
}

func_FECE(var_0, var_1, var_2, var_3) {
  var_4 = self.asm.shootparams;
  var_5 = self._blackboard.shootparams;
  if(!isDefined(var_5)) {
    return 1;
  }

  if(scripts\anim\utility_common::isasniper()) {
    return 0;
  }

  if(func_3DFB(var_4.ent, var_5.ent) || !isDefined(var_4.ent) && func_3DFB(var_4.pos, var_5.pos) || func_3DFB(var_4.var_1119D, var_5.var_1119D)) {
    return 1;
  }

  return 0;
}

func_FEDC(var_0, var_1, var_2, var_3) {
  if(isDefined(self.asm.shootparams)) {
    return self.asm.shootparams.var_FF0B == 1;
  }

  return self._blackboard.shootparams.var_FF0B == 1;
}

func_FED9(var_0, var_1, var_2, var_3) {
  if(self._blackboard.shootparams.var_1119D == "full" || self._blackboard.shootparams.var_1119D == "burst") {
    return 1;
  }

  return 0;
}

func_C185(var_0, var_1, var_2, var_3) {
  return !func_10078(var_0, var_1, var_2, var_3);
}

func_10078(var_0, var_1, var_2, var_3) {
  return scripts\anim\utility_common::usingmg() || isDefined(self getturret());
}

func_FEDA(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_1119D == "mg";
}

func_3DFB(var_0, var_1) {
  if(isDefined(var_0) != isDefined(var_1)) {
    return 1;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_0 != var_1;
}

func_5AAC(var_0) {
  var_1 = self getturret();
  var_1 func_8398();
  var_1 endon("death");
  var_1 endon("turretstatechange");
  var_2 = self.asm.shootparams.var_FF0B;
  while(var_2 > 0) {
    var_1 shootturret();
    var_2--;
    self.a.var_A9ED = gettime();
    wait(var_0);
  }

  var_1 givesentry();
}

func_5AAB(var_0, var_1, var_2, var_3) {
  var_4 = self.asm.shootparams.var_FF0B;
  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  var_6 = getanimlength(var_5);
  var_6 = var_6 / var_3;
  self func_83CE();
  while(var_4 > 0) {
    var_4--;
    scripts\anim\utility_common::shootenemywrapper(0);
    self func_82E7(var_1, var_5, 1, var_2, var_6);
    scripts\anim\combat_utility::decrementbulletsinclip();
    wait(var_3);
  }

  self shootstopsound();
}

func_FE70(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_FE89();
  var_4 = func_FE64();
  if(isDefined(self getturret())) {
    func_5AAC(var_4);
  } else {
    func_5AAB(var_0, var_1, var_2, var_4);
  }

  self.asm.shootparams.var_C21C--;
  scripts\asm\asm::asm_fireevent("shoot", "shoot_finished");
  scripts\asm\asm::asm_fireevent(var_1, "shoot_finished");
}

func_FE71(var_0, var_1, var_2) {
  self shootstopsound();
}

func_FE61(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  if(!isDefined(self.asm.shootparams)) {
    func_FE89();
  }

  if(scripts\anim\utility_common::isasniper(1)) {
    lib_0A2B::func_C599();
  }

  var_4 = func_FE64();
  self func_83CE();
  var_5 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self func_82E7(var_1, var_5, 1, var_2, var_4);
  func_FE5C(var_0, var_1, var_5, 2);
  self.asm.shootparams.var_C21C--;
  if(!func_FEDC()) {
    func_FE82(0.05);
  }

  scripts\asm\asm::asm_fireevent("shoot", "shoot_finished");
  scripts\asm\asm::asm_fireevent(var_1, "shoot_finished");
  if(scripts\anim\utility_common::isasniper(1)) {
    lib_0A2B::func_C59A();
  }
}

func_FE7D(var_0) {
  var_1 = var_0 + "_shotgun_sound";
  var_2 = var_0 + "kill_shotgun_sound";
  thread func_FE84(var_1, var_2, 2);
  self endon(var_1);
  self waittillmatch("rechamber", var_0);
  self playSound("ai_shotgun_pump");
  self notify(var_2);
}

func_FE82(var_0) {
  self endon("terminate_ai_threads");
  wait(var_0);
  self shootstopsound();
}

func_FE5C(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + "_timeout";
  var_5 = var_1 + "_timeout_end";
  childthread func_FE84(var_4, var_5, var_3);
  self endon(var_4);
  var_6 = animhasnotetrack(var_2, "fire");
  var_7 = weaponclass(self.weapon) == "rocketlauncher";
  if(var_6) {
    var_8 = getnotetracktimes(var_2, "fire");
    if(var_8.size == 1 && var_8[0] == 0) {
      var_6 = 0;
    }
  }

  var_9 = 0;
  var_10 = self.asm.shootparams.var_FF0B;
  var_11 = var_10 == 1 || self.asm.shootparams.var_1119D == "semi";
  var_12 = isPlayer(self.enemy) && self.enemy scripts\sp\utility::func_65DB("player_is_invulnerable");
  var_13 = scripts\anim\utility_common::weapon_pump_action_shotgun();
  while(var_9 < var_10 && var_10 > 0) {
    if(var_6) {
      self waittillmatch("fire", var_1);
    }

    if(!self.bulletsinclip) {
      break;
    }

    shootatshootentorpos(var_11);
    if(var_12) {
      if(randomint(3) == 0) {
        self.bulletsinclip--;
      }
    } else {
      self.bulletsinclip--;
    }

    if(var_7) {
      self.a.rockets--;
    }

    var_9++;
    if(var_13) {
      childthread func_FE7D(var_1);
    }

    if(self.asm.shootparams.var_6B92 && var_9 == var_10) {
      break;
    }

    if(!var_6 || var_10 == 1 && self.asm.shootparams.var_1119D == "single") {
      self waittillmatch("end", var_1);
    }
  }

  self notify(var_5);
}

shootatshootentorpos(var_0) {
  if(isDefined(self.asm.shootparams.ent)) {
    if(isDefined(self.enemy) && self.asm.shootparams.ent == self.enemy) {
      self[[level.shootenemywrapper_func]](var_0);
      return;
    }

    return;
  }

  self[[level.var_FED3]](self.asm.shootparams.pos, var_0);
}

func_FE84(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

func_FE64() {
  var_0 = self.asm.shootparams.var_1119D;
  var_1 = 1;
  if(isDefined(self.var_FED4)) {
    var_1 = self.var_FED4;
  } else if(var_0 == "mg") {
    var_1 = 0.1;
  } else if(var_0 == "full") {
    var_1 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1);
  } else if(var_0 == "burst") {
    var_1 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var_1 = 3;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var_1 = scripts\anim\combat_utility::func_FEFE();
  }

  return var_1;
}

func_FE89(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.shootparams;
  if(!isDefined(self.asm.shootparams)) {
    self.asm.shootparams = spawnStruct();
    self.asm.shootparams.var_C21C = var_4.var_32BD;
  }

  self.asm.shootparams.var_1119D = var_4.var_1119D;
  self.asm.shootparams.var_6B92 = var_4.var_6B92;
  self.asm.shootparams.var_FF0B = var_4.var_FF0B;
  self.asm.shootparams.pos = var_4.pos;
  self.asm.shootparams.ent = var_4.ent;
  switch (var_4.var_1119D) {
    case "semi":
    case "burst":
      self.asm.shootparams.var_FF0B = scripts\aitypes\combat::func_4F65(var_4);
      break;

    case "full":
      self.asm.shootparams.var_FF0B = scripts\aitypes\combat::func_4F66();
      break;

    case "mg":
      self.asm.shootparams.var_FF0B = scripts\aitypes\combat::func_4F68();
      break;
  }

  return 1;
}

func_32BE() {
  if(isDefined(self.asm.shootparams) && self.asm.shootparams.var_1119D == "full" && !self.asm.shootparams.var_6B92) {
    if(self.a.var_A9ED == gettime()) {
      wait(0.05);
    }

    return;
  }

  var_0 = func_80E7();
  if(var_0) {
    wait(var_0);
  }
}

func_80E7() {
  var_0 = gettime() - self.a.var_A9ED / 1000;
  var_1 = func_7E12();
  if(var_1 > var_0) {
    return var_1 - var_0;
  }

  return 0;
}

func_7E13() {
  var_0 = isDefined(self.turret);
  if(var_0 && isDefined(self.turret.script_delay_min)) {
    var_1 = self.turret.script_delay_min;
  } else {
    var_1 = 0.2;
  }

  if(var_0 && isDefined(self.turret.script_delay_max)) {
    var_2 = self.turret.script_delay_max - var_1;
  } else {
    var_2 = 0.5;
  }

  return var_1 + randomfloat(var_2);
}

func_7E12() {
  if(scripts\sp\mgturret::func_130FD() || weaponclass(self.weapon) == "mg") {
    return func_7E13();
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.15, 0.55);
  }

  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(1, 1.7);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return scripts\anim\combat_utility::getjointype();
  }

  if(isDefined(self.asm.shootparams)) {
    if(self.asm.shootparams.var_6B92) {
      if(isDefined(self.asm.shootparams.ent)) {
        return randomfloatrange(0.2, 0.4);
      } else {
        return randomfloatrange(0.6, 1);
      }
    }

    if(isDefined(self.asm.shootparams.ent)) {
      return randomfloatrange(0.4, 0.9);
    } else {
      return randomfloatrange(0.8, 1.2);
    }
  }

  return randomfloatrange(0.8, 1.2);
}
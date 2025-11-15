/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3902.gsc
************************/

func_98CC(param_00, param_01, param_02, param_03) {
  self.var_1198.shootstate = scripts\asm\asm::asm_getcurrentstate(self.asmname);
}

func_FE75(param_00, param_01, param_02, param_03) {
  scripts\asm\asm_mp::func_2361(param_00, param_01, param_02, param_03);
}

func_FE61(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  func_FE89();
  var_04 = func_FE64();
  self _meth_83CE();
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  shootblankorrpg(param_01, 0.2, 2);
  self.asm.shootparams.var_C21C--;
  func_32BE();
  scripts\asm\asm::asm_fireevent(param_01, "shoot_finished");
}

func_FE7D(param_00) {
  var_01 = param_00 + "_shotgun_sound";
  var_02 = param_00 + "kill_shotgun_sound";
  thread func_FE84(var_01, var_02, 2);
  self endon(var_01);
  self waittillmatch("rechamber", param_00);
  self playSound("ai_shotgun_pump");
  self notify(var_02);
}

shootblankorrpg(param_00, param_01, param_02) {
  var_03 = param_00 + "_timeout";
  var_04 = param_00 + "_timeout_end";
  thread func_FE84(var_03, var_04, param_02);
  self endon(var_03);
  self endon(param_00 + "_finished");
  var_05 = 0;
  var_06 = self.asm.shootparams.var_FF0B;
  var_07 = var_06 == 1;
  var_08 = 0;
  var_09 = scripts\anim\utility_common::weapon_pump_action_shotgun();
  while(var_05 < var_06 && var_06 > 0) {
    if(!isDefined(self.var_1198.shootparams)) {
      break;
    }

    if(isDefined(self.isnodeoccupied)) {
      if(!lib_0F3C::isfacingenemy() && !lib_0F3C::func_9FFF()) {
        break;
      }
    }

    scripts\anim\utility_common::shootenemywrapper(var_07);
    if(self.bulletsinclip > 0) {
      if(var_08) {
        if(randomint(3) == 0) {
          self.bulletsinclip--;
        }
      } else {
        self.bulletsinclip--;
      }
    }

    var_05++;
    if(var_09) {
      childthread func_FE7D(param_00);
    }

    if(self.asm.shootparams.var_6B92 && var_05 == var_06) {
      break;
    }

    wait(param_01);
  }

  self notify(var_04);
}

func_FE5C(param_00, param_01, param_02, param_03) {
  var_04 = param_01 + "_timeout";
  var_05 = param_01 + "_timeout_end";
  thread func_FE84(var_04, var_05, param_03);
  self endon(var_04);
  var_06 = self getsafecircleorigin(param_01, param_02);
  var_07 = animhasnotetrack(var_06, "fire");
  var_08 = weaponclass(self.var_394) == "rocketlauncher";
  var_09 = 0;
  var_0A = self.asm.shootparams.var_FF0B;
  var_0B = var_0A == 1;
  var_0C = 0;
  var_0D = scripts\anim\utility_common::weapon_pump_action_shotgun();
  while(var_09 < var_0A && var_0A > 0) {
    if(var_07) {
      self waittillmatch("fire", param_01);
    }

    if(!self.bulletsinclip) {
      break;
    }

    scripts\anim\utility_common::shootenemywrapper(var_0B);
    if(var_0C) {
      if(randomint(3) == 0) {
        self.bulletsinclip--;
      }
    } else {
      self.bulletsinclip--;
    }

    if(var_08) {
      if(issubstr(tolower(self.var_394), "rpg") || issubstr(tolower(self.var_394), "panzerfaust")) {
        self hidepart("tag_rocket");
      }
    }

    var_09++;
    if(var_0D) {
      childthread func_FE7D(param_01);
    }

    if(self.asm.shootparams.var_6B92 && var_09 == var_0A) {
      break;
    }

    if(!var_07 || var_0A == 1 && self.asm.shootparams.var_1119D == "single") {
      self waittillmatch("end", param_01);
    }
  }

  self notify(var_05);
}

func_FE84(param_00, param_01, param_02) {
  self endon(param_01);
  wait(param_02);
  self notify(param_00);
}

func_FEFE() {
  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return 1;
  }

  if(scripts\anim\weaponlist::usingautomaticweapon()) {
    return scripts\anim\weaponlist::autoshootanimrate() * 0.7;
  }

  return 0.4;
}

func_FE64() {
  var_00 = self.asm.shootparams.var_1119D;
  var_01 = 1;
  if(isDefined(self.var_FED4)) {
    var_01 = self.var_FED4;
  } else if(var_00 == "full") {
    var_01 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1);
  } else if(var_00 == "burst") {
    var_01 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var_01 = 3;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var_01 = func_FEFE();
  }

  return var_01;
}

func_FE89() {
  var_00 = self.var_1198.shootparams;
  if(!isDefined(self.asm.shootparams)) {
    self.asm.shootparams = spawnStruct();
    self.asm.shootparams.var_C21C = var_00.var_32BD;
  }

  self.asm.shootparams.var_1119D = var_00.var_1119D;
  self.asm.shootparams.var_6B92 = var_00.var_6B92;
  self.asm.shootparams.var_FF0B = var_00.var_FF0B;
  self.asm.shootparams.pos = var_00.pos;
  self.asm.shootparams.ent = var_00.ent;
}

func_32BE() {
  if(self.asm.shootparams.var_1119D == "full" && !self.asm.shootparams.var_6B92) {
    if(self.var_A9ED == gettime()) {
      wait(0.05);
    }

    return;
  }

  var_00 = _meth_80E7();
  if(var_00) {
    wait(var_00);
  }
}

_meth_80E7() {
  var_00 = gettime() - self.var_A9ED / 1000;
  var_01 = func_7E12();
  if(var_01 > var_00) {
    return var_01 - var_00;
  }

  return 0;
}

getjointype() {
  if(isplayer(self.isnodeoccupied)) {
    return randomfloatrange(self.isnodeoccupied.gs.var_B750, self.isnodeoccupied.gs.var_B461);
  }

  return randomfloatrange(level.var_B750, level.var_B461);
}

func_7E12() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.15, 0.55);
  }

  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(1, 1.7);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return getjointype();
  }

  if(self.asm.shootparams.var_6B92) {
    return randomfloatrange(0.1, 0.35);
  }

  return randomfloatrange(0.4, 0.9);
}
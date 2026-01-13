/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3902.gsc
***********************************************/

func_98CC(var_0, var_1, var_2, var_3) {
  self._blackboard.shootstate = scripts\asm\asm::asm_getcurrentstate(self.asmname);
}

func_FE75(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::func_2361(var_0, var_1, var_2, var_3);
}

func_FE61(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  func_FE89();
  var_4 = func_FE64();
  self _meth_83CE();
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  shootblankorrpg(var_1, 0.2, 2);
  self.asm.shootparams.var_C21C--;
  func_32BE();
  scripts\asm\asm::asm_fireevent(var_1, "shoot_finished");
}

func_FE7D(var_0) {
  var_1 = var_0 + "_shotgun_sound";
  var_2 = var_0 + "kill_shotgun_sound";
  thread func_FE84(var_1, var_2, 2);
  self endon(var_1);
  self waittillmatch(var_0, "rechamber");
  self playSound("ai_shotgun_pump");
  self notify(var_2);
}

shootblankorrpg(var_0, var_1, var_2) {
  var_3 = var_0 + "_timeout";
  var_4 = var_0 + "_timeout_end";
  thread func_FE84(var_3, var_4, var_2);
  self endon(var_3);
  self endon(var_0 + "_finished");
  var_5 = 0;
  var_6 = self.asm.shootparams.var_FF0B;
  var_7 = var_6 == 1;
  var_8 = 0;
  var_9 = scripts\anim\utility_common::weapon_pump_action_shotgun();

  while(var_5 < var_6 && var_6 > 0) {
    if(!isDefined(self._blackboard.shootparams)) {
      break;
    }

    if(isDefined(self.enemy)) {
      if(!lib_0F3C::isfacingenemy() && !lib_0F3C::func_9FFF()) {
        break;
      }
    }

    scripts\anim\utility_common::shootenemywrapper(var_7);

    if(self.bulletsinclip > 0) {
      if(var_8) {
        if(randomint(3) == 0) {
          self.bulletsinclip--;
        }
      } else
        self.bulletsinclip--;
    }

    var_5++;

    if(var_9) {
      childthread func_FE7D(var_0);
    }

    if(self.asm.shootparams.var_6B92 && var_5 == var_6) {
      break;
    }

    wait(var_1);
  }

  self notify(var_4);
}

func_FE5C(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + "_timeout";
  var_5 = var_1 + "_timeout_end";
  thread func_FE84(var_4, var_5, var_3);
  self endon(var_4);
  var_6 = self getanimentry(var_1, var_2);
  var_7 = animhasnotetrack(var_6, "fire");
  var_8 = weaponclass(self.weapon) == "rocketlauncher";
  var_9 = 0;
  var_10 = self.asm.shootparams.var_FF0B;
  var_11 = var_10 == 1;
  var_12 = 0;
  var_13 = scripts\anim\utility_common::weapon_pump_action_shotgun();

  while(var_9 < var_10 && var_10 > 0) {
    if(var_7) {
      self waittillmatch(var_1, "fire");
    }

    if(!self.bulletsinclip) {
      break;
    }

    scripts\anim\utility_common::shootenemywrapper(var_11);

    if(var_12) {
      if(randomint(3) == 0) {
        self.bulletsinclip--;
      }
    } else
      self.bulletsinclip--;

    if(var_8) {
      if(issubstr(tolower(self.weapon), "rpg") || issubstr(tolower(self.weapon), "panzerfaust")) {
        self hidepart("tag_rocket");
      }
    }

    var_9++;

    if(var_13) {
      childthread func_FE7D(var_1);
    }

    if(self.asm.shootparams.var_6B92 && var_9 == var_10) {
      break;
    }

    if(!var_7 || var_10 == 1 && self.asm.shootparams.var_1119D == "single") {
      self waittillmatch(var_1, "end");
    }
  }

  self notify(var_5);
}

func_FE84(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

func_FEFE() {
  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return 1.0;
  }

  if(scripts\anim\weaponlist::usingautomaticweapon()) {
    return scripts\anim\weaponlist::autoshootanimrate() * 0.7;
  }

  return 0.4;
}

func_FE64() {
  var_0 = self.asm.shootparams.var_1119D;
  var_1 = 1.0;

  if(isDefined(self.var_FED4)) {
    var_1 = self.var_FED4;
  } else if(var_0 == "full") {
    var_1 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1.0);
  } else if(var_0 == "burst") {
    var_1 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var_1 = 3.0;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var_1 = func_FEFE();
  }

  return var_1;
}

func_FE89() {
  var_0 = self._blackboard.shootparams;

  if(!isDefined(self.asm.shootparams)) {
    self.asm.shootparams = spawnStruct();
    self.asm.shootparams.var_C21C = var_0.var_32BD;
  }

  self.asm.shootparams.var_1119D = var_0.var_1119D;
  self.asm.shootparams.var_6B92 = var_0.var_6B92;
  self.asm.shootparams.var_FF0B = var_0.var_FF0B;
  self.asm.shootparams.pos = var_0.pos;
  self.asm.shootparams.ent = var_0.ent;
}

func_32BE() {
  if(self.asm.shootparams.var_1119D == "full" && !self.asm.shootparams.var_6B92) {
    if(self.var_A9ED == gettime()) {
      wait 0.05;
    }

    return;
  }

  var_0 = _meth_80E7();

  if(var_0) {
    wait(var_0);
  }
}

_meth_80E7() {
  var_0 = (gettime() - self.var_A9ED) / 1000;
  var_1 = func_7E12();

  if(var_1 > var_0) {
    return var_1 - var_0;
  }

  return 0;
}

getjointype() {
  if(isplayer(self.enemy)) {
    return randomfloatrange(self.enemy.gs.var_B750, self.enemy.gs.var_B461);
  } else {
    return randomfloatrange(anim.var_B750, anim.var_B461);
  }
}

func_7E12() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.15, 0.55);
  } else if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(1.0, 1.7);
  } else if(scripts\anim\utility_common::isasniper()) {
    return getjointype();
  } else if(self.asm.shootparams.var_6B92) {
    return randomfloatrange(0.1, 0.35);
  } else {
    return randomfloatrange(0.4, 0.9);
  }
}
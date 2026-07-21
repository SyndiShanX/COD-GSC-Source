/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\shoot\script_funcs.gsc
***********************************************/

initshoot(var_0, var_1, var_2) {
  self._blackboard.shootstate = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  self._blackboard.shoot_firstshot = 1;

  if(weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" && !isDefined(self.covernode))
    self._blackboard.shoot_firstshot = 0;
}

shouldbeginfiring(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_firerequested())
    return 0;

  var_4 = istrue(self._blackboard.shoot_firstshot) || scripts\asm\asm::asm_eventfired(var_0, "_encstr_BAC91580A3480B7BF9E09054271868D663F6188BA0AFC9");
  return var_4;
}

handleburstdelay(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");

  if(!istrue(self.ignoreburstdelay))
    burstdelay();

  scripts\asm\asm::asm_fireevent(var_0, "_encstr_BAC91580A3480B7BF9E09054271868D663F6188BA0AFC9");
}

chooseshootidle(var_0, var_1, var_2) {
  var_3 = self aigetdesiredspeed();
  var_4 = "_encstr_AF8A0B1B6C177B45712F594137";

  if(!isalive(self.enemy) || var_3 <= 120 || istrue(self.uprightcqbidle)) {
    if(scripts\asm\asm::asm_hasalias(var_1, "_encstr_960F0FA6B0E9513F5388A73BC1441DD030"))
      var_4 = "_encstr_960F0FA6B0E9513F5388A73BC1441DD030";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
}

shoot_playidleanimloop(var_0, var_1, var_2) {
  thread handleburstdelay(var_0, var_1);

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper()) {
    return;
  }
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }
  self.bshootidle = 1;
  self setupshootstyleadditive(1, 0);
}

shootstylesingle(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams_shotsperburst == 1;
}

doshoot_mgturret(var_0) {
  var_1 = self getturret();
  var_1 startfiring();
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F");
  var_2 = self._blackboard.shootparams_shotsperburst;

  while(var_2 > 0) {
    var_1 shootturret();
    var_2--;
    self.a.lastshoottime = gettime();
    wait(var_0);
  }

  var_1 stopfiring();
}

doshoot_lmg(var_0, var_1, var_2) {
  var_3 = self._blackboard.shootparams_shotsperburst;
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::asm_getxanim(var_1, var_4);
  var_6 = getanimlength(var_5);
  var_6 = var_6 / var_2;
  var_7 = 0.2;
  self updateplayersightaccuracy();

  while(var_3 > 0) {
    var_3--;
    _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::shootenemywrapper(0);

    if(!isagent(self))
      self setflaggedanimknobrestart(var_1, var_5, 1, var_7, var_6);

    scripts\asm\shared\utility::decrementbulletsinclip();
    wait(var_2);
  }

  self shootstopsound();
}

shootstylemgturret(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams_style == "_encstr_BE0703A54C" && (isDefined(self getturret()) || istrue(self.juggernaut));
}

shoot_mg(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self._blackboard.shoot_firstshot = 0;
  var_3 = shoot_getrate();

  if(isDefined(self getturret()))
    doshoot_mgturret(var_3);
  else {
    scripts\asm\soldier\script_funcs::shoot_setshootparameters();
    doshoot_lmg(var_0, var_1, var_3);
  }

  self._blackboard.shootparams_numburstsleft--;
  scripts\asm\asm::asm_fireephemeralevent("_encstr_844806DCD0B7F6A3", "_encstr_A21E0F3B73D00A284FCD80FDDA8FABCF73");
  scripts\asm\asm::asm_fireevent(var_0, "_encstr_A21E0F3B73D00A284FCD80FDDA8FABCF73");
}

shoot_mg_cleanup(var_0, var_1, var_2) {
  self shootstopsound();
}

shoot_shotgunpumpsound(var_0) {
  var_1 = var_0 + "_encstr_93130F7EA33338285FF5A5CF1B85F870AB";
  var_2 = var_0 + "_encstr_B6591338C70CD0E76354F005EF7BFDFE7B4740A85B";
  thread shoot_timeout(var_1, var_2, 2);
  self endon(var_1);
  self waittillmatch(var_0, "_encstr_B4430A6D6737F9134D1A5373");
  self notify(var_2);
}

shoot_stopsoundwithdelay(var_0) {
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  wait(var_0);
  self shootstopsound();
}

shoot_donotetrackswithtimeout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_encstr_A3BD09C633595885CA97A1";
  var_6 = var_1 + "_encstr_9AB00D68BC6F601B0D8B4011A265C1";
  childthread shoot_timeout(var_5, var_6, var_3);
  self endon(var_5);
  var_7 = getnotetracktimes(var_2, "_encstr_88780599B4E495");
  var_8 = var_7.size > 0;
  var_9 = weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0";

  if(var_8) {
    if(var_7.size == 1 && var_7[0] == 0)
      var_8 = 0;
  }

  var_10 = 0;
  var_11 = self._blackboard.shootparams_shotsperburst;
  var_12 = var_11 == 1 || self._blackboard.shootparams_style == "_encstr_BE1805DCCAB596";
  var_13 = isPlayer(self.enemy) && self.enemy isinvulnerable();
  var_14 = _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun();

  if(self._blackboard.shootparams_style == "_encstr_8E1F05C92C6CB6")
    var_11 = 1;

  var_15 = var_1;

  if(isDefined(var_4))
    var_15 = var_4;

  while(var_10 < var_11 && var_11 > 0) {
    if(var_8)
      self waittillmatch(var_15, "_encstr_88780599B4E495");

    if(!self.bulletsinclip) {
      break;
    }

    shootatshootentorpos(var_12);

    if(var_13) {
      if(randomint(3) == 0)
        self.bulletsinclip--;
    } else
      self.bulletsinclip--;

    if(var_9) {
      if(self.rocketammo > 0)
        self.rocketammo--;

      if(weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" && self tagexists("_encstr_8FD20B6BE0AA87786007DBC1A8"))
        self hidepart("_encstr_8FD20B6BE0AA87786007DBC1A8");
    }

    var_10++;

    if(var_14)
      childthread shoot_shotgunpumpsound(var_15);

    if(self._blackboard.shootparams_fastburst && var_10 == var_11) {
      break;
    }

    if(!var_8 || var_11 == 1 && self._blackboard.shootparams_style == "_encstr_BDDC07EBCCB5CA4BED" || var_14 && self._blackboard.shootparams_style == "_encstr_8E1F05C92C6CB6")
      self waittillmatch(var_15, "_encstr_961804BD954A");
  }

  self notify(var_6);
}

shootatshootentorpos(var_0) {
  if(isDefined(self._blackboard.shootparams_ent) && self._blackboard.shootparams_buseentinshootcalc) {
    if(isDefined(self.enemy) && self._blackboard.shootparams_ent == self.enemy)
      self[[anim.shootenemywrapper_func]](var_0);
  } else
    self[[anim.shootposwrapper_func]](self._blackboard.shootparams_pos, var_0);
}

shoot_timeout(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

shoot_getrate() {
  var_0 = self._blackboard.shootparams_style;
  var_1 = 1.0;

  if(isDefined(self.shootrateoverride))
    var_1 = self.shootrateoverride;
  else if(var_0 == "_encstr_BE0703A54C")
    var_1 = 0.1;
  else if(var_0 == "_encstr_997805335763B1")
    var_1 = _encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::autoshootanimrate() * randomfloatrange(0.5, 1.0);
  else if(var_0 == "_encstr_96E206CE53B31F0B")
    var_1 = _encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::burstshootanimrate();
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    var_1 = 3.0;
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingshotgun())
    var_1 = scripts\asm\shared\utility::shotgunfirerate();
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_genade_launcher())
    var_1 = scripts\asm\shared\utility::grenadelauncherfirerate();

  return var_1;
}

shoot_updateparams(var_0, var_1, var_2) {
  self._blackboard.shootparams_readid = self._blackboard.shootparams_writeid;

  if(!isDefined(self._blackboard.shootparams_numburstsleft))
    self._blackboard.shootparams_numburstsleft = self._blackboard.shootparams_burstcount;

  scripts\code\ai_shooting::choosenumshotsandbursts();
}

burstdelay() {
  if(scripts\asm\asm_bb::bb_shootparams_idsmatch() && self._blackboard.shootparams_style == "_encstr_997805335763B1" && !self._blackboard.shootparams_fastburst) {
    if(self.a.lastshoottime == gettime())
      waitframe();

    return;
  }

  var_0 = getremainingburstdelaytime();

  if(var_0)
    wait(var_0);
}

getremainingburstdelaytime() {
  var_0 = (gettime() - self.a.lastshoottime) / 1000;
  var_1 = getburstdelaytime();

  if(var_1 > var_0)
    return var_1 - var_0;

  return 0;
}

getburstdelaytimemg() {
  var_0 = isDefined(self.turret);

  if(var_0 && isDefined(self.turret.script_delay_min))
    var_1 = self.turret.script_delay_min;
  else
    var_1 = 0.2;

  if(var_0 && isDefined(self.turret.script_delay_max))
    var_2 = self.turret.script_delay_max - var_1;
  else
    var_2 = 0.5;

  return var_1 + randomfloat(var_2);
}

using_a_turret() {
  if(!isDefined(self.turret))
    return 0;

  return self.turret.owner == self;
}

getburstdelaytime() {
  if(using_a_turret() || weaponclass(self.weapon) == "_encstr_BE0703A54C")
    return getburstdelaytimemg();

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    return randomfloatrange(0.1, 0.45);

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun())
    return randomfloatrange(2.0, 2.7);
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_genade_launcher())
    return scripts\asm\shared\utility::grenadelauncherfirerate();
  else if(weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
    return randomfloatrange(6, 8);

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper())
    return scripts\asm\shared\utility::getsniperburstdelaytime();

  if(scripts\asm\asm_bb::bb_shootparams_idsmatch()) {
    if(self._blackboard.shootparams_fastburst) {
      if(isDefined(self._blackboard.shootparams_ent))
        return randomfloatrange(0.1, 0.35);
      else
        return randomfloatrange(0.6, 1.0);
    }

    if(isDefined(self._blackboard.shootparams_ent))
      return randomfloatrange(0.4, 0.9);
    else
      return randomfloatrange(0.8, 1.2);
  }

  return randomfloatrange(0.8, 1.2);
}
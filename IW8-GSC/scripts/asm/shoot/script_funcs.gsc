/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shoot\script_funcs.gsc
***********************************************/

function initshoot(var0, var1, var2) {
  self._blackboard.shootstate = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  self._blackboard.shoot_firstshot = 1;

  if(weaponclass(self.weapon) == "rocketlauncher" && !isDefined(self.covernode)) {
    self._blackboard.shoot_firstshot = 0;
    return;
  }
}

function shouldbeginfiring(var0, var1, var2, var3) {
  if(!scripts\asm\asm_bb::bb_firerequested()) {
    return 0;
  }

  var4 = istrue(self._blackboard.shoot_firstshot) || scripts\asm\asm::asm_eventfired(var0, "burst_delay_finished");
  return var4;
}

function handleburstdelay(var0, var1) {
  self endon(var1 + "_finished");

  if(!istrue(self.ignoreburstdelay)) {
    burstdelay();
  }

  scripts\asm\asm::asm_fireevent(var0, "burst_delay_finished");
}

function chooseshootidle(var0, var1, var2) {
  var3 = self aigetdesiredspeed();
  var4 = "shoot_idle";

  if(!isalive(self.enemy) || var3 <= 120 || istrue(self.uprightcqbidle)) {
    if(scripts\asm\asm::asm_hasalias(var1, "cqb_shoot_idle")) {
      var4 = "cqb_shoot_idle";
    }
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var4);
}

function shoot_playidleanimloop(var0, var1, var2) {
  thread handleburstdelay(var0, var1);

  if(scripts\anim\utility_common::isasniper()) {
    return;
  }

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  self.bshootidle = 1;
  self setupshootstyleadditive(1, 0);
}

function shootstylesingle(var0, var1, var2, var3) {
  return self._blackboard.shootparams_shotsperburst == 1;
}

function doshoot_mgturret(var0) {
  var1 = self getturret();
  var1 startfiring();
  var1 endon("death");
  var1 endon("turretstatechange");
  var2 = self._blackboard.shootparams_shotsperburst;

  while(var2 > 0) {
    var1 shootturret();
    var2--;
    self.a.lastshoottime = gettime();
    wait var0;
  }

  var1 stopfiring();
}

function doshoot_lmg(var0, var1, var2) {
  var3 = self._blackboard.shootparams_shotsperburst;
  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  var5 = scripts\asm\asm::asm_getxanim(var1, var4);
  var6 = getanimlength(var5);
  var6 /= var2;
  var7 = 0.2;
  self updateplayersightaccuracy();

  while(var3 > 0) {
    var3--;
    scripts\anim\utility_common::shootenemywrapper(0);

    if(!isagent(self)) {
      self setflaggedanimknobrestart(var1, var5, 1, var7, var6);
    }

    scripts\asm\shared\utility::decrementbulletsinclip();
    wait var2;
  }

  self shootstopsound();
}

function shootstylemgturret(var0, var1, var2, var3) {
  return self._blackboard.shootparams_style == "mg" && (isDefined(self getturret()) || istrue(self.juggernaut));
}

function shoot_mg(var0, var1, var2) {
  self endon(var1 + "_finished");
  self._blackboard.shoot_firstshot = 0;
  var3 = shoot_getrate();

  if(isDefined(self getturret())) {
    doshoot_mgturret(var3);
  } else {
    scripts\asm\soldier\script_funcs::shoot_setshootparameters();
    doshoot_lmg(var0, var1, var3);
  }

  self._blackboard.shootparams_numburstsleft--;
  scripts\asm\asm::asm_fireephemeralevent("shoot", "shoot_finished");
  scripts\asm\asm::asm_fireevent(var0, "shoot_finished");
}

function shoot_mg_cleanup(var0, var1, var2) {
  self shootstopsound();
}

function shoot_shotgunpumpsound(var0) {
  var1 = var0 + "_shotgun_sound";
  var2 = var0 + "kill_shotgun_sound";
  thread shoot_timeout(var1, var2, 2);
  self endon(var1);
  self waittillmatch(var0, "rechamber");
  self notify(var2);
}

function shoot_stopsoundwithdelay(var0) {
  self endon("terminate_ai_threads");
  wait var0;
  self shootstopsound();
}

function shoot_donotetrackswithtimeout(var0, var1, var2, var3, var4) {
  var5 = var1 + "_timeout";
  var6 = var1 + "_timeout_end";
  GscBinSkip4(0x35, var5, var6, var3);
}

function shootatshootentorpos(var0) {
  if(isDefined(self._blackboard.shootparams_ent) && self._blackboard.shootparams_buseentinshootcalc) {
    if(isDefined(self.enemy) && self._blackboard.shootparams_ent == self.enemy) {
      self[[anim.shootenemywrapper_func]](var0);
      return;
    }

    return;
  }

  self[[anim.shootposwrapper_func]](self._blackboard.shootparams_pos, var0);
}

function shoot_timeout(var0, var1, var2) {
  self endon(var1);
  wait var2;
  self notify(var0);
}

function shoot_getrate() {
  var0 = self._blackboard.shootparams_style;
  var1 = 1;

  if(isDefined(self.shootrateoverride)) {
    var1 = self.shootrateoverride;
  } else if(var0 == "mg") {
    var1 = 0.1;
  } else if(var0 == "full") {
    var1 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1);
  } else if(var0 == "burst") {
    var1 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var1 = 3;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var1 = scripts\asm\shared\utility::shotgunfirerate();
  } else if(scripts\anim\utility_common::weapon_genade_launcher()) {
    var1 = scripts\asm\shared\utility::grenadelauncherfirerate();
  }

  return var1;
}

function shoot_updateparams(var0, var1, var2) {
  self._blackboard.shootparams_readid = self._blackboard.shootparams_writeid;

  if(!isDefined(self._blackboard.shootparams_numburstsleft)) {
    self._blackboard.shootparams_numburstsleft = self._blackboard.shootparams_burstcount;
  }

  scripts\code\ai_shooting::choosenumshotsandbursts();
}

function burstdelay() {
  if(scripts\asm\asm_bb::bb_shootparams_idsmatch() && self._blackboard.shootparams_style == "full" && !self._blackboard.shootparams_fastburst) {
    if(self.a.lastshoottime == gettime()) {
      waitframe();
    }

    return;
  }

  var0 = getremainingburstdelaytime();

  if(var0) {
    wait var0;
    return;
  }
}

function getremainingburstdelaytime() {
  var0 = (gettime() - self.a.lastshoottime) / 1000;
  var1 = getburstdelaytime();

  if(var1 > var0) {
    return (var1 - var0);
  }

  return 0;
}

function getburstdelaytimemg() {
  var0 = isDefined(self.turret);

  if(var0 && isDefined(self.turret.script_delay_min)) {
    var1 = self.turret.script_delay_min;
  } else {
    var1 = 0.2;
  }

  if(var1 && isDefined(self.turret.script_delay_max)) {
    var2 = self.turret.script_delay_max - var1;
  } else {
    var2 = 0.5;
  }

  return var2 + randomfloat(var2);
}

function using_a_turret() {
  if(!isDefined(self.turret)) {
    return false;
  }

  return self.turret.owner == self;
}

function getburstdelaytime() {
  if(using_a_turret() || weaponclass(self.weapon) == "mg") {
    return getburstdelaytimemg();
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.1, 0.45);
  }

  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(2, 2.7);
  } else if(scripts\anim\utility_common::weapon_genade_launcher()) {
    return scripts\asm\shared\utility::grenadelauncherfirerate();
  } else if(weaponclass(self.weapon) == "rocketlauncher") {
    return randomfloatrange(6, 8);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return scripts\asm\shared\utility::getsniperburstdelaytime();
  }

  if(scripts\asm\asm_bb::bb_shootparams_idsmatch()) {
    if(self._blackboard.shootparams_fastburst) {
      if(isDefined(self._blackboard.shootparams_ent)) {
        return randomfloatrange(0.1, 0.35);
      } else {
        return randomfloatrange(0.6, 1);
      }
    }

    if(isDefined(self._blackboard.shootparams_ent)) {
      return randomfloatrange(0.4, 0.9);
    } else {
      return randomfloatrange(0.8, 1.2);
    }
  }

  return randomfloatrange(0.8, 1.2);
}
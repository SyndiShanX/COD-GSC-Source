/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shoot\script_funcs.gsc
***********************************************/

function initshoot(var_0, var_1, var_2) {
  self._blackboard.shootstate = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  self._blackboard.shoot_firstshot = 1;

  if(weaponclass(self.weapon) == "rocketlauncher" && !isDefined(self.covernode)) {
    self._blackboard.shoot_firstshot = 0;
    return;
  }
}

function shouldbeginfiring(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_firerequested()) {
    return 0;
  }

  var_4 = istrue(self._blackboard.shoot_firstshot) || scripts\asm\asm::asm_eventfired(var_0, "burst_delay_finished");
  return var_4;
}

function handleburstdelay(var_0, var_1) {
  self endon(var_1 + "_finished");

  if(!istrue(self.ignoreburstdelay)) {
    burstdelay();
  }

  scripts\asm\asm::asm_fireevent(var_0, "burst_delay_finished");
}

function chooseshootidle(var_0, var_1, var_2) {
  var_3 = self aigetdesiredspeed();
  var_4 = "shoot_idle";

  if(!isalive(self.enemy) || var_3 <= 120 || istrue(self.uprightcqbidle)) {
    if(scripts\asm\asm::asm_hasalias(var_1, "cqb_shoot_idle")) {
      var_4 = "cqb_shoot_idle";
    }
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
}

function shoot_playidleanimloop(var_0, var_1, var_2) {
  thread handleburstdelay(var_0, var_1);

  if(scripts\anim\utility_common::isasniper()) {
    return;
  }

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  self.bshootidle = 1;
  self setupshootstyleadditive(1, 0);
}

function shootstylesingle(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams_shotsperburst == 1;
}

function doshoot_mgturret(var_0) {
  var_1 = self getturret();
  var_1 startfiring();
  var_1 endon("death");
  var_1 endon("turretstatechange");
  var_2 = self._blackboard.shootparams_shotsperburst;

  while(var_2 > 0) {
    var_1 shootturret();
    var_2--;
    self.a.lastshoottime = gettime();
    wait var_0;
  }

  var_1 stopfiring();
}

function doshoot_lmg(var_0, var_1, var_2) {
  var_3 = self._blackboard.shootparams_shotsperburst;
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::asm_getxanim(var_1, var_4);
  var_6 = getanimlength(var_5);
  var_6 /= var_2;
  var_7 = 0.2;
  self updateplayersightaccuracy();

  while(var_3 > 0) {
    var_3--;
    scripts\anim\utility_common::shootenemywrapper(0);

    if(!isagent(self)) {
      self setflaggedanimknobrestart(var_1, var_5, 1, var_7, var_6);
    }

    scripts\asm\shared\utility::decrementbulletsinclip();
    wait var_2;
  }

  self shootstopsound();
}

function shootstylemgturret(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams_style == "mg" && (isDefined(self getturret()) || istrue(self.juggernaut));
}

function shoot_mg(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._blackboard.shoot_firstshot = 0;
  var_3 = shoot_getrate();

  if(isDefined(self getturret())) {
    doshoot_mgturret(var_3);
  } else {
    scripts\asm\soldier\script_funcs::shoot_setshootparameters();
    doshoot_lmg(var_0, var_1, var_3);
  }

  self._blackboard.shootparams_numburstsleft--;
  scripts\asm\asm::asm_fireephemeralevent("shoot", "shoot_finished");
  scripts\asm\asm::asm_fireevent(var_0, "shoot_finished");
}

function shoot_mg_cleanup(var_0, var_1, var_2) {
  self shootstopsound();
}

function shoot_shotgunpumpsound(var_0) {
  var_1 = var_0 + "_shotgun_sound";
  var_2 = var_0 + "kill_shotgun_sound";
  thread shoot_timeout(var_1, var_2, 2);
  self endon(var_1);
  self waittillmatch(var_0, "rechamber");
  self notify(var_2);
}

function shoot_stopsoundwithdelay(var_0) {
  self endon("terminate_ai_threads");
  wait var_0;
  self shootstopsound();
}

function shoot_donotetrackswithtimeout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  var_6 = var_1 + "_timeout_end";
  GscBinSkip4(0x35, var_5, var_6, var_3);
}

function shootatshootentorpos(var_0) {
  if(isDefined(self._blackboard.shootparams_ent) && self._blackboard.shootparams_buseentinshootcalc) {
    if(isDefined(self.enemy) && self._blackboard.shootparams_ent == self.enemy) {
      self[[anim.shootenemywrapper_func]](var_0);
      return;
    }

    return;
  }

  self[[anim.shootposwrapper_func]](self._blackboard.shootparams_pos, var_0);
}

function shoot_timeout(var_0, var_1, var_2) {
  self endon(var_1);
  wait var_2;
  self notify(var_0);
}

function shoot_getrate() {
  var_0 = self._blackboard.shootparams_style;
  var_1 = 1;

  if(isDefined(self.shootrateoverride)) {
    var_1 = self.shootrateoverride;
  } else if(var_0 == "mg") {
    var_1 = 0.1;
  } else if(var_0 == "full") {
    var_1 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1);
  } else if(var_0 == "burst") {
    var_1 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var_1 = 3;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var_1 = scripts\asm\shared\utility::shotgunfirerate();
  } else if(scripts\anim\utility_common::weapon_genade_launcher()) {
    var_1 = scripts\asm\shared\utility::grenadelauncherfirerate();
  }

  return var_1;
}

function shoot_updateparams(var_0, var_1, var_2) {
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

  var_0 = getremainingburstdelaytime();

  if(var_0) {
    wait var_0;
    return;
  }
}

function getremainingburstdelaytime() {
  var_0 = (gettime() - self.a.lastshoottime) / 1000;
  var_1 = getburstdelaytime();

  if(var_1 > var_0) {
    return (var_1 - var_0);
  }

  return 0;
}

function getburstdelaytimemg() {
  var_0 = isDefined(self.turret);

  if(var_0 && isDefined(self.turret.script_delay_min)) {
    var_1 = self.turret.script_delay_min;
  } else {
    var_1 = 0.2;
  }

  if(var_1 && isDefined(self.turret.script_delay_max)) {
    var_2 = self.turret.script_delay_max - var_1;
  } else {
    var_2 = 0.5;
  }

  return var_2 + randomfloat(var_2);
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
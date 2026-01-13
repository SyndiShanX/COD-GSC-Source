/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archreaper.gsc
************************************************/

func_97D0() {
  level._effect["swipe_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_swipe_trail");
  level.var_DDA0 = "prop_mp_reaper_shield";
}

applyarchetype() {
  self setsuit("reaper_mp");
  equipextras();
  self disableweaponpickup();
  self.isreaping = 0;
  self.var_C4DA = 0;
  self.var_B62A = spawn("script_model", self.origin);
  self.var_B62A setModel("tag_origin");
  self.var_FC9F = spawn("script_model", self.origin);
  self.var_FC9F setModel(level.var_DDA0);
  self.var_FC9F setCanDamage(0);
  self.var_FC9F hide();
  thread func_13ACC();
  self _meth_845E(1);
}

removearchetype() {
  self notify("removeReaper");
  self enableweaponpickup();
  self.var_FC9F delete();
  self.var_B62A delete();
}

equipextras() {}

func_4FB9(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  self endon("removeReaper");
  self endon("shield_down");
  level endon("game_ended");
  while(self.var_4BFD > var_0) {
    self.var_4BFD = self.var_4BFD - var_0;
    wait(var_1);
  }

  self.var_C4DA = 1;
  self notify("drop_shield");
}

func_93EE(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");
  self endon("removeReaper");
  self endon("shield_up");
  level endon("game_ended");
  while(self.var_4BFD < var_2) {
    self.var_4BFD = self.var_4BFD + var_0;
    if(self.var_4BFD > 33) {
      self.var_C4DA = 0;
    }

    wait(var_1);
  }
}

func_13994() {
  self endon("disconnect");
  self endon("death");
  self endon("removeReaper");
  level endon("game_ended");
  var_0 = 3;
  var_1 = 100;
  var_2 = var_1 / var_0;
  self.var_4BFD = var_1;
  var_3 = 0.1;
  var_4 = var_2 * var_3;
  self.var_FCA5 = 0;
  thread func_5D58();
  thread func_5D57(var_4, var_3, var_1);
  for(;;) {
    if(self.isreaping) {
      wait(0.05);
      continue;
    }

    if(self adsbuttonpressed() && !self.var_FCA5 && !self.var_C4DA) {
      func_FCA5(var_4, var_3);
    } else if(!self adsbuttonpressed() && self.var_FCA5) {
      func_FC98(var_4, var_3, var_1);
    }

    wait(0.05);
  }
}

func_5D57(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");
  self endon("removeReaper");
  level endon("game_ended");
  for(;;) {
    self waittill("drop_shield");
    func_FC98(var_0, var_1, var_2);
  }
}

func_FCA5(var_0, var_1) {
  thread func_4FB9(var_0, var_1);
  self.var_FCA5 = 1;
  self notify("shield_up");
  self.var_FC9F.angles = self.angles + (0, 90, 0);
  self.var_FC9F.origin = func_36DB(32);
  self playlocalsound("reaper_shield_up");
  self.var_FC9F playSound("reaper_shield_up_npc");
  self.var_FC9F show();
  self.var_FC9F setCanDamage(1);
  thread func_BCEE();
  thread func_FC9C();
  self getradiuspathsighttestnodes();
  self allowjump(0);
  self allowprone(0);
  scripts\mp\utility::_magicbullet("iw7_erad_mp", self.origin + (0, 0, 4500), self.origin + (0, 0, 5500), self);
}

func_FC98(var_0, var_1, var_2) {
  thread func_93EE(var_0, var_1, var_2);
  self playlocalsound("reaper_shield_down");
  self.var_FC9F playSound("reaper_shield_down_npc");
  self notify("shield_down");
  self.var_FCA5 = 0;
  self enableweapons();
  self allowjump(1);
  self allowprone(1);
  self.var_FC9F hide();
  self.var_FC9F setCanDamage(0);
}

func_5D58() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::waittill_any_return_no_endon_death_3("death", "disconnect");
  if(var_0 == "death") {
    self enableweapons();
    self allowjump(1);
    self allowprone(1);
    self notify("shield_down");
    if(isDefined(self.var_FC9F)) {
      self.var_FC9F hide();
      self.var_FC9F setCanDamage(0);
    }
  }

  if(var_0 == "disconnect" && isDefined(self.var_FC9F)) {
    self.var_FC9F hide();
    self.var_FC9F setCanDamage(0);
  }
}

func_FC9C() {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  self endon("shield_down");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(isDefined(var_3)) {
      playsoundatpos(var_3, "bs_shield_impact");
    } else {
      playsoundatpos(self.var_FC9F.origin, "bs_shield_impact");
    }

    var_1 scripts\mp\damagefeedback::updatedamagefeedback("hitbulletstorm");
    wait(0.05);
  }
}

func_BCEE(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  self endon("shield_down");
  level endon("game_ended");
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = 32;
  }

  for(;;) {
    self.var_FC9F.angles = self.angles + (0, 90, 0);
    self.var_FC9F.origin = func_36DB(var_1);
    wait(0.05);
  }
}

func_36DB(var_0) {
  var_1 = (0, 0, 0);
  var_2 = self.origin + var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoright(self.angles);
  var_5 = self getvelocity();
  var_6 = vectordot(var_5, self.angles);
  var_7 = length(var_5);
  if(var_7 < 64) {
    var_7 = 64;
  }

  if(var_7 > 64 && var_7 < 128) {
    var_7 = 92;
  }

  if(var_7 > 350) {
    var_7 = 500;
  }

  if(var_7 > 200) {
    var_7 = 256;
  }

  if(var_7 > 128) {
    var_7 = 164;
  }

  if(var_6 < 1) {
    var_7 = 64;
  }

  if(isDefined(var_0)) {
    var_7 = var_0;
  }

  return var_2 + var_3 * var_7;
}

func_13ACC(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var_1 = (0, 0, 32);
  for(;;) {
    self waittill("melee_fired");
    var_2 = self.origin + var_1;
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoright(self.angles);
    scripts\mp\utility::_magicbullet("iw7_erad_mp", self.origin + (0, 0, 4500), self.origin + (0, 0, 5500), self);
    self playrumbleonentity("damage_light");
    earthquake(0.2, 0.1, self.origin, 32);
    var_5 = func_36DB(var_0);
    var_5 = var_5 + var_1;
    var_6 = var_2 + var_4 * 64;
    var_7 = var_2 - var_4 * 32;
    var_8 = rotatevector(var_4, (0, 45, 0));
    var_9 = var_2 + var_8 * 64;
    var_0A = rotatevector(var_4, (0, 135, 0));
    var_0B = var_2 + var_0A * 32;
    var_0C = gettime();
    self.var_B62A.origin = var_6;
    wait(0.05);
    playFXOnTag(level._effect["swipe_trail"], self.var_B62A, "tag_origin");
    wait(0.05);
    self.var_B62A.origin = var_9;
    wait(0.05);
    self.var_B62A.origin = var_5;
    thread func_20D9(var_5);
    wait(0.05);
    self.var_B62A.origin = var_0B;
    wait(0.05);
    self.var_B62A.origin = var_7;
    wait(0.05);
    stopFXOnTag(level._effect["swipe_trail"], self.var_B62A, "tag_origin");
  }
}

func_20D9(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var_1 = distance2d(self.origin, var_0) / 2;
  self radiusdamage(self.origin, var_1, 135, 135, self, "MOD_MELEE", "iw7_reaperblade_mp");
}

func_11A83(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var_3 = self.origin + (0, 0, 32);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 0;
  var_9 = gettime();
  var_0A = var_2;
  var_4 = scripts\common\trace::ray_trace(var_3, var_0, var_0A);
  if(isDefined(var_4["entity"])) {
    var_8 = 1;
    var_6 = var_4["entity"];
    var_0A[var_0A.size] = var_6;
  }

  if(isDefined(var_1)) {
    var_5 = scripts\common\trace::ray_trace(var_0, var_1, var_0A);
    if(isDefined(var_5) && isDefined(var_5["entity"])) {
      var_8 = 1;
      var_7 = var_4["entity"];
      var_0A[var_0A.size] = var_7;
    }
  }

  if(isDefined(var_6)) {
    if(isDefined(var_6.var_904B) && var_6.var_904B == var_9) {
      return var_0A;
    }

    if(!scripts\mp\utility::attackerishittingteam(var_6, self) && var_6 != self) {
      var_6 thread[[level.callbackplayerdamage]](undefined, self, 135, 0, "MOD_MELEE", "iw7_reaperblade_mp", self.origin, undefined, "none", 0);
    }
  }

  if(isDefined(var_7)) {
    if(isDefined(var_7.var_904B) && var_7.var_904B == var_9) {
      return var_0A;
    }

    if(!scripts\mp\utility::attackerishittingteam(var_7, self) && var_7 != self) {
      var_7 thread[[level.callbackplayerdamage]](undefined, self, 135, 0, "MOD_MELEE", "iw7_reaperblade_mp", self.origin, undefined, "none", 0);
    }
  }

  return var_0A;
}
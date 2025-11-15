/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3611.gsc
************************/

init() {
  level._effect["visionPulse_ping"] = loadfx("vfx\iw7\_requests\mp\vfx_opticwave.vfx");
}

func_12F9B() {
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_pulse", undefined, 0.75);
  thread func_139A3();
  thread func_13450();
  return 1;
}

func_139A3() {
  if(!isDefined(self.var_13455)) {
    self.var_13455 = [];
  }

  self visionsetnakedforplayer("opticwave_mp", 0);
  self setscriptablepartstate("visionPulse", "active", 0);
  self.visionpulsevisionsetactive = 1;
  func_139A4();
  if(isDefined(self)) {
    if(scripts\mp\utility::isreallyalive(self)) {
      self visionsetnakedforplayer("", 0.5);
    } else {
      self visionsetnakedforplayer("", 0);
    }

    self setscriptablepartstate("visionPulse", "neutral", 0);
    self.visionpulsevisionsetactive = undefined;
  }
}

func_139A4() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = self.origin;
  var_01 = anglesToForward(self.angles);
  var_02 = 1000;
  var_03 = gettime();
  var_04 = var_03 + var_02;
  while(gettime() <= var_04) {
    var_05 = 1 - var_04 - gettime() / var_02 * 4096;
    foreach(var_07 in level.characters) {
      if(func_13151(var_07, var_05, var_00, var_01)) {
        var_07 thread func_13B9F(self);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_13B9F(param_00) {
  var_01 = self getentitynumber();
  param_00.var_13455[var_01] = self;
  if(!isai(self)) {
    scripts\mp\utility::_hudoutlineviewmodelenable(5);
  }

  var_02 = scripts\mp\utility::outlineenableforplayer(self, "orange", param_00, 0, 1, "killstreak_personal");
  func_13BA0(param_00, 5);
  if(isDefined(self)) {
    if(!isai(self)) {
      scripts\mp\utility::_hudoutlineviewmodeldisable();
    }
  }

  if(isDefined(param_00)) {
    if(isDefined(param_00.var_13455)) {
      param_00.var_13455[var_01] = undefined;
    }
  }

  scripts\mp\utility::outlinedisable(var_02, self);
}

func_13BA0(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_02 = gettime() + param_01 * 1000;
  while(gettime() <= var_02) {
    if(scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
      break;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_13151(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == self) {
    return 0;
  }

  if(scripts\mp\utility::func_9E05(self.team, param_00)) {
    return 0;
  }

  if(func_9EF9(param_00)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(param_00)) {
    return 0;
  }

  if(param_00 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
    return 0;
  }

  var_04 = param_00.origin - param_02 * (1, 1, 0);
  if(length2dsquared(var_04) > param_01 * param_01) {
    return 0;
  }

  return 1;
}

func_9EF9(param_00) {
  if(isDefined(self.var_13455)) {
    return isDefined(self.var_13455[param_00 getentitynumber()]);
  }

  return 0;
}

func_13450() {
  var_00 = self getEye();
  var_01 = anglesToForward(self.angles);
  var_02 = var_00 + var_01 * 4096;
  var_03 = spawn("script_model", var_00);
  var_03.angles = self.angles;
  var_03 setModel("tag_origin");
  wait(0.1);
  playfxontagforclients(scripts\engine\utility::getfx("visionPulse_ping"), var_03, "tag_origin", self);
  var_03 moveto(var_02, 1);
  wait(1);
  var_03 delete();
}
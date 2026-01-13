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
  var_0 = self.origin;
  var_1 = anglesToForward(self.angles);
  var_2 = 1000;
  var_3 = gettime();
  var_4 = var_3 + var_2;
  while(gettime() <= var_4) {
    var_5 = 1 - var_4 - gettime() / var_2 * 4096;
    foreach(var_7 in level.characters) {
      if(func_13151(var_7, var_5, var_0, var_1)) {
        var_7 thread func_13B9F(self);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_13B9F(var_0) {
  var_1 = self getentitynumber();
  var_0.var_13455[var_1] = self;
  if(!isai(self)) {
    scripts\mp\utility::_hudoutlineviewmodelenable(5);
  }

  var_2 = scripts\mp\utility::outlineenableforplayer(self, "orange", var_0, 0, 1, "killstreak_personal");
  func_13BA0(var_0, 5);
  if(isDefined(self)) {
    if(!isai(self)) {
      scripts\mp\utility::_hudoutlineviewmodeldisable();
    }
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0.var_13455)) {
      var_0.var_13455[var_1] = undefined;
    }
  }

  scripts\mp\utility::outlinedisable(var_2, self);
}

func_13BA0(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = gettime() + var_1 * 1000;
  while(gettime() <= var_2) {
    if(scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
      break;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_13151(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == self) {
    return 0;
  }

  if(scripts\mp\utility::func_9E05(self.team, var_0)) {
    return 0;
  }

  if(func_9EF9(var_0)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(var_0)) {
    return 0;
  }

  if(var_0 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
    return 0;
  }

  var_4 = var_0.origin - var_2 * (1, 1, 0);
  if(length2dsquared(var_4) > var_1 * var_1) {
    return 0;
  }

  return 1;
}

func_9EF9(var_0) {
  if(isDefined(self.var_13455)) {
    return isDefined(self.var_13455[var_0 getentitynumber()]);
  }

  return 0;
}

func_13450() {
  var_0 = self getEye();
  var_1 = anglesToForward(self.angles);
  var_2 = var_0 + var_1 * 4096;
  var_3 = spawn("script_model", var_0);
  var_3.angles = self.angles;
  var_3 setModel("tag_origin");
  wait(0.1);
  playfxontagforclients(scripts\engine\utility::getfx("visionPulse_ping"), var_3, "tag_origin", self);
  var_3 moveto(var_2, 1);
  wait(1);
  var_3 delete();
}
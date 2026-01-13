/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3606.gsc
*********************************************/

func_98AB() {
  level.var_C7F2 = [];
}

func_F7CE() {
  thread func_13A4F();
}

func_12CFF() {
  self notify("overdriveUnset");
  func_6373(1);
}

func_10DD6() {
  if(!scripts\mp\utility::isanymlgmatch()) {
    self.health = self.maxhealth;
  }

  self motionblurhqenable();
  thread func_13ADF();
  thread func_13AE0();
  thread func_13AE1();
  self setscriptablepartstate("overdrive", "activeOn", 0);
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_overdrive", undefined, 0.75);
}

func_6373(var_0) {
  self notify("overdriveEnd");
  self motionblurhqdisable();
  if(self.loadoutarchetype == "archetype_assault") {
    if(!scripts\mp\utility::istrue(var_0)) {
      self setscriptablepartstate("overdrive", "activeOff", 0);
    }

    self setscriptablepartstate("overdriveMove", "neutral", 0);
  }
}

func_13A4F() {
  self endon("disconnect");
  self endon("overdriveUnset");
  self notify("watchForOverdrive");
  self endon("watchForOverdrive");
  for(;;) {
    var_0 = spawnStruct();
    childthread func_13A53(var_0);
    childthread func_13A51(var_0);
    childthread func_13A50(var_0);
    childthread func_13A52(var_0);
    childthread watchforoverdriveracegameended(var_0);
    self waittill("overdriveBeginRace");
    waittillframeend;
    if(isDefined(var_0.var_6ACF)) {
      scripts\mp\supers::refundsuper();
    } else if(isDefined(var_0.var_10DE6) && isDefined(var_0.var_637B) || isDefined(var_0.var_4E59) || isDefined(var_0.gameendedreceived)) {
      scripts\mp\supers::refundsuper();
    } else if(isDefined(var_0.var_4E59)) {
      func_6373(1);
    } else if(isDefined(var_0.var_637B)) {
      func_6373(0);
    } else if(isDefined(var_0.gameendedreceived)) {
      if(self func_856B()) {
        self func_85AD();
        func_6373(0);
      }
    } else if(isDefined(var_0.var_10DE6)) {
      func_10DD6();
    }

    self notify("overdriveEndRace");
  }
}

func_13A53(var_0) {
  self endon("overdriveEndRace");
  self waittill("overdriveStart", var_1, var_2);
  var_0.var_10DE6 = 1;
  var_0.areanynavvolumesloaded = var_1;
  var_0.var_6378 = var_2;
  self notify("overdriveBeginRace");
}

func_13A51(var_0) {
  self endon("overdriveEndRace");
  self waittill("overdriveEnd");
  var_0.var_637B = 1;
  self notify("overdriveBeginRace");
}

func_13A50(var_0) {
  self endon("overdriveEndRace");
  self waittill("death");
  var_0.var_4E59 = 1;
  self notify("overdriveBeginRace");
}

func_13A52(var_0) {
  self endon("overdriveEndRace");
  self waittill("overdriveFailed");
  var_0.var_6ACF = 1;
  self notify("overdriveBeginRace");
}

watchforoverdriveracegameended(var_0) {
  self endon("overdriveEndRace");
  level scripts\engine\utility::waittill_any_3("bro_shot_start", "game_ended");
  var_0.gameendedreceived = 1;
  self notify("overdriveBeginRace");
}

func_13ADF() {
  self endon("death");
  self endon("disconnect");
  self endon("overdriveEnd");
  waittillframeend;
  while(self func_856B()) {
    var_0 = scripts\mp\supers::getcurrentsuper();
    var_0.var_130EF = self func_856C() * scripts\mp\supers::func_8188() * 1000;
    scripts\mp\supers::func_112A5();
    scripts\engine\utility::waitframe();
  }
}

func_13AE1() {
  var_0 = physics_volumecreate(self.origin, 72);
  var_0.time = gettime();
  level.var_C7F2 scripts\engine\utility::array_removeundefined(level.var_C7F2);
  var_1 = undefined;
  var_2 = 0;
  for(var_3 = 0; var_3 < 3; var_3++) {
    var_4 = level.var_C7F2[var_3];
    if(!isDefined(var_4)) {
      var_2 = var_3;
      break;
    } else if(!isDefined(var_1) || isDefined(var_1) && var_1.time > var_4.time) {
      var_1 = var_4;
      var_2 = var_3;
    }
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }

  level.var_C7F2[var_2] = var_0;
  var_5 = spawn("script_origin", var_0.origin);
  var_0 linkto(var_5);
  thread func_13AEF(var_0);
  thread func_13AF0(var_5);
  scripts\engine\utility::waittill_any_3("death", "disconnect", "overdriveEnd");
  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_5 delete();
}

func_13AF0(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("disconnect");
  self endon("overdriveEnd");
  for(;;) {
    var_0 moveto(self.origin, 0.1);
    wait(0.1);
  }
}

func_13AEF(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("disconnect");
  self endon("overdriveEnd");
  var_1 = -10311;
  for(;;) {
    var_2 = self getvelocity();
    if(lengthsquared(var_2) < var_1) {
      var_0 physics_volumeenable(0);
    } else {
      var_3 = vectornormalize(var_2);
      var_4 = self.origin + var_3 * 25;
      var_0 physics_volumesetasfocalforce(1, var_4, 325);
      var_0 physics_volumesetactivator(1);
      var_0 physics_volumeenable(1);
    }

    scripts\engine\utility::waitframe();
  }
}

func_13AE0() {
  self endon("death");
  self endon("disconnect");
  self endon("overdriveEnd");
  var_0 = -10311;
  for(;;) {
    var_1 = self getvelocity() * (1, 1, 0);
    var_2 = length2dsquared(var_1);
    if(var_2 >= var_0) {
      self setscriptablepartstate("overdriveMove", "active", 0);
    } else {
      self setscriptablepartstate("overdriveMove", "neutral", 0);
    }

    wait(0.1);
  }
}
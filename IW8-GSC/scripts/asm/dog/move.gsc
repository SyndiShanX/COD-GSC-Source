/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\dog\move.gsc
***********************************************/

function dog_init(var0, var1, var2) {
  self.sharpturnlookaheaddist = 60;
  scripts\asm\shared\utility::getbasearchetype();
  self.asm.customdata = spawnStruct();
  self enabletraversals(0);
  self.soundent = scripts\engine\utility::spawn_tag_origin();
  self.soundent linkTo(self, "tag_eye");
  thread waitfordeath(self.soundent);
}

function waitfordeath(var0) {
  self waittill("death");

  if(isDefined(var0)) {
    var0 stopsounds();
    waitframe();
    var0 delete();
    return;
  }
}

function needtoturn(var0, var1, var2, var3) {
  var4 = undefined;

  if(isDefined(self.enemy)) {
    var4 = self.enemy;
  } else if(isDefined(self._blackboard.target)) {
    var4 = self._blackboard.target;
  }

  if(!isDefined(var4)) {
    return 0;
  }

  var5 = vectorNormalize(var4.origin - self.origin);
  var6 = vectortoyaw(var5);
  var7 = angleclamp180(var6 - self.angles[1]);
  var8 = var7 < -35 || var7 > 35;

  if(var8) {
    self._blackboard.desiredturnyaw = var6;
  }

  return var8;
}

function needtoturnforexit(var0, var1, var2, var3) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(distance2dsquared(self.origin, self.pathgoalpos) < 4) {
    return 0;
  }

  var4 = vectortoyaw(self.lookaheaddir);
  var5 = angleclamp180(var4 - self.angles[1]);
  var6 = var5 < -46 || var5 > 46;

  if(var6) {
    self._blackboard.desiredturnyaw = var4;
  }

  return var6;
}

function shouldstartarrival(var0, var1, var2, var3) {
  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(isDefined(self.melee)) {
    return false;
  }

  if(!scripts\asm\asm::asm_eventfired(var0, "cover_approach")) {
    return false;
  }

  var4 = 128;
  var5 = 96;
  var6 = self pathdisttogoal();

  if(var6 > var4 || var6 < var5) {
    return false;
  }

  return true;
}

function chooseanim_arrival(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "2");
}

function playanim_arrival(var0, var1, var2) {
  self endon(var1 + "_finished");
  self animmode("zonly_physics", 0);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  var5 = self.pathgoalpos - self.origin;
  var6 = vectortoyaw(var5);
  var7 = getmovedelta(var4);
  var8 = getangledelta(var4);
  var9 = length(var5);
  var10 = length(var7) / var9;
  var11 = self.pathgoalpos;
  var12 = var11 - rotatevector(var7, (0, var6, 0));
  var13 = var6 + var8;
  var14 = int(1000 * getanimlength(var4) - 200);
  self startcoverarrival();
  self motionwarpwithanim(var12, (0, var6, 0), var11, (0, var13, 0), var14);
  self.asm.arriving = var1;
  self aisetanim(var1, var3, var10);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1), var1);
}

function playanim_arrival_cleanup(var0, var1, var2) {
  self finishcoverarrival();
  self motionwarpcancel();
}

function chooseturnanim(var0, var1, var2) {
  var3 = angleclamp180(self._blackboard.desiredturnyaw - self.angles[1]);
  var4 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  var5 = getangleindex(var3);
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var4[var5]);
}

function playturnanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var3);
  self.useanimgoalweight = 1;
  self._blackboard.turnanim = var3;
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1), var1);
}

function playturnanim_cleanup(var0, var1, var2) {
  self.useanimgoalweight = 0;
  self._blackboard.desiredturnyaw = undefined;
  self._blackboard.turnanim = undefined;
}

function playanim_idle(var0, var1, var2) {
  thread playanim_headtrack(var0, var1);
  thread playanim_growltrack(var0, var1);
  scripts\asm\asm::asm_loopanimstate(var0, var1, 1, 0);
}

function playanim_headtrack(var0, var1) {
  self endon(var1 + "_finished");

  for(;;) {
    if(isDefined(self.stealth) && isDefined(self.stealth.bidlecurious) && self.stealth.bidlecurious) {}

    waitframe();
  }
}

function playanim_growltrack(var0, var1) {
  self endon(var1 + "_finished");

  for(;;) {
    while(!isDefined(self.stealth) || !isDefined(self.stealth.bgrowl) || !self.stealth.bgrowl) {
      waitframe();
    }

    self.soundent playSound("anml_dog_growl", "dog_growl", 1);
    self.soundent waittill("dog_growl");
    waitframe();
  }
}

function shouldidlebark(var0, var1, var2, var3) {
  var4 = isDefined(self.stealth) && isDefined(self.stealth.bbark) && self.stealth.bbark;
  return istrue(self.forcebark) || var4;
}

function notshouldidlebark(var0, var1, var2, var3) {
  return !shouldidlebark(var0, var1, var2, var3);
}

function playanim_bark(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var3);

  for(;;) {
    scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1), var1);
    var3 = scripts\asm\asm::asm_getanim(var0, var1);
    self aisetanim(var1, var3);
  }
}

function handledogfootstepnotetracks(var0) {
  switch (var0) {
    case "fs_fr_l_sm":
    case "fs_fr_r_sm":
    case "fs_bk_r_sm":
    case "fs_bk_l_sm":
    case "fs_fr_r_lg":
    case "fs_fr_l_lg":
    case "fs_bk_l_lg":
    case "fs_bk_r_lg":
      var1 = undefined;

      if(isDefined(self.groundtype)) {
        var1 = self.groundtype;
        self.lastgroundtype = var1;
      } else if(isDefined(self.lastgroundtype)) {
        var1 = self.lastgroundtype;
      } else {
        var1 = "dirt";
      }

      if(var1 != "dirt" && var1 != "concrete" && var1 != "wood" && var1 != "metal") {
        var1 = "dirt";
      }

      if(var1 == "concrete") {
        var1 = "cement";
      }

      var2 = self._blackboard.movetype;
      self playSound("dogstep_" + var2 + "_" + var1);
      return true;
  }

  return false;
}

function handleorientnotetracks(var0, var1) {
  switch (var0) {
    case "orient_start":
      if(isDefined(self._blackboard.turnanim) && isDefined(self._blackboard.desiredturnyaw)) {
        var2 = scripts\asm\asm::asm_getxanim(var1, self._blackboard.turnanim);
        var3 = self getanimtime(var2);
        var4 = getangledelta(var2, var3, 1);
        self orientmode("face angle", self._blackboard.desiredturnyaw - var4);
      }

      break;
    default:
      return false;
  }

  return true;
}

function dog_notehandler(var0, var1) {
  if(handledogfootstepnotetracks(var0)) {
    return;
  }

  if(var0 == "sound_dogstep_run_default") {
    self playSound("dogstep_run_default");
    return;
  }

  if(handleorientnotetracks(var0, var1)) {
    return;
  }

  if(var0 == "dog_melee") {
    if(isDefined(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < self.meleerangesq) {
      var2 = 50;

      if(isDefined(self.unarmedmeleedamageoverride)) {
        var2 = self.unarmedmeleedamageoverride;
      }

      self.enemy dodamage(var2, self getEye(), self, self, "MOD_MELEE");
    }

    return;
  }

  var3 = getsubstr(var0, 0, 3);

  if(var3 != "ps_") {
    return;
  }

  var4 = getsubstr(var0, 3);

  if(isalive(self)) {
    thread scripts\engine\sp\utility::play_sound_on_tag_endon_death(var4, "tag_eye");
    return;
  }

  thread scripts\engine\utility::play_sound_in_space(var4, self getEye());
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\dog\move.gsc
***********************************************/

dog_init(var_0, var_1, var_2) {
  self.sharpturnlookaheaddist = 60;
  scripts\asm\shared\utility::getbasearchetype();
  self.asm.customdata = spawnStruct();
  self enabletraversals(0);
  self.soundent = scripts\engine\utility::spawn_tag_origin();
  self.soundent linkTo(self, "tag_eye");
  thread waitfordeath(self.soundent);
}

waitfordeath(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 stopsounds();
    waitframe();
    var_0 delete();
  }
}

needtoturn(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(self.enemy))
    var_4 = self.enemy;
  else if(isDefined(self._blackboard.target))
    var_4 = self._blackboard.target;

  if(!isDefined(var_4))
    return 0;

  var_5 = vectorNormalize(var_4.origin - self.origin);
  var_6 = vectortoyaw(var_5);
  var_7 = angleclamp180(var_6 - self.angles[1]);
  var_8 = var_7 < -35 || var_7 > 35;

  if(var_8)
    self._blackboard.desiredturnyaw = var_6;

  return var_8;
}

needtoturnforexit(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(distance2dsquared(self.origin, self.pathgoalpos) < 4)
    return 0;

  var_4 = vectortoyaw(self.lookaheaddir);
  var_5 = angleclamp180(var_4 - self.angles[1]);
  var_6 = var_5 < -46 || var_5 > 46;

  if(var_6)
    self._blackboard.desiredturnyaw = var_4;

  return var_6;
}

shouldstartarrival(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(isDefined(self.melee))
    return 0;

  if(!scripts\asm\asm::asm_eventfired(var_0, "cover_approach"))
    return 0;

  var_4 = 128;
  var_5 = 96;
  var_6 = self pathdisttogoal();

  if(var_6 > var_4 || var_6 < var_5)
    return 0;

  return 1;
}

chooseanim_arrival(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "2");
}

playanim_arrival(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self animmode("zonly_physics", 0);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_5 = self.pathgoalpos - self.origin;
  var_6 = vectortoyaw(var_5);
  var_7 = getmovedelta(var_4);
  var_8 = getangledelta(var_4);
  var_9 = length(var_5);
  var_10 = length(var_7) / var_9;
  var_11 = self.pathgoalpos;
  var_12 = var_11 - rotatevector(var_7, (0, var_6, 0));
  var_13 = var_6 + var_8;
  var_14 = int(1000 * getanimlength(var_4) - 200);
  self startcoverarrival();
  self motionwarpwithanim(var_12, (0, var_6, 0), var_11, (0, var_13, 0), var_14);
  self.asm.arriving = var_1;
  self aisetanim(var_1, var_3, var_10);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), var_1);
}

playanim_arrival_cleanup(var_0, var_1, var_2) {
  self finishcoverarrival();
  self motionwarpcancel();
}

chooseturnanim(var_0, var_1, var_2) {
  var_3 = angleclamp180(self._blackboard.desiredturnyaw - self.angles[1]);
  var_4 = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  var_5 = getangleindex(var_3);
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4[var_5]);
}

playturnanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  self.useanimgoalweight = 1;
  self._blackboard.turnanim = var_3;
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), var_1);
}

playturnanim_cleanup(var_0, var_1, var_2) {
  self.useanimgoalweight = 0;
  self._blackboard.desiredturnyaw = undefined;
  self._blackboard.turnanim = undefined;
}

playanim_idle(var_0, var_1, var_2) {
  thread playanim_headtrack(var_0, var_1);
  thread playanim_growltrack(var_0, var_1);
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1, 0);
}

playanim_headtrack(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    if(isDefined(self.stealth) && isDefined(self.stealth.bidlecurious) && self.stealth.bidlecurious) {} else {}

    waitframe();
  }
}

playanim_growltrack(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    while(!isDefined(self.stealth) || !isDefined(self.stealth.bgrowl) || !self.stealth.bgrowl)
      waitframe();

    self.soundent playSound("anml_dog_growl", "dog_growl", 1);
    self.soundent waittill("dog_growl");
    waitframe();
  }
}

shouldidlebark(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self.stealth) && isDefined(self.stealth.bbark) && self.stealth.bbark;
  return istrue(self.forcebark) || var_4;
}

notshouldidlebark(var_0, var_1, var_2, var_3) {
  return !shouldidlebark(var_0, var_1, var_2, var_3);
}

playanim_bark(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);

  for(;;) {
    scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), var_1);
    var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
    self aisetanim(var_1, var_3);
  }
}

handledogfootstepnotetracks(var_0) {
  switch (var_0) {
    case "fs_fr_l_sm":
    case "fs_fr_r_sm":
    case "fs_bk_r_sm":
    case "fs_bk_l_sm":
    case "fs_fr_r_lg":
    case "fs_fr_l_lg":
    case "fs_bk_l_lg":
    case "fs_bk_r_lg":
      var_1 = undefined;

      if(isDefined(self.groundtype)) {
        var_1 = self.groundtype;
        self.lastgroundtype = var_1;
      } else if(isDefined(self.lastgroundtype))
        var_1 = self.lastgroundtype;
      else
        var_1 = "dirt";

      if(var_1 != "dirt" && var_1 != "concrete" && var_1 != "wood" && var_1 != "metal")
        var_1 = "dirt";

      if(var_1 == "concrete")
        var_1 = "cement";

      var_2 = self._blackboard.movetype;
      self playSound("dogstep_" + var_2 + "_" + var_1);
      return 1;
  }

  return 0;
}

handleorientnotetracks(var_0, var_1) {
  switch (var_0) {
    case "orient_start":
      if(isDefined(self._blackboard.turnanim) && isDefined(self._blackboard.desiredturnyaw)) {
        var_2 = scripts\asm\asm::asm_getxanim(var_1, self._blackboard.turnanim);
        var_3 = self getanimtime(var_2);
        var_4 = getangledelta(var_2, var_3, 1);
        self orientmode("face angle", self._blackboard.desiredturnyaw - var_4);
      }

      break;
    default:
      return 0;
  }

  return 1;
}

dog_notehandler(var_0, var_1) {
  if(handledogfootstepnotetracks(var_0)) {
    return;
  }
  if(var_0 == "sound_dogstep_run_default")
    self playSound("dogstep_run_default");
  else {
    if(handleorientnotetracks(var_0, var_1)) {
      return;
    }
    if(var_0 == "dog_melee") {
      if(isDefined(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < self.meleerangesq) {
        var_2 = 50;

        if(isDefined(self.unarmedmeleedamageoverride))
          var_2 = self.unarmedmeleedamageoverride;

        self.enemy dodamage(var_2, self getEye(), self, self, "MOD_MELEE");
      }

      return;
    }

    var_3 = getsubstr(var_0, 0, 3);

    if(var_3 != "ps_") {
      return;
    }
    var_4 = getsubstr(var_0, 3);

    if(isalive(self)) {
      thread scripts\engine\sp\utility::play_sound_on_tag_endon_death(var_4, "tag_eye");
      return;
    }

    thread scripts\engine\utility::play_sound_in_space(var_4, self getEye());
  }
}
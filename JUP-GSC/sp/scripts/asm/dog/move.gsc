/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\dog\move.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace move;

function dog_init(asmname, statename, params) {
  self.sharpturnlookaheaddist = 60;
  self getbasearchetype();
  self.asm.customdata = spawnStruct();
  self enabletraversals(0);
  self.soundent = spawn_tag_origin();
  self.soundent linkTo(self, "tag_eye");
  scripts\common\cap::init_cap();
  thread waitfordeath(self.soundent);
}

function waitfordeath(soundent) {
  self waittill("death");

  if(isDefined(soundent)) {
    soundent stopsounds();
    waitframe();
    soundent delete();
  }
}

function needtoturn(asmname, statename, tostatename, params) {
  target = undefined;

  if(isDefined(self.enemy)) {
    target = self.enemy;
  } else if(isDefined(self._blackboard.target)) {
    target = self._blackboard.target;
  }

  if(!isDefined(target)) {
    return 0;
  }

  metotarget = vectorNormalize(target.origin - self.origin);
  desiredyaw = vectortoyaw(metotarget);
  anglediff = angleclamp180(desiredyaw - self.angles[1]);
  bturn = anglediff < -35 || anglediff > 35;

  if(bturn) {
    self._blackboard.desiredturnyaw = desiredyaw;
  }

  return bturn;
}

function needtoturnforexit(asmname, statename, tostatename, params) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(distance2dsquared(self.origin, self.pathgoalpos) < 4) {
    return 0;
  }

  lookaheadyaw = vectortoyaw(self.lookaheaddir);
  anglediff = angleclamp180(lookaheadyaw - self.angles[1]);
  bturn = anglediff < -46 || anglediff > 46;

  if(bturn) {
    self._blackboard.desiredturnyaw = lookaheadyaw;
  }

  return bturn;
}

function shouldstartarrival(asmname, statename, tostatename, params) {
  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  if(self.in_melee) {
    return false;
  }

  if(!asm_eventfired(asmname, "cover_approach")) {
    return false;
  }

  var_c5bad00580f36fb7 = 128;
  var_d3c3e7b6d4058099 = 96;
  var_39d91e399be1c48d = self pathdisttogoal();

  if(var_39d91e399be1c48d > var_c5bad00580f36fb7 || var_39d91e399be1c48d < var_d3c3e7b6d4058099) {
    return false;
  }

  return true;
}

function chooseanim_arrival(asmname, statename, params) {
  return asm_lookupanimfromalias(statename, "2");
}

function playanim_arrival(asmname, statename, params) {
  self endon(statename + "_finished");
  self animmode("zonly_physics", 0);
  arrivalanim = asm_getanim(asmname, statename);
  arrivalxanim = asm_getxanim(statename, arrivalanim);
  var_ca37f3fb87ac82a1 = self.pathgoalpos - self.origin;
  desiredangle = vectortoyaw(var_ca37f3fb87ac82a1);
  animdelta = getmovedelta(arrivalxanim);
  angledelta = getangledelta(arrivalxanim);
  actualdist = length(var_ca37f3fb87ac82a1);
  arrivalrate = length(animdelta) / actualdist;
  goalpos = self.pathgoalpos;
  desiredstartpos = goalpos - rotatevector(animdelta, (0, desiredangle, 0));
  goalyaw = desiredangle + angledelta;
  warpduration = int(1000 * getanimlength(arrivalxanim) - 200);
  self startcoverarrival();
  self motionwarpwithanim(desiredstartpos, (0, desiredangle, 0), goalpos, (0, goalyaw, 0), warpduration);
  self.asm.arriving = statename;
  self aisetanim(statename, arrivalanim, arrivalrate);
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename), statename);
}

function playanim_arrival_cleanup(asmname, statename, params) {
  self finishcoverarrival();
  self motionwarpcancel();
}

function chooseturnanim(asmname, statename, params) {
  assert(isDefined(self._blackboard.desiredturnyaw));
  anglediff = angleclamp180(self._blackboard.desiredturnyaw - self.angles[1]);
  animmap = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
  animindex = getangleindex(anglediff);
  return asm_lookupanimfromalias(statename, animmap[animindex]);
}

function function_5f1dbd8857a878ad(asmname, statename, params) {
  self endon(statename + "_finished");
  turnanim = asm_getanim(asmname, statename);
  self aisetanim(statename, turnanim);
  self.useanimgoalweight = 1;
  self._blackboard.turnanim = turnanim;
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename), statename);
}

function playturnanim_cleanup(asmname, statename, params) {
  self.useanimgoalweight = 0;
  self._blackboard.desiredturnyaw = undefined;
  self._blackboard.turnanim = undefined;
}

function playanim_idle(asmname, statename, params) {
  thread playanim_headtrack(asmname, statename);
  thread playanim_growltrack(asmname, statename);
  function_fb56c9527636713f(asmname, statename, 1, 0);
}

function playanim_headtrack(asmname, statename) {
  self endon(statename + "_finished");

  while(true) {
    if(isDefined(self.stealth) && self.var_d17737f2fb2cea58) {
      assert(isDefined(self.soundent));

      if(utility::issp()) {
        self.soundent playSound("anml_dog_bark_attention", "dog_bark_attention", 1);
      } else {
        self.soundent scripts\engine\utility::playsoundonentity("anml_dog_bark_attention", "dog_bark_attention");
      }

      self.soundent waittill("dog_bark_attention");
    }

    waitframe();
  }
}

function playanim_growltrack(asmname, statename) {
  self endon(statename + "_finished");

  while(true) {
    while(!isDefined(self.stealth) || !isDefined(self.stealth.bgrowl) || !self.stealth.bgrowl) {
      waitframe();
    }

    assert(isDefined(self.soundent));

    if(utility::issp()) {
      self.soundent playSound("anml_dog_growl", "dog_growl", 1);
    } else {
      self.soundent scripts\engine\utility::playsoundonentity("anml_dog_growl", "dog_growl");
    }

    self.soundent waittill("dog_growl");
    waitframe();
  }
}

function shouldidlebark(asmname, statename, tostatename, params) {
  var_8ed21a2d0e7adb3 = isDefined(self.stealth) && isDefined(self.stealth.bbark) && self.stealth.bbark;
  return istrue(self.forcebark) || var_8ed21a2d0e7adb3;
}

function notshouldidlebark(asmname, statename, tostatename, params) {
  return !shouldidlebark(asmname, statename, tostatename, params);
}

function playanim_bark(asmname, statename, params) {
  self endon(statename + "_finished");
  var_ee74db5e2b0c71f6 = asm_getanim(asmname, statename);
  self aisetanim(statename, var_ee74db5e2b0c71f6);

  while(true) {
    asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename), statename);
    var_ee74db5e2b0c71f6 = asm_getanim(asmname, statename);
    self aisetanim(statename, var_ee74db5e2b0c71f6);
  }
}

function handledogfootstepnotetracks(note) {
  switch (note) {
    case #"hash_39938c83dae363ae":
    case #"hash_39968283dae59287":
    case #"hash_504bcbfad9f23e88":
    case #"hash_508da5fada25de19":
    case #"hash_d29ca63665fe050e":
    case #"hash_d2ab9c3666092e43":
    case #"hash_ee8da1e0b86401b0":
    case #"hash_ee919be0b867c9d5":
      groundtype = undefined;

      if(isDefined(self.groundtype)) {
        groundtype = self.groundtype;
        self.lastgroundtype = groundtype;
      } else if(isDefined(self.lastgroundtype)) {
        groundtype = self.lastgroundtype;
      } else {
        groundtype = "dirt";
      }

      if(groundtype != "dirt" && groundtype != "concrete" && groundtype != "wood" && groundtype != "metal") {
        groundtype = "dirt";
      }

      if(groundtype == "concrete") {
        groundtype = "cement";
      }

      movetype = self._blackboard.movetype;
      self playSound("dogstep_" + movetype + "_" + groundtype);
      return true;
  }

  return false;
}

function handleorientnotetracks(note, statename) {
  switch (note) {
    case #"hash_5565eda892be0b23":
      if(isDefined(self._blackboard.turnanim) && isDefined(self._blackboard.desiredturnyaw)) {
        turnxanim = asm_getxanim(statename, self._blackboard.turnanim);
        curanimtime = self aigetanimtime(turnxanim);
        var_cd2871e9e4c4a2ac = getangledelta(turnxanim, curanimtime, 1);
        self orientmode("face angle", self._blackboard.desiredturnyaw - var_cd2871e9e4c4a2ac);
      }

      break;
    default:
      return false;
  }

  return true;
}

function dog_notehandler(note, statename) {
  if(handledogfootstepnotetracks(note)) {
    return;
  }

  if(note == "sound_dogstep_run_default") {
    self playSound("dogstep_run_default");
    return;
  }

  if(handleorientnotetracks(note, statename)) {
    return;
  }

  if(note == "dog_melee") {
    if(isDefined(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < self.meleerangesq) {
      damage = 50;

      if(isDefined(self.unarmedmeleedamageoverride)) {
        damage = self.unarmedmeleedamageoverride;
      }

      self.enemy dodamage(damage, self getEye(), self, self, "MOD_MELEE");
    }

    return;
  }

  prefix = getsubstr(note, 0, 3);

  if(prefix != "ps_") {
    return;
  }

  alias = getsubstr(note, 3);

  if(isalive(self)) {
    thread scripts\engine\utility::playsoundontag(alias, "tag_eye");
    return;
  }

  thread play_sound_in_space(alias, self getEye());
}
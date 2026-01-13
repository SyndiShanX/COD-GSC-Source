/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\zombie_sasquatch\sasquatch_asm.gsc
**********************************************************/

sasquatch_init(var_0, var_1, var_2, var_3) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "left";
  self.asm.var_4C86 = spawnStruct();
  self.sharpturnnotifydist = 24;
  self._blackboard.btreespawn = 0;
  self._blackboard.movetype = "run";
}

sasquatch_playidleanim(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self.isnodeoccupied);
  if(var_4) {
    self orientmode("face enemy");
  } else {
    self orientmode("face angle abs", self.angles);
  }

  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, 1, 0);
}

sas_play_meleeattack(var_0, var_1, var_2, var_3) {
  if(isDefined(self.bt.meleetarget)) {
    thread sasquatch_faceenemyhelper(self.bt.meleetarget, 500, var_1);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

sasquatch_melee_cleanup(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("meleeattack", "end");
}

sasquatch_faceenemyhelper(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2 + "_finished");
  }

  if(isDefined(var_1)) {
    var_3 = gettime() + var_1;
  } else {
    var_3 = -1;
  }

  while((var_3 < 0 || gettime() <= var_3) && isDefined(var_0) && isalive(var_0)) {
    var_4 = var_0.origin - self.origin;
    if(length2dsquared(var_4) > 1024) {
      var_5 = vectortoyaw(var_4);
      self orientmode("face angle abs", (0, var_5, 0));
    }

    wait(0.05);
  }
}

sasquatch_melee_notehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "hit":
      sasquatch_domeleedamage();
      break;
  }
}

sasquatch_domeleedamage() {
  var_0 = 90;
  var_1 = 9216;
  var_2 = 72;
  var_3 = 0.707;
  var_4 = 2304;
  var_5 = 0.174;
  var_6 = anglesToForward(self.angles);
  var_7 = 0;
  foreach(var_9 in level.players) {
    if(!isalive(var_9)) {
      continue;
    }

    var_0A = var_9.origin - self.origin;
    var_0B = lengthsquared(var_0A);
    if(var_0B > var_1) {
      continue;
    }

    if(abs(var_0A[2]) > var_2) {
      continue;
    }

    var_0C = (var_0A[0], var_0A[1], 0);
    var_0A = vectornormalize(var_0C);
    var_0D = vectordot(var_0A, var_6);
    if(var_0B < var_4) {
      if(var_0D < var_5) {
        continue;
      }
    } else if(var_0D < var_3) {
      continue;
    }

    var_7 = 1;
    self notify("attack_hit", var_9);
    scripts\asm\zombie\melee::domeleedamage(var_9, var_0, "MOD_IMPACT");
  }

  if(!var_7) {
    self notify("attack_miss");
  }
}

sas_play_throw(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();
  thread sasquatch_faceenemyhelper(var_4, 1500, var_1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

sas_play_throw_notehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "pickup") {
    return;
  }

  if(var_0 == "throw") {
    if(isDefined(self.rockmodel)) {
      self.rockmodel unlink();
      self.rockmodel delete();
      self.rockmodel = undefined;
    }

    sasquatch_throwrock(scripts\asm\asm_bb::bb_getthrowgrenadetarget());
  }
}

sasquatch_throwrock(var_0) {
  var_1 = self gettagorigin("j_wrist_ri");
  var_2 = undefined;
  if(isDefined(var_0)) {
    var_3 = anglesToForward(self.angles);
    var_4 = var_0.origin - self.origin;
    if(vectordot(var_3, vectornormalize(var_4)) > 0.707) {
      if(isalive(var_0)) {
        var_2 = var_0 getEye();
      } else {
        var_2 = var_0.origin;
      }
    }
  }

  if(!isDefined(var_2)) {
    var_5 = 256;
    var_6 = (cos(20), 0, -1 * sin(20));
    var_2 = var_1 + rotatevector(var_6, self.angles) * var_5;
  }

  var_2 = var_2 + (0, 0, -20);
  magicbullet("iw7_sasq_rock_mp", var_1, var_2, self);
}

sas_play_throw_terminate(var_0, var_1, var_2) {
  if(isDefined(self.rockmodel)) {
    self.rockmodel delete();
  }

  scripts\asm\asm::asm_fireephemeralevent("throwevent", "end");
}

sas_play_rush(var_0, var_1, var_2, var_3) {
  self notify("attack_charge");
  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, 1, 1);
}

sas_play_rush_orienthelper(var_0, var_1) {
  self endon(var_0 + "_finished");
  self orientmode("face motion");
}

sas_play_rushattack_notehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    sasquatch_domeleedamage();
    return;
  }

  if(var_0 == "footstep_left_small") {
    scripts\asm\asm::asm_fireephemeralevent("rushattack", "end");
  }
}

sas_play_rushattack_cleanup(var_0, var_1, var_2) {
  scripts\asm\asm::asm_fireephemeralevent("rushattack", "end");
}

sas_play_traverseexternal(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\mp\agents\_scriptedagents::func_CED4(var_1, var_4, 1);
  var_5 = self _meth_8146();
  self setorigin(var_5);
  self notify("killanimscript");
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

sasq_tauntrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.btauntrequested) && self._blackboard.btauntrequested;
}

sasq_rushrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.brushrequested);
}

sasq_rushnotrequested(var_0, var_1, var_2, var_3) {
  return !sasq_rushrequested(var_0, var_1, var_2, var_3);
}

sasq_rushcomplete(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.brushcomplete) && self._blackboard.brushcomplete;
}

sasq_throwrockrequested(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_throwgrenaderequested();
}
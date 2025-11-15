/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\zombie_sasquatch\sasquatch_asm.gsc
**********************************************************/

sasquatch_init(param_00, param_01, param_02, param_03) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "left";
  self.asm.var_4C86 = spawnStruct();
  self.sharpturnnotifydist = 24;
  self.var_1198.btreespawn = 0;
  self.var_1198.movetype = "run";
}

sasquatch_playidleanim(param_00, param_01, param_02, param_03) {
  var_04 = isDefined(self.isnodeoccupied);
  if(var_04) {
    self orientmode("face enemy");
  } else {
    self orientmode("face angle abs", self.angles);
  }

  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, 1, 0);
}

sas_play_meleeattack(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_3135.meleetarget)) {
    thread sasquatch_faceenemyhelper(self.var_3135.meleetarget, 500, param_01);
  }

  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

sasquatch_melee_cleanup(param_00, param_01, param_02) {
  scripts\asm\asm::asm_fireephemeralevent("meleeattack", "end");
}

sasquatch_faceenemyhelper(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    self endon(param_02 + "_finished");
  }

  if(isDefined(param_01)) {
    var_03 = gettime() + param_01;
  } else {
    var_03 = -1;
  }

  while((var_03 < 0 || gettime() <= var_03) && isDefined(param_00) && isalive(param_00)) {
    var_04 = param_00.origin - self.origin;
    if(length2dsquared(var_04) > 1024) {
      var_05 = vectortoyaw(var_04);
      self orientmode("face angle abs", (0, var_05, 0));
    }

    wait(0.05);
  }
}

sasquatch_melee_notehandler(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "hit":
      sasquatch_domeleedamage();
      break;
  }
}

sasquatch_domeleedamage() {
  var_00 = 90;
  var_01 = 9216;
  var_02 = 72;
  var_03 = 0.707;
  var_04 = 2304;
  var_05 = 0.174;
  var_06 = anglesToForward(self.angles);
  var_07 = 0;
  foreach(var_09 in level.players) {
    if(!isalive(var_09)) {
      continue;
    }

    var_0A = var_09.origin - self.origin;
    var_0B = lengthsquared(var_0A);
    if(var_0B > var_01) {
      continue;
    }

    if(abs(var_0A[2]) > var_02) {
      continue;
    }

    var_0C = (var_0A[0], var_0A[1], 0);
    var_0A = vectornormalize(var_0C);
    var_0D = vectordot(var_0A, var_06);
    if(var_0B < var_04) {
      if(var_0D < var_05) {
        continue;
      }
    } else if(var_0D < var_03) {
      continue;
    }

    var_07 = 1;
    self notify("attack_hit", var_09);
    scripts\asm\zombie\melee::domeleedamage(var_09, var_00, "MOD_IMPACT");
  }

  if(!var_07) {
    self notify("attack_miss");
  }
}

sas_play_throw(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();
  thread sasquatch_faceenemyhelper(var_04, 1500, param_01);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

sas_play_throw_notehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "pickup") {
    return;
  }

  if(param_00 == "throw") {
    if(isDefined(self.rockmodel)) {
      self.rockmodel unlink();
      self.rockmodel delete();
      self.rockmodel = undefined;
    }

    sasquatch_throwrock(scripts\asm\asm_bb::bb_getthrowgrenadetarget());
  }
}

sasquatch_throwrock(param_00) {
  var_01 = self gettagorigin("j_wrist_ri");
  var_02 = undefined;
  if(isDefined(param_00)) {
    var_03 = anglesToForward(self.angles);
    var_04 = param_00.origin - self.origin;
    if(vectordot(var_03, vectornormalize(var_04)) > 0.707) {
      if(isalive(param_00)) {
        var_02 = param_00 getEye();
      } else {
        var_02 = param_00.origin;
      }
    }
  }

  if(!isDefined(var_02)) {
    var_05 = 256;
    var_06 = (cos(20), 0, -1 * sin(20));
    var_02 = var_01 + rotatevector(var_06, self.angles) * var_05;
  }

  var_02 = var_02 + (0, 0, -20);
  magicbullet("iw7_sasq_rock_mp", var_01, var_02, self);
}

sas_play_throw_terminate(param_00, param_01, param_02) {
  if(isDefined(self.rockmodel)) {
    self.rockmodel delete();
  }

  scripts\asm\asm::asm_fireephemeralevent("throwevent", "end");
}

sas_play_rush(param_00, param_01, param_02, param_03) {
  self notify("attack_charge");
  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, 1, 1);
}

sas_play_rush_orienthelper(param_00, param_01) {
  self endon(param_00 + "_finished");
  self orientmode("face motion");
}

sas_play_rushattack_notehandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    sasquatch_domeleedamage();
    return;
  }

  if(param_00 == "footstep_left_small") {
    scripts\asm\asm::asm_fireephemeralevent("rushattack", "end");
  }
}

sas_play_rushattack_cleanup(param_00, param_01, param_02) {
  scripts\asm\asm::asm_fireephemeralevent("rushattack", "end");
}

sas_play_traverseexternal(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED4(param_01, var_04, 1);
  var_05 = self _meth_8146();
  self setorigin(var_05);
  self notify("killanimscript");
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

sasq_tauntrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.btauntrequested) && self.var_1198.btauntrequested;
}

sasq_rushrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.brushrequested);
}

sasq_rushnotrequested(param_00, param_01, param_02, param_03) {
  return !sasq_rushrequested(param_00, param_01, param_02, param_03);
}

sasq_rushcomplete(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.brushcomplete) && self.var_1198.brushcomplete;
}

sasq_throwrockrequested(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_throwgrenaderequested();
}
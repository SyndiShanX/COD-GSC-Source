/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3187.gsc
**************************************/

_id_138E4(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_meleerequested()) {
    return 1;
  }

  return 0;
}

_id_138E0() {
  return 0;
}

_id_138E1() {
  if(!scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!isDefined(self._id_B629)) {
    return 0;
  }

  if(self._id_B629 == "run" || self._id_B629 == "sprint") {
    return 1;
  }

  return 0;
}

shouldplayarenaintro() {
  if(isDefined(self.agent_type) && self.agent_type == "zombie_brute") {
    return 0;
  }

  if(isDefined(self.enemy) && self.enemy.health < 91) {
    return 0;
  }

  if(isDefined(level.wave_num) && level.wave_num < 10) {
    return 0;
  }

  var_0 = _id_0C72::_id_9EA5();
  var_1 = _id_0C72::_id_9EA4();
  var_2 = !(var_1 || var_0);
  var_3 = randomint(100) < 2;
  return var_2 && var_3;
}

_id_3EB9(var_0, var_1, var_2) {
  var_3 = _id_0C72::_id_9EA5();
  var_4 = _id_0C72::_id_9EA4();
  var_5 = var_3 && var_4;
  var_6 = !(var_4 || var_3);
  var_7 = self getanimentrycount(var_1);

  if(var_6) {
    return randomint(var_7);
  }

  if(var_5) {
    return 0;
  }

  var_8 = int(var_7 / 2);

  if(var_3) {
    return randomint(var_8);
  }

  return var_8 + randomint(var_8);
}

_id_D4C8(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = _id_81F1(self.curmeleetarget, 1);
  _id_57E5(var_0, var_1, self.curmeleetarget, var_4, 1, 1, self._id_C081, 1);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_D4DC(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = scripts\asm\asm_bb::bb_getmeleetarget();
  self._id_B629 = undefined;
  var_5 = _id_81F1(var_4, 1);
  self._id_CA1C = 1;
  self.aistate = "melee";
  _id_57E5(var_0, var_1, var_4, var_5, 0, 1, self._id_C081);
  self.aistate = "move";
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_D539(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = scripts\asm\asm_bb::bb_getmeleetarget();
  var_5 = _id_81F1(var_4, 1);
  self.aistate = "melee";
  _id_57E5(var_0, var_1, var_4, var_5, 0, 1, self._id_C081);
  self.aistate = "idle";
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_CC64(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = scripts\asm\asm_bb::bb_getmeleetarget();
  var_5 = _id_81F1(var_4, 1);
  self.aistate = "melee";
  _id_57E5(var_0, var_1, var_4, var_5, 0, 1, self._id_C081, 0, 1);
  self.aistate = "idle";
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_2989(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_3134) && self._blackboard._id_3134;
}

_id_138E5() {
  if(_id_2989()) {
    return 1;
  }

  return 0;
}

_id_138E6() {
  return scripts\engine\utility::is_true(self.should_play_transformation_anim);
}

_id_D543(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");

  if(isDefined(self.agent_type) && self.agent_type == "skater") {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_skater_pre_explo");
  } else {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_clown_pre_explo");
  }

  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\anim\notetracks_mp::_id_CED2(var_1, var_4, 2.0, var_1, "explode");

  if(isDefined(self.agent_type) && self.agent_type != "skater") {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_vo_clown_death");
  }

  wait 0.25;
  self stopsounds();
  self.nocorpse = 1;
  self suicide();
}

_id_D553(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  self.should_play_transformation_anim = undefined;
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\anim\notetracks_mp::_id_CED5(var_1, var_4, var_1);
}

_id_6A6A(var_0, var_1) {
  self endon(var_0 + "_finished");
  self notify("stop_melee_face_enemy");
  self endon("stop_melee_face_enemy");

  for(;;) {
    if(isDefined(var_1) && isalive(var_1)) {
      self orientmode("face angle abs", (0, vectortoyaw(var_1.origin - self.origin), 0));
    } else {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1106E() {
  self notify("stop_melee_face_enemy");
}

_id_57E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon(var_1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self._id_A9B6 = undefined;
  self._id_A9B7 = undefined;

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  var_9 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_10 = self getanimentry(var_1, var_9);
  var_11 = getanimlength(var_10);
  var_12 = getnotetracktimes(var_10, "hit");
  var_13 = var_11 / var_6 * 0.33;

  if(var_12.size > 0) {
    var_13 = var_11 / var_6 * var_12[0];
  }

  var_14 = getnotetracktimes(var_10, "finish");
  var_15 = 0.9;

  if(var_14.size > 0) {
    var_15 = var_14[0];
  } else {
    var_15 = 0.9;
  }

  var_16 = var_11 / var_6 * var_15;
  self scragentsetphysicsmode("gravity");

  if(var_5 && isDefined(self.enemy)) {
    thread _id_6A6A(var_1, self.enemy);
  } else if(isDefined(var_2)) {
    self orientmode("face angle abs", (0, vectortoyaw(var_2.origin - self.origin), 0));
  } else {
    self orientmode("face angle abs", self.angles);
  }

  self _meth_8281("anim deltas");
  scripts\anim\notetracks_mp::_id_F2B1(var_1, var_9, var_6);

  if(var_7) {
    var_17 = getnotetracktimes(var_10, "lunge_start");
    var_18 = 0;

    if(var_17.size > 0) {
      var_18 = var_11 / var_6 * var_17[0];
    }

    var_13 = var_13 - var_18;

    if(var_18 > 0) {
      wait(var_18);
    }

    if(self._id_B0FC) {
      var_19 = var_3 - self.origin;
      var_20 = getmovedelta(var_10, var_17[0], var_12[0]);
      var_21 = scripts\anim\notetracks_mp::_id_7DC9(var_19, var_20);
      var_6 = var_6 * clamp(1 / var_21._id_13E2B, 0.5, 1);
      var_13 = var_11 / var_6 * var_12[0] - var_11 / var_6 * var_17[0];
      scripts\anim\notetracks_mp::_id_F2B1(var_1 + "_norestart", var_9, var_6);
    }
  }

  if(var_4) {
    self scragentsetanimscale(0, 1);
    self _meth_827B(self.origin, var_3, var_13);
    childthread _id_12EC0(var_2, var_13, 1, self._id_B101);
    scripts\anim\notetracks_mp::setstatelocked(1, "DoAttack");
  } else
    self scragentsetanimscale(1, 1);

  wait(var_13);
  scripts\asm\asm_bb::bb_clearmeleerequest();
  self notify("cancel_updatelerppos");

  if(var_5 && isDefined(self.enemy)) {
    thread _id_6A6A(var_1, self.enemy);
  } else {
    _id_1106E();

    if(isDefined(var_2)) {
      self orientmode("face angle abs", (0, vectortoyaw(var_2.origin - self.origin), 0));
    } else {
      self orientmode("face angle abs", self.angles);
    }
  }

  self _meth_8281("anim deltas");
  self scragentsetanimscale(1, 1);

  if(var_4) {
    scripts\anim\notetracks_mp::setstatelocked(0, "DoAttack");
  }

  if(_id_252F(var_2)) {
    self notify("attack_hit", var_2, var_3);
    var_22 = 0;

    if(isDefined(var_2)) {
      var_22 = get_melee_damage_dealt();
    }

    if(isDefined(self._id_B601)) {
      var_22 = self._id_B601;
    }

    if(isDefined(var_8)) {
      thread _id_F08D(var_2, var_3, 0.5);
    }

    if(isalive(var_2)) {
      domeleedamage(var_2, var_22, "MOD_IMPACT");
    }

    level notify("attack_hit", self, var_2);
  } else
    self notify("attack_miss", var_2, var_3);

  self._id_A9B9 = self.origin;
  var_23 = var_16 - var_13;

  if(var_23 > 0) {
    scripts\anim\notetracks_mp::_id_1384D(var_1, "end", var_23);
  }

  self._id_A9B8 = gettime();
}

_id_F08D(var_0, var_1, var_2) {
  self endon("death");
  wait(var_2);

  if(_id_252F(var_0)) {
    self notify("attack_hit", var_0, var_1);
    var_3 = 0;

    if(isDefined(var_0)) {
      var_3 = get_melee_damage_dealt();
    }

    if(isDefined(self._id_B601)) {
      var_3 = self._id_B601;
    }

    if(isalive(var_0)) {
      domeleedamage(var_0, var_3, "MOD_IMPACT");
    }

    level notify("attack_hit", self, var_0);
  } else
    self notify("attack_miss", var_0, var_1);
}

get_melee_damage_dealt() {
  if(self.agent_type == "zombie_brute") {
    return 90;
  }

  return 45;
}

domeleedamage(var_0, var_1, var_2) {
  if(scripts\engine\utility::isprotectedbyriotshield(var_0)) {
    return;
  }
  if(isPlayer(var_0)) {
    if(var_0 scripts\engine\utility::isprotectedbyaxeblock(self)) {
      return;
    }
  }

  var_0 dodamage(var_1, self.origin, self, self, var_2);
}

_id_12EC0(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_4 = self.origin;
  var_5 = var_1;
  var_6 = 0.05;

  for(;;) {
    wait(var_6);
    var_5 = var_5 - var_6;

    if(var_5 <= 0) {
      break;
    }

    var_7 = _id_81F1(var_0, var_2);

    if(!isDefined(var_7)) {
      break;
    }

    if(isDefined(var_3)) {
      var_8 = var_3;
    } else {
      var_8 = scripts\mp\agents\zombie\zombie_util::_id_7FAE() - self.radius;
    }

    var_9 = var_7 - var_4;

    if(lengthsquared(var_9) > var_8 * var_8) {
      var_7 = var_4 + vectorNormalize(var_9) * var_8;
    }

    self orientmode("face enemy");
    self _meth_827B(self.origin, var_7, var_5);
  }
}

_id_81F1(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!var_1) {
    var_2 = scripts\anim\notetracks_mp::_id_5D51(var_0.origin);
    return var_2;
  } else {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < self._id_252B) {
      return self.origin;
    } else {
      var_3 = var_3 / var_4;
      var_5 = scripts\mp\agents\zombie\zombie_util::_id_7FAA(var_0);

      if(scripts\mp\agents\zombie\zombie_util::_id_38C2(self.origin, var_5.origin)) {
        return var_5.origin;
      } else {
        return undefined;
      }
    }
  }
}

_id_252F(var_0) {
  if(!isalive(var_0)) {
    return 0;
  }

  if(!_id_13D99()) {
    return 0;
  }

  if(isPlayer(var_0) || isai(var_0)) {
    if(scripts\engine\utility::is_true(self._id_29D2) && !scripts\engine\utility::is_true(self.dismember_crawl)) {
      var_1 = [];
      var_1[0] = self;
      var_2 = self getEye() - (0, 0, 16);
      var_3 = var_0 getEye() - (0, 0, 16);
      var_4 = scripts\common\trace::sphere_trace(var_2, var_3, 4, var_1);

      if(var_4["fraction"] < 1) {
        var_5 = var_4["entity"];

        if(isDefined(var_5) && isai(var_5)) {
          if(isDefined(var_5.team) && var_5.team == self.team) {
            if(distance(self.origin, var_5.origin) > 12) {
              return 0;
            }
          }
        }
      }
    }
  }

  if(isenemyinfrontofme(var_0, self.meleedot)) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::_id_9DE0(var_0)) {
    return 1;
  }

  return 0;
}

isenemyinfrontofme(var_0, var_1) {
  var_2 = vectorNormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);
  return var_4 > var_1;
}

_id_13D99() {
  var_0 = self.entered_playspace;

  if(isDefined(self.enemy) && !ispointonnavmesh(self.enemy.origin) && !scripts\asm\asm_bb::bb_moverequested()) {
    if(scripts\mp\agents\zombie\zombie_util::_id_DD7C("offmesh", var_0)) {
      return 1;
    }
  }

  if(!scripts\mp\agents\zombie\zombie_util::_id_DD7C("normal", var_0)) {
    return 0;
  }

  if(scripts\mp\agents\zombie\zombie_util::_id_7FAE() > self._id_B62E && !scripts\mp\agents\zombie\zombie_util::_id_13D9B()) {
    return 0;
  }

  return 1;
}
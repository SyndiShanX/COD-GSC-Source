/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3187.gsc
************************/

func_138E4(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_meleerequested()) {
    return 1;
  }

  return 0;
}

func_138E0() {
  return 0;
}

func_138E1() {
  if(!scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!isDefined(self.var_B629)) {
    return 0;
  }

  if(self.var_B629 == "run" || self.var_B629 == "sprint") {
    return 1;
  }

  return 0;
}

shouldplayarenaintro() {
  if(isDefined(self.agent_type) && self.agent_type == "zombie_brute") {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && self.isnodeoccupied.health < 91) {
    return 0;
  }

  if(isDefined(level.wave_num) && level.wave_num < 10) {
    return 0;
  }

  var_00 = lib_0C72::func_9EA5();
  var_01 = lib_0C72::func_9EA4();
  var_02 = !var_01 || var_00;
  var_03 = randomint(100) < 2;
  return var_02 && var_03;
}

func_3EB9(param_00, param_01, param_02) {
  var_03 = lib_0C72::func_9EA5();
  var_04 = lib_0C72::func_9EA4();
  var_05 = var_03 && var_04;
  var_06 = !var_04 || var_03;
  var_07 = self getanimentrycount(param_01);
  if(var_06) {
    return randomint(var_07);
  }

  if(var_05) {
    return 0;
  }

  var_08 = int(var_07 / 2);
  if(var_03) {
    return randomint(var_08);
  }

  return var_08 + randomint(var_08);
}

func_D4C8(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = makeentitysentient(self.curmeleetarget, 1);
  func_57E5(param_00, param_01, self.curmeleetarget, var_04, 1, 1, self.var_C081, 1);
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_D4DC(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = scripts\asm\asm_bb::bb_getmeleetarget();
  self.var_B629 = undefined;
  var_05 = makeentitysentient(var_04, 1);
  self.var_CA1C = 1;
  self.aistate = "melee";
  func_57E5(param_00, param_01, var_04, var_05, 0, 1, self.var_C081);
  self.aistate = "move";
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_D539(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = scripts\asm\asm_bb::bb_getmeleetarget();
  var_05 = makeentitysentient(var_04, 1);
  self.aistate = "melee";
  func_57E5(param_00, param_01, var_04, var_05, 0, 1, self.var_C081);
  self.aistate = "idle";
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_CC64(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = scripts\asm\asm_bb::bb_getmeleetarget();
  var_05 = makeentitysentient(var_04, 1);
  self.aistate = "melee";
  func_57E5(param_00, param_01, var_04, var_05, 0, 1, self.var_C081, 0, 1);
  self.aistate = "idle";
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_2989(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.var_3134) && self.var_1198.var_3134;
}

func_138E5() {
  if(func_2989()) {
    return 1;
  }

  return 0;
}

func_138E6() {
  return scripts\engine\utility::istrue(self.should_play_transformation_anim);
}

func_D543(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(param_01 + "_finished");
  if(isDefined(self.agent_type) && self.agent_type == "skater") {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_skater_pre_explo");
  } else {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_clown_pre_explo");
  }

  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04, 2, param_01, "explode");
  if(isDefined(self.agent_type) && self.agent_type != "skater") {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_vo_clown_death");
  }

  wait(0.25);
  self stopsounds();
  self.nocorpse = 1;
  self suicide();
}

func_D553(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(param_01 + "_finished");
  self.should_play_transformation_anim = undefined;
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED5(param_01, var_04, param_01);
}

func_6A6A(param_00, param_01) {
  self endon(param_00 + "_finished");
  self notify("stop_melee_face_enemy");
  self endon("stop_melee_face_enemy");
  for(;;) {
    if(isDefined(param_01) && isalive(param_01)) {
      self orientmode("face angle abs", (0, vectortoyaw(param_01.origin - self.origin), 0));
    } else {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_1106E() {
  self notify("stop_melee_face_enemy");
}

func_57E5(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon(param_01 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self.var_A9B6 = undefined;
  self.var_A9B7 = undefined;
  if(!isDefined(param_07)) {
    param_07 = 0;
  }

  var_09 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_0A = self getsafecircleorigin(param_01, var_09);
  var_0B = getanimlength(var_0A);
  var_0C = getnotetracktimes(var_0A, "hit");
  var_0D = var_0B / param_06 * 0.33;
  if(var_0C.size > 0) {
    var_0D = var_0B / param_06 * var_0C[0];
  }

  var_0E = getnotetracktimes(var_0A, "finish");
  var_0F = 0.9;
  if(var_0E.size > 0) {
    var_0F = var_0E[0];
  } else {
    var_0F = 0.9;
  }

  var_10 = var_0B / param_06 * var_0F;
  self gib_fx_override("gravity");
  if(param_05 && isDefined(self.isnodeoccupied)) {
    thread func_6A6A(param_01, self.isnodeoccupied);
  } else if(isDefined(param_02)) {
    self orientmode("face angle abs", (0, vectortoyaw(param_02.origin - self.origin), 0));
  } else {
    self orientmode("face angle abs", self.angles);
  }

  self ghostlaunched("anim deltas");
  scripts\mp\agents\_scriptedagents::func_F2B1(param_01, var_09, param_06);
  if(param_07) {
    var_11 = getnotetracktimes(var_0A, "lunge_start");
    var_12 = 0;
    if(var_11.size > 0) {
      var_12 = var_0B / param_06 * var_11[0];
    }

    var_0D = var_0D - var_12;
    if(var_12 > 0) {
      wait(var_12);
    }

    if(self.var_B0FC) {
      var_13 = param_03 - self.origin;
      var_14 = getmovedelta(var_0A, var_11[0], var_0C[0]);
      var_15 = scripts\mp\agents\_scriptedagents::func_7DC9(var_13, var_14);
      param_06 = param_06 * clamp(1 / var_15.var_13E2B, 0.5, 1);
      var_0D = var_0B / param_06 * var_0C[0] - var_0B / param_06 * var_11[0];
      scripts\mp\agents\_scriptedagents::func_F2B1(param_01 + "_norestart", var_09, param_06);
    }
  }

  if(param_04) {
    self scragentsetanimscale(0, 1);
    self ghostexplode(self.origin, param_03, var_0D);
    childthread func_12EC0(param_02, var_0D, 1, self.var_B101);
    scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoAttack");
  } else {
    self scragentsetanimscale(1, 1);
  }

  wait(var_0D);
  scripts\asm\asm_bb::bb_clearmeleerequest();
  self notify("cancel_updatelerppos");
  if(param_05 && isDefined(self.isnodeoccupied)) {
    thread func_6A6A(param_01, self.isnodeoccupied);
  } else {
    func_1106E();
    if(isDefined(param_02)) {
      self orientmode("face angle abs", (0, vectortoyaw(param_02.origin - self.origin), 0));
    } else {
      self orientmode("face angle abs", self.angles);
    }
  }

  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  if(param_04) {
    scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoAttack");
  }

  if(func_252F(param_02)) {
    self notify("attack_hit", param_02, param_03);
    var_16 = 0;
    if(isDefined(param_02)) {
      var_16 = get_melee_damage_dealt();
    }

    if(isDefined(self.var_B601)) {
      var_16 = self.var_B601;
    }

    if(isDefined(param_08)) {
      thread func_F08D(param_02, param_03, 0.5);
    }

    if(isalive(param_02)) {
      domeleedamage(param_02, var_16, "MOD_IMPACT");
    }

    level notify("attack_hit", self, param_02);
  } else {
    self notify("attack_miss", param_02, param_03);
  }

  self.var_A9B9 = self.origin;
  var_17 = var_10 - var_0D;
  if(var_17 > 0) {
    scripts\mp\agents\_scriptedagents::func_1384D(param_01, "end", var_17);
  }

  self.var_A9B8 = gettime();
}

func_F08D(param_00, param_01, param_02) {
  self endon("death");
  wait(param_02);
  if(func_252F(param_00)) {
    self notify("attack_hit", param_00, param_01);
    var_03 = 0;
    if(isDefined(param_00)) {
      var_03 = get_melee_damage_dealt();
    }

    if(isDefined(self.var_B601)) {
      var_03 = self.var_B601;
    }

    if(isalive(param_00)) {
      domeleedamage(param_00, var_03, "MOD_IMPACT");
    }

    level notify("attack_hit", self, param_00);
    return;
  }

  self notify("attack_miss", param_00, param_01);
}

get_melee_damage_dealt() {
  if(self.agent_type == "zombie_brute") {
    return 90;
  }

  return 45;
}

domeleedamage(param_00, param_01, param_02) {
  if(scripts\engine\utility::isprotectedbyriotshield(param_00)) {
    return;
  }

  if(isplayer(param_00)) {
    if(param_00 scripts\engine\utility::isprotectedbyaxeblock(self)) {
      return;
    }
  }

  param_00 dodamage(param_01, self.origin, self, self, param_02);
}

func_12EC0(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  param_00 endon("disconnect");
  param_00 endon("death");
  var_04 = self.origin;
  var_05 = param_01;
  var_06 = 0.05;
  for(;;) {
    wait(var_06);
    var_05 = var_05 - var_06;
    if(var_05 <= 0) {
      break;
    }

    var_07 = makeentitysentient(param_00, param_02);
    if(!isDefined(var_07)) {
      break;
    }

    if(isDefined(param_03)) {
      var_08 = param_03;
    } else {
      var_08 = scripts\mp\agents\zombie\zombie_util::func_7FAE() - self.fgetarg;
    }

    var_09 = var_07 - var_04;
    if(lengthsquared(var_09) > var_08 * var_08) {
      var_07 = var_04 + vectornormalize(var_09) * var_08;
    }

    self orientmode("face enemy");
    self ghostexplode(self.origin, var_07, var_05);
  }
}

makeentitysentient(param_00, param_01) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  if(!param_01) {
    var_02 = scripts\mp\agents\_scriptedagents::func_5D51(param_00.origin);
    return var_02;
  }

  var_03 = param_01.origin - self.origin;
  var_04 = length(var_03);
  if(var_04 < self.var_252B) {
    return self.origin;
  }

  var_03 = var_03 / var_04;
  var_05 = scripts\mp\agents\zombie\zombie_util::func_7FAA(param_01);
  if(scripts\mp\agents\zombie\zombie_util::func_38C2(self.origin, var_05.origin)) {
    return var_05.origin;
  }

  return undefined;
}

func_252F(param_00) {
  if(!isalive(param_00)) {
    return 0;
  }

  if(!func_13D99()) {
    return 0;
  }

  if(isplayer(param_00) || isai(param_00)) {
    if(scripts\engine\utility::istrue(self.var_29D2) && !scripts\engine\utility::istrue(self.dismember_crawl)) {
      var_01 = [];
      var_01[0] = self;
      var_02 = self getEye() - (0, 0, 16);
      var_03 = param_00 getEye() - (0, 0, 16);
      var_04 = scripts\common\trace::sphere_trace(var_02, var_03, 4, var_01);
      if(var_04["fraction"] < 1) {
        var_05 = var_04["entity"];
        if(isDefined(var_05) && isai(var_05)) {
          if(isDefined(var_05.team) && var_05.team == self.team) {
            if(distance(self.origin, var_05.origin) > 12) {
              return 0;
            }
          }
        }
      }
    }
  }

  if(isenemyinfrontofme(param_00, self.meleedot)) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_9DE0(param_00)) {
    return 1;
  }

  return 0;
}

isenemyinfrontofme(param_00, param_01) {
  var_02 = vectornormalize(param_00.origin - self.origin * (1, 1, 0));
  var_03 = anglesToForward(self.angles);
  var_04 = vectordot(var_02, var_03);
  return var_04 > param_01;
}

func_13D99() {
  var_00 = self.entered_playspace;
  if(isDefined(self.isnodeoccupied) && !ispointonnavmesh(self.isnodeoccupied.origin) && !scripts\asm\asm_bb::bb_moverequested()) {
    if(scripts\mp\agents\zombie\zombie_util::func_DD7C("offmesh", var_00)) {
      return 1;
    }
  }

  if(!scripts\mp\agents\zombie\zombie_util::func_DD7C("normal", var_00)) {
    return 0;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_7FAE() > self.var_B62E && !scripts\mp\agents\zombie\zombie_util::func_13D9B()) {
    return 0;
  }

  return 1;
}
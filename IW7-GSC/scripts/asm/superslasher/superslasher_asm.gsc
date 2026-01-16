/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\superslasher\superslasher_asm.gsc
*********************************************************/

superslasher_init(var_0, var_1, var_2, var_3) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "left";
  self.asm.footsteps.time = gettime();
  self.asm.var_4C86 = spawnStruct();
  self.despawncovernode = 32;
  self.sharpturnnotifydist = 160;
  var_4 = self getsafecircleorigin("jump_to_roof", 0);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta(var_4);
  level.superslasherjumptoroofangles = (0, angleclamp180(level.superslasherrooftopangles[1] - 180 - var_6), 0);
  level.superslashergotogroundspot = level.superslasherrooftopspot - rotatevector(var_5, level.superslasherjumptoroofangles);
}

ss_play(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(!isDefined(var_4)) {
    var_4 = scripts\asm\asm::func_2341(var_0, var_1);
  }

  scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_5, self.moveratescale, var_1, "end", var_4);
}

superslasher_playmoveloop(var_0, var_1, var_2, var_3) {
  self._blackboard.bmoving = 1;
  scripts\asm\shared\mp\move_v2::playmoveloopv2(var_0, var_1, var_2, var_3);
}

superslasher_playmoveloop_clean(var_0, var_1, var_2, var_3) {
  self._blackboard.bmoving = undefined;
}

ss_play_groundidle(var_0, var_1, var_2, var_3) {
  self._blackboard.bidle = 1;
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

ss_play_groundidle_clean(var_0, var_1, var_2) {
  self._blackboard.bidle = undefined;
}

ss_play_roofidle(var_0, var_1, var_2, var_3) {
  self gib_fx_override("noclip");
  self orientmode("face angle abs", level.superslasherrooftopangles);
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

ss_play_rooftaunt(var_0, var_1, var_2, var_3) {
  self gib_fx_override("noclip");
  self orientmode("face angle abs", level.superslasherrooftopangles);
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

ss_play_rooftaunt_clean(var_0, var_1, var_2) {
  self gib_fx_override("gravity");
}

ss_play_jumptoground(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._blackboard.buninterruptibleanim = 1;
  self ghostlaunched("anim deltas");
  self gib_fx_override("noclip");
  thread ss_play_jtog_waitmigrate(var_1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

ss_play_jtog_waitmigrate(var_0) {
  self endon(var_0 + "_finished");
  level waittill("host_migration_begin");
  self._blackboard.bjumptogroundborked = 1;
}

ss_play_jumptoground_clean(var_0, var_1, var_2) {
  self scragentsetanimscale(1, 1);
  self gib_fx_override("gravity");
  self._blackboard.buninterruptibleanim = undefined;
  if(isDefined(self._blackboard.bjumptogroundborked) || self.origin[2] > -116) {
    self setorigin(level.superslashergotogroundspot + (0, 0, 24));
    self._blackboard.bjumptogroundborked = undefined;
  }
}

ss_play_jumptoground_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "land") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
  }
}

ss_play_jumpscale(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - self.origin;
  var_6 = vectortoangles((var_5[0], var_5[1], 0));
  if(isDefined(var_3)) {
    var_7 = getmovedelta(var_3);
    var_4 = var_4 - rotatevector(var_7, var_6);
    var_5 = var_4 - self.origin;
  }

  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", var_6);
  self gib_fx_override("noclip");
  var_8 = getmovedelta(var_2);
  var_9 = length2d(var_8);
  var_10 = length2d(var_5);
  var_11 = var_10 / var_9;
  var_12 = max(var_5[2] / var_8[2], 0);
  var_13 = 1;
  self scragentsetanimscale(var_11, var_12);
  scripts\mp\agents\_scriptedagents::func_CED2(var_0, var_1, var_13, var_0, "end");
}

ss_play_jumptoroof(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self._blackboard.buninterruptibleanim = 1;
  var_4 = level.superslasherrooftopspot;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_6 = self getsafecircleorigin(var_1, var_5);
  var_7 = level.superslasherjumptoroofangles;
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", var_7);
  self gib_fx_override("noclip");
  thread ss_play_jtog_waitmigrate(var_1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

ss_play_jumptoroof_clean(var_0, var_1, var_2) {
  self gib_fx_override("gravity");
  self._blackboard.buninterruptibleanim = undefined;
  if(isDefined(self._blackboard.bjumptogroundborked) || self.origin[2] < 340) {
    self setorigin(level.superslasherrooftopspot);
    self._blackboard.bjumptogroundborked = undefined;
  }

  if(scripts\asm\asm::func_232B(var_1, "end")) {
    self.asm.turndata = spawnStruct();
    self.asm.turndata = angleclamp180(level.superslasherrooftopangles[1] - self.angles[1]);
  }
}

ss_play_groundpound(var_0, var_1, var_2, var_3) {
  self playsoundonmovingent("zmb_vo_supslasher_attack_ground_pound");
  ss_play(var_0, var_1, var_2, var_3, ::ss_play_groundpound_nt);
}

ss_play_groundpound_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
  }
}

ss_play_summonsawblades(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread scripts\asm\superslasher\superslasher_actions::superslasher_dosummonedsawblades();
  ss_play(var_0, var_1, var_2, var_3);
}

ss_play_sawcharge_start(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(isDefined(self._blackboard.throwsawchargetime)) {
    var_5 = self getsafecircleorigin(var_1, var_4);
    var_6 = getanimlength(var_5);
    self._blackboard.throwsawchargelooptime = max(self._blackboard.throwsawchargetime - var_6, 0);
  }

  var_7 = scripts\asm\asm::func_2341(var_0, var_1);
  scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_4, self.moveratescale, var_1, "end", var_7);
}

ss_play_sawcharge_start_clean(var_0, var_1, var_2) {
  self._blackboard.throwsawchargetime = undefined;
}

ss_play_sawcharge(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  thread lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
  wait(self._blackboard.throwsawchargelooptime);
  scripts\asm\asm::asm_fireevent(var_1, "saw_charge_loop_complete");
}

ss_play_sawcharge_clean(var_0, var_1, var_2) {
  self._blackboard.throwsawchargelooptime = undefined;
}

ss_play_throwsaw(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = 1;
  self.throwsawprevturnspeed = self ghosthover();
  if(isDefined(self._blackboard.throwsawtarget)) {
    thread superslasher_faceenemyhelper(self._blackboard.throwsawtarget, var_4 * 1000, var_1);
  }

  ss_play(var_0, var_1, var_2, var_3, ::ss_play_throwsaw_nt);
}

ss_play_throwsaw_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "throw") {
    scripts\asm\superslasher\superslasher_actions::superslasher_dothrownsaw();
  }
}

ss_play_throwsaw_clean(var_0, var_1, var_2) {
  self ghostskullstimestart(self.throwsawprevturnspeed);
  self.throwsawprevturnspeed = undefined;
}

ss_play_throwsawfan_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "throw") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dosawfan();
  }
}

ss_play_summon(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\mp\agents\_scriptedagents::func_CED1(var_1, var_4, self.moveratescale, 2 / self.moveratescale);
  thread scripts\asm\superslasher\superslasher_actions::superslasher_summonminions(var_3);
  scripts\mp\agents\_scriptedagents::func_1384C(var_1, "end", var_1, var_4);
}

ss_play_wires(var_0, var_1, var_2, var_3) {
  thread scripts\asm\superslasher\superslasher_actions::superslasher_domaskchange(1, "roof");
  ss_play(var_0, var_1, var_2, undefined);
}

ss_play_shockwave_start(var_0, var_1, var_2, var_3) {
  self playsoundonmovingent("zmb_vo_supslasher_attack_shockwave_build_start");
  self orientmode("face angle abs", level.superslasherrooftopangles);
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

ss_play_shockwave_loop(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  self playsoundonmovingent("zmb_vo_supslasher_attack_shockwave_build");
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self setanimstate(var_1, var_5, self.moveratescale);
  wait(var_4);
  scripts\asm\asm::asm_fireevent(var_1, "shockwave_loop_complete");
}

ss_play_shockwave_finish(var_0, var_1, var_2, var_3) {
  ss_play(var_0, var_1, var_2, undefined, ::ss_play_shockwave_nt);
}

ss_play_shockwave_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    thread scripts\asm\superslasher\superslasher_actions::domaskattack(0, "roof");
  }
}

ss_play_summonsharks(var_0, var_1, var_2, var_3) {
  self playsoundonmovingent("zmb_vo_supslasher_attack_summon");
  thread scripts\asm\superslasher\superslasher_actions::superslasher_domaskchange(2, "ground");
  ss_play(var_0, var_1, var_2, undefined);
}

ss_play_trapped(var_0, var_1, var_2, var_3) {
  thread func_126BB(var_1, self._blackboard.trapduration);
  self playsoundonmovingent("zmb_vo_supslasher_pain");
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

func_126BB(var_0, var_1) {
  self endon(var_0 + "_finished");
  wait(var_1);
  scripts\asm\asm::asm_fireevent(var_0, "trap_end");
}

ss_play_trapped_clean(var_0, var_1, var_2) {
  self._blackboard.trapduration = undefined;
  self._blackboard.btraprequested = undefined;
}

ss_play_jumpmove_start(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._blackboard.jumptargetpos;
  thread scripts\asm\superslasher\superslasher_actions::dogroundjumpattackfx(var_4);
  var_5 = var_4 - self.origin;
  var_6 = vectortoangles((var_5[0], var_5[1], 0));
  var_7 = length(var_5);
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", var_6);
  self gib_fx_override("noclip");
  self scragentsetanimscale(1, 3);
  self playsoundonmovingent("zmb_vo_supslasher_jump");
  ss_play(var_0, var_1, var_2, var_3);
}

ss_play_jumpmove_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "takeoff") {
    self._blackboard.binair = 1;
    return;
  }

  if(var_0 == "land") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
    self._blackboard.binair = undefined;
    scripts\asm\superslasher\superslasher_actions::groundjumpattackfxcleanup();
    self playsoundonmovingent("zmb_vo_supslasher_attack_land");
  }
}

func_A4DA() {
  self._blackboard.binair = undefined;
  scripts\asm\superslasher\superslasher_actions::groundjumpattackfxcleanup();
  self._blackboard.jumptargetpos = undefined;
  self gib_fx_override("gravity");
  self scragentsetanimscale(1, 1);
}

ss_play_jumpmove_start_clean(var_0, var_1, var_2) {
  self scragentsetanimscale(1, 1);
  if(!scripts\asm\asm::func_232B(var_1, "end")) {
    func_A4DA();
  }
}

ss_play_jumpmove(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._blackboard.jumptargetpos;
  self._blackboard.buninterruptibleanim = 1;
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_6 = self getsafecircleorigin(var_1, var_5);
  var_7 = scripts\asm\asm_mp::func_235A(var_1, "end");
  var_8 = self getsafecircleorigin(var_1, var_7);
  self._blackboard.binair = 1;
  ss_play_jumpscale(var_1, var_5, var_6, var_8, var_4);
}

ss_play_jumpmove_clean(var_0, var_1, var_2) {
  self._blackboard.buninterruptibleanim = undefined;
  if(!scripts\asm\asm::func_232B(var_1, "end")) {
    func_A4DA();
  }
}

ss_play_jumpmove_end(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getmovedelta(var_5);
  var_7 = scripts\common\trace::create_default_contents(1);
  var_8 = self._blackboard.jumptargetpos;
  var_9 = scripts\common\trace::capsule_trace(self.origin, self.origin - (0, 0, 60), self.fgetarg, self.height, self.angles, self, var_7);
  if(var_9["fraction"] < 1 && var_9["normal"][2] > 0) {
    var_8 = var_9["position"];
  }

  var_10 = max(var_8[2] - self.origin[2] / var_6[2], 0);
  self scragentsetanimscale(1, var_10);
  self ghostlaunched("anim deltas");
  self gib_fx_override("noclip");
  scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_4, self.moveratescale, var_1, "end", scripts\asm\asm::func_2341(var_0, var_1));
}

ss_play_jumpmove_end_clean(var_0, var_1, var_2) {
  func_A4DA();
  scripts\asm\asm::asm_fireephemeralevent("jumpmoveanim", "end");
}

superslasher_shouldstartarrival(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(var_1, "cover_approach")) {
    return 0;
  }

  var_4 = gettime();
  var_5 = 250;
  if(var_4 - self.asm.footsteps.time > var_5) {
    return 0;
  }

  var_6 = 128;
  var_7 = self.vehicle_getspawnerarray - self.origin;
  var_8 = length(var_7);
  if(var_8 > var_6) {
    return 0;
  }

  var_9 = gettime() - self.asm.footsteps.time;
  if(var_9 < 250 || var_9 > 400) {
    return 0;
  }

  var_10 = self.objective_playermask_showto;
  if(isDefined(self.node) || isDefined(self.physics_querypoint)) {
    var_10 = 0;
  }

  self.asm.var_11068 = func_3722(var_0, var_2, self.vehicle_getspawnerarray, var_10, 0);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3722(var_0, var_1, var_2, var_3, var_4) {
  var_2 = self.vehicle_getspawnerarray;
  var_5 = self.angles;
  var_6 = var_2 - self.origin;
  var_7 = length2dsquared(var_6);
  var_8 = lib_0F3C::func_3E96(var_0, var_1);
  var_9 = self getsafecircleorigin(var_1, var_8);
  var_10 = getmovedelta(var_9);
  var_11 = getangledelta3d(var_9);
  var_12 = rotatevector(var_10, self.angles);
  var_13 = var_12 + self.origin;
  var_14 = 0;
  var_15 = distancesquared(var_13, var_2);
  if(var_15 > var_3 * var_3) {
    var_14 = 1;
  }

  var_10 = getclosestpointonnavmesh(var_13, self);
  var_11 = self func_84AC();
  if(!navisstraightlinereachable(var_11, var_10, self)) {
    return undefined;
  }

  if(var_14) {
    var_12 = rotatevector(var_10, var_5 - var_11);
    var_12 = var_2 - var_12;
  } else if(distance2dsquared(var_11, var_14) > 4) {
    var_13 = rotatevector(var_11, var_6 - var_12);
    var_12 = var_11 - var_13;
  } else {
    var_12 = self.origin;
  }

  var_13 = spawnStruct();
  var_13.getgrenadedamageradius = var_9;
  var_13.opcode::OP_GetUnsignedShort = 4;
  var_13.areanynavvolumesloaded = var_12;
  var_13.opcode::OP_ScriptFarMethodChildThreadCall = var_11[1];
  var_13.log = var_5;
  var_13.stricmp = var_10;
  var_13.animindex = var_8;
  return var_13;
}

ss_play_arrival(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self.asm.var_11068;
  self.asm.var_11068 = undefined;
  var_5 = self.angles;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_6 = distance2d(self.origin, self.vehicle_getspawnerarray);
    var_7 = var_6 / length2d(var_4.stricmp);
    self scragentsetanimscale(var_7, 1);
    if(var_6 > 12) {
      var_8 = vectortoyaw(self.vehicle_getspawnerarray - self.origin);
      var_5 = (0, var_8, 0);
    }
  }

  self orientmode("face angle abs", var_5);
  self ghostlaunched("anim deltas");
  scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_4.animindex, self.moveplaybackrate, var_1, "end");
}

ss_play_arrival_clean(var_0, var_1, var_2) {
  self scragentsetanimscale(1, 1);
}

ss_play_meleecharge(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  thread superslasher_faceenemyhelper(self.bt.meleetarget, 500, var_1);
  self scragentsetanimscale(2, 1);
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

ss_play_meleecharge_clean(var_0, var_1, var_2) {
  self scragentsetanimscale(1, 1);
}

superslasher_shouldmovemelee(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_meleerequested()) {
    return 0;
  }

  return 1;
}

superslasher_faceenemyhelper(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2 + "_finished");
  }

  var_3 = gettime() + var_1;
  while(gettime() <= var_3 && isDefined(var_0) && isalive(var_0)) {
    var_4 = var_0.origin - self.origin;
    if(length2dsquared(var_4) > 1024) {
      var_5 = vectortoyaw(var_4);
      self orientmode("face angle abs", (0, var_5, 0));
    }

    wait(0.05);
  }

  self orientmode("face angle abs", self.angles);
}

ss_play_standmelee(var_0, var_1, var_2, var_3) {
  thread superslasher_faceenemyhelper(self.bt.meleetarget, 500, var_1);
  ss_play(var_0, var_1, var_2, var_3);
}

ss_play_movemelee(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::func_2957(var_0, var_1)) {
    thread superslasher_faceenemyhelper(self.bt.meleetarget, 1000, var_1);
  } else {
    self orientmode("face angle abs", self.angles);
  }

  ss_play(var_0, var_1, var_2, var_3);
}

ss_play_movemelee_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    scripts\asm\superslasher\superslasher_actions::superslasher_domeleedamage();
  }
}

ss_play_stomp(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = self._blackboard.stomptarget;
  thread superslasher_faceenemyhelper(var_4, 1500, var_1);
  self playsoundonmovingent("zmb_vo_supslasher_attack_stomp");
  ss_play(var_0, var_1, var_2, var_3, ::ss_play_stomp_nt);
}

ss_play_stomp_nt(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    scripts\asm\superslasher\superslasher_actions::superslasher_dostompattack(self._blackboard.stompdist);
  }
}

superslasher_needstoturn(var_0, var_1, var_2, var_3) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_4 = vectortoyaw(self func_813A());
    var_5 = angleclamp180(var_4 - self.angles[1]);
    if(abs(var_5) >= 35) {
      var_6 = anglesToForward(self.angles);
      var_7 = self.origin + var_6 * 128;
      if(navtrace(self.origin, var_7, self)) {
        self.asm.turndata = var_5;
        return 1;
      }
    }
  } else if(isDefined(self.bt.target)) {
    var_8 = self.bt.target getvelocity();
    var_9 = self.bt.target.origin + var_8;
    var_10 = var_9 - self.origin;
    var_11 = vectortoyaw(var_10);
    var_12 = angleclamp180(var_11 - self.angles[1]);
    if(abs(var_12) >= 35) {
      self.asm.turndata = var_12;
      return 1;
    }
  }

  return 0;
}

superslasher_chooseanim_turn(var_0, var_1, var_2) {
  var_3 = self.asm.turndata;
  if(var_3 > 0) {
    var_4 = int(180 + var_3 + 10 / 45);
  } else {
    var_4 = int(180 + var_4 - 10 / 45);
  }

  var_5 = ["2r", "3", "6", "9", "8", "7", "4", "1", "2l"];
  return var_5[var_4];
}

ss_play_turn(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getanimlength(var_5);
  var_7 = 0.75;
  var_8 = self.asm.turndata;
  self.asm.turndata = undefined;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  self._blackboard.bcommittedtoanim = 1;
  scripts\mp\agents\_scriptedagents::func_CED1(var_1, var_4, self.moveplaybackrate, var_6 - var_7 / self.moveplaybackrate);
  scripts\asm\asm::asm_fireevent(var_1, "turn_done");
}

ss_play_turn_clean(var_0, var_1, var_2) {
  self._blackboard.bcommittedtoanim = undefined;
}

superslasher_onroof(var_0, var_1, var_2, var_3) {
  return self._blackboard.bonroof;
}

superslasher_gotogroundrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bgroundrequested);
}

superslasher_gotoroofrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.broofrequested);
}

superslasher_shouldroofjumpagain(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.iroofjump) && self._blackboard.iroofjump == 0;
}

superslasher_tauntrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.btauntrequested);
}

superslasher_shouldsummon(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bsummonrequested);
}

superslasher_groundpoundrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bgroundpoundrequested);
}

superslasher_shouldsummonsawblades(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bsummonsawbladesrequested);
}

superslasher_shouldthrowsaw(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bthrowsawrequested);
}

superslasher_shouldthrowsawfan(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bthrowsawfanrequested);
}

superslasher_shouldjumpmove(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bjumpmoverequested) && isDefined(self._blackboard.jumptargetpos);
}

superslasher_wiresrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bwiresrequested);
}

superslasher_shockwaverequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bshockwaverequested);
}

superslasher_sharksrequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bsharksrequested);
}

superslasher_shouldsawchargeloop(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.throwsawchargelooptime) && self._blackboard.throwsawchargelooptime > 0;
}

superslasher_stomprequested(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bstomprequested);
}

superslasher_shoulddointro(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.bintrorequested);
}
/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\superslasher\superslasher_asm.gsc
*********************************************************/

superslasher_init(param_00, param_01, param_02, param_03) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "left";
  self.asm.footsteps.time = gettime();
  self.asm.var_4C86 = spawnStruct();
  self.despawncovernode = 32;
  self.sharpturnnotifydist = 160;
  var_04 = self getsafecircleorigin("jump_to_roof", 0);
  var_05 = getmovedelta(var_04);
  var_06 = getangledelta(var_04);
  level.superslasherjumptoroofangles = (0, angleclamp180(level.superslasherrooftopangles[1] - 180 - var_06), 0);
  level.superslashergotogroundspot = level.superslasherrooftopspot - rotatevector(var_05, level.superslasherjumptoroofangles);
}

ss_play(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  if(!isDefined(param_04)) {
    param_04 = scripts\asm\asm::func_2341(param_00, param_01);
  }

  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_05, self.moveratescale, param_01, "end", param_04);
}

superslasher_playmoveloop(param_00, param_01, param_02, param_03) {
  self.var_1198.bmoving = 1;
  scripts\asm\shared\mp\move_v2::playmoveloopv2(param_00, param_01, param_02, param_03);
}

superslasher_playmoveloop_clean(param_00, param_01, param_02, param_03) {
  self.var_1198.bmoving = undefined;
}

ss_play_groundidle(param_00, param_01, param_02, param_03) {
  self.var_1198.bidle = 1;
  lib_0F3C::func_B050(param_00, param_01, param_02, param_03);
}

ss_play_groundidle_clean(param_00, param_01, param_02) {
  self.var_1198.bidle = undefined;
}

ss_play_roofidle(param_00, param_01, param_02, param_03) {
  self gib_fx_override("noclip");
  self orientmode("face angle abs", level.superslasherrooftopangles);
  lib_0F3C::func_B050(param_00, param_01, param_02, param_03);
}

ss_play_rooftaunt(param_00, param_01, param_02, param_03) {
  self gib_fx_override("noclip");
  self orientmode("face angle abs", level.superslasherrooftopangles);
  lib_0F3C::func_CEA8(param_00, param_01, param_02, param_03);
}

ss_play_rooftaunt_clean(param_00, param_01, param_02) {
  self gib_fx_override("gravity");
}

ss_play_jumptoground(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.var_1198.buninterruptibleanim = 1;
  self ghostlaunched("anim deltas");
  self gib_fx_override("noclip");
  thread ss_play_jtog_waitmigrate(param_01);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

ss_play_jtog_waitmigrate(param_00) {
  self endon(param_00 + "_finished");
  level waittill("host_migration_begin");
  self.var_1198.bjumptogroundborked = 1;
}

ss_play_jumptoground_clean(param_00, param_01, param_02) {
  self scragentsetanimscale(1, 1);
  self gib_fx_override("gravity");
  self.var_1198.buninterruptibleanim = undefined;
  if(isDefined(self.var_1198.bjumptogroundborked) || self.origin[2] > -116) {
    self setorigin(level.superslashergotogroundspot + (0, 0, 24));
    self.var_1198.bjumptogroundborked = undefined;
  }
}

ss_play_jumptoground_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "land") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
  }
}

ss_play_jumpscale(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_04 - self.origin;
  var_06 = vectortoangles((var_05[0], var_05[1], 0));
  if(isDefined(param_03)) {
    var_07 = getmovedelta(param_03);
    param_04 = param_04 - rotatevector(var_07, var_06);
    var_05 = param_04 - self.origin;
  }

  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", var_06);
  self gib_fx_override("noclip");
  var_08 = getmovedelta(param_02);
  var_09 = length2d(var_08);
  var_0A = length2d(var_05);
  var_0B = var_0A / var_09;
  var_0C = max(var_05[2] / var_08[2], 0);
  var_0D = 1;
  self scragentsetanimscale(var_0B, var_0C);
  scripts\mp\agents\_scriptedagents::func_CED2(param_00, param_01, var_0D, param_00, "end");
}

ss_play_jumptoroof(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.var_1198.buninterruptibleanim = 1;
  var_04 = level.superslasherrooftopspot;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_06 = self getsafecircleorigin(param_01, var_05);
  var_07 = level.superslasherjumptoroofangles;
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", var_07);
  self gib_fx_override("noclip");
  thread ss_play_jtog_waitmigrate(param_01);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

ss_play_jumptoroof_clean(param_00, param_01, param_02) {
  self gib_fx_override("gravity");
  self.var_1198.buninterruptibleanim = undefined;
  if(isDefined(self.var_1198.bjumptogroundborked) || self.origin[2] < 340) {
    self setorigin(level.superslasherrooftopspot);
    self.var_1198.bjumptogroundborked = undefined;
  }

  if(scripts\asm\asm::func_232B(param_01, "end")) {
    self.asm.turndata = spawnStruct();
    self.asm.turndata = angleclamp180(level.superslasherrooftopangles[1] - self.angles[1]);
  }
}

ss_play_groundpound(param_00, param_01, param_02, param_03) {
  self playsoundonmovingent("zmb_vo_supslasher_attack_ground_pound");
  ss_play(param_00, param_01, param_02, param_03, ::ss_play_groundpound_nt);
}

ss_play_groundpound_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
  }
}

ss_play_summonsawblades(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread scripts\asm\superslasher\superslasher_actions::superslasher_dosummonedsawblades();
  ss_play(param_00, param_01, param_02, param_03);
}

ss_play_sawcharge_start(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  if(isDefined(self.var_1198.throwsawchargetime)) {
    var_05 = self getsafecircleorigin(param_01, var_04);
    var_06 = getanimlength(var_05);
    self.var_1198.throwsawchargelooptime = max(self.var_1198.throwsawchargetime - var_06, 0);
  }

  var_07 = scripts\asm\asm::func_2341(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04, self.moveratescale, param_01, "end", var_07);
}

ss_play_sawcharge_start_clean(param_00, param_01, param_02) {
  self.var_1198.throwsawchargetime = undefined;
}

ss_play_sawcharge(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  thread lib_0F3C::func_B050(param_00, param_01, param_02, param_03);
  wait(self.var_1198.throwsawchargelooptime);
  scripts\asm\asm::asm_fireevent(param_01, "saw_charge_loop_complete");
}

ss_play_sawcharge_clean(param_00, param_01, param_02) {
  self.var_1198.throwsawchargelooptime = undefined;
}

ss_play_throwsaw(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = 1;
  self.throwsawprevturnspeed = self ghosthover();
  if(isDefined(self.var_1198.throwsawtarget)) {
    thread superslasher_faceenemyhelper(self.var_1198.throwsawtarget, var_04 * 1000, param_01);
  }

  ss_play(param_00, param_01, param_02, param_03, ::ss_play_throwsaw_nt);
}

ss_play_throwsaw_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "throw") {
    scripts\asm\superslasher\superslasher_actions::superslasher_dothrownsaw();
  }
}

ss_play_throwsaw_clean(param_00, param_01, param_02) {
  self ghostskullstimestart(self.throwsawprevturnspeed);
  self.throwsawprevturnspeed = undefined;
}

ss_play_throwsawfan_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "throw") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dosawfan();
  }
}

ss_play_summon(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED1(param_01, var_04, self.moveratescale, 2 / self.moveratescale);
  thread scripts\asm\superslasher\superslasher_actions::superslasher_summonminions(param_03);
  scripts\mp\agents\_scriptedagents::func_1384C(param_01, "end", param_01, var_04);
}

ss_play_wires(param_00, param_01, param_02, param_03) {
  thread scripts\asm\superslasher\superslasher_actions::superslasher_domaskchange(1, "roof");
  ss_play(param_00, param_01, param_02, undefined);
}

ss_play_shockwave_start(param_00, param_01, param_02, param_03) {
  self playsoundonmovingent("zmb_vo_supslasher_attack_shockwave_build_start");
  self orientmode("face angle abs", level.superslasherrooftopangles);
  lib_0F3C::func_CEA8(param_00, param_01, param_02, param_03);
}

ss_play_shockwave_loop(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  self playsoundonmovingent("zmb_vo_supslasher_attack_shockwave_build");
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self setanimstate(param_01, var_05, self.moveratescale);
  wait(var_04);
  scripts\asm\asm::asm_fireevent(param_01, "shockwave_loop_complete");
}

ss_play_shockwave_finish(param_00, param_01, param_02, param_03) {
  ss_play(param_00, param_01, param_02, undefined, ::ss_play_shockwave_nt);
}

ss_play_shockwave_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    thread scripts\asm\superslasher\superslasher_actions::domaskattack(0, "roof");
  }
}

ss_play_summonsharks(param_00, param_01, param_02, param_03) {
  self playsoundonmovingent("zmb_vo_supslasher_attack_summon");
  thread scripts\asm\superslasher\superslasher_actions::superslasher_domaskchange(2, "ground");
  ss_play(param_00, param_01, param_02, undefined);
}

ss_play_trapped(param_00, param_01, param_02, param_03) {
  thread func_126BB(param_01, self.var_1198.trapduration);
  self playsoundonmovingent("zmb_vo_supslasher_pain");
  lib_0F3C::func_B050(param_00, param_01, param_02, param_03);
}

func_126BB(param_00, param_01) {
  self endon(param_00 + "_finished");
  wait(param_01);
  scripts\asm\asm::asm_fireevent(param_00, "trap_end");
}

ss_play_trapped_clean(param_00, param_01, param_02) {
  self.var_1198.trapduration = undefined;
  self.var_1198.btraprequested = undefined;
}

ss_play_jumpmove_start(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_1198.jumptargetpos;
  thread scripts\asm\superslasher\superslasher_actions::dogroundjumpattackfx(var_04);
  var_05 = var_04 - self.origin;
  var_06 = vectortoangles((var_05[0], var_05[1], 0));
  var_07 = length(var_05);
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", var_06);
  self gib_fx_override("noclip");
  self scragentsetanimscale(1, 3);
  self playsoundonmovingent("zmb_vo_supslasher_jump");
  ss_play(param_00, param_01, param_02, param_03);
}

ss_play_jumpmove_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "takeoff") {
    self.var_1198.binair = 1;
    return;
  }

  if(param_00 == "land") {
    thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
    self.var_1198.binair = undefined;
    scripts\asm\superslasher\superslasher_actions::groundjumpattackfxcleanup();
    self playsoundonmovingent("zmb_vo_supslasher_attack_land");
  }
}

func_A4DA() {
  self.var_1198.binair = undefined;
  scripts\asm\superslasher\superslasher_actions::groundjumpattackfxcleanup();
  self.var_1198.jumptargetpos = undefined;
  self gib_fx_override("gravity");
  self scragentsetanimscale(1, 1);
}

ss_play_jumpmove_start_clean(param_00, param_01, param_02) {
  self scragentsetanimscale(1, 1);
  if(!scripts\asm\asm::func_232B(param_01, "end")) {
    func_A4DA();
  }
}

ss_play_jumpmove(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_1198.jumptargetpos;
  self.var_1198.buninterruptibleanim = 1;
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_06 = self getsafecircleorigin(param_01, var_05);
  var_07 = scripts\asm\asm_mp::func_235A(param_01, "end");
  var_08 = self getsafecircleorigin(param_01, var_07);
  self.var_1198.binair = 1;
  ss_play_jumpscale(param_01, var_05, var_06, var_08, var_04);
}

ss_play_jumpmove_clean(param_00, param_01, param_02) {
  self.var_1198.buninterruptibleanim = undefined;
  if(!scripts\asm\asm::func_232B(param_01, "end")) {
    func_A4DA();
  }
}

ss_play_jumpmove_end(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self getsafecircleorigin(param_01, var_04);
  var_06 = getmovedelta(var_05);
  var_07 = scripts\common\trace::create_default_contents(1);
  var_08 = self.var_1198.jumptargetpos;
  var_09 = scripts\common\trace::capsule_trace(self.origin, self.origin - (0, 0, 60), self.fgetarg, self.height, self.angles, self, var_07);
  if(var_09["fraction"] < 1 && var_09["normal"][2] > 0) {
    var_08 = var_09["position"];
  }

  var_0A = max(var_08[2] - self.origin[2] / var_06[2], 0);
  self scragentsetanimscale(1, var_0A);
  self ghostlaunched("anim deltas");
  self gib_fx_override("noclip");
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04, self.moveratescale, param_01, "end", scripts\asm\asm::func_2341(param_00, param_01));
}

ss_play_jumpmove_end_clean(param_00, param_01, param_02) {
  func_A4DA();
  scripts\asm\asm::asm_fireephemeralevent("jumpmoveanim", "end");
}

superslasher_shouldstartarrival(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm::func_232B(param_01, "cover_approach")) {
    return 0;
  }

  var_04 = gettime();
  var_05 = 250;
  if(var_04 - self.asm.footsteps.time > var_05) {
    return 0;
  }

  var_06 = 128;
  var_07 = self.vehicle_getspawnerarray - self.origin;
  var_08 = length(var_07);
  if(var_08 > var_06) {
    return 0;
  }

  var_09 = gettime() - self.asm.footsteps.time;
  if(var_09 < 250 || var_09 > 400) {
    return 0;
  }

  var_0A = self.objective_playermask_showto;
  if(isDefined(self.target_getindexoftarget) || isDefined(self.physics_querypoint)) {
    var_0A = 0;
  }

  self.asm.var_11068 = func_3722(param_00, param_02, self.vehicle_getspawnerarray, var_0A, 0);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3722(param_00, param_01, param_02, param_03, param_04) {
  param_02 = self.vehicle_getspawnerarray;
  var_05 = self.angles;
  var_06 = param_02 - self.origin;
  var_07 = length2dsquared(var_06);
  var_08 = lib_0F3C::func_3E96(param_00, param_01);
  var_09 = self getsafecircleorigin(param_01, var_08);
  var_0A = getmovedelta(var_09);
  var_0B = getangledelta3d(var_09);
  var_0C = rotatevector(var_0A, self.angles);
  var_0D = var_0C + self.origin;
  var_0E = 0;
  var_0F = distancesquared(var_0D, param_02);
  if(var_0F > param_03 * param_03) {
    var_0E = 1;
  }

  var_10 = getclosestpointonnavmesh(var_0D, self);
  var_11 = self _meth_84AC();
  if(!navisstraightlinereachable(var_11, var_10, self)) {
    return undefined;
  }

  if(var_0E) {
    var_0C = rotatevector(var_0A, var_05 - var_0B);
    var_12 = param_02 - var_0C;
  } else if(distance2dsquared(var_11, var_0E) > 4) {
    var_0D = rotatevector(var_0B, var_06 - var_0C);
    var_12 = var_11 - var_0D;
  } else {
    var_12 = self.origin;
  }

  var_13 = spawnStruct();
  var_13.getgrenadedamageradius = var_09;
  var_13.opcode::OP_GetUnsignedShort = 4;
  var_13.areanynavvolumesloaded = var_12;
  var_13.opcode::OP_ScriptFarMethodChildThreadCall = var_0B[1];
  var_13.log = var_05;
  var_13.stricmp = var_0A;
  var_13.animindex = var_08;
  return var_13;
}

ss_play_arrival(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.asm.var_11068;
  self.asm.var_11068 = undefined;
  var_05 = self.angles;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_06 = distance2d(self.origin, self.vehicle_getspawnerarray);
    var_07 = var_06 / length2d(var_04.stricmp);
    self scragentsetanimscale(var_07, 1);
    if(var_06 > 12) {
      var_08 = vectortoyaw(self.vehicle_getspawnerarray - self.origin);
      var_05 = (0, var_08, 0);
    }
  }

  self orientmode("face angle abs", var_05);
  self ghostlaunched("anim deltas");
  scripts\mp\agents\_scriptedagents::func_CED2(param_01, var_04.animindex, self.moveplaybackrate, param_01, "end");
}

ss_play_arrival_clean(param_00, param_01, param_02) {
  self scragentsetanimscale(1, 1);
}

ss_play_meleecharge(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  thread superslasher_faceenemyhelper(self.var_3135.meleetarget, 500, param_01);
  self scragentsetanimscale(2, 1);
  lib_0F3C::func_B050(param_00, param_01, param_02, param_03);
}

ss_play_meleecharge_clean(param_00, param_01, param_02) {
  self scragentsetanimscale(1, 1);
}

superslasher_shouldmovemelee(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_meleerequested()) {
    return 0;
  }

  return 1;
}

superslasher_faceenemyhelper(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    self endon(param_02 + "_finished");
  }

  var_03 = gettime() + param_01;
  while(gettime() <= var_03 && isDefined(param_00) && isalive(param_00)) {
    var_04 = param_00.origin - self.origin;
    if(length2dsquared(var_04) > 1024) {
      var_05 = vectortoyaw(var_04);
      self orientmode("face angle abs", (0, var_05, 0));
    }

    wait(0.05);
  }

  self orientmode("face angle abs", self.angles);
}

ss_play_standmelee(param_00, param_01, param_02, param_03) {
  thread superslasher_faceenemyhelper(self.var_3135.meleetarget, 500, param_01);
  ss_play(param_00, param_01, param_02, param_03);
}

ss_play_movemelee(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::func_2957(param_00, param_01)) {
    thread superslasher_faceenemyhelper(self.var_3135.meleetarget, 1000, param_01);
  } else {
    self orientmode("face angle abs", self.angles);
  }

  ss_play(param_00, param_01, param_02, param_03);
}

ss_play_movemelee_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    scripts\asm\superslasher\superslasher_actions::superslasher_domeleedamage();
  }
}

ss_play_stomp(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = self.var_1198.stomptarget;
  thread superslasher_faceenemyhelper(var_04, 1500, param_01);
  self playsoundonmovingent("zmb_vo_supslasher_attack_stomp");
  ss_play(param_00, param_01, param_02, param_03, ::ss_play_stomp_nt);
}

ss_play_stomp_nt(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    scripts\asm\superslasher\superslasher_actions::superslasher_dostompattack(self.var_1198.stompdist);
  }
}

superslasher_needstoturn(param_00, param_01, param_02, param_03) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_04 = vectortoyaw(self _meth_813A());
    var_05 = angleclamp180(var_04 - self.angles[1]);
    if(abs(var_05) >= 35) {
      var_06 = anglesToForward(self.angles);
      var_07 = self.origin + var_06 * 128;
      if(navtrace(self.origin, var_07, self)) {
        self.asm.turndata = var_05;
        return 1;
      }
    }
  } else if(isDefined(self.var_3135.target)) {
    var_08 = self.var_3135.target getvelocity();
    var_09 = self.var_3135.target.origin + var_08;
    var_0A = var_09 - self.origin;
    var_0B = vectortoyaw(var_0A);
    var_0C = angleclamp180(var_0B - self.angles[1]);
    if(abs(var_0C) >= 35) {
      self.asm.turndata = var_0C;
      return 1;
    }
  }

  return 0;
}

superslasher_chooseanim_turn(param_00, param_01, param_02) {
  var_03 = self.asm.turndata;
  if(var_03 > 0) {
    var_04 = int(180 + var_03 + 10 / 45);
  } else {
    var_04 = int(180 + var_04 - 10 / 45);
  }

  var_05 = ["2r", "3", "6", "9", "8", "7", "4", "1", "2l"];
  return var_05[var_04];
}

ss_play_turn(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = self getsafecircleorigin(param_01, var_04);
  var_06 = getanimlength(var_05);
  var_07 = 0.75;
  var_08 = self.asm.turndata;
  self.asm.turndata = undefined;
  self orientmode("face angle abs", self.angles);
  self ghostlaunched("anim deltas");
  self.var_1198.bcommittedtoanim = 1;
  scripts\mp\agents\_scriptedagents::func_CED1(param_01, var_04, self.moveplaybackrate, var_06 - var_07 / self.moveplaybackrate);
  scripts\asm\asm::asm_fireevent(param_01, "turn_done");
}

ss_play_turn_clean(param_00, param_01, param_02) {
  self.var_1198.bcommittedtoanim = undefined;
}

superslasher_onroof(param_00, param_01, param_02, param_03) {
  return self.var_1198.bonroof;
}

superslasher_gotogroundrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bgroundrequested);
}

superslasher_gotoroofrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.broofrequested);
}

superslasher_shouldroofjumpagain(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.iroofjump) && self.var_1198.iroofjump == 0;
}

superslasher_tauntrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.btauntrequested);
}

superslasher_shouldsummon(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bsummonrequested);
}

superslasher_groundpoundrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bgroundpoundrequested);
}

superslasher_shouldsummonsawblades(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bsummonsawbladesrequested);
}

superslasher_shouldthrowsaw(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bthrowsawrequested);
}

superslasher_shouldthrowsawfan(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bthrowsawfanrequested);
}

superslasher_shouldjumpmove(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bjumpmoverequested) && isDefined(self.var_1198.jumptargetpos);
}

superslasher_wiresrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bwiresrequested);
}

superslasher_shockwaverequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bshockwaverequested);
}

superslasher_sharksrequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bsharksrequested);
}

superslasher_shouldsawchargeloop(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.throwsawchargelooptime) && self.var_1198.throwsawchargelooptime > 0;
}

superslasher_stomprequested(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bstomprequested);
}

superslasher_shoulddointro(param_00, param_01, param_02, param_03) {
  return isDefined(self.var_1198.bintrorequested);
}
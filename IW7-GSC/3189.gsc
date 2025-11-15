/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3189.gsc
************************/

func_13F9A(param_00, param_01, param_02, param_03) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.var_7360 = 0;
  self.var_71D0 = ::func_1004F;
  self.var_7198 = ::func_38B2;
  self.var_BC09 = [];
  self.weaponisboltaction = 64;
}

func_3EFC(param_00, param_01, param_02) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_03 = "";
    switch (self.synctransients) {
      case "walk":
      case "slow_walk":
        var_03 = "_walk";
        break;

      case "sprint":
      case "run":
        var_03 = "_run";
        break;

      default:
        break;
    }

    if(scripts\asm\asm_mp::func_2347(param_01, self.spawner.script_animation + var_03)) {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.spawner.script_animation + var_03);
    } else if(scripts\asm\asm_mp::func_2347(param_01, self.spawner.script_animation)) {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.spawner.script_animation);
    }
  }

  if(!isDefined(param_02)) {
    return lib_0F3C::func_3EF4(param_00, param_01, param_02);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
}

func_3EFB(param_00, param_01, param_02) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_03 = "";
    switch (self.synctransients) {
      case "walk":
      case "slow_walk":
        var_03 = "_walk";
        break;

      case "sprint":
      case "run":
        var_03 = "_run";
        break;

      default:
        break;
    }

    if(scripts\asm\asm_mp::func_2347(param_01, self.spawner.script_animation + var_03)) {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.spawner.script_animation + var_03);
    } else if(scripts\asm\asm_mp::func_2347(param_01, self.spawner.script_animation)) {
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.spawner.script_animation);
    }
  }

  if(!isDefined(param_02)) {
    return lib_0F3C::func_3EF4(param_00, param_01, param_02);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
}

func_3EE0(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return lib_0F3C::func_3EF4(param_00, param_01, param_02);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
}

func_3EE1(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = 0;
  var_05 = self getanimentrycount(param_01);
  if(var_05 == 1) {
    self.var_BC09[param_01] = 0;
  } else if(!isDefined(self.var_BC09[param_01])) {
    self.var_BC09[param_01] = randomintrange(0, var_05);
  }

  self.asm.var_BCD3 = tolower(self.var_BC09[param_01] + 1);
  if(isDefined(param_02)) {
    self.asm.var_BCD3 = param_02 + self.asm.var_BCD3;
  }

  return self.var_BC09[param_01];
}

func_3EF1(param_00, param_01, param_02, param_03) {
  var_04 = self getanimentrycount(param_01);
  var_05 = scripts\mp\agents\zombie\zombie_util::func_4D52(self.var_4D62, self.var_DC);
  var_06 = angleclamp180(var_05 - self.angles[1]);
  var_07 = scripts\mp\agents\zombie\zombie_util::botmemoryevent(var_06, var_04);
  return var_07;
}

func_D4F5(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  if(isDefined(self.vehicle_getspawnerarray)) {
    self ghostlaunched("code_move");
    self orientmode("face motion");
  }

  var_05 = self getsafecircleorigin(param_01, var_04);
  var_06 = getanimlength(var_05);
  var_07 = 1;
  if(isDefined(self.var_C081) && self.var_C081 > 0) {
    var_07 = self.var_C081;
  }

  var_06 = var_06 * 1 / var_07;
  self.var_BF9E = gettime() + var_06 * 0.75 * 1000;
  scripts\mp\agents\_scriptedagents::func_CED3(param_01, var_04, self.var_C081, "pain_anim");
  func_6CE0(param_00, param_01, param_03);
}

func_D4F3(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon(param_01 + "_finished");
  if(scripts\asm\asm_mp::func_2347(param_01, self.asm.var_BCD3)) {
    var_04 = scripts\asm\asm_mp::func_235A(param_01, self.asm.var_BCD3);
  } else {
    var_04 = lib_0F3C::func_3EF4(param_01, param_02, var_04);
  }

  var_05 = scripts\asm\asm::func_2341(param_00, param_01);
  thread scripts\mp\agents\_scriptedagents::func_CED5(param_01, var_04, param_01, "end", var_05);
  self.var_BF9E = gettime() + 10000;
  wait(0.35);
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_9DB2(param_00, param_01, param_02, param_03) {
  var_04 = func_4D41();
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && isDefined(var_04) && var_04 >= 0) {
    return 1;
  }

  return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand", "left_leg_upper", "left_foot", "left_leg_lower");
}

func_9DB3(param_00, param_01, param_02, param_03) {
  var_04 = func_4D41();
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && isDefined(var_04) && var_04 < 0) {
    return 1;
  }

  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "right_leg_upper", "right_foot", "right_leg_lower");
}

func_9DB1(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");
}

func_4D41() {
  var_00 = scripts\mp\agents\zombie\zombie_util::func_4D52(self.var_4D62, self.var_DC);
  var_01 = angleclamp180(var_00 - self.angles[1]);
  return var_01;
}

func_6CE0(param_00, param_01, param_02) {
  self notify("killanimscript");
  var_03 = level.asm[param_00].states[param_01];
  var_04 = undefined;
  if(isarray(param_02)) {
    var_04 = param_02[0];
  } else {
    var_04 = param_02;
  }

  if(!isDefined(var_04)) {
    if(isDefined(var_03.transitions) && var_03.transitions.size > 0) {
      return;
    }

    var_04 = "choose_idle";
  }

  scripts\asm\asm::func_2388(param_00, param_01, var_03, var_03.var_116FB);
  scripts\asm\asm::func_238A(param_00, var_04, 0.2, undefined, undefined, undefined);
}

func_1004F() {
  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return 0;
  }

  if(isDefined(self.isfrozen) && self.isfrozen) {
    return 0;
  }

  if(isDefined(self.var_BF9E) && gettime() < self.var_BF9E) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(isDefined(level.no_pain_volume) && self istouching(level.no_pain_volume)) {
    return 0;
  }

  if(!scripts\engine\utility::istrue(self.stunned)) {
    if(scripts\asm\asm_bb::bb_meleerequested()) {
      return 0;
    }

    if(scripts\asm\asm_bb::bb_meleeinprogress()) {
      return 0;
    }
  }

  return 1;
}

func_9E89(param_00) {
  switch (param_00) {
    case "right_foot":
    case "left_foot":
    case "right_leg_lower":
    case "right_leg_upper":
    case "left_leg_lower":
    case "left_leg_upper":
      return 1;

    default:
      return 0;
  }
}

func_9EAB(param_00, param_01, param_02, param_03) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_BE92() {
  if(isDefined(self.dismember_crawl)) {
    return self.dismember_crawl;
  }

  return 0;
}

func_BE99(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_BE9A(param_00, param_01, param_02, param_03) {
  if(func_9F87()) {
    return 1;
  }

  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_BE9B() {
  if(func_9F87() && func_1005C() && !func_8C13()) {
    return 1;
  }

  return 0;
}

func_BE97() {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    return !scripts\engine\utility::istrue(self.hasplayedvignetteanim);
  }

  return 0;
}

func_BE95(param_00, param_01, param_02, param_03) {
  return isDefined(self.linked_to_boat);
}

func_BE96() {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_fxid)) {
    return !scripts\engine\utility::istrue(self.var_8C12);
  }

  return 0;
}

func_1009C() {
  if(isDefined(self.linked_to_boat)) {
    return 0;
  }

  return 1;
}

func_BCCD() {
  if(isDefined(self.agent_type) && self.agent_type == "zombie_brute") {
    return 0;
  }

  var_00 = isDefined(self.asm.cur_move_mode) && self.asm.cur_move_mode != self.var_1198.movetype;
  if(var_00) {
    return 1;
  }

  return 0;
}

func_9E0F() {
  return scripts\engine\utility::istrue(self.bisghost);
}

func_9F87() {
  return scripts\engine\utility::istrue(self.is_suicide_bomber);
}

func_1005C() {
  return scripts\engine\utility::istrue(self.should_play_transformation_anim);
}

func_8C13() {
  return scripts\engine\utility::istrue(self.var_8C13);
}

func_9D8C(param_00, param_01, param_02, param_03) {
  if(isDefined(self.is_suicide_bomber)) {
    return 1;
  }

  return 0;
}

iscorempgametype(param_00, param_01, param_02, param_03) {
  if(self.agent_type == "zombie_cop") {
    if(getdvarint("scr_dont_use_cop_anims") != 0) {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_1005E(param_00, param_01, param_02, param_03) {
  if(!scripts\engine\utility::istrue(self.is_traversing) && !scripts\engine\utility::istrue(self.customdeath)) {
    return scripts\mp\agents\zombie\zmb_zombie_agent::dying_zapper_death();
  }

  return 0;
}

func_10046(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.rocket_feet);
}

choosefacemelteranim(param_00, param_01, param_02, param_03) {
  self notify("facemelter_launch_chosen");
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return "prone_launch";
  }

  return "launch";
}

func_6A79(param_00, param_01, param_02, param_03) {
  self notify("ready_to_launch");
}

shouldplaybalconydeath(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.dischord_spin);
}

choosedischordanim(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return "prone_spin";
  }

  return "spin";
}

func_5626(param_00, param_01, param_02, param_03) {
  self notify("ready_to_spin");
}

func_10049(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.head_is_exploding);
}

chooseheadcutteranim(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return "prone_expand_head";
  }

  return "expand_head";
}

func_10053(param_00, param_01, param_02, param_03) {
  return 0;
}

func_D532(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.scripted_mode = 1;
  self gib_fx_override("noclip");
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = 0.01;
  thread scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, var_05);
  if(isDefined(level.spawn_fx_func)) {
    self[[level.spawn_fx_func]]();
  }

  wait(0.5);
  self.var_8C12 = 1;
}

func_D4DB(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.scripted_mode = 1;
  self gib_fx_override("noclip");
  thread lib_0F3C::func_CEA8(param_00, param_01, param_02, param_03);
  wait(1);
  level thread[[level.meleevignetteanimfunc]](self);
}

func_D571(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self.scripted_mode = 1;
  self.is_traversing = 1;
  self.vignette_nocorpse = 1;
  self.precacheleaderboards = 1;
  self gib_fx_override("noclip");
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "play_vignette_anim");
  self.hasplayedvignetteanim = 0;
  if(isDefined(self.spawner) && isDefined(self.spawner.var_ABA7)) {
    thread func_C3C6(param_00, param_01);
  }

  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_05 = 1;
  var_06 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_04, var_05);
  self.do_immediate_ragdoll = var_06;
  self gib_fx_override("gravity");
  self.scripted_mode = 0;
  self.precacheleaderboards = 0;
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "play_vignette_anim");
  self.vignette_nocorpse = undefined;
  self.hasplayedvignetteanim = 1;
  self notify("intro_vignette_done");
}

func_11702(param_00, param_01, param_02) {
  self gib_fx_override("gravity");
  self.scripted_mode = 0;
  self.hasplayedvignetteanim = 1;
  self.is_traversing = undefined;
  self.vignette_nocorpse = undefined;
}

func_ABA5(param_00, param_01) {
  self endon(param_01 + "_finished");
  var_02 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_03 = self getsafecircleorigin(param_01, var_02);
  var_04 = getanimlength(var_03);
  var_05 = getnotetracktimes(var_03, "fall");
  var_06 = getnotetracktimes(var_03, "land");
  var_07 = getmovedelta(var_03, var_05[0], var_06[0]);
  self scragentsetanimscale(1, 1);
  var_08 = 1;
  scripts\mp\agents\_scriptedagents::func_CED3(param_01, var_02, var_08, param_01, "fall", undefined);
  if(var_07 == (0, 0, 0)) {
    self gib_fx_override("gravity");
    return;
  }

  var_09 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_09 = self.spawner.var_ABA6;
  var_0A = var_09 - self.origin;
  var_0B = var_0A[2] / var_07[2];
  var_0C = var_04 * var_06[0] - var_04 * var_05[0];
  var_0D = var_0C * var_0B;
  if(var_0B >= 1) {
    self scragentsetanimscale(1, var_0B);
    var_08 = 1 / var_0B;
    scripts\mp\agents\_scriptedagents::func_CED3(param_01, var_02, var_08, param_01, "land", undefined);
    var_08 = 1;
    self gib_fx_override("gravity");
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(param_01, var_02, var_08, param_01, "end", undefined);
  }
}

func_C3C6(param_00, param_01) {
  self endon(param_01 + "_finished");
  var_02 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  var_03 = self getsafecircleorigin(param_01, var_02);
  var_04 = getanimlength(var_03);
  var_05 = getnotetracktimes(var_03, "fall");
  var_06 = getnotetracktimes(var_03, "land");
  var_07 = getmovedelta(var_03, var_05[0], var_06[0]);
  scripts\mp\agents\_scriptedagents::func_1384C(param_01, "fall", param_01, var_02, undefined);
  if(var_07 == (0, 0, 0)) {
    self gib_fx_override("gravity");
    return;
  }

  var_08 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_08 = self.spawner.var_ABA6;
  var_09 = var_08 - self.origin;
  var_0A = var_09[2] / var_07[2];
  var_0B = var_04 * var_06[0] - var_04 * var_05[0];
  var_0C = var_0B * var_0A;
  if(var_0A >= 1) {
    self scragentsetanimscale(1, var_0A);
    scripts\mp\agents\_scriptedagents::func_1384C(param_01, "land", param_01, var_02, undefined);
    self gib_fx_override("gravity");
    self scragentsetanimscale(1, 1);
  }
}

playingburningfx(param_00, param_01, param_02, param_03) {
  if(isDefined(self.spawner) && isDefined(self.spawner.var_ABA7)) {
    return 1;
  }

  return 0;
}

func_D544(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  lib_0F3C::func_CEA8(param_00, param_01, param_02, param_03);
  self.var_8C13 = 1;
}

turnintosuicidebomber(param_00) {
  self.entered_playspace = 1;
  self.is_suicide_bomber = 1;
  self.nocorpse = 1;
  self.should_play_transformation_anim = param_00;
  self.health = func_3725();
  self.precacheleaderboards = 0;
  self setscriptablepartstate("eyes", "eye_glow_off");
  self detachall();
  var_01 = ["park_clown_zombie", "park_clown_zombie_blue", "park_clown_zombie_green", "park_clown_zombie_orange", "park_clown_zombie_yellow"];
  var_02 = scripts\engine\utility::random(var_01);
  self setModel(var_02);
  scripts\asm\asm_bb::bb_requestmovetype("sprint");
  if(isDefined(level.suicider_avoidance_radius)) {
    self setavoidanceradius(level.suicider_avoidance_radius);
  }
}

func_3725() {
  var_00 = 200;
  switch (level.specialroundcounter) {
    case 0:
      var_00 = 100;
      break;

    case 1:
      var_00 = 400;
      break;

    case 2:
      var_00 = 900;
      break;

    case 3:
      var_00 = 1300;
      break;

    default:
      var_00 = 1600;
      break;
  }

  return var_00;
}

func_10057(param_00, param_01, param_02, param_03) {
  if(scripts\mp\agents\_scriptedagents::isstatelocked()) {
    return 0;
  }

  if(self.aistate == "traverse") {
    return 0;
  }

  if(isDefined(param_02) && isexplosivedamagemod(param_02) && param_00 >= 350) {
    if(isDefined(param_01) && !issubstr(param_01, "g18pap")) {
      return 1;
    }
  }

  if(isDefined(param_02) && param_02 == "MOD_MELEE") {
    return 1;
  }

  if(isDefined(self.stun_hit_time)) {
    if(self.stun_hit_time > gettime()) {
      return 1;
    } else {
      self.stun_hit_time = undefined;
      self.stunned = undefined;
    }
  }

  if(scripts\engine\utility::istrue(self.stunned)) {
    return 1;
  }

  if(isDefined(self.var_10058) && [[self.var_10058]]()) {
    return 1;
  }

  return 0;
}

func_FFE7() {
  if(!lib_0F3A::func_FFE6()) {
    return 0;
  }

  if(isDefined(self.curmeleetarget)) {
    return 0;
  }

  if(isDefined(self.var_6658)) {
    return 0;
  }

  return 1;
}

func_10092(param_00, param_01, param_02, param_03) {
  if(!func_FFE7()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_04 = scripts\asm\asm::asm_getcurrentstate(param_00);
  if(!scripts\asm\asm::func_232B(var_04, "cover_approach")) {
    return 0;
  }

  if(!isDefined(self.var_20EE)) {
    return 0;
  }

  if(isDefined(self.isfrozen) && self.isfrozen) {
    self.var_20EE = undefined;
    return 0;
  }

  if(!isDefined(param_03) || param_03.size < 1) {
    var_05 = "Exposed";
  } else {
    var_05 = var_04[0];
  }

  if(!lib_0F3A::func_9D4C(param_00, param_01, param_02, var_05)) {
    return 0;
  }

  self.asm.var_11068 = func_3724(param_00, param_02, var_05);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3724(param_00, param_01, param_02) {
  var_03 = lib_0F3A::func_7DD6();
  if(isDefined(var_03)) {
    var_04 = var_03.origin;
  } else {
    var_04 = self.vehicle_getspawnerarray;
  }

  var_05 = lib_0F3A::func_7E54();
  var_06 = self.var_20EE;
  var_07 = vectortoangles(var_06);
  if(isDefined(var_05)) {
    var_08 = angleclamp180(var_05[1] - var_07[1]);
  } else if(isDefined(var_04) && var_04.type != "Path") {
    var_08 = angleclamp180(var_04.angles[1] - var_08[1]);
  } else {
    var_09 = var_05 - self.origin;
    var_0A = vectortoangles(var_09);
    var_08 = angleclamp180(var_0A[1] - var_07[1]);
  }

  var_0B = param_01;
  var_0C = lib_0F3A::getweaponslistprimaries();
  var_0D = var_04 - self.origin;
  var_0E = lengthsquared(var_0D);
  var_0F = 0;
  var_10 = self getsafecircleorigin(var_0B, var_0F);
  var_11 = getmovedelta(var_10);
  var_12 = getangledelta(var_10);
  var_13 = length(self getvelocity());
  var_14 = var_13 * 0.053;
  var_15 = length(var_0D);
  var_16 = length(var_11);
  if(abs(var_15 - var_16) > var_14) {
    return undefined;
  }

  if(var_0E < lengthsquared(var_11)) {
    return undefined;
  }

  var_17 = lib_0F3A::func_36D9(var_0C.pos, var_0C.log[1], var_11, var_12);
  var_18 = getclosestpointonnavmesh(var_0C.pos, self);
  var_19 = lib_0F3A::func_36D9(var_18, var_0C.log[1], var_11, var_12);
  var_1A = self _meth_84AC();
  var_1B = navtrace(var_1A, var_18, self, 1);
  var_1C = var_1B["fraction"] >= 0.9 || navisstraightlinereachable(var_1A, var_18, self);
  if(!var_1C) {
    var_1D = self pathdisttogoal();
    var_1C = var_1D < distance(var_1A, var_18) + 8;
  }

  if(var_1C) {
    var_1E = spawnStruct();
    var_1E.var_11060 = var_0F;
    var_1E.var_3F = 0;
    var_1E.areanynavvolumesloaded = var_17;
    var_1E.var_3E = var_12;
    var_1E.angles = var_0C.angles;
    var_1E.log = var_0C.log;
    var_1E.var_11069 = var_11;
    var_1E.var_22ED = var_04;
    return var_1E;
  }

  return undefined;
}

func_D563(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_04.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_06 = var_05 - var_04.origin;
  var_07 = self getsafecircleorigin(param_01, 0);
  var_08 = getanimlength(var_07);
  var_09 = getmovedelta(var_07);
  var_0A = length(var_09);
  var_0B = length(var_05 - self.origin);
  var_0C = var_08 * var_0B / var_0A;
  self ghostexplode(self.origin, var_05, var_0C);
  self setanimstate(param_01, 0);
  wait(var_0C);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(param_00, param_01);
}

func_3F08(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return lib_0F3C::func_3EF4(param_00, param_01, param_02);
  }

  switch (self.var_1198.movetype) {
    case "walk":
    case "slow_walk":
      param_02 = param_02 + "_walk";
      break;

    case "sprint":
    case "run":
      param_02 = param_02 + "_run";
      break;

    default:
      param_02 = param_02 + "_walk";
      break;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, param_02);
}

func_D567(param_00, param_01, param_02, param_03) {
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoTraverse");
  var_04 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  func_5AC4(param_00, param_01, param_02, param_03);
  self.do_immediate_ragdoll = var_04;
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
}

func_5AC4(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8146();
  self.endnode_pos = var_05;
  if(!isDefined(var_04)) {
    return;
  }

  if(!isDefined(var_05)) {
    return;
  }

  self.var_6378 = var_05;
  self.traversalvector = vectornormalize(var_05 - var_04.origin);
  var_06 = undefined;
  var_06 = var_04.var_48;
  if(param_01 == "traverse_external") {
    var_06 = param_01;
  }

  if(func_BE90(var_06)) {
    var_06 = "crawling_" + var_06;
  }

  if(!isDefined(var_06)) {
    return;
  }

  self.is_traversing = 1;
  var_07 = scripts\asm\asm_mp::asm_getanim(param_00, var_06);
  var_08 = var_05 - var_04.origin;
  var_09 = (var_08[0], var_08[1], 0);
  var_0A = vectortoangles(var_09);
  var_0B = issubstr(var_06, "jump_across");
  var_0C = var_06 == "traverse_boost" && self.species == "humanoid" || self.species == "zombie";
  self orientmode("face angle abs", var_0A);
  self ghostlaunched("anim deltas");
  var_0D = self getsafecircleorigin(var_06, var_07);
  var_0E = "flex_height_up_start";
  var_0F = getnotetracktimes(var_0D, var_0E);
  if(var_0F.size == 0) {
    var_0E = "flex_height_start";
    var_0F = getnotetracktimes(var_0D, var_0E);
    if(var_0F.size == 0) {
      var_0E = "traverse_jump_start";
      var_0F = getnotetracktimes(var_0D, var_0E);
    }
  }

  var_10 = "flex_height_up_end";
  var_11 = getnotetracktimes(var_0D, var_10);
  if(var_11.size == 0) {
    var_10 = "flex_height_end";
    var_11 = getnotetracktimes(var_0D, var_10);
    if(var_11.size == 0) {
      var_10 = "traverse_jump_end";
      var_11 = getnotetracktimes(var_0D, var_10);
    }
  }

  var_12 = "highest_point";
  var_13 = getnotetracktimes(var_0D, var_12);
  var_14 = "flex_height_down_start";
  var_15 = getnotetracktimes(var_0D, var_14);
  var_16 = "flex_height_down_end";
  var_17 = getnotetracktimes(var_0D, var_16);
  var_18 = "crawler_early_stop";
  var_19 = getnotetracktimes(var_0D, var_18);
  var_1A = getnotetracktimes(var_0D, "code_move");
  if(var_1A.size > 0) {
    var_1B = getmovedelta(var_0D, 0, var_1A[0]);
  } else {
    var_1B = getmovedelta(var_0E, 0, 1);
  }

  var_1C = scripts\mp\agents\_scriptedagents::func_7DC9(var_08, var_1B);
  var_1D = animhasnotetrack(var_0D, "ignoreanimscaling");
  if(var_1D) {
    var_1C.var_13E2B = 1;
  }

  self gib_fx_override("noclip");
  var_1E = self _meth_8145();
  if(isDefined(var_1E) && isDefined(var_1E.target)) {
    self.endnode = var_1E;
    if(var_13.size > 0) {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart", var_07, var_0D, "traverse", var_0E, var_12, 0, ::func_13FAE);
      var_1F = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
      if(isDefined(var_1F.script_noteworthy) && var_1F.script_noteworthy == "continue_flex_height") {
        scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart", var_07, var_0D, "traverse", var_12, var_10, 1, ::func_13FAE);
      }

      self scragentsetanimscale(1, 1);
      scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart", var_07, "traverse", "end", ::func_13FAE);
    } else if(var_15.size == 0) {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart", var_07, var_0D, "traverse", var_0E, var_10, 0, ::func_13FAE);
      self scragentsetanimscale(1, 1);
      scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart", var_07, "traverse", "end", ::func_13FAE);
    } else {
      var_1F = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
      var_20 = var_15[0];
      scripts\mp\agents\_scriptedagents::func_5AC2(var_06 + "_norestart", var_07, "traverse", var_0D, var_0E, var_10, var_1F.origin, var_20, ::func_13FAE);
      if(var_15[0] - var_11[0] > 0.02) {
        self scragentsetanimscale(1, 1);
        scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart", var_07, "traverse", var_14, ::func_13FAE);
      }

      var_1F = self.endnode;
      var_20 = var_17[0];
      scripts\mp\agents\_scriptedagents::func_5AC2(var_06 + "_norestart", var_07, "traverse", var_0D, var_14, var_16, var_1F.origin, var_20, ::func_13FAE);
      self scragentsetanimscale(1, 1);
      if(var_19.size == 0 || !scripts\engine\utility::istrue(self.dismember_crawl)) {
        scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart", var_07, "traverse", "end", ::func_13FAE);
      }
    }

    self.endnode = undefined;
  } else if(var_15.size > 0 && var_17.size > 0 && self.agent_type != "zombie_brute") {
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED5(var_06 + "_norestart", var_07, "traverse", "end", ::func_13FAE);
  } else if(var_0B && abs(var_08[2]) < 48) {
    var_21 = getanimlength(var_0D);
    var_22 = var_0F[0] * var_21;
    var_23 = var_11[0] * var_21;
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, self.traverseratescale, "traverse", var_0E);
    self scragentsetanimscale(1, 0);
    childthread func_126D8(var_04.origin[2], var_05[2], var_23 - var_22 / self.traverseratescale);
    scripts\mp\agents\_scriptedagents::func_CED3(var_06 + "_norestart", var_07, self.traverseratescale, "traverse", var_10);
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(var_06 + "_norestart", var_07, self.traverseratescale, "traverse");
  } else if(var_08[2] > 16) {
    if(var_1B[2] > 0) {
      if(var_0C) {
        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        var_24 = clamp(2 / var_1C.var_3A6, 0.5, 1);
        if(var_11.size > 0) {
          scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, var_24 * self.traverseratescale, "traverse", var_10);
          scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
          var_25 = var_06 + "_norestart";
          scripts\mp\agents\_scriptedagents::func_F2B1(var_25, var_07, self.traverseratescale);
          scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
        } else {
          scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, self.traverseratescale, "traverse");
        }

        self scragentsetanimscale(1, 1);
      } else if(var_0F.size > 0) {
        var_1C.var_13E2B = 1;
        var_1C.var_3A6 = 1;
        if(!var_1D && length2dsquared(var_09) < 0.64 * length2dsquared(var_1B)) {
          var_1C.var_13E2B = 0.4;
        }

        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, self.traverseratescale, "traverse", var_0E);
        var_26 = getmovedelta(var_0D, 0, var_0F[0]);
        var_27 = getmovedelta(var_0D, 0, var_11[0]);
        var_1C.var_13E2B = 1;
        var_1C.var_3A6 = 1;
        var_28 = var_05 - self.origin;
        var_29 = var_1B - var_26;
        if(!var_1D && length2dsquared(var_28) < 0.5625 * length2dsquared(var_29)) {
          var_1C.var_13E2B = 0.75;
        }

        var_2A = var_1B - var_27;
        var_2B = (var_2A[0] * var_1C.var_13E2B, var_2A[1] * var_1C.var_13E2B, var_2A[2] * var_1C.var_3A6);
        var_2C = rotatevector(var_2B, var_0A);
        var_2D = var_05 - var_2C;
        var_2E = var_27 - var_26;
        var_2F = rotatevector(var_2E, var_0A);
        var_30 = var_2D - self.origin;
        var_31 = var_1C;
        var_1C = scripts\mp\agents\_scriptedagents::func_7DC9(var_30, var_2F, 1);
        if(var_1D) {
          var_1C.var_13E2B = 1;
        }

        if(var_30[2] <= 0) {
          var_1C.var_3A6 = 0;
        }

        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_1384D("traverse", var_10);
        scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
        var_1C = var_31;
        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
      } else {
        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, self.traverseratescale, "traverse");
      }
    } else {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_06 + "_norestart", var_07, var_0D, "traverse", "flex_height_start", "flex_height_end", 1, ::func_13FAE);
    }
  } else if(abs(var_08[2]) < 16 || var_1B[2] == 0) {
    self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
    var_24 = clamp(2 / var_1C.var_3A6, 0.5, 1);
    if(var_11.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, var_24 * self.traverseratescale, "traverse", var_10);
      scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
      var_25 = var_06 + "_norestart";
      scripts\mp\agents\_scriptedagents::func_F2B1(var_25, var_07, self.traverseratescale);
      scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
    } else {
      scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, self.traverseratescale, "traverse");
    }

    self scragentsetanimscale(1, 1);
  } else if(var_1B[2] < 0) {
    self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
    var_24 = clamp(2 / var_1C.var_3A6, 0.5, 1);
    var_33 = var_06 + "_norestart";
    if(var_0F.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, self.traverseratescale, "traverse", var_0E);
      var_06 = var_33;
    }

    if(var_11.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, var_24 * 1, "traverse", var_10);
      scripts\mp\agents\_scriptedagents::func_F2B1(var_33, var_07, self.traverseratescale);
      if(animhasnotetrack(var_0D, "removestatelock")) {
        scripts\mp\agents\_scriptedagents::func_1384D("traverse", "removestatelock");
      }

      scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
      scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
    } else {
      scripts\mp\agents\_scriptedagents::func_CED3(var_06, var_07, 1, "traverse");
    }

    self scragentsetanimscale(1, 1);
  } else {}

  func_ABB8();
  self gib_fx_override("gravity");
  self.is_traversing = undefined;
  self notify("traverse_end");
  func_11701(param_00, param_01);
}

func_126D8(param_00, param_01, param_02) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_03 = gettime();
  for(;;) {
    var_04 = gettime() - var_03 / 1000;
    var_05 = var_04 / param_02;
    if(var_05 > 1) {
      break;
    }

    var_06 = scripts\mp\agents\zombie\zombie_util::func_AB6F(var_05, param_00, param_01);
    self setorigin((self.origin[0], self.origin[1], var_06), 0);
    wait(0.05);
  }
}

func_BE90(param_00) {
  if(self.dismember_crawl) {
    return 1;
  }

  return 0;
}

func_ABB8() {
  var_00 = 0.1;
  var_01 = self.var_6378;
  var_02 = var_01[2];
  var_03 = self.origin[2];
  if(var_03 < var_02) {
    self setorigin((self.origin[0], self.origin[1], var_02 + var_00), 0);
  }
}

func_11706(param_00, param_01, param_02) {
  self.is_traversing = undefined;
}

func_11701(param_00, param_01) {
  var_02 = level.asm[param_00].states[param_01];
  var_03 = undefined;
  if(isDefined(var_02.var_116FB)) {
    if(isarray(var_02.var_116FB[0])) {
      var_03 = var_02.var_116FB[0];
    } else {
      var_03 = var_02.var_116FB;
    }
  }

  scripts\asm\asm::func_2388(param_00, param_01, var_02, var_02.var_116FB);
  scripts\asm\asm::func_238A(param_00, var_03, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_D4E3(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  self.asm.cur_move_mode = param_03;
  lib_0F3C::func_D4DD(param_00, param_01, param_02, param_03);
  scripts\asm\asm::func_237B(1);
}

func_CEAE(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  lib_0F3A::func_CEAA(param_00, param_01, param_02, param_03);
}

func_CEB7(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  lib_0F3B::func_CEB5(param_00, param_01, param_02, param_03);
  scripts\asm\asm::func_237B(1);
}

func_D515(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  lib_0F3B::func_D514(param_00, param_01, param_02, param_03);
  scripts\asm\asm::func_237B(self.moveratescale);
}

func_D538(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  if(scripts\mp\agents\zombie\zombie_util::_meth_8252() < 2) {
    var_04 = level.var_BCE6["run"][1];
    var_04 = var_04 + self.moveratescale - level.var_BCE6["sprint"][0];
    scripts\asm\asm::func_237B(var_04);
  }

  lib_0F3B::func_D514(param_00, param_01, param_02, param_03);
  scripts\asm\asm::func_237B(self.moveratescale);
}

func_13FAE(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "apply_physics":
      self gib_fx_override("gravity");
      break;

    default:
      break;
  }
}

func_7389(param_00, param_01, param_02, param_03) {
  param_01 = self.var_7387;
  level thread[[level.frozenzombiefunc]](self);
  var_04 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  if(scripts\engine\utility::istrue(self.activated_slomo_sphere)) {
    scripts\asm\asm_mp::func_2365(param_00, param_01, 0.1, var_04, 0.2);
    return;
  }

  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    scripts\asm\asm_mp::func_2365(param_00, param_01, 0.1, var_04, 0.2);
    return;
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, 0.1, var_04, 0.001);
}

func_3E12(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.isfrozen)) {
    if(isDefined(param_03)) {
      self.var_7387 = param_03;
    } else {
      self.var_7387 = scripts\asm\asm::asm_getcurrentstate(param_00);
    }

    return 1;
  }

  return 0;
}

func_3E18(param_00, param_01, param_02, param_03) {
  if(!scripts\engine\utility::istrue(self.isfrozen)) {
    self.var_7387 = undefined;
    return 1;
  }

  return 0;
}

func_631D(param_00, param_01, param_02, param_03) {
  self.var_7387 = undefined;
  level thread[[level.thawzombiefunc]](self);
}

func_A013() {
  if(self _meth_84B9(200)) {
    return 1;
  }

  return 0;
}

func_38B2(param_00, param_01, param_02) {
  var_03 = 0.5;
  var_04 = getnotetracktimes(param_00, "turn_extent");
  if(var_04.size == 1) {
    var_03 = var_04[0];
  } else {
    var_05 = getnotetracktimes(param_00, "code_move");
    if(var_05.size == 1) {
      var_03 = var_05[0] * 0.5;
    }
  }

  var_06 = 1;
  var_07 = getnotetracktimes(param_00, "finish");
  if(var_07.size == 0) {
    var_07 = getnotetracktimes(param_00, "end");
  }

  if(var_07.size == 1) {
    var_06 = var_07[0];
  }

  var_08 = getmovedelta(param_00, 0, var_03);
  var_09 = getmovedelta(param_00, 0, var_06);
  var_0A = self.origin;
  var_0B = rotatevector(var_08, param_01) + var_0A;
  var_0C = rotatevector(var_09, param_01) + var_0A;
  if(!scripts\mp\agents\_scriptedagents::func_38D0(var_0B, var_0C, 0)) {
    return 0;
  }

  var_0D = self.fgetarg;
  if(!param_02) {
    var_0D = self.fgetarg / 2;
  }

  if(!scripts\mp\agents\_scriptedagents::func_38D0(var_0A, var_0B, 0, var_0D)) {
    return 0;
  }

  return 1;
}

func_6BC6(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.is_dancing)) {
    return 1;
  }

  return 0;
}

isdoublejumpanimdone(param_00, param_01, param_02, param_03) {
  if(func_6BC6(param_00, param_01, param_02, param_03)) {
    return 0;
  }

  self.var_2CA7 = undefined;
  return 1;
}

func_CEF3(param_00, param_01, param_02, param_03) {
  self orientmode("face angle abs", self.desired_dance_angles);
  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, 1, 0);
}

func_3EBE(param_00, param_01, param_02) {
  if(isDefined(self.var_2CA7)) {
    return self.var_2CA7;
  }

  if(self.dismember_crawl) {
    func_F2E5();
    self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "boombox_dance_crawl_" + level.var_2C9A);
    return self.var_2CA7;
  }

  if(scripts\engine\utility::istrue(self.var_9B6E)) {
    self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "disco_dance_center_" + randomintrange(0, 4));
    return self.var_2CA7;
  }

  if(scripts\engine\utility::istrue(self.fridge_trap_marked)) {
    self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "fridge_lured_anim_" + randomintrange(0, 4));
    return self.var_2CA7;
  }

  func_F2E6();
  self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "boombox_dance_" + level.var_2C9B);
  return self.var_2CA7;
}

func_F2E6() {
  if(!isDefined(level.var_2C9B)) {
    level.var_2C9B = 0;
  }

  level.var_2C9B++;
  if(level.var_2C9B > 5) {
    level.var_2C9B = 0;
  }
}

func_F2E5() {
  if(!isDefined(level.var_2C9A)) {
    level.var_2C9A = 0;
  }

  level.var_2C9A++;
  if(level.var_2C9A > 1) {
    level.var_2C9A = 0;
  }
}

func_BE8D(param_00, param_01, param_02, param_03) {
  return 0;
}

func_3EFE(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(self.upgraded_dischord_spin)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "upgraded");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "normal");
}

func_98DC(param_00, param_01, param_02, param_03) {
  return 0;
}

func_BE94(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_6658)) {
    return 0;
  }

  if(!scripts\engine\utility::istrue(self.bneedtoenterplayspace) || scripts\engine\utility::istrue(self.entered_playspace)) {
    return 0;
  }

  if(!isDefined(level.fn_get_closest_entrance)) {
    return 0;
  }

  if(!isDefined(self.var_429D)) {
    self.var_429D = [[level.fn_get_closest_entrance]](self.origin);
    if(!isDefined(self.var_429D)) {
      iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
      return 0;
    }
  } else if(!scripts\asm\asm_bb::bb_moverequested()) {
    self.var_429D = scripts\cp\zombies\zombie_entrances::func_7B14(self.origin, self.var_429D);
    if(!isDefined(self.var_429D)) {
      self.died_poorly = 1;
      self dodamage(self.health + 950, self.origin, self, self, "MOD_SUICIDE");
      return 0;
    }
  }

  self ghostskulls_total_waves(4);
  self ghostskulls_complete_status(self.var_429D.origin);
  if(!scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  self.var_6658 = self.var_429D;
  self.var_429D = undefined;
  return 1;
}

func_3ED7(param_00, param_01, param_02) {
  if(isDefined(self.var_662F)) {
    return self.var_662F;
  }

  var_03 = self.attack_spot;
  var_04 = undefined;
  if(!isDefined(var_03.script_label)) {
    var_04 = "mid";
  } else {
    var_04 = var_03.script_label;
  }

  if(scripts\engine\utility::istrue(var_03.var_2A9F)) {
    var_04 = var_04 + "_extended";
  }

  self.var_662F = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_04);
  return self.var_662F;
}

func_3EBA(param_00, param_01, param_02) {
  var_03 = self.attack_spot;
  var_04 = "standing_";
  if(func_BE92()) {
    var_04 = "crawling_";
  }

  if(!isDefined(var_03.script_label)) {
    var_04 = var_04 + "mid";
  } else {
    var_04 = var_04 + var_03.script_label;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_04);
}

func_116E8(param_00, param_01, param_02) {
  if(isDefined(self.var_BF2F)) {
    var_03 = scripts\cp\zombies\zombie_entrances::func_7872(self.var_6658, self.var_BF2F - 1);
    if(var_03 == "destroying") {
      scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, self.var_BF2F - 1, "boarded");
    }

    self.var_BF2F = undefined;
  }
}

func_3ECF(param_00, param_01, param_02) {
  var_03 = self.attack_spot;
  if(scripts\engine\utility::istrue(self.isfrozen)) {
    if(isDefined(self.var_BF2F)) {
      scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, self.var_BF2F - 1, "boarded");
      self.var_BF2F = undefined;
    }

    return self.var_A93A;
  }

  if(self.dismember_crawl) {
    if(!isDefined(var_03.script_label)) {
      self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(param_01, "crawling");
      return self.var_A93A;
    }

    var_04 = func_F496();
    var_05 = "crawling_" + var_03.script_label + "_" + var_04;
    self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_05);
    return self.var_A93A;
  }

  if(!isDefined(var_05.script_label)) {
    self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_03, "standing");
    return self.var_A93A;
  }

  while(isDefined(self.var_BF2F)) {
    wait(0.05);
  }

  var_04 = func_F496();
  var_05 = "standing_" + var_04.script_label + "_" + var_05;
  self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(param_01, var_05);
  return self.var_A93A;
}

func_F496() {
  var_00 = scripts\cp\zombies\zombie_entrances::func_7B12(self.var_6658);
  self.var_BF2F = var_00;
  scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, self.var_BF2F - 1, "destroying");
  return var_00;
}

func_3F13(param_00, param_01, param_02) {
  if(self.dismember_crawl) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "crawling");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "standing");
}

func_532D(param_00, param_01, param_02, param_03) {
  if(param_00 == "board_break" || param_00 == "hit") {
    if(!isDefined(self.var_BF2F)) {
      return;
    }

    var_04 = self.var_BF2F;
    self.var_BF2F = undefined;
    scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, var_04 - 1, "destroyed");
    scripts\cp\zombies\zombie_entrances::remove_barrier_from_entrance(self.var_6658, var_04);
  }
}

is_player_near_interaction_point(param_00, param_01) {
  var_02 = 2304;
  return distancesquared(param_00.origin, param_01.origin) < var_02;
}

func_252C(param_00, param_01, param_02, param_03) {
  if(param_00 == "hit") {
    var_04 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);
    if(is_player_near_interaction_point(self.closest_player_near_interaction_point, var_04)) {
      scripts\asm\zombie\melee::domeleedamage(self.closest_player_near_interaction_point, 45, "MOD_IMPACT");
    }
  }
}

func_CEE3(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self orientmode("face angle abs", self.attack_spot.angles);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_CF19(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self orientmode("face angle abs", self.attack_spot.angles);
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

func_662E(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", self.attack_spot.angles);
  self gib_fx_override("noclip");
  self clearpath();
  self scragentsetscripted(1);
  self.do_immediate_ragdoll = 1;
  self.is_traversing = 1;
  if(isDefined(self.attack_spot.script_parameters) && self.attack_spot.script_parameters == "script_adjust") {
    var_04 = anglesToForward(self.attack_spot.angles);
    var_04 = vectornormalize(var_04);
    var_04 = var_04 * -3.5;
    var_04 = (var_04[0], var_04[1], -1);
    self setorigin(self.origin + var_04, 0);
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, scripts\asm\asm_mp::asm_getanim(param_00, param_01), self.traverseratescale);
  self.do_immediate_ragdoll = 0;
  self.full_gib = 0;
  self.nocorpse = undefined;
  self scragentsetscripted(0);
  self gib_fx_override("gravity");
  self.entered_playspace = 1;
  self.bneedtoenterplayspace = undefined;
  self.var_6659 = undefined;
  self.var_6658 = undefined;
  self.var_BF2F = undefined;
  self.is_traversing = undefined;
  self ghostskulls_total_waves(4);
  self ghostskulls_complete_status(self.origin);
  scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
  self.attack_spot = undefined;
}

func_BA3E() {
  self endon("death");
  self.noturnanims = 1;
  self.entered_playspace = 1;
  self.full_gib = 1;
  self.nocorpse = 1;
  self.deathmethod = "window";
  self waittill("goal_reached");
  self.full_gib = 0;
  self.nocorpse = undefined;
  self.deathmethod = undefined;
  self.entered_playspace = 1;
  self.bneedtoenterplayspace = undefined;
  self.var_6659 = undefined;
  self.var_6658 = undefined;
  self.var_BF2F = undefined;
  scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
  self.attack_spot = undefined;
}

func_1305A(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.attack_spot.target)) {
    return 0;
  }

  var_04 = getnodearray(self.attack_spot.target, "targetname");
  if(!isDefined(var_04) || var_04.size == 0) {
    return 0;
  }

  var_05 = var_04[0];
  if(!isDefined(var_05) || !isDefined(var_05.var_48)) {
    return 0;
  }

  var_04 = getnodearray(var_05.target, "targetname");
  if(!isDefined(var_04) || var_04.size == 0) {
    return 0;
  }

  var_06 = var_04[0];
  self ghostskulls_complete_status(var_06.origin);
  self.var_6659 = 0;
  thread func_BA3E();
  return 1;
}

func_BA3D() {
  self endon("death");
  self.noturnanims = 1;
  self.despawncovernode = 200;
  self _meth_84BD();
  self waittill("stop_soon");
  self.attack_spot = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(self.var_6658);
  if(!scripts\cp\zombies\zombie_entrances::func_9CD3(self.attack_spot)) {
    scripts\cp\zombies\zombie_entrances::func_3FF0(self.attack_spot);
  } else {
    self ghostskulls_complete_status(self.origin);
    while(func_BE93()) {
      var_00 = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(self.var_6658);
      if(isDefined(var_00) && !scripts\cp\zombies\zombie_entrances::func_9CD3(var_00)) {
        self.attack_spot = var_00;
        scripts\cp\zombies\zombie_entrances::func_3FF0(self.attack_spot);
        break;
      }

      self.var_331F = 1;
      wait(0.05);
    }

    self.var_331F = undefined;
  }

  var_01 = getclosestpointonnavmesh(self.attack_spot.origin, self);
  var_02 = (self.attack_spot.origin[0], self.attack_spot.origin[1], var_01[2]);
  self ghostskulls_complete_status(var_02);
  self waittill("goal_reached");
  var_03 = (self.attack_spot.origin[0], self.attack_spot.origin[1], self.origin[2]);
  self setorigin(var_03, 0);
  self.noturnanims = 0;
  scripts\cp\zombies\zombie_entrances::func_E005(self.var_6658);
  self.var_6659 = 1;
}

func_5AEE(param_00, param_01, param_02, param_03) {
  self.var_6659 = 0;
  scripts\cp\zombies\zombie_entrances::func_16D1(self.var_6658);
  self ghostskulls_total_waves(4);
  self ghostskulls_complete_status(self.var_6658.origin);
  thread func_BA3D();
  return 1;
}

func_DD1E(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(self.var_6659)) {
    return 1;
  }

  return 0;
}

func_BE93(param_00, param_01, param_02, param_03) {
  var_04 = scripts\cp\zombies\zombie_entrances::func_7B12(self.var_6658);
  if(!isDefined(var_04)) {
    return 0;
  }

  return 1;
}

func_13F9B(param_00, param_01, param_02, param_03) {
  scripts\asm\asm_bb::bb_clearmeleerequestcomplete();
  return 1;
}

func_10007(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.asm.cur_move_mode)) {
    return 0;
  }

  switch (self.asm.cur_move_mode) {
    case "walk":
    case "slow_walk":
      return 0;
  }

  return 1;
}

func_FFC0(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_7089)) {
    return 0;
  }

  if(func_BE92()) {
    return 0;
  }

  var_04 = "mid";
  if(isDefined(self.attack_spot.script_label)) {
    var_04 = self.attack_spot.script_label;
  }

  self.closest_player_near_interaction_point = [
    [level.var_7089]
  ](self);
  if(!isDefined(self.closest_player_near_interaction_point)) {
    return 0;
  }

  if(randomint(100) > 50) {
    return 0;
  }

  return 1;
}

func_9FF5(param_00, param_01, param_02, param_03) {
  if(scripts\engine\utility::istrue(level.var_2AAD)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(self.var_331F)) {
    return 1;
  }

  return 0;
}

isdowned(param_00, param_01, param_02, param_03) {
  return !func_9FF5(param_00, param_01, param_02, param_03);
}

func_3F0B(param_00, param_01, param_02) {
  var_03 = "standing";
  if(func_BE92()) {
    var_03 = "crawling";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

func_1002F(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie\melee::func_138E4() && !scripts\engine\utility::istrue(self.stunned);
}

func_1003A(param_00, param_01, param_02, param_03) {
  if(self.hasplayedvignetteanim) {
    if(scripts\asm\asm_bb::bb_moverequested()) {
      return 1;
    }

    if(isDefined(self.spawner) && isDefined(self.spawner.script_animation) && self.spawner.script_animation == "spawn_wall_low") {
      return 1;
    }
  }

  return 0;
}
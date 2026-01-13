/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3189.gsc
*********************************************/

func_13F9A(var_0, var_1, var_2, var_3) {
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

func_3EFC(var_0, var_1, var_2) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_3 = "";
    switch (self.synctransients) {
      case "walk":
      case "slow_walk":
        var_3 = "_walk";
        break;

      case "sprint":
      case "run":
        var_3 = "_run";
        break;

      default:
        break;
    }

    if(scripts\asm\asm_mp::func_2347(var_1, self.spawner.script_animation + var_3)) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation + var_3);
    } else if(scripts\asm\asm_mp::func_2347(var_1, self.spawner.script_animation)) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation);
    }
  }

  if(!isDefined(var_2)) {
    return lib_0F3C::func_3EF4(var_0, var_1, var_2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

func_3EFB(var_0, var_1, var_2) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_3 = "";
    switch (self.synctransients) {
      case "walk":
      case "slow_walk":
        var_3 = "_walk";
        break;

      case "sprint":
      case "run":
        var_3 = "_run";
        break;

      default:
        break;
    }

    if(scripts\asm\asm_mp::func_2347(var_1, self.spawner.script_animation + var_3)) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation + var_3);
    } else if(scripts\asm\asm_mp::func_2347(var_1, self.spawner.script_animation)) {
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation);
    }
  }

  if(!isDefined(var_2)) {
    return lib_0F3C::func_3EF4(var_0, var_1, var_2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

func_3EE0(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return lib_0F3C::func_3EF4(var_0, var_1, var_2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

func_3EE1(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = self getanimentrycount(var_1);
  if(var_5 == 1) {
    self.var_BC09[var_1] = 0;
  } else if(!isDefined(self.var_BC09[var_1])) {
    self.var_BC09[var_1] = randomintrange(0, var_5);
  }

  self.asm.var_BCD3 = tolower(self.var_BC09[var_1] + 1);
  if(isDefined(var_2)) {
    self.asm.var_BCD3 = var_2 + self.asm.var_BCD3;
  }

  return self.var_BC09[var_1];
}

func_3EF1(var_0, var_1, var_2, var_3) {
  var_4 = self getanimentrycount(var_1);
  var_5 = scripts\mp\agents\zombie\zombie_util::func_4D52(self.var_4D62, self.var_DC);
  var_6 = angleclamp180(var_5 - self.angles[1]);
  var_7 = scripts\mp\agents\zombie\zombie_util::botmemoryevent(var_6, var_4);
  return var_7;
}

func_D4F5(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(isDefined(self.vehicle_getspawnerarray)) {
    self ghostlaunched("code_move");
    self orientmode("face motion");
  }

  var_5 = self getsafecircleorigin(var_1, var_4);
  var_6 = getanimlength(var_5);
  var_7 = 1;
  if(isDefined(self.var_C081) && self.var_C081 > 0) {
    var_7 = self.var_C081;
  }

  var_6 = var_6 * 1 / var_7;
  self.var_BF9E = gettime() + var_6 * 0.75 * 1000;
  scripts\mp\agents\_scriptedagents::func_CED3(var_1, var_4, self.var_C081, "pain_anim");
  func_6CE0(var_0, var_1, var_3);
}

func_D4F3(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");
  if(scripts\asm\asm_mp::func_2347(var_1, self.asm.var_BCD3)) {
    var_4 = scripts\asm\asm_mp::func_235A(var_1, self.asm.var_BCD3);
  } else {
    var_4 = lib_0F3C::func_3EF4(var_1, var_2, var_4);
  }

  var_5 = scripts\asm\asm::func_2341(var_0, var_1);
  thread scripts\mp\agents\_scriptedagents::func_CED5(var_1, var_4, var_1, "end", var_5);
  self.var_BF9E = gettime() + 10000;
  wait(0.35);
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

func_9DB2(var_0, var_1, var_2, var_3) {
  var_4 = func_4D41();
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && isDefined(var_4) && var_4 >= 0) {
    return 1;
  }

  return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand", "left_leg_upper", "left_foot", "left_leg_lower");
}

func_9DB3(var_0, var_1, var_2, var_3) {
  var_4 = func_4D41();
  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && isDefined(var_4) && var_4 < 0) {
    return 1;
  }

  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "right_leg_upper", "right_foot", "right_leg_lower");
}

func_9DB1(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");
}

func_4D41() {
  var_0 = scripts\mp\agents\zombie\zombie_util::func_4D52(self.var_4D62, self.var_DC);
  var_1 = angleclamp180(var_0 - self.angles[1]);
  return var_1;
}

func_6CE0(var_0, var_1, var_2) {
  self notify("killanimscript");
  var_3 = level.asm[var_0].states[var_1];
  var_4 = undefined;
  if(isarray(var_2)) {
    var_4 = var_2[0];
  } else {
    var_4 = var_2;
  }

  if(!isDefined(var_4)) {
    if(isDefined(var_3.transitions) && var_3.transitions.size > 0) {
      return;
    }

    var_4 = "choose_idle";
  }

  scripts\asm\asm::func_2388(var_0, var_1, var_3, var_3.var_116FB);
  scripts\asm\asm::func_238A(var_0, var_4, 0.2, undefined, undefined, undefined);
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

func_9E89(var_0) {
  switch (var_0) {
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

func_9EAB(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_BE92() {
  if(isDefined(self.dismember_crawl)) {
    return self.dismember_crawl;
  }

  return 0;
}

func_BE99(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_BE9A(var_0, var_1, var_2, var_3) {
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

func_BE95(var_0, var_1, var_2, var_3) {
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

  var_0 = isDefined(self.asm.cur_move_mode) && self.asm.cur_move_mode != self._blackboard.movetype;
  if(var_0) {
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

func_9D8C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.is_suicide_bomber)) {
    return 1;
  }

  return 0;
}

iscorempgametype(var_0, var_1, var_2, var_3) {
  if(self.agent_type == "zombie_cop") {
    if(getdvarint("scr_dont_use_cop_anims") != 0) {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_1005E(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::istrue(self.is_traversing) && !scripts\engine\utility::istrue(self.customdeath)) {
    return scripts\mp\agents\zombie\zmb_zombie_agent::dying_zapper_death();
  }

  return 0;
}

func_10046(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.rocket_feet);
}

choosefacemelteranim(var_0, var_1, var_2, var_3) {
  self notify("facemelter_launch_chosen");
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return "prone_launch";
  }

  return "launch";
}

func_6A79(var_0, var_1, var_2, var_3) {
  self notify("ready_to_launch");
}

shouldplaybalconydeath(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.dischord_spin);
}

choosedischordanim(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return "prone_spin";
  }

  return "spin";
}

func_5626(var_0, var_1, var_2, var_3) {
  self notify("ready_to_spin");
}

func_10049(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.head_is_exploding);
}

chooseheadcutteranim(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return "prone_expand_head";
  }

  return "expand_head";
}

func_10053(var_0, var_1, var_2, var_3) {
  return 0;
}

func_D532(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.scripted_mode = 1;
  self gib_fx_override("noclip");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = 0.01;
  thread scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, var_5);
  if(isDefined(level.spawn_fx_func)) {
    self[[level.spawn_fx_func]]();
  }

  wait(0.5);
  self.var_8C12 = 1;
}

func_D4DB(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.scripted_mode = 1;
  self gib_fx_override("noclip");
  thread lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
  wait(1);
  level thread[[level.meleevignetteanimfunc]](self);
}

func_D571(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.scripted_mode = 1;
  self.is_traversing = 1;
  self.vignette_nocorpse = 1;
  self.precacheleaderboards = 1;
  self gib_fx_override("noclip");
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "play_vignette_anim");
  self.hasplayedvignetteanim = 0;
  if(isDefined(self.spawner) && isDefined(self.spawner.var_ABA7)) {
    thread func_C3C6(var_0, var_1);
  }

  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = 1;
  var_6 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, var_5);
  self.do_immediate_ragdoll = var_6;
  self gib_fx_override("gravity");
  self.scripted_mode = 0;
  self.precacheleaderboards = 0;
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "play_vignette_anim");
  self.vignette_nocorpse = undefined;
  self.hasplayedvignetteanim = 1;
  self notify("intro_vignette_done");
}

func_11702(var_0, var_1, var_2) {
  self gib_fx_override("gravity");
  self.scripted_mode = 0;
  self.hasplayedvignetteanim = 1;
  self.is_traversing = undefined;
  self.vignette_nocorpse = undefined;
}

func_ABA5(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_3 = self getsafecircleorigin(var_1, var_2);
  var_4 = getanimlength(var_3);
  var_5 = getnotetracktimes(var_3, "fall");
  var_6 = getnotetracktimes(var_3, "land");
  var_7 = getmovedelta(var_3, var_5[0], var_6[0]);
  self scragentsetanimscale(1, 1);
  var_8 = 1;
  scripts\mp\agents\_scriptedagents::func_CED3(var_1, var_2, var_8, var_1, "fall", undefined);
  if(var_7 == (0, 0, 0)) {
    self gib_fx_override("gravity");
    return;
  }

  var_9 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_9 = self.spawner.var_ABA6;
  var_0A = var_9 - self.origin;
  var_0B = var_0A[2] / var_7[2];
  var_0C = var_4 * var_6[0] - var_4 * var_5[0];
  var_0D = var_0C * var_0B;
  if(var_0B >= 1) {
    self scragentsetanimscale(1, var_0B);
    var_8 = 1 / var_0B;
    scripts\mp\agents\_scriptedagents::func_CED3(var_1, var_2, var_8, var_1, "land", undefined);
    var_8 = 1;
    self gib_fx_override("gravity");
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(var_1, var_2, var_8, var_1, "end", undefined);
  }
}

func_C3C6(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_3 = self getsafecircleorigin(var_1, var_2);
  var_4 = getanimlength(var_3);
  var_5 = getnotetracktimes(var_3, "fall");
  var_6 = getnotetracktimes(var_3, "land");
  var_7 = getmovedelta(var_3, var_5[0], var_6[0]);
  scripts\mp\agents\_scriptedagents::func_1384C(var_1, "fall", var_1, var_2, undefined);
  if(var_7 == (0, 0, 0)) {
    self gib_fx_override("gravity");
    return;
  }

  var_8 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_8 = self.spawner.var_ABA6;
  var_9 = var_8 - self.origin;
  var_0A = var_9[2] / var_7[2];
  var_0B = var_4 * var_6[0] - var_4 * var_5[0];
  var_0C = var_0B * var_0A;
  if(var_0A >= 1) {
    self scragentsetanimscale(1, var_0A);
    scripts\mp\agents\_scriptedagents::func_1384C(var_1, "land", var_1, var_2, undefined);
    self gib_fx_override("gravity");
    self scragentsetanimscale(1, 1);
  }
}

playingburningfx(var_0, var_1, var_2, var_3) {
  if(isDefined(self.spawner) && isDefined(self.spawner.var_ABA7)) {
    return 1;
  }

  return 0;
}

func_D544(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
  self.var_8C13 = 1;
}

turnintosuicidebomber(var_0) {
  self.entered_playspace = 1;
  self.is_suicide_bomber = 1;
  self.nocorpse = 1;
  self.should_play_transformation_anim = var_0;
  self.health = func_3725();
  self.precacheleaderboards = 0;
  self setscriptablepartstate("eyes", "eye_glow_off");
  self detachall();
  var_1 = ["park_clown_zombie", "park_clown_zombie_blue", "park_clown_zombie_green", "park_clown_zombie_orange", "park_clown_zombie_yellow"];
  var_2 = scripts\engine\utility::random(var_1);
  self setModel(var_2);
  scripts\asm\asm_bb::bb_requestmovetype("sprint");
  if(isDefined(level.suicider_avoidance_radius)) {
    self setavoidanceradius(level.suicider_avoidance_radius);
  }
}

func_3725() {
  var_0 = 200;
  switch (level.specialroundcounter) {
    case 0:
      var_0 = 100;
      break;

    case 1:
      var_0 = 400;
      break;

    case 2:
      var_0 = 900;
      break;

    case 3:
      var_0 = 1300;
      break;

    default:
      var_0 = 1600;
      break;
  }

  return var_0;
}

func_10057(var_0, var_1, var_2, var_3) {
  if(scripts\mp\agents\_scriptedagents::isstatelocked()) {
    return 0;
  }

  if(self.aistate == "traverse") {
    return 0;
  }

  if(isDefined(var_2) && isexplosivedamagemod(var_2) && var_0 >= 350) {
    if(isDefined(var_1) && !issubstr(var_1, "g18pap")) {
      return 1;
    }
  }

  if(isDefined(var_2) && var_2 == "MOD_MELEE") {
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

func_10092(var_0, var_1, var_2, var_3) {
  if(!func_FFE7()) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_4 = scripts\asm\asm::asm_getcurrentstate(var_0);
  if(!scripts\asm\asm::func_232B(var_4, "cover_approach")) {
    return 0;
  }

  if(!isDefined(self.var_20EE)) {
    return 0;
  }

  if(isDefined(self.isfrozen) && self.isfrozen) {
    self.var_20EE = undefined;
    return 0;
  }

  if(!isDefined(var_3) || var_3.size < 1) {
    var_5 = "Exposed";
  } else {
    var_5 = var_4[0];
  }

  if(!lib_0F3A::func_9D4C(var_0, var_1, var_2, var_5)) {
    return 0;
  }

  self.asm.var_11068 = func_3724(var_0, var_2, var_5);
  if(!isDefined(self.asm.var_11068)) {
    return 0;
  }

  return 1;
}

func_3724(var_0, var_1, var_2) {
  var_3 = lib_0F3A::func_7DD6();
  if(isDefined(var_3)) {
    var_4 = var_3.origin;
  } else {
    var_4 = self.vehicle_getspawnerarray;
  }

  var_5 = lib_0F3A::func_7E54();
  var_6 = self.var_20EE;
  var_7 = vectortoangles(var_6);
  if(isDefined(var_5)) {
    var_8 = angleclamp180(var_5[1] - var_7[1]);
  } else if(isDefined(var_4) && var_4.type != "Path") {
    var_8 = angleclamp180(var_4.angles[1] - var_8[1]);
  } else {
    var_9 = var_5 - self.origin;
    var_0A = vectortoangles(var_9);
    var_8 = angleclamp180(var_0A[1] - var_7[1]);
  }

  var_0B = var_1;
  var_0C = lib_0F3A::getweaponslistprimaries();
  var_0D = var_4 - self.origin;
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
    var_1E.var_22ED = var_4;
    return var_1E;
  }

  return undefined;
}

func_D563(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self getspectatepoint();
  var_5 = self _meth_8146();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_4.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_6 = var_5 - var_4.origin;
  var_7 = self getsafecircleorigin(var_1, 0);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7);
  var_0A = length(var_9);
  var_0B = length(var_5 - self.origin);
  var_0C = var_8 * var_0B / var_0A;
  self ghostexplode(self.origin, var_5, var_0C);
  self setanimstate(var_1, 0);
  wait(var_0C);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(var_0, var_1);
}

func_3F08(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return lib_0F3C::func_3EF4(var_0, var_1, var_2);
  }

  switch (self._blackboard.movetype) {
    case "walk":
    case "slow_walk":
      var_2 = var_2 + "_walk";
      break;

    case "sprint":
    case "run":
      var_2 = var_2 + "_run";
      break;

    default:
      var_2 = var_2 + "_walk";
      break;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

func_D567(var_0, var_1, var_2, var_3) {
  scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoTraverse");
  var_4 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  func_5AC4(var_0, var_1, var_2, var_3);
  self.do_immediate_ragdoll = var_4;
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\_scriptedagents::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
}

func_5AC4(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self getspectatepoint();
  var_5 = self _meth_8146();
  self.endnode_pos = var_5;
  if(!isDefined(var_4)) {
    return;
  }

  if(!isDefined(var_5)) {
    return;
  }

  self.var_6378 = var_5;
  self.traversalvector = vectornormalize(var_5 - var_4.origin);
  var_6 = undefined;
  var_6 = var_4.var_48;
  if(var_1 == "traverse_external") {
    var_6 = var_1;
  }

  if(func_BE90(var_6)) {
    var_6 = "crawling_" + var_6;
  }

  if(!isDefined(var_6)) {
    return;
  }

  self.is_traversing = 1;
  var_7 = scripts\asm\asm_mp::asm_getanim(var_0, var_6);
  var_8 = var_5 - var_4.origin;
  var_9 = (var_8[0], var_8[1], 0);
  var_0A = vectortoangles(var_9);
  var_0B = issubstr(var_6, "jump_across");
  var_0C = var_6 == "traverse_boost" && self.species == "humanoid" || self.species == "zombie";
  self orientmode("face angle abs", var_0A);
  self ghostlaunched("anim deltas");
  var_0D = self getsafecircleorigin(var_6, var_7);
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

  var_1C = scripts\mp\agents\_scriptedagents::func_7DC9(var_8, var_1B);
  var_1D = animhasnotetrack(var_0D, "ignoreanimscaling");
  if(var_1D) {
    var_1C.var_13E2B = 1;
  }

  self gib_fx_override("noclip");
  var_1E = self _meth_8145();
  if(isDefined(var_1E) && isDefined(var_1E.target)) {
    self.endnode = var_1E;
    if(var_13.size > 0) {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_6 + "_norestart", var_7, var_0D, "traverse", var_0E, var_12, 0, ::func_13FAE);
      var_1F = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
      if(isDefined(var_1F.script_noteworthy) && var_1F.script_noteworthy == "continue_flex_height") {
        scripts\mp\agents\_scriptedagents::func_5AC1(var_6 + "_norestart", var_7, var_0D, "traverse", var_12, var_10, 1, ::func_13FAE);
      }

      self scragentsetanimscale(1, 1);
      scripts\mp\agents\_scriptedagents::func_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::func_13FAE);
    } else if(var_15.size == 0) {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_6 + "_norestart", var_7, var_0D, "traverse", var_0E, var_10, 0, ::func_13FAE);
      self scragentsetanimscale(1, 1);
      scripts\mp\agents\_scriptedagents::func_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::func_13FAE);
    } else {
      var_1F = scripts\engine\utility::getstruct(self.endnode.target, "targetname");
      var_20 = var_15[0];
      scripts\mp\agents\_scriptedagents::func_5AC2(var_6 + "_norestart", var_7, "traverse", var_0D, var_0E, var_10, var_1F.origin, var_20, ::func_13FAE);
      if(var_15[0] - var_11[0] > 0.02) {
        self scragentsetanimscale(1, 1);
        scripts\mp\agents\_scriptedagents::func_CED5(var_6 + "_norestart", var_7, "traverse", var_14, ::func_13FAE);
      }

      var_1F = self.endnode;
      var_20 = var_17[0];
      scripts\mp\agents\_scriptedagents::func_5AC2(var_6 + "_norestart", var_7, "traverse", var_0D, var_14, var_16, var_1F.origin, var_20, ::func_13FAE);
      self scragentsetanimscale(1, 1);
      if(var_19.size == 0 || !scripts\engine\utility::istrue(self.dismember_crawl)) {
        scripts\mp\agents\_scriptedagents::func_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::func_13FAE);
      }
    }

    self.endnode = undefined;
  } else if(var_15.size > 0 && var_17.size > 0 && self.agent_type != "zombie_brute") {
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::func_13FAE);
  } else if(var_0B && abs(var_8[2]) < 48) {
    var_21 = getanimlength(var_0D);
    var_22 = var_0F[0] * var_21;
    var_23 = var_11[0] * var_21;
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse", var_0E);
    self scragentsetanimscale(1, 0);
    childthread func_126D8(var_4.origin[2], var_5[2], var_23 - var_22 / self.traverseratescale);
    scripts\mp\agents\_scriptedagents::func_CED3(var_6 + "_norestart", var_7, self.traverseratescale, "traverse", var_10);
    self scragentsetanimscale(1, 1);
    scripts\mp\agents\_scriptedagents::func_CED3(var_6 + "_norestart", var_7, self.traverseratescale, "traverse");
  } else if(var_8[2] > 16) {
    if(var_1B[2] > 0) {
      if(var_0C) {
        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        var_24 = clamp(2 / var_1C.var_3A6, 0.5, 1);
        if(var_11.size > 0) {
          scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, var_24 * self.traverseratescale, "traverse", var_10);
          scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
          var_25 = var_6 + "_norestart";
          scripts\mp\agents\_scriptedagents::func_F2B1(var_25, var_7, self.traverseratescale);
          scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
        } else {
          scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse");
        }

        self scragentsetanimscale(1, 1);
      } else if(var_0F.size > 0) {
        var_1C.var_13E2B = 1;
        var_1C.var_3A6 = 1;
        if(!var_1D && length2dsquared(var_9) < 0.64 * length2dsquared(var_1B)) {
          var_1C.var_13E2B = 0.4;
        }

        self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
        scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse", var_0E);
        var_26 = getmovedelta(var_0D, 0, var_0F[0]);
        var_27 = getmovedelta(var_0D, 0, var_11[0]);
        var_1C.var_13E2B = 1;
        var_1C.var_3A6 = 1;
        var_28 = var_5 - self.origin;
        var_29 = var_1B - var_26;
        if(!var_1D && length2dsquared(var_28) < 0.5625 * length2dsquared(var_29)) {
          var_1C.var_13E2B = 0.75;
        }

        var_2A = var_1B - var_27;
        var_2B = (var_2A[0] * var_1C.var_13E2B, var_2A[1] * var_1C.var_13E2B, var_2A[2] * var_1C.var_3A6);
        var_2C = rotatevector(var_2B, var_0A);
        var_2D = var_5 - var_2C;
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
        scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse");
      }
    } else {
      scripts\mp\agents\_scriptedagents::func_5AC1(var_6 + "_norestart", var_7, var_0D, "traverse", "flex_height_start", "flex_height_end", 1, ::func_13FAE);
    }
  } else if(abs(var_8[2]) < 16 || var_1B[2] == 0) {
    self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
    var_24 = clamp(2 / var_1C.var_3A6, 0.5, 1);
    if(var_11.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, var_24 * self.traverseratescale, "traverse", var_10);
      scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
      var_25 = var_6 + "_norestart";
      scripts\mp\agents\_scriptedagents::func_F2B1(var_25, var_7, self.traverseratescale);
      scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
    } else {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse");
    }

    self scragentsetanimscale(1, 1);
  } else if(var_1B[2] < 0) {
    self scragentsetanimscale(var_1C.var_13E2B, var_1C.var_3A6);
    var_24 = clamp(2 / var_1C.var_3A6, 0.5, 1);
    var_33 = var_6 + "_norestart";
    if(var_0F.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, self.traverseratescale, "traverse", var_0E);
      var_6 = var_33;
    }

    if(var_11.size > 0) {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, var_24 * 1, "traverse", var_10);
      scripts\mp\agents\_scriptedagents::func_F2B1(var_33, var_7, self.traverseratescale);
      if(animhasnotetrack(var_0D, "removestatelock")) {
        scripts\mp\agents\_scriptedagents::func_1384D("traverse", "removestatelock");
      }

      scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoTraverse");
      scripts\mp\agents\_scriptedagents::func_1384D("traverse", "code_move");
    } else {
      scripts\mp\agents\_scriptedagents::func_CED3(var_6, var_7, 1, "traverse");
    }

    self scragentsetanimscale(1, 1);
  }

  func_ABB8();
  self gib_fx_override("gravity");
  self.is_traversing = undefined;
  self notify("traverse_end");
  func_11701(var_0, var_1);
}

func_126D8(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_3 = gettime();
  for(;;) {
    var_4 = gettime() - var_3 / 1000;
    var_5 = var_4 / var_2;
    if(var_5 > 1) {
      break;
    }

    var_6 = scripts\mp\agents\zombie\zombie_util::func_AB6F(var_5, var_0, var_1);
    self setorigin((self.origin[0], self.origin[1], var_6), 0);
    wait(0.05);
  }
}

func_BE90(var_0) {
  if(self.dismember_crawl) {
    return 1;
  }

  return 0;
}

func_ABB8() {
  var_0 = 0.1;
  var_1 = self.var_6378;
  var_2 = var_1[2];
  var_3 = self.origin[2];
  if(var_3 < var_2) {
    self setorigin((self.origin[0], self.origin[1], var_2 + var_0), 0);
  }
}

func_11706(var_0, var_1, var_2) {
  self.is_traversing = undefined;
}

func_11701(var_0, var_1) {
  var_2 = level.asm[var_0].states[var_1];
  var_3 = undefined;
  if(isDefined(var_2.var_116FB)) {
    if(isarray(var_2.var_116FB[0])) {
      var_3 = var_2.var_116FB[0];
    } else {
      var_3 = var_2.var_116FB;
    }
  }

  scripts\asm\asm::func_2388(var_0, var_1, var_2, var_2.var_116FB);
  scripts\asm\asm::func_238A(var_0, var_3, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_D4E3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  self.asm.cur_move_mode = var_3;
  lib_0F3C::func_D4DD(var_0, var_1, var_2, var_3);
  scripts\asm\asm::func_237B(1);
}

func_CEAE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  lib_0F3A::func_CEAA(var_0, var_1, var_2, var_3);
}

func_CEB7(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  lib_0F3B::func_CEB5(var_0, var_1, var_2, var_3);
  scripts\asm\asm::func_237B(1);
}

func_D515(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  lib_0F3B::func_D514(var_0, var_1, var_2, var_3);
  scripts\asm\asm::func_237B(self.moveratescale);
}

func_D538(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::func_237B(self.moveratescale);
  if(scripts\mp\agents\zombie\zombie_util::_meth_8252() < 2) {
    var_4 = level.var_BCE6["run"][1];
    var_4 = var_4 + self.moveratescale - level.var_BCE6["sprint"][0];
    scripts\asm\asm::func_237B(var_4);
  }

  lib_0F3B::func_D514(var_0, var_1, var_2, var_3);
  scripts\asm\asm::func_237B(self.moveratescale);
}

func_13FAE(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "apply_physics":
      self gib_fx_override("gravity");
      break;

    default:
      break;
  }
}

func_7389(var_0, var_1, var_2, var_3) {
  var_1 = self.var_7387;
  level thread[[level.frozenzombiefunc]](self);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  if(scripts\engine\utility::istrue(self.activated_slomo_sphere)) {
    scripts\asm\asm_mp::func_2365(var_0, var_1, 0.1, var_4, 0.2);
    return;
  }

  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    scripts\asm\asm_mp::func_2365(var_0, var_1, 0.1, var_4, 0.2);
    return;
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, 0.1, var_4, 0.001);
}

func_3E12(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.isfrozen)) {
    if(isDefined(var_3)) {
      self.var_7387 = var_3;
    } else {
      self.var_7387 = scripts\asm\asm::asm_getcurrentstate(var_0);
    }

    return 1;
  }

  return 0;
}

func_3E18(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::istrue(self.isfrozen)) {
    self.var_7387 = undefined;
    return 1;
  }

  return 0;
}

func_631D(var_0, var_1, var_2, var_3) {
  self.var_7387 = undefined;
  level thread[[level.thawzombiefunc]](self);
}

func_A013() {
  if(self _meth_84B9(200)) {
    return 1;
  }

  return 0;
}

func_38B2(var_0, var_1, var_2) {
  var_3 = 0.5;
  var_4 = getnotetracktimes(var_0, "turn_extent");
  if(var_4.size == 1) {
    var_3 = var_4[0];
  } else {
    var_5 = getnotetracktimes(var_0, "code_move");
    if(var_5.size == 1) {
      var_3 = var_5[0] * 0.5;
    }
  }

  var_6 = 1;
  var_7 = getnotetracktimes(var_0, "finish");
  if(var_7.size == 0) {
    var_7 = getnotetracktimes(var_0, "end");
  }

  if(var_7.size == 1) {
    var_6 = var_7[0];
  }

  var_8 = getmovedelta(var_0, 0, var_3);
  var_9 = getmovedelta(var_0, 0, var_6);
  var_0A = self.origin;
  var_0B = rotatevector(var_8, var_1) + var_0A;
  var_0C = rotatevector(var_9, var_1) + var_0A;
  if(!scripts\mp\agents\_scriptedagents::func_38D0(var_0B, var_0C, 0)) {
    return 0;
  }

  var_0D = self.fgetarg;
  if(!var_2) {
    var_0D = self.fgetarg / 2;
  }

  if(!scripts\mp\agents\_scriptedagents::func_38D0(var_0A, var_0B, 0, var_0D)) {
    return 0;
  }

  return 1;
}

func_6BC6(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.is_dancing)) {
    return 1;
  }

  return 0;
}

isdoublejumpanimdone(var_0, var_1, var_2, var_3) {
  if(func_6BC6(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  self.var_2CA7 = undefined;
  return 1;
}

func_CEF3(var_0, var_1, var_2, var_3) {
  self orientmode("face angle abs", self.desired_dance_angles);
  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, 1, 0);
}

func_3EBE(var_0, var_1, var_2) {
  if(isDefined(self.var_2CA7)) {
    return self.var_2CA7;
  }

  if(self.dismember_crawl) {
    func_F2E5();
    self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "boombox_dance_crawl_" + level.var_2C9A);
    return self.var_2CA7;
  }

  if(scripts\engine\utility::istrue(self.var_9B6E)) {
    self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "disco_dance_center_" + randomintrange(0, 4));
    return self.var_2CA7;
  }

  if(scripts\engine\utility::istrue(self.fridge_trap_marked)) {
    self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "fridge_lured_anim_" + randomintrange(0, 4));
    return self.var_2CA7;
  }

  func_F2E6();
  self.var_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "boombox_dance_" + level.var_2C9B);
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

func_BE8D(var_0, var_1, var_2, var_3) {
  return 0;
}

func_3EFE(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.upgraded_dischord_spin)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "upgraded");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "normal");
}

func_98DC(var_0, var_1, var_2, var_3) {
  return 0;
}

func_BE94(var_0, var_1, var_2, var_3) {
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

func_3ED7(var_0, var_1, var_2) {
  if(isDefined(self.var_662F)) {
    return self.var_662F;
  }

  var_3 = self.attack_spot;
  var_4 = undefined;
  if(!isDefined(var_3.script_label)) {
    var_4 = "mid";
  } else {
    var_4 = var_3.script_label;
  }

  if(scripts\engine\utility::istrue(var_3.var_2A9F)) {
    var_4 = var_4 + "_extended";
  }

  self.var_662F = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  return self.var_662F;
}

func_3EBA(var_0, var_1, var_2) {
  var_3 = self.attack_spot;
  var_4 = "standing_";
  if(func_BE92()) {
    var_4 = "crawling_";
  }

  if(!isDefined(var_3.script_label)) {
    var_4 = var_4 + "mid";
  } else {
    var_4 = var_4 + var_3.script_label;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
}

func_116E8(var_0, var_1, var_2) {
  if(isDefined(self.var_BF2F)) {
    var_3 = scripts\cp\zombies\zombie_entrances::func_7872(self.var_6658, self.var_BF2F - 1);
    if(var_3 == "destroying") {
      scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, self.var_BF2F - 1, "boarded");
    }

    self.var_BF2F = undefined;
  }
}

func_3ECF(var_0, var_1, var_2) {
  var_3 = self.attack_spot;
  if(scripts\engine\utility::istrue(self.isfrozen)) {
    if(isDefined(self.var_BF2F)) {
      scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, self.var_BF2F - 1, "boarded");
      self.var_BF2F = undefined;
    }

    return self.var_A93A;
  }

  if(self.dismember_crawl) {
    if(!isDefined(var_3.script_label)) {
      self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_1, "crawling");
      return self.var_A93A;
    }

    var_4 = func_F496();
    var_5 = "crawling_" + var_3.script_label + "_" + var_4;
    self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
    return self.var_A93A;
  }

  if(!isDefined(var_5.script_label)) {
    self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_3, "standing");
    return self.var_A93A;
  }

  while(isDefined(self.var_BF2F)) {
    wait(0.05);
  }

  var_4 = func_F496();
  var_5 = "standing_" + var_4.script_label + "_" + var_5;
  self.var_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
  return self.var_A93A;
}

func_F496() {
  var_0 = scripts\cp\zombies\zombie_entrances::func_7B12(self.var_6658);
  self.var_BF2F = var_0;
  scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, self.var_BF2F - 1, "destroying");
  return var_0;
}

func_3F13(var_0, var_1, var_2) {
  if(self.dismember_crawl) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crawling");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "standing");
}

func_532D(var_0, var_1, var_2, var_3) {
  if(var_0 == "board_break" || var_0 == "hit") {
    if(!isDefined(self.var_BF2F)) {
      return;
    }

    var_4 = self.var_BF2F;
    self.var_BF2F = undefined;
    scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, var_4 - 1, "destroyed");
    scripts\cp\zombies\zombie_entrances::remove_barrier_from_entrance(self.var_6658, var_4);
  }
}

is_player_near_interaction_point(var_0, var_1) {
  var_2 = 2304;
  return distancesquared(var_0.origin, var_1.origin) < var_2;
}

func_252C(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);
    if(is_player_near_interaction_point(self.closest_player_near_interaction_point, var_4)) {
      scripts\asm\zombie\melee::domeleedamage(self.closest_player_near_interaction_point, 45, "MOD_IMPACT");
    }
  }
}

func_CEE3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self orientmode("face angle abs", self.attack_spot.angles);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_CF19(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self orientmode("face angle abs", self.attack_spot.angles);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

func_662E(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self ghostlaunched("anim deltas");
  self orientmode("face angle abs", self.attack_spot.angles);
  self gib_fx_override("noclip");
  self clearpath();
  self scragentsetscripted(1);
  self.do_immediate_ragdoll = 1;
  self.is_traversing = 1;
  if(isDefined(self.attack_spot.script_parameters) && self.attack_spot.script_parameters == "script_adjust") {
    var_4 = anglesToForward(self.attack_spot.angles);
    var_4 = vectornormalize(var_4);
    var_4 = var_4 * -3.5;
    var_4 = (var_4[0], var_4[1], -1);
    self setorigin(self.origin + var_4, 0);
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, scripts\asm\asm_mp::asm_getanim(var_0, var_1), self.traverseratescale);
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

func_1305A(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.attack_spot.target)) {
    return 0;
  }

  var_4 = getnodearray(self.attack_spot.target, "targetname");
  if(!isDefined(var_4) || var_4.size == 0) {
    return 0;
  }

  var_5 = var_4[0];
  if(!isDefined(var_5) || !isDefined(var_5.var_48)) {
    return 0;
  }

  var_4 = getnodearray(var_5.target, "targetname");
  if(!isDefined(var_4) || var_4.size == 0) {
    return 0;
  }

  var_6 = var_4[0];
  self ghostskulls_complete_status(var_6.origin);
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
      var_0 = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(self.var_6658);
      if(isDefined(var_0) && !scripts\cp\zombies\zombie_entrances::func_9CD3(var_0)) {
        self.attack_spot = var_0;
        scripts\cp\zombies\zombie_entrances::func_3FF0(self.attack_spot);
        break;
      }

      self.var_331F = 1;
      wait(0.05);
    }

    self.var_331F = undefined;
  }

  var_1 = getclosestpointonnavmesh(self.attack_spot.origin, self);
  var_2 = (self.attack_spot.origin[0], self.attack_spot.origin[1], var_1[2]);
  self ghostskulls_complete_status(var_2);
  self waittill("goal_reached");
  var_3 = (self.attack_spot.origin[0], self.attack_spot.origin[1], self.origin[2]);
  self setorigin(var_3, 0);
  self.noturnanims = 0;
  scripts\cp\zombies\zombie_entrances::func_E005(self.var_6658);
  self.var_6659 = 1;
}

func_5AEE(var_0, var_1, var_2, var_3) {
  self.var_6659 = 0;
  scripts\cp\zombies\zombie_entrances::func_16D1(self.var_6658);
  self ghostskulls_total_waves(4);
  self ghostskulls_complete_status(self.var_6658.origin);
  thread func_BA3D();
  return 1;
}

func_DD1E(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(self.var_6659)) {
    return 1;
  }

  return 0;
}

func_BE93(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\zombies\zombie_entrances::func_7B12(self.var_6658);
  if(!isDefined(var_4)) {
    return 0;
  }

  return 1;
}

func_13F9B(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_bb::bb_clearmeleerequestcomplete();
  return 1;
}

func_10007(var_0, var_1, var_2, var_3) {
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

func_FFC0(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.var_7089)) {
    return 0;
  }

  if(func_BE92()) {
    return 0;
  }

  var_4 = "mid";
  if(isDefined(self.attack_spot.script_label)) {
    var_4 = self.attack_spot.script_label;
  }

  self.closest_player_near_interaction_point = [[level.var_7089]](self);
  if(!isDefined(self.closest_player_near_interaction_point)) {
    return 0;
  }

  if(randomint(100) > 50) {
    return 0;
  }

  return 1;
}

func_9FF5(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::istrue(level.var_2AAD)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(self.var_331F)) {
    return 1;
  }

  return 0;
}

isdowned(var_0, var_1, var_2, var_3) {
  return !func_9FF5(var_0, var_1, var_2, var_3);
}

func_3F0B(var_0, var_1, var_2) {
  var_3 = "standing";
  if(func_BE92()) {
    var_3 = "crawling";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

func_1002F(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4() && !scripts\engine\utility::istrue(self.stunned);
}

func_1003A(var_0, var_1, var_2, var_3) {
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
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3189.gsc
**************************************/

_id_13F9A(var_0, var_1, var_2, var_3) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm._id_4C86 = spawnStruct();
  self.asm._id_7360 = 0;
  self._id_71D0 = ::_id_1004F;
  self._id_7198 = ::_id_38B2;
  self._id_BC09 = [];
  self.postsharpturnlookaheaddist = 64;
}

_id_3EFC(var_0, var_1, var_2) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_3 = "";

    switch (self.movemode) {
      case "walk":
      case "slow_walk":
        var_3 = "_walk";
        break;
      case "run":
      case "sprint":
        var_3 = "_run";
        break;
      default:
        break;
    }

    if(scripts\asm\asm_mp::_id_2347(var_1, self.spawner.script_animation + var_3))
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation + var_3);
    else if(scripts\asm\asm_mp::_id_2347(var_1, self.spawner.script_animation))
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation);
  }

  if(!isDefined(var_2))
    return _id_0F3C::_id_3EF4(var_0, var_1, var_2);

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

_id_3EFB(var_0, var_1, var_2) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    var_3 = "";

    switch (self.movemode) {
      case "walk":
      case "slow_walk":
        var_3 = "_walk";
        break;
      case "run":
      case "sprint":
        var_3 = "_run";
        break;
      default:
        break;
    }

    if(scripts\asm\asm_mp::_id_2347(var_1, self.spawner.script_animation + var_3))
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation + var_3);
    else if(scripts\asm\asm_mp::_id_2347(var_1, self.spawner.script_animation))
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.spawner.script_animation);
  }

  if(!isDefined(var_2))
    return _id_0F3C::_id_3EF4(var_0, var_1, var_2);

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

_id_3EE0(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    return _id_0F3C::_id_3EF4(var_0, var_1, var_2);

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

_id_3EE1(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = self getanimentrycount(var_1);

  if(var_5 == 1)
    self._id_BC09[var_1] = 0;
  else if(!isDefined(self._id_BC09[var_1]))
    self._id_BC09[var_1] = randomintrange(0, var_5);

  self.asm._id_BCD3 = tolower(self._id_BC09[var_1] + 1);

  if(isDefined(var_2))
    self.asm._id_BCD3 = var_2 + self.asm._id_BCD3;

  return self._id_BC09[var_1];
}

_id_3EF1(var_0, var_1, var_2, var_3) {
  var_4 = self getanimentrycount(var_1);
  var_5 = scripts\mp\agents\zombie\zombie_util::_id_4D52(self._id_4D62, self.damagedir);
  var_6 = angleclamp180(var_5 - self.angles[1]);
  var_7 = scripts\mp\agents\zombie\zombie_util::_id_8040(var_6, var_4);
  return var_7;
}

_id_D4F5(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);

  if(isDefined(self.pathgoalpos)) {
    self _meth_8281("code_move");
    self orientmode("face motion");
  }

  var_5 = self getanimentry(var_1, var_4);
  var_6 = getanimlength(var_5);
  var_7 = 1;

  if(isDefined(self._id_C081) && self._id_C081 > 0)
    var_7 = self._id_C081;

  var_6 = var_6 * (1 / var_7);
  self._id_BF9E = gettime() + var_6 * 0.75 * 1000;
  scripts\anim\notetracks_mp::_id_CED3(var_1, var_4, self._id_C081, "pain_anim");
  _id_6CE0(var_0, var_1, var_3);
}

_id_D4F3(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon(var_1 + "_finished");

  if(scripts\asm\asm_mp::_id_2347(var_1, self.asm._id_BCD3))
    var_4 = scripts\asm\asm_mp::_id_235A(var_1, self.asm._id_BCD3);
  else
    var_4 = _id_0F3C::_id_3EF4(var_0, var_1, var_3);

  var_5 = scripts\asm\asm::_id_2341(var_0, var_1);
  thread scripts\anim\notetracks_mp::_id_CED5(var_1, var_4, var_1, "end", var_5);
  self._id_BF9E = gettime() + 10000;
  wait 0.35;
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_9DB2(var_0, var_1, var_2, var_3) {
  var_4 = _id_4D41();

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && (isDefined(var_4) && var_4 >= 0))
    return 1;

  return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand", "left_leg_upper", "left_foot", "left_leg_lower");
}

_id_9DB3(var_0, var_1, var_2, var_3) {
  var_4 = _id_4D41();

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && (isDefined(var_4) && var_4 < 0))
    return 1;

  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "right_leg_upper", "right_foot", "right_leg_lower");
}

_id_9DB1(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");
}

_id_4D41() {
  var_0 = scripts\mp\agents\zombie\zombie_util::_id_4D52(self._id_4D62, self.damagedir);
  var_1 = angleclamp180(var_0 - self.angles[1]);
  return var_1;
}

_id_6CE0(var_0, var_1, var_2) {
  self notify("killanimscript");
  var_3 = anim.asm[var_0].states[var_1];
  var_4 = undefined;

  if(isarray(var_2))
    var_4 = var_2[0];
  else
    var_4 = var_2;

  if(!isDefined(var_4)) {
    if(isDefined(var_3.transitions) && var_3.transitions.size > 0) {
      return;
    }
    var_4 = "choose_idle";
  }

  scripts\asm\asm::_id_2388(var_0, var_1, var_3, var_3._id_116FB);
  scripts\asm\asm::_id_238A(var_0, var_4, 0.2, undefined, undefined, undefined);
}

_id_1004F() {
  if(isDefined(self.allowpain) && self.allowpain == 0)
    return 0;

  if(isDefined(self.isfrozen) && self.isfrozen)
    return 0;

  if(isDefined(self._id_BF9E) && gettime() < self._id_BF9E)
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(isDefined(level.no_pain_volume) && self istouching(level.no_pain_volume))
    return 0;

  if(!scripts\engine\utility::is_true(self.stunned)) {
    if(scripts\asm\asm_bb::bb_meleerequested())
      return 0;

    if(scripts\asm\asm_bb::bb_meleeinprogress())
      return 0;
  }

  return 1;
}

_id_9E89(var_0) {
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

_id_9EAB(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_BE92() {
  if(isDefined(self.dismember_crawl))
    return self.dismember_crawl;

  return 0;
}

_id_BE99(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

_id_BE9A(var_0, var_1, var_2, var_3) {
  if(_id_9F87())
    return 1;

  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_BE9B() {
  if(_id_9F87() && _id_1005C() && !_id_8C13())
    return 1;

  return 0;
}

_id_BE97() {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation))
    return !scripts\engine\utility::is_true(self.hasplayedvignetteanim);

  return 0;
}

_id_BE95(var_0, var_1, var_2, var_3) {
  return isDefined(self.linked_to_boat);
}

_id_BE96() {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_fxid))
    return !scripts\engine\utility::is_true(self._id_8C12);

  return 0;
}

_id_1009C() {
  if(isDefined(self.linked_to_boat))
    return 0;
  else
    return 1;
}

_id_BCCD() {
  if(isDefined(self.agent_type) && self.agent_type == "zombie_brute")
    return 0;

  var_0 = isDefined(self.asm.cur_move_mode) && self.asm.cur_move_mode != self._blackboard.movetype;

  if(var_0)
    return 1;
  else
    return 0;
}

_id_9E0F() {
  return scripts\engine\utility::is_true(self.bisghost);
}

_id_9F87() {
  return scripts\engine\utility::is_true(self.is_suicide_bomber);
}

_id_1005C() {
  return scripts\engine\utility::is_true(self.should_play_transformation_anim);
}

_id_8C13() {
  return scripts\engine\utility::is_true(self._id_8C13);
}

_id_9D8C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.is_suicide_bomber))
    return 1;

  return 0;
}

iscorempgametype(var_0, var_1, var_2, var_3) {
  if(self.agent_type == "zombie_cop") {
    if(getdvarint("scr_dont_use_cop_anims") != 0)
      return 0;

    return 1;
  }

  return 0;
}

_id_1005E(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::is_true(self.is_traversing) && !scripts\engine\utility::is_true(self.customdeath))
    return scripts\mp\agents\zombie\zombie_agent::dying_zapper_death();

  return 0;
}

_id_10046(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::is_true(self.rocket_feet);
}

choosefacemelteranim(var_0, var_1, var_2, var_3) {
  self notify("facemelter_launch_chosen");

  if(scripts\engine\utility::is_true(self.dismember_crawl))
    return "prone_launch";

  return "launch";
}

_id_6A79(var_0, var_1, var_2, var_3) {
  self notify("ready_to_launch");
}

shouldplaybalconydeath(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::is_true(self.dischord_spin);
}

choosedischordanim(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(self.dismember_crawl))
    return "prone_spin";

  return "spin";
}

_id_5626(var_0, var_1, var_2, var_3) {
  self notify("ready_to_spin");
}

_id_10049(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::is_true(self.head_is_exploding);
}

chooseheadcutteranim(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(self.dismember_crawl))
    return "prone_expand_head";

  return "expand_head";
}

_id_10053(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_D532(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.scripted_mode = 1;
  self scragentsetphysicsmode("noclip");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = 0.01;
  thread scripts\asm\asm_mp::_id_2365(var_0, var_1, var_2, var_4, var_5);

  if(isDefined(level.spawn_fx_func))
    self[[level.spawn_fx_func]]();

  wait 0.5;
  self._id_8C12 = 1;
}

_id_D4DB(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.scripted_mode = 1;
  self scragentsetphysicsmode("noclip");
  thread _id_0F3C::_id_CEA8(var_0, var_1, var_2, var_3);
  wait 1;
  level thread[[level.meleevignetteanimfunc]](self);
}

_id_D571(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.scripted_mode = 1;
  self.is_traversing = 1;
  self.vignette_nocorpse = 1;
  self.ignoreall = 1;
  self scragentsetphysicsmode("noclip");
  scripts\anim\notetracks_mp::setstatelocked(1, "play_vignette_anim");
  self.hasplayedvignetteanim = 0;

  if(isDefined(self.spawner) && isDefined(self.spawner._id_ABA7))
    thread _id_C3C6(var_0, var_1);

  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = 1.0;
  var_6 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  scripts\asm\asm_mp::_id_2365(var_0, var_1, var_2, var_4, var_5);
  self.do_immediate_ragdoll = var_6;
  self scragentsetphysicsmode("gravity");
  self.scripted_mode = 0;
  self.ignoreall = 0;
  scripts\anim\notetracks_mp::setstatelocked(0, "play_vignette_anim");
  self.vignette_nocorpse = undefined;
  self.hasplayedvignetteanim = 1;
  self notify("intro_vignette_done");
}

_id_11702(var_0, var_1, var_2) {
  self scragentsetphysicsmode("gravity");
  self.scripted_mode = 0;
  self.hasplayedvignetteanim = 1;
  self.is_traversing = undefined;
  self.vignette_nocorpse = undefined;
}

_id_ABA5(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_3 = self getanimentry(var_1, var_2);
  var_4 = getanimlength(var_3);
  var_5 = getnotetracktimes(var_3, "fall");
  var_6 = getnotetracktimes(var_3, "land");
  var_7 = getmovedelta(var_3, var_5[0], var_6[0]);
  self scragentsetanimscale(1.0, 1.0);
  var_8 = 1;
  scripts\anim\notetracks_mp::_id_CED3(var_1, var_2, var_8, var_1, "fall", undefined);

  if(var_7 == (0, 0, 0)) {
    self scragentsetphysicsmode("gravity");
    return;
  }

  var_9 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_9 = self.spawner._id_ABA6;
  var_10 = var_9 - self.origin;
  var_11 = var_10[2] / var_7[2];
  var_12 = var_4 * var_6[0] - var_4 * var_5[0];
  var_13 = var_12 * var_11;

  if(var_11 >= 1) {
    self scragentsetanimscale(1, var_11);
    var_8 = 1 / var_11;
    scripts\anim\notetracks_mp::_id_CED3(var_1, var_2, var_8, var_1, "land", undefined);
    var_8 = 1;
    self scragentsetphysicsmode("gravity");
    self scragentsetanimscale(1, 1);
    scripts\anim\notetracks_mp::_id_CED3(var_1, var_2, var_8, var_1, "end", undefined);
  }
}

_id_C3C6(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_3 = self getanimentry(var_1, var_2);
  var_4 = getanimlength(var_3);
  var_5 = getnotetracktimes(var_3, "fall");
  var_6 = getnotetracktimes(var_3, "land");
  var_7 = getmovedelta(var_3, var_5[0], var_6[0]);
  scripts\anim\notetracks_mp::_id_1384C(var_1, "fall", var_1, var_2, undefined);

  if(var_7 == (0, 0, 0)) {
    self scragentsetphysicsmode("gravity");
    return;
  }

  var_8 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_8 = self.spawner._id_ABA6;
  var_9 = var_8 - self.origin;
  var_10 = var_9[2] / var_7[2];
  var_11 = var_4 * var_6[0] - var_4 * var_5[0];
  var_12 = var_11 * var_10;

  if(var_10 >= 1) {
    self scragentsetanimscale(1, var_10);
    scripts\anim\notetracks_mp::_id_1384C(var_1, "land", var_1, var_2, undefined);
    self scragentsetphysicsmode("gravity");
    self scragentsetanimscale(1, 1);
  }
}

playingburningfx(var_0, var_1, var_2, var_3) {
  if(isDefined(self.spawner) && isDefined(self.spawner._id_ABA7))
    return 1;

  return 0;
}

_id_D544(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_0F3C::_id_CEA8(var_0, var_1, var_2, var_3);
  self._id_8C13 = 1;
}

turnintosuicidebomber(var_0) {
  self.entered_playspace = 1;
  self.is_suicide_bomber = 1;
  self.nocorpse = 1;
  self.should_play_transformation_anim = var_0;
  self.health = _id_3725();
  self.ignoreall = 0;
  self setscriptablepartstate("eyes", "eye_glow_off");
  self detachall();
  var_1 = ["park_clown_zombie", "park_clown_zombie_blue", "park_clown_zombie_green", "park_clown_zombie_orange", "park_clown_zombie_yellow"];
  var_2 = scripts\engine\utility::random(var_1);
  self setModel(var_2);
  scripts\asm\asm_bb::bb_requestmovetype("sprint");

  if(isDefined(level.suicider_avoidance_radius))
    self setavoidanceradius(level.suicider_avoidance_radius);
}

_id_3725() {
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
  }

  return var_0;
}

_id_10057(var_0, var_1, var_2, var_3) {
  if(scripts\anim\notetracks_mp::isstatelocked())
    return 0;

  if(self.aistate == "traverse")
    return 0;

  if(isDefined(var_2) && isexplosivedamagemod(var_2) && var_0 >= 350) {
    if(isDefined(var_1) && !issubstr(var_1, "g18pap"))
      return 1;
  }

  if(isDefined(var_2) && var_2 == "MOD_MELEE")
    return 1;

  if(isDefined(self.stun_hit_time)) {
    if(self.stun_hit_time > gettime())
      return 1;
    else {
      self.stun_hit_time = undefined;
      self.stunned = undefined;
    }
  }

  if(scripts\engine\utility::is_true(self.stunned))
    return 1;

  if(isDefined(self._id_10058) && [[self._id_10058]]())
    return 1;

  return 0;
}

_id_FFE7() {
  if(!_id_0F3A::_id_FFE6())
    return 0;

  if(isDefined(self.curmeleetarget))
    return 0;

  if(isDefined(self._id_6658))
    return 0;

  return 1;
}

_id_10092(var_0, var_1, var_2, var_3) {
  if(!_id_FFE7())
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  var_4 = scripts\asm\asm::asm_getcurrentstate(var_0);

  if(!scripts\asm\asm::_id_232B(var_4, "cover_approach"))
    return 0;

  if(!isDefined(self._id_20EE))
    return 0;

  if(isDefined(self.isfrozen) && self.isfrozen) {
    self._id_20EE = undefined;
    return 0;
  }

  if(!isDefined(var_3) || var_3.size < 1)
    var_5 = "Exposed";
  else
    var_5 = var_3[0];

  if(!_id_0F3A::_id_9D4C(var_0, var_1, var_2, var_5))
    return 0;

  self.asm._id_11068 = _id_3724(var_0, var_2, var_5);

  if(!isDefined(self.asm._id_11068))
    return 0;

  return 1;
}

_id_3724(var_0, var_1, var_2) {
  var_3 = _id_0F3A::_id_7DD6();

  if(isDefined(var_3))
    var_4 = var_3.origin;
  else
    var_4 = self.pathgoalpos;

  var_5 = _id_0F3A::_id_7E54();
  var_6 = self._id_20EE;
  var_7 = vectortoangles(var_6);

  if(isDefined(var_5))
    var_8 = angleclamp180(var_5[1] - var_7[1]);
  else if(isDefined(var_3) && var_3.type != "Path")
    var_8 = angleclamp180(var_3.angles[1] - var_7[1]);
  else {
    var_9 = var_4 - self.origin;
    var_10 = vectortoangles(var_9);
    var_8 = angleclamp180(var_10[1] - var_7[1]);
  }

  var_11 = var_1;
  var_12 = _id_0F3A::_id_8177();
  var_13 = var_4 - self.origin;
  var_14 = lengthsquared(var_13);
  var_15 = 0;
  var_16 = self getanimentry(var_11, var_15);
  var_17 = getmovedelta(var_16);
  var_18 = getangledelta(var_16);
  var_19 = length(self getvelocity());
  var_20 = var_19 * 0.053;
  var_21 = length(var_13);
  var_22 = length(var_17);

  if(abs(var_21 - var_22) > var_20)
    return undefined;

  if(var_14 < lengthsquared(var_17))
    return undefined;

  var_23 = _id_0F3A::_id_36D9(var_12.pos, var_12._id_0130[1], var_17, var_18);
  var_24 = getclosestpointonnavmesh(var_12.pos, self);
  var_25 = _id_0F3A::_id_36D9(var_24, var_12._id_0130[1], var_17, var_18);
  var_26 = self _meth_84AC();
  var_27 = navtrace(var_26, var_24, self, 1);
  var_28 = var_27["fraction"] >= 0.9 || _func_2AC(var_26, var_24, self);

  if(!var_28) {
    var_29 = self pathdisttogoal();
    var_28 = var_29 < distance(var_26, var_24) + 8.0;
  }

  if(var_28) {
    var_30 = spawnStruct();
    var_30._id_11060 = var_15;
    var_30.angleindex = 0;
    var_30.startpos = var_23;
    var_30.angledelta = var_18;
    var_30.angles = var_12.angles;
    var_30._id_0130 = var_12._id_0130;
    var_30._id_11069 = var_17;
    var_30._id_22ED = var_4;
    return var_30;
  }

  return undefined;
}

_id_D563(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self _meth_8148();
  var_5 = self _meth_8146();
  self scragentsetphysicsmode("noclip");
  self orientmode("face angle abs", var_4.angles);
  self _meth_8281("anim deltas");
  self scragentsetanimscale(1.0, 1.0);
  var_6 = var_5 - var_4.origin;
  var_7 = self getanimentry(var_1, 0);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7);
  var_10 = length(var_9);
  var_11 = length(var_5 - self.origin);
  var_12 = var_8 * (var_11 / var_10);
  self _meth_827B(self.origin, var_5, var_12);
  self setanimstate(var_1, 0);
  wait(var_12);
  self scragentsetphysicsmode("gravity");
  self notify("traverse_end");
  _id_11701(var_0, var_1);
}

_id_3F08(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    return _id_0F3C::_id_3EF4(var_0, var_1, var_2);

  switch (self._blackboard.movetype) {
    case "walk":
    case "slow_walk":
      var_2 = var_2 + "_walk";
      break;
    case "run":
    case "sprint":
      var_2 = var_2 + "_run";
      break;
    default:
      var_2 = var_2 + "_walk";
      break;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

_id_D567(var_0, var_1, var_2, var_3) {
  scripts\anim\notetracks_mp::setstatelocked(1, "DoTraverse");
  var_4 = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  _id_5AC4(var_0, var_1, var_2, var_3);
  self.do_immediate_ragdoll = var_4;
  self scragentsetanimscale(1, 1);
  scripts\anim\notetracks_mp::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self.traversalvector = undefined;
}

_id_5AC4(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = self _meth_8148();
  var_5 = self _meth_8146();
  self.endnode_pos = var_5;

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_5)) {
    return;
  }
  self._id_6378 = var_5;
  self.traversalvector = vectorNormalize(var_5 - var_4.origin);
  var_6 = undefined;
  var_6 = var_4.animscript;

  if(var_1 == "traverse_external")
    var_6 = var_1;

  if(_id_BE90(var_6))
    var_6 = "crawling_" + var_6;

  if(!isDefined(var_6)) {
    return;
  }
  self.is_traversing = 1;
  var_7 = scripts\asm\asm_mp::asm_getanim(var_0, var_6);
  var_8 = var_5 - var_4.origin;
  var_9 = (var_8[0], var_8[1], 0);
  var_10 = vectortoangles(var_9);
  var_11 = issubstr(var_6, "jump_across");
  var_12 = var_6 == "traverse_boost" && (self.species == "humanoid" || self.species == "zombie");
  self orientmode("face angle abs", var_10);
  self _meth_8281("anim deltas");
  var_13 = self getanimentry(var_6, var_7);
  var_14 = "flex_height_up_start";
  var_15 = getnotetracktimes(var_13, var_14);

  if(var_15.size == 0) {
    var_14 = "flex_height_start";
    var_15 = getnotetracktimes(var_13, var_14);

    if(var_15.size == 0) {
      var_14 = "traverse_jump_start";
      var_15 = getnotetracktimes(var_13, var_14);
    }
  }

  var_16 = "flex_height_up_end";
  var_17 = getnotetracktimes(var_13, var_16);

  if(var_17.size == 0) {
    var_16 = "flex_height_end";
    var_17 = getnotetracktimes(var_13, var_16);

    if(var_17.size == 0) {
      var_16 = "traverse_jump_end";
      var_17 = getnotetracktimes(var_13, var_16);
    }
  }

  var_18 = "highest_point";
  var_19 = getnotetracktimes(var_13, var_18);
  var_20 = "flex_height_down_start";
  var_21 = getnotetracktimes(var_13, var_20);
  var_22 = "flex_height_down_end";
  var_23 = getnotetracktimes(var_13, var_22);
  var_24 = "crawler_early_stop";
  var_25 = getnotetracktimes(var_13, var_24);
  var_26 = getnotetracktimes(var_13, "code_move");

  if(var_26.size > 0)
    var_27 = getmovedelta(var_13, 0, var_26[0]);
  else
    var_27 = getmovedelta(var_13, 0, 1);

  var_28 = scripts\anim\notetracks_mp::_id_7DC9(var_8, var_27);
  var_29 = animhasnotetrack(var_13, "ignoreanimscaling");

  if(var_29)
    var_28._id_13E2B = 1.0;

  self scragentsetphysicsmode("noclip");
  var_30 = self _meth_8145();

  if(isDefined(var_30) && isDefined(var_30.target)) {
    self.endnode = var_30;

    if(var_19.size > 0) {
      scripts\anim\notetracks_mp::_id_5AC1(var_6 + "_norestart", var_7, var_13, "traverse", var_14, var_18, 0, ::_id_13FAE);
      var_31 = scripts\engine\utility::getStruct(self.endnode.target, "targetname");

      if(isDefined(var_31.script_noteworthy) && var_31.script_noteworthy == "continue_flex_height")
        scripts\anim\notetracks_mp::_id_5AC1(var_6 + "_norestart", var_7, var_13, "traverse", var_18, var_16, 1, ::_id_13FAE);

      self scragentsetanimscale(1.0, 1.0);
      scripts\anim\notetracks_mp::_id_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::_id_13FAE);
    } else if(var_21.size == 0) {
      scripts\anim\notetracks_mp::_id_5AC1(var_6 + "_norestart", var_7, var_13, "traverse", var_14, var_16, 0, ::_id_13FAE);
      self scragentsetanimscale(1.0, 1.0);
      scripts\anim\notetracks_mp::_id_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::_id_13FAE);
    } else {
      var_31 = scripts\engine\utility::getStruct(self.endnode.target, "targetname");
      var_32 = var_21[0];
      scripts\anim\notetracks_mp::_id_5AC2(var_6 + "_norestart", var_7, "traverse", var_13, var_14, var_16, var_31.origin, var_32, ::_id_13FAE);

      if(var_21[0] - var_17[0] > 0.02) {
        self scragentsetanimscale(1.0, 1.0);
        scripts\anim\notetracks_mp::_id_CED5(var_6 + "_norestart", var_7, "traverse", var_20, ::_id_13FAE);
      }

      var_31 = self.endnode;
      var_32 = var_23[0];
      scripts\anim\notetracks_mp::_id_5AC2(var_6 + "_norestart", var_7, "traverse", var_13, var_20, var_22, var_31.origin, var_32, ::_id_13FAE);
      self scragentsetanimscale(1.0, 1.0);

      if(var_25.size == 0 || !scripts\engine\utility::is_true(self.dismember_crawl))
        scripts\anim\notetracks_mp::_id_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::_id_13FAE);
    }

    self.endnode = undefined;
  } else if(var_21.size > 0 && var_23.size > 0 && self.agent_type != "zombie_brute") {
    self scragentsetanimscale(1.0, 1.0);
    scripts\anim\notetracks_mp::_id_CED5(var_6 + "_norestart", var_7, "traverse", "end", ::_id_13FAE);
  } else if(var_11 && abs(var_8[2]) < 48) {
    var_33 = getanimlength(var_13);
    var_34 = var_15[0] * var_33;
    var_35 = var_17[0] * var_33;
    self scragentsetanimscale(1, 1);
    scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse", var_14);
    self scragentsetanimscale(1, 0);
    childthread _id_126D8(var_4.origin[2], var_5[2], (var_35 - var_34) / self.traverseratescale);
    scripts\anim\notetracks_mp::_id_CED3(var_6 + "_norestart", var_7, self.traverseratescale, "traverse", var_16);
    self scragentsetanimscale(1, 1);
    scripts\anim\notetracks_mp::_id_CED3(var_6 + "_norestart", var_7, self.traverseratescale, "traverse");
  } else if(var_8[2] > 16) {
    if(var_27[2] > 0) {
      if(var_12) {
        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        var_36 = clamp(2 / var_28.z, 0.5, 1);

        if(var_17.size > 0) {
          scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, var_36 * self.traverseratescale, "traverse", var_16);
          scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
          var_37 = var_6 + "_norestart";
          scripts\anim\notetracks_mp::_id_F2B1(var_37, var_7, self.traverseratescale);
          scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
        } else
          scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse");

        self scragentsetanimscale(1, 1);
      } else if(var_15.size > 0) {
        var_28._id_13E2B = 1;
        var_28.z = 1;

        if(!var_29 && length2dsquared(var_9) < 0.64 * length2dsquared(var_27))
          var_28._id_13E2B = 0.4;

        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse", var_14);
        var_38 = getmovedelta(var_13, 0, var_15[0]);
        var_39 = getmovedelta(var_13, 0, var_17[0]);
        var_28._id_13E2B = 1;
        var_28.z = 1;
        var_40 = var_5 - self.origin;
        var_41 = var_27 - var_38;

        if(!var_29 && length2dsquared(var_40) < 0.5625 * length2dsquared(var_41))
          var_28._id_13E2B = 0.75;

        var_42 = var_27 - var_39;
        var_43 = (var_42[0] * var_28._id_13E2B, var_42[1] * var_28._id_13E2B, var_42[2] * var_28.z);
        var_44 = rotatevector(var_43, var_10);
        var_45 = var_5 - var_44;
        var_46 = var_39 - var_38;
        var_47 = rotatevector(var_46, var_10);
        var_48 = var_45 - self.origin;
        var_49 = var_28;
        var_28 = scripts\anim\notetracks_mp::_id_7DC9(var_48, var_47, 1);

        if(var_29)
          var_28._id_13E2B = 1.0;

        if(var_48[2] <= 0)
          var_28.z = 0.0;

        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_1384D("traverse", var_16);
        scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
        var_28 = var_49;
        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
      } else {
        self scragentsetanimscale(var_28._id_13E2B, var_28.z);
        scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse");
      }
    } else
      scripts\anim\notetracks_mp::_id_5AC1(var_6 + "_norestart", var_7, var_13, "traverse", "flex_height_start", "flex_height_end", 1, ::_id_13FAE);
  } else if(abs(var_8[2]) < 16 || var_27[2] == 0) {
    self scragentsetanimscale(var_28._id_13E2B, var_28.z);
    var_36 = clamp(2 / var_28.z, 0.5, 1);

    if(var_17.size > 0) {
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, var_36 * self.traverseratescale, "traverse", var_16);
      scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
      var_37 = var_6 + "_norestart";
      scripts\anim\notetracks_mp::_id_F2B1(var_37, var_7, self.traverseratescale);
      scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
    } else
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse");

    self scragentsetanimscale(1, 1);
  } else if(var_27[2] < 0) {
    self scragentsetanimscale(var_28._id_13E2B, var_28.z);
    var_36 = clamp(2 / var_28.z, 0.5, 1);
    var_51 = var_6 + "_norestart";

    if(var_15.size > 0) {
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, self.traverseratescale, "traverse", var_14);
      var_6 = var_51;
    }

    if(var_17.size > 0) {
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, var_36 * 1.0, "traverse", var_16);
      scripts\anim\notetracks_mp::_id_F2B1(var_51, var_7, self.traverseratescale);

      if(animhasnotetrack(var_13, "removestatelock"))
        scripts\anim\notetracks_mp::_id_1384D("traverse", "removestatelock");

      scripts\anim\notetracks_mp::setstatelocked(0, "DoTraverse");
      scripts\anim\notetracks_mp::_id_1384D("traverse", "code_move");
    } else
      scripts\anim\notetracks_mp::_id_CED3(var_6, var_7, 1.0, "traverse");

    self scragentsetanimscale(1, 1);
  } else {}

  _id_ABB8();
  self scragentsetphysicsmode("gravity");
  self.is_traversing = undefined;
  self notify("traverse_end");
  _id_11701(var_0, var_1);
}

_id_126D8(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_3 = gettime();

  for(;;) {
    var_4 = (gettime() - var_3) / 1000.0;
    var_5 = var_4 / var_2;

    if(var_5 > 1.0) {
      break;
    }

    var_6 = scripts\mp\agents\zombie\zombie_util::_id_AB6F(var_5, var_0, var_1);
    self setOrigin((self.origin[0], self.origin[1], var_6), 0);
    wait 0.05;
  }
}

_id_BE90(var_0) {
  if(self.dismember_crawl)
    return 1;

  return 0;
}

_id_ABB8() {
  var_0 = 0.1;
  var_1 = self._id_6378;
  var_2 = var_1[2];
  var_3 = self.origin[2];

  if(var_3 < var_2)
    self setOrigin((self.origin[0], self.origin[1], var_2 + var_0), 0);
}

_id_11706(var_0, var_1, var_2) {
  self.is_traversing = undefined;
}

_id_11701(var_0, var_1) {
  var_2 = anim.asm[var_0].states[var_1];
  var_3 = undefined;

  if(isDefined(var_2._id_116FB)) {
    if(isarray(var_2._id_116FB[0]))
      var_3 = var_2._id_116FB[0];
    else
      var_3 = var_2._id_116FB;
  }

  scripts\asm\asm::_id_2388(var_0, var_1, var_2, var_2._id_116FB);
  scripts\asm\asm::_id_238A(var_0, var_3, 0.2, undefined, undefined, undefined);
  self notify("killanimscript");
}

_id_D4E3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::_id_237B(self.moveratescale);
  self.asm.cur_move_mode = var_3;
  _id_0F3C::_id_D4DD(var_0, var_1, var_2, var_3);
  scripts\asm\asm::_id_237B(1);
}

_id_CEAE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  _id_0F3A::_id_CEAA(var_0, var_1, var_2, var_3);
}

_id_CEB7(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::_id_237B(self.moveratescale);
  _id_0F3B::_id_CEB5(var_0, var_1, var_2, var_3);
  scripts\asm\asm::_id_237B(1);
}

_id_D515(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::_id_237B(self.moveratescale);
  _id_0F3B::_id_D514(var_0, var_1, var_2, var_3);
  scripts\asm\asm::_id_237B(self.moveratescale);
}

_id_D538(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  scripts\asm\asm::_id_237B(self.moveratescale);

  if(scripts\mp\agents\zombie\zombie_util::_id_8252() < 2) {
    var_4 = level._id_BCE6["run"][1];
    var_4 = var_4 + (self.moveratescale - level._id_BCE6["sprint"][0]);
    scripts\asm\asm::_id_237B(var_4);
  }

  _id_0F3B::_id_D514(var_0, var_1, var_2, var_3);
  scripts\asm\asm::_id_237B(self.moveratescale);
}

_id_13FAE(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "apply_physics":
      self scragentsetphysicsmode("gravity");
      break;
    default:
      break;
  }
}

_id_7389(var_0, var_1, var_2, var_3) {
  var_1 = self._id_7387;
  level thread[[level.frozenzombiefunc]](self);
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);

  if(scripts\engine\utility::is_true(self.activated_slomo_sphere))
    scripts\asm\asm_mp::_id_2365(var_0, var_1, 0.1, var_4, 0.2);
  else if(scripts\engine\utility::is_true(self.activated_venomx_sphere))
    scripts\asm\asm_mp::_id_2365(var_0, var_1, 0.1, var_4, 0.4);
  else
    scripts\asm\asm_mp::_id_2365(var_0, var_1, 0.1, var_4, 0.001);
}

_id_3E12(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(self.isfrozen)) {
    if(isDefined(var_3))
      self._id_7387 = var_3;
    else
      self._id_7387 = scripts\asm\asm::asm_getcurrentstate(var_0);

    return 1;
  }

  return 0;
}

_id_3E18(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::is_true(self.isfrozen)) {
    self._id_7387 = undefined;
    return 1;
  }

  return 0;
}

_id_631D(var_0, var_1, var_2, var_3) {
  self._id_7387 = undefined;
  level thread[[level.thawzombiefunc]](self);
}

_id_A013() {
  if(self _meth_84B9(200))
    return 1;

  return 0;
}

_id_38B2(var_0, var_1, var_2) {
  var_3 = 0.5;
  var_4 = getnotetracktimes(var_0, "turn_extent");

  if(var_4.size == 1)
    var_3 = var_4[0];
  else {
    var_5 = getnotetracktimes(var_0, "code_move");

    if(var_5.size == 1)
      var_3 = var_5[0] * 0.5;
  }

  var_6 = 1.0;
  var_7 = getnotetracktimes(var_0, "finish");

  if(var_7.size == 0)
    var_7 = getnotetracktimes(var_0, "end");

  if(var_7.size == 1)
    var_6 = var_7[0];

  var_8 = getmovedelta(var_0, 0.0, var_3);
  var_9 = getmovedelta(var_0, 0.0, var_6);
  var_10 = self.origin;
  var_11 = rotatevector(var_8, var_1) + var_10;
  var_12 = rotatevector(var_9, var_1) + var_10;

  if(!scripts\anim\notetracks_mp::_id_38D0(var_11, var_12, 0))
    return 0;

  var_13 = self.radius;

  if(!var_2)
    var_13 = self.radius / 2;

  if(!scripts\anim\notetracks_mp::_id_38D0(var_10, var_11, 0, var_13))
    return 0;

  return 1;
}

_id_6BC6(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(self.is_dancing))
    return 1;

  return 0;
}

isdoublejumpanimdone(var_0, var_1, var_2, var_3) {
  if(_id_6BC6(var_0, var_1, var_2, var_3))
    return 0;

  self._id_2CA7 = undefined;
  return 1;
}

_id_CEF3(var_0, var_1, var_2, var_3) {
  self orientmode("face angle abs", self.desired_dance_angles);
  scripts\asm\asm_mp::_id_235F(var_0, var_1, var_2, 1, 0);
}

_id_3EBE(var_0, var_1, var_2) {
  if(isDefined(self._id_2CA7))
    return self._id_2CA7;

  if(self.dismember_crawl) {
    _id_F2E5();
    self._id_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "boombox_dance_crawl_" + level._id_2C9A);
    return self._id_2CA7;
  } else if(scripts\engine\utility::is_true(self._id_9B6E)) {
    self._id_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "disco_dance_center_" + randomintrange(0, 4));
    return self._id_2CA7;
  } else if(scripts\engine\utility::is_true(self.fridge_trap_marked)) {
    self._id_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "fridge_lured_anim_" + randomintrange(0, 4));
    return self._id_2CA7;
  } else {
    _id_F2E6();
    self._id_2CA7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "boombox_dance_" + level._id_2C9B);
    return self._id_2CA7;
  }
}

_id_F2E6() {
  if(!isDefined(level._id_2C9B))
    level._id_2C9B = 0;

  level._id_2C9B++;

  if(level._id_2C9B > 5)
    level._id_2C9B = 0;
}

_id_F2E5() {
  if(!isDefined(level._id_2C9A))
    level._id_2C9A = 0;

  level._id_2C9A++;

  if(level._id_2C9A > 1)
    level._id_2C9A = 0;
}

_id_BE8D(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_3EFE(var_0, var_1, var_2) {
  if(scripts\engine\utility::is_true(self.upgraded_dischord_spin))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "upgraded");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "normal");
}

_id_98DC(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_BE94(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_6658))
    return 0;

  if(!scripts\engine\utility::is_true(self.bneedtoenterplayspace) || scripts\engine\utility::is_true(self.entered_playspace))
    return 0;

  if(!isDefined(level.fn_get_closest_entrance))
    return 0;

  if(!isDefined(self._id_429D)) {
    self._id_429D = [[level.fn_get_closest_entrance]](self.origin);

    if(!isDefined(self._id_429D)) {
      iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
      return 0;
    }
  } else if(!scripts\asm\asm_bb::bb_moverequested()) {
    self._id_429D = scripts\cp\zombies\zombie_entrances::_id_7B14(self.origin, self._id_429D);

    if(!isDefined(self._id_429D)) {
      self.died_poorly = 1;
      self dodamage(self.health + 950, self.origin, self, self, "MOD_SUICIDE");
      return 0;
    }
  }

  self scragentsetgoalRadius(4);
  self scragentsetgoalpos(self._id_429D.origin);

  if(!scripts\asm\asm_bb::bb_moverequested())
    return 0;

  self._id_6658 = self._id_429D;
  self._id_429D = undefined;
  return 1;
}

_id_3ED7(var_0, var_1, var_2) {
  if(isDefined(self._id_662F))
    return self._id_662F;

  var_3 = self.attack_spot;
  var_4 = undefined;

  if(!isDefined(var_3.script_label))
    var_4 = "mid";
  else
    var_4 = var_3.script_label;

  if(scripts\engine\utility::is_true(var_3._id_2A9F))
    var_4 = var_4 + "_extended";

  self._id_662F = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  return self._id_662F;
}

_id_3EBA(var_0, var_1, var_2) {
  var_3 = self.attack_spot;
  var_4 = "standing_";

  if(_id_BE92())
    var_4 = "crawling_";

  if(!isDefined(var_3.script_label))
    var_4 = var_4 + "mid";
  else
    var_4 = var_4 + var_3.script_label;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
}

_id_116E8(var_0, var_1, var_2) {
  if(isDefined(self._id_BF2F)) {
    var_3 = scripts\cp\zombies\zombie_entrances::_id_7872(self._id_6658, self._id_BF2F - 1);

    if(var_3 == "destroying")
      scripts\cp\zombies\zombie_entrances::_id_F2E3(self._id_6658, self._id_BF2F - 1, "boarded");

    self._id_BF2F = undefined;
  }
}

_id_3ECF(var_0, var_1, var_2) {
  var_3 = self.attack_spot;

  if(scripts\engine\utility::is_true(self.isfrozen)) {
    if(isDefined(self._id_BF2F)) {
      scripts\cp\zombies\zombie_entrances::_id_F2E3(self._id_6658, self._id_BF2F - 1, "boarded");
      self._id_BF2F = undefined;
    }

    return self._id_A93A;
  }

  if(self.dismember_crawl) {
    if(!isDefined(var_3.script_label)) {
      self._id_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_1, "crawling");
      return self._id_A93A;
    } else {
      var_4 = _id_F496();
      var_5 = "crawling_" + var_3.script_label + "_" + var_4;
      self._id_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
      return self._id_A93A;
    }
  } else if(!isDefined(var_3.script_label)) {
    self._id_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_1, "standing");
    return self._id_A93A;
  } else {
    while(isDefined(self._id_BF2F))
      wait 0.05;

    var_4 = _id_F496();
    var_5 = "standing_" + var_3.script_label + "_" + var_4;
    self._id_A93A = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
    return self._id_A93A;
  }
}

_id_F496() {
  var_0 = scripts\cp\zombies\zombie_entrances::_id_7B12(self._id_6658);
  self._id_BF2F = var_0;
  scripts\cp\zombies\zombie_entrances::_id_F2E3(self._id_6658, self._id_BF2F - 1, "destroying");
  return var_0;
}

_id_3F13(var_0, var_1, var_2) {
  if(self.dismember_crawl)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crawling");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "standing");
}

_id_532D(var_0, var_1, var_2, var_3) {
  if(var_0 == "board_break" || var_0 == "hit") {
    if(!isDefined(self._id_BF2F)) {
      return;
    }
    var_4 = self._id_BF2F;
    self._id_BF2F = undefined;
    scripts\cp\zombies\zombie_entrances::_id_F2E3(self._id_6658, var_4 - 1, "destroyed");
    scripts\cp\zombies\zombie_entrances::remove_barrier_from_entrance(self._id_6658, var_4);
  }
}

is_player_near_interaction_point(var_0, var_1) {
  var_2 = 2304;
  return distancesquared(var_0.origin, var_1.origin) < var_2;
}

_id_252C(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);

    if(is_player_near_interaction_point(self.closest_player_near_interaction_point, var_4))
      scripts\asm\zombie\melee::domeleedamage(self.closest_player_near_interaction_point, 45, "MOD_IMPACT");
  }
}

_id_CEE3(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self orientmode("face angle abs", self.attack_spot.angles);
  scripts\asm\asm_mp::_id_2364(var_0, var_1, var_2, var_3);
}

_id_CF19(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self orientmode("face angle abs", self.attack_spot.angles);
  scripts\asm\asm_mp::_id_2364(var_0, var_1, var_2, var_3);
}

_id_662E(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self _meth_8281("anim deltas");
  self orientmode("face angle abs", self.attack_spot.angles);
  self scragentsetphysicsmode("noclip");
  self clearpath();
  self scragentsetscripted(1);
  self.do_immediate_ragdoll = 1;
  self.is_traversing = 1;

  if(isDefined(self.attack_spot.script_parameters) && self.attack_spot.script_parameters == "script_adjust") {
    var_4 = anglesToForward(self.attack_spot.angles);
    var_4 = vectorNormalize(var_4);
    var_4 = var_4 * -3.5;
    var_4 = (var_4[0], var_4[1], -1);
    self setOrigin(self.origin + var_4, 0);
  }

  scripts\asm\asm_mp::_id_2365(var_0, var_1, var_2, scripts\asm\asm_mp::asm_getanim(var_0, var_1), self.traverseratescale);
  self.do_immediate_ragdoll = 0;
  self.full_gib = 0;
  self.nocorpse = undefined;
  self scragentsetscripted(0);
  self scragentsetphysicsmode("gravity");
  self.entered_playspace = 1;
  self.bneedtoenterplayspace = undefined;
  self._id_6659 = undefined;
  self._id_6658 = undefined;
  self._id_BF2F = undefined;
  self.is_traversing = undefined;
  self scragentsetgoalRadius(4);
  self scragentsetgoalpos(self.origin);
  scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
  self.attack_spot = undefined;
}

_id_BA3E() {
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
  self._id_6659 = undefined;
  self._id_6658 = undefined;
  self._id_BF2F = undefined;
  scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
  self.attack_spot = undefined;
}

_id_1305A(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.attack_spot.target))
    return 0;

  var_4 = getnodearray(self.attack_spot.target, "targetname");

  if(!isDefined(var_4) || var_4.size == 0)
    return 0;

  var_5 = var_4[0];

  if(!isDefined(var_5) || !isDefined(var_5.animscript))
    return 0;

  var_4 = getnodearray(var_5.target, "targetname");

  if(!isDefined(var_4) || var_4.size == 0)
    return 0;

  var_6 = var_4[0];
  self scragentsetgoalpos(var_6.origin);
  self._id_6659 = 0;
  thread _id_BA3E();
  return 1;
}

_id_BA3D() {
  self endon("death");
  self.noturnanims = 1;
  self.stopsoonnotifydist = 200;
  self _meth_84BD();
  self waittill("stop_soon");
  self.attack_spot = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(self._id_6658);

  if(!scripts\cp\zombies\zombie_entrances::_id_9CD3(self.attack_spot))
    scripts\cp\zombies\zombie_entrances::_id_3FF0(self.attack_spot);
  else {
    self scragentsetgoalpos(self.origin);

    while(_id_BE93()) {
      var_0 = scripts\cp\zombies\zombie_entrances::get_open_attack_spot(self._id_6658);

      if(isDefined(var_0) && !scripts\cp\zombies\zombie_entrances::_id_9CD3(var_0)) {
        self.attack_spot = var_0;
        scripts\cp\zombies\zombie_entrances::_id_3FF0(self.attack_spot);
        break;
      }

      self._id_331F = 1;
      wait 0.05;
    }

    self._id_331F = undefined;
  }

  var_1 = getclosestpointonnavmesh(self.attack_spot.origin, self);
  var_2 = (self.attack_spot.origin[0], self.attack_spot.origin[1], var_1[2]);
  self scragentsetgoalpos(var_2);
  self waittill("goal_reached");
  var_3 = (self.attack_spot.origin[0], self.attack_spot.origin[1], self.origin[2]);
  self setOrigin(var_3, 0);
  self.noturnanims = 0;
  scripts\cp\zombies\zombie_entrances::_id_E005(self._id_6658);
  self._id_6659 = 1;
}

_id_5AEE(var_0, var_1, var_2, var_3) {
  self._id_6659 = 0;
  scripts\cp\zombies\zombie_entrances::_id_16D1(self._id_6658);
  self scragentsetgoalRadius(4);
  self scragentsetgoalpos(self._id_6658.origin);
  thread _id_BA3D();
  return 1;
}

_id_DD1E(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(self._id_6659))
    return 1;

  return 0;
}

_id_BE93(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\zombies\zombie_entrances::_id_7B12(self._id_6658);

  if(!isDefined(var_4))
    return 0;

  return 1;
}

_id_13F9B(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_bb::bb_clearmeleerequestcomplete();
  return 1;
}

_id_10007(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.asm.cur_move_mode))
    return 0;

  switch (self.asm.cur_move_mode) {
    case "walk":
    case "slow_walk":
      return 0;
  }

  return 1;
}

_id_FFC0(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_7089))
    return 0;

  if(_id_BE92())
    return 0;

  var_4 = "mid";

  if(isDefined(self.attack_spot.script_label))
    var_4 = self.attack_spot.script_label;

  self.closest_player_near_interaction_point = [[level._id_7089]](self);

  if(!isDefined(self.closest_player_near_interaction_point))
    return 0;

  if(randomint(100) > 50)
    return 0;

  return 1;
}

_id_9FF5(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::is_true(level._id_2AAD))
    return 1;

  if(scripts\engine\utility::is_true(self._id_331F))
    return 1;

  return 0;
}

isdowned(var_0, var_1, var_2, var_3) {
  return !_id_9FF5(var_0, var_1, var_2, var_3);
}

_id_3F0B(var_0, var_1, var_2) {
  var_3 = "standing";

  if(_id_BE92())
    var_3 = "crawling";

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_1002F(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4() && !scripts\engine\utility::is_true(self.stunned);
}

_id_1003A(var_0, var_1, var_2, var_3) {
  if(self.hasplayedvignetteanim) {
    if(scripts\asm\asm_bb::bb_moverequested())
      return 1;

    if(isDefined(self.spawner) && isDefined(self.spawner.script_animation) && self.spawner.script_animation == "spawn_wall_low")
      return 1;
  }

  return 0;
}
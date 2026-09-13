/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2583d21413584ab5.gsc
***********************************************/

_id_5171170AC608CA01() {}

_id_0B45B4CB9B781CBD(asmname, statename, params) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  self.asm.frantic = 0;
  self.fnshouldplaypainanim = ::_id_1AFCC60B17153ED5;
  self._id_8D2F044239555096 = ::_id_8951ABEB9DFE1E74;
  self._id_D1A1ED2D1B493E2B = [];
  self.postsharpturnlookaheaddist = 64;
  self _meth_7ADFCC654DD371DA(self._id_AE3EA15396B65C1F);

  if(getdvarint("dvar_3A2B15C19281B591", 1) == 1)
    thread _id_13D1C402F1421C35::monitorflash();
}

_id_FDF3CBF366143618(asmname, statename, params) {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation)) {
    _id_39129AEFC4AAFB2A = "";

    switch (self.legacy.movemode) {
      case "slow_walk":
      case "walk":
        _id_39129AEFC4AAFB2A = "_walk";
        break;
      case "sprint":
      case "run":
        _id_39129AEFC4AAFB2A = "_run";
        break;
      default:
        _id_39129AEFC4AAFB2A = "_run";
        break;
    }

    _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, self.spawner.script_animation + _id_39129AEFC4AAFB2A);

    if(isDefined(_id_2C8936D08F85C5C1))
      return _id_2C8936D08F85C5C1;

    _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, self.spawner.script_animation);

    if(isDefined(_id_2C8936D08F85C5C1))
      return _id_2C8936D08F85C5C1;
  }

  if(!isDefined(params))
    return scripts\asm\asm::asm_getrandomanim(asmname, statename);

  return scripts\asm\asm::asm_lookupanimfromalias(statename, params);
}

_id_F31533243DB1C788(asmname, statename, params) {
  return _id_FDF3CBF366143618(asmname, statename, params);
}

_id_E1F5F5125707EEFB(asmname, statename, params) {
  if(!isDefined(params))
    return scripts\asm\asm::asm_getrandomanim(asmname, statename);

  return scripts\asm\asm::asm_lookupanimfromalias(statename, params);
}

_id_E94D69D6EE392462(asmname, statename, params) {
  _id_440A5018F31077E0 = 0;
  _id_8042F163EA214B81 = 0;
  _id_48AB287AD776F873 = self getanimentrycount(statename);

  if(_id_48AB287AD776F873 == 1)
    self._id_D1A1ED2D1B493E2B[statename] = 0;
  else if(!isDefined(self._id_D1A1ED2D1B493E2B[statename]))
    self._id_D1A1ED2D1B493E2B[statename] = randomintrange(0, _id_48AB287AD776F873);

  self.asm._id_E85FBBC11DF3EC6C = tolower(self._id_D1A1ED2D1B493E2B[statename] + 1);

  if(isDefined(params))
    self.asm._id_E85FBBC11DF3EC6C = params + self.asm._id_E85FBBC11DF3EC6C;

  return self._id_D1A1ED2D1B493E2B[statename];
}

_id_88C988506100B781(asmname, statename, params) {
  _id_CDDEE9B090651865 = self getanimentrycount(statename);
  _id_65FACA4AE4AF2C9D = _id_0A662F25DBF78119::_id_15B80AE6984F4CCC(self.damagepoint, self.damagedir);
  _id_077B9E4B599269EB = angleclamp180(_id_65FACA4AE4AF2C9D - self.angles[1]);
  animindex = _id_0A662F25DBF78119::_id_E99764063B47DF86(_id_077B9E4B599269EB, _id_CDDEE9B090651865);
  return animindex;
}

_id_1050ABC64E117EA0(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_5784DA860A9BDB4F = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);

  if(isDefined(self.pathgoalpos)) {
    self animmode("normal");
    self orientmode("face motion");
  }

  _id_C9EDB1B72607D824 = self getanimentry(statename, _id_5784DA860A9BDB4F);
  animlength = getanimlength(_id_C9EDB1B72607D824);
  _id_C08B84490B532FB2 = 1;

  if(isDefined(self._id_0DA951E8204605E7) && self._id_0DA951E8204605E7 > 0)
    _id_C08B84490B532FB2 = self._id_0DA951E8204605E7;

  animlength = animlength * (1 / _id_C08B84490B532FB2);
  self._id_0755E27D4E82884D = gettime() + animlength * 0.75 * 1000;
  scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack_safe(statename, _id_5784DA860A9BDB4F, self._id_0DA951E8204605E7, "pain_anim");
  finishpain(asmname, statename, params);
}

_id_68F7AB36A507151B(asmname, statename, params) {
  self endon("death");
  self endon(statename + "_finished");
  animindex = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, self.asm._id_E85FBBC11DF3EC6C);

  if(!isDefined(animindex))
    animindex = scripts\asm\asm::asm_getrandomanim(asmname, statename);

  customfunc = scripts\asm\asm::asm_getnotehandler(asmname, statename);
  thread scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(statename, animindex, statename, "end", customfunc);
  self._id_0755E27D4E82884D = gettime() + 10000;
  wait 0.35;
  scripts\asm\asm::asm_fireevent(asmname, "end");
}

_id_9E24E56CA66F3CF5(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_711A734D0B3EF147 = _id_3FA2C56024CEB355();

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && (isDefined(_id_711A734D0B3EF147) && _id_711A734D0B3EF147 >= 0))
    return 1;

  return scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand", "left_leg_upper", "left_foot", "left_leg_lower");
}

_id_B3690E2C7A85D44E(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_711A734D0B3EF147 = _id_3FA2C56024CEB355();

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower") && (isDefined(_id_711A734D0B3EF147) && _id_711A734D0B3EF147 < 0))
    return 1;

  return scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand", "right_leg_upper", "right_foot", "right_leg_lower");
}

_id_179263C4907D7366(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\engine\utility::damagelocationisany("head", "neck", "helmet");
}

_id_3FA2C56024CEB355() {
  _id_65FACA4AE4AF2C9D = _id_0A662F25DBF78119::_id_15B80AE6984F4CCC(self.damagepoint, self.damagedir);
  _id_077B9E4B599269EB = angleclamp180(_id_65FACA4AE4AF2C9D - self.angles[1]);
  return _id_077B9E4B599269EB;
}

finishpain(asmname, statename, params) {
  self notify("killanimscript");
  self asmsetstate(asmname, "choose_idle");
}

_id_1AFCC60B17153ED5() {
  if(isDefined(self.allowpain) && self.allowpain == 0)
    return 0;

  if(isDefined(self.isfrozen) && self.isfrozen)
    return 0;

  if(isDefined(self._id_0755E27D4E82884D) && gettime() < self._id_0755E27D4E82884D)
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(isDefined(level._id_6B455C4ECE747602) && self istouching(level._id_6B455C4ECE747602))
    return 0;

  if(!istrue(self.stunned)) {
    if(scripts\asm\asm_bb::bb_meleerequested())
      return 0;

    if(scripts\asm\asm_bb::bb_meleeinprogress())
      return 0;
  }

  return 1;
}

_id_C5259C6807077972(location) {
  switch (location) {
    case "left_leg_lower":
    case "left_foot":
    case "left_leg_upper":
    case "right_leg_lower":
    case "right_foot":
    case "right_leg_upper":
      return 1;
    default:
      return 0;
  }
}

_id_E7277E5837922670(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_1AAA2F84052E7F9E() {
  if(isDefined(self.dismember_crawl))
    return self.dismember_crawl;

  return 0;
}

_id_935A1A773C29B4A4(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

_id_72A9AC4D7161B337(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(_id_EAC756C4A01AA740())
    return 1;

  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_1C259F23502E8457() {
  if(_id_EAC756C4A01AA740() && _id_54F55A19E6121F5C() && !_id_3F81275D560DA0CC())
    return 1;

  return 0;
}

_id_298A3BABA2C0C486() {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_animation))
    return !istrue(self.hasplayedvignetteanim);

  return 0;
}

_id_F747AB033E3A3B34(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._id_76F034E6150F2F5B);
}

_id_D3A4CB085DE246AA() {
  if(isDefined(self.spawner) && isDefined(self.spawner.script_fxid))
    return !istrue(self._id_2392A32020FB22B5);

  return 0;
}

_id_32FE100BB68249B1() {
  if(isDefined(self._id_76F034E6150F2F5B))
    return 0;
  else
    return 1;
}

_id_DABDD08D8888F419() {
  if(isDefined(self.agent_type) && self.agent_type == "zombie_brute")
    return 0;

  _id_9A1091BBE235A0AF = isDefined(self.asm.cur_move_mode) && self.asm.cur_move_mode != self._blackboard.movetype;

  if(_id_9A1091BBE235A0AF)
    return 1;
  else
    return 0;
}

_id_7F788F4B6412959C() {
  return istrue(self._id_CD4A93C4290D87F4);
}

_id_EAC756C4A01AA740() {
  return istrue(self.is_suicide_bomber);
}

_id_54F55A19E6121F5C() {
  return istrue(self.should_play_transformation_anim);
}

_id_3F81275D560DA0CC() {
  return istrue(self._id_3F81275D560DA0CC);
}

_id_7F68C2D87F68A3D6(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.is_suicide_bomber))
    return 1;

  return 0;
}

_id_0EDB1A9282567481(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self.agent_type == "zombie_cop") {
    if(getdvarint("scr_dont_use_cop_anims") != 0)
      return 0;

    return 1;
  }

  return 0;
}

_id_D9AC1AB87EA75817(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}

_id_CDD2728421148C33(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._id_F514A0EBC5F19D0A);
}

_id_A9AC9E09A3AD81A9(asmname, statename, params) {
  self notify("facemelter_launch_chosen");

  if(istrue(self.dismember_crawl))
    return "prone_launch";

  return "launch";
}

_id_4986AD1EE7C7645E(asmname, statename, _id_F2B19B25D457C2A6, params) {
  self notify("ready_to_launch");
}

_id_8B17AB8FF48E93D6(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._id_B584A0D8C3848134);
}

_id_DA153F2B892CFFB3(asmname, statename, params) {
  if(istrue(self.dismember_crawl))
    return "prone_spin";

  return "spin";
}

_id_C5080A5FEB1CF91D(asmname, statename, _id_F2B19B25D457C2A6, params) {
  self notify("ready_to_spin");
}

_id_B7BF2E39DDAD93A5(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self.head_is_exploding);
}

_id_E65CAFA6EB819A24(asmname, statename, params) {
  if(istrue(self.dismember_crawl))
    return "prone_expand_head";

  return "expand_head";
}

_id_5198AC8CCDE95415(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}

_id_DF87C28A61DCF3BC(asmname, statename, params) {
  self endon(statename + "_finished");
  self.scripted_mode = 1;
  self animmode("noclip");
  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  _id_07B60BC0EAB3FD1E = 0.01;
  thread scripts\asm\asm_mp::asm_playanimstateindex(asmname, statename, animindex, _id_07B60BC0EAB3FD1E);

  if(isDefined(level._id_1F279D0FBC91E916))
    self[[level._id_1F279D0FBC91E916]]();

  wait 0.5;
  self._id_2392A32020FB22B5 = 1;
}

_id_76826812C7FFC3F6(asmname, statename, params) {
  self endon(statename + "_finished");
  self.scripted_mode = 1;
  self animmode("noclip");
  thread scripts\asm\shared\utility::playanim(asmname, statename, params);
  wait 1;
  level thread[[level._id_89367E9D1D0E66AA]](self);
}

_id_8514C9ADBB3F1C9C(asmname, statename, params) {
  self endon(statename + "_finished");
  self.scripted_mode = 1;
  self._id_06263830DFE60A23 = 1;
  self._id_BAE9B33C9C1783AF = 1;
  self.ignoreall = 1;
  self animmode("noclip");
  scripts\mp\agents\scriptedagents::setstatelocked(1, "play_vignette_anim");
  self.hasplayedvignetteanim = 0;
  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);

  if(isDefined(self.spawner) && isDefined(self.spawner._id_69BDD83CCC975AC2))
    thread _id_511370885519AAB5(asmname, statename, animindex);

  _id_07B60BC0EAB3FD1E = 1.0;

  if(isDefined(self._id_63878E2A57DE6CB7))
    _id_07B60BC0EAB3FD1E = self._id_63878E2A57DE6CB7;

  save = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  scripts\asm\asm_mp::_id_4895EAFF78A2FC42(asmname, statename, animindex, _id_07B60BC0EAB3FD1E, "code_move");
  self.do_immediate_ragdoll = save;
  self animmode("gravity");
  self.scripted_mode = 0;
  self.ignoreall = 0;
  scripts\mp\agents\scriptedagents::setstatelocked(0, "play_vignette_anim");
  self._id_BAE9B33C9C1783AF = undefined;
  self.hasplayedvignetteanim = 1;
  self notify("intro_vignette_done");
}

_id_5384FBF2844C9CAA(asmname, statename, params) {
  self animmode("gravity");
  self.scripted_mode = 0;
  self.hasplayedvignetteanim = 1;
  self._id_06263830DFE60A23 = undefined;
  self._id_BAE9B33C9C1783AF = undefined;
}

_id_A8FE0E21676965C7(asmname, statename) {
  self endon(statename + "_finished");
  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  stopanim = self getanimentry(statename, animindex);
  time = getanimlength(stopanim);
  _id_8362CE0A01469DE5 = getnotetracktimes(stopanim, "fall");
  _id_2C91110DC038BB62 = getnotetracktimes(stopanim, "land");
  _id_160B9FFC98A00311 = getmovedelta(stopanim, _id_8362CE0A01469DE5[0], _id_2C91110DC038BB62[0]);
  _id_35A0F5AFB933E47B = 1;
  scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack_safe(statename, animindex, _id_35A0F5AFB933E47B, statename, "fall", undefined);

  if(_id_160B9FFC98A00311 == (0, 0, 0)) {
    self animmode("gravity");
    return;
  }

  ground_pos = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  ground_pos = self.spawner._id_22EC0DC3205D2D67;
  _id_2E28A9F423D2F51F = ground_pos - self.origin;
  _id_3F90DEBA7282476C = _id_2E28A9F423D2F51F[2] / _id_160B9FFC98A00311[2];
  _id_047085F3BF583F9F = time * _id_2C91110DC038BB62[0] - time * _id_8362CE0A01469DE5[0];
  _id_A326F793BDAF5565 = _id_047085F3BF583F9F * _id_3F90DEBA7282476C;

  if(_id_3F90DEBA7282476C >= 1) {
    _id_35A0F5AFB933E47B = 1 / _id_3F90DEBA7282476C;
    scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack_safe(statename, animindex, _id_35A0F5AFB933E47B, statename, "land", undefined);
    _id_35A0F5AFB933E47B = 1;
    self animmode("gravity");
    scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack_safe(statename, animindex, _id_35A0F5AFB933E47B, statename, "end", undefined);
  }
}

_id_511370885519AAB5(asmname, statename, animindex) {
  self endon(statename + "_finished");
  stopanim = self getanimentry(statename, animindex);
  time = getanimlength(stopanim);
  _id_8362CE0A01469DE5 = getnotetracktimes(stopanim, "fall");
  _id_2C91110DC038BB62 = getnotetracktimes(stopanim, "land");

  if(_id_8362CE0A01469DE5.size > 0 && _id_2C91110DC038BB62.size > 0) {
    _id_160B9FFC98A00311 = getmovedelta(stopanim, _id_8362CE0A01469DE5[0], _id_2C91110DC038BB62[0]);
    scripts\mp\agents\scriptedagents::waituntilnotetrack(statename, "fall", statename, animindex, undefined);
  } else {
    wait(time);
    return;
  }

  if(_id_160B9FFC98A00311 == (0, 0, 0)) {
    return;
  }
  ground_pos = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  ground_pos = self.spawner._id_22EC0DC3205D2D67;
  _id_2E28A9F423D2F51F = ground_pos - self.origin;
  _id_3F90DEBA7282476C = _id_2E28A9F423D2F51F[2] / _id_160B9FFC98A00311[2];
  _id_047085F3BF583F9F = time * _id_2C91110DC038BB62[0] - time * _id_8362CE0A01469DE5[0];
  _id_A326F793BDAF5565 = _id_047085F3BF583F9F * _id_3F90DEBA7282476C;

  if(_id_3F90DEBA7282476C >= 1) {
    scripts\mp\agents\scriptedagents::waituntilnotetrack(statename, "land", statename, animindex, undefined);
    self animmode("gravity");
  }
}

_id_6B0824ACB092315C(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.spawner) && isDefined(self.spawner._id_69BDD83CCC975AC2))
    return 1;

  return 0;
}

_id_AA9905227E82DC3B(asmname, statename, params) {
  self endon(statename + "_finished");
  scripts\asm\shared\utility::playanim(asmname, statename, params);
  self._id_3F81275D560DA0CC = 1;
}

_id_FF2403259D090C4B(should_play_transformation_anim) {
  self.entered_playspace = 1;
  self.is_suicide_bomber = 1;
  self.nocorpse = 1;
  self.should_play_transformation_anim = should_play_transformation_anim;
  self.health = _id_D5DCD504E1FAAE23();
  self.ignoreall = 0;
  self setscriptablepartstate("eyes", "eye_glow_off");
  self detachall();
  _id_76EBAEA8D54BCF28 = ["park_clown_zombie", "park_clown_zombie_blue", "park_clown_zombie_green", "park_clown_zombie_orange", "park_clown_zombie_yellow"];
  _id_5C58A6F115C9F898 = scripts\engine\utility::random(_id_76EBAEA8D54BCF28);
  self setModel(_id_5C58A6F115C9F898);
  scripts\asm\asm_bb::bb_requestmovetype("sprint");

  if(isDefined(level._id_4AA88117585B3EF5))
    self _meth_748A16E0D1FE8B85(level._id_4AA88117585B3EF5);
}

_id_D5DCD504E1FAAE23() {
  _id_081413730FB58D4F = 200;

  switch (level._id_7D95C78D0E490B08) {
    case 0:
      _id_081413730FB58D4F = 100;
      break;
    case 1:
      _id_081413730FB58D4F = 400;
      break;
    case 2:
      _id_081413730FB58D4F = 900;
      break;
    case 3:
      _id_081413730FB58D4F = 1300;
      break;
    default:
      _id_081413730FB58D4F = 1600;
  }

  return _id_081413730FB58D4F;
}

_id_5AE9A5D059D0030A(idamage, objweapon, smeansofdeath, shitloc) {
  if(scripts\mp\agents\scriptedagents::isstatelocked())
    return 0;

  if(self.aistate == "traverse")
    return 0;

  if(isDefined(smeansofdeath) && isexplosivedamagemod(smeansofdeath) && idamage >= 350) {
    if(isDefined(objweapon) && !issubstr(objweapon.basename, "g18pap") && isDefined(objweapon.underbarrel) && !issubstr(objweapon.underbarrel, "g18pap"))
      return 1;
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE")
    return 1;

  if(isDefined(self.stun_hit_time)) {
    if(self.stun_hit_time > gettime())
      return 1;
    else {
      self.stun_hit_time = undefined;
      self.stunned = undefined;
    }
  }

  if(istrue(self.stunned))
    return 1;

  if(isDefined(self._id_89C1E14BB96BD33C) && [[self._id_89C1E14BB96BD33C]]())
    return 1;

  return 0;
}

_id_289CAB085ECD2C1E() {
  if(!self shoulddoarrival())
    return 0;

  if(isDefined(self._id_003B90191D39897A))
    return 0;

  if(isDefined(self._id_D76A82870C350F14))
    return 0;

  return 1;
}

_id_9ECC61D081369543(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!_id_289CAB085ECD2C1E())
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!isDefined(self.approachdir))
    self.approachdir = self.lookaheaddir;

  if(isDefined(self.isfrozen) && self.isfrozen) {
    self.approachdir = undefined;
    return 0;
  }

  if(!isDefined(params) || params.size < 1)
    nodetype = "Exposed";
  else
    nodetype = params[0];

  if(!scripts\asm\shared\utility::isarrivaltype(asmname, statename, _id_F2B19B25D457C2A6, nodetype))
    return 0;

  self.asm.stopdata = _id_13BD38D003C8EF23(asmname, _id_F2B19B25D457C2A6, nodetype);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}

_id_13BD38D003C8EF23(asmname, _id_F2B19B25D457C2A6, nodetype) {
  node = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(node))
    goalpos = node.origin;
  else
    goalpos = self.pathgoalpos;

  _id_0A41EDF45BB0FF97 = _id_395DC18818F65EF2::getcustomarrivalangles();
  approachdir = self.approachdir;
  _id_098309FE48684A69 = vectortoangles(approachdir);

  if(isDefined(_id_0A41EDF45BB0FF97))
    _id_077B9E4B599269EB = angleclamp180(_id_0A41EDF45BB0FF97[1] - _id_098309FE48684A69[1]);
  else if(isDefined(node) && node.type != "Path")
    _id_077B9E4B599269EB = angleclamp180(node.angles[1] - _id_098309FE48684A69[1]);
  else {
    _id_03BB21148DC871D5 = goalpos - self.origin;
    _id_3F0B2928B3D20E77 = vectortoangles(_id_03BB21148DC871D5);
    _id_077B9E4B599269EB = angleclamp180(_id_3F0B2928B3D20E77[1] - _id_098309FE48684A69[1]);
  }

  statename = _id_F2B19B25D457C2A6;
  stopdata = _id_395DC18818F65EF2::_id_4135A2CC5B6963F3();
  _id_CCA29AD02A7C9BC6 = goalpos - self.origin;
  _id_3E7CFCDE4082C05E = lengthsquared(_id_CCA29AD02A7C9BC6);
  _id_CB2DB50AF34426A8 = 0;
  stopanim = self getanimentry(statename, _id_CB2DB50AF34426A8);
  _id_F075350FC4BE0D85 = getmovedelta(stopanim);
  _id_FD7C686CEAD623AA = getangledelta(stopanim);
  speed = length(self getvelocity());
  _id_8B8C240A0C200744 = speed * 0.053;
  _id_C92AEBFF8AAF03BA = length(_id_CCA29AD02A7C9BC6);
  _id_8DE6AAEAC22DB149 = length(_id_F075350FC4BE0D85);

  if(abs(_id_C92AEBFF8AAF03BA - _id_8DE6AAEAC22DB149) > _id_8B8C240A0C200744)
    return undefined;

  if(_id_3E7CFCDE4082C05E < lengthsquared(_id_F075350FC4BE0D85))
    return undefined;

  _id_641C7B140664D9D3 = _id_395DC18818F65EF2::calcanimstartpos(stopdata.pos, stopdata.finalangles[1], _id_F075350FC4BE0D85, _id_FD7C686CEAD623AA);
  _id_6DDA435EB9FD8059 = getclosestpointonnavmesh(stopdata.pos, self);
  _id_844127D31748B6D0 = _id_395DC18818F65EF2::calcanimstartpos(_id_6DDA435EB9FD8059, stopdata.finalangles[1], _id_F075350FC4BE0D85, _id_FD7C686CEAD623AA);
  _id_DA0655335C41C2C2 = self getnavposition();
  traceresults = navtrace(_id_DA0655335C41C2C2, _id_6DDA435EB9FD8059, self, 1);
  _id_58A8DB9B7B528979 = traceresults["fraction"] >= 0.9 || _func_BE87C989A3B9C6CD(_id_DA0655335C41C2C2, _id_6DDA435EB9FD8059, self);

  if(!_id_58A8DB9B7B528979) {
    pathdist = self pathdisttogoal();
    _id_58A8DB9B7B528979 = pathdist < distance(_id_DA0655335C41C2C2, _id_6DDA435EB9FD8059) + 8.0;
  }

  if(_id_58A8DB9B7B528979) {
    result = spawnStruct();
    result._id_CB2DB50AF34426A8 = _id_CB2DB50AF34426A8;
    result.angleindex = 0;
    result.startpos = _id_641C7B140664D9D3;
    result.angledelta = _id_FD7C686CEAD623AA;
    result.angles = stopdata.angles;
    result.finalangles = stopdata.finalangles;
    result._id_F075350FC4BE0D85 = _id_F075350FC4BE0D85;
    result._id_70B532DBD77D980C = goalpos;
    return result;
  }

  return undefined;
}

_id_81C487B3DDB51C61(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  startnode = self getnegotiationstartnode();
  endpos = self getnegotiationendpos();
  self orientmode("face angle", startnode.angles[1]);
  self animmode("noclip");
  _id_2674A2C3EE67214B = endpos - startnode.origin;
  _id_FE955022D7616EA0 = self getanimentry(statename, 0);
  time = getanimlength(_id_FE955022D7616EA0);
  movedelta = getmovedelta(_id_FE955022D7616EA0);
  dist = length(movedelta);
  _id_882B8312CAB56059 = length(endpos - self.origin);
  _id_A326F793BDAF5565 = time * (_id_882B8312CAB56059 / dist);
  self setanimstate(statename, 0);
  wait(_id_A326F793BDAF5565);
  self animmode("gravity");
  self notify("traverse_end");
  _id_F518CF782C8EDCCC(asmname, statename);
}

_id_3EAE95E96B61D1C3(asmname, statename, params) {
  if(!isDefined(params))
    return scripts\asm\asm::asm_getrandomanim(asmname, statename);

  switch (self._blackboard.movetype) {
    case "slow_walk":
    case "walk":
      params = params + "_walk";
      break;
    case "sprint":
    case "run":
      params = params + "_run";
      break;
    default:
      params = params + "_walk";
      break;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, params);
}

_id_DAA730BF09B40F6E(asmname, statename, params) {
  scripts\mp\agents\scriptedagents::setstatelocked(1, "DoTraverse");
  save = self.do_immediate_ragdoll;
  self.do_immediate_ragdoll = 1;
  _id_5B4A1EB650307677(asmname, statename, params);
  self.do_immediate_ragdoll = save;
  scripts\mp\agents\scriptedagents::setstatelocked(0, "Traverse end_script");
  self.hastraversed = 1;
  self._id_602AF8E12C1F5762 = undefined;
}

_id_7805CAD6E073B597(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  thread _id_76BC0DF53DCCE5E2(statename);
  startnode = self getnegotiationstartnode();
  endpos = self getnegotiationendpos();
  self.endnodepos = endpos;

  if(!isDefined(startnode)) {
    return;
  }
  if(!isDefined(endpos)) {
    return;
  }
  self.endpos = endpos;
  self._id_602AF8E12C1F5762 = vectorNormalize(endpos - startnode.origin);
  _id_E684FC6E068EE951 = undefined;
  _id_E684FC6E068EE951 = startnode.animscript;

  if(statename == "traverse_external")
    _id_E684FC6E068EE951 = statename;

  if(_id_99B9164945615B4B(_id_E684FC6E068EE951))
    _id_E684FC6E068EE951 = "crawling_" + _id_E684FC6E068EE951;

  if(!isDefined(_id_E684FC6E068EE951)) {
    return;
  }
  self._id_06263830DFE60A23 = 1;
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename, params);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  _id_9DD1CAE60FDDAF42 = issubstr(_id_E684FC6E068EE951, "jump_across");
  _id_785BA42B113D82E0 = _id_E684FC6E068EE951 == "traverse_boost" && (self.species == "humanoid" || self.species == "zombie");
  _id_2674A2C3EE67214B = endpos - startnode.origin;
  _id_D1082E47EA645E4D = (_id_2674A2C3EE67214B[0], _id_2674A2C3EE67214B[1], 0);
  _id_27B29B9E759793C1 = vectortoangles(_id_D1082E47EA645E4D);
  self orientmode("face angle", _id_27B29B9E759793C1[1]);
  self animmode("noclip");
  self._id_7D5B7F7081DDE035 = xanim;
  self._id_90CBFD047E12E8EF = startnode.angles;
  scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack_safe(_id_E684FC6E068EE951, _id_2C8936D08F85C5C1, 1.0, "traverse", undefined, ::_id_445DDDA581E240A1);
  _id_9DFE69C62C8FD0AD();
  self._id_06263830DFE60A23 = undefined;
  self notify("traverse_end");
  _id_F518CF782C8EDCCC(asmname, statename);
}

_id_887355020737CC27(_id_B9460E0CB9B449A3, endnote) {
  _id_94E409E1253102FD = getnotetracktimes(self._id_7D5B7F7081DDE035, _id_B9460E0CB9B449A3)[0];
  _id_B9CB504B8DAD8D60 = getnotetracktimes(self._id_7D5B7F7081DDE035, endnote)[0];
  _id_572AC7D0A59EFF91 = getmovedelta(self._id_7D5B7F7081DDE035, _id_94E409E1253102FD, 1.0);
  _id_6640D21A7514EDFE = self.endpos - self.origin;
  _id_C83457B23E7D2715 = _id_6640D21A7514EDFE[2] - _id_572AC7D0A59EFF91[2];
  _id_594117440B4B551A = getmovedelta(self._id_7D5B7F7081DDE035, _id_94E409E1253102FD, _id_B9CB504B8DAD8D60);
  _id_4591AAC0BFE1809F = (_id_594117440B4B551A[0], _id_594117440B4B551A[1], _id_594117440B4B551A[2] + _id_C83457B23E7D2715);
  _id_7554EB049F62C03D = rotatevector(_id_4591AAC0BFE1809F, self._id_90CBFD047E12E8EF);
  endpos = self.origin + _id_7554EB049F62C03D;
  return endpos;
}

_id_445DDDA581E240A1(_id_A234A65C378F3289, _id_E684FC6E068EE951, animindex, _id_EB5B1F36E255152D) {
  if(_id_A234A65C378F3289 == "warp_up_start")
    scripts\engine\utility::motionwarpwithnotetracks(self._id_7D5B7F7081DDE035, self.endpos, self._id_90CBFD047E12E8EF, _id_A234A65C378F3289, undefined);
  else if(_id_A234A65C378F3289 == "flex_height_up_start") {
    endpos = _id_887355020737CC27("flex_height_up_start", "flex_height_up_end");
    scripts\engine\utility::motionwarpwithnotetracks(self._id_7D5B7F7081DDE035, endpos, self._id_90CBFD047E12E8EF, "flex_height_up_start", "flex_height_up_end");
  } else if(_id_A234A65C378F3289 == "flex_height_down_start") {
    endpos = _id_887355020737CC27("flex_height_down_start", "flex_height_down_end");
    scripts\engine\utility::motionwarpwithnotetracks(self._id_7D5B7F7081DDE035, endpos, self._id_90CBFD047E12E8EF, "flex_height_down_start", "flex_height_down_end");
  }
}

_id_76BC0DF53DCCE5E2(statename) {
  self waittill(statename + "_finished");
  self.endpos = undefined;
  self._id_7D5B7F7081DDE035 = undefined;
  self._id_90CBFD047E12E8EF = undefined;
}

_id_5B4A1EB650307677(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  _id_7805CAD6E073B597(asmname, statename, params);
}

_id_E3DD80AECFE07F21(_id_1B11E8A9B42E4C1B, _id_688F95559BF04904, time) {
  self endon("death");
  self endon("terminate_ai_threads");
  start_time = gettime();

  for(;;) {
    _id_B497E19421070AE9 = (gettime() - start_time) / 1000.0;
    _id_FFDE424D65D22EA6 = _id_B497E19421070AE9 / time;

    if(_id_FFDE424D65D22EA6 > 1.0) {
      break;
    }

    _id_E71132C226369AF9 = _id_0A662F25DBF78119::lerp(_id_FFDE424D65D22EA6, _id_1B11E8A9B42E4C1B, _id_688F95559BF04904);
    self setOrigin((self.origin[0], self.origin[1], _id_E71132C226369AF9), 0);
    wait 0.05;
  }
}

_id_99B9164945615B4B(_id_E684FC6E068EE951) {
  if(self.dismember_crawl)
    return 1;

  return 0;
}

_id_9DFE69C62C8FD0AD() {
  _id_63398238E011F4F2 = 0.1;
  endpos = self.endpos;
  _id_4B07BAF10FAAD247 = endpos[2];
  _id_9A630A8BC02791EF = self.origin[2];

  if(_id_9A630A8BC02791EF < _id_4B07BAF10FAAD247)
    self setOrigin((self.origin[0], self.origin[1], _id_4B07BAF10FAAD247 + _id_63398238E011F4F2), 0);
}

_id_69BA7430B8B4DB92(asmname, statename, params) {
  self._id_06263830DFE60A23 = undefined;
}

_id_F518CF782C8EDCCC(asmname, statename) {
  self finishtraverse();
  self asmsetstate(asmname, "choose_movetype");
  self notify("killanimscript");
}

_id_9A4E666BE0DB2E1A(asmname, statename, params) {
  self endon(statename + "_finished");
  scripts\asm\asm::asm_setmoveplaybackrate(self._id_8D31C7EACB516468);
  self animmode("normal");
  self orientmode("face motion");
  self.asm.cur_move_mode = params;
  scripts\asm\shared\utility::playmoveloop(asmname, statename, params);
  scripts\asm\asm::asm_setmoveplaybackrate(1);
}

_id_37FE3EF536870246(asmname, statename, params) {
  self endon(statename + "_finished");
  self animmode("zonly_physics");
  stopdata = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  self orientmode("face angle", stopdata.finalangles[1]);
  thread _id_DF5EB055B3A0252A(statename + "_finished");
  _id_395DC18818F65EF2::playanim_arrival(asmname, statename, params);
  self notify("FinishArrivalAnim");
}

_id_DF5EB055B3A0252A(_id_830905E5C2645826) {
  self endon("death");
  scripts\engine\utility::waittill_any_two(_id_830905E5C2645826, "FinishArrivalAnim");
  self finishcoverarrival();
}

_id_F330681B9D3E66DB(asmname, statename, params) {
  self endon(statename + "_finished");
  scripts\asm\asm::asm_setmoveplaybackrate(self._id_8D31C7EACB516468);
  _id_374477D88E5F2CE2::playanim_exit(asmname, statename, params);
  scripts\asm\asm::asm_setmoveplaybackrate(1);
}

_id_2A6F140C2C70C0C3(asmname, statename, params) {
  self endon(statename + "_finished");
  scripts\asm\asm::asm_setmoveplaybackrate(self._id_8D31C7EACB516468);
  sharpturnindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  self.sharpturnindex = undefined;
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  scripts\asm\asm_mp::_id_4895EAFF78A2FC42(asmname, statename, sharpturnindex, self.moveplaybackrate, "code_move");
  self animmode("normal", 0);
  self orientmode("face motion");
  scripts\asm\asm::asm_setmoveplaybackrate(self._id_8D31C7EACB516468);
}

_id_5367090536186191(asmname, statename, params) {
  self endon(statename + "_finished");
  scripts\asm\asm::asm_setmoveplaybackrate(self._id_8D31C7EACB516468);
  _id_2A6F140C2C70C0C3(asmname, statename, params);
  scripts\asm\asm::asm_setmoveplaybackrate(self._id_8D31C7EACB516468);
}

_id_C533B824AF57608C(_id_A234A65C378F3289, _id_E684FC6E068EE951, animindex, _id_EB5B1F36E255152D) {
  switch (_id_A234A65C378F3289) {
    case "apply_physics":
      self animmode("gravity");
      break;
    default:
      break;
  }
}

_id_AE3BB8A9B52D9234(asmname, statename, params) {
  statename = self.freezestatename;
  level thread[[level._id_5E553E265797AAC7]](self);
  animindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);

  if(istrue(self._id_E6379D2D09A074F1))
    scripts\asm\asm_mp::asm_playanimstateindex(asmname, statename, 0.1, animindex, 0.2);
  else
    scripts\asm\asm_mp::asm_playanimstateindex(asmname, statename, 0.1, animindex, 0.001);
}

_id_7801BE4765AA92BD(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(self.isfrozen)) {
    if(isDefined(params))
      self.freezestatename = params;
    else
      self.freezestatename = scripts\asm\asm::asm_getcurrentstate(asmname);

    return 1;
  }

  return 0;
}

_id_00A7F242F9E89B72(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!istrue(self.isfrozen)) {
    self.freezestatename = undefined;
    return 1;
  }

  return 0;
}

_id_E458CE60DFBF7179(asmname, statename, params) {
  self.freezestatename = undefined;
  level thread[[level._id_10A4D56DC4588169]](self);
}

_id_A1187EAD4F44C8C9() {
  return 0;
}

_id_8951ABEB9DFE1E74(turnanim, _id_F1A4D9D10FD4B365, _id_A9F9C2B0D5B4E555) {
  _id_2A7BE01B49B9FC52 = 0.5;
  _id_8CAFFBBE3D1E80AE = getnotetracktimes(turnanim, "turn_extent");

  if(_id_8CAFFBBE3D1E80AE.size == 1)
    _id_2A7BE01B49B9FC52 = _id_8CAFFBBE3D1E80AE[0];
  else {
    _id_370A8C08BE55A7A5 = getnotetracktimes(turnanim, "code_move");

    if(_id_370A8C08BE55A7A5.size == 1)
      _id_2A7BE01B49B9FC52 = _id_370A8C08BE55A7A5[0] * 0.5;
  }

  _id_D4F2C844E88A2F32 = 1.0;
  _id_4B57DB1838537B36 = getnotetracktimes(turnanim, "finish");

  if(_id_4B57DB1838537B36.size == 0)
    _id_4B57DB1838537B36 = getnotetracktimes(turnanim, "end");

  if(_id_4B57DB1838537B36.size == 1)
    _id_D4F2C844E88A2F32 = _id_4B57DB1838537B36[0];

  _id_BD67F9D72B196F1B = getmovedelta(turnanim, 0.0, _id_2A7BE01B49B9FC52);
  _id_DF4A0D479AAC7D79 = getmovedelta(turnanim, 0.0, _id_D4F2C844E88A2F32);
  startpoint = self.origin;
  _id_4ABD55E07D3CCF70 = rotatevector(_id_BD67F9D72B196F1B, _id_F1A4D9D10FD4B365) + startpoint;
  endpoint = rotatevector(_id_DF4A0D479AAC7D79, _id_F1A4D9D10FD4B365) + startpoint;

  if(!_func_BE87C989A3B9C6CD(_id_4ABD55E07D3CCF70, endpoint, self))
    return 0;

  radius = self.radius;

  if(!_id_A9F9C2B0D5B4E555)
    radius = self.radius / 2;

  if(!scripts\mp\agents\scriptedagents::canmovepointtopoint(startpoint, _id_4ABD55E07D3CCF70, 0, radius))
    return 0;

  return 1;
}

_id_76B9651640D0A69F(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(self._id_4DA9D94CB820D6E6))
    return 1;

  return 0;
}

_id_7027BD948AD70157(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(_id_76B9651640D0A69F(asmname, statename, _id_F2B19B25D457C2A6, params))
    return 0;

  self._id_AED6A471459C1F66 = undefined;
  return 1;
}

_id_FB56678BA69CE494(asmname, statename, params) {
  self orientmode("face angle", self._id_AFB9589F35EBA0F2[1]);
  scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, 1, 0);
}

_id_A55A0851E6B74235(asmname, statename, params) {
  if(isDefined(self._id_AED6A471459C1F66))
    return self._id_AED6A471459C1F66;

  if(self.dismember_crawl) {
    _id_D50B05183432FC43();
    self._id_AED6A471459C1F66 = scripts\asm\asm::asm_lookupanimfromalias(statename, "boombox_dance_crawl_" + level._id_B99569E776E88CAC);
    return self._id_AED6A471459C1F66;
  } else if(istrue(self._id_8E4429F5285E0BB2)) {
    self._id_AED6A471459C1F66 = scripts\asm\asm::asm_lookupanimfromalias(statename, "disco_dance_center_" + randomintrange(0, 4));
    return self._id_AED6A471459C1F66;
  } else {
    _id_C290CDCA5B4D03B3();
    self._id_AED6A471459C1F66 = scripts\asm\asm::asm_lookupanimfromalias(statename, "boombox_dance_" + level._id_C43E2A394C660180);
    return self._id_AED6A471459C1F66;
  }
}

_id_C290CDCA5B4D03B3() {
  if(!isDefined(level._id_C43E2A394C660180))
    level._id_C43E2A394C660180 = 0;

  level._id_C43E2A394C660180++;

  if(level._id_C43E2A394C660180 > 5)
    level._id_C43E2A394C660180 = 0;
}

_id_D50B05183432FC43() {
  if(!isDefined(level._id_B99569E776E88CAC))
    level._id_B99569E776E88CAC = 0;

  level._id_B99569E776E88CAC++;

  if(level._id_B99569E776E88CAC > 1)
    level._id_B99569E776E88CAC = 0;
}

_id_C98AB9461B60D7AB(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}

_id_D548CAE522C5C709(asmname, statename, params) {
  if(istrue(self._id_9CA1FF845A52C335))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "upgraded");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "normal");
}

_id_33B72D0095CCE7C5(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}

_id_69B1A42B21866C4E(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self._id_D76A82870C350F14))
    return 0;

  if(!istrue(self._id_C61769CBBAEFB13E) || istrue(self.entered_playspace))
    return 0;

  if(!isDefined(level._id_0751304C16D7E7E1))
    return 0;

  if(!isDefined(self._id_6AE23C8CE441D0C5)) {
    self._id_6AE23C8CE441D0C5 = [[level._id_0751304C16D7E7E1]](self.origin);

    if(!isDefined(self._id_6AE23C8CE441D0C5)) {
      iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
      return 0;
    }
  } else if(!scripts\asm\asm_bb::bb_moverequested()) {
    self._id_6AE23C8CE441D0C5 = _id_0AE4767E658DC876::_id_5D11906B196A1764(self.origin, self._id_6AE23C8CE441D0C5);

    if(!isDefined(self._id_6AE23C8CE441D0C5)) {
      self.died_poorly = 1;
      self dodamage(self.health + 950, self.origin, self, self, "MOD_SUICIDE");
      return 0;
    }
  }

  self.goalradius = 4;
  self setgoalpos(self._id_6AE23C8CE441D0C5.origin);

  if(!scripts\asm\asm_bb::bb_moverequested())
    return 0;

  self._id_D76A82870C350F14 = self._id_6AE23C8CE441D0C5;
  self._id_6AE23C8CE441D0C5 = undefined;
  return 1;
}

_id_02498E8E0DC872B7(asmname, statename, params) {
  if(isDefined(self._id_A641B0B484180FC8))
    return self._id_A641B0B484180FC8;

  attack_spot = self.attack_spot;
  alias = undefined;

  if(!isDefined(attack_spot.script_label))
    alias = "mid";
  else
    alias = attack_spot.script_label;

  if(istrue(attack_spot._id_886A9D7510157DEC))
    alias = alias + "_extended";

  self._id_A641B0B484180FC8 = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return self._id_A641B0B484180FC8;
}

_id_A3D66605AC53859C(asmname, statename, params) {
  attack_spot = self.attack_spot;
  alias = "standing_";

  if(_id_1AAA2F84052E7F9E())
    alias = "crawling_";

  if(!isDefined(attack_spot.script_label))
    alias = alias + "mid";
  else
    alias = alias + attack_spot.script_label;

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_46B75EDA56662BBD(asmname, statename, params) {
  if(isDefined(self._id_17FA6262C0A79D41)) {
    state = _id_0AE4767E658DC876::_id_43A6309B8367993A(self._id_D76A82870C350F14, self._id_17FA6262C0A79D41 - 1);

    if(state == "destroying")
      _id_0AE4767E658DC876::_id_E71626C4B4F60736(self._id_D76A82870C350F14, self._id_17FA6262C0A79D41 - 1, "boarded");

    self._id_17FA6262C0A79D41 = undefined;
  }
}

_id_FE3BD473FFE9EF33(asmname, statename, params) {
  attack_spot = self.attack_spot;

  if(istrue(self.isfrozen)) {
    if(isDefined(self._id_17FA6262C0A79D41)) {
      _id_0AE4767E658DC876::_id_E71626C4B4F60736(self._id_D76A82870C350F14, self._id_17FA6262C0A79D41 - 1, "boarded");
      self._id_17FA6262C0A79D41 = undefined;
    }

    return self._id_F615574B76BD01AC;
  }

  if(self.dismember_crawl) {
    if(!isDefined(attack_spot.script_label)) {
      self._id_F615574B76BD01AC = scripts\asm\asm::asm_lookupanimfromalias(statename, "crawling");
      return self._id_F615574B76BD01AC;
    } else {
      _id_17FA6262C0A79D41 = _id_B9D37599A68DB8CA();
      alias = "crawling_" + attack_spot.script_label + "_" + _id_17FA6262C0A79D41;
      self._id_F615574B76BD01AC = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
      return self._id_F615574B76BD01AC;
    }
  } else if(!isDefined(attack_spot.script_label)) {
    self._id_F615574B76BD01AC = scripts\asm\asm::asm_lookupanimfromalias(statename, "standing");
    return self._id_F615574B76BD01AC;
  } else {
    while(isDefined(self._id_17FA6262C0A79D41))
      wait 0.05;

    _id_17FA6262C0A79D41 = _id_B9D37599A68DB8CA();
    alias = "standing_" + attack_spot.script_label + "_" + _id_17FA6262C0A79D41;
    self._id_F615574B76BD01AC = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
    return self._id_F615574B76BD01AC;
  }
}

_id_B9D37599A68DB8CA() {
  _id_17FA6262C0A79D41 = _id_0AE4767E658DC876::_id_11761A4A952726D6(self._id_D76A82870C350F14);
  self._id_17FA6262C0A79D41 = _id_17FA6262C0A79D41;
  _id_0AE4767E658DC876::_id_E71626C4B4F60736(self._id_D76A82870C350F14, self._id_17FA6262C0A79D41 - 1, "destroying");
  return _id_17FA6262C0A79D41;
}

_id_3E82482EE79C74E0(asmname, statename, params) {
  if(self.dismember_crawl)
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "crawling");
  else
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "standing");
}

_id_8EB1E4B3A17E8B54(_id_A234A65C378F3289, _id_E684FC6E068EE951, animindex, _id_EB5B1F36E255152D) {
  if(_id_A234A65C378F3289 == "board_break" || _id_A234A65C378F3289 == "hit") {
    if(!isDefined(self._id_17FA6262C0A79D41)) {
      return;
    }
    _id_C7C594511C61EC5F = self._id_17FA6262C0A79D41;
    self._id_17FA6262C0A79D41 = undefined;
    _id_0AE4767E658DC876::_id_E71626C4B4F60736(self._id_D76A82870C350F14, _id_C7C594511C61EC5F - 1, "destroyed");
    _id_0AE4767E658DC876::_id_85E0FB7FEB6205D9(self._id_D76A82870C350F14, _id_C7C594511C61EC5F);
  }
}

_id_3CB0B5C1C131B7AC(player, _id_AC3DC6CF8564E576) {
  _id_0A6E10300CDF705B = 2304;
  return distancesquared(player.origin, _id_AC3DC6CF8564E576.origin) < _id_0A6E10300CDF705B;
}

_id_C03DC6B92BB10DC1(_id_A234A65C378F3289, _id_E684FC6E068EE951, animindex, _id_EB5B1F36E255152D) {
  if(_id_A234A65C378F3289 == "hit") {
    _id_AC3DC6CF8564E576 = scripts\engine\utility::getclosest(self.origin, level.current_interaction_structs);

    if(_id_3CB0B5C1C131B7AC(self._id_2BD9344F09C76471, _id_AC3DC6CF8564E576))
      _id_63824E9BD0081BC7::_id_25F119243A1FF3BD(self._id_2BD9344F09C76471, 45, "MOD_IMPACT");
  }
}

_id_436E0491623C3857(asmname, statename, params) {
  self endon(statename + "_finished");
  self orientmode("face angle", self.attack_spot.angles[1]);
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

_id_B13E0034BB94ED8E(asmname, statename, params) {
  self endon(statename + "_finished");
  self orientmode("face angle", self.attack_spot.angles[1]);
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

_id_8316CE35FF4324D1(asmname, statename, params) {
  self endon(statename + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.attack_spot.angles[1]);
  self clearpath();
  self.do_immediate_ragdoll = 1;
  self._id_06263830DFE60A23 = 1;

  if(isDefined(self.attack_spot.script_parameters) && self.attack_spot.script_parameters == "script_adjust") {
    _id_D07C7C070A4A4E4F = anglesToForward(self.attack_spot.angles);
    _id_D07C7C070A4A4E4F = vectorNormalize(_id_D07C7C070A4A4E4F);
    _id_D07C7C070A4A4E4F = _id_D07C7C070A4A4E4F * -3.5;
    _id_D07C7C070A4A4E4F = (_id_D07C7C070A4A4E4F[0], _id_D07C7C070A4A4E4F[1], -1);
    self setOrigin(self.origin + _id_D07C7C070A4A4E4F, 0);
  }

  scripts\asm\asm_mp::_id_4895EAFF78A2FC42(asmname, statename, scripts\asm\asm_mp::asm_getanimindex(asmname, statename), self._id_D2D25942E3B908E9, "code_move");
  self.do_immediate_ragdoll = 0;
  self.full_gib = 0;
  self.nocorpse = undefined;
  self.entered_playspace = 1;
  self._id_C61769CBBAEFB13E = undefined;
  self._id_E4FB8F28C7074C55 = undefined;
  self._id_D76A82870C350F14 = undefined;
  self._id_17FA6262C0A79D41 = undefined;
  self._id_06263830DFE60A23 = undefined;
  self.goalradius = 4;
  self setgoalpos(self.origin);
  _id_0AE4767E658DC876::_id_5714453DD422F178(self.attack_spot);
  self.attack_spot = undefined;
}

_id_D2A76D94957230A9() {
  self endon("death");
  self.noturnanims = 1;
  self.entered_playspace = 1;
  self.full_gib = 1;
  self.nocorpse = 1;
  self._id_AD9276C342EDD6FC = "window";
  self waittill("goal_reached");
  self.full_gib = 0;
  self.nocorpse = undefined;
  self._id_AD9276C342EDD6FC = undefined;
  self.entered_playspace = 1;
  self._id_C61769CBBAEFB13E = undefined;
  self._id_E4FB8F28C7074C55 = undefined;
  self._id_D76A82870C350F14 = undefined;
  self._id_17FA6262C0A79D41 = undefined;
  _id_0AE4767E658DC876::_id_5714453DD422F178(self.attack_spot);
  self.attack_spot = undefined;
}

_id_4D574EF2630C531B(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.attack_spot.target))
    return 0;

  _id_5836C6D53A5F99A2 = getnodearray(self.attack_spot.target, "targetname");

  if(!isDefined(_id_5836C6D53A5F99A2) || _id_5836C6D53A5F99A2.size == 0)
    return 0;

  _id_3A58331DD886327F = _id_5836C6D53A5F99A2[0];

  if(!isDefined(_id_3A58331DD886327F) || !isDefined(_id_3A58331DD886327F.animscript))
    return 0;

  _id_5836C6D53A5F99A2 = getnodearray(_id_3A58331DD886327F.target, "targetname");

  if(!isDefined(_id_5836C6D53A5F99A2) || _id_5836C6D53A5F99A2.size == 0)
    return 0;

  _id_43B4368E16FD5DEA = _id_5836C6D53A5F99A2[0];
  self setgoalpos(_id_43B4368E16FD5DEA.origin);
  self._id_E4FB8F28C7074C55 = 0;
  thread _id_D2A76D94957230A9();
  return 1;
}

_id_EA9AA2CF2CF9448C() {
  self endon("death");
  self.noturnanims = 1;
  self.attack_spot = _id_0AE4767E658DC876::_id_313228003382F332(self._id_D76A82870C350F14);

  if(!_id_0AE4767E658DC876::_id_E244B2773B8A39CF(self.attack_spot))
    _id_0AE4767E658DC876::_id_16716D74E405BE15(self.attack_spot);
  else {
    self setgoalpos(self.origin);

    while(_id_3378DF0562BF23C3()) {
      attack_spot = _id_0AE4767E658DC876::_id_313228003382F332(self._id_D76A82870C350F14);

      if(isDefined(attack_spot) && !_id_0AE4767E658DC876::_id_E244B2773B8A39CF(attack_spot)) {
        self.attack_spot = attack_spot;
        _id_0AE4767E658DC876::_id_16716D74E405BE15(self.attack_spot);
        break;
      }

      self._id_0C03822216E31C53 = 1;
      wait 0.05;
    }

    self._id_0C03822216E31C53 = undefined;
  }

  _id_FC7F54CE37085AE2 = getclosestpointonnavmesh(self.attack_spot.origin, self);
  destination = (self.attack_spot.origin[0], self.attack_spot.origin[1], _id_FC7F54CE37085AE2[2]);
  self setgoalpos(destination);
  self waittill("goal");
  _id_A9706ADAF7C52E27 = (self.attack_spot.origin[0], self.attack_spot.origin[1], self.origin[2]);
  self setOrigin(_id_A9706ADAF7C52E27, 0);
  self.noturnanims = 0;
  _id_0AE4767E658DC876::_id_C3E941B6F08E09F2(self._id_D76A82870C350F14);
  self._id_E4FB8F28C7074C55 = 1;
}

_id_1C4EFF197FE143A9(asmname, statename, _id_F2B19B25D457C2A6, params) {
  self._id_E4FB8F28C7074C55 = 0;
  _id_0AE4767E658DC876::_id_2FE504FA79344506(self._id_D76A82870C350F14);
  self.goalradius = 4;
  self setgoalpos(self._id_D76A82870C350F14.origin);
  thread _id_EA9AA2CF2CF9448C();
  return 1;
}

_id_BCA235A9605EB211(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(self._id_E4FB8F28C7074C55))
    return 1;

  return 0;
}

_id_3378DF0562BF23C3(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_17FA6262C0A79D41 = _id_0AE4767E658DC876::_id_11761A4A952726D6(self._id_D76A82870C350F14);

  if(!isDefined(_id_17FA6262C0A79D41))
    return 0;

  return 1;
}

_id_35E021F60D68F619(asmname, statename, _id_F2B19B25D457C2A6, params) {
  scripts\asm\asm_bb::bb_clearmeleerequestcomplete();
  return 1;
}

_id_187B153A4135084B(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.asm.cur_move_mode))
    return 0;

  switch (self.asm.cur_move_mode) {
    case "slow_walk":
    case "walk":
      return 0;
  }

  return 1;
}

_id_C27EB774A931F60A(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(level._id_AA73D76F70A094F7))
    return 0;

  if(_id_1AAA2F84052E7F9E())
    return 0;

  _id_4F290BE6F76E6C96 = "mid";

  if(isDefined(self.attack_spot.script_label))
    _id_4F290BE6F76E6C96 = self.attack_spot.script_label;

  self._id_2BD9344F09C76471 = [[level._id_AA73D76F70A094F7]](self);

  if(!isDefined(self._id_2BD9344F09C76471))
    return 0;

  if(randomint(100) > 50)
    return 0;

  return 1;
}

_id_AA04822423E64FCC(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(level.bgameover))
    return 1;

  if(istrue(self._id_0C03822216E31C53))
    return 1;

  return 0;
}

_id_0B0676BA6E32CCF0(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !_id_AA04822423E64FCC(asmname, statename, _id_F2B19B25D457C2A6, params);
}

_id_81C789D82C8F87C2(asmname, statename, params) {
  aliasname = "standing";

  if(_id_1AAA2F84052E7F9E())
    aliasname = "crawling";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, aliasname);
}

_id_6308EEFEB6CD7A21(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return _id_63824E9BD0081BC7::_id_F8D4B082424E414F() && !istrue(self.stunned);
}

_id_BB579BD090BD12ED(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self.hasplayedvignetteanim) {
    if(scripts\asm\asm_bb::bb_moverequested())
      return 1;

    if(isDefined(self.spawner) && isDefined(self.spawner.script_animation) && self.spawner.script_animation == "spawn_wall_low")
      return 1;
  }

  return 0;
}
/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\script_funcs.gsc
************************************************/

soldier_init(asmname, statename, params) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  self.asm.gestures = spawnStruct();
  self.defaultturnthreshold = 59;
  self.anglelerprate = 100;

  if(!isDefined(self._id_98ADD129A7ECB962))
    self._id_98ADD129A7ECB962 = 1;

  if(isDefined(self.fnasm_initfingerposes))
    self thread[[self.fnasm_initfingerposes]]();

  self.fnhelmetpop = scripts\asm\soldier\death::helmetpop;
  initaimlimits(asmname);

  if(self._id_AE3EA15396B65C1F == "ai_animation_sequencer" || self._id_AE3EA15396B65C1F == "ai_animation_sequencer_combat_loop" || self._id_AE3EA15396B65C1F == "ai_animation_sequencer_additive_poses") {} else {
    initanimspeedthresholds_soldier(self.basearchetype);
    initanimspeedthresholds_soldier(self._id_AE3EA15396B65C1F);
  }

  if(self findoverridearchetype("default") == "rebel")
    self._id_0ED5FF3BCB60F394 = 1;

  if(self isscriptable())
    thread initscriptable();

  self _meth_62004D7561FD321E();
  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);

  if(_id_0DD6BF5F9DBA888C == "mg")
    self.combatmode = "cover_lmg";

  if(!isDefined(self findoverridearchetype("weapon")))
    _id_3433EE6B63C7E243::updateweaponarchetype(_id_0DD6BF5F9DBA888C);

  if(!isDefined(self._id_9087E842F157D27C))
    self._id_9087E842F157D27C = scripts\asm\soldier\melee::_id_6CDE2D3AE248271D;
}

initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

initaimlimits(asmname) {
  if(!isDefined(level.combataimlimits)) {
    level.combataimlimits = [];
    level.franticaimlimits = [];
    level.aimlimitstatemappings = [];
  }

  if(!isDefined(level.combataimlimits[asmname])) {
    combataimlimits = [];
    franticaimlimits = [];
    _id_4C3BAABE5686A741 = [];
    combataimlimits["exposed_idle"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    franticaimlimits["exposed_idle"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["down"] = 15;
    combataimlimits["cover_crouch_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["down"] = 15;
    franticaimlimits["cover_crouch_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    franticaimlimits["cover_crouch_aim"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["right"] = -15;
    combataimlimits["cover_left_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["right"] = -15;
    franticaimlimits["cover_left_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["right"] = -15;
    combataimlimits["cover_left_crouch_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["right"] = -15;
    franticaimlimits["cover_left_crouch_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["left"] = 15;
    combataimlimits["cover_right_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["down"] = 37;
    _id_4C3BAABE5686A741["left"] = 24;
    franticaimlimits["cover_right_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["left"] = 25;
    combataimlimits["cover_right_crouch_lean"] = _id_4C3BAABE5686A741;
    _id_4C3BAABE5686A741 = [];
    _id_4C3BAABE5686A741["left"] = 15;
    franticaimlimits["cover_right_crouch_lean"] = _id_4C3BAABE5686A741;
    level.combataimlimits[asmname] = combataimlimits;
    level.franticaimlimits[asmname] = franticaimlimits;
  }

  if(!isDefined(level.aimlimitstatemappings[asmname])) {
    _id_026893CE84A67261 = [];
    _id_026893CE84A67261["cover_stand_exposed"] = "cover_stand_exposed";
    _id_026893CE84A67261["cover_stand_hide_to_exposed"] = "cover_stand_exposed";
    _id_026893CE84A67261["cover_stand_full_exposed"] = "exposed_idle";
    _id_026893CE84A67261["cover_stand_hide_to_full_exposed"] = "exposed_idle";
    _id_026893CE84A67261["cover_stand_to_exposed_idle"] = "exposed_idle";
    _id_026893CE84A67261["wall_run_exit"] = "exposed_idle";
    _id_026893CE84A67261["wall_run_continue"] = "exposed_idle";
    _id_026893CE84A67261["wall_run_left_shoot"] = "exposed_idle";
    _id_026893CE84A67261["wall_run_right_shoot"] = "exposed_idle";
    _id_026893CE84A67261["wall_run_attach_left_shoot"] = "exposed_idle";
    _id_026893CE84A67261["wall_run_attach_right_shoot"] = "exposed_idle";
    _id_026893CE84A67261["cover_crouch_hide_to_stand"] = "exposed_idle";
    _id_026893CE84A67261["cover_crouch_hide_to_aim"] = "cover_crouch_aim";
    _id_026893CE84A67261["cover_crouch_hide_to_right"] = "cover_crouch_aim";
    _id_026893CE84A67261["cover_crouch_hide_to_left"] = "cover_crouch_aim";
    _id_026893CE84A67261["cover_crouch_hide_to_lean"] = "cover_crouch_lean";
    _id_026893CE84A67261["cover_crouch_aim"] = "cover_crouch_aim";
    _id_026893CE84A67261["cover_crouch_lean"] = "cover_crouch_lean";
    _id_026893CE84A67261["cover_crouch_exposed_left"] = "cover_crouch_aim";
    _id_026893CE84A67261["cover_crouch_exposed_right"] = "cover_crouch_aim";
    _id_026893CE84A67261["cover_crouch_stand"] = "exposed_idle";
    _id_026893CE84A67261["cover_crouch_to_exposed_idle"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_exposed_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_hide_to_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_exposed_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_hide_to_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_a_to_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_b_to_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_crouch_exposed_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_crouch_exposed_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_crouch_hide_to_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_crouch_hide_to_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_crouch_a_to_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_crouch_b_to_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_right_lean"] = "cover_right_lean";
    _id_026893CE84A67261["cover_right_hide_to_lean"] = "cover_right_lean";
    _id_026893CE84A67261["cover_right_crouch_hide_to_lean"] = "cover_right_crouch_lean";
    _id_026893CE84A67261["cover_right_crouch_lean"] = "cover_right_crouch_lean";
    _id_026893CE84A67261["cover_right_to_exposed_idle"] = "exposed_idle";
    _id_026893CE84A67261["cover_left_exposed_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_left_exposed_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_left_hide_to_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_left_hide_to_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_left_a_to_b"] = "exposed_idle";
    _id_026893CE84A67261["cover_left_b_to_a"] = "exposed_idle";
    _id_026893CE84A67261["cover_left_hide_to_lean"] = "cover_left_lean";
    _id_026893CE84A67261["cover_left_lean"] = "cover_left_lean";
    _id_026893CE84A67261["cover_left_crouch_hide_to_lean"] = "cover_left_crouch_lean";
    _id_026893CE84A67261["cover_left_crouch_lean"] = "cover_left_crouch_lean";
    _id_026893CE84A67261["cover_left_to_exposed_idle"] = "exposed_idle";
    _id_026893CE84A67261["cqb_idle"] = "exposed_idle";
    _id_026893CE84A67261["cqb_stand_loop"] = "exposed_idle";
    _id_026893CE84A67261["cqb_stand_strafe_loop"] = "exposed_idle";
    _id_026893CE84A67261["stand_run_strafe_loop"] = "exposed_idle";
    _id_026893CE84A67261["exposed_reload"] = "exposed_idle";
    _id_026893CE84A67261["exposed_weaponswitch"] = "exposed_idle";
    _id_026893CE84A67261["exposed_stand_turn"] = "exposed_idle";
    _id_026893CE84A67261["exposed_idle"] = "exposed_idle";
    _id_026893CE84A67261["exposed_prone"] = "exposed_idle";
    _id_026893CE84A67261["exposed_stand_infantry_reaction"] = "exposed_idle";
    level.aimlimitstatemappings[asmname] = _id_026893CE84A67261;
  }
}

initanimspeedthresholds_soldier(_id_AE3EA15396B65C1F) {
  if(istrue(anim._id_432836E99816347C[_id_AE3EA15396B65C1F])) {
    return;
  }
  if(animspeedthresholdsexist(_id_AE3EA15396B65C1F)) {
    return;
  }
  if(_id_AE3EA15396B65C1F == "boss" || _id_AE3EA15396B65C1F == "boss2")
    setspeedthreshold(_id_AE3EA15396B65C1F, "shuffle", 30);
  else
    setspeedthreshold(_id_AE3EA15396B65C1F, "shuffle", 23);

  if(_id_AE3EA15396B65C1F == "guard_01" || _id_AE3EA15396B65C1F == "guard_02")
    setspeedthreshold(_id_AE3EA15396B65C1F, "walk", 36);
  else
    setspeedthreshold(_id_AE3EA15396B65C1F, "walk", 65);

  setspeedthreshold(_id_AE3EA15396B65C1F, "fast", 104);
  setspeedthreshold(_id_AE3EA15396B65C1F, "jog", 178);
  setspeedthreshold(_id_AE3EA15396B65C1F, "run", 210);
  setspeedthreshold(_id_AE3EA15396B65C1F, "sprint", 250);
  anim._id_432836E99816347C[_id_AE3EA15396B65C1F] = 1;
}

needtoturn3d(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(self.matchexposednodeorientation) && isDefined(self.node))
    return 0;

  yaw = getturndesiredyaw3d();

  if(abs(yaw) > self.turnthreshold)
    return 1;

  pitch = getturndesiredpitch3d();

  if(abs(pitch) > self.pitchturnthreshold)
    return 1;

  return 0;
}

getturndesiredyaw() {
  if(isDefined(self.desiredturnyaw))
    return self.desiredturnyaw;

  _id_124CB35FA21F79AF = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos))
      shootpos = self._blackboard.shootparams_pos;
    else if(isDefined(self._blackboard.shootparams_ent))
      shootent = self._blackboard.shootparams_ent;
  } else if(isDefined(self.smartfacingpos))
    shootpos = self.smartfacingpos;

  if(!isDefined(shootpos) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36)
    return angleclamp180(self.node.angles[1] - self.angles[1]);

  if(isDefined(shootent) && !issentient(shootent))
    _id_124CB35FA21F79AF = 1.5;

  _id_2DB201E40E7AAF8C = scripts\engine\utility::getpredictedaimyawtoshootentorpos(_id_124CB35FA21F79AF, shootent, shootpos);
  return _id_2DB201E40E7AAF8C;
}

getturndesiredyaw3d() {
  _id_124CB35FA21F79AF = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent))
      shootent = self._blackboard.shootparams_ent;
    else if(isDefined(self._blackboard.shootparams_pos))
      shootpos = self._blackboard.shootparams_pos;
  } else if(isDefined(self.enemy))
    shootent = self.enemy;

  if(isDefined(shootent) && !issentient(shootent))
    _id_124CB35FA21F79AF = 1.5;

  _id_2DB201E40E7AAF8C = scripts\engine\utility::getpredictedaimyawtoshootentorpos3d(_id_124CB35FA21F79AF, shootent, shootpos);
  return _id_2DB201E40E7AAF8C;
}

getturndesiredpitch3d() {
  _id_124CB35FA21F79AF = 0.25;
  shootent = undefined;
  shootpos = undefined;

  if(self bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent))
      shootent = self._blackboard.shootparams_ent;
    else if(isDefined(self._blackboard.shootparams_pos))
      shootpos = self._blackboard.shootparams_pos;
  } else if(isDefined(self.enemy))
    shootent = self.enemy;

  if(isDefined(shootent) && !issentient(shootent))
    _id_124CB35FA21F79AF = 1.5;

  _id_98AFBD56092F6F05 = scripts\engine\utility::getpredictedaimpitchtoshootentorpos3d(_id_124CB35FA21F79AF, shootent, shootpos);
  return _id_98AFBD56092F6F05;
}

chooseturnanim3d(asmname, statename, params) {
  _id_2DB201E40E7AAF8C = getturndesiredyaw3d();
  _id_98AFBD56092F6F05 = getturndesiredpitch3d();

  if(abs(_id_2DB201E40E7AAF8C) > self.turnthreshold && abs(_id_2DB201E40E7AAF8C) > abs(_id_98AFBD56092F6F05)) {
    if(_id_2DB201E40E7AAF8C < 0)
      direction = "right";
    else
      direction = "left";

    _id_2DB201E40E7AAF8C = abs(_id_2DB201E40E7AAF8C);
    angle = 0;

    if(_id_2DB201E40E7AAF8C > 157.5)
      angle = 180;
    else if(_id_2DB201E40E7AAF8C > 112.5)
      angle = 135;
    else if(_id_2DB201E40E7AAF8C > 67.5)
      angle = 90;
    else
      angle = 45;

    animalias = direction + "_" + angle;
    turnanim = scripts\asm\asm::asm_lookupanimfromalias(statename, animalias);
    return turnanim;
  } else {
    if(_id_98AFBD56092F6F05 < 0)
      direction = "up";
    else
      direction = "down";

    _id_98AFBD56092F6F05 = abs(_id_98AFBD56092F6F05);
    angle = 0;

    if(_id_98AFBD56092F6F05 > 157.5)
      angle = 180;
    else if(_id_98AFBD56092F6F05 > 112.5)
      angle = 135;
    else if(_id_98AFBD56092F6F05 > 67.5)
      angle = 90;
    else
      angle = 45;

    animalias = direction + "_" + angle;
    turnanim = scripts\asm\asm::asm_lookupanimfromalias(statename, animalias);
    return turnanim;
  }
}

choosecrouchturnanim(asmname, statename, params) {
  _id_2DB201E40E7AAF8C = getturndesiredyaw();

  if(_id_2DB201E40E7AAF8C < -135)
    alias = "2r";
  else if(_id_2DB201E40E7AAF8C > 135)
    alias = "2l";
  else if(_id_2DB201E40E7AAF8C < 0)
    alias = "6";
  else
    alias = "4";

  turnanim = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return turnanim;
}

reload_cleanup(asmname, statename, params) {
  nullweapon = nullweapon();
  _id_DE88CD14114C1E24 = self._id_1E61BB39DEF2D99D;
  self._id_1E61BB39DEF2D99D = nullweapon;

  if(!isDefined(self.weaponinfo)) {
    return;
  }
  _id_78E527F9F68F891E = _id_DE88CD14114C1E24 != nullweapon && isDefined(self.weapon) && _id_DE88CD14114C1E24 == self.weapon;

  if(_id_DE88CD14114C1E24 == nullweapon)
    _id_DE88CD14114C1E24 = self.weapon;

  weaponname = getcompleteweaponname(_id_DE88CD14114C1E24);

  if(!isDefined(self.weaponinfo[weaponname])) {
    return;
  }
  if(!scripts\asm\asm::asm_eventfired(asmname, "drop clip")) {
    return;
  }
  if(self.weaponinfo[weaponname].useclip) {
    clipmodel = getweaponclipmodel(_id_DE88CD14114C1E24);

    if(isDefined(clipmodel)) {
      _id_5A578A2482E72059 = scripts\asm\asm::asm_eventfired(asmname, "attach clip left") || scripts\asm\asm::asm_eventfired(asmname, "attach clip right");
      _id_7CB5A062F767FB6F = scripts\asm\asm::asm_eventfired(asmname, "detach clip left") || scripts\asm\asm::asm_eventfired(asmname, "detach clip right") || scripts\asm\asm::asm_eventfired(asmname, "detach clip nohand");

      if(!_id_5A578A2482E72059)
        self notify("abort_reload");
      else if(_id_5A578A2482E72059 && !_id_7CB5A062F767FB6F) {
        if(scripts\asm\asm::asm_eventfired(asmname, "attach clip left"))
          tagname = "tag_accessory_left";
        else
          tagname = "tag_accessory_right";

        self detach(clipmodel, tagname);
        self notify("clip_detached");

        if(_id_78E527F9F68F891E)
          _id_3433EE6B63C7E243::showweaponmagattachment(weaponname);
      }
    }
  }
}

terminateexposedprone(asmname, statename, params) {
  self.pushable = 1;
}

terminateexposedidleaimdown(asmname, statename, params) {
  self.aimingdown = 0;
}

terminateexposedcrouchaimdown(asmname, statename, params) {
  self.aimingdown = 0;
}

shouldfaceenemyinexposed() {
  if(isDefined(self.pathgoalpos))
    return 0;

  return isDefined(self.enemy) && isPlayer(self.enemy) && self cansee(self.enemy);
}

playanim_weaponswitch(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_0DD6BF5F9DBA888C = scripts\asm\asm_bb::bb_getrequestedweapon();
  animname = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_07B60BC0EAB3FD1E = _id_13D1C402F1421C35::fasteranimspeed();
  self aisetanim(statename, animname, _id_07B60BC0EAB3FD1E);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, scripts\asm\asm::asm_getxanim(statename, animname));
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  self notify("switched_to_sidearm");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

terminate_weaponswitch(asmname, statename, params) {
  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);
  _id_3433EE6B63C7E243::updateweaponarchetype(_id_0DD6BF5F9DBA888C);
}

playturnanim_turnanimanglefixup(_id_19B744B1CDEE4BCB, statename) {
  self endon("death");
  self endon(statename + "_finished");
  enemy = self.enemy;
  enemy endon("death");
  animlength = getanimlength(_id_19B744B1CDEE4BCB);

  if(animhasnotetrack(_id_19B744B1CDEE4BCB, "start_aim")) {
    _id_6AA303AAB36EA0EA = getnotetracktimes(_id_19B744B1CDEE4BCB, "start_aim");
    animlength = animlength * _id_6AA303AAB36EA0EA[0];
  } else if(animhasnotetrack(_id_19B744B1CDEE4BCB, "finish")) {
    _id_6AA303AAB36EA0EA = getnotetracktimes(_id_19B744B1CDEE4BCB, "finish");
    animlength = animlength * _id_6AA303AAB36EA0EA[0];
  }

  _id_7E3211AE44B15B55 = int(animlength * 20);
  _id_0C3DDCD0C37A60C5 = _id_7E3211AE44B15B55;

  while(_id_0C3DDCD0C37A60C5 > 0) {
    _id_6BDB8335862F56EE = 1 / _id_0C3DDCD0C37A60C5;
    _id_A0F270EA6DC74BF3 = scripts\engine\utility::getyawtospot(enemy.origin);
    self.stepoutyaw = angleclamp180(self.angles[1] + _id_A0F270EA6DC74BF3);
    _id_03572E193DBCA166 = self aigetanimtime(_id_19B744B1CDEE4BCB);
    _id_993A8F9635E274CF = getangledelta(_id_19B744B1CDEE4BCB, _id_03572E193DBCA166, 1.0);
    _id_B1CBDF386B2C0DEA = angleclamp180(_id_A0F270EA6DC74BF3 - _id_993A8F9635E274CF);
    self orientmode("face angle", angleclamp(self.angles[1] + _id_B1CBDF386B2C0DEA * _id_6BDB8335862F56EE));
    _id_0C3DDCD0C37A60C5--;
    wait 0.05;
  }
}

shouldsnaptocover_checktype(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm_bb::bb_moverequested())
    return 0;

  if(!scripts\asm\shared\utility::isatcovernode())
    return 0;

  if(!isDefined(self.node))
    return 0;

  if(isDefined(self.primaryweapon) && _id_2B79931B08683E0A::isusingsidearm() && weaponclass(self.primaryweapon) != "mg")
    return 0;

  return scripts\asm\shared\utility::isarrivaltype(asmname, statename, _id_F2B19B25D457C2A6, params);
}

reloadnotehandler(_id_A234A65C378F3289) {
  _id_357B9A54DFEDBD4A::notetrack_prefix_handler(_id_A234A65C378F3289);
  return undefined;
}

shoot_setshootparameters() {
  _id_89F949A75D92E1A4 = self._blackboard.shootparams_shotsperburst;
  shootstyle = 2;

  if(self._blackboard.shootparams_style == "single" || _id_89F949A75D92E1A4 == 1 && self._blackboard.shootparams_style != "rack") {
    _id_89F949A75D92E1A4 = 1;
    shootstyle = 2;
  } else if(self._blackboard.shootparams_style == "semi") {
    shootstyle = 3;

    if(_id_89F949A75D92E1A4 == 1)
      shootstyle = 2;
    else if(_id_89F949A75D92E1A4 > 5)
      _id_89F949A75D92E1A4 = 5;
  } else if(self._blackboard.shootparams_style == "mg") {
    shootstyle = 2;
    _id_89F949A75D92E1A4 = 1;
  } else if(self._blackboard.shootparams_style == "rack" && self.currentpose != "prone")
    shootstyle = 5;
  else {
    shootstyle = 4;

    if(_id_89F949A75D92E1A4 > 6)
      _id_89F949A75D92E1A4 = 6;
  }

  self setupshootstyleadditive(shootstyle, _id_89F949A75D92E1A4);
}

shoot_clearshootparameters() {
  self setupshootstyleadditive(0, 0);
}

shoot_playidleanimloop_sniper(asmname, statename, params) {
  thread scripts\asm\shoot\script_funcs::handleburstdelay(asmname, statename);

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }
  scripts\asm\asm::asm_playadditiveanimloopstate(asmname, statename, params);
}

_id_6DDC94E521201A49(asmname, statename, params) {
  self._blackboard._id_074F8F2B8EFF7C7F = 0;
}

_id_9D9A4C83D3A8B338(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self._id_DC73F89FDCFFB56F))
    return 1;

  if(gettime() < self._id_DC73F89FDCFFB56F)
    return 0;

  return 1;
}

facegoalthread_newenemyreaction(statename, _id_1402D870C92DF1AF) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(statename + "_finished");

  for(;;) {
    _id_98EA5AFB293A76A2 = 0.25;
    _id_FD4E44B47427D5C6 = angleclamp180(_id_1402D870C92DF1AF - self.angles[1]);
    self orientmode("face angle", self.angles[1] + _id_FD4E44B47427D5C6 * _id_98EA5AFB293A76A2);
    waitframe();
  }
}

handlefacegoalnotetrack_newenemyreaction(statename, _id_A234A65C378F3289, _id_4FC502B1A10006CC) {
  if(_id_A234A65C378F3289 == "face_goal") {
    _id_63CC85541246C7B4 = _id_4FC502B1A10006CC - self.origin;
    _id_1402D870C92DF1AF = vectortoyaw(_id_63CC85541246C7B4);
    thread facegoalthread_newenemyreaction(statename, _id_1402D870C92DF1AF);
    return 1;
  }

  return 0;
}

playanim_newenemyreaction(asmname, statename, params) {
  self endon(statename + "_finished");
  pushdisabledgunpose();
  _id_93A2C35BC9547955 = self asmgetanim(asmname, statename);
  _id_9319232E93B989ED = scripts\asm\asm::asm_getxanim(statename, _id_93A2C35BC9547955);
  self aisetanim(statename, _id_93A2C35BC9547955);
  _id_4FC502B1A10006CC = self lastknownpos(self.enemy);
  thread playturnanim_turnanimanglefixup(_id_9319232E93B989ED, statename);
  scripts\asm\asm::asm_donotetrackswithinterceptor(asmname, statename, ::handlefacegoalnotetrack_newenemyreaction, _id_4FC502B1A10006CC);

  if(isDefined(self.enemy) && self cansee(self.enemy))
    self.remainexposedendtime = gettime() + 2000;
}

chooseanim_playerpushed(asmname, statename, params) {
  _id_F449E4F8397F13E7 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");
  _id_D5BE0521E83DF112 = vectorNormalize(_id_F449E4F8397F13E7);
  targetangles = vectortoangles(_id_D5BE0521E83DF112);
  _id_623F3095ECFA11FF = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = scripts\asm\asm::yawdiffto2468(_id_623F3095ECFA11FF);
  aliasname = "pushed_" + angleindex;
  turnanim = scripts\asm\asm::asm_lookupanimfromalias(statename, aliasname);
  return turnanim;
}

terminate_casualkiller(asmname, statename, params) {
  self setbasearchetype(self findoverridearchetype("default"));
  self clearoverridearchetype("demeanor", 0, 1);
  self.newenemyreaction = 0;
  self.forcenewenemyreaction = 0;
  self notify("leaveCasualKiller");
  self.leavecasualkiller = 0;
  self.casualkiller = 0;
  self setdefaultaimlimits();
}

pushdisabledgunpose() {
  if(isDefined(self.gunposeoverride))
    self.stashedgunposeoverride = self.gunposeoverride;

  self.gunposeoverride = "disable";
}

popdisabledgunpose() {
  if(isDefined(self.stashedgunposeoverride)) {
    self.gunposeoverride = self.stashedgunposeoverride;
    self.stashedgunposeoverride = undefined;
  } else
    self.gunposeoverride = undefined;
}

_id_E9CDFB92CC489ACB(asmname, statename, params) {
  self _meth_F662E31DF8183BF8(self.origin, self.angles);
  scripts\asm\shared\utility::loopanim(asmname, statename, params);
}

_id_33294352D1956570(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(istrue(self._id_9DC04EF5E55F3574)) {
    self _meth_1C339DAABA3F71DB(1);
    scripts\common\utility::lookatentity(self._id_C7CD5E7E287A7DF8);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, self._id_97BA98A2ACA4A96D);
}

_id_78FCDBC229EC648C(asmname, statename, _id_F2B19B25D457C2A6, params) {
  self _meth_1C339DAABA3F71DB(0);
  self._id_BE159BE38E485344 = 0;
  self._id_1F391695BCA4A279 = 1;
}
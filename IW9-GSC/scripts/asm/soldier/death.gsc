/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\death.gsc
***********************************************/

deathlmgcleanup() {
  if(!isDefined(self._blackboard.leftweaponent)) {
    return;
  }
  _id_7BC1C35C0AB292C2 = self._blackboard.leftweaponent;
  _id_7BC1C35C0AB292C2 delete();
  self._blackboard.leftweaponent = undefined;
  _id_3433EE6B63C7E243::forceuseweapon(self.primaryweapon, "primary");
}

_id_EA379D7359BD10AE(asmname, statename, params) {
  _id_4D3CEBAD4E3E8617 = isDefined(self.deathalias) && isDefined(self.deathstate);

  if(isDefined(self.deathanim)) {
    deathanim = self.deathanim;
    _id_60CE35EF4EA0CCAA = scripts\asm\asm::asm_getxanim(statename, deathanim);
  } else if(_id_4D3CEBAD4E3E8617) {
    deathanim = scripts\asm\asm::asm_lookupanimfromalias(self.deathstate, self.deathalias);
    _id_60CE35EF4EA0CCAA = scripts\asm\asm::asm_getxanim(self.deathstate, deathanim);
  } else {
    deathanim = scripts\asm\asm::asm_getanim(asmname, statename, params);
    _id_60CE35EF4EA0CCAA = scripts\asm\asm::asm_getxanim(statename, deathanim);
  }

  return [deathanim, _id_60CE35EF4EA0CCAA];
}

playdeathanim(asmname, statename, params) {
  stop_sounds();
  self stoplookat();

  if(isDefined(self.fnlaseroff))
    self[[self.fnlaseroff]]();

  if(isDefined(self.fnasm_clearfingerposes))
    self[[self.fnasm_clearfingerposes]]();

  if(isDefined(self.fnachievements))
    self thread[[self.fnachievements]]();

  removeselffrom_squadlastseenenemypos(self.origin);

  if(isDefined(self.scriptedarrivalent))
    self.scriptedarrivalent delete();

  _func_9912FB866ADA47D7(_func_5A05C362AF7E301B() - 1);
  _func_E004A29F97015C17(_func_D3D3F12A9FD105EB() - 1);
  deathlmgcleanup();
  self.disabledeathorient = !(self.a.nodeath || istrue(self.noragdoll));

  if(self.a.nodeath) {
    deathcleanup();
    return;
  }

  _id_AB1C9A379F19D469 = scripts\common\utility::wasdamagedbyexplosive();

  if(shouldhelmetpopondeath(_id_AB1C9A379F19D469))
    helmetpop();

  if(shouldheadpop(_id_AB1C9A379F19D469))
    headpop();

  if(!isDefined(self.skipdeathanim))
    self aiclearanim(scripts\asm\asm::asm_getroot(), 0.3);

  playdeathsound(_id_AB1C9A379F19D469);

  if(isDefined(self.asm.deathfunc)) {
    self[[self.asm.deathfunc]]();

    if(!isDefined(self.deathfunction)) {
      deathcleanup();
      return;
    }
  }

  if(isDefined(self.deathfunction)) {
    result = self[[self.deathfunction]]();

    if(!isDefined(result))
      result = 1;

    if(result) {
      deathcleanup();
      return;
    }
  }

  if(isDefined(self.ragdoll_immediate) || self.forceragdollimmediate) {
    if(isagent(self)) {
      if(istrue(self.bhasriotshieldattached))
        detachriotshield();

      _id_3433EE6B63C7E243::dropallaiweapons();
      return;
    }

    if(isDefined(self.doantigravgrenaderagdoll) && self.doantigravgrenaderagdoll)
      self animmode("noclip");
    else if(istrue(self.nogravityragdoll))
      self animmode("nogravity");
    else
      self animmode("gravity");

    doimmediateragdolldeath();

    if(!isDefined(self))
      return;
  }

  self endon("entitydeleted");

  if(shouldgib() && !self isragdoll()) {
    if(istrue(self.bhasriotshieldattached))
      detachriotshield();

    _id_3433EE6B63C7E243::dropallaiweapons();
    dogib();

    if(isagent(self))
      self.nocorpse = 1;
    else {
      self hide();

      if(!isagent(self))
        wait 0.1;
    }

    if(isDefined(self)) {
      deathcleanup();

      if(!isagent(self))
        self delete();
    }

    return;
  }

  if(isDefined(self.deathbysuffocation) && !isDefined(self.deathanim))
    scripts\common\ai::set_deathanim(getsuffocationdeathanim());

  deathanim = undefined;
  _id_60CE35EF4EA0CCAA = undefined;
  _id_4D3CEBAD4E3E8617 = isDefined(self.deathalias) && isDefined(self.deathstate);

  if(!isDefined(self.skipdeathanim) || istrue(self._id_0AA0214E1292A7B3)) {
    _id_41154210564D7C9C = _id_EA379D7359BD10AE(asmname, statename, params);
    deathanim = _id_41154210564D7C9C[0];
    _id_60CE35EF4EA0CCAA = _id_41154210564D7C9C[1];

    if(!animhasnotetrack(_id_60CE35EF4EA0CCAA, "dropgun") && !animhasnotetrack(_id_60CE35EF4EA0CCAA, "fire_spray"))
      _id_3433EE6B63C7E243::dropallaiweapons();

    if(animhasnotetrack(_id_60CE35EF4EA0CCAA, "dropgun"))
      self._blackboard.awaitingdropgunnotetrack = 1;

    if(istrue(self.bhasriotshieldattached))
      detachriotshield();

    if(isDefined(self._id_1BAB8712529EB3C2) && self._id_1BAB8712529EB3C2)
      scripts\asm\soldier\patrol::detachflashlight();

    handleburningtodeath(_id_60CE35EF4EA0CCAA);
    self.deathanimduration = int(getanimlength(_id_60CE35EF4EA0CCAA) * 1000);
    _id_AB71B1887FD003ED = isDefined(params) && params == "directional_orient";

    if(istrue(self.disabledeathdirectionalorient))
      _id_AB71B1887FD003ED = 0;

    orientmeleevictim(_id_AB71B1887FD003ED);

    if(isnumber(deathanim)) {
      if(_id_4D3CEBAD4E3E8617)
        self aisetanim(self.deathstate, deathanim);
      else
        self aisetanim(statename, deathanim);
    } else {
      _id_D5C987658103BFFD = scripts\asm\asm::asm_getinnerrootknob();
      self clearanim(_id_D5C987658103BFFD, 0.05);
      self setflaggedanimknoballrestart(statename, deathanim, _id_D5C987658103BFFD, 1, 0.05);
    }

    if(_id_4D3CEBAD4E3E8617)
      scripts\asm\asm::asm_playfacialanim(asmname, self.deathstate, _id_60CE35EF4EA0CCAA);
    else
      scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_60CE35EF4EA0CCAA);
  }

  if(isDefined(self.deathanimmode))
    self animmode(self.deathanimmode);

  if(isDefined(self.skipdeathanim)) {
    if(!isDefined(self.noragdoll)) {
      if(isDefined(self.fnpreragdoll))
        self[[self.fnpreragdoll]]();

      if(!isDefined(self)) {
        return;
      }
      if(istrue(self.bhasriotshieldattached))
        detachriotshield();

      _id_3433EE6B63C7E243::dropallaiweapons();
      self startragdoll();
    }

    if(!isagent(self)) {
      wait 0.05;

      if(!isDefined(self)) {
        return;
      }
      self animmode("gravity");
    }
  } else if(isDefined(self.ragdolltime))
    thread waitforragdoll(self.ragdolltime);
  else if(getdvarint("dvar_8C30A87F78A7D97E") == 1)
    thread startragdollwithoutwait();
  else {
    _id_41154210564D7C9C = _id_EA379D7359BD10AE(asmname, statename, params);
    deathanim = _id_41154210564D7C9C[0];
    _id_60CE35EF4EA0CCAA = _id_41154210564D7C9C[1];
    _id_689EF6000ED3E5FC = getnotetracktimes(_id_60CE35EF4EA0CCAA, "start_ragdoll");
    _id_73AFA09BAE81352A = !_id_4D3CEBAD4E3E8617 && !isDefined(self.deathanim) && (_id_689EF6000ED3E5FC.size == 0 || _id_689EF6000ED3E5FC[0] > 0.5);

    if(_id_73AFA09BAE81352A) {
      if(self.damagemod == "MOD_MELEE")
        _id_22356424BD0219B4 = 0.7;
      else
        _id_22356424BD0219B4 = 0.35;

      thread waitforragdoll(getanimlength(_id_60CE35EF4EA0CCAA) * _id_22356424BD0219B4);
    }
  }

  if(!isagent(self) && !isDefined(self.skipdeathanim))
    thread playdeathfx();

  self endon("terminate_death_thread");

  if(!isagent(self)) {
    if(isDefined(self.skipdeathanim) && !istrue(self._id_0AA0214E1292A7B3))
      wait 0.05;
    else {
      _id_0ED309E19B5083D1 = statename;

      if(_id_4D3CEBAD4E3E8617)
        _id_0ED309E19B5083D1 = self.deathstate;

      scripts\asm\asm::asm_donotetracks(asmname, _id_0ED309E19B5083D1, ::deathnotetrackhandler);
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.bhasriotshieldattached))
    detachriotshield();

  _id_3433EE6B63C7E243::dropallaiweapons();
  self notify("endPlayDeathAnim");

  if(!isagent(self)) {
    if(isDefined(self.ragdoll_immediate) || self.forceragdollimmediate) {
      wait 0.5;

      if(!isDefined(self)) {
        return;
      }
      self aisetanimrate(scripts\asm\asm::asm_getroot(), 0);
    }
  }

  deathcleanup();
}

deathnotetrackhandler(_id_A234A65C378F3289) {
  if(self.burningtodeath) {
    switch (_id_A234A65C378F3289) {
      case "model_swap":
        handleburndeathmodelswap();
        return;
      case "burn_vfx_death_start":
        thread handleburndeathvfx();
        return;
    }
  }

  _id_357B9A54DFEDBD4A::notetrack_prefix_handler(_id_A234A65C378F3289);
}

handleburningtodeath(_id_60CE35EF4EA0CCAA) {
  if(isscriptedagent(self) && !isnullweapon(self.damageweapon) && self.unittype != "juggernaut" && scripts\common\utility::shouldburnfromdamage(self.damageweapon)) {
    self.burningtodeath = 1;
    thread handleburndeathvfx();
    return;
  }

  if(isscriptedagent(self) && self.unittype == "juggernaut") {
    return;
  }
  if(!self.burningtodeath) {
    return;
  }
  if(isscriptedagent(self)) {
    return;
  }
  if(self.unittype != "dog" && (!isDefined(_id_60CE35EF4EA0CCAA) || !animhasnotetrack(_id_60CE35EF4EA0CCAA, "model_swap"))) {
    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
      self.headmodel = undefined;
    }

    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = undefined;
    }

    self setModel("burntbody_male");

    if(!isDefined(_id_60CE35EF4EA0CCAA) || !animhasnotetrack(_id_60CE35EF4EA0CCAA, "burn_vfx_death_start"))
      thread handleburndeathvfx();
  }
}

handleburndeathmodelswap() {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
    self.headmodel = undefined;
  }

  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
    self.hatmodel = undefined;
  }

  self setModel("burntbody_male");
}

handleburndeathvfx() {
  self endon("stop_burn_VFX");
  self endon("entitydeleted");
  _id_32561454D6DFF5F7 = 1;

  if(self isscriptable()) {
    currentstate = self getscriptablepartstate("burn_to_death_by_molotov", 1);

    if(isDefined(currentstate)) {
      self setscriptablepartstate("burn_to_death_by_molotov", "active");
      _id_32561454D6DFF5F7 = 0;
    }
  }

  if(_id_32561454D6DFF5F7) {
    _id_379506D5F8EBE669 = getburnvfxtagpackets();

    foreach(_id_BD804C4D30DBC230 in _id_379506D5F8EBE669) {
      if(!isDefined(self)) {
        return;
      }
      playFXOnTag(level.g_effect[_id_BD804C4D30DBC230.burnvfx], self, _id_BD804C4D30DBC230.tag);
      wait 0.05;
    }
  }
}

getburnvfxtagpackets() {
  _id_BD804C4D30DBC230 = [];
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_knee_ri", "vfx_burn_sml_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_knee_le", "vfx_burn_sml_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_hip_proc_ri", "vfx_burn_med_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_hip_proc_le", "vfx_burn_med_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_spinelower", "vfx_burn_med_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_spine4", "vfx_burn_lrg_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_elbow_ri", "vfx_burn_sml_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_elbow_le", "vfx_burn_sml_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_shoulder_ri", "vfx_burn_med_high");
  _id_BD804C4D30DBC230[_id_BD804C4D30DBC230.size] = createburnvfxpacket("j_shoulder_le", "vfx_burn_med_high");
  return _id_BD804C4D30DBC230;
}

createburnvfxpacket(tag, burnvfx, _id_E941D82A2EE0D75F) {
  _id_AD98E6D70679846D = spawnStruct();
  _id_AD98E6D70679846D.tag = tag;
  _id_AD98E6D70679846D.burnvfx = burnvfx;
  return _id_AD98E6D70679846D;
}

detachriotshield() {
  if(_id_0B6AC2CA2CE25F58())
    _id_324DA04684F354C3();

  if(scripts\common\utility::issp())
    self detach(self.riotshieldmodel, self.riotshieldmodeltag);
  else
    self detachshieldmodel(self.riotshieldmodel, self.riotshieldmodeltag);

  self.bhasriotshieldattached = undefined;
}

_id_0B6AC2CA2CE25F58() {
  if(istrue(self._id_0B6AC2CA2CE25F58))
    return 1;

  return 0;
}

_id_324DA04684F354C3() {
  _id_9CCC24389A9EDDEE = self gettagorigin(self.riotshieldmodeltag);
  _id_3E3F178F45C14044 = self gettagangles(self.riotshieldmodeltag);
  shield = spawn("script_model", _id_9CCC24389A9EDDEE);
  shield.angles = _id_3E3F178F45C14044;
  shield setModel(self.riotshieldmodel);
  shield physicslaunchserver(_id_9CCC24389A9EDDEE, anglesToForward(self.angles) * 5);
  shield thread _id_99A6B622F75D372D(10);
}

_id_99A6B622F75D372D(time) {
  self endon("death");
  wait(time);
  self delete();
}

c8deathsound(_id_CE177B78F5688D8A, notetrack) {
  _id_DEC9BCCE93873125 = getsubstr(notetrack, 0, 3);

  if(_id_DEC9BCCE93873125 == "vo_") {
    alias = getsubstr(notetrack, 3);
    _id_CE177B78F5688D8A playsoundatviewheight(alias);
    return;
  }

  if(_id_DEC9BCCE93873125 != "ps_") {
    return;
  }
  alias = getsubstr(notetrack, 3);

  if(!isDefined(_id_CE177B78F5688D8A.deathsoundent)) {
    _id_CE177B78F5688D8A.deathsoundent = spawn("script_origin", _id_CE177B78F5688D8A.origin);
    _id_CE177B78F5688D8A.deathsoundent linkTo(_id_CE177B78F5688D8A, "");
  }

  ent = _id_CE177B78F5688D8A.deathsoundent;
  ent notify("stop_C8DeathSound");
  ent endon("stop_C8DeathSound");
  ent playSound(alias);
  time = lookupsoundlength(alias);
  wait(time * 0.001 + 0.1);
  ent delete();
}

playexplosivedeathanim(asmname, statename, params) {
  if((scripts\common\utility::isdamageweapon(makeweapon("iw7_knife_upgrade1")) || scripts\common\utility::wasdamagedbyoffhandshield() || scripts\common\utility::isdamageweapon(makeweapon("iw7_sonic"))) && isDefined(self.attacker)) {
    _id_85E28F54B572F39F = vectortoyaw(self.attacker.origin - self.origin);

    if(self.damageyaw > 135 || self.damageyaw <= -135)
      self orientmode("face angle", _id_85E28F54B572F39F);
    else if(self.damageyaw > 45 && self.damageyaw <= 135)
      self orientmode("face angle", _id_85E28F54B572F39F + 90);
    else if(self.damageyaw > -45 && self.damageyaw <= 45)
      self orientmode("face angle", _id_85E28F54B572F39F - 180);
    else
      self orientmode("face angle", _id_85E28F54B572F39F - 90);
  }

  playdeathanim(asmname, statename, params);
}

playbalconydeathanim(asmname, statename, params) {
  _func_2AFCE3C4640B03C9(gettime() + randomintrange(25000, 35000));
  self orientmode("face angle", self._blackboard.balconydeathnode.angles[1]);
  playdeathanim(asmname, statename, params);
}

playdeathanim_melee_ragdolldelayed(asmname, statename, params) {
  _id_2E6C636F8E86EFF0 = isagent(self);

  if(!_id_2E6C636F8E86EFF0) {
    if(isDefined(self.meleestatename)) {
      time = params;

      if(!isDefined(time))
        time = 10;

      scripts\asm\asm::asm_donotetrackswithtimeout(asmname, self.meleestatename, time);
    }
  }

  _id_3433EE6B63C7E243::dropallaiweapons();

  if(istrue(self.bhasriotshieldattached))
    detachriotshield();

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(!isDefined(self)) {
    return;
  }
  if(!_id_2E6C636F8E86EFF0) {
    self startragdoll();
    wait 0.1;
  }

  deathcleanup();
}

deathcleanup() {
  if(istrue(self.skipdeathcleanup)) {
    return;
  }
  if(isDefined(self)) {
    if(self.unittype == "c6") {} else if(self.unittype == "c8")
      c8_scriptablecleanup();
  }

  scripts\asm\asm_bb::bb_clearmeleetarget();
  self notify("terminate_ai_threads");

  if(isagent(self)) {
    return;
  }
  _id_85CB4E4A8B191A0D = 3;

  while(isDefined(self) && self.script != "death" && _id_85CB4E4A8B191A0D > 0) {
    _id_85CB4E4A8B191A0D--;
    wait 0.05;
  }

  self notify("killanimscript");
}

chooseshockdeathanim(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, "standing");
}

shouldplayshockdeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\shared\utility::isshocked() || isDefined(self.shockdeath);
}

shouldplayexplosivedeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self.unittype == "juggernaut")
    return 0;

  if(istrue(self.forceexplosivedeath)) {
    self.forceexplosivedeath = 0;
    return 1;
  }

  if(scripts\common\utility::wasdamagedbyexplosive())
    return 1;

  return 0;
}

shouldplayplayermeleedeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.damagemod) && isalive(self.attacker)) {
    if(!isPlayer(self.attacker))
      return 0;

    if(scripts\common\utility::getdamagetype(self.damagemod) != "melee")
      return 0;

    return 1;
  }

  return 0;
}

shouldplaybalconydeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self.currentpose == "prone")
    return 0;

  if(!self.burningtodeath && scripts\common\utility::wasdamagedbyexplosive())
    return 0;

  if(gettime() < _func_75391F72C52786A5() && !istrue(self.forcebalconydeath))
    return 0;

  node = undefined;

  if(isDefined(self.covernode))
    node = self.covernode;
  else if(isDefined(self._blackboard.lastusednode))
    node = self._blackboard.lastusednode;

  if(!isDefined(node) || !isDefined(node.script_balcony))
    return 0;

  if(abs(angleclamp180(node.angles[1] - self.angles[1])) > 30)
    return 0;

  if(isDefined(self.script_chance)) {
    if(randomfloat(1) > self.script_chance)
      return 0;
  }

  if(self nearnode(node)) {
    self._blackboard.balconydeathnode = node;
    return 1;
  }

  return 0;
}

shouldplaybalconyraildeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._blackboard.balconydeathnode.script_balcony == 1;
}

choosebalconydeathanim(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, self.currentpose);
}

shouldplaystrongdamagedeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  objweapon = self.damageweapon;

  if(!isDefined(objweapon) || isnullweapon(objweapon))
    return 0;

  if(scripts\engine\utility::doinglongdeath())
    return 0;

  if(self.currentpose == "prone" || isDefined(self.a.onback))
    return 0;

  if(self.damagemod == "MOD_MELEE")
    return 0;

  if(abs(self.damageyaw) < 45)
    return 0;

  if(self.damagetaken > 500)
    return 1;

  if(self.a.movement == "run" && !isattackerwithindist(self.attacker, 275)) {
    if(randomint(100) < 65)
      return 0;
  }

  if(_id_2B79931B08683E0A::issniperrifle(objweapon) && self.maxhealth < self.damagetaken)
    return 1;

  if(_id_2B79931B08683E0A::isshotgun(objweapon) && isattackerwithindist(self.attacker, 512))
    return 1;

  if(objweapon.basename == "iw7_devastator" && scripts\common\utility::isweaponepic(objweapon))
    return 1;

  return 0;
}

stop_sounds() {
  self stopsoundchannel("voice_bchatter_1_3d");
  self stopsoundchannel("voice_air_3d");
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
  self stoploopsound();
}

c6_scriptablecleanup() {
  if(!isDefined(self)) {
    return;
  }
  self.bt.disabledismemberbehaviors = 1;

  if(isDefined(self.asm.bpreragdolled)) {
    return;
  }
  self.asm.bpreragdolled = 1;
  self.scriptablecleanup = 1;

  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }
  foreach(partname, part in self._blackboard.scriptableparts) {
    state = part.state;

    if(state == "normal") {
      continue;
    }
    if(issubstr(state, "_both"))
      state = "dmg_both";

    self setscriptablepartstate(partname, state + "_stopfx");
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

c8_scriptablecleanup() {
  self.bt.disabledismemberbehaviors = 1;

  if(isDefined(self.asm.bpreragdolled)) {
    return;
  }
  self.asm.bpreragdolled = 1;
  self.scriptablecleanup = 1;

  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }
  foreach(partname, part in self._blackboard.scriptableparts) {
    if(issubstr(partname, "dmg_fx"))
      self setscriptablepartstate(partname, "stopfx");
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

choosemovingdeathanim(asmname, statename, params) {
  _id_C63CAEFABA806BCC = length(self.velocity);
  archetype = self getbasearchetype();
  _id_C7EEABFB94518B4D = getnearestspeedthresholdname(archetype, _id_C63CAEFABA806BCC);
  _id_CD86E6C9B1AFD8CF = [];
  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_C7EEABFB94518B4D);

  if(_id_CD86E6C9B1AFD8CF.size == 0)
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  return _id_CD86E6C9B1AFD8CF[randomint(_id_CD86E6C9B1AFD8CF.size)];
}

choosecrouchingdeathanim(asmname, statename, params) {
  if(scripts\engine\utility::damagelocationisany("head", "neck"))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "head");

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "torso");

  return scripts\asm\asm::asm_lookupanimfromalias(statename, "default");
}

choosecoverdeathanim(asmname, statename, params) {
  switch (params) {
    case "cover_stand":
      return scripts\asm\asm::asm_lookupanimfromalias(statename, "stand");
    case "cover_exposed":
      return scripts\asm\asm::asm_lookupanimfromalias(statename, "exposed");
    case "cover_crouch":
      if(scripts\engine\utility::damagelocationisany("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45))
        return scripts\asm\asm::asm_lookupanimfromalias(statename, "crouch_head");

      if(self.damageyaw > -45 && self.damageyaw <= 45)
        return scripts\asm\asm::asm_lookupanimfromalias(statename, "crouch_back");

      return scripts\asm\asm::asm_lookupanimfromalias(statename, "crouch_default");
    case "cover_right":
      if(self.currentpose == "stand")
        return scripts\asm\asm::asm_lookupanimfromalias(statename, "right_stand");
      else {
        if(scripts\engine\utility::damagelocationisany("head", "neck"))
          return scripts\asm\asm::asm_lookupanimfromalias(statename, "right_crouch_head");

        return scripts\asm\asm::asm_lookupanimfromalias(statename, "right_crouch_default");
      }
    case "cover_left":
      if(self.currentpose == "stand")
        return scripts\asm\asm::asm_lookupanimfromalias(statename, "left_stand");
      else
        return scripts\asm\asm::asm_lookupanimfromalias(statename, "left_crouch");
    case "cover_3d":
      return scripts\asm\asm::asm_lookupanimfromalias(statename, "3d");
  }
}

choosestandingdeathanim(asmname, statename, params) {
  if(_id_2B79931B08683E0A::isusingsidearm())
    return choosestandingpistoldeathanim(asmname, statename, params);

  if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker))
    return choosestandingmeleedeathanim(asmname, statename, params);

  _id_D66228FB725EEFA5 = [];

  if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower"))
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "lower_body");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet"))
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "head");
  else if(scripts\engine\utility::damagelocationisany("neck"))
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "neck");
  else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper"))
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "left_shoulder");

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_upper");

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet"))
      _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_2");

    if(scripts\engine\utility::damagelocationisany("torso_upper"))
      _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "torso_2");
  } else if(self.damageyaw > -45 && self.damageyaw <= 45)
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "back");

  _id_D623BC8479F9F4A4 = _id_D66228FB725EEFA5.size > 0;

  if(!_id_D623BC8479F9F4A4 || randomint(100) < 15)
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  if(randomint(100) < 10 && firingdeathallowed())
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "default_firing");

  return _id_D66228FB725EEFA5[randomint(_id_D66228FB725EEFA5.size)];
}

chooseexplosivedeathanim(asmname, statename, params) {
  _id_C81A61AE7E6E7025 = 0;
  objweapon = self.damageweapon;

  if(!isnullweapon(objweapon) && self.unittype != "juggernaut" && scripts\common\utility::shouldburnfromdamage(objweapon)) {
    if(scripts\asm\asm::asm_hasalias(statename, "molotov_f"))
      _id_C81A61AE7E6E7025 = 1;
  }

  deathalias = undefined;

  if(_id_C81A61AE7E6E7025 && self.currentpose == "prone")
    deathalias = "molotov_prone";
  else {
    deathalias = "explosive";

    if(_id_C81A61AE7E6E7025)
      deathalias = "molotov";

    if(self.currentpose == "crouch")
      deathalias = deathalias + "_crouch";
    else if(self.currentpose == "prone")
      deathalias = deathalias + "_prone";

    deathalias = deathalias + scripts\asm\soldier\pain::getpaindirectiontoactor();
  }

  deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, deathalias);

  if(_id_C81A61AE7E6E7025)
    deathanim = preventrecentanimindex(self, statename, deathalias, deathanim);

  _id_60CE35EF4EA0CCAA = scripts\asm\asm::asm_getxanim(statename, deathanim);

  if(getDvar("scr_expdeathmaymovecheck", "on") == "on") {
    t = 1;
    _id_689EF6000ED3E5FC = getnotetracktimes(_id_60CE35EF4EA0CCAA, "start_ragdoll");

    if(_id_689EF6000ED3E5FC.size > 0)
      t = _id_689EF6000ED3E5FC[0];

    _id_523EF59D77596459 = getmovedelta(_id_60CE35EF4EA0CCAA, 0, t);
    endpoint = self localtoworldcoords(_id_523EF59D77596459);
    _id_63A8DCF3642CFE17 = 0;

    if(scripts\engine\utility::actor_is3d())
      _id_63A8DCF3642CFE17 = navtrace3d(self.origin, endpoint, 0);
    else
      _id_63A8DCF3642CFE17 = self maymovefrompointtopoint(self.origin, endpoint, 0, 1);

    if(!_id_63A8DCF3642CFE17) {
      if(_id_C81A61AE7E6E7025)
        deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "default_molotov");
      else
        deathanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "default");
    }
  }

  self.deathanimmode = "nogravity";
  return deathanim;
}

choosestandingpistoldeathanim(asmname, statename, params) {
  if(abs(self.damageyaw) < 50)
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_2");

  _id_D66228FB725EEFA5 = [];

  if(abs(self.damageyaw) < 110)
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_2");

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_torso_upper");

  if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0)
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_upper_body");

  if(_id_D66228FB725EEFA5.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper"))
    _id_D66228FB725EEFA5[_id_D66228FB725EEFA5.size] = scripts\asm\asm::asm_lookupanimfromalias(statename, "pistol_default");

  return _id_D66228FB725EEFA5[randomint(_id_D66228FB725EEFA5.size)];
}

choosestandingmeleedeathanim(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, "default");
}

firingdeathallowed() {
  return 0;
}

playdeathfx() {
  self endon("killanimscript");

  if(self.stairsstate != "none") {
    return;
  }
  wait 2;

  if(isDefined(self.noragdoll) && self.damagemod != "MOD_MELEE")
    play_blood_pool();
}

play_blood_pool(_id_A234A65C378F3289, flagname) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.skipbloodpool)) {
    return;
  }
  _id_F58A124E0F0556E7 = self gettagorigin("j_SpineUpper");
  _id_A43B0202C06E0907 = self gettagangles("j_SpineUpper");
  forward = anglesToForward(_id_A43B0202C06E0907);
  up = anglestoup(_id_A43B0202C06E0907);
  right = anglestoright(_id_A43B0202C06E0907);
  _id_F58A124E0F0556E7 = _id_F58A124E0F0556E7 + forward * -8.5 + up * 5 + right * 0;
  trace = scripts\engine\trace::_bullet_trace(_id_F58A124E0F0556E7 + (0, 0, 30), _id_F58A124E0F0556E7 - (0, 0, 100), 0, undefined);

  if(trace["normal"][2] > 0.9)
    playFX(level._effect["deathfx_bloodpool_generic"], _id_F58A124E0F0556E7);
}

waitforragdoll(time) {
  wait(time);

  if(!isDefined(self)) {
    return;
  }
  if(isagent(self)) {
    return;
  }
  if(isDefined(self))
    _id_3433EE6B63C7E243::dropallaiweapons();

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(isDefined(self) && !istrue(self.noragdoll))
    self startragdoll();
}

startragdollwithoutwait() {
  if(isagent(self)) {
    return;
  }
  if(isDefined(self))
    _id_3433EE6B63C7E243::dropallaiweapons();

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(isDefined(self) && !isDefined(self.noragdoll))
    self startragdoll();
}

doimmediateragdolldeath() {
  _id_3433EE6B63C7E243::dropallaiweapons();
  self.skipdeathanim = 1;

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.vehicle_idling)) {
    return;
  }
  _id_BFEBD8ADBC01A3B6 = 10;
  _id_D95DA0355CF4CCB4 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && _id_D95DA0355CF4CCB4 == "melee")
    _id_BFEBD8ADBC01A3B6 = 5;

  damagetaken = self.damagetaken;

  if(_id_D95DA0355CF4CCB4 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE")
    damagetaken = min(damagetaken, 300);
  else
    damagetaken = min(damagetaken, 5000);

  _id_5528888BDD4C85D6 = _id_BFEBD8ADBC01A3B6 * damagetaken;

  if(isDefined(self._id_1447D8FEE27482B0))
    _id_16290C9DDA466BCE = self._id_1447D8FEE27482B0;
  else {
    _id_041F464988E49DDB = min(0.3, self.damagedir[2]);
    _id_16290C9DDA466BCE = (self.damagedir[0], self.damagedir[1], _id_041F464988E49DDB);
  }

  if(isDefined(self._id_9DEBA7456A84F2CB))
    _id_16290C9DDA466BCE = _id_16290C9DDA466BCE * self._id_9DEBA7456A84F2CB;
  else
    _id_16290C9DDA466BCE = _id_16290C9DDA466BCE * _id_5528888BDD4C85D6;

  if(self.forceragdollimmediate)
    _id_16290C9DDA466BCE = _id_16290C9DDA466BCE + self.prevanimdelta * 20 * 10;

  damagelocation = self.damagelocation;

  if(damagelocation == "none")
    damagelocation = "torso_upper";

  self startragdollfromimpact(damagelocation, _id_16290C9DDA466BCE);
  waitframe();
}

shouldhelmetpoponpain(_id_AB1C9A379F19D469) {
  if(!istrue(self.shouldhelmetpop))
    return 0;

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && isDefined(self.team) && self.lastattacker.team == self.team)
    return 0;

  if(isDefined(self.helmetsubpart) && !_id_AB1C9A379F19D469)
    return 0;

  if(isDefined(self.onlyhelmetpopondeath) && self.onlyhelmetpopondeath)
    return 0;

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    return 0;

  if(isDefined(self.damagelocation) && self.damagelocation == "helmet")
    return 1;

  if(_id_AB1C9A379F19D469 && randomint(2) == 0)
    return 1;

  return 0;
}

shouldhelmetpopondeath(_id_AB1C9A379F19D469) {
  if(!istrue(self.shouldhelmetpop))
    return 0;

  if(self.unittype != "soldier" && self.unittype != "juggernaut")
    return 0;

  if(self.damagemod == "MOD_MELEE" && randomint(3) < 2)
    return 0;

  if(isDefined(self.damagelocation) && (self.damagelocation == "helmet" || self.damagelocation == "head"))
    return 1;

  if(_id_AB1C9A379F19D469 && randomint(3) == 0)
    return 1;

  return 0;
}

helmetpop() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.hatmodel)) {
    return;
  }
  if(isDefined(self.dontbreakhelmet) && self.dontbreakhelmet) {
    return;
  }
  pos = self gettagorigin("j_head");

  if(isDefined(self.helmetshatterfx)) {
    forward = anglesToForward(self gettagangles("j_head"));
    playFX(self.helmetshatterfx, pos, forward);
  }

  playworldsound("prj_bullet_small_flesh_helmet_npc", pos);

  if(isDefined(self.helmetsubpart)) {
    self.helmetsubpart = undefined;
    damage = self getdamageparthealth("helmet", "helmet");

    if(damage > 0)
      self damagedamagepart(damage, "helmet", "helmet");
  }

  partname = getpartname(self.hatmodel, 0);
  model = spawn("script_model", self.origin + (0, 0, 64));
  model setModel(self.hatmodel);
  model.origin = self gettagorigin(partname);
  model.angles = self gettagangles(partname);
  waitframe();

  if(isDefined(self.damagedir) && self.damagedir != (0, 0, 0))
    model thread helmetlaunch(self.damagedir);
  else
    model thread helmetlaunch((randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), randomfloatrange(-1, 1)));

  self detach(self.hatmodel, "");
  self.hatmodel = undefined;
  self hidepartandchildren_allinstances("j_helmet");

  if(isalive(self) && shouldplaysuffocatedeath()) {
    playFXOnTag(level.g_effect["helmet_break_suffocate"], self, "j_head");

    if(self.asmname != "zero_gravity_space" && self.asmname != "zero_gravity")
      self.deathbysuffocation = 1;

    self kill();
  }
}

helmetlaunch(damagedir) {
  _id_363CD698CE6C69C1 = damagedir;
  _id_363CD698CE6C69C1 = _id_363CD698CE6C69C1 * randomfloatrange(2000, 4000);
  _id_D43803BE5B18DDD8 = _id_363CD698CE6C69C1[0];
  _id_D43804BE5B18E00B = _id_363CD698CE6C69C1[1];
  _id_D43805BE5B18E23E = randomfloatrange(1500, 3000);
  _id_4E1BD1F59F6A4FEF = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(_id_4E1BD1F59F6A4FEF, (_id_D43803BE5B18DDD8, _id_D43804BE5B18E00B, _id_D43805BE5B18E23E));
  wait 60;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(distancesquared(self.origin, level.player.origin) > 262144) {
      break;
    }

    wait 30;
  }

  self delete();
}

getsuffocationdeathanim() {
  animation = undefined;

  if(randomint(11) >= 1)
    return animation;

  return animation;
}

shouldplaysuffocatedeath() {
  return 0;
}

shouldheadpop(_id_AB1C9A379F19D469) {
  if(self.unittype != "soldier" && self.unittype != "juggernaut")
    return 0;

  if(isDefined(self.forceheadpop))
    return 1;

  if(self.damagemod == "MOD_MELEE")
    return 0;

  if(self.damagemod == "MOD_FIRE")
    return 0;

  objweapon = self.damageweapon;

  if(isnullweapon(objweapon))
    return 0;

  if(self.damagemod == "MOD_PROJECTILE" && objweapon.classname == "turret" && istrue(level.disableheadpopbyturret))
    return 0;

  return 0;
}

headpop() {
  if(!isDefined(self.headmodel)) {
    return;
  }
  playFXOnTag(level.g_effect["human_gib_head"], self, "j_head");
  playFXOnTag(level.g_effect["human_gib_head_cap"], self, "j_spine4");
  self detach(self.headmodel, "");
  self.headmodel = undefined;
}

cross2d(a, b) {
  return a[0] * b[1] - b[0] * a[1];
}

meleegetattackercardinaldirection(_id_E508C1784EBEDBC6, _id_D9C3B6B9654FFD8E) {
  dot = vectordot(_id_D9C3B6B9654FFD8E, _id_E508C1784EBEDBC6);
  _id_F90D3CB356BC0E24 = cos(60);

  if(squared(dot) < squared(_id_F90D3CB356BC0E24)) {
    if(cross2d(_id_E508C1784EBEDBC6, _id_D9C3B6B9654FFD8E) > 0)
      return 1;
    else
      return 3;
  } else if(dot < 0)
    return 0;
  else
    return 2;
}

orientmeleevictim(_id_AB71B1887FD003ED) {
  _id_F968C960C23738E6 = makeweapon("iw7_knife_upgrade1");
  _id_AF2A51355E17E303 = makeweapon("iw7_sonic");

  if(scripts\common\utility::isdamageweapon(_id_F968C960C23738E6) || scripts\common\utility::isdamageweapon(_id_AF2A51355E17E303)) {
    return;
  }
  if(_id_AB71B1887FD003ED || self.damagemod == "MOD_MELEE" && isDefined(self.attacker) && !scripts\common\utility::wasdamagedbyoffhandshield() && !scripts\common\utility::isdamageweapon(_id_AF2A51355E17E303)) {
    if(scripts\engine\utility::actor_is3d()) {
      _id_65ED85ED588949AC = self.attacker.origin - self.origin;
      _id_910C18A863E61B73 = generateaxisanglesfromforwardvector(_id_65ED85ED588949AC, self.angles);
      self orientmode("face angle 3d", _id_910C18A863E61B73);
    } else {
      _id_8300AA96877A3FC8 = self.damagedir;
      _id_0F7FE90F909C5141 = anglesToForward(self.angles);
      _id_8305909687802F71 = vectorNormalize((_id_8300AA96877A3FC8[0], _id_8300AA96877A3FC8[1], 0));
      _id_0F7BC30F909807D8 = vectorNormalize((_id_0F7FE90F909C5141[0], _id_0F7FE90F909C5141[1], 0));
      _id_5049EA3DCC6ED882 = meleegetattackercardinaldirection(_id_0F7BC30F909807D8, _id_8305909687802F71);
      _id_AD639924557486D5 = _id_5049EA3DCC6ED882 * 90;
      _id_65F1ABED588D9315 = (-1 * _id_8305909687802F71[0], -1 * _id_8305909687802F71[1], 0);
      _id_B69039EA120956AF = rotatevector(_id_65F1ABED588D9315, (0, _id_AD639924557486D5, 0));
      _id_623F3095ECFA11FF = vectortoyaw(_id_B69039EA120956AF);
      forward = anglesToForward((0, _id_623F3095ECFA11FF, 0));
      self orientmode("face angle", _id_623F3095ECFA11FF);
    }
  }
}

playdeathsound(_id_AB1C9A379F19D469) {
  if(istrue(self._id_F543095C3CA1B743)) {
    return;
  }
  if(isDefined(self.diequietly) && self.diequietly) {
    if(isDefined(self.attacker) && isPlayer(self.attacker))
      _id_635E760983EDC107 = "death_quiet";
    else
      return;
  }

  if(shouldskipdeathsound()) {
    return;
  }
  if(isDefined(self.diequietly) && self.diequietly)
    _id_635E760983EDC107 = "death_quiet";
  else
    _id_635E760983EDC107 = "death";

  _id_D43B9FF976E8CE31 = undefined;
  _id_AB501F397D3CD312 = undefined;

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    if(isDefined(self.diequietly) && self.diequietly)
      _id_635E760983EDC107 = "death_quiet";
    else
      _id_635E760983EDC107 = "death";
  } else {
    if(isDefined(self.damageweapon) && !isnullweapon(self.damageweapon)) {
      _id_D43B9FF976E8CE31 = getweaponammopoolname(self.damageweapon);
      _id_AB501F397D3CD312 = _func_F581838CE4328F7A(self.damageweapon);
    }

    if(_id_AB1C9A379F19D469) {
      if(isDefined(_id_AB501F397D3CD312) && _id_AB501F397D3CD312 == "molotov")
        _id_635E760983EDC107 = "flamedeath";
      else
        _id_635E760983EDC107 = "explodeath";
    } else {
      if(isDefined(self._blackboard.balconydeathnode))
        _id_635E760983EDC107 = "falldeath";

      if(isDefined(_id_D43B9FF976E8CE31) && _id_D43B9FF976E8CE31 == "enum_6B98FC91F685D878")
        _id_635E760983EDC107 = "incendeath";
    }
  }

  _id_4ADE3AE5C138C8B3::saygenericdialogue(_id_635E760983EDC107);
}

shouldskipdeathsound() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
    if(isDefined(self.damageweapon) && !isnullweapon(self.damageweapon)) {
      if(self.damageweapon.classname == "spread")
        return 0;

      if(_func_F581838CE4328F7A(self.damageweapon) == "molotov")
        return 0;
    }

    return 1;
  }

  return 0;
}

removeselffrom_squadlastseenenemypos(org) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < anim.squadindex.size; _id_AC0E594AC96AA3A8++)
    anim.squadindex[_id_AC0E594AC96AA3A8] clearsightposnear(org);
}

clearsightposnear(org) {
  if(!isDefined(self.sightpos)) {
    return;
  }
  if(distance(org, self.sightpos) < 80) {
    self.sightpos = undefined;
    self.sighttime = gettime();
  }
}

isattackerwithindist(attacker, maxdist) {
  if(!isDefined(attacker))
    return 0;

  if(distance(self.origin, attacker.origin) > maxdist)
    return 0;

  return 1;
}

isspecialdeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\shared\utility::isshocked())
    return 1;

  return 0;
}

choosespecialdeath(asmname, statename, params) {
  if(scripts\asm\shared\utility::isshocked())
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "shock_death");
  else
    return scripts\asm\asm::asm_lookupanimfromalias("death_generic", "default");
}

shouldgib() {
  if(!isdismembermentenabled())
    return 0;

  if(isDefined(self.nogib))
    return 0;

  if(self.unittype != "soldier" && self.unittype != "juggernaut" && self.unittype != "civilian")
    return 0;

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    return 0;

  if(isDefined(self.damagemod) && isexplosivedamagemod(self.damagemod)) {
    if(isDefined(self.lastattacker) && (scripts\engine\utility::is_equal(self.lastattacker.asmname, "suicidebomber") || scripts\engine\utility::is_equal(self.lastattacker.asmname, "suicidebomber_cp")))
      return 1;

    if(isDefined(self.damageweapon) && scripts\engine\utility::is_equal(self.damageweapon.basename, "suicide_vest"))
      return 1;
  }

  return 0;
}

dogibdefault(victim) {
  origin = victim gettagorigin("j_spine4");

  if(isDefined(victim.damagedir) && victim.damagedir != (0, 0, 0))
    playFX(level.g_effect["human_gib_fullbody"], origin, victim.damagedir);
  else
    playFX(level.g_effect["human_gib_fullbody"], origin, (1, 0, 0));

  if(isagent(victim))
    victim playSound("gib_fullbody");
  else {
    ent = spawn("script_origin", origin);
    ent playSound("gib_fullbody", "sounddone");
    ent waittill("sounddone");
    wait 0.1;
    ent delete();
  }
}

dogib() {
  if(isDefined(self.gib_override_func))
    level thread[[self.gib_override_func]](self);
  else
    level thread dogibdefault(self);
}

shouldplayshieldbashdeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  objweapon = self.damageweapon;

  if(isDefined(objweapon)) {
    if(objweapon.type == "shield")
      return 1;

    weaponname = objweapon.basename;

    if(weaponname == "iw7_mauler_c8hack" || weaponname == "iw7_c6hack_melee" || weaponname == "iw7_c6worker_fists")
      return 1;
  }

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.unittype) && self.lastattacker.unittype == "c8" && isDefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    return 1;

  return 0;
}

doshieldbashdeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  stop_sounds();
  _id_3433EE6B63C7E243::dropallaiweapons();
  _id_483B72BBC1109AB2 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30));
  objweapon = self.damageweapon;
  weaponname = objweapon.basename;

  if(weaponname == "iw7_c6hack_melee" || weaponname == "iw7_c6worker_fists")
    _id_483B72BBC1109AB2 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);

  self setanimrate(scripts\asm\asm::asm_getroot(), 0);

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(!isDefined(self)) {
    return;
  }
  self startragdollfromimpact("torso_upper", _id_483B72BBC1109AB2 * 2400);

  if(isDefined(self.unittype) && self.unittype == "c6")
    self playSound("shield_death_c6_1");

  level.player playrumblelooponentity("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player scripts\engine\utility::delaycall(0.25, ::stoprumble, "damage_heavy");
  wait 1;
  deathcleanup();
}

getpainbodypartdeath() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    part = "head";
    return part;
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand")) {
    part = "midbody";
    return part;
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    part = "midbody";
    return part;
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    part = "lowerbody_l";
    return part;
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    part = "lowerbody_r";
    return part;
  } else {
    part = "midbody";
    return part;
  }
}

getpainbodypartcrouchdeath() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    part = "head";
    return part;
  } else {
    part = "midbody";
    return part;
  }
}

choosedirectionaldeathanim(asmname, statename, params) {
  _id_A61C75B156FC1EE0 = scripts\asm\soldier\pain::getpainweaponsize();

  if(isDefined(self._id_687D9DAF7A379462) && isDefined(self._id_AAE53348FFC9B4DD) && isDefined(self.currentpose) && self._id_687D9DAF7A379462 == "lowerbody" && self._id_AAE53348FFC9B4DD == "_lg" && self.currentpose == "prone") {
    part = "lowerbody";
    _id_A61C75B156FC1EE0 = "_lg";
  } else {
    part = getpainbodypartdeath();
    _id_A61C75B156FC1EE0 = scripts\asm\soldier\pain::getpainweaponsize();
  }

  _id_0F7FE90F909C5141 = anglesToForward(self.angles);
  _id_8305909687802F71 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  _id_0F7BC30F909807D8 = vectorNormalize((_id_0F7FE90F909C5141[0], _id_0F7FE90F909C5141[1], 0));
  _id_5049EA3DCC6ED882 = meleegetattackercardinaldirection(_id_0F7BC30F909807D8, _id_8305909687802F71);
  _id_FE5360FCC38632F8 = undefined;

  if(_id_5049EA3DCC6ED882 == 2)
    _id_FE5360FCC38632F8 = "_8";
  else if(_id_5049EA3DCC6ED882 == 3)
    _id_FE5360FCC38632F8 = "_6";
  else if(_id_5049EA3DCC6ED882 == 1)
    _id_FE5360FCC38632F8 = "_4";
  else
    _id_FE5360FCC38632F8 = "_2";

  if(shouldfireintoairdeath(statename, part))
    _id_E187B80BFB4878E7 = "fire_into_air";
  else
    _id_E187B80BFB4878E7 = part + _id_A61C75B156FC1EE0 + _id_FE5360FCC38632F8;

  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_E187B80BFB4878E7);
}

choosedirectionalcrouchdeathanim(asmname, statename, params) {
  part = getpainbodypartcrouchdeath();
  _id_A61C75B156FC1EE0 = scripts\asm\soldier\pain::getpainweaponsize();
  _id_0F7FE90F909C5141 = anglesToForward(self.angles);
  _id_8305909687802F71 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  _id_0F7BC30F909807D8 = vectorNormalize((_id_0F7FE90F909C5141[0], _id_0F7FE90F909C5141[1], 0));
  _id_5049EA3DCC6ED882 = meleegetattackercardinaldirection(_id_0F7BC30F909807D8, _id_8305909687802F71);
  _id_FE5360FCC38632F8 = undefined;

  if(_id_5049EA3DCC6ED882 == 2)
    _id_FE5360FCC38632F8 = "_8";
  else if(_id_5049EA3DCC6ED882 == 3)
    _id_FE5360FCC38632F8 = "_6";
  else if(_id_5049EA3DCC6ED882 == 1)
    _id_FE5360FCC38632F8 = "_4";
  else
    _id_FE5360FCC38632F8 = "_2";

  if(shouldfireintoairdeath(statename, part))
    _id_E187B80BFB4878E7 = "fire_into_air";
  else
    _id_E187B80BFB4878E7 = part + _id_A61C75B156FC1EE0 + _id_FE5360FCC38632F8;

  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_E187B80BFB4878E7);
}

shouldfireintoairdeath(statename, part) {
  if(scripts\common\utility::iscp())
    return 0;

  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);
  diequietly = istrue(self.diequietly) || _id_0DD6BF5F9DBA888C == "rocketlauncher" || _id_0DD6BF5F9DBA888C == "spread" || _id_0DD6BF5F9DBA888C == "pistol";

  if(!scripts\asm\asm::asm_hasalias(statename, "fire_into_air"))
    return 0;

  if(!self._blackboard.bfire)
    return 0;

  if(diequietly)
    return 0;

  if(part == "lowerbody")
    return 0;

  if(part == "head")
    _id_302E82DA1A1989AD = 0.3;
  else
    _id_302E82DA1A1989AD = 0.15;

  return randomfloat(1) < _id_302E82DA1A1989AD;
}

choosedirectionallargepaindeathanim(asmname, statename, params) {
  part = "lowerbody";
  _id_A61C75B156FC1EE0 = "_lg";
  _id_0F7FE90F909C5141 = anglesToForward(self.angles);
  _id_8305909687802F71 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  _id_0F7BC30F909807D8 = vectorNormalize((_id_0F7FE90F909C5141[0], _id_0F7FE90F909C5141[1], 0));
  _id_5049EA3DCC6ED882 = meleegetattackercardinaldirection(_id_0F7BC30F909807D8, _id_8305909687802F71);
  _id_FE5360FCC38632F8 = undefined;

  if(_id_5049EA3DCC6ED882 == 2)
    _id_FE5360FCC38632F8 = "_8";
  else if(_id_5049EA3DCC6ED882 == 3)
    _id_FE5360FCC38632F8 = "_6";
  else if(_id_5049EA3DCC6ED882 == 1)
    _id_FE5360FCC38632F8 = "_4";
  else
    _id_FE5360FCC38632F8 = "_2";

  _id_E187B80BFB4878E7 = part + _id_A61C75B156FC1EE0 + _id_FE5360FCC38632F8;
  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_E187B80BFB4878E7);
}
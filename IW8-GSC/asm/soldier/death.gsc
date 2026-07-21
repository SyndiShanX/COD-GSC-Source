/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\death.gsc
***********************************************/

deathlmgcleanup() {
  if(!isDefined(self._blackboard.leftweaponent)) {
    return;
  }
  var_0 = self._blackboard.leftweaponent;
  var_0 delete();
  self._blackboard.leftweaponent = undefined;
  scripts\anim\shared.gsc::forceuseweapon(self.primaryweapon, "primary");
}

playdeathanim(var_0, var_1, var_2) {
  stop_sounds();
  self stoplookat();

  if(isDefined(self.fnlaseroff))
    self[[self.fnlaseroff]]();

  if(isDefined(self.fnasm_clearfingerposes))
    self[[self.fnasm_clearfingerposes]]();

  if(isDefined(self.fnachievements))
    self thread[[self.fnachievements]]();

  removeselffrom_squadlastseenenemypos(self.origin);
  anim.numdeathsuntilcrawlingpain--;
  anim.numdeathsuntilcornergrenadedeath--;
  deathlmgcleanup();
  self.disabledeathorient = !(self.a.nodeath || istrue(self.noragdoll));

  if(self.a.nodeath) {
    deathcleanup();
    return;
  } else if(!isagent(self) && (isDefined(self.ragdoll_immediate) || self.forceragdollimmediate)) {
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

  var_3 = scripts\common\utility::wasdamagedbyexplosive();

  if(shouldhelmetpopondeath(var_3))
    helmetpop();

  if(shouldheadpop(var_3))
    headpop();

  if(!isDefined(self.skipdeathanim))
    self aiclearanim(scripts\asm\asm::asm_getroot(), 0.3);

  playdeathsound(var_3);

  if(isDefined(self.asm.deathfunc)) {
    self[[self.asm.deathfunc]]();

    if(!isDefined(self.deathfunction)) {
      deathcleanup();
      return;
    }
  }

  if(isDefined(self.deathfunction)) {
    var_4 = self[[self.deathfunction]]();

    if(!isDefined(var_4))
      var_4 = 1;

    if(var_4) {
      deathcleanup();
      return;
    }
  }

  self endon("entitydeleted");

  if(shouldgib() && !self isragdoll()) {
    scripts\anim\shared.gsc::dropallaiweapons();
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
    self.deathanim = getsuffocationdeathanim();

  var_5 = undefined;
  var_6 = undefined;
  var_7 = isDefined(self.deathalias) && isDefined(self.deathstate);

  if(!isDefined(self.skipdeathanim)) {
    if(isDefined(self.deathanim)) {
      var_5 = self.deathanim;
      var_6 = scripts\asm\asm::asm_getxanim(var_1, var_5);
    } else if(var_7) {
      var_5 = scripts\asm\asm::asm_lookupanimfromalias(self.deathstate, self.deathalias);
      var_6 = scripts\asm\asm::asm_getxanim(self.deathstate, var_5);
    } else {
      var_5 = scripts\asm\asm::asm_getanim(var_0, var_1, var_2);
      var_6 = scripts\asm\asm::asm_getxanim(var_1, var_5);
    }

    if(!animhasnotetrack(var_6, "dropgun") && !animhasnotetrack(var_6, "fire_spray"))
      scripts\anim\shared.gsc::dropallaiweapons();

    if(animhasnotetrack(var_6, "dropgun"))
      self._blackboard.awaitingdropgunnotetrack = 1;

    if(isDefined(self.asm.flashlight) && self.asm.flashlight)
      scripts\asm\soldier\patrol::detachflashlight();

    handleburningtodeath(var_6);
    self.deathanimduration = int(getanimlength(var_6) * 1000);
    var_8 = isDefined(var_2) && var_2 == "directional_orient";

    if(istrue(self.disabledeathdirectionalorient))
      var_8 = 0;

    orientmeleevictim(var_8);

    if(isnumber(var_5)) {
      if(var_7)
        self aisetanim(self.deathstate, var_5);
      else
        self aisetanim(var_1, var_5);
    } else {
      var_9 = scripts\asm\asm::asm_getinnerrootknob();
      self clearanim(var_9, 0.05);
      self setflaggedanimknoballrestart(var_1, var_5, var_9, 1, 0.05);
    }

    if(var_7)
      scripts\asm\asm::asm_playfacialanim(var_0, self.deathstate, var_6);
    else
      scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_6);
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
      scripts\anim\shared.gsc::dropallaiweapons();
      self startragdoll();
    }

    if(!isagent(self)) {
      wait 0.05;
      self animmode("gravity");
    }
  } else if(isDefined(self.ragdolltime))
    thread waitforragdoll(self.ragdolltime);
  else if(getdvarint("scr_forceRagdollOnDeath") == 1)
    thread startragdollwithoutwait();
  else {
    var_10 = getnotetracktimes(var_6, "start_ragdoll");
    var_11 = !var_7 && !isDefined(self.deathanim) && (var_10.size == 0 || var_10[0] > 0.5);

    if(var_11) {
      if(self.damagemod == "MOD_MELEE")
        var_12 = 0.7;
      else
        var_12 = 0.35;

      thread waitforragdoll(getanimlength(var_6) * var_12);
    }
  }

  if(!isagent(self) && !isDefined(self.skipdeathanim))
    thread playdeathfx();

  self endon("terminate_death_thread");

  if(!isagent(self)) {
    if(isDefined(self.skipdeathanim))
      wait 0.05;
    else {
      var_13 = var_1;

      if(var_7)
        var_13 = self.deathstate;

      scripts\asm\asm::asm_donotetracks(var_0, var_13, ::deathnotetrackhandler);
    }
  }

  if(!isDefined(self)) {
    return;
  }
  scripts\anim\shared.gsc::dropallaiweapons();
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

deathnotetrackhandler(var_0) {
  if(isDefined(self.burningtodeath) && self.burningtodeath) {
    switch (var_0) {
      case "model_swap":
        handleburndeathmodelswap();
        return;
      case "burn_vfx_death_start":
        thread handleburndeathvfx();
        return;
    }
  }

  scripts\anim\notetracks.gsc::notetrack_prefix_handler(var_0);
}

handleburningtodeath(var_0) {
  if(isDefined(self.burningtodeath) && self.burningtodeath && self.unittype != "dog" && (!isDefined(var_0) || !animhasnotetrack(var_0, "model_swap"))) {
    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
      self.headmodel = undefined;
    }

    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = undefined;
    }

    self setModel("burntbody_male");

    if(!isDefined(var_0) || !animhasnotetrack(var_0, "burn_vfx_death_start"))
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
  var_0 = 1;

  if(self isscriptable()) {
    var_1 = self getscriptablepartstate("burn_to_death_by_molotov", 1);

    if(isDefined(var_1)) {
      self setscriptablepartstate("burn_to_death_by_molotov", "active");
      var_0 = 0;
    }
  }

  if(var_0) {
    var_2 = getburnvfxtagpackets();

    foreach(var_4 in var_2) {
      if(!isDefined(self)) {
        return;
      }
      playFXOnTag(level.g_effect[var_4.burnvfx], self, var_4.tag);
      wait 0.05;
    }
  }
}

getburnvfxtagpackets() {
  var_0 = [];
  var_0[var_0.size] = createburnvfxpacket("j_knee_ri", "vfx_burn_sml_high");
  var_0[var_0.size] = createburnvfxpacket("j_knee_le", "vfx_burn_sml_high");
  var_0[var_0.size] = createburnvfxpacket("j_hip_proc_ri", "vfx_burn_med_high");
  var_0[var_0.size] = createburnvfxpacket("j_hip_proc_le", "vfx_burn_med_high");
  var_0[var_0.size] = createburnvfxpacket("j_spinelower", "vfx_burn_med_high");
  var_0[var_0.size] = createburnvfxpacket("j_spine4", "vfx_burn_lrg_high");
  var_0[var_0.size] = createburnvfxpacket("j_elbow_ri", "vfx_burn_sml_high");
  var_0[var_0.size] = createburnvfxpacket("j_elbow_le", "vfx_burn_sml_high");
  var_0[var_0.size] = createburnvfxpacket("j_shoulder_ri", "vfx_burn_med_high");
  var_0[var_0.size] = createburnvfxpacket("j_shoulder_le", "vfx_burn_med_high");
  return var_0;
}

createburnvfxpacket(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.tag = var_0;
  var_3.burnvfx = var_1;
  return var_3;
}

c8deathsound(var_0, var_1) {
  var_2 = getsubstr(var_1, 0, 3);

  if(var_2 == "vo_") {
    var_3 = getsubstr(var_1, 3);
    var_0 playsoundatviewheight(var_3);
    return;
  }

  if(var_2 != "ps_") {
    return;
  }
  var_3 = getsubstr(var_1, 3);

  if(!isDefined(var_0.deathsoundent)) {
    var_0.deathsoundent = spawn("script_origin", var_0.origin);
    var_0.deathsoundent linkTo(var_0, "");
  }

  var_4 = var_0.deathsoundent;
  var_4 notify("stop_C8DeathSound");
  var_4 endon("stop_C8DeathSound");
  var_4 playSound(var_3);
  var_5 = lookupsoundlength(var_3);
  wait(var_5 * 0.001 + 0.1);
  var_4 delete();
}

playexplosivedeathanim(var_0, var_1, var_2) {
  if((scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_knife_upgrade1")) || scripts\common\utility::wasdamagedbyoffhandshield() || scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_sonic"))) && isDefined(self.attacker)) {
    var_3 = vectortoyaw(self.attacker.origin - self.origin);

    if(self.damageyaw > 135 || self.damageyaw <= -135)
      self orientmode("face angle", var_3);
    else if(self.damageyaw > 45 && self.damageyaw <= 135)
      self orientmode("face angle", var_3 + 90);
    else if(self.damageyaw > -45 && self.damageyaw <= 45)
      self orientmode("face angle", var_3 - 180);
    else
      self orientmode("face angle", var_3 - 90);
  }

  playdeathanim(var_0, var_1, var_2);
}

playbalconydeathanim(var_0, var_1, var_2) {
  anim.nextbalconydeathtime = gettime() + randomintrange(25000, 35000);
  self orientmode("face angle", self._blackboard.balconydeathnode.angles[1]);
  playdeathanim(var_0, var_1, var_2);
}

playdeathanim_melee_ragdolldelayed(var_0, var_1, var_2) {
  var_3 = isagent(self);

  if(!var_3) {
    if(isDefined(self.meleestatename)) {
      var_4 = var_2;

      if(!isDefined(var_4))
        var_4 = 10;

      scripts\asm\asm::asm_donotetrackswithtimeout(var_0, self.meleestatename, var_4);
    }
  }

  scripts\anim\shared.gsc::dropallaiweapons();

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(!isDefined(self)) {
    return;
  }
  if(!var_3) {
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
  var_0 = 3;

  while(isDefined(self) && self.script != "death" && var_0 > 0) {
    var_0--;
    wait 0.05;
  }

  self notify("killanimscript");
}

chooseshockdeathanim(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "standing");
}

shouldplayshockdeath(var_0, var_1, var_2, var_3) {
  return scripts\asm\shared\utility::isshocked() || isDefined(self.shockdeath);
}

shouldplayexplosivedeath(var_0, var_1, var_2, var_3) {
  if(self.unittype == "juggernaut")
    return 0;

  if(scripts\common\utility::wasdamagedbyexplosive())
    return 1;

  return 0;
}

shouldplayplayermeleedeath(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damagemod) && isalive(self.attacker)) {
    if(!isPlayer(self.attacker))
      return 0;

    if(scripts\common\utility::getdamagetype(self.damagemod) != "melee")
      return 0;

    return 1;
  }

  return 0;
}

shouldplaybalconydeath(var_0, var_1, var_2, var_3) {
  if(self.currentpose == "prone")
    return 0;

  if(!isDefined(self.burningtodeath) && scripts\common\utility::wasdamagedbyexplosive())
    return 0;

  if(gettime() < anim.nextbalconydeathtime && !istrue(self.forcebalconydeath))
    return 0;

  var_4 = undefined;

  if(isDefined(self._blackboard.covernode))
    var_4 = self._blackboard.covernode;
  else if(isDefined(self._blackboard.lastusednode))
    var_4 = self._blackboard.lastusednode;

  if(!isDefined(var_4) || !isDefined(var_4.script_balcony))
    return 0;

  if(abs(angleclamp180(var_4.angles[1] - self.angles[1])) > 30)
    return 0;

  if(isDefined(self.script_chance)) {
    if(randomfloat(1) > self.script_chance)
      return 0;
  }

  if(self nearnode(var_4)) {
    self._blackboard.balconydeathnode = var_4;
    return 1;
  }

  return 0;
}

shouldplaybalconyraildeath(var_0, var_1, var_2, var_3) {
  return self._blackboard.balconydeathnode.script_balcony == 1;
}

choosebalconydeathanim(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.currentpose);
}

shouldplaystrongdamagedeath(var_0, var_1, var_2, var_3) {
  var_4 = self.damageweapon;

  if(!isDefined(var_4) || nullweapon(var_4))
    return 0;

  if(isDefined(self.a.doinglongdeath))
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

  if(scripts\anim\utility_common.gsc::issniperrifle(var_4) && self.maxhealth < self.damagetaken)
    return 1;

  if(scripts\anim\utility_common.gsc::isshotgun(var_4) && isattackerwithindist(self.attacker, 512))
    return 1;

  if(var_4.basename == "iw7_devastator" && scripts\common\utility::isweaponepic(var_4))
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
  foreach(var_3, var_1 in self._blackboard.scriptableparts) {
    var_2 = var_1.state;

    if(var_2 == "normal") {
      continue;
    }
    if(issubstr(var_2, "_both"))
      var_2 = "dmg_both";

    self setscriptablepartstate(var_3, var_2 + "_stopfx");
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
  foreach(var_2, var_1 in self._blackboard.scriptableparts) {
    if(issubstr(var_2, "dmg_fx"))
      self setscriptablepartstate(var_2, "stopfx");
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

choosemovingdeathanim(var_0, var_1, var_2) {
  var_3 = length(self.velocity);
  var_4 = scripts\asm\shared\utility::getbasearchetype();
  var_5 = getnextlowestspeedthresholdstring(var_4, var_3);
  var_6 = [];
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);

  if(var_6.size == 0)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  return var_6[randomint(var_6.size)];
}

choosecrouchingdeathanim(var_0, var_1, var_2) {
  if(scripts\engine\utility::damagelocationisany("head", "neck"))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso");

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
}

choosecoverdeathanim(var_0, var_1, var_2) {
  switch (var_2) {
    case "cover_stand":
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "stand");
    case "cover_exposed":
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "exposed");
    case "cover_crouch":
      if(scripts\engine\utility::damagelocationisany("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45))
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch_head");

      if(self.damageyaw > -45 && self.damageyaw <= 45)
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch_back");

      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch_default");
    case "cover_right":
      if(self.currentpose == "stand")
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_stand");
      else {
        if(scripts\engine\utility::damagelocationisany("head", "neck"))
          return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_crouch_head");

        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_crouch_default");
      }
    case "cover_left":
      if(self.currentpose == "stand")
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_stand");
      else
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_crouch");
    case "cover_3d":
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "3d");
  }
}

choosestandingdeathanim(var_0, var_1, var_2) {
  if(scripts\anim\utility_common.gsc::isusingsidearm())
    return choosestandingpistoldeathanim(var_0, var_1, var_2);

  if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker))
    return choosestandingmeleedeathanim(var_0, var_1, var_2);

  var_3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "lower_body");
  else if(scripts\engine\utility::damagelocationisany("head", "helmet"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  else if(scripts\engine\utility::damagelocationisany("neck"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "neck");
  else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_shoulder");

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet"))
      var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_2");

    if(scripts\engine\utility::damagelocationisany("torso_upper"))
      var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_2");
  } else if(self.damageyaw > -45 && self.damageyaw <= 45)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "back");

  var_4 = var_3.size > 0;

  if(!var_4 || randomint(100) < 15)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");

  if(randomint(100) < 10 && firingdeathallowed())
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default_firing");

  return var_3[randomint(var_3.size)];
}

chooseexplosivedeathanim(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = self.damageweapon;

  if(!nullweapon(var_4) && var_4.basename == "molotov") {
    if(scripts\asm\asm::asm_hasalias(var_1, "molotov_f"))
      var_3 = 1;
  }

  var_5 = undefined;

  if(var_3 && self.currentpose == "prone")
    var_5 = "molotov_prone";
  else {
    var_5 = "explosive";

    if(var_3)
      var_5 = "molotov";

    if(self.currentpose == "crouch")
      var_5 = var_5 + "_crouch";

    var_5 = var_5 + scripts\asm\soldier\pain::getpaindirectiontoactor();
  }

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);

  if(var_3)
    var_6 = scripts\asm\shared\utility::preventrecentanimindex(var_1, var_5, var_6);

  var_7 = scripts\asm\asm::asm_getxanim(var_1, var_6);

  if(getDvar("scr_expDeathMayMoveCheck", "on") == "on") {
    var_8 = 1;
    var_9 = getnotetracktimes(var_7, "start_ragdoll");

    if(var_9.size > 0)
      var_8 = var_9[0];

    var_10 = getmovedelta(var_7, 0, var_8);
    var_11 = self localtoworldcoords(var_10);
    var_12 = 0;

    if(scripts\engine\utility::actor_is3d())
      var_12 = navtrace3d(self.origin, var_11, 0);
    else
      var_12 = self maymovefrompointtopoint(self.origin, var_11, 0, 1);

    if(!var_12) {
      if(var_3)
        var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default_molotov");
      else
        var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
    }
  }

  self.deathanimmode = "nogravity";
  return var_6;
}

choosestandingpistoldeathanim(var_0, var_1, var_2) {
  if(abs(self.damageyaw) < 50)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_2");

  var_3 = [];

  if(abs(self.damageyaw) < 110)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_2");

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_torso_upper");

  if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0)
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_upper_body");

  if(var_3.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper"))
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_default");

  return var_3[randomint(var_3.size)];
}

choosestandingmeleedeathanim(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
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

play_blood_pool(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.skipbloodpool)) {
    return;
  }
  var_2 = self gettagorigin("j_SpineUpper");
  var_3 = self gettagangles("j_SpineUpper");
  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);
  var_6 = anglestoright(var_3);
  var_2 = var_2 + var_4 * -8.5 + var_5 * 5 + var_6 * 0;
  var_7 = scripts\engine\trace::_bullet_trace(var_2 + (0, 0, 30), var_2 - (0, 0, 100), 0, undefined);

  if(var_7["normal"][2] > 0.9)
    playFX(level._effect["deathfx_bloodpool_generic"], var_2);
}

waitforragdoll(var_0) {
  wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  if(isagent(self)) {
    return;
  }
  if(isDefined(self))
    scripts\anim\shared.gsc::dropallaiweapons();

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(isDefined(self) && !isDefined(self.noragdoll))
    self startragdoll();
}

startragdollwithoutwait() {
  if(isagent(self)) {
    return;
  }
  if(isDefined(self))
    scripts\anim\shared.gsc::dropallaiweapons();

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(isDefined(self) && !isDefined(self.noragdoll))
    self startragdoll();
}

doimmediateragdolldeath() {
  scripts\anim\shared.gsc::dropallaiweapons();
  self.skipdeathanim = 1;

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(!isDefined(self)) {
    return;
  }
  var_0 = 10;
  var_1 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && var_1 == "melee")
    var_0 = 5;

  var_2 = self.damagetaken;

  if(var_1 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE")
    var_2 = min(var_2, 300);

  var_3 = var_0 * var_2;
  var_4 = max(0.3, self.damagedir[2]);
  var_5 = (self.damagedir[0], self.damagedir[1], var_4);

  if(isDefined(self.ragdoll_directionscale))
    var_5 = var_5 * self.ragdoll_directionscale;
  else
    var_5 = var_5 * var_3;

  if(self.forceragdollimmediate)
    var_5 = var_5 + self.prevanimdelta * 20 * 10;

  if(isDefined(self.ragdoll_start_vel))
    var_5 = var_5 + self.ragdoll_start_vel * 10;

  var_6 = self.damagelocation;

  if(isDefined(self.ragdoll_damagelocation_none) && var_6 == "none")
    var_6 = self.ragdoll_damagelocation_none;

  if(isDefined(self.doantigravgrenaderagdoll) && self.doantigravgrenaderagdoll == 1) {
    var_5 = vectorNormalize((self.damagedir[0], self.damagedir[1], self.damagedir[2]));
    var_5 = var_5 * 1500;
  }

  self startragdollfromimpact(var_6, var_5);
  wait 0.05;
}

shouldhelmetpoponpain(var_0) {
  if(!istrue(self.shouldhelmetpop))
    return 0;

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && isDefined(self.team) && self.lastattacker.team == self.team)
    return 0;

  if(isDefined(self.helmetsubpart) && !var_0)
    return 0;

  if(isDefined(self.onlyhelmetpopondeath) && self.onlyhelmetpopondeath)
    return 0;

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    return 0;

  if(isDefined(self.damagelocation) && self.damagelocation == "helmet")
    return 1;

  if(var_0 && randomint(2) == 0)
    return 1;

  return 0;
}

shouldhelmetpopondeath(var_0) {
  if(!istrue(self.shouldhelmetpop))
    return 0;

  if(self.unittype != "soldier" && self.unittype != "juggernaut")
    return 0;

  if(self.damagemod == "MOD_MELEE" && randomint(3) < 2)
    return 0;

  if(isDefined(self.damagelocation) && (self.damagelocation == "helmet" || self.damagelocation == "head"))
    return 1;

  if(var_0 && randomint(3) == 0)
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
  var_0 = self gettagorigin("j_head");

  if(isDefined(self.helmetshatterfx)) {
    var_1 = anglesToForward(self gettagangles("j_head"));
    playFX(self.helmetshatterfx, var_0, var_1);
  }

  playworldsound("bullet_small_flesh_helmet_npc", var_0);

  if(isDefined(self.helmetsubpart)) {
    self.helmetsubpart = undefined;
    var_2 = self getdamageparthealth("helmet", "helmet");

    if(var_2 > 0)
      self damagedamagepart(var_2, "helmet", "helmet");
  }

  var_3 = getpartname(self.hatmodel, 0);
  var_4 = spawn("script_model", self.origin + (0, 0, 64));
  var_4 setModel(self.hatmodel);
  var_4.origin = self gettagorigin(var_3);
  var_4.angles = self gettagangles(var_3);
  waitframe();

  if(isDefined(self.damagedir) && self.damagedir != (0, 0, 0))
    var_4 thread helmetlaunch(self.damagedir);
  else
    var_4 thread helmetlaunch((randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), randomfloatrange(-1, 1)));

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

helmetlaunch(var_0) {
  var_1 = var_0;
  var_1 = var_1 * randomfloatrange(2000, 4000);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = randomfloatrange(1500, 3000);
  var_5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var_5, (var_2, var_3, var_4));
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
  var_0 = undefined;

  if(randomint(11) >= 1)
    return var_0;

  return var_0;
}

shouldplaysuffocatedeath() {
  return 0;
}

shouldheadpop(var_0) {
  if(self.unittype != "soldier" && self.unittype != "juggernaut")
    return 0;

  if(isDefined(self.forceheadpop))
    return 1;

  if(self.damagemod == "MOD_MELEE")
    return 0;

  if(self.damagemod == "MOD_FIRE")
    return 0;

  var_1 = self.damageweapon;

  if(nullweapon(var_1))
    return 0;

  if(self.damagemod == "MOD_PROJECTILE" && var_1.classname == "turret" && istrue(level.disableheadpopbyturret))
    return 0;

  return 0;
}

headpop() {
  if(!isDefined(self.headmodel)) {
    return;
  }
  var_0 = self gettagorigin("j_head");
  var_1 = anglesToForward(self gettagangles("j_head"));
  playFXOnTag(level.g_effect["human_gib_head"], self, "j_head");
  self detach(self.headmodel, "");
  self.headmodel = undefined;
}

cross2d(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

meleegetattackercardinaldirection(var_0, var_1) {
  var_2 = vectordot(var_1, var_0);
  var_3 = cos(60);

  if(squared(var_2) < squared(var_3)) {
    if(cross2d(var_0, var_1) > 0)
      return 1;
    else
      return 3;
  } else if(var_2 < 0)
    return 0;
  else
    return 2;
}

orientmeleevictim(var_0) {
  var_1 = getcompleteweaponname("iw7_knife_upgrade1");
  var_2 = getcompleteweaponname("iw7_sonic");

  if(scripts\common\utility::isdamageweapon(var_1) || scripts\common\utility::isdamageweapon(var_2)) {
    return;
  }
  if(var_0 || self.damagemod == "MOD_MELEE" && isDefined(self.attacker) && !scripts\common\utility::wasdamagedbyoffhandshield() && !scripts\common\utility::isdamageweapon(var_2)) {
    if(scripts\engine\utility::actor_is3d()) {
      var_3 = self.attacker.origin - self.origin;
      var_4 = generateaxisanglesfromforwardvector(var_3, self.angles);
      self orientmode("face angle 3d", var_4);
    } else {
      var_5 = self.damagedir;
      var_6 = anglesToForward(self.angles);
      var_7 = vectorNormalize((var_5[0], var_5[1], 0));
      var_8 = vectorNormalize((var_6[0], var_6[1], 0));
      var_9 = meleegetattackercardinaldirection(var_8, var_7);
      var_10 = var_9 * 90;
      var_11 = (-1 * var_7[0], -1 * var_7[1], 0);
      var_12 = rotatevector(var_11, (0, var_10, 0));
      var_13 = vectortoyaw(var_12);
      var_14 = anglesToForward((0, var_13, 0));
      self orientmode("face angle", var_13);
    }
  }
}

playdeathsound(var_0) {
  if(isDefined(self.diequietly) && self.diequietly) {
    return;
  }
  if(shouldskipdeathsound()) {
    return;
  }
  var_1 = "death";
  var_2 = undefined;

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    var_1 = "death";
  else {
    if(isDefined(self.damageweapon) && !nullweapon(self.damageweapon))
      var_2 = getweaponammopoolname(self.damageweapon);

    if(var_0) {
      if(isDefined(var_2) && var_2 == "molotov")
        var_1 = "flamedeath";
      else
        var_1 = "explodeath";
    } else {
      if(isDefined(self._blackboard.balconydeathnode))
        var_1 = "falldeath";

      if(isDefined(var_2) && var_2 == "incendiary")
        var_1 = "incendeath";
    }
  }

  scripts\anim\face.gsc::saygenericdialogue(var_1);
}

shouldskipdeathsound() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
    if(isDefined(self.damageweapon) && !nullweapon(self.damageweapon)) {
      if(self.damageweapon.classname == "spread")
        return 0;

      if(self.damageweapon.basename == "molotov")
        return 0;
    }

    return 1;
  }

  return 0;
}

removeselffrom_squadlastseenenemypos(var_0) {
  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++)
    anim.squadindex[var_1] clearsightposnear(var_0);
}

clearsightposnear(var_0) {
  if(!isDefined(self.sightpos)) {
    return;
  }
  if(distance(var_0, self.sightpos) < 80) {
    self.sightpos = undefined;
    self.sighttime = gettime();
  }
}

isattackerwithindist(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(distance(self.origin, var_0.origin) > var_1)
    return 0;

  return 1;
}

isspecialdeath(var_0, var_1, var_2, var_3) {
  if(scripts\asm\shared\utility::isshocked())
    return 1;

  return 0;
}

choosespecialdeath(var_0, var_1, var_2) {
  if(scripts\asm\shared\utility::isshocked())
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_death");
  else
    return scripts\asm\asm::asm_lookupanimfromalias("death_generic", "default");
}

shouldgib() {
  if(!getdvarint("NTMLLPTNLT"))
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

dogibdefault(var_0) {
  var_1 = var_0 gettagorigin("j_spine4");

  if(isDefined(var_0.damagedir) && var_0.damagedir != (0, 0, 0))
    playFX(level.g_effect["human_gib_fullbody"], var_1, var_0.damagedir);
  else
    playFX(level.g_effect["human_gib_fullbody"], var_1, (1, 0, 0));

  if(isagent(var_0))
    var_0 playSound("gib_fullbody");
  else {
    var_2 = spawn("script_origin", var_1);
    var_2 playSound("gib_fullbody", "sounddone");
    var_2 waittill("sounddone");
    wait 0.1;
    var_2 delete();
  }
}

dogib() {
  if(isDefined(self.gib_override_func))
    level thread[[self.gib_override_func]](self);
  else
    level thread dogibdefault(self);
}

shouldplayshieldbashdeath(var_0, var_1, var_2, var_3) {
  var_4 = self.damageweapon;

  if(isDefined(var_4)) {
    if(var_4.type == "shield")
      return 1;

    var_5 = var_4.basename;

    if(var_5 == "iw7_mauler_c8hack" || var_5 == "iw7_c6hack_melee" || var_5 == "iw7_c6worker_fists")
      return 1;
  }

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.unittype) && self.lastattacker.unittype == "c8" && isDefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    return 1;

  return 0;
}

doshieldbashdeath(var_0, var_1, var_2, var_3) {
  stop_sounds();
  scripts\anim\shared.gsc::dropallaiweapons();
  var_4 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30));
  var_5 = self.damageweapon;
  var_6 = var_5.basename;

  if(var_6 == "iw7_c6hack_melee" || var_6 == "iw7_c6worker_fists")
    var_4 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);

  self setanimrate(scripts\asm\asm::asm_getroot(), 0);

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(!isDefined(self)) {
    return;
  }
  self startragdollfromimpact("torso_upper", var_4 * 2400);

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
    var_0 = "head";
    return var_0;
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand")) {
    var_0 = "midbody";
    return var_0;
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    var_0 = "midbody";
    return var_0;
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_0 = "lowerbody_l";
    return var_0;
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_0 = "lowerbody_r";
    return var_0;
  } else {
    var_0 = "midbody";
    return var_0;
  }
}

getpainbodypartcrouchdeath() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_0 = "head";
    return var_0;
  } else {
    var_0 = "midbody";
    return var_0;
  }
}

choosedirectionaldeathanim(var_0, var_1, var_2) {
  var_3 = scripts\asm\soldier\pain::getpainweaponsize();

  if(isDefined(self.asm.painloc) && isDefined(self.asm.painsize) && isDefined(self.currentpose) && self.asm.painloc == "lowerbody" && self.asm.painsize == "_lg" && self.currentpose == "prone") {
    var_4 = "lowerbody";
    var_3 = "_lg";
  } else {
    var_4 = getpainbodypartdeath();
    var_3 = scripts\asm\soldier\pain::getpainweaponsize();
  }

  var_5 = anglesToForward(self.angles);
  var_6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var_7 = vectorNormalize((var_5[0], var_5[1], 0));
  var_8 = meleegetattackercardinaldirection(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2)
    var_9 = "_8";
  else if(var_8 == 3)
    var_9 = "_6";
  else if(var_8 == 1)
    var_9 = "_4";
  else
    var_9 = "_2";

  if(shouldfireintoairdeath(var_1, var_4))
    var_10 = "fire_into_air";
  else
    var_10 = var_4 + var_3 + var_9;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_10);
}

choosedirectionalcrouchdeathanim(var_0, var_1, var_2) {
  var_3 = getpainbodypartcrouchdeath();
  var_4 = scripts\asm\soldier\pain::getpainweaponsize();
  var_5 = anglesToForward(self.angles);
  var_6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var_7 = vectorNormalize((var_5[0], var_5[1], 0));
  var_8 = meleegetattackercardinaldirection(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2)
    var_9 = "_8";
  else if(var_8 == 3)
    var_9 = "_6";
  else if(var_8 == 1)
    var_9 = "_4";
  else
    var_9 = "_2";

  if(shouldfireintoairdeath(var_1, var_3))
    var_10 = "fire_into_air";
  else
    var_10 = var_3 + var_4 + var_9;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_10);
}

shouldfireintoairdeath(var_0, var_1) {
  var_2 = weaponclass(self.weapon);
  var_3 = istrue(self.diequietly) || var_2 == "rocketlauncher" || var_2 == "spread" || var_2 == "pistol";

  if(!scripts\asm\asm::asm_hasalias(var_0, "fire_into_air"))
    return 0;

  if(!self._blackboard.bfire)
    return 0;

  if(var_3)
    return 0;

  if(var_1 == "lowerbody")
    return 0;

  if(var_1 == "head")
    var_4 = 0.3;
  else
    var_4 = 0.15;

  return randomfloat(1) < var_4;
}

choosedirectionallargepaindeathanim(var_0, var_1, var_2) {
  var_3 = "lowerbody";
  var_4 = "_lg";
  var_5 = anglesToForward(self.angles);
  var_6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var_7 = vectorNormalize((var_5[0], var_5[1], 0));
  var_8 = meleegetattackercardinaldirection(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2)
    var_9 = "_8";
  else if(var_8 == 3)
    var_9 = "_6";
  else if(var_8 == 1)
    var_9 = "_4";
  else
    var_9 = "_2";

  var_10 = var_3 + var_4 + var_9;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_10);
}
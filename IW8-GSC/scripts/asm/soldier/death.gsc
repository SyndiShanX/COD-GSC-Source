/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\death.gsc
***********************************************/

function deathlmgcleanup() {
  if(!isDefined(self._blackboard.leftweaponent)) {
    return;
  }

  var0 = self._blackboard.leftweaponent;
  var0 delete();
  self._blackboard.leftweaponent = undefined;
  scripts\anim\shared::forceuseweapon(self.primaryweapon, "primary");
}

function playdeathanim(var0, var1, var2) {
  stop_sounds();
  self stoplookat();

  if(isDefined(self.fnlaseroff)) {
    self[[self.fnlaseroff]]();
  }

  if(isDefined(self.fnasm_clearfingerposes)) {
    self[[self.fnasm_clearfingerposes]]();
  }

  if(isDefined(self.fnachievements)) {
    self thread[[self.fnachievements]]();
  }

  removeselffrom_squadlastseenenemypos(self.origin);
  anim.numdeathsuntilcrawlingpain--;
  anim.numdeathsuntilcornergrenadedeath--;
  deathlmgcleanup();
  self.disabledeathorient = !(self.a.nodeath || istrue(self.noragdoll));

  if(self.a.nodeath) {
    deathcleanup();
    return;
  } else if(!isagent(self) && (isDefined(self.ragdoll_immediate) || self.forceragdollimmediate)) {
    if(isDefined(self.doantigravgrenaderagdoll) && self.doantigravgrenaderagdoll) {
      self animmode("noclip");
    } else if(istrue(self.nogravityragdoll)) {
      self animmode("nogravity");
    } else {
      self animmode("gravity");
    }

    doimmediateragdolldeath();

    if(!isDefined(self)) {
      return;
    }
  }

  var3 = scripts\common\utility::wasdamagedbyexplosive();

  if(shouldhelmetpopondeath(var3)) {
    helmetpop();
  }

  if(shouldheadpop(var3)) {
    headpop();
  }

  if(!isDefined(self.skipdeathanim)) {
    self aiclearanim(scripts\asm\asm::asm_getroot(), 0.3);
  }

  playdeathsound(var3);

  if(isDefined(self.asm.deathfunc)) {
    self[[self.asm.deathfunc]]();

    if(!isDefined(self.deathfunction)) {
      deathcleanup();
      return;
    }
  }

  if(isDefined(self.deathfunction)) {
    var4 = self[[self.deathfunction]]();

    if(!isDefined(var4)) {
      var4 = 1;
    }

    if(var4) {
      deathcleanup();
      return;
    }
  }

  self endon("entitydeleted");

  if(shouldgib() && !self isragdoll()) {
    scripts\anim\shared::dropallaiweapons();
    dogib();

    if(isagent(self)) {
      self.nocorpse = 1;
    } else {
      self hide();

      if(!isagent(self)) {
        wait 0.1;
      }
    }

    if(isDefined(self)) {
      deathcleanup();

      if(!isagent(self)) {
        self delete();
      }
    }

    return;
  }

  if(isDefined(self.deathbysuffocation) && !isDefined(self.deathanim)) {
    self.deathanim = getsuffocationdeathanim();
  }

  var5 = undefined;
  var6 = undefined;
  var7 = isDefined(self.deathalias) && isDefined(self.deathstate);

  if(!isDefined(self.skipdeathanim)) {
    if(isDefined(self.deathanim)) {
      var5 = self.deathanim;
      var6 = scripts\asm\asm::asm_getxanim(var1, var5);
    } else if(var7) {
      var5 = scripts\asm\asm::asm_lookupanimfromalias(self.deathstate, self.deathalias);
      var6 = scripts\asm\asm::asm_getxanim(self.deathstate, var5);
    } else {
      var5 = scripts\asm\asm::asm_getanim(var0, var1, var2);
      var6 = scripts\asm\asm::asm_getxanim(var1, var5);
    }

    if(!animhasnotetrack(var6, "dropgun") && !animhasnotetrack(var6, "fire_spray")) {
      scripts\anim\shared::dropallaiweapons();
    }

    if(animhasnotetrack(var6, "dropgun")) {
      self._blackboard.awaitingdropgunnotetrack = 1;
    }

    if(isDefined(self.asm.flashlight) && self.asm.flashlight) {
      scripts\asm\soldier\patrol::detachflashlight();
    }

    handleburningtodeath(var6);
    self.deathanimduration = int(getanimlength(var6) * 1000);
    var8 = isDefined(var2) && var2 == "directional_orient";

    if(istrue(self.disabledeathdirectionalorient)) {
      var8 = 0;
    }

    orientmeleevictim(var8);

    if(isnumber(var5)) {
      if(var7) {
        self aisetanim(self.deathstate, var5);
      } else {
        self aisetanim(var1, var5);
      }
    } else {
      var9 = scripts\asm\asm::asm_getinnerrootknob();
      self clearanim(var9, 0.05);
      self setflaggedanimknoballrestart(var1, var5, var9, 1, 0.05);
    }

    if(var7) {
      scripts\asm\asm::asm_playfacialanim(var0, self.deathstate, var6);
    } else {
      scripts\asm\asm::asm_playfacialanim(var0, var1, var6);
    }
  }

  if(isDefined(self.deathanimmode)) {
    self animmode(self.deathanimmode);
  }

  if(isDefined(self.skipdeathanim)) {
    if(!isDefined(self.noragdoll)) {
      if(isDefined(self.fnpreragdoll)) {
        self[[self.fnpreragdoll]]();
      }

      if(!isDefined(self)) {
        return;
      }

      scripts\anim\shared::dropallaiweapons();
      self startragdoll();
    }

    if(!isagent(self)) {
      wait 0.05;
      self animmode("gravity");
    }
  } else if(isDefined(self.ragdolltime)) {
    thread waitforragdoll(self.ragdolltime);
  } else if(getdvarint("scr_forceRagdollOnDeath") == 1) {
    thread startragdollwithoutwait();
  } else {
    var10 = getnotetracktimes(var6, "start_ragdoll");
    var11 = !var7 && !isDefined(self.deathanim) && (var10.size == 0 || var10[0] > 0.5);

    if(var11) {
      if(self.damagemod == "MOD_MELEE") {
        var12 = 0.7;
      } else {
        var12 = 0.35;
      }

      thread waitforragdoll(getanimlength(var7) * var12);
    }
  }

  if(!isagent(self) && !isDefined(self.skipdeathanim)) {
    thread playdeathfx();
  }

  self endon("terminate_death_thread");

  if(!isagent(self)) {
    if(isDefined(self.skipdeathanim)) {
      wait 0.05;
    } else {
      var13 = var2;

      if(var10) {
        var13 = self.deathstate;
      }

      scripts\asm\asm::asm_donotetracks(var1, var13, &deathnotetrackhandler);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\anim\shared::dropallaiweapons();
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

function deathnotetrackhandler(var0) {
  if(isDefined(self.burningtodeath) && self.burningtodeath) {
    switch (var0) {
      case "model_swap":
        handleburndeathmodelswap();
        return;
      case "burn_vfx_death_start":
        thread handleburndeathvfx();
        return;
    }
  }

  scripts\anim\notetracks::notetrack_prefix_handler(var0);
}

function handleburningtodeath(var0) {
  if(isDefined(self.burningtodeath) && self.burningtodeath && self.unittype != "dog" && (!isDefined(var0) || !animhasnotetrack(var0, "model_swap"))) {
    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
      self.headmodel = undefined;
    }

    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = undefined;
    }

    self setModel("burntbody_male");

    if(!isDefined(var0) || !animhasnotetrack(var0, "burn_vfx_death_start")) {
      thread handleburndeathvfx();
      return;
    }

    return;
  }
}

function handleburndeathmodelswap() {
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

function handleburndeathvfx() {
  self endon("stop_burn_VFX");
  self endon("entitydeleted");
  var0 = 1;

  if(self isscriptable()) {
    var1 = self getscriptablepartstate("burn_to_death_by_molotov", 1);

    if(isDefined(var1)) {
      self setscriptablepartstate("burn_to_death_by_molotov", "active");
      var0 = 0;
    }
  }

  if(var0) {
    var2 = getburnvfxtagpackets();

    foreach(var4 in var2) {
      if(!isDefined(self)) {
        return;
      }

      playFXOnTag(level.g_effect[var4.burnvfx], self, var4.tag);
      wait 0.05;
    }

    return;
  }
}

function getburnvfxtagpackets() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, createburnvfxpacket("j_knee_ri", "vfx_burn_sml_high"));
}

function createburnvfxpacket(var0, var1, var2) {
  var3 = spawnStruct();
  var3.tag = var0;
  var3.burnvfx = var1;
  return var3;
}

function c8deathsound(var0, var1) {
  var2 = getsubstr(var1, 0, 3);

  if(var2 == "vo_") {
    var3 = getsubstr(var1, 3);
    var0 playsoundatviewheight(var3);
    return;
  }

  if(var3 != "ps_") {
    return;
  }

  var3 = getsubstr(var2, 3);

  if(!isDefined(var1.deathsoundent)) {
    var1.deathsoundent = spawn("script_origin", var1.origin);
    var1.deathsoundent linkTo(var1, "");
  }

  var4 = var1.deathsoundent;
  var4 notify("stop_C8DeathSound");
  var4 endon("stop_C8DeathSound");
  var4 playSound(var3);
  var5 = lookupsoundlength(var3);
  wait var5 * 0.001 + 0.1;
  var4 delete();
}

function playexplosivedeathanim(var0, var1, var2) {
  if((scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_knife_upgrade1")) || scripts\common\utility::wasdamagedbyoffhandshield() || scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_sonic"))) && isDefined(self.attacker)) {
    var3 = vectortoyaw(self.attacker.origin - self.origin);

    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      self orientmode("face angle", var3);
    } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
      self orientmode("face angle", var3 + 90);
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      self orientmode("face angle", var3 - 180);
    } else {
      self orientmode("face angle", var3 - 90);
    }
  }

  playdeathanim(var0, var1, var2);
}

function playbalconydeathanim(var0, var1, var2) {
  anim.nextbalconydeathtime = gettime() + randomintrange(25000, 35000);
  self orientmode("face angle", self._blackboard.balconydeathnode.angles[1]);
  playdeathanim(var0, var1, var2);
}

function playdeathanim_melee_ragdolldelayed(var0, var1, var2) {
  var3 = isagent(self);

  if(!var3) {
    if(isDefined(self.meleestatename)) {
      var4 = var2;

      if(!isDefined(var4)) {
        var4 = 10;
      }

      scripts\asm\asm::asm_donotetrackswithtimeout(var0, self.meleestatename, var4);
    }
  }

  scripts\anim\shared::dropallaiweapons();

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(!isDefined(self)) {
    return;
  }

  if(!var3) {
    self startragdoll();
    wait 0.1;
  }

  deathcleanup();
}

function deathcleanup() {
  if(istrue(self.skipdeathcleanup)) {
    return;
  }

  if(isDefined(self)) {
    if(self.unittype == "c6") {} else if(self.unittype == "c8") {
      c8_scriptablecleanup();
    }
  }

  scripts\asm\asm_bb::bb_clearmeleetarget();
  self notify("terminate_ai_threads");

  if(isagent(self)) {
    return;
  }

  var0 = 3;

  while(isDefined(self) && self.script != "death" && var0 > 0) {
    var0--;
    wait 0.05;
  }

  self notify("killanimscript");
}

function chooseshockdeathanim(var0, var1, var2, var3) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "standing");
}

function shouldplayshockdeath(var0, var1, var2, var3) {
  return scripts\asm\shared\utility::isshocked() || isDefined(self.shockdeath);
}

function shouldplayexplosivedeath(var0, var1, var2, var3) {
  if(self.unittype == "juggernaut") {
    return false;
  }

  if(scripts\common\utility::wasdamagedbyexplosive()) {
    return true;
  }

  return false;
}

function shouldplayplayermeleedeath(var0, var1, var2, var3) {
  if(isDefined(self.damagemod) && isalive(self.attacker)) {
    if(!isPlayer(self.attacker)) {
      return false;
    }

    if(scripts\common\utility::getdamagetype(self.damagemod) != "melee") {
      return false;
    }

    return true;
  }

  return false;
}

function shouldplaybalconydeath(var0, var1, var2, var3) {
  if(self.currentpose == "prone") {
    return false;
  }

  if(!isDefined(self.burningtodeath) && scripts\common\utility::wasdamagedbyexplosive()) {
    return false;
  }

  if(gettime() < anim.nextbalconydeathtime && !istrue(self.forcebalconydeath)) {
    return false;
  }

  var4 = undefined;

  if(isDefined(self._blackboard.covernode)) {
    var4 = self._blackboard.covernode;
  } else if(isDefined(self._blackboard.lastusednode)) {
    var4 = self._blackboard.lastusednode;
  }

  if(!isDefined(var4) || !isDefined(var4.script_balcony)) {
    return false;
  }

  if(abs(angleclamp180(var4.angles[1] - self.angles[1])) > 30) {
    return false;
  }

  if(isDefined(self.script_chance)) {
    if(randomfloat(1) > self.script_chance) {
      return false;
    }
  }

  if(self nearnode(var4)) {
    self._blackboard.balconydeathnode = var4;
    return true;
  }

  return false;
}

function shouldplaybalconyraildeath(var0, var1, var2, var3) {
  return self._blackboard.balconydeathnode.script_balcony == 1;
}

function choosebalconydeathanim(var0, var1, var2, var3) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, self.currentpose);
}

function shouldplaystrongdamagedeath(var0, var1, var2, var3) {
  var4 = self.damageweapon;

  if(!isDefined(var4) || nullweapon(var4)) {
    return false;
  }

  if(isDefined(self.a.doinglongdeath)) {
    return false;
  }

  if(self.currentpose == "prone" || isDefined(self.a.onback)) {
    return false;
  }

  if(self.damagemod == "MOD_MELEE") {
    return false;
  }

  if(abs(self.damageyaw) < 45) {
    return false;
  }

  if(self.damagetaken > 500) {
    return true;
  }

  if(self.a.movement == "run" && !isattackerwithindist(self.attacker, 275)) {
    if(randomint(100) < 65) {
      return false;
    }
  }

  if(scripts\anim\utility_common::issniperrifle(var4) && self.maxhealth < self.damagetaken) {
    return true;
  }

  if(scripts\anim\utility_common::isshotgun(var4) && isattackerwithindist(self.attacker, 512)) {
    return true;
  }

  if(var4.basename == "iw7_devastator" && scripts\common\utility::isweaponepic(var4)) {
    return true;
  }

  return false;
}

function stop_sounds() {
  self stopsoundchannel("voice_bchatter_1_3d");
  self stopsoundchannel("voice_air_3d");
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
  self stoploopsound();
}

function c6_scriptablecleanup() {
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

  foreach(var1 in self._blackboard.scriptableparts) {
    var2 = var1.state;

    if(var2 == "normal") {
      continue;
    }

    if(issubstr(var2, "_both")) {
      var2 = "dmg_both";
    }

    self setscriptablepartstate(var3, var2 + "_stopfx");
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

function c8_scriptablecleanup() {
  self.bt.disabledismemberbehaviors = 1;

  if(isDefined(self.asm.bpreragdolled)) {
    return;
  }

  self.asm.bpreragdolled = 1;
  self.scriptablecleanup = 1;

  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }

  foreach(var1 in self._blackboard.scriptableparts) {
    if(issubstr(var2, "dmg_fx")) {
      self setscriptablepartstate(var2, "stopfx");
    }
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

function choosemovingdeathanim(var0, var1, var2) {
  var3 = length(self.velocity);
  var4 = scripts\asm\shared\utility::getbasearchetype();
  var5 = getnextlowestspeedthresholdstring(var4, var3);
  var6 = [];
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var5);
}

function choosecrouchingdeathanim(var0, var1, var2) {
  if(scripts\engine\utility::damagelocationisany("head", "neck")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "head");
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "torso");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, "default");
}

function choosecoverdeathanim(var0, var1, var2) {
  switch (var2) {
    case "cover_stand":
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "stand");
    case "cover_exposed":
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "exposed");
    case "cover_crouch":
      if(scripts\engine\utility::damagelocationisany("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45)) {
        return scripts\asm\asm::asm_lookupanimfromalias(var1, "crouch_head");
      }

      if(self.damageyaw > -45 && self.damageyaw <= 45) {
        return scripts\asm\asm::asm_lookupanimfromalias(var1, "crouch_back");
      }

      return scripts\asm\asm::asm_lookupanimfromalias(var1, "crouch_default");
    case "cover_right":
      if(self.currentpose == "stand") {
        return scripts\asm\asm::asm_lookupanimfromalias(var1, "right_stand");
      } else {
        if(scripts\engine\utility::damagelocationisany("head", "neck")) {
          return scripts\asm\asm::asm_lookupanimfromalias(var1, "right_crouch_head");
        }

        return scripts\asm\asm::asm_lookupanimfromalias(var1, "right_crouch_default");
      }
    case "cover_left":
      if(self.currentpose == "stand") {
        return scripts\asm\asm::asm_lookupanimfromalias(var1, "left_stand");
      } else {
        return scripts\asm\asm::asm_lookupanimfromalias(var1, "left_crouch");
      }
    case "cover_3d":
      return scripts\asm\asm::asm_lookupanimfromalias(var1, "3d");
  }
}

function choosestandingdeathanim(var0, var1, var2) {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return choosestandingpistoldeathanim(var0, var1, var2);
  }

  if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    return choosestandingmeleedeathanim(var0, var1, var2);
  }

  var3 = [];

  if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "lower_body"));
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "head"));
  }

  if(scripts\engine\utility::damagelocationisany("neck")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "neck"));
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "left_shoulder"));
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_upper"));
  }

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet")) {
      GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_2"));
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper")) {
      GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "torso_2"));
    }
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "back"));
  }

  var4 = var3.size > 0;

  if(!var4 || randomint(100) < 15) {
    var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "default");
  }

  if(randomint(100) < 10 && firingdeathallowed()) {
    var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "default_firing");
  }

  return var3[randomint(var3.size)];
}

function chooseexplosivedeathanim(var0, var1, var2) {
  var3 = 0;
  var4 = self.damageweapon;

  if(!nullweapon(var4) && var4.basename == "molotov") {
    if(scripts\asm\asm::asm_hasalias(var1, "molotov_f")) {
      var3 = 1;
    }
  }

  var5 = undefined;

  if(var3 && self.currentpose == "prone") {
    var5 = "molotov_prone";
  } else {
    var5 = "explosive";

    if(var3) {
      var5 = "molotov";
    }

    if(self.currentpose == "crouch") {
      var5 += "_crouch";
    }

    var5 += scripts\asm\soldier\pain::getpaindirectiontoactor();
  }

  var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, var5);

  if(var3) {
    var6 = scripts\asm\shared\utility::preventrecentanimindex(var1, var5, var6);
  }

  var7 = scripts\asm\asm::asm_getxanim(var1, var6);

  if(getDvar("scr_expDeathMayMoveCheck", "on") == "on") {
    var8 = 1;
    var9 = getnotetracktimes(var7, "start_ragdoll");

    if(var9.size > 0) {
      var8 = var9[0];
    }

    var10 = getmovedelta(var7, 0, var8);
    var11 = self localtoworldcoords(var10);
    var12 = 0;

    if(scripts\engine\utility::actor_is3d()) {
      var12 = navtrace3d(self.origin, var11, 0);
    } else {
      var12 = self maymovefrompointtopoint(self.origin, var11, 0, 1);
    }

    if(!var12) {
      if(var3) {
        var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, "default_molotov");
      } else {
        var6 = scripts\asm\asm::asm_lookupanimfromalias(var1, "default");
      }
    }
  }

  self.deathanimmode = "nogravity";
  return var6;
}

function choosestandingpistoldeathanim(var0, var1, var2) {
  if(abs(self.damageyaw) < 50) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_2");
  }

  var3 = [];

  if(abs(self.damageyaw) < 110) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_2"));
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_torso_upper"));
  }

  if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_upper_body"));
  }

  if(var3.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
    GscBinSkip0(0x2e, var3.size, scripts\asm\asm::asm_lookupanimfromalias(var1, "pistol_default"));
  }

  return var3[randomint(var3.size)];
}

function choosestandingmeleedeathanim(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "default");
}

function firingdeathallowed() {
  return false;
}

function playdeathfx() {
  self endon("killanimscript");

  if(self.stairsstate != "none") {
    return;
  }

  wait 2;

  if(isDefined(self.noragdoll) && self.damagemod != "MOD_MELEE") {
    play_blood_pool();
    return;
  }
}

function play_blood_pool(var0, var1) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.skipbloodpool)) {
    return;
  }

  var2 = self gettagorigin("j_SpineUpper");
  var3 = self gettagangles("j_SpineUpper");
  var4 = anglesToForward(var3);
  var5 = anglestoup(var3);
  var6 = anglestoright(var3);
  var2 = var2 + var4 * -8.5 + var5 * 5 + var6 * 0;
  var7 = scripts\engine\trace::_bullet_trace(var2 + (0, 0, 30), var2 - (0, 0, 100), 0, undefined);

  if(var7["normal"][2] > 0.9) {
    playFX(level._effect["deathfx_bloodpool_generic"], var2);
    return;
  }
}

function waitforragdoll(var0) {
  wait var0;

  if(!isDefined(self)) {
    return;
  }

  if(isagent(self)) {
    return;
  }

  if(isDefined(self)) {
    scripts\anim\shared::dropallaiweapons();
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(isDefined(self) && !isDefined(self.noragdoll)) {
    self startragdoll();
    return;
  }
}

function startragdollwithoutwait() {
  if(isagent(self)) {
    return;
  }

  if(isDefined(self)) {
    scripts\anim\shared::dropallaiweapons();
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(isDefined(self) && !isDefined(self.noragdoll)) {
    self startragdoll();
    return;
  }
}

function doimmediateragdolldeath() {
  scripts\anim\shared::dropallaiweapons();
  self.skipdeathanim = 1;

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(!isDefined(self)) {
    return;
  }

  var0 = 10;
  var1 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && var1 == "melee") {
    var0 = 5;
  }

  var2 = self.damagetaken;

  if(var1 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE") {
    var2 = min(var2, 300);
  }

  var3 = var0 * var2;
  var4 = max(0.3, self.damagedir[2]);
  var5 = (self.damagedir[0], self.damagedir[1], var4);

  if(isDefined(self.ragdoll_directionscale)) {
    var5 *= self.ragdoll_directionscale;
  } else {
    var5 *= var3;
  }

  if(self.forceragdollimmediate) {
    var5 += self.prevanimdelta * 20 * 10;
  }

  if(isDefined(self.ragdoll_start_vel)) {
    var5 += self.ragdoll_start_vel * 10;
  }

  var6 = self.damagelocation;

  if(isDefined(self.ragdoll_damagelocation_none) && var6 == "none") {
    var6 = self.ragdoll_damagelocation_none;
  }

  if(isDefined(self.doantigravgrenaderagdoll) && self.doantigravgrenaderagdoll == 1) {
    var5 = vectorNormalize((self.damagedir[0], self.damagedir[1], self.damagedir[2]));
    var5 *= 1500;
  }

  self startragdollfromimpact(var6, var5);
  wait 0.05;
}

function shouldhelmetpoponpain(var0) {
  if(!istrue(self.shouldhelmetpop)) {
    return false;
  }

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && isDefined(self.team) && self.lastattacker.team == self.team) {
    return false;
  }

  if(isDefined(self.helmetsubpart) && !var0) {
    return false;
  }

  if(isDefined(self.onlyhelmetpopondeath) && self.onlyhelmetpopondeath) {
    return false;
  }

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    return false;
  }

  if(isDefined(self.damagelocation) && self.damagelocation == "helmet") {
    return true;
  }

  if(var0 && randomint(2) == 0) {
    return true;
  }

  return false;
}

function shouldhelmetpopondeath(var0) {
  if(!istrue(self.shouldhelmetpop)) {
    return false;
  }

  if(self.unittype != "soldier" && self.unittype != "juggernaut") {
    return false;
  }

  if(self.damagemod == "MOD_MELEE" && randomint(3) < 2) {
    return false;
  }

  if(isDefined(self.damagelocation) && (self.damagelocation == "helmet" || self.damagelocation == "head")) {
    return true;
  }

  if(var0 && randomint(3) == 0) {
    return true;
  }

  return false;
}

function helmetpop() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.hatmodel)) {
    return;
  }

  if(isDefined(self.dontbreakhelmet) && self.dontbreakhelmet) {
    return;
  }

  var0 = self gettagorigin("j_head");

  if(isDefined(self.helmetshatterfx)) {
    var1 = anglesToForward(self gettagangles("j_head"));
    playFX(self.helmetshatterfx, var0, var1);
  }

  playworldsound("bullet_small_flesh_helmet_npc", var0);

  if(isDefined(self.helmetsubpart)) {
    self.helmetsubpart = undefined;
    var2 = self getdamageparthealth("helmet", "helmet");

    if(var2 > 0) {
      self damagedamagepart(var2, "helmet", "helmet");
    }
  }

  var3 = getpartname(self.hatmodel, 0);
  var4 = spawn("script_model", self.origin + (0, 0, 64));
  var4 setModel(self.hatmodel);
  var4.origin = self gettagorigin(var3);
  var4.angles = self gettagangles(var3);
  waitframe();

  if(isDefined(self.damagedir) && self.damagedir != (0, 0, 0)) {
    thread helmetlaunch(var4);
  } else {
    thread helmetlaunch(var4);
  }

  self detach(self.hatmodel, "");
  self.hatmodel = undefined;
  self hidepartandchildren_allinstances("j_helmet");

  if(isalive(self) && shouldplaysuffocatedeath()) {
    playFXOnTag(level.g_effect["helmet_break_suffocate"], self, "j_head");

    if(self.asmname != "zero_gravity_space" && self.asmname != "zero_gravity") {
      self.deathbysuffocation = 1;
    }

    self kill();
    return;
  }
}

function helmetlaunch(var0) {
  var1 = var0;
  var1 *= randomfloatrange(2000, 4000);
  var2 = var1[0];
  var3 = var1[1];
  var4 = randomfloatrange(1500, 3000);
  var5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var5, (var2, var3, var4));
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

function getsuffocationdeathanim() {
  var0 = undefined;

  if(randomint(11) >= 1) {
    return var0;
  }

  return var0;
}

function shouldplaysuffocatedeath() {
  return false;
}

function shouldheadpop(var0) {
  if(self.unittype != "soldier" && self.unittype != "juggernaut") {
    return false;
  }

  if(isDefined(self.forceheadpop)) {
    return true;
  }

  if(self.damagemod == "MOD_MELEE") {
    return false;
  }

  if(self.damagemod == "MOD_FIRE") {
    return false;
  }

  var1 = self.damageweapon;

  if(nullweapon(var1)) {
    return false;
  }

  if(self.damagemod == "MOD_PROJECTILE" && var1.classname == "turret" && istrue(level.disableheadpopbyturret)) {
    return false;
  }

  return false;
}

function headpop() {
  if(!isDefined(self.headmodel)) {
    return;
  }

  var0 = self gettagorigin("j_head");
  var1 = anglesToForward(self gettagangles("j_head"));
  playFXOnTag(level.g_effect["human_gib_head"], self, "j_head");
  self detach(self.headmodel, "");
  self.headmodel = undefined;
}

function cross2d(var0, var1) {
  return var0[0] * var1[1] - var1[0] * var0[1];
}

function meleegetattackercardinaldirection(var0, var1) {
  var2 = vectordot(var1, var0);
  var3 = cos(60);

  if(squared(var2) < squared(var3)) {
    if(cross2d(var0, var1) > 0) {
      return 1;
    }

    return 3;
  }

  if(var2 < 0) {
    return 0;
  }

  return 2;
}

function orientmeleevictim(var0) {
  var1 = getcompleteweaponname("iw7_knife_upgrade1");
  var2 = getcompleteweaponname("iw7_sonic");

  if(scripts\common\utility::isdamageweapon(var1) || scripts\common\utility::isdamageweapon(var2)) {
    return;
  }

  if(var0 || self.damagemod == "MOD_MELEE" && isDefined(self.attacker) && !scripts\common\utility::wasdamagedbyoffhandshield() && !scripts\common\utility::isdamageweapon(var2)) {
    if(scripts\engine\utility::actor_is3d()) {
      var3 = self.attacker.origin - self.origin;
      var4 = generateaxisanglesfromforwardvector(var3, self.angles);
      self orientmode("face angle 3d", var4);
      return;
    }

    var5 = self.damagedir;
    var6 = anglesToForward(self.angles);
    var7 = vectorNormalize((var5[0], var5[1], 0));
    var8 = vectorNormalize((var6[0], var6[1], 0));
    var9 = meleegetattackercardinaldirection(var8, var7);
    var10 = var9 * 90;
    var11 = (-1 * var7[0], -1 * var7[1], 0);
    var12 = rotatevector(var11, (0, var10, 0));
    var13 = vectortoyaw(var12);
    var14 = anglesToForward((0, var13, 0));
    self orientmode("face angle", var13);
    return;
  }
}

function playdeathsound(var0) {
  if(isDefined(self.diequietly) && self.diequietly) {
    return;
  }

  if(shouldskipdeathsound()) {
    return;
  }

  var1 = "death";
  var2 = undefined;

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    var1 = "death";
  } else {
    if(isDefined(self.damageweapon) && !nullweapon(self.damageweapon)) {
      var2 = getweaponammopoolname(self.damageweapon);
    }

    if(var0) {
      if(isDefined(var2) && var2 == "molotov") {
        var1 = "flamedeath";
      } else {
        var1 = "explodeath";
      }
    } else {
      if(isDefined(self._blackboard.balconydeathnode)) {
        var1 = "falldeath";
      }

      if(isDefined(var2) && var2 == "incendiary") {
        var1 = "incendeath";
      }
    }
  }

  scripts\anim\face::saygenericdialogue(var1);
}

function shouldskipdeathsound() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
    if(isDefined(self.damageweapon) && !nullweapon(self.damageweapon)) {
      if(self.damageweapon.classname == "spread") {
        return false;
      }

      if(self.damageweapon.basename == "molotov") {
        return false;
      }
    }

    return true;
  }

  return false;
}

function removeselffrom_squadlastseenenemypos(var0) {
  for(var1 = 0; var1 < anim.squadindex.size; var1++) {
    clearsightposnear(anim.squadindex[var1], var0);
  }
}

function clearsightposnear(var0) {
  if(!isDefined(self.sightpos)) {
    return;
  }

  if(distance(var0, self.sightpos) < 80) {
    self.sightpos = undefined;
    self.sighttime = gettime();
    return;
  }
}

function isattackerwithindist(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(distance(self.origin, var0.origin) > var1) {
    return false;
  }

  return true;
}

function isspecialdeath(var0, var1, var2, var3) {
  if(scripts\asm\shared\utility::isshocked()) {
    return true;
  }

  return false;
}

function choosespecialdeath(var0, var1, var2) {
  if(scripts\asm\shared\utility::isshocked()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "shock_death");
  }

  return scripts\asm\asm::asm_lookupanimfromalias("death_generic", "default");
}

function shouldgib() {
  if(!getdvarint("NTMLLPTNLT")) {
    return false;
  }

  if(isDefined(self.nogib)) {
    return false;
  }

  if(self.unittype != "soldier" && self.unittype != "juggernaut" && self.unittype != "civilian") {
    return false;
  }

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    return false;
  }

  if(isDefined(self.damagemod) && isexplosivedamagemod(self.damagemod)) {
    if(isDefined(self.lastattacker) && (scripts\engine\utility::is_equal(self.lastattacker.asmname, "suicidebomber") || scripts\engine\utility::is_equal(self.lastattacker.asmname, "suicidebomber_cp"))) {
      return true;
    }

    if(isDefined(self.damageweapon) && scripts\engine\utility::is_equal(self.damageweapon.basename, "suicide_vest")) {
      return true;
    }
  }

  return false;
}

function dogibdefault(var0) {
  var1 = var0 gettagorigin("j_spine4");

  if(isDefined(var0.damagedir) && var0.damagedir != (0, 0, 0)) {
    playFX(level.g_effect["human_gib_fullbody"], var1, var0.damagedir);
  } else {
    playFX(level.g_effect["human_gib_fullbody"], var1, (1, 0, 0));
  }

  if(isagent(var0)) {
    var0 playSound("gib_fullbody");
    return;
  }

  var2 = spawn("script_origin", var1);
  var2 playSound("gib_fullbody", "sounddone");
  var2 waittill("sounddone");
  wait 0.1;
  var2 delete();
}

function dogib() {
  if(isDefined(self.gib_override_func)) {
    level thread[[self.gib_override_func]](self);
    return;
  }

  thread dogibdefault(level);
}

function shouldplayshieldbashdeath(var0, var1, var2, var3) {
  var4 = self.damageweapon;

  if(isDefined(var4)) {
    if(var4.type == "shield") {
      return true;
    }

    var5 = var4.basename;

    if(var5 == "iw7_mauler_c8hack" || var5 == "iw7_c6hack_melee" || var5 == "iw7_c6worker_fists") {
      return true;
    }
  }

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.unittype) && self.lastattacker.unittype == "c8" && isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    return true;
  }

  return false;
}

function doshieldbashdeath(var0, var1, var2, var3) {
  stop_sounds();
  scripts\anim\shared::dropallaiweapons();
  var4 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30));
  var5 = self.damageweapon;
  var6 = var5.basename;

  if(var6 == "iw7_c6hack_melee" || var6 == "iw7_c6worker_fists") {
    var4 = vectorNormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);
  }

  self setanimrate(scripts\asm\asm::asm_getroot(), 0);

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(!isDefined(self)) {
    return;
  }

  self startragdollfromimpact("torso_upper", var4 * 2400);

  if(isDefined(self.unittype) && self.unittype == "c6") {
    self playSound("shield_death_c6_1");
  }

  level.player playrumblelooponentity("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player scripts\engine\utility::delaycall(0.25, &stoprumble, "damage_heavy");
  wait 1;
  deathcleanup();
}

function getpainbodypartdeath() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var0 = "head";
    return var0;
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower", "right_hand")) {
    var0 = "midbody";
    return var0;
  }

  if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower", "left_hand")) {
    var0 = "midbody";
    return var0;
  }

  if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var0 = "lowerbody_l";
    return var0;
  }

  if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var0 = "lowerbody_r";
    return var0;
  }

  var0 = "midbody";
  return var0;
}

function getpainbodypartcrouchdeath() {
  if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var0 = "head";
    return var0;
  }

  var0 = "midbody";
  return var0;
}

function choosedirectionaldeathanim(var0, var1, var2) {
  var3 = scripts\asm\soldier\pain::getpainweaponsize();

  if(isDefined(self.asm.painloc) && isDefined(self.asm.painsize) && isDefined(self.currentpose) && self.asm.painloc == "lowerbody" && self.asm.painsize == "_lg" && self.currentpose == "prone") {
    var4 = "lowerbody";
    var3 = "_lg";
  } else {
    var4 = getpainbodypartdeath();
    var4 = scripts\asm\soldier\pain::getpainweaponsize();
  }

  var5 = anglesToForward(self.angles);
  var6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var7 = vectorNormalize((var5[0], var5[1], 0));
  var8 = meleegetattackercardinaldirection(var7, var6);
  var9 = undefined;

  if(var8 == 2) {
    var9 = "_8";
  } else if(var8 == 3) {
    var9 = "_6";
  } else if(var8 == 1) {
    var9 = "_4";
  } else {
    var9 = "_2";
  }

  if(shouldfireintoairdeath(var2, var4)) {
    var10 = "fire_into_air";
  } else {
    var10 = var5 + var4 + var10;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var3, var10);
}

function choosedirectionalcrouchdeathanim(var0, var1, var2) {
  var3 = getpainbodypartcrouchdeath();
  var4 = scripts\asm\soldier\pain::getpainweaponsize();
  var5 = anglesToForward(self.angles);
  var6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var7 = vectorNormalize((var5[0], var5[1], 0));
  var8 = meleegetattackercardinaldirection(var7, var6);
  var9 = undefined;

  if(var8 == 2) {
    var9 = "_8";
  } else if(var8 == 3) {
    var9 = "_6";
  } else if(var8 == 1) {
    var9 = "_4";
  } else {
    var9 = "_2";
  }

  if(shouldfireintoairdeath(var1, var3)) {
    var10 = "fire_into_air";
  } else {
    var10 = var4 + var5 + var10;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var2, var10);
}

function shouldfireintoairdeath(var0, var1) {
  var2 = weaponclass(self.weapon);
  var3 = istrue(self.diequietly) || var2 == "rocketlauncher" || var2 == "spread" || var2 == "pistol";

  if(!scripts\asm\asm::asm_hasalias(var0, "fire_into_air")) {
    return false;
  }

  if(!self._blackboard.bfire) {
    return false;
  }

  if(var3) {
    return false;
  }

  if(var1 == "lowerbody") {
    return false;
  }

  if(var1 == "head") {
    var4 = 0.3;
  } else {
    var4 = 0.15;
  }

  return randomfloat(1) < var4;
}

function choosedirectionallargepaindeathanim(var0, var1, var2) {
  var3 = "lowerbody";
  var4 = "_lg";
  var5 = anglesToForward(self.angles);
  var6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var7 = vectorNormalize((var5[0], var5[1], 0));
  var8 = meleegetattackercardinaldirection(var7, var6);
  var9 = undefined;

  if(var8 == 2) {
    var9 = "_8";
  } else if(var8 == 3) {
    var9 = "_6";
  } else if(var8 == 1) {
    var9 = "_4";
  } else {
    var9 = "_2";
  }

  var10 = var3 + var4 + var9;
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var10);
}
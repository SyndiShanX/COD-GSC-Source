/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\script_funcs.gsc
************************************************/

function soldier_init(var0, var1, var2) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  self.asm.frantic = 0;
  self.arrivalspeed = 1;
  self.defaultturnthreshold = 59;
  scripts\common\utility::clear_movement_speed();
  self.asm.gestures = spawnStruct();

  if(isDefined(self.fnasm_initfingerposes)) {
    self thread[[self.fnasm_initfingerposes]]();
  }

  self.fnhelmetpop = &scripts\asm\soldier\death::helmetpop;
  initnodeyaw(self.asm.archetype);
  initgrenadeoffsets();
  initaimlimits(var0);

  if(self.asm.archetype == "juggernaut" || self.asm.archetype == "juggernaut_cp") {
    scripts\asm\juggernaut\juggernaut::initanimspeedthresholds_juggernaut(self.asm.archetype);
  } else {
    initanimspeedthresholds_soldier(self.asm.archetype);
  }

  if(scripts\asm\shared\utility::getbasearchetype() == "soldier_lw") {
    self.disablepistol = 1;
    self.disablelmgmount = 1;
    self.a.disablelongdeath = 1;
  }

  isnavmeshloaded();
  initgestures();

  if(self isscriptable()) {
    thread initscriptable();
  }

  scripts\asm\shared\utility::set_aim_and_turn_limits();
  var3 = weaponclass(self.weapon);

  if(var3 == "mg") {
    self.combatmode = "cover_lmg";
  }

  scripts\anim\shared::updateweaponarchetype(var3);
}

function initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

function initnodeyaw(var0) {
  if(!isDefined(anim.nodeyaws)) {
    anim.nodeyaws = [];
  }

  if(isDefined(anim.nodeyaws[var0])) {
    return;
  }

  initnodeyaw_soldier(var0);
}

function initnodeyaw_soldier(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "Cover Left", 90);
}

function initnodeyaw_dev(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "Cover Left", 90);
}

function initnodeyaw_rebel(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "Cover Left", 180);
}

function initaimlimits(var0) {
  if(!isDefined(level.combataimlimits)) {
    level.combataimlimits = [];
    level.franticaimlimits = [];
    level.aimlimitstatemappings = [];
  }

  if(!isDefined(level.combataimlimits[var0])) {
    var1 = [];
    var2 = [];
    var3 = [];
    var1 = var3;
    var3 = [];
    var2 = var3;
    var3 = [];
    GscBinSkip0(0x2e, "down", 15);
  }

  if(!isDefined(level.aimlimitstatemappings[var3])) {
    var4 = [];
    GscBinSkip0(0x2e, "cover_stand_exposed", "cover_stand_exposed");
  }
}

function initanimspeedthresholds_soldier(var0) {
  if(hasanimspeedthresholdstring(var0)) {
    return;
  }

  if(var0 == "boss" || var0 == "boss2") {
    animspeedthresholdsexist(var0, "shuffle", 30);
  } else {
    animspeedthresholdsexist(var0, "shuffle", 23);
  }

  animspeedthresholdsexist(var0, "walk", 56);
  animspeedthresholdsexist(var0, "fast", 120);
  animspeedthresholdsexist(var0, "jog", 170);
  animspeedthresholdsexist(var0, "run", 220);
  animspeedthresholdsexist(var0, "sprint", 250);
}

function initgestures() {
  if(isDefined(anim.gestures)) {
    return;
  }

  var0 = [];
  GscBinSkip0(0x2e, var0.size, "point_casual");
}

function initgrenadeoffsets() {
  if(!isDefined(anim.grenadethrowanims)) {
    anim.grenadethrowanims = [];
  }

  if(!isDefined(anim.grenadethrowoffsets)) {
    anim.grenadethrowoffsets = [];
  }

  var0 = self.asm.archetype == "soldier_lw";
  var1 = !var0;

  if(isDefined(anim.grenadethrowanims["soldier"]) && isDefined(anim.grenadethrowoffsets["soldier"])) {
    return;
  }

  anim.islightweightsoldier = var0;
  anim.isfullsoldier = var1;
  anim.grenadethrowanims["soldier"] = [];
  anim.grenadethrowoffsets["soldier"] = [];
  anim.grenadethrowanims["soldier"]["grenade_return_throw"]["throw_short"] = scripts\asm\asm::asm_getallanimindicesforalias("grenade_return_throw", "throw_short");
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_short"] = [];
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_short"][0] = (82.8191, 11.6735, 28.1425);
  anim.grenadethrowanims["soldier"]["grenade_return_throw"]["throw_long"] = scripts\asm\asm::asm_getallanimindicesforalias("grenade_return_throw", "throw_long");
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_long"] = [];
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_long"][0] = (82.8191, 11.6735, 28.1425);
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_long"][1] = (108.037, 19.9333, 58.7747);
  anim.grenadethrowanims["soldier"]["grenade_return_throw"]["throw_default"] = scripts\asm\asm::asm_getallanimindicesforalias("grenade_return_throw", "throw_default");
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_default"] = [];
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_default"][0] = (108.037, 19.9333, 58.7747);
  anim.grenadethrowanims["soldier"]["cover_stand_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_stand_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_exposed"][0] = (12.4289, 10.4494, 63.257);
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_exposed"][1] = (19.6744, -0.861649, 55.6794);
  anim.grenadethrowanims["soldier"]["cover_stand_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_stand_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_safe"][0] = (12.4289, 10.4494, 63.257);
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_safe"][1] = (19.6744, -0.861649, 55.6794);
  anim.grenadethrowanims["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_crouch_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_exposed"][0] = (14.4711, 19.9796, 60.7207);
  anim.grenadethrowanims["soldier"]["cover_crouch_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_crouch_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_safe"][0] = (16.2644, 3.3802, 58.673);
  anim.grenadethrowanims["soldier"]["cover_right_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_exposed"][0] = (52.7985, -16.1898, 71.2437);
  anim.grenadethrowanims["soldier"]["cover_right_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_safe"][0] = (23.61, 1.79103, 73.2797);
  anim.grenadethrowanims["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_crouch_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"][0] = (52.6922, -11.2103, 74.5468);
  anim.grenadethrowanims["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_crouch_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_safe"][0] = (29.3343, -4.89863, 47.8837);
  anim.grenadethrowanims["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_crouch_grenade_throw", "grenade_throw");
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"][0] = (15.5324, 4.86811, 50.6292);
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"][1] = (1.17014, -1.57043, 60.0271);
  anim.grenadethrowanims["soldier"]["cover_left_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_exposed"][0] = (52.9483, -8.80599, 69.6026);
  anim.grenadethrowanims["soldier"]["cover_left_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_safe"][0] = (29.9023, 0.265982, 33.1921);
  anim.grenadethrowanims["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_crouch_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"][0] = (70.3568, 6.78523, 61.5581);
  anim.grenadethrowanims["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_crouch_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_safe"][0] = (24.2908, -7.09458, 21.4564);
  anim.grenadethrowanims["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_crouch_grenade_throw", "grenade_throw");
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"][0] = (0.306949, -4.18872, 12.3224);
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"][1] = (-7.34781, 1.87832, 25.0602);
  anim.grenadethrowanims["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_throw_grenade", "exposed_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_throw_grenade"]["exposed_grenade"][0] = (30.5741, 1.97765, 73.9287);
  anim.grenadethrowanims["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_prone_throw_grenade", "exposed_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"][0] = (28.3429, 6.4308, 40.3279);
  anim.grenadethrowanims["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_crouch_throw_grenade", "exposed_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"][0] = (15.7078, 1.95027, 36.0834);
  anim.grenadethrowanims["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_crouch_throw_grenade", "exposed_crouch_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"][0] = (15.7078, 1.95027, 36.0834);
}

function needtoturnformelee(var0, var1, var2, var3) {
  if(!istrue(self._blackboard.meleerequestedcharge)) {
    return false;
  }

  var4 = scripts\asm\asm_bb::bb_getmeleechargetarget();

  if(!isDefined(var4)) {
    return false;
  }

  var5 = var4.origin - self.origin;
  var6 = length(var5);

  if(var6 > 80) {
    return false;
  }

  var7 = vectortoyaw(var5);

  if(scripts\engine\utility::absangleclamp180(var7 - self.angles[1]) < 90) {
    return false;
  }

  self.desiredturnyaw = var7;
  return true;
}

function needtoturntofacepath(var0, var1, var2, var3) {
  if(!scripts\asm\asm::asm_eventfired(var0, "abort")) {
    return false;
  }

  if(!self.facemotion) {
    return false;
  }

  var4 = vectortoyaw(self.lookaheaddir);
  var5 = angleclamp180(var4 - self.angles[1]);

  if(abs(var5) < 50) {
    return false;
  }

  self.desiredturnyaw = var5;
  return true;
}

function drawneedtoturn(var0) {
  self notify("kill_draw_need_to_turn");
  self endon("kill_draw_need_to_turn");

  for(;;) {
    var1 = self.origin + anglesToForward(self.angles) * 100;
    waitframe();
  }
}

function needtoturn(var0, var1, var2, var3) {
  var4 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos)) {
      var4 = self._blackboard.shootparams_pos;
    } else if(isDefined(self._blackboard.shootparams_ent)) {
      var4 = self._blackboard.shootparams_ent.origin;
    }
  }

  if(!isDefined(var4)) {
    if(isDefined(self.smartfacingpos)) {
      var4 = self.smartfacingpos;
    }
  }

  if(!isDefined(var4) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36 && self.combatmode != "no_cover") {
    var4 = self.node.origin + anglesToForward(self.node.angles) * 384;
  }

  if(!isDefined(var4)) {
    return false;
  }

  var5 = self.angles[1] - vectortoyaw(var4 - self.origin);
  var6 = distancesquared(self.origin, var4);

  if(var6 < 65536) {
    var7 = sqrt(var6);

    if(var7 > 3) {
      var5 += asin(-3 / var7);
    }
  }

  return abs(angleclamp180(var5)) > self.turnthreshold;
}

function needtoturn3d(var0, var1, var2, var3) {
  if(istrue(self.matchexposednodeorientation) && isDefined(self.node)) {
    return false;
  }

  var4 = getturndesiredyaw3d();

  if(abs(var4) > self.turnthreshold) {
    return true;
  }

  var5 = getturndesiredpitch3d();

  if(abs(var5) > self.pitchturnthreshold) {
    return true;
  }

  return false;
}

function getturndesiredyaw() {
  if(isDefined(self.desiredturnyaw)) {
    return self.desiredturnyaw;
  }

  var0 = 0.25;
  var1 = undefined;
  var2 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos)) {
      var2 = self._blackboard.shootparams_pos;
    } else if(isDefined(self._blackboard.shootparams_ent)) {
      var1 = self._blackboard.shootparams_ent;
    }
  } else if(isDefined(self.smartfacingpos)) {
    var2 = self.smartfacingpos;
  }

  if(!isDefined(var2) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36) {
    return (self.node.angles[1] - self.angles[1]);
  }

  if(isDefined(var1) && !issentient(var1)) {
    var0 = 1.5;
  }

  var3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var0, var1, var2);
  return var3;
}

function getturndesiredyaw3d() {
  var0 = 0.25;
  var1 = undefined;
  var2 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      var1 = self._blackboard.shootparams_ent;
    } else if(isDefined(self._blackboard.shootparams_pos)) {
      var2 = self._blackboard.shootparams_pos;
    }
  } else if(isDefined(self.enemy)) {
    var1 = self.enemy;
  }

  if(isDefined(var1) && !issentient(var1)) {
    var0 = 1.5;
  }

  var3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos3d(var0, var1, var2);
  return var3;
}

function getturndesiredpitch3d() {
  var0 = 0.25;
  var1 = undefined;
  var2 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent)) {
      var1 = self._blackboard.shootparams_ent;
    } else if(isDefined(self._blackboard.shootparams_pos)) {
      var2 = self._blackboard.shootparams_pos;
    }
  } else if(isDefined(self.enemy)) {
    var1 = self.enemy;
  }

  if(isDefined(var1) && !issentient(var1)) {
    var0 = 1.5;
  }

  var3 = scripts\engine\utility::getpredictedaimpitchtoshootentorpos3d(var0, var1, var2);
  return var3;
}

function chooseturnanim(var0, var1, var2) {
  var3 = getturndesiredyaw();

  if(var3 < 0) {
    var4 = "right";
  } else {
    var4 = "left";
  }

  var4 = abs(var4);
  var5 = 0;

  if(var4 > 157.5) {
    var5 = 180;
  } else if(var4 > 112.5) {
    var5 = 135;
  } else if(var4 > 67.5 || !istrue(self.allowturn45)) {
    var5 = 90;
  } else {
    var5 = 45;
  }

  var6 = var4 + "_" + var5;
  var7 = scripts\asm\asm::asm_lookupanimfromalias(var2, var6);
  return var7;
}

function chooseturnanim3d(var0, var1, var2) {
  var3 = getturndesiredyaw3d();
  var4 = getturndesiredpitch3d();

  if(abs(var3) > self.turnthreshold && abs(var3) > abs(var4)) {
    if(var3 < 0) {
      var5 = "right";
    } else {
      var5 = "left";
    }

    var4 = abs(var4);
    var6 = 0;

    if(var4 > 157.5) {
      var6 = 180;
    } else if(var4 > 112.5) {
      var6 = 135;
    } else if(var4 > 67.5) {
      var6 = 90;
    } else {
      var6 = 45;
    }

    var7 = var5 + "_" + var6;
    var8 = scripts\asm\asm::asm_lookupanimfromalias(var2, var7);
    return var8;
  }

  if(var8 < 0) {
    var5 = "up";
  } else {
    var5 = "down";
  }

  var5 = abs(var5);
  var6 = 0;

  if(var5 > 157.5) {
    var6 = 180;
  } else if(var5 > 112.5) {
    var6 = 135;
  } else if(var5 > 67.5) {
    var6 = 90;
  } else {
    var6 = 45;
  }

  var7 = var5 + "_" + var6;
  var8 = scripts\asm\asm::asm_lookupanimfromalias(var6, var7);
  return var8;
}

function choosecrouchturnanim(var0, var1, var2) {
  var3 = getturndesiredyaw();

  if(var3 < -135) {
    var4 = "2r";
  } else if(var4 > 135) {
    var4 = "2l";
  } else if(var4 < 0) {
    var4 = "6";
  } else {
    var4 = "4";
  }

  var5 = scripts\asm\asm::asm_lookupanimfromalias(var4, var4);
  return var5;
}

function reload_cleanup(var0, var1, var2) {
  var3 = self.asm.reloadweapon;
  self.asm.reloadweapon = undefined;

  if(!isDefined(self.weaponinfo)) {
    return;
  }

  var4 = isDefined(var3) && isDefined(self.weapon) && var3 == self.weapon;

  if(!isDefined(var3)) {
    var3 = self.weapon;
  }

  var5 = createheadicon(var3);

  if(!isDefined(self.weaponinfo[var5])) {
    return;
  }

  if(!scripts\asm\asm::asm_eventfired(var0, "drop clip")) {
    return;
  }

  if(self.weaponinfo[var5].useclip) {
    var6 = getweaponclipmodel(var3);

    if(isDefined(var6)) {
      var7 = scripts\asm\asm::asm_eventfired(var0, "attach clip left") || scripts\asm\asm::asm_eventfired(var0, "attach clip right");
      var8 = scripts\asm\asm::asm_eventfired(var0, "detach clip left") || scripts\asm\asm::asm_eventfired(var0, "detach clip right") || scripts\asm\asm::asm_eventfired(var0, "detach clip nohand");

      if(!var7) {
        self notify("abort_reload");
        return;
      }

      if(var7 && !var8) {
        if(scripts\asm\asm::asm_eventfired(var0, "attach clip left")) {
          var9 = "tag_accessory_left";
        } else {
          var9 = "tag_accessory_right";
        }

        self detach(var7, var9);
        self notify("clip_detached");

        if(var5) {
          scripts\anim\shared::showweaponmagattachment(var6);
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function terminateexposedprone(var0, var1, var2) {
  self.pushable = 1;
}

function playexposedproneloop(var0, var1, var2) {
  self.pushable = 0;
  playexposedloop(var0, var1, var2);
}

function playexposedloop(var0, var1, var2) {
  scripts\asm\shared\utility::set_aim_and_turn_limits();
  var3 = self asmgetstatetransitioningfrom(var0);

  if(isDefined(var3) && (var3 == "stand_run_loop" || var3 == "move_walk_loop" || var3 == "patrol_move" || var3 == "cqb_stand_loop")) {
    childthread scripts\asm\shared\utility::setuseanimgoalweight(var1, 0.2);
  }

  if(isDefined(self.node)) {
    self._blackboard.lastusednode = self.node;
  }

  if(self.team != "allies") {
    thread faceenemywhenneeded(var1);
  }

  scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
}

function playexposedcrouchloop(var0, var1, var2) {
  playexposedloop(var0, var1, var2);
}

function playexposedidleaimdownloop(var0, var1, var2) {
  self.aimingdown = 1;
  playexposedloop(var0, var1, var2);
}

function playexposedcrouchaimdownloop(var0, var1, var2) {
  self.aimingdown = 1;
  playexposedcrouchloop(var0, var1, var2);
}

function terminateexposedidleaimdown(var0, var1, var2) {
  self.aimingdown = 0;
}

function terminateexposedcrouchaimdown(var0, var1, var2) {
  self.aimingdown = 0;
}

function faceenemywhenneeded(var0) {
  self endon(var0 + "_finished");
  var1 = self.maxfaceenemydist * self.maxfaceenemydist;

  for(;;) {
    waitframe();

    if(shouldfaceenemyinexposed()) {
      var2 = distancesquared(self.origin, self.enemy.origin);

      if(var2 < var1) {
        self orientmode("face enemy");
      } else {
        self orientmode("face current");
      }

      continue;
    }

    self orientmode("face current");
  }
}

function terminateexposedcrouch(var0, var1, var2) {}

function shouldfaceenemyinexposed() {
  if(isDefined(self.pathgoalpos)) {
    return false;
  }

  return isDefined(self.enemy) && isPlayer(self.enemy) && self cansee(self.enemy);
}

function playanim_weaponswitch(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm_bb::bb_getrequestedweapon();
  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  var5 = scripts\anim\combat_utility::fasteranimspeed();
  self aisetanim(var1, var4, var5);
  scripts\asm\asm::asm_playfacialanim(var0, var1, scripts\asm\asm::asm_getxanim(var1, var4));
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  self notify("switched_to_sidearm");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

function terminate_weaponswitch(var0, var1, var2) {
  var3 = weaponclass(self.weapon);
  scripts\anim\shared::updateweaponarchetype(var3);
}

function playturnanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  pushdisabledgunpose();
  scripts\common\gameskill::didsomethingotherthanshooting();
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);

  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy)) {
    self orientmode("face enemy");
  } else {
    self orientmode("face angle 3d", self.angles);
  }

  if(isDefined(self.node)) {
    self animmode("angle deltas");
  } else {
    self animmode("zonly_physics");
  }

  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  self.stepoutyaw = angleclamp180(getangledelta(var4, 0, 1) + self.angles[1]);
  self.useanimgoalweight = 1;
  var5 = 1;
  self aisetanim(var1, var3, var5);

  if(shouldfaceenemyinexposed()) {
    thread playturnanim_turnanimanglefixup(var4, var1);
  }

  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function playturnanim_turnanimanglefixup(var0, var1) {
  self endon("death");
  self endon(var1 + "_finished");
  var2 = self.enemy;
  var2 endon("death");
  var3 = getanimlength(var0);

  if(animhasnotetrack(var0, "start_aim")) {
    var4 = getnotetracktimes(var0, "start_aim");
    var3 *= var4[0];
  } else if(animhasnotetrack(var0, "finish")) {
    var4 = getnotetracktimes(var0, "finish");
    var3 *= var4[0];
  }

  var5 = int(var3 * 20);
  var6 = var5;

  while(var6 > 0) {
    var7 = 1 / var6;
    var8 = scripts\engine\utility::getyawtospot(var2.origin);
    self.stepoutyaw = angleclamp180(self.angles[1] + var8);
    var9 = self aigetanimtime(var0);
    var10 = getangledelta(var0, var9, 1);
    var11 = angleclamp180(var8 - var10);
    self orientmode("face angle", angleclamp(self.angles[1] + var11 * var7));
    var6--;
    wait 0.05;
  }
}

function playturnanim_cleanup(var0, var1, var2) {
  self.useanimgoalweight = 0;
  self.stepoutyaw = undefined;
  self.desiredturnyaw = undefined;
  popdisabledgunpose();

  if(istrue(self.leavecasualkiller)) {
    terminate_casualkiller(var0, var1, var2);
    return;
  }
}

function shouldsnaptocover_checktype(var0, var1, var2, var3) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!scripts\asm\shared\utility::isatcovernode()) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common::isusingsidearm() && weaponclass(self.primaryweapon) != "mg") {
    return 0;
  }

  return scripts\asm\shared\utility::isarrivaltype(var0, var1, var2, var3);
}

function currentsnaptonodeis(var0, var1, var2, var3) {
  var4 = var3;

  if(!isDefined(self.node)) {
    return (var4 == "Exposed Crouch");
  }

  if(distance2dsquared(self.origin, self.node.origin) > 225) {
    if(scripts\asm\asm_bb::bb_getrequestedstance() == "stand") {
      return (var4 == "Exposed");
    } else {
      return (var4 == "Exposed Crouch");
    }
  }

  if(isDefined(self._blackboard.runpassthroughtype)) {
    return (self._blackboard.runpassthroughtype == var3);
  }

  return scripts\asm\shared\utility::isarrivaltype(var0, var1, var2, var3);
}

function reloadnotehandler(var0) {
  scripts\anim\notetracks::notetrack_prefix_handler(var0);
  return undefined;
}

function reload(var0, var1, var2) {
  self endon("reload_terminate");
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);

  if(weaponclass(self.weapon) == "pistol") {
    self orientmode("face enemy");
  }

  self aisetanim(var1, var3);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self.asm.reloadweapon = self.weapon;
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, &reloadnotehandler);
}

function shoot_doagentnotetrackswithtimeout(var0, var1, var2, var3) {
  self endon(var1 + "_finished");
  var4 = var1 + "_timeout";
  var5 = var1 + "_timeout_end";
  childthread scripts\asm\shoot\script_funcs::shoot_timeout(var4, var5, var3);
  self endon(var4);
  var6 = animhasnotetrack(var2, "fire");
  var7 = weaponclass(self.weapon) == "rocketlauncher";
  var8 = getanimlength(var2);
  var9 = [];

  if(var6) {
    var10 = getnotetracktimes(var2, "fire");

    if(var10.size == 1 && var10[0] == 0) {
      var6 = 0;
    } else {
      var9 = var8 * var10[0];

      for(var11 = 1; var11 < var10.size; var11++) {
        var12 = var8 * var10[var11];
        var12 -= var9[var11 - 1];
        var9 = var12;
      }
    }
  }

  var13 = 0;
  var14 = self._blackboard.shootparams_shotsperburst;
  var15 = var14 == 1 || self._blackboard.shootparams_style == "semi";
  var16 = isPlayer(self.enemy) && self.enemy isinvulnerable();
  var17 = scripts\anim\utility_common::weapon_pump_action_shotgun();
  var15 = 1;
  var18 = 0;

  while(var13 < var14 && var14 > 0) {
    if(var6) {
      if(var9[var18] > 0) {
        wait var9[var18];
      }

      var18 = (var18 + 1) % var9.size;
    }

    if(!self.bulletsinclip) {
      break;
    }

    scripts\asm\shoot\script_funcs::shootatshootentorpos(var15);

    if(var16) {
      if(randomint(3) == 0) {
        self.bulletsinclip--;
      }
    } else {
      self.bulletsinclip--;
    }

    if(var7) {
      self.rocketammo--;

      if(weaponclass(self.weapon) == "rocketlauncher" && self tagexists("tag_rocket")) {
        self hidepart("tag_rocket");
      }
    }

    var13++;

    if(var17) {
      childthread scripts\asm\shoot\script_funcs::shoot_shotgunpumpsound(var1);
    }

    if(self._blackboard.shootparams_fastburst && var13 == var14) {
      break;
    }

    if(!var6 || var14 == 1 && self._blackboard.shootparams_style == "single") {
      self waittillmatch(var1, "end");
    }
  }

  self notify(var5);
}

function shoot_setshootparameters() {
  var0 = self._blackboard.shootparams_shotsperburst;
  var1 = 2;

  if(self._blackboard.shootparams_style == "single" || var0 == 1 && self._blackboard.shootparams_style != "rack") {
    var0 = 1;
    var1 = 2;
  } else if(self._blackboard.shootparams_style == "semi") {
    var1 = 3;

    if(var0 == 1) {
      var1 = 2;
    } else if(var0 > 5) {
      var0 = 5;
    }
  } else if(self._blackboard.shootparams_style == "mg") {
    var1 = 2;
    var0 = 1;
  } else if(self._blackboard.shootparams_style == "rack" && self.currentpose != "prone") {
    var1 = 5;
  } else {
    var1 = 4;

    if(var0 > 6) {
      var0 = 6;
    }
  }

  self setupshootstyleadditive(var1, var0);
}

function shoot_clearshootparameters() {
  self setupshootstyleadditive(0, 0);
}

function shoot_generic(var0, var1, var2) {
  self endon(var1 + "_finished");
  self._blackboard.shoot_firstshot = 0;

  if(scripts\anim\utility_common::isasniper(1)) {
    scripts\asm\track::onsniperabouttofire();
  }

  self updateplayersightaccuracy();
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  var5 = scripts\engine\utility::ter_op(scripts\anim\utility_common::weapon_pump_action_shotgun(), 3, 2);

  if(self asmcurrentstatehasshootadditive(var0)) {
    shoot_setshootparameters();
    scripts\asm\shoot\script_funcs::shoot_donotetrackswithtimeout(var0, var1, var4, var5, "shoot_additive_fire");
  } else {
    shoot_clearshootparameters();

    if(isagent(self)) {
      shoot_doagentnotetrackswithtimeout(var0, var1, var4, var5);
    } else {
      var6 = scripts\asm\shoot\script_funcs::shoot_getrate();
      self setflaggedanimknobrestart(var1, var4, 1, 0.2, var6);
      scripts\asm\shoot\script_funcs::shoot_donotetrackswithtimeout(var0, var1, var4, 2);
    }
  }

  self._blackboard.shootparams_numburstsleft--;

  if(!scripts\asm\shoot\script_funcs::shootstylesingle()) {
    scripts\asm\shoot\script_funcs::shoot_stopsoundwithdelay(0.05);
  }

  scripts\asm\asm::asm_fireevent(var0, "shoot_finished");

  if(scripts\anim\utility_common::isasniper(1)) {
    scripts\asm\track::onsniperfired();
    return;
  }
}

function shoot_playidleanimloop_sniper(var0, var1, var2) {
  thread scripts\asm\shoot\script_funcs::handleburstdelay(var0, var1);

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  self.bshootidle = 1;
  scripts\asm\asm::asm_playadditiveanimloopstate(var0, var1, var2);
}

function shouldendsniperidle(var0, var1, var2, var3) {
  if(!shouldsniperidle(var0, var1, var2, var3)) {
    return true;
  }

  return false;
}

function shouldsniperidle(var0, var1, var2, var3) {
  if(!scripts\anim\utility_common::isasniper()) {
    return false;
  }

  if(scripts\asm\track::issniperconverging()) {
    return false;
  }

  return true;
}

function shouldsniperbeginfiring(var0, var1, var2, var3) {
  if(!scripts\anim\utility_common::isasniper()) {
    return scripts\asm\shoot\script_funcs::shouldbeginfiring(var0, var1, var2, var3);
  }

  if(scripts\asm\track::issniperconverging()) {
    return 0;
  }

  if(!scripts\asm\shoot\script_funcs::shouldbeginfiring(var0, var1, var2, var3)) {
    return 0;
  }

  return 1;
}

function shouldreacttonewenemy(var0, var1, var2, var3) {
  if(isDefined(self.stealth)) {
    self.newenemyreaction = 0;
    return false;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(isDefined(self.enemy.unittype) && self.enemy.unittype == "civilian") {
    return false;
  }

  if(!istrue(self.newenemyreaction) && !istrue(self.forcenewenemyreaction)) {
    return false;
  }

  if(isDefined(self.newenemyreactiontime) && gettime() - self.newenemyreactiontime > 1000) {
    self.forcenewenemyreaction = undefined;
    return false;
  }

  if(istrue(self.casualkiller)) {
    if(isDefined(level.casualkillernewenemyreaction) && gettime() < level.casualkillernewenemyreaction) {
      return false;
    }

    level.casualkillernewenemyreaction = gettime() + 5000;
  }

  return true;
}

function shouldcasualkillerreacttonewenemy(var0, var1, var2, var3) {
  if(istrue(self.casualkiller) && istrue(self.leavecasualkiller)) {
    var4 = shouldreacttonewenemy(var0, var1, var2, var3);

    if(istrue(var4)) {
      self clearbtgoal(2);
      return true;
    }
  }

  return false;
}

function terminate_newenemyreaction(var0, var1, var2) {
  self.newenemyreaction = 0;
  self.forcenewenemyreaction = undefined;
  self.stepoutyaw = undefined;
  popdisabledgunpose();

  if(istrue(self.leavecasualkiller)) {
    terminate_casualkiller(var0, var1, var2);
    return;
  }
}

function terminate_transitiontoexposedanim(var0, var1, var2) {
  terminate_newenemyreaction(var0, var1, var2);
  scripts\asm\soldier\cover::clearcoveranim(var0, var1, var2);
}

function getnewenemyreactangleindex(var0) {
  var0 = angleclamp180(var0);

  if(var0 > 135 || var0 < -135) {
    var1 = 2;
  } else if(var1 < -45) {
    var1 = 4;
  } else if(var1 > 45) {
    var1 = 6;
  } else {
    var1 = 8;
  }

  return var1;
}

function getnewenemyreactdirindex() {
  var0 = 0;
  var1 = self lastknownpos(self.enemy);
  var2 = var1 - self.origin;

  if(length2dsquared(var2) < 36) {
    var0 = 0;
  } else {
    var3 = vectortoyaw(var2);
    var0 = self.angles[1] - var3;
  }

  return getnewenemyreactangleindex(var0);
}

function getnewenemyreactalias() {
  var0 = getnewenemyreactdirindex();
  var1 = "" + var0;
  return var1;
}

function chooseanim_newenemyreaction(var0, var1, var2) {
  var3 = getnewenemyreactalias();
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function facegoalthread_newenemyreaction(var0, var1) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(var0 + "_finished");

  for(;;) {
    var2 = 0.25;
    var3 = angleclamp180(var1 - self.angles[1]);
    self orientmode("face angle", self.angles[1] + var3 * var2);
    waitframe();
  }
}

function handlefacegoalnotetrack_newenemyreaction(var0, var1, var2) {
  if(var1 == "face_goal") {
    var3 = var2 - self.origin;
    var4 = vectortoyaw(var3);
    thread facegoalthread_newenemyreaction(var0, var4);
    return true;
  }

  return false;
}

function playanim_newenemyreaction(var0, var1, var2) {
  self endon(var1 + "_finished");
  pushdisabledgunpose();
  var3 = self asmgetanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self aisetanim(var1, var3);
  var5 = self lastknownpos(self.enemy);
  thread playturnanim_turnanimanglefixup(var4, var1);
  scripts\asm\asm::asm_donotetrackswithinterceptor(var0, var1, &handlefacegoalnotetrack_newenemyreaction, var5);

  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    self.remainexposedendtime = gettime() + 2000;
    return;
  }
}

function chooseanimidle_interiorexterior(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var3, "idle")) {
    var4 = scripts\asm\asm::asm_getdemeanoranimoverride(var3, "idle");

    if(isarray(var4)) {
      return var4[randomint(var4.size)];
    }

    return var4;
  }

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over")) {
      var3 += "_high";
    }
  }

  if(istrue(self.uprightcqbidle)) {
    var3 += "_interior";

    if(!istrue(self._blackboard.hasplayedidleintro)) {
      var3 += "_intro";
      self._blackboard.hasplayedidleintro = 1;
    }
  }

  return scripts\asm\shared\utility::chooseanim_weaponclassprepended(var1, var2, var3);
}

function chooseanim_playerpushed(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");
  var4 = vectorNormalize(var3);
  var5 = vectortoangles(var4);
  var6 = angleclamp180(var5[1] - self.angles[1]);
  var7 = scripts\asm\soldier\move::yawdiffto2468(var6);
  var8 = "pushed_" + var7;
  var9 = scripts\asm\asm::asm_lookupanimfromalias(var1, var8);
  return var9;
}

function terminateidle(var0, var1, var2) {
  self._blackboard.hasplayedidleintro = undefined;
}

function shouldleavecasualkiller(var0, var1, var2, var3) {
  if(istrue(self.leavecasualkiller)) {
    if(needtoturn(var0, var1, var2, var3)) {
      return false;
    }

    if(isDefined(self.enemy)) {
      var4 = self.angles[1] - vectortoyaw(self.enemy.origin - self.origin);

      if(abs(angleclamp180(var4)) > 75) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function shouldleavecasualkillerimmediately(var0, var1, var2, var3) {
  if(istrue(self.leavecasualkiller)) {
    terminate_casualkiller(var0, var1, var3);
    return true;
  }

  return false;
}

function terminate_casualkiller(var0, var1, var2) {
  scripts\asm\shared\utility::setbasearchetype(scripts\asm\shared\utility::findoverridearchetype("default"));
  scripts\asm\shared\utility::clearoverridearchetype("casual_killer", 0, 1);
  self.newenemyreaction = 0;
  self.forcenewenemyreaction = undefined;
  self notify("leaveCasualKiller");
  self.leavecasualkiller = undefined;
  self.casualkiller = undefined;
  self setdefaultaimlimits();
}

function shoulddodge(var0, var1, var2, var3) {
  if(istrue(self.disabledodge)) {
    return false;
  }

  if(isDefined(self.dodgecooldown) && gettime() < self.dodgecooldown) {
    return false;
  }

  if(istrue(self.fixednode)) {
    return false;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(!issentient(self.enemy)) {
    return false;
  }

  if(!self issuppressed() && self canshootenemy()) {
    return false;
  }

  if(!self cansee(self.enemy)) {
    return false;
  }

  self.dodgecooldown = gettime() + randomintrange(4000, 7000);
  self.dodgeanim = "4";
  var4 = scripts\asm\asm::asm_getanim(var0, var2);
  var5 = scripts\asm\asm::asm_getxanim(var2, var4);
  var6 = getmovedelta(var5, 0, 1);
  self.dodgeanim = "6";
  var4 = scripts\asm\asm::asm_getanim(var0, var2);
  var5 = scripts\asm\asm::asm_getxanim(var2, var4);
  var7 = getmovedelta(var5, 0, 1);
  var6 = rotatevector(var6, self.angles);
  var7 = rotatevector(var7, self.angles);
  var8 = self.origin - self.enemy.origin;
  var9 = generateaxisanglesfromforwardvector(var8, self.enemy.angles);
  var10 = angleclamp180(var9[1] - self.enemy.angles[1]);

  if(abs(var10) > 4) {
    return false;
  }

  if(var10 > 0) {
    if(checkdodge(var7)) {
      self.dodgeanim = "6";
      return true;
    }
  } else if(checkdodge(var6)) {
    self.dodgeanim = "4";
    return true;
  }

  return false;
}

function checkdodge(var0) {
  var1 = self.origin + var0;

  if(!self isingoal(var1)) {
    return false;
  }

  if(!navisstraightlinereachable(self.origin, var1, self)) {
    return false;
  }

  var2 = self getapproxeyepos();
  var3 = var2 + var0;

  if(!sighttracepassed(var2, var3, 1, self)) {
    return false;
  }

  if(isai(self.enemy) && !isbot(self.enemy)) {
    var4 = self.enemy getapproxeyepos();
  } else {
    var4 = self.enemy getEye();
  }

  if(!sighttracepassed(var4, var4, 0, undefined)) {
    return false;
  }

  return true;
}

function chooseanim_dodge(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, self.dodgeanim);
}

function pushdisabledgunpose() {
  if(isDefined(self.gunposeoverride)) {
    self.stashedgunposeoverride = self.gunposeoverride;
  }

  self.gunposeoverride = "disable";
}

function popdisabledgunpose() {
  if(isDefined(self.stashedgunposeoverride)) {
    self.gunposeoverride = self.stashedgunposeoverride;
    self.stashedgunposeoverride = undefined;
    return;
  }

  self.gunposeoverride = undefined;
}
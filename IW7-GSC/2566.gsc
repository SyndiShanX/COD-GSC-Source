/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2566.gsc
*********************************************/

func_12E91(var_0) {
  scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.primaryweapon));
  func_12F28(var_0);
  var_1 = scripts\asm\asm::func_233E("ai_notify", "bulletwhizby");
  if(isDefined(var_1)) {
    if(!isDefined(self.disablebulletwhizbyreaction)) {
      var_2 = var_1.params[0];
      var_3 = isDefined(var_2) && distancesquared(self.origin, var_2.origin) < 160000;
      if(var_3 || scripts\engine\utility::cointoss()) {
        scripts\asm\asm_bb::bb_requestwhizby(var_1);
      }
    }
  } else {
    var_4 = 100;
    var_1 = scripts\asm\asm_bb::bb_getrequestedwhizby();
    if(!isDefined(var_1) || gettime() > var_1.var_7686 + var_4) {
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
    }
  }

  self.doentitiessharehierarchy = undefined;
  return level.success;
}

func_FFC8() {
  if(isDefined(self.var_7360)) {
    return self.var_7360;
  }

  return 0;
}

func_12E90(var_0) {
  if(!isalive(self)) {
    self.a.state = "death";
    return level.failure;
  }

  scripts\asm\asm_bb::bb_setisincombat(func_8BEC(undefined) == level.success);
  if(scripts\anim\utility_common::isasniper()) {
    self._blackboard.var_32D2 = 1;
  } else {
    self._blackboard.var_32D2 = undefined;
  }

  if(weaponclass(self.var_394) == "pistol") {
    lib_0A19::func_12F5C(var_0);
  }

  var_1 = func_7FD3();
  scripts\asm\asm_bb::bb_requestmovetype(var_1);
  if(scripts\asm\asm_bb::bb_moverequested()) {
    self.a.state = "move";
  } else if(isDefined(scripts\asm\asm_bb::bb_getcovernode())) {
    self.a.state = "cover";
  } else if(scripts\asm\asm_bb::bb_isincombat()) {
    self.a.state = "combat";
  } else {
    self.a.state = "stop";
  }

  return level.success;
}

func_12F64(var_0) {
  var_1 = scripts\asm\asm::func_233E("ai_notify", "bulletwhizby");
  if(isDefined(var_1) && isDefined(self.a)) {
    if(randomfloat(1) < self.a.reacttobulletchance) {
      scripts\asm\asm_bb::bb_requestwhizby(var_1);
    }
  } else {
    var_2 = 100;
    var_1 = scripts\asm\asm_bb::bb_getrequestedwhizby();
    if(!isDefined(var_1) || gettime() > var_1.var_7686 + var_2) {
      scripts\asm\asm_bb::bb_requestwhizby(undefined);
    }
  }

  return level.success;
}

func_12F28(var_0) {
  var_1 = self[[self.var_71A6]]();
  var_2 = scripts\asm\asm_bb::func_292C();
  var_3 = [];
  var_3["prone"] = 0;
  var_3["crouch"] = 1;
  var_3["stand"] = 2;
  var_4 = scripts\aitypes\bt_util::func_75();
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_2 = "stand";
  }

  if(!isDefined(var_1)) {
    var_1 = var_2;
  }

  if(var_4 == "casual" || var_4 == "casual_gun") {
    scripts\asm\asm_bb::bb_requestsmartobject("stand");
  } else if(var_1 == "prone" && self.unittype == "c6") {
    scripts\asm\asm_bb::bb_requestsmartobject("crouch");
  } else {
    if(var_3[var_1] < var_3[var_2]) {
      var_2 = var_1;
    } else if(var_2 == "crouch" && var_3[var_1] > var_3["crouch"]) {
      if(scripts\asm\asm_bb::bb_isinbadcrouchspot()) {
        var_2 = "stand";
      }
    }

    scripts\asm\asm_bb::bb_requestsmartobject(var_2);
  }

  return level.success;
}

func_12E93(var_0) {
  if(!isDefined(self.var_71D5)) {
    return level.success;
  }

  var_1 = self[[self.var_71D5]]();
  return var_1;
}

func_7FD3() {
  var_0 = self[[self.var_71A8]]();
  return var_0;
}

func_9E40(var_0) {
  return func_8BEC(var_0);
}

func_8BEC(var_0) {
  if(isDefined(self.isnodeoccupied)) {
    return level.success;
  }

  return level.failure;
}

func_8C0B(var_0) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(self getpersstat(self.isnodeoccupied)) {
    return level.success;
  }

  return level.failure;
}

hasammoinclip() {
  var_0 = makescrambler();
  if(isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(self.var_394)) {
    return 0;
  }

  if(self.bulletsinclip > 0 || isDefined(self.var_C08B)) {
    return 1;
  }

  return 0;
}

func_8BC6(var_0) {
  if(hasammoinclip()) {
    return level.success;
  }

  return level.failure;
}

func_9E8B(var_0, var_1) {
  if(scripts\anim\utility_common::needtoreload(var_1)) {
    return level.success;
  }

  return level.failure;
}

func_13D98(var_0, var_1) {
  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(distancesquared(self.origin, self.isnodeoccupied.origin) <= var_1 * var_1) {
    return level.success;
  }

  return level.failure;
}

func_8BF6(var_0) {
  if(self.objective_state > 0) {
    return level.success;
  }

  return level.failure;
}

func_8C24(var_0) {
  if(isDefined(self.objective_team) && self.objective_team == "seeker") {
    if(self.objective_state > 0) {
      return level.success;
    }
  }

  return level.failure;
}

func_B4EB(var_0) {
  if(!isDefined(self.var_394)) {
    return level.failure;
  }

  if(!shouldshoot()) {
    return level.failure;
  }

  return level.success;
}

func_12EC2(var_0) {
  if(!isDefined(self.doentitiessharehierarchy) || self.doentitiessharehierarchy != self.isnodeoccupied) {
    self.doentitiessharehierarchy = self.isnodeoccupied;
  }

  return level.success;
}

func_FE5A(var_0) {
  var_0.var_29AF = undefined;
}

func_FE5D(var_0) {
  var_0.var_29AF = 1;
}

func_FE6E(var_0) {
  self.bt.shootparams = spawnStruct();
  self.bt.shootparams.taskid = var_0;
  self.bt.shootparams.starttime = gettime();
  self.bt.m_bfiring = 0;
  self.doentitiessharehierarchy = self.isnodeoccupied;
  self.var_299D = self.isnodeoccupied;
  var_1 = scripts\anim\utility_common::isasniper();
  if(var_1) {
    func_FE5D(self.bt.shootparams);
    self.var_103BF = 0;
    self.var_103BA = 0;
  }
}

func_FE83(var_0) {
  if(isDefined(self.bt.shootparams) && self.bt.shootparams.taskid == var_0) {
    self.bt.shootparams = undefined;
  }

  self.bt.m_bfiring = 0;
  self.var_299D = undefined;
  scripts\asm\asm_bb::bb_requestfire(0);
}

isaimedataimtarget() {
  if(isDefined(self.var_71AE)) {
    return self[[self.var_71AE]]();
  }

  return 0;
}

resetmisstime_code() {
  if(isDefined(self.var_71CA)) {
    return self[[self.var_71CA]]();
  }
}

_meth_811C() {
  if(isDefined(self.var_71A9)) {
    return self[[self.var_71A9]]();
  }

  return 0;
}

_meth_81E2(var_0) {
  if(isDefined(self.var_71AA)) {
    return self[[self.var_71AA]](var_0);
  }

  return 0;
}

func_FE88(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("shoot", "shoot_finished")) {
    return level.success;
  }

  var_1 = self.bt.shootparams;
  var_2 = makescrambler();
  if(isDefined(self.isnodeoccupied) && !isplayer(self.isnodeoccupied) && var_1.starttime < gettime()) {
    var_3 = int(gettime() / 50);
    if(self getentitynumber() % 4 != var_3 % 4) {
      return level.running;
    }
  }

  if(isDefined(var_2)) {
    var_4 = _meth_81E2(var_2);
    var_5 = anglesToForward(var_4);
    var_5 = rotatevector(var_5, self.angles);
    var_6 = _meth_811C();
    var_1.pos = var_6 + var_5 * 512;
    var_1.ent = undefined;
  } else if(isDefined(self.goodshootpos)) {
    var_1.pos = self.goodshootpos;
    var_1.ent = undefined;
  } else if(self getpersstat(self.isnodeoccupied)) {
    var_1.pos = self.isnodeoccupied getshootatpos();
    var_1.ent = self.isnodeoccupied;
  } else {
    return level.success;
  }

  if(!isDefined(var_1.objective)) {
    var_1.objective = "normal";
  }

  scripts\asm\asm_bb::bb_setshootparams(var_1, self.isnodeoccupied);
  if(isaimedataimtarget()) {
    if(!self.bt.m_bfiring) {
      resetmisstime_code();
      chooseshootstyle(var_1);
      choosenumshotsandbursts(var_1);
    }

    func_3EF8(var_1);
    self.bt.m_bfiring = 1;
  } else {
    self.bt.m_bfiring = 0;
  }

  if(!isDefined(var_1.pos) && !isDefined(var_1.ent)) {
    return level.success;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return level.running;
}

func_8BCE(var_0) {
  if(self.var_394 == "none") {
    return 0;
  }

  return self.bulletsinclip >= weaponclipsize(self.var_394) * var_0;
}

func_43EB(var_0) {
  if(!isDefined(self.var_394) || self.var_394 == "none") {
    return level.failure;
  }

  if(!isDefined(self.isnodeoccupied)) {
    if(!func_8BCE(0.5)) {
      return level.success;
    }
  }

  if(!hasammoinclip()) {
    return level.success;
  }

  if(func_8BCE(0.1)) {
    return level.failure;
  }

  if(isDefined(self.vehicle_getspawnerarray)) {
    if(isDefined(self.var_C0A0) && self.var_C0A0) {
      return level.failure;
    }

    if(isDefined(self.var_C0AD) && self.var_C0AD) {
      return level.failure;
    }

    if(!scripts\anim\utility_common::usingriflelikeweapon()) {
      return level.failure;
    }

    if(self pathdisttogoal() < 256) {
      return level.failure;
    }
  }

  if(isDefined(self.isnodeoccupied) && isDefined(self.var_101B4) && !scripts\engine\utility::istrue(self.var_C009)) {
    var_1 = 409;
    var_2 = distancesquared(self.origin, self.isnodeoccupied.origin);
    if(var_2 < var_1 * var_1) {
      return level.failure;
    }
  }

  return level.success;
}

func_DF53(var_0) {
  scripts\asm\asm_bb::bb_requestreload(1);
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].var_2AB1 = isDefined(self.vehicle_getspawnerarray);
  self.bt.instancedata[var_0].timeout = gettime() + 5000;
}

func_DF55(var_0) {
  scripts\asm\asm_bb::bb_requestreload(0);
  self.bt.instancedata[var_0] = undefined;
}

func_DF4E() {
  var_0 = weaponclipsize(self.var_394);
  self.bulletsinclip = int(var_0 * 0.5);
  self.bulletsinclip = int(clamp(self.bulletsinclip, 0, var_0));
}

func_DF56(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("reload", "end")) {
    return level.success;
  }

  if(gettime() > self.bt.instancedata[var_0].timeout) {
    return level.success;
  }

  var_1 = weaponclipsize(self.var_394);
  var_2 = isDefined(self._blackboard.var_32D2);
  if(!var_2 && self.bulletsinclip == var_1) {
    return level.success;
  }

  if(isDefined(self.var_C08B)) {
    func_DF4E();
    return level.success;
  }

  if(isDefined(self.vehicle_getspawnerarray) && !self.livestreamingenable && !scripts\engine\utility::actor_is3d()) {
    func_DF4E();
    return level.success;
  }

  var_3 = self.bt.instancedata[var_0].var_2AB1;
  if(!var_3 && isDefined(self.vehicle_getspawnerarray)) {
    func_DF4E();
    return level.success;
  }

  return level.running;
}

chooseshootstyle(var_0) {
  var_1 = -3036;
  var_2 = 810000;
  var_3 = 2560000;
  var_4 = weaponclass(self.var_394);
  var_5 = makescrambler();
  var_6 = isDefined(var_5);
  if(isDefined(self.bt.var_FEDB)) {
    var_7 = 0;
    if(isDefined(self.bt.var_FED8)) {
      var_7 = self.bt.var_FED8;
    }

    return func_F840(var_0, self.bt.var_FEDB, var_7);
  }

  if(var_5 == "mg" || var_7) {
    return func_F840(var_1, "mg", 0);
  }

  if(isDefined(var_1.ent) && isDefined(var_1.ent.isnodeoccupied) && isDefined(var_1.ent.isnodeoccupied.physics_setgravityragdollscalar)) {
    return func_F840(var_1, "single", 0);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return func_F840(var_1, "single", 0);
  }

  if(var_5 == "rocketlauncher" || var_5 == "pistol") {
    return func_F840(var_1, "single", 0);
  }

  if(scripts\anim\utility_common::isshotgun(self.var_394)) {
    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      return func_F840(var_1, "single", 0);
    } else {
      return func_F840(var_1, "semi", 0);
    }
  }

  if(var_5 == "grenade") {
    return func_F840(var_1, "single", 0);
  }

  if(weaponburstcount(self.var_394) > 0) {
    return func_F840(var_1, "burst", 0);
  }

  var_8 = distancesquared(self getshootatpos(), var_1.pos);
  if(var_8 < var_2) {
    if(isDefined(var_1.ent) && isDefined(var_1.ent.var_B14F)) {
      return func_F840(var_1, "single", 0);
    } else {
      return func_F840(var_1, "full", 0);
    }
  } else if(var_8 < var_3 || func_FFC6()) {
    if(weaponissemiauto(self.var_394) || func_FFF6()) {
      return func_F840(var_1, "semi", 1);
    } else {
      return func_F840(var_1, "burst", 1);
    }
  } else if(self.assertmsg || var_8 < var_4) {
    if(func_FFF6()) {
      return func_F840(var_1, "semi", 0);
    } else {
      return func_F840(var_1, "burst", 0);
    }
  }

  return func_F840(var_1, "single", 0);
}

func_F840(var_0, var_1, var_2) {
  var_0.var_1119D = var_1;
  var_0.var_6B92 = var_2;
}

func_FFC6() {
  if(!isDefined(level.var_7683)) {
    return 0;
  }

  return level.var_7683 == 3 && isplayer(self.isnodeoccupied);
}

func_FFF6() {
  if(weaponclass(self.var_394) != "rifle") {
    return 0;
  }

  if(self.team != "allies") {
    return 0;
  }

  var_0 = scripts\anim\utility_common::safemod(int(self.origin[1]), 10000) + 2000;
  var_1 = int(self.origin[0]) + gettime();
  return var_1 % 2 * var_0 > var_0;
}

makescrambler() {
  if(isDefined(self.var_71AB)) {
    return [[self.var_71AB]]();
  }
}

func_4F68() {
  var_0 = makescrambler();
  var_1 = isDefined(var_0);
  if(var_1 && isDefined(var_0.var_ED26)) {
    var_2 = var_0.var_ED26;
  } else {
    var_2 = 0.5;
  }

  if(var_1 && isDefined(var_0.var_ED25)) {
    var_3 = var_0.var_ED25 - var_2;
  } else {
    var_3 = 1.5;
  }

  var_4 = var_2 + randomfloat(var_3);
  return int(var_4 * 10);
}

func_4F66() {
  if(isDefined(self.var_71A0)) {
    return [[self.var_71A0]]();
  }
}

choosenumshotsandbursts(var_0) {
  if(isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) > 160000) {
    var_0.var_32BD = randomintrange(1, 5);
  } else {
    var_0.var_32BD = 10;
  }

  if(var_0.var_1119D == "full") {
    var_0.var_FF0B = func_4F66();
    return;
  }

  if(var_0.var_1119D == "burst" || var_0.var_1119D == "semi") {
    var_0.var_FF0B = func_4F65(var_0);
    return;
  }

  if(var_0.var_1119D == "single") {
    var_0.var_FF0B = 1;
    return;
  }

  if(var_0.var_1119D == "mg") {
    var_0.var_FF0B = func_4F68();
    return;
  }
}

func_4F65(var_0) {
  var_1 = 0;
  var_2 = weaponburstcount(self.var_394);
  if(var_2) {
    var_1 = var_2;
  } else if(scripts\anim\weaponlist::usingsemiautoweapon()) {
    var_1 = level.var_F217[randomint(level.var_F217.size)];
  } else if(var_0.var_6B92) {
    var_1 = level.var_6B93[randomint(level.var_6B93.size)];
  } else {
    var_1 = level.var_32BF[randomint(level.var_32BF.size)];
  }

  if(var_1 <= self.bulletsinclip) {
    return var_1;
  }

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

shouldshoot() {
  if(isDefined(self.dontevershoot) && self.dontevershoot) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(self.bulletsinclip == 0) {
    return 0;
  }

  if(!isDefined(self.var_394) || self.var_394 == "") {
    return 0;
  }

  if(self getpersstat(self.isnodeoccupied)) {
    scripts\anim\utility_common::dontgiveuponsuppressionyet();
    self.goodshootpos = self.isnodeoccupied getshootatpos();
    return 1;
  }

  return scripts\anim\utility_common::cansuppressenemy();
}

func_3EF8(var_0) {
  if(isDefined(self.var_FED1)) {
    if(!isDefined(self.isnodeoccupied)) {
      var_0.pos = self.var_FED1;
      self.var_FED1 = undefined;
    } else {
      self.var_FED1 = undefined;
    }
  }

  var_1 = func_FECA(var_0);
  if(isDefined(var_1) && var_1 == "retry") {
    var_1 = func_FECA(var_0);
  }
}

func_FECA(var_0) {
  if(var_0.objective == "normal") {
    var_1 = func_FECB(var_0);
    return var_1;
  }

  if(scripts\anim\utility_common::shouldshootenemyent()) {
    var_1.objective = "normal";
    return "retry";
  }

  var_2 = scripts\anim\utility_common::cansuppressenemy();
  if(var_1.objective == "suppress" || self.team == "allies" && !isDefined(self.isnodeoccupied) && !var_2) {
    func_FECC(var_1, var_2);
  }
}

func_FECB(var_0) {
  if(!scripts\anim\utility_common::shouldshootenemyent()) {
    if(!isDefined(self.isnodeoccupied)) {
      func_8C4D(var_0);
      return;
    }

    if((self.assertmsg || randomint(5) > 0) && func_100A4()) {
      var_0.objective = "suppress";
    } else {
      var_0.objective = "ambush";
    }

    return "retry";
  }

  func_F83F(var_0);
}

func_100A4() {
  return 1;
}

func_F83F(var_0) {
  var_0.ent = self.isnodeoccupied;
  var_0.pos = var_0.ent getshootatpos();
}

func_FECC(var_0, var_1) {
  if(!var_1) {
    func_8C4D(var_0);
    return;
  }

  var_0.ent = undefined;
  var_0.pos = func_7E90();
}

func_7E90() {
  return self.goodshootpos;
}

func_8C4D(var_0) {
  var_0.ent = undefined;
  var_0.pos = undefined;
  var_0.var_1119D = "none";
  if(self.var_FC) {
    var_0.objective = "ambush";
  }
}

func_10026() {
  if(level.var_18D5[self.team] > 0 && level.var_18D5[self.team] < level.var_18D6) {
    if(gettime() - level.var_A936[self.team] > 4000) {
      return 0;
    }

    var_0 = level.var_A933[self.team];
    if(var_0 == self) {
      return 0;
    }

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;
    if((var_1 || distancesquared(self.origin, level.var_A935[self.team]) < 65536) && !isDefined(self.isnodeoccupied) || distancesquared(self.isnodeoccupied.origin, level.var_A934[self.team]) < 262144) {
      return 1;
    }
  }

  return 0;
}

func_FFC2() {
  if(self.logstring) {
    return 0;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  if(weaponclass(self.var_394) == "mg") {
    return 0;
  }

  if(self.var_BC == "ambush" || self.var_BC == "ambush_nodes_only") {
    return 0;
  }

  if(isDefined(self.bt.var_C2)) {
    return 0;
  }

  if(isDefined(self.script) && self.script == "cover_arrival") {
    return 0;
  }

  var_0 = vectornormalize(self.isnodeoccupied.origin - self.origin);
  var_1 = anglesToForward(self.angles);
  if(vectordot(var_0, var_1) < 0.5) {
    return 0;
  }

  if(self getpersstat(self.isnodeoccupied) && self canshootenemy()) {
    return 0;
  }

  return 1;
}

func_2544(var_0) {
  self.bt.instancedata[var_0] = 0;
}

func_2542(var_0) {
  if(isDefined(self.var_7196)) {
    return self[[self.var_7196]](var_0);
  }

  return level.failure;
}

func_2545(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

func_93B6(var_0) {
  if(self _meth_8531()) {
    return level.success;
  }

  return level.failure;
}

func_2753(var_0) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return level.failure;
  }

  var_1 = self _meth_8530(128);
  if(isDefined(var_1)) {
    self _meth_8481(var_1);
    self._blackboard.var_2754 = gettime();
    return level.success;
  }

  return level.failure;
}

func_1384E(var_0) {
  var_1 = gettime();
  if(var_1 > self._blackboard.var_2754 + 100 && !isDefined(self.vehicle_getspawnerarray)) {
    return level.failure;
  }

  if(var_1 > self._blackboard.var_2754 + 5000) {
    return level.failure;
  }

  return level.running;
}

func_275A(var_0) {
  self _meth_8484();
  self._blackboard.var_2754 = undefined;
}

func_24D4(var_0) {
  if(!isDefined(self.var_F126)) {
    return level.failure;
  }

  if(self.precacheleaderboards) {
    return level.failure;
  }

  var_1 = distancesquared(self.var_F126.origin, self.origin);
  if(self getpersstat(self.var_F126) && var_1 < 122500) {
    return level.success;
  }

  if(var_1 < 22500) {
    return level.success;
  }

  return level.failure;
}

func_E84E(var_0) {
  func_FE6E(var_0);
  self.var_C3BB = self.loadstartpointtransients;
  self.var_C3B6 = self.var_BC;
  self.loadstartpointtransients = self.var_F126;
  self.doentitiessharehierarchy = self.var_F126;
  self.var_299D = self.var_F126;
  self.var_F126.bt.var_1152B = 1;
}

func_13132(var_0) {
  switch (var_0) {
    case "w2":
    case "w1":
    case "w0":
    case "omr":
    case "slt":
    case "5":
    case "4":
    case "3":
    case "2":
    case "0":
    case "1":
      return 1;
  }

  return 0;
}

func_E84D(var_0) {
  if(!isDefined(self.var_F126)) {
    return level.failure;
  }

  if(self.unittype == "soldier") {
    var_1 = self.var_F126.origin;
    var_2 = vectornormalize(self.origin - var_1);
    var_3 = self.origin + var_2 * 200;
    var_4 = getclosestpointonnavmesh(var_3);
    self.var_BC = "no_cover";
    self _meth_8481(var_4);
  } else {
    self.var_BC = "no_cover";
    self _meth_8481(self.origin);
  }

  if(!isDefined(self.loadstartpointtransients) || !isalive(self.loadstartpointtransients) || self.loadstartpointtransients != self.var_F126) {
    return level.success;
  }

  if(!isDefined(self.isnodeoccupied) || self.isnodeoccupied != self.loadstartpointtransients) {
    return level.running;
  }

  var_5 = self.bt.shootparams;
  if(self getpersstat(self.isnodeoccupied)) {
    var_5.pos = self.isnodeoccupied getshootatpos();
    var_5.ent = self.isnodeoccupied;
  } else {
    return level.running;
  }

  if(!isDefined(self.var_F184)) {
    self.var_F184 = 1;
    if(isDefined(self.var_46BC) && isDefined(self.npcid) && self.var_46BC == "UN" || self.var_46BC == "SD") {
      if(func_13132(self.npcid)) {
        var_6 = self.var_46BC + "_" + self.npcid + "_reaction_seeker_attack";
        self playSound(var_6);
      }
    }

    func_DF4E();
  }

  if(!isDefined(var_5.objective)) {
    var_5.objective = "normal";
  }

  scripts\asm\asm_bb::bb_setshootparams(var_5, self.isnodeoccupied);
  if(isaimedataimtarget()) {
    if(!self.bt.m_bfiring) {
      resetmisstime_code();
      chooseshootstyle(var_5);
      choosenumshotsandbursts(var_5);
    }

    func_3EF8(var_5);
    self.bt.m_bfiring = 1;
  } else {
    self.bt.m_bfiring = 0;
  }

  if(!isDefined(var_5.pos) && !isDefined(var_5.ent)) {
    return level.success;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return level.running;
}

func_E84F(var_0) {
  self _meth_8484();
  self.loadstartpointtransients = self.var_C3BB;
  self.var_C3BB = undefined;
  self.var_BC = self.var_C3B6;
  self.var_C3B6 = undefined;
  self.var_F184 = undefined;
  func_FE83(var_0);
}

func_12A82(var_0) {
  if(isDefined(scripts\asm\asm_bb::bb_getrequestedturret())) {
    return level.success;
  }

  return level.failure;
}

_meth_8082() {
  var_0 = self getEye();
  foreach(var_2 in level.players) {
    if(!self getpersstat(var_2)) {
      continue;
    }

    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);
    if(var_8 < 0.805) {
      continue;
    }

    if(scripts\engine\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }

    return var_2;
  }

  return undefined;
}

func_12F1D(var_0) {
  if(self.team != "axis") {
    return level.success;
  }

  if(isDefined(self.var_5583) && self.var_5583) {
    return level.success;
  }

  if(!scripts\anim\utility_common::isasniper()) {
    return level.success;
  }

  var_1 = level.var_7649["sniper_glint"];
  if(!isDefined(var_1)) {
    return level.success;
  }

  if(!isDefined(self.var_BF5C)) {
    self.var_BF5C = gettime() + randomintrange(3000, 5000);
  }

  if(!isDefined(self.isnodeoccupied) || !isalive(self.isnodeoccupied)) {
    return level.success;
  }

  if(gettime() < self.var_BF5C) {
    return level.success;
  }

  self.var_BF5C = gettime() + 200;
  if(self.var_394 != self.primaryweapon) {
    return level.success;
  }

  var_2 = _meth_8082();
  if(!isDefined(var_2)) {
    return level.success;
  }

  if(distancesquared(self.origin, var_2.origin) < 65536) {
    return level.success;
  }

  if(scripts\asm\asm_bb::func_2985() && isDefined(self._blackboard.shootparams.pos)) {
    var_3 = self _meth_853C();
    var_4 = vectornormalize(self._blackboard.shootparams.pos - self getEye());
    var_5 = vectordot(var_3, var_4);
    if(var_5 < 0.906) {
      self.var_BF5C = undefined;
      return level.success;
    }
  } else {
    self.var_BF5C = undefined;
    return level.success;
  }

  playFXOnTag(var_1, self, "tag_flash");
  self.var_BF5C = gettime() + randomintrange(3000, 5000);
  return level.success;
}
/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2568.gsc
************************/

func_97EC(var_0) {
  self.var_71A8 = ::func_7FD3;
  self.var_71AE = ::isaimedataimtarget;
  self.var_71CA = ::resetmisstime_code;
  self.var_71A9 = ::_meth_811D;
  self.var_71AA = ::_meth_81E3;
  self.var_71A0 = ::func_4F67;
  self.var_71AB = ::makescrambler;
  self.var_71A6 = ::func_7EFC;
  self.var_7196 = ::func_2542;
  self.var_71BD = ::func_129AD;
  self.var_71BC = ::func_129AA;
  self.var_71CB = ::saygenericdialogue;
  self.var_71D5 = ::func_12E93;
  self.var_71C7 = ::scripts\sp\utility::func_D022;
  return level.success;
}

func_103F5(var_0) {
  if(isDefined(self.var_4D5D)) {
    lib_0A15::setupdestructibledoors();
    thread lib_0A1E::func_111A9();
    self.var_719D = ::func_103F3;
    self.var_8E1E = 1;
  }

  return level.success;
}

resetmisstime_code() {
  scripts\sp\gameskill::resetmisstime_code();
}

func_7FD3() {
  if(isDefined(self.var_10AB7) && self.var_10AB7) {
    return "sprint";
  }

  if(scripts\anim\utility::func_FFDB()) {
    return "cqb";
  }

  if(isDefined(self.var_527B)) {
    return self.var_527B;
  }

  var_0 = scripts\aitypes\bt_util::func_75();
  return var_0;
}

isaimedataimtarget() {
  return lib_0A2B::func_1A3A();
}

func_129AD() {
  self _meth_81D6();
}

func_129AA() {
  self _meth_81D5();
}

saygenericdialogue(var_0) {
  scripts\anim\face::saygenericdialogue(var_0);
}

_meth_811D() {
  return scripts\anim\shared::_meth_811C();
}

_meth_81E3(var_0) {
  return var_0 _meth_851F();
}

func_4F67() {
  return scripts\anim\shared::func_4F66();
}

func_7EFC() {
  var_0 = undefined;
  var_1 = 1;
  var_2 = 1;
  var_3 = 1;
  if(isDefined(self.target_getindexoftarget) && scripts\asm\shared_utility::isatcovernode()) {
    var_1 = self.target_getindexoftarget getrandomattachments("stand");
    var_2 = self.target_getindexoftarget getrandomattachments("crouch");
    var_3 = self.target_getindexoftarget getrandomattachments("prone");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
    var_4 = distancesquared(self.origin, self._blackboard.shootparams.pos);
    if(var_4 > 262144 && self getteleportlonertargetplayer("crouch") && !scripts\engine\utility::actor_is3d() && !scripts\anim\utility_common::isusingsidearm()) {
      if(sighttracepassed(self.origin + (0, 0, 32), self._blackboard.shootparams.pos, 0, undefined)) {
        return "crouch";
      }
    }
  }

  for(;;) {
    if(self getteleportlonertargetplayer("stand") && var_1) {
      return "stand";
    }

    if(self getteleportlonertargetplayer("crouch") && var_2) {
      return "crouch";
    }

    if(self getteleportlonertargetplayer("prone") && var_3) {
      return "prone";
    }

    if(!var_1 || !var_2 || !var_3) {
      var_1 = 1;
      var_2 = 1;
      var_3 = 1;
      continue;
    }

    break;
  }

  return "crouch";
}

func_3DE5() {
  if(!isDefined(level.var_A936[self.team])) {
    return 0;
  }

  if(scripts\aitypes\combat::func_10026()) {
    return 1;
  }

  if(gettime() - level.var_A936[self.team] < level.var_18D7) {
    return 0;
  }

  if(!issentient(self.isnodeoccupied)) {
    return 0;
  }

  if(level.var_18D5[self.team]) {
    level.var_18D5[self.team] = 0;
  }

  var_0 = isDefined(self.var_18CC) && self.var_18CC;
  if(!var_0 && getaicount(self.team) < getaicount(self.isnodeoccupied.team)) {
    return 0;
  }

  return 1;
}

func_2543() {
  if(!self _meth_81A5(self.isnodeoccupied.origin)) {
    return 0;
  }

  if(scripts\anim\utility_common::islongrangeai()) {
    return 0;
  }

  if(!func_3DE5()) {
    return 0;
  }

  self getrelativeteam(0);
  if(self _meth_8254()) {
    self.sendmatchdata = 0;
    self.sendclientmatchdata = 0;
    if(level.var_18D5[self.team] == 0) {
      level.var_A936[self.team] = gettime();
      level.var_A933[self.team] = self;
    }

    level.var_A935[self.team] = self.origin;
    level.var_A934[self.team] = self.isnodeoccupied.origin;
    level.var_18D5[self.team]++;
    return 1;
  }

  return 0;
}

func_2542(var_0) {
  if(!scripts\aitypes\combat::func_FFC2()) {
    return level.failure;
  }

  switch (self.bt.instancedata[var_0]) {
    case 0:
      if(self getzonearray(32)) {
        return level.success;
      }
      break;

    case 3:
      if(self getzonearray(64)) {
        return level.success;
      }
      break;

    case 7:
      if(self getzonearray(96)) {
        return level.success;
      }
      break;

    case 11:
      if(func_2543()) {
        return level.success;
      }
      break;

    case 15:
      self _meth_80EC();
      break;
  }

  self.bt.instancedata[var_0]++;
  if(self.bt.instancedata[var_0] > 60) {
    self.bt.instancedata[var_0] = 0;
  }

  return level.running;
}

makescrambler() {
  return self _meth_8164();
}

func_12E93() {
  if(self.unittype == "c6i" || scripts\engine\utility::actor_is3d() || self.team == "neutral") {
    return level.success;
  }

  var_0 = gettime();
  if(!isDefined(self._blackboard.var_7362) || self._blackboard.var_7362 > var_0) {
    var_1 = getaiarray(scripts\engine\utility::get_enemy_team(self.team));
    var_2 = 0;
    var_3 = 10000;
    var_4 = 4194304;
    var_5 = 5;
    self._blackboard.var_7362 = var_0 + 10000;
    self._blackboard.var_7366 = "combat";
    foreach(var_7 in var_1) {
      var_8 = distancesquared(self lastknownpos(var_7), self.origin);
      if(var_8 > var_4) {
        continue;
      }

      var_9 = gettime() - self lastknowntime(var_7);
      if(var_9 > var_3) {
        continue;
      }

      var_2++;
      if(var_7.unittype == "c8" || var_7.unittype == "c12") {
        self._blackboard.var_7366 = "frantic";
        break;
      }

      if(var_2 >= 3) {
        self._blackboard.var_7366 = "frantic";
        break;
      }
    }
  }

  return level.success;
}

func_103F3(var_0) {
  switch (var_0.updategamerprofileall) {
    case "helmet":
      if(isDefined(self.var_C065) && self.var_C065) {}

      if(isDefined(self.var_C554) && self.var_C554) {}

      lib_0C60::func_8E17();
      break;
  }
}
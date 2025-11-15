/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2568.gsc
************************/

func_97EC(param_00) {
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

func_103F5(param_00) {
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

  var_00 = scripts\aitypes\bt_util::func_75();
  return var_00;
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

saygenericdialogue(param_00) {
  scripts\anim\face::saygenericdialogue(param_00);
}

_meth_811D() {
  return scripts\anim\shared::_meth_811C();
}

_meth_81E3(param_00) {
  return param_00 _meth_851F();
}

func_4F67() {
  return scripts\anim\shared::func_4F66();
}

func_7EFC() {
  var_00 = undefined;
  var_01 = 1;
  var_02 = 1;
  var_03 = 1;
  if(isDefined(self.target_getindexoftarget) && scripts\asm\shared_utility::isatcovernode()) {
    var_01 = self.target_getindexoftarget getrandomattachments("stand");
    var_02 = self.target_getindexoftarget getrandomattachments("crouch");
    var_03 = self.target_getindexoftarget getrandomattachments("prone");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.pos)) {
    var_04 = distancesquared(self.origin, self.var_1198.shootparams.pos);
    if(var_04 > 262144 && self getteleportlonertargetplayer("crouch") && !scripts\engine\utility::actor_is3d() && !scripts\anim\utility_common::isusingsidearm()) {
      if(sighttracepassed(self.origin + (0, 0, 32), self.var_1198.shootparams.pos, 0, undefined)) {
        return "crouch";
      }
    }
  }

  for(;;) {
    if(self getteleportlonertargetplayer("stand") && var_01) {
      return "stand";
    }

    if(self getteleportlonertargetplayer("crouch") && var_02) {
      return "crouch";
    }

    if(self getteleportlonertargetplayer("prone") && var_03) {
      return "prone";
    }

    if(!var_01 || !var_02 || !var_03) {
      var_01 = 1;
      var_02 = 1;
      var_03 = 1;
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

  var_00 = isDefined(self.var_18CC) && self.var_18CC;
  if(!var_00 && getaicount(self.team) < getaicount(self.isnodeoccupied.team)) {
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

func_2542(param_00) {
  if(!scripts\aitypes\combat::func_FFC2()) {
    return level.failure;
  }

  switch (self.var_3135.instancedata[param_00]) {
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

  self.var_3135.instancedata[param_00]++;
  if(self.var_3135.instancedata[param_00] > 60) {
    self.var_3135.instancedata[param_00] = 0;
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

  var_00 = gettime();
  if(!isDefined(self.var_1198.var_7362) || self.var_1198.var_7362 > var_00) {
    var_01 = getaiarray(scripts\engine\utility::get_enemy_team(self.team));
    var_02 = 0;
    var_03 = 10000;
    var_04 = 4194304;
    var_05 = 5;
    self.var_1198.var_7362 = var_00 + 10000;
    self.var_1198.var_7366 = "combat";
    foreach(var_07 in var_01) {
      var_08 = distancesquared(self lastknownpos(var_07), self.origin);
      if(var_08 > var_04) {
        continue;
      }

      var_09 = gettime() - self lastknowntime(var_07);
      if(var_09 > var_03) {
        continue;
      }

      var_02++;
      if(var_07.unittype == "c8" || var_07.unittype == "c12") {
        self.var_1198.var_7366 = "frantic";
        break;
      }

      if(var_02 >= 3) {
        self.var_1198.var_7366 = "frantic";
        break;
      }
    }
  }

  return level.success;
}

func_103F3(param_00) {
  switch (param_00.updategamerprofileall) {
    case "helmet":
      if(isDefined(self.var_C065) && self.var_C065) {}

      if(isDefined(self.var_C554) && self.var_C554) {}

      lib_0C60::func_8E17();
      break;
  }
}
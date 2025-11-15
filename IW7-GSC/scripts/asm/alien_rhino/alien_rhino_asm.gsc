/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\alien_rhino\alien_rhino_asm.gsc
*******************************************************/

asminit(param_00, param_01, param_02, param_03) {
  scripts\asm\zombie\zombie::func_13F9A(param_00, param_01, param_02, param_03);
  self.fnactionvalidator = ::isvalidaction;
  scripts\asm\dlc4\dlc4_asm::analyzeanims();
  analyzerhinoanims();
}

analyzerhinoanims() {
  var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(isDefined(var_00.chargeintroanimtimes)) {
    return;
  }

  var_00.chargeintroanimtimes = [];
  var_01 = self getanimentrycount("charge_intro");
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = self getsafecircleorigin("charge_intro", var_02);
    var_00.chargeintroanimtimes[var_02] = getanimlength(var_03);
  }
}

isvalidaction(param_00) {
  switch (param_00) {
    case "charge":
    case "jump_attack":
    case "stand_melee":
    case "jump":
    case "moving_melee":
    case "taunt":
      return 1;
  }

  return 0;
}

shouldplayentranceanim(param_00, param_01, param_02, param_03) {
  return 0;
}

onbigslam() {
  self notify("attack_hit_big");
  var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  radiusdamage(self.origin, var_00.big_slam_radius, var_00.big_slam_max_damage, var_00.big_slam_min_damage, self);
}

onsmallslam() {
  self notify("attack_hit_small");
  var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  radiusdamage(self.origin, var_00.small_slam_radius, var_00.small_slam_max_damage, var_00.small_slam_min_damage, self);
}

alienrhinomeleenotehandler(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "alien_slam_big":
      onbigslam();
      break;

    case "alien_slam_small_l":
    case "alien_slam_small_r":
      onsmallslam();
      break;

    default:
      scripts\asm\dlc4\dlc4_asm::alienmeleenotehandler(param_00, param_01, param_02, param_03);
      break;
  }
}

alienrhinonotehandler(param_00, param_01, param_02, param_03) {}

dochargedamageoncontact(param_00, param_01) {
  self endon(param_00 + "_finished");
  self endon("DoChargeDamageOnContact_stop");
  var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_03 = 0;
  while(!var_03) {
    foreach(var_05 in level.players) {
      if(scripts\aitypes\dlc4\behavior_utils::shouldignoreenemy(var_05)) {
        continue;
      }

      var_06 = distancesquared(self.origin, var_05.origin);
      if(var_06 < var_02.charge_attack_stop_facing_enemy_dist_sq) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
      }

      if(scripts\asm\dlc4\dlc4_asm::shouldmeleeattackhit(var_05, var_02.charge_attack_damage_radius_sq, var_02.charge_attack_damage_dot)) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
        var_07 = var_02.charge_attack_damage_amt;
        if(isDefined(var_05.maxhealth)) {
          var_07 = min(180, var_05.maxhealth * 0.9);
        }

        scripts\asm\zombie\melee::domeleedamage(var_05, var_07, "MOD_IMPACT");
        scripts\asm\dlc4\dlc4_asm::clearasmaction();
        self.bchargehit = 1;
        var_03 = 1;
        break;
      } else {
        var_08 = vectornormalize(var_05.origin - self.origin * (1, 1, 0));
        var_09 = anglesToForward(self.angles);
        var_0A = vectordot(var_08, var_09);
        if(var_0A < var_02.charge_abort_dot) {
          self.bchargehit = 0;
          scripts\asm\dlc4\dlc4_asm::clearasmaction();
          var_03 = 1;
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

choosechargeintroanim(param_00, param_01, param_02) {
  if(isDefined(self.var_1198.chargeintroindex)) {
    return self.var_1198.chargeintroindex;
  }

  return randomint(self getanimentrycount(param_01));
}

choosechargeoutroanim(param_00, param_01, param_02) {
  var_03 = "charge_miss";
  if(scripts\engine\utility::istrue(self.bchargehit)) {
    var_03 = "charge_hit";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, var_03);
}

playchargeloop(param_00, param_01, param_02, param_03) {
  self.bchargehit = undefined;
  if(isDefined(self.curmeleetarget)) {
    thread dochargedamageoncontact(param_01, self.curmeleetarget);
    thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  }

  self notify("charge_to_stop");
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

playchargeintro(param_00, param_01, param_02, param_03) {
  if(isDefined(self.curmeleetarget)) {
    thread scripts\asm\zombie\melee::func_6A6A(param_01, self.curmeleetarget);
  }

  self notify("charge_start");
  return scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

shouldabortcharge(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.curmeleetarget) || !isDefined(self.vehicle_getspawnerarray)) {
    self.bchargeaborted = 1;
    return 1;
  }

  if(!navisstraightlinereachable(self.origin, self.vehicle_getspawnerarray, self)) {
    self.bchargeaborted = 1;
    return 1;
  }

  return 0;
}

playtauntanim(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(isDefined(var_04)) {
    thread scripts\asm\zombie\melee::func_6A6A(param_01, var_04);
  }

  self notify("taunt");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}

playsharpturnanim_rhino(param_00, param_01, param_02, param_03) {
  var_04 = self.moveplaybackrate;
  self.moveplaybackrate = 0.75;
  lib_0F3B::func_D514(param_00, param_01, param_02, param_03);
  self.moveplaybackrate = var_04;
}

playrhinochargeoutro(param_00, param_01, param_02, param_03) {
  if(isDefined(self.preventplayerpushdist)) {
    self _meth_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, param_03);
}
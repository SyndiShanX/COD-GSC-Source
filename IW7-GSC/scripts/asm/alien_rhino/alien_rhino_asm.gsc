/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\alien_rhino\alien_rhino_asm.gsc
*******************************************************/

asminit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  self.fnactionvalidator = ::isvalidaction;
  scripts\asm\dlc4\dlc4_asm::analyzeanims();
  analyzerhinoanims();
}

analyzerhinoanims() {
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(isDefined(var_0.chargeintroanimtimes)) {
    return;
  }

  var_0.chargeintroanimtimes = [];
  var_1 = self getanimentrycount("charge_intro");
  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = self getsafecircleorigin("charge_intro", var_2);
    var_0.chargeintroanimtimes[var_2] = getanimlength(var_3);
  }
}

isvalidaction(var_0) {
  switch (var_0) {
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

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  return 0;
}

onbigslam() {
  self notify("attack_hit_big");
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  radiusdamage(self.origin, var_0.big_slam_radius, var_0.big_slam_max_damage, var_0.big_slam_min_damage, self);
}

onsmallslam() {
  self notify("attack_hit_small");
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  radiusdamage(self.origin, var_0.small_slam_radius, var_0.small_slam_max_damage, var_0.small_slam_min_damage, self);
}

alienrhinomeleenotehandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "alien_slam_big":
      onbigslam();
      break;

    case "alien_slam_small_l":
    case "alien_slam_small_r":
      onsmallslam();
      break;

    default:
      scripts\asm\dlc4\dlc4_asm::alienmeleenotehandler(var_0, var_1, var_2, var_3);
      break;
  }
}

alienrhinonotehandler(var_0, var_1, var_2, var_3) {}

dochargedamageoncontact(var_0, var_1) {
  self endon(var_0 + "_finished");
  self endon("DoChargeDamageOnContact_stop");
  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_3 = 0;
  while(!var_3) {
    foreach(var_5 in level.players) {
      if(scripts\aitypes\dlc4\behavior_utils::shouldignoreenemy(var_5)) {
        continue;
      }

      var_6 = distancesquared(self.origin, var_5.origin);
      if(var_6 < var_2.charge_attack_stop_facing_enemy_dist_sq) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
      }

      if(scripts\asm\dlc4\dlc4_asm::shouldmeleeattackhit(var_5, var_2.charge_attack_damage_radius_sq, var_2.charge_attack_damage_dot)) {
        scripts\asm\zombie\melee::func_1106E();
        self ghostlaunched("code_move");
        self orientmode("face angle abs", self.angles);
        var_7 = var_2.charge_attack_damage_amt;
        if(isDefined(var_5.maxhealth)) {
          var_7 = min(180, var_5.maxhealth * 0.9);
        }

        scripts\asm\zombie\melee::domeleedamage(var_5, var_7, "MOD_IMPACT");
        scripts\asm\dlc4\dlc4_asm::clearasmaction();
        self.bchargehit = 1;
        var_3 = 1;
        break;
      } else {
        var_8 = vectornormalize(var_5.origin - self.origin * (1, 1, 0));
        var_9 = anglesToForward(self.angles);
        var_0A = vectordot(var_8, var_9);
        if(var_0A < var_2.charge_abort_dot) {
          self.bchargehit = 0;
          scripts\asm\dlc4\dlc4_asm::clearasmaction();
          var_3 = 1;
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

choosechargeintroanim(var_0, var_1, var_2) {
  if(isDefined(self._blackboard.chargeintroindex)) {
    return self._blackboard.chargeintroindex;
  }

  return randomint(self getanimentrycount(var_1));
}

choosechargeoutroanim(var_0, var_1, var_2) {
  var_3 = "charge_miss";
  if(scripts\engine\utility::istrue(self.bchargehit)) {
    var_3 = "charge_hit";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

playchargeloop(var_0, var_1, var_2, var_3) {
  self.bchargehit = undefined;
  if(isDefined(self.curmeleetarget)) {
    thread dochargedamageoncontact(var_1, self.curmeleetarget);
    thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  }

  self notify("charge_to_stop");
  if(isDefined(self.preventplayerpushdist)) {
    self func_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

playchargeintro(var_0, var_1, var_2, var_3) {
  if(isDefined(self.curmeleetarget)) {
    thread scripts\asm\zombie\melee::func_6A6A(var_1, self.curmeleetarget);
  }

  self notify("charge_start");
  return scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

shouldabortcharge(var_0, var_1, var_2, var_3) {
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

playtauntanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\dlc4\dlc4_asm::getenemy();
  if(isDefined(var_4)) {
    thread scripts\asm\zombie\melee::func_6A6A(var_1, var_4);
  }

  self notify("taunt");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

playsharpturnanim_rhino(var_0, var_1, var_2, var_3) {
  var_4 = self.moveplaybackrate;
  self.moveplaybackrate = 0.75;
  lib_0F3B::func_D514(var_0, var_1, var_2, var_3);
  self.moveplaybackrate = var_4;
}

playrhinochargeoutro(var_0, var_1, var_2, var_3) {
  if(isDefined(self.preventplayerpushdist)) {
    self func_85C9(self.preventplayerpushdist);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}
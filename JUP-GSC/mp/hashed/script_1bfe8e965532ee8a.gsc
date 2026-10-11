/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1bfe8e965532ee8a.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_2b7d0556a98cd96;

function function_714b93f3cd89e618() {
  self.var_306ac6ff52911f55 = &function_703e9acc55d0902b;
}

function function_306feec3952fc2ef(targets) {
  if(isDefined(self.var_7fb7ab379bea66a5) && self.var_7fb7ab379bea66a5 > gettime()) {
    self._blackboard.zombieunreachableisattacking = 0;
    return;
  }

  if(!isDefined(targets)) {
    targets = [self.var_c24f43a7d0d8d195];
  }

  final_targets = [];

  foreach(ranged_target in targets) {
    if(isPlayer(ranged_target)) {
      if(ranged_target function_4c108309dc0d7fd2() > self._blackboard.var_4a850e88a81da5f9) {
        continue;
      }
    }

    final_targets[final_targets.size] = ranged_target;
  }

  if(final_targets.size == 0) {
    self._blackboard.zombieunreachableisattacking = 0;
    return;
  }

  function_ac90fa5cc0a80298("ranged_attack_in");
  thread function_ed0aa045ccc205dd(final_targets);
}

function private function_ed0aa045ccc205dd(targets) {
  self endon("death");
  self endon("terminate_ranged_attack");
  self.var_35bcbbe0ba774121 = default_to(self.var_35bcbbe0ba774121, "tag_weakpoint_mouth");
  self waittill("fire_projectile");

  foreach(ranged_target in targets) {
    if(!isalive(ranged_target)) {
      continue;
    }

    target_point = ranged_target.origin;

    if(ranged_target tagexists("j_spine4")) {
      target_point = ranged_target gettagorigin("j_spine4");
    }

    function_7ed594e1ada9063e(target_point, ranged_target);
  }

  self.var_7fb7ab379bea66a5 = gettime() + 2000;
}

function private function_7ed594e1ada9063e(target_pos, ranged_target) {
  if(!isDefined(target_pos)) {
    return;
  }

  thread function_c2de30ecd5f08178(ranged_target);
  start_pos = self gettagorigin(self.var_35bcbbe0ba774121);
  to_target = target_pos - start_pos;

  if(lengthsquared(to_target) == 0) {
    iprintln("<dev string:x1c>");

    return;
  }

  gravity = getdvarfloat(@ "bg_lowgravity", 400);
  time = length((to_target[0], to_target[1], 0)) / 700;
  var_43957ae1526916df = (0.5 * gravity * squared(time) + to_target[2]) / time;
  to_target = vectorNormalize((to_target[0], to_target[1], 0));
  e_grenade = magicgrenademanual(self.grenadeweapon, start_pos, (to_target[0] * 700, to_target[1] * 700, var_43957ae1526916df), 8, self);
  e_grenade thread function_6dd93827edeb79f0();
}

function private function_6dd93827edeb79f0() {
  self endon("delay_death");
  childthread delay_endon("death");
  self waittill("projectile_impact_player", hitent);

  if(isPlayer(hitent)) {
    playfxontagforclients(getfx("player_hit_by_mimic_ranged_attack_fx"), hitent, "j_head", hitent);
  }
}

function function_703e9acc55d0902b(idamage, eattacker, objweapon) {
  if(isDefined(eattacker.var_b285453af8b7df75) && isDefined(eattacker.grenadeweapon) && objweapon == eattacker.grenadeweapon) {
    idamage = eattacker.var_b285453af8b7df75;
  }

  return idamage;
}

function private delay_endon(string) {
  self waittill(string);
  waitframe();
  self notify("delay_" + string);
}

function private function_c2de30ecd5f08178(ranged_target) {
  if(isPlayer(ranged_target)) {
    ranged_target function_e89f2bdb307f137e();
  }

  waittill_any_2("terminate_ranged_attack", "death");

  if(isPlayer(ranged_target)) {
    ranged_target function_a33073d6fd58e58e();
  }
}

function function_5b2ce71d8c7c9444(asmname, statename, tostatename, params) {
  target = self.var_c24f43a7d0d8d195;

  if(isDefined(target)) {
    targetyaw = vectortoyaw(target.origin - self.origin);
    return (abs(angleclamp180(self.angles[1] - targetyaw)) > 25);
  }

  return false;
}

function function_881bc6131b199e97(asmname, statename, params) {
  target = self.var_c24f43a7d0d8d195;
  alias = "ranged_attack";

  if(isDefined(target)) {
    if(target.origin[2] - self.origin[2] > 200) {
      alias = "ranged_attack_high";
    } else {
      targetyaw = vectortoyaw(target.origin - self.origin);
      attackyaw = angleclamp180(self.angles[1] - targetyaw);

      if(attackyaw < -25) {
        alias = "ranged_attack_left";
      } else if(attackyaw > 25) {
        alias = "ranged_attack_right";
      }
    }
  }

  result = asm_lookupanimfromalias(statename, alias);
  return result;
}
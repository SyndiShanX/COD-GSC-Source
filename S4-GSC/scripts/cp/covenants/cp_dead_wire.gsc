/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_dead_wire.gsc
*************************************************/

init() {
  _id_06CB::_id_AA49(::_id_AA49);
  _id_0945::_id_C2B1("dead_wire_specials");
  level._effect["vfx_cov_deadwire_aoe_exp"] = loadfx("vfx/s4/zombie_weapon/vfx_cov_deadwire_aoe_exp.vfx");
}

_id_AA49(var_0) {
  if(isPlayer(var_0._id_50FF) && scripts\cp\covenants\cp_covenants::isvalidcovenantprimaryweapon(var_0._id_04F6, var_0._id_DE2B)) {
    check_for_stun(var_0._id_50FF);
  }
}

can_stun(var_0, var_1) {
  if(scripts\aitypes\zombie_common\stun::is_stunned() || istrue(self._id_86F2)) {
    return 0;
  }

  if(!istrue(var_1) && isDefined(var_0.next_dead_wire_time) && gettime() < var_0.next_dead_wire_time) {
    return 0;
  }

  switch (self.zm_ai_category) {
    case "normal":
      return 1;
    case "special":
      return var_0 scripts\cp\utility::_hasperk("dead_wire_specials");
    default:
      return 0;
  }
}

check_for_stun(var_0) {
  if(can_stun(var_0)) {
    var_1 = var_0 _id_0945::_id_664E("dead_wire_chance");

    if(isDefined(var_1) && randomfloat(1) < var_1) {
      thread apply_stun(var_0);
      var_0.next_dead_wire_time = gettime() + var_0 _id_0945::_id_664E("dead_wire_cooldown") * 1000;
      check_for_arc(var_0);
    }
  }
}

check_for_arc(var_0) {
  if(isDefined(var_0.next_dead_wire_arc_time) && gettime() < var_0.next_dead_wire_arc_time) {
    return;
  }
  var_1 = var_0 _id_0945::_id_664E("dead_wire_additional_targets");

  if(var_1 > 0) {
    var_2 = var_0 _id_0945::_id_664E("dead_wire_arc_distance");
    var_3 = var_0 _id_0945::_id_664E("dead_wire_duration");
    var_4 = _func_0071(self.origin, var_2);
    var_5 = 0;

    foreach(var_7 in var_4) {
      if(!var_7 can_stun(var_0, 1)) {
        continue;
      }
      var_7 thread apply_stun(var_0);
      var_5++;

      if(var_5 == var_1) {
        break;
      }
    }

    if(var_5 > 0) {
      var_0.next_dead_wire_arc_time = gettime() + var_0 _id_0945::_id_664E("dead_wire_arc_cooldown") * 1000;
      playFX(level._effect["vfx_cov_deadwire_aoe_exp"], self.origin);
      self playSound("zmb_deadwire_explo");
    }
  }
}

apply_stun(var_0) {
  self endon("death");
  var_1 = var_0 _id_0945::_id_664E("dead_wire_duration");
  scripts\aitypes\zombie_common\stun::stun(var_1, "dead_wire");

  if(!isDefined(self.dead_wire_attackers)) {
    self.dead_wire_attackers = [];
  }

  self.dead_wire_attackers = scripts\cp\utility::_id_1B8C(self.dead_wire_attackers, var_0);
  self setscriptablepartstate("electricity", "active");
  self playLoopSound("zmb_deadwire_stun_lp");
  wait(var_1);
  self setscriptablepartstate("electricity", "neutral");
  self stoploopsound("zmb_deadwire_stun_lp");
  self.dead_wire_attackers = undefined;
}

is_dead_wire_active(var_0, var_1) {
  return isDefined(var_0.dead_wire_attackers) && scripts\engine\utility::array_contains(var_0.dead_wire_attackers, var_1);
}
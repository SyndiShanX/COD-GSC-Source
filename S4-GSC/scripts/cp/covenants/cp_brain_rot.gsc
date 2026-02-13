/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_brain_rot.gsc
*************************************************/

init() {
  _id_0945::_id_C2B1("brain_rot_specials");
  _id_0945::_id_C2B1("brain_rot_enemy_explode");
  _id_06CB::_id_AA49(::_id_AA49);
  _id_06CB::_id_AA4A(::_id_AA4A);
  level._effect["brain_rot_explode"] = loadfx("vfx/s4/zombie_ai/vfx_zai_exp_aoe_brain_rot.vfx");
}

_id_AA49(var_0) {
  if(isPlayer(var_0._id_50FF) && scripts\cp\covenants\cp_covenants::isvalidcovenantprimaryweapon(var_0._id_04F6, var_0._id_DE2B)) {
    check_for_turn(var_0._id_50FF);
  }
}

can_apply_brain_rot(var_0) {
  if(istrue(self._id_86F2)) {
    return 0;
  }

  if(istrue(self.brain_rot_immune)) {
    return 0;
  }

  if(isDefined(var_0._id_A465) && gettime() < var_0._id_A465) {
    return 0;
  }

  switch (self.zm_ai_category) {
    case "normal":
      return 1;
    case "special":
      return var_0 scripts\cp\utility::_hasperk("brain_rot_specials");
    default:
      return 0;
  }
}

check_for_turn(var_0) {
  if(can_apply_brain_rot(var_0)) {
    var_1 = var_0 _id_0945::_id_664E("brain_rot_chance");

    if(isDefined(var_1) && randomfloat(1) < var_1) {
      turn_zombie(var_0);
    }
  }
}

turn_zombie(var_0) {
  self endon("death");
  on_turned();
  var_0._id_A465 = gettime() + var_0 _id_0945::_id_664E("brain_rot_cooldown") * 1000;

  if(var_0 scripts\cp\utility::_hasperk("brain_rot_enemy_explode")) {
    self.brain_rot_explode = 1;
  }

  self.brain_rot_player = var_0;
  wait(var_0 _id_0945::_id_664E("brain_rot_duration"));

  if(isDefined(var_0)) {
    self _meth_81FA(self.origin, var_0, var_0, "MOD_PISTOL_BULLET");
  } else {
    self _meth_81FA(self.origin, self, self, "MOD_PISTOL_BULLET");
  }
}

on_turned() {
  self.team = "allies";
  self._id_86F2 = 1;
  _id_08EA::_id_110A7(self._id_110B0);
  self _meth_852B(0);
  self _meth_80C6(0.01, 0.1);
  scripts\cp\zombies\zombie_slow::end_all_slows();
  thread _id_5403();
  thread set_full_health();

  if(isDefined(self.set_turned_func)) {
    [[self.set_turned_func]](1);
  }
}

_id_AA4A(var_0) {
  if(istrue(self.brain_rot_explode) && isDefined(self.brain_rot_player) && (!isDefined(self.brain_rot_player.next_brain_rot_explosion_time) || gettime() >= self.brain_rot_player.next_brain_rot_explosion_time)) {
    var_1 = self.brain_rot_player _id_0945::_id_664E("brain_rot_explosion_radius");
    var_2 = _func_0071(self.origin, var_1);

    if(var_2.size > 0) {
      var_3 = self.brain_rot_player _id_0945::_id_664E("brain_rot_explosion_cooldown");
      self.brain_rot_player.next_brain_rot_explosion_time = gettime() + var_3 * 1000;
      var_4 = self.brain_rot_player _id_0945::_id_664E("brain_rot_max_explosion_turn");
      var_5 = 0;

      foreach(var_7 in var_2) {
        if(var_7 scripts\cp\utility::_id_872B() && !istrue(var_7._id_86F2) && !istrue(var_7.brain_rot_immune)) {
          var_7 thread turn_zombie(self.brain_rot_player);
          var_5++;

          if(var_5 >= var_4) {
            break;
          }
        }
      }

      var_9 = self.brain_rot_player _id_0945::_id_664E("brain_rot_explosion_damage");
      self radiusdamage(self.origin, var_1, var_9, var_9, self.brain_rot_player, "MOD_UNKNOWN", "s4_brain_rot_explosion_zm");
      playFX(scripts\engine\utility::getfx("brain_rot_explode"), self gettagorigin("j_head"));
    }
  }
}

_id_5403() {
  self endon("death");

  for(;;) {
    wait 1;

    if(!isDefined(self._id_0192)) {
      var_0 = _func_0070(level._id_11056);

      if(var_0.size == 0) {
        self _meth_81FA(self.origin, self.brain_rot_player, self.brain_rot_player, "MOD_PISTOL_BULLET");
        return;
      }

      foreach(var_2 in var_0) {
        self _meth_812E(var_2);
      }
    }
  }
}

set_full_health() {
  self endon("death");
  waittillframeend;
  self.health = self.maxhealth;
}

is_brain_rot_active(var_0, var_1) {
  if(isai(var_0) && istrue(var_0._id_86F2)) {
    return 1;
  }

  if(isDefined(var_1) && isDefined(var_1.basename) && var_1.basename == "s4_brain_rot_explosion_zm") {
    return 1;
  }

  return 0;
}
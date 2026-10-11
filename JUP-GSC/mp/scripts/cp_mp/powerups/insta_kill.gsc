/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\powerups\insta_kill.gsc
****************************************************/

#using script_16ea1b94f0f381b3;
#using script_7edf952f8921aa6b;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#namespace insta_kill;

function autoexec main() {
  function_f9a50549e0b4a614();
}

function function_f9a50549e0b4a614() {
  register_powerup("insta_kill", &grab_insta_kill);
  function_b5e57408c7878df7(&function_bdbabfc99054986b);

  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2f>", "<dev string:x4f>", &function_e2b8eeccc951133f);
  function_b23a59dfb4ca49a1("<dev string:x73>", "<dev string:x93>", &function_e2b8eeccc951133f);
  function_fe953f000498048f();
}

function grab_insta_kill(str_powerup, ent_powerup) {
  a_players = function_a56a8b17eae57b09(str_powerup);

  foreach(player in a_players) {
    player thread function_1eeed7712fef95ac();
  }

  level notify("zmb_insta_kill_level");
}

function function_1eeed7712fef95ac() {
  self notify("powerup instakill_active");
  self endon("powerup instakill_active");
  ent_flag_set("powerup_insta_kill_active");
  root = function_ecdae672c660149e();
  n_lifetime = root.powerups["insta_kill"].var_f862e718db266e0a;

  if(isDefined(level.powerup_timeout_override)) {
    n_lifetime = self[[level.powerup_timeout_override]](n_lifetime);
  }

  thread namespace_2b1145f62aa835b8::showpoweruphudsharedfunc("insta_kill", n_lifetime);

  if(isDefined(level.var_29a59b6489c9891c)) {
    self[[level.var_29a59b6489c9891c]](n_lifetime, "end_insta_kill");
  } else {
    waittill_any_timeout_1(n_lifetime, "end_insta_kill");
  }

  if(isDefined(self)) {
    ent_flag_clear("powerup_insta_kill_active");
  }
}

function function_bdbabfc99054986b(params) {
  if(isDefined(params.eattacker) && params.eattacker function_c88394be6941559a()) {
    return function_941a468f40ccf551(params.idamage, params.eattacker, params.smeansofdeath, params.shitloc, params.sweapon);
  }

  return -1;
}

function function_c88394be6941559a() {
  if(isPlayer(self) && ent_flag("powerup_insta_kill_active")) {
    return true;
  }

  if(isPlayer(self.owner) && self.owner ent_flag("powerup_insta_kill_active")) {
    return true;
  }

  return false;
}

function function_941a468f40ccf551(idamage, eattacker, smeansofdeath, shitloc, sweapon) {
  if(istrue(level.headshots_only) && !("head" == shitloc || "helmet" == shitloc || "neck" == shitloc)) {
    return -1;
  }

  if(smeansofdeath == "MOD_GRENADE_SPLASH") {
    return -1;
  }

  if(isDefined(eattacker)) {
    damage = self.health;

    if(isDefined(self.aicategory)) {
      if(self.aicategory == "special") {
        damage = idamage * function_519d44e54a9b8ae5("insta_kill").var_8644a5332247a86d;
      } else if(self.aicategory == "elite") {
        damage = idamage * function_519d44e54a9b8ae5("insta_kill").var_153861ab87fea6ed;
      } else if(self.aicategory == "boss") {
        damage = idamage * function_519d44e54a9b8ae5("insta_kill").var_11f0257e902f772f;
      }
    }

    if(!istrue(self.takedamage)) {
      return -1;
    }

    if(isDefined(self.instakill_func)) {
      b_result = self[[self.instakill_func]](eattacker, smeansofdeath, shitloc);

      if(istrue(b_result)) {
        return -1;
      }
    }

    if(damage == self.health) {
      val::set("insta_kill", "kill_on_damage", 1);
      val::set("zm_allow_give_super_point", "allow_give_super_point", 0);
    }

    return damage;
  }

  return -1;
}
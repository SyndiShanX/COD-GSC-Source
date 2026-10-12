/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\powerups\full_armor.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#namespace full_armor;

function autoexec main() {
  if(getdvarint(@ "hash_470805a9cd7bcb56", 0)) {
    return;
  }

  function_d5fc5da2613d29dd();
}

function function_d5fc5da2613d29dd() {
  register_powerup("full_armor", &function_89fc1f6a39554ce9, &function_589539e3a6b1386f, &function_58a4e1d475eb979b);

  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2f>", "<dev string:x4f>", &function_e2b8eeccc951133f);
  function_b23a59dfb4ca49a1("<dev string:x73>", "<dev string:x93>", &function_e2b8eeccc951133f);
  function_fe953f000498048f();
}

function function_589539e3a6b1386f() {
  if(utility::issharedfuncdefined("powerup_full_armor", "should_drop")) {
    return utility::callsharedfunc("powerup_full_armor", "should_drop");
  }

  foreach(player in level.players) {
    if(istrue(player scripts\cp_mp\armor::hasarmor())) {
      return 1;
    }
  }

  return 0;
}

function function_58a4e1d475eb979b(chance, context) {
  if(utility::issharedfuncdefined("powerup_full_armor", "modify_drop_chance")) {
    return utility::callsharedfunc("powerup_full_armor", "modify_drop_chance", chance, context);
  }

  return chance;
}

function function_89fc1f6a39554ce9(str_powerup, ent_powerup) {
  a_players = function_a56a8b17eae57b09(str_powerup);

  foreach(player in a_players) {
    var_ee96be2201d4d114 = isDefined(player.armorhealth) && isDefined(player.maxarmorhealth) && player.maxarmorhealth > 0;

    if(var_ee96be2201d4d114 && !player scripts\cp_mp\armor::function_e47b13babb51a365()) {
      player scripts\cp_mp\armor::repair_armor(player.maxarmorhealth);
    }

    player thread namespace_2b1145f62aa835b8::showpoweruphudsharedfunc(str_powerup);
  }
}
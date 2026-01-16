/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_galvaknuckles_t8.gsc
***************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_melee_weapon;

#namespace zm_weap_galvaknuckles_t8;

autoexec __init__system__() {
  system::register(#"galvaknuckles", &__init__, &__main__, undefined);
}

private __init__() {
  zm_loadout::register_melee_weapon_for_level(#"galvaknuckles_t8");
  level.var_b77d3496 = getweapon(#"galvaknuckles_t8");
  callback::on_ai_killed(&on_ai_killed);
}

private __main__() {
  zm_melee_weapon::init(#"galvaknuckles_t8", #"galvaknuckles_t8_flourish", 5000, "tazer_upgrade", #"hash_60606b68e93a29c8", "galva", undefined);
}

on_ai_killed(s_params) {
  wait 0.15;

  if(s_params.weapon === level.var_b77d3496 && isDefined(self) && isactor(self) && isDefined(s_params.eattacker)) {
    var_5b84ed9a = s_params.eattacker getcentroid();
    var_2640e082 = 15 * (vectornormalize(self getcentroid() - var_5b84ed9a) + (0, 0, 0.1));
    self startragdoll();
    self launchragdoll(var_2640e082);
  }
}
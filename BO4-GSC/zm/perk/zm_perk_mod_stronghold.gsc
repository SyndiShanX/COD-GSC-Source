/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_stronghold.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\perk\zm_perk_stronghold;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_stronghold;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_stronghold", &__init__, &__main__, undefined);
}

__init__() {
  function_8afdc221();
}

__main__() {}

function_8afdc221() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_camper", "mod_stronghold", #"perk_stronghold", #"specialty_camper", 3000);
  zm_perks::register_perk_threads(#"specialty_mod_camper", &function_1076eef9, &function_20b5dc19);
}

function_1076eef9() {
  level callback::on_ai_killed(&function_1c4f9c3f);
}

function_20b5dc19(b_pause, str_perk, str_result, n_slot) {
  level callback::remove_on_ai_killed(&function_1c4f9c3f);
}

function_1c4f9c3f(s_params) {
  player = s_params.eattacker;

  if(isplayer(player) && player hasperk(#"specialty_mod_camper")) {
    if(!(isDefined(player.var_7d0e99f3) && player.var_7d0e99f3)) {
      return;
    }

    n_dist = distance(player.var_3748ec02, self.origin);

    if(n_dist <= 130) {
      player zm_perk_stronghold::add_armor();
      player zm_perk_stronghold::function_c25b980c();
    }
  }
}
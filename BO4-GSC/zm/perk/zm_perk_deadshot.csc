/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_deadshot.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_deadshot;

autoexec __init__system__() {
  system::register(#"zm_perk_deadshot", &__init__, undefined, undefined);
}

__init__() {
  enable_deadshot_perk_for_level();
}

enable_deadshot_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_deadshot", &deadshot_client_field_func, &deadshot_code_callback_func);
  zm_perks::register_perk_effects(#"specialty_deadshot", "deadshot_light");
  zm_perks::register_perk_init_thread(#"specialty_deadshot", &init_deadshot);
  zm_perks::function_b60f4a9f(#"specialty_deadshot", #"p8_zm_vapor_altar_icon_01_deadshot", "zombie/fx8_perk_altar_symbol_ambient_dead_shot", #"zmperksdeadshot");
  zm_perks::function_f3c80d73("zombie_perk_bottle_deadshot", "zombie_perk_totem_deadshot");
}

init_deadshot() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect[#"deadshot_light"] = #"hash_2225287695ddf9c9";
  }
}

deadshot_client_field_func() {
  clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
}

deadshot_code_callback_func() {}

player_deadshot_perk_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!is_local_player(self)) {
    return;
  }

  self endon(#"death");

  if(self util::function_50ed1561(localclientnum)) {
    if(is_local_player(self)) {
      if(newval) {
        self usealternateaimparams();
        return;
      }

      self clearalternateaimparams();
    }
  }
}

private is_local_player(player) {
  if(!isDefined(player) || !isplayer(player)) {
    return 0;
  }

  a_players = getlocalplayers();
  return isinarray(a_players, player);
}
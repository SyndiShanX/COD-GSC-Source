/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_deadshot.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;
#namespace zm_perk_deadshot;

function private autoexec __init__system__() {
  system::register(#"zm_perk_deadshot", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  enable_deadshot_perk_for_level();
}

function enable_deadshot_perk_for_level() {
  zm_perks::register_perk_clientfields(#"talent_deadshot", &deadshot_client_field_func, &deadshot_code_callback_func);
  zm_perks::register_perk_effects(#"talent_deadshot", "deadshot_light");
  zm_perks::register_perk_init_thread(#"talent_deadshot", &init_deadshot);
  zm_perks::function_f3c80d73("zombie_perk_bottle_deadshot");
}

function init_deadshot() {
  if(is_true(level.enable_magic)) {
    level._effect[#"deadshot_light"] = "zombie/fx_perk_deadshot_ndu";
  }
}

function deadshot_client_field_func() {
  clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
}

function deadshot_code_callback_func() {}

function player_deadshot_perk_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!is_local_player(self)) {
    return;
  }

  self endon(#"death");

  if(self util::function_50ed1561(fieldname)) {
    if(is_local_player(self)) {
      if(bwastimejump) {
        self usealternateaimparams();
        return;
      }

      self clearalternateaimparams();
    }
  }
}

function private is_local_player(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return 0;
  }

  a_players = getlocalplayers();
  return isinarray(a_players, player);
}
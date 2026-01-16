/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_common_mode_spectre_rising_fixup.csc
*************************************************************/

#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\wz_common_fixup;

#namespace wz_common_mode_spectre_rising_fixup;

autoexec __init__() {
  function_63ad593a();
}

event_handler[level_init] main(eventstruct) {
  level thread function_b9962a73();
}

function_b9962a73() {
  if(isDefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising")) {
    chests = getdynentarray("world_ammo_stash_blackjack");

    foreach(dynent in chests) {
      add_helico(dynent, #"hash_6a582b37e8f152b4");
    }
  }
}

function_63ad593a() {
  var_a12b4736 = &item_world_fixup::function_96ff7b88;
  var_d2223309 = &item_world_fixup::function_261ab7f5;
  var_b5014996 = &item_world_fixup::function_19089c75;
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
  var_edfbccd0 = &item_world_fixup::function_e70fa91c;

  if(isDefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising")) {
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"blackjack_ammo_stash_parent_placeholder", #"spectre_rising_stash");

    if(isDefined(getgametypesetting(#"wzenablespectregrenade")) && getgametypesetting(#"wzenablespectregrenade")) {
      wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"smoke_grenade_wz_item", #"spectre_grenade_wz_item");
    }
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_escape_fixup.csc
***********************************************/

#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\wz_common_fixup;

#namespace wz_escape_fixup;

autoexec __init__() {
  function_d8c2344b();
}

function_d8c2344b() {
  var_a12b4736 = &item_world_fixup::function_96ff7b88;
  var_d2223309 = &item_world_fixup::function_261ab7f5;
  var_b5014996 = &item_world_fixup::function_19089c75;
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;

  if(isDefined(getgametypesetting(#"wzenableflareguns")) && getgametypesetting(#"wzenableflareguns")) {
    item_world_fixup::function_e70fa91c(#"wz_escape_supply_stash_parent", #"wz_escape_supply_stash_parent_flare_guns", 1);
  }

  if(isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) && getgametypesetting(#"hash_50b1121aee76a7e4")) {
    wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"cu08_list", #"cu08_list_escape");
    wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"cu32_list", #"cu32_list_escape");
    wz_common_fixup::item_replacer(var_f8a4c541, undefined, #"cu33_list", #"cu33_list_escape");
  }
}
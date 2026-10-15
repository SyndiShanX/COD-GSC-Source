/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_common_fixup.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world_fixup;

#namespace wz_common_fixup;

autoexec __init__system__() {
  system::register(#"wz_common_fixup", &__init__, undefined, undefined);
}

autoexec __init() {
  function_41453b43();
}

__init__() {}

item_remover(func1, func2, param1) {
  if(!isDefined(param1)) {
    return;
  }

  if(isDefined(func1)) {
    [[func1]](param1);
  }

  if(isDefined(func2)) {
    [[func2]](param1);
  }
}

item_replacer(func1, func2, list1, list2) {
  if(!isDefined(list1) || !isDefined(list2)) {
    return;
  }

  if(isDefined(func1)) {
    [[func1]](list1, list2);
  }

  if(isDefined(func2)) {
    [[func2]](list1, list2);
  }
}

function_41453b43() {
  var_a12b4736 = &item_world_fixup::function_96ff7b88;
  var_d2223309 = &item_world_fixup::function_261ab7f5;
  var_b5014996 = &item_world_fixup::function_19089c75;
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
}
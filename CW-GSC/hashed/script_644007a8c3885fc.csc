/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_644007a8c3885fc.csc
***********************************************/

#using scripts\core_common\item_world_fixup;
#using scripts\core_common\system_shared;
#namespace namespace_1c7b37c6;

function private autoexec __init__system__() {
  system::register(#"hash_28a40055ae0e64e0", &preinit, undefined, undefined, undefined);
}

function autoexec __init() {
  function_41453b43();
}

function private preinit() {}

function item_remover(func1, param1) {
  if(!isDefined(param1)) {
    return;
  }

  if(isDefined(func1)) {
    [[func1]](param1);
  }
}

function item_replacer(func1, list1, list2) {
  if(!isDefined(list1) || !isDefined(list2)) {
    return;
  }

  if(isDefined(func1)) {
    [[func1]](list1, list2);
  }
}

function function_41453b43() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
}
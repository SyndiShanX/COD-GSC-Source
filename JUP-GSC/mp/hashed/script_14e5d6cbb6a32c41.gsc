/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_14e5d6cbb6a32c41.gsc
*************************************************/

#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#namespace namespace_41242478a801e045;

function function_f2c483126e453846() {
  function_900f562c61c6a5d6("backpack", &function_631b0586e908a3b5, &function_cadc1e993f5a9179, &function_fe2f7ae6de16c38, &function_68adabf8bf68c0f4, &function_6e702ceeac07b35a);
}

function function_631b0586e908a3b5(item_bundle, item, auto_use) {
  assert(isDefined(item_bundle) && item_bundle.type == "<dev string:x1c>");
  function_32c79be2384f10fb(item_bundle.backpacksize, item_bundle);
  self.var_766fdf296110fa0b = item.type;
  self setclientomnvar("backpack_lootid", function_6d15e119c2779a93(item_bundle));
  return item.count - 1;
}

function function_cadc1e993f5a9179(item_bundle, item, auto_use, allow_swap) {
  assert(isDefined(item_bundle) && item_bundle.type == "<dev string:x1c>");
  return false;
}

function function_fe2f7ae6de16c38(item_bundle, item, auto_use, allow_swap) {
  assert(isDefined(item_bundle) && item_bundle.type == "<dev string:x1c>");
  var_7448836fc0de92a7 = function_1b35b10884bd8d67();
  var_e581c3a8c1025c69 = default_to(item_bundle.backpacksize, function_286713f0349afb22());
  return var_7448836fc0de92a7 < var_e581c3a8c1025c69;
}

function function_68adabf8bf68c0f4() {
  item_bundle = undefined;
  item_count = 0;

  if(isDefined(self.var_766fdf296110fa0b)) {
    var_9ec97bdad14a0a5b = function_2cdc55ba39d97d70(self.var_766fdf296110fa0b);

    if(isDefined(var_9ec97bdad14a0a5b)) {
      item_bundle = getscriptbundle("itemspawnentry:" + var_9ec97bdad14a0a5b);

      if(isDefined(item_bundle)) {
        assert(isDefined(item_bundle) && item_bundle.type == "<dev string:x1c>");
        item_count = 1;
      }
    }
  }

  return [item_bundle, item_count];
}

function function_6e702ceeac07b35a(var_7f278373c13f38a7) {
  function_32c79be2384f10fb();
  self.var_766fdf296110fa0b = undefined;
  self setclientomnvar("backpack_lootid", 0);
}
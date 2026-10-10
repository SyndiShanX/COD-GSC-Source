/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_14183f3fced4ee2b.gsc
*************************************************/

#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\zombie_perks;
#namespace namespace_ab72fb42cd326323;

function function_4113bac1fcc24f04() {
  if(isDefined(level.var_435b6cca8be74d31)) {
    [[level.var_435b6cca8be74d31]]();
    return;
  }

  function_900f562c61c6a5d6("perk", &use_perk, &function_60a287a143186571, &can_use_perk, &function_aac0b757b5a813f6);
}

function use_perk(itembundle, item) {
  usedperk = 0;

  if(!istrue(item.fromcache)) {
    usedperk = function_fd9a6fb7a67bcf3e(itembundle.ref);
  } else if(!has_perk(itembundle.ref)) {
    give_perk(itembundle.ref, 1);
    usedperk = 1;
  }

  if(usedperk) {
    return (item.count - 1);
  }

  return item.count;
}

function function_60a287a143186571(itembundle, item, autouse, allowswap) {
  return false;
}

function can_use_perk(itembundle, item, autouse, allowswap) {
  return !has_perk(itembundle.ref);
}

function function_aac0b757b5a813f6() {
  itembundle = undefined;
  quantity = 0;
  return [itembundle, quantity];
}
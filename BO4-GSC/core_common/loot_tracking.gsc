/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\loot_tracking.gsc
***********************************************/

#namespace loot;

function_13afbf2d(lootid, name) {
  if(!isplayer(self)) {
    return;
  }

  player = self;
  eventparams = {
    #loot_id: lootid, 
    #loot_data: name, 
    #gametime: function_f8d53445(), 
    #pos_x: player.origin[0], 
    #pos_y: player.origin[1], 
    #pos_z: player.origin[2]
  };
  function_92d1707f(#"hash_6e269493db33fcf7", eventparams);
}
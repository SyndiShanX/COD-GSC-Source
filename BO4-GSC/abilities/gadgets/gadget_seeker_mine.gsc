/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_seeker_mine.gsc
****************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\system_shared;

#namespace gadget_seeker_mine;

autoexec __init__system__() {
  system::register(#"gadget_seeker_mine", &__init__, undefined, undefined);
}

__init__() {
  ability_player::register_gadget_is_inuse_callbacks(28, &gadget_seeker_mine_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(28, &gadget_seeker_mine_is_flickering);
}

gadget_seeker_mine_is_inuse(slot) {
  return self gadgetisactive(slot);
}

gadget_seeker_mine_is_flickering(slot) {
  return self gadgetflickering(slot);
}
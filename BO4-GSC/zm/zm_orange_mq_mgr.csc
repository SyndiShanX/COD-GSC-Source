/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_mgr.csc
***********************************************/

#include script_6fdaa897ed596805;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\zm\perk\zm_perk_death_perception;
#include scripts\zm\zm_orange_mq_blood;
#include scripts\zm\zm_orange_mq_campfire;
#include scripts\zm\zm_orange_mq_fuse;
#include scripts\zm\zm_orange_mq_hell;
#include scripts\zm\zm_orange_mq_sendoff;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_utility;

#namespace zm_orange_mq_mgr;

preload() {
  zm_orange_mq_blood::preload();
  zm_orange_mq_campfire::preload();
  zm_orange_mq_hell::preload();
  zm_orange_mq_fuse::preload();
  namespace_4b68b2b3::preload();
  zm_orange_mq_sendoff::preload();
  clientfield::register("toplayer", "" + #"hash_668f474410d5c1d0", 24000, 1, "int", &clear_hud, 0, 0);
}

clear_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self zm::function_92f0c63(localclientnum);
  self zm_perk_death_perception::function_25410869(localclientnum);
}
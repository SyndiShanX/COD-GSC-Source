/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_ghost_interface.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\zm\ai\zm_ai_ghost;

#namespace zm_ai_ghost_interface;

function_fd76c3b() {
  ai::registermatchedinterface(#"ghost", #"run", 0, array(1, 0), &zm_ai_ghost::function_cea6c2e0);
}
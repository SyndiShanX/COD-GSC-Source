/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1353.gsc
**************************************/

#using_animtree("generic_human");

init() {
  level._id_200D["neutral"]["stand"]["idle"] = % casual_stand_idle;
  level._id_200D["neutral"]["stand"]["run"] = % unarmed_scared_run;
  level._id_200D["neutral"]["stand"]["death"] = % exposed_death;
  level._id_408D = animscripts\civilian\civilian_init::_id_4083;
  maps\_drone::_id_1FF7();
}
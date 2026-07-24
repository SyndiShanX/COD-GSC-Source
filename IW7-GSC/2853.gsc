/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2853.gsc
**************************************/

#using_animtree("generic_human");

init() {
  level._id_5BDF["neutral"]["stand"]["idle"] = % casual_stand_idle;
  level._id_5BDF["neutral"]["stand"]["run"] = % unarmed_scared_run;
  level._id_5BDF["neutral"]["stand"]["death"] = % exposed_death;
  level._id_24A8 = scripts\anim\civilian\civilian_init::_id_24A7;
  _id_0B22::_id_980E();
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_19de6a08d25644f4.gsc
***********************************************/

#using scripts\core_common\ai\systems\ai_interface;
#namespace namespace_835228b4;

function function_7304e94b() {
  ai::registermatchedinterface(#"dog", #"chaseenemyonspawn", 1, array(1, 0));
  ai::registermatchedinterface(#"dog", #"spacing_near_dist", 120);
  ai::registermatchedinterface(#"dog", #"spacing_far_dist", 480);
  ai::registermatchedinterface(#"dog", #"spacing_horz_dist", 144);
  ai::registermatchedinterface(#"dog", #"spacing_value", 0);
  ai::registermatchedinterface(#"dog", #"min_run_dist", 700);
}
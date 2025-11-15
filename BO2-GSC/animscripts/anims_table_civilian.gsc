/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_civilian.gsc
************************************************/

#include common_scripts\utility;
#include animscripts\anims;
#using_animtree("generic_human");

setup_civilian_anim_array(animtype, array) {
  civrunanims = array( % civilian_run_hunched_a, % civilian_run_hunched_b, % civilian_run_hunched_c, % civilian_run_upright);
  runanim = civrunanims[randomintrange(0, civrunanims.size)];
  self animscripts\anims::clearanimcache();
  assert(isDefined(array) && isarray(array));
  array[animtype]["move"]["stand"]["rifle"]["combat_run_f"] = runanim;
  array[animtype]["move"]["stand"]["none"]["combat_run_f"] = runanim;
  array[animtype]["react"]["stand"]["rifle"]["run_head"] = % civilian_run_hunched_flinch;
  array[animtype]["react"]["stand"]["rifle"]["run_lower_torso_fast"] = % civilian_run_hunched_flinch;
  array[animtype]["react"]["stand"]["rifle"]["run_lower_torso_stop"] = % civilian_run_hunched_dodge;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_45"] = % civilian_run_hunched_turnl45;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_90"] = % civilian_run_hunched_turnl90;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_135"] = % civ_run_upright_turnl135;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_l_180"] = % civilian_run_upright_turnl180;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_45"] = % civilian_run_upright_turnr45;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_90"] = % civilian_run_upright_turnr90;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_135"] = % civ_run_hunched_turnr135;
  array[animtype]["turn"]["stand"]["rifle"]["turn_f_r_180"] = % civilian_run_upright_turnr180;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_bR"] = % civilian_run_upright_turnr180;
  array[animtype]["move"]["stand"]["rifle"]["run_f_to_bL"] = % civilian_run_upright_turnl180;
  return array;
}
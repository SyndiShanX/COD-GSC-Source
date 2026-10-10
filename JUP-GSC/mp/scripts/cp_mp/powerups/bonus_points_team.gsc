/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\powerups\bonus_points_team.gsc
***********************************************************/

#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#namespace bonus_points_team;

function autoexec main() {
  function_e3322035230ef1d7();
}

function function_e3322035230ef1d7() {
  register_powerup("bonus_points_team", &function_24cd8348480a55d3);

  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2f>", "<dev string:x51>", &function_e2b8eeccc951133f);
  function_b23a59dfb4ca49a1("<dev string:x7c>", "<dev string:x9e>", &function_e2b8eeccc951133f);
  function_fe953f000498048f();
}

function function_24cd8348480a55d3(str_powerup, ent_powerup) {
  a_players = function_a56a8b17eae57b09(str_powerup);

  foreach(player in a_players) {
    player give_points();
    player thread function_676437737684783f(str_powerup);
  }

  level notify("zmb_bonus_points_team_level");
}

function give_points() {
  root = function_ecdae672c660149e();
  self[[root.var_cc680f1d779ccc51]]("powerup_bonus_points_team");
  self notify("zmb_bonus_points_team");
}
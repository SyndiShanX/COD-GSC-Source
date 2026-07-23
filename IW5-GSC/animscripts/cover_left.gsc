/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_left.gsc
**************************************/

main() {
  self.animarrayfuncs = [];
  self.animarrayfuncs["hiding"]["stand"] = ::set_animarray_standing_left;
  self.animarrayfuncs["hiding"]["crouch"] = ::set_animarray_crouching_left;
  self endon("killanimscript");
  animscripts\utility::initialize("cover_left");
  animscripts\corner::corner_think("left", 90);
}

end_script() {
  animscripts\corner::end_script_corner();
  animscripts\cover_behavior::end_script("left");
}

#using_animtree("generic_human");

set_animarray_standing_left() {
  var_0 = [];
  var_0["alert_idle"] = % corner_standl_alert_idle;
  var_0["alert_idle_twitch"] = animscripts\utility::array(%corner_standl_alert_twitch01, %corner_standl_alert_twitch02, %corner_standl_alert_twitch03, %corner_standl_alert_twitch04, %corner_standl_alert_twitch05, %corner_standl_alert_twitch06, %corner_standl_alert_twitch07);
  var_0["alert_idle_flinch"] = animscripts\utility::array(%corner_standl_flinch);
  var_0["alert_to_A"] = animscripts\utility::array(%corner_standl_trans_alert_2_a);
  var_0["alert_to_B"] = animscripts\utility::array(%corner_standl_trans_alert_2_b_v2);
  var_0["A_to_alert"] = animscripts\utility::array(%corner_standl_trans_a_2_alert_v2);
  var_0["A_to_alert_reload"] = animscripts\utility::array();
  var_0["A_to_B"] = animscripts\utility::array(%corner_standl_trans_a_2_b_v2);
  var_0["B_to_alert"] = animscripts\utility::array(%corner_standl_trans_b_2_alert_v2);
  var_0["B_to_alert_reload"] = animscripts\utility::array(%corner_standl_reload_b_2_alert);
  var_0["B_to_A"] = animscripts\utility::array(%corner_standl_trans_b_2_a_v2);
  var_0["lean_to_alert"] = animscripts\utility::array(%cornerstndl_lean_2_alert);
  var_0["alert_to_lean"] = animscripts\utility::array(%cornerstndl_alert_2_lean);
  var_0["look"] = % corner_standl_look;
  var_0["reload"] = animscripts\utility::array(%corner_standl_reload_v1);
  var_0["grenade_exposed"] = % corner_standl_grenade_a;
  var_0["grenade_safe"] = % corner_standl_grenade_b;
  var_0["blind_fire"] = animscripts\utility::array(%corner_standl_blindfire_v1, %corner_standl_blindfire_v2);
  var_0["alert_to_look"] = % corner_standl_alert_2_look;
  var_0["look_to_alert"] = % corner_standl_look_2_alert;
  var_0["look_to_alert_fast"] = % corner_standl_look_2_alert_fast_v1;
  var_0["look_idle"] = % corner_standl_look_idle;
  var_0["stance_change"] = % cornercrl_stand_2_alert;
  var_0["lean_aim_down"] = % cornerstndl_lean_aim_2;
  var_0["lean_aim_left"] = % cornerstndl_lean_aim_4;
  var_0["lean_aim_straight"] = % cornerstndl_lean_aim_5;
  var_0["lean_aim_right"] = % cornerstndl_lean_aim_6;
  var_0["lean_aim_up"] = % cornerstndl_lean_aim_8;
  var_0["lean_reload"] = % cornerstndl_lean_reload;
  var_0["lean_idle"] = animscripts\utility::array(%cornerstndl_lean_idle);
  var_0["lean_single"] = % cornerstndl_lean_fire;
  var_0["lean_fire"] = % cornerstndl_lean_auto;

  if(isDefined(anim.ramboanims)) {
    var_0["rambo90"] = anim.ramboanims.coverleft90;
    var_0["rambo45"] = anim.ramboanims.coverleft45;
    var_0["grenade_rambo"] = anim.ramboanims.coverleftgrenade;
  }

  self.hideyawoffset = 90;
  self.a.array = var_0;
}

set_animarray_crouching_left() {
  var_0 = [];
  var_0["alert_idle"] = % cornercrl_alert_idle;
  var_0["alert_idle_twitch"] = animscripts\utility::array();
  var_0["alert_idle_flinch"] = animscripts\utility::array();
  var_0["alert_to_A"] = animscripts\utility::array(%cornercrl_trans_alert_2_a);
  var_0["alert_to_B"] = animscripts\utility::array(%cornercrl_trans_alert_2_b);
  var_0["A_to_alert"] = animscripts\utility::array(%cornercrl_trans_a_2_alert);
  var_0["A_to_alert_reload"] = animscripts\utility::array();
  var_0["A_to_B"] = animscripts\utility::array(%cornercrl_trans_a_2_b);
  var_0["B_to_alert"] = animscripts\utility::array(%cornercrl_trans_b_2_alert);
  var_0["B_to_alert_reload"] = animscripts\utility::array();
  var_0["B_to_A"] = animscripts\utility::array(%cornercrl_trans_b_2_a);
  var_0["lean_to_alert"] = animscripts\utility::array(%cornercrl_lean_2_alert);
  var_0["alert_to_lean"] = animscripts\utility::array(%cornercrl_alert_2_lean);
  var_0["look"] = % cornercrl_look_fast;
  var_0["reload"] = animscripts\utility::array(%cornercrl_reloada, %cornercrl_reloadb);
  var_0["grenade_safe"] = % cornercrl_grenadea;
  var_0["grenade_exposed"] = % cornercrl_grenadeb;
  var_0["alert_to_over"] = animscripts\utility::array(%cornercrl_alert_2_over);
  var_0["over_to_alert"] = animscripts\utility::array(%cornercrl_over_2_alert);
  var_0["over_to_alert_reload"] = animscripts\utility::array();
  var_0["blind_fire"] = animscripts\utility::array();
  var_0["rambo90"] = animscripts\utility::array();
  var_0["rambo45"] = animscripts\utility::array();
  var_0["stance_change"] = % cornercrl_alert_2_stand;
  var_0["lean_aim_down"] = % cornercrl_lean_aim_2;
  var_0["lean_aim_left"] = % cornercrl_lean_aim_4;
  var_0["lean_aim_straight"] = % cornercrl_lean_aim_5;
  var_0["lean_aim_right"] = % cornercrl_lean_aim_6;
  var_0["lean_aim_up"] = % cornercrl_lean_aim_8;
  var_0["lean_idle"] = animscripts\utility::array(%cornercrl_lean_idle);
  var_0["lean_single"] = % cornercrl_lean_fire;
  var_0["lean_fire"] = % cornercrl_lean_auto;
  self.hideyawoffset = 90;
  self.a.array = var_0;
}
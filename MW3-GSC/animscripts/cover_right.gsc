/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_right.gsc
***************************************/

main() {
  self._id_2443 = [];
  self._id_2443["hiding"]["stand"] = ::_id_3FDE;
  self._id_2443["hiding"]["crouch"] = ::_id_3FDF;
  self endon("killanimscript");
  animscripts\utility::_id_0D15("cover_right");
  animscripts\corner::_id_2442("right", -90);
}

end_script() {
  animscripts\corner::_id_2449();
  animscripts\cover_behavior::end_script("right");
}

#using_animtree("generic_human");

_id_3FDE() {
  var_0 = [];
  var_0["alert_idle"] = % corner_standr_alert_idle;
  var_0["alert_idle_twitch"] = animscripts\utility::_id_0C6D( % corner_standr_alert_twitch01, % corner_standr_alert_twitch02, % corner_standr_alert_twitch04, % corner_standr_alert_twitch05, % corner_standr_alert_twitch06, % corner_standr_alert_twitch07);
  var_0["alert_idle_flinch"] = animscripts\utility::_id_0C6D( % corner_standr_flinch, % corner_standr_flinchb);
  var_0["alert_to_A"] = animscripts\utility::_id_0C6D( % corner_standr_trans_alert_2_a, % corner_standr_trans_alert_2_a_v2);
  var_0["alert_to_B"] = animscripts\utility::_id_0C6D( % corner_standr_trans_alert_2_b, % corner_standr_trans_alert_2_b_v2, % corner_standr_trans_alert_2_b_v3);
  var_0["A_to_alert"] = animscripts\utility::_id_0C6D( % corner_standr_trans_a_2_alert_v2);
  var_0["A_to_alert_reload"] = animscripts\utility::_id_0C6D();
  var_0["A_to_B"] = animscripts\utility::_id_0C6D( % corner_standr_trans_a_2_b, % corner_standr_trans_a_2_b_v2);
  var_0["B_to_alert"] = animscripts\utility::_id_0C6D( % corner_standr_trans_b_2_alert, % corner_standr_trans_b_2_alert_v2, % corner_standr_trans_b_2_alert_v3);
  var_0["B_to_alert_reload"] = animscripts\utility::_id_0C6D( % corner_standr_reload_b_2_alert);
  var_0["B_to_A"] = animscripts\utility::_id_0C6D( % corner_standr_trans_b_2_a, % corner_standr_trans_b_2_a_v2);
  var_0["lean_to_alert"] = animscripts\utility::_id_0C6D( % cornerstndr_lean_2_alert);
  var_0["alert_to_lean"] = animscripts\utility::_id_0C6D( % cornerstndr_alert_2_lean);
  var_0["look"] = % corner_standr_look;
  var_0["reload"] = animscripts\utility::_id_0C6D( % corner_standr_reload_v1);
  var_0["grenade_exposed"] = % corner_standr_grenade_a;
  var_0["grenade_safe"] = % corner_standr_grenade_b;
  var_0["blind_fire"] = animscripts\utility::_id_0C6D( % corner_standr_blindfire_v1, % corner_standr_blindfire_v2);
  var_0["alert_to_look"] = % corner_standr_alert_2_look;
  var_0["look_to_alert"] = % corner_standr_look_2_alert;
  var_0["look_to_alert_fast"] = % corner_standr_look_2_alert_fast;
  var_0["look_idle"] = % corner_standr_look_idle;
  var_0["stance_change"] = % cornercrr_stand_2_alert;
  var_0["lean_aim_down"] = % cornerstndr_lean_aim_2;
  var_0["lean_aim_left"] = % cornerstndr_lean_aim_4;
  var_0["lean_aim_straight"] = % cornerstndr_lean_aim_5;
  var_0["lean_aim_right"] = % cornerstndr_lean_aim_6;
  var_0["lean_aim_up"] = % cornerstndr_lean_aim_8;
  var_0["lean_reload"] = % cornerstndr_lean_reload;
  var_0["lean_idle"] = animscripts\utility::_id_0C6D( % cornerstndr_lean_idle);
  var_0["lean_single"] = % cornerstndr_lean_fire;
  var_0["lean_fire"] = % cornerstndr_lean_auto;

  if(isDefined(anim._id_0FAA)) {
    var_0["rambo90"] = anim._id_0FAA._id_3AA6;
    var_0["rambo45"] = anim._id_0FAA._id_3AA7;
    var_0["grenade_rambo"] = anim._id_0FAA._id_3AA8;
  }

  self._id_2474 = -90;
  self.a._id_0C6D = var_0;
}

_id_3FDF() {
  var_0 = [];
  var_0["alert_idle"] = % cornercrr_alert_idle;
  var_0["alert_idle_twitch"] = animscripts\utility::_id_0C6D( % cornercrr_alert_twitch_v1, % cornercrr_alert_twitch_v2, % cornercrr_alert_twitch_v3);
  var_0["alert_idle_flinch"] = animscripts\utility::_id_0C6D();
  var_0["alert_to_A"] = animscripts\utility::_id_0C6D( % cornercrr_trans_alert_2_a);
  var_0["alert_to_B"] = animscripts\utility::_id_0C6D( % cornercrr_trans_alert_2_b);
  var_0["A_to_alert"] = animscripts\utility::_id_0C6D( % cornercrr_trans_a_2_alert);
  var_0["A_to_alert_reload"] = animscripts\utility::_id_0C6D();
  var_0["A_to_B"] = animscripts\utility::_id_0C6D( % cornercrr_trans_a_2_b);
  var_0["B_to_alert"] = animscripts\utility::_id_0C6D( % cornercrr_trans_b_2_alert);
  var_0["B_to_alert_reload"] = animscripts\utility::_id_0C6D();
  var_0["B_to_A"] = animscripts\utility::_id_0C6D( % cornercrr_trans_b_2_a);
  var_0["lean_to_alert"] = animscripts\utility::_id_0C6D( % cornercrr_lean_2_alert);
  var_0["alert_to_lean"] = animscripts\utility::_id_0C6D( % cornercrr_alert_2_lean);
  var_0["reload"] = animscripts\utility::_id_0C6D( % cornercrr_reloada, % cornercrr_reloadb);
  var_0["grenade_exposed"] = % cornercrr_grenadea;
  var_0["grenade_safe"] = % cornercrr_grenadea;
  var_0["alert_to_over"] = animscripts\utility::_id_0C6D( % cornercrr_alert_2_over);
  var_0["over_to_alert"] = animscripts\utility::_id_0C6D( % cornercrr_over_2_alert);
  var_0["over_to_alert_reload"] = animscripts\utility::_id_0C6D();
  var_0["blind_fire"] = animscripts\utility::_id_0C6D();
  var_0["rambo90"] = animscripts\utility::_id_0C6D();
  var_0["rambo45"] = animscripts\utility::_id_0C6D();
  var_0["alert_to_look"] = % cornercrr_alert_2_look;
  var_0["look_to_alert"] = % cornercrr_look_2_alert;
  var_0["look_to_alert_fast"] = % cornercrr_look_2_alert_fast;
  var_0["look_idle"] = % cornercrr_look_idle;
  var_0["stance_change"] = % cornercrr_alert_2_stand;
  var_0["lean_aim_down"] = % cornercrr_lean_aim_2;
  var_0["lean_aim_left"] = % cornercrr_lean_aim_4;
  var_0["lean_aim_straight"] = % cornercrr_lean_aim_5;
  var_0["lean_aim_right"] = % cornercrr_lean_aim_6;
  var_0["lean_aim_up"] = % cornercrr_lean_aim_8;
  var_0["lean_idle"] = animscripts\utility::_id_0C6D( % cornercrr_lean_idle);
  var_0["lean_single"] = % cornercrr_lean_fire;
  var_0["lean_fire"] = % cornercrr_lean_auto;
  self._id_2474 = -90;
  self.a._id_0C6D = var_0;
}
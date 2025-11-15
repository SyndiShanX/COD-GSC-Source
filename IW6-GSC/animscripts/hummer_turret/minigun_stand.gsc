/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\minigun_stand.gsc
*******************************************************/

#using_animtree("generic_human");

main() {
  var_0 = self getturret();
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self.primaryturretanim = % humveegunner_aim;
  self.additiveturretrotateleft = % humvee_turret_aim_6_add;
  self.additiveturretrotateright = % humvee_turret_aim_4_add;
  self.additiverotateroot = % additive_humveegunner_aim_leftright;
  self.additiveturretidle = % humvee_turret_idle;
  self.additiveturretdriveidle = % humvee_turret_driveidle;
  self.additiveturretfire = % humvee_turret_fire;
  self.additiveusegunroot = % additive_humveegunner_usegun;
  self.turretdeathanimroot = % humveegunner_death;
  self.turretdeathanim = % humvee_turret_death;
  self.turretpainanims[0] = % humvee_turret_paina;
  self.turretpainanims[1] = % humvee_turret_painb;
  self.turretflashbangedanim = % humvee_turret_flincha;
  self.turretreloadanim = % humvee_turret_rechamber;
  self.turretspecialanimsroot = % humveegunner;
  var_1 = [];
  var_1["humvee_turret_bounce"] = % humvee_turret_bounce;
  var_1["humvee_turret_idle_lookback"] = % humvee_turret_idle_lookback;
  var_1["humvee_turret_idle_lookbackB"] = % humvee_turret_idle_lookbackb;
  var_1["humvee_turret_idle_signal_forward"] = % humvee_turret_idle_signal_forward;
  var_1["humvee_turret_idle_signal_side"] = % humvee_turret_idle_signal_side;
  var_1["humvee_turret_radio"] = % humvee_turret_radio;
  var_1["humvee_turret_flinchA"] = % humvee_turret_flincha;
  var_1["humvee_turret_flinchB"] = % humvee_turret_flinchb;
  var_1["humvee_turret_rechamber"] = % humvee_turret_rechamber;
  self.turretspecialanims = var_1;
  var_0 setup_turret_anims();
  thread animscripts\hummer_turret\minigun_code::main(var_0);
}

#using_animtree("vehicles");

setup_turret_anims() {
  self useanimtree(#animtree);
  self.passenger2turret_anime = % humvee_passenger_2_turret_minigun;
  self.turret2passenger_anime = % humvee_turret_2_passenger_minigun;
}
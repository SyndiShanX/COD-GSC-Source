/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\dshk_stand.gsc
****************************************************/

#using_animtree("generic_human");

main() {
  var_0 = self getturret();
  var_1 = get_death_anim();
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  self.primaryturretanim = % gazgunner_aim;
  self.additiveturretrotateleft = % gaz_turret_aim_6_add;
  self.additiveturretrotateright = % gaz_turret_aim_4_add;
  self.additiverotateroot = % additive_gazgunner_aim_leftright;
  self.additiveturretidle = % gaz_turret_idle;
  self.additiveturretdriveidle = % gaz_turret_idle;
  self.additiveturretfire = % gaz_turret_fire;
  self.additiveusegunroot = % additive_gazgunner_usegun;
  self.turretdeathanimroot = % gazgunner_death;
  self.turretdeathanim = var_1;
  self.turretpainanims[0] = % gaz_turret_paina;
  self.turretpainanims[1] = % gaz_turret_painb;
  self.turretflashbangedanim = % gaz_turret_flincha;
  self.turretreloadanim = % gaz_turret_paina;
  self.turretspecialanimsroot = % gazgunner;
  var_2 = [];
  var_2["humvee_turret_flinchA"] = % gaz_turret_flincha;
  var_2["humvee_turret_flinchB"] = % gaz_turret_flinchb;
  self.turretspecialanims = var_2;
  var_0 setup_turret_anims();
  thread animscripts\hummer_turret\minigun_code::main(var_0);
}

get_death_anim() {
  var_0 = % gaz_turret_death;

  if(isDefined(self.ridingvehicle)) {
    if(isDefined(level.dshk_death_anim)) {
      var_0 = self[[level.dshk_death_anim]]();
    }
  }

  return var_0;
}

#using_animtree("vehicles");

setup_turret_anims() {
  self useanimtree(#animtree);
  self.passenger2turret_anime = % humvee_passenger_2_turret_minigun;
  self.turret2passenger_anime = % humvee_turret_2_passenger_minigun;
}
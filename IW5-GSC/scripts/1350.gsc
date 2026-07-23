/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1350.gsc
**************************************/

initcarry() {
  anims();
}

#using_animtree("generic_human");

anims() {
  level.scr_anim["generic"]["wounded_idle"][0] = % wounded_carry_closet_idle_wounded;
  level.scr_anim["generic"]["pickup_wounded"] = % wounded_carry_pickup_closet_wounded_straight;
  level.scr_anim["generic"]["pickup_carrier"] = % wounded_carry_pickup_closet_carrier_straight;
  level.scr_anim["generic"]["wounded_walk_loop"][0] = % wounded_carry_fastwalk_wounded_relative;
  level.scr_anim["generic"]["carrier_walk_loop"] = % wounded_carry_fastwalk_carrier;
  level.scr_anim["generic"]["putdown_wounded"] = % wounded_carry_putdown_closet_wounded;
  level.scr_anim["generic"]["putdown_carrier"] = % wounded_carry_putdown_closet_carrier;
}

setwounded(var_0) {
  animscripts\shared::dropaiweapon();
  self.woundednode = var_0;
  self.woundednode thread maps\_anim::anim_generic_loop(self, "wounded_idle", "stop_wounded_idle");
  self.allowdeath = 1;
}

end_carry_ai_logic(var_0, var_1) {
  level notify("end_carry_ai_logic");
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
  var_0.allowpain = 1;
  var_0.disablebulletwhizbyreaction = 0;
  var_0.ignoreall = 0;
  var_0.grenadeawareness = 1;
  var_0 maps\_utility::setflashbangimmunity(0);
  var_0.dontmelee = undefined;
  var_0.neverenablecqb = undefined;
  var_0.disablearrivals = undefined;
  var_0.disableexits = undefined;
  var_0.nododgemove = 0;
  var_0 pushplayer(0);
  var_1 notify("stop_carried_loop");
  var_1 unlink();
  var_0 maps\_utility::clear_generic_run_anim();
  var_1.woundednode notify("stop_wounded_idle");
  var_1.woundednode = undefined;
}

move_president_to_node(var_0, var_1) {
  level endon("end_carry_ai_logic");
  goto_and_pickup_wounded(var_0, var_1);
  carry_to_and_putdown_wounded(var_0, var_1);
}

move_president_to_node_nopickup(var_0, var_1) {
  var_0 forceteleport(self.origin, self.angles);
  carry_to_and_putdown_wounded(var_0, var_1);
}

goto_and_pickup_wounded(var_0, var_1) {
  level endon("end_carry_ai_logic");
  self endon("end_carry_ai");
  var_0.woundednode maps\_anim::anim_generic_reach(self, "pickup_carrier");
  var_0 notify("stop_wounded_idle");
  var_0.woundednode notify("stop_wounded_idle");
  var_0.allowdeath = 1;
  var_0.woundednode thread maps\_anim::anim_generic(var_0, "pickup_wounded");
  var_0.woundednode maps\_anim::anim_generic(self, "pickup_carrier");
  self.dontmelee = 1;
  var_0 invisiblenotsolid();
}

link_wounded(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 linkTo(self, "tag_origin");
  wait 0.05;
  var_0 thread maps\_anim::anim_generic_loop(var_0, "wounded_walk_loop", "stop_carried_loop");
}

carry_to_and_putdown_wounded(var_0, var_1) {
  level endon("end_carry_ai_logic");
  self endon("end_carry_ai");
  var_0.being_carried = 1;
  thread maps\_utility::set_generic_run_anim("carrier_walk_loop", 1);
  var_0 notify("stop_wounded_idle");
  var_0.woundednode notify("stop_wounded_idle");
  wait 0.05;
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  self animmode("none");
  self.allowpain = 0;
  self.disablebulletwhizbyreaction = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeawareness = 0;
  maps\_utility::setflashbangimmunity(1);
  self.neverenablecqb = 1;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.nododgemove = 1;
  maps\_utility::disable_cqbwalk();
  self.oldgoal = self.goalradius;
  thread link_wounded(var_0);

  while(isDefined(var_1.target)) {
    self.ignoresuppression = 1;
    self.disablearrivals = 1;
    var_2 = getEnt(var_1.target, "targetname");
    var_2 = common_scripts\utility::ter_op(isDefined(var_2), var_2, getnode(var_1.target, "targetname"));

    if(!isDefined(var_2.target)) {
      var_1 = var_2;
      break;
    }

    self.goalradius = 64;
    self setgoalpos(var_2.origin);
    self waittill("goal");
    var_1 = var_2;
  }

  var_1 maps\_anim::anim_generic_reach(self, "putdown_carrier");
  var_0.woundednode = var_1;
  var_0 notify("stop_carried_loop");
  var_1 notify("stop_wounded_idle");
  var_0 unlink();
  self.ignoresuppression = 0;
  self.disablearrivals = 0;
  self.goalradius = self.oldgoal;
  thread maps\_utility::clear_run_anim();
  var_0.woundednode thread maps\_anim::anim_generic(self, "putdown_carrier");
  var_0.woundednode maps\_anim::anim_generic(var_0, "putdown_wounded");
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
  self.allowpain = 1;
  self.disablebulletwhizbyreaction = 0;
  self.ignoreall = 0;
  self.grenadeawareness = 1;
  maps\_utility::setflashbangimmunity(0);
  self.dontmelee = undefined;
  self.neverenablecqb = undefined;
  self.disablearrivals = undefined;
  self.disableexits = undefined;
  self.nododgemove = 0;
  self pushplayer(0);
  var_0 visiblesolid();
  var_0.woundednode thread maps\_anim::anim_generic_loop(var_0, "wounded_idle", "stop_wounded_idle");
  var_0.allowdeath = 1;
  var_0 notify("stop_putdown");
  var_0.being_carried = undefined;
}
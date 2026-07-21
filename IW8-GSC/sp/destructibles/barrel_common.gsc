/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\destructibles\barrel_common.gsc
***********************************************/

barrel_setup(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.phys_barrels))
    level.phys_barrels = [];

  level.phys_barrels = scripts\engine\utility::array_add(level.phys_barrels, self);
  self.onfire = undefined;
  self.subtype = var_0;
  self.isbarrel = 1;
  self setCanDamage(1);
  self.barrel_health = var_1;
  self.phys_barrel_radius = var_2;
  self.phys_amp_normal = var_3;
  self.phys_amp_max = var_4;
  self.min_range_max_amp = var_5;
  self.spewtags = [];
  thread barrel_cleanup();
  thread barrel_nav_obstruction();
}

barrel_nav_obstruction() {
  var_0 = createnavobstaclebybounds(self.origin, (12, 12, 50), (0, 0, 0));
  var_1 = undefined;

  while(isDefined(self) && self.spewtags.size <= 0)
    wait 0.05;

  if(!isDefined(self)) {
    destroynavobstacle(var_0);
    return;
  }

  var_2 = self.phys_barrel_radius / 4.5;
  var_1 = "barrel" + self getentitynumber();
  createnavrepulsor(var_1, -1, self, var_2, 1);
  scripts\engine\utility::waittill_either("barrel_death", "entitydeleted");
  destroynavobstacle(var_0);
}

is_self_detonating(var_0) {
  return self.subtype == "red";
}

barrel_cleanup() {
  scripts\engine\utility::waittill_either("barrel_death", "entitydeleted");
  level.phys_barrels = scripts\engine\utility::array_remove(level.phys_barrels, self);
}

get_barrels(var_0) {
  if(!isDefined(var_0))
    return level.phys_barrels;
  else {
    var_1 = [];

    foreach(var_3 in level.phys_barrels) {
      if(isDefined(var_3.subtype) && var_3.subtype == var_0)
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }

    return var_1;
  }
}

barrel_fusetimer(var_0) {
  self endon("barrel_death");
  self notify("new_barrel_timer");
  self endon("new_barrel_timer");
  wait(var_0);

  while(isDefined(self.dont_explode))
    waitframe();

  self notify("barrel_death");
}

barrel_block_gesture(var_0, var_1) {
  if(level.player isthrowinggrenade() || level.player isthrowingbackgrenade()) {
    return;
  }
  var_2 = distance2dsquared(level.player.origin, var_1);

  if(var_2 > squared(var_0)) {
    return;
  }
  if(var_2 > squared(var_0 * 0.25)) {
    var_3 = vectordot(scripts\engine\utility::flatten_vector(vectorNormalize(var_1 - level.player.origin)), anglesToForward(level.player.angles));

    if(var_3 < 0.0)
      return;
  }

  if(!scripts\engine\trace::ray_trace_passed(var_1 + (0, 0, 12), level.player getEye(), undefined, scripts\engine\trace::create_world_contents())) {
    return;
  }
  level.player thread barrel_reaction_gesture(var_1);
}

barrel_reaction_gesture(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_1);
  var_2 = "ges_frag_block";
  var_3 = self playgestureviewmodel(var_2, var_1, 1, 0.1);

  if(var_3) {
    childthread scripts\sp\player\gestures::player_gestures_input_disable(var_2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4, "barrelReactionGesture");

    for(;;) {
      self waittill("gesture_stopped", var_2);

      if(var_2 == "ges_frag_block") {
        break;
      }
    }
  }

  if(isDefined(var_1))
    var_1 delete();
}

isplayersniperhit(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && var_0 == level.player && var_1.classname == "sniper")
    return 1;

  return 0;
}

isdirectunderbarrelhit(var_0) {
  if(isDefined(var_0) && var_0 == "MOD_IMPACT")
    return 1;

  return 0;
}

isgrenadeinrange(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return 0;

  if(isDefined(var_1) && var_1 != "MOD_GRENADE" && var_1 != "MOD_GRENADE_SPLASH")
    return 0;

  if(!isDefined(var_0)) {
    return;
  }
  var_3 = distance(self.origin, var_0);

  if(var_3 > var_2)
    return 0;

  return 1;
}

isvalidbarreldamage(var_0, var_1) {
  if(isDefined(var_0) && isai(var_0))
    return 0;

  if(isDefined(var_0) && isDefined(var_0.isbarrel))
    return 0;

  if(ismeleedamage(var_1))
    return 0;

  return 1;
}

ismeleedamage(var_0) {
  if(isDefined(var_0) && var_0 == "MOD_MELEE")
    return 1;

  return 0;
}

barrel_launch(var_0, var_1, var_2) {
  self endon("barrel_death");
  wait(var_2);

  if(!isDefined(self)) {
    return;
  }
  var_3 = vectorNormalize(self.origin - var_0);
  var_4 = self.phys_amp_normal;

  if(var_1 <= self.min_range_max_amp)
    var_4 = self.phys_amp_max;

  var_5 = self.phys_barrel_radius - var_1;
  var_6 = var_5 / self.phys_barrel_radius;
  var_6 = var_6 * var_4;
  self physicslaunchserver(self.origin, var_3 * var_6);
}

barrel_one_hit_kill() {
  self waittill("damage");
  waitframe();
  waitframe();
  self notify("barrel_death");
}

barrel_player() {
  self endon("entitydeleted");

  for(;;) {
    while(distancesquared(level.player.origin, self.origin) > squared(40))
      wait 0.05;

    var_0 = self physics_getentitycenterofmass();
    var_0 = var_0["unscaled"] + (0, 0, 4);
    self physicslaunchserver(var_0, vectorNormalize(self.origin - level.player.origin) * 1000);
    wait 0.05;
  }
}

barrel_debug() {
  self endon("barrel_death");
  var_0 = undefined;
  var_1 = undefined;
  setdvarifuninitialized("barrel_debug", 0);

  for(;;) {
    if(!getdvarint("barrel_debug")) {} else
      thread scripts\engine\utility::draw_circle(self.origin, 250, (1, 0, 0), 1, 0, 1);

    wait 0.05;
  }
}
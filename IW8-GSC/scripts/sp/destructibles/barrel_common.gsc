/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\barrel_common.gsc
******************************************************/

function barrel_setup(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(level.phys_barrels)) {
    level.phys_barrels = [];
  }

  level.phys_barrels = scripts\engine\utility::array_add(level.phys_barrels, self);
  self.onfire = undefined;
  self.subtype = var0;
  self.isbarrel = 1;
  self setCanDamage(1);
  self.barrel_health = var1;
  self.phys_barrel_radius = var2;
  self.phys_amp_normal = var3;
  self.phys_amp_max = var4;
  self.min_range_max_amp = var5;
  self.spewtags = [];
  thread barrel_cleanup();
  thread barrel_nav_obstruction();
}

function barrel_nav_obstruction() {
  var0 = createnavobstaclebybounds(self.origin, (12, 12, 50), (0, 0, 0));
  var1 = undefined;

  while(isDefined(self) && self.spewtags.size <= 0) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    destroynavobstacle(var0);
    return;
  }

  var2 = self.phys_barrel_radius / 4.5;
  var1 = "barrel" + self getentitynumber();
  createnavrepulsor(var1, -1, self, var2, 1);
  scripts\engine\utility::waittill_either("barrel_death", "entitydeleted");
  destroynavobstacle(var0);
}

function is_self_detonating(var0) {
  return self.subtype == "red";
}

function barrel_cleanup() {
  scripts\engine\utility::waittill_either("barrel_death", "entitydeleted");
  level.phys_barrels = scripts\engine\utility::array_remove(level.phys_barrels, self);
}

function get_barrels(var0) {
  if(!isDefined(var0)) {
    return level.phys_barrels;
  }

  var1 = [];

  foreach(var3 in level.phys_barrels) {
    if(isDefined(var3.subtype) && var3.subtype == var0) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  return var1;
}

function barrel_fusetimer(var0) {
  self endon("barrel_death");
  self notify("new_barrel_timer");
  self endon("new_barrel_timer");
  wait var0;

  while(isDefined(self.dont_explode)) {
    waitframe();
  }

  self notify("barrel_death");
}

function barrel_block_gesture(var0, var1) {
  if(level.player isthrowinggrenade() || level.player isthrowingbackgrenade()) {
    return;
  }

  var2 = distance2dsquared(level.player.origin, var1);

  if(var2 > squared(var0)) {
    return;
  }

  if(var2 > squared(var0 * 0.25)) {
    var3 = vectordot(scripts\engine\utility::flatten_vector(vectorNormalize(var1 - level.player.origin)), anglesToForward(level.player.angles));

    if(var3 < 0) {
      return;
    }
  }

  if(!scripts\engine\trace::ray_trace_passed(var1 + (0, 0, 12), level.player getEye(), undefined, scripts\engine\trace::create_world_contents())) {
    return;
  }

  thread barrel_reaction_gesture(level.player);
}

function barrel_reaction_gesture(var0) {
  self endon("death");
  var1 = scripts\engine\utility::spawn_tag_origin(var0, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var1);
  var2 = "ges_frag_block";
  var3 = self playgestureviewmodel(var2, var1, 1, 0.1);

  if(var3) {
    childthread scripts\sp\player\gestures::player_gestures_input_disable(var2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4, "barrelReactionGesture");

    for(;;) {
      self waittill("gesture_stopped", var2);

      if(var2 == "ges_frag_block") {
        break;
      }
    }
  }

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function isplayersniperhit(var0, var1) {
  if(isDefined(var0) && isDefined(var1) && var0 == level.player && var1.classname == "sniper") {
    return true;
  }

  return false;
}

function isdirectunderbarrelhit(var0) {
  if(isDefined(var0) && var0 == "MOD_IMPACT") {
    return true;
  }

  return false;
}

function isgrenadeinrange(var0, var1, var2) {
  if(!isDefined(var1)) {
    return 0;
  }

  if(isDefined(var1) && var1 != "MOD_GRENADE" && var1 != "MOD_GRENADE_SPLASH") {
    return 0;
  }

  if(!isDefined(var0)) {
    return;
  }

  var3 = distance(self.origin, var0);

  if(var3 > var2) {
    return 0;
  }

  return 1;
}

function isvalidbarreldamage(var0, var1) {
  if(isDefined(var0) && isai(var0)) {
    return false;
  }

  if(isDefined(var0) && isDefined(var0.isbarrel)) {
    return false;
  }

  if(ismeleedamage(var1)) {
    return false;
  }

  return true;
}

function ismeleedamage(var0) {
  if(isDefined(var0) && var0 == "MOD_MELEE") {
    return true;
  }

  return false;
}

function barrel_launch(var0, var1, var2) {
  self endon("barrel_death");
  wait var2;

  if(!isDefined(self)) {
    return;
  }

  var3 = vectorNormalize(self.origin - var0);
  var4 = self.phys_amp_normal;

  if(var1 <= self.min_range_max_amp) {
    var4 = self.phys_amp_max;
  }

  var5 = self.phys_barrel_radius - var1;
  var6 = var5 / self.phys_barrel_radius;
  var6 *= var4;
  self physicslaunchserver(self.origin, var3 * var6);
}

function barrel_one_hit_kill() {
  self waittill("damage");
  waitframe();
  waitframe();
  self notify("barrel_death");
}

function barrel_player() {
  self endon("entitydeleted");

  for(;;) {
    while(distancesquared(level.player.origin, self.origin) > squared(40)) {
      wait 0.05;
    }

    var0 = self physics_getentitycenterofmass();
    var0 = var0["unscaled"] + (0, 0, 4);
    self physicslaunchserver(var0, vectorNormalize(self.origin - level.player.origin) * 1000);
    wait 0.05;
  }
}

function barrel_debug() {
  self endon("barrel_death");
  var0 = undefined;
  var1 = undefined;
  setdvarifuninitialized("barrel_debug", 0);

  for(;;) {
    if(!getdvarint("barrel_debug")) {} else {
      thread scripts\engine\utility::draw_circle(self.origin, 250, (1, 0, 0), 1, 0, 1);
    }

    wait 0.05;
  }
}
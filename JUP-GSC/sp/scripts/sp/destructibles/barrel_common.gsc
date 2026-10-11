/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\destructibles\barrel_common.gsc
*********************************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\gestures;
#using scripts\sp\utility;
#namespace barrel_common;

function barrel_setup(subtype, barrel_health, barrel_radius, amp_normal, amp_max, min_range_max_amp, repulsor_radius) {
  if(!isDefined(level.phys_barrels)) {
    level.phys_barrels = [];
  }

  level.phys_barrels = array_add(level.phys_barrels, self);
  self.onfire = undefined;
  self.subtype = subtype;
  self.isbarrel = 1;
  self setCanDamage(1);
  self.barrel_health = barrel_health;
  self.phys_barrel_radius = barrel_radius;
  self.phys_amp_normal = amp_normal;
  self.phys_amp_max = amp_max;
  self.min_range_max_amp = min_range_max_amp;
  self.spewtags = [];
  thread barrel_cleanup();
  thread barrel_nav_obstruction();
}

function barrel_nav_obstruction() {
  navobstruction = createnavobstaclebybounds(self.origin, (12, 12, 50), (0, 0, 0));
  repulsor_name = undefined;

  while(isDefined(self) && self.spewtags.size <= 0) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    destroynavobstacle(navobstruction);
    return;
  }

  var_90d8a00109786d78 = self.phys_barrel_radius / 4.5;
  repulsor_name = "barrel" + self getentitynumber();
  createnavrepulsor(repulsor_name, -1, self, var_90d8a00109786d78, 1);
  waittill_either("barrel_death", "entitydeleted");
  destroynavobstacle(navobstruction);
}

function is_self_detonating(subtype) {
  return self.subtype == "red";
}

function barrel_cleanup() {
  waittill_either("barrel_death", "entitydeleted");
  level.phys_barrels = array_remove(level.phys_barrels, self);
}

function get_barrels(subtype) {
  if(!isDefined(subtype)) {
    return level.phys_barrels;
  }

  barrels = [];

  foreach(barrel in level.phys_barrels) {
    if(isDefined(barrel.subtype) && barrel.subtype == subtype) {
      barrels = array_add(barrels, barrel);
    }
  }

  return barrels;
}

function barrel_fusetimer(timer) {
  self endon("barrel_death");
  self notify("new_barrel_timer");
  self endon("new_barrel_timer");
  wait timer;

  while(isDefined(self.dont_explode)) {
    waitframe();
  }

  self notify("barrel_death");
}

function barrel_block_gesture(max_dist, spot) {
  if(level.player isthrowinggrenade() || level.player isthrowingbackgrenade()) {
    return;
  }

  dist = distance2dsquared(level.player.origin, spot);

  if(dist > squared(max_dist)) {
    return;
  }

  if(dist > squared(max_dist * 0.25)) {
    dot = vectordot(flatten_vector(vectorNormalize(spot - level.player.origin)), anglesToForward(level.player.angles));

    if(dot < 0) {
      return;
    }
  }

  if(!scripts\engine\trace::ray_trace_passed(spot + (0, 0, 12), level.player getEye(), undefined, scripts\engine\trace::create_world_contents())) {
    return;
  }

  level.player thread barrel_reaction_gesture(spot);
}

function barrel_reaction_gesture(spot) {
  self endon("death");
  tagorigin = spawn_tag_origin(spot, (0, 0, 0));
  thread delete_on_death(tagorigin);
  gesturename = "ges_frag_block";
  gestureplayed = self playgestureviewmodel(gesturename, tagorigin, 1, 0.1);

  if(gestureplayed) {
    childthread scripts\sp\player\gestures::player_gestures_input_disable(gesturename, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4, "barrelReactionGesture");

    while(true) {
      self waittill("gesture_stopped", gesturename);

      if(gesturename == "ges_frag_block") {
        break;
      }
    }
  }

  if(isDefined(tagorigin)) {
    tagorigin delete();
  }
}

function isplayersniperhit(attacker, objweapon) {
  if(isDefined(attacker) && isDefined(objweapon) && attacker == level.player && objweapon.classname == "sniper") {
    return true;
  }

  return false;
}

function isdirectunderbarrelhit(type) {
  if(isDefined(type) && type == "MOD_IMPACT") {
    return true;
  }

  return false;
}

function isgrenadeinrange(point, type, range) {
  if(!isDefined(type)) {
    return 0;
  }

  if(isDefined(type) && type != "MOD_GRENADE" && type != "MOD_GRENADE_SPLASH") {
    return 0;
  }

  if(!isDefined(point)) {
    return;
  }

  dist = distance(self.origin, point);

  if(dist > range) {
    return 0;
  }

  return 1;
}

function isvalidbarreldamage(attacker, type) {
  if(isDefined(attacker) && isai(attacker)) {
    return false;
  }

  if(isDefined(attacker) && isDefined(attacker.isbarrel)) {
    return false;
  }

  if(ismeleedamage(type)) {
    return false;
  }

  return true;
}

function barrel_launch(explodeorigin, distancefrombarrel, timer) {
  self endon("barrel_death");
  wait timer;

  if(!isDefined(self)) {
    return;
  }

  throwvec = vectorNormalize(self.origin - explodeorigin);
  physamplifier = self.phys_amp_normal;

  if(distancefrombarrel <= self.min_range_max_amp) {
    physamplifier = self.phys_amp_max;
  }

  distcheck = self.phys_barrel_radius - distancefrombarrel;
  throwamplifier = distcheck / self.phys_barrel_radius;
  throwamplifier *= physamplifier;
  self physicslaunchserver(self.origin, throwvec * throwamplifier);
}

function barrel_one_hit_kill() {
  self waittill("damage");
  waitframe();
  waitframe();
  self notify("barrel_death");
}

function barrel_player() {
  self endon("entitydeleted");

  while(true) {
    while(distancesquared(level.player.origin, self.origin) > squared(40)) {
      wait 0.05;
    }

    physorigin = self physics_getentitycenterofmass();
    physorigin = physorigin["unscaled"] + (0, 0, 4);
    self physicslaunchserver(physorigin, vectorNormalize(self.origin - level.player.origin) * 1000);
    wait 0.05;
  }
}

function barrel_debug() {
  self endon("barrel_death");
  starttime = undefined;
  lasttimer = undefined;
  setdvarifuninitialized(@ "barrel_debug", 0);

  for(;;) {
    if(!getdvarint(@ "barrel_debug")) {} else {
      print3d(self gettagorigin("<dev string:x1c>") + (0, 0, 10), self.barrel_health);

      thread draw_circle(self.origin, 250, (1, 0, 0), 1, 0, 1);
    }

    wait 0.05;
  }
}
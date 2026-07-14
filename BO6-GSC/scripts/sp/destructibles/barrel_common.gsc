/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\barrel_common.gsc
******************************************************/

#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\gestures;
#namespace barrel_common;

function barrel_setup(subtype, barrel_health, barrel_radius, amp_normal, amp_max, min_range_max_amp, repulsor_radius) {
  if(!isDefined(level.phys_barrels)) {
    level.phys_barrels = [];
  }

  level.phys_barrels = utility::array_add(level.phys_barrels, self);
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

  var_4ee0f7baa9e8dad9 = self.phys_barrel_radius / 4.5;
  repulsor_name = "\x80\x83\vzF\x9f" + self getentitynumber();
  createnavrepulsor(repulsor_name, -1, self, var_4ee0f7baa9e8dad9, 1);
  utility::waittill_any("m\xd9S\xb0\xae%\xc1dt&\xf9,", "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  destroynavobstacle(navobstruction);
}

function is_self_detonating(subtype) {
  return self.subtype == "\x9b\x9b\v";
}

function barrel_cleanup() {
  utility::waittill_any("m\xd9S\xb0\xae%\xc1dt&\xf9,", "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  level.phys_barrels = arrayremove(level.phys_barrels, self);
}

function get_barrels(subtype) {
  if(!isDefined(subtype)) {
    return level.phys_barrels;
  }

  barrels = [];

  foreach(barrel in level.phys_barrels) {
    if(isDefined(barrel.subtype) && barrel.subtype == subtype) {
      barrels = utility::array_add(barrels, barrel);
    }
  }

  return barrels;
}

function barrel_fusetimer(timer) {
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
  self notify("yNI\\\x0e\x9f\xfe\xd5Vq\xc2\x13&`A\xf7");
  self endon("yNI\\\x0e\x9f\xfe\xd5Vq\xc2\x13&`A\xf7");
  wait timer;

  while(isDefined(self.dont_explode)) {
    waitframe();
  }

  self notify("m\xd9S\xb0\xae%\xc1dt&\xf9,");
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
    dot = vectordot(utility::flatten_vector(vectorNormalize(spot - level.player.origin)), anglesToForward(level.player.angles));

    if(dot < 0) {
      return;
    }
  }

  if(!trace::ray_trace_passed(spot + (0, 0, 12), level.player getEye(), undefined, trace::create_world_contents())) {
    return;
  }

  level.player thread barrel_reaction_gesture(spot);
}

function barrel_reaction_gesture(spot) {
  self endon("\x1e\xfd\xd1\xa2\a");
  tagorigin = utility::spawn_tag_origin(spot, (0, 0, 0));
  thread utility::delete_on_death(tagorigin);
  gesturename = "?H\xbf\x828S\x85s=Q\xb8\xa8g\x8b";
  gestureplayed = 0;

  if(!isnullweapon(self getcurrentweapon())) {
    gestureplayed = self playgestureviewmodel(gesturename, tagorigin, 1, 0.1);
  }

  if(gestureplayed) {
    childthread gestures::player_gestures_input_disable(gesturename, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4, "?T\xf3\xfa2wRW\x01G\xb3\xe2\xea\x02\xe1\xc64z%\xf5\xde");

    while(true) {
      self waittill("\x9f\x02\x98?\xad\x96kb\x0e\x86(wT\xaf\xb1", gesturename);

      if(gesturename == "?H\xbf\x828S\x85s=Q\xb8\xa8g\x8b") {
        break;
      }
    }
  }

  if(isDefined(tagorigin)) {
    tagorigin delete();
  }
}

function isplayersniperhit(attacker, objweapon) {
  if(isDefined(attacker) && isDefined(objweapon) && attacker == level.player && objweapon.classname == "\xff\x12\x9a\xbe.a") {
    return true;
  }

  return false;
}

function isdirectunderbarrelhit(type) {
  if(isDefined(type) && type == "M\x81\xaf\xee\xc9\xcfD\xef\x91J") {
    return true;
  }

  return false;
}

function isgrenadeinrange(point, type, range) {
  if(!isDefined(type)) {
    return 0;
  }

  if(isDefined(type) && type != "\x9az\x88\xfat)*\xe4\x14\x11\x15" && type != "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a") {
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

  if(utility::ismeleedamage(type)) {
    return false;
  }

  return true;
}

function barrel_launch(explodeorigin, distancefrombarrel, timer) {
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
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
  self waittill("\fU`\xc0y\x95");
  waitframe();
  waitframe();
  self notify("m\xd9S\xb0\xae%\xc1dt&\xf9,");
}

function barrel_player() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(true) {
    while(distancesquared(level.player.origin, self.origin) > squared(40)) {
      wait 0.05;
    }

    physorigin = self physics_getentitycenterofmass();
    physorigin = physorigin["-\x9d\x16\xf4m}\x12M"] + (0, 0, 4);
    self physicslaunchserver(physorigin, vectorNormalize(self.origin - level.player.origin) * 1000);
    wait 0.05;
  }
}

function barrel_debug() {
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
  starttime = undefined;
  lasttimer = undefined;
  setdvarifuninitialized(@ "barrel_debug", 0);

  for(;;) {
    if(!getdvarint(@ "barrel_debug")) {} else {
      print3d(self gettagorigin("<dev string:x24>") + (0, 0, 10), self.barrel_health);

      thread utility::draw_circle(self.origin, 250, (1, 0, 0), 1, 0, 1);
    }

    wait 0.05;
  }
}
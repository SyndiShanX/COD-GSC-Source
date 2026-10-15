/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_26187f7b449f7b92.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace doa_chicken;

function init() {
  level.doa.var_69216afe = [];
  level.doa.var_44b1769d = getweapon("zombietron_lmg");
}

function function_174651ce(bird) {
  bird notify(#"hash_44f0d6121a2adcc6");
  bird endon(#"hash_44f0d6121a2adcc6");
  bird endon(#"death");
  bird useanimtree("generic");
  curanim = "a_chicken_react_up_down";
  lastanim = "a_chicken_idle_peck";

  while(isDefined(bird)) {
    if(is_true(self.var_89dad306)) {
      curanim = "a_chicken_react_up_down";
    } else if(is_true(self.var_e1e5d308)) {
      curanim = "a_chicken_react_up_down";
    } else if(is_true(self.var_329aedd)) {
      curanim = "a_chicken_react_up_down";
      self.var_329aedd = undefined;
    } else if(is_true(self.is_dancing)) {
      curanim = "a_chicken_react_to_front_notrans";
    } else if(is_true(self.is_moving)) {
      curanim = "a_chicken_run";
    }

    animlength = getanimlength(curanim);
    bird.angles = self.angles;
    bird thread animation::play(curanim);
    wait animlength;
    lastanim = curanim;

    switch (randomint(3)) {
      case 0:
        curanim = "a_chicken_idle_peck";
        break;
      case 1:
        curanim = "a_chicken_idle_a";
        break;
      case 2:
        curanim = "a_chicken_idle";
        break;
    }
  }
}

function chicken_idle() {
  self.angles = (0, self.angles[1], 0);
  self thread function_174651ce(self);
  self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_chicken_squawk");
}

function add_a_chicken(model, scale, fated, var_706dd25e) {
  if(!isDefined(self.doa)) {
    return;
  }

  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  orb = namespace_ec06fe4a::spawnmodel(self.origin + (0, 0, 30), "tag_origin", self.angles);

  if(isDefined(orb)) {
    orb.targetname = "add_a_chicken";
    orb enablelinkTo();
    orb notsolid();
  } else {
    return;
  }

  bird = namespace_ec06fe4a::spawnmodel(orb.origin, scale, self.angles);

  if(isDefined(bird)) {
    bird.targetname = "chicken";
    bird linkTo(orb, "tag_origin");
    bird notsolid();
    bird setscale(fated);
  } else {
    orb delete();
    return;
  }

  orb.basescale = fated;
  orb.bird = bird;
  bird.orb = orb;
  orb.player = self;
  orb.owner = self;
  bird.owner = self;
  bird.var_7b9e42c2 = 1;
  bird.killcount = 0;
  bird.team = self.team;
  bird.donotdamageowner = 1;
  orb.team = self.team;
  orb.special = var_706dd25e;
  orb.weaponbonus = 0;
  orb.plumpness = 0;
  arrayremovevalue(self.doa.chicken_stack, undefined);
  orb.var_ce3eecd4 = self.doa.chicken_stack.size == 0 ? self : self.doa.chicken_stack[self.doa.chicken_stack.size - 1];
  orb thread function_174651ce(bird);

  if(is_true(orb.special) && self.doa.chicken_stack.size > 0) {
    arrayinsert(self.doa.chicken_stack, orb, 0);
    nextleader = self;

    foreach(chicken in self.doa.chicken_stack) {
      chicken.var_ce3eecd4 = nextleader;
      nextleader = chicken;
    }
  } else {
    self.doa.chicken_stack[self.doa.chicken_stack.size] = orb;
  }

  function_e67a092e(self);

  if(self.doa.chicken_stack.size > 5) {
    self function_fde39570();
  }

  orb thread function_a083a332(self);
  orb thread function_1284a4d7(self);
  orb thread function_723d0c4c(self);
  orb thread function_26d43617(self);
  orb thread function_a5d7e43d();
  orb thread function_e4dfa7dc();
  orb thread function_9d0fe581(self);
  orb thread function_5d7057fa();

  if(is_true(var_706dd25e)) {
    orb thread function_8f7ae651();
  }

  return orb;
}

function function_fde39570() {
  if(!isDefined(self.doa.chicken_stack)) {
    return;
  }

  bird = undefined;

  foreach(bird in self.doa.chicken_stack) {
    if(is_true(bird.special)) {
      continue;
    }

    bird notify(#"spin_out", 1);
    break;
  }
}

function function_f30a62f4() {
  if(!isDefined(self.doa.chicken_stack)) {
    return;
  }

  foreach(bird in self.doa.chicken_stack) {
    if(is_true(bird.special)) {
      continue;
    }

    bird notify(#"spin_out", 1);
  }
}

function function_a083a332(player) {
  self endon(#"death");
  player waittill(#"disconnect");

  if(is_true(self.special)) {
    self function_a7be9625();
    return;
  }

  self notify(#"spin_out");
}

function function_a7be9625() {
  if(is_true(self.special)) {
    self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_chicken_squawk_spinout");
    self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_chicken_explode");
    self.bird doa_fx::function_3ecfde67("chicken_explode");
    util::wait_network_frame();

    if(isDefined(self.bird)) {
      self.bird delete();
    }

    self delete();
    return;
  }

  self notify(#"spin_out");
}

function function_5d7057fa() {
  self endon(#"death");
  level waittill(#"game_over");
  self function_a7be9625();
}

function function_1284a4d7(player) {
  self notify("5374cb0351ab3b5a");
  self endon("5374cb0351ab3b5a");
  self endon(#"death");

  if(is_true(self.special)) {
    return;
  }

  result = self waittill(#"spin_out");
  waittillframeend();
  self notify(#"spinning_out");

  if(isDefined(player)) {
    arrayremovevalue(player.doa.chicken_stack, self);
    function_e67a092e(player);
  }

  if(!is_true(result.immediate)) {
    self.var_89dad306 = 1;
    self.spinouttime = 0;

    if(isDefined(player)) {
      lastleader = player;

      foreach(chicken in player.doa.chicken_stack) {
        chicken.var_ce3eecd4 = lastleader;
        lastleader = chicken;
      }

      player doa_player_utility::function_61d74d57();
      weapon = function_26c8b67(player);
      firetime = 0.15;
      self.spinouttime = randomfloatrange(5, 8);
    }

    while(self.spinouttime > 0) {
      rotate180time = 1;
      self rotateTo(self.angles + (0, 180, 0), rotate180time);
      localrotatetime = rotate180time;

      while(localrotatetime > 0) {
        extrawait = self function_ecec052c(player, weapon);
        interval = firetime + extrawait;
        wait interval;
        localrotatetime -= interval;
      }

      self.spinouttime -= rotate180time;
    }
  }

  self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_chicken_explode");
  self.bird doa_fx::function_3ecfde67("chicken_explode");
  util::wait_network_frame();

  if(isDefined(self.bird)) {
    self.bird delete();
  }

  self delete();
}

function function_a46136b9(leader) {
  self notify("4ec2da181d712b39");
  self endon("4ec2da181d712b39");
  self endon(#"death");
  self endon(#"spinning_out");
  var_f07c128e = isPlayer(leader);

  if(var_f07c128e) {
    leader endon(#"disconnect");
  } else {
    leader endon(#"death");
    leader endon(#"spinning_out");
  }

  waitframe(1);
  follow_pt = self.origin;

  while(isDefined(leader)) {
    if(distance2dsquared(leader.origin, follow_pt) > sqr(5)) {
      follow_pt = leader.origin;

      if(var_f07c128e) {
        if(is_true(leader.doa.infps) || isDefined(self.var_706dd25e)) {
          z = 20;
        } else {
          z = 30;
        }

        follow_pt += (0, 0, z);
      }

      if(!isDefined(self.follow_points)) {
        self.follow_points = [];
      } else if(!isarray(self.follow_points)) {
        self.follow_points = array(self.follow_points);
      }

      self.follow_points[self.follow_points.size] = follow_pt;
    }

    waitframe(1);
  }
}

function function_9d0fe581(player) {
  self endon(#"death");
  self endon(#"spinning_out");
  player endon(#"disconnect");
  follow_index = 0;
  self.var_ce3eecd4.var_85f8774c = 1;
  force = 0;
  var_ff7dfde4 = 0;
  var_afc473d1 = sqr(72);

  while(isDefined(self.var_ce3eecd4)) {
    if(is_true(self.var_ce3eecd4.var_85f8774c)) {
      self.follow_points = [];
      forward = anglesToForward(self.var_ce3eecd4.angles);
      origin = self.var_ce3eecd4.origin + forward * -25;

      for(seeds = 5; seeds; seeds--) {
        if(!isDefined(self.follow_points)) {
          self.follow_points = [];
        } else if(!isarray(self.follow_points)) {
          self.follow_points = array(self.follow_points);
        }

        self.follow_points[self.follow_points.size] = origin;
      }

      self.var_ce3eecd4.var_85f8774c = 0;
      self thread function_a46136b9(self.var_ce3eecd4);
      self moveTo(origin, 0.25);
      self waittill(#"movedone");
    }

    if(isPlayer(self.var_ce3eecd4)) {
      angles = self.var_ce3eecd4 getplayerangles();
    } else {
      angles = self.var_ce3eecd4.angles;
    }

    self.angles = (angles[0], angles[1], 0);
    self.bird.angles = self.angles;
    self.bird.origin = self.origin;

    if(self.follow_points.size > 5 || force && self.follow_points.size > 1) {
      point = self.follow_points[0];
      arrayremoveindex(self.follow_points, 0);
      self.movetime = 0.05;

      if(isPlayer(self.var_ce3eecd4)) {
        self.norm_move = length2d(player getnormalizedmovement());
        behind = self.follow_points.size - 5;
        magnitude = math::clamp(self.norm_move + behind * 0.2, 0, 1);
        self.movetime = mapfloat(0, 1, 0.05, 0.2, 1 - magnitude);
        namespace_1e25ad94::debugmsg("Movement: " + self.norm_move + "Magnitude:" + magnitude + "Move time:" + self.movetime + " Behind by:" + behind);
      } else if(isDefined(self.var_ce3eecd4.norm_move)) {
        self.norm_move = self.var_ce3eecd4.norm_move;
        behind = self.follow_points.size - 5;
        magnitude = math::clamp(self.norm_move + behind * 0.2, 0, 1);
        self.movetime = mapfloat(0, 1, 0.05, 0.2, 1 - magnitude);
      }

      self.is_moving = 1;
      self moveTo(point, self.movetime, 0, 0);
      self waittill(#"movedone");
      continue;
    }

    time = gettime();

    if(time > var_ff7dfde4) {
      distsq = distancesquared(self.origin, self.var_ce3eecd4.origin);

      if(distsq > var_afc473d1) {
        force = 1;
      } else {
        var_ff7dfde4 = time + 1000;
        force = 0;
      }
    }

    self.is_moving = 0;
    waitframe(1);
  }
}

function function_723d0c4c(player) {
  self endon(#"spinning_out");
  self endon(#"death");

  if(is_true(self.special)) {
    return;
  }

  timesec = player doa_fate::function_4808b985(60);

  if(player doa_fate::function_d5b51f1e()) {
    timesec += 60;
  }

  time = timesec * 1000;

  while(!doa_pickups::function_f759a457()) {
    waitframe(1);
  }

  timeout = gettime() + time;

  while(gettime() < timeout) {
    result = player waittilltimeout(0.25, #"player_died", #"disconnect");

    if(result._notify != #"timeout") {
      self.lastweapon = self function_26c8b67(player, self.special);
      self notify(#"spin_out");
      return;
    }

    if(level flag::get("doa_game_is_over")) {
      self notify(#"spin_out");
    }

    wait 0.25;
  }

  while(is_true(self.var_e1e5d308) || is_true(self.is_dancing)) {
    wait 1;
  }

  self notify(#"spin_out");
}

function function_26c8b67(player, fated = 0) {
  if(isDefined(self.lastweapon)) {
    return self.lastweapon;
  }

  if(is_true(level.var_4bf9ea19)) {
    weapon = player getcurrentweapon();
  } else {
    assert(isDefined(player.doa.var_9c7d56c1));

    if(fated == 0) {
      weapon = player.doa.var_9c7d56c1;
    } else {
      weapon = player.doa.var_4eda72ee;
    }
  }

  return weapon;
}

function function_56f05e91(player) {
  player endon(#"disconnect");
  self endon(#"death");

  while(isDefined(self) && !is_true(self.var_89dad306)) {
    if(isDefined(player.doa.vehicle)) {
      msg = player.doa.vehicle waittilltimeout(0.1, #"weapon_fired", #"gunner_weapon_fired", #"death");
    } else {
      msg = player waittilltimeout(0.1, #"weapon_fired", #"gunner_weapon_fired");
    }

    if(msg._notify != "timeout") {
      self notify(#"chicken_fire");
    }
  }
}

function function_26d43617(player) {
  self endon(#"death");
  self endon(#"spinning_out");
  player endon(#"disconnect");
  self thread function_56f05e91(player);

  while(true) {
    self waittill(#"chicken_fire");

    if(is_true(self.var_a446cf09)) {
      continue;
    }

    weapon = self function_26c8b67(player, self.special);
    extrawait = self function_ecec052c(player, weapon);
    extrawait += weapon.firetime - 0.05;

    if(extrawait > 0) {
      wait extrawait;
    }
  }
}

function private function_ecec052c(player, weapon) {
  extrawait = 0;
  owner = self.bird;
  angles = (self.angles[0], self.angles[1], 0);

  if(isDefined(player)) {
    if(is_true(player.doa.infps)) {
      viewangles = player getplayerangles();
      angles = (viewangles[0], self.angles[1], 0);
    }
  }

  forward = anglesToForward(angles);
  offset = forward * 12 + (0, 0, 6);
  start = self.bird.origin + offset;

  if(getdvarint(#"scr_doa_debug_chicken_fire", 0)) {
    level thread namespace_1e25ad94::debugpoint(start, 5, 20, (1, 0, 0));
    level thread namespace_1e25ad94::debugline(start, self.origin + forward * 1000, 5, (1, 0, 0));
  }

  if(weapon != level.weaponnone) {
    if(level.doa.var_69216afe.size && isinarray(level.doa.var_69216afe, weapon)) {
      weapon = level.doa.var_44b1769d;
    }

    if(isDefined(weapon.var_69baf44a)) {
      stacksize = 1;

      if(isDefined(player)) {
        stacksize = player.doa.chicken_stack.size;
      }

      if(stacksize > weapon.var_69baf44a && isDefined(weapon.var_f9fc5587) && self.stackindex >= weapon.var_69baf44a) {
        weapon = weapon.var_f9fc5587;
      }
    }

    if(is_true(weapon.isprojectileweapon)) {
      if(namespace_ec06fe4a::function_a8975c67(16)) {
        projectile = magicbullet(weapon, start, start + forward * 1000, owner);
      } else {
        extrawait = 0.2;
      }
    } else if(namespace_ec06fe4a::function_a8975c67()) {
      projectile = magicbullet(weapon, start, start + forward * 1000, owner);
    } else {
      extrawait = 0.2;
    }

    if(isDefined(projectile)) {
      projectile.chicken = owner;
    }
  }

  return extrawait;
}

function function_e4dfa7dc() {
  self endon(#"spinning_out");
  self endon(#"death");

  while(isDefined(self)) {
    rand = randomintrange(0, 100);

    if(rand > 50) {
      self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_chicken_squawk");
    }

    wait randomfloatrange(1, 3);
  }
}

function function_a5d7e43d() {
  self endon(#"death");
  self waittill(#"spinning_out");

  while(isDefined(self)) {
    self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_chicken_squawk_spinout");
    wait randomfloatrange(0.5, 1);
  }
}

function function_73b8cd81() {
  self notify(#"chicken_disconnect_watch");
  self endon(#"chicken_disconnect_watch");
  msg = self waittill(#"death", #"disconnect", #"chicken_disconnect_watch");

  foreach(chicken in self.doa.chicken_stack) {
    if(!isDefined(chicken)) {
      continue;
    }

    if(msg._notify == "disconnect" || !is_true(chicken.special)) {
      chicken notify(#"spin_out");
    }
  }
}

function chickenpickup(model, fated = 0, scale = 1) {
  if(!isDefined(self.doa.chicken_stack)) {
    self.doa.chicken_stack = [];
  }

  self thread function_73b8cd81();
  var_b8bb1cdf = self add_a_chicken(model, scale, fated != 0, fated == 2);

  if(self.doa.chicken_stack.size >= 5) {
    self giveachievement(#"doa_achievement_5_piece");
  }

  return var_b8bb1cdf;
}

function function_13c591b6(player) {
  number = 0;

  foreach(chicken in player.doa.chicken_stack) {
    if(chicken == self) {
      break;
    }

    number++;
  }

  return number;
}

function function_e67a092e(player) {
  number = 0;

  foreach(chicken in player.doa.chicken_stack) {
    chicken.stackindex = number;
    number++;
  }
}

function function_8f7ae651() {
  self endon(#"spinning_out");
  self endon(#"death");
  var_52acc12f = randomintrange(720, 1800);

  while(var_52acc12f > 0) {
    while(level.doa.world_state != 0 || level flag::get("doa_round_paused") || !level flag::get("doa_round_spawning") || is_true(level.hostmigrationtimer)) {
      waitframe(1);
    }

    wait 1;
    var_52acc12f -= 1;
    var_52acc12f -= self.bird.killcount;
    self.bird.killcount = 0;
  }

  roll = randomint(100);
  self.bird thread namespace_6e90e490::function_47e11416(48, 2);
  wait 0.6;

  if(roll > 15) {
    def = doa_pickups::function_6265bde4("zombietron_egg");
  } else {
    def = doa_pickups::function_6265bde4("zombietron_egg_golden");
  }

  doa_pickups::itemspawn(def, self.origin, self.angles, undefined, 1, "none", undefined, undefined, undefined, undefined, 0);
  self thread function_8f7ae651();
}
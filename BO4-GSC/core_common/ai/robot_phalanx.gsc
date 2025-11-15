/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\robot_phalanx.gsc
***********************************************/

#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\values_shared;

#namespace robotphalanx;

class robotphalanx {
  var breakingpoint_;
  var currentrobotcount_;
  var endposition_;
  var phalanxtype_;
  var scattered_;
  var startposition_;
  var startrobotcount_;
  var tier1robots_;
  var tier2robots_;
  var tier3robots_;

  constructor() {
    tier1robots_ = [];
    tier2robots_ = [];
    tier3robots_ = [];
    startrobotcount_ = 0;
    currentrobotcount_ = 0;
    breakingpoint_ = 0;
    scattered_ = 0;
  }

  function scatterphalanx() {
    if(!scattered_) {
      scattered_ = 1;
      _releaserobots(tier1robots_);
      tier1robots_ = [];
      _assignphalanxstance(tier2robots_, "crouch");
      wait randomfloatrange(5, 7);
      _releaserobots(tier2robots_);
      tier2robots_ = [];
      _assignphalanxstance(tier3robots_, "crouch");
      wait randomfloatrange(5, 7);
      _releaserobots(tier3robots_);
      tier3robots_ = [];
    }
  }

  function resumefire() {
    _resumefirerobots(tier1robots_);
    _resumefirerobots(tier2robots_);
    _resumefirerobots(tier3robots_);
  }

  function resumeadvance() {
    if(!scattered_) {
      _assignphalanxstance(tier1robots_, "stand");
      wait 1;
      forward = vectornormalize(endposition_ - startposition_);
      _movephalanxtier(tier1robots_, phalanxtype_, "phalanx_tier1", endposition_, forward);
      _movephalanxtier(tier2robots_, phalanxtype_, "phalanx_tier2", endposition_, forward);
      _movephalanxtier(tier3robots_, phalanxtype_, "phalanx_tier3", endposition_, forward);
      _assignphalanxstance(tier1robots_, "crouch");
    }
  }

  function initialize(phalanxtype, origin, destination, breakingpoint, maxtiersize = 10, tieronespawner = undefined, tiertwospawner = undefined, tierthreespawner = undefined) {
    assert(isstring(phalanxtype));
    assert(isint(breakingpoint));
    assert(isvec(origin));
    assert(isvec(destination));
    maxtiersize = math::clamp(maxtiersize, 1, 10);
    forward = vectornormalize(destination - origin);
    tier1robots_ = _createphalanxtier(phalanxtype, "phalanx_tier1", origin, forward, maxtiersize, tieronespawner);
    tier2robots_ = _createphalanxtier(phalanxtype, "phalanx_tier2", origin, forward, maxtiersize, tiertwospawner);
    tier3robots_ = _createphalanxtier(phalanxtype, "phalanx_tier3", origin, forward, maxtiersize, tierthreespawner);
    _assignphalanxstance(tier1robots_, "crouch");
    _movephalanxtier(tier1robots_, phalanxtype, "phalanx_tier1", destination, forward);
    _movephalanxtier(tier2robots_, phalanxtype, "phalanx_tier2", destination, forward);
    _movephalanxtier(tier3robots_, phalanxtype, "phalanx_tier3", destination, forward);
    startrobotcount_ = tier1robots_.size + tier2robots_.size + tier3robots_.size;
    breakingpoint_ = breakingpoint;
    startposition_ = origin;
    endposition_ = destination;
    phalanxtype_ = phalanxtype;
    self thread _updatephalanxthread(self);
  }

  function haltadvance() {
    if(!scattered_) {
      _haltadvance(tier1robots_);
      _haltadvance(tier2robots_);
      _haltadvance(tier3robots_);
    }
  }

  function haltfire() {
    _haltfire(tier1robots_);
    _haltfire(tier2robots_);
    _haltfire(tier3robots_);
  }

  function private _updatephalanx() {
    if(scattered_) {
      return false;
    }

    tier1robots_ = _prunedead(tier1robots_);
    tier2robots_ = _prunedead(tier2robots_);
    tier3robots_ = _prunedead(tier3robots_);
    currentrobotcount_ = tier1robots_.size + tier2robots_.size + tier2robots_.size;

    if(currentrobotcount_ <= startrobotcount_ - breakingpoint_) {
      scatterphalanx();
      return false;
    }

    return true;
  }

  function private _updatephalanxthread(phalanx) {
    while([
        [phalanx]
      ] - > _updatephalanx()) {
      wait 1;
    }
  }

  function private _rotatevec(vector, angle) {
    return (vector[0] * cos(angle) - vector[1] * sin(angle), vector[0] * sin(angle) + vector[1] * cos(angle), vector[2]);
  }

  function private _resumefirerobots(robots) {
    assert(isarray(robots));

    foreach(robot in robots) {
      _resumefire(robot);
    }
  }

  function private _resumefire(robot) {
    if(isDefined(robot) && isalive(robot)) {
      robot val::reset(#"halt_fire", "ignoreall");
    }
  }

  function private _releaserobots(robots) {
    foreach(robot in robots) {
      _resumefire(robot);
      _releaserobot(robot);
      wait randomfloatrange(0.5, 5);
    }
  }

  function private _releaserobot(robot) {
    if(isDefined(robot) && isalive(robot)) {
      robot function_d4c687c9();
      robot pathmode("move delayed", 1, randomfloatrange(0.5, 1));
      robot ai::set_behavior_attribute("phalanx", 0);
      waitframe(1);

      if(isDefined(robot) && isalive(robot)) {
        robot ai::set_behavior_attribute("move_mode", "normal");
        robot ai::set_behavior_attribute("force_cover", 0);
        robot setavoidancemask("avoid all");
        aiutility::removeaioverridedamagecallback(robot, &_dampenexplosivedamage);
      }
    }
  }

  function private _prunedead(robots) {
    liverobots = [];

    foreach(index, robot in robots) {
      if(isDefined(robot) && isalive(robot)) {
        liverobots[index] = robot;
      }
    }

    return liverobots;
  }

  function private _movephalanxtier(robots, phalanxtype, tier, destination, forward) {
    positions = _getphalanxpositions(phalanxtype, tier);
    angles = vectortoangles(forward);
    assert(robots.size <= positions.size, "<dev string:x1da>");

    foreach(index, robot in robots) {
      if(isDefined(robot) && isalive(robot)) {
        assert(isvec(positions[index]), "<dev string:x21c>" + index + "<dev string:x24b>" + tier + "<dev string:x258>" + phalanxtype);
        orientedpos = _rotatevec(positions[index], angles[1] - 90);
        navmeshposition = getclosestpointonnavmesh(destination + orientedpos, 200);
        robot function_a57c34b7(navmeshposition);
      }
    }
  }

  function private _initializerobot(robot) {
    assert(isactor(robot));
    robot ai::set_behavior_attribute("phalanx", 1);
    robot ai::set_behavior_attribute("move_mode", "marching");
    robot ai::set_behavior_attribute("force_cover", 1);
    robot setavoidancemask("avoid none");
    aiutility::addaioverridedamagecallback(robot, &_dampenexplosivedamage, 1);
  }

  function private _haltfire(robots) {
    assert(isarray(robots));

    foreach(robot in robots) {
      if(isDefined(robot) && isalive(robot)) {
        robot val::set(#"halt_fire", "ignoreall", 1);
      }
    }
  }

  function private _haltadvance(robots) {
    assert(isarray(robots));

    foreach(robot in robots) {
      if(isDefined(robot) && isalive(robot) && robot haspath()) {
        navmeshposition = getclosestpointonnavmesh(robot.origin, 200);
        robot function_a57c34b7(navmeshposition);
        robot clearpath();
      }
    }
  }

  function private _getphalanxspawner(tier) {
    spawner = getspawnerarray(tier, "targetname");
    assert(spawner.size >= 0, "<dev string:x6f>" + "<dev string:xbd>" + "<dev string:x107>");
    assert(spawner.size == 1, "<dev string:x120>" + "<dev string:x16c>" + "<dev string:x194>");
    return spawner[0];
  }

  function private _getphalanxpositions(phalanxtype, tier) {
    switch (phalanxtype) {
      case #"phanalx_wedge":
        switch (tier) {
          case #"phalanx_tier1":
            return array((0, 0, 0), (-64, -48, 0), (64, -48, 0), (-128, -96, 0), (128, -96, 0));
          case #"phalanx_tier2":
            return array((-32, -96, 0), (32, -96, 0));
          case #"phalanx_tier3":
            return array();
        }

        break;
      case #"phalanx_diagonal_left":
        switch (tier) {
          case #"phalanx_tier1":
            return array((0, 0, 0), (-48, -64, 0), (-96, -128, 0), (-144, -192, 0));
          case #"phalanx_tier2":
            return array((64, 0, 0), (16, -64, 0), (-48, -128, 0), (-112, -192, 0));
          case #"phalanx_tier3":
            return array();
        }

        break;
      case #"phalanx_diagonal_right":
        switch (tier) {
          case #"phalanx_tier1":
            return array((0, 0, 0), (48, -64, 0), (96, -128, 0), (144, -192, 0));
          case #"phalanx_tier2":
            return array((-64, 0, 0), (-16, -64, 0), (48, -128, 0), (112, -192, 0));
          case #"phalanx_tier3":
            return array();
        }

        break;
      case #"phalanx_forward":
        switch (tier) {
          case #"phalanx_tier1":
            return array((0, 0, 0), (64, 0, 0), (128, 0, 0), (192, 0, 0));
          case #"phalanx_tier2":
            return array((-32, -64, 0), (32, -64, 0), (96, -64, 0), (160, -64, 0));
          case #"phalanx_tier3":
            return array();
        }

        break;
      case #"phalanx_column":
        switch (tier) {
          case #"phalanx_tier1":
            return array((0, 0, 0), (-64, 0, 0), (0, -64, 0), (-64, -64, 0));
          case #"phalanx_tier2":
            return array((0, -128, 0), (-64, -128, 0), (0, -192, 0), (-64, -192, 0));
          case #"phalanx_tier3":
            return array();
        }

        break;
      case #"phalanx_column_right":
        switch (tier) {
          case #"phalanx_tier1":
            return array((0, 0, 0), (0, -64, 0), (0, -128, 0), (0, -192, 0));
          case #"phalanx_tier2":
            return array();
          case #"phalanx_tier3":
            return array();
        }

        break;
      default:
        assert("<dev string:x38>" + phalanxtype + "<dev string:x51>");
        break;
    }

    assert("<dev string:x56>" + tier + "<dev string:x51>");
  }

  function private _dampenexplosivedamage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    isexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdamage);

    if(isexplosive && isDefined(inflictor) && isDefined(inflictor.weapon)) {
      weapon = inflictor.weapon;
      distancetoentity = distance(entity.origin, inflictor.origin);
      fractiondistance = 1;

      if(weapon.explosionradius > 0) {
        fractiondistance = (weapon.explosionradius - distancetoentity) / weapon.explosionradius;
      }

      return int(max(damage * fractiondistance, 1));
    }

    return damage;
  }

  function private _createphalanxtier(phalanxtype, tier, phalanxposition, forward, maxtiersize, spawner = undefined) {
    robots = [];

    if(!isspawner(spawner)) {
      spawner = _getphalanxspawner(tier);
    }

    positions = _getphalanxpositions(phalanxtype, tier);
    angles = vectortoangles(forward);

    foreach(index, position in positions) {
      if(index >= maxtiersize) {
        break;
      }

      orientedpos = _rotatevec(position, angles[1] - 90);
      navmeshposition = getclosestpointonnavmesh(phalanxposition + orientedpos, 200);

      if(!(spawner.spawnflags&64)) {
        spawner.count++;
      }

      robot = spawner spawner::spawn(1, "", navmeshposition, angles);

      if(isalive(robot)) {
        _initializerobot(robot);
        waitframe(1);
        robots[robots.size] = robot;
      }
    }

    return robots;
  }

  function private _assignphalanxstance(robots, stance) {
    assert(isarray(robots));

    foreach(robot in robots) {
      if(isDefined(robot) && isalive(robot)) {
        robot ai::set_behavior_attribute("phalanx_force_stance", stance);
      }
    }
  }

}
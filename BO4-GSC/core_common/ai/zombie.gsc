/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie.gsc
***********************************************/

#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_locomotion_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\archetype_zombie_interface;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;

#namespace zombiebehavior;

autoexec init() {
  initzombiebehaviorsandasm();
  spawner::add_archetype_spawn_function(#"zombie", &archetypezombieblackboardinit);
  spawner::add_archetype_spawn_function(#"zombie", &archetypezombiedeathoverrideinit);
  spawner::add_archetype_spawn_function(#"zombie", &archetypezombiespecialeffectsinit);
  spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::zombiespawnsetup);

  spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::updateanimationrate);

  clientfield::register("actor", "zombie", 1, 1, "int");
  clientfield::register("actor", "zombie_special_day", 1, 1, "counter");
  zombieinterface::registerzombieinterfaceattributes();
}

private initzombiebehaviorsandasm() {
  assert(!isDefined(&zombiemoveactionstart) || isscriptfunctionptr(&zombiemoveactionstart));
  assert(!isDefined(&zombiemoveactionupdate) || isscriptfunctionptr(&zombiemoveactionupdate));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaction", &zombiemoveactionstart, &zombiemoveactionupdate, undefined);
  assert(!isDefined(&function_9b6830c9) || isscriptfunctionptr(&function_9b6830c9));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_fbdc2cc4) || isscriptfunctionptr(&function_fbdc2cc4));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemeleeaction", &function_9b6830c9, undefined, &function_fbdc2cc4);
  assert(isscriptfunctionptr(&zombietargetservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietargetservice", &zombietargetservice);
  assert(isscriptfunctionptr(&zombiecrawlercollision));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiecrawlercollisionservice", &zombiecrawlercollision);
  assert(isscriptfunctionptr(&zombietraversalservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietraversalservice", &zombietraversalservice);
  assert(isscriptfunctionptr(&zombieisatattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatattackobject", &zombieisatattackobject);
  assert(isscriptfunctionptr(&zombieshouldattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackobject", &zombieshouldattackobject);
  assert(isscriptfunctionptr(&zombieshouldmeleecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmelee", &zombieshouldmeleecondition);
  assert(isscriptfunctionptr(&zombieshouldjumpmeleecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpmelee", &zombieshouldjumpmeleecondition);
  assert(isscriptfunctionptr(&zombieshouldjumpunderwatermelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpunderwatermelee", &zombieshouldjumpunderwatermelee);
  assert(isscriptfunctionptr(&zombiegiblegscondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegiblegscondition", &zombiegiblegscondition);
  assert(isscriptfunctionptr(&zombieshoulddisplaypain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshoulddisplaypain", &zombieshoulddisplaypain);
  assert(isscriptfunctionptr(&iszombiewalking));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"iszombiewalking", &iszombiewalking);
  assert(isscriptfunctionptr(&zombieshouldmovelowg));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmovelowg", &zombieshouldmovelowg);
  assert(isscriptfunctionptr(&zombieshouldturn));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombieshouldturn", &zombieshouldturn);
  assert(isscriptfunctionptr(&function_a716a3af));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4ba5bc2aba9e7670", &function_a716a3af);
  assert(isscriptfunctionptr(&function_1b8c9407));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4136381d29600bc", &function_1b8c9407);
  assert(isscriptfunctionptr(&function_ecba5a44));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1732367c7f780c76", &function_ecba5a44);
  assert(isscriptfunctionptr(&zombieshouldmeleesuicide));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmeleesuicide", &zombieshouldmeleesuicide);
  assert(isscriptfunctionptr(&zombiemeleesuicidestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicidestart", &zombiemeleesuicidestart);
  assert(isscriptfunctionptr(&zombiemeleesuicideupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideupdate", &zombiemeleesuicideupdate);
  assert(isscriptfunctionptr(&zombiemeleesuicideterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideterminate", &zombiemeleesuicideterminate);
  assert(isscriptfunctionptr(&zombieshouldjukecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjuke", &zombieshouldjukecondition);
  assert(isscriptfunctionptr(&zombiejukeactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionstart", &zombiejukeactionstart);
  assert(isscriptfunctionptr(&zombiejukeactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionterminate", &zombiejukeactionterminate);
  assert(isscriptfunctionptr(&zombiedeathaction));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedeathaction", &zombiedeathaction);
  assert(isscriptfunctionptr(&zombiejuke));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeservice", &zombiejuke);
  assert(isscriptfunctionptr(&zombiestumble));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleservice", &zombiestumble);
  assert(isscriptfunctionptr(&zombieshouldstumblecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumblecondition", &zombieshouldstumblecondition);
  assert(isscriptfunctionptr(&zombiestumbleactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleactionstart", &zombiestumbleactionstart);
  assert(isscriptfunctionptr(&zombieattackobjectstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectstart", &zombieattackobjectstart);
  assert(isscriptfunctionptr(&zombieattackobjectterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectterminate", &zombieattackobjectterminate);
  assert(isscriptfunctionptr(&waskilledbyinterdimensionalguncondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbyinterdimensionalgun", &waskilledbyinterdimensionalguncondition);
  assert(isscriptfunctionptr(&wascrushedbyinterdimensionalgunblackholecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wascrushedbyinterdimensionalgunblackhole", &wascrushedbyinterdimensionalgunblackholecondition);
  assert(isscriptfunctionptr(&zombieidgundeathupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieidgundeathupdate", &zombieidgundeathupdate);
  assert(isscriptfunctionptr(&zombieidgundeathupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombievortexpullupdate", &zombieidgundeathupdate);
  assert(isscriptfunctionptr(&zombiehaslegs));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehaslegs", &zombiehaslegs);
  assert(isscriptfunctionptr(&zombieshouldproceduraltraverse));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldproceduraltraverse", &zombieshouldproceduraltraverse);
  assert(isscriptfunctionptr(&zombiemissinglegs));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemissinglegs", &zombiemissinglegs);
  assert(isscriptfunctionptr(&function_f937377));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31cc70f275702cf6", &function_f937377);
  assert(isscriptfunctionptr(&function_a82068d7));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionstart", &function_a82068d7);
  assert(isscriptfunctionptr(&function_626edd6b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionupdate", &function_626edd6b);
  animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
  animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
  animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_cbbae5cb, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_zombie_melee@zombie", &function_54d75299, &function_d1474842, &function_b6d297bb);
}

archetypezombieblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
}

private archetypezombieonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypezombieblackboardinit();
}

archetypezombiespecialeffectsinit() {
  aiutility::addaioverridedamagecallback(self, &archetypezombiespecialeffectscallback);
}

private archetypezombiespecialeffectscallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  specialdayeffectchance = getdvarint(#"tu6_ffotd_zombiespecialdayeffectschance", 0);

  if(specialdayeffectchance && randomint(100) < specialdayeffectchance) {
    if(isDefined(eattacker) && isplayer(eattacker)) {
      self clientfield::increment("zombie_special_day");
    }
  }

  return idamage;
}

bb_getvarianttype() {
  if(isDefined(self.variant_type)) {
    return self.variant_type;
  }

  return 0;
}

bb_getlowgravityvariant() {
  if(isDefined(self.low_gravity_variant)) {
    return self.low_gravity_variant;
  }

  return 0;
}

iszombiewalking(entity) {
  return !(isDefined(entity.missinglegs) && entity.missinglegs);
}

zombieshoulddisplaypain(entity) {
  if(isDefined(entity.suicidaldeath) && entity.suicidaldeath) {
    return false;
  }

  if(!hasasm(entity) || entity function_ebbebf56() < 1) {
    return false;
  }

  return !(isDefined(entity.missinglegs) && entity.missinglegs);
}

zombieshouldjukecondition(entity) {
  if(isDefined(entity.juke) && (entity.juke == "left" || entity.juke == "right")) {
    return true;
  }

  return false;
}

zombieshouldstumblecondition(entity) {
  if(isDefined(entity.stumble)) {
    return true;
  }

  return false;
}

private zombiejukeactionstart(entity) {
  entity setblackboardattribute("_juke_direction", entity.juke);

  if(isDefined(entity.jukedistance)) {
    entity setblackboardattribute("_juke_distance", entity.jukedistance);
  } else {
    entity setblackboardattribute("_juke_distance", "short");
  }

  entity.jukedistance = undefined;
  entity.juke = undefined;
}

private zombiejukeactionterminate(entity) {
  entity clearpath();
}

private zombiestumbleactionstart(entity) {
  entity.stumble = undefined;
}

private zombieattackobjectstart(entity) {
  entity.is_inert = 1;
}

private zombieattackobjectterminate(entity) {
  entity.is_inert = 0;
}

zombiegiblegscondition(entity) {
  return gibserverutils::isgibbed(entity, 256) || gibserverutils::isgibbed(entity, 128);
}

function_f937377(entity) {
  entity.ai.var_80045105 = gettime();
}

zombienotetrackmeleefire(entity) {
  if(isDefined(entity.marked_for_death) && entity.marked_for_death) {
    return;
  }

  entity.melee_cooldown = gettime() + getdvarfloat(#"scr_zombiemeleecooldown", 1) * 1000;

  if(isDefined(entity.aat_turned) && entity.aat_turned) {
    if(isDefined(entity.enemy) && isalive(entity.enemy) && !isplayer(entity.enemy)) {
      if(isDefined(entity.var_16d0eb06) && isDefined(entity.enemy.var_6d23c054) && entity.enemy.var_6d23c054) {
        if(isDefined(entity.var_443d78cc)) {
          e_attacker = entity.var_443d78cc;
        } else {
          e_attacker = entity;
        }

        entity.enemy dodamage(entity.var_16d0eb06, entity.origin, e_attacker, entity);

        if(!isalive(entity.enemy)) {
          gibserverutils::gibhead(entity.enemy);
          entity.enemy zombie_utility::gib_random_parts();
          entity.enemy.var_7105092c = 1;
          entity.n_aat_turned_zombie_kills++;
        }
      } else if(isDefined(entity.enemy.var_6d23c054) && entity.enemy.var_6d23c054 && isDefined(entity.enemy.allowdeath) && entity.enemy.allowdeath) {
        if(isDefined(entity.var_443d78cc)) {
          e_attacker = entity.var_443d78cc;
        } else {
          e_attacker = entity;
        }

        gibserverutils::gibhead(entity.enemy);
        entity.enemy zombie_utility::gib_random_parts();
        entity.enemy.var_7105092c = 1;
        entity.enemy kill(entity.enemy.origin, e_attacker, entity, undefined, undefined, 1);
        entity.n_aat_turned_zombie_kills++;
      } else if(isDefined(entity.enemy.canbetargetedbyturnedzombies) && entity.enemy.canbetargetedbyturnedzombies) {
        entity melee();
      }

      entity callback::callback(#"on_ai_melee");
    }

    return;
  }

  if(isDefined(entity.enemy) && isDefined(entity.enemy.ignoreme) && entity.enemy.ignoreme) {
    return;
  }

  if(isDefined(entity.ai.var_80045105)) {
    record3dtext("<dev string:x38>" + gettime() - entity.ai.var_80045105, self.origin, (1, 0, 0), "<dev string:x45>", entity);

  }

  if(isDefined(level.custom_melee_fire)) {
    entity[[level.custom_melee_fire]]();
  } else {
    entity melee();
  }

  record3dtext("<dev string:x4e>", entity.origin, (1, 0, 0), "<dev string:x45>", entity);

  if(isDefined(entity.enemy)) {
    eyepos = entity getEye();
    record3dtext("<dev string:x56>" + distance2d(eyepos, entity.enemy.origin), entity.origin, (1, 0, 0), "<dev string:x45>", entity);
  }

  if(zombieshouldattackobject(entity)) {
    if(isDefined(level.attackablecallback)) {
      entity.attackable[[level.attackablecallback]](entity);
    }
  }

  entity callback::callback(#"on_ai_melee");
}

zombienotetrackcrushfire(entity) {
  entity delete();
}

zombietargetservice(entity) {
  if(isDefined(entity.enablepushtime)) {
    if(gettime() >= entity.enablepushtime) {
      entity collidewithactors(1);
      entity.enablepushtime = undefined;
    }
  }

  if(isDefined(entity.disabletargetservice) && entity.disabletargetservice) {
    return 0;
  }

  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    return 0;
  }

  specifictarget = undefined;

  if(isDefined(level.zombielevelspecifictargetcallback)) {
    specifictarget = [[level.zombielevelspecifictargetcallback]]();
  }

  if(isDefined(specifictarget)) {
    entity setgoal(specifictarget.origin);
    return;
  }

  player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);

  if(!isDefined(player)) {
    if(isDefined(self.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [
          [level._should_skip_ignore_player_logic]
        ]()) {
        return 0;
      }

      self.ignore_player = [];
    }

    self setgoal(self.origin);
    return 0;
  }

  if(isDefined(player.last_valid_position)) {
    if(!(isDefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
      if(isDefined(level.zombie_use_zigzag_path) && level.zombie_use_zigzag_path) {
        entity zombieupdatezigzaggoal();
      } else {
        entity setgoal(player.last_valid_position);
      }
    }

    return 1;
  }

  if(!(isDefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
    entity setgoal(entity.origin);
  }

  return 0;
}

zombieupdatezigzaggoal() {
  aiprofile_beginentry("zombieUpdateZigZagGoal");
  shouldrepath = 0;

  if(!shouldrepath && isDefined(self.favoriteenemy)) {
    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else if(distancesquared(self.origin, self.favoriteenemy.origin) <= 250 * 250) {
      shouldrepath = 1;
    } else if(isDefined(self.pathgoalpos)) {
      distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
      shouldrepath = distancetogoalsqr < 72 * 72;
    }
  }

  if(isDefined(self.keep_moving) && self.keep_moving) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }

  if(shouldrepath) {
    goalpos = self.favoriteenemy.origin;

    if(isDefined(self.favoriteenemy.last_valid_position)) {
      goalpos = self.favoriteenemy.last_valid_position;
    }

    self setgoal(goalpos);

    if(distancesquared(self.origin, goalpos) > 250 * 250) {
      self.keep_moving = 1;
      self.keep_moving_time = gettime() + 250;
      path = self calcapproximatepathtoposition(goalpos, 0);

      if(getdvarint(#"ai_debugzigzag", 0)) {
        for(index = 1; index < path.size; index++) {
          recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x64>", self);
        }
      }

      if(isDefined(level._zombiezigzagdistancemin) && isDefined(level._zombiezigzagdistancemax)) {
        min = level._zombiezigzagdistancemin;
        max = level._zombiezigzagdistancemax;
      } else {
        min = 240;
        max = 600;
      }

      deviationdistance = randomintrange(min, max);
      segmentlength = 0;

      for(index = 1; index < path.size; index++) {
        currentseglength = distance(path[index - 1], path[index]);

        if(segmentlength + currentseglength > deviationdistance) {
          remaininglength = deviationdistance - segmentlength;
          seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;

          recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x64>", self);

          innerzigzagradius = 0;
          outerzigzagradius = 96;
          queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 0.5 * 72, 16, self, 16);
          positionquery_filter_inclaimedlocation(queryresult, self);

          if(queryresult.data.size > 0) {
            point = queryresult.data[randomint(queryresult.data.size)];
            self setgoal(point.origin);
          }

          break;
        }

        segmentlength += currentseglength;
      }
    }

    if(isDefined(level._zombiezigzagtimemin) && isDefined(level._zombiezigzagtimemax)) {
      mintime = level._zombiezigzagtimemin;
      maxtime = level._zombiezigzagtimemax;
    } else {
      mintime = 2500;
      maxtime = 3500;
    }

    self.nextgoalupdate = gettime() + randomintrange(mintime, maxtime);
  }

  aiprofile_endentry();
}

zombiecrawlercollision(entity) {
  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && !(isDefined(entity.knockdown) && entity.knockdown)) {
    return false;
  }

  if(isDefined(entity.dontpushtime)) {
    if(gettime() < entity.dontpushtime) {
      return true;
    }
  }

  if(!isDefined(level.zombie_team)) {
    return false;
  }

  zombies = getaiteamarray(level.zombie_team);

  foreach(zombie in zombies) {
    if(zombie == entity) {
      continue;
    }

    if(isDefined(zombie.missinglegs) && zombie.missinglegs || isDefined(zombie.knockdown) && zombie.knockdown) {
      continue;
    }

    dist_sq = distancesquared(entity.origin, zombie.origin);

    if(dist_sq < 14400) {
      entity collidewithactors(0);
      entity.dontpushtime = gettime() + 2000;
      return true;
    }
  }

  entity collidewithactors(1);
  return false;
}

zombietraversalservice(entity) {
  if(isDefined(entity.traversestartnode)) {
    entity collidewithactors(0);
    return true;
  }

  return false;
}

zombieisatattackobject(entity) {
  if(isDefined(entity.missinglegs) && entity.missinglegs) {
    return false;
  }

  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }

  if(isDefined(entity.favoriteenemy) && isDefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target) {
    return false;
  }

  if(isDefined(entity.aat_turned) && entity.aat_turned) {
    return false;
  }

  if(isDefined(entity.attackable) && isDefined(entity.attackable.is_active) && entity.attackable.is_active) {
    if(!isDefined(entity.attackable_slot)) {
      return false;
    }

    dist = distance2dsquared(entity.origin, entity.attackable_slot.origin);

    if(dist < 256) {
      height_offset = abs(entity.origin[2] - entity.attackable_slot.origin[2]);

      if(height_offset < 32) {
        entity.is_at_attackable = 1;
        return true;
      }
    }
  }

  return false;
}

zombieshouldattackobject(entity) {
  if(isDefined(entity.missinglegs) && entity.missinglegs) {
    return false;
  }

  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }

  if(isDefined(entity.favoriteenemy) && isDefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target) {
    return false;
  }

  if(isDefined(entity.aat_turned) && entity.aat_turned) {
    return false;
  }

  if(isDefined(entity.attackable) && isDefined(entity.attackable.is_active) && entity.attackable.is_active) {
    if(isDefined(entity.is_at_attackable) && entity.is_at_attackable) {
      return true;
    }
  }

  return false;
}

function_997f1224(entity) {
  if(entity.archetype == #"zombie" && !isDefined(entity.subarchetype) && !(isDefined(self.missinglegs) && self.missinglegs)) {
    if(entity.zombie_move_speed == "walk") {
      return (100 * 100);
    } else if(entity.zombie_move_speed == "run") {
      return (120 * 120);
    }

    return (90 * 90);
  }

  if(isDefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
    meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
  }

  if(!isDefined(meleedistsq)) {
    return (100 * 100);
  }

  return meleedistsq;
}

zombieshouldmeleecondition(entity) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death) && entity.marked_for_death) {
    return false;
  }

  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > (isDefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
    return false;
  }

  meleedistsq = function_997f1224(entity);

  if(distancesquared(entity.origin, entity.enemy.origin) > meleedistsq) {
    return false;
  }

  var_7b871a7d = 1;
  dist2d = distance2dsquared(entity.origin, entity.enemy.origin);

  if(dist2d < 576) {
    height = entity.origin[2] - entity.enemy.origin[2];

    if(height < 64) {
      var_7b871a7d = 0;
    }
  }

  if(var_7b871a7d) {
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

    if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
      return false;
    }

    if(!entity cansee(entity.enemy)) {
      return false;
    }
  }

  if(distancesquared(entity.origin, entity.enemy.origin) < 40 * 40) {
    return true;
  }

  if(var_7b871a7d) {
    if(!tracepassedonnavmesh(entity.origin, isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
      return false;
    }
  }

  return true;
}

private function_1b8c9407(entity) {
  if(getdvarint(#"hash_1a5939d8c37a2e07", 0)) {
    return false;
  }

  var_9fce1294 = blackboard::getblackboardevents("zombie_full_pain");

  if(isDefined(var_9fce1294) && var_9fce1294.size) {
    return false;
  }

  if(isDefined(level.var_eeb66e64) && ![[level.var_eeb66e64]](entity)) {
    return false;
  }

  return true;
}

private function_ecba5a44(entity) {
  var_1e466fbb = spawnStruct();
  var_1e466fbb.enemy = entity.enemy;
  blackboard::addblackboardevent("zombie_full_pain", var_1e466fbb, randomintrange(6000, 9000));
}

private zombieshouldmovelowg(entity) {
  return isDefined(entity.low_gravity) && entity.low_gravity;
}

private zombieshouldturn(entity) {
  return !isDefined(entity.turn_cooldown) || entity.turn_cooldown < gettime();
}

private function_a716a3af(entity) {
  entity.turn_cooldown = gettime() + 1000;
  return true;
}

zombieshouldjumpmeleecondition(entity) {
  if(!(isDefined(entity.low_gravity) && entity.low_gravity)) {
    return false;
  }

  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }

  if(entity.enemy isonground()) {
    if(isplayer(entity.enemy) && entity.enemy isplayerswimming()) {
      waterheight = getwaterheight(entity.enemy.origin);

      if(waterheight - entity.enemy.origin[2] < 24) {
        return false;
      }
    } else {
      return false;
    }
  }

  jumpchance = getdvarfloat(#"zmmeleejumpchance", 0.5);

  if(entity getentitynumber() % 10 / 10 > jumpchance) {
    return false;
  }

  predictedposition = entity.enemy.origin + entity.enemy getvelocity() * float(function_60d95f53()) / 1000 * 2;
  jumpdistancesq = pow(getdvarint(#"zmmeleejumpdistance", 180), 2);

  if(distance2dsquared(entity.origin, predictedposition) > jumpdistancesq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 60) {
    return false;
  }

  heighttoenemy = entity.enemy.origin[2] - entity.origin[2];

  if(heighttoenemy <= getdvarint(#"zmmeleejumpheightdifference", 60)) {
    return false;
  }

  return true;
}

zombieshouldjumpunderwatermelee(entity) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }

  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }

  if(entity.enemy isonground()) {
    return false;
  }

  if(entity depthinwater() < 48) {
    return false;
  }

  jumpdistancesq = pow(getdvarint(#"zmmeleewaterjumpdistance", 64), 2);

  if(distance2dsquared(entity.origin, entity.enemy.origin) > jumpdistancesq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 60) {
    return false;
  }

  heighttoenemy = entity.enemy.origin[2] - entity.origin[2];

  if(heighttoenemy <= getdvarint(#"zmmeleejumpunderwaterheightdifference", 48)) {
    return false;
  }

  return true;
}

zombiestumble(entity) {
  if(isDefined(entity.missinglegs) && entity.missinglegs) {
    return false;
  }

  if(!(isDefined(entity.canstumble) && entity.canstumble)) {
    return false;
  }

  if(!isDefined(entity.zombie_move_speed) || entity.zombie_move_speed != "sprint") {
    return false;
  }

  if(isDefined(entity.stumble)) {
    return false;
  }

  if(!isDefined(entity.next_stumble_time)) {
    entity.next_stumble_time = gettime() + randomintrange(9000, 12000);
  }

  if(gettime() > entity.next_stumble_time) {
    if(randomint(100) < 5) {
      closestplayer = arraygetclosest(entity.origin, level.players);

      if(distancesquared(closestplayer.origin, entity.origin) > 50000) {
        if(isDefined(entity.next_juke_time)) {
          entity.next_juke_time = undefined;
        }

        entity.next_stumble_time = undefined;
        entity.stumble = 1;
        return true;
      }
    }
  }

  return false;
}

zombiejuke(entity) {
  if(!entity ai::has_behavior_attribute("can_juke")) {
    return 0;
  }

  if(!entity ai::get_behavior_attribute("can_juke")) {
    return 0;
  }

  if(isDefined(entity.missinglegs) && entity.missinglegs) {
    return 0;
  }

  if(entity aiutility::function_cc26899f() != "locomotion_speed_walk") {
    if(entity ai::has_behavior_attribute("spark_behavior") && !entity ai::get_behavior_attribute("spark_behavior")) {
      return 0;
    }
  }

  if(isDefined(entity.juke)) {
    return 0;
  }

  if(!isDefined(entity.next_juke_time)) {
    entity.next_juke_time = gettime() + randomintrange(7500, 9500);
  }

  if(gettime() > entity.next_juke_time) {
    entity.next_juke_time = undefined;

    if(randomint(100) < 25 || entity ai::has_behavior_attribute("spark_behavior") && entity ai::get_behavior_attribute("spark_behavior")) {
      if(isDefined(entity.next_stumble_time)) {
        entity.next_stumble_time = undefined;
      }

      forwardoffset = 15;
      entity.ignorebackwardposition = 1;

      if(math::cointoss()) {
        jukedistance = 101;
        entity.jukedistance = "long";

        switch (entity aiutility::function_cc26899f()) {
          case #"locomotion_speed_run":
          case #"locomotion_speed_walk":
            forwardoffset = 122;
            break;
          case #"locomotion_speed_sprint":
            forwardoffset = 129;
            break;
        }

        entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);
      }

      if(!isDefined(entity.juke) || entity.juke == "forward") {
        jukedistance = 69;
        entity.jukedistance = "short";

        switch (entity aiutility::function_cc26899f()) {
          case #"locomotion_speed_run":
          case #"locomotion_speed_walk":
            forwardoffset = 127;
            break;
          case #"locomotion_speed_sprint":
            forwardoffset = 148;
            break;
        }

        entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);

        if(entity.juke == "forward") {
          entity.juke = undefined;
          entity.jukedistance = undefined;
          return 0;
        }
      }
    }
  }
}

zombiedeathaction(entity) {}

waskilledbyinterdimensionalguncondition(entity) {
  if(isDefined(entity.interdimensional_gun_kill) && !isDefined(entity.killby_interdimensional_gun_hole) && isalive(entity)) {
    return true;
  }

  return false;
}

wascrushedbyinterdimensionalgunblackholecondition(entity) {
  if(isDefined(entity.killby_interdimensional_gun_hole)) {
    return true;
  }

  return false;
}

zombieidgundeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("noclip");
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity pathmode("dont move");
  entity.hole_pull_speed = 0;
}

zombiemeleejumpmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face enemy");
  entity animmode("noclip", 0);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity.clamptonavmesh = 0;
  entity collidewithactors(0);
  entity.jumpstartposition = entity.origin;
}

zombiemeleejumpmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  normalizedtime = (entity getanimtime(mocompanim) * getanimlength(mocompanim) + mocompanimblendouttime) / mocompduration;

  if(normalizedtime > 0.5) {
    entity orientmode("face angle", entity.angles[1]);
  }

  speed = 5;

  if(isDefined(entity.zombie_move_speed)) {
    switch (entity.zombie_move_speed) {
      case #"walk":
        speed = 5;
        break;
      case #"run":
        speed = 6;
        break;
      case #"sprint":
        speed = 7;
        break;
    }
  }

  newposition = entity.origin + anglesToForward(entity.angles) * speed;
  newtestposition = (newposition[0], newposition[1], entity.jumpstartposition[2]);
  newvalidposition = getclosestpointonnavmesh(newtestposition, 12, 20);

  if(isDefined(newvalidposition)) {
    newvalidposition = (newvalidposition[0], newvalidposition[1], entity.origin[2]);
  } else {
    newvalidposition = entity.origin;
  }

  if(!(isDefined(entity.var_7c16e514) && entity.var_7c16e514)) {
    waterheight = getwaterheight(entity.origin);

    if(newvalidposition[2] + entity function_6a9ae71() > waterheight) {
      newvalidposition = (newvalidposition[0], newvalidposition[1], waterheight - entity function_6a9ae71());
    }
  }

  groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);

  if(isDefined(groundpoint) && groundpoint[2] > newvalidposition[2]) {
    newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
  }

  entity forceteleport(newvalidposition);
}

zombiemeleejumpmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.pushable = 1;
  entity.blockingpain = 0;
  entity.clamptonavmesh = 1;
  entity collidewithactors(1);
  groundpoint = getclosestpointonnavmesh(entity.origin, 12);

  if(isDefined(groundpoint)) {
    entity forceteleport(groundpoint);
  }
}

zombieidgundeathupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!isDefined(entity.killby_interdimensional_gun_hole)) {
    entity_eye = entity getEye();

    if(entity.b_vortex_repositioned !== 1) {
      entity.b_vortex_repositioned = 1;
      v_nearest_navmesh_point = getclosestpointonnavmesh(entity.damageorigin, 36, 15);

      if(isDefined(v_nearest_navmesh_point)) {
        f_distance = distance(entity.damageorigin, v_nearest_navmesh_point);

        if(f_distance < 41) {
          entity.damageorigin += (0, 0, 36);
        }
      }
    }

    entity_center = entity.origin + (entity_eye - entity.origin) / 2;
    flyingdir = entity.damageorigin - entity_center;
    lengthfromhole = length(flyingdir);

    if(lengthfromhole < entity.hole_pull_speed) {
      entity.killby_interdimensional_gun_hole = 1;
      entity.allowdeath = 1;
      entity.takedamage = 1;
      entity.aioverridedamage = undefined;
      entity.magic_bullet_shield = 0;
      level notify(#"interdimensional_kill", {
        #entity: entity
      });

      if(isDefined(entity.interdimensional_gun_weapon) && isDefined(entity.interdimensional_gun_attacker)) {
        entity kill(entity.origin, entity.interdimensional_gun_attacker, entity.interdimensional_gun_attacker, entity.interdimensional_gun_weapon);
      } else {
        entity kill(entity.origin);
      }

      return;
    }

    if(entity.hole_pull_speed < 12) {
      entity.hole_pull_speed += 0.5;

      if(entity.hole_pull_speed > 12) {
        entity.hole_pull_speed = 12;
      }
    }

    flyingdir = vectornormalize(flyingdir);
    entity forceteleport(entity.origin + flyingdir * entity.hole_pull_speed);
  }
}

zombieidgunholedeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("noclip");
  entity.pushable = 0;
}

zombieidgunholedeathmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!(isDefined(entity.interdimensional_gun_kill_vortex_explosion) && entity.interdimensional_gun_kill_vortex_explosion)) {
    entity hide();
  }
}

private zombieturnmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("angle deltas", 0);
}

private zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  normalizedtime = (entity getanimtime(mocompanim) + mocompanimblendouttime) / mocompduration;

  if(normalizedtime > 0.25) {
    entity orientmode("face motion");
    entity animmode("normal", 0);
  }
}

private zombieturnmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face motion");
  entity animmode("normal", 0);
}

zombiehaslegs(entity) {
  if(entity.missinglegs === 1) {
    return false;
  }

  return true;
}

zombiemissinglegs(entity) {
  return !zombiehaslegs(entity);
}

zombieshouldproceduraltraverse(entity) {
  return isDefined(entity.traversestartnode) && isDefined(entity.traverseendnode) && entity.traversestartnode.spawnflags&1024 && entity.traverseendnode.spawnflags&1024;
}

zombieshouldmeleesuicide(entity) {
  if(!entity ai::get_behavior_attribute("suicidal_behavior")) {
    return false;
  }

  if(isDefined(entity.magic_bullet_shield) && entity.magic_bullet_shield) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > 40000) {
    return false;
  }

  return true;
}

zombiemeleesuicidestart(entity) {
  entity.blockingpain = 1;

  if(isDefined(level.zombiemeleesuicidecallback)) {
    entity thread[[level.zombiemeleesuicidecallback]](entity);
  }
}

zombiemeleesuicideupdate(entity) {}

zombiemeleesuicideterminate(entity) {
  if(isalive(entity) && zombieshouldmeleesuicide(entity)) {
    entity.takedamage = 1;
    entity.allowdeath = 1;

    if(isDefined(level.zombiemeleesuicidedonecallback)) {
      entity thread[[level.zombiemeleesuicidedonecallback]](entity);
    }
  }
}

zombiemoveactionstart(entity, asmstatename) {
  function_ec25b529(entity);
  animationstatenetworkutility::requeststate(entity, asmstatename);

  if(isDefined(entity.stumble) && !isDefined(entity.move_anim_end_time)) {
    stumbleactionresult = entity astsearch(asmstatename);
    stumbleactionanimation = animationstatenetworkutility::searchanimationmap(entity, stumbleactionresult[#"animation"]);
    entity.move_anim_end_time = entity.movetime + getanimlength(stumbleactionanimation);
  }

  return 5;
}

function_a82068d7(entity) {
  function_ec25b529(entity);
  return true;
}

function_ec25b529(entity) {
  entity.movetime = gettime();
  entity.moveorigin = entity.origin;
}

zombiemoveactionupdate(entity, asmstatename) {
  if(isDefined(entity.move_anim_end_time) && gettime() >= entity.move_anim_end_time) {
    entity.move_anim_end_time = undefined;
    return 4;
  }

  function_26f9b8b1(entity);

  if(entity asmgetstatus() == "asm_status_complete") {
    if(entity iscurrentbtactionlooping()) {
      return zombiemoveactionstart(entity, asmstatename);
    } else {
      return 4;
    }
  }

  return 5;
}

function_626edd6b(entity) {
  function_26f9b8b1(entity);
  return true;
}

function_26f9b8b1(entity) {
  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.movetime > 1000) {
    distsq = distance2dsquared(entity.origin, entity.moveorigin);

    if(distsq < 144) {
      entity setavoidancemask("avoid all");
      entity.cant_move = 1;

      record3dtext("<dev string:x71>", entity.origin, (0, 0, 1), "<dev string:x45>", entity);

      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    } else {
      entity setavoidancemask("avoid none");
      entity.cant_move = 0;

      if(isDefined(entity.var_63d2fce2)) {
        entity thread[[entity.var_63d2fce2]]();
      }
    }

    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
  }
}

zombiemoveactionterminate(entity, asmstatename) {
  if(!(isDefined(entity.missinglegs) && entity.missinglegs)) {
    entity setavoidancemask("avoid none");
  }

  return 4;
}

function_79fe956f() {
  self notify("2360c9f36a377896");
  self endon("2360c9f36a377896");
  self endon(#"death");

  if(!isDefined(self.var_9ed3cc11)) {
    self.var_9ed3cc11 = self function_e827fc0e();
  }

  self pushplayer(1);
  wait 2;

  if(isDefined(self.var_9ed3cc11)) {
    self pushplayer(self.var_9ed3cc11);
    self.var_9ed3cc11 = undefined;
  }
}

function_22762653() {
  self notify("333a3e1bcad60a56");
  self endon("333a3e1bcad60a56");
  self endon(#"death");
  var_159fa617 = 0;

  foreach(player in getplayers()) {
    if(player laststand::player_is_in_laststand()) {
      if(distancesquared(self.origin, player.origin) < 14400) {
        var_159fa617 = 1;
        break;
      }
    }
  }

  if(!var_159fa617) {
    return;
  }

  if(!isDefined(self.var_9ed3cc11)) {
    self.var_9ed3cc11 = self function_e827fc0e();
  }

  self pushplayer(1);
  wait 2;

  if(isDefined(self.var_9ed3cc11)) {
    self pushplayer(self.var_9ed3cc11);
    self.var_9ed3cc11 = undefined;
  }
}

function_9b6830c9(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity pathmode("dont move", 1);
  return 5;
}

function_fbdc2cc4(entity, asmstatename) {
  entity pathmode("move allowed");
  return 4;
}

archetypezombiedeathoverrideinit() {
  aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

private zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
  if(!(isDefined(level.zombieanhilationenabled) && level.zombieanhilationenabled)) {
    return damage;
  }

  if(isDefined(self.forceanhilateondeath) && self.forceanhilateondeath) {
    self zombie_utility::gib_random_parts();
    gibserverutils::annihilate(self);
    return damage;
  }

  if(isDefined(attacker) && isplayer(attacker) && (isDefined(attacker.forceanhilateondeath) && attacker.forceanhilateondeath || isDefined(level.forceanhilateondeath) && level.forceanhilateondeath)) {
    self zombie_utility::gib_random_parts();
    gibserverutils::annihilate(self);
    return damage;
  }

  attackerdistance = 0;

  if(isDefined(attacker)) {
    attackerdistance = distancesquared(attacker.origin, self.origin);
  }

  isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);

  if(isDefined(weapon.weapclass) && weapon.weapclass == "turret") {
    if(isDefined(inflictor)) {
      isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
      iscloseexplosive = distancesquared(inflictor.origin, self.origin) <= 60 * 60;

      if(isdirectexplosive && iscloseexplosive) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
      }
    }
  }

  return damage;
}

private zombiezombieidlemocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1]) && entity != entity.enemyoverride[1]) {
    entity orientmode("face direction", entity.enemyoverride[1].origin - entity.origin);
    entity animmode("zonly_physics", 0);
    return;
  }

  entity orientmode("face current");
  entity animmode("zonly_physics", 0);
}

private zombieattackobjectmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.attackable_slot)) {
    entity orientmode("face angle", entity.attackable_slot.angles[1]);
    entity animmode("zonly_physics", 0);
    return;
  }

  entity orientmode("face current");
  entity animmode("zonly_physics", 0);
}

private zombieattackobjectmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.attackable_slot)) {
    entity forceteleport(entity.attackable_slot.origin);
  }
}

private function_54d75299(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.enemy)) {
    entity orientmode("face enemy");
  }

  entity animmode("zonly_physics", 1);
  entity pathmode("dont move");
  localdeltahalfvector = getmovedelta(mocompanim, 0, 0.9, entity);
  endpoint = entity localtoworldcoords(localdeltahalfvector);

  recordcircle(endpoint, 3, (1, 0, 0), "<dev string:x98>");
  recordline(entity.origin, endpoint, (1, 0, 0), "<dev string:x98>");
  record3dtext("<dev string:xa1>" + distance(entity.origin, endpoint) + "<dev string:xa9>" + function_9e72a96(mocompanim), endpoint, (1, 0, 0), "<dev string:x45>");
}

private function_d1474842(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity pathmode("dont move");
}

private function_b6d297bb(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity pathmode("move allowed");
}

private function_cbbae5cb(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("normal");

  if(isDefined(entity.traverseendnode)) {
    print3d(entity.traversestartnode.origin, "<dev string:xb2>", (1, 0, 0), 1, 1, 60);
    print3d(entity.traverseendnode.origin, "<dev string:xb2>", (0, 1, 0), 1, 1, 60);
    line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);

    entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
  }
}

zombiegravity(entity, attribute, oldvalue, value) {
  if(value == "low") {
    self.low_gravity = 1;

    if(!isDefined(self.low_gravity_variant) && isDefined(level.var_d9ffddf4)) {
      if(isDefined(self.missinglegs) && self.missinglegs) {
        self.low_gravity_variant = randomint(level.var_d9ffddf4[#"crawl"]);
      } else {
        self.low_gravity_variant = randomint(level.var_d9ffddf4[self.zombie_move_speed]);
      }
    }
  } else if(value == "normal") {
    self.low_gravity = 0;
  }

  entity setblackboardattribute("_low_gravity", value);
}
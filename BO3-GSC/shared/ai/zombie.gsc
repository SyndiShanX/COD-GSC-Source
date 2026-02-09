/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\archetype_zombie_interface;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#namespace zombiebehavior;

function autoexec init() {
  initzombiebehaviorsandasm();
  spawner::add_archetype_spawn_function("zombie", &archetypezombieblackboardinit);
  spawner::add_archetype_spawn_function("zombie", &archetypezombiedeathoverrideinit);
  spawner::add_archetype_spawn_function("zombie", &archetypezombiespecialeffectsinit);
  spawner::add_archetype_spawn_function("zombie", &zombie_utility::zombiespawnsetup);
  clientfield::register("actor", "zombie", 1, 1, "int");
  clientfield::register("actor", "zombie_special_day", 6001, 1, "counter");
  zombieinterface::registerzombieinterfaceattributes();
}

function private initzombiebehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreeaction("zombieMoveAction", &zombiemoveaction, &zombiemoveactionupdate, undefined);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieTargetService", &zombietargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieCrawlerCollisionService", &zombiecrawlercollision);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieTraversalService", &zombietraversalservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsAtAttackObject", &zombieisatattackobject);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldAttackObject", &zombieshouldattackobject);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMelee", &zombieshouldmeleecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJumpMelee", &zombieshouldjumpmeleecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJumpUnderwaterMelee", &zombieshouldjumpunderwatermelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieGibLegsCondition", &zombiegiblegscondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldDisplayPain", &zombieshoulddisplaypain);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isZombieWalking", &iszombiewalking);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMeleeSuicide", &zombieshouldmeleesuicide);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideStart", &zombiemeleesuicidestart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideUpdate", &zombiemeleesuicideupdate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideTerminate", &zombiemeleesuicideterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJuke", &zombieshouldjukecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeActionStart", &zombiejukeactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeActionTerminate", &zombiejukeactionterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDeathAction", &zombiedeathaction);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeService", &zombiejuke);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleService", &zombiestumble);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleCondition", &zombieshouldstumblecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleActionStart", &zombiestumbleactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieAttackObjectStart", &zombieattackobjectstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieAttackObjectTerminate", &zombieattackobjectterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledByInterdimensionalGun", &waskilledbyinterdimensionalguncondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("wasCrushedByInterdimensionalGunBlackhole", &wascrushedbyinterdimensionalgunblackholecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIDGunDeathUpdate", &zombieidgundeathupdate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieVortexPullUpdate", &zombieidgundeathupdate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieHasLegs", &zombiehaslegs);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldProceduralTraverse", &zombieshouldproceduraltraverse);
  animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
  animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
  animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
}

function archetypezombieblackboardinit() {
  blackboard::createblackboardforentity(self);
  self aiutility::registerutilityblackboardattributes();
  ai::createinterfaceforentity(self);
  blackboard::registerblackboardattribute(self, "_arms_position", "arms_up", &bb_getarmsposition);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", &bb_getlocomotionspeedtype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_has_legs", "has_legs_yes", &bb_gethaslegsstatus);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_variant_type", 0, &bb_getvarianttype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_which_board_pull", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_board_attack_spot", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_grapple_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_idgun_damage_direction", "back", &bb_idgungetdamagedirection);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_low_gravity_variant", 0, &bb_getlowgravityvariant);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_knockdown_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_knockdown_type", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_whirlwind_speed", "whirlwind_normal", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_zombie_blackholebomb_pull_state", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
  self finalizetrackedblackboardattributes();
}

function private archetypezombieonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypezombieblackboardinit();
}

function archetypezombiespecialeffectsinit() {
  aiutility::addaioverridedamagecallback(self, &archetypezombiespecialeffectscallback);
}

function private archetypezombiespecialeffectscallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  specialdayeffectchance = getdvarint("tu6_ffotd_zombieSpecialDayEffectsChance", 0);
  if(specialdayeffectchance && randomint(100) < specialdayeffectchance) {
    if(isDefined(eattacker) && isPlayer(eattacker)) {
      self clientfield::increment("zombie_special_day");
    }
  }
  return idamage;
}

function bb_getarmsposition() {
  if(isDefined(self.zombie_arms_position)) {
    if(self.zombie_arms_position == "up") {
      return "arms_up";
    }
    return "arms_down";
  }
  return "arms_up";
}

function bb_getlocomotionspeedtype() {
  if(isDefined(self.zombie_move_speed)) {
    if(self.zombie_move_speed == "walk") {
      return "locomotion_speed_walk";
    }
    if(self.zombie_move_speed == "run") {
      return "locomotion_speed_run";
    }
    if(self.zombie_move_speed == "sprint") {
      return "locomotion_speed_sprint";
    }
    if(self.zombie_move_speed == "super_sprint") {
      return "locomotion_speed_super_sprint";
    }
    if(self.zombie_move_speed == "jump_pad_super_sprint") {
      return "locomotion_speed_jump_pad_super_sprint";
    }
    if(self.zombie_move_speed == "burned") {
      return "locomotion_speed_burned";
    }
    if(self.zombie_move_speed == "slide") {
      return "locomotion_speed_slide";
    }
  }
  return "locomotion_speed_walk";
}

function bb_getvarianttype() {
  if(isDefined(self.variant_type)) {
    return self.variant_type;
  }
  return 0;
}

function bb_gethaslegsstatus() {
  if(self.missinglegs) {
    return "has_legs_no";
  }
  return "has_legs_yes";
}

function bb_getshouldturn() {
  if(isDefined(self.should_turn) && self.should_turn) {
    return "should_turn";
  }
  return "should_not_turn";
}

function bb_idgungetdamagedirection() {
  if(isDefined(self.damage_direction)) {
    return self.damage_direction;
  }
  return self aiutility::bb_getdamagedirection();
}

function bb_getlowgravityvariant() {
  if(isDefined(self.low_gravity_variant)) {
    return self.low_gravity_variant;
  }
  return 0;
}

function iszombiewalking(behaviortreeentity) {
  return !(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs);
}

function zombieshoulddisplaypain(behaviortreeentity) {
  if(isDefined(behaviortreeentity.suicidaldeath) && behaviortreeentity.suicidaldeath) {
    return 0;
  }
  return !(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs);
}

function zombieshouldjukecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.juke) && (behaviortreeentity.juke == "left" || behaviortreeentity.juke == "right")) {
    return true;
  }
  return false;
}

function zombieshouldstumblecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.stumble)) {
    return true;
  }
  return false;
}

function private zombiejukeactionstart(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_juke_direction", behaviortreeentity.juke);
  if(isDefined(behaviortreeentity.jukedistance)) {
    blackboard::setblackboardattribute(behaviortreeentity, "_juke_distance", behaviortreeentity.jukedistance);
  } else {
    blackboard::setblackboardattribute(behaviortreeentity, "_juke_distance", "short");
  }
  behaviortreeentity.jukedistance = undefined;
  behaviortreeentity.juke = undefined;
}

function private zombiejukeactionterminate(behaviortreeentity) {
  behaviortreeentity clearpath();
}

function private zombiestumbleactionstart(behaviortreeentity) {
  behaviortreeentity.stumble = undefined;
}

function private zombieattackobjectstart(behaviortreeentity) {
  behaviortreeentity.is_inert = 1;
}

function private zombieattackobjectterminate(behaviortreeentity) {
  behaviortreeentity.is_inert = 0;
}

function zombiegiblegscondition(behaviortreeentity) {
  return gibserverutils::isgibbed(behaviortreeentity, 256) || gibserverutils::isgibbed(behaviortreeentity, 128);
}

function zombienotetrackmeleefire(entity) {
  if(isDefined(entity.aat_turned) && entity.aat_turned) {
    if(isDefined(entity.enemy) && !isPlayer(entity.enemy)) {
      if(entity.enemy.archetype == "zombie" && (isDefined(entity.enemy.allowdeath) && entity.enemy.allowdeath)) {
        gibserverutils::gibhead(entity.enemy);
        entity.enemy zombie_utility::gib_random_parts();
        entity.enemy kill();
        entity.n_aat_turned_zombie_kills++;
      } else {
        if(entity.enemy.archetype == "zombie_quad" || entity.enemy.archetype == "spider" && (isDefined(entity.enemy.allowdeath) && entity.enemy.allowdeath)) {
          entity.enemy kill();
          entity.n_aat_turned_zombie_kills++;
        } else if(isDefined(entity.enemy.canbetargetedbyturnedzombies) && entity.enemy.canbetargetedbyturnedzombies) {
          entity melee();
        }
      }
    }
  } else {
    if(isDefined(entity.enemy) && (isDefined(entity.enemy.bgb_in_plain_sight_active) && entity.enemy.bgb_in_plain_sight_active || (isDefined(entity.enemy.bgb_idle_eyes_active) && entity.enemy.bgb_idle_eyes_active))) {
      return;
    }
    if(isDefined(entity.enemy) && (isDefined(entity.enemy.allow_zombie_to_target_ai) && entity.enemy.allow_zombie_to_target_ai)) {
      if(entity.enemy.health > 0) {
        entity.enemy dodamage(entity.meleeweapon.meleedamage, entity.origin, entity, entity, "none", "MOD_MELEE");
      }
      return;
    }
    entity melee();
    record3dtext("", self.origin, (1, 0, 0), "", entity);
    if(zombieshouldattackobject(entity)) {
      if(isDefined(level.attackablecallback)) {
        entity.attackable[[level.attackablecallback]](entity);
      }
    }
  }
}

function zombienotetrackcrushfire(behaviortreeentity) {
  behaviortreeentity delete();
}

function zombietargetservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enablepushtime)) {
    if(gettime() >= behaviortreeentity.enablepushtime) {
      behaviortreeentity pushactors(1);
      behaviortreeentity.enablepushtime = undefined;
    }
  }
  if(isDefined(behaviortreeentity.disabletargetservice) && behaviortreeentity.disabletargetservice) {
    return false;
  }
  if(isDefined(behaviortreeentity.ignoreall) && behaviortreeentity.ignoreall) {
    return false;
  }
  specifictarget = undefined;
  if(isDefined(level.zombielevelspecifictargetcallback)) {
    specifictarget = [[level.zombielevelspecifictargetcallback]]();
  }
  if(isDefined(specifictarget)) {
    behaviortreeentity setgoal(specifictarget.origin);
  } else {
    if(isDefined(behaviortreeentity.v_zombie_custom_goal_pos)) {
      goalpos = behaviortreeentity.v_zombie_custom_goal_pos;
      if(isDefined(behaviortreeentity.n_zombie_custom_goal_radius)) {
        behaviortreeentity.goalradius = behaviortreeentity.n_zombie_custom_goal_radius;
      }
      behaviortreeentity setgoal(goalpos);
    } else {
      player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
      if(!isDefined(player)) {
        if(isDefined(self.ignore_player)) {
          if(isDefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]()) {
            return false;
          }
          self.ignore_player = [];
        }
        self setgoal(self.origin);
        return false;
      }
      if(isDefined(player.last_valid_position)) {
        if(!(isDefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
          if(isDefined(level.zombie_use_zigzag_path) && level.zombie_use_zigzag_path) {
            behaviortreeentity zombieupdatezigzaggoal();
          } else {
            behaviortreeentity setgoal(player.last_valid_position);
          }
        }
        return true;
      }
      if(!(isDefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
        behaviortreeentity setgoal(behaviortreeentity.origin);
      }
      return false;
    }
  }
}

function zombieupdatezigzaggoal() {
  aiprofile_beginentry("zombieUpdateZigZagGoal");
  shouldrepath = 0;
  if(!shouldrepath && isDefined(self.favoriteenemy)) {
    if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
      shouldrepath = 1;
    } else {
      if(distancesquared(self.origin, self.favoriteenemy.origin) <= (250 * 250)) {
        shouldrepath = 1;
      } else if(isDefined(self.pathgoalpos)) {
        distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
        shouldrepath = distancetogoalsqr < (72 * 72);
      }
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
    if(distancesquared(self.origin, goalpos) > (250 * 250)) {
      self.keep_moving = 1;
      self.keep_moving_time = gettime() + 250;
      path = self calcapproximatepathtoposition(goalpos, 0);
      if(getdvarint("")) {
        for(index = 1; index < path.size; index++) {
          recordline(path[index - 1], path[index], (1, 0.5, 0), "", self);
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
        if((segmentlength + currentseglength) > deviationdistance) {
          remaininglength = deviationdistance - segmentlength;
          seedposition = (path[index - 1]) + ((vectornormalize(path[index] - (path[index - 1]))) * remaininglength);
          recordcircle(seedposition, 2, (1, 0.5, 0), "", self);
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
        segmentlength = segmentlength + currentseglength;
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

function zombiecrawlercollision(behaviortreeentity) {
  if(!(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) && (!(isDefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown))) {
    return false;
  }
  if(isDefined(behaviortreeentity.dontpushtime)) {
    if(gettime() < behaviortreeentity.dontpushtime) {
      return true;
    }
  }
  zombies = getaiteamarray(level.zombie_team);
  foreach(zombie in zombies) {
    if(zombie == behaviortreeentity) {
      continue;
    }
    if(isDefined(zombie.missinglegs) && zombie.missinglegs || (isDefined(zombie.knockdown) && zombie.knockdown)) {
      continue;
    }
    dist_sq = distancesquared(behaviortreeentity.origin, zombie.origin);
    if(dist_sq < 14400) {
      behaviortreeentity pushactors(0);
      behaviortreeentity.dontpushtime = gettime() + 2000;
      return true;
    }
  }
  behaviortreeentity pushactors(1);
  return false;
}

function zombietraversalservice(entity) {
  if(isDefined(entity.traversestartnode)) {
    entity pushactors(0);
    return true;
  }
  return false;
}

function zombieisatattackobject(entity) {
  if(isDefined(entity.missinglegs) && entity.missinglegs) {
    return false;
  }
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }
  if(isDefined(entity.favoriteenemy) && (isDefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target)) {
    return false;
  }
  if(isDefined(entity.aat_turned) && entity.aat_turned) {
    return false;
  }
  if(isDefined(entity.attackable) && (isDefined(entity.attackable.is_active) && entity.attackable.is_active)) {
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

function zombieshouldattackobject(entity) {
  if(isDefined(entity.missinglegs) && entity.missinglegs) {
    return false;
  }
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }
  if(isDefined(entity.favoriteenemy) && (isDefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target)) {
    return false;
  }
  if(isDefined(entity.aat_turned) && entity.aat_turned) {
    return false;
  }
  if(isDefined(entity.attackable) && (isDefined(entity.attackable.is_active) && entity.attackable.is_active)) {
    if(isDefined(entity.is_at_attackable) && entity.is_at_attackable) {
      return true;
    }
  }
  return false;
}

function zombieshouldmeleecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
    return false;
  }
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  if(isDefined(behaviortreeentity.marked_for_death)) {
    return false;
  }
  if(isDefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
    return false;
  }
  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 4096) {
    return false;
  }
  yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - (vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]));
  if(abs(yawtoenemy) > 60) {
    return false;
  }
  return true;
}

function zombieshouldjumpmeleecondition(behaviortreeentity) {
  if(!(isDefined(behaviortreeentity.low_gravity) && behaviortreeentity.low_gravity)) {
    return false;
  }
  if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
    return false;
  }
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  if(isDefined(behaviortreeentity.marked_for_death)) {
    return false;
  }
  if(isDefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
    return false;
  }
  if(behaviortreeentity.enemy isonground()) {
    return false;
  }
  jumpchance = getdvarfloat("zmMeleeJumpChance", 0.5);
  if(((behaviortreeentity getentitynumber() % 10) / 10) > jumpchance) {
    return false;
  }
  predictedposition = behaviortreeentity.enemy.origin + ((behaviortreeentity.enemy getvelocity() * 0.05) * 2);
  jumpdistancesq = pow(getdvarint("zmMeleeJumpDistance", 180), 2);
  if(distance2dsquared(behaviortreeentity.origin, predictedposition) > jumpdistancesq) {
    return false;
  }
  yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - (vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]));
  if(abs(yawtoenemy) > 60) {
    return false;
  }
  heighttoenemy = behaviortreeentity.enemy.origin[2] - behaviortreeentity.origin[2];
  if(heighttoenemy <= getdvarint("zmMeleeJumpHeightDifference", 60)) {
    return false;
  }
  return true;
}

function zombieshouldjumpunderwatermelee(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
    return false;
  }
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  if(isDefined(behaviortreeentity.marked_for_death)) {
    return false;
  }
  if(isDefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
    return false;
  }
  if(behaviortreeentity.enemy isonground()) {
    return false;
  }
  if(behaviortreeentity depthinwater() < 48) {
    return false;
  }
  jumpdistancesq = pow(getdvarint("zmMeleeWaterJumpDistance", 64), 2);
  if(distance2dsquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > jumpdistancesq) {
    return false;
  }
  yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - (vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]));
  if(abs(yawtoenemy) > 60) {
    return false;
  }
  heighttoenemy = behaviortreeentity.enemy.origin[2] - behaviortreeentity.origin[2];
  if(heighttoenemy <= getdvarint("zmMeleeJumpUnderwaterHeightDifference", 48)) {
    return false;
  }
  return true;
}

function zombiestumble(behaviortreeentity) {
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    return false;
  }
  if(!(isDefined(behaviortreeentity.canstumble) && behaviortreeentity.canstumble)) {
    return false;
  }
  if(!isDefined(behaviortreeentity.zombie_move_speed) || behaviortreeentity.zombie_move_speed != "sprint") {
    return false;
  }
  if(isDefined(behaviortreeentity.stumble)) {
    return false;
  }
  if(!isDefined(behaviortreeentity.next_stumble_time)) {
    behaviortreeentity.next_stumble_time = gettime() + randomintrange(9000, 12000);
  }
  if(gettime() > behaviortreeentity.next_stumble_time) {
    if(randomint(100) < 5) {
      closestplayer = arraygetclosest(behaviortreeentity.origin, level.players);
      if(distancesquared(closestplayer.origin, behaviortreeentity.origin) > 50000) {
        if(isDefined(behaviortreeentity.next_juke_time)) {
          behaviortreeentity.next_juke_time = undefined;
        }
        behaviortreeentity.next_stumble_time = undefined;
        behaviortreeentity.stumble = 1;
        return true;
      }
    }
  }
  return false;
}

function zombiejuke(behaviortreeentity) {
  if(!behaviortreeentity ai::has_behavior_attribute("can_juke")) {
    return false;
  }
  if(!behaviortreeentity ai::get_behavior_attribute("can_juke")) {
    return false;
  }
  if(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
    return false;
  }
  if(behaviortreeentity bb_getlocomotionspeedtype() != "locomotion_speed_walk") {
    if(behaviortreeentity ai::has_behavior_attribute("spark_behavior") && !behaviortreeentity ai::get_behavior_attribute("spark_behavior")) {
      return false;
    }
  }
  if(isDefined(behaviortreeentity.juke)) {
    return false;
  }
  if(!isDefined(behaviortreeentity.next_juke_time)) {
    behaviortreeentity.next_juke_time = gettime() + randomintrange(7500, 9500);
  }
  if(gettime() > behaviortreeentity.next_juke_time) {
    behaviortreeentity.next_juke_time = undefined;
    if(randomint(100) < 25 || (behaviortreeentity ai::has_behavior_attribute("spark_behavior") && behaviortreeentity ai::get_behavior_attribute("spark_behavior"))) {
      if(isDefined(behaviortreeentity.next_stumble_time)) {
        behaviortreeentity.next_stumble_time = undefined;
      }
      forwardoffset = 15;
      behaviortreeentity.ignorebackwardposition = 1;
      if(math::cointoss()) {
        jukedistance = 101;
        behaviortreeentity.jukedistance = "long";
        switch (behaviortreeentity bb_getlocomotionspeedtype()) {
          case "locomotion_speed_run":
          case "locomotion_speed_walk": {
            forwardoffset = 122;
            break;
          }
          case "locomotion_speed_sprint": {
            forwardoffset = 129;
            break;
          }
        }
        behaviortreeentity.juke = aiutility::calculatejukedirection(behaviortreeentity, forwardoffset, jukedistance);
      }
      if(!isDefined(behaviortreeentity.juke) || behaviortreeentity.juke == "forward") {
        jukedistance = 69;
        behaviortreeentity.jukedistance = "short";
        switch (behaviortreeentity bb_getlocomotionspeedtype()) {
          case "locomotion_speed_run":
          case "locomotion_speed_walk": {
            forwardoffset = 127;
            break;
          }
          case "locomotion_speed_sprint": {
            forwardoffset = 148;
            break;
          }
        }
        behaviortreeentity.juke = aiutility::calculatejukedirection(behaviortreeentity, forwardoffset, jukedistance);
        if(behaviortreeentity.juke == "forward") {
          behaviortreeentity.juke = undefined;
          behaviortreeentity.jukedistance = undefined;
          return false;
        }
      }
    }
  }
}

function zombiedeathaction(behaviortreeentity) {}

function waskilledbyinterdimensionalguncondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.interdimensional_gun_kill) && !isDefined(behaviortreeentity.killby_interdimensional_gun_hole) && isalive(behaviortreeentity)) {
    return true;
  }
  return false;
}

function wascrushedbyinterdimensionalgunblackholecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.killby_interdimensional_gun_hole)) {
    return true;
  }
  return false;
}

function zombieidgundeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("noclip");
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity pathmode("dont move");
  entity.hole_pull_speed = 0;
}

function zombiemeleejumpmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face enemy");
  entity animmode("noclip", 0);
  entity.pushable = 0;
  entity.blockingpain = 1;
  entity.clamptonavmesh = 0;
  entity pushactors(0);
  entity.jumpstartposition = entity.origin;
}

function zombiemeleejumpmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  normalizedtime = ((entity getanimtime(mocompanim) * getanimlength(mocompanim)) + mocompanimblendouttime) / mocompduration;
  if(normalizedtime > 0.5) {
    entity orientmode("face angle", entity.angles[1]);
  }
  speed = 5;
  if(isDefined(entity.zombie_move_speed)) {
    switch (entity.zombie_move_speed) {
      case "walk": {
        speed = 5;
        break;
      }
      case "run": {
        speed = 6;
        break;
      }
      case "sprint": {
        speed = 7;
        break;
      }
    }
  }
  newposition = entity.origin + (anglesToForward(entity.angles) * speed);
  newtestposition = (newposition[0], newposition[1], entity.jumpstartposition[2]);
  newvalidposition = getclosestpointonnavmesh(newtestposition, 12, 20);
  if(isDefined(newvalidposition)) {
    newvalidposition = (newvalidposition[0], newvalidposition[1], entity.origin[2]);
  } else {
    newvalidposition = entity.origin;
  }
  groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);
  if(isDefined(groundpoint) && groundpoint[2] > newvalidposition[2]) {
    newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
  }
  entity forceteleport(newvalidposition);
}

function zombiemeleejumpmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.pushable = 1;
  entity.blockingpain = 0;
  entity.clamptonavmesh = 1;
  entity pushactors(1);
  groundpoint = getclosestpointonnavmesh(entity.origin, 12);
  if(isDefined(groundpoint)) {
    entity forceteleport(groundpoint);
  }
}

function zombieidgundeathupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!isDefined(entity.killby_interdimensional_gun_hole)) {
    entity_eye = entity getEye();
    if(entity ispaused()) {
      entity setignorepauseworld(1);
      entity setentitypaused(0);
    }
    if(entity.b_vortex_repositioned !== 1) {
      entity.b_vortex_repositioned = 1;
      v_nearest_navmesh_point = getclosestpointonnavmesh(entity.damageorigin, 36, 15);
      if(isDefined(v_nearest_navmesh_point)) {
        f_distance = distance(entity.damageorigin, v_nearest_navmesh_point);
        if(f_distance < 41) {
          entity.damageorigin = entity.damageorigin + vectorscale((0, 0, 1), 36);
        }
      }
    }
    entity_center = entity.origin + ((entity_eye - entity.origin) / 2);
    flyingdir = entity.damageorigin - entity_center;
    lengthfromhole = length(flyingdir);
    if(lengthfromhole < entity.hole_pull_speed) {
      entity.killby_interdimensional_gun_hole = 1;
      entity.allowdeath = 1;
      entity.takedamage = 1;
      entity.aioverridedamage = undefined;
      entity.magic_bullet_shield = 0;
      level notify("interdimensional_kill", entity);
      if(isDefined(entity.interdimensional_gun_weapon) && isDefined(entity.interdimensional_gun_attacker)) {
        entity kill(entity.origin, entity.interdimensional_gun_attacker, entity.interdimensional_gun_attacker, entity.interdimensional_gun_weapon);
      } else {
        entity kill(entity.origin);
      }
    } else {
      if(entity.hole_pull_speed < 12) {
        entity.hole_pull_speed = entity.hole_pull_speed + 0.5;
        if(entity.hole_pull_speed > 12) {
          entity.hole_pull_speed = 12;
        }
      }
      flyingdir = vectornormalize(flyingdir);
      entity forceteleport(entity.origin + (flyingdir * entity.hole_pull_speed));
    }
  }
}

function zombieidgunholedeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("noclip");
  entity.pushable = 0;
}

function zombieidgunholedeathmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!(isDefined(entity.interdimensional_gun_kill_vortex_explosion) && entity.interdimensional_gun_kill_vortex_explosion)) {
    entity hide();
  }
}

function private zombieturnmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("angle deltas", 0);
}

function private zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  normalizedtime = (entity getanimtime(mocompanim) + mocompanimblendouttime) / mocompduration;
  if(normalizedtime > 0.25) {
    entity orientmode("face motion");
    entity animmode("normal", 0);
  }
}

function private zombieturnmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face motion");
  entity animmode("normal", 0);
}

function zombiehaslegs(behaviortreeentity) {
  if(behaviortreeentity.missinglegs === 1) {
    return false;
  }
  return true;
}

function zombieshouldproceduraltraverse(entity) {
  return isDefined(entity.traversestartnode) && isDefined(entity.traverseendnode) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

function zombieshouldmeleesuicide(behaviortreeentity) {
  if(!behaviortreeentity ai::get_behavior_attribute("suicidal_behavior")) {
    return false;
  }
  if(isDefined(behaviortreeentity.magic_bullet_shield) && behaviortreeentity.magic_bullet_shield) {
    return false;
  }
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  if(isDefined(behaviortreeentity.marked_for_death)) {
    return false;
  }
  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 40000) {
    return false;
  }
  return true;
}

function zombiemeleesuicidestart(behaviortreeentity) {
  behaviortreeentity.blockingpain = 1;
  if(isDefined(level.zombiemeleesuicidecallback)) {
    behaviortreeentity thread[[level.zombiemeleesuicidecallback]](behaviortreeentity);
  }
}

function zombiemeleesuicideupdate(behaviortreeentity) {}

function zombiemeleesuicideterminate(behaviortreeentity) {
  if(isalive(behaviortreeentity) && zombieshouldmeleesuicide(behaviortreeentity)) {
    behaviortreeentity.takedamage = 1;
    behaviortreeentity.allowdeath = 1;
    if(isDefined(level.zombiemeleesuicidedonecallback)) {
      behaviortreeentity thread[[level.zombiemeleesuicidedonecallback]](behaviortreeentity);
    }
  }
}

function zombiemoveaction(behaviortreeentity, asmstatename) {
  behaviortreeentity.movetime = gettime();
  behaviortreeentity.moveorigin = behaviortreeentity.origin;
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  if(isDefined(behaviortreeentity.stumble) && !isDefined(behaviortreeentity.move_anim_end_time)) {
    stumbleactionresult = behaviortreeentity astsearch(istring(asmstatename));
    stumbleactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, stumbleactionresult["animation"]);
    behaviortreeentity.move_anim_end_time = behaviortreeentity.movetime + getanimlength(stumbleactionanimation);
  }
  if(isDefined(behaviortreeentity.zombiemoveactioncallback)) {
    behaviortreeentity[[behaviortreeentity.zombiemoveactioncallback]](behaviortreeentity);
  }
  return 5;
}

function zombiemoveactionupdate(behaviortreeentity, asmstatename) {
  if(isDefined(behaviortreeentity.move_anim_end_time) && gettime() >= behaviortreeentity.move_anim_end_time) {
    behaviortreeentity.move_anim_end_time = undefined;
    return 4;
  }
  if(!(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) && (gettime() - behaviortreeentity.movetime) > 1000) {
    distsq = distance2dsquared(behaviortreeentity.origin, behaviortreeentity.moveorigin);
    if(distsq < 144) {
      behaviortreeentity setavoidancemask("avoid all");
      behaviortreeentity.cant_move = 1;
      if(isDefined(behaviortreeentity.cant_move_cb)) {
        behaviortreeentity[[behaviortreeentity.cant_move_cb]]();
      }
    } else {
      behaviortreeentity setavoidancemask("avoid none");
      behaviortreeentity.cant_move = 0;
    }
    behaviortreeentity.movetime = gettime();
    behaviortreeentity.moveorigin = behaviortreeentity.origin;
  }
  if(behaviortreeentity asmgetstatus() == "asm_status_complete") {
    if(behaviortreeentity iscurrentbtactionlooping()) {
      zombiemoveaction(behaviortreeentity, asmstatename);
    } else {
      return 4;
    }
  }
  return 5;
}

function zombiemoveactionterminate(behaviortreeentity, asmstatename) {
  if(!(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)) {
    behaviortreeentity setavoidancemask("avoid none");
  }
  return 4;
}

function archetypezombiedeathoverrideinit() {
  aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

function private zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
  if(!(isDefined(level.zombieanhilationenabled) && level.zombieanhilationenabled)) {
    return damage;
  }
  if(isDefined(self.forceanhilateondeath) && self.forceanhilateondeath) {
    self zombie_utility::gib_random_parts();
    gibserverutils::annihilate(self);
    return damage;
  }
  if(isDefined(attacker) && isPlayer(attacker) && (isDefined(attacker.forceanhilateondeath) && attacker.forceanhilateondeath || (isDefined(level.forceanhilateondeath) && level.forceanhilateondeath))) {
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
      iscloseexplosive = distancesquared(inflictor.origin, self.origin) <= (60 * 60);
      if(isdirectexplosive && iscloseexplosive) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
      }
    }
  }
  return damage;
}

function private zombiezombieidlemocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1]) && entity != entity.enemyoverride[1]) {
    entity orientmode("face direction", entity.enemyoverride[1].origin - entity.origin);
    entity animmode("zonly_physics", 0);
  } else {
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
  }
}

function private zombieattackobjectmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.attackable_slot)) {
    entity orientmode("face angle", entity.attackable_slot.angles[1]);
    entity animmode("zonly_physics", 0);
  } else {
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
  }
}

function private zombieattackobjectmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.attackable_slot)) {
    entity forceteleport(entity.attackable_slot.origin);
  }
}
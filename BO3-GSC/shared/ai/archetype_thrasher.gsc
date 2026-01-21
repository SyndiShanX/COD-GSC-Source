/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_thrasher.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_thrasher_interface;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace thrasherbehavior;

function autoexec __init__sytem__() {
  system::register("thrasher", &__init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_info("visionset", "zm_isl_thrasher_stomach_visionset", 9000, 30, 16, 1, &visionset_mgr::ramp_in_thread_per_player, 0);
  initthrasherbehaviorsandasm();
  spawner::add_archetype_spawn_function("thrasher", &archetypethrasherblackboardinit);
  spawner::add_archetype_spawn_function("thrasher", &thrasherspawnsetup);
  if(ai::shouldregisterclientfieldforarchetype("thrasher")) {
    clientfield::register("actor", "thrasher_spore_state", 5000, 3, "int");
    clientfield::register("actor", "thrasher_berserk_state", 5000, 1, "int");
    clientfield::register("actor", "thrasher_player_hide", 8000, 4, "int");
    clientfield::register("toplayer", "sndPlayerConsumed", 10000, 1, "int");
    foreach(spore in array(1, 2, 4)) {
      clientfield::register("actor", "thrasher_spore_impact" + spore, 8000, 1, "counter");
    }
  }
  thrasherinterface::registerthrasherinterfaceattributes();
}

function private initthrasherbehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherRageService", &thrasherrageservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTargetService", &thrashertargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherKnockdownService", &thrasherknockdownservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherAttackableObjectService", &thrasherattackableobjectservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldBeStunned", &thrashershouldbestunned);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldMelee", &thrashershouldmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldShowPain", &thrashershouldshowpain);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldTurnBerserk", &thrashershouldturnberserk);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldTeleport", &thrashershouldteleport);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldConsumePlayer", &thrashershouldconsumeplayer);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldConsumeZombie", &thrashershouldconsumezombie);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherConsumePlayer", &thrasherconsumeplayer);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherConsumeZombie", &thrasherconsumezombie);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherPlayedBerserkIntro", &thrasherserverutils::thrasherplayedberserkintro);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTeleport", &thrasherserverutils::thrasherteleport);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTeleportOut", &thrasherserverutils::thrasherteleportout);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherDeath", &thrasherdeath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherStartTraverse", &thrasherserverutils::thrasherstarttraverse);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTerminateTraverse", &thrasherserverutils::thrasherterminatetraverse);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherStunInitialize", &thrasherserverutils::thrasherstuninitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherStunUpdate", &thrasherserverutils::thrasherstunupdate);
  animationstatenetwork::registernotetrackhandlerfunction("thrasher_melee", &thrashernotetrackmelee);
}

function private archetypethrasherblackboardinit() {
  entity = self;
  blackboard::createblackboardforentity(entity);
  entity aiutility::registerutilityblackboardattributes();
  ai::createinterfaceforentity(entity);
  thrasher_speed = "locomotion_speed_walk";
  if(entity.thrasherhasturnedberserk === 1) {
    thrasher_speed = "locomotion_speed_run";
  }
  blackboard::registerblackboardattribute(self, "_locomotion_speed", thrasher_speed, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_zombie_damageweapon_type", "regular", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  entity.___archetypeonanimscriptedcallback = &archetypethrasheronanimscriptedcallback;
  entity finalizetrackedblackboardattributes();
}

function private archetypethrasheronanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypethrasherblackboardinit();
}

function private thrasherspawnsetup() {
  entity = self;
  entity.health = 1000;
  entity.maxhealth = entity.health;
  entity.thrasherconsumedplayer = 0;
  entity.thrasherisberserk = 0;
  entity.thrasherhasturnedberserk = 0;
  entity.thrasherheadhealth = 10;
  entity.thrasherlastconsume = gettime();
  entity.thrasherconsumecooldown = 3000;
  entity.thrasherconsumecount = 0;
  entity.thrasherconsumemax = 2;
  entity.thrasherlastteleporttime = gettime();
  entity.thrasherstunhealth = 3000;
  entity.thrasherragecount = 0;
  entity.thrasherragelevel = 1;
  thrasherinitspores();
  thrasherserverutils::thrasherhidespikes(entity, 1);
  aiutility::addaioverridedamagecallback(entity, &thrasherserverutils::thrasherdamagecallback);
}

function private bb_getshouldturn() {
  entity = self;
  if(isDefined(entity.should_turn) && entity.should_turn) {
    return "should_turn";
  }
  return "should_not_turn";
}

function private thrasherinitspores() {
  entity = self;
  assert(array("", "", "").size == array(1, 2, 4).size);
  thrasherspores = array("tag_spore_chest", "tag_spore_back", "tag_spore_leg");
  thrashersporedamagedists = array(12, 18, 12);
  thrasherclientfields = array(1, 2, 4);
  entity.thrasherspores = [];
  for(index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
    sporestruct = spawnStruct();
    sporestruct.dist = thrashersporedamagedists[index];
    sporestruct.health = 100;
    sporestruct.maxhealth = sporestruct.health;
    sporestruct.state = "state_healthly";
    sporestruct.tag = thrasherspores[index];
    sporestruct.clientfield = thrasherclientfields[index];
    entity.thrasherspores[index] = sporestruct;
  }
}

function private thrashernotetrackmelee(entity) {
  if(isDefined(entity.thrasher_melee_knockdown_function)) {
    entity thread[[entity.thrasher_melee_knockdown_function]]();
  }
  hitentity = entity melee();
  if(isDefined(hitentity) && isDefined(entity.thrashermeleehitcallback)) {
    entity thread[[entity.thrashermeleehitcallback]](hitentity);
  }
  if(aiutility::shouldattackobject(entity)) {
    if(isDefined(level.attackablecallback)) {
      entity.attackable[[level.attackablecallback]](entity);
    }
  }
}

function private thrashergetclosestlaststandplayer(entity) {
  if(entity.thrasherconsumedplayer) {
    return;
  }
  maxconsumedistancesq = 2400 * 2400;
  targets = getplayers();
  if(targets.size == 1) {
    return;
  }
  laststandtargets = [];
  foreach(target in targets) {
    if(!isDefined(target.laststandstarttime) || (target.laststandstarttime + 5000) > gettime()) {
      continue;
    }
    if(isDefined(target.thrasherfreedtime) && (target.thrasherfreedtime + 10000) > gettime()) {
      continue;
    }
    if(target laststand::player_is_in_laststand() && (!(isDefined(target.thrasherconsumed) && target.thrasherconsumed)) && distancesquared(target.origin, entity.origin) <= maxconsumedistancesq) {
      laststandtargets[laststandtargets.size] = target;
    }
  }
  if(laststandtargets.size > 0) {
    sortedpotentialtargets = arraysortclosest(laststandtargets, entity.origin);
    return sortedpotentialtargets[0];
  }
}

function private thrasherrageservice(entity) {
  entity.thrasherragecount = entity.thrasherragecount + ((entity.thrasherragelevel * 1) + 1);
  if(entity.thrasherragecount >= 200) {
    thrasherserverutils::thrashergoberserk(entity);
  }
}

function private thrashertargetservice(entity) {
  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    return false;
  }
  if(entity ai::get_behavior_attribute("move_mode") == "friendly") {
    if(isDefined(entity.thrashermovemodefriendlycallback)) {
      entity[[entity.thrashermovemodefriendlycallback]]();
    }
    return true;
  }
  laststandplayer = thrashergetclosestlaststandplayer(entity);
  if(isDefined(laststandplayer)) {
    entity.favoriteenemy = laststandplayer;
    entity setgoal(entity.favoriteenemy.origin);
    return true;
  }
  entity.ignore_player = [];
  players = getplayers();
  foreach(player in players) {
    if(player isnotarget() || player.ignoreme || player laststand::player_is_in_laststand() || (isDefined(player.thrasherconsumed) && player.thrasherconsumed)) {
      entity.ignore_player[entity.ignore_player.size] = player;
    }
  }
  player = undefined;
  if(isDefined(entity.thrasherclosestvalidplayer)) {
    player = [[entity.thrasherclosestvalidplayer]](entity.origin, entity.ignore_player);
  } else {
    player = zombie_utility::get_closest_valid_player(entity.origin, entity.ignore_player);
  }
  entity.favoriteenemy = player;
  if(!isDefined(player) || player isnotarget()) {
    if(isDefined(entity.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]()) {
        return;
      }
      entity.ignore_player = [];
    }
    entity setgoal(entity.origin);
    return false;
  }
  if(isDefined(entity.attackable)) {
    if(isDefined(entity.attackable_slot)) {
      entity setgoal(entity.attackable_slot.origin, 1);
    }
  } else {
    targetpos = getclosestpointonnavmesh(player.origin, 128, 30);
    if(isDefined(targetpos)) {
      entity setgoal(targetpos);
      return true;
    }
    entity setgoal(entity.origin);
    return false;
  }
}

function private thrasherattackableobjectservice(entity) {
  if(isDefined(entity.thrasherattackableobjectcallback)) {
    return [[entity.thrasherattackableobjectcallback]](entity);
  }
  return 0;
}

function private thrasherknockdownservice(entity) {
  velocity = entity getvelocity();
  predict_time = 0.3;
  predicted_pos = entity.origin + (velocity * predict_time);
  move_dist_sq = distancesquared(predicted_pos, entity.origin);
  speed = move_dist_sq / predict_time;
  if(speed >= 10) {
    a_zombies = getaiarchetypearray("zombie");
    a_filtered_zombies = array::filter(a_zombies, 0, &thrasherzombieeligibleforknockdown, entity, predicted_pos);
    if(a_filtered_zombies.size > 0) {
      foreach(zombie in a_filtered_zombies) {
        thrasherserverutils::thrasherknockdownzombie(entity, zombie);
      }
    }
  }
}

function private thrasherzombieeligibleforknockdown(zombie, thrasher, predicted_pos) {
  if(zombie.knockdown === 1) {
    return false;
  }
  knockdown_dist_sq = 2304;
  dist_sq = distancesquared(predicted_pos, zombie.origin);
  if(dist_sq > knockdown_dist_sq) {
    return false;
  }
  origin = thrasher.origin;
  facing_vec = anglesToForward(thrasher.angles);
  enemy_vec = zombie.origin - origin;
  enemy_yaw_vec = (enemy_vec[0], enemy_vec[1], 0);
  facing_yaw_vec = (facing_vec[0], facing_vec[1], 0);
  enemy_yaw_vec = vectornormalize(enemy_yaw_vec);
  facing_yaw_vec = vectornormalize(facing_yaw_vec);
  enemy_dot = vectordot(facing_yaw_vec, enemy_yaw_vec);
  if(enemy_dot < 0) {
    return false;
  }
  return true;
}

function thrashershouldmelee(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }
  if(distancesquared(entity.origin, entity.favoriteenemy.origin) > 9216) {
    return false;
  }
  if(entity.favoriteenemy isnotarget()) {
    return false;
  }
  yaw = abs(zombie_utility::getyawtoenemy());
  if(yaw > 60) {
    return false;
  }
  if(entity.favoriteenemy laststand::player_is_in_laststand()) {
    return false;
  }
  return true;
}

function private thrashershouldshowpain(entity) {
  return false;
}

function private thrashershouldturnberserk(entity) {
  return entity.thrasherisberserk && !entity.thrasherhasturnedberserk;
}

function private thrashershouldteleport(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    return 0;
  }
  if((entity.thrasherlastteleporttime + 10000) > gettime()) {
    return 0;
  }
  if(distancesquared(entity.origin, entity.favoriteenemy.origin) >= 1440000) {
    if(isDefined(entity.thrashershouldteleportcallback)) {
      return [[entity.thrashershouldteleportcallback]](entity.origin) && [[entity.thrashershouldteleportcallback]](entity.favoriteenemy.origin);
    }
    return 1;
  }
  return 0;
}

function private thrashershouldconsumeplayer(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }
  targets = getplayers();
  if(targets.size == 1) {
    return false;
  }
  if(distancesquared(entity.origin, entity.favoriteenemy.origin) > 2304) {
    return false;
  }
  if(!entity.favoriteenemy laststand::player_is_in_laststand()) {
    return false;
  }
  if(isDefined(entity.favoriteenemy.thrasherconsumed) && entity.favoriteenemy.thrasherconsumed) {
    return false;
  }
  if(isDefined(entity.thrashercanconsumeplayercallback) && !entity[[entity.thrashercanconsumeplayercallback]](entity)) {
    return false;
  }
  return true;
}

function private thrashershouldconsumezombie(entity) {
  if(entity.thrasherconsumecount >= entity.thrasherconsumemax) {
    return 0;
  }
  if((entity.thrasherlastconsume + entity.thrasherconsumecooldown) >= gettime()) {
    return 0;
  }
  haspoppedpustule = 0;
  for(index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
    sporestruct = entity.thrasherspores[index];
    if(sporestruct.health <= 0) {
      haspoppedpustule = 1;
      break;
    }
  }
  if(haspoppedpustule) {
    if(isDefined(entity.thrashercanconsumecallback)) {
      return [[entity.thrashercanconsumecallback]](entity);
    }
  }
  return 0;
}

function private thrasherconsumeplayer(entity) {
  if(isplayer(entity.favoriteenemy)) {
    entity thread thrasherserverutils::thrasherconsumeplayerutil(entity, entity.favoriteenemy);
  }
}

function private thrasherdeath(entity) {
  gibserverutils::annihilate(entity);
}

function private thrasherconsumezombie(entity) {
  if(isDefined(entity.thrasherconsumezombiecallback)) {
    if([[entity.thrasherconsumezombiecallback]](entity)) {
      entity.thrasherconsumecount++;
      entity.thrasherlastconsume = gettime();
    }
  }
}

function private thrashershouldbestunned(entity) {
  return entity ai::get_behavior_attribute("stunned");
}

#namespace thrasherserverutils;

function thrasherknockdownzombie(entity, zombie) {
  zombie.knockdown = 1;
  zombie.knockdown_type = "knockdown_shoved";
  zombie_to_thrasher = entity.origin - zombie.origin;
  zombie_to_thrasher_2d = vectornormalize((zombie_to_thrasher[0], zombie_to_thrasher[1], 0));
  zombie_forward = anglesToForward(zombie.angles);
  zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
  zombie_right = anglestoright(zombie.angles);
  zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
  dot = vectordot(zombie_to_thrasher_2d, zombie_forward_2d);
  if(dot >= 0.5) {
    zombie.knockdown_direction = "front";
    zombie.getup_direction = "getup_back";
  } else {
    if(dot < 0.5 && dot > -0.5) {
      dot = vectordot(zombie_to_thrasher_2d, zombie_right_2d);
      if(dot > 0) {
        zombie.knockdown_direction = "right";
        if(math::cointoss()) {
          zombie.getup_direction = "getup_back";
        } else {
          zombie.getup_direction = "getup_belly";
        }
      } else {
        zombie.knockdown_direction = "left";
        zombie.getup_direction = "getup_belly";
      }
    } else {
      zombie.knockdown_direction = "back";
      zombie.getup_direction = "getup_belly";
    }
  }
}

function thrashergoberserk(entity) {
  if(!entity.thrasherisberserk) {
    entity thread thrasherinvulnerability(2.5);
    entity.thrasherisberserk = 1;
    entity.health = entity.health + 1500;
    entity clientfield::set("thrasher_berserk_state", 1);
    thrasherhidespikes(entity, 0);
  }
}

function private thrasherplayedberserkintro(entity) {
  entity.thrasherhasturnedberserk = 1;
  meleeweapon = getweapon("thrasher_melee_enraged");
  entity.meleeweapon = getweapon("thrasher_melee_enraged");
  entity ai::set_behavior_attribute("stunned", 0);
  entity.thrasherstunhealth = 3000;
  blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
}

function thrasherdamagecallback(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;
  if(hitloc == "head" && !gibserverutils::isgibbed(entity, 8)) {
    entity.thrasherragecount = entity.thrasherragecount + 200;
    entity.thrasherheadhealth = entity.thrasherheadhealth - damage;
    if(entity.thrasherheadhealth <= 0) {
      if(isDefined(attacker)) {
        attacker notify("destroyed_thrasher_head");
      }
      gibserverutils::gibhead(entity);
      thrasherhidepoppedpustules(entity);
    }
  } else {
    entity.thrasherragecount = entity.thrasherragecount + 10;
    entity.thrasherstunhealth = entity.thrasherstunhealth - damage;
    if(entity.thrasherstunhealth <= 0) {
      entity ai::set_behavior_attribute("stunned", 1);
      if(isDefined(attacker)) {
        attacker notify("player_stunned_thrasher");
      }
    }
  }
  damage = thrashersporedamagecallback(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
  if(entity.thrasherragecount >= 200) {
    thrashergoberserk(entity);
    if(isDefined(attacker)) {
      attacker notify("player_enraged_thrasher");
    }
  }
  if(isDefined(entity.b_thrasher_temp_invulnerable) && entity.b_thrasher_temp_invulnerable) {
    damage = 1;
  }
  damage = int(damage);
  return damage;
}

function private thrasherinvulnerability(n_time) {
  entity = self;
  entity endon("death");
  entity notify("end_invulnerability");
  entity.b_thrasher_temp_invulnerable = 1;
  entity util::waittill_notify_or_timeout("end_invulnerability", n_time);
  entity.b_thrasher_temp_invulnerable = 0;
}

function thrashersporedamagecallback(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;
  assert(isDefined(entity.thrasherspores));
  if(!isDefined(point)) {
    return damage;
  }
  healthyspores = 0;
  for(index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
    sporestruct = entity.thrasherspores[index];
    assert(isDefined(sporestruct));
    if(sporestruct.health < 0) {
      continue;
    }
    tagorigin = entity gettagorigin(sporestruct.tag);
    if(isDefined(tagorigin) && distancesquared(tagorigin, point) < (sporestruct.dist * sporestruct.dist)) {
      entity.thrasherragecount = entity.thrasherragecount + 10;
      sporestruct.health = sporestruct.health - damage;
      entity clientfield::increment("thrasher_spore_impact" + sporestruct.clientfield);
      if(sporestruct.health <= 0) {
        entity hidepart(sporestruct.tag);
        sporestruct.state = "state_destroyed";
        destroyedspores = entity clientfield::get("thrasher_spore_state");
        destroyedspores = destroyedspores | sporestruct.clientfield;
        entity clientfield::set("thrasher_spore_state", destroyedspores);
        if(isDefined(entity.thrasherpustulepopcallback)) {
          entity thread[[entity.thrasherpustulepopcallback]](tagorigin, weapon, attacker);
        }
        entity ai::set_behavior_attribute("stunned", 1);
        damage = entity.maxhealth / array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size;
      }
      recordsphere(tagorigin, sporestruct.dist, (1, 1, 0), "", entity);
    }
    if(sporestruct.health > 0) {
      healthyspores++;
    }
  }
  if(healthyspores == 0) {
    damage = entity.maxhealth;
  }
  return damage;
}

function private thrasherteleportout(entity) {
  if(isDefined(entity.thrasherteleportcallback)) {
    entity thread[[entity.thrasherteleportcallback]](entity);
  }
}

function thrasherstarttraverse(entity) {
  aiutility::traversesetup(entity);
  if(isDefined(entity.thrasherstarttraversecallback)) {
    entity[[entity.thrasherstarttraversecallback]](entity);
  }
}

function thrasherterminatetraverse(entity) {
  if(isDefined(entity.thrasherterminatetraversecallback)) {
    entity[[entity.thrasherterminatetraversecallback]](entity);
  }
}

function thrasherteleport(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    println("");
    return;
  }
  points = util::positionquery_pointarray(entity.favoriteenemy.origin, 128, 256, 32, 64, entity);
  filteredpoints = [];
  thrashers = getaiarchetypearray("thrasher");
  overlapsqr = 240 * 240;
  foreach(point in points) {
    valid = 1;
    foreach(thrasher in thrashers) {
      if(distancesquared(point, thrasher.origin) <= overlapsqr) {
        valid = 0;
        break;
      }
    }
    if(valid) {
      filteredpoints[filteredpoints.size] = point;
    }
  }
  if(isDefined(entity.thrasher_teleport_dest_func)) {
    filteredpoints = entity[[entity.thrasher_teleport_dest_func]](filteredpoints);
  }
  sortedpoints = arraysortclosest(filteredpoints, entity.origin);
  teleport_point = sortedpoints[0];
  if(isDefined(teleport_point)) {
    v_dir = entity.favoriteenemy.origin - teleport_point;
    v_dir = vectornormalize(v_dir);
    v_angles = vectortoangles(v_dir);
    entity forceteleport(teleport_point, v_angles);
  }
  entity.thrasherlastteleporttime = gettime();
}

function private thrasherstuninitialize(entity) {
  entity.thrasherstunstarttime = gettime();
}

function private thrasherstunupdate(entity) {
  if((entity.thrasherstunstarttime + 1000) < gettime()) {
    entity ai::set_behavior_attribute("stunned", 0);
    entity.thrasherstunhealth = 3000;
  }
}

function private thrasherhidespikes(entity, hide) {
  for(index = 1; index <= 24; index++) {
    tag = "j_spike";
    if(index < 10) {
      tag = tag + "0";
    }
    tag = (tag + index) + "_root";
    if(hide) {
      entity hidepart(tag, "", 1);
      continue;
    }
    entity showpart(tag, "", 1);
  }
}

function thrasherhidefromplayer(thrasher, player, hide) {
  entitynumber = player getentitynumber();
  entitybit = 1 << entitynumber;
  currenthidden = clientfield::get("thrasher_player_hide");
  hiddenplayers = currenthidden;
  if(hide) {
    hiddenplayers = currenthidden | entitybit;
  } else {
    hiddenplayers = currenthidden &(~entitybit);
  }
  thrasher clientfield::set("thrasher_player_hide", hiddenplayers);
}

function thrasherhidepoppedpustules(entity) {
  for(index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
    sporestruct = entity.thrasherspores[index];
    if(sporestruct.health <= 0) {
      entity hidepart(sporestruct.tag);
      continue;
    }
    entity showpart(sporestruct.tag);
  }
}

function thrasherrestorepustule(entity) {
  for(index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
    sporestruct = entity.thrasherspores[index];
    if(sporestruct.health <= 0) {
      sporestruct.health = sporestruct.maxhealth;
      entity.health = entity.health + (int(entity.maxhealth / array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size));
      destroyedspores = entity clientfield::get("thrasher_spore_state");
      destroyedspores = destroyedspores &(~sporestruct.clientfield);
      entity clientfield::set("thrasher_spore_state", destroyedspores);
      break;
    }
  }
  thrasherhidepoppedpustules(entity);
}

function thrashercreateplayerclone(player) {
  clone = spawn("script_model", player.origin);
  clone.angles = player.angles;
  bodymodel = player getcharacterbodymodel();
  if(isDefined(bodymodel)) {
    clone setModel(bodymodel);
  }
  headmodel = player getcharacterheadmodel();
  if(isDefined(headmodel) && headmodel != "tag_origin") {
    if(isDefined(clone.head)) {
      clone detach(clone.head);
    }
    clone attach(headmodel);
  }
  helmetmodel = player getcharacterhelmetmodel();
  if(isDefined(helmetmodel) && headmodel != "tag_origin") {
    clone attach(helmetmodel);
  }
  return clone;
}

function thrasherhideplayerbody(thrasher, player) {
  player endon("death");
  player waittill("hide_body");
  player hide();
}

function thrashercanberevived(revivee) {
  if(isDefined(revivee.thrasherconsumed) && revivee.thrasherconsumed) {
    return false;
  }
  return true;
}

function private thrasherstopconsumeplayerscene(thrasher, playerclone) {
  thrasher endon("consume_scene_end");
  thrasher waittill("death");
  if(isDefined(thrasher)) {
    thrasher scene::stop("scene_zm_dlc2_thrasher_eat_player");
  }
  if(isDefined(playerclone)) {
    playerclone delete();
  }
}

function private thrasherconsumeplayerscene(thrasher, playerclone) {
  thrasher endon("death");
  thrasher thread thrasherstopconsumeplayerscene(thrasher, playerclone);
  thrasher scene::play("scene_zm_dlc2_thrasher_eat_player", array(thrasher, playerclone));
  thrasher notify("consume_scene_end");
  targetpos = getclosestpointonnavmesh(thrasher.origin, 1024, 18);
  if(isDefined(targetpos)) {
    thrasher forceteleport(targetpos);
  }
}

function thrasherconsumeplayerutil(thrasher, player) {
  assert(isactor(thrasher));
  assert(thrasher.archetype == "");
  assert(isplayer(player));
  thrasher endon("kill_consume_player");
  if(isDefined(player.thrasherconsumed) && player.thrasherconsumed) {
    return;
  }
  playerclone = thrashercreateplayerclone(player);
  playerclone.origin = player.origin;
  playerclone.angles = player.angles;
  playerclone hide();
  thrasher.offsetmodel = spawn("script_model", thrasher.origin);
  util::wait_network_frame();
  if(!isDefined(thrasher) || (isDefined(player.thrasherconsumed) && player.thrasherconsumed)) {
    playerclone destroy();
    return;
  }
  thrasherhidefromplayer(thrasher, player, 1);
  if(isDefined(thrasher.thrasherconsumedcallback)) {
    [[thrasher.thrasherconsumedcallback]](thrasher, player);
  }
  if(isDefined(player.revivetrigger)) {
    player.revivetrigger setinvisibletoall();
    player.revivetrigger triggerenable(0);
  }
  player setclientuivisibilityflag("hud_visible", 0);
  player setclientuivisibilityflag("weapon_hud_visible", 0);
  player.thrasherconsumed = 1;
  player.thrasher = thrasher;
  player setplayercollision(0);
  player walkunderwater(1);
  player.ignoreme = 1;
  player hideviewmodel();
  player freezecontrols(0);
  player freezecontrolsallowlook(1);
  player thread lui::screen_fade_in(10);
  player clientfield::set_to_player("sndPlayerConsumed", 1);
  visionset_mgr::activate("visionset", "zm_isl_thrasher_stomach_visionset", player, 2);
  player thread thrasherkillthrasheronautorevive(thrasher, player);
  eyeposition = player gettagorigin("tag_eye");
  eyeoffset = (abs(eyeposition[2] - player.origin[2])) + 10;
  thrasher.offsetmodel linkto(thrasher, "tag_camera_thrasher", (0, 0, (eyeoffset * -1) + 27));
  player playerlinkto(thrasher.offsetmodel, undefined, 1, 0, 0, 0, 0, 1);
  thrasher thread thrasherplayerdeath(thrasher, player);
  thrasher.thrasherconsumedplayer = 1;
  thrasher.thrasherplayer = player;
  thrasher.thrasherlastteleporttime = gettime();
  player ghost();
  playerclone show();
  if(isDefined(playerclone)) {
    thrasher thread thrasherconsumeplayerscene(thrasher, playerclone);
    playerclone thread thrasherhideplayerbody(thrasher, playerclone);
    player notify("player_eaten_by_thrasher");
  }
  thrasher waittill("death");
  thrasherreleaseplayer(thrasher, player);
}

function thrasherkillthrasheronautorevive(thrasher, player) {
  player endon("death");
  player endon("kill_thrasher_on_auto_revive");
  player waittill("bgb_revive");
  if(isDefined(player.thrasher)) {
    player.thrasher kill();
  }
}

function thrasherreleaseplayer(thrasher, player) {
  if(!isalive(player)) {
    return;
  }
  if(isDefined(thrasher.offsetmodel)) {
    thrasher.offsetmodel unlink();
    thrasher.offsetmodel delete();
  }
  if(isDefined(player.revivetrigger)) {
    player.revivetrigger setvisibletoall();
    player.revivetrigger triggerenable(1);
  }
  if(isDefined(thrasher.thrasherreleaseconsumedcallback)) {
    [[thrasher.thrasherreleaseconsumedcallback]](thrasher, player);
  }
  thrasher.thrasherplayer = undefined;
  player setclientuivisibilityflag("hud_visible", 1);
  player setclientuivisibilityflag("weapon_hud_visible", 1);
  player.thrasherfreedtime = gettime();
  player setstance("prone");
  player notify("kill_thrasher_on_auto_revive");
  player.thrasherconsumed = undefined;
  player.thrasher = undefined;
  player walkunderwater(0);
  player unlink();
  player setplayercollision(1);
  player show();
  player.ignoreme = 0;
  player showviewmodel();
  player freezecontrolsallowlook(0);
  player thread lui::screen_fade_in(2);
  player clientfield::set_to_player("sndPlayerConsumed", 0);
  visionset_mgr::deactivate("visionset", "zm_isl_thrasher_stomach_visionset", player);
  player thread check_revive_after_consumed();
  targetpos = getclosestpointonnavmesh(player.origin, 1024, 18);
  if(isDefined(targetpos)) {
    newposition = player.origin;
    groundposition = bulletTrace(targetpos + (vectorscale((0, 0, -1), 128)), targetpos + vectorscale((0, 0, 1), 128), 0, player);
    if(isDefined(groundposition["position"])) {
      newposition = groundposition["position"];
    } else {
      groundposition = bulletTrace(targetpos + (vectorscale((0, 0, -1), 256)), targetpos + vectorscale((0, 0, 1), 256), 0, player);
      if(isDefined(groundposition["position"])) {
        newposition = groundposition["position"];
      } else {
        groundposition = bulletTrace(targetpos + (vectorscale((0, 0, -1), 512)), targetpos + vectorscale((0, 0, 1), 512), 0, player);
        if(isDefined(groundposition["position"])) {
          newposition = groundposition["position"];
        }
      }
    }
    if(newposition[2] > player.origin[2]) {
      player.origin = newposition;
    }
  }
  thrasher notify("kill_consume_player");
}

function check_revive_after_consumed() {
  self endon("death");
  self waittill("player_revived");
  self notify("achievement_zm_island_thrasher_rescue");
}

function thrasherplayerdeath(thrasher, player) {
  thrasher endon("kill_consume_player");
  thrasher.thrasherplayer = undefined;
  characterindex = player.characterindex;
  if(!isDefined(characterindex)) {
    return;
  }
  level waittill("bleed_out", characterindex);
  if(isDefined(thrasher.thrasherreleaseconsumedcallback)) {
    [[thrasher.thrasherreleaseconsumedcallback]](thrasher, player);
  }
  if(isDefined(thrasher) && isDefined(player)) {
    thrasherhidefromplayer(thrasher, player, 0);
  }
  if(isDefined(player)) {
    player showviewmodel();
    player clientfield::set_to_player("sndPlayerConsumed", 0);
    visionset_mgr::deactivate("visionset", "zm_isl_thrasher_stomach_visionset", player);
  }
}

function thrashermovemodeattributecallback(entity, attribute, oldvalue, value) {
  if(value == "normal") {
    entity.team = "axis";
  } else if(value == "friendly") {
    entity.team = "allies";
  }
}
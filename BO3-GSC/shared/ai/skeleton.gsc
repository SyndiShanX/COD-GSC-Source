/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\skeleton.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace skeletonbehavior;

function autoexec __init__sytem__() {
  system::register("skeleton", & __init__, undefined, undefined);
}

function __init__() {
  initskeletonbehaviorsandasm();
  spawner::add_archetype_spawn_function("skeleton", & archetypeskeletonblackboardinit);
  spawner::add_archetype_spawn_function("skeleton", & skeletonspawnsetup);
  if(ai::shouldregisterclientfieldforarchetype("skeleton")) {
    clientfield::register("actor", "skeleton", 1, 1, "int");
  }
}

function skeletonspawnsetup() {
  self.zombie_move_speed = "walk";
  if(randomint(2) == 0) {
    self.zombie_arms_position = "up";
  } else {
    self.zombie_arms_position = "down";
  }
  self.missinglegs = 0;
  self setavoidancemask("avoid none");
  self pushactors(1);
  clientfield::set("skeleton", 1);
}

function private initskeletonbehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonTargetService", & skeletontargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonShouldMelee", & skeletonshouldmeleecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonGibLegsCondition", & skeletongiblegscondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isSkeletonWalking", & isskeletonwalking);
  behaviortreenetworkutility::registerbehaviortreescriptapi("skeletonDeathAction", & skeletondeathaction);
  animationstatenetwork::registernotetrackhandlerfunction("contact", & skeletonnotetrackmeleefire);
}

function private archetypeskeletonblackboardinit() {
  blackboard::createblackboardforentity(self);
  self aiutility::registerutilityblackboardattributes();
  blackboard::registerblackboardattribute(self, "_arms_position", "arms_up", & bb_getarmsposition);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", & bb_getlocomotionspeedtype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_has_legs", "has_legs_yes", & bb_gethaslegsstatus);
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
  self.___archetypeonanimscriptedcallback = & archetypeskeletononanimscriptedcallback;
  self finalizetrackedblackboardattributes();
}

function private archetypeskeletononanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypeskeletonblackboardinit();
}

function bb_getarmsposition() {
  if(isDefined(self.skeleton_arms_position)) {
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
  }
  return "locomotion_speed_walk";
}

function bb_gethaslegsstatus() {
  if(self.missinglegs) {
    return "has_legs_no";
  }
  return "has_legs_yes";
}

function isskeletonwalking(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.zombie_move_speed)) {
    return 1;
  }
  return behaviortreeentity.zombie_move_speed == "walk" && (!(isDefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)) && behaviortreeentity.zombie_arms_position == "up";
}

function skeletongiblegscondition(behaviortreeentity) {
  return gibserverutils::isgibbed(behaviortreeentity, 256) || gibserverutils::isgibbed(behaviortreeentity, 128);
}

function skeletonnotetrackmeleefire(animationentity) {
  hitent = animationentity melee();
  if(isDefined(hitent) && isDefined(animationentity.aux_melee_damage) && self.team != hitent.team) {
    animationentity[[animationentity.aux_melee_damage]](hitent);
  }
}

function is_within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

function skeletoncanseeplayer(player) {
  self endon("death");
  if(!isDefined(self.players_viscache)) {
    self.players_viscache = [];
  }
  entnum = player getentitynumber();
  if(!isDefined(self.players_viscache[entnum])) {
    self.players_viscache[entnum] = 0;
  }
  if(self.players_viscache[entnum] > gettime()) {
    return true;
  }
  zombie_eye = self.origin + vectorscale((0, 0, 1), 40);
  player_pos = player.origin + vectorscale((0, 0, 1), 40);
  distancesq = distancesquared(zombie_eye, player_pos);
  if(distancesq < 4096) {
    self.players_viscache[entnum] = gettime() + 3000;
    return true;
  }
  if(distancesq > 1048576) {
    return false;
  }
  if(is_within_fov(zombie_eye, self.angles, player_pos, cos(60))) {
    trace = groundtrace(zombie_eye, player_pos, 0, undefined);
    if(trace["fraction"] < 1) {
      return false;
    }
    self.players_viscache[entnum] = gettime() + 3000;
    return true;
  }
  return false;
}

function is_player_valid(player, checkignoremeflag, ignore_laststand_players) {
  if(!isDefined(player)) {
    return 0;
  }
  if(!isalive(player)) {
    return 0;
  }
  if(!isplayer(player)) {
    return 0;
  }
  if(isDefined(player.is_zombie) && player.is_zombie == 1) {
    return 0;
  }
  if(player.sessionstate == "spectator") {
    return 0;
  }
  if(player.sessionstate == "intermission") {
    return 0;
  }
  if(isDefined(self.intermission) && self.intermission) {
    return 0;
  }
  if(!(isDefined(ignore_laststand_players) && ignore_laststand_players)) {
    if(player laststand::player_is_in_laststand()) {
      return 0;
    }
  }
  if(isDefined(checkignoremeflag) && checkignoremeflag && player.ignoreme) {
    return 0;
  }
  if(isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](player);
  }
  return 1;
}

function get_closest_valid_player(origin, ignore_player) {
  valid_player_found = 0;
  players = getplayers();
  if(isDefined(ignore_player)) {
    for(i = 0; i < ignore_player.size; i++) {
      arrayremovevalue(players, ignore_player[i]);
    }
  }
  done = 0;
  while(players.size && !done) {
    done = 1;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(!is_player_valid(player, 1)) {
        arrayremovevalue(players, player);
        done = 0;
        break;
      }
    }
  }
  if(players.size == 0) {
    return undefined;
  }
  if(!valid_player_found) {
    for(;;) {
      player = [
        [self.closest_player_override]
      ](origin, players);
      player = [
        [level.closest_player_override]
      ](origin, players);
      player = arraygetclosest(origin, players);
      return undefined;
      arrayremovevalue(players, player);
      return undefined;
    }
    if(isDefined(self.closest_player_override)) {} else {
      if(isDefined(level.closest_player_override)) {} else {}
    }
    if(!isDefined(player) || players.size == 0) {}
    if(!is_player_valid(player, 1)) {
      if(players.size == 0) {}
    }
    return player;
  }
}

function skeletonsetgoal(goal) {
  if(isDefined(self.setgoaloverridecb)) {
    return [[self.setgoaloverridecb]](goal);
  }
  self setgoal(goal);
}

function skeletontargetservice(behaviortreeentity) {
  self endon("death");
  if(isDefined(behaviortreeentity.ignoreall) && behaviortreeentity.ignoreall) {
    return false;
  }
  if(isDefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.team == behaviortreeentity.team) {
    behaviortreeentity clearentitytarget();
  }
  if(behaviortreeentity.team == "allies") {
    if(isDefined(behaviortreeentity.favoriteenemy)) {
      behaviortreeentity skeletonsetgoal(behaviortreeentity.favoriteenemy.origin);
      return true;
    }
    if(isDefined(behaviortreeentity.enemy)) {
      behaviortreeentity skeletonsetgoal(behaviortreeentity.enemy.origin);
      return true;
    }
    target = getclosesttome(getaiteamarray("axis"));
    if(isDefined(target)) {
      behaviortreeentity skeletonsetgoal(target.origin);
      return true;
    }
    behaviortreeentity skeletonsetgoal(behaviortreeentity.origin);
    return false;
  }
  player = get_closest_valid_player(behaviortreeentity.origin, behaviortreeentity.ignore_player);
  if(!isDefined(player)) {
    if(isDefined(behaviortreeentity.ignore_player)) {
      if(isDefined(level._should_skip_ignore_player_logic) && [
          [level._should_skip_ignore_player_logic]
        ]()) {
        return;
      }
      behaviortreeentity.ignore_player = [];
    }
    behaviortreeentity skeletonsetgoal(behaviortreeentity.origin);
    return false;
  }
  if(isDefined(player.last_valid_position)) {
    cansee = self skeletoncanseeplayer(player);
    if(cansee) {
      behaviortreeentity skeletonsetgoal(player.last_valid_position);
      return true;
    }
    influencepos = undefined;
    if(isDefined(influencepos)) {
      if(distancesquared(influencepos, behaviortreeentity.origin) > 1024) {
        behaviortreeentity skeletonsetgoal(influencepos);
        return true;
      }
      behaviortreeentity clearpath();
      return false;
    }
    behaviortreeentity clearpath();
    return false;
  }
  behaviortreeentity skeletonsetgoal(behaviortreeentity.origin);
  return false;
}

function isvalidenemy(enemy) {
  if(!isDefined(enemy)) {
    return false;
  }
  return true;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function getyawtoenemy() {
  pos = undefined;
  if(isvalidenemy(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.angles);
    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function skeletonshouldmeleecondition(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  if(isDefined(behaviortreeentity.marked_for_death)) {
    return false;
  }
  if(isDefined(behaviortreeentity.stunned) && behaviortreeentity.stunned) {
    return false;
  }
  yaw = abs(getyawtoenemy());
  if(yaw > 45) {
    return false;
  }
  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 4096) {
    return true;
  }
  return false;
}

function skeletondeathaction(behaviortreeentity) {
  if(isDefined(behaviortreeentity.deathfunction)) {
    behaviortreeentity[[behaviortreeentity.deathfunction]]();
  }
}

function getclosestto(origin, entarray) {
  if(!isDefined(entarray)) {
    return;
  }
  if(entarray.size == 0) {
    return;
  }
  return arraygetclosest(origin, entarray);
}

function getclosesttome(entarray) {
  return getclosestto(self.origin, entarray);
}
/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\archetype_genesis_keeper_companion.gsc
*****************************************************/

#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\margwa;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\ai_squads;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\archetype_genesis_keeper_companion_interface;

class class_78f8bb8 {
  var var_2db009f1;
  var var_8e6eac66;
  var var_54c7425;

  constructor() {
    var_2db009f1 = gettime();
    var_8e6eac66 = 0;
    var_54c7425 = gettime();
  }

  destructor() {}

}

#namespace keepercompanionbehavior;

function autoexec main() {
  clientfield::register("allplayers", "being_keeper_revived", 15000, 1, "int");
  clientfield::register("actor", "keeper_reviving", 15000, 1, "int");
  clientfield::register("actor", "kc_effects", 15000, 1, "int");
  clientfield::register("world", "kc_callbox_lights", 15000, 2, "int");
  clientfield::register("actor", "keeper_thunderwall", 15000, 1, "counter");
  clientfield::register("actor", "keeper_ai_death_effect", 15000, 1, "int");
  clientfield::register("vehicle", "keeper_ai_death_effect", 15000, 1, "int");
  clientfield::register("scriptmover", "keeper_ai_spawn_tell", 15000, 1, "int");
  clientfield::register("scriptmover", "keeper_thunderwall_360", 15000, 1, "counter");
  initzombiebehaviorsandasm();
  spawner::add_archetype_spawn_function("keeper_companion", & function_8c4e826e);
  spawner::add_archetype_spawn_function("keeper_companion", & function_bd5d4573);
  keepercompanioninterface::function_e7b6b58c();
  registerbehaviorscriptfunctions();
}

function registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("keeperCompanionShouldmove", & keepercompanionshouldmove);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keeperCompanionDelayMovement", & keepercompaniondelaymovement);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keeperCompanionShouldTraverse", & keepercompanionshouldtraverse);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keeperCompanionKeepsUpdateMovementMode", & keepercompanionkeepsupdatemovementmode);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keeperUpdatethunderwallAttackParams", & keeperupdatethunderwallattackparams);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keeperCompanionUpdateLeader", & keepercompanionupdateleader);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keeperCompanionMovementService", & keepercompanionmovementservice);
}

function private initzombiebehaviorsandasm() {
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_out_traversal@keeper_companion", & function_3ff0b3e, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_in_traversal@keeper_companion", & function_f1efe0ab, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_keeper_companion_idle@keeper_companion", & function_7cf81f38, & function_7cf81f38, & function_7cf81f38);
  animationstatenetwork::registeranimationmocomp("mocomp_keeper_tactical_walk@keeper_companion", & function_8c2af335, & function_8c2af335, & function_8d3c82f6);
  animationstatenetwork::registernotetrackhandlerfunction("thunder", & function_7cbb0165);
  animationstatenetwork::registernotetrackhandlerfunction("attack_left", & function_c6326468);
  animationstatenetwork::registernotetrackhandlerfunction("attack_right", & function_ec3b8737);
  animationstatenetwork::registernotetrackhandlerfunction("attack_up", & function_86b6a4a8);
  animationstatenetwork::registernotetrackhandlerfunction("keeper_teleport_out", & function_cd4d7e12);
  animationstatenetwork::registernotetrackhandlerfunction("keeper_teleport_in", & function_d938ace7);
  animationstatenetwork::registernotetrackhandlerfunction("keeper_spawn_in", & function_10c1bf1);
  animationstatenetwork::registernotetrackhandlerfunction("keeper_spawn_out", & function_26729028);
}

function function_3ff0b3e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("normal", 0);
  entity setrepairpaths(0);
  entity.blockingpain = 1;
  entity.usegoalanimweight = 1;
  entity.var_63288fb8 = entity.traverseendnode;
}

function function_f1efe0ab(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.var_63288fb8)) {
    print3d(entity.origin, "", (1, 0, 0), 1, 1, 60);
    print3d(entity.var_63288fb8.origin, "", (0, 1, 0), 1, 1, 60);
    line(entity.origin, entity.var_63288fb8.origin, (0, 1, 0), 1, 0, 60);
    var_99523a0 = entity.var_63288fb8.origin - entity.origin;
    var_6aa21bd5 = vectortoangles(var_99523a0);
    entity forceteleport(entity.var_63288fb8.origin, (0, var_6aa21bd5[1], 0), 0);
  }
  entity finishtraversal();
  entity setrepairpaths(1);
  entity.blockingpain = 0;
  entity.usegoalanimweight = 0;
}

function function_7cf81f38(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("normal", 0);
  if(isDefined(self.reviving_a_player) && self.reviving_a_player && (isDefined(self.var_1a5b8ffb) && self.var_1a5b8ffb)) {
    entity orientmode("face direction", vectornormalize(self.var_b46b4189.origin - entity.origin));
  } else {
    if(isDefined(entity.var_92aa697) && entity.var_92aa697 && isDefined(entity.var_8cf1ff79)) {
      entity orientmode("face direction", vectornormalize(entity.var_8cf1ff79 - entity.origin));
    } else {
      if(isDefined(entity.leader)) {
        entity orientmode("face direction", vectornormalize(entity.leader.origin - entity.origin));
      } else {
        entity orientmode("face angle", entity.angles[1]);
      }
    }
  }
}

function function_8c2af335(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("normal", 0);
  entity orientmode("face motion");
  if(isDefined(self.reviving_a_player) && self.reviving_a_player && (isDefined(self.var_1a5b8ffb) && self.var_1a5b8ffb)) {
    entity orientmode("face direction", vectornormalize(self.var_b46b4189.origin - entity.origin));
  } else {
    if(isDefined(entity.var_92aa697) && entity.var_92aa697 && isDefined(entity.var_8cf1ff79)) {
      entity orientmode("face direction", vectornormalize(entity.var_8cf1ff79 - entity.origin));
    } else {
      if(isDefined(entity.leader)) {
        entity orientmode("face direction", vectornormalize(entity.leader.origin - entity.origin));
      } else {
        entity orientmode("face angle", entity.angles[1]);
      }
    }
  }
  if(!entity.manualtraversemode && isDefined(entity.traversalstartdist) && entity.traversalstartdist >= 0) {
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity animmode("pre_traversal", 0);
    entity orientmode("face current");
  }
}

function function_8d3c82f6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.blockingpain = 0;
  entity.usegoalanimweight = 0;
}

function function_cd4d7e12(entity) {
  entity clientfield::set("kc_effects", 0);
  entity ghost();
}

function function_d938ace7(entity) {
  entity clientfield::set("kc_effects", 1);
  entity show();
}

function function_10c1bf1(entity) {
  entity clientfield::set("kc_effects", 1);
  entity show();
}

function function_26729028(entity) {
  entity clientfield::set("kc_effects", 0);
  entity ghost();
  entity thread function_8a22bf01(entity);
}

function function_8a22bf01(entity) {
  entity endon("death");
  util::wait_network_frame();
  entity.var_2c553c41 delete();
  entity delete();
}

function private function_8c4e826e() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self aiutility::registerutilityblackboardattributes();
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_keeper_protector_attack", "inactive", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self finalizetrackedblackboardattributes();
}

function private function_bd5d4573() {
  self.fullhealth = self.health;
  self.highlyawareradius = 350;
  self.reviving_a_player = 0;
  self.companion_anchor_point = self.origin;
  self.next_move_time = gettime();
  self.allow_zombie_to_target_ai = 1;
  self.ignoreme = 1;
  self.fovcosine = 0;
  self.fovcosinebusy = self.fovcosine;
  self.maxvisibledist = 900;
  self.goalradius = 16;
  self setavoidancemask("avoid none");
  self notsolid();
  self ghost();
  self.var_fb400bf7 = [];
  self.var_fb400bf7[0] = "double_points";
  self.var_fb400bf7[1] = "fire_sale";
  self.var_fb400bf7[2] = "insta_kill";
  self.var_fb400bf7[3] = "nuke";
  self.var_fb400bf7[4] = "full_ammo";
  self.var_fb400bf7[5] = "insta_kill_ug";
  self.var_3e807a19 = gettime();
  self.var_733ed347 = gettime();
  self thread function_98f178fc(self);
  self.var_2c553c41 = spawn("script_model", self.origin);
  self.var_2c553c41 setModel("tag_origin");
  self.var_2c553c41 notsolid();
  self.var_2c553c41 linkto(self, "tag_origin", (0, 0, 0), vectorscale((-1, 0, 0), 90));
  self thread function_5250c5dd();
}

function private function_98f178fc(entity) {
  entity endon("death");
  while(true) {
    recordcircle(entity.origin, 700, (1, 0, 0), "", entity);
    if(isDefined(entity.var_8cf1ff79)) {
      recordline(entity.origin, entity.var_8cf1ff79, (0, 0, 1), "", entity);
      recordsphere(entity.var_8cf1ff79, 8, (0, 0, 1), "", entity);
    }
    wait(0.05);
  }
}

function private keepercompaniondelaymovement(entity) {
  entity pathmode("move delayed", 0, randomfloatrange(1, 2));
}

function private _isvalidplayer(player) {
  if(!isDefined(player) || !isalive(player) || !isplayer(player) || player.sessionstate == "spectator" || player.sessionstate == "intermission" || player laststand::player_is_in_laststand() || player.ignoreme) {
    return false;
  }
  return true;
}

function keepercompanionshouldtraverse(entity) {
  if(isDefined(entity.traversestartnode)) {
    return true;
  }
  return false;
}

function private keepercompanionshouldmove(entity) {
  if(!entity haspath()) {
    return false;
  }
  return true;
}

function private function_469c9511(entity) {
  entity endon("death");
  entity endon("outro");
  if(isDefined(entity.forcefire) && entity.forcefire) {
    return;
  }
  entity.var_539a912c = gettime() + 2500;
  entity.var_f1e0aeaf = 1;
  wait(3);
  if(!isDefined(entity) || !isDefined(entity.leader)) {
    entity.var_f1e0aeaf = 0;
    return;
  }
  position = entity.leader.origin;
  queryresult = positionquery_source_navigation(entity.leader.origin, 96, 256, 48, 20, entity);
  if(queryresult.data.size) {
    result = queryresult.data[randomint(queryresult.data.size)];
    position = result.origin;
  }
  angles = vectortoangles(position - entity.leader.origin);
  entity teleport_to_location(position, angles);
  entity.var_f1e0aeaf = 0;
}

function private keepercompanionmovementservice(entity) {
  if(isDefined(level.var_bfd9ed83) && (isDefined(level.var_bfd9ed83.eligible_leader) && level.var_bfd9ed83.eligible_leader)) {
    entity.leader = level.var_bfd9ed83;
  }
  if(isDefined(entity.outro) && entity.outro) {
    return;
  }
  if(entity.var_2fd11bbd === 1) {
    return;
  }
  if(!isDefined(entity.var_57e708f6)) {
    entity.var_57e708f6 = 0;
  }
  if(entity.reviving_a_player === 1) {
    return;
  }
  if(entity.var_53ce2a4e === 1 || entity.b_teleporting === 1) {
    return;
  }
  if(entity.var_c0e8df41 === 1) {
    return;
  }
  if(entity.var_f1e0aeaf === 1) {
    return;
  }
  if(isDefined(entity.leader)) {
    if(isDefined(entity.leader.b_teleporting === 1) && entity.leader.b_teleporting === 1) {
      entity thread function_34117adf(entity.leader.teleport_location);
      return;
    }
    if(entity.leader.is_flung === 1) {
      if(isDefined(entity.leader.var_fa1ecd39)) {
        entity thread function_3463b8c2(entity.leader.var_fa1ecd39);
      }
      return;
    }
    if(distancesquared(entity.leader.origin, entity.origin) > 490000) {
      if(!isDefined(entity.var_539a912c) || gettime() > entity.var_539a912c) {
        entity thread function_469c9511(entity);
      }
    }
  }
  foreach(player in level.players) {
    if(player laststand::player_is_in_laststand() && entity.reviving_a_player === 0 && player.revivetrigger.beingrevived !== 1) {
      time = gettime();
      if(distancesquared(entity.origin, player.origin) <= (1024 * 1024) && time >= entity.var_57e708f6) {
        entity.reviving_a_player = 1;
        entity function_95adf61c(player);
        return;
      }
    }
  }
  if(!isDefined(entity.var_a0c5deb2)) {
    entity.var_a0c5deb2 = gettime();
  }
  if(gettime() >= entity.var_a0c5deb2 && isDefined(level.active_powerups) && level.active_powerups.size > 0) {
    if(!isDefined(entity.var_34a9f1ad)) {
      entity.var_34a9f1ad = 0;
    }
    foreach(powerup in level.active_powerups) {
      if(isinarray(entity.var_fb400bf7, powerup.powerup_name)) {
        dist = distancesquared(entity.origin, powerup.origin);
        if(dist <= 147456 && randomint(100) < (50 + (10 * entity.var_34a9f1ad))) {
          entity setgoal(powerup.origin, 1);
          entity.var_a0c5deb2 = gettime() + randomintrange(2500, 3500);
          entity.next_move_time = gettime() + randomintrange(2500, 3500);
          entity.var_34a9f1ad = 0;
          return;
        }
        entity.var_34a9f1ad = entity.var_34a9f1ad + 1;
      }
    }
    entity.var_a0c5deb2 = gettime() + randomintrange(333, 666);
  }
  follow_radius_squared = 256 * 256;
  if(isDefined(entity.leader)) {
    entity.companion_anchor_point = entity.leader.origin;
  }
  dist_check_start_point = entity.origin;
  if(isDefined(entity.pathgoalpos)) {
    dist_check_start_point = entity.pathgoalpos;
  }
  if(distancesquared(dist_check_start_point, entity.companion_anchor_point) > follow_radius_squared) {
    if(isDefined(entity.leader) && entity.companion_anchor_point == entity.leader.origin) {
      enemies = getaiteamarray(level.zombie_team);
      validenemies = [];
      foreach(enemy in enemies) {
        if(isDefined(enemy.completed_emerging_into_playable_area) && enemy.completed_emerging_into_playable_area && entity cansee(entity.leader, 3000) && util::within_fov(entity.leader.origin, entity.leader.angles, enemy.origin, cos(70))) {
          validenemies[validenemies.size] = enemy;
        }
      }
      if(isDefined(validenemies) && validenemies.size) {
        averagepoint = get_average_origin(validenemies, entity.leader.origin[2]);
        var_be4a51b9 = vectornormalize(averagepoint - entity.leader.origin);
        point = entity.leader.origin + vectorscale(var_be4a51b9, 179.2);
        entity.companion_anchor_point = point + vectorscale(anglestoright(entity.leader.angles), 30);
      }
    }
    entity pick_new_movement_point();
  }
  if(gettime() >= entity.next_move_time && (!(isDefined(entity.var_92aa697) && entity.var_92aa697))) {
    entity pick_new_movement_point();
  }
}

function private get_average_origin(entities, var_d4653ed3) {
  assert(isarray(entities));
  assert(entities.size > 0);
  var_8a6850c7 = 0;
  var_6465d65e = 0;
  for(i = 0; i < entities.size; i++) {
    var_8a6850c7 = var_8a6850c7 + entities[i].origin[0];
    var_6465d65e = var_6465d65e + entities[i].origin[1];
  }
  return (var_8a6850c7 / entities.size, var_6465d65e / entities.size, var_d4653ed3);
}

function private function_34117adf(var_5935e1b9) {
  self endon("death");
  self.var_53ce2a4e = 1;
  self setgoal(var_5935e1b9, 1);
  self waittill("goal");
  wait(1);
  self.var_53ce2a4e = 0;
}

function private teleport_to_location(position, angles) {
  self endon("death");
  self endon("outro");
  self notify("teleport_to_location");
  self endon("teleport_to_location");
  self.var_641791df = 1;
  self clearpath();
  self pathmode("dont move");
  self scene::play("cin_zm_dlc4_keeper_prtctr_teleport_out", self);
  self forceteleport(position, angles);
  self scene::play("cin_zm_dlc4_keeper_prtctr_teleport_in", self);
  self pathmode("move allowed");
  self setgoal(position);
  self.var_641791df = 0;
}

function private function_3463b8c2(var_ee6ad78e) {
  self endon("death");
  self endon("outro");
  self.var_c0e8df41 = 1;
  var_c9277d64 = getnodearray("flinger_traversal", "script_noteworthy");
  var_292fba5b = arraygetclosest(var_ee6ad78e, var_c9277d64);
  var_577ef8dd = getnode(var_292fba5b.target, "targetname");
  self teleport_to_location(var_577ef8dd.origin, var_577ef8dd.angles);
  while(!isDefined(self.leader) || !isalive(self.leader) || (isDefined(self.leader.is_flung) && self.leader.is_flung)) {
    self setgoal(var_577ef8dd.origin);
    wait(0.05);
  }
  self.var_c0e8df41 = 0;
}

function private pick_new_movement_point() {
  queryresult = positionquery_source_navigation(self.companion_anchor_point, 96, 256, 48, 20, self);
  if(queryresult.data.size) {
    if(isDefined(self.enemy) && self.enemy.archetype == "parasite") {
      array::filter(queryresult.data, 0, & function_ab299a53, self.enemy);
    }
  }
  if(queryresult.data.size) {
    point = queryresult.data[randomint(queryresult.data.size)];
    pathsuccess = self findpath(self.origin, point.origin, 1, 0);
    if(pathsuccess) {
      self.companion_destination = point.origin;
    } else {
      self.next_move_time = gettime() + randomintrange(500, 1500);
      return;
    }
  }
  if(isDefined(self.companion_destination)) {
    self setgoal(self.companion_destination, 1);
  }
  self.next_move_time = gettime() + randomintrange(6000, 9000);
}

function private function_ab299a53(parasite) {
  point = self;
  height_difference = abs(point.origin[2] - parasite.origin[2]);
  var_3b804002 = (1.5 * height_difference) * (1.5 * height_difference);
  return distancesquared(point.origin, parasite.origin) > var_3b804002;
}

function function_95adf61c(player) {
  self endon("outro");
  self endon("revive_terminated");
  self endon("end_game");
  player endon("end_game");
  if(!(isDefined(self.reviving_a_player) && self.reviving_a_player)) {
    self.reviving_a_player = 1;
  }
  player.var_c35d3027 = 0;
  self thread function_f95febaf(player);
  queryresult = positionquery_source_navigation(player.origin, 64, 96, 48, 18, self);
  if(queryresult.data.size) {
    point = queryresult.data[randomint(queryresult.data.size)];
    self.companion_destination = point.origin;
  } else {
    self.companion_destination = player.origin;
  }
  if(distancesquared(self.companion_destination, self.origin) <= (450 * 450)) {
    self forceteleport(self.origin, self.angles, 1);
    wait(0.05);
    self setgoal(self.companion_destination, 1);
    self waittill("goal");
    self.var_1a5b8ffb = 1;
    self.var_b46b4189 = player;
    wait(2);
  } else {
    angles = vectortoangles(player.origin - self.companion_destination);
    self teleport_to_location(self.companion_destination, angles);
  }
  level.var_46040f3e = 1;
  player.revivetrigger.beingrevived = 1;
  player.var_c35d3027 = 1;
  self scene::play("cin_zm_dlc4_keeper_prtctr_revive_intro", self);
  player clientfield::set("being_keeper_revived", 1);
  self clientfield::set("keeper_reviving", 1);
  self scene::play("cin_zm_dlc4_keeper_prtctr_revive_loop", self);
  self clientfield::set("keeper_reviving", 0);
  self scene::play("cin_zm_dlc4_keeper_prtctr_revive_outtro", self);
  if(level.players.size == 1 && level flag::get("solo_game")) {
    self.var_57e708f6 = gettime() + 8000;
  } else {
    self.var_57e708f6 = gettime() + 5000;
  }
  if(player laststand::player_is_in_laststand()) {
    player notify("stop_revive_trigger");
    if(isplayer(player)) {
      player allowjump(1);
    }
    player.laststand = undefined;
    player thread zm_laststand::revive_success(self, 0);
  }
  level.var_46040f3e = 0;
  players = getplayers();
  if(players.size == 1 && level flag::get("solo_game") && (isDefined(player.waiting_to_revive) && player.waiting_to_revive)) {
    level.solo_game_free_player_quickrevive = 1;
    player thread zm_perks::give_perk("specialty_quickrevive", 0);
  }
  self function_703fda6d(player);
}

function function_f95febaf(player) {
  self endon("revive_terminated");
  while(true) {
    if(isDefined(player.revivetrigger) && player.revivetrigger.beingrevived === 1 && player.var_c35d3027 !== 1) {
      self function_703fda6d(player);
    }
    if(!(isDefined(player laststand::player_is_in_laststand()) && player laststand::player_is_in_laststand())) {
      self function_703fda6d(player);
    }
    wait(0.05);
  }
}

function function_703fda6d(player) {
  self.reviving_a_player = 0;
  self.var_1a5b8ffb = 0;
  self.var_b46b4189 = undefined;
  if(!isDefined(player)) {
    foreach(player in level.players) {
      player.var_c35d3027 = 0;
      player clientfield::set("being_keeper_revived", 0);
    }
  } else if(player.var_c35d3027 == 1) {
    player.var_c35d3027 = 0;
    player clientfield::set("being_keeper_revived", 0);
  }
  self notify("revive_terminated");
}

function private keepercompanionkeepsupdatemovementmode(entity) {
  var_ef42515b = 90000;
  var_1be8672c = 90000;
  dist = distancesquared(entity.origin, entity.companion_anchor_point);
  if(dist >= var_ef42515b) {
    blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
  } else {
    blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_walk");
  }
}

function private function_36af0313(entity, var_109b8552) {
  entity endon("death");
  entity notify("hash_36af0313");
  entity endon("hash_36af0313");
  entity.var_92aa697 = 1;
  while(true) {
    if(!isDefined(entity.var_8cf1ff79)) {
      break;
    } else if(!util::within_fov(entity.origin, entity.angles, entity.var_8cf1ff79, cos(70))) {
      wait(0.1);
      continue;
    }
    entity.holdfire = 0;
    entity.forcefire = 1;
    blackboard::setblackboardattribute(entity, "_keeper_protector_attack", "active");
    var_aef04392 = undefined;
    if(var_109b8552 == "single") {
      if(math::cointoss()) {
        blackboard::setblackboardattribute(entity, "_keeper_protector_attack_type", "left");
        var_aef04392 = getanimlength("ai_zm_dlc4_keeper_prtctr_idle_attack_left");
      } else {
        blackboard::setblackboardattribute(entity, "_keeper_protector_attack_type", "right");
        var_aef04392 = getanimlength("ai_zm_dlc4_keeper_prtctr_idle_attack_right");
      }
    } else {
      blackboard::setblackboardattribute(entity, "_keeper_protector_attack_type", "combo");
      var_aef04392 = getanimlength("ai_zm_dlc4_keeper_prtctr_idle_attack_combo");
    }
    if(isDefined(level.var_c3eaadba) && level.var_c3eaadba) {
      blackboard::setblackboardattribute(entity, "", "");
      var_aef04392 = getanimlength("");
    }
    entity.var_285f7306 = gettime() + (var_aef04392 * 1000);
    recordenttext("", self, (0, 1, 0), "");
    wait(var_aef04392);
    recordenttext("", self, (0, 1, 0), "");
    blackboard::setblackboardattribute(entity, "_keeper_protector_attack", "inactive");
    entity.var_92aa697 = 0;
    break;
  }
}

function private function_5d2ab113(entity) {
  recordenttext("", self, (1, 0, 0), "");
  blackboard::setblackboardattribute(entity, "_keeper_protector_attack", "inactive");
  entity.var_92aa697 = 0;
  entity.holdfire = 1;
  entity.forcefire = 0;
}

function private function_87727b5b(entity) {
  enemies = getaiarray();
  validenemies = [];
  foreach(enemy in enemies) {
    if(enemy.team != entity.team && (entity cansee(enemy) || distancesquared(entity.origin, enemy.origin) <= (350 * 350))) {
      if(enemy.archetype === "zombie" && (!(isDefined(enemy.completed_emerging_into_playable_area) && enemy.completed_emerging_into_playable_area))) {
        continue;
      }
      if(enemy ishidden()) {
        continue;
      }
      if(!isalive(enemy)) {
        continue;
      }
      if(isDefined(enemy.isteleporting) && enemy.isteleporting) {
        continue;
      }
      validenemies[validenemies.size] = enemy;
    }
  }
  foreach(enemy in validenemies) {
    recordline(entity.origin, enemy.origin, (0, 1, 0), "", entity);
  }
  return validenemies;
}

function private keeperupdatethunderwallattackparams(entity) {
  var_9540bf56 = 1;
  if(isDefined(entity.var_92aa697) && entity.var_92aa697) {
    if(isDefined(entity.var_285f7306)) {
      var_9540bf56 = gettime() >= entity.var_285f7306;
    }
  }
  if(isDefined(self.var_641791df) && self.var_641791df) {
    return;
  }
  var_a943c5d0 = 0;
  validenemies = [];
  var_a59136fc = [];
  validenemies = function_87727b5b(entity);
  closestenemy = arraygetclosest(entity.origin, validenemies, 700);
  if(!isDefined(closestenemy)) {
    entity.var_8cf1ff79 = undefined;
  } else {
    var_a59136fc = array::get_all_closest(closestenemy.origin, validenemies, undefined, undefined, 700);
    if(!isDefined(var_a59136fc) || !var_a59136fc.size) {
      entity.var_8cf1ff79 = undefined;
    } else {
      if(gettime() >= entity.var_3e807a19) {
        if(var_a59136fc.size) {
          entity.var_8cf1ff79 = get_average_origin(var_a59136fc, entity.origin[2]);
          var_a943c5d0 = 1;
        }
      } else {
        entity.var_8cf1ff79 = get_average_origin(var_a59136fc, entity.origin[2]);
      }
    }
  }
  if(!var_9540bf56) {
    return;
  }
  if(!var_a943c5d0) {
    function_5d2ab113(entity);
  } else if(var_a943c5d0 && (!(isDefined(entity.var_92aa697) && entity.var_92aa697)) && isDefined(entity.var_8cf1ff79)) {
    if(var_a59136fc.size <= 3 && distancesquared(entity.var_8cf1ff79, entity.origin) < (500 * 500)) {
      if(randomint(100) < 10) {
        var_109b8552 = "combo";
        cooldowntime = entity.var_733ed347;
      } else {
        var_109b8552 = "single";
        cooldowntime = entity.var_3e807a19;
      }
    } else {
      if(var_a59136fc.size >= 3) {
        var_109b8552 = "combo";
        cooldowntime = entity.var_733ed347;
      } else {
        return false;
      }
    }
    if(gettime() >= cooldowntime) {
      function_36af0313(entity, var_109b8552);
    }
  }
  return false;
}

function private keepercompanionupdateleader(entity) {
  if(!entity.reviving_a_player) {
    if(!isDefined(entity.leader) || (!(isDefined(entity.leader.eligible_leader) && entity.leader.eligible_leader))) {
      entity define_new_leader();
    }
  }
}

function private define_new_leader() {
  if(isDefined(level.var_bfd9ed83) && (isDefined(level.var_bfd9ed83.eligible_leader) && level.var_bfd9ed83.eligible_leader)) {
    self.leader = level.var_bfd9ed83;
  } else {
    a_potential_leaders = get_potential_leaders(self);
    closest_leader = undefined;
    closest_distance = 1000000;
    if(a_potential_leaders.size == 0) {
      self.leader = undefined;
    } else {
      foreach(potential_leader in a_potential_leaders) {
        dist = pathdistance(self.origin, potential_leader.origin);
        if(isDefined(dist) && dist < closest_distance) {
          closest_distance = dist;
          self.leader = potential_leader;
        }
      }
    }
  }
}

function private get_potential_leaders(companion) {
  a_potential_leaders = [];
  foreach(player in level.players) {
    if(!isDefined(player.eligible_leader)) {
      player.eligible_leader = 1;
    }
    if(isDefined(player.eligible_leader) && player.eligible_leader && companion findpath(companion.origin, player.origin)) {
      a_potential_leaders[a_potential_leaders.size] = player;
    }
  }
  return a_potential_leaders;
}

function function_7cbb0165(entity) {}

function function_c6326468(entity) {
  function_68cd1247(entity, "attack_left");
}

function function_ec3b8737(entity) {
  function_68cd1247(entity, "attack_right");
}

function function_86b6a4a8(entity) {
  function_68cd1247(entity, "attack_up");
}

function function_68cd1247(entity, var_e54db1ed) {
  var_4fd6352b = entity gettagorigin("tag_weapon_right");
  entity thread function_cd2f0f8a(entity, var_4fd6352b, var_e54db1ed);
  if(var_e54db1ed == "attack_up") {
    entity.var_2c553c41 clientfield::increment("keeper_thunderwall_360");
    entity.var_733ed347 = randomintrange(1200, 2100);
    entity.var_733ed347 = gettime() + entity.var_733ed347;
  } else {
    entity clientfield::increment("keeper_thunderwall");
    entity.var_3e807a19 = randomintrange(1200, 2100);
    entity.var_3e807a19 = gettime() + entity.var_3e807a19;
  }
}

function private function_5c472d67(entity, var_4fd6352b, var_e54db1ed) {
  var_9b627b75 = blackboard::getblackboardattribute(self, "_keeper_protector_attack_type");
  var_9357f4f4 = 500;
  if(var_9b627b75 == "combo") {
    var_9357f4f4 = 250;
  }
  var_13bc5a88 = 700 * 700;
  if(var_e54db1ed == "attack_left" || var_e54db1ed == "attack_right") {
    zombies = array::get_all_closest(var_4fd6352b, getaiteamarray(level.zombie_team), undefined, int(5), var_9357f4f4);
    var_13bc5a88 = var_9357f4f4 * var_9357f4f4;
  } else {
    zombies = array::get_all_closest(var_4fd6352b, getaiteamarray(level.zombie_team), undefined, 15, 300);
    var_13bc5a88 = 300 * 300;
  }
  if(!isDefined(zombies)) {
    return;
  }
  if(!zombies.size) {
    return;
  }
  fov = cos(70);
  if(var_e54db1ed == "attack_left" || var_e54db1ed == "attack_right") {
    fov = cos(60);
  }
  entity.var_13833827 = [];
  foreach(zombie in zombies) {
    if(!isDefined(zombie) || !isalive(zombie)) {
      continue;
    }
    if(var_e54db1ed != "attack_up") {
      tooclose = distancesquared(var_4fd6352b, zombie.origin) <= (64 * 64);
      if(!tooclose && !util::within_fov(var_4fd6352b, entity.angles, zombie.origin, fov)) {
        continue;
      }
    }
    var_ce2c8115 = distancesquared(var_4fd6352b, zombie getcentroid());
    level.var_fb631584[level.var_fb631584.size] = zombie;
    var_e3b3d13c = (var_13bc5a88 - var_ce2c8115) / var_13bc5a88;
    if(var_e54db1ed == "attack_up") {
      var_94f0027d = vectornormalize(zombie.origin - (entity.origin + vectorscale((0, 0, 1), 200)));
    } else {
      var_94f0027d = vectornormalize(zombie.origin - entity.origin);
    }
    var_94f0027d = (var_94f0027d[0], var_94f0027d[1], abs(var_94f0027d[2]));
    var_94f0027d = vectorscale(var_94f0027d, 75 + (75 * var_e3b3d13c));
    level.var_90c9a476[level.var_90c9a476.size] = var_94f0027d;
  }
}

function private function_84e1787e(entity, ai) {
  if(!isDefined(ai.var_78f8bb8)) {
    ai.var_78f8bb8 = new class_78f8bb8();
  }
  assert(isDefined(ai.var_78f8bb8));
  if(gettime() > ai.var_78f8bb8.var_2db009f1) {
    ai.var_78f8bb8.var_8e6eac66 = ai.var_78f8bb8.var_8e6eac66 + 100;
    ai.var_78f8bb8.var_2db009f1 = gettime() + randomintrange(2500, 3500);
  }
  if(ai.var_78f8bb8.var_8e6eac66 >= 200) {
    return true;
  }
  return false;
}

function private function_e620963b(entity, ai, var_4fd6352b, var_94f0027d, var_e54db1ed) {
  if(!isDefined(ai) || !isalive(ai)) {
    return;
  }
  if(ai.archetype == "margwa") {
    if(function_84e1787e(entity, ai)) {
      if(isDefined(ai.thundergun_fling_func)) {
        ai thread[[ai.thundergun_fling_func]](entity);
      }
    } else {
      assert(isDefined(ai.var_78f8bb8));
      if(isDefined(ai.canstun) && ai.canstun && gettime() >= ai.var_78f8bb8.var_54c7425) {
        ai.reactstun = 1;
        ai.var_78f8bb8.var_54c7425 = gettime() + randomintrange(3000, 5000);
      }
    }
  } else {
    if(ai.archetype == "mechz") {
      if(function_84e1787e(entity, ai)) {
        if(isDefined(ai.thundergun_fling_func)) {
          ai thread[[ai.thundergun_fling_func]](entity);
        }
      } else {
        assert(isDefined(ai.var_78f8bb8));
        if(isDefined(ai.canstun) && ai.canstun && gettime() >= ai.var_78f8bb8.var_54c7425) {
          ai.reactstun = 1;
          ai.var_78f8bb8.var_54c7425 = gettime() + randomintrange(3000, 5000);
        }
      }
    } else {
      if(var_e54db1ed == "attack_up") {
        ai dodamage(20000, var_4fd6352b, entity);
      } else {
        ai dodamage(17000, var_4fd6352b, entity);
      }
    }
  }
  if(!isalive(ai)) {
    ai clientfield::set("keeper_ai_death_effect", 1);
    level notify("hash_1fe79fb5", ai);
    if(isDefined(entity.leader.var_71148446) && isinarray(entity.leader.var_71148446, self.archetype)) {
      arrayremovevalue(entity.leader.var_71148446, ai.archetype);
      entity.leader notify("hash_af442f7c");
    }
    foreach(player in level.players) {
      if(player laststand::player_is_in_laststand()) {
        player notify("hash_935cc366");
      }
    }
    if(ai.archetype === "zombie") {
      if(randomint(100) < 30) {
        ai zombie_utility::gib_random_parts();
      }
      ai startragdoll();
      ai launchragdoll(var_94f0027d);
    }
  }
}

function private function_cd2f0f8a(entity, var_4fd6352b, var_e54db1ed) {
  if(!isDefined(level.var_fb631584)) {
    level.var_fb631584 = [];
    level.var_90c9a476 = [];
  }
  entity function_5c472d67(entity, var_4fd6352b, var_e54db1ed);
  for(i = 0; i < level.var_fb631584.size; i++) {
    ai = level.var_fb631584[i];
    ai thread function_e620963b(entity, ai, var_4fd6352b, level.var_90c9a476[i], var_e54db1ed);
    wait(0.05);
  }
  level.var_fb631584 = [];
  level.var_90c9a476 = [];
}

function private function_5250c5dd() {
  level waittill("intermission");
  wait(5.25);
  self.allowdeath = 1;
  self kill();
}
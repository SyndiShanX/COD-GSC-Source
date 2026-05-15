/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_ancestor\_alien_ancestor_melee.gsc
*************************************************************************/

main() {
  self endon("killanimscript");
  self endon("death");
  var_0 = gettime();
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);

  if(self.melee_type != "death" && self.is_moving) {
    self.is_moving = 0;
    var_1 = self.origin + anglesToForward(self.angles) * 500;
    maps\mp\agents\alien\alien_ancestor\_alien_ancestor_move::playstopanimation(var_1, 0);
  }

  switch (self.melee_type) {
    case "blast":
      blast_attack();
      break;
    case "forced_blast":
      forced_blast_attack();
      break;
    case "forced_grab":
      forced_grab_attack();
      break;
    case "grab":
      grab_attack();
      break;
    case "spawn":
      spawn_aliens();
      break;
    case "death":
      death();
      break;
    default:
      break;
  }

  if(var_0 == gettime()) {
    wait 0.05;
  }

  self notify("melee_complete");
}

endscript() {
  if(self.grab_target_disabled) {
    handle_post_grab_targets();
  }
}

forced_blast_attack() {
  if(!isDefined(self.forced_blast_position)) {
    return;
  }
  var_0 = self.forced_blast_position - self.origin;
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_0);
  maps\mp\agents\alien\alien_ancestor\_alien_ancestor::handleshieldstateforattack("blast");
  self.looktarget = undefined;
  maps\mp\alien\_utility::set_alien_emissive(0.2, 1.0);
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetanimmode("anim deltas");
  play_blast_anim();
  self.forced_blast_position = undefined;
}

blast_attack() {
  var_0 = self.blast_target;
  var_0 endon("death");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);

  if(isalive(var_0)) {
    maps\mp\agents\alien\alien_ancestor\_alien_ancestor::handleshieldstateforattack("blast");
    self.looktarget = var_0;
    maps\mp\alien\_utility::set_alien_emissive(0.2, 1.0);
    self scragentsetorientmode("face enemy");
    self scragentsetanimmode("anim deltas");
    play_blast_anim();
  }

  maps\mp\alien\_utility::set_alien_emissive_default(0.2);
  self.looktarget = undefined;
  self.blast_target = undefined;
  self.blast_target_location = undefined;
}

play_blast_anim() {
  self.blast_anim_index = randomint(self getanimentrycount("attack_blast"));
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_blast", self.blast_anim_index, "attack_melee", "end", ::handleattacknotetracks);
  self.last_blast_time = gettime();
}

fire_blast_projectile() {
  if(!isDefined(self.blast_target)) {
    return;
  }
  if(!isDefined(self.blast_target.usingremote)) {
    var_0 = self.blast_target getEye();
  } else {
    var_0 = self.blast_target.origin + (0, 0, 32);
  }

  var_1 = get_blast_fire_pos(var_0);
  var_2 = magicbullet("alien_ancestor_mp", var_1, var_0, self);
  var_2.owner = self;

  if(!isDefined(self.blast_target.usingremote)) {
    var_3 = self.blast_target getEye() - self.blast_target.origin;
  } else {
    var_3 = (0, 0, 32);
  }

  var_2 missile_settargetent(self.blast_target, var_3);
  var_2 missile_setflightmodedirect();

  if(isDefined(var_2)) {
    var_2 thread blast_tracking_monitor(self);
    var_2 thread blast_projectile_proximity_monitor(self);
    var_2 thread blast_projectile_impact_monitor(self);
  }
}

fire_forced_blast_projectile() {
  if(!isDefined(self.forced_blast_position)) {
    return;
  }
  var_0 = get_blast_fire_pos(self.forced_blast_position);
  var_1 = magicbullet("alien_ancestor_mp", var_0, self.forced_blast_position, self);
  var_1.owner = self;

  if(isDefined(var_1)) {
    var_1 thread blast_projectile_impact_monitor(self);
  }
}

blast_tracking_monitor(var_0) {
  self endon("explode");
  var_1 = var_0.blast_target;
  var_1 endon("death");
  var_2 = 16384;
  var_3 = gettime();

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_1) && distancesquared(self.origin, var_1.origin) < var_2) {
      break;
    }

    if(gettime() - var_3 > 2000) {
      var_4 = anglesToForward(self.angles);

      foreach(var_6 in level.players) {
        if(var_6 == var_1 || !isalive(var_6)) {
          continue;
        }
        if(distancesquared(self.origin, var_6.origin) > 160000) {
          continue;
        }
        var_7 = vectornormalize(var_6.origin - self.origin);

        if(vectordot(var_4, var_7) > 0.5) {
          var_1 = var_6;

          if(!isDefined(var_1.usingremote)) {
            var_8 = var_1 getEye() - var_1.origin;
          } else {
            var_8 = (0, 0, 32);
          }

          self missile_settargetent(var_1, var_8);
          var_3 = gettime();
        }
      }
    }

    if(!isDefined(var_1)) {
      break;
    }

    wait 0.05;
  }

  self missile_cleartarget();
}

blast_projectile_impact_monitor(var_0) {
  self waittill("explode", var_1);

  if(!isDefined(var_1)) {
    return;
  }
  playFX(level._effect["blackhole_exp"], var_1);
  playsoundatpos(var_1, "anc_orb_imp");
}

blast_projectile_proximity_monitor(var_0) {
  self endon("death");
  var_1 = 10000;
  var_2 = 90;
  var_3 = 40;
  var_4 = 256;
  var_5 = undefined;

  for(;;) {
    foreach(var_7 in level.players) {
      if(!isDefined(self)) {
        return;
      }
      var_8 = distancesquared(self.origin, var_7.origin);

      if(var_8 < var_1) {
        if(!isDefined(var_5)) {
          var_5 = var_8;
        }

        if(var_5 < var_8) {
          self notify("explode", self.origin);
          common_scripts\utility::waitframe();
          var_9 = var_2;
          var_10 = var_3;
          radiusdamage(self.origin, var_4, var_9, var_10, var_0, "MOD_EXPLOSIVE", "alien_ancestor_mp");
          common_scripts\utility::waitframe();
          self delete();
          return;
        } else
          var_5 = var_8;
      }
    }

    wait 0.05;
  }
}

get_blast_fire_pos(var_0) {
  if(self.blast_anim_index == 0) {
    var_1 = "TAG_WEAPON_RIGHT";
  } else {
    var_1 = "TAG_WEAPON_LEFT";
  }

  return self gettagorigin(var_1);
}

forced_grab_attack() {
  level endon("game_ended");

  if(!isDefined(self.forced_grab_position)) {
    return;
  }
  var_0 = self.forced_grab_position - self.origin;
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_0);
  var_1 = "attack_grab";
  var_2 = "attack_melee";
  var_3 = "end";
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_1, 0, var_2, var_3);
  play_variable_grab_anim(var_1, 1, 0.2);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_1, 2, var_2, var_3);
  self notify("forced_grab_damage_start");
  play_variable_grab_anim(var_1, 3, 3);
  self notify("forced_grab_damage_end");
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_1, 4, var_2, var_3);
  self.forced_grab_position = undefined;
}

play_variable_grab_anim(var_0, var_1, var_2) {
  var_3 = self getanimentry("attack_grab", var_1);
  var_4 = getanimlength(var_3);
  self setanimstate(var_0, var_1);
  var_5 = min(var_4, var_2);
  wait(var_5);
}

grab_attack() {
  level endon("game_ended");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(self.grab_target);
  thread monitor_grab_status();
  self scragentsetorientmode("face enemy");
  self scragentsetanimmode("anim deltas");
  self.grab_status = 0;
  activate_grab_zones();
  play_initial_grab_anims();

  if(is_grab_active()) {
    self.grab_status = 2;
  }

  while(is_grab_active()) {
    wait 0.05;
  }

  if(self.grab_status == 3) {
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_grab", 4, "attack_melee", "end", ::handleattacknotetracks);
  } else if(self.grab_status == 4) {
    handle_post_grab_targets();
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_grab", 5, "attack_melee", "end");
  }

  self.last_grab_time = gettime();
}

play_initial_grab_anims() {
  self endon("grab_finished");
  var_0 = "attack_grab";
  var_1 = "attack_melee";
  var_2 = "end";
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, 0, var_1, var_2);
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\alien\alien_ancestor\_alien_ancestor::handleshieldstateforattack("grab");
  play_variable_grab_anim(var_0, 1, 0.9);
  self.current_grab_victims = get_player_victims();

  if(self.current_grab_victims.size > 0) {
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, 2, var_1, var_2, ::handleattacknotetracks);
  } else {
    self.grab_status = 6;
    self notify("grab_finished");
  }
}

get_player_victims() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2 isusingturret() || maps\mp\alien\_utility::is_true(var_2.is_using_remote_turret)) {
      continue;
    }
    if(maps\mp\alien\_utility::is_true(var_2.is_grabbed)) {
      continue;
    }
    foreach(var_4 in self.grab_damage_zone_locations) {
      if(distancesquared(var_4, var_2.origin) < 15625) {
        var_0[var_0.size] = var_2;
      }
    }
  }

  return var_0;
}

activate_grab_zones() {
  var_0 = get_possible_grab_victims(self.grab_target);
  self.grab_damage_zone_locations = [];

  foreach(var_2 in var_0) {
    thread play_choke_ring_fx(var_2);
    self.grab_damage_zone_locations[self.grab_damage_zone_locations.size] = var_2.origin;
  }
}

is_grab_active() {
  return self.grab_status == 0 || self.grab_status == 1 || self.grab_status == 2;
}

start_grab() {
  if(self.current_grab_victims.size > 0) {
    self.grab_status = 1;
    do_grab_attack(self.current_grab_victims);
  }
}

get_possible_grab_victims(var_0) {
  var_1 = 0.5;
  var_2 = 589824;
  var_3 = anglesToForward(self.angles);
  var_4 = [];
  var_5 = gettime();

  foreach(var_7 in level.players) {
    if(var_7.inlaststand) {
      continue;
    }
    if(var_7.ignoreme) {
      continue;
    }
    if(var_7 isusingturret() || maps\mp\alien\_utility::is_true(var_7.is_using_remote_turret)) {
      continue;
    }
    if(maps\mp\alien\_utility::is_true(var_7.is_grabbed)) {
      continue;
    }
    if(isDefined(var_7.next_valid_grab_time) && var_7.next_valid_grab_time > var_5) {
      continue;
    }
    var_8 = vectornormalize(var_7.origin - self.origin);

    if(vectordot(var_3, var_8) > var_1) {
      if(distancesquared(var_7.origin, self.origin) < var_2) {
        if(bullettracepassed(self gettagorigin("TAG_EYE"), var_7 gettagorigin("TAG_EYE"), 0, self.shield)) {
          var_4[var_4.size] = var_7;
        }
      }
    }
  }

  return var_4;
}

play_choke_ring_fx(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("ancestor_destroyed");
  self endon("grab_finished");
  wait 0.9;
  playsoundatpos(var_0.origin, "anc_choke_ring");
  var_1 = spawnfx(level._effect["ancestor_choke_ring"], var_0.origin);

  for(;;) {
    triggerfx(var_1);
    wait 0.5;
  }
}

monitor_grab_status() {
  self endon("grab_finished");
  var_0 = 600;

  if(level.players.size == 4) {
    var_0 = 900;
  } else if(level.players.size == 3) {
    var_0 = 800;
  } else if(level.players.size == 2) {
    var_0 = 700;
  } else if(level.players.size == 1) {
    var_0 = 600;
  }

  var_1 = self.health - var_0;

  for(;;) {
    var_2 = common_scripts\utility::waittill_any_return("damage", "death", "ancestor_destroyed");

    if(var_2 == "death" || var_2 == "ancestor_destroyed") {
      self.grab_status = 5;
      break;
    } else if(self.health < var_1) {
      self.grab_status = 4;
      break;
    }
  }

  self notify("grab_finished");
}

grab_timeout_monitor() {
  self endon("grab_finished");
  wait 4;
  self.grab_status = 3;
  self notify("grab_finished");
}

do_grab_attack(var_0) {
  self endon("grab_finished");
  level endon("game_ended");
  level endon("host_migration_begin");
  level endon("host_migration_end");
  self.grab_lift_entities = [];
  thread grab_timeout_monitor();

  foreach(var_2 in var_0) {
    setup_grab_target(var_2);
    childthread process_grab_target(var_2);
  }

  while(self.grab_status == 0 || self.grab_status == 1) {
    wait 0.05;
  }

  for(;;) {
    maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("attack_grab", 3, "attack_melee", "end");
  }
}

setup_grab_target(var_0) {
  var_0 notify("force_cancel_placement");
  var_0 notify("dpad_cancel");
  self.grab_target_disabled = 1;
  var_0 disableusability();
  var_0 freezecontrols(1);
  var_0 disableweapons();
  var_0.turn_off_class_skill_activation = 1;
  var_0.player_action_disabled = 1;
  var_0.next_valid_grab_time = gettime() + 100000;
  var_0.is_grabbed = 1;
  var_0 notify("grabbed");
  var_0 playlocalsound("anc_choke");
  level notify("dlc_vo_notify", "ancestor_close");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  self.grab_lift_entities[self.grab_lift_entities.size] = var_1;
  thread lift_grab_player(var_1, var_0);
  thread grab_detect_migration(self);
}

lift_grab_player(var_0, var_1) {
  self endon("death");
  self endon("ancestor_destroyed");
  self endon("killanimscript");
  var_2 = 100;
  var_3 = 1.0;
  var_4 = var_0.origin;
  var_5 = var_0.origin + (0, 0, var_2);
  var_6 = 0.2;
  var_7 = playerphysicstrace(var_4, var_5);
  playfxontagforclients(level._effect["ancestor_choke_pv"], var_1, "tag_origin", var_1);
  playFXOnTag(level._effect["ancestor_choke_3pv"], var_1, "tag_origin");
  var_1 thread grab_detect_stuck();
  var_1 thread grab_detect_migration(self);
  var_8 = (self getEye() - var_7) * (1, 1, 0);
  var_0.angles = vectortoangles(var_8);
  var_0.origin = var_7;
  var_1 playerlinktoblend(var_0);
  var_1 _meth_842D();
  var_9 = 72;
  var_10 = 32;

  if(capsuletracepassed(var_0.origin, var_10, var_9)) {
    var_0 scriptmodelplayanimdeltamotion("alien_ancestor_player_attack_grab");
  }
}

process_grab_target(var_0) {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  var_1 = 18.75;

  for(;;) {
    wait 1.0;

    if(!isDefined(var_0) || !isDefined(self) || !isalive(self)) {
      return;
    }
    var_0 dodamage(var_1, self.origin, self, self);
  }
}

handle_post_grab_targets() {
  level endon("game_ended");

  if(level.gameended) {
    return;
  }
  var_0 = -400;

  foreach(var_2 in self.current_grab_victims) {
    if(!isalive(var_2)) {
      continue;
    }
    var_2.turn_off_class_skill_activation = undefined;
    var_2.player_action_disabled = undefined;

    if(!maps\mp\alien\_utility::is_true(var_2.iscarrying)) {
      var_2 enableweapons();
    }

    var_2 freezecontrols(0);

    if(!isDefined(var_2.inlaststand) || !var_2.inlaststand) {
      var_2 enableusability();
    }

    var_2 unlink();
    var_2.is_grabbed = 0;
    var_2 notify("grab_finished");
    var_2.next_valid_grab_time = gettime() + 5000;

    if(isDefined(var_2.imslist)) {
      foreach(var_4 in var_2.imslist) {
        if(isDefined(var_4.carriedby) && var_4.carriedby == var_2) {
          var_4 delete();
        }
      }
    }

    if(self.grab_status == 3) {
      var_6 = anglesToForward(var_2.angles) * var_0;
      var_2 setvelocity(var_6);
    }
  }

  foreach(var_9 in self.grab_lift_entities) {
    if(isDefined(var_9)) {
      var_9 delete();
    }
  }

  self.grab_target_disabled = 0;
  self.grab_lift_entities = [];
  self.current_grab_victims = [];
}

grab_detect_stuck() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 = self.origin;
  var_1 = 0;
  var_2 = common_scripts\utility::waittill_any_return("unresolved_collision", "grab_finished");

  if(var_2 == "unresolved_collision") {
    var_1 = 1;
  } else if(var_2 == "grab_finished") {
    var_3 = self.origin;
    wait 0.5;

    if(self.origin == var_3) {
      var_1 = 1;
    }
  }

  wait 0.1;

  if(var_1) {
    self setorigin(var_0);
  }
}

grab_detect_migration(var_0) {
  self endon("grab_finished");
  level waittill("host_migration_end");
  wait 1.0;
  var_0 handle_post_grab_targets();
}

spawn_aliens() {
  self.num_spawns = get_default_ancestor_spawns();

  if(!ancestor_spawn_find_spawn_loc()) {
    self.spawn_locations[self.spawn_locations.size] = self.origin;
  }

  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("spawn_alien", 0, "spawn_alien", "end", ::handleattacknotetracks);

  foreach(var_1 in self.minions) {
    if(isalive(var_1)) {
      var_1 thread set_minion_stationary(self.enemy);
    }
  }

  thread watch_for_death_during_spawn();
  var_3 = undefined;

  if(isDefined(self.enemy)) {
    var_3 = get_direct_minions_anim_index();
  }

  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("direct_minions", var_3, "direct_minions", "end", ::handleattacknotetracks);
  self.last_spawn_time = gettime();
}

get_direct_minions_anim_index() {
  var_0 = 0.906;
  var_1 = 0.5;
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = vectornormalize(self.enemy.origin - self.origin);
  var_5 = vectordot(var_2, var_4);

  if(var_5 < var_1) {
    maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(self.enemy);
    return 1;
  }

  if(var_5 > var_0) {
    return 1;
  }

  if(vectordot(var_3, var_4) > 0.0) {
    return 2;
  }

  return 0;
}

watch_for_death_during_spawn() {
  self endon("minion_released");
  common_scripts\utility::waittill_any("death", "ancestor_destroyed");
  release_minions();
}

release_minions() {
  foreach(var_1 in self.minions) {
    var_1 notify("minion_released");
  }

  self notify("minion_released");
}

set_minion_stationary(var_0) {
  self endon("death");

  while(self.trajectoryactive || isDefined(self.alien_scripted) && self.alien_scripted) {
    wait 0.05;
  }

  self scragentsetscripted(1);
  maps\mp\alien\_utility::enable_alien_scripted();
  thread maps\mp\agents\alien\_alien_idle::main();
  var_1 = 10;
  thread minion_player_proximity_monitor();
  var_2 = common_scripts\utility::waittill_any_timeout(var_1, "damage", "minion_released", "player_proximity");
  self notify("minion_activated");
  set_minion_enemy(var_0);
}

minion_player_proximity_monitor() {
  self endon("minion_activated");
  self endon("death");
  var_0 = 90000;

  for(;;) {
    wait 0.2;

    foreach(var_2 in level.players) {
      if(!isalive(var_2)) {
        continue;
      }
      if(var_2.inlaststand) {
        continue;
      }
      if(distancesquared(var_2.origin, self.origin) < var_0) {
        self notify("player_proximity");
        return;
      }
    }
  }
}

set_minion_enemy(var_0) {
  self endon("death");
  var_1 = 10;
  self.favoriteenemy = var_0;
  self scragentsetscripted(0);
  maps\mp\alien\_utility::disable_alien_scripted();

  if(isalive(var_0)) {
    var_0 common_scripts\utility::waittill_any_timeout(var_1, "death");
  } else {
    wait(var_1);
  }

  self.favoriteenemy = undefined;
}

get_default_ancestor_spawns() {
  switch (level.players.size) {
    case 1:
      return 2;
    case 2:
      return 2;
    case 3:
      return 3;
    case 4:
      return 3;
  }
}

ancestor_spawn_find_spawn_loc() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  self.spawn_locations = [];
  var_2 = self.origin + var_0 * 56.0;
  var_2 = maps\mp\agents\_scriptedagents::droppostoground(var_2);

  if(isDefined(var_2) && maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin, var_2, 12.0)) {
    self.spawn_locations[self.spawn_locations.size] = var_2;
  }

  var_3 = self.origin + var_1 * 56.0;
  var_3 = maps\mp\agents\_scriptedagents::droppostoground(var_3);

  if(isDefined(var_3) && maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin, var_3, 12.0)) {
    self.spawn_locations[self.spawn_locations.size] = var_3;
  }

  var_4 = self.origin + var_1 * -56.0;
  var_4 = maps\mp\agents\_scriptedagents::droppostoground(var_4);

  if(isDefined(var_4) && maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin, var_4, 12.0)) {
    self.spawn_locations[self.spawn_locations.size] = var_4;
  }

  if(self.spawn_locations.size > 0) {
    return 1;
  }

  return 0;
}

release_reserved_space_on_death() {
  self notify("reserved_space_death_monitor");
  self endon("reserved_space_death_monitor");
  common_scripts\utility::waittill_any("death", "ancestor_destroyed");
  empty_reserved_space();
}

empty_reserved_space() {
  if(isDefined(self.reserved_space) && self.reserved_space > 0) {
    maps\mp\alien\_spawn_director::release_custom_spawn_space(self.reserved_space);
    self.reserved_space = 0;
  }
}

do_ancestor_spawns() {
  self endon("death");
  self endon("ancestor_destroyed");
  thread release_reserved_space_on_death();
  self.minions = [];
  var_0 = spawn_of_type(self.num_spawns, "brute");
  var_1 = self.num_spawns - var_0;

  if(var_1 > 0) {
    spawn_of_type(var_1, "goon");
  }
}

spawn_of_type(var_0, var_1) {
  var_2 = int(maps\mp\alien\_spawn_director::reserve_custom_spawn_space(var_0, 1, var_1));

  for(self.reserved_space = var_2; self.reserved_space > 0; self.minions = common_scripts\utility::array_combine(self.minions, do_spawn(var_3, self.spawn_locations, var_1))) {
    var_3 = min(self.reserved_space, self.spawn_locations.size);
  }

  return var_2;
}

do_spawn(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.angles = self.angles;
  var_4 = level.cycle_data.spawn_node_info["chen_test"].vignetteinfo[var_2];
  var_5 = (0, 0, -100);
  var_6 = [];

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_8 = var_7 % var_1.size;
    var_3.origin = var_1[var_8] + var_5;
    var_9 = maps\mp\alien\_spawn_director::process_custom_spawn(var_2, var_3, var_4);

    if(isDefined(var_9)) {
      var_6[var_6.size] = var_9;
    }

    self.reserved_space--;
    wait(randomfloatrange(0.01, 0.14));
  }

  return var_6;
}

handleattacknotetracks(var_0, var_1, var_2, var_3) {
  if(isDefined(level.dlc_attacknotetrack_override_func)) {
    self[[level.dlc_attacknotetrack_override_func]](var_0, var_1, var_2, var_3);
    return;
  }

  switch (var_0) {
    case "ball_projectile_start":
      if(isDefined(self.forced_blast_position)) {
        fire_forced_blast_projectile();
      } else {
        fire_blast_projectile();
      }

      break;
    case "throw_player":
      handle_post_grab_targets();
      break;
    case "summon":
      do_ancestor_spawns();
      break;
    case "grab_player":
      thread start_grab();
      break;
    case "attack_direct":
      release_minions();
      break;
    default:
      break;
  }
}

death() {
  maps\mp\agents\alien\alien_ancestor\_alien_ancestor::playdeath();
}
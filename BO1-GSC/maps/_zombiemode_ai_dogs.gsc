/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_ai_dogs.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_net;
#include maps\_music;

init() {
  level.dogs_enabled = true;
  level.dog_rounds_enabled = false;
  level.dog_round_count = 1;
  level.enemy_dog_spawns = [];
  level.enemy_dog_locations = [];
  flag_init("dog_round");
  flag_init("dog_clips");
  PreCacheRumble("explosion_generic");
  if(getDvar(#"zombie_dog_animset") == "") {
    SetDvar("zombie_dog_animset", "zombie");
  }
  if(getDvar(#"scr_dog_health_walk_multiplier") == "") {
    SetDvar("scr_dog_health_walk_multiplier", "4.0");
  }
  if(getDvar(#"scr_dog_run_distance") == "") {
    SetDvar("scr_dog_run_distance", "500");
  }
  level.melee_range_sav = getDvar(#"ai_meleeRange");
  level.melee_height_sav = getDvar(#"ai_meleeWidth");
  level.melee_width_sav = getDvar(#"ai_meleeHeight");
  SetSavedDvar("dog_MeleeDamage", "100");
  set_zombie_var("dog_fire_trail_percent", 50);
  level._effect["lightning_dog_spawn"] = Loadfx("maps/zombie/fx_zombie_dog_lightning_buildup");
  level._effect["dog_eye_glow"] = Loadfx("maps/zombie/fx_zombie_dog_eyes");
  level._effect["dog_gib"] = Loadfx("maps/zombie/fx_zombie_dog_explosion");
  level._effect["dog_trail_fire"] = Loadfx("maps/zombie/fx_zombie_dog_fire_trail");
  level._effect["dog_trail_ash"] = Loadfx("maps/zombie/fx_zombie_dog_ash_trail");
  animscripts\zombie_dog_init::initDogAnimations();
  dog_spawner_init();
  level thread dog_clip_monitor();
}

enable_dog_rounds() {
  level.dog_rounds_enabled = true;
  if(!isDefined(level.dog_round_track_override)) {
    level.dog_round_track_override = ::dog_round_tracker;
  }
  level thread[[level.dog_round_track_override]]();
}

dog_spawner_init() {
  dogs = getEntArray("zombie_dog_spawner", "script_noteworthy");
  later_dogs = getEntArray("later_round_dog_spawners", "script_noteworthy");
  dogs = array_combine(dogs, later_dogs);
  if(dogs.size == 0) {
    return;
  }
  for(i = 0; i < dogs.size; i++) {
    if(maps\_zombiemode_spawner::is_spawner_targeted_by_blocker(dogs[i])) {
      dogs[i].is_enabled = false;
    } else {
      dogs[i].is_enabled = true;
    }
  }
  assert(dogs.size > 0);
  level.dog_health = 100;
  array_thread(dogs, ::add_spawn_function, ::dog_init);
  level.enemy_dog_spawns = getEntArray("zombie_spawner_dog_init", "targetname");
}

dog_round_spawning() {
  level endon("intermission");
  level.dog_targets = getplayers();
  for(i = 0; i < level.dog_targets.size; i++) {
    level.dog_targets[i].hunted_by = 0;
  }
  if(level.intermission) {
    return;
  }
  level.dog_intermission = true;
  level thread dog_round_aftermath();
  players = get_players();
  array_thread(players, ::play_dog_round);
  wait(7);
  if(level.dog_round_count < 3) {
    max = players.size * 6;
  } else {
    max = players.size * 8;
  }
  level.zombie_total = max;
  dog_health_increase();
  count = 0;
  while(count < max) {
    num_player_valid = get_number_of_valid_players();
    while(get_enemy_count() >= num_player_valid * 2) {
      wait(2);
      num_player_valid = get_number_of_valid_players();
    }
    players = get_players();
    favorite_enemy = get_favorite_enemy();
    if(isDefined(level.dog_spawn_func)) {
      spawn_loc = [[level.dog_spawn_func]](level.enemy_dog_spawns, favorite_enemy);
      ai = spawn_zombie(level.enemy_dog_spawns[0]);
      if(isDefined(ai)) {
        ai.favoriteenemy = favorite_enemy;
        spawn_loc thread dog_spawn_fx(ai, spawn_loc);
        level.zombie_total--;
        count++;
      }
    } else {
      spawn_point = dog_spawn_sumpf_logic(level.enemy_dog_spawns, favorite_enemy);
      ai = spawn_zombie(spawn_point);
      if(isDefined(ai)) {
        ai.favoriteenemy = favorite_enemy;
        spawn_point thread dog_spawn_fx(ai);
        level.zombie_total--;
        count++;
      }
    }
    waiting_for_next_dog_spawn(count, max);
  }
}

waiting_for_next_dog_spawn(count, max) {
  default_wait = 1.5;
  if(level.dog_round_count == 1) {
    default_wait = 3;
  } else if(level.dog_round_count == 2) {
    default_wait = 2.5;
  } else if(level.dog_round_count == 3) {
    default_wait = 2;
  } else {
    default_wait = 1.5;
  }
  default_wait = default_wait - (count / max);
  wait(default_wait);
}

dog_round_aftermath() {
  level waittill("last_dog_down");
  level thread maps\_zombiemode_audio::change_zombie_music("dog_end");
  power_up_origin = level.last_dog_origin;
  if(isDefined(power_up_origin)) {
    level thread maps\_zombiemode_powerups::specific_powerup_drop("full_ammo", power_up_origin);
  }
  wait(2);
  clientnotify("dog_stop");
  wait(6);
  level.dog_intermission = false;
}

dog_spawn_fx(ai, ent) {
  if(!isDefined(ent)) {
    ent = GetStruct(self.target, "targetname");
  }
  if(isDefined(ent)) {
    playFX(level._effect["lightning_dog_spawn"], ent.origin);
    playsoundatposition("zmb_hellhound_prespawn", ent.origin);
    wait(1.5);
    playsoundatposition("zmb_hellhound_bolt", ent.origin);
    Earthquake(0.5, 0.75, ent.origin, 1000);
    PlayRumbleOnPosition("explosion_generic", ent.origin);
    playsoundatposition("zmb_hellhound_spawn", ent.origin);
    angle = VectorToAngles(ai.favoriteenemy.origin - ent.origin);
    angles = (ai.angles[0], angle[1], ai.angles[2]);
    ai ForceTeleport(ent.origin, angles);
  }
  assertex(isDefined(ai), "Ent isn't defined.");
  assertex(IsAlive(ai), "Ent is dead.");
  assertex(ai.isdog, "Ent isn't a dog;");
  assertex(is_magic_bullet_shield_enabled(ai), "Ent doesn't have a magic bullet shield.");
  ai zombie_setup_attack_properties_dog();
  ai stop_magic_bullet_shield();
  wait(0.1);
  ai show();
  ai.ignoreme = false;
  ai notify("visible");
}

dog_spawn_sumpf_logic(dog_array, favorite_enemy) {
  assertex(dog_array.size > 0, "Dog Spawner array is empty.");
  dog_array = array_randomize(dog_array);
  for(i = 0; i < dog_array.size; i++) {
    if(isDefined(level.old_dog_spawn) && level.old_dog_spawn == dog_array[i]) {
      continue;
    }
    if(distanceSquared(dog_array[i].origin, favorite_enemy.origin) > (400 * 400) && distanceSquared(dog_array[i].origin, favorite_enemy.origin) < (800 * 800)) {
      if(distanceSquared((0, 0, dog_array[i].origin[2]), (0, 0, favorite_enemy.origin[2])) > 100 * 100) {
        continue;
      } else {
        level.old_dog_spawn = dog_array[i];
        return dog_array[i];
      }
    }
  }
  return dog_array[0];
}

dog_spawn_factory_logic(dog_array, favorite_enemy) {
  dog_locs = array_randomize(level.enemy_dog_locations);
  for(i = 0; i < dog_locs.size; i++) {
    if(isDefined(level.old_dog_spawn) && level.old_dog_spawn == dog_locs[i]) {
      continue;
    }
    dist_squared = distanceSquared(dog_locs[i].origin, favorite_enemy.origin);
    if(dist_squared > (400 * 400) && dist_squared < (1000 * 1000)) {
      level.old_dog_spawn = dog_locs[i];
      return dog_locs[i];
    }
  }
  return dog_locs[0];
}

get_favorite_enemy() {
  dog_targets = getplayers();
  least_hunted = dog_targets[0];
  for(i = 0; i < dog_targets.size; i++) {
    if(!isDefined(dog_targets[i].hunted_by)) {
      dog_targets[i].hunted_by = 0;
    }
    if(!is_player_valid(dog_targets[i])) {
      continue;
    }
    if(!is_player_valid(least_hunted)) {
      least_hunted = dog_targets[i];
    }
    if(dog_targets[i].hunted_by < least_hunted.hunted_by) {
      least_hunted = dog_targets[i];
    }
  }
  least_hunted.hunted_by += 1;
  return least_hunted;
}

dog_health_increase() {
  players = getplayers();
  if(level.dog_round_count == 1) {
    level.dog_health = 400;
  } else if(level.dog_round_count == 2) {
    level.dog_health = 900;
  } else if(level.dog_round_count == 3) {
    level.dog_health = 1300;
  } else if(level.dog_round_count == 4) {
    level.dog_health = 1600;
  }
  if(level.dog_health > 1600) {
    level.dog_health = 1600;
  }
}

dog_round_tracker() {
  level.dog_round_count = 1;
  level.next_dog_round = randomintrange(5, 8);
  old_spawn_func = level.round_spawn_func;
  old_wait_func = level.round_wait_func;
  while(1) {
    level waittill("between_round_over");
    if(level.round_number == level.next_dog_round) {
      level.music_round_override = true;
      old_spawn_func = level.round_spawn_func;
      old_wait_func = level.round_wait_func;
      dog_round_start();
      level.round_spawn_func = ::dog_round_spawning;
      level.next_dog_round = level.round_number + randomintrange(4, 6);
    } else if(flag("dog_round")) {
      dog_round_stop();
      level.round_spawn_func = old_spawn_func;
      level.round_wait_func = old_wait_func;
      level.music_round_override = false;
      level.dog_round_count += 1;
    }
  }
}

dog_round_start() {
  flag_set("dog_round");
  flag_set("dog_clips");
  level thread maps\_zombiemode_audio::change_zombie_music("dog_start");
  if(!isDefined(level.doground_nomusic)) {
    level.doground_nomusic = 0;
  }
  level.doground_nomusic = 1;
  level notify("dog_round_starting");
  clientnotify("dog_start");
  level.melee_range_sav = 100;
  level.melee_height_sav = 0;
  level.melee_width_sav = 0;
  if(isDefined(level.dog_melee_range)) {
    SetDvar("ai_meleeRange", level.dog_melee_range);
  } else {
    SetDvar("ai_meleeRange", "100");
  }
  SetDvar("ai_meleeWidth", "0");
  SetDvar("ai_meleeHeight", "0");
}

dog_round_stop() {
  flag_clear("dog_round");
  flag_clear("dog_clips");
  if(!isDefined(level.doground_nomusic)) {
    level.doground_nomusic = 0;
  }
  level.doground_nomusic = 0;
  level notify("dog_round_ending");
  clientnotify("dog_stop");
  SetDvar("ai_meleeRange", level.melee_range_sav);
  SetDvar("ai_meleeWidth", level.melee_width_sav);
  SetDvar("ai_meleeHeight", level.melee_height_sav);
}

play_dog_round() {
  self playlocalsound("zmb_dog_round_start");
  variation_count = 5;
  wait(1);
  play_sound_2D("zmb_vox_ann_dogstart");
  wait(3.5);
  players = getplayers();
  num = randomintrange(0, players.size);
  players[num] maps\_zombiemode_audio::create_and_play_dialog("general", "dog_spawn");
}

dog_init() {
  self.targetname = "zombie_dog";
  self.script_noteworthy = undefined;
  self.animname = "zombie_dog";
  self.ignoreall = true;
  self.ignoreme = true;
  self.allowdeath = true;
  self.allowpain = false;
  self.force_gib = true;
  self.is_zombie = true;
  self.has_legs = true;
  self.gibbed = false;
  self.head_gibbed = false;
  if(!isDefined(level.zombietron)) {
    self.default_goalheight = 40;
  }
  animscripts\zombie_dog_init::change_anim_set(getDvar(#"zombie_dog_animset"));
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoreSuppression = true;
  self.suppressionThreshold = 1;
  self.noDodgeMove = true;
  self.dontShootWhileMoving = true;
  self.pathenemylookahead = 0;
  self.badplaceawareness = 0;
  self.chatInitialized = false;
  self setTeamForEntity("axis");
  health_multiplier = 1.0;
  if(getDvar(#"scr_dog_health_walk_multiplier") != "") {
    health_multiplier = GetDvarFloat(#"scr_dog_health_walk_multiplier");
  }
  self.maxhealth = int(level.dog_health * health_multiplier);
  self.health = int(level.dog_health * health_multiplier);
  self.freezegun_damage = 0;
  self.zombie_move_speed = "sprint";
  self thread dog_run_think();
  self thread dog_stalk_audio();
  self thread maps\_zombiemode::round_spawn_failsafe();
  self hide();
  self thread magic_bullet_shield();
  self dog_fx_eye_glow();
  self dog_fx_trail();
  self thread dog_death();
  self.a.disablePain = true;
  self disable_react();
  self ClearEnemy();
  self ClearGoalVolume();
  self.flame_damage_time = 0;
  self.meleeDamage = 40;
  self.thundergun_disintegrate_func = ::dog_thundergun_disintegrate;
  self.thundergun_knockdown_func = ::dog_thundergun_knockdown;
  self maps\_zombiemode_spawner::zombie_history("zombie_dog_spawn_init -> Spawned = " + self.origin);
  if(isDefined(level.achievement_monitor_func)) {
    self[[level.achievement_monitor_func]]();
  }
}

dog_fx_eye_glow() {
  self.fx_dog_eye = spawn("script_model", self GetTagOrigin("J_EyeBall_LE"));
  assert(isDefined(self.fx_dog_eye));
  self.fx_dog_eye.angles = self GetTagAngles("J_EyeBall_LE");
  self.fx_dog_eye setModel("tag_origin");
  self.fx_dog_eye LinkTo(self, "J_EyeBall_LE");
}

dog_fx_trail() {
  if(!is_mature() || randomInt(100) > level.zombie_vars["dog_fire_trail_percent"]) {
    self.fx_dog_trail_type = level._effect["dog_trail_ash"];
    self.fx_dog_trail_sound = "zmb_hellhound_loop_breath";
  } else {
    self.a.nodeath = true;
    self.fx_dog_trail_type = level._effect["dog_trail_fire"];
    self.fx_dog_trail_sound = "zmb_hellhound_loop_fire";
  }
  self.fx_dog_trail = spawn("script_model", self GetTagOrigin("tag_origin"));
  assert(isDefined(self.fx_dog_trail));
  self.fx_dog_trail.angles = self GetTagAngles("tag_origin");
  self.fx_dog_trail setModel("tag_origin");
  self.fx_dog_trail LinkTo(self, "tag_origin");
}

dog_death() {
  self waittill("death");
  if(get_enemy_count() == 0 && level.zombie_total == 0) {
    level.last_dog_origin = self.origin;
    level notify("last_dog_down");
  }
  if(IsPlayer(self.attacker)) {
    event = "death";
    if(issubstr(self.damageweapon, "knife_ballistic_")) {
      event = "ballistic_knife_death";
    }
    self.attacker maps\_zombiemode_score::player_add_points(event, self.damagemod, self.damagelocation, true);
    if(RandomIntRange(0, 100) >= 80) {
      self.attacker maps\_zombiemode_audio::create_and_play_dialog("kill", "hellhound");
    }
  }
  if(isDefined(self.attacker) && isai(self.attacker)) {
    self.attacker notify("killed", self);
  }
  self stopLoopSound();
  assert(isDefined(self.fx_dog_eye));
  self.fx_dog_eye delete();
  assert(isDefined(self.fx_dog_trail));
  self.fx_dog_trail delete();
  if(isDefined(self.a.nodeath)) {
    level thread dog_explode_fx(self.origin);
    self delete();
  } else {
    self playSound("zmb_hellhound_vocals_death");
  }
}

dog_explode_fx(origin) {
  fx = network_safe_spawn("dog_death_fx", 2, "script_model", origin);
  assert(isDefined(fx));
  fx setModel("tag_origin");
  playFXOnTag(level._effect["dog_gib"], fx, "tag_origin");
  fx playSound("zmb_hellhound_explode");
  wait(5);
  fx delete();
}

zombie_setup_attack_properties_dog() {
  self maps\_zombiemode_spawner::zombie_history("zombie_setup_attack_properties()");
  self thread dog_behind_audio();
  self.ignoreall = false;
  self.pathEnemyFightDist = 64;
  self.meleeAttackDist = 64;
  self.disableArrivals = true;
  self.disableExits = true;
}

stop_dog_sound_on_death() {
  self waittill("death");
  self stopsounds();
}

dog_behind_audio() {
  self thread stop_dog_sound_on_death();
  self endon("death");
  self waittill_any("dog_running", "dog_combat");
  self playSound("zmb_hellhound_vocals_close", "sounddone");
  self waittill("sounddone");
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      dogAngle = AngleClamp180(vectorToAngles(self.origin - players[i].origin)[1] - players[i].angles[1]);
      if(isAlive(players[i]) && !isDefined(players[i].revivetrigger)) {
        if((abs(dogAngle) > 90) && distance2d(self.origin, players[i].origin) > 100) {
          self playSound("zmb_hellhound_vocals_close", "sounddone");
          self waittill("sounddone");
        }
      }
    }
    wait(.75);
  }
}

dog_clip_monitor() {
  clips_on = false;
  level.dog_clips = getEntArray("dog_clips", "targetname");
  while(1) {
    for(i = 0; i < level.dog_clips.size; i++) {
      level.dog_clips[i] trigger_off();
      level.dog_clips[i] ConnectPaths();
    }
    flag_wait("dog_clips");
    if(isDefined(level.no_dog_clip) && level.no_dog_clip == true) {
      return;
    }
    for(i = 0; i < level.dog_clips.size; i++) {
      level.dog_clips[i] trigger_on();
      level.dog_clips[i] DisconnectPaths();
      wait_network_frame();
    }
    dog_is_alive = true;
    while(dog_is_alive || flag("dog_round")) {
      dog_is_alive = false;
      dogs = getEntArray("zombie_dog", "targetname");
      for(i = 0; i < dogs.size; i++) {
        if(IsAlive(dogs[i])) {
          dog_is_alive = true;
        }
      }
      wait(1);
    }
    flag_clear("dog_clips");
    wait(1);
  }
}

special_dog_spawn(spawners, num_to_spawn) {
  dogs = GetAISpeciesArray("all", "zombie_dog");
  if(isDefined(dogs) && dogs.size >= 9) {
    return false;
  }
  if(!isDefined(num_to_spawn)) {
    num_to_spawn = 1;
  }
  spawn_point = undefined;
  count = 0;
  while(count < num_to_spawn) {
    players = get_players();
    favorite_enemy = get_favorite_enemy();
    if(isDefined(spawners)) {
      spawn_point = spawners[randomInt(spawners.size)];
      ai = spawn_zombie(spawn_point);
      if(isDefined(ai)) {
        ai.favoriteenemy = favorite_enemy;
        spawn_point thread dog_spawn_fx(ai);
        count++;
        flag_set("dog_clips");
      }
    } else {
      if(isDefined(level.dog_spawn_func)) {
        spawn_loc = [[level.dog_spawn_func]](level.enemy_dog_spawns, favorite_enemy);
        ai = spawn_zombie(level.enemy_dog_spawns[0]);
        if(isDefined(ai)) {
          ai.favoriteenemy = favorite_enemy;
          spawn_loc thread dog_spawn_fx(ai, spawn_loc);
          count++;
          flag_set("dog_clips");
        }
      } else {
        spawn_point = dog_spawn_factory_logic(level.enemy_dog_spawns, favorite_enemy);
        ai = spawn_zombie(spawn_point);
        if(isDefined(ai)) {
          ai.favoriteenemy = favorite_enemy;
          spawn_point thread dog_spawn_fx(ai);
          count++;
          flag_set("dog_clips");
        }
      }
    }
    waiting_for_next_dog_spawn(count, num_to_spawn);
  }
  return true;
}

dog_run_think() {
  self endon("death");
  self waittill("visible");
  if(self.health > level.dog_health) {
    self.maxhealth = level.dog_health;
    self.health = level.dog_health;
  }
  assert(isDefined(self.fx_dog_eye));
  network_safe_play_fx_on_tag("dog_fx", 2, level._effect["dog_eye_glow"], self.fx_dog_eye, "tag_origin");
  assert(isDefined(self.fx_dog_trail));
  network_safe_play_fx_on_tag("dog_fx", 2, self.fx_dog_trail_type, self.fx_dog_trail, "tag_origin");
  self playLoopSound(self.fx_dog_trail_sound);
}

dog_stalk_audio() {
  self endon("death");
  self endon("dog_running");
  self endon("dog_combat");
  while(1) {
    self playSound("zmb_hellhound_vocals_amb", "stalk_vox_done");
    self waittill("stalk_vox_done");
    wait randomfloatrange(1, 4);
  }
}

dog_thundergun_disintegrate(player) {
  self endon("death");
  self DoDamage(self.health + 666, player.origin, player);
}

dog_thundergun_knockdown(player, gib) {
  self endon("death");
  damage = int(self.maxhealth * 0.5);
  self DoDamage(damage, player.origin, player);
}
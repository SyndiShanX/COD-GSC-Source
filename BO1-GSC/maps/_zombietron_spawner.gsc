/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_spawner.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

init_spawner_set(name) {
  spawners = getEntArray(name, "targetname");
  level.spawners[name] = [];
  level.spawners[name]["top"] = [];
  level.spawners[name]["bottom"] = [];
  level.spawners[name]["left"] = [];
  level.spawners[name]["right"] = [];
  level.spawners[name]["boss"] = [];
  for (i = 0; i < spawners.size; i++) {
    side = spawners[i].script_parameters;
    size = level.spawners[name][side].size;
    level.spawners[name][side][size] = spawners[i];
  }
}
init() {
  level.dogAttackPlayerDist = 102;
  level.dogAttackPlayerCloseRangeDist = 50;
  level.dogRunTurnSpeed = 20;
  level.dogRunPainSpeed = 20;
  zombies = getEntArray("zombie_spawner", "script_noteworthy");
  array_thread(zombies, ::add_spawn_function, ::zombie_spawn_init);
  for (i = 0; i < level.arenas.size; i++) {
    spawn_set = level.arenas[i] + "_spawner";
    init_spawner_set(spawn_set);
  }
}
zombie_spawn_init(animname_set) {
  if(!isDefined(animname_set)) {
    self.animname = "zombie";
  } else {
    self.animname = animname_set;
  }
  if(!isDefined(self.vox_alias_name)) {
    self.vox_alias_name = self.animname;
  }
  self.targetname = "zombie";
  self.script_noteworthy = undefined;
  self.ignoreall = true;
  self.ignoreme = true;
  self.allowdeath = true;
  self.force_gib = ok_to_gib();
  self.is_zombie = true;
  self.has_legs = true;
  self.gibbed = false;
  self.head_gibbed = false;
  self allowedStances("stand");
  self.disableTurns = true;
  self.disableArrivals = true;
  self.disableExits = true;
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoreSuppression = true;
  self.suppressionThreshold = 1;
  self.noDodgeMove = true;
  self.dontShootWhileMoving = true;
  self.pathenemylookahead = 0;
  self.badplaceawareness = 0;
  self.chatInitialized = false;
  self.a.disablepain = true;
  self disable_react();
  self.maxhealth = level.zombie_health;
  self.health = level.zombie_health;
  self.dropweapon = false;
  level thread zombie_death_event(self);
  level thread zombie_damage_event(self);
  self set_zombie_run_cycle();
  self thread zombie_think();
  self.deathFunction = ::zombie_death_func;
  self thread zombie_eye_glow();
  self.flame_damage_time = 0;
  self.meleeDamage = 500;
  self setTeamForEntity("axis");
  self notify("zombie_init_done");
  self.ignoreall = false;
  self.pathEnemyFightDist = 48;
  self.meleeAttackDist = 48;
  self.is_zombie = true;
  self.maxsightdistsqrd = 128 * 128;
}
start_burning(attacker) {
  self endon("death");
  time = 8;
  while (time > 0) {
    wait .4;
    time -= .4;
    if(isDefined(attacker)) {
      self DoDamage(120, self.origin, attacker, undefined, "burned");
    }
  }
}
zombie_blood() {
  self notify("only_one_blood");
  self endon("only_one_blood");
  self setclientflag(level._ZT_ACTOR_CF_BLOOD);
  wait_network_frame();
  self clearclientflag(level._ZT_ACTOR_CF_BLOOD);
}
zombie_damage_event(zombie) {
  while (isAlive(zombie)) {
    zombie waittill("damage", damage, attacker, direction, point, type);
    if(isDefined(zombie.damagedby) && zombie.damagedby == "tesla") {
      zombie maps\_zombietron_weapon::tesla_damage_init(attacker);
    }
    if(isDefined(zombie.damageWeapon) && WeaponType(zombie.damageWeapon) == "projectile") {
      zombie thread zombie_blood();
    }
    if(isDefined(zombie.damageWeapon) && WeaponType(zombie.damageWeapon) == "gas") {
      zombie.moveplaybackrate = 0.65;
      if(!isDefined(zombie.is_on_fire) || !zombie.is_on_fire) {
        zombie thread animscripts\zombie_death::flame_death_fx();
        zombie thread start_burning(attacker);
      }
    }
  }
}
zombie_death_event(zombie) {
  zombie waittill("death");
  if(!isDefined(zombie)) {
    return;
  }
  zombie thread zombie_eye_glow_stop();
  if(isDefined(zombie.attacker) && isplayer(zombie.attacker)) {
    if(!isDefined(zombie.attacker.killcounter)) {
      zombie.attacker.killcounter = 1;
    } else {
      zombie.attacker.killcounter++;
    }
    zombie.attacker.stats["kills"] = zombie.attacker.killcounter;
    zombie.attacker maps\_zombietron_score::player_add_points(level.zombie_vars["zombie_points_regular"]);
    zombie.attacker notify("zom_kill");
  }
  level notify("zom_kill");
  level.total_zombies_killed++;
}
zombie_eye_glow() {
  self haseyes(1);
}
zombie_eye_glow_stop() {
  self haseyes(0);
}
zombie_death_func() {
  self setPlayerCollision(0);
  animscripts\zombie_utility::initialize("zombie_death");
  explosiveDamage = IsExplosiveDamage(self.damageMod);
  self.mayDoUpwardsDeath = true;
  if(WeaponType(self.damageWeapon) == "projectile") {
    if(ok_to_gib()) {
      self setclientflag(level._ZT_ACTOR_CF_GIB_DEATH_P1 + self.attacker GetEntityNumber());
    }
  }
  if(explosiveDamage) {
    self.animTranslationScale = RandomFloatRange(1.5, 2.2);
    if(animscripts\zombie_death::play_explosion_death())
      return;
  }
  refs = [];
  if(ok_to_gib()) {
    if(isDefined(self.damageLocation)) {
      switch (self.damageLocation) {
        case "torso_upper":
        case "torso_lower":
          refs[refs.size] = "guts";
          refs[refs.size] = "right_arm";
          refs[refs.size] = "left_arm";
          break;
        case "right_arm_upper":
        case "right_arm_lower":
        case "right_hand":
          refs[refs.size] = "right_arm";
          break;
        case "left_arm_upper":
        case "left_arm_lower":
        case "left_hand":
          refs[refs.size] = "left_arm";
          break;
        case "right_leg_upper":
        case "right_leg_lower":
        case "right_foot":
          refs[refs.size] = "right_leg";
          refs[refs.size] = "no_legs";
          break;
        case "left_leg_upper":
        case "left_leg_lower":
        case "left_foot":
          refs[refs.size] = "left_leg";
          refs[refs.size] = "no_legs";
          break;
        case "helmet":
        case "head":
          refs[refs.size] = "head";
          break;
      }
    } else {
      refs[refs.size] = "guts";
      refs[refs.size] = "right_arm";
      refs[refs.size] = "left_arm";
      refs[refs.size] = "right_leg";
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      refs[refs.size] = "head";
    }
  }
  do_ragdoll = true;
  if(WeaponType(self.damageWeapon) == "gas" || self.damageMod == "burned") {
    do_ragdoll = false;
    if(!isDefined(self.is_on_fire) || !self.is_on_fire) {
      self thread animscripts\zombie_death::flame_death_fx();
    }
  } else if(refs.size) {
    if(!isDefined(self.a.gib_ref)) {
      self.a.gib_ref = animscripts\zombie_death::get_random(refs);
    }
    if(!isDefined(self.a.gib_vel)) {
      up = get_camera_launch_direction();
      self.gib_vel = self.damagedir * RandomIntRange(100, 300);
      self.gib_vel += up * RandomIntRange(1400, 3500);
      self.launch_gib_up = true;
    }
  }
  if(self.damageMod == "MOD_CRUSH") {
    do_ragdoll = false;
  }
  if(do_ragdoll) {
    force = 1;
    if(self.damageWeapon == "minigun_zt") {
      force = 1.8;
    }
    initial_force = self.damagedir + (0, 0, 0.2);
    initial_force *= 60 * force;
    if(animscripts\zombie_utility::damageLocationIsAny("head", "helmet", "neck")) {
      initial_force *= 0.6;
    }
    self startragdoll();
    self launchragdoll(initial_force, self.damageLocation);
  }
  death_anims = level._zombie_deaths[self.animname];
  self.deathanim = random(death_anims);
  animscripts\zombie_death::play_death_anim(self.deathanim);
  wait 0.1;
  return true;
}
zombie_death_delete_me() {
  self setPlayerCollision(0);
  wait 0.1;
  self delete();
  return true;
}
zombie_go_faster() {
  if(!isDefined(self.animname) || !isDefined(level.scr_anim[self.animname])) {
    return;
  }
  if(!isDefined(self.zombie_move_speed)) {
    self.zombie_move_speed = "walk";
  }
  if(self.zombie_move_speed == "crawl") {
    self.zombie_move_speed = "walk";
  } else
  if(self.zombie_move_speed == "walk") {
    self.zombie_move_speed = "run";
  }
  if(self.zombie_move_speed == "run") {
    self.zombie_move_speed = "sprint";
  }
  retries = 10;
  while (isDefined(self) && retries > 0) {
    theanim = undefined;
    switch (self.zombie_move_speed) {
      case "walk":
        theanim = "walk" + randomintrange(1, 8);
        break;
      case "run":
        theanim = "run" + randomintrange(1, 6);
        break;
      case "sprint":
        theanim = "sprint" + randomintrange(1, 4);
        break;
    }
    if(isDefined(level.scr_anim[self.animname][theanim])) {
      self set_run_anim(theanim);
      self.run_combatanim = level.scr_anim[self.animname][theanim];
      return;
    }
    wait 0.1;
    retries--;
  }
}
set_zombie_run_cycle() {
  self set_run_speed();
  switch (self.zombie_move_speed) {
    case "crawl":
      var = randomintrange(1, 6);
      self set_run_anim("crawl" +
        var);
      self.run_combatanim = level.scr_anim[self.animname]["crawl" +
        var
      ];
      break;
    case "walk":
      var = randomintrange(1, 8);
      self set_run_anim("walk" +
        var);
      self.run_combatanim = level.scr_anim[self.animname]["walk" +
        var
      ];
      break;
    case "run":
      var = randomintrange(1, 6);
      self set_run_anim("run" +
        var);
      self.run_combatanim = level.scr_anim[self.animname]["run" +
        var
      ];
      break;
    case "sprint":
      var = randomintrange(1, 4);
      self set_run_anim("sprint" +
        var);
      self.run_combatanim = level.scr_anim[self.animname]["sprint" +
        var
      ];
      break;
  }
}
set_run_speed() {
  if(isDefined(self.crawlOnly)) {
    self.zombie_move_speed = "crawl";
    return;
  }
  if(isDefined(self.walkOnly)) {
    self.zombie_move_speed = "walk";
    return;
  }
  if(isDefined(self.runOnly)) {
    self.zombie_move_speed = "run";
    return;
  }
  if(isDefined(self.sprintOnly)) {
    self.zombie_move_speed = "sprint";
    return;
  }
  if(isDefined(self.fixedMovement)) {
    self.zombie_move_speed = self.fixedMovement;
    return;
  }
  if(isDefined(level.zombie_count) && level.zombie_count <= 3) {
    self.zombie_move_speed = "sprint";
    return;
  }
  rand = randomintrange(level.zombie_move_speed - 20, level.zombie_move_speed + 35);
  if(rand <= 40) {
    self.zombie_move_speed = "walk";
  } else if(rand <= 70) {
    self.zombie_move_speed = "run";
  } else {
    self.zombie_move_speed = "sprint";
  }
}
zombie_think() {
  self thread find_flesh();
  self thread zombie_alive_audio();
}
find_flesh() {
  self endon("death");
  self endon("stop_find_flesh");
  self.helitarget = true;
  self.ignoreme = false;
  self.ignore_player = [];
  self.goalradius = 32;
  while (1) {
    near_zombies = GetAISpeciesArray("axis", "all");
    same_enemy_count = 0;
    for (i = 0; i < near_zombies.size; i++) {
      if(isDefined(near_zombies[i]) && isalive(near_zombies[i])) {
        if(isDefined(near_zombies[i].favoriteenemy) && isDefined(self.favoriteenemy) &&
          near_zombies[i].favoriteenemy == self.favoriteenemy) {
          if(distancesquared(near_zombies[i].origin, self.favoriteenemy.origin) < 225 * 225 &&
            distancesquared(near_zombies[i].origin, self.origin) > 525 * 525) {
            same_enemy_count++;
          }
        }
      }
    }
    if(same_enemy_count > 12) {
      self.ignore_player[self.ignore_player.size] = self.favoriteenemy;
    }
    players = get_players();
    if(players.size == 1) {
      self.ignore_player = [];
    } else {
      for (i = 0; i < self.ignore_player.size; i++) {
        if(isDefined(self.ignore_player[i]) && isDefined(self.ignore_player[i].ignore_counter) && self.ignore_player[i].ignore_counter > 3) {
          self.ignore_player[i].ignore_counter = 0;
          self.ignore_player = array_remove(self.ignore_player, self.ignore_player[i]);
        }
      }
    }
    player = get_closest_valid_player(self.origin, self.ignore_player);
    if(!isDefined(player)) {
      if(isDefined(self.ignore_player)) {
        self.ignore_player = [];
      }
      wait(1);
      continue;
    }
    self.favoriteenemy = player;
    self thread zombie_pathing();
    if(players.size > 1) {
      for (i = 0; i < self.ignore_player.size; i++) {
        if(isDefined(self.ignore_player[i])) {
          if(!isDefined(self.ignore_player[i].ignore_counter))
            self.ignore_player[i].ignore_counter = 0;
          else
            self.ignore_player[i].ignore_counter += 1;
        }
      }
    }
    self.zombie_path_timer = GetTime() + (RandomFloatRange(1, 3) * 1000);
    while (GetTime() < self.zombie_path_timer) {
      zombie_poi = self get_zombie_point_of_interest(self.origin);
      if(!isDefined(self.boss)) {
        self.enemyoverride = zombie_poi;
      }
      wait(0.1);
    }
    self notify("path_timer_done");
    self TrySpecialAttack();
  }
}
TrySpecialAttack() {
  if(!isDefined(self.specialAttack) || isDefined(self.marked_for_death)) {
    return false;
  }
  return [[self.specialAttack]]();
}
zombie_pathing() {
  self endon("death");
  assert(isDefined(self.favoriteenemy) || isDefined(self.enemyoverride));
  self thread zombie_follow_enemy();
}
get_zombie_point_of_interest(origin) {
  if(level.active_monkeys.size > 0) {
    threshSQ = level.zombie_vars["monkey_attract_dist"] * level.zombie_vars["monkey_attract_dist"];
    best_monkey = self get_closest_to_me(level.active_monkeys);
    if(isDefined(best_monkey)) {
      distsq = distanceSquared(best_monkey.origin, origin);
      if(distsq < threshSQ) {
        return best_monkey.origin;
      }
    }
  }
  if(level.active_heli.size > 0) {
    best_spot = self get_closest_to_me(level.active_heli);
    if(isDefined(best_spot)) {
      return best_spot.origin;
    }
  }
  if(self.moveplaybackrate > 1.5 && !isDefined(self.mini_boss)) {
    if(isDefined(self.favoriteenemy) && isDefineD(self.favoriteenemy.crumbs)) {
      distSQ = distanceSquared(self.origin, self.favoriteenemy.origin);
      if(distSQ < 72 * 72) {
        self.poi = undefined;
        self.poi_expire = undefined;
        return undefined;
      }
      if(isDefineD(self.poi_expire)) {
        if(GetTime() > self.poi_expire) {
          self.poi_next = GetTime() + 10000;
          self.poi = undefined;
          self.poi_expire = undefined;
          return undefined;
        }
      }
      if(isDefined(self.poi_next)) {
        if(GetTime() < self.poi_next) {
          return undefined;
        }
      }
      if(isDefined(self.poi)) {
        distSQ = distanceSquared(self.origin, self.poi);
        if(distSQ < 72 * 72) {
          self.poi = undefined;
          self.poi_expire = undefined;
          self.poi_next = GetTime() + 10000;
          return undefined;
        } else {
          return self.poi;
        }
      }
      self.poi = self.favoriteenemy.crumbs[RandomInt(self.favoriteenemy.max_crumb)];
      self.poi_expire = GetTime() + 6000;
      self.poi_next = undefined;
      return self.poi;
    }
  }
  return undefined;
}
zombie_follow_enemy() {
  self notify("follow_enemy");
  self endon("follow_enemy");
  self endon("death");
  self endon("bad_path");
  while (1) {
    wait(0.1);
    if(isDefined(level.zombie_count) && level.zombie_count <= 3) {
      self set_zombie_run_cycle();
    }
    if(isDefined(self.stunned)) {
      if(isDefined(self.original_location)) {
        self SetGoalPos(self.original_location);
      } else {
        self SetGoalPos(self.origin);
      }
      continue;
    }
    if(isDefined(self.enemyoverride)) {
      if(distanceSquared(self.origin, self.enemyoverride) > 32 * 32) {
        self OrientMode("face motion");
      } else {
        self OrientMode("face point", self.enemyoverride);
      }
      self.ignoreall = true;
      self.goalradius = 64;
      self SetGoalPos(self.enemyoverride);
    } else if(isDefined(self.favoriteenemy)) {
      self.ignoreall = false;
      self.goalradius = 32;
      self OrientMode("face default");
      self SetGoalPos(self.favoriteenemy.origin);
    }
  }
}
spawn_a_mini_boss(spawn_point, type, checkAvailFirst) {
  miniBossSpawners = getEntArray("mini_boss", "script_noteworthy");
  miniBoss = undefined;
  if(miniBossSpawners.size > 0) {
    if(isDefined(type)) {
      for (i = 0; i < miniBossSpawners.size; i++) {
        if(type == miniBossSpawners[i].script_parameters) {
          miniBoss = miniBossSpawners[i];
          break;
        }
      }
    } else {
      miniBoss = level.RandomMiniBosses[RandomInt(level.RandomMiniBosses.size)];
    }
  }
  if(isDefined(checkAvailFirst) && checkAvailFirst) {
    found = false;
    for (i = 0; i < level.RandomMiniBosses.size; i++) {
      if(miniBoss == level.RandomMiniBosses[i]) {
        found = true;
      }
    }
    if(!found) {
      return undefined;
    }
  }
  assert(isDefined(miniBoss));
  bossStruct = maps\_zombietron_challenges::get_challenge_by_type(miniBoss.script_parameters);
  assert(isDefined(bossStruct));
  if(isDefined(miniBoss)) {
    if(!isDefined(miniBoss.initialized)) {
      if(isDefined(bossStruct.spawnInitCB)) {
        theMinis[0] = miniBoss;
        array_thread(theMinis, ::add_spawn_function, bossStruct.spawnInitCB);
      }
      miniBoss.initialized = true;
    }
    boss_ent = spawn_zombie(miniBoss);
    if(isDefined(boss_ent)) {
      boss_ent.mini_boss = 1;
      boss_ent.maxhealth += level.zombie_vars["mini_boss_health"];
      boss_ent.health += level.zombie_vars["mini_boss_health"];
      boss_ent ForceTeleport(spawn_point.origin, spawn_point.angles);
      if(isDefined(bossStruct.hp_mod)) {
        boss_ent.maxhealth = int(boss_ent.maxhealth * bossStruct.hp_mod);
        boss_ent.health = int(boss_ent.health * bossStruct.hp_mod);
      }
      if(isDefined(bossStruct.postspawnCB)) {
        boss_ent thread[[bossStruct.postspawnCB]]();
      }
      return boss_ent;
    }
  }
  return undefined;
}
the_big_boss_defeated(type) {
  text2 = undefined;
  text3 = undefined;
  boss_msg2 = undefined;
  boss_msg3 = undefined;
  switch (type) {
    case "ape_zombie":
      text2 = & "ZOMBIETRON_COSMIC_SB_DEFEATED";
      text3 = & "ZOMBIETRON_COSMIC_SB_DEFEATED2";
      break;
  }
  boss_msg = NewHudElem(self);
  boss_msg.alignX = "center";
  boss_msg.alignY = "middle";
  boss_msg.horzAlign = "center";
  boss_msg.vertAlign = "middle";
  boss_msg.y -= 30;
  boss_msg.foreground = true;
  boss_msg.fontScale = 4;
  boss_msg.color = (1.0, 0.0, 0.0);
  boss_msg.alpha = 0;
  boss_msg SetText(&"ZOMBIETRON_BOSS_ROUND_VICTORY");
  boss_msg FadeOverTime(2);
  boss_msg.alpha = 1;
  boss_msg.hidewheninmenu = true;
  if(isDefined(text2)) {
    boss_msg2 = NewHudElem(self);
    boss_msg2.alignX = "center";
    boss_msg2.alignY = "middle";
    boss_msg2.horzAlign = "center";
    boss_msg2.vertAlign = "middle";
    boss_msg2.y += 20;
    boss_msg2.foreground = true;
    boss_msg2.fontScale = 3;
    boss_msg2.color = (1.0, 0.0, 0.0);
    boss_msg2.alpha = 0;
    boss_msg2 SetText(text2);
    boss_msg2 FadeOverTime(2.5);
    boss_msg2.alpha = 1;
    boss_msg2.hidewheninmenu = true;
  }
  wait 2;
  if(isDefined(text3)) {
    boss_msg3 = NewHudElem(self);
    boss_msg3.alignX = "center";
    boss_msg3.alignY = "middle";
    boss_msg3.horzAlign = "center";
    boss_msg3.vertAlign = "middle";
    boss_msg3.y += 50;
    boss_msg3.foreground = true;
    boss_msg3.fontScale = 2;
    boss_msg3.color = (1.0, 0.0, 0.0);
    boss_msg3.alpha = 0;
    boss_msg3 SetText(text3);
    boss_msg3 FadeOverTime(2.5);
    boss_msg3.alpha = 1;
    boss_msg3.hidewheninmenu = true;
  }
  wait 3;
  boss_msg FadeOverTime(2);
  boss_msg.alpha = 0;
  if(isDefined(boss_msg2)) {
    boss_msg2 FadeOverTime(2);
    boss_msg2.alpha = 0;
  }
  if(isDefined(boss_msg3)) {
    boss_msg3 FadeOverTime(2);
    boss_msg3.alpha = 0;
  }
  wait 2;
  DestroyHudElem(boss_msg);
  DestroyHudElem(boss_msg2);
  DestroyHudElem(boss_msg3);
}
the_big_boss_introduction(type) {
  text2 = undefined;
  boss_msg2 = undefined;
  switch (type) {
    case "ape_zombie":
      text2 = & "ZOMBIETRON_COSMIC_SB";
      break;
  }
  boss_msg = NewHudElem(self);
  boss_msg.alignX = "center";
  boss_msg.alignY = "middle";
  boss_msg.horzAlign = "center";
  boss_msg.vertAlign = "middle";
  boss_msg.y -= 30;
  boss_msg.foreground = true;
  boss_msg.fontScale = 4;
  boss_msg.color = (1.0, 0.0, 0.0);
  boss_msg.alpha = 0;
  boss_msg SetText(&"ZOMBIETRON_BOSS_ROUND");
  boss_msg FadeOverTime(2);
  boss_msg.alpha = 1;
  boss_msg.hidewheninmenu = true;
  if(isDefined(text2)) {
    boss_msg2 = NewHudElem(self);
    boss_msg2.alignX = "center";
    boss_msg2.alignY = "middle";
    boss_msg2.horzAlign = "center";
    boss_msg2.vertAlign = "middle";
    boss_msg2.y += 20;
    boss_msg2.foreground = true;
    boss_msg2.fontScale = 3;
    boss_msg2.color = (1.0, 0.0, 0.0);
    boss_msg2.alpha = 0;
    boss_msg2 SetText(text2);
    boss_msg2 FadeOverTime(2.5);
    boss_msg2.alpha = 1;
    boss_msg2.hidewheninmenu = true;
  }
  wait 3;
  boss_msg FadeOverTime(2);
  boss_msg.alpha = 0;
  if(isDefined(boss_msg2)) {
    boss_msg2 FadeOverTime(2);
    boss_msg2.alpha = 0;
  }
  wait 2;
  DestroyHudElem(boss_msg);
  DestroyHudElem(boss_msg2);
  flag_set("boss_spawn_go");
  flag_wait("boss_is_spawned");
  flag_set("boss_intro_done");
}
spawn_the_big_boss() {
  flag_clear("boss_intro_done");
  flag_clear("boss_spawn_go");
  flag_clear("boss_is_spawned");
  wait 0.1;
  spawner_set = level.arenas[level.current_arena] + "_spawner";
  assertEx(level.spawners[spawner_set]["boss"].size > 0, "No boss spawner found");
  spawners = level.spawners[spawner_set]["boss"];
  self thread the_big_boss_introduction(spawners[0].script_animname);
  flag_wait("boss_spawn_go");
  numBosses = level.arena_laps + 1;
  boss = undefined;
  while (numBosses > 0) {
    for (i = 0; i < spawners.size; i++) {
      spawner = spawners[i];
      if(isDefined(spawner.script_animname) && spawner.script_animname == "ape_zombie") {
        maps\_zombietron_ai_ape::init(spawner);
      } else {
        assert("Unhandled Boss Spawner");
      }
      boss = spawn_zombie(spawner, "silverback");
    }
    numBosses--;
    wait 10;
  }
  if(isDefined(boss)) {
    boss thread maps\_zombietron_challenges::boss_battle_challenge();
  }
}
update_drop_locations() {
  center = maps\_zombietron_main::get_camera_center_point();
  level.spawn_drop_locations = GetAnyNodeArray(center, 450);
}
#using_animtree("generic_human");
clark_spawn_init() {
  self zombie_spawn_init();
}
moss_death_martyrdom() {
  self waittill("death");
  if(isDefined(self)) {
    PlayFx(level._effect["barrel_explode"], self.origin, AnglestoForward(self.angles));
    RadiusDamage(self.origin + (0, 0, 20), 128, 7000, 5000, self, "MOD_PROJECTILE_SPLASH");
    physicsExplosionSphere(self.origin, 512, 128, 2);
    playRumbleOnPosition("grenade_rumble", self.origin);
    playsoundatposition("exp_tron_barrel", self.origin);
    wait 0.3;
  }
  if(isDefined(self)) {
    self Delete();
  }
}
moss_proximity_watch() {
  self endon("death");
  while (1) {
    if(isDefined(self.favoriteenemy)) {
      distSQ = distanceSquared(self.origin, self.favoriteenemy.origin);
      if(distSQ < 96 * 96) {
        self DoDamage(self.health + 666, self.origin);
      }
    }
    wait 0.5;
  }
}
moss_spawn_init() {
  self zombie_spawn_init();
}
moss_spawn_init_big() {
  self.vox_alias_name = "martyr";
  self zombie_spawn_init();
  self thread moss_death_martyrdom();
  self thread moss_proximity_watch();
  self.deathFunction = undefined;
  PlayFxOnTag(level._effect["player3_light"], self, "tag_origin");
}
sergei_spawn_init() {
  self.vox_alias_name = "sergei";
  self zombie_spawn_init();
}
sergei_anim_override() {
  self.a.array["exposed_idle"] = array( % ai_sergei_stand_idle);
  self.a.array["straight_level"] = % ai_sergei_stand_idle;
  self.a.array["stand_2_crouch"] = % ai_sergei_stand_idle;
  self.a.array["turn_left_45"] = % ai_sergei_run_hunched_turnL45;
  self.a.array["turn_left_90"] = % ai_sergei_run_hunched_turnL90;
  self.a.array["turn_left_135"] = % exposed_tracking_turn135L;
  self.a.array["turn_left_180"] = % ai_sergei_run_upright_turn180;
  self.a.array["turn_right_45"] = % ai_sergei_run_upright_turnR45;
  self.a.array["turn_right_90"] = % ai_sergei_run_upright_turnR90;
  self.a.array["turn_right_135"] = % exposed_tracking_turn135R;
  self.a.array["turn_right_180"] = % ai_sergei_run_upright_turn180;
  self.run_combatanim = % ai_sergei_run_upright;
}
spawn_sergei_postCB() {
  self setTeamForEntity("axis");
  self.fixedMovement = "sprint";
  self sergei_anim_override();
  self.set_animarray_standing_override = ::sergei_anim_override;
}
spawn_engineer_postCB() {
  self endon("death");
  self.walkOnly = true;
  self setTeamForEntity("axis");
  self set_zombie_run_cycle();
  if(level.spawn_drop_locations.size) {
    dropOverNode = level.spawn_drop_locations[RandomInt(level.spawn_drop_locations.size)];
    dropLocation = dropOverNode.origin;
    dropLocation += (0, 0, 1000);
    self ForceTeleport(dropLocation);
    self notify("stop_find_flesh");
    self.ignoreall = true;
    self.landed = false;
    timeToDrop = GetTime() + 10000;
    landingThresh = dropOverNode.origin[2] + 36;
    while (GetTime() < timeToDrop) {
      if(self.origin[2] > landingThresh) {
        wait 0.05;
      } else {
        self PlaySound("zmb_engineer_groundbang");
        self.landed = true;
        break;
      }
    }
    if(self.landed) {
      PlayFxOnTag(level._effect["betty_explode"], self, "tag_origin");
      playRumbleOnPosition("explosion_generic", self.origin);
      if(RandomInt(100) < 35) {
        time = getAnimLength( % ai_zombie_boss_enrage_start);
        self playsound("zmb_boss_vox_hit");
        self animscripted("groundhit_anim", self.origin, self.angles, % ai_zombie_boss_enrage_start, "normal", % body, 3);
        time = time / 4.0;
        wait(time);
      }
      self thread find_flesh();
      self.ignoreall = false;
      self.original_location = undefined;
    } else {
      self DoDamage(self.health + 500, self.origin);
    }
  }
  while (1) {
    if(self.health < int(self.maxhealth * 0.7)) {
      self.walkOnly = undefined;
      self playsound("zmb_boss_vox_hit");
      set_zombie_run_cycle();
      break;
    }
    wait 1;
  }
}
zombie_kite_watch() {
  self endon("death");
  wait 30;
  self zombie_go_faster();
  wait 10;
  self zombie_go_faster();
  wait 10;
  self zombie_go_faster();
  wait 10;
  max_anim_playback = 2;
  max_time_till_fullspeed = 100;
  increment = (max_anim_playback - self.moveplaybackrate) / max_time_till_fullspeed;
  while (max_time_till_fullspeed > 0) {
    self.moveplaybackrate += increment;
    if(self.moveplaybackrate > max_anim_playback) {
      self.moveplaybackrate = max_anim_playback;
    }
    max_time_till_fullspeed--;
    wait 1;
  }
}
zombie_killer_failsafe() {
  self endon("death");
  if(isDefined(self.boss)) {
    return;
  }
  if(!isDefined(self.mini_boss)) {
    self thread zombie_kite_watch();
  }
  fails = 0;
  while (isDefined(self) && !flag("exits_open")) {
    if(flag("round_is_active")) {
      wait 1;
      continue;
    }
    pos = (self.origin[0], self.origin[1], 0);
    wait 5;
    pos2 = (self.origin[0], self.origin[1], 0);
    distSQ = distanceSquared(pos, pos2);
    if(distSQ < 32 * 32) {
      self DoDamage(self.health + 666, self.origin);
    }
    if(self HasPath() == false) {
      fails++;
      if(fails > 3) {
        self DoDamage(self.health + 667, self.origin);
      }
    } else {
      fails = 0;
    }
    close = false;
    players = GetPlayers();
    for (i = 0; i < players.size; i++) {
      distSQ = distanceSquared(self.origin, players[i].origin);
      if(distSQ < 1024 * 1024) {
        close = true;
        break;
      }
    }
    if(close == false) {
      self DoDamage(self.health + 664, self.origin);
    }
  }
  if(isDefined(self) && isAlive(self)) {
    self DoDamage(self.health + 665, self.origin);
  }
}
zombie_alive_audio() {
  self endon("death");
  middle = undefined;
  switch (self.vox_alias_name) {
    case "zombie":
      middle = "regular";
      break;
    case "quad_zombie":
      middle = "quad";
      break;
    case "boss_zombie":
      middle = "boss";
      break;
    case "sergei":
      middle = "sergei";
      break;
    case "martyr":
      middle = "martyr";
      break;
  }
  alias = "zmb_" + middle + "_vox_";
  self thread zombie_death_audio(alias);
  level.movement_vox = 0;
  level.attack_vox = 0;
  self.playing_attack_vox = false;
  self.playing_movement_vox = false;
  wait(RandomFloatRange(.5, 1.5));
  while (1) {
    players = get_players();
    for (i = 0; i < players.size; i++) {
      if((DistanceSquared(self.origin, players[i].origin) < 50 * 50) && (level.attack_vox <= 3) && !self.playing_attack_vox) {
        level.attack_vox++;
        self.playing_attack_vox = true;
        self thread vox_timer("attack");
        self PlaySound(alias + "attack");
      }
    }
    if(!self.playing_movement_vox && !self.playing_attack_vox && (level.movement_vox <= 8)) {
      level.movement_vox++;
      self.playing_movement_vox = true;
      self thread vox_timer("movement");
      self PlaySound(alias + "move");
    }
    wait(.1);
  }
}
vox_timer(type) {
  self endon("death");
  switch (type) {
    case "attack":
      wait(RandomFloatRange(.75, 1.75));
      self.playing_attack_vox = false;
      if(level.attack_vox > 0) {
        level.attack_vox--;
      }
      break;
    case "movement":
      wait(RandomFloatRange(2.5, 5));
      self.playing_movement_vox = false;
      if(level.movement_vox > 0) {
        level.movement_vox--;
      }
      break;
  }
}
zombie_death_audio(alias) {
  self waittill("death");
  if(isDefined(self))
    self PlaySound(alias + "death");
}
�
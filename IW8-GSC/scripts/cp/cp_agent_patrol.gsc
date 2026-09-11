/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_patrol.gsc
***********************************************/

function initpatrolpoints() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait 1;
  level.bestpatrolpoint = undefined;
  level.previouspatrolpoint = undefined;
  var0 = scripts\engine\utility::getStructArray("soldier_patrol", "script_noteworthy");
  level.allspatrolpoints = var0;
  var1 = 1;
  level.last_player_seen = 0;

  foreach(var3 in var0) {
    var3.patrolscore = 0;
    var3.id = var1;
    var3.personalscore = 0;
    var1++;
  }

  if(scripts\engine\utility::flag_exist("patrolPoints_initialized")) {
    scripts\engine\utility::flag_set("patrolPoints_initialized");
  }

  thread spatrolpointscoring();
}

function set_default_soldier_values() {
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.damaged = undefined;
  thread exit_patrol_mode();
  thread soldier_player_listener();
  self.stealth_initialized = 1;
}

function set_default_patrol_values() {
  self notify("patrol_values_set");
  setpatrolstate("patrol", "patrol", 0, 0, 0, undefined, 0, 1);
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.damaged = undefined;
  thread exit_patrol_mode();
  thread soldier_player_listener();
  self.stealth_initialized = 1;
}

function watchfornotifies(var0) {
  var0 endon("death");
  var0 notify("watchForNotifies");
  var0 endon("watchForNotifies");
  var0.notifycounter = [];
  var1 = ["death", "alerted", "texthandler", "set_goal_pos_requested", "goal_reached", "stalled", "patrol_path", "stop_patrol_logic", "watchForBulletWhizby", "exit_patrol_mode", "watchForSoldierKilled", "alertNearbyEnemiesAfterDelay", "watchForWeaponFire", "alertNearbyLoop", "soldier_investigate", "alerted_hunt_mode", "hunt_player", "exit_stealth", "soldier_player_listener", "patrol_values_set", "goal"];

  foreach(var3 in var1) {
    var0.notifycounter[var3] = 0;
  }

  for(;;) {
    var5 = var0 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var1);
    var0.notifycounter[var5]++;
  }
}

function patrol_state_text_handler(var0) {
  var0 endon("death");
  var0 notify("texthandler");
  var0 endon("texthandler");
  var1 = var0 getentitynumber();

  for(;;) {
    if(getDvar("stealth_show_states") == "") {
      level waittill("show_stealth_states");
    }

    if(isDefined(var0.patrol_state) && isDefined(var0._blackboard.movetype)) {} else if(isDefined(var0.patrol_state)) {}

    wait 0.05;
  }
}

function target_patrol_path(var0) {
  self endon("stop_patrol_logic");
  self endon("death");
  self endon("alerted");
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var2 = var1[randomint(var1.size)];

  for(;;) {
    thread setcooldown(var2, var2);
    setgoalandtimeout(var2.origin);
    thread unsetcooldown(var2);

    if(isDefined(var2.target)) {
      var1 = scripts\engine\utility::getStructArray(var2.target, "targetname");
      var2 = var1[randomint(var1.size)];
      continue;
    }

    break;
  }
}

function spatrolpointscoring() {
  level endon("game_ended");

  if(!isDefined(level.allspatrolpoints) || level.allspatrolpoints.size < 1) {
    return;
  }

  var0 = 12;
  level.excludedpatrolpoints = [];
  var1 = level.allspatrolpoints;
  var2 = [];
  var3 = 9 / var0;
  var4 = 3 / var0;
  var5 = 5;

  for(;;) {
    var6 = 0;

    foreach(var8 in var1) {
      var9 = 0;

      if(istrue(var8.cooldown) && isDefined(var8.startingcooldown)) {
        var10 = var3 * 500;
        var9 = var10 * var8.cooldown / var8.startingcooldown;
      }

      var9 = clamp(var9, 0, 500);
      var8.patrolscore = int(var9);
      var6++;

      if(var6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

function zpatrolpointscoring() {
  level endon("game_ended");

  if(!isDefined(level.allzpatrolpoints) || level.allzpatrolpoints.size < 1) {
    return;
  }

  var0 = 12;
  level.excludedpatrolpoints = [];
  var1 = level.allzpatrolpoints;
  var2 = [];
  var3 = 9 / var0;
  var4 = 3 / var0;
  var5 = 5;

  for(;;) {
    var6 = 0;

    foreach(var8 in var1) {
      var9 = 0;

      if(istrue(var8.cooldown) && isDefined(var8.startingcooldown)) {
        var10 = var3 * 500;
        var9 = var10 * var8.cooldown / var8.startingcooldown;
      }

      var9 = clamp(var9, 0, 500);
      var8.patrolscore = int(var9);
      var6++;

      if(var6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

function getscoredpatrolpoint2(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = level.allspatrolpoints;
  }

  if(!isDefined(var2)) {
    var2 = [];
  } else {
    var2 = scripts\engine\utility::array_removeundefined(var2);
  }

  if(!isDefined(var3)) {
    var3 = "soldier_agent";
  }

  var4 = 25;
  var5 = scripts\cp\cp_agent_utils::getactiveagentsoftype(var3);
  var6 = sortbydistance(scripts\engine\utility::array_remove_array(var1, var2), var0.origin);
  var7 = [];
  var8 = scripts\engine\utility::get_array_of_closest(var0.origin, var5, undefined, 4, 256).size >= 3;
  var9 = 5 / var4;
  var10 = 20 / var4;

  foreach(var12 in var6) {
    var13 = var12.patrolscore;
    var12.personalscore = 0;
    var14 = 250;

    if(var8 && distance(var0.origin, var12.origin) <= 500) {
      var14 = 500;
    } else {
      var15 = scripts\engine\math::get_dot(var0.origin, anglesToForward(var0.angles), var12.origin);

      if(isDefined(var12.target)) {
        var16 = scripts\engine\utility::getStructArray(var12.target, "targetname");

        if(var16.size > 1) {
          var17 = var10 * 500;
          var14 -= var17;
        }

        var18 = var9 * 500;
        var14 = var18 * var15;
      } else {
        var14 = 500 * var15;
      }
    }

    var14 = clamp(var14, 0, 500);
    var14 = clamp(var14 + var13, 0, 999);
    var12.personalscore = int(var14);
    var7 = var12;

    if(var14 <= 50) {
      return var12;
    }
  }

  var20 = scripts\cp\utility::array_sort_by_handler(var7, &getpersonalpatrolscore)[0];
  return var20;
}

function getpersonalpatrolscore() {
  if(isDefined(self.personalscore)) {
    return self.personalscore;
  }

  return 999;
}

function getpatrolscore() {
  if(isDefined(self.patrolscore)) {
    return self.patrolscore;
  }

  return 0;
}

function setcooldown(var0, var1) {
  level endon("game_ended");
  var0 notify("setCooldown");
  var0 endon("setCooldown");
  var0 endon("unsetCooldown");
  var2 = 0.5 * var1;
  var2 = clamp(var2, 0.1, var2);
  var3 = gettime() + var2 * 1000;
  var4 = var1 / 20;
  var4 = clamp(var4, 0.05, var4);
  var5 = 0;
  var0.patrolscore = 500;
  var0.startingcooldown = var1;

  while(gettime() < var3) {
    var0.cooldown = 20 - var5;
    var5++;
    wait var4;
  }
}

function unsetcooldown(var0) {
  var0 notify("unsetCooldown");
  var0.cooldown = undefined;
  var0.startingcooldown = undefined;
}

function watchforstalledpos(var0) {
  self notify("watchForStalledPos");
  self endon("watchForStalledPos");
  self endon("death");
  self endon("alerted");
  self endon("goal");
  self endon("goal_reached");

  if(isDefined(var0)) {
    self endon(var0);
  }

  var1 = self.origin;
  var2 = 0;
  var3 = 10;

  for(;;) {
    if(self.origin == var1) {
      var2++;
    }

    if(var2 >= var3) {
      break;
    }

    wait 0.25;
  }

  self notify("stalled");
}

function setgoalandtimeout(var0, var1, var2) {
  self notify("setGoalAndTimeout");
  self endon("setGoalAndTimeout");
  self endon("death");
  self endon("alerted");

  if(isDefined(var2)) {
    self endon(var2);
  }

  if(isDefined(var0)) {
    var3 = getclosestpointonnavmesh(var0);
    thread watchforstalledpos(var2);
    _setgoalpos(self, var3, var1);
    return;
  }

  wait 0.25;
}

function _setgoalpos(var0, var1, var2) {
  var0 notify("set_goal_pos_requested");
  var0 endon("set_goal_pos_requested");
  var0 endon("death");
  var0 endon("stalled");

  if(isDefined(var2)) {
    var0.goalradius = var2;
  } else {
    var0.goalradius = 32;
  }

  var3 = 0;

  foreach(var5 in level.nearbyposarray) {
    if(distance(var5, var1) <= var0.goalradius) {
      var3 = 1;
      break;
    }
  }

  var7 = 1;

  if(var3) {
    var8 = getrandomnavpoints(var1, 50, 10, undefined, getrandomnavpoint(var1, 32), 25);
    var9 = 0;

    foreach(var11 in var8) {
      var7 = 0;

      foreach(var5 in level.nearbyposarray) {
        if(distance(var5, var11) <= 32) {
          var7 = 1;
          break;
        }
      }

      if(!var7) {
        var1 = var11;
        break;
      }
    }
  }

  thread manageposarray(var0, var1);
  var0 setbtgoalpos(0, var1);
  var15 = var0 scripts\engine\utility::ref_143ad("goal", "goal_reached");
}

function manageposarray(var0, var1) {
  if(isDefined(var1)) {
    level.nearbyposarray[level.nearbyposarray.size] = var1;
    var2 = var0 scripts\engine\utility::waittill_any_in_array_return(["death", "set_goal_pos_requested", "alerted", "exit_stealth", "new_goal", "alerted_by_ai"]);

    if(scripts\engine\utility::array_contains(level.nearbyposarray, var1)) {
      level.nearbyposarray = scripts\engine\utility::array_remove(level.nearbyposarray, var1);
      return;
    }

    return;
  }
}

function patrol_path(var0, var1) {
  self notify("patrol_path");
  self endon("patrol_path");
  self endon("death");
  self endon("alerted");
  self endon("stop_patrol_logic");

  if(!isDefined(level.allspatrolpoints) || level.allspatrolpoints.size < 1) {
    return;
  }

  if(isDefined(level.allspatrolpoints) || level.allspatrolpoints.size > 1) {
    var2 = level.allspatrolpoints;
    var3 = scripts\engine\utility::array_combine([var0], level.excludedpatrolpoints);
    var4 = scripts\engine\utility::get_array_of_closest(var0.origin, var2, var3, 10);

    if(var4.size < 1) {
      var2 = scripts\engine\utility::getStructArray(var0.targetname, "targetname");
      var4 = scripts\engine\utility::get_array_of_closest(var0.origin, scripts\engine\utility::getStructArray(var0.targetname, "targetname"), var3, 5);
    }

    var5 = scripts\engine\utility::getclosest(var0.origin, var4, 256);

    if(isDefined(var5)) {
      var6 = var5;
    } else {
      var6 = getscoredpatrolpoint2(self, var5);
    }

    var7 = var6;
    var4 = scripts\engine\utility::array_combine([var6, var7], level.excludedpatrolpoints);

    for(;;) {
      thread setcooldown(var6, var6);
      thread removeifalerted(self, var6);
      setgoalandtimeout(var6.origin);
      self.onpatrolpath = undefined;
      unsetcooldown(var6);

      if(scripts\engine\utility::cointoss()) {
        wait randomfloatrange(2.5, 5);
      }

      var3 = level.allspatrolpoints;

      if(isDefined(var6)) {
        var7 = var6;
      }

      var4 = scripts\engine\utility::array_combine([var7, var6], level.excludedpatrolpoints);
      var5 = scripts\engine\utility::get_array_of_closest(self.origin, var3, var4, 5);
      var6 = getscoredpatrolpoint2(self, var5, var4);
    }
    LOC_00000179:

      return;
  }
}

function removeifalerted(var0, var1) {
  level endon("game_ended");
  var0 endon("goal_reached");
  var0 endon("goal");
  var0 endon("stalled");
  var0 endon("death");
  var0 scripts\engine\utility::ref_143a5("death", "alerted");
  addtopatrolexclusion(0, var1);
}

function addtopatrolexclusion(var0, var1) {
  if(istrue(var0) && !scripts\engine\utility::array_contains(level.excludedpatrolpoints, var1)) {
    level.excludedpatrolpoints = scripts\engine\utility::array_add(level.excludedpatrolpoints, var1);
    return;
  }

  if(scripts\engine\utility::array_contains(level.excludedpatrolpoints, var1)) {
    level.excludedpatrolpoints = scripts\engine\utility::array_remove(level.excludedpatrolpoints, var1);
    return;
  }
}

function watchforbulletwhizby() {
  self notify("watchForBulletWhizby");
  self endon("watchForBulletWhizby");
  level endon("game_ended");
  self endon("death");
  self endon("alerted");

  for(;;) {
    self waittill("bulletwhizby", var0, var1, var2, var3);

    if(isPlayer(var0)) {
      self notify("stop_patrol_logic");
      setpatrolstate("investigating_whizby", "cqb", 0, 1, 0, var2);
      break;
    }
  }
}

function exit_patrol_mode() {
  self notify("exit_patrol_mode");
  self endon("exit_patrol_mode");
  self endon("death");
  self endon("alerted");
  thread watchforweaponfire();
  thread watchforbulletwhizby();
  thread watchforsoldierkilled(self);
  thread scripts\cp\cp_trigger_spawn::soldier_player_listener();

  for(;;) {
    var0 = scripts\engine\utility::waittill_any_ents_return(self, "damage", self, "explode", self, "alerted_by_soldier", level, "large_explosion");

    if(!isDefined(var0)) {
      continue;
    }

    if(istrue(self.posted)) {
      if(var0 != "damage") {
        break;
      } else {
        continue;
      }

      continue;
    }

    break;
  }

  var1 = 2;
  var2 = 1;
  var3 = 1;
  var4 = 0;

  if(isDefined(var0)) {
    switch (var0) {
      case "alerted_by_soldier":
        setpatrolstate("alerted_by_soldier", "combat", 1, 0, 0, undefined);
        var2 = 1;
        var3 = 0;
        var4 = 0;
        break;
      case "damage":
        setpatrolstate("damaged", "combat", 1, 0, 0, undefined, 1);
        self.damaged = 1;
        var3 = 1;
        var4 = 1;
        break;
    }

    return;
  }
}

function watchforsoldierkilled(var0) {
  var0 notify("watchForSoldierKilled");
  var0 endon("watchForSoldierKilled");
  var0 endon("death");
  var0 endon("alerted");

  for(;;) {
    var1 = 0;
    level waittill("ai_killed", var2, var3, var4, var5, var6, var7);

    if(var7 != var0.team) {
      continue;
    }

    if(istrue(var0.posted)) {
      continue;
    }

    var1 = isPlayer(var5);
    var8 = scripts\engine\math::get_dot(var0.origin, var0 getplayerangles(1), var2);

    if(var8 >= 0.573576 && sighttracepassed(var0 getEye(), var2, 0, var0, 1)) {
      setpatrolstate(var0, "witnessed_friendly_death", "sprint", 0, 1, 0, var2, 0);
      break;
    }
  }
}

function setpatrolstate(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(var1)) {
    if(var1 == "cqb") {
      scripts\common\utility::demeanor_override("cqb");
      var1 = "combat";
    } else if(var1 == "combat") {
      scripts\common\utility::demeanor_override("combat");
    }

    scripts\asm\asm_bb::bb_requestmovetype(var1);
  }

  self notify(var0);
  self.patrol_state = var0;
  var9 = istrue(self.behinddoors);

  if(istrue(var6)) {
    thread alertnearbyenemiesafterdelay(undefined, undefined, 1, 1);
  }

  if(istrue(var7)) {
    if(isDefined(self.spawnpoint.target)) {
      thread target_patrol_path(self.spawnpoint);
      return;
    }

    thread _startsoldierpatrol(self);
    return;
  }

  if(istrue(var4)) {
    thread alerted_hunt_mode(self);
    return;
  }

  if(istrue(var3)) {
    if(isDefined(var5)) {
      thread soldier_investigate(self, var5);
      return;
    }

    var10 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(var10)) {
      thread soldier_investigate(self, var10.origin);
      return;
    }

    thread soldier_investigate(self, getrandomnavpoint(self.origin, 256));
    return;
  }

  if(istrue(var3)) {
    thread enter_combat();
    return;
  }
}

function alertnearbyenemiesafterdelay(var0, var1, var2, var3) {
  self notify("alertNearbyEnemiesAfterDelay");
  self endon("alertNearbyEnemiesAfterDelay");
  self endon("death");

  if(!isDefined(var1)) {
    var1 = 3;
  }

  wait var1;
  thread alert_all_nearby_enemies(var0, var2, undefined, var3);
}

function watchforweaponfire() {
  level endon("game_ended");
  self notify("watchForWeaponFire");
  self endon("watchForWeaponFire");
  self endon("alerted");
  self endon("death");
  var0 = 1500;

  for(;;) {
    level waittill("weapon_fired", var1, var2, var3);

    if(istrue(self.posted)) {
      continue;
    }

    if(isagent(var3) && var3.team == self.team) {
      continue;
    }

    var0 = 1500;

    if(isPlayer(var3)) {
      var0 *= var3.perk_data["stealth_weapon_noise_scalar"];
    }

    var4 = 0;

    foreach(var6 in var2.attachments) {
      if(issubstr(var6, "silencer")) {
        var4 = 1;
        break;
      }
    }

    if(var4) {
      continue;
    }

    if(istrue(self.damaged)) {
      var0 = int(var0 * 1.5);
    }

    if(distance(var1, self.origin) > var0) {
      continue;
    }

    setpatrolstate("investigating_weapon_fire", "sprint", 0, 1, 0, var1, 0);
    break;
  }
}

function canpathtotarget(var0, var1) {
  var2 = var0 findpath(var0.origin, var1, 0, 0);

  if(var2.size >= 1 && distance(var2[var2.size - 1], var1) <= 64) {
    return 1;
  }

  return 0;
}

function alertnearbyloop(var0) {
  var0 notify("alertNearbyLoop");
  var0 endon("alertNearbyLoop");
  var0 endon("death");
  var0 endon("patrol_values_set");

  for(;;) {
    var1 = var0 scripts\engine\utility::ref_143ac("shooting");
    thread alertnearbyenemiesafterdelay();

    if(var1 == "shooting") {
      wait 0.5;
    }
  }
}

function enter_combat() {
  self notify("alerted");
  self notify("enter_combat");
  self.goalradius = 64;
  self.nocorpse = undefined;
  self.ignoreall = 0;
  self.scripted_mode = 0;
  self.entered_combat = 1;
  scripts\common\utility::demeanor_override("frantic");
  thread get_enemy_info_loop(5);
}

function get_enemy_info_loop(var0) {
  level endon("game_ended");
  self notify("get_enemy_info_loop");
  self endon("get_enemy_info_loop");
  self endon("death");
  var1 = get_closest_available_player();

  if(!isDefined(var1)) {
    level notify("no_target_player_found");
    return;
  } else {
    self clearentitytarget();
    self getenemyinfo(var1);
    self.favoriteenemy = var1;

    if(!isDefined(var1.enemy_list)) {
      var1.enemy_list = [];
    }

    if(!isDefined(self.target_enemy) || self.target_enemy != var1) {
      self notify("changed_target");
      thread scripts\engine\utility::thread_on_notify_no_endon_death("changed_target", &clear_enemy_flags, var1);
      thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &clear_enemy_flags, var1);

      if(!scripts\engine\utility::array_contains(var1.enemy_list, self)) {
        var1.enemy_list[var1.enemy_list.size] = self;
      }
    }

    self.target_enemy = var1;
  }

  if(isDefined(self.script_goalvolume)) {
    self setgoalvolumeauto(self.script_goalvolume);
    return;
  }
}

function movetocovernode(var0) {
  self setbtgoalnode(1, var0);
  self setbtgoalRadius(1, self.goalradius);
  self setbtgoalheight(1, self.goalheight);
  self setbtgoalpos(0, var0.origin);
  self.movetocovernodestarttime = gettime();
  self.movetocovernode = var0;
  thread clearbtgoalonarrival();
}

function clearbtgoalonarrival() {
  self endon("death");
  self notify("ClearBTGoalArrival_reset");
  self endon("ClearBTGoalArrival_reset");
  self waittill("goal_reached");
  self clearbtgoal(1);
}

function get_closest_available_player() {
  var0 = sortbydistance(level.players, self.origin);

  foreach(var2 in var0) {
    if(var2 scripts\cp\utility::is_valid_player()) {
      if(!isDefined(var2.hunted_count) || var2.hunted_count.size < 3) {
        return var2;
      }

      if(!isDefined(var2.enemy_list) || var2.enemy_list.size < int(24 / level.players.size)) {
        return var2;
      }
    }
  }

  if(isDefined(self.enemy)) {
    return self.enemy;
  }

  return undefined;
}

function clear_enemy_flags(var0) {
  if(isDefined(var0)) {
    var0.enemy_list = scripts\engine\utility::array_remove(var0.enemy_list, self);
    return;
  }
}

function clear_hunted_flags(var0) {
  if(isDefined(var0)) {
    var0.hunted_count = scripts\engine\utility::array_remove(var0.hunted_count, self);
    return;
  }
}

function clear_pos_from_hunt_pos_array(var0) {
  if(isDefined(var0)) {
    var0.hunted_count = scripts\engine\utility::array_remove(var0.hunted_count, self);
    return;
  }
}

function hunt_player_delayed() {
  self endon("death");
  var0 = randomintrange(25, 60);
  var1 = randomintrange(10, 15);
  hunt_player(var0, var1);
}

function soldier_investigate(var0, var1) {
  level endon("game_ended");
  var0 notify("soldier_investigate");
  var0 endon("soldier_investigate");
  var0 endon("alerted");
  var0 endon("death");
  setgoalandtimeout(var0, var1);

  if(var0 scripts\cp\cp_trigger_spawn::trigger_temp_stealth_meter(2.6, undefined, "investigate")) {
    wait 5;

    foreach(var3 in scripts\cp\cp_agent_utils::getactiveagentsoftype("soldier_agent")) {
      thread setalertedhuntmode(var3);
    }
  }

  wait 5;
  thread setalertedhuntmode(var0);
}

function alerted_hunt_mode(var0) {
  var0 notify("stop_patrol_logic");
  var0 notify("alerted_hunt_mode");
  var0 endon("alerted_hunt_mode");
  var0 endon("hunt_player");
  var0 endon("death");
  var0 endon("patrol_values_set");
  var0 endon("alerted");
  var0.soldierhuntmode = undefined;
  var0.alertedhuntmode = undefined;
  var0.alerted_hunt_mode = 1;
  var0.no_fallback = 1;

  for(;;) {
    if(istrue(var0.behinddoors)) {
      var1 = getnodesinradiussorted(var0.origin, 512, 0, 24, "Cover");
      setgoalandtimeout(var0, var1[0].origin);
      continue;
    }

    var2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var0 scripts\cp\utility::get_closest_living_player(), var0);

    if(!isDefined(var2)) {
      var2 = var0;
    }

    var3 = getrandomnavpoint(var2.origin, 1024);

    if(isDefined(var3)) {
      setgoalandtimeout(var0, var3);
    } else {
      var3 = getrandomnavpoint(var0.origin, 256);
      setgoalandtimeout(var0, var3);
    }
  }
}

function hunt_player(var0, var1) {
  level endon("game_ended");
  self notify("hunt_player");
  self endon("hunt_player");
  self endon("death");

  if(isDefined(var0)) {
    wait var0;
  }

  while(!should_hunt_player()) {
    wait 1;
  }

  self.hunting_player = 1;
  self.no_fallback = 1;

  for(;;) {
    var2 = scripts\cp\utility::get_closest_living_player();

    if(isalive(var2)) {
      self getenemyinfo(var2);
      self setgoalentity(var2, 3);
    }

    wait 3;
  }
}

function should_hunt_player() {
  var0 = 0;
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var3 in var1) {
    if(isDefined(var3.hunting_player)) {
      var0++;
    }
  }

  if(var0 > level.players.size * 2) {
    return 0;
  }

  return 1;
}

function reduce_goalradius_over_time(var0) {
  self notify("reduce_goalradius_over_time");
  self endon("reduce_goalradius_over_time");
  self endon("death");
  self endon("patrol_values_set");
  jumpiftrue(isDefined(var0)) LOC_00000028;
  var0 = 2;

  for(;;) {
    var1 = self.goalradius - 100;

    if(self.goalradius < 250) {
      self.goalradius = 250;
    } else {
      self.goalradius = var1;
    }

    wait var0;
  }
}

function setweaponsfree(var0) {
  var0 notify("setWeaponsFree");
  var0 endon("setWeaponsFree");
  var0 endon("death");
  level endon("clearWeaponsFree");
  level endon("game_ended");

  for(;;) {
    var1 = var0 scripts\engine\utility::ref_143ba(5, "shooting", "spotted_player");

    if(isDefined(var1)) {
      if(var1 != "timeout") {
        continue;
      }

      thread setalertedhuntmode(var0);
      return;
    }
  }
}

function toggleweaponsfree(var0) {
  if(istrue(var0)) {
    scripts\engine\utility::flag_set("weapons_free");
    return;
  }

  scripts\engine\utility::flag_clear("weapons_free");
}

function clearweaponsfree() {
  level notify("clearWeaponsFree");

  foreach(var1 in scripts\cp\cp_agent_utils::getactiveagentsoftype("soldier_agent")) {
    thread setalertedhuntmode(var1);
  }
}

function setalertedhuntmode(var0) {
  set_default_soldier_values(var0);

  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    setpatrolstate(var0, "alerted_hunt_mode", "cqb", 0, 0, 1, undefined, 0);
    return;
  }

  setpatrolstate(var0, "spotted_player", "combat", 1, 0, 0, undefined, 1);
}

function _startsoldierpatrol(var0) {
  set_default_soldier_values(var0);
  thread patrol_path(var0, var0.spawnpoint);
}

function soldier_player_listener() {
  level endon("game_ended");
  self notify("soldier_player_listener");
  self endon("soldier_player_listener");
  self endon("alerted");
  self endon("death");
  var0 = ["dx_otn_usm1_exposed", "dx_otn_usm1_exposed_breaking", "dx_otn_usm1_exposed_open", "dx_otn_usm1_exposed_movement", "dx_otn_usm1_exposed_acquired"];

  for(;;) {
    foreach(var2 in level.players) {
      if(isplayernearme(self, var2)) {
        if(isDefined(level.last_player_seen) && gettime() >= level.last_player_seen + 5000) {
          level.last_player_seen = gettime();
          scripts\cp\utility::playsoundatpos_safe(self.origin, scripts\engine\utility::random(var0));
        }

        setpatrolstate("spotted_player", "combat", 1, 0, 0, undefined, 1);
        return;
      }
    }

    wait 0.1;
  }
}

function isplayernearme(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  if(istrue(var1.ignoreme)) {
    return false;
  }

  var2 = isPlayer(var1);
  var3 = distance(var1.origin, var0.origin);
  var4 = istrue(var0.damaged);

  if(var3 < 96) {
    if(vectordot(anglesToForward(var0.angles), vectorNormalize(var1.origin - var0.origin)) > 0) {
      return true;
    }
  }

  var5 = 1;
  var6 = var1 getvelocity();
  var7 = length(var6);

  if(var7 < 128) {
    var5 = 0.75;
  } else if(var7 < 200 || var2 && var1.perk_data["stealth_velocity_override"]) {
    var5 = 1;
  } else {
    var5 = 1.25;
  }

  if(var3 > 1500 * var5) {
    return false;
  }

  var8 = var0 cansee(var1);

  if(var8) {
    var9 = cos(75);
    var10 = scripts\engine\utility::within_fov(var0 getEye(), var0 getplayerangles(1), var1.origin + (0, 0, 40), var9);

    if(!var10) {
      return false;
    }

    var11 = sighttracepassed(var0 getEye(), var1 getEye(), 0, var0, var4);

    if(!var11) {
      return false;
    }

    var12 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var0 getEye(), var1 getEye(), var0, var12)) {
      return false;
    }

    var13 = scripts\engine\math::get_dot(var0.origin, anglesToForward(var0.angles), var1.origin);
    var5 = 1;

    if(var13 >= 0.573576) {
      var5 -= 0.34;
    }

    if(var4) {
      var5 -= 0.34;
    }

    var14 = var1 getstance();

    if(var3 <= int(350 / var5)) {
      if(var14 == "prone") {
        return false;
      }

      return true;
    } else if(var3 <= int(500 / var5)) {
      if(var14 == "prone") {
        return false;
      }

      return true;
    } else if(var3 <= int(950 / var5)) {
      if(var14 == "prone" || var14 == "crouch") {
        return false;
      }

      return true;
    }
  }

  return false;
}

function alert_all_nearby_enemies(var0, var1, var2, var3) {
  if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
    toggleweaponsfree(1);
  }

  var4 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  var3 = istrue(var3);

  foreach(var6 in var4) {
    if(!isDefined(var6) || var6 == self) {
      continue;
    }

    if(!isDefined(var6.agent_type) || isDefined(var6.agent_type) && var6.agent_type != "soldier_agent") {
      continue;
    }

    if(!var3 && isDefined(var0) && distance2dsquared(self.origin, var6.origin) > var0) {
      continue;
    }

    if(!istrue(var6.scripted_mode)) {
      continue;
    }

    if(var6.team != self.team) {
      continue;
    }

    if(!istrue(var2) && istrue(var6.posted)) {
      continue;
    }

    var6 notify("alerted_by_soldier");
  }
}

function debug_patrol_point_score_loop() {
  if(!scripts\engine\utility::flag_exist("patrolPoints_initialized")) {
    return;
  }

  scripts\engine\utility::flag_wait("patrolPoints_initialized");

  for(;;) {
    var0 = getdvarint("scr_patrol_point_debug", 0);
    var1 = getdvarint("scr_patrol_point_iso_debug", 0);

    if(var0 != 0 && isDefined(level.players[0])) {
      var2 = [];

      if(var0 == 1) {
        var2 = level.allzpatrolpoints;
      } else if(var0 == 2) {
        var2 = level.allspatrolpoints;
      }

      var3 = sortbydistance(var2, level.players[0].origin);
      var4 = 0;

      foreach(var6 in var3) {
        if(var1 > 0) {
          if(var6.id != var1) {
            goto LOC_0000016c;
          }
        }

        if(isDefined(var6.patrolscore)) {
          if(isDefined(var6.target)) {
            var7 = scripts\engine\utility::getStructArray(var6.target, "targetname");

            if(var7.size >= 1) {
              foreach(var9 in var7) {
                thread scripts\engine\utility::draw_line_for_time(var6.origin, var9.origin, 1, 0, 0, 0.1);
              }
            } else {
              thread scripts\engine\utility::draw_line_for_time(var6.origin, var6.origin + (0, 0, 128), 1, 1, 0, 0.1);
            }
          }

          thread debug_patrol_point_score(level, var6);
          var4++;
        }
      }
    }

    wait 0.1;
  }
}

function debug_patrol_point_score(var0, var1) {
  var2 = 0;
  var3 = 125;
  var4 = 300;
  var5 = 500;
  var6 = var0.patrolscore;

  if(var6 <= 0) {
    scripts\cp\utility::drawsphere(var0.origin, 20, var1, (1, 1, 1));
    return;
  }

  if(var6 <= var3) {
    scripts\cp\utility::drawsphere(var0.origin, 20, var1, (0, 1, 0));
    return;
  }

  if(var6 <= var4) {
    scripts\cp\utility::drawsphere(var0.origin, 20, var1, (1, 1, 0));
    return;
  }

  scripts\cp\utility::drawsphere(var0.origin, 20, var1, (1, 0, 0));
}
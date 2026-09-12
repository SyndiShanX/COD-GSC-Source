/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_stealth_zombie.gsc
***********************************************/

function scriptagentstealth_init() {
  scripts\engine\utility::flag_init("fake_stealth_paused");
  load_stealth_values_from_table();
  level.const_cos60 = cos(65);
  level.current_escalation_level = 0;
  level.maxescalationvalue = level.zombie_stealth_values.size;
  level.nearbyposarray = [];
}

function isgroundspawner(var_0) {
  if(isDefined(var_0.spawner) && isDefined(var_0.spawner.script_parameters) && (var_0.spawner.script_parameters == "ground_spawn_no_boards" || var_0.spawner.script_parameters == "ground_spawn")) {
    return 1;
  }

  return 0;
}

function zombiescriptedstealth(var_0, var_1) {
  var_0 notify("zombieScriptedStealth");
  var_0 endon("zombieScriptedStealth");
  var_0 endon("death");
  var_0 endon("exit_stealth");
  level endon("game_ended");

  for(;;) {
    var_0.ignoreall = 1;
    var_0.scripted_mode = 1;
    var_0.scriptedstealth = 1;
    fake_stealth_funcs(var_0, var_1);
    var_2 = var_0 scripts\engine\utility::ref_143AF("alerted", "damage", "reset_stealth", "alerted_by_ai");

    if(!isDefined(var_2) || var_2 == "reset_stealth") {
      continue;
    }

    var_0.forcedpatrol = undefined;
    var_0.scriptedstealth = undefined;

    if(var_2 == "alerted" || var_2 == "damage") {
      foreach(var_4 in scripts\engine\utility::get_array_of_closest(var_0.origin, level.spawned_enemies, [var_0], undefined, getzombiestealthvalues(var_0).propdistance, 0)) {
        if(var_4.agent_type != var_0.agent_type) {
          continue;
        }

        if(var_4.team != var_0.team) {
          continue;
        }

        if(var_4 != var_0) {
          var_4 notify("alerted");
        }
      }
    }

    if(var_2 == "alerted") {
      setstealthstate("spotted");
    } else if(var_2 == "damage") {
      setstealthstate("took damage");
    }

    chaseplayerthenreverttostealth(var_0);
  }
}

function chaseplayerthenreverttostealth(var_0) {
  var_0 endon("death");

  if(isDefined(var_0.og_goalradius)) {
    var_0.goalradius = var_0.og_goalradius;
  }

  var_0 setgoalpos(var_0.origin);
  var_0.ignoreall = 0;
  var_0.scripted_mode = 0;
  var_0.dont_cleanup = undefined;
  var_0.fake_stealth = 0;
  var_0.legacy.movemode = "sprint";
  var_1 = getzombiestealthvalues(var_0).timehiddennolosbeforedeescalate;
  var_2 = 0;
  var_3 = getzombiestealthvalues(var_0).distancebeforedeescalate;
  var_4 = 0.5;

  while(var_2 < var_1) {
    var_5 = 0;
    var_6 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var_0.team));

    foreach(var_8 in var_6) {
      if(istrue(var_8.ignoreme)) {
        continue;
      }

      if(isenemynearby(var_0, var_8, 0, 0)) {
        var_2 = 0;
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      var_2 += var_4;
    }

    wait var_4;
  }
}

function getstealthstate() {
  if(isDefined(self.patrol_state)) {
    return self.patrol_state;
  }

  return undefined;
}

function setstealthstate(var_0) {
  self.patrol_state = var_0;
  self notify("stealth_state_changed");
}

function fake_stealth_funcs(var_0) {
  set_stealth_values(self, int(level.current_escalation_level));
  thread setambientmovespeed(self, var_0);
  thread whizby_listener(self);
  thread grenade_listener(self);
  thread environment_listener(self);
  thread player_nearby_listener(self);
  thread player_weapon_listener(self);
  thread move_speed_monitor(self);
  thread stealth_patrol(self.origin);
  self.fake_stealth = 1;
  self notify("fake_stealth_set");
}

function setambientmovespeed(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");

  if(istrue(var_1)) {
    wait 0.15;
  }

  var_2 = strtok(var_0.stealthvals.zombiemovespeed, ",");
  var_3 = scripts\engine\utility::random(var_2);
  var_0.legacy.movemode = var_3;
  setstealthmovespeed(var_0, var_0, var_3);
}

function setstealthmovespeed(var_0, var_1) {
  var_0 scripts\asm\asm_bb::bb_requestmovetype(var_1);
}

function move_speed_monitor(var_0) {
  var_0 notify("move_speed_monitor");
  var_0 endon("move_speed_monitor");
  var_0 endon("alerted");
  var_0 endon("alerted_by_ai");
  var_0 endon("exit_stealth");
  var_0 endon("death");
  var_0 endon("new_goal");

  for(;;) {
    if(istrue(var_0.scriptedstealth)) {
      var_1 = strtok(getzombiestealthvalues(var_0).zombiemovespeed, ",");
      var_2 = scripts\engine\utility::random(var_1);
      setstealthmovespeed(var_0, var_0, var_2);
    }

    scripts\engine\utility::waittill_any_ents(var_0, "stealth_values_set", level, "runSpawnModule");
  }
}

function whizby_listener(var_0) {
  var_0 notify("whizby_listener");
  var_0 endon("whizby_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");

  for(;;) {
    var_0 waittill("bulletwhizby", var_1);

    if(istrue(var_1.ignoreme)) {
      continue;
    }

    if(isagent(var_1)) {
      setstealthstate(var_0, "spotted");
      var_0 playSound("zmb_vo_cop_pain");
      var_0 notify("alerted_by_ai");
      continue;
    }

    if(istrue(var_0.scriptedstealth)) {
      thread go_to_spot(var_0, var_0, var_1.origin, undefined);
    }
  }
}

function environment_listener(var_0) {
  var_0 notify("environment_listener");
  var_0 endon("environment_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");
  var_0 endon("new_goal");

  for(;;) {
    level waittill("environment_alert", var_1);

    if(!istrue(var_0.scriptedstealth)) {
      continue;
    }

    if(distance(var_0.origin, var_1) > 650) {
      continue;
    }

    thread go_to_spot(var_0, var_0, var_1, undefined);
  }
}

function grenade_listener(var_0) {
  var_0 notify("grenade_listener");
  var_0 endon("grenade_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");
  var_0 endon("new_goal");

  for(;;) {
    var_0 waittill("explode", var_1);

    if(!istrue(var_0.scriptedstealth)) {
      continue;
    }

    if(distance(var_0.origin, var_1) > 1500) {
      continue;
    }

    thread go_to_spot(var_0, var_0, var_1, undefined);
  }
}

function enemynearbylistener(var_0) {
  level endon("game_ended");
  var_0 notify("enemyNearbyListener");
  var_0 endon("enemyNearbyListener");
  var_0 endon("alerted");
  var_0 endon("death");
  var_0 endon("exit_stealth");

  for(;;) {
    if(istrue(var_0.scriptedstealth)) {
      var_1 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var_0.team));

      foreach(var_3 in var_1) {
        if(istrue(var_3.ignoreme)) {
          continue;
        }

        isenemynearby(var_0, var_3, 0, 1);
      }
    }

    wait 0.1;
  }
}

function player_nearby_listener(var_0) {
  level endon("game_ended");
  var_0 notify("player_nearby_listener");
  var_0 endon("player_nearby_listener");
  var_0 endon("alerted");
  var_0 endon("death");
  var_0 endon("exit_stealth");

  for(;;) {
    if(istrue(var_0.scriptedstealth)) {
      var_1 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var_0.team));

      foreach(var_3 in var_1) {
        if(istrue(var_3.ignoreme)) {
          continue;
        }

        isenemynearby(var_0, var_3, 1, 1);
      }
    }

    wait 0.1;
  }
}

function setandunsetzombieignoreme(var_0, var_1) {
  var_0 notify("setAndUnsetZombieIgnoreMe");
  var_0 endon("setAndUnsetZombieIgnoreMe");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "fake_stealth_set", var_1, "death");
}

function alertzombie(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    if(var_2) {
      var_0.spottedplayer = var_1;
      setstealthstate(var_0, "spotted");
      show_spotted_text(var_1);
      var_0 playsoundtoplayer("zmb_vo_cop_pain", var_1);
      thread setandunsetzombieignoreme(var_1, var_1);
    }

    var_0 notify("alerted");
    return;
  }

  setstealthstate(var_0, "spotted");
  var_0 playSound("zmb_vo_cop_pain");
  var_0 notify("alerted_by_ai");
}

function isenemynearby(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return false;
  }

  var_4 = isPlayer(var_1);
  var_5 = getzombiestealthvalues(var_0);
  var_6 = var_5.losfov;
  var_7 = distance(var_1.origin, var_0.origin);
  var_0.spottedplayer = undefined;
  var_2 = istrue(var_2);
  var_8 = var_0 getplayerangles(1);
  var_9 = istrue(var_5.canseethroughfoliage);

  if(var_4) {
    if(!var_1 scripts\cp\utility::is_valid_player()) {
      return false;
    }

    if(isDefined(var_1.skill_data)) {
      var_7 *= var_1.skill_data["stealth"].stealth_dist_scalar;
    }
  }

  if(var_7 < 96) {
    if(vectordot(var_8, vectorNormalize(var_1.origin - var_0.origin)) > 0) {
      alertzombie(var_0, var_1, var_2);
      return true;
    }
  }

  var_10 = var_0 cansee(var_1) && sighttracepassed(var_0 getEye(), var_1.origin, 0, var_0, var_9);

  if(var_10 || istrue(level.skipstealthcanseecheck)) {
    var_11 = scripts\engine\math::get_dot(var_0.origin, var_8, var_1.origin);

    if(var_11 < 0.573576 && !istrue(level.skipstealthcanseecheck)) {
      var_0.spottedplayer = undefined;
      return false;
    }

    var_3 = istrue(var_3);
    var_12 = var_1 getstance();
    var_13 = 1;
    var_14 = 1;
    var_15 = var_1 getvelocity();
    var_16 = length(var_15);

    if(var_16 < 128) {
      var_13 = 0.75;
    } else if(var_16 < 200 || var_4 && var_1.skill_data["stealth"].stealth_velocity_override) {
      var_13 = 1;
    } else {
      var_13 = 1.25;
    }

    if(var_12 == "stand" && var_7 <= int(var_5.standdetectdist * var_11 * var_13 * var_14) && (!var_3 || canpathtotarget(var_0, var_1.origin))) {
      alertzombie(var_0, var_1, var_2);
      return true;
    } else if(var_12 == "crouch" && var_7 <= int(var_5.crouchdetectdist * var_11 * var_13 * var_14) && (!var_3 || canpathtotarget(var_0, var_1.origin))) {
      alertzombie(var_0, var_1, var_2);
      return true;
    } else if(var_12 != "prone" && var_7 <= int(var_5.pronedetectdist * var_11 * var_13 * var_14) && (!var_3 || canpathtotarget(var_0, var_1.origin))) {
      alertzombie(var_0, var_1, var_2);
      return true;
    } else {
      var_0.spottedplayer = undefined;
      return false;
    }
  } else {
    var_0.spottedplayer = undefined;
    return false;
  }

  var_0.spottedplayer = undefined;
  return false;
}

function canpathtotarget(var_0, var_1) {
  if(!isDefined(level.findpathcount)) {
    level.findpathcount = 1;
  }

  level.findpathcount += 1;
  var_2 = istrue(var_0.skiptraversals);
  var_3 = var_0 findpath(var_0.origin, var_1, 0, var_2);

  if(var_3.size >= 1 && distance(var_3[var_3.size - 1], var_1) <= 64) {
    return 1;
  }

  return 0;
}

function stealth_patrol(var_0) {
  var_1 = self;
  var_1 notify("stealth_patrol");
  var_1 endon("stealth_patrol");
  var_1 endon("death");
  var_1 endon("alerted");
  var_1 endon("alerted_by_ai");
  var_1 endon("new_goal");
  var_1.og_goalradius = var_1.goalradius;

  if(!istrue(var_1.fake_stealth)) {
    var_1 waittill("fake_stealth_set");
  }

  if(!isDefined(var_0)) {
    var_0 = var_1.origin;
  }

  setstealthstate(var_1, "patrol");
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    var_4 = undefined;

    if(isDefined(var_1.patrol_state) && var_1.patrol_state != "patrol") {
      var_1.waitingforstealthstatechange = 1;
      var_1 waittill("stealth_state_changed");
      var_1.waitingforstealthstatechange = undefined;
      continue;
    }

    if(istrue(var_1.scriptedstealth)) {
      if(isDefined(var_1.forcedpatrol)) {
        var_5 = getclosestpointonnavmesh(var_1.forcedpatrol.origin);

        if(isDefined(var_2)) {
          var_3 = var_2;
        }

        var_2 = var_1.forcedpatrol;
        thread scripts\cp\cp_agent_patrol::setcooldown(var_1.forcedpatrol, 20);
        thread removeifalerted(var_1, var_1.forcedpatrol);
        _setgoalpos(var_1, var_5, 32);
        scripts\cp\cp_agent_patrol::unsetcooldown(var_1.forcedpatrol);
        var_1.forcedpatrol = undefined;
      } else {
        var_6 = scripts\engine\utility::get_array_of_closest(var_1.origin, level.allzpatrolpoints, undefined, 10);
        var_6 = getscoredpatrolpoints(var_1, var_1, var_6, [var_2, var_3], "generic_zombie");

        if(isDefined(var_6)) {
          foreach(var_8 in var_6) {
            var_5 = getclosestpointonnavmesh(var_8.origin);

            if(distance(var_8.origin, var_5) <= 40 && canpathtotarget(var_1, var_5)) {
              if(isDefined(var_2)) {
                var_3 = var_2;
              }

              var_2 = var_8;
              thread scripts\cp\cp_agent_patrol::setcooldown(var_8, 20);
              thread removeifalerted(var_1, var_8);
              _setgoalpos(var_1, var_5, 32);
              scripts\cp\cp_agent_patrol::unsetcooldown(var_8);
              break;
            }

            var_2 = undefined;
            var_3 = undefined;
          }
        } else {
          var_2 = undefined;
          var_3 = undefined;
        }
      }
    }

    if(randomint(100) < 20) {
      wait randomfloatrange(2.5, 5);
    }
  }
}

function removeifalerted(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("goal_reached");
  var_0 endon("goal");
  var_0 endon("stalled");
  var_0 scripts\engine\utility::ref_143A6("death", "alerted", "alerted_by_ai");
  scripts\cp\cp_agent_patrol::unsetcooldown(var_1);
}

function cooldownpatrolpoint(var_0) {
  level endon("game_ended");
  var_0.cooldown = 1;
  wait 20;
  var_0.cooldown = undefined;
}

function getscoredpatrolpoints(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = level.allspatrolpoints;
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = scripts\engine\utility::array_removeundefined(var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = "soldier_agent";
  }

  var_4 = 25;
  var_5 = scripts\cp\cp_agent_utils::getactiveagentsoftype(var_3);
  var_6 = sortbydistance(scripts\engine\utility::array_remove_array(var_1, var_2), var_0.origin);
  var_7 = [];
  var_8 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_5, undefined, 4, 256).size >= 3;
  var_9 = 5 / var_4;
  var_10 = 20 / var_4;

  foreach(var_12 in var_6) {
    var_13 = var_12.patrolscore;
    var_12.personalscore = 0;
    var_14 = 250;
    var_15 = distance(var_0.origin, var_12.origin);

    if(var_8 && var_15 <= 500) {
      var_14 = 500;
    } else if(var_15 >= 1500) {
      var_14 = 500;
    } else {
      var_16 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_12.origin);

      if(isDefined(var_12.target)) {
        var_17 = scripts\engine\utility::getStructArray(var_12.target, "targetname");

        if(var_17.size > 1) {
          var_18 = var_10 * 500;
          var_14 -= var_18;
        }

        var_19 = var_9 * 500;
        var_14 = var_19 * var_16;
      } else {
        var_14 = 500 * var_16;
      }
    }

    var_14 = clamp(var_14, 0, 500);
    var_14 = clamp(var_14 + var_13, 0, 999);
    var_12.personalscore = int(var_14);
    var_7 = var_12;
  }

  var_21 = scripts\cp\utility::array_sort_by_handler(var_7, &getpersonalpatrolscore);
  return var_21;
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

function go_to_spot(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("alerted_by_ai");
  var_0 endon("exit_stealth");
  var_4 = getclosestpointonnavmesh(var_1);

  if(distance(var_4, var_1) <= 32 && canpathtotarget(var_0, var_4)) {
    var_0 notify("new_goal");
    var_0 endon("new_goal");
    setstealthstate(var_0, var_3);
    resetgoalpos(var_0);

    if(!isDefined(var_0.legacy)) {
      iprintln("** - LEGACY IS UNDEFINED FOR : " + var_0 getentitynumber() + ", health: " + var_0.health + ", agent: " + var_0.agent_type);
      var_0.legacy = spawnStruct();
    }

    if(isDefined(var_2)) {
      var_0.legacy.movemode = var_2;
    } else {
      var_0.legacy.movemode = "sprint";
    }

    _setgoalpos(var_0, var_4, 32);
    var_0.legacy.movemode = "slow_walk";
    wait getzombiestealthvalues(var_0).timehiddennolosbeforedeescalate;
    var_0 notify("reset_stealth");
    return;
  }
}

function weapon_fire_monitor() {
  self notify("weapon_fire_monitor");
  self endon("weapon_fire_monitor");
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_fired");
    level notify("weapon_fired", self.origin, self getcurrentweapon(), self);
  }
}

function player_weapon_listener(var_0) {
  var_0 notify("player_weapon_listener");
  var_0 endon("player_weapon_listener");
  var_0 endon("death");
  var_0 endon("alerted");
  var_0 endon("exit_stealth");

  for(;;) {
    level waittill("weapon_fired", var_1, var_2, var_3, var_4);

    if(!istrue(var_0.scriptedstealth)) {
      continue;
    }

    if(isPlayer(var_3)) {
      var_5 = 2000 * var_3.skill_data["stealth"].stealth_weapon_noise_scalar;
    } else {
      var_5 = 2000;
    }

    foreach(var_7 in var_2.attachments) {
      if(issubstr(var_7, "silencer")) {
        var_5 *= 0.75;
        break;
      }
    }

    var_5 = int(var_5);

    if(distance(var_1, var_0.origin) > var_5) {
      continue;
    }

    thread go_to_spot(var_0, var_0, var_1, undefined);
    wait 0.5;
  }
}

function zombie_3dtext_handler() {
  self endon("death");
  self notify("texthandler");
  self endon("texthandler");
  var_0 = self getentitynumber();

  for(;;) {
    if(getDvar("stealth_show_states") == "") {
      level waittill("show_stealth_states");
    }

    if(isDefined(self.patrol_state)) {}

    waitframe();
  }
}

function draw_fov() {
  self endon("death");
  self notify("draw_fov");
  self endon("draw_fov");

  for(;;) {
    if(getDvar("stealth_show_los") == "") {
      wait 1;
      continue;
    }

    var_0 = self gettagorigin("tag_eye");
    var_1 = self gettagangles("tag_eye");
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * self.stealthvals.standdetectdist;
    waitframe();
  }
}

function load_stealth_values_from_table() {
  level.zombie_stealth_values = [];

  if(isDefined(level.zombie_stealth_table)) {
    var_0 = level.zombie_stealth_table;
  } else {
    var_0 = "scripts/cp/zombie_stealth.csv";
  }

  var_1 = 1;
  var_2 = 1;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, var_1);

    if(var_3 == "") {
      break;
    }

    var_4 = spawnStruct();
    var_4.standdetectdist = int(tablelookupbyrow(var_0, 2, var_1));
    var_4.crouchdetectdist = int(tablelookupbyrow(var_0, 3, var_1));
    var_4.pronedetectdist = int(tablelookupbyrow(var_0, 4, var_1));
    var_4.hiddenstanddetectdist = int(tablelookupbyrow(var_0, 5, var_1));
    var_4.hiddencrouchdetectdist = int(tablelookupbyrow(var_0, 6, var_1));
    var_4.hiddenpronedetectdist = int(tablelookupbyrow(var_0, 7, var_1));
    var_4.propdistance = int(tablelookupbyrow(var_0, 8, var_1));
    var_4.timebeforeescalate = int(tablelookupbyrow(var_0, 9, var_1));
    var_4.timebeforedeescalate = int(tablelookupbyrow(var_0, 10, var_1));
    var_4.distancebeforedeescalate = int(tablelookupbyrow(var_0, 11, var_1));
    var_4.timehiddennolosbeforedeescalate = int(tablelookupbyrow(var_0, 12, var_1));
    var_4.zombiemovespeed = tablelookupbyrow(var_0, 13, var_1);
    var_4.playerstandmovedist = int(tablelookupbyrow(var_0, 14, var_1));
    var_4.playercrouchmovedist = int(tablelookupbyrow(var_0, 15, var_1));
    var_4.playerpronemovedist = int(tablelookupbyrow(var_0, 16, var_1));
    var_4.hiddenplayerstandmovedist = int(tablelookupbyrow(var_0, 17, var_1));
    var_4.hiddenplayercrouchmovedist = int(tablelookupbyrow(var_0, 18, var_1));
    var_4.hiddenplayerpronemovedist = int(tablelookupbyrow(var_0, 19, var_1));
    var_4.playermovedistlerptime = int(tablelookupbyrow(var_0, 20, var_1));
    var_4.losfov = cos(int(tablelookupbyrow(var_0, 21, var_1)));
    var_4.canseethroughfoliage = cos(int(tablelookupbyrow(var_0, 22, var_1)));
    level.zombie_stealth_values[int(var_3)] = var_4;
    var_1++;
  }
}

function set_stealth_values(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 = int(clamp(var_1, 0, level.maxescalationvalue - 1));
  }

  var_1 = int(max(var_1, 0));
  var_2 = spawnStruct();
  var_2.currentstealthlevel = int(var_1);
  var_2.standdetectdist = level.zombie_stealth_values[var_1].standdetectdist;
  var_2.crouchdetectdist = level.zombie_stealth_values[var_1].crouchdetectdist;
  var_2.pronedetectdist = level.zombie_stealth_values[var_1].pronedetectdist;
  var_2.hiddenstanddetectdist = level.zombie_stealth_values[var_1].hiddenstanddetectdist;
  var_2.hiddencrouchdetectdist = level.zombie_stealth_values[var_1].hiddencrouchdetectdist;
  var_2.hiddenpronedetectdist = level.zombie_stealth_values[var_1].hiddenpronedetectdist;
  var_2.propdistance = level.zombie_stealth_values[var_1].propdistance;
  var_2.timebeforeescalate = level.zombie_stealth_values[var_1].timebeforeescalate;
  var_2.timebeforedeescalate = level.zombie_stealth_values[var_1].timebeforedeescalate;
  var_2.distancebeforedeescalate = level.zombie_stealth_values[var_1].distancebeforedeescalate;
  var_2.timehiddennolosbeforedeescalate = level.zombie_stealth_values[var_1].timehiddennolosbeforedeescalate;
  var_2.zombiemovespeed = level.zombie_stealth_values[var_1].zombiemovespeed;
  var_2.playerstandmovedist = level.zombie_stealth_values[var_1].playerstandmovedist;
  var_2.playercrouchmovedist = level.zombie_stealth_values[var_1].playercrouchmovedist;
  var_2.playerpronemovedist = level.zombie_stealth_values[var_1].playerpronemovedist;
  var_2.hiddenplayerstandmovedist = level.zombie_stealth_values[var_1].hiddenplayerstandmovedist;
  var_2.hiddenplayercrouchmovedist = level.zombie_stealth_values[var_1].hiddenplayercrouchmovedist;
  var_2.hiddenplayerpronemovedist = level.zombie_stealth_values[var_1].hiddenplayerpronemovedist;
  var_2.playermovedistlerptime = level.zombie_stealth_values[var_1].playermovedistlerptime;
  var_2.losfov = level.zombie_stealth_values[var_1].losfov;
  var_2.canseethroughfoliage = level.zombie_stealth_values[var_1].canseethroughfoliage;
  var_0.stealthvals = var_2;
  setzombiestate(var_0, var_1);
  var_0 notify("stealth_values_set");
}

function setzombiestate(var_0, var_1) {
  var_2 = level.maxescalationvalue;

  switch (var_1) {
    case 10:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 9:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 8:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 7:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 6:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 5:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "active");
      break;
    case 4:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "active");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 3:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "active");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 2:
      var_0 setscriptablepartstate("burning", "active");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    case 1:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "active");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
    default:
      var_0 setscriptablepartstate("burning", "inactive");
      var_0 setscriptablepartstate("arcane_white", "inactive");
      var_0 setscriptablepartstate("chemburn", "inactive");
      var_0 setscriptablepartstate("corrosive", "inactive");
      var_0 setscriptablepartstate("shocked", "inactive");
      var_0 setscriptablepartstate("pet", "inactive");
      break;
  }
}

function show_spotted_text(var_0) {
  if(!isDefined(var_0.last_spotted_vo) || gettime() >= var_0.last_spotted_vo + 5000) {
    var_0.last_spotted_vo = gettime();

    if(!istrue(level.disable_you_spotted_message)) {
      var_0 iprintlnbold("You've been spotted!");
      return;
    }

    return;
  }
}

function increasecurrentstealthvalue(var_0) {
  if(isDefined(var_0.stealthvals) && isDefined(var_0.stealthvals.currentstealthlevel)) {
    var_1 = clamp(var_0.stealthvals.currentstealthlevel + 1, 0, level.maxescalationvalue - 1);
    set_stealth_values(var_0, int(var_1));
    return;
  }
}

function decreasecurrentstealthvalue(var_0) {
  if(isDefined(var_0.stealthvals) && isDefined(var_0.stealthvals.currentstealthlevel)) {
    var_1 = clamp(var_0.stealthvals.currentstealthlevel - 1, 0, level.maxescalationvalue - 1);
    set_stealth_values(var_0, int(var_1));
    return;
  }
}

function getzombiestealthvalues(var_0) {
  if(isDefined(var_0.stealthvals)) {
    return var_0.stealthvals;
  }

  return undefined;
}

function monitorzawarenesslevel(var_0) {
  var_0 notify("monitorZAwarenessLevel");
  var_0 endon("monitorZAwarenessLevel");
  level endon("game_ended");
  level endon("disable_zombie_scripted_stealth");
  var_0 endon("disconnect");
  var_0.zombieawarenesslevel = 0;
  var_1 = 100;
  var_2 = 0;

  for(;;) {
    if(scripts\engine\utility::flag("track_player_movement")) {
      if(var_0 scripts\cp\utility::is_valid_player()) {
        var_3 = var_0 getvelocity();
        var_4 = length(var_3);

        if(var_4 < 64) {
          var_2 += 2;
        } else if(var_4 > 64 && var_4 < 128) {
          var_2 += 1;
        } else if(var_4 > 350) {
          var_2 -= 10;
        } else if(var_4 > 200) {
          var_2 -= 5;
        }

        var_2 = clamp(var_2, 0, var_1);

        if(var_2 >= var_1) {
          thread sendzombiehorde(var_0);
          var_2 = 0;
          wait 10;
        }
      }
    }

    wait 0.25;
  }
}

function sendzombiehorde(var_0) {
  if(istrue(var_0.ignoreme)) {
    return;
  }

  var_1 = scripts\cp\cp_agent_utils::getactiveagentsoftype("generic_zombie");
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = 10;
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(istrue(var_6.fake_stealth)) {
      var_7 = getstealthstate(var_6);

      if(isDefined(var_7) && var_7 == "patrol") {
        thread go_to_spot(var_6, var_6, var_0.origin, "run");
        var_4++;

        if(var_4 >= var_3) {
          break;
        }
      }
    }
  }

  var_4 = undefined;
  var_6 = undefined;
}

function spawn_ambient_zombie(var_0) {
  var_1 = undefined;

  if(!isDefined(var_1)) {
    return false;
  }

  if(!isDefined(var_1.script_parameters)) {
    var_1.script_parameters = "ground_spawn_no_boards";
  }

  if(var_1.script_parameters != "ground_spawn_no_boards") {
    iprintlnbold("bad spawn");
  }

  var_2 = var_1[[level.spawn_wave_enemy_func]]("generic_zombie", 1, var_1);

  if(isDefined(var_2)) {
    if(istrue(var_0.skiptraversals)) {
      var_2.skiptraversals = 1;
    }

    if(istrue(var_0.dontkilloff)) {
      var_2.dontkilloff = 1;
    }

    if(isDefined(var_1.target)) {
      var_2.forcedpatrol = scripts\engine\utility::random(scripts\engine\utility::getStructArray(var_1.target, "targetname"));
    }

    if(isDefined(var_0.threatbiasoverride)) {
      var_2.threatbiasoverride = var_0.threatbiasoverride;
    }

    var_1.lastspawntime = gettime();
    var_2.killofftime = gettime() + 10000;
    var_2 emissiveblend(1, 0.1);
    thread default_ambient_vals(var_2, var_2, var_0);
    return true;
  }

  return false;
}

function default_ambient_vals(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.iszombie = 1;
  var_0.dont_scriptkill = 1;
  var_0.dont_cleanup = 1;
  var_0.enemy_group = var_1.group_name;
  var_0.moduleid = var_1.moduleid;
  var_0.group = var_1;
  var_0.group.activecount++;
  var_3 = getdvarint("scr_infected_health", 160);
  var_0.maxhealth = var_3;
  var_0.health = var_3;
  activatezombiestealth(var_0, var_2);
}

function updatezombiegroupname(var_0, var_1) {
  var_0.enemy_group = var_1.group_name;
}

function activatezombiestealth(var_0, var_1) {
  thread zombiescriptedstealth(var_0, var_0);
}

function _setgoalpos(var_0, var_1, var_2) {
  var_0 notify("set_goal_pos_requested");
  var_0 endon("set_goal_pos_requested");
  var_0 endon("death");
  var_0 endon("stalled");

  if(isDefined(var_2)) {
    var_0.goalradius = var_2;
  } else {
    var_0.goalradius = 32;
  }

  var_3 = 0;

  foreach(var_5 in level.nearbyposarray) {
    if(distance(var_5, var_1) <= 32) {
      var_3 = 1;
      break;
    }
  }

  var_7 = 1;

  if(var_3) {
    var_8 = getrandomnavpoints(var_1, 128, 10, undefined, getrandomnavpoint(var_1, 64), 128);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_7 = 0;

      foreach(var_5 in level.nearbyposarray) {
        if(distance(var_5, var_11) <= 32) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1 = var_11;
        break;
      }
    }
  }

  thread manageposarray(var_0, var_1);
  var_0 setgoalpos(var_1);
  var_15 = var_0 scripts\engine\utility::ref_143AD("goal", "goal_reached");
}

function manageposarray(var_0, var_1) {
  level.nearbyposarray[level.nearbyposarray.size] = var_1;
  var_2 = var_0 scripts\engine\utility::waittill_any_in_array_return(["death", "set_goal_pos_requested", "alerted", "exit_stealth", "new_goal", "alerted_by_ai"]);

  if(scripts\engine\utility::array_contains(level.nearbyposarray, var_1)) {
    level.nearbyposarray = scripts\engine\utility::array_remove(level.nearbyposarray, var_1);
    return;
  }
}

function resetgoalpos(var_0) {
  var_0 setgoalpos(self.origin);
  var_0 scripts\engine\utility::ref_143A5("goal", "goal_reached");
}
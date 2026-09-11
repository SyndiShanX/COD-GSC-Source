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

function isgroundspawner(var0) {
  if(isDefined(var0.spawner) && isDefined(var0.spawner.script_parameters) && (var0.spawner.script_parameters == "ground_spawn_no_boards" || var0.spawner.script_parameters == "ground_spawn")) {
    return 1;
  }

  return 0;
}

function zombiescriptedstealth(var0, var1) {
  var0 notify("zombieScriptedStealth");
  var0 endon("zombieScriptedStealth");
  var0 endon("death");
  var0 endon("exit_stealth");
  level endon("game_ended");

  for(;;) {
    var0.ignoreall = 1;
    var0.scripted_mode = 1;
    var0.scriptedstealth = 1;
    fake_stealth_funcs(var0, var1);
    var2 = var0 scripts\engine\utility::ref_143af("alerted", "damage", "reset_stealth", "alerted_by_ai");

    if(!isDefined(var2) || var2 == "reset_stealth") {
      continue;
    }

    var0.forcedpatrol = undefined;
    var0.scriptedstealth = undefined;

    if(var2 == "alerted" || var2 == "damage") {
      foreach(var4 in scripts\engine\utility::get_array_of_closest(var0.origin, level.spawned_enemies, [var0], undefined, getzombiestealthvalues(var0).propdistance, 0)) {
        if(var4.agent_type != var0.agent_type) {
          continue;
        }

        if(var4.team != var0.team) {
          continue;
        }

        if(var4 != var0) {
          var4 notify("alerted");
        }
      }
    }

    if(var2 == "alerted") {
      setstealthstate("spotted");
    } else if(var2 == "damage") {
      setstealthstate("took damage");
    }

    chaseplayerthenreverttostealth(var0);
  }
}

function chaseplayerthenreverttostealth(var0) {
  var0 endon("death");

  if(isDefined(var0.og_goalradius)) {
    var0.goalradius = var0.og_goalradius;
  }

  var0 setgoalpos(var0.origin);
  var0.ignoreall = 0;
  var0.scripted_mode = 0;
  var0.dont_cleanup = undefined;
  var0.fake_stealth = 0;
  var0.legacy.movemode = "sprint";
  var1 = getzombiestealthvalues(var0).timehiddennolosbeforedeescalate;
  var2 = 0;
  var3 = getzombiestealthvalues(var0).distancebeforedeescalate;
  var4 = 0.5;

  while(var2 < var1) {
    var5 = 0;
    var6 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var0.team));

    foreach(var8 in var6) {
      if(istrue(var8.ignoreme)) {
        continue;
      }

      if(isenemynearby(var0, var8, 0, 0)) {
        var2 = 0;
        var5 = 1;
        break;
      }
    }

    if(!var5) {
      var2 += var4;
    }

    wait var4;
  }
}

function getstealthstate() {
  if(isDefined(self.patrol_state)) {
    return self.patrol_state;
  }

  return undefined;
}

function setstealthstate(var0) {
  self.patrol_state = var0;
  self notify("stealth_state_changed");
}

function fake_stealth_funcs(var0) {
  set_stealth_values(self, int(level.current_escalation_level));
  thread setambientmovespeed(self, var0);
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

function setambientmovespeed(var0, var1) {
  var0 endon("death");
  var0 endon("alerted");
  var0 endon("exit_stealth");

  if(istrue(var1)) {
    wait 0.15;
  }

  var2 = strtok(var0.stealthvals.zombiemovespeed, ",");
  var3 = scripts\engine\utility::random(var2);
  var0.legacy.movemode = var3;
  setstealthmovespeed(var0, var0, var3);
}

function setstealthmovespeed(var0, var1) {
  var0 scripts\asm\asm_bb::bb_requestmovetype(var1);
}

function move_speed_monitor(var0) {
  var0 notify("move_speed_monitor");
  var0 endon("move_speed_monitor");
  var0 endon("alerted");
  var0 endon("alerted_by_ai");
  var0 endon("exit_stealth");
  var0 endon("death");
  var0 endon("new_goal");

  for(;;) {
    if(istrue(var0.scriptedstealth)) {
      var1 = strtok(getzombiestealthvalues(var0).zombiemovespeed, ",");
      var2 = scripts\engine\utility::random(var1);
      setstealthmovespeed(var0, var0, var2);
    }

    scripts\engine\utility::waittill_any_ents(var0, "stealth_values_set", level, "runSpawnModule");
  }
}

function whizby_listener(var0) {
  var0 notify("whizby_listener");
  var0 endon("whizby_listener");
  var0 endon("death");
  var0 endon("alerted");
  var0 endon("exit_stealth");

  for(;;) {
    var0 waittill("bulletwhizby", var1);

    if(istrue(var1.ignoreme)) {
      continue;
    }

    if(isagent(var1)) {
      setstealthstate(var0, "spotted");
      var0 playSound("zmb_vo_cop_pain");
      var0 notify("alerted_by_ai");
      continue;
    }

    if(istrue(var0.scriptedstealth)) {
      thread go_to_spot(var0, var0, var1.origin, undefined);
    }
  }
}

function environment_listener(var0) {
  var0 notify("environment_listener");
  var0 endon("environment_listener");
  var0 endon("death");
  var0 endon("alerted");
  var0 endon("exit_stealth");
  var0 endon("new_goal");

  for(;;) {
    level waittill("environment_alert", var1);

    if(!istrue(var0.scriptedstealth)) {
      continue;
    }

    if(distance(var0.origin, var1) > 650) {
      continue;
    }

    thread go_to_spot(var0, var0, var1, undefined);
  }
}

function grenade_listener(var0) {
  var0 notify("grenade_listener");
  var0 endon("grenade_listener");
  var0 endon("death");
  var0 endon("alerted");
  var0 endon("exit_stealth");
  var0 endon("new_goal");

  for(;;) {
    var0 waittill("explode", var1);

    if(!istrue(var0.scriptedstealth)) {
      continue;
    }

    if(distance(var0.origin, var1) > 1500) {
      continue;
    }

    thread go_to_spot(var0, var0, var1, undefined);
  }
}

function enemynearbylistener(var0) {
  level endon("game_ended");
  var0 notify("enemyNearbyListener");
  var0 endon("enemyNearbyListener");
  var0 endon("alerted");
  var0 endon("death");
  var0 endon("exit_stealth");

  for(;;) {
    if(istrue(var0.scriptedstealth)) {
      var1 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var0.team));

      foreach(var3 in var1) {
        if(istrue(var3.ignoreme)) {
          continue;
        }

        isenemynearby(var0, var3, 0, 1);
      }
    }

    wait 0.1;
  }
}

function player_nearby_listener(var0) {
  level endon("game_ended");
  var0 notify("player_nearby_listener");
  var0 endon("player_nearby_listener");
  var0 endon("alerted");
  var0 endon("death");
  var0 endon("exit_stealth");

  for(;;) {
    if(istrue(var0.scriptedstealth)) {
      var1 = scripts\engine\utility::array_combine(level.players, scripts\cp\cp_agent_utils::getactiveenemyagents(var0.team));

      foreach(var3 in var1) {
        if(istrue(var3.ignoreme)) {
          continue;
        }

        isenemynearby(var0, var3, 1, 1);
      }
    }

    wait 0.1;
  }
}

function setandunsetzombieignoreme(var0, var1) {
  var0 notify("setAndUnsetZombieIgnoreMe");
  var0 endon("setAndUnsetZombieIgnoreMe");
  var0 endon("disconnect");
  level endon("game_ended");
  var2 = scripts\engine\utility::waittill_any_ents_return(var1, "fake_stealth_set", var1, "death");
}

function alertzombie(var0, var1, var2) {
  if(isPlayer(var1)) {
    if(var2) {
      var0.spottedplayer = var1;
      setstealthstate(var0, "spotted");
      show_spotted_text(var1);
      var0 playsoundtoplayer("zmb_vo_cop_pain", var1);
      thread setandunsetzombieignoreme(var1, var1);
    }

    var0 notify("alerted");
    return;
  }

  setstealthstate(var0, "spotted");
  var0 playSound("zmb_vo_cop_pain");
  var0 notify("alerted_by_ai");
}

function isenemynearby(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    return false;
  }

  var4 = isPlayer(var1);
  var5 = getzombiestealthvalues(var0);
  var6 = var5.losfov;
  var7 = distance(var1.origin, var0.origin);
  var0.spottedplayer = undefined;
  var2 = istrue(var2);
  var8 = var0 getplayerangles(1);
  var9 = istrue(var5.canseethroughfoliage);

  if(var4) {
    if(!var1 scripts\cp\utility::is_valid_player()) {
      return false;
    }

    if(isDefined(var1.skill_data)) {
      var7 *= var1.skill_data["stealth"].stealth_dist_scalar;
    }
  }

  if(var7 < 96) {
    if(vectordot(var8, vectorNormalize(var1.origin - var0.origin)) > 0) {
      alertzombie(var0, var1, var2);
      return true;
    }
  }

  var10 = var0 cansee(var1) && sighttracepassed(var0 getEye(), var1.origin, 0, var0, var9);

  if(var10 || istrue(level.skipstealthcanseecheck)) {
    var11 = scripts\engine\math::get_dot(var0.origin, var8, var1.origin);

    if(var11 < 0.573576 && !istrue(level.skipstealthcanseecheck)) {
      var0.spottedplayer = undefined;
      return false;
    }

    var3 = istrue(var3);
    var12 = var1 getstance();
    var13 = 1;
    var14 = 1;
    var15 = var1 getvelocity();
    var16 = length(var15);

    if(var16 < 128) {
      var13 = 0.75;
    } else if(var16 < 200 || var4 && var1.skill_data["stealth"].stealth_velocity_override) {
      var13 = 1;
    } else {
      var13 = 1.25;
    }

    if(var12 == "stand" && var7 <= int(var5.standdetectdist * var11 * var13 * var14) && (!var3 || canpathtotarget(var0, var1.origin))) {
      alertzombie(var0, var1, var2);
      return true;
    } else if(var12 == "crouch" && var7 <= int(var5.crouchdetectdist * var11 * var13 * var14) && (!var3 || canpathtotarget(var0, var1.origin))) {
      alertzombie(var0, var1, var2);
      return true;
    } else if(var12 != "prone" && var7 <= int(var5.pronedetectdist * var11 * var13 * var14) && (!var3 || canpathtotarget(var0, var1.origin))) {
      alertzombie(var0, var1, var2);
      return true;
    } else {
      var0.spottedplayer = undefined;
      return false;
    }
  } else {
    var0.spottedplayer = undefined;
    return false;
  }

  var0.spottedplayer = undefined;
  return false;
}

function canpathtotarget(var0, var1) {
  if(!isDefined(level.findpathcount)) {
    level.findpathcount = 1;
  }

  level.findpathcount += 1;
  var2 = istrue(var0.skiptraversals);
  var3 = var0 findpath(var0.origin, var1, 0, var2);

  if(var3.size >= 1 && distance(var3[var3.size - 1], var1) <= 64) {
    return 1;
  }

  return 0;
}

function stealth_patrol(var0) {
  var1 = self;
  var1 notify("stealth_patrol");
  var1 endon("stealth_patrol");
  var1 endon("death");
  var1 endon("alerted");
  var1 endon("alerted_by_ai");
  var1 endon("new_goal");
  var1.og_goalradius = var1.goalradius;

  if(!istrue(var1.fake_stealth)) {
    var1 waittill("fake_stealth_set");
  }

  if(!isDefined(var0)) {
    var0 = var1.origin;
  }

  setstealthstate(var1, "patrol");
  var2 = undefined;
  var3 = undefined;

  for(;;) {
    var4 = undefined;

    if(isDefined(var1.patrol_state) && var1.patrol_state != "patrol") {
      var1.waitingforstealthstatechange = 1;
      var1 waittill("stealth_state_changed");
      var1.waitingforstealthstatechange = undefined;
      continue;
    }

    if(istrue(var1.scriptedstealth)) {
      if(isDefined(var1.forcedpatrol)) {
        var5 = getclosestpointonnavmesh(var1.forcedpatrol.origin);

        if(isDefined(var2)) {
          var3 = var2;
        }

        var2 = var1.forcedpatrol;
        thread scripts\cp\cp_agent_patrol::setcooldown(var1.forcedpatrol, 20);
        thread removeifalerted(var1, var1.forcedpatrol);
        _setgoalpos(var1, var5, 32);
        scripts\cp\cp_agent_patrol::unsetcooldown(var1.forcedpatrol);
        var1.forcedpatrol = undefined;
      } else {
        var6 = scripts\engine\utility::get_array_of_closest(var1.origin, level.allzpatrolpoints, undefined, 10);
        var6 = getscoredpatrolpoints(var1, var1, var6, [var2, var3], "generic_zombie");

        if(isDefined(var6)) {
          foreach(var8 in var6) {
            var5 = getclosestpointonnavmesh(var8.origin);

            if(distance(var8.origin, var5) <= 40 && canpathtotarget(var1, var5)) {
              if(isDefined(var2)) {
                var3 = var2;
              }

              var2 = var8;
              thread scripts\cp\cp_agent_patrol::setcooldown(var8, 20);
              thread removeifalerted(var1, var8);
              _setgoalpos(var1, var5, 32);
              scripts\cp\cp_agent_patrol::unsetcooldown(var8);
              break;
            }

            var2 = undefined;
            var3 = undefined;
          }
        } else {
          var2 = undefined;
          var3 = undefined;
        }
      }
    }

    if(randomint(100) < 20) {
      wait randomfloatrange(2.5, 5);
    }
  }
}

function removeifalerted(var0, var1) {
  level endon("game_ended");
  var0 endon("goal_reached");
  var0 endon("goal");
  var0 endon("stalled");
  var0 scripts\engine\utility::ref_143a6("death", "alerted", "alerted_by_ai");
  scripts\cp\cp_agent_patrol::unsetcooldown(var1);
}

function cooldownpatrolpoint(var0) {
  level endon("game_ended");
  var0.cooldown = 1;
  wait 20;
  var0.cooldown = undefined;
}

function getscoredpatrolpoints(var0, var1, var2, var3) {
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
    var15 = distance(var0.origin, var12.origin);

    if(var8 && var15 <= 500) {
      var14 = 500;
    } else if(var15 >= 1500) {
      var14 = 500;
    } else {
      var16 = scripts\engine\math::get_dot(var0.origin, anglesToForward(var0.angles), var12.origin);

      if(isDefined(var12.target)) {
        var17 = scripts\engine\utility::getStructArray(var12.target, "targetname");

        if(var17.size > 1) {
          var18 = var10 * 500;
          var14 -= var18;
        }

        var19 = var9 * 500;
        var14 = var19 * var16;
      } else {
        var14 = 500 * var16;
      }
    }

    var14 = clamp(var14, 0, 500);
    var14 = clamp(var14 + var13, 0, 999);
    var12.personalscore = int(var14);
    var7 = var12;
  }

  var21 = scripts\cp\utility::array_sort_by_handler(var7, &getpersonalpatrolscore);
  return var21;
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

function go_to_spot(var0, var1, var2, var3) {
  var0 endon("death");
  var0 endon("alerted");
  var0 endon("alerted_by_ai");
  var0 endon("exit_stealth");
  var4 = getclosestpointonnavmesh(var1);

  if(distance(var4, var1) <= 32 && canpathtotarget(var0, var4)) {
    var0 notify("new_goal");
    var0 endon("new_goal");
    setstealthstate(var0, var3);
    resetgoalpos(var0);

    if(!isDefined(var0.legacy)) {
      iprintln("** - LEGACY IS UNDEFINED FOR : " + var0 getentitynumber() + ", health: " + var0.health + ", agent: " + var0.agent_type);
      var0.legacy = spawnStruct();
    }

    if(isDefined(var2)) {
      var0.legacy.movemode = var2;
    } else {
      var0.legacy.movemode = "sprint";
    }

    _setgoalpos(var0, var4, 32);
    var0.legacy.movemode = "slow_walk";
    wait getzombiestealthvalues(var0).timehiddennolosbeforedeescalate;
    var0 notify("reset_stealth");
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

function player_weapon_listener(var0) {
  var0 notify("player_weapon_listener");
  var0 endon("player_weapon_listener");
  var0 endon("death");
  var0 endon("alerted");
  var0 endon("exit_stealth");

  for(;;) {
    level waittill("weapon_fired", var1, var2, var3, var4);

    if(!istrue(var0.scriptedstealth)) {
      continue;
    }

    if(isPlayer(var3)) {
      var5 = 2000 * var3.skill_data["stealth"].stealth_weapon_noise_scalar;
    } else {
      var5 = 2000;
    }

    foreach(var7 in var2.attachments) {
      if(issubstr(var7, "silencer")) {
        var5 *= 0.75;
        break;
      }
    }

    var5 = int(var5);

    if(distance(var1, var0.origin) > var5) {
      continue;
    }

    thread go_to_spot(var0, var0, var1, undefined);
    wait 0.5;
  }
}

function zombie_3dtext_handler() {
  self endon("death");
  self notify("texthandler");
  self endon("texthandler");
  var0 = self getentitynumber();

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

    var0 = self gettagorigin("tag_eye");
    var1 = self gettagangles("tag_eye");
    var2 = anglesToForward(var1);
    var3 = var0 + var2 * self.stealthvals.standdetectdist;
    waitframe();
  }
}

function load_stealth_values_from_table() {
  level.zombie_stealth_values = [];

  if(isDefined(level.zombie_stealth_table)) {
    var0 = level.zombie_stealth_table;
  } else {
    var0 = "scripts/cp/zombie_stealth.csv";
  }

  var1 = 1;
  var2 = 1;

  for(;;) {
    var3 = tablelookupbyrow(var0, var2, var1);

    if(var3 == "") {
      break;
    }

    var4 = spawnStruct();
    var4.standdetectdist = int(tablelookupbyrow(var0, 2, var1));
    var4.crouchdetectdist = int(tablelookupbyrow(var0, 3, var1));
    var4.pronedetectdist = int(tablelookupbyrow(var0, 4, var1));
    var4.hiddenstanddetectdist = int(tablelookupbyrow(var0, 5, var1));
    var4.hiddencrouchdetectdist = int(tablelookupbyrow(var0, 6, var1));
    var4.hiddenpronedetectdist = int(tablelookupbyrow(var0, 7, var1));
    var4.propdistance = int(tablelookupbyrow(var0, 8, var1));
    var4.timebeforeescalate = int(tablelookupbyrow(var0, 9, var1));
    var4.timebeforedeescalate = int(tablelookupbyrow(var0, 10, var1));
    var4.distancebeforedeescalate = int(tablelookupbyrow(var0, 11, var1));
    var4.timehiddennolosbeforedeescalate = int(tablelookupbyrow(var0, 12, var1));
    var4.zombiemovespeed = tablelookupbyrow(var0, 13, var1);
    var4.playerstandmovedist = int(tablelookupbyrow(var0, 14, var1));
    var4.playercrouchmovedist = int(tablelookupbyrow(var0, 15, var1));
    var4.playerpronemovedist = int(tablelookupbyrow(var0, 16, var1));
    var4.hiddenplayerstandmovedist = int(tablelookupbyrow(var0, 17, var1));
    var4.hiddenplayercrouchmovedist = int(tablelookupbyrow(var0, 18, var1));
    var4.hiddenplayerpronemovedist = int(tablelookupbyrow(var0, 19, var1));
    var4.playermovedistlerptime = int(tablelookupbyrow(var0, 20, var1));
    var4.losfov = cos(int(tablelookupbyrow(var0, 21, var1)));
    var4.canseethroughfoliage = cos(int(tablelookupbyrow(var0, 22, var1)));
    level.zombie_stealth_values[int(var3)] = var4;
    var1++;
  }
}

function set_stealth_values(var0, var1) {
  if(isDefined(var1)) {
    var1 = int(clamp(var1, 0, level.maxescalationvalue - 1));
  }

  var1 = int(max(var1, 0));
  var2 = spawnStruct();
  var2.currentstealthlevel = int(var1);
  var2.standdetectdist = level.zombie_stealth_values[var1].standdetectdist;
  var2.crouchdetectdist = level.zombie_stealth_values[var1].crouchdetectdist;
  var2.pronedetectdist = level.zombie_stealth_values[var1].pronedetectdist;
  var2.hiddenstanddetectdist = level.zombie_stealth_values[var1].hiddenstanddetectdist;
  var2.hiddencrouchdetectdist = level.zombie_stealth_values[var1].hiddencrouchdetectdist;
  var2.hiddenpronedetectdist = level.zombie_stealth_values[var1].hiddenpronedetectdist;
  var2.propdistance = level.zombie_stealth_values[var1].propdistance;
  var2.timebeforeescalate = level.zombie_stealth_values[var1].timebeforeescalate;
  var2.timebeforedeescalate = level.zombie_stealth_values[var1].timebeforedeescalate;
  var2.distancebeforedeescalate = level.zombie_stealth_values[var1].distancebeforedeescalate;
  var2.timehiddennolosbeforedeescalate = level.zombie_stealth_values[var1].timehiddennolosbeforedeescalate;
  var2.zombiemovespeed = level.zombie_stealth_values[var1].zombiemovespeed;
  var2.playerstandmovedist = level.zombie_stealth_values[var1].playerstandmovedist;
  var2.playercrouchmovedist = level.zombie_stealth_values[var1].playercrouchmovedist;
  var2.playerpronemovedist = level.zombie_stealth_values[var1].playerpronemovedist;
  var2.hiddenplayerstandmovedist = level.zombie_stealth_values[var1].hiddenplayerstandmovedist;
  var2.hiddenplayercrouchmovedist = level.zombie_stealth_values[var1].hiddenplayercrouchmovedist;
  var2.hiddenplayerpronemovedist = level.zombie_stealth_values[var1].hiddenplayerpronemovedist;
  var2.playermovedistlerptime = level.zombie_stealth_values[var1].playermovedistlerptime;
  var2.losfov = level.zombie_stealth_values[var1].losfov;
  var2.canseethroughfoliage = level.zombie_stealth_values[var1].canseethroughfoliage;
  var0.stealthvals = var2;
  setzombiestate(var0, var1);
  var0 notify("stealth_values_set");
}

function setzombiestate(var0, var1) {
  var2 = level.maxescalationvalue;

  switch (var1) {
    case 10:
      var0 setscriptablepartstate("burning", "active");
      var0 setscriptablepartstate("arcane_white", "active");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 9:
      var0 setscriptablepartstate("burning", "active");
      var0 setscriptablepartstate("arcane_white", "active");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 8:
      var0 setscriptablepartstate("burning", "active");
      var0 setscriptablepartstate("arcane_white", "active");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 7:
      var0 setscriptablepartstate("burning", "active");
      var0 setscriptablepartstate("arcane_white", "active");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 6:
      var0 setscriptablepartstate("burning", "active");
      var0 setscriptablepartstate("arcane_white", "active");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 5:
      var0 setscriptablepartstate("burning", "inactive");
      var0 setscriptablepartstate("arcane_white", "inactive");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "active");
      break;
    case 4:
      var0 setscriptablepartstate("burning", "inactive");
      var0 setscriptablepartstate("arcane_white", "active");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 3:
      var0 setscriptablepartstate("burning", "inactive");
      var0 setscriptablepartstate("arcane_white", "inactive");
      var0 setscriptablepartstate("chemburn", "active");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 2:
      var0 setscriptablepartstate("burning", "active");
      var0 setscriptablepartstate("arcane_white", "inactive");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    case 1:
      var0 setscriptablepartstate("burning", "inactive");
      var0 setscriptablepartstate("arcane_white", "inactive");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "active");
      var0 setscriptablepartstate("pet", "inactive");
      break;
    default:
      var0 setscriptablepartstate("burning", "inactive");
      var0 setscriptablepartstate("arcane_white", "inactive");
      var0 setscriptablepartstate("chemburn", "inactive");
      var0 setscriptablepartstate("corrosive", "inactive");
      var0 setscriptablepartstate("shocked", "inactive");
      var0 setscriptablepartstate("pet", "inactive");
      break;
  }
}

function show_spotted_text(var0) {
  if(!isDefined(var0.last_spotted_vo) || gettime() >= var0.last_spotted_vo + 5000) {
    var0.last_spotted_vo = gettime();

    if(!istrue(level.disable_you_spotted_message)) {
      var0 iprintlnbold("You've been spotted!");
      return;
    }

    return;
  }
}

function increasecurrentstealthvalue(var0) {
  if(isDefined(var0.stealthvals) && isDefined(var0.stealthvals.currentstealthlevel)) {
    var1 = clamp(var0.stealthvals.currentstealthlevel + 1, 0, level.maxescalationvalue - 1);
    set_stealth_values(var0, int(var1));
    return;
  }
}

function decreasecurrentstealthvalue(var0) {
  if(isDefined(var0.stealthvals) && isDefined(var0.stealthvals.currentstealthlevel)) {
    var1 = clamp(var0.stealthvals.currentstealthlevel - 1, 0, level.maxescalationvalue - 1);
    set_stealth_values(var0, int(var1));
    return;
  }
}

function getzombiestealthvalues(var0) {
  if(isDefined(var0.stealthvals)) {
    return var0.stealthvals;
  }

  return undefined;
}

function monitorzawarenesslevel(var0) {
  var0 notify("monitorZAwarenessLevel");
  var0 endon("monitorZAwarenessLevel");
  level endon("game_ended");
  level endon("disable_zombie_scripted_stealth");
  var0 endon("disconnect");
  var0.zombieawarenesslevel = 0;
  var1 = 100;
  var2 = 0;

  for(;;) {
    if(scripts\engine\utility::flag("track_player_movement")) {
      if(var0 scripts\cp\utility::is_valid_player()) {
        var3 = var0 getvelocity();
        var4 = length(var3);

        if(var4 < 64) {
          var2 += 2;
        } else if(var4 > 64 && var4 < 128) {
          var2 += 1;
        } else if(var4 > 350) {
          var2 -= 10;
        } else if(var4 > 200) {
          var2 -= 5;
        }

        var2 = clamp(var2, 0, var1);

        if(var2 >= var1) {
          thread sendzombiehorde(var0);
          var2 = 0;
          wait 10;
        }
      }
    }

    wait 0.25;
  }
}

function sendzombiehorde(var0) {
  if(istrue(var0.ignoreme)) {
    return;
  }

  var1 = scripts\cp\cp_agent_utils::getactiveagentsoftype("generic_zombie");
  var2 = sortbydistance(var1, var0.origin);
  var3 = 10;
  var4 = 0;

  foreach(var6 in var2) {
    if(istrue(var6.fake_stealth)) {
      var7 = getstealthstate(var6);

      if(isDefined(var7) && var7 == "patrol") {
        thread go_to_spot(var6, var6, var0.origin, "run");
        var4++;

        if(var4 >= var3) {
          break;
        }
      }
    }
  }

  var4 = undefined;
  var6 = undefined;
}

function spawn_ambient_zombie(var0) {
  var1 = undefined;

  if(!isDefined(var1)) {
    return false;
  }

  if(!isDefined(var1.script_parameters)) {
    var1.script_parameters = "ground_spawn_no_boards";
  }

  if(var1.script_parameters != "ground_spawn_no_boards") {
    iprintlnbold("bad spawn");
  }

  var2 = var1[[level.spawn_wave_enemy_func]]("generic_zombie", 1, var1);

  if(isDefined(var2)) {
    if(istrue(var0.skiptraversals)) {
      var2.skiptraversals = 1;
    }

    if(istrue(var0.dontkilloff)) {
      var2.dontkilloff = 1;
    }

    if(isDefined(var1.target)) {
      var2.forcedpatrol = scripts\engine\utility::random(scripts\engine\utility::getStructArray(var1.target, "targetname"));
    }

    if(isDefined(var0.threatbiasoverride)) {
      var2.threatbiasoverride = var0.threatbiasoverride;
    }

    var1.lastspawntime = gettime();
    var2.killofftime = gettime() + 10000;
    var2 emissiveblend(1, 0.1);
    thread default_ambient_vals(var2, var2, var0);
    return true;
  }

  return false;
}

function default_ambient_vals(var0, var1, var2) {
  var0 endon("death");
  var0.iszombie = 1;
  var0.dont_scriptkill = 1;
  var0.dont_cleanup = 1;
  var0.enemy_group = var1.group_name;
  var0.moduleid = var1.moduleid;
  var0.group = var1;
  var0.group.activecount++;
  var3 = getdvarint("scr_infected_health", 160);
  var0.maxhealth = var3;
  var0.health = var3;
  activatezombiestealth(var0, var2);
}

function updatezombiegroupname(var0, var1) {
  var0.enemy_group = var1.group_name;
}

function activatezombiestealth(var0, var1) {
  thread zombiescriptedstealth(var0, var0);
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
    if(distance(var5, var1) <= 32) {
      var3 = 1;
      break;
    }
  }

  var7 = 1;

  if(var3) {
    var8 = getrandomnavpoints(var1, 128, 10, undefined, getrandomnavpoint(var1, 64), 128);
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
  var0 setgoalpos(var1);
  var15 = var0 scripts\engine\utility::ref_143ad("goal", "goal_reached");
}

function manageposarray(var0, var1) {
  level.nearbyposarray[level.nearbyposarray.size] = var1;
  var2 = var0 scripts\engine\utility::waittill_any_in_array_return(["death", "set_goal_pos_requested", "alerted", "exit_stealth", "new_goal", "alerted_by_ai"]);

  if(scripts\engine\utility::array_contains(level.nearbyposarray, var1)) {
    level.nearbyposarray = scripts\engine\utility::array_remove(level.nearbyposarray, var1);
    return;
  }
}

function resetgoalpos(var0) {
  var0 setgoalpos(self.origin);
  var0 scripts\engine\utility::ref_143a5("goal", "goal_reached");
}
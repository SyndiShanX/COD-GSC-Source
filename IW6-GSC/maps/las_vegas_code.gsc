/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\las_vegas_code.gsc
*****************************************************/

spawn_heroes() {
  if(is_start_point_before("atrium")) {
    return;
  }
  var_0 = getEntArray("heroes", "targetname");

  foreach(var_2 in var_0) {
    if(issubstr(var_2.script_noteworthy, "_intro")) {
      continue;
    }
    spawn_hero(var_2.script_noteworthy);
  }
}

spawn_hero(var_0, var_1) {
  if(!isDefined(level.heroes))
    level.heroes = [];

  if(var_0 == "merrick" && isDefined(level.merrick)) {
    return;
  }
  if(var_0 == "keegan" && isDefined(level.keegan)) {
    return;
  }
  if(var_0 == "hesh" && isDefined(level.hesh)) {
    return;
  }
  if(var_0 == "elias" && isDefined(level.elias)) {
    return;
  }
  var_2 = getEntArray("heroes", "targetname");
  var_3 = array_get_noteworthy(var_2, var_0);

  if(!isDefined(var_3))
    var_3 = getent(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    var_3.origin = var_1.origin;
    var_3.angles = var_1.angles;
  }

  if(issubstr(var_0, "_intro")) {
    var_4 = strtok(var_0, "_");
    var_0 = var_4[0];
  }

  var_3.count = 1;
  var_5 = var_3 maps\_utility::spawn_ai(1, 1);
  level.heroes[level.heroes.size] = var_5;

  if(var_0 == "merrick") {
    level.merrick = var_5;
    var_5 merrick_scripted_movement();
  } else if(var_0 == "keegan") {
    level.keegan = var_5;
    var_5.disable_sniper_glint = 1;
    var_5 keegan_scripted_movement();
    var_5 maps\_utility::ent_flag_init("doing_kitchen_ambush");
  } else if(var_0 == "hesh") {
    level.hesh = var_5;
    var_5 hesh_scripted_movement();
  } else if(var_0 == "riley") {
    level.dog = var_5;
    var_5.animname = "dog";
    var_5.name = "Riley";
    var_5 dog_scripted_movement();
    var_5 setthreatbiasgroup("heroes");
    return var_5;
  } else if(var_0 == "elias") {
    level.elias = var_5;
    var_5 maps\_utility::stop_magic_bullet_shield();
    var_5 elias_scripted_movement();
  }

  var_5 thread maps\_utility::set_ai_bcvoice("taskforce");
  var_5.script_noteworthy = var_0;
  var_5.animname = var_0;
  var_5.suppressionwait = 0;
  var_5 maps\_utility::disable_surprise();
  var_5.ignorerandombulletdamage = 1;
  var_5.grenadeawareness = 0;
  var_5.script_grenades = 0;
  var_5.originalbasaccuracy = var_5.baseaccuracy;
  var_5.neverenablecqb = 1;
  var_5.goalradius = 128;
  return var_5;
}

spawn_rorke() {
  if(isDefined(level.rorke)) {
    return;
  }
  var_0 = getent("rorke_spawner", "targetname");
  var_0.count = 3;
  level.rorke = var_0 maps\_utility::spawn_ai(1);
  level.rorke.animname = "rorke";
  level.rorke maps\_utility::place_weapon_on("m9a1", "right");
}

reset_if_new_goal(var_0) {
  self endon("goal");
  self waittill("ai_new_goal");

  if(isDefined(var_0))
    self.goalradius = var_0;

  disable_arrivals_and_exits(0);
}

set_goal_any(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isstring(var_0))
    var_0 = maps\_utility::getent_or_struct_or_node(var_0, "targetname");

  if(isDefined(var_2)) {
    if(isDefined(var_3)) {
      self.oldgoalradius = self.goalradius;
      self.goalradius = 15;
    }

    self.ignoreall = 1;
  }

  if(isDefined(var_0.type))
    thread maps\_utility::set_goal_node(var_0);
  else if(!isDefined(var_0.classname))
    thread maps\_utility::set_goal_pos(var_0.origin);
  else if(var_0.classname == "info_volume")
    thread old_set_goal_volume(undefined, var_0);
  else if(var_0.classname == "script_origin")
    self setgoalentity(var_0);
  else {}

  if(isDefined(var_1) && var_1 != 0) {
    thread waittill_goal(1);
    return;
  } else if(isDefined(var_2)) {
    waittill_goal();

    if(isDefined(var_3))
      self.goalradius = self.oldgoalradius;

    self.ignoreall = 0;
  }
}

old_set_goal_volume(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = getent(var_2, "targetname");

  if(!isDefined(var_0))
    var_0 = self;

  if(isarray(var_0)) {
    var_0 = maps\_utility::array_removedead_or_dying(var_0);

    foreach(var_4 in var_0)
    var_4 setgoalvolumeauto(var_1);
  } else if(isDefined(var_0) && isalive(var_0))
    var_0 setgoalvolumeauto(var_1);
}

guys_waittill_goals(var_0) {
  foreach(var_2 in var_0)
  var_2 thread waittill_goal();

  for(;;) {
    var_4 = 0;

    foreach(var_2 in var_0) {
      if(isDefined(var_2.atgoal) && var_2.atgoal == 1)
        var_4++;
    }

    if(var_4 == var_0.size) {
      break;
    }

    wait 0.05;
  }
}

waittill_goal(var_0) {
  self endon("death");
  self.atgoal = 0;
  self.oldgoalradius = self.goalradius;
  self.goalradius = 25;
  self waittill("goal");
  self.atgoal = 1;

  if(isDefined(var_0)) {
    self delete();
    return;
  }

  self.goalradius = self.oldgoalradius;
}

waittill_death_and_respawn(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("stop_respawning");

  if(isDefined(var_2))
    level endon(var_2);

  if(!isDefined(var_3))
    var_3 = 3;

  if(!isDefined(var_4))
    var_4 = 5;

  var_5 = undefined;

  if(isai(self))
    var_5 = self;
  else
    var_0 waittill("spawned", var_5);

  while(isDefined(var_5)) {
    if(isDefined(var_1))
      var_5 thread set_goal_any(var_1);

    var_5 waittill("death");

    if(!isDefined(var_0)) {
      break;
    }

    if(var_0.count == 0) {
      break;
    }

    wait(randomfloatrange(var_3, var_4));

    if(!isDefined(var_0)) {
      break;
    }

    var_5 = var_0 maps\_utility::spawn_ai();
  }
}

waittill_trigger_and_kill(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isstring(var_0))
    var_0 = getent(var_0, "targetname");

  var_0 waittill("trigger");
  wait(randomfloatrange(var_1, var_2));

  if(isDefined(var_3))
    self delete();
  else
    self kill();
}

trigger_waittill_trigger(var_0, var_1, var_2, var_3) {
  if(isstring(var_0))
    var_0 = getent_targetname_or_noteworthy(var_0);

  if(isDefined(var_1)) {
    var_4 = var_0 common_scripts\utility::waittill_any_timeout(var_1, "trigger");

    if(var_4 == "timeout")
      var_0 notify("trigger");
  } else if(isDefined(var_3)) {
    for(;;) {
      var_0 waittill("trigger", var_5);

      if(var_5 == var_3) {
        break;
      }

      wait 0.05;
    }
  } else
    var_0 waittill("trigger");

  if(isDefined(var_2))
    level notify(var_2);
}

getent_targetname_or_noteworthy(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1))
    var_1 = getent(var_0, "script_noteworthy");

  return var_1;
}

get_closest_in_array(var_0, var_1) {
  var_2 = get_closest_index_in_array(var_0, var_1);
  return var_0[var_2];
}

get_closest_index_in_array(var_0, var_1) {
  var_2 = distancesquared(var_0[0], var_1);
  var_3 = 0;

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_5 = distancesquared(var_0[var_4], var_1);

    if(var_5 < var_2) {
      var_2 = var_5;
      var_6 = var_0[var_4];
      var_3 = var_4;
    }
  }

  return var_3;
}

get_chained_vehiclenodes(var_0) {
  var_1 = [];
  var_1[0] = var_0;

  for(;;) {
    if(!isDefined(var_0.target)) {
      break;
    }

    var_0 = getvehiclenode(var_0.target, "targetname");
    var_1[var_1.size] = var_0;
  }

  return var_1;
}

get_targeted_ents() {
  var_0 = [];
  var_0[0] = self;

  for(var_1 = self; isDefined(var_1.target); var_1 = var_2) {
    var_2 = var_1 common_scripts\utility::get_target_ent();

    if(!isDefined(var_2)) {
      break;
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_target_chain_array(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;

  while(isDefined(var_0)) {
    if(!isDefined(var_0.target)) {
      break;
    }

    var_0 = maps\_utility::getent_or_struct_or_node(var_0.target, "targetname");

    if(!isDefined(var_0)) {
      break;
    }

    var_1[var_1.size] = var_0;

    if(!isDefined(var_0.target)) {
      break;
    }

    wait 0.05;
  }

  return var_1;
}

ignore_everything() {
  self.ignoreall = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
}

clear_ignore_everything() {
  self.ignoreall = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.fixednode = 1;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();

  if(isDefined(self.og_newenemyreactiondistsq))
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

set_all_ai_targetnames(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  self.targetname = var_0.targetname;
}

kill_over_time(var_0, var_1, var_2, var_3, var_4) {
  if(!isarray(var_0)) {
    var_5 = [];
    var_5[0] = var_0;
    var_0 = var_5;
  }

  var_0 = maps\_utility::remove_dead_from_array(var_0);

  foreach(var_7 in var_0)
  thread kill_over_time_single(var_7, var_1, var_2, var_3, var_4);
}

kill_over_time_single(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_5 = 3;

  if(!isDefined(var_2))
    var_5 = randomfloat(var_5);
  else if(isDefined(var_3))
    var_5 = randomfloatrange(var_2, var_3);
  else
    var_5 = randomfloatrange(var_2);

  while(isDefined(var_4)) {
    wait(var_5);

    if(maps\_utility::player_can_see_ai(var_0))
      continue;
    else
      var_4 = undefined;
  }

  if(isDefined(var_1))
    var_1 thread aim_and_kill(var_0);
  else
    var_0 kill();
}

aim_and_kill(var_0) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  thread maps\_utility::cqb_aim(var_0);
  var_1 = self gettagorigin("tag_flash");
  var_2 = var_0 gettagorigin("j_head");
  var_0.health = 1;

  if(!isDefined(var_0) || !isalive(var_0)) {
    thread maps\_utility::cqb_aim(undefined);
    return;
  }

  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(self.a.array)) {
    var_5 = randomint(self.a.array["single"].size);
    var_3 = self.a.array["single"][var_5];
    var_4 = weaponfiretime(self.weapon);
  }

  if(!isDefined(var_0) || !isalive(var_0)) {
    thread maps\_utility::cqb_aim(undefined);
    return;
  }

  if(isDefined(var_3)) {
    self setflaggedanimknobrestart("fire_notify", var_3, 1, 0.2, var_4);
    common_scripts\utility::waittill_any_timeout(0.2, "fire_notify", "fire");
  }

  magicbullet(self.weapon, var_1, var_2);

  if(!isDefined(var_0) || !isalive(var_0))
    var_0 kill();

  thread maps\_utility::cqb_aim(undefined);
}

stealth_shot_accuracy(var_0) {
  var_1 = self.baseaccuracy;
  self.baseaccuracy = 9999;
  var_0 waittill("death");
  self.baseaccuracy = var_1;
}

idle_and_react(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("dying");

  if(!isDefined(var_1))
    var_1 = self.script_animation + "_idle";

  var_4 = 0;

  if(!isDefined(var_2))
    var_2 = self.script_animation + "_react";
  else if(var_2 == "none")
    var_4 = 1;

  if(!isDefined(self.animname))
    var_0 thread maps\_anim::anim_generic_loop(self, var_1, "stop_anim");
  else
    var_0 thread maps\_anim::anim_loop_solo(self, var_1, "stop_anim");

  thread waittill_dead_and_stop_anim(var_0, var_2);
  self.stealth_radius_multiplier = 0;
  var_5 = waittill_stealth_notify();
  var_0 notify("stop_anim");
  self stopanimscripted();
  maps\_utility::set_ignoreme(0);
  maps\_utility::set_ignoreall(0);

  if(var_4 == 0) {
    if(!isDefined(self.animname))
      var_0 maps\_anim::anim_generic(self, var_2);
    else
      var_0 maps\_anim::anim_single_solo(self, var_2);
  }

  if(isDefined(var_3))
    thread set_goal_any(var_3);
}

waittill_dead_and_stop_anim(var_0, var_1) {
  var_0 endon(var_1);
  self.allowpain = 1;
  self.allowdeath = 1;
  self.health = 10;
  common_scripts\utility::waittill_any("death", "damage", "dying");

  if(!isDefined(self)) {
    return;
  }
  var_0 notify("stop_anim");
  self stopanimscripted();

  if(isalive(self))
    self kill();
}

get_living_ai_waittill_dead_or_dying(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_3))
    var_4 = get_living_ai_array_safe(var_0, var_1);
  else
    var_4 = maps\_utility::get_living_ai_array(var_0, var_1);

  if(!isDefined(var_4)) {
    var_5 = maps\_utility::get_living_ai(var_0, var_1);
    var_4 = var_5[0];
  }

  if(!isDefined(var_2))
    var_2 = var_4.size;

  maps\_utility::waittill_dead_or_dying(var_4, var_2);
}

get_living_ai_array_safe(var_0, var_1) {
  var_2 = getspawner_array(var_0, var_1);
  var_3 = undefined;
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(isDefined(var_6.script_delay)) {
      if(var_6.script_delay > var_4)
        var_3 = var_6.script_delay;
    }
  }

  if(isDefined(var_3))
    wait(var_3);

  return maps\_utility::get_living_ai_array(var_0, var_1);
}

getspawner_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    if(isspawner(var_5))
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

waittill_stealth_notify(var_0, var_1) {
  self endon("death");
  level endon("stealth_event_notify");
  self endon("stop_stealth_notify");

  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1)
    thread waittill_stealth_notify_goloud(var_0);

  thread waittill_stealth_radius();

  if(isDefined(var_0) && common_scripts\utility::flag(var_0)) {
    return;
  }
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  thread custom_ai_eventlistener("flashbang", var_0);
  level thread flash_bang_explode(self, var_0);
  self waittill("ai_event", var_2, var_3, var_4);

  if(isDefined(var_0))
    common_scripts\utility::flag_set(var_0);

  level notify("stealth_event_notify", self);
}

sight_stealth_notify(var_0, var_1) {
  self endon("death");
  self endon("stop_sight_stealth_notify");
  level endon(var_0);

  for(;;) {
    wait 0.1;

    if(!common_scripts\utility::flag(var_1)) {
      if(level.player sightconetrace(self getEye())) {
        break;
      }
    }
  }

  common_scripts\utility::flag_set(var_0);
}

flash_bang_explode(var_0, var_1) {
  level notify("stop_flash_bang_explode");
  level endon("stop_flash_bang_explode");

  if(isDefined(var_1))
    level endon(var_1);

  level endon("stealth_event_notify");
  level.player endon("death");

  if(!isDefined(level.stealth_notify_ents))
    level.stealth_notify_ents = [];

  level.stealth_notify_ents[level.stealth_notify_ents.size] = var_0;

  for(;;) {
    level.player waittill("grenade_fire", var_2, var_3);

    if(!isDefined(var_2)) {
      return;
    }
    if(isDefined(var_3)) {
      if(var_3 == "flash_grenade") {
        var_2 waittill("explode", var_4);
        level.stealth_notify_ents = common_scripts\utility::array_removeundefined(level.stealth_notify_ents);

        foreach(var_0 in level.stealth_notify_ents) {
          if(!isalive(var_0) || var_0 maps\_utility::doinglongdeath()) {
            continue;
          }
          if(distancesquared(var_0.origin, var_4) < squared(1200))
            var_0 notify("ai_event", "flash_grenade_exploded");
        }
      }
    }
  }
}

custom_ai_eventlistener(var_0, var_1) {
  if(isDefined(var_1))
    level endon(var_1);

  level endon("stop_stealth_notify");
  self endon("death");
  self waittill(var_0);
  self notify("ai_event", var_0);
}

waittill_stealth_radius() {
  self endon("death");
  self endon("stop_stealth_notify");
  level endon("stealth_event_notify");
  var_0["prone"] = 80;
  var_0["crouch"] = 100;
  var_0["stand"] = 140;

  for(;;) {
    var_1 = 1;
    var_1 = get_stealth_scale();
    var_2 = distancesquared(self.origin, level.player.origin);
    var_3 = level.player getstance();

    if(var_2 < squared(var_0[var_3] * var_1)) {
      break;
    }

    wait 0.05;
  }

  self notify("ai_event", "player_in_radius");
}

get_stealth_scale() {
  var_0 = 1;

  if(isDefined(self.stealth_radius_multiplier))
    var_0 = self.stealth_radius_multiplier;
  else {
    var_1 = getEntArray("hiding_volume", "targetname");

    foreach(var_3 in var_1) {
      if(level.player istouching(var_3)) {
        var_0 = var_3.script_multiplier;
        break;
      }
    }
  }

  return var_0;
}

waittill_stealth_notify_goloud(var_0) {
  self endon("death");
  self endon("stop_stealth_notify");

  if(!isDefined(var_0) || !common_scripts\utility::flag(var_0))
    level waittill("stealth_event_notify");

  wait(randomfloatrange(0.1, 0.5));
  self notify("stealth_event_notify");
  self notify("stop_going_to_node");
  maps\_utility::enable_arrivals();
  maps\_utility::enable_exits();
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.favoriteenemy = level.player;
  maps\_utility::set_baseaccuracy(2);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "kitchen_flashlight_enemy") {
    self stopanimscripted();

    if(isDefined(self.flashlight)) {
      self.flashlight unlink();
      var_1 = 0.5;
      self.flashlight moveto(self.origin + (0, 0, 1), var_1, var_1, 0);
      self.flashlight rotateto((90, 63, 0), var_1, var_1, 0);
      level maps\_utility::notify_delay("unlink_flashlight", var_1);
    }

    maps\_utility::gun_recall();
    self animcustom(::do_reaction);
  }

  if(isDefined(self.cqbenabled))
    maps\_utility::disable_cqbwalk();
  else if(!isDefined(self.animname))
    maps\_utility::clear_generic_run_anim();
  else
    maps\_utility::clear_run_anim();
}

do_reaction() {
  self endon("killanimscript");
  animscripts\utility::initialize("reactions");
  animscripts\reactions::newenemyreactionanim();
}

set_start_locations(var_0, var_1) {
  var_2 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(var_4.script_noteworthy == "player")
      var_4 set_player_location();
  }

  if(!isDefined(var_1))
    var_1 = common_scripts\utility::array_removeundefined(level.heroes);

  foreach(var_7 in var_1) {
    var_4 = array_get_noteworthy(var_2, var_7.script_noteworthy);
    var_7 forceteleport(var_4.origin, var_4.angles);
    var_7.teleport_node = var_4;
  }
}

set_player_location(var_0) {
  if(isDefined(var_0))
    var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  else
    var_1 = self;

  var_2 = common_scripts\utility::drop_to_ground(var_1.origin, 10, -100);
  level.player setorigin(var_2);
  level.player setplayerangles(var_1.angles);
}

array_get_noteworthy(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_1)
      return var_3;
  }

  return undefined;
}

disable_arrivals_and_exits(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.disablearrivals = var_0;
  self.disableexits = var_0;
}

anim_reach_and_anim(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("cancel_anim");

  if(isDefined(var_0.animname)) {
    maps\_anim::anim_reach_solo(var_0, var_1);
    maps\_anim::anim_single_solo(var_0, var_1);
  } else {
    maps\_anim::anim_generic_reach(var_0, var_1);
    maps\_anim::anim_generic(var_0, var_1);
  }

  var_0 notify(var_1);
}

waittill_flag_set(var_0, var_1) {
  self endon("death");
  self waittill(var_0);
  common_scripts\utility::flag_set(var_1);
}

too_close_to_allies(var_0, var_1, var_2) {
  level endon(var_2);
  self endon("death");
  var_1 = squared(var_1);
  var_3 = common_scripts\utility::array_add(level.heroes, level.player);

  for(;;) {
    foreach(var_5 in var_3) {
      if(distancesquared(var_5.origin, self.origin) < var_1) {
        self notify(var_0);
        return;
      }
    }

    wait 0.1;
  }
}

doors_open(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isstring(var_0))
    var_6 = getEntArray(var_0, "targetname");
  else
    var_6 = var_0;

  if(!isarray(var_6)) {
    var_6 door_open(var_1, var_2, var_3, var_4, var_5);
    return;
  }

  if(!isDefined(var_1))
    var_1 = 0.5;

  if(!isDefined(var_2))
    var_2 = "double_door_wood_kick";

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_3))
    var_3 = 90;

  foreach(var_11, var_8 in var_6) {
    if(isarray(var_3))
      var_9 = randomfloatrange(var_3[0], var_3[1]);
    else
      var_9 = var_3;

    if(isarray(var_1))
      var_10 = randomfloatrange(var_1[0], var_1[1]);
    else
      var_10 = var_1;

    if(var_8.script_noteworthy == "right")
      var_9 = var_9 * -1;

    if(isDefined(var_8.script_sound))
      var_8 playSound(var_8.script_sound);
    else if(var_11 == 0)
      var_8 playSound(var_2);

    var_8 rotateto(var_8.angles + (0, var_9, 0), var_10, var_4, var_5);
    var_8 connectpaths();
    var_8 thread door_waittill_rotatedone();
  }

  for(;;) {
    var_12 = 0;

    foreach(var_8 in var_6) {
      if(isDefined(var_8.rotatedone))
        var_12++;
    }

    if(var_12 == 2) {
      break;
    }

    wait 0.05;
  }

  level notify("double_doors_opened");
}

door_open(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0))
    var_0 = 0.5;

  if(!isDefined(var_1))
    var_1 = "double_door_wood_kick";

  if(!isDefined(var_2))
    var_2 = 90;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "right")
    var_2 = var_2 * -1;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  self rotateto(self.angles + (0, var_2, 0), var_0, var_3, var_4);
  self connectpaths();

  if(isDefined(self.script_sound))
    self playSound(self.script_sound);
  else if(isDefined(var_1))
    self playSound(var_1);
}

door_waittill_rotatedone() {
  self waittill("rotatedone");
  self.rotatedone = 1;
}

func_waittill_msg(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 waittill(var_1);

  if(isDefined(var_3))
    var_0 thread[[var_2]](var_3);
  else if(isDefined(var_4))
    var_4 thread[[var_2]](var_3);
  else
    var_0 thread[[var_2]]();
}

link_two_entites(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2))
    var_0 linkto(var_1, var_2, var_3, var_4);
  else
    var_0 linkto(var_1);
}

r_unlink(var_0) {
  var_0 unlink();
}

set_ai_name(var_0) {
  self.orginalname = self.name;
  self.name = var_0;
}

reset_ai_name() {
  self.name = self.orginalname;
  self.orginalname = undefined;
}

print3d_on_me(var_0) {}

set_goal_volume(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1))
    wait(var_1);

  self setgoalvolumeauto(var_0);
}

enemy_volume_trigger_thread(var_0, var_1) {
  self endon("death");
  var_2 = getEntArray(self.target, "targetname");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(var_5.classname == "info_volume")
      var_3 = var_5;
  }

  while(!common_scripts\utility::flag(var_1)) {
    self waittill("trigger");

    if(var_0.enemy_volume == var_3) {
      wait 0.5;
      continue;
    }

    var_0.enemy_volume = var_3;

    if(isDefined(self.script_wait)) {
      if(self.script_wait < 0)
        return;
    }
  }
}

update_enemy_volume(var_0) {
  var_0.enemies = maps\_utility::array_removedead_or_dying(var_0.enemies);
  var_0.enemies = common_scripts\utility::array_removeundefined(var_0.enemies);

  foreach(var_2 in var_0.enemies) {
    var_3 = var_2 getgoalvolume();

    if(!isDefined(var_3) || var_3 != var_0.enemy_volume)
      var_2 thread set_goal_volume(var_0.enemy_volume, randomfloatrange(0, 2));
  }
}

force_shot_track(var_0, var_1) {
  var_2 = 0;

  if(self.ignoreall)
    var_2 = 1;

  thread maps\_utility::cqb_aim(var_0);

  if(isDefined(var_1))
    wait(var_1);

  var_3 = randomint(self.a.array["single"].size);
  var_4 = self.a.array["single"][var_3];
  self setflaggedanimknobrestart("fire_notify", var_4, 1, 0.2, 1);
  self waittillmatch("fire_notify", "fire");
  var_5 = var_0 gettagorigin("j_head");
  self shoot(1, var_5, 1);

  if(var_2)
    self.ignoreall = 1;
}

remove_name() {
  self.og_name = self.name;
  self.name = "";
}

restore_name() {
  if(!isDefined(self.og_name)) {
    return;
  }
  self.name = self.og_name;
}

enable_creepwalk() {}

get_hero_noteworthy(var_0) {
  foreach(var_2 in level.heroes) {
    if(var_2.script_noteworthy == var_0)
      return var_2;
  }

  return undefined;
}

anim_reach_startorigin_solo(var_0, var_1, var_2, var_3, var_4) {}

run_to_goal_delete(var_0) {
  self endon("death");
  self setgoalnode(var_0);
  self waittill("goal");
  self delete();
}

nag_thread(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_nag_thread");

  if(!isDefined(var_2))
    var_2 = 3;

  if(!isDefined(var_3))
    var_3 = 5;

  if(!isDefined(var_4))
    var_4 = 1;

  var_5 = 2;

  if(!isarray(var_1))
    var_1 = [var_1];

  wait 3;
  var_6 = "";

  for(;;) {
    if(any_flag(var_1)) {
      break;
    }

    var_0 = common_scripts\utility::array_randomize(var_0);

    while(var_0[0] == var_6) {
      var_0 = common_scripts\utility::array_randomize(var_0);
      wait 0.05;
    }

    foreach(var_9, var_8 in var_0) {
      maps\_utility::smart_dialogue(var_8);
      var_6 = var_8;
      wait(randomfloatrange(var_2, var_3));

      if(var_4) {
        var_5 = var_5 + 3;
        var_2 = min(var_2 + var_5, 20);
        var_3 = min(var_3 + var_5, 30);
      } else {
        var_2 = min(var_2, 20);
        var_3 = min(var_3, 30);
      }

      if(any_flag(var_1)) {
        break;
      }
    }
  }
}

any_flag(var_0) {
  foreach(var_2 in var_0) {
    if(common_scripts\utility::flag(var_2))
      return 1;
  }

  return 0;
}

death_wait() {
  self endon("death");
  self waittillmatch("single anim", "end");
}

sniper_ragdoll_death() {
  var_0 = vectornormalize(self.damagedir);
  var_0 = var_0 * randomfloatrange(2000, 3000);
  var_1 = "torso_upper";

  if(self.damagelocation != "none")
    var_1 = self.damagelocation;

  self startragdollfromimpact(var_1, var_0);
  wait 1;
  return 1;
}

set_wounded() {
  self.dontmelee = 1;
  self.noturnanims = 1;
  self.norunngun = 1;
  self.norunreload = 1;
  self.nogrenadereturnthrow = 1;
  maps\_utility::set_archetype("wounded");
}

set_not_wounded() {
  self.dontmelee = 0;
  self.noturnanims = 0;
  self.norunngun = 0;
  self.norunreload = undefined;
  self.nogrenadereturnthrow = 0;
  maps\_utility::clear_archetype();
}

stop_animscripted(var_0, var_1) {
  var_2 = getanimlength(var_0) - var_1;
  wait(var_2);
}

death_ragdoll() {
  animscripts\shared::dropallaiweapons();
  var_0 = self.damagetaken * 100;
  var_1 = max(0.3, self.damagedir[2]);
  var_2 = (self.damagedir[0], self.damagedir[1], var_1);
  self startragdollfromimpact(self.damagelocation, var_2);
  wait 0.05;
}

intro_time(var_0, var_1, var_2, var_3) {
  level.player freezecontrols(1);

  if(isDefined(var_3))
    maps\_hud_util::fade_out(0, "black");

  thread intro_time_hud(var_0, var_1);
  wait(var_1 - var_2 * 0.5);

  if(isDefined(var_3))
    thread maps\_hud_util::fade_in(var_2, "black");

  level.player freezecontrols(0);
}

intro_time_hud(var_0, var_1) {
  var_2 = 320;
  var_3 = 300;
  var_4 = maps\_introscreen::stylized_line(var_0, var_1, var_2, var_3, "center");
  wait(var_1);
  maps\_introscreen::stylized_fadeout(var_4, var_2, var_3, 1);
}

cinematicmode_on() {
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player allowsprint(0);
}

cinematicmode_off() {
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowjump(1);
  level.player allowsprint(1);
}

set_player_speed(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = level.start_point;

  if(!isDefined(var_1))
    var_1 = 10;

  switch (var_0) {
    case "ambush":
      maps\_utility::player_speed_set(72, var_1);
      break;
    case "atrium":
    case "kitchen":
    case "bar":
      maps\_utility::player_speed_set(110, var_1);
      break;
    case "chase":
    case "hotel":
    case "floor":
      maps\_utility::player_speed_set(152, var_1);
      break;
    case "entrance":
      maps\_utility::player_speed_percent(10, var_1);
      break;
    case "exfil":
    case "entrance_combat":
      maps\_utility::player_speed_percent(100, var_1);
      break;
    default:
      break;
  }
}

merrick_scripted_movement() {
  self.movement_funcs["kitchen_enter"] = maps\las_vegas_casino::kitchen_enter_merrick;
  self.movement_funcs["kitchen_hide"] = maps\las_vegas_casino::kitchen_hide_merrick;
  self.movement_funcs["door_react"] = maps\las_vegas_casino::door_react_merrick;
  self.movement_funcs["to_casino_floor"] = maps\las_vegas_casino::to_casino_floor;
}

hesh_scripted_movement() {
  self.movement_funcs["human_shield"] = maps\las_vegas_casino::human_shield_hesh;
  self.movement_funcs["hesh_pickup_radio"] = maps\las_vegas_casino::hesh_pickup_radio;
  self.movement_funcs["door_react"] = maps\las_vegas_casino::door_react_hesh;
  self.movement_funcs["to_casino_floor"] = maps\las_vegas_casino::to_casino_floor;
}

keegan_scripted_movement() {
  self.movement_funcs["open_casino_door"] = maps\las_vegas_casino::open_casino_door_anim;
  self.movement_funcs["casino_ambush"] = maps\las_vegas_casino::casino_ambush_keegan;
  self.movement_funcs["open_gate"] = maps\las_vegas_casino::open_gate_keegan;
  self.movement_funcs["door_react"] = maps\las_vegas_casino::door_react_keegan;
  self.movement_funcs["to_casino_floor"] = maps\las_vegas_casino::to_casino_floor;
}

dog_scripted_movement() {}

elias_scripted_movement() {}

start_scripted_movement() {
  if(isDefined(self.teleport_node) && isDefined(self.teleport_node.target))
    var_0 = self.teleport_node;
  else
    var_0 = get_movement_node(self.script_noteworthy + "_scripted_movement");

  thread scripted_movement(var_0);
}

scripted_movement(var_0, var_1) {
  self endon("death");
  self notify("stop_scripted_movement");
  self endon("stop_scripted_movement");

  if(!maps\_utility::ent_flag_exist("scripted_movement_pause"))
    maps\_utility::ent_flag_init("scripted_movement_pause");

  if(!maps\_utility::ent_flag_exist("scripted_movement"))
    maps\_utility::ent_flag_init("scripted_movement");

  maps\_utility::ent_flag_set("scripted_movement");

  if(isDefined(var_1))
    var_2 = var_0;
  else
    var_2 = var_0 get_movement_node();

  for(;;) {
    self notify("scripted_movement_next_goal");

    if(maps\_utility::ent_flag("scripted_movement_pause"))
      maps\_utility::ent_flag_waitopen("scripted_movement_pause");

    if(is_stop_goal(var_2)) {
      maps\_utility::enable_arrivals();
      maps\_utility::enable_exits();
    } else {
      maps\_utility::disable_arrivals();
      thread delay_disable_exits();
    }

    scripted_goto_goal(var_2);
    maps\_utility::enable_arrivals();
    maps\_utility::enable_exits();
    movement_func(var_2);
    scripted_movement_parameters(var_2);
    var_3 = get_movement_trigger(var_2);

    if(isDefined(var_3))
      movement_trigger_wait(var_3);

    if(isDefined(var_2.script_flag_wait))
      common_scripts\utility::flag_wait(var_2.script_flag_wait);

    if(isDefined(var_2.script_wait) || isDefined(var_2.script_wait_min))
      var_2 maps\_utility::script_wait();

    if(!isDefined(var_2.target)) {
      break;
    }

    var_2 = var_2 get_movement_node();
  }

  maps\_utility::ent_flag_clear("scripted_movement");
  self notify("scripted_movement_done");
}

scripted_movement_parameters(var_0) {
  if(isDefined(var_0.script_avoidplayer))
    self.dontavoidplayer = !var_0.script_avoidplayer;

  if(isDefined(var_0.script_parameters)) {
    switch (var_0.script_parameters) {
      case "run":
        maps\_utility::disable_cqbwalk();
        maps\_utility::clear_archetype();
        break;
      case "enable_reach":
        self.disableplayeradsloscheck = 1;
        self.nododgemove = 1;
        self pushplayer(1);
        break;
      case "disable_reach":
        self.disableplayeradsloscheck = 0;
        self.nododgemove = 0;
        self pushplayer(0);
        break;
    }
  }
}

movement_func(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  if(!isDefined(self.movement_funcs)) {
    return;
  }
  if(!isDefined(self.movement_funcs[var_0.script_noteworthy])) {
    return;
  }
  [[self.movement_funcs[var_0.script_noteworthy]]](var_0);
}

movement_trigger_wait(var_0) {
  if(isDefined(var_0.targetname)) {
    if(var_0.targetname == "friendly_wait") {
      var_1 = get_hero_noteworthy(var_0.script_friendname);

      for(;;) {
        var_0 waittill("trigger", var_2);

        if(var_2 == var_1) {
          break;
        }
      }
    }
  } else
    common_scripts\utility::flag_wait(var_0.script_flag);
}

get_movement_trigger(var_0) {
  var_1 = getEntArray(var_0.targetname, "target");

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(var_3.code_classname == "trigger_multiple")
        return var_3;
    }
  } else {
    var_5 = var_0 common_scripts\utility::get_linked_ents();

    foreach(var_7 in var_5) {
      if(var_7.code_classname == "trigger_multiple")
        return var_7;
    }
  }

  return undefined;
}

get_movement_node(var_0) {
  if(!isDefined(var_0))
    var_0 = self.target;

  var_1 = undefined;

  if(isDefined(var_0)) {
    var_1 = getnode(var_0, "targetname");

    if(!isDefined(var_1))
      var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  }

  return var_1;
}

delay_disable_exits() {
  self endon("death");
  self endon("scripted_movement_next_goal");
  self endon("scripted_movement_done");
  wait 2;
  maps\_utility::disable_exits();
}

scripted_goto_goal(var_0) {
  self endon("stop_scripted_movement");
  var_1 = 0;
  var_2 = get_movement_trigger(var_0);

  if(isDefined(var_2)) {
    var_2 endon("trigger");

    if(isDefined(var_2.script_flag)) {
      if(common_scripts\utility::flag(var_2.script_flag))
        return;
      else
        level endon(var_2.script_flag);
    }
  }

  if(isDefined(var_0.radius) && var_0.radius != 0)
    self.goalradius = var_0.radius;

  if(isDefined(var_0.script_flag_wait)) {
    if(!common_scripts\utility::flag(var_0.script_flag_wait))
      level endon(var_0.script_flag_wait);
    else
      return;
  }

  var_3 = 0;

  if(isDefined(var_0.script_animation)) {
    var_3 = 1;
    var_0 maps\_anim::anim_reach_solo(self, var_0.script_animation);

    if(isDefined(var_0.script_timeout))
      maps\_utility::delaythread(var_0.script_timeout, maps\_utility::anim_stopanimscripted);

    var_0 maps\_anim::anim_single_solo(self, var_0.script_animation);
  } else if(isDefined(var_0.animation)) {
    if(isDefined(level.scr_anim["generic"][var_0.animation])) {
      var_4 = maps\_utility::getanim_generic(var_0.animation);

      if(isDefined(var_4)) {
        var_3 = 1;
        var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
        var_0 maps\_anim::anim_generic(self, var_0.animation);
      }
    }
  }

  if(!var_3) {
    if(isDefined(var_0.type))
      self setgoalnode(var_0);
    else
      self setgoalpos(var_0.origin);

    self waittill("goal");
  }

  if(isDefined(var_0.script_sound))
    thread maps\_utility::smart_dialogue(var_0.script_sound);

  if(isDefined(var_0.script_flag_set))
    common_scripts\utility::flag_set(var_0.script_flag_set);

  var_0 maps\_utility::script_delay();

  if(var_1) {
    self.type = undefined;
    self.scriptedarrivalent = undefined;
  }
}

is_stop_goal(var_0) {
  if(isDefined(var_0.script_flag_wait)) {
    if(!common_scripts\utility::flag(var_0.script_flag_wait))
      return 1;
  }

  if(isDefined(var_0.script_noteworthy))
    return 1;

  if(isDefined(var_0.script_stopnode) && var_0.script_stopnode)
    return 1;

  if(!isDefined(var_0.target))
    return 1;

  return 0;
}

vehicle_path_notifies() {
  self endon("death");
  var_0["reset_pitchroll"] = ::chopper_reset_pitchroll;
  var_0["chopper_holding"] = ::chopper_holding;
  var_0["spawn_target"] = ::spawn_node_target;
  var_0["end_chopper_crash"] = ::end_chopper_crash;
  var_0["explode"] = ::explode;

  for(;;) {
    self waittill("noteworthy", var_1);

    if(isDefined(var_0[var_1]))
      self[[var_0[var_1]]]();
  }
}

chopper_reset_pitchroll() {
  self setmaxpitchroll(25, 25);
}

chopper_holding() {
  if(!isDefined(self.holding)) {
    return;
  }
  self notify("newpath");
  self notify("reached_dynamic_path_end");
}

shooter_range() {
  if(!isDefined(self.shooters)) {
    return;
  }
  self endon("unloading");
  maps\_utility::ent_flag_init("shooter_range_stop");
  thread shooter_range_flag();
  var_0 = squared(1500);
  var_1 = 0;
  var_2 = var_1;

  while(isDefined(self.shooters) && self.shooters.size > 0) {
    var_1 = 0;

    if(distance2dsquared(self.origin, level.player.origin) < var_0)
      var_1 = 1;

    if(var_2 != var_1) {
      var_2 = var_1;
      enable_shooters(var_1);
    }

    wait 0.5;
  }
}

enable_shooters(var_0) {
  if(!isDefined(self.shooters)) {
    return;
  }
  foreach(var_2 in self.shooters) {
    if(isDefined(var_2))
      var_2.ignoreall = !var_0;
  }
}

shooter_range_flag() {
  self waittill("unloading");
  maps\_utility::ent_flag_set("shooter_range_stop");
}

end_chopper_crash() {
  self.scripted_crash = "end";
}

spawn_node_target() {
  var_0 = getEntArray(self.currentnode.target, "targetname");

  foreach(var_2 in var_0) {
    if(isspawner(var_2)) {
      if(issubstr(var_2.classname, "actor")) {
        var_2 maps\_utility::spawn_ai();
        continue;
      }

      if(isDefined(var_2.script_noteworthy)) {
        if(isDefined(level.bus_chase.count[var_2.script_noteworthy])) {
          if(level.bus_chase.count[var_2.script_noteworthy] > 0)
            continue;
        }
      }

      var_3 = 0;

      if(isDefined(var_2.target)) {
        var_4 = getvehiclenode(var_2.target, "targetname");

        if(isDefined(var_4))
          var_3 = 1;
      }

      if(var_3)
        var_2 maps\_vehicle::spawn_vehicle_and_gopath();
      else
        var_2 maps\_utility::spawn_vehicle();
    }
  }
}

explode() {
  var_0 = self.health - self.healthbuffer + 1000;
  radiusdamage(self.origin, 300, var_0, var_0 * 0.75, level.player);
}

chopper_shooter_init(var_0) {
  self.state = "shooter";
  self endon(self.state);
  self.goal_pos = (0, 0, 0);
  self.goal_dist = 0;
  self.on_path = 0;
  self.do_pain = 0;
  self setneargoalnotifydist(100);
  self setyawspeed(120, 60);
  self sethoverparams(60, 20, 50);
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_1 init_follow_path();

  if(!isDefined(self.shooter_side)) {
    self.shooter_side = "right";

    if(common_scripts\utility::cointoss())
      self.shooter_side = "left";
  }

  self.lookat_ent = spawn("script_origin", (0, 0, 0));
  set_lookat_origin();
  childthread chopper_shooter_pathing(var_1);
  childthread chopper_shooter_think();
  childthread chopper_shooter_death();
  childthread clear_chopper_shooter_flag();
}

chopper_shooter_death() {
  self waittill("death");

  if(isDefined(self.angle_origin))
    self.angle_origin delete();
}

clear_chopper_shooter_flag() {
  common_scripts\utility::waittill_any("death", "exiting");
  level.courtyard.chopper_shooter_count--;

  if(level.courtyard.chopper_shooter_count == 0)
    common_scripts\utility::flag_set("chopper_shooter_is_needed");
}

chopper_shooter_think() {
  self endon("death");
  self endon(self.state);
  var_0 = (self.health - self.healthbuffer) * 0.75 + self.healthbuffer;
  var_1 = 0;
  chopper_dialogue("spotted");

  for(;;) {
    wait 0.05;
    self.shooters = maps\_utility::array_removedead_or_dying(self.shooters);
    self.shooters = common_scripts\utility::array_removeundefined(self.shooters);

    if(!var_1 && self.health < var_0) {
      var_1 = 1;
      self.do_pain = 1;
      self setyawspeed(80, 30);
      self sethoverparams(200, 50, 100);
      chopper_dialogue("damage");
      thread chopper_pain_fx();
    }

    if(self.shooters.size == 0) {
      wait 1;
      self notify("stop_pathing");
      self clearlookatent();
      chopper_exit();
      break;
    } else if(self.shooters.size < 4)
      try_chopper_switch_sides();
  }
}

chopper_pain_fx() {
  self endon("death");
  var_0 = "tag_engine_left";
  var_1 = anglesToForward(self gettagangles(var_0));
  playFX(common_scripts\utility::getfx("aas_72x_damage_explosion"), self gettagorigin(var_0), var_1);
  self playSound("aascout72x_helicopter_secondary_exp");

  for(;;) {
    var_2 = self gettagangles(var_0);
    var_1 = anglesToForward(var_2);
    playFX(common_scripts\utility::getfx("aas_72x_damage_trail"), self gettagorigin(var_0), var_1);
    wait(randomfloatrange(0.05, 0.2));
  }
}

try_chopper_switch_sides() {
  foreach(var_1 in self.shooters) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    if(self.shooter_side == "right") {
      if(var_1.vehicle_position < 4)
        return;
    } else if(var_1.vehicle_position > 3)
      return;
  }

  chopper_dialogue("rotate");
  set_opposite_shooter_side();
}

chopper_dialogue(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "damage":
      var_1 = ["vegas_sp3_takingtoomuchdamage", "vegas_sp3_werehit"];
      break;
    case "moving_away":
      var_1 = ["vegas_sp3_movingaway", "vegas_sp3_gettingoutofhere"];
      break;
    case "spotted":
      var_1 = ["vegas_sp3_theretheyare"];
      break;
    case "rotate":
      var_1 = ["vegas_sp3_switchingsides", "vegas_sp3_rotating"];
      break;
  }

  var_2 = var_1[randomint(var_1.size)];
  thread play_enemy_radio(var_2);
}

set_opposite_shooter_side() {
  if(self.shooter_side == "left")
    self.shooter_side = "right";
  else
    self.shooter_side = "left";
}

chopper_shooter_lookat_think() {
  self endon("stop_pathing");
  self endon("death");
  self setlookatent(self.lookat_ent);

  for(;;) {
    wait 0.2;
    set_lookat_origin();
  }
}

set_lookat_origin() {
  var_0 = vectortoangles(level.player.origin - self.origin);
  var_1 = anglesToForward(var_0);
  var_2 = anglestoright(var_0);

  if(self.on_path && self.do_pain) {
    var_3 = 120;

    if(common_scripts\utility::cointoss())
      var_3 = -120;

    var_2 = anglestoright(var_0 + (0, var_3, 0));
  }

  var_4 = var_2;

  if(self.shooter_side == "right")
    var_4 = var_2 * -1;

  self.lookat_ent.origin = self.origin + var_4 * 100;
}

chopper_shooter_pathing(var_0) {
  thread chopper_shooter_movement(var_0);
  self endon("death");
  self endon("stop_pathing");

  for(;;) {
    wait 0.1;
    var_4 = get_pos_data_on_path(var_0, level.player.origin);
    var_5 = var_4["pos"];
    var_6 = var_4["index"];
    var_7 = var_0.path[var_6];
    var_8 = distance(var_5, var_7.origin);
    var_9 = var_7.dist + var_8;
    var_10 = 0;

    if(var_9 > 0) {
      var_10 = var_9 / var_0.total_dist;
      var_10 = round_to(var_10, 100);
    }

    var_11 = 800;

    if(var_9 == 0) {
      var_12 = distance2d(level.player.origin, var_0.origin);
      var_11 = var_11 - var_12;
    }

    self.goal_dist = max(var_9 + var_11, 0);
  }
}

get_pos_data_on_path(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(var_4 = 0; var_4 < var_0.path.size - 1; var_4++) {
    if(isDefined(var_0.path[var_4].skip)) {
      var_3++;
      continue;
    }

    if(isDefined(var_0.path[var_4].locked)) {
      break;
    }

    var_5 = pointonsegmentnearesttopoint(var_0.path[var_4].origin, var_0.path[var_4 + 1].origin, var_1);
    var_2[var_2.size] = var_5;
  }

  var_6 = get_closest_index_in_array(var_2, var_1);
  var_7 = var_2[var_6];
  var_8["pos"] = var_7;
  var_8["index"] = var_6 + var_3;
  var_8["node"] = var_0.path[var_8["index"]];
  return var_8;
}

path_unlocks() {
  self endon("death");
  var_0 = get_chained_vehiclenodes(self.attachedpath);

  foreach(var_5, var_2 in var_0) {
    if(!isDefined(var_2.script_linkto)) {
      continue;
    }
    var_2 waittill("trigger");
    var_3 = common_scripts\utility::getstruct(var_2.script_linkto, "script_linkname");

    for(var_4 = 0; var_4 < var_5; var_4++)
      var_0[var_4].skip = 1;

    var_3.locked = undefined;
  }
}

get_path_pos_from_dist(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 50;

  var_3 = undefined;

  if(self.on_path)
    var_3 = onpath_get_path_pos_from_dist(var_0, var_1, var_2);
  else {
    self.goal_pos_stop = 1;

    for(var_4 = 0; var_4 < var_0.path.size - 1; var_4++) {
      if(var_1 > var_0.path[var_4 + 1].dist) {
        continue;
      }
      var_5 = vectornormalize(var_0.path[var_4 + 1].origin - var_0.path[var_4].origin);
      var_6 = var_1 - var_0.path[var_4].dist;
      var_3 = var_0.path[var_4].origin + var_5 * var_6;
      break;
    }
  }

  return var_3;
}

onpath_get_path_pos_from_dist(var_0, var_1, var_2, var_3) {
  return get_path_pos_from_dist_and_origin(self.origin, var_0, var_1, var_2, var_3);
}

get_path_pos_from_dist_and_origin(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4))
    var_0 = var_0 + anglesToForward(self.angles) * var_4;

  var_5 = get_pos_data_on_path(var_1, var_0);
  path_reached_node(var_5["node"], var_5["index"]);
  var_6 = var_5["index"];

  if(var_2 > var_1.path[var_6 + 1].dist + var_3) {
    self.goal_pos_stop = 0;
    return var_1.path[var_6 + 1].origin;
  } else if(var_6 > 0 && var_2 < var_1.path[var_6 - 1].dist - var_3) {
    self.goal_pos_stop = 0;
    return var_1.path[var_6 - 1].origin;
  }

  self.goal_pos_stop = 1;
  var_7 = vectornormalize(var_1.path[var_6 + 1].origin - var_1.path[var_6].origin);
  var_8 = var_2 - var_1.path[var_6].dist;
  return var_1.path[var_6].origin + var_7 * var_8;
}

get_path_pos_from_dist_ignore_segments(var_0, var_1, var_2) {
  var_3 = -1;

  foreach(var_6, var_5 in var_1.path) {
    if(var_5.dist > var_2) {
      var_3 = var_6 - 1;
      break;
    }
  }

  if(var_3 == -1)
    return var_1.path[var_1.path.size - 1].origin;

  var_7 = vectornormalize(var_1.path[var_3 + 1].origin - var_1.path[var_3].origin);
  var_8 = var_2 - var_1.path[var_3].dist;
  return var_1.path[var_3].origin + var_7 * var_8;
}

path_reached_node(var_0, var_1) {
  if(!isDefined(self.segment_index))
    self.segment_index = -1;

  if(self.segment_index < var_1) {
    self.segment_index = var_1;

    if(isDefined(var_0.script_fightdist))
      self.fightdist = var_0.script_fightdist;

    if(isDefined(var_0.script_multiplier))
      self.speed_mult = var_0.script_multiplier;

    if(isDefined(var_0.script_noteworthy))
      self notify("noteworthy", var_0.script_noteworthy);

    if(isDefined(var_0.speed)) {
      if(var_0.speed <= 0)
        self.speed = undefined;
      else
        self.speed = var_0.speed;
    }

    if(isDefined(var_0.script_flag_wait))
      self.flag_wait = var_0.script_flag_wait;
  }
}

path_process_ent() {}

get_path_dist(var_0, var_1) {
  var_2 = get_pos_data_on_path(var_0, var_1);
  var_3 = var_2["pos"];
  var_4 = var_2["index"];
  var_5 = var_0.path[var_4];
  var_6 = distance(var_3, var_5.origin);
  var_7 = var_5.dist + var_6;
  return var_7;
}

chopper_shooter_movement(var_0) {
  self endon("death");
  self endon("stop_pathing");
  var_1 = squared(20);
  var_2 = (0, 0, 100);
  var_3 = 0;

  for(;;) {
    wait 0.05;

    if(self.on_path && self.do_pain) {
      self setneargoalnotifydist(20);
      wait 0.05;
      self vehicle_setspeed(60, 15, 50);
      var_3 = 1;
      var_4 = randomint(360);
      var_5 = anglesToForward((0, var_4, 0)) * 100;

      if(chance(90))
        var_2 = var_5 + (0, 0, -100);
      else
        var_2 = var_5 + (0, 0, 150);
    }

    var_6 = get_path_pos_from_dist(var_0, self.goal_dist);
    var_6 = var_6 + var_2;

    if(!self.on_path)
      self.starting_pos = var_6;

    if(distancesquared(self.origin, var_6) < var_1) {
      continue;
    }
    thread chopper_debug_goal_pos(var_6, self.goal_dist);
    self setvehgoalpos(var_6, self.goal_pos_stop);
    var_7 = chopper_shooter_waittill_goal(var_6);

    if(self.on_path && var_3) {
      wait 3;
      self setneargoalnotifydist(100);
      self vehicle_setspeed(30, 15, 50);
      var_3 = 0;
      self.do_pain = 0;
      var_2 = (0, 0, 0);
    }

    if(!self.on_path && var_7) {
      self vehicle_setspeed(30, 15, 50);
      self.on_path = 1;
      thread chopper_shooter_lookat_think();
      var_2 = (0, 0, 0);
    }
  }
}

chopper_shooter_waittill_goal(var_0) {
  self endon("death");

  if(self.on_path)
    var_1 = common_scripts\utility::waittill_any("near_goal", "goal");
  else {
    var_2 = self.goal_dist;

    for(;;) {
      wait 0.05;

      if(distancesquared(var_0, self.origin) < squared(100))
        return 1;

      if(abs(var_2 - self.goal_dist) > 10)
        return 0;
    }
  }

  return 1;
}

chopper_debug_node_dist() {}

chopper_debug_goal_pos(var_0, var_1) {}

init_follow_path() {
  if(isDefined(self.path)) {
    return;
  }
  var_0 = 0;
  var_1 = get_targeted_ents();

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    var_3 = var_1[var_2];
    var_3.segment_index = var_2;

    if(isDefined(var_3.script_linkname))
      var_3.locked = 1;

    var_4 = distance(var_1[var_2].origin, var_1[var_2 + 1].origin);
    var_3.dist = var_0;
    var_0 = var_0 + var_4;
    var_3.segment_dist = var_4;
  }

  var_1[var_1.size - 1].dist = var_0;
  self.total_dist = var_0;
  self.path = var_1;
}

chopper_unload(var_0) {
  if(!isDefined(var_0))
    var_0 = "chopper_landing";

  var_1 = get_sorted_structs(var_0, self.origin);
  var_2 = get_unused_struct(var_1);
  var_2.inuse = 1;
  var_2 thread reset_inuse(self, "reached_dynamic_path_end");
  self.state = "unloading";
  self setyawspeed(90, 45);
  thread maps\_vehicle::vehicle_paths(var_2, 0);
}

chopper_exit() {
  self endon("death");
  self notify("exiting");
  chopper_dialogue("moving_away");
  var_0 = get_sorted_structs("chopper_exit", self.origin);
  var_1 = get_unused_struct(var_0);
  self.inuse = 1;
  var_1 thread reset_inuse(self);
  maps\_vehicle::vehicle_paths(var_1, 0);
}

reset_inuse(var_0, var_1, var_2) {
  var_0 common_scripts\utility::waittill_any("death", var_1, var_2);
  self.inuse = 0;
}

get_unused_struct(var_0) {
  foreach(var_3, var_2 in var_0) {
    if(!isDefined(var_2.inuse))
      return var_2;

    if(!var_2.inuse)
      return var_2;
  }

  return undefined;
}

get_chopper_spawner(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_1 = common_scripts\utility::array_randomize(var_1);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.inuse) || !var_4.inuse) {
      var_2 = var_4;
      break;
    }
  }

  return var_2;
}

init_enemy_radio(var_0) {
  if(isDefined(level.enemy_radio)) {
    return;
  }
  level.enemy_radio = spawn("script_model", (0, 0, 0));
  level.enemy_radio setModel("com_hand_radio");

  if(isDefined(var_0))
    level.enemy_radio linkto(level.hesh, "tag_stowed_hip_rear", (6, -8, 10), (90, 20, -5));
}

play_enemy_radio(var_0, var_1) {
  init_enemy_radio(1);

  if(!isDefined(var_1))
    radio_queue(var_0);
  else
    level.enemy_radio maps\_utility::play_sound_on_entity(var_0);
}

radio_queue(var_0) {
  level.enemy_radio maps\_utility::function_stack(::player_enemy_radio_internal, var_0);
}

player_enemy_radio_internal(var_0) {
  level.enemy_radio playSound(var_0, "sound_done", 1);
  level.enemy_radio waittill("sound_done");
  wait 0.1;
}

array_play_enemy_radio(var_0) {
  init_enemy_radio(1);
  level.enemy_radio notify("stop_enemy_radio_array");
  level.enemy_radio endon("stop_enemy_radio_array");
  level.enemy_radio stopsounds();

  foreach(var_3, var_2 in var_0) {
    if(isstring(var_2)) {
      play_enemy_radio(var_2);
      continue;
    }

    wait(var_2);
  }
}

radio_volume(var_0, var_1) {
  init_enemy_radio();
  var_0 = var_0 * 0.55;
  level.enemy_radio scalevolume(var_0, var_1);
}

build_aianims_override(var_0, var_1, var_2) {
  level.vehicle_aianims[var_0] = [[var_1]]();

  if(isDefined(var_2))
    level.vehicle_aianims[var_0] = [
      [var_2]
    ](level.vehicle_aianims[var_0]);
}

enemy_radio_battle_loop() {
  level endon("stop_enemy_radio_chatter");
  level notify("stop_random_radio_chatter");
  var_0 = 1;
  var_1 = 0;
  var_2 = get_radio_chatter("battle");
  var_2 = common_scripts\utility::array_randomize(var_2);
  var_3 = 0;

  for(;;) {
    wait 0.1;
    var_4 = gettime();

    if(var_0) {
      var_1 = var_4 + randomintrange(2000, 5000);
      var_0 = 0;
    }

    var_5 = getaiarray("axis");

    if(var_5.size > 1) {
      continue;
    }
    if(var_4 > var_1) {
      var_0 = 1;
      play_enemy_radio(var_2[var_3], 1);
      var_3++;

      if(var_3 == var_2.size) {
        var_2 = common_scripts\utility::array_randomize(var_2);
        var_3 = 0;
      }
    }
  }
}

enemy_radio_chatter(var_0) {
  if(!isDefined(level.enemy_radio_chatter)) {
    level.enemy_radio_chatter = spawnStruct();
    level.enemy_radio_chatter.list = [];
    level.enemy_radio_chatter.is_playing = 0;
  }

  var_1 = level.enemy_radio_chatter;
  var_1.list[var_1.list.size] = var_0;

  if(var_1.is_playing) {
    return;
  }
  for(var_1.is_playing = 1; var_1.list.size > 0; var_1.list = maps\_utility::array_remove_index(var_1.list, 0)) {
    var_2 = get_radio_chatter(var_1.list[0]);

    foreach(var_5, var_4 in var_2)
    play_enemy_radio(var_4, 1);
  }

  var_1.is_playing = 0;
}

get_radio_chatter(var_0) {
  var_1 = [];

  switch (var_0) {
    case "battle":
      var_1 = ["vegas_sp3_movingintoposition", "vegas_sp3_onmyway", "vegas_sp3_almostthere", "vegas_sp3_gettingintoposition", "vegas_sp3_inposition", "vegas_sp3_repositioning"];
      break;
    case "conversation_1":
      var_1 = ["vegas_fs6_wheresthatfire", "vegas_fs5_floors17through23", "vegas_fs4_weheardgunfirecoming", "vegas_fs5_whossweepingthatarea", "vegas_fs6_thatsestebansteambuttheyre", "vegas_fs4_floor16isclear", "vegas_fs5_wereheadinguptothe", "vegas_fs4_soolidcopykeepus"];
      break;
    case "conversation_2":
      var_1 = ["vegas_fs4_floor12issecure", "vegas_fs6_negativewerestillsearching", "vegas_fs4_whataboutthecasino", "vegas_fs6_estebansteamisdown", "vegas_fs4_keeplookingtheyvegot"];
      break;
    case "conversation_3":
      var_1 = ["vegas_fs5_comeonguyssomeonetalk", "vegas__threeteamsaredown", "vegas_fs5_theresfourofthem", "vegas_fs4_notheresatleasta", "vegas__didtheygetreinforcements", "vegas_fs4_theresonlyfourof"];
      break;
    case "sitrep":
      var_1 = ["vegas_fs5_allteamssitrep", "vegas_fs6_teamsixcheckingin", "vegas_fs4_teamsevenareasecure", "vegas__teameightareasecure"];
      break;
    case "reinforcements":
      var_1 = ["vegas_fs4_wardenwhatsthestatus", "vegas_fs5_negativeonthatrequest", "vegas_fs4_thisplaceisgigantic", "vegas_fs5_justgetitdone"];
      break;
    case "convoy":
      var_1 = ["vegas_fs5_teamsevearethe", "vegas_fs6_rogerwerereadyto", "vegas_fs5_goodworktheboss", "vegas_fs6_copythatwereon"];
      break;
  }

  return var_1;
}

random_radio_chatter() {
  level endon("stop_random_radio_chatter");
  var_0 = ["sitrep", "reinforcements", "convoy"];

  foreach(var_3, var_2 in var_0) {
    enemy_radio_chatter(var_2);
    wait(randomfloatrange(3, 8));
  }
}

is_start_point_before(var_0) {
  var_1 = get_index_of_start(var_0);
  var_2 = get_index_of_start(level.start_point);

  if(isDefined(var_1) && isDefined(var_2))
    return var_2 < var_1;

  return undefined;
}

is_start_point_after(var_0) {
  var_1 = get_index_of_start(var_0);
  var_2 = get_index_of_start(level.start_point);

  if(isDefined(var_1) && isDefined(var_2))
    return var_2 > var_1;

  return undefined;
}

get_index_of_start(var_0) {
  foreach(var_3, var_2 in level.start_functions) {
    if(var_2["name"] == var_0)
      return var_3;
  }

  return undefined;
}

enable_outline(var_0) {
  if(isstring(var_0)) {
    var_1["white"] = 0;
    var_1["red"] = 1;
    var_1["green"] = 2;
    var_1["blue"] = 3;
    var_1["orange"] = 4;
    var_1["yellow"] = 5;
    var_0 = var_1[var_0];
  }

  self.outline_color = var_0;

  if(!isDefined(level.outline_ents))
    level.outline_ents = [];

  if(level.outline_ents.size == 0)
    setsaveddvar("r_hudoutlineenable", "1");

  self hudoutlineenable(var_0, 0);
  level.outline_ents = common_scripts\utility::array_removeundefined(level.outline_ents);

  if(!common_scripts\utility::array_contains(level.outline_ents, self))
    level.outline_ents[level.outline_ents.size] = self;
}

disable_outline() {
  self.outline_color = undefined;

  if(!isDefined(level.outline_ents))
    level.outline_ents = [];

  level.outline_ents common_scripts\utility::array_removeundefined(level.outline_ents);
  level.outline_ents = common_scripts\utility::array_remove(level.outline_ents, self);
  self hudoutlinedisable();

  if(level.outline_ents.size == 0)
    setsaveddvar("r_hudoutlineenable", "0");
}

anim_viewhands(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "tag_player";

  level.player setstance("stand");
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.player disableweapons();
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  var_2 hide();
  maps\_anim::anim_first_frame_solo(var_2, var_0);
  var_2 common_scripts\utility::delaycall(0.4, ::show);
  level.player playerlinktoblend(var_2, "tag_origin", 0.4, 0.2, 0.2);
  maps\_anim::anim_single_solo(var_2, var_0);
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.player enableweapons();
  var_2 delete();
  level.player unlink();
  level.player notify(var_0);
}

init_player_body(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level.player takeallweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(!isDefined(level.player.body))
    level.player.body = maps\_utility::spawn_anim_model("player_body");

  if(var_0 && !isDefined(level.player.link))
    level.player.link = common_scripts\utility::spawn_tag_origin();

  if(!isDefined(level.player.rig)) {
    level.player.rig = maps\_utility::spawn_anim_model("player_rig");
    level.player.rig hide();
  }
}

setup_player_body(var_0, var_1) {
  wait 0.05;
  level.player.link.origin = level.player.body gettagorigin("tag_sync");
  level.player.link.angles = level.player.body gettagangles("j_head");
  level.player.link linkto(level.player.body, "j_head");
  level.player.rig.origin = level.player.body gettagorigin("tag_sync");
  level.player.rig.angles = level.player.body gettagangles("tag_sync");
  level.player.rig linkto(level.player.body, "tag_sync", (0, 0, 2), (0, 0, 0));
}

do_player_drag(var_0) {
  level.player enableslowaim(0.5, 0.5);
  cleanup_player_drag();
  level notify("stop_player_drag");
  level endon("stop_player_drag");
  init_player_body(1);
  level.player.body.origin = common_scripts\utility::drop_to_ground(var_0.origin, 10, -100);
  level.player.body maps\_anim::anim_first_frame_solo(level.player.body, "drag_single");
  var_1 = getent("drag_enemy_spawner", "targetname");
  var_2 = var_1 spawndrone();
  var_2.animname = "enemy";
  var_2 maps\_anim::setanimtree();
  level.drag_mover = var_2;
  var_2.origin = common_scripts\utility::drop_to_ground(var_0.origin, 10, -100);
  var_2.angles = var_0.angles;
  level.player.body linkto(var_2, "tag_origin");
  setup_player_body();
  level.player playerlinktodelta(level.player.rig, "tag_origin", 0.5, 0, 0, 0, 40, 0);
  level.player lerpviewangleclamp(10, 0, 0, 45, 45, 60, 35);
  level.player setplayerangles((randomfloatrange(20, 35), level.player.angles[1], 0));
  var_2 thread drone_anim_loop([var_2], "drag");
  var_2 thread maps\_anim::anim_loop_solo(level.player.body, "drag_loop");
  var_2 drag_path(var_0);

  if(isDefined(level.drag_enemies))
    common_scripts\utility::array_call(level.drag_enemies, ::delete);

  level.drag_enemies = undefined;
  level.player disableslowaim();
  cleanup_player_drag();
}

do_hesh_drag(var_0) {
  var_1 = getent("drag_enemy_spawner", "targetname");
  var_2 = var_1 spawndrone();
  var_2.animname = "enemy";
  var_2 maps\_anim::setanimtree();
  var_1 = getent("drag_hesh_spawner", "targetname");
  var_3 = var_1 spawndrone();
  var_3.animname = "hesh";
  var_3 maps\_anim::setanimtree();
  var_3 linkto(var_2, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 = [var_3, var_2];
  var_2 thread drone_anim_loop(var_4, "drag");
  var_2 maps\_utility::delaythread(3.0, maps\_utility::play_sound_on_entity, "scn_vegas_dragged1_npc");
  var_2.origin = common_scripts\utility::drop_to_ground(var_0.origin, 10, -100);
  var_2.angles = var_0.angles;
  var_2 drag_path(var_0);
  common_scripts\utility::array_call(var_4, ::delete);
}

drone_anim_loop(var_0, var_1) {
  self endon("death");

  for(;;) {
    foreach(var_3 in var_0)
    var_3 thread drone_anim(var_1);

    self waittillmatch("drone_loop", "end");
  }
}

drone_anim(var_0) {
  self endon("death");
  var_1 = maps\_utility::getanim(var_0);
  self setflaggedanimrestart("drone_loop", var_1[0], 1, 0.2, 1);
}

drag_path(var_0) {
  self endon("death");
  var_1 = 100;
  var_2 = var_0.angles;
  var_3 = 40;
  var_4 = 10;
  var_5 = var_4 / var_3;
  var_0 init_follow_path();
  self.on_path = 1;
  var_6 = var_0.origin;
  var_7 = 0;

  for(;;) {
    var_8 = get_pos_data_on_path(var_0, var_6);

    if(isDefined(var_8["node"].speed)) {
      var_3 = var_8["node"].speed;
      var_5 = var_4 / var_3;
      var_8["node"].speed = undefined;
    }

    if(isDefined(var_8["node"].script_flag_set)) {
      common_scripts\utility::flag_set(var_8["node"].script_flag_set);
      var_8["node"].script_flag_set = undefined;
    }

    var_9 = var_8["node"].dist + distance(var_8["node"].origin, var_6);

    if(var_0.total_dist - var_9 < var_1) {
      var_10 = var_0.path[var_0.path.size - 1].origin;
      var_7 = 1;
    } else {
      var_10 = get_path_pos_from_dist_ignore_segments(var_6, var_0, var_1 + var_9);
      var_11 = vectornormalize(var_10 - var_6);
      var_10 = var_6 + var_11 * var_4;
    }

    var_6 = var_10;
    var_10 = common_scripts\utility::drop_to_ground(var_10, 10, -100);
    self moveto(var_10, var_5);
    var_2 = vectortoangles(var_10 - self.origin);
    self rotateto(var_2, var_5);
    wait(var_5 - 0.05);

    if(var_7) {
      break;
    }
  }
}

cleanup_player_drag() {
  if(isDefined(level.drag_mover)) {
    level.drag_mover maps\_utility::anim_stopanimscripted();
    level.drag_mover delete();
    level notify("stop_debug_drag_lines");
    level.player.body unlink();
  }
}

debug_drag_lines(var_0, var_1, var_2, var_3) {
  level notify("stop_debug_drag_lines");
  level endon("stop_debug_drag_lines");

  while(isDefined(var_0))
    wait 0.05;
}

spawn_drone_dog() {
  var_0 = getent("riley_drone_spawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 spawndrone();
  var_1 maps\_utility_dogs::set_dog_model("fullbody_dog_b_hurt");
  var_1.animname = "dog";
  var_1 maps\_anim::setanimtree();
  return var_1;
}

dog_init_pickup() {
  level.dog.obj_model = "fullbody_dog_b_cam_obj_hurt";
  level.dog.reg_model = "fullbody_dog_b_hurt";
  level.dog maps\_utility_dogs::set_dog_model(level.dog.obj_model);
  level.dog notsolid();
  level.dog.use_trigger = getent("dog_trigger", "targetname");
  level.dog.use_trigger.og_origin = level.dog.use_trigger.origin;

  if(!level.dog maps\_utility::ent_flag_exist("picked_up"))
    level.dog maps\_utility::ent_flag_init("picked_up");

  if(!level.dog maps\_utility::ent_flag_exist("disable_put_down"))
    level.dog maps\_utility::ent_flag_init("disable_put_down");
}

dog_enable_trigger() {
  self.use_trigger.origin = self.origin;
}

dog_disable_trigger() {
  self.use_trigger.origin = self.use_trigger.og_origin;
}

dog_thread() {
  common_scripts\utility::flag_set("dog_pickup_ready");
  level thread dog_nag();
  thread dog_loop_audio();
  dog_init_pickup();
  dog_enable_trigger();
  level thread dog_too_far_fail();
  dog_blood_pool();

  if(level.console || level.player usinggamepad()) {
    self sethintstring(&"LAS_VEGAS_PICKUP_RILEY");
    self.use_trigger sethintstring(&"LAS_VEGAS_PUTDOWN_RILEY");
  } else {
    self sethintstring(&"LAS_VEGAS_PICKUP_RILEY_PC");
    self.use_trigger sethintstring(&"LAS_VEGAS_PUTDOWN_RILEY_PC");
  }

  dog_disable_trigger();
  var_0 = 0;
  var_1 = 2;

  if(var_0)
    var_1 = 0.5;

  for(;;) {
    for(;;) {
      thread dog_pickup_thread();
      self waittill("trigger");

      if(dog_pickup_final_check()) {
        break;
      }
    }

    self makeunusable();
    dog_disable_trigger();
    dog_pickup();
    wait(var_1);
    thread dog_put_down_trigger_thread();
    self.use_trigger waittill("trigger");
    dog_put_down();
    dog_disable_trigger();
    wait(var_1);
  }
}

dog_blood_pool() {
  var_0 = level.dog.origin;
  var_1 = anglesToForward((270, randomint(360), 0));
  playFX(common_scripts\utility::getfx("crawling_death_blood_smear"), var_0, var_1);
}

dog_pickup_thread() {
  self endon("trigger");
  var_0 = 1;

  for(;;) {
    if(dog_pickup_check())
      self makeusable();
    else
      self makeunusable();

    wait 0.05;
  }
}

dog_pickup_final_check() {
  if(level.player ismeleeing())
    return 0;

  if(level.player ismantling())
    return 0;

  var_0 = level.player.origin + (0, 0, 1);
  var_1 = playerphysicstrace(level.player.origin, var_0);

  if(var_1 != var_0)
    return 0;

  return 1;
}

dog_pickup_check() {
  if(level.player ismeleeing())
    return 0;

  if(level.player ismantling())
    return 0;

  if(!maps\_utility::player_looking_at(self.origin, 0.8))
    return 0;

  var_0 = level.player.origin + (0, 0, 1);
  var_1 = playerphysicstrace(level.player.origin, var_0);

  if(var_1 != var_0)
    return 0;

  return 1;
}

dog_put_down_trigger_thread() {
  var_0 = self.use_trigger;
  self endon("disable_put_down");
  var_0 endon("trigger");

  for(;;) {
    wait 0.05;
    var_0.origin = var_0.origin + (0, 0, -1500);

    if(maps\_utility::ent_flag("disable_put_down")) {
      continue;
    }
    if(!level.player isonground()) {
      continue;
    }
    var_2 = level.player getEye();
    var_3 = level.player getplayerangles();
    var_4 = var_3[0] + 15;
    var_4 = clamp(var_4, 70, 80);
    var_5 = anglesToForward((var_4, var_3[1], 0));
    var_6 = var_2 + var_5 * 500;
    var_7 = bulletTrace(var_2, var_6, 1, level.player);
    var_8 = physicstrace(var_2, var_6);

    if(var_8 != var_7["position"]) {
      continue;
    }
    if(var_7["position"][2] > level.player.origin[2] + 26) {
      continue;
    }
    if(distance(level.player.origin, var_8) > 100) {
      continue;
    }
    if(!up_normal(var_7["normal"])) {
      continue;
    }
    if(!dog_place_clear(var_8)) {
      continue;
    }
    level.dog.place_pos = var_8;
    var_0.origin = level.player.origin;
  }
}

up_normal(var_0) {
  var_1 = 0.25;

  if(abs(var_0[0]) > var_1)
    return 0;

  if(abs(var_0[1]) > var_1)
    return 0;

  return var_0[2] >= 1 - var_1;
}

dog_place_clear(var_0) {
  var_1 = getdvarint("debug_dog_place");
  var_2 = 6;
  var_3 = 360 / var_2;
  var_4 = squared(0.01);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = (-50, var_5 * var_3, 0);
    var_7 = anglesToForward(var_6);
    var_8 = var_0 + var_7 * 48;
    var_9 = physicstrace(var_0, var_8);
    var_10 = distancesquared(var_9, var_8);

    if(var_10 > var_4)
      return 0;

    var_9 = physicstrace(var_8 + (0, 0, 42), var_8);

    if(var_10 > var_4)
      return 0;
  }

  return 1;
}

#using_animtree("dog");

dog_carry_thread() {
  self endon("stop_carry_thread");
  self useanimtree(#animtree);
  var_0 = % vegas_dog_carry_dog_1;
  var_1 = % vegas_dog_carry_dog_move;
  var_2 = 152;
  var_3 = 20;
  var_4 = var_2 - var_3;
  var_5 = -1;

  for(;;) {
    var_6 = level.player getvelocity();
    var_7 = length(var_6);

    if(var_5 != var_7) {
      var_8 = var_7 / var_2;
      var_5 = var_7;
      var_8 = clamp(var_8, 0, 1);
      self setanim(var_0, 1 - var_8, 0.2);
      self setanim(var_1, var_8, 0.2);
    }

    wait 0.05;
  }
}

dog_pickup() {
  maps\_utility_dogs::set_dog_model(self.reg_model);
  common_scripts\utility::flag_set("dog_first_pickup");
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  var_0 hide();
  var_0.angles = (0, level.player.angles[1], 0);
  var_0 maps\_anim::anim_first_frame_solo(var_0, "dog_pickup");
  var_1 = (-12, 20, -57);
  var_2 = (5, -10, 20);
  level.player playerlinktoblend(var_0, "tag_player", 0.4);
  level.player common_scripts\utility::delaycall(0.4, ::playrumbleonentity, "damage_light");
  dog_player_pickup_start();
  var_3 = [var_0, self];
  level.player playSound("scn_vegas_dog_pick_up");
  var_0 thread maps\_anim::anim_single_solo(var_0, "dog_pickup");
  var_4 = makestruct();
  var_4 thread maps\_anim::anim_single_solo(self, "dog_pickup");
  wait 0.45;
  level.player playerlinktodelta(var_0, "tag_player", 1, 30, 30, 30, 30, 1);
  self linktoplayerviewignoreparentrot(level.player, "tag_origin", var_1, var_2, 1, 0, 1, 0);
  self notsolid();
  self dontcastshadows();
  badplace_delete("dog_place");
  var_0 waittillmatch("single anim", "end");
  dog_player_pickup_end();
  maps\_utility::anim_stopanimscripted();
  thread dog_carry_thread();
  level.player unlink();
  var_0 delete();
  maps\_utility::ent_flag_set("picked_up");
  objective_position(1, (0, 0, 0));
}

dog_player_pickup_start() {
  level.player allowmelee(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowstand(1);
  level.player allowjump(0);
  level.player setstance("crouch");
  setsaveddvar("mantle_enable", 0);
  level.player.last_weapon = level.player getcurrentweapon();
  level.player disableweaponpickup();
  level.player disableweaponswitch();
  level.player giveweapon("noweapon_deer_hunt");
  level.player switchtoweapon("noweapon_deer_hunt");
  level.player disableoffhandweapons();
  setsaveddvar("slide_enable", 0);
  level.player enableweapons();
  level.player enableslowaim(0.5, 0.5);
  level.player maps\_utility::player_speed_percent(80);
  level.dvar_view_pitch_down = getdvarint("player_view_pitch_down");
}

dog_player_pickup_end() {
  level.player allowprone(0);
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.player allowsprint(1);
  level.player setstance("stand");
  level.player allowmelee(0);
  setsaveddvar("player_view_pitch_down", 35);
}

dog_put_down() {
  self notify("stop_carry_thread");
  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin + (0, 0, 0), level.player.angles);
  var_0 hide();
  var_0.angles = level.player.angles;
  level.player playerlinktoblend(var_0, "tag_origin", 0.4);
  level.player common_scripts\utility::delaycall(0.4, ::playrumbleonentity, "damage_light");
  level.player playSound("scn_vegas_dog_put_down");
  dog_player_put_down_start();
  self setanim(maps\_utility::getanim("hurt_idle_single"), 1, 1);
  wait 0.4;
  level.player playerlinktodelta(var_0, "tag_origin", 1, 30, 30, 30, 30);
  wait 0.1;
  self unlinkfromplayerview(level.player);
  self.origin = self.place_pos;
  dog_plant();
  badplace_cylinder("dog_place", 0, self.origin, 64, 60);
  maps\_anim::anim_first_frame_solo(self, "hurt_idle_single");
  thread maps\_anim::anim_loop_solo(self, "hurt_idle");
  self castshadows();
  dog_blood_pool();
  dog_player_put_down_end();
  level.player unlink();
  var_0 delete();
  maps\_utility_dogs::set_dog_model(self.obj_model);
  reset_dog_nag();
  maps\_utility::ent_flag_clear("picked_up");
  objective_onentity(1, level.dog, (0, 0, 20));
  thread dog_objective_thread();
}

dog_plant() {
  var_0 = 25;
  var_1 = [25, 15];
  var_2 = (0, 0, 0);
  var_3 = level.player.angles;
  var_4 = [];

  foreach(var_10, var_0 in var_1) {
    var_6 = var_3;

    if(var_10 == 0)
      var_7 = anglestoright(var_3);
    else
      var_7 = anglesToForward(var_3);

    var_8 = self.origin + var_7 * var_0;
    var_9 = self.origin + var_7 * var_0 * -1;
    var_8 = dog_plant_trace(var_8, 30, -30);
    var_9 = dog_plant_trace(var_9, 30, -30);
    var_4[var_10] = var_8 - var_9;
  }

  var_11 = vectorcross(var_4[0], var_4[1]);
  self.angles = axistoangles(var_4[1], var_4[0], var_11);
}

dog_plant_trace(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2), 0, self);

  if(!isDefined(var_3))
    return common_scripts\utility::drop_to_ground(var_0, var_1, var_2);

  return var_3["position"];
}

dog_loop_audio() {
  self notify("stop_loop_audio");
  self endon("stop_loop_audio");
  level.next_dog_whine = gettime() + randomfloatrange(5000, 20000);
  var_0 = -1;
  var_1 = "scn_dog_vegas_hurt_down";
  var_2 = 0;
  var_3 = gettime();

  for(;;) {
    wait 0.1;
    var_4 = gettime();

    if(var_0 != maps\_utility::ent_flag("picked_up") || var_2) {
      if(maps\_utility::ent_flag("picked_up")) {
        var_1 = "scn_dog_vegas_hurt";
        level.next_dog_whine = var_4 + randomfloatrange(3000, 7000);
      } else {
        var_1 = "scn_dog_vegas_hurt_down";
        level.next_dog_whine = var_4 + randomfloatrange(2000, 7000);
      }

      var_0 = maps\_utility::ent_flag("picked_up");
    }

    if(var_4 < level.next_dog_whine && var_4 - var_3 < 10000) {
      continue;
    }
    self playSound(var_1, "dog_sound_done");
    self waittill("dog_sound_done");
    var_2 = 1;
    var_3 = var_4;
  }
}

dog_objective_thread() {
  var_0 = squared(100);
  setsaveddvar("objectivehide", "1");
  var_1 = 1;

  while(!maps\_utility::ent_flag("picked_up")) {
    var_2 = 0;

    if(distance2dsquared(level.player.origin, self.origin) < var_0)
      var_2 = 1;

    if(var_2 != var_1) {
      var_1 = var_2;
      setsaveddvar("objectivehide", var_2);
    }

    wait 0.05;
  }
}

dog_player_put_down_start() {
  level.player allowjump(0);
  level.player allowprone(0);
  level.player allowstand(0);
  level.player allowcrouch(1);
  level.player setstance("crouch");
  level.player disableweapons();
  level.player takeweapon("noweapon_deer_hunt");
}

dog_player_put_down_end() {
  level.player allowsprint(1);
  level.player allowjump(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.player setstance("stand");
  level.player allowmelee(1);
  level.player enableoffhandweapons();
  setsaveddvar("mantle_enable", 1);
  setsaveddvar("slide_enable", 1);
  level.player enableweaponpickup();
  level.player enableweaponswitch();
  level.player enableweapons();
  level.player switchtoweapon(level.player.last_weapon);
  level.player disableslowaim();
  level.player maps\_utility::player_speed_percent(100);
  setsaveddvar("player_view_pitch_down", level.dvar_view_pitch_down);
}

dog_too_far_fail() {
  var_0 = common_scripts\utility::getstruct("ground_progression", "targetname");
  var_0 init_follow_path();
  var_1 = 1200;
  var_2 = 800;
  var_3 = 0;
  var_4 = squared(1000);

  for(;;) {
    if(!level.dog maps\_utility::ent_flag("picked_up")) {
      var_5 = get_path_dist(var_0, level.player.origin);
      var_6 = get_path_dist(var_0, level.dog.origin);
      var_7 = var_5 - var_6;

      if(var_7 > var_2 && gettime() > var_3) {
        var_3 = gettime() + 3000;
        dog_nag_now();
      }

      if(distance2dsquared(level.player.origin, level.dog.origin) > var_4) {
        if(var_7 > var_1) {
          break;
        }
      }
    }

    wait 0.05;
  }

  dog_mission_fail();
}

dog_mission_fail() {
  maps\_player_death::set_deadquote(&"LAS_VEGAS_NO_DOGS_LEFT_BEHIND");
  maps\_utility::missionfailedwrapper();
}

dog_nag() {
  var_0 = 0;
  var_1 = ["vegas_hsh_loganpickupriley", "vegas_hsh_dontforgetriley", "vegas_hsh_getrileyuplets", "vegas_hsh_grabriley"];
  var_1 = common_scripts\utility::array_randomize(var_1);
  level.dog_nag_time = gettime() + randomintrange(5000, 10000);

  for(;;) {
    wait 0.05;

    if(gettime() > level.dog_nag_time) {
      reset_dog_nag();

      if(!level.dog maps\_utility::ent_flag("picked_up")) {
        level.hesh maps\_utility::smart_dialogue(var_1[var_0]);
        var_0++;
        var_0 = var_0 % var_1.size;
      }
    }
  }
}

reset_dog_nag() {
  level.dog_nag_time = gettime() + randomintrange(15000, 25000);
}

dog_nag_now() {
  if(level.dog_nag_time - gettime() < 3000) {
    return;
  }
  level.dog_nag_time = 0;
}

ending_fadeout(var_0) {
  maps\_utility::set_vision_set("lv_tunnel_overbloom", 2);
  maps\_hud_util::fade_out(var_0 * 0.8, "white");
}

ending_fadein(var_0, var_1) {
  maps\_hud_util::fade_in(var_0 * 0.2, "white");

  if(isDefined(var_1))
    maps\_utility::set_vision_set(var_1, var_0);
  else
    maps\_utility::set_vision_set("", var_0);
}

progressional_visionset(var_0, var_1, var_2, var_3, var_4) {
  var_5 = distance(var_0.origin, var_1.origin);
  var_6 = spawnStruct();
  var_6.script_visionset_start = var_2;
  var_6.script_visionset_end = var_3;
  var_7 = 0;

  while(var_7 < var_4) {
    var_7 = maps\_utility::get_progress(var_0.origin, var_1.origin, level.player.origin, var_5);
    maps\_trigger::vision_set_fog_progress(var_6, var_7);
    wait 0.05;
  }
}

pa_queue(var_0, var_1) {
  maps\_utility::function_stack(::pa_playsound, var_0, var_1);
}

pa_playSound(var_0, var_1) {
  if(common_scripts\utility::flag(var_1)) {
    return;
  }
  if(!isDefined(level.pa)) {
    level.pa = spawnStruct();
    level.pa.is_playing = 0;
    level.pa.speakers = [];
    level.pa.speakers[0] = spawn("script_origin", (0, 0, 0));
    level.pa.speakers[1] = spawn("script_origin", (0, 0, 0));
    level.pa.speakers[1].distant = 1;
  }

  while(level.pa.is_playing > 0)
    wait 0.05;

  foreach(var_3 in level.pa.speakers)
  var_3 thread pa_playsound_internal(var_0);

  var_5 = common_scripts\utility::getstructarray("pa_speaker", "targetname");

  while(level.pa.is_playing) {
    var_5 = sortbydistance(var_5, level.player.origin);

    foreach(var_7, var_3 in level.pa.speakers)
    var_3.origin = var_5[var_7].origin;

    wait 0.1;
  }
}

pa_playsound_internal(var_0) {
  if(isDefined(self.distant))
    var_0 = var_0 + "_d";

  level.pa.is_playing++;
  self playSound(var_0, "sound_done");
  self waittill("sound_done");
  wait 0.1;
  level.pa.is_playing--;
}

pa_cleanup() {
  common_scripts\utility::array_call(level.pa_ents, ::delete);
  level.pa_ents = undefined;
}

launch_gas_by_targetname(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 0.3;

  if(!isDefined(var_2))
    var_2 = 0.6;

  var_3 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_3 = common_scripts\utility::array_randomize(var_3);

  foreach(var_6, var_5 in var_3) {
    thread launch_gas_grenade(var_5, var_6);
    wait(randomfloatrange(var_1, var_2));
  }
}

launch_gas_grenade(var_0, var_1) {
  if(!isDefined(level.gas_grenades))
    level.gas_grenades = [];

  var_2 = var_0.origin;

  if(var_1 < 7)
    thread common_scripts\utility::play_sound_in_space("gas_grenade_launch", var_2);

  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_3 = var_0.origin;
  var_3 = common_scripts\utility::drop_to_ground(var_3, 10, -100);
  var_3 = var_3 + (0, 0, 0);
  var_4 = spawn("script_model", var_2);
  var_4 setModel("projectile_us_smoke_grenade");
  var_4 playLoopSound("gas_loop");
  var_4 endon("death");
  level.gas_grenades[level.gas_grenades.size] = var_4;
  playFXOnTag(common_scripts\utility::getfx("gas_grenade_trail"), var_4, "polysurface22");
  var_4 movegravity_scripted(var_2, var_3, randomfloatrange(540, 600));

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = common_scripts\utility::drop_to_ground(var_4.origin, 10, -100);
  var_4 moveto(var_5 + (0, 0, 1), 0.2);
  var_4 rotateto((-90, 0, 0), 0.1);
  wait 0.2;
  var_4 playSound("gas_grenade_land_roll");
  var_6 = 50;
  var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_4 endon("death");
  var_4.fx = playFX(common_scripts\utility::getfx("gas_grenade"), var_4.origin);
  var_4 thread ambush_nade_rotate();

  while(isDefined(var_4)) {
    var_5 = common_scripts\utility::drop_to_ground(var_0.origin, 10, -100) + (0, 0, 1);
    var_7 = distance(var_4.origin, var_5);
    var_8 = var_7 / var_6;
    var_4 moveto(var_5, var_8);
    wait(var_8 - 0.05);

    if(!isDefined(var_0.target)) {
      break;
    }

    var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  }

  wait(randomfloatrange(1, 3));
  stopFXOnTag(common_scripts\utility::getfx("gas_grenade_trail"), var_4, "polysurface22");
  var_4 notify("stop_rotate");
  var_4 rotateyaw(900, 3, 0, 3);
}

ambush_nade_rotate() {
  self endon("death");
  self endon("stop_rotate");

  while(isDefined(self)) {
    var_0 = randomfloatrange(0.05, 0.1);
    self rotateyaw(90, var_0);
    wait(var_0);
  }
}

movegravity_scripted(var_0, var_1, var_2) {
  var_3 = getdvarint("g_gravity") * -1;
  var_4 = distance(var_0, var_1);
  var_5 = var_1 - var_0;
  var_6 = var_4 / var_2;
  var_7 = 0.5 * var_3 * (var_6 * var_6);
  var_8 = (var_5[0], var_5[1], var_5[2] - var_7) / var_6;
  self rotatevelocity((500, 5, 5), var_6);
  self movegravity(var_8, var_6);
  wait(var_6);
}

struct_stopanimscripted() {
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

round_to(var_0, var_1) {
  var_0 = int(var_0 * var_1) / var_1;
  return var_0;
}

get_sorted_structs(var_0, var_1) {
  var_2 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_2 = sortbydistance(var_2, var_1);
  return var_2;
}

chance(var_0) {
  var_1 = randomint(100);

  if(var_1 < var_0)
    return 1;

  return 0;
}

temp_dialogue_queue(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 2;

  var_2 = undefined;

  if(self.team == "allies")
    var_2 = "g";

  var_3 = level.scr_text[self.animname][var_0];
  thread maps\_utility::add_dialogue_line(self.name, var_3, var_2);
  wait(var_1);
}

vector2d(var_0) {
  return (var_0[0], var_0[1], 0);
}

makestruct() {
  var_0 = spawnStruct();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  return var_0;
}

ground_ref_rotate(var_0, var_1, var_2, var_3) {
  var_4 = level.player.angles;
  var_5 = anglestoaxis(var_4);
  var_6 = matrix_inverse(var_5);
  var_7 = axistoangles(var_6["forward"], var_6["right"], var_6["up"]);
  var_8 = level.ground_ref_ent.angles;
  var_9 = combineangles(var_8, var_4);
  var_9 = var_9 + var_0;
  var_9 = combineangles(var_9, var_7);
  level.ground_ref_ent rotateto(var_9, var_1, var_1 * 0.5, var_1 * 0.25);
  wait(var_1);
}

matrix_inverse(var_0) {
  var_0["right"] = var_0["right"] * -1;
  var_1["forward"] = (var_0["forward"][0], var_0["right"][0], var_0["up"][0]);
  var_1["right"] = (var_0["forward"][1], var_0["right"][1], var_0["up"][1]);
  var_1["up"] = (var_0["forward"][2], var_0["right"][2], var_0["up"][2]);
  var_1["right"] = var_1["right"] * -1;
  return var_1;
}

draw_ent_axis() {
  self endon("death");
  var_0 = 25;

  for(;;) {
    var_1 = self.origin;
    var_2 = self.angles;
    var_3 = anglesToForward(var_2) * var_0;
    var_4 = anglestoright(var_2) * var_0;
    var_5 = anglestoup(var_2) * var_0;
    wait 0.05;
  }
}

draw_axis(var_0, var_1) {
  var_2 = 25;
  var_3 = anglesToForward(var_1) * var_2;
  var_4 = anglestoright(var_1) * var_2;
  var_5 = anglestoup(var_1) * var_2;

  for(;;)
    wait 0.05;
}

flag_smart_dialogue(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait(var_0);

  if(isDefined(var_2)) {
    if(common_scripts\utility::flag(var_2))
      return;
  }

  maps\_utility::smart_dialogue(var_1);
}

add_delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.additive_delay = level.additive_delay + var_0;
  maps\_utility::delaythread(level.additive_delay, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

clear_add_delaythread() {
  level.additive_delay = 0;
}

disable_all_triggers() {
  if(isDefined(level.all_triggers_off)) {
    return;
  }
  level.all_triggers_off = 1;
  var_0 = getEntArray("trigger_multiple", "code_classname");
  common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_off);
}

enable_all_triggers() {
  if(isDefined(level.all_triggers_off) && level.all_triggers_off) {
    level.all_triggers_off = undefined;
    var_0 = getEntArray("trigger_multiple", "code_classname");
    common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_on);
  }
}

spawn_model_at_tag(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel(var_0);
  var_3.origin = var_1 gettagorigin(var_2);
  var_3.angles = var_1 gettagorigin(var_2);
  return var_3;
}

spawn_linked_model(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1.origin);
  var_3 setModel(var_0);
  var_3 linkto(var_1, var_2, (0, 0, 0), (0, 0, 0));
  return var_3;
}

print_timer() {}

print_fov() {}

custom_playsound_on_ent(var_0, var_1, var_2) {
  if(maps\_utility::is_dead_sentient()) {
    return;
  }
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3 endon("death");

  if(!isDefined(self.playsound_ents))
    self.playsound_ents = [];

  self.playsound_ents[self.playsound_ents.size] = var_3;
  thread maps\_utility::delete_on_death_wait_sound(var_3, "sounddone");

  if(isDefined(var_1))
    var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_3.origin = self.origin;
    var_3.angles = self.angles;
    var_3 linkto(self);
  }

  var_3.soundalias = var_0;
  var_3 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    if(!isDefined(maps\_utility_code::wait_for_sounddone_or_death(var_3)))
      var_3 stopsounds();

    wait 0.05;
  } else
    var_3 waittill("sounddone");

  var_3 delete();
  self.playsound_ents = common_scripts\utility::array_removeundefined(self.playsound_ents);
}

new_hand_hud() {
  var_0 = newhudelem();
  var_0.x = 35;
  var_0.y = 90;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.hidewhendead = 1;
  var_0.hidewheninmenu = 1;
  var_0.sort = 10;
  var_0.foreground = 1;
  var_0.alpha = 1;
  return var_0;
}

grab_gun_smash_count() {
  var_0["easy"] = 20;
  var_0["medium"] = 25;
  var_0["hard"] = 32;
  var_0["fu"] = 40;
  return var_0[maps\_utility::getdifficulty()];
}

struggle_smash_count() {
  var_0["easy"] = 30;
  var_0["medium"] = 50;
  var_0["hard"] = 55;
  var_0["fu"] = 60;
  return var_0[maps\_utility::getdifficulty()];
}

create_hand_hud() {
  var_0 = new_hand_hud();
  var_0 setshader("hint_usable", 32, 32);
  var_1 = new_hand_hud();
  var_1.x = var_1.x * -1;
  var_1.font = "default";
  var_1.fontscale = 2;
  var_1.width = 0;

  if(level.console || level.player usinggamepad())
    var_1 settext(&"LAS_VEGAS_PRESS_USE");
  else
    var_1 settext(&"LAS_VEGAS_PRESS_USE_PC");

  var_2["icon"] = var_0;
  var_2["text"] = var_1;
  return var_2;
}

hand_hint_thread(var_0, var_1) {
  level endon("stop_hand_hint_thread");
  level.hand_hint = spawnStruct();
  level.hand_hint.huds = create_hand_hud();

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in level.hand_hint.huds)
  var_3.alpha = 0;

  level.hand_hint.meter = 100;
  level.hand_hint.check = 90;
  level thread player_smash_use();
  level thread print_hand_meter(var_0);

  if(var_1) {
    return;
  }
  hand_hint_fade(0.95, 0.1);
  var_5 = level.hand_hint.huds["text"];

  for(;;) {
    var_5 fadeovertime(0.01);
    var_5.alpha = 0.95;
    var_5 changefontscaleovertime(0.01);
    var_5.fontscale = 2;
    wait 0.1;
    var_5 fadeovertime(0.1);
    var_5.alpha = 0.2;
    var_5 changefontscaleovertime(0.1);
    var_5.fontscale = 0.75;
    wait 0.2;
  }
}

hand_hint_fade(var_0, var_1) {
  level notify("stop_hand_hint_fade");
  level endon("stop_hand_hint_fade");

  foreach(var_3 in level.hand_hint.huds) {
    var_3 fadeovertime(var_1);
    var_3.alpha = var_0;
  }

  wait(var_1);
}

player_smash_use() {
  level endon("stop_player_smash_use");
  var_0 = level.player usebuttonpressed();
  var_1 = 0;
  level.player.smash_use_count = 0;
  var_2 = 100;
  var_3 = 1;
  var_4 = 2.5;
  var_5 = gettime();
  thread player_smash_use_audio();

  for(;;) {
    if(isDefined(level.player.smash_use_pause)) {
      wait 0.05;
      continue;
    }

    var_6 = level.player usebuttonpressed();
    var_7 = gettime();

    if(var_6 && !var_0) {
      level.player.smash_use_count++;
      var_1 = gettime();
      level.hand_hint.meter = level.hand_hint.meter + var_4;

      if(isDefined(level.player.sound_ent))
        level.player.sound_ent scalevolume(1, 0.2);

      level.player playrumbleonentity("vegas_struggle");
      cam_shake();
    } else if(var_7 > var_1 + 50) {
      level.hand_hint.meter = level.hand_hint.meter - var_3;

      if(isDefined(level.player.sound_ent))
        level.player.sound_ent scalevolume(0, 0.5);
    }

    var_0 = var_6;
    wait 0.05;
  }
}

player_smash_use_audio() {
  if(common_scripts\utility::flag("player_grabbed_gun")) {
    return;
  }
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playLoopSound("scn_vegas_torture_plr_rope_cut_loop");
  var_0 scalevolume(0, 0);
  level.player.sound_ent = var_0;
  common_scripts\utility::flag_wait("player_grabbed_gun");
  var_0 stoploopsound();
  wait 0.1;
  var_0 delete();
}

cam_shake() {
  var_0 = 0.15;
  earthquake(var_0, 1, level.player.origin, 5000);
}

player_smash_check(var_0) {
  return level.player.smash_use_count >= var_0;
}

cleanup_hand_hint() {
  hand_hint_fade(0, 1);
  level notify("stop_hand_hint_thread");

  if(isDefined(level.print_hand_meter))
    level.print_hand_meter destroy();

  common_scripts\utility::array_call(level.hand_hint.huds, ::destroy);
  level.hand_hint = undefined;
}

print_hand_meter(var_0) {}

objectives() {
  switch (level.start_point) {
    case "rescue":
    case "elias_death":
    case "drag2":
    case "drag1":
    case "ambush":
      common_scripts\utility::flag_wait("rescue_unlink_player");
    case "entrance":
    case "slide":
    case "chase":
    case "atrium":
    case "hotel":
    case "kitchen":
    case "bar":
    case "floor":
      objective_add(1, "current", & "LAS_VEGAS_OBJECTIVE_ESCAPE");
    case "exfil":
    case "entrance_combat":
      common_scripts\utility::flag_wait("dog_pickup_ready");
      objective_add(1, "current", & "LAS_VEGAS_OBJECTIVE_CARRY_RILEY");
      objective_onentity(1, level.dog, (0, 0, 20));
      common_scripts\utility::flag_wait("exfil_reached");
      wait 2;
      objective_state(1, "done");
      break;
    default:
  }
}

sun_direction(var_0) {
  if(var_0 == "hand")
    setsunflareposition((-60.82, -82.44, 0));
  else if(var_0 == "courtyard")
    setsunflareposition((-12.1948, -87.2369, 0));
  else if(var_0 == "elias_death")
    setsunflareposition((-10.5, -83.9, 0));
  else if(var_0 == "og")
    setsunflareposition((-170, -28, 0));
}

ui_show_stance(var_0) {
  setsaveddvar("hud_showstance", var_0);
}
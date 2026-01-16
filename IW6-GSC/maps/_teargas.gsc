/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_teargas.gsc
*****************************************************/

initteargas() {
  level.teargas_loaded = 1;
  precache_teargas();
  level.teargassed_ai = [];
  level.teargas_scripted_guys = [];
  level.teargas_cough_count = 0;
  level.teargas_last_cough_sound = 0;
  level.teargas_reaction_anim = [];
  level.teargas_reaction_anim[0] = "teargas_react1";
  level.teargas_reaction_anim[1] = "teargas_react2";
  level.teargas_reaction_anim[2] = "teargas_react3";
  level.teargas_recover_anim = [];
  level.teargas_recover_anim[0] = "teargas_recover1";
  level.teargas_recover_anim[1] = "teargas_recover2";
  level.teargas_recover_anim[2] = "teargas_recover3";
  level.teargas_recover_anim[3] = "teargas_recover4";
  level.teargas_recover_anim[4] = "teargas_recover5";
  level.teargas_recover_anim[5] = "teargas_recover6";
  level.teargas_recover_anim[6] = "teargas_react_inplace";
  level.teargas_cough_vo = [];
  level.teargas_cough_vo[0] = "enemyhq_fs1_coughinggaggingandhacking";
  level.teargas_cough_vo[1] = "enemyhq_fs2_coughinggaggingandhacking";
  level.teargas_cough_vo[2] = "enemyhq_fs3_coughinggaggingandhacking";
  level.teargas_cough_vo[3] = "enemyhq_fs1_coughinggaggingandhacking_2";
  level.teargas_cough_vo[4] = "enemyhq_fs2_coughinggaggingandhacking_2";
  level.teargas_cough_vo[5] = "enemyhq_fs3_coughinggaggingandhacking_2";
  level.teargas_cough_vo[6] = "enemyhq_fs1_coughinggaggingandhacking_3";
  level.teargas_cough_vo[7] = "enemyhq_fs2_coughinggaggingandhacking_3";
  level.teargas_cough_vo[8] = "enemyhq_fs3_coughinggaggingandhacking_3";
  level.teargas_cough_vo[9] = "enemyhq_fs1_coughinggaggingandhacking_4";
  level.teargas_cough_vo[10] = "enemyhq_fs2_coughinggaggingandhacking_4";
  level.teargas_cough_vo[11] = "enemyhq_fs3_coughinggaggingandhacking_4";
  level.coughing_active = 0;
  level.fake_teargas_coughing = 0;
  level.teargas_flush_volumes = getEntArray("teargas_flush_volume", "targetname");
  level.active_teargas = [];
  level._effect["default_teargas_smoke"] = loadfx("fx/smoke/teargas_grenade");
  thread handle_teargas_grenades();
  thread handle_teargas_launcher();
}

handle_teargas_grenades() {
  level.teargas_count = 0;
  level endon("death");

  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);

    if(var_1 == "teargas_grenade") {
      level.player notify("teargas_thrown");
      var_0 thread track_teargas();
    }
  }
}

handle_teargas_launcher() {
  level endon("death");

  for(;;) {
    level.player waittill("missile_fire", var_0, var_1);

    if(var_1 == "m203_teargas_m4_acog") {
      level.player notify("teargas_launched");
      var_0 thread track_teargas();
    }
  }
}

track_teargas() {
  self endon("death");
  level endon("death");
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 endon("death");
  self.exploded = 0;
  thread handle_teargas_explode(var_0);

  while(isDefined(self) && !self.exploded) {
    var_0.origin = self.origin;

    foreach(var_2 in level.teargas_flush_volumes) {
      if(var_0 istouching(var_2))
        var_2 notify("teargas_touched");
    }

    wait 0.05;
  }
}

handle_teargas_explode(var_0) {
  self waittill("explode", var_1);
  var_2 = 0;
  var_0.origin = var_1;
  var_3 = 0;

  foreach(var_5 in level.teargas_flush_volumes) {
    if(var_0 istouching(var_5)) {
      var_5 thread handle_teargas_volume(var_1);
      var_5 notify("teargas_exploded");
      var_2++;

      if(isDefined(var_5.script_parameters)) {
        var_3 = 1;
        var_5.finished = 0;

        if(!isDefined(var_5.playing_fx)) {
          var_5.playing_fx = 1;
          common_scripts\utility::exploder(int(var_5.script_parameters));
        }
      }

      var_5 thread handle_coughing();
    }
  }

  if(!var_3)
    playFX(level._effect["default_teargas_smoke"], var_1);

  if(var_2 == 0)
    thread add_teargas_cloud_radius(300, var_1);

  var_0 delete();
}

turn_off_gas() {
  wait 15;

  if(isDefined(self.playing_fx) && self.playing_fx) {
    maps\_utility::stop_exploder(int(self.script_parameters));
    self.playing_fx = undefined;
  }

  self.finished = 1;
  var_0 = common_scripts\utility::array_find(level.active_teargas, self);
  level.active_teargas = maps\_utility::array_remove_index(level.active_teargas, var_0);
}

handle_teargas_volume(var_0) {
  if(!isDefined(self.target)) {
    thread add_teargas_cloud_radius(300, var_0, self);
    return;
  }

  var_1 = maps\_utility::get_ai_touching_volume("axis");

  foreach(var_3 in var_1) {
    wait(randomintrange(1, 3));

    if(isDefined(var_3) && isalive(var_3) && !var_3 maps\_utility::doinglongdeath()) {
      var_3.fixednode = 0;
      var_3.pathrandompercent = randomintrange(75, 100);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = getnodearray(self.target, "targetname");

      if(isDefined(var_6) && var_6.size > 0)
        var_4 = var_6[randomint(var_6.size)];

      if(isDefined(var_4))
        var_3 thread ai_flee_from_teargas(var_4);
      else {
        var_5 = getent(self.target, "targetname");

        if(isDefined(var_5)) {
          var_3 thread ai_flee_from_teargas(undefined, var_5);
          common_scripts\utility::waitframe();
          var_3 setgoalvolume(var_5);
        }
      }
    }
  }
}

add_teargas_cloud_radius(var_0, var_1, var_2) {
  level.teargas_count++;
  var_3 = level.teargas_count;
  level endon("death");
  var_4 = getaiarray("axis");
  var_5 = var_0 * var_0;

  foreach(var_7 in var_4) {
    var_8 = distancesquared(var_7.origin, var_1);

    if(var_5 > var_8) {
      if(isDefined(var_7) && isalive(var_7) && !var_7 maps\_utility::doinglongdeath())
        var_7 thread ai_react_to_teargas(var_1, var_0);
    }
  }

  var_10 = getnodesinradius(var_1, var_0, 0, 100, "Path");
  var_11 = spawn("trigger_radius", var_1, 1, var_0 - 100, 100);
  var_11 thread handle_people_in_teargas();
  var_12 = var_11;
  var_12.nodes = var_10;
  var_12.origin = var_1;
  var_12.time = gettime();
  var_12.bp_id = var_3;
  var_11 thread handle_coughing();
  var_13 = undefined;

  if(!isDefined(level.disable_teargas_ally_badplaces) || level.disable_teargas_ally_badplaces == 0) {
    var_13 = "ally_teargas_bp" + maps\_utility::string(var_3);

    if(isDefined(var_2))
      badplace_brush(var_13, 15, var_2, "allies");
    else
      badplace_cylinder(var_13, 15, var_1, var_0, 100, "allies");
  }

  wait 3;
  var_14 = "axis_teargas_bp" + maps\_utility::string(var_3);

  if(isDefined(var_2))
    badplace_brush(var_14, 15, var_2, "axis");
  else
    badplace_cylinder(var_14, 15, var_1, var_0, 100, "axis");

  wait 12;

  if(isDefined(var_13))
    badplace_delete(var_13);

  badplace_delete(var_14);
  level.teargas_scripted_guys = [];
  var_11.finished = 1;
  var_11 notify("finished");
  common_scripts\utility::waitframe();
  var_11 delete();
}

handle_coughing() {
  var_0 = common_scripts\utility::array_find(level.active_teargas, self);

  if(!isDefined(var_0)) {
    level.active_teargas[level.active_teargas.size] = self;
    thread turn_off_gas();
  }

  if(level.coughing_active) {
    return;
  }
  level.coughing_active = 1;

  while(level.active_teargas.size > 0 || level.fake_teargas_coughing) {
    if(level.teargas_cough_count < 3) {
      var_1 = common_scripts\utility::array_combine(level.teargas_scripted_guys, level.teargassed_ai);
      var_1 = maps\_utility::array_removedead_or_dying(var_1);
      var_1 = sortbydistance(var_1, level.player.origin);

      for(var_2 = 0; var_2 < 3 && var_2 < var_1.size && level.teargas_cough_count < 3; var_2++) {
        var_1[var_2] thread ai_cough();
        wait 0.1;
      }
    }

    wait 0.25;
  }

  level.coughing_active = 0;
}

ai_cough() {
  if(isalive(self) && !isDefined(self.teargas_coughing)) {
    self.teargas_coughing = 1;
    level.teargas_cough_count++;
    level.teargas_last_cough_sound = level.teargas_last_cough_sound + randomintrange(1, 4);

    if(level.teargas_last_cough_sound >= level.teargas_cough_vo.size)
      level.teargas_last_cough_sound = level.teargas_last_cough_sound - level.teargas_cough_vo.size;

    self playSound(level.teargas_cough_vo[level.teargas_last_cough_sound], "done_coughing");
    common_scripts\utility::waittill_any("done_coughing", "death", "pain_death");

    if(isDefined(self)) {
      if(isalive(self))
        self.teargas_coughing = undefined;
      else
        self stopsounds();
    }

    level.teargas_cough_count--;
  }
}

handle_people_in_teargas() {
  self endon("death");
  self endon("finished");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(self.finished)) {
      return;
    }
    if(var_0 != level.player) {
      var_0 ai_react_to_teargas(self.origin, 300);
      continue;
    }

    if(!isDefined(level.player.gasmask_on) || level.player.gasmask_on == 0) {
      level.player setwatersheeting(1, 7);
      level.player shellshock("default", 7);
      wait 6;
    }
  }
}

remove_other_gassed_nodes(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.active_teargas) {
    if(isDefined(var_4) && isDefined(var_4.origin) && var_4.origin != var_1 && isDefined(var_4.nodes))
      var_0 = common_scripts\utility::array_remove_array(var_0, var_4.nodes);
  }

  return var_0;
}

find_scripted_teargas_flee_node(var_0, var_1, var_2) {
  var_3 = var_2 * var_2;
  var_4 = var_1 * var_1;
  var_5 = distancesquared(var_0, level.player.origin);
  var_6 = getnodearray("teargas_flee_node", "targetname");
  var_7 = [];
  var_8 = undefined;

  foreach(var_10 in var_6) {
    var_11 = distancesquared(var_0, var_10.origin);

    if(var_11 <= var_3 && var_11 < var_4) {
      var_12 = distancesquared(var_10.origin, level.player.origin);

      if(var_12 < var_5)
        var_7[var_7.size] = var_10;
    }
  }

  if(var_7.size > 0)
    var_8 = var_7[randomint(var_7.size)];

  return var_8;
}

find_teargas_free_node(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = getnodesinradius(var_0, var_1, var_2, 100, "Path");
  var_3 = remove_other_gassed_nodes(var_3, var_0);

  if(!isDefined(var_3) || var_3.size == 0) {
    return;
  }
  var_4 = var_3[randomint(var_3.size)];

  for(var_3 = common_scripts\utility::array_remove(var_3, var_4); isDefined(var_4.owner); var_3 = common_scripts\utility::array_remove(var_3, var_4)) {
    if(var_3.size == 0) {
      return;
    }
    var_4 = var_3[randomint(var_3.size)];
  }

  return var_4;
}

ai_react_to_teargas(var_0, var_1) {
  self endon("death");

  if(isDefined(self.syncedmeleetarget) || isDefined(self.melee) && isDefined(self.melee.target) || isDefined(self.gasmask_on) && self.gasmask_on == 1) {
    return;
  }
  var_2 = distance2d(self.origin, var_0);

  if(var_2 > 100) {
    var_3 = var_2 / var_1 * 3;
    wait(var_3);
    var_2 = distance2d(self.origin, var_0);

    if(var_2 > var_1)
      return;
  }

  var_4 = find_scripted_teargas_flee_node(var_0, var_1, 2000);

  if(!isDefined(var_4))
    var_4 = find_teargas_free_node(var_0, var_1 + 200, var_1);

  if(isDefined(var_4))
    ai_flee_from_teargas(var_4);
}

ai_flee_from_teargas(var_0, var_1) {
  self endon("death");

  if(isDefined(self) == 0 || isalive(self) == 0 || maps\_utility::doinglongdeath()) {
    return;
  }
  maps\_utility::set_ignoresuppression(1);
  self.tg_old_animname = self.animname;
  self.animname = "generic";
  self clearenemy();
  self.tg_old_badplace_awareness = self.badplaceawareness;
  self.badplaceawareness = 0;
  self.ignoreall = 1;
  self.allowdeath = 1;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.script_forcegoal = 0;

  if(!isDefined(self.teargassed)) {
    self.teargassed = 1;
    thread handle_gassed_ai(self);
    var_2 = level.teargas_reaction_anim[randomint(level.teargas_reaction_anim.size)];

    if(check_melee_interaction_active()) {
      cleanup_teargas_on_exit();
      return;
    }

    childthread maps\_anim::anim_custom_animmode_solo(self, "gravity", var_2);
  }

  if(check_melee_interaction_active()) {
    cleanup_teargas_on_exit();
    return;
  }

  var_3 = self.goalradius;
  var_4 = "teargas_run" + (1 + randomint(5));
  maps\_utility::set_run_anim(var_4);

  if(isDefined(var_1)) {
    self setgoalvolumeauto(var_1);
    self waittill("goal");
    wait(randomfloatrange(2, 5));
  } else if(isDefined(var_0)) {
    maps\_utility::set_goalradius(20);
    self setgoalnode(var_0);
    self waittill("goal");
  } else {
    maps\_utility::set_goalradius(50);
    self setgoalentity(level.player);
    self waittill("goal");
  }

  maps\_utility::set_goalradius(var_3);
  var_5 = level.teargas_recover_anim[randomint(level.teargas_recover_anim.size)];

  if(!isDefined(self.animname))
    self.animname = "generic";

  if(check_melee_interaction_active()) {
    cleanup_teargas_on_exit();
    return;
  }

  maps\_anim::anim_custom_animmode_solo(self, "gravity", var_5);
  cleanup_teargas_on_exit();
}

cleanup_teargas_on_exit() {
  maps\_utility::clear_run_anim();
  self.ignoreall = 0;
  self.disablearrivals = 0;
  self.disableexits = 0;
  self.badplaceawareness = self.tg_old_badplace_awareness;
  maps\_utility::set_ignoresuppression(0);

  if(isDefined(self.animname) && self.animname == "generic")
    self.animname = self.tg_old_animname;

  self.teargassed = undefined;
}

check_melee_interaction_active() {
  if(isDefined(self.dog_attacking_me) || isDefined(self.syncedmeleetarget) || isDefined(self.melee) && isDefined(self.melee.target))
    return 1;

  return 0;
}

handle_gassed_ai(var_0) {
  level.teargassed_ai[level.teargassed_ai.size] = var_0;
  var_0 waittill("death");
  common_scripts\utility::array_remove(level.teargassed_ai, var_0);
}

#using_animtree("generic_human");

precache_teargas() {
  precacheitem("teargas_grenade");
  level.scr_anim["generic"]["teargas_react1"] = % teargas_react_1;
  level.scr_anim["generic"]["teargas_react2"] = % teargas_react_2;
  level.scr_anim["generic"]["teargas_react3"] = % teargas_react_3;
  level.scr_anim["generic"]["teargas_react_inplace"] = % teargas_react_in_place_1;
  level.scr_anim["generic"]["teargas_run1"][0] = % teargas_run_1;
  level.scr_anim["generic"]["teargas_run2"][0] = % teargas_run_2;
  level.scr_anim["generic"]["teargas_run3"][0] = % teargas_run_3;
  level.scr_anim["generic"]["teargas_run4"][0] = % teargas_run_4;
  level.scr_anim["generic"]["teargas_run5"][0] = % teargas_run_5;
  level.scr_anim["generic"]["teargas_recover1"] = % teargas_recover_1;
  level.scr_anim["generic"]["teargas_recover2"] = % teargas_recover_2;
  level.scr_anim["generic"]["teargas_recover3"] = % teargas_recover_3;
  level.scr_anim["generic"]["teargas_recover4"] = % teargas_recover_4;
  level.scr_anim["generic"]["teargas_recover5"] = % teargas_recover_5;
  level.scr_anim["generic"]["teargas_recover6"] = % teargas_recover_6;
}
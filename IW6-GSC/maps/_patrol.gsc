/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_patrol.gsc
*****************************************************/

patrol(var_0) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("damage");
  self endon("end_patrol");
  self endon("dog_attacks_ai");
  waittillframeend;

  if(isDefined(self.script_stealthgroup))
    [[level.global_callbacks["_patrol_endon_spotted_flag"]]]();

  thread waittill_combat();
  thread waittill_death();
  self.goalradius = 32;
  self allowedstances("stand");
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.allowdeath = 1;
  self.script_patroller = 1;
  self.oldcombatmode = self.combatmode;
  self.combatmode = "no_cover";
  maps\_utility::disable_cqbwalk();

  if(isDefined(self.script_moveplaybackrate)) {
    self.oldmoveplaybackrate = self.moveplaybackrate;
    self.moveplaybackrate = self.script_moveplaybackrate;
  }

  linkpet();
  set_patrol_run_anim_array();
  var_1["ent"][1] = ::get_target_ents;
  var_1["ent"][0] = common_scripts\utility::get_linked_ents;
  var_1["node"][1] = ::get_target_nodes;
  var_1["node"][0] = ::get_linked_nodes;
  var_1["struct"][1] = ::get_target_structs;
  var_1["struct"][0] = maps\_utility::get_linked_structs;
  var_2["ent"] = maps\_utility::set_goal_ent;
  var_2["node"] = maps\_utility::set_goal_node;
  var_2["struct"] = maps\_utility::set_goal_ent;

  if(isDefined(var_0))
    self.target = var_0;

  if(isDefined(self.target)) {
    var_3 = 1;
    var_4 = get_target_ents();
    var_5 = get_target_nodes();
    var_6 = get_target_structs();

    if(var_4.size) {
      var_7 = common_scripts\utility::random(var_4);
      var_8 = "ent";
    } else if(var_5.size) {
      var_7 = common_scripts\utility::random(var_5);
      var_8 = "node";
    } else {
      var_7 = common_scripts\utility::random(var_6);
      var_8 = "struct";
    }
  } else {
    var_3 = 0;
    var_4 = common_scripts\utility::get_linked_ents();
    var_5 = get_linked_nodes();
    var_6 = maps\_utility::get_linked_structs();

    if(var_4.size) {
      var_7 = common_scripts\utility::random(var_4);
      var_8 = "ent";
    } else if(var_5.size) {
      var_7 = common_scripts\utility::random(var_5);
      var_8 = "node";
    } else {
      var_7 = common_scripts\utility::random(var_6);
      var_8 = "struct";
    }
  }

  var_9 = [];
  var_9["pause"] = "patrol_idle_";
  var_9["turn180"] = common_scripts\utility::ter_op(isDefined(self.patrol_anim_turn180), self.patrol_anim_turn180, "patrol_turn180");
  var_9["smoke"] = "patrol_idle_smoke";
  var_9["stretch"] = "patrol_idle_stretch";
  var_9["checkphone"] = "patrol_idle_checkphone";
  var_9["phone"] = "patrol_idle_phone";
  var_10 = var_7;

  for(;;) {
    while(isDefined(var_10.patrol_claimed))
      wait 0.05;

    var_7.patrol_claimed = undefined;
    var_7 = var_10;
    self notify("release_node");
    var_7.patrol_claimed = 1;
    self.last_patrol_goal = var_7;
    [[var_2[var_8]]](var_7);

    if(isDefined(var_7.radius) && var_7.radius > 0)
      self.goalradius = var_7.radius;
    else
      self.goalradius = 32;

    self waittill("goal");
    var_7 notify("trigger", self);

    if(isDefined(var_7.script_flag_set))
      common_scripts\utility::flag_set(var_7.script_flag_set);

    if(isDefined(var_7.script_ent_flag_set))
      maps\_utility::ent_flag_set(var_7.script_ent_flag_set);

    if(isDefined(var_7.script_flag_clear))
      common_scripts\utility::flag_clear(var_7.script_flag_clear);

    var_11 = var_7[[var_1[var_8][var_3]]]();

    if(!var_11.size) {
      self notify("reached_path_end");
      self notify("_patrol_reached_path_end");

      if(isalive(self.patrol_pet))
        self.patrol_pet notify("master_reached_patrol_end");
    }

    var_12 = animscripts\reactions::reactionscheckloop;
    var_13 = var_7.script_animation;
    var_14 = 1;
    var_15 = 0;

    if(isDefined(var_7.script_parameters)) {
      var_16 = strtok(var_7.script_parameters, " ");

      for(var_17 = 0; var_17 < var_16.size; var_17++) {
        switch (var_16[var_17]) {
          case "keep_running":
            var_14 = 0;
            break;
          case "use_node":
            var_15 = 1;
            break;
          case "animset":
            var_17 = var_17 + 1;
            self.script_animation = var_16[var_17];

            if(self.script_animation == "default") {
              self.script_animation = undefined;
              self.patrol_walk_anim = undefined;
              self.patrol_walk_twitch = undefined;
              self.patrol_idle_anim = undefined;
            }

            set_patrol_run_anim_array();
        }
      }
    }

    if(isDefined(var_7.script_moveplaybackrate))
      self.moveplaybackrate = var_7.script_moveplaybackrate;

    if(isDefined(var_7.script_delay) && var_7.script_delay > 0.5 || isDefined(var_13) || isDefined(var_7.script_flag_wait) && !common_scripts\utility::flag(var_7.script_flag_wait)) {
      if(!isDefined(self.patrol_no_stop_transition) && var_14)
        patrol_do_stop_transition_anim(var_13, var_12, var_7);

      if(isDefined(var_7.script_flag_wait) && !common_scripts\utility::flag(var_7.script_flag_wait))
        common_scripts\utility::flag_wait(var_7.script_flag_wait);

      var_7 maps\_utility::script_delay();

      if(isDefined(var_13)) {
        if(isDefined(var_7.script_faceangles))
          self orientmode("face angle", var_7.angles[1]);

        self.patrol_script_animation = 1;
        var_18 = var_9[var_13];

        if(!isDefined(var_18)) {
          if(isDefined(level.patrol_scriptedanims))
            var_18 = level.patrol_scriptedanims[var_13];
        }

        if(isDefined(var_18)) {
          if(var_13 == "pause") {
            if(isDefined(self.patrol_scriptedanim) && isDefined(self.patrol_scriptedanim[var_13]))
              var_18 = self.patrol_scriptedanim[var_13][randomint(self.patrol_scriptedanim[var_13].size)];
            else
              var_18 = var_18 + randomintrange(1, 6);
          }

          if(var_15) {
            var_7 maps\_anim::anim_generic_reach(self, var_18);
            var_7 maps\_anim::anim_generic_custom_animmode(self, "gravity", var_18, undefined, var_12);
          } else
            maps\_anim::anim_generic_custom_animmode(self, "gravity", var_18, undefined, var_12);
        }

        self.patrol_script_animation = undefined;
      }

      if(var_11.size && (!isDefined(var_13) || var_13 != "turn180") && var_14 && (!isDefined(self.skip_start_transition) || !self.skip_start_transition))
        patrol_do_start_transition_anim(var_13, var_12);
    }

    if(!var_11.size) {
      if(isDefined(self.patrol_end_idle) && !isDefined(var_13)) {
        patrol_do_stop_transition_anim("path_end_idle", var_12, var_7);

        for(;;) {
          var_19 = self.patrol_end_idle[randomint(self.patrol_end_idle.size)];
          maps\_anim::anim_generic_custom_animmode(self, "gravity", var_19, undefined, var_12);
        }
      }

      break;
    }

    var_10 = common_scripts\utility::random(var_11);
  }
}

patrol_do_stop_transition_anim(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0;

  if(isDefined(var_2.script_faceangles)) {
    var_3 = var_2;
    self.noteleport = 1;
    var_4 = 1;
  }

  if(isDefined(self.patrol_stop) && isDefined(self.patrol_stop[var_0]))
    var_3 maps\_anim::anim_generic_custom_animmode(self, "gravity", self.patrol_stop[var_0], undefined, var_1, var_4);
  else if(isDefined(self.script_animation) && isDefined(level.scr_anim["generic"]["patrol_stop_" + self.script_animation]))
    maps\_anim::anim_generic_custom_animmode(self, "gravity", "patrol_stop_" + self.script_animation, undefined, var_1);
  else
    var_3 maps\_anim::anim_generic_custom_animmode(self, "gravity", "patrol_stop", undefined, var_1, var_4);
}

patrol_do_start_transition_anim(var_0, var_1) {
  if(isDefined(self.patrol_start) && isDefined(self.patrol_start[var_0]))
    maps\_anim::anim_generic_custom_animmode(self, "gravity", self.patrol_start[var_0], undefined, var_1);
  else if(isDefined(self.script_animation) && isDefined(level.scr_anim["generic"]["patrol_start_" + self.script_animation]))
    maps\_anim::anim_generic_custom_animmode(self, "gravity", "patrol_start_" + self.script_animation, undefined, var_1);
  else
    maps\_anim::anim_generic_custom_animmode(self, "gravity", "patrol_start", undefined, var_1);
}

#using_animtree("generic_human");

stand_up_if_necessary() {
  if(self.a.pose == "crouch" && isDefined(self.a.array)) {
    var_0 = self.a.array["stance_change"];

    if(isDefined(var_0)) {
      self setflaggedanimknoballrestart("stand_up", var_0, % root, 1);
      animscripts\shared::donotetracks("stand_up");
    }
  }
}

patrol_resume_move_start_func() {
  self endon("enemy");
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  stand_up_if_necessary();
  var_0 = level.scr_anim["generic"]["patrol_radio_in_clear"];
  self setflaggedanimknoballrestart("radio", var_0, % root, 1);
  animscripts\shared::donotetracks("radio");
  turn_180_move_start_func();
}

turn_180_move_start_func() {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }
  var_0 = self.pathgoalpos;
  var_1 = var_0 - self.origin;
  var_1 = (var_1[0], var_1[1], 0);
  var_2 = lengthsquared(var_1);

  if(var_2 < 1) {
    return;
  }
  var_1 = var_1 / sqrt(var_2);
  var_3 = anglesToForward(self.angles);

  if(vectordot(var_3, var_1) < -0.5) {
    self animmode("zonly_physics", 0);
    self orientmode("face current");
    stand_up_if_necessary();
    var_4 = level.scr_anim["generic"]["patrol_turn180"];
    self setflaggedanimknoballrestart("move", var_4, % root, 1);

    if(animhasnotetrack(var_4, "code_move")) {
      animscripts\shared::donotetracks("move");
      self orientmode("face motion");
      self animmode("none", 0);
    }

    animscripts\shared::donotetracks("move");
  }
}

set_patrol_run_anim_array() {
  if(isDefined(self.script_animation)) {
    if(isDefined(level.scr_anim["generic"]["patrol_walk_" + self.script_animation]))
      self.patrol_walk_anim = "patrol_walk_" + self.script_animation;

    if(isDefined(level.scr_anim["generic"]["patrol_walk_weights_" + self.script_animation]))
      self.patrol_walk_twitch = "patrol_walk_weights_" + self.script_animation;

    if(isDefined(level.scr_anim["generic"]["patrol_idle_" + self.script_animation]))
      self.patrol_idle_anim = "patrol_idle_" + self.script_animation;
  }

  var_0 = "patrol_walk";

  if(isDefined(self.patrol_walk_anim))
    var_0 = self.patrol_walk_anim;

  var_1 = undefined;

  if(isDefined(self.patrol_walk_twitch))
    var_1 = self.patrol_walk_twitch;

  if(isDefined(self.script_animation)) {
    if(isDefined(level.scr_anim["generic"]["patrol_idle_" + self.script_animation]))
      maps\_utility::set_generic_idle_anim("patrol_idle_" + self.script_animation);
  }

  maps\_utility::set_generic_run_anim_array(var_0, var_1);
}

waittill_combat_wait() {
  self endon("end_patrol");

  if(isDefined(self.patrol_master))
    self.patrol_master endon("death");

  self waittill("enemy");
}

waittill_death() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.last_patrol_goal)) {
    return;
  }
  self.last_patrol_goal.patrol_claimed = undefined;
}

waittill_combat() {
  self endon("death");
  waittill_combat_wait();
  var_0 = maps\_utility::ent_flag_exist("_stealth_enabled") && maps\_utility::ent_flag("_stealth_enabled");
  self.script_patroller = 0;

  if(!var_0) {
    maps\_utility::clear_generic_idle_anim();
    self.combatmode = self.oldcombatmode;
    maps\_utility::clear_run_anim();
    self allowedstances("stand", "crouch", "prone");
    self.disablearrivals = 0;
    self.disableexits = 0;
    self stopanimscripted();
    self notify("stop_animmode");
    self.script_nobark = undefined;
    self.goalradius = level.default_goalradius;
  }

  if(isDefined(self.old_interval))
    self.interval = self.old_interval;

  self.moveplaybackrate = 1;

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.last_patrol_goal)) {
    return;
  }
  self.last_patrol_goal.patrol_claimed = undefined;
}

get_target_ents() {
  var_0 = [];

  if(isDefined(self.target))
    var_0 = getEntArray(self.target, "targetname");

  return var_0;
}

get_target_nodes() {
  var_0 = [];

  if(isDefined(self.target))
    var_0 = getnodearray(self.target, "targetname");

  return var_0;
}

get_target_structs() {
  var_0 = [];

  if(isDefined(self.target))
    var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  return var_0;
}

get_linked_nodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = strtok(self.script_linkto, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getnode(var_1[var_2], "script_linkname");

      if(isDefined(var_3))
        var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

showclaimed(var_0) {
  self endon("release_node");
}

linkpet() {
  if(isDefined(self.patrol_pet)) {
    self.patrol_pet thread pet_patrol();
    return;
  }

  if(!isDefined(self.script_pet)) {
    return;
  }
  waittillframeend;
  var_0 = getaispeciesarray(self.team, "dog");
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2].script_pet)) {
      continue;
    }
    if(var_0[var_2].script_pet != self.script_pet) {
      continue;
    }
    var_1 = var_0[var_2];
    self.patrol_pet = var_1;
    var_1.patrol_master = self;
    break;
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread pet_patrol();
}

pet_patrol() {
  maps\_utility::spawn_failed(self);

  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");

  if(isDefined(self.script_stealthgroup))
    [[level.global_callbacks["_patrol_endon_spotted_flag"]]]();

  self.patrol_master endon("death");
  thread waittill_combat();
  self.goalradius = 4;
  self.allowdeath = 1;
  var_0 = pet_patrol_create_positions();
  var_1 = vectornormalize(self.origin - self.patrol_master.origin);
  var_2 = anglestoright(self.patrol_master.angles);
  var_3 = "left";

  if(vectordot(var_1, var_2) > 0)
    var_3 = "right";

  wait 1;
  thread pet_patrol_handle_move_state();
  thread pet_patrol_handle_movespeed();
  self.old_interval = self.interval;
  self.interval = 70;

  for(;;) {
    if(isDefined(self.patrol_master) && !isDefined(self.patrol_master.patrol_script_animation)) {
      var_0 = pet_patrol_init_positions(var_0);

      if(var_3 == "null")
        var_3 = "back";

      var_3 = pet_patrol_get_available_origin(var_0, var_3);
      self.patrol_goal_pos = var_0[var_3].origin;
    } else
      self.patrol_goal_pos = self.origin;

    self setgoalpos(self.patrol_goal_pos);
    wait 0.05;
  }
}

pet_patrol_create_positions() {
  var_0 = [];
  var_1 = spawnStruct();
  var_1.options = [];
  var_1.options[var_1.options.size] = "right";
  var_1.options[var_1.options.size] = "back_right";
  var_2 = spawnStruct();
  var_2.options = [];
  var_2.options[var_2.options.size] = "right";
  var_2.options[var_2.options.size] = "back_right";
  var_2.options[var_2.options.size] = "back";
  var_3 = spawnStruct();
  var_3.options = [];
  var_3.options[var_3.options.size] = "back_right";
  var_3.options[var_3.options.size] = "back_left";
  var_3.options[var_3.options.size] = "back";
  var_4 = spawnStruct();
  var_4.options = [];
  var_4.options[var_4.options.size] = "left";
  var_4.options[var_4.options.size] = "back_left";
  var_4.options[var_4.options.size] = "back";
  var_5 = spawnStruct();
  var_5.options = [];
  var_5.options[var_5.options.size] = "left";
  var_5.options[var_5.options.size] = "back_left";
  var_6 = spawnStruct();
  var_0["right"] = var_1;
  var_0["left"] = var_5;
  var_0["back_right"] = var_2;
  var_0["back_left"] = var_4;
  var_0["back"] = var_3;
  var_0["null"] = var_6;
  return var_0;
}

pet_patrol_init_positions(var_0) {
  var_1 = vectortoangles(self.patrol_master.last_patrol_goal.origin - self.patrol_master.origin);
  var_2 = self.patrol_master.origin;
  var_3 = anglestoright(var_1);
  var_4 = anglesToForward(var_1);
  var_0["right"].origin = var_2 + var_3 * 40 + var_4 * 30;
  var_0["left"].origin = var_2 + var_3 * -40 + var_4 * 30;
  var_0["back_right"].origin = var_2 + var_3 * 32 + var_4 * -16;
  var_0["back_left"].origin = var_2 + var_3 * -32 + var_4 * -16;
  var_0["back"].origin = var_2 + var_4 * -48;
  var_0["null"].origin = self.origin;
  var_5 = getarraykeys(var_0);

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];
    var_0[var_7].checked = 0;
    var_0[var_7].recursed = 0;
  }

  return var_0;
}

pet_debug_positions(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3 == "null")
      continue;
  }
}

pet_patrol_get_available_origin(var_0, var_1) {
  var_0[var_1].recursed = 1;

  for(var_2 = 0; var_2 < var_0[var_1].options.size; var_2++) {
    var_3 = var_0[var_1].options[var_2];

    if(var_0[var_3].checked) {
      continue;
    }
    if(self maymovetopoint(var_0[var_3].origin))
      return var_3;

    var_0[var_3].checked = 1;
  }

  for(var_2 = 0; var_2 < var_0[var_1].options.size; var_2++) {
    var_3 = var_0[var_1].options[var_2];

    if(var_0[var_3].recursed) {
      continue;
    }
    var_3 = pet_patrol_get_available_origin(var_0, var_3);
    return var_3;
  }

  return "null";
}

pet_patrol_handle_move_state(var_0) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self.patrol_master endon("death");

  if(isDefined(self.patrol_master.script_noteworthy) && self.patrol_master.script_noteworthy == "cqb_patrol") {
    maps\_utility::set_dog_walk_anim();
    return;
  }

  if(!isDefined(var_0))
    var_0 = 200;

  maps\_utility::set_dog_walk_anim();

  for(;;) {
    wait 0.1;
    var_1 = self.patrol_goal_pos;
    var_2 = distancesquared(self.origin, self.patrol_goal_pos);

    if(var_2 > squared(var_0)) {
      if(self.a.movement == "run") {
        continue;
      }
      maps\_anim::anim_generic_custom_animmode(self, "gravity", "patrol_dog_start");
      maps\_utility::clear_run_anim();
      self.script_nobark = 1;
      continue;
    }

    if(self.a.movement != "walk") {
      self notify("stopped_while_patrolling");
      maps\_anim::anim_generic_custom_animmode(self, "gravity", "patrol_dog_stop");
      maps\_utility::set_dog_walk_anim();
    }
  }
}

pet_patrol_handle_movespeed(var_0, var_1) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self.patrol_master endon("death");

  if(isDefined(self.patrol_master.script_noteworthy) && self.patrol_master.script_noteworthy == "cqb_patrol") {
    for(;;) {
      wait 0.05;
      var_2 = self.patrol_goal_pos;
      var_3 = distancesquared(self.origin, self.patrol_goal_pos);

      if(var_3 < squared(16)) {
        if(self.moveplaybackrate > 0.4)
          self.moveplaybackrate = self.moveplaybackrate - 0.05;

        continue;
      }

      if(var_3 > squared(48)) {
        if(self.moveplaybackrate < 1.8)
          self.moveplaybackrate = self.moveplaybackrate + 0.05;

        continue;
      }

      self.moveplaybackrate = 1;
    }
  }

  if(!isDefined(var_0))
    var_0 = 16;

  if(!isDefined(var_1))
    var_1 = 48;

  var_4 = var_0 * var_0;
  var_5 = var_1 * var_1;

  for(;;) {
    wait 0.05;
    var_2 = self.patrol_goal_pos;
    var_3 = distancesquared(self.origin, self.patrol_goal_pos);

    if(self.a.movement != "walk") {
      self.moveplaybackrate = 1;
      continue;
    }

    if(var_3 < var_4) {
      if(self.moveplaybackrate > 0.4)
        self.moveplaybackrate = self.moveplaybackrate - 0.05;

      continue;
    }

    if(var_3 > var_5) {
      if(self.moveplaybackrate < 0.75)
        self.moveplaybackrate = self.moveplaybackrate + 0.05;

      continue;
    }

    self.moveplaybackrate = 0.5;
  }
}
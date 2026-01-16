/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_patrol.gsc
********************************/

patrol(var_0, var_1, var_2) {
  if(isdefined(self.enemy)) {
    return;
  }
  self endon("death");
  self endon("end_patrol");
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");
  thread waittill_combat();
  thread waittill_death();
  self endon("enemy");
  self.goalradius = 32;
  self allowedstances("stand");
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.allowdeath = 1;
  self.script_patroller = 1;
  var_3 = "patrol_walk";

  if(isdefined(self.patrol_walk_anim))
    var_3 = self.patrol_walk_anim;

  var_4 = isdefined(self.canpatrolturn) && self.canpatrolturn;
  maps\_utility::set_generic_run_anim(var_3, 1, !var_4);
  thread patrol_walk_twitch_loop();
  var_5[1][1] = ::get_target_ents;
  var_5[1][0] = common_scripts\utility::get_linked_ents;
  var_5[0][1] = ::get_target_nodes;
  var_5[0][0] = ::get_linked_nodes;
  var_6[1] = maps\_utility::set_goal_ent;
  var_6[0] = maps\_utility::set_goal_node;

  if(isdefined(var_0))
    self.target = var_0;

  if(isdefined(self.target)) {
    var_7 = 1;
    var_8 = get_target_ents();
    var_9 = get_target_nodes();

    if(var_8.size) {
      var_10 = common_scripts\utility::random(var_8);
      var_11 = 1;
    } else {
      var_10 = common_scripts\utility::random(var_9);
      var_11 = 0;
    }
  } else {
    var_7 = 0;
    var_8 = common_scripts\utility::get_linked_ents();
    var_9 = get_linked_nodes();

    if(var_8.size) {
      var_10 = common_scripts\utility::random(var_8);
      var_11 = 1;
    } else {
      var_10 = common_scripts\utility::random(var_9);
      var_11 = 0;
    }
  }

  var_12 = var_10;

  for (;;) {
    while (isdefined(var_12.patrol_claimed))
      wait 0.05;

    var_10.patrol_claimed = undefined;
    var_10 = var_12;
    self notify("release_node");
    var_10.patrol_claimed = 1;
    self.last_patrol_goal = var_10;
    [
      [var_6[var_11]]
    ](var_10);

    if(isdefined(var_10.radius) && var_10.radius > 0)
      self.goalradius = var_10.radius;
    else
      self.goalradius = 32;

    self waittill("goal");
    var_10 notify("trigger", self);

    if(isdefined(var_10.script_animation)) {
      if(!isdefined(var_2) || var_2 == 0) {
        var_13 = "patrol_stop";
        maps\_anim::anim_generic_custom_animmode(self, "gravity", var_13);
      }

      switch (var_10.script_animation) {
        case "pause":
          var_14 = "patrol_idle_" + randomintrange(1, 6);

          if(var_14 == "patrol_idle_2" && !can_smoke())
            var_14 = "patrol_idle_" + randomintrange(3, 6);

          maps\_anim::anim_generic(self, var_14);
          var_15 = "patrol_start";
          maps\_anim::anim_generic_custom_animmode(self, "gravity", var_15);
          break;
        case "turn180":
          var_16 = "patrol_turn180";
          maps\_anim::anim_generic_custom_animmode(self, "gravity", var_16);
          break;
        case "smoke":
          var_17 = "patrol_idle_smoke";

          if(!can_smoke())
            var_17 = "patrol_idle_" + randomintrange(3, 6);

          maps\_anim::anim_generic(self, var_17);
          var_15 = "patrol_start";
          maps\_anim::anim_generic_custom_animmode(self, "gravity", var_15);
          break;
        case "stretch":
          var_17 = "patrol_idle_stretch";
          maps\_anim::anim_generic(self, var_17);
          var_15 = "patrol_start";
          maps\_anim::anim_generic_custom_animmode(self, "gravity", var_15);
          break;
        case "checkphone":
          var_17 = "patrol_idle_checkphone";
          maps\_anim::anim_generic(self, var_17);
          var_15 = "patrol_start";
          maps\_anim::anim_generic_custom_animmode(self, "gravity", var_15);
          break;
        case "phone":
          var_17 = "patrol_idle_phone";
          maps\_anim::anim_generic(self, var_17);
          var_15 = "patrol_start";
          maps\_anim::anim_generic_custom_animmode(self, "gravity", var_15);
          break;
      }
    }

    if(isdefined(var_1) && var_1 == 1)
      self animmode("none");

    var_18 = var_10[[var_5[var_11][var_7]]]();

    if(!var_18.size) {
      self notify("reached_path_end");
      break;
    }

    var_12 = common_scripts\utility::random(var_18);
  }
}

add_to_patrol_animation_list(var_0, var_1) {
  if(isdefined(var_1))
    level.patrol_anims[var_0] = var_1;
}

init_patrol_animation_list() {
  add_to_patrol_animation_list("patrol_walk", level.scr_anim["generic"]["patrol_walk"]);
  add_to_patrol_animation_list("patrol_walk_twitch", level.scr_anim["generic"]["patrol_walk_twitch"]);
  add_to_patrol_animation_list("patrol_stop", level.scr_anim["generic"]["patrol_stop"]);
  add_to_patrol_animation_list("patrol_start", level.scr_anim["generic"]["patrol_start"]);
  add_to_patrol_animation_list("patrol_turn180", level.scr_anim["generic"]["patrol_turn180"]);
  add_to_patrol_animation_list("patrol_idle_1", level.scr_anim["generic"]["patrol_idle_1"]);
  add_to_patrol_animation_list("patrol_idle_2", level.scr_anim["generic"]["patrol_idle_2"]);
  add_to_patrol_animation_list("patrol_idle_3", level.scr_anim["generic"]["patrol_idle_3"]);
  add_to_patrol_animation_list("patrol_idle_4", level.scr_anim["generic"]["patrol_idle_4"]);
  add_to_patrol_animation_list("patrol_idle_5", level.scr_anim["generic"]["patrol_idle_5"]);
  add_to_patrol_animation_list("patrol_idle_6", level.scr_anim["generic"]["patrol_idle_6"]);
  add_to_patrol_animation_list("patrol_idle_smoke", level.scr_anim["generic"]["patrol_idle_smoke"]);
  add_to_patrol_animation_list("patrol_idle_checkphone", level.scr_anim["generic"]["patrol_idle_checkphone"]);
  add_to_patrol_animation_list("patrol_idle_stretch", level.scr_anim["generic"]["patrol_idle_stretch"]);
  add_to_patrol_animation_list("patrol_idle_phone", level.scr_anim["generic"]["patrol_idle_phone"]);
  add_to_patrol_animation_list("patrol_turn_l45_rfoot", level.scr_anim["generic"]["patrol_turn_l45_rfoot"]);
  add_to_patrol_animation_list("patrol_turn_l45_lfoot", level.scr_anim["generic"]["patrol_turn_l45_lfoot"]);
  add_to_patrol_animation_list("patrol_turn_l90_rfoot", level.scr_anim["generic"]["patrol_turn_l90_rfoot"]);
  add_to_patrol_animation_list("patrol_turn_l90_lfoot", level.scr_anim["generic"]["patrol_turn_l90_lfoot"]);
  add_to_patrol_animation_list("patrol_turn_l135_rfoot", level.scr_anim["generic"]["patrol_turn_l135_rfoot"]);
  add_to_patrol_animation_list("patrol_turn_l135_lfoot", level.scr_anim["generic"]["patrol_turn_l135_lfoot"]);
  add_to_patrol_animation_list("patrol_turn_r45_rfoot", level.scr_anim["generic"]["patrol_turn_r45_rfoot"]);
  add_to_patrol_animation_list("patrol_turn_r45_lfoot", level.scr_anim["generic"]["patrol_turn_r45_lfoot"]);
  add_to_patrol_animation_list("patrol_turn_r90_rfoot", level.scr_anim["generic"]["patrol_turn_r90_rfoot"]);
  add_to_patrol_animation_list("patrol_turn_r90_lfoot", level.scr_anim["generic"]["patrol_turn_r90_lfoot"]);
  add_to_patrol_animation_list("patrol_turn_r135_rfoot", level.scr_anim["generic"]["patrol_turn_r135_rfoot"]);
  add_to_patrol_animation_list("patrol_turn_r135_lfoot", level.scr_anim["generic"]["patrol_turn_r135_lfoot"]);
  add_to_patrol_animation_list("patrol_walk_in_lfoot", level.scr_anim["generic"]["patrol_walk_in_lfoot"]);
  add_to_patrol_animation_list("patrol_walk_out_lfoot", level.scr_anim["generic"]["patrol_walk_out_lfoot"]);
  add_to_patrol_animation_list("patrol_walk_in_rfoot", level.scr_anim["generic"]["patrol_walk_in_rfoot"]);
  add_to_patrol_animation_list("patrol_walk_out_rfoot", level.scr_anim["generic"]["patrol_walk_out_rfoot"]);
}

is_patrolling() {
  foreach(var_1 in level.patrol_anims) {
    if(isdefined(var_1) && self getanimweight(var_1) != 0.0) {
      self.usepathsmoothingvalues = 1;
      self.pathlookaheaddist = 70.0;
      self.maxturnspeed = 19.0;
      self.sharpturn = 0.94;
      return 1;
    }
  }

  self.usepathsmoothingvalues = 0;
  return 0;
}

enable_patrol_turn() {
  self.canpatrolturn = 1;
}

disable_patrol_turn() {
  self.canpatrolturn = undefined;
}

can_smoke() {
  if(!isdefined(self.headmodel))
    return 0;

  switch (self.headmodel) {
    case "head_spetsnaz_assault_demetry_lob":
    case "head_spetsnaz_assault_demetry":
    case "head_sp_opforce_gas_mask_body_f":
    case "head_sp_opforce_fullwrap_body_d":
    case "head_sp_opforce_ski_mask_body_a":
      return 0;
  }

  return 1;
}

patrol_walk_twitch_loop() {
  self endon("death");
  self endon("enemy");
  self endon("end_patrol");
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");
  self notify("patrol_walk_twitch_loop");
  self endon("patrol_walk_twitch_loop");

  if(isdefined(self.patrol_walk_anim) && !isdefined(self.patrol_walk_twitch)) {
    return;
  }
  for (;;) {
    wait(randomfloatrange(8, 20));
    var_0 = "patrol_walk_twitch";

    if(isdefined(self.patrol_walk_twitch))
      var_0 = self.patrol_walk_twitch;

    var_1 = isdefined(self.canpatrolturn) && self.canpatrolturn;
    maps\_utility::set_generic_run_anim(var_0, 1, !var_1);
    var_2 = getanimlength(maps\_utility::getanim_generic(var_0));
    wait(var_2);
    var_0 = "patrol_walk";

    if(isdefined(self.patrol_walk_anim))
      var_0 = self.patrol_walk_anim;

    maps\_utility::set_generic_run_anim(var_0, 1, !var_1);
  }
}

waittill_combat_wait() {
  self endon("end_patrol");
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");
  self waittill("enemy");
}

waittill_death() {
  self waittill("death");

  if(!isdefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isdefined(self.last_patrol_goal)) {
    return;
  }
  self.last_patrol_goal.patrol_claimed = undefined;
}

waittill_combat() {
  self endon("death");
  waittill_combat_wait();

  if(!isdefined(self._stealth)) {
    maps\_utility::clear_run_anim();
    self allowedstances("stand", "crouch", "prone");
    self.disablearrivals = 0;
    self.disableexits = 0;
    self stopanimscripted();
    self notify("stop_animmode");
  }

  self.allowdeath = 0;

  if(!isdefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isdefined(self.last_patrol_goal)) {
    return;
  }
  self.last_patrol_goal.patrol_claimed = undefined;
}

get_target_ents() {
  var_0 = [];

  if(isdefined(self.target))
    var_0 = getentarray(self.target, "targetname");

  return var_0;
}

get_target_nodes() {
  var_0 = [];

  if(isdefined(self.target))
    var_0 = getnodearray(self.target, "targetname");

  return var_0;
}

get_linked_nodes() {
  var_0 = [];

  if(isdefined(self.script_linkto)) {
    var_1 = strtok(self.script_linkto, " ");

    for (var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getnode(var_1[var_2], "script_linkname");

      if(isdefined(var_3))
        var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

showclaimed(var_0) {
  self endon("release_node");
}

patrol_resume_move_start_func() {}

pet_patrol() {}
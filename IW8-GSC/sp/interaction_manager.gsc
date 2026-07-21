/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\interaction_manager.gsc
***********************************************/

interaction_manager_init() {
  level.interaction_manager = spawnStruct();
  level.interaction_manager.data = [];
  level.interaction_manager.data["actors"] = [];
  level.interaction_manager.data["registered_interactions"] = [];
  level.interaction_manager.data["registered_state_interactions"] = [];
  reminder_vo_init();
  level.interaction_manager.allow_interactions = 1;
  level.interaction_manager.can_remind = 1;
  level.interaction_manager.pause_remind = 0;
  level.interaction_manager.data["reminder_queue"] = [];
}

stop_interactions() {
  reconstruct_actor_array();

  foreach(var_1 in level.interaction_manager.data["actors"]) {
    var_1.allow_interactions = 0;
    var_1.allow_gesture_reactions = 0;
  }
}

stop_interaction() {
  if(scripts\engine\utility::array_contains(level.interaction_manager.data["actors"], self)) {
    self.allow_interactions = 0;
    self.allow_gesture_reactions = 0;
  }
}

continue_interactions() {
  reconstruct_actor_array();

  foreach(var_1 in level.interaction_manager.data["actors"]) {
    var_1.allow_interactions = 1;
    var_1.allow_gesture_reactions = 1;
  }
}

continue_interaction() {
  if(scripts\engine\utility::array_contains(level.interaction_manager.data["actors"], self)) {
    self.allow_interactions = 1;
    self.allow_gesture_reactions = 1;
  }
}

trigger_interaction() {
  self endon("death");

  if(isDefined(self.lookat_anims))
    self.lookat_anims["interaction_trigger_override"] = 1;
}

trigger_interaction_multiple(var_0) {
  self endon("death");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.lookat_anims))
      var_2.lookat_anims["interaction_trigger_override"] = 1;
  }
}

trigger_interaction_common() {
  self endon("death");
  var_0 = self.lookat_anims["common_name"];
  var_1 = level.interaction_manager.data["actors"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3.lookat_anims["common_name"])) {
      if(var_3.lookat_anims["common_name"] == var_0)
        var_3.lookat_anims["interaction_trigger_override"] = 1;
    }
  }
}

reconstruct_actor_array() {
  foreach(var_1 in level.interaction_manager.data["actors"]) {
    if(!isDefined(var_1))
      level.interaction_manager.data["actors"] = scripts\engine\utility::array_remove(level.interaction_manager.data["actors"], var_1);
  }
}

add_actor_to_manager() {
  if(isDefined(level.interaction_manager)) {
    if(!scripts\engine\utility::array_contains(level.interaction_manager.data["actors"], self))
      level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);
  }
}

remove_actor_from_manager() {
  if(isDefined(level.interaction_manager))
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_remove(level.interaction_manager.data["actors"], self);
}

can_play_nearby_interaction(var_0) {
  var_1 = level.player.origin;

  if(isDefined(var_0))
    var_2 = var_0;
  else
    var_2 = 140.0;

  if(!isDefined(level.interaction_manager))
    return 1;

  if(isDefined(self.allow_interactions) && !self.allow_interactions)
    return 0;

  reconstruct_actor_array();

  foreach(var_4 in level.interaction_manager.data["actors"]) {
    if(isDefined(var_4) && isDefined(self)) {
      if(distance(self.origin, var_4.origin) < var_2) {
        if(scripts\engine\utility::hastag(var_4.model, "j_spine4") && level.player scripts\engine\math::point_in_fov(var_4 gettagorigin("j_spine4"))) {
          if(isDefined(var_4.is_playing_reaction) && var_4.is_playing_reaction)
            return 0;
        }
      }
    }
  }

  return 1;
}

can_play_nearby_gesture(var_0) {
  var_1 = level.player.origin;

  if(isDefined(var_0))
    var_2 = var_0;
  else
    var_2 = 140.0;

  if(!isDefined(level.interaction_manager))
    return 1;

  reconstruct_actor_array();

  foreach(var_4 in level.interaction_manager.data["actors"]) {
    if(isDefined(var_4) && isDefined(self)) {
      if(self != var_4) {
        if(distance(self.origin, var_4.origin) < var_2) {
          if(scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var_4 gettagorigin("j_spine4"), cos(45))) {
            if(isDefined(var_4.playing_gesture) && var_4.playing_gesture || isDefined(var_4.is_talking) && var_4.is_talking)
              return 0;

            if(isDefined(var_4.allow_gesture_reactions) && !var_4.allow_gesture_reactions)
              return 0;
          }
        }
      }
    }
  }

  return 1;
}

interaction_cooldown_timer(var_0) {
  if(isDefined(level.interaction_manager)) {
    if(isDefined(var_0.allow_interactions) && !var_0.allow_interactions) {
      return;
    }
    reconstruct_actor_array();

    foreach(var_2 in level.interaction_manager.data["actors"]) {
      if(isDefined(var_2))
        var_2.allow_interactions = 0;
    }

    for(;;) {
      var_4 = length(level.player.origin - level.player getEye());
      var_5 = var_0.origin + anglestoup(var_0.angles) * var_4;

      if(!level.player scripts\engine\sp\utility::player_looking_at(var_5, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    reconstruct_actor_array();
    var_0.allow_interactions = 1;

    foreach(var_2 in level.interaction_manager.data["actors"]) {
      if(isDefined(var_2))
        var_2.allow_interactions = 1;
    }
  }
}

interaction_reboot_timer() {
  self endon("death");

  if(isDefined(level.interaction_manager)) {
    if(isDefined(self.allow_interactions) && !self.allow_interactions) {
      return;
    }
    self.allow_interactions = 0;
    wait 20.0;

    for(;;) {
      if(isDefined(self.reaction_state) && self.reaction_state != "nag" && self.reaction_state != "busy") {
        break;
      }

      waitframe();
    }

    for(;;) {
      var_0 = length(level.player.origin - level.player getEye());
      var_1 = self.origin + anglestoup(self.angles) * var_0;

      if(!level.player scripts\engine\sp\utility::player_looking_at(var_1, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    self.allow_interactions = 1;
  }
}

reminder_cooldown_timer(var_0) {
  level endon("stop_reminders");
  level endon("reboot_timer");
  level.interaction_manager.can_remind = 0;
  wait(var_0);
  level.interaction_manager.can_remind = 1;
}

queue_reminder(var_0, var_1, var_2) {
  if(!isDefined(var_0) && isDefined(var_1))
    var_0 = "none";

  if(isDefined(var_1))
    var_0 = var_0 + "+" + var_1;

  level.interaction_manager.data["reminder_queue"][var_0] = self;

  if(isDefined(var_2))
    self.reminder_animnode = var_2;
}

queue_reminder_distance_anim(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0))
    var_0 = var_0 + "+" + var_1;
  else
    var_0 = var_1;

  level.interaction_manager.data["reminder_queue"][var_0] = self;

  if(isDefined(var_2))
    self.reminder_animnode = var_2;

  self.use_reminder_anim = 1;

  if(isDefined(var_3))
    self.return_anime = var_3;
}

queue_reminder_with_reaction(var_0, var_1, var_2, var_3) {
  queue_reminder(var_0);
  self.use_reminder_reaction = 1;
  self.registered_interaction = var_2;
  self.post_reaction_vo_array = var_3;
  self.reminder_reaction_pointat = var_1;
}

run_reminders(var_0) {
  level endon("stop_reminders");
  level thread reminder_queue_cleanup();
  var_1 = getarraykeys(level.interaction_manager.data["reminder_queue"]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level.interaction_manager.data["reminder_queue"][var_3];

    if(isDefined(var_4)) {
      var_5 = strtok(var_3, "+");
      var_6 = var_5[0];

      if(isDefined(var_4.use_reminder_reaction) && var_4.use_reminder_reaction) {
        if(isDefined(var_4.registered_interaction) && isDefined(var_4.post_reaction_vo_array))
          var_4 thread scripts\sp\interaction::play_smart_interaction(var_4.registered_interaction, var_6, var_4.post_reaction_vo_array);
        else if(isDefined(self.post_reaction_func) && isDefined(self.post_reaction_vo))
          self thread[[self.post_reaction_func]](undefined, undefined, self.post_reaction_vo);
        else
          var_4 thread play_gesture_reaction(85.0, 50.0, var_6, 1, var_4.reminder_reaction_pointat);
      } else if(isDefined(var_4.use_reminder_anim) && var_4.use_reminder_anim) {
        var_7 = undefined;
        var_8 = undefined;

        if(var_5.size > 1) {
          var_7 = var_5[1];
          var_8 = var_6;
        } else
          var_7 = var_5[0];

        if(isDefined(var_4.reminder_animnode))
          var_4.reminder_animnode thread play_reminder_anim_distance(var_4, 85.0, 50.0, var_7, undefined, 1);
        else
          var_4 thread play_reminder_anim_distance(var_4, 85.0, 50.0, var_7, undefined, 1);
      }
    }
  }

  wait(var_0);

  while(level.interaction_manager.pause_remind)
    waitframe();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level.interaction_manager.data["reminder_queue"][var_3];

    if(isDefined(var_4)) {
      var_5 = strtok(var_3, "+");
      var_6 = var_5[0];

      if(var_5.size > 1) {
        if(isDefined(var_4.reminder_animnode)) {
          var_4.reminder_animnode notify("stop_loop");
          var_4.reminder_animnode thread scripts\common\anim::anim_single_solo(var_4, var_5[1]);
          var_9 = getanimlength(var_4 scripts\engine\utility::getanim(var_5[1]));
          var_4 thread scripts\engine\sp\utility::notify_delay("reminder_anim_done", var_9);

          if(isDefined(var_4.return_anime))
            var_4.reminder_animnode scripts\engine\utility::delaythread(var_9, scripts\common\anim::anim_loop_solo, var_4, var_4.return_anime, "stop_loop");
        } else {
          var_4 notify("stop_loop");
          var_4 thread scripts\common\anim::anim_single_solo(var_4, var_5[1]);
          var_9 = getanimlength(var_4 scripts\engine\utility::getanim(var_5[1]));
          var_4 thread scripts\engine\sp\utility::notify_delay("reminder_anim_done", var_9);

          if(isDefined(var_4.return_anime))
            var_4 scripts\engine\utility::delaythread(var_9, scripts\common\anim::anim_loop_solo, var_4, var_4.return_anime, "stop_loop");
        }

        if(var_6 != "none") {
          if(soundexists(var_6))
            var_4 scripts\engine\sp\utility::smart_dialogue(var_6);
        }
      } else if(!soundexists(var_3))
        var_4 scripts\engine\sp\utility::smart_dialogue(var_3);

      var_4 notify("reminder_done");
      var_4.reminder_animnode = undefined;
      level.interaction_manager.data["reminder_queue"][var_3] = undefined;
      level.interaction_manager.can_remind = 0;
      wait(var_0);
      level.interaction_manager.can_remind = 1;
    }

    while(level.interaction_manager.pause_remind)
      waitframe();
  }

  level notify("reminders_done");
}

reminder_queue_cleanup() {
  level scripts\engine\utility::waittill_any("stop_reminders", "reminders_done");
  level.interaction_manager.data["reminder_queue"] = [];
}

stop_reminders() {
  level notify("stop_reminders");
  level notify("reminders_done");
  level.interaction_manager.data["reminder_queue"] = [];
  reconstruct_actor_array();

  foreach(var_1 in level.interaction_manager.data["actors"]) {
    if(isDefined(var_1)) {
      var_1.use_reminder_reaction = undefined;
      var_1.registered_interaction = undefined;
      var_1.post_reaction_vo_array = undefined;
      var_1.reminder_reaction_pointat = undefined;
      var_1.reminder_animnode = undefined;
      var_1.use_reminder_anim = undefined;
    }
  }
}

pause_reminders() {
  level.interaction_manager.pause_remind = 1;
}

continue_reminders() {
  level.interaction_manager.pause_remind = 0;
}

play_state_based_interaction(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = "casual";

  if(isDefined(self.gender) && issubstr(self.gender, "female"))
    var_2 = "busy";

  var_4 = var_0 + "_" + "casual";

  if(var_2 == "casual" || var_2 == "nag")
    var_4 = var_0 + "_" + var_2;

  self.reaction_state_basename = var_0;
  self.reaction_state = var_2;

  if(var_2 == "nag") {
    thread scripts\sp\interaction::play_interaction_with_states(var_4, var_1);
    self.allow_interactions = 0;
    self.reaction_state = var_2;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_3, 1);
    return;
  } else if(var_2 == "busy") {
    thread scripts\sp\interaction::play_interaction_with_states(var_4, var_1);
    self.allow_interactions = 0;
    self.reaction_state = var_2;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_3);
    return;
  }

  thread scripts\sp\interaction::play_interaction_with_states(var_4, var_1);
}

stop_state_based_interaction() {
  if(!isDefined(self.is_cheap))
    thread scripts\sp\interaction::interaction_end();
  else
    self notify("reaction_end");

  self notify("change_reaction_state");
  self.reaction_state = undefined;
  self.allow_interactions = undefined;
  self.reaction_state_basename = undefined;
  thread scripts\engine\sp\utility::gesture_stop(0.7);
}

set_reaction_state(var_0, var_1) {
  if(!isDefined(self.reaction_state)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self.reaction_state_basename)) {
    return;
  }
  self notify("change_reaction_state");
  self notify("stop_reaction_look");

  if(var_0 != "nag" && var_0 != "busy") {
    self.allow_interactions = 1;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    self.interaction_name = self.reaction_state_basename + "_" + var_0;
    self.reaction_state = var_0;
  } else if(var_0 == "nag") {
    self.allow_interactions = 0;
    self.reaction_state = var_0;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_1, 1);
  } else {
    self.allow_interactions = 0;
    self.reaction_state = var_0;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_1);
  }
}

reaction_state_busy_loop(var_0, var_1) {
  self endon("change_reaction_state");

  for(;;) {
    thread gesture_reaction_distance_based(var_0, var_1);
    self waittill("end_gesture_reaction_distance_based");

    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= level.state_interactions[self.interaction_name].scene["trigger_radius"] + 50.0) {
        break;
      }

      waitframe();
    }
  }
}

set_all_reaction_states(var_0, var_1) {
  switch (var_0) {
    case "busy":
    case "nag":
    case "alert":
    case "casual":
      foreach(var_3 in level.interaction_manager.data["actors"])
      var_3 thread set_reaction_state(var_0, var_1);

      break;
  }
}

reaction_look_distance_based(var_0, var_1, var_2, var_3) {
  self endon("death");
  self notify("stop_reaction_look");
  self endon("stop_reaction_look");
  self endon("stop_smart_reaction");
  var_4 = 85.0;

  if(isDefined(var_0))
    var_4 = var_0;

  if(!isDefined(var_1))
    var_1 = level.player;

  if(!isDefined(var_2))
    var_2 = 0.7;

  wait(var_2);

  if(isDefined(self.reaction_state_basename)) {
    if(isDefined(level.state_interactions[self.interaction_name].scene["trigger_radius"]))
      var_4 = level.state_interactions[self.interaction_name].scene["trigger_radius"] * 1.2;
  }

  waitframe();

  if(isDefined(var_3) && var_3)
    thread scripts\engine\sp\utility::gesture_follow_lookat(var_1, 0.5, 0.5);
  else
    thread scripts\engine\sp\utility::gesture_follow_lookat_natural(var_1, 0.5, 0.5, var_4);

  while(!isDefined(self.is_head_tracking))
    wait 0.05;

  thread scripts\engine\sp\utility::gesture_follow_eyes(var_1);
  wait(randomfloatrange(4.0, 6.0));
  var_5 = 1;
  var_6 = 1;

  for(;;) {
    if(distance2d(self.origin, var_1.origin) <= var_4) {
      if(!var_6) {
        thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_up(0.5);
        thread scripts\engine\sp\utility::gesture_follow_eyes(var_1);
        var_6 = 1;
      }
    } else if(distance2d(self.origin, var_1.origin) >= var_4) {
      if(var_6) {
        thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_down(1.0);
        thread scripts\engine\sp\utility::gesture_eyes_stop(0.7);
        var_6 = 0;
      }
    }

    waitframe();
  }
}

gesture_reaction_distance_based(var_0, var_1) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_reaction_look");
  var_2 = 50.0;

  if(isDefined(self.reaction_state_basename)) {
    if(isDefined(level.state_interactions[self.interaction_name].scene["trigger_radius"]))
      var_2 = level.state_interactions[self.interaction_name].scene["trigger_radius"];
  }

  waittill_gestureconditionsmet(var_2);
  thread scripts\engine\sp\utility::gesture_simple("salute");
  var_3 = undefined;

  if(isDefined(var_1) && var_1) {
    switch (var_0) {
      case "bridge_elev":
      case "bridge_elev_doors":
      case "cic":
      case "ftl":
      case "opsmap":
      case "captains":
      case "lounge":
      case "dropship":
      case "jackal":
      case "bridge":
        var_4 = level.interaction_manager.data["reminder_vo"][var_0][self.gender];
        var_5 = level.interaction_manager.data["reminder_vo"][var_0]["spent_" + self.gender];

        if(var_4.size < 1 && var_5.size > 0) {
          level.interaction_manager.data["reminder_vo"][var_0][self.gender] = var_5;
          level.interaction_manager.data["reminder_vo"][var_0]["spent_" + self.gender] = [];
          var_4 = level.interaction_manager.data["reminder_vo"][var_0][self.gender];
          var_5 = level.interaction_manager.data["reminder_vo"][var_0]["spent_" + self.gender];
        }

        if(var_4.size < 1 && var_5.size < 1)
          var_3 = undefined;
        else {
          var_3 = var_4[randomint(var_4.size)];
          level.interaction_manager.data["reminder_vo"][var_0]["spent_" + self.gender] = scripts\engine\utility::array_add(level.interaction_manager.data["reminder_vo"][var_0]["spent_" + self.gender], var_3);
          level.interaction_manager.data["reminder_vo"][var_0][self.gender] = scripts\engine\utility::array_remove(level.interaction_manager.data["reminder_vo"][var_0][self.gender], var_3);
        }

        break;
    }
  } else {
    var_4 = level.interaction_manager.data["busy_vo"][self.gender];
    var_5 = level.interaction_manager.data["busy_vo"]["spent_" + self.gender];

    if(var_4.size < 1 && var_5.size > 0) {
      level.interaction_manager.data["busy_vo"][self.gender] = var_5;
      level.interaction_manager.data["busy_vo"]["spent_" + self.gender] = [];
      var_4 = level.interaction_manager.data["busy_vo"][self.gender];
      var_5 = level.interaction_manager.data["busy_vo"]["spent_" + self.gender];
    }

    if(var_4.size < 1 && var_5.size < 1)
      var_3 = undefined;
    else {
      var_3 = var_4[randomint(var_4.size)];
      level.interaction_manager.data["busy_vo"]["spent_" + self.gender] = scripts\engine\utility::array_add(level.interaction_manager.data["busy_vo"]["spent_" + self.gender], var_3);
      level.interaction_manager.data["busy_vo"][self.gender] = scripts\engine\utility::array_remove(level.interaction_manager.data["busy_vo"][self.gender], var_3);
    }
  }

  if(isDefined(var_3)) {
    scripts\engine\sp\utility::smart_dialogue(var_3);

    if(isDefined(var_1) && var_1)
      level thread reminder_cooldown_timer(90.0);
  }

  self.playing_gesture = 1;
  self notify("end_gesture_reaction_distance_based");
  wait 15.0;
  self.playing_gesture = 0;
}

print_reaction_state() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");

  for(;;) {
    if(isDefined(self.allow_gesture_reactions)) {}

    if(isDefined(self.gender)) {}

    if(isDefined(self.animname)) {}

    waitframe();
  }
}

play_gesture_reaction(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  thread add_actor_to_manager();

  if(isDefined(self.allow_gesture_reactions) && !self.allow_gesture_reactions)
    self.allow_gesture_reactions = 1;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_0))
    var_0 = 150.0;

  if(!isDefined(var_1))
    var_1 = var_0 * 0.5;

  if(!isDefined(self.is_head_tracking) || isDefined(self.is_head_tracking) && !self.is_head_tracking)
    thread reaction_look_distance_based(var_0);

  waittill_gestureconditionsmet(var_1);
  play_gesture_reaction_anim(var_4);
  play_interaction_vo(var_2, var_3);
}

waittill_gestureconditionsmet(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  var_1 = 1;

  for(;;) {
    if(isplayerfocus(var_0) && canplaygesture(var_0)) {
      var_2 = scripts\engine\utility::flatten_vector(anglestoright(self gettagangles("j_head")));
      var_3 = scripts\engine\utility::flatten_vector(vectorNormalize(level.player getEye() - self gettagorigin("j_head")));
      var_4 = vectordot(var_2, var_3);

      if(var_4 >= 0.8) {
        break;
      }
    }

    waitframe();
  }
}

isplayerfocus(var_0) {
  self endon("death");

  if(isDefined(self.is_cheap))
    var_1 = self gettagorigin("j_head");
  else if(isai(self))
    var_1 = self getEye();
  else if(isDefined(self.origin))
    var_1 = self.origin;
  else
    return 0;

  var_2 = level.player getEye();
  var_3 = level.player getplayerangles();

  if(distance2d(self.origin, level.player.origin) <= var_0) {
    if(scripts\engine\utility::within_fov(var_2, var_3, var_1, cos(25)))
      return 1;
  }

  return 0;
}

canplaygesture(var_0) {
  if(!isDefined(self.allow_gesture_reactions) || isDefined(self.allow_gesture_reactions) && self.allow_gesture_reactions) {
    if(!isDefined(self.gesture_reaction_queue)) {
      if(can_play_nearby_gesture(var_0))
        return 1;
    }
  }

  return 0;
}

#using_animtree("generic_human");

play_gesture_reaction_anim(var_0) {
  self.playing_gesture = 1;

  if(!isDefined(self.is_cheap)) {
    if(isDefined(var_0))
      thread scripts\engine\sp\utility::gesture_point(var_0);
    else
      thread scripts\engine\sp\utility::gesture_simple("salute");
  } else
    scripts\engine\sp\utility::gesture_custom(%shipcrib_gst_head_salute_01);

  self.playing_gesture = undefined;
}

play_interaction_vo(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isDefined(var_1) && var_1) {
      force_reminder_delay(30);
      clear_reminder(var_0);
    }

    define_face_anim_if_exists(var_0);
    self.is_talking = 1;
    play_smart_dialog_if_exists(var_0);
    self.is_talking = undefined;
  }
}

define_face_anim_if_exists(var_0) {
  if(!isDefined(self.animname))
    self.animname = "generic";

  if(!isDefined(level.scr_face[self.animname]))
    level.scr_face[self.animname] = [];

  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      if(!isDefined(level.scr_face[self.animname][var_2])) {
        if(isDefined(level.shipcrib_linebook_anims) && isDefined(self.gender)) {
          if(isDefined(level.shipcrib_linebook_anims[self.gender]) && isDefined(level.shipcrib_linebook_anims[self.gender][var_2]))
            level.scr_face[self.animname][var_2] = level.shipcrib_linebook_anims[self.gender][var_2];
        }
      }
    }
  } else if(!isDefined(level.scr_face[self.animname][var_0])) {
    if(isDefined(level.shipcrib_linebook_anims) && isDefined(self.gender)) {
      if(isDefined(level.shipcrib_linebook_anims[self.gender]) && isDefined(level.shipcrib_linebook_anims[self.gender][var_0]))
        level.scr_face[self.animname][var_0] = level.shipcrib_linebook_anims[self.gender][var_0];
    }
  }
}

play_smart_dialog_if_exists(var_0) {
  var_1 = undefined;

  if(isarray(var_0)) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_3 = var_0[var_2];

      if(isstring(var_3)) {
        define_face_anim_if_exists(var_3);

        if(soundexists(var_3)) {
          if(issubstr(var_3, "plr"))
            level.player scripts\engine\sp\utility::smart_player_dialogue(var_3);
          else {
            var_1 = main_cast_dialog_actor_check(var_3);

            if(isDefined(var_1))
              var_1 scripts\engine\sp\utility::smart_dialogue(var_3);
            else
              scripts\engine\sp\utility::smart_dialogue(var_3);
          }
        }

        continue;
      }

      if(isnumber(var_3))
        wait(var_3);
    }
  } else {
    var_3 = var_0;

    if(isstring(var_3)) {
      define_face_anim_if_exists(var_3);

      if(soundexists(var_3)) {
        if(issubstr(var_3, "plr"))
          level.player scripts\engine\sp\utility::smart_player_dialogue(var_3);
        else {
          var_1 = main_cast_dialog_actor_check(var_3);

          if(isDefined(var_1))
            var_1 scripts\engine\sp\utility::smart_dialogue(var_3);
          else
            scripts\engine\sp\utility::smart_dialogue(var_3);
        }
      }
    }
  }
}

force_reminder_delay(var_0) {
  level notify("reboot_timer");
  waitframe();
  level thread reminder_cooldown_timer(var_0);
}

clear_reminder(var_0) {
  if(isDefined(level.interaction_manager)) {
    if(isDefined(level.interaction_manager.data["reminder_queue"])) {
      if(scripts\engine\utility::array_contains(level.interaction_manager.data["reminder_queue"], self))
        level.interaction_manager.data["reminder_queue"][var_0] = undefined;
    }
  }
}

play_group_gesture_reaction(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 endon("death");
    var_5 endon("stop_reaction");
    var_5 endon("reaction_end");
    var_5 endon("stop_gesture_reaction");
    var_5 endon("stop_smart_reaction");
  }

  foreach(var_5 in var_0)
  var_5 thread add_actor_to_manager();

  thread reaction_group_look_distance_based(var_0, var_1);
  waittill_group_gestureconditionsmet(var_0, var_2);
  play_group_gesture_performance(var_0, var_3, var_2);

  foreach(var_5 in var_0) {
    var_10 = randomfloatrange(0, 1);
    var_11 = randomfloatrange(0.5, 1.5);
    var_5 scripts\engine\utility::delaythread(var_10, scripts\engine\sp\utility::gesture_stop, var_11);
  }
}

waittill_group_gestureconditionsmet(var_0, var_1) {
  var_2 = 1;
  var_3 = create_middle_ent(var_0);
  var_0 = scripts\engine\utility::array_add(var_0, var_3);

  while(var_2) {
    foreach(var_5 in var_0) {
      if(var_5 isplayerfocus(var_1)) {
        var_2 = 0;
        break;
      }
    }

    waitframe();
  }
}

create_middle_ent(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  foreach(var_4 in var_0) {
    var_2 = var_2 + var_4.origin;
    var_1++;
  }

  var_6 = var_2 / var_1;
  var_7 = scripts\engine\utility::spawn_tag_origin(var_6, (0, 0, 0));
  return var_7;
}

play_group_gesture_performance(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isDefined(var_0[var_3]) && isDefined(var_1[var_3])) {
      var_0[var_3] play_gesture_reaction_anim();
      var_0[var_3] play_interaction_vo(var_1[var_3]);
    }

    if(!group_isplayerfocus(var_2, var_0)) {
      break;
    }
  }
}

group_isplayerfocus(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3 isplayerfocus(var_0))
      return 1;
  }

  return 0;
}

reaction_group_look_distance_based(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 endon("death");
    var_4 endon("stop_reaction");
    var_4 endon("reaction_end");
    var_4 endon("stop_reaction_look");
    var_4 endon("stop_smart_reaction");
  }

  var_6 = 85.0;

  if(isDefined(var_1))
    var_6 = var_1;

  if(!isDefined(var_2))
    var_2 = level.player;

  initialize_group_lookat(var_0, var_2);
  var_7 = create_middle_ent(var_0);

  for(;;) {
    update_lookat_status(var_0, var_7, var_2, var_1);
    update_lookat_weights(var_0);
    update_lookat_delays(var_0);
    waitframe();
  }
}

initialize_group_lookat(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 scripts\engine\sp\utility::gesture_follow_lookat(var_1, 0.15, 0.7);
    var_3.lookat_enabled = 0;
    var_3.lookat_delay = 0;
  }

  waitframe();

  foreach(var_3 in var_0)
  var_3 thread scripts\engine\sp\utility::gesture_eye_dart_loop(var_1);
}

update_lookat_status(var_0, var_1, var_2, var_3) {
  if(distance2d(var_1.origin, var_2.origin) <= var_3)
    enable_lookat(var_0);
  else
    disable_lookat(var_0);
}

enable_lookat(var_0) {
  foreach(var_2 in var_0) {
    if(!var_2.lookat_enabled)
      var_2 create_lookat_delay();

    var_2.lookat_enabled = 1;
  }
}

disable_lookat(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.lookat_enabled)
      var_2 create_lookat_delay();

    var_2.lookat_enabled = 0;
  }
}

update_lookat_weights(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.lookat_delay <= 0) {
      if(var_2.lookat_enabled) {
        var_2 increase_lookat_weight();
        continue;
      }

      var_2 decrease_lookat_weight();
    }
  }
}

update_lookat_delays(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.lookat_delay > 0)
      var_2.lookat_delay = var_2.lookat_delay - 0.05;
  }
}

create_lookat_delay() {
  self.lookat_delay = randomfloatrange(0, 1);
}

clear_lookat_delay() {
  self.lookat_delay = 0;
}

increase_lookat_weight() {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_up(0.7);
}

decrease_lookat_weight() {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_down(0.7);
}

convertvar_toarray(var_0) {
  if(!isarray(var_0))
    return [var_0];
  else
    return var_0;
}

play_gesture_reaction_loop(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_5 = [];
  var_6 = var_2;

  for(;;) {
    if(var_6.size <= 0) {
      var_5 = [];
      var_6 = var_2;
    }

    var_7 = var_6[randomint(var_6.size)];
    play_gesture_reaction(var_0, var_1, var_7, var_3, var_4);

    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= var_0) {
        break;
      }

      waitframe();
    }

    waitframe();
    var_5 = scripts\engine\utility::array_add(var_5, var_7);
    var_6 = scripts\engine\utility::array_remove(var_6, var_7);
  }
}

stop_gesture_reaction() {
  self notify("stop_gesture_reaction");
  self notify("stop_reaction_look");
  self notify("stop_gesture_reaction_set");
  self.gesture_reaction_queue = undefined;
  scripts\engine\sp\utility::gesture_stop(0.7);
}

stop_queued_reaction() {
  self notify("stop_smart_reaction");
  thread scripts\sp\interaction::interaction_end();
}

queue_gesture_reaction(var_0) {
  if(!isDefined(self.gesture_reaction_queue))
    self.gesture_reaction_queue = [];

  var_1 = var_0;

  if(isarray(var_0))
    var_1 = var_0[0];

  self.gesture_reaction_queue[var_1] = var_0;
}

play_gesture_reaction_set(var_0, var_1) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction_set");
  self notify("stop_reaction_look");
  scripts\engine\sp\utility::gesture_stop(0.7);
  thread add_actor_to_manager();
  self.allow_gesture_reactions = 1;

  if(!isDefined(var_0))
    var_0 = 150.0;

  if(!isDefined(var_1))
    var_1 = var_0 * 0.5;

  thread reaction_look_distance_based(var_0);
  var_2 = getarraykeys(self.gesture_reaction_queue);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = self.gesture_reaction_queue[var_4];

    for(;;) {
      if(!isDefined(self)) {
        return;
      }
      var_6 = length(level.player.origin - level.player getEye());
      var_7 = self.origin + anglestoup(self.angles) * var_6;

      if(level.player scripts\engine\sp\utility::player_looking_at(var_7, 0.75, 1)) {
        if(distance2d(self.origin, level.player.origin) <= var_1 && can_play_nearby_gesture(var_1)) {
          break;
        }
      }

      waitframe();
    }

    thread scripts\engine\sp\utility::gesture_simple("salute");
    self.allow_gesture_reactions = 0;

    if(isarray(var_5)) {
      for(var_8 = 0; var_8 < var_5.size; var_8++) {
        var_9 = var_5[var_8];

        if(isstring(var_9)) {
          define_face_anim_if_exists(var_9);

          if(soundexists(var_9)) {
            if(issubstr(var_9, "plr"))
              level.player scripts\engine\sp\utility::smart_player_dialogue(var_9);
            else {
              var_10 = main_cast_dialog_actor_check(var_9);

              if(isDefined(var_10))
                var_10 scripts\engine\sp\utility::smart_dialogue(var_9);
              else
                scripts\engine\sp\utility::smart_dialogue(var_9);
            }
          }

          continue;
        }

        if(isnumber(var_9))
          wait(var_9);
      }
    } else if(soundexists(var_5)) {
      define_face_anim_if_exists(var_5);
      var_10 = main_cast_dialog_actor_check(var_5);

      if(isDefined(var_10))
        var_10 scripts\engine\sp\utility::smart_dialogue(var_5);
      else
        scripts\engine\sp\utility::smart_dialogue(var_5);
    }

    self.gesture_reaction_queue[var_4] = undefined;
    wait 5.0;
    self.allow_gesture_reactions = 1;
  }

  self.gesture_reaction_queue = undefined;

  if(isDefined(self.post_reaction_func) && isDefined(self.post_reaction_vo))
    self thread[[self.post_reaction_func]](undefined, undefined, self.post_reaction_vo);
}

main_cast_dialog_actor_check(var_0) {
  var_1 = strtok(var_0, "_");

  if(scripts\engine\utility::array_contains(var_1, "nav") || scripts\engine\utility::array_contains(var_1, "gtr"))
    return level.gator;
  else if(scripts\engine\utility::array_contains(var_1, "slt") || scripts\engine\utility::array_contains(var_1, "xo"))
    return level.salter;
  else if(scripts\engine\utility::array_contains(var_1, "bsw")) {
    if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner")
      return level.sipes;
    else
      return level.sotomura;
  } else if(scripts\engine\utility::array_contains(var_1, "cmo"))
    return level.comms;
  else if(scripts\engine\utility::array_contains(var_1, "dpo"))
    return level.drop_officer;

  return undefined;
}

play_reminder_anim_distance(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(isDefined(var_0.pre_reaction_func)) {
    if(isDefined(var_0.pre_reaction_params)) {
      if(var_0.pre_reaction_params.size == 1)
        var_0[[var_0.pre_reaction_func]](var_0.pre_reaction_params[0]);
      else if(var_0.pre_reaction_params.size == 2)
        var_0[[var_0.pre_reaction_func]](var_0.pre_reaction_params[0], var_0.pre_reaction_params[1]);
      else if(var_0.pre_reaction_params.size == 3)
        var_0[[var_0.pre_reaction_func]](var_0.pre_reaction_params[0], var_0.pre_reaction_params[1], var_0.pre_reaction_params[2]);
    }
  }

  level endon("stop_reminders");
  level endon("reminders_done");
  var_0 thread add_actor_to_manager();

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_1))
    var_1 = 150.0;

  if(!isDefined(var_2))
    var_2 = var_1 * 0.5;

  if(!isDefined(var_0.is_head_tracking) || isDefined(var_0.is_head_tracking) && !var_0.is_head_tracking)
    var_0 thread reaction_look_distance_based(var_1);

  while(distance2d(var_0.origin, level.player.origin) <= var_1 + 25.0)
    waitframe();

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    var_6 = length(level.player.origin - level.player getEye());
    var_7 = var_0.origin + anglestoup(var_0.angles) * var_6;

    if(level.player scripts\engine\sp\utility::player_looking_at(var_7, 0.75, 1)) {
      if(distance2d(var_0.origin, level.player.origin) <= var_2) {
        break;
      }
    }

    waitframe();
  }

  self notify("stop_loop");
  thread scripts\common\anim::anim_single_solo(var_0, var_3);
  var_8 = getanimlength(var_0 scripts\engine\utility::getanim(var_3));
  thread scripts\engine\sp\utility::notify_delay("reminder_anim_done", var_8);

  if(isDefined(var_0.return_anime))
    scripts\engine\utility::delaythread(var_8, scripts\common\anim::anim_loop_solo, var_0, var_0.return_anime, "stop_loop");

  if(isDefined(var_4)) {
    if(var_5) {
      level notify("reboot_timer");
      waitframe();
      level thread reminder_cooldown_timer(90.0);

      if(isDefined(level.interaction_manager)) {
        if(isDefined(level.interaction_manager.data["reminder_queue"])) {
          if(scripts\engine\utility::array_contains(level.interaction_manager.data["reminder_queue"], var_0))
            level.interaction_manager.data["reminder_queue"][var_4] = undefined;
        }
      }
    }

    var_0 play_smart_dialog_if_exists(var_4);
  }

  if(isDefined(var_0.post_reaction_func) && !isDefined(var_0.post_reaction_vo)) {
    if(isDefined(var_0.post_reaction_params)) {
      if(var_0.pre_reaction_params.size == 1)
        var_0[[var_0.post_reaction_func]](var_0.post_reaction_params[0]);
      else if(var_0.pre_reaction_params.size == 2)
        var_0[[var_0.post_reaction_func]](var_0.post_reaction_params[0], var_0.post_reaction_params[1]);
      else if(var_0.pre_reaction_params.size == 3)
        var_0[[var_0.post_reaction_func]](var_0.post_reaction_params[0], var_0.post_reaction_params[1], var_0.post_reaction_params[2]);
    }
  } else if(isDefined(var_0.post_reaction_func) && isDefined(var_0.post_reaction_vo))
    var_0 thread[[var_0.post_reaction_func]](undefined, undefined, var_0.post_reaction_vo);
}

reminder_vo_init() {
  level.interaction_manager.data["reminder_vo"]["bridge"]["male_1"] = ["shipcrib_us1_wantedonbridge"];
  level.interaction_manager.data["reminder_vo"]["bridge"]["male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["female_1"] = ["shipcrib_us1_wantedonbridge"];
  level.interaction_manager.data["reminder_vo"]["bridge"]["female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["lounge"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["female"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["captains"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["opsmap"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["ftl"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["cic"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["male_1"] = ["shipcrib_un1_theyrewaitingfo", "shipcrib_un1_theyreattheelev"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["male_2"] = ["shipcrib_un2_theyreneartheel", "shipcrib_un2_theyrenearthee"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["male_3"] = ["shipcrib_un3_youreneededby", "shipcrib_un3_elevatordoorsa"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["female_1"] = ["shipcrib_unf1_theyrebythedoo", "shipcrib_unf1_theyrewaitingatt"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["female_2"] = ["shipcrib_unf2_ithinktheyrewaitin", "shipcrib_unf2_gettotheelevatord"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["female_3"] = ["shipcrib_unf3_theyrelookingfory", "shipcrib_unf3_elevatordoorsarea"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev_doors"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["male_1"] = ["shipcrib_un1_youreneededbythe", "shipcrib_un1_youreneededbythee"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["male_2"] = ["shipcrib_un2_theyrewaitingforyo", "shipcrib_un2_theyneedyoubyt"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["male_3"] = ["shipcrib_un3_elevatorswaitinfo", "shipcrib_un3_elevatorswaitinfor"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["female_1"] = ["shipcrib_unf1_elevatorsreadytot", "shipcrib_unf1_elevatorsreadyfo"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["female_2"] = ["shipcrib_unf2_theyrereadyforyo", "shipcrib_unf2_theyrebytheelev"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["female_3"] = ["shipcrib_unf3_elevatorsreadya", "shipcrib_unf3_elevatorsaroundt"];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["bridge_elev"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["dropship"]["male_1"] = ["shipcrib_un1_dropshipsfueled"];
  level.interaction_manager.data["reminder_vo"]["dropship"]["male_2"] = ["shipcrib_un2_yourdropshipisr"];
  level.interaction_manager.data["reminder_vo"]["dropship"]["male_3"] = ["shipcrib_un3_dropshipswaitingf"];
  level.interaction_manager.data["reminder_vo"]["dropship"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["dropship"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["dropship"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["dropship"]["female_1"] = ["shipcrib_unf1_bossgibsonhasad"];
  level.interaction_manager.data["reminder_vo"]["dropship"]["female_2"] = ["shipcrib_unf2_dropshipsreadyto"];
  level.interaction_manager.data["reminder_vo"]["dropship"]["female_3"] = ["shipcrib_unf3_reportfromtheflight"];
  level.interaction_manager.data["reminder_vo"]["dropship"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["dropship"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["dropship"]["spent_female_3"] = [];
  level.interaction_manager.data["reminder_vo"]["jackal"]["male_1"] = ["shipcrib_un1_yourjackalisread"];
  level.interaction_manager.data["reminder_vo"]["jackal"]["male_2"] = ["shipcrib_un2_gibsonhasyourja"];
  level.interaction_manager.data["reminder_vo"]["jackal"]["male_3"] = ["shipcrib_un3_flightdeckreports"];
  level.interaction_manager.data["reminder_vo"]["jackal"]["spent_male_1"] = [];
  level.interaction_manager.data["reminder_vo"]["jackal"]["spent_male_2"] = [];
  level.interaction_manager.data["reminder_vo"]["jackal"]["spent_male_3"] = [];
  level.interaction_manager.data["reminder_vo"]["jackal"]["female_1"] = ["shipcrib_unf1_yourjackalsreadyin"];
  level.interaction_manager.data["reminder_vo"]["jackal"]["female_2"] = ["shipcrib_unf2_bossgibsonsaysc"];
  level.interaction_manager.data["reminder_vo"]["jackal"]["female_3"] = ["shipcrib_unf3_jackalsreadyandw"];
  level.interaction_manager.data["reminder_vo"]["jackal"]["spent_female_1"] = [];
  level.interaction_manager.data["reminder_vo"]["jackal"]["spent_female_2"] = [];
  level.interaction_manager.data["reminder_vo"]["jackal"]["spent_female_3"] = [];
  level.interaction_manager.data["busy_vo"]["male_1"] = ["shipcrib_un1_captain2", "shipcrib_un1_sir2"];
  level.interaction_manager.data["busy_vo"]["male_2"] = ["shipcrib_un2_weregoodheresi", "shipcrib_un2_sorrysirgotalottok"];
  level.interaction_manager.data["busy_vo"]["male_3"] = ["shipcrib_un3_gotthingsundercon", "shipcrib_un3_captain"];
  level.interaction_manager.data["busy_vo"]["spent_male_1"] = [];
  level.interaction_manager.data["busy_vo"]["spent_male_2"] = [];
  level.interaction_manager.data["busy_vo"]["spent_male_3"] = [];
  level.interaction_manager.data["busy_vo"]["female_1"] = ["shipcrib_unf2_captain", "shipcrib_unf2_youllhavetoexcus"];
  level.interaction_manager.data["busy_vo"]["female_2"] = ["shipcrib_unf2_captain", "shipcrib_unf2_youllhavetoexcus"];
  level.interaction_manager.data["busy_vo"]["female_3"] = ["shipcrib_unf3_captainreyes", "shipcrib_unf3_sir"];
  level.interaction_manager.data["busy_vo"]["spent_female_1"] = [];
  level.interaction_manager.data["busy_vo"]["spent_female_2"] = [];
  level.interaction_manager.data["busy_vo"]["spent_female_3"] = [];
}
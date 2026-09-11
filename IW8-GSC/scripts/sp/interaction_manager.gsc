/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\interaction_manager.gsc
***********************************************/

function interaction_manager_init() {
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

function stop_interactions() {
  reconstruct_actor_array();

  foreach(var1 in level.interaction_manager.data["actors"]) {
    var1.allow_interactions = 0;
    var1.allow_gesture_reactions = 0;
  }
}

function stop_interaction() {
  if(scripts\engine\utility::array_contains(level.interaction_manager.data["actors"], self)) {
    self.allow_interactions = 0;
    self.allow_gesture_reactions = 0;
    return;
  }
}

function continue_interactions() {
  reconstruct_actor_array();

  foreach(var1 in level.interaction_manager.data["actors"]) {
    var1.allow_interactions = 1;
    var1.allow_gesture_reactions = 1;
  }
}

function continue_interaction() {
  if(scripts\engine\utility::array_contains(level.interaction_manager.data["actors"], self)) {
    self.allow_interactions = 1;
    self.allow_gesture_reactions = 1;
    return;
  }
}

function trigger_interaction() {
  self endon("death");

  if(isDefined(self.lookat_anims)) {
    self.lookat_anims["interaction_trigger_override"] = 1;
    return;
  }
}

function trigger_interaction_multiple(var0) {
  self endon("death");

  foreach(var2 in var0) {
    if(isDefined(var2.lookat_anims)) {
      var2.lookat_anims["interaction_trigger_override"] = 1;
    }
  }
}

function trigger_interaction_common() {
  self endon("death");
  var0 = self.lookat_anims["common_name"];
  var1 = level.interaction_manager.data["actors"];

  foreach(var3 in var1) {
    if(isDefined(var3.lookat_anims["common_name"])) {
      if(var3.lookat_anims["common_name"] == var0) {
        var3.lookat_anims["interaction_trigger_override"] = 1;
      }
    }
  }
}

function reconstruct_actor_array() {
  foreach(var1 in level.interaction_manager.data["actors"]) {
    if(!isDefined(var1)) {
      level.interaction_manager.data["actors"] = scripts\engine\utility::array_remove(level.interaction_manager.data["actors"], var1);
    }
  }
}

function add_actor_to_manager() {
  if(isDefined(level.interaction_manager)) {
    if(!scripts\engine\utility::array_contains(level.interaction_manager.data["actors"], self)) {
      level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);
      return;
    }

    return;
  }
}

function remove_actor_from_manager() {
  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_remove(level.interaction_manager.data["actors"], self);
    return;
  }
}

function can_play_nearby_interaction(var0) {
  var1 = level.player.origin;

  if(isDefined(var0)) {
    var2 = var0;
  } else {
    var2 = 140;
  }

  if(!isDefined(level.interaction_manager)) {
    return true;
  }

  if(isDefined(self.allow_interactions) && !self.allow_interactions) {
    return false;
  }

  reconstruct_actor_array();

  foreach(var4 in level.interaction_manager.data["actors"]) {
    if(isDefined(var4) && isDefined(self)) {
      if(distance(self.origin, var4.origin) < var2) {
        if(scripts\engine\utility::hastag(var4.model, "j_spine4") && level.player scripts\engine\math::point_in_fov(var4 gettagorigin("j_spine4"))) {
          if(isDefined(var4.is_playing_reaction) && var4.is_playing_reaction) {
            return false;
          }
        }
      }
    }
  }

  return true;
}

function can_play_nearby_gesture(var0) {
  var1 = level.player.origin;

  if(isDefined(var0)) {
    var2 = var0;
  } else {
    var2 = 140;
  }

  if(!isDefined(level.interaction_manager)) {
    return true;
  }

  reconstruct_actor_array();

  foreach(var4 in level.interaction_manager.data["actors"]) {
    if(isDefined(var4) && isDefined(self)) {
      if(self != var4) {
        if(distance(self.origin, var4.origin) < var2) {
          if(scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var4 gettagorigin("j_spine4"), cos(45))) {
            if(isDefined(var4.playing_gesture) && var4.playing_gesture || isDefined(var4.is_talking) && var4.is_talking) {
              return false;
            }

            if(isDefined(var4.allow_gesture_reactions) && !var4.allow_gesture_reactions) {
              return false;
            }
          }
        }
      }
    }
  }

  return true;
}

function interaction_cooldown_timer(var0) {
  if(isDefined(level.interaction_manager)) {
    if(isDefined(var0.allow_interactions) && !var0.allow_interactions) {
      return;
    }

    reconstruct_actor_array();

    foreach(var2 in level.interaction_manager.data["actors"]) {
      if(isDefined(var2)) {
        var2.allow_interactions = 0;
      }
    }

    for(;;) {
      var4 = length(level.player.origin - level.player getEye());
      var5 = var0.origin + anglestoup(var0.angles) * var4;

      if(!level.player scripts\engine\sp\utility::player_looking_at(var5, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    reconstruct_actor_array();
    var0.allow_interactions = 1;

    foreach(var2 in level.interaction_manager.data["actors"]) {
      if(isDefined(var2)) {
        var2.allow_interactions = 1;
      }
    }

    return;
  }
}

function interaction_reboot_timer() {
  self endon("death");

  if(isDefined(level.interaction_manager)) {
    if(isDefined(self.allow_interactions) && !self.allow_interactions) {
      return;
    }

    self.allow_interactions = 0;
    wait 20;

    for(;;) {
      if(isDefined(self.reaction_state) && self.reaction_state != "nag" && self.reaction_state != "busy") {
        goto LOC_0000005e;
      }

      waitframe();
    }

    for(;;) {
      var0 = length(level.player.origin - level.player getEye());
      var1 = self.origin + anglestoup(self.angles) * var0;

      if(!level.player scripts\engine\sp\utility::player_looking_at(var1, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    self.allow_interactions = 1;
    return;
  }
}

function reminder_cooldown_timer(var0) {
  level endon("stop_reminders");
  level endon("reboot_timer");
  level.interaction_manager.can_remind = 0;
  wait var0;
  level.interaction_manager.can_remind = 1;
}

function queue_reminder(var0, var1, var2) {
  if(!isDefined(var0) && isDefined(var1)) {
    var0 = "none";
  }

  if(isDefined(var1)) {
    var0 = var0 + "+" + var1;
  }

  level.interaction_manager.data["reminder_queue"][var0] = self;

  if(isDefined(var2)) {
    self.reminder_animnode = var2;
    return;
  }
}

function queue_reminder_distance_anim(var0, var1, var2, var3) {
  if(isDefined(var0)) {
    var0 = var0 + "+" + var1;
  } else {
    var0 = var1;
  }

  level.interaction_manager.data["reminder_queue"][var0] = self;

  if(isDefined(var2)) {
    self.reminder_animnode = var2;
  }

  self.use_reminder_anim = 1;

  if(isDefined(var3)) {
    self.return_anime = var3;
    return;
  }
}

function queue_reminder_with_reaction(var0, var1, var2, var3) {
  queue_reminder(var0);
  self.use_reminder_reaction = 1;
  self.registered_interaction = var2;
  self.post_reaction_vo_array = var3;
  self.reminder_reaction_pointat = var1;
}

function run_reminders(var0) {
  level endon("stop_reminders");
  thread reminder_queue_cleanup();
  var1 = getarraykeys(level.interaction_manager.data["reminder_queue"]);

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];
    var4 = level.interaction_manager.data["reminder_queue"][var3];

    if(isDefined(var4)) {
      var5 = strtok(var3, "+");
      var6 = var5[0];

      if(isDefined(var4.use_reminder_reaction) && var4.use_reminder_reaction) {
        if(isDefined(var4.registered_interaction) && isDefined(var4.post_reaction_vo_array)) {
          var4 thread scripts\sp\interaction::play_smart_interaction(var4.registered_interaction, var6, var4.post_reaction_vo_array);
        } else if(isDefined(self.post_reaction_func) && isDefined(self.post_reaction_vo)) {
          self thread[[self.post_reaction_func]](undefined, undefined, self.post_reaction_vo);
        } else {
          thread play_gesture_reaction(var4, 85, 50, var6, 1);
        }
      } else if(isDefined(var4.use_reminder_anim) && var4.use_reminder_anim) {
        var7 = undefined;
        var8 = undefined;

        if(var5.size > 1) {
          var7 = var5[1];
          var8 = var6;
        } else {
          var7 = var5[0];
        }

        if(isDefined(var4.reminder_animnode)) {
          thread play_reminder_anim_distance(var4.reminder_animnode, var4, 85, 50, var7, undefined);
        } else {
          thread play_reminder_anim_distance(var4, var4, 85, 50, var7, undefined);
        }
      }
    }
  }

  wait var0;

  while(level.interaction_manager.pause_remind) {
    waitframe();
  }

  var2 = 0;

  while(var2 < var1.size) {
    var3 = var1[var2];
    var4 = level.interaction_manager.data["reminder_queue"][var3];

    if(isDefined(var4)) {
      var5 = strtok(var3, "+");
      var6 = var5[0];

      if(var5.size > 1) {
        if(isDefined(var4.reminder_animnode)) {
          var4.reminder_animnode notify("stop_loop");
          var4.reminder_animnode thread scripts\common\anim::anim_single_solo(var4, var5[1]);
          var9 = getanimlength(var4 scripts\engine\utility::getanim(var5[1]));
          var4 thread scripts\engine\sp\utility::notify_delay("reminder_anim_done", var9);

          if(isDefined(var4.return_anime)) {
            var4.reminder_animnode scripts\engine\utility::delaythread(var9, &scripts\common\anim::anim_loop_solo, var4, var4.return_anime, "stop_loop");
          }
        } else {
          var5 notify("stop_loop");
          var5 thread scripts\common\anim::anim_single_solo(var5, var6[1]);
          var9 = getanimlength(var5 scripts\engine\utility::getanim(var6[1]));
          var5 thread scripts\engine\sp\utility::notify_delay("reminder_anim_done", var9);

          if(isDefined(var5.return_anime)) {
            var5 scripts\engine\utility::delaythread(var9, &scripts\common\anim::anim_loop_solo, var5, var5.return_anime, "stop_loop");
          }
        }

        if(var9 != "none") {
          if(soundexists(var9)) {
            var5 scripts\engine\sp\utility::smart_dialogue(var9);
          }
        }
      } else if(!soundexists(var4)) {
        var5 scripts\engine\sp\utility::smart_dialogue(var4);
      }

      var5 notify("reminder_done");
      var5.reminder_animnode = undefined;
      level.interaction_manager.data["reminder_queue"][var4] = undefined;
      level.interaction_manager.can_remind = 0;
      wait var1;
      level.interaction_manager.can_remind = 1;
    }

    while(level.interaction_manager.pause_remind) {
      waitframe();
    }

    var3++;
  }

  level notify("reminders_done");
}

function reminder_queue_cleanup() {
  level scripts\engine\utility::waittill_any("stop_reminders", "reminders_done");
  level.interaction_manager.data["reminder_queue"] = [];
}

function stop_reminders() {
  level notify("stop_reminders");
  level notify("reminders_done");
  level.interaction_manager.data["reminder_queue"] = [];
  reconstruct_actor_array();

  foreach(var1 in level.interaction_manager.data["actors"]) {
    if(isDefined(var1)) {
      var1.use_reminder_reaction = undefined;
      var1.registered_interaction = undefined;
      var1.post_reaction_vo_array = undefined;
      var1.reminder_reaction_pointat = undefined;
      var1.reminder_animnode = undefined;
      var1.use_reminder_anim = undefined;
    }
  }
}

function pause_reminders() {
  level.interaction_manager.pause_remind = 1;
}

function continue_reminders() {
  level.interaction_manager.pause_remind = 0;
}

function play_state_based_interaction(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = "casual";
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    var2 = "busy";
  }

  var4 = var0 + "_" + "casual";

  if(var2 == "casual" || var2 == "nag") {
    var4 = var0 + "_" + var2;
  }

  self.reaction_state_basename = var0;
  self.reaction_state = var2;

  if(var2 == "nag") {
    thread scripts\sp\interaction::play_interaction_with_states(var4, var1);
    self.allow_interactions = 0;
    self.reaction_state = var2;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var3, 1);
    return;
  } else if(var2 == "busy") {
    thread scripts\sp\interaction::play_interaction_with_states(var4, var1);
    self.allow_interactions = 0;
    self.reaction_state = var2;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var3);
    return;
  }

  thread scripts\sp\interaction::play_interaction_with_states(var4, var1);
}

function stop_state_based_interaction() {
  if(!isDefined(self.is_cheap)) {
    thread scripts\sp\interaction::interaction_end();
  } else {
    self notify("reaction_end");
  }

  self notify("change_reaction_state");
  self.reaction_state = undefined;
  self.allow_interactions = undefined;
  self.reaction_state_basename = undefined;
  thread scripts\engine\sp\utility::gesture_stop(0.7);
}

function set_reaction_state(var0, var1) {
  if(!isDefined(self.reaction_state)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(self.reaction_state_basename)) {
    return;
  }

  self notify("change_reaction_state");
  self notify("stop_reaction_look");

  if(var0 != "nag" && var0 != "busy") {
    self.allow_interactions = 1;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    self.interaction_name = self.reaction_state_basename + "_" + var0;
    self.reaction_state = var0;
    return;
  }

  if(var0 == "nag") {
    self.allow_interactions = 0;
    self.reaction_state = var0;
    thread scripts\engine\sp\utility::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var1, 1);
    return;
  }

  self.allow_interactions = 0;
  self.reaction_state = var0;
  thread scripts\engine\sp\utility::gesture_stop(0.7);
  thread reaction_look_distance_based();
  thread reaction_state_busy_loop(var1);
}

function reaction_state_busy_loop(var0, var1) {
  self endon("change_reaction_state");

  for(;;) {
    thread gesture_reaction_distance_based(var0, var1);
    self waittill("end_gesture_reaction_distance_based");

    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= level.state_interactions[self.interaction_name].scene["trigger_radius"] + 50) {
        break;
      }

      waitframe();
    }
  }
}

function set_all_reaction_states(var0, var1) {
  switch (var0) {
    case "busy":
    case "nag":
    case "alert":
    case "casual":
      foreach(var3 in level.interaction_manager.data["actors"]) {
        thread set_reaction_state(var3, var0);
      }

      break;
  }
}

function reaction_look_distance_based(var0, var1, var2, var3) {
  self endon("death");
  self notify("stop_reaction_look");
  self endon("stop_reaction_look");
  self endon("stop_smart_reaction");
  var4 = 85;

  if(isDefined(var0)) {
    var4 = var0;
  }

  if(!isDefined(var1)) {
    var1 = level.player;
  }

  if(!isDefined(var2)) {
    var2 = 0.7;
  }

  wait var2;

  if(isDefined(self.reaction_state_basename)) {
    if(isDefined(level.state_interactions[self.interaction_name].scene["trigger_radius"])) {
      var4 = level.state_interactions[self.interaction_name].scene["trigger_radius"] * 1.2;
    }
  }

  waitframe();

  if(isDefined(var3) && var3) {
    thread scripts\engine\sp\utility::gesture_follow_lookat(var1, 0.5, 0.5);
  } else {
    thread scripts\engine\sp\utility::gesture_follow_lookat_natural(var1, 0.5, 0.5, var4);
  }

  while(!isDefined(self.is_head_tracking)) {
    wait 0.05;
  }

  thread scripts\engine\sp\utility::gesture_follow_eyes(var1);
  wait randomfloatrange(4, 6);
  var5 = 1;
  var6 = 1;

  for(;;) {
    if(distance2d(self.origin, var1.origin) <= var4) {
      if(!var6) {
        thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_up(0.5);
        thread scripts\engine\sp\utility::gesture_follow_eyes(var1);
        var6 = 1;
      }
    } else if(distance2d(self.origin, var1.origin) >= var4) {
      if(var6) {
        thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_down(1);
        thread scripts\engine\sp\utility::gesture_eyes_stop(0.7);
        var6 = 0;
      }
    }

    waitframe();
  }
}

function gesture_reaction_distance_based(var0, var1) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_reaction_look");
  var2 = 50;

  if(isDefined(self.reaction_state_basename)) {
    if(isDefined(level.state_interactions[self.interaction_name].scene["trigger_radius"])) {
      var2 = level.state_interactions[self.interaction_name].scene["trigger_radius"];
    }
  }

  waittill_gestureconditionsmet(var2);
  thread scripts\engine\sp\utility::gesture_simple("salute");
  var3 = undefined;

  if(isDefined(var1) && var1) {
    switch (var0) {
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
        var4 = level.interaction_manager.data["reminder_vo"][var0][self.gender];
        var5 = level.interaction_manager.data["reminder_vo"][var0]["spent_" + self.gender];

        if(var4.size < 1 && var5.size > 0) {
          level.interaction_manager.data["reminder_vo"][var0][self.gender] = var5;
          level.interaction_manager.data["reminder_vo"][var0]["spent_" + self.gender] = [];
          var4 = level.interaction_manager.data["reminder_vo"][var0][self.gender];
          var5 = level.interaction_manager.data["reminder_vo"][var0]["spent_" + self.gender];
        }

        if(var4.size < 1 && var5.size < 1) {
          var3 = undefined;
        } else {
          var3 = var4[randomint(var4.size)];
          level.interaction_manager.data["reminder_vo"][var0]["spent_" + self.gender] = scripts\engine\utility::array_add(level.interaction_manager.data["reminder_vo"][var0]["spent_" + self.gender], var3);
          level.interaction_manager.data["reminder_vo"][var0][self.gender] = scripts\engine\utility::array_remove(level.interaction_manager.data["reminder_vo"][var0][self.gender], var3);
        }

        break;
    }
  } else {
    var4 = level.interaction_manager.data["busy_vo"][self.gender];
    var5 = level.interaction_manager.data["busy_vo"]["spent_" + self.gender];

    if(var4.size < 1 && var5.size > 0) {
      level.interaction_manager.data["busy_vo"][self.gender] = var5;
      level.interaction_manager.data["busy_vo"]["spent_" + self.gender] = [];
      var4 = level.interaction_manager.data["busy_vo"][self.gender];
      var5 = level.interaction_manager.data["busy_vo"]["spent_" + self.gender];
    }

    if(var4.size < 1 && var5.size < 1) {
      var3 = undefined;
    } else {
      var3 = var4[randomint(var4.size)];
      level.interaction_manager.data["busy_vo"]["spent_" + self.gender] = scripts\engine\utility::array_add(level.interaction_manager.data["busy_vo"]["spent_" + self.gender], var3);
      level.interaction_manager.data["busy_vo"][self.gender] = scripts\engine\utility::array_remove(level.interaction_manager.data["busy_vo"][self.gender], var3);
    }
  }

  if(isDefined(var3)) {
    scripts\engine\sp\utility::smart_dialogue(var3);

    if(isDefined(var1) && var1) {
      thread reminder_cooldown_timer(level);
    }
  }

  self.playing_gesture = 1;
  self notify("end_gesture_reaction_distance_based");
  wait 15;
  self.playing_gesture = 0;
}

function print_reaction_state() {
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

function play_gesture_reaction(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  thread add_actor_to_manager();

  if(isDefined(self.allow_gesture_reactions) && !self.allow_gesture_reactions) {
    self.allow_gesture_reactions = 1;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var0)) {
    var0 = 150;
  }

  if(!isDefined(var1)) {
    var1 = var0 * 0.5;
  }

  if(!isDefined(self.is_head_tracking) || isDefined(self.is_head_tracking) && !self.is_head_tracking) {
    thread reaction_look_distance_based(var0);
  }

  waittill_gestureconditionsmet(var1);
  play_gesture_reaction_anim(var4);
  play_interaction_vo(var2, var3);
}

function waittill_gestureconditionsmet(var0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  var1 = 1;

  for(;;) {
    if(isplayerfocus(var0) && canplaygesture(var0)) {
      var2 = scripts\engine\utility::flatten_vector(anglestoright(self gettagangles("j_head")));
      var3 = scripts\engine\utility::flatten_vector(vectorNormalize(level.player getEye() - self gettagorigin("j_head")));
      var4 = vectordot(var2, var3);

      if(var4 >= 0.8) {
        break;
      }
    }

    waitframe();
  }
}

function isplayerfocus(var0) {
  self endon("death");

  if(isDefined(self.is_cheap)) {
    var1 = self gettagorigin("j_head");
  } else if(isai(self)) {
    var1 = self getEye();
  } else if(isDefined(self.origin)) {
    var1 = self.origin;
  } else {
    return false;
  }

  var2 = level.player getEye();
  var3 = level.player getplayerangles();

  if(distance2d(self.origin, level.player.origin) <= var1) {
    if(scripts\engine\utility::within_fov(var2, var3, var1, cos(25))) {
      return true;
    }
  }

  return false;
}

function canplaygesture(var0) {
  if(!isDefined(self.allow_gesture_reactions) || isDefined(self.allow_gesture_reactions) && self.allow_gesture_reactions) {
    if(!isDefined(self.gesture_reaction_queue)) {
      if(can_play_nearby_gesture(var0)) {
        return true;
      }
    }
  }

  return false;
}

#using_animtree("generic_human");

function play_gesture_reaction_anim(var0) {
  self.playing_gesture = 1;

  if(!isDefined(self.is_cheap)) {
    if(isDefined(var0)) {
      thread scripts\engine\sp\utility::gesture_point(var0);
    } else {
      thread scripts\engine\sp\utility::gesture_simple("salute");
    }
  } else {
    scripts\engine\sp\utility::gesture_custom(%shipcrib_gst_head_salute_01);
  }

  self.playing_gesture = undefined;
}

function play_interaction_vo(var0, var1) {
  if(isDefined(var0)) {
    if(isDefined(var1) && var1) {
      force_reminder_delay(30);
      clear_reminder(var0);
    }

    define_face_anim_if_exists(var0);
    self.is_talking = 1;
    play_smart_dialog_if_exists(var0);
    self.is_talking = undefined;
    return;
  }
}

function define_face_anim_if_exists(var0) {
  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  if(!isDefined(level.scr_face[self.animname])) {
    level.scr_face[self.animname] = [];
  }

  if(isarray(var0)) {
    foreach(var2 in var0) {
      if(!isDefined(level.scr_face[self.animname][var2])) {
        if(isDefined(level.shipcrib_linebook_anims) && isDefined(self.gender)) {
          if(isDefined(level.shipcrib_linebook_anims[self.gender]) && isDefined(level.shipcrib_linebook_anims[self.gender][var2])) {
            level.scr_face[self.animname][var2] = level.shipcrib_linebook_anims[self.gender][var2];
          }
        }
      }
    }

    return;
  }

  if(!isDefined(level.scr_face[self.animname][var0])) {
    if(isDefined(level.shipcrib_linebook_anims) && isDefined(self.gender)) {
      if(isDefined(level.shipcrib_linebook_anims[self.gender]) && isDefined(level.shipcrib_linebook_anims[self.gender][var0])) {
        level.scr_face[self.animname][var0] = level.shipcrib_linebook_anims[self.gender][var0];
        return;
      }

      return;
    }

    return;
  }
}

function play_smart_dialog_if_exists(var0) {
  var1 = undefined;

  if(isarray(var0)) {
    for(var2 = 0; var2 < var0.size; var2++) {
      var3 = var0[var2];

      if(isstring(var3)) {
        define_face_anim_if_exists(var3);

        if(soundexists(var3)) {
          if(issubstr(var3, "plr")) {
            level.player scripts\engine\sp\utility::smart_player_dialogue(var3);
          } else {
            var1 = main_cast_dialog_actor_check(var3);

            if(isDefined(var1)) {
              var1 scripts\engine\sp\utility::smart_dialogue(var3);
            } else {
              scripts\engine\sp\utility::smart_dialogue(var3);
            }
          }
        }

        continue;
      }

      if(isnumber(var3)) {
        wait var3;
      }
    }

    return;
  }

  var3 = var1;

  if(isstring(var3)) {
    define_face_anim_if_exists(var3);

    if(soundexists(var3)) {
      if(issubstr(var3, "plr")) {
        level.player scripts\engine\sp\utility::smart_player_dialogue(var3);
        return;
      }

      var3 = main_cast_dialog_actor_check(var3);

      if(isDefined(var3)) {
        var3 scripts\engine\sp\utility::smart_dialogue(var3);
        return;
      }

      scripts\engine\sp\utility::smart_dialogue(var3);
      return;
    }

    return;
  }
}

function force_reminder_delay(var0) {
  level notify("reboot_timer");
  waitframe();
  thread reminder_cooldown_timer(level);
}

function clear_reminder(var0) {
  if(isDefined(level.interaction_manager)) {
    if(isDefined(level.interaction_manager.data["reminder_queue"])) {
      if(scripts\engine\utility::array_contains(level.interaction_manager.data["reminder_queue"], self)) {
        level.interaction_manager.data["reminder_queue"][var0] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function play_group_gesture_reaction(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    var5 endon("death");
    var5 endon("stop_reaction");
    var5 endon("reaction_end");
    var5 endon("stop_gesture_reaction");
    var5 endon("stop_smart_reaction");
  }

  foreach(var5 in var0) {
    thread add_actor_to_manager();
  }

  thread reaction_group_look_distance_based(var0, var1);
  waittill_group_gestureconditionsmet(var0, var2);
  play_group_gesture_performance(var0, var3, var2);

  foreach(var5 in var0) {
    var10 = randomfloatrange(0, 1);
    var11 = randomfloatrange(0.5, 1.5);
    var5 scripts\engine\utility::delaythread(var10, &scripts\engine\sp\utility::gesture_stop, var11);
  }
}

function waittill_group_gestureconditionsmet(var0, var1) {
  var2 = 1;
  var3 = create_middle_ent(var0);
  var0 = scripts\engine\utility::array_add(var0, var3);

  while(var2) {
    foreach(var5 in var0) {
      if(isplayerfocus(var5, var1)) {
        var2 = 0;
        break;
      }
    }

    waitframe();
  }
}

function create_middle_ent(var0) {
  var1 = 0;
  var2 = (0, 0, 0);

  foreach(var4 in var0) {
    var2 += var4.origin;
    var1++;
  }

  var6 = var2 / var1;
  var7 = scripts\engine\utility::spawn_tag_origin(var6, (0, 0, 0));
  return var7;
}

function play_group_gesture_performance(var0, var1, var2) {
  for(var3 = 0; var3 < var0.size; var3++) {
    if(isDefined(var0[var3]) && isDefined(var1[var3])) {
      play_gesture_reaction_anim(var0[var3]);
      play_interaction_vo(var0[var3], var1[var3]);
    }

    if(!group_isplayerfocus(var2, var0)) {
      break;
    }
  }
}

function group_isplayerfocus(var0, var1) {
  foreach(var3 in var1) {
    if(isplayerfocus(var3, var0)) {
      return true;
    }
  }

  return false;
}

function reaction_group_look_distance_based(var0, var1, var2) {
  foreach(var4 in var0) {
    var4 endon("death");
    var4 endon("stop_reaction");
    var4 endon("reaction_end");
    var4 endon("stop_reaction_look");
    var4 endon("stop_smart_reaction");
  }

  var6 = 85;

  if(isDefined(var1)) {
    var6 = var1;
  }

  if(!isDefined(var2)) {
    var2 = level.player;
  }

  initialize_group_lookat(var0, var2);
  var7 = create_middle_ent(var0);

  for(;;) {
    update_lookat_status(var0, var7, var2, var1);
    update_lookat_weights(var0);
    update_lookat_delays(var0);
    waitframe();
  }
}

function initialize_group_lookat(var0, var1) {
  foreach(var3 in var0) {
    var3 scripts\engine\sp\utility::gesture_follow_lookat(var1, 0.15, 0.7);
    var3.lookat_enabled = 0;
    var3.lookat_delay = 0;
  }

  waitframe();

  foreach(var3 in var0) {
    var3 thread scripts\engine\sp\utility::gesture_eye_dart_loop(var1);
  }
}

function update_lookat_status(var0, var1, var2, var3) {
  if(distance2d(var1.origin, var2.origin) <= var3) {
    enable_lookat(var0);
    return;
  }

  disable_lookat(var0);
}

function enable_lookat(var0) {
  foreach(var2 in var0) {
    if(!var2.lookat_enabled) {
      create_lookat_delay(var2);
    }

    var2.lookat_enabled = 1;
  }
}

function disable_lookat(var0) {
  foreach(var2 in var0) {
    if(var2.lookat_enabled) {
      create_lookat_delay(var2);
    }

    var2.lookat_enabled = 0;
  }
}

function update_lookat_weights(var0) {
  foreach(var2 in var0) {
    if(var2.lookat_delay <= 0) {
      if(var2.lookat_enabled) {
        increase_lookat_weight(var2);
        continue;
      }

      decrease_lookat_weight(var2);
    }
  }
}

function update_lookat_delays(var0) {
  foreach(var2 in var0) {
    if(var2.lookat_delay > 0) {
      var2.lookat_delay -= 0.05;
    }
  }
}

function create_lookat_delay() {
  self.lookat_delay = randomfloatrange(0, 1);
}

function clear_lookat_delay() {
  self.lookat_delay = 0;
}

function increase_lookat_weight() {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_up(0.7);
}

function decrease_lookat_weight() {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_weight_down(0.7);
}

function convertvar_toarray(var0) {
  if(!isarray(var0)) {
    return [var0];
  }

  return var0;
}

function play_gesture_reaction_loop(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var5 = [];

  for(var6 = var2;; var6 = scripts\engine\utility::array_remove(var6, var7)) {
    if(var6.size <= 0) {
      var5 = [];
      var6 = var2;
    }

    var7 = var6[randomint(var6.size)];
    play_gesture_reaction(var0, var1, var7, var3, var4);

    for(;;) {
      if(distance2d(self.origin, level.player.origin) >= var0) {
        break;
      }

      waitframe();
    }

    waitframe();
    var5 = scripts\engine\utility::array_add(var5, var7);
  }
}

function stop_gesture_reaction() {
  self notify("stop_gesture_reaction");
  self notify("stop_reaction_look");
  self notify("stop_gesture_reaction_set");
  self.gesture_reaction_queue = undefined;
  scripts\engine\sp\utility::gesture_stop(0.7);
}

function stop_queued_reaction() {
  self notify("stop_smart_reaction");
  thread scripts\sp\interaction::interaction_end();
}

function queue_gesture_reaction(var0) {
  if(!isDefined(self.gesture_reaction_queue)) {
    self.gesture_reaction_queue = [];
  }

  var1 = var0;

  if(isarray(var0)) {
    var1 = var0[0];
  }

  self.gesture_reaction_queue[var1] = var0;
}

function play_gesture_reaction_set(var0, var1) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction_set");
  self notify("stop_reaction_look");
  scripts\engine\sp\utility::gesture_stop(0.7);
  thread add_actor_to_manager();
  self.allow_gesture_reactions = 1;

  if(!isDefined(var0)) {
    var0 = 150;
  }

  if(!isDefined(var1)) {
    var1 = var0 * 0.5;
  }

  thread reaction_look_distance_based(var0);
  var2 = getarraykeys(self.gesture_reaction_queue);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];
    var5 = self.gesture_reaction_queue[var4];

    for(;;) {
      if(!isDefined(self)) {
        return;
      }

      var6 = length(level.player.origin - level.player getEye());
      var7 = self.origin + anglestoup(self.angles) * var6;

      if(level.player scripts\engine\sp\utility::player_looking_at(var7, 0.75, 1)) {
        if(distance2d(self.origin, level.player.origin) <= var1 && can_play_nearby_gesture(var1)) {
          break;
        }
      }

      waitframe();
    }

    thread scripts\engine\sp\utility::gesture_simple("salute");
    self.allow_gesture_reactions = 0;

    if(isarray(var5)) {
      for(var8 = 0; var8 < var5.size; var8++) {
        var9 = var5[var8];

        if(isstring(var9)) {
          define_face_anim_if_exists(var9);

          if(soundexists(var9)) {
            if(issubstr(var9, "plr")) {
              level.player scripts\engine\sp\utility::smart_player_dialogue(var9);
            } else {
              var10 = main_cast_dialog_actor_check(var9);

              if(isDefined(var10)) {
                var10 scripts\engine\sp\utility::smart_dialogue(var9);
              } else {
                scripts\engine\sp\utility::smart_dialogue(var9);
              }
            }
          }

          continue;
        }

        if(isnumber(var9)) {
          wait var9;
        }
      }
    } else if(soundexists(var5)) {
      define_face_anim_if_exists(var5);
      var10 = main_cast_dialog_actor_check(var5);

      if(isDefined(var10)) {
        var10 scripts\engine\sp\utility::smart_dialogue(var5);
      } else {
        scripts\engine\sp\utility::smart_dialogue(var5);
      }
    }

    self.gesture_reaction_queue[var4] = undefined;
    wait 5;
    self.allow_gesture_reactions = 1;
  }

  self.gesture_reaction_queue = undefined;

  if(isDefined(self.post_reaction_func) && isDefined(self.post_reaction_vo)) {
    self thread[[self.post_reaction_func]](undefined, undefined, self.post_reaction_vo);
    return;
  }
}

function main_cast_dialog_actor_check(var0) {
  var1 = strtok(var0, "_");

  if(scripts\engine\utility::array_contains(var1, "nav") || scripts\engine\utility::array_contains(var1, "gtr")) {
    return level.gator;
  } else if(scripts\engine\utility::array_contains(var1, "slt") || scripts\engine\utility::array_contains(var1, "xo")) {
    return level.salter;
  } else if(scripts\engine\utility::array_contains(var1, "bsw")) {
    if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner") {
      return level.sipes;
    } else {
      return level.sotomura;
    }
  } else if(scripts\engine\utility::array_contains(var1, "cmo")) {
    return level.comms;
  } else if(scripts\engine\utility::array_contains(var1, "dpo")) {
    return level.drop_officer;
  }

  return undefined;
}

function play_reminder_anim_distance(var0, var1, var2, var3, var4, var5) {
  var0 endon("death");

  if(isDefined(var0.pre_reaction_func)) {
    if(isDefined(var0.pre_reaction_params)) {
      if(var0.pre_reaction_params.size == 1) {
        var0[[var0.pre_reaction_func]](var0.pre_reaction_params[0]);
      } else if(var0.pre_reaction_params.size == 2) {
        var0[[var0.pre_reaction_func]](var0.pre_reaction_params[0], var0.pre_reaction_params[1]);
      } else if(var0.pre_reaction_params.size == 3) {
        var0[[var0.pre_reaction_func]](var0.pre_reaction_params[0], var0.pre_reaction_params[1], var0.pre_reaction_params[2]);
      }
    }
  }

  level endon("stop_reminders");
  level endon("reminders_done");
  thread add_actor_to_manager();

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 150;
  }

  if(!isDefined(var2)) {
    var2 = var1 * 0.5;
  }

  if(!isDefined(var0.is_head_tracking) || isDefined(var0.is_head_tracking) && !var0.is_head_tracking) {
    thread reaction_look_distance_based(var0);
  }

  for(;;) {
    jumpiffalse(distance2d(var0.origin, level.player.origin) <= var1 + 25) LOC_00000138;
    waitframe();
  }

  for(;;) {
    if(!isDefined(var0)) {
      return;
    }

    var6 = length(level.player.origin - level.player getEye());
    var7 = var0.origin + anglestoup(var0.angles) * var6;
    jumpiffalse(level.player scripts\engine\sp\utility::player_looking_at(var7, 0.75, 1)) LOC_000001a5;
    waitframe();
  }

  LOC_000001a9:
    self notify("stop_loop");
  thread scripts\common\anim::anim_single_solo(var0, var3);
  var8 = getanimlength(var0 scripts\engine\utility::getanim(var3));
  thread scripts\engine\sp\utility::notify_delay("reminder_anim_done", var8);

  if(isDefined(var0.return_anime)) {
    scripts\engine\utility::delaythread(var8, &scripts\common\anim::anim_loop_solo, var0, var0.return_anime, "stop_loop");
  }

  if(isDefined(var4)) {
    if(var5) {
      level notify("reboot_timer");
      waitframe();
      thread reminder_cooldown_timer(level);

      if(isDefined(level.interaction_manager)) {
        if(isDefined(level.interaction_manager.data["reminder_queue"])) {
          if(scripts\engine\utility::array_contains(level.interaction_manager.data["reminder_queue"], var0)) {
            level.interaction_manager.data["reminder_queue"][var4] = undefined;
          }
        }
      }
    }

    play_smart_dialog_if_exists(var0, var4);
  }

  if(isDefined(var0.post_reaction_func) && !isDefined(var0.post_reaction_vo)) {
    if(isDefined(var0.post_reaction_params)) {
      if(var0.pre_reaction_params.size == 1) {
        var0[[var0.post_reaction_func]](var0.post_reaction_params[0]);
        return;
      }

      if(var0.pre_reaction_params.size == 2) {
        var0[[var0.post_reaction_func]](var0.post_reaction_params[0], var0.post_reaction_params[1]);
        return;
      }

      if(var0.pre_reaction_params.size == 3) {
        var0[[var0.post_reaction_func]](var0.post_reaction_params[0], var0.post_reaction_params[1], var0.post_reaction_params[2]);
        return;
      }

      return;
    }

    return;
  }

  if(isDefined(var0.post_reaction_func) && isDefined(var0.post_reaction_vo)) {
    var0 thread[[var0.post_reaction_func]](undefined, undefined, var0.post_reaction_vo);
    return;
  }
}

function reminder_vo_init() {
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
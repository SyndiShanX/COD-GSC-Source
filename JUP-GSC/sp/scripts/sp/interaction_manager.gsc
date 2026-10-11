/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\interaction_manager.gsc
*************************************************/

#using script_4dac3680f88a01c3;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\interaction;
#using scripts\sp\utility;
#namespace interaction_manager;

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

  foreach(actor in level.interaction_manager.data["actors"]) {
    actor.allow_interactions = 0;
    actor.allow_gesture_reactions = 0;
  }
}

function stop_interaction() {
  if(array_contains(level.interaction_manager.data["actors"], self)) {
    self.allow_interactions = 0;
    self.allow_gesture_reactions = 0;
  }
}

function continue_interactions() {
  reconstruct_actor_array();

  foreach(actor in level.interaction_manager.data["actors"]) {
    actor.allow_interactions = 1;
    actor.allow_gesture_reactions = 1;
  }
}

function continue_interaction() {
  if(array_contains(level.interaction_manager.data["actors"], self)) {
    self.allow_interactions = 1;
    self.allow_gesture_reactions = 1;
  }
}

function trigger_interaction() {
  self endon("death");

  if(isDefined(self.lookat_anims)) {
    self.lookat_anims["interaction_trigger_override"] = 1;
  }
}

function trigger_interaction_multiple(ai_array) {
  self endon("death");

  foreach(ai in ai_array) {
    if(isDefined(ai.lookat_anims)) {
      ai.lookat_anims["interaction_trigger_override"] = 1;
    }
  }
}

function trigger_interaction_common() {
  self endon("death");
  common = self.lookat_anims["common_name"];
  interaction_actors = level.interaction_manager.data["actors"];

  foreach(actor in interaction_actors) {
    if(isDefined(actor.lookat_anims["common_name"])) {
      if(actor.lookat_anims["common_name"] == common) {
        actor.lookat_anims["interaction_trigger_override"] = 1;
      }
    }
  }
}

function reconstruct_actor_array() {
  foreach(guy in level.interaction_manager.data["actors"]) {
    if(!isDefined(guy)) {
      level.interaction_manager.data["actors"] = array_remove(level.interaction_manager.data["actors"], guy);
    }
  }
}

function add_actor_to_manager() {
  if(isDefined(level.interaction_manager)) {
    if(!array_contains(level.interaction_manager.data["actors"], self)) {
      level.interaction_manager.data["actors"] = array_add(level.interaction_manager.data["actors"], self);
    }
  }
}

function remove_actor_from_manager() {
  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = array_remove(level.interaction_manager.data["actors"], self);
  }
}

function can_play_nearby_interaction(check_range) {
  player_pos = level.player.origin;

  if(isDefined(check_range)) {
    active_range = check_range;
  } else {
    active_range = 140;
  }

  if(!isDefined(level.interaction_manager)) {
    print("<dev string:x1c>");

    return true;
  }

  if(isDefined(self.allow_interactions) && !self.allow_interactions) {
    return false;
  }

  reconstruct_actor_array();

  foreach(nearby_actor in level.interaction_manager.data["actors"]) {
    if(isDefined(nearby_actor) && isDefined(self)) {
      if(distance(self.origin, nearby_actor.origin) < active_range) {
        if(hastag(nearby_actor.model, "j_spine4") && level.player math::point_in_fov(nearby_actor gettagorigin("j_spine4"))) {
          if(isDefined(nearby_actor.is_playing_reaction) && nearby_actor.is_playing_reaction) {
            return false;
          }
        }
      }
    }
  }

  return true;
}

function can_play_nearby_gesture(check_range) {
  player_pos = level.player.origin;

  if(isDefined(check_range)) {
    active_range = check_range;
  } else {
    active_range = 140;
  }

  if(!isDefined(level.interaction_manager)) {
    print("<dev string:x1c>");

    return true;
  }

  reconstruct_actor_array();

  foreach(nearby_actor in level.interaction_manager.data["actors"]) {
    if(isDefined(nearby_actor) && isDefined(self)) {
      if(self != nearby_actor) {
        if(distance(self.origin, nearby_actor.origin) < active_range) {
          if(within_fov(level.player getEye(), level.player.angles, nearby_actor gettagorigin("j_spine4"), cos(45))) {
            if(isDefined(nearby_actor.playing_gesture) && nearby_actor.playing_gesture || isDefined(nearby_actor.is_talking) && nearby_actor.is_talking) {
              return false;
            }

            if(isDefined(nearby_actor.allow_gesture_reactions) && !nearby_actor.allow_gesture_reactions) {
              return false;
            }
          }
        }
      }
    }
  }

  return true;
}

function interaction_cooldown_timer(actor_ent) {
  if(isDefined(level.interaction_manager)) {
    if(isDefined(actor_ent.allow_interactions) && !actor_ent.allow_interactions) {
      return;
    }

    reconstruct_actor_array();

    foreach(actor in level.interaction_manager.data["actors"]) {
      if(isDefined(actor)) {
        actor.allow_interactions = 0;
      }
    }

    while(true) {
      offset = length(level.player.origin - level.player getEye());
      lookat = actor_ent.origin + anglestoup(actor_ent.angles) * offset;

      if(!level.player player_looking_at(lookat, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    reconstruct_actor_array();
    actor_ent.allow_interactions = 1;

    foreach(actor in level.interaction_manager.data["actors"]) {
      if(isDefined(actor)) {
        actor.allow_interactions = 1;
      }
    }
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

    while(true) {
      if(isDefined(self.reaction_state) && self.reaction_state != "nag" && self.reaction_state != "busy") {
        break;
      }

      waitframe();
    }

    while(true) {
      offset = length(level.player.origin - level.player getEye());
      lookat = self.origin + anglestoup(self.angles) * offset;

      if(!level.player player_looking_at(lookat, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    self.allow_interactions = 1;
  }
}

function reminder_cooldown_timer(interval_time) {
  level endon("stop_reminders");
  level endon("reboot_timer");
  level.interaction_manager.can_remind = 0;
  wait interval_time;
  level.interaction_manager.can_remind = 1;
}

function queue_reminder(dialog_alias, optional_anime, optional_animnode) {
  if(!isDefined(dialog_alias) && isDefined(optional_anime)) {
    dialog_alias = "none";
  }

  if(isDefined(optional_anime)) {
    dialog_alias = dialog_alias + "+" + optional_anime;
  }

  level.interaction_manager.data["reminder_queue"][dialog_alias] = self;

  if(isDefined(optional_animnode)) {
    self.reminder_animnode = optional_animnode;
  }
}

function queue_reminder_distance_anim(dialog_alias, anime, optional_animnode, return_anime) {
  if(isDefined(dialog_alias)) {
    dialog_alias = dialog_alias + "+" + anime;
  } else {
    dialog_alias = anime;
  }

  level.interaction_manager.data["reminder_queue"][dialog_alias] = self;

  if(isDefined(optional_animnode)) {
    self.reminder_animnode = optional_animnode;
  }

  self.use_reminder_anim = 1;

  if(isDefined(return_anime)) {
    self.return_anime = return_anime;
  }
}

function queue_reminder_with_reaction(dialog_alias, var_deb57c2beb8db767, registered_interaction, post_reaction_vo_array) {
  queue_reminder(dialog_alias);
  self.use_reminder_reaction = 1;
  self.registered_interaction = registered_interaction;
  self.post_reaction_vo_array = post_reaction_vo_array;
  self.reminder_reaction_pointat = var_deb57c2beb8db767;
}

function run_reminders(interval_time) {
  level endon("stop_reminders");
  level thread reminder_queue_cleanup();
  keys = getarraykeys(level.interaction_manager.data["reminder_queue"]);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    actor = level.interaction_manager.data["reminder_queue"][key];

    if(isDefined(actor)) {
      key_tok = strtok(key, "+");
      dialog_line = key_tok[0];

      if(isDefined(actor.use_reminder_reaction) && actor.use_reminder_reaction) {
        if(isDefined(actor.registered_interaction) && isDefined(actor.post_reaction_vo_array)) {
          actor thread scripts\sp\interaction::play_smart_interaction(actor.registered_interaction, dialog_line, actor.post_reaction_vo_array);
        } else if(isDefined(self.post_reaction_func) && isDefined(self.post_reaction_vo)) {
          self thread[[self.post_reaction_func]](undefined, undefined, self.post_reaction_vo);
        } else {
          actor thread play_gesture_reaction(85, 50, dialog_line, 1, actor.reminder_reaction_pointat);
        }

        continue;
      }

      if(isDefined(actor.use_reminder_anim) && actor.use_reminder_anim) {
        anime = undefined;
        vo_line = undefined;

        if(key_tok.size > 1) {
          anime = key_tok[1];
          vo_line = dialog_line;
        } else {
          anime = key_tok[0];
        }

        if(isDefined(actor.reminder_animnode)) {
          actor.reminder_animnode thread play_reminder_anim_distance(actor, 85, 50, anime, undefined, 1);
          continue;
        }

        actor thread play_reminder_anim_distance(actor, 85, 50, anime, undefined, 1);
      }
    }
  }

  wait interval_time;

  while(level.interaction_manager.pause_remind) {
    waitframe();
  }

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    actor = level.interaction_manager.data["reminder_queue"][key];

    if(isDefined(actor)) {
      key_tok = strtok(key, "+");
      dialog_line = key_tok[0];

      if(key_tok.size > 1) {
        if(isDefined(actor.reminder_animnode)) {
          actor.reminder_animnode notify("stop_loop");
          actor.reminder_animnode thread anim_single_solo(actor, key_tok[1]);
          wait_time = getanimlength(actor getanim(key_tok[1]));
          actor thread notify_delay("reminder_anim_done", wait_time);

          if(isDefined(actor.return_anime)) {
            actor.reminder_animnode delaythread(wait_time, &anim_loop_solo, actor, actor.return_anime, "stop_loop");
          }
        } else {
          actor notify("stop_loop");
          actor thread anim_single_solo(actor, key_tok[1]);
          wait_time = getanimlength(actor getanim(key_tok[1]));
          actor thread notify_delay("reminder_anim_done", wait_time);

          if(isDefined(actor.return_anime)) {
            actor delaythread(wait_time, &anim_loop_solo, actor, actor.return_anime, "stop_loop");
          }
        }

        if(dialog_line != "none") {
          if(soundexists(dialog_line)) {
            actor smart_dialogue(dialog_line);
          }
        }
      } else if(!soundexists(key)) {
        actor smart_dialogue(key);
      }

      actor notify("reminder_done");
      actor.reminder_animnode = undefined;
      level.interaction_manager.data["reminder_queue"][key] = undefined;
      level.interaction_manager.can_remind = 0;
      wait interval_time;
      level.interaction_manager.can_remind = 1;
    }

    while(level.interaction_manager.pause_remind) {
      waitframe();
    }
  }

  level notify("reminders_done");
}

function reminder_queue_cleanup() {
  level waittill_any("stop_reminders", "reminders_done");
  level.interaction_manager.data["reminder_queue"] = [];
}

function stop_reminders() {
  level notify("stop_reminders");
  level notify("reminders_done");
  level.interaction_manager.data["reminder_queue"] = [];
  reconstruct_actor_array();

  foreach(guy in level.interaction_manager.data["actors"]) {
    if(isDefined(guy)) {
      guy.use_reminder_reaction = undefined;
      guy.registered_interaction = undefined;
      guy.post_reaction_vo_array = undefined;
      guy.reminder_reaction_pointat = undefined;
      guy.reminder_animnode = undefined;
      guy.use_reminder_anim = undefined;
    }
  }
}

function pause_reminders() {
  level.interaction_manager.pause_remind = 1;
}

function continue_reminders() {
  level.interaction_manager.pause_remind = 0;
}

function play_state_based_interaction(reaction_name, optional_scripted_struct, starting_state, var_1ac1f24f36ef97c6) {
  if(!isDefined(starting_state)) {
    starting_state = "casual";
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    starting_state = "busy";
  }

  starting_reaction = reaction_name + "_" + "casual";

  if(starting_state == "casual" || starting_state == "nag") {
    starting_reaction = reaction_name + "_" + starting_state;
  }

  self.reaction_state_basename = reaction_name;
  self.reaction_state = starting_state;

  if(starting_state == "nag") {
    thread scripts\sp\interaction::play_interaction_with_states(starting_reaction, optional_scripted_struct);
    self.allow_interactions = 0;
    self.reaction_state = starting_state;
    thread gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_1ac1f24f36ef97c6, 1);
    return;
  } else if(starting_state == "busy") {
    thread scripts\sp\interaction::play_interaction_with_states(starting_reaction, optional_scripted_struct);
    self.allow_interactions = 0;
    self.reaction_state = starting_state;
    thread gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_1ac1f24f36ef97c6);
    return;
  }

  thread scripts\sp\interaction::play_interaction_with_states(starting_reaction, optional_scripted_struct);
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
  thread gesture_stop(0.7);
}

function set_reaction_state(reaction_state, var_1ac1f24f36ef97c6) {
  if(!isDefined(self.reaction_state)) {
    return;
  }

  if(!isDefined(reaction_state)) {
    assertmsg("reaction state to change to was not defined");
    return;
  }

  if(!isDefined(self.reaction_state_basename)) {
    assertmsg("There is not state based reaction running on this actor");
    return;
  }

  self notify("change_reaction_state");
  self notify("stop_reaction_look");

  if(reaction_state != "nag" && reaction_state != "busy") {
    self.allow_interactions = 1;
    thread gesture_stop(0.7);
    self.interaction_name = self.reaction_state_basename + "_" + reaction_state;
    self.reaction_state = reaction_state;
    return;
  }

  if(reaction_state == "nag") {
    self.allow_interactions = 0;
    self.reaction_state = reaction_state;
    thread gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_1ac1f24f36ef97c6, 1);
    return;
  }

  self.allow_interactions = 0;
  self.reaction_state = reaction_state;
  thread gesture_stop(0.7);
  thread reaction_look_distance_based();
  thread reaction_state_busy_loop(var_1ac1f24f36ef97c6);
}

function reaction_state_busy_loop(var_1ac1f24f36ef97c6, var_aceeb014451bd535) {
  self endon("change_reaction_state");

  while(true) {
    thread gesture_reaction_distance_based(var_1ac1f24f36ef97c6, var_aceeb014451bd535);
    self waittill("end_gesture_reaction_distance_based");

    while(true) {
      if(distance2d(self.origin, level.player.origin) >= level.state_interactions[self.interaction_name].scene["trigger_radius"] + 50) {
        break;
      }

      waitframe();
    }
  }
}

function set_all_reaction_states(state, var_db1cfdabe22af09a) {
  switch (state) {
    case #"hash_186d745a92c317d9":
    case #"hash_4075266c2bfb0d95":
    case #"hash_46fdaf04e9be63e4":
    case #"hash_ab31742ee80771e0":
      foreach(actor in level.interaction_manager.data["actors"]) {
        actor thread set_reaction_state(state, var_db1cfdabe22af09a);
      }

      break;
  }
}

function reaction_look_distance_based(check_distance, look_target, look_wait, var_5cd6b577cb6e78a7) {
  self endon("death");
  self notify("stop_reaction_look");
  self endon("stop_reaction_look");
  self endon("stop_smart_reaction");
  distance_value = 85;

  if(isDefined(check_distance)) {
    distance_value = check_distance;
  }

  if(!isDefined(look_target)) {
    look_target = level.player;
  }

  if(!isDefined(look_wait)) {
    look_wait = 0.7;
  }

  wait look_wait;

  if(isDefined(self.reaction_state_basename)) {
    if(isDefined(level.state_interactions[self.interaction_name].scene["trigger_radius"])) {
      distance_value = level.state_interactions[self.interaction_name].scene["trigger_radius"] * 1.2;
    }
  }

  waitframe();

  if(isDefined(var_5cd6b577cb6e78a7) && var_5cd6b577cb6e78a7) {
    thread gesture_follow_lookat(look_target, 0.5, 0.5);
  } else {
    thread gesture_follow_lookat_natural(look_target, 0.5, 0.5, distance_value);
  }

  while(!isDefined(self.is_head_tracking)) {
    wait 0.05;
  }

  thread gesture_follow_eyes(look_target);
  wait randomfloatrange(4, 6);
  eyes_enabled = 1;
  blend_up = 1;

  while(true) {
    if(distance2d(self.origin, look_target.origin) <= distance_value) {
      if(!blend_up) {
        thread namespace_3123a12d1da4993::ai_gesture_lookat_weight_up(0.5);
        thread gesture_follow_eyes(look_target);
        blend_up = 1;
      }
    } else if(distance2d(self.origin, look_target.origin) >= distance_value) {
      if(blend_up) {
        thread namespace_3123a12d1da4993::ai_gesture_lookat_weight_down(1);
        thread gesture_eyes_stop(0.7);
        blend_up = 0;
      }
    }

    waitframe();
  }
}

function gesture_reaction_distance_based(var_1ac1f24f36ef97c6, var_aceeb014451bd535) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_reaction_look");
  distance_value = 50;

  if(isDefined(self.reaction_state_basename)) {
    if(isDefined(level.state_interactions[self.interaction_name].scene["trigger_radius"])) {
      distance_value = level.state_interactions[self.interaction_name].scene["trigger_radius"];
    }
  }

  waittill_gestureconditionsmet(distance_value);
  thread gesture_simple("salute");
  var_765485f31a421aff = undefined;

  if(isDefined(var_aceeb014451bd535) && var_aceeb014451bd535) {
    switch (var_1ac1f24f36ef97c6) {
      case #"hash_27be96c0acdf881":
      case #"hash_124cf75fc29ad2a8":
      case #"hash_1a9ef56c17f3b186":
      case #"hash_33c1b71e7fba3091":
      case #"hash_413b1823d39eeba7":
      case #"hash_8b0d967838e55b97":
      case #"hash_b3a61cd5ed5d2e56":
      case #"hash_bd09950854d77c70":
      case #"hash_d6d8c4e1e1f333a7":
      case #"hash_e864ec163d1f06ab":
        line_array = level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6][self.gender];
        spent_array = level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6]["spent_" + self.gender];

        if(line_array.size < 1 && spent_array.size > 0) {
          level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6][self.gender] = spent_array;
          level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6]["spent_" + self.gender] = [];
          line_array = level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6][self.gender];
          spent_array = level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6]["spent_" + self.gender];
        }

        if(line_array.size < 1 && spent_array.size < 1) {
          var_765485f31a421aff = undefined;
        } else {
          var_765485f31a421aff = line_array[randomint(line_array.size)];
          level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6]["spent_" + self.gender] = array_add(level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6]["spent_" + self.gender], var_765485f31a421aff);
          level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6][self.gender] = array_remove(level.interaction_manager.data["reminder_vo"][var_1ac1f24f36ef97c6][self.gender], var_765485f31a421aff);
        }

        break;
    }
  } else {
    line_array = level.interaction_manager.data["busy_vo"][self.gender];
    spent_array = level.interaction_manager.data["busy_vo"]["spent_" + self.gender];

    if(line_array.size < 1 && spent_array.size > 0) {
      level.interaction_manager.data["busy_vo"][self.gender] = spent_array;
      level.interaction_manager.data["busy_vo"]["spent_" + self.gender] = [];
      line_array = level.interaction_manager.data["busy_vo"][self.gender];
      spent_array = level.interaction_manager.data["busy_vo"]["spent_" + self.gender];
    }

    if(line_array.size < 1 && spent_array.size < 1) {
      var_765485f31a421aff = undefined;
    } else {
      var_765485f31a421aff = line_array[randomint(line_array.size)];
      level.interaction_manager.data["busy_vo"]["spent_" + self.gender] = array_add(level.interaction_manager.data["busy_vo"]["spent_" + self.gender], var_765485f31a421aff);
      level.interaction_manager.data["busy_vo"][self.gender] = array_remove(level.interaction_manager.data["busy_vo"][self.gender], var_765485f31a421aff);
    }
  }

  if(isDefined(var_765485f31a421aff)) {
    smart_dialogue(var_765485f31a421aff);

    if(isDefined(var_aceeb014451bd535) && var_aceeb014451bd535) {
      level thread reminder_cooldown_timer(90);
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

  while(true) {
    print3d(self.origin + anglestoup(self.angles) * 70, self.reaction_state, (0.5, 1, 0), 1, 0.25, 1);

    print3d(self.origin + anglestoup(self.angles) * 75, "<dev string:x8e>" + self.allow_interactions, (0.5, 1, 0), 1, 0.25, 1);

    if(isDefined(self.allow_gesture_reactions)) {
      print3d(self.origin + anglestoup(self.angles) * 80, "<dev string:xa2>" + self.allow_gesture_reactions, (0.5, 1, 0), 1, 0.25, 1);
    }

    if(isDefined(self.gender)) {
      print3d(self.origin + anglestoup(self.angles) * 83, "<dev string:xb2>" + self.gender, (0.5, 1, 0), 1, 0.25, 1);
    }

    if(isDefined(self.animname)) {
      print3d(self.origin + anglestoup(self.angles) * 86, "<dev string:xb2>" + self.animname, (0.5, 1, 0), 1, 0.25, 1);
    }

    waitframe();
  }
}

function play_gesture_reaction(lookat_distance, reaction_distance, var_f0dd62735e42c1e2, is_reminder, pointat_target) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  thread add_actor_to_manager();

  if(isDefined(self.allow_gesture_reactions) && !self.allow_gesture_reactions) {
    self.allow_gesture_reactions = 1;
  }

  if(!isDefined(is_reminder)) {
    is_reminder = 0;
  }

  if(!isDefined(lookat_distance)) {
    lookat_distance = 150;
  }

  if(!isDefined(reaction_distance)) {
    reaction_distance = lookat_distance * 0.5;
  }

  if(!isDefined(self.is_head_tracking) || isDefined(self.is_head_tracking) && !self.is_head_tracking) {
    thread reaction_look_distance_based(lookat_distance);
  }

  waittill_gestureconditionsmet(reaction_distance);
  play_gesture_reaction_anim(pointat_target);
  play_interaction_vo(var_f0dd62735e42c1e2, is_reminder);
}

function waittill_gestureconditionsmet(reaction_distance) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  checkingconditions = 1;

  while(true) {
    if(isplayerfocus(reaction_distance) && canplaygesture(reaction_distance)) {
      head_vec = flatten_vector(anglestoright(self gettagangles("j_head")));
      vec_to_player = flatten_vector(vectorNormalize(level.player getEye() - self gettagorigin("j_head")));
      dot = vectordot(head_vec, vec_to_player);

      if(dot >= 0.8) {
        break;
      }
    }

    waitframe();
  }
}

function isplayerfocus(required_dist) {
  self endon("death");

  if(isDefined(self.is_cheap)) {
    self_eye = self gettagorigin("j_head");
  } else if(isai(self)) {
    self_eye = self getEye();
  } else if(isDefined(self.origin)) {
    self_eye = self.origin;
  } else {
    assertmsg("You called isPlayerFocus on an object without an eye, j_head, or origin.");
    println("<dev string:xbb>");
    return false;
  }

  var_efb844234ac72b75 = level.player getEye();
  var_42a02d3c4bcf914b = level.player getplayerangles();

  if(distance2d(self.origin, level.player.origin) <= required_dist) {
    if(within_fov(var_efb844234ac72b75, var_42a02d3c4bcf914b, self_eye, cos(25))) {
      return true;
    }
  }

  return false;
}

function canplaygesture(check_range) {
  if(!isDefined(self.allow_gesture_reactions) || isDefined(self.allow_gesture_reactions) && self.allow_gesture_reactions) {
    if(!isDefined(self.gesture_reaction_queue)) {
      if(can_play_nearby_gesture(check_range)) {
        return true;
      }
    }
  }

  return false;
}

#using_animtree("generic_human");

function play_gesture_reaction_anim(pointat_target) {
  self.playing_gesture = 1;

  if(!isDefined(self.is_cheap)) {
    if(isDefined(pointat_target)) {
      thread gesture_point(pointat_target);
    } else {
      thread gesture_simple("salute");
    }
  } else {
    gesture_custom(%shipcrib_gst_head_salute_01);
  }

  self.playing_gesture = undefined;
}

function play_interaction_vo(vo_line, is_reminder) {
  if(isDefined(vo_line)) {
    if(isDefined(is_reminder) && is_reminder) {
      force_reminder_delay(30);
      clear_reminder(vo_line);
    }

    define_face_anim_if_exists(vo_line);
    self.is_talking = 1;
    play_smart_dialog_if_exists(vo_line);
    self.is_talking = undefined;
  }
}

function define_face_anim_if_exists(vo_line) {
  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  if(!isDefined(level.scr_face[self.animname])) {
    level.scr_face[self.animname] = [];
  }

  if(isarray(vo_line)) {
    foreach(dialog in vo_line) {
      if(!isDefined(level.scr_face[self.animname][dialog])) {
        if(isDefined(level.shipcrib_linebook_anims) && isDefined(self.gender)) {
          if(isDefined(level.shipcrib_linebook_anims[self.gender]) && isDefined(level.shipcrib_linebook_anims[self.gender][dialog])) {
            level.scr_face[self.animname][dialog] = level.shipcrib_linebook_anims[self.gender][dialog];
          }
        }
      }
    }

    return;
  }

  if(!isDefined(level.scr_face[self.animname][vo_line])) {
    if(isDefined(level.shipcrib_linebook_anims) && isDefined(self.gender)) {
      if(isDefined(level.shipcrib_linebook_anims[self.gender]) && isDefined(level.shipcrib_linebook_anims[self.gender][vo_line])) {
        level.scr_face[self.animname][vo_line] = level.shipcrib_linebook_anims[self.gender][vo_line];
      }
    }
  }
}

function play_smart_dialog_if_exists(vo_line) {
  var_409b07aab3875801 = undefined;

  if(isarray(vo_line)) {
    for(index = 0; index < vo_line.size; index++) {
      action = vo_line[index];

      if(isstring(action)) {
        define_face_anim_if_exists(action);

        if(soundexists(action)) {
          if(issubstr(action, "plr")) {
            level.player smart_player_dialogue(action);
          } else {
            var_409b07aab3875801 = main_cast_dialog_actor_check(action);

            if(isDefined(var_409b07aab3875801)) {
              var_409b07aab3875801 smart_dialogue(action);
            } else {
              smart_dialogue(action);
            }
          }
        }

        continue;
      }

      if(isnumber(action)) {
        wait action;
      }
    }

    return;
  }

  action = vo_line;

  if(isstring(action)) {
    define_face_anim_if_exists(action);

    if(soundexists(action)) {
      if(issubstr(action, "plr")) {
        level.player smart_player_dialogue(action);
        return;
      }

      var_409b07aab3875801 = main_cast_dialog_actor_check(action);

      if(isDefined(var_409b07aab3875801)) {
        var_409b07aab3875801 smart_dialogue(action);
        return;
      }

      smart_dialogue(action);
    }
  }
}

function force_reminder_delay(delay_time) {
  level notify("reboot_timer");
  waitframe();
  level thread reminder_cooldown_timer(delay_time);
}

function clear_reminder(reminder_alias) {
  if(isDefined(level.interaction_manager)) {
    if(isDefined(level.interaction_manager.data["reminder_queue"])) {
      if(array_contains(level.interaction_manager.data["reminder_queue"], self)) {
        level.interaction_manager.data["reminder_queue"][reminder_alias] = undefined;
      }
    }
  }
}

function play_group_gesture_reaction(actor_array, lookat_distance, reaction_distance, var_7551dea02427d9cd) {
  foreach(actor in actor_array) {
    actor endon("death");
    actor endon("stop_reaction");
    actor endon("reaction_end");
    actor endon("stop_gesture_reaction");
    actor endon("stop_smart_reaction");
  }

  foreach(actor in actor_array) {
    actor thread add_actor_to_manager();
  }

  thread reaction_group_look_distance_based(actor_array, lookat_distance);
  waittill_group_gestureconditionsmet(actor_array, reaction_distance);
  play_group_gesture_performance(actor_array, var_7551dea02427d9cd, reaction_distance);

  foreach(actor in actor_array) {
    random_f1 = randomfloatrange(0, 1);
    random_f2 = randomfloatrange(0.5, 1.5);
    actor delaythread(random_f1, &gesture_stop, random_f2);
  }
}

function waittill_group_gestureconditionsmet(actor_array, minimum_distance) {
  checkingconditions = 1;
  mid_point = create_middle_ent(actor_array);
  actor_array = array_add(actor_array, mid_point);

  while(checkingconditions) {
    foreach(entry in actor_array) {
      if(entry isplayerfocus(minimum_distance)) {
        checkingconditions = 0;
        break;
      }
    }

    waitframe();
  }
}

function create_middle_ent(ent_array) {
  counter = 0;
  sum_vector = (0, 0, 0);

  foreach(entry in ent_array) {
    sum_vector += entry.origin;
    counter++;
  }

  midpoint = sum_vector / counter;
  middle_ent = spawn_tag_origin(midpoint, (0, 0, 0));
  return middle_ent;
}

function play_group_gesture_performance(actor_array, vo_array, minimum_distance) {
  for(i = 0; i < actor_array.size; i++) {
    if(isDefined(actor_array[i]) && isDefined(vo_array[i])) {
      actor_array[i] play_gesture_reaction_anim();
      actor_array[i] play_interaction_vo(vo_array[i]);
    }

    if(!group_isplayerfocus(minimum_distance, actor_array)) {
      break;
    }
  }
}

function group_isplayerfocus(minimum_distance, ent_array) {
  foreach(entry in ent_array) {
    if(entry isplayerfocus(minimum_distance)) {
      return true;
    }
  }

  return false;
}

function reaction_group_look_distance_based(actor_array, check_distance, look_target) {
  foreach(actor in actor_array) {
    actor endon("death");
    actor endon("stop_reaction");
    actor endon("reaction_end");
    actor endon("stop_reaction_look");
    actor endon("stop_smart_reaction");
  }

  distance_value = 85;

  if(isDefined(check_distance)) {
    distance_value = check_distance;
  }

  if(!isDefined(look_target)) {
    look_target = level.player;
  }

  initialize_group_lookat(actor_array, look_target);
  look_source = create_middle_ent(actor_array);

  while(true) {
    update_lookat_status(actor_array, look_source, look_target, check_distance);
    update_lookat_weights(actor_array);
    update_lookat_delays(actor_array);
    waitframe();
  }
}

function initialize_group_lookat(actor_array, look_target) {
  foreach(actor in actor_array) {
    actor gesture_follow_lookat(look_target, 0.15, 0.7);
    actor.lookat_enabled = 0;
    actor.lookat_delay = 0;
  }

  waitframe();

  foreach(actor in actor_array) {
    actor thread gesture_eye_dart_loop(look_target);
  }
}

function update_lookat_status(actor_array, lookat_source, lookat_target, dist) {
  if(distance2d(lookat_source.origin, lookat_target.origin) <= dist) {
    enable_lookat(actor_array);
    return;
  }

  disable_lookat(actor_array);
}

function enable_lookat(actor_array) {
  foreach(actor in actor_array) {
    if(!actor.lookat_enabled) {
      actor create_lookat_delay();
    }

    actor.lookat_enabled = 1;
  }
}

function disable_lookat(actor_array) {
  foreach(actor in actor_array) {
    if(actor.lookat_enabled) {
      actor create_lookat_delay();
    }

    actor.lookat_enabled = 0;
  }
}

function update_lookat_weights(actor_array) {
  foreach(actor in actor_array) {
    if(actor.lookat_delay <= 0) {
      if(actor.lookat_enabled) {
        actor increase_lookat_weight();
        continue;
      }

      actor decrease_lookat_weight();
    }
  }
}

function update_lookat_delays(actor_array) {
  foreach(actor in actor_array) {
    if(actor.lookat_delay > 0) {
      actor.lookat_delay -= 0.05;
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
  thread namespace_3123a12d1da4993::ai_gesture_lookat_weight_up(0.7);
}

function decrease_lookat_weight() {
  thread namespace_3123a12d1da4993::ai_gesture_lookat_weight_down(0.7);
}

function convertvar_toarray(var_e1fdb9e31a9005b0) {
  if(!isarray(var_e1fdb9e31a9005b0)) {
    return [var_e1fdb9e31a9005b0];
  }

  return var_e1fdb9e31a9005b0;
}

function play_gesture_reaction_loop(lookat_distance, reaction_distance, reaction_vo_array, is_reminder, pointat_target) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_3eb3d32007b7b5 = [];

  for(vo_array = reaction_vo_array; true; vo_array = array_remove(vo_array, random_line)) {
    if(vo_array.size <= 0) {
      var_3eb3d32007b7b5 = [];
      vo_array = reaction_vo_array;
    }

    random_line = vo_array[randomint(vo_array.size)];
    play_gesture_reaction(lookat_distance, reaction_distance, random_line, is_reminder, pointat_target);

    while(true) {
      if(distance2d(self.origin, level.player.origin) >= lookat_distance) {
        break;
      }

      waitframe();
    }

    waitframe();
    var_3eb3d32007b7b5 = array_add(var_3eb3d32007b7b5, random_line);
  }
}

function stop_gesture_reaction() {
  self notify("stop_gesture_reaction");
  self notify("stop_reaction_look");
  self notify("stop_gesture_reaction_set");
  self.gesture_reaction_queue = undefined;
  gesture_stop(0.7);
}

function stop_queued_reaction() {
  self notify("stop_smart_reaction");
  thread scripts\sp\interaction::interaction_end();
}

function queue_gesture_reaction(dialog_alias) {
  if(!isDefined(self.gesture_reaction_queue)) {
    self.gesture_reaction_queue = [];
  }

  alias_key = dialog_alias;

  if(isarray(dialog_alias)) {
    alias_key = dialog_alias[0];
  }

  self.gesture_reaction_queue[alias_key] = dialog_alias;
}

function play_gesture_reaction_set(lookat_distance, reaction_distance) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction_set");
  self notify("stop_reaction_look");
  gesture_stop(0.7);
  thread add_actor_to_manager();
  self.allow_gesture_reactions = 1;

  if(!isDefined(lookat_distance)) {
    lookat_distance = 150;
  }

  if(!isDefined(reaction_distance)) {
    reaction_distance = lookat_distance * 0.5;
  }

  thread reaction_look_distance_based(lookat_distance);
  keys = getarraykeys(self.gesture_reaction_queue);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    dialog_set = self.gesture_reaction_queue[key];

    while(true) {
      if(!isDefined(self)) {
        return;
      }

      offset = length(level.player.origin - level.player getEye());
      lookat = self.origin + anglestoup(self.angles) * offset;

      if(level.player player_looking_at(lookat, 0.75, 1)) {
        if(distance2d(self.origin, level.player.origin) <= reaction_distance && can_play_nearby_gesture(reaction_distance)) {
          break;
        }
      }

      waitframe();
    }

    thread gesture_simple("salute");
    self.allow_gesture_reactions = 0;

    if(isarray(dialog_set)) {
      for(index = 0; index < dialog_set.size; index++) {
        action = dialog_set[index];

        if(isstring(action)) {
          define_face_anim_if_exists(action);

          if(soundexists(action)) {
            if(issubstr(action, "plr")) {
              level.player smart_player_dialogue(action);
            } else {
              var_409b07aab3875801 = main_cast_dialog_actor_check(action);

              if(isDefined(var_409b07aab3875801)) {
                var_409b07aab3875801 smart_dialogue(action);
              } else {
                smart_dialogue(action);
              }
            }
          }

          continue;
        }

        if(isnumber(action)) {
          wait action;
        }
      }
    } else if(soundexists(dialog_set)) {
      define_face_anim_if_exists(dialog_set);
      var_409b07aab3875801 = main_cast_dialog_actor_check(dialog_set);

      if(isDefined(var_409b07aab3875801)) {
        var_409b07aab3875801 smart_dialogue(dialog_set);
      } else {
        smart_dialogue(dialog_set);
      }
    }

    self.gesture_reaction_queue[key] = undefined;
    wait 5;
    self.allow_gesture_reactions = 1;
  }

  self.gesture_reaction_queue = undefined;

  if(isDefined(self.post_reaction_func) && isDefined(self.post_reaction_vo)) {
    self thread[[self.post_reaction_func]](undefined, undefined, self.post_reaction_vo);
  }
}

function main_cast_dialog_actor_check(dialog_line) {
  var_7d9f09842d048f33 = strtok(dialog_line, "_");

  if(array_contains(var_7d9f09842d048f33, "nav") || array_contains(var_7d9f09842d048f33, "gtr")) {
    return level.gator;
  } else if(array_contains(var_7d9f09842d048f33, "slt") || array_contains(var_7d9f09842d048f33, "xo")) {
    return level.salter;
  } else if(array_contains(var_7d9f09842d048f33, "bsw")) {
    if(level.script == "shipcrib_rogue" || level.script == "shipcrib_prisoner") {
      return level.sipes;
    } else {
      return level.sotomura;
    }
  } else if(array_contains(var_7d9f09842d048f33, "cmo")) {
    return level.comms;
  } else if(array_contains(var_7d9f09842d048f33, "dpo")) {
    return level.drop_officer;
  }

  return undefined;
}

function play_reminder_anim_distance(actor, lookat_distance, reaction_distance, anime, var_f0dd62735e42c1e2, is_reminder) {
  actor endon("death");

  if(isDefined(actor.pre_reaction_func)) {
    if(isDefined(actor.pre_reaction_params)) {
      if(actor.pre_reaction_params.size == 1) {
        actor[[actor.pre_reaction_func]](actor.pre_reaction_params[0]);
      } else if(actor.pre_reaction_params.size == 2) {
        actor[[actor.pre_reaction_func]](actor.pre_reaction_params[0], actor.pre_reaction_params[1]);
      } else if(actor.pre_reaction_params.size == 3) {
        actor[[actor.pre_reaction_func]](actor.pre_reaction_params[0], actor.pre_reaction_params[1], actor.pre_reaction_params[2]);
      }
    }
  }

  level endon("stop_reminders");
  level endon("reminders_done");
  actor thread add_actor_to_manager();

  if(!isDefined(is_reminder)) {
    is_reminder = 0;
  }

  if(!isDefined(lookat_distance)) {
    lookat_distance = 150;
  }

  if(!isDefined(reaction_distance)) {
    reaction_distance = lookat_distance * 0.5;
  }

  if(!isDefined(actor.is_head_tracking) || isDefined(actor.is_head_tracking) && !actor.is_head_tracking) {
    actor thread reaction_look_distance_based(lookat_distance);
  }

  while(distance2d(actor.origin, level.player.origin) <= lookat_distance + 25) {
    waitframe();
  }

  while(true) {
    if(!isDefined(actor)) {
      return;
    }

    offset = length(level.player.origin - level.player getEye());
    lookat = actor.origin + anglestoup(actor.angles) * offset;

    if(level.player player_looking_at(lookat, 0.75, 1)) {
      if(distance2d(actor.origin, level.player.origin) <= reaction_distance) {
        break;
      }
    }

    waitframe();
  }

  self notify("stop_loop");
  thread anim_single_solo(actor, anime);
  wait_time = getanimlength(actor getanim(anime));
  thread notify_delay("reminder_anim_done", wait_time);

  if(isDefined(actor.return_anime)) {
    delaythread(wait_time, &anim_loop_solo, actor, actor.return_anime, "stop_loop");
  }

  if(isDefined(var_f0dd62735e42c1e2)) {
    if(is_reminder) {
      level notify("reboot_timer");
      waitframe();
      level thread reminder_cooldown_timer(90);

      if(isDefined(level.interaction_manager)) {
        if(isDefined(level.interaction_manager.data["reminder_queue"])) {
          if(array_contains(level.interaction_manager.data["reminder_queue"], actor)) {
            level.interaction_manager.data["reminder_queue"][var_f0dd62735e42c1e2] = undefined;
          }
        }
      }
    }

    actor play_smart_dialog_if_exists(var_f0dd62735e42c1e2);
  }

  if(isDefined(actor.post_reaction_func) && !isDefined(actor.post_reaction_vo)) {
    if(isDefined(actor.post_reaction_params)) {
      if(actor.pre_reaction_params.size == 1) {
        actor[[actor.post_reaction_func]](actor.post_reaction_params[0]);
      } else if(actor.pre_reaction_params.size == 2) {
        actor[[actor.post_reaction_func]](actor.post_reaction_params[0], actor.post_reaction_params[1]);
      } else if(actor.pre_reaction_params.size == 3) {
        actor[[actor.post_reaction_func]](actor.post_reaction_params[0], actor.post_reaction_params[1], actor.post_reaction_params[2]);
      }
    }

    return;
  }

  if(isDefined(actor.post_reaction_func) && isDefined(actor.post_reaction_vo)) {
    actor thread[[actor.post_reaction_func]](undefined, undefined, actor.post_reaction_vo);
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
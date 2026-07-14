/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\interaction_manager.gsc
**********************************************/

#using script_4dac3680f88a01c3;
#using scripts\common\anim;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\interaction;
#namespace interaction_manager;

function interaction_manager_init() {
  level.interaction_manager = spawnStruct();
  level.interaction_manager.data = [];
  level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = [];
  level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"] = [];
  level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"] = [];
  reminder_vo_init();
  level.interaction_manager.allow_interactions = 1;
  level.interaction_manager.can_remind = 1;
  level.interaction_manager.pause_remind = 0;
  level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"] = [];
}

function stop_interactions() {
  reconstruct_actor_array();

  foreach(actor in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
    actor.allow_interactions = 0;
    actor.allow_gesture_reactions = 0;
  }
}

function stop_interaction() {
  if(arraycontains(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self)) {
    self.allow_interactions = 0;
    self.allow_gesture_reactions = 0;
  }
}

function continue_interactions() {
  reconstruct_actor_array();

  foreach(actor in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
    actor.allow_interactions = 1;
    actor.allow_gesture_reactions = 1;
  }
}

function continue_interaction() {
  if(arraycontains(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self)) {
    self.allow_interactions = 1;
    self.allow_gesture_reactions = 1;
  }
}

function trigger_interaction() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.lookat_anims)) {
    self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"] = 1;
  }
}

function trigger_interaction_multiple(ai_array) {
  self endon("\x1e\xfd\xd1\xa2\a");

  foreach(ai in ai_array) {
    if(isDefined(ai.lookat_anims)) {
      ai.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"] = 1;
    }
  }
}

function trigger_interaction_common() {
  self endon("\x1e\xfd\xd1\xa2\a");
  common = self.lookat_anims["\x1f\xd7B\t\x17\x80\bZ\xcb\xa2\xf5"];
  interaction_actors = level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"];

  foreach(actor in interaction_actors) {
    if(isDefined(actor.lookat_anims["\x1f\xd7B\t\x17\x80\bZ\xcb\xa2\xf5"])) {
      if(actor.lookat_anims["\x1f\xd7B\t\x17\x80\bZ\xcb\xa2\xf5"] == common) {
        actor.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"] = 1;
      }
    }
  }
}

function reconstruct_actor_array() {
  foreach(guy in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
    if(!isDefined(guy)) {
      level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = arrayremove(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], guy);
    }
  }
}

function add_actor_to_manager() {
  if(isDefined(level.interaction_manager)) {
    if(!arraycontains(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self)) {
      level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = utility::array_add(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self);
    }
  }
}

function remove_actor_from_manager() {
  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = arrayremove(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self);
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
    print("<dev string:x24>");
    return true;
  }

  if(isDefined(self.allow_interactions) && !self.allow_interactions) {
    return false;
  }

  reconstruct_actor_array();

  foreach(nearby_actor in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
    if(isDefined(nearby_actor) && isDefined(self)) {
      if(distance(self.origin, nearby_actor.origin) < active_range) {
        if(utility::hastag(nearby_actor.model, "\x13'$\xc4\xf8l\x16\xdf") && level.player math::point_in_fov(nearby_actor gettagorigin("\x13'$\xc4\xf8l\x16\xdf"))) {
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
    print("<dev string:x24>");
    return true;
  }

  reconstruct_actor_array();

  foreach(nearby_actor in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
    if(isDefined(nearby_actor) && isDefined(self)) {
      if(self != nearby_actor) {
        if(distance(self.origin, nearby_actor.origin) < active_range) {
          if(utility::within_fov(level.player getEye(), level.player.angles, nearby_actor gettagorigin("\x13'$\xc4\xf8l\x16\xdf"), cos(45))) {
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

    foreach(actor in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
      if(isDefined(actor)) {
        actor.allow_interactions = 0;
      }
    }

    while(true) {
      offset = length(level.player.origin - level.player getEye());
      lookat = actor_ent.origin + anglestoup(actor_ent.angles) * offset;

      if(!level.player utility_sp::player_looking_at(lookat, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    reconstruct_actor_array();
    actor_ent.allow_interactions = 1;

    foreach(actor in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
      if(isDefined(actor)) {
        actor.allow_interactions = 1;
      }
    }
  }
}

function interaction_reboot_timer() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(level.interaction_manager)) {
    if(isDefined(self.allow_interactions) && !self.allow_interactions) {
      return;
    }

    self.allow_interactions = 0;
    wait 20;

    while(true) {
      if(isDefined(self.reaction_state) && self.reaction_state != "e\x94R" && self.reaction_state != "\xccS\x1fe") {
        break;
      }

      waitframe();
    }

    while(true) {
      offset = length(level.player.origin - level.player getEye());
      lookat = self.origin + anglestoup(self.angles) * offset;

      if(!level.player utility_sp::player_looking_at(lookat, 0.7, 1)) {
        break;
      }

      waitframe();
    }

    self.allow_interactions = 1;
  }
}

function reminder_cooldown_timer(interval_time) {
  level endon("\xdb5\xeb\x9d>?\xac&\xa24I,\x13\x99");
  level endon("2\xf2\xdb\x12\xd2\xf56\xc8k\x80\xfbu");
  level.interaction_manager.can_remind = 0;
  wait interval_time;
  level.interaction_manager.can_remind = 1;
}

function queue_reminder(dialog_alias, optional_anime, optional_animnode) {
  if(!isDefined(dialog_alias) && isDefined(optional_anime)) {
    dialog_alias = "\r+x5";
  }

  if(isDefined(optional_anime)) {
    dialog_alias = dialog_alias + "H" + optional_anime;
  }

  level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"][dialog_alias] = self;

  if(isDefined(optional_animnode)) {
    self.reminder_animnode = optional_animnode;
  }
}

function queue_reminder_distance_anim(dialog_alias, anime, optional_animnode, return_anime) {
  if(isDefined(dialog_alias)) {
    dialog_alias = dialog_alias + "H" + anime;
  } else {
    dialog_alias = anime;
  }

  level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"][dialog_alias] = self;

  if(isDefined(optional_animnode)) {
    self.reminder_animnode = optional_animnode;
  }

  self.use_reminder_anim = 1;

  if(isDefined(return_anime)) {
    self.return_anime = return_anime;
  }
}

function queue_reminder_with_reaction(dialog_alias, var_bbdccc70a974c132, registered_interaction, post_reaction_vo_array) {
  queue_reminder(dialog_alias);
  self.use_reminder_reaction = 1;
  self.registered_interaction = registered_interaction;
  self.post_reaction_vo_array = post_reaction_vo_array;
  self.reminder_reaction_pointat = var_bbdccc70a974c132;
}

function run_reminders(interval_time) {
  level endon("\xdb5\xeb\x9d>?\xac&\xa24I,\x13\x99");
  level thread reminder_queue_cleanup();
  keys = getarraykeys(level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"]);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    actor = level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"][key];

    if(isDefined(actor)) {
      key_tok = strtok(key, "H");
      dialog_line = key_tok[0];

      if(isDefined(actor.use_reminder_reaction) && actor.use_reminder_reaction) {
        if(isDefined(actor.registered_interaction) && isDefined(actor.post_reaction_vo_array)) {
          actor thread interaction::play_smart_interaction(actor.registered_interaction, dialog_line, actor.post_reaction_vo_array);
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
    actor = level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"][key];

    if(isDefined(actor)) {
      key_tok = strtok(key, "H");
      dialog_line = key_tok[0];

      if(key_tok.size > 1) {
        if(isDefined(actor.reminder_animnode)) {
          actor.reminder_animnode notify("b\xf6+H\xa9\xcc\x10\x940");
          actor.reminder_animnode thread animation::anim_single_solo(actor, key_tok[1]);
          wait_time = getanimlength(actor utility::getanim(key_tok[1]));
          actor thread utility_sp::notify_delay("\x04\x96\xbdF\xb1\x12&\xcd\xdf\x18\x06bG\x1d\x9a\x9bo\v", wait_time);

          if(isDefined(actor.return_anime)) {
            actor.reminder_animnode utility::delaythread(wait_time, &animation::anim_loop_solo, actor, actor.return_anime, "b\xf6+H\xa9\xcc\x10\x940");
          }
        } else {
          actor notify("b\xf6+H\xa9\xcc\x10\x940");
          actor thread animation::anim_single_solo(actor, key_tok[1]);
          wait_time = getanimlength(actor utility::getanim(key_tok[1]));
          actor thread utility_sp::notify_delay("\x04\x96\xbdF\xb1\x12&\xcd\xdf\x18\x06bG\x1d\x9a\x9bo\v", wait_time);

          if(isDefined(actor.return_anime)) {
            actor utility::delaythread(wait_time, &animation::anim_loop_solo, actor, actor.return_anime, "b\xf6+H\xa9\xcc\x10\x940");
          }
        }

        if(dialog_line != "\r+x5") {
          if(soundexists(dialog_line)) {
            actor utility_sp::smart_dialogue(dialog_line);
          }
        }
      } else if(!soundexists(key)) {
        actor utility_sp::smart_dialogue(key);
      }

      actor notify("N\x95mZ\xb92VN\xaf\x8co\xcd\x95");
      actor.reminder_animnode = undefined;
      level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"][key] = undefined;
      level.interaction_manager.can_remind = 0;
      wait interval_time;
      level.interaction_manager.can_remind = 1;
    }

    while(level.interaction_manager.pause_remind) {
      waitframe();
    }
  }

  level notify("\x05[\xfe\xacd\x86\x81\x9f\xf1\xc6\xce\x1eT\xb3");
}

function reminder_queue_cleanup() {
  level utility::waittill_any("\xdb5\xeb\x9d>?\xac&\xa24I,\x13\x99", "\x05[\xfe\xacd\x86\x81\x9f\xf1\xc6\xce\x1eT\xb3");
  level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"] = [];
}

function stop_reminders() {
  level notify("\xdb5\xeb\x9d>?\xac&\xa24I,\x13\x99");
  level notify("\x05[\xfe\xacd\x86\x81\x9f\xf1\xc6\xce\x1eT\xb3");
  level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"] = [];
  reconstruct_actor_array();

  foreach(guy in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
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

function play_state_based_interaction(reaction_name, optional_scripted_struct, starting_state, var_a17b40c112c1637) {
  if(!isDefined(starting_state)) {
    starting_state = "#yDV,\xd6";
  }

  if(isDefined(self.gender) && issubstr(self.gender, "Y\xfd\xb3\x92CH")) {
    starting_state = "\xccS\x1fe";
  }

  starting_reaction = reaction_name + "w" + "#yDV,\xd6";

  if(starting_state == "#yDV,\xd6" || starting_state == "e\x94R") {
    starting_reaction = reaction_name + "w" + starting_state;
  }

  self.reaction_state_basename = reaction_name;
  self.reaction_state = starting_state;

  if(starting_state == "e\x94R") {
    thread interaction::play_interaction_with_states(starting_reaction, optional_scripted_struct);
    self.allow_interactions = 0;
    self.reaction_state = starting_state;
    thread utility_sp::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_a17b40c112c1637, 1);
    return;
  } else if(starting_state == "\xccS\x1fe") {
    thread interaction::play_interaction_with_states(starting_reaction, optional_scripted_struct);
    self.allow_interactions = 0;
    self.reaction_state = starting_state;
    thread utility_sp::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_a17b40c112c1637);
    return;
  }

  thread interaction::play_interaction_with_states(starting_reaction, optional_scripted_struct);
}

function stop_state_based_interaction() {
  if(!isDefined(self.is_cheap)) {
    thread interaction::interaction_end();
  } else {
    self notify("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  }

  self notify("\xc6\x1a\x16\x9b;Y\xbe\xc9\xac\xc2c:\xa5\xde\x9b\xf5n\xe8\vte");
  self.reaction_state = undefined;
  self.allow_interactions = undefined;
  self.reaction_state_basename = undefined;
  thread utility_sp::gesture_stop(0.7);
}

function set_reaction_state(reaction_state, var_a17b40c112c1637) {
  if(!isDefined(self.reaction_state)) {
    return;
  }

  if(!isDefined(reaction_state)) {
    assertmsg("<dev string:x99>");
    return;
  }

  if(!isDefined(self.reaction_state_basename)) {
    assertmsg("<dev string:xc8>");
    return;
  }

  self notify("\xc6\x1a\x16\x9b;Y\xbe\xc9\xac\xc2c:\xa5\xde\x9b\xf5n\xe8\vte");
  self notify("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");

  if(reaction_state != "e\x94R" && reaction_state != "\xccS\x1fe") {
    self.allow_interactions = 1;
    thread utility_sp::gesture_stop(0.7);
    self.interaction_name = self.reaction_state_basename + "w" + reaction_state;
    self.reaction_state = reaction_state;
    return;
  }

  if(reaction_state == "e\x94R") {
    self.allow_interactions = 0;
    self.reaction_state = reaction_state;
    thread utility_sp::gesture_stop(0.7);
    thread reaction_look_distance_based();
    thread reaction_state_busy_loop(var_a17b40c112c1637, 1);
    return;
  }

  self.allow_interactions = 0;
  self.reaction_state = reaction_state;
  thread utility_sp::gesture_stop(0.7);
  thread reaction_look_distance_based();
  thread reaction_state_busy_loop(var_a17b40c112c1637);
}

function reaction_state_busy_loop(var_a17b40c112c1637, var_add80e43e785dd48) {
  self endon("\xc6\x1a\x16\x9b;Y\xbe\xc9\xac\xc2c:\xa5\xde\x9b\xf5n\xe8\vte");

  while(true) {
    thread gesture_reaction_distance_based(var_a17b40c112c1637, var_add80e43e785dd48);
    self waittill("\xdd ;K\x8a9[\x92)\xf4-!\xa4)S\x18\xbd\xce\xad\x8a\xbd\x0eu\x1d\x83\xc2w\xc7]\x9a\xd0\xcb\x03\xc2`");

    while(true) {
      if(distance2d(self.origin, level.player.origin) >= level.state_interactions[self.interaction_name].scene["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] + 50) {
        break;
      }

      waitframe();
    }
  }
}

function set_all_reaction_states(state, var_81c1ae89ad8da4cb) {
  switch (state) {
    case #"hash_186d745a92c317d9":
    case #"hash_4075266c2bfb0d95":
    case #"hash_46fdaf04e9be63e4":
    case #"hash_ab31742ee80771e0":
      foreach(actor in level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"]) {
        actor thread set_reaction_state(state, var_81c1ae89ad8da4cb);
      }

      break;
  }
}

function reaction_look_distance_based(check_distance, look_target, look_wait, var_b2773e075743672e) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");
  self endon("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
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
    if(isDefined(level.state_interactions[self.interaction_name].scene["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"])) {
      distance_value = level.state_interactions[self.interaction_name].scene["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] * 1.2;
    }
  }

  waitframe();

  if(isDefined(var_b2773e075743672e) && var_b2773e075743672e) {
    thread utility_sp::gesture_follow_lookat(look_target, 0.5, 0.5);
  } else {
    thread utility_sp::gesture_follow_lookat_natural(look_target, 0.5, 0.5, distance_value);
  }

  while(!isDefined(self.is_head_tracking)) {
    wait 0.05;
  }

  thread utility_sp::gesture_follow_eyes(look_target);
  wait randomfloatrange(4, 6);
  eyes_enabled = 1;
  blend_up = 1;

  while(true) {
    if(distance2d(self.origin, look_target.origin) <= distance_value) {
      if(!blend_up) {
        thread namespace_6ecc19f3ac5deab::ai_gesture_lookat_weight_up(0.5);
        thread utility_sp::gesture_follow_eyes(look_target);
        blend_up = 1;
      }
    } else if(distance2d(self.origin, look_target.origin) >= distance_value) {
      if(blend_up) {
        thread namespace_6ecc19f3ac5deab::ai_gesture_lookat_weight_down(1);
        thread utility_sp::gesture_eyes_stop(0.7);
        blend_up = 0;
      }
    }

    waitframe();
  }
}

function gesture_reaction_distance_based(var_a17b40c112c1637, var_add80e43e785dd48) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");
  distance_value = 50;

  if(isDefined(self.reaction_state_basename)) {
    if(isDefined(level.state_interactions[self.interaction_name].scene["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"])) {
      distance_value = level.state_interactions[self.interaction_name].scene["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"];
    }
  }

  waittill_gestureconditionsmet(distance_value);
  thread utility_sp::gesture_simple("4~\x99\x88\x19y");
  var_8d927ea24182e19a = undefined;

  if(isDefined(var_add80e43e785dd48) && var_add80e43e785dd48) {
    switch (var_a17b40c112c1637) {
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
        line_array = level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637][self.gender];
        spent_array = level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637]["H1\x06\x10\xd4[" + self.gender];

        if(line_array.size < 1 && spent_array.size > 0) {
          level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637][self.gender] = spent_array;
          level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637]["H1\x06\x10\xd4[" + self.gender] = [];
          line_array = level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637][self.gender];
          spent_array = level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637]["H1\x06\x10\xd4[" + self.gender];
        }

        if(line_array.size < 1 && spent_array.size < 1) {
          var_8d927ea24182e19a = undefined;
        } else {
          var_8d927ea24182e19a = line_array[randomint(line_array.size)];
          level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637]["H1\x06\x10\xd4[" + self.gender] = utility::array_add(level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637]["H1\x06\x10\xd4[" + self.gender], var_8d927ea24182e19a);
          level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637][self.gender] = arrayremove(level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][var_a17b40c112c1637][self.gender], var_8d927ea24182e19a);
        }

        break;
    }
  } else {
    line_array = level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"][self.gender];
    spent_array = level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["H1\x06\x10\xd4[" + self.gender];

    if(line_array.size < 1 && spent_array.size > 0) {
      level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"][self.gender] = spent_array;
      level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["H1\x06\x10\xd4[" + self.gender] = [];
      line_array = level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"][self.gender];
      spent_array = level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["H1\x06\x10\xd4[" + self.gender];
    }

    if(line_array.size < 1 && spent_array.size < 1) {
      var_8d927ea24182e19a = undefined;
    } else {
      var_8d927ea24182e19a = line_array[randomint(line_array.size)];
      level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["H1\x06\x10\xd4[" + self.gender] = utility::array_add(level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["H1\x06\x10\xd4[" + self.gender], var_8d927ea24182e19a);
      level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"][self.gender] = arrayremove(level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"][self.gender], var_8d927ea24182e19a);
    }
  }

  if(isDefined(var_8d927ea24182e19a)) {
    utility_sp::smart_dialogue(var_8d927ea24182e19a);

    if(isDefined(var_add80e43e785dd48) && var_add80e43e785dd48) {
      level thread reminder_cooldown_timer(90);
    }
  }

  self.playing_gesture = 1;
  self notify("\xdd ;K\x8a9[\x92)\xf4-!\xa4)S\x18\xbd\xce\xad\x8a\xbd\x0eu\x1d\x83\xc2w\xc7]\x9a\xd0\xcb\x03\xc2`");
  wait 15;
  self.playing_gesture = 0;
}

function print_reaction_state() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");

  while(true) {
    print3d(self.origin + anglestoup(self.angles) * 70, self.reaction_state, (0.5, 1, 0), 1, 0.25, 1);

    print3d(self.origin + anglestoup(self.angles) * 75, "<dev string:x103>" + self.allow_interactions, (0.5, 1, 0), 1, 0.25, 1);

    if(isDefined(self.allow_gesture_reactions)) {
      print3d(self.origin + anglestoup(self.angles) * 80, "<dev string:x11a>" + self.allow_gesture_reactions, (0.5, 1, 0), 1, 0.25, 1);
    }

    if(isDefined(self.gender)) {
      print3d(self.origin + anglestoup(self.angles) * 83, "<dev string:x12d>" + self.gender, (0.5, 1, 0), 1, 0.25, 1);
    }

    if(isDefined(self.animname)) {
      print3d(self.origin + anglestoup(self.angles) * 86, "<dev string:x12d>" + self.animname, (0.5, 1, 0), 1, 0.25, 1);
    }

    waitframe();
  }
}

function play_gesture_reaction(lookat_distance, reaction_distance, var_4d630b6ad675f4df, is_reminder, pointat_target) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("\x87@O\xb5E:8\xd3\xb4+x\xf4\xcd\xab\x06\x81?\x81cZ\xdf");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
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
  play_interaction_vo(var_4d630b6ad675f4df, is_reminder);
}

function waittill_gestureconditionsmet(reaction_distance) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("\x87@O\xb5E:8\xd3\xb4+x\xf4\xcd\xab\x06\x81?\x81cZ\xdf");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  checkingconditions = 1;

  while(true) {
    if(isplayerfocus(reaction_distance) && canplaygesture(reaction_distance)) {
      head_vec = utility::flatten_vector(anglestoright(self gettagangles("\xa6\xeb\x1ae\x85#")));
      vec_to_player = utility::flatten_vector(vectorNormalize(level.player getEye() - self gettagorigin("\xa6\xeb\x1ae\x85#")));
      dot = vectordot(head_vec, vec_to_player);

      if(dot >= 0.8) {
        break;
      }
    }

    waitframe();
  }
}

function isplayerfocus(required_dist) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.is_cheap)) {
    self_eye = self gettagorigin("\xa6\xeb\x1ae\x85#");
  } else if(isai(self)) {
    self_eye = self getEye();
  } else if(isDefined(self.origin)) {
    self_eye = self.origin;
  } else {
    assertmsg("<dev string:x139>");
    println("<dev string:x185>");
    return false;
  }

  var_453fb6469504b51c = level.player getEye();
  var_91c522ea229f5c2 = level.player getplayerangles();

  if(distance2d(self.origin, level.player.origin) <= required_dist) {
    if(utility::within_fov(var_453fb6469504b51c, var_91c522ea229f5c2, self_eye, cos(25))) {
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

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function play_gesture_reaction_anim(pointat_target) {
  self.playing_gesture = 1;

  if(!isDefined(self.is_cheap)) {
    if(isDefined(pointat_target)) {
      thread utility_sp::gesture_point(pointat_target);
    } else {
      thread utility_sp::gesture_simple("4~\x99\x88\x19y");
    }
  } else {
    utility_sp::gesture_custom(%s\x1aK\x0e\xb1r\x961\xf5;\xdc\x1d_\x1ae\x16F_\xb9\xb06\xab\x1d\xca\xfa\x18\xc4);
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
    self.animname = "RF\x9e\xe1\xc4\x1f\xe7";
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
  var_6ef3f54b15d98884 = undefined;

  if(isarray(vo_line)) {
    for(index = 0; index < vo_line.size; index++) {
      action = vo_line[index];

      if(isstring(action)) {
        define_face_anim_if_exists(action);

        if(soundexists(action)) {
          if(issubstr(action, "\x1d5\x17")) {
            level.player utility_sp::smart_player_dialogue(action);
          } else {
            var_6ef3f54b15d98884 = main_cast_dialog_actor_check(action);

            if(isDefined(var_6ef3f54b15d98884)) {
              var_6ef3f54b15d98884 utility_sp::smart_dialogue(action);
            } else {
              utility_sp::smart_dialogue(action);
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
      if(issubstr(action, "\x1d5\x17")) {
        level.player utility_sp::smart_player_dialogue(action);
        return;
      }

      var_6ef3f54b15d98884 = main_cast_dialog_actor_check(action);

      if(isDefined(var_6ef3f54b15d98884)) {
        var_6ef3f54b15d98884 utility_sp::smart_dialogue(action);
        return;
      }

      utility_sp::smart_dialogue(action);
    }
  }
}

function force_reminder_delay(delay_time) {
  level notify("2\xf2\xdb\x12\xd2\xf56\xc8k\x80\xfbu");
  waitframe();
  level thread reminder_cooldown_timer(delay_time);
}

function clear_reminder(reminder_alias) {
  if(isDefined(level.interaction_manager)) {
    if(isDefined(level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"])) {
      if(arraycontains(level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"], self)) {
        level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"][reminder_alias] = undefined;
      }
    }
  }
}

function play_group_gesture_reaction(actor_array, lookat_distance, reaction_distance, var_51e732186b4898fc) {
  foreach(actor in actor_array) {
    actor endon("\x1e\xfd\xd1\xa2\a");
    actor endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
    actor endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
    actor endon("\x87@O\xb5E:8\xd3\xb4+x\xf4\xcd\xab\x06\x81?\x81cZ\xdf");
    actor endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  }

  foreach(actor in actor_array) {
    actor thread add_actor_to_manager();
  }

  thread reaction_group_look_distance_based(actor_array, lookat_distance);
  waittill_group_gestureconditionsmet(actor_array, reaction_distance);
  play_group_gesture_performance(actor_array, var_51e732186b4898fc, reaction_distance);

  foreach(actor in actor_array) {
    random_f1 = randomfloatrange(0, 1);
    random_f2 = randomfloatrange(0.5, 1.5);
    actor utility::delaythread(random_f1, &utility_sp::gesture_stop, random_f2);
  }
}

function waittill_group_gestureconditionsmet(actor_array, minimum_distance) {
  checkingconditions = 1;
  mid_point = create_middle_ent(actor_array);
  actor_array = utility::array_add(actor_array, mid_point);

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
  middle_ent = utility::spawn_tag_origin(midpoint, (0, 0, 0));
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
    actor endon("\x1e\xfd\xd1\xa2\a");
    actor endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
    actor endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
    actor endon("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");
    actor endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
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
    actor utility_sp::gesture_follow_lookat(look_target, 0.15, 0.7);
    actor.lookat_enabled = 0;
    actor.lookat_delay = 0;
  }

  waitframe();

  foreach(actor in actor_array) {
    actor thread utility_sp::gesture_eye_dart_loop(look_target);
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
  thread namespace_6ecc19f3ac5deab::ai_gesture_lookat_weight_up(0.7);
}

function decrease_lookat_weight() {
  thread namespace_6ecc19f3ac5deab::ai_gesture_lookat_weight_down(0.7);
}

function convertvar_toarray(var_88e2ee2a8dec3b2d) {
  if(!isarray(var_88e2ee2a8dec3b2d)) {
    return [var_88e2ee2a8dec3b2d];
  }

  return var_88e2ee2a8dec3b2d;
}

function play_gesture_reaction_loop(lookat_distance, reaction_distance, reaction_vo_array, is_reminder, pointat_target) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  var_fcd9eb1cfb76985c = [];

  for(vo_array = reaction_vo_array; true; vo_array = arrayremove(vo_array, random_line)) {
    if(vo_array.size <= 0) {
      var_fcd9eb1cfb76985c = [];
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
    var_fcd9eb1cfb76985c = utility::array_add(var_fcd9eb1cfb76985c, random_line);
  }
}

function stop_gesture_reaction() {
  self notify("\x87@O\xb5E:8\xd3\xb4+x\xf4\xcd\xab\x06\x81?\x81cZ\xdf");
  self notify("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");
  self notify("\xefu\xbe\x9a\x9f\xf6i\xd7\v\x19\xbd\xd3q\x0e\xe3\xa8\xac\xf4?m\x91o\x1f\x8f\v");
  self.gesture_reaction_queue = undefined;
  utility_sp::gesture_stop(0.7);
}

function stop_queued_reaction() {
  self notify("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  thread interaction::interaction_end();
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("\xefu\xbe\x9a\x9f\xf6i\xd7\v\x19\xbd\xd3q\x0e\xe3\xa8\xac\xf4?m\x91o\x1f\x8f\v");
  self notify("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");
  utility_sp::gesture_stop(0.7);
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

      if(level.player utility_sp::player_looking_at(lookat, 0.75, 1)) {
        if(distance2d(self.origin, level.player.origin) <= reaction_distance && can_play_nearby_gesture(reaction_distance)) {
          break;
        }
      }

      waitframe();
    }

    thread utility_sp::gesture_simple("4~\x99\x88\x19y");
    self.allow_gesture_reactions = 0;

    if(isarray(dialog_set)) {
      for(index = 0; index < dialog_set.size; index++) {
        action = dialog_set[index];

        if(isstring(action)) {
          define_face_anim_if_exists(action);

          if(soundexists(action)) {
            if(issubstr(action, "\x1d5\x17")) {
              level.player utility_sp::smart_player_dialogue(action);
            } else {
              var_6ef3f54b15d98884 = main_cast_dialog_actor_check(action);

              if(isDefined(var_6ef3f54b15d98884)) {
                var_6ef3f54b15d98884 utility_sp::smart_dialogue(action);
              } else {
                utility_sp::smart_dialogue(action);
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
      var_6ef3f54b15d98884 = main_cast_dialog_actor_check(dialog_set);

      if(isDefined(var_6ef3f54b15d98884)) {
        var_6ef3f54b15d98884 utility_sp::smart_dialogue(dialog_set);
      } else {
        utility_sp::smart_dialogue(dialog_set);
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
  var_f8dfe8e384fb1252 = strtok(dialog_line, "w");

  if(arraycontains(var_f8dfe8e384fb1252, "\xb8\xae\x9a") || arraycontains(var_f8dfe8e384fb1252, "\x8d\x0f\xef")) {
    return level.gator;
  } else if(arraycontains(var_f8dfe8e384fb1252, "\x04m\b") || arraycontains(var_f8dfe8e384fb1252, "\xc32")) {
    return level.salter;
  } else if(arraycontains(var_f8dfe8e384fb1252, "U\xd6V")) {
    if(level.script == "-\xdf\xd5\x01\xe30\x16\xab\xb3\xf5\xf3\re\x10" || level.script == "\x89\x9f\xf6\x19\xd7\xa3\x04C\x7fb\xc0\xd1\xe1h\x99-9") {
      return level.sipes;
    } else {
      return level.sotomura;
    }
  } else if(arraycontains(var_f8dfe8e384fb1252, "\x05-d")) {
    return level.comms;
  } else if(arraycontains(var_f8dfe8e384fb1252, "\xbd\v\xa8")) {
    return level.drop_officer;
  }

  return undefined;
}

function play_reminder_anim_distance(actor, lookat_distance, reaction_distance, anime, var_4d630b6ad675f4df, is_reminder) {
  actor endon("\x1e\xfd\xd1\xa2\a");

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

  level endon("\xdb5\xeb\x9d>?\xac&\xa24I,\x13\x99");
  level endon("\x05[\xfe\xacd\x86\x81\x9f\xf1\xc6\xce\x1eT\xb3");
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

    if(level.player utility_sp::player_looking_at(lookat, 0.75, 1)) {
      if(distance2d(actor.origin, level.player.origin) <= reaction_distance) {
        break;
      }
    }

    waitframe();
  }

  self notify("b\xf6+H\xa9\xcc\x10\x940");
  thread animation::anim_single_solo(actor, anime);
  wait_time = getanimlength(actor utility::getanim(anime));
  thread utility_sp::notify_delay("\x04\x96\xbdF\xb1\x12&\xcd\xdf\x18\x06bG\x1d\x9a\x9bo\v", wait_time);

  if(isDefined(actor.return_anime)) {
    utility::delaythread(wait_time, &animation::anim_loop_solo, actor, actor.return_anime, "b\xf6+H\xa9\xcc\x10\x940");
  }

  if(isDefined(var_4d630b6ad675f4df)) {
    if(is_reminder) {
      level notify("2\xf2\xdb\x12\xd2\xf56\xc8k\x80\xfbu");
      waitframe();
      level thread reminder_cooldown_timer(90);

      if(isDefined(level.interaction_manager)) {
        if(isDefined(level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"])) {
          if(arraycontains(level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"], actor)) {
            level.interaction_manager.data["\xb3\xefF>\xf1\x95B\xa2VO\xd2\xcc\x1aL"][var_4d630b6ad675f4df] = undefined;
          }
        }
      }
    }

    actor play_smart_dialog_if_exists(var_4d630b6ad675f4df);
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
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xd8\xdav\xf1^\xed"] = ["'&Q}\xce\xadl\xd6\xe3Gu7\xfc@\x17c\xe0\xb3E\x15\x85\xdeN\xc4\x92\xc9l"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xaf\xf2\xe3\xe9on"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xb6acV\xfa\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["l\x89\x1f\x8c\x9c:\xd0S"] = ["'&Q}\xce\xadl\xd6\xe3Gu7\xfc@\x17c\xe0\xb3E\x15\x85\xdeN\xc4\x92\xc9l"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\x98\xc4\n9\xd2\x96m\x1b"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xbba\xe5\xddT\x88\x98T"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"][":d\xee;7`"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\xd8\xdav\xf1^\xed"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\xaf\xf2\xe3\xe9on"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\xb6acV\xfa\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["l\x89\x1f\x8c\x9c:\xd0S"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\x98\xc4\n9\xd2\x96m\x1b"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\x98\xc4\n9\xd2\x96m\x1b"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["+\x7f4W\t\x1c"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\xd8\xdav\xf1^\xed"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\xaf\xf2\xe3\xe9on"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\xb6acV\xfa\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["l\x89\x1f\x8c\x9c:\xd0S"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\x98\xc4\n9\xd2\x96m\x1b"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["Y\xfd\xb3\x92CH"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x82\xd1\xeb\xd1\xa0\x11\xb3\xdf"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xd8\xdav\xf1^\xed"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xaf\xf2\xe3\xe9on"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xb6acV\xfa\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["l\x89\x1f\x8c\x9c:\xd0S"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\x98\xc4\n9\xd2\x96m\x1b"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xbba\xe5\xddT\x88\x98T"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\x8b\xd8Q\xc7\xcc\xa0"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xd8\xdav\xf1^\xed"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xaf\xf2\xe3\xe9on"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xb6acV\xfa\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["l\x89\x1f\x8c\x9c:\xd0S"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\x98\xc4\n9\xd2\x96m\x1b"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xbba\xe5\xddT\x88\x98T"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["5\xa8\xa3"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xd8\xdav\xf1^\xed"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xaf\xf2\xe3\xe9on"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xb6acV\xfa\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["l\x89\x1f\x8c\x9c:\xd0S"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\x98\xc4\n9\xd2\x96m\x1b"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xbba\xe5\xddT\x88\x98T"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xd0\xee2"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xd8\xdav\xf1^\xed"] = ["\x0eq\x81o\xcc\x14\xb1+<\xc21\xd5\xf7\xa9 O]\x06\xf6\xeb\xedh\xac\xd0\xa3\xb9\x80}", "9\xba\xf19\xda8X5\xae6\xb8\x7fg\x1f8;86\x8b\x1b\xf5\xa8\xd8\xd9\xed\xda\xae\xf2"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xaf\xf2\xe3\xe9on"] = ["}\x0f\x19a\xd8\xfc\xc9\x1a\xe7lH=\x18A\x98\xbc\xf4/T\xc7:\x01\x9a\xae\x0fj\xe3^", "\x82\xf2\x98\xa0aQ\xcdW\xa7\xc9\xc9\b\xf3\x15\xf5\b\xa9\x01\xaa9\xcb\x02\x8do\xce\r\x1e"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xb6acV\xfa\x99"] = ["Kt\xbb:\x7f\a\xfc\x1a\xbfT~\xa4>\xbe\xb6.\x02\x1fK\x14\x94\xd104+\xaa", "\xb1\x85\aj\x12n\x13s\x19\x14\x1e\xc7y\xc7j\t\xf0Y\xfc\xef\xd6\xbb/\x83e\xef\x93"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["l\x89\x1f\x8c\x9c:\xd0S"] = ["9n@o%\xcd\xce\x81}\xe3;\n\x93&D\x92\x05\xb4\xf5\x05\xc3 \xb1\xcb\xa4\x8f\xa6\x99", "\xe6Ci\xe0\xc6rZL_\xab\xe6fb\xebt\x86\xca\x97\x9c+\xee\vKt-\xb9v\xb0G\xa3"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\x98\xc4\n9\xd2\x96m\x1b"] = ["L\xb4\xee\xfd\x93\x10\xbc\xd1%\x02\xd67i\xbcy\xb8L\x8a\xae\xbb\xc3\x01\xd1^1\x10\x91\x96\x80\x99\xed\x11", "?\xa7h\x87\xb7\xa5\xcez\xe0_hya\x02\xd6\xa6\xd9\x06]aA\xee\x96\xe1\xbe\xd3\xc4\x9cC\"\x84"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xbba\xe5\xddT\x88\x98T"] = ["\a\xd4\xa5D\xcc\x99K\xc6\x14\xb5\xdc\x1e\xfa\x8c\x89\x04\x16\x89\x146\f\xde\x0f%\xd1/\xfaM\xaf \x95", "\x17.\t\x9e\x16\xaa\x10\x04\xa0Q\xc0\x1c[s\xe5\xe3B\xd9l\xea6\x89\x02\xcf\x04\xf6\xb6xw^0"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["o(\xab\x97s\xd3\x8f\x02\x1c\xa4\xdd\xf8\x1b\xfd\xb9/v"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xd8\xdav\xf1^\xed"] = ["\xe6\r\xd2\al\x9c\xb4L_\xeanL\xfa\xe5\xdbWN\x957V\x952\xac\x91\x89\x97\xe8\xa1\x95", "Y8\x86#\xb2<\xed\x80\xf7\xf6/\x88\x97\xc7-|L\x02x\t\x1e\xff\x1c6\xa2\x14s\vr\xce"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xaf\xf2\xe3\xe9on"] = ["\xe3xH\xb5\t\xe8\x02]\xc7-z\xed\x91$\x034\xce)I\xc6\xa4\x9dD\t7!\xa1\xb3[\x10.", "F\xa29\r\x9b\xde>\xb6?\xbe1i\xc2s\xb2K_\xbev\x10\xb4G\xfd.\xdb\xee\xf5"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xb6acV\xfa\x99"] = ["A\xdb\x04\xfa\x1e\xf7\\:\xef\x92\x11i\x99:i\x02\xdc\x94\x81\xf0Y^G\xc8\x8eU\x13dP\b", "\x90\x0f\xa5\x13\xbd\x1d\xb6\x809\x19\x9d\xbbv\xc7\rv\xaa\x93M0\x97u\x18\xc6\x95\xf9\x85\x10\xd1\x95\n"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["l\x89\x1f\x8c\x9c:\xd0S"] = ["\xd0\x1e\xf0w5\x04\xad\xcb\xf1\x96\xc6^\x81\x81\xe2\x15U<_>\xce\x8c\xf2\xd7\x8b\xdb\xc3X\xed\x84\xbc", "z\x05\x99\xb0\xd5s\xb7U\xfc\x86\xc0\xb3m\xdc\x82U(>\xf7\xec_\x9dy\x15\xbb\x97$\xe3\xfa\x7f"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\x98\xc4\n9\xd2\x96m\x1b"] = ["\xdc4K\a\x8d\x9cK&\xeb\xea73\x8c\xbe\x1d\xa1V\x97\xc9\xb2\x9cV,2\xcb3{N\xcb\xb7", "d\x03Go\xc6\x16\xef%\x9du\a\xcf\xaa`\xe7(e\x14\r\xe8\x9f\x06\xcf\bJ\xc9\x01\xd7s"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xbba\xe5\xddT\x88\x98T"] = ["\xe6\xd0\xa5\x83\xc6\xe4i&\xebu\xcd\x993\xbe\xb2lYva\xe8\xf6\x9cs\x93e,\xc8\xf2\xc2", "z\xd6\x01]\xbd\xf6r\n\xe7\xd7\xe6D\x128\xfcc\x93\xd8&\r.r\xb4|\x9c\xa2\xff\xda\xdf\xa8"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["]8\x8c\x94\b>\xdc\xb6\xbd\x80\xe6"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xd8\xdav\xf1^\xed"] = ["&\xd1V\x19\xf2\xd9\xb7\xf0\xde\xdb\xa7\xa1w\x8dD\xbb\xc1J\x84\xaf\x94\n\x96\xde\xea\xb8\x85\xa1"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xaf\xf2\xe3\xe9on"] = ["Y{\x1f\nah\xc5\xba\x11\x9c@XN\x9b\xf0}\r\x82\x9a\x86 cr4x\xc6~\xeb"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xb6acV\xfa\x99"] = ["\xc9r\x1e\x12nb\xa5\xa2{V\x9a\"\xdb2\xc2\xbb\x96\x954\xed\x80\xd8#{0\xdc\x05\x19\xbb\xf8"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["l\x89\x1f\x8c\x9c:\xd0S"] = ["G-\xda\xbc\xe80\r\xde@\xf5\xb2\xc8\xb6\x1c%IE\x1b+\xf4\xe0\x16\x01\xf8\xbb]\x11\xf0\x9c"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\x98\xc4\n9\xd2\x96m\x1b"] = ["\x14\xfd\x1b\x11\x99\xfdHZ<x\xc7\x93\xad\x81\x9d6\x913\x169\x8e\xc0HX{\xe8\xd6\xaci\x98"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xbba\xe5\xddT\x88\x98T"] = ["#\xb7\x8c\xe7\xe6\xce\t\x0e\xde,t\xca\x1e\xefs~\x9a`\xf5\xd7\xd4\xdcH{\xf2\xc1\xc3\x1c$\x9b\x81b\x1f"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["Z\x88\xf14\x04\xdb\x13\xa0"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xd8\xdav\xf1^\xed"] = ["7\xd0\xa58\xb1'\x96L\xd7\xaes&}\x97\xde]\xe4M,\xc6k\xb06\xb4\x9b'\xca\x16#"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xaf\xf2\xe3\xe9on"] = ["\xff\x1c`$\x05Z~[\x03y[u\xf7\xb0\x1a\x19\xee\xc2\x80\x89\t\xff\xc9;`rT]"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xb6acV\xfa\x99"] = ["\xde\a\xcd8v\xb3\x8b\x84ta\xd7\xdb\x83\xbd\x89x\xf9&x\x1d(/\xa3\xec|\x86\xf2\xc6(P"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["l\x89\x1f\x8c\x9c:\xd0S"] = ["\x1a\xea\x05B\x94j\x95v\xd9\x99^T'\xa6E\xae\xc4N@\x84_\xc5\xfe\xd8L\xb1=\xf0\xea\xb0`\xdf"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\x98\xc4\n9\xd2\x96m\x1b"] = ["\xa8\xf8OF\x90\xdby\x03\x032u?h\xd0\xbb\xb8e\xe7\xa1\xd6)\xb0\x97\f\xf8>\x8e\x93\xd1"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xbba\xe5\xddT\x88\x98T"] = ["\xd5\x8dz\n,\xad\x82\xd9f\xd3<._\x06D\xbf\x7f\xcdyH3\xc0\x17\xc6!\xbf\xaf\xdc\x0e\xc8"];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\a\x03V\xd0\x82\t\"\x10\xed\x8f\xc4"]["\xae51W\xac]"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xd8\xdav\xf1^\xed"] = ["\x8dS\xb4\xb2L\x16'zO\xbe*?=\xcc\xeb\x17`d.\x1a\x14", "\xcd\x16\xfeO'O\xe9\x0e\x04j\xb2{\xec\xffR\xd9#"];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xaf\xf2\xe3\xe9on"] = ["\x9b9\xa0\xf2\x7f\xce\xd0\"\xf9\xbb(\xe2\xe1\xf8\x9b\x12\x15O\xe8}+\xfbI\xdbBC\xf3", "\xa2\x8a\xbax^\x18\x86\xc5\xeeM\xda\xb21\xb7E\x1fF\xaa\x05\xeb\xf9K[\xa8\xbevQ\x13\xde\xfd\x17"];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xb6acV\xfa\x99"] = ["o n-\xe7n\x0e\xa4w\x96c\xc6J~\xc4N8<n*\xf9\x85\xfa\xca\x11\xda\xd1\xfa\xb5\x15", "\xcd\xa1i\x0el9\xd2\xc4\xfa\xd5\xb9f\xfa\xd8\x85p\x8e\xc2\xd2\xe6"];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["k\x18x\xb1|N\xcb\x10\x05\xa6\x8c\x99"] = [];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\r\x83\xc5p_i\xbf\xe0\xa5ns\xdb"] = [];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xdc8+\xe6\xd1\xd7k\x16\x8d\xca\xaf\x99"] = [];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["l\x89\x1f\x8c\x9c:\xd0S"] = ["\x9eEthU]\xd0\f\xff\x9c\x16\b\x9a\xc6\xa8g\x10\a<\x18\x19", "7\x1a\x96\alN-&\xd7\xab\xdc3#\xbe\xf2\xed\xab\x1b\xb1\r\xb0\xce\xcaG\xb7\x95<\x8d]\xdc"];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\x98\xc4\n9\xd2\x96m\x1b"] = ["\x9eEthU]\xd0\f\xff\x9c\x16\b\x9a\xc6\xa8g\x10\a<\x18\x19", "7\x1a\x96\alN-&\xd7\xab\xdc3#\xbe\xf2\xed\xab\x1b\xb1\r\xb0\xce\xcaG\xb7\x95<\x8d]\xdc"];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xbba\xe5\xddT\x88\x98T"] = ["\x9dH\xb7\x86|gCI\xed\x95\xc05r\x0f\x8bA\x0eh:\xa08\xad\xdb\x03\x16~", "\xbf\xe0C\xfd\xe6\xf4\x966\x98\x82\x94\xf3cV\xbau\x98"];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xf5d\x7f\fV\xfa,L\xc1\xa9\xcc\x8b2\x90"] = [];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xe7\xadS&p\x10\xc2\x7f\xfb\x1b\xfcn\x17\f"] = [];
  level.interaction_manager.data["\xe9\x14\xe1%\xc8\xf5/"]["\xa8\x98\x8fI(\x90\xfe\x04\x1a8U\xff\xbe\xb3"] = [];
}
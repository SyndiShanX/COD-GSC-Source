/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\interaction.gsc
***********************************************/

register_interaction(var_0, var_1) {
  level.interactions[var_0] = var_1;
}

register_state_interaction(var_0, var_1) {
  level.state_interactions[var_0] = var_1;
}

get_interaction(var_0) {
  if(!isDefined(level.interactions) || !isDefined(level.interactions[var_0]))
    return undefined;

  return level.interactions[var_0];
}

get_state_interaction(var_0) {
  if(!issubstr(var_0, "casual") && !issubstr(var_0, "alert")) {
    if(isDefined(self.asm)) {
      var_1 = scripts\asm\asm::asm_getdemeanor();

      if(var_1 == "casual")
        var_0 = var_0 + "_" + var_1;
      else
        var_0 = var_0 + "_alert";
    } else
      var_0 = var_0 + "_casual";
  }

  if(!isDefined(level.state_interactions) || !isDefined(level.state_interactions[var_0]))
    return undefined;

  return level.state_interactions[var_0];
}

is_interaction(var_0) {
  return isDefined(level.interactions) && isDefined(level.interactions[var_0]);
}

is_state_interaction(var_0) {
  return isDefined(level.state_interactions) && isDefined(level.state_interactions[var_0 + "_casual"]);
}

is_state_interact_struct(var_0) {
  if(isDefined(var_0.script_reaction) && is_state_interaction(var_0.script_reaction))
    return 1;

  return 0;
}

is_interact_struct(var_0) {
  if(isDefined(var_0.script_reaction) && is_interaction(var_0.script_reaction))
    return 1;

  if(isDefined(var_0.script_noteworthy) && is_interaction(var_0.script_noteworthy))
    return 1;

  return 0;
}

is_interact_node(var_0) {
  if(isDefined(var_0.script_reaction)) {
    if(is_interaction(var_0.script_reaction) || var_0.script_reaction == "combat_reaction")
      return 1;
  }

  return 0;
}

get_arrivalstate_from_interaction(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(isDefined(var_0.arrivalstates))
    return var_0.arrivalstates[var_1];
  else
    return undefined;
}

get_exitstate_from_interaction(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();

  if(isDefined(var_0.exitstates))
    return var_0.exitstates[var_1];
  else
    return undefined;
}

get_idlestate_from_interaction(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();
  return var_0.idlestate;
}

setup_exit_states_for_interaction(var_0) {
  if(!isai(self)) {
    return;
  }
  self.asm.customdata.interaction = var_0;
  var_1 = get_interaction(var_0);

  if(!isDefined(var_1))
    var_1 = get_state_interaction(var_0);

  self.asm.customdata.exitstate = get_exitstate_from_interaction(var_1);
}

play_interaction_anim(var_0, var_1, var_2, var_3, var_4) {
  var_0 = get_interaction(var_0);

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0.05;

  if(!isDefined(var_4))
    var_4 = 1;

  start_fakeactor_notetracks(var_0.scene[var_1]);
  self setflaggedanim(var_1, var_0.scene[var_1], var_2, var_3, var_4);
}

define_interacton_position(var_0) {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_1 = undefined;

  for(;;) {
    if(isstruct(var_0) || isent(var_0))
      var_1 = var_0.origin;
    else if(isvector(var_0))
      var_1 = var_0;

    if(isDefined(self.lookat_anims))
      self.lookat_anims["interaction_position"] = var_1;

    waitframe();
  }
}

redefine_interaction_radius(var_0) {
  var_1 = undefined;

  if(isDefined(self.lookat_anims)) {
    var_1 = self.lookat_anims["trigger_radius"];
    self.lookat_anims["trigger_radius"] = var_0;
    thread _redefine_interaction_radius_cleanup(var_1);
  }
}

_redefine_interaction_radius_cleanup(var_0) {
  self endon("interaction_end");
  self endon("reaction_end");
  self waittill("interaction_done");
  self.lookat_anims["trigger_radius"] = var_0;
}

play_interaction(var_0, var_1, var_2) {
  self endon("death");
  self notify("reaction_end");
  var_3 = get_interaction(var_0);
  setup_exit_states_for_interaction(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  self.lookat_anims = var_3.scene;

  if(!isDefined(self.animname))
    self.animname = "generic";

  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var_0;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions))
    self.allow_interactions = 1;

  if(isDefined(level.interaction_manager)) {
    scripts\sp\interaction_manager::add_actor_to_manager();
    level.interaction_manager.data["registered_interactions"][var_0] = [];

    if(isDefined(var_3.scene["vo_lines_male"]))
      level.interaction_manager.data["registered_interactions"][var_0]["vo_lines_male"] = var_3.scene["vo_lines_male"];

    if(isDefined(var_3.scene["vo_lines_female"]))
      level.interaction_manager.data["registered_interactions"][var_0]["vo_lines_female"] = var_3.scene["vo_lines_female"];
  }

  if(isDefined(var_1)) {
    var_4 = undefined;

    if(isarray(self.lookat_anims["idle"]))
      var_5 = self.lookat_anims["idle"][0];
    else
      var_5 = self.lookat_anims["idle"];

    if(isstring(var_1))
      var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_4 = var_1;
    else if(isent(var_1))
      var_4 = var_1;
    else
      return;

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);

    if(!isDefined(self.is_cheap))
      self forceteleport(var_7, var_8);
    else {
      self.origin = var_7;
      self.angles = var_8;
    }

    if(!isDefined(self.is_cheap))
      self animmode("noclip");

    self.optional_struct = var_4;
  }

  if(!isDefined(self.anim_info))
    self.anim_info = spawnStruct();

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap))
      scripts\common\ai::gun_remove();
  }

  if(isDefined(self.is_cheap)) {
    if(!isDefined(var_2)) {
      thread interaction_process();
      thread interaction_end_cheap();
    } else {
      thread interaction_follow_process();
      thread interaction_end_cheap();
    }
  } else if(!isDefined(var_2))
    scripts\asm\asm_sp::asm_animcustom(::interaction_process, ::interaction_end);
  else
    scripts\asm\asm_sp::asm_animcustom(::interaction_follow_process, ::interaction_end);

  self waittill("reaction_end");
}

play_smart_interaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_smart_reaction");
  setup_interaction_head();
  var_8 = get_interaction(var_0).scene["trigger_radius"] * 2;
  thread scripts\sp\interaction_manager::reaction_look_distance_based(var_8);
  play_interaction_unknowntype(var_0, var_5, var_1, var_7);
  self waittill("interaction_done");
  thread scripts\engine\sp\utility::gesture_stop(0.7);
  self notify("stop_reaction_look");
  waittill_playeroutsideradius(var_6);
  play_looping_acknowlegdements(var_2, var_6);
}

#using_animtree("generic_human");

setup_interaction_head() {
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
}

play_interaction_unknowntype(var_0, var_1, var_2, var_3) {
  if(issubstr(var_0, "blended"))
    thread play_interaction_blended(var_0, var_1);
  else
    thread play_interaction(var_0, var_1);

  queue_interaction_vo(var_2, var_3);
}

queue_interaction_vo(var_0, var_1) {
  if(!isDefined(var_1))
    thread play_note_anim_vo(var_0);
  else {
    self waittill("playing_interaction_scene");
    scripts\engine\utility::delaythread(var_1, scripts\sp\interaction_manager::play_smart_dialog_if_exists, var_0);
  }
}

play_smart_simple_interaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  thread play_interaction_simple(var_0, var_5);
  scripts\sp\interaction_manager::play_gesture_reaction(85.0, 50.0, var_1, var_3, var_4);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var_6);
  var_7 = create_interaction_linebook(var_2);

  for(;;) {
    var_8 = var_7 get_interaction_vo_line();
    scripts\sp\interaction_manager::play_gesture_reaction(85.0, 50.0, var_8, var_3, var_4);
    waittill_playeroutsideradius(var_6);
  }
}

play_smart_basic_interaction(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  play_single_acknowledgement(var_0);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var_4);
  play_looping_acknowlegdements(var_1, var_4);
}

play_smart_silent_interaction(var_0) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  play_single_acknowledgement(undefined);
  waittill_playeroutsideradius(var_0);
  play_looping_acknowlegdements(undefined, var_0);
}

play_smart_simple_silent_interaction(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  thread play_interaction_simple(var_0, var_1);
  scripts\sp\interaction_manager::play_gesture_reaction(85.0, 50.0);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var_2);
  play_looping_acknowlegdements(undefined, var_2);
}

play_single_acknowledgement(var_0) {
  self endon("stop_smart_reaction");
  var_1 = 110;
  var_2 = 85;
  scripts\sp\interaction_manager::play_gesture_reaction(var_1, var_2, var_0);
}

play_looping_acknowlegdements(var_0, var_1) {
  self endon("death");
  self endon("stop_smart_reaction");

  if(!isDefined(var_1))
    var_1 = 300;

  if(isDefined(var_0)) {
    var_2 = create_interaction_linebook(var_0);

    for(;;) {
      var_3 = var_2 get_interaction_vo_line();
      play_single_acknowledgement(var_3);
      waittill_playeroutsideradius(var_1);
    }
  } else {
    for(;;) {
      play_single_acknowledgement();
      waittill_playeroutsideradius(var_1);
    }
  }
}

play_silent_acknowledgement() {
  var_0 = 110;
  var_1 = 85;
  scripts\sp\interaction_manager::play_gesture_reaction(var_0, var_1);
}

waittill_playeroutsideradius(var_0) {
  if(!isDefined(var_0))
    var_0 = 256;

  for(;;) {
    if(distance2d(self.origin, level.player.origin) >= var_0) {
      break;
    }

    waitframe();
  }
}

create_interaction_linebook(var_0) {
  if(!isarray(var_0) && !isstruct(var_0) && !isstring(var_0) && !isvector(var_0) && !var_0)
    return undefined;

  var_1 = spawnStruct();
  var_1.base = var_0;
  var_1.available = var_0;
  var_1.used = [];
  return var_1;
}

reset_interaction_linebook() {
  self.used = [];
  self.available = self.base;
}

get_interaction_vo_line() {
  var_0 = undefined;

  if(isDefined(self.available)) {
    if(self.available.size <= 0)
      reset_interaction_linebook();

    var_0 = self.available[randomint(self.available.size)];
    self.used = scripts\engine\utility::array_add(self.used, var_0);
    self.available = scripts\engine\utility::array_remove(self.available, var_0);
    return var_0;
  }
}

play_smart_basic_group_interaction(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 endon("death");
    var_5 endon("stop_smart_reaction");
    var_5.headknob = % head;
    var_5.scriptedtalkingknob = % scripted_talking;
    var_5.defaulttalk = % generic_talker_allies;
  }

  if(var_0.size != var_1.size || var_0.size != var_2.size) {
    return;
  }
  play_group_acknowledgement(var_0, var_1);
  var_7 = scripts\sp\interaction_manager::create_middle_ent(var_0);
  var_7 waittill_playeroutsideradius(var_3);
  play_group_looping_acknowledgements(var_0, var_2, var_3);
}

play_group_acknowledgement(var_0, var_1) {
  var_2 = 110;
  var_3 = 85;
  scripts\sp\interaction_manager::play_group_gesture_reaction(var_0, var_2, var_3, var_1);
}

play_group_looping_acknowledgements(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 endon("death");
    var_4 endon("stop_smart_reaction");
  }

  var_6 = create_group_interaction_linebook(var_1);
  var_7 = scripts\sp\interaction_manager::create_middle_ent(var_0);

  for(;;) {
    var_8 = get_interaction_vo_line_array(var_6);
    play_group_acknowledgement(var_0, var_8);
    var_7 waittill_playeroutsideradius(var_2);
  }
}

create_group_interaction_linebook(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = create_interaction_linebook(var_0[var_2]);

  return var_1;
}

get_interaction_vo_line_array(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = var_0[var_2] get_interaction_vo_line();

  return var_1;
}

play_interaction_with_states(var_0, var_1, var_2) {
  self endon("death");
  self notify("reaction_end");
  var_3 = get_state_interaction(var_0);
  setup_exit_states_for_interaction(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(self.animname))
    self.animname = "generic";

  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var_0;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions))
    self.allow_interactions = 1;

  if(isDefined(level.interaction_manager))
    scripts\sp\interaction_manager::add_actor_to_manager();

  if(isDefined(var_1)) {
    var_4 = undefined;

    if(isarray(var_3.scene["idle"]))
      var_5 = var_3.scene["idle"][0];
    else
      var_5 = var_3.scene["idle"];

    if(isstring(var_1))
      var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_4 = var_1;
    else if(isent(var_1))
      var_4 = var_1;
    else
      return;

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);

    if(!isDefined(self.is_cheap))
      self forceteleport(var_7, var_8);
    else {
      self.origin = var_7;
      self.angles = var_8;
    }

    if(!isDefined(self.is_cheap))
      self animmode("noclip");

    self.optional_struct = var_4;
  }

  if(!isDefined(self.anim_info))
    self.anim_info = spawnStruct();

  if(isDefined(var_3.scene["no_gun"])) {
    if(!isDefined(self.is_cheap) && !nullweapon(self.weapon))
      scripts\common\ai::gun_remove();
  }

  if(isDefined(self.is_cheap)) {
    thread interaction_process_for_states();
    thread interaction_end_cheap();
  } else
    scripts\asm\asm_sp::asm_animcustom(::interaction_process_for_states, scripts\sp\interaction_manager::stop_state_based_interaction);

  self waittill("reaction_end");
}

play_interaction_simple(var_0, var_1, var_2) {
  self endon("death");
  self endon("reaction_end");
  var_3 = get_interaction(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  self.lookat_anims = var_3.scene;

  if(!isDefined(self.animname))
    self.animname = "generic";

  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var_0;
  self.reaction_stop_anims = 1;
  self.optional_struct = undefined;
  self.optional_prop = undefined;

  if(!isDefined(self.allow_interactions))
    self.allow_interactions = 1;

  if(isDefined(level.interaction_manager))
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);

  if(isDefined(var_2))
    self.optional_prop = var_2;

  if(isDefined(var_1)) {
    var_4 = undefined;

    if(isarray(self.lookat_anims["idle"]))
      var_5 = self.lookat_anims["idle"][0];
    else
      var_5 = self.lookat_anims["idle"];

    if(isstring(var_1))
      var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_4 = var_1;
    else if(isent(var_1))
      var_4 = var_1;
    else
      return;

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);
    self.optional_struct = var_1;
  }

  if(!isDefined(self.is_cheap))
    self animmode("noclip");

  if(!isDefined(self.anim_info))
    self.anim_info = spawnStruct();

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap) && !nullweapon(self.weapon))
      scripts\common\ai::gun_remove();
  }

  if(isDefined(self.is_cheap)) {
    thread simple_interaction_idles();
    thread interaction_end_cheap();
  } else
    scripts\asm\asm_sp::asm_animcustom(::simple_interaction_idles, ::interaction_end);

  self waittill("reaction_end");
}

play_interaction_blended(var_0, var_1) {
  self endon("death");
  self notify("reaction_end");
  var_2 = get_interaction(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  reset_actor_interaction_values(var_2, var_0);
  add_actor_tointeractionmanager();
  move_actor_tointeractionposition(var_1);
  run_blended_interaction();
}

reset_actor_interaction_values(var_0, var_1) {
  if(!isDefined(self.animname))
    self.animname = "generic";

  self.lookat_anims = var_0.scene;
  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var_1;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions) || isDefined(self.allow_interactions) && !self.allow_interactions)
    self.allow_interactions = 1;

  if(!isDefined(self.anim_info))
    self.anim_info = spawnStruct();

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap))
      scripts\common\ai::gun_remove();
  }
}

add_actor_tointeractionmanager() {
  if(isDefined(level.interaction_manager))
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);
}

get_interaction_actor_lookatidle() {
  if(isarray(self.lookat_anims["idle"]))
    return self.lookat_anims["idle"][0];
  else
    return self.lookat_anims["idle"];
}

get_interaction_actor_optionalstruct(var_0) {
  var_1 = undefined;

  if(isstring(var_0))
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  else if(isstruct(var_0))
    var_1 = var_0;
  else if(isent(var_0))
    var_1 = var_0;
  else {}

  return var_1;
}

move_actor_tointeractionposition(var_0) {
  if(isDefined(var_0)) {
    var_1 = get_interaction_actor_lookatidle();
    var_2 = get_interaction_actor_optionalstruct(var_0);

    if(!isDefined(var_2)) {
      return;
    }
    self.optional_scripted_struct = var_0;
    var_3 = getstartorigin(var_2.origin, var_2.angles, var_1);
    var_4 = getstartangles(var_2.origin, var_2.angles, var_1);
    teleport_interaction_actor(var_3, var_4);

    if(!isDefined(self.is_cheap))
      self animmode("noclip");
  }
}

teleport_interaction_actor(var_0, var_1) {
  if(isDefined(self.is_cheap)) {
    self.origin = var_0;
    self.angles = var_1;
  } else
    self forceteleport(var_0, var_1);
}

run_blended_interaction() {
  if(isDefined(self.is_cheap)) {
    thread interaction_process_blended();
    thread interaction_end_cheap();
  } else
    scripts\asm\asm_sp::asm_animcustom(::interaction_process_blended, ::interaction_end);

  self waittill("reaction_end");
}

play_interaction_immediate(var_0, var_1) {
  self endon("death");
  var_2 = get_interaction(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  self.lookat_anims = var_2.scene;

  if(!isDefined(self.animname))
    self.animname = "generic";

  self.interaction_name = var_0;
  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;

  if(!isDefined(self.allow_interactions))
    self.allow_interactions = 1;

  if(isDefined(level.interaction_manager))
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);

  if(isDefined(var_1)) {
    var_3 = undefined;
    var_4 = self.lookat_anims["lastanim"];

    if(isstring(var_1))
      var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
    else if(isstruct(var_1))
      var_3 = var_1;
    else
      return;

    self.lookat_anims["optional_struct"] = var_3;
  }

  if(!isDefined(self.anim_info))
    self.anim_info = spawnStruct();

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap))
      scripts\common\ai::gun_remove();
  }

  thread scripts\asm\asm_sp::asm_animcustom(::interaction_immediate_process);
  self waittill("interaction_done");
}

clear_root() {
  self clearanim(%body, 0.2);
}

is_looking_at_range(var_0, var_1) {
  var_2 = anglesToForward(level.player.angles);
  var_3 = vectorNormalize(var_0.origin - level.player.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 >= var_1)
    return 1;
  else
    return 0;
}

interaction_immediate_process() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = self.lookat_anims["optional_struct"];
  var_1 = "single anim";

  if(!scripts\engine\utility::ent_flag_exist("interaction_end"))
    scripts\engine\utility::ent_flag_init("interaction_end");

  scripts\engine\utility::ent_flag_clear("interaction_end");
  var_2 = 0.25;
  var_3 = 0.25;

  if(isDefined(self.lookat_anims["common_name"]))
    thread scripts\sp\interaction_manager::trigger_interaction_common();

  if(!self.nearby_interaction_running) {
    self.is_playing_reaction = 1;
    self notify("playing_interaction");
    var_4 = undefined;

    if(isDefined(self.lookat_anims["interaction_position"]))
      var_4 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    else
      var_4 = vectortoangles(level.player.origin - self.origin);

    var_5 = abs(angleclamp(var_4 - self.angles[1]) - 360);
    var_6 = scripts\engine\math::normalize_value(0, 360, var_5);
    var_7 = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"])) {
      foreach(var_9 in self.lookat_anims["angles"]) {
        if(var_5 <= var_9) {
          var_7 = self.lookat_anims[var_9];
          break;
        }
      }
    }

    if(isDefined(var_0)) {
      var_11 = getstartorigin(var_0.origin, var_0.angles, var_7);
      var_12 = getstartangles(var_0.origin, var_0.angles, var_7);
      self forceteleport(var_11, var_12);
    }

    start_fakeactor_notetracks(var_7);
    self setflaggedanim(var_1, var_7, 1.0, var_2);
    var_13 = getanimlength(var_7);
    wait(var_13);
    self clearanim(var_7, var_3);
    level notify("interaction_done");
    self notify("interaction_done");
  }
}

interaction_follow_process() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["idle"])) {
    var_0 = self.lookat_anims["idle"][0];
    thread random_idle_controller();
  } else
    var_0 = self.lookat_anims["idle"];

  start_fakeactor_notetracks(var_0);
  self setflaggedanim("idle", var_0, 1, 0.5, 1);
  thread interaction_set_anim_movement("stop");
  var_1 = "single anim";

  if(!scripts\engine\utility::ent_flag_exist("scene_end"))
    scripts\engine\utility::ent_flag_init("scene_end");

  scripts\engine\utility::ent_flag_clear("scene_end");

  if(!scripts\engine\utility::ent_flag_exist("playing_interaction"))
    scripts\engine\utility::ent_flag_init("playing_interaction");

  scripts\engine\utility::ent_flag_clear("playing_interaction");
  var_2 = 0.11;
  var_3 = 0.25;
  var_4 = 0.25;
  var_5 = 350;
  var_6 = 0.45;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(self.lookat_anims["reacquire_left"]) || isDefined(self.lookat_anims["reacquire_right"]))
    var_7 = 1;

  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);

  for(;;) {
    if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
      if(self.sequential_scene)
        self.skip_interaction = 1;
      else
        self.skip_interaction = 0;
    } else
      self.skip_interaction = 0;

    var_10 = lengthsquared(level.player.origin - self.origin);
    var_11 = undefined;
    var_12 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_13 = undefined;

    for(;;) {
      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2)) {
        if(isDefined(self.lookat_anims["interaction_position"]))
          var_10 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
        else
          var_10 = lengthsquared(level.player.origin - self.origin);

        if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        } else if(self.lookat_anims["trigger_radius"] > 0 && var_10 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          var_14 = self.origin + anglestoup(self.angles) * 66;
          var_11 = vectorNormalize(level.player getEye() - var_14) * self.lookat_anims["trigger_radius"] + var_14;
          var_13 = scripts\engine\trace::ray_trace(var_14, var_11, self, var_12);

          if(isPlayer(var_13["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
            break;
          }
        }
      }

      waitframe();
    }

    if(isDefined(self.lookat_anims["common_name"]))
      thread scripts\sp\interaction_manager::trigger_interaction_common();

    self.is_playing_reaction = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_15 = undefined;

    if(isDefined(self.lookat_anims["interaction_position"]))
      var_15 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    else
      var_15 = vectortoangles(level.player.origin - self.origin);

    var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);
    var_17 = scripts\engine\math::normalize_value(0, 360, var_16);

    if(isDefined(self.lookat_anims["backseam"])) {
      if(var_17 >= 0 && var_17 <= 0.5)
        var_17 = var_17 + 0.5;
      else
        var_17 = var_17 - 0.5;
    }

    var_18 = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"]) && !self.sequential_scene) {
      foreach(var_20 in self.lookat_anims["angles"]) {
        if(var_16 <= var_20) {
          var_18 = self.lookat_anims[var_20];
          break;
        }
      }
    }

    if(isarray(var_18)) {
      if(isarray(var_18[0])) {
        var_22 = self.anim_sequential_counter;
        var_23 = var_18[0][var_22][0];
      } else
        var_23 = var_18[0];
    } else
      var_23 = var_18;

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var_23);
      self setflaggedanimknob(var_1, var_23, 1, var_3, 1);
      self.is_playing_reaction = 1;
    }

    if(!self.skip_interaction) {
      if(isarray(var_18)) {
        if(isarray(var_18[0]) && !isarray(self.lookat_anims["diff"])) {
          var_22 = self.anim_sequential_counter;
          var_24 = var_18[0][var_22];
          thread set_sequential_wait_time(var_24);
          thread play_anim_vo_sequential(var_24);
        } else if(var_18.size > 1)
          thread play_anim_vo_sequential(var_18);
      }
    }

    if(isDefined(self.lookat_anims["reaction_func"]))
      self thread[[self.lookat_anims["reaction_func"]]]();

    var_25 = getanimlength(var_23);
    var_25 = var_25 - var_4;

    if(var_25 < 0)
      var_25 = 0;

    if(!self.skip_interaction)
      wait(var_25);

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(self.lookat_anims["follow"]);
      self setflaggedanimlimited(var_1, self.lookat_anims["follow"], 1, 0.25, 1);
      self setanimtime(self.lookat_anims["follow"], var_17);
      self setanimknob(self.lookat_anims["ring"], 1, var_4, 1);
    }

    var_26 = undefined;

    if(isarray(self.lookat_anims["diff"])) {
      var_22 = self.anim_sequential_counter;
      var_26 = self.lookat_anims["diff"][var_22];
    } else
      var_26 = self.lookat_anims["diff"];

    start_fakeactor_notetracks(var_26);
    self setflaggedanimlimited(var_1, var_26, 1, 0.25, 1);
    self.is_playing_reaction = 1;

    if(!self.skip_interaction)
      self setanimlimited(self.lookat_anims["additive"], 1, var_4, 1);

    scripts\engine\utility::delaythread(getanimlength(var_26), scripts\engine\utility::ent_flag_set, "scene_end");
    scripts\engine\utility::ent_flag_set("playing_interaction");
    thread scripts\engine\utility::ent_flag_clear_delayed("playing_interaction", getanimlength(var_26));
    var_27 = var_17;

    for(;;) {
      var_28 = distance2d(level.player.origin, self.origin);

      if((var_28 >= var_5 || scripts\engine\utility::ent_flag("scene_end")) && !isDefined(var_7)) {
        var_10 = lengthsquared(level.player.origin - self.origin);

        if(var_10 < squared(self.lookat_anims["trigger_radius"])) {
          var_14 = self.origin + anglestoup(self.angles) * 66;
          var_11 = vectorNormalize(level.player getEye() - var_14) * self.lookat_anims["trigger_radius"] + var_14;
          var_13 = scripts\engine\trace::ray_trace(var_14, var_11, self, var_12);

          if(isPlayer(var_13["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
            if(isarray(self.lookat_anims["diff"]) && self.anim_sequential_counter < self.lookat_anims["diff"].size - 1) {
              self.sequential_scene = 1;
              scripts\engine\utility::ent_flag_clear("scene_end");
              self.anim_sequential_counter = self.anim_sequential_counter + 1;
              self clearanim(var_26, 0.15);
              self.is_playing_reaction = 0;
              break;
            }
          }
        }

        if(isDefined(self.lookat_anims["exitangles"])) {
          var_29 = self.lookat_anims["exitangles_anims"]["lastexitanim"];

          if(isDefined(self.lookat_anims["interaction_position"]))
            var_15 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
          else
            var_15 = vectortoangles(level.player.origin - self.origin);

          var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);

          foreach(var_31 in self.lookat_anims["exitangles"]) {
            if(var_16 <= var_31) {
              var_29 = self.lookat_anims["exitangles_anims"][var_31];
              break;
            }
          }

          start_fakeactor_notetracks(var_29);
          self setflaggedanimknob(var_1, var_29, 1, var_6, 1);
          wait(getanimlength(var_29));

          if(isDefined(self.lookat_anims["end_idle"])) {
            if(isarray(var_18[0])) {
              if(self.anim_sequential_counter >= var_18[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
                self setflaggedanimknob(var_1, self.lookat_anims["end_idle"], 1, var_6, 1);
              } else {
                start_fakeactor_notetracks(var_0);
                self setflaggedanimknob(var_1, var_0, 1, var_6, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
              self setflaggedanimknob(var_1, self.lookat_anims["end_idle"], 1, var_6, 1);
            }
          } else {
            start_fakeactor_notetracks(var_0);
            self setflaggedanimknob(var_1, var_0, 1, var_6, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims["diff"])) {
            if(self.anim_sequential_counter < self.lookat_anims["diff"].size) {
              scripts\engine\utility::ent_flag_clear("scene_end");
              self clearanim(self.lookat_anims["follow"], 0.1);
              self clearanim(self.lookat_anims["ring"], 0.1);
              self.anim_sequential_counter = self.anim_sequential_counter + 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims["diff"].size) {
              self.is_playing_reaction = 0;
              var_9 = 1;

              if(!isDefined(self.lookat_anims["allow_multi_use"]))
                self waittill("forever");
            }
          } else {
            var_9 = 1;

            if(!isDefined(self.lookat_anims["allow_multi_use"]))
              self waittill("forever");
          }

          self.is_playing_reaction = 0;
          break;
        } else {
          if(isDefined(self.lookat_anims["end_idle"])) {
            if(isarray(var_18[0])) {
              if(self.anim_sequential_counter >= var_18[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
                self setflaggedanimknob(var_1, self.lookat_anims["end_idle"], 1, var_6, 1);
              } else {
                start_fakeactor_notetracks(var_0);
                self setflaggedanimknob(var_1, var_0, 1, var_6, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
              self setflaggedanimknob(var_1, self.lookat_anims["end_idle"], 1, var_6, 1);
            }
          } else {
            start_fakeactor_notetracks(var_0);
            self setflaggedanimknob(var_1, var_0, 1, var_6, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims["diff"])) {
            if(self.anim_sequential_counter < self.lookat_anims["diff"].size) {
              scripts\engine\utility::ent_flag_clear("scene_end");
              self clearanim(self.lookat_anims["follow"], 0.1);
              self clearanim(self.lookat_anims["ring"], 0.1);
              self.anim_sequential_counter = self.anim_sequential_counter + 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims["diff"].size) {
              self.is_playing_reaction = 0;
              var_9 = 1;

              if(!isDefined(self.lookat_anims["allow_multi_use"]))
                self waittill("forever");
            }
          } else {
            var_9 = 1;

            if(!isDefined(self.lookat_anims["allow_multi_use"]))
              self waittill("forever");
          }

          self.is_playing_reaction = 0;
          break;
        }
      }

      if(isDefined(self.lookat_anims["interaction_position"]))
        var_15 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      else
        var_15 = vectortoangles(level.player.origin - self.origin);

      var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);
      var_17 = scripts\engine\math::normalize_value(0, 360, var_16);

      if(self.followoff)
        var_17 = 0;

      if(isDefined(self.lookat_anims["backseam"])) {
        if(var_17 >= 0 && var_17 <= 0.5)
          var_17 = var_17 + 0.5;
        else
          var_17 = var_17 - 0.5;

        var_27 = var_27 + (var_17 - var_27) * var_2;
      } else
        var_27 = var_27 + (var_17 - var_27) * var_2;

      if(isDefined(var_7)) {
        var_33 = vectorNormalize(level.player.origin - self.origin);
        var_33 = scripts\engine\utility::flatten_vector(var_33, anglestoup(self.angles));
        var_34 = anglesToForward(self.angles);
        var_35 = vectordot(var_33, var_34);
        var_16 = acos(var_35);
        var_36 = vectorcross(var_33, var_34);

        if(vectordot(var_36, anglestoup(self.angles)) < 0)
          var_16 = var_16 * -1;

        var_37 = 0;

        if(var_16 >= 90.0 && !var_37 && !scripts\engine\utility::ent_flag("playing_interaction")) {
          var_37 = 1;
          start_fakeactor_notetracks(self.lookat_anims["reacquire_right"]);
          self clearanim(%body, 0.25);
          self setflaggedanimrestart(var_1, self.lookat_anims["reacquire_right"], 1.0, 0.25);
          wait(clamp(getanimlength(self.lookat_anims["reacquire_right"]) - 0.25, 0, 100));
          self clearanim(self.lookat_anims["reacquire_right"], 0.25);
        } else if(var_16 < -90.0 && !var_37 && !scripts\engine\utility::ent_flag("playing_interaction")) {
          var_37 = 1;
          start_fakeactor_notetracks(self.lookat_anims["reacquire_left"]);
          self clearanim(%body, 0.25);
          self setflaggedanimrestart(var_1, self.lookat_anims["reacquire_left"], 1.0, 0.25);
          wait(clamp(getanimlength(self.lookat_anims["reacquire_left"]) - 0.25, 0, 100));
          self clearanim(self.lookat_anims["reacquire_left"], 0.25);
        } else
          set_time_via_rate(self.lookat_anims["follow"], var_27);

        if(var_37) {
          if(isDefined(self.lookat_anims["interaction_position"]))
            var_15 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
          else
            var_15 = vectortoangles(level.player.origin - self.origin);

          var_16 = abs(angleclamp(var_15 - self.angles[1]) - 360);
          var_17 = scripts\engine\math::normalize_value(0, 360, var_16);
          start_fakeactor_notetracks(self.lookat_anims["follow"]);
          self setflaggedanimlimited(var_1, self.lookat_anims["follow"], 1, 0.25, 1);
          self setanimtime(self.lookat_anims["follow"], 0.5);
          self setanimknob(self.lookat_anims["ring"], 1, var_4, 1);

          if(!scripts\engine\utility::ent_flag("playing_interaction") && !scripts\engine\utility::ent_flag("scene_end")) {
            start_fakeactor_notetracks(self.lookat_anims["diff"]);
            self setflaggedanimlimited(var_1, self.lookat_anims["diff"], 1, 0.05, 1);
          }

          self setanimlimited(self.lookat_anims["additive"], 1, var_4, 1);
          var_27 = 0.5;
        }
      } else
        set_time_via_rate(self.lookat_anims["follow"], var_27);

      waitframe();
    }

    waitframe();
  }
}

interaction_process() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["idle"])) {
    var_0 = self.lookat_anims["idle"][0];
    thread random_idle_controller();
  } else
    var_0 = self.lookat_anims["idle"];

  start_fakeactor_notetracks(var_0);
  self setflaggedanim("idle", var_0, 1, 0.05, 1);
  thread interaction_set_anim_movement("stop");
  var_1 = "single anim";

  if(!scripts\engine\utility::ent_flag_exist("scene_end"))
    scripts\engine\utility::ent_flag_init("scene_end");

  scripts\engine\utility::ent_flag_clear("scene_end");
  var_2 = 0.11;

  if(isDefined(self.lookat_anims["lookat_lerp"]))
    var_2 = self.lookat_anims["lookat_lerp"];

  var_3 = 0.25;

  if(isDefined(self.lookat_anims["initial_reaction_blendtime"]))
    var_3 = self.lookat_anims["initial_reaction_blendtime"];

  var_4 = 0.25;

  if(isDefined(self.lookat_anims["lookat_follow_blendtime"]))
    var_4 = self.lookat_anims["lookat_follow_blendtime"];

  var_5 = 350;

  if(isDefined(self.lookat_anims["lookat_end_distance"]))
    var_5 = self.lookat_anims["lookat_end_distance"];

  var_6 = 0.45;

  if(isDefined(self.lookat_anims["lookat_end_blendtime"]))
    var_6 = self.lookat_anims["lookat_end_blendtime"];

  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);

  for(;;) {
    if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
      if(self.sequential_scene)
        self.skip_interaction = 1;
      else
        self.skip_interaction = 0;
    } else
      self.skip_interaction = 0;

    var_7 = lengthsquared(level.player.origin - self.origin);
    var_8 = undefined;
    var_9 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_10 = undefined;

    for(;;) {
      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2)) {
        if(isDefined(self.lookat_anims["interaction_position"]))
          var_7 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
        else
          var_7 = lengthsquared(level.player.origin - self.origin);

        if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        } else if(self.lookat_anims["trigger_radius"] > 0 && var_7 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          var_11 = self.origin + anglestoup(self.angles) * 66;
          var_8 = vectorNormalize(level.player getEye() - var_11) * self.lookat_anims["trigger_radius"] + var_11;
          var_10 = scripts\engine\trace::ray_trace(var_11, var_8, self, var_9);

          if(isPlayer(var_10["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
            break;
          }
        }
      }

      waitframe();
    }

    if(isDefined(self.lookat_anims["common_name"]))
      thread scripts\sp\interaction_manager::trigger_interaction_common();

    self.is_playing_reaction = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_12 = undefined;

    if(isDefined(self.lookat_anims["interaction_position"]))
      var_12 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    else
      var_12 = vectortoangles(level.player.origin - self.origin);

    var_13 = abs(angleclamp(var_12 - self.angles[1]) - 360);
    var_14 = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"])) {
      foreach(var_16 in self.lookat_anims["angles"]) {
        if(var_13 <= var_16) {
          var_14 = self.lookat_anims[var_16];
          break;
        }
      }
    }

    if(isarray(var_14)) {
      if(isarray(var_14[0]) && self.anim_sequential_counter < var_14[0].size) {
        var_18 = self.anim_sequential_counter;
        var_19 = var_14[0][var_18][0];
      } else
        var_19 = var_14[0];
    } else
      var_19 = var_14;

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var_19);
      self setflaggedanimknob(var_1, var_19, 1, var_3, 1);
      self.is_playing_reaction = 1;
    }

    level thread scripts\sp\interaction_manager::interaction_cooldown_timer(self);

    if(isDefined(self.lookat_anims["scene"])) {
      if(isDefined(self.lookat_anims["interaction_position"]))
        var_12 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      else
        var_12 = vectortoangles(level.player.origin - self.origin);

      var_13 = abs(angleclamp(var_12 - self.angles[1]) - 360);

      if(self.skip_interaction)
        wait 0.0;
      else
        wait(getanimlength(var_19));

      if(isarray(self.lookat_anims["scene"])) {
        var_20 = self.scene_sequential_sounter;
        start_fakeactor_notetracks(self.lookat_anims["scene"][var_20]);
        self setflaggedanimknob(var_1, self.lookat_anims["scene"][var_20], 1, var_4, 1);
        wait(getanimlength(self.lookat_anims["scene"][var_20]));
        self.scene_sequential_sounter = self.scene_sequential_sounter + 1;
        self.sequential_scene = 1;
      } else {
        start_fakeactor_notetracks(self.lookat_anims["scene"]);
        self setflaggedanimknob(var_1, self.lookat_anims["scene"], 1, var_4, 1);
        wait(getanimlength(self.lookat_anims["scene"]));
      }
    }

    if(isDefined(self.lookat_anims["exitangles"])) {
      if(isDefined(self.lookat_anims["interaction_position"]))
        var_12 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      else
        var_12 = vectortoangles(level.player.origin - self.origin);

      var_13 = abs(angleclamp(var_12 - self.angles[1]) - 360);
      var_21 = self.lookat_anims["exitangles_anims"]["lastexitanim"];

      foreach(var_23 in self.lookat_anims["exitangles"]) {
        if(var_13 <= var_23) {
          var_21 = self.lookat_anims["exitangles_anims"][var_23];
          break;
        }
      }

      start_fakeactor_notetracks(var_21);
      self setflaggedanimknob(var_1, var_21, 1, var_6, 1);
      wait(getanimlength(var_21));

      if(isDefined(self.lookat_anims["end_idle"])) {
        if(isarray(var_14[0])) {
          if(self.anim_sequential_counter >= var_14[0].size) {
            start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
            self setflaggedanimknob(var_1, self.lookat_anims["end_idle"], 1, var_6, 1);
          } else {
            start_fakeactor_notetracks(var_0);
            self setflaggedanimknob(var_1, var_0, 1, var_6, 1);
          }
        } else {
          start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
          self setflaggedanimknob(var_1, self.lookat_anims["end_idle"], 1, var_6, 1);
        }
      } else {
        start_fakeactor_notetracks(var_0);
        self setflaggedanimknob(var_1, var_0, 1, var_6, 1);
      }

      self.is_playing_reaction = 0;

      if(!isDefined(self.lookat_anims["allow_multi_use"]))
        self waittill("forever");
    }

    if(!self.skip_interaction) {
      if(isarray(var_14)) {
        if(isarray(var_14[0]) && self.anim_sequential_counter < var_14[0].size) {
          var_18 = self.anim_sequential_counter;
          var_25 = var_14[0][var_18];
          thread set_sequential_wait_time(var_25);
          thread play_anim_vo_sequential(var_25);
        } else if(var_14.size > 1)
          thread play_anim_vo_sequential(var_14);
      }
    }

    if(isDefined(self.lookat_anims["reaction_func"]))
      self[[self.lookat_anims["reaction_func"]]]();

    var_26 = getanimlength(var_19);
    wait(var_26);

    if(isDefined(self.lookat_anims["end_idle"])) {
      if(isarray(var_14)) {
        if(isarray(var_14[0])) {
          start_fakeactor_notetracks();

          if(self.anim_sequential_counter >= var_14[0].size - 1)
            self setflaggedanimknoball(var_1, self.lookat_anims["end_idle"], %body, 1, var_6, 1);
          else
            self setflaggedanimknoball(var_1, var_0, %body, 1, var_6, 1);
        } else
          self setflaggedanimknoball(var_1, self.lookat_anims["end_idle"], %body, 1, var_6, 1);
      } else {
        start_fakeactor_notetracks();
        self setflaggedanimknoball(var_1, self.lookat_anims["end_idle"], %body, 1, var_6, 1);
      }
    } else {
      start_fakeactor_notetracks();
      self setflaggedanimknoball(var_1, var_0, %body, 1, var_6, 1);
    }

    self.anim_sequential_counter = self.anim_sequential_counter + 1;
    level notify("interaction_done");
    self notify("interaction_done");

    if(isarray(var_14)) {
      if(isarray(var_14[0]) && self.anim_sequential_counter < var_14[0].size) {
        var_27 = self.sequential_loop_padding + self.sequential_wait_time - getanimlength(var_19);
        var_28 = self.sequential_loop_padding + self.sequential_wait_time + getanimlength(var_19);
        var_29 = clamp(var_27, 0, var_28);
        wait(var_29);
        self clearanim(var_19, 0.1);
        self.is_playing_reaction = 0;
      } else {
        self.is_playing_reaction = 0;

        if(!isDefined(self.lookat_anims["allow_multi_use"]))
          self waittill("forever");
      }
    } else {
      self.is_playing_reaction = 0;

      if(!isDefined(self.lookat_anims["allow_multi_use"]))
        self waittill("forever");
    }

    waitframe();
  }
}

interaction_process_for_states() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_0 = undefined;
  self.random_idle_playing = 0;
  var_1 = get_state_interaction(self.interaction_name);

  if(!isDefined(var_1)) {
    return;
  }
  var_1 = var_1.scene;
  var_2 = undefined;

  if(isarray(var_1["idle"])) {
    if(isDefined(self.gender) && issubstr(self.gender, "female"))
      var_2 = "idle_female";
    else
      var_2 = "idle";

    var_0 = var_1[var_2][0];
    thread random_idle_controller_stateful();
  } else {
    if(isDefined(self.gender) && issubstr(self.gender, "female"))
      var_2 = "idle_female";
    else
      var_2 = "idle";

    var_0 = var_1[var_2];
  }

  var_3 = "single anim";
  start_fakeactor_notetracks(var_0);
  self setflaggedanim(var_3, var_0, 1, 0.5, 1);
  self setanimtime(var_0, randomfloat(1));
  thread interaction_set_anim_movement("stop");
  thread play_anim_shared_vo();

  if(!scripts\engine\utility::ent_flag_exist("scene_end"))
    scripts\engine\utility::ent_flag_init("scene_end");

  scripts\engine\utility::ent_flag_clear("scene_end");
  var_4 = 0.11;
  var_5 = 0.25;
  var_6 = 0.25;
  var_7 = 350;
  var_8 = 0.45;
  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, var_1["trigger_radius"], var_1["trigger_radius"]);

  for(;;) {
    var_9 = lengthsquared(level.player.origin - self.origin);
    var_10 = undefined;
    var_11 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_12 = undefined;

    for(;;) {
      if(!isDefined(self.reaction_state) || isDefined(self.reaction_state) && self.reaction_state != "busy" && self.reaction_state != "nag") {
        if(scripts\sp\interaction_manager::can_play_nearby_interaction(var_1["trigger_radius"] * 2)) {
          if(isDefined(var_1["interaction_position"]))
            var_9 = lengthsquared(var_1["interaction_position"] - self.origin);
          else
            var_9 = lengthsquared(level.player.origin - self.origin);

          if(isDefined(var_1["interaction_trigger_override"])) {
            break;
          } else if(var_1["trigger_radius"] > 0 && var_9 < squared(var_1["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
            var_13 = self.origin + anglestoup(self.angles) * 66;
            var_10 = vectorNormalize(level.player getEye() - var_13) * var_1["trigger_radius"] + var_13;
            var_12 = scripts\engine\trace::ray_trace(var_13, var_10, self, var_11);

            if(isPlayer(var_12["entity"]) || isDefined(var_1["interaction_trigger_override"])) {
              break;
            }
          }
        }
      }

      waitframe();
    }

    self.is_playing_reaction = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_14 = undefined;

    if(isDefined(var_1["interaction_position"]))
      var_14 = vectortoangles(var_1["interaction_position"] - self.origin);
    else
      var_14 = vectortoangles(level.player.origin - self.origin);

    var_15 = abs(angleclamp(var_14 - self.angles[1]) - 360);
    var_16 = "lastanim";

    if(isDefined(var_1["angles"])) {
      foreach(var_18 in var_1["angles"]) {
        if(var_15 <= var_18) {
          var_16 = var_18;
          break;
        }
      }
    }

    if(level.state_interactions[self.interaction_name].scene[var_16].size < 1) {
      level.state_interactions[self.interaction_name].scene[var_16] = level.state_interactions[self.interaction_name].scene["angle_" + scripts\engine\utility::string(var_16) + "_spent"];
      level.state_interactions[self.interaction_name].scene["angle_" + var_16 + "_spent"] = [];
    }

    var_20 = randomint(level.state_interactions[self.interaction_name].scene[var_16].size);
    var_21 = level.state_interactions[self.interaction_name].scene[var_16][var_20];
    start_fakeactor_notetracks(var_21);
    self setflaggedanimknob(var_3, var_21, 1, var_5, 1);
    self.is_playing_reaction = 1;
    thread scripts\sp\interaction_manager::interaction_reboot_timer();
    wait(getanimlength(var_21));
    level.state_interactions[self.interaction_name].scene["angle_" + var_16 + "_spent"] = scripts\engine\utility::array_add(level.state_interactions[self.interaction_name].scene["angle_" + var_16 + "_spent"], var_21);
    level.state_interactions[self.interaction_name].scene[var_16] = scripts\engine\utility::array_remove(level.state_interactions[self.interaction_name].scene[var_16], var_21);

    if(isDefined(var_1["exitangles"])) {
      if(isDefined(var_1["interaction_position"]))
        var_14 = vectortoangles(var_1["interaction_position"] - self.origin);
      else
        var_14 = vectortoangles(level.player.origin - self.origin);

      var_15 = abs(angleclamp(var_14 - self.angles[1]) - 360);
      var_22 = "lastexitanim";

      foreach(var_24 in var_1["exitangles"]) {
        if(var_15 <= var_24) {
          var_22 = var_24;
          break;
        }
      }

      if(level.state_interactions[self.interaction_name].scene[var_22].size < 1) {
        level.state_interactions[self.interaction_name].scene[var_22][var_22] = level.state_interactions[self.interaction_name].scene[var_22]["exit_angle_" + scripts\engine\utility::string(var_22) + "_spent"];
        level.state_interactions[self.interaction_name].scene[var_22]["exit_angle_" + scripts\engine\utility::string(var_22) + "_spent"] = [];
      }

      var_20 = randomint(level.state_interactions[self.interaction_name].scene[var_22].size);
      var_26 = level.state_interactions[self.interaction_name].scene[var_22][var_20];
      start_fakeactor_notetracks(var_26);
      self setflaggedanimknob(var_3, var_26, 1, var_8, 1);
      wait(getanimlength(var_26));
      level.state_interactions[self.interaction_name].scene[var_22] = scripts\engine\utility::array_remove(level.state_interactions[self.interaction_name].scene[var_22], var_26);
    }

    start_fakeactor_notetracks(var_0);
    self setflaggedanimknob(var_3, var_0, 1, var_8, 1);
    self.is_playing_reaction = 0;

    if(isDefined(var_1["reaction_func"]))
      self[[var_1["reaction_func"]]]();

    level notify("interaction_done");
    thread scripts\sp\interaction_manager::set_reaction_state("busy");
    waitframe();
    level waittill("forever");
  }
}

interaction_process_blended() {
  self endon("death");
  self endon("reaction_end");
  initialize_blending_actor();
  var_0 = 0.11;
  var_1 = 0.25;
  var_2 = 0.25;
  var_3 = 350;
  var_4 = setup_blend_interaction_idles();
  var_5 = "single anim";

  for(;;) {
    self.skip_interaction = is_performing_sequential_scene();
    blended_interaction_tracecheck();
    self.is_playing_reaction = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");

    if(isDefined(self.lookat_anims["common_name"]))
      thread scripts\sp\interaction_manager::trigger_interaction_common();

    play_blended_interaction_anims();
    waitframe();
  }
}

initialize_blending_actor() {
  self stopanimScripted();
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  if(!scripts\engine\utility::ent_flag_exist("scene_end"))
    scripts\engine\utility::ent_flag_init("scene_end");

  scripts\engine\utility::ent_flag_clear("scene_end");
  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);
}

setup_blend_interaction_idles() {
  var_0 = get_interaction_starting_idle();
  self.random_idle_playing = 0;
  start_fakeactor_notetracks(var_0);
  self setflaggedanim("single anim", var_0, 1, 0.05, 1);
  thread interaction_set_anim_movement("stop");
}

get_interaction_starting_idle() {
  var_0 = undefined;

  if(isarray(self.lookat_anims["idle"]))
    var_0 = self.lookat_anims["idle"][0];
  else
    var_0 = self.lookat_anims["idle"];

  return var_0;
}

is_performing_sequential_scene() {
  var_0 = undefined;

  if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
    if(self.sequential_scene)
      var_0 = 1;
    else
      var_0 = 0;
  } else
    var_0 = 0;

  return var_0;
}

blended_interaction_tracecheck() {
  var_0 = lengthsquared(level.player.origin - self.origin);
  var_1 = undefined;
  var_2 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_3 = undefined;

  for(;;) {
    var_4 = scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2);

    if(var_4) {
      if(isDefined(self.lookat_anims["interaction_position"]))
        var_0 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
      else
        var_0 = lengthsquared(level.player.origin - self.origin);

      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      } else if(self.lookat_anims["trigger_radius"] > 0 && var_0 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
        var_5 = self.origin + anglestoup(self.angles) * 66;
        var_1 = vectorNormalize(level.player getEye() - var_5) * self.lookat_anims["trigger_radius"] + var_5;
        var_3 = scripts\engine\trace::ray_trace(var_5, var_1, self, var_2);

        if(isPlayer(var_3["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        }
      }
    }

    waitframe();
  }
}

play_blended_interaction_anims() {
  initialize_blended_interaction_anims();
  var_0 = 0;
  var_1 = 0;
  var_2 = gettime() / 1000;
  var_3 = getanimlength(self.lookat_anims["fwd_anim"]);

  while(gettime() / 1000 - var_2 < var_3) {
    var_4 = vectorNormalize(level.player.origin - self.origin);
    var_5 = anglesToForward(self.angles);
    var_6 = anglesToForward(self.angles) * -1;
    var_7 = anglestoright(self.angles);
    var_8 = anglestoright(self.angles) * -1;
    var_9 = anglestoup(self.angles);
    var_10 = clamp(vectordot(var_4, var_5), 0.005, 1);
    var_11 = clamp(vectordot(var_4, var_7), 0.005, 1);
    var_12 = clamp(vectordot(var_4, var_8), 0.005, 1);
    var_13 = clamp(vectordot(var_4, var_6), 0.005, 1);
    self setanimlimited(self.lookat_anims["right_anim"], var_11, 0.2);
    self setanimlimited(self.lookat_anims["left_anim"], var_12, 0.2);
    self setflaggedanimlimited("single anim", self.lookat_anims["fwd_anim"], var_10 + 0.005, 0.2);
    var_14 = 1;

    if(scripts\engine\math::anglebetweenvectorssigned(var_5, var_4, var_9) > 0)
      var_14 = 0;

    if(var_14) {
      var_1 = scripts\engine\math::lerp(var_1, var_13, 0.1);
      var_0 = scripts\engine\math::lerp(var_0, 0.005, 0.1);
    } else {
      var_1 = scripts\engine\math::lerp(var_1, 0.005, 0.1);
      var_0 = scripts\engine\math::lerp(var_0, var_13, 0.1);
    }

    self setanimlimited(self.lookat_anims["back_right_anim"], var_1, 0.2);
    self setanimlimited(self.lookat_anims["back_left_anim"], var_0, 0.2);
    waitframe();
  }

  var_15 = 0.45;
  end_blended_interaction_anims(var_15);
  play_interaction_endidle(var_15);
}

initialize_blended_interaction_anims() {
  var_0 = undefined;
  var_0 = vectortoangles(level.player.origin - self.origin);
  self.is_playing_reaction = 1;
  level thread scripts\sp\interaction_manager::interaction_cooldown_timer(self);
  self setanimlimited(self.lookat_anims["interaction_blend_parent"], 1.0, 0.2);
  var_1 = get_interaction_starting_idle();
  self clearanim(var_1, 0.2);
  self clearanim(%head, 0.2);
  start_fakeactor_notetracks(self.lookat_anims["fwd_anim"]);
  self setflaggedanimlimited("single anim", self.lookat_anims["fwd_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["right_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["left_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["back_right_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["back_left_anim"], 0.005, 0.05);
}

end_blended_interaction_anims(var_0) {
  self.reaction_blend_end = undefined;
  self clearanim(self.lookat_anims["fwd_anim"], var_0);
  self clearanim(self.lookat_anims["right_anim"], var_0);
  self clearanim(self.lookat_anims["left_anim"], var_0);
  self clearanim(self.lookat_anims["back_right_anim"], var_0);
  self clearanim(self.lookat_anims["back_left_anim"], var_0);
  level notify("interaction_done");
  self notify("interaction_done");
  self.is_playing_reaction = 0;
}

play_interaction_endidle(var_0) {
  for(;;) {
    var_1 = undefined;

    if(isDefined(self.lookat_anims["end_idle"])) {
      var_1 = self.lookat_anims["end_idle"];
      start_fakeactor_notetracks(var_1);
      self setanimtime(var_1, 0);
      self setflaggedanimknoball("single anim", var_1, %body, 1, var_0, 1);
    } else {
      var_1 = get_interaction_starting_idle();
      start_fakeactor_notetracks(var_1);
      self setanimtime(var_1, 0);
      self setflaggedanimknoball("single anim", var_1, %body, 1, var_0, 1);
    }

    wait(getanimlength(var_1));
  }
}

simple_interaction_idles() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_0 = get_interaction(self.interaction_name);

  if(!scripts\engine\utility::ent_flag_exist("hold_simple_idles"))
    scripts\engine\utility::ent_flag_init("hold_simple_idles");
  else
    scripts\engine\utility::ent_flag_clear("hold_simple_idles");

  if(!isarray(var_0.scene["idle"])) {
    return;
  }
  if(isarray(var_0.scene["idle"]) && var_0.scene["idle"].size <= 1) {
    return;
  }
  var_1 = [];
  var_2 = var_0.scene["idle"];
  var_3 = var_2[0];
  var_2 = scripts\engine\utility::array_remove_index(var_2, 0);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_0.scene["idle_prop"]) && isDefined(self.optional_prop)) {
    var_4 = [];
    var_0.scene["spent_array_prop"] = var_4;
    var_6 = var_0.scene["idle_prop"];
    var_5 = var_6[0];
    var_6 = scripts\engine\utility::array_remove_index(var_6, 0);
    var_7 = var_6;
    var_6 = undefined;
  }

  var_8 = var_2;
  var_2 = undefined;
  thread clear_root();
  interaction_set_anim_movement("stop");

  for(;;) {
    if(isDefined(self.optional_struct))
      _set_node_relative_anim_actor(self.optional_struct, var_3);

    start_fakeactor_notetracks(var_3);
    self setflaggedanimknob("single anim", var_3, 1, 0.2, 1);
    thread scripts\asm\gesture\script_funcs::ai_lookat_release();

    if(isDefined(self.optional_prop))
      thread _simple_interaction_prop_start(var_5);

    wait(getanimlength(var_3) * randomintrange(1, 2));

    while(scripts\engine\utility::ent_flag("hold_simple_idles"))
      wait(getanimlength(var_3));

    if(var_8.size <= 0) {
      var_8 = var_1;
      var_1 = [];
    }

    var_9 = randomint(var_8.size);
    var_10 = var_8[var_9];
    var_1 = scripts\engine\utility::array_add(var_1, var_10);
    var_8 = scripts\engine\utility::array_remove_index(var_8, var_9);

    if(isDefined(self.optional_prop)) {
      if(var_7.size <= 0) {
        var_7 = var_4;
        var_4 = [];
      }

      var_11 = var_7[var_9];
      var_4 = scripts\engine\utility::array_add(var_4, var_11);
      var_7 = scripts\engine\utility::array_remove_index(var_7, var_9);
      thread _simple_interaction_prop_random_anim(var_11);
    }

    self clearanim(var_3, 0.2);

    if(isDefined(self.optional_struct))
      _set_node_relative_anim_actor(self.optional_struct, var_10);

    start_fakeactor_notetracks(var_10);
    self setflaggedanimknob("single anim", var_10, 1, 0.2, 1);
    thread scripts\asm\gesture\script_funcs::ai_lookat_hold();
    wait(getanimlength(var_10));
    self clearanim(var_10, 0.2);

    if(isDefined(self.optional_prop))
      thread _simple_interaction_prop_clear();

    waitframe();
  }
}

_set_node_relative_anim_actor(var_0, var_1) {
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);

  if(!isDefined(self.is_cheap)) {
    self forceteleport(var_2, var_3, 100000);
    wait 0.05;
  } else {
    self.origin = var_2;
    self.angles = var_3;
    self dontinterpolate();
    wait 0.05;
  }
}

#using_animtree("script_model");

_simple_interaction_prop_random_anim(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
  self.optional_prop setanimknob(var_0, 1, 0.2, 1);
  self.optional_prop.curr_anim = var_0;
}

_simple_interaction_prop_start(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop setanimknob(var_0, 1, 0.2, 1);
  self.optional_prop.curr_anim = var_0;
}

_simple_interaction_prop_clear() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
}

play_anim_vo(var_0, var_1) {
  wait(var_0);
  var_2 = strtok(var_1, "_");

  if(scripts\engine\utility::array_contains(var_2, "plr"))
    level.player scripts\engine\sp\utility::play_sound_on_entity(var_1);
  else
    scripts\engine\sp\utility::smart_dialogue(var_1);
}

_play_interaction_anim_vo_note() {
  self notify("start_interaction_vo_note");
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("start_interaction_vo_note");

  for(;;) {
    self waittill("single anim", var_0);

    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(issubstr(var_2, "vo_") && !issubstr(var_2, "_plr")) {
          var_3 = getsubstr(var_2, 3);
          thread scripts\engine\sp\utility::smart_dialogue(var_3);
          wait(lookupsoundlength(var_3) / 1000);
          self notify("single dialogue");

          if(isDefined(self.scriptedtalkingknob))
            self clearanim(self.scriptedtalkingknob, 0.2);
        }
      }

      continue;
    }

    if(issubstr(var_0, "vo_") && !issubstr(var_0, "_plr")) {
      var_3 = getsubstr(var_0, 3);
      thread scripts\engine\sp\utility::smart_dialogue(var_3);
      wait(lookupsoundlength(var_3) / 1000);
      self notify("single dialogue");

      if(isDefined(self.scriptedtalkingknob))
        self clearanim(self.scriptedtalkingknob, 0.2);
    }
  }
}

play_note_anim_vo(var_0) {
  self endon("death");
  self endon("stop_smart_reaction");
  var_1 = 0;

  while(!var_1) {
    self waittill("single anim", var_2);

    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4 == "reaction_vo") {
          var_1 = 1;
          break;
        }
      }
    } else if(var_2 == "reaction_vo") {
      var_1 = 1;
      break;
    }

    waitframe();
  }

  self notify("reaction_vo_fired");
  scripts\sp\interaction_manager::play_smart_dialog_if_exists(var_0);
}

play_anim_shared_vo() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_0 = undefined;
  var_1 = undefined;

  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"])) {
    return;
  }
  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"])) {
    return;
  }
  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"]))
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"] = [];

  if(isDefined(self.gender) && issubstr(self.gender, "male")) {
    if(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"].size < 1)
      level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"] = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"];

    var_2 = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"];
    var_3 = randomint(var_2.size);
    var_1 = var_2[var_3];
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"], var_3);
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"], var_1);
  }

  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"]))
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"] = [];

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    if(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"].size < 1)
      level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"] = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"];

    var_2 = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"];
    var_3 = randomint(var_2.size);
    var_1 = var_2[var_3];
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"], var_3);
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"], var_1);
  }

  var_4 = undefined;

  for(;;) {
    self waittill("single anim", var_5);

    if(isarray(var_5)) {
      foreach(var_7 in var_5) {
        if(var_7 == "reaction_vo") {
          var_4 = 1;
          break;
        }
      }
    } else if(var_5 == "reaction_vo")
      var_4 = 1;

    if(isDefined(var_4)) {
      break;
    }

    waitframe();
  }

  scripts\engine\sp\utility::smart_dialogue(var_1);
}

play_anim_vo_sequential(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.interaction_manager.data["registered_interactions"][self.interaction_name];

  if(isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"])) {
    var_1 = 1;

    if(!isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"]))
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"] = [];

    if(isDefined(self.gender) && issubstr(self.gender, "male")) {
      if(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"].size < 1)
        level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"] = level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"];

      var_4 = level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"];
      var_5 = randomint(var_4.size);
      var_2 = var_4[var_5];
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"], var_5);
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"], var_2);
    }
  }

  if(isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"])) {
    var_1 = 1;

    if(!isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"]))
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"] = [];

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      if(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"].size < 1)
        level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"] = level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"];

      var_4 = level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"];
      var_5 = randomint(var_4.size);
      var_2 = var_4[var_5];
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"], var_5);
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"], var_2);
    }
  }

  var_6 = var_0.size - 1;

  if(!isDefined(var_1)) {
    if(isstring(var_0[var_6])) {
      for(var_7 = 1; var_7 < var_0.size; var_7 = var_7 + 2)
        play_anim_vo(var_0[var_7], var_0[var_7 + 1]);

      return;
    }

    for(var_7 = 1; var_7 < var_0.size - 1; var_7 = var_7 + 2)
      play_anim_vo(var_0[var_7], var_0[var_7 + 1]);

    return;
  } else
    play_anim_vo(var_0[1], var_2);
}

set_sequential_wait_time(var_0) {
  self.sequential_wait_time = 0.0;
  self.sequential_loop_padding = 0.0;
  var_1 = var_0.size - 1;

  if(isstring(var_0[var_1])) {
    self.sequential_loop_padding = 0.0;

    for(var_2 = 1; var_2 < var_0.size; var_2 = var_2 + 2)
      self.sequential_wait_time = self.sequential_wait_time + var_0[var_2];
  } else {
    self.sequential_loop_padding = var_0[var_1];

    for(var_2 = 1; var_2 < var_0.size - 1; var_2 = var_2 + 2)
      self.sequential_wait_time = self.sequential_wait_time + var_0[var_2];
  }
}

random_idle_controller() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_0 = undefined;
  var_1 = get_interaction(self.interaction_name);

  if(!isDefined(var_1))
    var_1 = get_state_interaction(self.interaction_name);

  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;

  if(!isarray(var_1.scene["idle"]))
    var_1.scene["idle"] = [var_1.scene["idle"], var_1.scene["idle"]];

  var_2 = [];
  var_3 = var_1.scene["idle"];
  var_4 = var_3[0];
  var_3 = scripts\engine\utility::array_remove_index(var_3, 0);
  var_5 = var_3;
  var_3 = undefined;
  self.starting_random_idle = var_4;

  for(;;) {
    self.is_playing_random_idle = 1;
    var_6 = getanimlength(var_4);
    var_7 = randomint(2) + 1;
    var_8 = var_6 * float(var_7);
    wait(var_8);

    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150.0)) {
        break;
      }

      waitframe();
    }

    if(var_5.size <= 0) {
      var_5 = var_2;
      var_2 = [];
    }

    var_9 = var_5[randomint(var_5.size)];
    var_2 = scripts\engine\utility::array_add(var_2, var_9);
    var_5 = scripts\engine\utility::array_remove(var_5, var_9);
    var_10 = undefined;
    var_11 = undefined;

    if(isDefined(self.optional_struct)) {
      var_10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var_9);
      var_11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var_9);

      if(!isDefined(self.is_cheap))
        self forceteleport(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    while(self.is_playing_reaction)
      waitframe();

    start_fakeactor_notetracks(var_9);
    self setflaggedanimknob("single anim", var_9, 1, 0.2, 1);
    self.random_idle_playing = 1;
    var_12 = getanimlength(var_9);
    wait(var_12);

    while(self.is_playing_reaction)
      waitframe();

    if(isDefined(self.optional_struct)) {
      var_10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var_4);
      var_11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var_4);

      if(!isDefined(self.is_cheap))
        self forceteleport(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    self.random_idle_playing = 0;
    self clearanim(var_9, 0.3);
    self.is_playing_random_idle = undefined;
    start_fakeactor_notetracks(var_4);
    self setflaggedanimknob("single anim", var_4, 1, 0.2, 1);
    self setanimtime(var_4, randomfloat(1));

    for(;;) {
      if(isDefined(self.can_play_random_idle)) {
        break;
      }

      waitframe();
    }

    waitframe();
  }
}

random_idle_controller_stateful() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_0 = undefined;
  var_1 = get_state_interaction(self.interaction_name);
  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;
  var_2 = undefined;

  if(isDefined(self.gender) && issubstr(self.gender, "female"))
    var_2 = "idle_female";
  else
    var_2 = "idle";

  var_3 = var_1.scene[var_2][0];
  self.starting_random_idle = var_3;

  for(;;) {
    self.is_playing_random_idle = 1;
    var_4 = getanimlength(var_3);
    var_5 = randomint(2) + 1;
    var_6 = var_4 * float(var_5);
    wait(var_6);

    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150.0)) {
        break;
      }

      waitframe();
    }

    var_7 = undefined;
    var_8 = undefined;

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_7 = "random_idles_female";
      var_8 = "spent_random_idles_female";
    } else {
      var_7 = "random_idles";
      var_8 = "spent_random_idles";
    }

    if(level.state_interactions[self.interaction_name].scene[var_7].size <= 0) {
      level.state_interactions[self.interaction_name].scene[var_7] = level.state_interactions[self.interaction_name].scene[var_8];
      level.state_interactions[self.interaction_name].scene[var_8] = [];
    }

    var_9 = level.state_interactions[self.interaction_name].scene[var_7][randomint(level.state_interactions[self.interaction_name].scene[var_7].size)];
    level.state_interactions[self.interaction_name].scene[var_8] = scripts\engine\utility::array_add(level.state_interactions[self.interaction_name].scene[var_8], var_9);
    level.state_interactions[self.interaction_name].scene[var_7] = scripts\engine\utility::array_remove(level.state_interactions[self.interaction_name].scene[var_7], var_9);
    var_10 = undefined;
    var_11 = undefined;

    if(isDefined(self.optional_struct)) {
      var_10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var_9);
      var_11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var_9);

      if(!isDefined(self.is_cheap))
        self forceteleport(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    while(self.is_playing_reaction)
      waitframe();

    start_fakeactor_notetracks(var_9);
    self setflaggedanimknob("single anim", var_9, 1, 0.2, 1);
    self.random_idle_playing = 1;
    var_12 = getanimlength(var_9);
    wait(var_12);

    while(self.is_playing_reaction)
      waitframe();

    if(isDefined(self.optional_struct)) {
      var_10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var_3);
      var_11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var_3);

      if(!isDefined(self.is_cheap))
        self forceteleport(var_10, var_11);
      else {
        self.origin = var_10;
        self.angles = var_11;
      }
    }

    self.random_idle_playing = 0;
    self clearanim(var_9, 0.3);
    self.is_playing_random_idle = undefined;
    start_fakeactor_notetracks(var_3);
    self setflaggedanimknob("single anim", var_3, 1, 0.2, 1);
    self setanimtime(var_3, randomfloat(1));

    for(;;) {
      if(isDefined(self.can_play_random_idle)) {
        break;
      }

      waitframe();
    }

    waitframe();
  }
}

random_idle_group_controller(var_0, var_1, var_2) {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  level endon("stop_idle_controller");
  self endon("stop_group_idle_controller");
  level endon("stop_group_idle_controller");
  self endon("death");

  if(!scripts\engine\utility::flag_exist("hold_group_vignettes"))
    scripts\engine\utility::flag_init("hold_group_vignettes");

  var_3 = [];
  var_4 = var_2;

  for(;;) {
    wait(randomfloatrange(var_1 * 0.5, var_1));

    foreach(var_6 in var_0) {
      if(!isDefined(var_6)) {
        self notify("stop_group_idle_controller");
        return;
      }

      var_6 endon("death");
      var_6 endon("entitydeleted");
      var_6.can_play_random_idle = undefined;
    }

    var_8 = 0;

    for(;;) {
      if(!scripts\engine\utility::flag("hold_group_vignettes")) {
        foreach(var_10 in var_0) {
          if(!isDefined(var_10.is_playing_random_idle))
            var_8++;
        }

        if(var_8 >= var_0.size) {
          break;
        } else
          var_8 = 0;
      }

      waitframe();
    }

    var_12 = undefined;

    if(isarray(var_2)) {
      if(var_4.size <= 0) {
        var_4 = var_2;
        var_3 = [];
      }

      var_12 = var_4[randomint(var_4.size)];
    } else
      var_12 = var_2;

    var_13 = 0;

    if(!scripts\engine\utility::flag("hold_group_vignettes")) {
      foreach(var_6 in var_0) {
        if(!isDefined(var_6)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_15 = var_6 scripts\engine\utility::getanim(var_12);
        var_16 = getstartorigin(var_6.origin, var_6.angles, var_15);
        var_17 = getstartangles(var_6.origin, var_6.angles, var_15);

        if(isai(var_6))
          var_6 forceteleport(var_16, var_17);
        else {
          var_6.origin = var_16;
          var_6.angles = var_17;
        }

        var_6 thread start_fakeactor_notetracks(var_15);
        var_6 setflaggedanimknob("single anim", var_15, 1.0, 0.2);
        var_6.allow_interactions = 0;
        var_6.hold_lookat = 1;
        var_13 = getanimlength(var_15);
      }

      wait(var_13);

      if(isarray(var_2)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_12);
        var_4 = scripts\engine\utility::array_remove(var_4, var_12);
      }

      foreach(var_20 in var_0) {
        if(!isDefined(var_20)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_15 = var_20 scripts\engine\utility::getanim(var_12);
        var_20 thread start_fakeactor_notetracks(var_20.starting_random_idle);
        var_20 setanimknob(var_15, 0.0, 0.2);
        var_20 setflaggedanimknob("single anim", var_20.starting_random_idle, 1, 0.2, 1);
        var_20 setanimtime(var_20.starting_random_idle, randomfloat(1));
        var_20.can_play_random_idle = 1;
        var_20.allow_interactions = 1;
        var_20.hold_lookat = undefined;
      }
    }

    waitframe();
  }
}

interaction_end() {
  if(!isDefined(self.reaction_stop_anims)) {
    scripts\asm\asm_sp::asm_stopanimScripted();
    interaction_set_anim_movement("stop");
  }

  scripts\sp\interaction_manager::remove_actor_from_manager();
  self notify("reaction_end");
  thread scripts\sp\interaction_manager::stop_gesture_reaction();
  self notify("stop_smart_reaction");
  self.is_talking = undefined;
}

interaction_end_cheap() {
  self waittill("reaction_end");
  scripts\sp\interaction_manager::remove_actor_from_manager();
  self notify("interaction_done");
  self notify("stop_reaction");
  self.is_talking = undefined;
}

set_time_via_rate(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = self getanimtime(var_0);
  var_4 = getanimlength(var_0);
  var_5 = (var_1 - var_3) * var_4 / 0.05;
  self setanimlimited(var_0, var_2, 0.25, var_5);
}

play_combat_interaction(var_0, var_1) {
  self endon("death");
  self endon("interaction_done");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.combat_reaction_return_state = var_1;

  if(isDefined(level.interaction_manager))
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);

  while(self.script == "init")
    waitframe();

  for(;;) {
    for(;;) {
      var_2 = lengthsquared(level.player.origin - self.origin);

      if(var_2 < squared(150.0) && is_looking_at_range(self, 0.925)) {
        break;
      }

      waitframe();
    }

    var_3 = self.asmname;
    var_4 = self asmgetcurrentstate(var_3);

    if(var_4 == self.combat_reaction_return_state && !self.nearby_interaction_running) {
      if(var_0.script_reaction == "combat_reaction") {
        var_5 = [];

        if(isDefined(var_0.type)) {
          switch (var_0.type) {
            case "Cover Crouch":
              var_5 = ["combat_crouch_1", "combat_crouch_2"];
              break;
            case "Cover Left":
              switch (self.currentpose) {
                case "stand":
                  var_5 = ["hm_grnd_org_cover_left_stand_react_01", "hm_grnd_org_cover_left_stand_react_02"];
                  break;
                case "crouch":
                  var_5 = ["hm_grnd_org_cover_left_crouch_react_01", "hm_grnd_org_cover_left_crouch_react_02"];
                  break;
                case "prone":
                  break;
              }

              break;
            case "Cover Right":
              switch (self.currentpose) {
                case "stand":
                  var_5 = ["hm_grnd_org_cover_right_stand_react_01", "hm_grnd_org_cover_right_stand_react_02"];
                  break;
                case "crouch":
                  var_5 = ["hm_grnd_org_cover_right_crouch_react_01", "hm_grnd_org_cover_right_crouch_react_02"];
                  break;
                case "prone":
                  break;
              }

              break;
            case "Cover Prone":
              break;
            case "Cover Stand":
              break;
            case "Cover Crouch Window":
              var_5 = ["combat_cover_crouch_1"];
              break;
          }

          if(var_5.size > 0) {
            var_6 = randomint(var_5.size);
            var_7 = var_5[var_6];
            combat_interaction_process(var_7, var_0);
          } else
            return;
        }
      } else
        combat_interaction_process(var_0.script_reaction, var_0);
    }

    wait 1.5;
  }
}

combat_interaction_process(var_0, var_1) {
  self endon("death");
  self endon("interaction_done");
  var_2 = get_interaction(var_0);
  thread scripts\common\notetrack::start_notetrack_wait(self, "vo");
  thread _play_interaction_anim_vo_note();

  if(!isDefined(var_2)) {
    return;
  }
  self.lookat_anims = var_2.scene;

  if(!isDefined(self.animname))
    self.animname = "generic";

  var_3 = lengthsquared(level.player.origin - self.origin);
  var_4 = undefined;
  var_5 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_6 = undefined;

  if(isDefined(self.lookat_anims["interaction_position"]))
    var_3 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
  else
    var_3 = lengthsquared(level.player.origin - self.origin);

  if(var_3 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925)) {
    var_4 = vectorNormalize(level.player getEye() - self getEye()) * self.lookat_anims["trigger_radius"] + self getEye();
    var_6 = scripts\engine\trace::ray_trace(self getEye(), var_4, self, var_5);

    if(isPlayer(var_6["entity"]))
      combat_interaction_run();
  }
}

#using_animtree("generic_human");

combat_interaction_run() {
  self endon("death");
  self endon("interaction_done");
  self.is_playing_reaction = 1;
  self notify("playing_interaction_scene");
  level notify("playing_interaction");
  var_0 = self.combat_reaction_previous_anim;
  var_1 = undefined;

  if(isDefined(self.lookat_anims["interaction_position"]))
    var_1 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
  else
    var_1 = vectortoangles(level.player.origin - self.origin);

  var_2 = abs(angleclamp(var_1 - self.angles[1]) - 360);
  var_3 = self.lookat_anims["lastanim"];

  if(isDefined(self.lookat_anims["angles"])) {
    foreach(var_5 in self.lookat_anims["angles"]) {
      if(var_2 <= var_5) {
        var_3 = self.lookat_anims[var_5];
        break;
      }
    }
  }

  if(isarray(var_3)) {
    if(isarray(var_3[0])) {
      var_7 = self.anim_sequential_counter;
      var_8 = var_3[0][var_7][0];
    } else
      var_8 = var_3[0];
  } else
    var_8 = var_3;

  start_fakeactor_notetracks(var_8);
  self setanimlimited(%cover, 0, 0.25, 1);
  self setflaggedanimknoball("vo", var_8, %body, 1, 0.25, 1);
  wait(getanimlength(var_8));
  self clearanim(%scripted, 0.25);
  self setanimlimited(%cover, 1, 0.25, 1);
  self.is_playing_reaction = 0;
  wait 0.25;
  self notify("interaction_done");
  level notify("interaction_done");
  thread interaction_end();
}

combat_reaction_wait_buffer(var_0) {
  var_0.combat_reaction_wait = 1;
  wait 2.0;
  var_0.combat_reaction_wait = undefined;
}

new_goal_listener() {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_0 = undefined;

  if(isDefined(self.last_set_goalnode)) {
    var_0 = self.last_set_goalnode.origin;

    while(isDefined(self.last_set_goalnode) && self.last_set_goalnode.origin == var_0)
      waitframe();
  } else if(isDefined(self.last_set_goalent)) {
    var_0 = self.last_set_goalent.origin;

    while(isDefined(self.last_set_goalent) && self.last_set_goalent.origin == var_0)
      waitframe();
  } else if(isDefined(self.last_set_goalpos)) {
    var_0 = self.last_set_goalpos;

    while(isDefined(self.last_set_goalpos) && self.last_set_goalpos == var_0)
      waitframe();
  }

  self notify("interaction_done");
  thread interaction_end();
}

interaction_pain_listener() {
  self endon("death");
  self endon("interaction_done");
  self.interaction_pain = undefined;

  for(;;) {
    self.interaction_pain = undefined;
    self waittill("pain");
    self.interaction_pain = 1;
    wait 5.0;
  }
}

interaction_set_anim_movement(var_0) {
  if(!isDefined(var_0))
    var_0 = "stop";

  if(isai(self))
    self.a.movement = var_0;
  else
    return;
}

start_fakeactor_notetracks(var_0) {
  var_1 = undefined;

  if(isDefined(self.interaction_name))
    var_1 = self.interaction_name;

  thread scripts\common\notetrack::start_notetrack_wait(self, "single anim", var_1, undefined, var_0);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "single anim", var_1);
}
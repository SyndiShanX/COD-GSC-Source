/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\interaction.gsc
***********************************************/



#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\asm\gesture\script_funcs;
#using scripts\common\ai;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\interaction_manager;
#using scripts\sp\utility;
#namespace interaction;

function register_interaction(interact_name, struct) {
  level.interactions[interact_name] = struct;
}

function register_state_interaction(interact_name, struct) {
  level.state_interactions[interact_name] = struct;
}

function get_interaction(interact_name) {
  if(!isDefined(level.interactions) || !isDefined(level.interactions[interact_name])) {
    return undefined;
  }

  return level.interactions[interact_name];
}

function get_state_interaction(interact_name) {
  if(!issubstr(interact_name, "casual") && !issubstr(interact_name, "alert")) {
    if(isDefined(self.asm)) {
      demeanor = asm_getdemeanor();

      if(demeanor == "casual") {
        interact_name = interact_name + "_" + demeanor;
      } else {
        interact_name += "_alert";
      }
    } else {
      interact_name += "_casual";
    }
  }

  if(!isDefined(level.state_interactions) || !isDefined(level.state_interactions[interact_name])) {
    return undefined;
  }

  return level.state_interactions[interact_name];
}

function is_interaction(interact_name) {
  return isDefined(level.interactions) && isDefined(level.interactions[interact_name]);
}

function is_state_interaction(interact_name) {
  return isDefined(level.state_interactions) && isDefined(level.state_interactions[interact_name + "_casual"]);
}

function is_state_interact_struct(struct) {
  if(isDefined(struct.script_reaction) && is_state_interaction(struct.script_reaction)) {
    return true;
  }

  return false;
}

function is_interact_struct(struct) {
  if(isDefined(struct.script_reaction) && is_interaction(struct.script_reaction)) {
    return true;
  }

  if(isDefined(struct.script_noteworthy) && is_interaction(struct.script_noteworthy)) {
    return true;
  }

  return false;
}

function is_interact_node(node) {
  if(isDefined(node.script_reaction)) {
    if(is_interaction(node.script_reaction) || node.script_reaction == "combat_reaction") {
      return true;
    }
  }

  return false;
}

function get_arrivalstate_from_interaction(interaction) {
  demeanor = asm_getdemeanor();

  if(isDefined(interaction.arrivalstates)) {
    return interaction.arrivalstates[demeanor];
  }

  return undefined;
}

function get_exitstate_from_interaction(interaction) {
  demeanor = asm_getdemeanor();

  if(isDefined(interaction.exitstates)) {
    return interaction.exitstates[demeanor];
  }

  return undefined;
}

function get_idlestate_from_interaction(interaction) {
  demeanor = asm_getdemeanor();
  return interaction.idlestate;
}

function setup_exit_states_for_interaction(interaction_name) {
  if(!isai(self)) {
    return;
  }

  self.asm.customdata.interaction = interaction_name;
  interaction = get_interaction(interaction_name);

  if(!isDefined(interaction)) {
    interaction = get_state_interaction(interaction_name);
  }

  self.var_57e1b0c4ad45db70 = get_exitstate_from_interaction(interaction);
}

function play_interaction_anim(interact, anim_index, weight, time, rate) {
  interact = get_interaction(interact);
  assertex(isDefined(interact), "play_interact_anim() must be sent a registered interact");
  assertex(isDefined(interact.scene[anim_index]), "play_interact_anim() must be sent a valid anim_index");

  if(!isDefined(weight)) {
    weight = 1;
  }

  if(!isDefined(time)) {
    time = 0.05;
  }

  if(!isDefined(rate)) {
    rate = 1;
  }

  start_fakeactor_notetracks(interact.scene[anim_index]);
  self setflaggedanim(anim_index, interact.scene[anim_index], weight, time, rate);
}

function define_interacton_position(reference) {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  reference_pos = undefined;

  while(true) {
    if(isstruct(reference) || isent(reference)) {
      reference_pos = reference.origin;
    } else if(isvector(reference)) {
      reference_pos = reference;
    }

    if(isDefined(self.lookat_anims)) {
      self.lookat_anims["interaction_position"] = reference_pos;
    }

    waitframe();
  }
}

function redefine_interaction_radius(new_radius) {
  old_radius = undefined;

  if(isDefined(self.lookat_anims)) {
    old_radius = self.lookat_anims["trigger_radius"];
    self.lookat_anims["trigger_radius"] = new_radius;
    thread _redefine_interaction_radius_cleanup(old_radius);
  }
}

function _redefine_interaction_radius_cleanup(old_radius) {
  self endon("interaction_end");
  self endon("reaction_end");
  self waittill("interaction_done");
  self.lookat_anims["trigger_radius"] = old_radius;
}

function play_interaction(interaction_name, optional_scripted_struct, var_4ec51221f3064070) {
  self endon("death");
  self notify("reaction_end");
  interaction = get_interaction(interaction_name);
  setup_exit_states_for_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("Interaction by name of " + interaction_name + " but interaction isn't registered");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = interaction_name;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    scripts\sp\interaction_manager::add_actor_to_manager();
    level.interaction_manager.data["registered_interactions"][interaction_name] = [];

    if(isDefined(interaction.scene["vo_lines_male"])) {
      level.interaction_manager.data["registered_interactions"][interaction_name]["vo_lines_male"] = interaction.scene["vo_lines_male"];
    }

    if(isDefined(interaction.scene["vo_lines_female"])) {
      level.interaction_manager.data["registered_interactions"][interaction_name]["vo_lines_female"] = interaction.scene["vo_lines_female"];
    }
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;

    if(isarray(self.lookat_anims["idle"])) {
      var_7dadc6aea2eb869d = self.lookat_anims["idle"][0];
    } else {
      var_7dadc6aea2eb869d = self.lookat_anims["idle"];
    }

    if(isstring(optional_scripted_struct)) {
      optional_struct = getStruct(optional_scripted_struct, "targetname");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else if(isent(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("Optional struct is not a string or struct or an ent");
      return;
    }

    anime = var_7dadc6aea2eb869d;
    start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, anime);
    start_angles = getstartangles(optional_struct.origin, optional_struct.angles, anime);

    if(!isDefined(self.is_cheap)) {
      self forceteleport(start_origin, start_angles);
    } else {
      self.origin = start_origin;
      self.angles = start_angles;
    }

    if(!isDefined(self.is_cheap)) {
      self animmode("noclip");
    }

    self.optional_struct = optional_struct;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap)) {
      scripts\common\ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    if(!isDefined(var_4ec51221f3064070)) {
      thread interaction_process();
      thread interaction_end_cheap();
    } else {
      thread interaction_follow_process();
      thread interaction_end_cheap();
    }
  } else if(!isDefined(var_4ec51221f3064070)) {
    asm_animcustom(&interaction_process, &interaction_end);
  } else {
    asm_animcustom(&interaction_follow_process, &interaction_end);
  }

  self waittill("reaction_end");
}

function play_smart_interaction(interaction_name, reaction_vo, post_reaction_vo, is_reminder, optional_pointat, optional_scripted_struct, var_ae60636acdfadd47, var_a8b8d69bb3f6e8a9) {
  assert(is_interaction(interaction_name));
  self endon("death");
  self endon("stop_smart_reaction");
  setup_interaction_head();
  var_cd56aed546a14150 = get_interaction(interaction_name).scene["trigger_radius"] * 2;
  thread scripts\sp\interaction_manager::reaction_look_distance_based(var_cd56aed546a14150);
  play_interaction_unknowntype(interaction_name, optional_scripted_struct, reaction_vo, var_a8b8d69bb3f6e8a9);
  self waittill("interaction_done");
  thread gesture_stop(0.7);
  self notify("stop_reaction_look");
  waittill_playeroutsideradius(var_ae60636acdfadd47);
  play_looping_acknowlegdements(post_reaction_vo, var_ae60636acdfadd47);
}

#using_animtree("generic_human");

function setup_interaction_head() {
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
}

function play_interaction_unknowntype(interaction_name, optional_scripted_struct, reaction_vo, var_a8b8d69bb3f6e8a9) {
  if(issubstr(interaction_name, "blended")) {
    thread play_interaction_blended(interaction_name, optional_scripted_struct);
  } else {
    thread play_interaction(interaction_name, optional_scripted_struct);
  }

  queue_interaction_vo(reaction_vo, var_a8b8d69bb3f6e8a9);
}

function queue_interaction_vo(reaction_vo, var_a8b8d69bb3f6e8a9) {
  if(!isDefined(var_a8b8d69bb3f6e8a9)) {
    thread play_note_anim_vo(reaction_vo);
    return;
  }

  self waittill("playing_interaction_scene");
  delaythread(var_a8b8d69bb3f6e8a9, &scripts\sp\interaction_manager::play_smart_dialog_if_exists, reaction_vo);
}

function play_smart_simple_interaction(interaction_name, reaction_vo, post_reaction_vo, is_reminder, optional_pointat, optional_scripted_struct, var_ae60636acdfadd47) {
  self endon("death");
  self endon("stop_smart_reaction");
  assert(is_interaction(interaction_name));
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  thread play_interaction_simple(interaction_name, optional_scripted_struct);
  scripts\sp\interaction_manager::play_gesture_reaction(85, 50, reaction_vo, is_reminder, optional_pointat);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var_ae60636acdfadd47);
  linebook = create_interaction_linebook(post_reaction_vo);

  while(true) {
    random_line = linebook get_interaction_vo_line();
    scripts\sp\interaction_manager::play_gesture_reaction(85, 50, random_line, is_reminder, optional_pointat);
    waittill_playeroutsideradius(var_ae60636acdfadd47);
  }
}

function play_smart_basic_interaction(var_bff752982ed3d584, post_reaction_vo, is_reminder, optional_pointat, var_ae60636acdfadd47) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  play_single_acknowledgement(var_bff752982ed3d584);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var_ae60636acdfadd47);
  play_looping_acknowlegdements(post_reaction_vo, var_ae60636acdfadd47);
}

function play_smart_silent_interaction(var_ae60636acdfadd47) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  play_single_acknowledgement(undefined);
  waittill_playeroutsideradius(var_ae60636acdfadd47);
  play_looping_acknowlegdements(undefined, var_ae60636acdfadd47);
}

function play_smart_simple_silent_interaction(interaction_name, optional_scripted_struct, var_ae60636acdfadd47) {
  self endon("death");
  self endon("stop_smart_reaction");
  assert(is_interaction(interaction_name));
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  thread play_interaction_simple(interaction_name, optional_scripted_struct);
  scripts\sp\interaction_manager::play_gesture_reaction(85, 50);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var_ae60636acdfadd47);
  play_looping_acknowlegdements(undefined, var_ae60636acdfadd47);
}

function play_single_acknowledgement(vo_line) {
  self endon("stop_smart_reaction");
  lookat_distance = 110;
  reaction_distance = 85;
  scripts\sp\interaction_manager::play_gesture_reaction(lookat_distance, reaction_distance, vo_line);
}

function play_looping_acknowlegdements(vo_array, var_ae60636acdfadd47) {
  self endon("death");
  self endon("stop_smart_reaction");

  if(!isDefined(var_ae60636acdfadd47)) {
    var_ae60636acdfadd47 = 300;
  }

  if(isDefined(vo_array)) {
    linebook = create_interaction_linebook(vo_array);

    while(true) {
      random_line = linebook get_interaction_vo_line();
      play_single_acknowledgement(random_line);
      waittill_playeroutsideradius(var_ae60636acdfadd47);
    }

    return;
  }

  while(true) {
    play_single_acknowledgement();
    waittill_playeroutsideradius(var_ae60636acdfadd47);
  }
}

function play_silent_acknowledgement() {
  lookat_distance = 110;
  reaction_distance = 85;
  scripts\sp\interaction_manager::play_gesture_reaction(lookat_distance, reaction_distance);
}

function waittill_playeroutsideradius(dist) {
  if(!isDefined(dist)) {
    dist = 256;
  }

  while(true) {
    if(distance2d(self.origin, level.player.origin) >= dist) {
      break;
    }

    waitframe();
  }
}

function create_interaction_linebook(vo_array) {
  assertex(isDefined(vo_array), "vo_array must be defined to perform a smart_interaction.");

  if(!isarray(vo_array) && !isstruct(vo_array) && !isstring(vo_array) && !isvector(vo_array) && !vo_array) {
    return undefined;
  }

  vo_struct = spawnStruct();
  vo_struct.base = vo_array;
  vo_struct.available = vo_array;
  vo_struct.used = [];
  return vo_struct;
}

function reset_interaction_linebook() {
  self.used = [];
  self.available = self.base;
}

function get_interaction_vo_line() {
  random_line = undefined;

  if(isDefined(self.available)) {
    if(self.available.size <= 0) {
      reset_interaction_linebook();
    }

    random_line = self.available[randomint(self.available.size)];
    self.used = array_add(self.used, random_line);
    self.available = array_remove(self.available, random_line);
    return random_line;
  }
}

function play_smart_basic_group_interaction(actor_array, var_7551dea02427d9cd, var_eee89e98a7ce9526, var_ae60636acdfadd47) {
  foreach(actor in actor_array) {
    actor endon("death");
    actor endon("stop_smart_reaction");
    actor.headknob = % head;
    actor.scriptedtalkingknob = % scripted_talking;
    actor.defaulttalk = % generic_talker_allies;
  }

  if(actor_array.size != var_7551dea02427d9cd.size || actor_array.size != var_eee89e98a7ce9526.size) {
    assertmsg("Basic Group Interaction Input Error: The number of vo_arrays you pass must be equal to the number of actors.");
    return;
  }

  play_group_acknowledgement(actor_array, var_7551dea02427d9cd);
  mid_ent = scripts\sp\interaction_manager::create_middle_ent(actor_array);
  mid_ent waittill_playeroutsideradius(var_ae60636acdfadd47);
  play_group_looping_acknowledgements(actor_array, var_eee89e98a7ce9526, var_ae60636acdfadd47);
}

function play_group_acknowledgement(actor_array, voline_array) {
  lookat_distance = 110;
  reaction_distance = 85;
  scripts\sp\interaction_manager::play_group_gesture_reaction(actor_array, lookat_distance, reaction_distance, voline_array);
}

function play_group_looping_acknowledgements(actor_array, vo_arrays, var_ae60636acdfadd47) {
  foreach(actor in actor_array) {
    actor endon("death");
    actor endon("stop_smart_reaction");
  }

  group_linebook = create_group_interaction_linebook(vo_arrays);
  mid_ent = scripts\sp\interaction_manager::create_middle_ent(actor_array);

  while(true) {
    var_e73000eabf1cd643 = get_interaction_vo_line_array(group_linebook);
    play_group_acknowledgement(actor_array, var_e73000eabf1cd643);
    mid_ent waittill_playeroutsideradius(var_ae60636acdfadd47);
  }
}

function create_group_interaction_linebook(vo_arrays) {
  assertex(isDefined(vo_arrays), "vo_arrays must be defined to perform a smart_group_interaction.");
  group_linebook = [];

  for(i = 0; i < vo_arrays.size; i++) {
    group_linebook[i] = create_interaction_linebook(vo_arrays[i]);
  }

  return group_linebook;
}

function get_interaction_vo_line_array(group_linebook) {
  vo_line_array = [];

  for(i = 0; i < group_linebook.size; i++) {
    vo_line_array[i] = group_linebook[i] get_interaction_vo_line();
  }

  return vo_line_array;
}

function play_interaction_with_states(interaction_name, optional_scripted_struct, var_4ec51221f3064070) {
  self endon("death");
  self notify("reaction_end");
  interaction = get_state_interaction(interaction_name);
  setup_exit_states_for_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("Interaction by name of " + interaction_name + " isn't registered in state based interactions");
    return;
  }

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = interaction_name;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    scripts\sp\interaction_manager::add_actor_to_manager();
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;

    if(isarray(interaction.scene["idle"])) {
      var_7dadc6aea2eb869d = interaction.scene["idle"][0];
    } else {
      var_7dadc6aea2eb869d = interaction.scene["idle"];
    }

    if(isstring(optional_scripted_struct)) {
      optional_struct = getStruct(optional_scripted_struct, "targetname");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else if(isent(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("Optional struct is not a string or struct or an ent");
      return;
    }

    anime = var_7dadc6aea2eb869d;
    start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, anime);
    start_angles = getstartangles(optional_struct.origin, optional_struct.angles, anime);

    if(!isDefined(self.is_cheap)) {
      self forceteleport(start_origin, start_angles);
    } else {
      self.origin = start_origin;
      self.angles = start_angles;
    }

    if(!isDefined(self.is_cheap)) {
      self animmode("noclip");
    }

    self.optional_struct = optional_struct;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(interaction.scene["no_gun"])) {
    if(!isDefined(self.is_cheap) && !isnullweapon(self.weapon)) {
      scripts\common\ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    thread interaction_process_for_states();
    thread interaction_end_cheap();
  } else {
    asm_animcustom(&interaction_process_for_states, &scripts\sp\interaction_manager::stop_state_based_interaction);
  }

  self waittill("reaction_end");
}

function play_interaction_simple(interaction_name, optional_scripted_struct, optional_prop) {
  self endon("death");
  self endon("reaction_end");
  interaction = get_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("Interaction by name of " + interaction_name + " but interaction isn't registered");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = interaction_name;
  self.reaction_stop_anims = 1;
  self.optional_struct = undefined;
  self.optional_prop = undefined;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = array_add(level.interaction_manager.data["actors"], self);
  }

  if(isDefined(optional_prop)) {
    self.optional_prop = optional_prop;
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;

    if(isarray(self.lookat_anims["idle"])) {
      var_7dadc6aea2eb869d = self.lookat_anims["idle"][0];
    } else {
      var_7dadc6aea2eb869d = self.lookat_anims["idle"];
    }

    if(isstring(optional_scripted_struct)) {
      optional_struct = getStruct(optional_scripted_struct, "targetname");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else if(isent(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("Optional struct is not a string or struct");
      return;
    }

    anime = var_7dadc6aea2eb869d;
    start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, anime);
    start_angles = getstartangles(optional_struct.origin, optional_struct.angles, anime);
    self.optional_struct = optional_scripted_struct;
  }

  if(!isDefined(self.is_cheap)) {
    self animmode("noclip");
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap) && !isnullweapon(self.weapon)) {
      scripts\common\ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    thread simple_interaction_idles();
    thread interaction_end_cheap();
  } else {
    asm_animcustom(&simple_interaction_idles, &interaction_end);
  }

  self waittill("reaction_end");
}

function play_interaction_blended(interaction_name, optional_scripted_struct) {
  self endon("death");
  self notify("reaction_end");
  interaction = get_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("Interaction by name of " + interaction_name + " but interaction isn't registered");
    return;
  }

  reset_actor_interaction_values(interaction, interaction_name);
  add_actor_tointeractionmanager();
  move_actor_tointeractionposition(optional_scripted_struct);
  run_blended_interaction();
}

function reset_actor_interaction_values(interaction, interaction_name) {
  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.lookat_anims = interaction.scene;
  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = interaction_name;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions) || isDefined(self.allow_interactions) && !self.allow_interactions) {
    self.allow_interactions = 1;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap)) {
      gun_remove();
    }
  }
}

function add_actor_tointeractionmanager() {
  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = array_add(level.interaction_manager.data["actors"], self);
  }
}

function get_interaction_actor_lookatidle() {
  if(isarray(self.lookat_anims["idle"])) {
    return self.lookat_anims["idle"][0];
  }

  return self.lookat_anims["idle"];
}

function get_interaction_actor_optionalstruct(optional_scripted_struct) {
  optional_struct = undefined;

  if(isstring(optional_scripted_struct)) {
    optional_struct = getStruct(optional_scripted_struct, "targetname");
  } else if(isstruct(optional_scripted_struct)) {
    optional_struct = optional_scripted_struct;
  } else if(isent(optional_scripted_struct)) {
    optional_struct = optional_scripted_struct;
  } else {
    assertmsg("Optional struct is not a string or struct");
  }

  return optional_struct;
}

function move_actor_tointeractionposition(optional_scripted_struct) {
  if(isDefined(optional_scripted_struct)) {
    idle_anime = get_interaction_actor_lookatidle();
    optional_struct = get_interaction_actor_optionalstruct(optional_scripted_struct);

    if(!isDefined(optional_struct)) {
      return;
    }

    self.optional_scripted_struct = optional_scripted_struct;
    start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, idle_anime);
    start_angles = getstartangles(optional_struct.origin, optional_struct.angles, idle_anime);
    teleport_interaction_actor(start_origin, start_angles);

    if(!isDefined(self.is_cheap)) {
      self animmode("noclip");
    }
  }
}

function teleport_interaction_actor(new_origin, new_angles) {
  if(isDefined(self.is_cheap)) {
    self.origin = new_origin;
    self.angles = new_angles;
    return;
  }

  self forceteleport(new_origin, new_angles);
}

function run_blended_interaction() {
  if(isDefined(self.is_cheap)) {
    thread interaction_process_blended();
    thread interaction_end_cheap();
  } else {
    asm_animcustom(&interaction_process_blended, &interaction_end);
  }

  self waittill("reaction_end");
}

function play_interaction_immediate(interaction_name, optional_scripted_struct) {
  self endon("death");
  interaction = get_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("Interaction by name of " + interaction_name + " but interaction isn't registered");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.interaction_name = interaction_name;
  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = array_add(level.interaction_manager.data["actors"], self);
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;
    starting_anim = self.lookat_anims["lastanim"];

    if(isstring(optional_scripted_struct)) {
      optional_struct = getStruct(optional_scripted_struct, "targetname");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("Optional struct is not a string or struct");
      return;
    }

    self.lookat_anims["optional_struct"] = optional_struct;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap)) {
      gun_remove();
    }
  }

  thread asm_animcustom(&interaction_immediate_process);
  self waittill("interaction_done");
}

function clear_root() {
  self clearanim(%body, 0.2);
}

function is_looking_at_range(target_guy, range) {
  player_forward = anglesToForward(level.player.angles);
  var_bac0559feed06173 = vectorNormalize(target_guy.origin - level.player.origin);
  dot_vec = vectordot(player_forward, var_bac0559feed06173);

  if(dot_vec >= range) {
    return 1;
  }

  return 0;
}

function interaction_immediate_process() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  optional_struct = self.lookat_anims["optional_struct"];
  anim_string = "single anim";

  if(!ent_flag_exist("interaction_end")) {
    ent_flag_init("interaction_end");
  }

  ent_flag_clear("interaction_end");
  initial_reaction_blendtime = 0.25;
  lookat_end_blendtime = 0.25;

  if(isDefined(self.lookat_anims["common_name"])) {
    thread scripts\sp\interaction_manager::trigger_interaction_common();
  }

  if(!self.nearby_interaction_running) {
    self.is_playing_reaction = 1;
    self notify("playing_interaction");
    var_837c12743ab916fe = undefined;

    if(isDefined(self.lookat_anims["interaction_position"])) {
      var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    } else {
      var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
    follow_percent = math::normalize_value(0, 360, angle);
    println("<dev string:x1c>" + angle);
    reaction_anim = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"])) {
      foreach(reaction_angle in self.lookat_anims["angles"]) {
        if(angle <= reaction_angle) {
          reaction_anim = self.lookat_anims[reaction_angle];
          break;
        }
      }
    }

    if(isDefined(optional_struct)) {
      start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, reaction_anim);
      start_angles = getstartangles(optional_struct.origin, optional_struct.angles, reaction_anim);
      self forceteleport(start_origin, start_angles);
    }

    start_fakeactor_notetracks(reaction_anim);
    self setflaggedanim(anim_string, reaction_anim, 1, initial_reaction_blendtime);
    wait_time = getanimlength(reaction_anim);
    wait wait_time;
    self clearanim(reaction_anim, lookat_end_blendtime);
    level notify("interaction_done");
    self notify("interaction_done");
  }
}

function interaction_follow_process() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  starting_idle = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["idle"])) {
    starting_idle = self.lookat_anims["idle"][0];
    thread random_idle_controller();
  } else {
    starting_idle = self.lookat_anims["idle"];
  }

  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim("idle", starting_idle, 1, 0.5, 1);
  thread interaction_set_anim_movement("stop");
  anim_string = "single anim";

  if(!ent_flag_exist("scene_end")) {
    ent_flag_init("scene_end");
  }

  ent_flag_clear("scene_end");

  if(!ent_flag_exist("playing_interaction")) {
    ent_flag_init("playing_interaction");
  }

  ent_flag_clear("playing_interaction");
  lookat_lerp = 0.11;
  initial_reaction_blendtime = 0.25;
  lookat_follow_blendtime = 0.25;
  lookat_end_distance = 350;
  lookat_end_blendtime = 0.45;
  using_reacquire = undefined;
  reacquire_started = undefined;
  var_9ef180b6a072474b = undefined;

  if(isDefined(self.lookat_anims["reacquire_left"]) || isDefined(self.lookat_anims["reacquire_right"])) {
    using_reacquire = 1;
  }

  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);

  while(true) {
    if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
      if(self.sequential_scene) {
        self.skip_interaction = 1;
      } else {
        self.skip_interaction = 0;
      }
    } else {
      self.skip_interaction = 0;
    }

    var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
    trace_end = undefined;
    tracecontents = create_contents(1, 1, 0, 1, 1, 1);
    trace = undefined;

    while(true) {
      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2)) {
        if(isDefined(self.lookat_anims["interaction_position"])) {
          var_84d1d51d3f40043 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
        } else {
          var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        } else if(self.lookat_anims["trigger_radius"] > 0 && var_84d1d51d3f40043 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          actor_eye = self.origin + anglestoup(self.angles) * 66;
          trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["trigger_radius"] + actor_eye;
          trace = ray_trace(actor_eye, trace_end, self, tracecontents);

          if(isPlayer(trace["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
            break;
          }
        }
      }

      waitframe();
    }

    if(isDefined(self.lookat_anims["common_name"])) {
      thread scripts\sp\interaction_manager::trigger_interaction_common();
    }

    self.is_playing_reaction = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_837c12743ab916fe = undefined;

    if(isDefined(self.lookat_anims["interaction_position"])) {
      var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    } else {
      var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
    follow_percent = math::normalize_value(0, 360, angle);

    if(isDefined(self.lookat_anims["backseam"])) {
      if(follow_percent >= 0 && follow_percent <= 0.5) {
        follow_percent += 0.5;
      } else {
        follow_percent -= 0.5;
      }
    }

    println("<dev string:x1c>" + angle);
    reaction_anim = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"]) && !self.sequential_scene) {
      foreach(reaction_angle in self.lookat_anims["angles"]) {
        if(angle <= reaction_angle) {
          reaction_anim = self.lookat_anims[reaction_angle];
          break;
        }
      }
    }

    if(isarray(reaction_anim)) {
      if(isarray(reaction_anim[0])) {
        var_1511386e758ef855 = self.anim_sequential_counter;
        var_e88ef0694a45c625 = reaction_anim[0][var_1511386e758ef855][0];
      } else {
        var_e88ef0694a45c625 = reaction_anim[0];
      }
    } else {
      var_e88ef0694a45c625 = reaction_anim;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var_e88ef0694a45c625);
      self setflaggedanimknob(anim_string, var_e88ef0694a45c625, 1, initial_reaction_blendtime, 1);
      self.is_playing_reaction = 1;
    }

    if(!self.skip_interaction) {
      if(isarray(reaction_anim)) {
        if(isarray(reaction_anim[0]) && !isarray(self.lookat_anims["diff"])) {
          var_1511386e758ef855 = self.anim_sequential_counter;
          vo_array = reaction_anim[0][var_1511386e758ef855];
          thread set_sequential_wait_time(vo_array);
          thread play_anim_vo_sequential(vo_array);
        } else if(reaction_anim.size > 1) {
          thread play_anim_vo_sequential(reaction_anim);
        }
      }
    }

    if(isDefined(self.lookat_anims["reaction_func"])) {
      self thread[[self.lookat_anims["reaction_func"]]]();
    }

    var_2c3d71c250a9405d = getanimlength(var_e88ef0694a45c625);
    var_2c3d71c250a9405d -= lookat_follow_blendtime;

    if(var_2c3d71c250a9405d < 0) {
      var_2c3d71c250a9405d = 0;
    }

    if(!self.skip_interaction) {
      wait var_2c3d71c250a9405d;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(self.lookat_anims["follow"]);
      self setflaggedanimlimited(anim_string, self.lookat_anims["follow"], 1, 0.25, 1);
      self setanimtime(self.lookat_anims["follow"], follow_percent);
      self setanimknob(self.lookat_anims["ring"], 1, lookat_follow_blendtime, 1);
    }

    diff_anim = undefined;

    if(isarray(self.lookat_anims["diff"])) {
      var_1511386e758ef855 = self.anim_sequential_counter;
      diff_anim = self.lookat_anims["diff"][var_1511386e758ef855];
    } else {
      diff_anim = self.lookat_anims["diff"];
    }

    start_fakeactor_notetracks(diff_anim);
    self setflaggedanimlimited(anim_string, diff_anim, 1, 0.25, 1);
    self.is_playing_reaction = 1;

    if(!self.skip_interaction) {
      self setanimlimited(self.lookat_anims["additive"], 1, lookat_follow_blendtime, 1);
    }

    delaythread(getanimlength(diff_anim), &ent_flag_set, "scene_end");
    ent_flag_set("playing_interaction");
    thread ent_flag_clear_delayed("playing_interaction", getanimlength(diff_anim));
    var_8bc1a6a78e77c5d1 = follow_percent;

    while(true) {
      var_ac24b8027c653bef = distance2d(level.player.origin, self.origin);

      if((var_ac24b8027c653bef >= lookat_end_distance || ent_flag("scene_end")) && !isDefined(using_reacquire)) {
        var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);

        if(var_84d1d51d3f40043 < squared(self.lookat_anims["trigger_radius"])) {
          actor_eye = self.origin + anglestoup(self.angles) * 66;
          trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["trigger_radius"] + actor_eye;
          trace = ray_trace(actor_eye, trace_end, self, tracecontents);

          if(isPlayer(trace["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
            if(isarray(self.lookat_anims["diff"]) && self.anim_sequential_counter < self.lookat_anims["diff"].size - 1) {
              self.sequential_scene = 1;
              ent_flag_clear("scene_end");
              self.anim_sequential_counter += 1;
              self clearanim(diff_anim, 0.15);
              self.is_playing_reaction = 0;
              break;
            }
          }
        }

        if(isDefined(self.lookat_anims["exitangles"])) {
          exit_anim = self.lookat_anims["exitangles_anims"]["lastexitanim"];

          if(isDefined(self.lookat_anims["interaction_position"])) {
            var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
          } else {
            var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
          }

          angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
          println("<dev string:x1c>" + angle);

          foreach(exit_angle in self.lookat_anims["exitangles"]) {
            if(angle <= exit_angle) {
              exit_anim = self.lookat_anims["exitangles_anims"][exit_angle];
              break;
            }
          }

          start_fakeactor_notetracks(exit_anim);
          self setflaggedanimknob(anim_string, exit_anim, 1, lookat_end_blendtime, 1);
          wait getanimlength(exit_anim);

          if(isDefined(self.lookat_anims["end_idle"])) {
            if(isarray(reaction_anim[0])) {
              if(self.anim_sequential_counter >= reaction_anim[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
                self setflaggedanimknob(anim_string, self.lookat_anims["end_idle"], 1, lookat_end_blendtime, 1);
              } else {
                start_fakeactor_notetracks(starting_idle);
                self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
              self setflaggedanimknob(anim_string, self.lookat_anims["end_idle"], 1, lookat_end_blendtime, 1);
            }
          } else {
            start_fakeactor_notetracks(starting_idle);
            self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims["diff"])) {
            if(self.anim_sequential_counter < self.lookat_anims["diff"].size) {
              ent_flag_clear("scene_end");
              self clearanim(self.lookat_anims["follow"], 0.1);
              self clearanim(self.lookat_anims["ring"], 0.1);
              self.anim_sequential_counter += 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims["diff"].size) {
              self.is_playing_reaction = 0;
              var_9ef180b6a072474b = 1;

              if(!isDefined(self.lookat_anims["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var_9ef180b6a072474b = 1;

            if(!isDefined(self.lookat_anims["allow_multi_use"])) {
              self waittill("forever");
            }
          }

          self.is_playing_reaction = 0;
          break;
        } else {
          if(isDefined(self.lookat_anims["end_idle"])) {
            if(isarray(reaction_anim[0])) {
              if(self.anim_sequential_counter >= reaction_anim[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
                self setflaggedanimknob(anim_string, self.lookat_anims["end_idle"], 1, lookat_end_blendtime, 1);
              } else {
                start_fakeactor_notetracks(starting_idle);
                self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
              self setflaggedanimknob(anim_string, self.lookat_anims["end_idle"], 1, lookat_end_blendtime, 1);
            }
          } else {
            start_fakeactor_notetracks(starting_idle);
            self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims["diff"])) {
            if(self.anim_sequential_counter < self.lookat_anims["diff"].size) {
              ent_flag_clear("scene_end");
              self clearanim(self.lookat_anims["follow"], 0.1);
              self clearanim(self.lookat_anims["ring"], 0.1);
              self.anim_sequential_counter += 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims["diff"].size) {
              self.is_playing_reaction = 0;
              var_9ef180b6a072474b = 1;

              if(!isDefined(self.lookat_anims["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var_9ef180b6a072474b = 1;

            if(!isDefined(self.lookat_anims["allow_multi_use"])) {
              self waittill("forever");
            }
          }

          self.is_playing_reaction = 0;
          break;
        }
      }

      if(isDefined(self.lookat_anims["interaction_position"])) {
        var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
      follow_percent = math::normalize_value(0, 360, angle);

      if(self.followoff) {
        follow_percent = 0;
      }

      if(isDefined(self.lookat_anims["backseam"])) {
        if(follow_percent >= 0 && follow_percent <= 0.5) {
          follow_percent += 0.5;
        } else {
          follow_percent -= 0.5;
        }

        var_8bc1a6a78e77c5d1 += (follow_percent - var_8bc1a6a78e77c5d1) * lookat_lerp;
      } else {
        var_8bc1a6a78e77c5d1 += (follow_percent - var_8bc1a6a78e77c5d1) * lookat_lerp;
      }

      if(isDefined(using_reacquire)) {
        vec_to_player = vectorNormalize(level.player.origin - self.origin);
        vec_to_player = flatten_vector(vec_to_player, anglestoup(self.angles));
        var_58789c337a81799f = anglesToForward(self.angles);
        dot_angle = vectordot(vec_to_player, var_58789c337a81799f);
        angle = acos(dot_angle);
        cross = vectorcross(vec_to_player, var_58789c337a81799f);

        if(vectordot(cross, anglestoup(self.angles)) < 0) {
          angle *= -1;
        }

        var_633b54f5d37b7d94 = 0;

        if(angle >= 90 && !var_633b54f5d37b7d94 && !ent_flag("playing_interaction")) {
          var_633b54f5d37b7d94 = 1;
          start_fakeactor_notetracks(self.lookat_anims["reacquire_right"]);
          self clearanim(%body, 0.25);
          self setflaggedanimrestart(anim_string, self.lookat_anims["reacquire_right"], 1, 0.25);
          wait clamp(getanimlength(self.lookat_anims["reacquire_right"]) - 0.25, 0, 100);
          self clearanim(self.lookat_anims["reacquire_right"], 0.25);
        } else if(angle < -90 && !var_633b54f5d37b7d94 && !ent_flag("playing_interaction")) {
          var_633b54f5d37b7d94 = 1;
          start_fakeactor_notetracks(self.lookat_anims["reacquire_left"]);
          self clearanim(%body, 0.25);
          self setflaggedanimrestart(anim_string, self.lookat_anims["reacquire_left"], 1, 0.25);
          wait clamp(getanimlength(self.lookat_anims["reacquire_left"]) - 0.25, 0, 100);
          self clearanim(self.lookat_anims["reacquire_left"], 0.25);
        } else {
          set_time_via_rate(self.lookat_anims["follow"], var_8bc1a6a78e77c5d1);
        }

        if(var_633b54f5d37b7d94) {
          if(isDefined(self.lookat_anims["interaction_position"])) {
            var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
          } else {
            var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
          }

          angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
          follow_percent = math::normalize_value(0, 360, angle);
          start_fakeactor_notetracks(self.lookat_anims["follow"]);
          self setflaggedanimlimited(anim_string, self.lookat_anims["follow"], 1, 0.25, 1);
          self setanimtime(self.lookat_anims["follow"], 0.5);
          self setanimknob(self.lookat_anims["ring"], 1, lookat_follow_blendtime, 1);

          if(!ent_flag("playing_interaction") && !ent_flag("scene_end")) {
            start_fakeactor_notetracks(self.lookat_anims["diff"]);
            self setflaggedanimlimited(anim_string, self.lookat_anims["diff"], 1, 0.05, 1);
          }

          self setanimlimited(self.lookat_anims["additive"], 1, lookat_follow_blendtime, 1);
          var_8bc1a6a78e77c5d1 = 0.5;
        }
      } else {
        set_time_via_rate(self.lookat_anims["follow"], var_8bc1a6a78e77c5d1);
      }

      waitframe();
    }

    waitframe();
  }
}

function interaction_process() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  starting_idle = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["idle"])) {
    starting_idle = self.lookat_anims["idle"][0];
    thread random_idle_controller();
  } else {
    starting_idle = self.lookat_anims["idle"];
  }

  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim("idle", starting_idle, 1, 0.05, 1);
  thread interaction_set_anim_movement("stop");
  anim_string = "single anim";

  if(!ent_flag_exist("scene_end")) {
    ent_flag_init("scene_end");
  }

  ent_flag_clear("scene_end");
  lookat_lerp = 0.11;

  if(isDefined(self.lookat_anims["lookat_lerp"])) {
    lookat_lerp = self.lookat_anims["lookat_lerp"];
  }

  initial_reaction_blendtime = 0.25;

  if(isDefined(self.lookat_anims["initial_reaction_blendtime"])) {
    initial_reaction_blendtime = self.lookat_anims["initial_reaction_blendtime"];
  }

  lookat_follow_blendtime = 0.25;

  if(isDefined(self.lookat_anims["lookat_follow_blendtime"])) {
    lookat_follow_blendtime = self.lookat_anims["lookat_follow_blendtime"];
  }

  lookat_end_distance = 350;

  if(isDefined(self.lookat_anims["lookat_end_distance"])) {
    lookat_end_distance = self.lookat_anims["lookat_end_distance"];
  }

  lookat_end_blendtime = 0.45;

  if(isDefined(self.lookat_anims["lookat_end_blendtime"])) {
    lookat_end_blendtime = self.lookat_anims["lookat_end_blendtime"];
  }

  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);

  while(true) {
    if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
      if(self.sequential_scene) {
        self.skip_interaction = 1;
      } else {
        self.skip_interaction = 0;
      }
    } else {
      self.skip_interaction = 0;
    }

    var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
    trace_end = undefined;
    tracecontents = create_contents(1, 1, 0, 1, 1, 1);
    trace = undefined;

    while(true) {
      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2)) {
        if(isDefined(self.lookat_anims["interaction_position"])) {
          var_84d1d51d3f40043 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
        } else {
          var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        } else if(self.lookat_anims["trigger_radius"] > 0 && var_84d1d51d3f40043 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          actor_eye = self.origin + anglestoup(self.angles) * 66;
          trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["trigger_radius"] + actor_eye;
          trace = ray_trace(actor_eye, trace_end, self, tracecontents);

          if(isPlayer(trace["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
            break;
          }
        }
      }

      waitframe();
    }

    if(isDefined(self.lookat_anims["common_name"])) {
      thread scripts\sp\interaction_manager::trigger_interaction_common();
    }

    self.is_playing_reaction = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_837c12743ab916fe = undefined;

    if(isDefined(self.lookat_anims["interaction_position"])) {
      var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    } else {
      var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
    println("<dev string:x1c>" + angle);
    reaction_anim = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"])) {
      foreach(reaction_angle in self.lookat_anims["angles"]) {
        if(angle <= reaction_angle) {
          reaction_anim = self.lookat_anims[reaction_angle];
          break;
        }
      }
    }

    if(isarray(reaction_anim)) {
      if(isarray(reaction_anim[0]) && self.anim_sequential_counter < reaction_anim[0].size) {
        var_1511386e758ef855 = self.anim_sequential_counter;
        var_e88ef0694a45c625 = reaction_anim[0][var_1511386e758ef855][0];
      } else {
        var_e88ef0694a45c625 = reaction_anim[0];
      }
    } else {
      var_e88ef0694a45c625 = reaction_anim;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var_e88ef0694a45c625);
      self setflaggedanimknob(anim_string, var_e88ef0694a45c625, 1, initial_reaction_blendtime, 1);
      self.is_playing_reaction = 1;
    }

    level thread scripts\sp\interaction_manager::interaction_cooldown_timer(self);

    if(isDefined(self.lookat_anims["scene"])) {
      if(isDefined(self.lookat_anims["interaction_position"])) {
        var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);

      if(self.skip_interaction) {
        wait 0;
      } else {
        wait getanimlength(var_e88ef0694a45c625);
      }

      if(isarray(self.lookat_anims["scene"])) {
        current_index = self.scene_sequential_sounter;
        start_fakeactor_notetracks(self.lookat_anims["scene"][current_index]);
        self setflaggedanimknob(anim_string, self.lookat_anims["scene"][current_index], 1, lookat_follow_blendtime, 1);
        wait getanimlength(self.lookat_anims["scene"][current_index]);
        self.scene_sequential_sounter += 1;
        self.sequential_scene = 1;
      } else {
        start_fakeactor_notetracks(self.lookat_anims["scene"]);
        self setflaggedanimknob(anim_string, self.lookat_anims["scene"], 1, lookat_follow_blendtime, 1);
        wait getanimlength(self.lookat_anims["scene"]);
      }
    }

    if(isDefined(self.lookat_anims["exitangles"])) {
      if(isDefined(self.lookat_anims["interaction_position"])) {
        var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
      println("<dev string:x1c>" + angle);
      exit_anim = self.lookat_anims["exitangles_anims"]["lastexitanim"];

      foreach(exit_angle in self.lookat_anims["exitangles"]) {
        if(angle <= exit_angle) {
          exit_anim = self.lookat_anims["exitangles_anims"][exit_angle];
          break;
        }
      }

      start_fakeactor_notetracks(exit_anim);
      self setflaggedanimknob(anim_string, exit_anim, 1, lookat_end_blendtime, 1);
      wait getanimlength(exit_anim);

      if(isDefined(self.lookat_anims["end_idle"])) {
        if(isarray(reaction_anim[0])) {
          if(self.anim_sequential_counter >= reaction_anim[0].size) {
            start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
            self setflaggedanimknob(anim_string, self.lookat_anims["end_idle"], 1, lookat_end_blendtime, 1);
          } else {
            start_fakeactor_notetracks(starting_idle);
            self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
          }
        } else {
          start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
          self setflaggedanimknob(anim_string, self.lookat_anims["end_idle"], 1, lookat_end_blendtime, 1);
        }
      } else {
        start_fakeactor_notetracks(starting_idle);
        self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
      }

      self.is_playing_reaction = 0;

      if(!isDefined(self.lookat_anims["allow_multi_use"])) {
        self waittill("forever");
      }
    }

    if(!self.skip_interaction) {
      if(isarray(reaction_anim)) {
        if(isarray(reaction_anim[0]) && self.anim_sequential_counter < reaction_anim[0].size) {
          var_1511386e758ef855 = self.anim_sequential_counter;
          vo_array = reaction_anim[0][var_1511386e758ef855];
          thread set_sequential_wait_time(vo_array);
          thread play_anim_vo_sequential(vo_array);
        } else if(reaction_anim.size > 1) {
          thread play_anim_vo_sequential(reaction_anim);
        }
      }
    }

    if(isDefined(self.lookat_anims["reaction_func"])) {
      self[[self.lookat_anims["reaction_func"]]]();
    }

    var_2c3d71c250a9405d = getanimlength(var_e88ef0694a45c625);
    wait var_2c3d71c250a9405d;

    if(isDefined(self.lookat_anims["end_idle"])) {
      if(isarray(reaction_anim)) {
        if(isarray(reaction_anim[0])) {
          start_fakeactor_notetracks();

          if(self.anim_sequential_counter >= reaction_anim[0].size - 1) {
            self setflaggedanimknoball(anim_string, self.lookat_anims["end_idle"], %body, 1, lookat_end_blendtime, 1);
          } else {
            self setflaggedanimknoball(anim_string, starting_idle, %body, 1, lookat_end_blendtime, 1);
          }
        } else {
          self setflaggedanimknoball(anim_string, self.lookat_anims["end_idle"], %body, 1, lookat_end_blendtime, 1);
        }
      } else {
        start_fakeactor_notetracks();
        self setflaggedanimknoball(anim_string, self.lookat_anims["end_idle"], %body, 1, lookat_end_blendtime, 1);
      }
    } else {
      start_fakeactor_notetracks();
      self setflaggedanimknoball(anim_string, starting_idle, %body, 1, lookat_end_blendtime, 1);
    }

    self.anim_sequential_counter += 1;
    level notify("interaction_done");
    self notify("interaction_done");

    if(isarray(reaction_anim)) {
      if(isarray(reaction_anim[0]) && self.anim_sequential_counter < reaction_anim[0].size) {
        var_c838814a0c155ab8 = self.sequential_loop_padding + self.sequential_wait_time - getanimlength(var_e88ef0694a45c625);
        max_wait_time = self.sequential_loop_padding + self.sequential_wait_time + getanimlength(var_e88ef0694a45c625);
        var_19c9e7491a3fee8c = clamp(var_c838814a0c155ab8, 0, max_wait_time);
        wait var_19c9e7491a3fee8c;
        self clearanim(var_e88ef0694a45c625, 0.1);
        self.is_playing_reaction = 0;
      } else {
        self.is_playing_reaction = 0;

        if(!isDefined(self.lookat_anims["allow_multi_use"])) {
          self waittill("forever");
        }
      }
    } else {
      self.is_playing_reaction = 0;

      if(!isDefined(self.lookat_anims["allow_multi_use"])) {
        self waittill("forever");
      }
    }

    waitframe();
  }
}

function interaction_process_for_states() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  starting_idle = undefined;
  self.random_idle_playing = 0;
  interaction = get_state_interaction(self.interaction_name);

  if(!isDefined(interaction)) {
    return;
  }

  interaction = interaction.scene;
  var_961e7b22dd3c0cdc = undefined;

  if(isarray(interaction["idle"])) {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_961e7b22dd3c0cdc = "idle_female";
    } else {
      var_961e7b22dd3c0cdc = "idle";
    }

    starting_idle = interaction[var_961e7b22dd3c0cdc][0];
    thread random_idle_controller_stateful();
  } else {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_961e7b22dd3c0cdc = "idle_female";
    } else {
      var_961e7b22dd3c0cdc = "idle";
    }

    starting_idle = interaction[var_961e7b22dd3c0cdc];
  }

  anim_string = "single anim";
  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim(anim_string, starting_idle, 1, 0.5, 1);
  self setanimtime(starting_idle, randomfloat(1));
  thread interaction_set_anim_movement("stop");
  thread play_anim_shared_vo();

  if(!ent_flag_exist("scene_end")) {
    ent_flag_init("scene_end");
  }

  ent_flag_clear("scene_end");
  lookat_lerp = 0.11;
  initial_reaction_blendtime = 0.25;
  lookat_follow_blendtime = 0.25;
  lookat_end_distance = 350;
  lookat_end_blendtime = 0.45;
  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, interaction["trigger_radius"], interaction["trigger_radius"]);

  while(true) {
    var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
    trace_end = undefined;
    tracecontents = create_contents(1, 1, 0, 1, 1, 1);
    trace = undefined;

    while(true) {
      if(!isDefined(self.reaction_state) || isDefined(self.reaction_state) && self.reaction_state != "busy" && self.reaction_state != "nag") {
        if(scripts\sp\interaction_manager::can_play_nearby_interaction(interaction["trigger_radius"] * 2)) {
          if(isDefined(interaction["interaction_position"])) {
            var_84d1d51d3f40043 = lengthsquared(interaction["interaction_position"] - self.origin);
          } else {
            var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
          }

          if(isDefined(interaction["interaction_trigger_override"])) {
            break;
          } else if(interaction["trigger_radius"] > 0 && var_84d1d51d3f40043 < squared(interaction["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
            actor_eye = self.origin + anglestoup(self.angles) * 66;
            trace_end = vectorNormalize(level.player getEye() - actor_eye) * interaction["trigger_radius"] + actor_eye;
            trace = ray_trace(actor_eye, trace_end, self, tracecontents);

            if(isPlayer(trace["entity"]) || isDefined(interaction["interaction_trigger_override"])) {
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
    var_837c12743ab916fe = undefined;

    if(isDefined(interaction["interaction_position"])) {
      var_837c12743ab916fe = vectortoangles(interaction["interaction_position"] - self.origin);
    } else {
      var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
    println("<dev string:x1c>" + angle);
    chosen_angle = "lastanim";

    if(isDefined(interaction["angles"])) {
      foreach(reaction_angle in interaction["angles"]) {
        if(angle <= reaction_angle) {
          chosen_angle = reaction_angle;
          break;
        }
      }
    }

    if(level.state_interactions[self.interaction_name].scene[chosen_angle].size < 1) {
      level.state_interactions[self.interaction_name].scene[chosen_angle] = level.state_interactions[self.interaction_name].scene["angle_" + string(chosen_angle) + "_spent"];
      level.state_interactions[self.interaction_name].scene["angle_" + chosen_angle + "_spent"] = [];
    }

    random_index = randomint(level.state_interactions[self.interaction_name].scene[chosen_angle].size);
    var_e88ef0694a45c625 = level.state_interactions[self.interaction_name].scene[chosen_angle][random_index];
    start_fakeactor_notetracks(var_e88ef0694a45c625);
    self setflaggedanimknob(anim_string, var_e88ef0694a45c625, 1, initial_reaction_blendtime, 1);
    self.is_playing_reaction = 1;
    thread scripts\sp\interaction_manager::interaction_reboot_timer();
    wait getanimlength(var_e88ef0694a45c625);
    level.state_interactions[self.interaction_name].scene["angle_" + chosen_angle + "_spent"] = array_add(level.state_interactions[self.interaction_name].scene["angle_" + chosen_angle + "_spent"], var_e88ef0694a45c625);
    level.state_interactions[self.interaction_name].scene[chosen_angle] = array_remove(level.state_interactions[self.interaction_name].scene[chosen_angle], var_e88ef0694a45c625);

    if(isDefined(interaction["exitangles"])) {
      if(isDefined(interaction["interaction_position"])) {
        var_837c12743ab916fe = vectortoangles(interaction["interaction_position"] - self.origin);
      } else {
        var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
      println("<dev string:x1c>" + angle);
      var_e2d055545bfcb308 = "lastexitanim";

      foreach(exit_angle in interaction["exitangles"]) {
        if(angle <= exit_angle) {
          var_e2d055545bfcb308 = exit_angle;
          break;
        }
      }

      if(level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308].size < 1) {
        level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308][var_e2d055545bfcb308] = level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308]["exit_angle_" + string(var_e2d055545bfcb308) + "_spent"];
        level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308]["exit_angle_" + string(var_e2d055545bfcb308) + "_spent"] = [];
      }

      random_index = randomint(level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308].size);
      var_d56c071dcfc44b88 = level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308][random_index];
      start_fakeactor_notetracks(var_d56c071dcfc44b88);
      self setflaggedanimknob(anim_string, var_d56c071dcfc44b88, 1, lookat_end_blendtime, 1);
      wait getanimlength(var_d56c071dcfc44b88);
      level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308] = array_remove(level.state_interactions[self.interaction_name].scene[var_e2d055545bfcb308], var_d56c071dcfc44b88);
    }

    start_fakeactor_notetracks(starting_idle);
    self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
    self.is_playing_reaction = 0;

    if(isDefined(interaction["reaction_func"])) {
      self[[interaction["reaction_func"]]]();
    }

    level notify("interaction_done");
    thread scripts\sp\interaction_manager::set_reaction_state("busy");
    waitframe();
    level waittill("forever");
  }
}

function interaction_process_blended() {
  self endon("death");
  self endon("reaction_end");
  initialize_blending_actor();
  lookat_lerp = 0.11;
  initial_reaction_blendtime = 0.25;
  lookat_follow_blendtime = 0.25;
  lookat_end_distance = 350;
  starting_idle = setup_blend_interaction_idles();
  anim_string = "single anim";

  while(true) {
    self.skip_interaction = is_performing_sequential_scene();
    blended_interaction_tracecheck();
    self.is_playing_reaction = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");

    if(isDefined(self.lookat_anims["common_name"])) {
      thread scripts\sp\interaction_manager::trigger_interaction_common();
    }

    play_blended_interaction_anims();
    waitframe();
  }
}

function initialize_blending_actor() {
  self stopanimScripted();
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  if(!ent_flag_exist("scene_end")) {
    ent_flag_init("scene_end");
  }

  ent_flag_clear("scene_end");
  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);
}

function setup_blend_interaction_idles() {
  starting_idle = get_interaction_starting_idle();
  self.random_idle_playing = 0;
  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim("single anim", starting_idle, 1, 0.05, 1);
  thread interaction_set_anim_movement("stop");
}

function get_interaction_starting_idle() {
  starting_idle = undefined;

  if(isarray(self.lookat_anims["idle"])) {
    starting_idle = self.lookat_anims["idle"][0];
  } else {
    starting_idle = self.lookat_anims["idle"];
  }

  return starting_idle;
}

function is_performing_sequential_scene() {
  skip_interaction = undefined;

  if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
    if(self.sequential_scene) {
      skip_interaction = 1;
    } else {
      skip_interaction = 0;
    }
  } else {
    skip_interaction = 0;
  }

  return skip_interaction;
}

function blended_interaction_tracecheck() {
  var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
  trace_end = undefined;
  tracecontents = create_contents(1, 1, 0, 1, 1, 1);
  trace = undefined;

  while(true) {
    var_365d60e0212d332f = scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2);

    if(var_365d60e0212d332f) {
      if(isDefined(self.lookat_anims["interaction_position"])) {
        var_84d1d51d3f40043 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
      }

      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      } else if(self.lookat_anims["trigger_radius"] > 0 && var_84d1d51d3f40043 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
        actor_eye = self.origin + anglestoup(self.angles) * 66;
        trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["trigger_radius"] + actor_eye;
        trace = ray_trace(actor_eye, trace_end, self, tracecontents);

        if(isPlayer(trace["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        }
      }
    }

    waitframe();
  }
}

function play_blended_interaction_anims() {
  initialize_blended_interaction_anims();
  var_3a58e25d07fa8963 = 0;
  var_9e41f6b2a5fdfa6c = 0;
  start_time = gettime() / 1000;
  wait_time = getanimlength(self.lookat_anims["fwd_anim"]);

  while(gettime() / 1000 - start_time < wait_time) {
    vec_to_player = vectorNormalize(level.player.origin - self.origin);
    forward_vec = anglesToForward(self.angles);
    back_vec = anglesToForward(self.angles) * -1;
    right_vec = anglestoright(self.angles);
    left_vec = anglestoright(self.angles) * -1;
    up_vec = anglestoup(self.angles);
    dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0.005, 1);
    dot_right = clamp(vectordot(vec_to_player, right_vec), 0.005, 1);
    dot_left = clamp(vectordot(vec_to_player, left_vec), 0.005, 1);
    dot_back = clamp(vectordot(vec_to_player, back_vec), 0.005, 1);
    self setanimlimited(self.lookat_anims["right_anim"], dot_right, 0.2);
    self setanimlimited(self.lookat_anims["left_anim"], dot_left, 0.2);
    self setflaggedanimlimited("single anim", self.lookat_anims["fwd_anim"], dot_fwd + 0.005, 0.2);
    back_test = 1;

    if(anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    if(back_test) {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, dot_back, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, 0.005, 0.1);
    } else {
      var_9e41f6b2a5fdfa6c = math::lerp(var_9e41f6b2a5fdfa6c, 0.005, 0.1);
      var_3a58e25d07fa8963 = math::lerp(var_3a58e25d07fa8963, dot_back, 0.1);
    }

    self setanimlimited(self.lookat_anims["back_right_anim"], var_9e41f6b2a5fdfa6c, 0.2);
    self setanimlimited(self.lookat_anims["back_left_anim"], var_3a58e25d07fa8963, 0.2);
    waitframe();
  }

  ending_blendtime = 0.45;
  end_blended_interaction_anims(ending_blendtime);
  play_interaction_endidle(ending_blendtime);
}

function initialize_blended_interaction_anims() {
  var_837c12743ab916fe = undefined;
  var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
  self.is_playing_reaction = 1;
  level thread scripts\sp\interaction_manager::interaction_cooldown_timer(self);
  self setanimlimited(self.lookat_anims["interaction_blend_parent"], 1, 0.2);
  starting_idle = get_interaction_starting_idle();
  self clearanim(starting_idle, 0.2);
  self clearanim(%head, 0.2);
  start_fakeactor_notetracks(self.lookat_anims["fwd_anim"]);
  self setflaggedanimlimited("single anim", self.lookat_anims["fwd_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["right_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["left_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["back_right_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["back_left_anim"], 0.005, 0.05);
}

function end_blended_interaction_anims(blendtime) {
  self.reaction_blend_end = undefined;
  self clearanim(self.lookat_anims["fwd_anim"], blendtime);
  self clearanim(self.lookat_anims["right_anim"], blendtime);
  self clearanim(self.lookat_anims["left_anim"], blendtime);
  self clearanim(self.lookat_anims["back_right_anim"], blendtime);
  self clearanim(self.lookat_anims["back_left_anim"], blendtime);
  level notify("interaction_done");
  self notify("interaction_done");
  self.is_playing_reaction = 0;
}

function play_interaction_endidle(blendtime) {
  while(true) {
    animtoplay = undefined;

    if(isDefined(self.lookat_anims["end_idle"])) {
      animtoplay = self.lookat_anims["end_idle"];
      start_fakeactor_notetracks(animtoplay);
      self setanimtime(animtoplay, 0);
      self setflaggedanimknoball("single anim", animtoplay, %body, 1, blendtime, 1);
    } else {
      animtoplay = get_interaction_starting_idle();
      start_fakeactor_notetracks(animtoplay);
      self setanimtime(animtoplay, 0);
      self setflaggedanimknoball("single anim", animtoplay, %body, 1, blendtime, 1);
    }

    wait getanimlength(animtoplay);
  }
}

function simple_interaction_idles() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  interaction = get_interaction(self.interaction_name);

  if(!ent_flag_exist("hold_simple_idles")) {
    ent_flag_init("hold_simple_idles");
  } else {
    ent_flag_clear("hold_simple_idles");
  }

  if(!isarray(interaction.scene["idle"])) {
    return;
  }

  if(isarray(interaction.scene["idle"]) && interaction.scene["idle"].size <= 1) {
    return;
  }

  spent_array = [];
  anim_array = interaction.scene["idle"];
  starting_idle = anim_array[0];
  anim_array = array_remove_index(anim_array, 0);
  spent_array_prop = undefined;
  var_69db5a62c886cb68 = undefined;
  var_7a8dcef989dbd61a = undefined;
  var_374762e6ea6a151f = undefined;

  if(isDefined(interaction.scene["idle_prop"]) && isDefined(self.optional_prop)) {
    spent_array_prop = [];
    interaction.scene["spent_array_prop"] = spent_array_prop;
    var_7a8dcef989dbd61a = interaction.scene["idle_prop"];
    var_69db5a62c886cb68 = var_7a8dcef989dbd61a[0];
    var_7a8dcef989dbd61a = array_remove_index(var_7a8dcef989dbd61a, 0);
    var_374762e6ea6a151f = var_7a8dcef989dbd61a;
    var_7a8dcef989dbd61a = undefined;
  }

  idle_array = anim_array;
  anim_array = undefined;
  thread clear_root();
  interaction_set_anim_movement("stop");

  while(true) {
    if(isDefined(self.optional_struct)) {
      _set_node_relative_anim_actor(self.optional_struct, starting_idle);
    }

    start_fakeactor_notetracks(starting_idle);
    self setflaggedanimknob("single anim", starting_idle, 1, 0.2, 1);
    thread scripts\asm\gesture\script_funcs::ai_lookat_release();

    if(isDefined(self.optional_prop)) {
      thread _simple_interaction_prop_start(var_69db5a62c886cb68);
    }

    wait getanimlength(starting_idle) * randomintrange(1, 2);

    while(ent_flag("hold_simple_idles")) {
      wait getanimlength(starting_idle);
    }

    if(idle_array.size <= 0) {
      idle_array = spent_array;
      spent_array = [];
    }

    anim_index = randomint(idle_array.size);
    random_anim = idle_array[anim_index];
    spent_array = array_add(spent_array, random_anim);
    idle_array = array_remove_index(idle_array, anim_index);

    if(isDefined(self.optional_prop)) {
      if(var_374762e6ea6a151f.size <= 0) {
        var_374762e6ea6a151f = spent_array_prop;
        spent_array_prop = [];
      }

      var_bf114bb6b7e12922 = var_374762e6ea6a151f[anim_index];
      spent_array_prop = array_add(spent_array_prop, var_bf114bb6b7e12922);
      var_374762e6ea6a151f = array_remove_index(var_374762e6ea6a151f, anim_index);
      thread _simple_interaction_prop_random_anim(var_bf114bb6b7e12922);
    }

    self clearanim(starting_idle, 0.2);

    if(isDefined(self.optional_struct)) {
      _set_node_relative_anim_actor(self.optional_struct, random_anim);
    }

    start_fakeactor_notetracks(random_anim);
    self setflaggedanimknob("single anim", random_anim, 1, 0.2, 1);
    thread scripts\asm\gesture\script_funcs::ai_lookat_hold();
    wait getanimlength(random_anim);
    self clearanim(random_anim, 0.2);

    if(isDefined(self.optional_prop)) {
      thread _simple_interaction_prop_clear();
    }

    waitframe();
  }
}

function _set_node_relative_anim_actor(scripted_node, animation) {
  pos = getstartorigin(scripted_node.origin, scripted_node.angles, animation);
  ang = getstartangles(scripted_node.origin, scripted_node.angles, animation);

  if(!isDefined(self.is_cheap)) {
    self forceteleport(pos, ang, 100000);
    wait 0.05;
    return;
  }

  self.origin = pos;
  self.angles = ang;
  self dontinterpolate();
  wait 0.05;
}

#using_animtree("script_model");

function _simple_interaction_prop_random_anim(random_anim) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
  self.optional_prop setanimknob(random_anim, 1, 0.2, 1);
  self.optional_prop.curr_anim = random_anim;
}

function _simple_interaction_prop_start(starting_anim) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop setanimknob(starting_anim, 1, 0.2, 1);
  self.optional_prop.curr_anim = starting_anim;
}

function _simple_interaction_prop_clear() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
}

function play_anim_vo(waittime, vo_line) {
  wait waittime;
  tok_string = strtok(vo_line, "_");

  if(array_contains(tok_string, "plr")) {
    level.player play_sound_on_entity(vo_line);
    return;
  }

  smart_dialogue(vo_line);
}

function _play_interaction_anim_vo_note() {
  self notify("start_interaction_vo_note");
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("start_interaction_vo_note");

  while(true) {
    self waittill("single anim", notes);

    if(isarray(notes)) {
      foreach(note in notes) {
        if(issubstr(note, "vo_") && !issubstr(note, "_plr")) {
          vo_line = getsubstr(note, 3);
          thread smart_dialogue(vo_line);
          wait lookupsoundlength(vo_line) / 1000;
          self notify("single dialogue");

          if(isDefined(self.scriptedtalkingknob)) {
            self clearanim(self.scriptedtalkingknob, 0.2);
          }
        }
      }

      continue;
    }

    if(issubstr(notes, "vo_") && !issubstr(notes, "_plr")) {
      vo_line = getsubstr(notes, 3);
      thread smart_dialogue(vo_line);
      wait lookupsoundlength(vo_line) / 1000;
      self notify("single dialogue");

      if(isDefined(self.scriptedtalkingknob)) {
        self clearanim(self.scriptedtalkingknob, 0.2);
      }
    }
  }
}

function play_note_anim_vo(vo_line) {
  self endon("death");
  self endon("stop_smart_reaction");
  can_break = 0;

  while(!can_break) {
    self waittill("single anim", notetracks);

    if(isarray(notetracks)) {
      foreach(notetrack in notetracks) {
        if(notetrack == "reaction_vo") {
          can_break = 1;
          break;
        }
      }
    } else if(notetracks == "reaction_vo") {
      can_break = 1;
      break;
    }

    waitframe();
  }

  self notify("reaction_vo_fired");
  scripts\sp\interaction_manager::play_smart_dialog_if_exists(vo_line);
}

function play_anim_shared_vo() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_876db5e801f6dfba = undefined;
  random_line = undefined;

  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"])) {
    return;
  }

  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"])) {
    return;
  }

  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"])) {
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "male")) {
    if(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"].size < 1) {
      level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"] = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"];
    }

    lines = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"];
    var_c1e5762d7ec31d56 = randomint(lines.size);
    random_line = lines[var_c1e5762d7ec31d56];
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"] = array_remove_index(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"], var_c1e5762d7ec31d56);
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"] = array_add(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"], random_line);
  }

  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"])) {
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    if(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"].size < 1) {
      level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"] = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"];
    }

    lines = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"];
    var_c1e5762d7ec31d56 = randomint(lines.size);
    random_line = lines[var_c1e5762d7ec31d56];
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"] = array_remove_index(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"], var_c1e5762d7ec31d56);
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"] = array_add(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"], random_line);
  }

  var_533794d29349e370 = undefined;

  while(true) {
    self waittill("single anim", notetracks);

    if(isarray(notetracks)) {
      foreach(notetrack in notetracks) {
        if(notetrack == "reaction_vo") {
          var_533794d29349e370 = 1;
          break;
        }
      }
    } else if(notetracks == "reaction_vo") {
      var_533794d29349e370 = 1;
    }

    if(isDefined(var_533794d29349e370)) {
      break;
    }

    waitframe();
  }

  smart_dialogue(random_line);
}

function play_anim_vo_sequential(var_bffe0e76de43dbbc) {
  var_876db5e801f6dfba = undefined;
  random_line = undefined;
  registered_interaction = level.interaction_manager.data["registered_interactions"][self.interaction_name];

  if(isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"])) {
    var_876db5e801f6dfba = 1;

    if(!isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"])) {
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "male")) {
      if(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"].size < 1) {
        level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"] = level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"];
      }

      lines = level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"];
      var_c1e5762d7ec31d56 = randomint(lines.size);
      random_line = lines[var_c1e5762d7ec31d56];
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"] = array_remove_index(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"], var_c1e5762d7ec31d56);
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"] = array_add(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"], random_line);
    }
  }

  if(isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"])) {
    var_876db5e801f6dfba = 1;

    if(!isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"])) {
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      if(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"].size < 1) {
        level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"] = level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"];
      }

      lines = level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"];
      var_c1e5762d7ec31d56 = randomint(lines.size);
      random_line = lines[var_c1e5762d7ec31d56];
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"] = array_remove_index(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"], var_c1e5762d7ec31d56);
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"] = array_add(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"], random_line);
    }
  }

  last_index = var_bffe0e76de43dbbc.size - 1;

  if(!isDefined(var_876db5e801f6dfba)) {
    if(isstring(var_bffe0e76de43dbbc[last_index])) {
      i = 1;

      while(i < var_bffe0e76de43dbbc.size) {
        play_anim_vo(var_bffe0e76de43dbbc[i], var_bffe0e76de43dbbc[i + 1]);
        i += 2;
      }
    } else {
      i = 1;

      while(i < var_bffe0e76de43dbbc.size - 1) {
        play_anim_vo(var_bffe0e76de43dbbc[i], var_bffe0e76de43dbbc[i + 1]);
        i += 2;
      }
    }

    return;
  }

  play_anim_vo(var_bffe0e76de43dbbc[1], random_line);
}

function set_sequential_wait_time(var_bffe0e76de43dbbc) {
  self.sequential_wait_time = 0;
  self.sequential_loop_padding = 0;
  last_index = var_bffe0e76de43dbbc.size - 1;

  if(isstring(var_bffe0e76de43dbbc[last_index])) {
    self.sequential_loop_padding = 0;
    i = 1;

    while(i < var_bffe0e76de43dbbc.size) {
      self.sequential_wait_time += var_bffe0e76de43dbbc[i];
      i += 2;
    }

    return;
  }

  self.sequential_loop_padding = var_bffe0e76de43dbbc[last_index];
  i = 1;

  while(i < var_bffe0e76de43dbbc.size - 1) {
    self.sequential_wait_time += var_bffe0e76de43dbbc[i];
    i += 2;
  }
}

function random_idle_controller() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_9016cdd15da6e3dc = undefined;
  interaction = get_interaction(self.interaction_name);

  if(!isDefined(interaction)) {
    interaction = get_state_interaction(self.interaction_name);
  }

  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;

  if(!isarray(interaction.scene["idle"])) {
    interaction.scene["idle"] = [interaction.scene["idle"], interaction.scene["idle"]];
  }

  spent_array = [];
  anim_array = interaction.scene["idle"];
  starting_idle = anim_array[0];
  anim_array = array_remove_index(anim_array, 0);
  idle_array = anim_array;
  anim_array = undefined;
  self.starting_random_idle = starting_idle;

  while(true) {
    self.is_playing_random_idle = 1;
    var_6a626ae2a0ecb1e = getanimlength(starting_idle);
    var_5406e6effd6154e8 = randomint(2) + 1;
    wait_time = var_6a626ae2a0ecb1e * float(var_5406e6effd6154e8);
    wait wait_time;

    while(true) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      waitframe();
    }

    if(idle_array.size <= 0) {
      idle_array = spent_array;
      spent_array = [];
    }

    random_anim = idle_array[randomint(idle_array.size)];
    spent_array = array_add(spent_array, random_anim);
    idle_array = array_remove(idle_array, random_anim);
    pos = undefined;
    ang = undefined;

    if(isDefined(self.optional_struct)) {
      pos = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, random_anim);
      ang = getstartangles(self.optional_struct.origin, self.optional_struct.angles, random_anim);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(pos, ang);
      } else {
        self.origin = pos;
        self.angles = ang;
      }
    }

    while(self.is_playing_reaction) {
      waitframe();
    }

    start_fakeactor_notetracks(random_anim);
    self setflaggedanimknob("single anim", random_anim, 1, 0.2, 1);
    self.random_idle_playing = 1;
    random_wait_time = getanimlength(random_anim);
    wait random_wait_time;

    while(self.is_playing_reaction) {
      waitframe();
    }

    if(isDefined(self.optional_struct)) {
      pos = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, starting_idle);
      ang = getstartangles(self.optional_struct.origin, self.optional_struct.angles, starting_idle);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(pos, ang);
      } else {
        self.origin = pos;
        self.angles = ang;
      }
    }

    self.random_idle_playing = 0;
    self clearanim(random_anim, 0.3);
    self.is_playing_random_idle = undefined;
    start_fakeactor_notetracks(starting_idle);
    self setflaggedanimknob("single anim", starting_idle, 1, 0.2, 1);
    self setanimtime(starting_idle, randomfloat(1));

    while(true) {
      if(isDefined(self.can_play_random_idle)) {
        break;
      }

      waitframe();
    }

    waitframe();
  }
}

function random_idle_controller_stateful() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_9016cdd15da6e3dc = undefined;
  interaction = get_state_interaction(self.interaction_name);
  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;
  var_961e7b22dd3c0cdc = undefined;

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    var_961e7b22dd3c0cdc = "idle_female";
  } else {
    var_961e7b22dd3c0cdc = "idle";
  }

  starting_idle = interaction.scene[var_961e7b22dd3c0cdc][0];
  self.starting_random_idle = starting_idle;

  while(true) {
    self.is_playing_random_idle = 1;
    var_6a626ae2a0ecb1e = getanimlength(starting_idle);
    var_5406e6effd6154e8 = randomint(2) + 1;
    wait_time = var_6a626ae2a0ecb1e * float(var_5406e6effd6154e8);
    wait wait_time;

    while(true) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      waitframe();
    }

    var_eda2de4e93c90579 = undefined;
    var_9c4ca7794f6f0ee6 = undefined;

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_eda2de4e93c90579 = "random_idles_female";
      var_9c4ca7794f6f0ee6 = "spent_random_idles_female";
    } else {
      var_eda2de4e93c90579 = "random_idles";
      var_9c4ca7794f6f0ee6 = "spent_random_idles";
    }

    if(level.state_interactions[self.interaction_name].scene[var_eda2de4e93c90579].size <= 0) {
      level.state_interactions[self.interaction_name].scene[var_eda2de4e93c90579] = level.state_interactions[self.interaction_name].scene[var_9c4ca7794f6f0ee6];
      level.state_interactions[self.interaction_name].scene[var_9c4ca7794f6f0ee6] = [];
    }

    random_anim = level.state_interactions[self.interaction_name].scene[var_eda2de4e93c90579][randomint(level.state_interactions[self.interaction_name].scene[var_eda2de4e93c90579].size)];
    level.state_interactions[self.interaction_name].scene[var_9c4ca7794f6f0ee6] = array_add(level.state_interactions[self.interaction_name].scene[var_9c4ca7794f6f0ee6], random_anim);
    level.state_interactions[self.interaction_name].scene[var_eda2de4e93c90579] = array_remove(level.state_interactions[self.interaction_name].scene[var_eda2de4e93c90579], random_anim);
    pos = undefined;
    ang = undefined;

    if(isDefined(self.optional_struct)) {
      pos = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, random_anim);
      ang = getstartangles(self.optional_struct.origin, self.optional_struct.angles, random_anim);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(pos, ang);
      } else {
        self.origin = pos;
        self.angles = ang;
      }
    }

    while(self.is_playing_reaction) {
      waitframe();
    }

    start_fakeactor_notetracks(random_anim);
    self setflaggedanimknob("single anim", random_anim, 1, 0.2, 1);
    self.random_idle_playing = 1;
    random_wait_time = getanimlength(random_anim);
    wait random_wait_time;

    while(self.is_playing_reaction) {
      waitframe();
    }

    if(isDefined(self.optional_struct)) {
      pos = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, starting_idle);
      ang = getstartangles(self.optional_struct.origin, self.optional_struct.angles, starting_idle);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(pos, ang);
      } else {
        self.origin = pos;
        self.angles = ang;
      }
    }

    self.random_idle_playing = 0;
    self clearanim(random_anim, 0.3);
    self.is_playing_random_idle = undefined;
    start_fakeactor_notetracks(starting_idle);
    self setflaggedanimknob("single anim", starting_idle, 1, 0.2, 1);
    self setanimtime(starting_idle, randomfloat(1));

    while(true) {
      if(isDefined(self.can_play_random_idle)) {
        break;
      }

      waitframe();
    }

    waitframe();
  }
}

function random_idle_group_controller(actors, frequency, group_anime) {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  level endon("stop_idle_controller");
  self endon("stop_group_idle_controller");
  level endon("stop_group_idle_controller");
  self endon("death");

  if(!flag_exist("hold_group_vignettes")) {
    flag_init("hold_group_vignettes");
  }

  spent_array = [];
  anim_array = group_anime;

  while(true) {
    wait randomfloatrange(frequency * 0.5, frequency);

    foreach(actor in actors) {
      if(!isDefined(actor)) {
        self notify("stop_group_idle_controller");
        return;
      }

      actor endon("death");
      actor endon("entitydeleted");
      actor.can_play_random_idle = undefined;
    }

    break_count = 0;

    while(true) {
      if(!flag("hold_group_vignettes")) {
        foreach(idle_actor in actors) {
          if(!isDefined(idle_actor.is_playing_random_idle)) {
            break_count++;
          }
        }

        if(break_count >= actors.size) {
          break;
        } else {
          break_count = 0;
        }
      }

      waitframe();
    }

    var_b92972e6e87ed559 = undefined;

    if(isarray(group_anime)) {
      if(anim_array.size <= 0) {
        anim_array = group_anime;
        spent_array = [];
      }

      var_b92972e6e87ed559 = anim_array[randomint(anim_array.size)];
    } else {
      var_b92972e6e87ed559 = group_anime;
    }

    wait_time = 0;

    if(!flag("hold_group_vignettes")) {
      foreach(actor in actors) {
        if(!isDefined(actor)) {
          self notify("stop_group_idle_controller");
          return;
        }

        animation = actor getanim(var_b92972e6e87ed559);
        org = getstartorigin(actor.origin, actor.angles, animation);
        ang = getstartangles(actor.origin, actor.angles, animation);

        if(isai(actor)) {
          actor forceteleport(org, ang);
        } else {
          actor.origin = org;
          actor.angles = ang;
        }

        actor thread start_fakeactor_notetracks(animation);
        actor setflaggedanimknob("single anim", animation, 1, 0.2);
        actor.allow_interactions = 0;
        actor.hold_lookat = 1;
        wait_time = getanimlength(animation);
      }

      wait wait_time;

      if(isarray(group_anime)) {
        spent_array = array_add(spent_array, var_b92972e6e87ed559);
        anim_array = array_remove(anim_array, var_b92972e6e87ed559);
      }

      foreach(guy in actors) {
        if(!isDefined(guy)) {
          self notify("stop_group_idle_controller");
          return;
        }

        animation = guy getanim(var_b92972e6e87ed559);
        guy thread start_fakeactor_notetracks(guy.starting_random_idle);
        guy setanimknob(animation, 0, 0.2);
        guy setflaggedanimknob("single anim", guy.starting_random_idle, 1, 0.2, 1);
        guy setanimtime(guy.starting_random_idle, randomfloat(1));
        guy.can_play_random_idle = 1;
        guy.allow_interactions = 1;
        guy.hold_lookat = undefined;
      }
    }

    waitframe();
  }
}

function interaction_end() {
  if(!isDefined(self.reaction_stop_anims)) {
    asm_stopanimScripted();
    interaction_set_anim_movement("stop");
  }

  scripts\sp\interaction_manager::remove_actor_from_manager();
  self notify("reaction_end");
  thread scripts\sp\interaction_manager::stop_gesture_reaction();
  self notify("stop_smart_reaction");
  self.is_talking = undefined;
}

function interaction_end_cheap() {
  self waittill("reaction_end");
  scripts\sp\interaction_manager::remove_actor_from_manager();
  self notify("interaction_done");
  self notify("stop_reaction");
  self.is_talking = undefined;
}

function set_time_via_rate(anime, time, weight) {
  if(!isDefined(weight)) {
    weight = 1;
  }

  prev_time = self getanimtime(anime);
  duration = getanimlength(anime);
  rate = (time - prev_time) * duration / 0.05;
  self setanimlimited(anime, weight, 0.25, rate);
}

function play_combat_interaction(node, statename) {
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
  self.combat_reaction_return_state = statename;

  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = array_add(level.interaction_manager.data["actors"], self);
  }

  while(self.script == "init") {
    waitframe();
  }

  while(true) {
    while(true) {
      var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);

      if(var_84d1d51d3f40043 < squared(150) && is_looking_at_range(self, 0.925)) {
        break;
      }

      waitframe();
    }

    asmname = self.asmname;
    var_293af010052e93ca = self asmgetcurrentstate(asmname);

    if(var_293af010052e93ca == self.combat_reaction_return_state && !self.nearby_interaction_running) {
      if(node.script_reaction == "combat_reaction") {
        interactions = [];

        if(isDefined(node.type)) {
          switch (node.type) {
            case #"hash_c3b74422dec48736":
              interactions = ["combat_crouch_1", "combat_crouch_2"];
              break;
            case #"hash_e1d8e1adebed5a61":
              switch (self.currentpose) {
                case #"hash_c6775c88e38f7803":
                  interactions = ["hm_grnd_org_cover_left_stand_react_01", "hm_grnd_org_cover_left_stand_react_02"];
                  break;
                case #"hash_3fed0cbd303639eb":
                  interactions = ["hm_grnd_org_cover_left_crouch_react_01", "hm_grnd_org_cover_left_crouch_react_02"];
                  break;
                case #"hash_d91940431ed7c605":
                  break;
              }

              break;
            case #"hash_cd3ffe799551db82":
              switch (self.currentpose) {
                case #"hash_c6775c88e38f7803":
                  interactions = ["hm_grnd_org_cover_right_stand_react_01", "hm_grnd_org_cover_right_stand_react_02"];
                  break;
                case #"hash_3fed0cbd303639eb":
                  interactions = ["hm_grnd_org_cover_right_crouch_react_01", "hm_grnd_org_cover_right_crouch_react_02"];
                  break;
                case #"hash_d91940431ed7c605":
                  break;
              }

              break;
            case #"hash_c051a32186a33cae":
              break;
            case #"hash_78b110033ccb68b0":
              break;
            case #"hash_776752872754e5ee":
              interactions = ["combat_cover_crouch_1"];
              break;
          }

          if(interactions.size > 0) {
            random_pick = randomint(interactions.size);
            random_interaction = interactions[random_pick];
            combat_interaction_process(random_interaction, node);
          } else {
            println("<dev string:x34>" + node.type);
            return;
          }
        }
      } else {
        combat_interaction_process(node.script_reaction, node);
      }
    }

    wait 1.5;
  }
}

function combat_interaction_process(interaction_name, node) {
  self endon("death");
  self endon("interaction_done");
  interaction = get_interaction(interaction_name);
  thread scripts\common\notetrack::start_notetrack_wait(self, "vo");
  thread _play_interaction_anim_vo_note();

  if(!isDefined(interaction)) {
    assertmsg("Interaction by name of " + interaction_name + " but interaction isn't registered");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
  trace_end = undefined;
  tracecontents = create_contents(1, 1, 0, 1, 1, 1);
  trace = undefined;

  if(isDefined(self.lookat_anims["interaction_position"])) {
    var_84d1d51d3f40043 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
  } else {
    var_84d1d51d3f40043 = lengthsquared(level.player.origin - self.origin);
  }

  if(var_84d1d51d3f40043 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925)) {
    trace_end = vectorNormalize(level.player getEye() - self getEye()) * self.lookat_anims["trigger_radius"] + self getEye();
    trace = ray_trace(self getEye(), trace_end, self, tracecontents);

    if(isPlayer(trace["entity"])) {
      combat_interaction_run();
    }
  }
}

#using_animtree("generic_human");

function combat_interaction_run() {
  self endon("death");
  self endon("interaction_done");
  self.is_playing_reaction = 1;
  self notify("playing_interaction_scene");
  level notify("playing_interaction");
  starting_anim = self.combat_reaction_previous_anim;
  var_837c12743ab916fe = undefined;

  if(isDefined(self.lookat_anims["interaction_position"])) {
    var_837c12743ab916fe = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
  } else {
    var_837c12743ab916fe = vectortoangles(level.player.origin - self.origin);
  }

  angle = abs(angleclamp((var_837c12743ab916fe - self.angles)[1]) - 360);
  println("<dev string:x1c>" + angle);
  reaction_anim = self.lookat_anims["lastanim"];

  if(isDefined(self.lookat_anims["angles"])) {
    foreach(reaction_angle in self.lookat_anims["angles"]) {
      if(angle <= reaction_angle) {
        reaction_anim = self.lookat_anims[reaction_angle];
        break;
      }
    }
  }

  if(isarray(reaction_anim)) {
    if(isarray(reaction_anim[0])) {
      var_1511386e758ef855 = self.anim_sequential_counter;
      var_e88ef0694a45c625 = reaction_anim[0][var_1511386e758ef855][0];
    } else {
      var_e88ef0694a45c625 = reaction_anim[0];
    }
  } else {
    var_e88ef0694a45c625 = reaction_anim;
  }

  start_fakeactor_notetracks(var_e88ef0694a45c625);
  self setanimlimited(%body, 0, 0.25, 1);
  self setflaggedanimknoball("vo", var_e88ef0694a45c625, %body, 1, 0.25, 1);
  wait getanimlength(var_e88ef0694a45c625);
  self clearanim(%scripted, 0.25);
  self setanimlimited(%body, 1, 0.25, 1);
  self.is_playing_reaction = 0;
  wait 0.25;
  self notify("interaction_done");
  level notify("interaction_done");
  thread interaction_end();
}

function combat_reaction_wait_buffer(node) {
  node.combat_reaction_wait = 1;
  wait 2;
  node.combat_reaction_wait = undefined;
}

function new_goal_listener() {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_db33b152656eeed0 = undefined;

  if(isDefined(self.last_set_goalnode)) {
    var_db33b152656eeed0 = self.last_set_goalnode.origin;

    while(isDefined(self.last_set_goalnode) && self.last_set_goalnode.origin == var_db33b152656eeed0) {
      waitframe();
    }
  } else if(isDefined(self.last_set_goalent)) {
    var_db33b152656eeed0 = self.last_set_goalent.origin;

    while(isDefined(self.last_set_goalent) && self.last_set_goalent.origin == var_db33b152656eeed0) {
      waitframe();
    }
  } else if(isDefined(self.last_set_goalpos)) {
    var_db33b152656eeed0 = self.last_set_goalpos;

    while(isDefined(self.last_set_goalpos) && self.last_set_goalpos == var_db33b152656eeed0) {
      waitframe();
    }
  }

  self notify("interaction_done");
  thread interaction_end();
}

function interaction_pain_listener() {
  self endon("death");
  self endon("interaction_done");
  self.interaction_pain = undefined;

  while(true) {
    self.interaction_pain = undefined;
    self waittill("pain");
    self.interaction_pain = 1;
    wait 5;
  }
}

function interaction_set_anim_movement(movement) {
  if(!isDefined(movement)) {
    movement = "stop";
  }

  if(isai(self)) {
    self.a.movement = movement;
    return;
  }

  return;
}

function start_fakeactor_notetracks(animation) {
  anime = undefined;

  if(isDefined(self.interaction_name)) {
    anime = self.interaction_name;
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, "single anim", anime, undefined, animation);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "single anim", anime);
}
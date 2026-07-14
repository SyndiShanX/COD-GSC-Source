/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\interaction.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\asm\gesture\script_funcs;
#using scripts\common\ai;
#using scripts\common\notetrack;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\interaction_manager;
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
  if(!issubstr(interact_name, "#yDV,\xd6") && !issubstr(interact_name, "\\*\xe3\xec\x10")) {
    if(isDefined(self.asm)) {
      demeanor = asm::asm_getdemeanor();

      if(demeanor == "#yDV,\xd6") {
        interact_name = interact_name + "w" + demeanor;
      } else {
        interact_name += "[y\xbc^\xa5\x16";
      }
    } else {
      interact_name += "\x9d\xa2f\x06\xe4$\xd2";
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
  return isDefined(level.state_interactions) && isDefined(level.state_interactions[interact_name + "\x9d\xa2f\x06\xe4$\xd2"]);
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
    if(is_interaction(node.script_reaction) || node.script_reaction == "?\x90\xef\xdc\xc7u\x7ft\xbf\xbe{\xb4\x9e\x93\x8f") {
      return true;
    }
  }

  return false;
}

function get_arrivalstate_from_interaction(interaction) {
  demeanor = asm::asm_getdemeanor();

  if(isDefined(interaction.arrivalstates)) {
    return interaction.arrivalstates[demeanor];
  }

  return undefined;
}

function get_exitstate_from_interaction(interaction) {
  demeanor = asm::asm_getdemeanor();

  if(isDefined(interaction.exitstates)) {
    return interaction.exitstates[demeanor];
  }

  return undefined;
}

function get_idlestate_from_interaction(interaction) {
  demeanor = asm::asm_getdemeanor();
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

  self.var_c9829cc678d083b1 = get_exitstate_from_interaction(interaction);
}

function play_interaction_anim(interact, anim_index, weight, time, rate) {
  interact = get_interaction(interact);
  assert(isDefined(interact), "<dev string:x24>");
  assert(isDefined(interact.scene[anim_index]), "<dev string:x5f>");

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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x90\xd8s\xf2\x1a\xa3\xec\xe6N\xf8T<\x1a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  reference_pos = undefined;

  while(true) {
    if(isstruct(reference) || isent(reference)) {
      reference_pos = reference.origin;
    } else if(isvector(reference)) {
      reference_pos = reference;
    }

    if(isDefined(self.lookat_anims)) {
      self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] = reference_pos;
    }

    waitframe();
  }
}

function redefine_interaction_radius(new_radius) {
  old_radius = undefined;

  if(isDefined(self.lookat_anims)) {
    old_radius = self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"];
    self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] = new_radius;
    thread _redefine_interaction_radius_cleanup(old_radius);
  }
}

function _redefine_interaction_radius_cleanup(old_radius) {
  self endon("\x1a\xa0\x91C\x1a\xdf\x9f\xc1\xfb~\xb9\x9dE`\x98");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self waittill("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] = old_radius;
}

function play_interaction(interaction_name, optional_scripted_struct, var_6a0809224a9661b1) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  interaction = get_interaction(interaction_name);
  setup_exit_states_for_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("<dev string:x97>" + interaction_name + "<dev string:xb2>");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "RF\x9e\xe1\xc4\x1f\xe7";
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
    interaction_manager::add_actor_to_manager();
    level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][interaction_name] = [];

    if(isDefined(interaction.scene["O\xb0\fa\x9c,0:<\xce\xc1oy"])) {
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"] = interaction.scene["O\xb0\fa\x9c,0:<\xce\xc1oy"];
    }

    if(isDefined(interaction.scene["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"])) {
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"] = interaction.scene["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"];
    }
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;

    if(isarray(self.lookat_anims["\x91\x88\xc2*"])) {
      var_d1f285138c58cb08 = self.lookat_anims["\x91\x88\xc2*"][0];
    } else {
      var_d1f285138c58cb08 = self.lookat_anims["\x91\x88\xc2*"];
    }

    if(isstring(optional_scripted_struct)) {
      optional_struct = utility::getStruct(optional_scripted_struct, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else if(isent(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("<dev string:xd7>");
      return;
    }

    anime = var_d1f285138c58cb08;
    start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, anime);
    start_angles = getstartangles(optional_struct.origin, optional_struct.angles, anime);

    if(!isDefined(self.is_cheap)) {
      self forceteleport(start_origin, start_angles);
    } else {
      self.origin = start_origin;
      self.angles = start_angles;
    }

    if(!isDefined(self.is_cheap)) {
      self animmode("b\xf21\xbc\xeb{");
    }

    self.optional_struct = optional_struct;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["\xa4\x93<sJA"])) {
    if(!isDefined(self.is_cheap)) {
      ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    if(!isDefined(var_6a0809224a9661b1)) {
      thread interaction_process();
      thread interaction_end_cheap();
    } else {
      thread interaction_follow_process();
      thread interaction_end_cheap();
    }
  } else if(!isDefined(var_6a0809224a9661b1)) {
    asm_sp::asm_animcustom(&interaction_process, &interaction_end);
  } else {
    asm_sp::asm_animcustom(&interaction_follow_process, &interaction_end);
  }

  self waittill("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
}

function play_smart_interaction(interaction_name, reaction_vo, post_reaction_vo, is_reminder, optional_pointat, optional_scripted_struct, var_bc552174bd33dcae, var_1286f5b87ac8e00) {
  assert(is_interaction(interaction_name));
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  setup_interaction_head();
  var_6768250b08614a29 = get_interaction(interaction_name).scene["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] * 2;
  thread interaction_manager::reaction_look_distance_based(var_6768250b08614a29);
  play_interaction_unknowntype(interaction_name, optional_scripted_struct, reaction_vo, var_1286f5b87ac8e00);
  self waittill("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  thread utility_sp::gesture_stop(0.7);
  self notify("7\xbe=\x90\xa0\x861\xad\xbc\x90\xff\xc8N\x0f]BG3");
  waittill_playeroutsideradius(var_bc552174bd33dcae);
  play_looping_acknowlegdements(post_reaction_vo, var_bc552174bd33dcae);
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function setup_interaction_head() {
  self.headknob = % \x83\xe2\x11D;
  self.scriptedtalkingknob = % F\x83\x1c\x9d\x19\xc5\xca\x1b\xe35DN\xb8\xf4 ? \x8c;
  self.defaulttalk = % \xe9\xbc\xeb\xea\x98\xfcA\xc5y\x0f\x0e\xf1\xffh\xae\xf2\x15\xae\xe7z % ;
}

function play_interaction_unknowntype(interaction_name, optional_scripted_struct, reaction_vo, var_1286f5b87ac8e00) {
  if(issubstr(interaction_name, "\xfa*\x1d\x13\x91\x05n")) {
    thread play_interaction_blended(interaction_name, optional_scripted_struct);
  } else {
    thread play_interaction(interaction_name, optional_scripted_struct);
  }

  queue_interaction_vo(reaction_vo, var_1286f5b87ac8e00);
}

function queue_interaction_vo(reaction_vo, var_1286f5b87ac8e00) {
  if(!isDefined(var_1286f5b87ac8e00)) {
    thread play_note_anim_vo(reaction_vo);
    return;
  }

  self waittill("\x19\xee%c\xc4\x8a\xad\xe8T\x82\xffR=\xda\x06\xcd$tAC^\x85\xbe\xd9\xc9");
  utility::delaythread(var_1286f5b87ac8e00, &interaction_manager::play_smart_dialog_if_exists, reaction_vo);
}

function play_smart_simple_interaction(interaction_name, reaction_vo, post_reaction_vo, is_reminder, optional_pointat, optional_scripted_struct, var_bc552174bd33dcae) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  assert(is_interaction(interaction_name));
  self.headknob = % \x83\xe2\x11D;
  self.scriptedtalkingknob = % F\x83\x1c\x9d\x19\xc5\xca\x1b\xe35DN\xb8\xf4 ? \x8c;
  self.defaulttalk = % \xe9\xbc\xeb\xea\x98\xfcA\xc5y\x0f\x0e\xf1\xffh\xae\xf2\x15\xae\xe7z % ;
  thread play_interaction_simple(interaction_name, optional_scripted_struct);
  interaction_manager::play_gesture_reaction(85, 50, reaction_vo, is_reminder, optional_pointat);
  self notify("\x88H\b\xb6\xcb\x96'gYj6\x8b\xc3\xc1nu\n\xe0\xbf\x17;W\x05;\xfb\x12");
  waittill_playeroutsideradius(var_bc552174bd33dcae);
  linebook = create_interaction_linebook(post_reaction_vo);

  while(true) {
    random_line = linebook get_interaction_vo_line();
    interaction_manager::play_gesture_reaction(85, 50, random_line, is_reminder, optional_pointat);
    waittill_playeroutsideradius(var_bc552174bd33dcae);
  }
}

function play_smart_basic_interaction(var_dcef0fa891f5b16d, post_reaction_vo, is_reminder, optional_pointat, var_bc552174bd33dcae) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  self.headknob = % \x83\xe2\x11D;
  self.scriptedtalkingknob = % F\x83\x1c\x9d\x19\xc5\xca\x1b\xe35DN\xb8\xf4 ? \x8c;
  self.defaulttalk = % \xe9\xbc\xeb\xea\x98\xfcA\xc5y\x0f\x0e\xf1\xffh\xae\xf2\x15\xae\xe7z % ;
  play_single_acknowledgement(var_dcef0fa891f5b16d);
  self notify("\x88H\b\xb6\xcb\x96'gYj6\x8b\xc3\xc1nu\n\xe0\xbf\x17;W\x05;\xfb\x12");
  waittill_playeroutsideradius(var_bc552174bd33dcae);
  play_looping_acknowlegdements(post_reaction_vo, var_bc552174bd33dcae);
}

function play_smart_silent_interaction(var_bc552174bd33dcae) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  self.headknob = % \x83\xe2\x11D;
  self.scriptedtalkingknob = % F\x83\x1c\x9d\x19\xc5\xca\x1b\xe35DN\xb8\xf4 ? \x8c;
  self.defaulttalk = % \xe9\xbc\xeb\xea\x98\xfcA\xc5y\x0f\x0e\xf1\xffh\xae\xf2\x15\xae\xe7z % ;
  play_single_acknowledgement(undefined);
  waittill_playeroutsideradius(var_bc552174bd33dcae);
  play_looping_acknowlegdements(undefined, var_bc552174bd33dcae);
}

function play_smart_simple_silent_interaction(interaction_name, optional_scripted_struct, var_bc552174bd33dcae) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  assert(is_interaction(interaction_name));
  self.headknob = % \x83\xe2\x11D;
  self.scriptedtalkingknob = % F\x83\x1c\x9d\x19\xc5\xca\x1b\xe35DN\xb8\xf4 ? \x8c;
  self.defaulttalk = % \xe9\xbc\xeb\xea\x98\xfcA\xc5y\x0f\x0e\xf1\xffh\xae\xf2\x15\xae\xe7z % ;
  thread play_interaction_simple(interaction_name, optional_scripted_struct);
  interaction_manager::play_gesture_reaction(85, 50);
  self notify("\x88H\b\xb6\xcb\x96'gYj6\x8b\xc3\xc1nu\n\xe0\xbf\x17;W\x05;\xfb\x12");
  waittill_playeroutsideradius(var_bc552174bd33dcae);
  play_looping_acknowlegdements(undefined, var_bc552174bd33dcae);
}

function play_single_acknowledgement(vo_line) {
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  lookat_distance = 110;
  reaction_distance = 85;
  interaction_manager::play_gesture_reaction(lookat_distance, reaction_distance, vo_line);
}

function play_looping_acknowlegdements(vo_array, var_bc552174bd33dcae) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");

  if(!isDefined(var_bc552174bd33dcae)) {
    var_bc552174bd33dcae = 300;
  }

  if(isDefined(vo_array)) {
    linebook = create_interaction_linebook(vo_array);

    while(true) {
      random_line = linebook get_interaction_vo_line();
      play_single_acknowledgement(random_line);
      waittill_playeroutsideradius(var_bc552174bd33dcae);
    }

    return;
  }

  while(true) {
    play_single_acknowledgement();
    waittill_playeroutsideradius(var_bc552174bd33dcae);
  }
}

function play_silent_acknowledgement() {
  lookat_distance = 110;
  reaction_distance = 85;
  interaction_manager::play_gesture_reaction(lookat_distance, reaction_distance);
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
  assert(isDefined(vo_array), "<dev string:x10e>");

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
    self.used = utility::array_add(self.used, random_line);
    self.available = arrayremove(self.available, random_line);
    return random_line;
  }
}

function play_smart_basic_group_interaction(actor_array, var_51e732186b4898fc, var_c4b143ec8f62592b, var_bc552174bd33dcae) {
  foreach(actor in actor_array) {
    actor endon("\x1e\xfd\xd1\xa2\a");
    actor endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
    actor.headknob = % \x83\xe2\x11D;
    actor.scriptedtalkingknob = % F\x83\x1c\x9d\x19\xc5\xca\x1b\xe35DN\xb8\xf4 ? \x8c;
    actor.defaulttalk = % \xe9\xbc\xeb\xea\x98\xfcA\xc5y\x0f\x0e\xf1\xffh\xae\xf2\x15\xae\xe7z % ;
  }

  if(actor_array.size != var_51e732186b4898fc.size || actor_array.size != var_c4b143ec8f62592b.size) {
    assertmsg("<dev string:x14a>");
    return;
  }

  play_group_acknowledgement(actor_array, var_51e732186b4898fc);
  mid_ent = interaction_manager::create_middle_ent(actor_array);
  mid_ent waittill_playeroutsideradius(var_bc552174bd33dcae);
  play_group_looping_acknowledgements(actor_array, var_c4b143ec8f62592b, var_bc552174bd33dcae);
}

function play_group_acknowledgement(actor_array, voline_array) {
  lookat_distance = 110;
  reaction_distance = 85;
  interaction_manager::play_group_gesture_reaction(actor_array, lookat_distance, reaction_distance, voline_array);
}

function play_group_looping_acknowledgements(actor_array, vo_arrays, var_bc552174bd33dcae) {
  foreach(actor in actor_array) {
    actor endon("\x1e\xfd\xd1\xa2\a");
    actor endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  }

  group_linebook = create_group_interaction_linebook(vo_arrays);
  mid_ent = interaction_manager::create_middle_ent(actor_array);

  while(true) {
    var_7bf56d6e4c6afe9a = get_interaction_vo_line_array(group_linebook);
    play_group_acknowledgement(actor_array, var_7bf56d6e4c6afe9a);
    mid_ent waittill_playeroutsideradius(var_bc552174bd33dcae);
  }
}

function create_group_interaction_linebook(vo_arrays) {
  assert(isDefined(vo_arrays), "<dev string:x1ba>");
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

function play_interaction_with_states(interaction_name, optional_scripted_struct, var_6a0809224a9661b1) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  interaction = get_state_interaction(interaction_name);
  setup_exit_states_for_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("<dev string:x97>" + interaction_name + "<dev string:x1fd>");
    return;
  }

  if(!isDefined(self.animname)) {
    self.animname = "RF\x9e\xe1\xc4\x1f\xe7";
  }

  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = interaction_name;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    interaction_manager::add_actor_to_manager();
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;

    if(isarray(interaction.scene["\x91\x88\xc2*"])) {
      var_d1f285138c58cb08 = interaction.scene["\x91\x88\xc2*"][0];
    } else {
      var_d1f285138c58cb08 = interaction.scene["\x91\x88\xc2*"];
    }

    if(isstring(optional_scripted_struct)) {
      optional_struct = utility::getStruct(optional_scripted_struct, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else if(isent(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("<dev string:xd7>");
      return;
    }

    anime = var_d1f285138c58cb08;
    start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, anime);
    start_angles = getstartangles(optional_struct.origin, optional_struct.angles, anime);

    if(!isDefined(self.is_cheap)) {
      self forceteleport(start_origin, start_angles);
    } else {
      self.origin = start_origin;
      self.angles = start_angles;
    }

    if(!isDefined(self.is_cheap)) {
      self animmode("b\xf21\xbc\xeb{");
    }

    self.optional_struct = optional_struct;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(interaction.scene["\xa4\x93<sJA"])) {
    if(!isDefined(self.is_cheap) && !isnullweapon(self.weapon)) {
      ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    thread interaction_process_for_states();
    thread interaction_end_cheap();
  } else {
    asm_sp::asm_animcustom(&interaction_process_for_states, &interaction_manager::stop_state_based_interaction);
  }

  self waittill("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
}

function play_interaction_simple(interaction_name, optional_scripted_struct, optional_prop) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  interaction = get_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("<dev string:x97>" + interaction_name + "<dev string:xb2>");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "RF\x9e\xe1\xc4\x1f\xe7";
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
    level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = utility::array_add(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self);
  }

  if(isDefined(optional_prop)) {
    self.optional_prop = optional_prop;
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;

    if(isarray(self.lookat_anims["\x91\x88\xc2*"])) {
      var_d1f285138c58cb08 = self.lookat_anims["\x91\x88\xc2*"][0];
    } else {
      var_d1f285138c58cb08 = self.lookat_anims["\x91\x88\xc2*"];
    }

    if(isstring(optional_scripted_struct)) {
      optional_struct = utility::getStruct(optional_scripted_struct, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else if(isent(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("<dev string:x22e>");
      return;
    }

    anime = var_d1f285138c58cb08;
    start_origin = getstartorigin(optional_struct.origin, optional_struct.angles, anime);
    start_angles = getstartangles(optional_struct.origin, optional_struct.angles, anime);
    self.optional_struct = optional_scripted_struct;
  }

  if(!isDefined(self.is_cheap)) {
    self animmode("b\xf21\xbc\xeb{");
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["\xa4\x93<sJA"])) {
    if(!isDefined(self.is_cheap) && !isnullweapon(self.weapon)) {
      ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    thread simple_interaction_idles();
    thread interaction_end_cheap();
  } else {
    asm_sp::asm_animcustom(&simple_interaction_idles, &interaction_end);
  }

  self waittill("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
}

function play_interaction_blended(interaction_name, optional_scripted_struct) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  interaction = get_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("<dev string:x97>" + interaction_name + "<dev string:xb2>");
    return;
  }

  reset_actor_interaction_values(interaction, interaction_name);
  add_actor_tointeractionmanager();
  move_actor_tointeractionposition(optional_scripted_struct);
  run_blended_interaction();
}

function reset_actor_interaction_values(interaction, interaction_name) {
  if(!isDefined(self.animname)) {
    self.animname = "RF\x9e\xe1\xc4\x1f\xe7";
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

  if(isDefined(self.lookat_anims["\xa4\x93<sJA"])) {
    if(!isDefined(self.is_cheap)) {
      ai::gun_remove();
    }
  }
}

function add_actor_tointeractionmanager() {
  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = utility::array_add(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self);
  }
}

function get_interaction_actor_lookatidle() {
  if(isarray(self.lookat_anims["\x91\x88\xc2*"])) {
    return self.lookat_anims["\x91\x88\xc2*"][0];
  }

  return self.lookat_anims["\x91\x88\xc2*"];
}

function get_interaction_actor_optionalstruct(optional_scripted_struct) {
  optional_struct = undefined;

  if(isstring(optional_scripted_struct)) {
    optional_struct = utility::getStruct(optional_scripted_struct, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  } else if(isstruct(optional_scripted_struct)) {
    optional_struct = optional_scripted_struct;
  } else if(isent(optional_scripted_struct)) {
    optional_struct = optional_scripted_struct;
  } else {
    assertmsg("<dev string:x22e>");
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
      self animmode("b\xf21\xbc\xeb{");
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
    asm_sp::asm_animcustom(&interaction_process_blended, &interaction_end);
  }

  self waittill("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
}

function play_interaction_immediate(interaction_name, optional_scripted_struct) {
  self endon("\x1e\xfd\xd1\xa2\a");
  interaction = get_interaction(interaction_name);

  if(!isDefined(interaction)) {
    assertmsg("<dev string:x97>" + interaction_name + "<dev string:xb2>");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "RF\x9e\xe1\xc4\x1f\xe7";
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
    level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = utility::array_add(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self);
  }

  if(isDefined(optional_scripted_struct)) {
    optional_struct = undefined;
    starting_anim = self.lookat_anims["Q\x01\xbe\xad\xe3\x1e\x0e\xba"];

    if(isstring(optional_scripted_struct)) {
      optional_struct = utility::getStruct(optional_scripted_struct, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    } else if(isstruct(optional_scripted_struct)) {
      optional_struct = optional_scripted_struct;
    } else {
      assertmsg("<dev string:x22e>");
      return;
    }

    self.lookat_anims["\x9f0\xfc\xdcXJ`\xea\xe3\xbe\x02K\xd9?#"] = optional_struct;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["\xa4\x93<sJA"])) {
    if(!isDefined(self.is_cheap)) {
      ai::gun_remove();
    }
  }

  thread asm_sp::asm_animcustom(&interaction_immediate_process);
  self waittill("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
}

function clear_root() {
  self clearanim(%\xb7\x1bs\xf8, 0.2);
}

function is_looking_at_range(target_guy, range) {
  player_forward = anglesToForward(level.player.angles);
  var_39c027471595bf56 = vectorNormalize(target_guy.origin - level.player.origin);
  dot_vec = vectordot(player_forward, var_39c027471595bf56);

  if(dot_vec >= range) {
    return 1;
  }

  return 0;
}

function interaction_immediate_process() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
    self animmode("b\xf21\xbc\xeb{");
  }

  optional_struct = self.lookat_anims["\x9f0\xfc\xdcXJ`\xea\xe3\xbe\x02K\xd9?#"];
  anim_string = "\xb3\\\x97b@19[\x9e\xc1\xd7";

  if(!utility::ent_flag_exist("\x1a\xa0\x91C\x1a\xdf\x9f\xc1\xfb~\xb9\x9dE`\x98")) {
    utility::ent_flag_init("\x1a\xa0\x91C\x1a\xdf\x9f\xc1\xfb~\xb9\x9dE`\x98");
  }

  utility::ent_flag_clear("\x1a\xa0\x91C\x1a\xdf\x9f\xc1\xfb~\xb9\x9dE`\x98");
  initial_reaction_blendtime = 0.25;
  lookat_end_blendtime = 0.25;

  if(isDefined(self.lookat_anims["\x1f\xd7B\t\x17\x80\bZ\xcb\xa2\xf5"])) {
    thread interaction_manager::trigger_interaction_common();
  }

  if(!self.nearby_interaction_running) {
    self.is_playing_reaction = 1;
    self notify("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
    var_3a0109b661e8a1a7 = undefined;

    if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
      var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
    } else {
      var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
    follow_percent = math::normalize_value(0, 360, angle);
    println("<dev string:x25b>" + angle);
    reaction_anim = self.lookat_anims["Q\x01\xbe\xad\xe3\x1e\x0e\xba"];

    if(isDefined(self.lookat_anims["\xc5\x94\x82H\x9a`"])) {
      foreach(reaction_angle in self.lookat_anims["\xc5\x94\x82H\x9a`"]) {
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
    level notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
    self notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  }
}

function interaction_follow_process() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
    self animmode("b\xf21\xbc\xeb{");
  }

  starting_idle = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["\x91\x88\xc2*"])) {
    starting_idle = self.lookat_anims["\x91\x88\xc2*"][0];
    thread random_idle_controller();
  } else {
    starting_idle = self.lookat_anims["\x91\x88\xc2*"];
  }

  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim("\x91\x88\xc2*", starting_idle, 1, 0.5, 1);
  thread interaction_set_anim_movement("\x04M\xed\xab");
  anim_string = "\xb3\\\x97b@19[\x9e\xc1\xd7";

  if(!utility::ent_flag_exist("=\xdf\xdc/R_Lz(")) {
    utility::ent_flag_init("=\xdf\xdc/R_Lz(");
  }

  utility::ent_flag_clear("=\xdf\xdc/R_Lz(");

  if(!utility::ent_flag_exist("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/")) {
    utility::ent_flag_init("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
  }

  utility::ent_flag_clear("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
  lookat_lerp = 0.11;
  initial_reaction_blendtime = 0.25;
  lookat_follow_blendtime = 0.25;
  lookat_end_distance = 350;
  lookat_end_blendtime = 0.45;
  using_reacquire = undefined;
  reacquire_started = undefined;
  var_2f5d04ecdc0c8996 = undefined;

  if(isDefined(self.lookat_anims["^>J-\xce\xd0\vu\xa9B\xae\x04\xfa%"]) || isDefined(self.lookat_anims["\"KB\xb6~f\xcdP\xfbA\x05R\xb7\b8"])) {
    using_reacquire = 1;
  }

  self.reactiontrigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", self.origin, 0, self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"], self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]);

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

    var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
    trace_end = undefined;
    tracecontents = trace::create_contents(1, 1, 0, 1, 1, 1);
    trace = undefined;

    while(true) {
      if(isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
        break;
      }

      if(interaction_manager::can_play_nearby_interaction(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] * 2)) {
        if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
          var_b7ad5728319caeda = lengthsquared(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
        } else {
          var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
          break;
        } else if(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] > 0 && var_b7ad5728319caeda < squared(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          actor_eye = self.origin + anglestoup(self.angles) * 66;
          trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] + actor_eye;
          trace = trace::ray_trace(actor_eye, trace_end, self, tracecontents);

          if(isPlayer(trace["\x1f\xa8\x10WP\xa9"]) || isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
            break;
          }
        }
      }

      waitframe();
    }

    if(isDefined(self.lookat_anims["\x1f\xd7B\t\x17\x80\bZ\xcb\xa2\xf5"])) {
      thread interaction_manager::trigger_interaction_common();
    }

    self.is_playing_reaction = 1;
    self notify("\x19\xee%c\xc4\x8a\xad\xe8T\x82\xffR=\xda\x06\xcd$tAC^\x85\xbe\xd9\xc9");
    level notify("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
    var_3a0109b661e8a1a7 = undefined;

    if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
      var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
    } else {
      var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
    follow_percent = math::normalize_value(0, 360, angle);

    if(isDefined(self.lookat_anims["J^\x18u\xd6-a\x06"])) {
      if(follow_percent >= 0 && follow_percent <= 0.5) {
        follow_percent += 0.5;
      } else {
        follow_percent -= 0.5;
      }
    }

    println("<dev string:x25b>" + angle);
    reaction_anim = self.lookat_anims["Q\x01\xbe\xad\xe3\x1e\x0e\xba"];

    if(isDefined(self.lookat_anims["\xc5\x94\x82H\x9a`"]) && !self.sequential_scene) {
      foreach(reaction_angle in self.lookat_anims["\xc5\x94\x82H\x9a`"]) {
        if(angle <= reaction_angle) {
          reaction_anim = self.lookat_anims[reaction_angle];
          break;
        }
      }
    }

    if(isarray(reaction_anim)) {
      if(isarray(reaction_anim[0])) {
        var_6168817ba6e28cbc = self.anim_sequential_counter;
        var_86adefa702820ffc = reaction_anim[0][var_6168817ba6e28cbc][0];
      } else {
        var_86adefa702820ffc = reaction_anim[0];
      }
    } else {
      var_86adefa702820ffc = reaction_anim;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var_86adefa702820ffc);
      self setflaggedanimknob(anim_string, var_86adefa702820ffc, 1, initial_reaction_blendtime, 1);
      self.is_playing_reaction = 1;
    }

    if(!self.skip_interaction) {
      if(isarray(reaction_anim)) {
        if(isarray(reaction_anim[0]) && !isarray(self.lookat_anims[".\x12\xb9\xc9"])) {
          var_6168817ba6e28cbc = self.anim_sequential_counter;
          vo_array = reaction_anim[0][var_6168817ba6e28cbc];
          thread set_sequential_wait_time(vo_array);
          thread play_anim_vo_sequential(vo_array);
        } else if(reaction_anim.size > 1) {
          thread play_anim_vo_sequential(reaction_anim);
        }
      }
    }

    if(isDefined(self.lookat_anims["\x0f^\xe0\xd4\x02\a^7\xb9f\x04\xe9\x01"])) {
      self thread[[self.lookat_anims["\x0f^\xe0\xd4\x02\a^7\xb9f\x04\xe9\x01"]]]();
    }

    var_180bf495d8c37c44 = getanimlength(var_86adefa702820ffc);
    var_180bf495d8c37c44 -= lookat_follow_blendtime;

    if(var_180bf495d8c37c44 < 0) {
      var_180bf495d8c37c44 = 0;
    }

    if(!self.skip_interaction) {
      wait var_180bf495d8c37c44;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"]);
      self setflaggedanimlimited(anim_string, self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], 1, 0.25, 1);
      self setanimtime(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], follow_percent);
      self setanimknob(self.lookat_anims["\x86\xd5\xe9\x1e"], 1, lookat_follow_blendtime, 1);
    }

    diff_anim = undefined;

    if(isarray(self.lookat_anims[".\x12\xb9\xc9"])) {
      var_6168817ba6e28cbc = self.anim_sequential_counter;
      diff_anim = self.lookat_anims[".\x12\xb9\xc9"][var_6168817ba6e28cbc];
    } else {
      diff_anim = self.lookat_anims[".\x12\xb9\xc9"];
    }

    start_fakeactor_notetracks(diff_anim);
    self setflaggedanimlimited(anim_string, diff_anim, 1, 0.25, 1);
    self.is_playing_reaction = 1;

    if(!self.skip_interaction) {
      self setanimlimited(self.lookat_anims["\xa6g\xce\x87\xd6\xbakY"], 1, lookat_follow_blendtime, 1);
    }

    utility::delaythread(getanimlength(diff_anim), &utility::ent_flag_set, "=\xdf\xdc/R_Lz(");
    utility::ent_flag_set("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
    thread utility::ent_flag_clear_delayed("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/", getanimlength(diff_anim));
    var_c2e3ce36da51e7fc = follow_percent;

    while(true) {
      var_5dfe67a693db377a = distance2d(level.player.origin, self.origin);

      if((var_5dfe67a693db377a >= lookat_end_distance || utility::ent_flag("=\xdf\xdc/R_Lz(")) && !isDefined(using_reacquire)) {
        var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);

        if(var_b7ad5728319caeda < squared(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"])) {
          actor_eye = self.origin + anglestoup(self.angles) * 66;
          trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] + actor_eye;
          trace = trace::ray_trace(actor_eye, trace_end, self, tracecontents);

          if(isPlayer(trace["\x1f\xa8\x10WP\xa9"]) || isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
            if(isarray(self.lookat_anims[".\x12\xb9\xc9"]) && self.anim_sequential_counter < self.lookat_anims[".\x12\xb9\xc9"].size - 1) {
              self.sequential_scene = 1;
              utility::ent_flag_clear("=\xdf\xdc/R_Lz(");
              self.anim_sequential_counter += 1;
              self clearanim(diff_anim, 0.15);
              self.is_playing_reaction = 0;
              break;
            }
          }
        }

        if(isDefined(self.lookat_anims["j\xc3%\\F\xe4\x8f\xa5\xd6\xac"])) {
          exit_anim = self.lookat_anims["U\x9f\xf1tVx\xf1*\xa7\xc3=\xe44Hu\xb2"]["\xec\x03\xf1\x9f\xd8\xf3'\xa5w\x16BL"];

          if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
            var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
          } else {
            var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
          }

          angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
          println("<dev string:x25b>" + angle);

          foreach(exit_angle in self.lookat_anims["j\xc3%\\F\xe4\x8f\xa5\xd6\xac"]) {
            if(angle <= exit_angle) {
              exit_anim = self.lookat_anims["U\x9f\xf1tVx\xf1*\xa7\xc3=\xe44Hu\xb2"][exit_angle];
              break;
            }
          }

          start_fakeactor_notetracks(exit_anim);
          self setflaggedanimknob(anim_string, exit_anim, 1, lookat_end_blendtime, 1);
          wait getanimlength(exit_anim);

          if(isDefined(self.lookat_anims["\xef\x02\xc3gY7a}"])) {
            if(isarray(reaction_anim[0])) {
              if(self.anim_sequential_counter >= reaction_anim[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["\xef\x02\xc3gY7a}"]);
                self setflaggedanimknob(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], 1, lookat_end_blendtime, 1);
              } else {
                start_fakeactor_notetracks(starting_idle);
                self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["\xef\x02\xc3gY7a}"]);
              self setflaggedanimknob(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], 1, lookat_end_blendtime, 1);
            }
          } else {
            start_fakeactor_notetracks(starting_idle);
            self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims[".\x12\xb9\xc9"])) {
            if(self.anim_sequential_counter < self.lookat_anims[".\x12\xb9\xc9"].size) {
              utility::ent_flag_clear("=\xdf\xdc/R_Lz(");
              self clearanim(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], 0.1);
              self clearanim(self.lookat_anims["\x86\xd5\xe9\x1e"], 0.1);
              self.anim_sequential_counter += 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims[".\x12\xb9\xc9"].size) {
              self.is_playing_reaction = 0;
              var_2f5d04ecdc0c8996 = 1;

              if(!isDefined(self.lookat_anims["3H\x13\xa4\xef\x15(\xd0\xb6W\xcd\x8e\xc6d\xd5"])) {
                self waittill(")\xb0\x16\xd5YF\xae");
              }
            }
          } else {
            var_2f5d04ecdc0c8996 = 1;

            if(!isDefined(self.lookat_anims["3H\x13\xa4\xef\x15(\xd0\xb6W\xcd\x8e\xc6d\xd5"])) {
              self waittill(")\xb0\x16\xd5YF\xae");
            }
          }

          self.is_playing_reaction = 0;
          break;
        } else {
          if(isDefined(self.lookat_anims["\xef\x02\xc3gY7a}"])) {
            if(isarray(reaction_anim[0])) {
              if(self.anim_sequential_counter >= reaction_anim[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["\xef\x02\xc3gY7a}"]);
                self setflaggedanimknob(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], 1, lookat_end_blendtime, 1);
              } else {
                start_fakeactor_notetracks(starting_idle);
                self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["\xef\x02\xc3gY7a}"]);
              self setflaggedanimknob(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], 1, lookat_end_blendtime, 1);
            }
          } else {
            start_fakeactor_notetracks(starting_idle);
            self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims[".\x12\xb9\xc9"])) {
            if(self.anim_sequential_counter < self.lookat_anims[".\x12\xb9\xc9"].size) {
              utility::ent_flag_clear("=\xdf\xdc/R_Lz(");
              self clearanim(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], 0.1);
              self clearanim(self.lookat_anims["\x86\xd5\xe9\x1e"], 0.1);
              self.anim_sequential_counter += 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims[".\x12\xb9\xc9"].size) {
              self.is_playing_reaction = 0;
              var_2f5d04ecdc0c8996 = 1;

              if(!isDefined(self.lookat_anims["3H\x13\xa4\xef\x15(\xd0\xb6W\xcd\x8e\xc6d\xd5"])) {
                self waittill(")\xb0\x16\xd5YF\xae");
              }
            }
          } else {
            var_2f5d04ecdc0c8996 = 1;

            if(!isDefined(self.lookat_anims["3H\x13\xa4\xef\x15(\xd0\xb6W\xcd\x8e\xc6d\xd5"])) {
              self waittill(")\xb0\x16\xd5YF\xae");
            }
          }

          self.is_playing_reaction = 0;
          break;
        }
      }

      if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
        var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
      } else {
        var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
      follow_percent = math::normalize_value(0, 360, angle);

      if(self.followoff) {
        follow_percent = 0;
      }

      if(isDefined(self.lookat_anims["J^\x18u\xd6-a\x06"])) {
        if(follow_percent >= 0 && follow_percent <= 0.5) {
          follow_percent += 0.5;
        } else {
          follow_percent -= 0.5;
        }

        var_c2e3ce36da51e7fc += (follow_percent - var_c2e3ce36da51e7fc) * lookat_lerp;
      } else {
        var_c2e3ce36da51e7fc += (follow_percent - var_c2e3ce36da51e7fc) * lookat_lerp;
      }

      if(isDefined(using_reacquire)) {
        vec_to_player = vectorNormalize(level.player.origin - self.origin);
        vec_to_player = utility::flatten_vector(vec_to_player, anglestoup(self.angles));
        var_2f781ce4070720da = anglesToForward(self.angles);
        dot_angle = vectordot(vec_to_player, var_2f781ce4070720da);
        angle = acos(dot_angle);
        cross = vectorcross(vec_to_player, var_2f781ce4070720da);

        if(vectordot(cross, anglestoup(self.angles)) < 0) {
          angle *= -1;
        }

        var_ac3b66b1c3cdcd65 = 0;

        if(angle >= 90 && !var_ac3b66b1c3cdcd65 && !utility::ent_flag("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/")) {
          var_ac3b66b1c3cdcd65 = 1;
          start_fakeactor_notetracks(self.lookat_anims["\"KB\xb6~f\xcdP\xfbA\x05R\xb7\b8"]);
          self clearanim(%\xb7\x1bs\xf8, 0.25);
          self setflaggedanimrestart(anim_string, self.lookat_anims["\"KB\xb6~f\xcdP\xfbA\x05R\xb7\b8"], 1, 0.25);
          wait clamp(getanimlength(self.lookat_anims["\"KB\xb6~f\xcdP\xfbA\x05R\xb7\b8"]) - 0.25, 0, 100);
          self clearanim(self.lookat_anims["\"KB\xb6~f\xcdP\xfbA\x05R\xb7\b8"], 0.25);
        } else if(angle < -90 && !var_ac3b66b1c3cdcd65 && !utility::ent_flag("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/")) {
          var_ac3b66b1c3cdcd65 = 1;
          start_fakeactor_notetracks(self.lookat_anims["^>J-\xce\xd0\vu\xa9B\xae\x04\xfa%"]);
          self clearanim(%\xb7\x1bs\xf8, 0.25);
          self setflaggedanimrestart(anim_string, self.lookat_anims["^>J-\xce\xd0\vu\xa9B\xae\x04\xfa%"], 1, 0.25);
          wait clamp(getanimlength(self.lookat_anims["^>J-\xce\xd0\vu\xa9B\xae\x04\xfa%"]) - 0.25, 0, 100);
          self clearanim(self.lookat_anims["^>J-\xce\xd0\vu\xa9B\xae\x04\xfa%"], 0.25);
        } else {
          set_time_via_rate(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], var_c2e3ce36da51e7fc);
        }

        if(var_ac3b66b1c3cdcd65) {
          if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
            var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
          } else {
            var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
          }

          angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
          follow_percent = math::normalize_value(0, 360, angle);
          start_fakeactor_notetracks(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"]);
          self setflaggedanimlimited(anim_string, self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], 1, 0.25, 1);
          self setanimtime(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], 0.5);
          self setanimknob(self.lookat_anims["\x86\xd5\xe9\x1e"], 1, lookat_follow_blendtime, 1);

          if(!utility::ent_flag("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/") && !utility::ent_flag("=\xdf\xdc/R_Lz(")) {
            start_fakeactor_notetracks(self.lookat_anims[".\x12\xb9\xc9"]);
            self setflaggedanimlimited(anim_string, self.lookat_anims[".\x12\xb9\xc9"], 1, 0.05, 1);
          }

          self setanimlimited(self.lookat_anims["\xa6g\xce\x87\xd6\xbakY"], 1, lookat_follow_blendtime, 1);
          var_c2e3ce36da51e7fc = 0.5;
        }
      } else {
        set_time_via_rate(self.lookat_anims["\xe5\xf7\xa5\xa3%\xf8"], var_c2e3ce36da51e7fc);
      }

      waitframe();
    }

    waitframe();
  }
}

function interaction_process() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self.followoff = 0;
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
    self animmode("b\xf21\xbc\xeb{");
  }

  starting_idle = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["\x91\x88\xc2*"])) {
    starting_idle = self.lookat_anims["\x91\x88\xc2*"][0];
    thread random_idle_controller();
  } else {
    starting_idle = self.lookat_anims["\x91\x88\xc2*"];
  }

  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim("\x91\x88\xc2*", starting_idle, 1, 0.05, 1);
  thread interaction_set_anim_movement("\x04M\xed\xab");
  anim_string = "\xb3\\\x97b@19[\x9e\xc1\xd7";

  if(!utility::ent_flag_exist("=\xdf\xdc/R_Lz(")) {
    utility::ent_flag_init("=\xdf\xdc/R_Lz(");
  }

  utility::ent_flag_clear("=\xdf\xdc/R_Lz(");
  lookat_lerp = 0.11;

  if(isDefined(self.lookat_anims["\xc4\x06\x13@Z;'e\xc0\x13["])) {
    lookat_lerp = self.lookat_anims["\xc4\x06\x13@Z;'e\xc0\x13["];
  }

  initial_reaction_blendtime = 0.25;

  if(isDefined(self.lookat_anims["\xfd\xef\xd5\x05\xcb#\x94\xd1\x160\x83\fm\x1cC_\xe0\xe0 v\xd1\x1b\xd9\xa1\xc4\xaa"])) {
    initial_reaction_blendtime = self.lookat_anims["\xfd\xef\xd5\x05\xcb#\x94\xd1\x160\x83\fm\x1cC_\xe0\xe0 v\xd1\x1b\xd9\xa1\xc4\xaa"];
  }

  lookat_follow_blendtime = 0.25;

  if(isDefined(self.lookat_anims["Sx\x9b\xe04\xb7#!\xba0\xebf)e\xd4\xa1\xfd\xcc\xcaVp \xb5"])) {
    lookat_follow_blendtime = self.lookat_anims["Sx\x9b\xe04\xb7#!\xba0\xebf)e\xd4\xa1\xfd\xcc\xcaVp \xb5"];
  }

  lookat_end_distance = 350;

  if(isDefined(self.lookat_anims["\x1a\x14\x8fU\x82W\xe8=\a\xc05\xe1y\xcb\x8am(\x1eX"])) {
    lookat_end_distance = self.lookat_anims["\x1a\x14\x8fU\x82W\xe8=\a\xc05\xe1y\xcb\x8am(\x1eX"];
  }

  lookat_end_blendtime = 0.45;

  if(isDefined(self.lookat_anims["-\x12O9,H\x84s\f\xf1\xe4\xf9@0.%\x03\xca\x85\xaf"])) {
    lookat_end_blendtime = self.lookat_anims["-\x12O9,H\x84s\f\xf1\xe4\xf9@0.%\x03\xca\x85\xaf"];
  }

  self.reactiontrigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", self.origin, 0, self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"], self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]);

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

    var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
    trace_end = undefined;
    tracecontents = trace::create_contents(1, 1, 0, 1, 1, 1);
    trace = undefined;

    while(true) {
      if(isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
        break;
      }

      if(interaction_manager::can_play_nearby_interaction(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] * 2)) {
        if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
          var_b7ad5728319caeda = lengthsquared(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
        } else {
          var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
          break;
        } else if(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] > 0 && var_b7ad5728319caeda < squared(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          actor_eye = self.origin + anglestoup(self.angles) * 66;
          trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] + actor_eye;
          trace = trace::ray_trace(actor_eye, trace_end, self, tracecontents);

          if(isPlayer(trace["\x1f\xa8\x10WP\xa9"]) || isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
            break;
          }
        }
      }

      waitframe();
    }

    if(isDefined(self.lookat_anims["\x1f\xd7B\t\x17\x80\bZ\xcb\xa2\xf5"])) {
      thread interaction_manager::trigger_interaction_common();
    }

    self.is_playing_reaction = 1;
    self notify("\x19\xee%c\xc4\x8a\xad\xe8T\x82\xffR=\xda\x06\xcd$tAC^\x85\xbe\xd9\xc9");
    level notify("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
    var_3a0109b661e8a1a7 = undefined;

    if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
      var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
    } else {
      var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
    println("<dev string:x25b>" + angle);
    reaction_anim = self.lookat_anims["Q\x01\xbe\xad\xe3\x1e\x0e\xba"];

    if(isDefined(self.lookat_anims["\xc5\x94\x82H\x9a`"])) {
      foreach(reaction_angle in self.lookat_anims["\xc5\x94\x82H\x9a`"]) {
        if(angle <= reaction_angle) {
          reaction_anim = self.lookat_anims[reaction_angle];
          break;
        }
      }
    }

    if(isarray(reaction_anim)) {
      if(isarray(reaction_anim[0]) && self.anim_sequential_counter < reaction_anim[0].size) {
        var_6168817ba6e28cbc = self.anim_sequential_counter;
        var_86adefa702820ffc = reaction_anim[0][var_6168817ba6e28cbc][0];
      } else {
        var_86adefa702820ffc = reaction_anim[0];
      }
    } else {
      var_86adefa702820ffc = reaction_anim;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var_86adefa702820ffc);
      self setflaggedanimknob(anim_string, var_86adefa702820ffc, 1, initial_reaction_blendtime, 1);
      self.is_playing_reaction = 1;
    }

    level thread interaction_manager::interaction_cooldown_timer(self);

    if(isDefined(self.lookat_anims["1\xf5\x92\xd8;"])) {
      if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
        var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
      } else {
        var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);

      if(self.skip_interaction) {
        wait 0;
      } else {
        wait getanimlength(var_86adefa702820ffc);
      }

      if(isarray(self.lookat_anims["1\xf5\x92\xd8;"])) {
        current_index = self.scene_sequential_sounter;
        start_fakeactor_notetracks(self.lookat_anims["1\xf5\x92\xd8;"][current_index]);
        self setflaggedanimknob(anim_string, self.lookat_anims["1\xf5\x92\xd8;"][current_index], 1, lookat_follow_blendtime, 1);
        wait getanimlength(self.lookat_anims["1\xf5\x92\xd8;"][current_index]);
        self.scene_sequential_sounter += 1;
        self.sequential_scene = 1;
      } else {
        start_fakeactor_notetracks(self.lookat_anims["1\xf5\x92\xd8;"]);
        self setflaggedanimknob(anim_string, self.lookat_anims["1\xf5\x92\xd8;"], 1, lookat_follow_blendtime, 1);
        wait getanimlength(self.lookat_anims["1\xf5\x92\xd8;"]);
      }
    }

    if(isDefined(self.lookat_anims["j\xc3%\\F\xe4\x8f\xa5\xd6\xac"])) {
      if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
        var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
      } else {
        var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
      println("<dev string:x25b>" + angle);
      exit_anim = self.lookat_anims["U\x9f\xf1tVx\xf1*\xa7\xc3=\xe44Hu\xb2"]["\xec\x03\xf1\x9f\xd8\xf3'\xa5w\x16BL"];

      foreach(exit_angle in self.lookat_anims["j\xc3%\\F\xe4\x8f\xa5\xd6\xac"]) {
        if(angle <= exit_angle) {
          exit_anim = self.lookat_anims["U\x9f\xf1tVx\xf1*\xa7\xc3=\xe44Hu\xb2"][exit_angle];
          break;
        }
      }

      start_fakeactor_notetracks(exit_anim);
      self setflaggedanimknob(anim_string, exit_anim, 1, lookat_end_blendtime, 1);
      wait getanimlength(exit_anim);

      if(isDefined(self.lookat_anims["\xef\x02\xc3gY7a}"])) {
        if(isarray(reaction_anim[0])) {
          if(self.anim_sequential_counter >= reaction_anim[0].size) {
            start_fakeactor_notetracks(self.lookat_anims["\xef\x02\xc3gY7a}"]);
            self setflaggedanimknob(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], 1, lookat_end_blendtime, 1);
          } else {
            start_fakeactor_notetracks(starting_idle);
            self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
          }
        } else {
          start_fakeactor_notetracks(self.lookat_anims["\xef\x02\xc3gY7a}"]);
          self setflaggedanimknob(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], 1, lookat_end_blendtime, 1);
        }
      } else {
        start_fakeactor_notetracks(starting_idle);
        self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
      }

      self.is_playing_reaction = 0;

      if(!isDefined(self.lookat_anims["3H\x13\xa4\xef\x15(\xd0\xb6W\xcd\x8e\xc6d\xd5"])) {
        self waittill(")\xb0\x16\xd5YF\xae");
      }
    }

    if(!self.skip_interaction) {
      if(isarray(reaction_anim)) {
        if(isarray(reaction_anim[0]) && self.anim_sequential_counter < reaction_anim[0].size) {
          var_6168817ba6e28cbc = self.anim_sequential_counter;
          vo_array = reaction_anim[0][var_6168817ba6e28cbc];
          thread set_sequential_wait_time(vo_array);
          thread play_anim_vo_sequential(vo_array);
        } else if(reaction_anim.size > 1) {
          thread play_anim_vo_sequential(reaction_anim);
        }
      }
    }

    if(isDefined(self.lookat_anims["\x0f^\xe0\xd4\x02\a^7\xb9f\x04\xe9\x01"])) {
      self[[self.lookat_anims["\x0f^\xe0\xd4\x02\a^7\xb9f\x04\xe9\x01"]]]();
    }

    var_180bf495d8c37c44 = getanimlength(var_86adefa702820ffc);
    wait var_180bf495d8c37c44;

    if(isDefined(self.lookat_anims["\xef\x02\xc3gY7a}"])) {
      if(isarray(reaction_anim)) {
        if(isarray(reaction_anim[0])) {
          start_fakeactor_notetracks();

          if(self.anim_sequential_counter >= reaction_anim[0].size - 1) {
            self setflaggedanimknoball(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], %\xb7\x1bs\xf8, 1, lookat_end_blendtime, 1);
          } else {
            self setflaggedanimknoball(anim_string, starting_idle, %\xb7\x1bs\xf8, 1, lookat_end_blendtime, 1);
          }
        } else {
          self setflaggedanimknoball(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], %\xb7\x1bs\xf8, 1, lookat_end_blendtime, 1);
        }
      } else {
        start_fakeactor_notetracks();
        self setflaggedanimknoball(anim_string, self.lookat_anims["\xef\x02\xc3gY7a}"], %\xb7\x1bs\xf8, 1, lookat_end_blendtime, 1);
      }
    } else {
      start_fakeactor_notetracks();
      self setflaggedanimknoball(anim_string, starting_idle, %\xb7\x1bs\xf8, 1, lookat_end_blendtime, 1);
    }

    self.anim_sequential_counter += 1;
    level notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
    self notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");

    if(isarray(reaction_anim)) {
      if(isarray(reaction_anim[0]) && self.anim_sequential_counter < reaction_anim[0].size) {
        var_c25944ca50efad79 = self.sequential_loop_padding + self.sequential_wait_time - getanimlength(var_86adefa702820ffc);
        max_wait_time = self.sequential_loop_padding + self.sequential_wait_time + getanimlength(var_86adefa702820ffc);
        var_56bbd3a9ebb2ba35 = clamp(var_c25944ca50efad79, 0, max_wait_time);
        wait var_56bbd3a9ebb2ba35;
        self clearanim(var_86adefa702820ffc, 0.1);
        self.is_playing_reaction = 0;
      } else {
        self.is_playing_reaction = 0;

        if(!isDefined(self.lookat_anims["3H\x13\xa4\xef\x15(\xd0\xb6W\xcd\x8e\xc6d\xd5"])) {
          self waittill(")\xb0\x16\xd5YF\xae");
        }
      }
    } else {
      self.is_playing_reaction = 0;

      if(!isDefined(self.lookat_anims["3H\x13\xa4\xef\x15(\xd0\xb6W\xcd\x8e\xc6d\xd5"])) {
        self waittill(")\xb0\x16\xd5YF\xae");
      }
    }

    waitframe();
  }
}

function interaction_process_for_states() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  clear_root();

  if(!isDefined(self.is_cheap)) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
    self animmode("b\xf21\xbc\xeb{");
  }

  starting_idle = undefined;
  self.random_idle_playing = 0;
  interaction = get_state_interaction(self.interaction_name);

  if(!isDefined(interaction)) {
    return;
  }

  interaction = interaction.scene;
  var_373c232f2244c589 = undefined;

  if(isarray(interaction["\x91\x88\xc2*"])) {
    if(isDefined(self.gender) && issubstr(self.gender, "Y\xfd\xb3\x92CH")) {
      var_373c232f2244c589 = "\x96\xc8\xb1\xb2\xaffV\xadX\x8d+";
    } else {
      var_373c232f2244c589 = "\x91\x88\xc2*";
    }

    starting_idle = interaction[var_373c232f2244c589][0];
    thread random_idle_controller_stateful();
  } else {
    if(isDefined(self.gender) && issubstr(self.gender, "Y\xfd\xb3\x92CH")) {
      var_373c232f2244c589 = "\x96\xc8\xb1\xb2\xaffV\xadX\x8d+";
    } else {
      var_373c232f2244c589 = "\x91\x88\xc2*";
    }

    starting_idle = interaction[var_373c232f2244c589];
  }

  anim_string = "\xb3\\\x97b@19[\x9e\xc1\xd7";
  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim(anim_string, starting_idle, 1, 0.5, 1);
  self setanimtime(starting_idle, randomfloat(1));
  thread interaction_set_anim_movement("\x04M\xed\xab");
  thread play_anim_shared_vo();

  if(!utility::ent_flag_exist("=\xdf\xdc/R_Lz(")) {
    utility::ent_flag_init("=\xdf\xdc/R_Lz(");
  }

  utility::ent_flag_clear("=\xdf\xdc/R_Lz(");
  lookat_lerp = 0.11;
  initial_reaction_blendtime = 0.25;
  lookat_follow_blendtime = 0.25;
  lookat_end_distance = 350;
  lookat_end_blendtime = 0.45;
  self.reactiontrigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", self.origin, 0, interaction["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"], interaction["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]);

  while(true) {
    var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
    trace_end = undefined;
    tracecontents = trace::create_contents(1, 1, 0, 1, 1, 1);
    trace = undefined;

    while(true) {
      if(!isDefined(self.reaction_state) || isDefined(self.reaction_state) && self.reaction_state != "\xccS\x1fe" && self.reaction_state != "e\x94R") {
        if(interaction_manager::can_play_nearby_interaction(interaction["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] * 2)) {
          if(isDefined(interaction["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
            var_b7ad5728319caeda = lengthsquared(interaction["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
          } else {
            var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
          }

          if(isDefined(interaction["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
            break;
          } else if(interaction["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] > 0 && var_b7ad5728319caeda < squared(interaction["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
            actor_eye = self.origin + anglestoup(self.angles) * 66;
            trace_end = vectorNormalize(level.player getEye() - actor_eye) * interaction["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] + actor_eye;
            trace = trace::ray_trace(actor_eye, trace_end, self, tracecontents);

            if(isPlayer(trace["\x1f\xa8\x10WP\xa9"]) || isDefined(interaction["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
              break;
            }
          }
        }
      }

      waitframe();
    }

    self.is_playing_reaction = 1;
    self notify("\x19\xee%c\xc4\x8a\xad\xe8T\x82\xffR=\xda\x06\xcd$tAC^\x85\xbe\xd9\xc9");
    level notify("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
    var_3a0109b661e8a1a7 = undefined;

    if(isDefined(interaction["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
      var_3a0109b661e8a1a7 = vectortoangles(interaction["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
    } else {
      var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
    }

    angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
    println("<dev string:x25b>" + angle);
    chosen_angle = "Q\x01\xbe\xad\xe3\x1e\x0e\xba";

    if(isDefined(interaction["\xc5\x94\x82H\x9a`"])) {
      foreach(reaction_angle in interaction["\xc5\x94\x82H\x9a`"]) {
        if(angle <= reaction_angle) {
          chosen_angle = reaction_angle;
          break;
        }
      }
    }

    if(level.state_interactions[self.interaction_name].scene[chosen_angle].size < 1) {
      level.state_interactions[self.interaction_name].scene[chosen_angle] = level.state_interactions[self.interaction_name].scene["\xc5\x94\x82H\x9a\x01" + utility::string(chosen_angle) + "\xc8u\x9bq\x10\x01"];
      level.state_interactions[self.interaction_name].scene["\xc5\x94\x82H\x9a\x01" + chosen_angle + "\xc8u\x9bq\x10\x01"] = [];
    }

    random_index = randomint(level.state_interactions[self.interaction_name].scene[chosen_angle].size);
    var_86adefa702820ffc = level.state_interactions[self.interaction_name].scene[chosen_angle][random_index];
    start_fakeactor_notetracks(var_86adefa702820ffc);
    self setflaggedanimknob(anim_string, var_86adefa702820ffc, 1, initial_reaction_blendtime, 1);
    self.is_playing_reaction = 1;
    thread interaction_manager::interaction_reboot_timer();
    wait getanimlength(var_86adefa702820ffc);
    level.state_interactions[self.interaction_name].scene["\xc5\x94\x82H\x9a\x01" + chosen_angle + "\xc8u\x9bq\x10\x01"] = utility::array_add(level.state_interactions[self.interaction_name].scene["\xc5\x94\x82H\x9a\x01" + chosen_angle + "\xc8u\x9bq\x10\x01"], var_86adefa702820ffc);
    level.state_interactions[self.interaction_name].scene[chosen_angle] = arrayremove(level.state_interactions[self.interaction_name].scene[chosen_angle], var_86adefa702820ffc);

    if(isDefined(interaction["j\xc3%\\F\xe4\x8f\xa5\xd6\xac"])) {
      if(isDefined(interaction["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
        var_3a0109b661e8a1a7 = vectortoangles(interaction["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
      } else {
        var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
      }

      angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
      println("<dev string:x25b>" + angle);
      var_b6cbae6bcd0cfd91 = "\xec\x03\xf1\x9f\xd8\xf3'\xa5w\x16BL";

      foreach(exit_angle in interaction["j\xc3%\\F\xe4\x8f\xa5\xd6\xac"]) {
        if(angle <= exit_angle) {
          var_b6cbae6bcd0cfd91 = exit_angle;
          break;
        }
      }

      if(level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91].size < 1) {
        level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91][var_b6cbae6bcd0cfd91] = level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91]["V\xc3K\x1d\xaf,\xe6;\x1b\xac_" + utility::string(var_b6cbae6bcd0cfd91) + "\xc8u\x9bq\x10\x01"];
        level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91]["V\xc3K\x1d\xaf,\xe6;\x1b\xac_" + utility::string(var_b6cbae6bcd0cfd91) + "\xc8u\x9bq\x10\x01"] = [];
      }

      random_index = randomint(level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91].size);
      var_eea9db37bdc0b9a5 = level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91][random_index];
      start_fakeactor_notetracks(var_eea9db37bdc0b9a5);
      self setflaggedanimknob(anim_string, var_eea9db37bdc0b9a5, 1, lookat_end_blendtime, 1);
      wait getanimlength(var_eea9db37bdc0b9a5);
      level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91] = arrayremove(level.state_interactions[self.interaction_name].scene[var_b6cbae6bcd0cfd91], var_eea9db37bdc0b9a5);
    }

    start_fakeactor_notetracks(starting_idle);
    self setflaggedanimknob(anim_string, starting_idle, 1, lookat_end_blendtime, 1);
    self.is_playing_reaction = 0;

    if(isDefined(interaction["\x0f^\xe0\xd4\x02\a^7\xb9f\x04\xe9\x01"])) {
      self[[interaction["\x0f^\xe0\xd4\x02\a^7\xb9f\x04\xe9\x01"]]]();
    }

    level notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
    thread interaction_manager::set_reaction_state("\xccS\x1fe");
    waitframe();
    level waittill(")\xb0\x16\xd5YF\xae");
  }
}

function interaction_process_blended() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  initialize_blending_actor();
  lookat_lerp = 0.11;
  initial_reaction_blendtime = 0.25;
  lookat_follow_blendtime = 0.25;
  lookat_end_distance = 350;
  starting_idle = setup_blend_interaction_idles();
  anim_string = "\xb3\\\x97b@19[\x9e\xc1\xd7";

  while(true) {
    self.skip_interaction = is_performing_sequential_scene();
    blended_interaction_tracecheck();
    self.is_playing_reaction = 1;
    self notify("\x19\xee%c\xc4\x8a\xad\xe8T\x82\xffR=\xda\x06\xcd$tAC^\x85\xbe\xd9\xc9");
    level notify("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");

    if(isDefined(self.lookat_anims["\x1f\xd7B\t\x17\x80\bZ\xcb\xa2\xf5"])) {
      thread interaction_manager::trigger_interaction_common();
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
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
    self animmode("b\xf21\xbc\xeb{");
  }

  if(!utility::ent_flag_exist("=\xdf\xdc/R_Lz(")) {
    utility::ent_flag_init("=\xdf\xdc/R_Lz(");
  }

  utility::ent_flag_clear("=\xdf\xdc/R_Lz(");
  self.reactiontrigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", self.origin, 0, self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"], self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]);
}

function setup_blend_interaction_idles() {
  starting_idle = get_interaction_starting_idle();
  self.random_idle_playing = 0;
  start_fakeactor_notetracks(starting_idle);
  self setflaggedanim("\xb3\\\x97b@19[\x9e\xc1\xd7", starting_idle, 1, 0.05, 1);
  thread interaction_set_anim_movement("\x04M\xed\xab");
}

function get_interaction_starting_idle() {
  starting_idle = undefined;

  if(isarray(self.lookat_anims["\x91\x88\xc2*"])) {
    starting_idle = self.lookat_anims["\x91\x88\xc2*"][0];
  } else {
    starting_idle = self.lookat_anims["\x91\x88\xc2*"];
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
  var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
  trace_end = undefined;
  tracecontents = trace::create_contents(1, 1, 0, 1, 1, 1);
  trace = undefined;

  while(true) {
    var_9a5c5c6d56e8f0c6 = interaction_manager::can_play_nearby_interaction(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] * 2);

    if(var_9a5c5c6d56e8f0c6) {
      if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
        var_b7ad5728319caeda = lengthsquared(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
      } else {
        var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
      }

      if(isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
        break;
      } else if(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] > 0 && var_b7ad5728319caeda < squared(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
        actor_eye = self.origin + anglestoup(self.angles) * 66;
        trace_end = vectorNormalize(level.player getEye() - actor_eye) * self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] + actor_eye;
        trace = trace::ray_trace(actor_eye, trace_end, self, tracecontents);

        if(isPlayer(trace["\x1f\xa8\x10WP\xa9"]) || isDefined(self.lookat_anims["\xd2\xcd\x1d+\x9c\v\xc6t\xa5\xf6\xcd\xfa\xa3\x93\xb4\xd9v+N_\xde;e\x9c\xe4Zd\xb2"])) {
          break;
        }
      }
    }

    waitframe();
  }
}

function play_blended_interaction_anims() {
  initialize_blended_interaction_anims();
  var_17fe93aa2ce8e05a = 0;
  var_e6b8d311282ec15d = 0;
  start_time = gettime() / 1000;
  wait_time = getanimlength(self.lookat_anims["\xed\xed\x80\x80\xb5\xe27\xa0"]);

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
    self setanimlimited(self.lookat_anims["\xf6W%m}.'\xc95*"], dot_right, 0.2);
    self setanimlimited(self.lookat_anims["\v9\xfe\x16Y~o\x86\x95"], dot_left, 0.2);
    self setflaggedanimlimited("\xb3\\\x97b@19[\x9e\xc1\xd7", self.lookat_anims["\xed\xed\x80\x80\xb5\xe27\xa0"], dot_fwd + 0.005, 0.2);
    back_test = 1;

    if(math::anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    if(back_test) {
      var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, dot_back, 0.1);
      var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, 0.005, 0.1);
    } else {
      var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, 0.005, 0.1);
      var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, dot_back, 0.1);
    }

    self setanimlimited(self.lookat_anims["\x16\xd1\x9e);\x14\x17\xef;:\t\a\x8e\xeeH"], var_e6b8d311282ec15d, 0.2);
    self setanimlimited(self.lookat_anims["\xce\x8c\xab@> \x14|\xf7\x8030\xe4\xad"], var_17fe93aa2ce8e05a, 0.2);
    waitframe();
  }

  ending_blendtime = 0.45;
  end_blended_interaction_anims(ending_blendtime);
  play_interaction_endidle(ending_blendtime);
}

function initialize_blended_interaction_anims() {
  var_3a0109b661e8a1a7 = undefined;
  var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
  self.is_playing_reaction = 1;
  level thread interaction_manager::interaction_cooldown_timer(self);
  self setanimlimited(self.lookat_anims["\xf0#\x05\n\xbc-\xd3_\xa8M\x96\xc1\xaa\xd7kf\x1cG\x03\xa7C0\xa6U"], 1, 0.2);
  starting_idle = get_interaction_starting_idle();
  self clearanim(starting_idle, 0.2);
  self clearanim(%\x83\xe2\x11D, 0.2);
  start_fakeactor_notetracks(self.lookat_anims["\xed\xed\x80\x80\xb5\xe27\xa0"]);
  self setflaggedanimlimited("\xb3\\\x97b@19[\x9e\xc1\xd7", self.lookat_anims["\xed\xed\x80\x80\xb5\xe27\xa0"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["\xf6W%m}.'\xc95*"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["\v9\xfe\x16Y~o\x86\x95"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["\x16\xd1\x9e);\x14\x17\xef;:\t\a\x8e\xeeH"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["\xce\x8c\xab@> \x14|\xf7\x8030\xe4\xad"], 0.005, 0.05);
}

function end_blended_interaction_anims(blendtime) {
  self.reaction_blend_end = undefined;
  self clearanim(self.lookat_anims["\xed\xed\x80\x80\xb5\xe27\xa0"], blendtime);
  self clearanim(self.lookat_anims["\xf6W%m}.'\xc95*"], blendtime);
  self clearanim(self.lookat_anims["\v9\xfe\x16Y~o\x86\x95"], blendtime);
  self clearanim(self.lookat_anims["\x16\xd1\x9e);\x14\x17\xef;:\t\a\x8e\xeeH"], blendtime);
  self clearanim(self.lookat_anims["\xce\x8c\xab@> \x14|\xf7\x8030\xe4\xad"], blendtime);
  level notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  self notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  self.is_playing_reaction = 0;
}

function play_interaction_endidle(blendtime) {
  while(true) {
    animtoplay = undefined;

    if(isDefined(self.lookat_anims["\xef\x02\xc3gY7a}"])) {
      animtoplay = self.lookat_anims["\xef\x02\xc3gY7a}"];
      start_fakeactor_notetracks(animtoplay);
      self setanimtime(animtoplay, 0);
      self setflaggedanimknoball("\xb3\\\x97b@19[\x9e\xc1\xd7", animtoplay, %\xb7\x1bs\xf8, 1, blendtime, 1);
    } else {
      animtoplay = get_interaction_starting_idle();
      start_fakeactor_notetracks(animtoplay);
      self setanimtime(animtoplay, 0);
      self setflaggedanimknoball("\xb3\\\x97b@19[\x9e\xc1\xd7", animtoplay, %\xb7\x1bs\xf8, 1, blendtime, 1);
    }

    wait getanimlength(animtoplay);
  }
}

function simple_interaction_idles() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  interaction = get_interaction(self.interaction_name);

  if(!utility::ent_flag_exist("\v\xae\xe0?4f\xc9FH\xa6\\&\xed\xfePP\x89")) {
    utility::ent_flag_init("\v\xae\xe0?4f\xc9FH\xa6\\&\xed\xfePP\x89");
  } else {
    utility::ent_flag_clear("\v\xae\xe0?4f\xc9FH\xa6\\&\xed\xfePP\x89");
  }

  if(!isarray(interaction.scene["\x91\x88\xc2*"])) {
    return;
  }

  if(isarray(interaction.scene["\x91\x88\xc2*"]) && interaction.scene["\x91\x88\xc2*"].size <= 1) {
    return;
  }

  spent_array = [];
  anim_array = interaction.scene["\x91\x88\xc2*"];
  starting_idle = anim_array[0];
  anim_array = utility::array_remove_index(anim_array, 0);
  spent_array_prop = undefined;
  var_6edc9e7493e0499d = undefined;
  var_8e7d3667d5476dc3 = undefined;
  var_c93b16548d791b9e = undefined;

  if(isDefined(interaction.scene["\xbdt\xcc8\xf1&h\ft"]) && isDefined(self.optional_prop)) {
    spent_array_prop = [];
    interaction.scene["1\xb2\xf0\r\x85o\xa0\x8a\xa6\xcd\x14&\xf0p[\xeb"] = spent_array_prop;
    var_8e7d3667d5476dc3 = interaction.scene["\xbdt\xcc8\xf1&h\ft"];
    var_6edc9e7493e0499d = var_8e7d3667d5476dc3[0];
    var_8e7d3667d5476dc3 = utility::array_remove_index(var_8e7d3667d5476dc3, 0);
    var_c93b16548d791b9e = var_8e7d3667d5476dc3;
    var_8e7d3667d5476dc3 = undefined;
  }

  idle_array = anim_array;
  anim_array = undefined;
  thread clear_root();
  interaction_set_anim_movement("\x04M\xed\xab");

  while(true) {
    if(isDefined(self.optional_struct)) {
      _set_node_relative_anim_actor(self.optional_struct, starting_idle);
    }

    start_fakeactor_notetracks(starting_idle);
    self setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", starting_idle, 1, 0.2, 1);
    thread script_funcs::ai_lookat_release();

    if(isDefined(self.optional_prop)) {
      thread _simple_interaction_prop_start(var_6edc9e7493e0499d);
    }

    wait getanimlength(starting_idle) * randomintrange(1, 2);

    while(utility::ent_flag("\v\xae\xe0?4f\xc9FH\xa6\\&\xed\xfePP\x89")) {
      wait getanimlength(starting_idle);
    }

    if(idle_array.size <= 0) {
      idle_array = spent_array;
      spent_array = [];
    }

    anim_index = randomint(idle_array.size);
    random_anim = idle_array[anim_index];
    spent_array = utility::array_add(spent_array, random_anim);
    idle_array = utility::array_remove_index(idle_array, anim_index);

    if(isDefined(self.optional_prop)) {
      if(var_c93b16548d791b9e.size <= 0) {
        var_c93b16548d791b9e = spent_array_prop;
        spent_array_prop = [];
      }

      var_5f42156c1598f18b = var_c93b16548d791b9e[anim_index];
      spent_array_prop = utility::array_add(spent_array_prop, var_5f42156c1598f18b);
      var_c93b16548d791b9e = utility::array_remove_index(var_c93b16548d791b9e, anim_index);
      thread _simple_interaction_prop_random_anim(var_5f42156c1598f18b);
    }

    self clearanim(starting_idle, 0.2);

    if(isDefined(self.optional_struct)) {
      _set_node_relative_anim_actor(self.optional_struct, random_anim);
    }

    start_fakeactor_notetracks(random_anim);
    self setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", random_anim, 1, 0.2, 1);
    thread script_funcs::ai_lookat_hold();
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

#using_animtree("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6");

function _simple_interaction_prop_random_anim(random_anim) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
  self.optional_prop setanimknob(random_anim, 1, 0.2, 1);
  self.optional_prop.curr_anim = random_anim;
}

function _simple_interaction_prop_start(starting_anim) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop setanimknob(starting_anim, 1, 0.2, 1);
  self.optional_prop.curr_anim = starting_anim;
}

function _simple_interaction_prop_clear() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
}

function play_anim_vo(waittime, vo_line) {
  wait waittime;
  tok_string = strtok(vo_line, "w");

  if(arraycontains(tok_string, "\x1d5\x17")) {
    level.player utility_sp::play_sound_on_entity(vo_line);
    return;
  }

  utility_sp::smart_dialogue(vo_line);
}

function _play_interaction_anim_vo_note() {
  self notify("\xd6\xaa\x7f\x1d\x81W\x10~X`\xea!\xcd\fF\xc8\xc3;|\xa9\xbd\xc9&\x82K");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("\xd6\xaa\x7f\x1d\x81W\x10~X`\xea!\xcd\fF\xc8\xc3;|\xa9\xbd\xc9&\x82K");

  while(true) {
    self waittill("\xb3\\\x97b@19[\x9e\xc1\xd7", notes);

    if(isarray(notes)) {
      foreach(note in notes) {
        if(issubstr(note, "\xca!\xcf") && !issubstr(note, "\x9b;\x18=")) {
          vo_line = getsubstr(note, 3);
          thread utility_sp::smart_dialogue(vo_line);
          wait lookupsoundlength(vo_line) / 1000;
          self notify("\xcam$[\x8b\xc4 \x1b\x9dm\x8e\x8e \x89\x86");

          if(isDefined(self.scriptedtalkingknob)) {
            self clearanim(self.scriptedtalkingknob, 0.2);
          }
        }
      }

      continue;
    }

    if(issubstr(notes, "\xca!\xcf") && !issubstr(notes, "\x9b;\x18=")) {
      vo_line = getsubstr(notes, 3);
      thread utility_sp::smart_dialogue(vo_line);
      wait lookupsoundlength(vo_line) / 1000;
      self notify("\xcam$[\x8b\xc4 \x1b\x9dm\x8e\x8e \x89\x86");

      if(isDefined(self.scriptedtalkingknob)) {
        self clearanim(self.scriptedtalkingknob, 0.2);
      }
    }
  }
}

function play_note_anim_vo(vo_line) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  can_break = 0;

  while(!can_break) {
    self waittill("\xb3\\\x97b@19[\x9e\xc1\xd7", notetracks);

    if(isarray(notetracks)) {
      foreach(notetrack in notetracks) {
        if(notetrack == "\n,\x86\f\xb7\xdd\xd1 YO\x8b") {
          can_break = 1;
          break;
        }
      }
    } else if(notetracks == "\n,\x86\f\xb7\xdd\xd1 YO\x8b") {
      can_break = 1;
      break;
    }

    waitframe();
  }

  self notify("\x82\x8a\xf4/\xc3\xe8\x95\xd1\xd0\x06\xd56\x8a\xecY/\xc9");
  interaction_manager::play_smart_dialog_if_exists(vo_line);
}

function play_anim_shared_vo() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  var_9cceec3798741d2b = undefined;
  random_line = undefined;

  if(!isDefined(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"])) {
    return;
  }

  if(!isDefined(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"])) {
    return;
  }

  if(!isDefined(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"])) {
    level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "?\xc0\x19\xd5")) {
    if(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"].size < 1) {
      level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"] = level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"];
    }

    lines = level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"];
    var_f2c945b27181759f = randomint(lines.size);
    random_line = lines[var_f2c945b27181759f];
    level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"] = utility::array_remove_index(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"], var_f2c945b27181759f);
    level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"] = utility::array_add(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"], random_line);
  }

  if(!isDefined(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"])) {
    level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "Y\xfd\xb3\x92CH")) {
    if(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"].size < 1) {
      level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"] = level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"];
    }

    lines = level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"];
    var_f2c945b27181759f = randomint(lines.size);
    random_line = lines[var_f2c945b27181759f];
    level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"] = utility::array_remove_index(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"], var_f2c945b27181759f);
    level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"] = utility::array_add(level.interaction_manager.data["\xed!\xfc\xf5\xa9\x94\x1c\x1f\x1fQ-\x87KJ\xf7a\x17(\xcc\x13>o\xe2\x8f)/\x12\xaa\xfb"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"], random_line);
  }

  var_de349a7e6dce73dd = undefined;

  while(true) {
    self waittill("\xb3\\\x97b@19[\x9e\xc1\xd7", notetracks);

    if(isarray(notetracks)) {
      foreach(notetrack in notetracks) {
        if(notetrack == "\n,\x86\f\xb7\xdd\xd1 YO\x8b") {
          var_de349a7e6dce73dd = 1;
          break;
        }
      }
    } else if(notetracks == "\n,\x86\f\xb7\xdd\xd1 YO\x8b") {
      var_de349a7e6dce73dd = 1;
    }

    if(isDefined(var_de349a7e6dce73dd)) {
      break;
    }

    waitframe();
  }

  utility_sp::smart_dialogue(random_line);
}

function play_anim_vo_sequential(var_56c32e5eb5ee49f1) {
  var_9cceec3798741d2b = undefined;
  random_line = undefined;
  registered_interaction = level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name];

  if(isDefined(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"])) {
    var_9cceec3798741d2b = 1;

    if(!isDefined(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"])) {
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "?\xc0\x19\xd5")) {
      if(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"].size < 1) {
        level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"] = level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"];
      }

      lines = level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"];
      var_f2c945b27181759f = randomint(lines.size);
      random_line = lines[var_f2c945b27181759f];
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"] = utility::array_remove_index(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["O\xb0\fa\x9c,0:<\xce\xc1oy"], var_f2c945b27181759f);
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"] = utility::array_add(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["2R\xfd\xb7m)jyyL\x94\x0f"], random_line);
    }
  }

  if(isDefined(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"])) {
    var_9cceec3798741d2b = 1;

    if(!isDefined(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"])) {
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "Y\xfd\xb3\x92CH")) {
      if(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"].size < 1) {
        level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"] = level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"];
      }

      lines = level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"];
      var_f2c945b27181759f = randomint(lines.size);
      random_line = lines[var_f2c945b27181759f];
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"] = utility::array_remove_index(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name]["G=\x8d+\xc8\x18'\n\f0\xd0\xaatI{"], var_f2c945b27181759f);
      level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"] = utility::array_add(level.interaction_manager.data["\xed\xf0\x8e\x89\x1f\x16\x88s_N[\xc5\xc1\x9b_\x8d\x17\xedd\xbc\xba\xe8\x9f"][self.interaction_name][" \xee\xbb\x9c\x1e\x95\xffIN+\x96>\xd1\x87"], random_line);
    }
  }

  last_index = var_56c32e5eb5ee49f1.size - 1;

  if(!isDefined(var_9cceec3798741d2b)) {
    if(isstring(var_56c32e5eb5ee49f1[last_index])) {
      i = 1;

      while(i < var_56c32e5eb5ee49f1.size) {
        play_anim_vo(var_56c32e5eb5ee49f1[i], var_56c32e5eb5ee49f1[i + 1]);
        i += 2;
      }
    } else {
      i = 1;

      while(i < var_56c32e5eb5ee49f1.size - 1) {
        play_anim_vo(var_56c32e5eb5ee49f1[i], var_56c32e5eb5ee49f1[i + 1]);
        i += 2;
      }
    }

    return;
  }

  play_anim_vo(var_56c32e5eb5ee49f1[1], random_line);
}

function set_sequential_wait_time(var_56c32e5eb5ee49f1) {
  self.sequential_wait_time = 0;
  self.sequential_loop_padding = 0;
  last_index = var_56c32e5eb5ee49f1.size - 1;

  if(isstring(var_56c32e5eb5ee49f1[last_index])) {
    self.sequential_loop_padding = 0;
    i = 1;

    while(i < var_56c32e5eb5ee49f1.size) {
      self.sequential_wait_time += var_56c32e5eb5ee49f1[i];
      i += 2;
    }

    return;
  }

  self.sequential_loop_padding = var_56c32e5eb5ee49f1[last_index];
  i = 1;

  while(i < var_56c32e5eb5ee49f1.size - 1) {
    self.sequential_wait_time += var_56c32e5eb5ee49f1[i];
    i += 2;
  }
}

function random_idle_controller() {
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("xX\xacPAYe\xab\xd2-\x03O\xc8\xff\x06\x1f\x0fW\x84>");
  self endon("\x1e\xfd\xd1\xa2\a");
  var_662a70297281ec35 = undefined;
  interaction = get_interaction(self.interaction_name);

  if(!isDefined(interaction)) {
    interaction = get_state_interaction(self.interaction_name);
  }

  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;

  if(!isarray(interaction.scene["\x91\x88\xc2*"])) {
    interaction.scene["\x91\x88\xc2*"] = [interaction.scene["\x91\x88\xc2*"], interaction.scene["\x91\x88\xc2*"]];
  }

  spent_array = [];
  anim_array = interaction.scene["\x91\x88\xc2*"];
  starting_idle = anim_array[0];
  anim_array = utility::array_remove_index(anim_array, 0);
  idle_array = anim_array;
  anim_array = undefined;
  self.starting_random_idle = starting_idle;

  while(true) {
    self.is_playing_random_idle = 1;
    var_16cbc2769e329d2f = getanimlength(starting_idle);
    var_b06551982e451c49 = randomint(2) + 1;
    wait_time = var_16cbc2769e329d2f * float(var_b06551982e451c49);
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
    spent_array = utility::array_add(spent_array, random_anim);
    idle_array = arrayremove(idle_array, random_anim);
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
    self setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", random_anim, 1, 0.2, 1);
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
    self setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", starting_idle, 1, 0.2, 1);
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
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("xX\xacPAYe\xab\xd2-\x03O\xc8\xff\x06\x1f\x0fW\x84>");
  self endon("\x1e\xfd\xd1\xa2\a");
  var_662a70297281ec35 = undefined;
  interaction = get_state_interaction(self.interaction_name);
  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;
  var_373c232f2244c589 = undefined;

  if(isDefined(self.gender) && issubstr(self.gender, "Y\xfd\xb3\x92CH")) {
    var_373c232f2244c589 = "\x96\xc8\xb1\xb2\xaffV\xadX\x8d+";
  } else {
    var_373c232f2244c589 = "\x91\x88\xc2*";
  }

  starting_idle = interaction.scene[var_373c232f2244c589][0];
  self.starting_random_idle = starting_idle;

  while(true) {
    self.is_playing_random_idle = 1;
    var_16cbc2769e329d2f = getanimlength(starting_idle);
    var_b06551982e451c49 = randomint(2) + 1;
    wait_time = var_16cbc2769e329d2f * float(var_b06551982e451c49);
    wait wait_time;

    while(true) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      waitframe();
    }

    var_358d6c51d129ab2c = undefined;
    var_b0614eec6d18744f = undefined;

    if(isDefined(self.gender) && issubstr(self.gender, "Y\xfd\xb3\x92CH")) {
      var_358d6c51d129ab2c = "\xea/\xad{A6\xe3\x1b\t\xd4\x7f\x1c\aLT\f\x8b*\xbe";
      var_b0614eec6d18744f = "6z>\xce\xb0c\x1a\x99kW\xb0\xb0X3fS9QM\xce\x84\xd3\xb4oe";
    } else {
      var_358d6c51d129ab2c = "\xeb\xdd\x7f\xbbs\x9d\xc4\x88\xb6\xd2D\x1b";
      var_b0614eec6d18744f = "77\xfd\x8b^\\\x05\x81bO\xd2\x04 \x88\x10\xa8h\xb0";
    }

    if(level.state_interactions[self.interaction_name].scene[var_358d6c51d129ab2c].size <= 0) {
      level.state_interactions[self.interaction_name].scene[var_358d6c51d129ab2c] = level.state_interactions[self.interaction_name].scene[var_b0614eec6d18744f];
      level.state_interactions[self.interaction_name].scene[var_b0614eec6d18744f] = [];
    }

    random_anim = level.state_interactions[self.interaction_name].scene[var_358d6c51d129ab2c][randomint(level.state_interactions[self.interaction_name].scene[var_358d6c51d129ab2c].size)];
    level.state_interactions[self.interaction_name].scene[var_b0614eec6d18744f] = utility::array_add(level.state_interactions[self.interaction_name].scene[var_b0614eec6d18744f], random_anim);
    level.state_interactions[self.interaction_name].scene[var_358d6c51d129ab2c] = arrayremove(level.state_interactions[self.interaction_name].scene[var_358d6c51d129ab2c], random_anim);
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
    self setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", random_anim, 1, 0.2, 1);
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
    self setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", starting_idle, 1, 0.2, 1);
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
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self endon("xX\xacPAYe\xab\xd2-\x03O\xc8\xff\x06\x1f\x0fW\x84>");
  level endon("xX\xacPAYe\xab\xd2-\x03O\xc8\xff\x06\x1f\x0fW\x84>");
  self endon("s\xd1\xb7\x1c_;\xc9\xde]8\xeb\x96\xc8\x8d\xac_\xc6\xdb\xcd\x8e\x93\xf6l\x1b\xb2\xe4");
  level endon("s\xd1\xb7\x1c_;\xc9\xde]8\xeb\x96\xc8\x8d\xac_\xc6\xdb\xcd\x8e\x93\xf6l\x1b\xb2\xe4");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!utility::flag_exist("\x01S\x93\xa5G>v\x8f.\xf6\xd6&\xac\xaf\x17\xd1\xc0\xb1'\xb6")) {
    utility::flag_init("\x01S\x93\xa5G>v\x8f.\xf6\xd6&\xac\xaf\x17\xd1\xc0\xb1'\xb6");
  }

  spent_array = [];
  anim_array = group_anime;

  while(true) {
    wait randomfloatrange(frequency * 0.5, frequency);

    foreach(actor in actors) {
      if(!isDefined(actor)) {
        self notify("s\xd1\xb7\x1c_;\xc9\xde]8\xeb\x96\xc8\x8d\xac_\xc6\xdb\xcd\x8e\x93\xf6l\x1b\xb2\xe4");
        return;
      }

      actor endon("\x1e\xfd\xd1\xa2\a");
      actor endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
      actor.can_play_random_idle = undefined;
    }

    break_count = 0;

    while(true) {
      if(!utility::flag("\x01S\x93\xa5G>v\x8f.\xf6\xd6&\xac\xaf\x17\xd1\xc0\xb1'\xb6")) {
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

    var_887db695188adfbc = undefined;

    if(isarray(group_anime)) {
      if(anim_array.size <= 0) {
        anim_array = group_anime;
        spent_array = [];
      }

      var_887db695188adfbc = anim_array[randomint(anim_array.size)];
    } else {
      var_887db695188adfbc = group_anime;
    }

    wait_time = 0;

    if(!utility::flag("\x01S\x93\xa5G>v\x8f.\xf6\xd6&\xac\xaf\x17\xd1\xc0\xb1'\xb6")) {
      foreach(actor in actors) {
        if(!isDefined(actor)) {
          self notify("s\xd1\xb7\x1c_;\xc9\xde]8\xeb\x96\xc8\x8d\xac_\xc6\xdb\xcd\x8e\x93\xf6l\x1b\xb2\xe4");
          return;
        }

        animation = actor utility::getanim(var_887db695188adfbc);
        org = getstartorigin(actor.origin, actor.angles, animation);
        ang = getstartangles(actor.origin, actor.angles, animation);

        if(isai(actor)) {
          actor forceteleport(org, ang);
        } else {
          actor.origin = org;
          actor.angles = ang;
        }

        actor thread start_fakeactor_notetracks(animation);
        actor setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", animation, 1, 0.2);
        actor.allow_interactions = 0;
        actor.hold_lookat = 1;
        wait_time = getanimlength(animation);
      }

      wait wait_time;

      if(isarray(group_anime)) {
        spent_array = utility::array_add(spent_array, var_887db695188adfbc);
        anim_array = arrayremove(anim_array, var_887db695188adfbc);
      }

      foreach(guy in actors) {
        if(!isDefined(guy)) {
          self notify("s\xd1\xb7\x1c_;\xc9\xde]8\xeb\x96\xc8\x8d\xac_\xc6\xdb\xcd\x8e\x93\xf6l\x1b\xb2\xe4");
          return;
        }

        animation = guy utility::getanim(var_887db695188adfbc);
        guy thread start_fakeactor_notetracks(guy.starting_random_idle);
        guy setanimknob(animation, 0, 0.2);
        guy setflaggedanimknob("\xb3\\\x97b@19[\x9e\xc1\xd7", guy.starting_random_idle, 1, 0.2, 1);
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
    asm_sp::asm_stopanimScripted();
    interaction_set_anim_movement("\x04M\xed\xab");
  }

  interaction_manager::remove_actor_from_manager();
  self notify("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  thread interaction_manager::stop_gesture_reaction();
  self notify("\xf4\xcfqkC-F\xe0\xfal\xb3pwCiy\f\xb8\x04");
  self.is_talking = undefined;
}

function interaction_end_cheap() {
  self waittill("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  interaction_manager::remove_actor_from_manager();
  self notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  self notify("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  self endon("\xdc\xd1{\x83\xd7'Va\xd8\xd1i\xde\xcd");
  self endon("\xb2_gfFQ8E\xb8\xc7\xe7\x96");
  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.combat_reaction_return_state = statename;

  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"] = utility::array_add(level.interaction_manager.data["\x8a1\x8f\x89\xbc\xa2"], self);
  }

  while(self.script == "-7\xa5\xa3") {
    waitframe();
  }

  while(true) {
    while(true) {
      var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);

      if(var_b7ad5728319caeda < squared(150) && is_looking_at_range(self, 0.925)) {
        break;
      }

      waitframe();
    }

    asmname = self.asmname;
    var_a73049dc6406858b = self asmgetcurrentstate(asmname);

    if(var_a73049dc6406858b == self.combat_reaction_return_state && !self.nearby_interaction_running) {
      if(node.script_reaction == "?\x90\xef\xdc\xc7u\x7ft\xbf\xbe{\xb4\x9e\x93\x8f") {
        interactions = [];

        if(isDefined(node.type)) {
          switch (node.type) {
            case #"hash_c3b74422dec48736":
              interactions = ["\xf9{\xd6\xf80\xd89\xa4l\xde\xa9A\xb1#[", "\aKz?N\xda8KF.t\xc0B\xe42"];
              break;
            case #"hash_e1d8e1adebed5a61":
              switch (self.currentpose) {
                case #"hash_c6775c88e38f7803":
                  interactions = ["\x88y\xb0m\xd4\xb2\x05\xadm\x12\x12\x9dl\xb0V\xa4\xe8G\x86\xed\xd3\xc3>\x1f\x019rUcfq\xcc\xa4p\xb09t", "\x1e\x15\x05TE\xf7\x02m\x0ecg\x14T\xc5\xab\xce\xaf1\xf7t\x80v1\x8f\xdf\xd2\xd7 \xd7V\x9b\x8e\xbe\x82\x86aA"];
                  break;
                case #"hash_3fed0cbd303639eb":
                  interactions = ["</\xcd\xcc\xe4\xaf$\xb2\xf4\x0f\xcf\xefMWYY\xad\xe4\xa4Eq\xa7\x1a\xde\xbd\x86\xf6\x06t\v\x9bE\n\xdb\xe9~\xaf\xa8", "\xfa\x10Ms\xb9X\xd6\xc6[r=\xf2\xf7\x12\x9d\xab\x8d\x8c\xc3\xb6=v:\xa1\xd5\a\r\xbc\x11\vD\xbe\xfd0b\xf3~["];
                  break;
                case #"hash_d91940431ed7c605":
                  break;
              }

              break;
            case #"hash_cd3ffe799551db82":
              switch (self.currentpose) {
                case #"hash_c6775c88e38f7803":
                  interactions = ["\bS\xe7\x94\xa5\x83\x01:\xffc\xcd~\xd2\xa7\xbc\xfct\x03K%\xe5\b\xb8=x\x03\xa8\xf6\xcb\xb7\xb6\xd5\xec\xef\xcc\xc2\x11\xef", "\xbc0\xf9{\xe8*\xd6\xc1\xf9\xfc:=\xf7\x8f\x8bU\xf2\x12K\xd9~\b\xa6\xf3\xd9*\xe4\x86|\xfd\x03\xb4\xe4\xb0\x93\xa44\xe7"];
                  break;
                case #"hash_3fed0cbd303639eb":
                  interactions = ["\xc5\x0f\x7f\xa7\xd4Z\xc7\xbd\x90\x04=}t\x87*\xdf\x87\xefZ\xc3\xf3\x8c\x91\xa2\xf1\b(\xf7\x01\xe8\xa9`\xc7\xa9\x03\xe4\xe7v\xc7", "\x12{\xd87r\xd0|]\x1a\xd3\x90<\xe7n\x12\xdaJ\x97\x7f\xd9\xb6\xa5\xa7\xe7=T\xfd?n\xcd\xa3t\xeb]\xd6\xf3J \x91"];
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
              interactions = ["\vc\xec\x8aof\x90&%\x14:}\xb7\xec\x15\xc7nM-\x97>"];
              break;
          }

          if(interactions.size > 0) {
            random_pick = randomint(interactions.size);
            random_interaction = interactions[random_pick];
            combat_interaction_process(random_interaction, node);
          } else {
            println("<dev string:x276>" + node.type);
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  interaction = get_interaction(interaction_name);
  thread notetrack::start_notetrack_wait(self, "p2");
  thread _play_interaction_anim_vo_note();

  if(!isDefined(interaction)) {
    assertmsg("<dev string:x97>" + interaction_name + "<dev string:xb2>");
    return;
  }

  self.lookat_anims = interaction.scene;

  if(!isDefined(self.animname)) {
    self.animname = "RF\x9e\xe1\xc4\x1f\xe7";
  }

  var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
  trace_end = undefined;
  tracecontents = trace::create_contents(1, 1, 0, 1, 1, 1);
  trace = undefined;

  if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
    var_b7ad5728319caeda = lengthsquared(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
  } else {
    var_b7ad5728319caeda = lengthsquared(level.player.origin - self.origin);
  }

  if(var_b7ad5728319caeda < squared(self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"]) && is_looking_at_range(self, 0.925)) {
    trace_end = vectorNormalize(level.player getEye() - self getEye()) * self.lookat_anims["\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I"] + self getEye();
    trace = trace::ray_trace(self getEye(), trace_end, self, tracecontents);

    if(isPlayer(trace["\x1f\xa8\x10WP\xa9"])) {
      combat_interaction_run();
    }
  }
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function combat_interaction_run() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  self.is_playing_reaction = 1;
  self notify("\x19\xee%c\xc4\x8a\xad\xe8T\x82\xffR=\xda\x06\xcd$tAC^\x85\xbe\xd9\xc9");
  level notify("\xc4=x\xbe\xeae\x10\xf3\x05\x94O\x87\x1e\x9b$?\xfd\xc3/");
  starting_anim = self.combat_reaction_previous_anim;
  var_3a0109b661e8a1a7 = undefined;

  if(isDefined(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"])) {
    var_3a0109b661e8a1a7 = vectortoangles(self.lookat_anims["\xb6\xeb\xa1\xcf\xf5\xbe^\xb6g{\xd3V8\xb3\xb2\x16\nX\xe6\xe3"] - self.origin);
  } else {
    var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
  }

  angle = abs(angleclamp((var_3a0109b661e8a1a7 - self.angles)[1]) - 360);
  println("<dev string:x25b>" + angle);
  reaction_anim = self.lookat_anims["Q\x01\xbe\xad\xe3\x1e\x0e\xba"];

  if(isDefined(self.lookat_anims["\xc5\x94\x82H\x9a`"])) {
    foreach(reaction_angle in self.lookat_anims["\xc5\x94\x82H\x9a`"]) {
      if(angle <= reaction_angle) {
        reaction_anim = self.lookat_anims[reaction_angle];
        break;
      }
    }
  }

  if(isarray(reaction_anim)) {
    if(isarray(reaction_anim[0])) {
      var_6168817ba6e28cbc = self.anim_sequential_counter;
      var_86adefa702820ffc = reaction_anim[0][var_6168817ba6e28cbc][0];
    } else {
      var_86adefa702820ffc = reaction_anim[0];
    }
  } else {
    var_86adefa702820ffc = reaction_anim;
  }

  start_fakeactor_notetracks(var_86adefa702820ffc);
  self setanimlimited(%\xb7\x1bs\xf8, 0, 0.25, 1);
  self setflaggedanimknoball("p2", var_86adefa702820ffc, %\xb7\x1bs\xf8, 1, 0.25, 1);
  wait getanimlength(var_86adefa702820ffc);
  self clearanim(%\xb86gH\x1e;\xcfE, 0.25);
  self setanimlimited(%\xb7\x1bs\xf8, 1, 0.25, 1);
  self.is_playing_reaction = 0;
  wait 0.25;
  self notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  level notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  thread interaction_end();
}

function combat_reaction_wait_buffer(node) {
  node.combat_reaction_wait = 1;
  wait 2;
  node.combat_reaction_wait = undefined;
}

function new_goal_listener() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x90\xd8s\xf2\x1a\xa3\xec\xe6N\xf8T<\x1a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  var_7771d3c15bada575 = undefined;

  if(isDefined(self.last_set_goalnode)) {
    var_7771d3c15bada575 = self.last_set_goalnode.origin;

    while(isDefined(self.last_set_goalnode) && self.last_set_goalnode.origin == var_7771d3c15bada575) {
      waitframe();
    }
  } else if(isDefined(self.last_set_goalent)) {
    var_7771d3c15bada575 = self.last_set_goalent.origin;

    while(isDefined(self.last_set_goalent) && self.last_set_goalent.origin == var_7771d3c15bada575) {
      waitframe();
    }
  } else if(isDefined(self.last_set_goalpos)) {
    var_7771d3c15bada575 = self.last_set_goalpos;

    while(isDefined(self.last_set_goalpos) && self.last_set_goalpos == var_7771d3c15bada575) {
      waitframe();
    }
  }

  self notify("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  thread interaction_end();
}

function interaction_pain_listener() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8e2s\x9b\xf1kX.\x14a%\xa1\x19C6\x96");
  self.interaction_pain = undefined;

  while(true) {
    self.interaction_pain = undefined;
    self waittill("\x80\xb5\xc7J");
    self.interaction_pain = 1;
    wait 5;
  }
}

function interaction_set_anim_movement(movement) {
  if(!isDefined(movement)) {
    movement = "\x04M\xed\xab";
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

  thread notetrack::start_notetrack_wait(self, "\xb3\\\x97b@19[\x9e\xc1\xd7", anime, undefined, animation);
  thread anim_sp::animscriptdonotetracksthread(self, "\xb3\\\x97b@19[\x9e\xc1\xd7", anime);
}
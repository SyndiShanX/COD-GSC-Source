/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\interaction.gsc
***********************************************/

function register_interaction(var0, var1) {
  level.interactions[var0] = var1;
}

function register_state_interaction(var0, var1) {
  level.state_interactions[var0] = var1;
}

function get_interaction(var0) {
  if(!isDefined(level.interactions) || !isDefined(level.interactions[var0])) {
    return undefined;
  }

  return level.interactions[var0];
}

function get_state_interaction(var0) {
  if(!issubstr(var0, "casual") && !issubstr(var0, "alert")) {
    if(isDefined(self.asm)) {
      var1 = scripts\asm\asm::asm_getdemeanor();

      if(var1 == "casual") {
        var0 = var0 + "_" + var1;
      } else {
        var0 += "_alert";
      }
    } else {
      var0 += "_casual";
    }
  }

  if(!isDefined(level.state_interactions) || !isDefined(level.state_interactions[var0])) {
    return undefined;
  }

  return level.state_interactions[var0];
}

function is_interaction(var0) {
  return isDefined(level.interactions) && isDefined(level.interactions[var0]);
}

function is_state_interaction(var0) {
  return isDefined(level.state_interactions) && isDefined(level.state_interactions[var0 + "_casual"]);
}

function is_state_interact_struct(var0) {
  if(isDefined(var0.script_reaction) && is_state_interaction(var0.script_reaction)) {
    return true;
  }

  return false;
}

function is_interact_struct(var0) {
  if(isDefined(var0.script_reaction) && is_interaction(var0.script_reaction)) {
    return true;
  }

  if(isDefined(var0.script_noteworthy) && is_interaction(var0.script_noteworthy)) {
    return true;
  }

  return false;
}

function is_interact_node(var0) {
  if(isDefined(var0.script_reaction)) {
    if(is_interaction(var0.script_reaction) || var0.script_reaction == "combat_reaction") {
      return true;
    }
  }

  return false;
}

function get_arrivalstate_from_interaction(var0) {
  var1 = scripts\asm\asm::asm_getdemeanor();

  if(isDefined(var0.arrivalstates)) {
    return var0.arrivalstates[var1];
  }

  return undefined;
}

function get_exitstate_from_interaction(var0) {
  var1 = scripts\asm\asm::asm_getdemeanor();

  if(isDefined(var0.exitstates)) {
    return var0.exitstates[var1];
  }

  return undefined;
}

function get_idlestate_from_interaction(var0) {
  var1 = scripts\asm\asm::asm_getdemeanor();
  return var0.idlestate;
}

function setup_exit_states_for_interaction(var0) {
  if(!isai(self)) {
    return;
  }

  self.asm.customdata.interaction = var0;
  var1 = get_interaction(var0);

  if(!isDefined(var1)) {
    var1 = get_state_interaction(var0);
  }

  self.asm.customdata.exitstate = get_exitstate_from_interaction(var1);
}

function play_interaction_anim(var0, var1, var2, var3, var4) {
  var0 = get_interaction(var0);

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 0.05;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  start_fakeactor_notetracks(var0.scene[var1]);
  self setflaggedanim(var1, var0.scene[var1], var2, var3, var4);
}

function define_interacton_position(var0) {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var1 = undefined;

  for(;;) {
    if(isstruct(var0) || isent(var0)) {
      var1 = var0.origin;
    } else if(isvector(var0)) {
      var1 = var0;
    }

    if(isDefined(self.lookat_anims)) {
      self.lookat_anims["interaction_position"] = var1;
    }

    waitframe();
  }
}

function redefine_interaction_radius(var0) {
  var1 = undefined;

  if(isDefined(self.lookat_anims)) {
    var1 = self.lookat_anims["trigger_radius"];
    self.lookat_anims["trigger_radius"] = var0;
    thread _redefine_interaction_radius_cleanup(var1);
    return;
  }
}

function _redefine_interaction_radius_cleanup(var0) {
  self endon("interaction_end");
  self endon("reaction_end");
  self waittill("interaction_done");
  self.lookat_anims["trigger_radius"] = var0;
}

function play_interaction(var0, var1, var2) {
  self endon("death");
  self notify("reaction_end");
  var3 = get_interaction(var0);
  setup_exit_states_for_interaction(var0);

  if(!isDefined(var3)) {
    return;
  }

  self.lookat_anims = var3.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var0;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    scripts\sp\interaction_manager::add_actor_to_manager();
    level.interaction_manager.data["registered_interactions"][var0] = [];

    if(isDefined(var3.scene["vo_lines_male"])) {
      level.interaction_manager.data["registered_interactions"][var0]["vo_lines_male"] = var3.scene["vo_lines_male"];
    }

    if(isDefined(var3.scene["vo_lines_female"])) {
      level.interaction_manager.data["registered_interactions"][var0]["vo_lines_female"] = var3.scene["vo_lines_female"];
    }
  }

  if(isDefined(var1)) {
    var4 = undefined;

    if(isarray(self.lookat_anims["idle"])) {
      var5 = self.lookat_anims["idle"][0];
    } else {
      var5 = self.lookat_anims["idle"];
    }

    if(isstring(var2)) {
      var5 = scripts\engine\utility::getStruct(var2, "targetname");
    } else if(isstruct(var2)) {
      var5 = var2;
    } else if(isent(var2)) {
      var5 = var2;
    } else {
      return;
    }

    var6 = var5;
    var7 = getstartorigin(var5.origin, var5.angles, var6);
    var8 = getstartangles(var5.origin, var5.angles, var6);

    if(!isDefined(self.is_cheap)) {
      self forceteleport(var7, var8);
    } else {
      self.origin = var7;
      self.angles = var8;
    }

    if(!isDefined(self.is_cheap)) {
      self animmode("noclip");
    }

    self.optional_struct = var5;
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
    if(!isDefined(var3)) {
      thread interaction_process();
      thread interaction_end_cheap();
    } else {
      thread interaction_follow_process();
      thread interaction_end_cheap();
    }
  } else if(!isDefined(var3)) {
    scripts\asm\asm_sp::asm_animcustom(&interaction_process, &interaction_end);
  } else {
    scripts\asm\asm_sp::asm_animcustom(&interaction_follow_process, &interaction_end);
  }

  self waittill("reaction_end");
}

function play_smart_interaction(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("death");
  self endon("stop_smart_reaction");
  setup_interaction_head();
  var8 = get_interaction(var0).scene["trigger_radius"] * 2;
  thread scripts\sp\interaction_manager::reaction_look_distance_based(var8);
  play_interaction_unknowntype(var0, var5, var1, var7);
  self waittill("interaction_done");
  thread scripts\engine\sp\utility::gesture_stop(0.7);
  self notify("stop_reaction_look");
  waittill_playeroutsideradius(var6);
  play_looping_acknowlegdements(var2, var6);
}

#using_animtree("");

function setup_interaction_head() {
  self.headknob = % head;
  self.scriptedtalkingknob = $scripted_talking;
  self.defaulttalk = % generic_talker_allies;
}

function play_interaction_unknowntype(var0, var1, var2, var3) {
  if(issubstr(var0, "blended")) {
    thread play_interaction_blended(var0, var1);
  } else {
    thread play_interaction(var0, var1);
  }

  queue_interaction_vo(var2, var3);
}

function queue_interaction_vo(var0, var1) {
  if(!isDefined(var1)) {
    thread play_note_anim_vo(var0);
    return;
  }

  self waittill("playing_interaction_scene");
  scripts\engine\utility::delaythread(var1, &scripts\sp\interaction_manager::play_smart_dialog_if_exists, var0);
}

function play_smart_simple_interaction(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  thread play_interaction_simple(var0, var5);
  scripts\sp\interaction_manager::play_gesture_reaction(85, 50, var1, var3, var4);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var6);
  var7 = create_interaction_linebook(var2);

  for(;;) {
    var8 = get_interaction_vo_line(var7);
    scripts\sp\interaction_manager::play_gesture_reaction(85, 50, var8, var3, var4);
    waittill_playeroutsideradius(var6);
  }
}

function play_smart_basic_interaction(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  play_single_acknowledgement(var0);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var4);
  play_looping_acknowlegdements(var1, var4);
}

function play_smart_silent_interaction(var0) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  play_single_acknowledgement(undefined);
  waittill_playeroutsideradius(var0);
  play_looping_acknowlegdements(undefined, var0);
}

function play_smart_simple_silent_interaction(var0, var1, var2) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.headknob = % head;
  self.scriptedtalkingknob = % scripted_talking;
  self.defaulttalk = % generic_talker_allies;
  thread play_interaction_simple(var0, var1);
  scripts\sp\interaction_manager::play_gesture_reaction(85, 50);
  self notify("first_acknowledgement_done");
  waittill_playeroutsideradius(var2);
  play_looping_acknowlegdements(undefined, var2);
}

function play_single_acknowledgement(var0) {
  self endon("stop_smart_reaction");
  var1 = 110;
  var2 = 85;
  scripts\sp\interaction_manager::play_gesture_reaction(var1, var2, var0);
}

function play_looping_acknowlegdements(var0, var1) {
  self endon("death");
  self endon("stop_smart_reaction");

  if(!isDefined(var1)) {
    var1 = 300;
  }

  if(isDefined(var0)) {
    var2 = create_interaction_linebook(var0);

    for(;;) {
      var3 = get_interaction_vo_line(var2);
      play_single_acknowledgement(var3);
      waittill_playeroutsideradius(var1);
    }

    return;
  }

  for(;;) {
    play_single_acknowledgement();
    waittill_playeroutsideradius(var1);
  }
}

function play_silent_acknowledgement() {
  var0 = 110;
  var1 = 85;
  scripts\sp\interaction_manager::play_gesture_reaction(var0, var1);
}

function waittill_playeroutsideradius(var0) {
  if(!isDefined(var0)) {
    var0 = 256;
  }

  for(;;) {
    if(distance2d(self.origin, level.player.origin) >= var0) {
      break;
    }

    waitframe();
  }
}

function create_interaction_linebook(var0) {
  if(!isarray(var0) && !isstruct(var0) && !isstring(var0) && !isvector(var0) && !var0) {
    return undefined;
  }

  var1 = spawnStruct();
  var1.base = var0;
  var1.available = var0;
  var1.used = [];
  return var1;
}

function reset_interaction_linebook() {
  self.used = [];
  self.available = self.base;
}

function get_interaction_vo_line() {
  var0 = undefined;

  if(isDefined(self.available)) {
    if(self.available.size <= 0) {
      reset_interaction_linebook();
    }

    var0 = self.available[randomint(self.available.size)];
    self.used = scripts\engine\utility::array_add(self.used, var0);
    self.available = scripts\engine\utility::array_remove(self.available, var0);
    return var0;
  }
}

function play_smart_basic_group_interaction(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    var5 endon("death");
    var5 endon("stop_smart_reaction");
    var5.headknob = % head;
    var5.scriptedtalkingknob = % scripted_talking;
    var5.defaulttalk = % generic_talker_allies;
  }

  if(var0.size != var1.size || var0.size != var2.size) {
    return;
  }

  play_group_acknowledgement(var0, var1);
  var7 = scripts\sp\interaction_manager::create_middle_ent(var0);
  waittill_playeroutsideradius(var7, var3);
  play_group_looping_acknowledgements(var0, var2, var3);
}

function play_group_acknowledgement(var0, var1) {
  var2 = 110;
  var3 = 85;
  scripts\sp\interaction_manager::play_group_gesture_reaction(var0, var2, var3, var1);
}

function play_group_looping_acknowledgements(var0, var1, var2) {
  foreach(var4 in var0) {
    var4 endon("death");
    var4 endon("stop_smart_reaction");
  }

  var6 = create_group_interaction_linebook(var1);
  var7 = scripts\sp\interaction_manager::create_middle_ent(var0);

  for(;;) {
    var8 = get_interaction_vo_line_array(var6);
    play_group_acknowledgement(var0, var8);
    waittill_playeroutsideradius(var7, var2);
  }
}

function create_group_interaction_linebook(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 = create_interaction_linebook(var0[var2]);
  }

  return var1;
}

function get_interaction_vo_line_array(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 = get_interaction_vo_line(var0[var2]);
  }

  return var1;
}

function play_interaction_with_states(var0, var1, var2) {
  self endon("death");
  self notify("reaction_end");
  var3 = get_state_interaction(var0);
  setup_exit_states_for_interaction(var0);

  if(!isDefined(var3)) {
    return;
  }

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var0;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    scripts\sp\interaction_manager::add_actor_to_manager();
  }

  if(isDefined(var1)) {
    var4 = undefined;

    if(isarray(var3.scene["idle"])) {
      var5 = var3.scene["idle"][0];
    } else {
      var5 = var4.scene["idle"];
    }

    if(isstring(var2)) {
      var5 = scripts\engine\utility::getStruct(var2, "targetname");
    } else if(isstruct(var2)) {
      var5 = var2;
    } else if(isent(var2)) {
      var5 = var2;
    } else {
      return;
    }

    var6 = var5;
    var7 = getstartorigin(var5.origin, var5.angles, var6);
    var8 = getstartangles(var5.origin, var5.angles, var6);

    if(!isDefined(self.is_cheap)) {
      self forceteleport(var7, var8);
    } else {
      self.origin = var7;
      self.angles = var8;
    }

    if(!isDefined(self.is_cheap)) {
      self animmode("noclip");
    }

    self.optional_struct = var5;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(var4.scene["no_gun"])) {
    if(!isDefined(self.is_cheap) && !nullweapon(self.weapon)) {
      scripts\common\ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    thread interaction_process_for_states();
    thread interaction_end_cheap();
  } else {
    scripts\asm\asm_sp::asm_animcustom(&interaction_process_for_states, &scripts\sp\interaction_manager::stop_state_based_interaction);
  }

  self waittill("reaction_end");
}

function play_interaction_simple(var0, var1, var2) {
  self endon("death");
  self endon("reaction_end");
  var3 = get_interaction(var0);

  if(!isDefined(var3)) {
    return;
  }

  self.lookat_anims = var3.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var0;
  self.reaction_stop_anims = 1;
  self.optional_struct = undefined;
  self.optional_prop = undefined;

  if(!isDefined(self.allow_interactions)) {
    self.allow_interactions = 1;
  }

  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);
  }

  if(isDefined(var2)) {
    self.optional_prop = var2;
  }

  if(isDefined(var1)) {
    var4 = undefined;

    if(isarray(self.lookat_anims["idle"])) {
      var5 = self.lookat_anims["idle"][0];
    } else {
      var5 = self.lookat_anims["idle"];
    }

    if(isstring(var2)) {
      var5 = scripts\engine\utility::getStruct(var2, "targetname");
    } else if(isstruct(var2)) {
      var5 = var2;
    } else if(isent(var2)) {
      var5 = var2;
    } else {
      return;
    }

    var6 = var5;
    var7 = getstartorigin(var5.origin, var5.angles, var6);
    var8 = getstartangles(var5.origin, var5.angles, var6);
    self.optional_struct = var2;
  }

  if(!isDefined(self.is_cheap)) {
    self animmode("noclip");
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap) && !nullweapon(self.weapon)) {
      scripts\common\ai::gun_remove();
    }
  }

  if(isDefined(self.is_cheap)) {
    thread simple_interaction_idles();
    thread interaction_end_cheap();
  } else {
    scripts\asm\asm_sp::asm_animcustom(&simple_interaction_idles, &interaction_end);
  }

  self waittill("reaction_end");
}

function play_interaction_blended(var0, var1) {
  self endon("death");
  self notify("reaction_end");
  var2 = get_interaction(var0);

  if(!isDefined(var2)) {
    return;
  }

  reset_actor_interaction_values(var2, var0);
  add_actor_tointeractionmanager();
  move_actor_tointeractionposition(var1);
  run_blended_interaction();
}

function reset_actor_interaction_values(var0, var1) {
  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.lookat_anims = var0.scene;
  self.anim_sequential_counter = 0;
  self.scene_sequential_sounter = 0;
  self.sequential_scene = 0;
  self.skip_interaction = 0;
  self.is_playing_reaction = 0;
  self.nearby_interaction_running = 0;
  self.interaction_name = var1;
  self.reaction_stop_anims = 1;

  if(!isDefined(self.allow_interactions) || isDefined(self.allow_interactions) && !self.allow_interactions) {
    self.allow_interactions = 1;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap)) {
      scripts\common\ai::gun_remove();
      return;
    }

    return;
  }
}

function add_actor_tointeractionmanager() {
  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);
    return;
  }
}

function get_interaction_actor_lookatidle() {
  if(isarray(self.lookat_anims["idle"])) {
    return self.lookat_anims["idle"][0];
  }

  return self.lookat_anims["idle"];
}

function get_interaction_actor_optionalstruct(var0) {
  var1 = undefined;

  if(isstring(var0)) {
    var1 = scripts\engine\utility::getStruct(var0, "targetname");
  } else if(isstruct(var0)) {
    var1 = var0;
  } else if(isent(var0)) {
    var1 = var0;
  }

  return var1;
}

function move_actor_tointeractionposition(var0) {
  if(isDefined(var0)) {
    var1 = get_interaction_actor_lookatidle();
    var2 = get_interaction_actor_optionalstruct(var0);

    if(!isDefined(var2)) {
      return;
    }

    self.optional_scripted_struct = var0;
    var3 = getstartorigin(var2.origin, var2.angles, var1);
    var4 = getstartangles(var2.origin, var2.angles, var1);
    teleport_interaction_actor(var3, var4);

    if(!isDefined(self.is_cheap)) {
      self animmode("noclip");
      return;
    }

    return;
  }
}

function teleport_interaction_actor(var0, var1) {
  if(isDefined(self.is_cheap)) {
    self.origin = var0;
    self.angles = var1;
    return;
  }

  self forceteleport(var0, var1);
}

function run_blended_interaction() {
  if(isDefined(self.is_cheap)) {
    thread interaction_process_blended();
    thread interaction_end_cheap();
  } else {
    scripts\asm\asm_sp::asm_animcustom(&interaction_process_blended, &interaction_end);
  }

  self waittill("reaction_end");
}

function play_interaction_immediate(var0, var1) {
  self endon("death");
  var2 = get_interaction(var0);

  if(!isDefined(var2)) {
    return;
  }

  self.lookat_anims = var2.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  self.interaction_name = var0;
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
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);
  }

  if(isDefined(var1)) {
    var3 = undefined;
    var4 = self.lookat_anims["lastanim"];

    if(isstring(var1)) {
      var3 = scripts\engine\utility::getStruct(var1, "targetname");
    } else if(isstruct(var1)) {
      var3 = var1;
    } else {
      return;
    }

    self.lookat_anims["optional_struct"] = var3;
  }

  if(!isDefined(self.anim_info)) {
    self.anim_info = spawnStruct();
  }

  if(isDefined(self.lookat_anims["no_gun"])) {
    if(!isDefined(self.is_cheap)) {
      scripts\common\ai::gun_remove();
    }
  }

  thread scripts\asm\asm_sp::asm_animcustom(&interaction_immediate_process);
  self waittill("interaction_done");
}

function clear_root() {
  self clearanim(%body, 0.2);
}

function is_looking_at_range(var0, var1) {
  var2 = anglesToForward(level.player.angles);
  var3 = vectorNormalize(var0.origin - level.player.origin);
  var4 = vectordot(var2, var3);

  if(var4 >= var1) {
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

  var0 = self.lookat_anims["optional_struct"];
  var1 = "single anim";

  if(!scripts\engine\utility::ent_flag_exist("interaction_end")) {
    scripts\engine\utility::ent_flag_init("interaction_end");
  }

  scripts\engine\utility::ent_flag_clear("interaction_end");
  var2 = 0.25;
  var3 = 0.25;

  if(isDefined(self.lookat_anims["common_name"])) {
    thread scripts\sp\interaction_manager::trigger_interaction_common();
  }

  if(!self.nearby_interaction_running) {
    self.is_playing_reaction = 1;
    self notify("playing_interaction");
    var4 = undefined;

    if(isDefined(self.lookat_anims["interaction_position"])) {
      var4 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    } else {
      var4 = vectortoangles(level.player.origin - self.origin);
    }

    var5 = abs(angleclamp((var4 - self.angles)[1]) - 360);
    var6 = scripts\engine\math::normalize_value(0, 360, var5);
    var7 = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"])) {
      foreach(var9 in self.lookat_anims["angles"]) {
        if(var5 <= var9) {
          var7 = self.lookat_anims[var9];
          break;
        }
      }
    }

    if(isDefined(var0)) {
      var11 = getstartorigin(var0.origin, var0.angles, var7);
      var12 = getstartangles(var0.origin, var0.angles, var7);
      self forceteleport(var11, var12);
    }

    start_fakeactor_notetracks(var7);
    self setflaggedanim(var1, var7, 1, var2);
    var13 = getanimlength(var7);
    wait var13;
    self clearanim(var7, var3);
    level notify("interaction_done");
    self notify("interaction_done");
    return;
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

  var0 = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["idle"])) {
    var0 = self.lookat_anims["idle"][0];
    thread random_idle_controller();
  } else {
    var0 = self.lookat_anims["idle"];
  }

  start_fakeactor_notetracks(var0);
  self setflaggedanim("idle", var0, 1, 0.5, 1);
  thread interaction_set_anim_movement("stop");
  var1 = "single anim";

  if(!scripts\engine\utility::ent_flag_exist("scene_end")) {
    scripts\engine\utility::ent_flag_init("scene_end");
  }

  scripts\engine\utility::ent_flag_clear("scene_end");

  if(!scripts\engine\utility::ent_flag_exist("playing_interaction")) {
    scripts\engine\utility::ent_flag_init("playing_interaction");
  }

  scripts\engine\utility::ent_flag_clear("playing_interaction");
  var2 = 0.11;
  var3 = 0.25;
  var4 = 0.25;
  var5 = 350;
  var6 = 0.45;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;

  if(isDefined(self.lookat_anims["reacquire_left"]) || isDefined(self.lookat_anims["reacquire_right"])) {
    var7 = 1;
  }

  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);

  for(;;) {
    if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
      if(self.sequential_scene) {
        self.skip_interaction = 1;
      } else {
        self.skip_interaction = 0;
      }
    } else {
      self.skip_interaction = 0;
    }

    var10 = lengthsquared(level.player.origin - self.origin);
    var11 = undefined;
    var12 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
    var13 = undefined;

    for(;;) {
      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2)) {
        if(isDefined(self.lookat_anims["interaction_position"])) {
          var10 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
        } else {
          var10 = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        } else if(self.lookat_anims["trigger_radius"] > 0 && var10 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          var14 = self.origin + anglestoup(self.angles) * 66;
          var11 = vectorNormalize(level.player getEye() - var14) * self.lookat_anims["trigger_radius"] + var14;
          var13 = scripts\engine\trace::ray_trace(var14, var11, self, var12);

          if(isPlayer(var13["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
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
    var13 = undefined;

    if(isDefined(self.lookat_anims["interaction_position"])) {
      var13 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    } else {
      var13 = vectortoangles(level.player.origin - self.origin);
    }

    var15 = abs(angleclamp((var13 - self.angles)[1]) - 360);
    var16 = scripts\engine\math::normalize_value(0, 360, var15);

    if(isDefined(self.lookat_anims["backseam"])) {
      if(var16 >= 0 && var16 <= 0.5) {
        var16 += 0.5;
      } else {
        var16 -= 0.5;
      }
    }

    var17 = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"]) && !self.sequential_scene) {
      foreach(var20 in self.lookat_anims["angles"]) {
        if(var15 <= var20) {
          var17 = self.lookat_anims[var20];
          break;
        }
      }
    }

    if(isarray(var17)) {
      if(isarray(var17[0])) {
        var22 = self.anim_sequential_counter;
        var18 = var17[0][var22][0];
      } else {
        var18 = var17[0];
      }
    } else {
      var18 = var17;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var18);
      self setflaggedanimknob(var0, var18, 1, var2, 1);
      self.is_playing_reaction = 1;
    }

    if(!self.skip_interaction) {
      if(isarray(var17)) {
        if(isarray(var17[0]) && !isarray(self.lookat_anims["diff"])) {
          var22 = self.anim_sequential_counter;
          var24 = var17[0][var22];
          thread set_sequential_wait_time(var24);
          thread play_anim_vo_sequential(var24);
        } else if(var17.size > 1) {
          thread play_anim_vo_sequential(var17);
        }
      }
    }

    if(isDefined(self.lookat_anims["reaction_func"])) {
      self thread[[self.lookat_anims["reaction_func"]]]();
    }

    var23 = getanimlength(var18);
    var23 -= var3;

    if(var23 < 0) {
      var23 = 0;
    }

    if(!self.skip_interaction) {
      wait var23;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(self.lookat_anims["follow"]);
      self setflaggedanimlimited(var0, self.lookat_anims["follow"], 1, 0.25, 1);
      self setanimtime(self.lookat_anims["follow"], var16);
      self setanimknob(self.lookat_anims["ring"], 1, var3, 1);
    }

    var25 = undefined;

    if(isarray(self.lookat_anims["diff"])) {
      var22 = self.anim_sequential_counter;
      var25 = self.lookat_anims["diff"][var22];
    } else {
      var25 = self.lookat_anims["diff"];
    }

    start_fakeactor_notetracks(var25);
    self setflaggedanimlimited(var0, var25, 1, 0.25, 1);
    self.is_playing_reaction = 1;

    if(!self.skip_interaction) {
      self setanimlimited(self.lookat_anims["additive"], 1, var3, 1);
    }

    scripts\engine\utility::delaythread(getanimlength(var25), &scripts\engine\utility::ent_flag_set, "scene_end");
    scripts\engine\utility::ent_flag_set("playing_interaction");
    thread scripts\engine\utility::ent_flag_clear_delayed("playing_interaction", getanimlength(var25));
    var26 = var16;

    for(;;) {
      var27 = distance2d(level.player.origin, self.origin);

      if((var27 >= var4 || scripts\engine\utility::ent_flag("scene_end")) && !isDefined(var6)) {
        var9 = lengthsquared(level.player.origin - self.origin);

        if(var9 < squared(self.lookat_anims["trigger_radius"])) {
          var14 = self.origin + anglestoup(self.angles) * 66;
          var10 = vectorNormalize(level.player getEye() - var14) * self.lookat_anims["trigger_radius"] + var14;
          var12 = scripts\engine\trace::ray_trace(var14, var10, self, var11);

          if(isPlayer(var12["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
            if(isarray(self.lookat_anims["diff"]) && self.anim_sequential_counter < self.lookat_anims["diff"].size - 1) {
              self.sequential_scene = 1;
              scripts\engine\utility::ent_flag_clear("scene_end");
              self.anim_sequential_counter += 1;
              self clearanim(var25, 0.15);
              self.is_playing_reaction = 0;
              break;
            }
          }
        }

        if(isDefined(self.lookat_anims["exitangles"])) {
          var29 = self.lookat_anims["exitangles_anims"]["lastexitanim"];

          if(isDefined(self.lookat_anims["interaction_position"])) {
            var12 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
          } else {
            var12 = vectortoangles(level.player.origin - self.origin);
          }

          var13 = abs(angleclamp((var12 - self.angles)[1]) - 360);

          foreach(var31 in self.lookat_anims["exitangles"]) {
            if(var13 <= var31) {
              var29 = self.lookat_anims["exitangles_anims"][var31];
              break;
            }
          }

          start_fakeactor_notetracks(var29);
          self setflaggedanimknob( < error > , var29, 1, var4, 1);
          wait getanimlength(var29);

          if(isDefined(self.lookat_anims["end_idle"])) {
            if(isarray(var16[0])) {
              if(self.anim_sequential_counter >= var16[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
                self setflaggedanimknob( < error > , self.lookat_anims["end_idle"], 1, var4, 1);
              } else {
                start_fakeactor_notetracks( < error > );
                self setflaggedanimknob( < error > , < error > , 1, var4, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
              self setflaggedanimknob( < error > , self.lookat_anims["end_idle"], 1, var4, 1);
            }
          } else {
            start_fakeactor_notetracks( < error > );
            self setflaggedanimknob( < error > , < error > , 1, var4, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims["diff"])) {
            if(self.anim_sequential_counter < self.lookat_anims["diff"].size) {
              scripts\engine\utility::ent_flag_clear("scene_end");
              self clearanim(self.lookat_anims["follow"], 0.1);
              self clearanim(self.lookat_anims["ring"], 0.1);
              self.anim_sequential_counter += 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims["diff"].size) {
              self.is_playing_reaction = 0;
              var7 = 1;

              if(!isDefined(self.lookat_anims["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var7 = 1;

            if(!isDefined(self.lookat_anims["allow_multi_use"])) {
              self waittill("forever");
            }
          }

          self.is_playing_reaction = 0;
          break;
        } else {
          if(isDefined(self.lookat_anims["end_idle"])) {
            if(isarray(var16[0])) {
              if(self.anim_sequential_counter >= var16[0].size) {
                start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
                self setflaggedanimknob( < error > , self.lookat_anims["end_idle"], 1, var4, 1);
              } else {
                start_fakeactor_notetracks( < error > );
                self setflaggedanimknob( < error > , < error > , 1, var4, 1);
              }
            } else {
              start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
              self setflaggedanimknob( < error > , self.lookat_anims["end_idle"], 1, var4, 1);
            }
          } else {
            start_fakeactor_notetracks( < error > );
            self setflaggedanimknob( < error > , < error > , 1, var4, 1);
          }

          self.is_playing_reaction = 0;

          if(isarray(self.lookat_anims["diff"])) {
            if(self.anim_sequential_counter < self.lookat_anims["diff"].size) {
              scripts\engine\utility::ent_flag_clear("scene_end");
              self clearanim(self.lookat_anims["follow"], 0.1);
              self clearanim(self.lookat_anims["ring"], 0.1);
              self.anim_sequential_counter += 1;
              self.is_playing_reaction = 0;
            }

            if(self.anim_sequential_counter >= self.lookat_anims["diff"].size) {
              self.is_playing_reaction = 0;
              var7 = 1;

              if(!isDefined(self.lookat_anims["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var7 = 1;

            if(!isDefined(self.lookat_anims["allow_multi_use"])) {
              self waittill("forever");
            }
          }

          self.is_playing_reaction = 0;
          break;
        }
      }

      if(isDefined(self.lookat_anims["interaction_position"])) {
        var12 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var12 = vectortoangles(level.player.origin - self.origin);
      }

      var13 = abs(angleclamp((var12 - self.angles)[1]) - 360);
      var15 = scripts\engine\math::normalize_value(0, 360, var13);

      if(self.followoff) {
        var15 = 0;
      }

      if(isDefined(self.lookat_anims["backseam"])) {
        if(var15 >= 0 && var15 <= 0.5) {
          var15 += 0.5;
        } else {
          var15 -= 0.5;
        }

        var25 += (var15 - var25) * var0;
      } else {
        var25 += (var15 - var25) * var0;
      }

      if(isDefined(var5)) {
        var33 = vectorNormalize(level.player.origin - self.origin);
        var33 = scripts\engine\utility::flatten_vector(var33, anglestoup(self.angles));
        var34 = anglesToForward(self.angles);
        var35 = vectordot(var33, var34);
        var13 = acos(var35);
        var36 = vectorcross(var33, var34);

        if(vectordot(var36, anglestoup(self.angles)) < 0) {
          var13 *= -1;
        }

        var37 = 0;

        if(var13 >= 90 && !var37 && !scripts\engine\utility::ent_flag("playing_interaction")) {
          var37 = 1;
          start_fakeactor_notetracks(self.lookat_anims["reacquire_right"]);
          self clearanim(%body, 0.25);
          self setflaggedanimrestart( < error > , self.lookat_anims["reacquire_right"], 1, 0.25);
          wait clamp(getanimlength(self.lookat_anims["reacquire_right"]) - 0.25, 0, 100);
          self clearanim(self.lookat_anims["reacquire_right"], 0.25);
        } else if(var13 < -90 && !var37 && !scripts\engine\utility::ent_flag("playing_interaction")) {
          var37 = 1;
          start_fakeactor_notetracks(self.lookat_anims["reacquire_left"]);
          self clearanim(%body, 0.25);
          self setflaggedanimrestart( < error > , self.lookat_anims["reacquire_left"], 1, 0.25);
          wait clamp(getanimlength(self.lookat_anims["reacquire_left"]) - 0.25, 0, 100);
          self clearanim(self.lookat_anims["reacquire_left"], 0.25);
        } else {
          set_time_via_rate(self.lookat_anims["follow"], var25);
        }

        if(var37) {
          if(isDefined(self.lookat_anims["interaction_position"])) {
            var12 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
          } else {
            var12 = vectortoangles(level.player.origin - self.origin);
          }

          var13 = abs(angleclamp((var12 - self.angles)[1]) - 360);
          var15 = scripts\engine\math::normalize_value(0, 360, var13);
          start_fakeactor_notetracks(self.lookat_anims["follow"]);
          self setflaggedanimlimited( < error > , self.lookat_anims["follow"], 1, 0.25, 1);
          self setanimtime(self.lookat_anims["follow"], 0.5);
          self setanimknob(self.lookat_anims["ring"], 1, var2, 1);

          if(!scripts\engine\utility::ent_flag("playing_interaction") && !scripts\engine\utility::ent_flag("scene_end")) {
            start_fakeactor_notetracks(self.lookat_anims["diff"]);
            self setflaggedanimlimited( < error > , self.lookat_anims["diff"], 1, 0.05, 1);
          }

          self setanimlimited(self.lookat_anims["additive"], 1, var2, 1);
          var25 = 0.5;
        }
      } else {
        set_time_via_rate(self.lookat_anims["follow"], var25);
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

  var0 = undefined;
  self.random_idle_playing = 0;

  if(isarray(self.lookat_anims["idle"])) {
    var0 = self.lookat_anims["idle"][0];
    thread random_idle_controller();
  } else {
    var0 = self.lookat_anims["idle"];
  }

  start_fakeactor_notetracks(var0);
  self setflaggedanim("idle", var0, 1, 0.05, 1);
  thread interaction_set_anim_movement("stop");
  var1 = "single anim";

  if(!scripts\engine\utility::ent_flag_exist("scene_end")) {
    scripts\engine\utility::ent_flag_init("scene_end");
  }

  scripts\engine\utility::ent_flag_clear("scene_end");
  var2 = 0.11;

  if(isDefined(self.lookat_anims["lookat_lerp"])) {
    var2 = self.lookat_anims["lookat_lerp"];
  }

  var3 = 0.25;

  if(isDefined(self.lookat_anims["initial_reaction_blendtime"])) {
    var3 = self.lookat_anims["initial_reaction_blendtime"];
  }

  var4 = 0.25;

  if(isDefined(self.lookat_anims["lookat_follow_blendtime"])) {
    var4 = self.lookat_anims["lookat_follow_blendtime"];
  }

  var5 = 350;

  if(isDefined(self.lookat_anims["lookat_end_distance"])) {
    var5 = self.lookat_anims["lookat_end_distance"];
  }

  var6 = 0.45;

  if(isDefined(self.lookat_anims["lookat_end_blendtime"])) {
    var6 = self.lookat_anims["lookat_end_blendtime"];
  }

  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);

  for(;;) {
    if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
      if(self.sequential_scene) {
        self.skip_interaction = 1;
      } else {
        self.skip_interaction = 0;
      }
    } else {
      self.skip_interaction = 0;
    }

    var7 = lengthsquared(level.player.origin - self.origin);
    var8 = undefined;
    var9 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
    var10 = undefined;

    for(;;) {
      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2)) {
        if(isDefined(self.lookat_anims["interaction_position"])) {
          var7 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
        } else {
          var7 = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        } else if(self.lookat_anims["trigger_radius"] > 0 && var7 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
          var11 = self.origin + anglestoup(self.angles) * 66;
          var8 = vectorNormalize(level.player getEye() - var11) * self.lookat_anims["trigger_radius"] + var11;
          var10 = scripts\engine\trace::ray_trace(var11, var8, self, var9);

          if(isPlayer(var10["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
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
    var10 = undefined;

    if(isDefined(self.lookat_anims["interaction_position"])) {
      var10 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
    } else {
      var10 = vectortoangles(level.player.origin - self.origin);
    }

    var12 = abs(angleclamp((var10 - self.angles)[1]) - 360);
    var13 = self.lookat_anims["lastanim"];

    if(isDefined(self.lookat_anims["angles"])) {
      foreach(var16 in self.lookat_anims["angles"]) {
        if(var12 <= var16) {
          var13 = self.lookat_anims[var16];
          break;
        }
      }
    }

    if(isarray(var13)) {
      if(isarray(var13[0]) && self.anim_sequential_counter < var13[0].size) {
        var18 = self.anim_sequential_counter;
        var14 = var13[0][var18][0];
      } else {
        var14 = var13[0];
      }
    } else {
      var14 = var13;
    }

    if(!self.skip_interaction) {
      start_fakeactor_notetracks(var14);
      self setflaggedanimknob(var0, var14, 1, var2, 1);
      self.is_playing_reaction = 1;
    }

    level thread scripts\sp\interaction_manager::interaction_cooldown_timer(self);

    if(isDefined(self.lookat_anims["scene"])) {
      if(isDefined(self.lookat_anims["interaction_position"])) {
        var10 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var10 = vectortoangles(level.player.origin - self.origin);
      }

      var12 = abs(angleclamp((var10 - self.angles)[1]) - 360);

      if(self.skip_interaction) {
        wait 0;
      } else {
        wait getanimlength(var14);
      }

      if(isarray(self.lookat_anims["scene"])) {
        var20 = self.scene_sequential_sounter;
        start_fakeactor_notetracks(self.lookat_anims["scene"][var20]);
        self setflaggedanimknob(var0, self.lookat_anims["scene"][var20], 1, var3, 1);
        wait getanimlength(self.lookat_anims["scene"][var20]);
        self.scene_sequential_sounter += 1;
        self.sequential_scene = 1;
      } else {
        start_fakeactor_notetracks(self.lookat_anims["scene"]);
        self setflaggedanimknob(var0, self.lookat_anims["scene"], 1, var3, 1);
        wait getanimlength(self.lookat_anims["scene"]);
      }
    }

    if(isDefined(self.lookat_anims["exitangles"])) {
      if(isDefined(self.lookat_anims["interaction_position"])) {
        var10 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var10 = vectortoangles(level.player.origin - self.origin);
      }

      var12 = abs(angleclamp((var10 - self.angles)[1]) - 360);
      var21 = self.lookat_anims["exitangles_anims"]["lastexitanim"];

      foreach(var23 in self.lookat_anims["exitangles"]) {
        if(var12 <= var23) {
          var21 = self.lookat_anims["exitangles_anims"][var23];
          break;
        }
      }

      start_fakeactor_notetracks(var21);
      self setflaggedanimknob(var0, var21, 1, var5, 1);
      wait getanimlength(var21);

      if(isDefined(self.lookat_anims["end_idle"])) {
        if(isarray(var13[0])) {
          if(self.anim_sequential_counter >= var13[0].size) {
            start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
            self setflaggedanimknob(var0, self.lookat_anims["end_idle"], 1, var5, 1);
          } else {
            start_fakeactor_notetracks( < error > );
            self setflaggedanimknob(var0, < error > , 1, var5, 1);
          }
        } else {
          start_fakeactor_notetracks(self.lookat_anims["end_idle"]);
          self setflaggedanimknob(var0, self.lookat_anims["end_idle"], 1, var5, 1);
        }
      } else {
        start_fakeactor_notetracks( < error > );
        self setflaggedanimknob(var0, < error > , 1, var5, 1);
      }

      self.is_playing_reaction = 0;

      if(!isDefined(self.lookat_anims["allow_multi_use"])) {
        self waittill("forever");
      }
    }

    if(!self.skip_interaction) {
      if(isarray(var13)) {
        if(isarray(var13[0]) && self.anim_sequential_counter < var13[0].size) {
          var18 = self.anim_sequential_counter;
          var25 = var13[0][var18];
          thread set_sequential_wait_time(var25);
          thread play_anim_vo_sequential(var25);
        } else if(var13.size > 1) {
          thread play_anim_vo_sequential(var13);
        }
      }
    }

    if(isDefined(self.lookat_anims["reaction_func"])) {
      self[[self.lookat_anims["reaction_func"]]]();
    }

    var19 = getanimlength(var14);
    wait var19;

    if(isDefined(self.lookat_anims["end_idle"])) {
      if(isarray(var13)) {
        if(isarray(var13[0])) {
          start_fakeactor_notetracks();

          if(self.anim_sequential_counter >= var13[0].size - 1) {
            self setflaggedanimknoball(var0, self.lookat_anims["end_idle"], %body, 1, var5, 1);
          } else {
            self setflaggedanimknoball(var0, < error > , %body, 1, var5, 1);
          }
        } else {
          self setflaggedanimknoball(var0, self.lookat_anims["end_idle"], %body, 1, var5, 1);
        }
      } else {
        start_fakeactor_notetracks();
        self setflaggedanimknoball(var0, self.lookat_anims["end_idle"], %body, 1, var5, 1);
      }
    } else {
      start_fakeactor_notetracks();
      self setflaggedanimknoball(var0, < error > , %body, 1, var5, 1);
    }

    self.anim_sequential_counter += 1;
    level notify("interaction_done");
    self notify("interaction_done");

    if(isarray(var13)) {
      if(isarray(var13[0]) && self.anim_sequential_counter < var13[0].size) {
        var27 = self.sequential_loop_padding + self.sequential_wait_time - getanimlength(var14);
        var28 = self.sequential_loop_padding + self.sequential_wait_time + getanimlength(var14);
        var29 = clamp(var27, 0, var28);
        wait var29;
        self clearanim(var14, 0.1);
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

  var0 = undefined;
  self.random_idle_playing = 0;
  var1 = get_state_interaction(self.interaction_name);

  if(!isDefined(var1)) {
    return;
  }

  var1 = var1.scene;
  var2 = undefined;

  if(isarray(var1["idle"])) {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var2 = "idle_female";
    } else {
      var2 = "idle";
    }

    var0 = var1[var2][0];
    thread random_idle_controller_stateful();
  } else {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var2 = "idle_female";
    } else {
      var2 = "idle";
    }

    var0 = var1[var2];
  }

  var3 = "single anim";
  start_fakeactor_notetracks(var0);
  self setflaggedanim(var3, var0, 1, 0.5, 1);
  self setanimtime(var0, randomfloat(1));
  thread interaction_set_anim_movement("stop");
  thread play_anim_shared_vo();

  if(!scripts\engine\utility::ent_flag_exist("scene_end")) {
    scripts\engine\utility::ent_flag_init("scene_end");
  }

  scripts\engine\utility::ent_flag_clear("scene_end");
  var4 = 0.11;
  var5 = 0.25;
  var6 = 0.25;
  var7 = 350;
  var8 = 0.45;
  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, var1["trigger_radius"], var1["trigger_radius"]);

  for(;;) {
    var9 = lengthsquared(level.player.origin - self.origin);
    var10 = undefined;
    var11 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
    var12 = undefined;

    for(;;) {
      if(!isDefined(self.reaction_state) || isDefined(self.reaction_state) && self.reaction_state != "busy" && self.reaction_state != "nag") {
        if(scripts\sp\interaction_manager::can_play_nearby_interaction(var1["trigger_radius"] * 2)) {
          if(isDefined(var1["interaction_position"])) {
            var9 = lengthsquared(var1["interaction_position"] - self.origin);
          } else {
            var9 = lengthsquared(level.player.origin - self.origin);
          }

          if(isDefined(var1["interaction_trigger_override"])) {
            break;
          } else if(var1["trigger_radius"] > 0 && var9 < squared(var1["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
            var13 = self.origin + anglestoup(self.angles) * 66;
            var10 = vectorNormalize(level.player getEye() - var13) * var1["trigger_radius"] + var13;
            var12 = scripts\engine\trace::ray_trace(var13, var10, self, var11);

            if(isPlayer(var12["entity"]) || isDefined(var1["interaction_trigger_override"])) {
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
    var12 = undefined;

    if(isDefined(var0["interaction_position"])) {
      var12 = vectortoangles(var0["interaction_position"] - self.origin);
    } else {
      var12 = vectortoangles(level.player.origin - self.origin);
    }

    var14 = abs(angleclamp((var12 - self.angles)[1]) - 360);
    var15 = "lastanim";

    if(isDefined(var0["angles"])) {
      foreach(var18 in var0["angles"]) {
        if(var14 <= var18) {
          var15 = var18;
          break;
        }
      }
    }

    if(level.state_interactions[self.interaction_name].scene[var15].size < 1) {
      level.state_interactions[self.interaction_name].scene[var15] = level.state_interactions[self.interaction_name].scene["angle_" + scripts\engine\utility::string(var15) + "_spent"];
      level.state_interactions[self.interaction_name].scene["angle_" + var15 + "_spent"] = [];
    }

    var16 = randomint(level.state_interactions[self.interaction_name].scene[var15].size);
    var20 = level.state_interactions[self.interaction_name].scene[var15][var16];
    start_fakeactor_notetracks(var20);
    self setflaggedanimknob(var2, var20, 1, var4, 1);
    self.is_playing_reaction = 1;
    thread scripts\sp\interaction_manager::interaction_reboot_timer();
    wait getanimlength(var20);
    level.state_interactions[self.interaction_name].scene["angle_" + var15 + "_spent"] = scripts\engine\utility::array_add(level.state_interactions[self.interaction_name].scene["angle_" + var15 + "_spent"], var20);
    level.state_interactions[self.interaction_name].scene[var15] = scripts\engine\utility::array_remove(level.state_interactions[self.interaction_name].scene[var15], var20);

    if(isDefined(var0["exitangles"])) {
      if(isDefined(var0["interaction_position"])) {
        var12 = vectortoangles(var0["interaction_position"] - self.origin);
      } else {
        var12 = vectortoangles(level.player.origin - self.origin);
      }

      var14 = abs(angleclamp((var12 - self.angles)[1]) - 360);
      var22 = "lastexitanim";

      foreach(var24 in var0["exitangles"]) {
        if(var14 <= var24) {
          var22 = var24;
          break;
        }
      }

      if(level.state_interactions[self.interaction_name].scene[var22].size < 1) {
        level.state_interactions[self.interaction_name].scene[var22][var22] = level.state_interactions[self.interaction_name].scene[var22]["exit_angle_" + scripts\engine\utility::string(var22) + "_spent"];
        level.state_interactions[self.interaction_name].scene[var22]["exit_angle_" + scripts\engine\utility::string(var22) + "_spent"] = [];
      }

      var16 = randomint(level.state_interactions[self.interaction_name].scene[var22].size);
      var26 = level.state_interactions[self.interaction_name].scene[var22][var16];
      start_fakeactor_notetracks(var26);
      self setflaggedanimknob(var2, var26, 1, var7, 1);
      wait getanimlength(var26);
      level.state_interactions[self.interaction_name].scene[var22] = scripts\engine\utility::array_remove(level.state_interactions[self.interaction_name].scene[var22], var26);
    }

    start_fakeactor_notetracks( < error > );
    self setflaggedanimknob(var2, < error > , 1, var7, 1);
    self.is_playing_reaction = 0;

    if(isDefined(var0["reaction_func"])) {
      self[[var0["reaction_func"]]]();
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
  var0 = 0.11;
  var1 = 0.25;
  var2 = 0.25;
  var3 = 350;
  var4 = setup_blend_interaction_idles();
  var5 = "single anim";

  for(;;) {
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

  if(!scripts\engine\utility::ent_flag_exist("scene_end")) {
    scripts\engine\utility::ent_flag_init("scene_end");
  }

  scripts\engine\utility::ent_flag_clear("scene_end");
  self.reactiontrigger = spawn("trigger_radius", self.origin, 0, self.lookat_anims["trigger_radius"], self.lookat_anims["trigger_radius"]);
}

function setup_blend_interaction_idles() {
  var0 = get_interaction_starting_idle();
  self.random_idle_playing = 0;
  start_fakeactor_notetracks(var0);
  self setflaggedanim("single anim", var0, 1, 0.05, 1);
  thread interaction_set_anim_movement("stop");
}

function get_interaction_starting_idle() {
  var0 = undefined;

  if(isarray(self.lookat_anims["idle"])) {
    var0 = self.lookat_anims["idle"][0];
  } else {
    var0 = self.lookat_anims["idle"];
  }

  return var0;
}

function is_performing_sequential_scene() {
  var0 = undefined;

  if((level.player istouching(self.reactiontrigger) || is_looking_at_range(self, 0.925)) && !self.random_idle_playing) {
    if(self.sequential_scene) {
      var0 = 1;
    } else {
      var0 = 0;
    }
  } else {
    var0 = 0;
  }

  return var0;
}

function blended_interaction_tracecheck() {
  var0 = lengthsquared(level.player.origin - self.origin);
  var1 = undefined;
  var2 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
  var3 = undefined;

  for(;;) {
    var4 = scripts\sp\interaction_manager::can_play_nearby_interaction(self.lookat_anims["trigger_radius"] * 2);

    if(var4) {
      if(isDefined(self.lookat_anims["interaction_position"])) {
        var0 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
      } else {
        var0 = lengthsquared(level.player.origin - self.origin);
      }

      if(isDefined(self.lookat_anims["interaction_trigger_override"])) {
        break;
      } else if(self.lookat_anims["trigger_radius"] > 0 && var0 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925) && !self.random_idle_playing) {
        var5 = self.origin + anglestoup(self.angles) * 66;
        var1 = vectorNormalize(level.player getEye() - var5) * self.lookat_anims["trigger_radius"] + var5;
        var3 = scripts\engine\trace::ray_trace(var5, var1, self, var2);

        if(isPlayer(var3["entity"]) || isDefined(self.lookat_anims["interaction_trigger_override"])) {
          break;
        }
      }
    }

    waitframe();
  }
}

function play_blended_interaction_anims() {
  initialize_blended_interaction_anims();
  var0 = 0;
  var1 = 0;
  var2 = gettime() / 1000;
  var3 = getanimlength(self.lookat_anims["fwd_anim"]);

  while(gettime() / 1000 - var2 < var3) {
    var4 = vectorNormalize(level.player.origin - self.origin);
    var5 = anglesToForward(self.angles);
    var6 = anglesToForward(self.angles) * -1;
    var7 = anglestoright(self.angles);
    var8 = anglestoright(self.angles) * -1;
    var9 = anglestoup(self.angles);
    var10 = clamp(vectordot(var4, var5), 0.005, 1);
    var11 = clamp(vectordot(var4, var7), 0.005, 1);
    var12 = clamp(vectordot(var4, var8), 0.005, 1);
    var13 = clamp(vectordot(var4, var6), 0.005, 1);
    self setanimlimited(self.lookat_anims["right_anim"], var11, 0.2);
    self setanimlimited(self.lookat_anims["left_anim"], var12, 0.2);
    self setflaggedanimlimited("single anim", self.lookat_anims["fwd_anim"], var10 + 0.005, 0.2);
    var14 = 1;

    if(scripts\engine\math::anglebetweenvectorssigned(var5, var4, var9) > 0) {
      var14 = 0;
    }

    if(var14) {
      var1 = scripts\engine\math::lerp(var1, var13, 0.1);
      var0 = scripts\engine\math::lerp(var0, 0.005, 0.1);
    } else {
      var1 = scripts\engine\math::lerp(var1, 0.005, 0.1);
      var0 = scripts\engine\math::lerp(var0, var13, 0.1);
    }

    self setanimlimited(self.lookat_anims["back_right_anim"], var1, 0.2);
    self setanimlimited(self.lookat_anims["back_left_anim"], var0, 0.2);
    waitframe();
  }

  var15 = 0.45;
  end_blended_interaction_anims(var15);
  play_interaction_endidle(var15);
}

function initialize_blended_interaction_anims() {
  var0 = undefined;
  var0 = vectortoangles(level.player.origin - self.origin);
  self.is_playing_reaction = 1;
  level thread scripts\sp\interaction_manager::interaction_cooldown_timer(self);
  self setanimlimited(self.lookat_anims["interaction_blend_parent"], 1, 0.2);
  var1 = get_interaction_starting_idle();
  self clearanim(var1, 0.2);
  self clearanim(%head, 0.2);
  start_fakeactor_notetracks(self.lookat_anims["fwd_anim"]);
  self setflaggedanimlimited("single anim", self.lookat_anims["fwd_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["right_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["left_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["back_right_anim"], 0.005, 0.05);
  self setanimlimited(self.lookat_anims["back_left_anim"], 0.005, 0.05);
}

function end_blended_interaction_anims(var0) {
  self.reaction_blend_end = undefined;
  self clearanim(self.lookat_anims["fwd_anim"], var0);
  self clearanim(self.lookat_anims["right_anim"], var0);
  self clearanim(self.lookat_anims["left_anim"], var0);
  self clearanim(self.lookat_anims["back_right_anim"], var0);
  self clearanim(self.lookat_anims["back_left_anim"], var0);
  level notify("interaction_done");
  self notify("interaction_done");
  self.is_playing_reaction = 0;
}

function play_interaction_endidle(var0) {
  for(;;) {
    var1 = undefined;

    if(isDefined(self.lookat_anims["end_idle"])) {
      var1 = self.lookat_anims["end_idle"];
      start_fakeactor_notetracks(var1);
      self setanimtime(var1, 0);
      self setflaggedanimknoball("single anim", var1, %body, 1, var0, 1);
    } else {
      var1 = get_interaction_starting_idle();
      start_fakeactor_notetracks(var1);
      self setanimtime(var1, 0);
      self setflaggedanimknoball("single anim", var1, %body, 1, var0, 1);
    }

    wait getanimlength(var1);
  }
}

function simple_interaction_idles() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var0 = get_interaction(self.interaction_name);

  if(!scripts\engine\utility::ent_flag_exist("hold_simple_idles")) {
    scripts\engine\utility::ent_flag_init("hold_simple_idles");
  } else {
    scripts\engine\utility::ent_flag_clear("hold_simple_idles");
  }

  if(!isarray(var0.scene["idle"])) {
    return;
  }

  if(isarray(var0.scene["idle"]) && var0.scene["idle"].size <= 1) {
    return;
  }

  var1 = [];
  var2 = var0.scene["idle"];
  var3 = var2[0];
  var2 = scripts\engine\utility::array_remove_index(var2, 0);
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;

  if(isDefined(var0.scene["idle_prop"]) && isDefined(self.optional_prop)) {
    var4 = [];
    var0.scene["spent_array_prop"] = var4;
    var6 = var0.scene["idle_prop"];
    var5 = var6[0];
    var6 = scripts\engine\utility::array_remove_index(var6, 0);
    var7 = var6;
    var6 = undefined;
  }

  var8 = var2;
  var2 = undefined;
  thread clear_root();
  interaction_set_anim_movement("stop");

  for(;;) {
    if(isDefined(self.optional_struct)) {
      _set_node_relative_anim_actor(self.optional_struct, var3);
    }

    start_fakeactor_notetracks(var3);
    self setflaggedanimknob("single anim", var3, 1, 0.2, 1);
    thread scripts\asm\gesture\script_funcs::ai_lookat_release();

    if(isDefined(self.optional_prop)) {
      thread _simple_interaction_prop_start(var5);
    }

    wait getanimlength(var3) * randomintrange(1, 2);

    while(scripts\engine\utility::ent_flag("hold_simple_idles")) {
      wait getanimlength(var3);
    }

    if(var8.size <= 0) {
      var8 = var1;
      var1 = [];
    }

    var9 = randomint(var8.size);
    var10 = var8[var9];
    var1 = scripts\engine\utility::array_add(var1, var10);
    var8 = scripts\engine\utility::array_remove_index(var8, var9);

    if(isDefined(self.optional_prop)) {
      if(var7.size <= 0) {
        var7 = var4;
        var4 = [];
      }

      var11 = var7[var9];
      var4 = scripts\engine\utility::array_add(var4, var11);
      var7 = scripts\engine\utility::array_remove_index(var7, var9);
      thread _simple_interaction_prop_random_anim(var11);
    }

    self clearanim(var3, 0.2);

    if(isDefined(self.optional_struct)) {
      _set_node_relative_anim_actor(self.optional_struct, var10);
    }

    start_fakeactor_notetracks(var10);
    self setflaggedanimknob("single anim", var10, 1, 0.2, 1);
    thread scripts\asm\gesture\script_funcs::ai_lookat_hold();
    wait getanimlength(var10);
    self clearanim(var10, 0.2);

    if(isDefined(self.optional_prop)) {
      thread _simple_interaction_prop_clear();
    }

    waitframe();
  }
}

function _set_node_relative_anim_actor(var0, var1) {
  var2 = getstartorigin(var0.origin, var0.angles, var1);
  var3 = getstartangles(var0.origin, var0.angles, var1);

  if(!isDefined(self.is_cheap)) {
    self forceteleport(var2, var3, 100000);
    wait 0.05;
    return;
  }

  self.origin = var2;
  self.angles = var3;
  self dontinterpolate();
  wait 0.05;
}

#using_animtree("script_model");

function _simple_interaction_prop_random_anim(var0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
  self.optional_prop setanimknob(var0, 1, 0.2, 1);
  self.optional_prop.curr_anim = var0;
}

#using_animtree("");

function _simple_interaction_prop_start(var0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop setanimknob(var0, 1, 0.2, 1);
  self.optional_prop.curr_anim = var0;
}

function _simple_interaction_prop_clear() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.optional_prop useanimtree(#animtree);
  self.optional_prop clearanim(self.optional_prop.curr_anim, 0.2);
}

function play_anim_vo(var0, var1) {
  wait var0;
  var2 = strtok(var1, "_");

  if(scripts\engine\utility::array_contains(var2, "plr")) {
    level.player scripts\engine\sp\utility::play_sound_on_entity(var1);
    return;
  }

  scripts\engine\sp\utility::smart_dialogue(var1);
}

function _play_interaction_anim_vo_note() {
  self notify("start_interaction_vo_note");
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("start_interaction_vo_note");

  for(;;) {
    self waittill("single anim", var0);

    if(isarray(var0)) {
      foreach(var2 in var0) {
        if(issubstr(var2, "vo_") && !issubstr(var2, "_plr")) {
          var3 = getsubstr(var2, 3);
          thread scripts\engine\sp\utility::smart_dialogue(var3);
          wait lookupsoundlength(var3) / 1000;
          self notify("single dialogue");

          if(isDefined(self.scriptedtalkingknob)) {
            self clearanim(self.scriptedtalkingknob, 0.2);
          }
        }
      }

      continue;
    }

    if(issubstr(var0, "vo_") && !issubstr(var0, "_plr")) {
      var3 = getsubstr(var0, 3);
      thread scripts\engine\sp\utility::smart_dialogue(var3);
      wait lookupsoundlength(var3) / 1000;
      self notify("single dialogue");

      if(isDefined(self.scriptedtalkingknob)) {
        self clearanim(self.scriptedtalkingknob, 0.2);
      }
    }
  }
}

function play_note_anim_vo(var0) {
  self endon("death");
  self endon("stop_smart_reaction");
  var1 = 0;

  while(!var1) {
    self waittill("single anim", var2);

    if(isarray(var2)) {
      foreach(var4 in var2) {
        if(var4 == "reaction_vo") {
          var1 = 1;
          break;
        }
      }
    } else if(var2 == "reaction_vo") {
      var1 = 1;
      break;
    }

    waitframe();
  }

  self notify("reaction_vo_fired");
  scripts\sp\interaction_manager::play_smart_dialog_if_exists(var0);
}

function play_anim_shared_vo() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var0 = undefined;
  var1 = undefined;

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

    var2 = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"];
    var3 = randomint(var2.size);
    var1 = var2[var3];
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_male"], var3);
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_male_vo"], var1);
  }

  if(!isDefined(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"])) {
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    if(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"].size < 1) {
      level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"] = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"];
    }

    var2 = level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"];
    var3 = randomint(var2.size);
    var1 = var2[var3];
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["vo_lines_female"], var3);
    level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_state_interactions"][self.interaction_name]["used_female_vo"], var1);
  }

  var4 = undefined;

  for(;;) {
    self waittill("single anim", var5);

    if(isarray(var5)) {
      foreach(var7 in var5) {
        if(var7 == "reaction_vo") {
          var4 = 1;
          break;
        }
      }
    } else if(var5 == "reaction_vo") {
      var4 = 1;
    }

    if(isDefined(var4)) {
      break;
    }

    waitframe();
  }

  scripts\engine\sp\utility::smart_dialogue(var1);
}

function play_anim_vo_sequential(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = level.interaction_manager.data["registered_interactions"][self.interaction_name];

  if(isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"])) {
    var1 = 1;

    if(!isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"])) {
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "male")) {
      if(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"].size < 1) {
        level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"] = level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"];
      }

      var4 = level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"];
      var5 = randomint(var4.size);
      var2 = var4[var5];
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_male"], var5);
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_male_vo"], var2);
    }
  }

  if(isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"])) {
    var1 = 1;

    if(!isDefined(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"])) {
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      if(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"].size < 1) {
        level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"] = level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"];
      }

      var4 = level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"];
      var5 = randomint(var4.size);
      var2 = var4[var5];
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"] = scripts\engine\utility::array_remove_index(level.interaction_manager.data["registered_interactions"][self.interaction_name]["vo_lines_female"], var5);
      level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"] = scripts\engine\utility::array_add(level.interaction_manager.data["registered_interactions"][self.interaction_name]["used_female_vo"], var2);
    }
  }

  var6 = var0.size - 1;

  if(!isDefined(var1)) {
    if(isstring(var0[var6])) {
      var7 = 1;

      while(var7 < var0.size) {
        play_anim_vo(var0[var7], var0[var7 + 1]);
        var7 += 2;
      }

      return;
    }

    var7 = 1;

    while(var7 < var1.size - 1) {
      play_anim_vo(var1[var7], var1[var7 + 1]);
      var7 += 2;
    }

    return;
  }

  play_anim_vo(var1[1], var3);
}

function set_sequential_wait_time(var0) {
  self.sequential_wait_time = 0;
  self.sequential_loop_padding = 0;
  var1 = var0.size - 1;

  if(isstring(var0[var1])) {
    self.sequential_loop_padding = 0;
    var2 = 1;

    while(var2 < var0.size) {
      self.sequential_wait_time += var0[var2];
      var2 += 2;
    }

    return;
  }

  self.sequential_loop_padding = var1[var2];
  var2 = 1;

  while(var2 < var1.size - 1) {
    self.sequential_wait_time += var1[var2];
    var2 += 2;
  }
}

function random_idle_controller() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var0 = undefined;
  var1 = get_interaction(self.interaction_name);

  if(!isDefined(var1)) {
    var1 = get_state_interaction(self.interaction_name);
  }

  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;

  if(!isarray(var1.scene["idle"])) {
    var1.scene["idle"] = [var1.scene["idle"], var1.scene["idle"]];
  }

  var2 = [];
  var3 = var1.scene["idle"];
  var4 = var3[0];
  var3 = scripts\engine\utility::array_remove_index(var3, 0);
  var5 = var3;
  var3 = undefined;
  self.starting_random_idle = var4;

  for(;;) {
    self.is_playing_random_idle = 1;
    var6 = getanimlength(var4);
    var7 = randomint(2) + 1;
    var8 = var6 * float(var7);
    wait var8;

    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      waitframe();
    }

    if(var5.size <= 0) {
      var5 = var2;
      var2 = [];
    }

    var9 = var5[randomint(var5.size)];
    var2 = scripts\engine\utility::array_add(var2, var9);
    var5 = scripts\engine\utility::array_remove(var5, var9);
    var10 = undefined;
    var11 = undefined;

    if(isDefined(self.optional_struct)) {
      var10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var9);
      var11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var9);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(var10, var11);
      } else {
        self.origin = var10;
        self.angles = var11;
      }
    }

    while(self.is_playing_reaction) {
      waitframe();
    }

    start_fakeactor_notetracks(var9);
    self setflaggedanimknob("single anim", var9, 1, 0.2, 1);
    self.random_idle_playing = 1;
    var12 = getanimlength(var9);
    wait var12;

    while(self.is_playing_reaction) {
      waitframe();
    }

    if(isDefined(self.optional_struct)) {
      var10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var4);
      var11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var4);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(var10, var11);
      } else {
        self.origin = var10;
        self.angles = var11;
      }
    }

    self.random_idle_playing = 0;
    self clearanim(var9, 0.3);
    self.is_playing_random_idle = undefined;
    start_fakeactor_notetracks(var4);
    self setflaggedanimknob("single anim", var4, 1, 0.2, 1);
    self setanimtime(var4, randomfloat(1));

    for(;;) {
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
  var0 = undefined;
  var1 = get_state_interaction(self.interaction_name);
  self.can_play_random_idle = 1;
  self.is_playing_random_idle = undefined;
  var2 = undefined;

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    var2 = "idle_female";
  } else {
    var2 = "idle";
  }

  var3 = var1.scene[var2][0];
  self.starting_random_idle = var3;

  for(;;) {
    self.is_playing_random_idle = 1;
    var4 = getanimlength(var3);
    var5 = randomint(2) + 1;
    var6 = var4 * float(var5);
    wait var6;

    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      waitframe();
    }

    var7 = undefined;
    var8 = undefined;

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var7 = "random_idles_female";
      var8 = "spent_random_idles_female";
    } else {
      var7 = "random_idles";
      var8 = "spent_random_idles";
    }

    if(level.state_interactions[self.interaction_name].scene[var7].size <= 0) {
      level.state_interactions[self.interaction_name].scene[var7] = level.state_interactions[self.interaction_name].scene[var8];
      level.state_interactions[self.interaction_name].scene[var8] = [];
    }

    var9 = level.state_interactions[self.interaction_name].scene[var7][randomint(level.state_interactions[self.interaction_name].scene[var7].size)];
    level.state_interactions[self.interaction_name].scene[var8] = scripts\engine\utility::array_add(level.state_interactions[self.interaction_name].scene[var8], var9);
    level.state_interactions[self.interaction_name].scene[var7] = scripts\engine\utility::array_remove(level.state_interactions[self.interaction_name].scene[var7], var9);
    var10 = undefined;
    var11 = undefined;

    if(isDefined(self.optional_struct)) {
      var10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var9);
      var11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var9);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(var10, var11);
      } else {
        self.origin = var10;
        self.angles = var11;
      }
    }

    while(self.is_playing_reaction) {
      waitframe();
    }

    start_fakeactor_notetracks(var9);
    self setflaggedanimknob("single anim", var9, 1, 0.2, 1);
    self.random_idle_playing = 1;
    var12 = getanimlength(var9);
    wait var12;

    while(self.is_playing_reaction) {
      waitframe();
    }

    if(isDefined(self.optional_struct)) {
      var10 = getstartorigin(self.optional_struct.origin, self.optional_struct.angles, var3);
      var11 = getstartangles(self.optional_struct.origin, self.optional_struct.angles, var3);

      if(!isDefined(self.is_cheap)) {
        self forceteleport(var10, var11);
      } else {
        self.origin = var10;
        self.angles = var11;
      }
    }

    self.random_idle_playing = 0;
    self clearanim(var9, 0.3);
    self.is_playing_random_idle = undefined;
    start_fakeactor_notetracks(var3);
    self setflaggedanimknob("single anim", var3, 1, 0.2, 1);
    self setanimtime(var3, randomfloat(1));

    for(;;) {
      if(isDefined(self.can_play_random_idle)) {
        break;
      }

      waitframe();
    }

    waitframe();
  }
}

function random_idle_group_controller(var0, var1, var2) {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  level endon("stop_idle_controller");
  self endon("stop_group_idle_controller");
  level endon("stop_group_idle_controller");
  self endon("death");

  if(!scripts\engine\utility::flag_exist("hold_group_vignettes")) {
    scripts\engine\utility::flag_init("hold_group_vignettes");
  }

  var3 = [];
  var4 = var2;

  for(;;) {
    wait randomfloatrange(var1 * 0.5, var1);

    foreach(var6 in var0) {
      if(!isDefined(var6)) {
        self notify("stop_group_idle_controller");
        return;
      }

      var6 endon("death");
      var6 endon("entitydeleted");
      var6.can_play_random_idle = undefined;
    }

    var8 = 0;

    for(;;) {
      if(!scripts\engine\utility::flag("hold_group_vignettes")) {
        foreach(var10 in var0) {
          if(!isDefined(var10.is_playing_random_idle)) {
            var8++;
          }
        }

        if(var8 >= var0.size) {
          break;
        } else {
          var8 = 0;
        }
      }

      waitframe();
    }

    var12 = undefined;

    if(isarray(var2)) {
      if(var4.size <= 0) {
        var4 = var2;
        var3 = [];
      }

      var12 = var4[randomint(var4.size)];
    } else {
      var12 = var2;
    }

    var13 = 0;

    if(!scripts\engine\utility::flag("hold_group_vignettes")) {
      foreach(var6 in var0) {
        if(!isDefined(var6)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var15 = var6 scripts\engine\utility::getanim(var12);
        var16 = getstartorigin(var6.origin, var6.angles, var15);
        var17 = getstartangles(var6.origin, var6.angles, var15);

        if(isai(var6)) {
          var6 forceteleport(var16, var17);
        } else {
          var6.origin = var16;
          var6.angles = var17;
        }

        thread start_fakeactor_notetracks(var6);
        var6 setflaggedanimknob("single anim", var15, 1, 0.2);
        var6.allow_interactions = 0;
        var6.hold_lookat = 1;
        var13 = getanimlength(var15);
      }

      wait var13;

      if(isarray(var2)) {
        var3 = scripts\engine\utility::array_add(var3, var12);
        var4 = scripts\engine\utility::array_remove(var4, var12);
      }

      foreach(var20 in var0) {
        if(!isDefined(var20)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var15 = var20 scripts\engine\utility::getanim(var12);
        thread start_fakeactor_notetracks(var20);
        var20 setanimknob(var15, 0, 0.2);
        var20 setflaggedanimknob("single anim", var20.starting_random_idle, 1, 0.2, 1);
        var20 setanimtime(var20.starting_random_idle, randomfloat(1));
        var20.can_play_random_idle = 1;
        var20.allow_interactions = 1;
        var20.hold_lookat = undefined;
      }
    }

    waitframe();
  }
}

function interaction_end() {
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

function interaction_end_cheap() {
  self waittill("reaction_end");
  scripts\sp\interaction_manager::remove_actor_from_manager();
  self notify("interaction_done");
  self notify("stop_reaction");
  self.is_talking = undefined;
}

function set_time_via_rate(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = self getanimtime(var0);
  var4 = getanimlength(var0);
  var5 = (var1 - var3) * var4 / 0.05;
  self setanimlimited(var0, var2, 0.25, var5);
}

function play_combat_interaction(var0, var1) {
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
  self.combat_reaction_return_state = var1;

  if(isDefined(level.interaction_manager)) {
    level.interaction_manager.data["actors"] = scripts\engine\utility::array_add(level.interaction_manager.data["actors"], self);
  }

  for(;;) {
    jumpiffalse(self.script == "init") LOC_0000008e;
    waitframe();
  }

  for(;;) {
    for(;;) {
      var2 = lengthsquared(level.player.origin - self.origin);

      if(var2 < squared(150) && is_looking_at_range(self, 0.925)) {
        break;
      }

      waitframe();
    }

    var3 = self.asmname;
    var4 = self asmgetcurrentstate(var3);

    if(var4 == self.combat_reaction_return_state && !self.nearby_interaction_running) {
      if(var0.script_reaction == "combat_reaction") {
        var5 = [];

        if(isDefined(var0.type)) {
          switch (var0.type) {
            case "Cover Crouch":
              var5 = ["combat_crouch_1", "combat_crouch_2"];
              break;
            case "Cover Left":
              switch (self.currentpose) {
                case "stand":
                  var5 = ["hm_grnd_org_cover_left_stand_react_01", "hm_grnd_org_cover_left_stand_react_02"];
                  break;
                case "crouch":
                  var5 = ["hm_grnd_org_cover_left_crouch_react_01", "hm_grnd_org_cover_left_crouch_react_02"];
                  break;
                case "prone":
                  break;
              }

              break;
            case "Cover Right":
              switch (self.currentpose) {
                case "stand":
                  var5 = ["hm_grnd_org_cover_right_stand_react_01", "hm_grnd_org_cover_right_stand_react_02"];
                  break;
                case "crouch":
                  var5 = ["hm_grnd_org_cover_right_crouch_react_01", "hm_grnd_org_cover_right_crouch_react_02"];
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
              var5 = ["combat_cover_crouch_1"];
              break;
          }

          if(var5.size > 0) {
            var6 = randomint(var5.size);
            var7 = var5[var6];
            combat_interaction_process(var7, var0);
          } else {
            return;
          }
        }
      } else {
        combat_interaction_process(var0.script_reaction, var0);
      }
    }

    wait 1.5;
  }
}

function combat_interaction_process(var0, var1) {
  self endon("death");
  self endon("interaction_done");
  var2 = get_interaction(var0);
  thread scripts\common\notetrack::start_notetrack_wait(self, "vo");
  thread _play_interaction_anim_vo_note();

  if(!isDefined(var2)) {
    return;
  }

  self.lookat_anims = var2.scene;

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  var3 = lengthsquared(level.player.origin - self.origin);
  var4 = undefined;
  var5 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
  var6 = undefined;

  if(isDefined(self.lookat_anims["interaction_position"])) {
    var3 = lengthsquared(self.lookat_anims["interaction_position"] - self.origin);
  } else {
    var3 = lengthsquared(level.player.origin - self.origin);
  }

  if(var3 < squared(self.lookat_anims["trigger_radius"]) && is_looking_at_range(self, 0.925)) {
    var4 = vectorNormalize(level.player getEye() - self getEye()) * self.lookat_anims["trigger_radius"] + self getEye();
    var6 = scripts\engine\trace::ray_trace(self getEye(), var4, self, var5);

    if(isPlayer(var6["entity"])) {
      combat_interaction_run();
      return;
    }

    return;
  }
}

function combat_interaction_run() {
  self endon("death");
  self endon("interaction_done");
  self.is_playing_reaction = 1;
  self notify("playing_interaction_scene");
  level notify("playing_interaction");
  var0 = self.combat_reaction_previous_anim;
  var1 = undefined;

  if(isDefined(self.lookat_anims["interaction_position"])) {
    var1 = vectortoangles(self.lookat_anims["interaction_position"] - self.origin);
  } else {
    var1 = vectortoangles(level.player.origin - self.origin);
  }

  var2 = abs(angleclamp((var1 - self.angles)[1]) - 360);
  var3 = self.lookat_anims["lastanim"];

  if(isDefined(self.lookat_anims["angles"])) {
    foreach(var5 in self.lookat_anims["angles"]) {
      if(var2 <= var5) {
        var3 = self.lookat_anims[var5];
        break;
      }
    }
  }

  if(isarray(var3)) {
    if(isarray(var3[0])) {
      var7 = self.anim_sequential_counter;
      var8 = var3[0][var7][0];
    } else {
      var8 = var8[0];
    }
  } else {
    var8 = var8;
  }

  start_fakeactor_notetracks(var8);
  self setanimlimited(%cover, 0, 0.25, 1);
  self setflaggedanimknoball("vo", var8, $body, 1, 0.25, 1);
  wait getanimlength(var8);
  self clearanim(%scripted, 0.25);
  self setanimlimited(%cover, 1, 0.25, 1);
  self.is_playing_reaction = 0;
  wait 0.25;
  self notify("interaction_done");
  level notify("interaction_done");
  thread interaction_end();
}

function combat_reaction_wait_buffer(var0) {
  var0.combat_reaction_wait = 1;
  wait 2;
  var0.combat_reaction_wait = undefined;
}

function new_goal_listener() {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var0 = undefined;

  if(isDefined(self.last_set_goalnode)) {
    var0 = self.last_set_goalnode.origin;

    while(isDefined(self.last_set_goalnode) && self.last_set_goalnode.origin == var0) {
      waitframe();
    }
  } else if(isDefined(self.last_set_goalent)) {
    var0 = self.last_set_goalent.origin;

    while(isDefined(self.last_set_goalent) && self.last_set_goalent.origin == var0) {
      waitframe();
    }
  } else if(isDefined(self.last_set_goalpos)) {
    var0 = self.last_set_goalpos;

    while(isDefined(self.last_set_goalpos) && self.last_set_goalpos == var0) {
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

  for(;;) {
    self.interaction_pain = undefined;
    self waittill("pain");
    self.interaction_pain = 1;
    wait 5;
  }
}

function interaction_set_anim_movement(var0) {
  if(!isDefined(var0)) {
    var0 = "stop";
  }

  if(isai(self)) {
    self.a.movement = var0;
    return;
  }
}

function start_fakeactor_notetracks(var0) {
  var1 = undefined;

  if(isDefined(self.interaction_name)) {
    var1 = self.interaction_name;
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, "single anim", var1, undefined, var0);
  thread scripts\sp\anim::animscriptdonotetracksthread(self, "single anim", var1);
}
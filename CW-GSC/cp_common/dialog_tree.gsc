/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\dialog_tree.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace dialog_tree;

function private autoexec __init__system__() {
  system::register("dialog_tree", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "dt_set_fov", 1, 3, "int");
  clientfield::register("toplayer", "dt_set_dof", 1, 3, "int");
  clientfield::register("toplayer", "dt_set_hide_reticle_dot", 1, 1, "int");
  level.var_fb0a6829 = [];
  level.var_fb0a6829[# "default"] = 1;
  level.var_fb0a6829[# "hash_2e64a3fb2ff83fc4"] = 2;
  level.var_fb0a6829[# "zoom"] = 3;
  level.var_fb0a6829[# "more_zoom"] = 4;
  level.var_fb0a6829[# "extreme_zoom"] = 5;
  level.var_22817c8a[# "none"] = 1;
  level.var_22817c8a[# "close"] = 2;
  level.var_22817c8a[# "medium"] = 3;
}

function new_tree(enter_func = undefined, exit_func = undefined, allow_movement = 0, allow_weapon = 0, script_bundle, var_4d84ed71 = 1, timeout = 0, skippable = 1) {
  if(!isDefined(level.var_d5314f55)) {
    level.var_d5314f55 = [];
  }

  new_dialog = spawnStruct();
  new_dialog.selected_options = 0;
  new_dialog.player_pos = [];
  new_dialog.enter_func = enter_func;
  new_dialog.exit_func = exit_func;
  new_dialog.allow_movement = allow_movement;
  new_dialog.allow_weapon = allow_weapon;
  new_dialog.var_4d84ed71 = var_4d84ed71;
  new_dialog.timeout = timeout;
  new_dialog.skippable = skippable;
  new_dialog.options = [];
  new_dialog.position = array(1224, 650);
  new_dialog.state_index = 0;
  new_dialog.temp_disabled = 0;
  new_dialog.var_6c2428f4 = # "hash_23c2f3c5f7013d69";
  new_dialog set_scriptbundle(script_bundle);
  var_ed170ba3 = level.var_d5314f55.size;
  level.var_d5314f55[var_ed170ba3] = new_dialog;
  new_dialog.var_ec3cbc15 = 0;
  return new_dialog;
}

function set_scriptbundle(bundle) {
  self.scriptbundle = bundle;
}

function add_option(option_text, ai_vo = undefined, ai_anim = undefined, var_a0ee58ce = undefined, end_dialog = 0, set_flag = undefined, var_a16c9b3f = undefined, selected_func = undefined, func_parameter, skip_func = undefined) {
  option = function_98927b7b(undefined, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func);
  return self function_d602cdd7(option);
}

function function_6bbbf87(var_9ddc06f5, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined) {
  option = function_98927b7b(undefined, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func);
  return self function_d602cdd7(option);
}

function function_7fe78745(var_84fa2307, var_c275310d, reset = 1, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined) {
  option = function_98927b7b(undefined, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func, 0, var_84fa2307, var_c275310d, reset);
  return self function_d602cdd7(option);
}

function function_9e36808(option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined) {
  var_1307f204 = self.options.size - 1;
  option = function_98927b7b(var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func);
  option.active = 0;
  return self function_d602cdd7(option);
}

function function_ad98a815(var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined) {
  option = function_98927b7b(var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func);
  option.active = 0;
  return self function_d602cdd7(option);
}

function function_f5d1891(var_9ddc06f5, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined) {
  var_1307f204 = self.options.size - 1;
  option = function_98927b7b(var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func);
  option.active = 0;
  return self function_d602cdd7(option);
}

function function_da884b08(var_1307f204, var_9ddc06f5, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined) {
  option = function_98927b7b(var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func);
  option.active = 0;
  return self function_d602cdd7(option);
}

function function_6cbfa3d2(option_id = self.options.size - 1, end_dialog = 1) {
  self.options[option_id].end_dialog = end_dialog;
}

function function_6ebd37a4(option_id = self.options.size - 1) {
  self.options[option_id].important = 1;
}

function function_bc7c03bf(option_id = self.options.size - 1) {
  self.options[option_id].show_locked = 1;
}

function function_46f25b65(option_id = self.options.size - 1, var_a5bdf9c0 = 0, cycle_style = "loop", vo_lines = 1, anims = 1) {
  self.options[option_id].cycle_style = cycle_style;

  if(vo_lines) {
    if(isDefined(self.options[option_id].vo_npc)) {
      if(!isarray(self.options[option_id].vo_npc)) {
        self.options[option_id].vo_npc = [self.options[option_id].vo_npc];
      }

      if(var_a5bdf9c0) {
        self.options[option_id].cur_vo = randomint(self.options[option_id].vo_npc.size);
      } else {
        self.options[option_id].cur_vo = 0;
      }
    }
  }

  if(anims) {
    if(isDefined(self.options[option_id].anim_npc)) {
      if(!isarray(self.options[option_id].anim_npc)) {
        self.options[option_id].anim_npc = [self.options[option_id].anim_npc];
      }

      if(var_a5bdf9c0) {
        self.options[option_id].cur_anim = randomint(self.options[option_id].anim_npc.size);
        return;
      }

      self.options[option_id].cur_anim = 0;
    }
  }
}

function function_a3a3ea7d(message, var_b5df2c8b) {
  self.temp_disabled = 1;

  if(isDefined(message)) {
    self.var_6c2428f4 = message;
  }

  if(isDefined(var_b5df2c8b)) {
    level flag::wait_till(var_b5df2c8b);
    self.temp_disabled = 0;
  }
}

function function_b32b7f64() {
  self.temp_disabled = 0;
}

function function_21780fc5(dialog_tree, var_a9b0cfdc) {
  assert(isDefined(dialog_tree) && isarray(var_a9b0cfdc) && isint(var_a9b0cfdc[0]) && isint(var_a9b0cfdc[1]), "<dev string:x38>");
  dialog_tree.position = var_a9b0cfdc;
}

function function_6bb91351(state_index) {
  self.state_index = state_index;
}

function function_b82713b8(player_loc, var_f2aae3f7, var_dfe2a95d, var_60a7aecc, stance = "stand", fov = "zoom", dof = "medium", lerptime = 2, var_6549d3f9, override_struct) {
  new_pos = spawnStruct();
  new_pos.player_loc = player_loc;
  new_pos.var_f2aae3f7 = var_f2aae3f7;
  new_pos.var_9d5a3b8f = var_dfe2a95d;
  new_pos.var_60a7aecc = var_60a7aecc;
  new_pos.stance = stance;
  new_pos.origin = player_loc.origin;
  new_pos.fov = fov;
  new_pos.dof = dof;
  new_pos.lerptime = lerptime;
  new_pos.var_6549d3f9 = var_6549d3f9;
  new_pos.override_struct = override_struct;
  self.player_pos[self.player_pos.size] = new_pos;
}

function private function_decf2123(cur_idx, var_16f87bfa, cycle_option) {
  last_idx = cur_idx;
  cur_idx++;

  if(cur_idx >= var_16f87bfa) {
    cur_idx = 0;

    switch (cycle_option) {
      case # "hash_c8920743575bcda":
        cur_idx = 1;
        break;
      case # "repeat_last":
        cur_idx = last_idx;
        break;
      case # "randomize":
        cur_idx = randomint(var_16f87bfa);
        break;
      case # "randomize_skip_first":
        cur_idx = randomint(var_16f87bfa - 1) + 1;
        break;
    }

    if(cycle_option == "randomize" || cycle_option == "randomize_skip_first") {
      first_option = 0;

      if(cycle_option == "randomize_skip_first") {
        first_option = 1;
      }

      if(cur_idx == last_idx) {
        cur_idx++;

        if(cur_idx >= var_16f87bfa) {
          cur_idx = first_option;
        }
      }
    }

    cur_idx = math::clamp(cur_idx, 0, var_16f87bfa - 1);
  }

  return cur_idx;
}

function private function_a92530c0(ai_actor, anim_struct) {
  player = self.activator;

  if(isDefined(self.player_pos) && self.player_pos.size > 0) {
    foreach(pos in self.player_pos) {
      if(!isDefined(pos.player_loc)) {
        ai_pos = struct::spawn();
        ai_pos.origin = ai_actor.origin;
        ai_pos.angles = ai_actor.angles;

        if(isDefined(pos.var_f2aae3f7)) {
          future_pos = function_b8031554(ai_actor, anim_struct, self.scriptbundle, pos.var_f2aae3f7);

          if(isDefined(future_pos)) {
            ai_pos = future_pos;
          }
        }

        pos.player_loc = struct::spawn(ai_pos.origin + anglesToForward(ai_pos.angles) * 56 + anglestoright(ai_pos.angles) * -10, ai_pos.angles + (0, 180, 0));
        pos.origin = pos.player_loc.origin;
      }
    }

    closest_pos = arraygetclosest(player.origin, self.player_pos);
    self.var_c7af782 = closest_pos;

    if(isDefined(closest_pos.stance)) {
      switch (closest_pos.stance) {
        case # "stand":
          self.activator val::set(#"dialog_tree", "allow_crouch", 0);
          self.activator val::set(#"dialog_tree", "allow_prone", 0);
          self.activator val::set(#"dialog_tree", "allow_stand", 1);
          break;
        case # "crouch":
          self.activator val::set(#"dialog_tree", "allow_crouch", 1);
          self.activator val::set(#"dialog_tree", "allow_prone", 0);
          self.activator val::set(#"dialog_tree", "allow_stand", 0);
          break;
        case # "prone":
          self.activator val::set(#"dialog_tree", "allow_crouch", 0);
          self.activator val::set(#"dialog_tree", "allow_prone", 1);
          self.activator val::set(#"dialog_tree", "allow_stand", 0);
          break;
      }

      player setstance(closest_pos.stance);
    }

    self.activator val::set(#"dialog_tree", "allow_movement", 0);
    self.activator ghost();
    self.player_linkto = player util::spawn_model("tag_origin", closest_pos.player_loc.origin, closest_pos.player_loc.angles);
    self.player_linkto dontinterpolate();

    if(isDefined(closest_pos.fov) && isDefined(level.var_fb0a6829[closest_pos.fov])) {
      player thread clientfield::set_to_player("dt_set_fov", level.var_fb0a6829[closest_pos.fov]);
    }

    if(isDefined(closest_pos.dof) && isDefined(level.var_22817c8a[closest_pos.dof])) {
      player thread clientfield::set_to_player("dt_set_dof", level.var_22817c8a[closest_pos.dof]);
    }

    if(isai(ai_actor)) {
      ai_actor thread ai::look_at(player);
    }

    targ_pos = self.player_linkto gettagorigin("tag_origin");

    if(targ_pos == (0, 0, 0) || distance(player.origin, targ_pos) > 256) {
      player show();
    } else {
      player playerlinktoblend(self.player_linkto, "tag_origin", 2, 0.4, 0.4);
      self thread function_edd56700(player);
    }

    self function_2ae0f2f5(ai_actor, anim_struct, closest_pos);
  }
}

function private function_edd56700(player) {
  wait 2;

  if(!self.allow_movement) {
    player playerlinktodelta(self.player_linkto, "tag_origin", 1, 10, 10, 5, 5, 1, 1);
  } else {
    player unlink();
    self.player_linkto = undefined;
    self.activator val::reset(#"dialog_tree", "allow_movement");
  }

  player show();
}

function function_b8031554(ai_actor, struct, scene, shot) {
  if(isDefined(struct) && isDefined(scene) && isDefined(shot)) {
    fakeai = util::spawn_anim_model(struct.model, struct.origin, struct.angles);
    fakeai.animname = struct.animname;
    fakeai.targetname = struct.targetname;
    fakeai makefakeai();
    fakeai hide();
    fakeai scene::play_from_time(scene, shot, [fakeai], 1, 1, 1);
    fakeai dontinterpolate();
    wait 0.05;
    pos_info = struct::spawn();
    pos_info.origin = fakeai.origin;
    pos_info.angles = fakeai gettagangles("tag_origin");
    pos_info.var_38d4ed7 = fakeai gettagorigin("j_head");
    fakeai delete();
    return pos_info;
  }

  return undefined;
}

function private function_2ae0f2f5(ai_actor, struct, player_pos) {
  bundle = self.scriptbundle;

  if(isDefined(player_pos.override_scene)) {
    bundle = player_pos.override_scene;
  }

  if(isDefined(player_pos.override_struct)) {
    struct = player_pos.override_struct;
  }

  if(isDefined(bundle)) {
    if(isDefined(player_pos.var_f2aae3f7)) {
      struct scene::play(bundle, player_pos.var_f2aae3f7, [ai_actor]);
    }

    if(isDefined(player_pos.var_9d5a3b8f)) {
      struct thread scene::play(bundle, player_pos.var_9d5a3b8f, [ai_actor]);
    }
  }
}

function private function_86a1bed2(ai_actor, struct, player_pos) {
  if(isDefined(player_pos)) {
    bundle = self.scriptbundle;

    if(isai(ai_actor)) {
      ai_actor thread ai::look_at(undefined);
      ai_actor lookatentity();
    }

    if(isDefined(player_pos.fov)) {
      self.activator thread clientfield::set_to_player("dt_set_fov", 1);
    }

    if(isDefined(player_pos.dof)) {
      self.activator thread clientfield::set_to_player("dt_set_dof", 1);
    }

    if(isDefined(player_pos.override_scene)) {
      bundle = player_pos.override_scene;
    }

    if(isDefined(player_pos.override_struct)) {
      struct = player_pos.override_struct;
    }

    if(isDefined(bundle)) {
      if(isDefined(player_pos.var_60a7aecc)) {
        struct scene::play(bundle, player_pos.var_60a7aecc, [ai_actor]);
      }
    }
  }
}

function function_cfa96cee(dialog_tree, anim_struct, timer, kill_notify = "dialog_wait_cancel", use_dist = 80, display_dist = 200, use_angles = 0, use_offset = (6, 0, 0), var_5bab29d8 = 0) {
  if(isDefined(self) && isai(self) && !isalive(self)) {
    println("<dev string:x69>" + self.name + "<dev string:xaa>");
    return;
  }

  self.radius = 2.5;

  if(self haspart("j_spine4")) {
    tagname = "j_spine4";
  } else {
    tagname = undefined;
  }

  interactstring = # "OBJECTIVES/TALK_TO";
  self util::create_cursor_hint(tagname, use_offset, interactstring, use_dist, undefined, undefined, undefined, display_dist, use_angles);
  self prompts::function_92127496(1);
  self prompts::function_1a5e1da6(#"use", 1);
  msg = self waittill(#"trigger", #"death", #"start_context_melee", #"deleted", kill_notify);

  if(msg._notify == "trigger") {
    return dialog_tree run(self, anim_struct, timer, msg.activator, var_5bab29d8);
  }

  self util::remove_cursor_hint();
  return;
}

function run(ai_actor, anim_struct, timer, activator, var_5bab29d8 = 0, var_cf6d95c9 = 4, var_5738c83e = 0) {
  assert(isarray(self.options));

  if(!isDefined(ai_actor)) {
    ai_actor = level;
  }

  self.ai_actor = ai_actor;

  if(isDefined(activator) && isPlayer(activator)) {
    self.activator = activator;
  } else {
    self.activator = getplayers()[0];
  }

  if(!isDefined(self.activator)) {
    return -1;
  }

  self.activator endon(#"death");
  globallogic_ui::function_9ed5232e("ActorOverheadNames.0.hidden", 1);
  self.activator val::set(#"dialog_tree", "show_crosshair", 0);

  if(self.temp_disabled || !savegame::function_51c242e9(1) && !var_5bab29d8) {
    var_e9ba1503 = 3;
    self.activator util::show_hint_text(self.var_6c2428f4, 0, undefined, var_e9ba1503);
    wait var_e9ba1503;
    return -1;
  }

  ai_actor notify(#"dialog_active");

  if(!isDefined(ai_actor.var_b905c47b)) {
    ai_actor.var_b905c47b = 0;
  }

  ai_actor.var_b905c47b++;

  if(!isDefined(anim_struct)) {
    anim_struct = ai_actor;
  }

  if(self.skippable) {
    self thread function_27059a7f(ai_actor, anim_struct);
  }

  if(ai_actor.var_b905c47b <= 1) {
    level flag::set("dialog_tree_active");
    level flag::set("prompts_disabled");
    namespace_61e6d095::function_28027c42(#"dialog_tree", [# "dialog_tree", #"hint_tutorial"]);
    objectives::function_9dfb43fc();
    self.var_bc62b3ce = getdvarfloat(#"hash_6b57212fd4fcdd3a");
    setDvar(#"hash_6b57212fd4fcdd3a", 0);
    self.activator val::set(#"dialog_tree", "ignoreme", 1);
    self.activator val::set(#"dialog_tree", "takedamage", 0);

    if(isai(ai_actor)) {
      if(!isDefined(ai_actor.animname)) {
        ai_actor.animname = "generic";
      }

      ai_actor val::set(#"dialog_tree", "ignoreme", 1);
      ai_actor val::set(#"dialog_tree", "takedamage", 0);
    }

    self function_a92530c0(ai_actor, anim_struct);

    if(!isDefined(self.player_linkto) && !self.allow_movement) {
      self.player_linkto = util::spawn_model("tag_origin", self.activator.origin, self.activator.angles);

      if(is_true(level.var_9c0a73b)) {
        v = level.player getplayerangles();
        f_upper = -1 * (v[0] - 10);
        f_lower = v[0] + 10;
        self.activator playerlinktodelta(self.player_linkto, "tag_origin", 0, 20, 20, f_upper, f_lower, 1);
      } else {
        self.activator playerlinktodelta(self.player_linkto, "tag_origin", 0, 20, 20, 10, 10, 1);
      }

      self.activator setstance("stand");
      self.activator val::set(#"dialog_tree", "allow_crouch", 0);
      self.activator val::set(#"dialog_tree", "allow_prone", 0);
    }

    if(!self.allow_weapon) {
      self.activator val::set(#"dialog_tree", "disable_weapons", 1);
      self.activator val::set(#"dialog_tree", "disable_offhand_weapons", 1);
    }

    self.selected_options = 0;
  }

  ai_actor function_a5440f84("_dialog_vo_playing");
  ai_actor function_a5440f84("_dialog_anim_playing");
  ai_actor function_a5440f84("_dialog_func_running");
  ai_actor function_a5440f84("_dialog_ui_animating");

  if(isDefined(self.enter_func)) {
    ai_actor[[self.enter_func]]();
  }

  ai_actor flag::wait_till_clear("_dialog_ui_animating");

  while(ai_actor.var_b905c47b > 1) {
    wait 0.1;
  }

  wait 0.5;
  end_dialog = 0;
  last_choice = -1;

  if(self.var_4d84ed71) {
    namespace_82bfe441::fade(1, "FadeFast");
  }

  function_43bca3cb(self.position, self.state_index);
  globallogic_ui::function_9ed5232e("hudItems.subtitles.noAutoHide", 1);

  if(isDefined(timer) && timer > 0) {
    self.timeout = timer;
  }

  while(!end_dialog) {
    var_d9d52a9d = self function_4a2c9dcb(var_cf6d95c9);

    if(var_d9d52a9d.size < 1) {
      end_dialog = 1;
      continue;
    }

    ai_actor flag::set("_dialog_ui_animating");
    namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "kbmIndexSelected", -1, 1, undefined, undefined, 1);
    var_8989140b = function_8b61aa4c(var_d9d52a9d, ai_actor, var_cf6d95c9);

    if(var_8989140b == -1) {
      break;
    }

    self.selected_options++;
    globallogic_ui::function_9ed5232e("hudItems.subtitles.noAutoHide", 0);
    waitframe(1);
    globallogic_ui::function_9ed5232e("hudItems.subtitles.noAutoHide", 1);
    ai_actor notify(#"dialog_tree_choice_made");
    level notify(#"dialog_tree_choice_made");
    ai_actor flag::wait_till_clear("dialog_wait_for_animation");
    var_b7751c0b = self.options[var_8989140b];
    bb::function_7977c093(self.scriptbundle, self.options[var_8989140b].hudstring, getplayers()[0]);

    if(isai(ai_actor)) {
      ai_actor stopsounds();
    }

    if(isDefined(var_b7751c0b.set_flag)) {
      foreach(flag in var_b7751c0b.set_flag) {
        level flag::set(flag);
      }
    }

    if(isDefined(var_b7751c0b.selected_func)) {
      ai_actor flag::set("_dialog_func_running");
      ai_actor childthread function_a7575efe(var_b7751c0b.selected_func, var_b7751c0b.func_parameter, var_b7751c0b.skip_func);
    }

    if(isDefined(var_b7751c0b.vo_npc)) {
      ai_actor flag::set("_dialog_vo_playing");

      if(var_b7751c0b.cur_vo < 0) {
        self thread function_62d48ab(ai_actor, var_b7751c0b.vo_npc);
      } else {
        self thread function_62d48ab(ai_actor, var_b7751c0b.vo_npc[var_b7751c0b.cur_vo]);
        var_b7751c0b.cur_vo = function_decf2123(var_b7751c0b.cur_vo, var_b7751c0b.vo_npc.size, var_b7751c0b.cycle_style);
      }
    }

    anim_struct notify(#"hash_302d410c6a09c48e");

    if(isDefined(var_b7751c0b.anim_npc) || isDefined(var_b7751c0b.var_59ae859c)) {
      ai_actor flag::set("_dialog_anim_playing");

      if(var_b7751c0b.cur_anim < 0) {
        self thread function_c331410b(ai_actor, var_b7751c0b.anim_npc, var_b7751c0b.var_59ae859c, anim_struct, self.scriptbundle);
      } else {
        self thread function_c331410b(ai_actor, var_b7751c0b.anim_npc[var_b7751c0b.cur_anim], var_b7751c0b.var_59ae859c, anim_struct, self.scriptbundle);
        var_b7751c0b.cur_anim = function_decf2123(var_b7751c0b.cur_anim, var_b7751c0b.anim_npc.size, var_b7751c0b.cycle_style);
      }
    }

    if(is_true(var_b7751c0b.end_dialog) || self.timeout > 0) {
      end_dialog = 1;
      last_choice = var_8989140b;
    }

    ai_actor flag::wait_till_clear_all(["_dialog_func_running", "_dialog_vo_playing", "_dialog_anim_playing"]);

    if(!end_dialog) {
      ai_actor flag::wait_till_clear("_dialog_ui_animating");
    }

    ai_actor notify(#"hash_3d888301ef5802aa");

    if(!isDefined(var_b7751c0b.var_a16c9b3f) || var_b7751c0b.var_a16c9b3f != "forever" && level flag::get(var_b7751c0b.var_a16c9b3f)) {
      if(isDefined(self.options[var_8989140b])) {
        self.options[var_8989140b].active = 0;
      }
    }

    self function_59d38639(var_8989140b);
    waitframe(1);

    if(var_5738c83e) {
      self.var_ec3cbc15 = var_8989140b;
    }

    if(is_true(ai_actor.end_dialog)) {
      ai_actor.end_dialog = undefined;
      break;
    }
  }

  if(ai_actor.var_b905c47b <= 1) {
    if(self.var_4d84ed71) {
      namespace_82bfe441::fade(0, "FadeFast");
    }

    if(namespace_61e6d095::exists(#"dialog_tree")) {
      namespace_61e6d095::function_73c9a490(#"dialog_tree", 0);
      namespace_61e6d095::remove(#"dialog_tree");
    }

    namespace_61e6d095::function_4279fd02(#"dialog_tree");
    objectives::function_4279fd02();
    globallogic_ui::function_9ed5232e("ActorOverheadNames.0.hidden", 0);
    self.activator val::reset(#"dialog_tree", "show_crosshair");
    self.activator clientfield::set_to_player("dt_set_hide_reticle_dot", 0);

    if(isDefined(self.var_c7af782)) {
      self thread function_86a1bed2(ai_actor, anim_struct, self.var_c7af782);
      self.var_c7af782 = undefined;
    }
  }

  if(isDefined(self.exit_func)) {
    ai_actor childthread[[self.exit_func]]();
  }

  if(ai_actor.var_b905c47b <= 1) {
    if(isDefined(self.var_bc62b3ce)) {
      setDvar(#"hash_6b57212fd4fcdd3a", self.var_bc62b3ce);
    }

    if(!self.allow_movement) {
      self.activator unlink();

      if(isDefined(self.player_linkto)) {
        self.player_linkto delete();
        self.player_linkto = undefined;
      }

      self.activator val::reset(#"dialog_tree", "allow_crouch");
      self.activator val::reset(#"dialog_tree", "allow_prone");
      self.activator val::reset(#"dialog_tree", "allow_stand");
      self.activator val::reset(#"dialog_tree", "allow_movement");
    }

    if(!self.allow_weapon) {
      self.activator val::reset(#"dialog_tree", "disable_weapons");
      self.activator val::reset(#"dialog_tree", "disable_offhand_weapons");
    }

    ai_actor flag::clear("_dialog_vo_playing");
    ai_actor flag::clear("_dialog_anim_playing");
    ai_actor flag::clear("_dialog_func_running");
    self.activator val::reset(#"dialog_tree", "ignoreme");
    self.activator val::reset(#"dialog_tree", "takedamage");
    waitframe(1);

    if(isai(ai_actor)) {
      ai_actor val::reset(#"dialog_tree", "ignoreme");
      ai_actor val::reset(#"dialog_tree", "takedamage");
    }

    self notify(#"dialog_tree_end");
    ai_actor notify(#"dialog_tree_end");
    self.activator notify(#"dialog_tree_end");
    globallogic_ui::function_9ed5232e("hudItems.subtitles.noAutoHide", 0);
    level flag::clear("dialog_tree_active");
    level flag::clear("prompts_disabled");
  }

  ai_actor.var_b905c47b--;

  while(ai_actor.var_b905c47b > 0) {
    wait 0.1;
  }

  return last_choice;
}

function function_bfcc8f29() {
  if(self.var_4d84ed71) {
    namespace_82bfe441::fade(0, "FadeFast");
  }

  namespace_61e6d095::function_73c9a490(#"dialog_tree", 0);
  namespace_61e6d095::remove(#"dialog_tree");
  namespace_61e6d095::function_4279fd02(#"dialog_tree");
  objectives::function_4279fd02();
}

function function_6a2674b8() {
  choices = self function_4a2c9dcb();
  return choices.size;
}

function function_a6a75a20() {
  self.ai_actor flag::wait_till("waiting_on_player_choice");
  waitframe(1);
  level notify(#"dialog_tree_option_selected", {
    #optindex: -1
  });
}

function private function_27059a7f(ai_actor, anim_struct) {
  self.activator endon(#"death");
  self endon(#"dialog_tree_end");
  level notify(#"watch_dt_skips");
  level endon(#"watch_dt_skips");

  while(true) {
    self.activator namespace_61e6d095::function_b0bad5ff("dialog_tree_end", "watch_dt_skips");
    bb::function_7977c093(self.scriptbundle, #"ui_cancel", getplayers()[0]);

    if(ai_actor flag::get("_dialog_vo_playing")) {
      if(isDefined(ai_actor.var_e744d1aa)) {
        if(isai(ai_actor)) {
          ai_actor dialogue::function_47b06180();
        } else {
          snd::stop(ai_actor.var_e744d1aa);
        }

        ai_actor.var_e744d1aa = undefined;
        ai_actor notify(#"cancel speaking");
      }
    }

    if(ai_actor flag::get("_dialog_anim_playing") && isDefined(ai_actor._scene_object)) {
      var_45c1f22c = self function_58881e72(self.scriptbundle, ai_actor._scene_object._str_shot, anim_struct);

      if(var_45c1f22c) {
        ai_actor notify(#"dialog_tree_cancel_response");
        anim_struct thread scene::play_from_time(self.scriptbundle, ai_actor._scene_object._str_shot, undefined, getanimlength(ai_actor._scene_object._str_current_anim) - 0.25, 0, 1);
      }
    } else {
      ai_actor notify(#"dialog_tree_cancel_response");
    }

    wait 0.3;
  }
}

function private function_58881e72(sb, str_shot, anim_struct) {
  a_instances = scene::get_active_scenes(sb);

  if(!isarray(a_instances)) {
    return false;
  }

  if(!isarray(a_instances[0].scene_ents)) {
    return false;
  }

  scene_ents = a_instances[0].scene_ents;
  db = {
    #vox: "none", #scn: sb, #skipt: 9999, #ent: undefined, #var_4fc15872: 2.4, #var_30468601: 1, #var_bd15dadd: -1
  };

  foreach(ent in scene_ents) {
    if(!isDefined(ent)) {
      continue;
    }

    if(isDefined(ent._scene_object._str_current_anim)) {
      if(isanimlooping(ent._scene_object._str_current_anim)) {
        continue;
      }

      if(db.var_bd15dadd < 0) {
        db.var_bd15dadd = ent getanimtime(ent._scene_object._str_current_anim);
      }

      anim_len = getanimlength(ent._scene_object._str_current_anim);
      curr_time = ent getanimtime(ent._scene_object._str_current_anim);

      if(abs(curr_time - db.var_bd15dadd) > 0.025) {
        iprintln("<dev string:xba>" + abs(curr_time - db.var_bd15dadd));

        continue;
      }

      notetracks = getnotetracksindelta(ent._scene_object._str_current_anim, 0, 999);

      if(notetracks.size) {
        foreach(notetrack in notetracks) {
          if(notetrack[5] == # "vox") {
            ent.stop_sound = 1;

            if(notetrack[3] > curr_time && notetrack[3] * anim_len < db.skipt) {
              check_time = notetrack[3] * anim_len - 0.1;

              if(check_time < curr_time * anim_len) {
                continue;
              }

              db.ent = ent;
              db.skipt = check_time;
              db.var_30468601 = check_time / anim_len;
              db.var_4fc15872 = notetrack[3] * anim_len;

              db.vox = function_9e72a96(notetrack[6]);
            }
          }
        }
      }
    }
  }

  foreach(ent in scene_ents) {
    if(is_true(ent.stop_sound)) {
      ent stopsounds();
      ent.stop_sound = undefined;
    }
  }

  if(isDefined(db.ent)) {
    anim_struct thread scene::play_from_time(sb, str_shot, undefined, db.var_30468601, 1, 1);
    return false;
  }

  return true;
}

function private function_62d48ab(ai_actor, vo_lines) {
  ai_actor endon(#"death");
  ai_actor endon(#"dialog_tree_end");
  waitframe(1);

  if(!isarray(vo_lines)) {
    vo_lines = [vo_lines];
  }

  for(i = 0; i < vo_lines.size; i++) {
    vo_line = vo_lines[i];

    if(soundexists(vo_line)) {
      if(isai(ai_actor)) {
        ai_actor dialogue::function_47b06180();
        ai_actor.var_e744d1aa = 1;
        ai_actor dialogue::queue(vo_line);
      } else {
        ai_actor.var_e744d1aa = snd::play(vo_line, [ai_actor, "j_head"]);
        snd::function_2fdc4fb(ai_actor.var_e744d1aa);
      }

      continue;
    }

    iprintlnbold(vo_line);
    self.activator waittilltimeout(1.5, #"dialog_tree_cancel_response");
  }

  ai_actor notify(#"hash_48ace2900075b6e8");
  ai_actor.var_e744d1aa = undefined;
  ai_actor flag::clear("_dialog_vo_playing");
}

function private function_d602cdd7(new_option) {
  assert(isarray(self.options));
  option_id = self.options.size;
  self.options[option_id] = new_option;
  return option_id;
}

function private function_98927b7b(parent_id, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog = 0, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func, important = 0, var_84fa2307, var_c275310d, var_50f9a62 = 1) {
  option = spawnStruct();
  option.active = 1;
  option.parent_id = parent_id;
  option.hudstring = option_text;
  option.vo_npc = ai_vo;
  option.anim_npc = ai_anim;
  option.var_59ae859c = var_a0ee58ce;
  option.end_dialog = end_dialog;

  if(isDefined(set_flag) && !isarray(set_flag)) {
    set_flag = [set_flag];
  }

  option.set_flag = set_flag;
  option.var_a16c9b3f = var_a16c9b3f;
  option.var_9ddc06f5 = var_9ddc06f5;
  option.selected_func = selected_func;
  option.func_parameter = func_parameter;
  option.skip_func = skip_func;
  option.important = important;
  option.show_locked = 0;
  option.cur_vo = -1;
  option.cur_anim = -1;
  option.var_84fa2307 = var_84fa2307;
  option.var_c275310d = var_c275310d;
  option.var_50f9a62 = var_50f9a62;
  return option;
}

function private function_b85d5a3a(var_d9d52a9d, var_cf6d95c9 = 4) {
  hudstrings = [];

  for(i = 0; i < var_cf6d95c9; i++) {
    if(isDefined(var_d9d52a9d[i])) {
      option = self.options[var_d9d52a9d[i]];
      var_2ebd3f57 = isDefined(option.var_9ddc06f5) && option.show_locked && !level flag::get(option.var_9ddc06f5);
      hudstrings[i] = {
        #important: option.important, #string: option.hudstring, #locked: var_2ebd3f57
      };
      continue;
    }

    hudstrings[i] = {
      #important: 0, #string: undefined, #locked: 0
    };
  }

  return hudstrings;
}

function private function_a7575efe(func, param, skip_func) {
  self endon(#"dialog_tree_end");

  if(isDefined(skip_func)) {
    self childthread function_49048365(skip_func);
  }

  if(!isDefined(param)) {
    self[[func]]();
  } else {
    self[[func]](param);
  }

  self notify(#"hash_4501fed1970295ab");
  self flag::clear("_dialog_func_running");
}

function private function_49048365(skip_func) {
  self endon(#"dialog_tree_end");
  self endon(#"hash_4501fed1970295ab");
  self waittill(#"dialog_tree_cancel_response");
  self childthread[[skip_func]]();
}

function private function_c331410b(ai_actor, anims, anim_loop, struct, scriptbundle) {
  self endon(#"dialog_tree_end");
  ai_actor endon(#"dialog_tree_choice_made");

  if(isDefined(scriptbundle) && isDefined(anims)) {
    if(!isarray(anims)) {
      anims = [anims];
    }

    self thread function_a5ba53f8(ai_actor);

    for(i = 0; i < anims.size; i++) {
      self thread function_c4ae7ee0(ai_actor, anims[i], struct, scriptbundle);
      self waittill(#"hash_222d1d96d3da9edb", #"hash_711653fb95598c66");
    }
  }

  ai_actor notify(#"hash_12324459eb2bc76d");
  self.var_ebacf97b = undefined;
  ai_actor flag::clear("_dialog_anim_playing");

  if(isDefined(scriptbundle) && isDefined(anim_loop)) {
    struct thread scene::play(scriptbundle, anim_loop, [ai_actor]);
  }
}

function private function_c4ae7ee0(ai_actor, shot_name, struct, scriptbundle) {
  self endon(#"dialog_tree_end");
  self.var_ebacf97b = shot_name;
  struct scene::play(scriptbundle, shot_name, [ai_actor]);
  self notify(#"hash_222d1d96d3da9edb");
}

function private function_a5ba53f8(ai_actor) {
  self.activator endon(#"death");
  ai_actor endon(#"hash_12324459eb2bc76d");
  level waittill(#"hash_3d5358602caccf41");
  ai_actor flag::clear("_dialog_anim_playing");
  ai_actor notify(#"hash_12324459eb2bc76d");
}

function private function_a5440f84(flagname) {
  if(!self flag::exists(flagname)) {
    self flag::init(flagname);
    self flag::clear(flagname);
    return;
  }

  self flag::wait_till_clear(flagname);
}

function private function_4a2c9dcb(max_options) {
  var_d9d52a9d = [];

  for(choice_id = 0; choice_id < self.options.size && (!isDefined(max_options) || var_d9d52a9d.size < max_options); choice_id++) {
    option = self.options[choice_id];

    if(isDefined(option.var_84fa2307) && option.var_84fa2307 > 0) {
      if(self.selected_options == 0 && is_true(option.var_50f9a62)) {
        self.options[choice_id].active = 1;

        if(isDefined(option.var_c275310d)) {
          level flag::clear(option.var_c275310d);
        }
      }

      if(self.selected_options >= option.var_84fa2307 && option.active) {
        self.options[choice_id].active = 0;

        if(isDefined(option.var_c275310d)) {
          level flag::set(option.var_c275310d);
        }
      }
    }

    if(isDefined(option.var_a16c9b3f)) {
      if(option.var_a16c9b3f != "forever" && level flag::get(option.var_a16c9b3f)) {
        self.options[choice_id].active = 0;
      }
    }

    if(!option.active || isDefined(option.var_9ddc06f5) && !level flag::get(option.var_9ddc06f5) && !option.show_locked) {
      choice_id++;
      continue;
    }

    var_d9d52a9d[var_d9d52a9d.size] = choice_id;
  }

  return var_d9d52a9d;
}

function private function_59d38639(parent_id) {
  foreach(option in self.options) {
    if(isDefined(option.parent_id) && option.parent_id == parent_id) {
      option.active = 1;
    }
  }
}

function private function_985e8e32(index) {
  keyinput = index + 1;
  choice_string = "^S " + keyinput + " ^E";
  return choice_string;
}

function private function_8b61aa4c(var_d9d52a9d, ai_actor, var_cf6d95c9 = 4) {
  dialog_strings = function_b85d5a3a(var_d9d52a9d, var_cf6d95c9);
  index = 0;
  choices = [];

  foreach(choice in dialog_strings) {
    if(isDefined(choice.string)) {
      namespace_61e6d095::function_f2a9266(#"dialog_tree", index, "dialogString", choice.string);
      namespace_61e6d095::function_f2a9266(#"dialog_tree", index, "important", choice.important);
      namespace_61e6d095::function_f2a9266(#"dialog_tree", index, "unImportant", choice.locked);
      namespace_61e6d095::function_f2a9266(#"dialog_tree", index, "kbmShortcut", function_985e8e32(index));
      choices[index] = choice;
      index++;
    }
  }

  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "optionSelected", 0, 1, undefined, undefined, 1);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "isActive", 1);

  if(isDefined(self.timeout) && self.timeout > 0) {
    waittillframeend();
    namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "timeOut", self.timeout);
  }

  player = self.activator;
  assert(isPlayer(player));
  ai_actor flag::set("waiting_on_player_choice");
  selected = level waittill(#"dialog_tree_option_selected");
  ai_actor flag::clear("waiting_on_player_choice");
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "isActive", 0);

  if(selected.optindex < 0) {
    level thread function_310d2602(choices, ai_actor, 1);
    return selected.optindex;
  }

  level thread function_310d2602(choices, ai_actor);
  return var_d9d52a9d[selected.optindex];
}

function private function_9ca575ba(choices) {
  self endon(#"death", #"dialog_tree_option_selected", #"disconnect");

  if(isDefined(choices) && isDefined(choices.size)) {
    level.waitingforresponse = 1;
    selectedoption = -1;

    while(level.waitingforresponse) {
      var_dae97dcc = level waittill(#"dialog_tree_kbm_key_selected");

      if(choices.size > 0 && var_dae97dcc.optindex == 1) {
        selectedoption = 0;
        level.waitingforresponse = 0;
      } else if(choices.size > 1 && var_dae97dcc.optindex == 2) {
        selectedoption = 1;
        level.waitingforresponse = 0;
      } else if(choices.size > 2 && var_dae97dcc.optindex == 3) {
        selectedoption = 2;
        level.waitingforresponse = 0;
      } else if(choices.size > 3 && var_dae97dcc.optindex == 4) {
        selectedoption = 3;
        level.waitingforresponse = 0;
      }

      if(!level.waitingforresponse) {
        namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "index", selectedoption, 1, undefined, undefined, 1);
        waitframe(1);
        namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "kbmIndexSelected", selectedoption, 1, undefined, undefined, 1);
        waitframe(1);
        namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "validateListElement", selectedoption, 1, undefined, undefined, 1);
        waitframe(1);
        level notify(#"dialog_tree_option_selected", {
          #optindex: selectedoption
        });
      }

      waitframe(1);
    }
  }
}

function private function_cde38026(old_indices, new_indices, choices) {
  var_c8994f32 = old_indices[0];
  var_d9161f36 = new_indices[0];
  var_1e50dc81 = var_d9161f36;

  while(is_true(choices[var_1e50dc81].locked)) {
    if(var_d9161f36 < var_c8994f32) {
      var_1e50dc81--;
    } else {
      var_1e50dc81++;
    }

    if(var_1e50dc81 < 0 || var_1e50dc81 >= choices.size) {
      var_1e50dc81 = var_c8994f32;
      break;
    }
  }

  if(var_1e50dc81 != var_c8994f32) {
    namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "index", var_1e50dc81, 1, undefined, undefined, 1);
  }

  return [var_1e50dc81, 0];
}

function private function_310d2602(choices, ai_actor, quick_clear = 0) {
  if(!quick_clear) {
    namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "optionSelected", 1, 1);
    wait 1.5;
  }

  if(namespace_61e6d095::exists(#"dialog_tree")) {
    for(i = choices.size - 1; i >= 0; i--) {
      namespace_61e6d095::function_7239e030(#"dialog_tree", i);
    }
  }

  ai_actor flag::clear("_dialog_ui_animating");
}

function private function_43bca3cb(position, state_index) {
  namespace_61e6d095::create(#"dialog_tree", #"hash_5ee7619b9b614d34");
  namespace_61e6d095::set_x(#"dialog_tree", position[0]);
  namespace_61e6d095::set_y(#"dialog_tree", position[1]);
  namespace_61e6d095::function_330981ed(#"dialog_tree");
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "index", 0);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "timeOut", 0);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "stateIndex", state_index);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "optionSelected", 0);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "kbmIndexSelected", -1);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "isActive", 0);
  namespace_61e6d095::function_73c9a490(#"dialog_tree", 1);
  namespace_61e6d095::function_24e5fa63(#"dialog_tree", [# "ui_confirm", #"ui_cancel"], 1);
  self.activator clientfield::set_to_player("dt_set_hide_reticle_dot", 1);
}
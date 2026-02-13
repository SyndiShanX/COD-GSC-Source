/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\objective_assault.gsc
****************************************************/

init() {
  _id_0987::_id_C215("assault", ::_id_7FBE, ::setup, ::_id_8CE4, ::_id_385C, "assault", undefined, undefined, 15, undefined, undefined, ::on_player_spawned);
  level._effect["assault_rift_temp"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_obelisk_rune.vfx");
  level._effect["assault_rift"] = loadfx("vfx/s4/zombie/vfx_ritual_rift.vfx");
  level._effect["assault_ritual_site_destroyed"] = loadfx("vfx/s4/zombie/vfx_ritual_transform.vfx");
  level._effect["assault_ritual_site_idle"] = loadfx("vfx/s4/zombie/vfx_ritual_idle.vfx");
  level._effect["assault_ritual_site_idle_ray_child"] = loadfx("vfx/s4/zombie/vfx_ritual_idle_ray_child.vfx");
  level._effect["assault_ritual_site_idle_mouth"] = loadfx("vfx/s4/zombie/vfx_ritual_idle_mouth.vfx");
  level._effect["assault_ritual_site_cleared"] = loadfx("vfx/s4/zombie/vfx_ritual_cleared.vfx");
  level._effect["assault_ritual_site_cleared_ray_child"] = loadfx("vfx/s4/zombie/vfx_ritual_cleared_ray_child.vfx");
  level._effect["assault_ritual_site_cleared_mouth"] = loadfx("vfx/s4/zombie/vfx_ritual_cleared_mouth.vfx");
  level._effect["assault_rift_spawn"] = loadfx("vfx/s4/zombie/vfx_obj_domination_portal_air_collapse.vfx");
  level._effect["assault_sacrifice_zombie"] = loadfx("vfx/s4/zombie/vfx_ritual_sacrificing.vfx");
  level._effect["assault_zombie_sacrificed"] = loadfx("vfx/s4/zombie/vfx_ritual_sacrifice.vfx");
  level._effect["assault_zombie_sacrificed_soul_trail"] = loadfx("vfx/s4/zombie/vfx_ritual_sacrifice.vfx");
  level._effect["assault_sacrifice_zombie_trail"] = loadfx("vfx/s4/zombie/vfx_ritual_attack_trail.vfx");
  level._effect["assault_next_ritual_site_beam"] = loadfx("vfx/iw7/core/zombie/magicwheel/vfx_magicwheel_beam_rnr.vfx");
  level._effect["assault_failure_explosion"] = loadfx("vfx/s4/zombie/vfx_ritual_fail.vfx");
  level._effect["s2_mq_dormant_shield_ambient"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor");
  level._effect["s2_mq_dormant_shield_energy_trail"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_tome_page_shield_anchor_trail");
  level._effect["s2_mq_shield_portal_ambient_fx"] = loadfx("vfx/s4/level/cp_zm_skorpion/vfx_hub_portal_shield_green");
  level._effect["s2_mq_shield_portal_outro_fx"] = loadfx("vfx/s4/level/cp_zm_skorpion/vfx_hub_portal_shield_end_green");
  level.objective_assault_syphoncore_fx_mouth_tags = ["tag_fx_mouth_1", "tag_fx_mouth_2", "tag_fx_mouth_3"];
  register_zombie_entry_triggers();
}

_id_7FBE(var_0) {
  var_0._id_0DF6 = var_0._id_3BE8["teleport_pt"];
  var_0._id_0DF7 = var_0._id_3BE8["zombie_spawn"];
  var_0._id_529C = 1;
}

init_ritual_sites(var_0) {
  var_0.ritual_sites = [];
  var_0.ritual_sites = scripts\engine\utility::array_combine(var_0._id_3BE8["ritual_site_1"], var_0._id_3BE8["ritual_site_2"], var_0._id_3BE8["ritual_site_3"]);
  var_0.ritual_site_clip = [];
  var_0.ritual_site_clip["ritual_site_1"] = [];
  var_0.ritual_site_clip["ritual_site_2"] = [];
  var_0.ritual_site_clip["ritual_site_3"] = [];
  var_1 = getEntArray("assault_objective_clip_prop_top", "targetname");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      var_0.ritual_site_clip[var_3._id_039B]["top"] = var_3;
    }
  }

  var_5 = getEntArray("assault_objective_clip_prop_bottom", "targetname");

  if(var_5.size > 0) {
    foreach(var_3 in var_5) {
      var_0.ritual_site_clip[var_3._id_039B]["bottom"] = var_3;
    }
  }

  for(var_8 = 0; var_8 < var_0.ritual_sites.size; var_8++) {
    var_9 = var_0.ritual_sites[var_8];
    var_9.array_index = var_8;
    var_9.initial_index = var_8;
    var_9.being_attacked = 0;
    var_9.ritual_site_model = _id_06EF::_id_E1E5(var_9, "zmb_syphoncore_wholebody_idle", 0);
    var_9.ritual_site_model _meth_82CB("ai_s4_zm_zombie_syphoncore_idle_01");
    var_9.ritual_site_model _meth_80B5();
    var_9.ritual_site_model solid();
    var_9.health = 5;
    var_9._id_9C21 = 5;
    var_9.sacrifice_locations = var_9._id_3BE8["zombie_sacrifice_location"];
    var_9.available_sacrifice_locations = var_9.sacrifice_locations;
    var_9.is_destroyed = 0;
    var_9.ritual_site_model playLoopSound("zmb_ritual_site_amb_lp");

    if(_func_0107(var_0.ritual_site_clip[var_9._id_3BE4])) {
      var_10 = var_0.ritual_site_clip[var_9._id_3BE4]["top"];
      var_10.origin = var_9.ritual_site_model.origin + (0, 0, 112);
      var_10 show();
      var_10 _meth_80B5();
      var_11 = var_0.ritual_site_clip[var_9._id_3BE4]["bottom"];
      var_11.origin = var_9.ritual_site_model.origin + (0, 0, 46);
      var_11 show();
      var_11 _meth_80B5();
    }

    for(var_12 = 0; var_12 < var_9.sacrifice_locations.size; var_12++) {
      var_13 = var_9.sacrifice_locations[var_12];
      var_13._id_A926 = 0;
      var_13.array_index = var_12;
    }
  }

  var_0.available_ritual_sites = var_0.ritual_sites;
  var_0 add_ritual_site_mini_map_icons();
}

select_ritual_site_target(var_0, var_1) {
  level endon("game_ended");
  level endon("objective_ended");
  var_0 endon("objective_ended");
  var_0 endon("assault_ended");
  var_0 endon("ritual_site_destroyed");
  level endon("assault_ended");

  if(!istrue(var_1) && isDefined(var_0.assault_start_time)) {
    var_2 = (gettime() - var_0.assault_start_time) / 1000;
    var_3 = 180 - var_2;

    if(var_3 < 27) {
      return;
    }
  }

  if(istrue(var_0.complete)) {
    return;
  }
  var_0.should_play_ritual_site_vo = 1;
  release_all_sacrifice_zombies(var_0);
  var_0.selecting_next_ritual_site = 1;
  var_4 = 0;
  var_5 = var_0._id_3BE8["ritual_site_1"][var_4];
  var_6 = 1;
  var_0.ritual_site_moves = scripts\cp\utility::_id_459B(var_0.ritual_site_moves, 0);

  if(isDefined(var_0.ritual_site_target)) {
    var_0.ritual_site_moves++;
    var_6 = 0;

    if(var_0.available_ritual_sites.size > 0 && var_0.ritual_site_moves >= var_0.ritual_sites.size) {
      var_4 = randomint(var_0.available_ritual_sites.size);
    }

    var_5 = var_0.available_ritual_sites[var_4];

    if(!istrue(var_0.ritual_site_target.is_destroyed)) {
      var_0.available_ritual_sites = scripts\engine\utility::array_add(var_0.available_ritual_sites, var_0.ritual_site_target);
      var_0.ritual_site_target.array_index = var_0.available_ritual_sites.size - 1;
    }
  }

  var_0.available_ritual_sites = scripts\engine\utility::array_remove_index(var_0.available_ritual_sites, var_4);

  if(isDefined(var_5.ritual_site_model)) {
    var_5.ritual_site_model playSound("zmb_obelisk_finale");
  }

  if(!istrue(var_6) && istrue(var_0.b_is_quest) && !istrue(var_0.b_played_syph_vo)) {
    level thread play_switch_target_vo(var_0);
    var_0.b_played_syph_vo = 1;
  }

  var_0 notify("new_ritual_site_target");

  if(!istrue(var_6)) {
    wait 5;
  }

  var_0.ritual_site_selected_time = gettime();

  if(istrue(var_6)) {
    var_0.available_ritual_sites = scripts\engine\utility::array_randomize(var_0.available_ritual_sites);
    var_0.ritual_site_selected_time = -100000;
  } else if(!istrue(var_1)) {
    foreach(var_8 in level.players) {
      var_8 thread _id_0752::_id_7003("objective_assault_syphoncore_defend");
    }
  }

  if(!isDefined(var_0.ritual_site_target)) {
    var_0.ritual_site_target = var_5;
    var_0 thread add_ritual_site_marker();
  } else {
    if(!istrue(var_1)) {
      level thread play_ritual_site_cleared_fx(var_0, var_0.ritual_site_target);
      play_ritaul_site_head_clear_fx(var_0.ritual_site_target, var_0);
    }

    if(is_s2_mq_event(var_0)) {
      _id_0987::set_objective_ui_state(7, 1, 4);
    } else {
      _id_0987::set_objective_ui_state(6, 1, 4);
    }

    var_0.ritual_site_target.is_current_target = 0;

    if(isDefined(var_0.ritual_site_target.ritual_site_model)) {
      stopFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_idle"), var_0.ritual_site_target.ritual_site_model, "tag_origin");

      if(!istrue(var_0.ritual_site_target.is_destroyed) && isDefined(var_0.ritual_site_target.ritual_site_model)) {
        var_0.ritual_site_target.ritual_site_model delete();
        var_0.ritual_site_target.ritual_site_model = _id_06EF::_id_E1E5(var_0.ritual_site_target, "zmb_syphoncore_wholebody_idle", 0);
        var_0.ritual_site_target.ritual_site_model _meth_82CB("ai_s4_zm_zombie_syphoncore_idle_01");
        var_0.ritual_site_target.ritual_site_model _meth_80B5();
        var_0.ritual_site_target.ritual_site_model solid();
      }
    }

    if(isDefined(var_0.ritual_site_target)) {
      var_0.ritual_site_target.being_attacked = 0;
    }

    var_0.ritual_site_target = var_5;
    var_0 thread switch_ritual_site_marker();
  }

  if(!istrue(var_0.ritual_site_target.is_destroyed) && isDefined(var_0.ritual_site_target.ritual_site_model)) {
    var_0.ritual_site_target.ritual_site_model stoploopsound("zmb_ritual_site_amb_lp");
    var_0.ritual_site_target.ritual_site_model delete();
    var_0.ritual_site_target.ritual_site_model = _id_06EF::_id_E1E5(var_0.ritual_site_target, "zmb_syphoncore_wholebody", 0);
    var_0.ritual_site_target.ritual_site_model _meth_82CB("ai_s4_zm_zombie_syphoncore_activated_01");
    var_0.ritual_site_target.ritual_site_model _meth_81B0("outline_objective_syphoncore");
    var_0.ritual_site_target.ritual_site_model _meth_80B5();
    var_0.ritual_site_target.ritual_site_model solid();
    var_0.ritual_site_target.ritual_site_model playLoopSound("zmb_ritual_site_amb_lp");
    toggle_ritual_site_head_fx(var_0.ritual_site_target, var_0, 1);
  }

  if(isDefined(var_0.ritual_site_target.ritual_site_model) && !istrue(var_6)) {
    var_0.ritual_site_target.ritual_site_model playSound("zmb_ritual_site_active_stinger");
  }

  var_0.ritual_site_target.available_sacrifice_locations = var_0.ritual_site_target.sacrifice_locations;
  var_0.ritual_site_target.is_current_target = 1;

  if(isDefined(var_0.ritual_site_target.ritual_site_model)) {
    playFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_idle"), var_0.ritual_site_target.ritual_site_model, "tag_origin");
  }

  if(isDefined(var_0.current_intensity) && !istrue(var_0.complete)) {
    var_0 notify("stop_wave_manager");
    waitframe();
    level thread _id_0991::_id_E8E2(0);
    wait 2;
    level thread _id_0991::_id_C9FC(var_0.current_intensity, undefined, var_0.ritual_site_target._id_3BE8["spawn_manager_spawner"], 1);
    waitframe();
    var_0 thread _id_9A14();
  }

  var_0.selecting_next_ritual_site = 0;

  if(var_0.available_ritual_sites.size > 0) {
    var_0 thread ritual_site_target_manager();
  }
}

toggle_ritual_site_head_fx(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.ritual_site_model)) {
    return;
  }
  foreach(var_4 in level.objective_assault_syphoncore_fx_mouth_tags) {
    if(istrue(var_2)) {
      playFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_idle_mouth"), var_0.ritual_site_model, var_4);
      continue;
    }

    stopFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_idle_mouth"), var_0.ritual_site_model, var_4);
  }
}

play_ritaul_site_head_clear_fx(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.ritual_site_model)) {
    return;
  }
  foreach(var_3 in level.objective_assault_syphoncore_fx_mouth_tags) {
    playFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_cleared_mouth"), var_0.ritual_site_model, var_3);
  }
}

play_ritual_site_flicker_fx(var_0, var_1) {
  if(!isDefined(var_1.ritual_site_model) || isDefined(var_1.ritual_site_cleared_fx_mdl)) {
    return;
  }
  var_1.ritual_site_flicker_fx_mdl = _id_06EF::_id_E1E5(var_1, "tag_origin", 0);
  var_2 = 3;
  var_3 = 0;

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_cleared"), var_1.ritual_site_flicker_fx_mdl, "tag_origin");
    wait 0.5;
    stopFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_cleared"), var_1.ritual_site_flicker_fx_mdl, "tag_origin");
    wait 1.5;
    var_3++;

    if(var_3 >= var_2) {
      break;
    }
  }

  stopFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_cleared"), var_1.ritual_site_flicker_fx_mdl, "tag_origin");
  var_1.ritual_site_flicker_fx_mdl delete();
}

play_ritual_site_cleared_fx(var_0, var_1) {
  if(!isDefined(var_1.ritual_site_model) || isDefined(var_1.ritual_site_cleared_fx_mdl)) {
    return;
  }
  var_1.ritual_site_cleared_fx_mdl = _id_06EF::_id_E1E5(var_1, "tag_origin", 0);
  playFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_cleared"), var_1.ritual_site_cleared_fx_mdl, "tag_origin");
  wait 3;
  stopFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_cleared"), var_1.ritual_site_cleared_fx_mdl, "tag_origin");
  var_1.ritual_site_cleared_fx_mdl delete();
}

add_ritual_site_mini_map_icons() {
  foreach(var_1 in self.ritual_sites) {
    var_2 = spawnStruct();
    var_2._id_E747 = "active";
    var_2.setbackground = 5;
    var_2.team = "allies";
    var_2._id_96CF = var_1.origin;
    var_3 = 0;

    if(scripts\engine\utility::is_equal(var_1._id_3BE4, self.ritual_sites[0]._id_3BE4)) {
      var_3 = 3;
    }

    var_2._id_7C3B = getsiteminimapicon(var_1._id_3BE4, var_3);
    var_2.minimapiconsize = "icon_regular";
    var_1.markerlabel = "ritual_site_mini_map_" + var_1.initial_index;
    var_1.instanceindex = _id_0987::add_instanced_objective_marker(var_1.markerlabel, var_2);
  }
}

remove_ritual_site_mini_map_icons() {
  foreach(var_1 in self.ritual_sites) {
    if(!var_1.is_destroyed) {
      _id_0987::remove_instanced_objective_marker(var_1.markerlabel, var_1.instanceindex);
    }
  }
}

update_ritual_site_mini_map_icons() {
  foreach(var_1 in self.ritual_sites) {
    if(var_1.is_destroyed) {
      continue;
    }
    _id_0987::remove_instanced_objective_marker(var_1.markerlabel, var_1.instanceindex);
    var_2 = spawnStruct();
    var_3 = 0;

    if(scripts\engine\utility::is_equal(self.ritual_site_target._id_3BE4, var_1._id_3BE4)) {
      if(var_1.being_attacked) {
        var_3 = 5;
      } else {
        var_3 = 3;
      }
    }

    var_2._id_E747 = "active";
    var_2.setbackground = 5;
    var_2.team = "allies";
    var_2._id_96CF = var_1.origin;
    var_2.minimapiconsize = "icon_regular";
    var_2._id_7C3B = getsiteminimapicon(var_1._id_3BE4, var_3);
    var_1.instanceindex = _id_0987::add_instanced_objective_marker(var_1.markerlabel, var_2);
  }
}

getsiteminimapicon(var_0, var_1) {
  var_2 = " ";

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return var_2;
  }

  if(var_1 == 0) {
    switch (var_0) {
      case "ritual_site_1":
        var_2 = "v_ui_icon_minimap_a_graybacking";
        break;
      case "ritual_site_2":
        var_2 = "v_ui_icon_minimap_b_graybacking";
        break;
      case "ritual_site_3":
        var_2 = "v_ui_icon_minimap_c_graybacking";
        break;
    }
  } else if(var_1 == 5) {
    switch (var_0) {
      case "ritual_site_1":
        var_2 = "v_ui_icon_minimap_a_redbacking";
        break;
      case "ritual_site_2":
        var_2 = "v_ui_icon_minimap_b_redbacking";
        break;
      case "ritual_site_3":
        var_2 = "v_ui_icon_minimap_c_redbacking";
        break;
    }
  } else if(var_1 == 3) {
    switch (var_0) {
      case "ritual_site_1":
        var_2 = "v_ui_icon_minimap_a_whitebacking";
        break;
      case "ritual_site_2":
        var_2 = "v_ui_icon_minimap_b_whitebacking";
        break;
      case "ritual_site_3":
        var_2 = "v_ui_icon_minimap_c_whitebacking";
        break;
    }
  }

  return var_2;
}

add_ritual_site_marker() {
  var_0 = spawnStruct();
  var_0._id_E747 = "current";
  var_0.label = "";
  var_0._id_96CF = self.ritual_site_target.origin;
  var_0._id_11012 = 110;

  switch (self.ritual_site_target._id_3BE4) {
    case "ritual_site_1":
      var_0._id_7C3B = "v_ui_icon_objective_a";
      break;
    case "ritual_site_2":
      var_0._id_7C3B = "v_ui_icon_objective_b";
      break;
    case "ritual_site_3":
      var_0._id_7C3B = "v_ui_icon_objective_c";
      break;
    default:
      var_0._id_7C3B = "v_ui_icons_zombies_minimap_objective";
      break;
  }

  var_0.minimapiconsize = "icon_regular";
  var_0.setbackground = 0;
  var_0.team = "allies";
  var_0.showsdistance = 0;
  self.ritualsitemarkernum = _id_0987::_id_0FFD("assault_ritual_site_marker", var_0);
  waitframe();
  var_0 = spawnStruct();
  var_0._id_E747 = "invisible";
  var_0._id_96CF = self.ritual_site_target.origin;
  var_0._id_11012 = 110;
  _id_0987::_id_FB90(self.ritualsitemarkernum, var_0);

  if(isDefined(self.ritual_site_target)) {
    _id_0987::set_objective_target_id(self.ritual_site_target.initial_index);
  }
}

switch_ritual_site_marker() {
  level endon("game_ended");
  level endon("objective_ended");
  self endon("assault_ended");
  var_0 = spawnStruct();
  var_0._id_E747 = "invisible";
  var_0.label = "";
  var_0.setbackground = 0;
  var_0.team = "allies";

  switch (self.ritual_site_target._id_3BE4) {
    case "ritual_site_1":
      var_0._id_7C3B = "v_ui_icon_objective_a";
      break;
    case "ritual_site_2":
      var_0._id_7C3B = "v_ui_icon_objective_b";
      break;
    case "ritual_site_3":
      var_0._id_7C3B = "v_ui_icon_objective_c";
      break;
    default:
      var_0._id_7C3B = "v_ui_icons_zombies_minimap_objective";
      break;
  }

  _id_0987::_id_FB90(self.ritualsitemarkernum, var_0);

  if(isDefined(self.ritual_site_target)) {
    _id_0987::set_objective_target_id(self.ritual_site_target.initial_index);
    self.ritual_site_target.being_attacked = 0;
    update_ritual_site_mini_map_icons();
    _id_0987::set_objective_target_color_id(0);
  }

  update_ritual_site_marker(var_0);
}

update_ritual_site_marker(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
  }

  var_0._id_E747 = "invisible";
  var_0._id_96CF = self.ritual_site_target.origin;
  var_0._id_11012 = 110;
  _id_0987::set_objective_ui_bar_progress_numerical(self.ritual_site_target._id_9C21 - self.ritual_site_target.health, self.ritual_site_target._id_9C21);
  _id_0987::set_objective_ui_bar_progress(1 - self.ritual_site_target.health / self.ritual_site_target._id_9C21);

  if(scripts\engine\utility::is_equal(self.ritual_site_target.health, self.ritual_site_target._id_9C21)) {
    var_0._id_BD95 = 0.99;
  }

  _id_0987::_id_FB90(self.ritualsitemarkernum, var_0);
}

cleanup_marker() {
  _id_0987::set_objective_show_subtext(0);
  _id_0987::_id_C413("assault_ritual_site_marker", self.ritualsitemarkernum);
  waitframe();
  self.ritualsitemarkernum = undefined;
}

setup(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, var_0);
  var_0.selected_sacrifice_zombie_time = 0;
  var_0.zombies_for_sacrifice = [];
  var_0.zombies_sacrificing = [];
  _id_06CB::_id_0FA4("zm_spawn_manager_zombie_spawned", ::on_zombie_spawned, undefined, var_1);
  init_ritual_sites(var_0);
  var_0.played_first_drain_narration = 0;
  var_0.played_second_drain_narration = 0;
  var_0.played_third_drain_narration = 0;
}

_id_8CE4(var_0, var_1) {
  var_0 notify("teleport_go");
  var_0 notify("assault_go");
  level notify("assault_start");
  level.b_perfect_finish_assault = 1;
  level thread _id_0987::kill_all_objective_zombies();
  var_0.rifts_opened = 0;
  level thread _id_0991::_id_E8E2(1);
  _func_01E3("assault");
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(var_0._id_3BE8["prop"], 1);
  _id_06CB::_id_AA4A(::_id_AA6D);
  level.current_instance = var_0;
  thread play_kickoff_vo(var_0);
  var_0 thread _id_1CE0();

  if(is_s2_mq_event(var_0)) {
    level._id_A52A = 1;
  }
}

_id_1CE0() {
  self endon("players_dead");
  self endon("objective_ended");
  level endon("objective_ended");
  level endon("game_ended");

  if(is_s2_mq_event(self)) {
    level init_dormant_shield(self);
    wait 1.5;
    zabala_intro();
  }

  self.assault_start_time = gettime();
  level select_ritual_site_target(self);
  thread _id_9A14();

  if(is_s2_mq_event(self)) {
    thread setup_s2_mq_ui();
  } else {
    thread setup_assault_ui();
  }

  thread manage_time_narration();

  if(is_s2_mq_event(self)) {
    thread s2_mq_victory_watcher();
  } else {
    manage_time_victory();
  }
}

setup_assault_ui() {
  _id_0987::set_objective_ui_time(180);
  _id_0987::set_objective_ui_state(6, 0, 1);
  _id_0987::set_objective_ui_bar_progress_numerical(0, 5);
  _id_0987::set_objective_ui_bar_progress(0);
  _id_0987::set_objective_show_subtext(1);
  _id_0987::set_objective_target_color_id(0);
  _id_0987::set_objective_phase_count(self.available_ritual_sites.size, self.ritual_sites.size);
}

manage_time_victory() {
  if(istrue(self.b_is_quest)) {
    thread play_25_pct_time_vo();
  }

  _id_0987::_id_E65C(180, "assault");
  _id_0987::set_objective_ui_state(6, 0, 2);
  level thread assault_complete(1, self);
}

play_25_pct_time_vo() {
  level endon("game_ended");
  self endon("objective_ended");
  level endon("objective_ended");
  level endon("assault_ended");
  var_0 = int(45.0);
  wait(var_0);
  thread _id_0720::play_narration("zm_cqas_oqas_vrcn_aq25");
  level waittill("dialogue_finished");
}

_id_9A14() {
  self endon("players_dead");
  level endon("game_ended");
  self endon("objective_ended");
  level endon("objective_ended");
  level endon("assault_ended");
  self endon("assault_ended");
  self endon("stop_wave_manager");
  self.current_intensity = scripts\cp\utility::_id_459B(self.current_intensity, 0);

  for(;;) {
    var_0 = (gettime() - self.assault_start_time) / 1000;

    if(isint(self.current_intensity) && scripts\engine\utility::is_equal(self.current_intensity, 0)) {
      level thread _id_0991::_id_E8E2(0);
      waitframe();
      level thread _id_0991::_id_C9FC("cp_zm_zod_assault_intensity_01", undefined, self.ritual_site_target._id_3BE8["spawn_manager_spawner"], 1);
      self.current_intensity = "cp_zm_zod_assault_intensity_01";
    } else if(scripts\engine\utility::is_equal(self.current_intensity, "cp_zm_zod_assault_intensity_01") && var_0 > 60.0) {
      level thread _id_0991::_id_E8E2(0);
      waitframe();
      level thread _id_0991::_id_C9FC("cp_zm_zod_assault_intensity_02", undefined, self.ritual_site_target._id_3BE8["spawn_manager_spawner"], 1);
      self.current_intensity = "cp_zm_zod_assault_intensity_02";
    } else if(scripts\engine\utility::is_equal(self.current_intensity, "cp_zm_zod_assault_intensity_02") && var_0 > 120.0) {
      level thread _id_0991::_id_E8E2(0);
      waitframe();
      level thread _id_0991::_id_C9FC("cp_zm_zod_assault_intensity_03", undefined, self.ritual_site_target._id_3BE8["spawn_manager_spawner"], 1);
      self.current_intensity = "cp_zm_zod_assault_intensity_03";
    } else if(scripts\engine\utility::is_equal(self.current_intensity, "cp_zm_zod_assault_intensity_03") && var_0 > 180.0) {
      if(!is_s2_mq_event(self)) {
        level thread _id_0991::_id_E8E2(0);
      }

      return;
    }

    wait 0.1;
  }
}

ritual_site_target_manager() {
  self endon("players_dead");
  level endon("game_ended");
  level endon("objective_ended");
  self endon("objective_ended");
  self endon("new_ritual_site_target");
  self endon("ritual_site_destroyed");
  self endon("assault_ended");

  for(;;) {
    self.ritual_site_attack_duration = randomintrange(30, 40);
    wait(self.ritual_site_attack_duration);
    var_0 = (gettime() - self.assault_start_time) / 1000;
    var_1 = 180 - var_0;

    if(var_1 > 33) {
      level thread queue_ritual_site_target(self);
    }

    return;
  }
}

queue_ritual_site_target(var_0) {
  var_0 endon("players_dead");
  level endon("game_ended");
  level endon("objective_ended");
  var_0 endon("objective_ended");
  var_0 endon("new_ritual_site_target");
  var_0 endon("ritual_site_destroyed");
  var_0 endon("assault_ended");

  if(istrue(var_0.selecting_next_ritual_site)) {
    return;
  }
  for(;;) {
    if(_func_0107(var_0.zombies_sacrificing) && var_0.zombies_sacrificing.size == 0) {
      level thread select_ritual_site_target(var_0);
      return;
    }

    wait 1;
  }
}

on_zombie_spawned(var_0, var_1) {
  var_1 endon("assault_ended");
  var_1.last_zombie_spawn_time = gettime();
  var_1 notify("assault_zombie_spawned");

  if(isDefined(var_0) && isDefined(var_0._id_122C) && isDefined(var_1) && (var_0._id_122C._id_1210 == "actor_enemy_base_zombie_cp" || var_0._id_122C._id_1210 == "actor_enemy_base_zombie_skorpion_cp" || var_0._id_122C._id_1210 == "actor_enemy_base_zombie_sumpf_cp")) {
    if(isDefined(var_1.rifts_opened) && var_1.rifts_opened > 0 && isDefined(var_0._id_122C.override_spawn_info) && scripts\engine\utility::is_equal(var_0._id_122C.override_spawn_info.spawn_tag, "rift_spawn")) {
      var_0._id_122C thread setup_rift_spawn_zombie_fx();
      var_1.last_rift_zombie_spawn_time = gettime();
      var_0._id_122C[[var_0._id_122C._id_D603]]("super_sprint");
    }

    if(isDefined(var_1.ritual_site_target) && _func_0107(var_1.ritual_site_target.available_sacrifice_locations) && var_1.ritual_site_target.available_sacrifice_locations.size > 0 && !istrue(var_1.ritual_site_target.is_destroyed) && !isDefined(var_0._id_122C.override_spawn_info) && isDefined(var_1.ritual_site_selected_time) && var_1.ritual_site_selected_time < gettime() - 6000 && isDefined(var_1.selected_sacrifice_zombie_time) && var_1.selected_sacrifice_zombie_time < gettime() - 750) {
      var_0._id_122C thread set_zombie_ritual_site_target(var_1, 1);
    }
  }

  var_1 thread zombie_spawn_watcher();
}

zombie_spawn_watcher() {
  self endon("assault_zombie_spawned");
  self endon("ritual_site_destroyed");
  self endon("new_ritual_site_target");
  self endon("players_dead");
  self endon("assault_ended");
  level endon("game_ended");
  level endon("objective_ended");

  for(;;) {
    if(isDefined(self.last_zombie_spawn_time) && self.last_zombie_spawn_time < gettime() - 5500) {
      thread force_sacrifice_random_zombie();
    }

    wait 1;
  }
}

setup_rift_spawn_zombie_fx() {
  self endon("death");
  self endon("disconnect");
  self endon("damage");
  self endon("combat_alerted");

  if(isDefined(self.override_spawn_info.ritual_struct)) {
    var_0 = scripts\engine\utility::getfx("assault_rift_spawn");
    playFXOnTag(var_0, self.override_spawn_info.rift_struct.rift_model, "tag_origin");
    self.override_spawn_info.rift_struct.rift_model playSound("zmb_dom_orb_tentacle_spawn");
  }

  self waittill("intro_vignette_done");
}

_id_AA6D(var_0) {
  if(isDefined(self.ritual_site_sacrifice_location) && isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "assault") && !istrue(level._id_3BE9._id_0F51.complete)) {
    var_1 = level._id_3BE9._id_0F51;

    if(istrue(self.sacrificed) || istrue(self.ritual_site_annihilate)) {
      self._id_5FF5 = 1;
      self._id_A546 = 1;
      var_2 = self gettagorigin("j_spine4");
      playFX(scripts\engine\utility::getfx("assault_zombie_sacrificed"), var_2);
      level thread sacrifice_zombie_energy_think(var_1, self, var_1.ritual_site_target, "assault_zombie_sacrificed_soul_trail", var_2, 1);
      self _meth_81AD();
    }

    if(isDefined(self.targeted_ritual_site)) {
      var_1.zombies_for_sacrifice = scripts\engine\utility::array_remove(var_1.zombies_for_sacrifice, self);
      var_1.zombies_sacrificing = scripts\engine\utility::array_remove(var_1.zombies_sacrificing, self);

      if(var_1.zombies_sacrificing.size <= 0) {
        var_3 = spawnStruct();
        var_3.setbackground = 0;
        var_3.label = "";
        var_3.team = "allies";
        self.targeted_ritual_site.being_attacked = 0;
        var_1 update_ritual_site_mini_map_icons();
        _id_0987::set_objective_target_color_id(0);
        _id_0987::_id_FB90(var_1.ritualsitemarkernum, var_3);
      }

      self.targeted_ritual_site.available_sacrifice_locations = scripts\engine\utility::array_add(self.targeted_ritual_site.available_sacrifice_locations, self.ritual_site_sacrifice_location);
      self.ritual_site_sacrifice_location.array_index = level._id_3BE9._id_0F51.ritual_site_target.available_sacrifice_locations.size - 1;
    }
  }
}

set_zombie_ritual_site_target(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("assault_ended");
  var_0 endon("new_ritual_site_target");
  var_0 endon("ritual_site_destroyed");
  var_0.selected_sacrifice_zombie_time = gettime();
  var_0.zombies_for_sacrifice = scripts\cp\utility::_id_459B(var_0.zombies_for_sacrifice, []);
  var_0.zombies_for_sacrifice = scripts\engine\utility::array_add(var_0.zombies_for_sacrifice, self);

  if(istrue(var_1)) {
    self waittill("intro_vignette_done");
  }

  if(!isDefined(var_0.ritual_site_target) || istrue(self.targeting_ritual_site) || istrue(self._id_86F2)) {
    var_0.zombies_for_sacrifice = scripts\engine\utility::array_remove(var_0.zombies_for_sacrifice, self);
    return;
  }

  self.ritual_site_sacrifice_location = var_0.ritual_site_target get_ritual_site_sacrifice_location();

  if(!isDefined(self.ritual_site_sacrifice_location)) {
    var_0.zombies_for_sacrifice = scripts\engine\utility::array_remove(var_0.zombies_for_sacrifice, self);
    return;
  }

  self.targeted_ritual_site = var_0.ritual_site_target;
  self.targeting_ritual_site = 1;
  self notify("zombie_selected_for_sacrifice");
  var_2 = _func_02AB(self.ritual_site_sacrifice_location.origin);

  while(isDefined(self._id_86ED) && self._id_86ED) {
    waitframe();
  }

  var_3 = var_0 get_sacrifice_zombie_run_speed();
  self.movement_speed = var_3;
  playFXOnTag(level._effect["assault_sacrifice_zombie"], self, "j_spine4");
  self[[self._id_D603]](var_3);
  self._id_0229 = 1;
  self _meth_8326(var_2);
  self._id_CF4A = 1;
  self._id_0043 = 0;
  self.brain_rot_immune = 1;
  thread ritual_site_zombie_watcher(var_0);
}

get_sacrifice_zombie_run_speed() {
  var_0 = randomfloat(100);

  if(var_0 < 25) {
    return "run";
  }

  return "super_sprint";
}

get_ritual_site_sacrifice_location() {
  if(self.available_sacrifice_locations.size == 0) {
    return undefined;
  }

  var_0 = randomint(self.available_sacrifice_locations.size);
  var_1 = self.available_sacrifice_locations[var_0];
  self.available_sacrifice_locations = scripts\engine\utility::array_remove_index(self.available_sacrifice_locations, var_0);
  return var_1;
}

ritual_site_zombie_watcher(var_0) {
  self endon("death");
  var_0 endon("players_dead");
  level endon("game_ended");
  level endon("objective_ended");
  var_0 endon("assault_ended");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    wait 0.1;
    var_5 = scripts\aitypes\zombie_common\ai_util::get_door_in_path();
    _id_08F1::setdoortoopen(var_5);

    if(!isDefined(self.ritual_site_sacrifice_location) || istrue(var_0.complete)) {
      return;
    }
    if(!isDefined(self.targeted_ritual_site) || !scripts\engine\utility::is_equal(self.targeted_ritual_site, var_0.ritual_site_target)) {
      release_sacrifice_zombie();
      return;
    }

    if(istrue(var_0.complete)) {
      return;
    }
    var_6 = distancesquared(self.origin, self.ritual_site_sacrifice_location.origin);

    if(scripts\engine\utility::is_equal(var_1, 0)) {
      var_4 = var_6;
    }

    var_1++;

    if(var_1 > 3) {
      var_1 = 0;
      var_2 = abs(var_6 - var_4);

      if(var_2 < 16) {
        var_3 = 1;
      }
    }

    if(var_6 < 324 || var_6 < 4096 && istrue(var_3)) {
      level thread sacrifice_zombie_energy_think(var_0, self, var_0.ritual_site_target, "assault_sacrifice_zombie_trail", undefined, undefined, 1);
      thread zombie_begin_sacrifice(var_0, var_0.ritual_site_target);
      var_0.zombies_sacrificing = scripts\engine\utility::array_add(var_0.zombies_sacrificing, self);
      var_0 thread play_drain_narration();
      return;
    }

    var_3 = 0;
  }
}

zombie_begin_sacrifice(var_0, var_1) {
  self endon("death");
  self endon("zombie_sacrificed");
  var_0 endon("players_dead");
  level endon("game_ended");
  level endon("objective_ended");
  var_0 endon("assault_ended");
  var_0 endon("ritual_site_destroyed");
  var_0 endon("new_ritual_site_target");
  self endon("zombie_selected_for_sacrifice");

  if(istrue(self.being_sacrificed)) {
    release_sacrifice_zombie();
    return;
  }

  var_2 = spawnStruct();
  var_2.label = &"CP_ZMB/OBJECTIVE_ASSAULT_RITUAL_SITE";
  var_2.setbackground = 5;
  var_2.team = "allies";
  self.targeted_ritual_site.being_attacked = 1;
  var_0 update_ritual_site_mini_map_icons();
  _id_0987::set_objective_target_color_id(1);

  if(isDefined(level._id_A88B[var_0.ritualsitemarkernum])) {
    _id_0987::_id_FB90(var_0.ritualsitemarkernum, var_2);
  }

  self.being_sacrificed = 1;
  self _meth_81B0("outline_assault_zombie");
  self playLoopSound("zmb_sacrificing_lp");
  self _meth_8326(self.origin);
  self _meth_8251("face direction", var_1.origin - self.origin);
  wait 0.5;

  if(isDefined(self._id_110B0) && isDefined(self.try_do_scripted_anim)) {
    self[[self.try_do_scripted_anim]]("animscripted", "syphoncore_intro");
    wait 2.6;
    self[[self.try_do_scripted_anim]]("animscripted", "syphoncore_loop");
    wait 2.6;
  }

  var_0.zombies_for_sacrifice = scripts\engine\utility::array_remove(var_0.zombies_for_sacrifice, self);

  if(!isDefined(self.targeted_ritual_site) || !scripts\engine\utility::is_equal(self.targeted_ritual_site, var_0.ritual_site_target)) {
    release_sacrifice_zombie();
    return;
  }

  if(isDefined(var_0.ritual_site_target) && isDefined(var_0.ritual_site_target) && scripts\engine\utility::is_equal(var_0.ritual_site_target, var_1) && scripts\engine\utility::is_equal(self.targeted_ritual_site, var_1) && istrue(self.targeting_ritual_site)) {
    damage_ritual_site(var_0, self);

    if(isDefined(self) && isalive(self)) {
      self.sacrificed = 1;
      self _meth_81FA();
    }

    self notify("zombie_sacrificed");
    return;
  }

  release_sacrifice_zombie();
}

release_sacrifice_zombie(var_0) {
  self.targeting_ritual_site = undefined;
  self.targeted_ritual_site = undefined;
  self.being_sacrificed = undefined;
  self.brain_rot_immune = undefined;
  self._id_0043 = 1;
  self.override_spawn_info = undefined;
  self _meth_81AD();
  self notify("released");

  if(istrue(var_0)) {
    self.ritual_site_annihilate = 1;
    self _meth_81FA();
    return;
  }

  self._id_0229 = 0;
  self._id_CF4A = 0;
  stopFXOnTag(level._effect["assault_sacrifice_zombie"], self, "j_spine4");

  if(isalive(self) && isDefined(self._id_D603)) {
    self[[self._id_D603]]("run");
  }
}

release_all_sacrifice_zombies(var_0, var_1) {
  if(_func_0107(var_0.zombies_for_sacrifice) && var_0.zombies_for_sacrifice.size > 0) {
    var_0.zombies_for_sacrifice = scripts\engine\utility::_id_1BCA(var_0.zombies_for_sacrifice);

    foreach(var_3 in var_0.zombies_for_sacrifice) {
      var_3 release_sacrifice_zombie(var_1);
    }
  }

  var_0.zombies_for_sacrifice = [];

  if(_func_0107(var_0.zombies_sacrificing) && var_0.zombies_sacrificing.size > 0) {
    var_0.zombies_sacrificing = scripts\engine\utility::_id_1BCA(var_0.zombies_sacrificing);

    foreach(var_3 in var_0.zombies_sacrificing) {
      var_3 release_sacrifice_zombie(var_1);
    }
  }

  var_0.zombies_sacrificng = [];
}

damage_ritual_site(var_0, var_1) {
  if(!isDefined(var_0.ritual_site_target)) {
    return;
  }
  level.b_perfect_finish_assault = 0;
  var_0.ritual_site_target.health--;

  if(var_0.zombies_sacrificing.size <= 0) {
    var_2 = spawnStruct();
    var_2.setbackground = 0;
    var_2.label = "";
    var_2.team = "allies";
    var_0.ritual_site_target.being_attacked = 0;
    var_0 update_ritual_site_mini_map_icons();
    _id_0987::set_objective_target_color_id(0);
    _id_0987::_id_FB90(var_0.ritualsitemarkernum, var_2);
  }

  var_0.ritual_site_target.ritual_site_model playSound("zmb_sacrifice");
  var_0 update_ritual_site_marker();

  if(var_0.ritual_site_target.health <= 0) {
    var_0 thread play_rift_open_narration(scripts\cp\utility::_id_459B(var_0.ritual_sites_destroyed, 0));
    level thread destroy_ritual_site(var_0.ritual_site_target, var_0);

    if(isDefined(var_1) && isalive(var_1)) {
      self.sacrificed = 1;
      self _meth_81FA();
    }

    return;
  }
}

destroy_ritual_site(var_0, var_1) {
  if(istrue(var_0.is_destroyed)) {
    return;
  }
  if(is_s2_mq_event(var_1)) {
    _id_0987::set_objective_ui_state(7, 2, 4);
  } else {
    _id_0987::set_objective_ui_state(6, 2, 4);
  }

  foreach(var_3 in var_1.zombies_sacrificing) {
    var_3.targeting_ritual_site = 0;
    var_3.targeted_ritual_site = undefined;
    var_3.ritual_site_annihilate = 1;
    var_3 _meth_81FA();
  }

  var_1.zombies_sacrificing = [];
  var_0.is_current_target = 0;
  var_0.is_destroyed = 1;
  var_1.ritual_sites_destroyed = scripts\cp\utility::_id_459B(var_1.ritual_sites_destroyed, 0);
  var_1.ritual_sites_destroyed++;
  release_all_sacrifice_zombies(var_1, 1);
  stopFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_idle"), var_0.ritual_site_model, "tag_origin");
  var_5 = spawnStruct();
  var_5._id_E747 = "invisible";
  _id_0987::_id_FB90(var_1.ritualsitemarkernum, var_5);
  _id_0987::remove_instanced_objective_marker(var_0.markerlabel, var_0.instanceindex);

  if(isDefined(var_0.ritual_site_model)) {
    var_0.ritual_site_model _meth_8093();
  }

  if(_func_0107(var_1.ritual_site_clip[var_0._id_3BE4]) && var_1.ritual_site_clip[var_0._id_3BE4].size > 0) {
    foreach(var_7 in var_1.ritual_site_clip[var_0._id_3BE4]) {
      var_7 _meth_8093();
      var_7 hide();
    }
  }

  var_0.ritual_site_model stoploopsound("zmb_ritual_site_amb_lp");
  var_0.ritual_site_model delete();
  _id_0987::set_objective_phase_count(var_1.available_ritual_sites.size, var_1.ritual_sites.size);
  spawn_rift(var_1, var_0);

  if(_func_0205("zmb_obelisk_finale")) {
    var_0.rift_model playSound("zmb_ritual_site_into_rift");
    var_0.rift_model playLoopSound("zmb_rift_lp");
  }

  var_9 = 0;

  foreach(var_0 in var_1.ritual_sites) {
    if(istrue(var_0.is_destroyed)) {
      var_9++;
    }
  }

  if(var_9 >= var_1.ritual_sites.size) {
    level thread assault_complete(0, var_1);
    return;
  }

  var_1 notify("ritual_site_destroyed");
  var_1.selecting_next_ritual_site = 0;
  level thread select_ritual_site_target(var_1, 1);
}

spawn_rift(var_0, var_1) {
  var_0.rifts_opened = scripts\cp\utility::_id_459B(var_0.rifts_opened, 0);
  var_0.rifts_opened++;

  if(_func_0107(var_0.zombies_for_sacrifice) && var_0.zombies_for_sacrifice.size > 0) {
    foreach(var_3 in var_0.zombies_for_sacrifice) {}
  }

  var_1.rift_model = _id_06EF::_id_E1E5(var_1, "zmb_syphoncore_wholebody_stump", 0);
  var_1 thread rift_zombie_spawn_watcher(var_0);
  playFXOnTag(scripts\engine\utility::getfx("assault_rift"), var_1.rift_model, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("assault_rift_temp"), var_1.rift_model, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_destroyed"), var_1.rift_model, "tag_origin");
}

rift_zombie_spawn_watcher(var_0) {
  var_0 endon("players_dead");
  var_0 endon("objective_ended");
  var_0 endon("assault_ended");
  level endon("game_ended");
  level endon("objective_ended");
  var_0.last_rift_zombie_spawn_time = 0;
  level.zm_spawn_manager_spawn_struct_array_override = scripts\cp\utility::_id_459B(level.zm_spawn_manager_spawn_struct_array_override, []);
  var_1 = spawnStruct();
  var_1.spawn_struct = self;
  var_1.spawn_tag = "rift_spawn";
  var_1.rift_struct = self;

  for(;;) {
    if(var_0.last_rift_zombie_spawn_time < gettime() - get_rift_time_between_spawns() && _func_0107(level.zm_spawn_manager_spawn_struct_array_override) && level.zm_spawn_manager_spawn_struct_array_override.size < 20) {
      level.zm_spawn_manager_spawn_struct_array_override = scripts\engine\utility::array_add(level.zm_spawn_manager_spawn_struct_array_override, var_1);
      var_0.last_rift_zombie_spawn_time = gettime();
    }

    wait 0.1;
  }
}

zombies_switch_target_cleanup(var_0) {
  level endon("game_ended");
  var_0 endon("new_ritual_site_target");
  var_0 endon("ritual_site_destroyed");
  var_0 endon("assault_ended");
  var_0 endon("objective_ended");
  level endon("objective_ended");

  if(isDefined(var_0.ritual_site_target) && _func_0107(var_0.ritual_site_target.available_sacrifice_locations) && var_0.ritual_site_target.available_sacrifice_locations.size > 0 && !istrue(var_0.ritual_site_target.is_destroyed)) {
    foreach(var_2 in var_0.ritual_site_target.available_sacrifice_locations) {
      wait 0.1;
      var_0 force_sacrifice_random_zombie();
    }
  }
}

kill_ritual_site_zombies() {}

force_sacrifice_random_zombie() {
  self endon("assault_ended");
  self endon("objective_ended");
  self endon("new_ritual_site_target");
  self endon("ritual_site_destroyed");
  level endon("game_ended");
  level endon("objective_ended");
  var_0 = _func_0070("axis");

  if(var_0.size == 0) {
    return;
  }
  for(var_1 = 0; var_1 < 5; var_1++) {
    var_2 = randomint(var_0.size);

    if(scripts\engine\utility::is_equal(var_0[var_2]._id_110B0, "base") && !isDefined(var_0[var_2].targeted_ritual_site) && !istrue(var_0[var_2].targeting_ritual_site) && (scripts\engine\utility::is_equal(var_1, 4) || (!isDefined(var_0[var_2].override_spawn_info) || !scripts\engine\utility::is_equal(var_0[var_2].override_spawn_info.spawn_tag, "rift_spawn")))) {
      var_0[var_2] set_zombie_ritual_site_target(self);
      return;
    }

    waittillframeend;
  }
}

get_rift_time_between_spawns() {
  switch (level.players.size) {
    case 2:
      return 5000;
    case 3:
      return 4000;
    case 4:
      return 3000;
    default:
      return 7000;
  }
}

sacrifice_zombie_energy_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0) || !isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  level endon("game_ended");
  var_0 endon("assault_ended");
  var_0 endon("new_ritual_site_target");
  var_2 endon("death");
  var_1 endon("death");
  var_1 endon("released");

  for(;;) {
    level thread send_sacrifice_zombie_energy(var_1, var_2, var_3, var_4, var_5);

    if(!istrue(var_6)) {
      return;
    }
    wait 1;
  }
}

send_sacrifice_zombie_energy(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_5 = var_3;

  if(!isDefined(var_5)) {
    var_5 = var_0 gettagorigin("j_spine4");
  }

  var_6 = var_5;
  var_7 = var_1.origin + (0, 0, 44);
  var_8 = 0;

  if(istrue(var_4)) {
    var_8 = 160;
  } else {
    var_8 = 160;

    if(scripts\engine\utility::is_equal(var_0.movement_speed, "run")) {
      var_8 = 160;
    }
  }

  var_9 = distance(var_6, var_7) / var_8;

  if(var_9 <= 0) {
    return;
  }
  var_10 = scripts\cp\utility::_id_E190("tag_origin", var_6);
  waitframe();

  if(isDefined(var_0)) {
    var_11 = playFXOnTag(level._effect[var_2], var_10, "tag_origin");
    var_10 moveto(var_7, var_9);
    var_10 waittill("movedone");

    if(isDefined(var_11)) {
      stopFXOnTag(var_11, var_10, "tag_origin");
    }

    wait 1;
  }

  var_10 delete();
}

cleanup_ritual_sites() {
  foreach(var_1 in self.ritual_sites) {
    if(isDefined(var_1.rift_model)) {
      stopFXOnTag(scripts\engine\utility::getfx("assault_rift"), var_1.rift_model, "tag_origin");
      stopFXOnTag(scripts\engine\utility::getfx("assault_rift_temp"), var_1.rift_model, "tag_origin");
      stopFXOnTag(scripts\engine\utility::getfx("assault_ritual_site_destroyed"), var_1.rift_model, "tag_origin");
      var_1.rift_model delete();
    }

    if(isDefined(var_1.ritual_site_model)) {
      var_1.ritual_site_model _meth_8093();
      var_1.ritual_site_model stoploopsound("zmb_ritual_site_amb_lp");
      var_1.ritual_site_model delete();
    }
  }
}

complete_objective() {
  level notify("timer_stop");
  _id_0987::set_objective_ui_state(6, 0, 2);
  assault_complete(1, level._id_3BE9._id_0F51);
}

assault_complete(var_0, var_1) {
  var_1 notify("assault_ended");
  level notify("assault_ended");
  var_1 notify("stop_wave_manager");
  var_1.current_intensity = undefined;
  var_1.complete = 1;
  _func_01E3("none");
  cleanup_marker();

  if(istrue(var_0)) {
    if(isDefined(var_1.ritual_sites)) {
      foreach(var_3 in var_1.ritual_sites) {
        if(istrue(var_3.is_destroyed) && isDefined(var_3.rift_model)) {
          var_3.rift_model delete();
        }
      }
    }

    if(isDefined(var_1.ritual_site_target) && isDefined(var_1.ritual_site_target.ritual_site_model)) {
      var_1.ritual_site_target.ritual_site_model stoploopsound("zmb_ritual_site_amb_lp");
      var_1.ritual_site_target.ritual_site_model delete();
      var_1.ritual_site_target.ritual_site_model = _id_06EF::_id_E1E5(var_1.ritual_site_target, "zmb_syphoncore_wholebody_idle", 0);
      var_1.ritual_site_target.ritual_site_model _meth_82CB("ai_s4_zm_zombie_syphoncore_idle_01");
      var_1.ritual_site_target.ritual_site_model playLoopSound("zmb_ritual_site_amb_lp");
    }

    var_1 remove_ritual_site_mini_map_icons();
    level thread _id_0991::_id_E8E2(1);
    level thread _id_0987::kill_all_objective_zombies();

    if(!isDefined(var_1.ritual_sites_destroyed) || scripts\engine\utility::is_equal(var_1.ritual_sites_destroyed, 0)) {
      level thread drop_syphoncore_loot(var_1.ritual_site_target);
    }

    _id_0987::_id_A871(var_1, 1);
  } else {
    if(is_s2_mq_event(var_1)) {
      _id_0987::set_objective_ui_state(7, 0, 3);
    } else {
      _id_0987::set_objective_ui_state(6, 0, 3);
    }

    wait 2;
    playFX(scripts\engine\utility::getfx("assault_failure_explosion"), var_1.ritual_site_target.origin);

    if(isDefined(var_1.ritual_site_target.rift_model)) {
      var_1.ritual_site_target.rift_model playSound("zmb_sacrifice_fail_explo");
    }

    wait 0.3;
    assault_down_all_players();
    wait 1;
    _id_0987::_id_A871(var_1, 0, _id_0726::_id_6472("fail"));
    level thread _id_0991::_id_E8E2(0);
  }
}

drop_syphoncore_loot(var_0) {
  wait 1.35;
  var_1 = level.cache_drop_table_names["syphoncore"];

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = _id_073D::get_highest_round_loot_table(var_1, scripts\cp\utility::_id_6871());

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_CD99) && var_0._id_CD99 == "is_near_wall") {
      var_3 = 10;
    } else {
      var_3 = 20;
    }

    _id_073D::select_and_spawn_items_from_table(var_2, var_0.origin + (0, 0, 48), var_0.angles, undefined, "syphoncore", var_3, undefined, 0.2, "zmb_spawn_portal", var_0.ritual_site_model);

    if(isDefined(var_0.ritual_site_model)) {
      var_0.ritual_site_model playSound("zmb_exfil_portal_open");
    }
  }
}

assault_down_all_players() {
  foreach(var_1 in level.players) {
    var_1 thread reset_assault_screen_fx_on_disconnect();
    var_1 _id_0981::_id_C391("self_revive");
    var_2 = scripts\cp\utility::_id_3EE1("white", 0, var_1);
    var_2 fadeovertime(0.125);
    var_2.alpha = 0.4;
    wait 0.125;
    var_1 dodamage(var_1.health + 100, var_1.origin);
    var_2 fadeovertime(0.175);
    var_2.alpha = 0;
  }
}

assault_failure_death_screen_fx() {
  var_0 = 0;
  var_1 = gettime();
  var_2 = -0.5;
  var_3 = 0.3;
  var_4 = 0.2;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  setDvar("#x320c6aa95071ea85d", var_5);
  setDvar("#x31f9ba2c1834330ea", var_6);
  setDvar("#x329d798d8baa02cac", var_7);

  while(var_0 < 2000) {
    var_0 = gettime() - var_1;
    var_8 = var_0 / 1000;
    setDvar("#x320c6aa95071ea85d", var_5 + (var_2 - var_5) * var_8);
    setDvar("#x31f9ba2c1834330ea", var_6 + (var_3 - var_6) * var_8);
    setDvar("#x329d798d8baa02cac", var_7 + (var_4 - var_7) * var_8);
    wait 0.01;
  }

  var_5 = -0.5;
  var_6 = 0.3;
  var_7 = 0.2;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_0 = 0;

  while(var_0 < 300) {
    var_0 = gettime() - var_1;
    var_8 = var_0 / 300;
    setDvar("#x320c6aa95071ea85d", var_5 + (var_2 - var_5) * var_8);
    setDvar("#x31f9ba2c1834330ea", var_6 + (var_3 - var_6) * var_8);
    setDvar("#x329d798d8baa02cac", var_7 + (var_4 - var_7) * var_8);
    wait 0.01;
  }

  setDvar("#x320c6aa95071ea85d", 0);
  setDvar("#x31f9ba2c1834330ea", 0);
  setDvar("#x329d798d8baa02cac", 0);
  level notify("assault_death_sequence_finished");
}

reset_assault_screen_fx_on_disconnect() {
  level endon("assault_death_sequence_finished");
  self waittill("disconnect");
  setDvar("#x320c6aa95071ea85d", 0);
  setDvar("#x31f9ba2c1834330ea", 0);
  setDvar("#x329d798d8baa02cac", 0);
}

_id_385C() {
  _id_06CB::_id_C388("zm_spawn_manager_zombie_spawned", ::on_zombie_spawned, undefined);
  _id_06CB::_id_C417(::_id_AA6D);
  level thread _id_0991::_id_E8E2(1);

  foreach(var_1 in self.ritual_site_clip) {
    if(_func_0107(var_1) && var_1.size > 0) {
      foreach(var_3 in var_1) {
        var_3 _meth_8093();
        var_3 hide();
      }
    }
  }

  self.complete = undefined;
  self.ritual_site_target = undefined;
  self.current_intensity = undefined;
  self.available_ritual_sites = undefined;
  self.ritual_sites_destroyed = undefined;
  self.ritual_site_moves = undefined;
  self.zombies_for_sacrifice = [];
  self.zombies_sacrificing = [];
  level.zm_spawn_manager_spawn_struct_array_override = undefined;
  self.last_rift_zombie_spawn_time = 0;
  self.selected_sacrifice_zombie_time = 0;
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(self._id_3BE8["prop"], 0);
  thread cleanup_ritual_sites();

  if(is_s2_mq_event(self)) {
    if(isDefined(level.mdl_dormant_shield)) {
      level.mdl_dormant_shield delete();
    }

    if(isDefined(level.mdl_dormant_shield_fx)) {
      stopFXOnTag(level._effect["s2_mq_dormant_shield_ambient"], level.mdl_dormant_shield_fx, "tag_origin");
      level.mdl_dormant_shield_fx delete();
    }

    level._id_A52A = 0;
  }

  if(isDefined(self._id_EACB) && self._id_EACB) {
    return;
  }
}

on_player_spawned() {
  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "assault")) {
    _id_0987::set_objective_ui_state(6, 0, 5);
    _id_0987::set_objective_ui_bar_progress_numerical(0, 5);
    _id_0987::set_objective_ui_bar_progress(0);
  }
}

register_zombie_entry_triggers() {
  level.a_objective_zombie_entry_triggers["objective_tonga_windmill_assault"] = ["trigger_tonga_barnyard_holdout", "trigger_tonga_barn_holdout", "trigger_tonga_small_barn_holdout", "trigger_tonga_windmill_holdout", "trigger_tonga_windmill_barn_soul", "trigger_tonga_yard_small_barn_soul"];
  level.a_objective_zombie_entry_triggers["objective_oasis_crashed_plane_tail_assault"] = ["trigger_crashed_plane_west_soul", "trigger_crashed_plane_tail_assault"];
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_west_exterior_assault"] = ["trigger_ruins_west_exterior_assault", "trigger_ruins_west_exterior_holdout"];
  level.a_objective_zombie_entry_triggers["objective_hall_bottom_assault"] = ["trigger_hall_bottom_up_soul"];
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_east_building_assault"] = ["trigger_ruins_east_exterior_soul", "trigger_ruins_east_building_assault"];
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_tents_assault"] = ["trigger_ruins_east_exterior_soul", "trigger_ruins_tents_assault"];
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_tents_assault"] = ["trigger_apartment_assault", "trigger_apartment_stairwell_soul", "trigger_apartment_top_down_soul"];
}

play_kickoff_vo(var_0) {
  if(!is_s2_mq_event(var_0)) {
    wait 1;
    level.assault_count = scripts\cp\utility::_id_459B(level.assault_count, 1);
    _id_0987::play_objective_kickoff_narration("assault", level.assault_count, var_0, 0);
    level.assault_count++;
  }
}

play_drain_narration() {
  var_0 = scripts\cp\utility::_id_459B(self.ritual_sites_destroyed, 0);

  if(!istrue(self.b_played_start_drain_vo) && istrue(self.b_is_quest)) {
    level thread _id_0720::_id_BEC0("zm_cqas_oqas_vrcn_aq1s");
    self.b_played_start_drain_vo = 1;
  }

  if((var_0 == 0 || istrue(self.should_play_ritual_site_vo)) && !istrue(self.played_first_drain_narration)) {
    self.should_play_ritual_site_vo = 0;
    wait 4;
    self.played_first_drain_narration = 1;
    thread _id_0720::play_narration("zm_o2as_ass2_vrcn_a1sy");
    level waittill("dialogue_finished");
  }

  if((var_0 == 1 || istrue(self.should_play_ritual_site_vo)) && !istrue(self.played_second_drain_narration)) {
    self.played_second_drain_narration = 1;
    self.should_play_ritual_site_vo = 0;
    thread _id_0720::play_narration("zm_o2as_ass2_vrcn_a2sy");
    level waittill("dialogue_finished");
  }

  if((var_0 == 2 || istrue(self.should_play_ritual_site_vo)) && !istrue(self.played_third_drain_narration)) {
    self.played_third_drain_narration = 1;
    self.should_play_ritual_site_vo = 0;
    thread _id_0720::play_narration("zm_o2as_ass2_vlst_a3sy");
    level waittill("dialogue_finished");
  }
}

play_rift_open_narration(var_0) {
  var_0++;

  if(var_0 == 1) {
    if(_func_0121(self.override_1st_rift_open_vo) && _func_0121(self.override_1st_rift_open_resp_vo)) {
      thread _id_0720::play_narration(self.override_1st_rift_open_vo);
      level waittill("dialogue_finished");
      thread _id_0720::play_narration(self.override_1st_rift_open_resp_vo);
      level waittill("dialogue_finished");
    } else {
      thread _id_0720::play_narration("zm_o2as_ass2_krft_a1ro");
      level waittill("dialogue_finished");
      thread _id_0720::play_narration("zm_o2as_ass2_vlst_a1rr");
      level waittill("dialogue_finished");
    }
  }

  if(var_0 == 2) {
    if(_func_0121(self.override_2nd_rift_open_vo) && _func_0121(self.override_2nd_rift_open_resp_vo)) {
      thread _id_0720::play_narration(self.override_2nd_rift_open_vo);
      level waittill("dialogue_finished");
      thread _id_0720::play_narration(self.override_2nd_rift_open_resp_vo);
      level waittill("dialogue_finished");
    } else {
      thread _id_0720::play_narration("zm_o2as_ass2_vlst_a2ro");
      level waittill("dialogue_finished");
      thread _id_0720::play_narration("zm_o2as_ass2_krft_a2rr");
      level waittill("dialogue_finished");
    }
  }
}

manage_time_narration() {
  wait 135.0;
  thread _id_0720::play_narration("zm_o2as_ass2_vrcn_a25e");
  level waittill("dialogue_finished");
}

play_switch_target_vo(var_0) {
  level endon("end_game");
  var_0 waittill("new_ritual_site_target");
  level thread _id_0720::_id_BEC0("zm_cqas_oqas_vrcn_aq2s");
  var_0 waittill("new_ritual_site_target");
  level thread _id_0720::_id_BEC0("zm_cqas_oqas_krtx_aq3s");
}

is_s2_mq_event(var_0) {
  return isDefined(var_0) && scripts\engine\utility::is_equal(var_0._id_0481, "objective_dark_aether_assault");
}

init_dormant_shield(var_0) {
  level endon("end_game");
  wait 3;
  var_1 = scripts\engine\utility::getstruct("s2_mq_shield_loc", "targetname");
  var_2 = scripts\engine\utility::getstruct("s2_mq_shield_portal", "targetname");
  var_3 = scripts\cp\utility::_id_E190("tag_origin", var_2.origin, var_2.angles);
  var_3 playSound("zmb_exfil_portal_open");
  waitframe();
  playFXOnTag(level._effect["s2_mq_shield_portal_ambient_fx"], var_3, "tag_origin");
  wait 2;

  if(isDefined(var_3)) {
    level.mdl_dormant_shield = scripts\cp\utility::_id_E190("vm_shield_demonic_zm_closeeye_200", var_1.origin, var_1.angles);
    level.mdl_dormant_shield movez(-200, 4, 0, 0);
    level.mdl_dormant_shield waittill("movedone");
    level.mdl_dormant_shield thread shield_bob();
    _func_012F(level._effect["s2_mq_shield_portal_ambient_fx"], var_3, "tag_origin");
  }

  var_3 playSound("zmb_spawn_portal");
  wait 0.1;

  if(isDefined(var_3)) {
    playFX(level._effect["s2_mq_shield_portal_outro_fx"], var_3.origin);
    var_3 delete();
  }

  if(isDefined(level.mdl_dormant_shield)) {
    level.mdl_dormant_shield_fx = scripts\cp\utility::_id_E190("tag_origin", level.mdl_dormant_shield.origin + (0, 0, -15), level.mdl_dormant_shield.angles);
    playFXOnTag(level._effect["s2_mq_dormant_shield_ambient"], level.mdl_dormant_shield_fx, "tag_origin");
  }

  foreach(var_5 in var_0.ritual_sites) {
    var_5 thread charge_dormant_shield();
  }
}

charge_dormant_shield() {
  level endon("game_ended");
  level endon("assault_ended");

  while(self.health > 0) {
    var_0 = scripts\cp\utility::_id_E190("tag_origin", self.origin + (0, 0, 60), self.angles);
    waitframe();

    if(isDefined(var_0)) {
      playFXOnTag(level._effect["s2_mq_dormant_shield_energy_trail"], var_0, "tag_origin");
      var_1 = distance(self.origin, level.mdl_dormant_shield_fx.origin) / 150;

      if(var_1 <= 0) {
        return;
      }
      var_0 moveto(level.mdl_dormant_shield_fx.origin, var_1, 0, 0);
      var_0 thread shield_energy_trail_travel_watcher();
    }

    wait 1;
  }
}

shield_energy_trail_travel_watcher() {
  level endon("game_ended");
  self endon("death");
  self waittill("movedone");
  _func_0130(self);
  self delete();
}

s2_mq_victory_watcher() {
  level endon("game_ended");
  level endon("assault_ended");
  var_0 = 0;
  var_1 = 0.02849 / self.ritual_sites.size;
  var_2 = 0;

  for(;;) {
    var_3 = 0;

    foreach(var_5 in self.ritual_sites) {
      if(istrue(var_5.is_destroyed)) {
        var_3++;
      }
    }

    var_7 = self.ritual_sites.size - var_3;
    var_0 = var_0 + var_1 * var_7;
    _id_0987::set_objective_ui_bar_2_progress(var_0 / 100);

    if(var_0 - var_2 > 5) {
      var_2 = var_2 + 5;

      foreach(var_9 in level.players) {
        var_9 thread _id_0752::_id_7003("s2_mq_charge_dormant_shield");
      }
    }

    if(var_0 >= 100) {
      level notify("unique_assault_complete");
      _id_0987::set_objective_ui_state(7, 0, 2);
      level thread assault_complete(1, self);
    }

    waitframe();
  }
}

setup_s2_mq_ui() {
  self.assault_start_time = gettime();
  _id_0987::set_objective_ui_state(7, 0, 1);
  _id_0987::set_objective_ui_bar_2_progress(0);
  _id_0987::set_objective_phase_count(self.available_ritual_sites.size, self.ritual_sites.size);
  _id_0987::set_objective_ui_bar_progress_numerical(0, 5);
  _id_0987::set_objective_ui_bar_progress(0);
  _id_0987::set_objective_show_subtext(1);
  _id_0987::set_objective_target_color_id(0);
}

zabala_intro() {
  level endon("end_game");
  var_0 = scripts\engine\utility::getstruct("zabala_spawn_loc", "targetname");

  if(!isDefined(level.first_zabala)) {
    level.skip_trickster_intro = 1;
    level.first_zabala = _id_09A4::_id_110AD("enemy_zombie_trickster_cp", var_0.origin, var_0.angles, var_0);
    level.skip_trickster_intro = undefined;

    if(isDefined(level.first_zabala.try_do_scripted_anim)) {
      level.first_zabala[[level.first_zabala.try_do_scripted_anim]]("animscripted", "intro");
      level.first_zabala playSound("ai_deceiver_portal_open");
      wait 0.1;
      var_1 = level.first_zabala._id_8530;
      level.first_zabala._id_8530 = level.first_zabala.health;
      wait 0.5;
      level.first_zabala thread play_zabala_intro_vos();
      wait 27;
      level.first_zabala._id_8530 = var_1;
    }
  }
}

play_zabala_intro_vos() {
  level endon("end_game");
  self playSound("zm_cqas_oqas_zbla_aqz1");
  wait(_id_0720::get_dialogue_length("zm_cqas_oqas_zbla_aqz1"));
  self playSound("zm_cqas_oqas_zbla_aqz2");
  wait(_id_0720::get_dialogue_length("zm_cqas_oqas_zbla_aqz2"));
  self playSound("zm_cqas_oqas_zbla_aqz3");
  wait(_id_0720::get_dialogue_length("zm_cqas_oqas_zbla_aqz3"));
  self playSound("zm_cqas_oqas_zbla_aqz4");
  wait(_id_0720::get_dialogue_length("zm_cqas_oqas_zbla_aqz4"));
  self playSound("zm_cqas_oqas_zbla_aqz5");
  wait(_id_0720::get_dialogue_length("zm_cqas_oqas_zbla_aqz5"));
  level thread _id_0720::play_narrations("zm_cqas_oqas_vrcn_aqzr", 1, 0);
}

shield_bob() {
  level endon("end_game");
  self endon("death");
  var_0 = self.origin + (0, 0, 10);
  var_1 = self.origin;

  for(;;) {
    self moveto(var_0, 1, 0, 0.3);
    self waittill("movedone");
    self moveto(var_1, 1, 0, 0.3);
    self waittill("movedone");
  }
}
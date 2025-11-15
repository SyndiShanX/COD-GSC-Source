/*************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_memory_quests.gsc
*************************************************************/

init_memory_quests() {
  rave_charm_mapping();
  level.closest_crystal_func = ::return_closest_memory_item;
  level.crystal_check_func = ::ent_near_item;
  level.is_in_box_func = ::is_in_box;
  setup_memory_playback_progression();
}

setup_memory_playback_progression() {
  level.memory_quest_vo_progression = [];
  level.memory_quest_vo_progression["m2_wwlyer_daughter"] = 1;
  level.memory_quest_vo_progression["m3_dwapner_crew"] = 1;
  level.memory_quest_vo_progression["m5_jgeiger_costar"] = 1;
  level.memory_quest_vo_progression["m4_alimaye_triberep"] = 1;
  level.memory_quest_vo_progression["m6_rjones_pi"] = 1;
  level.memory_quest_vo_progression["m8_tramon_manager"] = 1;
  level.memory_quest_vo_progression["m1_carya_student"] = 1;
  level.memory_quest_vo_progression["m7_mmason_soninlaw"] = 1;
  level.memory_quest_vo_progression["m9_bmax_starlet"] = 1;
  level.memory_quest_vo_progression["m10_ghudson_foreman"] = 1;
}

rave_charm_mapping() {
  level.rave_charm_attachment_perks = [];
  level.rave_charm_attachment_perks["cos_087"] = "perk_machine_tough";
  level.rave_charm_attachment_perks["cos_086"] = "perk_machine_revive";
  level.rave_charm_attachment_perks["cos_093"] = "perk_machine_flash";
  level.rave_charm_attachment_perks["cos_090"] = "perk_machine_more";
  level.rave_charm_attachment_perks["cos_072"] = "perk_machine_rat_a_tat";
  level.rave_charm_attachment_perks["cos_091"] = "perk_machine_run";
  level.rave_charm_attachment_perks["cos_085"] = "perk_machine_fwoosh";
  level.rave_charm_attachment_perks["cos_089"] = "perk_machine_smack";
  level.rave_charm_attachment_perks["cos_095"] = "perk_machine_zap";
  level.rave_charm_attachment_perks["cos_092"] = "perk_machine_boom";
  level.rave_charm_attachment_perks["cos_090"] = "perk_machine_more";
  level.rave_charm_attachment = [];
  level.rave_charm_attachment["binoculars"] = "cos_095";
  level.rave_charm_attachment["lure"] = "cos_072";
  level.rave_charm_attachment["pool_ball"] = "cos_085";
  level.rave_charm_attachment["shovel"] = "cos_086";
  level.rave_charm_attachment["pacifier"] = "cos_087";
  level.rave_charm_attachment["ring"] = "cos_089";
  level.rave_charm_attachment["arrowhead"] = "cos_090";
  level.rave_charm_attachment["toad"] = "cos_091";
  level.rave_charm_attachment["boots"] = "cos_092";
  level.rave_charm_attachment["tiki_mask"] = "cos_093";
}

return_closest_memory_item(param_00) {
  return scripts\engine\utility::getclosest(param_00.origin, level.memory_quest_items);
}

ent_near_item(param_00, param_01) {
  if(level.memory_quest_items.size < 1) {
    return 0;
  }

  var_02 = 0;
  foreach(var_04 in level.memory_quest_items) {
    var_05 = 562500;
    if(!isDefined(var_04) || scripts\engine\utility::istrue(var_04.fully_charged)) {
      continue;
    }

    if(distancesquared(var_04.origin, param_00.origin) < var_05) {
      var_02 = 1;
    }

    if(var_02) {
      break;
    }
  }

  if(var_02) {
    return 1;
  }

  return 0;
}

memories_end_hint_func(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.quest_complete)) {
    return & "CP_RAVE_INSPECT_ITEM";
  }

  return "";
}

memories_end_use_func(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.quest_restart)) {
    param_00.quest_restart = undefined;
    param_01 playlocalsound("part_pickup");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    thread run_memory_release_quest(param_00);
    return;
  }

  if(isDefined(param_01.has_memory_quest_item) && isDefined(param_00.name) && param_01.has_memory_quest_item == param_00.name) {
    param_01 setclientomnvar("zm_hud_inventory_1", 0);
    switch (param_00.name) {
      case "pacifier":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(9);
        break;

      case "shovel":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(2);
        break;

      case "tiki_mask":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(5);
        break;

      case "arrowhead":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(3);
        break;

      case "lure":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(7);
        break;

      case "toad":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(8);
        break;

      case "pool_ball":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(6);
        break;

      case "ring":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(4);
        break;

      case "binoculars":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(1);
        break;

      case "boots":
        level scripts\cp\maps\cp_rave\cp_rave::set_charm_icon(10);
        break;
    }

    param_01.has_memory_quest_item = undefined;
    param_00.activated = 1;
    param_00.starting_struct notify("charm_placed");
    param_01 playlocalsound("part_pickup");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    if(isDefined(param_00.target)) {
      var_02 = scripts\engine\utility::getstruct(param_00.target, "targetname");
      var_02.name = param_00.name;
      var_02.activated = 1;
      var_02.script_noteworthy = "memory_quest_end_pos";
      scripts\cp\maps\cp_rave\cp_rave::remove_from_current_rave_interaction_list(param_00);
      scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_02);
    } else {
      scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(param_00);
    }

    foreach(var_04 in level.players) {
      var_04 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_04);
    }

    thread run_memory_release_quest(param_00);
    return;
  }

  if(scripts\engine\utility::istrue(param_00.quest_complete)) {
    param_01 playlocalsound("part_pickup");
    if(isDefined(param_00.currentlyownedby[param_01.name])) {
      param_00.currentlyownedby[param_01.name] setscriptablepartstate("quest_effects", "memory_release");
    }

    play_memory_vo(param_00);
    playFX(scripts\engine\utility::getfx("mem_release_lrg"), param_00.origin);
    if(!scripts\engine\utility::istrue(param_00.player_has_charm)) {
      var_06 = level.rave_charm_attachment[param_00.name];
      if(scripts\cp\maps\cp_rave\cp_rave::rave_add_attachment_to_weapon(var_06, param_01)) {
        foreach(var_04 in level.players) {
          var_04 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_04);
        }

        thread watch_for_charm_removed(param_00, param_01, level.rave_charm_attachment[param_00.name]);
        return;
      }

      return;
    }

    return;
  }
}

watch_for_charm_removed(param_00, param_01, param_02) {
  param_00.player_has_charm = 1;
  param_00 thread wait_for_charm_disowned(param_00, param_02, param_01);
  level thread watchforplayerdisconnect(param_00, param_01, param_02);
  param_01 thread watchforcharmweaponremoved(param_00, param_01, param_02);
  param_01 thread watchforplayerdeath(param_00, param_01, param_02);
}

wait_for_charm_disowned(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 waittill("charm_disowned_" + param_01);
  param_00.player_has_charm = 0;
  if(isDefined(param_02)) {
    if(isDefined(level.rave_charm_attachment_perks[param_01])) {
      param_02 scripts\cp\maps\cp_rave\cp_rave::takeraveperk(level.rave_charm_attachment_perks[param_01], param_01);
    }
  }

  foreach(var_04 in level.players) {
    var_04 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_04);
  }
}

watchforcharmweaponremoved(param_00, param_01, param_02) {
  level endon("game_ended");
  param_01 endon("last_stand");
  param_01 endon("disconnect");
  param_00 endon("charm_disowned_" + param_02);
  var_03 = 1;
  for(;;) {
    if(!var_03) {
      break;
    }

    param_01 scripts\engine\utility::waittill_any_3("weapon_purchased", "mule_munchies_sold");
    var_03 = 0;
    var_04 = param_01 getweaponslistall();
    foreach(var_06 in var_04) {
      if(scripts\cp\utility::weaponhasattachment(var_06, param_02)) {
        var_03 = 1;
        break;
      }
    }
  }

  param_00 notify("charm_disowned_" + param_02);
}

watchforplayerdisconnect(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("charm_disowned_" + param_02);
  param_01 waittill("disconnect");
  param_00 notify("charm_disowned_" + param_02);
}

watchforplayerdeath(param_00, param_01, param_02) {
  level endon("game_ended");
  param_01 endon("disconnect");
  param_00 endon("charm_disowned_" + param_02);
  var_03 = 1;
  for(;;) {
    if(!var_03) {
      break;
    }

    var_04 = undefined;
    param_01 waittill("last_stand");
    if(isDefined(level.rave_charm_attachment_perks[param_02])) {
      param_01 scripts\cp\maps\cp_rave\cp_rave::takeraveperk(level.rave_charm_attachment_perks[param_02], param_02);
    }

    var_03 = 0;
    var_05 = param_01 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive", "death");
    if(var_05 != "revive") {
      var_04 = param_01 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
      if(isDefined(var_04) && var_04 == "lost_and_found_time_out") {
        continue;
      }
    }

    var_06 = param_01 getweaponslistall();
    foreach(var_08 in var_06) {
      if(scripts\cp\utility::weaponhasattachment(var_08, param_02)) {
        param_01 thread watchforcharmweaponremoved(param_00, param_01, param_02);
        var_03 = 1;
        if(isDefined(level.rave_charm_attachment_perks[param_02])) {
          param_01 scripts\cp\maps\cp_rave\cp_rave::giveraveperk(level.rave_charm_attachment_perks[param_02], param_02);
        }

        break;
      }
    }
  }

  param_00 notify("charm_disowned_" + param_02);
}

ring_quest_use_func(param_00, param_01) {
  param_00.model ghost_killed_update_func((0, -90, 0), 0.5);
  param_00.times_rotated++;
  if(param_00.times_rotated == param_00.parent_struct.rotationgoal) {
    param_00.parent_struct.correct_positions[param_00.parent_struct.correct_positions.size] = param_00;
  } else if(scripts\engine\utility::array_contains(param_00.parent_struct.correct_positions, param_00)) {
    param_00.parent_struct.correct_positions = scripts\engine\utility::array_remove(param_00.parent_struct.correct_positions, param_00);
  }

  if(param_00.parent_struct.correct_positions.size == 2) {
    level notify("all_ring_pos_correct");
  }

  if(param_00.parent_struct.correct_positions.size < 0) {
    param_00.parent_struct.correct_positions = [];
  }

  if(param_00.times_rotated > param_00.parent_struct.rotationgoal) {
    param_00.times_rotated = 0;
  }

  wait(0.5);
}

ring_quest_hint_func(param_00, param_01) {
  return "";
}

run_memory_release_quest(param_00) {
  var_01 = getquestfromid(param_00);
  for(;;) {
    if([
        [var_01]
      ](param_00)) {
      playsoundatpos(param_00.origin, "zmb_quest_complete");
      break;
    } else {
      param_00.quest_restart = 1;
      scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
      return;
    }
  }

  param_00.quest_complete = 1;
  foreach(var_03 in level.players) {
    var_03 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_03);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

play_memory_vo(param_00) {
  switch (param_00.name) {
    case "pacifier":
      param_00 thread play_memory_to_nearby_players("m2_wwlyer_daughter");
      break;

    case "shovel":
      param_00 thread play_memory_to_nearby_players("m3_dwapner_crew");
      break;

    case "tiki_mask":
      param_00 thread play_memory_to_nearby_players("m5_jgeiger_costar");
      break;

    case "arrowhead":
      param_00 thread play_memory_to_nearby_players("m4_alimaye_triberep");
      break;

    case "lure":
      param_00 thread play_memory_to_nearby_players("m6_rjones_pi");
      break;

    case "toad":
      param_00 thread play_memory_to_nearby_players("m8_tramon_manager");
      break;

    case "pool_ball":
      param_00 thread play_memory_to_nearby_players("m1_carya_student");
      break;

    case "ring":
      param_00 thread play_memory_to_nearby_players("m7_mmason_soninlaw");
      break;

    case "binoculars":
      param_00 thread play_memory_to_nearby_players("m9_bmax_starlet");
      break;

    case "boots":
      param_00 thread play_memory_to_nearby_players("m10_ghudson_foreman");
      break;

    default:
      break;
  }
}

play_memory_to_nearby_players(param_00, param_01) {
  var_02 = [];
  var_03 = 512;
  if(isDefined(param_01)) {
    var_03 = param_01;
  }

  foreach(var_05 in level.players) {
    if(distance2d(self.origin, var_05.origin) <= var_03) {
      var_02[var_02.size] = var_05;
    }
  }

  var_07 = level.memory_quest_vo_progression[param_00];
  var_08 = param_00 + "_" + level.memory_quest_vo_progression[param_00];
  thread remove_interaction_for_vo_length(self, param_00, var_08);
  foreach(var_05 in var_02) {
    if(soundexists(var_08)) {
      var_05 thread scripts\cp\cp_vo::try_to_play_vo(var_08, "rave_memory_vo");
      level.memory_quest_vo_progression[param_00]++;
      if(!soundexists(param_00 + "_" + level.memory_quest_vo_progression[param_00])) {
        level.memory_quest_vo_progression[param_00] = 1;
      }

      wait(scripts\cp\cp_vo::get_sound_length(var_08));
      if(var_07 == 3) {
        var_05 thread play_memory_reaction_vo(var_08);
      }

      continue;
    }

    if(soundexists(param_00)) {
      var_05 thread scripts\cp\cp_vo::try_to_play_vo(param_00, "rave_memory_vo");
      wait(scripts\cp\cp_vo::get_sound_length(param_00));
      if(var_07 == 3) {
        var_05 thread play_memory_reaction_vo(param_00);
      }
    }
  }
}

play_memory_reaction_vo(param_00) {
  var_01 = strtok(param_00, "_");
  var_02 = var_01[1];
  switch (var_02) {
    case "wwlyer":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_wwyler", "rave_comment_vo");
      break;

    case "dwapner":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_dwapner", "rave_comment_vo");
      break;

    case "jgeiger":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_jgeiger", "rave_comment_vo");
      break;

    case "alimaye":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_alimaye", "rave_comment_vo");
      break;

    case "rjones":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_rjones", "rave_comment_vo");
      break;

    case "tramon":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_tramon", "rave_comment_vo");
      break;

    case "carya":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_carya", "rave_comment_vo");
      break;

    case "mmason":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_mmason", "rave_comment_vo");
      break;

    case "bmax":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_bmaxey", "rave_comment_vo");
      break;

    case "ghudson":
      thread scripts\cp\cp_vo::try_to_play_vo("memento_ghudson", "rave_comment_vo");
      break;

    default:
      break;
  }
}

remove_interaction_for_vo_length(param_00, param_01, param_02) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(soundexists(param_02)) {
    wait(lookupsoundlength(param_02) / 1000);
  } else if(soundexists(param_01)) {
    wait(lookupsoundlength(param_01) / 1000);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

getquestfromid(param_00) {
  if(!isDefined(param_00.name)) {
    return::scripts\cp\maps\cp_rave\cp_rave_interactions::collect_zombie_souls;
  }

  switch (param_00.name) {
    case "pacifier":
      return::run_pacifier_quest;

    case "shovel":
      return::run_shovel_quest;

    case "tiki_mask":
      return::run_tiki_quest;

    case "arrowhead":
      return::run_arrowhead_quest;

    case "lure":
      return::run_lure_quest;

    case "toad":
      return::run_toad_quest;

    case "pool_ball":
      return::run_pool_ball_quest;

    case "ring":
      return::run_ring_quest;

    case "binoculars":
      return::run_binocular_quest;

    case "boots":
      return::run_boots_quest;

    default:
      return::scripts\cp\maps\cp_rave\cp_rave_interactions::collect_zombie_souls;
  }
}

run_toad_quest(param_00) {
  level endon("game_ended");
  level.toads_killed = 0;
  level.toad_ent_array = [];
  var_01 = scripts\engine\utility::getstruct("toad_move_struct_one", "targetname");
  var_02 = scripts\engine\utility::getstruct("toad_move_struct_two", "targetname");
  var_03 = scripts\engine\utility::getstruct("toad_move_struct_three", "targetname");
  var_04 = scripts\engine\utility::getstruct("toad_move_struct_four", "targetname");
  var_05 = scripts\engine\utility::getstruct("toad_move_struct_five", "targetname");
  var_06 = scripts\engine\utility::getstruct("toad_move_struct_six", "targetname");
  var_07 = scripts\engine\utility::getstruct("toad_move_struct_seven", "targetname");
  var_08 = scripts\engine\utility::getstruct("toad_move_struct_eight", "targetname");
  var_09 = scripts\engine\utility::getstruct("toad_move_struct_nine", "targetname");
  var_0A = scripts\engine\utility::getstruct("toad_move_struct_ten", "targetname");
  var_0B = [var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A];
  var_0C = 0;
  for(var_0C = 0; var_0C < 10; var_0C++) {
    if(var_0C <= 5) {
      var_0D = scripts\engine\utility::random(var_0B);
      level.toad_ent_array[var_0C] = spawn("script_model", var_0D.origin, 0, 64, 32);
      level.toad_ent_array[var_0C] setModel("tag_origin_memory_quest");
      level.toad_ent_array[var_0C] setCanDamage(1);
      level.toad_ent_array[var_0C].maxhealth = 5;
      level.toad_ent_array[var_0C].health = 5;
      level.toad_ent_array[var_0C] playLoopSound("memory_quest_frogs");
      level.toad_ent_array[var_0C] thread move_ents_in_random_directions(var_0B);
      level.toad_ent_array[var_0C] thread watch_for_ground_pound_on_toad();
    }
  }

  level waittill("toad_quest_complete");
  foreach(var_0F in level.toad_ent_array) {
    if(isDefined(var_0F)) {
      var_0F delete();
    }
  }

  level.toad_ent_array = undefined;
  level.toads_killed = undefined;
  var_0B = undefined;
  return 1;
}

watch_for_ground_pound_on_toad() {
  level endon("game_ended");
  self endon("toad_quest_complete");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(var_09 != "zom_groundpound_rave_mp") {
      self.health = 5;
    }

    if(isplayer(var_01)) {
      if(var_09 == "zom_groundpound_rave_mp") {
        playFX(scripts\engine\utility::getfx("zombie_freeze_shatter"), var_03);
        level.toads_killed++;
        if(scripts\engine\utility::array_contains(level.toad_ent_array, self)) {
          scripts\engine\utility::array_remove(level.toad_ent_array, self);
        }

        self setscriptablepartstate("quest_effects", "neutral");
      }

      if(self.health <= 0) {
        self delete();
      }
    }

    if(level.toads_killed >= 6) {
      level notify("toad_quest_complete");
      break;
    }
  }
}

getrandom_toad_spawn_points(param_00, param_01, param_02) {
  self endon("random_points_gotten");
  level endon("game_ended");
  var_03 = [];
  var_04 = 0;
  while(var_04 < param_02) {
    var_05 = getrandomnavpoint(param_00, param_01);
    if(distance2dsquared(var_05, param_00) <= 16384) {
      var_03[var_04] = var_05;
      var_04++;
      continue;
    }

    scripts\engine\utility::waitframe();
    continue;
    scripts\engine\utility::waitframe();
  }

  return var_03;
}

move_ents_in_random_directions(param_00) {
  level endon("game_ended");
  self endon("toad_quest_complete");
  for(;;) {
    foreach(var_02 in param_00) {
      var_03 = scripts\engine\utility::random(param_00);
      var_04 = gettime();
      thread move_ent_function(self, var_04, undefined, var_03);
    }

    self waittill("toad_movement_complete");
    self setscriptablepartstate("quest_effects", "neutral");
  }
}

move_ent_function(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("disconnect");
  self endon("toad_movement_complete");
  self setscriptablepartstate("quest_effects", "toad_move");
  while(gettime() < param_01 + 6000) {
    param_00 moveto(param_03.origin, 20, 1, 0);
    wait(10);
    self notify("toad_movement_complete");
  }
}

choose_new_dir(param_00, param_01) {
  level endon("game_ended");
  self endon("toad_quest_complete");
  var_02 = anglestoup(param_01);
  var_03 = anglestoright(param_01);
  var_04 = anglesToForward(param_01);
  var_05 = randomint(360);
  var_06 = randomint(360);
  var_07 = cos(var_06) * sin(var_05);
  var_08 = sin(var_06) * sin(var_05);
  var_09 = cos(var_05);
  var_0A = scripts\engine\utility::drop_to_ground(var_07 * var_03 + var_08 * var_04 + var_09 * var_02 / 0.33);
  return -1 * var_0A;
}

run_pacifier_quest(param_00) {
  level endon("game_ended");
  var_01 = [(-2451, -2592, 210), (-3540, -2591, 210), (-3559, -2690, 210), (-3075, -3178, 210)];
  var_02 = [(0, 78, 0), (0, -12, 0), (0, -12, 0), (0, 80, 0)];
  make_sure_area_is_clear();
  var_03 = [];
  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    var_05 = scripts\engine\utility::drop_to_ground(var_01[var_04], 12, -400);
    var_06 = spawn("script_model", var_05);
    var_06.angles = var_02[var_04];
    var_06 setModel("cp_rave_door_sized_collision");
    var_06 setscriptablepartstate("door_effect", "active");
    var_03[var_03.size] = var_06;
  }

  var_07 = wait_for_area_cleared(var_03);
  return isDefined(var_07);
}

wait_for_area_cleared(param_00) {
  level endon("game_ended");
  level endon("end_pacifier_quest_early");
  var_01 = (-2398, -2605, 100);
  var_02 = (-2542, -3300, 400);
  var_03 = (-3597, -2834, 100);
  var_04 = (-3476, -2375, 400);
  var_05 = 0;
  var_06 = 15;
  thread check_for_players_in_area(var_01, var_02, var_03, var_04, param_00);
  for(;;) {
    level waittill("zombie_killed", var_07, var_08, var_09, var_0A);
    if(isDefined(var_0A) && isplayer(var_0A)) {
      if(is_in_box(var_01, var_02, var_03, var_04, var_07)) {
        var_05++;
      }

      if(var_05 >= var_06) {
        break;
      }
    }
  }

  foreach(var_0C in param_00) {
    if(isDefined(var_0C)) {
      var_0C delete();
    }
  }

  return 1;
}

check_for_players_in_area(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  level endon("end_pacifier_quest_early");
  for(;;) {
    var_05 = 0;
    foreach(var_07 in level.players) {
      if(is_in_box(param_00, param_01, param_02, param_03, var_07.origin)) {
        var_05 = 1;
        break;
      }
    }

    if(!var_05) {
      foreach(var_0A in param_04) {
        if(isDefined(var_0A)) {
          var_0A delete();
        }
      }

      level notify("end_pacifier_quest_early");
    }

    wait(0.25);
  }
}

make_sure_area_is_clear() {
  var_00 = [(-3469, -2525, 100), (-3567, -2508, 100), (-3145, -3163, 100), (-3145, -3163, 100), (-2518, -2576, 100), (-2518, -2576, 100)];
  var_01 = [(-3560, -2701, 400), (-3560, -2701, 400), (-3057, -3181, 400), (-3057, -3181, 400), (-2430, -2594, 400), (-2430, -2594, 400)];
  var_02 = [(-3528, -2524, 100), (-3610, -2691, 100), (-3068, -3208, 100), (-3134, -3127, 100), (-2423, -2544, 100), (-2527, -2620, 100)];
  var_03 = [(-3522, -2711, 400), (-3528, -2524, 400), (-3152, -3206, 400), (-3053, -3144, 400), (-2510, -2532, 400), (-2446, -2642, 400)];
  var_04 = [(200, 0, 0), (-200, 0, 0), (0, -200, 0), (0, 200, 0), (0, 200, 0), (0, -200, 0)];
  foreach(var_06 in level.players) {
    for(var_07 = 0; var_07 < var_00.size; var_07++) {
      var_06 bump_check(var_00[var_07], var_01[var_07], var_02[var_07], var_03[var_07], var_04[var_07], var_07);
    }
  }
}

bump_check(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.standing_list)) {
    level.standing_list = [];
  }

  if(!isDefined(level.standing_list[param_05])) {
    level.standing_list[param_05] = [];
  }

  var_06 = 0;
  if(is_in_box(param_00, param_01, param_02, param_03)) {
    if(isDefined(level.standing_list[param_05][self.name])) {
      self setvelocity(vectornormalize(param_04) * 500);
      var_06 = 1;
    }

    if(!var_06) {
      level.standing_list[param_05][self.name] = 1;
      return;
    }

    level.standing_list[param_05][self.name] = undefined;
    return;
  }

  level.standing_list[param_05][self.name] = undefined;
}

is_in_box(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [param_00, param_01, param_02, param_03];
  if(!isDefined(param_04)) {
    if(isplayer(self) || isagent(self)) {
      param_04 = self.origin;
    } else {
      return 0;
    }
  }

  for(var_06 = 0; var_06 < 2; var_06++) {
    foreach(var_08 in var_05) {
      var_09 = 0;
      foreach(var_0B in var_05) {
        if(var_08 == var_0B) {
          continue;
        }

        if((param_04[var_06] > var_08[var_06] && param_04[var_06] < var_0B[var_06]) || param_04[var_06] > var_0B[var_06] && param_04[var_06] < var_08[var_06]) {
          break;
        } else {
          var_09++;
          if(var_09 > 2) {
            return 0;
          }
        }
      }
    }
  }

  return 1;
}

run_pool_ball_quest(param_00) {
  level endon("game_ended");
  var_01 = scripts\engine\utility::getstructarray("pool_balls", "targetname");
  param_00.total_pool_balls = 0;
  foreach(var_03 in var_01) {
    thread watch_for_player_damage(var_03, param_00, var_01.size);
  }

  wait_for_all_pool_balls_destroyed(param_00);
  return 1;
}

wait_for_all_pool_balls_destroyed(param_00) {
  level endon("game_ended");
  param_00 waittill("all_pool_balls_destroyed");
}

watch_for_player_damage(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00.model.health = 1;
  param_00.model.maxhealth = 1;
  param_00.model setCanDamage(1);
  for(;;) {
    param_00.model waittill("damage", var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C);
    param_00.model playsoundtoplayer("memory_quest_pool_ball", var_04);
    scripts\engine\utility::waitframe();
    param_01.total_pool_balls++;
    param_00.model delete();
    break;
  }

  if(param_01.total_pool_balls >= param_02) {
    param_01 notify("all_pool_balls_destroyed");
  }
}

run_ring_quest(param_00) {
  level endon("game_ended");
  if(isDefined(param_00.target)) {
    var_01 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  } else {
    var_01 = scripts\engine\utility::getstructarray("lanterns", "targetname");
  }

  foreach(var_03 in var_01) {
    var_03.script_noteworthy = "ring_quest_lights";
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
  }

  foreach(var_06 in var_01) {
    var_06.model setscriptablepartstate("model", "lantern_on");
  }

  level waittill("all_ring_pos_correct");
  foreach(var_06 in var_01) {
    var_06 thread adjust_light_angles(var_06);
  }

  wait(1);
  foreach(var_0B in level.players) {
    if(isDefined(param_00.currentlyownedby) && isDefined(param_00.currentlyownedby[var_0B.name])) {
      param_00.currentlyownedby[var_0B.name] setscriptablepartstate("idle_effects", "sparkle");
    }
  }

  foreach(var_0E in level.players) {
    var_0E scripts\cp\cp_interaction::refresh_interaction();
  }

  return 1;
}

adjust_light_angles(param_00) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00.model setscriptablepartstate("model", "lantern_on_angled");
  wait(1);
  param_00.model setscriptablepartstate("model", "lantern_off");
}

set_up_ring_quest_interactions() {
  var_00 = scripts\engine\utility::getstructarray("memory_quest_end_pos", "script_noteworthy");
  var_01 = randomintrange(1, 4);
  var_02 = undefined;
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.name) || var_02.name != "ring") {
      continue;
    } else {
      break;
    }
  }

  var_01 = randomintrange(1, 4);
  var_05 = scripts\engine\utility::getstructarray("lanterns", "targetname");
  foreach(var_07 in var_05) {
    var_07.script_noteworthy = "ring_quest_lights";
    var_07.requires_power = 0;
    var_07.powered_on = 1;
    var_07.script_parameters = "default";
    var_07.custom_search_dist = 128;
    var_07.times_rotated = 0;
    var_07.currentlyownedby = [];
    var_07.parent_struct = var_02;
    var_07.parent_struct.rotationgoal = var_01;
    var_07.parent_struct.correct_positions = [];
    var_07.model = spawn("script_model", var_07.origin);
    var_07.model setModel("tag_origin_memory_quest");
    var_07.model.angles = var_07.angles + (0, 90 * var_07.parent_struct.rotationgoal, 0);
    if(isDefined(var_07.target)) {
      var_07.fx_struct = scripts\engine\utility::getstruct(var_07.target, "targetname");
      var_07.fx_struct.angles = vectortoangles(scripts\engine\utility::getstruct(var_07.fx_struct.target, "targetname").origin - var_07.fx_struct.origin);
      var_07.fx_struct thread play_lantern_light_effects(var_07.model, var_07.fx_struct);
    }
  }
}

play_lantern_light_effects(param_00, param_01) {
  waittillframeend;
  param_00 setscriptablepartstate("model", "lantern_off");
}

run_lure_quest(param_00) {
  start_fish_path(param_00);
  return 1;
}

start_fish_path(param_00) {
  var_01 = scripts\engine\utility::getstructarray("lure_quest_struct", "script_noteworthy");
  var_02 = spawn("script_model", var_01[0].origin);
  var_02 endon("fish_quest_completed");
  var_02 setModel("tag_origin_memory_quest");
  var_02 setscriptablepartstate("quest_effects", "lure_fish");
  var_02 thread wait_for_player_damage(var_02, param_00);
  var_02 thread cleanup_fish_model(var_02);
  var_03 = 1;
  for(;;) {
    var_02 moveto(var_01[var_03].origin, 3);
    var_02 waittill("movedone");
    var_03++;
    if(var_03 >= var_01.size) {
      var_03 = 0;
    }
  }
}

wait_for_player_damage(param_00, param_01) {
  param_00.maxhealth = 1;
  param_00.health = 1;
  param_00 setCanDamage(1);
  param_00 waittill("damage");
  param_00 setscriptablepartstate("quest_effects", "lure_fish_explosion");
  param_00 notify("fish_quest_completed");
}

cleanup_fish_model(param_00) {
  param_00 waittill("fish_quest_completed");
  wait(3);
  param_00 delete();
}

run_arrowhead_quest(param_00) {
  level endon("game_ended");
  var_01 = 0;
  var_02 = getent("archery_clip", "targetname");
  for(;;) {
    var_03 = arrange_archery_targets();
    foreach(var_05 in var_03) {
      var_05 make_active_target(var_02, var_03);
      if(var_05 == var_03[0]) {
        var_02 waittill_archery_target_damaged(0, param_00);
      } else {
        var_01 = var_02 waittill_archery_target_damaged(1, param_00);
        if(!var_01) {
          break;
        }
      }

      playFX(level._effect["archery_hit_fx"], var_05.origin);
      var_06 = var_05;
      wait(0.25);
    }

    if(var_01) {
      break;
    } else {
      clear_archery_targets(var_03);
      play_archery_fail_buzzer(param_00);
      wait(2);
    }

    wait(0.1);
  }

  clear_archery_targets(var_03);
  return 1;
}

play_archery_fail_buzzer(param_00) {
  var_01 = 418;
  foreach(var_03 in level.players) {
    if(isDefined(var_03.rave_mode) && var_03.rave_mode && distance2d(param_00.origin, var_03.origin) <= var_01) {
      var_03 playlocalsound("archery_fail_buzzer");
    }
  }
}

waittill_archery_target_damaged(param_00, param_01) {
  if(param_00) {
    var_02 = 2;
    if(level.players.size == 4) {
      var_02 = 0.75;
    } else if(level.players.size == 3) {
      var_02 = 1;
    } else if(level.players.size == 2) {
      var_02 = 1.5;
    }

    var_03 = scripts\engine\utility::waittill_any_timeout_1(var_02, "damage");
    self setCanDamage(0);
    if(var_03 == "damage") {
      var_04 = 418;
      foreach(var_06 in level.players) {
        if(isDefined(var_06.rave_mode) && var_06.rave_mode && distance2d(param_01.origin, var_06.origin) <= var_04) {
          self playsoundtoplayer("memory_quest_target_hit", var_06);
        }
      }

      return 1;
    }

    return 0;
  }

  for(;;) {
    self waittill("damage", var_08, var_09);
    if(isDefined(var_09.rave_mode) && var_09.rave_mode) {
      var_04 = 418;
      foreach(var_06 in level.players) {
        if(isDefined(var_06.rave_mode) && var_06.rave_mode && distance2d(var_04.origin, var_06.origin) <= var_09) {
          self playsoundtoplayer("memory_quest_target_hit", var_06);
        }
      }

      return 1;
    }
  }
}

clear_archery_targets(param_00) {
  level.active_archery_target = undefined;
  foreach(var_02 in param_00) {
    if(isDefined(var_02.modelent)) {
      var_02.modelent delete();
      var_02.modelent = undefined;
    }
  }
}

make_active_target(param_00, param_01) {
  level endon("game_ended");
  clear_archery_targets(param_01);
  var_02 = spawn("script_model", self.origin);
  var_02 setModel("cp_rave_archery_target");
  var_02.angles = self.angles + (0, 0, -90);
  var_02 hide();
  foreach(var_04 in level.players) {
    if(isDefined(var_04.rave_mode) && var_04.rave_mode) {
      var_02 showtoplayer(var_04);
      continue;
    }

    var_02 hidefromplayer(var_04);
  }

  self.modelent = var_02;
  level.active_archery_target = var_02;
  param_00.origin = self.origin;
  param_00.angles = self.angles;
  param_00.health = 99999;
  wait(0.2);
  param_00 setCanDamage(1);
  foreach(var_04 in level.players) {
    if(isDefined(var_04.rave_mode) && var_04.rave_mode) {
      var_02 showtoplayer(var_04);
    }
  }
}

arrange_archery_targets(param_00) {
  var_01 = scripts\engine\utility::getstructarray("archery_quest_target", "script_noteworthy");
  var_02 = scripts\engine\utility::getstruct("last_archery_target", "targetname");
  var_01 = scripts\engine\utility::array_remove(var_01, var_02);
  var_01 = scripts\engine\utility::array_randomize(var_01);
  var_01[var_01.size] = var_02;
  return var_01;
}

run_shovel_quest(param_00) {
  level endon("game_ended");
  var_01 = 5;
  level.skeletons_alive = var_01;
  var_02 = 0;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  if(scripts\cp\zombies\zombies_spawning::num_zombies_available_to_spawn() < var_01) {
    var_03 = level.current_enemy_deaths;
    var_04 = level.max_static_spawned_enemies;
    var_05 = level.desired_enemy_deaths_this_wave;
    var_06 = level.wave_num;
    while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
      wait(0.05);
    }

    level.current_enemy_deaths = 0;
    level.desired_enemy_deaths_this_wave = 24;
    level.special_event = 1;
    scripts\engine\utility::flag_set("pause_wave_progression");
    level.zombies_paused = 1;
    var_02 = 1;
  }

  var_07 = scripts\engine\utility::getstruct("shovel_lightning_point", "script_noteworthy");
  var_08 = getent("shovel_mud", "script_noteworthy");
  playsoundatpos(var_07.origin, "memory_quest_lightning_strike");
  playFX(level._effect["hammer_of_dawn_lightning"], var_07.origin);
  var_08 delete();
  var_09 = determine_best_shovel_spawns(var_07.origin, var_01);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_01);
  wait(2);
  var_0A = skeleton_spawner(var_09);
  while(level.skeletons_alive > 0) {
    wait(0.1);
  }

  if(var_02) {
    level.spawndelayoverride = undefined;
    level.wave_num_override = undefined;
    level.special_event = undefined;
    level.zombies_paused = 0;
    scripts\engine\utility::flag_clear("pause_wave_progression");
    if(level.wave_num == var_06) {
      level.current_enemy_deaths = var_03;
      level.max_static_spawned_enemies = var_04;
      level.desired_enemy_deaths_this_wave = var_05;
    } else {
      level.current_enemy_deaths = 0;
      level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
      level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
    }
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_01);
  return 1;
}

determine_best_shovel_spawns(param_00, param_01) {
  var_02 = [];
  var_03 = scripts\engine\utility::getstructarray("camper_to_lake_spawner", "targetname");
  var_03 = sortbydistance(var_03, param_00);
  for(var_04 = 0; var_04 < param_01; var_04++) {
    var_02[var_04] = var_03[var_04];
  }

  var_05 = scripts\engine\utility::array_randomize(var_02);
  return var_02;
}

skeleton_spawner(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = spawn_skeleton_solo(param_00[var_02].origin);
    if(isDefined(var_03)) {
      var_03 thread skeleton_death_watcher();
      var_01[var_01.size] = var_03;
      var_03 thread skeleton_arrival_cowbell(param_00[var_02].origin);
      var_03 thread set_skeleton_attributes();
      wait(1);
      continue;
    }

    level.skeletons_alive--;
  }

  return var_01;
}

skeleton_death_watcher() {
  level endon("game_ended");
  self waittill("death");
  level.skeletons_alive--;
}

spawn_skeleton_solo(param_00) {
  param_00 = scripts\engine\utility::drop_to_ground(param_00, 30, -100);
  var_01 = spawnStruct();
  var_01.origin = param_00;
  var_01.script_parameters = "ground_spawn_no_boards";
  var_01.script_animation = "spawn_ground";
  var_02 = 4;
  var_03 = 0.3;
  for(var_04 = 0; var_04 < var_02; var_04++) {
    var_05 = var_01 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("skeleton", 1);
    wait(var_03);
    if(isDefined(var_05)) {
      return var_05;
    }
  }

  return undefined;
}

set_skeleton_attributes() {
  level endon("game_ended");
  self endon("death");
  self.dont_cleanup = 1;
  self.synctransients = "sprint";
  self.is_skeleton = 1;
  self.health = 5000;
  self waittill("intro_vignette_done");
  self.health = scripts\cp\zombies\cp_rave_spawning::calculatezombiehealth("skeleton");
}

skeleton_arrival_cowbell(param_00) {
  var_01 = (0, 0, -11);
  var_02 = spawnfx(level._effect["superslasher_summon_zombie_portal"], param_00 + var_01, (0, 0, 1), (1, 0, 0));
  triggerfx(var_02);
  scripts\engine\utility::waittill_any_3("death", "intro_vignette_done");
  var_02 delete();
}

run_tiki_quest(param_00) {
  level endon("game_ended");
  var_01 = getent("tiki_key", "targetname");
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = getent("tiki_key_clip", "targetname");
  var_03 = var_01.angles;
  var_04 = 10;
  var_05 = 0;
  var_06 = 0.05;
  var_01 rotatepitch(10, var_06);
  wait(var_06);
  playsoundatpos(var_01.origin, "memory_quest_key_jingle");
  for(var_07 = 0; var_07 < var_04; var_07++) {
    var_06 = var_06 + 0.05;
    if(var_05) {
      var_05 = 0;
      var_01 rotatepitch(20, var_06);
    } else {
      var_05 = 1;
      var_01 rotatepitch(-20, var_06);
    }

    wait(var_06);
  }

  var_01 rotateto(var_03, 0.15);
  wait(0.15);
  var_02 setCanDamage(1);
  var_02 waittill("damage");
  var_02 delete();
  var_08 = scripts\engine\utility::getstruct(var_01.target, "targetname");
  var_09 = scripts\engine\utility::getstruct(var_08.target, "targetname");
  var_0A = var_01.origin;
  var_0B = var_01.angles;
  var_01 moveto(var_08.origin, 0.1);
  var_01 rotateto(var_08.angles, 0.1);
  wait(0.1);
  var_01 moveto(var_09.origin, 0.25);
  var_01 rotateto(var_09.angles, 0.15);
  playsoundatpos(var_01.origin, "memory_quest_key_into_cup");
  return 1;
}

run_binocular_quest(param_00) {
  level endon("game_ended");
  var_01 = getent("gazebo_volume", "targetname");
  var_02 = scripts\engine\utility::getstruct("beach_target_struct_one", "targetname");
  var_03 = scripts\engine\utility::getstruct("beach_target_struct_two", "targetname");
  var_04 = scripts\engine\utility::getstruct("beach_target_struct_three", "targetname");
  var_05 = scripts\engine\utility::getstruct("beach_target_struct_four", "targetname");
  var_06 = scripts\engine\utility::getstruct("totem_struct_one", "targetname");
  var_07 = scripts\engine\utility::getstruct("totem_struct_two", "targetname");
  var_08 = scripts\engine\utility::getstruct("totem_struct_three", "targetname");
  var_09 = scripts\engine\utility::getstruct("totem_struct_four", "targetname");
  var_0A = [var_02, var_03, var_04, var_05];
  var_0B = [var_06, var_07, var_08, var_09];
  var_0C = 15;
  level thread check_for_beach_structs_shot(param_00, var_0A, var_01);
  level thread check_for_totem_poles_shot(param_00, var_0B, var_01);
  foreach(var_0E in level.players) {
    var_0E thread run_sniper_watcher(var_0E, param_00, var_01, var_0C);
  }

  level scripts\engine\utility::waittill_multiple("totem_part_complete", "sniper_quest_kills_done");
  scripts\engine\utility::waitframe();
  thread play_vfx_between_points_mem_quest_binoculars(param_00.origin, (-1806.99, 1061.74, 913));
  foreach(var_0E in level.players) {
    var_0E scripts\cp\cp_interaction::refresh_interaction();
  }

  level.sniper_quest_on = undefined;
  level.sniper_kills_for_quest = undefined;
  wait(5);
  return 1;
}

check_for_beach_structs_shot(param_00, param_01, param_02) {
  var_03 = [];
  if(!isDefined(level.totems_killed)) {
    level.totems_killed = 0;
  }

  foreach(var_05 in param_01) {
    var_05 = spawn("script_model", var_05.origin);
    var_05 setModel("cp_rave_neversoft_logo");
    var_05 setCanDamage(1);
    var_05.maxhealth = 5;
    var_05.health = 5;
    var_05 thread watch_for_totem_death(param_02);
  }
}

check_for_totem_poles_shot(param_00, param_01, param_02) {
  var_03 = [];
  level.totems_killed = 0;
  foreach(var_05 in param_01) {
    var_05 = spawn("script_model", var_05.origin);
    var_05 setModel("cp_rave_neversoft_logo");
    var_05 setCanDamage(1);
    var_05.maxhealth = 5;
    var_05.health = 5;
    var_05 thread watch_for_totem_death(param_02);
  }
}

watch_for_totem_death(param_00) {
  self endon("totem_part_complete");
  while(level.totems_killed < 8) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isplayer(var_02) && !isagent(var_02)) {
      continue;
    }

    if(ispointinvolume(var_02.origin, param_00)) {
      level.totems_killed++;
      playFX(level._effect["zombie_freeze_shatter"], var_04);
      var_02 playlocalsound("part_pickup");
      if(self.health < 0) {
        self delete();
      }
    }
  }

  if(level.totems_killed >= 8) {
    level notify("totem_part_complete");
  }
}

run_sniper_watcher(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  level endon("sniper_quest_kills_done");
  param_00 notifyonplayercommand("binoculars_ads_in", "+speed_throw");
  param_00 notifyonplayercommand("binoculars_ads_out", "-speed_throw");
  param_00 notifyonplayercommand("binoculars_ads_in", "+toggleads_throw");
  param_00 notifyonplayercommand("binoculars_ads_in", "+ads_akimbo_accessible");
  param_00 notifyonplayercommand("binoculars_ads_out", "-toggleads_throw");
  param_00 notifyonplayercommand("binoculars_ads_out", "-ads_akimbo_accessible");
  param_00 thread sniper_kills_watcher(param_01, param_00, param_02, param_03);
  for(;;) {
    var_04 = param_00 scripts\engine\utility::waittill_any_return("binoculars_ads_in");
    if(param_00 scripts\cp\utility::coop_getweaponclass(param_00 getcurrentweapon()) == "weapon_sniper") {
      if(var_04 == "binoculars_ads_in") {
        level.sniper_quest_on = 1;
        if(!isDefined(level.sniper_kills_for_quest)) {
          level.sniper_kills_for_quest = 0;
        }
      } else {
        level.sniper_quest_on = 0;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

sniper_kills_watcher(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  level endon("sniper_quest_kills_done");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(!isDefined(level.sniper_quest_on) || !isDefined(level.sniper_kills_for_quest)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(level.sniper_kills_for_quest < param_03) {
      level waittill("kill_near_bino_with_sniper", var_04, var_05, var_06);
      if(ispointinvolume(var_04.origin, param_02)) {
        if(var_04 == param_01) {
          if(!isDefined(level.sniper_kills_for_quest)) {
            level.sniper_kills_for_quest = 1;
          } else {
            level.sniper_kills_for_quest++;
          }

          var_04 playlocalsound("part_pickup");
        }
      }
    }

    if(level.sniper_kills_for_quest >= param_03) {
      foreach(param_01 in level.players) {
        param_01 playlocalsound("part_pickup");
      }

      level notify("sniper_quest_kills_done");
    }

    scripts\engine\utility::waitframe();
  }
}

play_vfx_between_points_mem_quest_binoculars(param_00, param_01) {
  var_02 = spawnfx(scripts\engine\utility::getfx("mem_release_lrg"), param_00);
  var_03 = spawnfx(scripts\engine\utility::getfx("mem_soul_trail"), param_01);
  triggerfx(var_02);
  wait(5);
  var_02 delete();
}

run_boots_quest(param_00) {
  level endon("game_ended");
  var_01 = scripts\engine\utility::getstruct("boot_spooky_guy", "targetname");
  var_02 = scripts\engine\utility::getstruct(var_01.target, "targetname");
  var_03 = undefined;
  var_04 = scripts\engine\utility::getstruct("footprint_start", "targetname");
  var_05 = var_04;
  var_06 = 0;
  var_07 = 0;
  for(;;) {
    var_07 = var_05 bootprint_logic(var_07);
    if(!isDefined(var_05.target)) {
      break;
    } else {
      var_05 = scripts\engine\utility::getstruct(var_05.target, "targetname");
    }
  }

  var_03 = spawn("script_model", var_01.origin);
  var_03.angles = var_01.angles;
  var_03 setModel("body_zmb_slasher");
  var_03 hide();
  var_08 = spawn("script_model", var_01.origin);
  var_08 setModel("weapon_zmb_slasher_vm");
  var_08 hide();
  var_08.origin = var_03 gettagorigin("tag_inhand");
  var_08.angles = var_03 gettagangles("tag_inhand");
  var_08 linkto(var_03, "tag_inhand");
  while(!var_06) {
    foreach(var_0A in level.players) {
      if(distance2dsquared(var_0A.origin, var_02.origin) <= 26896) {
        if(scripts\engine\utility::within_fov(var_0A.origin, var_0A getplayerangles(), var_03.origin, 0.83)) {
          var_06 = 1;
          break;
        }
      }
    }

    wait(0.1);
  }

  thread mus_slasher_stinger(var_02, var_03, 0);
  wait(0.5);
  var_08 show();
  var_03 show();
  var_03 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_03.origin, var_03.angles);
  var_0C = getanimlength( % iw7_cp_slasher_walk_forward_01);
  wait(var_0C);
  var_03 delete();
  var_08 delete();
  var_01 = scripts\engine\utility::getstruct("boot_spooky_guy_2", "targetname");
  if(!isDefined(var_01)) {
    return 1;
  }

  var_02 = scripts\engine\utility::getstruct(var_01.target, "targetname");
  var_03 = undefined;
  var_04 = scripts\engine\utility::getstruct("footprint_start_2", "targetname");
  var_05 = var_04;
  var_06 = 0;
  var_07 = 0;
  for(;;) {
    var_07 = var_05 bootprint_logic(var_07);
    if(!isDefined(var_05.target)) {
      break;
    } else {
      var_05 = scripts\engine\utility::getstruct(var_05.target, "targetname");
    }
  }

  var_03 = spawn("script_model", var_01.origin);
  var_03.angles = var_01.angles;
  var_03 setModel("body_zmb_slasher");
  var_03 hide();
  var_08 = spawn("script_model", var_01.origin);
  var_08 setModel("weapon_zmb_slasher_vm");
  var_08 hide();
  var_08.origin = var_03 gettagorigin("tag_inhand");
  var_08.angles = var_03 gettagangles("tag_inhand");
  var_08 linkto(var_03, "tag_inhand");
  while(!var_06) {
    foreach(var_0A in level.players) {
      if(distance2dsquared(var_0A.origin, var_02.origin) <= 26896) {
        if(scripts\engine\utility::within_fov(var_0A.origin, var_0A getplayerangles(), var_03.origin, 0.83)) {
          var_06 = 1;
          break;
        }
      }
    }

    wait(0.1);
  }

  thread mus_slasher_stinger(var_02, var_03, 0.2);
  wait(0.5);
  var_08 show();
  var_03 show();
  var_03 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_03.origin, var_03.angles);
  var_0C = getanimlength( % iw7_cp_slasher_walk_forward_01);
  wait(var_0C);
  var_03 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_03.origin, var_03.angles);
  wait(var_0C * 0.75);
  var_03 delete();
  var_08 delete();
  var_01 = scripts\engine\utility::getstruct("boot_spooky_guy_3", "targetname");
  var_02 = scripts\engine\utility::getstruct(var_01.target, "targetname");
  var_03 = undefined;
  var_04 = scripts\engine\utility::getstruct("footprint_start_3", "targetname");
  var_05 = var_04;
  var_06 = 0;
  var_07 = 0;
  for(;;) {
    var_07 = var_05 bootprint_logic(var_07);
    if(!isDefined(var_05.target)) {
      break;
    } else {
      var_05 = scripts\engine\utility::getstruct(var_05.target, "targetname");
    }
  }

  var_03 = spawn("script_model", var_01.origin);
  var_03.angles = var_01.angles;
  var_03 setModel("body_zmb_slasher");
  var_03 hide();
  var_08 = spawn("script_model", var_01.origin);
  var_08 setModel("weapon_zmb_slasher_vm");
  var_08 hide();
  var_08.origin = var_03 gettagorigin("tag_inhand");
  var_08.angles = var_03 gettagangles("tag_inhand");
  var_08 linkto(var_03, "tag_inhand");
  while(!var_06) {
    foreach(var_0A in level.players) {
      if(distance2dsquared(var_0A.origin, var_02.origin) <= 26896) {
        if(scripts\engine\utility::within_fov(var_0A.origin, var_0A getplayerangles(), var_03.origin, 0.83)) {
          var_06 = 1;
          break;
        }
      }
    }

    wait(0.1);
  }

  thread mus_slasher_stinger(var_02, var_03, 0);
  wait(0.5);
  var_08 show();
  var_03 show();
  var_03 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_03.origin, var_03.angles);
  var_0C = getanimlength( % iw7_cp_slasher_walk_forward_01);
  wait(var_0C * 0.8);
  var_03 delete();
  var_08 delete();
  return 1;
}

bootprint_logic(param_00) {
  var_01 = 0;
  var_02 = "left_footprint";
  if(param_00) {
    var_02 = "right_footprint";
  }

  var_03 = getgroundposition(self.origin, 15, 30, 30);
  self.bootprint = spawnfx(level._effect[var_02], var_03, anglesToForward(self.angles), anglestoup(self.angles));
  wait(0.1);
  triggerfx(self.bootprint);
  playsoundatpos(var_03, "boot_quest_foot_creak");
  wait(2);
  while(!var_01) {
    foreach(var_05 in level.players) {
      if(distance2dsquared(var_05.origin, var_03) <= 16384) {
        if(scripts\engine\utility::within_fov(var_05.origin, var_05 getplayerangles(), var_03, 0.5)) {
          var_01 = 1;
          break;
        }
      }
    }

    wait(0.5);
  }

  self.bootprint delete();
  if(param_00) {
    return 0;
  }

  return 1;
}

memory_start_hint_func(param_00, param_01) {
  return "";
}

memory_quest_start_func(param_00, param_01) {
  if(!param_01 scripts\cp\utility::is_valid_player()) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  scripts\cp\maps\cp_rave\cp_rave::remove_from_current_rave_interaction_list(param_00);
  param_00.ravetriggered = 0;
  param_01 playlocalsound("part_pickup");
  setplayeritemfromstructid(param_00, param_01);
  enable_end_struct(param_00, param_01);
  param_01 notify("charm_switched");
  param_00 watch_for_charm_disowned(param_00, param_01);
  foreach(var_03 in level.players) {
    var_03 scripts\cp\cp_interaction::refresh_interaction();
    var_03 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_03);
  }
}

watch_for_charm_disowned(param_00, param_01) {
  param_00 thread wait_for_start_charm_disowned(param_00, param_01);
  level thread charm_start_watchforplayerdisconnect(param_00, param_01);
  param_01 thread watchforstartcharmweaponremoved(param_00, param_01);
}

charm_start_watchforplayerdisconnect(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("charm_placed");
  param_00 endon("charm_disowned");
  param_01 waittill("disconnect");
  param_00 notify("charm_disowned");
}

wait_for_start_charm_disowned(param_00, param_01) {
  param_00 endon("charm_placed");
  param_00 waittill("charm_disowned");
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(param_00);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00.end_struct);
  scripts\cp\maps\cp_rave\cp_rave::remove_from_current_rave_interaction_list(param_00.end_struct);
  param_00.ravetriggered = 1;
  foreach(var_03 in level.players) {
    var_03 scripts\cp\cp_interaction::refresh_interaction();
    var_03 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_03);
  }
}

watchforstartcharmweaponremoved(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  param_00 endon("charm_disowned");
  param_00 endon("charm_placed");
  var_02 = 1;
  for(;;) {
    if(!var_02) {
      break;
    }

    param_01 waittill("charm_switched");
    if(!isDefined(param_01.has_memory_quest_item) || param_01.has_memory_quest_item != param_00.has_memory_quest_item) {
      var_02 = 0;
    }
  }

  param_00 notify("charm_disowned");
}

enable_end_struct(param_00, param_01) {
  if(!isDefined(param_00.has_memory_quest_item)) {
    return;
  }

  var_02 = scripts\engine\utility::getstructarray("memory_quest_end_pos", "script_noteworthy");
  foreach(var_04 in var_02) {
    if(param_00.has_memory_quest_item == var_04.name) {
      param_00.end_struct = var_04;
      var_04.starting_struct = param_00;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_04);
      scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_04);
    }
  }
}

setplayeritemfromstructid(param_00, param_01) {
  if(!isDefined(param_00.id)) {
    return;
  }

  switch (param_00.id) {
    case "pacifier":
      param_01.has_memory_quest_item = "pacifier";
      param_00.has_memory_quest_item = "pacifier";
      param_01 setclientomnvar("zm_hud_inventory_1", 9);
      break;

    case "shovel":
      param_01.has_memory_quest_item = "shovel";
      param_00.has_memory_quest_item = "shovel";
      param_01 setclientomnvar("zm_hud_inventory_1", 2);
      break;

    case "tiki_mask":
      param_01.has_memory_quest_item = "tiki_mask";
      param_00.has_memory_quest_item = "tiki_mask";
      param_01 setclientomnvar("zm_hud_inventory_1", 5);
      break;

    case "arrowhead":
      param_01.has_memory_quest_item = "arrowhead";
      param_00.has_memory_quest_item = "arrowhead";
      param_01 setclientomnvar("zm_hud_inventory_1", 3);
      break;

    case "lure":
      param_01.has_memory_quest_item = "lure";
      param_00.has_memory_quest_item = "lure";
      param_01 setclientomnvar("zm_hud_inventory_1", 7);
      break;

    case "toad":
      param_01.has_memory_quest_item = "toad";
      param_00.has_memory_quest_item = "toad";
      param_01 setclientomnvar("zm_hud_inventory_1", 8);
      break;

    case "pool_ball":
      param_01.has_memory_quest_item = "pool_ball";
      param_00.has_memory_quest_item = "pool_ball";
      param_01 setclientomnvar("zm_hud_inventory_1", 6);
      break;

    case "ring":
      param_01.has_memory_quest_item = "ring";
      param_00.has_memory_quest_item = "ring";
      param_01 setclientomnvar("zm_hud_inventory_1", 4);
      break;

    case "binoculars":
      param_01.has_memory_quest_item = "binoculars";
      param_00.has_memory_quest_item = "binoculars";
      param_01 setclientomnvar("zm_hud_inventory_1", 1);
      break;

    case "boots":
      param_01.has_memory_quest_item = "boots";
      param_00.has_memory_quest_item = "boots";
      param_01 setclientomnvar("zm_hud_inventory_1", 10);
      break;
  }
}

mus_slasher_stinger(param_00, param_01, param_02) {
  wait(param_02);
  foreach(var_04 in level.players) {
    if(distance2dsquared(var_04.origin, param_00.origin) <= 26896) {
      if(scripts\engine\utility::within_fov(var_04.origin, var_04 getplayerangles(), param_01.origin, 0.83)) {
        level.player playlocalsound("mus_zmb_rave_slasher_stinger");
      }
    }
  }
}
/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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

return_closest_memory_item(var_0) {
  return scripts\engine\utility::getclosest(var_0.origin, level.memory_quest_items);
}

ent_near_item(var_0, var_1) {
  if(level.memory_quest_items.size < 1) {
    return 0;
  }

  var_2 = 0;
  foreach(var_4 in level.memory_quest_items) {
    var_5 = 562500;
    if(!isDefined(var_4) || scripts\engine\utility::istrue(var_4.fully_charged)) {
      continue;
    }

    if(distancesquared(var_4.origin, var_0.origin) < var_5) {
      var_2 = 1;
    }

    if(var_2) {
      break;
    }
  }

  if(var_2) {
    return 1;
  }

  return 0;
}

memories_end_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.quest_complete)) {
    return &"CP_RAVE_INSPECT_ITEM";
  }

  return "";
}

memories_end_use_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.quest_restart)) {
    var_0.quest_restart = undefined;
    var_1 playlocalsound("part_pickup");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    thread run_memory_release_quest(var_0);
    return;
  }

  if(isDefined(var_1.has_memory_quest_item) && isDefined(var_0.name) && var_1.has_memory_quest_item == var_0.name) {
    var_1 setclientomnvar("zm_hud_inventory_1", 0);
    switch (var_0.name) {
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

    var_1.has_memory_quest_item = undefined;
    var_0.activated = 1;
    var_0.starting_struct notify("charm_placed");
    var_1 playlocalsound("part_pickup");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    if(isDefined(var_0.target)) {
      var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
      var_2.name = var_0.name;
      var_2.activated = 1;
      var_2.script_noteworthy = "memory_quest_end_pos";
      scripts\cp\maps\cp_rave\cp_rave::remove_from_current_rave_interaction_list(var_0);
      scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_2);
    } else {
      scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_0);
    }

    foreach(var_4 in level.players) {
      var_4 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_4);
    }

    thread run_memory_release_quest(var_0);
    return;
  }

  if(scripts\engine\utility::istrue(var_0.quest_complete)) {
    var_1 playlocalsound("part_pickup");
    if(isDefined(var_0.currentlyownedby[var_1.name])) {
      var_0.currentlyownedby[var_1.name] setscriptablepartstate("quest_effects", "memory_release");
    }

    play_memory_vo(var_0);
    playFX(scripts\engine\utility::getfx("mem_release_lrg"), var_0.origin);
    if(!scripts\engine\utility::istrue(var_0.player_has_charm)) {
      var_6 = level.rave_charm_attachment[var_0.name];
      if(scripts\cp\maps\cp_rave\cp_rave::rave_add_attachment_to_weapon(var_6, var_1)) {
        foreach(var_4 in level.players) {
          var_4 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_4);
        }

        thread watch_for_charm_removed(var_0, var_1, level.rave_charm_attachment[var_0.name]);
        return;
      }

      return;
    }

    return;
  }
}

watch_for_charm_removed(var_0, var_1, var_2) {
  var_0.player_has_charm = 1;
  var_0 thread wait_for_charm_disowned(var_0, var_2, var_1);
  level thread watchforplayerdisconnect(var_0, var_1, var_2);
  var_1 thread watchforcharmweaponremoved(var_0, var_1, var_2);
  var_1 thread watchforplayerdeath(var_0, var_1, var_2);
}

wait_for_charm_disowned(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 waittill("charm_disowned_" + var_1);
  var_0.player_has_charm = 0;
  if(isDefined(var_2)) {
    if(isDefined(level.rave_charm_attachment_perks[var_1])) {
      var_2 scripts\cp\maps\cp_rave\cp_rave::takeraveperk(level.rave_charm_attachment_perks[var_1], var_1);
    }
  }

  foreach(var_4 in level.players) {
    var_4 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_4);
  }
}

watchforcharmweaponremoved(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("last_stand");
  var_1 endon("disconnect");
  var_0 endon("charm_disowned_" + var_2);
  var_3 = 1;
  for(;;) {
    if(!var_3) {
      break;
    }

    var_1 scripts\engine\utility::waittill_any("weapon_purchased", "mule_munchies_sold");
    var_3 = 0;
    var_4 = var_1 getweaponslistall();
    foreach(var_6 in var_4) {
      if(scripts\cp\utility::weaponhasattachment(var_6, var_2)) {
        var_3 = 1;
        break;
      }
    }
  }

  var_0 notify("charm_disowned_" + var_2);
}

watchforplayerdisconnect(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("charm_disowned_" + var_2);
  var_1 waittill("disconnect");
  var_0 notify("charm_disowned_" + var_2);
}

watchforplayerdeath(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_0 endon("charm_disowned_" + var_2);
  var_3 = 1;
  for(;;) {
    if(!var_3) {
      break;
    }

    var_4 = undefined;
    var_1 waittill("last_stand");
    if(isDefined(level.rave_charm_attachment_perks[var_2])) {
      var_1 scripts\cp\maps\cp_rave\cp_rave::takeraveperk(level.rave_charm_attachment_perks[var_2], var_2);
    }

    var_3 = 0;
    var_5 = var_1 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive", "death");
    if(var_5 != "revive") {
      var_4 = var_1 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
      if(isDefined(var_4) && var_4 == "lost_and_found_time_out") {
        continue;
      }
    }

    var_6 = var_1 getweaponslistall();
    foreach(var_8 in var_6) {
      if(scripts\cp\utility::weaponhasattachment(var_8, var_2)) {
        var_1 thread watchforcharmweaponremoved(var_0, var_1, var_2);
        var_3 = 1;
        if(isDefined(level.rave_charm_attachment_perks[var_2])) {
          var_1 scripts\cp\maps\cp_rave\cp_rave::giveraveperk(level.rave_charm_attachment_perks[var_2], var_2);
        }

        break;
      }
    }
  }

  var_0 notify("charm_disowned_" + var_2);
}

ring_quest_use_func(var_0, var_1) {
  var_0.model ghost_killed_update_func((0, -90, 0), 0.5);
  var_0.times_rotated++;
  if(var_0.times_rotated == var_0.parent_struct.rotationgoal) {
    var_0.parent_struct.correct_positions[var_0.parent_struct.correct_positions.size] = var_0;
  } else if(scripts\engine\utility::array_contains(var_0.parent_struct.correct_positions, var_0)) {
    var_0.parent_struct.correct_positions = scripts\engine\utility::array_remove(var_0.parent_struct.correct_positions, var_0);
  }

  if(var_0.parent_struct.correct_positions.size == 2) {
    level notify("all_ring_pos_correct");
  }

  if(var_0.parent_struct.correct_positions.size < 0) {
    var_0.parent_struct.correct_positions = [];
  }

  if(var_0.times_rotated > var_0.parent_struct.rotationgoal) {
    var_0.times_rotated = 0;
  }

  wait(0.5);
}

ring_quest_hint_func(var_0, var_1) {
  return "";
}

run_memory_release_quest(var_0) {
  var_1 = getquestfromid(var_0);
  for(;;) {
    if([
        [var_1]
      ](var_0)) {
      playsoundatpos(var_0.origin, "zmb_quest_complete");
      break;
    } else {
      var_0.quest_restart = 1;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
      return;
    }
  }

  var_0.quest_complete = 1;
  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_3);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

play_memory_vo(var_0) {
  switch (var_0.name) {
    case "pacifier":
      var_0 thread play_memory_to_nearby_players("m2_wwlyer_daughter");
      break;

    case "shovel":
      var_0 thread play_memory_to_nearby_players("m3_dwapner_crew");
      break;

    case "tiki_mask":
      var_0 thread play_memory_to_nearby_players("m5_jgeiger_costar");
      break;

    case "arrowhead":
      var_0 thread play_memory_to_nearby_players("m4_alimaye_triberep");
      break;

    case "lure":
      var_0 thread play_memory_to_nearby_players("m6_rjones_pi");
      break;

    case "toad":
      var_0 thread play_memory_to_nearby_players("m8_tramon_manager");
      break;

    case "pool_ball":
      var_0 thread play_memory_to_nearby_players("m1_carya_student");
      break;

    case "ring":
      var_0 thread play_memory_to_nearby_players("m7_mmason_soninlaw");
      break;

    case "binoculars":
      var_0 thread play_memory_to_nearby_players("m9_bmax_starlet");
      break;

    case "boots":
      var_0 thread play_memory_to_nearby_players("m10_ghudson_foreman");
      break;

    default:
      break;
  }
}

play_memory_to_nearby_players(var_0, var_1) {
  var_2 = [];
  var_3 = 512;
  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  foreach(var_5 in level.players) {
    if(distance2d(self.origin, var_5.origin) <= var_3) {
      var_2[var_2.size] = var_5;
    }
  }

  var_7 = level.memory_quest_vo_progression[var_0];
  var_8 = var_0 + "_" + level.memory_quest_vo_progression[var_0];
  thread remove_interaction_for_vo_length(self, var_0, var_8);
  foreach(var_5 in var_2) {
    if(soundexists(var_8)) {
      var_5 thread scripts\cp\cp_vo::try_to_play_vo(var_8, "rave_memory_vo");
      level.memory_quest_vo_progression[var_0]++;
      if(!soundexists(var_0 + "_" + level.memory_quest_vo_progression[var_0])) {
        level.memory_quest_vo_progression[var_0] = 1;
      }

      wait(scripts\cp\cp_vo::get_sound_length(var_8));
      if(var_7 == 3) {
        var_5 thread play_memory_reaction_vo(var_8);
      }

      continue;
    }

    if(soundexists(var_0)) {
      var_5 thread scripts\cp\cp_vo::try_to_play_vo(var_0, "rave_memory_vo");
      wait(scripts\cp\cp_vo::get_sound_length(var_0));
      if(var_7 == 3) {
        var_5 thread play_memory_reaction_vo(var_0);
      }
    }
  }
}

play_memory_reaction_vo(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = var_1[1];
  switch (var_2) {
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

remove_interaction_for_vo_length(var_0, var_1, var_2) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(soundexists(var_2)) {
    wait(lookupsoundlength(var_2) / 1000);
  } else if(soundexists(var_1)) {
    wait(lookupsoundlength(var_1) / 1000);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

getquestfromid(var_0) {
  if(!isDefined(var_0.name)) {
    returnscripts\cp\maps\cp_rave\cp_rave_interactions::collect_zombie_souls;
  }

  switch (var_0.name) {
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
      returnscripts\cp\maps\cp_rave\cp_rave_interactions::collect_zombie_souls;
  }
}

run_toad_quest(var_0) {
  level endon("game_ended");
  level.toads_killed = 0;
  level.toad_ent_array = [];
  var_1 = scripts\engine\utility::getstruct("toad_move_struct_one", "targetname");
  var_2 = scripts\engine\utility::getstruct("toad_move_struct_two", "targetname");
  var_3 = scripts\engine\utility::getstruct("toad_move_struct_three", "targetname");
  var_4 = scripts\engine\utility::getstruct("toad_move_struct_four", "targetname");
  var_5 = scripts\engine\utility::getstruct("toad_move_struct_five", "targetname");
  var_6 = scripts\engine\utility::getstruct("toad_move_struct_six", "targetname");
  var_7 = scripts\engine\utility::getstruct("toad_move_struct_seven", "targetname");
  var_8 = scripts\engine\utility::getstruct("toad_move_struct_eight", "targetname");
  var_9 = scripts\engine\utility::getstruct("toad_move_struct_nine", "targetname");
  var_10 = scripts\engine\utility::getstruct("toad_move_struct_ten", "targetname");
  var_11 = [var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10];
  var_12 = 0;
  for(var_12 = 0; var_12 < 10; var_12++) {
    if(var_12 <= 5) {
      var_13 = scripts\engine\utility::random(var_11);
      level.toad_ent_array[var_12] = spawn("script_model", var_13.origin, 0, 64, 32);
      level.toad_ent_array[var_12] setModel("tag_origin_memory_quest");
      level.toad_ent_array[var_12] setCanDamage(1);
      level.toad_ent_array[var_12].maxhealth = 5;
      level.toad_ent_array[var_12].health = 5;
      level.toad_ent_array[var_12] playLoopSound("memory_quest_frogs");
      level.toad_ent_array[var_12] thread move_ents_in_random_directions(var_11);
      level.toad_ent_array[var_12] thread watch_for_ground_pound_on_toad();
    }
  }

  level waittill("toad_quest_complete");
  foreach(var_15 in level.toad_ent_array) {
    if(isDefined(var_15)) {
      var_15 delete();
    }
  }

  level.toad_ent_array = undefined;
  level.toads_killed = undefined;
  var_11 = undefined;
  return 1;
}

watch_for_ground_pound_on_toad() {
  level endon("game_ended");
  self endon("toad_quest_complete");
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(var_9 != "zom_groundpound_rave_mp") {
      self.health = 5;
    }

    if(isplayer(var_1)) {
      if(var_9 == "zom_groundpound_rave_mp") {
        playFX(scripts\engine\utility::getfx("zombie_freeze_shatter"), var_3);
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

getrandom_toad_spawn_points(var_0, var_1, var_2) {
  self endon("random_points_gotten");
  level endon("game_ended");
  var_3 = [];
  var_4 = 0;
  while(var_4 < var_2) {
    var_5 = getrandomnavpoint(var_0, var_1);
    if(distance2dsquared(var_5, var_0) <= 16384) {
      var_3[var_4] = var_5;
      var_4++;
      continue;
    }

    scripts\engine\utility::waitframe();
    continue;
    scripts\engine\utility::waitframe();
  }

  return var_3;
}

move_ents_in_random_directions(var_0) {
  level endon("game_ended");
  self endon("toad_quest_complete");
  for(;;) {
    foreach(var_2 in var_0) {
      var_3 = scripts\engine\utility::random(var_0);
      var_4 = gettime();
      thread move_ent_function(self, var_4, undefined, var_3);
    }

    self waittill("toad_movement_complete");
    self setscriptablepartstate("quest_effects", "neutral");
  }
}

move_ent_function(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("disconnect");
  self endon("toad_movement_complete");
  self setscriptablepartstate("quest_effects", "toad_move");
  while(gettime() < var_1 + 6000) {
    var_0 moveto(var_3.origin, 20, 1, 0);
    wait(10);
    self notify("toad_movement_complete");
  }
}

choose_new_dir(var_0, var_1) {
  level endon("game_ended");
  self endon("toad_quest_complete");
  var_2 = anglestoup(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglesToForward(var_1);
  var_5 = randomint(360);
  var_6 = randomint(360);
  var_7 = cos(var_6) * sin(var_5);
  var_8 = sin(var_6) * sin(var_5);
  var_9 = cos(var_5);
  var_10 = scripts\engine\utility::drop_to_ground(var_7 * var_3 + var_8 * var_4 + var_9 * var_2 / 0.33);
  return -1 * var_10;
}

run_pacifier_quest(var_0) {
  level endon("game_ended");
  var_1 = [(-2451, -2592, 210), (-3540, -2591, 210), (-3559, -2690, 210), (-3075, -3178, 210)];
  var_2 = [(0, 78, 0), (0, -12, 0), (0, -12, 0), (0, 80, 0)];
  make_sure_area_is_clear();
  var_3 = [];
  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = scripts\engine\utility::drop_to_ground(var_1[var_4], 12, -400);
    var_6 = spawn("script_model", var_5);
    var_6.angles = var_2[var_4];
    var_6 setModel("cp_rave_door_sized_collision");
    var_6 setscriptablepartstate("door_effect", "active");
    var_3[var_3.size] = var_6;
  }

  var_7 = wait_for_area_cleared(var_3);
  return isDefined(var_7);
}

wait_for_area_cleared(var_0) {
  level endon("game_ended");
  level endon("end_pacifier_quest_early");
  var_1 = (-2398, -2605, 100);
  var_2 = (-2542, -3300, 400);
  var_3 = (-3597, -2834, 100);
  var_4 = (-3476, -2375, 400);
  var_5 = 0;
  var_6 = 15;
  thread check_for_players_in_area(var_1, var_2, var_3, var_4, var_0);
  for(;;) {
    level waittill("zombie_killed", var_7, var_8, var_9, var_10);
    if(isDefined(var_10) && isplayer(var_10)) {
      if(is_in_box(var_1, var_2, var_3, var_4, var_7)) {
        var_5++;
      }

      if(var_5 >= var_6) {
        break;
      }
    }
  }

  foreach(var_12 in var_0) {
    if(isDefined(var_12)) {
      var_12 delete();
    }
  }

  return 1;
}

check_for_players_in_area(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level endon("end_pacifier_quest_early");
  for(;;) {
    var_5 = 0;
    foreach(var_7 in level.players) {
      if(is_in_box(var_0, var_1, var_2, var_3, var_7.origin)) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      foreach(var_10 in var_4) {
        if(isDefined(var_10)) {
          var_10 delete();
        }
      }

      level notify("end_pacifier_quest_early");
    }

    wait(0.25);
  }
}

make_sure_area_is_clear() {
  var_0 = [(-3469, -2525, 100), (-3567, -2508, 100), (-3145, -3163, 100), (-3145, -3163, 100), (-2518, -2576, 100), (-2518, -2576, 100)];
  var_1 = [(-3560, -2701, 400), (-3560, -2701, 400), (-3057, -3181, 400), (-3057, -3181, 400), (-2430, -2594, 400), (-2430, -2594, 400)];
  var_2 = [(-3528, -2524, 100), (-3610, -2691, 100), (-3068, -3208, 100), (-3134, -3127, 100), (-2423, -2544, 100), (-2527, -2620, 100)];
  var_3 = [(-3522, -2711, 400), (-3528, -2524, 400), (-3152, -3206, 400), (-3053, -3144, 400), (-2510, -2532, 400), (-2446, -2642, 400)];
  var_4 = [(200, 0, 0), (-200, 0, 0), (0, -200, 0), (0, 200, 0), (0, 200, 0), (0, -200, 0)];
  foreach(var_6 in level.players) {
    for(var_7 = 0; var_7 < var_0.size; var_7++) {
      var_6 bump_check(var_0[var_7], var_1[var_7], var_2[var_7], var_3[var_7], var_4[var_7], var_7);
    }
  }
}

bump_check(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.standing_list)) {
    level.standing_list = [];
  }

  if(!isDefined(level.standing_list[var_5])) {
    level.standing_list[var_5] = [];
  }

  var_6 = 0;
  if(is_in_box(var_0, var_1, var_2, var_3)) {
    if(isDefined(level.standing_list[var_5][self.name])) {
      self setvelocity(vectornormalize(var_4) * 500);
      var_6 = 1;
    }

    if(!var_6) {
      level.standing_list[var_5][self.name] = 1;
      return;
    }

    level.standing_list[var_5][self.name] = undefined;
    return;
  }

  level.standing_list[var_5][self.name] = undefined;
}

is_in_box(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [var_0, var_1, var_2, var_3];
  if(!isDefined(var_4)) {
    if(isplayer(self) || isagent(self)) {
      var_4 = self.origin;
    } else {
      return 0;
    }
  }

  for(var_6 = 0; var_6 < 2; var_6++) {
    foreach(var_8 in var_5) {
      var_9 = 0;
      foreach(var_11 in var_5) {
        if(var_8 == var_11) {
          continue;
        }

        if((var_4[var_6] > var_8[var_6] && var_4[var_6] < var_11[var_6]) || var_4[var_6] > var_11[var_6] && var_4[var_6] < var_8[var_6]) {
          break;
        } else {
          var_9++;
          if(var_9 > 2) {
            return 0;
          }
        }
      }
    }
  }

  return 1;
}

run_pool_ball_quest(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::getstructarray("pool_balls", "targetname");
  var_0.total_pool_balls = 0;
  foreach(var_3 in var_1) {
    thread watch_for_player_damage(var_3, var_0, var_1.size);
  }

  wait_for_all_pool_balls_destroyed(var_0);
  return 1;
}

wait_for_all_pool_balls_destroyed(var_0) {
  level endon("game_ended");
  var_0 waittill("all_pool_balls_destroyed");
}

watch_for_player_damage(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0.model.health = 1;
  var_0.model.maxhealth = 1;
  var_0.model setCanDamage(1);
  for(;;) {
    var_0.model waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_0.model playsoundtoplayer("memory_quest_pool_ball", var_4);
    scripts\engine\utility::waitframe();
    var_1.total_pool_balls++;
    var_0.model delete();
    break;
  }

  if(var_1.total_pool_balls >= var_2) {
    var_1 notify("all_pool_balls_destroyed");
  }
}

run_ring_quest(var_0) {
  level endon("game_ended");
  if(isDefined(var_0.target)) {
    var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  } else {
    var_1 = scripts\engine\utility::getstructarray("lanterns", "targetname");
  }

  foreach(var_3 in var_1) {
    var_3.script_noteworthy = "ring_quest_lights";
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
  }

  foreach(var_6 in var_1) {
    var_6.model setscriptablepartstate("model", "lantern_on");
  }

  level waittill("all_ring_pos_correct");
  foreach(var_6 in var_1) {
    var_6 thread adjust_light_angles(var_6);
  }

  wait(1);
  foreach(var_11 in level.players) {
    if(isDefined(var_0.currentlyownedby) && isDefined(var_0.currentlyownedby[var_11.name])) {
      var_0.currentlyownedby[var_11.name] setscriptablepartstate("idle_effects", "sparkle");
    }
  }

  foreach(var_14 in level.players) {
    var_14 scripts\cp\cp_interaction::refresh_interaction();
  }

  return 1;
}

adjust_light_angles(var_0) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.model setscriptablepartstate("model", "lantern_on_angled");
  wait(1);
  var_0.model setscriptablepartstate("model", "lantern_off");
}

set_up_ring_quest_interactions() {
  var_0 = scripts\engine\utility::getstructarray("memory_quest_end_pos", "script_noteworthy");
  var_1 = randomintrange(1, 4);
  var_2 = undefined;
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.name) || var_2.name != "ring") {
      continue;
    } else {
      break;
    }
  }

  var_1 = randomintrange(1, 4);
  var_5 = scripts\engine\utility::getstructarray("lanterns", "targetname");
  foreach(var_7 in var_5) {
    var_7.script_noteworthy = "ring_quest_lights";
    var_7.requires_power = 0;
    var_7.powered_on = 1;
    var_7.script_parameters = "default";
    var_7.custom_search_dist = 128;
    var_7.times_rotated = 0;
    var_7.currentlyownedby = [];
    var_7.parent_struct = var_2;
    var_7.parent_struct.rotationgoal = var_1;
    var_7.parent_struct.correct_positions = [];
    var_7.model = spawn("script_model", var_7.origin);
    var_7.model setModel("tag_origin_memory_quest");
    var_7.model.angles = var_7.angles + (0, 90 * var_7.parent_struct.rotationgoal, 0);
    if(isDefined(var_7.target)) {
      var_7.fx_struct = scripts\engine\utility::getstruct(var_7.target, "targetname");
      var_7.fx_struct.angles = vectortoangles(scripts\engine\utility::getstruct(var_7.fx_struct.target, "targetname").origin - var_7.fx_struct.origin);
      var_7.fx_struct thread play_lantern_light_effects(var_7.model, var_7.fx_struct);
    }
  }
}

play_lantern_light_effects(var_0, var_1) {
  waittillframeend;
  var_0 setscriptablepartstate("model", "lantern_off");
}

run_lure_quest(var_0) {
  start_fish_path(var_0);
  return 1;
}

start_fish_path(var_0) {
  var_1 = scripts\engine\utility::getstructarray("lure_quest_struct", "script_noteworthy");
  var_2 = spawn("script_model", var_1[0].origin);
  var_2 endon("fish_quest_completed");
  var_2 setModel("tag_origin_memory_quest");
  var_2 setscriptablepartstate("quest_effects", "lure_fish");
  var_2 thread wait_for_player_damage(var_2, var_0);
  var_2 thread cleanup_fish_model(var_2);
  var_3 = 1;
  for(;;) {
    var_2 moveto(var_1[var_3].origin, 3);
    var_2 waittill("movedone");
    var_3++;
    if(var_3 >= var_1.size) {
      var_3 = 0;
    }
  }
}

wait_for_player_damage(var_0, var_1) {
  var_0.maxhealth = 1;
  var_0.health = 1;
  var_0 setCanDamage(1);
  var_0 waittill("damage");
  var_0 setscriptablepartstate("quest_effects", "lure_fish_explosion");
  var_0 notify("fish_quest_completed");
}

cleanup_fish_model(var_0) {
  var_0 waittill("fish_quest_completed");
  wait(3);
  var_0 delete();
}

run_arrowhead_quest(var_0) {
  level endon("game_ended");
  var_1 = 0;
  var_2 = getent("archery_clip", "targetname");
  for(;;) {
    var_3 = arrange_archery_targets();
    foreach(var_5 in var_3) {
      var_5 make_active_target(var_2, var_3);
      if(var_5 == var_3[0]) {
        var_2 waittill_archery_target_damaged(0, var_0);
      } else {
        var_1 = var_2 waittill_archery_target_damaged(1, var_0);
        if(!var_1) {
          break;
        }
      }

      playFX(level._effect["archery_hit_fx"], var_5.origin);
      var_6 = var_5;
      wait(0.25);
    }

    if(var_1) {
      break;
    } else {
      clear_archery_targets(var_3);
      play_archery_fail_buzzer(var_0);
      wait(2);
    }

    wait(0.1);
  }

  clear_archery_targets(var_3);
  return 1;
}

play_archery_fail_buzzer(var_0) {
  var_1 = 418;
  foreach(var_3 in level.players) {
    if(isDefined(var_3.rave_mode) && var_3.rave_mode && distance2d(var_0.origin, var_3.origin) <= var_1) {
      var_3 playlocalsound("archery_fail_buzzer");
    }
  }
}

waittill_archery_target_damaged(var_0, var_1) {
  if(var_0) {
    var_2 = 2;
    if(level.players.size == 4) {
      var_2 = 0.75;
    } else if(level.players.size == 3) {
      var_2 = 1;
    } else if(level.players.size == 2) {
      var_2 = 1.5;
    }

    var_3 = scripts\engine\utility::waittill_any_timeout(var_2, "damage");
    self setCanDamage(0);
    if(var_3 == "damage") {
      var_4 = 418;
      foreach(var_6 in level.players) {
        if(isDefined(var_6.rave_mode) && var_6.rave_mode && distance2d(var_1.origin, var_6.origin) <= var_4) {
          self playsoundtoplayer("memory_quest_target_hit", var_6);
        }
      }

      return 1;
    }

    return 0;
  }

  for(;;) {
    self waittill("damage", var_8, var_9);
    if(isDefined(var_9.rave_mode) && var_9.rave_mode) {
      var_4 = 418;
      foreach(var_6 in level.players) {
        if(isDefined(var_6.rave_mode) && var_6.rave_mode && distance2d(var_4.origin, var_6.origin) <= var_9) {
          self playsoundtoplayer("memory_quest_target_hit", var_6);
        }
      }

      return 1;
    }
  }
}

clear_archery_targets(var_0) {
  level.active_archery_target = undefined;
  foreach(var_2 in var_0) {
    if(isDefined(var_2.modelent)) {
      var_2.modelent delete();
      var_2.modelent = undefined;
    }
  }
}

make_active_target(var_0, var_1) {
  level endon("game_ended");
  clear_archery_targets(var_1);
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("cp_rave_archery_target");
  var_2.angles = self.angles + (0, 0, -90);
  var_2 hide();
  foreach(var_4 in level.players) {
    if(isDefined(var_4.rave_mode) && var_4.rave_mode) {
      var_2 showtoplayer(var_4);
      continue;
    }

    var_2 hidefromplayer(var_4);
  }

  self.modelent = var_2;
  level.active_archery_target = var_2;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0.health = 99999;
  wait(0.2);
  var_0 setCanDamage(1);
  foreach(var_4 in level.players) {
    if(isDefined(var_4.rave_mode) && var_4.rave_mode) {
      var_2 showtoplayer(var_4);
    }
  }
}

arrange_archery_targets(var_0) {
  var_1 = scripts\engine\utility::getstructarray("archery_quest_target", "script_noteworthy");
  var_2 = scripts\engine\utility::getstruct("last_archery_target", "targetname");
  var_1 = scripts\engine\utility::array_remove(var_1, var_2);
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_1[var_1.size] = var_2;
  return var_1;
}

run_shovel_quest(var_0) {
  level endon("game_ended");
  var_1 = 5;
  level.skeletons_alive = var_1;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  if(scripts\cp\zombies\zombies_spawning::num_zombies_available_to_spawn() < var_1) {
    var_3 = level.current_enemy_deaths;
    var_4 = level.max_static_spawned_enemies;
    var_5 = level.desired_enemy_deaths_this_wave;
    var_6 = level.wave_num;
    while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
      wait(0.05);
    }

    level.current_enemy_deaths = 0;
    level.desired_enemy_deaths_this_wave = 24;
    level.special_event = 1;
    scripts\engine\utility::flag_set("pause_wave_progression");
    level.zombies_paused = 1;
    var_2 = 1;
  }

  var_7 = scripts\engine\utility::getstruct("shovel_lightning_point", "script_noteworthy");
  var_8 = getent("shovel_mud", "script_noteworthy");
  playsoundatpos(var_7.origin, "memory_quest_lightning_strike");
  playFX(level._effect["hammer_of_dawn_lightning"], var_7.origin);
  var_8 delete();
  var_9 = determine_best_shovel_spawns(var_7.origin, var_1);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_1);
  wait(2);
  var_10 = skeleton_spawner(var_9);
  while(level.skeletons_alive > 0) {
    wait(0.1);
  }

  if(var_2) {
    level.spawndelayoverride = undefined;
    level.wave_num_override = undefined;
    level.special_event = undefined;
    level.zombies_paused = 0;
    scripts\engine\utility::flag_clear("pause_wave_progression");
    if(level.wave_num == var_6) {
      level.current_enemy_deaths = var_3;
      level.max_static_spawned_enemies = var_4;
      level.desired_enemy_deaths_this_wave = var_5;
    } else {
      level.current_enemy_deaths = 0;
      level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
      level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
    }
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_1);
  return 1;
}

determine_best_shovel_spawns(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\utility::getstructarray("camper_to_lake_spawner", "targetname");
  var_3 = sortbydistance(var_3, var_0);
  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_2[var_4] = var_3[var_4];
  }

  var_5 = scripts\engine\utility::array_randomize(var_2);
  return var_2;
}

skeleton_spawner(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = spawn_skeleton_solo(var_0[var_2].origin);
    if(isDefined(var_3)) {
      var_3 thread skeleton_death_watcher();
      var_1[var_1.size] = var_3;
      var_3 thread skeleton_arrival_cowbell(var_0[var_2].origin);
      var_3 thread set_skeleton_attributes();
      wait(1);
      continue;
    }

    level.skeletons_alive--;
  }

  return var_1;
}

skeleton_death_watcher() {
  level endon("game_ended");
  self waittill("death");
  level.skeletons_alive--;
}

spawn_skeleton_solo(var_0) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 30, -100);
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.script_parameters = "ground_spawn_no_boards";
  var_1.script_animation = "spawn_ground";
  var_2 = 4;
  var_3 = 0.3;
  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = var_1 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("skeleton", 1);
    wait(var_3);
    if(isDefined(var_5)) {
      return var_5;
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

skeleton_arrival_cowbell(var_0) {
  var_1 = (0, 0, -11);
  var_2 = spawnfx(level._effect["superslasher_summon_zombie_portal"], var_0 + var_1, (0, 0, 1), (1, 0, 0));
  triggerfx(var_2);
  scripts\engine\utility::waittill_any("death", "intro_vignette_done");
  var_2 delete();
}

run_tiki_quest(var_0) {
  level endon("game_ended");
  var_1 = getent("tiki_key", "targetname");
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = getent("tiki_key_clip", "targetname");
  var_3 = var_1.angles;
  var_4 = 10;
  var_5 = 0;
  var_6 = 0.05;
  var_1 rotatepitch(10, var_6);
  wait(var_6);
  playsoundatpos(var_1.origin, "memory_quest_key_jingle");
  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_6 = var_6 + 0.05;
    if(var_5) {
      var_5 = 0;
      var_1 rotatepitch(20, var_6);
    } else {
      var_5 = 1;
      var_1 rotatepitch(-20, var_6);
    }

    wait(var_6);
  }

  var_1 rotateto(var_3, 0.15);
  wait(0.15);
  var_2 setCanDamage(1);
  var_2 waittill("damage");
  var_2 delete();
  var_8 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_9 = scripts\engine\utility::getstruct(var_8.target, "targetname");
  var_10 = var_1.origin;
  var_11 = var_1.angles;
  var_1 moveto(var_8.origin, 0.1);
  var_1 rotateto(var_8.angles, 0.1);
  wait(0.1);
  var_1 moveto(var_9.origin, 0.25);
  var_1 rotateto(var_9.angles, 0.15);
  playsoundatpos(var_1.origin, "memory_quest_key_into_cup");
  return 1;
}

run_binocular_quest(var_0) {
  level endon("game_ended");
  var_1 = getent("gazebo_volume", "targetname");
  var_2 = scripts\engine\utility::getstruct("beach_target_struct_one", "targetname");
  var_3 = scripts\engine\utility::getstruct("beach_target_struct_two", "targetname");
  var_4 = scripts\engine\utility::getstruct("beach_target_struct_three", "targetname");
  var_5 = scripts\engine\utility::getstruct("beach_target_struct_four", "targetname");
  var_6 = scripts\engine\utility::getstruct("totem_struct_one", "targetname");
  var_7 = scripts\engine\utility::getstruct("totem_struct_two", "targetname");
  var_8 = scripts\engine\utility::getstruct("totem_struct_three", "targetname");
  var_9 = scripts\engine\utility::getstruct("totem_struct_four", "targetname");
  var_10 = [var_2, var_3, var_4, var_5];
  var_11 = [var_6, var_7, var_8, var_9];
  var_12 = 15;
  level thread check_for_beach_structs_shot(var_0, var_10, var_1);
  level thread check_for_totem_poles_shot(var_0, var_11, var_1);
  foreach(var_14 in level.players) {
    var_14 thread run_sniper_watcher(var_14, var_0, var_1, var_12);
  }

  level scripts\engine\utility::waittill_multiple("totem_part_complete", "sniper_quest_kills_done");
  scripts\engine\utility::waitframe();
  thread play_vfx_between_points_mem_quest_binoculars(var_0.origin, (-1806.99, 1061.74, 913));
  foreach(var_14 in level.players) {
    var_14 scripts\cp\cp_interaction::refresh_interaction();
  }

  level.sniper_quest_on = undefined;
  level.sniper_kills_for_quest = undefined;
  wait(5);
  return 1;
}

check_for_beach_structs_shot(var_0, var_1, var_2) {
  var_3 = [];
  if(!isDefined(level.totems_killed)) {
    level.totems_killed = 0;
  }

  foreach(var_5 in var_1) {
    var_5 = spawn("script_model", var_5.origin);
    var_5 setModel("cp_rave_neversoft_logo");
    var_5 setCanDamage(1);
    var_5.maxhealth = 5;
    var_5.health = 5;
    var_5 thread watch_for_totem_death(var_2);
  }
}

check_for_totem_poles_shot(var_0, var_1, var_2) {
  var_3 = [];
  level.totems_killed = 0;
  foreach(var_5 in var_1) {
    var_5 = spawn("script_model", var_5.origin);
    var_5 setModel("cp_rave_neversoft_logo");
    var_5 setCanDamage(1);
    var_5.maxhealth = 5;
    var_5.health = 5;
    var_5 thread watch_for_totem_death(var_2);
  }
}

watch_for_totem_death(var_0) {
  self endon("totem_part_complete");
  while(level.totems_killed < 8) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    if(!isplayer(var_2) && !isagent(var_2)) {
      continue;
    }

    if(ispointinvolume(var_2.origin, var_0)) {
      level.totems_killed++;
      playFX(level._effect["zombie_freeze_shatter"], var_4);
      var_2 playlocalsound("part_pickup");
      if(self.health < 0) {
        self delete();
      }
    }
  }

  if(level.totems_killed >= 8) {
    level notify("totem_part_complete");
  }
}

run_sniper_watcher(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  level endon("sniper_quest_kills_done");
  var_0 notifyonplayercommand("binoculars_ads_in", "+speed_throw");
  var_0 notifyonplayercommand("binoculars_ads_out", "-speed_throw");
  var_0 notifyonplayercommand("binoculars_ads_in", "+toggleads_throw");
  var_0 notifyonplayercommand("binoculars_ads_in", "+ads_akimbo_accessible");
  var_0 notifyonplayercommand("binoculars_ads_out", "-toggleads_throw");
  var_0 notifyonplayercommand("binoculars_ads_out", "-ads_akimbo_accessible");
  var_0 thread sniper_kills_watcher(var_1, var_0, var_2, var_3);
  for(;;) {
    var_4 = var_0 scripts\engine\utility::waittill_any_return("binoculars_ads_in");
    if(var_0 scripts\cp\utility::coop_getweaponclass(var_0 getcurrentweapon()) == "weapon_sniper") {
      if(var_4 == "binoculars_ads_in") {
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

sniper_kills_watcher(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("sniper_quest_kills_done");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(!isDefined(level.sniper_quest_on) || !isDefined(level.sniper_kills_for_quest)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(level.sniper_kills_for_quest < var_3) {
      level waittill("kill_near_bino_with_sniper", var_4, var_5, var_6);
      if(ispointinvolume(var_4.origin, var_2)) {
        if(var_4 == var_1) {
          if(!isDefined(level.sniper_kills_for_quest)) {
            level.sniper_kills_for_quest = 1;
          } else {
            level.sniper_kills_for_quest++;
          }

          var_4 playlocalsound("part_pickup");
        }
      }
    }

    if(level.sniper_kills_for_quest >= var_3) {
      foreach(var_1 in level.players) {
        var_1 playlocalsound("part_pickup");
      }

      level notify("sniper_quest_kills_done");
    }

    scripts\engine\utility::waitframe();
  }
}

play_vfx_between_points_mem_quest_binoculars(var_0, var_1) {
  var_2 = spawnfx(scripts\engine\utility::getfx("mem_release_lrg"), var_0);
  var_3 = spawnfx(scripts\engine\utility::getfx("mem_soul_trail"), var_1);
  triggerfx(var_2);
  wait(5);
  var_2 delete();
}

run_boots_quest(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::getstruct("boot_spooky_guy", "targetname");
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_3 = undefined;
  var_4 = scripts\engine\utility::getstruct("footprint_start", "targetname");
  var_5 = var_4;
  var_6 = 0;
  var_7 = 0;
  for(;;) {
    var_7 = var_5 bootprint_logic(var_7);
    if(!isDefined(var_5.target)) {
      break;
    } else {
      var_5 = scripts\engine\utility::getstruct(var_5.target, "targetname");
    }
  }

  var_3 = spawn("script_model", var_1.origin);
  var_3.angles = var_1.angles;
  var_3 setModel("body_zmb_slasher");
  var_3 hide();
  var_8 = spawn("script_model", var_1.origin);
  var_8 setModel("weapon_zmb_slasher_vm");
  var_8 hide();
  var_8.origin = var_3 gettagorigin("tag_inhand");
  var_8.angles = var_3 gettagangles("tag_inhand");
  var_8 linkto(var_3, "tag_inhand");
  while(!var_6) {
    foreach(var_10 in level.players) {
      if(distance2dsquared(var_10.origin, var_2.origin) <= 26896) {
        if(scripts\engine\utility::within_fov(var_10.origin, var_10 getplayerangles(), var_3.origin, 0.83)) {
          var_6 = 1;
          break;
        }
      }
    }

    wait(0.1);
  }

  thread mus_slasher_stinger(var_2, var_3, 0);
  wait(0.5);
  var_8 show();
  var_3 show();
  var_3 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_3.origin, var_3.angles);
  var_12 = getanimlength( % iw7_cp_slasher_walk_forward_01);
  wait(var_12);
  var_3 delete();
  var_8 delete();
  var_1 = scripts\engine\utility::getstruct("boot_spooky_guy_2", "targetname");
  if(!isDefined(var_1)) {
    return 1;
  }

  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_3 = undefined;
  var_4 = scripts\engine\utility::getstruct("footprint_start_2", "targetname");
  var_5 = var_4;
  var_6 = 0;
  var_7 = 0;
  for(;;) {
    var_7 = var_5 bootprint_logic(var_7);
    if(!isDefined(var_5.target)) {
      break;
    } else {
      var_5 = scripts\engine\utility::getstruct(var_5.target, "targetname");
    }
  }

  var_3 = spawn("script_model", var_1.origin);
  var_3.angles = var_1.angles;
  var_3 setModel("body_zmb_slasher");
  var_3 hide();
  var_8 = spawn("script_model", var_1.origin);
  var_8 setModel("weapon_zmb_slasher_vm");
  var_8 hide();
  var_8.origin = var_3 gettagorigin("tag_inhand");
  var_8.angles = var_3 gettagangles("tag_inhand");
  var_8 linkto(var_3, "tag_inhand");
  while(!var_6) {
    foreach(var_10 in level.players) {
      if(distance2dsquared(var_10.origin, var_2.origin) <= 26896) {
        if(scripts\engine\utility::within_fov(var_10.origin, var_10 getplayerangles(), var_3.origin, 0.83)) {
          var_6 = 1;
          break;
        }
      }
    }

    wait(0.1);
  }

  thread mus_slasher_stinger(var_2, var_3, 0.2);
  wait(0.5);
  var_8 show();
  var_3 show();
  var_3 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_3.origin, var_3.angles);
  var_12 = getanimlength( % iw7_cp_slasher_walk_forward_01);
  wait(var_12);
  var_3 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_3.origin, var_3.angles);
  wait(var_12 * 0.75);
  var_3 delete();
  var_8 delete();
  var_1 = scripts\engine\utility::getstruct("boot_spooky_guy_3", "targetname");
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_3 = undefined;
  var_4 = scripts\engine\utility::getstruct("footprint_start_3", "targetname");
  var_5 = var_4;
  var_6 = 0;
  var_7 = 0;
  for(;;) {
    var_7 = var_5 bootprint_logic(var_7);
    if(!isDefined(var_5.target)) {
      break;
    } else {
      var_5 = scripts\engine\utility::getstruct(var_5.target, "targetname");
    }
  }

  var_3 = spawn("script_model", var_1.origin);
  var_3.angles = var_1.angles;
  var_3 setModel("body_zmb_slasher");
  var_3 hide();
  var_8 = spawn("script_model", var_1.origin);
  var_8 setModel("weapon_zmb_slasher_vm");
  var_8 hide();
  var_8.origin = var_3 gettagorigin("tag_inhand");
  var_8.angles = var_3 gettagangles("tag_inhand");
  var_8 linkto(var_3, "tag_inhand");
  while(!var_6) {
    foreach(var_10 in level.players) {
      if(distance2dsquared(var_10.origin, var_2.origin) <= 26896) {
        if(scripts\engine\utility::within_fov(var_10.origin, var_10 getplayerangles(), var_3.origin, 0.83)) {
          var_6 = 1;
          break;
        }
      }
    }

    wait(0.1);
  }

  thread mus_slasher_stinger(var_2, var_3, 0);
  wait(0.5);
  var_8 show();
  var_3 show();
  var_3 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01", var_3.origin, var_3.angles);
  var_12 = getanimlength( % iw7_cp_slasher_walk_forward_01);
  wait(var_12 * 0.8);
  var_3 delete();
  var_8 delete();
  return 1;
}

bootprint_logic(var_0) {
  var_1 = 0;
  var_2 = "left_footprint";
  if(var_0) {
    var_2 = "right_footprint";
  }

  var_3 = getgroundposition(self.origin, 15, 30, 30);
  self.bootprint = spawnfx(level._effect[var_2], var_3, anglesToForward(self.angles), anglestoup(self.angles));
  wait(0.1);
  triggerfx(self.bootprint);
  playsoundatpos(var_3, "boot_quest_foot_creak");
  wait(2);
  while(!var_1) {
    foreach(var_5 in level.players) {
      if(distance2dsquared(var_5.origin, var_3) <= 16384) {
        if(scripts\engine\utility::within_fov(var_5.origin, var_5 getplayerangles(), var_3, 0.5)) {
          var_1 = 1;
          break;
        }
      }
    }

    wait(0.5);
  }

  self.bootprint delete();
  if(var_0) {
    return 0;
  }

  return 1;
}

memory_start_hint_func(var_0, var_1) {
  return "";
}

memory_quest_start_func(var_0, var_1) {
  if(!var_1 scripts\cp\utility::is_valid_player()) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\cp\maps\cp_rave\cp_rave::remove_from_current_rave_interaction_list(var_0);
  var_0.ravetriggered = 0;
  var_1 playlocalsound("part_pickup");
  setplayeritemfromstructid(var_0, var_1);
  enable_end_struct(var_0, var_1);
  var_1 notify("charm_switched");
  var_0 watch_for_charm_disowned(var_0, var_1);
  foreach(var_3 in level.players) {
    var_3 scripts\cp\cp_interaction::refresh_interaction();
    var_3 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_3);
  }
}

watch_for_charm_disowned(var_0, var_1) {
  var_0 thread wait_for_start_charm_disowned(var_0, var_1);
  level thread charm_start_watchforplayerdisconnect(var_0, var_1);
  var_1 thread watchforstartcharmweaponremoved(var_0, var_1);
}

charm_start_watchforplayerdisconnect(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("charm_placed");
  var_0 endon("charm_disowned");
  var_1 waittill("disconnect");
  var_0 notify("charm_disowned");
}

wait_for_start_charm_disowned(var_0, var_1) {
  var_0 endon("charm_placed");
  var_0 waittill("charm_disowned");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0.end_struct);
  scripts\cp\maps\cp_rave\cp_rave::remove_from_current_rave_interaction_list(var_0.end_struct);
  var_0.ravetriggered = 1;
  foreach(var_3 in level.players) {
    var_3 scripts\cp\cp_interaction::refresh_interaction();
    var_3 thread scripts\cp\maps\cp_rave\cp_rave_interactions::update_rave_mode_for_player(var_3);
  }
}

watchforstartcharmweaponremoved(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_0 endon("charm_disowned");
  var_0 endon("charm_placed");
  var_2 = 1;
  for(;;) {
    if(!var_2) {
      break;
    }

    var_1 waittill("charm_switched");
    if(!isDefined(var_1.has_memory_quest_item) || var_1.has_memory_quest_item != var_0.has_memory_quest_item) {
      var_2 = 0;
    }
  }

  var_0 notify("charm_disowned");
}

enable_end_struct(var_0, var_1) {
  if(!isDefined(var_0.has_memory_quest_item)) {
    return;
  }

  var_2 = scripts\engine\utility::getstructarray("memory_quest_end_pos", "script_noteworthy");
  foreach(var_4 in var_2) {
    if(var_0.has_memory_quest_item == var_4.name) {
      var_0.end_struct = var_4;
      var_4.starting_struct = var_0;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
      scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_4);
    }
  }
}

setplayeritemfromstructid(var_0, var_1) {
  if(!isDefined(var_0.id)) {
    return;
  }

  switch (var_0.id) {
    case "pacifier":
      var_1.has_memory_quest_item = "pacifier";
      var_0.has_memory_quest_item = "pacifier";
      var_1 setclientomnvar("zm_hud_inventory_1", 9);
      break;

    case "shovel":
      var_1.has_memory_quest_item = "shovel";
      var_0.has_memory_quest_item = "shovel";
      var_1 setclientomnvar("zm_hud_inventory_1", 2);
      break;

    case "tiki_mask":
      var_1.has_memory_quest_item = "tiki_mask";
      var_0.has_memory_quest_item = "tiki_mask";
      var_1 setclientomnvar("zm_hud_inventory_1", 5);
      break;

    case "arrowhead":
      var_1.has_memory_quest_item = "arrowhead";
      var_0.has_memory_quest_item = "arrowhead";
      var_1 setclientomnvar("zm_hud_inventory_1", 3);
      break;

    case "lure":
      var_1.has_memory_quest_item = "lure";
      var_0.has_memory_quest_item = "lure";
      var_1 setclientomnvar("zm_hud_inventory_1", 7);
      break;

    case "toad":
      var_1.has_memory_quest_item = "toad";
      var_0.has_memory_quest_item = "toad";
      var_1 setclientomnvar("zm_hud_inventory_1", 8);
      break;

    case "pool_ball":
      var_1.has_memory_quest_item = "pool_ball";
      var_0.has_memory_quest_item = "pool_ball";
      var_1 setclientomnvar("zm_hud_inventory_1", 6);
      break;

    case "ring":
      var_1.has_memory_quest_item = "ring";
      var_0.has_memory_quest_item = "ring";
      var_1 setclientomnvar("zm_hud_inventory_1", 4);
      break;

    case "binoculars":
      var_1.has_memory_quest_item = "binoculars";
      var_0.has_memory_quest_item = "binoculars";
      var_1 setclientomnvar("zm_hud_inventory_1", 1);
      break;

    case "boots":
      var_1.has_memory_quest_item = "boots";
      var_0.has_memory_quest_item = "boots";
      var_1 setclientomnvar("zm_hud_inventory_1", 10);
      break;
  }
}

mus_slasher_stinger(var_0, var_1, var_2) {
  wait(var_2);
  foreach(var_4 in level.players) {
    if(distance2dsquared(var_4.origin, var_0.origin) <= 26896) {
      if(scripts\engine\utility::within_fov(var_4.origin, var_4 getplayerangles(), var_1.origin, 0.83)) {
        level.player playlocalsound("mus_zmb_rave_slasher_stinger");
      }
    }
  }
}
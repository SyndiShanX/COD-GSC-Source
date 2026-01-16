/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_openareas.gsc
********************************************************/

init_all_debris_and_door_positions() {
  func_F945("debris_350");
  func_F945("debris_1000");
  func_F945("debris_1500");
  func_F945("debris_2000");
  func_F945("debris_1250");
  func_F945("debris_750");
  func_F945("team_door_switch");
  func_F945("chi_0");
  func_F945("chi_1");
  func_F945("chi_2");
}

func_F945(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    set_nonstick(var_3);
  }
}

set_nonstick(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    var_3 setnonstick(1);
    wait(0.1);
  }
}

func_102F3(var_0, var_1) {
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_0);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_0.script_area);
  playsoundatpos(var_0.origin, "zmb_sliding_door_open");
  var_2 = getEntArray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    var_4 connectpaths();
    var_5 = scripts\engine\utility::getstruct(var_4.target, "targetname");
    var_4 moveto(var_5.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  if(level.players.size > 1) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
    return;
  }

  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 1, 1, 40);
}

use_team_door_switch(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  if(!isDefined(level.var_115C8)) {
    level.var_115C8 = 0;
  }

  switch (var_0.script_side) {
    case "moon":
      if(!isDefined(level.moon_donations)) {
        level.moon_donations = -1;
      }

      level.moon_donations++;
      var_3 = level.moon_donations;
      scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, var_1, var_0.script_side, 1000, level.wave_num);
      break;

    case "kepler":
      if(!isDefined(level.kepler_donations)) {
        level.kepler_donations = -1;
      }

      level.kepler_donations++;
      var_3 = level.kepler_donations;
      scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, var_1, var_0.script_side, 1000, level.wave_num);
      break;

    case "triton":
      if(!isDefined(level.triton_donations)) {
        level.triton_donations = -1;
      }

      level.triton_donations++;
      var_3 = level.triton_donations;
      scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, var_1, var_0.script_side, 1000, level.wave_num);
      break;
  }

  var_4 = getEntArray(var_0.target, "targetname");
  foreach(var_6 in var_4) {
    if(!isDefined(var_6.script_noteworthy)) {
      continue;
    } else if(var_6.script_noteworthy == "progress") {
      var_6 movez(4, 0.1);
      var_6 waittill("movedone");
    }
  }

  if(var_3 >= 3) {
    level thread func_C61B(var_0, var_2, var_3, var_1);
    var_1 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
    var_1 notify("door_opened_notify");
    level.var_115C8++;
    if(level.var_115C8 == 2) {
      scripts\engine\utility::flag_set("canFiresale");
    }
  }

  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      var_1 scripts\cp\cp_persistence::give_player_xp(250, 1);
    }
  } else if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_1 scripts\cp\cp_persistence::give_player_xp(75, 1);
  }

  var_1 scripts\cp\cp_interaction::refresh_interaction();
}

func_C61B(var_0, var_1, var_2, var_3) {
  scripts\cp\zombies\zombie_analytics::func_AF7E(1, var_3, var_0.script_side, 1000, level.wave_num);
  thread func_115B2(var_0);
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_4 = scripts\cp\cp_interaction::get_linked_interactions(var_0);
  foreach(var_6 in var_4) {
    if(!level.spawn_volume_array[var_6.script_area].var_19) {
      level thread[[level.team_buy_vos]](var_6, var_3);
    }
  }

  foreach(var_9 in var_4) {
    scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_9);
    scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_9.script_area);
  }

  if(isDefined(var_0.var_ED83)) {
    scripts\engine\utility::exploder(var_0.var_ED83);
  }

  var_11 = getEntArray(var_4[0].target, "targetname");
  foreach(var_13 in var_11) {
    if(var_13.spawnimpulsefield == 1) {
      var_13 connectpaths();
      var_13 notsolid();
      continue;
    }

    if(var_13.classname == "script_brushmodel") {
      var_13 hide();
      var_13 notsolid();
      continue;
    }

    var_13 setscriptablepartstate("default", "hide");
    if(should_play_door_purchase_sound()) {
      var_13 playSound("purchase_generic");
    }
  }
}

func_115B2(var_0) {
  wait(0.5);
  playsoundatpos(var_0.origin, "zmb_clear_barricade");
  wait(0.5);
}

init_sliding_power_doors() {
  var_0 = scripts\engine\utility::getstructarray("power_door_sliding", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread sliding_power_door();
  }
}

sliding_power_door() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  playsoundatpos(self.origin, "zmb_sliding_door_open");
  var_0 = getEntArray(self.target, "targetname");
  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_2 moveto(var_3.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}

func_8FDE(var_0, var_1) {
  playsoundatpos(var_0.origin, "zmb_gate_open");
  var_2 = getent(var_0.target, "targetname");
  var_2 rotateyaw(160, 1);
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
}

clear_debris(var_0, var_1) {
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  if(isDefined(level.script) && level.script == "cp_disco") {
    if(isDefined(var_0) && issubstr(var_0.name, "chi_")) {
      playsoundatpos(var_0.origin, "cp_disco_doorbuy_chi_gongs");
    } else {
      playsoundatpos(var_0.origin, "cp_disco_doorbuy_caution_tape");
    }
  } else {
    playsoundatpos(var_0.origin, "zmb_clear_barricade");
  }

  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_0);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_0.script_area);
  var_2 = getEntArray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    if(var_4.classname == "script_brushmodel") {
      var_4 connectpaths();
      var_4 notsolid();
      continue;
    }

    var_4 setscriptablepartstate("default", "hide");
    if(should_play_door_purchase_sound()) {
      var_4 playSound("purchase_generic");
    }
  }
}

should_play_door_purchase_sound() {
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return 0;
  }

  return 1;
}

move_up_and_delete(var_0) {
  self endon("death");
  wait(var_0 * 0.2);
  self movez(10, 0.5);
  self rotateto(self.angles + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(-10, 10)), 0.5);
  wait(0.5);
  self movez(1000, 3, 2, 1);
  wait(2);
  if(isDefined(self)) {
    self delete();
  }
}
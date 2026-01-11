/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3385.gsc
***************************************/

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

func_F945(var_00) {
  var_01 = scripts\engine\utility::getstructarray(var_00, "script_noteworthy");

  foreach(var_03 in var_01) {
  set_nonstick(var_03);
  }
}

set_nonstick(var_00) {
  var_01 = getEntArray(var_0.target, "targetname");

  foreach(var_03 in var_01) {
    var_03 setnonstick(1);
    wait 0.1;
  }
}

func_102F3(var_00, var_01) {
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_00);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_0.script_area);
  playLoopSound(var_0.origin, "zmb_sliding_door_open");
  var_02 = getEntArray(var_0.target, "targetname");

  foreach(var_04 in var_02) {
    var_04 connectpaths();
    var_05 = scripts\engine\utility::getstruct(var_4.target, "targetname");
    var_04 moveto(var_5.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(var_00);

  if(level.players.size > 1) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
  }
  else {
    level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 1, 1, 40);
  }
}

use_team_door_switch(var_00, var_01) {
  var_02 = undefined;
  var_03 = undefined;

  if(!isDefined(level.func_115C8)) {
    level.func_115C8 = 0;
  }

  switch (var_0.script_side) {
    case "moon":
      if(!isDefined(level.moon_donations)) {
        level.moon_donations = -1;
      }

      level.moon_donations++;
      var_03 = level.moon_donations;
      scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, var_01, var_0.script_side, 1000, level.wave_num);
      break;
    case "kepler":
      if(!isDefined(level.kepler_donations)) {
        level.kepler_donations = -1;
      }

      level.kepler_donations++;
      var_03 = level.kepler_donations;
      scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, var_01, var_0.script_side, 1000, level.wave_num);
      break;
    case "triton":
      if(!isDefined(level.triton_donations)) {
        level.triton_donations = -1;
      }

      level.triton_donations++;
      var_03 = level.triton_donations;
      scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, var_01, var_0.script_side, 1000, level.wave_num);
      break;
  }

  var_04 = getEntArray(var_0.target, "targetname");

  foreach(var_06 in var_04) {
    if(!isDefined(var_6.script_noteworthy)) {
      continue;
    }
    else if(var_6.script_noteworthy == "progress") {
      var_06 movez(4, 0.1);
      var_06 waittill("movedone");
    }
  }

  if(var_03 >= 3) {
    level thread func_C61B(var_00, var_02, var_03, var_01);
    var_01 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
    var_01 notify("door_opened_notify");
    level.func_115C8++;

    if(level.func_115C8 == 2) {
      scripts\engine\utility::flag_set("canFiresale");
    }
  }

  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::is_true(level.only_one_player)) {
    var_01 scripts\cp\cp_persistence::give_player_xp(250, 1);
  }
  else {
    var_01 scripts\cp\cp_persistence::give_player_xp(75, 1);
  }

  var_01 scripts\cp\cp_interaction::refresh_interaction();
}

func_C61B(var_00, var_01, var_02, var_03) {
  scripts\cp\zombies\zombie_analytics::func_AF7E(1, var_03, var_0.script_side, 1000, level.wave_num);
  thread func_115B2(var_00);
  scripts\cp\cp_interaction::disable_linked_interactions(var_00);
  var_04 = scripts\cp\cp_interaction::get_linked_interactions(var_00);

  foreach(var_06 in var_04) {
    if(!level.spawn_volume_array[var_6.script_area].active) {
      level thread[[level.team_buy_vos]](var_06, var_03);
    }
  }

  foreach(var_09 in var_04) {
    scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_09);
    scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_9.script_area);
  }

  if(isDefined(var_0.func_ED83)) {
    scripts\engine\utility::exploder(var_0.func_ED83);
  }

  var_11 = getEntArray(var_4[0].target, "targetname");

  foreach(var_14, var_13 in var_11) {
    if(var_13.spawnflags == 1) {
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
  }
}

func_115B2(var_00) {
  wait 0.5;
  playLoopSound(var_0.origin, "zmb_clear_barricade");
  wait 0.5;
}

init_sliding_power_doors() {
  var_00 = scripts\engine\utility::getstructarray("power_door_sliding", "script_noteworthy");

  foreach(var_02 in var_00) {
  var_02 thread sliding_power_door();
  }
}

sliding_power_door() {
  if(scripts\engine\utility::is_true(self.requires_power)) {
    level scripts\engine\utility::waittill_any("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  playLoopSound(self.origin, "zmb_sliding_door_open");
  var_00 = getEntArray(self.target, "targetname");

  foreach(var_02 in var_00) {
    var_02 connectpaths();
    var_03 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_02 moveto(var_3.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}

func_8FDE(var_00, var_01) {
  playLoopSound(var_0.origin, "zmb_gate_open");
  var_02 = getent(var_0.target, "targetname");
  var_02 rotateyaw(160, 1);
  scripts\cp\cp_interaction::disable_linked_interactions(var_00);
}

clear_debris(var_00, var_01) {
  scripts\cp\cp_interaction::disable_linked_interactions(var_00);

  if(isDefined(level.script) && level.script == "cp_disco") {
    if(isDefined(var_00) && issubstr(var_0.name, "chi_")) {
      playLoopSound(var_0.origin, "cp_disco_doorbuy_chi_gongs");
    }
    else {
      playLoopSound(var_0.origin, "cp_disco_doorbuy_caution_tape");
    }
  } else
    playLoopSound(var_0.origin, "zmb_clear_barricade");

  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_00);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_0.script_area);
  var_02 = getEntArray(var_0.target, "targetname");

  foreach(var_05, var_04 in var_02) {
    if(var_4.classname == "script_brushmodel") {
      var_04 connectpaths();
      var_04 notsolid();
      continue;
    }

    var_04 setscriptablepartstate("default", "hide");
  }
}

move_up_and_delete(var_00) {
  self endon("death");
  wait(var_00 * 0.2);
  self movez(10, 0.5);
  self rotateto(self.angles + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(-10, 10)), 0.5);
  wait 0.5;
  self movez(1000, 3, 2, 1);
  wait 2;

  if(isDefined(self)) {
    self delete();
  }
}
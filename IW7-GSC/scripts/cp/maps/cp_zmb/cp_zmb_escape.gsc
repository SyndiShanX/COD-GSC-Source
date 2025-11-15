/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_escape.gsc
****************************************************/

cp_zmb_escape_init() {
  level.interactions_disabled = 1;
  scripts\cp\utility::coop_mode_enable(["loot"]);
  level.initial_active_volumes = ["underground_route"];
  level.escape_table = "scripts\cp\maps\cp_zmb\cp_zmb_escape.csv";
  level.escape_time = 90;
  level.get_escape_exit_interactions = ::get_escape_exit_interactions;
  level thread scripts\cp\zombies\zombies_spawning::escape_room_init();
}

init_escape_interactions() {
  level thread delete_all_doors();
  level thread spawn_escape_entities();
  level thread delete_zombie_gamemode_entities();
  level thread remove_team_door_meters();
  var_00 = getEntArray("escape_exit_path", "targetname");
  foreach(var_02 in var_00) {
    var_02 hide();
  }
}

get_escape_exit_interactions() {
  return scripts\engine\utility::getstructarray("escape_exit", "script_noteworthy");
}

delete_zombie_gamemode_entities() {
  var_00 = getEntArray("first_gate_bollard", "targetname");
  foreach(var_02 in var_00) {
    var_02 delete();
  }

  var_04 = getEntArray("first_gate_bollard_clip", "targetname");
  foreach(var_06 in var_04) {
    var_06 delete();
  }

  var_08 = getEntArray("bollard_trigger", "targetname");
  foreach(var_0A in var_08) {
    var_0A delete();
  }
}

delete_all_doors() {
  var_00 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.target)) {
      continue;
    }

    var_03 = scripts\engine\utility::getstructarray(var_02.script_noteworthy, "script_noteworthy");
    foreach(var_05 in var_03) {
      if(!isDefined(var_05.target)) {
        continue;
      }

      if(var_05.target == var_02.target && var_05 != var_02) {
        if(scripts\engine\utility::array_contains(var_00, var_05)) {
          var_00 = scripts\engine\utility::array_remove(var_00, var_05);
        }
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_door_buy(var_02)) {
      if(!isDefined(var_02.script_noteworthy)) {
        continue;
      }

      var_07 = strtok(var_02.script_noteworthy, "_");
      switch (var_07[0]) {
        case "debris":
          delete_door(var_02);
          break;

        case "team":
          delete_team_door(var_02);
          break;
      }
    }

    wait(0.05);
  }
}

delete_door(param_00) {
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  var_01 = getEntArray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.classname == "script_brushmodel") {
      var_03 connectpaths();
    }

    var_03 delete();
  }
}

delete_team_door(param_00) {
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  var_01 = scripts\cp\cp_interaction::get_linked_interactions(param_00);
  var_02 = getEntArray(var_01[0].target, "targetname");
  foreach(var_04 in var_02) {
    if(var_04.spawnimpulsefield == 1) {
      var_04 connectpaths();
    }

    var_04 delete();
  }
}

spawn_escape_entities() {
  var_00 = getent("escape_1_blocker_brush", "targetname");
  var_00 movez(-1024, 0.1);
  var_00 waittill("movedone");
  var_00 disconnectpaths();
  var_01 = scripts\engine\utility::getstructarray("escape_1_blocker", "targetname");
  level.escape_barriers = [];
  foreach(var_05, var_03 in var_01) {
    var_04 = spawn("script_model", var_03.origin);
    if(isDefined(var_03.angles)) {
      var_04.angles = var_03.angles;
    }

    var_04 setModel(var_03.script_noteworthy);
    level.escape_barriers[level.escape_barriers.size] = var_04;
    if(var_05 % 3 == 0) {
      wait(0.05);
    }
  }

  var_06 = getEntArray("escape_door", "targetname");
  foreach(var_08 in var_06) {
    level thread setup_door(var_08);
  }

  level thread escape_armageddon();
}

escape_armageddon() {
  wait(5);
  level.min_wait_between_metors = 2;
  level.max_wait_between_metors = 5;
  level.earthquake_time_extension = 1;
  level.armageddon_duration = 2;
  level.armageddon_earthquake_scale = 0.25;
  for(;;) {
    level.players[0] scripts\cp\powers\coop_armageddon::armageddon_use();
    wait(randomintrange(3, 10));
    level.earthquake_time_extension = randomfloatrange(0.05, 1);
    level.armageddon_duration = 2;
    level.armageddon_earthquake_scale = randomfloatrange(0.15, 0.25);
  }
}

remove_team_door_meters() {
  setomnvarbit("zombie_doors_progress", 4, 1);
  scripts\engine\utility::waitframe();
  setomnvarbit("zombie_doors_progress", 14, 1);
  scripts\engine\utility::waitframe();
  setomnvarbit("zombie_doors_progress", 9, 1);
}

setup_door(param_00) {
  param_00 movez(-1024, 0.05);
  param_00 waittill("movedone");
  param_00 disconnectpaths();
  param_00.panels = [];
  var_01 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.script_noteworthy == "waypoint_spot") {
      continue;
    }

    var_04 = spawn("script_model", var_03.origin);
    if(isDefined(var_03.angles)) {
      var_04.angles = var_03.angles;
    }

    var_04 setModel(var_03.script_noteworthy);
    param_00.panels[param_00.panels.size] = var_04;
  }
}
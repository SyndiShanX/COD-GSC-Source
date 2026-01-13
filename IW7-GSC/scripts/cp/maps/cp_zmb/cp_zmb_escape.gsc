/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = getEntArray("escape_exit_path", "targetname");
  foreach(var_2 in var_0) {
    var_2 hide();
  }
}

get_escape_exit_interactions() {
  return scripts\engine\utility::getstructarray("escape_exit", "script_noteworthy");
}

delete_zombie_gamemode_entities() {
  var_0 = getEntArray("first_gate_bollard", "targetname");
  foreach(var_2 in var_0) {
    var_2 delete();
  }

  var_4 = getEntArray("first_gate_bollard_clip", "targetname");
  foreach(var_6 in var_4) {
    var_6 delete();
  }

  var_8 = getEntArray("bollard_trigger", "targetname");
  foreach(var_0A in var_8) {
    var_0A delete();
  }
}

delete_all_doors() {
  var_0 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.target)) {
      continue;
    }

    var_3 = scripts\engine\utility::getstructarray(var_2.script_noteworthy, "script_noteworthy");
    foreach(var_5 in var_3) {
      if(!isDefined(var_5.target)) {
        continue;
      }

      if(var_5.target == var_2.target && var_5 != var_2) {
        if(scripts\engine\utility::array_contains(var_0, var_5)) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_5);
        }
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_door_buy(var_2)) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }

      var_7 = strtok(var_2.script_noteworthy, "_");
      switch (var_7[0]) {
        case "debris":
          delete_door(var_2);
          break;

        case "team":
          delete_team_door(var_2);
          break;
      }
    }

    wait(0.05);
  }
}

delete_door(var_0) {
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.classname == "script_brushmodel") {
      var_3 connectpaths();
    }

    var_3 delete();
  }
}

delete_team_door(var_0) {
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_1 = scripts\cp\cp_interaction::get_linked_interactions(var_0);
  var_2 = getEntArray(var_1[0].target, "targetname");
  foreach(var_4 in var_2) {
    if(var_4.spawnimpulsefield == 1) {
      var_4 connectpaths();
    }

    var_4 delete();
  }
}

spawn_escape_entities() {
  var_0 = getent("escape_1_blocker_brush", "targetname");
  var_0 movez(-1024, 0.1);
  var_0 waittill("movedone");
  var_0 disconnectpaths();
  var_1 = scripts\engine\utility::getstructarray("escape_1_blocker", "targetname");
  level.escape_barriers = [];
  foreach(var_5, var_3 in var_1) {
    var_4 = spawn("script_model", var_3.origin);
    if(isDefined(var_3.angles)) {
      var_4.angles = var_3.angles;
    }

    var_4 setModel(var_3.script_noteworthy);
    level.escape_barriers[level.escape_barriers.size] = var_4;
    if(var_5 % 3 == 0) {
      wait(0.05);
    }
  }

  var_6 = getEntArray("escape_door", "targetname");
  foreach(var_8 in var_6) {
    level thread setup_door(var_8);
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

setup_door(var_0) {
  var_0 movez(-1024, 0.05);
  var_0 waittill("movedone");
  var_0 disconnectpaths();
  var_0.panels = [];
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.script_noteworthy == "waypoint_spot") {
      continue;
    }

    var_4 = spawn("script_model", var_3.origin);
    if(isDefined(var_3.angles)) {
      var_4.angles = var_3.angles;
    }

    var_4 setModel(var_3.script_noteworthy);
    var_0.panels[var_0.panels.size] = var_4;
  }
}
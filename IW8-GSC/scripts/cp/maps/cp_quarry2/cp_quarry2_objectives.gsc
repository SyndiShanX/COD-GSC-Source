/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_quarry2\cp_quarry2_objectives.gsc
****************************************************************/

function levelobjectives_init() {
  level.objectives_table = "cp/cp_quarry2_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_quarry2_objectives_matrix.csv";
  level.objectiveregistration = &levelregisterobjectives;

  if(scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_wait("create_script_initialized");
  }

  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function levelregisterobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_objectives::registerobjective("test_objective_1", &initobjective1, &startobjective1, &completeobjective1);

  if(isDefined(level.convoy4_objective_func)) {
    [[level.convoy4_objective_func]]();
  }

  scripts\cp\maps\cp_quarry2\inside_obj\cp_inside_obj::main();
}

function waitforallplayersnearpoint(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_2 = 1;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) > var_1) {
        var_2 = 0;
      }
    }

    wait 0.5;
  }
}

function waitforvehicleorplayernearpoint(var_0, var_1) {
  level endon("game_ended");
  var_2 = 0;
  var_3 = 0;

  while(!var_2 && !var_3) {
    var_2 = 0;
    var_3 = 0;

    if(!isDefined(level.vehicle_travel_array)) {
      wait 5;
      continue;
    }

    foreach(var_5 in level.vehicle_travel_array) {
      if(distance(var_5.origin, var_0) <= var_1) {
        var_2 = 1;
      }
    }

    foreach(var_8 in level.players) {
      if(distance(var_8.origin, var_0) <= var_1) {
        var_3 = 1;
      }
    }

    wait 0.05;
  }
}

function initobjective1(var_0, var_1) {
  iprintlnbold("objective 1 init");
}

function startobjective1(var_0, var_1) {
  iprintlnbold("objective 1 Start");

  while(distance(level.players[0].origin, (14214, -8782, 520)) > 100) {
    wait 1;
  }
}

function completeobjective1(var_0) {
  iprintlnbold("objective 1 finished");
}
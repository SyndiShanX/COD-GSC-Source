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

function waitforallplayersnearpoint(var0, var1) {
  var2 = 0;

  while(!var2) {
    var2 = 1;

    foreach(var4 in level.players) {
      if(distance(var4.origin, var0) > var1) {
        var2 = 0;
      }
    }

    wait 0.5;
  }
}

function waitforvehicleorplayernearpoint(var0, var1) {
  level endon("game_ended");
  var2 = 0;
  var3 = 0;

  while(!var2 && !var3) {
    var2 = 0;
    var3 = 0;

    if(!isDefined(level.vehicle_travel_array)) {
      wait 5;
      continue;
    }

    foreach(var5 in level.vehicle_travel_array) {
      if(distance(var5.origin, var0) <= var1) {
        var2 = 1;
      }
    }

    foreach(var8 in level.players) {
      if(distance(var8.origin, var0) <= var1) {
        var3 = 1;
      }
    }

    wait 0.05;
  }
}

function initobjective1(var0, var1) {
  iprintlnbold("objective 1 init");
}

function startobjective1(var0, var1) {
  iprintlnbold("objective 1 Start");

  while(distance(level.players[0].origin, (14214, -8782, 520)) > 100) {
    wait 1;
  }
}

function completeobjective1(var0) {
  iprintlnbold("objective 1 finished");
}
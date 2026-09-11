/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_suburbs09_a\cp_suburbs09_a_objectives.gsc
************************************************************************/

function levelobjectives_init() {
  level.objectives_table = "cp/cp_suburbs09_a_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_suburbs09_a_objectives_matrix.csv";
  level.objectiveregistration = &levelregisterobjectives;

  if(scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_wait("create_script_initialized");
  }

  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function levelregisterobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_obj_overwatch::overwatch_init();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_obj_overwatch::register_overwatch_objective();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_obj_iedrace::iedrace_init();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_obj_iedrace::register_iedrace_objective();
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

function startrangeroverobjective(var_0, var_1) {
  waitforvehicleorplayernearpoint(var_0.iconpos[0], 800);
  level notify("stop_ied_nag");
}

function startglexfilobjective(var_0, var_1) {
  if(isDefined(level.savedmorales) && level.savedmorales) {
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/SAVED_MORALES_EXFIL");
  } else {
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/SAVED_PILOT_EXFIL");
  }

  wait 3;
  thread nag_exfil_tutorial();
  level waittill("call_exfil");
}

function nag_exfil_tutorial() {
  level endon("game_ended");
  level endon("ready_to_exfil");

  for(;;) {
    thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CALL_EXFIL");
    wait 15;
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

function initobjective2(var_0, var_1) {
  iprintlnbold("objective 2 init");
}

function startobjective2(var_0, var_1) {
  iprintlnbold("objective 2 Start");

  while(distance(level.players[0].origin, var_0.iconpos) > 100) {
    wait 1;
  }
}

function completeobjective2(var_0) {
  iprintlnbold("objective 2 finished");
}

function initobjective3(var_0, var_1) {
  iprintlnbold("objective 3 init");
}

function startobjective3(var_0, var_1) {
  iprintlnbold("objective 3 Start");

  while(distance(level.players[0].origin, var_0.iconpos) > 100) {
    wait 1;
  }
}

function completeobjective3(var_0) {
  iprintlnbold("objective 3 finished");
}

function debugbeatobjective3(var_0) {
  iprintlnbold("objective 3 DEBUG BEAT");
}
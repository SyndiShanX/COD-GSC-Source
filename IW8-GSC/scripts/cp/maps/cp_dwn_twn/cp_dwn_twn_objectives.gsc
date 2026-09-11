/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_objectives.gsc
****************************************************************/

function levelobjectives_init() {
  level.objectives_table = "cp/cp_dwn_twn_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_dwn_twn_objectives_matrix.csv";
  level.objectiveregistration = &levelregisterobjectives;

  if(scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_wait("create_script_initialized");
  }

  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function levelregisterobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(!scripts\engine\utility::flag_exist("objective_table_parsed")) {
    scripts\engine\utility::flag_init("objective_table_parsed");
  }

  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.vault_assault_objective_func)) {
    [[level.vault_assault_objective_func]]();
  }

  if(isDefined(level.mlp1_obj_func)) {
    [[level.mlp1_obj_func]]();
  }

  if(isDefined(level.mlp3_obj_func)) {
    [[level.mlp3_obj_func]]();
  }

  if(isDefined(level.rooftop_obj_func)) {
    [[level.rooftop_obj_func]]();
  }

  if(isDefined(level.convoy_obj_func)) {
    [[level.convoy_obj_func]]();
  }

  if(isDefined(level.mlp2_obj_func)) {
    [[level.mlp2_obj_func]]();
  }

  if(isDefined(level.convoyescort_obj_func)) {
    [[level.convoyescort_obj_func]]();
  }

  if(isDefined(level.safehouse_obj_func)) {
    [[level.safehouse_obj_func]]();
    return;
  }
}
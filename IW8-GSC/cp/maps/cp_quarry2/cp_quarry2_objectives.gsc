/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_quarry2\cp_quarry2_objectives.gsc
********************************************************/

levelobjectives_init() {
  level.objectives_table = "_encstr_A9461D5781784E22A1280D82D3EB430236483B308AB7A3B49085930E0B8F8D";
  level.objectivesmatrixtable = "_encstr_BECC249E7F177A20BED0B7EFE033F1B71F1826546D374371E368970FE089B4FB2B2BBD8ECE75";
  level.objectiveregistration = ::levelregisterobjectives;

  if(scripts\engine\utility::flag_exist("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C"))
    scripts\engine\utility::flag_wait("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");

  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

levelregisterobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\cp\cp_objectives::registerobjective("_encstr_B8861163899EFBF948FD2A2D97F83CABCD668F", ::initobjective1, ::startobjective1, ::completeobjective1);

  if(isDefined(level.convoy4_objective_func))
    [[level.convoy4_objective_func]]();

  _encstr_A71E388B3F68A4C33D63E62A2BB88F1ED0875FE37159EA1F6FBB2BB37BC0D715301B8C6D9730F63B20B103D97848678C20FB3FFF05A0ADC736A9::main();
}

waitforallplayersnearpoint(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_2 = 1;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) > var_1) {
        var_2 = 0;
        continue;
      }
    }

    wait 0.5;
  }
}

waitforvehicleorplayernearpoint(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
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
      if(distance(var_5.origin, var_0) <= var_1)
        var_2 = 1;
    }

    foreach(var_8 in level.players) {
      if(distance(var_8.origin, var_0) <= var_1) {
        var_3 = 1;
        continue;
      }
    }

    wait 0.05;
  }
}

initobjective1(var_0, var_1) {
  iprintlnbold("_encstr_825D11F832BBBD101B69153BC892D273033A13");
}

startobjective1(var_0, var_1) {
  iprintlnbold("_encstr_86021247E8B06532E1BB8B4737533E1BDB68BB53");

  while(distance(level.players[0].origin, (14214, -8782, 520)) > 100)
    wait 1;
}

completeobjective1(var_0) {
  iprintlnbold("_encstr_8F0515DE989A2B363A4B9D5601131099B4CD4BCDA1B2C8");
}
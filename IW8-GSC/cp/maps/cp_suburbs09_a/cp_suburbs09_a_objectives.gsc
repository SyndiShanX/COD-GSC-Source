/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_suburbs09_a\cp_suburbs09_a_objectives.gsc
****************************************************************/

levelobjectives_init() {
  level.objectives_table = "_encstr_B44A213BB92286A3C803235A2BB6137A32B38F814F788E838D392B1253051F6510CF3E";
  level.objectivesmatrixtable = "_encstr_AD7E283607E58D83FA6E5798EA39C4CD189CFA2CFAF6139A2BC68EA5672BB97DDA0BE8934BC3C51B6E3B";
  level.objectiveregistration = ::levelregisterobjectives;

  if(scripts\engine\utility::flag_exist("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C"))
    scripts\engine\utility::flag_wait("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");

  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

levelregisterobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level thread _encstr_A62C388AE6BDCA10EBF0CEF78368F5B251060506D7BF5247F078BB4FC050B3EBB7159DFD3541FB9BFE40EB2349307E628534E6F3AE8166DF8338::overwatch_init();
  level thread _encstr_A62C388AE6BDCA10EBF0CEF78368F5B251060506D7BF5247F078BB4FC050B3EBB7159DFD3541FB9BFE40EB2349307E628534E6F3AE8166DF8338::register_overwatch_objective();
  level thread _encstr_889F369BC64EA5388E6E971B38BCD6580ECDF28D1CAF237BB9953AE6B6F2D80EFA23DBE656D137D6F5DB2653F5A5CA8C9316B156B8EC3736::iedrace_init();
  level thread _encstr_889F369BC64EA5388E6E971B38BCD6580ECDF28D1CAF237BB9953AE6B6F2D80EFA23DBE656D137D6F5DB2653F5A5CA8C9316B156B8EC3736::register_iedrace_objective();
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

startrangeroverobjective(var_0, var_1) {
  waitforvehicleorplayernearpoint(var_0.iconpos[0], 800);
  level notify("_encstr_A6010D50FBC0ABAF2770974F300ACF");
}

startglexfilobjective(var_0, var_1) {
  if(isDefined(level.savedmorales) && level.savedmorales)
    thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_8B832B0D05AF1294D79A654AA5F5E8137D114A5089A774AA15E59A282B1588D76A7A290598A835BEA8858C4A62");
  else
    thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_87D5291AA0F52425D7D42B922DAF8E89BE88945062D3D15554793514B254117D2894899E8A7D2A16649289");

  wait 3;
  level thread nag_exfil_tutorial();
  level waittill("_encstr_91750BE60B41C076B37326D770");
}

nag_exfil_tutorial() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");

  for(;;) {
    thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_B64F22C69F59D021AF5999FAC310C0B47710833B0DB098F71D96F3D10144B9DF81674454");
    wait 15;
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

initobjective2(var_0, var_1) {
  iprintlnbold("_encstr_9209117F3E409FDEE9B093BAE2BDC6677813EC");
}

startobjective2(var_0, var_1) {
  iprintlnbold("_encstr_A9DB12DD36DD5A739B50FBBF327B686189DFE293");

  while(distance(level.players[0].origin, var_0.iconpos) > 100)
    wait 1;
}

completeobjective2(var_0) {
  iprintlnbold("_encstr_A1D115DBC4A6956C3A2DB3B20146103396CD5AE643B2C8");
}

initobjective3(var_0, var_1) {
  iprintlnbold("_encstr_8AEF11F613D4568DA3B4ECB204CC01D237A547");
}

startobjective3(var_0, var_1) {
  iprintlnbold("_encstr_B8D71218E562651FBBA373CDE0961ABBF3A97321");

  while(distance(level.players[0].origin, var_0.iconpos) > 100)
    wait 1;
}

completeobjective3(var_0) {
  iprintlnbold("_encstr_A37D157F058AEADB10803BC79112A012D385EFF7F9A542");
}

debugbeatobjective3(var_0) {
  iprintlnbold("_encstr_9B271742F9822F66601BA6BDA172FE13AD557948497E67D639");
}
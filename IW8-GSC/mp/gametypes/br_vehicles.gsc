/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_vehicles.gsc
***********************************************/

brvehiclesinit() {
  level.modecontrolledvehiclespawningonly = 1;
  level.ignorevehicletypeinstancelimit = 1;
  var_0 = getdvarint("_encstr_A25F20A802AA87718B177DEB0EEFD85356693038DA032DEEC35573F01A476105BF23", 24);
  level.br_totalvehiclesmax = 128 - var_0;
  level.br_totalvehiclesspawned = 0;
  level.br_helosmax = getdvarint("_encstr_A9831150C790BF4DD3486433C43A1B27FD0FE0", 3);
  level.defuse_spawners = getdvarint("_encstr_8D4411AFE0F3698A45416025E3D362F6E21203", -1);
  level.defuse_nag = getdvarint("_encstr_937D15E66C4E7D8927BE190BEA73A3C6956E9B7D6B85F0", -1);
  level.define_trial_mission_init_func = getdvarint("_encstr_BA6F123318E52973BB408A8F6181572A17F09AFB", -1);
  level.br_vehtargetnametoref = [];
  level.br_vehtargetnametoref["_encstr_BE7E0A0F2843CFA3792F7B35"] = "_encstr_8C190467402B";
  level.br_vehtargetnametoref["_encstr_85A91140D1CA87553BD33F571247EFC9616BB3"] = "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6";
  level.br_vehtargetnametoref["_encstr_ABF215FF783B1F8A69BED34E2A4FE3B3C321273B0BF35E"] = "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB";
  level.br_vehtargetnametoref["_encstr_8CA71382101B81CD957678373BC8F05F339BD65B7D"] = "_encstr_BAC20FBEE6F88945F163A37BD68409923B";
  level.br_vehtargetnametoref["_encstr_AFED17935FA3773D094883FA985FF36F9B371937EE4BB7C3D5"] = "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843";
  level.br_vehtargetnametoref["_encstr_B26E0D5E6883E36A4ECFA7A39BF4A2"] = "_encstr_8FE608B268BFF756987D";
  level.br_vehtargetnametoref["_encstr_AD8D0DA07A28AAC42337DBB8BB6F45"] = "_encstr_91CD07D045CF0B0BB8";
  level.br_vehtargetnametoref["_encstr_A25612D42F20D32B9B9B2B7BFFF2D1D347E853F6"] = "_encstr_8BAA0D68183D43A35319057A93B767";
  level.br_vehtargetnametoref["_encstr_9B1A0BCA9B29FF2703F3124BE0"] = "_encstr_85DE05A6B2AC0E";
  level.br_vehtargetnametoref["_encstr_9AF01563B09CB395A39358E6B9E0DB39A3FAE6C116DDCD"] = "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E";
  level.br_vehtargetnametoref["_encstr_827911362D47E8C6CA26A539197D37C116DD37"] = "_encstr_9A8F0CB1A5E8471BB2EB894B39C8";
  level.br_vehtargetnametoref["_encstr_8E9213A9E1E5F340FFB2C355775A2907179BDFABBA"] = "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F";
  level.br_vehtargetnametoref["_encstr_BDC80A5437EAD749519A6068"] = "_encstr_BDC80A5437EAD749519A6068";
  level.br_vehtargetnametoref["_encstr_83F40783ADF1D14AA3"] = "_encstr_83F40783ADF1D14AA3";
  level.br_vehtargetnametoref["_encstr_969116B695914BD55B8E9C5837DCC1DE4E1DF5E638B0EEDC"] = "_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301";
  level.br_vehtargetnametoref["_encstr_87D2116BDE47F627D85E6C6395AFE60EC2EEE6"] = "_encstr_99C20BA548E9F27A61D897932B";
  level.br_vehtargetnametoref["_encstr_AA930FED38CA9B53ACB2E07DDC1C16BB9B"] = "_encstr_97AE0AF6E0959BEB4D2B95C1";
  level.br_vehtargetnametoref["_encstr_A6B217B718E7C538388BFD0B079F188E495DF68F9BE056D4BA"] = "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3";
  level.br_vehtargetnametoref["_encstr_8BBC121759BF58D32203D8F86ABCCF134BF91C80"] = "_encstr_8FD60D6AA0EAB34083F7C423A0213B";
  level.br_vehtargetnametoref["_encstr_9B910F8E2C36937BD956E47DCDC10BEECD"] = "_encstr_9A120A1D8536F5E4ED3BB293";
  level.br_vehtargetnametoref["_encstr_BA6A107318F7349308AE797CA89333BE37B8"] = "_encstr_84D70A6B2BEF3C9B30A67164";
  level.br_vehtargetnametoref["_encstr_87470AEB7203514BD3DF73DA"] = "_encstr_911904464232";
  level.br_vehtargetnametoref["_encstr_927D12D78760333F80CBA26B4178473BC7333F6B"] = "_encstr_8D860D49508DBBF831085BF0335F07";
  level.br_vehtargetnametoref["_encstr_BE820B53A080CF0245ADFC77B7"] = "_encstr_BE820B53A080CF0245ADFC77B7";
  level._effect["_encstr_91940F1BD14B275EE85BC7C671B8225F6E"] = loadfx("_encstr_8AD4322327D2AD98742B5F8837D732731A7AEE2BF2519BF2081C4FA37187EF8E01FB5379731260451BA98F19A62E718FDD131380");
}

brvehiclesonstartgametype() {
  setupvehiclespawnvolumes();
  brvehiclesreset();
}

setupvehiclespawnvolumes() {
  var_0 = "_encstr_BE6A0F1C3D989830516526E040F8CB15EF";

  if(getdvarint("_encstr_825516CD1BC97D139C7DB3B243EB677B63FA9B96B6E0B1AC", 1))
    var_0 = "_encstr_A7511A63F7D8F8067A57773D672255906DC14B181D2808CBF20F0B11";

  level.brvehspawnvols = getEntArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in level.brvehspawnvols)
  initvehiclespawnvolume(var_2);

  level.br_vehicleallspawns = [];
  level.br_vehiclealwaysspawns = [];
  level.br_helospawns = [];
  level.deletex1stashhud = [];
  level.defend_death_counter = [];
  level.debug_warpplayer_monitor = [];
  var_4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  foreach(var_14, var_6 in var_4.databyref) {
    var_7 = [[var_6.getspawnstructscallback]]();

    if(isDefined(level.play_nag_players_hvt_callouts))
      var_7 = [[level.play_nag_players_hvt_callouts]](var_7);

    if(isDefined(level._encstr_B46C21E108B199271B7BD59877BA4829DF2B3973757A037B9D0FABB60FC940DDF56026))
      var_7 = [[level._encstr_B46C21E108B199271B7BD59877BA4829DF2B3973757A037B9D0FABB60FC940DDF56026]](var_14, var_7);

    _id_13E0C(var_7);
    hudcoststring(var_7, "_encstr_BE7E0A0F2843CFA3792F7B35", "_encstr_8C190467402B", "_encstr_87D2116BDE47F627D85E6C6395AFE60EC2EEE6", "_encstr_99C20BA548E9F27A61D897932B", "_encstr_A9241903C8BB182BC74AD1F3D5373BF018670BD66377F2E6B5B03B");
    hudcoststring(var_7, "_encstr_85A91140D1CA87553BD33F571247EFC9616BB3", "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_ABF215FF783B1F8A69BED34E2A4FE3B3C321273B0BF35E", "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_A7B91DFAE1F64F0D78059D932F9853D71FDE735349CC33493003929BDB585B");
    hudcoststring(var_7, "_encstr_ABF215FF783B1F8A69BED34E2A4FE3B3C321273B0BF35E", "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_AFED17935FA3773D094883FA985FF36F9B371937EE4BB7C3D5", "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_BE011F16E158AF32855D6727772EDBF3F0490E915BA0718BD06F7B376DDE0256B8");
    hudcoststring(var_7, "_encstr_9B1A0BCA9B29FF2703F3124BE0", "_encstr_85DE05A6B2AC0E", "_encstr_AA930FED38CA9B53ACB2E07DDC1C16BB9B", "_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_95B71737CB6BA0035DAF494146805088E011D172751E291838");
    hudcoststring(var_7, "_encstr_83F40783ADF1D14AA3", "_encstr_83F40783ADF1D14AA3", "_encstr_BDC80A5437EAD749519A6068", "_encstr_BDC80A5437EAD749519A6068", "_encstr_85FC1ADEF3190108BF5F5A4A5BDC464793DECC508143FB536B67A860");
    hudcoststring(var_7, "_encstr_AFED17935FA3773D094883FA985FF36F9B371937EE4BB7C3D5", "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_AA930FED38CA9B53ACB2E07DDC1C16BB9B", "_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_BEE026C2D9CE6725A0ED657BF7206E3F75B0998A832D0B5CF03B787FFF28F55308CBB22349F5D393");
    hudcoststring(var_7, "_encstr_9B1A0BCA9B29FF2703F3124BE0", "_encstr_85DE05A6B2AC0E", "_encstr_A6B217B718E7C538388BFD0B079F188E495DF68F9BE056D4BA", "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_A3B7214471F0A821F517BF3F55116AE2A8F9BA0B8BC9530B470F73CF79CD432B2BC0F3");
    hudcoststring(var_7, "_encstr_AA930FED38CA9B53ACB2E07DDC1C16BB9B", "_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_A6B217B718E7C538388BFD0B079F188E495DF68F9BE056D4BA", "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_AF0125289335809D12670F803BEAAF298A5FA0582FCCFB6B0B81861F56830556D017F058B76E53");
    level.br_vehicleallspawns = scripts\engine\utility::array_combine_unique(level.br_vehicleallspawns, var_7);

    foreach(var_9 in var_7) {
      if(isDefined(var_9.script_priority) && var_9.script_priority > 0 && (level.defuse_spawners < 0 || !tv_station_fastrope_two_infil_start_targetname_array(var_9))) {
        var_10 = level.br_vehiclealwaysspawns.size;
        level.br_vehiclealwaysspawns[var_10] = var_9;
        continue;
      }

      if(isDefined(var_9.targetname) && (var_9.targetname == "_encstr_827911362D47E8C6CA26A539197D37C116DD37" || var_9.targetname == "_encstr_8E9213A9E1E5F340FFB2C355775A2907179BDFABBA")) {
        level.br_helospawns[level.br_helospawns.size] = var_9;
        continue;
      }

      if(level.defuse_spawners >= 0 && tv_station_fastrope_two_infil_start_targetname_array(var_9)) {
        level.deletex1stashhud[level.deletex1stashhud.size] = var_9;
        continue;
      }

      if(level.defuse_nag >= 0 && uid(var_9)) {
        level.defend_death_counter[level.defend_death_counter.size] = var_9;
        continue;
      }

      if(level.define_trial_mission_init_func >= 0 && tutorial_intro(var_9)) {
        level.debug_warpplayer_monitor[level.debug_warpplayer_monitor.size] = var_9;
        continue;
      }

      foreach(var_2 in level.brvehspawnvols) {
        if(ispointinvolume(var_9.origin, var_2)) {
          var_10 = var_2.vehiclespawns.size;
          var_2.vehiclespawns[var_10] = var_9;
          break;
        }
      }
    }
  }
}

initvehiclespawnvolume(var_0) {
  var_0.vehiclespawns = [];
  var_0.vehiclesspawned = 0;

  switch (level.mapname) {
    case "_encstr_99640BBF88E674E2C5AD3BF282":
    case "_encstr_AFFF0BE590A158DFF3D1238507":
    case "_encstr_B1D508B607F591B7CD33":
      assignvehicleminimumsforvolume(var_0);
      break;
    case "_encstr_8CD508CA98A70FAFC01D":
      cargo_truck_mg_mp_ondeathrespawncallback(var_0);
      break;
    case "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319":
      cargo_truck_mg_mp_spawncallback(var_0);
      break;
  }
}

cargo_truck_mg_mp_spawncallback(var_0) {
  var_0.minvehicles = 0;

  switch (var_0.targetname) {
    case "_encstr_A5E10A97FFD1E7B176C32090":
      var_0.minvehicles = 2;
      break;
    case "_encstr_967B0985969CCC2D561B19":
      var_0.minvehicles = 1;
      break;
    case "_encstr_8AE61085B4E4CC5A95C6917DC4BDB6265939":
      var_0.minvehicles = 1;
      break;
    case "_encstr_8D9009B0964ECD1D4E5A07":
      var_0.minvehicles = 0;
      break;
    case "_encstr_929F103B49A3E3F08B8BF8194188F7B11592":
      var_0.minvehicles = 1;
      break;
    case "_encstr_8D9708AFC2079025B13D":
      var_0.minvehicles = 1;
      break;
    case "_encstr_B2280A3A935086C353C1623A":
      var_0.minvehicles = 1;
      break;
    case "_encstr_8BDC089661282C1206FB":
      var_0.minvehicles = 1;
      break;
    case "_encstr_8D0308D858C14BD15836":
      var_0.minvehicles = 3;
      break;
    case "_encstr_81AB066CB069AF22":
      var_0.minvehicles = 1;
      break;
    case "_encstr_A56206DAA57359E6":
      var_0.minvehicles = 1;
      break;
    case "_encstr_B46A066BF3D0B56F":
      var_0.minvehicles = 1;
      break;
    case "_encstr_BA89073EAD46E7874A":
      var_0.minvehicles = 2;
      break;
    case "_encstr_B1B708EC8C1209E1AF57":
      var_0.minvehicles = 1;
      break;
    case "_encstr_99E00710F71780B782":
      var_0.minvehicles = 1;
      break;
    case "_encstr_BA600DEA271937556F206A3320BFCD":
      var_0.minvehicles = 3;
      break;
    case "_encstr_BD7D0796D1CE57163B":
      var_0.minvehicles = 1;
      break;
  }
}

cargo_truck_mg_mp_ondeathrespawncallback(var_0) {
  var_0.minvehicles = 0;

  switch (var_0.targetname) {
    case "_encstr_A12309057F2275CBB14A51":
      var_0.minvehicles = 2;
      break;
    case "_encstr_A19407CB0D1807F441":
      var_0.minvehicles = 2;
      break;
    case "_encstr_879D0F1263A0A5528507133F79238BE150":
      var_0.minvehicles = 1;
      break;
    case "_encstr_883009BD28232B4B688B98":
      var_0.minvehicles = 4;
      break;
    case "_encstr_BDB20D46DE7773A3BDDDCD83C24E6D":
      var_0.minvehicles = 1;
      break;
    case "_encstr_837905862370BD":
      var_0.minvehicles = 4;
      break;
    case "_encstr_9B220634456A5747":
      var_0.minvehicles = 1;
      break;
    case "_encstr_883E0978CAE2A1689B3161":
      var_0.minvehicles = 0;
      break;
    case "_encstr_A7FA0953BADCAD2F2C4E19":
      var_0.minvehicles = 1;
      break;
    case "_encstr_9BD70814BBB0A55B35C3":
      var_0.minvehicles = 3;
      break;
    case "_encstr_8E4107C6EA5B135939":
      var_0.minvehicles = 2;
      break;
    case "_encstr_B4840D0763993ADCA8D3C816A9E015":
      var_0.minvehicles = 3;
      break;
    case "_encstr_810D059BE07D8B":
      var_0.minvehicles = 2;
      break;
    case "_encstr_B49507136BBF0EA070":
      var_0.minvehicles = 2;
      break;
    case "_encstr_A77808BB284B9F27D3C1":
      var_0.minvehicles = 1;
      break;
    case "_encstr_834D0CDC8EDE93C23B59BB0B9C6E":
      var_0.minvehicles = 1;
      break;
    case "_encstr_BEB406F03B72BB3B":
      var_0.minvehicles = 1;
      break;
    case "_encstr_A37D06131F86EAC2":
      var_0.minvehicles = 1;
      break;
    case "_encstr_8B410851CDC7EDE732ED":
      var_0.minvehicles = 2;
      break;
    case "_encstr_834E0AFD036B7C39A427F282":
      var_0.minvehicles = 1;
      break;
    case "_encstr_AD66051957B30B":
      var_0.minvehicles = 1;
      break;
    case "_encstr_ADFA0AB6DE33129C10709F83":
      var_0.minvehicles = 1;
      break;
    case "_encstr_96BA0A4B920F854128DF756B":
      var_0.minvehicles = 1;
      break;
  }
}

assignvehicleminimumsforvolume(var_0) {
  var_0.minvehicles = 0;

  switch (var_0.targetname) {
    case "_encstr_A12309057F2275CBB14A51":
      var_0.minvehicles = 2;
      break;
    case "_encstr_971804ED3712":
      var_0.minvehicles = 2;
      break;
    case "_encstr_883009BD28232B4B688B98":
      var_0.minvehicles = 4;
      break;
    case "_encstr_BDB20D46DE7773A3BDDDCD83C24E6D":
      var_0.minvehicles = 1;
      break;
    case "_encstr_837905862370BD":
      var_0.minvehicles = 4;
      break;
    case "_encstr_9B220634456A5747":
      var_0.minvehicles = 1;
      break;
    case "_encstr_883E0978CAE2A1689B3161":
      var_0.minvehicles = 0;
      break;
    case "_encstr_A7FA0953BADCAD2F2C4E19":
      var_0.minvehicles = 1;
      break;
    case "_encstr_9BD70814BBB0A55B35C3":
      var_0.minvehicles = 3;
      break;
    case "_encstr_8E4107C6EA5B135939":
      var_0.minvehicles = 2;
      break;
    case "_encstr_B4840D0763993ADCA8D3C816A9E015":
      var_0.minvehicles = 3;
      break;
    case "_encstr_810D059BE07D8B":
      var_0.minvehicles = 2;
      break;
    case "_encstr_B49507136BBF0EA070":
      var_0.minvehicles = 2;
      break;
    case "_encstr_A77808BB284B9F27D3C1":
      var_0.minvehicles = 1;
      break;
    case "_encstr_834D0CDC8EDE93C23B59BB0B9C6E":
      var_0.minvehicles = 1;
      break;
    case "_encstr_BEB406F03B72BB3B":
      var_0.minvehicles = 1;
      break;
    case "_encstr_A37D06131F86EAC2":
      var_0.minvehicles = 1;
      break;
    case "_encstr_8B410851CDC7EDE732ED":
      var_0.minvehicles = 2;
      break;
    case "_encstr_834E0AFD036B7C39A427F282":
      var_0.minvehicles = 1;
      break;
    case "_encstr_96BA0A4B920F854128DF756B":
      var_0.minvehicles = 1;
      break;
  }
}

emptyallvehicles() {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }
  foreach(var_5, var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE(var_3))
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_3);
    }
  }
}

deleteextantvehicles(var_0) {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_spawn::_id_14212();
  level.suppressvehicleexplosion = 1;

  foreach(var_7, var_2 in level.vehicle.instances) {
    var_3 = scripts\mp\vehicles\damage::get_death_callback(var_7);

    foreach(var_5 in var_2) {
      if(isDefined(var_0) && scripts\engine\utility::array_contains(var_0, var_5)) {
        continue;
      }
      scripts\cp_mp\vehicles\vehicle_spawn::_id_14219(var_5);
      var_5[[var_3]](undefined);
    }
  }

  level.suppressvehicleexplosion = 0;
}

tryspawnavehicle(var_0, var_1, var_2, var_3) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_9B0C0EEC59D0A5D8B1B2353885BBE6B9")) {
    return;
  }
  if((var_0 == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_0 == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F") && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_8CE711B1A5E88E1B2B24B439329A072CDDB96E")) {
    return;
  }
  if((var_0 == "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6" || var_0 == "_encstr_BAC20FBEE6F88945F163A37BD68409923B") && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_AA630C8E27D51B5B4D1CC2DD9BDC")) {
    return;
  }
  if(var_0 == "_encstr_85DE05A6B2AC0E" && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A1270BA8AAA7E16FCB71AC285B")) {
    return;
  }
  if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293" && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_AC4D0F4B90F1F252451D2A6AFF13AB869B")) {
    return;
  }
  if(var_0 == "_encstr_8C190467402B" && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_B82C0A0FA3DB1FBBD177D09B")) {
    return;
  }
  if(var_0 == "_encstr_99C20BA548E9F27A61D897932B" && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_99D711CD7D55A852E1F919D46AF97F6F1808B6")) {
    return;
  }
  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(var_0, undefined, undefined, var_1)) {
    var_4 = spawnavehicle(var_0, var_1, var_3);

    if(isDefined(var_4))
      return var_4;
  }

  return undefined;
}

spawnavehicle(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = var_1.angles;

  if(!isDefined(var_4))
    var_4 = (0, randomfloat(360), 0);

  var_5 = spawnStruct();
  var_5.origin = var_3;
  var_5.angles = var_4;
  var_5.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(var_0, var_5, var_2);

  if(isDefined(var_6)) {
    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_B1D811CBD7BE435378D9337D17F8A02A1E7907"))
      _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_B1D811CBD7BE435378D9337D17F8A02A1E7907", var_6, var_0);

    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_monitor_shieldstow(var_6, var_0);

    if(var_0 == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_0 == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F")
      var_6.isheli = 1;

    if(!isDefined(var_6.unique_id))
      var_6 scripts\engine\flags::assign_unique_id();
  }

  return var_6;
}

spawninitialvehicles() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
  level.br_totalvehiclesspawned = 0;
  var_1 = 0;
  var_2 = [];
  var_3 = level.br_vehicleallspawns;
  var_4 = scripts\engine\utility::array_randomize(level.br_vehiclealwaysspawns);

  foreach(var_6 in var_4) {
    var_7 = spawnStruct();
    var_8 = level.br_vehtargetnametoref[var_6.targetname];
    var_9 = tryspawnavehicle(var_8, var_6, "_encstr_8E520CA189533FE85731A38A2855", var_7);

    if(isDefined(var_9)) {
      level.br_totalvehiclesspawned++;
      var_2[var_2.size] = var_6;
      var_10 = 0;

      foreach(var_12 in level.brvehspawnvols) {
        if(ispointinvolume(var_6.origin, var_12)) {
          var_12.vehiclesspawned++;
          var_10 = 1;
          break;
        }
      }

      if(!var_10) {}

      if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
        break;
      }

      waitframe();
      continue;
    }

    var_1++;
  }

  var_19 = 0;

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_20 = scripts\engine\utility::array_randomize(level.brvehspawnvols);

    foreach(var_12 in var_20) {
      var_22 = var_12.minvehicles;

      if(isDefined(var_22) && var_22 > 0) {
        if(var_22 > var_12.vehiclespawns.size) {}

        if(var_12.vehiclesspawned < var_22 && var_12.vehiclespawns.size > 0) {
          var_23 = scripts\engine\utility::array_randomize(var_12.vehiclespawns);

          for(var_24 = 0; var_12.vehiclesspawned < var_22 && var_24 < var_23.size; var_24++) {
            var_7 = spawnStruct();
            var_6 = var_23[var_24];
            var_8 = level.br_vehtargetnametoref[var_6.targetname];
            var_9 = tryspawnavehicle(var_8, var_6, var_12.targetname, var_7);

            if(!isDefined(var_9)) {
              var_19++;
              continue;
            }

            level.br_totalvehiclesspawned++;
            var_2[var_2.size] = var_6;
            var_12.vehiclesspawned++;

            if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
              break;
            }

            waitframe();
          }

          if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
            break;
          }
        }
      }
    }
  }

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_26 = 0;
    var_27 = scripts\engine\utility::array_randomize(level.br_helospawns);

    foreach(var_6 in var_27) {
      var_7 = spawnStruct();
      var_8 = level.br_vehtargetnametoref[var_6.targetname];
      var_9 = tryspawnavehicle(var_8, var_6, "_encstr_BE2B0A30E5D8EF9AA9484BD2", var_7);

      if(isDefined(var_9)) {
        level.br_totalvehiclesspawned++;
        var_2[var_2.size] = var_6;
        var_26++;

        if(var_26 >= level.br_helosmax) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.defuse_spawners > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_30 = 0;
    var_31 = scripts\engine\utility::array_randomize(level.deletex1stashhud);

    foreach(var_6 in var_31) {
      var_7 = spawnStruct();
      var_8 = level.br_vehtargetnametoref[var_6.targetname];
      var_9 = tryspawnavehicle(var_8, var_6, "_encstr_8DFB0B5380FBD6A76FC79987D0", var_7);

      if(isDefined(var_9)) {
        level.br_totalvehiclesspawned++;
        var_2[var_2.size] = var_6;
        var_30++;

        if(var_30 >= level.defuse_spawners) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.defuse_nag > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_34 = 0;
    var_35 = scripts\engine\utility::array_randomize(level.defend_death_counter);

    foreach(var_6 in var_35) {
      var_7 = spawnStruct();
      var_8 = level.br_vehtargetnametoref[var_6.targetname];
      var_9 = tryspawnavehicle(var_8, var_6, "_encstr_BDC80A5437EAD749519A6068", var_7);

      if(isDefined(var_9)) {
        level.br_totalvehiclesspawned++;
        var_2[var_2.size] = var_6;
        var_34++;

        if(var_34 >= level.defuse_nag) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.define_trial_mission_init_func > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_38 = 0;
    var_39 = scripts\engine\utility::array_randomize(level.debug_warpplayer_monitor);

    foreach(var_6 in var_39) {
      var_7 = spawnStruct();
      var_8 = level.br_vehtargetnametoref[var_6.targetname];
      var_9 = tryspawnavehicle(var_8, var_6, "_encstr_83F40783ADF1D14AA3", var_7);

      if(isDefined(var_9)) {
        level.br_totalvehiclesspawned++;
        var_2[var_2.size] = var_6;
        var_38++;

        if(var_38 >= level.define_trial_mission_init_func) {
          break;
        }

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  if(level.defuse_spawners >= 0)
    var_3 = scripts\engine\utility::array_remove_array(var_3, level.deletex1stashhud);

  if(level.defuse_nag >= 0)
    var_3 = scripts\engine\utility::array_remove_array(var_3, level.defend_death_counter);

  if(level.define_trial_mission_init_func >= 0)
    var_3 = scripts\engine\utility::array_remove_array(var_3, level.debug_warpplayer_monitor);

  if(level.br_totalvehiclesspawned < level.br_totalvehiclesmax) {
    var_23 = 0;
    var_3 = scripts\engine\utility::array_remove_array(var_3, var_2);
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_6 in var_3) {
      var_8 = level.br_vehtargetnametoref[var_6.targetname];

      while(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle())
        wait 1;

      var_7 = spawnStruct();
      var_9 = tryspawnavehicle(var_8, var_6, "_encstr_8C3D0D90129DC1E0A74B279747832B", var_7);

      if(isDefined(var_9)) {
        level.br_totalvehiclesspawned++;
        var_23++;

        if(level.br_totalvehiclesspawned >= level.br_totalvehiclesmax) {
          break;
        }

        waitframe();
      }
    }
  }

  var_44 = 0;
  var_52 = var_1 + var_19;

  if(var_44 > 0)
    return;
}

brvehiclespawnvolreset() {
  level.br_totalvehiclesspawned = 0;
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();

  foreach(var_2 in level.brvehspawnvols)
  var_2.vehiclesspawned = 0;
}

waitforvehiclestodeletethenspawninitial() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_AA7019DD2BD6EB619B2B8B59716E49F7E8E8680A3B29826A6FDC39");
  level endon("_encstr_AA7019DD2BD6EB619B2B8B59716E49F7E8E8680A3B29826A6FDC39");
  waitframe();
  waittillframeend;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_AAF215A7382770D5F975C84D2081C06EE5B8E0792397EB"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AAF215A7382770D5F975C84D2081C06EE5B8E0792397EB");
  else
    spawninitialvehicles();
}

brvehiclesreset() {
  emptyallvehicles();
  deleteextantvehicles();
  brvehiclespawnvolreset();
  level thread waitforvehiclestodeletethenspawninitial();
  level notify("_encstr_8D18114CC97D9DB234A5C663CADC4AB29BAC3A");
}

brvehicleonprematchstarted() {
  wait 1.5;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal(0);
  brvehiclesreset();
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal(1);
}

enemy_monitor_reload() {
  var_0 = scripts\engine\utility::array_combine(level.vehicle.instances["_encstr_9A8F0CB1A5E8471BB2EB894B39C8"], level.vehicle.instances["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"]);
  return var_0;
}

enemy_molotov_launch() {
  var_0 = scripts\engine\utility::array_combine(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"], level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]);
  return var_0;
}

dangercircletick(var_0, var_1) {
  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances)) {
    return;
  }
  var_2 = 160.0;
  var_3 = 36.0;
  var_4 = 100.0;
  var_5 = getdvarfloat("_encstr_873B1FFA49B07F3A2EAFAB97215B11BB80F3768521810C4289EB8F6F5FFD3AF328", var_4);
  var_6 = enemy_monitor_reload();

  if(isDefined(var_6)) {
    foreach(var_8 in var_6) {
      var_9 = 0;
      var_10 = var_8.origin;
      var_11 = distance2d(var_0, var_10);

      if(var_11 + var_2 > var_1)
        var_9 = 1;
      else {
        var_12 = var_8 gettagorigin("_encstr_A25B0F90226CE1D68B2775E01217385D93");
        var_11 = distance2d(var_0, var_12);

        if(var_11 + var_3 > var_1)
          var_9 = 1;
      }

      if(var_9)
        var_8 dodamage(var_5, var_10, undefined, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
    }
  }

  var_14 = getdvarint("_encstr_92D5237FFB0A69BE437151584BEF6E40A7449FD76972C0F12769094182BFAC2831BC7B4F03", 85);

  if(isDefined(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"])) {
    foreach(var_16 in level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]) {
      var_17 = 0;
      var_10 = var_16.origin;
      var_11 = distance2d(var_0, var_10);

      if(var_11 > var_1)
        var_17 = 1;

      if(var_17)
        var_16 dodamage(var_14, var_10, undefined, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
    }
  }

  var_19 = getdvarint("_encstr_84AB21D71B537F02CD80AEE5F1950A1A9E98376BA848BD19C9A7751EECB361C4E0F0A7", 100);

  if(isDefined(level.vehicle.instances["_encstr_83F40783ADF1D14AA3"])) {
    foreach(var_21 in level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]) {
      var_22 = 0;
      var_10 = var_21.origin;
      var_11 = distance2d(var_0, var_10);

      if(var_11 > var_1)
        var_22 = 1;

      if(var_22)
        var_21 dodamage(var_19, var_10, undefined, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
    }
  }
}

hudcoststring(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getdvarfloat(var_5, 0);

  if(var_6 == 0) {
    return;
  }
  var_6 = clamp(var_6, 0, 100) / 100;
  var_7 = [];

  foreach(var_9 in var_0) {
    if(vars_update(var_9, var_1, var_2))
      var_7[var_7.size] = var_9;
  }

  var_7 = scripts\engine\utility::array_randomize(var_7);
  var_11 = floor(var_7.size * var_6);

  for(var_12 = 0; var_12 < var_7.size && var_12 < var_11; var_12++) {
    var_7[var_12].targetname = var_3;
    var_7[var_12].refname = var_4;
  }
}

vars_update(var_0, var_1, var_2) {
  if(isDefined(var_0.targetname) && var_0.targetname == var_1)
    return 1;

  if(isDefined(var_0.refname) && var_0.refname == var_2)
    return 1;

  return 0;
}

_id_13E0C(var_0) {
  var_1 = getdvarfloat("_encstr_936514F8B5FFD24FD8D71F81BF18E72B4950F333704D", 0);

  if(var_1 == 0) {
    return;
  }
  var_1 = clamp(var_1, 0, 100) / 100;
  var_2 = [];

  foreach(var_4 in var_0) {
    if(update_bomb_vest_controller(var_4))
      var_2[var_2.size] = var_4;
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_6 = floor(var_2.size * var_1);

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_4 = var_2[var_7];
    var_4.targetname = "_encstr_8E9213A9E1E5F340FFB2C355775A2907179BDFABBA";
    var_4.refname = "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F";
  }
}

update_bomb_vest_controller(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "_encstr_827911362D47E8C6CA26A539197D37C116DD37")
    return 1;

  if(isDefined(var_0.refname) && var_0.refname == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8")
    return 1;

  return 0;
}

tv_station_fastrope_two_infil_start_targetname_array(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "_encstr_85A91140D1CA87553BD33F571247EFC9616BB3")
    return 1;

  if(isDefined(var_0.targetname) && var_0.targetname == "_encstr_8CA71382101B81CD957678373BC8F05F339BD65B7D")
    return 1;

  if(isDefined(var_0.refname) && var_0.refname == "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6")
    return 1;

  if(isDefined(var_0.refname) && var_0.refname == "_encstr_BAC20FBEE6F88945F163A37BD68409923B")
    return 1;

  return 0;
}

uid(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "_encstr_BDC80A5437EAD749519A6068")
    return 1;

  if(isDefined(var_0.refname) && var_0.refname == "_encstr_BDC80A5437EAD749519A6068")
    return 1;

  return 0;
}

tutorial_intro(var_0) {
  if(isDefined(var_0.targetname) && var_0.targetname == "_encstr_83F40783ADF1D14AA3")
    return 1;

  if(isDefined(var_0.refname) && var_0.refname == "_encstr_83F40783ADF1D14AA3")
    return 1;

  return 0;
}
/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_safehouse_landlord.gsc
****************************************************************/

registersafehouse() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init("_encstr_BED8123A11EBBB557BA03F8378B11A826BB7C7B7");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_init("_encstr_8A4D18584B27992D95C6C8FAB9B0CC5643B7BAE6ACBEDBE0CA37");
  scripts\cp\cp_objectives::registerobjective("_encstr_A79417CDC233CA86EDEA372BAF63B0DC9136BD9C46EBB6DC57", undefined, undefined, undefined, undefined, ::debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_BA061352A1B8ED02C893BFFFDF615A2E10A8CD9A79", undefined, ::start_safehouse, undefined, ::debugbeatobjective, ::debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("_encstr_92091F63BFC19F1CDF50C3BA1901967B3991F7FA458E9B67E7800AB3480FCDC3F3", undefined, ::_id_12E59, undefined, undefined, ::debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("_encstr_B4771B67E1E75043CF3B0BF1A1FB8F403F74D71D8C01501D07A380FB3B", undefined, ::_id_137F8, undefined, ::debugbeatobjective, ::debugbeatobjective);
  scripts\engine\utility::flag_set("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
  scripts\engine\utility::flag_wait("_encstr_8B172BEB6971972FA031E39BD810078ED03B687FCBA81F2759A97AF24050CB07C19F0BC77FA0A5E371C1D3EA69");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E57();
}

debugbeatobjective(var_0) {}

debug_safehouse_start(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF"))
    scripts\engine\utility::flag_init("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");

  scripts\engine\utility::flag_set("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
  scripts\engine\utility::flag_wait("_encstr_8B172BEB6971972FA031E39BD810078ED03B687FCBA81F2759A97AF24050CB07C19F0BC77FA0A5E371C1D3EA69");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93");
  thread start_safehouse_objective();
}

isprophuntgametype(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF"))
    scripts\engine\utility::flag_init("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");

  scripts\engine\utility::flag_set("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
  scripts\engine\utility::flag_wait("_encstr_8B172BEB6971972FA031E39BD810078ED03B687FCBA81F2759A97AF24050CB07C19F0BC77FA0A5E371C1D3EA69");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_97B72813A868CC6A6F8EA711761B8295F070CFE710A6122247A66D93DFBF1B5479B8077B299B6C2A85BD");
  thread _id_137F9();
}

spawn_atvs() {
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 3;

  if(!isDefined(level.atvs))
    level.atvs = [];

  var_0 = scripts\engine\utility::getStructArray("_encstr_BA94131B16DC238DB74E19F5B0A33BAFE68385BBDC", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
  level thread _encstr_A62C388AE6BDCA10EBF0CEF78368F5B251060506D7BF5247F078BB4FC050B3EBB7159DFD3541FB9BFE40EB2349307E628534E6F3AE8166DF8338::_id_135AC();
}

start_safehouse_objective() {
  wait 3;
  scripts\cp\cp_objectives::run_objective("_encstr_BA061352A1B8ED02C893BFFFDF615A2E10A8CD9A79", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

start_safehouse(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8B172BEB6971972FA031E39BD810078ED03B687FCBA81F2759A97AF24050CB07C19F0BC77FA0A5E371C1D3EA69");
  level._id_121B1 = getEnt("_encstr_97C712BFACD9200D87F73B31DF8AD6786585A153", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_121B1))
    thread scripts\cp\cp_outofbounds::watchoobtrigger(level._id_121B1);

  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_1 = scripts\mp\vehicles\little_bird_mg_mp::blockachievementstimestamp((16520, -4520, 1656));
  var_2 = getentitylessscriptablearrayinradius("_encstr_8FCF25CDB14E9638D185893659AFE68DC99607E858C4C62BFAB05D1DF6EBC8B2E61B59DC8C2B27", "_encstr_AC110A7F14873B5B3D073009", var_1.origin, 256);
  var_3 = var_2[0];
  var_3 setscriptablepartstate("_encstr_8D1F09027BA68F8523E342", "_encstr_8698096D1870821A51010B");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, (16520, -4520, 1656), 2048, "_encstr_84FE2703B7E02CBB45A9AA5231082365B03DB795C3B876F3F803127A59F97FD130FF50B21FF87A9F93", "_encstr_AC110A7F14873B5B3D073009");
  level._id_139B5 = 1;
  thread trial_spawn_wp();
  thread trial_special_end();
  thread spawn_atvs();
  thread managejumpmasterinfodisplay();
  level waittill("_encstr_92EB1003730270708FCF718B369D703D4AE3");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, (16520, -4520, 1656), 2048, "_encstr_84FE2703B7E02CBB45A9AA5231082365B03DB795C3B876F3F803127A59F97FD130FF50B21FF87A9F93", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_5 in level.players) {
    var_5 skydive_setbasejumpingstatus(1);
    var_5 skydive_setdeploymentstatus(1);
  }

  var_3 setscriptablepartstate("_encstr_8D1F09027BA68F8523E342", "_encstr_AB0703DBB9");
  wait 5;
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_82040C6F3160DFAB4053A3C1F672");
}

_id_137F9() {
  wait 3;
  scripts\cp\cp_objectives::run_objective("_encstr_B4771B67E1E75043CF3B0BF1A1FB8F403F74D71D8C01501D07A380FB3B", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
}

_id_12E59(var_0) {
  scripts\engine\utility::flag_set("_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B");
  scripts\engine\utility::flag_wait("_encstr_B12F24A0BB6903E803B6636D846316CF8A7238E002B19FE16BD1F7DD5F97D88B724A8068BA17");
  level._id_139B5 = 1;
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_95E51E8C59CC8557631DEB38C6B0CBB24EEBB9D158C93AEBC24B2733B42B63C8");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  thread br_circleshowdelaysafe();
  thread br_clearinventory();
  setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");
  setDvar("_encstr_86D1161B8B078A43A0B9B4F5D3F1D7BF2C66A31B603FF1D2", "_encstr_92091F63BFC19F1CDF50C3BA1901967B3991F7FA458E9B67E7800AB3480FCDC3F3");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_95E51E8C59CC8557631DEB38C6B0CBB24EEBB9D158C93AEBC24B2733B42B63C8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_14329(1);
}

_id_137F8(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF"))
    scripts\engine\utility::flag_init("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");

  scripts\engine\utility::flag_set("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
  scripts\engine\utility::flag_wait("_encstr_8B172BEB6971972FA031E39BD810078ED03B687FCBA81F2759A97AF24050CB07C19F0BC77FA0A5E371C1D3EA69");

  if(!scripts\engine\utility::flag("_encstr_BED8123A11EBBB557BA03F8378B11A826BB7C7B7")) {
    thread _id_12B44(var_0);
    scripts\engine\utility::flag_wait("_encstr_BED8123A11EBBB557BA03F8378B11A826BB7C7B7");
    thread _id_13CE6();

    if(isDefined(level._id_121B1))
      level._id_121B1 scripts\engine\utility::trigger_off();

    setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");
    setDvar("_encstr_86D1161B8B078A43A0B9B4F5D3F1D7BF2C66A31B603FF1D2", "_encstr_92091F63BFC19F1CDF50C3BA1901967B3991F7FA458E9B67E7800AB3480FCDC3F3");
    level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }
}

_id_12B44(var_0) {
  var_1 = (19872, 3712, -442.974);
  thread return_to_safehouse_vo();
  objective_position(var_0.objectiveindex, var_1 + (0, 0, 90));
  objective_setlabel(var_0.objectiveindex, &"_encstr_B83C1C463189AE5182AF94CD4EC787E62560F7653751A91553645D37AF21");
  thread _id_12B47(var_1);
}

return_to_safehouse_vo() {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B10227D7C231ABC306070F737938BBE140C94C9D9BB87509530D6B3751C02259B8F087223158072717");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A7BC29F2700F766BCB30F7E6B196BF3E9560BADAB0EFAF9F8305D4FD569847C2C3D09222F88BE28F1E5798");
}

_id_12B47(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_1 < 31; var_1++) {
    var_3 = _id_11F26(var_0);

    if(var_3) {
      if(var_3 == level.players.size) {
        if(!var_2) {
          thread scripts\cp\utility::objective_update("_encstr_8F5B176323DB074A5F8B1BED082D773C30D3334FB4A3F7A0BE", 5, undefined, undefined, 1, undefined, 1, 1);
          var_2 = 1;
          var_1 = int(max(var_1, 24));
        }
      } else if(!var_2) {
        thread scripts\cp\utility::objective_update("_encstr_8F5B176323DB074A5F8B1BED082D773C30D3334FB4A3F7A0BE", 30, 20, 10, 1, undefined, 1, 1);
        var_2 = 1;
      }
    } else {
      if(var_2) {
        scripts\cp\cp_objectives::lua_objective_complete("_encstr_8F5B176323DB074A5F8B1BED082D773C30D3334FB4A3F7A0BE");
        thread scripts\cp\utility::objective_update("_encstr_B4771B67E1E75043CF3B0BF1A1FB8F403F74D71D8C01501D07A380FB3B");
        var_2 = 0;
      }

      var_1 = 0;
    }

    wait 1;
  }

  scripts\engine\utility::flag_set("_encstr_BED8123A11EBBB557BA03F8378B11A826BB7C7B7");
}

zombienumhitsatv() {
  scripts\engine\utility::flag_set("_encstr_8D561A7ABA3822F23519EB1BE1F9D8FABE9F1FA00DBF5BD9EB8B433B");
  scripts\engine\utility::flag_wait("_encstr_B12F24A0BB6903E803B6636D846316CF8A7238E002B19FE16BD1F7DD5F97D88B724A8068BA17");
}

_id_11F26(var_0) {
  var_1 = 0;
  var_2 = 148996;

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0) <= var_2)
      var_1++;
  }

  return var_1;
}

_id_14329(var_0) {
  scripts\cp\cp_compass::setupminimap("_encstr_AAE61AB852FD49817FCB1071B11B0E37E2F97820DA57B99843C418D6");
  _id_135B4();

  if(!isDefined(level._id_121B1)) {} else {
    level._id_121B1.origin = (24889, 13966, 11264);
    level._id_121B1 scripts\engine\utility::trigger_on();
  }

  if(!istrue(var_0)) {
    scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
    level thread choppersupport_watchleashrange();
    level waittill("_encstr_88D70B4C16AF67DED78CB7CDAC");
    scripts\mp\vehicles\vehicle_damage_mp::run_mission("_encstr_91DE0FCE21588B3BBFE35B595680ABA567");
    wait 4;
  } else {
    scripts\mp\vehicles\vehicle_damage_mp::run_mission("_encstr_91DE0FCE21588B3BBFE35B595680ABA567");
    wait 5;
  }

  var_1 = scripts\engine\utility::getStruct("_encstr_831721711036E3A339CD79B99FD73E95433D5343790F49A10BDF0A0D5973F8BF306678", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AD96140D0A7D35A29225D251E5887AE992F5D328519C", 25, "_encstr_97C20EB5FD43A179CC6AD05152651579", "_encstr_BD1805CB69C063", 512, 65, 64, 65);

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  var_2 delete();
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);
  var_4 = getEnt("_encstr_8FD01F85B44E66B495B191AFDCB0CC95A1F657E659BE760B93B0D959F58CDEB7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_93CF08C7684F60BBB372");
  scripts\engine\utility::flag_set("_encstr_8A4D18584B27992D95C6C8FAB9B0CC5643B7BAE6ACBEDBE0CA37");
}

br_clearinventory() {
  var_0 = getEntArray("_encstr_B6581868C712918B02557590EA3AEDB9604740405FE7284F8A7B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread scripts\cp\utility::create_fake_loot();
}

trial_special_end() {
  var_0 = getEntArray("_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread scripts\cp\utility::create_fake_loot();
}

br_circleshowdelaysafe() {
  var_0 = scripts\engine\utility::getStruct("_encstr_8D1A202CA5C999B4B2B1C8FAE658CCB243EDBA9B95FA95912D477D1BB7C28CEDAE1D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var_0);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_967B0985969CCC2D561B19", "_encstr_87571A3ADED9ECC6ACEBCD85665643EDEA3795BEB956E83A9637CECD", 10, 1);
}

trial_spawn_wp() {
  var_0 = scripts\engine\utility::getStruct("_encstr_99B41B54FB4827F3F00312A90BDFE3DFD07FC5B31B19EDB7AFB9BA33F3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var_0);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_811D0B60AF6F53294F409B09B3", "_encstr_92EB1003730270708FCF718B369D703D4AE3", 10, 1);
  var_0 = scripts\engine\utility::getStruct("_encstr_AF5722D96165D8C14FCB6936E34F8C98BCF7639F0D8120989F42ED7BFBDF3628165EDF3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var_0);
}

_id_135E8(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  self.ignoreme = 1;
  self.anchor = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.anchor setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 = vectortoangles(var_1.origin + (0, 0, -60000) - var_0.origin);
  self.anchor.angles = var_2;
  self cameralinkTo(self.anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 0, 1);
  self.anchor rotateTo(var_2, 0.15);
  self.anchor moveTo(var_0.origin + (0, 0, 20000), 2);
  self predictstreampos(var_1.origin + (0, 0, 1000));
  wait 2.5;
  var_2 = vectortoangles(var_1.origin - self.anchor.origin);
  self.anchor rotateTo(var_2, 0.75);
  self.anchor moveTo(var_1.origin, 2);
  wait 1.85;
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(0.15, 0.25, 0.5);
  wait 0.5;
  self cameraunlink();
  self.anchor delete();
  self clearpredictedstreampos();
}

_id_13CE6() {
  foreach(var_1 in level.players)
  level thread scripts\mp\vehicles\vehicle_damage_mp::regroup_blackscreen(var_1, "_encstr_8CD7092B58C7CBC3A13B74", "_encstr_B4771B67E1E75043CF3B0BF1A1FB8F403F74D71D8C01501D07A380FB3B", "_encstr_A3A407992C912BB473");

  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  zombienumhitsatv();
  level notify("_encstr_8CD7092B58C7CBC3A13B74");
  level waittill("_encstr_BE95124BC1DCBBADD061D7E45360B3C7F53802A2");
  wait 1;
  var_3 = spawnStruct();
  var_3.angles = (0, 0, 0);
  var_3.origin = level.players[0].origin + (0, 0, 90);
  var_4 = spawnStruct();
  var_4 = scripts\engine\utility::getStructArray("_encstr_95E51E8C59CC8557631DEB38C6B0CBB24EEBB9D158C93AEBC24B2733B42B63C8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0];
  thread br_circleshowdelaysafe();
  thread br_clearinventory();
  var_5 = "_encstr_95E51E8C59CC8557631DEB38C6B0CBB24EEBB9D158C93AEBC24B2733B42B63C8";

  if(getdvarint("_encstr_B15F13C173303F0F1D38FA31E1E1333960E9795FE5") > 0)
    var_5 = "_encstr_BDB51520BAB2FD18AF2C75E03EAB80A59B613830D20B35";

  var_6 = scripts\engine\utility::getStructArray(var_5, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E5A(var_6);
  wait 1;
  level notify("_encstr_A3A407992C912BB473");
  wait 3;
  _id_14329();
}

choppersupport_watchleashrange() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BD4922EAA2AF3FAA207FA3B103E83973B77B72C169EEA7263871B48735987CD76C968FBF", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A17A22C86B3937FB375F31BF6BEFC6FD1E634889924A4F910784C5B85283484B07494A7A", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A64922A1306F280F0B3F9F93EF72C068E94A095E9EAB704F439BA9E7FBAB13E886297B3B", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B67A22190FF58D07DCAF1B0B9BB9BEC42C6ECAEBB09BDC16AEC647EB4C392DAC99FA0D18", "_encstr_9A8507BA4040188D08");
  level notify("_encstr_88D70B4C16AF67DED78CB7CDAC");
  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
  level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
}

managejumpmasterinfodisplay() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_831409792835B3A07E4B18") > 0) {
    wait 3;
    level notify("_encstr_92EB1003730270708FCF718B369D703D4AE3");
    level notify("_encstr_99FF0E6CF89042DA888D276F8148128D");
    level._id_139B5 = 0;
    return;
  }

  var_0 = 0;

  if(getdvarint("_encstr_BDA10A73413891FBD1FBD9F4") != 0 && getdvarint("_encstr_BDA10A73413891FBD1FBD9F4") != 1)
    var_0 = 1.5;

  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_994D1B6AE897FEE373B87C69469B97060FB0D352696773DF0B154731FF", "_encstr_9A8507BA4040188D08");
  wait(var_0);
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
  wait(level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_97E61347B0CDA621176D7DB7CED33A476B1883E3A8") + 1);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AA2A1B89185710372367F9EBFF0BE8F00D73528D49D25063BA9BA7538A", "_encstr_9A8507BA4040188D08");
  wait(var_0);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_83CB1BF9F30FDEE8BA3F8F932566C91DAF4BD26029438EE8D71EDF2D30", "_encstr_9A8507BA4040188D08");
  wait(var_0);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_912A1B30F34F61E93329C15F3AEB6F4BD57B50E8070A1B937A8F507EC2", "_encstr_9A8507BA4040188D08");
  wait(var_0);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_95CB1B6B33B96FE026E7CB21F96F27238AD878C4FF6010C38518072AA2", "_encstr_9A8507BA4040188D08");
  wait(var_0);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B12A1B983B6907CB078FE16F9B3F16E14D63F820A1FE9DA037DE607D30", "_encstr_9A8507BA4040188D08");
  wait(var_0);
  level notify("_encstr_92EB1003730270708FCF718B369D703D4AE3");
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));
  wait(level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB"));
  level notify("_encstr_99FF0E6CF89042DA888D276F8148128D");
  setDvar("_encstr_831409792835B3A07E4B18", 1);
  level._id_139B5 = 0;
}

_id_135B4() {
  var_0 = spawnStruct();
  var_0.origin = (3097.5, 61399, 758.734);
  var_0.angles = (0, 225, 0);
  var_0.team = "_encstr_9A8507BA4040188D08";
  scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0);
}

_id_13776(var_0) {
  zombienumhitsatv();
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_95E51E8C59CC8557631DEB38C6B0CBB24EEBB9D158C93AEBC24B2733B42B63C8");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  thread br_circleshowdelaysafe();
  thread br_clearinventory();
  setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");
  setDvar("_encstr_86D1161B8B078A43A0B9B4F5D3F1D7BF2C66A31B603FF1D2", "_encstr_92091F63BFC19F1CDF50C3BA1901967B3991F7FA458E9B67E7800AB3480FCDC3F3");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_95E51E8C59CC8557631DEB38C6B0CBB24EEBB9D158C93AEBC24B2733B42B63C8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_14329();
}
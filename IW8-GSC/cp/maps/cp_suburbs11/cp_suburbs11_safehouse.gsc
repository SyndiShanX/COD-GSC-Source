/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_suburbs11\cp_suburbs11_safehouse.gsc
***********************************************************/

main() {
  level.safehouse_s11_obj_func = ::safehouse_obj_func;
}

safehouse_obj_func() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init("_encstr_BED8123A11EBBB557BA03F8378B11A826BB7C7B7");
  scripts\engine\utility::flag_init("_encstr_ABFE1A0A7878B7BAF10B73CF4F2FF2ED3880039291D16A52D5330B13");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\cp\cp_objectives::registerobjective("_encstr_8EE61883FA7355A005AD37039F6AABAE47A3390B478680709D85", undefined, undefined, undefined, undefined, ::debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_96AC1437B0332BA1B757CD2B7D6EBAC4AB274CCD98C4", undefined, ::start_safehouse, undefined, ::debugbeatobjective, ::debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("_encstr_8D5311B3A74307D05D8B3B354F32CD10532B2D", undefined, ::_id_12E58, undefined, ::debugbeatobjective, ::debugbeatobjective);
  scripts\engine\utility::flag_wait("_encstr_AF672C83E7364B0D0DE0838BE817421749C56837FD5BB7D91F48EAE30845BA8E0BA093A3AFE1D71DC19882EBA891");
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E57();
}

debugbeatobjective(var_0) {}

debug_safehouse_start(var_0) {
  thread threaded_debug_start();
}

threaded_debug_start() {
  scripts\engine\utility::flag_wait("_encstr_AF672C83E7364B0D0DE0838BE817421749C56837FD5BB7D91F48EAE30845BA8E0BA093A3AFE1D71DC19882EBA891");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C");
  thread start_safehouse_objective();
}

spawn_atvs(var_0, var_1) {
  scripts\engine\utility::flag_wait("_encstr_AF672C83E7364B0D0DE0838BE817421749C56837FD5BB7D91F48EAE30845BA8E0BA093A3AFE1D71DC19882EBA891");

  if(istrue(var_1))
    scripts\engine\utility::flag_wait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D");

  if(!isDefined(level.atvs))
    level.atvs = [];

  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_2, 1);
}

_id_135E1(var_0) {
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 3;

  if(!isDefined(level.tacrovers))
    level.tacrovers = [];

  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\vehicles\tac_rover_cp::tac_rover_cp_createfromstructs(var_1, 1);
}

start_safehouse_objective() {
  scripts\engine\utility::flag_wait("_encstr_AF672C83E7364B0D0DE0838BE817421749C56837FD5BB7D91F48EAE30845BA8E0BA093A3AFE1D71DC19882EBA891");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C");
  var_0 = scripts\engine\utility::getStructArray("_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0].origin;
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(scripts\engine\utility::getStruct("_encstr_8EDE1CB9DAAEECECB1AC39FA9B1699B20DEDAE372BC4D736B72CC8B7EAE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_BD320BCDD6BA3B3BC6CAC9BEC4", "_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7", 10, 1);
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  thread spawn_atvs("_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330");
  thread _id_135E1("_encstr_A5BB1812093FE74FD2CDDA1E39734E4A402B071881DF78FFDCB5");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_0, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_0, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  scripts\cp\cp_objectives::run_objective("_encstr_8DD40BAF059011477FB95AB283", "_encstr_BA7F0830B3A7859B60B0", "_encstr_9A8507BA4040188D08");
  wait 0.7;
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_0, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_0, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_0, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_0, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  level waittill("_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);

  foreach(var_2 in level.players)
  var_2 thread precomputeddropbagpos();

  level._id_121B1 = getEnt("_encstr_97C712BFACD9200D87F73B31DF8AD6786585A153", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_121B1))
    thread scripts\cp\cp_outofbounds::watchoobtrigger(level._id_121B1);
}

precomputeddropbagpos() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0";

  if(!istrue(self._id_124C8)) {
    return;
  }
  for(;;) {
    wait 0.1;

    if(self issupersprinting()) {
      continue;
    }
    if(self issprinting()) {
      continue;
    }
    if(self isgestureplaying(var_0)) {
      wait 0.5;

      if(self isgestureplaying(var_0)) {
        var_1 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
        self._id_127F9 = self getcurrentprimaryweapon();
        scripts\cp\utility::_giveweapon(var_1, undefined, undefined, 1);
        self switchtoweaponimmediate(var_1);
        wait 0.05;
        self takeweapon(var_1);
        self switchtoweaponimmediate(self._id_127F9);
        continue;
      }
    }

    if(self isgestureplaying()) {
      continue;
    }
    self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
    break;
  }
}

start_safehouse(var_0) {
  scripts\engine\utility::flag_wait("_encstr_AF672C83E7364B0D0DE0838BE817421749C56837FD5BB7D91F48EAE30845BA8E0BA093A3AFE1D71DC19882EBA891");
  wait 1;
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8DD40BAF059011477FB95AB283");
}

_id_12E58(var_0) {
  scripts\engine\utility::flag_set("_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D");
  scripts\engine\utility::flag_wait("_encstr_AA6B2D272846C362530C1FD56505198B2920B79338FB1B2A2F16228F5FE1723331E83F7B781643B2B3B7AD873DFB1A");
  var_1 = scripts\engine\utility::getStruct("_encstr_A2B9216EADAB9DD9C62BC9FAB9C233B2A1DBABE6B2F564D79359D993BDAB1CFA0EB7E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_position(var_0.objectiveindex, var_1.origin);
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  regroup_at_safehouse();
}

regroup_at_safehouse() {
  var_0 = getEnt("_encstr_92011CBFEF0BEC5804373B965AF1A815327F3B0767F10ED1368DE02BC5DD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A7132B5FD1BE1C29FDC87BA3583760E2E491C78BA137551167ECB56B300FF9A9CD09635F29CF8D19BF90CA958D", "_encstr_9A8507BA4040188D08", 5);
  scripts\mp\vehicles\vehicle_damage_mp::_id_12E58(var_0, "_encstr_BED8123A11EBBB557BA03F8378B11A826BB7C7B7");
  level notify("_encstr_A55313D36A6F0488B5CD4527E2DF4056DF034B9962");
  thread mover_update();
}

mover_update() {
  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0].ability_invulnerable = 1;

  foreach(var_2 in level.players) {
    var_2 scripts\cp_mp\xmike109::scriptable_callback("_encstr_AAD00AD085E4135A73D9AC9C");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_A3C90EDA7166EB3C18BF1DF237F8453B");
        continue;
      }

      var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_B63F125B364BAD480EC778D83F55C0E9E19B45DD");
    }
  }

  wait 2;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

_id_137F7() {
  scripts\engine\utility::flag_init("_encstr_841419E17B980A53234E3A5233FE6F095827577EFB4814AF4321E2");
  var_0 = "_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D";

  if(!scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_init(var_0);

  if(!scripts\engine\utility::flag(var_0))
    scripts\engine\utility::flag_set(var_0);

  scripts\engine\utility::flag_wait(var_0 + "_encstr_93D80BF536F6B638D8AC1D95C8");
  wait 1;
  var_1 = scripts\engine\utility::getStruct("_encstr_825922CD6BD59D3B1B9593AF9B2C662B437BAB37B2BEC8EB56232D1DD736DBB091BD57A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray("_encstr_8F83222EDA9B01B75C9993AFA3F74B7DB827535351175A2F8328F792D7B36163F868737E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEntArray("_encstr_992D1A97C723C440ECDFC37E42C9800D4A67031F9FE936B934B56813", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getStruct("_encstr_A2B9216EADAB9DD9C62BC9FAB9C233B2A1DBABE6B2F564D79359D993BDAB1CFA0EB7E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1)) {
    return;
  }
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(var_1);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_88320B3668030F7A08AA96D16B", "_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7", 10, 1);
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E56(var_3);
  setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");
  level.initlocs_bunkertest = var_2;
  level._id_139B5 = 1;
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_4.origin, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_4.origin, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  if(getDvar("_encstr_8CEF141FA80148791FB25138FA6B3810A41981EF36F5", "_encstr_B40101") == "_encstr_B40101") {
    level thread _id_12414();
    wait 35;
  } else {
    level thread _id_12414(1);
    wait 10;
  }

  setDvar("_encstr_8CEF141FA80148791FB25138FA6B3810A41981EF36F5", "_encstr_8A18059BF07BBA");
  scripts\engine\utility::flag_set("_encstr_841419E17B980A53234E3A5233FE6F095827577EFB4814AF4321E2");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_4.origin, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_4.origin, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_4.origin, 2048, "_encstr_AC822360CA62D30BDB7126294D4FB1978D438938627D71615BA737972ECFF82FF5CB118A3F", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_14325(var_4.origin, 2048, "_encstr_85B92416A340A97F83B1429915A66FB8E0B04FABAFEFC59FDB515AA7353D48B46190D39961EA", "_encstr_AC110A7F14873B5B3D073009");
  level waittill("_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7");

  foreach(var_6 in level.players)
  var_6 thread precomputeddropbagpos();

  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);
  scripts\cp\utility::_id_123FE("_encstr_AA3C19ADEACDEB6C38AFB9ADAED93BB12B39FAE8E40B9D561BF5D0");
  level._id_139B5 = 0;
}

_id_12414(var_0) {
  level endon("_encstr_AB79125B1DC8E3C9FF381A23E021BC632110C6CF");
  wait 5;

  if(!istrue(var_0)) {
    scripts\mp\vehicles\vehicle_damage_mp::_id_12409("_encstr_AFAD05B58130DB");
    level play_vo_delay("_encstr_91BD2532F0D78D3837D73685DCE6BEE2AEB04EC95E91BEB696E69B2DB773BE5AB9479C7BEB9881");
    wait 1.5;
    level play_vo_delay("_encstr_AF9D1D1BFB1F37D307F9F243089091AB459F9252D842AFF3C69C4AB7F1BE2F");
    wait 0.75;
    scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
  } else {
    level play_vo_delay("_encstr_AF9D1D1BFB1F37D307F9F243089091AB459F9252D842AFF3C69C4AB7F1BE2F");
    wait 0.75;
    scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
  }
}

play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    wait(var_4);

  if(isDefined(var_0))
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08", var_3, var_5, var_6);

  if(isDefined(var_1))
    wait(var_1);

  if(isDefined(var_2))
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);
}
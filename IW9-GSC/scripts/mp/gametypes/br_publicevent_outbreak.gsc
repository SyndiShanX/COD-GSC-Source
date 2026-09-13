/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_outbreak.gsc
************************************************************/

main() {
  level thread _id_566F849E77540164();
}

_id_566F849E77540164() {
  level endon("disable_public_event");
  level endon("game_ended");

  if(isDefined(level._id_034714CE799B6017) && !level._id_034714CE799B6017) {
    return;
  }
  level waittill("init_public_event");
  init();
}

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_AF5F123DDBD1ABA0", 1.0);
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_6D1AB4854ECCFD8B", 0);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("outbreak", "020 20 20 0000\t 0000");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("outbreak");
  _id_337BD370F7C5E6F9::registerpublicevent(20, _id_7EC7671A1E0C788F);
}

_id_C9E871D29702E8CF() {
  game["dialog"]["human_outbreak_meter_25percent"] = "zxp1_wzan_mt75";
  game["dialog"]["human_outbreak_meter_50percent"] = "zxp1_wzan_mt50";
  game["dialog"]["human_outbreak_meter_75percent"] = "zxp1_wzan_mt25";
  game["dialog"]["zmb_outbreak_meter_25percent"] = "zxp1_wzan_mz75";
  game["dialog"]["zmb_outbreak_meter_50percent"] = "zxp1_wzan_mz50";
  game["dialog"]["zmb_outbreak_meter_75percent"] = "zxp1_wzan_mz25";
  game["dialog"]["human_outbreak_announcement"] = "zxp1_wzan_mtfl";
  game["dialog"]["zmb_outbreak_announcement"] = "zxp1_wzan_mzfl";
  _id_0EC17C5D2776FA83 = _id_8E69ED234B909498(0.05, "human_outbreak_announcement", "zmb_outbreak_announcement", 2.5, -1);
  _id_0E050855AE9B4BF4 = _id_8E69ED234B909498(0.25, "human_outbreak_meter_25percent", "zmb_outbreak_meter_25percent", 0.5, 0);
  _id_8E1B9588B2A5CED4 = _id_8E69ED234B909498(0.5, "human_outbreak_meter_50percent", "zmb_outbreak_meter_50percent", 0.5, 1);
  _id_1CAD5690C51334E7 = _id_8E69ED234B909498(0.75, "human_outbreak_meter_75percent", "zmb_outbreak_meter_75percent", 0.5, 2);
  level.brgametype._id_CAC7326DB3301CC1 = [_id_0EC17C5D2776FA83, _id_0E050855AE9B4BF4, _id_8E1B9588B2A5CED4, _id_1CAD5690C51334E7];
  level.brgametype._id_E7CDD3FB24F93391 = 3;
  level.brgametype._id_D2DA0BD454548D48 = getdvarfloat("dvar_058E3FE90E58C6E2", 47);
  level.brgametype._id_37A6FEF4EBDCD6A4 = (0, 0, 0);

  if(isDefined(level.brgametype._id_EF005D8AAD03C36C))
    level.brgametype._id_37A6FEF4EBDCD6A4 = level.brgametype._id_EF005D8AAD03C36C;
}

validatefunc() {
  _id_FAF0D2FAC3F47583 = level scripts\mp\utility\game::getsubgametype();
  _id_B3074827E0D12849 = _id_FAF0D2FAC3F47583 == "zxp" || _id_FAF0D2FAC3F47583 == "brz" || _id_FAF0D2FAC3F47583 == "gxp";
  isvalid = 0;
  _id_2D70C3E4D540CB04 = istrue(level.usegulag) && !_id_362C58E8BB39BCDA::isfeaturedisabled("gulag");

  if(_id_B3074827E0D12849 && !_id_2D70C3E4D540CB04)
    isvalid = 1;

  return isvalid;
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

activatefunc() {
  level endon("game_ended");
  _id_79324A8BCFC504A1 = 3.5;
  _id_01491D8D252AD642 = _id_294DDA4A4B00FFE3::_id_4AD287E0971672A6();

  if(!_id_01491D8D252AD642)
    _id_3D710EBC0F4C181B("br_pe_outbreak_incoming");

  wait(_id_79324A8BCFC504A1);
  thread _id_1B203C25FDA5E3A8();
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();
  _id_5E660C5ED0F2504C = undefined;
  _id_81A566D2F1047439 = undefined;
  _id_827C53020F6F228F = getdvarint("dvar_520F4DFD896E0888", 1);

  if(!_id_01491D8D252AD642)
    _id_337BD370F7C5E6F9::showsplashtoall("br_pe_outbreak_active", "splash_list_br_pe_outbreak");

  if(_id_827C53020F6F228F && _id_362C58E8BB39BCDA::isbrgametypefuncdefined("onEliminatedTeamsRespawn"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("onEliminatedTeamsRespawn");

  thread respawnplayers(_id_827C53020F6F228F);
}

calculateeventstarttime() {
  _id_87940078241E4580 = getdvarfloat("dvar_17D74BBA636E9A92", 795.0);
  _id_07AF9598177DC2DE = getdvarfloat("dvar_17B455BA634868D8", 1110.0);

  if(_id_07AF9598177DC2DE > _id_87940078241E4580)
    return randomfloatrange(_id_87940078241E4580, _id_07AF9598177DC2DE);
  else
    return _id_87940078241E4580;
}

_id_C725A0493496F7AA(player, _id_827C53020F6F228F) {
  if(!isDefined(player))
    return 0;

  _id_54EBFC906D9A55E7 = scripts\mp\utility\teams::getteamdata(player.team, "alivePlayers");
  _id_18AB43B1D2DABCCB = scripts\engine\utility::array_contains(_id_54EBFC906D9A55E7, player);

  if(_id_18AB43B1D2DABCCB || istrue(player.respawningfromtoken))
    return 0;

  if(!_id_827C53020F6F228F && _id_54EBFC906D9A55E7.size == 0)
    return 0;

  return 1;
}

respawnplayers(_id_827C53020F6F228F) {
  level endon("game_ended");

  foreach(player in level.players) {
    if(_id_C725A0493496F7AA(player, _id_827C53020F6F228F)) {
      player._id_584C38D71AA17739 = 1;
      player thread _id_0F820C96419FE887::playerzombierespawn(0, 1);
      waitframe();
    }
  }
}

_id_3D710EBC0F4C181B(splashname) {
  foreach(player in level.players) {
    if(scripts\mp\utility\player::isreallyalive(player))
      player scripts\mp\hud_message::showsplash(splashname, undefined, undefined, undefined, undefined, "splash_list_br_pe_outbreak");
  }
}

_id_8E69ED234B909498(_id_6C8D21B2E54B2478, _id_A16D41FB5B817106, _id_4F990706B21F9CD3, _id_D0E34A284E587AA8, _id_E445F60177FD30D7) {
  _id_36933C75F6C4F948 = spawnStruct();
  _id_36933C75F6C4F948._id_6C8D21B2E54B2478 = _id_6C8D21B2E54B2478;
  _id_36933C75F6C4F948._id_A16D41FB5B817106 = _id_A16D41FB5B817106;
  _id_36933C75F6C4F948._id_4F990706B21F9CD3 = _id_4F990706B21F9CD3;
  _id_36933C75F6C4F948._id_D0E34A284E587AA8 = _id_D0E34A284E587AA8;
  _id_36933C75F6C4F948._id_E445F60177FD30D7 = _id_E445F60177FD30D7;
  return _id_36933C75F6C4F948;
}

_id_C8B0148638FB3F0A() {
  _id_D52CAA35D2B2D235 = _id_294DDA4A4B00FFE3::_id_3168DDA92F94DE9C();

  if(!isDefined(_id_D52CAA35D2B2D235)) {
    return;
  }
  _id_0AEA01ED6C64EF3C = level.brgametype._id_E7CDD3FB24F93391;

  if(isDefined(level.brgametype._id_CAC7326DB3301CC1)) {
    for(index = 0; index <= level.brgametype._id_E7CDD3FB24F93391; index++) {
      state = level.brgametype._id_CAC7326DB3301CC1[index];

      if(_id_D52CAA35D2B2D235 <= state._id_6C8D21B2E54B2478) {
        _id_99E8FCB28E160694 = [];
        _id_926296FA3AEECB13 = [];
        _id_69B535CDFDCF807D = [];

        foreach(player in level.players) {
          if(!isDefined(player)) {
            continue;
          }
          if(scripts\mp\utility\player::isreallyalive(player)) {
            if(istrue(player _id_2CEDCC356F1B9FC8::playeriszombie()))
              _id_926296FA3AEECB13[_id_926296FA3AEECB13.size] = player;
            else
              _id_99E8FCB28E160694[_id_99E8FCB28E160694.size] = player;

            continue;
          }

          _id_69B535CDFDCF807D[_id_69B535CDFDCF807D.size] = player;
        }

        _id_2F2C13FE976A62C3 = state._id_6C8D21B2E54B2478 == level.brgametype._id_CAC7326DB3301CC1[0]._id_6C8D21B2E54B2478;
        _id_44558DDFE2E91DBF = scripts\engine\utility::ter_op(_id_2F2C13FE976A62C3, scripts\engine\utility::array_combine(_id_926296FA3AEECB13, _id_69B535CDFDCF807D), _id_69B535CDFDCF807D);

        if(isDefined(state._id_A16D41FB5B817106))
          _id_2CEDCC356F1B9FC8::brleaderdialog(state._id_A16D41FB5B817106, 1, _id_99E8FCB28E160694, 1, state._id_D0E34A284E587AA8, undefined, "dx_br_bds6_");

        if(isDefined(state._id_4F990706B21F9CD3))
          _id_2CEDCC356F1B9FC8::brleaderdialog(state._id_4F990706B21F9CD3, 1, _id_44558DDFE2E91DBF, 1, state._id_D0E34A284E587AA8, undefined, "dx_br_bds6_");

        level.brgametype._id_E7CDD3FB24F93391 = state._id_E445F60177FD30D7;
        return;
      }
    }
  }
}

_id_EB754127266D1DEC() {
  _id_D52CAA35D2B2D235 = _id_294DDA4A4B00FFE3::_id_3168DDA92F94DE9C();

  if(!isDefined(_id_D52CAA35D2B2D235)) {
    return;
  }
  if(_id_D52CAA35D2B2D235 <= 0.1 && !istrue(level.brgametype._id_1F9E3CE0A38EB72F))
    thread _id_549E7EB58B82CE6F();
}

_id_549E7EB58B82CE6F() {
  level endon("game_ended");
  script_origin = spawn("script_origin", level.brgametype._id_37A6FEF4EBDCD6A4);
  script_origin hide();
  waitframe();
  script_origin playSound("scn_zr_infestation_siren");
  level.brgametype._id_1F9E3CE0A38EB72F = 1;
  wait(level.brgametype._id_D2DA0BD454548D48);
  script_origin delete();
  level.brgametype._id_1F9E3CE0A38EB72F = 0;
}

_id_1B203C25FDA5E3A8() {
  level endon("game_ended");
  script_origin = spawn("script_origin", level.brgametype._id_37A6FEF4EBDCD6A4);
  script_origin hide();
  waitframe();
  script_origin playSound("scn_zr_infestation_zombies_far");
  wait 10;
  script_origin delete();
}
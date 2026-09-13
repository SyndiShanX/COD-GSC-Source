/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1a81bc4d0bda1aa6.gsc
***********************************************/

_id_56DDFF8548C968D6() {
  level.player = _id_78DAC680A1677E7C::_id_F765ACF5B7C0C4A1();
  level.player endon("entitydeleted");
  level.player _id_3FB16506404E5493::_id_7ACF4442545D6B26("orientation_match_preload");

  while(level.player.sessionstate == "spectator" || level.player.sessionstate == "intermission")
    waitframe();

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_wait_for_intermission_ended");
  level.player setsoundsubmix("fade_to_black_all_except_music", 0, 1);
  level.player setclientomnvar("ui_br_extended_load_screen", 1);
  level.player _meth_670863FC4008C3D8(level._id_DBF4D97004E64BD5._id_3D84EEF8B3AFE5EB);

  while(!_func_96D228FA8E72A818(level.player) && !level.player isadditionalstreamposready())
    waitframe();

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_start_position_ready");
  level.player _meth_E4A38A7C9732F011("autoGrabWeapons", 0);
  level.player _meth_E4A38A7C9732F011("toggleADSEnabledTouch", 1);
  level.player _meth_E4A38A7C9732F011("autoFireTouch", 0);
  vehicle_allowplayeruse(level.player, 0);
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_gamer_profile_commands_sent");
  level.player _id_23A85A6F3340BF6F::_id_67D00E6B876C5EE2(level._id_DBF4D97004E64BD5._id_3D84EEF8B3AFE5EB, level._id_DBF4D97004E64BD5._id_9D94E563E4BE46B8);
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_player_teleported");
  level.player skydive_interrupt();
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_skydive_interrupted");
  level.player scripts\mp\teams::createoperatorcustomization(level._id_DBF4D97004E64BD5._id_56E53E400A2D0F31[0], level._id_DBF4D97004E64BD5._id_56E53E400A2D0F31[1]);
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_player_operator_updated");
  level.player takeallweapons();
  startingweapon = _id_2669878CF5A1B6BC::buildweapon(level._id_DBF4D97004E64BD5._id_1176926A4B469EAC, undefined, undefined, undefined, -1, undefined, undefined, undefined, 0);
  level.player giveweapon(startingweapon);
  level.player switchtoweapon(startingweapon);
  level.player allowfire(0);
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_player_equipment_ready");
  level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_F04017EEB74341EF = _id_0A947BE31E190E16::_id_E6019A2D874F8C36(level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_C2E05BD1D324F3D3, level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_3E64B0476403507A, level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_0D651012A7700B7E, level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_ED077719222AD193);
  level._id_DBF4D97004E64BD5._id_4B422FDC1B596EF9._id_8B46CAE7D035A67C = _id_0A947BE31E190E16::_id_225BE5A2F4CAA3AF(level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_C2E05BD1D324F3D3, level._id_DBF4D97004E64BD5._id_4B422FDC1B596EF9._id_BDDB37F38F87A338);
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_weapon_ammo_prespawned");

  if(level._id_DBF4D97004E64BD5._id_6DE4E8C345415ADE)
    _id_78DAC680A1677E7C::_id_E27C8EAD6AB015FA(level._id_DBF4D97004E64BD5._id_14500EBF04E5180E);

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_walls_spawned");

  if(level._id_DBF4D97004E64BD5._id_74F9D8BEDFDA6770)
    _id_63002651C12F57E3::_id_CE9D634E565EF6DE(level._id_DBF4D97004E64BD5.vehicles);

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_vehicles_spawned");

  if(level._id_DBF4D97004E64BD5._id_9572C127E918050C)
    _id_78DAC680A1677E7C::_id_DE1ACB2EC7807E38();

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_level_assets_spawned");

  if(level._id_DBF4D97004E64BD5._id_212875D77B9905F5)
    _id_669A0D5052376C2C::_id_9813640FB9B49E46(level._id_DBF4D97004E64BD5._id_C0271A486AA56405);

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_enemy_bots_spawned");

  if(level._id_DBF4D97004E64BD5._id_DF53369F451F4139)
    _id_669A0D5052376C2C::_id_9813640FB9B49E46(level._id_DBF4D97004E64BD5._id_395082021DFC3AE9);

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_ally_bots_spawned");

  if(isDefined(level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")]._id_E0E1C48A5393D3D1))
    level._id_3896BF00E9C5CA00 = level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")]._id_E0E1C48A5393D3D1;

  level.player thread _id_23A85A6F3340BF6F::_id_F83C33A014EE22FE();
  level.player setstance(level._id_DBF4D97004E64BD5._id_396891C2565891D8);
  level.player.armorhealth = 0;
  level.player setclientomnvar("ui_armor_percent", 0);

  if(isDefined(level._id_3896BF00E9C5CA00))
    level._id_3896BF00E9C5CA00 setstance(level._id_DBF4D97004E64BD5._id_8C5DA83724FD450B);

  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_ally_and_player_ready");
  _id_245DDDCAF477A7C4::_id_919B5AD1E695966C();
  wait 3;
  level.player setclientomnvar("ui_br_extended_load_screen", 0);
  level.player clearadditionalstreampos();
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_preload_loading_screen_cleared");
  level.player clearsoundsubmix("fade_to_black_all_except_music", 0);
  _id_4585999B9BC82F8F::_id_6481FDD7C2EB7D5C();

  if(getdvarint("dvar_521FD4CA05C98FE5", 0) == 1)
    level.player _id_5C61825C1DCE3571::_id_E05669C955312C22(2, 1);

  level.player _id_3FB16506404E5493::_id_7004AD4F3793CEDB("orientation_match_preload");
}

_id_C4BDFC504CBE12B4() {
  level.player _id_3FB16506404E5493::_id_7ACF4442545D6B26("orientation_match_infil_sequence");
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("moveCameraTip");
  level.player freezecontrols(1);
  _id_245DDDCAF477A7C4::_id_1748039E0A11F61B();
  level.player freezecontrols(0);
  level.player _id_3FB16506404E5493::_id_7004AD4F3793CEDB("orientation_match_infil_sequence");
}

_id_45E7081F7ADD52DE() {
  level.player _id_3FB16506404E5493::_id_7ACF4442545D6B26("orientation_match_heli_sequence");
  _id_1E2E5336470B52B6 = level._id_DBF4D97004E64BD5.vehicles[_func_1823FF50BB28148D("LittleBird_1")]._id_F86FAA8C5CA8BA0C;
  _id_1E2E5336470B52B6.origin = level._id_DBF4D97004E64BD5._id_9004C82EA70421BC.spawnposition;
  _id_1E2E5336470B52B6.angles = level._id_DBF4D97004E64BD5._id_9004C82EA70421BC.spawnangles;
  _id_1E2E5336470B52B6 thread _id_63002651C12F57E3::_id_721F3E8A51E2D485(level._id_DBF4D97004E64BD5._id_9004C82EA70421BC._id_DB585B8134EED64C);
  level.player _id_3FB16506404E5493::_id_7004AD4F3793CEDB("orientation_match_heli_sequence");
}

_id_BE0865890F99C70E() {
  level.player _id_3FB16506404E5493::_id_7ACF4442545D6B26("orientation_match_execution_sequence");

  if(!isDefined(level._id_3896BF00E9C5CA00) || !isDefined(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D("ExecuteBot_1")]._id_E0E1C48A5393D3D1)) {
    return;
  }
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("moveCameraTip");
  level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("crouch");
  level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_D780D856D7D110A4(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D("ExecuteBot_1")]._id_E0E1C48A5393D3D1, 0.8, "execution_000", ::_id_687173E2CE46615F);
  level.player _id_3FB16506404E5493::_id_7004AD4F3793CEDB("orientation_match_execution_sequence");
}

_id_687173E2CE46615F() {
  level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_57D6A00F90C8C77E);
}

_id_20E6C27A91C3ACCD() {
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_show_pad_prompt_start");
  _id_4D32AAA310660A55 = level.player usinggamepad();

  if(!_id_4D32AAA310660A55 || getdvarint("dvar_585200EDDAEBFA78", 1) == 0) {
    return;
  }
  level.player freezecontrols(1);
  _id_E9444163EE17C4AC = level._id_DBF4D97004E64BD5._id_744254A0A817FF39;
  _id_E9444163EE17C4AC.sound = 0;
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("noControllerPopupTip", _id_E9444163EE17C4AC);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("moveCameraTip");
  level.player _id_52EED65F3AF6AF91::_id_36939D27AE6DF257(::_id_76E49C16322EFA47);
  scripts\engine\utility::flag_init("ftue_player_no_controller_popup");
  scripts\engine\utility::flag_wait("ftue_player_no_controller_popup");
  level.player freezecontrols(0);
  level.player _id_3FB16506404E5493::_id_42716045CDD993D1("orientation_match_pad_prompt_was_shown");
}

_id_76E49C16322EFA47(_id_C550577B692B6C54) {
  if(isDefined(_id_C550577B692B6C54))
    scripts\engine\utility::flag_set("ftue_player_no_controller_popup");
}

_id_49CAB10CAAC7C6CD() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("moveCameraTip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("moveCameraTip");
  level.player allowmovement(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player _id_6B1017606BBE1A47::_id_105BD25B72F6EA55(level._id_DBF4D97004E64BD5._id_49CAB10CAAC7C6CD._id_D9B20FB7B6B1CEED);
  level.player allowmovement(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("moveCameraTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_4D9206A74ADB396E() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("walkTip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("walkTip");
  level.player _id_6B1017606BBE1A47::_id_33749FEFAB503510(level._id_DBF4D97004E64BD5._id_4D9206A74ADB396E._id_2975304AA952EDEF);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("walkTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_B5799765F0103E33() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("moveCameraWalkTip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("moveCameraWalkTip");
  level.player _id_6B1017606BBE1A47::_id_4F94F7B207E54B3F(level._id_DBF4D97004E64BD5._id_B5799765F0103E33._id_B4651E34AE901B3E, level._id_DBF4D97004E64BD5._id_B5799765F0103E33._id_D9B20FB7B6B1CEED);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("moveCameraWalkTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_91B5B282CB2B18FC(_id_C96B95F99B74B4AB) {
  _id_025261199A27252E = scripts\engine\utility::drop_to_ground((level._id_DBF4D97004E64BD5._id_025261199A27252E._id_E4B7E99A96C8829F[_id_C96B95F99B74B4AB][0], level._id_DBF4D97004E64BD5._id_025261199A27252E._id_E4B7E99A96C8829F[_id_C96B95F99B74B4AB][1], level._id_DBF4D97004E64BD5._id_025261199A27252E._id_E4B7E99A96C8829F[_id_C96B95F99B74B4AB][2] + 50), level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_329C3AC67930D855);
  _id_5C9E22AE1EC6CB1B = undefined;
  _id_34E326B47A846F0B = "moveToPositionDefaultTip";
  objectivetext = &"FTUE_MOBILE/MOVE_TO_POSITION_OBJ";

  switch (_id_C96B95F99B74B4AB) {
    case 0:
      _id_34E326B47A846F0B = "walkTip";

      if(isDefined(level._id_3896BF00E9C5CA00)) {
        level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
        level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("MOVE_TO_STEP", 0.8);
        level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents.moving);
      }

      break;
    case 1:
      _id_34E326B47A846F0B = "moveToPosition2Tip";

      if(isDefined(level._id_3896BF00E9C5CA00)) {
        level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
        level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("ADS_STEP");
        level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_6FE4C889DDE2FECF);
      }

      break;
    case 2:
      _id_34E326B47A846F0B = "moveToPosition3Tip";
      break;
    case 3:
      _id_34E326B47A846F0B = "moveToPosition4Tip";
      objectivetext = &"FTUE_MOBILE/REACH_EXTRACTION_POINT_OBJ";

      if(isDefined(level._id_3896BF00E9C5CA00)) {
        level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
        level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("EXTRACTION_STEP");
        level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_2E6DA450104BDA0C);
      }

      break;
    default:
      break;
  }

  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9(_id_34E326B47A846F0B);
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E(_id_34E326B47A846F0B, level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  _id_5C9E22AE1EC6CB1B = _id_695A872D7D692EFA::_id_E5524FB8509827BF(_id_025261199A27252E, objectivetext, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C.objectiveicon, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_F87CEAC8AB1123D1);
  _id_8D126083C75ADBE6 = _id_695A872D7D692EFA::_id_784459B6FA2274CC(level.player, _id_025261199A27252E, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_3F64F8F90ECC06C7, 1.8);
  _id_695A872D7D692EFA::_id_F36E91AA37D197C3(_id_5C9E22AE1EC6CB1B, _id_8D126083C75ADBE6);
  level.player _id_6B1017606BBE1A47::_id_87682C85D41C2E13(level._id_DBF4D97004E64BD5._id_025261199A27252E._id_E4B7E99A96C8829F[_id_C96B95F99B74B4AB], level._id_DBF4D97004E64BD5._id_75E74A5148C1D441);
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(_id_5C9E22AE1EC6CB1B);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(_id_34E326B47A846F0B, 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_931DC024B9A4425D() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("pickUpWeapon1Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("pickUpWeapon1Tip");

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("TAKE_WEAPON_STEP");
  }

  _id_E46130A1F1555462 = level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_0D651012A7700B7E;

  if(!isDefined(level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_F04017EEB74341EF)) {
    weaponname = level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_C2E05BD1D324F3D3;
    weaponattachments = level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_3E64B0476403507A;
    _id_9CBCD63169EBE6B9 = level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_ED077719222AD193;
    level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_F04017EEB74341EF = _id_0A947BE31E190E16::_id_E6019A2D874F8C36(weaponname, weaponattachments, _id_E46130A1F1555462, _id_9CBCD63169EBE6B9);
  }

  _id_D7F262D1696EA41A = _id_695A872D7D692EFA::_id_E5524FB8509827BF(_id_E46130A1F1555462, &"FTUE_MOBILE/MOVE_TO_POSITION_OBJ", level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C.objectiveicon, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_F87CEAC8AB1123D1);
  _id_8D126083C75ADBE6 = _id_695A872D7D692EFA::_id_784459B6FA2274CC(level.player, _id_E46130A1F1555462 + level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_138210DEE3953A98, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_9DD6024D6A47F168, 1.8);
  _id_695A872D7D692EFA::_id_F36E91AA37D197C3(_id_D7F262D1696EA41A, _id_8D126083C75ADBE6);
  thread _id_695A872D7D692EFA::_id_CE25EC56EF58C5CC(_id_D7F262D1696EA41A, level.player, level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_62A3B08574578B5C);
  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_D741791913407FC6);

  while(!level.player _id_67E2C9BD89ED9289::_id_B69898678ED4466D(_id_E46130A1F1555462, level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_D2D2C2EFECA7F10D, level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_62A3B08574578B5C))
    wait 0.5;

  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(_id_D7F262D1696EA41A);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("pickUpWeapon1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_6C00D659B72888BF() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("pickUpWeapon2Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("pickUpWeapon2Tip");

  while(isDefined(level._id_DBF4D97004E64BD5._id_6C00D659B72888BF._id_F04017EEB74341EF))
    waitframe();

  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("pickUpWeapon2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  waittime = level.player playviewmodelanim("vm_ar_mike4_inspect_generic");
}

_id_E919B21AF04165A2() {
  level notify("ftue_weapon_picked_up");
}

_id_4B422FDC1B596EF9() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("pickUpAmmoTip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("pickUpAmmoTip");

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("TAKE_AMMO_STEP_1", undefined, undefined, ::_id_B157F7093578C486);
  }

  _id_8B46CAE7D035A67C = level._id_DBF4D97004E64BD5._id_4B422FDC1B596EF9._id_8B46CAE7D035A67C;
  _id_C9F65801A0258B90 = level._id_DBF4D97004E64BD5._id_4B422FDC1B596EF9._id_BDDB37F38F87A338;

  if(!isDefined(_id_8B46CAE7D035A67C))
    _id_8B46CAE7D035A67C = _id_0A947BE31E190E16::_id_40F588E8C075F3A1(_id_C9F65801A0258B90);

  _id_8B46CAE7D035A67C disablescriptableplayeruse(level.player);
  _id_CDFE671B1F557F44 = _id_695A872D7D692EFA::_id_E5524FB8509827BF(_id_C9F65801A0258B90, &"FTUE_MOBILE/PICK_UP_AMMO_OBJ", level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C.objectiveicon, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_F87CEAC8AB1123D1);
  _id_8D126083C75ADBE6 = _id_695A872D7D692EFA::_id_784459B6FA2274CC(level.player, _id_C9F65801A0258B90, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_9DD6024D6A47F168, 1.8);
  _id_695A872D7D692EFA::_id_F36E91AA37D197C3(_id_CDFE671B1F557F44, _id_8D126083C75ADBE6);
  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_C5FEB537B8EBFE54);
  _id_8B46CAE7D035A67C enablescriptableplayeruse(level.player);

  while(isDefined(_id_8B46CAE7D035A67C))
    waitframe();

  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(_id_CDFE671B1F557F44);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("pickUpAmmoTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_B157F7093578C486() {
  level._id_3896BF00E9C5CA00._id_BC97ABF5A86E403F = 0;
  level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("TAKE_AMMO_STEP_2", 0.3);
  level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_9CD34CBD05A34BF2(level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")]._id_E5C38BE28345C687["TAKE_AMMO_STEP_2"][1]);
}

_id_EE69C387D92C4B38() {
  level.player freezecontrols(1);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("autoFirePopupTip");
  _id_E9444163EE17C4AC = level._id_DBF4D97004E64BD5._id_744254A0A817FF39;
  _id_E9444163EE17C4AC.sound = 0;
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("autoFirePopupTip", _id_E9444163EE17C4AC);
  level.player _id_52EED65F3AF6AF91::_id_36939D27AE6DF257(::_id_974735AD95DE2EBF);
  level.player _id_4585999B9BC82F8F::_id_AE00F22F048A1F57("uin_choosefiremode_appearance");
  scripts\engine\utility::flag_init("ftue_player_autofire_popup");
  scripts\engine\utility::flag_wait("ftue_player_autofire_popup");
  level.player freezecontrols(0);
}

_id_974735AD95DE2EBF(_id_C550577B692B6C54) {
  if(isDefined(_id_C550577B692B6C54))
    scripts\engine\utility::flag_set("ftue_player_autofire_popup");
}

_id_B6001EA887635DE4(_id_DED14AE1EA8C4446) {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("killAutoShootTip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player allowfire(1);
  level.player thread _id_23A85A6F3340BF6F::_id_A074C3F0D66BA8E0();
  level.player _meth_E4A38A7C9732F011("autoFireTouch", 0);

  foreach(_id_D1BFF7E80776F894 in _id_DED14AE1EA8C4446)
  thread _id_669A0D5052376C2C::_id_931679C28A759F96(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)], "shooting");

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    wait 0.5;
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("AUTO_FIRE_STEP");
    level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_18B9D1D9954DCC62);
  }

  _id_78DAC680A1677E7C::_id_FE4AEFEBD9992D47(_id_DED14AE1EA8C4446, 1, undefined);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("killAutoShootTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_722BE554926B1CC0);
}

_id_F438DE09FA371CFA() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("reloadTip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("reloadTip");
  level.player notify("clip_limited");
  level.player disableautoreload();

  while(level._id_DBF4D97004E64BD5._id_F438DE09FA371CFA.needtoreload) {
    if(level.player isreloading())
      level._id_DBF4D97004E64BD5._id_F438DE09FA371CFA.needtoreload = 0;

    waitframe();
  }

  level.player enableautoreload();
  level.player _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_02840D4402B27DD0);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("reloadTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_8AB6A96B2278D5CF() {
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("armorUp1Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("armorUp1Tip");

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("TAKE_ARMOR_STEP");
  }

  _id_F838308C6674637E = level._id_DBF4D97004E64BD5._id_4084605D5216BC12._id_C9746086DBDD302D[0];
  _id_F838318C667465B1 = level._id_DBF4D97004E64BD5._id_4084605D5216BC12._id_C9746086DBDD302D[1];
  _id_F1E0FDAE661FA0AB = scripts\engine\utility::drop_to_ground((_id_F838308C6674637E, _id_F838318C667465B1, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_329C3AC67930D855));
  _id_3F00185D759781C0 = _id_695A872D7D692EFA::_id_E5524FB8509827BF(_id_F1E0FDAE661FA0AB + level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_B4CF16890B8820ED, &"FTUE_MOBILE/MOVE_TO_POSITION_OBJ", level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C.objectiveicon, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_F87CEAC8AB1123D1);
  _id_8D126083C75ADBE6 = _id_695A872D7D692EFA::_id_784459B6FA2274CC(level.player, _id_F1E0FDAE661FA0AB, level._id_DBF4D97004E64BD5._id_3C5EF1ED040AF91C._id_9DD6024D6A47F168, 1.8);
  _id_695A872D7D692EFA::_id_F36E91AA37D197C3(_id_3F00185D759781C0, _id_8D126083C75ADBE6);
  _id_3D42898277F45F44 = _id_60F11E2541FC10C7::_id_CDF4890B38273393(level.player, _id_F1E0FDAE661FA0AB, ::_id_ECE067E4F23075CF);
  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_EA9CF1FAE9D99AE1);

  while(isDefined(_id_3D42898277F45F44))
    waitframe();

  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(_id_3F00185D759781C0);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("armorUp1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("armorUp2Tip");
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("armorUp2Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  _id_60F11E2541FC10C7::_id_D92343BE83930B25(level.player, ::_id_A6C9D2E9BB210C22);
  level waittill("ftue_armor_plate_equipped");
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("armorUp2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_ECE067E4F23075CF() {
  level notify("ftue_armor_plate_picked");
}

_id_A6C9D2E9BB210C22() {
  level notify("ftue_armor_plate_equipped");
}

_id_ED36379DA3790CBA() {
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("adsAndAutoShoot1Tip");
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("adsAndAutoShoot1Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_DE620A47B8947E6A);
  level.player _meth_E4A38A7C9732F011("toggleADSEnabledTouch", 1);

  while(level._id_DBF4D97004E64BD5._id_59575BF55F0D3987._id_88A418AFFB89D5EA) {
    if(level.player adsButtonPressed()) {
      level._id_DBF4D97004E64BD5._id_59575BF55F0D3987._id_88A418AFFB89D5EA = 0;
      level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("adsAndAutoShoot1Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
    }

    waitframe();
  }
}

_id_3DE63BDBD1B3E065(_id_DED14AE1EA8C4446) {
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("adsAndAutoShoot2Tip");
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("adsAndAutoShoot2Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);

  foreach(_id_D1BFF7E80776F894 in _id_DED14AE1EA8C4446)
  thread _id_669A0D5052376C2C::_id_931679C28A759F96(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)], "moving");

  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_07005D00435A3568);

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("ADS_COMBAT_STEP");
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_A7FC1CE7540E5915(_id_DED14AE1EA8C4446);
  }

  _id_78DAC680A1677E7C::_id_FE4AEFEBD9992D47(_id_DED14AE1EA8C4446, 1, undefined);

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("MANUAL_COMBAT_STEP");
    level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_1C8883442EDA0C90);
  }

  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("adsAndAutoShoot2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_7931A9F93D82DD27() {
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("adsAndAutoShoot3Tip");
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("adsAndAutoShoot3Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);

  while(level._id_DBF4D97004E64BD5._id_7931A9F93D82DD27._id_77ED397326EDDF57) {
    if(!level.player adsButtonPressed())
      level._id_DBF4D97004E64BD5._id_7931A9F93D82DD27._id_77ED397326EDDF57 = 0;

    waitframe();
  }

  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("adsAndAutoShoot3Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_463D388FED95C483() {
  level.player freezecontrols(1);
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("manualFirePopupTip");
  _id_E9444163EE17C4AC = level._id_DBF4D97004E64BD5._id_744254A0A817FF39;
  _id_E9444163EE17C4AC.sound = 0;
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("manualFirePopupTip", _id_E9444163EE17C4AC);
  level.player _id_52EED65F3AF6AF91::_id_36939D27AE6DF257(::_id_CBDFD292CBCB65E0);
  level.player _id_4585999B9BC82F8F::_id_AE00F22F048A1F57("uin_choosefiremode_appearance");
  level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_B0251816DC04001B);
  scripts\engine\utility::flag_init("ftue_player_manualfire_popup");
  scripts\engine\utility::flag_wait("ftue_player_manualfire_popup");
  level.player freezecontrols(0);
}

_id_CBDFD292CBCB65E0(_id_C550577B692B6C54) {
  if(isDefined(_id_C550577B692B6C54))
    scripts\engine\utility::flag_set("ftue_player_manualfire_popup");
}

_id_A31A8245682550C1(_id_DED14AE1EA8C4446) {
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("manualShoot2Tip");
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("manualShoot2Tip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);
  level.player _meth_E4A38A7C9732F011("autoFireTouch", 2);

  foreach(_id_D1BFF7E80776F894 in _id_DED14AE1EA8C4446)
  thread _id_669A0D5052376C2C::_id_931679C28A759F96(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)], "shooting");

  level.player _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_07006000435A3C01);

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_A7FC1CE7540E5915(_id_DED14AE1EA8C4446);
  }

  _id_78DAC680A1677E7C::_id_FE4AEFEBD9992D47(_id_DED14AE1EA8C4446, 1, undefined);
  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("manualShoot2Tip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_DE9508D62F36EC59() {
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("chooseFireMode");

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")] _id_669A0D5052376C2C::_id_F5CE7D12B7B279D3("FINAL_COMBAT_STEP");
  }

  level.player freezecontrols(1);
  _id_E9444163EE17C4AC = level._id_DBF4D97004E64BD5._id_744254A0A817FF39;
  _id_E9444163EE17C4AC.sound = 0;
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("chooseFireMode", _id_E9444163EE17C4AC);
  level.player _id_52EED65F3AF6AF91::_id_36939D27AE6DF257(::_id_9DCC1A6D7D189448);
  level.player _id_4585999B9BC82F8F::_id_AE00F22F048A1F57("uin_choosefiremode_appearance");
  scripts\engine\utility::flag_init("ftue_player_choose_fire_mode");
  scripts\engine\utility::flag_wait("ftue_player_choose_fire_mode");
  level.player freezecontrols(0);
}

_id_9DCC1A6D7D189448(_id_C550577B692B6C54) {
  if(isDefined(_id_C550577B692B6C54))
    scripts\engine\utility::flag_set("ftue_player_choose_fire_mode");
}

_id_7F36A1282A73E40F(_id_6D8AD4134B2E2BCE) {
  level.player _id_738ECC23FB96110C::_id_9C8E6A1620EDC3B9("combatTip");
  level.player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("combatTip", level._id_DBF4D97004E64BD5._id_744254A0A817FF39);

  if(isDefined(level._id_3896BF00E9C5CA00)) {
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
    level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_07005F00435A39CE);
  }

  foreach(_id_0D8F27B0D11D1236 in _id_6D8AD4134B2E2BCE) {
    foreach(_id_D1BFF7E80776F894 in _id_0D8F27B0D11D1236) {
      thread _id_669A0D5052376C2C::_id_931679C28A759F96(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)]);
      wait 1;
    }

    if(isDefined(level._id_3896BF00E9C5CA00))
      level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_A7FC1CE7540E5915(_id_0D8F27B0D11D1236);

    _id_78DAC680A1677E7C::_id_FE4AEFEBD9992D47(_id_0D8F27B0D11D1236, 1, undefined);
  }

  if(!_id_A791A878E9049670("heli_destruction"))
    level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("combatTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_E48318BD7516FDE6() {
  _id_1E2E5336470B52B6 = level._id_DBF4D97004E64BD5.vehicles[_func_1823FF50BB28148D("LittleBird_1")]._id_F86FAA8C5CA8BA0C;

  if(isDefined(_id_1E2E5336470B52B6)) {
    _id_59BD0CFDFA271E2D = level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D("FinalCombatBot_5")];
    _id_E37890E45E132EFB = level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D("FinalCombatBot_6")];
    _id_1E2E5336470B52B6 _id_63002651C12F57E3::_id_CB90A442BF4D8100("immuneToPlayer");
    _id_669A0D5052376C2C::_id_931679C28A759F96(_id_59BD0CFDFA271E2D);
    _id_59BD0CFDFA271E2D._id_E0E1C48A5393D3D1 usevehicle(_id_1E2E5336470B52B6, 1, 1);
    _id_669A0D5052376C2C::_id_931679C28A759F96(_id_E37890E45E132EFB);
    _id_E37890E45E132EFB._id_E0E1C48A5393D3D1 usevehicle(_id_1E2E5336470B52B6, 2, 1);
    _id_E37890E45E132EFB._id_E0E1C48A5393D3D1 thread _id_23A85A6F3340BF6F::_id_A074C3F0D66BA8E0();
    _id_E37890E45E132EFB._id_E0E1C48A5393D3D1 _id_669A0D5052376C2C::_id_3500675D209F72A2(level.player);
    _id_1E2E5336470B52B6 _id_63002651C12F57E3::_id_0944743524ECAEA3(level._id_DBF4D97004E64BD5._id_9004C82EA70421BC._id_1FF1FA846AAF925E, 100, 125, -170, (1, 1, 1));

    if(isDefined(level._id_3896BF00E9C5CA00)) {
      level._id_3896BF00E9C5CA00 _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents._id_584F532EEFA02962);
      level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_E333732833F72059("stand");
      level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_3A31862196D98146("attack");
      level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_DEAFDBA8D60E4C3B(_id_1E2E5336470B52B6, level._id_DBF4D97004E64BD5._id_395082021DFC3AE9[_func_1823FF50BB28148D("AllyBot_1")]._id_E5C38BE28345C687["RPG_STEP"][0], (0, 0, -30), ::_id_5399588FFB3350B9);
      level scripts\engine\utility::waittill_notify_or_timeout("destruction_sequence_completed", 20);
    }
  }

  level.player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20("combatTip", 1, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);
}

_id_5399588FFB3350B9(_id_1E2E5336470B52B6) {
  _id_1E2E5336470B52B6 _id_63002651C12F57E3::_id_11CC5DBD12CB9F9E(level._id_DBF4D97004E64BD5._id_9004C82EA70421BC._id_DB99277A1168408F, 40);
  level.player _id_4585999B9BC82F8F::_id_CDA6B5416805C105(level._id_DBF4D97004E64BD5.soundevents.heli_destroyed);
  level notify("destruction_sequence_completed");
  level waittill("vehicle_crashDone");
  _id_59BD0CFDFA271E2D = level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D("FinalCombatBot_5")]._id_E0E1C48A5393D3D1;
  _id_E37890E45E132EFB = level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D("FinalCombatBot_6")]._id_E0E1C48A5393D3D1;
  _id_59BD0CFDFA271E2D _id_669A0D5052376C2C::_id_553FB9972F5FCE8A();
  _id_E37890E45E132EFB _id_669A0D5052376C2C::_id_553FB9972F5FCE8A();
  _id_59BD0CFDFA271E2D._id_56ACA941817E8E68 = 0;
  _id_E37890E45E132EFB._id_56ACA941817E8E68 = 0;
  _id_59BD0CFDFA271E2D dodamage(1000, _id_59BD0CFDFA271E2D.origin, level._id_3896BF00E9C5CA00, undefined, "MOD_EXPLOSIVE");
  _id_E37890E45E132EFB dodamage(1000, _id_E37890E45E132EFB.origin, level._id_3896BF00E9C5CA00, undefined, "MOD_EXPLOSIVE");
}

_id_AB5AB2886323A8A5() {
  if(isDefined(level._id_3896BF00E9C5CA00))
    level._id_3896BF00E9C5CA00 _id_669A0D5052376C2C::_id_390C90207BAC8552();

  level._id_6F626F29FFD28538._id_D0BAA670C4FCF6FF = 1;

  if(getdvarint("dvar_521FD4CA05C98FE5", 0) == 0)
    level.player _id_5C61825C1DCE3571::_id_E05669C955312C22(2, 1);

  level.player _id_3FB16506404E5493::_id_9C335ACC44971F71();
  _id_72A1BB2FB20CBDBA::_id_422C480D1E41BFF2();
}

_id_F68E1A166600BCDF(_id_CF60A913480C34E2) {
  if(isDefined(level._id_DBF4D97004E64BD5._id_B5F719818090A874[_id_CF60A913480C34E2]))
    level._id_DBF4D97004E64BD5._id_B5F719818090A874[_id_CF60A913480C34E2].wall = _id_78DAC680A1677E7C::_id_E27C8EAD6AB015FA([level._id_DBF4D97004E64BD5._id_B5F719818090A874[_id_CF60A913480C34E2].data]);
}

_id_EC363F75C60D5900(_id_CF60A913480C34E2) {
  if(isDefined(level._id_DBF4D97004E64BD5._id_B5F719818090A874[_id_CF60A913480C34E2].wall))
    _id_78DAC680A1677E7C::_id_8EC6FF395F428891(level._id_DBF4D97004E64BD5._id_B5F719818090A874[_id_CF60A913480C34E2].wall);
}

_id_FE5ABC4FB25C1701(_id_BDB110A067C516C3) {
  if(isDefined(_id_BDB110A067C516C3.function) && _id_A791A878E9049670(_id_BDB110A067C516C3.id)) {
    level._id_6F626F29FFD28538._id_5F5F6FB97E94AC59 = 1;

    if(isDefined(_id_BDB110A067C516C3.param))
      [[_id_BDB110A067C516C3.function]](_id_BDB110A067C516C3.param);
    else
      [[_id_BDB110A067C516C3.function]]();

    level._id_6F626F29FFD28538._id_5F5F6FB97E94AC59 = 0;
  }

  level._id_6F626F29FFD28538._id_E950DFDD6E1577DC++;
}

_id_C699558663F2308A(_id_5ACBEA480D34F416, _id_B0F0026F732DD7F1, _id_3DBB8FD808F67B78) {
  _id_BDB110A067C516C3 = spawnStruct();
  _id_BDB110A067C516C3.id = _id_5ACBEA480D34F416;
  _id_BDB110A067C516C3.function = _id_B0F0026F732DD7F1;

  if(isDefined(_id_3DBB8FD808F67B78))
    _id_BDB110A067C516C3.param = _id_3DBB8FD808F67B78;

  level._id_6F626F29FFD28538._id_63F445469B886BF8 = scripts\engine\utility::array_add(level._id_6F626F29FFD28538._id_63F445469B886BF8, _id_BDB110A067C516C3);
}

_id_7CD3D20E755EC81D(_id_5ACBEA480D34F416, _id_22BC00C6B9C5D4EA, _id_EF53D8FDAC5647F5, _id_9A561299BAE38294) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_6F626F29FFD28538._id_63F445469B886BF8.size; _id_AC0E594AC96AA3A8++) {
    if(level._id_6F626F29FFD28538._id_63F445469B886BF8[_id_AC0E594AC96AA3A8].id == _id_5ACBEA480D34F416) {
      _id_BDB110A067C516C3 = spawnStruct();
      _id_BDB110A067C516C3.id = _id_22BC00C6B9C5D4EA;
      _id_BDB110A067C516C3.function = _id_EF53D8FDAC5647F5;
      _id_BDB110A067C516C3._id_554EDA1E779CD2B1 = 1;

      if(isDefined(_id_9A561299BAE38294))
        _id_BDB110A067C516C3.param = _id_9A561299BAE38294;

      level._id_6F626F29FFD28538._id_63F445469B886BF8[_id_AC0E594AC96AA3A8] = _id_BDB110A067C516C3;
      return 1;
    }
  }

  return 0;
}

_id_A791A878E9049670(_id_5ACBEA480D34F416) {
  foreach(_id_D0DE0DB1760B9C5B in level._id_6F626F29FFD28538._id_63F445469B886BF8) {
    if(_id_D0DE0DB1760B9C5B.id == _id_5ACBEA480D34F416 && !issubstr(getDvar("dvar_7C6EBE8894CF9EBF", ""), _id_5ACBEA480D34F416))
      return 1;
  }

  return 0;
}
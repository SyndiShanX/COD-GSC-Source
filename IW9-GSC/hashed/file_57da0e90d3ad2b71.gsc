/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_57da0e90d3ad2b71.gsc
***********************************************/

_id_8777165F2FD37CE1() {
  level._id_A7B62649C81B481A = spawnStruct();
  _id_ABECAC26BD74617D();
  _id_D950377D5BC98232();
  level._id_F8A8D9BD63AC2A8B = getdvarint("dvar_36ED1AE689796120", 1) == 1;
  level._id_A7B62649C81B481A._id_9554040D20610E7D = getdvarint("dvar_0B8CAC4389DECD22", 1);
  level._id_A7B62649C81B481A._id_ACC161DE36707DE2 = level._id_A7B62649C81B481A._id_9554040D20610E7D;
  level thread _id_33E114011647AFBB();
  level thread _id_6339D2EDD7254086();
  level._id_823F06A812B13FC2 = getentitylessscriptablearray("beacon_light", "targetname");
  level._id_AB76F8B53752861C = getentitylessscriptablearray("lpcon_screen", "targetname");
  level._id_0A354453B64103B7 = getentitylessscriptablearray("leak_pipe", "targetname");
  level._id_AD62A3AA57453A5E = getentitylessscriptablearray("high_security_light", "targetname");
  level thread _id_AD3D47857B816FCE();
}

_id_F8B541AF9E1D21B8(totaltime) {
  timelimit = totaltime;
  _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
  level.watchdvars[_id_B2FF82EC901486E4].value = timelimit;
  level.overridewatchdvars[_id_B2FF82EC901486E4] = timelimit;
}

_id_ABECAC26BD74617D() {
  level._id_A7B62649C81B481A._id_546B4B92426D200E = [];
  level._id_A7B62649C81B481A._id_546B4B92426D200E[0] = undefined;
  level._id_A7B62649C81B481A._id_546B4B92426D200E[1] = undefined;
  level._id_A7B62649C81B481A._id_546B4B92426D200E[2] = "br_dmz_bio_labs_lpcon_bravo";
  level._id_A7B62649C81B481A._id_546B4B92426D200E[3] = "br_dmz_bio_labs_lpcon_charlie";
  level._id_A7B62649C81B481A._id_546B4B92426D200E[4] = "br_dmz_bio_labs_lpcon_delta";
  level._id_A7B62649C81B481A._id_546B4B92426D200E[5] = "br_dmz_bio_labs_lpcon_echo";
}

_id_D950377D5BC98232() {
  _id_FB118536C3769A37 = getdvarint("dvar_1309865C26C09D3C", 0);
  _id_9120F0776E3FD546 = getdvarint("dvar_353A94B18E77095D", 60);
  _id_A2A96B8EE97427A6 = getdvarint("dvar_0F20F51622DBD3BD", 120);
  _id_CE4B15ABB51009A4 = getdvarint("dvar_346FAE774AD5587F", 360);
  _id_56DDE920C84C7B04 = getdvarint("dvar_91332E91F9E9CE23", 300);
  _id_3FA8F4D6A91146A9 = getdvarint("dvar_5627CCE29F31F2E2", 180);

  if(_id_9120F0776E3FD546 > 60)
    _id_9120F0776E3FD546 = 60;

  _id_EF8B7888B41BA951 = 68;

  if(_id_A2A96B8EE97427A6 < _id_EF8B7888B41BA951)
    _id_A2A96B8EE97427A6 = _id_EF8B7888B41BA951;

  totaltime = _id_A2A96B8EE97427A6 + _id_CE4B15ABB51009A4 + _id_56DDE920C84C7B04;
  _id_F8B541AF9E1D21B8(totaltime);
  level._id_A7B62649C81B481A._id_6C28286E5A71C7CC = [];
  level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[0] = _id_FB118536C3769A37;
  level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[1] = _id_9120F0776E3FD546;
  level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[2] = _id_A2A96B8EE97427A6;
  level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[3] = _id_CE4B15ABB51009A4;
  level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[4] = _id_56DDE920C84C7B04;
  level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[5] = _id_3FA8F4D6A91146A9;
}

_id_33E114011647AFBB() {
  level endon("game_ended");
  level._id_A7B62649C81B481A._id_F641C9A64F857258 = [];

  foreach(timer in level._id_A7B62649C81B481A._id_6C28286E5A71C7CC) {
    level._id_A7B62649C81B481A._id_F641C9A64F857258[level._id_A7B62649C81B481A._id_F641C9A64F857258.size] = spawnStruct();
    level._id_A7B62649C81B481A._id_F641C9A64F857258[level._id_A7B62649C81B481A._id_F641C9A64F857258.size - 1].timer = timer;
  }

  level thread _id_498BDD216B119D58();
  _id_E21E2347FD06A5C9();
  level thread _id_53E2724BD8092C64();
}

_id_498BDD216B119D58() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  _id_CEC6BD703DD33CB5(level._id_A7B62649C81B481A._id_9554040D20610E7D);

  if(!isDefined(level._id_A7B62649C81B481A._id_F641C9A64F857258)) {
    return;
  }
  _id_90FB431C1E7E1B5C = 0;

  while(level._id_A7B62649C81B481A._id_ACC161DE36707DE2 < 5) {
    if(level._id_A7B62649C81B481A._id_ACC161DE36707DE2 == 1)
      _id_90FB431C1E7E1B5C = gettime();

    if(level._id_A7B62649C81B481A._id_ACC161DE36707DE2 == 2) {
      _id_69723D6DCECDBCA2 = (gettime() - _id_90FB431C1E7E1B5C) / 1000;
      _id_A2A96B8EE97427A6 = level._id_A7B62649C81B481A._id_F641C9A64F857258[2].timer;
      _id_A2A96B8EE97427A6 = _id_A2A96B8EE97427A6 - _id_69723D6DCECDBCA2;
      level._id_A7B62649C81B481A._id_F641C9A64F857258[2].timer = _id_A2A96B8EE97427A6;
    }

    timer = level._id_A7B62649C81B481A._id_F641C9A64F857258[level._id_A7B62649C81B481A._id_ACC161DE36707DE2].timer;
    msg = scripts\engine\utility::waittill_any_timeout_1(timer, "lpcon_current_alert_level_updated");

    if(msg == "timeout") {
      alertlevel = level._id_A7B62649C81B481A._id_ACC161DE36707DE2 + 1;
      _id_CEC6BD703DD33CB5(alertlevel);
    }
  }
}

_id_1FBD2B236DC12930() {
  agentskilled = 0;
  _id_9C02E895E4DBDC3B = "-1";

  if(isDefined(level._id_A7B62649C81B481A) && isDefined(level._id_A7B62649C81B481A._id_ACC161DE36707DE2))
    _id_9C02E895E4DBDC3B = scripts\engine\utility::string(level._id_A7B62649C81B481A._id_ACC161DE36707DE2);

  _id_E067C78D41A11DEC = [];

  foreach(player in level.players) {
    if(scripts\cp_mp\utility\player_utility::isreallyalive(player) && !istrue(player.extracted))
      _id_E067C78D41A11DEC[player.team] = 1;

    if(isDefined(player.pers["telemetry"]._id_44E6F7522AE08173))
      agentskilled = agentskilled + player.pers["telemetry"]._id_44E6F7522AE08173;
  }

  timeelapsed = scripts\mp\utility\game::getsecondspassed();
  data = spawnStruct();
  data._id_9C02E895E4DBDC3B = _id_9C02E895E4DBDC3B;
  data._id_C983D3ABB7EC13D9 = int(timeelapsed);
  data.agentskilled = agentskilled;
  data._id_75A8EB8AF196B837 = _id_E067C78D41A11DEC.size;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_dmz_on_lpcon_alert", data);
}

_id_F0D6A3727EB0F125(event) {
  _id_D0D885B682472AE4 = ["ally_damaged", "ally_hurt_peripheral", "ally_killed", "attack", "death", "decoy_grenade", "explosion", "glass_destroyed", "grenade danger", "grenade_ping", "gunshot", "gunshot_impact", "gunshot_teammate", "pain", "projectile_impact", "silenced_shot_impact", "throwingknife_impact"];

  if(scripts\engine\utility::array_contains(_id_D0D885B682472AE4, event.type)) {
    if(level._id_A7B62649C81B481A._id_ACC161DE36707DE2 < 2)
      _id_CEC6BD703DD33CB5(2);
  }

  _id_67015C88C47EC4F8::_id_DF0FE5AC51164868(event);
}

_id_DD82A92C1A172BB8(smeansofdeath) {
  if(level._id_A7B62649C81B481A._id_ACC161DE36707DE2 < 2)
    _id_CEC6BD703DD33CB5(2);

  return 1;
}

_id_E21E2347FD06A5C9() {
  level._id_01A6C1600565C49A = ::_id_F0D6A3727EB0F125;
  level.onplayerdamaged_func = ::_id_DD82A92C1A172BB8;
}

_id_53E2724BD8092C64() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  _id_A2A96B8EE97427A6 = level._id_A7B62649C81B481A._id_F641C9A64F857258[2].timer;
  _id_EF8B7888B41BA951 = 68;
  wait(_id_A2A96B8EE97427A6 - _id_EF8B7888B41BA951);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_entry_hack_in_progress", level.players);
  _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53("bio_lab_locks_hack_ongoing");
  wait 60;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_entry_hack_hacked", level.players);
  _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53("bio_lab_locks_hack_complete");
}

_id_CEC6BD703DD33CB5(alertlevel) {
  if(alertlevel > 5 || alertlevel < 0) {
    return;
  }
  level._id_A7B62649C81B481A._id_ACC161DE36707DE2 = alertlevel;
  level notify("lpcon_current_alert_level_updated", alertlevel);
  _id_6A8EC730B2BFA844::_id_22024087C0855CDE();
}

_id_4B83F0DA5C534111() {
  return level._id_A7B62649C81B481A._id_ACC161DE36707DE2;
}

_id_F4995A51416BE83E() {
  foreach(_id_77EA0C09D9F5AA59 in level._id_AD62A3AA57453A5E)
  _id_77EA0C09D9F5AA59 setscriptablepartstate("light", "Light_Off", 0);
}

_id_357F50E94BD56EC6() {
  level endon("game_ended");
  _id_52C4C7423DA6A533 = level._id_F2A8E4A4AF870513;
  _id_B94EB495411123FE = level._id_029CED2D4D9A0BDE;
  _id_BAA148BC6CA44798 = 0;

  while(_id_52C4C7423DA6A533.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_52C4C7423DA6A533.size; _id_AC0E594AC96AA3A8++) {
      area = _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8];
      _id_AEF83E0182D8E814 = _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8] == "lv3_armory_room";
      _id_F33355848EB28BFD = _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8] == "lv1_generator_room";

      foreach(player in level.players) {
        if(isalive(player) && player istouching(_id_B94EB495411123FE[area])) {
          _id_BAA148BC6CA44798 = 1;
          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_" + _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8] + "_under_attack", level.players);
          _id_0898C4DFD33F16EB = _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8];
          _id_CB3339ECE72DBDEB = "bio_lab_" + _id_0898C4DFD33F16EB + "_vo";

          if(_id_AEF83E0182D8E814)
            _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53(_id_CB3339ECE72DBDEB);
          else {
            level thread _id_3707F44961816B2F::_id_0E1CA44858CD8EA1(_id_CB3339ECE72DBDEB);
            player _id_3707F44961816B2F::_id_D50D0A086958E440("stat_6BC346A4E4CEEC9C", "doorsUnlocked");
          }

          _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8] = undefined;
          break;
        }
      }
    }

    if(istrue(_id_BAA148BC6CA44798)) {
      _id_52C4C7423DA6A533 = scripts\engine\utility::array_removeundefined(_id_52C4C7423DA6A533);
      _id_34901859711436C9 = 0;
    }

    waitframe();
  }
}

_id_6339D2EDD7254086() {
  level endon("game_ended");

  for(;;) {
    level waittill("lpcon_current_alert_level_updated", alertlevel);
    _id_1FBD2B236DC12930();
    _id_BC611FF28EE75E4F(alertlevel);
    _id_BC1A2CF28E98B876(alertlevel);
    _id_5D39EC7BAABB5C7E(alertlevel);
    level thread _id_D09976A83FC2A1B2(alertlevel);
    _id_3039AB0E70B3AD06(alertlevel);
  }
}

_id_772FBBD72E871F8A() {
  level endon("game_ended");
  guys = getaiarray();

  foreach(guy in guys) {
    if(isalive(guy) && isDefined(guy._id_E31EE88092E41CC8))
      guy._id_E31EE88092E41CC8 = 1;
  }
}

_id_3039AB0E70B3AD06(alertlevel) {
  if(alertlevel >= 2)
    level thread _id_772FBBD72E871F8A();

  if(alertlevel >= 3 && !istrue(level._id_72CAC51196C2C39F)) {
    level._id_72CAC51196C2C39F = 1;
    _id_9069EE279D9AB053();
    level thread _id_357F50E94BD56EC6();
  }

  if(alertlevel == 5) {
    level thread _id_0DDA586D27C1CEBE::_id_A01F654E559EE5EC();

    if(getdvarint("dvar_96DFF7E19D1A47F6", 0) == 1)
      level thread _id_7E32C4283965A098::_id_1D78E37DA1598763();
  }
}

_id_D09976A83FC2A1B2(alertlevel) {
  level endon("game_ended");
  level notify("show_lpcon_splash");
  level endon("show_lpcon_splash");

  switch (alertlevel) {
    case 2:
      _id_5688A7BF1277BB6D(alertlevel);
      break;
    case 3:
      _id_5688A7BF1277BB6D(alertlevel);
      break;
    case 4:
      _id_5688A7BF1277BB6D(alertlevel);
      break;
    case 5:
      _id_5688A7BF1277BB6D(alertlevel);
      wait 5;
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_radiation_spreading", level.players);
      level thread _id_87E1CC3B6A071D1D();
      break;
    default:
      break;
  }
}

_id_5688A7BF1277BB6D(alertlevel) {
  if(isDefined(level._id_A7B62649C81B481A._id_546B4B92426D200E[alertlevel]))
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(level._id_A7B62649C81B481A._id_546B4B92426D200E[alertlevel], level.players);
}

_id_BC611FF28EE75E4F(alertlevel) {
  state = undefined;

  switch (alertlevel) {
    case 2:
      state = "blue_transition";
      break;
    case 3:
      state = "yellow_transition";
      break;
    case 4:
      state = "red_transition";
      break;
    case 5:
      state = "red_rotate";
      break;
    default:
      break;
  }

  foreach(_id_4E468EB1A25D1345 in level._id_823F06A812B13FC2) {
    if(isDefined(state))
      _id_4E468EB1A25D1345 setscriptablepartstate("becon_light", state, 0);
  }
}

_id_BC1A2CF28E98B876(alertlevel) {
  dialog = undefined;

  switch (alertlevel) {
    case 2:
      dialog = "bio_lab_lpcon_brvo_intro";
      break;
    case 3:
      dialog = "bio_lab_lpcon_chrl_intro";
      break;
    case 4:
      dialog = "bio_lab_lpcon_dlta_intro";
      break;
    case 5:
      dialog = "bio_lab_lpcon_echo_intro";
      break;
    default:
      break;
  }

  if(isDefined(dialog))
    level thread _id_3707F44961816B2F::_id_0E1CA44858CD8EA1(dialog, 1);
}

_id_5D39EC7BAABB5C7E(alertlevel) {
  _id_8D69FC2AF2587549(alertlevel);
  level thread _id_E92E15169E103C9C(alertlevel);
}

_id_8D69FC2AF2587549(alertlevel) {
  if(!isDefined(level._id_AB76F8B53752861C)) {
    return;
  }
  foreach(screen in level._id_AB76F8B53752861C) {
    if(screen getscriptablepartstate("main") != "dead") {
      switch (alertlevel) {
        case 2:
          screen setscriptablepartstate("screen", "bravo");
          break;
        case 3:
          screen setscriptablepartstate("screen", "charlie");
          break;
        case 4:
          screen setscriptablepartstate("screen", "delta");
          break;
        case 5:
          screen setscriptablepartstate("screen", "data_wiped");
          break;
        default:
          screen setscriptablepartstate("screen", "init");
          break;
      }
    }
  }
}

_id_E92E15169E103C9C(alertlevel) {
  if(!isDefined(level._id_0A354453B64103B7)) {
    return;
  }
  if(alertlevel == 5) {
    wait 5;

    foreach(_id_3F0B819F2F7B898D in level._id_0A354453B64103B7) {
      _id_3F0B819F2F7B898D setscriptablepartstate("gas", "leak");
      wait(randomfloat(0.1));
    }

    wait 60;

    foreach(_id_3F0B819F2F7B898D in level._id_0A354453B64103B7)
    _id_3F0B819F2F7B898D setscriptablepartstate("gas", "idle");
  }
}

_id_AD3D47857B816FCE() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  _id_5C118165D3E98A42::_id_FA81150E9ADA1F6A(0);
  _id_5C118165D3E98A42::_id_FA81150E9ADA1F6A(1);

  foreach(door in level._id_F64C6EF6F688A407) {
    if(isDefined(door.node.script_noteworthy) && issubstr(door.node.script_noteworthy, "high_security")) {
      if(istrue(door._id_3D9512B73BDC1514)) {
        door scriptabledoorfreeze(1);
        continue;
      }

      _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);
    }
  }

  foreach(door in level._id_F64C6EF6F688A407) {
    if(isDefined(door._id_8F7EDDC9C0864A1B) && issubstr(door._id_8F7EDDC9C0864A1B, "third_floor")) {
      if(istrue(door._id_3D9512B73BDC1514)) {
        door scriptabledoorfreeze(1);
        continue;
      }

      _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);
    }
  }
}

_id_9069EE279D9AB053() {
  foreach(door in level._id_F64C6EF6F688A407) {
    if(isDefined(door._id_8F7EDDC9C0864A1B)) {
      if(issubstr(door._id_8F7EDDC9C0864A1B, "high_security") || issubstr(door._id_8F7EDDC9C0864A1B, "third_floor")) {
        if(level._id_F8A8D9BD63AC2A8B && distancesquared(door.origin, (2082, 3598, 458)) < 10000) {
          door._id_8F7EDDC9C0864A1B = "stuck";
          continue;
        }

        door._id_65513AD5397A67EF = "activity_key_bio_lab";
      }
    }
  }

  _id_6D8966492C1D2D55 = getEntArray("lvl3_lpcon_charlie_col", "targetname");

  foreach(col in _id_6D8966492C1D2D55) {
    if(isDefined(col)) {
      col connectpaths();
      col notsolid();
      col delete();
    }
  }

  _id_F4995A51416BE83E();

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player._id_65513AD5397A67EF = "activity_key_bio_lab";
  }

  _id_5C118165D3E98A42::_id_FA81150E9ADA1F6A(2);
}

_id_87E1CC3B6A071D1D() {
  level endon("game_ended");
  level waittill("pa_dialog_lpcon_echo_intro_end");
  wait 3.0;
  level thread _id_3707F44961816B2F::_id_0E1CA44858CD8EA1("bio_lab_poison_gas");
}
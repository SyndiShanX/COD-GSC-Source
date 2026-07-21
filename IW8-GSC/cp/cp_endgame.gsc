/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_endgame.gsc
***********************************************/

init() {
  thread _id_1252D();
  register_end_game_string_index();
}

_id_1252D() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(isDefined(level._id_127FF)) {
      var_0 setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", level._id_127FF);

      if(isDefined(var_0.pers["_encstr_8AEF05472BC2D6"]) && level.winner == var_0.pers["_encstr_8AEF05472BC2D6"])
        var_1 = get_end_game_string_index("_encstr_91190447C232");
      else
        var_1 = get_end_game_string_index("_encstr_BD79059C51C351");

      var_0 setclientomnvar("_encstr_97B31357D27D9CEDAE73917D2B9B46BEA3B4D1C659", var_1);
    }
  }
}

_id_131AC(var_0) {
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", var_0);
  level._id_127FF = var_0;
}

cargo_truck_mg_explode(var_0) {
  if(isDefined(var_0) && !isDefined(var_0.clientmatchdataid)) {
    var_0.clientmatchdataid = level.initship;
    level.initship++;
  }
}

endgame(var_0, var_1) {
  if(gamealreadyended()) {
    return;
  }
  foreach(var_3 in level.players) {
    if(istrue(var_3 isparachuting()) || istrue(var_3 isskydiving()))
      var_3 skydive_interrupt();

    thread scripts\cp\cp_laststand::hide_all_revive_icons(var_3);
  }

  if(isDefined(level.intel_headicons)) {
    foreach(var_6 in level.intel_headicons) {
      level.intel_headicons = scripts\engine\utility::array_remove(level.intel_headicons, var_6);
      setheadiconimage(var_6);
    }
  }

  if(var_1 == 3) {
    foreach(var_3 in level.players) {
      if(isDefined(level.gametype) && level.gametype == "_encstr_B6570B78A33FB39B3317E886AB") {
        var_9 = game["_encstr_813F06832D8A18FE"]["_encstr_A5640DE6C10BDDDCF507C616E5CA93"].size;
        var_10 = randomint(var_9);
        var_3 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_88490DB11CBEE4BDAEB919D87B37CD"][var_10]);
      } else {
        var_3 setsoundsubmix("_encstr_B2281235B9A105E75D01F22A48BDE7FD1827B983", 2);
        var_3 setplayermusicstate("_encstr_ABFC0E8D7B488FFAFF7F2B27652D82FC");
      }

      var_3 thread deathfx();
    }
  }

  setDvar("_encstr_87D9124B6393AECFD89C54373A5380FD074A1062", "_encstr_B40101");
  setnojiptime(1);
  markgameended();
  level notify("_encstr_9B1D0BC7932875276230426AA1", var_0);
  freezeallplayers(1.0, "_encstr_A11E0A5D8FF1E1519E04D72C", 1);
  var_12 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));

  foreach(var_3 in level.players) {
    if(isDefined(level.gametype)) {
      var_3 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AAAC09D09972B9CC3F2B7F", level.gametype);
      var_3 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AB1904852B68", var_12);
    }
  }

  if(var_1 == 3)
    wait 1;

  var_15 = 0;
  var_16 = "_encstr_B40101";

  if(!scripts\cp\utility::tryingtoleave()) {
    var_16 = "_encstr_BD79058C55D311";

    switch (var_1) {
      case 1:
        var_16 = "_encstr_88E308D7ADF5379F7903";
        scripts\cp\drone\emp_drone::rankedmatchupdates("_encstr_9A8507BA4040188D08");
        break;
      case 4:
        var_16 = "_encstr_9AD50AD030FFC3862B29E831";
        scripts\cp\drone\emp_drone::rankedmatchupdates("_encstr_8E8405EA382B2A");
        break;
      default:
        var_16 = "_encstr_BD79058C55D311";
        scripts\cp\drone\emp_drone::rankedmatchupdates("_encstr_8E8405EA382B2A");
        break;
    }

    if(isDefined(level.pre_map_restart_func))
      [[level.pre_map_restart_func]](var_16);

    scripts\cp\cp_analytics::_id_119B8(var_16);
  }

  setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", scripts\cp\utility::matchmakinggame());
  level.initship = 0;

  foreach(var_3 in level.players) {
    if(!isPlayer(var_3)) {
      continue;
    }
    if(scripts\cp\utility::matchmakinggame() && (var_16 == "_encstr_88E308D7ADF5379F7903" || var_16 == "_encstr_BD79058C55D311"))
      var_3 scripts\cp_mp\utility\game_utility::stopkeyearning(var_16);

    var_18 = get_current_zone(var_3);
    var_19 = var_3 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8E8D0697EB01F243");
    var_20 = var_3 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8FAE0723DEEECDCA19");
    var_21 = var_3 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_B642089B65A658E8F597");
    getentitylessscriptablearray("_encstr_8D941632C6ED9DD7AC9D56DCE8FA8DC123161D16D7567B9D", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_8D990BAE444FC837B53DB05FC9", getbuildnumber(), "_encstr_A9900BF17C56C0B5CB1AD940B2", var_3.name, "_encstr_936B0AB93A0B3AAF1D5EC1AC", "_encstr_8E8D0617EB01F243", "_encstr_A28E061BDE5DB9D1", var_19, "_encstr_A6700C553F53A7133193E808875E", "_encstr_B40101"]);
    getentitylessscriptablearray("_encstr_8D941632C6ED9DD7AC9D56DCE8FA8DC123161D16D7567B9D", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_8D990BAE444FC837B53DB05FC9", getbuildnumber(), "_encstr_A9900BF17C56C0B5CB1AD940B2", var_3.name, "_encstr_936B0AB93A0B3AAF1D5EC1AC", "_encstr_8E5C0C26C26EA3809AA30BDC199B", "_encstr_A28E061BDE5DB9D1", var_20, "_encstr_A6700C553F53A7133193E808875E", "_encstr_B40101"]);
    getentitylessscriptablearray("_encstr_8D941632C6ED9DD7AC9D56DCE8FA8DC123161D16D7567B9D", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_8D990BAE444FC837B53DB05FC9", getbuildnumber(), "_encstr_A9900BF17C56C0B5CB1AD940B2", var_3.name, "_encstr_936B0AB93A0B3AAF1D5EC1AC", "_encstr_B642081B65A658E8F597", "_encstr_A28E061BDE5DB9D1", var_21, "_encstr_A6700C553F53A7133193E808875E", "_encstr_B40101"]);
    cargo_truck_mg_explode(var_3);
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_823C09A2FB0F95E1C4FF41", var_3 getxuidhigh());
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_B12B0878EBE4094C77A7", var_3 getxuidlow());
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_82470DF0B83BAAB09D966F23813C01", var_19);
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_8FCE169139ED073895917D3ADBAFD885CD47F5E61DC2E623", var_20);
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_B15517ADDF2BFBE03D478E41EDEF28A3F27B7F3153E2BB3042", var_21);

    if(isDefined(var_3.pers["_encstr_A51F05CB11A052"]) && scripts\cp\utility::matchmakinggame()) {
      var_22 = var_3 scripts\cp\drone\emp_drone::getrank();
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_A51F05CB11A052", var_22);
    }

    if(isDefined(var_3.pers["_encstr_A1ED09400BA5D351227715"]) && scripts\cp\utility::matchmakinggame()) {
      var_23 = var_3 scripts\cp\drone\emp_drone::getprestigelevel();
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_A1ED09400BA5D351227715", var_23);
    }

    if(var_3 isps4player())
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_A31904E09B0D");
    else if(var_3 isxb3player())
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8D19040F89CC");
    else if(var_3 ispcplayer())
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_B49B054CDC568E");
    else
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8BBA05185F8B99");

    var_3 scripts\cp\agents\agents::logplayerdata(var_16);
  }

  level.ingraceperiod = 0;
  setomnvar("_encstr_BE51134A8548B7C3DFD8F55DDD85E30EA7D1CB58E8", 0);
  waitframe();

  if(isDefined(level.timerstarttime))
    level.starttime = level.timerstarttime;

  level.time_survived = int((gettime() - level.starttime) / 1000);

  if(isDefined(level.eogscoringtable)) {}

  setomnvar("_encstr_88FF111263479BB8858057D385C34BEAE36983", level.time_survived);
  _id_131AC(1);
  setDvar("_encstr_8C3C0A99C0159584534AB827", 1);
  setDvar("_encstr_A744140DDAF1C720F1D777172C20C0A5FFC0163BF76B", 0);
  setDvar("_encstr_BAE50BF142A0C7670673B9A11F", 0);
  setDvar("_encstr_ABAE0ECD3693BE76B06B2BB237912B91", 1);
  setgameendtime(0);
  setslowmotion(1, 1, 0);

  foreach(var_3 in level.players)
  cleanup_player_on_game_end(var_3);

  level.bgameover = 1;

  foreach(var_28 in level.agentarray) {
    if(isDefined(var_28.isactive) && var_28.isactive) {
      var_28.ignoreall = 1;
      var_28 scripts\cp\utility::enable_alien_scripted();
    }
  }

  _id_131AC(0);
  level.winner = var_0;
  displaygameend(var_0, var_1);
  var_30 = should_load_new_map(var_1);

  if(isDefined(var_30)) {
    if(isDefined(level.load_new_map_func))
      [[level.load_new_map_func]](var_1);

    load_new_map(var_30);
    return;
  } else if(players_want_to_restart(var_0, var_1)) {
    var_31 = get_end_game_string_index("_encstr_92DF0B127AF74B41D63488E317");

    foreach(var_3 in level.players)
    var_3 setclientomnvar("_encstr_97B31357D27D9CEDAE73917D2B9B46BEA3B4D1C659", var_31);

    wait 1.0;
    restart_map();
    return;
  } else {
    var_31 = get_end_game_string_index("_encstr_84B408CAC3D2E8B4B9D9");

    foreach(var_3 in level.players)
    var_3 setclientomnvar("_encstr_97B31357D27D9CEDAE73917D2B9B46BEA3B4D1C659", var_31);
  }

  scripts\cp\cp_globallogic::_id_12C58();
  setDvar("_encstr_A53311F3D8256937BBAFC5C1AF66432E8DF86F", "_encstr_B40101");

  if(isDefined(level.pre_end_game_display_func))
    [[level.pre_end_game_display_func]]();

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_3 in level.players)
    var_3 setclientdvar("_encstr_8D410B996AD8A5BC640751B95F", 1);
  }

  var_38 = get_end_condition(var_1);
  var_39 = get_play_time();
  scripts\cp\cp_analytics::endgame(var_38, var_39);
  reset_players_subparty_data();
  wait 1;
  var_40 = level.intermissionfunc;

  if(isDefined(level.custom_intermission_func))
    var_40 = level.custom_intermission_func;

  wait 0.5;

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_3 in level.players)
    var_3 thread[[var_40]](var_1);
  }

  level notify("_encstr_88BC11FDBA8A5109E0A34075FFF167A4699A0D");
  exitlevel(0);
}

_id_13446() {
  level thread _id_13445("_encstr_8E8405EA382B2A", get_end_game_string_index("_encstr_BA970939F8483496FDA8C0"));
}

_id_13445(var_0, var_1) {
  if(gamealreadyended()) {
    return;
  }
  if(var_1 == 3 || var_1 == 2) {
    foreach(var_3 in level.players) {
      var_4 = game["_encstr_813F06832D8A18FE"]["_encstr_A5640DE6C10BDDDCF507C616E5CA93"].size;
      var_5 = randomint(var_4);
      var_3 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_88490DB11CBEE4BDAEB919D87B37CD"][var_5]);
      var_3 clearclienttriggeraudiozone(0);
      var_3 setsoundsubmix("_encstr_B89F0CD807D75B58A36C1A2B3723", 3);
      var_3 thread _id_1344A(var_0);

      if(istrue(var_3.musicplaying)) {
        var_3 playlocalsound("_encstr_938A1A9DCB39AAEB047FD7177336710C10B1972581E16AA3E5210F23");
        var_3 setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
      }
    }
  }

  if(var_1 == 1) {
    foreach(var_3 in level.players) {
      var_3 clearclienttriggeraudiozone(0);

      if(istrue(var_3.musicplaying)) {
        var_3 playlocalsound("_encstr_938A1A9DCB39AAEB047FD7177336710C10B1972581E16AA3E5210F23");
        var_3 setscriptablepartstate("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A7A408B9CA5D1D4E2C63", 0);
      }

      var_3 setplayermusicstate("_encstr_A13211C1259BD88BFF03FB61B32B3ED3282E47");
      var_3 setsoundsubmix("_encstr_B89F0CD807D75B58A36C1A2B3723", 3);
    }
  }

  setDvar("_encstr_87D9124B6393AECFD89C54373A5380FD074A1062", "_encstr_B40101");
  setnojiptime(1);
  markgameended();
  level notify("_encstr_9B1D0BC7932875276230426AA1", var_0);
  scripts\cp\cp_analytics::_id_119B8(var_1);
  freezeallplayers(1.0, "_encstr_A11E0A5D8FF1E1519E04D72C", 1);
  var_9 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));

  foreach(var_3 in level.players) {
    if(isDefined(level.gametype)) {
      var_3 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AAAC09D09972B9CC3F2B7F", level.gametype);
      var_3 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AB1904852B68", var_9);
    }
  }

  if(var_1 == 3)
    wait 1;

  setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", scripts\cp\utility::matchmakinggame());
  level.initship = 0;

  foreach(var_3 in level.players) {
    var_13 = get_current_zone(var_3);
    var_14 = var_3 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8E8D0697EB01F243");
    var_15 = var_3 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_8FAE0723DEEECDCA19");
    var_16 = var_3 getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_B642089B65A658E8F597");
    getentitylessscriptablearray("_encstr_8D941632C6ED9DD7AC9D56DCE8FA8DC123161D16D7567B9D", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_8D990BAE444FC837B53DB05FC9", getbuildnumber(), "_encstr_A9900BF17C56C0B5CB1AD940B2", var_3.name, "_encstr_936B0AB93A0B3AAF1D5EC1AC", "_encstr_8E8D0617EB01F243", "_encstr_A28E061BDE5DB9D1", var_14, "_encstr_A6700C553F53A7133193E808875E", "_encstr_B40101"]);
    getentitylessscriptablearray("_encstr_8D941632C6ED9DD7AC9D56DCE8FA8DC123161D16D7567B9D", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_8D990BAE444FC837B53DB05FC9", getbuildnumber(), "_encstr_A9900BF17C56C0B5CB1AD940B2", var_3.name, "_encstr_936B0AB93A0B3AAF1D5EC1AC", "_encstr_8E5C0C26C26EA3809AA30BDC199B", "_encstr_A28E061BDE5DB9D1", var_15, "_encstr_A6700C553F53A7133193E808875E", "_encstr_B40101"]);
    getentitylessscriptablearray("_encstr_8D941632C6ED9DD7AC9D56DCE8FA8DC123161D16D7567B9D", ["_encstr_B4F50AD8956795D8E6856BB2", level.script, "_encstr_8D990BAE444FC837B53DB05FC9", getbuildnumber(), "_encstr_A9900BF17C56C0B5CB1AD940B2", var_3.name, "_encstr_936B0AB93A0B3AAF1D5EC1AC", "_encstr_B642081B65A658E8F597", "_encstr_A28E061BDE5DB9D1", var_16, "_encstr_A6700C553F53A7133193E808875E", "_encstr_B40101"]);
    cargo_truck_mg_explode(var_3);

    if(isDefined(var_3.pers["_encstr_A51F05CB11A052"]) && scripts\cp\utility::matchmakinggame()) {
      var_17 = var_3 scripts\cp\drone\emp_drone::getrank();
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_A51F05CB11A052", var_17);
    }

    if(isDefined(var_3.pers["_encstr_A1ED09400BA5D351227715"]) && scripts\cp\utility::matchmakinggame()) {
      var_18 = var_3 scripts\cp\drone\emp_drone::getprestigelevel();
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_A1ED09400BA5D351227715", var_18);
    }

    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_823C09A2FB0F95E1C4FF41", var_3 getxuidhigh());
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_B12B0878EBE4094C77A7", var_3 getxuidlow());
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_82470DF0B83BAAB09D966F23813C01", var_14);
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_8FCE169139ED073895917D3ADBAFD885CD47F5E61DC2E623", var_15);
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_B15517ADDF2BFBE03D478E41EDEF28A3F27B7F3153E2BB3042", var_16);

    if(var_3 isps4player())
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_A31904E09B0D");
    else if(var_3 isxb3player())
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8D19040F89CC");
    else if(var_3 ispcplayer())
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_B49B054CDC568E");
    else
      setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_3.clientmatchdataid, "_encstr_BAE3090EC6581D66BD93D6", "_encstr_8BBA05185F8B99");

    var_3 scripts\cp\agents\agents::logplayerdata(var_1);
  }

  level.ingraceperiod = 0;
  waitframe();

  if(level.autoassignlowteamconsistent > -1)
    level.time_survived = _id_13447();
  else
    level.time_survived = 0;

  if(isDefined(level.eogscoringtable)) {}

  setomnvar("_encstr_88FF111263479BB8858057D385C34BEAE36983", level.time_survived);
  var_20 = _id_13448(var_0);

  if(var_20._id_1376C > 0)
    setomnvar("_encstr_B41D12ABA5FAE67B7DDCA3852737D7D95A9DACCD", var_20._id_1376C);

  setomnvar("_encstr_BDFD118564C9DFD86F9308D8C3579337124A75", var_20._id_11E84);
  setomnvar("_encstr_92380DCFCBB8237FF128236E4178AC", var_20.vehicle_compass_cp_init);
  setDvar("_encstr_8C3C0A99C0159584534AB827", 1);
  setDvar("_encstr_A744140DDAF1C720F1D777172C20C0A5FFC0163BF76B", 0);
  setDvar("_encstr_BAE50BF142A0C7670673B9A11F", 0);
  setgameendtime(0);

  if(getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7")) {
    foreach(var_3 in level.players) {
      if(var_20._id_1376C > 0) {
        var_3 _id_1344B(var_20._id_1376C, level.time_survived);
        var_22 = tablelookuprownum("_encstr_819B1B7337E8871ABF600219880B120F9810F6D74D49DB25E362CAD378", 1, level.script);
        var_23 = tablelookupbyrow("_encstr_819B1B7337E8871ABF600219880B120F9810F6D74D49DB25E362CAD378", var_22, 0);
        var_3 reportchallengeuserevent("_encstr_BA440D3863C5F12762923ED02F8AA9", var_23, var_20._id_1376C);
      }
    }
  }

  foreach(var_3 in level.players)
  cleanup_player_on_game_end(var_3);

  foreach(var_28 in level.agentarray) {
    if(isDefined(var_28.isactive) && var_28.isactive)
      var_28.ignoreall = 1;
  }

  _id_13444(var_0, var_1);
  var_30 = get_end_condition(var_1);
  var_31 = get_play_time();
  scripts\cp\cp_analytics::endgame(var_30, var_31);
  reset_players_subparty_data();

  if(_id_1344C()) {
    wait 0.1;

    foreach(var_3 in level.players) {
      var_3 clearsoundsubmix("_encstr_B89F0CD807D75B58A36C1A2B3723", 2);
      var_3 clearsoundsubmix("_encstr_B2281235B9A105E75D01F22A48BDE7FD1827B983", 2);
    }

    restart_map(0);
  } else
    exitlevel(0);
}

_id_13447() {
  var_0 = int(gettime() - level.autoassignlowteamconsistent);
  var_0 = int(var_0 / 1000) * 1000;
  return var_0;
}

trygetlastpotentiallivingplayer() {
  return getdvarint("_encstr_8B370BD5CF21D3395DE73B5BC1") && getdvarint("_encstr_A21D0A35C98AA27296A625A7");
}

_id_13448(var_0) {
  var_1 = spawnStruct();
  var_1._id_1376C = 0;
  var_1._id_11E86 = 1;
  var_1._id_11E84 = 0;
  var_2 = tablelookuprownum("_encstr_819B1B7337E8871ABF600219880B120F9810F6D74D49DB25E362CAD378", 1, level.script);
  var_3[0] = int(tablelookupbyrow("_encstr_819B1B7337E8871ABF600219880B120F9810F6D74D49DB25E362CAD378", var_2, 6));
  var_3[1] = int(tablelookupbyrow("_encstr_819B1B7337E8871ABF600219880B120F9810F6D74D49DB25E362CAD378", var_2, 7));
  var_3[2] = int(tablelookupbyrow("_encstr_819B1B7337E8871ABF600219880B120F9810F6D74D49DB25E362CAD378", var_2, 8));
  var_1._id_1376D = var_3;

  if(var_0 == "_encstr_9A8507BA4040188D08") {
    var_1._id_1376C = 1;

    for(var_4 = var_3.size - 1; var_4 >= 0; var_4--) {
      if(level.time_survived <= var_3[var_4]) {
        var_1._id_1376C = var_4 + 1;
        break;
      }
    }

    if(var_1._id_1376C == 3) {
      var_1._id_11E86 = 4;
      var_1._id_11E84 = 1;
    } else
      var_1._id_11E86 = var_1._id_1376C + 1;
  }

  if(var_1._id_11E86 > 1 && var_1._id_11E86 < 4)
    var_1._id_11E84 = var_3[var_1._id_11E86 - 1];

  var_1.vehicle_compass_cp_init = int(tablelookupbyrow("_encstr_819B1B7337E8871ABF600219880B120F9810F6D74D49DB25E362CAD378", var_2, 5));
  return var_1;
}

_id_1344B(var_0, var_1) {
  var_2 = self getplayerdata("_encstr_850703B7D9", "_encstr_BA771389A977FBA0E2C79149FF53B91BDD5D2D309D", level.script);
  var_3 = self getplayerdata("_encstr_850703B7D9", "_encstr_ACE7131612D1EB080320D19C2ACF13E1F3D3B7436B", level.script);

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return;
  }
  if(var_0 > var_2)
    self setplayerdata("_encstr_850703B7D9", "_encstr_BA771389A977FBA0E2C79149FF53B91BDD5D2D309D", level.script, var_0);

  if(var_1 < var_3 || var_3 == 0)
    self setplayerdata("_encstr_850703B7D9", "_encstr_ACE7131612D1EB080320D19C2ACF13E1F3D3B7436B", level.script, var_1);
}

_id_1344A(var_0) {
  var_1 = var_0 == self.pers["_encstr_8AEF05472BC2D6"];

  if(var_1 && !scripts\cp_mp\utility\player_utility::_id_12510()) {
    visionsetpain("_encstr_8BD40C3C9B3006FFD586322AA9BD", 0.2);
    self painvisionon();
    thread deathfxoverlay("_encstr_A3CA0E1AF1EFB37C91AF0EE56DF0C64F", "_encstr_A51B187752F8509AA9D11B8EA91777C1CB20A9A7B865EBA8B158", 0, 1, 18);
  }

  self setblurforplayer(10, 1);
}

_id_13444(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3.connectedpostgame) || var_3.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_3 thread _id_13449(var_0, var_1);
    var_3 thread scripts\cp\utility::freezecontrolswrapper(1);
  }
}

_id_13449(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_B6F20E9A5FE7874B997B159BC980E05A");
  var_2 = self.pers["_encstr_8AEF05472BC2D6"];

  if(!isDefined(var_2) || var_2 != "_encstr_9A8507BA4040188D08" && var_2 != "_encstr_8E8405EA382B2A")
    var_2 = "_encstr_9A8507BA4040188D08";

  self endon("_encstr_B6F20E9A5FE7874B997B159BC980E05A");

  if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && var_0 == var_2)
    var_3 = get_end_game_string_index("_encstr_91190447C232");
  else
    var_3 = get_end_game_string_index("_encstr_BD79059C51C351");

  self setclientomnvar("_encstr_97B31357D27D9CEDAE73917D2B9B46BEA3B4D1C659", var_3);

  if(isDefined(var_1))
    self setclientomnvar("_encstr_8F91145D4BFA39DE5D3732AFACB991EBE459169BBD9B", var_1);

  _id_131AC(11);
}

_id_1344C() {
  level.retry_total_votes = 0;
  level.retry_yes_votes = 0;
  var_0 = 35;
  var_1 = 0.1;

  for(var_2 = 0; var_2 < level.players.size; var_2++)
    setomnvar("_encstr_AF3F12AD31C780A89C6398D887AF539441D30768" + var_2, 0);

  var_3 = -1;
  var_4 = -1;
  var_5 = 1;

  foreach(var_7 in level.players)
  var_7 thread _id_124E8();

  while(level.retry_total_votes < level.players.size) {
    var_9 = int(var_0);

    if(var_9 >= 0 && var_9 != var_4) {
      var_4 = var_0;
      setomnvar("_encstr_AB7A105D93CEFBC5F1383B93604FFB7F600D", var_9);
    }

    if(var_0 <= 0) {
      var_5 = 0;
      break;
    }

    wait(var_1);
    var_0 = var_0 - var_1;
  }

  setomnvar("_encstr_AB7A105D93CEFBC5F1383B93604FFB7F600D", 0);
  level notify("_encstr_8FEA197B20B7B33948F147914FFBA98BC09832B13963F83D2B578B");

  if(!var_5)
    return 0;

  if(level.retry_yes_votes == level.players.size)
    return 1;

  return 0;
}

_id_124E8() {
  level endon("_encstr_8FEA197B20B7B33948F147914FFBA98BC09832B13963F83D2B578B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = -1;

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1);

    if(var_1 == "_encstr_8D840C6B550BAB48179179D03241") {
      if(var_0 < 0) {
        level.retry_total_votes = level.retry_total_votes + 1;
        level.retry_yes_votes = level.retry_yes_votes + 1;
        var_0 = 1;
        setomnvar("_encstr_AF3F12AD31C780A89C6398D887AF539441D30768" + self getentitynumber(), 1);
      } else if(var_0 == 0) {
        level.retry_yes_votes = level.retry_yes_votes + 1;
        var_0 = 1;
        setomnvar("_encstr_AF3F12AD31C780A89C6398D887AF539441D30768" + self getentitynumber(), 1);
      }

      continue;
    }

    if(var_1 == "_encstr_85E30B17BA2D8EFA1B59D9CAB1") {
      if(var_0 < 0)
        level.retry_total_votes = level.retry_total_votes + 1;
      else if(var_0 == 1)
        level.retry_yes_votes = level.retry_yes_votes - 0;

      var_0 = 0;
    }
  }
}

reset_players_subparty_data() {
  foreach(var_1 in level.players)
  var_1 setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_8BD6092BB3484AE75EE3E3", -1);
}

get_current_zone(var_0) {
  var_1 = getEntArray("_encstr_8D050B1CD79573D1D73DBD9BCA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin, var_3))
      return var_3.script_noteworthy;
  }
}

check_best_score() {}

vehomn_updateomnvarsperframe() {
  var_0 = getaiarray("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0)
  var_2 thread scripts\cp\cp_skits::movequestobjicon();
}

forceendgame() {
  level thread endgame("_encstr_8E8405EA382B2A", get_end_game_string_index("_encstr_BA970939F8483496FDA8C0"));
}

markgameended() {
  game["_encstr_A1AD062E09D98338"] = "_encstr_ACE709DA22939BA8075060";
  level.gameended = 1;
}

gamealreadyended() {
  return game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060" || level.gameended;
}

freezeallplayers(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 0;

  foreach(var_4 in level.players) {
    var_4 thread freezeplayerforroundend(var_0);
    var_4 thread roundenddof(4.0);
    var_4 freegameplayhudelems();
    var_4 setclientdvars("_encstr_A3D20B62A25A2854A94194A839", 1, "_encstr_B61F197138F9AD4D2940EFBF3FCE2B31CC35C64D1BB0B6E19F5757", 0);

    if(isDefined(var_1) && isDefined(var_2))
      var_4 setclientdvars(var_1, var_2);
  }

  foreach(var_7 in level.agentarray)
  var_7 scripts\cp\utility::freezecontrolswrapper(1);
}

freezeplayerforroundend(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp\utility::clearlowermessages();

  if(!isDefined(var_0))
    var_0 = 0.05;

  wait(var_0);
  scripts\cp\utility::freezecontrolswrapper(1);
}

roundenddof(var_0) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

get_play_time() {
  var_0 = 0;

  if(isDefined(level.starttime))
    var_0 = gettime() - level.starttime;

  return var_0;
}

freegameplayhudelems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] scripts\cp\utility::destroyelem();
      self.perkname[0] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] scripts\cp\utility::destroyelem();
      self.perkname[1] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] scripts\cp\utility::destroyelem();
      self.perkname[2] scripts\cp\utility::destroyelem();
    }
  }

  self notify("_encstr_8DFC0D2BC0A39BC347CB5C1725EBCA");
  self.lowermessage scripts\cp\utility::destroyelem();
  self.lowertimer scripts\cp\utility::destroyelem();

  if(isDefined(self.proxbar))
    self.proxbar scripts\cp\utility::destroyelem();

  if(isDefined(self.proxbartext))
    self.proxbartext scripts\cp\utility::destroyelem();
}

cleanup_player_on_game_end(var_0) {
  var_0 notify("_encstr_B64A0C53D00460920B7F17F03513");
  var_0 notify("_encstr_B6F20E9A5FE7874B997B159BC980E05A");
  var_0.pers["_encstr_88AD06120BDE0B17"] = var_0.stats;
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 scripts\cp\cp_persistence::set_player_currency(0);
  var_0 scripts\cp\utility::clearlowermessages();

  if(isDefined(var_0.pap))
    var_0.pap = [];

  if(isDefined(var_0.powerupicons))
    var_0.powerupicons = [];

  if(isDefined(var_0.consumables_equipped))
    var_0.consumables_equipped = [];

  if(isDefined(var_0.powers))
    var_0.powers = [];

  var_0 clear_powers_hud();
}

should_load_new_map(var_0) {
  if((var_0 == 1 || var_0 == 2) && getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") == "_encstr_82340EC683FA5316C6AD0BB1BE58DC9B")
    return "_encstr_AC4009C8D30131F03389D8";

  return undefined;
}

load_new_map(var_0) {
  kill_em_all();
  level scripts\engine\utility::_id_143B9(15, "_encstr_8CC1124B371DCA9CAD4BDCDC5ADBB9F5B7CE95C9");
  setDvar("_encstr_9A050BF1B1D21107C3D5B601E0", var_0);
  setDvar("_encstr_B60D0B9C840C31FA415FD7EFCB", "_encstr_8D6D0768D4AB5D8DCA");
  var_1 = "_encstr_86A20572899F2A" + var_0;
}

restart_map(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
    level.players[var_1] setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
    level.players[var_1] setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  }

  kill_em_all();
  setomnvar("_encstr_BE51134A8548B7C3DFD8F55DDD85E30EA7D1CB58E8", 1);
  _id_131AC(0);
  setomnvarforallclients("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 1);

  if(!isDefined(var_0))
    var_0 = 3;

  for(var_1 = var_0; var_1 > 0; var_1--)
    wait 1;

  foreach(var_3 in level.players) {
    var_3 clearsoundsubmix("_encstr_B89F0CD807D75B58A36C1A2B3723", 4);
    var_3 clearsoundsubmix("_encstr_B2281235B9A105E75D01F22A48BDE7FD1827B983", 4);
  }

  map_restart(1);
}

kill_em_all() {
  foreach(var_1 in level.characters) {
    if(isPlayer(var_1)) {
      continue;
    }
    var_1 dodamage(100000, var_1.origin);
  }

  var_3 = scripts\cp\cp_agent_utils::getactiveagentsofspecies("_encstr_97BB06B0C64B59B9");

  foreach(var_5 in var_3)
  var_5 suicide();
}

players_want_to_restart(var_0, var_1) {
  if(allow_players_to_restart(var_1)) {
    if(istrue(level.focus_test_mode))
      return 1;

    level.retry_total_votes = 0;
    level.retry_yes_votes = 0;
    level.retry_timer = 0;
    level._id_12CDF = 0;

    foreach(var_3 in level.players)
    var_3 thread display_retry_dialog(var_0, var_1);

    for(var_5 = level.players.size - level.retry_total_votes; level.retry_total_votes < level.players.size; level.retry_timer = level.retry_timer + 0.5) {
      if(level._id_12CDF != 0) {
        wait 1.0;
        return 0;
      }

      setomnvar("_encstr_AB7A105D93CEFBC5F1383B93604FFB7F600D", 33 - int(level.retry_timer));

      if(level.retry_timer >= 33)
        return 0;

      var_6 = var_5;
      var_5 = level.players.size - level.retry_total_votes;

      if(var_5 != var_6)
        iprintlnbold("_encstr_A52C0DB79064BB194064F1E260B3A2" + var_5 + "_encstr_B24C12A2A0A849BBFB0EF79A5FB19250B3F04B3F");

      wait 0.5;
    }

    if(level.retry_yes_votes == level.players.size && level._id_12CDF == 0) {
      wait 1.0;
      return 1;
    }
  }

  return 0;
}

allow_players_to_restart(var_0) {
  if(isDefined(level.allow_players_to_restart))
    return [[level.allow_players_to_restart]](var_0);
  else
    return var_0 == 3;
}

display_retry_dialog(var_0, var_1) {
  level endon("_encstr_8FEA197B20B7B33948F147914FFBA98BC09832B13963F83D2B578B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 1.0;
  scripts\cp\cp_laststand::clear_last_stand_timer(self);

  if(!isDefined(self.connectedpostgame) || !(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D")) {
    var_2 = self.pers["_encstr_8AEF05472BC2D6"];

    if(!isDefined(var_2) || var_2 != "_encstr_9A8507BA4040188D08" && var_2 != "_encstr_8E8405EA382B2A")
      var_2 = "_encstr_9A8507BA4040188D08";

    if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && var_0 == var_2)
      var_3 = get_end_game_string_index("_encstr_91190447C232");
    else
      var_3 = get_end_game_string_index("_encstr_BD79059C51C351");

    if(isDefined(var_1))
      self setclientomnvar("_encstr_8F91145D4BFA39DE5D3732AFACB991EBE459169BBD9B", var_1);
  }

  _id_131AC(10);
  var_4 = -1;
  self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_5);

  if(var_5 == "_encstr_8D840C6B550BAB48179179D03241") {
    if(var_4 < 0) {
      level.retry_total_votes = level.retry_total_votes + 1;
      level.retry_yes_votes = level.retry_yes_votes + 1;
      var_4 = 1;
      setomnvar("_encstr_AF3F12AD31C780A89C6398D887AF539441D30768" + self getentitynumber(), 1);
    } else if(var_4 == 0) {
      level.retry_yes_votes = level.retry_yes_votes + 1;
      var_4 = 1;
      setomnvar("_encstr_AF3F12AD31C780A89C6398D887AF539441D30768" + self getentitynumber(), 1);
    }
  } else if(var_5 == "_encstr_85E30B17BA2D8EFA1B59D9CAB1") {
    setomnvar("_encstr_AF3F12AD31C780A89C6398D887AF539441D30768" + self getentitynumber(), 2);
    level._id_12CDF = 1;
  }
}

clear_powers_hud() {
  if(isDefined(self.powers)) {
    foreach(var_1 in getarraykeys(self.powers)) {
      var_2 = self.powers[var_1].charges * -1;

      if(isDefined(level.power_adjustcharges))
        self[[level.power_adjustcharges]](var_2);
    }
  }

  if(isDefined(level.powers_clearpower)) {
    self[[level.powers_clearpower]]("_encstr_AC8F0AE74163F85AAA380AD8");
    self[[level.powers_clearpower]]("_encstr_BA7F0830B3A7859B60B0");
  }
}

get_end_condition(var_0) {
  switch (var_0) {
    case 1:
      return "_encstr_91190447C232";
    case 3:
    case 2:
      return "_encstr_9267057B2785D7";
    case 4:
      return "_encstr_96D50A34385E1B264F1D9B10";
    default:
  }
}

display_retry_loadout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0);

    if(var_0 == "_encstr_A1260BE03A25E7A9777DA5285D") {
      level.loadout_retry_completed = level.loadout_retry_completed + 1;
      continue;
    } else {
      switch (var_0) {
        case "_encstr_9A971243411ED7EFF37D49E399032A10BF59D970":
        case "_encstr_8897128C07B019FA8E560B6BF50BDAD6B7F5B473":
        case "_encstr_AD5A14321C0B19BE8E2B2C5BBE585B5B7BD7DC8E5D9B":
        case "_encstr_BA8E1346E0B08CBE1D2BB0B6D70B5BDAEDEB9CB2CE":
          break;
        case "_encstr_9B9A10A421C8DFB7F579CA3206C6BFD580C1":
        case "_encstr_B20E1069282107E9212072990877267298DB":
        case "_encstr_9B4315233A225C97AB4287AD59F323DA1D7D3BE470287B":
        case "_encstr_97BC1532070B197D1D9558ADFA563C1CC6BDDC2DB356B9":
          break;
        case "_encstr_833B0B58BB19F9CFBA3EEFEC92":
        case "_encstr_B45710858887CDB183CBCA0BC86B0FEB49DB":
        case "_encstr_96D813230E2CC8BE2359853A1AF56B16D8862D9B95":
        case "_encstr_924B11DA185B8FEF6337F227D949D754934072":
          break;
        case "_encstr_BDEF1312BDF5A24751889B8310CB0F1AABC1DE4F15":
          waitframe();
          waitframe();
          break;
        case "_encstr_A9870C40925A1F2673BD6FD1845B":
          waitframe();
          waitframe();
          break;
        case "_encstr_AC010C2043EA68A69A70B9045F13":
          waitframe();
          waitframe();
          break;
        case "_encstr_973A0B0E59936DBED656194BB1":
          waitframe();
          waitframe();
          break;
        case "_encstr_840A0E934FF6D779737506178B10CFAB":
          waitframe();
          waitframe();
          break;
        case "_encstr_8F8210AF5AEB808F5499F81840F3037B8026":
          waitframe();
          waitframe();
          break;
        case "_encstr_B8871023891E87F908D32E3B8910FDEFCDC3":
          waitframe();
          waitframe();
          break;
        case "_encstr_B65F0C83CA39B5AF0DF2984E5A19":
          waitframe();
          waitframe();
          break;
        case "_encstr_A3E7114878687A280B2DB370FF19C13A25A8DE":
        case "_encstr_92E711CB9FBA9060D37F07014F3AA8C047623A":
        case "_encstr_966B13D38792B848EB571FE9B7D2B040599F98CB2D":
        case "_encstr_93E711704DB3572111A0D39BA811695B68AEEF":
          break;
        case "_encstr_8A190FAB804D7CDFF322F9E4499EAB07B9":
        case "_encstr_8C621807CA27DAAF6EB5B4C61BD759B12B1B1D4ED2C6F5C2E436":
        case "_encstr_82271267077B8FBE23E708588377B0CF23EB57EE":
        case "_encstr_852A11CB45FB63B92340C3B35DAF048AD21068":
        case "_encstr_97E4150BE083BB213F6ABCF5C1BF8A7D09503F9B28B8EF":
        case "_encstr_A97912C1520A08379B2AC29D59775F33987310C3":
        case "_encstr_A3DD1807B24ED6BE37D62D8DC6BE4B733BD56373CA93169863B2":
        case "_encstr_8D35190E2B39ADF5E66DB43636EB4BB9CC5AB9968EAC7D16B5B6F6":
          break;
        case "_encstr_AC451493FB479F1379ABD8283396C933FBA33630D57B":
        case "_encstr_85A20D54B47DE1735368E7FFC1E820":
        case "_encstr_84900DF2D80D89D75B762F2D9880E3":
        case "_encstr_828116207BD2A818E28833359A8F588C37F3FB0B471FF9B8":
        case "_encstr_87D5194BEE63F5C64C4CA60BCCAFDA0E56C236DB3BDC9B5A072B27":
        case "_encstr_8B0C142DDDB1FA3B5B37F5ADC156CE5BDCE66CBDE056":
        case "_encstr_84A70BA053A6692EFB77176B7B":
        case "_encstr_91CC0BF0437DF93AE21B2F9851":
        case "_encstr_8E3E0D96EE8DFA5AB6C4CA36BEB50E":
        case "_encstr_A1FB10316F7AE65B78E733B7BB4388699543":
        case "_encstr_847D0B70E70EDED16AFBB0A112":
        case "_encstr_81060CAA3FE249F539126BF991C0":
        case "_encstr_87440C2C1362512BD39E97C9A220":
        case "_encstr_8B860C0AB89DCF128E6348E1D951":
        case "_encstr_97FD0DD2BBC6F5C64C4DB69BEBD638":
        case "_encstr_9A9A0E774FCB198BF3761A53037F2AF8":
        case "_encstr_AA170B2D77D8AF33838DFA5B38":
        case "_encstr_9BD8132DBBD8F5D0F673AC97C48523B3564EBEB5E0":
        case "_encstr_BA7B14FB932FF7692C9F1858B3746163E7FD6368EDA3":
        case "_encstr_BE570C96EE6C7D3823C8D8EBAD38":
        case "_encstr_84DE0EDAA3542F0D50AF0605A379D55B":
        case "_encstr_82980CA75B0231183A372BA170C1":
        case "_encstr_B1430DF0CB337F680BE4CD46B747F3":
        case "_encstr_81460B294BEDE13852C397D78A":
        case "_encstr_85FB0C5B932721D1FF092010A511":
        case "_encstr_A2F420BBB70FC05014A66B21CED02AAE316701A793D29680353E739322BBF8481BAF":
        case "_encstr_9AFA12306BC2B8901569E72391BE70F57F41089B":
        case "_encstr_AA1A0C9677E6FAACE41646D75B83":
        case "_encstr_A5450B0470E781E09009B73382":
        case "_encstr_8B9D121FBB5B9F8203F48E02DD33BB675BD98783":
        case "_encstr_A76612A5EECDAF6CD016C9D9959B1AEDA3F5B683":
        case "_encstr_BD3B0C4B3B83EF3B9B01DEC01543":
        case "_encstr_A1410D4BEE6EAF99F693B3957DB51C":
        case "_encstr_A1DE0B33FB4767A3DBE0E7F890":
        case "_encstr_8DB50B423B4CA786B823AF95E1":
        case "_encstr_8F540ABBEBBBC97DFB5F6A21":
        case "_encstr_95470C5863DBA731EB1DB4982D8B":
        case "_encstr_993D129AB067D1B7FA589D984A782A6277D893D2":
        case "_encstr_9B1E1C3344DF4846588F731B0B8B5F25E2D28F3337F2D3E7BF9F97CFBA57":
        case "_encstr_B8BA14104BE69868B65B9FC360CCA0DE2FE3A958A307":
        case "_encstr_B6090E3AFBF261AA88BBC37B3AB7D7E3":
        case "_encstr_97B60B071863F71A7306699DF7":
        case "_encstr_992D0EA3AF07D840EC9AC37880F7D887":
          break;
      }
    }
  }
}

displaygameend(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3.connectedpostgame) || var_3.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_3 thread outcomenotify(var_0, var_1);
    var_3 thread scripts\cp\utility::freezecontrolswrapper(1);
  }

  level notify("_encstr_9B2A094F9788B7C9F758EA", var_0);
  roundendwait(3.0, 1);
}

outcomenotify(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_B6F20E9A5FE7874B997B159BC980E05A");
  var_2 = self.pers["_encstr_8AEF05472BC2D6"];

  if(!isDefined(var_2) || var_2 != "_encstr_9A8507BA4040188D08" && var_2 != "_encstr_8E8405EA382B2A")
    var_2 = "_encstr_9A8507BA4040188D08";

  while(scripts\cp\cp_hud_message::isdoingsplash())
    wait 0.05;

  self endon("_encstr_B6F20E9A5FE7874B997B159BC980E05A");

  if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && var_0 == var_2)
    var_3 = get_end_game_string_index("_encstr_91190447C232");
  else
    var_3 = get_end_game_string_index("_encstr_BD79059C51C351");

  self setclientomnvar("_encstr_97B31357D27D9CEDAE73917D2B9B46BEA3B4D1C659", var_3);

  if(isDefined(var_1))
    self setclientomnvar("_encstr_8F91145D4BFA39DE5D3732AFACB991EBE459169BBD9B", var_1);

  _id_131AC(2);
}

register_end_game_string_index() {
  if(isDefined(level.end_game_string_override))
    [[level.end_game_string_override]]();
  else
    register_default_end_game_string_index();
}

register_default_end_game_string_index() {
  level.end_game_string_index = [];
  level.end_game_string_index["_encstr_91190447C232"] = 1;
  level.end_game_string_index["_encstr_BD79059C51C351"] = 2;
  level.end_game_string_index["_encstr_BA19049B7723"] = 3;
  level.end_game_string_index["_encstr_BA970939F8483496FDA8C0"] = 4;
  level.end_game_string_index["_encstr_92DF0B127AF74B41D63488E317"] = 5;
  level.end_game_string_index["_encstr_84B408CAC3D2E8B4B9D9"] = 6;
}

get_end_game_string_index(var_0) {
  return level.end_game_string_index[var_0];
}

roundendwait(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!isDefined(var_5.doingsplash)) {
        continue;
      }
      if(!var_5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }
      var_2 = 0;
    }

    wait 0.5;
  }

  if(!var_1) {
    wait(var_0);
    level notify("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739");
    return;
  }

  wait(var_0 / 2);
  level notify("_encstr_82AA118770E83DA1F98B93B7E1883A7F705B3A");
  wait(var_0 / 2);
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!isDefined(var_5.doingsplash)) {
        continue;
      }
      if(!var_5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }
      var_2 = 0;
    }

    wait 0.5;
  }

  level notify("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739");
}

deathfx() {
  var_0 = self;
  var_0.death = spawnStruct();
  var_0.death.huds = [];
  var_1 = 3.0;
  var_2 = 5;

  if(istrue(var_0.skip_screen_fx)) {
    return;
  }
  if(!var_0 scripts\cp_mp\utility\player_utility::_id_12510()) {
    visionsetpain("_encstr_8BD40C3C9B3006FFD586322AA9BD", 0.2);
    var_0 painvisionon();
    var_0 thread deathfxoverlay("_encstr_A3CA0E1AF1EFB37C91AF0EE56DF0C64F", "_encstr_A51B187752F8509AA9D11B8EA91777C1CB20A9A7B865EBA8B158", 0, 0, 18);
  }

  var_0 thread deathfxoverlay("_encstr_A3390DE1227781DBFFA3A3984D07E8", "_encstr_83F21F43AB9F234401F8AF8BB1D9057A91B341BB0D153A9588E18F934833F4A223", 1, 3, 19);
  var_0 thread deathfxoverlay("_encstr_850E0C7927A28DF89F5E40F90683", "_encstr_A64A1E83746FB0012AA783B52722DD70FC8C4EF9DDB9F04AE197AD93BB4A1708", 1, var_1, 20);
  wait 1;
  var_0 setblurforplayer(6, var_2);
}

deathfxoverlay(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  wait(var_2);
  var_5.death.huds[var_0] = create_death_hudelem();
  var_5.death.huds[var_0] setshader(var_1, 640, 480);

  if(var_3 > 0)
    var_5.death.huds[var_0] fadeovertime(var_3);

  var_5.death.huds[var_0].alpha = 1;
  var_5.death.huds[var_0].sort = var_4;
}

create_death_hudelem() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.splatter = 1;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.lowresbackground = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 0;
  var_0.enablehudlighting = 1;
  return var_0;
}
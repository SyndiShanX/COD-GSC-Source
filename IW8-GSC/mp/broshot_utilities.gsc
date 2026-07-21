/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\broshot_utilities.gsc
***********************************************/

processepictaunt(var_0, var_1, var_2) {
  if(var_1 >= 0 && isDefined(level.camera_bro_shot.char_loc)) {
    var_3 = level.camera_bro_shot.char_loc[var_1].origin;
    var_4 = level.camera_bro_shot.char_loc[var_1].angles;

    if(isDefined(level.overridebroslot))
      var_1 = level.overridebroslot - 1;
  } else {
    var_3 = level.charactercac.origin;
    var_4 = level.charactercac.angles;
    var_1 = 0;
  }

  if(tauntinprogress(var_1)) {
    return;
  }
  processtauntsound(var_0);
  deleteepictauntprops(var_1);
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = 0;
  var_14 = 0;
  var_15 = [];
  var_16 = [];
  var_17 = [];
  var_18 = [];
  var_19 = [];
  var_20 = 0;
  var_21 = 0;
  var_22 = [];
  var_23 = [];
  var_24 = [];
  var_25 = [];
  var_26 = 0;
  var_27 = [];
  var_28 = 0;

  switch (var_0) {
    case "_encstr_A3671F917C33AF952939FBA2AB7D8BF7B1550C0FA743CBD12790026A08C75396E3":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_7[0] = 10.0;
        var_23[0] = 0.85;
        var_23[1] = 2.05;
        var_23[2] = 1.15;
        level.losersinteractable = 0;
      }

      break;
    case "_encstr_85FC1F4B3B9F574890A770C017D6231FF29B41C8DAA2F9F66357B8A067CFF3335F":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_7[0] = 10.0;
        var_23[0] = 1.1;
        var_23[1] = 2.7;
        var_23[2] = 1.467;
        level.losersinteractable = 0;
      }

      break;
    case "_encstr_82BE1FCC33DF1159F387E9CBC7FA1DC92653D086B2E280187A4721C9E7B145D2AE":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_7[0] = 10.0;
        var_23[0] = 1.03;
        var_23[1] = 2.76;
        var_23[2] = 1.43;
        level.losersinteractable = 0;
      }

      break;
    case "_encstr_8D051852D5DCFAB51CAFD158EAE6A3BED8F691F51BD00B5B83DC":
      var_7[0] = 7.834;
      break;
    case "_encstr_868C1D68FF17F6C313D93D4FAB0A093EBB6F28B0432729892AFEBAC3050263":
      var_7[0] = 7.0;

      for(var_29 = 0; var_29 < 20; var_29++)
        var_22[var_29] = 2.6 + var_29 * 0.1;

      break;
    case "_encstr_938B269C2B7A9F6A8F0F7B2773B8C327405314E6C6207AA2E80B230F3F5DBA43881E4EEEF928603F":
      var_7[0] = 8.0;
      var_22[0] = 5.7;
      var_22[1] = 6.15;
      var_22[2] = 6.6;
      break;
    case "_encstr_AD7E289677E67D6B83EB4758EA37E87DB9BA83AC93F5BB5893CC2D9D86A3B2C9BE0BE8FA9B1B4E2BAC37":
      var_7[0] = 6.6;
      var_22[0] = 1.0;
      var_22[1] = 1.2;
      var_22[2] = 1.4;
      var_22[3] = 1.6;
      var_22[4] = 1.8;
      var_22[5] = 2.0;
      var_22[6] = 2.2;
      var_22[7] = 2.4;
      break;
    case "_encstr_A65617D2DDE6FADA83EBE885EACD3AFA4C967BBE6E38965BAC":
      var_7[0] = 6.6;
      var_22[0] = 1.65;
      var_22[1] = 2.05;
      break;
    case "_encstr_B1BB2154FF4F49CFEF21904205AD08C87A42988BBB0B5BB967CED199E225E250423219":
    case "_encstr_8ABB214AEB0F3FC140C118A1DDAAA33F9BCF85E61B2BF30279A2B78208F2166FAE8EBA":
    case "_encstr_B6791D5AEE737DD61CAF1D0BAB37E8BE6E2FDC2C38A35A36EB27562C0EB24E":
      var_7[0] = 6.6;
      var_21 = 2.0;
      break;
    case "_encstr_A78921A5DDDCF5D607FAA3B0BACD1DEBB696D836E63A93CA58DABEB96CB7E4361AB293":
      var_5[0] = "_encstr_93272CD55D2CC9998FE2F6399ACB58F0868F1573C35470512F7A6BE0124F10A89B0597CF57FAE8A6DF5320EE0A73";
      var_6[0] = "_encstr_826F2C815C039F8539298BD2106DBBE7E0CB1C0CF6B3E34FC3B0218BB857F2DF38A58A870EF9CFD2EF408A930A03";
      var_7[0] = 6.6;
      var_5[1] = "_encstr_93272CD55D2CC9998FE2F6399ACB58F0868F1573C35470512F7A6BE0124F10A89B0597CF57FAE8A6DF5320EE0A73";
      var_6[1] = "_encstr_926F2C335BF73FD0080FC8688F3ECB879A4439C9329B2D19C12789C0CF47433752EFAED88A02CFA3AB0350C0EA32";
      var_7[1] = 6.6;
      var_5[2] = "_encstr_93272CD55D2CC9998FE2F6399ACB58F0868F1573C35470512F7A6BE0124F10A89B0597CF57FAE8A6DF5320EE0A73";
      var_6[2] = "_encstr_BE6F2C2DBBB9BED683F5E8C2ABE6A3D76DB4B1C6E68E9CCA2CB6F59B36B7C9C634CA4EFACDC6BDC9D8A195C91866";
      var_7[2] = 6.6;
      var_21 = 3.0;
      var_28 = 1;
      break;
    case "_encstr_AD031BD2BBB97DAD0ED71DB0EAB9477DDAA58D6337D127AC85B67DC683":
      var_5[0] = "_encstr_96C50C22704F7257A968AC8F76BA";
      var_6[0] = "_encstr_85FA215B933721D3F3CE200FA32D2B178349D4502BD9EDD1D1C25FE9C249EE9F51C29B";
      var_7[0] = 5.5;
      var_8[0] = [];
      var_8[0][0] = "_encstr_8FA5185F27A28FC0AE11A1D2099BB04B5AABE1879BAA5779F5B2";
      var_8[0][1] = "_encstr_8E491B24C527AB773541A002390A31C06F6425885AF7D3995D4A49A0E3";
      var_9[0] = [];
      var_9[0][0] = "_encstr_B8470E7A993BAD6833EBA868877D80C9";
      var_9[0][1] = "_encstr_85D611A2C1D33680675C354CC01FC91FE90443";
      var_21 = 1.67;
      var_22[0] = 5.15;
      break;
    case "_encstr_8C641F94AE73D7B60EAF3A165D9B1D7D5B4B1B8DE6E827CAC2B6FA2C1C56C36062":
      var_5[0] = "_encstr_878221ACCF122F20E1338178CF12BE8F2AF9A83EE57A35E8DF2379489B57D0CB119D9F";
      var_6[0] = "_encstr_8CE724255D6EEB5B83F53AB0BA7347EBDAA58D639B1D2795585B7D853856E11889BE16E0B23C";
      var_7[0] = 5.0;
      var_22[0] = 2.0;
      var_22[1] = 2.4;
      var_22[2] = 2.6;
      var_22[3] = 3.2;
      var_22[4] = 3.6;
      var_22[5] = 3.8;
      break;
    case "_encstr_ABC71D96EECDFAD6E0BE3A85D59BA3AFADD2B11B6ED1E4B2B06DEB8E86BD39":
      var_5[0] = "_encstr_998114D62D90E7CD43E8716A388D898348805A47BC58";
      var_5[1] = "_encstr_B876194EEF924F40989FC0401FA9DB6369D5CBD682DAE1894F3A6A";
      var_5[2] = "_encstr_A6B41E67C05ED5BB7FF2960E6A2B325FA1D8FBAFD8701FA327199C024EC3EA2D";
      var_5[3] = "_encstr_A6B41E67C05ED5BB7FF2960E6A2B325FA1D8FBAFD8701FA327199C024EC3EA2D";
      var_5[4] = "_encstr_A6B41E67C05ED5BB7FF2960E6A2B325FA1D8FBAFD8701FA327199C024EC3EA2D";
      var_5[5] = "_encstr_A6B41E67C05ED5BB7FF2960E6A2B325FA1D8FBAFD8701FA327199C024EC3EA2D";
      var_5[6] = "_encstr_A6B41E67C05ED5BB7FF2960E6A2B325FA1D8FBAFD8701FA327199C024EC3EA2D";
      var_6[0] = "_encstr_829722A75B0A311870CFA15073FD40BE9FB958553FDBD87267B23E2CAAEA3B81533DED1B";
      var_6[1] = "_encstr_874D27FAD007B1D753F8242985F8FBC9C74832224829320FA9DA073413E03B0163D04B6B70C1AF128B";
      var_6[2] = "_encstr_924D270A20F741278328F419D5A88B999778E2D29819425F992AD70463D0EBD133809BBB20917FC29B";
      var_6[3] = "_encstr_824D27672F2449D53046BBC63BF8F481D28BFB8BCF2D2395D0A8798B70183AD9B9231F7F43591A189A";
      var_6[4] = "_encstr_8E4D272BD77E4E73B24118C89B4D0906576121114B9B13BBDE2A49686225FDDEE7193616B943B95953";
      var_6[5] = "_encstr_BE4D27B4EEB9FAB583FAA316AB9BD1BEB5B48D8DCD8E39AC0B6DF5D11ABDE4F5DA4BB9CDB4635903A9";
      var_6[6] = "_encstr_BE4D27B4EEB9FAB583FAA316AB9BD1BEB5B48D8DCD8E39AC0B6DF5D11ABDE4F5DA4BB9CDB4635903A9";
      var_7[0] = 7.47;
      var_7[1] = 3.76;
      var_7[2] = 4.7;
      var_7[3] = 4.7;
      var_7[4] = 4.7;
      var_7[5] = 4.7;
      var_7[6] = 4.7;
      var_13 = 1;
      var_14 = 1.5;
      var_21 = 4.5;
      var_28 = 1;
      break;
    case "_encstr_99FD1864DF8A6FFA1F9FCB97E3C8B3B7D04122F7508014F278F3":
      var_5[0] = "_encstr_834A19592EEA4BE06B5937A3D7ADE0F59B8573DBB934F68ED7EEB6";
      var_6[0] = "_encstr_BEC31DA91FA361EDE321DB5178F5E9A79649E2791856B92A30510960590547";
      var_7[0] = 10.0;
      var_22[0] = 7.5;
      break;
    case "_encstr_A3C81DCAB3C41F3DE8CF0CE163E083D70E6BD3B2BBA8D734388704EC7FBB4D":
      var_5[0] = "_encstr_833D135B7FAB91E11812672FD7BBB9B5D8BFB3AA83";
      var_6[0] = "_encstr_9B4921674F826035C05163434DE3EB1FD71B0818B551CB04BA9DD39108EB0D89C0F054";
      var_7[0] = 6.0;
      var_22[0] = 3.75;
      break;
    case "_encstr_859F1F93E3478F80585FB818DF6E7B57DBD40F98837AA38E338B580B5F87DB45C2":
    case "_encstr_9A9F1F610FFB87836728DB41AFCA5B56279279C3A357FDE7BE4D884B4F313AF861":
    case "_encstr_AC581B1039EFA9CF7BC01C01ED8093E1C9581A1A48079DCFF1B11F398A":
      var_10[0] = "_encstr_AC9506CFB2B5A0E0";
      var_11[0] = "_encstr_AB0703DBB9";
      var_12[0] = 0.01;
      var_10[1] = "_encstr_AC9506CFB2B5A0E0";
      var_11[1] = "_encstr_BA19049F4B2D";
      var_12[1] = 1.5;
      var_10[2] = "_encstr_AC9506CFB2B5A0E0";
      var_11[2] = "_encstr_AB0703DBB9";
      var_12[2] = 3.2;
      var_10[3] = "_encstr_AC9506CFB2B5A0E0";
      var_11[3] = "_encstr_BA19049F4B2D";
      var_12[3] = 4.7;
      var_7[0] = 5.1;
      var_13 = 1;
      var_14 = 2.0;
      break;
    case "_encstr_A20F249FD7ACC15DA8CE034EA3708C19663B03274520AA0DC051F1D27BF0A562B58DCFB7D7D0":
      var_15[0] = 0.466;
      var_16[0] = 2.85;
      var_17[0] = "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5";
      var_18[0] = "_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759";
      var_19[0] = "_encstr_9335171BB143FF9B807BF6D41728A35F656801425B97A79510";
      var_7[0] = 4.0;
      var_22[0] = 0.5;
      var_22[1] = 0.7;
      var_22[2] = 0.9;
      var_22[3] = 1.0;
      var_22[4] = 1.2;
      var_22[5] = 1.4;
      var_22[6] = 1.6;
      var_22[7] = 1.8;
      var_22[8] = 2.0;
      var_22[9] = 2.2;
      var_22[10] = 2.4;
      var_22[11] = 2.7;
      var_22[12] = 2.9;
      var_22[13] = 3.1;
      break;
    case "_encstr_AB52252DDDB9D76BE0BE47165DB91DBE6DD2B1B19BE84E56B0B67D63B037569CBEE63A9CB46DB2":
      var_7[0] = 12.0;
      var_24[0] = "_encstr_A6241E3B33F0BE13BDAD312CE432BE1637E84B3BC91667D70727ACEB56E11C63";
      var_24[1] = "_encstr_AD3B1DAB01F3AF4EA03B8A911D20D9DB1ED8E202094D2F859877948AD3605D";
      var_26 = 0.2;
      var_25[0] = (0, 80, 0);
      var_25[1] = (75, 140, 0);
      var_25[2] = (-165, 250, 0);
      var_25[3] = (50, 200, 0);
      var_25[4] = (155, 250, 0);
      var_25[5] = (-75, 140, 0);
      var_25[6] = (-50, 200, 0);
      var_27[0] = 1.0;
      var_27[1] = 1.0;
      var_27[2] = 3.5;
      var_22[0] = 3.5;
      var_22[1] = 3.7;
      var_22[2] = 3.9;
      var_22[3] = 4.1;
      var_22[4] = 4.3;
      var_22[5] = 4.5;
      var_22[6] = 4.7;
      var_22[7] = 4.9;
      break;
    default:
      return;
  }

  level.broshotepictauntprops[var_1] = [];
  level.broshotepictauntsubprops[var_1] = [];

  if(var_2 && var_13) {
    if(!isDefined(level.queuedtaunts))
      level.queuedtaunts = [];

    if(isDefined(level.queuedtaunts[var_0])) {
      var_30 = gettime() - level.queuedtaunts[var_0];

      if(var_30 < var_14 * 1000)
        wait(var_14 - var_30 / 1000);
    }

    level.queuedtaunts[var_0] = gettime();
  }

  var_31 = (0, 0, 0);

  if(var_28 && isDefined(level.upsidedowntaunts) && level.upsidedowntaunts == 1)
    var_31 = (180, 180, 0);

  for(var_29 = 0; var_29 < var_5.size; var_29++) {
    var_32 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_32 setModel(var_5[var_29]);
    var_32.angles = var_4 + var_31;
    var_32 notsolid();
    var_32 dontinterpolate();
    var_32 scriptmodelplayanimdeltamotion(var_6[var_29]);

    if(!isDefined(level.broshotepictauntprops))
      level.broshotepictauntprops = [];

    level.broshotepictauntprops[var_1][var_29] = var_32;

    if(!(isDefined(var_8[var_29]) && isarray(var_8[var_29]))) {
      continue;
    }
    level.broshotepictauntsubprops[var_1] = [];

    for(var_33 = 0; var_33 < var_8[var_29].size; var_33++) {
      var_34 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
      var_34 setModel(var_8[var_29][var_33]);
      var_34.angles = var_4 + var_31;
      var_34 notsolid();
      var_34 dontinterpolate();
      var_34 linkTo(var_32, var_9[var_29][var_33], (0, 0, 0), (0, 0, 0));
      level.broshotepictauntsubprops[var_1][var_33] = var_34;
    }
  }

  var_35 = 0;

  for(var_29 = 0; var_29 < var_7.size; var_29++)
    var_35 = max(var_35, var_7[var_29]);

  for(var_29 = 0; var_29 < var_10.size; var_29++)
    thread doepictauntscriptablestep(var_2, var_1, var_10[var_29], var_11[var_29], var_12[var_29]);

  if(var_2 == 0)
    var_36 = getplayercharacter(-1);
  else
    var_36 = getplayercharacter(var_1);

  if(var_2 != 0) {
    for(var_29 = 0; var_29 < var_15.size; var_29++)
      thread playbeamfx(var_15[var_29], var_16[var_29], var_19[var_29], var_17[var_29], var_18[var_29], var_36);
  }

  if(var_2 != 0 && var_20 > 0)
    thread doshellshock(var_20);

  if(var_2 != 0 && var_21 > 0)
    thread doearthquake(var_21, 1);

  for(var_29 = 0; var_29 < var_22.size; var_29++)
    thread doearthquake(var_22[var_29], 0);

  for(var_29 = 0; var_29 < var_23.size; var_29++)
    thread dodisintegrate(var_23[var_29], var_29);

  for(var_29 = 0; var_29 < var_25.size; var_29++) {
    var_37 = anglesToForward(level.camera_bro_shot.basecam.angles);
    var_38 = vectorNormalize((var_37[0], var_37[1], 0));
    var_39 = vectorcross(var_38, (0, 0, 1));
    var_40 = var_38 * var_25[var_29][1];
    var_41 = var_39 * var_25[var_29][0];
    var_42 = var_40 + var_41;

    if(var_2 != 0)
      var_43 = level.camera_bro_shot.char_loc[0].origin;
    else
      var_43 = var_3;

    for(var_33 = 0; var_33 < var_24.size; var_33++)
      thread dospawnvfx(var_24[var_33], var_27[var_33] + var_26 * var_29, var_42, var_43);
  }

  thread cleanupepictauntprops(var_1, var_35, var_0);
}

dospawnvfx(var_0, var_1, var_2, var_3) {
  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  wait(var_1);
  var_4 = var_3 + var_2;
  var_5 = spawnfx(level._effect[var_0], var_4);

  if(isDefined(var_5)) {
    triggerfx(var_5);
    var_5 thread delayfxdelete(12.0);
  }
}

delayfxdelete(var_0) {
  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  wait(var_0);

  if(isDefined(self))
    self delete();
}

dodisintegrate(var_0, var_1) {
  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  wait(var_0);

  if(isDefined(level.topplayers[var_1 + 3]))
    level.topplayers[var_1 + 3].bro hide(1);
}

playbeamfx(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  wait(var_0);
  var_6 = playfxontagsbetweenclients(level._effect[var_2], var_5, var_3, var_5, var_4);
  thread cleanupbeamfx(var_6, var_1);
}

cleanupbeamfx(var_0, var_1) {
  waittill_notify_or_timeout("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09", var_1);
  var_0 delete();
}

waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

doearthquake(var_0, var_1) {
  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");

  if(!isDefined(level.players)) {
    return;
  }
  wait(var_0);

  foreach(var_3 in level.players) {
    if(isbot(var_3)) {
      continue;
    }
    if(var_1) {
      var_3 earthquakeforplayer(0.5, 0.65, var_3.origin, 1000);
      continue;
    }

    var_3 earthquakeforplayer(0.15, 0.25, var_3.origin, 1000);
  }
}

doshellshock(var_0) {
  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  wait(var_0);

  foreach(var_2 in level.players) {
    if(isbot(var_2))
      continue;
  }
}

getplayercharacter(var_0) {
  if(var_0 == -1)
    var_1 = level.charactercac;
  else
    var_1 = level.topplayers[var_0].bro;

  return var_1;
}

doepictauntscriptablestep(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == 0)
    var_1 = -1;

  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  thread listenepictauntscriptablecancel(var_1, var_2);
  wait(var_4);
  var_5 = getplayercharacter(var_1);

  if(!isDefined(var_5)) {
    return;
  }
  var_5 setscriptablepartstate(var_2, var_3, 0);
}

listenepictauntscriptablecancel(var_0, var_1) {
  self waittill("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  var_2 = getplayercharacter(var_0);
  var_2 setscriptablepartstate(var_1, "_encstr_A66C0DD0FF02F3F035C76808BF4489", 0);
}

respawnclientcharacter() {
  var_0 = level.charactercac.angles;
  var_1 = level.charactercac.origin;
  level.charactercac delete();
  level.charactercac = spawn("_encstr_8B211183A693105B187E973892C8933B9B5F38", var_1, 0, 0, 1, "_encstr_A78C12A94168635A569B8E34A11627856C1D959C");
  level.charactercac.angles = var_0;
  deleteepictauntprops(0);

  if(isDefined(level.last_taunt_sfx)) {
    self stoplocalsound(level.last_taunt_sfx);

    if(soundexists(level.last_taunt_sfx + "_encstr_B68506EBB19BC96E"))
      self stoplocalsound(level.last_taunt_sfx + "_encstr_B68506EBB19BC96E");

    if(soundexists(level.last_taunt_sfx + "_encstr_B84305E0552A83"))
      self stoplocalsound(level.last_taunt_sfx + "_encstr_B84305E0552A83");

    level.last_taunt_sfx = undefined;
  }
}

tauntinprogress(var_0) {
  return isDefined(level.broshotepictauntprops) && isarray(level.broshotepictauntprops) && isDefined(level.broshotepictauntprops[var_0]) && level.broshotepictauntprops[var_0].size > 0;
}

cleanupepictauntprops(var_0, var_1, var_2) {
  self endon("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
  wait(var_1);
  level.taunts_done = 1;
  deleteepictauntprops(var_0);
}

deleteepictauntprops(var_0) {
  if(tauntinprogress(var_0)) {
    for(var_1 = 0; var_1 < level.broshotepictauntprops[var_0].size; var_1++) {
      if(isDefined(level.broshotepictauntprops[var_0][var_1])) {
        level.broshotepictauntprops[var_0][var_1] scriptmodelclearanim();
        level.broshotepictauntprops[var_0][var_1] delete();
      }
    }

    level.broshotepictauntprops[var_0] = [];

    if(isDefined(level.broshotepictauntsubprops[var_0]) && isarray(level.broshotepictauntsubprops[var_0])) {
      for(var_1 = 0; var_1 < level.broshotepictauntsubprops[var_0].size; var_1++) {
        if(isDefined(level.broshotepictauntsubprops[var_0][var_1])) {
          level.broshotepictauntsubprops[var_0][var_1] scriptmodelclearanim();
          level.broshotepictauntsubprops[var_0][var_1] delete();
        }
      }

      level.broshotepictauntsubprops[var_0] = [];
    }
  }

  self notify("_encstr_885315303AB5F7998B1F7DFF2DDBE3C75E5288B8228B09");
}

processtauntsound(var_0) {
  if(!soundexists(var_0)) {
    return;
  }
  if(!isDefined(level.taunts_done))
    level.taunts_done = 0;

  if(!isDefined(level.taunts_used))
    level.taunts_used = [];

  if(soundexists(var_0)) {
    if(isDefined(level.last_taunt_sfx)) {
      self stoplocalsound(level.last_taunt_sfx);

      if(soundexists(level.last_taunt_sfx + "_encstr_B68506EBB19BC96E"))
        self stoplocalsound(level.last_taunt_sfx + "_encstr_B68506EBB19BC96E");

      if(soundexists(level.last_taunt_sfx + "_encstr_B84305E0552A83"))
        self stoplocalsound(level.last_taunt_sfx + "_encstr_B84305E0552A83");

      level.last_taunt_sfx = undefined;
    }

    playepicbroshotsound(var_0);
    level.taunts_used[level.taunts_used.size] = var_0;
    level.last_taunt_sfx = var_0;
  } else if(soundexists(var_0 + "_encstr_81DF073F83C83CFF55")) {
    if(!array_contains(level.taunts_used, var_0)) {
      playepicbroshotsound(var_0 + "_encstr_81DF073F83C83CFF55");
      level.taunts_used[level.taunts_used.size] = var_0;
      level.last_taunt_sfx = var_0 + "_encstr_81DF073F83C83CFF55";
    }
  }
}

playepicbroshotsound(var_0) {
  if(isDefined(level.players)) {
    foreach(var_2 in level.players) {
      if(!isbot(var_2))
        var_2 playlocalsound(var_0);
    }
  } else
    self playlocalsound(var_0);
}

array_contains(var_0, var_1) {
  if(var_0.size <= 0)
    return 0;

  foreach(var_3 in var_0) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}
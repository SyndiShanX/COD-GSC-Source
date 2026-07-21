/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_dev.gsc
***********************************************/

init() {}

hidehudintermission(var_0, var_1) {
  level notify("_encstr_8BD3103B873005E750E1016A0B3E3BFF207F" + var_0);
  level endon("_encstr_8BD3103B873005E750E1016A0B3E3BFF207F" + var_0);
  setDvar(var_0, "_encstr_B40101");

  for(;;) {
    waitframe();
    var_2 = getDvar(var_0);

    if(var_2 == "_encstr_B40101") {
      continue;
    }
    setDvar(var_0, "_encstr_B40101");
    var_3 = strtok(var_2, "_encstr_974C0246");

    if(!isDefined(var_3) || var_3.size < 1) {
      continue;
    }
    var_4 = var_3[0];
    var_5 = scripts\engine\utility::array_slice(var_3, 1);
    [[var_1]](var_4, var_5);
  }
}

setup_level_for_nightvision(var_0, var_1) {
  if(!isDefined(level.setup_manned_turret)) {
    return;
  }
  foreach(var_3 in level.setup_manned_turret)[[var_3]](var_0, var_1);
}

_id_12B21(var_0) {
  if(!isDefined(level.setup_manned_turret))
    level.setup_manned_turret = [];

  level.setup_manned_turret[level.setup_manned_turret.size] = var_0;
}

setup_lights_in_region(var_0, var_1) {
  switch (var_0) {
    case "_encstr_AF07035B2B":
      thread level_getspawnpoint(var_1);
      break;
    case "_encstr_A71909E87A30A998FFE49E":
      thread _encstr_A61931882663C86301E31EA1B2B6BA990BFF04DB120F0B57795310BFF6AD795B13800D9E6B329B4CB8B1D0876F409CE05AD887::_id_12E0A(var_1);
      break;
    default:
      break;
  }
}

level_getspawnpoint(var_0) {
  level notify("_encstr_B8911191AC9DA6D827D2073A5646A856E68EE6");
  level endon("_encstr_B8911191AC9DA6D827D2073A5646A856E68EE6");
  var_1 = remove_map_hint(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-21500, 46200, -300), 0, 6000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((51000, -39000, 1401), 0, 4000), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((32000, 40000, 767), 0, 5500), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((23000, -15000, -158), 0, 6000)];

  if(!scripts\cp_mp\utility\game_utility::unlink_on_ai_death())
    var_2 = undefined;

  if(istrue(level.usegulag)) {
    foreach(var_4 in level.gulag.arenas)
    var_4.matches = [];

    level.gulag.arenas = sortbydistance(level.gulag.arenas, level.mapcorners[0].origin);
    level.gulag.maxuses = -1;
    level.gulag.timelimit = 15;
    setDvar("_encstr_913513DC6C93AF9827D7CCC67DDEB3AC9CA32DB595", 15);
    setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", 95);
  }

  scripts\mp\flags::gameflagset("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level notify("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setomnvar("_encstr_A1431305E44959FBD51FA8381FE0969132CAF3803F", 0);
  level.maxteamsize = 3;
  level.br_prematchstarted = 1;
  level.teammaxfill = 1;
  level.disablespawning = 0;
  level.ignorescoring = 0;
  level.allowprematchdamage = 1;
  setDvar("_encstr_A6CC0B082BBD112110C9375973", 1);
  setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 150);
  setDvar("_encstr_882B1C635A9D95BE1BBD314C5ED7AD2D9BC1B10B9795276EF56E47B0393A", 150);
  setDvar("_encstr_A9051587EF43C87802A1B1E959FED8968A5F5B0D6FEAAF", -1);
  setDvar("_encstr_B8892213491E57B6A08733389B407BF74521483A7066336A20E35507ABC883AB65B94342", 0);
  setDvar("_encstr_8885169B369CBE4C4E7DEC57C60BECBEEE5A73AF34EDC632", 0);
  setDvar("_encstr_A9DA15DAB6EDF9725BE1839750B117C2BDC0A7D3A973B2", 0);

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
    foreach(var_4 in level.gulag.arenas)
    var_4.shutdown = undefined;

    level.gulag.shutdown = undefined;
  }

  foreach(var_9 in level.players) {
    if(var_9 calloutmarkerping_getEnt()) {
      var_9 allowmovement(0);
      var_9 allowfire(0);
      var_9 allowmelee(0);
    }

    var_9.br_infilstarted = undefined;
    var_9.gulag = undefined;
    var_9.jailed = undefined;
    var_9.gulagarena = undefined;
    var_9._id_14439 = undefined;
    var_9._id_126CC = undefined;
    var_9._id_11E80 = undefined;
    var_9.gulagloser = undefined;
    var_9.gulaguses = undefined;
    var_9._id_119D7 = undefined;
    var_9.set_relic_nuketimer = undefined;
    var_9 notify("_encstr_91ED0AECABC60B3BEB95CD23");
    var_9 notify("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
    var_9 scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", var_9);
    var_9 setstance("_encstr_A5AD069B231F0BAF");
    var_9 calloutmarkerping_getcreatedtime(0.0);
    var_9 playershow();
    var_9.setspawnpoint = undefined;

    if(istrue(level.usegulag)) {
      var_9 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playerrespawngulagcleanup(0);
      var_9 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagarenaready();
    }
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    level.br_circle.dangercircleui.hidden = 1;
    level.br_circle.dangercircleent.hidden = 1;
    level.br_circle.safecircleui.hidden = 1;
    level.br_circle.safecircleent.hidden = 1;
    level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
  }

  if(!isDefined(level.level_logic))
    level.level_logic = [];

  if(!isDefined(level.level_killstreak_spawn)) {
    for(var_11 = 0; var_11 < level.teamnamelist.size; var_11++) {
      var_12 = level.teamnamelist[var_11];

      if(var_12 != var_1.team) {
        if(!isDefined(level.level_killstreak_spawn)) {
          level.level_killstreak_spawn = var_12;
          continue;
        }

        level.level_light = var_12;
        break;
      }
    }
  }

  _id_12D1C(var_1, var_1.team);
  _id_12D1C(var_1, level.level_killstreak_spawn);

  if(isDefined(level.level_light))
    _id_12D1C(var_1, level.level_light);

  var_13 = run_current_spawn_group(var_1, var_1.team);
  var_14 = run_current_spawn_group(var_1, level.level_killstreak_spawn);
  var_15 = [];

  if(isDefined(level.level_light))
    var_15 = run_current_spawn_group(var_1, level.level_light);

  for(var_11 = 0; var_11 < var_13.size; var_11++) {
    var_16 = var_13[var_11];
    var_17 = var_14[var_11];
    var_18 = undefined;

    if(isDefined(level.level_light))
      var_18 = var_15[var_11];

    var_19 = undefined;

    if(isDefined(var_2))
      var_19 = var_2[var_11].origin;
    else
      var_19 = var_16.origin;

    var_16 _id_126C5(var_19, 0);
    var_17 _id_126C5(var_19, 1);

    if(isDefined(level.level_light))
      var_18 _id_126C5(var_19, 2);
  }

  level.disablespawning = 1;
  var_20 = scripts\mp\utility\game::getlivingplayers();
  level.totalplayers = var_20.size;
  var_1 iprintlnbold("_encstr_8EB00BE9804FBB22D325F1ECC3");
  wait 2;

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_978809C03A1B91B8C6F5F3") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85CE0A9770B02C7299FF0CC5") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_92AA0C7973A3FF606E764FBE8042") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_82AA0C4770C03BA27895D7B7D93E") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BDAA0CBDD4BB4F68EEC35870B36B")) {
    killplayer(var_1, var_1, var_14);

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_82AA0C4770C03BA27895D7B7D93E")) {
      while(var_1.sessionstate != "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
        waitframe();

      while(var_1.sessionstate == "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
        waitframe();
    } else if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BDAA0CBDD4BB4F68EEC35870B36B")) {
      while(var_1.sessionstate != "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
        waitframe();

      wait 0.5;
    } else {
      _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
      wait 3;

      if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_92AA0C7973A3FF606E764FBE8042")) {
        var_1 iprintlnbold("_encstr_ABEF08314893239FF89C");
        wait 10;
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_92AA0C7973A3FF606E764FBE8042") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_82AA0C4770C03BA27895D7B7D93E") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BDAA0CBDD4BB4F68EEC35870B36B")) {
    var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580();
    kick(var_21 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85CE0A9770B02C7299FF0CC5")) {
    for(var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580(); !isDefined(var_21); var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580())
      waitframe();

    killplayer(var_1, var_21, var_14);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85CE0A9770B02C7299FF0CC5")) {
    for(var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580(); !isDefined(var_21); var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580())
      waitframe();

    killplayer(var_1, var_21, var_14);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85CE0A9770B02C7299FF0CC5")) {
    for(var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580(); !isDefined(var_21); var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580())
      waitframe();

    killplayer(var_1, var_21, var_15);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85CE0A9770B02C7299FF0CC5")) {
    for(var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580(); !isDefined(var_21); var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580())
      waitframe();

    killplayer(var_1, var_21, var_15);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85CE0A9770B02C7299FF0CC5")) {
    for(var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580(); !isDefined(var_21); var_21 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580())
      waitframe();

    killplayer(var_1, var_21, var_15);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 3;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_B13707978F9AEF5859")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        killplayer(var_1, var_9, var_14);
      }
    }

    wait 10;
    killplayer(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BA370757E765FB77C6") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A937070AA705683A2F")) {
    killplayer(var_1, var_1, var_14);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        killplayer(var_1, var_9, var_14);
      }
    }

    while(!isDefined(var_1 getspectatingplayer()))
      waitframe();

    var_26 = var_1 getspectatingplayer();
    var_26.br_infilstarted = 1;
    wait 1;

    foreach(var_9 in var_14) {
      var_9.br_infilstarted = 1;
      killplayer(var_1, var_9, var_15);
    }

    while(!istrue(var_26.gulagarena))
      waitframe();

    wait 5;

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BA370757E765FB77C6")) {
      var_29 = spawnStruct();
      var_29.playerspawnpos = (26474, -16709, -162);
      var_29.playerspawnangles = (85, 135, 0);
      var_26.setspawnpoint = var_29;

      foreach(var_9 in var_14) {
        if(istrue(var_9.gulagarena)) {
          var_9.br_infilstarted = 1;
          killplayer(var_1, var_9, var_15);
          break;
        }
      }

      while(!var_26 islinked())
        waitframe();

      while(var_26 islinked())
        waitframe();

      waitframe();
      var_32 = var_26 getplayerangles();
      var_26 setplayerangles((85, var_32[1], 0));
    } else
      killplayer(var_1, var_26, var_15);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8C370774BD7BE11FDB")) {
    var_1.br_infilstarted = 1;
    var_33 = killplayer(var_1, var_1, var_14);
    var_33.br_infilstarted = 1;
    killplayer(var_1, var_33, var_13);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_88A10B3BEA8D85B3ECAE360BB3")) {
    var_34 = getdvarint("_encstr_BEBA1103B60289465BFF4557E7B29690A68EC3", 0);
    var_35 = getdvarint("_encstr_BDBA113736C9F5C4277DCCD8EB2C392B732CC8", 5);
    setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", 9999);
    setDvar("_encstr_A9051587EF43C87802A1B1E959FED8968A5F5B0D6FEAAF", var_34);
    var_1.br_infilstarted = 1;
    var_33 = killplayer(var_1, var_1, var_14);
    setDvar("_encstr_A9051587EF43C87802A1B1E959FED8968A5F5B0D6FEAAF", var_35);

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        killplayer(var_1, var_9, var_14);
      }
    }

    setDvar("_encstr_A9051587EF43C87802A1B1E959FED8968A5F5B0D6FEAAF", var_34);
    var_33.br_infilstarted = 1;
    killplayer(var_1, var_33, var_15);

    while(!istrue(var_1.gulagarena) && !istrue(var_33.gulagarena))
      waitframe();

    wait 5;
    killplayer(var_1, var_1, undefined, var_33);
    setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", 90);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A547098480BC4DA048C8D1")) {
    var_33 = var_14[0];

    foreach(var_9 in var_13) {
      if(var_9 != var_1)
        killplayer(var_1, var_9, undefined, var_33);
    }

    killplayer(var_1, var_33, undefined, var_1);
    wait 10;
    killplayer(var_1, var_1, undefined, var_33);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AA880912FC6279F1F9271A")) {
    var_33 = killplayer(var_1, var_1, var_14);
    wait 3;
    killplayer(var_1, var_1._id_11E80, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_9A3707EFCD188A872B") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AF37073F273247C036")) {
    var_40 = undefined;

    foreach(var_9 in var_13) {
      if(!isDefined(var_40) && var_9 != var_1) {
        var_40 = var_9;
        continue;
      }

      killplayer(var_1, var_9, var_14);
      _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_9);
    }

    var_40.br_infilstarted = 1;

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AF37073F273247C036")) {
      setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", 9999);
      var_34 = getdvarint("_encstr_BEBA1103B60289465BFF4557E7B29690A68EC3", 5);
      setDvar("_encstr_A9051587EF43C87802A1B1E959FED8968A5F5B0D6FEAAF", var_34);
      var_40._id_119D7 = 1;
    }

    killplayer(var_1, var_40, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8D37073CD34A4B69B7")) {
    killplayer(var_1, var_1, var_14);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;
    var_43 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        var_43 = var_9;
        var_43 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::initplayerjail();
        break;
      }
    }

    while(!isDefined(var_1 getspectatingplayer()))
      waitframe();

    wait 1;
    var_46 = undefined;

    foreach(var_9 in var_14) {
      var_9.br_infilstarted = 1;
      var_46 = var_9;
      killplayer(var_1, var_9, var_15);
      break;
    }

    while(!istrue(var_43.gulagarena) && !istrue(var_46.gulagarena))
      waitframe();

    wait 5;
    setDvar("_encstr_8885169B369CBE4C4E7DEC57C60BECBEEE5A73AF34EDC632", 1);
    killplayer(var_1, var_46, undefined, var_43);

    while(var_1 getspectatingplayer() != var_43)
      wait 1;

    wait 5;
    setDvar("_encstr_8885169B369CBE4C4E7DEC57C60BECBEEE5A73AF34EDC632", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_853707273F2A5FC8C0")) {
    level.gulag.timelimit = 3;
    setDvar("_encstr_913513DC6C93AF9827D7CCC67DDEB3AC9CA32DB595", 3);
    setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", -1);
    killplayer(var_1, var_1, var_14);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;
    var_43 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9.br_infilstarted = 1;
        var_43 = var_9;
        var_43 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::initplayerjail();
        break;
      }
    }

    while(!isDefined(var_1 getspectatingplayer()))
      waitframe();

    while(var_1 getspectatingplayer() != var_43) {
      iprintlnbold("_encstr_8EAD229F4F6C909E8B2693F80ECFCFC006A40359C9154077CF6BA821825A87C0DE1183CD");
      waitframe();
    }

    wait 1;
    var_46 = undefined;

    foreach(var_9 in var_14) {
      var_9.br_infilstarted = 1;
      var_46 = var_9;
      killplayer(var_1, var_9, var_15);
      break;
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8A370767507061727B")) {
    var_1.br_infilstarted = 1;
    var_33 = killplayer(var_1, var_1, var_14);
    var_33.br_infilstarted = 1;
    killplayer(var_1, var_33, var_13);

    foreach(var_9 in var_13) {
      if(var_9 != var_1)
        killplayer(var_1, var_9, var_14);
    }

    foreach(var_9 in var_14) {
      if(var_9 != var_33)
        killplayer(var_1, var_9, var_15);
    }

    while(!istrue(var_1.gulagarena))
      waitframe();

    wait 5;
    setDvar("_encstr_8885169B369CBE4C4E7DEC57C60BECBEEE5A73AF34EDC632", 1);
    setDvar("_encstr_B8892213491E57B6A08733389B407BF74521483A7066336A20E35507ABC883AB65B94342", 3);
    killplayer(var_1, var_1, undefined, var_33);
    wait 9;
    setDvar("_encstr_8885169B369CBE4C4E7DEC57C60BECBEEE5A73AF34EDC632", 0);
    setDvar("_encstr_B8892213491E57B6A08733389B407BF74521483A7066336A20E35507ABC883AB65B94342", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_841208F77BF0CE0707A3")) {
    var_57 = var_14[0];
    var_57.br_infilstarted = 1;
    killplayer(var_1, var_57, var_15);
    var_58 = var_15[0];
    var_58.br_infilstarted = 1;
    killplayer(var_1, var_58, var_14);
    wait 1;
    var_59 = var_1;
    var_59.br_infilstarted = 1;
    killplayer(var_1, var_59, var_14);
    var_60 = var_14[1];
    var_60.br_infilstarted = 1;
    killplayer(var_1, var_60, var_15);

    while(!istrue(var_57.gulagarena) || !istrue(var_58.gulagarena) || !istrue(var_59.jailed) || !istrue(var_60.jailed))
      waitframe();

    setDvar("_encstr_A9DA15DAB6EDF9725BE1839750B117C2BDC0A7D3A973B2", 1);
    var_61 = var_15[1];
    var_61.br_infilstarted = 1;
    killplayer(var_1, var_61, var_14);
    wait 1;

    while(istrue(var_61.set_relic_steelballs_perks))
      waitframe();

    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::shutdowngulag("_encstr_BAA70D43AB53970DDBF1921AD023C0", 0);
    wait 1;
    kick(var_61 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    wait 3;
    setDvar("_encstr_A9DA15DAB6EDF9725BE1839750B117C2BDC0A7D3A973B2", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8A12080FDDE8E7873BDA")) {
    var_1.br_infilstarted = 1;
    _id_1294D(var_1, var_1, var_15);
    wait 1;
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::shutdowngulag("_encstr_BAA70D43AB53970DDBF1921AD023C0", 0);
    wait 1;
    var_1 scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", var_1);
    wait 5;
    killplayer(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BDD2099DABB10BCE594A41")) {
    var_62 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_62 = var_9;
        break;
      }
    }

    var_1.br_infilstarted = 1;
    killplayer(var_1, var_1, var_14);
    var_65 = getdvarfloat("_encstr_87D5129BC627F5765D1B2C3BD9B4E0EBEEC2961D", 0.1);
    wait(var_65);
    _encstr_92CD26C37908D8EB3D1F670F50C8DA3955FB5BD792B14F9E42836953ACF2D18F7312F230F087FB66::_id_142C5(var_1, var_62, "_encstr_951904D8F1E0");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A7FB0CA3BBDEBDCDACCC9C165B59")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        killplayer(var_1, var_9, var_14);
        break;
      }
    }

    wait 5;

    foreach(var_9 in var_13) {
      if(isalive(var_9))
        vo_nag_mark_crates(var_1, var_9, var_14);
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A7EE08BF9BDB5A0140F1")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1)
        killplayer(var_1, var_9, var_14);
    }

    wait 5;

    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
      var_1 scripts\mp\utility\perk::removeperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

    var_1 suicide();
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8AEF05472BC2D6")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1)
        vo_nag_mark_crates(var_1, var_9, var_14);
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_ACC107AD988D31CD07")) {
    vo_nag_mark_crates(var_1, var_1, var_14);

    while(!isDefined(var_1._id_126CC))
      waitframe();

    var_9 = var_1._id_126CC;
    var_74 = anglesToForward(var_9.angles);
    var_75 = getdvarint("_encstr_A37C0C130B06FBDEC8E37BC6DBA8", 5);

    for(var_76 = var_1 getspectatingplayer(); !isDefined(var_76); var_76 = var_1 getspectatingplayer()) {
      var_77 = var_9.origin + var_74 * var_75;
      var_9 setOrigin(var_77);
      waitframe();
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AB460690C7CCE83F") || calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8346066C85B178BA")) {
    var_26 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(!isDefined(var_26)) {
          var_26 = var_9;
          continue;
        }

        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }

    wait 1;
    vo_nag_mark_crates(var_1, var_1, var_14);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 1;
    var_80 = getarraykeys(level.vehicle.instances["_encstr_9A8F0CB1A5E8471BB2EB894B39C8"]);
    var_81 = level.vehicle.instances["_encstr_9A8F0CB1A5E8471BB2EB894B39C8"][var_80[0]];
    var_82 = var_81 getlinkedscriptableinstance();
    var_26 setOrigin(var_81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "_encstr_BDDC07EBCCB5CA4BED", "_encstr_962F0CB3560DD236D8CAD7576E59", var_26, 0);

    if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8346066C85B178BA")) {
      wait 3;
      kick(var_26 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_854C06DD0B8E959C"))
    var_1 setOrigin((28252, -32627, -415));

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_83631299F763E6200EFDC11963FB282BEB3719BB")) {
    vo_nag_mark_crates(var_1, var_1, var_14);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    var_26 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580();

    while(!var_1 buttonPressed("_encstr_B4EF0EAB0BB5D9D7E16612AA7C092471"))
      waitframe();

    var_83 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1 && var_9 != var_26) {
        var_83 = var_9;
        break;
      }
    }

    wait 0.5;
    kick(var_83 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_9B63128C3B70364FC030523A9BA6F76CE0970842")) {
    vo_nag_mark_crates(var_1, var_1, var_14);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    var_26 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580();

    while(!var_1 buttonPressed("_encstr_B4EF0EAB0BB5D9D7E16612AA7C092471"))
      waitframe();

    wait 0.5;
    kick(var_26 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AB070C59B919CD0EB236D1B0E82B")) {
    level.br_infils_disabled = 1;
    setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 2);
    level.gulag.maxuses = 0;
    wait 1;
    vo_nag_mark_crates(var_1, var_1, var_14);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 2;

    foreach(var_9 in var_13) {
      if(var_9 != var_1)
        vo_nag_mark_crates(var_1, var_9, var_14);
    }

    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 2;
    var_33 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580();
    vo_nag_mark_crates(var_1, var_33, var_15);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 2;
    var_33 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580();
    vo_nag_mark_crates(var_1, var_33, var_15);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 2;
    var_33 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580();
    vo_nag_mark_crates(var_1, var_33, var_15);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    wait 2;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_86EC0A736B2F4AEFD883DF32")) {
    setDvar("_encstr_B8892213491E57B6A08733389B407BF74521483A7066336A20E35507ABC883AB65B94342", 5);

    foreach(var_9 in var_13) {
      if(var_9 != var_1)
        vo_nag_mark_crates(var_1, var_9, var_14);
    }

    wait(getdvarfloat("_encstr_AF9F0E5B75331921095AF75B4BD05A29", 5));
    var_33 = vo_nag_mark_crates(var_1, var_1, var_14);
    wait(getdvarfloat("_encstr_B6C50F53FDB71307D348EFC7C0A8E0CACD", 13));
    vo_nag_mark_crates(var_1, var_33, var_15);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A9850DE0929E21C01FAF6BDD935B23")) {
    setDvar("_encstr_B8892213491E57B6A08733389B407BF74521483A7066336A20E35507ABC883AB65B94342", 5);
    vo_nag_mark_crates(var_1, var_1, var_14);
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_143FA(var_1);
    var_26 = var_1 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_12580();

    while(!var_1 buttonPressed("_encstr_B4EF0EAB0BB5D9D7E16612AA7C092471"))
      waitframe();

    var_83 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1 && var_9 != var_26) {
        var_83 = var_9;
        break;
      }
    }

    wait 0.5;
    vo_nag_mark_crates(var_1, var_83, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BDEE0CD2B7FB027CF368BBAF10CB")) {
    setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", 9999);
    setDvar("_encstr_B8892213491E57B6A08733389B407BF74521483A7066336A20E35507ABC883AB65B94342", 3);

    foreach(var_9 in var_13) {
      if(var_9 != var_1)
        kick(var_9 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    }

    wait 5;
    var_94 = var_14[0];
    var_95 = var_14[1];
    var_94.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_94, undefined, var_1);
    wait(getdvarfloat("_encstr_A29A112B600E4CB97A03539A2AEBCF1B522B1B", 4));
    vo_nag_mark_crates(var_1, var_1, undefined, var_95);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A2130842D8C14BA660D1")) {
    level.overrideingraceperiod = 1;
    var_96 = var_13[1];

    foreach(var_9 in var_13) {
      if(var_9 != var_96)
        vo_nag_mark_crates(var_1, var_9, var_14);
    }

    foreach(var_9 in var_14)
    vo_nag_mark_crates(var_1, var_9, var_15);

    foreach(var_9 in var_15)
    vo_nag_mark_crates(var_1, var_9, var_14);

    wait 10;
    kick(var_96 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    level.overrideingraceperiod = undefined;
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_82AB0A05B0283DC3FA9BF38B")) {
    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        var_9 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(45);
        var_9.br_infilstarted = 1;
        vo_nag_mark_crates(var_1, var_9, var_14);
      }
    }

    wait 5;
    vo_nag_mark_crates(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AB8209820B1B23F6A86FF1")) {
    _id_12F81(var_1.origin, 500);
    setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", -1);
    var_105 = var_1;
    var_105.br_infilstarted = 1;
    killplayer(var_1, var_105, var_15);
    var_106 = var_15[0];
    var_106.br_infilstarted = 1;
    killplayer(var_1, var_106, var_15);

    while(!istrue(var_105.gulagarena))
      waitframe();

    wait 5;
    vo_nag_mark_crates(var_1, var_105, []);

    while(!isDefined(var_105 getspectatingplayer()))
      waitframe();

    var_107 = var_105 getspectatingplayer();
    var_107.br_infilstarted = 1;
    var_61 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_105 && var_9 != var_107) {
        var_61 = var_9;
        break;
      }
    }

    var_61 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(45);
    killplayer(var_1, var_107, var_15);

    while(!istrue(var_107.jailed))
      waitframe();

    while(!isDefined(var_105 getspectatingplayer()) || var_105 getspectatingplayer() != var_107)
      waitframe();

    var_110 = var_15[1];
    var_110.br_infilstarted = 1;
    killplayer(var_1, var_110, var_15);

    while(!istrue(var_107.gulagarena))
      waitframe();

    wait 5;
    setDvar("_encstr_B8892213491E57B6A08733389B407BF74521483A7066336A20E35507ABC883AB65B94342", 3);
    vo_nag_mark_crates(var_1, var_107, []);
    var_61 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
    var_105 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagautowin("_encstr_9118045402B3", var_61, 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8BEC0AC3CAA8488BC0F32FCD")) {
    vo_nag_mark_crates(var_1, var_1, var_14);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;
    var_111 = 0;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(var_111 > 0) {
          var_9 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(45);
          var_9.br_infilstarted = 1;
        }

        vo_nag_mark_crates(var_1, var_9, var_15);
        var_111++;
        wait 5;
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8ACC0563CB1333")) {
    _id_12F81(var_1.origin, 700);
    var_1.br_infilstarted = 1;
    var_26 = var_13[1];
    var_114 = spawnStruct();
    var_114.vip = var_26;
    var_114.team = var_26.team;
    var_114.isvalidkillcam = "_encstr_914C09A5379BA30BB98DB2";
    var_114.removed = 1;
    setDvar("_encstr_A9DA15DAB6EDF9725BE1839750B117C2BDC0A7D3A973B2", 2);
    killplayer(var_1, var_1, var_14);

    while(!istrue(var_1.set_relic_nuketimer))
      waitframe();

    var_114 _encstr_92CD26C37908D8EB3D1F670F50C8DA3955FB5BD792B14F9E42836953ACF2D18F7312F230F087FB66::_id_142B7();
    wait 5;
    setDvar("_encstr_A9DA15DAB6EDF9725BE1839750B117C2BDC0A7D3A973B2", 0);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_BD7D0B1BB0445B19387F5353E4")) {
    thread _id_14366(getdvarint("_encstr_BECD0D5BF5AF0B0F3BF0C7E738F1ED", 1), var_13[1]);
    _id_12078();
    level waittill("_encstr_B4DE144C93BE1B139960FA1B5933D1FA98DED59B91CD");
    wait 2;
    var_13[2].br_infilstarted = 0;
    vo_nag_mark_crates(var_1, var_13[2], var_14);
    wait 5;
    var_1.br_infilstarted = 0;
    vo_nag_mark_crates(var_1, var_1, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8A300C7E2DC7A08D870B63600232")) {
    setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 9);
    wait 5;
    var_94 = var_14[0];
    var_95 = var_15[0];
    kick(var_14[2] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_14[1] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_15[2] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_15[1] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_13[2] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_13[1] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    wait 1;
    var_1 _id_126B5();
    var_94.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_94, undefined, var_95);
    wait 7;
    var_1.br_infilstarted = 1;

    if(!var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
      var_1 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

    vo_nag_mark_crates(var_1, var_1, undefined, var_95, 1);

    while(!istrue(var_1.gulagarena))
      waitframe();

    wait 5;
    vo_nag_mark_crates(var_1, var_94, undefined, var_1);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85300CC0C733A0953063019FFF3F")) {
    var_94 = var_14[0];
    var_95 = var_14[1];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1)
      var_115 = var_13[0];
    else if(var_83 == var_1)
      var_83 = var_13[0];

    kick(var_14[2] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_15[2] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_15[1] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    kick(var_15[0] getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    vo_nag_mark_crates(var_1, var_83, undefined, var_94);
    wait 1;
    var_115 _id_126B5();
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 3;
    var_95.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_95, undefined, var_115);
    var_115.br_infilstarted = 1;

    if(!var_115 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
      var_115 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

    vo_nag_mark_crates(var_1, var_115, undefined, var_94, 1);

    while(!istrue(var_115.gulagarena))
      waitframe();

    wait 5;
    vo_nag_mark_crates(var_1, var_115, undefined, var_95);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_B86E0EFB5E371197974A9FE3F2EB5BC8")) {
    setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 8);
    wait 5;
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::shutdowngulag("_encstr_BAA70D43AB53970DDBF1921AD023C0", 0);
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1)
      var_115 = var_13[0];
    else if(var_83 == var_1)
      var_83 = var_13[0];

    vo_nag_mark_crates(var_1, var_14[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_14[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[0], undefined, var_1);
    vo_nag_mark_crates(var_1, var_115, undefined, var_94);
    vo_nag_mark_crates(var_1, var_83, undefined, var_94);
    wait 3;
    var_1 scripts\mp\juggernaut::jugg_makejuggernaut(level.juggksglobals.config);
    wait 3;
    var_94 dodamage(999, var_94.origin, var_94, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");

    while(isalive(var_1)) {
      var_1 dodamage(999, var_1.origin, var_1, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
      waitframe();
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_99B60D51E50864FBF3C3029888D8AB")) {
    setomnvar("_encstr_B17E1560778AD811ABBEEEE197316140CF437930C73491", 0);
    var_116 = var_1.origin;
    var_117 = var_1.angles;
    var_118 = 0;
    var_119 = 0;
    var_120 = 0;

    for(;;) {
      var_121 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_116 + (var_118, var_119, 0), var_117);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1", var_121);
      var_120++;
      var_118 = var_118 + 10;

      if(var_118 > 5000) {
        var_118 = 0;
        var_119 = var_119 + 10;

        if(var_119 > 100)
          var_119 = 0;
      }

      if(var_120 > 8) {
        waitframe();
        var_120 = 0;
      }
    }
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_96520C322D2B2AB7A57BDA98A559")) {
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1)
      var_115 = var_13[0];
    else if(var_83 == var_1)
      var_83 = var_13[0];

    kick(var_83 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    var_1 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12723(0);
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;
    var_115.br_infilstarted = 1;
    vo_nag_mark_crates(var_1, var_115, undefined, var_94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_977013D3EDB513B4B24D0EACD88EB03A9528D2B93B")) {
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1)
      var_115 = var_13[0];
    else if(var_83 == var_1)
      var_83 = var_13[0];

    kick(var_83 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    var_1 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12723(0);
    var_115 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12723(0);
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;
    var_122 = _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::spawndogtags();
    _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_id_13238(var_122, (0, 0, 200));

    for(var_123 = var_1 getnodeoffset_code(7); var_123 == -1; var_123 = var_1 getnodeoffset_code(7))
      waitframe();

    wait 2;
    var_115 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
    var_1 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::wait_for_chopper_boss_finish_turning(var_115);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_84F31691A81ACC3AB0683208606578B2EE5B1A33B3165322")) {
    setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 8);
    wait 5;
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1)
      var_115 = var_13[0];
    else if(var_83 == var_1)
      var_83 = var_13[0];

    kick(var_83 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    var_115 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12723(0);
    wait 2;
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;
    vo_nag_mark_crates(var_1, var_14[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_14[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_14[0], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[2], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[1], undefined, var_1);
    vo_nag_mark_crates(var_1, var_15[0], undefined, var_1);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_998209C225B213CE57D0A7")) {
    setDvar("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", -1);
    var_94 = var_14[0];
    var_115 = var_13[1];
    var_83 = var_13[2];

    if(var_115 == var_1)
      var_115 = var_13[0];
    else if(var_83 == var_1)
      var_83 = var_13[0];

    kick(var_83 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    vo_nag_mark_crates(var_1, var_115, undefined, var_94);
    var_1 scripts\engine\utility::waittill_notify_or_timeout("_encstr_84BC0E804AC539896F9D584D6683B1E1", 8);
    wait 2;
    var_1 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
    var_115 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagautowin("_encstr_9118045402B3", var_1, 0);
    vo_nag_mark_crates(var_1, var_1, undefined, var_94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AAC30AB5305BCD07EA295E4C")) {
    var_1 setOrigin((1710, -1703, 58));
    var_1 setplayerangles((19, 268, 0));
    waitframe();
    waitframe();

    while(!var_1 isthrowingbackgrenade())
      waitframe();

    wait 0.5;
    var_1 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_1298F(9);
    wait 0.5;
    var_124 = var_1 getcurrentprimaryweapon();

    if(var_124.basename != "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")
      var_1 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_1298F(9);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AA800F4A577399BE9738996F2BBD82CBF5")) {
    while(!var_1 isspectatingplayer())
      waitframe();

    var_26 = var_1 getspectatingplayer();
    wait 1;
    vo_nag_mark_crates(var_1, var_26, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A61208378DEDF85C2EC7")) {
    var_94 = var_14[0];
    var_94.br_infilstarted = 1;
    killplayer(var_1, var_94, var_15);
    var_115 = var_13[1];

    if(var_115 == var_1)
      var_115 = var_13[0];

    var_115.br_infilstarted = 1;
    killplayer(var_1, var_115, var_15);

    while(!istrue(var_94.gulagarena) || !istrue(var_115.gulagarena))
      waitframe();

    wait 5;
    killplayer(var_1, var_115, undefined, var_94);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_B1CC07A159364BB59D")) {
    var_26 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(!isDefined(var_26)) {
          var_26 = var_9;
          break;
        }
      }
    }

    wait 1;
    var_81 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"])) {
      var_80 = getarraykeys(level.vehicle.instances["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"]);

      if(var_80.size > 0)
        var_81 = level.vehicle.instances["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"][var_80[0]];
    }

    if(!isDefined(var_81)) {
      var_127 = spawnStruct();
      var_127.origin = (1000, -2000, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "_encstr_A390072B07566805D8";
      var_81 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_127);
    }

    var_82 = var_81 getlinkedscriptableinstance();
    var_26 setOrigin(var_81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "_encstr_BDDC07EBCCB5CA4BED", "_encstr_962F0CB3560DD236D8CAD7576E59", var_26, 0);
    wait 5;
    var_128 = "_encstr_977A0A6A3B6947CBAE9328F0";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_81, var_26);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_81, var_128, var_26);
    var_26 dodamage(500, var_14[0].origin, var_14[0], undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_AAE108481F244BF92292")) {
    wait 1;
    var_81 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"])) {
      var_80 = getarraykeys(level.vehicle.instances["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"]);

      if(var_80.size > 0)
        var_81 = level.vehicle.instances["_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F"][var_80[0]];
    }

    if(!isDefined(var_81)) {
      var_127 = spawnStruct();
      var_127.origin = (1000, -2000, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "_encstr_A390072B07566805D8";
      var_81 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_127);
    }

    var_82 = var_81 getlinkedscriptableinstance();
    var_1 setOrigin(var_81.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "_encstr_BDDC07EBCCB5CA4BED", "_encstr_962F0CB3560DD236D8CAD7576E59", var_1, 0);
    wait 5;
    var_128 = "_encstr_977A0A6A3B6947CBAE9328F0";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_81, var_1);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_81, var_128, var_1);

    if(!var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
      var_1 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

    var_1 dodamage(500, var_14[0].origin, var_14[0], undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_8B790885537F03075BCF")) {
    var_26 = undefined;

    foreach(var_9 in var_13) {
      if(var_9 != var_1) {
        if(!isDefined(var_26)) {
          var_26 = var_9;
          break;
        }
      }
    }

    wait 1;
    var_132 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["_encstr_BAC20FBEE6F88945F163A37BD68409923B"])) {
      var_80 = getarraykeys(level.vehicle.instances["_encstr_BAC20FBEE6F88945F163A37BD68409923B"]);

      if(var_80.size > 0)
        var_132 = level.vehicle.instances["_encstr_BAC20FBEE6F88945F163A37BD68409923B"][var_80[0]];
    }

    if(!isDefined(var_132)) {
      var_127 = spawnStruct();
      var_127.origin = (400, -2100, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "_encstr_A390072B07566805D8";
      var_132 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_127);
    }

    var_133 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B");

    foreach(var_129, var_135 in var_133._id_11FA5)
    var_133._id_11FA5[var_129] = 1.0;

    foreach(var_129, var_135 in var_133._id_11FA4)
    var_133._id_11FA4[var_129] = 500;

    var_82 = var_132 getlinkedscriptableinstance();
    var_26 setOrigin(var_132.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "_encstr_BDDC07EBCCB5CA4BED", "_encstr_962F0CB3560DD236D8CAD7576E59", var_26, 0);
    wait 5;
    var_137 = "_encstr_8D48079DD59BE65627";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_132, var_26);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_132, var_137, var_26);

    if(!var_26 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
      var_26 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

    var_26 dodamage(500, var_14[0].origin, var_14[0], undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_85ED090C9DD0A62F3161B7")) {
    wait 1;
    var_132 = undefined;
    var_82 = undefined;

    if(isDefined(level.vehicle.instances["_encstr_BAC20FBEE6F88945F163A37BD68409923B"])) {
      var_80 = getarraykeys(level.vehicle.instances["_encstr_BAC20FBEE6F88945F163A37BD68409923B"]);

      if(var_80.size > 0)
        var_132 = level.vehicle.instances["_encstr_BAC20FBEE6F88945F163A37BD68409923B"][var_80[0]];
    }

    if(!isDefined(var_132)) {
      var_127 = spawnStruct();
      var_127.origin = (400, -2100, 100);
      var_127.angles = (0, 0, 0);
      var_127.owner = var_1;
      var_127.spawntype = "_encstr_A390072B07566805D8";
      var_132 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle(var_127);
    }

    var_133 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B");

    foreach(var_129, var_135 in var_133._id_11FA5)
    var_133._id_11FA5[var_129] = 1.0;

    foreach(var_129, var_135 in var_133._id_11FA4)
    var_133._id_11FA4[var_129] = 500;

    var_82 = var_132 getlinkedscriptableinstance();
    var_1 setOrigin(var_132.origin);
    wait 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_scriptableused(var_82, "_encstr_BDDC07EBCCB5CA4BED", "_encstr_962F0CB3560DD236D8CAD7576E59", var_1, 0);
    wait 5;
    var_137 = "_encstr_8D48079DD59BE65627";
    var_129 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_132, var_1);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_132, var_137, var_1);

    if(!var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
      var_1 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

    for(var_140 = getdvarint("_encstr_B47F1002B14887937D2F13C77D9E8AFDA81B", 1); var_140 > 0; var_140--)
      waitframe();

    var_1 dodamage(500, var_14[0].origin, var_14[0], undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9", var_14[0] getcurrentprimaryweapon());
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_81240F95E1E8C4BA2F6B1BCA46ECD75813")) {
    setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 8);
    wait 5;
    var_26 = var_13[1];

    if(var_26 == var_1)
      var_26 = var_13[0];

    foreach(var_9 in var_13) {
      if(var_9 == var_1 || var_9 == var_26) {
        continue;
      }
      vo_nag_mark_crates(var_1, var_9, var_14);
    }

    foreach(var_9 in var_15)
    vo_nag_mark_crates(var_1, var_9, var_14);

    wait 2;
    vo_nag_mark_crates(var_1, var_1, var_14);
    var_1 waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
    wait 2;
    vo_nag_mark_crates(var_1, var_26, var_14);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_858E0AD75CFF9B9349B0F07C")) {
    setDvar("_encstr_AC2E0E31E47DB6B4DC07B1B02F9539B9", 8);
    wait 5;
    var_26 = var_13[1];

    if(var_26 == var_1)
      var_26 = var_13[0];

    var_94 = var_14[0];
    var_95 = var_15[0];

    foreach(var_33 in var_14) {
      if(var_33 == var_94) {
        continue;
      }
      vo_nag_mark_crates(var_1, var_33, undefined, var_1);
    }

    foreach(var_33 in var_15) {
      if(var_33 == var_95) {
        continue;
      }
      vo_nag_mark_crates(var_1, var_33, undefined, var_1);
    }

    foreach(var_62 in var_13) {
      if(var_62 == var_26 || var_62 == var_1) {
        continue;
      }
      kick(var_62 getentitynumber(), "_encstr_8A6D1DA2B0545E419828CA2A92D2528669A888FA24F4A27D481426289C8654");
    }

    wait 5;
    level thread vo_nag_mark_crates(var_1, var_94, undefined, var_1);
    level thread vo_nag_mark_crates(var_1, var_95, undefined, var_26);
  }

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_A3FF0BBE91BEC390EDFF8D413B")) {
    var_1 setOrigin((12799, 16985, 10014));
    var_1 setplayerangles((351, 35, 0));
    var_151 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_give_weapon();
    var_152 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", (23271, 24389, 13789), var_151, 0);
    var_74 = vectorNormalize(var_1 getEye() - var_152.origin);
    var_153 = vectortoangles(var_74);
    var_152.angles = var_153;
    var_152 setModel("_encstr_8849273B59D0BECD867D5BD263F585D2C9AF4616D8C143C2F5BBE9D7D1EAC9932BA37D581D1DB0C634");
    var_152 setmode("_encstr_BA7D0EF916AAA3692C479020EB7FA1E9");
    var_152 setsentryowner(undefined);
    var_152 makeunusable();
    var_152 setdefaultdroppitch(0);
    var_152 setturretmodechangewait(1);
    var_154 = 0;

    for(;;) {
      if(getdvarint("_encstr_AD750B35573BE1EE664760F077", 0)) {
        setDvar("_encstr_AD750B35573BE1EE664760F077", 0);
        var_154 = !var_154;
        var_152 unmarkkeyframedmover(var_154);
      }

      var_152 shootturret("_encstr_91E80B3A2CCE7D262C4E9359D8");
      waitframe();
    }
  }
}

_id_126B5() {
  var_0 = spawnStruct();
  var_0.scriptablename = "_encstr_B6CD1D26398DF67BD1BEDAD2361BCD47392B856DAF932BD8EDE623E4BDB9CA";
  var_0.count = 1;
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::takesuperpickup(var_0);
  wait 1;
  var_1 = getcompleteweaponname("_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1");
  scripts\mp\supers::trysuperusebegin(var_1);

  while(self getcurrentprimaryweapon().basename != "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E")
    waitframe();
}

_id_14366(var_0, var_1) {
  wait(var_0);
  var_1 suicide();
}

_id_12078() {
  level notify("_encstr_B1311872F0A9C509E7E84B38F006BE7C7049504083A0297556C5");
  level thread _id_12077();
  var_0 = undefined;

  if(!istrue(level.br_infils_disabled) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection())
    var_0 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path();

  waitframe();
  var_1 = 0;
  level.debugnextpropindex = 0;
  level.delay_music_reinforcements = 0;
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::clear_tier_lights(var_0, "_encstr_8BB007E03658CBCAE4");
  level thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::waittoplayinfildialog();
  level notify("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");
}

_id_12077() {
  var_0 = 1.4;
  level endon("_encstr_B1311872F0A9C509E7E84B38F006BE7C7049504083A0297556C5");

  if(!isDefined(level._id_136DE)) {
    level._id_136DE = 1;
    return;
  }

  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::resetalldoors(var_0 * 1.5);
  level thread scripts\cp\vehicles\little_bird_mg_cp::fulton_destroy(1);
  level thread _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::brvehicleonprematchstarted();
  level thread _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::onprematchdone();
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::has_focus_fire_objective();
  _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::emptyallvehicles();

  foreach(var_2 in level.players) {
    var_2 _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::setplayerprematchallows();
    var_2 thread _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::resetplayerinventory();

    if(istrue(var_2.hasspawned)) {
      if(istrue(var_2.usingascender))
        var_2 scripts\cp_mp\auto_ascender::canseesafecircleui();

      var_2 thread scripts\mp\weapons::deleteplacedequipment(1);
    }
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_2.burninginfo))
      var_2 scripts\mp\equipment\molotov::molotov_clear_burning();

    var_2 scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
  }

  level notify("_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");

  if(!istrue(level.br_circle_disabled))
    level thread _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_12E09(1);
}

_id_12F81(var_0, var_1) {
  if(!isDefined(level.br_circle.safecircleent)) {
    thread _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_12E09(1);
    level.br_circle thread _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::circledamagetick();
  }

  waitframe();
  level notify("_encstr_8F8F12E70303AAD5CD813BC52A860CFD427A3BC3");
  var_2 = 1;
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = var_2;
  var_3 = var_2 == 0;
  var_4 = var_2 == level.br_level.br_circleclosetimes.size - 1;
  var_5 = level.br_level.br_circledelaytimes[var_2];
  var_6 = level.br_level.br_circleclosetimes[var_2];
  var_7 = level.br_level.br_circleradii[var_2 + 1];
  setomnvar("_encstr_9561115DB4EB4CC9F56C9693B136CAF5DCBADA", var_2 + 1);
  level.br_circle.centertarget = var_0;
  level.br_circle.safecircleent.origin = var_0;
  level.br_circle.dangercircleui.hidden = 0;
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.safecircleent.hidden = 0;
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = var_0 + (0, 0, var_1);
  _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::setstaticuicircles(999, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_4);
  level notify("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
  waitframe();
  level notify("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD");
  level.br_circle.dangercircleent brcirclemoveTo(var_0[0], var_0[1], var_1, 1);
}

_id_126C5(var_0, var_1) {
  if(self calloutmarkerping_getEnt()) {
    self allowmovement(0);
    self allowfire(0);
    self allowmelee(0);
  }

  var_2 = self getentitynumber();

  if(isDefined(level.level_logic[var_2]))
    var_0 = level.level_logic[var_2];
  else {
    var_3 = anglesToForward((0, 0, 0));
    var_0 = var_0 + var_3 * (var_1 * 50);
    var_0 = getgroundposition(var_0, 15, 100);
  }

  self setOrigin(var_0);
  self setplayerangles((0, 0, 0));

  if(!isDefined(level.level_logic[var_2]))
    level.level_logic[var_2] = var_0;
}

killplayer(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = reset_button_handler(var_0, var_1.origin, var_2);

  var_1 dodamage(500, var_3.origin, var_3, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_3 getcurrentprimaryweapon());
  wait 1;

  while(isalive(var_1)) {
    var_1 dodamage(500, var_3.origin, var_3, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_3 getcurrentprimaryweapon());
    waitframe();
  }

  return var_3;
}

vo_nag_mark_crates(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = reset_button_handler(var_0, var_1.origin, var_2);

  if(!isDefined(var_3))
    var_3 = var_1;

  if(!istrue(var_4) && var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
    var_1 scripts\mp\utility\perk::removeperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

  while(isalive(var_1)) {
    var_1 dodamage(500, var_3.origin, var_3, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_3 getcurrentprimaryweapon());

    if(!isalive(var_1)) {
      break;
    }

    waitframe();
  }

  return var_3;
}

_id_1294D(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = reset_button_handler(var_0, var_1.origin, var_2);

  if(!isDefined(var_3))
    var_3 = var_1;

  if(!var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
    var_1 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

  while(!istrue(var_1.inlaststand)) {
    var_1 dodamage(30, var_3.origin, var_3, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_3 getcurrentprimaryweapon());
    wait 0.1;
  }

  return var_3;
}

reset_button_handler(var_0, var_1, var_2) {
  var_2 = sortbydistance(var_2, var_1);

  if(isalive(var_2[0])) {
    var_3 = distance2dsquared(var_1, var_2[0].origin);

    if(var_3 < 40000)
      return var_2[0];
  }

  var_4 = undefined;

  for(var_5 = 1; var_5 < var_2.size; var_5++) {
    var_6 = var_2[var_5];

    if(isalive(var_6)) {
      var_4 = var_6;
      break;
    }
  }

  return var_4;
}

remove_map_hint(var_0) {
  if(isDefined(level.level_offhand_spawn))
    return level.level_offhand_spawn;

  var_1 = scripts\mp\gamelogic::gethostplayer();

  if(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, "_encstr_B1210BCE21CB4A4EAB698FF7E0")) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && !var_3 calloutmarkerping_getEnt() && (!isDefined(var_1) || var_3 != var_1)) {
        var_1 = var_3;
        break;
      }
    }
  } else if(!isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(!isai(var_3) && !var_3 calloutmarkerping_getEnt()) {
        level.level_offhand_spawn = var_3;
        var_1 = var_3;
        break;
      }
    }
  } else
    level.maxteamsize = 3;

  if(!isDefined(level.level_offhand_spawn))
    level.level_offhand_spawn = var_1;

  return var_1;
}

calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}

_id_12D1C(var_0, var_1) {
  var_2 = level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"];
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!isalive(var_5) || var_5.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
      var_6 = var_5 getentitynumber();

      if(isDefined(level.level_logic[var_6])) {
        var_5.forcespawnangles = (0, 0, 0);
        var_5.forcespawnorigin = level.level_logic[var_6];
      } else {
        var_5.forcespawnangles = var_5.angles;
        var_5.forcespawnorigin = var_5.origin;
      }

      var_5 _id_13623(0);
      var_3 = 1;
    }

    if(istrue(var_5.delay_enter_combat_after_investigating_grenade))
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(var_5, "_encstr_85790BAB48AB010BBB5D27DE39");
  }

  if(var_3) {
    var_0 iprintlnbold("_encstr_8E7D104A599DD2ECB4B9B3808A2B2CADD102" + var_1);
    wait 1.0;
  }
}

run_current_spawn_group(var_0, var_1) {
  var_2 = 0;

  if(level.teamdata[var_1]["_encstr_AB580A05672AE35D5FFF50B8"] < level.maxteamsize)
    var_2 = level.maxteamsize - level.teamdata[var_1]["_encstr_AB580A05672AE35D5FFF50B8"];

  if(var_2 > 0) {
    level._id_11C84 = ::_id_13623;
    var_3 = level.players.size;
    addbots(var_2, var_1);
    var_0 iprintlnbold("_encstr_B2D6106953EFBFFD20AD1FA021B8C61FAAC1" + var_1);
    var_4 = gettime() + 10000;

    while(gettime() < var_4 && level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"] < level.maxteamsize)
      waitframe();

    level._id_11C84 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnclientbr;
  }

  return level.teamdata[var_1]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];
}

addbots(var_0, var_1) {
  setDvar("_encstr_9AD00BFD062950EAD45183FF81", "_encstr_A34C02BB");

  if(!isDefined(var_1))
    var_1 = "_encstr_8F4B0BD00FAC3813FB1A0B0435";

  level thread[[level.bot_funcs["_encstr_95D20BE6C869B3D7E3101F7FD8"]]](var_0, var_1);

  if(level.matchmakingmatch)
    setmatchdata("_encstr_99350889DF6B7E181CB2", 1);
}

_id_13623(var_0) {
  self.class = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1234A();
  self.pers["_encstr_959506B911C79707"] = self.class;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);
  waitframe();
  self skydive_setdeploymentstatus(0);
  self skydive_setbasejumpingstatus(0);
  var_1 = !self calloutmarkerping_getEnt();

  if(var_1) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist))
      waitframe();
  }

  self notify("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self.waitingtospawn = 0;
  self freezecontrols(0);
}

showsplash(var_0) {
  foreach(var_2 in level.players)
  var_2 scripts\mp\hud_message::showsplash(var_0);
}
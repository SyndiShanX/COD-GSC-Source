/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\ammorestock.gsc
***********************************************/

init() {
  if(!challengesenabled()) {
    return;
  }
  if(scripts\cp\utility::getgametype() == "_encstr_B607038AAB")
    level setupchallengelocales();
}

setupchallengelocales() {
  level.localetriggers = [];
  var_0 = getEntArray("_encstr_B66314EBA72963897D1FCFA3AD6AE9A3A857A22F77F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }
      switch (var_2.script_noteworthy) {
        case "_encstr_883009BD28232B4B688B98":
          var_2.localeid = 0;
          break;
        case "_encstr_A77808BB284B9F27D3C1":
          var_2.localeid = 1;
          break;
        case "_encstr_834E0AFD036B7C39A427F282":
          var_2.localeid = 2;
          break;
        case "_encstr_883E0978CAE2A1689B3161":
          var_2.localeid = 3;
          break;
        case "_encstr_A60108C05863AB184BF8":
          var_2.localeid = 4;
          break;
        case "_encstr_971804ED3712":
          var_2.localeid = 5;
          break;
        case "_encstr_97BC0AB9369358C15E859C8C":
          var_2.localeid = 6;
          break;
        case "_encstr_AFD40D24BE99C11BC3956F29C2B020":
          var_2.localeid = 7;
          break;
        case "_encstr_B49507136BBF0EA070":
          var_2.localeid = 8;
          break;
        case "_encstr_84850BABF3A1327598A8A4ED60":
          var_2.localeid = 9;
          break;
        case "_encstr_810D059BE07D8B":
          var_2.localeid = 10;
          break;
        case "_encstr_9B220634456A5747":
          var_2.localeid = 11;
          break;
      }
    }

    level.localetriggers = var_0;
  }
}

challengesenabled() {
  if(getdvarint("_encstr_B2EC17E2F865A6EF9E5D0113E701F36F97105AAA58135D63F3", 0) != 0)
    return 0;

  return level.challengesallowed;
}

challengesenabledforplayer() {
  if(!challengesenabled())
    return 0;

  if(!isPlayer(self) || isai(self))
    return 0;

  return 1;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0))
      var_1 = var_0;
    else
      return;
  }

  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_8)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_5);

    if(!isDefined(var_9))
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_5.basename);

    switch (var_9) {
      case "_encstr_84E81558CF28E6D952A6C1D5FC290BE9CA07B018070B5B":
      case "_encstr_9508192DEE707DB0239CB273851B2DDCCAF5B658C9DA9539D7B1C1":
      case "_encstr_B4E9147053F0F70EFB580FA689A0BB721C4F3B7918E1":
      case "_encstr_826813691C902EB9B0A5507FFF574ABB61A2B1EBA3":
        var_9 = "_encstr_92BC0F408BC20108238458CE67F3F6F32A";
        break;
      default:
        break;
    }

    var_10 = "_encstr_B40101";

    if(isDefined(var_1.secondaryweaponobj)) {
      if(var_5 == var_1.primaryweaponobj)
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
      else if(var_5 == var_1.secondaryweaponobj)
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);
    }

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_7)) {
      var_12 = var_7["_encstr_87A205AF10734B"];
      var_13 = var_7["_encstr_95A40617A8CBC38F"];
    }

    var_14 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15))
      var_15 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "_encstr_B40101";
    var_18 = 1;

    if(isDefined(var_5.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_5.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "_encstr_B8FB06FF97EA2708")
          var_19 = 1;

        if(scripts\cp\cp_weapon::carriedpunchcard(var_5, var_22)) {
          if(!var_18)
            var_17 = var_17 + "_encstr_854C021F";

          var_22 = scripts\cp\cp_weapon::_id_12BBB(var_22);
          var_17 = var_17 + var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18)
          var_17 = var_17 + "_encstr_854C021F";

        var_17 = var_17 + "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";
      }
    }

    var_24 = "_encstr_B40101";
    var_25 = 1;

    if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
      foreach(var_27 in var_1.classstruct.loadoutperks) {
        if(!var_25)
          var_24 = var_24 + "_encstr_854C021F";

        var_24 = var_24 + var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_2, 0];
    var_30 = 0;

    if(isPlayer(var_8))
      var_30 = var_30 | 1;
    else if(isagent(var_8))
      var_30 = _id_12CE0(var_30, var_8);

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_6)) {
      if(scripts\cp\utility::isheadshot(var_5, var_6, var_4, var_1))
        var_4 = "_encstr_87280E1FB705D168313D1FD197B1A799";
    }

    if(isDefined(var_8.streakinfo)) {
      var_30 = var_30 | 2;
      var_35 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_35);

      switch (var_35) {
        case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
        case "_encstr_B1B30B51D176511E377A1BC313":
        case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
        case "_encstr_8CC008133958C81BACCB":
        case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
          var_31 = 1;
          break;
        case "_encstr_B8BA05F06B9785":
        case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
        case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
        case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
        case "_encstr_8C980A867B3B569CFAA659E8":
        case "_encstr_86FD08B775CD07DC1338":
        case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
        case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
        case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
          var_32 = 1;
          break;
        case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
        case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
        case "_encstr_851904B59B34":
        case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
          var_32 = 1;
          var_33 = 1;
          break;
        case "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B":
        case "_encstr_BA67082278D537E3C827":
          var_33 = 1;
          break;
      }

      if(var_31)
        var_30 = var_30 | 8;

      if(var_32)
        var_30 = var_30 | 4;

      if(var_33)
        var_30 = var_30 | 16;
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 = var_30 | 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        var_30 = var_30 | 8;
    }

    if(isDefined(var_8.equipmentref))
      var_30 = var_30 | 64;

    var_36 = "_encstr_B40101";
    var_37 = 65535;
    var_38 = 65535;

    if(var_30 == 512)
      vehicle_occupancy_canspawninto(var_1, var_8, var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, var_4, var_37, var_38);
    else {
      var_39 = level.players.size;

      if(istrue(level.matchmakingmatch)) {
        var_40 = var_1 getfireteammembers();
        var_39 = var_40.size;
      }

      var_1 reportchallengeuserevent("_encstr_ABD70578F3D02C", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, gettouchinglocaletriggers(var_1, var_8), var_4, var_37, var_38, var_39);
    }
  }
}

_id_12CE0(var_0, var_1) {
  var_2 = var_1.aitype;

  if(!isDefined(var_1.aitype)) {
    if(isDefined(var_1.unittype))
      var_2 = var_1.unittype;
  }

  switch (var_2) {
    case "_encstr_958C08CDDBD8325A959C":
      var_0 = var_0 | 128;
      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      var_0 = var_0 | 512;
      break;
    case "_encstr_8EF60E63FBE3D70440A312175B98CF6B":
      var_0 = var_0 | 1024;
      break;
    case "_encstr_A5450BC280BF4B604068C33187":
      var_0 = var_0 | 256;
      break;
    default:
      var_0 = var_0 | 128;
      break;
  }

  return var_0;
}

vehicle_occupancy_canspawninto(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(var_10 != 512)
    return 0;

  if(isDefined(var_1.attackers)) {
    foreach(var_16 in var_1.attackers) {
      if(!isDefined(scripts\cp\cp_agent_damage::_validateattacker(var_16))) {
        continue;
      }
      if(var_1 == var_16) {
        continue;
      }
      if(isDefined(level.assists_disabled)) {
        continue;
      }
      var_17 = undefined;

      if(isDefined(var_1.attackerdata)) {
        var_18 = var_1.attackerdata[var_16.guid];

        if(isDefined(var_18))
          var_17 = var_18.objweapon;
      }

      var_19 = 0;

      if(self.attackerdata[var_16.guid].damage >= var_1.maxhealth * 0.1)
        var_19 = 1;

      if(self.attackerdata[var_16.guid].damage >= var_1.maxhealth * 0.2)
        var_19 = 2;

      if(var_19 >= 1) {
        var_20 = level.players.size;

        if(istrue(level.matchmakingmatch)) {
          var_21 = var_0 getfireteammembers();
          var_20 = var_21.size;
        }

        var_16 reportchallengeuserevent("_encstr_ABD70578F3D02C", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, gettouchinglocaletriggers(var_0, var_1), var_12, var_13, var_14, var_20);
      }
    }

    return 1;
  }

  return 0;
}

ondeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("_encstr_AD75063D571AE108", 0);
}

onplayerkillassist(var_0) {
  var_1 = self;

  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_0)) {
    var_2 = "_encstr_B40101";

    if(isDefined(var_1.primaryweaponobj))
      var_2 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);

    var_3 = "_encstr_B40101";

    if(isDefined(var_1.secondaryweaponobj))
      var_3 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);

    var_4 = [var_2, var_3];
    var_5 = [0, 0];
    var_6 = 0;

    if(isPlayer(var_0))
      var_6 = var_6 | 1;
    else if(isagent(var_0))
      var_6 = _id_12CE0(var_6, var_0);

    var_7 = var_1 resetstuckthermite();
    var_1 reportchallengeuserevent("_encstr_A1BD075837DCD29B47", var_5, var_4, var_7);
  }
}

_id_1204A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_7 = var_0;
  var_8 = var_1;
  var_9 = var_2;
  var_10 = var_3;
  var_11 = var_4;
  var_12 = var_5;
  var_13 = var_6;
  var_14 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();

  switch (var_7) {
    case "_encstr_85BE135AE8D73BAFF1650F290D7BBF85D3606202F8":
    case "_encstr_833E161E3A771BEE7892672CBBE7AABF9985398A03D92185":
    case "_encstr_ABBB0EB1C1F5AE375946EB5893D67B39":
    case "_encstr_84791320FB679BD77A3FB0A755D22706831BC81037":
      var_7 = "_encstr_92BC0F408BC20108238458CE67F3F6F32A";

      if(var_10 == 0)
        var_10++;

      break;
    default:
      break;
  }

  var_15 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_86860FAD4B1B369B8EC9AC0BB5D7B2E623", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
}

_id_12033(var_0, var_1) {
  var_2 = var_0;

  if(var_0 == "_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA" && isDefined(self.recondronesuper)) {
    if(isDefined(self.recondronesuper._id_1406B))
      var_1 = self.recondronesuper._id_1406B;
  }

  scripts\cp\vehicles\vehicle_compass_cp::_id_12032(var_0, var_1);
}

_id_12032(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = var_0;
  var_3 = var_1;
  self reportchallengeuserevent("_encstr_8AC20AE97C4D481DC1AF9D81", var_2, var_3);
}

_id_12003(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["_encstr_87A205AF10734B"];
    var_2 = var_0["_encstr_95A40617A8CBC38F"];
  }

  var_3 = scripts\cp\utility::getgametype();

  if(!isDefined(var_3))
    var_3 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

  var_4 = level.getallselectableattachments.game_type_col[var_3];
  self reportchallengeuserevent("_encstr_95EB0866891B23FB85B3", var_4, var_1, var_2);
}

_id_1201F(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["_encstr_87A205AF10734B"];
    var_2 = var_0["_encstr_95A40617A8CBC38F"];
  }

  var_3 = scripts\cp\utility::getgametype();

  if(!isDefined(var_3))
    var_3 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

  var_4 = level.getallselectableattachments.game_type_col[var_3];
  self reportchallengeuserevent("_encstr_830C078CCA33ABB959", var_4, var_1, var_2);
}

_id_12062(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["_encstr_87A205AF10734B"];
    var_2 = var_0["_encstr_95A40617A8CBC38F"];
  }

  var_3 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("_encstr_830C078CCA33ABB959", var_3, var_1, var_2, var_4);
}

_id_12096(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("_encstr_9B1905D3B92BF0", var_0);
}

_id_12092(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("_encstr_BA19058303338D", var_0);
}

_id_1203D(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = "_encstr_B40101";
  var_2 = 1;

  if(isDefined(self.classstruct) && isDefined(self.classstruct.loadoutperks)) {
    foreach(var_4 in self.classstruct.loadoutperks) {
      if(!var_2)
        var_1 = var_1 + "_encstr_854C021F";

      var_1 = var_1 + var_4;
      var_2 = 0;
    }
  }

  self reportchallengeuserevent("_encstr_95CC050D168DDA", var_0, var_1);
}

gettouchinglocaletriggers(var_0, var_1) {
  var_2 = "_encstr_B40101";

  if(!isDefined(level.localetriggers))
    return var_2;

  var_3 = 0;

  foreach(var_5 in level.localetriggers) {
    if(var_0 istouching(var_5) || var_1 istouching(var_5)) {
      if(isDefined(var_5.localeid)) {
        if(var_3)
          var_2 = var_2 + "_encstr_854C021F";

        var_2 = var_2 + var_5.localeid;
        var_3 = 1;
      }
    }
  }

  return var_2;
}

onplayerteamrevive(var_0, var_1) {}

onsuccessfulhit(var_0) {}

onspawn() {}

updatesuperweaponkills(var_0, var_1) {}

updatesuperkills(var_0, var_1, var_2) {}

resistedstun(var_0) {}

triggereddelayedexplosion() {}

minedestroyed(var_0, var_1, var_2) {}

roundbegin() {}

roundend(var_0) {}

playerdamaged(var_0, var_1, var_2, var_3, var_4, var_5) {}

processuavassist(var_0, var_1) {}

killstreakdamaged(var_0, var_1, var_2, var_3, var_4) {}

killstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!var_3 challengesenabledforplayer()) {
    return;
  }
  var_8 = self;

  if(!isPlayer(var_3)) {
    return;
  }
  if(!isDefined(var_8.owner)) {
    return;
  }
  if(!scripts\cp\utility\player::isfriendly(var_3.team, var_8.owner)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_6);

    if(!isDefined(var_9))
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_6.basename);

    var_10 = "_encstr_B40101";

    if(isDefined(var_3.secondaryweaponobj)) {
      if(var_6 == var_3.primaryweaponobj)
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_3.secondaryweaponobj.basename);
      else if(var_6 == var_3.secondaryweaponobj)
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_3.primaryweaponobj.basename);
    }

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_3.modifiers)) {
      var_12 = var_3.modifiers["_encstr_87A205AF10734B"];
      var_13 = var_3.modifiers["_encstr_95A40617A8CBC38F"];
    }

    var_14 = [var_3 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_3.team), var_3 scripts\cp\survival\survival_loadout::lookupotheroperator(var_3.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15))
      var_15 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "_encstr_B40101";
    var_18 = 1;

    if(isDefined(var_6.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_6.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "_encstr_B8FB06FF97EA2708")
          var_19 = 1;

        if(scripts\cp\cp_weapon::carriedpunchcard(var_6, var_22)) {
          if(var_22 == "_encstr_B8FB06FF97EA2708")
            var_22 = "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";

          if(!var_18)
            var_17 = var_17 + "_encstr_854C021F";

          var_22 = scripts\cp\cp_weapon::_id_12BBB(var_22);
          var_17 = var_17 + var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18)
          var_17 = var_17 + "_encstr_854C021F";

        var_17 = var_17 + "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";
      }
    }

    var_24 = "_encstr_B40101";
    var_25 = 1;

    if(isDefined(var_3.classstruct) && isDefined(var_3.classstruct.loadoutperks)) {
      foreach(var_27 in var_3.classstruct.loadoutperks) {
        if(!var_25)
          var_24 = var_24 + "_encstr_854C021F";

        var_24 = var_24 + var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_4, 0];
    var_30 = 0;

    if(isPlayer(var_8))
      var_30 = var_30 | 1;
    else if(isagent(var_8))
      var_30 = _id_12CE0(var_30, var_8);

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_8.streakinfo)) {
      var_30 = var_30 | 2;
      var_0 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_0);

      switch (var_0) {
        case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
        case "_encstr_B1B30B51D176511E377A1BC313":
        case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
        case "_encstr_8CC008133958C81BACCB":
        case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
          var_31 = 1;
          break;
        case "_encstr_B8BA05F06B9785":
        case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
        case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
        case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
        case "_encstr_8C980A867B3B569CFAA659E8":
        case "_encstr_86FD08B775CD07DC1338":
        case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
        case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
        case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
          var_32 = 1;
          break;
        case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
        case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
        case "_encstr_851904B59B34":
        case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
          var_32 = 1;
          var_33 = 1;
          break;
        case "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B":
        case "_encstr_BA67082278D537E3C827":
          var_33 = 1;
          break;
      }

      if(var_31)
        var_30 = var_30 | 8;

      if(var_32)
        var_30 = var_30 | 4;

      if(var_33)
        var_30 = var_30 | 16;
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 = var_30 | 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        var_30 = var_30 | 8;
    }

    if(isDefined(var_8.equipmentref))
      var_30 = var_30 | 64;

    var_35 = "_encstr_B40101";
    var_3 reportchallengeuserevent("_encstr_ABD70578F3D02C", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_35, gettouchinglocaletriggers(var_3, var_8));
  }
}

unsetreduceregendelayonkill(var_0) {
  switch (var_0) {
    case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return 0;
  }

  return 1;
}

equipmentdestroyed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0))
      var_1 = var_0;
    else
      return;
  }

  if(!isDefined(var_8.owner)) {
    return;
  }
  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_8.owner)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_5);

    if(!isDefined(var_9))
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_5.basename);

    var_10 = "_encstr_B40101";

    if(var_5 == var_1.primaryweaponobj)
      var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
    else if(var_5 == var_1.secondaryweaponobj)
      var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_7)) {
      var_12 = var_7["_encstr_87A205AF10734B"];
      var_13 = var_7["_encstr_95A40617A8CBC38F"];
    }

    var_14 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15))
      var_15 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "_encstr_B40101";
    var_18 = 1;

    if(isDefined(var_5.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_5.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "_encstr_B8FB06FF97EA2708")
          var_19 = 1;

        if(scripts\cp\cp_weapon::carriedpunchcard(var_5, var_22)) {
          if(!var_18)
            var_17 = var_17 + "_encstr_854C021F";

          var_22 = scripts\cp\cp_weapon::_id_12BBB(var_22);
          var_17 = var_17 + var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18)
          var_17 = var_17 + "_encstr_854C021F";

        var_17 = var_17 + "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";
      }
    }

    var_24 = "_encstr_B40101";
    var_25 = 1;

    if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
      foreach(var_27 in var_1.classstruct.loadoutperks) {
        if(!var_25)
          var_24 = var_24 + "_encstr_854C021F";

        var_24 = var_24 + var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_2, 0];
    var_30 = 0;

    if(isPlayer(var_8))
      var_30 = var_30 | 1;
    else if(isagent(var_8))
      var_30 = _id_12CE0(var_30, var_8);

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_8.streakinfo)) {
      var_30 = var_30 | 2;
      var_35 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_35);

      switch (var_35) {
        case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
        case "_encstr_B1B30B51D176511E377A1BC313":
        case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
        case "_encstr_8CC008133958C81BACCB":
        case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
          var_31 = 1;
          break;
        case "_encstr_B8BA05F06B9785":
        case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
        case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
        case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
        case "_encstr_8C980A867B3B569CFAA659E8":
        case "_encstr_86FD08B775CD07DC1338":
        case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
        case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
        case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
          var_32 = 1;
          break;
        case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
        case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
        case "_encstr_851904B59B34":
        case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
          var_32 = 1;
          var_33 = 1;
          break;
        case "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B":
        case "_encstr_BA67082278D537E3C827":
          var_33 = 1;
          break;
      }

      if(var_31)
        var_30 = var_30 | 8;

      if(var_32)
        var_30 = var_30 | 4;

      if(var_33)
        var_30 = var_30 | 16;
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 = var_30 | 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        var_30 = var_30 | 8;
    }

    if(isDefined(var_8.equipmentref))
      var_30 = var_30 | 64;

    var_36 = "_encstr_B40101";
    var_1 reportchallengeuserevent("_encstr_ABD70578F3D02C", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, gettouchinglocaletriggers(var_1, var_8));
  }
}

vehiclekilled(var_0, var_1, var_2, var_3) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_4 = var_0;
  var_5 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_3);

  if(!isDefined(var_5))
    var_5 = scripts\cp\utility::relic_nuketimer_globalthread(var_3.basename);

  var_6 = "_encstr_B40101";

  if(var_3 == var_1.primaryweaponobj)
    var_6 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
  else if(var_3 == var_1.secondaryweaponobj)
    var_6 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);

  var_7 = [var_5, var_6];
  var_8 = 0;
  var_9 = 0;

  if(isDefined(var_1.modifiers)) {
    var_8 = var_1.modifiers["_encstr_87A205AF10734B"];
    var_9 = var_1.modifiers["_encstr_95A40617A8CBC38F"];
  }

  var_10 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
  var_11 = scripts\cp\utility::getgametype();

  if(!isDefined(var_11))
    var_11 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

  var_12 = level.getallselectableattachments.game_type_col[var_11];
  var_13 = "_encstr_B40101";
  var_14 = 1;

  if(isDefined(var_3.attachments)) {
    var_15 = 0;

    foreach(var_17 in var_3.attachments) {
      var_18 = scripts\cp\utility::attachmentmap_tobase(var_17);

      if(var_18 == "_encstr_B8FB06FF97EA2708")
        var_15 = 1;

      if(scripts\cp\cp_weapon::carriedpunchcard(var_3, var_18)) {
        if(var_18 == "_encstr_B8FB06FF97EA2708")
          var_18 = "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";

        if(!var_14)
          var_13 = var_13 + "_encstr_854C021F";

        var_18 = scripts\cp\cp_weapon::_id_12BBB(var_18);
        var_13 = var_13 + var_18;
        var_14 = 0;
      }
    }

    if(var_15) {
      if(!var_14)
        var_13 = var_13 + "_encstr_854C021F";

      var_13 = var_13 + "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";
    }
  }

  var_20 = "_encstr_B40101";
  var_21 = 1;

  if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
    foreach(var_23 in var_1.classstruct.loadoutperks) {
      if(!var_21)
        var_20 = var_20 + "_encstr_854C021F";

      var_20 = var_20 + var_23;
      var_21 = 0;
    }
  }

  var_25 = [var_2, 0];
  var_26 = 0;

  if(isPlayer(var_4))
    var_26 = var_26 | 1;
  else if(isagent(var_4))
    var_26 = _id_12CE0(var_26, var_4);

  var_27 = 0;
  var_28 = 0;
  var_29 = 0;
  var_30 = 0;

  if(isDefined(var_4.streakinfo)) {
    var_26 = var_26 | 2;
    var_31 = var_4.streakinfo.streakname;
    var_30 = unsetreduceregendelayonkill(var_31);

    switch (var_31) {
      case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
      case "_encstr_B1B30B51D176511E377A1BC313":
      case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      case "_encstr_8CC008133958C81BACCB":
      case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
        var_27 = 1;
        break;
      case "_encstr_B8BA05F06B9785":
      case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
      case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
      case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      case "_encstr_8C980A867B3B569CFAA659E8":
      case "_encstr_86FD08B775CD07DC1338":
      case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
      case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
      case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
        var_28 = 1;
        break;
      case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
      case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
      case "_encstr_851904B59B34":
      case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
        var_28 = 1;
        var_29 = 1;
        break;
      case "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B":
      case "_encstr_BA67082278D537E3C827":
        var_29 = 1;
        break;
    }

    if(var_27)
      var_26 = var_26 | 8;

    if(var_28)
      var_26 = var_26 | 4;

    if(var_29)
      var_26 = var_26 | 16;
  }

  if(isDefined(var_4.vehiclename) || var_30) {
    var_26 = var_26 | 32;

    if(!var_27 && isDefined(var_4.vehiclename) && !istrue(var_4 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
      var_26 = var_26 | 8;
  }

  if(isDefined(var_4.equipmentref))
    var_26 = var_26 | 64;

  var_32 = "_encstr_B40101";
  var_1 reportchallengeuserevent("_encstr_ABD70578F3D02C", var_25, var_7, var_8, var_9, var_10, var_12, var_13, var_20, var_26, var_32, gettouchinglocaletriggers(var_1, var_4));
}

processfinalkillchallenges(var_0, var_1) {}

usedkillstreak(var_0) {}

resetstuckthermite() {
  var_0 = [];
  var_0[0] = scripts\cp\survival\survival_loadout::lookupcurrentoperator(self.team);
  var_0[1] = scripts\cp\survival\survival_loadout::lookupotheroperator(self.team);
  return var_0;
}

_id_12071(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0))
      var_1 = var_0;
    else
      return;
  }

  if(!scripts\cp\utility\player::isfriendly(var_1.team, var_8)) {
    var_9 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_5);

    if(!isDefined(var_9))
      var_9 = scripts\cp\utility::relic_nuketimer_globalthread(var_5.basename);

    var_10 = "_encstr_B40101";

    if(isDefined(var_1.secondaryweaponobj)) {
      if(var_5 == var_1.primaryweaponobj)
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.secondaryweaponobj.basename);
      else if(var_5 == var_1.secondaryweaponobj)
        var_10 = scripts\cp\utility::relic_nuketimer_globalthread(var_1.primaryweaponobj.basename);
    }

    var_11 = [var_9, var_10];
    var_12 = 0;
    var_13 = 0;

    if(isDefined(var_7)) {
      var_12 = var_7["_encstr_87A205AF10734B"];
      var_13 = var_7["_encstr_95A40617A8CBC38F"];
    }

    var_14 = [var_1 scripts\cp\survival\survival_loadout::lookupcurrentoperator(var_1.team), var_1 scripts\cp\survival\survival_loadout::lookupotheroperator(var_1.team)];
    var_15 = scripts\cp\utility::getgametype();

    if(!isDefined(var_15))
      var_15 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

    var_16 = level.getallselectableattachments.game_type_col[var_15];
    var_17 = "_encstr_B40101";
    var_18 = 1;

    if(isDefined(var_5.attachments)) {
      var_19 = 0;

      foreach(var_21 in var_5.attachments) {
        var_22 = scripts\cp\utility::attachmentmap_tobase(var_21);

        if(var_22 == "_encstr_B8FB06FF97EA2708")
          var_19 = 1;

        if(scripts\cp\cp_weapon::carriedpunchcard(var_5, var_22)) {
          if(!var_18)
            var_17 = var_17 + "_encstr_854C021F";

          var_22 = scripts\cp\cp_weapon::_id_12BBB(var_22);
          var_17 = var_17 + var_22;
          var_18 = 0;
        }
      }

      if(var_19) {
        if(!var_18)
          var_17 = var_17 + "_encstr_854C021F";

        var_17 = var_17 + "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";
      }
    }

    var_24 = "_encstr_B40101";
    var_25 = 1;

    if(isDefined(var_1.classstruct) && isDefined(var_1.classstruct.loadoutperks)) {
      foreach(var_27 in var_1.classstruct.loadoutperks) {
        if(!var_25)
          var_24 = var_24 + "_encstr_854C021F";

        var_24 = var_24 + var_27;
        var_25 = 0;
      }
    }

    var_29 = [var_2, 0];
    var_30 = 0;

    if(isPlayer(var_8))
      var_30 = var_30 | 1;
    else if(isagent(var_8))
      var_30 = _id_12CE0(var_30, var_8);

    var_31 = 0;
    var_32 = 0;
    var_33 = 0;
    var_34 = 0;

    if(isDefined(var_8.streakinfo)) {
      var_30 = var_30 | 2;
      var_35 = var_8.streakinfo.streakname;
      var_34 = unsetreduceregendelayonkill(var_35);

      switch (var_35) {
        case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
        case "_encstr_B1B30B51D176511E377A1BC313":
        case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
        case "_encstr_8CC008133958C81BACCB":
        case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
          var_31 = 1;
          break;
        case "_encstr_B8BA05F06B9785":
        case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
        case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
        case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
        case "_encstr_8C980A867B3B569CFAA659E8":
        case "_encstr_86FD08B775CD07DC1338":
        case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
        case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
        case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
          var_32 = 1;
          break;
        case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
        case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
        case "_encstr_851904B59B34":
        case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
          var_32 = 1;
          var_33 = 1;
          break;
        case "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B":
        case "_encstr_BA67082278D537E3C827":
          var_33 = 1;
          break;
      }

      if(var_31)
        var_30 = var_30 | 8;

      if(var_32)
        var_30 = var_30 | 4;

      if(var_33)
        var_30 = var_30 | 16;
    }

    if(isDefined(var_8.vehiclename) || var_34) {
      var_30 = var_30 | 32;

      if(!var_31 && isDefined(var_8.vehiclename) && !istrue(var_8 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        var_30 = var_30 | 8;
    }

    if(isDefined(var_8.equipmentref))
      var_30 = var_30 | 64;

    var_36 = "_encstr_B40101";
    var_1 reportchallengeuserevent("_encstr_ABD70578F3D02C", var_29, var_11, var_12, var_13, var_14, var_16, var_17, var_24, var_30, var_36, gettouchinglocaletriggers(var_1, var_8));
  }
}
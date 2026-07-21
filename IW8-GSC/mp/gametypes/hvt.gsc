/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\hvt.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8D110DCAB7E1501459D3B2418BD9FF";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A2660AB0527D4F23CFCC8D71";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_BA13136BDE7AF13B73CB9FF3B7BB6D5812B7D10342", getmatchrulesdata("_encstr_8CE20834E3886C3225DB", "_encstr_B49D0EFB538B53E9B8EBB8383FFD0367"));
  setdynamicdvar("_encstr_A7B615FBA1F6AFCC6809B7933B8013CF1E992142E8CD1F", getmatchrulesdata("_encstr_8CE20834E3886C3225DB", "_encstr_87AA1060E5A8DE972F93730B9914CF4DC8BB"));
  setdynamicdvar("_encstr_B2AF110E512049EFF7D29830EE010773889B8D", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("_encstr_8CEB103FBB4A29744FE356BB8B1F21F06715", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  initspawns();
  _encstr_91E429B96CE4A5078E6E795BE0E5B358DA563ACB1CAC6EF2139CC2238DAC2FBEE6072C7773954E17D9376C::inittankspawns();
  level.activehvts = [];
  thread watchhvts();
}

resethvtstatus() {
  if(scripts\engine\utility::array_contains(level.activehvts, self))
    level.activehvts = scripts\engine\utility::array_remove(level.activehvts, self);
}

laststand_hack() {
  returnheadicons();
  level.activehvts = scripts\engine\utility::array_remove(level.activehvts, self);
  self setclientomnvar("_encstr_87630EBA2DF543EC3AFA9BD1851DD5E6", 0);
  thread showvalueincreasesplash("_encstr_99EB11A2CB032F6E5148AFC1183BC0A883A351");
  scripts\mp\rank::scoreeventpopup("_encstr_A1DD0C21154328B1D520C8D3DFFF");
}

_id_134D4(var_0, var_1) {
  if(var_0.tagscarried == var_1.tagscarried) {
    var_2 = scripts\engine\utility::array_contains(level.activehvts, var_0);
    return var_2;
  } else
    return var_0.tagscarried > var_1.tagscarried;
}

_id_13A27() {
  self setclientomnvar("_encstr_8A960D4DD7D1F8334B5ECE69296503", self.tagscarried);
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.team == "_encstr_9A8507BA4040188D08") {
      var_0 = var_0 + var_3.tagscarried;
      continue;
    }

    if(var_3.team == "_encstr_8E8405EA382B2A")
      var_1 = var_1 + var_3.tagscarried;
  }

  scripts\mp\gamescore::_setteamscore("_encstr_9A8507BA4040188D08", var_0);
  scripts\mp\gamescore::_setteamscore("_encstr_8E8405EA382B2A", var_1);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.hvtcapturevalue = scripts\mp\utility\dvars::dvarintvalue("_encstr_87AA1060E5A8DE972F93730B9914CF4DC8BB", 5, 0, 50);
  level.hvtmaxtargets = scripts\mp\utility\dvars::dvarintvalue("_encstr_B49D0EFB538B53E9B8EBB8383FFD0367", 3, 1, 10);

  if(getmaxclients() < 21)
    level.hvtmaxtargets = 1;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(isDefined(level.localeid))
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_973807485A3B8A88D4", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");

  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_2);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_3);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C");
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
  }

  return var_2;
}

showvalueincreasesplash(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    return;
  }
  thread scripts\mp\hud_message::showsplash(var_0, var_1);
}

ishvt() {
  if(!isDefined(level.activehvts))
    return 0;

  return scripts\engine\utility::array_contains(level.activehvts, self);
}

becomehvt() {
  if(!isDefined(self.objidnumfriend))
    addhvtheadicons();

  thread showvalueincreasesplash("_encstr_8F3F0E0C43A3D9EB28377B8F07D2EE1B", 1);
  scripts\mp\rank::scoreeventpopup("_encstr_99120B53257BD833919FAB68FB");
  self setclientomnvar("_encstr_87630EBA2DF543EC3AFA9BD1851DD5E6", 1);
  scripts\mp\utility\outline::_hudoutlineviewmodelenable("_encstr_AA2E1BE85B7C68BBF28FEDFB83FAE8200F77D18383D83960CB87C5FFDF", 0);
  level.activehvts[level.activehvts.size] = self;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(ishvt())
    var_1 scripts\mp\rank::scoreeventpopup("_encstr_ABD209607C101FA7481923");

  var_10 = self getentitynumber();

  if(isDefined(level.outlinedplayers[var_10])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[var_10] = undefined;
  }

  if(self.team == "_encstr_9A8507BA4040188D08" || self.team == "_encstr_8E8405EA382B2A")
    scripts\mp\gamescore::giveteamscoreforobjective(self.team, self.tagscarried * -1);
}

returnheadicons() {
  if(isDefined(self.objidnumfriend)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnumfriend);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnumenemy);
    self.objidnumfriend = undefined;
    self.objidnumenemy = undefined;
    scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }
}

ontimelimit() {
  var_0 = scripts\mp\gamescore::gethighestscoringteam();

  if(game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08")
    var_0 = "_encstr_91AB08AC45BB5539F95B";
  else if("_encstr_8D19048EA595")
    var_0 = "_encstr_8B6D0940CC35339149DA08";

  thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

onplayerspawned() {
  self.tagscarried = 0;

  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B")) {
    if(var_1 != self && isDefined(var_1.objidnumfriend))
      objective_addclienttomask(var_1.objidnumfriend, self);
  }

  if(ishvt())
    laststand_hack();
}

onplayerdisconnect(var_0) {
  var_0 resethvtstatus();
  var_0 returnheadicons();
}

watchhvts() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.outlinedplayers = [];

  for(;;) {
    var_0 = scripts\engine\utility::array_sort_with_func(level.players, ::_id_134D4);
    var_1 = int(min(var_0.size, level.hvtmaxtargets));
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(!var_4 ishvt() && var_4.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_4.tagscarried >= 10) {
        var_4 becomehvt();
        var_4.vehicle_occupancy_mp_showcashbag = 1;
      }

      var_2++;

      if(var_2 == level.hvtmaxtargets) {
        break;
      }
    }

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(var_4 ishvt()) {
        if(isDefined(var_4.vehicle_occupancy_mp_showcashbag)) {
          var_4.vehicle_occupancy_mp_showcashbag = undefined;
          var_1--;
          continue;
        }

        if(var_1 > 0) {
          var_1--;
          continue;
        }

        var_4 laststand_hack();
      }
    }

    foreach(var_6 in level.players) {
      var_7 = var_6 getentitynumber();
      var_8 = var_6.pers["_encstr_8AEF05472BC2D6"];

      if(var_8 == "_encstr_9A8507BA4040188D08")
        var_9 = "_encstr_8E8405EA382B2A";
      else
        var_9 = "_encstr_9A8507BA4040188D08";

      if(isalive(var_6) && istrue(var_6 ishvt())) {
        if(!isDefined(level.outlinedplayers[var_7])) {
          level.outlinedplayers[var_7] = var_6;
          var_6.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(var_6, var_8, "_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
          var_6.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(var_6, var_9, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
        }

        continue;
      }

      if(isDefined(level.outlinedplayers[var_7])) {
        scripts\mp\utility\outline::outlinedisable(var_6.outlineidfriend, var_6);
        scripts\mp\utility\outline::outlinedisable(var_6.outlineidenemy, var_6);
        var_6.outlineidfriend = undefined;
        var_6.outlineidenemy = undefined;
        level.outlinedplayers[var_7] = undefined;
      }
    }

    waitframe();
  }
}

addhvtheadicons() {
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 24);
  self.objidnumfriend = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_0 = self.objidnumfriend;
  objective_setzoffset(var_0, 90);
  objective_icon(var_0, "_encstr_84B31E1ABA46BE968DB7B9AF9927DBE63A8DD23795EB9BA14BAC6391BE349DA3");
  objective_setplayintro(var_0, 1);
  objective_removeallfrommask(var_0);

  foreach(var_2 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B")) {
    if(var_2 != self)
      objective_addclienttomask(var_0, var_2);
  }

  objective_showtoplayersinmask(var_0);
  objective_setbackground(var_0, 0);
  objective_position(var_0, self getEye() + self.offset3d);
  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
  objective_setownerteam(var_0, self.team);
  self.objidnumenemy = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_0 = self.objidnumenemy;
  objective_setzoffset(var_0, 90);
  objective_icon(var_0, "_encstr_B4291521350731F336881D1031EF0693D3CF806BD7933D");
  objective_setplayintro(var_0, 1);
  scripts\mp\objidpoolmanager::objective_teammask_single(var_0, scripts\mp\utility\game::getotherteam(self.team)[0]);
  objective_setownerteam(var_0, self.team);
  objective_setbackground(var_0, 0);
  objective_position(var_0, self getEye() + self.offset3d);
  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
  thread updatetargetlocation();
}

updatetargetlocation() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_950E1393553A0BC82BAFDD3F6C4B6BCF6590C27803");
  self endon("_encstr_950E1393553A0BC82BAFDD3F6C4B6BCF6590C27803");

  if(!isDefined(level.objpingdelay))
    level.objpingdelay = 3.0;

  for(;;) {
    if(!isDefined(self.objidnumfriend)) {
      return;
    }
    if(self.health > 0) {
      var_0 = self getEye() + self.offset3d;
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnumfriend, var_0);
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnumenemy, var_0);
      objective_ping(self.objidnumfriend);
      objective_ping(self.objidnumenemy);
    } else
      returnheadicons();

    waitframe();
  }
}

revivetriggerspawned() {}
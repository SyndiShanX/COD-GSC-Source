/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\teamrevive.gsc
***********************************************/

init() {
  level.onteamchangedeath = ::onteamchangedeath;
  level.revivetriggers = [];
  level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
  level.numrevives = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A6A90CC9A3CBEF46426B5A332A77", 0);
  level.loadoutdefaultfiresalediscount = 1;
  level thread onplayerconnect();
}

onplayerconnect() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.numrevives = level.numrevives;
  }
}

onteamchangedeath(var_0) {
  if(var_0.team != "_encstr_AF8C0A1B6A1D6045925B4F7D")
    level thread spawnrevivetrigger(var_0, var_0, "_encstr_AA7414CDCABBFAE8935A763B5939BEE6E0C2BBE659C8", "_encstr_AB590C99ED78875F650F3951034D");
}

updaterevivetriggerspawnposition() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))) {
    if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
      level scripts\engine\utility::_id_143A6("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9", "_encstr_8C0D0E8410E8B112602F133F559DCAF4");
      var_0 = int(max(level.prematchperiodend - 5, 5));
      wait(var_0);
    } else
      level scripts\engine\utility::_id_143A6("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9", "_encstr_924C1B4A90714E33663EF41956EB27D28B38E2E1182F83733BADE70760");
  }

  while(scripts\mp\utility\player::isreallyalive(self)) {
    if(isvalidrevivetriggerspawnposition())
      _id_13285();

    waitframe();
  }
}

_id_13285() {
  var_0 = self.origin;

  if(isbot(self)) {
    var_1 = self getnearestnode();

    if(!isDefined(var_1))
      var_0 = self.origin;
    else
      var_0 = var_1.origin;
  } else {
    var_1 = self getnearestnode();

    if(!isDefined(var_1))
      var_1 = self.origin;
    else
      var_1 = var_1.origin;
  }

  if(!isDefined(self.revivepos))
    self.prevrevivepos = var_0;
  else
    self.prevrevivepos = self.revivepos;

  self.revivepos = var_0;
  self.revivetriggerspawnposition = var_0;
  self.nearestrevivenodepos = var_1;
}

isvalidrevivetriggerspawnposition() {
  var_0 = self.origin + (0, 0, 3);

  if(canspawn(var_0) && self isonground() && !scripts\mp\utility\entity::touchingoobtrigger())
    return 1;
  else
    return 0;
}

spawnrevivetrigger(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = var_0.origin;
  var_0.pers["_encstr_BDAA073552DA154FC7"] = 0;

  if(var_0 isnightvisionon())
    var_0.pers["_encstr_BDAA073552DA154FC7"] = 1;

  var_5 = 1;

  if(istrue(level.numlifelimited)) {
    waitframe();
    var_5 = !scripts\mp\utility\player::isreallyalive(var_0) && !istrue(var_0.inlaststand);

    if(var_5)
      var_5 = var_5 && !var_0 scripts\mp\playerlogic::mayspawn();
  }

  var_6 = level.laststandtimer;

  if(var_6 != 0)
    var_0.timeuntilbleedout = var_6;

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    var_0.revivetriggerblockedinremote = 1;
    var_0 waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
    var_0.revivetriggeravailable = 1;
  } else {
    var_0.revivetriggeravailable = 1;
    wait 3;
  }

  if(istrue(var_0.timeuntilbleedout))
    var_0 thread revivetimeoutthink(var_6);

  if(!var_5) {
    return;
  }
  if(isagent(var_0) || !isDefined(var_0))
    return;
  else {
    if(!isDefined(var_0.revive_chosenclass))
      var_0.revive_chosenclass = var_0.class;

    var_7 = var_0 scripts\mp\class::loadout_getorbuildclassstruct(var_0.revive_chosenclass);
    var_8 = var_0 scripts\mp\playerlogic::getplayerassets(var_7);
    var_0 scripts\mp\playerlogic::loadplayerassets([var_8], 1);
  }

  if(isDefined(var_1) && isagent(var_1))
    var_1 = var_1.owner;

  var_9[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_10 = var_9[0];
  var_9[0] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(istrue(level.numlifelimited))
    var_9[0] setclientowner(var_0);

  var_9[0] setasgametypeobjective();
  var_11 = 0;
  var_12 = var_0.team;
  var_11 = level.laststandrevivetimer;

  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.classname) && var_0.attacker.classname == "_encstr_85FE0DD5727A27098513298817CA23" && isDefined(var_0.nearestrevivenodepos))
    var_4 = var_0.nearestrevivenodepos;
  else if(isDefined(var_0.revivetriggerspawnposition))
    var_4 = var_0.revivetriggerspawnposition;
  else {
    var_13 = var_0 getnearestnode();

    if(isDefined(var_13))
      var_4 = var_13.origin;
    else
      var_4 = var_0.origin;
  }

  var_14 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C"];
  var_15 = physics_createcontents(var_14);
  var_16 = scripts\engine\trace::sphere_trace(var_4 + (0, 0, 10), var_4 + (0, 0, 30), 2.0, undefined, var_15, 1);
  var_4 = var_16["_encstr_BD260953AA97E3F014279D"];
  var_10.team = var_0.team;
  var_10.destination = var_4;
  level.revivetriggers[var_0.guid] = scripts\mp\gameobjects::createholduseobject(var_12, var_10, var_9, (0, 0, 0));
  level.revivetriggers[var_0.guid].trigger makereviveteamusable(var_0.team, istrue(level.numrevives));
  level.revivetriggers[var_0.guid].ownerteam = var_0.team;
  level.revivetriggers[var_0.guid].trigger.owner = var_0;
  level.revivetriggers[var_0.guid].trigger.id = "_encstr_9A43124032FAC143E35908750F93C99D24EBB038";
  level.revivetriggers[var_0.guid].interactteam = "_encstr_ACFC091AE8AB2FCBE15119";
  level.revivetriggers[var_0.guid].curprogress = 0;
  level.revivetriggers[var_0.guid].usetime = var_11;
  level.revivetriggers[var_0.guid].defaultusetime = var_11;
  level.revivetriggers[var_0.guid].userate = 1;
  level.revivetriggers[var_0.guid].id = "_encstr_9A43124032FAC143E35908750F93C99D24EBB038";
  level.revivetriggers[var_0.guid].exclusiveuse = 0;
  level.revivetriggers[var_0.guid].exclusiveclaim = 1;
  level.revivetriggers[var_0.guid].skiptouching = 1;
  level.revivetriggers[var_0.guid].skipminimapids = 1;
  level.revivetriggers[var_0.guid].onbeginuse = ::revivetriggerholdonusebegin;
  level.revivetriggers[var_0.guid].onuse = ::revivetriggerholdonuse;
  level.revivetriggers[var_0.guid].onenduse = ::revivetriggerholdonuseend;
  level.revivetriggers[var_0.guid].oncantuse = ::revivetriggeroncantuse;
  level.revivetriggers[var_0.guid].trigger setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  level.revivetriggers[var_0.guid].trigger setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  level.revivetriggers[var_0.guid].trigger setusehideprogressbar(1);
  level.revivetriggers[var_0.guid].trigger sethinttag("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.revivetriggers[var_0.guid].trigger setusepriority(-2);
  level.revivetriggers[var_0.guid].trigger sethintdisplayrange(96);
  level.revivetriggers[var_0.guid].trigger sethintdisplayfov(120);
  level.revivetriggers[var_0.guid].trigger setuserange(96);
  level.revivetriggers[var_0.guid].trigger setusefov(360);
  level.revivetriggers[var_0.guid].trigger sethintonobstruction("_encstr_BECC055CF3811A");
  level.revivetriggers[var_0.guid].trigger.targetname = "_encstr_81C90FCAF9E0392BF5FFEBFBFBAC626D68";

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    level.revivetriggers[var_0.guid].trigger setHintString(&"_encstr_8E6518CF01A621FF4791374FB01E30DFEDCDAEF32B19EFBD8B5F");
  else {}

  level.revivetriggers[var_0.guid] scripts\mp\gameobjects::setusetime(var_11);
  level.revivetriggers[var_0.guid].victim = var_0;
  level.revivetriggers[var_0.guid].victimteam = var_0.team;
  var_0 thread revivetriggerteamupdater(level.revivetriggers[var_0.guid]);
  var_0 thread revivetriggerspectateteamupdater(level.revivetriggers[var_0.guid]);
  level.revivetriggers[var_0.guid].deathicon = 1;
  level.revivetriggers[var_0.guid].curorigin = var_4;
  level.revivetriggers[var_0.guid].trigger.origin = var_4;
  level.revivetriggers[var_0.guid].visuals[0].origin = var_4;
  level.revivetriggers[var_0.guid] scripts\mp\gameobjects::initializetagpathvariables();

  if(isDefined(var_1)) {
    level.revivetriggers[var_0.guid].attacker = var_1;
    level.revivetriggers[var_0.guid].attackerteam = var_1.team;
  }

  var_0.forcespawnorigin = var_4;
  var_0.forcespawnangles = var_0.angles;
  var_0 thread addtriggerdeathicon(level.revivetriggers[var_0.guid], var_0, var_0.team);
  level notify(var_2, level.revivetriggers[var_0.guid]);
  level notify("_encstr_ACBE12F049519F2F9591A24AC8A1E9FFABA7669C");
  var_0 scripts\mp\utility\player::_id_1312B(0);

  if(isDefined(level.numlifelimited) && level.numlifelimited)
    var_0.statusicon = "_encstr_A6A81504CF8F27D653378B3F4BC7E2389B63D3A7CF93F3";
}

makereviveteamusable(var_0, var_1) {
  self makeusable();
  thread _updatereviveteamusable(var_0, var_1);
}

_updatereviveteamusable(var_0, var_1) {
  self notify("_encstr_B89413CD8E58E41DF5E856B0D6F5E827D2ECCE5993");
  self endon("_encstr_B89413CD8E58E41DF5E856B0D6F5E827D2ECCE5993");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_3 in level.players) {
      if(!var_1)
        var_3.numrevives = 1;

      if(var_3.team == var_0 && var_3.numrevives && !istrue(var_3 scripts\mp\utility\perk::_hasperk("_encstr_92D11CC31BB088C8B721D15F2963FA2E51DD794FD373635F57DF8A4B2D75")))
        self enableplayeruse(var_3);
      else
        self disableplayeruse(var_3);

      if(istrue(var_3 scripts\mp\utility\perk::_hasperk("_encstr_92D11CC31BB088C8B721D15F2963FA2E51DD794FD373635F57DF8A4B2D75")))
        var_3.hiddenreviveents[self getentitynumber()] = self;
    }

    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

_updatereviveplayerusable(var_0) {
  self endon("_encstr_AD75063D571AE108");

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }
  }
}

revivetimeoutthink(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self endon("_encstr_AC85100340F8BFAA2BDE396A4DD3E2568118");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B28110A395C2D67DB2B12DAD5A37B0475919");
  var_1 = level.revivetriggers[self.guid];
  level waittill("_encstr_AA7414CDCABBFAE8935A763B5939BEE6E0C2BBE659C8", var_1);
  var_2 = var_0;

  for(;;) {
    waitframe();
    var_3 = var_0;

    if(!istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      var_0 = var_0 - level.framedurationseconds;
      self.timelefttospawnaction = var_0;
      self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", min(var_0 / var_3, 0.01));
      self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    }

    if(level.teamdata[self.team]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
      scripts\mp\utility\lower_message::setlowermessageomnvar(5, int(gettime() + var_0 * 1000));

    if(istrue(self.eliminated)) {
      thread removetrigger(self.guid, 1);
      self notify("_encstr_AC85100340F8BFAA2BDE396A4DD3E2568118");
      return;
    }

    if(var_0 <= level.framedurationseconds) {
      self notify("_encstr_AAA9148899939B8E076B6FC5B1615A436D6F07A8CB3B");
      thread removetrigger(self.guid, 1, 1);

      if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
        scripts\mp\utility\lower_message::setlowermessageomnvar(18);
      else {
        scripts\mp\utility\lower_message::setlowermessageomnvar(2);
        thread scripts\mp\playerlogic::removespawnmessageshortly(3.0);
      }

      self notify("_encstr_AC85100340F8BFAA2BDE396A4DD3E2568118");
      break;
    } else if(istrue(self.beingrallyrespawned)) {
      thread removetrigger(self.guid, 1);
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      self notify("_encstr_AC85100340F8BFAA2BDE396A4DD3E2568118");
      break;
    }
  }
}

removetrigger(var_0, var_1, var_2) {
  self.revivetriggeravailable = undefined;

  if(isDefined(level.revivetriggers[var_0])) {
    if(isDefined(level.revivetriggers[var_0].enemytrigger))
      level.revivetriggers[var_0].enemytrigger removetriggerobject(self);

    level.revivetriggers[var_0] removetriggerobject(self);
    waitframe();

    if(isDefined(level.revivetriggers[var_0].enemytrigger)) {
      level.revivetriggers[var_0].enemytrigger removeuseobject();
      level.revivetriggers[var_0].enemytrigger = undefined;
    }

    if(isDefined(level.revivetriggers[var_0]))
      level.revivetriggers[var_0] removeuseobject();

    level.revivetriggers[var_0] = undefined;

    if(isDefined(var_2)) {
      self.forcespawnorigin = undefined;
      self.forcespawnangles = undefined;
    }
  }
}

removetriggerobject(var_0) {
  self notify("_encstr_921D09D9D9C0090D7275B4");

  if(isDefined(self.deathicon)) {
    if(isDefined(var_0.lastheadicondeathent))
      var_0.lastheadicondeathent delete();

    self.deathicon = undefined;
  }

  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  self notify("_encstr_88F20627959BCAE8");
}

removeuseobject() {
  self notify("_encstr_AD75063D571AE108");

  for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
    if(isDefined(self.visuals[var_0]))
      self.visuals[var_0] delete();
  }

  if(!isDefined(self.skipminimapids))
    thread scripts\mp\gameobjects::deleteuseobject();
}

relocatetrigger(var_0) {
  var_1 = var_0 + (0, 0, 5);
  var_2 = level.revivetriggers[self.guid].trigger;
  var_2.destination = var_1;
  var_2.curorigin = var_1;
  var_2.origin = var_1;
  level.revivetriggers[self.guid].visuals[0].origin = var_1;
  self.forcespawnorigin = var_1;
  self.lastheadicondeathent.origin = var_1;
}

revivetriggerteamupdater(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AC85100340F8BFAA2BDE396A4DD3E2568118");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298");
    thread removetrigger(self.guid, 1, 1);
  }
}

revivetriggerspectateteamupdater(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AC85100340F8BFAA2BDE396A4DD3E2568118");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

    if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      thread removetrigger(self.guid, 1, 1);
  }
}

onrevivepickupevent(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(self.pers))
    waitframe();

  var_2 = scripts\mp\rank::getscoreinfovalue(var_0);

  if(istrue(var_1.suicidespawndelay))
    var_2 = 0;

  thread scripts\mp\utility\points::giveunifiedpoints(var_0, undefined, var_2);
}

lifelimitedallyonuse(var_0) {
  if(istrue(level.numrevives))
    var_0.numrevives--;

  if(isDefined(var_0.pers["_encstr_8294083A0938C3CB2577"])) {
    var_0.pers["_encstr_8294083A0938C3CB2577"]++;
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8294083A0938C3CB2577", var_0.pers["_encstr_8294083A0938C3CB2577"]);

    switch (scripts\mp\utility\game::getgametype()) {
      case "_encstr_ACF906B79752C5E8":
      case "_encstr_A54F06D32A2F0498":
      case "_encstr_9B0703CD93":
        var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_8294083A0938C3CB2577"]);
    }
  }

  var_1 = [];
  var_1[var_1.size] = self.victim;

  if(isDefined(self.victim)) {
    level notify("_encstr_999F140422C16A9198A74DC2B17265E30F7E8085F7EA", self.victim);
    self.victim thread scripts\mp\rank::scoreeventpopup("_encstr_8E4208C9ACEC5A3BAC46");
    self.victim scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8E4208C9ACEC5A3BAC46");

    if(!level.gameended) {
      self.victim scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_AB420B13C7C1C88EFA6B6B2D5F");

      if(istrue(self.laststanding))
        scripts\mp\utility\stats::incpersstat("_encstr_BA2F0ED8635DA36C344AAC3B4B3B59CD", 1);

      self.victim thread respawn();
    }

    self.victim.revivetriggeravailable = undefined;
    self.victim.statusicon = "_encstr_B40101";
    scripts\cp\vehicles\vehicle_compass_cp::onplayerteamrevive(var_0, self.victim);
  }

  var_0 thread onrevivepickupevent("_encstr_B442086D6763FB3D4F0A", self.victim);

  if(!isDefined(var_0.rescuedplayers))
    var_0.rescuedplayers = [];

  var_0.rescuedplayers[self.victim.guid] = 1;
  scripts\mp\events::revivedplayer(var_0, self.victim);
}

lifelimitedenemyonuse(var_0) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("_encstr_8A360E37681665C2DBB94C8597D96A2C");
    level notify("_encstr_937F157EBAB7C3098E4BC87801A7D138975908FF14E709", self.victim);
  }

  var_1 = [];
  var_1[var_1.size] = self.victim;
  scripts\mp\hud_message::notifyteam("_encstr_953113E6E4D7851B632FEB2B36D2B6B4CDC2E85619", "_encstr_BA7D14F6D2B98388258FF8D1B77420DB627D67FDEFE2", self.victim.team, var_1);

  if(isDefined(self.victim)) {
    if(!level.gameended) {
      self.victim scripts\mp\utility\lower_message::setlowermessageomnvar(2);
      self.victim thread scripts\mp\playerlogic::removespawnmessageshortly(3.0);
    }

    self.victim.revivetriggeravailable = undefined;
    self.victim.statusicon = "_encstr_8D2810A1EA91AFE6E816D1D5E6BE8C59C28C";
  }

  if(self.attacker != var_0)
    self.attacker thread onrevivepickupevent("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");

  var_0 thread onrevivepickupevent("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");
  var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");
}

respawn() {
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::incrementalivecount(self.team, 1, "_encstr_AB420B13C7C1C89EFA6B6B2D5F");
  thread scripts\mp\playerlogic::waittillcanspawnclient(1);
}

revivetriggerholdonuse(var_0) {
  if(isDefined(var_0.owner))
    var_0 = var_0.owner;

  if(var_0.pers["_encstr_8AEF05472BC2D6"] == self.victimteam) {
    if(isDefined(self.victim.body))
      self.victim.body delete();

    var_0 scripts\mp\utility\stats::incpersstat("_encstr_B64E070F391562989D", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B64E070F391562989D", var_0.pers["_encstr_B64E070F391562989D"]);

    if(istrue(level.numlifelimited))
      lifelimitedallyonuse(var_0);
  } else if(level.numlifelimited) {
    lifelimitedenemyonuse(var_0);
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(2);
  }

  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0.01);
  var_0.ui_securing = undefined;
  self.victim notify("_encstr_AC85100340F8BFAA2BDE396A4DD3E2568118");
  self.victim thread removetrigger(self.victim.guid);
}

revivetriggerholdonusebegin(var_0, var_1) {
  var_2 = self.trigger.owner;
  var_2 scripts\mp\utility\player::_id_1312B(1);

  if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_84C710D3602B067FF9F9BCB918AD378F5B60")) {
    var_3 = level.revivetriggers[var_2.guid].defaultusetime;
    level.revivetriggers[var_2.guid] scripts\mp\gameobjects::setusetime(var_3 * getdvarfloat("_encstr_A97E1B48CB906F372255672BCBE9D983FC84A7370AE3828C4F17A8D2C7"));
  }

  self.trigger thread _updatereviveplayerusable(var_0);
  var_2.reviver = var_0;
  var_2 scripts\mp\utility\player::_id_1312B(1);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, "_encstr_B4EE096B6BA40AEED8405F");

  if(!istrue(var_1))
    var_0 thread allowedwhilereviving(0);

  var_2 scripts\mp\utility\player::_id_12898("_encstr_B45C3A14AB683DA3DDBBEAE3218A4A329025B19E33A98297F4B122ABAC086BEF69ED05035BA18F67AB88EE06B942B725085FA99569C15CE7DF2730D8");
  var_2 notify("_encstr_B6730EE73AE71389B1DA381842565B08");
  var_2.cancelkillcam = 1;
  var_2 scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_AB420B13C7C1C88EFA6B6B2D5F");
  var_4 = var_0 getEye();
  var_5 = getrevivecameradata(var_2, var_0);
  var_6 = var_5.origin;
  var_7 = var_5.angles;
  var_2.forcespawnangles = (0, var_7[1], 0);
  waitframe();
  var_2 scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  var_2 scripts\mp\spectating::setdisabled();
  waitframe();

  if(isDefined(level.revivetriggers[var_2.guid].headicondeath)) {
    if(scripts\cp_mp\utility\game_utility::isrealismenabled())
      var_8 = "_encstr_8DE81A482DB29113F049E9D8AB75E1729AF86FB6F3CF6373F8C09E4F";
    else
      var_8 = "_encstr_82ED1888E5256702787FC871037B45350A7F6ECA0350D097C8E7";

    setheadiconenemyimage(level.revivetriggers[var_2.guid].headicondeath, var_8);
  }

  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
  var_9 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_9.angles = var_7;
  var_2.revivecameraent = var_9;
  var_2 cameralinkTo(var_9, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  var_2 thread revivecamerapullin();

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    var_2 thread applynvgforrevive();

  var_2 thread runslamzoomonspawn();
}

getrevivecameradata(var_0, var_1) {
  var_2 = level.revivetriggers[var_0.guid].curorigin;
  var_3 = var_2;
  var_4 = vectorNormalize(var_1.origin - var_3);
  var_5 = 2;
  var_6 = 30;
  var_7 = 360 / var_6;
  var_8 = 1;
  var_9 = 1;
  var_10 = 100;
  var_11 = generateaxisanglesfromforwardvector(var_4, (0, 0, 1));
  var_12 = 0;
  var_13 = undefined;
  var_14 = 0;
  var_15 = var_3;
  var_16 = var_11;

  while(var_8 < var_7) {
    if(var_12) {
      var_12 = 0;
      var_13 = anglesToForward(var_11);
    } else {
      var_13 = anglesToForward(var_11 + (0, scripts\engine\utility::ter_op(var_9, var_6, var_6 * -1) * var_8, 0));
      var_9 = !var_9;

      if(var_9 == 1)
        var_8++;
    }

    var_17 = var_3 + (0, 0, 12);
    var_18 = var_3 + var_13 * var_10 + (0, 0, 100);
    var_19 = scripts\engine\trace::sphere_trace(var_17, var_18, var_5, [var_1]);
    var_20 = 30;
    var_21 = var_19["_encstr_BD260953AA97E3F014279D"];
    var_22 = 0;

    if(var_19["_encstr_A53009A25003666B9818C6"] < 1) {
      var_21 = var_21 + var_13 * var_5;
      var_22 = 1;
    }

    if(var_19["_encstr_A53009A25003666B9818C6"] > 0.99) {
      var_15 = var_21;
      var_16 = vectortoangles(var_13);
      break;
    }
  }

  var_23 = spawnStruct();
  var_23.origin = var_15;
  var_24 = vectorNormalize(var_3 - var_15);
  var_23.angles = vectortoangles(var_24);
  return var_23;
}

revivecamerapullin(var_0) {
  var_1 = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 3.0;
  var_2 = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 50.0;
  var_3 = scripts\engine\trace::sphere_trace(var_1, var_2, 2.0, undefined)["_encstr_BD260953AA97E3F014279D"];
  var_4 = level.revivetriggers[self.guid].usetime / 1000;
  self.revivecameraent moveTo(var_3, var_4, var_4 * 0.3, var_4 * 0.3);
}

applynvgforrevive() {
  self notify("_encstr_835810E6D17B07C9CA743DB994CAB3A59DB2");
  self endon("_encstr_835810E6D17B07C9CA743DB994CAB3A59DB2");
  wait 1;
  self nightvisionviewon(1);
}

deleteonspawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 delete();
}

allowedwhilereviving(var_0) {
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\mp\utility\player::allow_gesture(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
}

movecameratorevivepos(var_0, var_1, var_2) {
  var_3 = 1.0;
  var_4 = 1.0;
  self moveTo(var_0, 1.0, 0.5, 0.5);
  var_1 = (-9.5111, var_2.angles[1], 0);
  self rotateTo(var_1, 1.0, 0.5, 0.5);
}

revivetriggerholdonuseend(var_0, var_1, var_2, var_3) {
  if(isDefined(self.trigger.owner)) {
    var_4 = self.trigger.owner;
    var_5 = level.revivetriggers[var_4.guid].defaultusetime;
    level.revivetriggers[var_4.guid] scripts\mp\gameobjects::setusetime(var_5);
    var_4 scripts\mp\utility\player::_id_1312B(0);

    if(var_2) {
      if(!isDefined(var_4.revivecount))
        var_4.revivecount = 1;
      else
        var_4.revivecount++;

      var_6 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_9B251672990E6B6A600BBEBC45C06BA734B1A86A6169A39C");
      scripts\mp\analyticslog::logevent_playerhealed(var_4, var_6, var_1);
      var_4 setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", -1);
      var_4 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    } else {
      self.trigger thread _updatereviveteamusable(var_4.team, istrue(level.numrevives));

      if(scripts\cp_mp\utility\game_utility::isrealismenabled())
        var_7 = "_encstr_950518D0EA46BE93AC0B36A59BDAAFD0CA2C8CFA9CAC67B49D2B";
      else
        var_7 = "_encstr_BA2416A1BA19F5D2D8B79BF58D2F13AC39EB932B9DB4B32B";

      if(isDefined(level.revivetriggers[var_4.guid].headicondeath))
        setheadiconenemyimage(level.revivetriggers[var_4.guid].headicondeath, var_7);

      var_4 scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_AB420B13C7C1C88EFA6B6B2D5F");
      var_4 scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
      var_4 cameraunlink();
      var_4.revivecameraent delete();

      if(isDefined(var_4.team) && var_4.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        var_4 allowspectateteam(var_4.team, 1);

        foreach(var_9 in level.teamnamelist) {
          if(var_9 != var_4.team)
            var_4 allowspectateteam(var_9, 0);
        }

        var_4 spectateclientnum(var_1 getentitynumber());
      }
    }
  }

  if(!istrue(var_3))
    var_1 thread allowedwhilereviving(1);

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    var_1 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0.01);
    var_1.ui_securing = undefined;
  }

  if(var_2) {
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B642089B65A658E8F597", 1);

    if(istrue(var_1.laststanding))
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_BA2F0ED8635DA36C344AAC3B4B3B59CD", 1);
  }
}

revivetriggeroncantuse(var_0) {
  var_0 scripts\mp\hud_message::showerrormessage("_encstr_B87D200329EF4F1898334DCAFEF7A86547EF7799067E9F593857D9AAE5E1131125C9");
}

addtriggerdeathicon(var_0, var_1, var_2) {
  if(!level.teambased) {
    return;
  }
  var_3 = var_0.visuals[0].origin;
  var_1 endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();

  if(getDvar("_encstr_876C16B3FFA96BC80CB91B705DE7B815A21301337FF220B0") == "_encstr_934C0218") {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.lastheadicondeath);

  if(isDefined(self.lastheadicondeathent))
    self.lastheadicondeathent delete();

  self notify("_encstr_8E301348C05BF3A68DD0AF7A7FB37B2998613FC7D8");

  if(!isDefined(var_2) || var_2 == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    return;
  }
  self.lastheadicondeathent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  self.lastheadicondeathent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.lastheadicondeathent.team = var_2;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled() || level.hardcoremode) {
    var_4 = 0;
    var_5 = 500;
    var_6 = 100;
    var_7 = "_encstr_950518D0EA46BE93AC0B36A59BDAAFD0CA2C8CFA9CAC67B49D2B";
  } else {
    var_4 = 1;
    var_5 = 8000;
    var_6 = 100;
    var_7 = "_encstr_BA2416A1BA19F5D2D8B79BF58D2F13AC39EB932B9DB4B32B";
  }

  var_0.headicondeath = self.lastheadicondeathent thread scripts\cp_mp\entityheadicons::setheadicon_multiimage(var_2, var_7, undefined, undefined, 0, var_4, var_5, var_6);

  if(level.showenemydeathloc) {
    setheadiconneutralimage(var_0.headicondeath, "_encstr_BE8E1C642D8A30DB9238AE410781D903124FE2BF80CBA72371A860112BAA");

    foreach(var_9 in level.teamnamelist)
    removeclientfromheadiconmask(var_0.headicondeath, var_9);
  }
}

runslamzoomonspawn() {
  self notify("_encstr_88420F5BFE97713E436A9BA091B3F8386D");
  self endon("_encstr_88420F5BFE97713E436A9BA091B3F8386D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = self getEye();
  var_1 = self.angles;
  self cameralinkTo(self.revivecameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self.revivecameraent moveTo(var_0, 0.25, 0.1, 0.1);
  self.revivecameraent rotateTo(var_1, 0.25, 0.1, 0.1);
  wait 0.25;
  self visionsetnakedforplayer("_encstr_B40101", 0.1);
  self cameraunlink();
  self.revivecameraent delete();
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_8E4208C9ACEC5A3BAC46");
}

playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

cleanuprevivetriggericons() {
  foreach(var_1 in level.revivetriggers) {
    var_1 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_1 notify("_encstr_88F20627959BCAE8");
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1.lastheadicondeath);

    if(isDefined(var_1.lastheadicondeathent))
      var_1.lastheadicondeathent delete();
  }
}

updatetimerwaitforjoined() {}

assigntimervisibleteam(var_0) {
  self.interactteams = var_0;

  foreach(var_2 in level.players)
  applytimervisibleteam(var_2);
}

applytimervisibleteam(var_0) {
  if(var_0.team == self.ownerteam)
    self.visuals[0] showtoplayer(var_0);
  else
    self.visuals[0] hidefromplayer(var_0);
}

waitrespawnbutton() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");
  self endon("_encstr_B28110A395C2D67DB2B12DAD5A37B0475919");
  var_0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      while(self useButtonPressed()) {
        var_0 = var_0 + 0.05;

        if(var_0 >= 1.0) {
          break;
        }

        wait 0.05;
      }

      if(var_0 >= 0.5)
        var_0 = var_0 + 0.05;
    }

    var_0 = 0;
    wait 0.05;
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\obj_dogtag.gsc
***********************************************/

init() {
  level.dogtags = [];
  level.dogtagallyonusecb = _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::dogtagcommonallyonusecb;
  level.dogtagenemyonusecb = _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::dogtagcommonenemyonusecb;
  level.conf_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
  level.conf_fx["_encstr_9AF40BB3B09BB4CD43FAD9F6B9"] = loadfx("_encstr_93C22B2B84494EA92B0AAF6F60089F12CBAD75E57DAB86FE5170B77F807B6F0BAB3471DA53CF9A257BEA1B73D0");
  level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"] = loadfx("_encstr_855E3AD999E15E2DDDE0F5AD38BCCEB0D6AC5BDE1959BC67CC0FAF0D2CB1C6DEEEAC9537D76DB1D7D82CC147EAC959F533E496ACDC8CD85EE23B6687");
  level.spawnoffsettacinsertmax["_encstr_81930D73E6AE887E4AAF090F97A2C8"] = loadfx("_encstr_AF3A371D6B7360B07708E6B80207088F9ACFB3A71BCA3870BEF0EE106E3C0830D3572BDD5FF2D671D38EF3AB130A8860AA9393535F0E2460F0");

  if(istrue(level.playinggulagbink))
    level._id_136CD = ::_id_136CC;

  level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
}

shouldspawntags(var_0) {
  if(isDefined(self.switching_teams))
    return 0;

  if(isDefined(var_0) && var_0 == self)
    return 0;

  if(level.teambased && isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team)
    return 0;

  if(isDefined(var_0) && !isDefined(var_0.team) && (var_0.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_0.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0"))
    return 0;

  return 1;
}

spawndogtags(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(istrue(level.numlifelimited)) {
    var_4 = var_0 shouldspawntags(var_1);

    if(var_4)
      var_4 = var_4 && !scripts\mp\utility\player::isreallyalive(var_0);

    if(var_4)
      var_4 = var_4 && !var_0 scripts\mp\playerlogic::mayspawn();
  }

  if(!var_4) {
    return;
  }
  if(isagent(var_0)) {
    return;
  }
  if(isagent(var_1))
    var_1 = var_1.owner;

  var_5 = 14;
  var_6 = (0, 0, 0);
  var_7 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_7 = var_0 getworldupreferenceangles();
    var_6 = anglestoup(var_7);

    if(var_6[2] < 0)
      var_5 = -14;
  }

  if(isDefined(level.dogtags[var_0.guid])) {
    if(istrue(level.playinggulagbink))
      playFX(level.conf_fx["_encstr_9AF40BB3B09BB4CD43FAD9F6B9"], level.dogtags[var_0.guid].curorigin);
    else if(istrue(level.setplayerselfrevivingextrainfo))
      playFX(level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"], level.dogtags[var_0.guid].curorigin);
    else
      playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], level.dogtags[var_0.guid].curorigin);

    level.dogtags[var_0.guid] resettags();
    level.dogtags[var_0.guid].visuals[0].angles = (0, 0, 0);
    level.dogtags[var_0.guid].visuals[1].angles = (0, 0, 0);
  } else {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var_8[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
      var_8[0] setModel("_encstr_880B20D934AABBEB019398B1D357C1C902DF4E48CC936BB1E60FC018FF7C7867BF12");
      var_8[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
      var_8[1] setModel("_encstr_970B20ADB4632DA32C9C97BEC8DE3B1DC2D9DCD734D5B616B9EB9B5BEA36D87D8126");
    } else {
      var_8[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
      var_8[0] setModel("_encstr_84CD1C70848CA8DDFA3B0BBF9BE2AC88599F3B8E2CFF5AAF321333D5BF6A");
      var_8[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
      var_8[1] setModel("_encstr_8CFD1ADD63D0EC6B0F8B5B2151506FE30BD75B679BE060FFA620938A");
    }

    if(level.numlifelimited) {
      var_8[0] setclientowner(var_0);
      var_8[1] setclientowner(var_0);
    }

    var_8[0] setasgametypeobjective();
    var_8[1] setasgametypeobjective();
    var_9 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);

    if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
      if(var_6[2] < 0) {
        var_8[0].angles = var_7;
        var_8[1].angles = var_7;
      }
    }

    var_10 = "_encstr_9A19040BCDBC";
    var_11 = 0;
    level.dogtags[var_0.guid] = scripts\mp\gameobjects::createuseobject(var_10, var_9, var_8, (0, 0, 16));
    level.dogtags[var_0.guid].onuse = ::onuse;
    level.dogtags[var_0.guid] scripts\mp\gameobjects::setusetime(var_11);
    level.dogtags[var_0.guid].victim = var_0;
    level.dogtags[var_0.guid].victimteam = var_0.team;
    level thread clearonvictimdisconnect(var_0);
    var_0 thread tagteamupdater(level.dogtags[var_0.guid]);
  }

  var_12 = var_0.origin + (0, 0, var_5);
  level.dogtags[var_0.guid].curorigin = var_12;
  level.dogtags[var_0.guid].trigger.origin = var_12;
  level.dogtags[var_0.guid].visuals[0].origin = var_12;
  level.dogtags[var_0.guid].visuals[1].origin = var_12;
  level.dogtags[var_0.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[var_0.guid] scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  level.dogtags[var_0.guid].visuals[0] showtoteam(level.dogtags[var_0.guid], var_1.team);
  level.dogtags[var_0.guid].visuals[1] showtoteam(level.dogtags[var_0.guid], var_0.team);
  level.dogtags[var_0.guid].attacker = var_1;
  level.dogtags[var_0.guid].attackerteam = var_1.team;
  level.dogtags[var_0.guid].ownerteam = var_0.team;

  if(isDefined(level.dogtags[var_0.guid].objidnum)) {
    if(level.dogtags[var_0.guid].objidnum != -1) {
      var_13 = level.dogtags[var_0.guid].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_13, "_encstr_AF5A081BBAC993AC73A3");
      scripts\mp\objidpoolmanager::update_objective_position(var_13, var_0.origin + (0, 0, 36));
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_13, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var_0.guid].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var_0.guid].objidnum, 0);

      if(istrue(level.setplayerselfrevivingextrainfo))
        level.dogtags[var_0.guid] scripts\mp\gameobjects::setobjectivestatusicons("_encstr_95641ADDB02F0EBD96CD47FA32B7CE47C2B3E6F5DCDAD51B36F59927", "_encstr_976E17BB2CE583B7B4B98EEB19EDB33A85B3E67D9BB5571BC6");
      else
        level.dogtags[var_0.guid] scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", "_encstr_8ECD1123407BEFC751BD31889F2789592B50D7");

      level.dogtags[var_0.guid] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    }
  }

  if(istrue(level.setplayerselfrevivingextrainfo))
    playsoundatpos(var_12, "_encstr_BE091CA5C7BFB2618070979F58F9296B83C86BDE244F49B4AB80D35743B3");
  else
    playsoundatpos(var_12, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");

  level notify(var_2, level.dogtags[var_0.guid]);
  var_0.tagavailable = 1;
  level.dogtags[var_0.guid].visuals[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
  level.dogtags[var_0.guid].visuals[1] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");

  if(level.numlifelimited)
    var_0.statusicon = "_encstr_816912E0BB7B4878C3B93923B36188280FC35989";
}

resettags() {
  self.attacker = undefined;
  self notify("_encstr_88F20627959BCAE8");
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.visuals[0] dontinterpolate();
  self.visuals[1] dontinterpolate();
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  self.visuals[1].origin = (0, 0, 1000);
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  if(self.objidnum != -1)
    scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "_encstr_8267056410C669");
}

removetags(var_0, var_1, var_2) {
  if(isDefined(level.dogtags[var_0])) {
    level.dogtags[var_0] scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

    if(istrue(var_1) && isDefined(level.dogtags[var_0].attacker))
      level.dogtags[var_0].attacker thread scripts\mp\rank::scoreeventpopup("_encstr_92380CB7CB21D24F28A965AC41C0");

    if(istrue(level.playinggulagbink)) {
      if(isDefined(level._id_136CD))
        level[[level._id_136CD]](level.dogtags[var_0], var_2);
    } else if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(isDefined(var_2) && var_2.team == level.dogtags[var_0].ownerteam) {
        playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], level.dogtags[var_0].curorigin);
        playFX(level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"], level.dogtags[var_0].curorigin + (0, 0, 45));
      } else {
        playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], level.dogtags[var_0].curorigin);
        playFX(level.spawnoffsettacinsertmax["_encstr_81930D73E6AE887E4AAF090F97A2C8"], level.dogtags[var_0].curorigin + (0, 0, 45));
      }
    } else
      playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], level.dogtags[var_0].curorigin);

    level.dogtags[var_0] notify("_encstr_88F20627959BCAE8");
    waitframe();

    if(isDefined(level.dogtags[var_0])) {
      level.dogtags[var_0] notify("_encstr_AD75063D571AE108");

      for(var_3 = 0; var_3 < level.dogtags[var_0].visuals.size; var_3++)
        level.dogtags[var_0].visuals[var_3] delete();

      if(!isDefined(level.dogtags[var_0].skipminimapids))
        level.dogtags[var_0] thread scripts\mp\gameobjects::deleteuseobject();

      level.dogtags[var_0] = undefined;
    }
  }
}

_id_136CC(var_0, var_1) {
  var_2 = 20;
  var_3 = 600;
  var_4 = var_0.curorigin + (0, 0, var_2);
  var_5 = var_0.curorigin + (0, 0, var_3);
  var_6 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_7 = [];
  var_7[var_7.size] = var_0.visuals[0];
  var_7[var_7.size] = var_0.visuals[1];

  if(isPlayer(var_1))
    var_7[var_7.size] = var_1;

  var_8 = scripts\engine\trace::ray_trace(var_4, var_5, var_7, var_6, 0);

  if(isPlayer(var_8["_encstr_850E077B0BF30318B9"]))
    var_8["_encstr_850E077B0BF30318B9"] = undefined;

  if(isDefined(var_8["_encstr_850E077B0BF30318B9"]) && isDefined(var_8["_encstr_850E077B0BF30318B9"].code_classname) && var_8["_encstr_850E077B0BF30318B9"].code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    var_7[var_7.size] = var_8["_encstr_850E077B0BF30318B9"];
    var_8 = scripts\engine\trace::ray_trace(var_4, var_5, var_7, var_6, 0);
  }

  if(var_8["_encstr_A53009A25003666B9818C6"] != 1)
    playFX(level.conf_fx["_encstr_9AF40BB3B09BB4CD43FAD9F6B9"], var_0.curorigin);
  else {
    playFX(level.conf_fx["_encstr_9AF40BB3B09BB4CD43FAD9F6B9"], var_0.curorigin);
    playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], var_0.curorigin);
    level thread _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::_id_14397(var_0.curorigin);
  }
}

onplayerjoinedteam(var_0) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  foreach(var_2 in level.dogtags) {
    if(isDefined(var_2.attackerteam)) {
      if(var_0.team == var_2.attackerteam)
        var_2.visuals[0] showtoplayer(var_0);

      if(var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_2.attackerteam == "_encstr_9A8507BA4040188D08")
        var_2.visuals[0] showtoplayer(var_0);
    }

    if(isDefined(var_2.ownerteam)) {
      if(var_0.team == var_2.ownerteam)
        var_2.visuals[1] showtoplayer(var_0);

      if(var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_2.ownerteam == "_encstr_9A8507BA4040188D08")
        var_2.visuals[1] showtoplayer(var_0);
    }
  }
}

showtoteam(var_0, var_1) {
  self hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_1)
      self showtoplayer(var_3);

    if(var_3.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_1 == "_encstr_9A8507BA4040188D08")
      self showtoplayer(var_3);
  }
}

playercanusetags(var_0) {
  return 1;
}

onuse(var_0) {
  if(!playercanusetags(var_0)) {
    return;
  }
  if(isDefined(var_0.owner))
    var_0 = var_0.owner;

  if(scripts\mp\utility\game::getgametype() == "_encstr_959105B99040BD")
    var_0 thread watchrapidtagpickup();

  if(var_0.pers["_encstr_8AEF05472BC2D6"] == self.victimteam) {
    if(istrue(level.setplayerselfrevivingextrainfo))
      self.trigger playSound("_encstr_A2FD1C3AE3405FAC98D96B7FC51074F3F1BE2362692ED7A7F8357947E1F0");
    else
      self.trigger playSound("_encstr_8B87194A804F1F52CD40A960587D7C4E09270DFF7A4F28C1584B7B");

    var_0 scripts\mp\utility\stats::incpersstat("_encstr_B64E070F391562989D", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B64E070F391562989D", var_0.pers["_encstr_B64E070F391562989D"]);

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "_encstr_A9B606B0C956B916")
      lifelimitedallyonuse(var_0);
    else
      allyonuse(var_0);

    if(isDefined(level.dogtagallyonusecb) && !level.gameended)
      self thread[[level.dogtagallyonusecb]](var_0);
  } else {
    if(istrue(level.setplayerselfrevivingextrainfo))
      self.trigger playSound("_encstr_9B4D1E7753C17A34209DA65FC0C39F32EB4F28389F5AE702DA9E22B3F0698C83");
    else
      self.trigger playSound("_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");

    if(scripts\mp\utility\game::getgametype() != "_encstr_A7290676E4D2378C" && scripts\mp\utility\game::getgametype() != "_encstr_A20D05FBEB01F2") {
      var_0 scripts\mp\utility\stats::incpersstat("_encstr_820E0A2AE8981DBA528588DC", 1);
      var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_820E0A2AE8981DBA528588DC", var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);
    }

    if(level.numlifelimited && scripts\mp\utility\game::getgametype() != "_encstr_A9B606B0C956B916")
      lifelimitedenemyonuse(var_0);
    else
      enemyonuse(var_0);

    if(isDefined(level.dogtagenemyonusecb) && !level.gameended)
      self thread[[level.dogtagenemyonusecb]](var_0);

    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
  }

  self.victim notify("_encstr_96640CDC1749DF0253F87AE350B9");
  thread removetags(self.victim.guid, undefined, var_0);
}

watchrapidtagpickup() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_9381167CA91BA10142CA60A0B2EBCBF963598EFA15B380CB");
  self endon("_encstr_9381167CA91BA10142CA60A0B2EBCBF963598EFA15B380CB");

  if(!isDefined(self.recenttagcount))
    self.recenttagcount = 1;
  else {
    self.recenttagcount++;

    if(self.recenttagcount == 3)
      thread scripts\mp\awards::givemidmatchaward("_encstr_8B430F1A20FD47018027B7C347A056879E");
  }

  wait 3.0;
  self.recenttagcount = 0;
}

tagteamupdater(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_81170C244F9CBDE72C01BB99A298");
    thread removetags(self.guid, 1);
  }
}

clearonvictimdisconnect(var_0) {
  var_0 notify("_encstr_8C91182E85CA5BDBDF333130FF1C708B446C9EA6DD123D61DB73");
  var_0 endon("_encstr_8C91182E85CA5BDBDF333130FF1C708B446C9EA6DD123D61DB73");
  var_0 endon("_encstr_96640CDC1749DF0253F87AE350B9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.guid;
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread removetags(var_1, 1);
}

ontagpickupevent(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(self.pers))
    waitframe();

  thread scripts\mp\utility\points::giveunifiedpoints(var_0);
}

lifelimitedallyonuse(var_0) {
  var_0.pers["_encstr_8294083A0938C3CB2577"]++;
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8294083A0938C3CB2577", var_0.pers["_encstr_8294083A0938C3CB2577"]);
  var_1 = [];
  var_1[var_1.size] = self.victim;
  scripts\mp\hud_message::notifyteam("_encstr_A7F1122F7A77936B75C7EF9AC7474371F0D0E781", "_encstr_8D9D13CD9CF595B9CAB697BEC9AC9BC10BEE37ACC8", self.victim);

  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("_encstr_B4C50DBBF3AFF6E01AB07B5FC6C7B0");
    level notify("_encstr_8AC2144BBA77A81922DF8BAD2F7BD5E8F0D67360E7B4", self.victim);
    self.victim scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8E4208C9ACEC5A3BAC46");

    if(!level.gameended)
      self.victim thread respawn();

    self.victim.tagavailable = undefined;
    self.victim.statusicon = "_encstr_B40101";
  }

  if(isDefined(self.attacker))
    self.attacker thread scripts\mp\rank::scoreeventpopup("_encstr_92380CB7CB21D24F28A965AC41C0");

  var_0 thread ontagpickupevent("_encstr_92380CB7CB21D24F28A965AC41C0");

  if(!isDefined(var_0.rescuedplayers))
    var_0.rescuedplayers = [];

  var_0.rescuedplayers[self.victim.guid] = 1;
}

lifelimitedenemyonuse(var_0) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("_encstr_8A360E37681665C2DBB94C8597D96A2C");
    level notify("_encstr_937F157EBAB7C3098E4BC87801A7D138975908FF14E709", self.victim);
  }

  var_1 = [];
  var_1[var_1.size] = self.victim;
  scripts\mp\hud_message::notifyteam("_encstr_953113E6E4D7851B632FEB2B36D2B6B4CDC2E85619", "_encstr_BA7D14F6D2B98388258FF8D1B77420DB627D67FDEFE2", self.victim);

  if(isDefined(self.victim)) {
    if(!level.gameended) {
      self.victim scripts\mp\utility\lower_message::setlowermessageomnvar(2);
      self.victim thread scripts\mp\playerlogic::removespawnmessageshortly(3.0);
    }

    self.victim.tagavailable = undefined;
    self.victim.statusicon = "_encstr_8D2810A1EA91AFE6E816D1D5E6BE8C59C28C";
  }

  if(self.attacker != var_0)
    self.attacker thread ontagpickupevent("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");

  var_0 thread ontagpickupevent("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");
  var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");
}

respawn() {
  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.alreadyaddedtoalivecount = 1;
  thread scripts\mp\playerlogic::waittillcanspawnclient();
}

allyonuse(var_0) {
  if(self.victim == var_0) {
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_8E810ED9B74298A8255B0378071E584D");
    var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_817E11EA40F16F4F40967F77B4C887F323E8F3");
  } else if(issubstr(scripts\mp\utility\game::getgametype(), "_encstr_959105B99040BD"))
    var_0 ontagpickupevent("_encstr_92380CB7CB21D24F28A965AC41C0");
  else if(scripts\mp\utility\game::getgametype() != "_encstr_A7290676E4D2378C")
    var_0 ontagpickupevent("_encstr_82780B3A2C76BE46CAE6A5B219");
  else {
    var_0 ontagpickupevent("_encstr_96590EE82CB3D71BDE36B1ACD88E598C");
    var_0 playersettagcount(var_0.tagscarried + 1);
  }

  if(isDefined(self.attacker))
    self.attacker thread scripts\mp\rank::scoreeventpopup("_encstr_82780B3A2C76BE46CAE6A5B219");

  if(isDefined(level.supportcranked) && level.supportcranked) {
    if(isDefined(var_0.cranked) && var_0.cranked)
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_97840D618B0F15D087F46337F42E50");
    else
      var_0 scripts\mp\cranked::oncranked(undefined, var_0);
  }
}

enemyonuse(var_0) {
  if(issubstr(scripts\mp\utility\game::getgametype(), "_encstr_959105B99040BD"))
    var_0 ontagpickupevent("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");
  else
    var_0 ontagpickupevent("_encstr_96590EE82CB3D71BDE36B1ACD88E598C");

  if(scripts\mp\utility\game::getgametype() == "_encstr_A7290676E4D2378C")
    var_0 playersettagcount(var_0.tagscarried + 1);

  if(self.attacker != var_0) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_A7290676E4D2378C")
      self.attacker thread ontagpickupevent("_encstr_84D5165AB8FBBDB3F62462614D387BC52339B3328857339B");
    else
      self.attacker thread ontagpickupevent("_encstr_A7D713B56CF5339CD259DC321BBCD7C14BC6DAEA83");
  }

  if(isDefined(level.supportcranked) && level.supportcranked) {
    if(isDefined(var_0.cranked) && var_0.cranked)
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");
    else
      var_0 scripts\mp\cranked::oncranked(undefined, var_0);

    if(var_0 != self.attacker && isDefined(self.attacker.cranked) && self.attacker.cranked)
      self.attacker scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");
  }
}

playersettagcount(var_0) {
  self.tagscarried = var_0;
  self.game_extrainfo = var_0;

  if(var_0 > 999)
    var_0 = 999;

  self setclientomnvar("_encstr_81730E57C86EEFAB43A08771957BB2A3", var_0);
}
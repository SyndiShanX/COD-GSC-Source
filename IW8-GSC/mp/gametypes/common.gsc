/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\common.gsc
***********************************************/

setupcommoncallbacks() {
  level.onnormaldeath = ::oncommonnormaldeath;
  level.onsuicidedeath = ::oncommonsuicidedeath;
  level.onteamchangedeath = ::oncommonteamchangedeath;

  if(isusingmatchrulesdata())
    setdynamicdvar("_encstr_920218BFD77BF0580935D9965FE5E804A2771B4F67122F502E8A", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A13F0F3BEADCA385D62BAB9585C1DBE637"));

  level.set_systems_init_flag = getdvarint("_encstr_920218BFD77BF0580935D9965FE5E804A2771B4F67122F502E8A", 0);

  if(level.set_systems_init_flag > 0) {
    _id_131C1();
    setomnvar("_encstr_B83015C8F1C6FAE72927E56A9CE9510868955ADB73C22D", 1);
    level thread _id_1439C();
  }

  var_0 = undefined;

  if(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") == "_encstr_A9B606B0C956B916") {
    var_1 = 0;

    if(isusingmatchrulesdata())
      var_1 = getmatchrulesdata("_encstr_9BC90AD773B028802F9928CF", "_encstr_AB4D0C0FA0F8F54A0973578C6D0D");
    else
      var_1 = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB4D0C0FA0F8F54A0973578C6D0D", 0, 0, 2);

    if(var_1 == 2)
      var_0 = 1;
  }

  level.maxtagsvisible = 0;
  var_2 = getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7") && !getdvarint("_encstr_93390B136AA2628AA8A93529D4");

  if(var_2) {
    level.maxtagsvisible = getdvarint("_encstr_B4831502B14887A27F1357C75710AAF3A83B3FCBE94054", 0);

    if(getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") == "_encstr_A90A0D75F9E1455F9EA3227A68F5EF" && getdvarint("_encstr_966A17B30692195EAB7731D3DFC2B0B0579E39C9EAEA909902", 1))
      level.maxtagsvisible = 1;
  } else if(getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") == "_encstr_A90A0D75F9E1455F9EA3227A68F5EF" && !dotournamentendgame() && !isgamebattlematch())
    level.maxtagsvisible = 1;

  if(level.maxtagsvisible || istrue(var_0)) {
    _id_11962();
    level._id_1326E = ::_id_1326E;
    level thread[[level._id_1326E]]();
    level thread scripts\mp\utility\entity::global_physics_sound_monitor();

    if(getdvarint("_encstr_ADF21490877AEECFEAAD5D4802220FD1D56BA8F8F70C", 1) == 1) {
      _id_13237();
      level _id_13471();

      if(getdvarint("_encstr_8F5D1963278BEFBA438DD9D71E17F62BB0D33FE7AC99E79837DD59", 3) > 0) {
        if(!isDefined(game["_encstr_9A4D0A2D85B0EB6CB520E2DA"]))
          game["_encstr_9A4D0A2D85B0EB6CB520E2DA"] = 0;
      }
    }
  } else
    level.maxtagsvisible = undefined;

  if(getdvarint("_encstr_93FC1A1B30CDF1BF31A1755746FB7F0603C872F0204BF58BAC1E7273", 0) == 1) {
    level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"] = loadfx("_encstr_81CE2967990FBCA5EE077D5B3879B32CADB2DAF6915979B3990F7DB3B7CDEB334B9CB2BBDB39AD713B33C3");
    level.playinggulagbink = 1;
  }

  var_3 = scripts\mp\utility\game::matchmakinggame() && scripts\mp\utility\game::usequesttimer();

  if(var_3) {
    level.setplayerselfrevivingextrainfo = 1;
    level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"] = loadfx("_encstr_855E3AD999E15E2DDDE0F5AD38BCCEB0D6AC5BDE1959BC67CC0FAF0D2CB1C6DEEEAC9537D76DB1D7D82CC147EAC959F533E496ACDC8CD85EE23B6687");
    level.spawnoffsettacinsertmax["_encstr_81930D73E6AE887E4AAF090F97A2C8"] = loadfx("_encstr_AF3A371D6B7360B07708E6B80207088F9ACFB3A71BCA3870BEF0EE106E3C0830D3572BDD5FF2D671D38EF3AB130A8860AA9393535F0E2460F0");
    level.spawnoffsettacinsertmax["_encstr_A6CB0CD90DBDE6D1B185D1AF43EE"] = loadfx("_encstr_8633365333C1E58FCB0347723E186FBE03E0BB6A907BBDC3A3854566781B23803F2052E2603F630FD9787767E3404F4B97E0DADB1AD59F33");
    level.spawnoffsettacinsertmax["_encstr_8C08081ABBD8A2FFB363"] = loadfx("_encstr_A3392DC5121337DFD72AF7F84A2E898B88D9D28B60198D10EB2BE1CACF05B5A059DC23F10F8899A2E8730F702680C3");
    level.spawnoffsettacinsertmax["_encstr_B2190CC4C21D6EAF99C697D743DD"] = loadfx("_encstr_884031885A201F689768F86E1ACE914BCDF230A0C2B8A70DFF5DFD50AF437921398A90603A150F997F54FEC0FE73C245DB1260");
    level.spawnoffsettacinsertmax["_encstr_85170EB291A2077991B9F3B7F597C8E3"] = loadfx("_encstr_A61C3DA06722FA4007A8DF2632B6BA990BFF7051567F8010DBB10DB66563199BAF4009F8E8D29C45BD5009BA6D1010C5D9589FD0F5E9E36F77D743A2B0D490");
    level.spawnoffsettacinsertmax["_encstr_B8A50F48057D083AF8E073F74820B7A3D0"] = loadfx("_encstr_952F3B64C7DB077827AAB928FB07F1D3D2AFDFE19E23FF800FF76040A67629395994DF7935FA0769C5C3A938B3B74049A1BFC1704D438FFBF92AE8100B");

    if(getdvarint("_encstr_A1E8188F8693895078A0DB97CA0E67EEC0606B39D74DDD9971AE", 1) > 0) {
      var_4 = strtok(getDvar("_encstr_B2441CA3F9AEE782C06BC9DD2531CC3FDB511A5AC68AF77D1857C7B50550", "_encstr_8F010566084C81"), "_encstr_974C0246");
      level.spawnoffsettacinsertmin = int(var_4[0]);
      level.spawnoutofboundstrigger = int(var_4[1]);
      level._id_12070 = ::_id_12070;
    }
  }

  level._id_1368D = undefined;
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onplayerjointeamcommon);
  scripts\mp\utility\game::registerdogtagsenableddvar(scripts\mp\utility\game::getgametype(), 0);
  level._effect["_encstr_8EF3100682106612B5B58F5F28607CB76B38"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
}

updatecommongametypedvars() {
  level.dogtagsenabled = scripts\mp\utility\dvars::dvarintvalue("_encstr_B631089D3F97E1F394E6", 0, 0, 1);
  level.showenemydeathloc = scripts\mp\utility\dvars::dvarintvalue("_encstr_923F0EBB1E376BDB730A79C3C20B9838", 0, 0, 3);

  if(level.dogtagsenabled)
    _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::init();

  level.mpingamelootdrop = scripts\mp\utility\game::getgametype() == "_encstr_B1190448CD80" || scripts\mp\utility\dvars::respawn_players_into_plane("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_93470CF153DBC89EB08F15FD2783", "_encstr_850C14573F931880A19D613E8486C94FDA8FB1E7F71B");

  if(level.mpingamelootdrop)
    _encstr_B82C2106669B6BBBC467DAF053A791B3B20F7D8B3A42E708A873ABE0EB050B757A327E::init();
}

oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level thread scripts\mp\teamrevive::spawnrevivetrigger(var_0, var_1, "_encstr_AA7414CDCABBFAE8935A763B5939BEE6E0C2BBE659C8", var_3);

  if(isbot(self) && isDefined(self.tutorial_lead_collected))
    self.tutorial_lead_collected = undefined;

  if(istrue(level.flashpointactive))
    scripts\mp\flashpoint::flashpoint_processnewevent(var_1, var_0, gettime(), "_encstr_A9D509DF776894B19E78B1" + var_1.team);

  var_7 = scripts\mp\utility\game::islaststandenabled() && istrue(var_0._id_125B9);

  if(!var_7 && var_1.team != self.team) {
    var_8 = level.scoremod["_encstr_AD75063D571AE108"] * -1;

    if(var_8 != 0) {
      if(level.teambased)
        level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], var_8, 0);
      else
        var_1 scripts\mp\gamescore::giveplayerscore("_encstr_ABD70578F3D02C", var_8);
    }

    var_6 = level.scoremod["_encstr_ABD70578F3D02C"];

    if(istrue(var_5))
      var_6 = var_6 + level.scoremod["_encstr_B452070CBB88B90AF1"];

    if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
      var_6 = var_6 + level.scoremod["_encstr_848909BBD3A7526348E8E3"];

    if(level.dogtagsenabled && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      level thread _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::spawndogtags(var_0, var_1, "_encstr_871E107D55071984D9C07FC790315FD28B7D", var_3);

    if(level.mpingamelootdrop)
      level thread _encstr_B82C2106669B6BBBC467DAF053A791B3B20F7D8B3A42E708A873ABE0EB050B757A327E::dropplayerstags(var_0, var_1);
  }

  if(istrue(level.supportcranked)) {
    if(scripts\mp\utility\game::matchmakinggame() && isDefined(var_1.cranked)) {
      if(!var_7 && var_6 != 0) {
        var_6 = var_6 + 1;
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_85B0122B99385D1B96FFD387B7C8029C9001E079" + var_6);
      }
    }

    var_1 scripts\mp\cranked::oncranked(var_0, var_1, var_2);
  }

  if(var_6 != 0) {
    if(level.teambased)
      level scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["_encstr_8AEF05472BC2D6"], var_6, 0);
    else
      var_1 scripts\mp\gamescore::giveplayerscore("_encstr_ABD70578F3D02C", var_6, var_0);
  }
}

oncommonsuicidedeath(var_0) {
  if(istrue(level.supportcranked))
    var_0 scripts\mp\cranked::cleanupcrankedplayertimer();

  if(isDefined(level.scoremod)) {
    var_1 = level.scoremod["_encstr_AD75063D571AE108"] * -1;

    if(var_1 != 0) {
      if(level.teambased)
        level scripts\mp\gamescore::giveteamscoreforobjective(var_0.pers["_encstr_8AEF05472BC2D6"], var_1, 0);
    }
  }

  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    if(level.teambased)
      level thread scripts\mp\teamrevive::spawnrevivetrigger(var_0, var_0, "_encstr_AA7414CDCABBFAE8935A763B5939BEE6E0C2BBE659C8", "_encstr_AB590C99ED78875F650F3951034D");
  }

  if(level.mpingamelootdrop)
    level thread _encstr_B82C2106669B6BBBC467DAF053A791B3B20F7D8B3A42E708A873ABE0EB050B757A327E::dropplayerstags(var_0, undefined);

  if(isDefined(level.modeonsuicidedeath))
    [[level.modeonsuicidedeath]](var_0);
}

oncommonteamchangedeath(var_0) {
  if(istrue(level.supportcranked))
    var_0 scripts\mp\cranked::cleanupcrankedplayertimer();

  if(isDefined(level.modeonteamchangedeath))
    [[level.modeonteamchangedeath]](var_0);
}

dogtagcommonallyonusecb(var_0) {}

dogtagcommonenemyonusecb(var_0) {}

onspawnplayercommon() {
  if(istrue(game["_encstr_95810CA5B9982DEC9526DEC426F2"])) {
    var_0 = istrue(level.allowprematchdamage) && istrue(level.spawnprotectiontimer);
    thread managespawnprotection(var_0);
  } else if(istrue(level.spawnprotectiontimer)) {
    if(isDefined(level._id_1368D)) {
      if([[level._id_1368D]]())
        thread managespawnprotection(1);
    } else
      thread managespawnprotection(1);
  }

  if(scripts\mp\utility\game::isteamreviveenabled())
    thread scripts\mp\teamrevive::updaterevivetriggerspawnposition();

  if(istrue(level.disablesupersprint))
    self allowsupersprint(0);

  if(istrue(level.loadout_updateammo)) {
    self allowmountside(0);
    self allowmounttop(0);
  }

  if(isDefined(level.modeonspawnplayer))
    [[level.modeonspawnplayer]]();
  else
    thread updatematchstatushintonspawncommon();

  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    updatealiveomnvars();

  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    if(istrue(level._id_1343F))
      thread _id_13440();
    else
      self sethudtutorialmessage("_encstr_970D1E1BC37123F9D7C6340D79F7B1E9495659AD1F1815192B2F7EE715B58935");
  } else if(!isagent(self))
    self clearhudtutorialmessage();

  if(istrue(level.set_systems_init_flag))
    thread _id_1438C();

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    self.spawnloot = 0;

    if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      thread _id_1439B();

    if(getdvarint("_encstr_A1E8188F8693895078A0DB97CA0E67EEC0606B39D74DDD9971AE", 1) == 2)
      thread _id_136B2();
  }
}

nvghintnotify(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A13613A36B47B9EF101EBBF02FF3254B48E308A7D9");
  self endon("_encstr_A13613A36B47B9EF101EBBF02FF3254B48E308A7D9");
  var_1 = 1;

  if(!isDefined(var_0))
    var_0 = 0;

  for(;;) {
    if(var_1)
      self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
    else
      self waittill("_encstr_BA350853C128FB939DB9");

    if(var_0 < 2) {
      if(self usinggamepad())
        var_2 = 32;
      else
        var_2 = 33;

      if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
        level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(var_2);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      } else {
        if(!var_0)
          wait 5;

        scripts\mp\utility\lower_message::setlowermessageomnvar(var_2);
        wait 5;
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      }

      var_0++;
      continue;
    }

    break;
  }
}

onplayerkilledcommon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    updatealiveomnvars();

  if(scripts\mp\utility\game::islaststandenabled() && istrue(self.inlaststand) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    oncommonnormaldeath(self, var_1, var_9, var_3, var_4, var_10);

  if(isDefined(level.onplayerkilled))
    [[level.onplayerkilled]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(level._id_12037))
    [[level._id_12037]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(level._id_12070))
    [[level._id_12070]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

onplayerconnectcommon() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(isDefined(level.onplayerconnect))
      level thread[[level.onplayerconnect]](var_0);

    if(scripts\cp_mp\utility\game_utility::isnightmap())
      var_0 thread nvghintnotify();

    var_0 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", 65);
    var_0 setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 0);

    if(level.set_systems_init_flag > 0) {
      var_0.pers["_encstr_959506B911C79707"] = "_encstr_A90B0D7BF38003BF978062EAA87DCF";
      var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.gun_loadouts["_encstr_8E8405EA382B2A"];

      if(!isDefined(var_0.pers["_encstr_BE671094359E5D20536525F848D1FD57EFA1"])) {
        var_0.pers["_encstr_BE671094359E5D20536525F848D1FD57EFA1"] = 0;
        var_0.gungamegunindex = 0;
      } else
        var_0.gungamegunindex = var_0.pers["_encstr_BE671094359E5D20536525F848D1FD57EFA1"];

      if(!isDefined(var_0.pers["_encstr_A98A146805EAE8C62755B8A69804E78DFDC765F107F8"])) {
        var_0.pers["_encstr_A98A146805EAE8C62755B8A69804E78DFDC765F107F8"] = 0;
        var_0.gungameprevgunindex = 0;
      } else
        var_0.gungameprevgunindex = var_0.pers["_encstr_A98A146805EAE8C62755B8A69804E78DFDC765F107F8"];

      scripts\mp\flags::gameflagwait("_encstr_8A200C3BABE6EC0BB6B2FADCB247");
      var_0 thread _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::keepweaponsloaded();
    }
  }
}

onplayerdisconnectcommon(var_0) {
  if(scripts\mp\utility\game::getgametypenumlives() != 0)
    var_0 updatealiveomnvars();

  if(isDefined(level.onplayerdisconnect))
    var_0 thread[[level.onplayerdisconnect]](var_0);
}

onplayerjointeamcommon(var_0) {
  if(isDefined(level.onplayerjointeam))
    [[level.onplayerjointeam]](self);

  if(istrue(level.dogtagsenabled))
    _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::onplayerjoinedteam(var_0);

  if(istrue(level.usezonecapture))
    _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::onplayerjoinedteam(var_0);

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    var_0 thread nvghintnotify(1);
}

managespawnprotection(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A909186AD370C5FB95C6033B69F4E3B1F065FFD47BD8CB4F48D8");
  thread applyspawnprotection();

  if(!istrue(level.allowprematchdamage))
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(var_0)
    wait(level.spawnprotectiontimer);

  thread removespawnprotection();
}

applyspawnprotection() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A909186AD370C5FB95C6033B69F4E3B1F065FFD47BD8CB4F48D8");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self.spawnprotection = 1;
  scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
}

removespawnprotection() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self))
    self.spawnprotection = 0;

  scripts\mp\lightarmor::lightarmor_unset(self);
  self notify("_encstr_A909186AD370C5FB95C6033B69F4E3B1F065FFD47BD8CB4F48D8");
}

updatealiveomnvars() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    var_0 = 0;

    foreach(var_2 in level.teamnamelist)
    var_0 = var_0 + scripts\mp\utility\teams::getteamdata(var_2, "_encstr_8A2A0B936CCCC3078547970A8B");

    setomnvar("_encstr_939810432BB9E331F8C0E847A9D141BA337A", 0);
    setomnvar("_encstr_968A0ED52D7D58F02DDCAF58C6966759", var_0);
  } else {
    setomnvar("_encstr_939810432BB9E331F8C0E847A9D141BA337A", scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_8A2A0B936CCCC3078547970A8B"));
    setomnvar("_encstr_968A0ED52D7D58F02DDCAF58C6966759", scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_8A2A0B936CCCC3078547970A8B"));
  }
}

updatematchstatushintonspawncommon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 0);
}

ffmessageonspawn() {
  wait 1;

  if(isDefined(self))
    scripts\mp\hud_message::showerrormessage("_encstr_ACE51A95D118B801131139FD243FD185E9E21FF70FB4D9A43924A541");
}

_id_13440() {
  self endon("_encstr_AD75063D571AE108");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    thread scripts\mp\utility\print::tutorialprint("_encstr_970D1E1BC37123F9D7C6340D79F7B1E9495659AD1F1815192B2F7EE715B58935", 5);
    wait 6;
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
    thread scripts\mp\utility\print::tutorialprint("_encstr_BD4E1EF58F1738FE5DB1F7DF2934A630B398CABD98FF403904C1C7CBA1ED6879", 5);
  } else
    thread scripts\mp\utility\print::tutorialprint("_encstr_BD4E1EF58F1738FE5DB1F7DF2934A630B398CABD98FF403904C1C7CBA1ED6879", 5);
}

bearsred() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC"] = "_encstr_91610B08574B5CC95953036D07";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8"] = "_encstr_91610B08574B5CC95953036D07";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F"] = "_encstr_8E24111C59E45BBEB1F6C62389B1B7DB19AC91";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B"] = "_encstr_95DC100B5F7A50A052A7CBED836A7D180D37";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A360EC74F39AA043E1D2333C71D30C3"] = "_encstr_B89109C1AC9CD6D756DE46";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2"] = "_encstr_84BB0B588A42370E779840467C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95"] = "_encstr_8E910FA7EDE63426CB02DF61364A69B319";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF8F161B6A1D60CB923B796BDF2A05C8A680065057543871"] = "_encstr_83C90F7B22BBDA91BC0981892B243893A3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765"] = "_encstr_82AE0EA01B400CA7682BBAD390B3A305";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A15715DCE059D85A0B631D2FEB9BE89C0B47AC3BD237E8"] = "_encstr_970B0E0EB2936DFA0EDB96DCE8DA0B9B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDD614CD83951BD28563D1977D8BAEA5C66D7D99963C"] = "_encstr_85070EFBF30E826FA08B44CE6030916B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F"] = "_encstr_8C7F0D33D8BB9309E5B5D20BA8EF82";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6"] = "_encstr_840A0F934FF6D7795376C673CFF0C7698A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92B519E6C12BC6D22C8D1D2FEB56F0474EC2D76E434E2C83DC95C6"] = "_encstr_87A80E78C398D46FAE10033A3B08DF4D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A6F51B234BDFF6086654D9DB7FCA884D7F72F948226FB581FE3FE5CB7B"] = "_encstr_86A215A3099E07792859A5AB03D0FD5746833ADAF0F5AF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735"] = "_encstr_97790D784A224469B3EB78C0BBB9EB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A98E15C8705AAAC417D19C23490BD537C957A61343BFAB"] = "_encstr_A64F0DD95DAA6880FB033179BA97CE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A925123F2B991E48CFE833A7EF1C3D73384F6733"] = "_encstr_A1260C78AA62D7EEDB6520AD5DF3";
}

_id_12070(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && isDefined(var_1) && isDefined(var_1.team) && var_1.team == "_encstr_8E8405EA382B2A") {
    return;
  }
  self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(istrue(var_1.isjuggernaut)) {
    return;
  }
  self.spawnloot = 0;

  if(isDefined(var_1) && istrue(var_1.iszombie)) {
    return;
  }
  if(!var_1 scripts\mp\riotshield::riotshield_hasweapon()) {
    if(!isDefined(var_1.spawnloot))
      var_1.spawnloot = 1;
    else {
      var_1.spawnloot++;

      if(var_1.spawnloot == level.spawnoffsettacinsertmin) {
        var_10 = var_1 getcustomizationbody();
        var_11 = var_1 getcustomizationhead();
        var_12 = var_1 getcustomizationviewmodel();
        var_1 detachall();
        var_1 setModel(var_10);
        var_1 setviewmodel(var_12);
        var_13 = scripts\engine\utility::ter_op(var_1.team == "_encstr_9A8507BA4040188D08", "_encstr_9BCD2743562C327DD6E0BE34AB5B58CDFA385DDA83AD2DCDAF35C2C6B6F636C2DCE82B93E6F5C8F5C4", "_encstr_88CD2721F58B2C6693F8B8531D8AC6A8CF971FFDB30BABEBA72DE34A84E759E0780412CB70013BB937");
        var_1 attach(var_13, "_encstr_B40101", 1);
        var_1.headmodel = var_13;
      } else if(var_1.spawnloot == level.spawnoutofboundstrigger)
        var_1 setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_840E07CCD8B0DA2B9B", 0);
    }
  }
}

_id_1439B() {
  waitframe();
  self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

_id_136B2() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    return;
  }
  var_0 = self getcustomizationbody();
  var_1 = self getcustomizationhead();
  var_2 = self getcustomizationviewmodel();
  self detachall();
  self setModel(var_0);
  self setviewmodel(var_2);
  var_3 = scripts\engine\utility::ter_op(self.team == "_encstr_9A8507BA4040188D08", "_encstr_9BCD2743562C327DD6E0BE34AB5B58CDFA385DDA83AD2DCDAF35C2C6B6F636C2DCE82B93E6F5C8F5C4", "_encstr_88CD2721F58B2C6693F8B8531D8AC6A8CF971FFDB30BABEBA72DE34A84E759E0780412CB70013BB937");
  self attach(var_3, "_encstr_B40101", 1);
  self.headmodel = var_3;
}

_id_1439C() {
  scripts\mp\flags::initgameflags();
  scripts\mp\flags::gameflaginit("_encstr_8A200C3BABE6EC0BB6B2FADCB247", 0);

  while(!isDefined(level.weaponmapdata))
    waitframe();

  wait 0.1;
  level.blockweapondrops = 1;
  level.setback = 1;
  level.setbackstreak = 0;
  level.killsperweapon = 1;
  level.ladderindex = level.set_systems_init_flag;
  _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::setgunladder();
  _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::setgunsfinal();

  if(turret_enemy_watcher_internal())
    level._id_12037 = ::_id_12038;
  else
    level._id_12037 = ::_id_12037;

  scripts\mp\flags::gameflagset("_encstr_8A200C3BABE6EC0BB6B2FADCB247");
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = getnextgun(0);
}

_id_12037(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    if(isDefined(self.pers["_encstr_A1B90BC25B81E32841B9C081E7"]) && self.pers["_encstr_A1B90BC25B81E32841B9C081E7"].size > 0)
      self.pers["_encstr_A1B90BC25B81E32841B9C081E7"] = [];

    if(isDefined(var_1.pers["_encstr_A1B90BC25B81E32841B9C081E7"]) && var_1.pers["_encstr_A1B90BC25B81E32841B9C081E7"].size > 0)
      var_1.pers["_encstr_A1B90BC25B81E32841B9C081E7"] = [];
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_4) && var_1 != self) {
    return;
  }
  if(var_3 == "_encstr_87A10C9D24E997A01F21838F3D34" || isDefined(var_1) && isPlayer(var_1)) {
    var_10 = scripts\mp\riotshield::isriotshield(var_4.basename);
    var_11 = scripts\mp\utility\weapon::isknifeonly(var_4.basename) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_4.basename) || scripts\mp\utility\weapon::isaxeweapon(var_4.basename) || scripts\mp\utility\weapon::update_health_bar_to_player(var_4);
    var_12 = isDefined(var_3) && var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001";

    if(!isDefined(self.ladderdeathsthisweapon))
      self.ladderdeathsthisweapon = 1;
    else
      self.ladderdeathsthisweapon++;

    if(var_3 == "_encstr_87A10C9D24E997A01F21838F3D34" || var_1 == self || var_3 == "_encstr_8DED0A21C79B660BC7588981" && var_11 || self.ladderdeathsthisweapon == level.setbackstreak || var_12) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D");
      self notify("_encstr_95481357388C581D59AF1BBDC291BB56C207EDCDDC");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        if(level.teambased)
          scripts\mp\gamescore::giveplayerscore("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B", 0);
        else
          scripts\mp\gamescore::giveplayerscore("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B", 0);

        thread scripts\mp\rank::scoreeventpopup("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B");
        var_13 = getnextgun();
        var_13 = scripts\mp\weapons::updatesavedaltstate(var_13);
        self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_13;
        self.preloadedclassstruct = undefined;
      }

      if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
        if(self.gungameprevgunindex)
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AFA217E9F32FB3409F7739A79DED53883F8FD7EB66133F152A");

        var_1 scripts\mp\awards::givemidmatchaward("_encstr_958A0FB5DBC8B2D79D5DDCEB6BB2B19595");
      }

      if(var_1 == self)
        return;
    }

    if(var_1 != self && var_3 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_3 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799" || var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_3 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83" || var_3 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_3 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_3 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_3 == "_encstr_9B0D099AD3887D91252954" || var_3 == "_encstr_8DED0A21C79B660BC7588981" && var_1 update_readings() && (var_11 || var_10 || var_12) || var_3 == "_encstr_8DED0A21C79B660BC7588981" && !var_11 || var_12) {
      var_14 = getweaponbasename(var_1.primaryweapon);

      if(!var_1 get_available_unique_id(var_4, var_14, var_12, var_10, var_11)) {
        return;
      }
      if(!isDefined(var_1.ladderkillsthisweapon))
        var_1.ladderkillsthisweapon = 1;
      else
        var_1.ladderkillsthisweapon++;

      if(var_1.ladderkillsthisweapon != level.killsperweapon) {
        return;
      }
      var_1.ladderkillsthisweapon = 0;
      var_1.ladderdeathsthisweapon = 0;
      var_1.gungameprevgunindex = var_1.gungamegunindex;
      var_1.gungamegunindex++;
      var_1.pers["_encstr_A98A146805EAE8C62755B8A69804E78DFDC765F107F8"] = var_1.gungamegunindex;
      var_1.pers["_encstr_BE671094359E5D20536525F848D1FD57EFA1"]++;
      var_1 notify("_encstr_95481357388C581D59AF1BBDC291BB56C207EDCDDC");

      if(level.teambased)
        var_1 scripts\mp\gamescore::giveplayerscore("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5", 0);
      else
        var_1 scripts\mp\gamescore::giveplayerscore("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5", 0);

      if(var_1.gungamegunindex < level.gun_guns.size) {
        var_15 = scripts\mp\rank::getscoreinfovalue("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
        var_1 thread scripts\mp\rank::scorepointspopup(var_15);
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
        var_1 playlocalsound("_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255");
        var_13 = var_1 getnextgun();
        var_13 = scripts\mp\weapons::updatesavedaltstate(var_13);
        var_1.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_13;
        var_1.preloadedclassstruct = undefined;
        var_1 thread givenextgun(0);
      } else if(var_1.gungamegunindex >= level.gun_guns.size) {
        var_1.gungamegunindex = 0;
        var_1.gungameprevgunindex = 0;
        var_1.pers["_encstr_A98A146805EAE8C62755B8A69804E78DFDC765F107F8"] = 0;
        var_1.pers["_encstr_BE671094359E5D20536525F848D1FD57EFA1"] = 0;
        var_15 = scripts\mp\rank::getscoreinfovalue("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
        var_1 thread scripts\mp\rank::scorepointspopup(var_15);
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
        var_1 playlocalsound("_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255");
        var_13 = var_1 getnextgun();
        var_13 = scripts\mp\weapons::updatesavedaltstate(var_13);
        var_1.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_13;
        var_1.preloadedclassstruct = undefined;
        var_1 thread givenextgun(0);
      }

      var_1.lastgunrankincreasetime = gettime();
    }
  }
}

get_available_unique_id(var_0, var_1, var_2, var_3, var_4) {
  if(var_0.basename == var_1)
    return 1;

  if(var_1 == "_encstr_88AC1394CB88B917A8A797F32F539A05376FD02DD3") {
    if(issubstr(var_0.basename, "_encstr_A69B053982C355"))
      return 1;
  }

  if(var_0.basename == "_encstr_AB45111102C198104A7F7D255FC2E5A8A75D1B")
    return 1;

  if(update_readings()) {
    if(var_2 || var_3 || var_4)
      return 1;
  }

  return 0;
}

update_readings() {
  return self.gungamegunindex == level.gun_guns.size - 1;
}

_id_12038(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    if(isDefined(self.pers["_encstr_A1B90BC25B81E32841B9C081E7"]) && self.pers["_encstr_A1B90BC25B81E32841B9C081E7"].size > 0)
      self.pers["_encstr_A1B90BC25B81E32841B9C081E7"] = [];

    if(isDefined(var_1.pers["_encstr_A1B90BC25B81E32841B9C081E7"]) && var_1.pers["_encstr_A1B90BC25B81E32841B9C081E7"].size > 0)
      var_1.pers["_encstr_A1B90BC25B81E32841B9C081E7"] = [];
  }

  var_10 = isDefined(var_3) && var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001";

  if(var_3 == "_encstr_87A10C9D24E997A01F21838F3D34" || isDefined(var_1) && isPlayer(var_1)) {
    if(!isDefined(self.ladderdeathsthisweapon))
      self.ladderdeathsthisweapon = 1;
    else
      self.ladderdeathsthisweapon++;

    if(var_3 == "_encstr_87A10C9D24E997A01F21838F3D34" || var_1 == self || var_3 == "_encstr_8DED0A21C79B660BC7588981" || self.ladderdeathsthisweapon == level.setbackstreak || var_10) {
      self.ladderdeathsthisweapon = 0;
      self playlocalsound("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D");
      self notify("_encstr_95481357388C581D59AF1BBDC291BB56C207EDCDDC");
      self.gungameprevgunindex = self.gungamegunindex;
      self.gungamegunindex = int(max(0, self.gungamegunindex - level.setback));

      if(self.gungameprevgunindex > self.gungamegunindex) {
        if(level.teambased)
          scripts\mp\gamescore::giveplayerscore("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B", 0);
        else
          scripts\mp\gamescore::giveplayerscore("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B", 0);

        thread scripts\mp\rank::scoreeventpopup("_encstr_A1DB11391DF2BF99D501CE179F7DC750A7755B");
        var_11 = getnextgun();
        var_11 = scripts\mp\weapons::updatesavedaltstate(var_11);
        self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_11;
        self.preloadedclassstruct = undefined;
      }

      if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
        if(self.gungameprevgunindex)
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AFA217E9F32FB3409F7739A79DED53883F8FD7EB66133F152A");

        var_1 scripts\mp\awards::givemidmatchaward("_encstr_958A0FB5DBC8B2D79D5DDCEB6BB2B19595");
      }

      if(var_1 == self)
        return;
    }

    if(isDefined(var_1.lastgunrankincreasetime) && var_1.lastgunrankincreasetime + 500 > gettime()) {
      return;
    }
    if(!isDefined(var_1.ladderkillsthisweapon))
      var_1.ladderkillsthisweapon = 1;
    else
      var_1.ladderkillsthisweapon++;

    if(var_1.ladderkillsthisweapon != level.killsperweapon) {
      return;
    }
    var_1.ladderkillsthisweapon = 0;
    var_1.ladderdeathsthisweapon = 0;
    var_1.gungameprevgunindex = var_1.gungamegunindex;
    var_1.gungamegunindex++;
    var_1.pers["_encstr_A98A146805EAE8C62755B8A69804E78DFDC765F107F8"] = var_1.gungamegunindex;
    var_1.pers["_encstr_BE671094359E5D20536525F848D1FD57EFA1"]++;
    var_1 notify("_encstr_95481357388C581D59AF1BBDC291BB56C207EDCDDC");

    if(level.teambased)
      var_1 scripts\mp\gamescore::giveplayerscore("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5", 0);
    else
      var_1 scripts\mp\gamescore::giveplayerscore("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5", 0);

    if(var_1.gungamegunindex < level.gun_guns.size) {
      var_12 = scripts\mp\rank::getscoreinfovalue("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
      var_1 thread scripts\mp\rank::scorepointspopup(var_12);
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
      var_1 playlocalsound("_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255");
      var_11 = var_1 getnextgun();
      var_11 = scripts\mp\weapons::updatesavedaltstate(var_11);
      var_1.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_11;
      var_1.preloadedclassstruct = undefined;
      var_1 thread givenextgun(0, undefined, var_1 scripts\cp_mp\utility\player_utility::isusingremote());
    } else if(var_1.gungamegunindex >= level.gun_guns.size) {
      var_1.gungamegunindex = 0;
      var_1.gungameprevgunindex = 0;
      var_1.pers["_encstr_A98A146805EAE8C62755B8A69804E78DFDC765F107F8"] = 0;
      var_1.pers["_encstr_BE671094359E5D20536525F848D1FD57EFA1"] = 0;
      var_12 = scripts\mp\rank::getscoreinfovalue("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
      var_1 thread scripts\mp\rank::scorepointspopup(var_12);
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_847510CE1696DCCA32D7B3D573D7C9B0CDB5");
      var_1 playlocalsound("_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255");
      var_11 = var_1 getnextgun();
      var_11 = scripts\mp\weapons::updatesavedaltstate(var_11);
      var_1.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_11;
      var_1.preloadedclassstruct = undefined;
      var_1 thread givenextgun(0, undefined, var_1 scripts\cp_mp\utility\player_utility::isusingremote());
    }

    var_1.lastgunrankincreasetime = gettime();
  }
}

_id_1438C() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(self.gungamegunindex == level.gun_guns.size)
    self.gungamegunindex = self.gungameprevgunindex;

  thread givenextgun(1);
}

givenextgun(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_AA8C12846C53FBC55D9B2118BF651F23CAD20898");
  self endon("_encstr_AA8C12846C53FBC55D9B2118BF651F23CAD20898");

  if(isDefined(self.infil))
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(istrue(var_2)) {
    while(scripts\cp_mp\utility\player_utility::isusingremote())
      wait 0.05;

    wait 1;
  }

  if(!var_0)
    scripts\common\utility::allow_weapon_switch(0);

  var_3 = getnextgun();
  var_3 = scripts\mp\weapons::updatesavedaltstate(var_3);

  if(!var_0 && !istrue(var_1) || isbot(self))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);

  if(var_0 && isbot(self)) {
    self setspawnweapon(var_3);

    foreach(var_5 in self.weaponlist) {
      if(var_5 != var_3)
        thread scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var_5);
    }
  }

  if(!var_0 && !istrue(var_1) || isbot(self)) {
    self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"] = var_3.basename;
    self.primaryweapon = var_3.basename;
    self.primaryweaponobj = var_3;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
  }

  if(!var_0 && !istrue(var_1)) {
    var_7 = self.lastdroppableweaponobj;
    thread takeweaponwhensafegungame(var_7, 1);
  }

  scripts\mp\weapons::updatetogglescopestate(var_3);
  self.gungameprevgunindex = self.gungamegunindex;

  if(!isDefined(self.lastgunpromotiontime))
    self.lastgunpromotiontime = gettime();

  var_8 = (gettime() - self.lastgunpromotiontime) / 1000;
  self.lastgunpromotiontime = gettime();

  if(isDefined(self.pers["_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6"]) && var_8 > self.pers["_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6"])
    self.pers["_encstr_8A271936DB9BECACB9D18A96B5593583569BD1E9E6D52B58C1DBE6"] = var_8;
}

takeweaponwhensafegungame(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  if(var_1)
    scripts\common\utility::allow_weapon_switch(1);
}

getnextgun(var_0) {
  var_1 = self.gungamegunindex;

  if(isDefined(var_0))
    var_1 = var_0;

  var_2 = level.gun_guns[var_1];
  return var_2;
}

_id_131C1() {
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_8D900DB477077D1C2DD736E0C28385";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = 0;
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.gun_loadouts["_encstr_8E8405EA382B2A"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = 0;
  level.gun_loadouts["_encstr_9A8507BA4040188D08"] = level.gun_loadouts["_encstr_8E8405EA382B2A"];
}

tv_station_infil_enemy_combat_logic() {
  return level.set_systems_init_flag == 1;
}

tv_station_infil_enemies_attack_logic() {
  return level.set_systems_init_flag == 2;
}

tv_station_global_stealth_broken() {
  return level.set_systems_init_flag == 3;
}

turret_enemy_watcher_internal() {
  return level.set_systems_init_flag == 7 || level.set_systems_init_flag == 8 || level.set_systems_init_flag == 9 || level.set_systems_init_flag == 10;
}

_id_1326E() {
  level._id_1346D = [];
  var_0 = [];
  var_1 = undefined;

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
    var_2 = getEntArray("_encstr_BE220B4E0117F8B7861D7D7819", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = var_2[0].origin + (0, 0, 30);
  } else {
    var_0 = [];
    var_3 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_3) {
      if(var_5.script_label == "_encstr_B40703E96D") {
        var_0[var_0.size] = var_5.origin;
        break;
      }
    }

    if(var_0.size == 0) {
      return;
    }
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_1 = var_0[0];

    if(getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") == "_encstr_A3930F8FD35F7A396BA3D6614DF1A0B245")
      var_1 = (-194, -858, 90);
  }

  var_7 = [];
  var_8 = getEntArray("_encstr_BE8D16A62BEA2DED5168AD8AC923D87222E7631750ABA481", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_10 in var_8)
  var_7[var_7.size] = var_10.origin;

  level._id_11E00 = var_7;
  var_12 = undefined;

  if(getdvarint("_encstr_8A271AB9D89CEB6EB78D6C56C9D7270BE619BDAD351C0BDDB913F68D", 0) == 1 && var_7.size > 0) {
    var_12 = 1;
    var_0 = scripts\engine\utility::array_combine(var_0, var_7);
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_1 = var_0[0];
  }

  level thread init_reach_exhaust_waste(var_1, 1);
}

init_reach_exhaust_waste(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  var_2 = var_0 + (0, 0, 64);
  var_3 = var_0 + (0, 0, -64);
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, scripts\engine\trace::create_default_contents(1));
  var_0 = var_4["_encstr_BD260953AA97E3F014279D"] + (0, 0, 30);
  var_5 = spawnStruct();
  var_5.angles = (0, 0, 0);
  var_5.visuals = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5.visuals setModel("_encstr_933811584EA3FA9BE8B046B4575BD74C2CD863");
  var_5.visuals dontinterpolate();
  var_5._id_12C7B = var_0;
  var_5.usemilestonephases = 1;
  var_5.onreset = ::_id_1208B;
  var_5._id_1203A = ::_id_1203A;
  var_5._id_13472 = ::_id_13789;
  var_6 = (0, 30, 0);
  var_7 = anglestoup(var_6);
  var_8 = anglesToForward(var_6);

  if(getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") == "_encstr_A90A0D75F9E1455F9EA3227A68F5EF")
    var_9 = var_7 * 500 + (0, 0, 80);
  else
    var_9 = var_7 * 50 + (0, 0, 80);

  waittillframeend;
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_5.visuals physicslaunchserver(var_5.visuals.origin, var_9);
  var_5 thread _id_12167();
  var_5 thread _id_12168();

  if(getdvarint("_encstr_ADF21490877AEECFEAAD5D4802220FD1D56BA8F8F70C", 1) == 1)
    var_5 thread _id_13470();

  if(isDefined(var_5._id_13472))
    var_5[[var_5._id_13472]]();

  level._id_1346D[level._id_1346D.size] = var_5;
}

_id_13789() {
  self.visuals thread scripts\mp\utility\entity::register_physics_collisions();
  self.visuals physics_registerforcollisioncallback();
  scripts\mp\utility\entity::register_physics_collision_func(self.visuals, ::ball_impact_sounds);
}

ball_impact_sounds(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0 physics_getbodyid(0);
  var_10 = physics_getbodylinvel(var_9);
  var_11 = length(var_10);

  if(isDefined(var_0.playing_sound) || var_11 < 70) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.playing_sound = 1;
  var_12 = physics_getsurfacetypefromflags(var_4);
  var_13 = getsubstr(var_12["_encstr_84BA05A8CA852B"], 9);

  if(var_13 == "_encstr_A1140EEA6EB2E4EB3A9593C90BB4734C")
    var_0 playSound("_encstr_95461688E2CEA751A744199822F7FBBDB62A719B7AE60968");
  else if(var_11 < 180)
    var_0 playsurfacesound("_encstr_95461688E2CEA751A744199822F7FBBDB62A719B7AE60968", var_13);
  else if(var_11 < 260)
    var_0 playsurfacesound("_encstr_AB021443F553C9062AF391EFD392D508EBCF4E189FBC", var_13);
  else
    var_0 playsurfacesound("_encstr_AABD16C8A28EE711E70459D8E2373B7D76EA31B8FA62DF89", var_13);

  wait 0.1;
  var_0.playing_sound = undefined;
}

_id_1208B(var_0) {
  self.stage3accradius = 1;

  if(!istrue(var_0)) {
    wait 0.5;
    self.visuals playSound("_encstr_ABE010C79F128838512DB0AED33910DB4B2B");
    playFX(level._id_1346C["_encstr_8BE007AB0FE8607F9B"], self.visuals.origin);
  } else {
    wait 0.1;
    playFX(level._id_1346C["_encstr_8BE007AB0FE8607F9B"], self.visuals.origin);
  }

  self.visuals hide();
  wait 1;
  self.visuals.origin = self._id_12C7B;
  var_1 = (0, 30, 0);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);

  if(level.mapname == "_encstr_A90A0D75F9E1455F9EA3227A68F5EF")
    var_4 = var_2 * 500 + (0, 0, 80);
  else
    var_4 = var_2 * 50 + (0, 0, 80);

  self.visuals show();
  self.visuals physicslaunchserver(self.visuals.origin, var_4);
  self.stage3accradius = 0;

  if(isDefined(self._id_13472))
    self[[self._id_13472]]();
}

_id_1203A(var_0) {
  if(istrue(self.stage3accradius)) {
    self.stage3accradius = 0;
    return;
  }

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_1 = scripts\mp\utility\game::getotherteam(var_0.team)[0];

    if(var_1 == "_encstr_9A8507BA4040188D08") {
      game["_encstr_834E0A77E3CA7B1FBF07C253"]++;
      var_2 = "_encstr_88A7079FB7DFC4D95F";
    } else {
      game["_encstr_87F20C10DA05F389E777808F249F"]++;
      var_2 = "_encstr_81A7076FD70B156F0E";
    }
  } else {
    var_1 = var_0.team;

    if(var_1 == "_encstr_9A8507BA4040188D08") {
      game["_encstr_87F20C10DA05F389E777808F249F"]++;
      var_2 = "_encstr_81A7076FD70B156F0E";
    } else {
      game["_encstr_834E0A77E3CA7B1FBF07C253"]++;
      var_2 = "_encstr_88A7079FB7DFC4D95F";
    }
  }

  if(isDefined(var_2))
    scripts\engine\utility::exploder(var_2);

  var_3 = "_encstr_B8B30883ACAFCF8579EC";

  if(isDefined(var_3))
    scripts\engine\utility::exploder(var_3);

  var_0.select_low_roof_spawners++;
  level _id_14017(var_0);
  var_0 thread select_lobby_door_two_spawners();

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
    foreach(var_5 in level.players) {
      if(var_5.team == var_1) {
        if(var_5.team == "_encstr_9A8507BA4040188D08")
          var_5 thread _id_12736("_encstr_8EFD1D64F1F95DCBBFFE3B73A3013F92F0B315ED7D5167575151E15AA8EFCB" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "_encstr_A9D111B957ADB5CAE4D7B30BD6CAEB767BC236", 2, "_encstr_8F0A11503A16177913BF545899B3E6F13C6228");
        else
          var_5 thread _id_12736("_encstr_AB741DA1C1575ACA61C7A5126C7539431D7F620DAABF4AD96B2F7121D8B9FD" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "_encstr_A9D111B957ADB5CAE4D7B30BD6CAEB767BC236", 2, "_encstr_8F0A11503A16177913BF545899B3E6F13C6228");

        continue;
      }

      if(var_5.team == "_encstr_9A8507BA4040188D08") {
        var_5 thread _id_12736("_encstr_AB741DA1C1575ACA61C7A5126C7539431D7F620DAABF4AD96B2F7121D8B9FD" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "_encstr_A9D111B957ADB5CAE4D7B30BD6CAEB767BC236", 2, "_encstr_8D400F86E50AFF99425718609764161BD3");
        continue;
      }

      var_5 thread _id_12736("_encstr_8EFD1D64F1F95DCBBFFE3B73A3013F92F0B315ED7D5167575151E15AA8EFCB" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "_encstr_A9D111B957ADB5CAE4D7B30BD6CAEB767BC236", 2, "_encstr_8D400F86E50AFF99425718609764161BD3");
    }
  } else {
    foreach(var_5 in level.players) {
      if(var_5.team == "_encstr_9A8507BA4040188D08") {
        var_5 thread _id_12736("_encstr_AB741DA1C1575ACA61C7A5126C7539431D7F620DAABF4AD96B2F7121D8B9FD" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "_encstr_A9D111B957ADB5CAE4D7B30BD6CAEB767BC236", 2, "_encstr_8D400F86E50AFF99425718609764161BD3");
        continue;
      }

      var_5 thread _id_12736("_encstr_8EFD1D64F1F95DCBBFFE3B73A3013F92F0B315ED7D5167575151E15AA8EFCB" + scripts\engine\utility::random(level.select_lobby_door_one_spawners), "_encstr_A9D111B957ADB5CAE4D7B30BD6CAEB767BC236", 2, "_encstr_8D400F86E50AFF99425718609764161BD3");
    }
  }

  self.visuals thread _id_12737();
  var_9 = self.visuals getlinkedchildren();

  foreach(var_11 in var_9) {
    if(isDefined(var_11))
      var_11 unlink(1);
  }

  if(isDefined(self.onreset))
    self thread[[self.onreset]](1);

  if(var_0.select_low_roof_spawners >= 10 && isDefined(game["_encstr_9A4D0A2D85B0EB6CB520E2DA"]) && !game["_encstr_9A4D0A2D85B0EB6CB520E2DA"] || getdvarint("_encstr_B11318DCC6C9F59D2CD62BD7337B93D8B26BABD8E85A2658B1B1", 0) == 1 && isDefined(game["_encstr_9A4D0A2D85B0EB6CB520E2DA"]) && !game["_encstr_9A4D0A2D85B0EB6CB520E2DA"]) {
    game["_encstr_9A4D0A2D85B0EB6CB520E2DA"] = 1;

    foreach(var_5 in level.players)
    var_5 thread scripts\mp\hud_message::showsplash("_encstr_B456110E70864E3F83A7EA2B301B0FE553FB58");

    if(level._id_11E00.size > 0) {
      var_15 = getdvarint("_encstr_8F5D1963278BEFBA438DD9D71E17F62BB0D33FE7AC99E79837DD59", 3);

      for(var_16 = 0; var_16 < var_15; var_16++)
        init_reach_exhaust_waste(level._id_11E00[var_16]);
    }
  }
}

_id_12737() {
  self playSound("_encstr_B4E51133D226F7CE99780930070899F51D4BD9");
  wait 1.5;
  self playSound("_encstr_BD8014AB1DAB31FEC26B39576F0AB7707F7593230413");
}

select_lobby_door_two_spawners(var_0, var_1) {
  for(var_2 = 0; var_2 < min(self.select_low_roof_spawners, 10); var_2++) {
    playFX(level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"], self.trigger.origin + (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-25, 60)), anglesToForward(self.trigger.angles + (randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), 0)), anglestoup(self.trigger.angles + (randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), randomintrange(int(max(clamp(0 - var_2 * 5, -19, 0), -20)), int(min(20, 1 + var_2 * 5))), 0)));

    if(istrue(var_0))
      level thread _id_14397(self.trigger.origin);

    if(isDefined(var_1))
      wait(var_1);
  }
}

_id_14017(var_0) {
  foreach(var_2 in level.brking_playerwelcomesplashes) {
    if(var_2._id_12F11 == var_0.team) {
      if(var_0.select_low_roof_spawners >= 10) {
        var_2.scriptable setscriptablepartstate("_encstr_82FB06EB26785BD7", "_encstr_AF0703133A");
        continue;
      }

      var_2.scriptable setscriptablepartstate("_encstr_82FB06EB26785BD7", "_encstr_934C0218" + scripts\engine\utility::string(var_0.select_low_roof_spawners));
    }
  }
}

_id_12167() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 0.5;

    if(istrue(self.stage3accradius)) {
      continue;
    }
    if(isDefined(self.resetnow)) {
      self.resetnow = undefined;

      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    for(var_0 = 0; var_0 < level.radtriggers.size; var_0++) {
      if(!self.visuals istouching(level.radtriggers[var_0])) {
        continue;
      }
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    for(var_0 = 0; var_0 < level.minetriggers.size; var_0++) {
      if(!self.visuals istouching(level.minetriggers[var_0])) {
        continue;
      }
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    for(var_0 = 0; var_0 < level.hurttriggers.size; var_0++) {
      if(!self.visuals istouching(level.hurttriggers[var_0])) {
        continue;
      }
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();

      continue;
    }

    if(istrue(level.ballallowedtriggers.size)) {
      self.allowedintrigger = 0;

      foreach(var_2 in level.ballallowedtriggers) {
        if(self.visuals istouching(var_2)) {
          self.allowedintrigger = 1;
          break;
        }
      }
    }

    if(isDefined(level.outofboundstriggers)) {
      foreach(var_2 in level.outofboundstriggers) {
        if(istrue(self.allowedintrigger)) {
          break;
        }

        if(!self.visuals istouching(var_2)) {
          continue;
        }
        if(isDefined(self.onreset))
          self thread[[self.onreset]]();

        continue;
      }
    }

    if(isDefined(self.autoresettime)) {
      wait(self.autoresettime);

      if(!isDefined(self.carrier)) {
        if(isDefined(self.onreset))
          self thread[[self.onreset]]();
      }
    }
  }
}

_id_12168() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 0.25;

    if(istrue(self.stage3accradius)) {
      continue;
    }
    if(distancesquared(self.visuals.origin, self._id_12C7B) > 9000000) {
      if(isDefined(self.onreset))
        self thread[[self.onreset]]();
    }
  }
}

_id_13471() {
  var_0 = getEntArray("_encstr_8C720C66B05851629697BFA7D331", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_85B80A1FB898B3E8E1707299", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0 && var_1.size > 0) {
    level.briotshieldinitialized = spawnStruct();
    level.briotshieldinitialized.team = "_encstr_9A8507BA4040188D08";
    level.briotshieldinitialized.trigger = var_0[0];
    level.briotshieldinitialized.entsinside = [];
    level.chooseanim_vehicleturretdeath = spawnStruct();
    level.chooseanim_vehicleturretdeath.team = "_encstr_8E8405EA382B2A";
    level.chooseanim_vehicleturretdeath.trigger = var_1[0];
    level.chooseanim_vehicleturretdeath.entsinside = [];
    level.chooseanim_vehicleturretdeath.select_low_roof_spawners = 0;

    if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
      game["_encstr_87F20C10DA05F389E777808F249F"] = 0;
      level.briotshieldinitialized.select_low_roof_spawners = 0;
      game["_encstr_834E0A77E3CA7B1FBF07C253"] = 0;
      level.chooseanim_vehicleturretdeath.select_low_roof_spawners = 0;
    } else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
      level.chooseanim_vehicleturretdeath.select_low_roof_spawners = game["_encstr_87F20C10DA05F389E777808F249F"];
      level.briotshieldinitialized.select_low_roof_spawners = game["_encstr_834E0A77E3CA7B1FBF07C253"];
    } else {
      level.briotshieldinitialized.select_low_roof_spawners = game["_encstr_87F20C10DA05F389E777808F249F"];
      level.chooseanim_vehicleturretdeath.select_low_roof_spawners = game["_encstr_834E0A77E3CA7B1FBF07C253"];
    }

    level._id_1346E = [level.chooseanim_vehicleturretdeath, level.briotshieldinitialized];
    level thread _id_1439A();
  } else
    level notify("_encstr_9BF5117F1058C8492770160E6D0D0167E0109B");
}

_id_1439A() {
  wait 1;
  level.brjugg_dropfunc = scripts\engine\utility::getStructArray("_encstr_ABCC051AF65B56", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.choosedropbagmodel = scripts\engine\utility::getStructArray("_encstr_A2840585EE16CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.brking_playerwelcomesplashes = scripts\engine\utility::array_combine(level.brjugg_dropfunc, level.choosedropbagmodel);

  foreach(var_1 in level.brjugg_dropfunc) {
    var_1.scriptable = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_1.scriptable.angles = var_1.angles;
    var_1.scriptable setModel("_encstr_AB9022740998173623F047E90B914158E08DEEC28528F1CB249687938B109FB946604855");
    var_1._id_12F11 = "_encstr_9A8507BA4040188D08";
  }

  foreach(var_1 in level.choosedropbagmodel) {
    var_1.scriptable = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_1.scriptable.angles = var_1.angles;
    var_1.scriptable setModel("_encstr_AB9022740998173623F047E90B914158E08DEEC28528F1CB249687938B109FB946604855");
    var_1._id_12F11 = "_encstr_8E8405EA382B2A";
  }

  level _id_14017(level.briotshieldinitialized);
  level _id_14017(level.chooseanim_vehicleturretdeath);
}

_id_13470(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9BF5117F1058C8492770160E6D0D0167E0109B");

  while(!isDefined(level._id_1346E))
    waitframe();

  for(;;) {
    wait 0.05;

    if(istrue(self.stage3accradius)) {
      continue;
    }
    for(var_1 = 0; var_1 < level._id_1346E.size; var_1++) {
      if(!validatefunc(level._id_1346E[var_1], self.visuals)) {
        continue;
      }
      if(!_id_132E7(level._id_1346E[var_1], self.visuals)) {
        continue;
      }
      var_2 = self.visuals getentitynumber();
      level._id_1346E[var_1].entsinside[var_2] = self.visuals;
      self.visuals._id_1346F = level._id_1346E[var_1];

      if(isDefined(self._id_1203A))
        [[self._id_1203A]](level._id_1346E[var_1]);

      continue;
    }
  }
}

_id_132E7(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entsinside[var_2]))
    return 0;

  return 1;
}

validatefunc(var_0, var_1) {
  if(!var_1 istouching(var_0.trigger)) {
    var_2 = var_1 getentitynumber();
    var_0.entsinside[var_2] = undefined;

    if(isDefined(var_1._id_1346F) && var_1._id_1346F == var_0)
      var_1._id_1346F = undefined;

    return 0;
  }

  return 1;
}

_id_14397(var_0) {
  var_1 = "_encstr_B4BF18ECDBE6AF99D2C9B2BBB7395BFA9BD8272BC2ADFA37CCE1";
  playsoundatpos(var_0, var_1);
  var_2 = lookupsoundlength(var_1);
  wait 1.5;
  playsoundatpos(var_0 + (0, 0, 600), "_encstr_84891787C7AEE176404BA72BED70B3390D4163235FC06B2EF0");
}

_id_11962() {
  level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"] = loadfx("_encstr_81CE2967990FBCA5EE077D5B3879B32CADB2DAF6915979B3990F7DB3B7CDEB334B9CB2BBDB39AD713B33C3");
  level._id_1346C["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_831B2ED5A36BD6B3B3405EFFC3F04C76010D65079975B57098D1B6BBDF0F0E4D80485657397219B6A7C27A9DBDA5B93A");
  level._id_1346C["_encstr_A617091F9B2D605D97E7DB"] = loadfx("_encstr_BE3E2FDD56305293FF9FFEA00346D9C84BAD61F7EB9B786DEF63B0E08B4B8B61A21483E95F02A020BB1ACEFBD712446038");
  level._id_1346C["_encstr_B21709B9C6F63995EB6026"] = loadfx("_encstr_B4332FCB98596D07738BCFE54790DB07BD68F2D688E9B64BE815F5AF5C81D3C11F78AADA81BFEEAFA375FF48D7E0235751");
  level._id_1346C["_encstr_B4170908A24D7D31DF98B6"] = loadfx("_encstr_AC452F1CBFA37F306FF2F1683BDF6813ABE79908523BABD929FF78823BAEA22F434B872521E377601AD7E172028EBB859B");
  level._id_1346C["_encstr_B61709E686AABDF90F8ADA"] = loadfx("_encstr_AB232F9B8D03CE51882AF1451B726CA2DC137B064FAD921410EB75DD33D0B0593699D7A3AF56FAC710F1E10283CAE6020B");
  level._id_1346C["_encstr_851709A316A21A5991D351"] = loadfx("_encstr_963C2F159EE88A5B37673678CB7E818003F5592F13533015B7AB4828D30343999A5CCB21977A98E8F34206C3DFCA7C28F0");
  level._id_1346C["_encstr_AD1709DCC6F69395AF0CA6"] = loadfx("_encstr_AA492F76CCF246AC1F2A110A5097A5276B25E457DEDBC737CBA83A26086D98172315719460C307BDA53001CF0A25D3BBFA");
  level._id_1346C["_encstr_841709E357E80A0F30A3CF"] = loadfx("_encstr_A7622F9D66F05E96BBC1FAD607798DCACEAC365EDCE858462DD5B65E67CCF07DCD3AB046D7CD1BDEC956EB0C635CCECCE1");
  level._id_1346C["_encstr_8A17091BD688AB07E7D23F"] = loadfx("_encstr_BA452F103BD8784BE38028C96A9EB9F93EAF4862C78CC9192AFB39E0C322D9E68303B8B00F2341D7C3E738778BFE1D09E0");
  level._id_1346C["_encstr_8C1709C7CFB0236501F3E0"] = loadfx("_encstr_8F0C2FB3CC1E792DBB837D5BC1CB1B56B3CAD8F2DCA385322DEADABC9D33C3BEE6E88532EBB98D7B93B27D03C17167331E");
  level._id_1346C["_encstr_A91709D71BF05272973778"] = loadfx("_encstr_8FEE2F7EB0A0CE884F59BF850A8E9AFA5810B5E73263B0116007AF963B8A10808743709B4E2FB3485885989F9FF0A41F89");
  level._id_1346C["_encstr_BA17096BDE6798BDE1DE41"] = loadfx("_encstr_9A232F3B993CF24BEE1C7DAD07796395ECB2B1CBDC8E0B234BEAB6E5B3CC3C7D6E1D0B467DCDD8B72756FA4C18B83B993C");
}

_id_13237() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C0413E6ABDAB695E4AF9DB0B6CAFAD9DB2CD8AFC4"] = "_encstr_8C0413E6ABDAB695E4AF9DB0B6CAFAD9DB2CD8AFC4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9041387B7B2D14002A191A9D5FD591C4A4F015732"] = "_encstr_A9041387B7B2D14002A191A9D5FD591C4A4F015732";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA0413CDEA6B5B9539D7CEB06B56AF76F616C6FACC"] = "_encstr_BA0413CDEA6B5B9539D7CEB06B56AF76F616C6FACC";
  level.select_lobby_door_one_spawners = ["_encstr_B10703410F", "_encstr_8C0703271D", "_encstr_A90703477F"];
}

_id_12736(var_0, var_1, var_2, var_3) {
  self notify("_encstr_A7ED0CEFAFDFAA37F8318DD2E918");
  self endon("_encstr_A7ED0CEFAFDFAA37F8318DD2E918");

  if(!isDefined(level.lastteamstatustime["_encstr_9A8507BA4040188D08"][var_1]))
    level.lastteamstatustime["_encstr_9A8507BA4040188D08"][var_1] = 0;

  if(gettime() < level.lastteamstatustime["_encstr_9A8507BA4040188D08"][var_1] + var_2 * 1000) {
    return;
  }
  self queuedialogforplayer(var_0, var_1, var_2);
  level.lastteamstatustime["_encstr_9A8507BA4040188D08"][var_1] = gettime();
  thread scripts\mp\hud_message::showsplash(var_3);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\to_hstg.gsc
***********************************************/

main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = ::onstartgametype;
}

maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.startedfromtacops = 1;
  onstartgametype();
}

maintacopsinit() {
  level.tacopssublevel = "_encstr_ADD408F4F719618E2970";
  level.currentmode = "_encstr_ADD408F4F719618E2970";
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);
}

maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("_encstr_ADD408F4F719618E2970", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("_encstr_ADD408F4F719618E2970", 10);
    scripts\mp\utility\game::registerscorelimitdvar("_encstr_ADD408F4F719618E2970", 85);
    scripts\mp\utility\game::registerroundlimitdvar("_encstr_ADD408F4F719618E2970", 1);
    scripts\mp\utility\game::registerwinlimitdvar("_encstr_ADD408F4F719618E2970", 1);
    scripts\mp\utility\game::registernumlivesdvar("_encstr_ADD408F4F719618E2970", 0);
    scripts\mp\utility\game::registerhalftimedvar("_encstr_ADD408F4F719618E2970", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("_encstr_ADD408F4F719618E2970", 0);
  }

  updategametypedvars();
  setuphudelements();
  level.resetscoreonroundstart = 1;
  level.spawnedhostagecount = 0;
  _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::init();
  level.teambased = 1;
  level.onplayerconnect = ::onplayerconnect;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onsuicidedeath = ::onsuicidedeath;
  level.ontimelimit = ::ontimelimit;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_B456150E100E507B52A7BAEBF057D7E553F3609B51C065", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_B6BD0901163E087DCAD7A3"));
  setdynamicdvar("_encstr_A14915336A93F8F0951791DF44FFE13E8712889FD2632D", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_BACF09DD798D48268F4351"));
  setdynamicdvar("_encstr_AA031C4057AA3E393A118B0EB3D227C1E1CB3849C74093E3D387ED1BCD2A", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_A65110FD59AD688EAF2393BB2B97DDA085B5"));
  setdynamicdvar("_encstr_88021AD26198574348475327096439AD9849CE1659103BF893CB5F33", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_99630EBF20E17130DB28FC3D839BDA2C"));
  setdynamicdvar("_encstr_9A1C169B6C39D7E8F6AF1AB9E89DD7130BDC6D21DECDAE9B", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_B6EB0E7209142F3EB865AB8A0FA8BB3F"));
  setdynamicdvar("_encstr_AD1B156BDE7AF135E267F1CFE34AE8100175B103C4DDE8", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_ADD408F4F719618E2970", 0);
  setdynamicdvar("_encstr_814814C39F0690BD7A16F0D31080B15F7D102D02E35D", 0);
}

seticonnames() {
  level.waypointcolors["_encstr_88D8197847B9B36722359D304E9A61FB1D9360C1E37D692FBB9F96"] = "_encstr_A7A408B9CA5D1D4E2C63";
  level.waypointbgtype["_encstr_88D8197847B9B36722359D304E9A61FB1D9360C1E37D692FBB9F96"] = 1;
  level.waypointcolors["_encstr_AF120B78D23BF9C6A7568DF129"] = "_encstr_88BF06FD784A6393";
  level.waypointbgtype["_encstr_AF120B78D23BF9C6A7568DF129"] = 1;
  level.icontarget = "_encstr_8F511ABB16F2E0DE969B8E7D43584E19E0DB2DCD3AFA8EB039CE95A3";
  level.iconneutral = "_encstr_96730D2FF80BE0794D25C3BB967B02";
  level.iconcapture = "_encstr_AF120B78D23BF9C6A7568DF129";
  level.icondefend = "_encstr_AA5E0EFB38032B514DE8E23A109155A7";
  level.iconcontested = "_encstr_A6C21D1FA7E70AAF8B30C529326FF8C477B827133CBEBAAF085B630BFB4345";
  level.icontaking = "_encstr_BD4218BB162FC1EDD2E6E8FAD158ADB4E6D9AF6CA1B2D9C9BDB9";
  level.iconlosing = "_encstr_A3471A8421A74B9714B2F899EA2E65015BC703F0AC9770CFFAAA2050";
  level.iconbombcapture = "_encstr_8F361077FED381AD0833C589FCA8DA67776B";
  level.iconbombdefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.iconrecover = "_encstr_88D8197847B9B36722359D304E9A61FB1D9360C1E37D692FBB9F96";
  level.iconescort = "_encstr_BE7610A351B00882DBB5B3279BFE0A5FB09B";
  level.icondefendhvt = "_encstr_ADEA161721610FB88B60E4F15F7733D1957FC8C398A5B027";
  level.iconkill = "_encstr_8BEE1CA38A68EB0AC08B6B170F39A8D98013E36104B874B0D112B07B7AF1";
}

onstartgametype() {
  createzones();
  seticonnames();
  scripts\mp\tac_ops\hostage_utility::hostagesysteminit();
  setDvar("_encstr_913D0B1D65C41B95DD51E03981", 0.75);
  level.zoneduration = 120;
  level.hostagestates = [];
  level.hostagecarrystates = [];
  level.debughostagegame = 1;
  createhvt();
  level.extractionlocent = getEnt("_encstr_8DB011863B47A80FD14E2CB1A3B4DB9B89DE8D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.hostagecheckpointent = [];
  level.hostagecheckpointent[0] = scripts\engine\utility::getStructArray("_encstr_97DA1344E88723098158075F80BAD05A6BF0CB316F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.hostagecheckpointent[1] = scripts\engine\utility::getStructArray("_encstr_88DA13807FB3337BC2F70824CE1B619801E3E8C1E2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.hostagecheckpointent[2] = scripts\engine\utility::getStructArray("_encstr_81DA13A1EDB947857656BEEEC22F83DE96CDE8EB66", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread createhvtextractionsite();
  level.hostagehidespots = [];
  level.hostagehidespots[0] = level.hvtlocent;
  level.hostageexitpoints = [];
  level.hostageexitpoints[0] = level.objectives[0];
  scripts\mp\tac_ops\hostage_utility::spawnallhostages();
  level.hostages[0].outlineid = scripts\mp\utility\outline::outlineenableforteam(level.hostages[0].body, level.hostages[0].team, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
  setDvar("_encstr_913D0B1D65C41B95DD51E03981", 0.75);
  level.zoneduration = 120;
  level.hostagestates = [];
  level.hostagecarrystates = [];
  level.debughostagegame = 1;
  level.objectives[0] scripts\mp\gameobjects::setkeyobject(level.hostages[0]);
  level.fixedlzs = [];
  level.fixedlzs[0] = level.objectives[0];
  initializefixedlzs();
  level thread watchpushtriggers();

  if(!istrue(level.startedfromtacops)) {
    var_0[0] = "_encstr_8218041DF5FA";
    scripts\mp\gameobjects::main(var_0);
    _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::commoninit();
    activatespawns();
  }

  var_1 = scripts\mp\utility\game::gettimelimit();
  level.extratime = 0;
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 6);
  level.tacopssubmodetimeron = 1;
}

setusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.banktime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B6BD0901163E087DCAD7A3", 2, 0, 10);
  level.bankrate = scripts\mp\utility\dvars::dvarintvalue("_encstr_BACF09DD798D48268F4351", 1, 1, 10);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("_encstr_A65110FD59AD688EAF2393BB2B97DDA085B5", 0, 0, 10);
  level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue("_encstr_99630EBF20E17130DB28FC3D839BDA2C", 5, 5, 15);
  level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue("_encstr_B6EB0E7209142F3EB865AB8A0FA8BB3F", 150, 0, 750);
}

setuphudelements() {
  level.iconenemyextract3d = "_encstr_BE571777C2F2C1B796B9D1EBAC3C472785C6E87DB2DCB2B697";
  level.iconenemyextract2d = "_encstr_BE571777C2F2C1B796B9D1EBAC3C472785C6E87DB2DCB2B697";
  level.iconfriendlyextract3d = "_encstr_B44A1A2F9B9042DFD3A0338929B34B3AB807A4BF3D904CBF08D9AA13";
  level.iconfriendlyextract2d = "_encstr_B44A1A2F9B9042DFD3A0338929B34B3AB807A4BF3D904CBF08D9AA13";
  level.iconfriendlyzone3d = "_encstr_A2301A5F37238FC0A95D433E029CF84C9AA3E787D37BDBA8F6B748F2";
  level.iconfriendlyzone2d = "_encstr_A2301A5F37238FC0A95D433E029CF84C9AA3E787D37BDBA8F6B748F2";
}

updateextracticons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlyextract2d);
}

onspawnplayer() {
  if(isDefined(self.tagscarried))
    self setclientomnvar("_encstr_81730E57C86EEFAB43A08771957BB2A3", self.tagscarried);

  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.hostagecarried = undefined;
  scripts\mp\tac_ops\roles_utility::kitspawn();
}

onplayerconnect(var_0) {
  var_0.isscoring = 0;
  var_0 thread monitorjointeam();
}

monitorjointeam() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_81170C244F9CBDE72C01BB99A298");
    var_0 = 0;

    if(self.team == "_encstr_9A8507BA4040188D08")
      var_0 = 1;
    else if(self.team == "_encstr_8E8405EA382B2A")
      var_0 = 2;

    self setclientomnvar("_encstr_8C460FD55A7D8E16D8DB83B9FAD15616DA", var_0);

    if(!isDefined(level.startedfromtacops)) {
      scripts\mp\supers::clearsuper();
      scripts\mp\tac_ops\roles_utility::latejointeamkitobjective();
    }
  }
}

createzones() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A559170D7BB9D10BCE59AF95E18E272C1B8EEBE9DBDC59AF0A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_8D5917CA7D2E73721F79F01BEBD94EDA36DBE7D007DD995EED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.fixedlzs = scripts\engine\utility::array_combine(var_0, var_1);
  level.objectives = [];
}

zone_ondisableobjective() {
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
}

initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_96691770C2BF40506A3F11CF772327204FDDBE496DE4D01DF3", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_913D153D77A69B9D91A0735AD9FF12871BD087A98B885F", 1);
  var_0.to_hstg_spawns = [];
  var_0.to_hstg_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_96691770C2BF40506A3F11CF772327204FDDBE496DE4D01DF3");
  var_0.to_hstg_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_913D153D77A69B9D91A0735AD9FF12871BD087A98B885F");

  if(var_0.to_hstg_spawns["_encstr_9A8507BA4040188D08"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
    var_0.to_hstg_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
  }

  if(var_0.to_hstg_spawns["_encstr_8E8405EA382B2A"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
    var_0.to_hstg_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
  }
}

getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_0.to_hstg_spawns[var_1]);
  var_3 = undefined;
  return var_3;
}

activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A11904A822A6");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_ADD408F4F719618E2970", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_ADD408F4F719618E2970", "_encstr_8E8405EA382B2A");
  level.getspawnpoint = ::getspawnpoint;
}

ontimelimit() {
  endhostagegame("_encstr_9A8507BA4040188D08");
}

endhostagegame(var_0) {
  level.extratime = undefined;
  level notify("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  foreach(var_2 in level.hostages) {
    var_2 scripts\mp\tac_ops\hostage_utility::removeminimapicons();

    if(isDefined(var_2.useobj))
      var_2.useobj delete();

    var_2.body delete();
    var_2.head delete();
    var_2 delete();
  }

  level.hostages = [];

  foreach(var_5 in level.activeextractions) {
    var_5 cleanuplz(0);
    var_5 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::deactivatezone();
  }

  if(isDefined(level.onphaseend))
    [[level.onphaseend]](var_0);

  scripts\mp\gamescore::_setteamscore(var_0, 1, 0);
  thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
}

onsuicidedeath(var_0) {
  if(isDefined(var_0.hostagecarried))
    scripts\mp\tac_ops\hostage_utility::drophostage(var_0, var_0.hostagecarried, var_0.origin);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_0.hostagecarried))
    scripts\mp\tac_ops\hostage_utility::drophostage(var_0, var_0.hostagecarried, var_0.origin);

  if(!isDefined(var_0.switching_teams))
    var_0 scripts\mp\playerlogic::decrementalivecount(var_0.team);
}

delayedhostagespawn(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A7D21434ED37A358CE59BEB91CB0DDB9FACA58E4632F");
  wait(var_0);
  scripts\mp\tac_ops\hostage_utility::spawnrandomhostages(var_1, var_2);
}

hostagecheckscoring() {
  for(var_0 = 0; var_0 < level.activeextractions.size; var_0++) {
    var_1 = level.activeextractions[var_0];

    if(distancesquared(self.origin, var_1.origin) < 14400) {
      iprintlnbold("_encstr_91DC1AE941323D2908A80BA292280DA82A11805004243D3551143A8A");
      scripts\mp\tac_ops\hostage_utility::scorehostage(var_1.team, 3);
      return 1;
    }
  }

  return 0;
}

initializefixedlzs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  level.extractionteam = "_encstr_9A8507BA4040188D08";

  for(var_0 = 0; var_0 < level.fixedlzs.size; var_0++)
    level.inactiveextractions[var_0] = level.fixedlzs[var_0];

  thread waitprematchdone();
}

initializedynamiclzs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  level.extractionteam = "_encstr_8E8405EA382B2A";

  for(var_0 = 0; var_0 < 2; var_0++) {
    level.inactiveextractions[var_0] = level.objective[var_0];
    level.inactiveextractions[var_0] updateextracticons();
    level.inactiveextractions[var_0] scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  }

  thread waitprematchdone();
}

waitprematchdone() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

createhostagelz(var_0, var_1) {
  var_2 = level.inactiveextractions.size;
  var_3 = level.inactiveextractions[var_2 - 1];
  var_3.marker = var_0;
  level.inactiveextractions[var_2 - 1] = undefined;
  var_4 = level.activeextractions.size;
  level.activeextractions[var_4] = var_3;
  level.activeextractors[var_4] = self;
  var_5 = int(gettime() + 119000);

  if(istrue(var_1))
    makelzextractionvisuals(var_3);
}

makelzextractionvisuals(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level.extractionpos;

  var_0.origin = var_1;

  if(isDefined(var_0.trigger))
    var_0.trigger.origin = var_1;

  var_0.curorigin = var_1;
  var_0 scripts\mp\gameobjects::requestid(1, 1);
  var_0 updateextracticons();
  var_0 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::activatezone();
  var_0.active = 1;
  var_0 scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
  var_0.scriptable = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setupscriptablevisuals(var_1, var_0);
  var_0 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::updateflagstate(var_0.team, 0);

  if(isDefined(var_0.team))
    updateservericons(var_0.team, 0);

  level notify("_encstr_87BD0BFA5FF0DFF73978FBF221");
  scripts\mp\utility\sound::playsoundonplayers("_encstr_B67514E1282730B37DAAE8D8A3D75BC8CFB27FED91CB");
  var_2 = spawnfx(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], var_1);

  if(isDefined(var_2))
    triggerfx(var_2);

  var_0.fxtoplay = var_2;
}

spawnextractchopper(var_0, var_1) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  wait(var_1);
  var_2 = level.extractionpos;
  var_3 = (0, 0, 0);
  var_4 = 24000;
  var_5 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_6 = var_5.origin[2];
  var_7 = getexplodedistance(var_6);
  var_8 = 4000;
  var_9 = "_encstr_B88607820996877650";
  var_10 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_2, var_3, var_4, var_5, var_6, var_8, var_7, var_9);
  var_11 = fakestreakinfo();
  var_12 = scripts\mp\killstreaks\jackal::beginjackal(0, var_10["_encstr_B18C0B5E9C6FA319E20A487853"], var_2, var_11, var_0);
  return var_12;
}

fakestreakinfo() {
  var_0 = spawnStruct();
  var_0.available = 1;
  var_0.firednotify = "_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0";
  var_0.isgimme = 1;
  var_0.kid = 5;
  var_0.lifeid = 0;
  var_0.madeavailabletime = gettime();
  var_0.scriptuseagetype = "_encstr_AD56169FC186E14B0B222E10A9B28BA3D38FD76FE2A17735";
  var_0.streakname = "_encstr_B88607820996877650";
  var_0.streaksetupinfo = undefined;
  var_0.variantid = -1;
  var_0.weaponname = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";
  var_0.objweapon = getcompleteweaponname(var_0.weaponname);
  return var_0;
}

getexplodedistance(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

waitlzextractarrival(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self endon("_encstr_963715B53B8DFAA769EBAB5ADEDFB1BD8B535BF0DABFA8");
  thread extractvehicledeathwatcher();
  wait 119;

  foreach(var_2 in level.jackals) {
    if(!isDefined(var_2.lz) || !isDefined(var_2.lz.marker)) {
      continue;
    }
    if(self.marker == var_2.lz.marker)
      var_2 notify("_encstr_A6201117400BFA9A57AD49BC185F83B131C037");
  }

  if(level.objectives[0].ownerteam == "_encstr_9A8507BA4040188D08") {
    scripts\mp\gamescore::_setteamscore("_encstr_9A8507BA4040188D08", 1, 0);
    thread scripts\mp\gamelogic::endgame("_encstr_9A8507BA4040188D08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
  } else {
    scripts\mp\gamescore::_setteamscore("_encstr_8E8405EA382B2A", 1, 0);
    thread scripts\mp\gamelogic::endgame("_encstr_8E8405EA382B2A", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
  }
}

extractvehicledeathwatcher() {
  level endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A6201117400BFA9A57AD49BC185F83B131C037");
  self waittill("_encstr_963715B53B8DFAA769EBAB5ADEDFB1BD8B535BF0DABFA8");
  cleanuplz(0);
}

cleanuplz(var_0) {
  if(var_0)
    checkhostagescoring();

  cleanuplzvisuals();
  level.inactiveextractions[level.inactiveextractions.size] = self;
  level.activeextractors = scripts\engine\utility::array_remove_index(level.activeextractors, 0);
  level.activeextractions = scripts\engine\utility::array_remove_index(level.activeextractions, 0);
}

cleanuplzvisuals() {
  if(isDefined(self.scriptable)) {
    _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::updateflagstate("_encstr_BA19049F4B2D", 0);
    self.scriptable delete();
  }

  if(isDefined(self.fxtoplay))
    self.fxtoplay delete();

  if(isDefined(self.marker) && isDefined(self.marker.visual)) {
    self.marker.visual delete();
    scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    scripts\mp\gameobjects::releaseid();
  }

  self.active = 0;
  updateservericons("_encstr_83270B204F9E4157D3C463FCDB", 0);
  _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::deactivatezone();
  self.active = 1;
  self.lastactivatetime = gettime();
}

checkhostagescoring() {
  var_0 = [];
  var_1 = "_encstr_8BBA05185F8B99";

  foreach(var_3 in level.hostages) {
    if(var_3 hostagecheckscoring())
      var_0[var_0.size] = var_3;

    var_1 = var_3.team;
  }

  level.hostages = scripts\engine\utility::array_remove_array(level.hostages, var_0);
  tryhostagerespawn(var_1);
}

tryhostagerespawn(var_0) {
  if(level.hostages.size == 0) {
    level notify("_encstr_A7D21434ED37A358CE59BEB91CB0DDB9FACA58E4632F");
    scripts\mp\tac_ops\hostage_utility::spawnrandomhostages(2, var_0);
    waitframe();
    var_1 = _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::gettacopstimelimitms() / 1000;
    thread delayedhostagespawn(var_1 * 0.2, 2);
    thread delayedhostagespawn(var_1 * 0.4, 2);
    thread delayedhostagespawn(var_1 * 0.6, 2);
  }
}

handlehostmigration(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 > 0) {
    return;
  }
  return;
}

updateservericons(var_0, var_1) {
  var_2 = -1;

  if(var_1)
    var_2 = -2;
  else {
    switch (var_0) {
      case "_encstr_8E8405EA382B2A":
      case "_encstr_9A8507BA4040188D08":
        var_3 = thread getownerteamplayer(var_0);

        if(isDefined(var_3))
          var_2 = var_3 getentitynumber();

        break;
      case "_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E":
        var_2 = -3;
        break;
      case "_encstr_83270B204F9E4157D3C463FCDB":
      default:
        break;
    }
  }
}

getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

setupextractioncallouts(var_0) {
  var_1 = 1;
  level.extractionteam = var_0;

  if(!isDefined(level.extractionteam))
    var_1 = 2;
  else if(level.extractionteam == "_encstr_9A8507BA4040188D08")
    var_1 = 0;

  foreach(var_3 in level.players) {
    if(isDefined(var_1))
      var_3 setclientomnvar("_encstr_997811BA96FAA11C7D1B2C36C6DEAEE87DB491", var_1);
  }
}

trycreateextractpoint(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(level.activeextractions.size < 2) {
    level.extractionpos = var_0;
    createhostagelz(var_1, var_2);
    self iprintlnbold("_encstr_816626456B3BDEE806AC0317AEBEB02853C3D92B56D39D981D9F2B0BCC85726387DA71D94A4F4D5A");
    return 1;
  } else {
    self iprintlnbold("_encstr_B2242F0A93D003F7DEE3763829B83FFF9081FDC073600DAA8EB86BC3318E1FE60BF13A0D4B889072A5F066AB5865DB6F6A");
    return 0;
  }
}

getextractiontimeconst() {
  return 120;
}

createhvt() {
  var_0 = getEnt("_encstr_B8370CA3B08B5B0BD3AC853598FF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.hvtlocent = var_0;
}

createhvtextractionsite() {
  var_0 = getEnt("_encstr_8DB011863B47A80FD14E2CB1A3B4DB9B89DE8D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.objectives = [];
  level.objectives[0] = var_0;
  var_1 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(level.objectives[0]);
  scripts\engine\utility::delaythread(3.0, ::delayset);
  var_1.onuse = ::hostagedompoint_onuse;
  level.objectives[0] = var_1;
  level.flagcapturetime = 0.1;
  level.flagneutralization = 0;
  waitframe();
  var_1 scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  var_1 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_1 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_1 scripts\mp\gameobjects::cancontestclaim(1);
  var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

delayset() {
  level.objectives[0] scripts\mp\gameobjects::setownerteam("_encstr_8E8405EA382B2A");
  level.objectives[0] scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  level.objectives[0] _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_8E8405EA382B2A", 0);
  level.objectives[0] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

watchpushtriggers() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  var_0 = getEntArray("_encstr_950315E8DEF5D09B8E3BAFC1ABE634BEE84E2D3BD9AC27", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0) || var_0.size <= 0) {
    return;
  }
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = int(var_3.script_noteworthy);
    var_1[var_4] = var_3;
  }

  var_6 = 0;

  for(;;) {
    wait 1.0;
    var_7 = var_1[var_6 + 1];

    if(isDefined(var_7)) {
      foreach(var_9 in level.hostages) {
        if(var_9 istouching(var_7)) {
          var_6++;
          var_10 = "_encstr_A7C40951B8A8705FA1CAF1" + var_6;
          scripts\mp\tac_ops_map::setactivemapconfig(var_10, "_encstr_9A8507BA4040188D08");
          scripts\mp\tac_ops_map::setactivemapconfig(var_10, "_encstr_8E8405EA382B2A");
          level notify("_encstr_8F5816B9E8337B7131B74927432927951247D9AB5B2B6FBF");
        }
      }
    }
  }
}

hostagedompoint_onuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse(var_0);

  if(var_0.team == "_encstr_9A8507BA4040188D08") {
    if(isDefined(var_0.hostagecarried)) {
      var_1 = scripts\mp\tac_ops\hostage_utility::drophostage(var_0, var_0.hostagecarried, var_0.origin);
      var_1.trackedobject scripts\mp\gameobjects::deletetrackedobject();
      var_1 makeunusable();
      var_1.useobj unlink();
      var_1.useobj makeunusable();
    }

    var_0 thread trycreateextractpoint(var_0.origin, undefined, 0);
    var_2 = _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::gettacopstimeremainingms();

    if(var_2 < getextractiontimeconst() * 1000)
      _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::extendtacopstimelimitms(getextractiontimeconst() * 1000 - var_2);
    else
      _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::reducetacopstimelimitms(var_2 - getextractiontimeconst() * 1000);

    level.objectives[0].onuse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse;
    level.objectives[0] scripts\mp\gameobjects::setkeyobject(undefined);
    level.objectives[0] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    level.objectives[0] scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");

    if(scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_AB580A05672AE35D5FFF50B8")) {
      level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B"), ::compare_player_score);
      var_3 = level.topplayers[0] spawnextractchopper(self, 0);
      var_4 = scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B");
      var_5 = var_4.size;
      var_5 = max(var_5, 1);
      var_6 = 1666.67;
      var_3.health = int(var_5 * var_6);
      var_3.maxhealth = var_3.health;
      level.objectives[0] thread copterdeathwatcher();
      var_3 thread copterhealthwatcher();
      setomnvar("_encstr_BEF81E4B07519DA0D36DB3AB19B0C8D90A77C9E3BF8A6530D78219833E65680D", 1.0);
      thread holdoutphase();
    }
  }
}

holdouttext() {
  wait 7;
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::teamprint(&"_encstr_82B0279D434906A7794DD9C1D5A407CAD1A31877C10159A7914471091C861BB7792985A68B51571717", &"_encstr_9AA627D425D468F5A9159A4D28748AD47DD4A0BCA8A7FA140B29A9D742A6A88EAF228AC8512711AF89");
}

copterhealthwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0);
    setomnvar("_encstr_BEF81E4B07519DA0D36DB3AB19B0C8D90A77C9E3BF8A6530D78219833E65680D", self.health / self.maxhealth);
  }
}

copterdeathwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_963715B53B8DFAA769EBAB5ADEDFB1BD8B535BF0DABFA8");
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::pausetacopstimer();
  wait 5;
  endhostagegame("_encstr_8E8405EA382B2A");
}

holdoutphase() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_963715B53B8DFAA769EBAB5ADEDFB1BD8B535BF0DABFA8");
  level notify("_encstr_8EFA1CD2B8EE8B0658A32F105FE88F1F153339DBE04FDF7FC1950DE773C0");
  thread holdouttext();
  startcopteroutofbounds();
  wait(getextractiontimeconst() - 110.0);
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_9A431723A3F1F323BB6785FE61276BA126BBB022491333388F", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_A6F717E2F05F421B79B1719FB9F0D8B23AF1864FE39385931A", "_encstr_8E8405EA382B2A");
  wait 10.0;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_95791324F3C7E51B2891DFDBB3A158288190827830", "_encstr_9A8507BA4040188D08");
  wait 20.0;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_97D51AFBF2B1F9B8D6296B8005194ADC814F1BA20FD8D89B534F0753", "_encstr_9A8507BA4040188D08");
  wait 55.0;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_84B51AC8C3BEDA3889D7D5E664AF0E43B0CD9513BEB4B9332DB1581B", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_8B071D8CE1EBDA834C7D0B8B36D6FA833416CD9589EBB1ACCDCD8E2DB5ACC4", "_encstr_8E8405EA382B2A");
}

startcopteroutofbounds() {
  var_0 = getEntArray("_encstr_8CD9140B7791E2CF301B595DD3D0073A7E9FE79BD946", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1) {
    foreach(var_5 in var_0)
    var_3 startphaseoob(var_5, "_encstr_85E00E36B70E8E2B9C12BDD891D357A3");
  }
}

startphaseoob(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
}

compare_player_score(var_0, var_1) {
  return var_0.score >= var_1.score;
}
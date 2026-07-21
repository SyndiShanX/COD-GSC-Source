/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\mtmc.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = "_encstr_93A2056DBB5853";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.disablebuddyspawn = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onobjectivecomplete = ::onflagcapture;
  level.ondeadevent = ::ondeadevent;
  level.lastcaptime = gettime();
  level.gamemodegesturecalloutassign = ::assigngamemodecallout;
  level.gamemodegesturecalloutverify = ::verifygamemodecallout;
  level.alliescapturing = [];
  level.axiscapturing = [];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_83CC14D916B69547BCC1567D19EDADB4371647D27BCD";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A3210DEE4972B3383AE9B75F0A4D13";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A3210DEE4972B3383AE9B75F0A4D13";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7270B37CAC6BA4E96CD76BE2C"] = "_encstr_A7270B37CAC6BA4E96CD76BE2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB270BF3CD11AFEAA31812A940"] = "_encstr_AB270BF3CD11AFEAA31812A940";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99270B0B3F0BC056E2C34F371F"] = "_encstr_99270B0B3F0BC056E2C34F371F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7010A03FD5FFFE3521A09C8"] = "_encstr_BD3009CD56B1AB9356BE85";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B010A0FFD30CD6AE50956EB"] = "_encstr_BE3009909F6BABE5AA21DE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99010A734743881E7AA38787"] = "_encstr_9230098783F6133210DEF6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BDC098D7BCD96DC76FA2C"] = "_encstr_9BDC098D7BCD96DC76FA2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83DC0901B70A98F85731F1"] = "_encstr_83DC0901B70A98F85731F1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BDC0955A0D021A28C87BF"] = "_encstr_8BDC0955A0D021A28C87BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD68071BF6B9A3BE0B"] = "_encstr_AD68071BF6B9A3BE0B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_976807690FAFEBD7F6"] = "_encstr_976807690FAFEBD7F6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA68071BD0C3C4417F"] = "_encstr_AA68071BD0C3C4417F";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_A5F7196E1B9CFAADE8ADC6EBCC1B2C9D1A0B83E8ABE4CAA2D25B95", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA"));
  setdynamicdvar("_encstr_8D9A1CA686034123A47DF107ED6C28CACD39355312CE608B1567EDA850B3", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60"));
  setdynamicdvar("_encstr_88BF13EBD93B079968C070B99FD14B9B77DA09A78A", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_86FA0ABD89A6D41B85630BC9"));
  setdynamicdvar("_encstr_8E4D1626C36B4E73B362A039CB4A2B857F783F9051F3D397", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_82730D3B68514312E927CD4410D90B"));
  setdynamicdvar("_encstr_A30815C74FF0485D888AAEF87B7A2F037BDBC70DDBBFE9", getmatchrulesdata("_encstr_8C2E0C7708EF6DE58B29E13B7557", "_encstr_A5B60CF9DFD99DEB337D3193BF2F"));
  setdynamicdvar("_encstr_B21E16B91BC9BEB61DAD36BEB158E047AB4E9588958D16CB", getmatchrulesdata("_encstr_8C2E0C7708EF6DE58B29E13B7557", "_encstr_87940DB10BE0D1D5E42B88ACC616E5"));
  setdynamicdvar("_encstr_ADC21213A7F0B1DF55D84A7180271337181BB58D", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_93A2056DBB5853", 0);
}

seticonnames() {
  level.iconneutral = "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1";
  level.iconcapture = "_encstr_859A1183D94B3B2548D56447E7202A93F5133A";
  level.icondefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.iconcontested = "_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509";
  level.icontaking = "_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012";
  level.iconlosing = "_encstr_8202100F51F881C7C0F2255890A5865376FF";
  level.icontarget = "_encstr_A2BC15B4C6B737EBDD585E0EB796B98EAF1D2C3976ACA3";
}

onstartgametype() {
  seticonnames();

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_964615086EAD9DA5BF6883B71B556D601C7F9141DFB9ED");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_B404149E2125A8685125958A6A5E11D335F509299C2A");
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(!isDefined(game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"]))
    game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"] = level.teamnamelist;

  initspawns();
  thread setupflags();
  thread startgame();
}

startgame() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 15.0;

  foreach(var_1 in level.objectives) {
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    var_1 scripts\mp\gameobjects::enableobject();
    var_1 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_1 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  }
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA", 30, 0, 30);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("_encstr_82730D3B68514312E927CD4410D90B", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("_encstr_87940DB10BE0D1D5E42B88ACC616E5", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("_encstr_A5B60CF9DFD99DEB337D3193BF2F", 1, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86FA0ABD89A6D41B85630BC9", 4, 1, 10);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_93A20565BF5973", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8DFB14C290AF55DBA84EA783DFF10F5D0730DB9AE881");

  foreach(var_2 in game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"])
  scripts\mp\spawnlogic::registerspawnpoints(var_2, var_0);

  level.startlocations = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5.target) || var_5.target == "_encstr_B40101") {
      continue;
    }
    if(!isDefined(var_5.script_noteworthy) || var_5.script_noteworthy == "_encstr_B40101") {}

    if(int(var_5.script_noteworthy) != game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"].size) {
      continue;
    }
    var_6 = level.startlocations[var_5.target];

    if(isDefined(var_6)) {
      var_6.spawnpoints[var_6.spawnpoints.size] = var_5;
      continue;
    }

    var_7 = scripts\engine\utility::getStruct(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_8 = spawnStruct();
    var_8.origin = var_7.origin;
    var_8.angles = var_7.angles;
    var_8.spawnpoints = [];
    var_8.spawnpoints[0] = var_5;
    var_8.inuse = 0;
    level.startlocations[var_5.target] = var_8;
  }

  foreach(var_11, var_6 in level.startlocations) {
    scripts\mp\spawnlogic::registerspawnset(var_11, var_6.spawnpoints);
    scripts\mp\spawnlogic::activatespawnset(var_11);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  scripts\mp\spawnlogic::deactivateallspawnsets();

  if(!isDefined(level.teamspawnlocations))
    level.teamspawnlocations = [];

  var_0 = level.teamspawnlocations[self.team];

  if(isDefined(var_0)) {
    scripts\mp\spawnlogic::activatespawnset(var_0);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "_encstr_8F1904CA1729");
    return var_1;
  }

  foreach(var_0, var_3 in level.startlocations) {
    if(var_3.inuse) {
      continue;
    }
    scripts\mp\spawnlogic::activatespawnset(var_0);
  }

  var_1 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, undefined, undefined, "_encstr_8F1904CA1729");
  level.startlocations[var_1.target].inuse = 1;
  level.teamspawnlocations[self.team] = var_1.target;
  return var_1;
}

setupflags() {
  var_0 = getEntArray("_encstr_877409B5E8DA6CEBC87BB5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!var_0.size) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy) || var_2.script_noteworthy == "_encstr_B40101") {}

    if(int(var_2.script_noteworthy) != game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"].size) {
      continue;
    }
    var_3 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_2, 1);
    var_3 scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    var_3 scripts\mp\gameobjects::disableobject();
    var_3 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_3 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    level.objectives[var_3.objectivekey] = var_3;
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

onspawnplayer() {}

onplayerconnect(var_0) {
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;
  var_0 thread onplayerspawned();
}

onplayerspawned(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_BA350853C128FB939DB9");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["_encstr_81CF0936850ED1D54EACCD"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_81CF0936850ED1D54EACCD"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["_encstr_B1F7085B03F492AE98DB"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_B1F7085B03F492AE98DB"]);
  }
}

onflagcapture(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\utility\dialog::statusdialog("_encstr_AAE70838F27E43E327DC" + self.objectivekey, var_3, 1);
  var_6 = scripts\mp\utility\game::getotherteam(var_3);

  foreach(var_8 in var_6)
  scripts\mp\utility\dialog::statusdialog("_encstr_97B70613D8CBDC59" + self.objectivekey, var_8, 1);

  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  if(isDefined(self.flagmodel))
    self.flagmodel hide();

  if(!isDefined(level.remainingflags))
    level.remainingflags = level.objectives.size;

  level.remainingflags--;

  if(level.remainingflags == 0)
    setremainingteams();
}

assigngamemodecallout() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = cos(10);
  var_4 = 250000;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  foreach(var_11 in level.objectives) {
    var_12 = vectorNormalize(var_11.trigger.origin - var_0);
    var_13 = vectordot(var_2, var_12);
    var_14 = distancesquared(var_11.trigger.origin, var_0);

    if(!isDefined(var_5) || var_5 < var_13) {
      var_5 = var_13;
      var_7 = var_14;
      var_6 = var_11;
    }

    if(!isDefined(var_8) || var_8 > var_14) {
      var_8 = var_14;
      var_9 = var_11;
    }
  }

  var_11 = undefined;
  var_16 = undefined;
  var_17 = undefined;

  if(isDefined(var_5) && var_5 > var_3) {
    var_11 = var_6;
    var_18 = getsubstr(var_11.objectivekey, 1, 2);

    if(var_11.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
      var_16 = self.name + "_encstr_B1F30B9ACA0B69A17B6B169516" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_95EB0866891B23FB85B3";
    } else if(var_11.ownerteam == self.team) {
      var_16 = self.name + "_encstr_BE270B92E989F72B057082CED1" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_A20C07ABF304625E08";
    } else {
      var_16 = self.name + "_encstr_AF760B5217DD0F9BA70B03E508" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_AB3508737F830710ACDB";
    }
  } else if(isDefined(var_8) && var_8 < var_4) {
    var_11 = var_9;
    var_18 = getsubstr(var_11.objectivekey, 1, 2);

    if(var_11.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
      var_16 = self.name + "_encstr_B1F30B9ACA0B69A17B6B169516" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_95EB0866891B23FB85B3";
    } else if(var_11.ownerteam == self.team) {
      var_16 = self.name + "_encstr_BE270B92E989F72B057082CED1" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_A20C07ABF304625E08";
    } else {
      var_16 = self.name + "_encstr_AF760B5217DD0F9BA70B03E508" + var_18 + "_encstr_AD4C0212";
      var_17 = "_encstr_AB3508737F830710ACDB";
    }
  }

  if(isDefined(var_11))
    thread scripts\cp_mp\gestures::applygamemodecallout(var_11, var_16, var_17);

  return isDefined(var_11);
}

verifygamemodecallout(var_0, var_1) {
  var_2 = 0;

  switch (var_0) {
    case "_encstr_95EB0866891B23FB85B3":
      if(var_1.team == self.team)
        var_2 = 1;

      break;
    case "_encstr_A20C07ABF304625E08":
      if(var_1.team == self.team)
        var_2 = 1;

      break;
    case "_encstr_AB3508737F830710ACDB":
      if(var_1.team == self.team)
        var_2 = 1;

      break;
  }

  return var_2;
}

ondeadevent(var_0) {
  if(var_0 == "_encstr_AF1904A7F929")
    setremainingteams();
  else {
    var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
    var_2 = [];

    foreach(var_4 in var_1)
    var_2[var_4] = 0;

    if(!istrue(level.disablespawning)) {
      foreach(var_4 in var_1) {
        foreach(var_8 in scripts\mp\utility\teams::getteamdata(var_4, "_encstr_9775086022BE1B413B8B")) {
          if(!istrue(var_8.hasspawned)) {
            continue;
          }
          var_2[var_4] = var_2[var_4] + var_8.pers["_encstr_8CAA06DB20A31543"];
        }
      }
    }

    var_11 = [];

    foreach(var_4 in var_1) {
      if(scripts\mp\utility\teams::getteamdata(var_4, "_encstr_8A2A0B936CCCC3078547970A8B") || var_2[var_4])
        var_11[var_11.size] = var_4;
    }

    if(var_11.size == 1)
      setremainingteams(var_11[0]);
  }
}

setremainingteams(var_0) {
  if(istrue(level.remainingteamsset)) {
    return;
  }
  level.remainingteamsset = 1;
  game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"] = [];

  foreach(var_2 in level.objectives) {
    if(var_2.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
      continue;
    }
    if(!scripts\engine\utility::array_contains(game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"], var_2.ownerteam))
      game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"][game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"].size] = var_2.ownerteam;
  }

  if(isDefined(var_0) && !scripts\engine\utility::array_contains(game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"], var_0) && game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"].size < level.objectives.size)
    game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"][game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"].size] = var_0;

  foreach(var_5 in level.players) {
    if(scripts\engine\utility::array_contains(level.teamnamelist, var_5.team)) {
      if(!scripts\engine\utility::array_contains(game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"], var_5.team))
        var_5 scripts\mp\menus::addtoteam("_encstr_AF8C0A1B6A1D6045925B4F7D");
    }
  }

  if(game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"].size == 1) {
    scripts\mp\gamescore::giveteamscoreforobjective(game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"][0], 1, 0);
    thread scripts\mp\gamelogic::endgame(game["_encstr_86720FAA13B08647D0C0128A8FBD9F7DA8"][0], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"]);
  } else
    thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
}
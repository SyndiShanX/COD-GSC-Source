/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\vip.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_B807035284";
  var_0[2] = "_encstr_979A09DA67D0262B70CD82";
  var_0[3] = "_encstr_8218041DF5FA";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 3);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  level.teambased = 1;
  level.objectivebased = 1;
  updategametypedvars();
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_91A0129D2CAD95D1F2C156BE915699ACCD9156C9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_AF980D1B11DA0C576B5A50400312B8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_AF980D1B11DA0C576B5A50400312B8";
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_8AED11371BE4F5D94B38BE342C1B33E8B4B556", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("_encstr_A5D81037D89CF59D4B387D83C9DBADED322B", 0);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
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

  scripts\mp\utility\game::setobjectivetext("_encstr_9A8507BA4040188D08", &"_encstr_84660F8D8D8CD5D64D337493198ABEEFDA");
  scripts\mp\utility\game::setobjectivetext("_encstr_8E8405EA382B2A", &"_encstr_84660F8D8D8CD5D64D337493198ABEEFDA");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_84660F8D8D8CD5D64D337493198ABEEFDA");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_84660F8D8D8CD5D64D337493198ABEEFDA");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_A6DE15F49094A20D45A46515A65ECA2514D74D0DF4A451");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_A6DE15F49094A20D45A46515A65ECA2514D74D0DF4A451");
  }

  scripts\mp\utility\game::setobjectivehinttext("_encstr_9A8507BA4040188D08", &"_encstr_8D7D14E99BDA250FC12C5CCDB2AEFD6C68575941C3BC");
  scripts\mp\utility\game::setobjectivehinttext("_encstr_8E8405EA382B2A", &"_encstr_8D7D14E99BDA250FC12C5CCDB2AEFD6C68575941C3BC");
  initspawns();
  level.hostagestates = [];
  level.hostagecarrystates = [];
  seticonnames();
  thread waittoprocess();
  level thread votimeendingsoon();
}

waittoprocess() {
  level endon("_encstr_842909CE58B659AF2B3791");
  level endon("_encstr_BE7F0C5780A0E4A14F2BBAB20509");
  level thread extractionzone();
  level thread spawnvip();
  level thread createthreatbiasgroups();
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  scripts\mp\flags::gameflagwait("_encstr_A75411B7E0D72245126A426A8019D7B7FA7EEA");
  self notify("_encstr_A5F60EEC93581BAC86EDDA0E8D598E95");
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = "_encstr_AC9A15250B91A8BDA6E3404BD38E405F4178BFF233D550";

  if(self.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_0 = "_encstr_8C0515DA83BEB991BEB9C1B0BBDCFA581D8EC2B1ADCA39";

  var_1 = scripts\mp\spawnlogic::getspawnpointarray(var_0);
  var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  return var_2;
}

seticonnames() {
  level.iconrecover = "_encstr_9AB415BB16F2C1BDD2738EBE935936DED9B293BE3B4B83";
  level.iconescort = "_encstr_AAA1149451D73BE764A2E8A90ABAB79043EC088CA11B";
  level.iconextract = "_encstr_93D215F853DF1B784868838695DAC573A0CB43A1530373";
  level.icontakingextract = "_encstr_93D218F853DF1B784868838684F94A1FD8CFEF706B397BEF885B";
  level.iconlosingextract = "_encstr_918718BB2CBC38B7D2B9E8AFB1EDE6A5379DAFCAC31D93B08DD1";
  level.iconcontestingextract = "_encstr_8A651C77B0970EB7B473477DD8F6E61D599BA3969BEC7DAC3CA3392C3647";
  level.icondefendextract = "_encstr_920118B7DFCB671801F5FB969FF5A81552536F2B13432E20234B";
  level.iconcaptureextract = "_encstr_8F78194CAE6311ED815B782947A1BB41CB12CDC007CBD16B717740";
  level.iconstoppingextract = "_encstr_95FB1ADD2CBC83DB969BA3AF6E3ADB070EA53776AF2B871D9C0BD81D";
}

onspawnplayer() {
  self.isvip = 0;
  self.usingobj = undefined;
  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", -1);
  self setthreatbiasgroup(self.team);
  thread updatematchstatushintonspawn();

  if(isDefined(level.vip))
    level.vip.trigger enableplayeruse(self);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\rank::getscoreinfovalue("_encstr_ABD70578F3D02C");
  var_7 = var_0.team;

  if(isDefined(var_0.isvip) && var_0.isvip) {
    level thread vip_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_838F1211A2413B24E197D1E18FD4DDE1A9DB9B07");
    var_1.finalkill = 1;
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread checkallowspectating();
}

ontimelimit() {
  if(game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08")
    var_0 = "_encstr_91AB08AC45BB5539F95B";
  else if(game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_9A8507BA4040188D08"] == game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_8E8405EA382B2A"])
    var_0 = "_encstr_8B6D0940CC35339149DA08";
  else if(game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_8E8405EA382B2A"] > game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_9A8507BA4040188D08"])
    var_0 = "_encstr_8E8405EA382B2A";
  else
    var_0 = "_encstr_9A8507BA4040188D08";

  thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[game["_encstr_991C0AB9ED5B57161FE89B83"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0)
    scripts\mp\spectating::updatespectatesettings();
}

ondeadevent(var_0) {
  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    level thread vip_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  else if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level thread vip_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
}

vip_endgame(var_0, var_1) {
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

extractionzone() {
  var_0 = getEntArray("_encstr_979A09DA67D0262B70CD82", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = _encstr_8E601C3798D3B367DBE3C668A37F02A393ED8CEBA218B780ABDB35AC073A::removebombzonec(var_0);
  level.objectives = [];
  var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];

  foreach(var_3 in var_0) {
    var_4[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
    var_4[0].angles = (0, 270, 0);
    var_4[0].team = var_1;
    var_4[0].visibleteam = "_encstr_9A19040BCDBC";
    var_4[0].ownerteam = var_1;
    var_4[0].type = "_encstr_B40101";
    var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.origin, 0, 120, 80);
    var_5.team = var_1;
    var_6 = var_5.origin;
    var_7 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
    var_8 = [];
    var_9 = scripts\engine\trace::ray_trace(var_4[0].origin + (0, 0, 20), var_4[0].origin - (0, 0, 4000), var_8, var_7, 0);

    if(isPlayer(var_9["_encstr_850E077B0BF30318B9"]))
      var_9["_encstr_850E077B0BF30318B9"] = undefined;

    if(isDefined(var_9)) {
      var_10 = randomfloat(360);
      var_11 = var_9["_encstr_BD260953AA97E3F014279D"];

      if(isDefined(self.visualgroundoffset))
        var_11 = var_11 + self.visualgroundoffset;

      var_12 = (cos(var_10), sin(var_10), 0);
      var_12 = vectorNormalize(var_12 - var_9["_encstr_820E07FAE8780B3A4C"] * vectordot(var_12, var_9["_encstr_820E07FAE8780B3A4C"]));
      var_13 = vectortoangles(var_12);
      var_4[0].origin = var_11;
      var_4[0] setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
      var_4[0] setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_8419044EB232");
      var_4[0] playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
    }

    level.flagcapturetime = 0.05;

    if(isDefined(var_5.objectivekey))
      var_14 = var_5.objectivekey;
    else
      var_14 = var_5.script_label;

    if(isDefined(var_5.iconname))
      var_15 = var_5.iconname;
    else
      var_15 = var_5.script_label;

    var_5 = scripts\mp\gameobjects::createuseobject(var_1, var_5, var_4, (0, 0, 100));
    var_5.team = var_1;
    var_5.ownerteam = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    var_5.ownerteamcaps = 1;
    var_5.origin = var_5.curorigin;
    var_5 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    var_5 scripts\mp\gameobjects::cancontestclaim(1);
    var_5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
    var_5.onuse = ::extractzone_onuse;
    var_5.onbeginuse = ::extractzone_onusebegin;
    var_5.onenduse = ::extractzone_onuseend;
    var_5.oncontested = ::extractzone_oncontested;
    var_5.onuncontested = ::extractzone_onuncontested;
    var_5 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_5.id = "_encstr_87D9083A6F628DDB5F1F";
    var_5.extractionactive = 0;
    var_5 scripts\mp\gameobjects::setcapturebehavior("_encstr_820E07FAE8780B3A4C");
    var_5.objectivekey = var_14;
    var_5.iconname = var_15;
    var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_5.stompprogressreward = ::extractzone_stompprogressreward;
    var_5.nousebar = 1;
    var_5.id = "_encstr_87D9083A6F628DDB5F1F";
    var_5.claimgracetime = level.flagcapturetime * 1000;
    var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
    waitframe();
  }

  var_17 = getEntArray();

  foreach(var_19 in var_17) {
    var_20 = var_19.script_gameobjectname;

    if(isDefined(var_20)) {
      if(var_20 == "_encstr_979A09DA67D0262B70CD82")
        var_19 delete();
    }
  }
}

extractzone_onusebegin(var_0) {
  var_0.iscapturing = 1;
  level.canprocessot = 0;
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.neutralizing = istrue(level.flagneutralization) && var_1 != "_encstr_A7A408B9CA5D1D4E2C63";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(var_0.team);

  self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagcapturestate(var_0.team);

  if(var_1 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconstoppingextract, level.iconlosingextract);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosingextract, level.icontakingextract);
}

extractzone_onuseend(var_0, var_1, var_2) {
  level.canprocessot = 1;

  if(var_2)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(var_1)) {
    var_1.iscapturing = 0;
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  if(!var_2) {
    self.neutralized = 0;
    var_3 = scripts\mp\gameobjects::getownerteam();

    if(var_3 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      if(self.extractionactive)
        scripts\mp\gameobjects::setobjectivestatusicons("_encstr_818C1BB48DEDB9F5EE589783B796DC8EBEB06C1D4BD92BBEB28733A5B1", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A");
      else
        scripts\mp\gameobjects::setobjectivestatusicons("_encstr_95A11CD7B7D88A37D8710852A8705E63B8E77F4F31F442D271D940DF2D70", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A");
    } else
      scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
  }
}

extractzone_onuse(var_0) {
  level.canprocessot = 1;
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  self.capturetime = gettime();
  self.neutralized = 0;
  extractzone_setcaptured(var_1, var_0);

  if(!self.neutralized) {
    if(isDefined(level.onobjectivecomplete))
      [[level.onobjectivecomplete]]("_encstr_ABED0902389B228718185C", self.objectivekey, var_0, var_1, var_2, self);
  }

  if(var_1 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    playFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], self.visuals[0], "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playannouncerbattlechatter(var_1, "_encstr_93B8247B53F38EB0A3DB2658849C50C95A93FBDDDBA9D620F9324B36AE4F187EF2177D095393", 20);
    var_0 vipextract(self);
  } else {
    stopFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], self.visuals[0], "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    self.extractionactive = 0;
  }
}

extractzone_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

extractzone_onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(self.ownerteam == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(self.extractionactive)
      scripts\mp\gameobjects::setobjectivestatusicons("_encstr_818C1BB48DEDB9F5EE589783B796DC8EBEB06C1D4BD92BBEB28733A5B1", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A");
    else
      scripts\mp\gameobjects::setobjectivestatusicons("_encstr_95A11CD7B7D88A37D8710852A8705E63B8E77F4F31F442D271D940DF2D70", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A");
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);
}

extractzone_setcaptured(var_0, var_1) {
  scripts\mp\gameobjects::setownerteam(var_0);

  if(self.ownerteam == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    scripts\mp\gameobjects::setusetime(5);
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_95A11CD7B7D88A37D8710852A8705E63B8E77F4F31F442D271D940DF2D70", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A");
  } else {
    scripts\mp\gameobjects::setusetime(0.05);
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefendextract, level.iconcaptureextract);

    foreach(var_3 in self.choppers) {
      var_3 notify("_encstr_BAFC0789BA3BD35DA3");
      var_3 notify("_encstr_A7401607773E79E4C8F36B75C948396305979FC31D53B3A5");
      var_3 scripts\engine\utility::array_remove(self.choppers, var_3);
      self.choppers = [];
      var_3 thread _encstr_B6D52CE3C835940B4B0697DD9F780FDEA3401BDBB8E3CABEA1EE9FCDB3FB9366E7A011F2E05F42FBB9D6E6C7CE21::littlebirdleave();
    }

    playannouncerbattlechatter(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_925F2662F0D9B2AF4925477CB37323FD13D82A8BB8376DF7610C49665C3E3F494DF0D2727029A57F", 10);
  }

  self notify("_encstr_95EB0866891B23FB85B3", var_1);
  self notify("_encstr_AB3508737F830710ACDB", var_1);
  self.neutralized = 0;

  if(self.touchlist[var_0].size == 0)
    self.touchlist = self.oldtouchlist;

  thread giveflagcapturexp(self.touchlist[var_0], var_1);
  scripts\mp\analyticslog::logevent_gameobject(self.analyticslogtype, self.analyticslogid, self.visuals[0].origin, -1, "_encstr_AD260A8AFAF7FBA3658762C6" + var_0);
}

extractzone_stompprogressreward(var_0) {
  var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
}

getcapturetype() {
  var_0 = "_encstr_820E07FAE8780B3A4C";

  if(level.capturetype == 2)
    var_0 = "_encstr_A10F0BD0F2FB41E337D40BFAB5";
  else if(level.capturetype == 3)
    var_0 = "_encstr_92FC0B5BB01A6B73D09459526B";

  return var_0;
}

giveflagcapturexp(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_1;

  if(isDefined(var_2.owner))
    var_2 = var_2.owner;

  level.lastcaptime = gettime();

  if(isPlayer(var_2)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B6C51896FF899237F3C017BF50E9E5BB6385DA0D5E2B4B49D838", var_2);
    var_2 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_2.origin);
  }

  var_3 = getarraykeys(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_0[var_3[var_4]].player;

    if(isDefined(var_5.owner))
      var_5 = var_5.owner;

    if(!isPlayer(var_5)) {
      continue;
    }
    var_5 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
    var_5 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_5.pers["_encstr_81CF0936850ED1D54EACCD"]);
    var_5 scripts\mp\utility\stats::setextrascore0(var_5.pers["_encstr_81CF0936850ED1D54EACCD"]);
    var_5 thread scripts\mp\awards::givemidmatchaward("_encstr_83A2106BF6C8B2EB237B6BD7CDCAB1ABE42B");
    wait 0.05;
  }
}

vipextract(var_0) {
  if(!isDefined(var_0.choppers))
    var_0.choppers = [];

  var_1 = anglesToForward(self getplayerangles(1));
  var_2 = getgroundposition(self getEye() + (0, 0, 60) + var_1 * 80, 60) + (0, 0, 8);
  var_3 = _encstr_B6D52CE3C835940B4B0697DD9F780FDEA3401BDBB8E3CABEA1EE9FCDB3FB9366E7A011F2E05F42FBB9D6E6C7CE21::spawnextractchopper(var_0, var_0.origin);
  var_0.choppers[var_0.choppers.size] = var_3;
  self iprintlnbold("_encstr_B8B61C2AF0E84E2CC6A35AB7DC806CDE073A594E02ACB90193DBEA47AC84");
  var_3.extractzone = var_0;
  var_3.extractteam = self.team;
  var_0.curorigin = var_0.origin;
  var_0.offset3d = (0, 0, 30);
  var_0 thread extracttriggerwatcher(var_3);
}

extracttriggerwatcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_BAFC0789BA3BD35DA3");
  var_0 waittill("_encstr_A7401607773E79E4C8F36B75C948396305979FC31D53B3A5");
  self.extractionactive = 1;
  playannouncerbattlechatter(var_0.extractteam, "_encstr_8E2D245AC8E19A8791CDAF846B5B1BA57BB002A350DF968BC8B69DBF77460BEA8B10FABAB84B", 10);

  if(self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontestingextract);
  else
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_818C1BB48DEDB9F5EE589783B796DC8EBEB06C1D4BD92BBEB28733A5B1", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!istrue(self.stalemate)) {
      if(istrue(var_1.isagentvip) && self.numtouching[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] == 0) {
        level thread vip_endgame(var_1.team, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
        break;
      } else if(var_1.team == self.team && isDefined(var_1.carryobject)) {
        level thread vip_endgame(var_1.team, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
        break;
      }
    }
  }
}

createthreatbiasgroups() {
  waitframe();
  createthreatbiasgroup("_encstr_951904D8F1E0");

  foreach(var_1 in level.teamnamelist) {
    createthreatbiasgroup(var_1);
    setignoremegroup(var_1, "_encstr_951904D8F1E0");
  }
}

spawnvip() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;
  var_0 = getEnt("_encstr_ABF214BF509E1A8A5BB6598A2B6F02B5C3213B3340F1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = undefined;
  var_2 = undefined;
  level.allowhvtspawn = 1;

  while(!isDefined(var_1)) {
    var_1 = scripts\mp\agents\agent_common::connectnewagent("_encstr_8BB007E03658CBCAE4", game["_encstr_991C0AB9ED5B57161FE89B83"]);

    if(isDefined(var_1)) {
      var_2 = var_0.origin;
      var_0 delete();
      var_1 thread[[var_1 scripts\mp\agents\agent_utility::agentfunc("_encstr_8E8A06F7D987435E")]](var_2, (0, 0, 0));
      var_3 = var_1 getnearestnode();
      var_1 setOrigin(var_3.origin);
      var_1.team = game["_encstr_991C0AB9ED5B57161FE89B83"];
      var_1 scripts\mp\bots\bots_util::bot_set_difficulty("_encstr_889F0893CA6CC9BA2D8E");
      var_1.outlineid = scripts\mp\utility\outline::outlineenableforteam(var_1, var_1.team, "_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40", "_encstr_A7440781BA73D7D8C1");
      var_1.nocorpse = 1;
      var_1.isdowned = 0;
      var_1.isagentvip = 1;
      var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + (0, 0, 30));
      var_4.team = game["_encstr_991C0AB9ED5B57161FE89B83"];
      var_4.destination = var_1.origin;
      var_4 linkTo(var_1);
      var_4 scripts\mp\utility\usability::maketeamusable(var_4.team);
      var_4 setHintString(&"_encstr_88D316A90597849E1388AF8AE9AF8AD40DD3922AFA2BA482");
      var_4 setusepriority(-3);
      var_1.trigger = var_4;
      var_1.ownerteam = var_4.team;
      var_1.interactteam = "_encstr_ACFC091AE8AB2FCBE15119";
      var_1.requireslos = 1;
      var_1.exclusiveuse = 0;
      var_1.curprogress = 0;
      var_1.usetime = 0;
      var_1.userate = 1;
      var_1.id = "_encstr_BAE50DE60E739BA638C72068AF47B9";
      var_1.skiptouching = 1;
      var_1.onuse = ::agent_onuse;
      var_1 thread scripts\mp\gameobjects::useobjectusethink();
      var_1.trackedobject = var_1 scripts\mp\gameobjects::createtrackedobject(var_1, (0, 0, 70));
      var_1.trackedobject.objidpingfriendly = 0;
      var_1.trackedobject.objidpingenemy = 0;
      var_1.trackedobject.objpingdelay = 0.05;
      var_1.trackedobject.visibleteam = "_encstr_ACFC091AE8AB2FCBE15119";
      var_1.invulnerable = 1;
      var_1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort);
      continue;
    }

    waitframe();
  }

  var_1 setthreatbiasgroup("_encstr_951904D8F1E0");
  var_1 thread hvtclearmove(var_2);
  var_1 thread hvtdeathwatcher();
  var_1 takeallweapons();
  waitframe();
  var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", undefined, undefined, 1);
  level.vip = var_1;
}

hvtclearmove(var_0) {
  self botsetscriptgoal(var_0, 20, "_encstr_99CC09DA9020C4ECD149AD");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

  while(!isDefined(self.tetherplayer)) {
    self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);
    wait 0.1;
  }
}

agent_onuse(var_0) {
  scripts\mp\utility\print::printboldonteam("_encstr_8F911212B2A210D2DC1033B78DB1BDEED29B7601" + var_0.name, var_0.team);
  self.following = 1;
  self.usetime = 1000;
  thread followplayer(var_0);
  var_0 thread watchownerdeath(self);
  self.trigger scripts\mp\utility\usability::maketeamusable(self.team);
  self.trigger disableplayeruse(var_0);
}

followplayer(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self.tetherplayer = var_0;
  level.tetherplayer = var_0;
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 11, 12, level.tetherplayer, 9);

  while(isDefined(self.tetherplayer)) {
    var_1 = self.tetherplayer getstance();
    self botsetstance(var_1);

    if(self.tetherplayer issprinting()) {
      self botsetflag("_encstr_839A09C658ABE896DBEA37", 0);
      self botsetflag("_encstr_A61A0D20256398C157E3632EF4B38B", 1);
    } else {
      self botsetflag("_encstr_A61A0D20256398C157E3632EF4B38B", 0);
      self botsetflag("_encstr_839A09C658ABE896DBEA37", 1);
    }

    if(distance2dsquared(self.tetherplayer.origin, self.origin) < 10000)
      level.vipdist = distance2dsquared(self.tetherplayer.origin, self.origin);
    else if(distance2dsquared(self.tetherplayer.origin, self.origin) > 10000) {
      level.vipdist = distance2dsquared(self.tetherplayer.origin, self.origin);
      var_2 = botgetclosestnavigablepoint(self.tetherplayer.origin, 40, self);

      if(isDefined(var_2)) {
        self botsetpathingstyle("_encstr_A15906DCDC5958DA");
        self botsetscriptgoal(var_2, 32, "_encstr_99C209E34FC743616118AB");
        var_3 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(3);

        if(var_3 == "_encstr_8B7205D9ED5958") {}
      }
    }

    wait 0.15;
  }

  level.tetherplayer = undefined;
}

watchownerdeath(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8BB70C685FBCC80B9B61161CC693");
  self waittill("_encstr_AD75063D571AE108");
  var_0.following = 0;
  var_0.usetime = 0;
  var_0.tetherplayer = undefined;
  level.tetherplayer = undefined;
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 10, 12);
}

hvtdeathwatcher() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AF1D0C83CD25E96C58A05F255B48");
  self waittill("_encstr_AD75063D571AE108");
  self.trackedobject scripts\mp\gameobjects::releaseid();
  self.trigger scripts\mp\utility\usability::setallunusable();
  level.hostages[0] = scripts\mp\tac_ops\hostage_utility::spawnhostage(self.origin, self.team, 1);
  level.hostages[0].outlineid = scripts\mp\utility\outline::outlineenableforteam(level.hostages[0].body, level.hostages[0].team, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.vip)) {
    if(isDefined(level.tetherplayer)) {
      if(isDefined(level.tetherplayer.team) && level.tetherplayer.team == self.team) {
        if(level.tetherplayer == self)
          self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 9);
        else
          self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 11);
      } else
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 12);
    } else if(isDefined(self.team) && level.vip.team == self.team)
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 10);
    else
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 12);
  } else if(isDefined(level.hostagecarrier)) {
    if(level.hostagecarrier.team == self.team) {
      if(level.hostagecarrier == self)
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 13);
      else
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 11);
    } else
      self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 12);
  } else if(level.hostages[0].team == self.team)
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 10);
  else
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 12);
}

playannouncerbattlechatter(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = "_encstr_8EE40543DB3BD1";
  var_4 = "_encstr_816908616B9751608687" + var_3 + "_encstr_BA4C02DF" + var_1 + "_encstr_BA4C02DF" + var_2;

  if(soundexists(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0)
        var_6 queuedialogforplayer(var_4, var_1, 2);
    }
  }
}

votimeendingsoon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A15F178159EB5191911A2078F2F5B76E4BC596038F2F18D785");
  playannouncerbattlechatter(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_AF822BB23CD14EC28D3AAF63A53AE8D82B315A4E46D7D82B16D9A5CDD9D7CDB7DBDCBE0B7D339CD2ACE646635E", 10);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\to_dd.gsc
***********************************************/

main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata())
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();

  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = ::onstartgametype;
}

maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.startedfromtacops = 1;
  onstartgametype(1);
}

maintacopsinit() {
  level.tacopssublevel = "_encstr_917E062D776791E9";
  level.currentmode = "_encstr_917E062D776791E9";
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);
}

maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("_encstr_917E062D776791E9", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("_encstr_917E062D776791E9", 3);
    scripts\mp\utility\game::registerscorelimitdvar("_encstr_917E062D776791E9", 0);
    scripts\mp\utility\game::registerroundlimitdvar("_encstr_917E062D776791E9", 1);
    scripts\mp\utility\game::registerwinlimitdvar("_encstr_917E062D776791E9", 1);
    scripts\mp\utility\game::registernumlivesdvar("_encstr_917E062D776791E9", 0);
    scripts\mp\utility\game::registerhalftimedvar("_encstr_917E062D776791E9", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("_encstr_917E062D776791E9", 0);
    scripts\mp\utility\game::setovertimelimitdvar(2);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.gamemodemaydropweapon = scripts\mp\utility\game::isplayeroutsideofanybombsite;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;

  level.dd = 1;
  level.bombsplanted = 0;
  level.ddbombmodel = [];
  level.aplanted = 0;
  level.bplanted = 0;
  level.allowhvtspawn = 0;
  level.hvtkilled = 0;
  level.bombexplodedcount = 0;
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setbombtimeromnvars();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8864089A40955C97F00D";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_BABB12E68D9CFA8EF6FA1991AF83E4DEDA7B8CAC"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_B40101";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_B40101";
  setomnvar("_encstr_950418EAD2F5C47BAD13AFD14BDAB2E4BEACCD231D2DD6B2D70B", 0);
  setomnvar("_encstr_BA0418D5D2FA98BDB698BE3A4BD6B227F556E6231D5ADA56FAC4", 0);
  setomnvar("_encstr_B47A12BBF4378A8F5573A12B03F138F30588CED7", 0);
  setomnvar("_encstr_B67A125D2DF589F65B31D78363B0DCE8AC8CBE4C", 0);
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 6);
  setdynamicdvar("_encstr_858A1BD7DE83CFF36801F17409EB4A3353F6037B6A212CFB6767C1FE43", 20);
  setdynamicdvar("_encstr_A2B11F6E1BE4FAD1EDF5198CEBDD58B3563959E60E8577B932563658BCBEC2B1D1", 20);
  setdynamicdvar("_encstr_97B11437C6C9D78EEDFA9191FA98F6DA133AA5D6594E", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_912A0A13AF7D41A192A545D6"));
  setdynamicdvar("_encstr_92A0141F43A321F028E7ECAAE670F3D11E13932C2707", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_85980AF3784743E3A1DB7D7D"));
  setdynamicdvar("_encstr_8CC0159BB19CBE1DEDFA1919D7199566BA6E95D196B5AC", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_87B30B90E22F53D3579C7B6185"));
  setdynamicdvar("_encstr_A94D16371B9CAFD17BAFC8467DE696C6B29B8EA08D0B73A3", getmatchrulesdata("_encstr_ACED09DB8FF96A0C48B36E", "_encstr_866A0CDCD2D8569B8E058D0BCD3A"));
  setdynamicdvar("_encstr_B25F1420F94B618BEF3FCBDA4015588BF5B8ACF87072", getmatchrulesdata("_encstr_9BAB0891566B1185E8B0", "_encstr_82610A2B1E3A4E16152DDACA"));
  setdynamicdvar("_encstr_A54918D613BB9E91A571A8B0697D5D1103AC53416D2B2D9B0C2B", getmatchrulesdata("_encstr_9BAB0891566B1185E8B0", "_encstr_85ED0E179550E2533320C25888191FDB"));
  setdynamicdvar("_encstr_AF52136E1B27EBE8DE7D2346F586B0C6CCD14B5B59", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_917E062D776791E9", 0);
  setdynamicdvar("_encstr_BABB12E68D9CFA8EF6FA1991AF83E4DEDA7B8CAC", 0);
  setdynamicdvar("_encstr_8CC0159BB19CBE1DEDFA1919D7199566BA6E95D196B5AC", 5);
  setdynamicdvar("_encstr_B25F1420F94B618BEF3FCBDA4015588BF5B88CF87072", 1);
}

onprecachegametype() {
  game["_encstr_BE9B13E59FF216D154AAD04B523D40C04B3773752B"] = "_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D";
  game["_encstr_BA2A15987B5B13EB39AC6CB7B3B29C9523EB6EBDEA3719"] = "_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255";
}

onstartgametype(var_0) {
  scripts\cp_mp\utility\game_utility::getmapname();
  seticonnames();

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  level.usestartspawns = 1;
  level.to_dd_phase_1 = 1;
  setclientnamemode("_encstr_8B070EAD85CDEA0B8D7D1B4316E63B2B");

  if(scripts\mp\utility\game::inovertime())
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_ADEB0C27227298E09388E4239D07";

  scripts\mp\utility\game::setobjectivetext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_AFF517A8C6B8EFD379FC41CFCFE86DD5CE8BB73491B779A569");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8E57173168DCDB3D0B294CCD2B3E051171F0E9E1B06581B57B");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_AFF517A8C6B8EFD379FC41CFCFE86DD5CE8BB73491B779A569");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8E57173168DCDB3D0B294CCD2B3E051171F0E9E1B06581B57B");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_813A1DE41D20A5A601A9FD615FB799B92EDDFB39AE9DF155DB89190BB9D9D3");
    scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_A27C1D15E65D98935F91BBFF69184C509F0D6FDFFDEDC0DDE73997FF716F05");
  }

  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_81611C35ADB1A5E8FD4393D71F38E0DC7194FB0F079961C05D57F39F3DAD");
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_81611C35ADB1A5E8FD4393D71F38E0DC7194FB0F079961C05D57F39F3DAD");
  } else {
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_915D1C69308493757361049513F6DDE9B9682939B86E474DB34F039B1623");
    scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_8CE21CFD65796D10358B4B1FA760A8A4294DE7373DF134086E8F3B2775E5");
  }

  thread waitformatchbegin();

  if(!istrue(var_0)) {
    _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::commoninit();
    activatespawns();
  }

  var_1 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1");
  var_2[0] = "_encstr_B60703EACA";
  var_2[1] = "_encstr_844E0C99C3A166200DFE2298E5ED";
  var_2[2] = "_encstr_A65908C41BED1BD62B4E";
  var_2[3] = "_encstr_A7290676E4D2378C";
  var_2[4] = "_encstr_8218041DF5FA";
  var_2[5] = "_encstr_959105B99040BD";
  scripts\mp\gameobjects::main(var_2);
  level.tacopssubmodetimeron = 1;
  var_3 = randomfloat(1.0);

  if(var_3 < 0.5)
    level.hvtlabel = "_encstr_B20703DFCF";
  else
    level.hvtlabel = "_encstr_B40703E96D";

  var_4 = "_encstr_8A800E70A0AAF7BB511E80DB71FF594A";
  var_5 = "_encstr_99061990532CF2E013E390766B4B32295230D26BCDB0FA67FFCA1B";
  level thread votimer();
  initbombs();
  thread createbridgecapturesite();
}

createbridgecapturesite() {
  var_0 = getEnt("_encstr_8A631247B7F58C32AF1327A5197656D799630B76", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.objectives))
    level.objectives = [];

  level.bridgeobjectiveindex = level.objectives.size;
  level.objectives[level.bridgeobjectiveindex] = var_0;
  var_1 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(level.objectives[level.bridgeobjectiveindex]);
  scripts\engine\utility::delaythread(3.0, ::delayset);
  var_1.onuse = ::bridgedompoint_onuse;
  level.objectives[level.bridgeobjectiveindex] = var_1;
  level.flagcapturetime = 10.0;
  level.flagneutralization = 0;
  waitframe();
  var_1 scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  var_1 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_1 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_1 scripts\mp\gameobjects::cancontestclaim(1);
  var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

delayset() {
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setownerteam("_encstr_8E8405EA382B2A");
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  level.objectives[level.bridgeobjectiveindex] _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_8E8405EA382B2A", 0);
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

bridgedompoint_onuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse(var_0);

  if(var_0.team == "_encstr_9A8507BA4040188D08") {
    level.objectives[level.bridgeobjectiveindex].onuse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse;
    level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setkeyobject(undefined);
    level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    startbombphase();
  }
}

startbombphase() {
  level.onnormaldeath = ::onnormaldeath;
  iprintlnbold("_encstr_8EB01088387BBF3F3187D3E947FBBFC29B60");
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setmodelvisibility(0);
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::disableobject();
  level.objectives[level.bridgeobjectiveindex].scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", "_encstr_BA19049F4B2D");
  level.to_dd_phase_1 = 0;
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_917E062D776791E9", "_encstr_9A8507BA4040188D08");
  thread bombs();
}

votimer() {
  wait 10;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_97B61933604EC5AB7518E31A5767E398D1908FEEC1E10E225323EE", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_9B2B194C1BCE9702DDE91A13724FFA7BE106D59120D1D30F9BE032", "_encstr_8E8405EA382B2A");
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::tacopslongwaitsec(30);
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_8AFE1C79738F59687EBF3337F96930931FBBD14BA9FB85B8D28C3313D5CE", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_84AC1C8BD8F64D23ED806E62F68BA91878885F37222EB4BAE7AE331CE9B3", "_encstr_8E8405EA382B2A");
}

initspawns() {
  var_0 = level.tacopsspawns;
  var_0.to_dd_spawns = [];
  var_0.to_dd_spawns["_encstr_91D90D2CB163A5B2DCEB6EA30B4ED1"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8CF11BF05BC71B4FCA9FD0CE7272B7801FB74070A795B377838337564B");
  var_0.to_dd_spawns["_encstr_998E0BF873AC1F16CF7CBF2E54"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5C819F31BB95B2722CBAE5623E1A4461F59786BBF793ECB963685");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_863615938BB975283C478E036AE130A05137190947A2BE");
  var_0.to_dd_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_863615938BB975283C478E036AE130A05137190947A2BE");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_83F31345279F6347A110478FC879178AC73788FC0E");
  var_0.to_dd_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_83F31345279F6347A110478FC879178AC73788FC0E");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_88BF0EF938DA6B9D508678F293117FAD", "_encstr_8DFF1B5F6806840231CD9E92A3E95A5DAEC8A3F73858F7AA09D1A44F96");
  var_0.to_dd_spawns["_encstr_88BF0EF938DA6B9D508678F293117FAD"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8DFF1B5F6806840231CD9E92A3E95A5DAEC8A3F73858F7AA09D1A44F96");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_BE690C97B399DBD14D72E0703BB0", "_encstr_A5F319ED9A9EC3F7E8594302C381CF43D96F9FC3DBB518A9E89377");
  var_0.to_dd_spawns["_encstr_BE690C97B399DBD14D72E0703BB0"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5F319ED9A9EC3F7E8594302C381CF43D96F9FC3DBB518A9E89377");
}

getspawnpointdist(var_0, var_1) {
  var_2 = getpathdist(var_0.origin, var_1, 16000);

  if(var_2 < 0)
    var_2 = distance(var_0.origin, var_1);

  return var_2;
}

getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];

  if(level.usestartspawns && !isDefined(self.tacopsmapselectedarea))
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_0.to_dd_spawns[var_1 + "_encstr_B4810709B378B9F3F5"]);
  else if(istrue(level.to_dd_phase_1)) {
    var_3 = var_1 + "_encstr_BE2D0807661BF7578768";
    var_4 = var_0.to_dd_spawns[var_3];
    var_4 = scripts\mp\tac_ops_map::filterspawnpoints(var_4);
    var_2 = undefined;
  } else {
    var_4 = var_0.to_dd_spawns[var_1];
    var_4 = scripts\mp\tac_ops_map::filterspawnpoints(var_4);
    var_2 = undefined;
  }

  return var_2;
}

activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A11904A822A6");
  thread usetacopsmapongamestart();
  level.getspawnpoint = ::getspawnpoint;
}

usetacopsmapongamestart() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_917E062D776791E9", "_encstr_8E8405EA382B2A");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_AC7D1750D702E381928360E01EFAE9087DC701F813A1396FDA", "_encstr_9A8507BA4040188D08");
}

waitforhvtrelease() {
  level endon("_encstr_AA840F95BF514190F95FA079EF1EE9930A");
  level endon("_encstr_842909CE58B659AF2B3791");
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::tacopslongwaitsec(45);
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::teamprint(&"_encstr_AB632509F9FFDD07ED905149C8377B9777550FA01C67860385680921B01F97ED2FC33F97A57F03", &"_encstr_8AB22551A8EAC7AE7F15FEF6296FD52F417031BA913547254371E6C8C48B5E5B3A3821C93859D3");

  if(level.hvtlabel == "_encstr_B20703DFCF")
    level.extractionpos = scripts\engine\utility::getStructArray("_encstr_8D5415CA7D2E73721F79F01BEBD94EDA36DB3F7806BF19", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0].origin;
  else
    level.extractionpos = scripts\engine\utility::getStructArray("_encstr_A554150D7BB9D10BCE59AF95E18E272C1B8E2DBD9BBE98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0].origin;

  level.ddlz = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", level.extractionpos, 0, 90, 128);
  level.ddlz.angles = (0, 0, 0);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("_encstr_A65110FD59AD688EAF2393BB2B97DDA085B5", 0, 0, 10);
  level.ddlz.useobj = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setupobjective(0, "_encstr_9A8507BA4040188D08", level.ddlz);
  level.ddlz.team = "_encstr_9A8507BA4040188D08";
  level.ddlz.ownerteam = "_encstr_9A8507BA4040188D08";
  level.ddlz.visibleteam = "_encstr_9A19040BCDBC";
  level.ddlz.useobj _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::updateextracticons();
  level.ddlz.useobj scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  level.ddlz.offset3d = (0, 0, 16);
  _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::makelzextractionvisuals(level.ddlz);
  level.ddlz.location = level.extractionpos;

  if(scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_AB580A05672AE35D5FFF50B8")) {
    level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B"), ::compare_player_score);
    var_0 = level.topplayers[0] _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::spawnextractchopper(level.ddlz, 30);
    level.ddlz thread _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::extractvehicledeathwatcher();
    var_0 thread waitdoextraction();
  }
}

compare_player_score(var_0, var_1) {
  return var_0.score >= var_1.score;
}

waitdoextraction() {
  level endon("_encstr_AA840F95BF514190F95FA079EF1EE9930A");
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::tacopslongwaitsec(15);
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::teamprint(&"_encstr_836325CB7761F6A12D37071F2ECFB936598F6987BB08A029745D4E9687F43145312FC3C19751DE", &"_encstr_85B225651CA973D981AB575F8B5CA0BB2164AA6517F1277063AB6F7779F549E5190D1632AD19F2");

  foreach(var_1 in level.objectives)
  removedoorcollision(var_1.objectivekey);

  foreach(var_1 in level.objectives) {
    if(isDefined(var_1.ondisableobjective))
      var_1[[var_1.ondisableobjective]]();
  }

  level.to_ddhvt.invulnerable = 0;
  level.to_ddhvt thread hvtmovetoextractpt();
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::tacopslongwaitsec(1);

  if(isDefined(level.to_ddhvt))
    scripts\mp\tac_ops\hvt_utility::hvtcleanup(level.to_ddhvt);

  level.ddlz _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::cleanuplzvisuals();
  self notify("_encstr_A6201117400BFA9A57AD49BC185F83B131C037");
}

hvtmovetoextractpt() {
  level endon("_encstr_AA840F95BF514190F95FA079EF1EE9930A");
  level endon("_encstr_842909CE58B659AF2B3791");
  self endon("_encstr_AD75063D571AE108");
  self botsetscriptgoal(level.extractionpos, 20, "_encstr_99CC09DA9020C4ECD149AD");
  var_0 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

waitformatchbegin() {
  level endon("_encstr_842909CE58B659AF2B3791");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.usestartspawns = 0;
}

onspawnplayer() {
  if(scripts\mp\utility\game::inovertime() || self.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 1);
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
  } else {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(isDefined(self.pers["_encstr_8FB00783D8C2CDE8DC"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_8FB00783D8C2CDE8DC"]);
  else
    scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["_encstr_817B0812789D1387E986"]))
    scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_817B0812789D1387E986"]);
  else
    scripts\mp\utility\stats::setextrascore1(0);

  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = 0;

  if(self.team == "_encstr_9A8507BA4040188D08")
    var_0 = 1;
  else if(self.team == "_encstr_8E8405EA382B2A")
    var_0 = 2;

  self setclientomnvar("_encstr_8C460FD55A7D8E16D8DB83B9FAD15616DA", var_0);

  if(!isagent(self))
    scripts\mp\playerlogic::incrementalivecount(self.team);

  scripts\mp\tac_ops\roles_utility::kitspawn();
}

dd_endgame(var_0, var_1) {
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

ondeadevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }
  if(var_0 == "_encstr_AF1904A7F929") {
    if(level.bombplanted)
      dd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][game["_encstr_B6A70A23CA6659DC91CAE4DC"] + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
    else
      dd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][game["_encstr_991C0AB9ED5B57161FE89B83"] + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  } else if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(level.bombplanted) {
      return;
    }
    level thread dd_endgame(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][game["_encstr_991C0AB9ED5B57161FE89B83"] + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  } else if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level thread dd_endgame(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][game["_encstr_B6A70A23CA6659DC91CAE4DC"] + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
  var_5 = var_0.team;

  if(var_0.isplanting) {
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_8AD1096F4D428DC321FB3B");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  } else if(var_0.isdefusing) {
    thread scripts\common\utility::_id_13E0A(level._id_11B30, var_2, "_encstr_B669098CAC99BA6E96E63B");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  }

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_awardgenericbombzonemedals(var_1, var_0);

  if(!isagent(var_0)) {
    if(!isDefined(var_0.switching_teams))
      var_0 scripts\mp\playerlogic::decrementalivecount(var_0.team);
  }
}

ontimelimit() {
  foreach(var_1 in level.objectives) {
    if(isDefined(var_1.ondisableobjective))
      var_1[[var_1.ondisableobjective]]();
  }

  if(isDefined(level.onphaseend)) {
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
    [[level.onphaseend]]("_encstr_8E8405EA382B2A");
  }
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_85980AF3784743E3A0DB7D7D", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_87B30B90E22F53D357BC7B6185", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarintvalue("_encstr_912A0A13AF7D41E192A545D6", 30, 1, 300);
  level.ddtimetoadd = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_82610A2B1E3A4E16152DDACA", 2, 0, 5);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_85ED0E179550E2533320C25888191FDB", 1, 0, 5);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("_encstr_866A0CDCD2D8569B8E058D0BCD3A", 0, 0, 1);
}

verifybombzones(var_0) {
  var_1 = "_encstr_B40101";

  if(var_0.size != 3) {
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(issubstr(tolower(var_6.script_label), "_encstr_994C023A")) {
        var_2 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "_encstr_8B4C024C")) {
        var_3 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "_encstr_834C02D8"))
        var_4 = 1;
    }

    if(!var_2)
      var_1 = var_1 + "_encstr_A917049A1119";

    if(!var_3)
      var_1 = var_1 + "_encstr_881704128191";

    if(!var_4)
      var_1 = var_1 + "_encstr_851704960656";
  }

  if(var_1 != "_encstr_B40101")
    return;
}

initbombs() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.multibomb = 1;
  level.objectives = [];
}

bombs() {
  var_0 = getEntArray("_encstr_844E0C99C3A166200DFE2298E5ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 0) {
    return;
  }
  wait 0.5;
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setupobjective(var_3);
    var_4.onbeginuse = ::onbeginuse;
    var_4.onenduse = ::onenduse;
    var_4.onuse = ::onuseplantobject;
    var_4.ondisableobjective = ::bombzone_ondisableobjective;
    level.objectives[var_4.objectivekey] = var_4;
  }
}

onbeginuse(var_0) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onbeginuse(var_0);
}

onenduse(var_0, var_1, var_2) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onenduse(var_0, var_1, var_2);
}

onuseplantobject(var_0) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onuseplantobject(var_0);
}

resetbombzone() {
  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
    var_0 = "_encstr_8A8B128FE7F35F1019EDF36E93F9301CEA1B672D";
    var_1 = "_encstr_8A8B128FE7F35F1019EDF36E93F9301CEA1B672D";
  } else {
    scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    var_0 = "_encstr_994B105B20DB3A9F30206457CD5973870DE0" + self.label;
    var_1 = "_encstr_8F361077FED381AD0833C589FCA8DA67776B" + self.label;
  }

  self.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setusetext(&"_encstr_85B116653F4A60E887BD4B37955C01AD19C7AD7DF7C12E30");
  scripts\mp\gameobjects::setusehinttext(&"_encstr_86521C40F31A48B789C00EA1E87719B36165B94985B9F1294046695955AA");
  scripts\mp\gameobjects::setobjectivestatusicons(var_0, var_1);
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  self.useweapon = getcompleteweaponname("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B");
  self.bombexploded = undefined;
}

bombhandler(var_0, var_1, var_2) {
  level.bombsplanted = level.bombsplanted - 1;

  if(self.label == "_encstr_B20703DFCF")
    level.aplanted = 0;
  else
    level.bplanted = 0;

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setbombtimeromnvars();

  if(level.gameended) {
    return;
  }
  if(var_1 == "_encstr_860808CB78E2984063BA") {
    self.bombexploded = 1;
    scripts\mp\utility\dialog::statusdialog("_encstr_A1310CC5A8FAC16B17A2BBB0B0A5", game["_encstr_B6A70A23CA6659DC91CAE4DC"], 1);
    scripts\mp\utility\dialog::statusdialog("_encstr_9B7C0DF35F15829D73F9AF8330E844", game["_encstr_991C0AB9ED5B57161FE89B83"], 1);

    foreach(var_4 in level.objectives) {
      removedoorcollision(var_4.objectivekey);

      if(isDefined(var_4.ondisableobjective))
        var_4[[var_4.ondisableobjective]]();
    }

    wait 2;
    restarttimer();

    if(level.ddtimetoadd > 0)
      level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_824E13863B73F3E8859B67F1D070739EFFE15F4F39", var_0);

    waitframe();
    level.bombexplodedcount++;

    if(level.bombsplanted == 1)
      level notify("_encstr_9BC10FEA30280BA2C7687A82409B5DAFA1");

    restarttimer();
    level.bombsplanted = level.bombsplanted - 1;
    setomnvar("_encstr_B47A12BBF4378A8F5573A12B03F138F30588CED7", 0);
    setomnvar("_encstr_B67A125D2DF589F65B31D78363B0DCE8AC8CBE4C", 0);
    _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::extendtacopstimelimitms(30000);

    if(isDefined(level.onphaseend) && level.bombexplodedcount == 1) {
      [[level.onphaseend]]("_encstr_9A8507BA4040188D08");
      return;
    }
  } else {
    restarttimer();
    var_0 notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + self.label);
    self notify("_encstr_9A7B088CCA335D37CA91");
    resetbombzone();
  }
}

removedoorcollision(var_0) {
  var_1 = getEnt("_encstr_B6B311298409C86067EA8A50523F30889D1189" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 delete();
}

restarttimer() {
  _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::resumetacopstimer();

  if(level.bombsplanted <= 0)
    level.timelimitoverride = 0;
}

bombzone_ondisableobjective() {
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
}

seticonnames() {
  level.icontarget = "_encstr_8F511ABB16F2E0DE969B8E7D43584E19E0DB2DCD3AFA8EB039CE95A3";
  level.iconneutral = "_encstr_96730D2FF80BE0794D25C3BB967B02";
  level.iconcapture = "_encstr_AF120B78D23BF9C6A7568DF129";
  level.icondefend = "_encstr_AA5E0EFB38032B514DE8E23A109155A7";
  level.iconcontested = "_encstr_A6C21D1FA7E70AAF8B30C529326FF8C477B827133CBEBAAF085B630BFB4345";
  level.icontaking = "_encstr_BD4218BB162FC1EDD2E6E8FAD158ADB4E6D9AF6CA1B2D9C9BDB9";
  level.iconlosing = "_encstr_A3471A8421A74B9714B2F899EA2E65015BC703F0AC9770CFFAAA2050";
  level.iconbombcapture = "_encstr_8F361077FED381AD0833C589FCA8DA67776B";
  level.iconbombdefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.iconescort = "_encstr_BE7610A351B00882DBB5B3279BFE0A5FB09B";
}

setupkillcament() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0.angles = self.angles;
  var_0 rotateYaw(-45, 0.05);
  waitframe();
  var_1 = self.origin + (0, 0, 5);
  var_2 = self.origin + anglesToForward(var_0.angles) * 100 + (0, 0, 128);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, self, scripts\engine\trace::create_default_contents(1));
  self.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3["_encstr_BD260953AA97E3F014279D"]);
  self.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
  var_0 delete();
}
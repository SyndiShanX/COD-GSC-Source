/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\tdef.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  level.keepviewingthe747 = [];
  var_0 = getEntArray("_encstr_BE8D16A62BEA2DED5168AD8AC923D87222E7631750ABA481", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  level.keepviewingthe747[level.keepviewingthe747.size] = var_2.origin;

  level.keepstreamposfresh = (0, 0, 0);
  var_4 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_4) {
    if(var_6.script_label == "_encstr_B40703E96D") {
      level.keepstreamposfresh = var_6.origin;
      break;
    }
  }

  var_8[0] = scripts\mp\utility\game::getgametype();
  var_8[1] = "_encstr_A11904E823B6";
  scripts\mp\gameobjects::main(var_8);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 7500);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    setdynamicdvar("_encstr_82B922C862CAE7D3F30D5CD8F037FB47F78B50901A65B589F7355DDEF70B413B1BB23810", 1);
    setdynamicdvar("_encstr_AF0F1D3EEB4366798FCA9051B3652FBB778346BB4F8B0F93B2D238115ABDCB", 60);
    level.matchrules_enemyflagradar = 1;
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.carrierarmor = 100;
  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.key_position = 1;
  level.key_drop_on_client_death_disconnect = [];
  level.scorefrozenuntil = 0;
  level.key_hint = 0;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_91A0129D2CAD95D1F2C156BE915699ACCD9156C9";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_A5EE0E780BFD08A5321F7B07635AE040"] = &"_encstr_8F180FE58F40BBCC3D09C97169E9B567C5";
  game["_encstr_BE9B13E59FF216D154AAD04B523D40C04B3773752B"] = "_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D";
  game["_encstr_BA2A15987B5B13EB39AC6CB7B3B29C9523EB6EBDEA3719"] = "_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A2660AB0527D4F23CFCC8D71";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE8F0DE7A1DA2CB7E2D0AF8A028179"] = "_encstr_B44E120D7B40B20A7329532B712FE2D758238552";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_855C0E99B185CEEB9C9547AE39B9CA32"] = "_encstr_AA280F329B05F1B10197497AA9BB3DDD25";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BCD0DC83AA6CFEE97752D2E49BF50"] = "_encstr_81A61567E39896A3A393834AB88FD78158BBF4F263A81C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD4A11FA601D07E8410DA4B11719F37FB2B9C2"] = "_encstr_BA7913F8136B8DC829EBE0189379E1BFB3BE62752D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C11138710F0B5436005733F7F08DAE2F87B7A0FC9"] = "_encstr_846B1407D569FD585679EBF18BC0844F1729BF220859";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8559141F553552F981B9753EB1A93A6A15CBDBBB3BED"] = "_encstr_84691485E38BF21DD34962D5EAF88FB752F8BB25E065";
  setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_8A361737E0B35F43C1BD8FC91FD18A1CF968C7BBE86DD4DA2F", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_91540E0EE05BA82B0BB672F61963C2B3"));
  setdynamicdvar("_encstr_A6A4196EB193FAE8232BCCF5E038AD5195C26BEAB4471A233616EC", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_8A7D105789181528A070515F732CCCC5A771"));
  setdynamicdvar("_encstr_837318DC1BE4FAE8C8CACCEB0E83B5918D859D0DB0279CB456E4", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_878D0F2B0952808CD0391E9EF320C1CAB6"));
  setdynamicdvar("_encstr_92D015C37908696B3533F5C748415A2A51ED3963D4B063", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_93910C9EC867BB18C0D18F500D2D"));
  setdynamicdvar("_encstr_A1A8162E27CA31B02D79071706478233539F17235B4406F7", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_ABBE0DB98DF64E5614564E154B365B"));
  setdynamicdvar("_encstr_87301AEBB1E69FFBC83B9E5FCF1882E383E9734098B04F72610B9D6D", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_953411C6C29CC95A2B4E487B37EAB92A2DDACA"));
  setdynamicdvar("_encstr_835F1BFB8E1B89A1827207B7521FAEBBC0C07BC5D86E63E276B3BF5B1F", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_A6CD12DA01F2E092A2C03A7835AFD6ABFA886EBA"));
  setdynamicdvar("_encstr_933B15DC6C93FAA3C8B266AF46591B2C2FE063B0BCAC93", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_A9210CA017EC518B7175D7E30F6B"));
  setdynamicdvar("_encstr_B855143E5EA33FF31CE75899972069D7CA07BDC9B64B", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_8CA10BD013238F78BFFAB053C3"));
  setdynamicdvar("_encstr_BA721D08B7FE7E9832DF38C995D2B94F9D5E2CD09CFF1BFC2825B0AFE076F1", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_BE351438BB69E983CAEB5BDC86931B50DEB3B8E0F719"));
  setdynamicdvar("_encstr_82B922C862CAE7D3F30D5CD8F037FB47F78B50901A65B589F7355DDEF70B413B1BB23810", getmatchrulesdata("_encstr_870D0F89161B36A1B7D6D6DBCD882CD1C2", "_encstr_B665199BA72B470D6BAFCBD728594A431023E03FB548EF70D45D68"));
  setdynamicdvar("_encstr_AF0F1D3EEB4366798FCA9051B3652FBB778346BB4F8B0F93B2D238115ABDCB", getmatchrulesdata("_encstr_870D0F89161B36A1B7D6D6DBCD882CD1C2", "_encstr_8DD414B01F581A5F76BB4A1220DE97D230C16C218340"));
  setdynamicdvar("_encstr_92521AE63627D78E9195CCF537867BDD8A37CAD6E5D00B27E4B4B2C9", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B"));
  setdynamicdvar("_encstr_AC811760CA62BF8B9B7524B041A3B083C232E8A8D3B36B6077", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_83FA0E968C63594A9537B2A38A96D6CA"));
  setdynamicdvar("_encstr_962F129B364EBE47C8CA99F50D5863993AA5B556", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_85EF050CB150E7", 0);
  setdynamicdvar("_encstr_A22B11E61B4EF5A38C2B33EB8339B7ADDE23CA", 0);
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
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_88C810F421522A1A1552AC2A35BC8A115132");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_88C810F421522A1A1552AC2A35BC8A115132");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_952316C8325BDDFF6B1039B9A96D1935DF9E485E4B2767CB");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_9A7F1EB8153A156EDCCBFD0133D8D5E38F4F3F769F737D8EE2A5C37910687503");
  }

  initspawns();
  tdef();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level._id_1283A = scripts\mp\utility\dvars::dvarintvalue("_encstr_91540E0EE05BA82B0BB672F61963C2B3", 50, 0, 250);
  level._id_1283B = scripts\mp\utility\dvars::dvarintvalue("_encstr_8A7D105789181528A070515F732CCCC5A771", 100, 0, 250);
  level._id_12839 = scripts\mp\utility\dvars::dvarintvalue("_encstr_878D0F2B0952808CD0391E9EF320C1CAB6", 250, 0, 250);
  level.scoringtime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_93910C9EC867BB18C0D18F500D2D", 1, 1, 10);
  level.scorepertick = scripts\mp\utility\dvars::dvarintvalue("_encstr_ABBE0DB98DF64E5614564E154B365B", 1, 1, 25);
  level.carrierbonustime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_953411C6C29CC95A2B4E487B37EAB92A2DDACA", 4, 0, 10);
  level.carrierbonusscore = scripts\mp\utility\dvars::dvarintvalue("_encstr_A6CD12DA01F2E092A2C03A7835AFD6ABFA886EBA", 25, 0, 250);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9210CA017EC518B7175D7E30F6B", 1, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8CA10BD013238F78BFFAB053C3", 2.5, 0, 30);
  level.player_has_respawn_munition = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_BE351438BB69E983CAEB5BDC86931B50DEB3B8E0F719", 10, 0, 30);
  level.possessionresetcondition = scripts\mp\utility\dvars::dvarintvalue("_encstr_B665199BA72B470D6BAFCBD728594A431023E03FB548EF70D45D68", 0, 0, 2);
  level.possessionresettime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8DD414B01F581A5F76BB4A1220DE97D230C16C218340", 0, 0, 150);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_83FA0E968C63594A9537B2A38A96D6CA", 15, 0, 60);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B", 5, 0, 6);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_85EF052CF150E7", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(var_3 in level.spawnpoints)
  freeze_timer_at_max_time_bomb_case(var_3);
}

freeze_timer_at_max_time_bomb_case(var_0) {
  var_0.scriptdata.lootchopper_droploot = undefined;
  var_1 = getpathdist(var_0.origin, level.keepviewingthe747[0], 1000);

  if(var_1 < 0)
    var_1 = scripts\engine\utility::distance_2d_squared(var_0.origin, level.keepviewingthe747[0]);
  else
    var_1 = var_1 * var_1;

  var_0.scriptdata.lootchopper_droploot = var_1;
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_3 = [];
    var_3["_encstr_AC51159A71EC777DC83B8A46D118C76B802BC223583023"] = level.keeprightdooropen.visuals[0].origin;

    if(isDefined(level.keeprightdooropen.carrier))
      var_3["_encstr_AA3116F74B5B5B70C8386B125311196BAF6FE64264B8C2A2"] = level.keeprightdooropen.carrier.origin;
    else
      var_3["_encstr_AA3116F74B5B5B70C8386B125311196BAF6FE64264B8C2A2"] = var_3["_encstr_AC51159A71EC777DC83B8A46D118C76B802BC223583023"];

    var_3["_encstr_850A20BFD580A2540989874FC0209DCBFC09472F293D6A0C81D0BD577D90B3E32E8B"] = 1000000;
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18", undefined, var_3);
  }

  return var_2;
}

tdef() {
  level.flagmodel["_encstr_9A8507BA4040188D08"] = "_encstr_86FE13B3F501B71F03D0E2599041D61F9EDC3D3B0D";
  level.flagbase["_encstr_9A8507BA4040188D08"] = "_encstr_A56913CF75743E17E7397139EFCD689C6F32567259";
  level.carryflag["_encstr_9A8507BA4040188D08"] = "_encstr_BDAF1807E4F683FA8D1DCCFACE2CAD56BE66638576BEEECADC1D";
  level.flagmodel["_encstr_8E8405EA382B2A"] = "_encstr_A2931336D1CCBEB3585B2BEB661B8576EB95C237A3";
  level.flagbase["_encstr_8E8405EA382B2A"] = "_encstr_A56913CF75743E17E7397139EFCD689C6F32567259";
  level.carryflag["_encstr_8E8405EA382B2A"] = "_encstr_A344180732FF4BF7961368991A2E5B21E7CE8177BF9751D3FA7B";
  setupwaypointicons();
  level.iconescort = "_encstr_BD2E15FB09E850EAA3CDDB7F3356D2B7583379078D700F";
  level.iconkill = "_encstr_8E1D12A77FE20B1D13C8F359B87117FF18D33424";
  level.iconcaptureflag = "_encstr_922D1337B98850786F22335EEB2722A0A916B99327";
  level.icondefendflag = "_encstr_92BB1560CA8001084F9ECD506C87D1E3AD02A950B2DE57";
  level.iconreturnflag = "_encstr_BEA8161BF0472BD82920DBE7AB513E3F8EC07E117E6031EF";
  level._id_11C5F = "_encstr_87C218EE16E583DE4B9BD1FADA369D7D59D60EA3F2D7CCD8C23B";
  level._id_11C60 = "_encstr_AB8717DDC22F0EF62DE6D1AF5B1B9DBECCAB63B1F53363853B";
  level.icontarget = "_encstr_8F361077FED381AD0833C589FCA8DA67776B";
  init_relic_noluck();
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8E1D12A77FE20B1D13C8F359B87117FF18D33424", 2, "_encstr_88BF06FD784A6393", "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E", "_encstr_A6A2132DB17B73BEBB0B2F07DEB4B9D17DD64B8D36", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BEA8161BF0472BD82920DBE7AB513E3F8EC07E117E6031EF", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_B89220350AD792937482D4A2F5F49CC4B2E59E9052D749A20D9EAC5449FAD050A06A", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BD2E15FB09E850EAA3CDDB7F3356D2B7583379078D700F", 2, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_922D1337B98850786F22335EEB2722A0A916B99327", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A5D31DA9A0BE92397414D48A7DF4E413CA79D309947DA882A52ABE3414054D", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_92BB1560CA8001084F9ECD506C87D1E3AD02A950B2DE57", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8F361077FED381AD0833C589FCA8DA67776B", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_87C218EE16E583DE4B9BD1FADA369D7D59D60EA3F2D7CCD8C23B", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_A9BD2232E835875688F1455A8F709EEF68860B9AB2977F8C98E94753A150A90F01DBB383", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AB8717DDC22F0EF62DE6D1AF5B1B9DBECCAB63B1F53363853B", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_866E21D8C5AF0E0B1F8BA80E074B27A03090A3035720F8E0762BD88743CCAF5FD7C5EB", 0);
}

init_relic_noluck() {
  level.keepviewingthe747 = scripts\engine\utility::array_randomize(level.keepviewingthe747);
  var_0 = level.keepviewingthe747[0] + (0, 0, 64);
  var_1 = level.keepviewingthe747[0] + (0, 0, -64);
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1, undefined, scripts\engine\trace::create_default_contents(1));
  level.keepviewingthe747[0] = var_2["_encstr_BD260953AA97E3F014279D"];
  level.keeprightdooropen = init_unlock_silo("_encstr_9A8507BA4040188D08");
  level thread player_in_bush_monitor();
}

player_in_bush_monitor() {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    level.key_activate._id_11F89 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");
    level.key_activate._id_11F89 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  }

  if(level.player_has_respawn_munition) {
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
    level.key_activate._id_11F89 thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_1199E(level.player_has_respawn_munition, level.keeprightdooropen.curorigin + level.keeprightdooropen.offset3d);
    wait(level.player_has_respawn_munition);
    level.key_activate._id_11F89 scripts\mp\gameobjects::_id_1317F(level.iconcaptureflag, level.iconcaptureflag, level._id_11C60);
    level.keeprightdooropen.trigger scripts\engine\utility::trigger_on();

    foreach(var_1 in level.teamnamelist)
    scripts\mp\utility\dialog::leaderdialog("_encstr_AA8314574B50C73FDF38F323237E81CF7780B5FDD3BF", var_1);
  }
}

init_unlock_silo(var_0) {
  level.pickuptime = 0;
  level.returntime = 0;
  var_1 = 32;
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", level.keepviewingthe747[0], 0, var_1, 128);
  var_3 = [];
  var_3[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.keepviewingthe747[0]);
  var_3[0] setModel(level.flagmodel[var_0]);
  var_3[0] setasgametypeobjective();
  var_3[0] setteaminhuddatafromteamname(var_0);
  var_4 = "_encstr_A7A408B9CA5D1D4E2C63";
  var_5 = scripts\mp\gameobjects::createcarryobject(var_4, var_2, var_3, (0, 0, 85));
  var_5 scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  var_5 scripts\mp\gameobjects::setteamusetime("_encstr_ACFC091AE8AB2FCBE15119", level.pickuptime);
  var_5 scripts\mp\gameobjects::setteamusetime("_encstr_88BF06FD784A6393", level.returntime);
  var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  var_5 scripts\mp\gameobjects::_id_1317F(level.iconescort, level.iconkill, level._id_11C60);
  var_5 scripts\mp\objidpoolmanager::objective_set_play_intro(var_5.objidnum, 0);
  var_5 scripts\mp\objidpoolmanager::objective_set_play_outro(var_5.objidnum, 0);
  var_5 scripts\mp\gameobjects::_id_12B13(::player_infil_already_played);
  var_5.allowweapons = 1;
  var_5.onpickup = ::onpickup;
  var_5.onpickupfailed = ::onpickup;
  var_5.ondrop = ::ondrop;
  var_5.onreset = ::onreset;

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_5.objidpingfriendly = 1;
        var_5.objidpingenemy = 0;
        var_5.objpingdelay = 60.0;
        break;
      case 1:
        var_5.objidpingfriendly = 0;
        var_5.objidpingenemy = 0;
        var_5.objpingdelay = 0.05;
        break;
      case 2:
        var_5.objidpingfriendly = 1;
        var_5.objidpingenemy = 0;
        var_5.objpingdelay = 1.0;
        break;
      case 3:
        var_5.objidpingfriendly = 1;
        var_5.objidpingenemy = 0;
        var_5.objpingdelay = 1.5;
        break;
      case 4:
        var_5.objidpingfriendly = 1;
        var_5.objidpingenemy = 0;
        var_5.objpingdelay = 2.0;
        break;
      case 5:
        var_5.objidpingfriendly = 1;
        var_5.objidpingenemy = 0;
        var_5.objpingdelay = 3.0;
        break;
      case 6:
        var_5.objidpingfriendly = 1;
        var_5.objidpingenemy = 0;
        var_5.objpingdelay = 4.0;
        break;
    }

    var_6 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
    var_5.pingobjidnum = var_6;
    scripts\mp\objidpoolmanager::objective_add_objective(var_6, "_encstr_8267056410C669", var_5.origin);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_6, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var_6, 0);
    var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99", var_6);
    objective_setownerteam(var_6, var_0);
    var_5 scripts\mp\gameobjects::_id_1317F(level.iconescort, level.iconkill, level._id_11C60, var_6);
  } else {
    var_5.objidpingfriendly = 1;
    var_5.objidpingenemy = 0;
    var_5.objpingdelay = 3.0;
  }

  level.key_activate = init_usb_animations(var_0, var_5);
  return var_5;
}

player_infil_already_played(var_0) {
  return !var_0 scripts\cp_mp\utility\player_utility::isinvehicle();
}

init_usb_animations(var_0, var_1) {
  var_2 = var_1.visuals[0].origin;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel(level.flagbase[var_0]);
  var_3.ownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
  var_3 setasgametypeobjective();
  var_3 setteaminhuddatafromteamname(var_0);
  var_3._id_11F89 = scripts\mp\gameobjects::createobjidobject(var_2, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 85), undefined, "_encstr_9A19040BCDBC", 0);
  var_3._id_11F89 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");

  if(level.player_has_respawn_munition) {
    var_1.trigger scripts\engine\utility::trigger_off();
    var_3._id_11F89 scripts\mp\gameobjects::_id_1317F(level.icontarget, level.icontarget, level._id_11C60);
  } else
    var_3._id_11F89 scripts\mp\gameobjects::_id_1317F(level.iconcaptureflag, level.iconcaptureflag, level._id_11C60);

  return var_3;
}

setteaminhuddatafromteamname(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    self setteaminhuddata(1);
  else if(var_0 == "_encstr_9A8507BA4040188D08")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}

onpickup(var_0, var_1, var_2) {
  self notify("_encstr_9A990A13739E149BF7605DD9");
  var_0 notify("_encstr_BD920E0FA530B1ABDB19CAD2013877B2");
  level.key_activate._id_11F89 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  level.keeprightdooropen.initscriptablemanagement = var_0;
  var_0 thread choose_and_drop_tank_near_hostage();
  var_0 thread player_helis();
  var_3 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(var_0.team);
  var_4 = var_0.pers["_encstr_8AEF05472BC2D6"];

  if(var_4 == "_encstr_9A8507BA4040188D08")
    var_5 = "_encstr_8E8405EA382B2A";
  else
    var_5 = "_encstr_9A8507BA4040188D08";

  var_0 attachflag();
  var_0 scripts\mp\utility\stats::incpersstat("_encstr_A17908687A36275B3B73", 1);

  if(self.ownerteam == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", var_0 getentitynumber());
  else
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", var_0 getentitynumber());

  var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0)
      scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    else {
      scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
      objective_state(self.pingobjidnum, "_encstr_AF5A081BBAC993AC73A3");
      scripts\mp\gameobjects::updatecompassicon("_encstr_88BF06FD784A6393", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "_encstr_A6A2132DB17B73BEBB0B2F07DEB4B9D17DD64B8D36");
      objective_setbackground(self.pingobjidnum, 2);
      scripts\mp\objidpoolmanager::_id_11F7D(self.pingobjidnum, 1);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.pingobjidnum, "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.pingobjidnum, "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E");
      objective_setownerteam(self.pingobjidnum, var_4);
    }
  }

  scripts\mp\gameobjects::_id_1317F(level.iconescort, level.iconkill, level._id_11C60);
  scripts\mp\utility\print::printandsoundoneveryone(var_4, var_5, undefined, undefined, "_encstr_A9270D032BDE1829E38E33C7DB0D26", "_encstr_A72E13B6C1F5AC3756ADBCFADB899AEBE885DA2B9B", var_0);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("_encstr_BD4A11FA601D07E8410DA4B11719F37FB2B9C2", var_4);
    scripts\mp\utility\dialog::leaderdialog("_encstr_8BCD0DC83AA6CFEE97752D2E49BF50", var_5);
  }

  thread scripts\mp\hud_util::teamplayercardsplash("_encstr_9A041398929D516047EC3094DC3F293184DAA0A01B", var_0);
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_A7660B998D58B30ED236AD5DC1");

  if(!isDefined(self.previouscarrier) || self.previouscarrier != var_0)
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BD130A5D809EB9A92F6B2169");

  var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A31C07E04BD8ADABE0", var_0.origin);
  self.previouscarrier = var_0;

  if(level.codcasterenabled)
    var_0 setgametypevip(1);
}

returnflag() {
  scripts\mp\gameobjects::returnhome();
}

ondrop(var_0) {
  if(isDefined(var_0.leaving_team)) {
    self.droppedteam = var_0.leaving_team;
    var_0.leaving_team = undefined;
  } else if(!isDefined(var_0))
    self.droppedteam = self.ownerteam;
  else
    self.droppedteam = var_0.team;

  level.keeprightdooropen.initscriptablemanagement = undefined;

  if(isDefined(var_0))
    var_0 _id_13FFA();

  scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  var_1 = self.droppedteam;
  var_2 = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  objective_state(self.pingobjidnum, "_encstr_8267056410C669");

  if(level.returntime >= 0)
    scripts\mp\gameobjects::_id_1317F(level.iconreturnflag, level.iconreturnflag, level._id_11C60);
  else {
    scripts\mp\gameobjects::_id_1317F(level.iconreturnflag, level.iconreturnflag, level._id_11C60);
    scripts\mp\objidpoolmanager::_id_11F7D(self.objidnum, 1);
  }

  if(self.ownerteam == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -1);
  else
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -1);

  if(isDefined(var_0))
    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);

  if(isDefined(var_0)) {
    if(!scripts\mp\utility\player::isreallyalive(var_0))
      var_0.carryobject.previouscarrier = undefined;

    if(isDefined(var_0.carryflag))
      var_0 detachflag();

    scripts\mp\utility\print::printandsoundoneveryone(var_2, "_encstr_8BBA05185F8B99", undefined, undefined, "_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", "_encstr_B40101", var_0);

    if(level.codcasterenabled)
      var_0 setgametypevip(0);
  } else
    scripts\mp\utility\sound::playsoundonplayers("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", var_2);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("_encstr_8C11138710F0B5436005733F7F08DAE2F87B7A0FC9", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\dialog::leaderdialog("_encstr_BE8F0DE7A1DA2CB7E2D0AF8A028179", self.droppedteam, "_encstr_A16D07532531CB4BF7");
  }

  if(level.idleresettime > 0)
    thread returnaftertime();
}

returnaftertime() {
  self endon("_encstr_9A990A13739E149BF7605DD9");
  var_0 = 0.0;

  while(var_0 < level.idleresettime) {
    waitframe();

    if(self.claimteam == "_encstr_8BBA05185F8B99")
      var_0 = var_0 + level.framedurationseconds;
  }

  foreach(var_2 in level.teamnamelist)
  scripts\mp\utility\sound::playsoundonplayers("_encstr_A76F166B1CF5BBB039F57B89A6568DD196D995F5D8F6E61D", var_2);

  scripts\mp\gameobjects::returnhome();
}

onreset() {
  level.keeprightdooropen.initscriptablemanagement = undefined;

  if(isDefined(level.keeprightdooropen._id_127EB)) {
    level.keeprightdooropen._id_127EB clearportableradar();
    level.keeprightdooropen._id_127EB delete();
  }

  if(isDefined(self.droppedteam))
    scripts\mp\gameobjects::setownerteam(self.droppedteam);

  var_0 = scripts\mp\gameobjects::getownerteam();
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];
  scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  level.key_activate._id_11F89 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("_encstr_8559141F553552F981B9753EB1A93A6A15CBDBBB3BED", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "_encstr_A16D07532531CB4BF7");
    scripts\mp\utility\dialog::leaderdialog("_encstr_8559141F553552F981B9753EB1A93A6A15CBDBBB3BED", self.droppedteam, "_encstr_A16D07532531CB4BF7");
  }

  self.droppedteam = undefined;

  if(self.ownerteam == "_encstr_9A8507BA4040188D08")
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);
  else
    setomnvar("_encstr_9601135D5AAF6C4733F5CC1B0BECEBB0C6365AB2E6", -2);

  self.previouscarrier = undefined;
}

attachflag() {
  _id_13FF9();
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"])[0];
  self attach(level.carryflag[var_0], "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1);
  self.carryflag = level.carryflag[var_0];
}

detachflag() {
  self detach(self.carryflag, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6");
  self.carryflag = undefined;
}

_id_13FFA() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 43);
}

_id_13FF9() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 43);
}

choose_and_drop_tank_near_hostage(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.keeprightdooropen endon("_encstr_88C60846397B83835919");
  level.keeprightdooropen endon("_encstr_88F20627959BCAE8");
  level notify("_encstr_ACAD15F77398C369D82351DF3466044F49F5D820FA48B0");
  level endon("_encstr_ACAD15F77398C369D82351DF3466044F49F5D820FA48B0");

  while(!level.gameended) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      level.keeprightdooropen.carrier scripts\mp\utility\stats::incpersstat("_encstr_ACF5089FF6827199725B", 1);
      level.keeprightdooropen.carrier scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_ACF5089FF6827199725B", level.keeprightdooropen.carrier.pers["_encstr_ACF5089FF6827199725B"]);
      level.keeprightdooropen.carrier scripts\mp\utility\stats::setextrascore0(level.keeprightdooropen.carrier.pers["_encstr_ACF5089FF6827199725B"]);
      level.keeprightdooropen.carrier scripts\mp\gamescore::giveplayerscore("_encstr_A6D20EA3325999EB43BD8D237DDB26A6", 10);
    }
  }
}

player_helis(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.keeprightdooropen endon("_encstr_88C60846397B83835919");
  level.keeprightdooropen endon("_encstr_88F20627959BCAE8");
  level notify("_encstr_8EAC15D957AA909FA3E2B15F1A9347784AA51D6DC91540");
  level endon("_encstr_8EAC15D957AA909FA3E2B15F1A9347784AA51D6DC91540");

  if(isDefined(level.keeprightdooropen._id_127EB)) {
    level.keeprightdooropen._id_127EB clearportableradar();
    level.keeprightdooropen._id_127EB delete();
  }

  if(!isDefined(var_0))
    var_0 = self.team;

  var_1 = relic_vampire(var_0);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.keeprightdooropen.visuals[0].origin);
  var_2.team = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_2.owner = var_1;
  var_2 makeportableradar(var_1);
  level.keeprightdooropen._id_127EB = var_2;
  level.keeprightdooropen thread player_infil_landlord();
  level.keeprightdooropen thread player_infil_lbravo();
}

relic_vampire(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88C60846397B83835919");
  level endon("_encstr_8EAC15D957AA909FA3E2B15F1A9347784AA51D6DC91540");
  var_1 = 0;

  for(;;) {
    if(level.teamswithplayers.size == 1 && game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B")
      var_1 = 1;
    else {
      if(var_1)
        wait 15;

      var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];
      var_1 = 0;

      foreach(var_4 in level.players) {
        if(isalive(var_4) && var_4.pers["_encstr_8AEF05472BC2D6"] == var_2)
          return var_4;
      }
    }

    wait 0.05;
  }
}

player_infil_landlord() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88C60846397B83835919");
  self._id_127EB endon("_encstr_AD75063D571AE108");
  level endon("_encstr_8EAC15D957AA909FA3E2B15F1A9347784AA51D6DC91540");

  for(;;) {
    self._id_127EB moveTo(self.initscriptablemanagement.origin, 0.05);
    wait 0.05;
  }
}

player_infil_lbravo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88C60846397B83835919");
  var_0 = self._id_127EB.team;
  var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  self._id_127EB.owner scripts\engine\utility::_id_143A6("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self._id_127EB clearportableradar();
  self._id_127EB = undefined;
  player_helis(var_0);
}

getrespawndelay() {
  var_0 = level.keeprightdooropen scripts\mp\gameobjects::getownerteam();

  if(isDefined(var_0)) {
    if(self.pers["_encstr_8AEF05472BC2D6"] == var_0) {
      if(!level.spawndelay)
        return undefined;

      if(level.delayplayer)
        return level.spawndelay;
    }
  }
}

onplayerconnect(var_0) {
  thread onplayerspawned(var_0);
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("_encstr_BA350853C128FB939DB9");
    var_0 setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);
    var_0 scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(var_0.pers["_encstr_ACF5089FF6827199725B"]))
      var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_ACF5089FF6827199725B"]);

    var_0 scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(var_0.pers["_encstr_B1F7085B03F492AE98DB"]))
      var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B1F7085B03F492AE98DB"]);
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1 == self) {
    if(isDefined(self.carryflag))
      detachflag();

    return;
  }

  var_10 = level._id_1283A;

  if(isDefined(level.keeprightdooropen) && level.keeprightdooropen scripts\mp\gameobjects::getownerteam() == var_1.pers["_encstr_8AEF05472BC2D6"]) {
    if(isDefined(level.keeprightdooropen.carrier) && var_1 != level.keeprightdooropen.carrier) {
      level.keeprightdooropen.carrier thread scripts\mp\rank::scoreeventpopup("_encstr_84DA0E420F5B2B9AE59866559FD8ABEB");
      var_11 = scripts\mp\rank::getscoreinfovalue("_encstr_84DA0E420F5B2B9AE59866559FD8ABEB");
      scripts\mp\gamescore::giveplayerscore("_encstr_84DA0E420F5B2B9AE59866559FD8ABEB", var_11, self);
      level.keeprightdooropen.carrier thread scripts\mp\rank::giverankxp("_encstr_84DA0E420F5B2B9AE59866559FD8ABEB", var_11);
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_86BD0BC00A85794E23DF8005BB");
      var_11 = scripts\mp\rank::getscoreinfovalue("_encstr_86BD0BC00A85794E23DF8005BB");
      scripts\mp\gamescore::giveplayerscore("_encstr_86BD0BC00A85794E23DF8005BB", var_11, self);
      var_1 thread scripts\mp\rank::giverankxp("_encstr_86BD0BC00A85794E23DF8005BB", var_11);
    }

    var_10 = level._id_1283B;
  } else if(isDefined(self.carryflag))
    var_10 = level._id_12839;

  var_1 scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["_encstr_8AEF05472BC2D6"], var_10);
  var_12 = 0;
  var_13 = var_1.origin;
  var_14 = 0;

  if(isDefined(var_0)) {
    var_13 = var_0.origin;
    var_14 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["_encstr_8AEF05472BC2D6"] != self.pers["_encstr_8AEF05472BC2D6"]) {
    if(isDefined(var_1.carryflag) && var_14) {
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_B4010DC6B0394E2D95C9D7D62DD8B1");
      var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_AB2818EDC8F1EFA1B7C802A9089B2583CEAC618CD33E5BB55BB8");
      var_12 = 1;
    }

    if(isDefined(self.carryflag)) {
      var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_AA5316225A58AD509873B5299F9BE261513606D07368ADFE");
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_A3B80D06F148AA427D2DEF1F6991AB", 1);
      var_1 thread scripts\mp\hud_message::showsplash("_encstr_8F2F0FB5D21B1B5632AFB10BE4E4D2B227");
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
      thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_852F09FA41FB7ADB3968C4");
      scripts\mp\utility\game::setmlgannouncement(20, var_1.team, var_1 getentitynumber());
      var_12 = 1;
    }

    if(!var_12) {
      var_15 = 0;
      var_16 = 0;
      var_17 = distsquaredcheck(var_13, self.origin, level.keeprightdooropen.curorigin);

      if(var_17) {
        if(level.keeprightdooropen.ownerteam == self.team)
          var_15 = 1;
        else
          var_16 = 1;
      }

      if(var_15) {
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_BADE092C37DC5857B1A337", 1);
      } else if(var_16) {
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
        var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
        thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
      }
    }
  }

  if(isDefined(self.carryflag))
    detachflag();
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000)
    return 1;
  else
    return 0;
}

carriergivescore() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  level.keeprightdooropen endon("_encstr_88C60846397B83835919");
  level.keeprightdooropen endon("_encstr_88F20627959BCAE8");

  for(;;) {
    wait(level.carrierbonustime);
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B4E90B1132E5C481D9D935A65E", undefined, level.carrierbonusscore);
  }
}
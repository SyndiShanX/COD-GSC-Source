/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\tac_ops.gsc
***********************************************/

main() {
  if(!isDefined(level.tacopssublevel)) {
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    level.tacopssublevel = "_encstr_A53E0883E976B715503F";
    level.currentmode = "_encstr_A53E0883E976B715503F";
    level.onphaseend = ::onphaseend;
    level.tacopscurrentstate = "_encstr_99AD06F3B5B5D383";
  }

  level.tacopsroundresults = [];
  level.spottedindex = 0;
  level.axisadjuststarttime = 5;

  if(isusingmatchrulesdata())
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  else {
    scripts\mp\utility\game::registerroundswitchdvar("_encstr_A53E0883E976B715503F", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("_encstr_A53E0883E976B715503F", 3);
    scripts\mp\utility\game::registerscorelimitdvar("_encstr_A53E0883E976B715503F", 0);
    scripts\mp\utility\game::registerroundlimitdvar("_encstr_A53E0883E976B715503F", 1);
    scripts\mp\utility\game::registerwinlimitdvar("_encstr_A53E0883E976B715503F", 1);
    scripts\mp\utility\game::registernumlivesdvar("_encstr_A53E0883E976B715503F", 0);
    scripts\mp\utility\game::registerhalftimedvar("_encstr_A53E0883E976B715503F", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("_encstr_A53E0883E976B715503F", 0);
    scripts\mp\utility\game::setovertimelimitdvar(2);
  }

  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.modeonspawnplayer = ::onspawnplayer;
}

commoninit() {
  scripts\mp\tac_ops\radio_utility::initialize_radio();
  onbeginnewmode();
  thread timelimitthread();
  level.allowkillstreaks = 0;
  level.istacops = 1;
  scripts\mp\tac_ops\roles_utility::initroles();
  scripts\mp\tac_ops_map::init();
  initspawns();
}

onphaseend(var_0) {
  var_1 = 1;

  if(isDefined(var_0))
    level.lastwinner = var_0;

  if(isDefined(level.lastwinner))
    var_1 = level.lastwinner == "_encstr_9A8507BA4040188D08";

  level.modeonspawnplayer = ::onspawnplayer;
  level.tacopssubmodetimeron = 0;
  setgameendtime(0);
  level.starttime = gettime();
  level.tacopssublevel = "_encstr_A53E0883E976B715503F";
  level.currentmode = "_encstr_A53E0883E976B715503F";
  level.tacopscurrentstate = statecontroller(level.tacopscurrentstate, var_1);
  level thread runnextmode();
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);
}

playsoundforteam(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_5 in var_3) {
    if(!isbot(var_5))
      var_5 playlocalsound(var_0, var_2);
  }
}

teamprint(var_0, var_1) {
  foreach(var_3 in scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B"))
  var_3 thread tutorialprint(var_0, 5);

  foreach(var_3 in scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B"))
  var_3 thread tutorialprint(var_1, 5);
}

tutorialprint(var_0, var_1) {
  self sethudtutorialmessage(var_0);
  wait(var_1);
  self clearhudtutorialmessage();
}

spawnsandboxa() {
  var_0 = level.sandboxobjectivesa[0][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(5, var_0, "_encstr_9A8507BA4040188D08", 1);
  var_0 = level.sandboxobjectivesa[1][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(1, var_0, "_encstr_9A8507BA4040188D08", 1);
  var_0 = level.sandboxobjectivesa[2][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(3, var_0, "_encstr_9A8507BA4040188D08", 1);
  var_0 = level.sandboxobjectivesa[3][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(6, var_0, "_encstr_9A8507BA4040188D08", 1);
  var_0 = level.sandboxobjectivesa[4][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(2, var_0, "_encstr_9A8507BA4040188D08", 1);
  var_0 = level.sandboxobjectivesa[5][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(4, var_0, "_encstr_9A8507BA4040188D08", 1);
  var_0 = level.sandboxobjectivesa[6][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(1, var_0, "_encstr_8E8405EA382B2A", 1);
  var_0 = level.sandboxobjectivesa[7][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(5, var_0, "_encstr_8E8405EA382B2A", 1);
  var_0 = level.sandboxobjectivesa[8][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(10, var_0, "_encstr_8E8405EA382B2A", 1);
  var_0 = level.sandboxobjectivesa[9][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(9, var_0, "_encstr_8E8405EA382B2A", 1);
  var_0 = level.sandboxobjectivesa[10][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(6, var_0, "_encstr_8E8405EA382B2A", 1);
  var_0 = level.sandboxobjectivesa[11][0].origin;
  scripts\mp\tac_ops\roles_utility::createtacopskitstation(7, var_0, "_encstr_8E8405EA382B2A", 1);
}

runnextmode() {
  onbeginnewmode();

  switch (level.tacopscurrentstate) {
    case "_encstr_99AD06F3B5B5D383":
      wait 5;
      break;
    case "_encstr_A16708A47AAAE488EB4C":
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_8C011AC8C3BEB6C1C4AFD5B998BE831A586ECA987DD237664B36588C", "_encstr_9A8507BA4040188D08");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_BEDA1A3F1B97FA4079C1C78F48F03773513F42F7276F7296C1688BDB", "_encstr_8E8405EA382B2A");
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_A71E1D9C0901A5C336E6229A8999475A10A303E5F3596A4FEC598AD293EEE7", "_encstr_8E8405EA382B2A");
      _encstr_A6221F4F98CBE18B792E55FD97E7B2B170C02BEF988133A681C841B7F5BD8A6B59::maintacops();
      break;
    case "_encstr_8DD90EA22528394D915194EB98D7640A":
      level notify("_encstr_AA840F95BF514190F95FA079EF1EE9930A");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_AD4F1BD810EFFD9275E1E8F308B7A038808E6B3B3E67430B7BA4FD106D", "_encstr_9A8507BA4040188D08");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_9A431723A3F1F323BB6785FE61276BA126BBB022491333388F", "_encstr_9A8507BA4040188D08");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_8DF51B985BE718518A712F2F5652C76308D7D818E64F7037E3E4903CEE", "_encstr_8E8405EA382B2A");
      spawnsandboxa();
      level.tacopscurrentstate = statecontroller(level.tacopscurrentstate, 1);
      level thread runnextmode();
      break;
    case "_encstr_A5D90E459450E4D432A249FAC4D74648":
      level notify("_encstr_AA840F95BF514190F95FA079EF1EE9930A");
      spawnsandboxa();
      teamprint(&"_encstr_AA6023A9944D1AFA3551A64D50D18A9AFAA98297A29E7DA02613B2D78888BEA22788FA8921", &"_encstr_A33E23C13451E7B61547D1D93F778DBFF9ADC748DB4817BDD84FC9C1334C065B5087D8CFA6");
      wait 6;
      teamprint(&"_encstr_816023B5CC79A329715B878F3B0CF0CB71D47A95C7417714D971B7C729A59915419D219ADD", &"_encstr_8F3E2345BF47183949954383D71FADDF97F94B96650FD7C3F3544ED9F49D78EFA3B4201163");
      wait 6;
      teamprint(&"_encstr_B86F24AB79FA318817487F6710E74D79018519F7CC5589FF7BF036EE689F9DA1A930E5AB5F92", &"_encstr_A3DA25D4A46A86BED48A6A6A148E2A9AAF358279A87AF550C2A49AF5429A458EFAA02554AFC424");
      wait 6;
      level.tacopscurrentstate = statecontroller(level.tacopscurrentstate, 0);
      level thread runnextmode();
      break;
    case "_encstr_8250091E67977BB190827A":
      teamprint(&"_encstr_8D2325C03CBE17C949A3636BC371072FC0D4896E2718AFB69989711FDB391AD76E6F1001CFC84E", &"_encstr_97AE25D4924DD0EBA92A4D4D0AD154A6FAA641F215E9F514B029A9AF142994FAA945A029A8AFC4");
      break;
    case "_encstr_8E500992181783A70F3AB0":
      level _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::maintacops();
      level _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::activatespawns();
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_822B173D686FB8F986D15080FA91B150EF0B350FF767E03DAE", "_encstr_9A8507BA4040188D08");
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_88B41A321EEBAD074C7D582E36ADEB07430BCD2BC8AF2D371D27DB13", "_encstr_8E8405EA382B2A");
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_B2F61AD741616A5B819FF70B98EF233B47FBE39AF74272AD8B383981", "_encstr_9A8507BA4040188D08");
      wait 6;
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_881D1A463CAFB63813F5D5CD98EB1CD0C29B56C8D7B4E6E893B72CC8", "_encstr_9A8507BA4040188D08");
      break;
    case "_encstr_833910D93339BCD7083776F8C250874B6117":
      scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("_encstr_A56219C8E1FA5BE026F516178DDAFA0EA12C9B2B467D63DEE6E631", "_encstr_8E8405EA382B2A");
      level notify("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
      teamprint(&"_encstr_9BA62509473335E7801FEE966658AB7F57CF69A29BF74E13B875E3980C314125EF8701714F22C5", &"_encstr_91D725910F8A980F25A7567AE8B79B7F1F816AA03D4819CE2B2B9919793379AFD05918B73F5293");
      wait 6;
      thread scripts\mp\gamelogic::endgame("_encstr_8BBA05185F8B99", 0);
      return;
    case "_encstr_9B3910B50A8805FFD69F1181BA29B63750A6":
      level notify("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
      teamprint(&"_encstr_86A625708C0EA779D933939B53E1B7BF50A419DEB7E81F26E939E18F79990B27F8DD70F03EEE13", &"_encstr_8FD72525A1E99B11249FE30701A5156E4F8031F57B0F7709D98419F728A99F4C6FD751254E8A6B");
      wait 6;
      thread scripts\mp\gamelogic::endgame("_encstr_8BBA05185F8B99", 0);
      return;
    case "_encstr_B14A105125A039A9C85149AF9184D7CC1205":
      level notify("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
      teamprint(&"_encstr_9BA62509473335E7801FEE966658AB7F57CF69A29BF74E13B875E3980C314125EF8701714F22C5", &"_encstr_91D725910F8A980F25A7567AE8B79B7F1F816AA03D4819CE2B2B9919793379AFD05918B73F5293");
      wait 6;
      thread scripts\mp\gamelogic::endgame("_encstr_8BBA05185F8B99", 0);
      return;
    case "_encstr_B44A100CFD51CD2F44C55189C3AEE76AA145":
      level notify("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
      teamprint(&"_encstr_86A625708C0EA779D933939B53E1B7BF50A419DEB7E81F26E939E18F79990B27F8DD70F03EEE13", &"_encstr_8FD72525A1E99B11249FE30701A5156E4F8031F57B0F7709D98419F728A99F4C6FD751254E8A6B");
      wait 6;
      thread scripts\mp\gamelogic::endgame("_encstr_8BBA05185F8B99", 0);
      return;
    case "_encstr_A2EF0A218FE564215152372F":
      teamprint(&"_encstr_85BD23B821CFB61FF4F5031B9FDD3FCAAF69F116715F799F0C49011F8CA4E301190928A9B2", &"_encstr_A73A23A9529AA1EB6A156A9A143A8AA9BEA641CBA87A7DA00B25D4AFAB9A11D705252AEB26");
      wait 6;
      teamprint(&"_encstr_97EE2535A4A61AD7A6A2A64D0A7451A9D735825EA8F4AF501331ACFA756A11D74D2A0A922AFA98", &"_encstr_AF9B258931093B574D98B7B943A09D8E016570EEBB774EBBFB4163E1A72DDD099799378DC9A95A");
      level _encstr_A56020E68D935AE04737F2D6C15E3B2CB5ACA3CB0E959B5EE8DEAFBBB69171B3B936::maintacops();
      level _encstr_A56020E68D935AE04737F2D6C15E3B2CB5ACA3CB0E959B5EE8DEAFBBB69171B3B936::activatespawns();
      break;
    case "_encstr_95EF0AFE4C8FCBDDDF1F9B75":
      teamprint(&"_encstr_9A9223552C994309517BA7AF5B6C90EB51349AB5E7211720399197A74583C82FD17F4721F3", &"_encstr_A2012309F0B2EF86473DD62ED1870D1769185992B9DD9F1D2B29DE20EAE355470211798987");
      wait 6;
      teamprint(&"_encstr_919325A854D68F51E11BCBF32B89EF87784CF1F69F80471E01E1C9F74599E76F86C778A9276036", &"_encstr_B42F25FFACA136CFCD63C15FA01110FE6F1599AEECB7C711FB016270E56CF361A19F3F2539C6AF");
      level _encstr_B61A20B91B395AE0A337976B07BC760BB6CAE8CB1CACCDE53A7BFA98D08C71D937D8::maintacops();
      level _encstr_B61A20B91B395AE0A337976B07BC760BB6CAE8CB1CACCDE53A7BFA98D08C71D937D8::activatespawns();
      break;
    case "_encstr_88EF0A4AE9559C22F59924A0":
      teamprint(&"_encstr_9A9423552C994309517BA7AF5B6C90EB51349AB5E7211720399197A76707582FD17F4721F3", &"_encstr_AC0C23C7314F0BDE7B97C1CF792C15CE711CAA5721FDA1C7E053E7F0E16178098121F7E97F");
      wait 6;
      teamprint(&"_encstr_97BF25A6949AD07D5315D46A0A74A2D4F53514E5A2F4AF8226132BFA3582A97DD42AA02945FA89", &"_encstr_A34D253408D73669DDCD27DF31B771E63FE02FF041CF70C1A0E92FCF0B6E49A8A78985C72937BF");
      level _encstr_817F200B20DD6CF3A39E0F7537E067B63BF88323205BA2D6DB88776347707A7F6F70::maintacops();
      level _encstr_817F200B20DD6CF3A39E0F7537E067B63BF88323205BA2D6DB88776347707A7F6F70::activatespawns();
      break;
    case "_encstr_BDEF0A9AA8BBF05CF6BA233B":
      teamprint(&"_encstr_BEF42595491F567FD1F3E9CA2569B767017951872B67A9FD9165695922CC04695A0FC951BD2F23", &"_encstr_AAE625C930722F4687FD166E91C74D5729D89952799DDF5DEBE91E60AA333491C081112180217B");
      wait 6;
      teamprint(&"_encstr_82C627A70326B8D7E9D5A2BA4D61157198B35BB651402181C91C28B1055151B9F27FEFD3E31659A75A", &"_encstr_92A8272B63837FE14D5DC2B229DF973BD1E9AF48CBFDCFC9C124B9EFCD55919359CF916CD93A3D8182");
      level _encstr_822822E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247680CDFB120AB696B3D4E57D6FE::maintacops();
      level _encstr_822822E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247680CDFB120AB696B3D4E57D6FE::activatespawns();
      break;
    case "_encstr_961804AD9D48":
    case "_encstr_8E6A0C7371BC175B78A92BA2B67E":
    case "_encstr_BE6A0C042BBE9D49035FAB412991":
    case "_encstr_966A0C158CAEE9C1B88F9F850F30":
    case "_encstr_AA6A0CB3E164F17033100A5E7763":
    case "_encstr_836A0C03CC5E13918D68F76F363E":
    case "_encstr_8B6A0CB4B4A88509573986D72D97":
    case "_encstr_BD6A0C3C691B0DB17FC1A24958C6":
    case "_encstr_BE6A0C042BBE9D49035FAB593191":
      thread scripts\mp\gamelogic::endgame("_encstr_8BBA05185F8B99", 0);
      break;
  }
}

onbeginnewmode() {
  level.starttime = gettime();
  level.tacopssubmodetimeron = 0;
  level.pausetacopscounter = 0;
  level.pausetimerecord = 0;
}

sendwinnerresultstoclients() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 3; var_1++) {
    if(isDefined(level.tacopsroundresults[var_1])) {
      if(level.tacopsroundresults[var_1] == "_encstr_8D19048EA595" || level.tacopsroundresults[var_1] == "_encstr_9A8507BA4040188D08") {
        var_0 = var_0 + int(pow(10, var_1) * 1);
        continue;
      }

      var_0 = var_0 + int(pow(10, var_1) * 2);
    }
  }

  setomnvarforallclients("_encstr_8C601357D2F51DB06CAFB707DCD79C959BAB1B8EE6", var_0);
}

roundbreaktest() {
  foreach(var_1 in level.players)
  var_1 thread scripts\mp\utility\game::setuipostgamefade(0.0);

  scripts\mp\utility\player::_visionsetnaked("_encstr_B40101", 0);
  visionsetfadetoblack("_encstr_B40101", 0.75);
  wait 5.0;
  visionsetnaked("_encstr_B40101", 0.75);
}

statecontroller(var_0, var_1) {
  switch (var_0) {
    case "_encstr_99AD06F3B5B5D383":
      var_0 = "_encstr_A16708A47AAAE488EB4C";
      break;
    case "_encstr_A16708A47AAAE488EB4C":
      if(var_1)
        var_0 = "_encstr_8DD90EA22528394D915194EB98D7640A";
      else
        var_0 = "_encstr_961804AD9D48";

      break;
    case "_encstr_8DD90EA22528394D915194EB98D7640A":
      var_0 = "_encstr_8E500992181783A70F3AB0";
      break;
    case "_encstr_A5D90E459450E4D432A249FAC4D74648":
      var_0 = "_encstr_961804AD9D48";
      break;
    case "_encstr_8E500992181783A70F3AB0":
      if(var_1)
        var_0 = "_encstr_833910D93339BCD7083776F8C250874B6117";
      else
        var_0 = "_encstr_961804AD9D48";

      break;
    case "_encstr_8250091E67977BB190827A":
      if(var_1)
        var_0 = "_encstr_B14A105125A039A9C85149AF9184D7CC1205";
      else
        var_0 = "_encstr_B44A100CFD51CD2F44C55189C3AEE76AA145";

      break;
    case "_encstr_833910D93339BCD7083776F8C250874B6117":
      var_0 = "_encstr_A2EF0A218FE564215152372F";
      break;
    case "_encstr_9B3910B50A8805FFD69F1181BA29B63750A6":
      var_0 = "_encstr_95EF0AFE4C8FCBDDDF1F9B75";
      break;
    case "_encstr_B14A105125A039A9C85149AF9184D7CC1205":
      var_0 = "_encstr_95EF0AFE4C8FCBDDDF1F9B75";
      break;
    case "_encstr_B44A100CFD51CD2F44C55189C3AEE76AA145":
      var_0 = "_encstr_BDEF0A9AA8BBF05CF6BA233B";
      break;
    case "_encstr_A2EF0A218FE564215152372F":
      if(var_1)
        var_0 = "_encstr_BE6A0C042BBE9D49035FAB593191";
      else
        var_0 = "_encstr_BD6A0C3C691B0DB17FC1A24958C6";

      break;
    case "_encstr_BDEF0A9AA8BBF05CF6BA233B":
      if(var_1)
        var_0 = "_encstr_BE6A0C042BBE9D49035FAB412991";
      else
        var_0 = "_encstr_8E6A0C7371BC175B78A92BA2B67E";

      break;
    case "_encstr_95EF0AFE4C8FCBDDDF1F9B75":
      if(var_1)
        var_0 = "_encstr_8B6A0CB4B4A88509573986D72D97";
      else
        var_0 = "_encstr_836A0C03CC5E13918D68F76F363E";

      break;
    case "_encstr_88EF0A4AE9559C22F59924A0":
      if(var_1)
        var_0 = "_encstr_AA6A0CB3E164F17033100A5E7763";
      else
        var_0 = "_encstr_966A0C158CAEE9C1B88F9F850F30";

      break;
    case "_encstr_8E6A0C7371BC175B78A92BA2B67E":
    case "_encstr_BE6A0C042BBE9D49035FAB412991":
    case "_encstr_966A0C158CAEE9C1B88F9F850F30":
    case "_encstr_AA6A0CB3E164F17033100A5E7763":
    case "_encstr_836A0C03CC5E13918D68F76F363E":
    case "_encstr_8B6A0CB4B4A88509573986D72D97":
    case "_encstr_BD6A0C3C691B0DB17FC1A24958C6":
    case "_encstr_BE6A0C042BBE9D49035FAB593191":
      var_0 = "_encstr_961804AD9D48";
      break;
  }

  return var_0;
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  scripts\mp\utility\game::setobjectivetext("_encstr_9A8507BA4040188D08", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
  scripts\mp\utility\game::setobjectivetext("_encstr_8E8405EA382B2A", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");
  }

  scripts\mp\utility\game::setobjectivehinttext("_encstr_9A8507BA4040188D08", &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  scripts\mp\utility\game::setobjectivehinttext("_encstr_8E8405EA382B2A", &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1");
  var_1[0] = "_encstr_B60703EACA";
  var_1[1] = "_encstr_844E0C99C3A166200DFE2298E5ED";
  var_1[2] = "_encstr_A65908C41BED1BD62B4E";
  var_1[3] = "_encstr_A7290676E4D2378C";
  var_1[4] = "_encstr_8218041DF5FA";
  var_1[5] = "_encstr_959105B99040BD";
  var_1[6] = "_encstr_A53E0883E976B715503F";
  var_1[7] = "_encstr_BA2013BE09B0528AA5F5778F295DD2B34850F40503";
  scripts\mp\gameobjects::main(var_1);
  commoninit();
  _encstr_A6221F4F98CBE18B792E55FD97E7B2B170C02BEF988133A681C841B7F5BD8A6B59::activatespawns();
  level thread firstphaseend();
  initsandbox();
  spawnsandboxa();
  scripts\mp\tac_ops\roles_utility::enabletacopsstations(level.tacopsstations);
}

initsandbox() {
  var_0 = "_encstr_AF520C4E0B462CE4BE9193F6E656";
  var_1 = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  level.sandboxobjectivesa = [];
  level.sandboxrewarda = [];
  level.sandboxobjectivesa[0] = scripts\engine\utility::getStructArray("_encstr_91CF1053C6D7F95A503C11805963FA5FB191", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[0] = var_0;
  level.sandboxobjectivesa[1] = scripts\engine\utility::getStructArray("_encstr_8ECF1013404F78FF5C8D1B109B3B897B5778", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[1] = var_0;
  level.sandboxobjectivesa[2] = scripts\engine\utility::getStructArray("_encstr_B8CF10F383571F6F6F8BFF2093378C19D94A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[2] = var_1;
  level.sandboxobjectivesa[3] = scripts\engine\utility::getStructArray("_encstr_92CF10C4398069C93515FB037001DA3D67F9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[3] = var_1;
  level.sandboxobjectivesa[4] = scripts\engine\utility::getStructArray("_encstr_BECF105BF78FB931D9E8E7D3D051EFC21F1D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[4] = var_0;
  level.sandboxobjectivesa[5] = scripts\engine\utility::getStructArray("_encstr_BDCF103A85C6BE2C19670B371D0BB32BFA33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[5] = var_1;
  level.sandboxobjectivesa[6] = scripts\engine\utility::getStructArray("_encstr_99CF10AB0870EFEE31ABEE5833775CD7D80B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[6] = var_1;
  level.sandboxobjectivesa[7] = scripts\engine\utility::getStructArray("_encstr_9BCF10A3166CAF8546ECC237A358D9ACFAB4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[7] = var_0;
  level.sandboxobjectivesa[8] = scripts\engine\utility::getStructArray("_encstr_A7CF10D37F1721B951506F4B5829774A9702", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[8] = var_1;
  level.sandboxobjectivesa[9] = scripts\engine\utility::getStructArray("_encstr_ABCF101D16D8F5168C3B0BDC3A859DB2D76D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[9] = var_1;
  level.sandboxobjectivesa[10] = scripts\engine\utility::getStructArray("_encstr_93CF10F179CEE9BF9B63D138AB6764E069DC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[10] = var_1;
  level.sandboxobjectivesa[11] = scripts\engine\utility::getStructArray("_encstr_A1CF101DC2367D2C32CE0B37A32CB3B2F5AD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.sandboxrewarda[11] = var_1;
}

firstphaseend() {
  if(level.prematchperiod > 0)
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  else
    wait 15;

  onphaseend(level.lastwinner);
}

onspawnplayer() {
  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.isplanting = 0;
  self.isdefusing = 0;
}

onplayerconnect(var_0) {
  var_0 setclientomnvar("_encstr_997811BA96FAA11C7D1B2C36C6DEAEE87DB491", 2);
  var_0.isscoring = 0;
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);
  var_0 thread monitorjointeam();
}

monitorjointeam() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_81170C244F9CBDE72C01BB99A298");
    scripts\mp\supers::clearsuper();
    scripts\mp\tac_ops\roles_utility::latejointeamkitobjective();
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A11904A822A6");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  var_0 = spawnStruct();
  level.tacopsspawns = var_0;
  _encstr_8B8C20620ECB6110B19B7D50A8BD894B2193E352886B93878B5FD9C150A590CFF397::initspawns();
  _encstr_B61A20B91B395AE0A337976B07BC760BB6CAE8CB1CACCDE53A7BFA98D08C71D937D8::initspawns();
  _encstr_822822E6867B8B5B24873A50F307F1D3D2AFDD6BDAE247680CDFB120AB696B3D4E57D6FE::initspawns();
  _encstr_A6221F4F98CBE18B792E55FD97E7B2B170C02BEF988133A681C841B7F5BD8A6B59::initspawns();
  _encstr_BE7D21F241B8412325FFAEBFE1609A81B869ABF89BA803AE7DEF67A30FF5C2B64033E6::initspawns();
  _encstr_817F200B20DD6CF3A39E0F7537E067B63BF88323205BA2D6DB88776347707A7F6F70::initspawns();
  _encstr_A56020E68D935AE04737F2D6C15E3B2CB5ACA3CB0E959B5EE8DEAFBBB69171B3B936::initspawns();
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  scripts\mp\tac_ops_map::setupspawnareas();
}

onsuicidedeath(var_0) {}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_0.switching_teams))
    var_0 scripts\mp\playerlogic::decrementalivecount(var_0.team);
}

timelimitthread() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = gettacopstimepassedms();

  for(;;) {
    thread checktacopstimelimit(var_0);
    var_0 = gettacopstimepassedms();

    if(isDefined(level.starttime)) {
      if(gettacopstimeremainingms() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

extendtacopstimelimitms(var_0) {
  level.basetacopstimelimit = gettacopstimelimitms() + var_0;
}

reducetacopstimelimitms(var_0) {
  level.basetacopstimelimit = gettacopstimelimitms() - var_0;
}

checktacopstimelimit(var_0) {
  var_1 = gettacopstimeremainingms();
  setgameendtime(gettime() + int(var_1));

  if(level.tacopssubmodetimeron == 0) {
    setgameendtime(0);
    return;
  }

  if(var_1 > 0) {
    return;
  }
  setgameendtime(0);
  [[level.ontimelimit]]();
}

gettacopstimepassedms() {
  if(isDefined(level.pausetacopstime))
    return level.pausetacopstime;

  return gettime() - level.starttime;
}

gettacopstimelimitms() {
  if(!isDefined(level.basetacopstimelimit))
    level.basetacopstimelimit = scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9") * 60 * 1000;

  return level.basetacopstimelimit;
}

gettacopstimeextensionsms() {
  return level.basetacopstimelimit - scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9") * 60 * 1000 + level.pausetimerecord;
}

gettacopstimeremainingms() {
  return gettacopstimelimitms() - gettacopstimepassedms();
}

pausetacopstimer() {
  if(level.pausetacopscounter == 0) {
    level.pausetacopstime = gettacopstimepassedms();
    level.pausetacopstimestarted = gettime();
  }

  level.pausetacopscounter++;
}

resumetacopstimer() {
  level.pausetacopscounter--;

  if(level.pausetacopscounter < 0)
    level.pausetacopscounter = 0;

  if(level.pausetacopscounter == 0) {
    if(!isDefined(level.pausetacopstime))
      level.pausetacopstime = 0;

    if(!isDefined(level.pausetacopstimestarted))
      level.pausetacopstimestarted = 0;

    level.starttime = gettime() - level.pausetacopstime;

    if(!isDefined(level.pausetimerecord))
      level.pausetimerecord = 0;

    level.pausetimerecord = level.pausetimerecord + (gettime() - level.pausetacopstimestarted);
    level.pausetacopstime = undefined;
    level.pausetacopstimestarted = undefined;
  }
}

tacopslongwaitsec(var_0) {
  var_1 = gettacopstimeremainingms() / 1000 - var_0;
  wait(var_1);
  var_2 = gettacopstimeextensionsms() / 1000;
  wait(var_2);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\hq.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = "_encstr_8CE606A1C5D8EDD8";
  var_0[1] = "_encstr_B67B0A1A2C279107DBB49BA3";
  var_0[2] = "_encstr_A11904E823B6";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.hpstarttime = 0;
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.modeonsuicidedeath = ::onsuicidedeath;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.modeonteamchangedeath = ::modeonteamchangedeath;
  level.get_br_jugg_setting = ::get_br_jugg_setting;
  level.lastcaptime = gettime();
  level.usehqrules = 1;
  level.usezonecapture = 1;
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", 0);
  setomnvar("_encstr_86491063E151C0C7078283A80A9B7D10764D", -1);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A5960CD1662D687DDB9393DFCB63";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_A51D092B32E0531B97C033";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A51D092B32E0531B97C033";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A51D092B32E0531B97C033";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32"] = "_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96150D4AF18ABF1EC031AC950DD8E7"] = "_encstr_96150D4AF18ABF1EC031AC950DD8E7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_962909991059C7F8721301"] = "_encstr_86BF09D88B496D8863C38D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_929E0A295071C2484B8BFEBA"] = "_encstr_A2B20A0D8BBE0B8D8E969DAC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA8D10032AC1ED815F5F786887617B3B2A55"] = "_encstr_BAE810630AA18DE13F3F5848A7419BDB0A75";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1341202FF59E78993406BB05124317D280B40A2"] = "_encstr_AC591202083FA6FF7B551D12E5C13F6FF530DA6B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86CF15588B077A4350BBADB2A2F1D7952A64D2BAFD3992"] = "_encstr_A7B015E9FFC98E483853FB133F1481B4B3077B1D43224B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C5E0D34E0BEB1DBCD1D59373A2B23"] = "_encstr_86130D58EB714FD7382B95DB5BAAD1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2D90D0DE07DB6BDD956D7DCB7EDB9"] = "_encstr_ABEB0DC2C8FF6587FB9D7753A0E0BB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DF313F87BE7D973ABBB25AED462B78605EB6858C7"] = "_encstr_A67B139A33B0AF7EA8D94D329B208717C548C2729A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8FAD16C8485FB69008A3CB7B2F38CFF06F434BED08E06968"] = "_encstr_88BF0CF09BE95F9DD0C3F8349D71";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEA908F878DF5BD8332D"] = "_encstr_A9D308D3170E9430DA3B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B680BA3FA2023205D9AA8CDEB"] = "_encstr_BEF90B7167519DE0DDEF506BD3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1C0144383BECD56B1AB9CAC32EB66E4A5B27319D8CB"] = "_encstr_8CD90B0B4B0893C5803B12DFF1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95010ED0E0F5DEBBCD2B327D63DEB9E8"] = "_encstr_83440C6C91D7D9D77BD336F887A4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC9B13200B91103B23F1D051328E5C914138BFC247"] = "_encstr_B1C613DB818F792B221218708ABDFFD6DF36D5C1F1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC1516D05941A7677EE1F21AC8D867D120C559258D406D6F"] = "_encstr_8AD716A4E2367F987687AB80BB55341FBA9BE33AEE7181FB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CEB0809A801F07D4F82"] = "_encstr_849108E2E8DF47CF797D";
  thread writeplayerrotationscoretomatchdataongameend();
  level._effect["_encstr_B2EC0B02083F279B7B590704E5"] = loadfx("_encstr_B4EF2B7B6DA36EF1288A51257B120742F1F39FA7C14516A688AA596C73B94AFAD36F230797750B6728780BF74A");
  level.nosuspensemusic = 1;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_BEA313A8BF42C6F933C92AB89DAA59C8B55FC0AB4B", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_88760C3297381703E3F0329ADB45"));
  setdynamicdvar("_encstr_8BEF1423AA300E7A8B4FE877153D49E318F1C1D08539", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_86550DFA1D220B34D12B80A33FFD29"));
  setdynamicdvar("_encstr_AD531760D6C2CF9453E120EF5097AEB083CB0B156F7108BA6A", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59"));
  setdynamicdvar("_encstr_BED6207E1EE37FB0C9CF98E853E30BCD9AC5FD9FF65BDB3B811BF8E03B2CE1E902A8", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_87E51966D293CD1D2DDEDCCA82361D4BD9C2A3A5DEB922598DC2E5"));
  setdynamicdvar("_encstr_92F21BCD8DE4EBA18BFAE9B7732B50B13A4BB32C4796F6CD4495C62CBC", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5"));
  setdynamicdvar("_encstr_BAA01ACDB19CBE0D17D7D3BDB9AC4D2BB156C6A3D2DEB91156D858F2", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_B2CF13BDA03A59CB4D441BDEFB98B7AD7BED4DC07A"));
  setdynamicdvar("_encstr_8AEA1B371BE4F5A18BAFE4B0CD197BDA26BD360B8EA5DE737A4E8C564E", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB"));
  setdynamicdvar("_encstr_8DCE175E8B230621AA0908285244C1189B35F6DEEF5B886517", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_829C10A99FECC0B502436B0F3F4AFE988E37"));
  setdynamicdvar("_encstr_9B0A11CD1BC9D743B8BE1C85EACDCA454B5B95", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_83FE0A484FBDAB0BF9EC1915"));
  setdynamicdvar("_encstr_B8B9139BC6E4EB0DE2FA19B2D8852FA0C6B05EAC27", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_A9210CA017EC518B7175D7E30F6B"));
  setdynamicdvar("_encstr_9AD012721E5541D093391F1FF0ECA0D9E3217FEA", getmatchrulesdata("_encstr_8F100743E2110B8EB0", "_encstr_B8160B55DE49F0DF153B43D3DF"));
  setdynamicdvar("_encstr_96AE107B4E73E601B28E29210BD863209F8D", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_8E07030349", 0);
}

onstartgametype() {
  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_933F0E9879FD376FD7F3060D96D00B4A");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_933F0E9879FD376FD7F3060D96D00B4A");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8655146056604BD5EC971989D7BF8CDB998AEE98BA48");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_A59F13F4212954D0A84A2B519ACB122AFA4294C915");
  }

  if(level.scoremod["_encstr_ABD70578F3D02C"] > 0) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  level thread setupzones();
  player_give_chopper();
  level thread setupzoneareabrushes();
  initspawns();
  seticonnames();

  if(!level.zonerandomlocationorder)
    _id_12BBC();

  level thread hqmainloop();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.zonetimeout = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_88760C3297381703E3F0329ADB45", 60, 0, 300);
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86550DFA1D220B34D12B80A33FFD29", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_87E51966D293CD1D2DDEDCCA82361D4BD9C2A3A5DEB922598DC2E5", 30, 0, 120);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5", 30, 0, 120);
  level.zoneselectiondelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B2CF13BDA03A59CB4D441BDEFB98B7AD7BED4DC07A", 15, 0, 120);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("_encstr_829C10A99FECC0B502436B0F3F4AFE988E37", 0, 0, 1);
  level._id_1221A = scripts\mp\utility\dvars::dvarintvalue("_encstr_83FE0A484FBDAB0BF9EC1915", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9210CA017EC518B7175D7E30F6B", 0, 0, 1);
  level.usehprules = scripts\mp\utility\dvars::dvarintvalue("_encstr_B8160B55DE49F0DF153B43D3DF", 0, 0, 1);
}

hqmainloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
  setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", -1);
  level.zone = getfirstzone();
  var_0 = 1;
  level.kothhillrotation = 0;
  level.zone.visuals[0] scriptmodelplayanim("_encstr_A90A1F71F7DAC9971FC6E2AAC8FB8B3EE073CFC853390E234F9B7AB131412F72E0");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_9AA40B86A51B8DF5ADBDB3958C", level.zone.trigger.origin);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(level._id_1221A)
    level scripts\mp\gamelogic::pausetimer();

  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);
  var_1 = 0;

  if(level.firstzoneactivationdelay) {
    level thread waitthenshowfirsthqsplash();
    var_1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 1);
    level thread waitthenplaynewobj();
    level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_1199E(level.firstzoneactivationdelay, level.zone.visuals[0].origin + (0, 0, 70));
    wait(level.firstzoneactivationdelay);
    scripts\mp\utility\game::setmlgannouncement(7, "_encstr_BD78059C33C543");
  }

  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);
  scripts\mp\utility\sound::playsoundonplayers("_encstr_A63B13DA38BE1A8BEB0B36E84BCE58E8B2BE37661E");

  for(;;) {
    if(!isDefined(level._id_11AD5))
      level thread setupzonecallouts();

    level.objectivesetorder = 1;
    waittillframeend;

    if(!var_1) {
      foreach(var_3 in level.players)
      scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var_3);
    }

    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled)
      level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::trackgametypevips();

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var_1, var_0);
    var_0 = 0;
    var_1 = 0;
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 2);
    scripts\mp\spawnlogic::clearlastteamspawns();
    level.zone.visuals[0] scriptmodelplayanim("_encstr_B6781E5AEE837DD61CAF5B4B63B4E8C24E2FBE0DB8FAD8272C4756EBED38ACCD");
    level.zone.visuals[0] playLoopSound("_encstr_AA511C22AB81A14442DFA9CB4F8F037B08B789483780A1FC41BFD0F1332B");
    hpcaptureloop();
    var_5 = level.zone scripts\mp\gameobjects::getownerteam();
    setomnvar("_encstr_86491063E151C0C7078283A80A9B7D10764D", 0);
    level.spectateoverride[game["_encstr_991C0AB9ED5B57161FE89B83"]].allowenemyspectate = 0;
    level.spectateoverride[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].allowenemyspectate = 0;

    if(level.usehprules) {
      if(level._id_1221A)
        level scripts\mp\gamelogic::resumetimer();
    }

    level.lastcaptureteam = undefined;
    level.zone killhardpointvfx();
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(var_3 in level.players)
      level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hideplayerspecificbrushes(var_3);
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    level.zone scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    updateservericons("_encstr_83270B204F9E4157D3C463FCDB", 0);
    level notify("_encstr_9B740BDBEF187A77B0B1CA578B");
    level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::deactivatezone();
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 5);
    var_8 = int(gettime() + level.zoneselectiondelay * 1000 + 500);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", var_8);

    if(!level.usehprules) {
      if(level.zoneselectiondelay > 0) {
        if(level._id_1221A)
          level scripts\mp\gamelogic::pausetimer();

        scripts\mp\spawnlogic::setactivespawnlogic("_encstr_96E506037261A9B4", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
        level.usetdmspawns = 1;
      }

      thread forcespawnplayers();

      if(level.zoneselectiondelay >= 10)
        thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hp_move_soon(level.zoneselectiondelay);

      wait(level.zoneselectiondelay);

      if(!istrue(level.binoculars_clearuidata)) {
        scripts\mp\spawnlogic::deactivatespawnset("_encstr_820E07FAE8780B3A4C");
        level.usetdmspawns = undefined;
        scripts\mp\spawnlogic::setactivespawnlogic("_encstr_B67B0A122C279107DBB49BA3", "_encstr_829A0D0F1AF8FB5ED127855073F940");
      }
    }

    spawn_next_zone();
    wait 0.5;
  }
}

waitthenplaynewobj() {
  if(istrue(level.infilvotiming))
    wait 8.5;
  else
    wait 6.0;

  foreach(var_1 in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("_encstr_962909991059C7F8721301", var_1);
}

waitthenshowfirsthqsplash() {
  if(istrue(level.infilvotiming))
    wait 6.5;
  else
    wait 5.5;

  level thread scripts\mp\hud_message::notifyteam("_encstr_82DA0B4BD97139D853A7F1838D", "_encstr_82DA0B4BD97139D853A7F1838D", "_encstr_9A8507BA4040188D08");
}

killhardpointvfx() {
  foreach(var_1 in level.players) {
    foreach(var_3 in var_1._hardpointeffect) {
      var_1._hardpointeffect = scripts\engine\utility::array_remove(var_1._hardpointeffect, var_3);

      if(isDefined(var_3))
        var_3 delete();
    }
  }

  if(isDefined(self.neutralhardpointfx) && self.neutralhardpointfx.size > 0) {
    foreach(var_3 in self.neutralhardpointfx)
    var_3 delete();
  }

  self.neutralhardpointfx = [];
}

_id_12BBC() {
  switch (level.mapname) {
    case "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0":
    case "_encstr_86570E71DA311191DB1FD8887FCFA9A3":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_AC4C024A", "_encstr_A14C023B", "_encstr_8B4C0227", "_encstr_864C02F9"];
      break;
    case "_encstr_AB5D0960CBB77E40E7D955":
    case "_encstr_8E940C29F87032C3FF82F50F725A":
      level._id_12BBE = ["_encstr_B84C027E", "_encstr_AC4C024A", "_encstr_A14C023B", "_encstr_A74C0222", "_encstr_8F4C026A"];
      break;
    case "_encstr_BDFF088922C9FF1946BF":
    case "_encstr_99020BB0027F38974BA78783FF":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_B84C027E", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A"];
      break;
    case "_encstr_BA4D0DED61799A1FB5DB6AD2E30753":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_8B4C0227", "_encstr_AC4C024A", "_encstr_B84C027E", "_encstr_A74C0222"];
      break;
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      level._id_12BBE = ["_encstr_8C0703491D", "_encstr_9A07034C89", "_encstr_A14C023B", "_encstr_A34C02BB", "_encstr_A74C0222"];
      break;
    case "_encstr_A3890850E25F90B79A83":
      level._id_12BBE = ["_encstr_990703B2F9", "_encstr_A74C0222", "_encstr_864C02F9", "_encstr_8B4C0227", "_encstr_B84C027E"];
      break;
    case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_B84C027E", "_encstr_914C02DC", "_encstr_A14C023B", "_encstr_864C02F9"];
      break;
    default:
      break;
  }
}

getfirstzone() {
  if(isDefined(level._id_12BBE)) {
    var_0 = level.objectives[level._id_12BBE[0]];
    level.prevzoneindex = 0;
  } else {
    var_0 = level.objectives["_encstr_A34C02BB"];
    level.prevzoneindex = 1;
  }

  return var_0;
}

getnextzone() {
  if(level.zonerandomlocationorder) {
    var_0 = [];

    foreach(var_2 in level.teamnamelist)
    var_0[var_2] = (0, 0, 0);

    var_4 = scripts\mp\utility\game::getpotentiallivingplayers();

    foreach(var_6 in var_4) {
      if(var_6.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        continue;
      }
      var_0[var_6.team] = var_0[var_6.team] + var_6.origin;
    }

    var_8 = [];

    foreach(var_2 in level.teamnamelist) {
      var_10 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");
      var_11 = max(var_10.size, 1);
      var_8[var_2] = var_0[var_2] / var_11;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1)
      level.prevzonelist = [];

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    var_13 = 0.7;
    var_14 = 0.3;
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_18 in level.objectives) {
      var_19 = 0;

      foreach(var_21 in level.prevzonelist) {
        if(var_18.objectivekey == scripts\engine\utility::string(var_21)) {
          var_19 = 1;
          break;
        }
      }

      if(var_19) {
        continue;
      }
      var_23 = var_18;
      var_24 = 0;

      foreach(var_2 in level.teamnamelist)
      var_24 = var_24 + distance2dsquared(var_23.curorigin, var_8[var_2]);

      var_27 = distance2dsquared(var_23.curorigin, level.zone.curorigin);
      var_28 = var_24 * var_13 + var_27 * var_14;

      if(!isDefined(var_16) || var_28 > var_16) {
        var_16 = var_28;
        var_15 = var_18.objectivekey;
      }
    }

    var_23 = level.objectives[var_15];
    level.prevzoneindex = var_15;
  } else if(isDefined(level._id_12BBE)) {
    level.prevzoneindex++;

    if(level.prevzoneindex > level._id_12BBE.size - 1)
      level.prevzoneindex = 0;

    var_23 = level.objectives[level._id_12BBE[level.prevzoneindex]];
  } else {
    level.prevzoneindex++;

    if(level.prevzoneindex > level.objectives.size)
      level.prevzoneindex = 1;

    var_23 = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
  }

  return var_23;
}

spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone resetzone();
  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0)
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  else
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_9AA40B86A51B8DF5ADBDB3958C", level.zone.trigger.origin);
}

resetzone() {
  self.lastclaimteam = "_encstr_8BBA05185F8B99";
  self.lastprogressteam = "_encstr_8BBA05185F8B99";
  self.ownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
  self.prevownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
  self.curprogress = 0;
  var_0 = getarraykeys(self.teamprogress);

  foreach(var_2 in var_0)
  self.teamprogress[var_2] = 0;

  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

hqactivatenextzone(var_0, var_1) {
  if(!var_1) {
    foreach(var_3 in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("_encstr_AA8D10032AC1ED815F5F786887617B3B2A55", var_3);
  }

  scripts\mp\utility\sound::playsoundonplayers("_encstr_A63B13DA38BE1A8BEB0B36E84BCE58E8B2BE37661E");
  thread scripts\mp\music_and_dialog::headquarters_newhq_music();
  level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  if(istrue(var_0)) {} else if(level.zoneactivationdelay) {
    level thread scripts\mp\hud_message::notifyteam("_encstr_82DA0B4BD97139D853A7F1838D", "_encstr_82DA0B4BD97139D853A7F1838D", "_encstr_9A8507BA4040188D08");
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 1);

    if(level._id_1221A)
      level scripts\mp\gamelogic::pausetimer();

    level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_1199E(level.zoneactivationdelay, level.zone.visuals[0].origin + (0, 0, 70));
    wait(level.zoneactivationdelay);
    scripts\mp\utility\game::setmlgannouncement(7, "_encstr_BD78059C33C543");
  }

  foreach(var_3 in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("_encstr_929E0A295071C2484B8BFEBA", var_3);

  level thread scripts\mp\hud_message::notifyteam("_encstr_96B80B0D8BEBC6C2831DBA3959", "_encstr_96B80B0D8BEBC6C2831DBA3959", "_encstr_9A8507BA4040188D08");

  if(level._id_1221A)
    level scripts\mp\gamelogic::resumetimer();

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(level.zoneduration) {
    updateservericons("_encstr_A7A408B9CA5D1D4E2C63", 0);

    if(level.zonetimeout == 0 && !level.usehprules)
      thread locktimeruntilcap();
    else {
      var_7 = scripts\engine\utility::ter_op(level.usehprules, level.zoneduration, level.zonetimeout);
      thread movezoneaftertime(var_7);
      level.zoneendtime = int(gettime() + 1000 * var_7);
      setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    }
  } else
    level.zonedestroyedbytimer = 0;
}

locktimeruntilcap() {
  level endon("_encstr_86C30E225D088A98370A61DBF31607CC");

  for(;;) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    waitframe();
  }
}

hpcaptureloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level.hpstarttime = gettime();

  for(;;) {
    level.zone scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    level.zone scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    level.zone scripts\mp\gameobjects::setusetext(&"_encstr_838E1511A2461705EBF709D9B3C79EC9A89A9B054CF865");

    if(level.usehprules) {
      level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hardpoint_setneutral();
      level.zone scripts\mp\gameobjects::cancontestclaim(1);
    }

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime)
      level thread _encstr_A9631EE6B1939638D1B9F2B6C1973B85B6AC3AF283ACE65EEC4EDC2371CEDCD8::randomdrops();

    var_0 = level scripts\engine\utility::_id_143AD("_encstr_86C30E225D088A98370A61DBF31607CC", "_encstr_A29C0FA77BE659D74656B9479CDBE52B91");

    if(var_0 == "_encstr_A29C0FA77BE659D74656B9479CDBE52B91")
      continue;
    else if(!level.usehprules) {
      level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
      setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
      setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 3);
    }

    var_1 = level.zone scripts\mp\gameobjects::getownerteam();
    thread updaterespawntimer();

    if(!level.usehprules && level.zoneduration > 0)
      thread movezoneaftertime(level.zoneduration);

    if(!level.usehprules && level.zonecapturetime > 0) {
      var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");
      level thread scripts\mp\hud_message::notifyteam("_encstr_86280C0D6AEFDB473BA8E03B45E9", "_encstr_8ACE0B630AA199E13B93A848CF", var_1, var_2);
    }

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1, 17, 29);
    scripts\mp\utility\game::setmlgannouncement(8, var_1);
    level waittill("_encstr_A29C0FA77BE659D74656B9479CDBE52B91", var_3);
    scripts\mp\utility\game::setmlgannouncement(9, "_encstr_BD78059C33C543");

    if(!level.usehprules && level.zonecapturetime > 0)
      level thread scripts\mp\hud_message::notifyteam("_encstr_A7B30DE9FFC90D683B531BB0381558", "_encstr_A7B30DE9FFC90D683B531BB0381558", "_encstr_9A8507BA4040188D08");

    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 16, 16);
    level.spawndelay = undefined;

    if(isDefined(var_3))
      level.zone scripts\mp\gameobjects::setownerteam(var_3);
    else
      level.zone scripts\mp\gameobjects::setownerteam("_encstr_8BBA05185F8B99");

    if(!level.usehprules) {
      setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
      setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", -1);
      break;
    }
  }
}

updaterespawntimer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level endon("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
  var_0 = gettime();

  if(level.zoneduration > 0)
    var_1 = var_0 + level.zoneduration * 1000;
  else
    var_1 = var_0 + scripts\mp\utility\game::gettimelimit() * 1000 - scripts\mp\utility\game::gettimepassed();

  var_2 = var_0;

  while(var_2 < var_1) {
    var_2 = gettime();
    level.spawndelay = (var_1 - var_2) / 1000 + 0.1;
    waitframe();
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_ABC218DA077D5BDB1DD0AFB90EC2DD9BF59B56B1B7CD8CC2C9BC", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_ABC218DA077D5BDB1DD0AFB90EC2DD9BF59B56B1B7CD8CC2C9BC", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_97BF0EB607FADABD1DA1D76E8316BB9B");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ABC218DA077D5BDB1DD0AFB90EC2DD9BF59B56B1B7CD8CC2C9BC");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_2);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_3);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.binoculars_clearuidata)) {
    return;
  }
  foreach(var_5 in level.objectives) {
    var_5.furthestspawndistsq = 0;
    var_5.spawnpoints = [];
    var_5.fallbackspawnpoints = [];
  }

  foreach(var_8 in level.spawnpoints) {
    var_9 = scripts\mp\spawnlogic::getoriginidentifierstring(var_8);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[var_9])) {
      foreach(var_11 in level.kothextraprimaryspawnpoints[var_9]) {
        var_5 = level.objectives[var_11];
        var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
      }
    }

    var_13 = 0;
    var_14 = var_8.classname == "_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B" || var_8.classname == "_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B";
    var_15 = var_8.classname == "_encstr_97BF0EB607FADABD1DA1D76E8316BB9B";
    var_16 = var_8.classname == "_encstr_ABC218DA077D5BDB1DD0AFB90EC2DD9BF59B56B1B7CD8CC2C9BC";
    var_17 = var_8.classname == "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
    var_18 = var_8.classname == "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318";
    var_19 = [];

    if(var_14) {
      continue;
    }
    if(var_15 || var_16) {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy != "_encstr_B40101") {
        var_13 = 1;
        var_19 = strtok(var_8.script_noteworthy, "_encstr_974C0246");

        foreach(var_11 in var_19) {
          if(var_11 == "_encstr_8A1804CF18C5" || var_11 == "_encstr_B27706C1CF833659") {
            continue;
          }
          if(!postshipmodifiedzones(var_11)) {
            var_5 = level.objectives[var_11];

            if(var_15) {
              var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
              continue;
            }

            var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
          }
        }
      }
    }

    calculatespawndisttozones(var_8, var_19);

    if(!var_13 && !var_17 && !var_18) {
      foreach(var_5 in level.objectives) {
        if(var_15) {
          var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
          continue;
        }

        var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
      }
    }
  }

  foreach(var_26, var_5 in level.objectives) {
    var_5.spawnset = "_encstr_839F069FEF15AA77" + var_26;
    scripts\mp\spawnlogic::registerspawnset(var_5.spawnset, var_5.spawnpoints);
    var_5.fallbackspawnset = "_encstr_83FC0F9077BCC87FDAEE999106824F102F" + var_26;
    scripts\mp\spawnlogic::registerspawnset(var_5.fallbackspawnset, var_5.fallbackspawnpoints);
  }
}

calculatespawndisttozones(var_0, var_1) {
  var_2 = 0;
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_4 in level.objectives) {
    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_B40101")
      var_2 = 1;
    else {
      foreach(var_6 in var_1) {
        if(var_6 == var_4.trigger.objectivekey) {
          var_2 = 1;
          break;
        }
      }
    }

    if(!var_2) {
      continue;
    }
    var_8 = getpathdist(var_0.origin, var_4.trigger.origin, 5000);

    if(var_8 < 0)
      var_8 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_4.trigger.origin);
    else
      var_8 = var_8 * var_8;

    var_0.scriptdata.distsqtokothzones[var_4.trigger getentitynumber()] = var_8;

    if(var_8 > var_4.furthestspawndistsq)
      var_4.furthestspawndistsq = var_8;
  }
}

comparezoneindexes(var_0, var_1) {
  var_2 = int(var_0.objectivekey);
  var_3 = int(var_1.objectivekey);

  if(!isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(!isDefined(var_2) && isDefined(var_3))
    return 1;

  if(isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(var_2 > var_3)
    return 1;

  return 0;
}

getzonearray(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3.objectivekey = var_3.script_label;

  if(!isDefined(var_1) || var_1.size == 0)
    return undefined;

  var_5 = 1;

  for(var_6 = var_1.size; var_5; var_6--) {
    var_5 = 0;

    for(var_7 = 0; var_7 < var_6 - 1; var_7++) {
      if(comparezoneindexes(var_1[var_7], var_1[var_7 + 1])) {
        var_8 = var_1[var_7];
        var_1[var_7] = var_1[var_7 + 1];
        var_1[var_7 + 1] = var_8;
        var_5 = 1;
      }
    }
  }

  return var_1;
}

setupzones() {
  var_0 = getzonearray("_encstr_8E4A0FABC16B29497522C86039483F206F");
  var_0 = player_give_loadout(var_0);
  var_1 = [];
  var_2 = 0;
  var_3 = getEntArray("_encstr_8CE606A1C5D8EDD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = [];

  if(var_0.size != var_3.size) {
    var_1[var_1.size] = "_encstr_821D410873FAED89529A68388290C339221EA78ECEC2A3B03BB210707BF0B85B5B4707A8A43A517E0AF750D052DC3383522F75AEBA36C383FDE258886BA0E9EB9BD679";
    var_2 = 1;

    foreach(var_6 in var_0) {
      var_7 = 0;

      foreach(var_9 in var_3) {
        if(var_9 istouching(var_6)) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7)
        var_1[var_1.size] = "_encstr_B22711309BC847A3D040923B6EB2273D98B5F0" + var_6.script_label + "_encstr_B6431ED2E3B1885A70E7E7446F7BA5FEC9B25F913F1D294B456AA3416A7E9795";
    }
  }

  level.objectives = [];

  for(var_12 = 0; var_12 < var_3.size; var_12++) {
    var_9 = var_3[var_12];
    var_6 = undefined;

    for(var_13 = 0; var_13 < var_0.size; var_13++) {
      if(var_9 istouching(var_0[var_13])) {
        if(isDefined(var_6)) {
          var_1[var_1.size] = "_encstr_8D760A82D77704C85637F389" + var_9.origin + "_encstr_B13D3428DB9006C3A0B312AA1808D75E08AFF2F5E110DC5FD801EAD2E1770A84B03D9C68E710E57368A2E2DAC99E3AFB809317C71B90";
          var_2 = 1;
          break;
        }

        var_6 = var_0[var_13];
        break;
      }
    }

    if(!isDefined(var_6)) {
      if(!var_2) {
        var_1[var_1.size] = "_encstr_8D760A82D77704C85637F389" + var_9.origin + "_encstr_BE8C2C7623FB8FD552E0E0CC8543D802C2B272D3388E766092A0C0702DDAD51B89BBF8405092C973C0A0FFE7D7D5";
        var_2 = 1;
        continue;
      }
    }

    var_4 = [];
    var_4[0] = var_9;
    var_14 = getEntArray(var_9.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(var_15 = 0; var_15 < var_14.size; var_15++)
      var_4[var_4.size] = var_14[var_15];

    var_16 = _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setupobjective(var_6, var_4);
    level.objectives[var_16.objectivekey] = var_16;
  }

  if(var_1.size > 0) {
    for(var_12 = 0; var_12 < var_1.size; var_12++) {}
  } else {
    var_17 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
    var_18 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
    level.startpos["_encstr_9A8507BA4040188D08"] = var_18[0].origin;
    level.startpos["_encstr_8E8405EA382B2A"] = var_17[0].origin;
  }
}

player_give_loadout(var_0) {
  var_1 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");

  if(var_1 == "_encstr_8B390FDD8B79ED89C6AFA3DB95FB125408") {
    foreach(var_3 in var_0) {
      var_3.origin = var_3.origin - (0, 0, 9);

      if(isDefined(var_3.script_label) && var_3.script_label == "_encstr_A74C0222") {
        var_3.origin = var_3.origin - (0, 0, 9);
        continue;
      }

      if(isDefined(var_3.script_label) && var_3.script_label == "_encstr_A14C023B")
        var_3.origin = var_3.origin - (0, 0, 9);
    }
  }

  return var_0;
}

player_give_chopper(var_0) {
  var_1 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");

  if(var_1 == "_encstr_96040A5B1CAF0D163926ED9C") {
    level.objectives["_encstr_B84C027E"].visuals[0].origin = level.objectives["_encstr_B84C027E"].visuals[0].origin - (0, 0, 8);
    level.objectives["_encstr_B84C027E"].visuals[1].origin = level.objectives["_encstr_B84C027E"].visuals[1].origin - (0, 0, 8);
  }
}

setupzoneareabrushes() {
  level.neutralzonebrushes = [];
  level.contestedzonebrushes = [];
  level.friendlyzonebrushes = [];
  level.enemyzonebrushes = [];
  var_0 = getzonearray("_encstr_B16316A1F75345F8EFDC401B49D2C8889AA7052BC74B9F20");
  var_1 = getzonearray("_encstr_BE9B1EF1A70315A85F6CF0CB992218582AF7757B779B6F9057C6D8807BE59B8D");
  var_2 = getzonearray("_encstr_99C51DE44FE54278E058A3F3D17A2FAA93C8EBDC2E43AABC0EC8DB8F68901C");
  var_3 = getzonearray("_encstr_B6D41C52D835D70B280BD6C408D22F1DB3913BDAA0C34EB30665AECD395A");

  if(!isDefined(var_0))
    level.usehpzonebrushes = 0;
  else
    level.usehpzonebrushes = 1;

  if(istrue(level.usehpzonebrushes)) {
    foreach(var_5 in var_0) {
      level.neutralzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_1) {
      level.contestedzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_2) {
      level.friendlyzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_3) {
      level.enemyzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    postshipmodifiedzonebrushes();
    thread matchbrushestozones();
  }
}

postshipmodifiedzonebrushes() {
  if(level.mapname == "_encstr_824D0B772110BBD920C07DC3DB") {
    for(var_0 = 0; var_0 < level.neutralzonebrushes.size; var_0++) {
      if(level.neutralzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.neutralzonebrushes[var_0] hide();
        var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_1 setModel("_encstr_8FBB1EDA03A0D34E88F74745DDB954DF5EF9836288801B09C0D14F57B5918A66");
        var_1.angles = (0, 0, 0);
        var_1.script_label = "_encstr_A34C02BB";
        level.neutralzonebrushes[var_0] = var_1;
      }
    }

    for(var_0 = 0; var_0 < level.contestedzonebrushes.size; var_0++) {
      if(level.contestedzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.contestedzonebrushes[var_0] hide();
        var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_2 setModel("_encstr_871D266B837D07B04E5BED5D27FA34C29CC883DB96733AD7CC1BDEDEE4F56089F56CB7E64756CD1D");
        var_2.angles = (0, 0, 0);
        var_2.script_label = "_encstr_A34C02BB";
        level.contestedzonebrushes[var_0] = var_2;
      }
    }

    for(var_0 = 0; var_0 < level.friendlyzonebrushes.size; var_0++) {
      if(level.friendlyzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.friendlyzonebrushes[var_0] hide();
        var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_3 setModel("_encstr_950A25ADE0BEC1B093DAB7ABC9D70DC2E44638DBA59BD1AF9936BDBD277D0389FA66E45AACE619");
        var_3.angles = (0, 0, 0);
        var_3.script_label = "_encstr_A34C02BB";
        level.friendlyzonebrushes[var_0] = var_3;
      }
    }

    for(var_0 = 0; var_0 < level.enemyzonebrushes.size; var_0++) {
      if(level.enemyzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.enemyzonebrushes[var_0] hide();
        var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_4 setModel("_encstr_8252248119BF839806E757F308E1695976E15A672350FC07A6630760A267B78A583DE3A988EA");
        var_4.angles = (0, 0, 0);
        var_4.script_label = "_encstr_A34C02BB";
        level.enemyzonebrushes[var_0] = var_4;
      }
    }
  }
}

matchbrushestozones() {
  foreach(var_1 in level.objectives) {
    var_1.neutralbrush = level.neutralzonebrushes[var_1.objectivekey];
    var_1.enemybrush = level.enemyzonebrushes[var_1.objectivekey];
    var_1.contestedbrush = level.contestedzonebrushes[var_1.objectivekey];
    var_1.friendlybrush = level.friendlyzonebrushes[var_1.objectivekey];
  }
}

setupzonecallouts() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.zone.visuals[0];

  foreach(var_5 in level.calloutglobals.areatriggers) {
    var_1 = ispointinvolume(var_3.baseorigin, var_5);
    var_2 = isDefined(var_3.script_noteworthy) && isDefined(var_5.script_noteworthy) && var_3.script_noteworthy == var_5.script_noteworthy;

    if(var_1 || var_2) {
      var_0 = level.calloutglobals.areaidmap[var_5.script_noteworthy];

      foreach(var_7 in level.players) {
        if(isDefined(var_0))
          var_7 setclientomnvar("_encstr_997811BA96FAA11C7D1B2C36C6DEAEE87DB491", var_0);
      }

      break;
    }
  }

  scripts\mp\utility\game::setmlgannouncement(6, "_encstr_BD78059C33C543");
}

forcespawnplayers() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || istrue(var_2.fauxdead) && var_2 scripts\mp\utility\player::isusingremote() || isalive(var_2) && !istrue(var_2.fauxdead)) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var_2);
    var_2 notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
    waitframe();
  }

  thread _id_14394();
}

_id_14394() {
  wait 3;
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 scripts\mp\utility\player::isinkillcam()) {
      var_2 thread _id_14373();
      continue;
    } else if(!isDefined(var_2) || istrue(var_2.fauxdead) && var_2 scripts\mp\utility\player::isusingremote() || isalive(var_2) && !istrue(var_2.fauxdead)) {
      continue;
    }
    scripts\mp\objidpoolmanager::objective_unpin_player(level.zone.objidnum, var_2);
    var_2 notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
    waitframe();
  }
}

_id_14373() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_BA350853C128FB939DB9");

  while(scripts\mp\utility\player::isinkillcam())
    wait 0.1;

  wait 1;
  self notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = getkothzonedeadzonedist();
  var_2 = [];
  var_2["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239"] = level.zone.trigger getentitynumber();
  var_2["_encstr_AC921AF7627031A3C02F53A7A46D886BA324607C1E2B45B62B6B3B4A"] = level.zone.furthestspawndistsq;
  var_2["_encstr_A1F117DA7BD18669F6CD5922B28523A7B7E65944D2DCD14DE2"] = var_1 * var_1;
  var_2["_encstr_B6421CDFE1BF8870FE8B55C53F7F20EB55B7D9B30F5DAF5311ECAE61092A"] = 12250000;

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
    }
  } else if(istrue(level.usetdmspawns)) {
    scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C", 1);
    var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
  } else
    var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.zone.spawnset, level.zone.fallbackspawnset, "_encstr_8F1904CA1729", var_2);

  return var_3;
}

getkothzonedeadzonedist() {
  if(!istrue(level.zone.active))
    return 2000;
  else
    return 1000;
}

onspawnplayer() {
  self setclientomnvar("_encstr_A92D10AB43477A71EE78AFD308434852BF68", 0);

  if(isDefined(level.zone) && isDefined(level.zone.ownerteam) && level.zone.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
    setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", scripts\mp\utility\teams::getteamdata(level.zone.ownerteam, "_encstr_8A2A0B936CCCC3078547970A8B"));

  self.forcespawnnearteammates = undefined;
  self.skipspawncamera = undefined;
  thread updatematchstatushintonspawn();
}

movezoneaftertime(var_0) {
  level notify("_encstr_8D8A0FF83329E3FBD875FB20D7CF407D83");
  level endon("_encstr_8D8A0FF83329E3FBD875FB20D7CF407D83");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B740BDBEF187A77B0B1CA578B");
  level endon("_encstr_A6940FED853B0E2535D3E028F988FFE0AF");
  level.zonemovetime = var_0;
  level.zonedestroyedbytimer = 0;
  _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::zonetimerwait();
  level.zonedestroyedbytimer = 1;

  foreach(var_2 in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("_encstr_8B680BA3FA2023205D9AA8CDEB", var_2);

  scripts\mp\utility\game::setmlgannouncement(9, "_encstr_BD78059C33C543");
  level notify("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level notify("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
}

onsuicidedeath(var_0) {
  setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_8A2A0B936CCCC3078547970A8B"));
}

modeonteamchangedeath(var_0) {
  setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", scripts\mp\utility\teams::getteamdata(var_0.leaving_team, "_encstr_8A2A0B936CCCC3078547970A8B"));
}

get_br_jugg_setting(var_0) {
  var_1 = level.zone.ownerteam == var_0.team;
  return !var_1;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level.zone.ownerteam;

  if(!isPlayer(var_1) || var_1.team == self.team) {
    if(var_10 != "_encstr_A7A408B9CA5D1D4E2C63")
      self.skipspawncamera = 1;

    return;
  }

  if(var_1 == self) {
    return;
  }
  if(!isDefined(level.zone)) {
    return;
  }
  var_10 = level.zone.ownerteam;

  if(!isDefined(var_10)) {
    return;
  }
  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }
  var_11 = self;
  var_12 = 0;
  var_13 = var_1.team;

  if(var_10 != "_encstr_A7A408B9CA5D1D4E2C63")
    level updatehqaliveomnvars(var_10);

  if(var_10 == var_11.team)
    var_11.skipspawncamera = 1;

  if(level.zone.active) {
    if(level.zonecapturetime > 0 && var_1 istouching(level.zone.trigger)) {
      if(var_10 != var_13)
        var_12 = 1;
    }

    if(var_13 != var_10) {
      if(var_12)
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");
      else if(var_11 istouching(level.zone.trigger)) {
        var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
        var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
      }
    } else if(var_1 istouching(level.zone.trigger)) {
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
      var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
    }
  }

  thread checkallowspectating();
}

checkallowspectating() {
  if(level.zone.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
    return;
  }
  if(!scripts\mp\utility\teams::getteamdata(level.zone.ownerteam, "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[level.zone.ownerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
  }
}

updatehqaliveomnvars(var_0) {
  setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", scripts\mp\utility\teams::getteamdata(var_0, "_encstr_8A2A0B936CCCC3078547970A8B"));
}

give_capture_credit(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.lastcaptime = gettime();
  var_6 = var_4;

  if(isDefined(var_6.owner))
    var_6 = var_6.owner;

  if(isPlayer(var_6)) {
    if(!isscoreboosting(var_6)) {
      var_6 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_6.origin);
      var_6 thread scripts\mp\rank::scoreeventpopup("_encstr_A7B10AE9FFC986682B131BF1");
      var_6 thread scripts\mp\awards::givemidmatchaward("_encstr_B2A70FEDC8F1EFA1A1E8916B788F63FB89");

      if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100)
        var_6 thread scripts\mp\awards::givemidmatchaward("_encstr_97D91205E8A9323760F0074720B8C31A07768EFA");

      if(var_6.lastkilltime + 500 > gettime()) {} else
        var_6 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setcrankedtimerzonecap(var_6);
    }
  }

  var_7 = getarraykeys(var_0);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_0[var_7[var_8]].player;
    var_9 updatecapsperminute(var_3);

    if(!isscoreboosting(var_9)) {
      var_9 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
      var_9 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_9.pers["_encstr_81CF0936850ED1D54EACCD"]);
      var_9 scripts\mp\utility\stats::setextrascore0(var_9.pers["_encstr_81CF0936850ED1D54EACCD"]);
    } else {}

    wait 0.05;
  }

  if(isDefined(var_5.assisttouchlist)) {
    if(var_5.assisttouchlist[var_2].size > 0) {
      var_10 = getarraykeys(var_5.assisttouchlist[var_2]);

      foreach(var_12 in var_7) {
        foreach(var_14 in var_10) {
          if(var_14 == var_12)
            var_5.assisttouchlist[var_2][var_14] = undefined;
        }
      }
    }

    if(var_5.assisttouchlist[var_2].size > 0)
      var_5 thread scriptedagentmodifieddamage(var_2);
  }
}

scriptedagentmodifieddamage(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = getarraykeys(self.assisttouchlist[var_0]);

  if(var_1.size > 0) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = self.assisttouchlist[var_0][var_1[var_2]].player;

      if(isDefined(var_3.owner))
        var_3 = var_3.owner;

      if(!isPlayer(var_3)) {
        continue;
      }
      var_3 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
      var_3 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_3.pers["_encstr_81CF0936850ED1D54EACCD"]);
      var_3 scripts\mp\utility\stats::setextrascore0(var_3.pers["_encstr_81CF0936850ED1D54EACCD"]);
      var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_96E10F4E1293111B5BCF794043AB0C0FFB");
      var_3 thread scripts\mp\awards::givemidmatchaward("_encstr_A57E172DC0B12ADF09F027E73801DB93356D39A6B6C7A23BD3");
      var_3 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setcrankedtimerzonecap(var_3);
      self.assisttouchlist[var_0][var_1[var_2]] = undefined;
      wait 0.05;
    }
  }
}

awardcapturepoints() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B740BDBEF187A77B0B1CA578B");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level notify("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  level endon("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    var_2 = 0.0;

    while(var_2 < var_0) {
      wait(level.framedurationseconds);
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + level.framedurationseconds;

      if(level.usehprules) {
        if(level.zone.stalemate)
          var_2 = 0.0;
      }
    }

    var_3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
      continue;
    }
    if(!level.usehprules) {
      if(level.zoneadditivescoring)
        var_1 = level.zone.touchlist[var_3].size;

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);

      if(!istrue(level._id_12F0E))
        binoculars_cleanupheadiconondisconnect(var_3);

      continue;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring)
        var_1 = level.zone.touchlist[var_3].size;

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);
    }
  }
}

binoculars_cleanupheadiconondisconnect(var_0) {
  if(!level._id_1221A) {
    return;
  }
  var_1 = scripts\mp\gamescore::_getteamscore(var_0);
  var_2 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var_0)[0]);

  if(var_1 > var_2) {
    level._id_12F0E = 1;
    level scripts\mp\gamelogic::resumetimer();
  } else
    level scripts\mp\gamelogic::pausetimer();
}

updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "_encstr_A7A408B9CA5D1D4E2C63") {
    return;
  }
  self.numcaps++;
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["_encstr_BE7D0633C08849E2"]))
    var_1 = self.timeplayed["_encstr_BE7D0633C08849E2"] / 60;

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps)
    self.capsperminute = self.numcaps;
}

isscoreboosting(var_0) {
  if(var_0.capsperminute > 3)
    return 1;

  return 0;
}

onplayerconnect(var_0) {
  var_0 setclientomnvar("_encstr_A92D10AB43477A71EE78AFD308434852BF68", 0);
  var_0._hardpointeffect = [];
  var_0.numcaps = 0;
  var_0.capsperminute = 0;
  var_0.timebyrotation = [];
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_81CF0936850ED1D54EACCD"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_81CF0936850ED1D54EACCD"]);

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["_encstr_B1F7085B03F492AE98DB"]))
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B1F7085B03F492AE98DB"]);

  thread onplayerspawned(var_0);

  foreach(var_2 in level.objectives) {
    if(istrue(level.usehpzonebrushes))
      var_2 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hideplayerspecificbrushes(var_0);
  }

  var_0 thread refreshfreecamhardpointfx();
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("_encstr_BA350853C128FB939DB9");

    foreach(var_2 in level.objectives) {
      if(istrue(var_2.active)) {
        if(var_2.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
          var_2 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::playhardpointneutralfx();
          continue;
        }

        var_2 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::showcapturedhardpointeffecttoplayer(var_2.ownerteam, var_0);
      }
    }
  }
}

gethqownerteamvalue(var_0) {
  if(var_0 == "_encstr_9A8507BA4040188D08")
    var_1 = 2;
  else if(var_0 == "_encstr_8E8405EA382B2A")
    var_1 = 1;
  else
    var_1 = 0;

  return var_1;
}

updateservericons(var_0, var_1) {
  var_2 = -1;

  if(var_1)
    var_2 = -2;
  else if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
    var_3 = thread getownerteamplayer(var_0);

    if(isDefined(var_3))
      var_2 = var_3 getentitynumber();
  } else {
    switch (var_0) {
      case "_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E":
        var_2 = -3;
        break;
      case "_encstr_83270B204F9E4157D3C463FCDB":
      default:
        break;
    }
  }

  setomnvar("_encstr_95E80DAE5ABEA11693190EB79637A3", var_2);
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

refreshfreecamhardpointfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_A9B710B6B1767D675ACADDFAC60DC23776CA") {
      foreach(var_3 in level.objectives) {
        if(var_3.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
          var_3 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::showcapturedhardpointeffecttoplayer(var_3.ownerteam, self);
      }
    }
  }
}

getrespawndelay() {
  if(!level.delayplayer)
    return undefined;

  var_0 = level.zone.ownerteam;

  if(isDefined(var_0)) {
    if(self.pers["_encstr_8AEF05472BC2D6"] == var_0) {
      if(!level.spawndelay)
        return undefined;

      return level.spawndelay;
    }
  }
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.zone)) {
    if(isDefined(level.zone.ownerteam)) {
      if(level.zone.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63")
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 16);
      else if(level.zone.ownerteam == self.team)
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 17);
      else
        self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 29);
    }
  }
}

showrespawnwarningmessage() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self setclientomnvar("_encstr_A92D10AB43477A71EE78AFD308434852BF68", 1);
  wait 5;
  self setclientomnvar("_encstr_A92D10AB43477A71EE78AFD308434852BF68", 0);
}

postshipmodifiedzones(var_0) {
  if(level.mapname == "_encstr_B2860A4A938957DBAB1DED3D" && var_0 == "_encstr_B84C027E")
    return 1;

  return 0;
}

seticonnames() {
  level.icontarget = "_encstr_971A0AEB3F31A3A8A8E7B278";
  level.iconneutral = "_encstr_9BB60B3B0F2F0592DB69CBB0CB";
  level.iconcapture = "_encstr_8ACE0B630AA199E13B93A848CF";
  level.icondefend = "_encstr_9A9F0A40CBE1F1936C357A44";
  level.iconcontested = "_encstr_86130D58EB714FD7382B95DB5BAAD1";
  level.icontaking = "_encstr_95560ABBE1EF1B5B4432D888";
  level.iconlosing = "_encstr_BECE0A5CFFF78A3F3B10DBF7";
  level.icondefending = "_encstr_A25F0D7023E1F191DB2D786509D399";
}

writeplayerrotationscoretomatchdataongameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  writecurrentrotationteamscore();
}

writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("_encstr_BE7D1176A0484172A6BDAFDFDDC5D983A88BEF", level.kothhillrotation, getteamscore("_encstr_9A8507BA4040188D08"));
    setmatchdata("_encstr_A56F0FEBCBBA96A1576388C18203104ED2", level.kothhillrotation, getteamscore("_encstr_8E8405EA382B2A"));
  }
}
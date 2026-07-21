/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_prop.gsc
***********************************************/

init() {
  level._id_12315 = spawnStruct();
  level._id_12315.settings = spawnStruct();
  level._id_12315.settings._id_128F2 = getdvarint("_encstr_BE9616C7AF03883842E1330B9528995BEA1B53176B5A69D8", 30);
  level._id_12315.settings._id_12924 = getdvarint("_encstr_81171962435ADFFB3A01AB7B427059CF584C0F335A07EF0B606B67", 30);
  level._id_12315.settings._id_128DB = getdvarint("_encstr_88CD1817F6AD17C1ADD72F5E075B49A89B19B77E3201A5CF9D1F", 2);
  level._id_12315.settings._id_12904 = getdvarint("_encstr_99C417224EE5F16A43E9DBEB503B1FAAB3D1A11FA16B3AB58B", 1);
  level._id_12315.settings._id_12903 = getdvarint("_encstr_91C21768C26A47B1CB57372E4FEBDE9D138A91604A456D6917", 3);
  level._id_12315.settings._id_12914 = getdvarfloat("_encstr_A51018932672F9362B6FF9C5973390D0283FD90941DBA07F226F", 1.4);
  level._id_12315.settings._id_11C86 = getdvarint("_encstr_8EC0115F57B679EA10966AF288D80F9280E18F", 0);
  level._id_12315.settings._id_11F3D = getdvarint("_encstr_936814B9B193AF319CD7C14EB7E07DA157E63A2B93E6", 20);
  level._id_12315.settings._id_11F42 = getdvarint("_encstr_8B8219CD3639FA989CFAC14EB707EB9BD55BFA1CAC39F52CC9AC0B", 30);

  if(level._id_12315.settings._id_11C86 == 1) {
    scripts\mp\utility\game::registerroundswitchdvar(level.gametype, 1, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(level.gametype, 4);
    scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
    scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 4);
    scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 3);
    scripts\mp\utility\game::registernumlivesdvar(level.gametype, 1);
    scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
    level.objectivebased = 1;
    level.getintermissionspawnpointoverride = ::_id_12316;
    level.remaining_enemies_aggro = ::remapattachmentparentname;
    level.playoverwatch_dialogue_with_endon = ::playoverwatch_dialogue_with_endon;
  }

  level.updatex1prematchloadoutarray = 1;
  level.allowlatecomers = 1;
  level.checkforlaststandfinish = 1;
  level.custom_death_sound = ::_id_1245E;
  level.loadoutdrop = ::loadoutdefaultperkdiscount;
  level.getrandompointincirclenearby = ::getrandompointincirclenearby;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_841310FF4D098B1FA62BD8A2107583806833", ::onstartgametype);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A3511399F56AFBE9595B700BE79DA369C29D0714CF", ::gamemodemodifyplayerdamage);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BE94109AA047C32EB04BFAD347D0352F765B", ::onplayerconnect);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_ADBB1538C49859E5C29B60B8A33047CAA3AF31F1D38BE8", ::_id_1269C);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8D88182BD14E87A83A8F9B4851792F8B7EDFADF8B74180D7707D", ::_id_1263D);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::_id_12604);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_99FE10EF999079CA14F3AB53D14F638D48A3", ::remove_on_death);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A549125D02CF7BE7E581E8980BFF55355FB9DDC3", ::droponplayerdeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA32084FFD08358F1C99");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_AB23109F838B7B7448013FC5BBA84402D013");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A7B606DA83796F4A");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A3380CCF6327ABEBEC818BC88F5B");
  level._id_12315._id_11975 = [];
  level._id_12315._id_128F7 = [];
  level._id_12315.armor_nag = ["_encstr_88A9065F05D67961", "_encstr_A59506C0242F4887"];
  level thread _id_1217C();
  level thread toggleusbstickinhand();
  level.teammaxfill = 0;
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
}

toggleusbstickinhand() {
  waittillframeend;
  level.onsuicidedeath = ::onsuicidedeath;
  level.onnormaldeath = ::onnormaldeath;
  level.onspawnplayer = ::onspawnplayer;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.ondeadevent = ::ondeadevent;
  level.bypassclasschoicefunc = ::_id_12321;
  level.onplayerjointeam = ::onplayerjointeam;
  scripts\mp\tweakables::settweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712", 0);
  scripts\mp\tweakables::settweakablelastvalue("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712", 0);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  scripts\mp\rank::registerscoreinfo("_encstr_9A8B0CCDD1D2C61BAF2CB14B3BCA", "_encstr_BA94069D16D8ABAC", 50);
  scripts\mp\rank::registerscoreinfo("_encstr_99B7194BD17025F3E86192CAABDD07DDB869D9B50B196EB7289B7B", "_encstr_BA94069D16D8ABAC", 50);
  scripts\mp\rank::registerscoreinfo("_encstr_8E65183720BF316977C2CBE8C33581B98BFA9FE569208F20AD87", "_encstr_BA94069D16D8ABAC", 100);
  scripts\mp\rank::registerscoreinfo("_encstr_88051ED2834064C2503B434F0D6539A5702B0ADE9E63311B94DB876B1798C30B", "_encstr_BA94069D16D8ABAC", 150);
  scripts\mp\rank::registerscoreinfo("_encstr_840D106CD8B7DC2BFA19CAE61DC9DEF2B2C8", "_encstr_BA94069D16D8ABAC", 50);
  scripts\mp\rank::registerscoreinfo("_encstr_9B8F14A60DE2CDA157DFF0689784792FFB322833272A", "_encstr_BA94069D16D8ABAC", 10);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AC0B0F6F0BE08018A55A0779C481E8C95A", ::vehicle_occupancy_mp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_BA110E075B45433181E1982091C8AB68", ::vehicle_occupancy_mp_onexitvehicle);
  _id_127E9();
  toma_strike();
}

_id_1217C() {
  while(!isDefined(game["_encstr_813F06832D8A18FE"]) || !isDefined(game["_encstr_813F06832D8A18FE"]["_encstr_B62312B008A02E7917D01BB53C48490FCB354885"]))
    waitframe();

  game["_encstr_813F06832D8A18FE"]["_encstr_B62312B008A02E7917D01BB53C48490FCB354885"] = "_encstr_AB110F1C39DE83F58DEDBACD8E23EDEE37";
}

onplayerconnect(var_0) {
  if(!isDefined(var_0.pers["_encstr_8F020CE09CDB8335B21BDBE62337"]))
    var_0.pers["_encstr_8F020CE09CDB8335B21BDBE62337"] = 0;
}

onstartgametype() {
  if(level._id_12315.settings._id_11C86 == 1) {
    if([[level.getintermissionspawnpointoverride]]()) {
      game["_encstr_A16D07532531CB4BF7"] = "_encstr_8B6D0940CC35339149DA08";
      setDvar("_encstr_8ADD0CABA5AFEDECB2271D2DB6AC", 1);
      setDvar("_encstr_AFE312DEB32B4EE8D25BCAA2966B95C45AAD5A1D", 3.5);
    }

    if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
      game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

    if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
      var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
      var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
      game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
      game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
    } else
      level.prematchperiod = 30;
  }

  setspecialloadouts();
  setclientnamemode("_encstr_8B070EAD85CDEA0B8D7D1B4316E63B2B");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_AAEB1761388CAB4D7B791C9D1B2F57F9BD903101A0164F454B");
  scripts\mp\utility\game::setobjectivetext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_AC8417EFC19C9DE849437BA756B71168C8195F4341B4D4F01D");
  scripts\mp\utility\game::setobjectivescoretext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_B15B1DEF25F1F7A7859CD990A778A3FC828B4C7CBB518C67AE7681F80CD60F");
  scripts\mp\utility\game::setobjectivescoretext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_BE9C1D5066507B85BCC769F9879FBF396E9FDD4C0FA8B18D428779D18FCAD5");
  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_991C0AB9ED5B57161FE89B83"], &"_encstr_95041C9E84A48A1A8A4A2B159ABE28905E288AA25068B4A294FA24A49C45");
  scripts\mp\utility\game::setobjectivehinttext(game["_encstr_B6A70A23CA6659DC91CAE4DC"], &"_encstr_AA5F1CDFAEC49F5629311138F9E75A63D0055D4E552CC3EF0D69F8F03999");

  if(level._id_12315.settings._id_11C86 == 1) {
    var_2 = game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % 4 == 2 || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] % 4 == 3;

    if(var_2) {
      game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];
      game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];
    } else {}
  }

  level._effect["_encstr_ABC70A074EDB8364D8C2B9A1"] = loadfx("_encstr_832F2D3B9B739AEE755BED97B993A8BB527B43AAF86F9803DE0B4A28C6D6D5F081F3406ABC0F1506277E6055DE23D5");
  level._effect["_encstr_9B580CE039B707115985D1A18C2C"] = loadfx("_encstr_A14E30A3F7080AC30B62D77F0FB297C2978FEAFB1D77528E92EF73430FEB557A56A75296C7B86031DA2FBF794F63A9300AFF");

  if(!isDefined(game["_encstr_889A0A0E27B71C9A6CF6932B"])) {
    game["_encstr_889A0A0E27B71C9A6CF6932B"] = [];
    game["_encstr_889A0A0E27B71C9A6CF6932B"]["_encstr_9A8507BA4040188D08"] = 0;
    game["_encstr_889A0A0E27B71C9A6CF6932B"]["_encstr_8E8405EA382B2A"] = 0;
  }

  if(!isDefined(game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"])) {
    game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"] = [];
    game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"]["_encstr_9A8507BA4040188D08"] = 0;
    game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"]["_encstr_8E8405EA382B2A"] = 0;
  }

  if(!isDefined(game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"])) {
    game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"] = [];
    game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"]["_encstr_9A8507BA4040188D08"] = 0;
    game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"]["_encstr_8E8405EA382B2A"] = 0;
  }

  scripts\mp\flags::gameflaginit("_encstr_91FA1038C9BD83B9F543A523ACFADB3B564E", 0);
  scripts\mp\flags::gameflaginit("_encstr_96831103CA05F13FAFB89252C5B9B0CB77F315", 0);
  level thread _id_13269();
  level thread _id_12913();
  level thread _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::spawn_carried_punchcard_if_player_down();
  level thread _id_11D20();
  level thread last_spawned_time();
  level thread _id_13198();
  level thread _id_138A9();
  level thread _id_13C62();
  level thread _id_1386D();
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_128ED(var_1.pers["_encstr_8AEF05472BC2D6"]);

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060" && game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1.team] > game["_encstr_96040B1D59B0AD35B1F64E599B"][level.otherteam[var_1.team]])
    var_1.finalkill = 1;
}

onsuicidedeath(var_0) {
  if(var_0 scripts\mp\playerlogic::mayspawn()) {
    return;
  }
  var_1 = scripts\mp\utility\game::getotherteam(var_0.pers["_encstr_8AEF05472BC2D6"]);

  foreach(var_3 in var_1)
  _id_128ED(var_3);
}

_id_128ED(var_0) {
  if(var_0 != game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    return;
  }
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0, 1, 1);
  game["_encstr_889A0A0E27B71C9A6CF6932B"][var_0] = game["_encstr_889A0A0E27B71C9A6CF6932B"][var_0] + 1;
}

remapattachmentparentname(var_0, var_1) {
  if(!isstring(var_0))
    return var_0;

  var_2 = var_0;

  if(level.gameended) {
    var_3 = "_encstr_B81B0A39EDABE69137D5BDCD";

    if(isDefined(level._id_145C0) && level._id_145C0)
      var_3 = "_encstr_96040B1D59B0AD35B1F64E599B";

    level._id_12916 = "_encstr_8BBA05185F8B99";

    if(game[var_3]["_encstr_9A8507BA4040188D08"] == game[var_3]["_encstr_8E8405EA382B2A"]) {
      level._id_12916 = "_encstr_8E8D0697EB01F243";

      if(game["_encstr_889A0A0E27B71C9A6CF6932B"]["_encstr_8E8405EA382B2A"] == game["_encstr_889A0A0E27B71C9A6CF6932B"]["_encstr_9A8507BA4040188D08"]) {
        level._id_12916 = "_encstr_84EF055338A18F";

        if(game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"]["_encstr_8E8405EA382B2A"] == game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"]["_encstr_9A8507BA4040188D08"]) {
          level._id_12916 = "_encstr_8D19048EA595";
          var_2 = "_encstr_8D19048EA595";
        } else if(game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"]["_encstr_8E8405EA382B2A"] < game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"]["_encstr_9A8507BA4040188D08"])
          var_2 = "_encstr_8E8405EA382B2A";
        else
          var_2 = "_encstr_9A8507BA4040188D08";
      } else if(game["_encstr_889A0A0E27B71C9A6CF6932B"]["_encstr_8E8405EA382B2A"] > game["_encstr_889A0A0E27B71C9A6CF6932B"]["_encstr_9A8507BA4040188D08"])
        var_2 = "_encstr_8E8405EA382B2A";
      else
        var_2 = "_encstr_9A8507BA4040188D08";

      if(var_2 != "_encstr_8D19048EA595")
        level thread scriptgoalyaw(var_2);
    } else if(game[var_3]["_encstr_8E8405EA382B2A"] > game[var_3]["_encstr_9A8507BA4040188D08"])
      var_2 = "_encstr_8E8405EA382B2A";
    else
      var_2 = "_encstr_9A8507BA4040188D08";
  }

  if(var_1 && (var_2 == "_encstr_9A8507BA4040188D08" || var_2 == "_encstr_8E8405EA382B2A"))
    _id_12319(var_2);

  return var_2;
}

relic_squadlink_modifyplayerdamage() {
  var_0 = [];
  var_0["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
  var_0["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_0["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1";
  var_0["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_AC9C0FEA0FF30A29692883BF99A00D4249"];
  var_0["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  return var_0;
}

setspecialloadouts() {
  var_0 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
  level._id_12318[var_0] = relic_squadlink_modifyplayerdamage();
  var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
  level._id_12318[var_1] = relic_squadlink_modifyplayerdamage();
  level._id_12318[var_1]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6";
  level._id_12318[var_1]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8E5F063CDA2C3BCD";
  level._id_12318[var_1]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_91EC068D0B372B93";
  level._id_12318[var_1]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_9106102387E011DF472978E0722F376ADAB9";
  level._id_12318[var_1]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E";
  level._id_12318[var_1]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F", "_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B"];
}

_id_12321() {
  self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level._id_12318[self.pers["_encstr_8AEF05472BC2D6"]];
  self.class = self.pers["_encstr_959506B911C79707"];
  self.lastclass = self.pers["_encstr_92690A5B078ED325F539E25E"];
  return self.class;
}

_id_12913() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\spectating::updatespectatesettings();
}

_id_145B9(var_0) {
  level notify("_encstr_96F31E2CF03FF349BDFA492083963D6B8F74BBA9558BBEAD27E2E0B03AACCDC1");
  var_1 = int(var_0);

  if(var_1 >= 0)
    thread _id_145BA(var_1);
}

_id_145BA(var_0) {
  level endon("_encstr_96F31E2CF03FF349BDFA492083963D6B8F74BBA9558BBEAD27E2E0B03AACCDC1");
  waittillframeend;

  while(var_0 > 0 && !level.gameended) {
    setomnvar("_encstr_8A1A18FBE017BA03762CF8E1C6FBDB07EF58C27360E9F7672B98", var_0);
    var_0--;
    wait 1;
  }

  setomnvar("_encstr_8A1A18FBE017BA03762CF8E1C6FBDB07EF58C27360E9F7672B98", var_0);
}

_id_1408E() {
  return 1;
}

_id_13269() {
  if(_id_1408E() && level._id_12315.settings._id_128F2 > 0) {
    level._id_12315.implement_cointoss = scripts\mp\hud_util::createservertimer("_encstr_8B1608EC43B8D647A113", 1.4);
    level._id_12315.implement_cointoss scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", undefined, 0, 50);
    level._id_12315.implement_cointoss.label = &"_encstr_8AA61054EA5F8123FE5FB1A3637196B111F5";
    level._id_12315.implement_cointoss.alpha = 0;
    level._id_12315.implement_cointoss.archived = 0;
    level._id_12315.implement_cointoss.hidewheninmenu = 1;
    level._id_12315.implement_cointoss.sort = 1;
  }

  if(_id_1408E()) {
    level._id_12315._id_145BB = scripts\mp\hud_util::createservertimer("_encstr_8B1608EC43B8D647A113", 0.9);
    level._id_12315._id_145BB.x = -6;
    level._id_12315._id_145BB.y = 2;
    level._id_12315._id_145BB.alignx = "_encstr_8253060E2B5FE330";
    level._id_12315._id_145BB.aligny = "_encstr_AC190479FF92";
    level._id_12315._id_145BB.horzalign = "_encstr_85B111AA1808586B88E38BBBE346B389C840E7";
    level._id_12315._id_145BB.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
    level._id_12315._id_145BB.label = &"_encstr_B80411750F972978D081636FC9D724203F2B0D";
    level._id_12315._id_145BB.alpha = 0;
    level._id_12315._id_145BB.archived = 1;
    level._id_12315._id_145BB.hidewheninmenu = 1;
    level._id_12315._id_145BB settimer(120);
  } else
    _id_145B9(120);

  if(_id_1408E()) {
    level._id_145BC = init_trap_room_obj("_encstr_8B1608EC43B8D647A113", 1);
    level._id_145BC.label = &"_encstr_AD6C10A614F582845EAE21A49AA813A4E41D";
    level._id_145BC.x = -5;
    level._id_145BC.y = 2;
    level._id_145BC.alignx = "_encstr_8253060E2B5FE330";
    level._id_145BC.aligny = "_encstr_AC190479FF92";
    level._id_145BC.horzalign = "_encstr_85B111AA1808586B88E38BBBE346B389C840E7";
    level._id_145BC.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
    level._id_145BC.archived = 1;
    level._id_145BC.alpha = 0;
    level._id_145BC.glowalpha = 0.2;
    level._id_145BC.hidewheninmenu = 0;
  }

  if(_id_1408E()) {
    if(!isDefined(level.monitor_player_plundercount))
      level.monitor_player_plundercount = [];

    level.monitor_player_plundercount = init_trap_room_obj("_encstr_8B1608EC43B8D647A113", 0.9);
    level.monitor_player_plundercount.label = &"_encstr_B8720C51E20151E4C7E7B9999385";
    level.monitor_player_plundercount setvalue(0);
    level.monitor_player_plundercount.x = -5;
    level.monitor_player_plundercount.y = 14;
    level.monitor_player_plundercount.alignx = "_encstr_8253060E2B5FE330";
    level.monitor_player_plundercount.aligny = "_encstr_AC190479FF92";
    level.monitor_player_plundercount.horzalign = "_encstr_85B111AA1808586B88E38BBBE346B389C840E7";
    level.monitor_player_plundercount.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
    level.monitor_player_plundercount.archived = 1;
    level.monitor_player_plundercount.fontscale = 1.0;
    level.monitor_player_plundercount.alpha = 1;
    level.monitor_player_plundercount.glowalpha = 0;
    level.monitor_player_plundercount.hidewheninmenu = 0;
    level thread monitor_truck_stuck();
  }
}

init_trap_room_obj(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2.archived = 0;
  return var_2;
}

monitor_truck_stuck() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = prematchspawnoriginteamcount(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
    level.monitor_player_plundercount setvalue(var_0.size);
    level scripts\engine\utility::_id_143A8("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", "_encstr_950A130ED8C2E5B293D0B7ABB91D68D0C2E6B35991", "_encstr_B849116B4D10A3E3E03B159B153009BAFC8BA3", "_encstr_8B8113C1C6B0CB599C22A56EB1F6CD9B95D8A3598C");
  }
}

prematchspawnoriginteamcount(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isalive(var_3) && (!isDefined(var_3.sessionstate) || var_3.sessionstate == "_encstr_877508C1D8C22F2DDC3B")) {
      if(!isDefined(var_0) || var_3.team == var_0)
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

onplayerdisconnect(var_0) {
  level notify("_encstr_8B8113C1C6B0CB599C22A56EB1F6CD9B95D8A3598C");

  if(isDefined(var_0._id_128F8))
    var_0 _id_12907();
  else if(isDefined(var_0._id_128DD))
    var_0 _id_12906();
}

vehomn_fadeoutcontrolsforclient(var_0, var_1) {
  if(isbot(var_0)) {
    return;
  }
  kick(var_0 getentitynumber(), var_1);
}

_id_145A4() {
  var_0 = scripts\engine\utility::_id_143AF("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_9A1A0D9B0E395ADC47AF98B2CEA59B", "_encstr_AB760F43D123BA8C610BBC9E7DF5C85415", "_encstr_ADD91793364FA9F4DF5233D8CA5FA648A793376FB5729034E7");

  if(var_0 == "_encstr_ADD91793364FA9F4DF5233D8CA5FA648A793376FB5729034E7") {
    if(istrue(self.should_skip_default_intro_scene))
      return 1;

    vehomn_fadeoutcontrolsforclient(self, "_encstr_8D7D1AB9F3D56629402EDBCDF2E8C32D733F39F1DFA6FD47E9C454C5");
    return 0;
  }

  return 1;
}

_id_127EE(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(var_0))
    var_0 = 45;

  if(!isDefined(var_1))
    var_1 = 300;

  var_2 = self.origin;
  var_3 = squared(var_1);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0; var_5++) {
    if(!var_4) {
      var_6 = distancesquared(var_2, self.origin);

      if(var_6 >= var_3)
        var_4 = 1;
    }

    wait 1;
  }

  if(var_4)
    return 1;

  return 0;
}

_id_143F0() {
  scripts\mp\flags::gameflagwait("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");
}

_id_1383C() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.manageafktracking = 1;
  _id_143F0();
  childthread _id_145A4();

  if(!_id_127EE(45, 300)) {
    if(istrue(self.should_skip_default_intro_scene)) {
      return;
    }
    vehomn_fadeoutcontrolsforclient(self, "_encstr_8D7D1AB9F3D56629402EDBCDF2E8C32D733F39F1DFA6FD47E9C454C5");
    return;
  }

  if(!_id_127EE(75, 150)) {
    if(istrue(self.should_skip_default_intro_scene)) {
      return;
    }
    vehomn_fadeoutcontrolsforclient(self, "_encstr_8D7D1AB9F3D56629402EDBCDF2E8C32D733F39F1DFA6FD47E9C454C5");
    return;
  }

  wait 30;
  self notify("_encstr_ADD91793364FA9F4DF5233D8CA5FA648A793376FB5729034E7");
}

onspawnplayer() {
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::onspawnplayer();
  self.breathingstoptime = 0;

  if(_id_125F0()) {
    self._id_133C8 = 1;
    self.overrideweaponspeed_speedscale = level._id_12315.settings._id_12914;

    if(!isDefined(self.armor_target_vo))
      self.armor_target_vo = 0;

    if(!isDefined(self.heli_boss_shoot))
      self.heli_boss_shoot = 0;

    if(!isDefined(self.pers["_encstr_A23908476E6229C09C07"]))
      self.pers["_encstr_A23908476E6229C09C07"] = 0;

    self.initplayerplunderevents = level._id_12315.armor_nag[self.pers["_encstr_A23908476E6229C09C07"]];

    if(_id_1408E())
      thread _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_128E4();

    self.turret_guncourse_think = 0;
    var_0 = int(level._id_12315.settings._id_128DB);
    var_1 = undefined;
    var_2 = undefined;

    if(isDefined(self._id_13640) && isDefined(self.getbrplayersnoteliminated)) {
      var_0 = self.getbrplayersnoteliminated;
      var_1 = self.armor_target_vo;
      var_2 = self.heli_boss_shoot;
    }

    _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_1290A(var_0);
    _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_13177(self.initplayerplunderevents, var_1);
    _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_13177("_encstr_A59506C0242F4887", var_2);
    thread _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::has_keycard();
    thread setupextractnumhud();
  } else {
    self._id_133C8 = undefined;
    self.armor_target_vo = undefined;
    self.heli_boss_shoot = undefined;
    self.overrideweaponspeed_speedscale = undefined;

    if(!isDefined(self._id_13B5E))
      self._id_13B5E = 0;

    thread scriptcircleat();
    var_3 = 1;

    if(var_3 && !isDefined(self.manageafktracking))
      thread _id_1383C();
  }

  self._id_13640 = 1;
}

_id_11D20() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_96831103CA05F13FAFB89252C5B9B0CB77F315");

  if(_id_1408E()) {
    if(level._id_12315.settings._id_128F2 > 0) {
      level._id_12315.implement_cointoss settimer(level._id_12315.settings._id_128F2);
      level._id_12315.implement_cointoss.alpha = 1;
    }

    level._id_12315._id_145BB settimer(level._id_12315.settings._id_12924 + level._id_12315.settings._id_128F2);
    level._id_12315._id_145BB.alpha = 1;
  } else if(level._id_12315.settings._id_128F2 > 0 || level._id_12315.settings._id_12924 > 0)
    _id_145B9(level._id_12315.settings._id_12924 + level._id_12315.settings._id_128F2);

  if(level._id_12315.settings._id_128F2 > 0)
    wait(level._id_12315.settings._id_128F2);

  scripts\mp\flags::gameflagset("_encstr_91FA1038C9BD83B9F543A523ACFADB3B564E");

  if(_id_1408E()) {
    level._id_12315._id_145BB.alpha = 1;

    if(level._id_12315.settings._id_128F2 > 0)
      level._id_12315.implement_cointoss.alpha = 0;
  }

  if(level._id_12315.settings._id_12924 > 0)
    _id_12923();
}

setupextractnumhud() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
  self allowprone(0);
  self allowsprint(0);
  scripts\mp\weapons::updatemovespeedscale();
  self disableweaponpickup();
  self takeallweapons();
  self allowspectateteam(game["_encstr_991C0AB9ED5B57161FE89B83"], 1);
  self playerhide();
  scripts\mp\class::loadout_giveperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
  thread _id_13266();
  thread _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_13256();
  thread _id_13236();
  thread _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_128F5();
  thread _id_12921();
  thread _id_1291F();
  thread _id_12920();
  thread _id_12922();
  self.prop thread spawn_exfil_techo(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", self);
  self.hoopty_initomnvars = undefined;
}

run_guards_spawner(var_0) {
  switch (var_0) {
    case 50:
      return 120;
    case 100:
      return 150;
    case 250:
      return 180;
    case 450:
      return 260;
    case 550:
      return 320;
    default:
      break;
  }

  return 120;
}

run_global_functions_for_relics(var_0) {
  switch (var_0) {
    case 50:
      return -30;
    case 100:
      return -20;
    case 250:
      return 0;
    case 450:
      return 20;
    case 550:
      return 40;
    default:
      break;
  }

  return 0;
}

calculateobjectivesheld() {
  if(!isDefined(self.prop._id_1467E)) {
    return;
  }
  self.prop.angles = self.angles;
  var_0 = anglesToForward(self.prop.angles) * self.prop._id_1467E[0];
  var_1 = anglestoright(self.prop.angles) * self.prop._id_1467E[1];
  var_2 = anglestoup(self.prop.angles) * self.prop._id_1467E[2];
  self.prop.origin = self.prop.origin + var_0;
  self.prop.origin = self.prop.origin + var_1;
  self.prop.origin = self.prop.origin + var_2;
}

cache1_defender_after_spawn() {
  if(!isDefined(self.prop.building_roof_chopper_reenforce)) {
    return;
  }
  self.prop.angles = self.angles;
  self.prop.angles = self.prop.angles + self.prop.building_roof_chopper_reenforce;
  self.turret_guncourse_think = 1;
}

gettimeremaining() {
  var_0 = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
    for(var_1 = 0; var_1 < level.br_level.br_circledelaytimes.size; var_1++) {
      var_2 = level.br_level.br_circledelaytimes[var_1];
      var_3 = level.br_level.br_circleclosetimes[var_1];
      var_0 = var_0 + var_2 + var_3;
    }

    var_0 = var_0 * 1000;
    var_4 = gettime() - level._id_12315.settings._id_145B8;
    var_0 = var_0 - var_4;

    if(var_0 < 0)
      var_0 = 0;
  }

  return int(var_0);
}

_id_12923() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_12315.settings._id_145B8 = gettime();
  var_0 = gettime();
  var_1 = level._id_12315.settings._id_12924 * 1000;
  var_2 = 20000;
  var_3 = var_2;
  var_4 = 500;
  var_5 = 5000;
  var_6 = 0;
  var_7 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0].origin;
  wait(level._id_12315.settings._id_12924);

  if(!_id_1408E())
    setomnvar("_encstr_813615A34B7197B74DBF935011F108B02E9BB74AE31838", 0);

  for(;;) {
    if(var_0 + var_1 - var_4 < gettime()) {
      var_6++;
      var_8 = sortbydistance(level.players, var_7);

      foreach(var_10 in var_8) {
        if(!isDefined(var_10)) {
          continue;
        }
        if(_id_1408E()) {
          level._id_12315._id_145BB.alpha = 0;
          level._id_145BC.alpha = 0.6;
        }

        if(var_10 _id_125F0() && isalive(var_10)) {
          if(_id_1408E()) {
            level._id_145BC.alpha = 1;
            level._id_145BC fadeovertime(0.75);
            level._id_145BC.alpha = 0.6;
          }

          playsoundatpos(var_10.origin + (0, 0, 60), "_encstr_B1630D91BB824F81F79CA0FB83C498");
          wait 1.5;
        }
      }

      if(!_id_1408E())
        setomnvar("_encstr_813615A34B7197B74DBF935011F108B02E9BB74AE31838", 2);

      var_0 = gettime();

      if(var_6 % 2 == 0)
        var_1 = max(var_1 - 5000, var_2);

      if(var_3 >= gettimeremaining() - var_5) {
        if(_id_1408E())
          level._id_145BC.alpha = 0;

        return;
      } else {
        if(var_3 * 2 + getteamplayersalive(game["_encstr_B6A70A23CA6659DC91CAE4DC"]) * 2500 >= gettimeremaining() - var_5) {
          if(_id_1408E())
            level._id_12315._id_145BB.label = &"_encstr_9394148151A73311CAF52CB421B9E83F98BB1F8DD1EF";
          else
            setomnvar("_encstr_813615A34B7197B74DBF935011F108B02E9BB74AE31838", 1);

          var_3 = var_3 + getteamplayersalive(game["_encstr_B6A70A23CA6659DC91CAE4DC"]) * 2500;
        }

        if(_id_1408E())
          level._id_12315._id_145BB settimer(int(var_1 / 1000));
        else
          _id_145B9(int(var_1 / 1000));

        if(_id_1408E()) {
          level._id_145BC.alpha = 0;
          level._id_12315._id_145BB.alpha = 1;
        }
      }
    }

    wait 0.5;
  }
}

removematchingents_byclassname(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(var_3) && scripts\mp\utility\entity::isteamparticipant(var_3) && var_3.team == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

init_swivelroom_variables() {
  self._id_136D7 = removematchingents_byclassname(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
}

_id_13236() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 0.5;
  self.prop._id_133D4 = 1;
  self.prop thread scripts\mp\damage::monitordamage(self.prop.health, "_encstr_A5AE098ADB583E0AF7A5AB", undefined, ::damagewatch);
}

damagewatch(var_0) {
  if(!isDefined(var_0.attacker))
    return 0;

  if(!isDefined(self.owner))
    return 0;

  if(isPlayer(var_0.attacker)) {
    if(var_0.attacker.pers["_encstr_8AEF05472BC2D6"] == self.owner.pers["_encstr_8AEF05472BC2D6"])
      return 0;

    var_0.attacker thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");

    if(var_0.objweapon.basename == "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B") {
      var_1 = spawnStruct();
      var_1.origin = var_0.point;
      self.owner thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_1, var_0.attacker);

      if(istrue(self.owner.lock))
        self.owner _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_13F1D();
    }
  }

  self.owner dodamage(var_0.damage, var_0.point, var_0.attacker, var_0.inflictor, var_0.meansofdeath, var_0.objweapon);
  return 0;
}

_id_128DF() {
  thread _id_128E0([self.prop, self._id_128D7, self._id_128EA]);
}

_id_128E0(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 unlink();
  }

  waitframe();

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

_id_12921() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.iskingofthehillactive = "_encstr_9AD50BE8AE78535941A86A3328";
  self._id_128E5 = "_encstr_9B580CE039B707115985D1A18C2C";
  self waittill("_encstr_AD75063D571AE108");
  var_0 = self.body;
  playsoundatpos(self.prop.origin + (0, 0, 4), self.iskingofthehillactive);
  playFX(scripts\engine\utility::getfx(self._id_128E5), self.prop.origin + (0, 0, 4));

  if(isDefined(var_0))
    var_0 delete();

  _id_128DF();
  self setcamerathirdperson(0, 0);
  _id_12680(0);
}

_id_1291F() {
  self notify("_encstr_AB381A52768F530F71C0E7D35929FCCA4105D78C5E3FFA4EF860EFAB");
  self endon("_encstr_AB381A52768F530F71C0E7D35929FCCA4105D78C5E3FFA4EF860EFAB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  foreach(var_1 in level.players) {
    if(istrue(var_1._id_12913) && isDefined(var_1._id_136DF) && self == var_1._id_136DF)
      var_1 notify("_encstr_B63F10DDF52AC92B0F9BC9C8D75BA3E3535F");
  }

  _id_128DF();
  _id_128E1();
}

_id_12920() {
  self notify("_encstr_93B718517B428F01A1DBA1D8CF8D904D4B8F8DE79FBA5DA9F6B7");
  self endon("_encstr_93B718517B428F01A1DBA1D8CF8D904D4B8F8DE79FBA5DA9F6B7");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_97A10C67F01867829BF19397D3B1", 5);
  _id_128DF();
  _id_128E1();
}

_id_128E1() {
  if(isDefined(self._id_128E3)) {
    foreach(var_1 in self._id_128E3) {
      if(isDefined(var_1))
        var_1 delete();
    }
  }
}

handleriotshielddamage() {
  foreach(var_1 in level.players)
  var_1 _id_128E1();
}

_id_12922() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self allowprone(0);
  self allowsprint(0);
}

last_spawned_time() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
}

_id_1213E() {
  foreach(var_5, var_1 in level._id_12315._id_128F7) {
    if(var_5 != "_encstr_9A19040BCDBC") {
      foreach(var_4, var_3 in level._id_12315._id_128F7["_encstr_9A19040BCDBC"])
      level._id_12315._id_128F7[var_5][var_4] = scripts\engine\utility::array_combine(level._id_12315._id_128F7[var_5][var_4], var_3);
    }
  }
}

_id_129F3(var_0) {
  var_1 = level._id_12315._id_128F7[var_0];
  var_2 = 10 * isDefined(var_1[50]);
  var_3 = 30 * isDefined(var_1[100]);
  var_4 = 40 * isDefined(var_1[250]);
  var_5 = 20 * isDefined(var_1[450]);
  var_6 = 10 * isDefined(var_1[550]);
  var_7 = var_2 + var_3 + var_4 + var_5 + var_6;
  var_8 = randomint(var_7);

  if(var_8 < var_2)
    return 50;

  var_8 = var_8 - var_2;

  if(var_8 < var_3)
    return 100;

  var_8 = var_8 - var_3;

  if(var_8 < var_4)
    return 250;

  var_8 = var_8 - var_4;

  if(var_8 < var_5)
    return 450;

  var_8 = var_8 - var_5;
  return 550;
}

reset_search_spot_light_nodes(var_0) {
  var_1 = var_0 _id_128EC();
  var_2 = level._id_12315._id_128F7[var_1];
  var_3 = _id_129F3(var_1);
  var_4 = scripts\engine\utility::array_randomize(getarraykeys(var_2));
  var_5 = [var_3];

  foreach(var_7 in var_4) {
    if(var_7 != var_3)
      var_5[var_5.size] = var_7;
  }

  var_9 = undefined;

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    var_7 = var_5[var_10];

    if(!isDefined(var_2[var_7]) || !var_2[var_7].size) {
      continue;
    }
    var_11 = scripts\engine\utility::array_randomize(var_2[var_7]);

    for(var_12 = 0; var_12 < var_11.size; var_12++) {
      var_9 = var_11[var_12];
      var_13 = 0;

      if(isDefined(var_0._id_1406D) && var_0._id_1406D.size) {
        for(var_14 = 0; var_14 < var_0._id_1406D.size; var_14++) {
          if(var_9.modelname == var_0._id_1406D[var_14].modelname) {
            var_13 = 1;
            break;
          }
        }
      }

      if(!var_13)
        return var_9;
    }
  }

  return var_9;
}

_id_127E9() {
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();
  var_1 = "_encstr_B419046BC179" + var_0 + "_encstr_A537087FE1CB1E9B6823";
  var_2 = 0;

  if(tableexists(var_1)) {
    var_2 = tablelookupgetnumrows(var_1);

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = tablelookupbyrow(var_1, var_3, 0);

      if(var_4 == "_encstr_8F0E0583E4DB83") {
        var_5 = tablelookupbyrow(var_1, var_3, 1);
        var_6 = tablelookupbyrow(var_1, var_3, 2);
        var_7 = int(tablelookupbyrow(var_1, var_3, 3));
        var_8 = int(tablelookupbyrow(var_1, var_3, 4));
        var_9 = int(tablelookupbyrow(var_1, var_3, 5));
        var_10 = int(tablelookupbyrow(var_1, var_3, 6));
        var_11 = int(tablelookupbyrow(var_1, var_3, 7));
        var_12 = int(tablelookupbyrow(var_1, var_3, 8));
        var_13 = tablelookupbyrow(var_1, var_3, 9);
        var_14 = tablelookupbyrow(var_1, var_3, 10);
        var_15 = tablelookupbyrow(var_1, var_3, 11);

        if(var_15 == "_encstr_B40101")
          var_15 = "_encstr_9A19040BCDBC";

        var_16 = undefined;

        if(isDefined(var_7) && isDefined(var_8) && isDefined(var_9))
          var_16 = (var_7, var_8, var_9);

        var_17 = undefined;

        if(isDefined(var_10) && isDefined(var_11) && isDefined(var_12))
          var_17 = (var_10, var_11, var_12);

        var_18 = revive_vo_time(var_6);

        if(!isDefined(var_13) || var_13 == "_encstr_B40101")
          var_13 = run_global_functions_for_relics(var_18);
        else
          var_13 = int(var_13);

        if(!isDefined(var_14) || var_14 == "_encstr_B40101")
          var_14 = run_guards_spawner(var_18);
        else
          var_14 = int(var_14);

        battletracksidstandingonvehicle(var_5, var_18, var_16, var_17, var_6, var_13, var_14, var_15);
        continue;
      }

      if(var_4 == "_encstr_8A19046AD06F") {
        var_15 = tablelookupbyrow(var_1, var_3, 11);
        var_19 = int(tablelookupbyrow(var_1, var_3, 12));
        var_20 = int(tablelookupbyrow(var_1, var_3, 13));
        var_21 = int(tablelookupbyrow(var_1, var_3, 14));
        timeoutplunderextractionsites(var_15, var_19, var_20, var_21);
        continue;
      }
    }
  }

  if(var_2 == 0)
    battletracksidstandingonvehicle("_encstr_A2B40B8E2C3B7DDB274B9D4B37", 250, (0, 0, 0), (0, 0, 0), "_encstr_AB5E07609A5B7368E5", run_global_functions_for_relics(250), run_guards_spawner(250), "_encstr_9A19040BCDBC");

  _id_1213E();
}

_id_13266() {
  var_0 = self._id_128F4;

  if(!isDefined(var_0))
    var_0 = reset_search_spot_light_nodes(self);

  self._id_128D7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self._id_128D7.targetname = "_encstr_B6F60BA3307F829F583EE0EF4E";
  self._id_128D7 linkTo(self);
  self._id_128EA = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self._id_128EA setModel("_encstr_AD7316BC57EAC34B697709682BB7C37F93FEAC35ED91A15B");
  self._id_128EA.targetname = "_encstr_8DEA08BFFA37831B0DDB";
  self._id_128EA linkTo(self._id_128D7);
  self.prop = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self._id_128EA.origin);
  self.prop.targetname = "_encstr_8F0E0583E4DB83";
  self.prop setModel(var_0.modelname);
  self.prop setCanDamage(1);
  self.prop._id_1467E = var_0._id_1467E;
  self.prop.building_roof_chopper_reenforce = var_0.building_roof_chopper_reenforce;
  self.prop.angles = self.angles;
  calculateobjectivesheld();
  cache1_defender_after_spawn();
  self.prop linkTo(self._id_128EA, "_encstr_AFAA093C4628DA52A72756");
  self.prop.owner = self;
  self.prop.health = 10000;
  self._id_128EA scriptmodelplayanim("_encstr_81A814783EE8C32929580AA321315A07A330E3F0DB90", "_encstr_B1D50D3827F6C1A90E967382B9965B", undefined, 1.5);
  self._id_128EA scriptmodelpauseanim(1);
  self._id_13B30 = var_0._id_12905;
  self._id_13B2F = var_0._id_128F1;
  self setcamerathirdperson(1, self._id_13B30, self._id_13B2F);
  _id_12680(1);
  self.prop.info = var_0;
  self._id_128F4 = var_0;

  if(!isDefined(self._id_13640))
    self._id_1406D = [];

  self.maxhealth = revive_stim(var_0);
  self.health = self.maxhealth;
}

_id_12680(var_0) {}

revive_stim(var_0) {
  return int(var_0._id_1290D);
}

revive_vo_time(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_83FC070807A5E9197A":
      var_1 = 50;
      break;
    case "_encstr_A972062F7FDAF9B0":
      var_1 = 100;
      break;
    case "_encstr_AB5E07609A5B7368E5":
      var_1 = 250;
      break;
    case "_encstr_8DEC06B1E943615B":
      var_1 = 450;
      break;
    case "_encstr_A5A50718294E061C81":
      var_1 = 550;
      break;
    default:
      var_2 = scripts\cp_mp\utility\game_utility::getmapname();
      var_3 = "_encstr_B419046BC179" + var_2 + "_encstr_A537087FE1CB1E9B6823";
      var_1 = 100;
      break;
  }

  return var_1;
}

battletracksidstandingonvehicle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level._id_12315._id_128F7[var_7]))
    level._id_12315._id_128F7[var_7] = [];

  if(!isDefined(level._id_12315._id_128F7[var_7][var_1]))
    level._id_12315._id_128F7[var_7][var_1] = [];

  var_8 = spawnStruct();
  var_8.modelname = var_0;
  var_8._id_1290D = int(var_1);
  var_8._id_1290E = var_4;
  var_8.location = var_7;

  if(isDefined(var_2))
    var_8._id_1467E = var_2;

  if(isDefined(var_3))
    var_8.building_roof_chopper_reenforce = var_3;

  var_8._id_12905 = var_6;
  var_8._id_128F1 = var_5;
  var_10 = level._id_12315._id_128F7[var_7][var_1].size;
  level._id_12315._id_128F7[var_7][var_1][var_10] = var_8;
}

_id_12317(var_0, var_1) {
  if(istrue(level.need_respawn)) {
    return;
  }
  level.need_respawn = 1;
  _id_12319(var_0);
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
  level thread scriptgoalyaw(var_0);
}

_id_12319(var_0) {
  level.finalkillcam_winner = var_0;

  if(level.finalkillcam_winner == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level._id_133CF = 1;
}

scriptgoalyaw(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0] + 1;
  setteamscore(var_0, var_1);
}

_id_13198() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = game["_encstr_B81B0A39EDABE69137D5BDCD"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]];
  var_1 = game["_encstr_B81B0A39EDABE69137D5BDCD"][game["_encstr_991C0AB9ED5B57161FE89B83"]];
  setteamscore(game["_encstr_B6A70A23CA6659DC91CAE4DC"], var_0);
  setteamscore(game["_encstr_991C0AB9ED5B57161FE89B83"], var_1);
}

ononeleftevent(var_0) {
  if(istrue(level.gameended)) {
    return;
  }
  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    return;
  }
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_3) && !var_3 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(isDefined(var_1)) {
      return;
    }
    var_1 = var_3;
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread givelastonteamwarning();
}

givelastonteamwarning() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_AB591C8E66FAE1D845FBD978977B7319B28E7101FF4245C12AC748582385", self, self.pers["_encstr_8AEF05472BC2D6"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_81D01736858DB1BDAE8E7D1BB09B3AACCDB2DA97851B4BB395", self, var_0);

  if(_id_125F0()) {
    level notify("_encstr_A2751273B7144EBD0EDC45B7D438591BE858D12B");
    level._id_11EB9 = 1;
  }

  level notify("_encstr_B6420BE367A3B0A1F7EB43C33F", self);
}

ontimelimit() {
  if(!istrue(level.playerzombiethermal)) {
    var_0 = scripts\mp\utility\game::gettimepassed();
    game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] + var_0;
    game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"][game["_encstr_991C0AB9ED5B57161FE89B83"]] = game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"][game["_encstr_991C0AB9ED5B57161FE89B83"]] + var_0;
    give_and_switch_to_primary_weapon();
    _id_12317(game["_encstr_B6A70A23CA6659DC91CAE4DC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  }
}

give_and_switch_to_primary_weapon() {
  var_0 = removematchingents_byclassname(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

  if(var_0.size < 1) {
    return;
  }
  var_1 = removematchingents_byclassname(game["_encstr_991C0AB9ED5B57161FE89B83"]);

  if(var_1.size < 1) {
    return;
  }
  var_2 = getweaponvariantids(var_0, var_1);

  if(scripts\mp\utility\entity::isgameparticipant(var_2))
    var_3 = var_2 getentitynumber();
  else
    var_3 = -1;

  var_4 = var_1[0];
  var_4.deathtime = gettime() - 1000;
  scripts\mp\final_killcam::recordfinalkillcam(5.0, var_4, var_2, var_3, -1, 0, "_encstr_8BBA05185F8B99", 0, 0, "_encstr_8BBA05185F8B99", "_encstr_820E07FAE8780B3A4C", 0);
}

getweaponvariantids(var_0, var_1) {
  var_2 = undefined;
  var_3 = 1073741824;

  foreach(var_5 in var_0) {
    var_6 = undefined;
    var_7 = 1073741824;

    foreach(var_9 in var_1) {
      var_10 = getpathdist(var_5.origin, var_9.origin, 999999);

      if(var_10 < var_7) {
        var_7 = var_10;
        var_6 = var_9;
      }
    }

    if(var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_5;
    }
  }

  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::random(var_0);

  return var_2;
}

_id_12316() {
  if(game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_9A8507BA4040188D08"] == scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1") - 1 && game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_8E8405EA382B2A"] == scripts\mp\utility\dvars::getwatcheddvar("_encstr_97B20977D2B91B2DAD4BD1") - 1)
    return 1;

  return 0;
}

_id_125DF() {
  scripts\mp\equipment::incrementequipmentammo("_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E");
  scripts\mp\class::loadout_removeperk("_encstr_9A871B9BA008488198DBDB8B56AADD04615713F4EB11F882C28BC8D057");
}

scriptcircleat() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");

  if(!istrue(self.gulag))
    _id_125DF();

  self._id_13B30 = undefined;
  self setcamerathirdperson(0, 0);
  _id_12680(0);
  self allowprone(1);
  self allowsprint(1);
  scripts\mp\weapons::updatemovespeedscale();
  self enableweaponpickup();
  self playershow();
  self.hoopty_initomnvars = 1;
  cdlgametuning();
  thread center_struct();
}

_id_138A9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.scoreinfo["_encstr_ABD70578F3D02C"]["_encstr_BA94069D16D8ABAC"] = 300;
  scripts\mp\flags::gameflagwait("_encstr_91FA1038C9BD83B9F543A523ACFADB3B564E");

  for(;;) {
    wait 10;

    foreach(var_1 in level.players) {
      if(!isDefined(var_1.team)) {
        continue;
      }
      if(!var_1 _id_125F0()) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }
      var_1 thread scriptablesmax("_encstr_9A8B0CCDD1D2C61BAF2CB14B3BCA");

      switch (var_1.prop.info._id_1290D) {
        case 250:
          var_1 thread scriptablesmax("_encstr_99B7194BD17025F3E86192CAABDD07DDB869D9B50B196EB7289B7B");
          break;
        case 450:
          var_1 thread scriptablesmax("_encstr_8E65183720BF316977C2CBE8C33581B98BFA9FE569208F20AD87");
          break;
        case 550:
          var_1 thread scriptablesmax("_encstr_88051ED2834064C2503B434F0D6539A5702B0ADE9E63311B94DB876B1798C30B");
          break;
        default:
          break;
      }
    }
  }
}

_id_13C62() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _id_143F0();

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1.team)) {
        continue;
      }
      if(var_1.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }
      if(isDefined(var_1.pers["_encstr_8F020CE09CDB8335B21BDBE62337"]))
        var_1.pers["_encstr_8F020CE09CDB8335B21BDBE62337"]++;
    }

    wait 1;
  }
}

gamemodemodifyplayerdamage(var_0) {
  var_1 = var_0.damage;

  if(istrue(self._id_12913)) {
    self notify("_encstr_B63F10DDF52AC92B0F9BC9C8D75BA3E3535F");

    if(var_0.meansofdeath == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3")
      return 0;
  }

  if(isDefined(var_0.victim.team)) {
    if(var_0.victim _id_125F0())
      var_1 = _id_11C99(var_0);
    else
      var_1 = _id_11C98(var_0);

    if(var_1 == 0)
      return 0;
  }

  if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && isalive(var_0.attacker)) {
    if(!isDefined(var_0.attacker.should_skip_default_intro_scene))
      var_0.attacker.should_skip_default_intro_scene = 1;

    if(level.matchrules_damagemultiplier)
      var_1 = var_1 * level.matchrules_damagemultiplier;

    if(level.matchrules_vampirism)
      var_0.attacker.health = int(min(float(var_0.attacker.maxhealth), float(var_0.attacker.health + 20)));
  }

  return var_1;
}

_id_11C99(var_0) {
  if(isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_87A10C9D24E997A01F21838F3D34")
    return 0;

  return var_0.damage;
}

_id_11C98(var_0) {
  if(isDefined(var_0.meansofdeath) && var_0.meansofdeath == "_encstr_87A10C9D24E997A01F21838F3D34")
    return 0;

  if(var_0.objweapon.basename == "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B")
    return 0;

  if(issubstr(var_0.objweapon.basename, "_encstr_A6460DC8CADC8E4EAB8D3AA5C46356"))
    return 0;

  return var_0.damage;
}

cdlgametuning() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0)
  self givemaxammo(var_2);

  var_4 = self getweaponammostock("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B");
  var_4 = var_4 - self._id_13B5E;
  var_4 = int(max(var_4, 0));
  self setweaponammostock("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", var_4);

  if(var_4 > 0)
    thread _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_144F6();
}

center_struct() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_9A6A1286F4EB5B8840CA6695590751223747B578");
  self endon("_encstr_9A6A1286F4EB5B8840CA6695590751223747B578");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    var_0 = self getcurrentprimaryweapon();
    var_1 = weaponmaxammo(var_0);

    if(self getweaponammostock(var_0) < var_1)
      self setweaponammostock(var_0, var_1);
  }
}

getkeypadstatefromomnvar() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.1;

  if(self.pers["_encstr_8CAA06DB20A31543"] == 1) {
    self.pers["_encstr_8CAA06DB20A31543"]--;
    level.zombiejumpbartext[self.team]--;
    scripts\mp\gamelogic::updategameevents();
    level notify("_encstr_B849116B4D10A3E3E03B159B153009BAFC8BA3");
    return;
  }
}

_id_126BF() {
  var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];

  if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_0 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];

  scripts\mp\menus::addtoteam(var_0);
}

onplayerkilled(var_0) {
  var_1 = 0;
  level notify("_encstr_950A130ED8C2E5B293D0B7ABB91D68D0C2E6B35991");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    _id_126BF();
    return;
  }

  if(!var_0.victim _id_125F0())
    thread _id_12CAC();
  else if(!scripts\mp\flags::gameflag("_encstr_91FA1038C9BD83B9F543A523ACFADB3B564E")) {
    thread _id_12CAC();
    return;
  }

  if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && var_0.attacker != var_0.victim && var_0.victim.team != var_0.attacker.team)
    var_1 = 1;

  if(var_1)
    var_0.attacker thread _id_12558("_encstr_AC710F68CB35111E636930BF74ABA0E79B");

  foreach(var_3 in level.players) {
    if(istrue(var_3._id_12913) && isDefined(var_3._id_136DF) && var_0.victim == var_3._id_136DF)
      var_3 notify("_encstr_B63F10DDF52AC92B0F9BC9C8D75BA3E3535F");

    if(var_3 != var_0.attacker && var_3 _id_125F0() && isalive(var_3) && var_0.victim _id_125F0())
      var_3 thread _id_12558("_encstr_88C30EC38B700B194833929E23485F83");
  }
}

_id_12558(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_9A8B0CCDD1D2C61BAF2CB14B3BCA":
      var_1 = &"_encstr_9B371E368A581BFFD89F19813320B8F770E50EB5D1C149E4F49371796B09EF83";
      break;
    case "_encstr_99B7194BD17025F3E86192CAABDD07DDB869D9B50B196EB7289B7B":
      var_1 = &"_encstr_974F286A28130AA990154DEB0524BC4D349E94A2F5A65125C4897D0589A465A27DD4A888D7127A93559A";
      break;
    case "_encstr_8E65183720BF316977C2CBE8C33581B98BFA9FE569208F20AD87":
      var_1 = &"_encstr_AD7E2A350589059A42A835D7A0245E4DA1A792A8FA35A2526298EB05C44A2B15BE6282923A2AEB12E92755D4";
      break;
    case "_encstr_88051ED2834064C2503B434F0D6539A5702B0ADE9E63311B94DB876B1798C30B":
      var_1 = &"_encstr_A11330A60A26826A24159A7D822479D40DE9928A7D9A45941362AF0562942B54D751612A2950EB62A04AD151D7099EC9AAA9";
      break;
    case "_encstr_840D106CD8B7DC2BFA19CAE61DC9DEF2B2C8":
      var_1 = &"_encstr_B65E1F9AA026A0A9098AD4EB1412E59A863D4A2AF5118A1AD3CAEB2D5289C42A22";
      break;
    case "_encstr_9B8F14A60DE2CDA157DFF0689784792FFB322833272A":
      var_1 = &"_encstr_B69C2353A16156472BBD29D12713FE9A41F72ACD2789EFDF40D6E1596DF60744F949BC55B9";
      break;
    case "_encstr_AC710F68CB35111E636930BF74ABA0E79B":
      var_1 = &"_encstr_8CC81B9B3F71A88ACBB74B9F8939AA38CBA8714F035410210C7DFCD02F";
      break;
    case "_encstr_88C30EC38B700B194833929E23485F83":
      var_1 = &"_encstr_AA701ABFA3B40DA78B3DBBC0D7F3CE338F3109091F0BF1C964FE3DCB";
      break;
    default:
      return;
  }

  self iprintlnbold(var_1);
}

_id_12CAC() {
  thread _id_14384();
}

_id_14384() {
  self endon("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 0.05;

    if(isDefined(self) && (self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" || !scripts\mp\utility\player::isreallyalive(self))) {
      self.pers["_encstr_8CAA06DB20A31543"] = 1;
      scripts\mp\playerlogic::spawnclient();
      continue;
    }

    return;
  }
}

ondeadevent(var_0) {
  if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    level thread _id_128F6();
}

onplayerjointeam(var_0) {
  if(level.teambased)
    var_0 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_131A8(1);

  if(!var_0 _id_125F0()) {
    if(isDefined(var_0._id_128F8))
      var_0 _id_12907();
    else if(isDefined(var_0._id_128DD))
      var_0 _id_12906();
  }
}

_id_128F6() {
  if(istrue(level.spawnedasspectator)) {
    return;
  }
  if(istrue(level.playerzombiethermal)) {
    return;
  }
  level.spawnedasspectator = 1;
  var_0 = scripts\mp\utility\game::gettimepassed();
  game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = game["_encstr_B62411079CDB1C355D279D2DB30B3645D2DA95"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] + var_0;
  game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"][game["_encstr_991C0AB9ED5B57161FE89B83"]] = game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"][game["_encstr_991C0AB9ED5B57161FE89B83"]] + var_0;
  level.playerzombiethermal = 1;
  wait 3;
  thread _id_12317(game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][game["_encstr_B6A70A23CA6659DC91CAE4DC"] + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
}

_id_1245E(var_0, var_1, var_2) {
  if(var_1 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
    return;
  }
  if(_id_125F0()) {
    return;
  }
  var_3 = randomintrange(1, 8);
  var_4 = "_encstr_979608DF73C8E70B73A1";

  if(scripts\mp\utility\player::isfemale())
    var_4 = "_encstr_B82907C2887BC62B39";

  if(var_1 == "_encstr_87A10C9D24E997A01F21838F3D34" || var_1 == "_encstr_AB590C99ED78875F650F3951034D" && isPlayer(self)) {
    if(self.team == "_encstr_8E8405EA382B2A")
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "_encstr_ACAB14C94B58EF64D92B70D1B96D0849AAF856C09A48", var_4 + "_encstr_A52710BECD2D4E23C04133D38A6678DA8B91" + var_3);
    else
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "_encstr_ACAB14C94B58EF64D92B70D1B96D0849AAF856C09A48", var_4 + "_encstr_A50311FA46CA0BD1A1FA2CD62BC95A8DB0DCFA" + var_3);
  } else if(isPlayer(self)) {
    if(self.team == "_encstr_8E8405EA382B2A")
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "_encstr_966112D891EBDF875398CB0281BF3FE3E1065943", var_4 + "_encstr_A52710BECD2D4E23C04133D38A6678DA8B91" + var_3);
    else
      scripts\mp\utility\sound::playplayerandnpcsounds(self, "_encstr_966112D891EBDF875398CB0281BF3FE3E1065943", var_4 + "_encstr_A50311FA46CA0BD1A1FA2CD62BC95A8DB0DCFA" + var_3);
  } else if(self.team == "_encstr_8E8405EA382B2A")
    self playSound(var_4 + "_encstr_A52710BECD2D4E23C04133D38A6678DA8B91" + var_3);
  else
    self playSound(var_4 + "_encstr_A50311FA46CA0BD1A1FA2CD62BC95A8DB0DCFA" + var_3);
}

playoverwatch_dialogue_with_endon(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3) && isDefined(level._id_12916)) {
    if(level._id_12916 == "_encstr_8E8D0697EB01F243") {
      self setclientomnvar("_encstr_8F91145D4BFA39DE5D3732AFACB991EBE459169BBD9B", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ADA016682387EB5F9B8C7DF622E26BF0F54B8938F72CA0FF"]);
      self setclientomnvar("_encstr_83681CCFC84F75B78BF08217A5286171639303874694300B9F9652D8FAEB", game["_encstr_889A0A0E27B71C9A6CF6932B"][var_4]);
      self setclientomnvar("_encstr_9792198B0989C8E087AAC9D662932DE95F962303B161383EC743E1", game["_encstr_889A0A0E27B71C9A6CF6932B"][level.otherteam[var_4]]);
    } else if(level._id_12916 == "_encstr_84EF055338A18F") {
      var_5 = game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"][var_4] / 1000;
      var_6 = game["_encstr_8FEA0F6028B6A3E84ABF67840D63CA7AC0"][level.otherteam[var_4]] / 1000;
      var_7 = int(scripts\engine\math::round_float(var_5));
      var_8 = int(scripts\engine\math::round_float(var_6));

      if(var_7 == var_8) {
        if(var_5 > var_6)
          var_7++;
        else
          var_8++;
      }

      self setclientomnvar("_encstr_8F91145D4BFA39DE5D3732AFACB991EBE459169BBD9B", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8FB01583E4DE0EBE1D5ACAC439B2B0DAB2277DE896D6AC"]);
      self setclientomnvar("_encstr_83681CCFC84F75B78BF08217A5286171639303874694300B9F9652D8FAEB", var_7);
      self setclientomnvar("_encstr_9792198B0989C8E087AAC9D662932DE95F962303B161383EC743E1", var_8);
    }

    return 1;
  }

  return 0;
}

_id_126F0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AE("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_95C0114B0F99BF33EB808AF230BF2E0FB1F9A5", "_encstr_AD75063D571AE108");

    if(var_0 == "_encstr_AD75063D571AE108") {
      continue;
    }
    waittillframeend;
    var_1 = self getspectatingplayer();

    if(!isDefined(var_1))
      continue;
  }
}

spawn_fake_digit_pool(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  self hudoutlinedisable();

  foreach(var_5 in level.players) {
    if(isDefined(var_2) && var_2 == var_5) {
      continue;
    }
    var_6 = var_5.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D";

    if(var_5.team == var_0 && !var_6)
      self hudoutlineenableforclient(var_5, var_1);

    if(var_3 && (var_5.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_6))
      self hudoutlineenableforclient(var_5, var_1);
  }
}

spawn_exfil_techo(var_0, var_1, var_2, var_3) {
  self notify("_encstr_A65F0B4B38A7AB23804D0539F9");
  self endon("_encstr_A65F0B4B38A7AB23804D0539F9");
  self endon("_encstr_8E95062EE46DB683");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A74F0AADF6C891057A57211B");

  if(!isDefined(var_3))
    var_3 = 1;

  spawn_fake_digit_pool(var_0, var_1, var_2, var_3);

  for(;;) {
    level waittill("_encstr_B1750C47E049978B0F78C3BF5F23");
    spawn_fake_digit_pool(var_0, var_1, var_2, var_3);
  }
}

getrandompointincirclenearby(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 _id_125F0()) {
      if(isDefined(var_2._id_13665) && isDefined(var_2._id_13665.spawnpoint) && var_2._id_13665.spawnpoint == var_0)
        return 0;
    }
  }

  return 1;
}

loadoutdefaultperkdiscount(var_0) {
  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 0;

  if(!scripts\mp\utility\game::gamehasstarted())
    return 0;

  if(var_0 _id_125F0())
    return !level.ingraceperiod;

  return 0;
}

_id_125F0() {
  return isDefined(self.team) && self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"];
}

_id_1269C(var_0) {
  return _id_125F0() || level.stop_end_breach_fx;
}

scriptablesmax(var_0) {
  var_1 = scripts\mp\rank::getscoreinfovalue(var_0);
  scripts\mp\rank::giverankxp(var_0, var_1);
  scripts\mp\utility\points::giveunifiedpoints(var_0, undefined, undefined, 1);

  if(isDefined(self.awardsthislife[var_0]))
    self.awardsthislife[var_0]++;
  else
    self.awardsthislife[var_0] = 1;

  _id_12558(var_0);
}

_id_1263D() {
  if(_id_125F0())
    _id_126BF();
}

_id_12604() {
  _id_12321();
  self.prevweaponobj = undefined;
  var_0 = scripts\mp\class::loadout_getclassstruct();
  var_0 = scripts\mp\class::loadout_updateclass(var_0, "_encstr_AAAC09D09972B9C83F2B7F");
  scripts\mp\class::preloadandqueueclassstruct(var_0, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "_encstr_AAAC09D09972B9C83F2B7F", 1, 1);
  self givestartammo(var_0.loadoutprimaryobject);
  self givestartammo(var_0.loadoutsecondaryobject);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD", 200, 0);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
  self notify("_encstr_B2110C63C02DC5E92388229F9D75");
  _id_125DF();
}

vehicle_occupancy_mp_onentervehicle(var_0, var_1, var_2, var_3) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onentervehicle(var_0, var_1, var_2, var_3);

  if(var_2 _id_125F0())
    var_2 setcamerathirdperson(0);
}

vehicle_occupancy_mp_onexitvehicle(var_0, var_1, var_2, var_3) {
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_onexitvehicle(var_0, var_1, var_2, var_3);

  if(!istrue(var_3.playerdisconnect) && !istrue(var_3.playerdeath) && var_2 _id_125F0())
    var_2 setcamerathirdperson(1, var_2._id_13B30, var_2._id_13B2F);
}

droponplayerdeath(var_0) {
  if(istrue(level.usegulag) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
    return 1;

  if(_id_125F0())
    return 1;

  return 0;
}

remove_on_death() {
  var_0 = scripts\engine\utility::array_randomize(level.players);
  var_1 = level._id_12315.settings._id_11F3D;

  if(level.players.size < var_1)
    var_1 = 1;

  var_2 = 0;
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_0) {
    if(var_2 < var_1)
      var_3[var_3.size] = var_6;
    else
      var_4[var_4.size] = var_6;

    var_2++;
  }

  thread _id_13253(var_3);
  thread _id_13267(var_4);
  return var_3;
}

_id_12562() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_AD75063D571AE108");
  waittillframeend;
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::stop_player_trigger_monitor();
}

_id_13253(var_0) {
  if(!istrue(level.br_infils_disabled)) {
    scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
    waitframe();
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 _id_125F0()) {
      var_2 _id_126BF();
      var_2 _id_12321();
      var_2.forcespawnorigin = var_2.origin;
      var_2.forcespawnangles = var_2.angles;
      var_2 thread _id_12562();
    }

    if(istrue(level.br_infils_disabled)) {
      var_2 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
      var_2 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(var_2, "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD", 200, 0);
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(var_2);
      var_2 notify("_encstr_B2110C63C02DC5E92388229F9D75");
    }
  }
}

revive_txt_hint() {
  if(!isDefined(level._id_12315.settings._id_12A08))
    level._id_12315.settings._id_12A08 = randomint(level._id_12315._id_11975.size);
  else
    level._id_12315.settings._id_12A08 = (level._id_12315.settings._id_12A08 + 1) % level._id_12315._id_11975.size;

  var_0 = level._id_12315._id_11975[level._id_12315.settings._id_12A08];
  return var_0;
}

revive_wounded_in_handler(var_0, var_1) {
  var_2 = 10;
  var_3 = 200.0;
  var_4 = 100.0;
  var_5 = 10.0;
  var_6 = 360.0 / var_2;
  var_7 = int(var_0 / var_2);
  var_8 = var_0 - var_7 * var_2;
  var_9 = var_8 * var_6 + var_7 * var_5;
  var_10 = var_3 + var_7 * var_4;
  var_11 = (0.0, var_9, 0.0);
  var_12 = anglesToForward(var_11);
  var_13 = var_1 + var_12 * var_10;
  var_13 = getgroundposition(var_13, 15, 12000, 12000);
  return var_13;
}

_id_126C4(var_0) {
  self cancelmantle();
  self setOrigin(var_0, 1);
}

_id_14362(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::neurotoxin_damage_loop();

    if(!var_2 _id_125F0()) {
      var_2 _id_126BF();
      var_2.forcespawnorigin = var_2._id_1290F;
      var_2 thread _id_12562();
    } else if(!isalive(var_2)) {
      var_2.forcespawnorigin = var_2._id_1290F;
      var_2 _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::stop_player_trigger_monitor();
    } else {
      var_2 _id_126C4(var_2._id_1290F);
      var_2.br_infilstarted = 1;
      var_2 _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_128DA(1);
      var_2 _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_1290A(int(level._id_12315.settings._id_128DB));
      var_2 _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_13177(var_2.initplayerplunderevents);
      var_2 _encstr_A13C289BC6E4B4C1479B97B5C1BCD916D62BA39783ACE697FA1C4EF6E0BEC6B7B9479CDB8DB98B76CD8D::_id_13177("_encstr_A59506C0242F4887");
    }

    var_2 notify("_encstr_BEBC0A21371738404846EFF1");
  }
}

_id_13267(var_0) {
  var_1 = revive_txt_hint();
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 scripts\mp\utility\player::hidehudenable();
    var_5 = revive_wounded_in_handler(var_2, var_1.origin);
    var_4._id_1290F = var_5;
    var_2++;

    if(var_2 >= level._id_12315.settings._id_11F42) {
      var_1 = revive_txt_hint();
      var_2 = 0;
    }
  }

  var_7 = 1;
  var_8 = 1.5;
  var_9 = 1;
  thread _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::infilallfadetoblack(var_7, var_8, var_9, "_encstr_B2741680EEC53387D3C21BF83223859F520AD8786F1B5FA1", var_0, 1);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 predictstreampos(var_4._id_1290F, 1);
  }

  wait(var_7);
  waitframe();
  handleriotshielddamage();
  _id_14362(var_0);
  level notify("_encstr_B2741680EEC53387D3C21BF83223859F520AD8786F1B5FA1");
  wait(var_8);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 clearpredictedstreampos();
    var_4 _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::neurotoxin_damage_loop();

    if(_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_4.hidehudenabled) > 0)
      var_4 scripts\mp\utility\player::hidehuddisable();

    var_4.delay_explosion_fx = 1;
  }

  scripts\mp\flags::gameflagset("_encstr_96831103CA05F13FAFB89252C5B9B0CB77F315");
}

timeoutplunderextractionsites(var_0, var_1, var_2, var_3) {
  var_4 = getmaxobjectivecount(var_1, var_2, var_3);
  var_4 setmapcirclecolorindex(4);
  var_4 hide(1);
  var_4.inuse = 0;
  var_4.count = 0;
  var_4.name = var_0;
  var_4.radius = var_3;
  var_4._id_129E5 = var_3 * var_3;
  var_5 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_4.objectiveiconid = var_5;

  if(var_5 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_5, "_encstr_930B07BB1B6B3854FF", (0, 0, 0), "_encstr_953025EAD2D7B51CFA4C4EFAB1DEB6382CE6E6F55AC6B7B9EBE2D5B29B8EBE58DC9B16B9DC96E6");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_5, 1);
    objective_showtoplayersinmask(var_5);
    scripts\mp\objidpoolmanager::update_objective_position(var_5, (var_1, var_2, 0));
  }

  level._id_12315._id_11975[level._id_12315._id_11975.size] = var_4;
}

toma_strike() {
  level._id_12315._id_128DE = [];
  var_0 = level.maxteamsize - level._id_12315.settings._id_11F3D;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level._id_12315._id_128DE[var_1] = getmaxobjectivecount(0, 0, 500);
    level._id_12315._id_128DE[var_1] setmapcirclecolorindex(1);
    level._id_12315._id_128DE[var_1] hide(1);
    level._id_12315._id_128DE[var_1].inuse = 0;
    level._id_12315._id_128DE[var_1].count = 0;
    level._id_12315._id_128DE[var_1].radius = 500;
    level._id_12315._id_128DE[var_1]._id_129E5 = 250000;
  }
}

_id_1386D() {
  var_0 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];

  while(level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"].size == 0)
    waitframe();

  for(;;) {
    var_1 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

    if(isDefined(level._id_12315.payload))
      var_1 = level._id_12315.payload;

    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_128F8)) {
        var_4 = level._id_12315._id_11975[var_3._id_128F8];
        var_5 = distance2dsquared(var_4.origin, var_3.origin);

        if(var_5 <= var_4._id_129E5)
          continue;
        else
          var_3 _id_12907();
      } else if(isDefined(var_3._id_128DD)) {
        var_6 = level._id_12315._id_128DE[var_3._id_128DD];
        var_5 = distance2dsquared(var_6.origin, var_3.origin);

        if(var_5 > var_6._id_129E5)
          var_3 _id_12906();
      }

      var_7 = undefined;
      var_8 = undefined;

      for(var_9 = 0; var_9 < level._id_12315._id_11975.size; var_9++) {
        var_4 = level._id_12315._id_11975[var_9];
        var_5 = distance2dsquared(var_4.origin, var_3.origin);

        if(var_5 <= var_4._id_129E5 && (!isDefined(var_8) || var_5 < var_8)) {
          var_8 = var_5;
          var_7 = var_9;
        }
      }

      if(isDefined(var_7)) {
        if(isDefined(var_3._id_128DD))
          var_3 _id_12906();

        var_3 _id_128D6(var_7);
        continue;
      }

      if(!isDefined(var_3._id_128DD))
        var_3 _id_128D5();
    }

    waitframe();
  }
}

_id_128EC() {
  if(isDefined(self._id_128F8))
    return level._id_12315._id_11975[self._id_128F8].name;

  return "_encstr_9A19040BCDBC";
}

_id_128D6(var_0) {
  self._id_128F8 = var_0;
  var_1 = level._id_12315._id_11975[var_0];
  var_1.count++;

  if(var_1.count == 1) {
    var_1.inuse = 1;
    var_1 show();
    scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1.objectiveiconid, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  }
}

_id_12907() {
  var_0 = self._id_128F8;
  var_1 = level._id_12315._id_11975[var_0];
  var_1.count--;

  if(var_1.count == 0) {
    var_1.inuse = 0;
    var_1 hide(1);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1.objectiveiconid, undefined);
  }

  self._id_128F8 = undefined;
}

_id_128D5() {
  var_0 = reset_motionblur();
  self._id_128DD = var_0;
  var_1 = level._id_12315._id_128DE[var_0];
  var_1.count++;

  if(var_1.count == 1) {
    var_1.inuse = 1;
    var_1 show();
    var_1._id_129E5 = 250000;
  }

  var_2 = (self.origin[0], self.origin[1], 500);
  var_2 = var_2 + scripts\engine\math::random_vector_2d() * randomfloatrange(0, 500);
  var_1.origin = var_2;
}

reset_motionblur() {
  for(var_0 = 0; var_0 < level._id_12315._id_128DE.size; var_0++) {
    var_1 = level._id_12315._id_128DE[var_0];

    if(!var_1.inuse)
      return var_0;
  }
}

_id_12906() {
  var_0 = self._id_128DD;
  var_1 = level._id_12315._id_128DE[var_0];
  var_1.count--;

  if(var_1.count == 0) {
    var_1.inuse = 0;
    var_1 hide(1);
  }

  self._id_128DD = undefined;
}
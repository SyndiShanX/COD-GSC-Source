/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\matchrecording.gsc
***********************************************/

init() {
  var_0 = matchrecording_getrecordingtype();

  if(!matchrecording_validaterecordingtype(var_0))
    return;
  else
    level.matchrecording_type = var_0;

  level.matchreceventcountline = 0;
  level.matchrecevents = [];
  level.matchrecording_logevent = ::matchrecording_logevent;
  level.matchrecording_logeventmsg = ::matchrecording_logeventmsg;
  level.matchrecording_logeventplayername = ::matchrecording_logeventplayername;
  level.matchrecording_dump = ::matchrecording_dump;
  level.matchrecording_generateid = ::matchrecording_generateid;
  level.matchrecording_usereventthink = ::matchrecording_usereventthink;

  if(level.matchrecording_type == 1)
    matchrecording_glog_addheader();
  else if(level.matchrecording_type == 3)
    matchrecording_scriptdata_openfileaddheader(1);

  level thread matchrecording_logallplayerposthink();
  level thread matchrecording_onplayerconnect();
  level thread matchrecording_loggameendstats();
  level thread matchrecording_vehiclewatcher("_encstr_B49F1E79968B0FC8B22FA8D06BFCA05D02B1E47EED73CD71B70B90E02F13D8F3", "_encstr_851A0F87FDA8035994099988F069B16951");
  level thread matchrecording_vehiclewatcher("_encstr_823524DA0BA31B86E4951BBDE4195A739DAF37ADC2B1637D9D27DED5378CAFB3CA1A966CB1AC", "_encstr_957715FF4097A9E951C7DDEF3DCD71E863781424C8DB75");
  level thread matchrecording_vehiclewatcher("_encstr_993D15DA0BE1DEA3B3459387E6596F257F59934278BD17", "_encstr_99D10EE96161FEE756AFE76994FFC9DF");
  level thread matchrecording_vehiclewatcher("_encstr_AA67171FA023D3325D0D1E15EE297A96E9E9AF93385B182A75", "_encstr_854410E331D9B2EB0DFF49A165F3C73E9983");
}

matchrecording_getrecordingtype() {
  if(scripts\mp\utility\game::lpcfeaturegated() && scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B")
    return 0;

  var_0 = getdvarint("_encstr_91CE14B346F5F99A783D13B00F45DADEBDF3412B8397", 0);

  if(var_0 == 0 && getdvarint("_encstr_87DB0A4951500F2347D3742B", 0) == 1)
    var_0 = 1;
  else if(drawentitybounds())
    var_0 = 1;

  return var_0;
}

matchrecording_validaterecordingtype(var_0) {
  var_1 = 1;

  if(var_0 == 0)
    var_1 = 0;
  else if(var_0 < 0 || var_0 > 4)
    var_1 = 0;
  else if(var_0 == 3 || var_0 == 4) {
    var_2 = 0;

    if(!var_2)
      var_1 = 0;
  } else if(var_0 == 1 || var_0 == 2) {
    var_3 = getdvarint("_encstr_87DB0A4951500F2347D3742B", 0);
    var_4 = drawentitybounds();
    var_1 = var_3 == 1 || var_4 == 1;
  }

  return var_1;
}

matchrecording_isenabled() {
  return isDefined(level.matchrecording_type) && level.matchrecording_type > 0;
}

matchrecording_teammap(var_0) {
  if(isDefined(level.teambased) && !level.teambased)
    var_1 = 2;
  else if(!isDefined(var_0) || var_0 == "_encstr_9A8507BA4040188D08")
    var_1 = 2;
  else
    var_1 = 3;

  return var_1;
}

matchrecording_eventcharmap(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_8F0D0582821542":
      var_1 = "_encstr_A64C0223";
      break;
    case "_encstr_8E8A06779997417E":
      var_1 = "_encstr_B24C02EF";
      break;
    case "_encstr_AD75062D5F18A10C":
      var_1 = "_encstr_A14C02D1";
      break;
    case "_encstr_A6260721AA98982A51":
      var_1 = "_encstr_8B4C024C";
      break;
    case "_encstr_8E440A150BA013A76A943DE4":
      var_1 = "_encstr_934C02B2";
      break;
    case "_encstr_A28407059C3442D329":
      var_1 = "_encstr_A24C0281";
      break;
    case "_encstr_B60A0BC8A93925F9E1A13365EF":
      var_1 = "_encstr_A54C0259";
      break;
    case "_encstr_AB9912D996470C8C37DCF98C81078D0C91C3CD11":
      var_1 = "_encstr_B44C0203";
      break;
    case "_encstr_820710B9253DA8D7D0D993854B8FBBAB53DB":
      var_1 = "_encstr_8C4C0209";
      break;
    case "_encstr_AB0E079126823AF505":
      var_1 = "_encstr_994C0238";
      break;
    case "_encstr_990E0723C405747D21":
      var_1 = "_encstr_8B4C0248";
      break;
    case "_encstr_9B0E078C13821DD70D":
      var_1 = "_encstr_834C02D0";
      break;
    case "_encstr_830E07C8980A3AAF11":
      var_1 = "_encstr_A14C02D5";
      break;
    case "_encstr_8B0E07C8130A3AAF2A":
      var_1 = "_encstr_934C02A2";
      break;
    case "_encstr_8B0E07C8130A3AAF81":
      var_1 = "_encstr_934C0218";
      break;
    case "_encstr_860E0764ECC777B9FA":
      var_1 = "_encstr_A34C02BB";
      break;
    case "_encstr_A50E0735ED4139A82F":
      var_1 = "_encstr_A74C0222";
      break;
    case "_encstr_8D0E07D821F7413F13":
      var_1 = "_encstr_A14C023B";
      break;
    case "_encstr_AF0E07A4C48F652F9B":
      var_1 = "_encstr_AC4C024A";
      break;
    case "_encstr_97C20D2ED88F670D41C8D10920AB7B":
      var_1 = "_encstr_B24C026F";
      break;
    case "_encstr_ADD1073811F11921A9":
      var_1 = "_encstr_8D4C023D";
      break;
    case "_encstr_8B020E7CD08771AD7DF8E10691210985":
      var_1 = "_encstr_AD4C0212";
      break;
    case "_encstr_96BD144C30DF1081E7FE2305D15E79D17F692715580F":
      var_1 = "_encstr_864C0253";
      break;
    case "_encstr_835E0F1C85CF89E3F1700AB73084354B67":
      var_1 = "_encstr_B14C02D5";
      break;
    case "_encstr_93BC0988A4EC2F82F9E33C":
      var_1 = "_encstr_9B4C023E";
      break;
    case "_encstr_B1540CE97B58E3790A89AC4525C5":
      var_1 = "_encstr_AF4C0273";
      break;
    case "_encstr_AD3D1221519AA2BE6AA01475277DA03189A48A4D":
      var_1 = "_encstr_BE4C0295";
      break;
    case "_encstr_91AC10BECFA9317EC3CB89C14B3775E1D0E2":
      var_1 = "_encstr_B14C0279";
      break;
    case "_encstr_851A0F87FDA8035994099988F069B16951":
      var_1 = "_encstr_A74C0257";
      break;
    case "_encstr_957715FF4097A9E951C7DDEF3DCD71E863781424C8DB75":
      var_1 = "_encstr_A74C0277";
      break;
    case "_encstr_99D10EE96161FEE756AFE76994FFC9DF":
      var_1 = "_encstr_B44C020E";
      break;
    case "_encstr_854410E331D9B2EB0DFF49A165F3C73E9983":
      var_1 = "_encstr_8C4C0258";
      break;
    default:
      break;
  }

  return var_1;
}

matchrecording_getfileheaderarray() {
  var_0 = [];
  var_0[var_0.size] = "_encstr_8A6A0F0F5B935636BEB91D164E3A7C8028";
  var_0[var_0.size] = "_encstr_B4070C317393C51B47CB895F5DF0" + level.script + "_encstr_AD4C02A0";
  var_0[var_0.size] = "_encstr_A16D121CA9538FCEAF30122AD857C337CB0596B8" + scripts\mp\utility\game::getgametype() + "_encstr_AD4C02A0";
  var_0[var_0.size] = "_encstr_8AC219A27D5A2B9EC1AFAD83EB1BC850E5175AA9AA9141D30EE32D";
  var_0[var_0.size] = "_encstr_8F071F2A1A521BB9A785DC5D96D3E6D17F52B25261262194CF9BF75747134187FC";
  var_0[var_0.size] = "_encstr_A2911FC3B5E4CAB1D759B3ACE61D7D46AC997C028205A242D711A214A209014650";
  var_0[var_0.size] = "_encstr_8FAA209CA072378027E70B273335F76DAFC1BA4FF9C9192406951D946CF399F68335";
  var_0[var_0.size] = "_encstr_83842309B1ED5A73FE30FBBF40B31712AB5CF186B733819006297B73298CD30827F0FE4F32";
  var_0[var_0.size] = "_encstr_826B1B3C11DA69BB21A77397F30301B461B6A7A8B0F82BB84F028658B4";
  var_0[var_0.size] = "_encstr_A93E2BE16B932BC67D59D959E63AF519B266C7013A8A728A49251ABE26A439A810360423A6A90B185806B06050";
  var_0[var_0.size] = "_encstr_82B12FEC0B408F5770498BA2303D6F072BF57678E7511DB79EE4D0099C8B73378217E0D26B8A4DA215131E176BCC32A28B";
  var_0[var_0.size] = "_encstr_8C692F42120B0DA061D5456BF6937945FF3A8A39580F20D94A813727CC34398D9221D1F3C7A659AA0DD2D3FB44B2BA7D92";
  var_0[var_0.size] = "_encstr_9AFB4A9ACAD3A508D96DED339EFB21FD57D26291F0677861A2698F4F91EDA9247F4E05098A7B17B80E16F927A19E580997929DA992935B905A7EF12FC96633C13F0A15D13BDF8E82B30FE3CD";
  var_0[var_0.size] = "_encstr_BADC4AB253DB5D2BDFA13387D89397F429824A0E6F54088FE94B680981CC377130CA690A1CC839B20E1DD4AF907EDFFD7248EEA95D783253C2564B9892C11541AE3965DBC3C8D0BA4B77371C";
  var_0[var_0.size] = "_encstr_85F54A81C5BB53F9CF1F3050CB1CB69912AF3807D7A07D65EA8791897F0D0D87B8C60E9FF78AEBE9A3023050C738211982BF96B7CD62A3917B6A3858AFD079A12A271ECF206A5FB04477A80B";
  var_0[var_0.size] = "_encstr_910421EF8F1B3B9371787EC55A33C76F0FCB12B11FF361D9452F87E89C5CF133329BFC";
  var_0[var_0.size] = "_encstr_99154079131BC523C79D2BE858F3E0A3326CCEAF15EF20A5B2BB65A199E756EF5FBFA1BE32A929F9E180B571196F107D64BF33B66CB809379609BB2B10258348D81C";
  var_0[var_0.size] = "_encstr_8F9C4A379815B7670E6DAEB5F033CFBF53B89F6E39D7E75FA455B39B0F7D6F56032226E4B8E1A7E7D83DC8B3AF419F8D0FBAEAAA8025DF2A598D83D148A98A56537016E31093D373402ED8BA";
  var_0[var_0.size] = "_encstr_87DA29BF6D93E9E7409F5643EA2380F937EACAB6C4970F017C194E314778A55E434E3E7886EDDA1A09266C";
  var_0[var_0.size] = "_encstr_999E344C3D132F1669D7C407A2F35FF485BFCA1653586F890FC797E1B6874D6A9B2E9A45FFCD450F8FD34D9D430FB14DC75736494FB2";
  var_0[var_0.size] = "_encstr_AD882A09A0D69129D9C7A3398DAB77F1981697CA2C1D8479D5DB21D9637595A98662FAE94760D57A7A3DDA3C";
  var_0[var_0.size] = "_encstr_93A6203998A0551A88EBC387D5C5018CF00131A697E939F1ED9D5F337371E880F024";
  var_0[var_0.size] = "_encstr_AF0D3699E543215741CA108052A377597796E01F67278CD3FA10814958B583F52F78E287DA4F93C9926B98BB025EE1E837A55608241F99FD";
  var_0[var_0.size] = "_encstr_81E2345CBBF03FE7C0D91BD240ADDFB79005E6C877218D276E7440798C19DF2739710E5055980A2BB64B7AE37047F364F0C5BC9FEB0B";
  var_0[var_0.size] = "_encstr_B8A85AD11F8B1DA8E7E70B614D9411C5528B5D715F544051C2F4D53EBC45299C08FA17F9533AAF3003053B315E1060BE4237CD892BF2E340236D01CD0534D87D3BF261078F4E3C4077036861A3E588A35203CBD34362FEEA849FB1B4";
  var_0[var_0.size] = "_encstr_BAFD64F0B69359D8FA2B3B2B7347F5C859661F08D151C9A22929D0F5255350D1A808EC0213D8C29B6D71E8CE2C406ED6858D1BE893F6EA9B91CA56345A8D36B2141BD8B42B3771473B58109BD62CD88D8E27B7EACDC8952B1A4B8DC6CA0A3CD2DCC547CE0BA0";
  var_0[var_0.size] = "_encstr_AD9D4E0A5F9A4927298FF47525F31711F51B82624F05E49321BC7610F458F3BD7D9AB9DA33F4598D9A8DE504D666FF0D8F738378EBB13051C2475EB86B4AC3C1EBEB70484B2D4B43FB6C56B043620B3C";
  var_0[var_0.size] = "_encstr_A64F4A4155AA189E5772D3B9EAD358C887B6BDF1E7DF09C51BA84DE660EF1F99D748E5696AFDC8A8D7B6A3E9CA32BF38766E1B231C2540656F8EBB11D20A77708EF6939BA0CCC8181BF211B4";
  return var_0;
}

matchrecording_logevent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_9 = matchrecording_teammap(var_1);
  var_10 = int(var_3) + "_encstr_964C0249" + int(var_4);
  var_11 = matchrecording_eventcharmap(var_2);

  if(var_2 == "_encstr_A6260721AA98982A51" || var_2 == "_encstr_B60A0BC8A93925F9E1A13365EF" || var_2 == "_encstr_AB9912D996470C8C37DCF98C81078D0C91C3CD11" || var_2 == "_encstr_820710B9253DA8D7D0D993854B8FBBAB53DB") {}

  var_12 = "_encstr_B40101";

  if(isDefined(var_6))
    var_12 = "_encstr_BE1704019B47" + var_6;

  var_13 = "_encstr_B40101";

  if(isDefined(var_7) && isDefined(var_8))
    var_13 = "_encstr_974C0246" + int(var_7) + "_encstr_964C0249" + int(var_8);

  var_14 = "_encstr_854C021F" + var_0 + "_encstr_974C0246" + var_9 + "_encstr_974C0246" + var_11 + "_encstr_974C0246" + var_10 + "_encstr_974C0246" + var_5 + var_13 + var_12;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_14;
}

matchrecording_logeventmsg(var_0, var_1, var_2) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_3 = matchrecording_eventcharmap(var_0);

  if(var_2 != "_encstr_B40101") {
    if(!isDefined(var_2))
      var_2 = "_encstr_B40101";
    else
      var_2 = "_encstr_BE0703F6EE" + var_2 + "_encstr_814C02E9";
  }

  var_4 = "_encstr_82E9063E03800308" + var_3 + "_encstr_974C0246" + var_1 + var_2;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_4;
}

matchrecording_logeventplayername(var_0, var_1, var_2) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_3 = matchrecording_teammap(var_1);
  var_4 = matchrecording_eventcharmap("_encstr_B1540CE97B58E3790A89AC4525C5");
  var_5 = "_encstr_854C021F" + var_0 + "_encstr_974C0246" + var_3 + "_encstr_974C0246" + var_4 + "_encstr_974C0246" + "_encstr_814C02E9" + var_2 + "_encstr_814C02E9";
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_5;
}

matchrecording_inceventlinecount() {
  level.matchreceventcountline++;

  if(level.matchrecevents.size == 0) {
    level.matchrecevents[level.matchrecevents.size] = "_encstr_A5040FE1D6E42B8D7D2BCE5673D1DCF810";
    level.matchreceventcountline = 0;
  } else if(level.matchreceventcountline > 30 || level.matchrecevents[level.matchrecevents.size - 1].size > 800) {
    if(level.matchrecording_type == 1 || level.matchrecording_type == 3)
      matchrecording_dump();

    level.matchrecevents[level.matchrecevents.size] = "_encstr_A5040FE1D6E42B8D7D2BCE5673D1DCF810";
    level.matchreceventcountline = 0;
  }
}

matchrecording_dump() {
  if(!matchrecording_isenabled()) {
    return;
  }
  if(!isDefined(level.matchrecevents) || level.matchrecevents.size == 0) {
    return;
  }
  switch (level.matchrecording_type) {
    case 2:
    case 1:
      matchrecording_glog_dump();
      break;
    case 4:
    case 3:
      matchrecording_scriptdata_dump();
      break;
    default:
      break;
  }
}

matchrecording_glog_dump() {
  if(level.matchrecording_type == 2)
    matchrecording_glog_addheader();

  foreach(var_1 in level.matchrecevents) {
    logprint(var_1 + "_encstr_AD4C02A0");

    if(drawentitybounds())
      analyticsstreamerlogfiletagplayer(var_1 + "_encstr_AD4C02A0");
  }

  level.matchrecevents = [];
}

matchrecording_glog_addheader() {
  var_0 = matchrecording_getfileheaderarray();

  foreach(var_2 in var_0) {
    logprint(var_2);

    if(drawentitybounds())
      analyticsstreamerlogfiletagplayer(var_2);
  }
}

matchrecording_scriptdata_openfilewrite() {}

matchrecording_scriptdata_openfileappend() {}

matchrecording_scriptdata_openfileaddheader(var_0) {}

matchrecording_scriptdata_dump() {}

matchrecording_logallplayerposthink() {
  if(!matchrecording_isenabled()) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      var_4 = gettime();

      if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3)) {
        matchrecording_logevent(var_3.clientid, var_3.team, "_encstr_8F0D0582821542", var_3.origin[0], var_3.origin[1], var_4);
        waitframe();
      }
    }

    wait(max(level.framedurationseconds, 1.5 - (gettime() - var_0) / 1000));
  }
}

matchrecording_onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread matchrecording_usereventthink();
  }
}

matchrecording_loggameendstats() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0.0;
  var_3 = 0;
  var_4 = 0.0;

  foreach(var_6 in level.players) {
    if(isDefined(var_6._id_1338F))
      var_0 = var_6._id_1338F;

    if(isDefined(var_6.nuke_explposstruct))
      var_3 = var_6.nuke_explposstruct;

    if(isDefined(var_6.nuke_hostmigration_waitlongdurationwithpause))
      var_4 = var_6.nuke_hostmigration_waitlongdurationwithpause;
  }

  if(var_3 > 0) {
    matchrecording_logeventmsg("_encstr_93BC0988A4EC2F82F9E33C", gettime(), "_encstr_A6801B9F93AFEBBE6FDBC7D368C7A1285F67406EC0E856102ACE933A3E" + var_0 / var_3 * 100.0 + "_encstr_B24C02B6");
    matchrecording_logeventmsg("_encstr_93BC0988A4EC2F82F9E33C", gettime(), "_encstr_AB891950ECECC502A8E69DB0D959B5CADCA3013156373BD143A310" + var_4 / var_3 / 1000.0 + "_encstr_B24C02EF");
  }

  if(isDefined(level.frontlineinfo) && isDefined(level.frontlineinfo.uptime) && isDefined(level.frontlineinfo.downtime)) {
    var_8 = level.frontlineinfo.uptime + level.frontlineinfo.downtime;

    if(var_8 > 0.0)
      matchrecording_logeventmsg("_encstr_93BC0988A4EC2F82F9E33C", gettime(), "_encstr_B85B139193DBCDD1B12D735610AA1C3AA5DAB24708" + level.frontlineinfo.uptime / var_8 * 100.0 + "_encstr_B24C02B6");
  }
}

matchrecording_usereventthink() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isai(self)) {
    return;
  }
  self notifyonplayercommand("_encstr_ADDD1581378FA9F5871273DE7AFBA578E3AF0739A13238", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_9727138C3FD8313F5659DBF1A12CB7B598F73D06B1", "_encstr_A6380E5AB0C61D4BED7337D87B8E0866");
  self notifyonplayercommand("_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3", "_encstr_B44609DFE707CF394E1651");

  for(;;) {
    self waittill("_encstr_ADDD1581378FA9F5871273DE7AFBA578E3AF0739A13238");
    var_0 = scripts\engine\utility::_id_143B4("_encstr_9727138C3FD8313F5659DBF1A12CB7B598F73D06B1", "_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3");

    if(var_0 == "_encstr_BE2A1D34E0B92F13AF681BC12BCD4FB3734087B5880153DCB7A1124B3825C3") {
      self iprintlnbold("_encstr_832F0D5DDBA2902BA6B8E807BC310D");
      matchrecording_logeventmsg("_encstr_835E0F1C85CF89E3F1700AB73084354B67", gettime(), self.name);
    }
  }
}

matchrecording_generateid() {
  if(!isDefined(game["_encstr_BD71169A6175DF4CC9AB0B1F9DA0D423145E2282EACD2F0F"]))
    game["_encstr_BD71169A6175DF4CC9AB0B1F9DA0D423145E2282EACD2F0F"] = 100;

  var_0 = game["_encstr_BD71169A6175DF4CC9AB0B1F9DA0D423145E2282EACD2F0F"];
  game["_encstr_BD71169A6175DF4CC9AB0B1F9DA0D423145E2282EACD2F0F"]++;
  return var_0;
}

matchrecording_vehiclewatcher(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill(var_0, var_2);
    var_2 matchrecording_vehicletrackingthink(var_1);
  }
}

matchrecording_vehicletrackingthink(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = matchrecording_generateid();

  if(!isDefined(self.team)) {
    iprintln("_encstr_ABD23B49F71023A12F0B1FFD42632D88E71A656E572373B94056306F14CF44F5F9106175F8200FE8152861AB7F7556DCE5E7083732F2BD372ABB68F32B");
    return;
  }

  if(!isDefined(self.origin)) {
    iprintln("_encstr_8B743D9C6E4C200B61DF9787AB2AC3F0F79608B91E8180945BB291BFE79694E0805C49C83FA4AAFEA29783835FEAF758346690E122101020CEBFDDA3377228");
    return;
  }

  thread matchrecording_vehiclecleanupthink(var_1, var_0);

  for(;;) {
    var_2 = scripts\engine\utility::ter_op(self.team == "_encstr_9A8507BA4040188D08", 1, 2);
    matchrecording_logevent(var_1, self.team, var_0, self.origin[0], self.origin[1], gettime(), var_2);
    wait 0.25;
  }
}

matchrecording_vehiclecleanupthink(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  matchrecording_logevent(var_0, "_encstr_9A8507BA4040188D08", var_1, 0, 0, gettime(), 0);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\vehicle_compass_cp.gsc
***********************************************/

init() {
  level.ismountdisabled = getdvarint("_encstr_8C27111AF16EB7BF91B710E151F0C7130469E3", 0) != 0;
  level.play_intel_collect_vo = getdvarint("_encstr_8A810AB9E929EB27648551BD", 1) != 0;
  level.getallactivequestsforteam = getdvarint("_encstr_B4CA0B19CBC12E11DB85F4AF7C", 1);

  if(!challengesenabled()) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

    if(isDefined(var_0) && (var_0 == "_encstr_B607038AAB" || var_0 == "_encstr_931D068662634370")) {
      level.getattractionomnvarbitpackinginfo = 1;
      level setupchallengelocales();
      level thread _id_13C45();
      _id_13223();
    }
  }
}

_id_13223() {
  var_0 = [];
  var_0["_encstr_A35D1A8FA106AA5690C07B03FE906801DDAB072F73239205F8A8225A"] = 1;
  var_0["_encstr_BD861ACD1CE42DE63A7BBAA3EBDCD0BE3A9C99ABB11B2CABE8F6064C"] = 1;
  level._id_132BD = var_0;
  var_1 = [];
  var_1["_encstr_86B01B90EBF32399876531B847E26B875AC299D0174A63107789452D5F"] = 1;
  var_1["_encstr_A1131BDE0E3AD26CAF9563BDFA1889D7C12DFAE8E49B56D65A0BBAD17B"] = 1;
  var_1["_encstr_8F9F18027019B4670E6DB4BF68BB767179C0892B928D6BEB63CD"] = 1;
  var_1["_encstr_A5C01860EF0BE2F961336A37D11A1B1F38FBFE0BBA0A6BDA8385"] = 1;
  var_1["_encstr_BE491BB70EA34B8DFA2B63F6FA0CC4BE38B4EB8EE44EB2CE7B8D67959C"] = 1;
  var_1["_encstr_86251BE02A43D14FC92028987F63DF50EF4C99C3E32D8583F262A3701E"] = 1;
  level._id_1237C = var_1;
}

turn_on_have_target_hud(var_0) {
  var_1 = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AA501282FAD89F4D8863A73A7B97D251D9B60568"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AA501282FAD89F4D8863A73A7B97D251D9B60568")]](var_0);

  if(isDefined(level._id_14580) && istrue(level._id_14580[var_1]))
    return 1;

  return 0;
}

setupchallengelocales() {
  var_0 = getDvar("_encstr_AF66148D6FD3A74F0F5831BBC87B492BA9C10D2BF5BB", level.mapname);
  level._encstr_8BD20F3B895045D3D5A0022A283F5BFC90 = 0;

  switch (var_0) {
    case "_encstr_AF690B8DE7364F0A17C0C3EA12":
    case "_encstr_A9690B5B38F5ACB98D2C0EACCC":
      level._encstr_8BD20F3B895045D3D5A0022A283F5BFC90 = 2;
      _id_11AD7();
      break;
    case "_encstr_A3F50BC8631F6D20CD64F7A155":
    case "_encstr_915C0C7813C1D1F09B1B80862882":
    case "_encstr_B1D508B607F591B7CD33":
    case "_encstr_8CD508CA98A70FAFC01D":
      level._encstr_8BD20F3B895045D3D5A0022A283F5BFC90 = 1;
      _id_11ADB();
      break;
    case "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319":
      level._encstr_8BD20F3B895045D3D5A0022A283F5BFC90 = 3;
      _id_11AD9();
      break;
    case "_encstr_8F340F3992796F28DFDFE808E736C1FF27":
      level._encstr_8BD20F3B895045D3D5A0022A283F5BFC90 = 4;
      _encstr_A575207D29C186431B954CB36DE092790F9F770975834297A0050BF20528670AF91A();
      break;
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      _id_11ADB();
      _id_11AD7();
      _id_11AD9();
      _encstr_A575207D29C186431B954CB36DE092790F9F770975834297A0050BF20528670AF91A();
      break;
    default:
      _id_11AD8(var_0);
      break;
  }
}

_encstr_8873122F83E896F3E7D0A23AB8CC1FCDA851A9B4() {
  if(isDefined(level._encstr_8BD20F3B895045D3D5A0022A283F5BFC90))
    return level._encstr_8BD20F3B895045D3D5A0022A283F5BFC90;

  return 0;
}

_id_11ADB() {
  level.localetriggers = [];
  var_0 = getEntArray("_encstr_B8EE102BE0F1C1E37B182D69FC0F1A9D5828", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }
      switch (var_2.script_noteworthy) {
        case "_encstr_967B0985969CCC2D561B19":
          var_2.localeid = 1;
          break;
        case "_encstr_A12309057F2275CBB14A51":
          var_2.localeid = 2;
          break;
        case "_encstr_828E06992D9960C5":
          var_2.localeid = 3;
          break;
        case "_encstr_A19407CB0D1807F441":
        case "_encstr_971804ED3712":
          var_2.localeid = 4;
          break;
        case "_encstr_883009BD28232B4B688B98":
          var_2.localeid = 5;
          break;
        case "_encstr_BAC106FFE6F8C842":
          var_2.localeid = 6;
          break;
        case "_encstr_9B220634456A5747":
          var_2.localeid = 7;
          break;
        case "_encstr_883E0978CAE2A1689B3161":
          var_2.localeid = 8;
          break;
        case "_encstr_A7FA0953BADCAD2F2C4E19":
          var_2.localeid = 9;
          break;
        case "_encstr_9BD70814BBB0A55B35C3":
          var_2.localeid = 10;
          break;
        case "_encstr_8E4107C6EA5B135939":
          var_2.localeid = 11;
          break;
        case "_encstr_8AB20C502A649DCBDF3EE7680BE7":
          var_2.localeid = 12;
          break;
        case "_encstr_8A710AB7EA47E6ADD24EA39B":
          var_2.localeid = 13;
          break;
        case "_encstr_920D05A20F2572":
          var_2.localeid = 14;
          break;
        case "_encstr_810D059BE07D8B":
          var_2.localeid = 15;
          break;
        case "_encstr_81B70AD2BFC95347B06893A7":
        case "_encstr_B49507136BBF0EA070":
          var_2.localeid = 16;
          break;
        case "_encstr_8F230B2AC1D5B2F8D8395957D9":
          var_2.localeid = 17;
          break;
        case "_encstr_AC390C9C2DEC9527F5E67B9C1DD0":
          var_2.localeid = 18;
          break;
        case "_encstr_97B00C27D2D9594EEB9BBDD5A31A":
          var_2.localeid = 19;
          break;
        case "_encstr_A77808BB284B9F27D3C1":
          var_2.localeid = 20;
          break;
        case "_encstr_85540C476130A3E140D973BDB320":
          var_2.localeid = 21;
          break;
        case "_encstr_AD0E1177E51620BE0B4B9E41F2937C086F44D1":
          var_2.localeid = 22;
          break;
        case "_encstr_B24F0E58DB786D42255B39172FCEF34B":
          var_2.localeid = 23;
          break;
        case "_encstr_AAE80C38F33E43E33BCB10F5B16F":
          var_2.localeid = 24;
          break;
        case "_encstr_B4741267F5E6D04EFB5B8EF1428705A07C6EC31D":
          var_2.localeid = 25;
          break;
        case "_encstr_B1FD117B4B7AB02602E78FE9FF7B6F2804268D":
          var_2.localeid = 26;
          break;
        case "_encstr_A33C0FDE3B428B133A9FB1C8EF516BFD9B":
          var_2.localeid = 27;
          break;
        case "_encstr_87A210D7B0515503ED96E1E27D931A01DBE8":
          var_2.localeid = 28;
          break;
        case "_encstr_92A70EBB835B75585EB30757DD82B8BE":
          var_2.localeid = 29;
          break;
        case "_encstr_A975102F1FEA7540BA020E636A6178AEB2E3":
          var_2.localeid = 30;
          break;
        case "_encstr_BEB406F03B72BB3B":
          var_2.localeid = 31;
          break;
        case "_encstr_8B410851CDC7EDE732ED":
          var_2.localeid = 32;
          break;
        case "_encstr_834E0AFD036B7C39A427F282":
          var_2.localeid = 33;
          break;
        case "_encstr_AAAB06A89862980B":
          var_2.localeid = 34;
          break;
        case "_encstr_950214E6D0F6E0832D73B37D23D2B9E8E42D6CA3D7AC":
        case "_encstr_99021473044FA01FBA8BF7FFDBC2E6C80ADCF92B61BF":
          var_2.localeid = 35;
          break;
        default:
          _id_11AD6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
  }
}

_id_11AD9() {
  level.localetriggers = [];
  var_0 = getEntArray("_encstr_B8EE102BE0F1C1E37B182D69FC0F1A9D5828", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }
      switch (var_2.script_noteworthy) {
        case "_encstr_967B0985969CCC2D561B19":
          var_2.localeid = 36;
          break;
        case "_encstr_8D9009B0964ECD1D4E5A07":
          var_2.localeid = 37;
          break;
        case "_encstr_8D9708AFC2079025B13D":
          var_2.localeid = 38;
          break;
        case "_encstr_B2280A3A935086C353C1623A":
          var_2.localeid = 39;
          break;
        case "_encstr_8BDC089661282C1206FB":
          var_2.localeid = 40;
          break;
        case "_encstr_8D0308D858C14BD15836":
          var_2.localeid = 41;
          break;
        case "_encstr_81AB066CB069AF22":
          var_2.localeid = 42;
          break;
        case "_encstr_BAC106FFE6F8C842":
          var_2.localeid = 43;
          break;
        case "_encstr_99E00710F71780B782":
          var_2.localeid = 44;
          break;
        case "_encstr_A56206DAA57359E6":
          var_2.localeid = 45;
          break;
        case "_encstr_AFC50B031F04EACA3020FE051B":
          var_2.localeid = 46;
          break;
        case "_encstr_BD7D0796D1CE57163B":
          var_2.localeid = 47;
          break;
        case "_encstr_B46A066BF3D0B56F":
          var_2.localeid = 48;
          break;
        case "_encstr_BA89073EAD46E7874A":
          var_2.localeid = 49;
          break;
        case "_encstr_B1B708EC8C1209E1AF57":
          var_2.localeid = 50;
          break;
        case "_encstr_85540C476130A3E140D973BDB320":
          var_2.localeid = 62;
          break;
        case "_encstr_828B0D99EC9D9050628FD7F19F0B8B":
          var_2.localeid = 63;
          break;
        default:
          _id_11AD6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
  }
}

_id_11AD7() {
  level.localetriggers = [];
  var_0 = getEntArray("_encstr_B8EE102BE0F1C1E37B182D69FC0F1A9D5828", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }
      switch (var_2.script_noteworthy) {
        case "_encstr_8F7A07C6AC0229C18A":
          var_2.localeid = 51;
          break;
        case "_encstr_A5B50AF95BF311E1D279E015":
          var_2.localeid = 52;
          break;
        case "_encstr_AD560B9E8089D38B13822BA08B":
          var_2.localeid = 53;
          break;
        case "_encstr_86B508A91DA668F6226B":
          var_2.localeid = 54;
          break;
        case "_encstr_83B00EE1371308401A074F432B329570":
          var_2.localeid = 55;
          break;
        case "_encstr_BD0208BE67B903152D08":
          var_2.localeid = 56;
          break;
        case "_encstr_8DE1070D169C137BC9":
          var_2.localeid = 57;
          break;
        case "_encstr_83510DF3324A6C29A5072323D360DA":
          var_2.localeid = 58;
          break;
        case "_encstr_84E2075B0179EF8E5B":
          var_2.localeid = 59;
          break;
        case "_encstr_B41E0A53B0F3C9E263986EE7":
          var_2.localeid = 60;
          break;
        case "_encstr_AC480657D870D2F2":
          var_2.localeid = 61;
          break;
        default:
          _id_11AD6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
  }
}

_encstr_A575207D29C186431B954CB36DE092790F9F770975834297A0050BF20528670AF91A() {
  level.localetriggers = [];
  var_0 = getEntArray("_encstr_B8EE102BE0F1C1E37B182D69FC0F1A9D5828", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }
      switch (var_2.script_noteworthy) {
        case "_encstr_828E06992D9960C5":
          var_2.localeid = 64;
          break;
        case "_encstr_925E061218F3F68B":
          var_2.localeid = 65;
          break;
        case "_encstr_9B8A0AA48A02FDA1718768D0":
          var_2.localeid = 66;
          break;
        case "_encstr_B1320CC370DBFD4E9F686B28B325":
          var_2.localeid = 67;
          break;
        case "_encstr_85A80920330FD3958AA747":
          var_2.localeid = 68;
          break;
        case "_encstr_8CF20F3827EF582F7ADB45CEB4F2BDC333":
          var_2.localeid = 69;
          break;
        case "_encstr_8F810B265A2AEDA455DE3018C3":
          var_2.localeid = 70;
          break;
        case "_encstr_B1960EC847BE202192698618BBDB4F28":
          var_2.localeid = 71;
          break;
        case "_encstr_88390E5379600810276F0829C1AA3845":
          var_2.localeid = 72;
          break;
        case "_encstr_B6410ED6353BA7890CCFC0D03F5A01D3":
          var_2.localeid = 73;
          break;
        case "_encstr_B4DA0B15BBDF926C1058FFFF10":
          var_2.localeid = 74;
          break;
        case "_encstr_967B0985969CCC2D561B19":
          var_2.localeid = 75;
          break;
        case "_encstr_AD7F0B26562C8D43FAAC16DCE8":
          var_2.localeid = 76;
          break;
        case "_encstr_B891058DED9DCA":
          var_2.localeid = 77;
          break;
        case "_encstr_B2EA07F3C85D27B35A":
          var_2.localeid = 78;
          break;
        case "_encstr_969F0A66F693E8FAAC166E8E":
          var_2.localeid = 79;
          break;
        case "_encstr_8E680BF3403BC3171B286D943C":
          var_2.localeid = 80;
          break;
        case "_encstr_83360A48C70AFBCF1B3FE66D":
          var_2.localeid = 81;
          break;
        case "_encstr_974C0A22A87E9B9908930518":
          var_2.localeid = 82;
          break;
        case "_encstr_8A6707D81AAB2736D0":
          var_2.localeid = 83;
          break;
        case "_encstr_B87008FF51B208959B2B":
          var_2.localeid = 84;
          break;
        case "_encstr_BA4B0EF35B285F17B939BB51C10777D2":
          var_2.localeid = 85;
          break;
        default:
          _id_11AD6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
  }
}

_id_11AD8(var_0) {
  if(var_0 == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE" || var_0 == "_encstr_A70810C368C1A0BC77D251996A67E08066C3" || var_0 == "_encstr_A3930F8FD35F7A396BA3D6614DF1A0B245" || var_0 == "_encstr_AD2B10B5E0EBA1ADB9969BC659EB8E56E61D") {
    return;
  }
  return;
}

_id_11AD6(var_0) {
  return;
}

challengesenabled() {
  return level.challengesallowed;
}

challengesenabledforplayer() {
  if(!challengesenabled())
    return 0;

  if(!isPlayer(self) || isai(self))
    return 0;

  if(istrue(level.getarenapickupattachmentoverrides))
    return 0;

  return 1;
}

relic_amped_is_there_valid_new_victim() {
  var_0 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

  if(!isDefined(var_0))
    var_0 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

  if(!isDefined(var_0))
    return 0;

  if(!isDefined(level.getallselectableattachments) || !isDefined(level.getallselectableattachments.game_type_col) || !isDefined(level.getallselectableattachments.game_type_col[var_0]))
    return 0;

  if(var_0 == "_encstr_B607038AAB") {
    if(getdvarint("_encstr_8FBE235AC0BF9B0D309F5A55FD08D28B539EF28208057F05D0C35367B728DE6B0D51098AB1", 0) && scripts\cp_mp\utility\game_utility::turretdisabled())
      return 95;

    var_1 = "_encstr_B40101";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A13E0F3BCAE8A9D5263AB0B595515E0756"))
      var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A13E0F3BCAE8A9D5263AB0B595515E0756")]]();

    switch (var_1) {
      case "_encstr_8AE1099A0B999F2D28AF15":
      case "_encstr_BE180419DAE9":
        return 99;
      case "_encstr_86370883AB0B76583B43":
        return 98;
      case "_encstr_816005BF2BE883":
        return 97;
      case "_encstr_9936086E0BB9324CDBC3":
        return 96;
      case "_encstr_AD51088015D1E2D47930":
      case "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95":
      case "_encstr_AD300C932B4C969CD1D0AF911346":
      case "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8":
      case "_encstr_A254085207A6B7334B5A":
        return 95;
      case "_encstr_A1D0081CC297B1EDB08C":
        return 94;
      case "_encstr_9286085A21B8034D3863":
        return 93;
      case "_encstr_866209ECEDB1197DEE0B4E":
        return 92;
      case "_encstr_AAEF05B85A86E9":
        return 91;
      case "_encstr_B607038AAB":
        break;
      default:
        break;
    }
  }

  return level.getallselectableattachments.game_type_col[var_0];
}

getatvspawns() {
  if(!istrue(level.getattractionomnvarbitpackinginfo))
    return 0;

  if(!challengesenabledforplayer())
    return 0;

  return 1;
}

_id_140DB(var_0) {
  if(!isDefined(self.getattachmentoverride))
    return 0;

  if(!isDefined(self.getattachmentoverride[var_0]))
    return 0;

  return 1;
}

_id_12C6E(var_0) {
  if(!getatvspawns()) {
    return;
  }
  if(!_id_140DB(var_0)) {
    return;
  }
  self.getattachmentoverride[var_0] = 0;
}

_id_1383B(var_0) {
  if(!getatvspawns()) {
    return;
  }
  if(!isDefined(self.getattachmentoverride))
    self.getattachmentoverride = [];

  if(!isDefined(self.getattachmentoverride[var_0]))
    self.getattachmentoverride[var_0] = 0;

  self.getattachmentoverride[var_0] = gettime();
}

_encstr_8EB11CDA80417E03B1A1FCED4899FF82B948731218C7F44FE919F7F550C3(var_0) {
  switch (var_0) {
    case "_encstr_B1A81263104592BBB74837413915989D6123EAE5":
      return getdvarint("_encstr_B2522D58F7F8780631490A2B3B0DE70FA19B89AEE0D539966B47ED10E581D0508337B1F5D04BE83FA22ED30BE2736F", 63360);
    case "_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3":
      return getdvarint("_encstr_9A3633C7C6DB69867C5EA2B9FD9870C70F820AC170BD116150BAFD78B3FFD322C49F61C96B22345F0AB9C8AFC4A01748D094F7DFD3", 19685);
    default:
      return -1;
  }
}

_encstr_8AB01AA86A229F0B9B3363EF04C3D1554FF22860C2FB3BA09F4D785D(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  var_2 = "_encstr_8CDA1F676F9E51C3D8B9959DD1730F0AE0979793C9469BB160C18CA90BE8515358" + var_0;
  var_3 = getdvarint(var_2, 0);

  if(var_3 > 0) {
    return;
  }
  var_4 = resetstuckthermite();
  var_5 = relic_amped_is_there_valid_new_victim();

  switch (var_0) {
    case "_encstr_9933089193CA642806B7":
      self reportchallengeuserevent("_encstr_88AD06120BDE0B17", var_4, var_5, var_1, 0, 0, 0, 0, 0, 0);
      break;
    case "_encstr_A9B10D16D8A53B2BEBB473F5D9C2CD":
      self reportchallengeuserevent("_encstr_88AD06120BDE0B17", var_4, var_5, 0, var_1, 0, 0, 0, 0, 0);
      break;
    case "_encstr_82A71120EA74DD99472EF07507F380971DC280":
      self reportchallengeuserevent("_encstr_88AD06120BDE0B17", var_4, var_5, 0, 0, var_1, 0, 0, 0, 0);
      break;
    case "_encstr_B1A81263104592BBB74837413915989D6123EAE5":
      self reportchallengeuserevent("_encstr_88AD06120BDE0B17", var_4, var_5, 0, 0, 0, var_1, 0, 0, 0);
      break;
    case "_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3":
      self reportchallengeuserevent("_encstr_88AD06120BDE0B17", var_4, var_5, 0, 0, 0, 0, var_1, 0, 0);
      break;
    case "_encstr_998A0668F36A3BD2":
      self reportchallengeuserevent("_encstr_88AD06120BDE0B17", var_4, var_5, 0, 0, 0, 0, 0, var_1, 0);
      break;
    case "_encstr_8F0508CE59DCA357392B":
      self reportchallengeuserevent("_encstr_88AD06120BDE0B17", var_4, var_5, 0, 0, 0, 0, 0, 0, var_1);
      break;
  }
}

_id_138D5(var_0) {
  if(!getatvspawns()) {
    return;
  }
  if(!_id_140DB(var_0)) {
    return;
  }
  if(self.getattachmentoverride[var_0] > 0) {
    var_1 = gettime() - self.getattachmentoverride[var_0];

    if(var_1 > 0)
      _encstr_8AB01AA86A229F0B9B3363EF04C3D1554FF22860C2FB3BA09F4D785D(var_0, var_1);

    self.getattachmentoverride[var_0] = 0;
  }
}

getextractionpadent(var_0, var_1) {
  if(!getatvspawns()) {
    return;
  }
  if(!_id_140DB(var_0)) {
    return;
  }
  if(self.getattachmentoverride[var_0] > 0) {
    var_2 = gettime() - self.getattachmentoverride[var_0];

    if(var_2 >= var_1) {
      _encstr_8AB01AA86A229F0B9B3363EF04C3D1554FF22860C2FB3BA09F4D785D(var_0, var_2);
      self.getattachmentoverride[var_0] = gettime();
    }
  }
}

_id_13C45() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(isDefined(level.players)) {
      var_0 = level.players.size;

      for(var_1 = 0; var_1 < var_0; var_1++) {
        if(isalive(level.players[var_1]))
          level.players[var_1] getextractionpadent("_encstr_9933089193CA642806B7", 60000);
      }
    }

    wait 1;
  }
}

_encstr_A56113CCB1ABDCD0368616C6B1CA73EC956EA30B8E(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2)) {
    return;
  }
  if(!isDefined(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0])) {
    return;
  }
  var_1 = int(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0]);
  self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0] = 0;
  _encstr_8AB01AA86A229F0B9B3363EF04C3D1554FF22860C2FB3BA09F4D785D(var_0, var_1);
}

_encstr_BA0411A5DC1BD8A1B01BD8B27376B237471647(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  if(!isDefined(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2))
    self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2 = [];

  if(!isDefined(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0]))
    self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0] = 0;

  self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0] = self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0] + var_1;

  if(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0] <= 0) {
    return;
  }
  var_2 = _encstr_8EB11CDA80417E03B1A1FCED4899FF82B948731218C7F44FE919F7F550C3(var_0);

  if(var_2 < 0) {
    return;
  }
  if(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0] >= var_2) {
    var_3 = int(self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0]);
    self._encstr_8E591350CA1689D8CF0ED4DD0B53A1717EA2D890B2[var_0] = 0;
    _encstr_8AB01AA86A229F0B9B3363EF04C3D1554FF22860C2FB3BA09F4D785D(var_0, var_3);
  }
}

_encstr_B476144DEC23E043FFEA49D092DF08087F6BE13B9C0A() {
  if(!challengesenabledforplayer()) {
    return;
  }
  _encstr_A56113CCB1ABDCD0368616C6B1CA73EC956EA30B8E("_encstr_B1A81263104592BBB74837413915989D6123EAE5");
  _encstr_A56113CCB1ABDCD0368616C6B1CA73EC956EA30B8E("_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3");
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_10 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0))
      var_1 = var_0;
    else
      return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")]](var_1.team, var_10)) {
      if(isDefined(var_5._id_121D9))
        var_5 = var_5._id_121D9;

      var_11 = _id_14583(var_5, var_1);
      init_sentry_traps(var_0, var_1, var_11, var_10, var_7, var_8, var_5, var_2, var_4, var_9);
    }
  }
}

_id_11FFC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_9 = self;
  var_10 = play_sound_from_closest_player(var_9);
  var_11 = _id_14583(var_5, var_1);

  if(var_10 == 2048 && level.getallactivequestsforteam == 8) {
    var_1 thread _id_14010();
    var_1 chooseanim_arrival_forcode(var_10, var_11[0], var_7, var_8, var_0, var_4);
  }
}

_id_12097(var_0, var_1) {
  if(level.getallactivequestsforteam >= 10) {
    if(var_0.staticdata.ref == "_encstr_A935120E5D9AA97D0177A390E88D93C7CC08C0F7" && !var_1)
      _id_12C3F("_encstr_958E4BD14EBEB11A7DD9D8ED13B0B17D8D0B1B1BF596E6D7360BC995BEC15836DA583B59EBDE93BEB1DB858CEDAB47FA4639F61C377DCCF69CFA7B0EAC9C8547BDE47DADD2DCCDB4B7B9EB370D", 1);
  }

  if(level.getallactivequestsforteam >= 10) {
    if(var_0.staticdata.ref == "_encstr_A935120E5D9AA97D0177A390E88D93C7CC08C0F7" && !var_1)
      _id_12C3F("_encstr_B48E4B8BB269F30A284FCBCFADEF92172001051516A0B6311E5B4BFFEF0F0A63B8E97FDF8E385209E16F0FF3E7B5A3E7A813F5E2A3610EC2C6772F9BEBDEBA0448BB612D1868C3FA903DE79F63", 1);
  }
}

chooseanim_arrival_forcode(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "_encstr_B40101";
  var_7 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D8516C9550B77083D13DB0832457BEF714BB4D9176042EF")) {
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D8516C9550B77083D13DB0832457BEF714BB4D9176042EF")]](var_1);

    if(isDefined(var_8))
      var_7 = var_8.defaultslot == "_encstr_BA7F0830B3A7859B60B0";
    else if(var_1 != "_encstr_81C80E0C79E00F3BF583FB8FF5B0C278")
      var_6 = weaponclass(var_1);
  } else if(var_1 != "_encstr_81C80E0C79E00F3BF583FB8FF5B0C278")
    var_6 = weaponclass(var_1);

  var_9 = var_5 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_4) && isDefined(var_4.vehiclename);

  if(var_2 & 1048576)
    _id_12C3F("_encstr_A7262F4772BEB10DF5ECC6DE4C851BF58E93EB773DD79EB6BE8D935A1D4BC6B0C6F5B596D88D377D99B79CF52BECACDCE8", 1);

  _id_12C3F("_encstr_B2632DC0D35E7750EEE18D5FFB3A9D9FC97128F4FAF148E859D298D739F02D284DCAA7F0C3C92CE8ABC11935D96D4D", 1);

  if(!isDefined(self._id_146C8))
    self._id_146C8 = 1;
  else
    self._id_146C8++;

  if(istrue(var_7))
    _id_12C3F("_encstr_888937A393D7C60DEB9D8DF6260B8DBE8E4EFABB3DEBA7B6EBC6951D1A858DD795B8BA4B386BCA9B1DF5DAA5631B9BFA33BDC9D756EC5637E8", 1);

  if(istrue(var_9))
    _id_12C3F("_encstr_AC41357047011FD09F8FD940628F989F33AFB1E0CBA96508C7A655CB71BFC0A351F2A0A8D27C954143D168304327496F42F910D8CA55E9", 1);

  if(self._id_146C8 >= 5 && !istrue(self.show_balloon_purchase_hint)) {
    _id_12C3F("_encstr_8DE7365461015250214FE91889792D018B3AA1B37327607BB1A09CCC0B6A1EA29CC8B5E8E7B7703AC286BA58B0956189D2A2E9CB7BC54663", 1);
    self.show_balloon_purchase_hint = 1;
  }

  if(var_6 == "_encstr_A1100738A33A638123")
    _id_12C3F("_encstr_9605351D4EAF6C86AF768DDB132C8DAF479CD7BBF47DE9B5EBDCA1F6A3B357B9D7B2D896DA5A37B047A57BB937BE99ED937DACB3B2DC47", 1);

  if(isDefined(self._id_12A8D) && self._id_12A8D == 2)
    _id_12C3F("_encstr_AA4A2B74631677EC4FD0222AC00BA5CF2B0BD70F5ABEAB75A768BB1218735CCFC01963AFFC4043B18BA8A22AA3", 1);

  if(var_6 == "_encstr_8D940738966ED1DB8D")
    _id_12C3F("_encstr_8E7B348E4ED7C6D0AF9D36BD4C0B8DEBA393EBBBD3EB4F5BFA07B49BA3B7C6EB56D8A5DAB4E62CD1B4DE9B6E7D33F69CD7B2D995DC3A", 1);

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex == 0)
    _id_12C3F("_encstr_95773B1B07EF3EC851E7A1AF0A0630E8EBBFF6E35B97EAA879FD59BB3D6C684F33524848533F2ED04FDF6DAB67D6A88E079A8116AA275EC9A7BE5B8554", 1);
}

_id_14010() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_97851803AB3B17A3C7CA5B4FE5EDC872EF927908422F5BB8DDC3");
  self endon("_encstr_97851803AB3B17A3C7CA5B4FE5EDC872EF927908422F5BB8DDC3");

  if(!isDefined(self._id_12A8D))
    self._id_12A8D = 1;
  else
    self._id_12A8D++;

  wait 4.0;
  self._id_12A8D = 0;
}

vehiclekilled(var_0, var_1, var_2, var_3, var_4) {
  if(!var_2 challengesenabledforplayer()) {
    return;
  }
  var_5 = var_0;

  if(isDefined(var_4._id_121D9))
    var_4 = var_4._id_121D9;

  var_6 = _id_14583(var_4, var_2);
  var_7 = "_encstr_BDB50C41D83F8F9F030B60E80F5B";
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;

  if(isDefined(var_2.modifiers)) {
    var_8 = var_2.modifiers["_encstr_87A205AF10734B"];
    var_9 = var_2.modifiers["_encstr_95A40617A8CBC38F"];
    var_10 = var_2.modifiers["_encstr_A2A406E139973007"];
  }

  init_sentry_traps(var_1, var_2, var_6, var_5, var_8, var_9, var_4, var_3, var_7, var_10);
}

equipmentdestroyed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0))
      var_1 = var_0;
    else
      return;
  }

  if(!isDefined(var_8.owner)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")]](var_1.team, var_8.owner)) {
      if(isDefined(var_5._id_121D9))
        var_5 = var_5._id_121D9;

      var_9 = _id_14583(var_5, var_1);
      var_10 = 0;
      var_11 = 0;
      var_12 = 0;

      if(isDefined(var_7)) {
        var_10 = var_7["_encstr_87A205AF10734B"];
        var_11 = var_7["_encstr_95A40617A8CBC38F"];
        var_12 = var_7["_encstr_A2A406E139973007"];
      }

      init_sentry_traps(var_0, var_1, var_9, var_8, var_10, var_11, var_5, var_2, var_4, var_12);
    }
  }
}

killstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!var_3 challengesenabledforplayer()) {
    return;
  }
  var_8 = self;

  if(!isPlayer(var_3)) {
    return;
  }
  if(!isDefined(var_8.owner)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")]](var_3.team, var_8.owner)) {
      if(isDefined(var_6._id_121D9))
        var_6 = var_6._id_121D9;

      var_9 = _id_14583(var_6, var_3);
      var_10 = "_encstr_BDB50C41D83F8F9F030B60E80F5B";
      var_11 = 0;
      var_12 = 0;
      var_13 = 0;

      if(isDefined(var_3.modifiers)) {
        var_11 = var_3.modifiers["_encstr_87A205AF10734B"];
        var_12 = var_3.modifiers["_encstr_95A40617A8CBC38F"];
        var_13 = var_3.modifiers["_encstr_A2A406E139973007"];
      }

      init_sentry_traps(undefined, var_3, var_9, var_8, var_11, var_12, var_6, var_4, var_10, var_13);
    }
  }
}

ondeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("_encstr_AD75063D571AE108", 0);
}

onplayerkillassist(var_0) {
  var_1 = self;

  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB")]](var_1.team, var_0)) {
      var_2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

      if(!isDefined(var_2))
        var_2 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

      var_3 = "_encstr_B40101";

      if(isDefined(var_1.primaryweaponobj)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
          var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_1.primaryweaponobj.basename);
      }

      var_4 = "_encstr_B40101";

      if(isDefined(var_1.secondaryweaponobj)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
          var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_1.secondaryweaponobj.basename);
      }

      var_5 = [var_3, var_4];
      var_6 = [0, 0];
      var_7 = 0;
      var_8 = level.carnage_enemydummycleanup;
      var_9 = relic_amped_is_there_valid_new_victim();
      var_10 = "_encstr_B40101";
      var_11 = "_encstr_B40101";
      var_12 = "_encstr_B40101";
      var_13 = "_encstr_B40101";
      var_14 = "_encstr_B40101";
      var_15 = -1;
      var_16 = 0;
      var_17 = "_encstr_B2900F2AA8011BFB130FEFB0EBCADA3B96";
      var_18 = var_1 resetstuckthermite();
      var_1 reportchallengeuserevent("_encstr_A1BD075837DCD29B47", var_6, var_5, var_7, var_8, var_18, var_9, var_17, var_10, var_12, var_11, gettouchinglocaletriggers(var_1, var_0), var_13, var_14, var_15, var_16);
      var_12 = play_sound_from_closest_player(var_0);

      if((var_2 == "_encstr_B607038AAB" || var_2 == "_encstr_931D068662634370") && (isPlayer(var_0) || var_12 & 32)) {
        var_19 = var_1.primaryweaponobj;

        if(isDefined(var_0.attackerdata)) {
          var_20 = var_0.attackerdata[var_1.guid];

          if(isDefined(var_20)) {
            if(isDefined(var_20.objweapon)) {
              var_19 = var_20.objweapon;

              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
                var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_19.basename);
            }

            if(isDefined(var_20._id_11C8D))
              var_7 = var_20._id_11C8D;

            if(isDefined(var_20._id_11C8E)) {
              var_8 = var_20._id_11C8E;
              var_8 = var_8 | 2097152;
            }
          }
        }

        var_1 init_turrets(var_12, var_3, var_19, var_17, var_7, var_8, undefined, 0);
      }
    }
  }
}

_id_12047(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = var_0;
  var_3 = undefined;

  switch (var_1) {
    case "_encstr_BEBD07C1360273C53A":
      var_3 = 0;
      break;
    case "_encstr_8F180CCB17EB37825B883A9240BB":
      var_3 = 1;
      break;
    case "_encstr_8261067B1D34AC27":
    default:
      var_3 = 2;
      break;
  }

  var_4 = relic_amped_is_there_valid_new_victim();
  var_5 = resetstuckthermite();
  var_6 = play_stealthy_disguise_vo(self);
  var_7 = play_stealthy_disguise_vo(self, 1);
  self reportchallengeuserevent("_encstr_BEC415B82175ADF3F3F3CA518897C3F596E865F97815AB", var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_1204A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_7 = var_0;
  var_8 = var_1;
  var_9 = var_2;
  var_10 = var_3;
  var_11 = var_4;
  var_12 = var_5;
  var_13 = var_6;

  if(var_7 == "_encstr_8CC008133958C81BACCB")
    var_7 = "_encstr_B1B30B51D176511E377A1BC313";

  var_14 = resetstuckthermite();
  var_15 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_86860FAD4B1B369B8EC9AC0BB5D7B2E623", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
}

_id_12032(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isDefined(self) && !var_2 challengesenabledforplayer()) {
    return;
  }
  var_4 = var_0;
  var_5 = var_1;
  var_6 = 0;

  if(isDefined(var_2) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    var_7 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA");
    var_6 = var_2[[var_7]]("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735");
  }

  if(level.getallactivequestsforteam >= 8 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team && istrue(var_6))
    var_2 _id_12C3F("_encstr_AC1656CCCB4166636821122AA95F4BD130EB4334B51828F7AC989A2271B8E752506DC9AC23F1F3F74D9031BAD88CCF0DE83B520F5F2031D77768FBB3815EDFC230BDF387D520029F9063E2DB69B567BA891B791357488D13", 1);

  if(level.getallactivequestsforteam >= 10 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team)
    var_2 _id_12C3F("_encstr_827E3B839F77B640299F2937828EA81023F2FB0B53DFF3C1BF793339AC79384FC71B31718AC7A408D277DF39D51A5015BFF34ED8D2DF66E0AD2EB737AC", 1);

  if(level.getallactivequestsforteam >= 9 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team) {
    var_2 _id_12C3F("_encstr_92992B479CAFB10D7D761BDB2685C6D799B495C646BED5C1EC4E0B8C56BE46959B3A9CAED83AA5F6E66EAFB9CC", 1);
    var_2 _id_12C3F("_encstr_977E3B3A27BEB143BE76B17B260B1BAF9195DC1D4EDBCBFACC5A958D23F5EA0E769CB01956D799DB93FABD0795C9B0D1F69CAFB54B376ED2EDCDF53766", 1);
  }

  if(level.getallactivequestsforteam >= 11 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team && istrue(var_6))
    var_2 _id_12C3F("_encstr_A5445943028F8EB8F9A9D137064FD009AC5DF72340670321F7831310B1604B8317FAE06C6F7663871442C83DCDD72CA323376A1927FBB62022381D75A972A0CA714AA269A61003A60582E7E8F74420D5E80D63EBAB2B8072A7E775", 1);

  if(level.getallactivequestsforteam >= 11 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team)
    var_2 _id_12C3F("_encstr_BD7E3B4B8897D0FB214739377BEA31E9447753C3C21F4838CA6713299BD185D81F0A9959AF4708E8A3D70F19B76BC7A3BF62C6F0D4B36893AA2B77E7EE", 1);

  var_8 = resetstuckthermite();
  var_9 = relic_amped_is_there_valid_new_victim();

  if(challengesenabledforplayer())
    self reportchallengeuserevent("_encstr_8AC20AE97C4D481DC1AF9D81", var_4, var_5, var_8, var_9);
}

_id_12021(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 12) {
    if(isDefined(var_0) && istrue(var_0.isequipment))
      _id_12C3F("_encstr_865A3E4BC2B7DEA316449C87EEF97B6965A84271088599E76AA09D8DFF460B2C93585A0970594FBB611565ABAFA9E337BF489282D0DB027B3B8D69BB2EB6EF6B", 1);
  }
}

_id_12003(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["_encstr_87A205AF10734B"];
    var_2 = var_0["_encstr_95A40617A8CBC38F"];
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("_encstr_95EB0866891B23FB85B3", var_3, var_1, var_2, var_4);
}

_id_1201F(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["_encstr_87A205AF10734B"];
    var_2 = var_0["_encstr_95A40617A8CBC38F"];
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("_encstr_830C078CCA33ABB959", var_3, var_1, var_2, var_4);
}

_id_12062(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["_encstr_87A205AF10734B"];
    var_2 = var_0["_encstr_95A40617A8CBC38F"];
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("_encstr_830C078CCA33ABB959", var_3, var_1, var_2, var_4);
}

_id_12096(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = relic_amped_is_there_valid_new_victim();
  var_2 = resetstuckthermite();
  self reportchallengeuserevent("_encstr_9B1905D3B92BF0", var_0, var_1, var_2);
}

_id_12092(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = relic_amped_is_there_valid_new_victim();
  var_2 = resetstuckthermite();
  self.watch_for_player_enter_trigger = gettime();
  self._id_14072 = 1;
  self reportchallengeuserevent("_encstr_BA19058303338D", var_0, var_1, var_2);

  if(level.getallactivequestsforteam >= 7)
    _id_12C3F("_encstr_8A2C3CB9394197440667F31AD347EDEE17B4C0E88113180A7B018BA956597B4B6F0B4FB9789EF8AB30016DAFED21974A3D53A6837AABB73D2CEF6F0CCF5E", var_0);

  if(level.getallactivequestsforteam >= 9)
    _id_12C3F("_encstr_A3943FEBF65F2A38B9BFD4606DF1B0315380D33BF8482932B3993CA3AE2D0B58BFFD8D1E78FBF276A0D9AC30BA07E069A84B81EB9A85974867BB777FEFD0E1CBD2", var_0);

  if(level.getallactivequestsforteam >= 11)
    _id_12C3F("_encstr_91943F3B5AD00F9C715FF4CF6DB8A5B76E6B62D2FE9E9B95C0C7F8CD03B8EBB380033ABA40F4678AF0DFEEDF3DF9F59B35FBF253A84ED78558AFF3D12F58B16F45", var_0);
}

_id_1203D(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = play_stealthy_disguise_vo(self);
  var_2 = relic_amped_is_there_valid_new_victim();
  var_3 = resetstuckthermite();
  self reportchallengeuserevent("_encstr_95CC050D168DDA", var_0, var_1, var_2, var_3);
  var_4 = 0;

  if(isDefined(self) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    var_5 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA");
    var_4 = self[[var_5]]("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735");
  }

  if(level.getallactivequestsforteam >= 10) {
    if(istrue(var_4))
      _id_12C3F("_encstr_B20B3FF4E396F76CCF50A2AA408B254F28A76B9348797BF74348993270EB1D7B2615E01776019BBF276112BAB0471563D97E799CB7CB2F453B284BD2700D41979B", 1);
  }

  if(level.getallactivequestsforteam >= 11) {
    if(istrue(var_4))
      _id_12C3F("_encstr_95B7425B5F1FC80B402F714DCE9138C9D0E0F7925B9D6E58D08D495FA135A1922378728F37218BFF488DDEB00C289897F7682D9B1138E5129F60E04FD7C42AC04A71AB7B", 1);
  }
}

ondestroyedbytrophy() {
  if(!isDefined(self.owner)) {
    return;
  }
  if(level.getallactivequestsforteam >= 8)
    self.owner _id_12C3F("_encstr_91F3407C9BEE8FE447C82A12C813DDC7212DE3F456B0AFE1EBC8F31AB84FD4ABF9986F91EDB8EF73AD58FB52603FCF97B360CF708D435FBBAFA8F11AD8BFC2474850", 1);

  var_0 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA");
    var_0 = self.owner[[var_1]]("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735");
  }

  if(level.getallactivequestsforteam >= 9 && var_0 && istrue(self.ishacked))
    self.owner _id_12C3F("_encstr_970C3169667136C8CF4F104836D9A0604A5311C3D31A8DD01C2478601ABF40A373F3CF4137E2423024B103FB057870E379778F", 1);

  var_2 = self getlinkedparent();

  if(level.getallactivequestsforteam >= 9 && isDefined(var_2) && var_2 scripts\cp_mp\vehicles\vehicle::isvehicle())
    self.owner _id_12C3F("_encstr_9B46476368C15BA0616201AFB0F340F70EBF29E131387B6F4F4863CE68A3BBCF8BEE7A13B0CBCE9FFD880D3317DDAFF3236E6430762FEF43B77ADF8B7F6BEF0590D33B7B78E0913766", 1);

  if(level.getallactivequestsforteam >= 11) {
    self.owner _id_12C3F("_encstr_B6B945D193FAC634D7CE63DB4C0B8DFA32ACE6E827B797BEC139DB4DCA1B3AB48DCAE6FAEED2E8D0F51D9CDE07A1E5F566DB27D7B783AC4E2C8EED9CEBADD2B96E4BBD9BF5CDA6", 1);
    self.owner _id_12C3F("_encstr_A3182CE8C9D78D43BEECD8DB98588DD70DC21BDA2B237D994B95368CAFD538B3930B4695AFAC67B2DC3A9B7D37A9", 1);
  }
}

gettouchinglocaletriggers(var_0, var_1) {
  var_2 = "_encstr_B40101";

  if(!isDefined(level.localetriggers))
    return var_2;

  var_3 = 0;

  foreach(var_5 in level.localetriggers) {
    if(var_0 istouching(var_5) || isDefined(var_1) && var_1 istouching(var_5)) {
      if(isDefined(var_5.localeid)) {
        if(var_3)
          var_2 = var_2 + "_encstr_854C021F";

        var_2 = var_2 + var_5.localeid;
        var_3 = 1;
      }
    }
  }

  return var_2;
}

run_laser_vfx_loop(var_0) {
  if(!isDefined(level.localetriggers))
    return -1;

  foreach(var_2 in level.localetriggers) {
    if(var_0 istouching(var_2)) {
      var_3 = isDefined(var_2.localeid) && var_2.localeid > 0;
      var_4 = isDefined(var_0.wasingulag) && var_0.wasingulag == var_2.localeid;

      if(var_3 && !var_4) {
        if(!isDefined(var_0.wasingulag))
          var_0.wasingulag = 0;

        var_0.wasingulag = var_2.localeid;
        return var_2.localeid;
      }
    }
  }

  return -1;
}

_id_1200A(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_A5310FF2B81DA373991EDCFF2E0307EA81", gettouchinglocaletriggers(self, undefined), gettouchinglocaletriggers(var_1, undefined), resetstuckthermite(), var_2, var_0);
}

_id_12009(var_0, var_1, var_2) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(var_1 == level.questinfo.hotfootabsloops) {
    if(!isDefined(self.hotfootreset))
      self.hotfootreset = 1;
    else
      self.hotfootreset++;

    if(self.hotfootreset == 3)
      _id_12C3F("_encstr_92F236D1E4BE6CA1FA3BB1B7130B1BAFB17B6B0EC65647ACF5D1864EB22BEB6CDBDC474E0BC61DB9AF7B732BF55B588E6CA17D3798EBBBA7", 1);

    if(var_0 == "_encstr_A1580B19DE5B5A9B0BA35AEDCD") {
      if(level.getallactivequestsforteam >= 10)
        _id_12C3F("_encstr_91AE37FBC219835A781F7B7F7D1F62C7F031F407219841734D575F3F41BD3B2218FE6F0DFB691F4B95E55F635766C16590C3A214F098E7B355", 1);

      if(level.getallactivequestsforteam >= 11)
        _id_12C3F("_encstr_ACAE37B38E19EF385832E047D6916D41EDA28063475C3A7BD57861B6F1933D607560435810A7B0223D90A7155506188F9BBB604FD7C82F7763", 1);
    }

    if(level.getallactivequestsforteam >= 11)
      _id_12C3F("_encstr_95873131E101C8FBB7B230588A27A171A61CAB9332F98AA8779B4B81A2D7EDD0FA57372DF75BB0909702CD2B5BD7965819D31B", 1);

    if(level.getallactivequestsforteam >= 12)
      _id_12C3F("_encstr_BEE744E3FADE5BBAFFF4558D6EABB2DF41D0131F50D0AFD2DB159E44D87F3ABCE8F9BBE7D029F73A352267BEB56B8375D6303F7B98433F622D50EBF00825EA2D5870F72F0813", 1);
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_8AE40D8DB7DC8E9C8536D17DCAB932", var_0, var_1, isalive(self), var_2, resetstuckthermite(), var_3);
}

_id_1204B(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(var_1 == "_encstr_93920C9E781BB33078D689330FA7")
    _id_12C3F("_encstr_930538736A4ECB2A0F04A51DFE1B22AF9170AFEB58E1142237A96D96D5DF4B4CBE505B0F501E7ECA852875CA4DCD42F44048778F20F3A392E758", 1);
  else if(var_1 == "_encstr_AB420B13C7C1C89EFA6B6B2D5F")
    _id_12C3F("_encstr_ADB633313E296EA0B73778109E71788873D793BBC792AD809F4E432A865948DA7933170D77DA7758EAE66BE0AA3FE003D3DF93AF1B", 1);
  else if(level.getallactivequestsforteam >= 8 && var_1 == "_encstr_85CE0B9770B02C73A1760F06D2")
    _id_12C3F("_encstr_829332BB8259C31A385F3B3FBDDFA2071010350563589A820F7F5F0781FD0B73B0F96ACFF9A95F2B480317B7A3ABD3ADB886E282", 1);

  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_A5A8098A0313CFEC180BA5", var_0, var_1, resetstuckthermite(), var_2);
}

_id_1205F(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = level.getallactivequestsforteam;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  if(var_0 == "_encstr_AC20072B9FA9487832") {
    var_3 = 1;

    if(isDefined(var_1))
      var_6 = var_1;
  } else if(var_0 == "_encstr_83A20883C6EA378C2B93") {
    var_4 = 1;

    if(isDefined(var_1))
      var_8 = var_1;
  } else if(var_2 >= 8 && var_0 == "_encstr_85CE0B9770B02C73A1760F06D2")
    _id_12C3F("_encstr_829332BB8259C31A385F3B3FBDDFA2071010350563589A820F7F5F0781FD0B73B0F96ACFF9A95F2B480317B7A3ABD3ADB886E282", 1);
  else if(var_2 >= 8 && var_0 == "_encstr_8B2C0ED07A16BDF9E307D55639372047") {
    _id_12C3F("_encstr_88C32683E26847D429178C8735F01D6FAF80EABAB657274EF02BA8AFEF386683C558C282BBB8F7D2", 1);
    _id_12C3F("_encstr_ADE63899F66F37B859AA796FBAB1A189332D4587B9580AAAC76D1F77A76F5E8BAD35A18F35A129B742AE17FB191AD948656AA9384B4F174B18F8", 1);
  } else if(var_0 == "_encstr_BE8F0A272F9B2BE97268AE8B") {
    var_5 = 1;

    if(isDefined(var_1))
      var_7 = var_1;
  }

  if(var_2 >= 9 && var_0 == "_encstr_8B2C0ED07A16BDF9E307D55639372047")
    _id_12C3F("_encstr_B15A3BD4D3597E0BAF597A3281675339F0D3754787C804FF3233B3398B4E9FAB78ADF7D535098F87666E5AD3511ED763D03D5755BB9B12A780A051EB73", 1);

  if(var_2 >= 10 && var_0 == "_encstr_8B2C0ED07A16BDF9E307D55639372047")
    _id_12C3F("_encstr_AF5A3BA39C7D1B0DFA3BC6DE4CB036AF165BADBDD7C12D6CDA5D83F5DC36163BB2CDEC2B39EB66ED27D7B7385927581DF6E4D76B2D9BCD5AB7E6F56E43", 1);

  if(var_2 >= 11 && var_0 == "_encstr_8B2C0ED07A16BDF9E307D55639372047")
    _id_12C3F("_encstr_8D5A3B4727D7B10DAF761B7B312C8DBE58B56BEDFA074B1BB657E0FA37D8C2CEAC9B9D2BE4AF33F64EFA7B0E2B932C1DDB9CBED6B4DC6ED2BD737D9BA9", 1);

  if(var_2 >= 12 && var_0 == "_encstr_8B2C0ED07A16BDF9E307D55639372047")
    _id_12C3F("_encstr_8C5A3B3A72BEB11AEBD91BF6310B63AF85B6ADBDD7C12DB1ADBAC1EBDCB1B03BAC3776594EF599BD27AFDE0E599C2C8EB7C9FAB6D29BB9B4F6CDAF6E63", 1);

  if(var_2 >= 12 && var_0 == "_encstr_85CE0B9770B02C73A1760F06D2")
    _id_12C3F("_encstr_97A047231AC15BB280E793A7D5B73AAFB8F8DDADCB30F23AE797E76F1965E3CBC84192778111A783D09BBFCF0B03AB0510EE4F7D3BB97FDB1595BFD317B6A17590F3824430E80723D4", 1);

  var_9 = relic_amped_is_there_valid_new_victim();
  var_10 = gettouchinglocaletriggers(self, undefined);
  var_11 = _encstr_8873122F83E896F3E7D0A23AB8CC1FCDA851A9B4();
  self reportchallengeuserevent("_encstr_A31C07E04BD8ADABE0", var_3, var_4, 0, resetstuckthermite(), var_10, var_9, var_5, var_6, var_7, var_8, var_11);
}

_id_12060(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
    return;
  }
  var_1 = var_0 * 100;

  if(level.getallactivequestsforteam >= 9)
    _id_12C3F("_encstr_97923089598940632F3AC8D012AF29E95F990D05976AB838B332A6F9EACB48B0B2F5959344D5786817EA3B43926798798A1B", var_1);

  if(level.getallactivequestsforteam >= 11) {
    _id_12C3F("_encstr_82173B8E27EBB1A1AFD98DB789161BEB590BC9B9BEE6B1B727CAD7DE39F5BBE9D736B0B986D7CCDE4EFADEC1CA4E16A3BDE47D5BB437DCD2DBCDBEDC53", var_1);
    _id_12C3F("_encstr_8F36267BE89FA76CB917C985EAA85D17773AF350C1B3BBB71B5AA1806321F7A3D18E17339A20C36B", var_1);
    _id_12C3F("_encstr_84C325DD61016BF2595EF0397938DB2F9083F2FBED64D5A77947D2C9C00D5AF397037C935DA99E", var_1);
  }

  if(level.getallactivequestsforteam >= 12) {
    _id_12C3F("_encstr_92173BA42376706208B7C28A32010266B96FB33A0107FA68EBC13750DB0984DD79EA296BF4F1BAD53319C090202261B3D5AB57B22CA316AC7FA229EFA7", var_1);
    _id_12C3F("_encstr_ACDE256CF18726F9EFF330908D5F8DE7FDA3BE1D2821C0202EB77A49D25E4BF7A7D390533A2783", var_1);

    if(!isDefined(self.get_tv_station_infil_rider_start_targetname))
      self.get_tv_station_infil_rider_start_targetname = 0;

    for(self.get_tv_station_infil_rider_start_targetname = self.get_tv_station_infil_rider_start_targetname + var_1; self.get_tv_station_infil_rider_start_targetname >= 15000; self.get_tv_station_infil_rider_start_targetname = self.get_tv_station_infil_rider_start_targetname - 15000)
      _id_12C3F("_encstr_8FF525D38B2F981128F37F4D7ABA902122F39E5BCAC91197668A5F1127203563E678282B87C62A", 1);

    if(!isDefined(self.get_trap_room_spawnpoints)) {
      if(!isDefined(self.get_turret_target_pos))
        self.get_turret_target_pos = 0;

      self.get_turret_target_pos = self.get_turret_target_pos + var_1;

      if(self.get_turret_target_pos >= 25000) {
        _id_12C3F("_encstr_8D8C25C006EEA7FCF9769F60F0D7204752FA2D3D40A2ACF06191C5AFAA75657D477DFA759B89FC", 1);
        self.get_trap_room_spawnpoints = 1;
      }
    }
  }
}

_id_12002() {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_0 = relic_amped_is_there_valid_new_victim();
  var_1 = gettouchinglocaletriggers(self, undefined);
  var_2 = _encstr_8873122F83E896F3E7D0A23AB8CC1FCDA851A9B4();
  self reportchallengeuserevent("_encstr_A31C07E04BD8ADABE0", 0, 0, 1, resetstuckthermite(), var_1, var_0, 0, 0, 0, var_2);
}

_id_120A8(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_B6D50983481B196F4B0DD5", var_0, resetstuckthermite(), var_1);
}

_id_12098(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 7)
    _id_12C3F("_encstr_8F5B3564933F1F4A3F0FF8E7960B3517083147E7B091F34028DB4BE17BAD774BB76F17E75F32F8588181AEB64B18026E90B197A730A713", 1);

  if(level.getallactivequestsforteam >= 10)
    _id_12C3F("_encstr_95F12B739B99C0940197093798C672D7A21F8AC77AD3DB06629B0B2887C03197DEDD1B7A371B9B7D802B416B43", 1);
}

_id_12004(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", var_0, resetstuckthermite(), var_2, var_1);
}

_id_120A4(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", var_0, resetstuckthermite(), var_2, var_1);
}

_id_12061(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_870D05C1969BB3", var_0, resetstuckthermite(), var_1);
}

_id_12053(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_B1750873B8E9AC3A3BED", var_0, resetstuckthermite(), var_1);
}

_id_12050(var_0, var_1) {
  var_2 = relic_amped_is_there_valid_new_victim();

  if(var_0 == var_1) {
    if(var_0 challengesenabledforplayer())
      var_0 reportchallengeuserevent("_encstr_9695073995D94BD959", 1, 1, var_0 resetstuckthermite(), var_2);
  } else {
    if(var_0 challengesenabledforplayer())
      var_0 reportchallengeuserevent("_encstr_9695073995D94BD959", 1, 0, var_0 resetstuckthermite(), var_2);

    if(var_1 challengesenabledforplayer())
      var_1 reportchallengeuserevent("_encstr_9695073995D94BD959", 0, 1, var_0 resetstuckthermite(), var_2);
  }
}

_id_1203C(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("_encstr_B6D11076BA8D163B7DCA9BC8AF5B8547B143", var_0, resetstuckthermite(), var_1);

  if(level.getallactivequestsforteam >= 11) {
    var_2 = 1;

    if(var_0 == var_2)
      _id_12C3F("_encstr_A2072A8D81C7D11111BAB0A0C2B621EE8F55180C39FF7861494258198B888FA1BFE41774B7D72D8DAA695842", 1);
  }
}

_id_1205A(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(var_0 <= 0) {
    return;
  }
  if(var_0 <= 15)
    _id_12C3F("_encstr_B87B3371BF9FD65A792C64F759E7AA7FC76FFAEA06651F710A4F6B9743712F0A668DC56531C56BD98298F86FEB8F704B9ED338C728", 1);

  if(var_0 <= 3)
    _id_12C3F("_encstr_8F721E437AA13BD2E087F387F597DA4F8078BE0E6949D47A4F0737ABF150D3F9", 1);

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC")]](self.team);

  var_2 = 0;

  if(var_1.size != 0)
    var_2 = var_0 / var_1.size;

  if(var_2 <= 0.25)
    _id_12C3F("_encstr_8DDE268E93D71B437DB3C67B4C85D8EBE8DEC17D649AF583569C8D56DC1DD7334BB95A3734FA37CC", 1);

  if(level.getallactivequestsforteam >= 10) {
    if(isDefined(self.kills) && isDefined(self.assists) && isDefined(self.deaths)) {
      var_3 = self.kills + self.assists;
      var_4 = 0;

      if(var_3 > 0) {
        if(self.deaths > 0)
          var_4 = var_3 / self.deaths;
        else
          var_4 = var_3 / 1;
      }

      if(var_4 >= 2)
        _id_12C3F("_encstr_830B3B83BA61FB12204733C7B5D79A0F7018BD4C6BB0BF1A074907D3E784B27CA8262290862047236D0707C793A719B4D049ADD15988117B3337E7AF41", 1);

      if(var_3 > self.deaths) {
        _id_12C3F("_encstr_8E4C4DA599DFC97979C2D8B8EA8E3906636120934BEBB6ABDEDBA8881123CBBBF32F3918A267FEF38412A029BB3C93B0D7BCB5871C3BA3BFAF9A3021E252438B8734C8865FF7A82FD2C2E090D9AAA9", 1);

        if(level.getallactivequestsforteam >= 11)
          _id_12C3F("_encstr_B84C4D7BDB0892C86179955D317804A97C938B87F7CB19B5C8234E648EF05953C3670F279DE5C175B0E8C6A1C360992A30B9D797099B4B1720303AB9D878A5A3F7E17743F7B152F3A0D875FDF648BD", 1);

        if(level.getallactivequestsforteam >= 12) {
          _id_12C3F("_encstr_924C4DDB52274E336634EC175E49EB998D78C2829821097F99A5EB18F8D3871B39317A7AF883F197B003F13705186F252F4062127071B247C978EA3F90E327EAFB584A5BC123ECBF4353CF36A0ABA2", 1);
          _id_12C3F("_encstr_A3DE2529F969A083CF9A483042374889BD288DD3460F605DA7C70B7E8AEB722BD684035DF5B9EA", 1);
        }
      }
    }

    if(var_2 <= 0.1)
      _id_12C3F("_encstr_B86526CBF229B34A680F0B0F6D2F52D7D88042991BAA47035D3D4F3F4D4DA92668C8BC1AA879137F", 1);

    if(var_2 <= 0.25) {
      _id_12C3F("_encstr_84FF44040389AEDBD0694A62D1170369F80B8691EF58F9F7E7E3B21A5E7B53D1809F10DFC56A31CB9D1B4AF2CDCD5FD77B4D8767D94002573DD0535948AB974A98CF3ECF37B2", 1);

      if(level.getallactivequestsforteam >= 12) {
        _id_12C3F("_encstr_85FF44D5A0192FE8BF47B0B04BD9201FF2DC40D38AC28FB06923C080D7F9B8E77BC5C77032CFC75B55C3F8902B1CD6DD122A28E03AA225A12C9F7849CF296B2F1A953860522F", 1);
        _id_12C3F("_encstr_99F5258E277D1B867D6C7BB5DABDE6FAB783895D37C8C6ACD71886AFBD4C4D2BC6E84BB359D78C", 1);
        _id_12C3F("_encstr_BE1325A3C9EBC634FA36DE5BB5DE9BEBED8389BAB932B159F503DCFADB4C9A2BD8472DB356AF68", 1);
      }
    }
  }

  if(level.getallactivequestsforteam >= 11) {
    if(var_2 <= 0.5)
      _id_12C3F("_encstr_95C3254CABDEBF349738EAC260DF6D9730F7A2C5A801CB3FEFBA37F9881D2437E95D215EB50E12", 1);

    if(isDefined(self.kills) && isDefined(self.assists) && isDefined(self.deaths)) {
      var_3 = self.kills + self.assists;

      if(var_3 > self.deaths)
        _id_12C3F("_encstr_960725101AE1C67A4E429A393B88FD67E0E79A4D50FA63FF615F1E1075496471C273FF6B7F1F69", 1);
    }
  }

  if(level.getallactivequestsforteam >= 12) {
    if(isDefined(level.disable_super_in_turret.name) && level.disable_super_in_turret.name == "_encstr_A11804CEC338") {
      _id_12C3F("_encstr_AAC12BB5BAFECE7BD76958CD587DB6E946C5B6EB9228E92259A48297878BE1CDBB87A6E91F43583F18E21D77A6", 1);

      if(var_0 <= 10)
        _id_12C3F("_encstr_97C12BBDB1F7E14141AAD8C06265153E2F954FB64F8BAE35B9F348499A7BCBD0EB07C6A3D96B70EBDD1AB841C7", 1);
    }
  }

  var_5 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD");

  if(var_0 == 1 && var_5 == "_encstr_A11804C81332" && scripts\cp_mp\utility\game_utility::turretdisabled())
    _id_120A4("_encstr_8CD81C3B6D9551C13818D61DF3381BA97493BFF3CFC67B8750014B262B68");

  if(var_5 == "_encstr_91190446A2B3") {
    if(var_0 == 1)
      _id_120A4("_encstr_87A8137ED7B8D9CBA37163DA7B8337CA489FE1E269");

    _id_120A4("_encstr_ACEF198B8F74B93848732B7449506012CD3B6773079EC2F7601B27");
  }

  if(scripts\cp_mp\utility\game_utility::tutorialzoneenter() && var_0 == 1)
    _id_120A4("_encstr_9993123492F9E528632B88780787830BC3FEAEB5");

  if(var_0 == 1 && (var_5 == "_encstr_A254085207A6B7334B5A" || var_5 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_5 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_5 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95"))
    _id_12004("_encstr_AC640D181FFB2B3F1B2CDE5D8573BB");

  if(var_0 == 1 && var_5 == "_encstr_A519044B436F" && !_id_125F3())
    _id_12004("_encstr_AFF208FB481B69E7AA18");

  if(var_0 == 1 && (var_5 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_5 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95") && self.kills >= 15)
    _id_12004("_encstr_B24809B330A9775B8FAF73");
}

_id_1208F() {
  if(!challengesenabledforplayer()) {
    return;
  }
  _encstr_8AB01AA86A229F0B9B3363EF04C3D1554FF22860C2FB3BA09F4D785D("_encstr_998A0668F36A3BD2", 1);
  var_0 = run_laser_vfx_loop(self);

  if(var_0 != -1) {
    var_1 = resetstuckthermite();
    var_2 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent("_encstr_998A0668F36A3BD2", var_0, var_1, var_2);
  }
}

_encstr_9A6C0AFFB8611F5A69D0533A() {
  if(!challengesenabledforplayer()) {
    return;
  }
  _encstr_8AB01AA86A229F0B9B3363EF04C3D1554FF22860C2FB3BA09F4D785D("_encstr_8F0508CE59DCA357392B", 1);
}

_id_1301E(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = relic_amped_is_there_valid_new_victim();
  var_3 = gettouchinglocaletriggers(self, undefined);
  var_4 = resetstuckthermite();
  var_5 = "_encstr_842611DA9DAF593B2B37D1FA4B378ECA36F526";

  switch (var_0) {
    case "_encstr_842611DA9DAF593B2B37D1FA4B378ECA36F526":
      self reportchallengeuserevent("_encstr_9A3B0AE3C479BB07BF5E233D", var_5, var_2, var_4, var_3, var_1, 0, 0, 0, 0);
      break;
    case "_encstr_A62611B63BBECAB395CD3AEBD237E85636BE99":
      self reportchallengeuserevent("_encstr_9A3B0AE3C479BB07BF5E233D", var_5, var_2, var_4, var_3, 0, var_1, 0, 0, 0);
      break;
    case "_encstr_AA261112FB5F9185819E105728F8BDF3A5DFC2":
      self reportchallengeuserevent("_encstr_9A3B0AE3C479BB07BF5E233D", var_5, var_2, var_4, var_3, 0, 0, var_1, 0, 0);
      break;
    case "_encstr_9726118D0D19BF335D38BBF12020F37758F76D":
      self reportchallengeuserevent("_encstr_9A3B0AE3C479BB07BF5E233D", var_5, var_2, var_4, var_3, 0, 0, 0, var_1, 0);
      break;
    case "_encstr_AD26116A8B60BF634BAB63C633EBA1C28D89CB":
      self reportchallengeuserevent("_encstr_9A3B0AE3C479BB07BF5E233D", var_5, var_2, var_4, var_3, 0, 0, 0, 0, var_1);
      break;
    default:
      self reportchallengeuserevent("_encstr_9A3B0AE3C479BB07BF5E233D", var_0, var_2, var_4, var_3, var_1, 0, 0, 0, 0);
      break;
  }
}

_id_12000(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_12C3F("_encstr_8A30417D71372181812A63105226517E2BDC087E8B8F89DB7552605879FC1DB36F6A0DE51CE791055DDAC081C2151DCEEFF01DE67193984D09C24B188BACEFA0D79BBE", var_0);
}

_id_12007(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  switch (weaponclass(var_0)) {
    case "_encstr_850707F7E5833355B8":
      if(level.getallactivequestsforteam >= 10 && var_1 > 0 && var_1 % 3 == 0)
        _id_12C3F("_encstr_A31644ABDBAE2242988FCC58907A02662C52A5C9204AAFA708B0686B3E80E5C068C22F87C1203F08AB10376992830AD59BAFF37A3938294B28A3F1AAC6B7CAA098A4BF015B82", 1);

      if(level.getallactivequestsforteam >= 12 && var_1 > 0 && var_1 % 3 == 0)
        _id_12C3F("_encstr_820D595BC31117AA7F07C0D7394810E13682638DC96B6643C010034D1A7B53088B1A674DB34A6A97787014470F28C03D07C80F5B934B4F48CD5C1305C2F1839760E1C3F1E9BD9311F87279D261C0AF0B892D631BA3A210B3968395", 1);

      break;
    default:
      break;
  }
}

_id_12094() {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 9)
    _id_12C3F("_encstr_8E5A3A3A72EB1BA1FA3B63DE980B1BAFD6961B1B9BD7E6C6DBE4AC6EE8939516AD7D7B9C7D63DB0B23B75747FA234EDE0EFA77CA8583ED9BB9F5E699", 1);

  if(level.getallactivequestsforteam >= 10)
    _id_12C3F("_encstr_AAF84FB38A51CB223057233745C7AA3FC829EDBAB99884FB757337FF87FD22688010694533A14B53582963DF8D9409A0D89B1F8A0EE8E98A215F33CFDD5032F860439693A09897528B1F7FCFFFE0793352", 1);

  if(level.getallactivequestsforteam >= 12) {
    _id_12C3F("_encstr_88F84FB3EB37F87BEE7F893A6E4193F1CFF987F2A748EB855FCACAA787DFBFB0AF1651B792D61B63A011D3EBBD2FA6E2708F1BBA60584ACCC07002876B096877AFFBC743BD7A3121FFA39F5B70BB916256", 1);

    if(!isDefined(self._id_12A8A))
      self._id_12A8A = 0;

    self._id_12A8A++;

    if(self._id_12A8A >= 2)
      _id_12C3F("_encstr_867649ACAB2106434801320A49BFABF1A0832009B9794C0F8958DBF1F3838374714FAB87ED2B92A3AE11F2BADEE41FEE60CF2E2F7F40D1E7524EEB53A0BF03A448B7E788E7C0E7CBE8E3B7", 1);
  }
}

_id_1207C() {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 9)
    _id_12C3F("_encstr_925D4C73FA8FF68BCEAC747F36D1433111E0FBFA80612FF3A6824964D93E23C44B6302D1683366E79876777265C13FCD97D8EB6A18F3D14B705E6F978729835639E873E1B84392C7E8C856AF1E3B", 1);

  if(level.getallactivequestsforteam >= 11)
    _id_12C3F("_encstr_815D4C515E490E80971758307E9198A852B7D98BDF23C5A8FF6CE068E54733FB3A3B61775F9A9EA917022EA34F2310A03163C58F3BE248283F1A5618320D306F5BE77D67AFCA267841B578169AA5", 1);
}

_id_14583(var_0, var_1) {
  var_2 = undefined;

  switch (var_0.basename) {
    case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
    case "_encstr_8A9B18CDA79A41114F78E7C8AB7719A3EB6702DFB1F277A75BF3":
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
    case "_encstr_8EC319437BB679EF28B0A17249903CB287E167DB1D5DE2AB513862":
    case "_encstr_AAC517BEE0390F6BED2A408B187B8722C6CF7429D2C0E94F20":
    case "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8":
    case "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2":
    case "_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38":
    case "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83":
      var_2 = "_encstr_81C80E0C79E00F3BF583FB8FF5B0C278";
      break;
    case "_encstr_88E90F60526BE39B37B026C8BBEA614FB1":
      var_2 = "_encstr_88E90F60526BE39B37B026C8BBEA614FB1";
      break;
    case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
      var_2 = "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07";
      break;
    default:
      var_2 = undefined;
      break;
  }

  if(!isDefined(var_2)) {
    var_2 = "_encstr_B40101";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_B2231AB32BD18AB85D2D07DAB29BE8252BCC194EBDB5752B16E0DEE6"))
      var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_B2231AB32BD18AB85D2D07DAB29BE8252BCC194EBDB5752B16E0DEE6")]](var_0);

    if(!isDefined(var_2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_0.basename);
    }

    if(var_2 == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC" || var_2 == "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B" || var_2 == "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1")
      var_2 = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";
  }

  var_3 = "_encstr_B40101";

  if(isDefined(var_1.secondaryweaponobj) && isDefined(var_1.primaryweaponobj)) {
    if(var_0 == var_1.primaryweaponobj) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
        var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_1.secondaryweaponobj.basename);
    } else if(var_0 == var_1.secondaryweaponobj) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
        var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_1.primaryweaponobj.basename);
    }
  }

  var_4 = [var_2, var_3];
  return var_4;
}

_id_12C3F(var_0, var_1) {
  if(!isPlayer(self) || isai(self)) {
    return;
  }
  if(level.play_intel_collect_vo) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_95C61377BF300F48A80BF42AE5271DE308C87FC653")) {
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_95C61377BF300F48A80BF42AE5271DE308C87FC653")]](var_0);

      if(!var_2)
        return;
    }
  }

  self reportchallengeuserevent("_encstr_8DCC0DDDD1978121AE3A6020F2C7E3", var_0, var_1);
}

_id_13276() {
  if(isDefined(level._id_139E2)) {
    return;
  }
  var_0 = [];
  var_0["_encstr_97881280DB4A0820C4C779FBE22BF8E683B1982B"] = "_encstr_B65617C0863F3189A152F3862BDAF9FE6A2F78401BE72BE389";
  var_0["_encstr_A90415B3BFE7C8E819A1F3A217EDC099AA1F313787DA27"] = "_encstr_81831A7BF287EE93C61F496B35E84B392D780272A87B63D7BE05114F";
  var_0["_encstr_A3E51551E83A39BF28C6531AE29D8898A1CBDD2B0118FB"] = "_encstr_9AB31AFDF1B7A10101DBA870B325D1FEEB5504F80CAB297D79831209";
  var_0["_encstr_B27D15323B97575043A125C3A8079BA17183F057212B4B"] = "_encstr_AAC91A1D93AFC686FA1C5A9B1DBDC6BEDCB25BA58557D1F67DE827BE";
  var_0["_encstr_97F517F8C3B807B36797F54B904F9BE9D5DAB078BA43CF285B"] = "_encstr_87C119E8937D1BD0FA1CA59BE8B7B17DDC86EDA3CE5DCDBEE8C97D";
  var_0["_encstr_A75F1523EF7A76633A591072D2161F4B3B6135AD6FF75B"] = "_encstr_934416437B1F8ADC218E9AF129F2E7AB03E07B4D59A86331";
  var_0["_encstr_B688132DDDC17D2CC9BED1C946C26B2C762B7DB538"] = "_encstr_A93D14A3C9FA1BD07D58C9D746B0D658B356EBA3C9BE";
  var_0["_encstr_B19915980FE8260BE3698D333F8A770B1ECFC86047451B"] = "_encstr_A2CD163A9CAF8D1AD71627D73316DC1D66B4E42BD7D172D7";
  var_0["_encstr_9709192DBBC1EB0B4ED74772CCC29B1DD0589B1936A537767DAD83"] = "_encstr_9B101AE84EBE8D1A7DB027AF990B373A862C9BC8635ACDB3EB1D4EFA";
  var_0["_encstr_8D8E15283F0257BE2B79F3C2F0D7A17162BC013B6632B0"] = "_encstr_AA97163A93D71B43FA8527F5DAED13D2635A4797F53AC9F5";
  var_0["_encstr_926F15335B073F510A0FC8AA973CA8D74A44364D390A29"] = "_encstr_B28A163AC9EB8DA1AFC24EBE6EB1B7EE66969C2B7DE893FA";
  var_0["_encstr_A947157F8F9A5066C8598D07F32B4F1551387BF129ABB3"] = "_encstr_B6B916D193FAC634D7C293D76EA32C73322CE4C8F53A93BE";
  var_0["_encstr_8660192DEEE0D7854EFA8E4EDC8DBDEE0D0BB9C88DA59BB3EBB50E"] = "_encstr_85461AD4D3597E0BAF999B31A3E15F33B8CB764CE14BC5EF28132739";
  var_0["_encstr_B2DB14DA273967BF858FBB904573D3A388D0C091DD82"] = "_encstr_A35E159333900A50C901BAC9599869B3533F6BC7410B71";
  var_0["_encstr_A51414EC0CC949A18B31033E78419933CF28A3E9F981"] = "_encstr_9602151D4EAF6C86AF164ED79BAC2CB9F6378DAFE8E47D";
  var_0["_encstr_91AB132B431F27B9E2F720B2BF079383122B88A11A"] = "_encstr_8B3414AB524876BA50162A7F07203813A9F3E93999AE";
  var_0["_encstr_BEFA17737F270830DE6133E2D7B9885F8A9FFFE38FDAF018F8"] = "_encstr_8C7518231AC15BB280C1EB67D9B72A91D8791AEF08D8DF2BCBFF";
  var_0["_encstr_B1C7165B87121E3B62F1A8DADAFDEDD1C32D5ECEFCE7AD21"] = "_encstr_AD23178EE4EB1BD0AFD14EBE36F6E67698D54E373ABEE872AF";
  var_0["_encstr_927A17FFB74BA12320AE237823586F5AC635371B279569E5F0"] = "_encstr_B25F1818B299A28C8F149369D71F20CFF5A0AD9BB363E643EFC7";
  var_0["_encstr_9B5F1A1B732F17CBCEE73042430AC1A7C29A83908D333B70A1CFF083"] = "_encstr_ADD71BF45B1977037FE89388475B43766C83DB070E831F0212C0898ED0";
  var_0["_encstr_AABA15182358E733D73755EBE107F94B32AA68F019A5F1"] = "_encstr_81351713A3698B33598AC89771A937AA7B8A6E51655F18AB5F";
  var_0["_encstr_888A12D2DD707D9B6B7DD19331D5E4DCD1AFB538"] = "_encstr_B28714DBB68916C967DAE92FCFC59BA3A8D8E943EAD8";
  var_0["_encstr_8FB51519D46A17BABBA113DF58FB32A779B38C91786873"] = "_encstr_B1991770368FA1193162011C71AA538B19E710E8DF779B7319";
  var_0["_encstr_AAF315CFBB423192DD3920EB5881234C649838B9EF95DB"] = "_encstr_A5EE171BD8C780AB51676B77BFAA677884672053771FF0FB89";
  var_0["_encstr_B81815B4EEC1F5CDD6D7D1271AB037918D96B9CEBE5BC1"] = "_encstr_8BEA17C30F59897A71FF2D67773020ED08D0FBE8077E6C1AD1";
  var_0["_encstr_B633121B27EAB7D791F0FB0241AF772658371D1F"] = "_encstr_A17B14487F3937F88773B1BC478381FBDBC399D01741";
  var_0["_encstr_A1BA125A770EBE9BD6D7474EDC833916F2AF6B0E"] = "_encstr_99B4144C4BC1E6E3E823822A8ED6BB1A9853EFB4A319";
  var_0["_encstr_A6CB155AEEE0BECDB67DD19C9BE8C23791164E91EBAD07"] = "_encstr_82361729F969A083CF9B087161474578FD3C8BDD4CC1A073A7";
  var_0["_encstr_A30914AF1FA248DA40A925CB767AA382FFC7EB889ABF"] = "_encstr_95E0178E72FADCE059C6B40BC6F5B958D2C676D573AF3AE4FA";
  var_0["_encstr_885610D0A049D1CF158901611B2358DFB121"] = "_encstr_BE7F125B4266F3122726FD771807DBBA0E50E66F";
  var_0["_encstr_AC1D1543E780713E3789FB4A53CFF9086E5DF1D7A7BD50"] = "_encstr_B11E170B8BA72A48CEB087A7B9233DB2A3CFD383187F93D116";
  var_0["_encstr_910A142387E0115E57295BEAF32F1F384DE615D7355A"] = "_encstr_B24416D3B2381784594FDDDF7F508F675610EA7FC605B6B1";
  var_0["_encstr_96AA1696BB1CFACDB6F5D1C9998DB2C643568ED1B27DDAC1"] = "_encstr_865118D356992BF911B34892E905F81770EC30FB1D5001352740";
  var_0["_encstr_8DB21596BB83EB8DB5EB8E9C0BB1D85D4EC2D195EB5B83"] = "_encstr_95781734F6C7669AC15DD7F97F42B96ED04062B838B7554B99";
  var_0["_encstr_92EB12131F4768A8BD0153C2F591383B5B57E3A9"] = "_encstr_AF371419160146B85F1DA0F9C944788CCA8BD7916E69";
  var_0["_encstr_9AC915BBE303C71B60298B625E2683D58C40CE1F71EBEB"] = "_encstr_84B817E8C9BEC6347D1BB5CEBE332C9B3A99A527CAAFD1C9EB";
  var_0["_encstr_8C3115B4EE70D71BD6AFD19CE68DB7DD33B4E42BEBAD1C"] = "_encstr_95E6178E4EBE8D86FA1BADB3F5B963B7EECCB4C9597D3A27BE";
  var_0["_encstr_B2CA15705348AF704A7F446373141920B1B20E5BCFDDCB"] = "_encstr_824A1A13B3108AD049C33DC49BA0F281DEB1CF83E1A72394214BE041";
  var_0["_encstr_8D7A17D84FA8666F62A94DF33A0B832953E71B703B8D3E1BAB"] = "_encstr_9BB61C4B2B2F1F4251670AF0BB7282E92AB782292217D6E8B9C7AF137AFF";
  var_0["_encstr_A9A916887B90511652C729BB132A5CD872D2B180640F084F"] = "_encstr_A66B1BC8FFB9B77807F3B03BE837E307DA2258D823CAE390F737450BEF";
  var_0["_encstr_B409136447BAD80B83AF9CFBE7B1F6376882816037"] = "_encstr_9A5818419171B8ABE7A340A87BE75EA19621EDFD7F6511ED2659";
  var_0["_encstr_922515C324286F13068763636103AFC0A2EB6BC839DD41"] = "_encstr_86021A2B32166382B7B68D441FFB1B177978FF579389CC9A5FCD40F1";
  var_0["_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB"] = "_encstr_A7C71BFBA81F766BC78069F946AFD6D2AFD835152753164F3707C802E6";
  var_0["_encstr_A95A155ABB07EBE686FA1D4E66D5D88D16D5A37BAFB607"] = "_encstr_95A31B736A4ECB2A0F0EA41DF517B39E1638CF9B586115335730AB8048";
  var_0["_encstr_A6F115603BAAE8D82467D95B534F604B77B35B284117B7"] = "_encstr_A73A1B8E4EFAB10DFACD0D7B473BEA37BEB9955BD20BD53AED7D1D9CAF";
  var_0["_encstr_8A921191BF22995B3A07FD22731F2AA0B6C530"] = "_encstr_AF1817F353B02A70E9631C257BD0953268597F2F69D82369C1";
  var_0["_encstr_B84418FB93CFF72B284790E2937DC3CBD3BE66FDEC524D960593"] = "_encstr_AB291EF4E396F76CCFF0E2AAF087638BCE216D8E559B477671C89AB2C1C94897";
  var_0["_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59"] = "_encstr_8AC51CAB6877301BC18B83A3EB6A5358F259F323E6BEC0472BB387B98E71";
  var_0["_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0"] = "_encstr_8E231CD127EB3686D7B1B05D73D88659C9EB3339CA2B33A52756FAE8E4FA";
  var_0["_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB"] = "_encstr_ABD9227B1A90CF5CB1B72805AF38263B3849939218576B5740FB250647D8EF1B4083BFB9";
  var_0["_encstr_8D511912FF3A89F8DFDFDB1B172CCD90725AACC35270A96591B293"] = "_encstr_816A1D637F9756A009B51B11A5EF512623D2F98902E39F705D953D7FDCC089";
  var_0["_encstr_AC411698A3D8677077B7D56B778F78F3B02AD018FAA94BAB"] = "_encstr_A31C1AE8C9D78D43BEADCA1B5959EBDD2CD64B9E0B9BA15AFAD19CEB";
  var_0["_encstr_ABDA14AAD3233F1D60EF2C59B108261B200BF33178DF"] = "_encstr_9AC615812AB0FB0B2688C8685E27AFD90841C59DFBD957";
  var_0["_encstr_9A18124BEE1CD7DA56AF1D9CCAD1DB7B63BEAD38"] = "_encstr_9B2D165CBBCEAF04A7785AC2D03B314F4308DFCC20F38E81";
  var_0["_encstr_A62814B4BB70BE6B95EB3A27DAB0C686B2E82BFAB507"] = "_encstr_BEBC18E3202F6843893743490FF2AFD0A90EE8591B7DD105C717";
  var_0["_encstr_A3BF1B2DF308C9816A3FA123D3725918E14A2B981EB3984B72BFFF83B3"] = "_encstr_91D32458CE899AD3377FC7F7CAEBD3011F1626C8212A1283B37F58907006F0A945BA90BF9FE7";
  var_0["_encstr_B1650DA3AFF7D810E55103B206C910"] = "_encstr_8D8519AB7BC1D7A824157999425B67C97247B4F8BB81632F982861";
  var_0["_encstr_920B1179B40A775DCB01B37F881B16575E11E8"] = "_encstr_9AD8154772EBB1D0AFD6568D2BACF5B6B01BACD747E4D7";
  var_0["_encstr_935D114BDD83D7AD59FA3A276C58B9CA7DB638"] = "_encstr_8EFD157473F9DEABA0B84AE281853F9650B51DD7716269";
  var_0["_encstr_A2EB10F86F884673F249AD135A6AA38E358B"] = "_encstr_9966176B1001A0D099FB2D980BEA563B37C720FD83C0B7B0E9";
  var_0["_encstr_A2E1163898A1F1781DF9CB6F3669D5FB1A6751F09F911A37"] = "_encstr_B4011AE89CAF6C0D7DB559D8ACCA7D9885478E8DCAB03CCAFAD1937D";
  var_0["_encstr_A6F81432FF91616F99B1D3BBB9B04132BC0B0EB79783"] = "_encstr_95111BB1FB896708C79F557DC98747E37FA0CFB8222011798001192B2E";
  var_0["_encstr_A79D13BAEFD8265A194773AA4ABFE04143AF215BB8"] = "_encstr_91DE17C52A588A3B6797B978D701DFAF7F0364910891644A17";
  level._id_139E2 = var_0;
  var_1 = [];
  var_1["_encstr_A9C60AFD7D8F70BDEBF173D2"] = "_encstr_9A4A1334A3D6B72C8FB8727A70C3E08F8863A4D41E";
  var_1["_encstr_86420BC99599D82B3C91AFA39C"] = "_encstr_ABEB14038AFFE69BDE164D4621A1E37A57805A7AC87F";
  var_1["_encstr_8C3D0B90529FD1A1F32BB01D09"] = "_encstr_B2C614D39A9193A859CB55DD82053A8ED612837BFC5A";
  var_1["_encstr_AA320BBB4DDF51E8204F17933A"] = "_encstr_8274142B32166382B7364F8711FBBB7CBE38D733F0CB";
  var_1["_encstr_8CB10A6605F3E9B77381D84A"] = "_encstr_A245133AE47D1B34F5E4AC3232DBE8BEDAD23663DC";
  var_1["_encstr_A90208B1DFA2D0910438"] = "_encstr_86E111479C7DB1D0EB43EDD87BFA6DD26363B9";
  var_1["_encstr_AA8508177E526F76EC76"] = "_encstr_B1C211A3C9BE8D86AF0BD8EDB3EBB6D2B1369B";
  var_1["_encstr_A3DD0B37B1EDE0CA33F0EB8E93"] = "_encstr_8CBF14DDA81127D0871FD0B87BD5C36979A4DB69550B";
  var_1["_encstr_921C0BF7D3202B03F7688FDBCB"] = "_encstr_9697142066DF11A981B2D6E84A1A293A77B740985BAB";
  var_1["_encstr_B1380793EBAAF0C051"] = "_encstr_9709108E9CFA6C43EB59C6DEBED64B1BD8DC";
  var_1["_encstr_AF1E08ADF1280A69517A"] = "_encstr_A9D0113A93EB8DD0BE59367B23BE6D9663D8B9";
  var_1["_encstr_BD17085B801D33A9EB02"] = "_encstr_81F8117473F9DEABA0B9DAD24B98EF1438B10B";
  var_1["_encstr_91A30C19A596A8FA7F4A1846E37E"] = "_encstr_9B7616E343801A40D9914B56888080A3630FC7074BB1B213";
  level._id_139E1 = var_1;
}

routers_picked_up(var_0) {
  _id_13276();
  var_1 = level._id_139E2[var_0];

  if(isDefined(var_1)) {
    var_2 = var_0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AA501282FAD89F4D8863A73A7B97D251D9B60568"))
      var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AA501282FAD89F4D8863A73A7B97D251D9B60568")]](var_0);

    if(!scripts\cp_mp\utility\weapon_utility::vehicle_clearpreventplayercollisiondamagefortimeafterexit(var_2))
      var_1 = undefined;
  }

  return var_1;
}

init_turrets(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_8 = level.getallactivequestsforteam;
  var_9 = 1;
  var_10 = 0;

  if(var_7) {
    if(isDefined(self.killcountthislife))
      var_9 = self.killcountthislife + 1;

    if(self.recentkillcount > 1 && !istrue(self._id_11E04)) {
      self._id_11E04 = 1;
      var_10 = 1;
    }
  }

  var_11 = "_encstr_B40101";
  var_12 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D8516C9550B77083D13DB0832457BEF714BB4D9176042EF")) {
    var_13 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D8516C9550B77083D13DB0832457BEF714BB4D9176042EF")]](var_1);

    if(isDefined(var_13))
      var_12 = var_13.defaultslot == "_encstr_BA7F0830B3A7859B60B0";
    else if(var_1 != "_encstr_81C80E0C79E00F3BF583FB8FF5B0C278")
      var_11 = weaponclass(var_1);
  } else if(var_1 != "_encstr_81C80E0C79E00F3BF583FB8FF5B0C278")
    var_11 = weaponclass(var_1);

  var_14 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005"))
    var_14 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005")]](var_2.basename);

  var_15 = "_encstr_B40101";

  if(istrue(var_14))
    var_15 = getkillstreaknamefromweapon(var_2);

  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_20 = 0;
  var_21 = 0;

  if(isDefined(var_6) && isDefined(var_6.equipmentref)) {
    if(var_6.equipmentref == "_encstr_843D095F2B7D52B041D9A3")
      var_16 = 1;

    if(var_6.equipmentref == "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9")
      var_17 = 1;

    if(var_6.equipmentref == "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95")
      var_18 = 1;

    if(var_6.equipmentref == "_encstr_8C450D955CD52D07D7DC2BB6A39587")
      var_19 = 1;

    if(var_6.equipmentref == "_encstr_8BBB0B9D41E718D9E922D8582A")
      var_20 = 1;

    if(var_6.equipmentref == "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381")
      var_21 = 1;
  }

  var_22 = scripts\cp_mp\utility\player_utility::isinvehicle();
  var_23 = undefined;
  var_24 = 0;

  if(istrue(var_22)) {
    var_23 = scripts\cp_mp\utility\player_utility::getvehicle();

    if(var_23 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())
      var_24 = var_24 | 4;
    else
      var_24 = var_24 | 2;
  }

  var_25 = 0;
  var_26 = 0;
  var_27 = 0;
  var_28 = 0;
  var_29 = 0;
  var_30 = 0;
  var_31 = 0;
  var_32 = 0;
  var_33 = 0;
  var_34 = 0;
  var_35 = 0;
  var_36 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA");
    var_25 = [[var_37]]("_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F");
    var_26 = [[var_37]]("_encstr_B8251D93206B463FB9B9FCF9D823F78E99300B6A2047BF171313E015ED88FB");
    var_27 = [[var_37]]("_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8");
    var_28 = [[var_37]]("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA");
    var_29 = [[var_37]]("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
    var_30 = [[var_37]]("_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95");
    var_31 = [[var_37]]("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
    var_32 = [[var_37]]("_encstr_990810B8796F28FB0B6193B21770B42573B3");
    var_33 = [[var_37]]("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735");
    var_34 = [[var_37]]("_encstr_9A360EC74F39AA043E1D2333C71D30C3");
    var_35 = [[var_37]]("_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B");
    var_36 = [[var_37]]("_encstr_966512DB9F092FC45BF0CB1381BF3BE3A190584F");
  }

  var_38 = routers_picked_up(var_1);
  var_39 = isDefined(var_38) && turn_on_have_target_hud(var_1);

  if(!(var_0 & 1)) {
    if(var_7) {
      if(var_39) {
        if(var_0 & 8)
          _id_12C3F(var_38 + "_encstr_BDD8179ACF8FFB33E778C76B2F224B7A69AD99B71E20CD9D09", 1);

        if(var_0 & 4)
          _id_12C3F(var_38 + "_encstr_B8C1142ACFCF336BD83F48E38A3A1C3F184DE9818AD0", 1);

        if(var_0 & 98 && var_1 != "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB")
          _id_12C3F(var_38 + "_encstr_B4B40C186AE2A90BF729F8EF0697", 1);

        if(var_0 & 32 && var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" && var_1 != "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB") {
          if(!isDefined(self._id_12D7B))
            self._id_12D7B = 0;

          self._id_12D7B = self._id_12D7B + 1;

          if(self._id_12D7B == 3)
            _id_12C3F(var_38 + "_encstr_BAA61F44AD73CB8ACFC0F1CF09058773E806C4FD3E9EC7D58758EAA2210FFE3FC1", 1);
        }

        if((var_0 & 4 || var_0 & 2) && var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0") {
          if(var_8 >= 8)
            _id_12C3F("_encstr_8C57428E27D71BA17D3BC6DB982CC6FAC859CDE827DEE5BE58B439C6E416CC1DD7DDA51D1AF5B1165773C61AAC2737AFCCED39BEDBE059930B1DF6277D5B96DC9BD2BD9B", 1);

          if(var_8 >= 11)
            _id_12C3F("_encstr_B19A4570368FA119316781183E8A496E1CFFC0E8F3473ABFFA8C8616126295B37FDFA86003DFD0FB437576AB2F6BC71EAE27F8C1B7A809952A1B78AE89F23BC3039788C00F434B", 1);
        }
      }

      if(var_0 & 32) {
        _id_12C3F("_encstr_95D0318E937DD80DD77636F6315836FA8CAC6EA34E7B5E7D672B0D2D6C36CAEB33F64E7D7B0E954EB01DF6C9F5BACDB17B8DD6", 1);
        _id_12C3F("_encstr_8A7B32551BB98E4051318847126ED909B3312BC3F375E950AB58192871A8628E76581D67C887EFBE472C1A0A28B08C97B02CBD45", 1);
        _id_12C3F("_encstr_814836232B908EB37911D0CFA0B082C8514033B3BB57B960036DE042AF40CF1906E063797BD0DFDB993CD83329D3A02777C0FF7050D727AD", 1);
      }

      if(var_8 >= 7) {
        if(var_0 & 8 && istrue(var_16))
          _id_12C3F("_encstr_B61F3B93CAF92E7917C01330FECF280FCBB6C5C6012B39DF8F141FB2695F86CF220A98A505E9E3A780D0105A79CFFB02C78370031E932A8D927B77E3B7", 1);

        if(var_0 & 6)
          _id_12C3F("_encstr_977021A3277D1B34AF9D8DED982C36AF91B2E6D193B797D7162D39B19C0B66E8F53762", 1);
      }

      if(var_8 >= 8) {
        if(var_0 & 8) {
          _id_12C3F("_encstr_A6252C3A9CBEC6437DEC36EDC4B0D8F5B3E47BABB946F59D56862D6CC695D7232B6E1DC9EAC6D1D2ED73DCD7E691", 1);
          _id_12C3F("_encstr_9A9C3E5CC2E1FF89F0345A4FF33ADA56AC33B8AFCB7B7143BD4CB84F41BF51B9638333C07DA78B7BE848B077B6A712B9D5FB3DFD8B05552209B3438B4B84F5CA", 1);

          if(istrue(var_18))
            _id_12C3F("_encstr_871636BDB1F7E14141EAC0D092E6113E5391C83D7F8768853771A0203ABBDD91472EC5A3D15770EB912AB820A392D30943A9582823FFDB8D", 1);
        }
      }

      if(var_8 >= 9) {
        var_40 = isDefined(var_5) && (var_5 & 65536 || var_5 & 4096);
        var_41 = var_15 == "_encstr_B270105ECB28E94BC5CFABAB937D524C5053" || var_15 == "_encstr_B1B30B51D176511E377A1BC313" || var_15 == "_encstr_8CC008133958C81BACCB" || var_15 == "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A" || var_15 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";

        if((var_40 || var_41) && var_0 & 32)
          _id_12C3F("_encstr_87862FF8CF89A768171741C8EA1710172B9290A8C21DD3C6D33DD6BDD26FB91954DA38911A356F3B8F28D33ED477E6DFAA", 1);

        if(var_0 & 32)
          _id_12C3F("_encstr_850A35EB4B980258D1C905CD41089419ED1B0F634538EB37E0913C5499B8A551B4B78357D7DF92D270DBF59A36D8E16B96D36F1BCF863F", 1);
      }

      if(var_8 >= 10) {
        if(var_0 & 34) {
          _id_12C3F("_encstr_A63A44E89CBED843EB3BC6DE132C1BBE32CA37479CED5EFAB3CAD09636C6B2F5F6E47D9B8DEDC9CADCD1279558B5D799ED27BEB7072B9C2CA3DE93F5DAA5E66EA5DE37EBE643", 1);
          _id_12C3F("_encstr_B2632FC0D35E7750EEE18D5FFB3A9D9FE92D3E75FB70507913D2B8D73ED83BD9C07B6753C2C526B8AF0BFB13592CD8A0C7", 1);
        }
      }

      if(var_8 >= 11) {
        if(var_0 & 34)
          _id_12C3F("_encstr_B63A44E8C9FAD8D0AFB3C6DBC4588D7DC8CA6E47E4BDCBD7CEB2344BD8362BAFDE4EF59BD8DE932BCD1D3959B05BAF99ED9CD77BE09539168EF69CAF6B5A37B996ED9BAF9BA9", 1);
      }
    }

    return;
  }

  if(var_4 & 8 && isDefined(var_2) && isDefined(var_2.attachments) && var_7) {
    var_42 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
      var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

    foreach(var_44 in var_2.attachments) {
      var_45 = "_encstr_B40101";

      if(isDefined(var_42))
        var_45 = [[var_42]](var_44);

      var_46 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 5, var_45, 2);

      if(isDefined(var_46) && var_46 == "_encstr_A3840610E27448B6") {
        var_47 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_44, 11);

        if(isDefined(level._id_139E1[var_47]))
          _id_12C3F(level._id_139E1[var_47], 1);

        break;
      }
    }
  }

  if(var_39) {
    _id_12C3F(var_38 + "_encstr_8860051A109B1E", 1);

    if(var_7) {
      _id_12C3F(var_38 + "_encstr_8E8D0697EB01F243", 1);

      if(var_9 % 2 == 0)
        _id_12C3F(var_38 + "_encstr_847F0DA4CB5942FB03930F27F05EF3", 1);

      if(var_9 % 5 == 0)
        _id_12C3F(var_38 + "_encstr_857F0DAD4B1B8D37D1C9ACB0B57D4D", 1);

      if(isDefined(self._id_12A86) && isDefined(self._id_12A86[var_2.basename]) && self._id_12A86[var_2.basename] == 2)
        _id_12C3F(var_38 + "_encstr_A76C0C6B5DC63AB4B59663B1F523", 1);

      if(var_4 & 268435456)
        _id_12C3F(var_38 + "_encstr_A1E520BF8350107F30D8E3B7C10EE3F0A0617A39C34DD9B97B206F2F3B82FAAE18A2", 1);

      if(var_4 & 4096)
        _id_12C3F(var_38 + "_encstr_8F11185BD21B63EBB2E6955BE5D7DD862BDCBE969B53D539ACC8", 1);

      if(var_4 & 256)
        _id_12C3F(var_38 + "_encstr_B6CB19D62DD8367DCAE62BD6F2EBDDA15A63B2BEDCC62D32967376", 1);

      if(var_5 & 1048576) {
        if(var_1 == "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB" && !(var_5 & 1073741824))
          _id_12C3F(var_38 + "_encstr_B43D21C4307874E1BDD5974F03489BB198983D4F6E680F2B85C5776B3D0872D7A0A073", 1);
        else
          _id_12C3F(var_38 + "_encstr_A2E31C78680968E90BDA0D4AF76C407E1A575E109F4839B6A8BBEAC09742", 1);
      }

      if(var_5 & 524288) {
        if(var_1 == "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB" && !(var_5 & 1073741824))
          _id_12C3F(var_38 + "_encstr_B43D21C4307874E1BDD5974F03489BB198983D4F6E680F2B85C5776B3D0872D7A0A073", 1);
        else
          _id_12C3F(var_38 + "_encstr_8DDF1E6D961B63FA91B2472B6CD1CA8CBEE6D1D5DC375623F598B196DC195932", 1);
      }

      if(var_4 & 262144) {
        if(var_1 != "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB")
          _id_12C3F(var_38 + "_encstr_B43D21C4307874E1BDD5974F03489BB198983D4F6E680F2B85C5776B3D0872D7A0A073", 1);
      }

      if(var_4 & 4)
        _id_12C3F(var_38 + "_encstr_87C411C4168D5BE6A3588913CA397DAD5AC68D", 1);

      if(var_4 & 262144)
        _id_12C3F(var_38 + "_encstr_BD7E0E481DA6F076526709575F6A3170", 1);

      if(var_4 & 1048576) {
        if(var_1 == "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB")
          _id_12C3F(var_38 + "_encstr_B4B40C186AE2A90BF729F8EF0697", 1);
        else
          _id_12C3F(var_38 + "_encstr_96D30A3468575BA3C307A128", 1);
      }

      if(var_4 & 1) {
        if(var_1 == "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB")
          _id_12C3F(var_38 + "_encstr_BAA61F44AD73CB8ACFC0F1CF09058773E806C4FD3E9EC7D58758EAA2210FFE3FC1", 1);
        else
          _id_12C3F(var_38 + "_encstr_8FEE1D63C8B4C3395DF55785484FAA4AC0C136BDF5039031D11FA3F223BA1A", 1);
      }

      if(var_4 & 524288)
        _id_12C3F(var_38 + "_encstr_9A6B11C2EF484530C6BA69F3383716729743B4", 1);
    }
  }

  if(var_7 && var_5 & 256 && isDefined(self.weaponlist)) {
    foreach(var_50 in self.weaponlist) {
      var_51 = "_encstr_B40101";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
        var_51 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_50.basename);

      var_52 = routers_picked_up(var_51);

      if(isDefined(var_52) && turn_on_have_target_hud(var_51))
        _id_12C3F(var_52 + "_encstr_9A7A14CCD2735A37D0A573D9FADAB73B2BEBDAB41BD8", 1);
    }
  }

  if(var_7) {
    if(var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
      _id_12C3F("_encstr_819D35417189C18BD18239403E8799A91AB2A3B0988762386B18908738F8260B8F70F791D77A46DF43670253DB1F9A691A7293AF9942A8", 1);

    if(var_11 == "_encstr_A1100738A33A638123") {
      if(!isDefined(self.intel_guys))
        self.intel_guys = 1;
      else
        self.intel_guys++;

      if(turn_on_have_target_hud("_encstr_A95A155ABB07EBE686FA1D4E66D5D88D16D5A37BAFB607") && self.intel_guys == 3 && !istrue(self.shouldzombiespawntags)) {
        _id_12C3F("_encstr_A2F434818E99DE3027A708600EC1C818F3733F199F4310C13B3CF01872BC704D0A97E71FE7DA68907793D9B1DA9F68E8231B09DFBFD2", 1);
        self.shouldzombiespawntags = 1;
      }
    }

    if(turn_on_have_target_hud("_encstr_9709192DBBC1EB0B4ED74772CCC29B1DD0589B1936A537767DAD83") && var_11 == "_encstr_965306392D3336B2" && var_9 == 3 && !istrue(self.shouldreflect)) {
      _id_12C3F("_encstr_821C341560D9EF287F8770708B99605FC21A0E17CB4299B62397786027A4FB536A84908629BA67DB2F9708F013C7B0EF736DF120BE82", 1);
      self.shouldreflect = 1;
    }

    if(turn_on_have_target_hud("_encstr_AAF315CFBB423192DD3920EB5881234C649838B9EF95DB") && var_11 == "_encstr_BE1904DCDA9D" && isDefined(self._id_12A89) && self._id_12A89 == 2 && !istrue(self.shouldrespawn)) {
      _id_12C3F("_encstr_BA812F10DA7F06890937D080B510E0DFC7DDCFBF6B3D5DB558C27BDC8DE86A68BD65F5098FFAC7A710DE69F01E9AF09170", 1);
      self.shouldrespawn = 1;
    }

    if(var_11 == "_encstr_850707F7E5833355B8" && var_4 & 1)
      _id_12C3F("_encstr_938B3FDBE239A33A187F1B1F5D3F422730705525C63066A2693BCF275DD5B952B878CDEF1B8923CAB3012F5BD70CE29A41604277B3C0EC921647772FB7AE4ACF10", 1);

    if(var_11 == "_encstr_92590EFBF91ED25750D8D7DC30B88E8A" || istrue(var_21))
      _id_12C3F("_encstr_B2FA2FD3C3618A3B26EFF49A5993A0A063E9C1109982D338EF3B34DCB9C998556F30636FDBB8C96FA6CF9FD1430701C896", 1);

    if(var_1 == "_encstr_ABDA14AAD3233F1D60EF2C59B108261B200BF33178DF") {
      _id_12C3F("_encstr_8457356B8E91BEE078AFB45DBB073C29A848E3FADB27EBB879A73FCBB316D41B290301C390BA47DAD8BFB31A6007209F0A70D3F320F0B2", 1);
      _id_12C3F("_encstr_8F7E39AD9F3981B86FD9F01881F76360A0266B025117041FA129F01393616C20186376760F38A9FDD8DA92F8C39FA37FCDCF431FC0B0CAC9323BEA", 1);
    }

    if(var_5 & 1073741824) {
      if(isDefined(self._id_12A86) && isDefined(self._id_12A86[var_2.basename]) && self._id_12A86[var_2.basename] == 2 && !istrue(self.should_enter_combat_after_checking_smoke_grenade)) {
        if(turn_on_have_target_hud("_encstr_8D511912FF3A89F8DFDFDB1B172CCD90725AACC35270A96591B293")) {
          _id_12C3F("_encstr_A580396BEBC74AE86EB02327B081D43107E8B467BD9FF22771503777183E9D5BF17D3C5C13112A4F73A11B1740165F0243970595909B42B4E058D7", 1);
          self.should_enter_combat_after_checking_smoke_grenade = 1;
        }
      }
    }

    if(var_9 % 5 == 0) {
      _id_12C3F("_encstr_ADA92E89598940632F3AC8D012AF29E9DC913101BBAB303DFFD2A693E99B505879FF919B425648706B89FBE0C2671ED8", 1);
      _id_12C3F("_encstr_A23E2F4D3881B76037FF3828C321B897AA54C9D9028B5D09F1D799E24F7E1005317DBFD5DA32E930CAEF6B08D783E8478A", 1);
      _id_12C3F("_encstr_8CBB33DDA81127D0874FA8B833D128273A245969927BCDB961472912DFEE80B5C1CDCF652A8299A05A7FB0F8471318D73A79C87792", 1);
    }

    if(var_10)
      _id_12C3F("_encstr_B22B2E80B7F1EF204F5F09F032DFE8CF25DBF8082A143378BB7F2EE00E3FD3070DF338A0426B47F39F659BEEF30F38DD", 1);

    if(istrue(var_14)) {
      _id_12C3F("_encstr_B8CD37F3332FEFEBA19ACBEDF237095E9AEA7D4AB743085B5817DE7B921B75CBF388BFFF3B79B6DFE3B71F4025F3A6D320D3393792DB40E780", 1);
      _id_12C3F("_encstr_ADE53899F66F37B859AA796FBAB1A189272C448BB9600ADBCB789E87D72B5F9F2532E18E07A129B742AE17FB191AD948656AA9384B4F174B18F8", 1);
    }

    if(istrue(var_12) && (istrue(var_25) || istrue(var_26)))
      _id_12C3F("_encstr_8A7551D5A0192FE8BF47B0B04BD9201F52DF4D530E828F706143B83977F9FB89C942456F22DBB31B5D8F7818071AD6CFC361BEE5FAB31FE1335F6898B32BEE057AD2A078921AEDE9F4876051D771A367A23DA0", 1);

    if(var_5 & 524288)
      _id_12C3F("_encstr_AFD637241BA7CB03011C5B1F72C0305FC2D08069D898A534C3D6D8CFC9A9CB1D2DEB1F9BC7804DF09A81473287D266B46D73E96B153B5F415C", 1);

    if(var_5 & 256) {
      _id_12C3F("_encstr_A68A35E84EAF6CD0EBCE8DDB13858DAF3396CD2D9B4396B9B37DDAED67CAFAB6D2C636BECCF693EBB7E059C9B08EED397DAB73D87B1B5B", 1);
      _id_12C3F("_encstr_AB383653D3EF6230B658DBCF68A9FC6965035D8C5E299A4ED9B1D7C720019752D32925894C7FE3B7E0B0CF4BA05B6F0BE731EC3AAE9B8ADE", 1);

      if(!istrue(self.show_balloon_deploy_hint) && var_5 & 1073741824) {
        if(!isDefined(self._id_1440A))
          self._id_1440A = 1;
        else
          self._id_1440A++;

        if(self._id_1440A == 2) {
          if(turn_on_have_target_hud("_encstr_AC411698A3D8677077B7D56B778F78F3B02AD018FAA94BAB")) {
            _id_12C3F("_encstr_ACD143A3C9F5B10DD7B38DF6260B637DD6E6B499B2AF8DDBB032BDEAA3BE9996DC2DDC8696DC76BED6DEB32BFAB62DD88DFA91BECCDB27AFBBCA0BC1DBDCD757378DBD8DDA", 1);
            self.show_balloon_deploy_hint = 1;
            self._id_1440A = undefined;
          }
        }
      }
    }

    if(istrue(self.gulag)) {
      _id_12C3F("_encstr_93AA3CD127BE6C86BEB336ED13168DAFEE2DB97D7B7359EBCEF5BDDCACEB859BBE1C39A5DCBD37CA9CF533DEC9EB7B0E9527B0E8BDE47DD6D2B9B94BBD9B", 1);
      _id_12C3F("_encstr_A18240AC9B0123706FC8FBE2FAB9A82117333B279018C807A379C760320F2670680B4B8B4B1A9DD71BA9ED0DAB37D8488F7A5E5DF7706FF95090C0446F62667DC00A", 1);
    }

    if(var_4 & 512 || var_4 & 1024)
      _id_12C3F("_encstr_BEAA457B32DF67381FA4BB27EBD1FD0F93A0718847283EE7595209EFD008C4673F97129AA348BB28C03F804388E0CA3060AF11171FF3BFC010375A09DB479AF115FB93A348703E", 1);

    if(var_4 & 1048576)
      _id_12C3F("_encstr_928B2C09061156A8AF2F70E896794080BADF9BA1B70A2810BB0939E0BA1F204FC27B1319AF13F810C91A8338E506", 1);

    if(var_4 & 524288)
      _id_12C3F("_encstr_B8D033F3332FEFEBA19ACBEDF237095E2B8A3C6A9CC150DA1075D247D2AA7C28392897760F7AA0CBE34F73B83247A570C0F35A5F92", 1);

    if(var_4 & 262144)
      _id_12C3F("_encstr_AAC8301D93AFC686FAD91B7B9885C6BE1BB79B9DCD86BD477DD62DD8C6AFCCDE4ED7ED1CCAC91647B793F5B65A37DCB4B7CD", 1);

    if(var_4 & 4096)
      _id_12C3F("_encstr_96833A831809D709AF59C2E2464848AE5F9019094165588D03C2A778DB0D9B672CF0DA7BDD82B4279DD83D97A8437BC83FF3CA0E305D2223EF3307FE", 1);

    if(var_4 & 2097152)
      _id_12C3F("_encstr_B6034185F0497FB8EF37C0E01BE9F0CFD20C7101F142DD41B5275128DB0FAEFF9AF5F91D9799A189616FD880B35DE62D421AF890EA9275715C4F2879FF79BB7FCAC5E8", 1);

    if(istrue(var_16))
      _id_12C3F("_encstr_93D236E0E3475798F920808092F9C9C730C943402B1B03F088D81E8B672D6130D84919010A9FEA17A7DFCFFB5F557DEB4F8A5B305383C22D", 1);

    if(istrue(var_17))
      _id_12C3F("_encstr_B66F2F8E72EBC6A1EBECB1B78916B1EBB6DB36DB1DF6D9F56D4BC68DFA33DB27F5DE079527851DED4EBEAD96CD9BD2ED9B", 1);
  }

  if(var_8 >= 8) {
    if(var_7) {
      if(istrue(var_17))
        _id_12C3F("_encstr_B66F2F8E72EBC6A1EBECB1B78916B1EBB6DB36DB1DF6D9F56D4BC68DFA33DB27F5DE079527851DED4EBEAD96CD9BD2ED9B", 1);

      if(var_1 == "_encstr_ABDA14AAD3233F1D60EF2C59B108261B200BF33178DF")
        _id_12C3F("_encstr_A37E39E827EB1B1AD7B31BED985863D7DA9BB4CC56F58DB7C2467BEA3AFAD64B63B1F533DB937DDEC1959C583AED9CEBB5D2379B4BF6CDBEF61C33", 1);

      if(istrue(var_14)) {
        _id_12C3F("_encstr_82A03C0BC8D790BB610779773BAAF1298BB47080C947086DEAFF7F7777C34D804CCAD9B96C87C8A863174F59772B87C0FF2206B014F32853EAEB371F3B17", 1);

        if(isDefined(var_15) && (var_15 == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" || var_15 == "_encstr_A2E60C6BC099B7E1A0A93A398F48"))
          _id_12C3F("_encstr_93823FFDF1B7A10101AA8090D2A6D1FE8F5909793FAFA871B43140E8FABA8B33ABEA0567936753891A3A88D0D1D7A7EBAF6F17EDE2477BF7C261A0480BAA63ED93", 1);
      }

      if(var_5 & 8388608)
        _id_12C3F("_encstr_8FF22FD38B2F981128F7734F8A5A912162D01D1DD90911A740284ADFE7333F4DE9A00B4942012BF8C669AF841F868FD020", 1);

      if(isDefined(self.waitillcanspawnclient) && gettime() < self.waitillcanspawnclient + 20000)
        _id_12C3F("_encstr_AFC13D13B3108AD04941BD45D980EC81D28BFB8B97A5E295B0EA79CEB1C02D0BA0177F5759DB2B417031611788A84F128F4393AF1170B33F40D8625A6068B6", 1);

      if(var_4 & 524288)
        _id_12C3F("_encstr_A52837DB6317CE24794FD272CE6FD839F39DB8F5786135B8EE3807B7C004E990B6A9E00581C09F4F659773E0BBA1554B63DB3A8AE5E9405B0D", 1);

      if(istrue(var_16))
        _id_12C3F("_encstr_954B3A479CEBD81AD7B31BBDC48563F5E6168E6C1A591BBE1B43C2E4CE95AFB5961BB1AFCCDB277D7B83CA270B8EBD27BEB6D2376E5AF6B9EBB78346", 1);

      if(istrue(var_19) || var_1 == "_encstr_8C450D955CD52D07D7DC2BB6A39587")
        _id_12C3F("_encstr_A3132EABDBAE2242988FCC58907A0266A6929BEB3D4AAF870BA0901F7F50E671A0931502C1E838A0B00839AB92870AD8", 1);

      if(var_11 == "_encstr_965306392D3336B2" && var_4 & 1048576)
        _id_12C3F("_encstr_B1A0341D72BED843BE9DB1DB890BC67D342BB091DC1AB7D16ED716DC9B165DD83ABECCBD27D7DB83CA392CD1B7E4F5D64B9B6EB47B73", 1);

      if(isDefined(self.plantedsuperequip)) {
        foreach(var_55 in self.plantedsuperequip) {
          if(isDefined(var_55.origin) && distancesquared(var_55.origin, self.origin) < 640000) {
            _id_12C3F("_encstr_B15F45D4D3597E0BAF597A3281675339A0DB7444873807F7BE76523A2850AB6FF0A1F1DC6FC04CAF69095983F3949B268813575EB70819BF0FC183CA9BF843116893F3B3D3381D", 1);
            break;
          }
        }
      }

      if(var_5 & 536870912)
        _id_12C3F("_encstr_A2263483BA61FB12204733C7B5D79A0F3018FF0C8BB88EBA07791F0F8F8BE2647026375523B147036D5D17BB9F2E19ADD80BEA5C38D0", 1);

      if(var_5 & 4194304) {
        _id_12C3F("_encstr_8DED2BBDB1F7E14141EAC0D092E6113E3791C4A04B97C881B9E2E020393DE1B1F3394D20CAA750F39A5BD8C002", 1);
        _id_12C3F("_encstr_B8202FE84EF5D8A1BEB3D87B980BD8FA572CB37DD64B63D8FA99F639AFDBE0AC9CC21DB74ED7AD4B37CD2DB7E6F5B70723", 1);
      }

      if(var_11 == "_encstr_92590EFBF91ED25750D8D7DC30B88E8A" || istrue(var_21))
        _id_12C3F("_encstr_95FE33A327FAD843D7CEC6F69885367D3485478D1ACAD1D75BB41B63D766DE4EEBB7E0CA390B1DB7937DB62DE6DC96F69BAF7BE064", 1);

      if(var_4 & 262144)
        _id_12C3F("_encstr_854A341DC9EB8D1AF53B8DB7138536FAB1DE9B9DE686DBD1FADAD28D1BEB99DE27D7F60E59390B47ED39F5ADB4CDCD4BF69BEBB7C191", 1);

      if(var_5 & 512)
        _id_12C3F("_encstr_97DF358EC9D7C643D7ECD8F6C416B17DB9B5BD5BACEB9D39B2E62C32597D6D96C663EB99B739D7ED0ECA272C8EF693FAD6969BDC2DB7DC", 1);

      if(var_9 == 3)
        _id_12C3F("_encstr_97332F34AAEF63C0EF7A202741278A588F388C25676D8B28C1A05E9B01724236173FB39F28E8BB1008BF73382F4E980F5D", 1);

      if(istrue(var_20))
        _id_12C3F("_encstr_8DCF34DDD1978121218A60703246F1DEDB22EFDCDF0FEB7355F2D838D99CB3F02BE7E4406A47B061FFEBF8B8B2F227685753F6CBDF5B", 1);

      if(self.recentkillcount == 2)
        _id_12C3F("_encstr_93AD32D127BE6C86BEB336ED13168DAFADAEB1D14B5B5A8D8DF5C8BECCEDC9FADE1CB2C958D1B7E4D7D64BE6CD2D7BCD7DF63864", 1);

      if(var_5 & 256)
        _id_12C3F("_encstr_AAF83AB38A51CB223057233745C7AA3F6068AD7C7B40993A740F2F3F85FDC173B050A549B1204AE1582937B3931D0AA259D81CCA8BF8EFAAB83F6BBA", 1);
    }

    if(var_4 & 16384)
      _id_12C3F("_encstr_87463D6BF7C7B02836C7C2CA5231D589D29FFF4FFFF039D3A3982190305AA5393F57592F3330F7D3AFB86F72F2434EEF90F7EDCF0B1D2BD1715F7FA3F2B740", 1);

    if(var_11 == "_encstr_8D940738966ED1DB8D") {
      _id_12C3F("_encstr_BD442E3A93EB8D0DBE76D87B8958B1AF56DAB42C7D38A5CDD1BD367D33DB27FABD38B2392C8EDB277D5BA59B9BA5ED9B", 1);
      _id_12C3F("_encstr_9A453280B7F1EF204F5F09F032DFE8CF273AD0A049D2339BDB4F01E00E3FD3070DF338A0426B47F39F659BEEF30F38DDF9AA082A", 1);
    }

    if(var_4 & 131072)
      _id_12C3F("_encstr_9192313B5AD00F9C715FF4CF6DB8A5B765886212FE9EAF9618A5F4C92510218B9803997AA37D3B4E98BFFAEF0348F297335802", 1);

    if(isDefined(self) && isDefined(self.modifiers) && istrue(self.modifiers["_encstr_B2D012A590EA7BF1495B39D593A0BD2FC7EB4DA8"]))
      _id_12C3F("_encstr_88E83A63570E018BDFACA5F8FBBA5287979030E6A3285FB09D9A010F234D8E7187524717976B89BE591FF2D00748D90D71ABAA13D91AA2E2EA689510", 1);

    var_57 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1"))
      var_57 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1");

    if(isDefined(var_57) && [[var_57]](var_2.basename) == "_encstr_9B65109F23E0F24FC016431A79258FEE4889") {
      _id_12C3F("_encstr_8E7B368E4ED7C6D0AF9D36BD4C0B8DEB2BB62DB0FA8E2CD8A396B10B63AF272D66D895BE33F64E7DB7E0594E85A3F69CD7B6A5CDE6B4DBCD", 1);
      _id_12C3F("_encstr_BAA23A5483F6970CAF30C20AE02BC5AF6902C1F928FBE796D1683AE2B87F3A2FA179554FDC206351BFB842CBC871B58BFE51D1FBEE084F2537281BC7", 1);
    }

    if(istrue(var_34))
      _id_12C3F("_encstr_AACE3DE8E4BE1B1AFAD98DDB4C8563FAACB696857DDD4BA334EBCC1B0BADD7A90BB1DACAD1FAC1959C5BAF99DB93F5DB382B4E58E87B27EBDA2DB99B5ABDE6", 1);

    if(var_11 == "_encstr_BE1904DCDA9D")
      _id_12C3F("_encstr_A60F2B63767FF760296123450ADF911F15CA3067913F38D101527FC2E1FFD2FA3283F85D330FF811EFBA010755", 1);

    if(var_24 & 2)
      _id_12C3F("_encstr_AC733FFBAFCF69D01FC1D3D0A6CE14A63F10C9CFD76703AC51674942E6DFEC3DF01348F9B793CA68C420AD4721DB273B07D8039D933F4D102BD99D424853588876", 1);

    if(istrue(var_30))
      _id_12C3F("_encstr_A27F42435A7EFB1A1F14B56D8E0B12BF41A0AF9FD1333143BBB87DE4674FFA5AAE20273F800E69EA9B4E8311DCC7632F70486FE35003AFD397E9CC12BE938AD61E48B37A", 1);

    if(var_5 & 2048)
      _id_12C3F("_encstr_958332D1E4BE6CD07DB3D8DE26C2B1BE2BB6A5C2BE91EDBBB9958C7DCCF69CEB7B0E569C1647DE27D7AD4BE63796F6B9EBF63864", 1);

    if(var_11 == "_encstr_A1100738A33A638123")
      _id_12C3F("_encstr_B10333D3EA31AB421077031765274ADF58080C1EDEB8780ADD1F6F1B375CA24AE110C2E7D3702CC23657773F97FE8A9FB07EBD2A43", 1);

    if(istrue(var_31))
      _id_12C3F("_encstr_B26733A3CB36E778CF27F9BF8D0163C8E118B0DE3710E01768D3A2832EE445DE7F485A572BF263DF25062D2F87BBD3384B7F08982E", 1);

    if(var_11 == "_encstr_850707F7E5833355B8")
      _id_12C3F("_encstr_92972E479CAFB10D7D761BDB2685C6D795B5A516F5E6B9A50EAC93EB66DE277D7B38594E583ABD27F5ADB4B9DC4BDEE6", 1);

    var_58 = self stopplayermusicstate();

    if(var_58 <= 35 && !issubstr(var_3, "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F"))
      _id_12C3F("_encstr_B1F150E8AE172991C9EF19908602D116954F98C8CF9282C792D298AC9ABA133BFDB3A1509F9F1863EA3C8D2539F35F80308719B85324312F3225F538CB69ADC89AD710A87FDA49C92A0AE0B1E443CFF0FFFB", 1);

    if(istrue(var_32) && var_5 & 1)
      _id_12C3F("_encstr_B21E513AC97DC634D7ECC6DE3158D8F52B6DA52C7DD5E62356E4BE56CD955BBCAF91ACD1956CA34BDE37D7EE4BE80D7D76D0EDE61D7D83B2E4D67D99F6E4EBB707CAE42C47DE9CFAAD4BE6CDA5B737FAB7E064", 1);

    var_42 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
      var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

    foreach(var_44 in var_2.attachments) {
      var_45 = "_encstr_B40101";

      if(isDefined(var_42))
        var_45 = [[var_42]](var_44);

      if(isstartstr(var_45, "_encstr_A3CA081B50EDAB3D60A9")) {
        _id_12C3F("_encstr_8D3D350570C9FF386FB740609B69704FB20C730771D351C12AF720708793A9778B37E01CD5CB7748F0CFA00B33D7C3DFE25C6E1E2CB2CD", 1);
        break;
      }
    }

    if(var_11 == "_encstr_BE0703A54C")
      _id_12C3F("_encstr_B6292B474ED7D886D7761BED130B36F5CAD6A558EBC66BB3D799BDE4AF7B1C56C92C8EBDC9EBAD5A6EE62DDE73", 1);

    var_61 = strtok(var_3, "_encstr_854C021F").size;

    if(var_61 >= 5)
      _id_12C3F("_encstr_A39E3D3BF8E7A08B315709076BFAC1F975C42D1199558930BBCF133F334280401C9B89A9FC652B7833577F25AF1BC8E8B0B7536163DF70B89A275F178F92A8", 1);

    if(var_24 & 4)
      _id_12C3F("_encstr_A28F3FA372D78DA1AF3B36BD89C236AF56ADD2B07DBB0DA5D856D75ADC7D852B934B58B1BEB35943D236D8CAFACCF693D7BD83B24E0B1DF627FADA96CD375AED37", 1);
  }

  if(var_11 == "_encstr_850707F7E5833355B8")
    _id_12C3F("_encstr_B8C32D2BBE7F6F285947D1A5FAAA5D47394A8A81E9D89398A1625617699F9B3F92090D5BBAAB4822698B603C857837", 1);

  if(var_11 == "_encstr_A1100738A33A638123")
    _id_12C3F("_encstr_859F2F0D78C1F72077BF7868836178578A140B1F49BBA98824A788788FBE504571BD7F959AF229700A2F404817C3A887CA", 1);

  if(var_11 == "_encstr_965306392D3336B2")
    _id_12C3F("_encstr_93102FB3330F82D056F87B6FC8C99C09C3A27C6EE89B5BF3B9AB730B09C14763DFC882E7E6C3632723690F47905B097A65", 1);

  if(var_5 & 131072)
    _id_12C3F("_encstr_B1DA3DDB7BA832680119F53D91D8A4491D773707CFE4DA4C60E62A844880FE42E5F167271307931F384B294F401007DAC71B6BF7A9B8FBF71810DA12B8204E", 1);

  if(var_5 & 16777216)
    _id_12C3F("_encstr_9744477B429903DAF89FFBFFFD9FE2472090B4862690C6C2C9BBC7F79FB4FAA349382CCD99E99FEB084FDFFFB76C93ED2801E797765857236047A3BF15073B2F902EDD1C6B58E9CAC0", 1);

  if(var_5 & 8388608)
    _id_12C3F("_encstr_8BDA2F536AB12BC290F78397E5A7CA5FD8888C9E5EB0FCEA5099AFB3B7DC22CA6190426753F0AC42B6D7F7BF177E0A1F30", 1);

  if(var_5 & 4096)
    _id_12C3F("_encstr_97C438BDB1F7E14141EAC0D092E6113E779B4BBF7FEF488B75D261F82A31EDB19B31C6A1DDA731FFDA99E838B292FBEB2FB240A9394FDB3BC5B2", 1);

  if(var_5 & 2048)
    _id_12C3F("_encstr_840A2ED33E60F7C0D6778517D311D12E9D37E4DBD9993753082BF259EE7FC209F7389DB3B36CE88267C2B0277A8868A8", 1);

  if(istrue(var_27) || istrue(var_28))
    _id_12C3F("_encstr_9BD24D0C0B81A6232861526AE91F0B11F8379961AF986C9B6B9ECBB2D1784756B09F37E74D3176970DD342FA3ECBAFCAA07B8E758989BA4F362889D2ED1E1F4558D32AF93160C2DF512D438B28F823", 1);

  if(istrue(var_29))
    _id_12C3F("_encstr_84CE345390BFF8D3196F21DF830229D15D9C7849A1EBE09982A735D19FCA6558F47901ED926F284FCA0B2BF9874320D081CA2B587DB6", 1);

  if(istrue(var_30))
    _id_12C3F("_encstr_97A93EE3E098FFD1976740AA32E721A97220CC5F50C3FFA361E5326CD8B1A8DA10616B2781A1217B6FFA1470FBCFF36F5291051DF65027CDC75D0AF283075FD0", 1);

  if(istrue(var_31))
    _id_12C3F("_encstr_96F42FADA1E7F17171DAD0C0E296010E676BBBAF6F931BABA6228050296FCF633707BF15BA6F83EFCA89C880C3C29B981B", 1);

  if(istrue(var_32) && var_5 & 1)
    _id_12C3F("_encstr_93234D2550E9DF184F9760807B89506F926C13275123BDC15DEBF1D863A5087B99579D35B7FA41A80F83E95067EC60FF62FCB73E4BD11111FAFFE1D01702DE27BB27064FA38ADD1EDDCFB840372730", 1);

  if(var_8 >= 8) {
    if(var_7) {
      if(istrue(var_17))
        _id_12C3F("_encstr_AB7733A34357BACC5F2729107A36A06F117772082BDF5BE7301FBD40DEBE3D56F0074892228FA4A0C3D1BB814BE6E3DF9DEF3F47E2", 1);
    }

    if(var_5 & 1073741824) {
      if(!isDefined(self._id_11BC2))
        self._id_11BC2 = 1;
      else
        self._id_11BC2++;

      if(turn_on_have_target_hud("_encstr_9A18124BEE1CD7DA56AF1D9CCAD1DB7B63BEAD38") && self._id_11BC2 == 3 && !istrue(self.shouldrecorddamagestats)) {
        _id_12C3F("_encstr_B8BD3AB3AF478670F94FF9C7725E98404F32E879F2EF49100E24F7FB8C0998133BAA23A32B7F77F8A96B8FC58F2A71E4A712DB48923FB5A8BD1FFFD7", 1);
        self.shouldrecorddamagestats = 1;
      }
    }

    if(turn_on_have_target_hud("_encstr_A62814B4BB70BE6B95EB3A27DAB0C686B2E82BFAB507") && var_4 & 4 && !istrue(self.shouldspawndropscommon)) {
      _id_12C3F("_encstr_A15E300D01475191913A30204236A16E1BC11E0AA333D9CD8662D899CACC6940976E907E37570113EAEA3091C32531F8CF1B", 1);
      self.shouldspawndropscommon = 1;
    }

    if(turn_on_have_target_hud("_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB") && var_4 & 1 && isDefined(var_3) && (var_3 == "_encstr_B40101" || var_3 == "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F") && !istrue(self.shouldplayerovertimedialog)) {
      if(!isDefined(self._id_1202C))
        self._id_1202C = 1;
      else
        self._id_1202C++;

      if(self._id_1202C >= 3) {
        _id_12C3F("_encstr_9B1C46D4236E76FBC111C2CA616FC281E38080A99F8D9EE7B7A3D83F509A775E1BA90DBDBB81A59D6658A414B07FB3389F8853EE172FF623482E57B06D388A8798394306B490F2AA", 1);
        self.shouldplayerovertimedialog = 1;
      }
    }

    if(turn_on_have_target_hud("_encstr_B409136447BAD80B83AF9CFBE7B1F6376882816037") && var_11 == "_encstr_850707F7E5833355B8" && var_4 & 262144 && !istrue(self.shouldspawnloot)) {
      if(!isDefined(self._id_13DBF))
        self._id_13DBF = 0;

      self._id_13DBF++;

      if(self._id_13DBF >= 2) {
        _id_12C3F("_encstr_8EDC369B27CF47A12F3F50C05BFA19E7B00D2B104348E7F9FFE83C01E169505DFCCFB7DA57F5C72E38C260BC2B5753DFCBA1ABA8A468CF44", 1);
        self.shouldspawnloot = 1;
      }
    }
  }

  if(var_8 >= 9) {
    if(var_7) {
      if(turn_on_have_target_hud("_encstr_A3BF1B2DF308C9816A3FA123D3725918E14A2B981EB3984B72BFFF83B3") && !isDefined(self.chopper_watch_death)) {
        if(var_4 & 1)
          self._id_1202B = 1;

        if(istrue(self._id_1202B) && isDefined(self._id_11BC2) && self._id_11BC2 > 0) {
          self.chopper_watch_death = 1;
          _id_12C3F("_encstr_81295484632146FA2F2ADA6AC6F951010F2AF56A0807323DEF53B97FF89081E205C078C7511768A208C157797980F759EFBB172350F869B2E44BC43127F2CB8315880AB065F954E7161B2F33CF4D23639D1B30E920B6", 1);
        }
      }

      if(var_11 == "_encstr_BE1904DCDA9D" && turn_on_have_target_hud("_encstr_AABA15182358E733D73755EBE107F94B32AA68F019A5F1") && !isDefined(self.watchspawninput)) {
        if(!isDefined(self._id_1341B))
          self._id_1341B = 1;
        else
          self._id_1341B++;

        if(self._id_1341B == 3) {
          self.watchspawninput = 1;
          _id_12C3F("_encstr_AB9633482307A9B037F7DCA8B87B281FEF8B8971D7A1913543249802689AE7CF111A2252CE6FEA6EA7FA1AA17D18CD8D632C712BE3", 1);
        }
      }

      if(var_11 == "_encstr_965306392D3336B2" && turn_on_have_target_hud("_encstr_8660192DEEE0D7854EFA8E4EDC8DBDEE0D0BB9C88DA59BB3EBB50E")) {
        if(!isDefined(self.pendingtimer) && var_4 & 1048576) {
          if(!isDefined(self.cargo_truck_initomnvars))
            self.cargo_truck_initomnvars = 1;
          else
            self.cargo_truck_initomnvars++;

          if(self.cargo_truck_initomnvars == 2) {
            self.pendingtimer = 1;
            _id_12C3F("_encstr_91D53058CE899AD3372FC975DAFBC967211EA948A5AAD742B0519819AA3FE8A5468984FFC75BCFF06740C82805B2B2094BB2", 1);
          }
        }
      }

      if(turn_on_have_target_hud("_encstr_823F1680DB4A08A802C779FBE62EF065DB137B4B537F5958")) {
        var_57 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1"))
          var_57 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1");

        if(!isDefined(self.playerzombiesetradar) && isDefined(var_57) && [[var_57]](var_2.basename) == "_encstr_9B65109F23E0F24FC016431A79258FEE4889") {
          if(isDefined(self._id_12A86) && isDefined(self._id_12A86[var_2.basename]) && self._id_12A86[var_2.basename] == 2) {
            self.playerzombiesetradar = 1;
            _id_12C3F("_encstr_8225316510A99F580FD72040BB4990AF436A48619B7249A013C7285067320E055A12C0F4771A0928CE07F858B3B7C157A1FA6E", 1);
          }
        }
      }

      if(turn_on_have_target_hud("_encstr_B87610432B774F408D9F781A43A13B174A92") && var_5 & 1073741824 && var_5 & 4194304 && !isDefined(self.cinderblock_damage_monitor)) {
        self.cinderblock_damage_monitor = 1;
        _id_12C3F("_encstr_A7603D1D93BEC686FA3B63F6260B8DBEADAC36CA59BEDD562CC1B7DCF56DD2B1B1AF32561D951BE89546EB99F6E4EBEE9585C1B737F5D573C6DE6C6DFA6E99", 1);
      }
    }

    if(turn_on_have_target_hud("_encstr_A90415B3BFE7C8E819A1F3A217EDC099AA1F313787DA27") && var_11 == "_encstr_8D940738966ED1DB8D" && !isDefined(self._id_127D6)) {
      if(!isDefined(self._id_1237A))
        self._id_1237A = 1;
      else
        self._id_1237A++;

      if(self._id_1237A == 5) {
        self._id_127D6 = 1;
        _id_12C3F("_encstr_9BA530C0863F3189A1977188AE3AF9FE785F707877D44E5BCA3CFF9853F12520C2EFC878B760ED1551236019DDEA676E2BE6", 1);
      }
    }

    if(var_7) {
      if(var_5 & 1073741824)
        _id_12C3F("_encstr_95503793F27857C419279C97C50B0D5F99918A0AC1D04FFFB031876EA76814DBB14EA2124B88F772B85D817CEFC851076B630BFA70F87FEAF2", 1);

      if(isDefined(self.waitillcanspawnclient) && gettime() < self.waitillcanspawnclient + 20000)
        _id_12C3F("_encstr_A5EA401BD8C780AB513769674BDAE1199BA48090F92520D5AA77170343B3BDB817BAE88ADF81B89BB2E71F054F3BE808D097B30143FF5058FAC77F37AFB248418BFA", 1);

      if(var_11 == "_encstr_92590EFBF91ED25750D8D7DC30B88E8A" || istrue(var_21))
        _id_12C3F("_encstr_8E0E321D68D1E710478F6878739168674AE6952E942A81BE2B8F70989FAE4075818D0FA56AC259601A3F70B807D35897FA390616", 1);

      if(isDefined(self) && isDefined(self.modifiers) && istrue(self.modifiers["_encstr_B2D012A590EA7BF1495B39D593A0BD2FC7EB4DA8"]))
        _id_12C3F("_encstr_97253D9493193E4B40193AF241A793F92097360B931042177010017A6B8DE32EB07B8F9BC3504D07AC28CBE1D05F0722E0F1270A17B0548FCE8012FABE3606", 1);

      if(self.intel_guys % 3 == 0)
        _id_12C3F("_encstr_B87146D909F930135F6A98E0227FD9190CA16171EB9BE0EDCF82F66B6A6F8DA0230EFFCF69C3F820A70BCE71430F4868F19E177D37ED807D5372A3189BFFF14012E383CFBE59D09E", 1);

      if(istrue(var_12) && (istrue(var_25) || istrue(var_26)))
        _id_12C3F("_encstr_8758543A72D76C86EBECB1BD261663EBD856D1D0B0C6BEB59636D87DBBD21DA1EBC55DB0393A5693D6856E47B2C9BEBD39AF39956ED1DEC66DF51C56E4B5FA99DE4ED77B072B93C2A37B277DDAB4B9E65AB7B9AFB9CC", 1);

      if(var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        _id_12C3F("_encstr_8BC242141399BECBC099BA72C1271379D80BAD863F4847FBE830E24A2810676AE9F9350379208B7725689A7256D4AFA29147B89DCD50937FCEC6B20ABBB6EF5DB0BF33B3", 1);

      if(var_11 == "_encstr_965306392D3336B2" && isDefined(self._id_12A86) && isDefined(self._id_12A86[var_2.basename]) && self._id_12A86[var_2.basename] >= 2)
        _id_12C3F("_encstr_AB0E371D9CBE1B867DEC36ED4C0B8DBEB09B6E85EA36E8BEB5AE8D8E5AD64BB163EB99DB277DDB1C954EC28EBDC9D7DA5AE69B2DED9BAFB933", 1);

      if(istrue(var_19) || var_1 == "_encstr_8C450D955CD52D07D7DC2BB6A39587")
        _id_12C3F("_encstr_9727319493193E4B40193AF241A793F9A083351CB348491F735032F9E98893A1E851B582D3908DB330687A2353D32F2511FF7B", 1);

      if(var_5 & 4194304)
        _id_12C3F("_encstr_99DD447473F9DEABA0F9DAD26187F3995BBB14E42710A477D151E14A0BEBEF0D9009894FDB58EBE70F894BA29335CF4770DD37F729D0B2E7AD2023C9D81B27FA287F8E7F873A", 1);

      if(istrue(var_12))
        _id_12C3F("_encstr_A96F317BB8A7E0CBF197C9C7AB3A01B93C07E370D6CC49724A43D19FA3A25671C7DA494B7E3C10B6416FD3CF9FEA10A05FF23B", 1);

      if(var_4 & 4)
        _id_12C3F("_encstr_91FA393AE47D1B34F53BB17B4C0B1BAF662D37966E344BDCECBEDADBEC2BBE6D5A36B17DCCED27AF7B1C95E485E8DB9CFAB5D26E6E5AED73FA6ECC", 1);

      if(istrue(var_14))
        _id_12C3F("_encstr_86143BDBE2714FD9B16711C7DEEAD0E7FC8AE4DCA184C823A377E77F8F9B27E664ADE1AE23A0D86773A7C0203BE253C9103809D0DBFFDE836FDDD726EE", 1);

      if(var_5 & 8388608)
        _id_12C3F("_encstr_B87032D909F930135F6A98E0227FD9190CA16171C71E10EBF372B189194BB708A90FA1EB72861820BBB988D0E367CB28BDA72FFF", 1);

      if(var_5 & 512)
        _id_12C3F("_encstr_9A6638C3B98E5FD0C6EA69EFB91F7031FF47B7F80579C783B75597502D489487C09D79B03F9B07BA6B2718793BBD5ACF48D26FEFF11880FF67C2", 1);

      if(istrue(var_20))
        _id_12C3F("_encstr_9175376DC2D8B890C7FC2CCF139B08195345863077E8E59B352803BD689F4B9152D062B28B10C03083836050DA4E672718C8BF032FCD79ABEE", 1);

      if(var_5 & 4096) {
        _id_12C3F("_encstr_B46B3B0B7A16AF039E34B15ADA837B81B21850EDAFBB99BFA95787A3754783058943E06BA940B10F9BAE380BC03B6853E776B71FC7FF5854A22D4108AB", 1);

        if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
          var_62 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.vehicle, 1);

          if(isDefined(var_62) && var_62 != self)
            var_62 _id_12C3F("_encstr_82D1425067213FF07F6F39A042AFB8FF524AF0E0DA057F6913AFB2AB54E38667BC528028D15F8DA06BB1C8940FE3483529DAD8A09BB6C9B8439F419B1B6FF0C7CD61488A", 1);
        }
      }

      if(var_5 & 268435456)
        _id_12C3F("_encstr_85AC40F8DA81979489875B4F82BFD1976B8ABBEB5F4F43D479883BAD118391400F7594F1DDAE3579580DB7C24852B15091C98B1BC04242882D8CE356A2DF4099E3CF", 1);
    }

    if(istrue(var_35) || istrue(var_36))
      _id_12C3F("_encstr_86523ED356992BF911F268123A0BF8FF402C50AA8840A338C24048901667BA8B42598DCE9CC41DF5C9DE28C6210F92374B8B39476A39A07313B2DA6A382FBF93", 1);

    if(isDefined(var_2) && isDefined(var_2.attachments)) {
      var_42 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
        var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

      foreach(var_44 in var_2.attachments) {
        var_45 = "_encstr_B40101";

        if(isDefined(var_42))
          var_45 = [[var_42]](var_44);

        if(var_11 == "_encstr_BE1904DCDA9D" && var_45 == "_encstr_85E508032BD7D638C537")
          _id_12C3F("_encstr_9164370C40FF5EBA67477367867069408A5FB18FA59004A979C38D618B61D89E1B4FA92F3651E7D312FA78BBA05B7F7DDB471BC2A8AE596FAA", 1);

        if(var_11 == "_encstr_8D940738966ED1DB8D" && issubstr(var_45, "_encstr_AA1C072756CC63ACF0"))
          _id_12C3F("_encstr_8AA93B47C9F56C34BECE8DDE13851B7DE05ACD47B763FACA6D2DC2AF365946FADBC1D1968DBE99F6C9EBF60E5927C21DED9C7DAD4B6ECD2DF6DCF5CD33", 1);

        if(isstartstr(var_45, "_encstr_AD7205BC929AE9"))
          _id_12C3F("_encstr_85F82F614EB12ED94FC9E008663328178F52D1B0AEE7DBF0DCD8BB68EB4960E3B113DE4B05A0476D48F06BC7C7F0D1128B", 1);
      }
    }

    if(istrue(var_34))
      _id_12C3F("_encstr_A7C2405172A81133F7CA68385027552E40C2DC16F1AF08734381EF79B13FC9FADEB7C7E59BB008470D18B71A209D315FA10518D9E07D9A89278A17BBB30FC0C92016", 1);

    if(var_1 == "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB" || var_1 == "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB" || var_1 == "_encstr_B1611797B322C630E19D66D9C6C4D00BFB0B3B3FA7FA9B703D")
      _id_12C3F("_encstr_81DC39D127AF36A1F576D8EDC42C63BE370ECA6CD2C21B7D77ACC283BDDCF5595BD2B07D33ED4EF5BD8395390BA37B93D7D6D26EDC5A7BDCFAB966", 1);

    if(var_11 == "_encstr_965306392D3336B2") {
      _id_12C3F("_encstr_ACF232A95BB71F98515FCBA016DF10B1C06A4BC66919D69B9F63A09B30E1DF3A09C859D59AB15BEF1ABE6BF23BD6E7C73E49D02F", 1);

      if(isDefined(var_2) && isDefined(var_2.attachments)) {
        var_42 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
          var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

        foreach(var_44 in var_2.attachments) {
          var_45 = "_encstr_B40101";

          if(isDefined(var_42))
            var_45 = [[var_42]](var_44);

          if(isstartstr(var_45, "_encstr_AC540503E843A7") || isstartstr(var_45, "_encstr_8B180587206137") || isstartstr(var_45, "_encstr_8B6605A57A35AD"))
            _id_12C3F("_encstr_938B3ADBE239A33A187F1B1F5D3F4227601399E42D7864016D39630F5D551A54E9588E6F7E403F0BA83F7B078D8F5387286605749350F19218470F46", 1);
        }
      }
    }

    if(var_11 == "_encstr_850707F7E5833355B8")
      _id_12C3F("_encstr_91E4313A27BE8D86EBEC63DBC42C36D7CAB6B40BD76ECD968359E4FACCED4EBEDE07AC270BD1ED39D7D62DCD6EB47B9BAFCD33", 1);

    var_57 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1")) {
      var_57 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1");

      if(isDefined(var_57) && [[var_57]](var_2.basename) == "_encstr_9B65109F23E0F24FC016431A79258FEE4889") {
        var_58 = self stopplayermusicstate();

        if(var_58 <= 35 && !issubstr(var_3, "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F"))
          _id_12C3F("_encstr_8FEE367C4A87FF8067E773878EB79A5948A879AD3417B067BA3367536F1A189D37627BC34E5FA00958870D302B4829DC9FBA6FA8CD1116D2", 1);
      }
    }

    if(istrue(var_31))
      _id_12C3F("_encstr_AAA83248925179685F275BC7BD90548F6D5744AF8E3B5D10E750CD66DFAB923A2157EB8B92B733AFA3D1D8EBF32A03A288E16F7E", 1);

    if(var_11 == "_encstr_BE0703A54C") {
      _id_12C3F("_encstr_87642E3A27F51BD0AF3B63BD8958B1BE59B5A52CF58DB69DBE99DE39EBF60EAC9CB08EDEE4EBB6A5CD9BD27B37EB6ECC", 1);

      if(isDefined(var_2) && isDefined(var_2.attachments)) {
        var_42 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
          var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

        foreach(var_44 in var_2.attachments) {
          var_45 = "_encstr_B40101";

          if(isDefined(var_42))
            var_45 = [[var_42]](var_44);

          var_68 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 5, var_45, 3);

          if(issubstr(var_68, "_encstr_8B6605B5722504")) {
            _id_12C3F("_encstr_AC123CCCCB4166636821122AA95F4BD188FB571F9B382C0F3039EBB350B88716504BD2A13520F9CBC0D3311A1B8DA3CE602F520F5BF83AD7FB685A0143FE", 1);
            break;
          }
        }
      }
    }

    if(var_11 == "_encstr_A1100738A33A638123") {
      if(isDefined(var_2) && isDefined(var_2.attachments) && isDefined(level._id_132BD)) {
        foreach(var_44 in var_2.attachments) {
          if(isDefined(level._id_132BD[var_44])) {
            _id_12C3F("_encstr_8F383D7BE89FA76CB917C985EAA85D172FAA87133B73B68747BAC2F0D7608F835F815F43EA3EC02633275877E8B7D84A875307989F4A53E63620504DE93B5B", 1);
            break;
          }
        }
      }
    }

    if(var_11 == "_encstr_8D940738966ED1DB8D") {
      if(var_5 & 2048)
        _id_12C3F("_encstr_9A02382017514F80EFFFA910D23F486FC27A60A8EA35FFF9C7E927AFAC5F13C56F1289A0424A47F0830DB60794B77BDFD52A7080DAA56D0ED763", 1);

      if(var_2 hasattachment("_encstr_AD9C07E0478148252A", 1))
        _id_12C3F("_encstr_A1AB34AD93E7F250B03985D78E4FB29679B84F3BB70518E997AEB132ACE7BFF8F8B64197C3B24EE8CC58426FCD14135244505027CEBE", 1);

      if(isDefined(var_2) && isDefined(var_2.attachments) && isDefined(level._id_1237C)) {
        foreach(var_44 in var_2.attachments) {
          if(isDefined(level._id_1237C[var_44])) {
            _id_12C3F("_encstr_8AA93B47C9F56C34BECE8DDE13851B7DE05ACD47B763FACA6D2DC2AF365946FADBC1D1968DBE99F6C9EBF60E5927C21DED9C7DAD4B6ECD2DF6DCF5CD33", 1);
            break;
          }
        }
      }
    }

    if(istrue(var_29))
      _id_12C3F("_encstr_AB2D388B4857103BE187F9F7BB2A71A905B450A149D3B8E1AA7FDDE9F7924DB0DC0139F8AA077BA79223D3D1DFAB188879E203B0156EA8C8AB1E", 1);

    if(var_4 & 16777216)
      _id_12C3F("_encstr_BEA53290D66F41F9D1C721B89EEA290EAA5F088023EFD9DFFA6C293139B267D3DFDFC008CB8133475399914B0A9B53B846875002", 1);
  }

  if(var_8 >= 10) {
    if(getdvarint("_encstr_84911D53788589CF98FF2A2C85C6AB8AB760FA9BE061BD37F3D50F50A5C83B", 0) == 1) {
      if(var_7 && update_objective_ownerclient(self.origin))
        _id_12C3F("_encstr_A96556E89CFA36347DB3C6B789B0637DB28DB4DA4BCDC2E8ACEBCA732BDA5ED7CD95169CAF0BD81DB4D9ACEBCD8547635A37D6F5DE39D76C930BCDA1ACC87D9B16D1CA631B9647CAFA99F69CF59B0DF5959DB2B9E8AFDDA7", 1);
    }

    if(var_7) {
      if(turn_on_have_target_hud("_encstr_A1BA125A770EBE9BD6D7474EDC833916F2AF6B0E") && var_11 == "_encstr_BE1904DCDA9D") {
        var_74 = 1500;
        var_75 = self _meth_87C5();
        var_76 = var_75 < var_74;

        if(!isDefined(self._id_1283C) && var_76) {
          if(!isDefined(self._id_1341A))
            self._id_1341A = 1;
          else
            self._id_1341A++;

          if(self._id_1341A == 3) {
            _id_12C3F("_encstr_8D213C5332B89704D9E75C5785404D1FD6D0FA69C00B63FD60AF4926B15812D77EEB23B2885D2F35E847462795611B67AF438A4A36B5FB6DD027730F6F62", 1);
            self._id_1283C = 1;
            self._id_1341A = undefined;
          }
        }
      }

      if(!isDefined(self._id_139CA) && turn_on_have_target_hud("_encstr_922515C324286F13068763636103AFC0A2EB6BC839DD41") && var_11 == "_encstr_850707F7E5833355B8" && var_4 & 1048576) {
        if(!isDefined(self._id_1343E))
          self._id_1343E = 1;
        else
          self._id_1343E++;

        if(self._id_1343E == 2) {
          _id_12C3F("_encstr_81BA335D511701A1A10AE0F0B2C6715E0FBE6BD765DBCEE9177258082A1D0993675EE04EC76771C33ABA73619375C1A8FFCB604604", 1);
          self._id_139CA = 1;
          self._id_1343E = undefined;
        }
      }

      if(turn_on_have_target_hud("_encstr_920B1179B40A775DCB01B37F881B16575E11E8") && !isDefined(self._id_11A6B) && var_5 & 1073741824 && var_4 & 256) {
        _id_12C3F("_encstr_B6CD42479CEB36437DCE1BDE3158B1F5B62BB1ACB2FABB592C077BDC7DADD26336FAEE1AD23659F5CDC6A5465A37B3FA33BD9CFADD2BC207B79BF557CDC6F6C6B5EBDC86", 1);
        self._id_11A6B = 1;
      }

      if(turn_on_have_target_hud("_encstr_885610D0A049D1CF158901611B2358DFB121") && !isDefined(self._id_12159) && var_11 == "_encstr_BE1904DCDA9D") {
        if(isDefined(self._id_12A86) && isDefined(self._id_12A86[var_2.basename]) && self._id_12A86[var_2.basename] == 2) {
          _id_12C3F("_encstr_A73B308E4EFAB10DFA9D8D7B260BD8AFE6B69DD7DAABB13A2DAD5A3636BE99DB27F5BBAC2C0EF6377DEADCD8BDC6B6AFB90D", 1);
          self._id_12159 = 1;
        }
      }
    }

    if(turn_on_have_target_hud("_encstr_A30914AF1FA248DA40A925CB767AA382FFC7EB889ABF") && !isDefined(self._id_11E22) && useserverhud(var_1)) {
      if(!isDefined(self._id_136D4))
        self._id_136D4 = 1;
      else
        self._id_136D4++;

      if(self._id_136D4 == 5) {
        _id_12C3F("_encstr_A6A32F8E9CFA1BD0FA3B8DF6C4B0B17DCDE02B6CB4161BAFB2B62D58EB66DB27EBEE56581CF6E6BEBACDD8BDB1ADEB6E0D", 1);
        self._id_136D4 = undefined;
        self._id_11E22 = 1;
      }
    }

    if(var_7) {
      var_77 = var_4 & 524288;
      var_78 = var_11 == "_encstr_A1100738A33A638123";

      if(var_77 && var_78)
        _id_12C3F("_encstr_8F433E73A8D7618148DFD10DB657E3CE6FAAA2118705FD06706851C8A1613B5977A257EF826410B9177445BA51878BF796FE911833472B9367E3E74F9DFF47CB", 1);

      if(isDefined(self.watch_for_player_enter_trigger)) {
        var_79 = gettime() - self.watch_for_player_enter_trigger < 10000;

        if(istrue(var_79))
          _id_12C3F("_encstr_8EBE3A474EEB36A1F53B36B798B0C67DB6968DC6EBB099D195C9FAE6D1966BEB6E86DE3AD733EDC97DDBC15639858EB7E47DD62D376ED2F6DCBE6E0D", 1);
      }

      if(var_4 & 8)
        _id_12C3F("_encstr_87C035E8937D1BD0FAD9B17BC4B0B17DDA968D63E6D7EED0D26395D758C8CDEBCCF64EEB7BE02B4EC2D1B793BE5BB4CDCDB4DBDCEB9BD0", 1);

      if(var_4 & 1048576) {
        if(!isDefined(self.getanglesfacingorigin))
          self.getanglesfacingorigin = 0;

        self.getanglesfacingorigin++;

        if(self.getanglesfacingorigin == 3)
          _id_12C3F("_encstr_B47F3BC3FA21BB526007730775175ACFC0D93E4F2B704F4B4E5F6F0B27C8822DD1E1B69501710EB226476F6B4B6E3A74A8EBA11D3878C3EAF0CDA76F01", 1);
      }

      var_80 = var_11 == "_encstr_850707F7E5833355B8" || va_cluster_spawnpoint_valid(var_2);
      var_81 = var_4 & 1048576 && var_4 & 262144;

      if(var_80 && var_81)
        _id_12C3F("_encstr_8D714BC081B05E0CC18A348F73C703A75BD604F0CFABB85F9A5998491159B2E6C869F03B788ED1833BAAD3D9B3C72FE39F13D5940B70AE723B41480AA505718B6F5A1832C0E25657E8F349AB7B", 1);

      if(var_5 & 1048576)
        _id_12C3F("_encstr_82253D6510A99F580FD72040BB4990AF322DD0669B8347A017DBB108D365280BEAD7C0FA74CA312EC6C7C0D1BFA80165423B40FE41B2E393BB37205097C3F3", 1);

      if(istrue(var_12)) {
        if(!isDefined(self.getarenaomnvarbitpackinginfo))
          self.getarenaomnvarbitpackinginfo = 0;

        self.getarenaomnvarbitpackinginfo++;

        if(self.getarenaomnvarbitpackinginfo == 3)
          _id_12C3F("_encstr_B1FF3E9B58471B2BD1B7E9E7CB5A61991C270390F6AC29526AA3F1A727E2B851A77DA9CE9F09E01D2163FFAD0F6AFFD85216F340424F28C39B2FCB8F3331469A", 1);
      }

      if(istrue(var_19) || var_1 == "_encstr_8C450D955CD52D07D7DC2BB6A39587")
        _id_12C3F("_encstr_8A27313A4ED76C0DAF9D8DF68958C6FA3759B58E561EFADAA51BC67DCCDB39D7ED07954E2CE8DB9CEBD6A5376EA57B37F5DC68", 1);

      if(istrue(var_12)) {
        _id_12C3F("_encstr_8B6F31986B0F77A97F7A40FAEDF1D967883BFB3AEBB8175F88E8782E20A71BB14F872DB5438B88BB9FF2ACB34334E8801E1BAA", 1);

        if(var_25) {
          if(!isDefined(self.weapon_xp_iw8_sh_dpapa12))
            self.weapon_xp_iw8_sh_dpapa12 = 1;
          else
            self.weapon_xp_iw8_sh_dpapa12++;

          if(self.weapon_xp_iw8_sh_dpapa12 == 2)
            _id_12C3F("_encstr_83CD631D93AF8D86AF9DC6BD982C8DAF3A77F6BE63ACE8D05836BE5B5AC636CDBE9B0B6BCABEB14B3359EBBB96D10D7D5C5D2CC93A2BC9AD85E63AB29CD77B27EB9395CDE87BD8ADFAE0B29CB5EB99F627FAB70756E4588EDE4EEBB55A37E696DEDCF5E60D", 1);
        }
      }

      if(var_4 & 8)
        _id_12C3F("_encstr_87C035E8937D1BD0FAD9B17BC4B0B17DDA968D63E6D7EED0D26395D758C8CDEBCCF64EEB7BE02B4EC2D1B793BE5BB4CDCDB4DBDCEB9BD0", 1);

      if(!isDefined(self.getanimsforplanefacing))
        self.getanimsforplanefacing = var_1;
      else if(self.getanimsforplanefacing != var_1)
        _id_12C3F("_encstr_A9B15047727DB143EBB363F698C2B1D7B6B4C66337D7CC27BDDAF5C896CC33B29CB2371D7DDD2B85C1DB37B9F5BB5A4786DBBAE8F5C8E5D29B3BEBCCDB4EAFDB38AC390B47BD397D5B4BB9E696F6B97DE643", 1);

      var_80 = var_11 == "_encstr_850707F7E5833355B8" || va_cluster_spawnpoint_valid(var_2);
      var_81 = var_4 & 1048576 && var_4 & 262144;

      if(var_80 && var_81)
        _id_12C3F("_encstr_8D714BC081B05E0CC18A348F73C703A75BD604F0CFABB85F9A5998491159B2E6C869F03B788ED1833BAAD3D9B3C72FE39F13D5940B70AE723B41480AA505718B6F5A1832C0E25657E8F349AB7B", 1);

      if(var_14 && getkillstreaknamefromweapon(var_2) == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895")
        _id_12C3F("_encstr_B1FA421BBB68F2A84159B57DD198E489DAB3E3F38FA49A8CA0266A4668F835032D1D4F3F4FD8634498C864CF867077CB104FA3A7E57FDB07A0169DD43B8089525097277A", 1);

      if(var_4 & 256)
        _id_12C3F("_encstr_AA64328E937D1B437DD9D8BD9858D8FA9B8D4B324BDC9DAFB55AD81BEBCCDE39AFED832B39B047F69CEB5B5ACDE6D2B79B7DB943", 1);

      if(var_5 & 1073741824 || var_1 == "_encstr_A3BF1B2DF308C9816A3FA123D3725918E14A2B981EB3984B72BFFF83B3")
        _id_12C3F("_encstr_AF1D4AF353B02A70E9E11D25B9E08C2171731B0F43D81335302BD56D36B8DA795E9383A32376EBE178D6CC75E8A815B1A23B0B3BE71402B271B802BFE3784C0A863FF7A727C6AA97C086FAD3", 1);

      if(!isDefined(self._id_145A3))
        self._id_145A3 = [];

      self._id_145A3[var_1] = 1;

      if(self._id_145A3.size == 6 && !isDefined(self.lightsreset)) {
        self.lightsreset = 1;
        _id_12C3F("_encstr_AF174180B7F1EF204F5F09F032DFE8CFA41AF8C84913337BAB7F05FB0E1B315D8F12B0C9232F5BB35F6696F8E6179BBFF55BA028FA038FCBC79D93E6EB77E09551F3A2", 1);
      }

      if(isDefined(self.player_equip_primary) && self.recentkillcount >= 2 && weaponclass(self.player_equip_primary) == "_encstr_BE1904DCDA9D" && var_2 == self.player_equip_primary)
        _id_12C3F("_encstr_81513364EB777EFB47FFE867F60FC361A3810999AF086A835B10C3AB50684FDF535930C837232FB31F356913F14AC3C4F5AA0FAF0C", 1);

      if(istrue(var_12) && isDefined(self.recentkillcount) && self.recentkillcount >= 2)
        _id_12C3F("_encstr_B1C74FD5C98F9929297268683A7EE9D6FB3D5D43E92B46178C2A6080C1D78D68179F664F4DD78E61B4F38098AAA173CD87476035E777318BDF49C0504349071BC7E27F353F5B3EC3049370788A5DAF337A", 1);

      if(var_5 & 262144)
        _id_12C3F("_encstr_9ABA41AB6877301BC1A79997DB4A5189EBD4102069A7A8CD8A5FD99BD3D2A528B9EBB9B9811A3089229FD9E71B5AEEF95F4221F3B65428BE4947FB875742B838D71A83", 1);

      if(var_4 & 524288)
        _id_12C3F("_encstr_BABF36E8E4D71B0DF53B1BBD310BD8BEE07B2DCD1D7D31B1C2735BF56DB46336BE33BD39EBED0E5639B01DED4EEBDAA56E37A5DBDCAFDCD0", 1);

      if(var_4 & 8 && isDefined(var_2) && isDefined(var_2.attachments)) {
        var_42 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
          var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

        foreach(var_44 in var_2.attachments) {
          var_45 = "_encstr_B40101";

          if(isDefined(var_42))
            var_45 = [[var_42]](var_44);

          if(issubstr(var_45, "_encstr_AA1C072756CC63ACF0")) {
            _id_12C3F("_encstr_A34A3D130FE726D059EF59A7123E38E0C7724BFEB257E9A861D75B9930E940B57B3940832BEF96F947D775D72F0AC0861723D84B2117DBA0DAB947BD773212", 1);
            break;
          }
        }
      }

      if(var_14) {
        if(var_15 == "_encstr_A2E60C6BC099B7E1A0A93A398F48")
          _id_12C3F("_encstr_8EE14A3A72EB6C0D7DEC367B13161BAFCD2C0E1663B5D7B93A4ED2B5CABEB7C97D8D63BACD3A5639F5378E3996B5ACF5B6D2D8C6FA33F693BEBD075993C247DBE4AFD65A6E6EB4DECDAFCDD0", 1);

        if(var_15 == "_encstr_A2E60C6BC099B7E1A0A93A398F48" || var_15 == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" || var_15 == "_encstr_B270105ECB28E94BC5CFABAB937D524C5053" || var_15 == "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A" || var_15 == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA" || var_15 == "_encstr_86FD08B775CD07DC1338")
          _id_12C3F("_encstr_AFE53DA393F5C686BE3B637B89B0D87D58B2275A16C6FAE6C6BD39CAE6D14EB2C2B57DD64B8DC6F533DB4EEBDB8359C92CA3F627AFADA5CDCD5AED73EB371A", 1);
      }

      if(var_4 & 1048576 && va_cluster_spawnpoint_valid(var_2))
        _id_12C3F("_encstr_9A2838E8C9F5360DD7ECC6DB31C2D87DE8C236A32D1B2CD8D78659B091B9867B1DCDAF33F6C9F5F638B227C28E7B27F56B5AB99BA5BD377D9B43", 1);

      if(var_5 & 16777216)
        _id_12C3F("_encstr_A6662EC8FFB9B77807E7B138FA2720071FC27809B24CF1B02F0EC8AEEF77EBCB822AF87BBB693B28E723C328A68F7321", 1);

      if(var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        _id_12C3F("_encstr_83C2428EC9FA1B0DEB3B36DE262C637DD82C5D37B10D95C9BEAD4BB18DFA7BC9AF8C2BCD8E93AE363A5AEDB9AFCCBD93AFED075927C2A3ED93D7AD966EDC96ED737DCD86", 1);

      if(var_4 & 524288 && var_11 == "_encstr_8D940738966ED1DB8D" && isDefined(self.lastkilledplayer)) {
        var_84 = vectorNormalize(self.origin - self.lastkilledplayer.origin);
        var_85 = anglesToForward(self.lastkilledplayer getplayerangles(1));
        var_86 = vectordot(var_84, var_85);

        if(var_86 < 0)
          _id_12C3F("_encstr_BD5949038AFFE69BDE9C444F2621B3210990FBFBD04151B3B0F35E6C50A97BF64D28A1825829D5D74966577D48F1077CEB789A5948978A9F404F257A7F1BE7825FC8F213787385A33E367C", 1);
      }

      if(self.killcountthislife == 5)
        _id_12C3F("_encstr_A5E632A9A6B1F6080F8FD088F619E0202A0F611117ABC63849E4BECB51C6C0EE01AFD19BBB828DA072F1E05842BBB8A8AA074FB1", 1);
    }

    if(isDefined(var_2) && var_2.inventorytype == "_encstr_BA7F0830B3A7859B60B0" && !(var_4 & 131072))
      _id_12C3F("_encstr_969E354793FAC643EB768DED311663F5C1395AB62C272FFA77CA16E0F6E6EBCAAD4B2CAFB738AC2758E8ED937DAD2DE6E6A5B737EB9B86", 1);

    if(istrue(var_34))
      _id_12C3F("_encstr_9BC240FC1B6E0F64C748AA9248935D4781AA796140336FAB7171129A48FFD95BF906F31D6DDED3B72DF8893250E5011773FD5291856093F12BF0B37B5807051F4BFD", 1);

    if(isDefined(var_2) && weaponissemiauto(var_2))
      _id_12C3F("_encstr_AB0E341D9CBE1B867DEC36ED4C0B8DBEB92BADA5BEB0EAE8BDEBAC6D5AC2FA997B4E7DDB07959C58D1EDE4EBB5A5DCE65ADE73EB6E0D", 1);

    var_87 = "_encstr_8B060D0EA56EE87B8D9D934B070399";
    var_88 = isDefined(var_3) && issubstr(var_3, var_87);

    if(var_88)
      _id_12C3F("_encstr_A2DB458E727DB1A17D761BDB312CB1BE2BD6B4B0D7DD5A8E43D7DC0795AC23FA3AB083ACAF0BE83A851BD0B559B947EB99DE9C7DBDC1CAC9C21D7B27FA5BA59B9BD2F6E67DB91A", 1);

    if(var_11 == "_encstr_BE0703A54C")
      _id_12C3F("_encstr_9A8C2ED1E4BE361AAFECB17B31C236D763DA76BEACB65A2CD766EDE4EBDB83599C168EED9CF55BB4B9E6B4F6B9AFCDD0", 1);

    if(isDefined(var_2) && isDefined(var_2.attachments)) {
      var_42 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
        var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

      foreach(var_44 in var_2.attachments) {
        var_45 = "_encstr_B40101";

        if(isDefined(var_42))
          var_45 = [[var_42]](var_44);

        if(isstartstr(var_45, "_encstr_91EC068D0B372B93")) {
          _id_12C3F("_encstr_A53745D37350CA900901FD0599C0AC41154F2FFFD7ECD24458EEF58ED388FA997EEF83176F1FCB1C4871EC95090824D1C4175317E73F82D260BB255A663871EB26B39F5B1FE65F", 1);
          break;
        }
      }
    }

    if(var_4 & 131072)
      _id_12C3F("_encstr_96B6348EC9EBC6D0FAD936B798C263BE56DAD2B07D9BB26CDB73190B4E2FAF66ED9CBEB7C1AC93853A7B39FAB5D2DC374B7B73EB6E1A", 1);

    if(var_11 == "_encstr_A1100738A33A638123")
      _id_12C3F("_encstr_872F32EBF71FEE188137919F5A7640B8C77AED53BA6F9069270383FB7F9F90F6CF627BF91397D5B03ADF83E37B02F830E3D9934B", 1);

    if(var_11 == "_encstr_BE1904DCDA9D" && var_5 & 131072)
      _id_12C3F("_encstr_88CE4419DBF72B80F7EF21D00A4A858E97195771E20BABD7A717F33B4487D6A03815A2DAF5B2B6B31D97E1BF8ED3A86A78767FD84B8F531169979B567503A7D71BE8CD5F9BBF", 1);

    if(turret_struct(var_2))
      _id_12C3F("_encstr_837032230E39B8298007B992269B2C21BE435AD6338CFB8EDFF82C539FEED7EA3FF87FFD63C9993703E7AD0A90EFFB6FAD9093FF", 1);

    if(isDefined(var_2) && weaponinventorytype(var_2) == "_encstr_BA7F0830B3A7859B60B0" && var_1 != "_encstr_81C80E0C79E00F3BF583FB8FF5B0C278" && var_1 != "_encstr_ADFC11E951B753CA61A8373B38C3A0ABCB6295" && (weaponburstcount(var_1) > 0 || var_1 == "_encstr_ADFC16685782488E088739432083E1A5C26296DB12F66013"))
      _id_12C3F("_encstr_A26D355BE270C10897A15BCF42337AA11A236B63708F343BC3BD1F2D8780C271C5AD16A14F136DF3D66517AB4789E4529FA2E7B0D99BEF", 1);
  }

  if(var_8 >= 11) {
    if(var_7) {
      if(turn_on_have_target_hud("_encstr_9AC915BBE303C71B60298B625E2683D58C40CE1F71EBEB") && !isDefined(self._id_11BD7) && var_11 == "_encstr_BE0703A54C") {
        if(!isDefined(self.zombieloadout)) {
          self.zombieloadout = 1;
          thread watchreloading("_encstr_848A1A25E7AAE20FC670924A182D136FE86F9082DF28BAAFF60B2AD2");
        } else
          self.zombieloadout++;

        if(self.zombieloadout == 3) {
          _id_12C3F("_encstr_A6413FB3701F5873B9CF81BFE3624971F4FD592E0C819839D1DBEF8727DB83A88513C60337FCC867BA8795BFE7A2588817AB09F91A57183083B399A73F5A88F895", 1);
          self notify("_encstr_848A1A25E7AAE20FC670924A182D136FE86F9082DF28BAAFF60B2AD2");
          self._id_11BD7 = 1;
        }
      }

      if(turn_on_have_target_hud("_encstr_926F15335B073F510A0FC8AA973CA8D74A44364D390A29") && !isDefined(self.force_group_thermites) && turret_struct(var_2) && var_4 & 262144) {
        _id_12C3F("_encstr_950C33B1FB896708C7B7D1BD29978BDF63500160C2C0D077D48039A9A8E88069E1FAEAC6878B3D1AB3EAB8979BA04ACAC9F2083AA2", 1);
        self.force_group_thermites = 1;
      }

      if(turn_on_have_target_hud("_encstr_97F517F8C3B807B36797F54B904F9BE9D5DAB078BA43CF285B") && !isDefined(self._id_11B1A) && var_11 == "_encstr_8D940738966ED1DB8D" && var_4 & 1048576) {
        _id_12C3F("_encstr_8A32377D71372181812A63105226517E63D906F58F43EEC9775278E80A7D29365771016127035005D15B7870A31525CE87EE996873EF9E4F93", 1);
        self._id_11B1A = 1;
      }

      if(turn_on_have_target_hud("_encstr_935D114BDD83D7AD59FA3A276C58B9CA7DB638") && !isDefined(self.get_actual_grenade_name) && var_5 & 1073741824) {
        var_91 = var_5 & 1048576;
        var_92 = var_5 & 8388608;

        if(var_91 || var_92) {
          _id_12C3F("_encstr_B48044C3FA21BB526007730775175ACFE8D97D0FE9C9575A4701770B27CAF22448E676D580F80C122D471F7B6B60CA65F04EEF9D5B19C72AF7F1671BD79512D47B5124691392", 1);
          self.get_actual_grenade_name = 1;
        }
      }

      if(turn_on_have_target_hud("_encstr_A2EB10F86F884673F249AD135A6AA38E358B") && !isDefined(self._id_12E7A) && var_5 & 1073741824 && var_5 & 268435456) {
        _id_12C3F("_encstr_BAF243D127D7D81AAFCE8DF6262C8DEBAD5636B2ACD7EE95B007EDE6BEAD2DC6367D9BDEEBC9CAA3AE4EE6F599969C95D733B793AFBB5658387B73BEAB9B63F636B5FAB9D4", 1);
        self._id_12E7A = 1;
      }
    }

    if(var_7) {
      if(var_5 & 536870912)
        _id_12C3F("_encstr_BE3237A8EE5769D1092FD95046C21156DE07A8C0A30980F7321545701C3A49F82B47288013E778911ABA4FED75A3E780691F3838FF7E364F27", 1);

      if(istrue(var_17))
        _id_12C3F("_encstr_AD0A321B626960E097713890BA9AF9F7C8D81C8003E55BCE6C1870C2495470E3FF7F6201CBAA8B6F0B514D23EE9E5397C35087AD", 1);

      if(var_11 == "_encstr_8D940738966ED1DB8D") {
        if(!isDefined(self._id_1237B))
          self._id_1237B = 1;
        else
          self._id_1237B++;

        if(self._id_1237B > 0 && self._id_1237B % 3 == 0)
          _id_12C3F("_encstr_A3D039EBF2D623C2F7FC4D8556B3BAD79BE87F13A868A7BAF30155BA457DE2B180F1FE375860C22127271FF227291A6AAE18071F9818077A6FBE73", 1);
      }

      if(var_5 & 1073741824)
        _id_12C3F("_encstr_B150373B9B48D2882139D51DF1B8C469394BC3F79B905B7D08E30D254ED0199201A763675D3882202B4B86AB60F067DA6B574FF7FFD849FBFA", 1);

      if(istrue(var_12))
        _id_12C3F("_encstr_866F316050610E19AFC7E0803A4F39B8318DC311373C79A0714B417701489611BFC2CF2B2F738A65778B4F6AFBCF67AE311357", 1);

      if(var_4 & 1048576 && va_cluster_spawnpoint_valid(var_2))
        _id_12C3F("_encstr_8C28381B7AF0EF7C91BF14EF4D9885D78DE9E2A3D8B69F35B98915E96920CC4F3543B90A6096AF2D988B1AF151989247D1B8F3C308E033696843", 1);

      if(var_11 == "_encstr_92590EFBF91ED25750D8D7DC30B88E8A" || istrue(var_21))
        _id_12C3F("_encstr_99F2448E277D1B867DEC63BDC485C6FA340BD1D834CA47EBDB39EB3AA14EEDBBD2DC3BFADA9B5A99597DB54B368DAF33DE4EBEF607569C581DB7E4AFB64BB9CD2DDE37BECD53", 1);

      if(var_2.inventorytype == "_encstr_BA7F0830B3A7859B60B0" && !(var_4 & 131072)) {
        if(!isDefined(self.vip_questthink_iconposition))
          self.vip_questthink_iconposition = 1;
        else
          self.vip_questthink_iconposition++;

        if(!isDefined(self.vip_removequestinstance))
          self.vip_removequestinstance = 1;
        else
          self.vip_removequestinstance++;
      }

      if(var_4 & 131072) {
        if(!isDefined(self.vip_respawnplayer))
          self.vip_respawnplayer = 1;
        else
          self.vip_respawnplayer++;

        if(!isDefined(self.vipbot_movesup))
          self.vipbot_movesup = 1;
        else
          self.vipbot_movesup++;
      }

      if(var_12) {
        if(!isDefined(self.vip_playerremoved))
          self.vip_playerremoved = 1;
        else
          self.vip_playerremoved++;
      }

      if(isDefined(self.vip_questthink_iconposition) && isDefined(self.vip_respawnplayer) && self.vip_questthink_iconposition > 0 && self.vip_respawnplayer > 0) {
        self.vip_questthink_iconposition--;
        self.vip_respawnplayer--;
        _id_12C3F("_encstr_88164A435A7EFB1A1F14B56D8E0B12BF80B0BBABD13322F2A33F3AE078175A4BA810132750CA575B834D841D55F1B114B28043B7A141AFD397E88A973E833BD7BBC9C717685B114ADDE8521A", 1);
        _id_12C3F("_encstr_87164ABDB1F7E14141EAC0D092E6113E4F99C9397FF30B8B35920878393ACB7187364527CA3F16CF1C2BD0C0B31387E977A9D8AC0F1B580DC9A208E8DB6E99402377D1139BE7406F6DC91862", 1);
      }

      if(isDefined(self.vip_removequestinstance) && isDefined(self.vip_respawnplayer) && isDefined(self.vip_playerremoved) && self.vip_removequestinstance > 0 && self.vipbot_movesup > 0 && self.vip_playerremoved > 0) {
        self.vip_removequestinstance--;
        self.vipbot_movesup--;
        self.vip_playerremoved--;
        _id_12C3F("_encstr_993051B1BEA9EE2037B7F8901EF1F808026709398F032E602D0E23AA49CBF85EFA9381AB433B60907D2368A1ADBFB08323331F1BF3A1B57099BDB17E5767D0D04A3BF39D3FBB8810975578F33A597BF0E1AFD7", 1);

        if(var_8 >= 12) {
          _id_12C3F("_encstr_A130514D0359C67A17429BE0312FFD612AA3132AD989A034DD3B6003B76B5573ED8B91E12ADB3F31D1E5215EE361B44B53F3979B03B61BE01A682AA761B78B9E58207F9641BB4520D04913BE674B1F0DD988CA", 1);
          _id_12C3F("_encstr_99E34CD0962F01B9918761F8DE2AE9CE68C3B0805FBA9A1FBB2FEEF0B5523B93B9DFA8E89749F303E2155D90CADA1FDB0DF7A8483F1928AF6AFC5901295255A66377E068A3B5668712E5C5803AFF", 1);
        }
      }

      if(var_4 & 524288)
        _id_12C3F("_encstr_A9BF364322A88714E9D74C47F5305D2F6780EA6A13AF4BCDE0DD736F9F28652B18190233DEE0BBC7502B64578571ED47B653FA6ACD50FF2B", 1);

      if(var_4 & 512 || var_4 & 1024)
        _id_12C3F("_encstr_82474873935FABB8A7916D37822909696CC8A88166A7E8304BD366EF9BD0397D1627EA72284ACBE260B1ED42667BB3F7E81BF8F440BD8E487928FBAA33ADAAB79F09DB1F40308541AA13", 1);

      if(var_4 & 262144)
        _id_12C3F("_encstr_8DC1332B6790E7E8F1921330AA993CE87BF7C61FF048F2BBD6E33BAD725962A2EB599737E7430A9D9F1DE0A042CB2268284001F29F", 1);

      if(var_14 && getkillstreaknamefromweapon(var_2) == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895")
        _id_12C3F("_encstr_A2FA424B2AA09F0CE1EF445FFD485527D25842524E0C6FC3B0B7535B8FF8DF6F8593AA0A50F04FBB58237325D7A06523B8A873F29BB7EBB530677D216720AC8F5846DB7F", 1);

      if(istrue(var_19) || var_1 == "_encstr_8C450D955CD52D07D7DC2BB6A39587")
        _id_12C3F("_encstr_8527313A4E7DD834EBEC63ED890BD8D79BCAD6A32B87BE5BD21BB17DCCBDE4FADE0EAC9C2C1DF6E4F5B64B9BE6D2BDB9EBCD6A", 1);

      if(var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        _id_12C3F("_encstr_9BC242FC1B6E0F64C748AA9248935D47A0AF656E5ED05F2A1FD0E29A2097D53B3E85FD0B6D7BC73621E88AB2D1CD0D6396F8509586A18BFD154152DA883FC4DFE848DB5D", 1);

      if(turret_struct(var_2)) {
        if(isDefined(self._id_12A86) && isDefined(self._id_12A86[var_2.basename]) && self._id_12A86[var_2.basename] == 2)
          _id_12C3F("_encstr_A29B322B82185BCA71C1C27A4A8ADBF73205D1DDF74A03518F0F8A6039934F3B3F2A123D3AA763180A56E8CB680BACF2DD873BE3", 1);
      }

      if(var_15 == "_encstr_A2E60C6BC099B7E1A0A93A398F48" || var_15 == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" || var_15 == "_encstr_B270105ECB28E94BC5CFABAB937D524C5053" || var_15 == "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A" || var_15 == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA" || var_15 == "_encstr_86FD08B775CD07DC1338")
        _id_12C3F("_encstr_96B3507C63A161013989212F33E0659187810A2427E32C0592A8012393209295E8EE2F9D3DE5271466A8DF53DF482BBF7FC829856B8022325BBF69F49073D6908965FE593155ADC95FC03BB3234790715B73", 1);

      if(var_5 & 1073741824 || var_1 == "_encstr_A3BF1B2DF308C9816A3FA123D3725918E14A2B981EB3984B72BFFF83B3")
        _id_12C3F("_encstr_8D1D4A8EE47DD834AF9DD87BC4588DAF6BAC362B95FADD952C07BD9BAFDE4EEB4C58B16396B98E2D1BBEAD9B966695AFAD2D63D87D33BDC9EBDB1CB24E2C47ED27D7AD4BB99B96BDDC7DE6A9", 1);

      if(self.killcountthislife == 3)
        _id_12C3F("_encstr_8AC325AB6877301BC1B79F93E7AA5089EF92D10325B48045F9E25BEFD7A2AA90BBEB38FB0F270A", 1);

      if(var_4 & 1048576)
        _id_12C3F("_encstr_BD0725A17191580B4702C088CAAF30013590152BDE87E8C51F4F73F6F263FA984E0C8BD57D2142", 1);

      if(isDefined(self.recentkillcount) && self.recentkillcount == 2)
        _id_12C3F("_encstr_82072528F3393E50D087DFC31B4FE52840F8AA23C86CD0851F4B7DA1CFFAF5DDBFC0217DDAE1DA", 1);

      if(var_12)
        _id_12C3F("_encstr_A9F1258EE4EB6C0DFAC6DEB5B5EDCDBEDEC131BAE646D859AFC0CCAFBD31A62BB1E8D2ECCABE33", 1);

      if(self.killcountthislife == 5)
        _id_12C3F("_encstr_A6F125C3DF37F643E95BEFF34DCD78504FE3996B5233B950B1605F9F67768005173B70F34A87CD", 1);
    }

    if(var_11 == "_encstr_BE1904DCDA9D")
      _id_12C3F("_encstr_A3643769B9A960430F1AE8B072CF09C9FA75C7478D0C881FE76280BE0BF3B0F014EF5DAF22F970DF57BB59C3D23360C82C3BFF3BD71DA9A63E", 1);

    if(istrue(var_31))
      _id_12C3F("_encstr_B2A832EB5BB7870BFF87C068B0DB2C99F072C197E159B21153D3B71B086CE04B291098E7E313F320B021CD18B793D7C0B8F92B4B", 1);

    if(turret_struct(var_2))
      _id_12C3F("_encstr_9B70321D9CF56C86AF76B17B89B0D8F5B0376E16AE361DF5CAADA5C2D799F6277DED835939853AF6C9BE5BD2E6DCA5DB9BF5B94D", 1);

    if(var_5 & 2048)
      _id_12C3F("_encstr_883E3198AFE98748373761E80AF7F037CF12F8C821FF27E39B5D7DC8E627FB6F350B2BD87A936F9B874DF3D6EB67EDC591430A", 1);

    if(istrue(var_30))
      _id_12C3F("_encstr_B6D8411D4EF536A1EBD9C67B98C2B1FAACB6D285EB0EB0E42C9BDBD216AFDB4ED71AA5CE0DBE588D59933ABE66DBC9D7ED072B27168EF6397D6B4BB9372DF6B9D79BA6", 1);

    var_42 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
      var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

    foreach(var_44 in var_2.attachments) {
      var_45 = "_encstr_B40101";

      if(isDefined(var_42))
        var_45 = [[var_42]](var_44);

      if(isstartstr(var_45, "_encstr_A3CA081B50EDAB3D60A9"))
        _id_12C3F("_encstr_9B6B389BCB6909BCEF5463A79DE228B7FD7A1B4BE8356AF72D4A69D00EF34E159A49095520BA1FDFEA1D8807B8F8AB210D2BE0DFB370462F3BF5", 1);

      if(var_11 == "_encstr_A1100738A33A638123" && isstartstr(var_45, "_encstr_85E508032BD7D638C537"))
        _id_12C3F("_encstr_8D3D3B0570C9FF386FB740609B69704FD3CC708D7FC35D863DEF6018878E2817BB73F89ED4190548F227488877CAA189C29A78112C73F7F0C7CBC1981E", 1);
    }

    if(istrue(var_29))
      _id_12C3F("_encstr_A55337332FC706F079CF7947F2DE18C0F7E26819D19F4888CF9F6D49178560959B190140AB17F0A0A7AA73610FAAF16917B33B08027B20C06B", 1);

    if(istrue(var_34))
      _id_12C3F("_encstr_99C240E363BF3260E628AB9F38192CB993D22CDE38472AA4E8018B9B48302732737E345715EF73FDF3B877AB20CBEF2AE985FACEFD270B3F3880CFF7384086D18705", 1);

    if(istrue(var_32) && var_5 & 1)
      _id_12C3F("_encstr_B46C50A30228B713AF6ADC785B9A486E879A31B139FB851A8D2D61BD03CD5DE3DF65A7F375F2BDC8F7E09E84F099525F8AC8102BB357F34B52A7993C20BB3E5FC081DD37E938DE473A5F179B68A752FE9B66", 1);

    if(var_5 & 16777216)
      _id_12C3F("_encstr_BD0F4AA39A41DB32AF6713275537BA2F48381C6ECE386EBA61133F5FC7EC525BF14094352191270350173747DF842B85C0A94F7F1EF0FF7B882F7B17ADBF93F7C8F685C43380B16278B70FAE", 1);

    if(useserverhud(var_1))
      _id_12C3F("_encstr_96DC39A327EBC6D0FAD9B1B7981663F5DC07ACD8A50B8DAFBB59B01CBDB9EB955B5A58BE33B793AFBD8356E42CA3BDC9F55B4B9B9B2DDB37BE6E4D", 1);

    if(istrue(var_35) || istrue(var_36))
      _id_12C3F("_encstr_83523EFDF7A96B308F1FC292DDF81D59474AD02A9E5883E08719687DBF9155539EF3C7AF53198F473733DF806FFAF0D73AC88938935760604FD83C52CA57AF0E", 1);

    if(var_11 == "_encstr_850707F7E5833355B8")
      _id_12C3F("_encstr_AA5F31E41366079C3F40B29A709B553F5B10717845ABAFE77FD86A9178EF8A873087C5F2EFB3A76A6FC0126BA8DB050B6EEE1D", 1);

    if(var_11 == "_encstr_BE0703A54C")
      _id_12C3F("_encstr_8C8C2E2B8B58C2981109C50D81C8D459A94B1F0FABFAAA49E9313D525EE0F0327EEBDB572D085209A07BB41D50893B4F", 1);

    var_61 = strtok(var_3, "_encstr_854C021F").size;

    if(var_61 >= 5)
      _id_12C3F("_encstr_831940D1DEF7E733B91F38F78139C9F9050A6109FE25A9B8389FF038E503104FB0DD96563B6297B5A3C371943FAD9ED8DBB08307DBF09A117DB443C740ED08D76B77", 1);

    var_95 = 0;
    var_96 = 0;
    var_97 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA");
      var_95 = self[[var_37]]("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
      var_96 = self[[var_37]]("_encstr_99241C0B7A0D70DB62CB697BEF7A1049A2965363E575D986CAE791793FE3");
      var_97 = self[[var_37]]("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
    }

    var_98 = var_95 && var_96 && var_97;

    if(var_98)
      _id_12C3F("_encstr_AFDB4C47C9F51B1ABE9DC6BD132C36FA956D4B16FA771A2D8DCAAFBAB92D73D9EB37A5CDA985D7EDC9D78CCA588CBECD968D9573C659EB99B7C9FAF638B24EB0E87BE4F5B64BE6374BDBDCF5CD53", 1);

    if(var_11 == "_encstr_8D940738966ED1DB8D" && var_5 & 131072)
      _id_12C3F("_encstr_8DCE47DDD1978121218A60703246F1DE8339E655EF234E731472F0E95B1C8970E7CB63C17D83314BBF394830527247083F7F7CC8C29FF8A92793E080AA0A6FA0EFFB7EB3273326F71B", 1);

    switch (var_1) {
      case "_encstr_B81815B4EEC1F5CDD6D7D1271AB037918D96B9CEBE5BC1":
      case "_encstr_8D8E15283F0257BE2B79F3C2F0D7A17162BC013B6632B0":
        _id_12C3F("_encstr_A6C3251CC67FCEB3E7B648A5626818FFF8370B7F26D94A87904ACB274A4D422AD8850BCBE770EE", 1);
        break;
      case "_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588":
      case "_encstr_8A921191BF22995B3A07FD22731F2AA0B6C530":
      case "_encstr_888A12D2DD707D9B6B7DD19331D5E4DCD1AFB538":
      case "_encstr_B688132DDDC17D2CC9BED1C946C26B2C762B7DB538":
        _id_12C3F("_encstr_BE0725E363BF3260E608A79740D82EB9875FEEDBA0617AB50E7ADA57381112C277F5B4939DEF67", 1);
        break;
      case "_encstr_B633121B27EAB7D791F0FB0241AF772658371D1F":
      case "_encstr_A947157F8F9A5066C8598D07F32B4F1551387BF129ABB3":
        _id_12C3F("_encstr_B1F125E8AE172991C9EE989145E2D5169F23C0680BC48DB39142AEB0DDCA0519FBAB10888FA7F3", 1);
        break;
    }
  }

  if(var_8 >= 12) {
    if(var_7) {
      if(turn_on_have_target_hud("_encstr_AC1D1543E780713E3789FB4A53CFF9086E5DF1D7A7BD50") && !isDefined(self._id_13AD4) && var_11 == "_encstr_BE1904DCDA9D" && var_4 & 1048576) {
        if(!isDefined(self._id_13419))
          self._id_13419 = 0;

        self._id_13419++;

        if(self._id_13419 == 2) {
          _id_12C3F("_encstr_AD74353540F9CF085F6790906BB9407F83FD24286C3293B15BB38040B7DBB8A19AE2B0CC059B279B35AF80A00BD7F3EDC20D16C291238D", 1);
          self._id_13AD4 = 1;
        }
      }

      if(turn_on_have_target_hud("_encstr_B2DB14DA273967BF858FBB904573D3A388D0C091DD82") && !isDefined(self.monitoraveragevelocities) && isDefined(var_2) && turret_struct(var_2)) {
        if(isDefined(self._id_12A86) && isDefined(self._id_12A86[var_2.basename]) && self._id_12A86[var_2.basename] == 2) {
          _id_12C3F("_encstr_933A2F1D27FA1B43BEB3C6B726581BEB2CE4FAB6BA8DA396B6A51B8DFA99F69CF5DD2B850EDEDCEBD5B963DB6CADF5E6D8", 1);
          self.monitoraveragevelocities = 1;
        }
      }

      var_99 = var_2.inventorytype == "_encstr_BA7F0830B3A7859B60B0" && !(var_4 & 131072);
      var_100 = var_4 & 131072;
      var_101 = !(var_5 & 1073741824);

      if((var_99 || var_100) && var_101) {
        if(!isDefined(self._id_12A0C))
          self._id_12A0C = 0;

        self._id_12A0C++;
      }

      if(var_12) {
        if(!isDefined(self.numnonrallyvehicles))
          self.numnonrallyvehicles = 0;

        self.numnonrallyvehicles++;
      }

      if(turn_on_have_target_hud("_encstr_A2E1163898A1F1781DF9CB6F3669D5FB1A6751F09F911A37") && !isDefined(self.chooseanim_vehicleturret)) {
        if(isDefined(self._id_11BC2) && self._id_11BC2 > 0 && isDefined(self.numnonrallyvehicles) && self.numnonrallyvehicles > 0 && isDefined(self._id_12A0C) && self._id_12A0C > 0) {
          _id_12C3F("_encstr_BD1255792A11396421C980C8204EE85FCB49AD691F499518D9D7DBA5C9998E6AE1327244AF0197DB45AE878A60385B60833721F579585E60596B9E3B21A1B4CCCC0F3131A28BC9CF7DD1BB2270186DC07057C2DBF9AF5A", 1);
          self.chooseanim_vehicleturret = 1;
        }
      }

      if(turn_on_have_target_hud("_encstr_A6F81432FF91616F99B1D3BBB9B04132BC0B0EB79783") && !isDefined(self.setteamlastzombietime)) {
        if(var_11 == "_encstr_92590EFBF91ED25750D8D7DC30B88E8A" || istrue(var_21) || var_1 == "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381")
          self._id_13B5B = 1;

        if(isDefined(self._id_11BC2) && self._id_11BC2 >= 0 && istrue(self._id_13B5B)) {
          _id_12C3F("_encstr_96CC57D1C9AFD8437D9DC6B726C21BFAD695C69559F55B5A3663D7C163ABE6EB34B0E83686CA47F5F6C9AF474393EDBBD2DCB3F5ADD2631BF5B9A573CEB195F5639633CAF566F69CFABB5685E0DE9BD7EA731BDB36DAEB6EC6", 1);
          self.setteamlastzombietime = 1;
        }
      }

      if(turn_on_have_target_hud("_encstr_910A142387E0115E57295BEAF32F1F384DE615D7355A") && !isDefined(self.waitingforteammaterevive)) {
        if(var_11 == "_encstr_BE1904DCDA9D" && var_4 & 8) {
          if(!isDefined(self._id_13418))
            self._id_13418 = 0;

          self._id_13418++;

          if(self._id_13418 == 3) {
            _id_12C3F("_encstr_8768323AE4AFD834FA9D63DBC4B0D8BE6E5B3BBEC246CDAF3CEBB6A536366EF5CCB74EBEBB2B58E0BD73FAD5371BED6CB5AFCD63", 1);
            self.waitingforteammaterevive = 1;
          }
        }
      }

      if(turn_on_have_target_hud("_encstr_B84418FB93CFF72B284790E2937DC3CBD3BE66FDEC524D960593") && !isDefined(self.trial_targs_combo)) {
        if(var_11 == "_encstr_A1100738A33A638123" && var_4 & 524288) {
          if(!isDefined(self._id_132BC))
            self._id_132BC = 0;

          self._id_132BC++;

          if(self._id_132BC == 2) {
            _id_12C3F("_encstr_B18F3CDDD1978121218A60703246F1DE8F38E855E7476807D212B0606B91A5F01FD66258739FD0597A39C06063B977697750F848EF37D891A582B0D96B1B", 1);
            self.trial_targs_combo = 1;
          }
        }
      }

      if(turn_on_have_target_hud("_encstr_A51414EC0CC949A18B31033E78419933CF28A3E9F981") && !isDefined(self.send_notify_to_module_struct)) {
        if(turret_struct(var_2) && isDefined(self.lastkilledplayer) && make_c4_pick_up_interact(self, self.lastkilledplayer)) {
          if(!isDefined(self.cargo_truck_initcollision))
            self.cargo_truck_initcollision = 0;

          self.cargo_truck_initcollision++;

          if(self.cargo_truck_initcollision == 3) {
            _id_12C3F("_encstr_918D43D14EBEB134D79D63DE310B36F516C9BE6D4BB163BE59E6CAB5E5BE851DAFB1DEEECAC9F559C656D92C1DA5F673BE99F64EAF77595807F637AFEAB91BB7D86DEBE6C6", 1);
            self.send_notify_to_module_struct = 1;
          }
        }
      }
    }

    if(var_7) {
      if(var_12)
        _id_12C3F("_encstr_A56F31C1CED99E7067E7C8A0CE0108D842074961471248A0793DB0BEF7E730102A3BD3DDDF3B2850B75518335AD9A030C1AFFD", 1);

      if(isDefined(self.getanglesfacingorigin) && self.getanglesfacingorigin == 2)
        _id_12C3F("_encstr_AB433D13D0FFB893592F611F43C2E9118CDBF8CE2C2D505DB33B6F212F09AE383D376641969D38983A3F4D6F4723FDE8C9CBE87BB1F5804603CF7F056F7B9C", 1);

      if(var_9 == 5) {
        _id_12C3F("_encstr_AFE632A393F5C686BE3B637B89B0D87DDAB4C61B374793CAC2ADAF6ABE99ED39BEB7C1CA932C47F639D7AD2DDC9B5ABDCDFA3763", 1);
        _id_12C3F("_encstr_91DE25C52A588A3B67AFF858D540BDF74F8772AB50487CC1172185A75A6153097EA971E8958F36", 1);
      }

      if(var_9 == 3)
        _id_12C3F("_encstr_9B8C252D58E1D70D578F80985F8F18774AB2AE35E52A81E96FDAB2116FDAD04B525B933CBF31C7", 1);

      if(isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "_encstr_8C8D08671D451291C849") {
        _id_12C3F("_encstr_B2E035A393FAC60DEBCEB1DE89B036F52B87C1B1EDCD5ACEACD7AD2D36C6377D99B793AFED1CB24EB01DB7E47DB696B9DC4BF637AF6E63", 1);
        _id_12C3F("_encstr_998C255067213FF07F6BB8A14D97F8FF955B78D06A876969A7C01CB057DB20437E83A8B072910D", 1);
      }

      if(isDefined(self.cargo_truck_mg_addgunnerdamagemod) && self.cargo_truck_mg_addgunnerdamagemod == 3)
        _id_12C3F("_encstr_B24B35F3EACE4BAA8F84259D7E9BA22F5118E707F0408CC3E1266F16D23FAFE71988DB4F287BFD9B233DF5CAD073427343103703117366", 1);

      if(self.recentkillcount >= 2)
        _id_12C3F("_encstr_8D193B8EE47DD834AF9DD87BC4588DAF5B2D3663CDFADDA12DC695D7B7DCEB6E8E9C950BB6AFCCED93BEBD1C5627853ABD4EFADAA5B9CDA5ED9BD7B9C6", 1);

      if(istrue(var_2._id_12CC1))
        _id_12C3F("_encstr_8C4634D14E7D6C86D7D963B71385C6F5E6D50E381BF2837B19AF6DA58D1BD766F64ED7BDC1959C2C3ADBE4AFB52DDC6E2DDEE6F59BB1", 1);

      if(var_5 & 268435456) {
        _id_12C3F("_encstr_88AC40D358517A218ED7AB8722415D7F3317496D211789F160EAA51819438198193DC29770B6B063E1078F1627AB59E8DBAAE2D0FCD5A3DEDAC20F9BE8D0F6B197AE", 1);
        _id_12C3F("_encstr_B8132554FB0E42D80FF94FC3E320E39F92F156FFD561190F1E2A9C980542BAF0C64457069FD85B", 1);
        var_95 = 0;
        var_96 = 0;
        var_97 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
          var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA");
          var_95 = self[[var_37]]("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
          var_96 = self[[var_37]]("_encstr_99241C0B7A0D70DB62CB697BEF7A1049A2965363E575D986CAE791793FE3");
          var_97 = self[[var_37]]("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
        }

        var_98 = var_95 && var_96 && var_97;

        if(var_98)
          _id_12C3F("_encstr_AD0246E8C9FA8D0DEBD91BB7C485C67D9BA5CD53167DB62DB1C67DEE96E8D0BDD5A3BE3A0BB5A59B9DF58C16D60B9D56EB33BDC9D7DB38B2C92C47DE4ED7B5B46EB92DF673FA9B1B", 1);
      }

      if(var_4 & 1048576) {
        _id_12C3F("_encstr_8ED22F352EE6D7A0370F785A7E37ABD1D4A532EF8F9BBA3928A70CEA2AF10F43DDB660AC2F55D723609EC3F7F7F84E6364", 1);
        _id_12C3F("_encstr_9BF525637A5EDB3A7F76158D6937125FE098A3EF38D11CD227B7CB0940D58A2D0920071BC8EE1B", 1);
      }

      if(isDefined(self.player_equip_primary) && self.recentkillcount >= 2 && weaponclass(self.player_equip_primary) == "_encstr_BE1904DCDA9D" && var_2 == self.player_equip_primary)
        _id_12C3F("_encstr_9651333A27FAB134F53BD8DB8958C6FAE65BD9F5D6AB1B1D2D6D5A63B1F599DBC9EBF683594EB01DB7C9BE5BD29BCDB4F6E6D7CDB1", 1);

      if(var_11 == "_encstr_BE1904DCDA9D" && var_4 & 16) {
        if(isDefined(var_2) && isDefined(var_2.attachments)) {
          var_42 = undefined;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
            var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

          foreach(var_44 in var_2.attachments) {
            var_45 = "_encstr_B40101";

            if(isDefined(var_42))
              var_45 = [[var_42]](var_44);

            if(isstartstr(var_45, "_encstr_91EC068D0B372B93")) {
              _id_12C3F("_encstr_8CD1478E9CBEB11AD7EC1BF6130B63BEDC5B9DD7A1960E99969C95FA63856E5693D70B8ED1161B43B5CAE6D1FA2BB6D2C2F533B79CFADB83B239C2D1ED27AFD6D2DCDCA5BDDCBE378D", 1);
              break;
            }
          }
        }
      }

      if(var_5 & 262144)
        _id_12C3F("_encstr_88E83763570E018BDFACA5F8FBBA528787A02061E61033D39D2B0F33865F817C85F1A31FFBA7085B3925364507589E3379B76B70D52AC1E2BB", 1);

      if(var_14 && getkillstreaknamefromweapon(var_2) == "_encstr_A2E60C6BC099B7E1A0A93A398F48")
        _id_12C3F("_encstr_ACE14A6CF18726F9EFF7B1804E5189E7BDB2B71729AD59904B96984472C05F32DFA230635B0C494B9F235DDEF267638912CB68C097F490F2E130679803E963489B9178EF2A78217BCE1EE0F3", 1);

      if(var_4 & 512 || var_4 & 1024)
        _id_12C3F("_encstr_8E4748D127BED834EB76B1F6260B1BBE5B5AD81BEB563795DAF2AF7786961BB2EBD84E7BEAD8865946F5DE397D83E47BCDCABE33DB9CEBB70E2B390B1DB74E7DB5A59B9B4BDB9BEBB9D8", 1);

      if(var_5 & 16777216)
        _id_12C3F("_encstr_BE0F4AD1DEC98E431797D8B0FE111828C20F6303AFB2C0204D6CE10BA9FFB87619BFFB95FF791840A7C7690341A778A5A2F7691B7F52D0088FDD33D9328980E8BBA7C38B57EBAB18C6395BBB", 1);

      if(isDefined(self._id_142AD) && var_12) {
        var_104 = self.origin + (0, 0, 35);

        if(var_4 & 1024)
          var_104 = self.origin + (0, 0, 17);

        var_105 = scripts\engine\trace::ray_trace(self._id_142AD.origin + (0, 0, 35), var_104, undefined, undefined, undefined, 1);

        if(isDefined(var_105["_encstr_850E077B0BF30318B9"]) && var_105["_encstr_850E077B0BF30318B9"] != self)
          _id_12C3F("_encstr_99944E3540F9CF085F6790906BB9407F72FFADB32EA2EF9159C7B0607FD55891A9E4ABC9C58B27983E57A8A87FEDF1EDF1CB174E9F4209C327DB7040E70F2B238B3615583299F3C8D39758B03B6783CD", 1);
      }

      if(self.recentkillcount >= 3)
        _id_12C3F("_encstr_962932A15A5986F0399131AFF3DFC861310238AABC65696FB9C179238950885317674797080BA3EA63CFB30B804891858ED7D7D2", 1);

      if(isDefined(self._id_142AD) && !(var_4 & 512)) {
        var_104 = self.origin + (0, 0, 35);

        if(var_4 & 1024)
          var_104 = self.origin + (0, 0, 17);

        var_105 = scripts\engine\trace::ray_trace(var_104, self._id_142AD.origin + (0, 0, 35), undefined, undefined, undefined, 1);

        if(var_105["_encstr_A53009A25003666B9818C6"] < 1)
          _id_12C3F("_encstr_95B64A5B5F1FC80B402F714DCE9138C9C8A0E9E22F1D4840F0815B9AA13791725B58C1DB4BC3CBCF308151A3904870BEDF782DFA2FA8E5129F70C363D5C69BC80A71686C4B7A91D8E209F713", 1);
      }

      if(isDefined(self.watch_for_player_enter_trigger)) {
        var_79 = gettime() - self.watch_for_player_enter_trigger < 10000;

        if(istrue(var_79))
          _id_12C3F("_encstr_BA9D48D19CD7C60DF5D963BD892CB1FAD186E42BCABEBD9CF5DADBE4ACD76D4BC636E6AFBB4B8E86FA378E4BB6EB6E43B747D7CCED277D7BC1AC390BD1F69CD7AD5AE6E6967BCDFAB9C6", 1);
      }

      if(isDefined(self.plantedsuperequip)) {
        foreach(var_55 in self.plantedsuperequip) {
          if(isDefined(var_55.origin) && distancesquared(var_55.origin, self.origin) < 640000) {
            _id_12C3F("_encstr_82214803621F63124F44C272CABACD2727D92DC1A8B89BA0D3E17815208991A32401ABCDE7931051C4EA9E351BE7B2696091EF4187FA293713C9D2E84CFFEBCEC148BB5662E55AA603A2", 1);
            break;
          }
        }
      }

      if(isDefined(self._id_11BC1) && self._id_11BC1 == 3)
        _id_12C3F("_encstr_A9F2468EE4EB6C0DFACED8BD892C8DBEE8A139B256F5DA59369595AFADB4C663B9BED2DCBEE696CDCE8D95D77616B556D7CC7B93EBB783B2C9B03A7BC9F55BD2E637A5DECDF5DC8D", 1);

      if(isDefined(self.attackerdata) && isDefined(self.lastkilledplayer) && isDefined(self.attackerdata[self.lastkilledplayer.guid]) && isDefined(self.attackerdata[self.lastkilledplayer.guid].lasttimedamaged))
        _id_12C3F("_encstr_8AC13BAB6877301BC1A79997DB4A5189EBD4102069B59045DAC78799EF522F80BD213AD80B27A808C377EFB9178B67A05FC26610B453C8334A4B978742", 1);

      if(istrue(var_20))
        _id_12C3F("_encstr_8E7537D0E7A1BF70FFEFB920C22F387F57FBE0C0F9C7D5E9E311B52DE77FC0D13DB150F883113703A72ACF9DBF33CE8B249B4040CAF51FBBD2", 1);

      if(var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        _id_12C3F("_encstr_99C242E363BF3260E628AB9F38192CB981D72B1D2679EAA20EA0B79B20B617B30FFDB7D215B523FB33A8B78BA149DFFBB7807ACFFE3B6B0FDB31B79FE8C381D2BD300293", 1);

      if(isDefined(self.lastkilledplayer)) {
        var_108 = 3936.8;
        var_109 = distance2d(self.origin, self.lastkilledplayer.origin);

        if(var_109 >= var_108)
          _id_12C3F("_encstr_847F3F63E33FB2E066A82B1FB899AC390F53ED1DB8E3DA35C8B0EF1770718AE1535762D5AF1383791299130F48EE5F5B438EBE0BF09D598D38D04F1F88E037938D", 1);
      }
    }

    _id_12C3F("_encstr_8EE72A637F9756A009BF0917A2EEC83007325849A1DB9888D19F390BDAD6D0E0F3E950F08B57C328B55707D5", 1);

    if(istrue(var_27) || istrue(var_28))
      _id_12C3F("_encstr_883550B5E2A11F8A6E8A99D26177E5F76060649361CC2C30D346E3F6086743838B60FFE2E3384BD37BD34DA0507C5FC35CCF18156298AB6FF53F218B1FCBB05DF78D93D181229350FD13EA3BB9F740B952F4", 1);

    if(isDefined(var_2) && va_cluster_spawnpoint_valid(var_2))
      _id_12C3F("_encstr_A9193929F969A083CFDA2870B20F49893F339BFB770B085E0B52C1B9BA1F7E60979C1B0FF6B5D888BFDB19C372EBB87061E58BCF8B9CE86857C37B", 1);

    if(isDefined(var_2) && turret_struct(var_2))
      _id_12C3F("_encstr_8670326050610E19AFC7E0803A4F39B8B7862303673C20267D57C38F26CC185A7F059BC9A6223B5FC3EF5FECFBA76BAFB8963357", 1);

    switch (level.disable_super_in_turret.name) {
      case "_encstr_87A205AF50D049":
      case "_encstr_B40101":
        _id_12C3F("_encstr_928840CBAA201F8C616FC4DF7DC8D5A755989202CE8EEFC54851C5E709A09FB790F1BA0A1070B7FD68BBC7A63780E9D7AF69D332DB307339488BE3BBD340EDCF56EB", 1);
        break;
      default:
        break;
    }

    if(var_11 == "_encstr_BE1904DCDA9D")
      _id_12C3F("_encstr_84C22EDD61016BF2595FE838FEF9D32F1320A2AFFB6B94A6792220A0D81740F3B5573BF7D6A9E7D0986E7305C859BE3E", 1);

    if(var_11 == "_encstr_8D940738966ED1DB8D")
      _id_12C3F("_encstr_B140467C7BF1D6B3B8F1E2DA798FFB81E0A3F3E47FD0114F5A280AC181D04B49C0399D6AFBF8A56B6840820B0B3B077DE98D1FD26F782AFFA6F94BB233184774F04F8147B55132EA", 1);

    if(var_4 & 131072)
      _id_12C3F("_encstr_81B6341393AF2270F6189B8F28693CA9A3C2DCCE085F9A831878B3BFC042D7C21FE629C507ABA3C94388D33F6BB8B3DBCBF0ED716E65", 1);

    if(isDefined(var_2) && isDefined(var_2.attachments)) {
      var_42 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
        var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");

      foreach(var_44 in var_2.attachments) {
        var_45 = "_encstr_B40101";

        if(isDefined(var_42))
          var_45 = [[var_42]](var_44);

        if(isstartstr(var_45, "_encstr_AC540503E843A7") || isstartstr(var_45, "_encstr_8B180587206137") || isstartstr(var_45, "_encstr_8B6605A57A35AD"))
          _id_12C3F("_encstr_AA073E8E9CFAD8D0AF3B8DF62685B1EB56B55AB0FAB2F0E8E416F52CDA5BB7D7AD2CB3C2F4D2B92BFA66DBC97DDEE0AC9CB01DDB4EEBAD96E6DCA5B7DC7DCD63", 1);
      }
    }

    if(var_11 == "_encstr_A1100738A33A638123")
      _id_12C3F("_encstr_822F3235296F79C9C95248481A1E89B6A71030ADCF6FCD5FAFBA6830A1F757EBBF8FC7AD32E70B77520170085B4A13EDA317CEBC", 1);

    if(isDefined(var_2) && unset_relic_focus_fire(var_2))
      _id_12C3F("_encstr_A3FD34AC3ABEC19006F7814251EE4DB73F9AB05F816BE529E8C80FDBC178B0930FCD813759F513965B5FF359376357B6DA30A20F1ADE", 1);

    if(var_11 == "_encstr_BE0703A54C")
      _id_12C3F("_encstr_8D8C2EC006EEA7FCF977937011EF604762BD27282152A9D0613D7782A96F517D03F72B47B589A522BFC731F842B9A22A", 1);

    if(istrue(var_30))
      _id_12C3F("_encstr_84D8413323893A8AF8308D4FABA0886EA178DB1B5903A27BA937B70A0A99E8FB80BC883B941F6675298340098397E2A1E0D3111287136DA258035BC013C3554828A057", 1);

    switch (var_1) {
      case "_encstr_888A12D2DD707D9B6B7DD19331D5E4DCD1AFB538":
        _id_12C3F("_encstr_ABF525A3BA9E1BFA3F3655CD2977529F2058632F78915C12E7778B49B7154A6D49E0C75B882ED9", 1);
        break;
      case "_encstr_92EB12131F4768A8BD0153C2F591383B5B57E3A9":
      case "_encstr_B633121B27EAB7D791F0FB0241AF772658371D1F":
      case "_encstr_8660192DEEE0D7854EFA8E4EDC8DBDEE0D0BB9C88DA59BB3EBB50E":
        _id_12C3F("_encstr_8EDE253A72EB6C0D7D6CB76B6BF69BAFED0E4C5773911BB2AF066AAFDEC435958DD14B3B95AF13", 1);
        break;
      case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
      case "_encstr_A6CB155AEEE0BECDB67DD19C9BE8C23791164E91EBAD07":
        _id_12C3F("_encstr_8B8C25A3986E6B08E7806D50B5ADA83720B966D3786962CD27E14FFF6085184FF1B9810BC81947", 1);
        break;
      case "_encstr_B81815B4EEC1F5CDD6D7D1271AB037918D96B9CEBE5BC1":
      case "_encstr_A90415B3BFE7C8E819A1F3A217EDC099AA1F313787DA27":
        _id_12C3F("_encstr_AC1325CCCB41666368A1220A485843D168C152358D406D1F30B3BF1110269B177061C1BE23F162", 1);
        break;
      case "_encstr_B2DB14DA273967BF858FBB904573D3A388D0C091DD82":
        _id_12C3F("_encstr_ABF525A3BA9E1BFA3F3655CD2977529F2058632F78915C12E7778B49B7154A6D49E0C75B882ED9", 1);
        _id_12C3F("_encstr_AC1325CCCB41666368A1220A485843D168C152358D406D1F30B3BF1110269B177061C1BE23F162", 1);
        break;
    }
  }

  if(var_8 >= 14) {
    if(var_7) {
      var_95 = 0;
      var_96 = 0;
      var_97 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
        var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA");
        var_95 = self[[var_37]]("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
        var_96 = self[[var_37]]("_encstr_99241C0B7A0D70DB62CB697BEF7A1049A2965363E575D986CAE791793FE3");
        var_97 = self[[var_37]]("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
      }

      var_98 = istrue(var_95) && istrue(var_96) && istrue(var_97);

      if(turn_on_have_target_hud("_encstr_A79D13BAEFD8265A194773AA4ABFE04143AF215BB8") && var_98 && var_5 & 1073741824) {
        if(!isDefined(self.isgroundwardom))
          self.isgroundwardom = 1;
        else
          self.isgroundwardom++;

        if(self.isgroundwardom == 2)
          _id_12C3F("_encstr_B2E45688CE7749F1E9CF39B066E23136BD57D08807DF83935232A0C8317A6318142780585FB4192F3B9AABC01751A5604E5BC869DF421601C20615406AEA99A9A60760F153E70BBFCB2F9FDF45B2B7131E93A8989FBFE357", 1);
      }
    }
  }

  if(var_8 >= 15) {
    if(var_7) {
      if(turn_on_have_target_hud("_encstr_96AA1696BB1CFACDB6F5D1C9998DB2C643568ED1B27DDAC1") && var_11 == "_encstr_BE1904DCDA9D" && var_5 & 4194304 && !istrue(self._encstr_9AFF106EDAB319B28ECA1B47CAC8DAA51BD8)) {
        _id_12C3F("_encstr_85233C830A7F661B5E1CC4CFA6A133A18F303AC970CB1D4336F5D5ECCD099B77D9098252B8AB14BF6B70DEFF5ED6CFBF7B08AACA01230DD3C046ABD7F6F3", 1);
        self._encstr_9AFF106EDAB319B28ECA1B47CAC8DAA51BD8 = 1;
      }
    }
  }
}

runplunderextractsitetimer(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")) {
      var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_0.basename);
      var_3 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 5, var_2, 4);
      var_4 = var_3 + "_encstr_83750BD7B3C293D2C2DCE8EB06";
      var_1 = int(tablelookup("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", 6, var_4, 0));
    }
  }

  return var_1;
}

resetstreamerposhint() {
  var_0 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8ACE16618DA287E3384F90A0E345D8E108F26DF6E6EB47CB")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8ACE16618DA287E3384F90A0E345D8E108F26DF6E6EB47CB")]](self.team);

    if(var_1 != "_encstr_B40101")
      var_0 = int(tablelookup("_encstr_B62516C6DBDB1DF2DB07594E0BA3B727BED291DCC5369B3B", 1, var_1, 0));
  }

  return var_0;
}

init_silo_elevator(var_0, var_1, var_2, var_3) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  if(var_3 <= 0) {
    return;
  }
  var_4 = relic_amped_is_there_valid_new_victim();
  var_5 = var_0 runplunderextractsitetimer(var_2);
  var_6 = var_0 resetstreamerposhint();

  if(!isDefined(var_1))
    var_1 = [];

  var_7 = 0;

  if(istrue(var_1["_encstr_849508B2188BC58BF97D"]))
    var_7 = var_7 | 1;

  if(istrue(var_0.modifiers["_encstr_B49B0B6CDEC68DC28EAC4E168D"]))
    var_7 = var_7 | 2;

  var_8 = 0;
  var_9 = weaponclass(var_2.basename);

  if(issubstr(var_2.basename, "_encstr_B643052F61B5E9"))
    var_9 = "_encstr_A6C7065BACB1CA95";

  switch (var_9) {
    case "_encstr_965306392D3336B2":
      var_8 = 3;
      break;
    case "_encstr_BE0703A54C":
      var_8 = 17;
      break;
    case "_encstr_A6C7065BACB1CA95":
      var_8 = 513;
      break;
    case "_encstr_8D940738966ED1DB8D":
      var_8 = 129;
      break;
    case "_encstr_A1100738A33A638123":
      var_8 = 9;
      break;
    case "_encstr_BE1904DCDA9D":
      var_8 = 5;
      break;
    case "_encstr_850707F7E5833355B8":
      var_8 = 65;
      break;
    default:
      break;
  }

  if(var_9 == "_encstr_A6C7065BACB1CA95" && !isDefined(var_0.pers["_encstr_84301309A57369039D83B8407A2CD380AB6737F63D"])) {
    var_7 = var_7 | 32;
    var_0.pers["_encstr_84301309A57369039D83B8407A2CD380AB6737F63D"] = 1;
  }

  if(var_9 == "_encstr_B116071BCAD186858D" && !isDefined(var_0.pers["_encstr_8ABB141AA98951C7A05110ACDCDA52E7849BC725796F"])) {
    var_7 = var_7 | 4;
    var_0.pers["_encstr_8ABB141AA98951C7A05110ACDCDA52E7849BC725796F"] = 1;
  }

  var_0 reportchallengeuserevent("_encstr_979608DF73C8E70B73A1", 1, var_5, var_3, var_6, var_4, var_7, var_8);
}

init_sentry_traps(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = var_1 resetstuckthermite();
  var_11 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

  if(!isDefined(var_11))
    var_11 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

  var_12 = play_station_closed_vo(var_6);
  var_13 = play_stealthy_disguise_vo(var_1);
  var_14 = [var_7, 0];
  var_15 = play_sound_from_closest_player(var_3);
  var_16 = "_encstr_B40101";

  if(isDefined(var_1.modifiers) && isDefined(var_1.modifiers["_encstr_88C91516B1A34BB359D7CC4B56B18CD75D83D99C16C8B2"]))
    var_16 = var_1.modifiers["_encstr_88C91516B1A34BB359D7CC4B56B18CD75D83D99C16C8B2"];

  var_17 = 65535;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
    var_17 = level.br_circle.circleindex;

  var_18 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_8C07101FB3D8AB173783627AEF1F739C7013"))
    var_18 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_8C07101FB3D8AB173783627AEF1F739C7013")]](var_6);

  if(!isDefined(var_18))
    var_18 = 65535;

  if(var_2[0] == "_encstr_81C80E0C79E00F3BF583FB8FF5B0C278" || var_2[0] == "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07")
    var_8 = "_encstr_8D4E0A501FCB898912CB3FA3";

  if(getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7", 1)) {
    var_19 = var_1 getfireteammembers();
    var_20 = var_19.size;
  } else
    var_20 = 1;

  if(isDefined(var_1.pers["_encstr_93500B11CD1B017B642AA0A8E3"]) && var_1.pers["_encstr_93500B11CD1B017B642AA0A8E3"] == 5)
    var_1.mp_village2_patches["_encstr_962D15A9F5ADCAC6CACAD777AC5883DB377DAD96D8B1E6"] = 1;

  if(isDefined(var_1.pers["_encstr_A7FF0C03DD3410080F51C1C0C437"]) && var_1.pers["_encstr_A7FF0C03DD3410080F51C1C0C437"] == 10)
    var_1.mp_village2_patches["_encstr_AF0211DA920F618173E98E99FFE9C728945B40"] = 1;

  if(isDefined(var_1.pers["_encstr_A9E50C61184837F11940A8D573B7"]) && var_1.pers["_encstr_A9E50C61184837F11940A8D573B7"] == 5)
    var_1.mp_village2_patches["_encstr_B20814B5D070EF2EB9F0E2AAF0F766FBCEA26194D1BB"] = 1;

  if(isDefined(var_1.pers["_encstr_ACF81397CBE24F50F25540394AC0C885787F3121C7"]) && var_1.pers["_encstr_ACF81397CBE24F50F25540394AC0C885787F3121C7"] == 10)
    var_1.mp_village2_patches["_encstr_ADC012510199BAD3C0534B0260ADDF74F011B49B"] = 1;

  if(isDefined(var_1.pers["_encstr_B2F50A49DCFAA02A022B794F"]) && var_1.pers["_encstr_B2F50A49DCFAA02A022B794F"] == 5)
    var_1.mp_village2_patches["_encstr_8A7B0CF5D7708B9080B0A04BF2EA"] = 1;

  if(isDefined(var_1.pers["_encstr_92B50CDABDB3D2DCEC695A8D8D37"]) && var_1.pers["_encstr_92B50CDABDB3D2DCEC695A8D8D37"] == 10)
    var_1.mp_village2_patches["_encstr_AB2E0E230A5760B873BFFDE79FAA7130"] = 1;

  if(isDefined(var_1.pers["_encstr_9BE4105B208BCD83057121569A4CBF15D968"]) && var_1.pers["_encstr_9BE4105B208BCD83057121569A4CBF15D968"] == 10)
    var_1.mp_village2_patches["_encstr_AB4312BB92FFB8915A7F73254F326CC0935C98A8"] = 1;

  if(isDefined(var_1.pers["_encstr_81B00D6844C3B7343A28E1194043A0"]) && var_1.pers["_encstr_81B00D6844C3B7343A28E1194043A0"] == 10)
    var_1.mp_village2_patches["_encstr_96F40F0FA8E79073BACAF82892140B6843"] = 1;

  if(isDefined(var_1.pers["_encstr_929E0B1F4C129278AC8BE42A63"]) && var_1.pers["_encstr_929E0B1F4C129278AC8BE42A63"] == 3)
    var_1.mp_village2_patches["_encstr_8AE00EDBF197531B23A32F1823E31093"] = 1;

  if(isDefined(var_1.pers["_encstr_AC3310E07AC707A817C41088ADFFF031ED33"]) && var_1.pers["_encstr_AC3310E07AC707A817C41088ADFFF031ED33"] == 10)
    var_1.mp_village2_patches["_encstr_87691398C0AFDB372BCD43DBE8B7DCCA6D5A63D8E6"] = 1;

  var_21 = gettouchinglocaletriggers(var_1, var_3);
  var_22 = relic_amped_is_there_valid_new_victim();
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = runleadmarkers(var_6);
  var_27 = _encstr_8873122F83E896F3E7D0A23AB8CC1FCDA851A9B4();
  var_1 reportchallengeuserevent("_encstr_ABD70578F3D02C", var_14, var_2, var_4, var_5, var_10, var_22, var_12, var_13, var_15, var_16, var_21, var_8, var_18, var_17, var_20, var_9, var_23, var_26, var_25, var_24, var_27);

  if((var_11 == "_encstr_B607038AAB" || var_11 == "_encstr_931D068662634370") && (isPlayer(var_3) || var_15 & 32)) {
    var_28 = var_2[0];

    if(isDefined(var_1.modifiers) && istrue(var_1.modifiers["_encstr_B1100A561EACC6AB3AB47BCD"])) {
      if(isDefined(var_1.primaryweaponobj)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
          var_28 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_1.primaryweaponobj.basename);
      }

      if(isDefined(var_1.weaponlist)) {
        foreach(var_30 in var_1.weaponlist) {
          if(var_30.basename == "_encstr_ABDA14AAD3233F1D60EF2C59B108261B200BF33178DF")
            var_28 = "_encstr_ABDA14AAD3233F1D60EF2C59B108261B200BF33178DF";
        }
      }
    }

    var_1._id_142AD = var_3;
    var_1 init_turrets(var_15, var_28, var_6, var_12, var_4, var_5, var_0, 1);
  }
}

relic_squadlink_onsteppedclose() {
  var_0 = 0;

  if(isDefined(self.mp_village2_patches)) {
    foreach(var_3, var_2 in self.mp_village2_patches) {
      switch (var_3) {
        case "_encstr_962D15A9F5ADCAC6CACAD777AC5883DB377DAD96D8B1E6":
          var_0 = var_0 | 2;
          break;
        case "_encstr_AF0211DA920F618173E98E99FFE9C728945B40":
          var_0 = var_0 | 4;
          break;
        case "_encstr_B20814B5D070EF2EB9F0E2AAF0F766FBCEA26194D1BB":
          var_0 = var_0 | 8;
          break;
        case "_encstr_ADC012510199BAD3C0534B0260ADDF74F011B49B":
          var_0 = var_0 | 16;
          break;
        case "_encstr_8A7B0CF5D7708B9080B0A04BF2EA":
          var_0 = var_0 | 32;
          break;
        case "_encstr_AB2E0E230A5760B873BFFDE79FAA7130":
          var_0 = var_0 | 64;
          break;
        case "_encstr_AB4312BB92FFB8915A7F73254F326CC0935C98A8":
          var_0 = var_0 | 128;
          break;
        case "_encstr_96F40F0FA8E79073BACAF82892140B6843":
          var_0 = var_0 | 512;
          break;
        case "_encstr_8AE00EDBF197531B23A32F1823E31093":
          var_0 = var_0 | 16384;
          break;
        case "_encstr_87691398C0AFDB372BCD43DBE8B7DCCA6D5A63D8E6":
          var_0 = var_0 | 32768;
          break;
      }
    }
  }

  if(_func_043E(self))
    var_0 = var_0 | 1;

  return var_0;
}

runleadmarkers(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 10; var_2++)
    var_1[var_2] = "_encstr_B40101";

  if(!isDefined(var_0) || !isDefined(var_0.attachments))
    return var_1;

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695"))
    return var_1;

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
    return var_1;

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AFD81716A3470BD8D0B556B9A329B99A958D2B36A316988DAC"))
    return var_1;

  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695")]](var_0.basename);
  var_4 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 5, var_3, 4);
  var_5 = "_encstr_8BB606A877A74B9F" + var_4 + "_encstr_AF5214EB0B478EC2C6A16B56E647AF968CCD71D8DCB3";
  var_6 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF");
  var_7 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AFD81716A3470BD8D0B556B9A329B99A958D2B36A316988DAC");
  var_2 = 0;

  foreach(var_9 in var_0.attachments) {
    var_10 = [[var_6]](var_9);

    if([[var_7]](var_0, var_10)) {
      var_1[var_2] = tablelookup(var_5, 1, var_10, 0);
      var_2++;
      continue;
    }

    if(isDefined(level._encstr_AB721901D9019A0E680FAD906CB570559E03228D6FE9CADA6077FF) && isDefined(level._encstr_AB721901D9019A0E680FAD906CB570559E03228D6FE9CADA6077FF[var_9]) && [[var_7]](var_0, level._encstr_AB721901D9019A0E680FAD906CB570559E03228D6FE9CADA6077FF[var_9])) {
      var_1[var_2] = tablelookup(var_5, 1, level._encstr_AB721901D9019A0E680FAD906CB570559E03228D6FE9CADA6077FF[var_9], 0);
      var_2++;
    }
  }

  if(var_2 > 10) {}

  return var_1;
}

play_station_closed_vo(var_0) {
  var_1 = "_encstr_B40101";
  var_2 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_97F718A5B9680A1AA093D26B85395EF49CD456B1DB37230B39F2")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_97F718A5B9680A1AA093D26B85395EF49CD456B1DB37230B39F2")]](var_0))
      var_1 = "_encstr_B2900F2AA8011BFB130FEFB0EBCADA3B96";
  }

  if(isDefined(var_0.attachments)) {
    var_3 = 0;

    foreach(var_5 in var_0.attachments) {
      var_6 = "_encstr_B40101";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF"))
        var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF")]](var_5);

      if(var_6 == "_encstr_B8FB06FF97EA2708")
        var_3 = 1;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AFD81716A3470BD8D0B556B9A329B99A958D2B36A316988DAC")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AFD81716A3470BD8D0B556B9A329B99A958D2B36A316988DAC")]](var_0, var_6)) {
          if(!var_2)
            var_1 = var_1 + "_encstr_854C021F";

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_B2201A392BB5C238508E47C2B11ADA56738E412CC995E6A3E4C2DA56"))
            var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_B2201A392BB5C238508E47C2B11ADA56738E412CC995E6A3E4C2DA56")]](var_6);

          var_1 = var_1 + var_6;
          var_2 = 0;
        }
      }
    }

    if(var_3) {
      if(!var_2)
        var_1 = var_1 + "_encstr_854C021F";

      var_1 = var_1 + "_encstr_B6D51592F81D961F4885E7C390B053DF9D916B7A40C94F";
    }
  }

  return var_1;
}

play_stealthy_disguise_vo(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0.classstruct)) {
    if(istrue(var_1))
      var_2 = var_0.classstruct.loadoutextraperks;
    else
      var_2 = var_0.classstruct.loadoutperks;
  }

  var_3 = "_encstr_B40101";
  var_4 = 1;

  if(isDefined(var_2)) {
    foreach(var_6 in var_2) {
      if(!var_4)
        var_3 = var_3 + "_encstr_854C021F";

      var_3 = var_3 + var_6;
      var_4 = 0;
    }
  }

  return var_3;
}

play_sound_from_closest_player(var_0) {
  var_1 = 0;

  if(isPlayer(var_0))
    var_1 = var_1 | 1;

  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_0.streakinfo)) {
    var_1 = var_1 | 2;
    var_6 = var_0.streakinfo.streakname;
    var_5 = unsetreduceregendelayonkill(var_6);

    switch (var_6) {
      case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
      case "_encstr_B1B30B51D176511E377A1BC313":
      case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      case "_encstr_8CC008133958C81BACCB":
      case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
        var_2 = 1;
        break;
      case "_encstr_B8BA05F06B9785":
      case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
      case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
      case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      case "_encstr_8C980A867B3B569CFAA659E8":
      case "_encstr_86FD08B775CD07DC1338":
      case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
      case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
      case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
        var_3 = 1;
        break;
      case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
      case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
      case "_encstr_851904B59B34":
      case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
        var_3 = 1;
        var_4 = 1;
        break;
      case "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B":
      case "_encstr_BA67082278D537E3C827":
        var_4 = 1;
        break;
    }

    if(var_2)
      var_1 = var_1 | 8;

    if(var_3)
      var_1 = var_1 | 4;

    if(var_4)
      var_1 = var_1 | 16;
  }

  if(isDefined(var_0.vehiclename) || var_5) {
    var_1 = var_1 | 32;

    if(!var_2 && isDefined(var_0.vehiclename) && !istrue(var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
      var_1 = var_1 | 8;

    if(!var_3 && isDefined(var_0.vehiclename) && istrue(var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
      var_1 = var_1 | 4;
  }

  if(isDefined(var_0.equipmentref))
    var_1 = var_1 | 64;

  if(isagent(var_0))
    var_1 = _id_12CE0(var_1, var_0);

  return var_1;
}

_id_12CE0(var_0, var_1) {
  if(isDefined(var_1.unittype) && var_1.unittype == "_encstr_BACB074025B01AAA28")
    var_0 = var_0 | 2048;

  if(!isDefined(var_1.aitype))
    return var_0;

  switch (var_1.aitype) {
    case "_encstr_958C08CDDBD8325A959C":
      var_0 = var_0 | 512;
      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      var_0 = var_0 | 128;
      break;
    case "_encstr_8EF60E63FBE3D70440A312175B98CF6B":
      var_0 = var_0 | 1024;
      break;
    case "_encstr_A5450BC280BF4B604068C33187":
      var_0 = var_0 | 256;
      break;
    default:
      var_0 = var_0 | 512;
      break;
  }

  return var_0;
}

watchreloading(var_0) {
  self endon(var_0);
  self waittill("_encstr_8A730DD6B72A37C984A7486847CA23");

  if(level.getallactivequestsforteam >= 11)
    self.zombieloadout = undefined;
}

va_cluster_spawnpoint_valid(var_0) {
  var_1 = weaponclass(var_0);

  if(var_1 != "_encstr_965306392D3336B2")
    return 0;

  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1"))
    var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A9DC16DFB5E1797539989F9359912603E7DF63D72C6FE3A1");

  if(!isDefined(var_2))
    return 0;

  return [[var_2]](var_0.basename) == "_encstr_9B65109F23E0F24FC016431A79258FEE4889";
}

turret_struct(var_0) {
  var_1 = va_cluster_spawnpoint_valid(var_0);
  var_2 = weaponclass(var_0);
  return var_2 == "_encstr_965306392D3336B2" && !var_1;
}

unset_relic_focus_fire(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(weaponisauto(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "_encstr_965306392D3336B2":
        return !va_cluster_spawnpoint_valid(var_0);
      case "_encstr_BE1904DCDA9D":
      case "_encstr_8D940738966ED1DB8D":
      case "_encstr_A1100738A33A638123":
      case "_encstr_BE0703A54C":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

useserverhud(var_0) {
  switch (var_0) {
    case "_encstr_88AC1394CB88B917A8A797F32F539A05376FD02DD3":
    case "_encstr_A3BF1B2DF308C9816A3FA123D3725918E14A2B981EB3984B72BFFF83B3":
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_A51B1507B34B7F6BA6F7392BA692F5D32B2A28BFF161AB":
    case "_encstr_A30914AF1FA248DA40A925CB767AA382FFC7EB889ABF":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
      return 1;
    default:
      return 0;
  }
}

make_c4_pick_up_interact(var_0, var_1) {
  if(isDefined(var_0.origin) && isDefined(var_1.origin)) {
    var_2 = var_0.origin[2] - var_1.origin[2];
    var_3 = 70;

    if(var_2 >= var_3)
      return 1;
  }

  return 0;
}

_id_1424B() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self, 1);

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 10 && self.targetname == "_encstr_99C20BA548E9F27A61D897932B") {
    if(!self vehicle_isonground()) {
      if(!isDefined(var_0.investigate_someone_using_bomb))
        var_0.investigate_someone_using_bomb = gettime();
      else {
        var_1 = gettime() - var_0.investigate_someone_using_bomb;

        if(var_1 >= 1000) {
          var_0 _id_12C3F("_encstr_929C37111971E2102E97E41A41F8F31614548B6BEF1B49AC2B0F86C75BC4975170616FA203678D72B33B2B8378FDF132D3904FC14FD5D6C77B", var_1 / 1000);
          var_0.investigate_someone_using_bomb = undefined;
        }
      }
    } else if(isDefined(var_0.investigate_someone_using_bomb)) {
      var_1 = gettime() - var_0.investigate_someone_using_bomb;

      if(var_1 >= 1000)
        var_0 _id_12C3F("_encstr_929C37111971E2102E97E41A41F8F31614548B6BEF1B49AC2B0F86C75BC4975170616FA203678D72B33B2B8378FDF132D3904FC14FD5D6C77B", var_1 / 1000);

      var_0.investigate_someone_using_bomb = undefined;
    }
  }
}

update_objective_ownerclient(var_0) {
  if(isDefined(level._id_13641) && isDefined(level.modeupdateloadoutclass)) {
    var_1 = 348100;

    foreach(var_3 in level._id_13641) {
      var_4 = distance2dsquared(var_0, var_3.curorigin);

      if(var_4 <= var_1)
        return 1;
    }

    foreach(var_7 in level.modeupdateloadoutclass) {
      var_4 = distance2dsquared(var_0, var_7.origin);

      if(var_4 <= var_1)
        return 1;
    }
  }

  return 0;
}

_id_12083() {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 10 && getdvarint("_encstr_84911D53788589CF98FF2A2C85C6AB8AB760FA9BE061BD37F3D50F50A5C83B", 0) == 1)
    _id_12C3F("_encstr_B2012C38994F376041BF1CF8F23FBAE68315887B55A8BFD7B7D9900B7B60D8B24796D0F2A49E071C5588FC8E8CB3", 1);
}

_id_12005() {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 10 && getdvarint("_encstr_84911D53788589CF98FF2A2C85C6AB8AB760FA9BE061BD37F3D50F50A5C83B", 0) == 1)
    _id_12C3F("_encstr_A7AC36E893BED886D7EC36BD4CB01BBE367B1B36CAD8D1EBE6851D598DD85A1DACAF9CCABB16E432BE99BD9CFA6E43F5AC3B95E6A37DBBE9", 1);
}

_id_120A9(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(level.getallactivequestsforteam >= 11 && getdvarint("_encstr_B28D1DB91B4E7D8939BECDEAAD89B24E37F51D7BDDCA27FACAB9C231C6B28C", 0) == 1 && getdvarint("_encstr_A90F1CE66C39AF9827AFB9ABB589CA27CDEBA3DEEEB239D757DC0B2663B2", 0) == 1)
    _id_12C3F(var_0, 1);
}

_id_125F3() {
  return istrue(self.iszombie);
}

onplayerteamrevive(var_0, var_1) {}

onsuccessfulhit(var_0) {}

onspawn() {}

updatesuperweaponkills(var_0, var_1) {}

updatesuperkills(var_0, var_1, var_2) {}

resistedstun(var_0) {}

triggereddelayedexplosion() {}

minedestroyed(var_0, var_1, var_2) {}

roundbegin() {}

roundend(var_0) {}

playerdamaged(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1) && !var_1 challengesenabledforplayer()) {
    return;
  }
  if(level.getallactivequestsforteam >= 12) {
    if(isDefined(var_1)) {
      var_1 _id_12C3F("_encstr_9AC331A393BE8D43BE76B17B4C1663F5910BD65876ACF546B7DC957D33F639EBF638CA932CE8EDE47DB55AB937D27BB9EBDC1B", var_2);
      var_1 _id_12C3F("_encstr_ABC01CE8937D1B1AD7CE36B74CC2B1D7460BD6B0B3ACEBC8BD37B2F59B8D", var_2);
    }
  }

  if(turn_on_have_target_hud("_encstr_91AB132B431F27B9E2F720B2BF079383122B88A11A") && isDefined(var_1) && !isDefined(var_1._id_139E3)) {
    if(isDefined(var_4) && turret_struct(var_4)) {
      if(!isDefined(var_1._id_11B21))
        var_1._id_11B21 = var_2;
      else
        var_1._id_11B21 = var_1._id_11B21 + var_2;

      if(var_1._id_11B21 >= 1000) {
        var_1 _id_12C3F("_encstr_960836101AE1C67A4E02AA382549F967E7E649C531AA6371125F1FA77989A670E23FCF4EBF7FE5DFACA5D732CA30B798A512979E8AD87377", 1);
        var_1._id_139E3 = 1;
      }
    }
  }
}

processuavassist(var_0, var_1) {}

killstreakdamaged(var_0, var_1, var_2, var_3, var_4) {}

unsetreduceregendelayonkill(var_0) {
  switch (var_0) {
    case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return 0;
  }

  return 1;
}

getkillstreaknamefromweapon(var_0) {
  var_1 = var_0.basename;

  if(isDefined(level.killstreakweaponmap[var_1]))
    return level.killstreakweaponmap[var_1];

  return undefined;
}

processfinalkillchallenges(var_0, var_1) {}

usedkillstreak(var_0) {
  if(!isDefined(self.vote_player_init)) {
    if(!isDefined(self.fuelsequencestability))
      self.fuelsequencestability = 1;
    else
      self.fuelsequencestability++;

    if(self.fuelsequencestability >= 5) {
      _id_12C3F("_encstr_8848373A4EBEC6A1EB9D1BDE1316B1BEE1AF3736DEC92BE647939558ADBE851BA34BD9581D5AB7DCB9EBB99673B3362BAF6BC21D6C34BEE666", 1);
      self.vote_player_init = 1;
    }
  }

  if(level.getallactivequestsforteam >= 9 && (var_0 == "_encstr_B8BA05F06B9785" || var_0 == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" || var_0 == "_encstr_B270105ECB28E94BC5CFABAB937D524C5053" || var_0 == "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4" || var_0 == "_encstr_B1B30B51D176511E377A1BC313" || var_0 == "_encstr_A2E60C6BC099B7E1A0A93A398F48" || var_0 == "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A" || var_0 == "_encstr_8CC008133958C81BACCB" || var_0 == "_encstr_86FD08B775CD07DC1338" || var_0 == "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA" || var_0 == "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3" || var_0 == "_encstr_AA060B6EB2731DE4BCFAEC57E6" || var_0 == "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2" || var_0 == "_encstr_8C980A867B3B569CFAA659E8" || var_0 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79" || var_0 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"))
    _id_12C3F("_encstr_AF694094433657CC6FF0024AA06B85EFE9C70434E8189BD921C88B329059B18741B882B51603A31FE3A021CAF8BDF9BFDB150A292D087BA99358EB9320EF6DC713A6", 1);

  if(level.getallactivequestsforteam >= 12)
    _id_12C3F("_encstr_8E13258B977F4EB82193373BB515B018179BC1D38ACB7118C9389F67AF3ED8DDDF73383B82CF16", 1);
}

resetstuckthermite() {
  var_0 = [];

  if(isDefined(self.team) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8ACE16618DA287E3384F90A0E345D8E108F26DF6E6EB47CB"))
    var_0[0] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8ACE16618DA287E3384F90A0E345D8E108F26DF6E6EB47CB")]](self.team);
  else
    var_0[0] = "_encstr_B40101";

  if(isDefined(self.team) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_958014B1BDDE6DEAC1A7E8D056E43DE02B2785E8DEC9"))
    var_0[1] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_958014B1BDDE6DEAC1A7E8D056E43DE02B2785E8DEC9")]](self.team);
  else
    var_0[1] = "_encstr_B40101";

  return var_0;
}

attachmentgroup(var_0) {
  return tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_0, 2);
}

_encstr_B6851AEC95A3BD0E95E485A3F6E4332C677BC9A53A95EECA16E0BDB9(var_0) {
  var_1 = "_encstr_B40101";

  if(var_0 != "_encstr_B40101")
    var_1 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 33);

  return var_1;
}
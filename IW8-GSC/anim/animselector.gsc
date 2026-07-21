/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\animselector.gsc
***********************************************/

getanimselectorfilenames() {
  var_0 = [];

  if(scripts\common\utility::iscp()) {
    var_0["_encstr_9A9A1103451E539B72764D879303DBF88F08C8"] = [[0, "_encstr_920F30E6881312BB61B04F6F4818724BDB162D1FEE374BFF2898777F90F64C73B3B4F75256DBC12F51300B8FB04B5EAA2FCC"], [1, "_encstr_9B6F31583796AD37B2C6951BD1B7E447B0268D566E97D896ECA5B1D258B9F547C92CB35939CDB2F5DDC29CE0BE5DC18BD8373B"], [2, "_encstr_8A1C2FBAD87BFD6F31A1F5EB4598A3439350F272885F7667689EFDF2C8C3FB4E15F09BAB50E7EB97A3FFFF0D77E077124D"]];
    var_0["_encstr_A7BA13F32073333FEB26FDCF3C51BB7AE768CA5B68"] = [[0, "_encstr_B6AB3258CDB4DA9B5636958D1D7B9C1D0BC463B2DCCBE6DBD823B456C9AF1D9316672B93DC2BBEEE164E83FA91DBEE73B88DB9B3"], [1, "_encstr_AA5533F31DC04806F76AB210AB80BBD593A5145D974F50117D20C13C888A3103E5170DF1951BBFB117F1FB31BECFB70C4845468B8D"], [2, "_encstr_A7433107AA92F7D8E3D1652B2C7058BCFBCA5517DFFFE67068417AF21F1353C1452FE88787C1375F856BF7A37077CDE241DF6E"]];
    var_0["_encstr_81E5133403D99507481F071978AFCD2277A7ED5B93"] = [[0, "_encstr_8D0335589BA56BCD593695D8E8F693E85826B1569B5E9BDB6319D2AC397D8E4EC2D959396E56BEBBC22783AFF63B959CF56C388BB137CE"], [1, "_encstr_810F338AE84BCD5F21B1E51B558893538320E24298AF066F7B2BE419E7F05F1B0DC0CBDAF8AF7F7F3307E21890F833E77512023360"], [2, "_encstr_ABB03185E64BDA37B2632BB13ABD93D10B261B56CDE513BDB6269527BE8EC9B03BAC9CCDACF5EE85271CFAF6CECA398B369BD9"]];
    var_0["_encstr_ABA015238B2F9C8802EB5B37F72EF8672F52596BE2CF56"] = [[0, "_encstr_AD57371EA08BD38B57B269904BAF062371B2BB6FC31F0737D04FD1D3D3A9BBCBD096EDDDA047CFF4E6BBBB6E27AF6B783F4638E8DB786757DC"], [1, "_encstr_8F12355B230A2938CDB519D1DBBF48DDE28BC9EBFFB6E620F6CC20E88696E9156BEF656303DBBDC92F26EBC32141504E521FE76DEFA3FC"], [2, "_encstr_A32233EF463422082DC8C3476BA003D94BAE20E5AF668D7D1993A3CB2F584EC9E37F08D22579CF63833A97CEA73228AB40E6C9F8D8"]];
    var_0["_encstr_95A717733089DEFA550EE711741BC3801620FBFB10030E6251"] = [[0, "_encstr_A7923685DC4BDA37ACD8561B3A7B39E88531B15937E5B9DEC6C84BCA93AF8EE416EC95E46EB2BEBB85C983BE2B1EE856C9730B8DE26CCDD9"], [1, "_encstr_819837713820BFDACB98A2DA400752139996F4EDCE80DF64C5583A72C06D41AB138F5665E6D30FA1BF2023DB494340E3A9EEC61971D06F7295"], [2, "_encstr_ABEC3552309365F799194D432DE0CBEB2BC80AEA30C71ECFF076556A506B03F67D587303384F132FCB676775DB3307FAE50B1A4E60AF8B"]];
  } else {
    var_0["_encstr_9A9A1103451E539B72764D879303DBF88F08C8"] = [[0, "_encstr_920F30E6881312BB61B04F6F4818724BDB162D1FEE374BFF2898777F90F64C73B3B4F75256DBC12F51300B8FB04B5EAA2FCC"], [1, "_encstr_9B6F31583796AD37B2C6951BD1B7E447B0268D566E97D896ECA5B1D258B9F547C92CB35939CDB2F5DDC29CE0BE5DC18BD8373B"]];
    var_0["_encstr_A7BA13F32073333FEB26FDCF3C51BB7AE768CA5B68"] = [[0, "_encstr_B6AB3258CDB4DA9B5636958D1D7B9C1D0BC463B2DCCBE6DBD823B456C9AF1D9316672B93DC2BBEEE164E83FA91DBEE73B88DB9B3"], [1, "_encstr_AA5533F31DC04806F76AB210AB80BBD593A5145D974F50117D20C13C888A3103E5170DF1951BBFB117F1FB31BECFB70C4845468B8D"]];
    var_0["_encstr_81E5133403D99507481F071978AFCD2277A7ED5B93"] = [[0, "_encstr_9296321637B4B66E95C659D847BD271D8531B156375ECDBD8D8C4BAC27BE47C90B3B594EDCB27D77164E38AFDBB3CA27171B9BB3"], [1, "_encstr_810F338AE84BCD5F21B1E51B558893538320E24298AF066F7B2BE419E7F05F1B0DC0CBDAF8AF7F7F3307E21890F833E77512023360"]];
    var_0["_encstr_ABA015238B2F9C8802EB5B37F72EF8672F52596BE2CF56"] = [[0, "_encstr_AAD734C2DC5AADB9B21BCAD81DDE9CD1B0983656CDBCCDDE1B192D56C9F51D3958B3B227CDCAAF772C93C1EB161B9CED6ECD8BC637CE"], [1, "_encstr_8F12355B230A2938CDB519D1DBBF48DDE28BC9EBFFB6E620F6CC20E88696E9156BEF656303DBBDC92F26EBC32141504E521FE76DEFA3FC"]];
    var_0["_encstr_95A717733089DEFA550EE711741BC3801620FBFB10030E6251"] = [[0, "_encstr_A7923685DC4BDA37ACD8561B3A7B39E88531B15937E5B9DEC6C84BCA93AF8EE416EC95E46EB2BEBB85C983BE2B1EE856C9730B8DE26CCDD9"], [1, "_encstr_819837713820BFDACB98A2DA400752139996F4EDCE80DF64C5583A72C06D41AB138F5665E6D30FA1BF2023DB494340E3A9EEC61971D06F7295"]];
  }

  return var_0;
}

init() {
  anim.animselectorfeaturetable = [];
  anim.animselectorfeaturetable["_encstr_B2980B28E72ED6E96274942B0B"] = ["_encstr_AFF60752796347C440", 0];
  anim.animselectorfeaturetable["_encstr_85590B3F4BBB71E85058B77CD3"] = ["_encstr_AFF60752796347C440", 1];
  anim.animselectorfeaturetable["_encstr_99341083FFBAF0681AF258B3DEFC611BA21F"] = ["_encstr_9A870CBAB0B0189E98DB118B91AB", 0];
  anim.animselectorfeaturetable["_encstr_9A7B10ADC2C3D716E4C94B9D0BD8AFBC0BEE"] = ["_encstr_9A870CBAB0B0189E98DB118B91AB", 1];
  anim.animselectorfeaturetable["_encstr_8AE90BB5B4DCEB1B95E69DD1D0"] = ["_encstr_AD3F073659733BE80D", 0];
  anim.animselectorfeaturetable["_encstr_95FF0B6B2CC3D76359DC76471A"] = ["_encstr_AD3F073659733BE80D", 1];
  anim.animselectorfeaturetable["_encstr_AD29106A7AF857E765AF23C6B3C79BE2803B"] = ["_encstr_A5890CE26B97CB31A067D3270B95", 0];
  anim.animselectorfeaturetable["_encstr_AAE510C8B2B817217BD78768B84FC83FE44B"] = ["_encstr_A5890CE26B97CB31A067D3270B95", 1];
  anim.animselectorfeaturetable["_encstr_9A760AB65AB9D7CD382B9546"] = ["_encstr_928A060723B255C8", 0];
  anim.animselectorfeaturetable["_encstr_AFB20AD60B0FEBE6E0CA2B32"] = ["_encstr_928A060723B255C8", 1];
  anim.animselector = [];
  var_0 = getanimselectorfilenames();

  foreach(var_13, var_2 in var_0) {
    foreach(var_12, var_4 in var_2) {
      anim.animselector[var_13][var_12] = spawnStruct();
      anim.animselector[var_13][var_12].aliases = [];
      anim.animselector[var_13][var_12].features = [];
      anim.animselector[var_13][var_12].values = [];
      var_5 = tablelookuprownum(var_4[1], 0, "_encstr_BECD0891E8C3A814BEA1");
      var_5 = var_5 - 1;

      for(var_6 = 0; var_6 < var_5; var_6++) {
        var_7 = tablelookupbyrow(var_4[1], var_6 + 1, 0);
        anim.animselector[var_13][var_12].aliases[var_6] = var_7;
      }

      var_8 = undefined;

      for(var_6 = 0; var_6 < 50; var_6++) {
        var_9 = tablelookupbyrow(var_4[1], 0, var_6 + 1);

        if(var_9 == "_encstr_BECD0891E8C3A814BEA1" || var_9 == "_encstr_B40101") {
          var_8 = var_6;
          break;
        } else
          anim.animselector[var_13][var_12].features[var_6] = var_9;
      }

      for(var_6 = 0; var_6 < var_5; var_6++) {
        for(var_10 = 0; var_10 < var_8; var_10++) {
          var_7 = anim.animselector[var_13][var_12].aliases[var_6];
          var_9 = anim.animselector[var_13][var_12].features[var_10];
          var_11 = tablelookupbyrow(var_4[1], var_6 + 1, var_10 + 1);

          if(var_11 == "_encstr_B40101")
            var_11 = undefined;
          else
            var_11 = float(var_11);

          anim.animselector[var_13][var_12].values[var_7][var_9] = var_11;
        }
      }
    }
  }
}

checkfeaturevalue(var_0, var_1, var_2) {
  var_3 = anim.animselectorfeaturetable[var_1][0];
  var_4 = anim.animselectorfeaturetable[var_1][1];
  var_5 = var_2[var_3];

  if(!isDefined(var_5))
    return 1;

  if(var_4 == 0)
    return var_5 >= var_0;
  else if(var_4 == 1)
    return var_5 <= var_0;
}

selectanim(var_0, var_1, var_2) {
  var_3 = anim.animselector[var_0][var_2];

  foreach(var_5 in var_3.aliases) {
    if(isai(self) && !scripts\asm\asm::asm_hasalias(var_0, var_5)) {
      continue;
    }
    var_6 = 1;

    foreach(var_8 in var_3.features) {
      var_9 = var_3.values[var_5][var_8];

      if(isDefined(var_9)) {
        if(!checkfeaturevalue(var_9, var_8, var_1)) {
          var_6 = 0;
          break;
        }
      }
    }

    if(var_6)
      return var_5;
  }
}

gettraverserindex() {
  var_0 = scripts\asm\shared\utility::getbasearchetype();

  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_ABCD0E9A57D976564E370BEA3A7D8D38":
      case "_encstr_88180F37B73632B42B277DC1B46E1DDED8":
      case "_encstr_9BAC0FCDF66319A5CA397D33AC6BC2C62B":
      case "_encstr_B4C10619C21B7F88":
      case "_encstr_A2660CE0F23A77467FD989FDB513":
      case "_encstr_ACF80B97CFB24530E51A66F982":
      case "_encstr_8DF306282FDA1969":
      case "_encstr_958C08CDDBD8325A959C":
      case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
        return 0;
      case "_encstr_81CD1036A5CEA5B12D2CB9D7332BB62C8DB2":
      case "_encstr_87B40A0D5674582EE9C7C1E1":
      case "_encstr_83E8094727E333E8F9CE50":
        return 1;
      default:
        if(isDefined(self.asm.archetype) && self.asm.archetype == "_encstr_BE4111D745743093B34A59E0D2735D7001AB59")
          return 2;

        if(isDefined(self.unittype) && self.unittype == "_encstr_958C08CDDBD8325A959C")
          return 0;

        return -1;
    }
  }

  return -1;
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gxp_hallucination.gsc
*************************************************/

init() {
  if(!getdvarint("_encstr_A94C10371B9CAF8993AFCE87C1BE6656B09C", 0)) {
    return;
  }
  level.disable_super_in_turret.setsuperisinuse = [];
  level.disable_super_in_turret.setspecialistbonus = [];
  level.disable_super_in_turret.setspecialistbonus[1] = [];
  level.disable_super_in_turret.setspecialistbonus[2] = [];
  level.disable_super_in_turret.setspecialistbonus[3] = [];
  level._effect["_encstr_8AF514B3CC0FBE9D3C0EAF33C6A5AC9BFA5B4BE6DB27"] = loadfx("_encstr_BA4633103BD8784BE380284EEA9EAF7925AFA8788F81E501CBFF3D40D2B6C5C188AF8850B30FE1D172E72EC01D8A2D28EAD288383B");
  level._effect["_encstr_9537148333830F2F0A015FC0F520B89B56C8769A301B"] = loadfx("_encstr_BD4C33CB61930EECBBB197B23D9A377FB1B923F269EBD6642863A5B69572BBDB6396EA3BD350BB5D205BCBBFD338C4378E2073227A");
  level._effect["_encstr_872513F3E51BD147D81BD95FD2D89B2979130B1F75"] = loadfx("_encstr_A2D832CECCE197A5DD83D79839E59DC26BCA3836585ECB0DBB5959E6C8E5B3333CAF3B0F38FACABC959BBEB55AB9F64E8BEC99E1");
  level._effect["_encstr_8767133B993CD7B3C3C1FA59F2B2E6BEAD5853DEE4"] = loadfx("_encstr_8CB53267CC87CB2DBBE0D7989379CE0BB6B20E1B85F2BC0DBBCA563719F2CECC87BE9D1EC1F5AC2F5937FAB6C29AF6275C9D9987");
  level._effect["_encstr_A99318FD7610F1B4E3FB1E4012177768ECDC476F273D18089733"] = loadfx("_encstr_84CF371347989A539B1247C5C3E6AC20551F5BE82EF1E29BB34F3BD5EACE6C40E87921E2126F38C0AB0703C3EB923641854C88983AF6B80CF3");
  level._effect["_encstr_9BD4180EB5B8A91FBB83614A48167F9B98099F73AF486EE3E83B"] = loadfx("_encstr_A15137A3F7080AC30B62375553561CB0A58FEB785E61520B23FF4B457A3EDC3058E9B172829F88B01B9793731B02A6B115FE98E8AA4628FC83");
  level._effect["_encstr_9130179DCCC3AFD9871CBED095C2A38C5A9B8E7DB52DE6BD39"] = loadfx("_encstr_A96D363B6F80824B73EAAFDDEBDE84483D0763F0D6D9CAF3AB67C3FDF2A654B8D011090A3A17283DA20BC9FB9F3B08B869B5B0C33586106B");
  level._effect["_encstr_AC7617DB5AE8EE3138231F3025CE0CC10FD0D437B3710B2D6D"] = loadfx("_encstr_88A436DB93BB87543BA3B696459FAA97D8B7B204B670EEFB74BF1AE0E6E55684F8A917F332A12AF2373D2C908FD3B168CA18724BC67BCAAB");
  level._effect["_encstr_A1431584273B0759C86B599B3FFDF0A95381F187BCE2E5"] = loadfx("_encstr_A7E134D39C6898CFC770E01DCEBF1F8BE3B28828C84F5840D84BABFBAA5FC33E4826CFD2B30F908AC5315D5B89E839EAAA8A9213AA7B");
  level._effect["_encstr_848515C3D52BE177C80B292A8048B40A060F17375DD87B"] = loadfx("_encstr_A1C734A3F1F817A294595F93F5908A918879DAAD8958AFEAEC8BBFAB9D48A3CE488697300311BB12C58183C75F011A0E484B5D3BB980");
  level._effect["_encstr_8B251613479819546B3347DBB7D2A88857DBBEC82CE6E096"] = loadfx("_encstr_993E356B38F9CDA713EBAF8AE63057E66B8893427893859BCBBD9D8EDE484BEFA9C16A7B5807CDCFC09074B7946EEF74DDA88396F0DDC0");
  level._effect["_encstr_A52F1693A82071174BEF1EC3C3FFAF659D10B179602375B6"] = loadfx("_encstr_8C0535EC33F097A5EE1C7D31395E3B585BACE03685F29786BBB2599B46799D991EFAB3C383BE47E42CD8ACE49BF5B5B49BF69CC5B366E1");
  level._effect["_encstr_ABEC162370B1E9A73A1777542E218FAF0D40396AA04D5DBB"] = loadfx("_encstr_9A4F350B6709365ACB776FA30DFF7A5ADD739BC87B8FC7C8CF1D80D05AC62B52DB8F71281B5E68904F8747B3409F709F482F1B153551D8");
  level._effect["_encstr_914D13D933C3FA3BA1BDB9E8F5232B0B1D437D990E"] = loadfx("_encstr_A712328B605A77CA8F7BB9EE46D7E2C1AD900B6BE0D23FA2D7FD3FE58EEFAB8E0AD9DFC3F8CBBC19D985069B9B6737409838230B");
  level._effect["_encstr_8DE31DCE661EFA3BE138F51B0D95E68EBEC4B1D5CA33969356D79156C21D1A"] = loadfx("_encstr_9ABD3CEBBF50529B43DAFF8D9BAED478EDD79320E6A99AC37BB7F38DA276A488A021F93A4A27808BB2C7D9E70B6A6D285604C31139447837FB53758D0353");
  level._effect["_encstr_B4691A2B91F2D73F7ABFD79A0AA50BD0BE5998ED1D3BF7AFA3954795"] = loadfx("_encstr_8BE239AB132AA817144B3F917A5E47CBC59760E9077AE0626BC740A045DE10CEAB2157E3C3CF5A18D33A6393A25DB4490F99138490BFCA20738688");
  level._effect["_encstr_83AB1A54E420D97780BB8706AAC880C5BB66A7B138B3577A6BE0F733"] = loadfx("_encstr_992E399DEBF3E030F78866D90287880F1A4F09218F8BB8432F3729503AFF5834A33FAF7163315670424AD3CB168D40FD4BD703CB939AA6A27EA77A");
  level._effect["_encstr_B14F153325DB118718DB191EF3B8CB2A363FC7C78D880B"] = loadfx("_encstr_83F93467CCC3CB2DDD83AF134EF276C2AD591CC60BE59743EE2B953719799D33E1AF76E1077D369CB01BAD6E7D5B2D73F6E417B33387");
  level._effect["_encstr_819615663C0277DFF17801DA701B166FDB08F5E942889B"] = loadfx("_encstr_873234BB11E35EBC5081A762ED6AC7AF81E953A2593B26B4781395664542CBEBB346BA6B0380DFEA900783638708D613505BA61369EB");
  level._effect["_encstr_8293183B6960FFEAAB71F737B3DF233030B077C2E6908132084D"] = loadfx("_encstr_96FE379DEBF3E030F78866D90287880F1A4F09218F8BB8432F3729503AFF5834A33FAF7163315120514B7048D59DB8E0AA0F05D7F38EA4E070");
  level._effect["_encstr_8C52183B99C3BECE0F38EBADB2C2E834B71B2BDCD76B0B9ADBE4"] = loadfx("_encstr_AD6537D68CB3F66AD7DA7F0D8D076F4EF3F81ADD7358725B18F15973DEB07BB6306FBF838B516B3FB7948CF051937230E2679A704368C34940");
  level._effect["_encstr_A230175D2B331880B8DA26BBC284F8C54B8FCD87FFCA58F8EA"] = loadfx("_encstr_853A3605736B78B88FF0EE418A0F108792C781A9070330F8A7BF51D8A267D04C1BC71709DBC9E683C4967B931F026171629B8F650A832488");
  level._effect["_encstr_8E7717C01268C79163F8202ED01B9929D38A7801DA46E5A893"] = loadfx("_encstr_8373369D33F079D2EE70BE4C4E79B358AD95C1B1B097CB3477CAACDC64973B6687FA9DE183EB9B838D161D3AACE4FAB6169AED395CB3660F");
  level._effect["_encstr_9A15179D9987F5CE0F38AF93C2B49B137BBB37F55B9637ED93"] = loadfx("_encstr_AA96363B661E794BBBE0F526E4E53BC26B5907C616BC7986BBCAACCD19BC67331ED79D0F83D727585ADC4CB7BBE6BE5BD2DCDB27E2EC3387");
  level._effect["_encstr_9B5617EC333CF5D91EC17DC9C2B4E64CDBBBB9EB5BC253BDE4"] = loadfx("_encstr_A31A36EC331EBC4BEE07BE989CCBEC58ADCA831B0BCBBC1ABB95B2CD19BC3B33C3FA76E138EB27B0D23713BD779BBE6B2C9AEDC9B83B990F");
  level._effect["_encstr_BA2D189D331EFAEC3C0EEBB193B2DC8D2BCD8ECDBEB65ADCEDE4"] = loadfx("_encstr_ACC03763B99177E02781414B033D914F4D30B12D2F59AFEB9BFB4F857FC8ACC4A006A9A24167984BBB26E81D354B9BA655B71615E0C0B51CAA");
  level._effect["_encstr_B2EC18E3B071A9E77A5737036EE18FEEE3684BCB11039E1B70BE"] = loadfx("_encstr_A60D37230B316F40688AEF060BF887211D2AF85360172A3040626BDE37FE53CA38FF60983B0F390AC3BA0B0D557132B7D9F75B1862B5B3D470");
  level._effect["_encstr_818E153B990F7D760F1CF5333616DAACE6AFAD5A73BD93"] = loadfx("_encstr_8F093478AAD08FF807D848DE8ABEE1DB7D62C0307228D7906FAD6DC022968BAD60698018FBC98DE80FDD654677E750750D2342D0F2D8");
  level._effect["_encstr_814C1563950390340BF349C6D0B092D57F912DE2DB57B2"] = loadfx("_encstr_A9C534B3CCE1E55A7770F5899CCBECC2DA95C16385E5F2A1BBB2ACDC23CBEC33E1EB9DC338FACCC6B05BCA9BF5AD2CA6ED9C1767CCC3");
  level._effect["_encstr_8BE119AB132AA62F936F3F3361DA47D1C7524F512FBEC17248EFF8"] = loadfx("_encstr_A55438CE333CBC4BEE0EAF89C9E5762C6BAC0EB158F2CB34BBB2B2DCC8973B33C3EB76C3E0F5EE5A76CEB159C9BE0CC4D76BD2CDDE9C8BD9CC0F");
  level._effect["_encstr_8E9B199E2528396FCBF3F17B38ACB72D68B53F40E369FD3FFA08DB"] = loadfx("_encstr_BDD1383B99F05E2DDD83FA319C79B30B6BB2C1B116CBCB34DDCACAE646CBB3990FBE3BF007D7EE96EC9D8D59E4D7C04CFADAB0A6B7C95CB399C3");
  level._effect["_encstr_823A162DA6A0410453AB4EF3933BCFE87C21F7E3418D78D6"] = loadfx("_encstr_A9CA35F57E086ABBD78716B9CB5E64C0E5D54149E1302273EF4AA920F706A4B07817E7F998113847EB2263E82BEFD170958F55DD268728");
  level._effect["_encstr_827C163BCC87BE76F0077DB91CB116CD86E5AF6BC29AF627"] = loadfx("_encstr_B4C2351BB23358801BF80775DA55A837CF3A53C02ACF804033BD0B75A2BDE80CC3F109CAA3FFE6B80D912F7101994847636A23F86B439B");
  level._effect["_encstr_84BD1E68BAC05F090B8058467CDBB1EBEC331858029D534602E940B14193B895"] = loadfx("_encstr_A2BC3D3BCC3C972DDD0ED74C39F29D2CB6590E36162F7943BB59CADC19CB9DCCC3EBB3E10EFADC8E4EAC585BBBB4CE76C6B2EB034CF5B61635BDE4C5D9663C");
  level._effect["_encstr_93FE1E4B18D9F1BF122F4F7BC5BB7F86077822D2A859372743B7476D53CD0F0A"] = loadfx("_encstr_88FC3D1E75602EB8036A57C206680F6A5269D3A062B916892F8B7FF0FE0675315A79AF31204F0B90336B9213F7A3AF6F71C9D7AF0306D773ADD26BE893AC49");
  level.disable_super_in_turret.setquestindexteamomnvar = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  tr_vis_radius_override_lod1();
  battle_tracks_settogglestate();
  team_revive_kbm_override();
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_8AF514B3CC0FBE9D3C0EAF33C6A5AC9BFA5B4BE6DB27", 1, 2.5), ::_id_119CA, "_encstr_B2E72DB0A75ACEE53BC1BC3BE20121F0A347A0C007DF609B8235AD4EBC2A731B11E748E163B4985B5B91A94355529D", _id_13244(0, 4, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_9537148333830F2F0A015FC0F520B89B56C8769A301B", 1, 2.5), ::_id_119CA, "_encstr_8BA62D33AAA3CF3AD009D77A83D7639BB6EB425B7D0798BFC4BCDB3F244289DBCB78CB3F9EF2C0077B26B3E3CA3A6A", _id_13244(0, 5, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_872513F3E51BD147D81BD95FD2D89B2979130B1F75", 1, 2.5), ::_id_119CA, "_encstr_A1B72CC367E321A0C87EE0A1A2D0B1AF2AFFD3594771148F1A82D7CF970897E56C8F7EAF68A2C337702592D2B003", _id_13244(0, 4, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_8767133B993CD7B3C3C1FA59F2B2E6BEAD5853DEE4", 1, 2.5), ::_id_119CA, "_encstr_A7712C9BD827AF3139F53BE107F591A5378589C6CAF5D058D8B157B196DC2C8E2D7B37FA95E559B97D6BB0A9ED9C", _id_13244(0, 5, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_A99318FD7610F1B4E3FB1E4012177768ECDC476F273D18089733", 1, 2.5), ::_id_119CA, "_encstr_B46A317B31B3D72B3B28A72BFBFF5B30BE1920ED1DBE999FA9152FB77B83DF8D8B4F88A7A8581377EB68E0E8709E0882E5F8ED", _id_13244(0, 3, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_9BD4180EB5B8A91FBB83614A48167F9B98099F73AF486EE3E83B", 1, 2.5), ::_id_119CA, "_encstr_822831E6867BE719223778F8F37791C333AED6E19F4171A114D3E028BF6EC9213A5558E075FA0FEBD5DFF050CF87AD43F2FDCE", _id_13244(0, 4, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_9130179DCCC3AFD9871CBED095C2A38C5A9B8E7DB52DE6BD39", 1, 2.5), ::_id_119CA, "_encstr_A9423017A7D350A6C8590413934ECDD4B3383BF08ACFD3B6408C53DA01FBA350847228FF53ED7F9BF8FB80451F47BB78286B", _id_13244(0, 3, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_AC7617DB5AE8EE3138231F3025CE0CC10FD0D437B3710B2D6D", 1, 2.5), ::_id_119CA, "_encstr_AB833093C99ED7362007A7B03121FF5746213AEA91E0C32EE879CDB33B7046EBE3987241D8459F23405BC3ACBF400E2B1893", _id_13244(0, 4, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_848515C3D52BE177C80B292A8048B40A060F17375DD87B", 1, 2.5), ::_id_119CA, "_encstr_96142E8BD186BF5E586FBF980909E7AFAE091282F9C8DBD6C061A58BD3686E83DB604A3983BAE74D1847979DCB30B553", _id_13244(0, 2.5, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_A1431584273B0759C86B599B3FFDF0A95381F187BCE2E5", 1, 2.5), ::_id_119CA, "_encstr_96D22EF258DEB781CE37877071A9B8FFA72750C1B777B0A729E128666798183988C7C517037FD5E34BD0C0A54958A043", _id_13244(0, 3, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_B4691A2B91F2D73F7ABFD79A0AA50BD0BE5998ED1D3BF7AFA3954795", 1, 2.5), ::_id_119CA, "_encstr_B40133E6B139EB4CC97DD9F00EBE915ACD164C8DCAAF34C263B1578D96CD8547967BB9EBD8DB9C07EA6EB1D563CADC7DB6D2CDBDC9", _id_13244(0, 3, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_83AB1A54E420D97780BB8706AAC880C5BB66A7B138B3577A6BE0F733", 1, 2.5), ::_id_119CA, "_encstr_8F4233033E8DE695DEE754C83248C3086F3A722185107CC190E94D699B72376957B25DEF02E5E0B7BFFE467B9D93871F19FEAD1833", _id_13244(0, 4, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_B14F153325DB118718DB191EF3B8CB2A363FC7C78D880B", 1, 2.5), ::_id_119CA, "_encstr_867D2EEEB62E90765B410F487789413C834711538F17BBE7B2095B2931061773478A5BA96770CB56DFAAC90F60FA40B3", _id_13244(0, 4, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_819615663C0277DFF17801DA701B166FDB08F5E942889B", 1, 2.5), ::_id_119CA, "_encstr_ACBF2EF3CE3307EE959112DBD0F727974BA76A94553E63F641E03B6270FD5E3BE018FE2FFE638F3E179B819A282D156B", _id_13244(0, 5, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_8293183B6960FFEAAB71F737B3DF233030B077C2E6908132084D", 1, 2.5), ::_id_119CA, "_encstr_9A4930338E7347AED5D1529B90B7E7578B67AAD4157E233681207B22B03D9E7BA0D83E6FB9414FBB5120F25A1963D4DBD83E", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_8C52183B99C3BECE0F38EBADB2C2E834B71B2BDCD76B0B9ADBE4", 1, 2.5), ::_id_119CA, "_encstr_820630104772201146FFCFE9218FF1334EE9AAB24D57F0812CC0F340C93AE3CC9718262F5A6F4EF97340D8CFC10723B0371A", _id_13244(0, 2, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_A230175D2B331880B8DA26BBC284F8C54B8FCD87FFCA58F8EA", 1, 2.5), ::_id_119CA, "_encstr_A3F1300B52ABF048CA0F87B148F923A3C7EAA1509AC793986504BBFF499DE0F51762B8BE03D3D9C0BBF493D55785F8B0E70B", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_8E7717C01268C79163F8202ED01B9929D38A7801DA46E5A893", 1, 2.5), ::_id_119CA, "_encstr_95B030DC36E4AF3127FAEC3C0EF591A5370B136395BE0DC28D8DBA8D4BE6588EA5F69B7D378336B047479527AFB685D4F6C9", _id_13244(0, 2, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_9A15179D9987F5CE0F38AF93C2B49B137BBB37F55B9637ED93", 1, 2.5), ::_id_119CA, "_encstr_B175300FD88B97EA357807F8D74742797320B3FB7086E88271898B36B3FD2A2C58E80BAF603951BA4510132AB093E2CE2068", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_9B5617EC333CF5D91EC17DC9C2B4E64CDBBBB9EB5BC253BDE4", 1, 2.5), ::_id_119CA, "_encstr_84343006A30B2E0D5221E020EB21C920D74906713D177053BD7A78F09285FBDBD7FF986082971885E6527068E91DB3D0778A", _id_13244(0, 2, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_BA2D189D331EFAEC3C0EEBB193B2DC8D2BCD8ECDBEB65ADCEDE4", 1, 2.5), ::_id_119CA, "_encstr_BA1B31835F0501917DD9DF9BD02FBAE848515EF362DFA286E08B73F60F60A8BCD0221510EE86E28BD1B90EAD9F81A3A070ED75", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_B2EC18E3B071A9E77A5737036EE18FEEE3684BCB11039E1B70BE", 1, 2.5), ::_id_119CA, "_encstr_A2D9316EC6C9AF89C9F5D91E38EB91D29BC2313659D71A2C631B5D36A5CD0BA3B4B773EBB193CAB98D2BDCD1DC7DD62C9ADE9C", _id_13244(0, 2, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_818E153B990F7D760F1CF5333616DAACE6AFAD5A73BD93", 1, 2.5), ::_id_119CA, "_encstr_994D2E1B30CDF1AB53B87770C71E7B8437C89262B83F74DFC8196D6353CD378BAB20DAE9C801EE27C1FE7F957B68C7D2", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_814C1563950390340BF349C6D0B092D57F912DE2DB57B2", 1, 2.5), ::_id_119CA, "_encstr_AB6E347F8E9B179E30E1C4DB01D90F108A62BD8C60F96331A58A4DB902D0A2C038678D411A65C343971F419DA2789AFBF115372A5026", _id_13244(0, 2, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_8BE119AB132AA62F936F3F3361DA47D1C7524F512FBEC17248EFF8", 1, 2.5), ::_id_119CA, "_encstr_ABD8320B51063FDED8EF3F188989672F2E89920279485B5640E1250B53E8EE035BE0CAB9833B2F0F98EB3A2FF94A39AFF3B852F3", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_8E9B199E2528396FCBF3F17B38ACB72D68B53F40E369FD3FFA08DB", 1, 2.5), ::_id_119CA, "_encstr_A9B03837C6C9AF134EAF3B871CBE915A37B0266356D70D16B1D857C696DCB03A5AB737D7DD5A3B9DB15939AF0389D7D6169AB7E4F5DA85D4DB93", _id_13244(0, 2, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_823A162DA6A0410453AB4EF3933BCFE87C21F7E3418D78D6", 1, 2.5), ::_id_119CA, "_encstr_AC322F9BAA021FE963EF0483B8AF513B2A1213406291894133F41576894339D9149AF851FBF2C91997E81B60958780A73A", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_827C163BCC87BE76F0077DB91CB116CD86E5AF6BC29AF627", 1, 2.5), ::_id_119CA, "_encstr_A2F12F8FE74BC0600AA969828AFF8803F357252997E113303C7DD3F9F4A6E8C58A8785C757BBE9085B545A769D9148F053", _id_13244(0, 2.5, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(2, 0.2, ::setspawninstances, _id_1327E("_encstr_93FE1E4B18D9F1BF122F4F7BC5BB7F86077822D2A859372743B7476D53CD0F0A", 1, 2.5), ::_id_119CA, "_encstr_92B937E68D93BEC44EEBD90F0EF5C8966EC2988D2BEB0D0BD8B1576CB4732C8EA5BD9B7D3747C9CAB0B677D23B761B95BE8162F56BD237BDC9", _id_13244(0, 2, "_encstr_BA1C08966F0D0150475B"));
  battle_tracks_setmusicstate(3, 0.3, ::setspawninstances, _id_1327E("_encstr_84BD1E68BAC05F090B8058467CDBB1EBEC331858029D534602E940B14193B895", 1, 2.5), ::_id_119CA, "_encstr_9BFF3727CF3A016D8A176F80E0374CBB3B61BAA835B738D670FA73065BA011C5DBC756F0FB535BD123B3B3E7BFC0A808C7038A01A85B50588B", _id_13244(0, 2.5, "_encstr_BEA00BC42D934F408D7390787F"));
  battle_tracks_setmusicstate(1, 0.1, ::setsoundsubmixfadetoblackamb, "_encstr_AC571BA2103FA7C7BBC009156E61F3E1F910CA3A401F9C0BB1BD193708", ::_id_119C9, "_encstr_AA8A278EEE138F615A5F20D0CB5F793BEB968E99C779A9493C8B881057B6914912BD70885EB325B114");
  battle_tracks_setmusicstate(1, 0.1, ::setsoundsubmixfadetoblackamb, "_encstr_A763201987BEC4270BFA4316C6ABEBD02C8D36EAD8D29B168EA5B7DCF5CEDEA58DB2", ::_id_119C9, "_encstr_A7762CA770232F529DD05F90AF1FEAD1ABD86B4328FE402A8951234E1B15F2743040E307D8918C539774ADC4763B");
  battle_tracks_setmusicstate(1, 0.1, ::setsoundsubmixfadetoblackamb, "_encstr_BE52201A802EAD82E1B9737BE9D231E82F70F968D8A9A06BE3022A96C9AB3F93AFA9", ::_id_119C9, "_encstr_91612C0BD64B511A4A375F7002816D5B8A6F1143A51644A9E0CB0B6E9155DF15192FA84F3BDEE19BB1FB086AC007");
  battle_tracks_setmusicstate(2, 0.2, ::setsuperexpended, 5, ::_id_119C8, "_encstr_99F7356E36C9D7139C7DCE871CBE8CD2B9C2131B56FA342CD88DAB36A5DC85472DF69BF5E63639165BC43695EB0DAE46D76B9532B42C73");
  battle_tracks_setmusicstate(3, 0.3, ::setsuperexpended, 15, ::_id_119C8, "_encstr_AA4834734EB3876E1511925B5077A717CB27EA14D5BEE376C160BBE2F07DDEBB60987EAF76C1433E9B08329A59A913B31E71F902804B");
  battle_tracks_setmusicstate(2, 0.2, ::setquestrewardtier, pavelow_boss_hit_by_emp(2, 0.7, 1.2, 40, 0), ::_id_119C5, "_encstr_BA5834B98D9CEB134ED79D8707AFC82DE68589362BBE4358B163BA36A5B92CA3D2F6737D3358B6CABE32165BB0D995F5D6598CB42C9B");
  battle_tracks_setmusicstate(3, 0.3, ::setquestrewardtier, pavelow_boss_hit_by_emp(5, 0.7, 1.5, 60, 0), ::_id_119C5, "_encstr_A7B333DFB71B90503A99B9527A2F5833A32775194711C30B4C2DE30924F6B8F57AB7F5F7F39A1AF8A70769C0CEA7C0B892F7750FCB");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(11, "_encstr_B6C60AE82CBEB3BDECF58113", 4.26, 1), ::_id_119C4, "_encstr_8EBF2437D84EF58927FAB33C1CAF46A537164CC6ACAFA185B1B1ABC6A5E60B8E2DF6DCAF0C89");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(12, "_encstr_A2C60AA358BEECDEB37D038C", 5.0, 1), ::_id_119C4, "_encstr_B8BF24530AF39820B277EFE960D1D85B2FC28938F2EF4B604D2CC3D79145C89D2F9A80C60F22");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(13, "_encstr_95C60A2BBFB96718A4E7906B", 5.0, 1), ::_id_119C4, "_encstr_ACBF24F3CE3307EE959112DBD0F727974BA76A94553E63F641E03B6270FD5E3BE018FE2F574B");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(14, "_encstr_84C60AA3E85F07671B60F8F4", 4.1, 1), ::_id_119C4, "_encstr_91BF24B9C69C7D3127D7B3E11CBEC8D26EB04CB159FAD0B0C6D8AB6CB473C21DA5F69BFA061A");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(15, "_encstr_8AC60A0CBB81A73FBC6697CF", 5.0, 1), ::_id_119C4, "_encstr_8FBF243B61366F8E889F4F48D9B957FFDE59A25209186B8690D1555B8318DE730B301AE93BC5");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(16, "_encstr_A6C60A1D2C7DCEBD3B7DC01B", 5.0, 1), ::_id_119C4, "_encstr_A3BF2443F642C9061B3F87A19B915D30FBCEE9389F87A84FD29BAB9FD76A17608925D0D652B6");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(17, "_encstr_B2C60AD391919790CB7F307F", 5.0, 1), ::_id_119C4, "_encstr_93BF247B21762FCEC8DF0F089979973F1E99E2124958AB465091151B43D89E334BF0DAA97B04");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(18, "_encstr_AFC60A2B41C0EFADC83FB8A8", 5.0, 1), ::_id_119C4, "_encstr_AABF24C862CAE711AB37DC4BF0F7197372AAD8B8BA29C1098B3CDDCEF10BE1015CD2309987A8");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(19, "_encstr_9AC60A8121B0FF1703290362", 5.06, 1), ::_id_119C4, "_encstr_81BF24DE0BA386B5EA89B848934961980FB1EED9656F28FB55A2D0883A5D2373BF5760D8A85E");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(20, "_encstr_A9C60AF179C128B8D3F1DBF3", 5.01, 1), ::_id_119C4, "_encstr_88BF24EBD93B071E58865070A17673A157DA0E939DA7C1E641A8670F2A48DAA36A673219F36A");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(21, "_encstr_8CC60ABCA757CA85D43129F1", 3.11, 1), ::_id_119C4, "_encstr_81BF24DE0BA386B5EA89B848934961980FB1EED9656F28FB55A2D0883A5D2373BF5760D8A97E");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(22, "_encstr_B1C60AD5918F192763F18282", 5.01, 1), ::_id_119C4, "_encstr_AABF24C862CAE711AB37DC4BF0F7197372AAD8B8BA29C1098B3CDDCEF10BE1015CD23099972A");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(23, "_encstr_BAC60A30A6214ACAB039320B", 3.23, 1), ::_id_119C4, "_encstr_97BF24B93693D7899C7DD90F83F5325A3785988D2BF534C2361BAE1B96DC2CD15AB737AF1399");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(24, "_encstr_8DC60A69E1A940C0AB9943DB", 5.16, 1), ::_id_119C4, "_encstr_82BF248B3E9A11DED387CFF9D3E91578331611E027CFE0070A5313D78FA2EFD8F16D181E5A0C");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(25, "_encstr_A5C60AC139B9172703276375", 5.19, 1), ::_id_119C4, "_encstr_BDBF243736C9F5C4277DEC1E0EEB324B9B2C89B159FAD00BD88DBA6C96CD58475ADE9BBE13A9");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(26, "_encstr_9AC60A8121B0FF1703292383", 5.24, 1), ::_id_119C4, "_encstr_87BF24F347105103B67EEA23A3185394402B9A64D3D124D751F0C39AE8E87F0B788F1ECFD362");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(27, "_encstr_AFC60A2B41C0EFADC83FB9A7", 5.02, 1), ::_id_119C4, "_encstr_96BF24ABF20B10A82AEF6751E859A0C3A74A01B07A6733F8C5A45B5FE9FD4015B702185E87AE");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(28, "_encstr_83C60AFB620FDC10FB3F3B21", 2.39, 1), ::_id_119C4, "_encstr_B2BF24309A320FF9739F74F3A89F612BDA0230501281B95123C4056699B309A9048AE841CFF0");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(29, "_encstr_9BC60A833F61ACF0A35E02E3", 4.6, 1), ::_id_119C4, "_encstr_A6BF244E977E81D2EB110F18A37E09580F4959DDEB0160FB9974F3C6C1E8BF8C33185009EFAA");
  battle_tracks_setmusicstate(2, 0.2, ::setradarparamsonlatejoiner, _id_13233(30, "_encstr_96C60AD3DBA03FCF33A9A2BF", 5.2, 1), ::_id_119C4, "_encstr_85BF245B708DB1EB13F8373007DEBB44F708D222F87FB41F08592D2393C077CB6BE09AA9AA79");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(31, "_encstr_87C60A1B0B68B2AF085E22EA", 6.2, 1), ::_id_119C4, "_encstr_ADBF2420CB937FE2C297E19AA30151AA43373A10DD2928BF682D7FFFD8A501C1F3DF7DBF6B77");
  battle_tracks_setmusicstate(3, 0.3, ::setradarparamsonlatejoiner, _id_13233(32, "_encstr_BDC60A553699A7881627C2DA", 6.2, 1), ::_id_119C4, "_encstr_84BF2440EA425FA923AF44C3786F91FBEA5240632251498173B455B649837999D45AB8112FA2");
  _id_13381();
}

tr_vis_radius_override_lod1() {
  level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup = getdvarint("_encstr_97A81BFF760E87CDADE6B0A922DF1D5B13E141D4CC43E0A361F1526B48", 10000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.illumination_flare_init = getdvarint("_encstr_8D7720A3DFF2894C0237726680F092E36B880E30DE08B1A8E65BA98BFB487821F5AF", 5000);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_126E5 = getdvarint("_encstr_A35A1B8F8706C95E1801BAC91B686163553DB76365AB710250C9744B93", 1000);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_126E4 = getdvarint("_encstr_9765240BBFE8A91B35A1B369AB993F98F805AF76DDE0E1F76E1BDA8373653BD940AF37E57BB8", 30000);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_126E3 = getdvarint("_encstr_8E65243798D3A86C9FC2B32EA33C629383FAA76C27F0EFA0BA87E726135A5B1ECDCA490B67C8", 90000);
}

battle_tracks_settogglestate() {
  var_0 = (1, 0, 0);
  var_1 = (1, 1, 0);
  var_2 = (0, 1, 0);
  var_3 = getdvarfloat("_encstr_BA601CEB26DBEF944BE0BA2370B3CDCFB39B4F7E5063139C7FA0D24BA95F", 0.75);
  var_4 = getdvarfloat("_encstr_B67413EE3B93B6AD3F7AE081C3D453EB7E9FF56F83", 25);
  var_5 = getdvarfloat("_encstr_82741337E0B35F62C3BF8AC91DE36A3A3399A307B8", 15);
  var_6 = getdvarfloat("_encstr_852A12FB43FB572A35104E7F5B77058A1788E03C", 5);
  var_7 = getdvarfloat("_encstr_962A129B364EBE66CAC29CF58E5A2B9C997DB937", 0.0);
  var_8 = getdvarfloat("_encstr_A22A12E61B4EF533AC0B93EBA3B4B24E66FADCB2", 0.0);
  var_9 = getdvarfloat("_encstr_8D9714A686034135B57ED307C969089B377E2D820E4A", 0.0);
  var_10 = getdvarfloat("_encstr_92971437B139AFCC95169CD747A5569CCCAFB596E6CA", 0.0);
  var_11 = getdvarfloat("_encstr_A29714CB508E672AFF0123792B0AFF43175F5DDFB3BB", 0.1);
  var_12 = getdvarfloat("_encstr_92971437B139AFCC95169CD747A5569CCCAFB55646CA", 0.1);
  var_13 = getdvarfloat("_encstr_A697141B42BBC0583F01BDEF3C64181ED6F950C17A07", 0.9);
  var_14 = getdvarfloat("_encstr_AF9714961B1B272565DA93D92942991E62774DD7345D", 0.9);
  _id_1324A(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_0);
  var_3 = getdvarfloat("_encstr_B1601C97FF53D838E19D8D3B46C1C00F8B7F3725775B16083FB729D361E2", 0.5);
  var_4 = getdvarfloat("_encstr_844813DCC639F533ACB027AFE84B594EC8EBA30BE6", 30);
  var_5 = getdvarfloat("_encstr_A7481363D780C183AD090BC1B3F3C7C2FAC7FCF963", 20);
  var_6 = getdvarfloat("_encstr_B13012B3768B9F69C7E88BD97329BF6ACA7F8843", 5);
  var_7 = getdvarfloat("_encstr_873012EBB1E69F7FC0338A5FE15847E32EAEB253", 0.2);
  var_8 = getdvarfloat("_encstr_A930120E4B1AEE55D03FADE9ECA052EA9A61E07D", 0.2);
  var_9 = getdvarfloat("_encstr_84301406A30B2E0597C24819ABACCB43D27781F336A7", 0.2);
  var_10 = getdvarfloat("_encstr_A53014F3D8256923191FDAFFADA017EA0DA19AAA58D3", 0.2);
  var_11 = getdvarfloat("_encstr_853014C8DF22A68512660E803B8ADB4BCA97B0E02BDB", 0.6);
  var_12 = getdvarfloat("_encstr_993014BFD77BF0500D363B969BF9B09E97BF0B2B6352", 0.6);
  var_13 = getdvarfloat("_encstr_923014878F7EB1261019B2F193586DDBF65F67476526", 0.2);
  var_14 = getdvarfloat("_encstr_8C3014B96CE4D79956B0C9AFE82DB29C19AFDA0B4DAC", 0.2);
  _id_1324A(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_0);
  var_3 = getdvarfloat("_encstr_A2601C363AF3570ACFC98A5BA68B0A88B449FF30D0515214C4103D7B0FDA", 0.0);
  var_4 = getdvarfloat("_encstr_966513DB16EBDF075398AB71D8A33F936B904441B6", 40);
  var_5 = getdvarfloat("_encstr_A56513E68D93D7CC561627F5D1D22B4EC4EBA30BAC", 30);
  var_6 = getdvarfloat("_encstr_813A12635FA3BF346381B5B111F19008E31EF31B", 10);
  var_7 = getdvarfloat("_encstr_8E3A12F77392F13497EABB06A37F7D50FAF7456F", 0.4);
  var_8 = getdvarfloat("_encstr_863A12AFC76BE0603D062B866BE9A0AEB7CF1D1B", 0.4);
  var_9 = getdvarfloat("_encstr_8A4214F8F69877FA4D419B69B3571F4AAEF015C7F8F7", 0.8);
  var_10 = getdvarfloat("_encstr_824214B2BE0597C89D51EA5794211B22FA79A00340A7", 0.8);
  var_11 = getdvarfloat("_encstr_884114A00AA2FF89DF316EF01CD7D16DDA51D8E8923A", 0.2);
  var_12 = getdvarfloat("_encstr_B64114D6B64BD7A905DFC0B1935181C507D14155CF92", 0.2);
  var_13 = getdvarfloat("_encstr_8E411437C69CFA99B2C2E4AFE8A5ACC9137DB50B9A37", 0.0);
  var_14 = getdvarfloat("_encstr_9A4114777F8E41D68089024103C81D4BC7EFF7B7F5BD", 0.0);
  _id_1324A(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_0);
}

team_revive_kbm_override() {}

onplayerconnect(var_0) {
  var_0.sales_discount_items = [];

  foreach(var_3, var_2 in level.disable_super_in_turret.setspecialistbonus) {
    if(var_2.size)
      var_0.sales_discount_items[var_3] = randomint(var_2.size);
  }
}

onplayerspawned() {
  if(!level.disable_super_in_turret.placementstatsset) {
    return;
  }
  has_target_player();
}

_id_1324A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = spawnStruct();
  var_13._id_13DB4 = var_0;
  var_13.time = (var_1, var_2, var_3);
  var_13.initlootvaultkeypad = 0.0;
  var_14 = 1.0 - var_4;
  var_15 = 1.0 - var_5;
  var_13.setpostgamestate = [];
  var_13.setpostgamestate[0] = (var_4, var_5, 0);
  var_13.setpostgamestate[1] = (var_6 * var_14, var_7 * var_15, 0);
  var_13.setpostgamestate[2] = (var_8 * var_14, var_9 * var_15, 0);
  var_13.setpostgamestate[3] = (var_10 * var_14, var_11 * var_15, 0);
  var_13.left_control = var_12;
  level.disable_super_in_turret.setsuperisinuse[level.disable_super_in_turret.setsuperisinuse.size] = var_13;
}

freight_lift_attacker_internal() {
  foreach(var_1 in level.disable_super_in_turret.setsuperisinuse)
  var_1.initlootvaultkeypad = randomfloatrange(-1 * var_1.time[2], var_1.time[2]);
}

remove_fake_guy_from_list(var_0) {
  foreach(var_3, var_2 in level.disable_super_in_turret.setsuperisinuse) {
    if(var_2._id_13DB4 <= var_0)
      return var_3;
  }

  return 0;
}

run_hotjoin_loadout_thread() {
  var_0 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks]._id_13DB4;
  var_1 = 1.0;

  if(self.setchainkillstreaks > 0)
    var_1 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks - 1]._id_13DB4;

  var_2 = (self.setcachedclientomnvar - var_0) / (var_1 - var_0);
  return var_2;
}

_id_13233(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.length = var_2;
  var_5.cinematic = var_1;
  var_5.moveeffect = var_3;
  var_5.index = var_0;
  var_5._id_1276E = var_4;
  return var_5;
}

_id_1327E(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.fx = var_0;
  var_3._id_1276E = var_1;
  var_3.length = var_2;
  return var_3;
}

_id_13244(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.watchspawnwallplayerexit = var_0;
  var_3.length = var_1;
  var_3.type = var_2;
  return var_3;
}

battle_tracks_setmusicstate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getdvarint(var_5, 0)) {
    return;
  }
  var_7 = spawnStruct();
  var_7.pity_timer_end_time = var_1;
  var_7.function = var_2;
  var_7._id_119AB = var_4;
  var_7.data = var_3;
  var_7.playerplunderlosecallback = var_6;
  level.disable_super_in_turret.setspecialistbonus[var_0][level.disable_super_in_turret.setspecialistbonus[var_0].size] = var_7;
}

_id_13381() {
  foreach(var_2, var_1 in level.disable_super_in_turret.setspecialistbonus)
  level.disable_super_in_turret.setspecialistbonus[var_2] = scripts\engine\utility::array_randomize(var_1);
}

_id_12348(var_0) {
  var_1 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks];
  var_2 = randomfloat(1);
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_5 < 4; var_5++) {
    if(var_5 > 0 && level.disable_super_in_turret.setspecialistbonus[var_5].size)
      var_4 = var_5;

    var_3 = var_3 + scripts\engine\math::lerp(var_1.setpostgamestate[var_5][0], var_1.setpostgamestate[var_5][1], var_0);

    if(var_3 >= var_2)
      return var_4;
  }
}

_id_12347(var_0) {
  var_1 = undefined;

  if(isDefined(self.sales_discount_items[var_0])) {
    var_1 = self.sales_discount_items[var_0] % level.disable_super_in_turret.setspecialistbonus[var_0].size;
    self.sales_discount_items[var_0]++;
  }

  return var_1;
}

update(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(self.setbuybackpingmessage)) {
    return;
  }
  self.setcachedclientomnvar = var_0;
  self.setchainkillstreaks = remove_fake_guy_from_list(var_0);
  var_1 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks];
  var_2 = run_hotjoin_loadout_thread();
  var_3 = (scripts\engine\math::lerp(var_1.time[0], var_1.time[1], var_2) + var_1.initlootvaultkeypad) * 1000;

  if(self.setcachedgameomnvar + var_3 < gettime()) {
    var_4 = _id_12348(var_2);

    if(var_4 != 0) {
      self.setbuybackpingmessage = 1;
      var_5 = _id_12347(var_4);

      if(isDefined(var_5)) {
        var_0 = level.disable_super_in_turret.setspecialistbonus[var_4][var_5];
        _id_13FDB(var_0.playerplunderlosecallback);
        [[var_0.function]](var_0.data);
        _encstr_AC0D253F1BCB213B094F2208F01837D7FD19A3FB8377AAF0DA25FFEC53E8594728B82BB55486EA::placementupdatewait("_encstr_B47D143D35296AB7506FC82C37FC28F706E0E8D76DA5", var_0);
      }
    } else {}

    self.setbuybackpingmessage = 0;
    self.setcachedgameomnvar = gettime();
    freight_lift_attacker_internal();
  }
}

_id_13FDB(var_0) {
  if(getdvarint("_encstr_9BC9249F3708B0A864DB804EB21D777B71FB88036A4AF6DFC3081FAB39BB68DDF8D0E0EBF3F4", 0)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  self lerpfovbypreset("_encstr_83570ED08563C6AE6C96B9851DD27BB9");

  if(var_0.type == "_encstr_BA1C08966F0D0150475B")
    self visionsetnakedforplayer("_encstr_9A8F0FB5C1BE761E38EB997B3BBE36DBBB", 1);
  else
    self visionsetnakedforplayer("_encstr_A25312E7B1E03A30C0D6AFF5EBE17D52C53B0F7F", 1);

  thread mp_runner_patch(var_0.length);
  thread has_access_card();

  if(isDefined(var_0.watchspawnwallplayerexit) && var_0.watchspawnwallplayerexit > 0)
    wait(var_0.watchspawnwallplayerexit);
}

has_target_player() {
  self.setcachedgameomnvar = gettime();
  self.setcachedclientomnvar = 0;
  self.setchainkillstreaks = 0;
  self.setbuybackpingmessage = 0;
}

setsoundsubmixfadetoblackamb(var_0) {
  self playsoundtoplayer(var_0, self, self);
  wait 3;
}

setquestrewardtierteamomnvar(var_0) {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(var_0, self, 1);
  wait 3;
}

setroundwinstreakspecialcamos(var_0) {
  self setplayermusicstate(var_0);
  wait 3;
}

setradarparamsonlatejoiner(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(var_0._id_1276E))
    _id_12739();

  self setclientomnvar("_encstr_8F2D13BAD2D71A163636B7BBCACADCAF563B56373A", var_0.index);
  var_1 = 3;
  wait(var_0.length);
}

setspawninstances(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(var_0._id_1276E))
    _id_12739();

  playfxontagforclients(scripts\engine\utility::getfx(var_0.fx), self, "_encstr_A130084D2FDAD8AA8F62", self);
  wait(var_0.length);
}

setsuperexpended(var_0) {
  scripts\cp_mp\emp_debuff::play_emp_scramble(5);
  thread has_module_met_max_vehicles();
  never_kill_off_old(var_0);
}

never_kill_off_old(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_0);
  self notify("_encstr_A95611597391EBDC1B2785D689D859FA43BA19");
  scripts\cp_mp\emp_debuff::stop_emp_scramble(5);
}

has_module_met_max_vehicles() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A95611597391EBDC1B2785D689D859FA43BA19");
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp_mp\emp_debuff::stop_emp_scramble(5);
}

setreduceregendelayonkill(var_0) {
  var_1 = rungwperif_largeexplosions(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = relic_healthpacks_globalfunc(var_1.origin);

  if(!isDefined(var_2)) {
    return;
  }
  playfxontagforclients(level._effect["_encstr_914D13D933C3FA3BA1BDB9E8F5232B0B1D437D990E"], var_1, "_encstr_813B0D4027B390B37585BBC819FD28", var_2);
  var_2 _id_119C2("_encstr_914D13D933C3FA3BA1BDB9E8F5232B0B1D437D990E", "_encstr_8F7B0A462DD311838D3BE810");
}

rungwperif_largeexplosions(var_0) {
  var_1 = gettime();
  var_2 = var_1 + 250;

  for(var_3 = undefined; isDefined(var_0) && var_1 < var_2; var_1 = gettime()) {
    var_3 = var_0 getcorpseentity();

    if(isDefined(var_3))
      return var_3;

    waitframe();
  }

  return undefined;
}

relic_healthpacks_globalfunc(var_0) {
  var_1 = level.disable_super_in_turret.setpreviewuicircle;

  if(isDefined(var_1) && var_1 _encstr_AC0D253F1BCB213B094F2208F01837D7FD19A3FB8377AAF0DA25FFEC53E8594728B82BB55486EA::get_ai_hearing_bomb_plant_sound() && level.disable_super_in_turret.setquestindexomnvar < gettime()) {
    if(distance2dsquared(var_0, var_1.origin) > level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup * level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup)
      return undefined;

    var_2 = anglesToForward(var_1.angles);
    var_3 = vectorNormalize(var_0 - var_1.origin);

    if(vectordot(var_2, var_3) <= 0)
      return undefined;

    return var_1;
  }

  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53"))
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53")]](var_0, level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup);

  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_1 in var_4) {
    if(!isalive(var_1) || var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() || !var_1 _encstr_AC0D253F1BCB213B094F2208F01837D7FD19A3FB8377AAF0DA25FFEC53E8594728B82BB55486EA::get_ai_hearing_bomb_plant_sound()) {
      continue;
    }
    var_2 = anglesToForward(var_1.angles);
    var_3 = vectorNormalize(var_0 - var_1.origin);

    if(vectordot(var_2, var_3) <= 0) {
      continue;
    }
    level.disable_super_in_turret.setpreviewuicircle = var_1;
    level.disable_super_in_turret.setquestindexomnvar = gettime() + level.disable_super_in_turret.play_3p_anim_non_animscene.illumination_flare_init;
    return var_1;
  }

  return undefined;
}

_id_11E33() {
  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(level.players);

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || !isalive(var_2) || var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() || !var_2 _encstr_AC0D253F1BCB213B094F2208F01837D7FD19A3FB8377AAF0DA25FFEC53E8594728B82BB55486EA::get_ai_hearing_bomb_plant_sound()) {
        continue;
      }
      if(isDefined(var_2.setreduceregendelayonkills) && var_2.setreduceregendelayonkills > gettime()) {
        continue;
      }
      var_3 = reset_current_step_count(var_2, level.disable_super_in_turret.play_3p_anim_non_animscene._id_126E5);

      if(isDefined(var_3)) {
        playfxontagforclients(level._effect["_encstr_8DE31DCE661EFA3BE138F51B0D95E68EBEC4B1D5CA33969356D79156C21D1A"], var_3, "_encstr_813B0D4027B390B37585BBC819FD28", var_2);
        var_2.setreduceregendelayonkills = gettime() + randomintrange(level.disable_super_in_turret.play_3p_anim_non_animscene._id_126E4, level.disable_super_in_turret.play_3p_anim_non_animscene._id_126E3);
        var_2 _id_119C2("_encstr_8DE31DCE661EFA3BE138F51B0D95E68EBEC4B1D5CA33969356D79156C21D1A", "_encstr_8599101259473366C8E97C79D32BAA9B7C52");
      }

      waitframe();
    }

    waitframe();
  }
}

setquestrewardtier(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = gettime() + var_0.module_set_goal_height * 1000;
  var_2 = randomfloat(360);
  var_3 = 3000;

  while(var_1 > gettime()) {
    if(randomfloat(1) < var_0._id_145BE)
      self playsoundtoplayer("_encstr_B40101", self);
    else {
      var_4 = angleclamp(var_2 + randomfloat(var_0.building_magic_grenades));
      var_5 = cos(var_4);
      var_6 = sin(var_4);
      var_7 = (var_5, var_6, 0);
      var_8 = self getEye();
      var_9 = var_8 + var_7 * var_3;
      self playsoundtoplayer("_encstr_B19A1DC007BC400383690E19FE5A496E1EDB70D09B779BDFCB0A080892B2BD", self);
      self.donotmodifydamage = 1;
      self dodamage(1, var_9, level.disable_super_in_turret.setquestindexteamomnvar);
      self.donotmodifydamage = undefined;
    }

    wait(randomfloatrange(var_0.trial_race_lap_total_override, var_0.trial_target_requisites));
  }
}

pavelow_boss_hit_by_emp(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.module_set_goal_height = var_0;
  var_5.trial_race_lap_total_override = var_1;
  var_5.trial_target_requisites = var_2;
  var_5.building_magic_grenades = var_3;
  var_5._id_145BE = var_4;
  return var_5;
}

reset_current_step_count(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53"))
    var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53")]](var_0.origin, var_1);

  var_3 = scripts\engine\utility::array_randomize(var_3);

  foreach(var_5 in var_3) {
    if(var_5 == var_0 || var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() || !isalive(var_5)) {
      continue;
    }
    var_6 = vectorNormalize(var_5.origin - var_0.origin);

    if(vectordot(var_2, var_6) <= 0) {
      continue;
    }
    return var_5;
  }

  return undefined;
}

setquestrewardtieromnvar(var_0) {
  self lerpfovbypreset("_encstr_83570ED08563C6AE6C96B9851DD27BB9");
  self visionsetnakedforplayer("_encstr_82A411402BF9FF3AFB1F74F82E1F03A9DCF2A3", 1);
  thread has_access_card();
  mp_runner_patch(var_0);
}

mp_runner_patch(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_0);
  self notify("_encstr_955E0C62F80547A738A50F308B48");
  self lerpfovbypreset("_encstr_8B760DB96F5E3085829BEF95E75B4D");
  self visionsetnakedforplayer("_encstr_B40101", 2);
}

has_access_card() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_955E0C62F80547A738A50F308B48");
  self waittill("_encstr_AD75063D571AE108");
  self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
  self visionsetnakedforplayer("_encstr_B40101", 0);
}

_id_12739() {
  self playsoundtoplayer("_encstr_9A0F1B58D6B91F87A3EE5B83B061B549FB304ECD22EFC027667CE89887", self, self);
  wait 0.1;
}

_id_119C2(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = "_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1";
  var_2[var_2.size] = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2[var_2.size] = "_encstr_81EF05D197C12B";
  var_2[var_2.size] = var_1;
  var_2[var_2.size] = "_encstr_84BA05A8CA852B";
  var_2[var_2.size] = var_0;
  self dlog_recordplayerevent("_encstr_85891C713A474409B79E2B05A411A896DF12A9F8A2878E608D610103D705", var_2);
}

_id_119C3(var_0) {
  _id_119C2(var_0, "_encstr_8B3E0A7BF540EFEB42662DB3");
}

_id_119C9(var_0) {
  _id_119C2(var_0, "_encstr_8260069BDBBACD46");
}

_id_119C7(var_0) {
  _id_119C2(var_0, "_encstr_813F06832D8A18FE");
}

_id_119C4(var_0) {
  _id_119C2(var_0.cinematic, "_encstr_86EE0A2F73A8CAF59803DCA6");
}

_id_119CA(var_0) {
  _id_119C2(var_0, "_encstr_96190434978B");
}

_id_119C8(var_0) {
  _id_119C2(var_0, "_encstr_BAED0C4E9B33D1DB9ECA38587337");
}

_id_119C5(var_0) {
  _id_119C2(var_0.module_set_goal_height, "_encstr_AF6B0B866FB04FCF13A0D2CA98");
}

_id_119C6(var_0) {
  _id_119C2(var_0, "_encstr_A918040DAF23");
}

level_ammo_crate_spawn() {
  if(self.setcachedclientomnvar == 0.0)
    return (1, 1, 1);

  return level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks].left_control;
}
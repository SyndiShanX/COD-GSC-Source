/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_728ffcee8cbf30ee.gsc
***********************************************/

_id_FB7271D5EE18B98D(data) {
  if(level.mapname == "mp_br_mechanics")
    _id_E79057A53754525C();

  if(!getdvarint("dvar_74ABB928AB13113B", 0)) {
    data.enabled = 0;
    return;
  }

  level._id_C83AA9DBC3654AFA = spawnStruct();
  level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D = spawnStruct();
  level._effect["arrow_nuke_screen"] = loadfx("vfx/iw9_br/gameplay/vfx_champ_nuke_screen_flash");
  level._effect["arrow_plutonium_far"] = loadfx("vfx/iw9_br/gameplay/vfx_champ_plutonium_screen_effect_far");
  level._effect["arrow_plutonium_close"] = loadfx("vfx/iw9_br/gameplay/vfx_champ_plutonium_screen_effect_close");
  _id_797F8EE99632DBC2();
  _id_2C472B5AF1A9287D();
  _id_D91C1A6B28AE8EA3();
  _id_D44853CEBE3E6D36();
  data.funcs["onInit"] = ::_id_B31F7AF7E23417B0;
  data.funcs["onTeamAssigned"] = ::_id_401F74A7D8648053;
  data.funcs["onEnterGulag"] = ::_id_53378EBC66BE211C;
  data.funcs["onGlobalPlayerEnterGulag"] = ::_id_4C82D5D35830EA32;
  data.funcs["onPlayerRespawn"] = ::_id_DCF3929E77FE1DE9;
  data.funcs["onGlobalPlayerRespawn"] = ::_id_E1E06922C2539044;
  data.funcs["onTabletHidden"] = ::_id_AEE1FF3149365FA6;
  level._id_947925F5FC6939A3 = ::_id_5908E524F32EB629;
  level._id_2C6B8985DB118349 = ::_id_3E22F1EDF43325C1;
  _id_7E52B56769FA7774::_id_C3E1679F348A5E40(::_id_33577EBB4253A4F9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("eliteArrow", "arrow_nepShockEffectToggle", ::_id_78B078214CBC140D);
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_112636A06B12393B);
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_A4FC9A04B674A389);
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_4F13C26FCEBE3FF8);

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_5FB0D01B9AF82AC3) {
    if(isDefined(_id_F7806D4CF24AACD3._id_BC4A2F35F7DFF533)) {
      _id_8C50F5B7B81E6E06 = getscriptbundle("elitebrokenarrowelement:" + _id_F7806D4CF24AACD3._id_BC4A2F35F7DFF533);

      if(isDefined(_id_8C50F5B7B81E6E06._id_A782B3BC8550816D))
        scripts\cp_mp\utility\script_utility::registersharedfunc(_id_8C50F5B7B81E6E06._id_A782B3BC8550816D, "delete", ::_id_28ECFD94DDA4D7FD);
    }
  }

  thread _id_4FB72C0C86F7746F();
  thread _id_722929515E5A34B9();
  thread _id_3797FC27DA5395C1();
}

_id_2C472B5AF1A9287D() {
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5 = spawnStruct();
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.enabled = getdvarint("dvar_74ABB928AB13113B", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F5EFF9E11A2D9B7E = issubstr(getDvar("loot_table_filter", ""), "brloot_champion_tablet");
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_5159F960A67ED33B = getdvarint("dvar_CDA1DD0709C4D180", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_60EA877E814EE1A8 = getdvarfloat("dvar_E943BD1371A994C1", 50.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_91B307624076699A = getdvarint("dvar_75AC11DBFA57F324", 3);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB = getdvarint("dvar_30D49880D50137EE", 4);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_336CBBA00B3C960C = getdvarint("dvar_531A7F3580EA315F", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE = getdvarint("dvar_764D7336D782F134", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_85EE4754325BC510 = getdvarint("dvar_950C20A5C594B232", level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_91B307624076699A);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.maxteamsize = getdvarint("dvar_6C12989A0A4FF9A2", 4);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C2C0C51679AA5A4F = getdvarfloat("dvar_31CC8AEBA0A944BE", 30.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DB411D3DF4599406 = getdvarint("dvar_DCFFAF5C214172DD", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29258DCC063EEC7F = getdvarint("dvar_2F036784E7EC2C72", 18);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8A0E0D62D99BEF57 = getdvarint("dvar_83550AC54C009FB2", 15000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A076A7284AA6E915 = getdvarint("dvar_10264A6F662CA430", 7500);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_66F01753408E68A6 = getdvarint("dvar_DF243DF1AAA96E57", 40000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_702EE9172F969DE8 = getdvarint("dvar_0B114889265A1179", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7846374C36699FD8 = getdvarint("dvar_D96AD4B9762BA0BB", 210);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BCDE724251CE0168 = getdvarfloat("dvar_DDFDCD24993014CF", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BD1B7C4252108828 = getdvarfloat("dvar_DDE2AF24991176CB", 40.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BCE042BDEA07B805 = getdvarint("dvar_BE31A0B0F96264BE", 4000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_33B2F96CE75CB855 = getDvar("dvar_287FBE54205F4583", "ber plu tri");
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_803A71BF7E2AFEC9 = getdvarint("dvar_21F6B2F4F605A38B", 2);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AC12C191D578B1FC = getdvarint("dvar_EC0D2F77C149A76F", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8EF9F58B6A7AFE93 = getdvarint("dvar_D2B336A16E9B3F70", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_716235BDDFB305F0 = getdvarint("dvar_98CB40FB319BCD47", 2304);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572BB4C60DF2D1B1 = getdvarfloat("dvar_EE13F902F72541EA", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_5769C2C60E37943D = getdvarfloat("dvar_EE1BFF02F72D3ACA", 20.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572D9F41A62CC17C = getdvarint("dvar_0A061D7692B5D643", 3000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF = getdvarint("dvar_2AA7E94F2B915238", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_11027E0991067FAA = getdvarint("dvar_649BE3F19F691BA0", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8E6E735A3607B730 = getdvarint("dvar_1E38E38A1534C4A2", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_77322344F7917DFC = getdvarint("dvar_49D4578BB39F0848", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_879711B450FD9DCE = getdvarfloat("dvar_CF6F4BC73FE603D4", 9.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_EC24CB21C7F05967 = getdvarfloat("dvar_BC4AB0E1E738F53B", 0.25);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_187B15D0D681ED14 = getdvarfloat("dvar_D9B5475A1979AB9D", 1.5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_ADC0FAD3F842D68F = getdvarint("dvar_6B82286284E9D06E", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_393D26E0E968F852 = getdvarint("dvar_A6CFC5544D74F7BF", 4);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_4472A2372DDC2CC0 = getdvarfloat("dvar_87B5941C5FDCA522", 5.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F5BFD8CF641D707 = getdvarint("dvar_D1DD4F34AADA10FE", 6);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AB026FC2A155136D = getdvarfloat("dvar_5F0AA90F84BBD519", 5.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_84AA1B04A3F96808 = getdvarint("dvar_E49151992582CFB7", 10);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_851FFE073082048A = getdvarfloat("dvar_D60D231EE6DC387A", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B68FCB1B5D940382 = getdvarfloat("dvar_956FDD322FAED186", 0.25);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_638730E568DEA417 = getdvarint("dvar_32813E962C93ACB0", 256);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D46D4318A15EE3FE = getdvarint("dvar_7EB225EE98272551", 192);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_588BA2EC2484B034 = getdvarint("dvar_8070336039BC4225", 768);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AD7AD59EBFDAE08C = getdvarint("dvar_C32D9DE045C69A10", 2);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8875BE3CE5A370D4 = getdvarint("dvar_EAC47BF2C6567180", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6DE843516FB84235 = getdvarfloat("dvar_D9B3475D9A51F76C", 5.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D583139D37B99DDF = getdvarfloat("dvar_A24A178DAC7D8A33", 0.5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_762EB6F1E9724FEA = getdvarint("dvar_2A2E0BE32B76EF8B", 512);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_1D37E435E474B707 = getdvarint("dvar_261F96EA4E704B78", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2E0C9DC38097F039 = getdvarint("dvar_85047ABB86E552D8", 590);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0481C2689C39BA74 = getdvarint("dvar_248FD1E95368AAD9", 192);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_1ED92F6D912C9995 = getdvarfloat("dvar_57C3E963115A0E1B", 1.5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8275FEFD6945052A = getdvarfloat("dvar_D8EA04134343528B", 3.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_92FB78CA5AF82FE4 = getdvarfloat("dvar_ECF067EFC8974734", 6.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_EB5B985CBA8997F9 = getdvarfloat("dvar_2378E0430F4A2E9E", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CE33E905A8335D56 = getdvarfloat("dvar_D4D62EC2ACE68362", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_1B9DDC66EA9DC058 = getdvarfloat("dvar_389A4BB4EE827CB8", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_38EAC2A5C514C498 = getdvarfloat("dvar_F35E51324FA28BE4", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D0B83C7B63C98011 = getdvarfloat("dvar_4912E52003018245", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F9F69D98D83B83C9 = getdvarfloat("dvar_B3291F1137147C4F", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A4830E9532F7FC59 = getdvarfloat("dvar_29FF5562E7D0A380", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C1BCEFE508528799 = getdvarfloat("dvar_8E909710891BBDAF", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_57E8127D75FC9DA9 = getdvarfloat("dvar_67576D2AE1FF56E0", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AA657343E38C0C5C = getdvarfloat("dvar_8058E06CA4D33991", 13.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7325CE521FC5E3E7 = getdvarfloat("dvar_A58E96D700307A82", 8.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0198A615BFD3F059 = getdvarint("dvar_E20E4ECC3C826E9D", 2);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A302E223567A930B = getdvarfloat("dvar_7F1B736511EA4264", 12.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_16082451127C4A27 = getdvarint("dvar_4DB1FD61445ED464", 250);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AAB3C520B5A4D04E = getdvarint("dvar_9670EF62E1FA2E2D", 192);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_40159311E3FB11F2 = getdvarfloat("dvar_6426F6E330D523E2", 0.25);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7D816906AFE09AF9 = getdvarfloat("dvar_A8B000EDE1F4D6B8", 6);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CE691C052CEDA566 = getdvarfloat("dvar_87F645E62D9F9B80", 3.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_76014CA6914AD16A = getdvarfloat("dvar_4367A112E7A376C9", 0.1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BC674AA0CFE2F13B = getdvarfloat("dvar_8A828A019E16AAD4", 0.33);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_19425DBAE48971B9 = getdvarfloat("dvar_789C80E8D0A7863D", 0.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DD38DB1002A8FD1A = getdvarfloat("dvar_B56CEE9856470DFE", 0.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B00B634FF0D615B6 = getdvarfloat("dvar_43951110B4E39DEB", 3.5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9042D5CF11398509 = getdvarfloat("dvar_FCB42FBEE40A2B06", 0.5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8935D39CDF624A21 = getdvarint("dvar_A9B91D09C8910B23", 10000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BC573EA608F113CD = getdvarint("dvar_0449561F9F615FBA", 4500);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F12ACD8EB090FB0 = getdvarint("dvar_FBEB3408FD066A4F", 2000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_22CF546CE61F0EE4 = getdvarint("dvar_A39387848555FF92", 700);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2A708F42DF785976 = getdvarint("dvar_0C160239976C5A59", 500);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2A938142DF9E8264 = getdvarint("dvar_0BF3143997463A37", 2500);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F3369A0BF2E24D98 = getdvarint("dvar_28853A0ECCA5530C", 650);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_E31C618E0043E25C = getdvarint("dvar_26E1802CC88B7A47", 100);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_63E44F52D71E301E = getdvarint("dvar_73E7F4778AD48646", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AB283D0E7E66556F = getdvarfloat("dvar_2026983AFB054BA1", 300.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_E49836FBF89774A4 = getdvarint("dvar_5609F399D2AED079", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_481B257DA804995E = getdvarint("dvar_83026AE3DA184B2D", 1000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_97A198E6390E4DA9 = getdvarint("dvar_E4A0734D3E02BAC7", 2000000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F07DDDD68D0CBCD8 = getdvarint("dvar_47538600A09B3AC9", 5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_4C57A2F7BB2C52B8 = getdvarint("dvar_60BA0FD26B4A9011", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_FFF72F4D008B3EA6 = getdvarint("dvar_FC67AB7BEBC87864", -1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F167D252E60F3073 = getdvarint("dvar_F49436DA08765BB8", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6E608BE85A24080B = getdvarint("dvar_C6E5DC7DEBC72EED", 90);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_45B2296F6F91A215 = getdvarint("dvar_96AEAE237894FBA7", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_31C2E1A85FB84FB5 = getdvarint("dvar_935A1CB445BBB32F", 400);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_218BC5767126BB7A = getdvarint("dvar_C0EF52A5EBBA31EC", 40);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DC6FDA0FBC9FE1E9 = getdvarint("dvar_E2BE0EFAE70F07A1", 4);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_21AA92004DD32D05 = getdvarint("dvar_ABAE39B8C021549C", 5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.userate = getdvarfloat("dvar_634F6A9F40D48EAA", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.usecooldown = getdvarfloat("dvar_D5198FA240C8A729", 0.75);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9C24246ADC08EDD8 = getdvarint("dvar_303ACDB7C2756320", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_69C68027E3FF75A4 = getdvarint("dvar_8D4A9C3FB764F814", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.armtime = getdvarfloat("dvar_E01340AAC4318F42", 10.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DD475D11757AD803 = getdvarfloat("dvar_B287A598411C516E", -1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_3483B8B1B5DC47AF = getdvarint("dvar_71BEF7BE698CC6C9", 128);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9B7BE937E7E7CF36 = getdvarint("dvar_A2EC02DEDBDF4744", 128);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0CD816464EB84955 = getdvarfloat("dvar_F9AAEBB4D0ED8973", 120.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_4B094191812BE79A = getdvarint("dvar_7C55FBB1B17FE120", 90);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_284D588BB7B6D497 = getdvarint("dvar_7B806B03745EB1C1", 72);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.defusetime = getdvarfloat("dvar_2AE542C01753B936", 15.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_E5AD956128DC4DA1 = getdvarfloat("dvar_AFB6FF8E5B2C0402", 0.5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_28B3C6C19C3773DE = getdvarint("dvar_2C63C6118E91805B", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D25D8476EAF60724 = getdvarint("dvar_71200E8541315AB2", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BDFC36B6FAC17CC4 = getdvarfloat("dvar_F75DC4D887B09EC1", 18.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_895D3E780C654E27 = getdvarint("dvar_00A875817690841B", 100);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A1C716E522C46B09 = getdvarfloat("dvar_984263B915F3105B", 3.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_36B827B9C3105FDB = getdvarfloat("dvar_ED76CDFEFE71C0E9", 0.5);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_ECD0F4EB1E770D6C = getdvarfloat("dvar_A8161A2602C3E52B", 1.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B01D54F0EA63BFB3 = getdvarint("dvar_E7CB141AEA4CD049", 500);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B983F90AB46B22A6 = getdvarint("dvar_A6D39B5B39005AF5", 100);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_41DF90BB27AA4B6F = getdvarint("dvar_E083AC3AF8DE9F02", 2000);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2FFB7E53B882CC63 = getdvarint("dvar_7C7E489C5812729C", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AC446D2819C17146 = getdvarint("dvar_03F63147E77D0CE3", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9719A1F9940E8A89 = getdvarint("dvar_8DD640AC99E86037", 0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_FB5C6A73584DF0C1 = getdvarint("dvar_2262425B040AD7E8", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_32B459C0D029B500 = getdvarfloat("dvar_9FC3C1594145303F", 5.0);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_52EDD3735575F1CB = getdvarint("dvar_EB319C1BCB7E8ED1", 0);
  _id_F879772A0F3EC6EF();
}

_id_F879772A0F3EC6EF() {
  switch (level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_5159F960A67ED33B) {
    case 1:
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8875BE3CE5A370D4 = 0;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_77322344F7917DFC = 0;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29258DCC063EEC7F = 15;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8A0E0D62D99BEF57 = 20000;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A076A7284AA6E915 = 5000;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7846374C36699FD8 = 120;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572D9F41A62CC17C = 2500;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_588BA2EC2484B034 = 512;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B00B634FF0D615B6 = 4.0;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9042D5CF11398509 = 1.0;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F3369A0BF2E24D98 = 500;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_E31C618E0043E25C = 150;
      break;
    case 2:
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8875BE3CE5A370D4 = 1;
      level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_77322344F7917DFC = 1;
      break;
    default:
      break;
  }
}

_id_E79057A53754525C() {
  setdvarifuninitialized("dvar_74ABB928AB13113B", 1);
  setdvarifuninitialized("dvar_60BA0FD26B4A9011", 1);

  if(istrue(level.br_circle_disabled))
    setdvarifuninitialized("dvar_30D49880D50137EE", 1);
}

_id_61FF01586B919509(_id_1493DA49A2631455) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B) || level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size < 1) {
    return;
  }
  _id_D43E1B169E506F3B = level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B;

  if(isDefined(_id_1493DA49A2631455))
    _id_D43E1B169E506F3B = _id_1493DA49A2631455;

  _id_977F24E61599CBBA = tablelookupgetnumrows("loot/consumable_ids.csv");

  for(index = 0; index < _id_977F24E61599CBBA; index++) {
    _id_DB35956D84816F27 = tablelookupbyrow("loot/consumable_ids.csv", index, 0);
    itemname = tablelookupbyrow("loot/consumable_ids.csv", index, 1);
    _id_27DE1507ED41F01E = _id_96A1620D901981D1(itemname, 0, _id_1493DA49A2631455);

    if(isDefined(_id_27DE1507ED41F01E))
      _id_D43E1B169E506F3B[_id_27DE1507ED41F01E]._id_AA75D313B311DE39 = int(_id_DB35956D84816F27);
  }
}

_id_D91C1A6B28AE8EA3() {
  _id_5A7FCBE60CDF0A26 = _id_9F8B8711FE09E7C3();

  if(!isDefined(_id_5A7FCBE60CDF0A26)) {
    return;
  }
  level._id_C83AA9DBC3654AFA._id_5FB0D01B9AF82AC3 = _id_5A7FCBE60CDF0A26._id_D43E1B169E506F3B;
  level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B = [];
  level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855 = strtok(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_33B2F96CE75CB855, " ");

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_5FB0D01B9AF82AC3) || level._id_C83AA9DBC3654AFA._id_5FB0D01B9AF82AC3.size < 1) {
    return;
  }
  if(level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855.size < 3) {
    return;
  }
  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_5FB0D01B9AF82AC3) {
    if(isDefined(_id_F7806D4CF24AACD3._id_BC4A2F35F7DFF533))
      _id_8C50F5B7B81E6E06 = getscriptbundle("elitebrokenarrowelement:" + _id_F7806D4CF24AACD3._id_BC4A2F35F7DFF533);
    else
      continue;

    if(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size == level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855.size) {
      break;
    } else if(scripts\engine\utility::array_contains(level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855, _id_8C50F5B7B81E6E06._id_27DE1507ED41F01E)) {
      level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B[_id_8C50F5B7B81E6E06._id_27DE1507ED41F01E] = _id_8C50F5B7B81E6E06;
      level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B[_id_8C50F5B7B81E6E06._id_27DE1507ED41F01E]._id_6A89F76ED7B6F41E = scripts\engine\utility::_id_53C4C53197386572(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B[_id_8C50F5B7B81E6E06._id_27DE1507ED41F01E]._id_6A89F76ED7B6F41E, 0);
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B[level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855[_id_AC0E594AC96AA3A8]])) {
      level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B = [];
      return;
    }

    level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B[level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855[_id_AC0E594AC96AA3A8]]._id_C36FC01475B3A4C9 = _id_AC0E594AC96AA3A8;
  }

  _id_61FF01586B919509();
}

_id_9F8B8711FE09E7C3() {
  if(!isDefined(level._id_21E8A7768C0260F2) || !isDefined(level._id_21E8A7768C0260F2._id_446147A0D9941152)) {
    return;
  }
  return getscriptbundle("elitebrokenarrowelementlist:" + level._id_21E8A7768C0260F2._id_446147A0D9941152);
}

_id_D44853CEBE3E6D36() {
  game["dialog"]["arrow_started"] = "thrs_cqan_cqsh";
  game["dialog"]["arrow_started_enemy"] = "thrs_cqan_cqpl";
  game["dialog"]["arrow_collect_element_1"] = "frst_cqan_cmp1";
  game["dialog"]["arrow_collect_element_2"] = "frst_cqan_cmp2";
  game["dialog"]["arrow_collect_element_all"] = "chw1_cqan_cmpa";
  game["dialog"]["arrow_bombsite_reveal"] = "frst_cqan_dvcl";
  game["dialog"]["arrow_bombsite_arm"] = "chw1_cqan_dvam";
  game["dialog"]["arrow_bombsite_arm_enemy"] = "frst_cqan_dvam";
  game["dialog"]["arrow_detonation_warning"] = "frst_cqan_dvwr";
  game["dialog"]["arrow_defused"] = "frst_cqan_dd30";
  game["dialog"]["arrow_defused_under_30"] = "frst_cqan_ddls";
  game["dialog"]["arrow_detonated"] = "chw1_cqan_dvdt";
  game["dialog"]["arrow_detonated_enemy"] = "frst_cqan_dvdt";
  game["dialog"]["arrow_failed"] = "chw1_cqan_dvdf";
}

_id_4DA2FEDD08554C6E(dialog, delay) {
  delay = scripts\engine\utility::_id_53C4C53197386572(delay, 2.0);
  _id_DB62C0CFC8A661CC = self;
  _id_2CEDCC356F1B9FC8::brleaderdialogteam(dialog, _id_DB62C0CFC8A661CC.targetteam, undefined, delay);
}

_id_BF0175F3BB67A26D(dialog, delay, _id_D3806C49E6704209) {
  delay = scripts\engine\utility::_id_53C4C53197386572(delay, 2.0);
  _id_DB62C0CFC8A661CC = self;

  foreach(player in level.players) {
    if(isDefined(player) && player.team != _id_DB62C0CFC8A661CC.targetteam) {
      if(istrue(_id_D3806C49E6704209) && _id_8EF404291EA37583(player)) {
        continue;
      }
      thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer(dialog, player, undefined, undefined, delay);
    }
  }
}

_id_3738BE6FCF9FECD1(dialog) {
  _id_2CEDCC356F1B9FC8::brleaderdialog(dialog);
}

_id_797F8EE99632DBC2() {
  _id_7ED3748A6429CDFF = scripts\engine\utility::getStructArray("elite_arrow_spawn", "targetname");

  if(isDefined(_id_7ED3748A6429CDFF) && _id_7ED3748A6429CDFF.size > 0) {
    level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A = [];

    foreach(bomb in _id_7ED3748A6429CDFF)
    level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A[level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A.size] = bomb.origin;
  } else if(level.mapname == "mp_br_mechanics")
    level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A = [(198, -2218, 0)];
  else
    level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A = [(12541.3, 18580.8, 263.25), (16653.7, -2014.65, 376.375), (43244.5, -4839.64, 744.5), (29629.9, -18271.5, 551.59), (28183.5, -31562.6, 351.75), (9650.21, -27067.1, 1074.5), (26452.4, -24821.7, 595), (17575.8, -39062.8, 851), (3872.74, -42656.5, 175), (18706.6, -50833.7, 864), (-18442.7, -50707, 237.91), (-23513.5, -37714.8, 519.682), (-25700.3, -45209.7, 297.231), (-31703.1, -37764.1, 240.376), (-28870.2, -30780.3, 257.78), (-45368.7, -17245.2, 255.02), (-36604.8, -14054.4, 261.262), (-21428.8, -11651.1, 630.5), (-41286.4, -7004.32, 453), (-46975.8, 4787.15, 828.89), (-28021.7, -1849.79, 1924.35), (-35393.6, 21162.5, -435.81), (-23611, 21521.7, -285.71), (-8926.07, 45061.9, 253), (-5513.55, 14513.4, 352), (-10474, -4168.93, 1425.78), (-3418, -14106, 4761.43), (21037.4, -15753.4, 3698.3), (-5543.01, 25395.3, 56), (-16351, -34060.5, 522.5)];
}

_id_B31F7AF7E23417B0() {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_F198C878F78DD4AB))
    level._id_C83AA9DBC3654AFA._id_F198C878F78DD4AB = 0;

  level._id_C83AA9DBC3654AFA._id_F198C878F78DD4AB++;
  return 1;
}

_id_8F2A91A76E062B32(player) {
  _id_B8EBE3F71A08AB40 = self;
  _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.maxteamsize >= 0 && _id_7273312620004BC3.size > level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.maxteamsize)
    return "too_many_teammates";

  return 1;
}

_id_401F74A7D8648053() {
  _id_B8EBE3F71A08AB40 = self;
  _id_B8EBE3F71A08AB40.category = "elite_arrow";

  if(!_id_B8EBE3F71A08AB40 _id_E2F4E0D74CFA48A3()) {
    scripts\mp\utility\script::demoforcesre("arrow_onTeamAssigned - Failed arrow_onTeamAssignedCheckNum. level.arrow.numAccepted: " + level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22 + ", level.arrow.dvars.maxAccepted: " + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_85EE4754325BC510);
    return;
  }

  if(!_id_B8EBE3F71A08AB40 _id_B108B493FFDB2DE2()) {
    scripts\mp\utility\script::demoforcesre("arrow_onTeamAssigned - Failed arrow_onTeamAssignedCheckToken.");
    return;
  }

  level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22++;

  if(level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22 >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_85EE4754325BC510)
    _id_259DD894CBA599E8();

  _id_B8EBE3F71A08AB40 _id_3912F25D2EAD337E();
  _id_B8EBE3F71A08AB40 _id_56F6B28D2F262CCE();
  _id_B8EBE3F71A08AB40 _id_B13F8DA1C1A71B93();

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176))
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176 = _id_6C310980DF01AC73();

  _id_B8EBE3F71A08AB40.targetteam = _id_B8EBE3F71A08AB40._id_0D154AC2657C5F44.team;
  _id_B8EBE3F71A08AB40 _id_0CCE93D9EDEF517A();
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_B8EBE3F71A08AB40.targetteam];

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B) || level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size < 1) {
    _id_9C74CCDAA1E15C02("container_spawn_failed");
    return;
  }

  _id_16D299FC7942BA3D(_id_B8EBE3F71A08AB40.targetteam);
  _id_DB62C0CFC8A661CC _id_0105103A837ADD0E();
  _id_DB62C0CFC8A661CC _id_31B2CAE426F07A05(_id_B8EBE3F71A08AB40);
  _id_DB62C0CFC8A661CC _id_CC32274AF7105ABB();
  _id_DB62C0CFC8A661CC _id_77C7DF8755C85A82();
}

_id_56F6B28D2F262CCE() {
  _id_B8EBE3F71A08AB40 = self;

  foreach(player in scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40._id_0D154AC2657C5F44.team, "players")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "disablePlayer"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "disablePlayer")]](player, "br_elite_contract");
  }
}

_id_B13F8DA1C1A71B93() {
  _id_B8EBE3F71A08AB40 = self;

  foreach(player in scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40._id_0D154AC2657C5F44.team, "players"))
  player scripts\mp\utility\stats::incpersstat("eliteStarted", 1);
}

_id_E2F4E0D74CFA48A3() {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22) || istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.debug))
    level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22 = 0;

  if(level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22 >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_85EE4754325BC510) {
    _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_93663FE58D95F174();
    return 0;
  }

  return 1;
}

_id_B108B493FFDB2DE2() {
  _id_B8EBE3F71A08AB40 = self;

  if(_id_AEE3A8BE63DB5997(_id_B8EBE3F71A08AB40._id_0D154AC2657C5F44)) {
    if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_52EDD3735575F1CB)
      return 1;

    _id_B8EBE3F71A08AB40._id_0D154AC2657C5F44 scripts\cp_mp\challenges::_id_8935E658D461FC50();
    return 1;
  }

  _id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_93663FE58D95F174();
  return 0;
}

_id_0105103A837ADD0E() {
  _id_DB62C0CFC8A661CC = self;
  _id_DB62C0CFC8A661CC _id_4DA2FEDD08554C6E("arrow_started");
  _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_started_enemy");
  scripts\mp\hud_util::showsplashtoteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_started");
  scripts\mp\hud_util::showsplashtoallexceptteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_started_global", undefined, _id_DB62C0CFC8A661CC.champion);
}

_id_31B2CAE426F07A05(_id_B8EBE3F71A08AB40) {
  _id_DB62C0CFC8A661CC = self;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE))
    _id_DB62C0CFC8A661CC _id_86EA1B770AE5CB74();
  else
    _id_B8EBE3F71A08AB40 _id_3FD409053922036C();

  _id_DB62C0CFC8A661CC _id_57D7831B6681E062();
  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
}

_id_57D7831B6681E062() {
  _id_DB62C0CFC8A661CC = self;
  _id_D442D1AD58AC95E8 = _id_F584D115CB4C5860();
  _id_6925C46F3E7740CD = 1200;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DB411D3DF4599406 > 0)
    _id_6925C46F3E7740CD = min(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DB411D3DF4599406, 1200);
  else if(_id_362C58E8BB39BCDA::isfeatureenabled("circle"))
    _id_6925C46F3E7740CD = _id_2695A20D4011076D::_id_E55C19338F6E9E0C(_id_D442D1AD58AC95E8);

  _id_6925C46F3E7740CD = _id_6925C46F3E7740CD + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AB283D0E7E66556F;
  _id_6925C46F3E7740CD = _id_6925C46F3E7740CD + 120;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_DB62C0CFC8A661CC.targetteam, "players");

  foreach(player in _id_6D5ED003AF1F9612)
  player _id_2E7F459351D2A81E(int(_id_6925C46F3E7740CD), 3);
}

_id_3E22F1EDF43325C1(_id_3B96D5666000C2E0, _id_EB06B338608EF354) {
  _id_06448BD11F15B7DD = _id_2EAC770CF8006E0B(_id_EB06B338608EF354);
  _id_24360C0E09F7DE0C = _id_8EF404291EA37583(_id_3B96D5666000C2E0);

  if(_id_06448BD11F15B7DD && level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2FFB7E53B882CC63 == 0)
    return 0;

  if(_id_24360C0E09F7DE0C && level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AC446D2819C17146 == 0)
    return 0;

  return 1;
}

_id_4F13C26FCEBE3FF8(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)) {
    return;
  }
  if(isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_8A04AA0E0755E7E3]))
    _id_04595D1F5F78B6B7(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);

  if(isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_EB06B338608EF354]))
    _id_AF63D46F908FDD08(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
}

_id_AF63D46F908FDD08(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_EB06B338608EF354];
  player _id_E16C60B795D0B382(1);
  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
  _id_DB62C0CFC8A661CC _id_77C7DF8755C85A82();
  player _id_DB724919D6173E87(_id_EB06B338608EF354);
  _id_F045C586F2D204CE(player, 1, _id_EB06B338608EF354);
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(_id_DB62C0CFC8A661CC.state >= 2 && _id_DB62C0CFC8A661CC.state <= 4)
    _id_B5111CD83B4A3176 enablescriptableplayeruse(player);
  else
    _id_B5111CD83B4A3176 disablescriptableplayeruse(player);

  if(isDefined(_id_B5111CD83B4A3176._id_404971775E931566))
    _id_B5111CD83B4A3176._id_404971775E931566 _id_F025BE1CBF898D23(player, 1);

  if(isDefined(_id_B5111CD83B4A3176._id_6F92F4592E6847E9))
    _id_B5111CD83B4A3176._id_6F92F4592E6847E9 _id_F025BE1CBF898D23(player, 0);
}

_id_04595D1F5F78B6B7(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_8A04AA0E0755E7E3];
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(isDefined(_id_B5111CD83B4A3176._id_B32599446F874D93)) {
    foreach(icon in _id_B5111CD83B4A3176._id_B32599446F874D93) {
      if(!isDefined(icon)) {
        continue;
      }
      icon _id_F5549984B1909638(player, 0);
    }
  }

  if(_id_DB62C0CFC8A661CC.state == 5)
    _id_B5111CD83B4A3176 enablescriptableplayeruse(player);
  else
    _id_B5111CD83B4A3176 disablescriptableplayeruse(player);

  if(isDefined(_id_B5111CD83B4A3176._id_404971775E931566))
    _id_B5111CD83B4A3176._id_404971775E931566 _id_F025BE1CBF898D23(player, 0);

  if(isDefined(_id_B5111CD83B4A3176._id_6F92F4592E6847E9))
    _id_B5111CD83B4A3176._id_6F92F4592E6847E9 _id_F025BE1CBF898D23(player, 1);

  player setclientomnvar("ui_br_elite_arrow_mission_data", 0);
  player setclientomnvar("ui_br_elite_arrow_mission_players", 0);
  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
  player _id_E16C60B795D0B382(0);
  player _id_3CEE7764BD6C4CFF(_id_8A04AA0E0755E7E3);
  _id_F045C586F2D204CE(player, 0, _id_8A04AA0E0755E7E3);

  if(isDefined(_id_B5111CD83B4A3176.targetplayer) && player == _id_B5111CD83B4A3176.targetplayer)
    _id_B5111CD83B4A3176 _id_3A3999F7F98A09BA();

  if(player == _id_DB62C0CFC8A661CC.owner)
    player notify("arrow_player_removed");
}

_id_53378EBC66BE211C(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  _id_EF1A83CF2BA58E1A(player, 0);
}

_id_4C82D5D35830EA32(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(_id_2EAC770CF8006E0B(player.team)) {
    return;
  }
  _id_EF1C1B3C3CF49AB0(player, 0);
}

_id_DCF3929E77FE1DE9(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  _id_EF1A83CF2BA58E1A(player, 1);
  _id_19723E62D956D201(player);
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];

  if(!isDefined(_id_DB62C0CFC8A661CC.owner))
    _id_DB62C0CFC8A661CC _id_CC850454568F09F9(player);
}

_id_E1E06922C2539044(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(_id_2EAC770CF8006E0B(player.team)) {
    return;
  }
  _id_EF1C1B3C3CF49AB0(player, 1);
  _id_19723E62D956D201(player);
}

_id_33577EBB4253A4F9() {
  if(isDefined(self._id_B8EBE3F71A08AB40) && isDefined(self.type) && _id_7E52B56769FA7774::_id_C7279E910CEFD2A4(self.type))
    self._id_B8EBE3F71A08AB40 _id_3912F25D2EAD337E();
}

_id_AEE1FF3149365FA6(tablet) {
  if(!isDefined(level._id_C83AA9DBC3654AFA)) {
    return;
  }
  if(isDefined(tablet) && isDefined(tablet._id_B8EBE3F71A08AB40))
    tablet._id_B8EBE3F71A08AB40 _id_3912F25D2EAD337E();
}

_id_601137842B64C899(player) {
  if(!isDefined(level._id_C83AA9DBC3654AFA)) {
    return;
  }
  [_id_3793828403C6873E, _id_F1CBC68C79EBF1EA] = _id_C1A30DB229B1311D(player, 0);

  while(isDefined(_id_3793828403C6873E)) {
    player _id_7E52B56769FA7774::quickdropall(10, _id_3793828403C6873E);
    [_id_3793828403C6873E, _id_F1CBC68C79EBF1EA] = _id_C1A30DB229B1311D(player, _id_3793828403C6873E + 1);
  }

  if(isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D) && isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176)) {
    _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

    if(isDefined(_id_B5111CD83B4A3176.targetplayer) && player == _id_B5111CD83B4A3176.targetplayer)
      _id_B5111CD83B4A3176 _id_3A3999F7F98A09BA();
  }
}

_id_9C74CCDAA1E15C02(_id_1EA736D378B0D412, _id_8162ABD764747B50) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)) {
    return;
  }
  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      continue;
    }
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47(_id_1EA736D378B0D412, 0, _id_8162ABD764747B50);
  }
}

_id_088A043B99A75E47(_id_1EA736D378B0D412, success, _id_8162ABD764747B50) {
  _id_DB62C0CFC8A661CC = self;

  if(!isDefined(_id_DB62C0CFC8A661CC) || _id_DB62C0CFC8A661CC.state == 0 || _id_DB62C0CFC8A661CC.state == 6) {
    return;
  }
  _id_DB62C0CFC8A661CC notify("on_end");
  _id_DB62C0CFC8A661CC endon("on_end");
  _id_715028F54BAD19A1::_id_1D6052577CD7738C(_id_DB62C0CFC8A661CC, _id_1EA736D378B0D412, success);

  if(istrue(success)) {
    level.skipplaybodycountsound = 1;
    level._id_FDB13CCD60AFE05C = 1;
    level notify("nuke_detonated");

    foreach(player in scripts\mp\utility\teams::getteamdata(_id_DB62C0CFC8A661CC.targetteam, "players")) {
      player scripts\mp\utility\stats::incpersstat("eliteCompleted", 1);
      player _id_FA5724663BA71381();
    }
  } else {
    level notify("nuke_aborted");
    _id_7AB5B649FA408138::_id_C79F9300EE85F805(level.players, "br_elite_contract_ending", 0.0);
  }

  _id_DB62C0CFC8A661CC _id_984F516E55828C50(_id_1EA736D378B0D412, success);
  _id_DB62C0CFC8A661CC _id_B141B13225E7B0FE(success);

  if(_id_77FB65AE3082871C() == 0)
    _id_4905559A168F4DD4();

  _id_DB62C0CFC8A661CC _id_20238D522C76FB01();
  _id_5E7FDF58F111F041();
  wait 0.5;
  _id_0DA60AC7AAE847D8 = undefined;

  if(!istrue(success))
    _id_0DA60AC7AAE847D8 = _id_8162ABD764747B50;

  _id_DB62C0CFC8A661CC._id_B8EBE3F71A08AB40 _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), _id_DB62C0CFC8A661CC.targetteam, undefined), undefined, _id_0DA60AC7AAE847D8);

  if(istrue(success))
    _id_DB62C0CFC8A661CC _id_350746711C99EB8D();
  else
    _id_DB62C0CFC8A661CC _id_C71B665383229BC9();
}

_id_4905559A168F4DD4() {
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(!isDefined(_id_B5111CD83B4A3176)) {
    return;
  }
  _id_B5111CD83B4A3176 notify("on_end_bombsite");
  _id_B5111CD83B4A3176.enabled = 0;
  _id_B5111CD83B4A3176 thread _id_B51E8C52609285F0();
  waitframe();
  _id_B5111CD83B4A3176 notify("death");
}

_id_69AE8AB0C2DB4623(_id_74B5B12BB6514385) {
  level endon("game_ended");
  level endon("nuke_aborted");
  _id_74B5B12BB6514385 = scripts\engine\utility::_id_53C4C53197386572(_id_74B5B12BB6514385, 0.4);
  wait(_id_74B5B12BB6514385);
  scripts\mp\hud_util::showsplashtoall("elite_arrow_victory");
}

_id_984F516E55828C50(_id_1EA736D378B0D412, success) {
  _id_DB62C0CFC8A661CC = self;

  if(istrue(success)) {
    return;
  }
  if(_id_DB62C0CFC8A661CC.state >= 5 || _id_1EA736D378B0D412 == "bomb_defused") {
    level._id_C83AA9DBC3654AFA.defused = 1;
    _id_34E4B26FEE2CFD2B = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_C6B73E1A1D773F72;

    if(!isDefined(_id_34E4B26FEE2CFD2B)) {
      return;
    }
    scripts\mp\hud_util::showsplashtoall("elite_arrow_defused", undefined, _id_34E4B26FEE2CFD2B);

    if(isDefined(_id_34E4B26FEE2CFD2B)) {
      _id_517A45BAB5F1F926 = _id_34E4B26FEE2CFD2B getentitynumber();

      if(isDefined(_id_517A45BAB5F1F926)) {
        setomnvarforallclients("ui_br_elite_savior_id", _id_517A45BAB5F1F926);
        return;
      }

      return;
    }
  } else {
    champion = scripts\engine\utility::_id_53C4C53197386572(_id_DB62C0CFC8A661CC.champion, _id_DB62C0CFC8A661CC.owner);

    if(!isDefined(champion)) {
      return;
    }
    scripts\mp\hud_util::showsplashtoteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_failed_center");
    scripts\mp\hud_util::showsplashtoallexceptteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_failed_global", undefined, champion);
    return;
  }
}

_id_350746711C99EB8D() {
  _id_DB62C0CFC8A661CC = self;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_28B3C6C19C3773DE)) {
    _id_67708F418B1FAC79::shutdowngulag("nuke_end", 0, 1);
    _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

    if(!isDefined(_id_B5111CD83B4A3176)) {
      return;
    }
    _id_B5111CD83B4A3176 _id_B308A39503F00ABF();
  }
}

_id_C71B665383229BC9() {
  _id_DB62C0CFC8A661CC = self;
  _id_DB62C0CFC8A661CC _id_4DA2FEDD08554C6E("arrow_failed", 4.0);
}

_id_77C7DF8755C85A82() {
  _id_DB62C0CFC8A661CC = self;
  _id_A0A60C2DF22298D9(_id_DB62C0CFC8A661CC.targetteam, 1);
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;
  _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(1, _id_DB62C0CFC8A661CC.targetteam);
}

_id_66C05A319972D8DC() {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC))
    return 0;

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      continue;
    }
    if(_id_DB62C0CFC8A661CC.state != 0)
      return 1;
  }

  return 0;
}

_id_2EAC770CF8006E0B(team) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC))
    return 0;

  return isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[team]) && level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[team].state > 0;
}

_id_8EF404291EA37583(player) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC))
    return 0;

  return isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team]) && level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team].state > 0;
}

_id_10949665EFA60B20() {
  _id_B51A2875223FBBEC = self;
  scriptable = _id_B51A2875223FBBEC.instance;

  if(isDefined(_id_B51A2875223FBBEC.scriptablename) && !_id_B51A2875223FBBEC _id_5FACFBEE97E1A98E())
    return undefined;

  if(!scriptable _id_5FACFBEE97E1A98E())
    return undefined;

  _id_27DE1507ED41F01E = _id_96A1620D901981D1(scriptable.type, 7);
  return _id_6844602F3120E900(_id_27DE1507ED41F01E, 0);
}

_id_5FACFBEE97E1A98E() {
  scriptable = self;

  if(!isDefined(scriptable))
    return 0;

  _id_27DE1507ED41F01E = undefined;
  name = scriptable.type;

  if(isDefined(scriptable.scriptablename))
    name = scriptable.scriptablename;

  if(isDefined(name))
    _id_27DE1507ED41F01E = _id_96A1620D901981D1(name, 7);

  return isDefined(_id_27DE1507ED41F01E) && isDefined(_id_6844602F3120E900(_id_27DE1507ED41F01E, 7));
}

_id_668FA8D4516F7E15() {
  scriptable = self;

  if(isDefined(scriptable._id_27DE1507ED41F01E) && isDefined(_id_6844602F3120E900(scriptable._id_27DE1507ED41F01E, 5)))
    return 1;

  _id_27DE1507ED41F01E = undefined;
  name = scriptable.type;

  if(isDefined(scriptable.scriptablename))
    name = scriptable.scriptablename;

  if(isDefined(name))
    _id_27DE1507ED41F01E = _id_96A1620D901981D1(name, 0);

  return isDefined(_id_27DE1507ED41F01E) && isDefined(_id_6844602F3120E900(_id_27DE1507ED41F01E, 0));
}

_id_3B0BC758816BA092() {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176))
    return 0;

  return istrue(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_B6AF7EF8B50C76EE);
}

_id_CE3E8C8B6DE2CA1B() {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176))
    return 0;

  return istrue(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_27DB4EB198CD48B9) && !istrue(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_71DD48E6C8570392);
}

_id_5908E524F32EB629() {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176))
    return 1;

  _id_862B6D5E858FB4F8 = _id_CE3E8C8B6DE2CA1B();

  if(_id_862B6D5E858FB4F8) {
    _id_BE2203D59EE928B6 = scripts\mp\utility\teams::getenemycount(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176.targetteam, 1);

    if(_id_BE2203D59EE928B6 == 0)
      level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176 _id_758F95FB5CF87D1B();
  }

  return !_id_862B6D5E858FB4F8;
}

_id_DD1EDDCB3A80416D(player) {
  cooldown = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.usecooldown * 1000;

  if(isDefined(player._id_BE21D884F764E2FC) && gettime() < player._id_BE21D884F764E2FC + cooldown)
    return 0;

  return 1;
}

_id_10451FCEDD4D3D6E() {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176))
    return 0;

  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B) {
    if(_id_B5111CD83B4A3176._id_DEBE9FD67DD91A71[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] < 1)
      return 0;
  }

  return 1;
}

_id_BC04F4B45CD80CF8(_id_27DE1507ED41F01E) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176))
    return 0;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_DEBE9FD67DD91A71[_id_27DE1507ED41F01E]))
    return 0;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F167D252E60F3073))
    return level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_DEBE9FD67DD91A71[_id_27DE1507ED41F01E] == 0;
  else
    return 1;
}

_id_C1A30DB229B1311D(player, _id_3793828403C6873E) {
  for(_id_AC0E594AC96AA3A8 = _id_3793828403C6873E; _id_AC0E594AC96AA3A8 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player); _id_AC0E594AC96AA3A8++) {
    _id_F1CBC68C79EBF1EA = player _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B) {
      if(_id_F7806D4CF24AACD3._id_AA75D313B311DE39 == _id_F1CBC68C79EBF1EA)
        return [_id_AC0E594AC96AA3A8, _id_F1CBC68C79EBF1EA];
    }
  }

  return [undefined, undefined];
}

_id_3A3D1BCCF139DD5B(player, _id_27DE1507ED41F01E, _id_3793828403C6873E) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements))
    return undefined;

  foreach(_id_C0414F532C535578 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) {
    if(!isDefined(_id_C0414F532C535578[_id_27DE1507ED41F01E])) {
      continue;
    }
    if(!isDefined(_id_3793828403C6873E) || !isDefined(_id_C0414F532C535578[_id_27DE1507ED41F01E]._id_3793828403C6873E) || _id_C0414F532C535578[_id_27DE1507ED41F01E]._id_3793828403C6873E != _id_3793828403C6873E) {
      continue;
    }
    if(!isDefined(player) || !isDefined(_id_C0414F532C535578[_id_27DE1507ED41F01E].player) || _id_C0414F532C535578[_id_27DE1507ED41F01E].player != player) {
      continue;
    }
    return _id_C0414F532C535578[_id_27DE1507ED41F01E];
  }

  return undefined;
}

_id_2C126DE0BDB9BFD5(_id_C36FC01475B3A4C9) {
  if(!isDefined(_id_C36FC01475B3A4C9))
    return 0;

  return 1 << _id_C36FC01475B3A4C9;
}

_id_96A1620D901981D1(_id_3E63B10BEEFB310B, _id_B70BA129CADD8394, _id_1493DA49A2631455) {
  if(getdvarint("dvar_74ABB928AB13113B", 0) == 0) {
    return;
  }
  if(!isDefined(_id_B70BA129CADD8394) || !isDefined(_id_3E63B10BEEFB310B) || !isDefined(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B) || level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size < 1) {
    return;
  }
  _id_097BC523A8E41C7D = 0;
  _id_EB99AE539FAB2970 = level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B;

  if(isDefined(_id_1493DA49A2631455))
    _id_EB99AE539FAB2970 = _id_1493DA49A2631455;

  foreach(_id_F7806D4CF24AACD3 in _id_EB99AE539FAB2970) {
    switch (_id_B70BA129CADD8394) {
      case 0:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_F391BF01090B356C;
        break;
      case 7:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_9815D79AFE176D3E;
        break;
      case 1:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_A782B3BC8550816D;
        break;
      case 8:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_12DB460B6BF36594;
        break;
      case 3:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_0BE816838784D6DB;
        break;
      case 2:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_8E829CA1FF49E752;
        break;
      case 5:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_AA75D313B311DE39;
        break;
      case 6:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_C36FC01475B3A4C9;
        break;
      case 4:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_6A89F76ED7B6F41E;
        break;
      case 9:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_D10723BDC6D74FA0;
        break;
      case 10:
        _id_9A4F2CDBB8EDD7D8 = _id_F7806D4CF24AACD3._id_A1A9BE5DD973583D;
        break;
      default:
        return undefined;
    }

    if(_id_9A4F2CDBB8EDD7D8 == _id_3E63B10BEEFB310B)
      return _id_F7806D4CF24AACD3._id_27DE1507ED41F01E;
  }

  return undefined;
}

_id_6844602F3120E900(_id_27DE1507ED41F01E, _id_3E63B10BEEFB310B, _id_1493DA49A2631455) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B) || level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size < 1 || !isDefined(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B[_id_27DE1507ED41F01E]))
    return undefined;

  _id_EB99AE539FAB2970 = level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B;

  if(isDefined(_id_1493DA49A2631455))
    _id_EB99AE539FAB2970 = _id_1493DA49A2631455;

  switch (_id_3E63B10BEEFB310B) {
    case 0:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_F391BF01090B356C;
    case 7:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_9815D79AFE176D3E;
    case 1:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_A782B3BC8550816D;
    case 3:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_0BE816838784D6DB;
    case 2:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_8E829CA1FF49E752;
    case 5:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_AA75D313B311DE39;
    case 6:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_C36FC01475B3A4C9;
    case 4:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_6A89F76ED7B6F41E;
    case 9:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_D10723BDC6D74FA0;
    case 10:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_A1A9BE5DD973583D;
    case 11:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_DA490276F40D2A1C._id_24D4BA21D4C1CB81;
    case 12:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_DA490276F40D2A1C._id_1FFFFCADF503CB61;
    case 13:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_69BC7818CF79DBE2._id_9A0F5F276577B987;
    case 14:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_69BC7818CF79DBE2._id_7027B25F7901F8C0;
    case 15:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_69BC7818CF79DBE2._id_28649FA5C5F7A7BD;
    case 16:
      return _id_EB99AE539FAB2970[_id_27DE1507ED41F01E]._id_69BC7818CF79DBE2._id_1634175863FD915D;
    default:
      return undefined;
  }
}

_id_270EFE97B9F9C9FC(_id_2E5F671F800DB00F) {
  if(!isDefined(_id_2E5F671F800DB00F)) {
    return;
  }
  if(isarray(_id_2E5F671F800DB00F)) {
    foreach(_id_4EFE32558A7556C6 in _id_2E5F671F800DB00F) {
      if(isDefined(_id_4EFE32558A7556C6))
        _id_4EFE32558A7556C6 destroy();
    }
  } else if(isDefined(_id_2E5F671F800DB00F))
    _id_2E5F671F800DB00F destroy();
}

_id_A0A60C2DF22298D9(targetteam, _id_C37B1CC67943336D) {
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(!isDefined(_id_B5111CD83B4A3176._id_B32599446F874D93)) {
    return;
  }
  foreach(icon in _id_B5111CD83B4A3176._id_B32599446F874D93) {
    if(!isDefined(icon)) {
      continue;
    }
    icon _id_1B390A39AC7EC281(targetteam, _id_C37B1CC67943336D);
  }
}

_id_08EDBA3D30393649(position, ignoreents) {
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  _id_90128D0639A1315D = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(position, 100, -150, contents);
  result = _id_2CEDCC356F1B9FC8::raytraceoffset(_id_90128D0639A1315D, 0, 0, 50, -125, contents, ignoreents);
  spawninfo = spawnStruct();
  spawninfo.origin = result["position"];
  angledelta = scripts\engine\math::anglebetweenvectors((0, 0, 1), result["normal"]);

  if(angledelta <= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C2C0C51679AA5A4F)
    spawninfo.angles = generateaxisanglesfromupvector(result["normal"], (0, 0, 0));
  else
    spawninfo.angles = (0, 0, 0);

  return spawninfo;
}

_id_AEE3A8BE63DB5997(player) {
  _id_BD935443ADCD6F9C = player scripts\cp_mp\challenges::_id_3D871E989C0BDB6D();
  return _id_BD935443ADCD6F9C || level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_52EDD3735575F1CB;
}

_id_AF54A33C2AC9A71F(player, _id_27DE1507ED41F01E) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) || !isPlayer(player))
    return 0;

  foreach(_id_C0414F532C535578 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) {
    if(!isDefined(_id_C0414F532C535578[_id_27DE1507ED41F01E]) || !isDefined(_id_C0414F532C535578[_id_27DE1507ED41F01E].player) || !isPlayer(_id_C0414F532C535578[_id_27DE1507ED41F01E].player)) {
      continue;
    }
    if(_id_C0414F532C535578[_id_27DE1507ED41F01E].player == player)
      return 1;
  }

  return 0;
}

_id_93B029FA699BD0CC(team, _id_EF58AD6EC803BFB7) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[team]) || !isDefined(_id_EF58AD6EC803BFB7))
    return 0;

  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(_id_27DE1507ED41F01E in _id_EF58AD6EC803BFB7) {
    _id_2C5BAEC4506566D5 = 0;

    foreach(player in _id_6D5ED003AF1F9612) {
      if(!isDefined(player)) {
        continue;
      }
      if(_id_AF54A33C2AC9A71F(player, _id_27DE1507ED41F01E))
        _id_2C5BAEC4506566D5 = 1;
    }

    if(!_id_2C5BAEC4506566D5)
      return 0;
  }

  return 1;
}

_id_C2EF2A31F608BD68(_id_69E96A4CAA72D794) {
  if(!_id_69E96A4CAA72D794 _id_5FACFBEE97E1A98E())
    return 0;

  state = _id_69E96A4CAA72D794 _id_E5E7DF17C00CA60B();

  if(state == "active_and_closed" || state == "active_and_open" || state == "opening")
    return 1;

  return 0;
}

_id_CC32274AF7105ABB() {
  _id_DB62C0CFC8A661CC = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB == 2 || level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB == 3)
    thread _id_A0C5C7BD3E5A9430();

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB == 3) {
    _id_7F81056A779B4777 = _id_96A1620D901981D1(0, 6);
    _id_922091E401D2375B = _id_96A1620D901981D1(1, 6);
    _id_DB62C0CFC8A661CC _id_F9C0E192946C2B4D(_id_6844602F3120E900(_id_7F81056A779B4777, 7));
    _id_DB62C0CFC8A661CC _id_F421381F1379BC3C(_id_922091E401D2375B);
  }

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB == 2)
    _id_DB62C0CFC8A661CC _id_F421381F1379BC3C(_id_96A1620D901981D1(0, 6));
  else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB == 1)
    _id_DB62C0CFC8A661CC thread _id_D1A420C02864991A();
  else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB == 0)
    _id_DB62C0CFC8A661CC _id_6A6B4D717EC3582E();
  else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB == 4) {
    thread _id_F77BCF971718B230();
    _id_DB62C0CFC8A661CC thread _id_6015E54691824443();
  }

  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
}

_id_F77BCF971718B230() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  circle = 0;

  for(;;) {
    success = _id_593F3AE1C539DC69(circle);

    if(!istrue(success)) {
      _id_9C74CCDAA1E15C02("circle_close");
      return;
    }

    if(istrue(success) && circle == level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F07DDDD68D0CBCD8)
      _id_C4516DCF97C05302();

    level waittill("br_circle_set");
    circle++;
  }
}

_id_593F3AE1C539DC69(circleindex) {
  success = 1;
  _id_7C5F25DF310107D4 = _id_F584D115CB4C5860();

  if(circleindex == _id_7C5F25DF310107D4)
    success = _id_D2EFEF69FF2AAE7B();

  return success;
}

_id_A0C5C7BD3E5A9430() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  circle = 0;

  for(;;) {
    success = _id_3ABD98401A0EDF89(circle);

    if(!istrue(success)) {
      _id_9C74CCDAA1E15C02("circle_close");
      return;
    }

    if(istrue(success) && circle == level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F07DDDD68D0CBCD8)
      _id_C4516DCF97C05302();

    level waittill("br_circle_set");
    circle++;
  }
}

_id_3ABD98401A0EDF89(circleindex) {
  _id_7C5F25DF310107D4 = _id_F584D115CB4C5860();
  success = 1;

  if(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size == 3) {
    _id_89482557D24C6D81 = 2;
    _id_6197E0CFF49F50FF = 1;
  } else {
    _id_89482557D24C6D81 = 1;
    _id_6197E0CFF49F50FF = 0;
  }

  if(circleindex == 1 && level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size == 3) {
    _id_D587D06C0FEDE8C8(circleindex);
    return success;
  }

  if(circleindex > 0) {
    _id_D587D06C0FEDE8C8(circleindex);
    success = _id_8EDD1A973F8E9C57(circleindex, _id_7C5F25DF310107D4, _id_89482557D24C6D81, _id_6197E0CFF49F50FF);
  }

  if(circleindex == _id_7C5F25DF310107D4)
    success = _id_D2EFEF69FF2AAE7B();

  return success;
}

_id_F584D115CB4C5860() {
  if(_id_58F20490049AF6AC::_id_D987886BB9DE9137() <= 1)
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DC6FDA0FBC9FE1E9;

  if(!_id_58F20490049AF6AC::_id_49411683F5A51DAA(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_21AA92004DD32D05))
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_21AA92004DD32D05;

  return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DC6FDA0FBC9FE1E9;
}

_id_D587D06C0FEDE8C8(circleindex) {
  level notify("flow_update_timers");
  _id_27DE1507ED41F01E = _id_96A1620D901981D1(circleindex - 1, 6);

  if(isDefined(_id_27DE1507ED41F01E)) {
    level._id_C83AA9DBC3654AFA._id_BCE3837DC67D6F25 = [];
    _id_CD9862AF0CD53429 = _id_2695A20D4011076D::getcircleclosetime(circleindex - 1);
    _id_641A4A6BE91674D0 = _id_2695A20D4011076D::getcircleclosetime(circleindex);
    thread _id_69EE75A3EEA2AC03(_id_27DE1507ED41F01E, int(_id_641A4A6BE91674D0 - _id_CD9862AF0CD53429));
  } else
    level._id_C83AA9DBC3654AFA._id_BCE3837DC67D6F25 = undefined;
}

_id_69EE75A3EEA2AC03(_id_27DE1507ED41F01E, timer, team, _id_6C0954D8D0416746) {
  level endon("game_ended");
  level endon("flow_update_timers");
  _id_792ED6BAA73AE134 = int(timer);
  _id_F1FB762D15F78344 = 0;

  while(_id_792ED6BAA73AE134 > 0) {
    if(!_id_66C05A319972D8DC()) {
      wait 1.0;
      _id_792ED6BAA73AE134--;
      continue;
    }

    if(isDefined(team))
      level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[team]._id_8DFD9E71543B605B[_id_27DE1507ED41F01E] = _id_792ED6BAA73AE134;
    else
      level._id_C83AA9DBC3654AFA._id_BCE3837DC67D6F25[_id_27DE1507ED41F01E] = _id_792ED6BAA73AE134;

    if(_id_792ED6BAA73AE134 <= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29258DCC063EEC7F) {
      if(!isDefined(team))
        _id_20238D522C76FB01(_id_792ED6BAA73AE134, _id_F1FB762D15F78344);
      else
        level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[team] _id_56EE84F1B091647A(_id_792ED6BAA73AE134, _id_F1FB762D15F78344);
    }

    wait 1.0;
    _id_F1FB762D15F78344 = istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_11027E0991067FAA) && !_id_93B029FA699BD0CC(team, _id_6C0954D8D0416746);

    if(!_id_F1FB762D15F78344)
      _id_792ED6BAA73AE134--;
  }
}

_id_8EDD1A973F8E9C57(circleindex, _id_7C5F25DF310107D4, _id_89482557D24C6D81, _id_6197E0CFF49F50FF) {
  if(!_id_66C05A319972D8DC())
    return 0;

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(_id_DB62C0CFC8A661CC.state == 0) {
      continue;
    }
    _id_8C50F5B7B81E6E06 = _id_96A1620D901981D1(circleindex - _id_89482557D24C6D81, 6);

    if(isDefined(_id_8C50F5B7B81E6E06))
      _id_DB62C0CFC8A661CC _id_F9C0E192946C2B4D(_id_6844602F3120E900(_id_8C50F5B7B81E6E06, 7));

    _id_FCAB081D387E6E24 = _id_96A1620D901981D1(circleindex - _id_6197E0CFF49F50FF, 6);

    if(isDefined(_id_FCAB081D387E6E24) && circleindex != _id_7C5F25DF310107D4)
      _id_DB62C0CFC8A661CC _id_F421381F1379BC3C(_id_FCAB081D387E6E24);
  }

  return 1;
}

_id_D2EFEF69FF2AAE7B() {
  if(!_id_66C05A319972D8DC())
    return 0;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176))
    return 0;

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(_id_DB62C0CFC8A661CC.state == 0) {
      continue;
    }
    player = scripts\engine\utility::_id_53C4C53197386572(_id_DB62C0CFC8A661CC.owner, _id_DB62C0CFC8A661CC.champion);

    if(!isDefined(player)) {
      continue;
    }
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176 thread _id_29BB7DE765F0C591(player);
  }

  return 1;
}

_id_C4516DCF97C05302() {
  if(!_id_66C05A319972D8DC()) {
    return;
  }
  thread _id_1A640C4239148816();
}

_id_1A640C4239148816() {
  level endon("game_ended");
  level waittill("br_circle_started");
  setDvar("dvar_047D8674C992E098", 1);
  _id_2695A20D4011076D::_id_64AEDA8C8A4179C5(1);

  while(_id_66C05A319972D8DC())
    wait 0.1;

  _id_2695A20D4011076D::_id_64AEDA8C8A4179C5(0);
}

_id_D1A420C02864991A() {
  _id_DB62C0CFC8A661CC = self;
  level endon("game_ended");
  _id_DB62C0CFC8A661CC endon("on_end");

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855) {
    _id_9815D79AFE176D3E = _id_6844602F3120E900(_id_F7806D4CF24AACD3, 7);

    if(!isDefined(_id_9815D79AFE176D3E)) {
      break;
    }

    _id_DB62C0CFC8A661CC _id_F9C0E192946C2B4D(_id_9815D79AFE176D3E);
    _id_5282D6616A31530E(_id_DB62C0CFC8A661CC, _id_6844602F3120E900(_id_F7806D4CF24AACD3, 6) + 1);
    _id_DB62C0CFC8A661CC waittill("element_pickup_first");
  }

  level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176 _id_29BB7DE765F0C591(_id_DB62C0CFC8A661CC.champion);
}

_id_5282D6616A31530E(_id_DB62C0CFC8A661CC, _id_C36FC01475B3A4C9) {
  if(_id_C36FC01475B3A4C9 >= level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size) {
    return;
  }
  _id_27DE1507ED41F01E = _id_96A1620D901981D1(_id_C36FC01475B3A4C9, 6);
  _id_DB62C0CFC8A661CC _id_F421381F1379BC3C(_id_27DE1507ED41F01E);
}

_id_6015E54691824443() {
  _id_DB62C0CFC8A661CC = self;
  level endon("game_ended");
  _id_DB62C0CFC8A661CC endon("on_end");
  _id_8418B247828B695C = [];

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855) {
    if(!isDefined(level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B[_id_F7806D4CF24AACD3])) {
      break;
    }

    _id_69EE75A3EEA2AC03(_id_F7806D4CF24AACD3, int(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29258DCC063EEC7F), _id_DB62C0CFC8A661CC.targetteam, _id_8418B247828B695C);
    _id_9815D79AFE176D3E = _id_6844602F3120E900(_id_F7806D4CF24AACD3, 7);
    _id_DB62C0CFC8A661CC _id_F9C0E192946C2B4D(_id_9815D79AFE176D3E);
    _id_DB62C0CFC8A661CC waittill("element_pickup_first");
    _id_8418B247828B695C[_id_8418B247828B695C.size] = _id_F7806D4CF24AACD3;
  }
}

_id_F9C0E192946C2B4D(_id_7F2F4EB2E503984F) {
  _id_DB62C0CFC8A661CC = self;
  _id_27DE1507ED41F01E = _id_96A1620D901981D1(_id_7F2F4EB2E503984F, 7);

  if(isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105) && isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_DB62C0CFC8A661CC.targetteam]) && isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_DB62C0CFC8A661CC.targetteam][_id_27DE1507ED41F01E])) {
    return;
  }
  _id_C229D93C0BB4F8E8 = _id_DB62C0CFC8A661CC _id_90204FE09C3DDB14();

  if(!isDefined(_id_C229D93C0BB4F8E8)) {
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("container_spawn_failed");
    return;
  }

  _id_69E96A4CAA72D794 = _id_2EB30DCE28E6A061(_id_7F2F4EB2E503984F, _id_DB62C0CFC8A661CC.targetteam, _id_C229D93C0BB4F8E8.origin, _id_C229D93C0BB4F8E8.angles);

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105))
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105 = [];

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_DB62C0CFC8A661CC.targetteam]))
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_DB62C0CFC8A661CC.targetteam] = [];

  level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_DB62C0CFC8A661CC.targetteam][_id_27DE1507ED41F01E] = _id_69E96A4CAA72D794;
  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
}

_id_90204FE09C3DDB14() {
  _id_DB62C0CFC8A661CC = self;
  _id_91385DBD7A09A5CC = 0;

  while(_id_91385DBD7A09A5CC <= 2) {
    _id_49D57C14E962F312 = _id_DB62C0CFC8A661CC _id_50B388AA83AECA2C();
    _id_BCB418497D44610B = _id_CA6C0350AC3A2550(_id_49D57C14E962F312, _id_91385DBD7A09A5CC);

    if(_id_BCB418497D44610B.size == 0) {
      _id_91385DBD7A09A5CC++;
      continue;
    }

    _id_CF876CD1A06753F5 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7846374C36699FD8 * getdvarfloat("dvar_11508C2017D016A5", 1.0);
    _id_C229D93C0BB4F8E8 = _id_1780902700581723(_id_BCB418497D44610B, _id_CF876CD1A06753F5);

    if(!isDefined(_id_C229D93C0BB4F8E8)) {
      _id_91385DBD7A09A5CC++;
      continue;
    }

    return _id_C229D93C0BB4F8E8;
  }

  return undefined;
}

_id_D26703EF0BDC9106() {
  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_52EDD3735575F1CB))
    return 1;

  if(isDefined(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_60EA877E814EE1A8) && level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_60EA877E814EE1A8 > 0.0) {
    _id_2BF3C98575BA0BE1 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_60EA877E814EE1A8 / 100.0;
    maxplayers = getdvarint("party_maxplayers");
    _id_69BA742900B5B3A2 = maxplayers * _id_2BF3C98575BA0BE1;

    if(level.totalplayers < _id_69BA742900B5B3A2) {
      _id_715028F54BAD19A1::_id_77814C1B523FD8A3(level.totalplayers);
      return 0;
    }
  }

  return 1;
}

_id_722929515E5A34B9() {
  level endon("game_ended");

  if(!_id_D0D49CA3928FB0B8()) {
    return;
  }
  _id_EF0D52837C9E7954();

  if(!_id_D26703EF0BDC9106()) {
    return;
  }
  thread _id_11473D63DAECBF48();

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_F198C878F78DD4AB))
    level._id_C83AA9DBC3654AFA._id_F198C878F78DD4AB = 0;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22))
    level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_91B307624076699A; _id_AC0E594AC96AA3A8++) {
    _id_EE6EA77813E3C559 = _id_E82DCF1F570A836E();

    if(!isDefined(_id_EE6EA77813E3C559)) {
      break;
    }

    if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A))
      level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A = [];

    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A[level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A.size] = _id_EE6EA77813E3C559;
  }

  _id_CD4CE58BE10FB51D();
}

_id_EF0D52837C9E7954() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(istrue(level._id_C62D39D6E6AFB119)) {
    while(!isDefined(level._id_F1073FBD45B59A06) || !istrue(level._id_F1073FBD45B59A06._id_9B87FDB80920F442))
      waitframe();
  }

  waitframe();
}

_id_D0D49CA3928FB0B8() {
  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.disabled))
    return 0;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F5EFF9E11A2D9B7E))
    return 0;

  return 1;
}

_id_E82DCF1F570A836E() {
  _id_EA156F5F477A8792 = getlootspawnpointcount();

  if(_id_EA156F5F477A8792 == 0) {
    return;
  }
  _id_CEE815921523C7DB = randomint(_id_EA156F5F477A8792);
  currentindex = _id_CEE815921523C7DB;

  for(;;) {
    _id_D67C5BBB1609D037 = getlootspawnpoint(currentindex);

    if(_id_5C6AD7C2954A522C(_id_D67C5BBB1609D037)) {
      break;
    } else {
      currentindex = (currentindex + 1) % _id_EA156F5F477A8792;

      if(currentindex == _id_CEE815921523C7DB)
        return;
    }
  }

  _id_EE6EA77813E3C559 = _id_3FF56F0BA058501A(_id_D67C5BBB1609D037.origin, _id_D67C5BBB1609D037.angles);
  disablelootspawnpoint(currentindex);
  return _id_EE6EA77813E3C559;
}

_id_3FF56F0BA058501A(origin, angles) {
  _id_3F9147D423834FC2 = spawn("script_model", origin);
  _id_3F9147D423834FC2 setModel("offhand_2h_wm_briefcase_bomb_v0_nuke");
  _id_3F9147D423834FC2 playLoopSound("iw9_br_elite_contract_attract_lp");
  _id_3F9147D423834FC2.angles = angles;
  _id_3F9147D423834FC2 scripts\common\utility::_id_57257D1ED9CE2F48(::_id_CABC7D4E59B3D20A);
  _id_EE6EA77813E3C559 = _id_64ACB6CE534155B7::_id_FE5D4D0A6A530B1E("elite_arrow", origin, angles);
  _id_EE6EA77813E3C559._id_B8EBE3F71A08AB40._id_3F9147D423834FC2 = _id_3F9147D423834FC2;
  _id_3F9147D423834FC2._id_B8EBE3F71A08AB40 = _id_EE6EA77813E3C559._id_B8EBE3F71A08AB40;
  return _id_EE6EA77813E3C559;
}

_id_5C6AD7C2954A522C(_id_BEFF9366F458CCC3) {
  if(!_func_A59E04A186FEDA43(_id_BEFF9366F458CCC3.index) || _id_BEFF9366F458CCC3.game_extrainfo == 1)
    return 0;

  if(issubstr(_id_BEFF9366F458CCC3._id_319F74ED8FA1A512, "small"))
    return 0;

  if(_id_362C58E8BB39BCDA::isfeatureenabled("circle") && istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_336CBBA00B3C960C)) {
    _id_2675FAEEF715C28B = _id_58F20490049AF6AC::_id_03E0A90B32E551AD(_id_BEFF9366F458CCC3.origin);
    _id_84697B290AFA1BFA = _id_2695A20D4011076D::_id_E55C19338F6E9E0C(1);

    if(_id_84697B290AFA1BFA < _id_2675FAEEF715C28B)
      return 0;
  }

  if(_id_4948CDF739393D2D::_id_F59F68ADC71D49B3(_id_BEFF9366F458CCC3.origin))
    return 0;

  return 1;
}

_id_11473D63DAECBF48() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("infil_animatic_complete");
  wait 1.5;
  _id_4324D3F629EBB9C8 = [];

  foreach(player in level.players) {
    if(_id_AEE3A8BE63DB5997(player)) {
      if(!istrue(_id_4324D3F629EBB9C8[player.team])) {
        _id_4324D3F629EBB9C8[player.team] = 1;
        scripts\mp\hud_util::showsplashtoteam(player.team, "elite_arrow_available");
      }
    }
  }
}

_id_4FB72C0C86F7746F() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  circle = 0;

  for(;;) {
    _id_A2530C94DC7FDCBC(circle);
    level waittill("br_circle_set");
    circle++;
  }
}

_id_A2530C94DC7FDCBC(circleindex) {
  if(circleindex >= 2) {
    _id_259DD894CBA599E8();
    level._id_C83AA9DBC3654AFA._id_60982E3AE30BBD22 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_85EE4754325BC510;
  }
}

_id_259DD894CBA599E8() {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A)) {
    return;
  }
  foreach(tablet in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A) {
    if(!isDefined(tablet)) {
      continue;
    }
    tablet._id_B8EBE3F71A08AB40 _id_3912F25D2EAD337E();
    tablet thread _id_64ACB6CE534155B7::tablethide();
  }
}

_id_3912F25D2EAD337E() {
  _id_B8EBE3F71A08AB40 = self;

  if(isDefined(_id_B8EBE3F71A08AB40._id_3F9147D423834FC2)) {
    _id_B8EBE3F71A08AB40._id_3F9147D423834FC2 delete();
    _id_B8EBE3F71A08AB40._id_3F9147D423834FC2 = undefined;
  }
}

_id_15D7B4838D344C81() {
  player = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A)) {
    return;
  }
  foreach(tablet in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A) {
    if(!isDefined(tablet)) {
      continue;
    }
    tablet._id_B8EBE3F71A08AB40._id_3F9147D423834FC2 hidefromplayer(player);
    tablet disablescriptableplayeruse(player);
  }
}

_id_16D299FC7942BA3D(team) {
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(team, "players");

  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A)) {
    return;
  }
  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player))
      player _id_15D7B4838D344C81();
  }
}

_id_CD4CE58BE10FB51D() {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A)) {
    return;
  }
  foreach(player in level.players) {
    if(_id_AEE3A8BE63DB5997(player)) {
      player _id_1B94D19475863421();
      continue;
    }

    player _id_15D7B4838D344C81();
  }
}

_id_1B94D19475863421() {
  player = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A)) {
    return;
  }
  foreach(tablet in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A) {
    if(!isDefined(tablet)) {
      continue;
    }
    tablet._id_B8EBE3F71A08AB40._id_3F9147D423834FC2 showtoplayer(player);
    tablet enablescriptableplayeruse(player);
  }
}

_id_CABC7D4E59B3D20A() {
  _id_3F9147D423834FC2 = self;
  _id_B8EBE3F71A08AB40 = _id_3F9147D423834FC2._id_B8EBE3F71A08AB40;
  _id_B8EBE3F71A08AB40 _id_3912F25D2EAD337E();
  _id_B8EBE3F71A08AB40.tablet thread _id_64ACB6CE534155B7::tablethide();
  return 0;
}

_id_0CCE93D9EDEF517A() {
  _id_B8EBE3F71A08AB40 = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC))
    level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC = [];

  _id_DB62C0CFC8A661CC = spawnStruct();
  _id_DB62C0CFC8A661CC.state = 1;
  _id_DB62C0CFC8A661CC._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_DB62C0CFC8A661CC.targetteam = _id_B8EBE3F71A08AB40.targetteam;
  _id_DB62C0CFC8A661CC.champion = _id_B8EBE3F71A08AB40._id_0D154AC2657C5F44;
  _id_DB62C0CFC8A661CC.owner = _id_B8EBE3F71A08AB40._id_0D154AC2657C5F44;
  _id_DB62C0CFC8A661CC._id_546E0DB97A2C9D12 = undefined;
  _id_DB62C0CFC8A661CC._id_3451FA20079DE642 = 0;
  _id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D = 0;
  _id_DB62C0CFC8A661CC._id_8DFD9E71543B605B = [];
  level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_B8EBE3F71A08AB40.targetteam] = _id_DB62C0CFC8A661CC;
  _id_DB62C0CFC8A661CC thread _id_E10C95ED3EF9E1DD();
}

_id_B141B13225E7B0FE(success) {
  _id_DB62C0CFC8A661CC = self;
  _id_6C05BD253D4AE324(_id_DB62C0CFC8A661CC.targetteam);
  _id_C2CE67F5903927AF(_id_DB62C0CFC8A661CC.targetteam);
  _id_AA6BA140692B3197(_id_DB62C0CFC8A661CC.targetteam);
  _id_A0A60C2DF22298D9(_id_DB62C0CFC8A661CC.targetteam, 0);
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(isDefined(_id_B5111CD83B4A3176._id_404971775E931566))
    _id_B5111CD83B4A3176._id_404971775E931566 _id_3AE40BB839DC4AEA(_id_DB62C0CFC8A661CC.targetteam, 0);

  if(isDefined(_id_B5111CD83B4A3176._id_6F92F4592E6847E9))
    _id_B5111CD83B4A3176._id_6F92F4592E6847E9 _id_3AE40BB839DC4AEA(_id_DB62C0CFC8A661CC.targetteam, 1);

  if(istrue(success))
    _id_DB62C0CFC8A661CC.state = 6;
  else
    _id_DB62C0CFC8A661CC.state = 0;
}

_id_E10C95ED3EF9E1DD() {
  _id_DB62C0CFC8A661CC = self;
  _id_DB62C0CFC8A661CC notify("team_info_watch");
  _id_DB62C0CFC8A661CC endon("team_info_watch");
  _id_DB62C0CFC8A661CC endon("on_end");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(_id_DB62C0CFC8A661CC.owner)) {
      _id_DB62C0CFC8A661CC _id_1BAB1F08AFA8CAAE();
      wait 1.0;
      continue;
    }

    _id_401C3A2E68AAB0FD = _id_DB62C0CFC8A661CC.owner scripts\engine\utility::waittill_any_return_no_endon_death_3("death_or_disconnect", "br_team_fully_eliminated", "arrow_player_removed");

    if(!isDefined(_id_DB62C0CFC8A661CC._id_546E0DB97A2C9D12))
      _id_DB62C0CFC8A661CC._id_546E0DB97A2C9D12 = _id_DB62C0CFC8A661CC.owner.origin;

    _id_DB62C0CFC8A661CC _id_337EAE8F3C28FE1C();
    _id_DB62C0CFC8A661CC thread _id_1BAB1F08AFA8CAAE(_id_401C3A2E68AAB0FD);
  }
}

_id_337EAE8F3C28FE1C(_id_401C3A2E68AAB0FD) {
  _id_DB62C0CFC8A661CC = self;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_DB62C0CFC8A661CC.targetteam, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isalive(player) && player != _id_DB62C0CFC8A661CC.owner) {
      _id_DB62C0CFC8A661CC.owner = player;
      _id_DB62C0CFC8A661CC._id_546E0DB97A2C9D12 = undefined;
      return;
    }
  }

  _id_DB62C0CFC8A661CC.owner = undefined;
}

_id_1BAB1F08AFA8CAAE(_id_401C3A2E68AAB0FD) {
  _id_DB62C0CFC8A661CC = self;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_DB62C0CFC8A661CC.targetteam, "players");

  if(!isDefined(_id_401C3A2E68AAB0FD) || _id_401C3A2E68AAB0FD != "br_team_fully_eliminated") {
    foreach(player in _id_6D5ED003AF1F9612) {
      if(!isDefined(player.placementbonus))
        return;
    }
  }

  if(isDefined(_id_401C3A2E68AAB0FD) && _id_401C3A2E68AAB0FD == "arrow_player_removed")
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("team_empty", 0);
  else {
    _id_545A22B48CD677FA = undefined;

    if(isDefined(_id_DB62C0CFC8A661CC.owner) && isDefined(_id_DB62C0CFC8A661CC.owner.laststandattacker))
      _id_545A22B48CD677FA = _id_DB62C0CFC8A661CC.owner.laststandattacker.team;

    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("team_wiped", 0, _id_545A22B48CD677FA);
  }
}

_id_3797FC27DA5395C1() {
  level endon("br_ending_start");
  level waittill("team_won", _id_EC15CE3E7A9D1D86);

  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)) {
    return;
  }
  if(isDefined(_id_EC15CE3E7A9D1D86)) {
    foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
      if(!isDefined(_id_DB62C0CFC8A661CC) || !isDefined(_id_DB62C0CFC8A661CC._id_B8EBE3F71A08AB40) || _id_DB62C0CFC8A661CC.targetteam == _id_EC15CE3E7A9D1D86) {
        continue;
      }
      if(_id_DB62C0CFC8A661CC.state != 0 && _id_DB62C0CFC8A661CC.state != 6)
        _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("team_wiped", 0, _id_EC15CE3E7A9D1D86);
    }
  }
}

_id_77FB65AE3082871C() {
  active = 0;

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      continue;
    }
    if(_id_DB62C0CFC8A661CC.state >= 1)
      active++;
  }

  return active;
}

_id_50B388AA83AECA2C() {
  _id_DB62C0CFC8A661CC = self;

  if(isDefined(_id_DB62C0CFC8A661CC._id_546E0DB97A2C9D12))
    return _id_DB62C0CFC8A661CC._id_546E0DB97A2C9D12;

  return _id_DB62C0CFC8A661CC.owner.origin;
}

_id_CC850454568F09F9(_id_838778220EEDE9FC) {
  _id_DB62C0CFC8A661CC = self;
  _id_DB62C0CFC8A661CC.owner = _id_838778220EEDE9FC;
  _id_DB62C0CFC8A661CC._id_546E0DB97A2C9D12 = undefined;
  _id_DB62C0CFC8A661CC thread _id_E10C95ED3EF9E1DD();
}

_id_1A9EE6A7092D4536() {
  _id_DB62C0CFC8A661CC = self;

  foreach(state in _id_DB62C0CFC8A661CC _id_002E702BEA8F46BA()) {
    if(!(state == 3) || istrue(state >= 5 && state <= 8))
      return 0;
  }

  return 1;
}

_id_6C310980DF01AC73() {
  _id_7A5184F920A39079 = scripts\engine\utility::ter_op(level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855.size > 0 && level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855[0] == "gal", "brloot_elite_arrow_bombsite_delta", "brloot_elite_arrow_bombsite");
  _id_B5111CD83B4A3176 = spawnscriptable(_id_7A5184F920A39079, (0, 0, -5000), (0, 0, 0));
  _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("disabled");
  _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("blank", "arrow_bombsite_screen");
  _id_DEBE9FD67DD91A71 = [];

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B)
  _id_DEBE9FD67DD91A71[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] = 0;

  _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71 = _id_DEBE9FD67DD91A71;
  _id_B5111CD83B4A3176.enabled = 1;
  _id_B5111CD83B4A3176._id_48D6C5734103E2B0 = undefined;
  _id_B5111CD83B4A3176._id_B6AF7EF8B50C76EE = undefined;
  _id_B5111CD83B4A3176._id_DC0258A29DC9FAF1 = undefined;
  _id_B5111CD83B4A3176._id_27DB4EB198CD48B9 = undefined;
  _id_B5111CD83B4A3176._id_1CCF4918D7C10AD6 = undefined;
  _id_B5111CD83B4A3176._id_AD590A75663898F3 = undefined;
  _id_B5111CD83B4A3176._id_71DD48E6C8570392 = undefined;
  return _id_B5111CD83B4A3176;
}

_id_B51E8C52609285F0() {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 thread _id_EAF22A1A752CC819();
  _id_B5111CD83B4A3176 _id_4D6D1400D6DF4B2D();
  _id_B5111CD83B4A3176 _id_A5CBE340384AF146();
  _id_B5111CD83B4A3176 _id_50AE9CF898EC9BA2();
  _id_B5111CD83B4A3176 _id_2E031201711A99DE();
  _id_B5111CD83B4A3176 _id_2156C23E5AFC6D06();

  if(isDefined(_id_B5111CD83B4A3176._id_404971775E931566))
    _id_B5111CD83B4A3176._id_404971775E931566 thread _id_E9B71089684738A7(1);

  if(isDefined(_id_B5111CD83B4A3176._id_6F92F4592E6847E9))
    _id_B5111CD83B4A3176._id_6F92F4592E6847E9 thread _id_E9B71089684738A7(1);

  _id_B5111CD83B4A3176 waittill("death");

  if(_id_3B0BC758816BA092()) {
    _id_B5111CD83B4A3176._id_71DD48E6C8570392 = 1;
    _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("disabled");
    _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("disarmed", "arrow_bombsite_screen");
  } else
    _id_B5111CD83B4A3176 freescriptable();
}

_id_2156C23E5AFC6D06() {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 _id_231AAE2264CE7F2E();

  if(isDefined(_id_B5111CD83B4A3176._id_B32599446F874D93)) {
    foreach(icon in _id_B5111CD83B4A3176._id_B32599446F874D93) {
      if(!isDefined(icon)) {
        continue;
      }
      icon _id_231AAE2264CE7F2E();
    }
  }
}

_id_A4FC9A04B674A389(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part != "arrow_bombsite_body") {
    return;
  }
  [_id_3793828403C6873E, _id_F1CBC68C79EBF1EA] = instance _id_790EC5DC7D594C13(player);

  if(!isDefined(_id_F1CBC68C79EBF1EA) || !isDefined(player) || !isDefined(_id_3793828403C6873E)) {
    return;
  }
  instance _id_7C7D1CF55B40C047(player, _id_3793828403C6873E, _id_F1CBC68C79EBF1EA);
}

_id_790EC5DC7D594C13(player) {
  _id_B5111CD83B4A3176 = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team]))
    return [undefined, undefined];

  if(!_id_DD1EDDCB3A80416D(player))
    return [undefined, undefined];

  if(istrue(_id_B5111CD83B4A3176._id_27DB4EB198CD48B9) || istrue(_id_B5111CD83B4A3176._id_DC0258A29DC9FAF1))
    return [undefined, undefined];

  [_id_3793828403C6873E, _id_F1CBC68C79EBF1EA] = _id_C1A30DB229B1311D(player, 0);

  while(isDefined(_id_3793828403C6873E)) {
    if(_id_BC04F4B45CD80CF8(_id_96A1620D901981D1(_id_F1CBC68C79EBF1EA, 5)))
      return [_id_3793828403C6873E, _id_F1CBC68C79EBF1EA];

    [_id_3793828403C6873E, _id_F1CBC68C79EBF1EA] = _id_C1A30DB229B1311D(player, _id_3793828403C6873E + 1);
  }

  return [undefined, undefined];
}

_id_7C7D1CF55B40C047(player, _id_3793828403C6873E, _id_F1CBC68C79EBF1EA) {
  _id_B5111CD83B4A3176 = self;
  _id_27DE1507ED41F01E = _id_96A1620D901981D1(_id_F1CBC68C79EBF1EA, 5);

  if(isDefined(_id_B5111CD83B4A3176._id_B32599446F874D93)) {
    _id_B5111CD83B4A3176._id_B32599446F874D93[_id_27DE1507ED41F01E] _id_231AAE2264CE7F2E();
    _id_B5111CD83B4A3176._id_B32599446F874D93[_id_27DE1507ED41F01E] = undefined;
  }

  _id_B5111CD83B4A3176 thread _id_F92179DCF9D84BC9(player, _id_27DE1507ED41F01E, _id_3793828403C6873E);
  _id_B5111CD83B4A3176 thread _id_EAF22A1A752CC819(_id_27DE1507ED41F01E);
  player thread _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
  player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_3793828403C6873E, 1);
}

_id_1395E6FA844B959F(player) {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("depositing");
  wait 1.5;

  if(_id_B5111CD83B4A3176 _id_10451FCEDD4D3D6E()) {
    if(!player scripts\cp_mp\utility\inventory_utility::iscurrentweapon("briefcase_bomb_mp_nuke")) {
      _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("arm");
      _id_B5111CD83B4A3176 _id_3570EAA3344A147C();
    }
  } else {
    _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("deposit");
    _id_B5111CD83B4A3176 _id_A0DDAD612CBE0349();
  }
}

_id_0E5C04EDC3287E3F(_id_860BE8762B9AE62F, targetteam, _id_2B3FD4D618D33439) {
  _id_B5111CD83B4A3176 = self;

  if(istrue(_id_2B3FD4D618D33439))
    _id_967F19716AC6EDD6(!_id_860BE8762B9AE62F);

  if(isDefined(targetteam))
    _id_D0DBCA153B783912(_id_860BE8762B9AE62F, targetteam);
  else
    _id_967F19716AC6EDD6(_id_860BE8762B9AE62F);
}

_id_967F19716AC6EDD6(_id_860BE8762B9AE62F) {
  _id_B5111CD83B4A3176 = self;

  if(istrue(_id_860BE8762B9AE62F)) {
    foreach(player in level.players)
    _id_B5111CD83B4A3176 enablescriptableplayeruse(player);
  } else {
    foreach(player in level.players)
    _id_B5111CD83B4A3176 disablescriptableplayeruse(player);
  }
}

_id_D0DBCA153B783912(_id_860BE8762B9AE62F, targetteam) {
  _id_B5111CD83B4A3176 = self;

  if(istrue(_id_860BE8762B9AE62F)) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(targetteam, "players");

    foreach(player in _id_A6AB8D0FDA441DC2)
    _id_B5111CD83B4A3176 enablescriptableplayeruse(player);
  } else {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(targetteam, "players");

    foreach(player in _id_A6AB8D0FDA441DC2)
    _id_B5111CD83B4A3176 disablescriptableplayeruse(player);
  }
}

_id_1EE7685E35F26553(player) {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176.targetplayer = player;
  _id_B5111CD83B4A3176.targetteam = player.team;
}

_id_84C4D0A19073A1CA(alive) {
  _id_B5111CD83B4A3176 = self;

  if(!istrue(alive))
    return _id_B5111CD83B4A3176.targetplayer;

  _id_E2430B5731471962 = undefined;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_B5111CD83B4A3176.targetteam, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    if(!isDefined(_id_E2430B5731471962))
      _id_E2430B5731471962 = player;

    if(isalive(player) && !isbot(player))
      return player;
  }

  return _id_E2430B5731471962;
}

_id_3A3999F7F98A09BA() {
  _id_B5111CD83B4A3176 = self;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_B5111CD83B4A3176.targetteam, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player) && _id_B5111CD83B4A3176.targetplayer != player) {
      _id_B5111CD83B4A3176 _id_1EE7685E35F26553(player);
      return;
    }
  }

  _id_B5111CD83B4A3176.targetplayer = undefined;
}

_id_9AD2B2A571D4CDC9(_id_9B1941CB7354665E, partname) {
  _id_B5111CD83B4A3176 = self;

  if(!isDefined(partname))
    partname = "arrow_bombsite_body";

  _id_B5111CD83B4A3176 setscriptablepartstate(partname, _id_9B1941CB7354665E);
}

_id_E15F6A723C77F629(position) {
  contents = scripts\engine\trace::_id_B88B8BD51EA7FE24();
  result = _id_2CEDCC356F1B9FC8::raytraceoffset(position, 0, 0, 1000, -1000, contents);
  _id_27A7F36BDDDB2E67 = undefined;

  if(result["hittype"] != "hittype_none") {
    _id_27A7F36BDDDB2E67 = result["position"];
    _id_F18844A048881951 = max(0, _id_27A7F36BDDDB2E67[2] - position[2]);
    return _id_F18844A048881951;
  }

  return 0;
}

_id_3D1149DBECB9E203(origin, angles) {
  _id_B5111CD83B4A3176 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_31C2E1A85FB84FB5 > 0) {
    _id_DE5538C1E87E6BF7 = getclosestpointonnavmesh(origin);

    if(isDefined(_id_DE5538C1E87E6BF7)) {
      _id_751FA541B7B026D1 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_31C2E1A85FB84FB5 * level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_31C2E1A85FB84FB5;

      if(distancesquared(_id_DE5538C1E87E6BF7, origin) <= _id_751FA541B7B026D1) {
        _id_463030CF175994A4 = (0, 0, 45);
        contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
        result = scripts\engine\trace::ray_trace(origin + _id_463030CF175994A4, _id_DE5538C1E87E6BF7 + _id_463030CF175994A4, undefined, contents);

        if(isDefined(result) && result["hittype"] == "hittype_none")
          origin = _id_DE5538C1E87E6BF7;
      }
    }
  }

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_218BC5767126BB7A > 0) {
    _id_447F40C814B97CDC = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.crate;
    _id_E5403EB19D281362 = _id_08EDBA3D30393649(origin, _id_447F40C814B97CDC);

    if(abs(_id_E5403EB19D281362.origin[2] - origin[2]) <= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_218BC5767126BB7A) {
      origin = _id_E5403EB19D281362.origin;
      angles = _id_E5403EB19D281362.angles;
    }
  }

  _id_B5111CD83B4A3176.origin = origin;
  _id_B5111CD83B4A3176.angles = angles;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6E608BE85A24080B > 0) {
    _id_F18844A048881951 = _id_E15F6A723C77F629(origin);

    if(_id_F18844A048881951 > level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6E608BE85A24080B)
      _id_9C74CCDAA1E15C02("bombsite_spawn_error");
  }

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_45B2296F6F91A215)) {
    if(scripts\mp\outofbounds::ispointinoutofbounds(origin))
      _id_9C74CCDAA1E15C02("bombsite_spawn_error");
  }
}

_id_38342968B751D11B(player) {
  _id_B5111CD83B4A3176 = self;
  spawnorigin = _id_BAD6109AC2AC3E6E(player);

  if(!isDefined(spawnorigin)) {
    _id_9C74CCDAA1E15C02("bombsite_spawn_error");
    return undefined;
  }

  return spawnorigin;
}

_id_BAD6109AC2AC3E6E(player) {
  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_4C57A2F7BB2C52B8 == 1)
    return _id_27A225332E2ECDAE();

  level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A = scripts\engine\utility::array_randomize(level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A);

  foreach(location in level._id_C83AA9DBC3654AFA._id_23AD176C11DD154A) {
    if(_id_58F20490049AF6AC::_id_A465E3C1371D7DAB(location))
      return location;
  }

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_4C57A2F7BB2C52B8 == 2)
    return _id_27A225332E2ECDAE();

  return undefined;
}

_id_27A225332E2ECDAE() {
  origin = _id_2695A20D4011076D::getnextsafecircleorigin();

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_FFF72F4D008B3EA6 < 0)
    return origin;

  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  result = scripts\engine\trace::ray_trace(origin + (0, 0, 3000), origin, undefined, contents);
  location = scripts\engine\utility::ter_op(result["fraction"] == 1, origin, result["position"]);
  location = getclosestpointonnavmesh(location, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_FFF72F4D008B3EA6);
  radius = _id_2695A20D4011076D::getnextsafecircleradius();

  if(distance2dsquared(origin, location) < radius * radius)
    origin = location;

  return origin;
}

_id_07E1FE16D6E3919A(_id_B32599446F874D93, _id_DCFF63A4D06F32D3, _id_AE52C3C4A761FB73) {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 _id_68EF3E106AB2D16B(undefined, _id_B5111CD83B4A3176.targetteam, "hud_icon_objective_elite_radioactive", "hud_icon_objective_elite_radioactive_red");
  _id_1E2F2224127D2990 = vectorNormalize(anglestoup(_id_B5111CD83B4A3176.angles)) * 35;
  _id_B5111CD83B4A3176 _id_3B7130B58A7C77B3("ground", _id_B5111CD83B4A3176, istrue(_id_DCFF63A4D06F32D3), istrue(_id_AE52C3C4A761FB73), _id_1E2F2224127D2990);
  _id_B5111CD83B4A3176 _id_D05FD62000DDCFB3(_id_B32599446F874D93);
}

_id_D05FD62000DDCFB3(_id_B32599446F874D93) {
  _id_B5111CD83B4A3176 = self;

  if(!istrue(_id_B32599446F874D93)) {
    return;
  }
  _id_B5111CD83B4A3176._id_B32599446F874D93 = [];
  zoffset = 25;
  xoffset = -7;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71.size; _id_AC0E594AC96AA3A8++) {
    if(_id_B5111CD83B4A3176._id_DEBE9FD67DD91A71[_id_AC0E594AC96AA3A8] > 0) {
      continue;
    }
    _id_B5111CD83B4A3176._id_B32599446F874D93[_id_AC0E594AC96AA3A8] = spawnStruct();
    _id_B5111CD83B4A3176._id_B32599446F874D93[_id_AC0E594AC96AA3A8] _id_68EF3E106AB2D16B(undefined, _id_B5111CD83B4A3176.targetteam, "hud_icon_objective_elite_radioactive", undefined);
    _id_D2666395E6CF4732 = (xoffset, 0, zoffset);
    _id_B5111CD83B4A3176._id_B32599446F874D93[_id_AC0E594AC96AA3A8] _id_3B7130B58A7C77B3("ground", _id_B5111CD83B4A3176, 0, 0, _id_D2666395E6CF4732);
    xoffset = xoffset + 7;
  }
}

_id_32041F48A2A2E73C(player, _id_C37B1CC67943336D) {
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;
  _id_B5111CD83B4A3176 _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);

  if(isDefined(_id_B5111CD83B4A3176._id_B32599446F874D93)) {
    foreach(_id_8E829CA1FF49E752 in _id_B5111CD83B4A3176._id_B32599446F874D93)
    _id_8E829CA1FF49E752 _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);
  }
}

_id_EAF22A1A752CC819(_id_27DE1507ED41F01E) {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 notify("screen_update");
  _id_B5111CD83B4A3176 endon("screen_update");
  _id_B5111CD83B4A3176 endon("death");

  for(;;) {
    _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("blank", "arrow_bombsite_screen");

    if(istrue(_id_B5111CD83B4A3176._id_71DD48E6C8570392))
      _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("disarmed", "arrow_bombsite_screen");
    else if(istrue(_id_B5111CD83B4A3176._id_AD590A75663898F3)) {} else if(istrue(_id_B5111CD83B4A3176._id_27DB4EB198CD48B9))
      _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("armed", "arrow_bombsite_screen");
    else if(istrue(_id_B5111CD83B4A3176._id_DC0258A29DC9FAF1))
      _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("arming", "arrow_bombsite_screen");
    else {
      if(isDefined(_id_27DE1507ED41F01E)) {
        _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9(_id_6844602F3120E900(_id_27DE1507ED41F01E, 9), "arrow_bombsite_screen");
        _id_27DE1507ED41F01E = undefined;
      } else
        _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("deposit", "arrow_bombsite_screen");

      waitframe();

      foreach(tag, _id_F7806D4CF24AACD3 in _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71) {
        if(istrue(_id_F7806D4CF24AACD3)) {
          _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9(_id_6844602F3120E900(tag, 10), "arrow_bombsite_screen");
          waitframe();
        }
      }
    }

    wait 2.0;
  }
}

_id_29BB7DE765F0C591(player, _id_B32599446F874D93) {
  _id_B5111CD83B4A3176 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
  level endon("game_ended");
  _id_B5111CD83B4A3176 endon("on_end_bombsite");
  _id_DB62C0CFC8A661CC.state = 2;
  _id_566EBF0873178B74(&"BR_ELITE_BROKEN_ARROW/WAITING_BOMB");
  _id_20238D522C76FB01();

  if(istrue(_id_B5111CD83B4A3176._id_48D6C5734103E2B0)) {
    return;
  }
  _id_B5111CD83B4A3176._id_48D6C5734103E2B0 = 1;
  _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("deposit");
  _id_B5111CD83B4A3176 _id_1EE7685E35F26553(player);
  _id_B5111CD83B4A3176 thread _id_EAF22A1A752CC819();
  _id_B5111CD83B4A3176 scripts\common\utility::_id_57257D1ED9CE2F48(::_id_26F148B3E91E1FE9);
  spawnorigin = _id_38342968B751D11B(player);

  if(!isDefined(spawnorigin)) {
    return;
  }
  _id_25C7990B2F530CE2();
  _id_B5111CD83B4A3176 _id_8FC5A3E09E9F5078(spawnorigin, player);
  _id_518587A0C6C54232();
  _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_bombsite_reveal", 3.0, 1);
  _id_B5111CD83B4A3176._id_B6AF7EF8B50C76EE = 1;
  _id_B5111CD83B4A3176.spawntime = gettime();
  _id_B5111CD83B4A3176 _id_A0DDAD612CBE0349();
  _id_B5111CD83B4A3176 _id_176FE0789723E9BD(_id_B32599446F874D93);
  _id_5A414C2BDA5F666B(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AB283D0E7E66556F);
  _id_B5111CD83B4A3176 thread _id_A66A455D9266F65D();

  if(_id_DB62C0CFC8A661CC _id_1A9EE6A7092D4536()) {
    _id_DB62C0CFC8A661CC.state = 3;
    _id_566EBF0873178B74(&"BR_ELITE_BROKEN_ARROW/DEPOSIT_ELEMS");
  }

  _id_20238D522C76FB01();
  _id_5E7FDF58F111F041();
}

_id_25C7990B2F530CE2() {
  foreach(_id_5EC35B0D0E09922D, teamdata in level.teamdata) {
    if(_id_2EAC770CF8006E0B(_id_5EC35B0D0E09922D))
      scripts\mp\hud_util::showsplashtoteam(_id_5EC35B0D0E09922D, "elite_arrow_bomb_revealed");
  }
}

_id_518587A0C6C54232() {
  foreach(_id_5EC35B0D0E09922D, teamdata in level.teamdata) {
    if(!_id_2EAC770CF8006E0B(_id_5EC35B0D0E09922D))
      scripts\mp\hud_util::showsplashtoteam(_id_5EC35B0D0E09922D, "elite_arrow_bomb_revealed_global");
  }
}

_id_8FC5A3E09E9F5078(spawnorigin, player) {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  _id_B5111CD83B4A3176 endon("death");

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_E49836FBF89774A4)) {
    foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
      if(_id_DCC5F31EC71D6D8A.state == 0) {
        continue;
      }
      _id_DCC5F31EC71D6D8A _id_6AF5DED34F8C79BE();
    }

    _id_046CF752D93DC17B::_id_1A01863A6EC2AD05(spawnorigin, "br_elite_arrow_bombsite_drop");
    _id_B5111CD83B4A3176 thread _id_51890F7F9A9BF31C();
    _id_B5111CD83B4A3176 waittill("arrow_finish_bombsite_reveal");
  } else
    _id_B5111CD83B4A3176 _id_3D1149DBECB9E203(spawnorigin, player.angles);
}

_id_A0DDAD612CBE0349() {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(0);

  foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(_id_DCC5F31EC71D6D8A.state == 0) {
      continue;
    }
    _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(1, _id_DCC5F31EC71D6D8A.targetteam);
  }
}

_id_176FE0789723E9BD(_id_B32599446F874D93) {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 _id_07E1FE16D6E3919A(_id_B32599446F874D93, 1, 1);

  foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(_id_DCC5F31EC71D6D8A.state == 0) {
      continue;
    }
    _id_A0A60C2DF22298D9(_id_DCC5F31EC71D6D8A.targetteam, 1);
  }
}

_id_B0E82AAC43901AE6(player) {
  _id_B5111CD83B4A3176 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
  _id_DB62C0CFC8A661CC.state = 4;
  _id_B5111CD83B4A3176 _id_3570EAA3344A147C();
  _id_566EBF0873178B74(&"BR_ELITE_BROKEN_ARROW/ARM_THE_BOMB");
  _id_20238D522C76FB01();
  _id_5E7FDF58F111F041();

  if(istrue(_id_B5111CD83B4A3176._id_DC0258A29DC9FAF1)) {
    return;
  }
  _id_B5111CD83B4A3176._id_DC0258A29DC9FAF1 = 1;
  _id_B5111CD83B4A3176 thread _id_EAF22A1A752CC819();
  _id_B5111CD83B4A3176 _id_54D4FF342D2C322F(player);
}

_id_3570EAA3344A147C() {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(0);

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C42B7C38A37D8F06))
    _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(1);
  else {
    foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
      if(_id_DCC5F31EC71D6D8A.state == 0) {
        continue;
      }
      _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(1, _id_DCC5F31EC71D6D8A.targetteam);
    }
  }
}

_id_C0E9E9C23F5B3F14(player) {
  _id_B5111CD83B4A3176 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
  _id_DB62C0CFC8A661CC.state = 5;

  if(istrue(_id_B5111CD83B4A3176._id_27DB4EB198CD48B9)) {
    return;
  }
  _id_B5111CD83B4A3176._id_27DB4EB198CD48B9 = 1;
  _id_B5111CD83B4A3176 _id_9AD2B2A571D4CDC9("defuse");
  _id_B5111CD83B4A3176 thread _id_EAF22A1A752CC819();
  _id_0CD816464EB84955 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0CD816464EB84955;

  if(isDefined(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C6020D9F48812BED))
    _id_0CD816464EB84955 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C6020D9F48812BED;

  _id_57D38C13BED22262(_id_0CD816464EB84955, _id_DB62C0CFC8A661CC);
  _id_B5111CD83B4A3176 _id_C3DD1D53419783BE(_id_DB62C0CFC8A661CC);
  _id_B5111CD83B4A3176 _id_90056B14A57B07EE();
  _id_DB62C0CFC8A661CC _id_B63894955A03D82B(player);
  _id_B5111CD83B4A3176 _id_44A546D3987C1686();
  _id_B5111CD83B4A3176 _id_2156C23E5AFC6D06();
  _id_B5111CD83B4A3176 _id_4BFAC84A99F0DDBA(player);
  _id_259DD894CBA599E8();
}

_id_57D38C13BED22262(timer, _id_DB62C0CFC8A661CC) {
  _id_B5111CD83B4A3176 = self;
  _id_5A414C2BDA5F666B(timer);
  _id_B5111CD83B4A3176 thread _id_E035378C608F9511(int(timer - 1), 0.0);
  _id_DB62C0CFC8A661CC _id_5CF6AB54F8852B93(int(timer));
  _id_20238D522C76FB01();
  _id_5E7FDF58F111F041();
}

_id_C3DD1D53419783BE(_id_DB62C0CFC8A661CC) {
  _id_B5111CD83B4A3176 = self;

  foreach(otherteam in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(otherteam == _id_DB62C0CFC8A661CC) {
      continue;
    }
    otherteam thread _id_088A043B99A75E47("enemy_armed_bomb");
  }
}

_id_90056B14A57B07EE() {
  _id_B5111CD83B4A3176 = self;
  _id_085E53E70C7110DA = scripts\mp\music_and_dialog::_id_AECAFE54C65C0E35(level.players);
  _id_1933AEF6359F408C = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_elite_arrow_bomb_armed");
  _id_C3E230FDA23AD937 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_elite_arrow_bomb_armed_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(_id_085E53E70C7110DA, _id_1933AEF6359F408C, undefined, undefined, _id_C3E230FDA23AD937);
}

_id_B63894955A03D82B(player) {
  _id_DB62C0CFC8A661CC = self;
  scripts\mp\hud_util::showsplashtoteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_bomb_defend", undefined, player);
  scripts\mp\hud_util::showsplashtoallexceptteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_bomb_defuse", undefined, player);
}

_id_44A546D3987C1686() {
  _id_B5111CD83B4A3176 = self;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6B16473C9C8C32B2))
    _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(1);
  else
    _id_B5111CD83B4A3176 _id_0E5C04EDC3287E3F(0, _id_B5111CD83B4A3176.targetteam, 1);
}

_id_A66A455D9266F65D() {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  timer = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AB283D0E7E66556F;

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)
  _id_DB62C0CFC8A661CC _id_8BEF76D7D75916B6(timer);

  result = _id_B5111CD83B4A3176 scripts\engine\utility::waittill_any_timeout_2(timer, "arm_complete", "on_end_bombsite");

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)
  _id_DB62C0CFC8A661CC _id_9DE2E8C510281719();

  if(isDefined(result) && result == "timeout") {
    if(isDefined(_id_B5111CD83B4A3176._id_404971775E931566) && istrue(_id_B5111CD83B4A3176._id_404971775E931566.inuse)) {
      _id_A9B8FB5C0A14AF76 = _id_B5111CD83B4A3176._id_404971775E931566 scripts\engine\utility::waittill_any_return_2("trigger_success", "trigger_fail");

      if(_id_A9B8FB5C0A14AF76 == "trigger_success")
        return;
      else
        waitframe();
    }

    _id_9C74CCDAA1E15C02("bombsite_timed_out");
  }
}

_id_26F148B3E91E1FE9() {
  thread _id_9C74CCDAA1E15C02("bombsite_deleted_in_area_swap");
  return 1;
}

_id_5A414C2BDA5F666B(_id_246AEE6688CC8EAE) {
  level._id_C83AA9DBC3654AFA._id_FCDECE7735749A7E = int(gettime() + scripts\engine\utility::_id_A5B14435E3229BED(_id_246AEE6688CC8EAE));
}

_id_3FB6126945208E3E() {
  _id_FCDECE7735749A7E = scripts\engine\utility::_id_53C4C53197386572(level._id_C83AA9DBC3654AFA._id_FCDECE7735749A7E, gettime());
  _id_D83E59CC6FA3383D = max(0, _id_FCDECE7735749A7E - gettime());
  return int(_func_C5CF558181E12D1F(scripts\engine\utility::_id_C89ED1840C8D0F0F(_id_D83E59CC6FA3383D)));
}

_id_758F95FB5CF87D1B() {
  _id_B5111CD83B4A3176 = self;

  if(istrue(_id_B5111CD83B4A3176._id_1CCF4918D7C10AD6)) {
    return;
  }
  _id_B5111CD83B4A3176._id_1CCF4918D7C10AD6 = 1;
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C6020D9F48812BED = 7;
  player = _id_84C4D0A19073A1CA(1);

  if(_id_CE3E8C8B6DE2CA1B()) {
    if(_id_3FB6126945208E3E() <= 7) {
      return;
    }
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
    _id_B5111CD83B4A3176 _id_57D38C13BED22262(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C6020D9F48812BED, _id_DB62C0CFC8A661CC);
    _id_B5111CD83B4A3176 thread _id_0F7B9661A3753DA9(_id_B5111CD83B4A3176._id_6F92F4592E6847E9);
  } else
    _id_B5111CD83B4A3176 thread _id_C0E9E9C23F5B3F14(player);
}

_id_90692628E3F5A1C1() {
  dropstruct = self;
  dropstruct._id_2E0D8BA0A46CE1B1 = 1;
  dropstruct._id_3077F6D3D97BB34B = getdvarint("dvar_83026AE3DA184B2D", 1000);
  dropstruct._id_3C3ED534C61A56E4 = getdvarint("dvar_71B0625BA447D37A", 100);
  dropstruct._id_9612B650D147F458 = getdvarint("dvar_DDE9024816A0B75A", 200);
  dropstruct._id_81986B2D8E843970 = getdvarint("dvar_E4A0734D3E02BAC7", 562500);
  dropstruct._id_EB4187DD85E05B36 = 0;
  dropstruct._id_623DB0CC7C389A05 = 0;
  dropstruct._id_322B7887F80ACC62 = 1;
  dropstruct._id_F453AECD14B7F921 = 1;
}

_id_51890F7F9A9BF31C() {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  _id_B5111CD83B4A3176 endon("death");
  level waittill("arrow_bombsite_drop_landed");
  crate = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.crate;

  if(!isDefined(crate)) {
    return;
  }
  spawninfo = _id_08EDBA3D30393649(crate.origin, [crate]);
  _id_B5111CD83B4A3176 _id_3D1149DBECB9E203(spawninfo.origin, spawninfo.angles);
  _id_B5111CD83B4A3176 notify("arrow_finish_bombsite_reveal");
}

_id_8992A7892FE3A42C(_id_8EE83E2CBD3D747D) {
  _id_D4858C7C75F6AB04 = _id_8EE83E2CBD3D747D + (0, 0, level._id_5D2AF95280A3CF58);
  angles = (0, 0, 0);
  crate = scripts\cp_mp\killstreaks\airdrop::createcrate(undefined, undefined, "elite_arrow_bombsite", _id_D4858C7C75F6AB04, angles, _id_8EE83E2CBD3D747D, undefined, 1);
  crate _id_CE3306FAF9CCE45D();
  level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.crate = crate;
  crate scripts\common\utility::_id_57257D1ED9CE2F48(::_id_62173F65F7672DDC);
  return crate;
}

_id_CE3306FAF9CCE45D() {
  crate = self;
  crate _id_68EF3E106AB2D16B(undefined, undefined, "hud_icon_objective_elite_radioactive", undefined);

  foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)
  crate _id_1B390A39AC7EC281(_id_DCC5F31EC71D6D8A.targetteam, 1);

  crate _id_3B7130B58A7C77B3("player", crate, 0, 0);
}

_id_F2697D44D12A9E3E(player, _id_C37B1CC67943336D) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.crate)) {
    return;
  }
  crate = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.crate;
  crate _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);
}

_id_F19FDCE841E05D0D(_id_8EE83E2CBD3D747D, dropstruct) {
  crate = self;
  wait 2.0;
  crate _id_046CF752D93DC17B::_id_7DEC3B199D2E73B8(_id_8EE83E2CBD3D747D, dropstruct);
  endtime = gettime() + 20000;

  while(gettime() < endtime) {
    _id_212A44A5393C3B34 = crate physics_getbodyid(0);
    velocity = physics_getbodylinvel(_id_212A44A5393C3B34);

    if(lengthsquared(velocity) <= 0.5) {
      break;
    }

    waitframe();
  }

  wait 1.5;
  crate setscriptablepartstate("dmz_supply_drop", "fully_opening_unusable");
  crate _id_231AAE2264CE7F2E();

  if(isDefined(crate.smokesignal))
    crate.smokesignal delete();

  level notify("arrow_bombsite_drop_landed");
}

_id_62173F65F7672DDC() {
  thread _id_9C74CCDAA1E15C02("supply_drop_deleted_in_area_swap");
  return 1;
}

_id_E035378C608F9511(_id_0CD816464EB84955, delay) {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 notify("nuke_countdown");
  _id_B5111CD83B4A3176 endon("nuke_countdown");
  level endon("game_ended");
  _id_B5111CD83B4A3176 thread _id_ED670AA9479CC141(_id_0CD816464EB84955);
  level thread _id_659A7F8045916418(_id_0CD816464EB84955);

  if(isDefined(delay))
    wait(delay);

  starttime = gettime();
  endtime = _id_0CD816464EB84955 * 1000 + starttime;
  _id_B5111CD83B4A3176._id_F28399727742EB23 = endtime;
  _id_B5111CD83B4A3176 scripts\engine\utility::waittill_any_timeout_1(_id_0CD816464EB84955, "on_end_bombsite");
}

_id_818377520915C3CF(origin, soundalias, delay) {
  delay = scripts\engine\utility::_id_53C4C53197386572(delay, 0.0);
  wait(delay);
  ent = spawn("script_model", origin);
  ent forcenetfieldhighlod(1);
  waitframe();
  ent playLoopSound(soundalias);
  level scripts\engine\utility::waittill_any_timeout_2(39.9, "nuke_detonated");
  ent stoploopsound();
  waitframe();
  ent delete();
}

_id_659A7F8045916418(_id_0CD816464EB84955) {
  level endon("nuke_detonated");
  _id_10F6D49F1C8AB708[0] = [60.0, "mx_mp_elitecontracts_bombcountdown1", "mx_mp_elitecontracts_bomb_defuse_1"];
  _id_10F6D49F1C8AB708[1] = [61.4, "mx_mp_elitecontracts_bombcountdown2", "mx_mp_elitecontracts_bomb_defuse_2"];
  _id_10F6D49F1C8AB708[2] = [61.5, "mx_mp_elitecontracts_bombcountdown3", "mx_mp_elitecontracts_bomb_defuse_3"];
  _id_10F6D49F1C8AB708[3] = [61.3, "mx_mp_elitecontracts_bombcountdown4", "mx_mp_elitecontracts_bomb_defuse_4"];
  _id_10F6D49F1C8AB708[4] = [61.0, "mx_mp_elitecontracts_bombcountdown5", "mx_mp_elitecontracts_bomb_defuse_5"];
  _id_81C69DF4C998ED74 = randomint(_id_10F6D49F1C8AB708.size);
  _id_6958D396E4AD3B95 = _id_10F6D49F1C8AB708[_id_81C69DF4C998ED74][0];
  _id_9BF8C21598894A29 = _id_10F6D49F1C8AB708[_id_81C69DF4C998ED74][1];
  _id_DDF2F457E6F16FBC = _id_10F6D49F1C8AB708[_id_81C69DF4C998ED74][2];
  _id_761997000F163954 = _id_0CD816464EB84955 - _id_6958D396E4AD3B95 - 1.5;
  _id_C020952F2597D1E6 = "mx_mp_elitecontracts_bombcountdown1_classic";
  _id_A6C907E927ACB9C7 = "mx_mp_elitecontracts_bomb_defuse_1_classic";

  if(_id_761997000F163954 < 0) {
    return;
  }
  wait(_id_761997000F163954);
  _id_085E53E70C7110DA = scripts\mp\music_and_dialog::_id_AECAFE54C65C0E35(level.players);
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(_id_085E53E70C7110DA, _id_9BF8C21598894A29, undefined, undefined, _id_C020952F2597D1E6);
  level waittill("nuke_aborted");
  _id_085E53E70C7110DA = scripts\mp\music_and_dialog::_id_AECAFE54C65C0E35(level.players);
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(_id_085E53E70C7110DA, _id_DDF2F457E6F16FBC, undefined, undefined, _id_A6C907E927ACB9C7);
}

_id_ED670AA9479CC141(_id_0CD816464EB84955) {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  level endon("nuke_aborted");
  _id_D1969C7D1F084C73 = int(_id_0CD816464EB84955);
  _id_2C69CF9B20D1464A = _id_0CD816464EB84955 - _id_D1969C7D1F084C73;
  timer = _id_D1969C7D1F084C73;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_B5111CD83B4A3176.targetteam];
  wait(_id_2C69CF9B20D1464A);

  while(timer > 0) {
    soundalias = "";
    _id_C7EDA8C7EE5C0B46 = timer % 30;

    if(timer <= 60)
      _id_C7EDA8C7EE5C0B46 = timer % 10;

    if(timer == 31) {
      _id_12B397CBEAAB23B6 = (3456, 48128, 5760);
      thread _id_818377520915C3CF(_id_12B397CBEAAB23B6, "evt_br_nuke_siren_dist", 0);
      origin2 = (-52160, 5304, 5760);
      thread _id_818377520915C3CF(origin2, "evt_br_nuke_siren_dist", 3);
      _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_detonation_warning");
    }

    if(timer == 5) {
      _id_1930FFBBF1B6164E = _id_B5111CD83B4A3176.origin + (0, 0, 60);
      level thread _id_69AE8AB0C2DB4623(0.4);
      playsoundatpos(_id_1930FFBBF1B6164E, "evt_br_portable_nuke_detonation_plunger");
    }

    if(timer == 3)
      _id_7AB5B649FA408138::_id_4E8BA327EB12540C(level.players, "br_elite_contract_ending", 3.0);

    if(timer == 30 || timer == 20)
      soundalias = "evt_br_nuke_bomb_timer_urgent";
    else if(timer <= 10)
      soundalias = "evt_br_nuke_bomb_timer_urgent";
    else if(timer <= 30)
      soundalias = "evt_br_nuke_bomb_timer";
    else if(_id_C7EDA8C7EE5C0B46 == 0)
      soundalias = "evt_br_nuke_bomb_timer_reminder";

    if(soundalias != "")
      _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, soundalias);

    timer = timer - 1;
    wait 1.0;
  }
}

_id_102A65E0B585135B(_id_B5111CD83B4A3176) {
  _id_7AB5B649FA408138::_id_7ACDE5FEB50C98F2(level.players, "evt_br_elite_arrow_nuke_explo");
}

_id_B308A39503F00ABF() {
  _id_B5111CD83B4A3176 = self;
  level._id_57ECE26E490AD8C4 = 1;
  level.shownonspectatingwinnersplash = 1;
  level endon("game_ended");
  owner = _id_B5111CD83B4A3176 _id_84C4D0A19073A1CA();
  level.mercywintriggered = 1;
  streakinfo = _id_51F812F559785EE2(owner);
  _id_CCF25836CBFA32E4();
  level thread _id_102A65E0B585135B(_id_B5111CD83B4A3176);
  _id_B5111CD83B4A3176 _id_FD06A1BBF48D3FCA(owner, streakinfo);

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\player::_freezecontrols(1, undefined, "cq_nuke");
  }

  level._id_79C116F876DC27EB = ::_id_42D4AAFB1B78C3BA;
  level thread scripts\mp\gamelogic::endgame(owner.team, game["end_reason"]["nuke_end"], undefined, 1, 1);
}

_id_51F812F559785EE2(owner) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke", owner);
  streakinfo._id_3DABFA23BEF362B5 = 1;
  streakinfo.skipequippedstreakcheck = 1;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D25D8476EAF60724)) {
    streakinfo._id_93DBD6174CA50E88 = 1;
    streakinfo._id_9ED60D0D51F90D76 = 1;
    streakinfo._id_E723BC4541254543 = 1;
    streakinfo._id_FC46647C49FA8A11 = 1;
  }

  owner scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct(streakinfo);
  return streakinfo;
}

_id_CCF25836CBFA32E4() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player.ignoredeathsdoor = 1;
    player _id_2CEDCC356F1B9FC8::_id_179A8D5A185DFB56(1);
  }
}

_id_FD06A1BBF48D3FCA(owner, streakinfo) {
  _id_B5111CD83B4A3176 = self;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D25D8476EAF60724))
    _id_B5111CD83B4A3176 _id_0EE09E2CAAF92CAA(owner, streakinfo);
  else
    wait 7.5;
}

_id_0EE09E2CAAF92CAA(owner, streakinfo) {
  _id_B5111CD83B4A3176 = self;

  foreach(player in level.players) {
    if(!isPlayer(player) || !isalive(player)) {
      continue;
    }
    _id_477C1209E5432ABE = 0.0;
    _id_B5111CD83B4A3176 thread _id_71BDE23F6E0AA583(player, _id_477C1209E5432ABE, owner, streakinfo);
  }

  _id_19D232C72B0827E3();
}

_id_71BDE23F6E0AA583(player, _id_477C1209E5432ABE, owner, streakinfo) {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  player _id_36F999A7C7ED0D32(1, "nuke_champ_quest_flash", 0.1);
  wait 0.1;
  player _id_36F999A7C7ED0D32(1, "", 0.9);
  player _id_36F999A7C7ED0D32(1, "nuke_champ_quest_death", 0.9);
}

_id_19D232C72B0827E3() {
  wait 0.1;
  setomnvarforallclients("post_game_state", 11);
  wait 1.9;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.1);
  }
}

_id_42D4AAFB1B78C3BA(_id_03784E17637539B8, _id_F7B694A4EDF7DC9A) {
  level thread _id_5AEB021930CA58DE();
}

_id_5AEB021930CA58DE() {
  level endon("game_ended");
  wait 0.75;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_world_fade", 1.0);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.1);
  }
}

_id_E73CBD9A52431832() {
  setomnvarforallclients("post_game_state", 13);
  setomnvarforallclients("ui_br_bink_overlay_state", 13);

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    playcinematicforall("mp_br_elite_arrow_nuke_delta");
  else
    playcinematicforall("mp_br_elite_arrow_nuke_saba");
}

_id_F6E0BDD81A472B97(_id_03784E17637539B8) {
  _id_7AB5B649FA408138::_id_4E8BA327EB12540C(level.players, "mp_killstreak_nuke", 6.0);
  wait 6.1;
  _id_E73CBD9A52431832();
  wait 2.0;
  _id_8B24245302ADC601(_id_03784E17637539B8);
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 1);
  wait 5.0;
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 2);
  wait 2.0;

  if(!_id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch())
    setomnvarforallclients("ui_br_end_game_splash_type", 17);

  wait 1.0;
  setomnvarforallclients("post_game_state", 14);
  wait 10.0;
}

_id_8B24245302ADC601(winners) {
  _id_062C595D55B88B26::_id_74497A0F417E329F(winners);
  _id_5C6B989A6F25F7FA::_id_226B83F846D32FF2(winners);
}

_id_9E8981EF0C238DD0() {
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  lootid = level.br_pickups._id_7B2BFF2D04EE1017["brloot_plunder_cash_uncommon_1"];

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
    if(isDefined(lootid)) {
      _id_FBB5190911C15C1B = _id_F0EA4030349A33D5 getvieworigin();
      _id_F0EA4030349A33D5 _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, _id_FBB5190911C15C1B, 1, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_41DF90BB27AA4B6F);
    }

    _id_F0EA4030349A33D5 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_4EBC44521D9A1B18");
    _id_F0EA4030349A33D5 _id_6AFF3948CF4CCA03::playerplunderpickup(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_41DF90BB27AA4B6F);
  }
}

_id_E01BC5DBA2DA7D6A(victim) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[victim.team])) {
    return;
  }
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[victim.team];
  _id_492CB44147FCF2CE = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_895D3E780C654E27;
  _id_C8A8CADCFBFF950A = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B01D54F0EA63BFB3;

  if(_id_DB62C0CFC8A661CC.state == 5) {
    _id_492CB44147FCF2CE = _id_492CB44147FCF2CE * level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A1C716E522C46B09;
    _id_C8A8CADCFBFF950A = _id_C8A8CADCFBFF950A + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B983F90AB46B22A6 * 5;
  } else {
    _id_E10C02E90A53AC61 = _id_DB62C0CFC8A661CC._id_3451FA20079DE642;

    if(_id_DB62C0CFC8A661CC.state == 4)
      _id_E10C02E90A53AC61++;

    _id_492CB44147FCF2CE = _id_492CB44147FCF2CE * (1 + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_36B827B9C3105FDB * _id_E10C02E90A53AC61);
    _id_C8A8CADCFBFF950A = _id_C8A8CADCFBFF950A + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B983F90AB46B22A6 * _id_E10C02E90A53AC61;
  }

  lootid = level.br_pickups._id_7B2BFF2D04EE1017["brloot_plunder_cash_uncommon_1"];

  if(isDefined(lootid)) {
    _id_FBB5190911C15C1B = self getvieworigin();
    _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, _id_FBB5190911C15C1B, 1, _id_C8A8CADCFBFF950A);
  }

  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8677B7BA02F174E2", undefined, undefined, _id_492CB44147FCF2CE);
  _id_6AFF3948CF4CCA03::playerplunderpickup(_id_C8A8CADCFBFF950A);
}

_id_54D4FF342D2C322F(player) {
  _id_B5111CD83B4A3176 = self;
  usetime = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.armtime;
  decayrate = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DD475D11757AD803;
  _id_A76969DCC6F15D80 = [];
  _id_B5111CD83B4A3176._id_404971775E931566 = _id_FFA4B010CB5F82DC(_id_B5111CD83B4A3176, "elite_arrow_arm", usetime, decayrate, _id_A76969DCC6F15D80, player);
  _id_B5111CD83B4A3176._id_404971775E931566._id_6A95B711C7C0C9B4 = ::_id_BC1ADD9D6B949CDC;
  _id_B5111CD83B4A3176 _id_01CA195A0E80A83B();
  _id_B5111CD83B4A3176 thread _id_CD7C81FD616E8339(_id_B5111CD83B4A3176._id_404971775E931566);
}

_id_01CA195A0E80A83B() {
  _id_B5111CD83B4A3176 = self;

  if(!isDefined(_id_B5111CD83B4A3176._id_404971775E931566)) {
    return;
  }
  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C42B7C38A37D8F06)) {
    foreach(player in level.players)
    _id_B5111CD83B4A3176._id_404971775E931566 _id_F025BE1CBF898D23(player, 1);
  } else {
    foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
      if(_id_DCC5F31EC71D6D8A.state == 0) {
        continue;
      }
      _id_B5111CD83B4A3176._id_404971775E931566 _id_3AE40BB839DC4AEA(_id_DCC5F31EC71D6D8A.targetteam, 1);
    }
  }
}

_id_CD7C81FD616E8339(_id_404971775E931566) {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  _id_B5111CD83B4A3176 endon("arm_complete");

  for(;;) {
    _id_404971775E931566 waittill("trigger_start");
    _id_B5111CD83B4A3176 _id_1EE7685E35F26553(_id_404971775E931566._id_C6B73E1A1D773F72);
  }
}

_id_BC1ADD9D6B949CDC(result) {
  _id_B5111CD83B4A3176 = self;
  level endon("game_ended");
  _id_B5111CD83B4A3176 notify("arm_complete");

  if(result == "trigger_done") {
    player = _id_B5111CD83B4A3176._id_404971775E931566._id_C6B73E1A1D773F72;
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
    _id_715028F54BAD19A1::_id_0523B126AA6B63C7(player, gettime() - _id_B5111CD83B4A3176.spawntime);
    _id_B5111CD83B4A3176 _id_1EE7685E35F26553(player);
    _id_DB62C0CFC8A661CC _id_4DA2FEDD08554C6E("arrow_bombsite_arm", 5.0);
    _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_bombsite_arm_enemy", 5.0);
    waitframe();
    _id_B5111CD83B4A3176 _id_C0E9E9C23F5B3F14(player);
  } else
    _id_9C74CCDAA1E15C02("arm_error");
}

_id_4BFAC84A99F0DDBA(player) {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 _id_DE1B7260327FEF3F(player);
  _id_B5111CD83B4A3176 _id_E30E9D644D44EA47(player);
  _id_B5111CD83B4A3176 _id_01F52C10E91ED6A0();
  _id_B5111CD83B4A3176 thread _id_0F7B9661A3753DA9(_id_B5111CD83B4A3176._id_6F92F4592E6847E9);
}

_id_DE1B7260327FEF3F(player) {
  _id_B5111CD83B4A3176 = self;
  spawninfo = _id_08EDBA3D30393649(player.origin);
  _id_B5111CD83B4A3176._id_499F8A240912C54C = spawnscriptable("brloot_elite_arrow_briefcase", spawninfo.origin, spawninfo.angles);
  _id_B5111CD83B4A3176._id_499F8A240912C54C._id_B5111CD83B4A3176 = _id_B5111CD83B4A3176;
  _id_B5111CD83B4A3176._id_499F8A240912C54C _id_523253715D93C40F("defuse");
  _id_B5111CD83B4A3176._id_499F8A240912C54C _id_68EF3E106AB2D16B("hud_icon_objective_elite_radioactive_red");
  _id_B5111CD83B4A3176._id_499F8A240912C54C _id_3B7130B58A7C77B3("ground", _id_B5111CD83B4A3176._id_499F8A240912C54C, 1, 1);
}

_id_E30E9D644D44EA47(player) {
  _id_B5111CD83B4A3176 = self;
  usetime = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.defusetime;
  decayrate = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_E5AD956128DC4DA1;
  _id_A76969DCC6F15D80 = ["fuse_detonated"];
  _id_B5111CD83B4A3176._id_6F92F4592E6847E9 = _id_FFA4B010CB5F82DC(_id_B5111CD83B4A3176._id_499F8A240912C54C, "elite_arrow_fuse", usetime, decayrate, _id_A76969DCC6F15D80, player);
  _id_B5111CD83B4A3176._id_6F92F4592E6847E9._id_6A95B711C7C0C9B4 = ::_id_7CF677701D4A5CD1;
}

_id_01F52C10E91ED6A0() {
  _id_B5111CD83B4A3176 = self;

  if(!isDefined(_id_B5111CD83B4A3176._id_6F92F4592E6847E9)) {
    return;
  }
  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6B16473C9C8C32B2)) {
    foreach(player in level.players)
    _id_B5111CD83B4A3176._id_6F92F4592E6847E9 _id_F025BE1CBF898D23(player, 1);
  } else {
    foreach(player in level.players) {
      if(isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team]) && level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team].state >= 5) {
        _id_B5111CD83B4A3176._id_6F92F4592E6847E9 _id_F025BE1CBF898D23(player, 0);
        _id_B5111CD83B4A3176._id_499F8A240912C54C disablescriptableplayeruse(player);
        continue;
      }

      _id_B5111CD83B4A3176._id_6F92F4592E6847E9 _id_F025BE1CBF898D23(player, 1);
    }
  }
}

_id_523253715D93C40F(_id_9B1941CB7354665E) {
  _id_499F8A240912C54C = self;
  partname = _id_499F8A240912C54C _meth_90069777043E7833()[0];
  _id_499F8A240912C54C setscriptablepartstate(partname, _id_9B1941CB7354665E);
}

_id_999950434FE81F2E(player, _id_C37B1CC67943336D) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176)) {
    return;
  }
  _id_499F8A240912C54C = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_499F8A240912C54C;

  if(!isDefined(_id_499F8A240912C54C)) {
    return;
  }
  _id_499F8A240912C54C _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);
}

_id_50AE9CF898EC9BA2() {
  _id_B5111CD83B4A3176 = self;

  if(!isDefined(_id_B5111CD83B4A3176._id_499F8A240912C54C)) {
    return;
  }
  _id_B5111CD83B4A3176._id_499F8A240912C54C _id_523253715D93C40F("disabled");
  _id_B5111CD83B4A3176._id_499F8A240912C54C _id_231AAE2264CE7F2E();
  _id_B5111CD83B4A3176._id_499F8A240912C54C notify("death");
  _id_B5111CD83B4A3176._id_499F8A240912C54C freescriptable();
}

_id_0F7B9661A3753DA9(_id_6F92F4592E6847E9) {
  _id_B5111CD83B4A3176 = self;
  _id_B5111CD83B4A3176 notify("fuse_explode_think");
  _id_B5111CD83B4A3176 endon("fuse_explode_think");
  level endon("game_ended");
  _id_B5111CD83B4A3176 endon("fuse_complete");

  if(_id_6F92F4592E6847E9.id != "elite_arrow_fuse") {
    return;
  }
  _id_0CD816464EB84955 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0CD816464EB84955;

  if(isDefined(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C6020D9F48812BED))
    _id_0CD816464EB84955 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C6020D9F48812BED;

  wait(_id_0CD816464EB84955);
  _id_6F92F4592E6847E9 notify("fuse_detonated");
}

_id_7CF677701D4A5CD1(result) {
  _id_499F8A240912C54C = self;
  _id_B5111CD83B4A3176 = _id_499F8A240912C54C._id_B5111CD83B4A3176;
  _id_B5111CD83B4A3176 notify("fuse_complete");
  _id_B5111CD83B4A3176 _id_FC97BD9A4CF8355E(result);

  if(result == "fuse_detonated") {
    _id_B5111CD83B4A3176._id_AD590A75663898F3 = 1;
    player = _id_B5111CD83B4A3176 _id_84C4D0A19073A1CA();
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("nuke_detonated", 1);
  } else {
    _id_B5111CD83B4A3176._id_71DD48E6C8570392 = 1;
    _id_6F3B85CD1AFA4EFA = undefined;

    if(isDefined(_id_B5111CD83B4A3176._id_499F8A240912C54C._id_C6B73E1A1D773F72)) {
      _id_B5111CD83B4A3176._id_C6B73E1A1D773F72 = _id_B5111CD83B4A3176._id_499F8A240912C54C._id_C6B73E1A1D773F72;
      _id_6F3B85CD1AFA4EFA = _id_B5111CD83B4A3176._id_C6B73E1A1D773F72.team;
      _id_B5111CD83B4A3176._id_C6B73E1A1D773F72 _id_9E8981EF0C238DD0();
      _id_715028F54BAD19A1::_id_F3C107FAA06DC299(_id_B5111CD83B4A3176._id_C6B73E1A1D773F72, _id_B5111CD83B4A3176._id_F28399727742EB23 - gettime());
      _id_B5111CD83B4A3176._id_C6B73E1A1D773F72 scripts\mp\utility\stats::incpersstat("eliteBlocked", 1);
    }

    _id_9C74CCDAA1E15C02("bomb_defused", _id_6F3B85CD1AFA4EFA);
  }
}

_id_FC97BD9A4CF8355E(result) {
  _id_B5111CD83B4A3176 = self;

  if(result == "fuse_detonated") {
    player = _id_B5111CD83B4A3176 _id_84C4D0A19073A1CA();
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
    level thread _id_DD91024F2A925430(_id_DB62C0CFC8A661CC);
  } else {
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_B5111CD83B4A3176.targetteam];

    if(_id_B5111CD83B4A3176._id_F28399727742EB23 - gettime() <= 30000)
      _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_defused_under_30");
    else
      _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_defused");
  }
}

_id_DD91024F2A925430(_id_DB62C0CFC8A661CC, delay) {
  delay = scripts\engine\utility::_id_53C4C53197386572(delay, 10.0);
  wait(delay);
  _id_DB62C0CFC8A661CC _id_4DA2FEDD08554C6E("arrow_detonated", 0.0);
  _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_detonated_enemy", 0.0);
}

_id_FFA4B010CB5F82DC(_id_FD845515368E4118, id, usetime, decayrate, _id_A76969DCC6F15D80, owner) {
  _id_E0B53362A901D3AC = _id_90DBC2921A6B8B42(id);
  _id_6BCC6405C250ECB4 = spawn("trigger_radius", _id_FD845515368E4118.origin, 0, _id_E0B53362A901D3AC.radius, _id_E0B53362A901D3AC.height);
  _id_6BCC6405C250ECB4._id_FD845515368E4118 = _id_FD845515368E4118;
  _id_6BCC6405C250ECB4.id = id;
  _id_6BCC6405C250ECB4.usetime = usetime;
  _id_6BCC6405C250ECB4.decayrate = decayrate;
  _id_6BCC6405C250ECB4._id_A76969DCC6F15D80 = _id_A76969DCC6F15D80;
  _id_6BCC6405C250ECB4._id_A76969DCC6F15D80[_id_6BCC6405C250ECB4._id_A76969DCC6F15D80.size] = "trigger_done";
  _id_6BCC6405C250ECB4.owner = owner;
  _id_6BCC6405C250ECB4.radius = _id_E0B53362A901D3AC.radius;
  _id_6BCC6405C250ECB4.height = _id_E0B53362A901D3AC.height;
  _id_6BCC6405C250ECB4.trigger = spawnStruct();
  _id_6BCC6405C250ECB4.trigger.owner = owner;
  _id_6BCC6405C250ECB4.trigger.id = id;
  _id_6BCC6405C250ECB4.trigger.targetname = id + "_trigger";
  _id_6BCC6405C250ECB4 scripts\mp\gameobjects::setusetime(_id_6BCC6405C250ECB4.usetime);
  _id_6BCC6405C250ECB4 makeusable();
  _id_6BCC6405C250ECB4 sethintdisplayrange(_id_6BCC6405C250ECB4.radius);
  _id_6BCC6405C250ECB4 setuserange(_id_6BCC6405C250ECB4.radius);
  _id_6BCC6405C250ECB4 sethintdisplayfov(360);
  _id_6BCC6405C250ECB4 setusefov(360);
  _id_6BCC6405C250ECB4.inuse = 0;
  _id_6BCC6405C250ECB4 _id_13CE247FE0D09704(id);
  _id_FD845515368E4118 thread _id_F301C94B65BED28F(_id_6BCC6405C250ECB4);
  _id_6BCC6405C250ECB4 thread _id_E9B71089684738A7();
  scripts\mp\utility\trigger::makeenterexittrigger(_id_6BCC6405C250ECB4, ::_id_2840C7B0F2B083E1, ::_id_149D65954B948021);
  return _id_6BCC6405C250ECB4;
}

_id_3AE40BB839DC4AEA(targetteam, _id_860BE8762B9AE62F) {
  _id_6BCC6405C250ECB4 = self;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(targetteam, "players");

  foreach(player in _id_A6AB8D0FDA441DC2)
  _id_6BCC6405C250ECB4 _id_F025BE1CBF898D23(player, _id_860BE8762B9AE62F);
}

_id_F025BE1CBF898D23(targetplayer, _id_860BE8762B9AE62F) {
  _id_6BCC6405C250ECB4 = self;

  if(!isDefined(_id_6BCC6405C250ECB4.targets))
    _id_6BCC6405C250ECB4.targets = [];

  if(istrue(_id_860BE8762B9AE62F))
    _id_6BCC6405C250ECB4.targets[targetplayer.name] = 1;
  else
    _id_6BCC6405C250ECB4.targets[targetplayer.name] = undefined;
}

_id_90DBC2921A6B8B42(id) {
  _id_E0B53362A901D3AC = spawnStruct();

  switch (id) {
    case "elite_arrow_fuse":
      _id_E0B53362A901D3AC.radius = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_4B094191812BE79A;
      _id_E0B53362A901D3AC.height = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_284D588BB7B6D497;
      break;
    case "elite_arrow_arm":
    default:
      _id_E0B53362A901D3AC.radius = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_3483B8B1B5DC47AF;
      _id_E0B53362A901D3AC.height = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9B7BE937E7E7CF36;
      break;
  }

  return _id_E0B53362A901D3AC;
}

_id_13CE247FE0D09704(id) {
  _id_6BCC6405C250ECB4 = self;
  _id_7C8DE8DEDE9D350B = id == "elite_arrow_arm" || id == "elite_arrow_fuse";

  if(_id_7C8DE8DEDE9D350B && isDefined(_id_6BCC6405C250ECB4._id_FD845515368E4118._id_D89E953F27063A40) && isDefined(_id_6BCC6405C250ECB4._id_FD845515368E4118._id_D89E953F27063A40.all)) {
    _id_6BCC6405C250ECB4.objidnum = _id_6BCC6405C250ECB4._id_FD845515368E4118._id_D89E953F27063A40.all;
    scripts\mp\objidpoolmanager::objective_set_progress(_id_6BCC6405C250ECB4.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_setbackground(_id_6BCC6405C250ECB4.objidnum, 1);
  }
}

_id_F301C94B65BED28F(_id_6BCC6405C250ECB4) {
  _id_FD845515368E4118 = self;
  level endon("game_ended");
  result = _id_6BCC6405C250ECB4 scripts\engine\utility::waittill_any_in_array_return(_id_6BCC6405C250ECB4._id_A76969DCC6F15D80);

  if(!isDefined(result)) {
    return;
  }
  if(isDefined(_id_6BCC6405C250ECB4._id_6A95B711C7C0C9B4))
    _id_FD845515368E4118[[_id_6BCC6405C250ECB4._id_6A95B711C7C0C9B4]](result);
}

_id_2840C7B0F2B083E1(_id_EEE718E33217DC9E, trigger) {
  if(!isPlayer(_id_EEE718E33217DC9E) || !isalive(_id_EEE718E33217DC9E) || !isDefined(trigger)) {
    return;
  }
  if(!_id_EEE718E33217DC9E istouching(trigger)) {
    return;
  }
  _id_FD845515368E4118 = trigger._id_FD845515368E4118;

  if(!isDefined(_id_FD845515368E4118)) {
    return;
  }
  _id_FD845515368E4118 _id_B2FB3AA0B1AE1E80(trigger, _id_EEE718E33217DC9E);
}

_id_149D65954B948021(_id_EEE718E33217DC9E, trigger) {
  if(!isPlayer(_id_EEE718E33217DC9E)) {
    return;
  }
  thread _id_64BCC0DAD8750045(_id_EEE718E33217DC9E, trigger);
}

_id_64BCC0DAD8750045(_id_EEE718E33217DC9E, trigger) {
  _id_EEE718E33217DC9E notify("trigger_leave");
  waitframe();
  _id_EEE718E33217DC9E notify("trigger_use_think");
}

_id_B2FB3AA0B1AE1E80(_id_6BCC6405C250ECB4, _id_EEE718E33217DC9E) {
  _id_FD845515368E4118 = self;
  level endon("game_ended");
  _id_6BCC6405C250ECB4 endon("trigger_cleanup");
  _id_EEE718E33217DC9E endon("trigger_use_think");

  for(;;) {
    _id_6BCC6405C250ECB4 waittill("trigger", _id_39064A1B041B296A);

    if(_id_39064A1B041B296A != _id_EEE718E33217DC9E) {
      continue;
    }
    if(!_id_6BCC6405C250ECB4 _id_8C218E7F79F79418(_id_EEE718E33217DC9E)) {
      continue;
    }
    _id_6BCC6405C250ECB4 _id_3F0ACEB64141B7A0(_id_EEE718E33217DC9E);

    if(!_id_EEE718E33217DC9E useButtonPressed()) {
      continue;
    }
    _id_6BCC6405C250ECB4 _id_8A014ABBC4D13014(_id_EEE718E33217DC9E);
    result = _id_6BCC6405C250ECB4 _id_4A11FF41D980C285(_id_EEE718E33217DC9E);
    _id_6BCC6405C250ECB4 _id_71FD26B1AB0CF890(_id_EEE718E33217DC9E);
    _id_FD845515368E4118 _id_E6E5690310AD67B6(_id_6BCC6405C250ECB4, _id_EEE718E33217DC9E, result);
  }
}

_id_8A014ABBC4D13014(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;
  _id_6BCC6405C250ECB4 notify("trigger_start");

  if(isDefined(_id_EEE718E33217DC9E) && isPlayer(_id_EEE718E33217DC9E))
    _id_6BCC6405C250ECB4 _id_FEE0052854AAD103(_id_EEE718E33217DC9E, 1);

  _id_6BCC6405C250ECB4 makeunusable();
  _id_6BCC6405C250ECB4.inuse = 1;
}

_id_4A11FF41D980C285(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;
  _id_6BCC6405C250ECB4._id_C6B73E1A1D773F72 = _id_EEE718E33217DC9E;
  _id_6BCC6405C250ECB4 thread _id_910AFE3F427D993C(_id_EEE718E33217DC9E);
  result = scripts\engine\utility::_id_7B9E0E7CA4B3B940(_id_6BCC6405C250ECB4, "trigger_success", _id_6BCC6405C250ECB4, "trigger_fail", _id_EEE718E33217DC9E, "trigger_leave", _id_EEE718E33217DC9E, "death_or_disconnect");
  _id_6BCC6405C250ECB4 thread _id_6E5D48D0254628BF(0, _id_6BCC6405C250ECB4._id_C6B73E1A1D773F72.team);
  _id_6BCC6405C250ECB4 thread _id_A186E4E9C028312A();
  return result;
}

_id_71FD26B1AB0CF890(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;
  _id_6BCC6405C250ECB4.inuse = 0;
  _id_6BCC6405C250ECB4 makeusable();

  if(isDefined(_id_EEE718E33217DC9E) && isPlayer(_id_EEE718E33217DC9E))
    _id_6BCC6405C250ECB4 _id_FEE0052854AAD103(_id_EEE718E33217DC9E, 0);

  _id_6BCC6405C250ECB4 notify("trigger_stop");
}

_id_FEE0052854AAD103(_id_EEE718E33217DC9E, isusing) {
  _id_6BCC6405C250ECB4 = self;
  _id_EEE718E33217DC9E notify("trigger_hold_feedback");
  _id_EEE718E33217DC9E thread _id_80A4D1B69751A181(isusing, _id_6BCC6405C250ECB4);
  _id_EEE718E33217DC9E _id_571E26B585AD8B83(isusing);
  _id_6BCC6405C250ECB4 _id_0C133ACB2C0012D2(isusing);
}

_id_571E26B585AD8B83(isusing) {
  _id_EEE718E33217DC9E = self;
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_movement", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "sprint", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "fire", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "reload", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_pickup", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_switch", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_jump", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "gesture", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "melee", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "mantle", !isusing);
  _id_EEE718E33217DC9E _id_3B64EB40368C1450::set("sam_holding_bomb", "offhand_weapons", !isusing);
  _id_EEE718E33217DC9E _meth_35501B42058D4DE9();

  if(!istrue(isusing)) {
    _id_EEE718E33217DC9E _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("sam_holding_bomb");
    _id_EEE718E33217DC9E _meth_BB04491D50D9E43E();
  }
}

_id_80A4D1B69751A181(isusing, _id_6BCC6405C250ECB4) {
  _id_EEE718E33217DC9E = self;

  if(istrue(isusing)) {
    _id_DBD546841AFE3787 = makeweapon("briefcase_bomb_mp_nuke");
    _id_EEE718E33217DC9E._id_DBD546841AFE3787 = _id_DBD546841AFE3787;
    _id_EEE718E33217DC9E scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_DBD546841AFE3787, undefined, undefined, 0);
    _id_EEE718E33217DC9E setweaponammostock(_id_DBD546841AFE3787, 0);
    _id_EEE718E33217DC9E setweaponammoclip(_id_DBD546841AFE3787, 0);
    _id_EEE718E33217DC9E scripts\mp\gameobjects::switchtouseweapon(_id_DBD546841AFE3787, 1, 1);
  } else {
    if(_id_EEE718E33217DC9E scripts\cp_mp\utility\inventory_utility::iscurrentweapon("briefcase_bomb_mp_nuke")) {
      lastweaponobj = _id_EEE718E33217DC9E scripts\mp\utility\inventory::getlastweapon();
      _id_EEE718E33217DC9E scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(lastweaponobj, 0, 1);
    } else {
      _id_EEE718E33217DC9E scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(makeweapon("briefcase_bomb_mp_nuke"));
      _id_EEE718E33217DC9E._id_DBD546841AFE3787 = undefined;
    }

    if(isDefined(_id_EEE718E33217DC9E._id_DBD546841AFE3787)) {
      _id_EEE718E33217DC9E takeweapon(_id_EEE718E33217DC9E._id_DBD546841AFE3787);
      _id_EEE718E33217DC9E._id_DBD546841AFE3787 = undefined;
    }
  }
}

_id_0C133ACB2C0012D2(isusing) {
  _id_6BCC6405C250ECB4 = self;

  if(_id_6BCC6405C250ECB4.id == "elite_arrow_arm") {
    if(istrue(isusing))
      _id_6BCC6405C250ECB4._id_FD845515368E4118 _id_9AD2B2A571D4CDC9("arming");
    else {
      _id_6BCC6405C250ECB4._id_FD845515368E4118 _id_9AD2B2A571D4CDC9("arm");
      _id_6BCC6405C250ECB4._id_FD845515368E4118 _id_3570EAA3344A147C();
    }
  } else if(_id_6BCC6405C250ECB4.id == "elite_arrow_fuse") {
    if(istrue(isusing))
      _id_6BCC6405C250ECB4._id_FD845515368E4118 _id_523253715D93C40F("defusing");
    else
      _id_6BCC6405C250ECB4._id_FD845515368E4118 _id_523253715D93C40F("defuse");
  }
}

_id_910AFE3F427D993C(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_6BCC6405C250ECB4 endon("trigger_cleanup");
  _id_EEE718E33217DC9E endon("death_or_disconnect");
  _id_EEE718E33217DC9E endon("trigger_leave");

  if(!isDefined(_id_6BCC6405C250ECB4.curprogress))
    _id_6BCC6405C250ECB4.curprogress = 0;

  _id_6BCC6405C250ECB4 thread _id_6E5D48D0254628BF(1, _id_EEE718E33217DC9E.team);
  userate = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.userate;
  _id_6C2B19B1B95157AA = _id_6BCC6405C250ECB4.usetime;

  while(_id_30F6F2C77A2057AE(_id_EEE718E33217DC9E)) {
    _id_EF98038667968D83(_id_EEE718E33217DC9E);
    waitframe();
    _id_C0785ED64427E13F = level.frameduration * userate;
    _id_6BCC6405C250ECB4.curprogress = _id_6BCC6405C250ECB4.curprogress + _id_C0785ED64427E13F;

    if(_id_6BCC6405C250ECB4.curprogress >= _id_6C2B19B1B95157AA) {
      _id_6BCC6405C250ECB4 notify("trigger_success");
      return;
    }
  }

  _id_6BCC6405C250ECB4 notify("trigger_fail");
}

_id_6E5D48D0254628BF(_id_9828F1535ACBC937, _id_B908AF06E8E30C57) {
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_6BCC6405C250ECB4 endon("trigger_cleanup");
  _id_6BCC6405C250ECB4 notify("hold_UI_update");
  _id_6BCC6405C250ECB4 endon("hold_UI_update");

  for(;;) {
    if(_id_6BCC6405C250ECB4.id == "elite_arrow_fuse") {
      _id_AD2476E82036A18D = [];

      if(isDefined(_id_B908AF06E8E30C57))
        _id_AD2476E82036A18D = scripts\mp\utility\teams::getteamdata(_id_B908AF06E8E30C57, "players");
      else
        _id_AD2476E82036A18D = level.players;

      foreach(player in _id_AD2476E82036A18D) {
        if(isDefined(player))
          player scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, _id_9828F1535ACBC937);
      }
    } else if(_id_6BCC6405C250ECB4.id == "elite_arrow_arm") {
      targetteam = scripts\engine\utility::_id_53C4C53197386572(_id_B908AF06E8E30C57, _id_6BCC6405C250ECB4._id_FD845515368E4118.targetteam);

      if(!isDefined(targetteam)) {
        break;
      }

      _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(targetteam, "players");

      foreach(player in _id_6D5ED003AF1F9612)
      player scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, _id_9828F1535ACBC937);
    }

    waitframe();
  }
}

_id_97E1F9473D7EBE5B() {
  _id_6BCC6405C250ECB4 = self;
  _id_6BCC6405C250ECB4.curprogress = 0.0;
  _id_6BCC6405C250ECB4 thread _id_6E5D48D0254628BF(0, undefined);
  _id_6BCC6405C250ECB4 notify("hold_UI_update");
}

_id_30F6F2C77A2057AE(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;

  if(!isDefined(_id_6BCC6405C250ECB4))
    return 0;

  _id_6C2B19B1B95157AA = _id_6BCC6405C250ECB4.usetime;

  if(isDefined(_id_6BCC6405C250ECB4.curprogress) && _id_6BCC6405C250ECB4.curprogress > _id_6C2B19B1B95157AA)
    return 0;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_69C68027E3FF75A4)) {
    if(isDefined(_id_EEE718E33217DC9E._id_2A5A464BBDABF17E) && _id_EEE718E33217DC9E._id_2A5A464BBDABF17E == 3)
      return 0;
  } else if(!_id_EEE718E33217DC9E useButtonPressed())
    return 0;

  if(isDefined(_id_6BCC6405C250ECB4.targets) && !istrue(_id_6BCC6405C250ECB4.targets[_id_EEE718E33217DC9E.name]))
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(_id_EEE718E33217DC9E) || istrue(_id_EEE718E33217DC9E.inlaststand))
    return 0;

  _id_243F810EBB89FEF1 = _id_6BCC6405C250ECB4.radius * _id_6BCC6405C250ECB4.radius;

  if(distance2dsquared(_id_EEE718E33217DC9E.origin, _id_6BCC6405C250ECB4.origin) > _id_243F810EBB89FEF1)
    return 0;

  if(abs(_id_EEE718E33217DC9E.origin[2] - _id_6BCC6405C250ECB4.origin[2]) > _id_6BCC6405C250ECB4.height)
    return 0;

  return 1;
}

_id_EF98038667968D83(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_69C68027E3FF75A4)) {
    return;
  }
  if(!isDefined(_id_EEE718E33217DC9E._id_2A5A464BBDABF17E))
    _id_EEE718E33217DC9E._id_2A5A464BBDABF17E = 1;
  else {
    if(_id_EEE718E33217DC9E._id_2A5A464BBDABF17E == 1) {
      if(!_id_EEE718E33217DC9E useButtonPressed()) {
        _id_EEE718E33217DC9E._id_2A5A464BBDABF17E = 2;
        return;
      }

      return;
    }

    if(_id_EEE718E33217DC9E._id_2A5A464BBDABF17E == 2) {
      if(_id_EEE718E33217DC9E useButtonPressed())
        _id_EEE718E33217DC9E._id_2A5A464BBDABF17E = 3;
    }
  }
}

_id_E6E5690310AD67B6(_id_6BCC6405C250ECB4, _id_EEE718E33217DC9E, result) {
  _id_FD845515368E4118 = self;
  _id_EEE718E33217DC9E._id_2A5A464BBDABF17E = undefined;

  if(result == "trigger_success") {
    _id_6BCC6405C250ECB4 notify("trigger_done");
    _id_EEE718E33217DC9E._id_BE21D884F764E2FC = gettime();
    _id_FD845515368E4118._id_C6B73E1A1D773F72 = _id_EEE718E33217DC9E;
  } else if(result == "trigger_fail") {
    if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9C24246ADC08EDD8))
      _id_EEE718E33217DC9E._id_BE21D884F764E2FC = gettime();
  }
}

_id_A186E4E9C028312A() {
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_6BCC6405C250ECB4 endon("trigger_cleanup");
  _id_6BCC6405C250ECB4 endon("trigger_start");
  decayrate = _id_6BCC6405C250ECB4.decayrate;

  if(decayrate == 0.0)
    return;
  else if(decayrate == -1.0) {
    _id_6BCC6405C250ECB4 _id_97E1F9473D7EBE5B();
    return;
  }

  for(;;) {
    _id_6BCC6405C250ECB4.curprogress = _id_6BCC6405C250ECB4.curprogress - level.frameduration * decayrate;

    if(_id_6BCC6405C250ECB4.curprogress <= 0) {
      _id_6BCC6405C250ECB4 _id_97E1F9473D7EBE5B();
      return;
    }

    waitframe();
  }
}

_id_8C218E7F79F79418(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;

  if(istrue(_id_6BCC6405C250ECB4.inuse))
    return 0;

  if(!_id_DD1EDDCB3A80416D(_id_EEE718E33217DC9E))
    return 0;

  if(isDefined(_id_EEE718E33217DC9E._id_DBD546841AFE3787))
    return 0;

  if(!_id_6BCC6405C250ECB4 _id_30F6F2C77A2057AE(_id_EEE718E33217DC9E))
    return 0;

  return 1;
}

_id_53BAC5AD6B036444() {
  _id_6BCC6405C250ECB4 = self;

  if(!istrue(_id_6BCC6405C250ECB4.inuse))
    return undefined;

  return _id_6BCC6405C250ECB4._id_C6B73E1A1D773F72;
}

_id_3F0ACEB64141B7A0(_id_EEE718E33217DC9E) {
  _id_6BCC6405C250ECB4 = self;
  level endon("game_ended");
  _id_6BCC6405C250ECB4 endon("trigger_cleanup");

  while((!_id_EEE718E33217DC9E isonground() || _id_EEE718E33217DC9E _meth_E40102956C887F7C()) && _id_EEE718E33217DC9E useButtonPressed())
    waitframe();

  if(istrue(_id_EEE718E33217DC9E.insertingarmorplate)) {
    _id_EEE718E33217DC9E notify("try_armor_cancel");

    while(istrue(_id_EEE718E33217DC9E.insertingarmorplate) && _id_EEE718E33217DC9E useButtonPressed())
      waitframe();
  }
}

_id_E9B71089684738A7(_id_F8048727716242B0) {
  _id_6BCC6405C250ECB4 = self;

  if(!isDefined(_id_6BCC6405C250ECB4)) {
    return;
  }
  level endon("game_ended");
  _id_6BCC6405C250ECB4 notify("trigger_cleanup_singleton");
  _id_6BCC6405C250ECB4 endon("trigger_cleanup_singleton");

  if(!istrue(_id_F8048727716242B0))
    _id_6BCC6405C250ECB4 waittill("trigger_done");

  _id_6BCC6405C250ECB4 notify("trigger_cleanup");
  _id_6BCC6405C250ECB4 _id_97E1F9473D7EBE5B();
  waitframe();

  if(isDefined(_id_6BCC6405C250ECB4)) {
    _id_270EFE97B9F9C9FC(_id_6BCC6405C250ECB4._id_4908CA330BDC48D1);
    _id_6BCC6405C250ECB4 notify("destroy");
    _id_6BCC6405C250ECB4 delete();
  }
}

_id_68EF3E106AB2D16B(_id_2C19B08549244B79, targetteam, friendlyicon, _id_30F120A1EFC1DCBE) {
  _id_FD845515368E4118 = self;
  _id_FD845515368E4118._id_D89E953F27063A40 = spawnStruct();
  _id_FD845515368E4118._id_D89E953F27063A40.owner = _id_FD845515368E4118;
  _id_FD845515368E4118._id_D89E953F27063A40._id_2C19B08549244B79 = _id_2C19B08549244B79;
  _id_FD845515368E4118._id_D89E953F27063A40.friendlyicon = friendlyicon;
  _id_FD845515368E4118._id_D89E953F27063A40._id_30F120A1EFC1DCBE = _id_30F120A1EFC1DCBE;

  if(isDefined(targetteam))
    _id_FD845515368E4118 _id_1B390A39AC7EC281(targetteam, 1);
}

_id_231AAE2264CE7F2E() {
  _id_FD845515368E4118 = self;

  if(!isDefined(_id_FD845515368E4118._id_D89E953F27063A40)) {
    return;
  }
  _id_594EFF9E3940A6EE();
  _id_FD845515368E4118._id_D89E953F27063A40 = undefined;
}

_id_3B7130B58A7C77B3(state, _id_90F9773EF140E661, _id_DCFF63A4D06F32D3, _id_AE52C3C4A761FB73, _id_1E2F2224127D2990, _id_4CF3F1D180AA34E7) {
  _id_FD845515368E4118 = self;

  if(!isDefined(_id_FD845515368E4118._id_D89E953F27063A40)) {
    return;
  }
  _id_7919C8F3A10FEB86 = _id_90F9773EF140E661 _id_D11129BC318850DC(state, _id_1E2F2224127D2990);

  if(!isDefined(_id_7919C8F3A10FEB86)) {
    return;
  }
  if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40._id_2C19B08549244B79)) {
    _id_FD845515368E4118._id_D89E953F27063A40.all = _id_D940E1F43CBFE78A("all", _id_FD845515368E4118._id_D89E953F27063A40._id_2C19B08549244B79, _id_7919C8F3A10FEB86, _id_DCFF63A4D06F32D3, _id_AE52C3C4A761FB73);
    _id_FD845515368E4118 _id_B8BE1F76F5F61957(state, _id_90F9773EF140E661, _id_FD845515368E4118._id_D89E953F27063A40.all, "all", _id_1E2F2224127D2990);
    return;
  }

  if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40.friendlyicon)) {
    _id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2 = _id_D940E1F43CBFE78A("friendly", _id_FD845515368E4118._id_D89E953F27063A40.friendlyicon, _id_7919C8F3A10FEB86, _id_DCFF63A4D06F32D3, _id_AE52C3C4A761FB73);
    _id_FD845515368E4118 _id_B8BE1F76F5F61957(state, _id_90F9773EF140E661, _id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2, "friendly", _id_1E2F2224127D2990);
  }

  if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40._id_30F120A1EFC1DCBE)) {
    _id_FD845515368E4118._id_D89E953F27063A40.enemy = _id_D940E1F43CBFE78A("enemy", _id_FD845515368E4118._id_D89E953F27063A40._id_30F120A1EFC1DCBE, _id_7919C8F3A10FEB86, _id_DCFF63A4D06F32D3, _id_AE52C3C4A761FB73);
    _id_FD845515368E4118 _id_B8BE1F76F5F61957(state, _id_90F9773EF140E661, _id_FD845515368E4118._id_D89E953F27063A40.enemy, "enemy", _id_1E2F2224127D2990);
  }

  if(isDefined(_id_FD845515368E4118.player) && istrue(_id_4CF3F1D180AA34E7))
    _id_FD845515368E4118.player.ismarked = 1;
}

_id_594EFF9E3940A6EE(_id_4CF3F1D180AA34E7) {
  _id_FD845515368E4118 = self;
  _id_FD845515368E4118 notify("icon_hide");

  if(!isDefined(_id_FD845515368E4118._id_D89E953F27063A40)) {
    return;
  }
  if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40.all)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_FD845515368E4118._id_D89E953F27063A40.all);
    _id_FD845515368E4118._id_D89E953F27063A40.all = undefined;
  }

  if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2);
    _id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2 = undefined;
  }

  if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40.enemy)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_FD845515368E4118._id_D89E953F27063A40.enemy);
    _id_FD845515368E4118._id_D89E953F27063A40.enemy = undefined;
  }

  if(isDefined(_id_FD845515368E4118.player) && istrue(_id_4CF3F1D180AA34E7))
    _id_FD845515368E4118.player.ismarked = 0;
}

_id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D) {
  _id_FD845515368E4118 = self;

  if(!isDefined(_id_FD845515368E4118._id_D89E953F27063A40)) {
    return;
  }
  if(istrue(_id_C37B1CC67943336D) && !istrue(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())) {
    if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40.all))
      objective_addclienttomask(_id_FD845515368E4118._id_D89E953F27063A40.all, player);

    if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2) && _id_CDD64ADDD69607B1(player))
      objective_addclienttomask(_id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2, player);

    if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40.enemy) && !_id_CDD64ADDD69607B1(player))
      objective_addclienttomask(_id_FD845515368E4118._id_D89E953F27063A40.enemy, player);
  } else {
    if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40.all))
      objective_removeclientfrommask(_id_FD845515368E4118._id_D89E953F27063A40.all, player);

    if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2))
      objective_removeclientfrommask(_id_FD845515368E4118._id_D89E953F27063A40._id_3E2EF879EE8848E2, player);

    if(isDefined(_id_FD845515368E4118._id_D89E953F27063A40.enemy))
      objective_removeclientfrommask(_id_FD845515368E4118._id_D89E953F27063A40.enemy, player);
  }
}

_id_1B390A39AC7EC281(targetteam, _id_C37B1CC67943336D) {
  _id_FD845515368E4118 = self;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(targetteam, "players");

  foreach(player in _id_A6AB8D0FDA441DC2)
  _id_FD845515368E4118 _id_F5549984B1909638(player, _id_C37B1CC67943336D);
}

_id_F5549984B1909638(targetplayer, _id_C37B1CC67943336D) {
  _id_FD845515368E4118 = self;

  if(!isDefined(_id_FD845515368E4118._id_D89E953F27063A40.targets))
    _id_FD845515368E4118._id_D89E953F27063A40.targets = [];

  if(istrue(_id_C37B1CC67943336D))
    _id_FD845515368E4118._id_D89E953F27063A40.targets[targetplayer.name] = 1;
  else
    _id_FD845515368E4118._id_D89E953F27063A40.targets[targetplayer.name] = undefined;

  _id_B63A22F9943A3AE8(targetplayer, _id_C37B1CC67943336D);
}

_id_B8BE1F76F5F61957(state, _id_90F9773EF140E661, _id_A3EC0E7732B1EDF1, _id_DC382B1157307F94, _id_1E2F2224127D2990) {
  _id_FD845515368E4118 = self;

  if(state == "ground")
    _id_FD845515368E4118 thread _id_A71E5368DD774148(_id_90F9773EF140E661, _id_A3EC0E7732B1EDF1, _id_1E2F2224127D2990);
  else if(state == "player")
    _id_FD845515368E4118 thread _id_A061E912AA8B0E76(_id_90F9773EF140E661, _id_A3EC0E7732B1EDF1, _id_DC382B1157307F94, _id_1E2F2224127D2990);
}

_id_D940E1F43CBFE78A(_id_DC382B1157307F94, _id_82605F63D444A44E, _id_7919C8F3A10FEB86, _id_DCFF63A4D06F32D3, _id_AE52C3C4A761FB73) {
  _id_FD845515368E4118 = self;
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", _id_7919C8F3A10FEB86, _id_82605F63D444A44E);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, _id_DCFF63A4D06F32D3);
    objective_setshowdistance(objid, _id_AE52C3C4A761FB73);
    objective_removeallfrommask(objid);

    foreach(player in level.players) {
      if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
        continue;
      }
      if(_id_DC382B1157307F94 == "friendly" && !_id_CDD64ADDD69607B1(player)) {
        continue;
      }
      if(_id_DC382B1157307F94 == "enemy" && _id_CDD64ADDD69607B1(player)) {
        continue;
      }
      objective_addclienttomask(objid, player);
    }

    objective_showtoplayersinmask(objid);
  } else {}

  return objid;
}

_id_A71E5368DD774148(_id_90F9773EF140E661, _id_A3EC0E7732B1EDF1, _id_1E2F2224127D2990) {
  _id_FD845515368E4118 = self;
  _id_FD845515368E4118 endon("death");
  _id_90F9773EF140E661 endon("death");
  _id_FD845515368E4118 endon("icon_hide");

  for(;;) {
    _id_7919C8F3A10FEB86 = _id_90F9773EF140E661 _id_D11129BC318850DC("ground", _id_1E2F2224127D2990);

    if(!isDefined(_id_7919C8F3A10FEB86)) {
      return;
    }
    scripts\mp\objidpoolmanager::update_objective_position(_id_A3EC0E7732B1EDF1, _id_7919C8F3A10FEB86);
    waitframe();
  }
}

_id_A061E912AA8B0E76(_id_90F9773EF140E661, _id_A3EC0E7732B1EDF1, _id_DC382B1157307F94, _id_1E2F2224127D2990) {
  _id_FD845515368E4118 = self;
  _id_FD845515368E4118 endon("death");
  _id_90F9773EF140E661 endon("death");
  _id_FD845515368E4118 endon("icon_hide");
  _id_6F4226FE72D50C87 = _id_0268FFE9EE453E80(_id_DC382B1157307F94);

  if(_id_6F4226FE72D50C87 <= 0.0) {
    zoffset = 80;

    if(isDefined(_id_1E2F2224127D2990))
      zoffset = _id_1E2F2224127D2990[2];

    scripts\mp\objidpoolmanager::update_objective_setzoffset(_id_A3EC0E7732B1EDF1, zoffset);
    scripts\mp\objidpoolmanager::update_objective_onentity(_id_A3EC0E7732B1EDF1, _id_90F9773EF140E661);
  } else {
    for(;;) {
      _id_7919C8F3A10FEB86 = _id_90F9773EF140E661 _id_D11129BC318850DC("player", _id_1E2F2224127D2990);

      if(!isDefined(_id_7919C8F3A10FEB86)) {
        return;
      }
      scripts\mp\objidpoolmanager::update_objective_position(_id_A3EC0E7732B1EDF1, _id_7919C8F3A10FEB86);

      if(_id_90F9773EF140E661 scripts\cp_mp\utility\player_utility::isinvehicle()) {
        wait 0.1;
        continue;
      }

      wait(_id_6F4226FE72D50C87);
    }
  }
}

_id_EF1A83CF2BA58E1A(player, _id_C37B1CC67943336D) {
  _id_32041F48A2A2E73C(player, _id_C37B1CC67943336D);
  _id_3957D8D2EA023852(player, _id_C37B1CC67943336D);
  _id_F045C586F2D204CE(player, _id_C37B1CC67943336D);
  _id_999950434FE81F2E(player, _id_C37B1CC67943336D);
  _id_F2697D44D12A9E3E(player, _id_C37B1CC67943336D);
}

_id_EF1C1B3C3CF49AB0(player, _id_C37B1CC67943336D) {
  _id_32041F48A2A2E73C(player, _id_C37B1CC67943336D);
  _id_A7EE3A5E548C916E(player, "ber", _id_C37B1CC67943336D);
  _id_999950434FE81F2E(player, _id_C37B1CC67943336D);
  _id_F2697D44D12A9E3E(player, _id_C37B1CC67943336D);
}

_id_CDD64ADDD69607B1(player) {
  _id_FD845515368E4118 = self;

  if(!isDefined(_id_FD845515368E4118._id_D89E953F27063A40.targets))
    return 0;

  return isDefined(_id_FD845515368E4118._id_D89E953F27063A40.targets[player.name]);
}

_id_D11129BC318850DC(state, _id_1E2F2224127D2990) {
  _id_FD845515368E4118 = self;
  _id_7919C8F3A10FEB86 = _id_FD845515368E4118.origin;

  if(!isDefined(_id_7919C8F3A10FEB86))
    return undefined;

  if(state == "ground")
    _id_7919C8F3A10FEB86 = _id_7919C8F3A10FEB86 + (0, 0, 25);
  else if(state == "player")
    _id_7919C8F3A10FEB86 = _id_7919C8F3A10FEB86 + (0, 0, 80);

  if(isDefined(_id_1E2F2224127D2990))
    _id_7919C8F3A10FEB86 = _id_7919C8F3A10FEB86 + _id_1E2F2224127D2990;

  return _id_7919C8F3A10FEB86;
}

_id_0268FFE9EE453E80(_id_DC382B1157307F94) {
  _id_6F4226FE72D50C87 = 0.0;

  if(_id_DC382B1157307F94 == "friendly")
    _id_6F4226FE72D50C87 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_19425DBAE48971B9;
  else if(_id_DC382B1157307F94 == "enemy")
    _id_6F4226FE72D50C87 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_DD38DB1002A8FD1A;

  return _id_6F4226FE72D50C87;
}

_id_E84FB82FC52B3EA2(_id_264E3329827F2DA3, _id_BFBE9638E9832D90, targetteam, _id_63E44F52D71E301E, _id_BAC6C36DAD5FB495, _id_6B250C2C33200931) {
  _id_FD845515368E4118 = self;

  if(!isDefined(_id_264E3329827F2DA3) || !isDefined(_id_BFBE9638E9832D90)) {
    return;
  }
  _id_FD845515368E4118 _id_564F3CD2BDC17D5F(_id_264E3329827F2DA3, _id_BFBE9638E9832D90, _id_FD845515368E4118.origin, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8935D39CDF624A21);
  mapcircle = _id_FD845515368E4118 _id_7C84AECCE384688D(_id_264E3329827F2DA3);
  mapcircle.team = targetteam;

  if(!istrue(_id_BAC6C36DAD5FB495)) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(targetteam, "players");

    foreach(player in _id_A6AB8D0FDA441DC2)
    _id_FD845515368E4118 _id_C203F89A3D83F9BE(_id_264E3329827F2DA3, player);
  }

  _id_FD845515368E4118 thread _id_A90F855AA2D7DDD6(_id_264E3329827F2DA3, _id_63E44F52D71E301E, _id_6B250C2C33200931);
}

_id_C203F89A3D83F9BE(_id_264E3329827F2DA3, player) {
  _id_FD845515368E4118 = self;

  if(_id_264E3329827F2DA3 == 1)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  else if(_id_264E3329827F2DA3 == 2)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_FAB8EC5FEB7D4C9C(player);
}

_id_43C474EAB683E97A(_id_264E3329827F2DA3, player) {
  _id_FD845515368E4118 = self;

  if(_id_264E3329827F2DA3 == 1)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  else if(_id_264E3329827F2DA3 == 2)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_74C4CD59F26EB9EC(player);
}

_id_7C84AECCE384688D(_id_264E3329827F2DA3) {
  _id_FD845515368E4118 = self;

  if(_id_264E3329827F2DA3 == 1)
    return _id_FD845515368E4118.mapcircle;
  else if(_id_264E3329827F2DA3 == 2)
    return _id_FD845515368E4118._id_616C7052C6C2D9B9;
}

_id_C9A7F5AD5FAEE037(_id_264E3329827F2DA3) {
  if(_id_264E3329827F2DA3 == 1)
    return "circle_cleanup";
  else if(_id_264E3329827F2DA3 == 2)
    return "circle_two_cleanup";
}

_id_564F3CD2BDC17D5F(_id_264E3329827F2DA3, _id_BFBE9638E9832D90, origin, radius) {
  _id_FD845515368E4118 = self;

  if(_id_264E3329827F2DA3 == 1)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_BFBE9638E9832D90, origin, radius);
  else if(_id_264E3329827F2DA3 == 2)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_DB48978D7206BD41(_id_BFBE9638E9832D90, origin, radius);
}

_id_953DD2DAC81CED7D(_id_264E3329827F2DA3) {
  _id_FD845515368E4118 = self;

  if(_id_264E3329827F2DA3 == 1)
    return _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_ACAA75CA8754452E();
  else if(_id_264E3329827F2DA3 == 2)
    return _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_28F9DFE13002DBB9();

  return 0;
}

_id_6C1A0DACEA15C314(_id_264E3329827F2DA3) {
  _id_FD845515368E4118 = self;
  _id_FD845515368E4118 _id_33480A83D352290D();

  if(_id_264E3329827F2DA3 == 1)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  else if(_id_264E3329827F2DA3 == 2)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_F630402329582086();
}

_id_33480A83D352290D() {
  _id_FD845515368E4118 = self;

  if(!isDefined(_id_FD845515368E4118.targetteam)) {
    return;
  }
  if(!isDefined(_id_FD845515368E4118.mapcircle) && !isDefined(_id_FD845515368E4118._id_616C7052C6C2D9B9)) {
    return;
  }
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_FD845515368E4118.targetteam, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    if(!isDefined(player)) {
      return;
    }
    for(_id_394466C2DDB208CB = 0; _id_394466C2DDB208CB < 21; _id_394466C2DDB208CB++) {
      _id_A1823E6B1CB4B46D = player calloutmarkerping_gettype(_id_394466C2DDB208CB);

      if(_id_A1823E6B1CB4B46D != 16) {
        continue;
      }
      _id_82076CFFF3BD567A = player calloutmarkerping_getEnt(_id_394466C2DDB208CB);

      if(isDefined(_id_FD845515368E4118.mapcircle) && _id_82076CFFF3BD567A != _id_FD845515368E4118.mapcircle || isDefined(_id_FD845515368E4118._id_616C7052C6C2D9B9) && _id_82076CFFF3BD567A != _id_FD845515368E4118._id_616C7052C6C2D9B9) {
        continue;
      }
      player scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(_id_394466C2DDB208CB);
    }
  }
}

_id_CC8B8058ACAD7A5E(_id_264E3329827F2DA3, search_location) {
  _id_FD845515368E4118 = self;

  if(_id_264E3329827F2DA3 == 1)
    scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(search_location);
  else if(_id_264E3329827F2DA3 == 2)
    scripts\cp_mp\utility\game_utility::_id_1D0718FB3B210270(search_location);
}

_id_362AFD02A416E0E1(_id_264E3329827F2DA3) {
  _id_FD845515368E4118 = self;
  _id_FD845515368E4118 notify(_id_C9A7F5AD5FAEE037(_id_264E3329827F2DA3));
  _id_C42DD9DA85552F4F = _id_FD845515368E4118 _id_953DD2DAC81CED7D(_id_264E3329827F2DA3);

  if(istrue(_id_C42DD9DA85552F4F))
    _id_FD845515368E4118 _id_6C1A0DACEA15C314(_id_264E3329827F2DA3);
}

_id_A90F855AA2D7DDD6(_id_264E3329827F2DA3, _id_63E44F52D71E301E, _id_6B250C2C33200931) {
  _id_FD845515368E4118 = self;
  _id_FD845515368E4118 endon(_id_C9A7F5AD5FAEE037(_id_264E3329827F2DA3));

  for(;;) {
    _id_D0A3509F93C5B2E5 = _id_140A060C10923557(_id_264E3329827F2DA3);

    if(istrue(_id_6B250C2C33200931) || istrue(_id_D0A3509F93C5B2E5) || istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_63E44F52D71E301E) || istrue(_id_63E44F52D71E301E))
      _id_751A786DC5A29DE1(_id_264E3329827F2DA3, _id_6B250C2C33200931);

    if(istrue(_id_6B250C2C33200931)) {
      waitframe();
      continue;
    }

    _id_495B81D9B9FAC4B9 = randomfloat(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9042D5CF11398509) - level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9042D5CF11398509 / 2;
    wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B00B634FF0D615B6 + _id_495B81D9B9FAC4B9);
  }
}

_id_751A786DC5A29DE1(_id_264E3329827F2DA3, _id_6AC9A089E3DEAF54) {
  _id_FD845515368E4118 = self;
  search_location = (_id_FD845515368E4118.origin[0], _id_FD845515368E4118.origin[1], 0);

  if(!istrue(_id_6AC9A089E3DEAF54)) {
    radius = _id_E9B7D4BC067911CF(_id_264E3329827F2DA3);
    range = _id_B2089F7EC141EB6A(radius);
    search_location = search_location + scripts\engine\math::random_vector_2d() * range;
  }

  _id_FD845515368E4118 _id_CC8B8058ACAD7A5E(_id_264E3329827F2DA3, search_location);
}

_id_B2089F7EC141EB6A(radius) {
  _id_FD845515368E4118 = self;

  if(!isDefined(radius)) {
    return;
  }
  if(radius == level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_22CF546CE61F0EE4)
    return randomfloatrange(0, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_E31C618E0043E25C);
  else if(radius == level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F12ACD8EB090FB0)
    return randomfloatrange(0, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F3369A0BF2E24D98);
  else
    return randomfloatrange(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2A708F42DF785976, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2A938142DF9E8264);
}

_id_140A060C10923557(_id_264E3329827F2DA3) {
  _id_FD845515368E4118 = self;
  _id_42CA41C7DADAE0C0 = undefined;
  circle = _id_FD845515368E4118 _id_7C84AECCE384688D(_id_264E3329827F2DA3);
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\game::getlivingplayers(circle.team);

  foreach(player in _id_A6AB8D0FDA441DC2) {
    dist = distance2d(player.origin, _id_FD845515368E4118.origin);

    if(!isDefined(_id_42CA41C7DADAE0C0) || dist < _id_42CA41C7DADAE0C0)
      _id_42CA41C7DADAE0C0 = dist;
  }

  oldradius = _id_E9B7D4BC067911CF(_id_264E3329827F2DA3);
  _id_A66785EDEC9E567B = oldradius;

  if(!isDefined(_id_42CA41C7DADAE0C0) || _id_42CA41C7DADAE0C0 > level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8935D39CDF624A21) {
    _id_FD845515368E4118 _id_C220E901546E3DDB(_id_264E3329827F2DA3, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8935D39CDF624A21);
    _id_A66785EDEC9E567B = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8935D39CDF624A21;
  } else if(_id_42CA41C7DADAE0C0 > level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BC573EA608F113CD) {
    _id_FD845515368E4118 _id_C220E901546E3DDB(_id_264E3329827F2DA3, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BC573EA608F113CD);
    _id_A66785EDEC9E567B = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BC573EA608F113CD;
  } else if(_id_42CA41C7DADAE0C0 > level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F12ACD8EB090FB0) {
    _id_FD845515368E4118 _id_C220E901546E3DDB(_id_264E3329827F2DA3, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F12ACD8EB090FB0);
    _id_A66785EDEC9E567B = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F12ACD8EB090FB0;
  } else {
    _id_FD845515368E4118 _id_C220E901546E3DDB(_id_264E3329827F2DA3, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_22CF546CE61F0EE4);
    _id_A66785EDEC9E567B = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_22CF546CE61F0EE4;
  }

  if(_id_A66785EDEC9E567B != oldradius)
    return 1;

  return 0;
}

_id_C220E901546E3DDB(_id_264E3329827F2DA3, _id_A66785EDEC9E567B) {
  _id_FD845515368E4118 = self;

  if(_id_264E3329827F2DA3 == 1)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(_id_A66785EDEC9E567B);
  else if(_id_264E3329827F2DA3 == 2)
    _id_FD845515368E4118 scripts\cp_mp\utility\game_utility::_id_AE2BFAA147F91CA5(_id_A66785EDEC9E567B);
}

_id_E9B7D4BC067911CF(_id_264E3329827F2DA3) {
  _id_FD845515368E4118 = self;
  circle = _id_FD845515368E4118 _id_7C84AECCE384688D(_id_264E3329827F2DA3);

  if(isDefined(circle))
    return circle.origin[2];

  return -1;
}

_id_DB724919D6173E87(targetteam) {
  player = self;

  foreach(_id_69E96A4CAA72D794 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[targetteam]) {
    if(!isDefined(_id_69E96A4CAA72D794)) {
      continue;
    }
    _id_69E96A4CAA72D794 _id_C203F89A3D83F9BE(1, player);
  }
}

_id_3CEE7764BD6C4CFF(targetteam) {
  player = self;

  foreach(_id_69E96A4CAA72D794 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[targetteam]) {
    if(!isDefined(_id_69E96A4CAA72D794)) {
      continue;
    }
    _id_69E96A4CAA72D794 _id_43C474EAB683E97A(1, player);
  }
}

_id_86EA1B770AE5CB74() {
  _id_DB62C0CFC8A661CC = self;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE)) {
    return;
  }
  _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C = spawnStruct();
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_DB62C0CFC8A661CC.targetteam, "players");
  _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C._id_6D5ED003AF1F9612 = _id_6D5ED003AF1F9612;
  _id_DB62C0CFC8A661CC _id_FF3FABC5E0883062();
  _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C._id_585B2B3F676CCC77 = _id_E067B71266D46A9D((1, 0.9, 0.7), 165, 95, -50);
}

_id_2E031201711A99DE() {
  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE)) {
    return;
  }
  foreach(info in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(info)) {
      continue;
    }
    _id_AA6BA140692B3197(info.targetteam);
  }
}

_id_AA6BA140692B3197(targetteam) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[targetteam]) || !isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[targetteam]._id_DAF52E0D19EC394C)) {
    return;
  }
  level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[targetteam] _id_9F667C7C18DDE8AF();
  level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[targetteam]._id_DAF52E0D19EC394C = undefined;
}

_id_9F667C7C18DDE8AF() {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  _id_4895F52923623FCD(_id_DAF52E0D19EC394C.title);
  _id_4895F52923623FCD(_id_DAF52E0D19EC394C._id_585B2B3F676CCC77);

  foreach(_id_F90358454413407F in _id_DAF52E0D19EC394C.entries)
  _id_4895F52923623FCD(_id_F90358454413407F);
}

_id_4895F52923623FCD(_id_2E5F671F800DB00F) {
  if(!isDefined(_id_2E5F671F800DB00F)) {
    return;
  }
  foreach(_id_4EFE32558A7556C6 in _id_2E5F671F800DB00F) {
    if(isDefined(_id_4EFE32558A7556C6))
      _id_4EFE32558A7556C6 scripts\mp\hud_util::destroyelem();
  }
}

_id_FF3FABC5E0883062() {
  _id_DB62C0CFC8A661CC = self;
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE)) {
    return;
  }
  if(istrue(_id_B5111CD83B4A3176._id_DC0258A29DC9FAF1))
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.title = _id_DC5ADA7D3D98A103(&"BR_ELITE_BROKEN_ARROW/ARM_THE_BOMB", 1.2, 1.0, -75);
  else if(istrue(_id_B5111CD83B4A3176._id_B6AF7EF8B50C76EE))
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.title = _id_DC5ADA7D3D98A103(&"BR_ELITE_BROKEN_ARROW/DEPOSIT_ELEMS", 1.2, 1.0, -75);
  else if(istrue(_id_B5111CD83B4A3176._id_48D6C5734103E2B0))
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.title = _id_DC5ADA7D3D98A103(&"BR_ELITE_BROKEN_ARROW/WAITING_BOMB", 1.2, 1.0, -75);
  else
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.title = _id_DC5ADA7D3D98A103(&"BR_ELITE_BROKEN_ARROW/LOCATE_ELEMS", 1.2, 1.0, -75);
}

_id_F421381F1379BC3C(_id_27DE1507ED41F01E, spawned) {
  _id_DB62C0CFC8A661CC = self;
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;
  _id_6A89F76ED7B6F41E = _id_6844602F3120E900(_id_27DE1507ED41F01E, 4);
  _id_644DA2EEFEA4726E = _id_65336E6B7ECD0BFC(_id_6844602F3120E900(_id_27DE1507ED41F01E, 6));

  if(!isDefined(_id_6A89F76ED7B6F41E)) {
    return;
  }
  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE)) {
    return;
  }
  if(!isDefined(_id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.entries))
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.entries = [];

  if(isDefined(_id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.entries[_id_6A89F76ED7B6F41E]))
    _id_4895F52923623FCD(_id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.entries[_id_6A89F76ED7B6F41E]);

  if(istrue(_id_B5111CD83B4A3176._id_DEBE9FD67DD91A71[_id_27DE1507ED41F01E]))
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.entries[_id_6A89F76ED7B6F41E] = _id_DC5ADA7D3D98A103(_id_6844602F3120E900(_id_27DE1507ED41F01E, 15), 0.9, 0.6, _id_644DA2EEFEA4726E);
  else if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB) && !istrue(spawned))
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.entries[_id_6A89F76ED7B6F41E] = _id_DC5ADA7D3D98A103(&"BR_ELITE_BROKEN_ARROW/NEXT_TASK", 0.9, 0.6, _id_644DA2EEFEA4726E);
  else
    _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C.entries[_id_6A89F76ED7B6F41E] = _id_DC5ADA7D3D98A103(_id_6844602F3120E900(_id_27DE1507ED41F01E, 14), 0.9, 1.0, _id_644DA2EEFEA4726E);
}

_id_DC5ADA7D3D98A103(text, _id_A61C75B156FC1EE0, alpha, heightoffset) {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  if(!isDefined(_id_DAF52E0D19EC394C._id_6D5ED003AF1F9612)) {
    return;
  }
  _id_94480E1669B7FF0D = [];

  foreach(player in _id_DAF52E0D19EC394C._id_6D5ED003AF1F9612) {
    if(!isDefined(player)) {
      continue;
    }
    _id_94480E1669B7FF0D[player.clientid] = player scripts\mp\hud_util::createfontstring("default", _id_A61C75B156FC1EE0);
    _id_94480E1669B7FF0D[player.clientid] scripts\mp\hud_util::setpoint("LEFT", "LEFT", 15, heightoffset);
    _id_94480E1669B7FF0D[player.clientid].alpha = alpha;
    _id_94480E1669B7FF0D[player.clientid].archived = 0;
    _id_94480E1669B7FF0D[player.clientid].hidewheninmenu = 1;
    _id_94480E1669B7FF0D[player.clientid] settext(text);
  }

  return _id_94480E1669B7FF0D;
}

_id_94CC9DC4D6F03045(time, _id_A61C75B156FC1EE0, _id_6E04E340B75C04AD, heightoffset, _id_210F94A8FD146F18) {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  if(!isDefined(_id_DAF52E0D19EC394C._id_6D5ED003AF1F9612)) {
    return;
  }
  _id_94480E1669B7FF0D = [];

  foreach(player in _id_DAF52E0D19EC394C._id_6D5ED003AF1F9612) {
    if(!isDefined(player)) {
      continue;
    }
    _id_94480E1669B7FF0D[player.clientid] = player scripts\mp\hud_util::createtimer("default", _id_A61C75B156FC1EE0);
    _id_94480E1669B7FF0D[player.clientid] scripts\mp\hud_util::setpoint("LEFT", "LEFT", _id_210F94A8FD146F18, heightoffset);
    _id_94480E1669B7FF0D[player.clientid].alpha = 1;
    _id_94480E1669B7FF0D[player.clientid].archived = 0;
    _id_94480E1669B7FF0D[player.clientid].hidewheninmenu = 1;

    if(istrue(_id_6E04E340B75C04AD)) {
      _id_94480E1669B7FF0D[player.clientid] settenthstimer(time);
      continue;
    }

    _id_94480E1669B7FF0D[player.clientid] settimer(time);
  }

  return _id_94480E1669B7FF0D;
}

_id_E067B71266D46A9D(color, width, height, heightoffset) {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  if(!isDefined(_id_DAF52E0D19EC394C._id_6D5ED003AF1F9612)) {
    return;
  }
  _id_94480E1669B7FF0D = [];

  foreach(player in _id_DAF52E0D19EC394C._id_6D5ED003AF1F9612) {
    if(!isDefined(player)) {
      continue;
    }
    _id_94480E1669B7FF0D[player.clientid] = player scripts\mp\hud_util::createbar(color, width, height);
    _id_94480E1669B7FF0D[player.clientid] scripts\mp\hud_util::setpoint("LEFT", "LEFT", 0, heightoffset);
    _id_94480E1669B7FF0D[player.clientid].alpha = 0.5;
    _id_94480E1669B7FF0D[player.clientid].bar.alpha = 0.5;
    _id_94480E1669B7FF0D[player.clientid].archived = 0;
    _id_94480E1669B7FF0D[player.clientid].hidewheninmenu = 1;
  }

  return _id_94480E1669B7FF0D;
}

_id_566EBF0873178B74(text) {
  foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)
  _id_DCC5F31EC71D6D8A _id_B20ED2F9B411799E(text);
}

_id_B20ED2F9B411799E(text) {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  if(!isDefined(_id_DAF52E0D19EC394C.title)) {
    return;
  }
  foreach(_id_F90358454413407F in _id_DAF52E0D19EC394C.title) {
    if(!isDefined(_id_F90358454413407F)) {
      continue;
    }
    _id_F90358454413407F settext(text);
  }
}

_id_C34F3E1C188C4EE6(text, alpha, _id_43348865D9126A85) {
  foreach(_id_DCC5F31EC71D6D8A in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)
  _id_DCC5F31EC71D6D8A _id_F0FE6459C0D406DC(text, alpha, _id_43348865D9126A85);
}

_id_F0FE6459C0D406DC(text, alpha, _id_43348865D9126A85) {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  if(!isDefined(_id_DAF52E0D19EC394C.entries[_id_43348865D9126A85])) {
    return;
  }
  foreach(_id_F90358454413407F in _id_DAF52E0D19EC394C.entries[_id_43348865D9126A85]) {
    if(!isDefined(_id_F90358454413407F)) {
      continue;
    }
    _id_F90358454413407F settext(text);

    if(isDefined(alpha))
      _id_F90358454413407F.alpha = alpha;
  }
}

_id_6AF5DED34F8C79BE() {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  _id_DAF52E0D19EC394C.entries[6] = _id_DC5ADA7D3D98A103(&"BR_ELITE_BROKEN_ARROW/BOMB_INCOMING", 1.0, 0.6, -12);
}

_id_8BEF76D7D75916B6(time) {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  _id_4895F52923623FCD(_id_DAF52E0D19EC394C.entries[6]);
  _id_DAF52E0D19EC394C.entries[6] = _id_DC5ADA7D3D98A103(&"BR_ELITE_BROKEN_ARROW/BOMB_EXPIRES", 1.0, 1.0, -12);
  _id_DAF52E0D19EC394C.entries[7] = _id_94CC9DC4D6F03045(time, 1.0, 0, -24, 125);
}

_id_9DE2E8C510281719() {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  _id_4895F52923623FCD(_id_DAF52E0D19EC394C.entries[6]);
  _id_4895F52923623FCD(_id_DAF52E0D19EC394C.entries[7]);
}

_id_5CF6AB54F8852B93(time) {
  _id_DB62C0CFC8A661CC = self;
  _id_DAF52E0D19EC394C = _id_DB62C0CFC8A661CC._id_DAF52E0D19EC394C;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE) || !isDefined(_id_DAF52E0D19EC394C)) {
    return;
  }
  foreach(_id_F90358454413407F in _id_DAF52E0D19EC394C.entries)
  _id_4895F52923623FCD(_id_F90358454413407F);

  _id_B20ED2F9B411799E(&"BR_ELITE_BROKEN_ARROW/PROTECT_NUKE");
  _id_DAF52E0D19EC394C.entries[8] = _id_94CC9DC4D6F03045(time, 1.5, 1, -45, 15);
}

_id_3FD409053922036C() {
  _id_B8EBE3F71A08AB40 = self;

  foreach(player in scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40.teams[0], "players")) {
    if(!player _id_2CEDCC356F1B9FC8::isplayeringulag())
      player _id_E16C60B795D0B382(1);
  }
}

_id_E16C60B795D0B382(visible) {
  player = self;

  if(istrue(visible))
    player _id_64ACB6CE534155B7::uiobjectiveshow("elite_arrow");
  else
    player _id_64ACB6CE534155B7::uiobjectivehide();
}

_id_56EE84F1B091647A(timer, _id_F1FB762D15F78344) {
  _id_DB62C0CFC8A661CC = self;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE)) {
    return;
  }
  enabled = _id_DB62C0CFC8A661CC _id_AD4ED1C9602D71E0();
  _id_22C75974769A0663 = _id_DB62C0CFC8A661CC _id_B6255B7471955EFC();
  timer = _id_AE2D71B31ECC6C60(timer);
  _id_F1FB762D15F78344 = istrue(_id_F1FB762D15F78344);
  _id_B5111CD83B4A3176 = _id_C3EC46D0059F56B8();
  states = _id_DB62C0CFC8A661CC _id_002E702BEA8F46BA();
  allies = _id_DB62C0CFC8A661CC _id_FBD99FB0F0DBDF28();
  enemies = _id_DB62C0CFC8A661CC _id_BB6E0639AF98DBA6();
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_DB62C0CFC8A661CC.targetteam, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    player _id_92E23A2852DD5EF7(enabled, _id_22C75974769A0663, states, _id_B5111CD83B4A3176, allies, timer, _id_F1FB762D15F78344);
    player _id_A94FC1246FD1026D(enemies);
    player _id_2E7F459351D2A81E(timer, _id_22C75974769A0663);
  }
}

_id_C9699034E76B57C8(timer) {
  player = self;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE)) {
    return;
  }
  _id_22C75974769A0663 = _id_0C9F395DF805314E();
  timer = _id_AE2D71B31ECC6C60(timer);
  _id_F1FB762D15F78344 = 0;
  _id_B5111CD83B4A3176 = _id_C3EC46D0059F56B8();
  states = _id_2B087DC1A7410F08();
  player _id_92E23A2852DD5EF7(0, _id_22C75974769A0663, states, _id_B5111CD83B4A3176, [], timer, _id_F1FB762D15F78344);
}

_id_20238D522C76FB01(timer, _id_F1FB762D15F78344) {
  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7AF870EF18E0ECFE)) {
    return;
  }
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)) {
    return;
  }
  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      continue;
    }
    _id_DB62C0CFC8A661CC thread _id_56EE84F1B091647A(timer, _id_F1FB762D15F78344);
  }
}

_id_5E7FDF58F111F041(timer) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(_id_8EF404291EA37583(player)) {
      continue;
    }
    player _id_C9699034E76B57C8(timer);
  }
}

_id_AD4ED1C9602D71E0() {
  _id_DB62C0CFC8A661CC = self;
  return _id_DB62C0CFC8A661CC.state > 0;
}

_id_B6255B7471955EFC() {
  _id_DB62C0CFC8A661CC = self;
  return max(_id_DB62C0CFC8A661CC.state, 0);
}

_id_0C9F395DF805314E() {
  _id_BA62064FF7EEE264 = 0;

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      continue;
    }
    _id_BA62064FF7EEE264 = max(_id_DB62C0CFC8A661CC _id_B6255B7471955EFC(), _id_BA62064FF7EEE264);
  }

  return _id_BA62064FF7EEE264;
}

_id_AE2D71B31ECC6C60(timer) {
  if(isDefined(level._id_C83AA9DBC3654AFA._id_FCDECE7735749A7E))
    return _id_3FB6126945208E3E();
  else if(isDefined(timer))
    return int(timer);

  return 0;
}

_id_C3EC46D0059F56B8() {
  if(isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176) && istrue(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_B6AF7EF8B50C76EE))
    return 2;

  return 1;
}

_id_002E702BEA8F46BA() {
  _id_DB62C0CFC8A661CC = self;
  elements = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements;
  result = [];

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855)
  result[result.size] = _id_DB62C0CFC8A661CC _id_3FEA6986376FA82D(_id_F7806D4CF24AACD3);

  return result;
}

_id_3FEA6986376FA82D(_id_27DE1507ED41F01E) {
  _id_DB62C0CFC8A661CC = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam]) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam][_id_27DE1507ED41F01E])) {
    _id_5C30839190169E61 = isDefined(level._id_C83AA9DBC3654AFA._id_BCE3837DC67D6F25) && isDefined(level._id_C83AA9DBC3654AFA._id_BCE3837DC67D6F25[_id_27DE1507ED41F01E]) && level._id_C83AA9DBC3654AFA._id_BCE3837DC67D6F25[_id_27DE1507ED41F01E] <= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29258DCC063EEC7F;
    _id_FE9F3114268BD3CB = isDefined(_id_DB62C0CFC8A661CC._id_8DFD9E71543B605B[_id_27DE1507ED41F01E]) && _id_DB62C0CFC8A661CC._id_8DFD9E71543B605B[_id_27DE1507ED41F01E] <= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29258DCC063EEC7F;

    if(_id_5C30839190169E61 || _id_FE9F3114268BD3CB)
      return 1;
    else
      return 0;
  }

  _id_F7806D4CF24AACD3 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam][_id_27DE1507ED41F01E];

  if(isDefined(_id_F7806D4CF24AACD3._id_A683E11BF953F9B7) && _id_F7806D4CF24AACD3._id_A683E11BF953F9B7 > 0) {
    switch (_id_F7806D4CF24AACD3._id_A683E11BF953F9B7) {
      case 1:
        return 5;
      case 2:
        return 6;
      case 3:
        return 7;
      case 4:
        return 8;
      default:
        break;
    }
  }

  if(isDefined(_id_F7806D4CF24AACD3.player)) {
    if(_id_F7806D4CF24AACD3.player.team == _id_F7806D4CF24AACD3.targetteam)
      return 3;
    else
      return 4;
  }

  if(_id_F7806D4CF24AACD3 _id_97C5201A39C968E4() == "dropped" || _id_F7806D4CF24AACD3 _id_97C5201A39C968E4() == "visible" || istrue(_id_F7806D4CF24AACD3.firstpickup))
    return 2;

  return 0;
}

_id_2B087DC1A7410F08() {
  elements = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements;

  if(!isDefined(elements))
    return [0, 0, 0];

  result = [];

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855)
  result[result.size] = _id_94604D3A8A6BCBCD(_id_F7806D4CF24AACD3);

  return result;
}

_id_94604D3A8A6BCBCD(_id_27DE1507ED41F01E) {
  _id_CC378BF2F62661F2 = 0;

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      continue;
    }
    _id_CC378BF2F62661F2 = max(_id_DB62C0CFC8A661CC _id_3FEA6986376FA82D(_id_27DE1507ED41F01E), _id_CC378BF2F62661F2);
  }

  if(_id_CC378BF2F62661F2 < 5)
    _id_CC378BF2F62661F2 = 0;

  return _id_CC378BF2F62661F2;
}

_id_FBD99FB0F0DBDF28(elements) {
  _id_DB62C0CFC8A661CC = self;
  elements = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements;
  result = [];

  if(!isDefined(elements) || !isDefined(elements[_id_DB62C0CFC8A661CC.targetteam])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size; _id_AC0E594AC96AA3A8++)
      result[result.size] = 0;
  } else {
    foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855)
    result[result.size] = _id_DB62C0CFC8A661CC _id_916A1B0FE3B68A5F(_id_F7806D4CF24AACD3);
  }

  return result;
}

_id_916A1B0FE3B68A5F(_id_27DE1507ED41F01E) {
  _id_DB62C0CFC8A661CC = self;
  _id_F7806D4CF24AACD3 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam][_id_27DE1507ED41F01E];

  if(!isDefined(_id_F7806D4CF24AACD3) || !isDefined(_id_F7806D4CF24AACD3.player))
    return 0;

  return _id_F7806D4CF24AACD3.player._id_3F78C6A0862F9E25;
}

_id_BB6E0639AF98DBA6(elements) {
  _id_DB62C0CFC8A661CC = self;
  elements = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements;
  result = [];

  if(!isDefined(elements) || !isDefined(elements[_id_DB62C0CFC8A661CC.targetteam])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size; _id_AC0E594AC96AA3A8++)
      result[result.size] = 0;
  } else {
    foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_33B2F96CE75CB855)
    result[result.size] = _id_DB62C0CFC8A661CC _id_F6A8EAC525987FB3(_id_F7806D4CF24AACD3);
  }

  return result;
}

_id_F6A8EAC525987FB3(_id_27DE1507ED41F01E) {
  _id_DB62C0CFC8A661CC = self;
  _id_F7806D4CF24AACD3 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam][_id_27DE1507ED41F01E];

  if(!isDefined(_id_F7806D4CF24AACD3))
    return 0;

  if(isDefined(_id_F7806D4CF24AACD3.player))
    return _id_F7806D4CF24AACD3.player getentitynumber();

  return 0;
}

_id_92E23A2852DD5EF7(enabled, _id_22C75974769A0663, _id_0DEDFD45A583BD6B, _id_B5111CD83B4A3176, _id_05CD71E0B5232F12, timer, _id_F1FB762D15F78344) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  player _id_4D04726ABAC45416(_id_0DEDFD45A583BD6B, _id_05CD71E0B5232F12);
  player _id_861ECA600AA7E32C(enabled, _id_22C75974769A0663, _id_B5111CD83B4A3176, timer, _id_F1FB762D15F78344);
}

_id_4D04726ABAC45416(_id_0DEDFD45A583BD6B, _id_05CD71E0B5232F12) {
  _id_60BC1C932D9C930C = 15;
  _id_396348F5E859D0E9 = 3;
  _id_7BD189E8A12DBE14 = _id_0DEDFD45A583BD6B.size;

  if(_id_0DEDFD45A583BD6B.size < 3)
    _id_0DEDFD45A583BD6B[_id_0DEDFD45A583BD6B.size] = 0;

  if(_id_05CD71E0B5232F12.size < 4)
    _id_05CD71E0B5232F12[_id_05CD71E0B5232F12.size] = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0DEDFD45A583BD6B.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_0DEDFD45A583BD6B[_id_AC0E594AC96AA3A8]) && _id_0DEDFD45A583BD6B[_id_AC0E594AC96AA3A8] >= 0 && _id_0DEDFD45A583BD6B[_id_AC0E594AC96AA3A8] <= _id_60BC1C932D9C930C)
      scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_element_data", 4 * _id_AC0E594AC96AA3A8, 4, int(_id_0DEDFD45A583BD6B[_id_AC0E594AC96AA3A8]) &_id_60BC1C932D9C930C);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_05CD71E0B5232F12.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_05CD71E0B5232F12[_id_AC0E594AC96AA3A8]) && _id_05CD71E0B5232F12[_id_AC0E594AC96AA3A8] >= 0 && _id_05CD71E0B5232F12[_id_AC0E594AC96AA3A8] <= _id_396348F5E859D0E9)
      scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_element_data", 12 + 2 * _id_AC0E594AC96AA3A8, 2, int(_id_05CD71E0B5232F12[_id_AC0E594AC96AA3A8]) &_id_396348F5E859D0E9);
  }

  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_element_data", 20, 3, _id_7BD189E8A12DBE14);
}

_id_861ECA600AA7E32C(enabled, _id_22C75974769A0663, _id_B5111CD83B4A3176, timer, _id_F1FB762D15F78344, success) {
  _id_A01A7CAB5CF01EAC = 1;
  _id_BA62064FF7EEE264 = 7;
  _id_030EE88D1D0EB5E8 = 3;
  _id_41D74EE5D7FDEBB0 = 511;
  _id_7E53E1F2F0376472 = 1;
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_mission_data", 0, 1, int(enabled) &_id_A01A7CAB5CF01EAC);
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_mission_data", 1, 3, int(_id_22C75974769A0663) &_id_BA62064FF7EEE264);
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_mission_data", 4, 2, int(_id_B5111CD83B4A3176) &_id_030EE88D1D0EB5E8);
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_mission_data", 6, 9, int(timer) &_id_41D74EE5D7FDEBB0);
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_mission_data", 15, 1, int(_id_F1FB762D15F78344) &_id_7E53E1F2F0376472);
}

_id_FA5724663BA71381() {
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_mission_data", 16, 1, int(1));
}

_id_A94FC1246FD1026D(_id_8AE34D1FC33F5566) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  player _id_2F11BD77A8FA0132(_id_8AE34D1FC33F5566);
}

_id_2F11BD77A8FA0132(_id_8AE34D1FC33F5566) {
  _id_CD975998ED2963B2 = 255;

  if(_id_8AE34D1FC33F5566.size < 4)
    _id_8AE34D1FC33F5566[_id_8AE34D1FC33F5566.size] = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AE34D1FC33F5566.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_8AE34D1FC33F5566[_id_AC0E594AC96AA3A8]) && _id_8AE34D1FC33F5566[_id_AC0E594AC96AA3A8] >= 0 && _id_8AE34D1FC33F5566[_id_AC0E594AC96AA3A8] <= _id_CD975998ED2963B2)
      scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_br_elite_arrow_mission_players", 8 * _id_AC0E594AC96AA3A8, 8, int(_id_8AE34D1FC33F5566[_id_AC0E594AC96AA3A8]) &_id_CD975998ED2963B2);
  }
}

_id_2E7F459351D2A81E(timer, _id_22C75974769A0663) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  if(_id_22C75974769A0663 == 0 || _id_22C75974769A0663 == 1 || _id_22C75974769A0663 == 6) {
    return;
  }
  time = gettime() + timer * 1000;
  player setclientomnvar("ui_br_objective_countdown_timer", time);
}

_id_6A6B4D717EC3582E() {
  _id_DB62C0CFC8A661CC = self;
  player = _id_DB62C0CFC8A661CC.champion;
  _id_B7015A0DBEFEBCE1 = _id_149D1A95D86FDE9F(player);

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5.debug) && (_id_B7015A0DBEFEBCE1.size != 3 || level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B.size != 3)) {
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("container_spawn_failed", 0);
    return;
  }

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105))
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105 = [];

  _id_5F2CAD9ADA90D105 = [];

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B) {
    _id_5F2CAD9ADA90D105[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] = _id_2EB30DCE28E6A061(_id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 7), player.team, _id_B7015A0DBEFEBCE1[_id_F7806D4CF24AACD3._id_C36FC01475B3A4C9].origin, _id_B7015A0DBEFEBCE1[_id_F7806D4CF24AACD3._id_C36FC01475B3A4C9].angles);

    if(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E == "ber")
      _id_5F2CAD9ADA90D105[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] _id_68EF3E106AB2D16B("ui_map_icon_elite_crown");
  }

  level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[player.team] = _id_5F2CAD9ADA90D105;
}

_id_2EB30DCE28E6A061(scriptable, targetteam, position, angles) {
  _id_69E96A4CAA72D794 = spawnscriptable(scriptable, position, angles);
  _id_69E96A4CAA72D794 _id_3182E44BB20CC5AF("active_and_closed");
  _id_27DE1507ED41F01E = _id_96A1620D901981D1(scriptable, 7);
  _id_E3C7BDFC2AE5DC88 = _id_6844602F3120E900(_id_27DE1507ED41F01E, 3);
  _id_69E96A4CAA72D794 _id_E84FB82FC52B3EA2(1, _id_E3C7BDFC2AE5DC88, targetteam);
  _id_69E96A4CAA72D794.targetteam = targetteam;
  _id_69E96A4CAA72D794._id_BBC200BC77C5DB2B = 1;
  _id_69E96A4CAA72D794.keepinmap = 1;
  _id_69E96A4CAA72D794._id_7B4388C3A450812A = 1;
  _id_69E96A4CAA72D794._id_D89E953F27063A40 = spawnStruct();
  _id_69E96A4CAA72D794._id_D89E953F27063A40.friendlyicon = _id_6844602F3120E900(_id_27DE1507ED41F01E, 2);
  _id_69E96A4CAA72D794 _id_1B390A39AC7EC281(targetteam, 1);
  _id_69E96A4CAA72D794 _id_28F475DBB88A7E63(_id_69E96A4CAA72D794.type, targetteam);
  _id_69E96A4CAA72D794 thread _id_208F655060EEF025();
  _id_69E96A4CAA72D794 scripts\common\utility::_id_57257D1ED9CE2F48(::_id_71EBB660B298AF07);
  return _id_69E96A4CAA72D794;
}

_id_28F475DBB88A7E63(_id_7F2F4EB2E503984F, targetteam) {
  _id_69E96A4CAA72D794 = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements))
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements = [];

  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[targetteam]))
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[targetteam] = [];

  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[targetteam];
  _id_27DE1507ED41F01E = _id_96A1620D901981D1(_id_7F2F4EB2E503984F, 7);
  level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[targetteam][_id_27DE1507ED41F01E] = _id_DB62C0CFC8A661CC _id_4C842789D2E221A8(_id_27DE1507ED41F01E, _id_69E96A4CAA72D794.origin, _id_69E96A4CAA72D794.angles);
  _id_69E96A4CAA72D794._id_84B9876DBE3B246C = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[targetteam][_id_27DE1507ED41F01E];
  _id_69E96A4CAA72D794._id_84B9876DBE3B246C._id_361509C548D93DC9 = _id_69E96A4CAA72D794;
}

_id_4D6D1400D6DF4B2D() {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105)) {
    return;
  }
  foreach(info in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(info)) {
      continue;
    }
    _id_6C05BD253D4AE324(info.targetteam);
  }
}

_id_6C05BD253D4AE324(targetteam) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[targetteam])) {
    return;
  }
  foreach(_id_69E96A4CAA72D794 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[targetteam])
  _id_69E96A4CAA72D794 _id_983755EFB92EBFC2();
}

_id_983755EFB92EBFC2() {
  _id_69E96A4CAA72D794 = self;

  if(!isDefined(_id_69E96A4CAA72D794)) {
    return;
  }
  _id_69E96A4CAA72D794 _id_362AFD02A416E0E1(1);
  _id_69E96A4CAA72D794 _id_594EFF9E3940A6EE();
  _id_69E96A4CAA72D794 notify("death");
  _id_69E96A4CAA72D794 freescriptable();
}

_id_149D1A95D86FDE9F(player) {
  _id_B7015A0DBEFEBCE1 = [];
  _id_BCB418497D44610B = _id_CA6C0350AC3A2550(player.origin);

  if(_id_BCB418497D44610B.size == 0)
    return undefined;

  _id_8FC5B65D2CDFC7CE = getdvarfloat("dvar_11508C2017D016A5", 1.0);
  _id_B7015A0DBEFEBCE1[0] = _id_1780902700581723(_id_BCB418497D44610B, 90 * _id_8FC5B65D2CDFC7CE);
  _id_B7015A0DBEFEBCE1[1] = _id_1780902700581723(_id_BCB418497D44610B, 330 * _id_8FC5B65D2CDFC7CE);
  _id_B7015A0DBEFEBCE1[2] = _id_1780902700581723(_id_BCB418497D44610B, 510 * _id_8FC5B65D2CDFC7CE);
  _id_B7015A0DBEFEBCE1 = scripts\engine\utility::array_randomize(_id_B7015A0DBEFEBCE1);
  return _id_B7015A0DBEFEBCE1;
}

_id_CA6C0350AC3A2550(position, _id_C7236D5024DC86A8) {
  maxdist = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8A0E0D62D99BEF57;

  if(isDefined(_id_C7236D5024DC86A8) && int(_id_C7236D5024DC86A8) >= 2)
    maxdist = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_66F01753408E68A6;

  _id_636C8575D7A7768B = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A076A7284AA6E915;

  if(istrue(_id_C7236D5024DC86A8))
    _id_636C8575D7A7768B = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_702EE9172F969DE8;

  _id_BCB418497D44610B = getunusedlootcachepoints(position, maxdist, _id_636C8575D7A7768B);

  if(!istrue(_id_C7236D5024DC86A8))
    _id_BCB418497D44610B = _id_A076336C265F25C0(position, _id_BCB418497D44610B);

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8E6E735A3607B730)
    _id_BCB418497D44610B = _id_C0B7581316E30132(_id_BCB418497D44610B);

  return _id_BCB418497D44610B;
}

_id_A076336C265F25C0(position, nodes) {
  if(!_id_362C58E8BB39BCDA::isfeatureenabled("circle"))
    return nodes;

  _id_BFC65A378A6D8EFE = [];

  foreach(node in nodes) {
    if(_id_58F20490049AF6AC::_id_77CEC84F05CA9418(position, node.origin, 1000))
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = node;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_C0B7581316E30132(nodes) {
  _id_BFC65A378A6D8EFE = [];

  foreach(node in nodes) {
    if(!_id_744CAD313ED0A87E::_id_20A22133815385F8(node.origin))
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = node;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_1780902700581723(_id_7A180981CE616EF4, _id_745A27070FCADB17) {
  if(!isDefined(_id_7A180981CE616EF4))
    return undefined;

  _id_7A180981CE616EF4 = scripts\engine\utility::array_randomize(_id_7A180981CE616EF4);

  if(istrue(level.br_circle_disabled))
    return _id_7A180981CE616EF4[0];

  foreach(node in _id_7A180981CE616EF4) {
    if(!_id_D51C0A9F57AA9815(node, _id_745A27070FCADB17)) {
      continue;
    }
    disablelootspawnpoint(node.index);
    return node;
  }

  return undefined;
}

_id_D51C0A9F57AA9815(node, _id_745A27070FCADB17) {
  _id_CF876CD1A06753F5 = _id_58F20490049AF6AC::_id_03E0A90B32E551AD(node.origin);

  if(_id_CF876CD1A06753F5 < _id_745A27070FCADB17)
    return 0;

  if(_id_4948CDF739393D2D::_id_F59F68ADC71D49B3(node.origin))
    return 0;

  return 1;
}

_id_208F655060EEF025() {
  _id_69E96A4CAA72D794 = self;
  _id_69E96A4CAA72D794 notify("watch_circle");
  _id_69E96A4CAA72D794 endon("watch_circle");
  _id_69E96A4CAA72D794 endon("element_taken");
  level endon("game_ended");

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BCDE724251CE0168 <= 0.0) {
    return;
  }
  for(;;) {
    wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BCDE724251CE0168);

    if(!_id_C2EF2A31F608BD68(_id_69E96A4CAA72D794)) {
      return;
    }
    _id_6FD2D9A208CEF69B = !istrue(level.br_circle_disabled) && !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_69E96A4CAA72D794.origin);

    if(!istrue(_id_6FD2D9A208CEF69B)) {
      continue;
    }
    _id_69E96A4CAA72D794 _id_AE237980930F2584();
    _id_69E96A4CAA72D794 _id_AE4D9D04FB05BAE9();
  }
}

_id_AE237980930F2584() {
  _id_69E96A4CAA72D794 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BD1B7C4252108828 <= 0.0) {
    return;
  }
  if(!isDefined(_id_69E96A4CAA72D794._id_2841F41440CBB817))
    _id_69E96A4CAA72D794._id_2841F41440CBB817 = 0.0;

  _id_69E96A4CAA72D794._id_2841F41440CBB817 = _id_69E96A4CAA72D794._id_2841F41440CBB817 + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BCDE724251CE0168;

  if(_id_69E96A4CAA72D794._id_2841F41440CBB817 >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BD1B7C4252108828) {
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_69E96A4CAA72D794.targetteam];
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("container_gas_timeout");
  }
}

_id_AE4D9D04FB05BAE9() {
  _id_69E96A4CAA72D794 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BCE042BDEA07B805 < 0.0) {
    return;
  }
  _id_115E51DB24ACCA46 = !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_69E96A4CAA72D794.origin, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BCE042BDEA07B805);

  if(istrue(_id_115E51DB24ACCA46)) {
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_69E96A4CAA72D794.targetteam];
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("container_gas_too_far");
  }
}

_id_71EBB660B298AF07() {
  _id_69E96A4CAA72D794 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_69E96A4CAA72D794.targetteam];
  _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("container_deleted_in_area_swap");
  return 0;
}

_id_112636A06B12393B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(_id_96A1620D901981D1(part, 8))) {
    return;
  }
  if(!instance _id_D0DAEA8E27167BF7(player)) {
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/MISSION_OCCUPIED");
    return;
  }

  if(instance._id_84B9876DBE3B246C _id_699D3AFB882FD365() && !instance._id_84B9876DBE3B246C _id_EC5207AAEB1D4AD9(player)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
    return;
  }

  if(state != "active_and_open")
    instance _id_3DE18BA2E2C30E99(state);
}

_id_D0DAEA8E27167BF7(player) {
  _id_69E96A4CAA72D794 = self;

  if(isDefined(_id_69E96A4CAA72D794.instance))
    _id_69E96A4CAA72D794 = _id_69E96A4CAA72D794.instance;

  if(_id_69E96A4CAA72D794.targetteam != player.team)
    return 0;

  return 1;
}

_id_699D3AFB882FD365() {
  _id_69E96A4CAA72D794 = self;

  if(isDefined(_id_69E96A4CAA72D794.instance))
    _id_69E96A4CAA72D794 = _id_69E96A4CAA72D794.instance;

  if(_id_69E96A4CAA72D794 _id_E5E7DF17C00CA60B() != "active_and_open")
    return 0;

  return 1;
}

_id_E5E7DF17C00CA60B() {
  _id_69E96A4CAA72D794 = self;

  if(isDefined(_id_69E96A4CAA72D794._id_361509C548D93DC9))
    _id_69E96A4CAA72D794 = _id_69E96A4CAA72D794._id_361509C548D93DC9;

  partname = _id_69E96A4CAA72D794 _meth_90069777043E7833()[0];
  curstate = _id_69E96A4CAA72D794 getscriptablepartstate(partname, 1);

  if(curstate == "hidden")
    return "hidden";
  else if(curstate == "active_and_closed" || curstate == "opening" || curstate == "closing")
    return "active_and_closed";
  else if(curstate == "active_and_open")
    return "active_and_open";
  else if(curstate == "empty_and_open")
    return "empty_and_open";
}

_id_3182E44BB20CC5AF(_id_9B1941CB7354665E) {
  _id_69E96A4CAA72D794 = self;
  partname = _id_69E96A4CAA72D794 _meth_90069777043E7833()[0];
  _id_69E96A4CAA72D794 setscriptablepartstate(partname, _id_9B1941CB7354665E);
}

_id_3DE18BA2E2C30E99(state) {
  _id_69E96A4CAA72D794 = self;

  switch (state) {
    case "active_and_open":
      _id_69E96A4CAA72D794 _id_DC8599923C57CE27();
      break;
    case "active_and_closed":
      _id_69E96A4CAA72D794 _id_D05ED5F3CD2D2166();
      break;
    case "empty_and_open":
    case "closing":
    case "opening":
    case "hidden":
    default:
      break;
  }
}

_id_DC8599923C57CE27() {
  _id_69E96A4CAA72D794 = self;
  _id_69E96A4CAA72D794 notify("element_taken");
  _id_69E96A4CAA72D794 scripts\common\utility::_id_0307245F5E6C7A85();
  _id_69E96A4CAA72D794 _id_3182E44BB20CC5AF("empty_and_open");
  _id_69E96A4CAA72D794 _id_594EFF9E3940A6EE();
}

_id_D05ED5F3CD2D2166() {
  _id_69E96A4CAA72D794 = self;
  _id_69E96A4CAA72D794 _id_3182E44BB20CC5AF("opening");
  _id_69E96A4CAA72D794._id_84B9876DBE3B246C _id_2622FB76607DECE9(1);
  _id_69E96A4CAA72D794 _id_362AFD02A416E0E1(1);
  _id_69E96A4CAA72D794 _id_3B7130B58A7C77B3("ground", _id_69E96A4CAA72D794, 0, 0);
}

_id_E1D317DBD311185D(_id_27DE1507ED41F01E, position, angles, player) {
  _id_DB62C0CFC8A661CC = self;
  _id_F7806D4CF24AACD3 = _id_4C842789D2E221A8(_id_27DE1507ED41F01E, position, angles);
  _id_F7806D4CF24AACD3 _id_D0E46D09A12DD2A9(player);
  return _id_F7806D4CF24AACD3;
}

_id_4C842789D2E221A8(_id_27DE1507ED41F01E, position, angles) {
  _id_DB62C0CFC8A661CC = self;
  _id_F7806D4CF24AACD3 = undefined;

  switch (_id_27DE1507ED41F01E) {
    case "ber":
      _id_F7806D4CF24AACD3 = _id_DB62C0CFC8A661CC _id_6B5ECEBDDC1C6AD3(_id_27DE1507ED41F01E, position, angles);
      break;
    case "plu":
      _id_F7806D4CF24AACD3 = _id_DB62C0CFC8A661CC _id_6253104CC59C4F29(_id_27DE1507ED41F01E, position, angles);
      break;
    case "tri":
      _id_F7806D4CF24AACD3 = _id_DB62C0CFC8A661CC _id_52DC4CB3754B675F(_id_27DE1507ED41F01E, position, angles);
      break;
    case "gal":
      _id_F7806D4CF24AACD3 = _id_DB62C0CFC8A661CC _id_80F86D133491DAF8(_id_27DE1507ED41F01E, position, angles);
      break;
    case "deu":
      _id_F7806D4CF24AACD3 = _id_DB62C0CFC8A661CC _id_D35BBFF23005617E(_id_27DE1507ED41F01E, position, angles);
      break;
    case "nep":
      _id_F7806D4CF24AACD3 = _id_DB62C0CFC8A661CC _id_3B3B0F3703EBD7E5(_id_27DE1507ED41F01E, position, angles);
      break;
    default:
      break;
  }

  return _id_F7806D4CF24AACD3;
}

_id_8B73CAE3FC8903B2(_id_27DE1507ED41F01E, _id_4CF3F1D180AA34E7) {
  _id_DB62C0CFC8A661CC = self;
  _id_DB62C0CFC8A661CC _id_F421381F1379BC3C(_id_27DE1507ED41F01E, 1);
  _id_F7806D4CF24AACD3 = spawnStruct();
  _id_F7806D4CF24AACD3._id_27DE1507ED41F01E = _id_27DE1507ED41F01E;
  _id_F7806D4CF24AACD3.targetteam = _id_DB62C0CFC8A661CC.targetteam;
  _id_F7806D4CF24AACD3.firstpickup = 1;
  _id_F7806D4CF24AACD3._id_A683E11BF953F9B7 = 0;
  _id_F7806D4CF24AACD3.spawntime = gettime();
  _id_F7806D4CF24AACD3._id_6A89F76ED7B6F41E = _id_6844602F3120E900(_id_27DE1507ED41F01E, 4);

  if(istrue(_id_4CF3F1D180AA34E7)) {
    _id_F7806D4CF24AACD3.icon = "ui_map_icon_elite_crown";
    _id_F7806D4CF24AACD3 _id_68EF3E106AB2D16B(_id_F7806D4CF24AACD3.icon);
  } else {
    _id_F7806D4CF24AACD3.icon = _id_6844602F3120E900(_id_27DE1507ED41F01E, 2);
    _id_F7806D4CF24AACD3 _id_68EF3E106AB2D16B(undefined, _id_DB62C0CFC8A661CC.targetteam, _id_F7806D4CF24AACD3.icon, undefined);
  }

  thread _id_F2E1BF20E302F384(_id_F7806D4CF24AACD3);
  return _id_F7806D4CF24AACD3;
}

_id_AA97A28838886E60(player, _id_F33DB1522C7885F1, _id_4CF3F1D180AA34E7) {
  _id_F7806D4CF24AACD3 = self;
  _id_F7806D4CF24AACD3 _id_43563F93A8AF2E8C(_id_4CF3F1D180AA34E7);

  if(istrue(_id_F33DB1522C7885F1)) {
    return;
  }
  if(istrue(_id_4CF3F1D180AA34E7) && !istrue(player.ismarked))
    _id_F7806D4CF24AACD3 _id_3B7130B58A7C77B3("player", player, 0, 0, undefined, _id_4CF3F1D180AA34E7);

  _id_F7806D4CF24AACD3 _id_11F9F12CF0115D10("player", player);
  _id_54A65B932BB1233A(_id_F7806D4CF24AACD3, player);
}

_id_E80445BEC743C7A9(player, _id_4CF3F1D180AA34E7) {
  _id_F7806D4CF24AACD3 = self;
  _id_F7806D4CF24AACD3 _id_43563F93A8AF2E8C(_id_4CF3F1D180AA34E7);

  if(istrue(_id_F7806D4CF24AACD3.cleanup)) {
    return;
  }
  if(istrue(_id_4CF3F1D180AA34E7))
    _id_F7806D4CF24AACD3 _id_325031A0B2F983E4();
  else {
    [_id_69E00D24A565D9A1, _id_5AE5E6CD7F0CC727] = _id_F7806D4CF24AACD3 _id_2D501383CD6A7711();
    _id_F7806D4CF24AACD3 _id_3B7130B58A7C77B3("player", _id_69E00D24A565D9A1, 0, 0, _id_5AE5E6CD7F0CC727);
  }

  _id_F7806D4CF24AACD3 _id_11F9F12CF0115D10("ground", player);
  _id_EFD43A8E0998D07D(_id_F7806D4CF24AACD3, player);
}

_id_325031A0B2F983E4() {
  _id_F7806D4CF24AACD3 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];
  _id_F7806D4CF24AACD3.icon = _id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 2);
  _id_F7806D4CF24AACD3.scriptable _id_68EF3E106AB2D16B(undefined, _id_DB62C0CFC8A661CC.targetteam, _id_F7806D4CF24AACD3.icon, "ui_map_icon_elite_crown");
  [_id_69E00D24A565D9A1, _id_5AE5E6CD7F0CC727] = _id_F7806D4CF24AACD3 _id_2D501383CD6A7711();
  _id_F7806D4CF24AACD3.scriptable _id_3B7130B58A7C77B3("player", _id_69E00D24A565D9A1, 0, 0, _id_5AE5E6CD7F0CC727);
}

_id_F67AC964313877A0(_id_4CF3F1D180AA34E7) {
  _id_F7806D4CF24AACD3 = self;
  _id_F7806D4CF24AACD3 notify("element_cleanup");
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];

  if(!isDefined(_id_DB62C0CFC8A661CC)) {
    return;
  }
  if(istrue(_id_4CF3F1D180AA34E7))
    _id_F7806D4CF24AACD3 _id_43563F93A8AF2E8C();

  _id_C34F3E1C188C4EE6(_id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 15), 0.6, _id_F7806D4CF24AACD3._id_6A89F76ED7B6F41E);
  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
}

_id_11F9F12CF0115D10(state, player) {
  _id_F7806D4CF24AACD3 = self;

  if(state == "player") {
    if(istrue(_id_F7806D4CF24AACD3.firstpickup)) {
      if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B303983F30CB3658))
        scripts\mp\hud_util::showsplashtoteam(player.team, _id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 12));

      waitframe();
    }
  }

  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];

  if(!isDefined(_id_DB62C0CFC8A661CC) || _id_DB62C0CFC8A661CC.state == 0) {
    return;
  }
  if(state == "hidden")
    _id_DB62C0CFC8A661CC _id_F0FE6459C0D406DC(_id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 13), 1.0, _id_F7806D4CF24AACD3._id_6A89F76ED7B6F41E);
  else if(state == "ground")
    _id_DB62C0CFC8A661CC _id_F0FE6459C0D406DC(_id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 16), 1.0, _id_F7806D4CF24AACD3._id_6A89F76ED7B6F41E);
}

_id_1448434D41F7A323(scriptable, position, angles) {
  _id_F391BF01090B356C = spawnscriptable(scriptable, position, angles);
  _id_F391BF01090B356C _id_F3548416F24B0F48("hidden");
  _id_7E52B56769FA7774::clearspaceforscriptableinstance();
  _id_7E52B56769FA7774::registerscriptableinstance(_id_F391BF01090B356C);
  _id_F391BF01090B356C._id_BBC200BC77C5DB2B = 1;
  return _id_F391BF01090B356C;
}

_id_8A43BDA3F6BEFEF4(position, angles) {
  _id_F7806D4CF24AACD3 = self;
  lootid = _id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 5);
  _id_2713F4A3502D1624 = _id_2D9D24F7C63AC143::_id_91C1BE871300A518(lootid);
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, position, angles, undefined, undefined, undefined, undefined, undefined, undefined, 50000.0);
  scriptable = _id_7E52B56769FA7774::spawnpickup(_id_2713F4A3502D1624, _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
  scriptable._id_BBC200BC77C5DB2B = 1;
  return scriptable;
}

_id_A5CBE340384AF146() {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements)) {
    return;
  }
  foreach(info in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(info)) {
      continue;
    }
    _id_C2CE67F5903927AF(info.targetteam);
  }
}

_id_C2CE67F5903927AF(targetteam) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[targetteam])) {
    return;
  }
  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[targetteam])
  _id_F7806D4CF24AACD3 _id_C1F94114AE475307();
}

_id_C1F94114AE475307() {
  _id_F7806D4CF24AACD3 = self;

  if(!isDefined(_id_F7806D4CF24AACD3) || istrue(_id_F7806D4CF24AACD3.cleanup)) {
    return;
  }
  _id_F7806D4CF24AACD3.cleanup = 1;

  if(isDefined(_id_F7806D4CF24AACD3.player) && isDefined(_id_F7806D4CF24AACD3._id_3793828403C6873E))
    _id_F7806D4CF24AACD3.player _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_F7806D4CF24AACD3._id_3793828403C6873E, 1);

  if(isDefined(_id_F7806D4CF24AACD3._id_B5163896CAAFC5CD))
    _id_F7806D4CF24AACD3[[_id_F7806D4CF24AACD3._id_B5163896CAAFC5CD]]();

  _id_CCEA330AD0AF8D55 = _id_F7806D4CF24AACD3._id_8499B021054BA877 || level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF;
  _id_F7806D4CF24AACD3 _id_F67AC964313877A0(_id_CCEA330AD0AF8D55);
  _id_F7806D4CF24AACD3 _id_231AAE2264CE7F2E();
  _id_F7806D4CF24AACD3 _id_7FEB456A1DDB4048();
}

_id_7FEB456A1DDB4048() {
  _id_F7806D4CF24AACD3 = self;

  if(!isDefined(_id_F7806D4CF24AACD3.scriptable)) {
    return;
  }
  _id_F7806D4CF24AACD3.scriptable _id_231AAE2264CE7F2E();
  _id_7E52B56769FA7774::loothide(_id_F7806D4CF24AACD3.scriptable);
  _id_F7806D4CF24AACD3.scriptable = undefined;
}

_id_BC0879C9AA2863A3(player, instance, _id_3793828403C6873E) {
  if(!instance _id_668FA8D4516F7E15() && !instance _id_5FACFBEE97E1A98E()) {
    return;
  }
  _id_F7806D4CF24AACD3 = _id_0756A52F68962826(player, instance);

  if(!isDefined(_id_F7806D4CF24AACD3)) {
    return;
  }
  if(_id_F7806D4CF24AACD3 _id_668FA8D4516F7E15())
    _id_F7806D4CF24AACD3 _id_D0E46D09A12DD2A9(player);

  _id_F7806D4CF24AACD3._id_3793828403C6873E = _id_3793828403C6873E;
}

_id_6D070B6AD87FC4A2(player, _id_026E51DC5F1CC490, _id_41DCBC4D3302F6DC, _id_8541E31967F0D3C1, _id_B6F2154B2FE59E35) {
  _id_7F81056A779B4777 = undefined;
  _id_56A8547611C8AD7A = _id_96A1620D901981D1(_id_026E51DC5F1CC490, 5);

  if(isDefined(_id_56A8547611C8AD7A))
    _id_7F81056A779B4777 = _id_3A3D1BCCF139DD5B(player, _id_56A8547611C8AD7A, _id_8541E31967F0D3C1);

  _id_922091E401D2375B = undefined;
  _id_87818652E195C716 = _id_96A1620D901981D1(_id_41DCBC4D3302F6DC, 5);

  if(isDefined(_id_87818652E195C716))
    _id_922091E401D2375B = _id_3A3D1BCCF139DD5B(player, _id_87818652E195C716, _id_B6F2154B2FE59E35);

  if(isDefined(_id_7F81056A779B4777))
    _id_7F81056A779B4777._id_3793828403C6873E = _id_B6F2154B2FE59E35;

  if(isDefined(_id_922091E401D2375B))
    _id_922091E401D2375B._id_3793828403C6873E = _id_8541E31967F0D3C1;
}

_id_0756A52F68962826(player, instance) {
  _id_F7806D4CF24AACD3 = undefined;

  if(isDefined(instance._id_84B9876DBE3B246C))
    _id_F7806D4CF24AACD3 = instance._id_84B9876DBE3B246C;
  else if(isDefined(instance.instance))
    _id_F7806D4CF24AACD3 = instance.instance._id_84B9876DBE3B246C;
  else if(isDefined(instance.scriptablename)) {
    _id_27DE1507ED41F01E = _id_96A1620D901981D1(instance.scriptablename, 0);
    _id_F7806D4CF24AACD3 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[player.team][_id_27DE1507ED41F01E];
  }

  _id_F7806D4CF24AACD3._id_C36FC01475B3A4C9 = _id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 6);
  return _id_F7806D4CF24AACD3;
}

_id_D0E46D09A12DD2A9(player, _id_F33DB1522C7885F1) {
  _id_F7806D4CF24AACD3 = self;

  if(!_id_F7806D4CF24AACD3 _id_BD7732605A7843B2(player) && !istrue(_id_F33DB1522C7885F1)) {
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/MISSION_OCCUPIED");
    return 0;
  }

  if(!_id_F7806D4CF24AACD3 _id_EC5207AAEB1D4AD9(player)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
    return 0;
  }

  _id_F7806D4CF24AACD3 thread _id_467F0B7ED16D1567(player, _id_F33DB1522C7885F1);

  if(isDefined(_id_F7806D4CF24AACD3._id_361509C548D93DC9))
    _id_F7806D4CF24AACD3._id_361509C548D93DC9 _id_3DE18BA2E2C30E99(_id_F7806D4CF24AACD3._id_361509C548D93DC9 _id_E5E7DF17C00CA60B());

  return istrue(_id_F33DB1522C7885F1);
}

_id_467F0B7ED16D1567(player, _id_F33DB1522C7885F1) {
  _id_F7806D4CF24AACD3 = self;
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;
  _id_F7806D4CF24AACD3 notify("on_pickup");

  if(!istrue(_id_F33DB1522C7885F1)) {
    _id_F7806D4CF24AACD3.player = player;
    _id_F7806D4CF24AACD3._id_2841F41440CBB817 = undefined;
  }

  if(isDefined(_id_F7806D4CF24AACD3._id_1E4A95A72A733873))
    _id_F7806D4CF24AACD3[[_id_F7806D4CF24AACD3._id_1E4A95A72A733873]](player, _id_F33DB1522C7885F1);

  _id_CCEA330AD0AF8D55 = _id_F7806D4CF24AACD3._id_8499B021054BA877 || level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF;
  _id_F7806D4CF24AACD3 _id_AA97A28838886E60(player, _id_F33DB1522C7885F1, _id_CCEA330AD0AF8D55);
  _id_F7806D4CF24AACD3 _id_7FF595F68388541D(player);
  _id_F7806D4CF24AACD3 _id_405B5950C66270E8();
}

_id_405B5950C66270E8() {
  _id_F7806D4CF24AACD3 = self;
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];
  _id_BA9B215007EB7888 = _id_DB62C0CFC8A661CC _id_1A9EE6A7092D4536();

  if(istrue(_id_B5111CD83B4A3176._id_B6AF7EF8B50C76EE) && istrue(_id_BA9B215007EB7888)) {
    _id_DB62C0CFC8A661CC.state = 3;
    _id_566EBF0873178B74(&"BR_ELITE_BROKEN_ARROW/DEPOSIT_ELEMENTS");
  } else if(istrue(_id_B5111CD83B4A3176._id_48D6C5734103E2B0) && istrue(_id_BA9B215007EB7888)) {
    _id_DB62C0CFC8A661CC.state = 2;
    _id_566EBF0873178B74(&"BR_ELITE_BROKEN_ARROW/WAITING_BOMB");
  }

  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
}

_id_7FF595F68388541D(player) {
  _id_F7806D4CF24AACD3 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];

  if(!istrue(_id_F7806D4CF24AACD3.firstpickup)) {
    return;
  }
  _id_F7806D4CF24AACD3.firstpickup = 0;
  _id_DB62C0CFC8A661CC._id_3451FA20079DE642++;
  _id_DB62C0CFC8A661CC notify("element_pickup_first");
  _id_DB62C0CFC8A661CC _id_99C99B2E9B72C23E(_id_F7806D4CF24AACD3, player);
  _id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D = _id_DB62C0CFC8A661CC._id_876BE3BC4DF3A81D | _id_2C126DE0BDB9BFD5(_id_F7806D4CF24AACD3._id_C36FC01475B3A4C9);
  _id_F7806D4CF24AACD3 _id_8828A851C96AEC21();
  _id_715028F54BAD19A1::_id_F36C99358D254EA9(player, _id_F7806D4CF24AACD3);
  _id_DB62C0CFC8A661CC _id_24B7E8DB343A8D77(player);
  _id_DB62C0CFC8A661CC thread _id_1C9697E4221D99A5();
}

_id_8828A851C96AEC21() {
  _id_F7806D4CF24AACD3 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];
  _id_085E53E70C7110DA = scripts\mp\music_and_dialog::_id_AECAFE54C65C0E35(level.players);
  _id_D5B74FD05CE437E0 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_elite_arrow_element");
  _id_C31F2501156B196B = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_elite_arrow_element_classic");
  _id_7AB5B649FA408138::_id_FE75A89529DD0FD0(_id_085E53E70C7110DA, _id_D5B74FD05CE437E0, undefined, undefined, _id_C31F2501156B196B);

  if(isDefined(game["dialog"]["arrow_collect_element_" + _id_DB62C0CFC8A661CC._id_3451FA20079DE642]))
    _id_DB62C0CFC8A661CC _id_BF0175F3BB67A26D("arrow_collect_element_" + _id_DB62C0CFC8A661CC._id_3451FA20079DE642);

  if(_id_DB62C0CFC8A661CC._id_3451FA20079DE642 >= level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176._id_DEBE9FD67DD91A71.size)
    _id_DB62C0CFC8A661CC _id_4DA2FEDD08554C6E("arrow_collect_element_all");
}

_id_99C99B2E9B72C23E(_id_F7806D4CF24AACD3, player) {
  _id_DB62C0CFC8A661CC = self;
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;
  _id_D95A7788BF7CE976(_id_F7806D4CF24AACD3, player);

  if(_id_DB62C0CFC8A661CC._id_3451FA20079DE642 == _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71.size) {
    scripts\mp\hud_util::showsplashtoteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_elements_acquired");

    if(!isDefined(level._id_C83AA9DBC3654AFA._id_5225CFA34334F492)) {
      scripts\mp\hud_util::showsplashtoallexceptteam(_id_DB62C0CFC8A661CC.targetteam, "elite_arrow_elements_acquired_global", undefined, player);
      level._id_C83AA9DBC3654AFA._id_5225CFA34334F492 = 1;
    }
  }
}

_id_D95A7788BF7CE976(_id_F7806D4CF24AACD3, player) {
  _id_DB62C0CFC8A661CC = self;
  _id_94A02C0997BC05EA = 0;

  foreach(team in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC)
  _id_94A02C0997BC05EA = _id_94A02C0997BC05EA | team._id_876BE3BC4DF3A81D;

  _id_0415D61C3258EA25 = _id_94A02C0997BC05EA &_id_2C126DE0BDB9BFD5(_id_F7806D4CF24AACD3._id_C36FC01475B3A4C9);

  if(!_id_0415D61C3258EA25) {
    _id_83AFA1BB13298AC7 = _id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 11);

    if(isDefined(_id_83AFA1BB13298AC7))
      scripts\mp\hud_util::showsplashtoallexceptteam(_id_F7806D4CF24AACD3.targetteam, _id_83AFA1BB13298AC7, undefined, player);
  }
}

_id_BD7732605A7843B2(player) {
  _id_F7806D4CF24AACD3 = self;

  if(!isDefined(level._id_C83AA9DBC3654AFA))
    return 0;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_803A71BF7E2AFEC9 == 2) {} else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_803A71BF7E2AFEC9 == 1) {
    if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team]))
      return 0;

    if(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team].state == 0)
      return 0;
  } else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_803A71BF7E2AFEC9 == 0) {
    if(_id_F7806D4CF24AACD3.targetteam != player.team)
      return 0;
  }

  return 1;
}

_id_EC5207AAEB1D4AD9(player) {
  _id_F7806D4CF24AACD3 = self;

  if(isDefined(_id_F7806D4CF24AACD3._id_3793828403C6873E)) {
    _id_BDF3BEFC4E719369 = _id_3A3D1BCCF139DD5B(player, _id_F7806D4CF24AACD3._id_27DE1507ED41F01E, _id_F7806D4CF24AACD3._id_3793828403C6873E);

    if(isDefined(_id_BDF3BEFC4E719369) && _id_BDF3BEFC4E719369 == _id_F7806D4CF24AACD3)
      return 1;
  }

  lootid = _id_6844602F3120E900(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E, 5);

  if(!player _id_2D9D24F7C63AC143::_id_3D7E44B7E940DE24(lootid, 1))
    return 0;

  return 1;
}

_id_24B7E8DB343A8D77(player) {
  _id_DB62C0CFC8A661CC = self;
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_29781E8C0705DBDB != 0) {
    return;
  }
  if(_id_DB62C0CFC8A661CC._id_3451FA20079DE642 < _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71.size) {
    return;
  }
  _id_B5111CD83B4A3176 thread _id_29BB7DE765F0C591(player);
}

_id_1C9697E4221D99A5() {
  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_9719A1F9940E8A89)) {
    return;
  }
  _id_DB62C0CFC8A661CC = self;
  _id_B5111CD83B4A3176 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_B5111CD83B4A3176;

  if(_id_DB62C0CFC8A661CC._id_3451FA20079DE642 < _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71.size) {
    return;
  }
  if(isDefined(level._id_C83AA9DBC3654AFA._id_D595B9AF4509BEE5)) {
    return;
  }
  level._id_C83AA9DBC3654AFA._id_D595B9AF4509BEE5 = 1;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_FB5C6A73584DF0C1))
    _id_337BD370F7C5E6F9::_id_44424D94254DFAF5();

  waittime = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_32B459C0D029B500;

  if(isDefined(waittime) && waittime > 0.0)
    wait(waittime);

  eventtype = 3;
  _id_ACA4779F20EC97B3 = 1;
  level thread _id_337BD370F7C5E6F9::runpubliceventoftype(eventtype, _id_ACA4779F20EC97B3);
}

_id_28ECFD94DDA4D7FD() {
  scriptable = self;
  _id_F7806D4CF24AACD3 = scriptable._id_84B9876DBE3B246C;

  if(!isDefined(_id_F7806D4CF24AACD3))
    return 0;

  _id_F7806D4CF24AACD3 thread _id_DA26BB2730074639();
  return 1;
}

_id_DA26BB2730074639() {
  _id_F7806D4CF24AACD3 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];
  level endon("game_ended");
  _id_DB62C0CFC8A661CC endon("on_end");
  position = _id_F7806D4CF24AACD3.scriptable.origin;
  angles = _id_F7806D4CF24AACD3.scriptable.angles;
  _id_F7806D4CF24AACD3 _id_7FEB456A1DDB4048();
  wait 0.25;

  if(istrue(_id_F7806D4CF24AACD3.cleanup)) {
    return;
  }
  scriptable = _id_F7806D4CF24AACD3 _id_8A43BDA3F6BEFEF4(position, angles);
  _id_F7806D4CF24AACD3 _id_545F24B9213213FE(undefined, scriptable);
}

_id_A5130B39363778B7(player, instance, _id_3793828403C6873E) {
  if(!instance _id_668FA8D4516F7E15()) {
    return;
  }
  _id_27DE1507ED41F01E = _id_96A1620D901981D1(instance.type, 0);
  _id_F7806D4CF24AACD3 = _id_3A3D1BCCF139DD5B(player, _id_27DE1507ED41F01E, _id_3793828403C6873E);

  if(!isDefined(_id_F7806D4CF24AACD3)) {
    return;
  }
  _id_F7806D4CF24AACD3 _id_545F24B9213213FE(player, instance);
}

_id_545F24B9213213FE(player, instance) {
  _id_F7806D4CF24AACD3 = self;

  if(isDefined(instance)) {
    _id_F7806D4CF24AACD3 thread _id_B28C6D87EA4CAE30();
    instance scripts\common\utility::_id_57257D1ED9CE2F48(::_id_37DAA6A08797B2CC);
    instance._id_BBC200BC77C5DB2B = 1;
    instance._id_84B9876DBE3B246C = _id_F7806D4CF24AACD3;
    _id_F7806D4CF24AACD3.scriptable = instance;
  }

  if(isDefined(_id_F7806D4CF24AACD3._id_A527B47D4B5014B2))
    _id_F7806D4CF24AACD3[[_id_F7806D4CF24AACD3._id_A527B47D4B5014B2]](player);

  _id_CCEA330AD0AF8D55 = _id_F7806D4CF24AACD3._id_8499B021054BA877 || level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF;
  _id_F7806D4CF24AACD3 _id_E80445BEC743C7A9(player, _id_CCEA330AD0AF8D55);
  _id_F7806D4CF24AACD3.player = undefined;
  _id_F7806D4CF24AACD3._id_3793828403C6873E = undefined;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];

  if(_id_DB62C0CFC8A661CC.state == 2 || _id_DB62C0CFC8A661CC.state == 3) {
    _id_DB62C0CFC8A661CC.state = 1;
    _id_566EBF0873178B74(&"BR_ELITE_BROKEN_ARROW/LOCATE_ELEMENTS");
  }

  _id_DB62C0CFC8A661CC _id_56EE84F1B091647A();
}

_id_65336E6B7ECD0BFC(_id_C36FC01475B3A4C9) {
  heightoffset = -60 + 12 * _id_C36FC01475B3A4C9;
  return heightoffset;
}

_id_B28C6D87EA4CAE30() {
  _id_F7806D4CF24AACD3 = self;
  _id_F7806D4CF24AACD3 notify("watch_circle");
  _id_F7806D4CF24AACD3 endon("watch_circle");
  _id_F7806D4CF24AACD3 endon("on_pickup");
  level endon("game_ended");

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572BB4C60DF2D1B1 <= 0.0) {
    return;
  }
  for(;;) {
    wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572BB4C60DF2D1B1);

    if(!isDefined(_id_F7806D4CF24AACD3.scriptable)) {
      return;
    }
    _id_6FD2D9A208CEF69B = !istrue(level.br_circle_disabled) && !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_F7806D4CF24AACD3.scriptable.origin);

    if(!istrue(_id_6FD2D9A208CEF69B)) {
      continue;
    }
    _id_F7806D4CF24AACD3 _id_25814D59F2CCD689();
    _id_F7806D4CF24AACD3 _id_411359CD8DF47DA0();
  }
}

_id_25814D59F2CCD689() {
  _id_F7806D4CF24AACD3 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_5769C2C60E37943D < 0.0) {
    return;
  }
  if(!isDefined(_id_F7806D4CF24AACD3._id_2841F41440CBB817))
    _id_F7806D4CF24AACD3._id_2841F41440CBB817 = 0.0;

  _id_F7806D4CF24AACD3._id_2841F41440CBB817 = _id_F7806D4CF24AACD3._id_2841F41440CBB817 + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572BB4C60DF2D1B1;

  if(_id_F7806D4CF24AACD3._id_2841F41440CBB817 >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_5769C2C60E37943D) {
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("element_gas_timeout");
  }
}

_id_411359CD8DF47DA0() {
  _id_F7806D4CF24AACD3 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572D9F41A62CC17C < 0.0) {
    return;
  }
  if(!isDefined(_id_F7806D4CF24AACD3) || !isDefined(_id_F7806D4CF24AACD3.scriptable) || !isDefined(_id_F7806D4CF24AACD3.scriptable.origin)) {
    return;
  }
  _id_115E51DB24ACCA46 = !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_F7806D4CF24AACD3.scriptable.origin, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_572D9F41A62CC17C);

  if(istrue(_id_115E51DB24ACCA46)) {
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];

    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      return;
    }
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("element_gas_too_far");
  }
}

_id_F92179DCF9D84BC9(player, _id_27DE1507ED41F01E, _id_3793828403C6873E) {
  _id_B5111CD83B4A3176 = self;
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];
  _id_DB62C0CFC8A661CC endon("on_end");
  _id_F7806D4CF24AACD3 = _id_3A3D1BCCF139DD5B(player, _id_27DE1507ED41F01E, _id_3793828403C6873E);

  if(isDefined(_id_F7806D4CF24AACD3) && istrue(_id_F7806D4CF24AACD3.cleanup)) {
    return;
  }
  _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71[_id_27DE1507ED41F01E]++;
  _id_B5111CD83B4A3176 _id_517E2F9457967425(_id_27DE1507ED41F01E);
  _id_20238D522C76FB01();
  _id_5E7FDF58F111F041();

  if(isDefined(_id_F7806D4CF24AACD3))
    _id_F7806D4CF24AACD3 _id_C1F94114AE475307();

  _id_B5111CD83B4A3176 _id_1395E6FA844B959F(player);

  if(_id_10451FCEDD4D3D6E())
    _id_B5111CD83B4A3176 _id_B0E82AAC43901AE6(player);
}

_id_517E2F9457967425(_id_27DE1507ED41F01E) {
  _id_B5111CD83B4A3176 = self;
  _id_FB72CCEEE7A5CFF3 = 0;

  foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_D43E1B169E506F3B)
  _id_FB72CCEEE7A5CFF3 = _id_FB72CCEEE7A5CFF3 + _id_B5111CD83B4A3176._id_DEBE9FD67DD91A71[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E];

  foreach(_id_DB62C0CFC8A661CC in level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC) {
    if(!isDefined(_id_DB62C0CFC8A661CC)) {
      continue;
    }
    if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam])) {
      continue;
    }
    level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam][_id_27DE1507ED41F01E]._id_A683E11BF953F9B7 = _id_FB72CCEEE7A5CFF3;
  }
}

_id_97C5201A39C968E4() {
  _id_F7806D4CF24AACD3 = self;

  if(!isDefined(_id_F7806D4CF24AACD3.scriptable))
    return "hidden";

  partname = _id_F7806D4CF24AACD3.scriptable _meth_90069777043E7833()[0];
  curstate = _id_F7806D4CF24AACD3.scriptable getscriptablepartstate(partname, 1);
  return curstate;
}

_id_F3548416F24B0F48(_id_9B1941CB7354665E) {
  _id_F7806D4CF24AACD3 = self;

  if(!isDefined(_id_F7806D4CF24AACD3)) {
    return;
  }
  partname = _id_F7806D4CF24AACD3 _meth_90069777043E7833()[0];
  _id_F7806D4CF24AACD3 setscriptablepartstate(partname, _id_9B1941CB7354665E);
}

_id_E6B87EEB3ABC7BE0(_id_27DE1507ED41F01E) {
  _id_60387512CF7DA15D = [];

  if(!isDefined(_id_27DE1507ED41F01E) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements))
    return _id_60387512CF7DA15D;

  foreach(_id_7DBF76A8B1CF08B1 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) {
    if(isDefined(_id_7DBF76A8B1CF08B1[_id_27DE1507ED41F01E]))
      _id_60387512CF7DA15D = scripts\engine\utility::array_add(_id_60387512CF7DA15D, _id_7DBF76A8B1CF08B1[_id_27DE1507ED41F01E]);
  }

  return _id_60387512CF7DA15D;
}

_id_1C40B75ACDD5AF37(_id_9B1941CB7354665E) {
  _id_6DBBE0FB71DF75C1 = undefined;

  if(_id_9B1941CB7354665E == "dropped" || _id_9B1941CB7354665E == "visible")
    _id_6DBBE0FB71DF75C1 = "ground";
  else if(_id_9B1941CB7354665E == "hidden")
    _id_6DBBE0FB71DF75C1 = "player";

  return _id_6DBBE0FB71DF75C1;
}

_id_3957D8D2EA023852(player, _id_C37B1CC67943336D) {
  _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[player.team];

  if(!isDefined(_id_DB62C0CFC8A661CC) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements)) {
    return;
  }
  if(isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam])) {
    foreach(_id_F7806D4CF24AACD3 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements[_id_DB62C0CFC8A661CC.targetteam]) {
      _id_F7806D4CF24AACD3 _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);

      if(isDefined(_id_F7806D4CF24AACD3.scriptable))
        _id_F7806D4CF24AACD3.scriptable _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);
    }
  }
}

_id_37DAA6A08797B2CC() {
  _id_AA6A4CD5972F85B0 = self;
  _id_F7806D4CF24AACD3 = _id_AA6A4CD5972F85B0._id_84B9876DBE3B246C;

  if(isDefined(_id_F7806D4CF24AACD3)) {
    _id_DB62C0CFC8A661CC = level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[_id_F7806D4CF24AACD3.targetteam];
    _id_DB62C0CFC8A661CC thread _id_088A043B99A75E47("element_deleted_in_area_swap");
    return 0;
  }

  return 1;
}

_id_F045C586F2D204CE(player, _id_C37B1CC67943336D, _id_C8251387149387A0) {
  if(!isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105)) {
    return;
  }
  _id_5F2CAD9ADA90D105 = undefined;

  if(isDefined(_id_C8251387149387A0))
    _id_5F2CAD9ADA90D105 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_C8251387149387A0];
  else
    _id_5F2CAD9ADA90D105 = level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[player.team];

  if(!isDefined(_id_5F2CAD9ADA90D105)) {
    return;
  }
  foreach(_id_69E96A4CAA72D794 in _id_5F2CAD9ADA90D105) {
    if(isDefined(_id_69E96A4CAA72D794))
      _id_69E96A4CAA72D794 _id_F5549984B1909638(player, _id_C37B1CC67943336D);
  }
}

_id_A7EE3A5E548C916E(player, _id_27DE1507ED41F01E, _id_C37B1CC67943336D) {
  if(isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements)) {
    foreach(_id_7DBF76A8B1CF08B1 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) {
      _id_16A79800D2FC5D4C = _id_7DBF76A8B1CF08B1[_id_27DE1507ED41F01E];

      if(!isDefined(_id_16A79800D2FC5D4C)) {
        continue;
      }
      _id_16A79800D2FC5D4C _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);

      if(isDefined(_id_16A79800D2FC5D4C.scriptable))
        _id_16A79800D2FC5D4C.scriptable _id_B63A22F9943A3AE8(player, _id_C37B1CC67943336D);
    }
  }
}

_id_43563F93A8AF2E8C(_id_4CF3F1D180AA34E7) {
  _id_F7806D4CF24AACD3 = self;
  _id_F7806D4CF24AACD3 _id_594EFF9E3940A6EE(_id_4CF3F1D180AA34E7);

  if(isDefined(_id_F7806D4CF24AACD3.scriptable))
    _id_F7806D4CF24AACD3.scriptable _id_594EFF9E3940A6EE(_id_4CF3F1D180AA34E7);
}

_id_2D501383CD6A7711() {
  _id_F7806D4CF24AACD3 = self;
  _id_69E00D24A565D9A1 = _id_F7806D4CF24AACD3._id_DB4005060A0C66AF;

  if(isDefined(_id_F7806D4CF24AACD3.scriptable) && isDefined(_id_F7806D4CF24AACD3.scriptable._id_BF8E5F003146AF44) && !istrue(_id_F7806D4CF24AACD3.scriptable._id_BF8E5F003146AF44.isdestroyed))
    _id_69E00D24A565D9A1 = _id_F7806D4CF24AACD3.scriptable._id_BF8E5F003146AF44;

  _id_5AE5E6CD7F0CC727 = (0, 0, 25);

  if(_id_69E00D24A565D9A1 == _id_F7806D4CF24AACD3._id_DB4005060A0C66AF)
    return [_id_69E00D24A565D9A1, _id_5AE5E6CD7F0CC727];

  _id_5AE5E6CD7F0CC727 = (0, 0, 80);
  return [_id_69E00D24A565D9A1, _id_5AE5E6CD7F0CC727];
}

_id_2622FB76607DECE9(_id_860BE8762B9AE62F) {
  _id_F7806D4CF24AACD3 = self;

  switch (_id_F7806D4CF24AACD3._id_27DE1507ED41F01E) {
    case "tri":
      _id_F7806D4CF24AACD3 _id_3B1ECB2735CF8C88(istrue(_id_860BE8762B9AE62F));

      if(istrue(_id_860BE8762B9AE62F))
        _id_F7806D4CF24AACD3 _id_EE40BA68EF2E28AC();

      return;
    case "plu":
      _id_F7806D4CF24AACD3 _id_4F4F8B0CC0803FC3(istrue(_id_860BE8762B9AE62F));
      return;
    case "nep":
      _id_F7806D4CF24AACD3 _id_8932ECA89649C982();
      return;
    case "gal":
      _id_F7806D4CF24AACD3 _id_8E9C04AA5FA8A3DB();
      return;
  }
}

_id_775F98C18204823E() {
  _id_F7806D4CF24AACD3 = self;

  if(isDefined(_id_F7806D4CF24AACD3.player)) {
    if(isDefined(_id_F7806D4CF24AACD3.player.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(_id_F7806D4CF24AACD3.player))
      return _id_F7806D4CF24AACD3.player.vehicle;
    else
      return _id_F7806D4CF24AACD3.player;
  }

  return undefined;
}

_id_A67115AF2229F2F4() {
  _id_F7806D4CF24AACD3 = self;
  _id_4AFEE9FA32892740 = _id_F7806D4CF24AACD3 _id_775F98C18204823E();

  if(isDefined(_id_4AFEE9FA32892740))
    return _id_4AFEE9FA32892740;
  else if(isDefined(_id_F7806D4CF24AACD3.scriptable))
    return _id_F7806D4CF24AACD3.scriptable;
  else if(isDefined(_id_F7806D4CF24AACD3._id_27DE1507ED41F01E) && isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105) && isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_F7806D4CF24AACD3.targetteam]))
    return level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_5F2CAD9ADA90D105[_id_F7806D4CF24AACD3.targetteam][_id_F7806D4CF24AACD3._id_27DE1507ED41F01E];

  return undefined;
}

_id_8D5EC92683359A75(distsq, _id_14C5CAED498445FF) {
  foreach(dist, state in _id_14C5CAED498445FF) {
    _id_C4F50D54CA6B5FAA = squared(dist);

    if(distsq <= _id_C4F50D54CA6B5FAA)
      return state;
  }

  return "off";
}

_id_D24209600567366F(distsq, _id_FCFBA3EDF2106FD1) {
  foreach(dist, _id_6ADA3242ACD08CF5 in _id_FCFBA3EDF2106FD1) {
    _id_4E0C2ADD1E73C9CC = squared(dist);

    if(distsq <= _id_4E0C2ADD1E73C9CC) {
      _id_CD40AC65A2951F58 = _id_6ADA3242ACD08CF5[0];
      _id_CD63C265A2BB9772 = _id_6ADA3242ACD08CF5[1];
      delay = randomfloatrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772);
      return delay;
    }
  }

  return undefined;
}

_id_80B2BE1E9631485F(_id_F7806D4CF24AACD3, player, _id_FCFBA3EDF2106FD1, _id_14C5CAED498445FF) {
  level endon("game_ended");
  player endon("disconnect");
  player._id_248F319D9C9F6C51[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] = thisthread;

  while(!istrue(_id_F7806D4CF24AACD3.cleanup)) {
    _id_334FDFBF05A26EEC = _id_F7806D4CF24AACD3 _id_A67115AF2229F2F4();

    if(isDefined(_id_334FDFBF05A26EEC)) {
      distsq = distancesquared(player.origin, _id_334FDFBF05A26EEC.origin);

      if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8EF9F58B6A7AFE93 == 0 || level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8EF9F58B6A7AFE93 == 1) {
        delay = _id_D24209600567366F(distsq, _id_FCFBA3EDF2106FD1);

        if(isnumber(delay)) {
          if(isDefined(_id_F7806D4CF24AACD3._id_DB4005060A0C66AF))
            _id_F7806D4CF24AACD3._id_DB4005060A0C66AF playsoundtoplayer("evt_elite_arrow_geiger_counter_tick", player, _id_F7806D4CF24AACD3._id_DB4005060A0C66AF);
          else
            player playlocalsound("evt_elite_arrow_geiger_counter_tick");

          wait(delay);
        } else
          break;
      } else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8EF9F58B6A7AFE93 == 2) {
        state = _id_8D5EC92683359A75(distsq, _id_14C5CAED498445FF);
        player._id_8466BE2AB0AB5D00[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] = distsq;
        waittillframeend;
        _id_84D4866087B00608 = distsq;
        _id_F29EFE66D0F3F9E5 = _id_F7806D4CF24AACD3._id_27DE1507ED41F01E;

        if(isarray(player._id_8466BE2AB0AB5D00)) {
          foreach(_id_27DE1507ED41F01E, _id_CBAF4DD17AD2BA13 in player._id_8466BE2AB0AB5D00) {
            if(_id_CBAF4DD17AD2BA13 < _id_84D4866087B00608) {
              _id_84D4866087B00608 = _id_CBAF4DD17AD2BA13;
              _id_F29EFE66D0F3F9E5 = _id_27DE1507ED41F01E;
            }
          }
        }

        if(_id_F29EFE66D0F3F9E5 == _id_F7806D4CF24AACD3._id_27DE1507ED41F01E) {
          if(!isDefined(player._id_7ED9253D93E7C6BD) || player._id_7ED9253D93E7C6BD != state) {
            player._id_7ED9253D93E7C6BD = state;
            player setscriptablepartstate("geiger", state, 0);
          }
        }

        if(state == "off") {
          break;
        } else
          waitframe();
      }

      continue;
    }

    waitframe();
  }

  if(isarray(player._id_8466BE2AB0AB5D00))
    player._id_8466BE2AB0AB5D00[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] = undefined;

  player._id_248F319D9C9F6C51[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E] = undefined;
}

_id_F2E1BF20E302F384(_id_F7806D4CF24AACD3, radius) {
  level endon("game_ended");
  _id_F7806D4CF24AACD3 notify("stop_element_geiger");
  _id_F7806D4CF24AACD3 endon("stop_element_geiger");
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8EF9F58B6A7AFE93 = getdvarint("dvar_D2B336A16E9B3F70", 1);
  level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_716235BDDFB305F0 = getdvarint("dvar_98CB40FB319BCD47", 2304);
  _id_30191FE4B6B233C4 = getdvarint("dvar_98CB40FB319BCD47", 2304);
  radius = scripts\engine\utility::_id_53C4C53197386572(radius, _id_30191FE4B6B233C4);
  _id_CDD57978F51FEF8B = int(radius * 0.03125);
  _id_CDD57878F51FED58 = int(radius * 0.0625);
  _id_CDD57B78F51FF3F1 = int(radius * 0.125);
  _id_CDD57A78F51FF1BE = int(radius * 0.25);
  _id_CDD57D78F51FF857 = int(radius * 0.5);
  _id_CDD57C78F51FF624 = int(radius * 1.0);
  _id_FCFBA3EDF2106FD1 = [];
  _id_FCFBA3EDF2106FD1[_id_CDD57978F51FEF8B] = [0.01, 0.02];
  _id_FCFBA3EDF2106FD1[_id_CDD57878F51FED58] = [0.02, 0.05];
  _id_FCFBA3EDF2106FD1[_id_CDD57B78F51FF3F1] = [0.05, 0.1];
  _id_FCFBA3EDF2106FD1[_id_CDD57A78F51FF1BE] = [0.1, 0.2];
  _id_FCFBA3EDF2106FD1[_id_CDD57D78F51FF857] = [0.2, 0.5];
  _id_FCFBA3EDF2106FD1[_id_CDD57C78F51FF624] = [0.5, 1.0];
  _id_14C5CAED498445FF = [];
  _id_14C5CAED498445FF[_id_CDD57978F51FEF8B] = "100cps";
  _id_14C5CAED498445FF[_id_CDD57878F51FED58] = "50cps";
  _id_14C5CAED498445FF[_id_CDD57B78F51FF3F1] = "20cps";
  _id_14C5CAED498445FF[_id_CDD57A78F51FF1BE] = "10cps";
  _id_14C5CAED498445FF[_id_CDD57D78F51FF857] = "5cps";
  _id_14C5CAED498445FF[_id_CDD57C78F51FF624] = "2cps";

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8EF9F58B6A7AFE93 == 1) {
    _id_F7806D4CF24AACD3._id_DB4005060A0C66AF = spawn("script_model", (0, 0, 0));
    _id_F7806D4CF24AACD3._id_DB4005060A0C66AF setModel("tag_origin");
  }

  while(!istrue(_id_F7806D4CF24AACD3.cleanup)) {
    _id_334FDFBF05A26EEC = _id_F7806D4CF24AACD3 _id_A67115AF2229F2F4();

    if(isDefined(_id_334FDFBF05A26EEC)) {
      position = _id_334FDFBF05A26EEC.origin + (0, 0, 7.5);

      if(isent(_id_F7806D4CF24AACD3._id_DB4005060A0C66AF)) {
        _id_F7806D4CF24AACD3._id_DB4005060A0C66AF.origin = _id_334FDFBF05A26EEC.origin + (0, 0, 7.5);
        position = _id_F7806D4CF24AACD3._id_DB4005060A0C66AF.origin;
      }

      players = getentarrayinradius("player", "classname", position, radius);

      foreach(player in players) {
        _id_690F868C45A96061 = isarray(player._id_248F319D9C9F6C51) && isDefined(player._id_248F319D9C9F6C51[_id_F7806D4CF24AACD3._id_27DE1507ED41F01E]);

        if(!_id_690F868C45A96061)
          player thread _id_80B2BE1E9631485F(_id_F7806D4CF24AACD3, player, _id_FCFBA3EDF2106FD1, _id_14C5CAED498445FF);
      }
    }

    waitframe();
  }

  if(isent(_id_F7806D4CF24AACD3._id_DB4005060A0C66AF)) {
    _id_F7806D4CF24AACD3._id_DB4005060A0C66AF delete();
    _id_F7806D4CF24AACD3._id_DB4005060A0C66AF = undefined;
  }
}

_id_F8BD2935A988BB02() {
  _id_F7806D4CF24AACD3 = self;
  _id_F7806D4CF24AACD3.outlineids = [];
  _id_F7806D4CF24AACD3._id_079EF6BDEF3BF42D = [];
}

_id_BA8F494325EDE6D7(_id_6ACB3CD9C5BB74E9) {
  _id_F7806D4CF24AACD3 = self;

  if(isDefined(_id_F7806D4CF24AACD3._id_079EF6BDEF3BF42D)) {
    foreach(_id_18EBEB29BB7541E3 in _id_F7806D4CF24AACD3._id_079EF6BDEF3BF42D) {
      _id_F7806D4CF24AACD3 _id_653C2166507F3631(_id_18EBEB29BB7541E3);
      _id_F7806D4CF24AACD3 _id_E62674D5DE7043F9(_id_18EBEB29BB7541E3, _id_6ACB3CD9C5BB74E9);
    }
  }

  _id_F7806D4CF24AACD3.outlineids = undefined;
  _id_F7806D4CF24AACD3._id_079EF6BDEF3BF42D = undefined;
}

_id_E62674D5DE7043F9(player, _id_6ACB3CD9C5BB74E9) {
  _id_F7806D4CF24AACD3 = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  _id_F7806D4CF24AACD3 endon("element_cleanup");

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(istrue(player._id_6B4CCFEF38537183))
    player scripts\mp\utility\outline::_hudoutlineviewmodelenable(_id_6ACB3CD9C5BB74E9, 0);
  else
    player scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

_id_F3711BF7CE3191D0(_id_18EBEB29BB7541E3, _id_6ACB3CD9C5BB74E9, prioritygroup) {
  _id_F7806D4CF24AACD3 = self;
  _id_CF03C60B371EFF98 = _id_18EBEB29BB7541E3 getentitynumber();
  id = scripts\mp\utility\outline::outlineenableforall(_id_18EBEB29BB7541E3, _id_6ACB3CD9C5BB74E9, prioritygroup);
  _id_F7806D4CF24AACD3.outlineids[_id_CF03C60B371EFF98] = id;
  _id_F7806D4CF24AACD3._id_079EF6BDEF3BF42D[_id_CF03C60B371EFF98] = _id_18EBEB29BB7541E3;
  _id_18EBEB29BB7541E3._id_6B4CCFEF38537183 = 1;
}

_id_653C2166507F3631(_id_18EBEB29BB7541E3) {
  _id_F7806D4CF24AACD3 = self;

  if(!isDefined(_id_18EBEB29BB7541E3)) {
    return;
  }
  _id_CF03C60B371EFF98 = _id_18EBEB29BB7541E3 getentitynumber();
  id = _id_F7806D4CF24AACD3.outlineids[_id_CF03C60B371EFF98];
  scripts\mp\utility\outline::outlinedisable(id, _id_18EBEB29BB7541E3);
  _id_F7806D4CF24AACD3.outlineids[_id_CF03C60B371EFF98] = undefined;
  _id_F7806D4CF24AACD3._id_079EF6BDEF3BF42D[_id_CF03C60B371EFF98] = undefined;
  _id_18EBEB29BB7541E3._id_6B4CCFEF38537183 = undefined;
}

_id_37748EF3982539D4(player, state, _id_6ACB3CD9C5BB74E9) {
  _id_F7806D4CF24AACD3 = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  foreach(_id_5B5EC4358B49B47E in _id_F7806D4CF24AACD3._id_079EF6BDEF3BF42D) {
    if(!isDefined(_id_5B5EC4358B49B47E)) {
      continue;
    }
    if(state) {
      _id_5B5EC4358B49B47E hudoutlineenableforclient(player, _id_6ACB3CD9C5BB74E9);
      continue;
    }

    _id_5B5EC4358B49B47E hudoutlinedisableforclient(player);
  }
}

_id_A65B28A8FA9423E8(player) {
  if(!isPlayer(player) || !isalive(player))
    return 0;

  if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    return 0;

  if(istrue(player._id_6B4CCFEF38537183))
    return 0;

  return 1;
}

_id_54A65B932BB1233A(_id_F7806D4CF24AACD3, player) {
  player setsoundsubmix("mute_scripted5", 0.1, 0.5);
  player playlocalsound("evt_elite_arrow_element_pickup_swt");
}

_id_EFD43A8E0998D07D(_id_F7806D4CF24AACD3, player) {
  if(!isDefined(player)) {
    return;
  }
  player clearsoundsubmix("mute_scripted5", 0.0);
}

_id_B2E040EF75DE3602(position, radius, height) {
  _id_F7806D4CF24AACD3 = self;
  trigger = spawn("trigger_rotatable_radius", position, 0, radius, height);
  trigger.radius = radius;
  trigger.height = height;
  trigger._id_F7806D4CF24AACD3 = _id_F7806D4CF24AACD3;
  trigger enablelinkTo();
  return trigger;
}

_id_CF631F26161504DB(trigger, _id_599217E02A6DA3FA) {
  if(!isDefined(trigger)) {
    return;
  }
  if(trigger islinked())
    trigger unlink();

  trigger notify("trigger_link");

  if(!isDefined(_id_599217E02A6DA3FA) || !isDefined(_id_599217E02A6DA3FA.origin)) {
    return;
  }
  trigger.origin = _id_599217E02A6DA3FA.origin;
  _id_2DEFF046A09A621C = _id_AA8DAA8BE6051112(trigger);
  trigger.origin = trigger.origin - (0, 0, _id_2DEFF046A09A621C);

  if(isent(_id_599217E02A6DA3FA))
    trigger linkTo(_id_599217E02A6DA3FA);
  else
    thread _id_ECB3F178E27990B3(trigger, _id_599217E02A6DA3FA);
}

_id_ECB3F178E27990B3(trigger, _id_599217E02A6DA3FA) {
  trigger endon("trigger_link");
  trigger endon("destroy");
  _id_599217E02A6DA3FA endon("destroy");
  _id_2DEFF046A09A621C = _id_AA8DAA8BE6051112(trigger);

  for(;;) {
    wait 0.25;

    if(!isDefined(trigger) || !isDefined(_id_599217E02A6DA3FA) || !isDefined(_id_599217E02A6DA3FA.origin)) {
      return;
    }
    trigger.origin = _id_599217E02A6DA3FA.origin;
    trigger.origin = trigger.origin - (0, 0, _id_2DEFF046A09A621C);
  }
}

_id_AA8DAA8BE6051112(trigger) {
  if(isDefined(trigger.height))
    return trigger.height * level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_BC674AA0CFE2F13B;

  return 0.0;
}

_id_B15E5BA7931DBB41() {
  _id_F7806D4CF24AACD3 = self;
  trigger = _id_F7806D4CF24AACD3.trigger;

  if(!isDefined(trigger)) {
    return;
  }
  trigger notify("destroy");
  trigger delete();
  _id_F7806D4CF24AACD3.trigger = undefined;
}

_id_1F21AB99F974FB93(player, trigger, _id_F8048727716242B0, _id_DC97CEC26EEE3B30) {
  if(!isPlayer(player) || !isalive(player) || !isDefined(trigger)) {
    return;
  }
  if(!player istouching(trigger) && !istrue(_id_F8048727716242B0)) {
    return;
  }
  _id_F7806D4CF24AACD3 = trigger._id_F7806D4CF24AACD3;

  if(!isDefined(_id_F7806D4CF24AACD3)) {
    return;
  }
  if(_id_AF54A33C2AC9A71F(player, _id_F7806D4CF24AACD3._id_27DE1507ED41F01E) && !istrue(_id_DC97CEC26EEE3B30)) {
    return;
  }
  if(!isDefined(trigger._id_78122E18403A8DC4))
    trigger._id_78122E18403A8DC4 = [];

  trigger._id_78122E18403A8DC4[player.clientid] = player;
}

_id_44B8AAE5BCDC3081(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }
  waitframe();

  foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
  _id_1F21AB99F974FB93(_id_F85572CD5F6117C6, trigger, 1);
}

_id_95F74C4EEDBBD627(player, trigger, _id_F8048727716242B0) {
  if(!isDefined(player) || !isPlayer(player) || !isDefined(trigger)) {
    return;
  }
  if(player istouching(trigger) && !istrue(_id_F8048727716242B0)) {
    return;
  }
  _id_F7806D4CF24AACD3 = trigger._id_F7806D4CF24AACD3;

  if(!isDefined(_id_F7806D4CF24AACD3)) {
    return;
  }
  if(isDefined(trigger._id_78122E18403A8DC4))
    trigger._id_78122E18403A8DC4[player.clientid] = undefined;
}

_id_685375BBA20333AD(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }
  waitframe();

  foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
  _id_95F74C4EEDBBD627(_id_F85572CD5F6117C6, trigger, 1);
}

_id_6B5ECEBDDC1C6AD3(_id_27DE1507ED41F01E, position, angles) {
  _id_DB62C0CFC8A661CC = self;
  _id_ED7FA851BC0CA94E = _id_DB62C0CFC8A661CC _id_8B73CAE3FC8903B2(_id_27DE1507ED41F01E, 1);
  _id_ED7FA851BC0CA94E._id_8499B021054BA877 = 1;
  _id_ED7FA851BC0CA94E._id_1E4A95A72A733873 = ::_id_BC553BD4C6C01245;
  _id_ED7FA851BC0CA94E._id_A527B47D4B5014B2 = ::_id_B30B6186D630078C;
  _id_ED7FA851BC0CA94E._id_B5163896CAAFC5CD = ::_id_1AE09B9B6A2FF850;
  return _id_ED7FA851BC0CA94E;
}

_id_1AE09B9B6A2FF850() {
  _id_ED7FA851BC0CA94E = self;
  _id_ED7FA851BC0CA94E _id_BA8F494325EDE6D7("outline_nodepth_red");
}

_id_BC553BD4C6C01245(player, _id_F33DB1522C7885F1) {
  _id_ED7FA851BC0CA94E = self;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_ADC0FAD3F842D68F))
    _id_ED7FA851BC0CA94E _id_BA8F494325EDE6D7("outline_nodepth_red");

  if(istrue(_id_F33DB1522C7885F1))
    return;
}

_id_B30B6186D630078C(player) {
  _id_ED7FA851BC0CA94E = self;
  _id_ED7FA851BC0CA94E _id_3F1E807772A2B6FA();
}

_id_3F1E807772A2B6FA(_id_0DD076BC7F2C07BD) {
  _id_ED7FA851BC0CA94E = self;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_77322344F7917DFC)) {
    return;
  }
  _id_ED7FA851BC0CA94E _id_F8BD2935A988BB02();

  if(!isDefined(_id_ED7FA851BC0CA94E.outlinetime) || istrue(_id_0DD076BC7F2C07BD))
    _id_ED7FA851BC0CA94E.outlinetime = 0.0;

  _id_ED7FA851BC0CA94E thread _id_010935396A23FDA6();
}

_id_010935396A23FDA6() {
  _id_ED7FA851BC0CA94E = self;
  level endon("game_ended");
  _id_ED7FA851BC0CA94E endon("death");
  _id_ED7FA851BC0CA94E endon("on_pickup");

  while(!istrue(self.cleanup)) {
    _id_ED7FA851BC0CA94E.outlinetime = _id_ED7FA851BC0CA94E.outlinetime + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_EC24CB21C7F05967;

    if(_id_ED7FA851BC0CA94E.outlinetime >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_879711B450FD9DCE) {
      _id_ED7FA851BC0CA94E _id_58A5EE48F095667B();
      _id_ED7FA851BC0CA94E.outlinetime = 0.0;
    }

    wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_EC24CB21C7F05967);
  }
}

_id_58A5EE48F095667B() {
  _id_ED7FA851BC0CA94E = self;
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_ED7FA851BC0CA94E.targetteam, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    if(!_id_ED7FA851BC0CA94E _id_A65B28A8FA9423E8(player)) {
      continue;
    }
    _id_ED7FA851BC0CA94E thread _id_76D0AB1FD73EA3B3(player);
  }
}

_id_76D0AB1FD73EA3B3(player) {
  _id_ED7FA851BC0CA94E = self;
  level endon("game_ended");
  _id_ED7FA851BC0CA94E endon("death");
  _id_ED7FA851BC0CA94E endon("on_pickup");
  _id_ED7FA851BC0CA94E _id_2B6CCE6F0FA08DE1(player);
  wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_187B15D0D681ED14);
  _id_ED7FA851BC0CA94E _id_E62B6844DB038D40(player);
}

_id_2B6CCE6F0FA08DE1(player) {
  _id_ED7FA851BC0CA94E = self;
  _id_ED7FA851BC0CA94E _id_F3711BF7CE3191D0(player, "outline_nodepth_red", "level_script");
  _id_ED7FA851BC0CA94E thread _id_D6DE0C68A45378FF(player);
}

_id_D6DE0C68A45378FF(player) {
  _id_ED7FA851BC0CA94E = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("ber_outline_end");
  scripts\engine\utility::_id_7B9E0E7CA4B3B940(_id_ED7FA851BC0CA94E, "death", _id_ED7FA851BC0CA94E, "on_pickup", player, "death");
  _id_ED7FA851BC0CA94E _id_E62B6844DB038D40(player);
}

_id_E62B6844DB038D40(player) {
  _id_ED7FA851BC0CA94E = self;

  if(!isDefined(player) || istrue(_id_ED7FA851BC0CA94E.cleanup)) {
    return;
  }
  player notify("ber_outline_end");
  _id_ED7FA851BC0CA94E _id_653C2166507F3631(player);
}

_id_52DC4CB3754B675F(_id_27DE1507ED41F01E, position, angles) {
  _id_DB62C0CFC8A661CC = self;
  _id_CA4ABBC8D230A04B = _id_DB62C0CFC8A661CC _id_8B73CAE3FC8903B2(_id_27DE1507ED41F01E, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF);
  _id_CA4ABBC8D230A04B._id_8499B021054BA877 = 0;
  _id_CA4ABBC8D230A04B._id_1E4A95A72A733873 = ::_id_99F72D5A3CD95101;
  _id_CA4ABBC8D230A04B._id_A527B47D4B5014B2 = ::_id_07970A43AB3E39D0;
  _id_CA4ABBC8D230A04B._id_B5163896CAAFC5CD = ::_id_056ABA4AC9640CEC;
  return _id_CA4ABBC8D230A04B;
}

_id_056ABA4AC9640CEC() {
  _id_CA4ABBC8D230A04B = self;
  _id_CA4ABBC8D230A04B _id_3B1ECB2735CF8C88(0);
}

_id_99F72D5A3CD95101(player, _id_F33DB1522C7885F1) {
  _id_CA4ABBC8D230A04B = self;

  if(istrue(_id_F33DB1522C7885F1)) {
    return;
  }
  _id_CA4ABBC8D230A04B _id_EE40BA68EF2E28AC(_id_CA4ABBC8D230A04B.player);
}

_id_07970A43AB3E39D0(player) {
  _id_CA4ABBC8D230A04B = self;
  _id_CA4ABBC8D230A04B _id_EE40BA68EF2E28AC(_id_CA4ABBC8D230A04B.scriptable);
}

_id_3B1ECB2735CF8C88(_id_860BE8762B9AE62F) {
  _id_CA4ABBC8D230A04B = self;

  if(istrue(_id_860BE8762B9AE62F)) {
    _id_599217E02A6DA3FA = _id_CA4ABBC8D230A04B _id_A67115AF2229F2F4();

    if(!isDefined(_id_599217E02A6DA3FA)) {
      return;
    }
    if(!isDefined(_id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934))
      _id_CA4ABBC8D230A04B _id_B6E96B5151F70773(_id_599217E02A6DA3FA.origin);

    foreach(player in level.players)
    _id_CA4ABBC8D230A04B _id_CC74B7B6A9EA697A(player);
  } else
    _id_CA4ABBC8D230A04B _id_83EE42A34FF018F0();
}

_id_B6E96B5151F70773(position) {
  _id_CA4ABBC8D230A04B = self;

  if(isDefined(_id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934)) {
    return;
  }
  _id_5F3AD9A537BCE934 = spawn("script_model", position);
  _id_5F3AD9A537BCE934 _id_2CA50158D4286139(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_588BA2EC2484B034);
  _id_5F3AD9A537BCE934._id_CA4ABBC8D230A04B = _id_CA4ABBC8D230A04B;
  _id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934 = _id_5F3AD9A537BCE934;
  _id_5F3AD9A537BCE934 _id_36215174C7E56A42();
}

_id_2CA50158D4286139(_id_2C1633FC63896687) {
  _id_5F3AD9A537BCE934 = self;
  _id_5F3AD9A537BCE934._id_88F72D2C0421F8B1 = [];
  _id_5F3AD9A537BCE934._id_CE8EF6E68DF034C7 = 1;

  if(isDefined(_id_2C1633FC63896687))
    _id_5F3AD9A537BCE934._id_32EFB854DF6D5296 = _id_2C1633FC63896687;
}

_id_83EE42A34FF018F0() {
  _id_CA4ABBC8D230A04B = self;

  if(!isDefined(_id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934)) {
    return;
  }
  _id_CA4ABBC8D230A04B _id_E1EC969B1C8D92D7();
  _id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934 _id_30D9221820E966FA();
  _id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934 notify("destroy");
  _id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934 delete();
}

_id_EE40BA68EF2E28AC(_id_599217E02A6DA3FA) {
  _id_CA4ABBC8D230A04B = self;

  if(!isDefined(_id_599217E02A6DA3FA))
    _id_599217E02A6DA3FA = _id_A67115AF2229F2F4();

  _id_CF631F26161504DB(_id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934, _id_599217E02A6DA3FA);
}

_id_19723E62D956D201(player) {
  if(!isDefined(level._id_C83AA9DBC3654AFA) || !isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements)) {
    return;
  }
  foreach(_id_7DBF76A8B1CF08B1 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) {
    if(!isDefined(_id_7DBF76A8B1CF08B1["tri"])) {
      continue;
    }
    _id_CA4ABBC8D230A04B = _id_7DBF76A8B1CF08B1["tri"];
    _id_CA4ABBC8D230A04B _id_CC74B7B6A9EA697A(player);
  }
}

_id_CC74B7B6A9EA697A(player) {
  _id_CA4ABBC8D230A04B = self;

  if(!_id_CA4ABBC8D230A04B _id_4E1F3F888738797F(player.team)) {
    return;
  }
  _id_CA4ABBC8D230A04B _id_B6DA015AA819A984(player);
}

_id_4E1F3F888738797F(team) {
  _id_CA4ABBC8D230A04B = self;

  if(!isDefined(_id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934))
    return 0;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AD7AD59EBFDAE08C == 2) {} else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AD7AD59EBFDAE08C == 1) {
    if(!isDefined(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[team]))
      return 0;

    if(level._id_C83AA9DBC3654AFA._id_DB62C0CFC8A661CC[team].state == 0)
      return 0;
  } else if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AD7AD59EBFDAE08C == 0) {
    if(_id_CA4ABBC8D230A04B.targetteam != team)
      return 0;
  }

  return 1;
}

_id_B6DA015AA819A984(player) {
  _id_CA4ABBC8D230A04B = self;

  if(!isDefined(_id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934)) {
    return;
  }
  player scripts\cp_mp\killstreaks\helper_drone::helperdrone_setscramblerjammed(1, _id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934, 1, 1);
}

_id_E1EC969B1C8D92D7() {
  _id_CA4ABBC8D230A04B = self;

  if(!isDefined(_id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934)) {
    return;
  }
  foreach(player in level.players)
  player scripts\cp_mp\killstreaks\helper_drone::helperdrone_setscramblerjammed(0, _id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934, 1, 1);

  _id_CA4ABBC8D230A04B._id_5F3AD9A537BCE934 scripts\cp_mp\killstreaks\helper_drone::helperdrone_endscramblereffect();
}

_id_36215174C7E56A42() {
  _id_5F3AD9A537BCE934 = self;

  if(!istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8875BE3CE5A370D4)) {
    return;
  }
  _id_5F3AD9A537BCE934.vehicles = [];
  _id_5F3AD9A537BCE934 thread _id_3E5679CBF0FCB3FE();
}

_id_30D9221820E966FA() {
  _id_5F3AD9A537BCE934 = self;

  foreach(vehicle in _id_5F3AD9A537BCE934.vehicles)
  _id_5F3AD9A537BCE934 _id_CD8EBC4B7610BCFD(vehicle);

  _id_5F3AD9A537BCE934.vehicles = undefined;
}

_id_3E5679CBF0FCB3FE() {
  _id_5F3AD9A537BCE934 = self;
  _id_5F3AD9A537BCE934 endon("death");

  for(;;) {
    foreach(vehicles in level.vehicle.instances) {
      foreach(vehicle in vehicles) {
        if(!_id_5F3AD9A537BCE934 _id_2A9E351A772FC5CD(vehicle)) {
          continue;
        }
        _id_5F3AD9A537BCE934 thread _id_D3243B5CEBDDD038(vehicle);
      }
    }

    wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D583139D37B99DDF);
  }
}

_id_2A9E351A772FC5CD(vehicle) {
  _id_5F3AD9A537BCE934 = self;
  _id_CA4ABBC8D230A04B = _id_5F3AD9A537BCE934._id_CA4ABBC8D230A04B;

  if(!isDefined(_id_CA4ABBC8D230A04B) || !isDefined(vehicle))
    return 0;

  if(istrue(vehicle._id_8875BE3CE5A370D4))
    return 0;

  vehicleteam = vehicle.team;

  if(isDefined(vehicle.owner))
    vehicleteam = vehicle.owner.team;

  if(!_id_CA4ABBC8D230A04B _id_4E1F3F888738797F(vehicleteam))
    return 0;

  _id_F7DC57D731F3F0AE = vehicle getboundshalfsize();
  _id_24AD3E29CF78B701 = _id_F7DC57D731F3F0AE[0];
  dist = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_762EB6F1E9724FEA + _id_24AD3E29CF78B701;
  distsq = squared(dist);

  if(distancesquared(vehicle.origin, _id_5F3AD9A537BCE934.origin) > distsq)
    return 0;

  return 1;
}

_id_D3243B5CEBDDD038(vehicle) {
  _id_5F3AD9A537BCE934 = self;
  _id_5F3AD9A537BCE934 endon("death");
  vehicle endon("death");
  _id_5F3AD9A537BCE934 _id_53FB5135D0684784(vehicle);
  wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6DE843516FB84235);
  _id_5F3AD9A537BCE934 _id_CD8EBC4B7610BCFD(vehicle);
}

_id_53FB5135D0684784(vehicle) {
  _id_5F3AD9A537BCE934 = self;
  vehicle._id_8875BE3CE5A370D4 = 1;
  _id_5F3AD9A537BCE934.vehicles[vehicle getentitynumber()] = vehicle;
  objweapon = makeweapon("emp_pulse_mp");
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(_id_5F3AD9A537BCE934, vehicle, 1, objweapon, "MOD_EXPLOSIVE", _id_5F3AD9A537BCE934, _id_5F3AD9A537BCE934.origin);
  time = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_6DE843516FB84235 + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D583139D37B99DDF;
  thread scripts\cp_mp\emp_debuff::_id_662905D3B9455612(data, time, 0);

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_1D37E435E474B707))
    vehicle _meth_65AA053C077C003A(1);
}

_id_CD8EBC4B7610BCFD(vehicle) {
  _id_5F3AD9A537BCE934 = self;

  if(!isDefined(vehicle)) {
    return;
  }
  vehicle._id_8875BE3CE5A370D4 = undefined;
  _id_5F3AD9A537BCE934.vehicles[vehicle getentitynumber()] = undefined;

  if(istrue(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_1D37E435E474B707))
    vehicle _meth_65AA053C077C003A(0);
}

_id_6253104CC59C4F29(_id_27DE1507ED41F01E, position, angles) {
  _id_DB62C0CFC8A661CC = self;
  _id_223C23FDCE71AF72 = _id_DB62C0CFC8A661CC _id_8B73CAE3FC8903B2(_id_27DE1507ED41F01E, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF);
  _id_223C23FDCE71AF72._id_8499B021054BA877 = 0;
  _id_223C23FDCE71AF72._id_1E4A95A72A733873 = ::_id_410102769F042583;
  _id_223C23FDCE71AF72._id_A527B47D4B5014B2 = ::_id_8A8A6D0BD987A462;
  _id_223C23FDCE71AF72._id_B5163896CAAFC5CD = ::_id_2AC4A2695AD6E57A;
  _id_223C23FDCE71AF72 _id_9B12D9ADBC63A390(position, 0);
  return _id_223C23FDCE71AF72;
}

_id_2AC4A2695AD6E57A() {
  _id_223C23FDCE71AF72 = self;
  _id_223C23FDCE71AF72 _id_DCC65DCB67F1A539();
}

_id_410102769F042583(player, _id_F33DB1522C7885F1) {
  _id_223C23FDCE71AF72 = self;

  if(istrue(_id_223C23FDCE71AF72.firstpickup))
    _id_223C23FDCE71AF72._id_F542D3F854D1B90D = 1;

  if(istrue(_id_F33DB1522C7885F1)) {
    return;
  }
  _id_223C23FDCE71AF72 _id_312C406AE0CEEC92(player);
}

_id_312C406AE0CEEC92(player) {
  _id_223C23FDCE71AF72 = self;
  player _id_36F999A7C7ED0D32(0, "elite_arrow_plutonium_far");
  player _id_36F999A7C7ED0D32(1, "elite_arrow_plutonium_close", 1.0);
  _id_223C23FDCE71AF72 _id_30FFFBB28E03BF3C(1, scripts\engine\utility::getfx("arrow_plutonium_close"), _id_223C23FDCE71AF72._id_DB4005060A0C66AF, player);
  _id_CF631F26161504DB(_id_223C23FDCE71AF72.trigger, player);

  if(isDefined(_id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4)) {
    foreach(_id_F6C27256472A15A4 in _id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4) {
      if(!isDefined(_id_F6C27256472A15A4)) {
        continue;
      }
      if(_id_F6C27256472A15A4 != player)
        _id_6BA8CBF3F6545034(_id_F6C27256472A15A4, _id_223C23FDCE71AF72.trigger);
    }
  }
}

_id_8A8A6D0BD987A462(player) {
  _id_223C23FDCE71AF72 = self;
  _id_223C23FDCE71AF72 _id_CF67B97C62474F0F();
}

_id_CF67B97C62474F0F() {
  _id_223C23FDCE71AF72 = self;
  _id_CF631F26161504DB(_id_223C23FDCE71AF72.trigger, _id_223C23FDCE71AF72.scriptable);

  if(!isDefined(_id_223C23FDCE71AF72.player)) {
    return;
  }
  _id_223C23FDCE71AF72.player _id_36F999A7C7ED0D32(0, "elite_arrow_plutonium_close");

  if(isDefined(_id_223C23FDCE71AF72._id_DB4005060A0C66AF))
    _id_223C23FDCE71AF72 _id_30FFFBB28E03BF3C(0, scripts\engine\utility::getfx("arrow_plutonium_close"), _id_223C23FDCE71AF72._id_DB4005060A0C66AF, _id_223C23FDCE71AF72.player);

  foreach(_id_7DBF76A8B1CF08B1 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) {
    if(!isDefined(_id_7DBF76A8B1CF08B1["plu"])) {
      continue;
    }
    trigger = _id_7DBF76A8B1CF08B1["plu"].trigger;
    _id_6BA8CBF3F6545034(_id_223C23FDCE71AF72.player, trigger, undefined, 1);
  }
}

_id_4F4F8B0CC0803FC3(_id_860BE8762B9AE62F) {
  _id_223C23FDCE71AF72 = self;
  _id_223C23FDCE71AF72._id_F542D3F854D1B90D = istrue(_id_860BE8762B9AE62F);

  if(istrue(_id_860BE8762B9AE62F)) {
    if(isDefined(_id_223C23FDCE71AF72._id_DB4005060A0C66AF))
      _id_223C23FDCE71AF72 _id_30FFFBB28E03BF3C(1, scripts\engine\utility::getfx("arrow_plutonium_far"), _id_223C23FDCE71AF72._id_DB4005060A0C66AF);

    if(isDefined(_id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4)) {
      foreach(player in _id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4)
      _id_6BA8CBF3F6545034(player, _id_223C23FDCE71AF72.trigger);
    }
  } else if(isDefined(_id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4)) {
    if(isDefined(_id_223C23FDCE71AF72._id_DB4005060A0C66AF)) {
      _id_223C23FDCE71AF72 _id_30FFFBB28E03BF3C(0, scripts\engine\utility::getfx("arrow_plutonium_far"), _id_223C23FDCE71AF72._id_DB4005060A0C66AF);
      _id_223C23FDCE71AF72 _id_30FFFBB28E03BF3C(0, scripts\engine\utility::getfx("arrow_plutonium_close"), _id_223C23FDCE71AF72._id_DB4005060A0C66AF);
    }

    foreach(player in _id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4)
    _id_E7D74F537AD78F5A(player, _id_223C23FDCE71AF72.trigger);
  }
}

_id_9B12D9ADBC63A390(position, _id_F6106F1E37F0B658) {
  _id_223C23FDCE71AF72 = self;
  _id_223C23FDCE71AF72.trigger = _id_223C23FDCE71AF72 _id_E0CFB24E950AACE9(position, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_638730E568DEA417, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D46D4318A15EE3FE);
  _id_223C23FDCE71AF72 thread _id_F5C198EA628D986F();
  _id_223C23FDCE71AF72._id_F542D3F854D1B90D = _id_F6106F1E37F0B658;
}

_id_DCC65DCB67F1A539() {
  _id_223C23FDCE71AF72 = self;

  if(isDefined(_id_223C23FDCE71AF72.player))
    _id_223C23FDCE71AF72.player _id_36F999A7C7ED0D32(0, "elite_arrow_plutonium_close");

  if(isDefined(_id_223C23FDCE71AF72.trigger) && isDefined(_id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4)) {
    foreach(player in _id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4)
    _id_E7D74F537AD78F5A(player, _id_223C23FDCE71AF72.trigger, 1);
  }

  if(isDefined(_id_223C23FDCE71AF72._id_DB4005060A0C66AF)) {
    _id_223C23FDCE71AF72 _id_30FFFBB28E03BF3C(0, scripts\engine\utility::getfx("arrow_plutonium_far"), _id_223C23FDCE71AF72._id_DB4005060A0C66AF);
    _id_223C23FDCE71AF72 _id_30FFFBB28E03BF3C(0, scripts\engine\utility::getfx("arrow_plutonium_close"), _id_223C23FDCE71AF72._id_DB4005060A0C66AF);
  }

  _id_223C23FDCE71AF72 _id_B15E5BA7931DBB41();
}

_id_F5C198EA628D986F() {
  _id_223C23FDCE71AF72 = self;
  level endon("game_ended");
  _id_223C23FDCE71AF72 endon("element_cleanup");

  for(;;) {
    if(!istrue(_id_223C23FDCE71AF72._id_F542D3F854D1B90D)) {
      wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B68FCB1B5D940382);
      continue;
    }

    _id_223C23FDCE71AF72 _id_BBE6C5E8750D96D2();
    _id_223C23FDCE71AF72 _id_258C5FD2E0E24E7E();
    wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B68FCB1B5D940382);
  }
}

_id_BBE6C5E8750D96D2() {
  _id_223C23FDCE71AF72 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_84AA1B04A3F96808 <= 0) {
    return;
  }
  if(!isDefined(level.vehicle) || !isDefined(_id_223C23FDCE71AF72.trigger)) {
    return;
  }
  _id_2DEFF046A09A621C = _id_AA8DAA8BE6051112(_id_223C23FDCE71AF72.trigger);
  damageorigin = _id_223C23FDCE71AF72.trigger.origin + (0, 0, _id_2DEFF046A09A621C);
  damageradius = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_638730E568DEA417;
  _id_C4C191BEFB977DB0 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_84AA1B04A3F96808;

  foreach(vehicles in level.vehicle.instances) {
    foreach(vehicle in vehicles) {
      if(!isDefined(vehicle)) {
        continue;
      }
      if(distance2dsquared(vehicle.origin, damageorigin) > squared(damageradius)) {
        continue;
      }
      if(!isDefined(vehicle._id_B2EE58922A98CEA6))
        vehicle._id_B2EE58922A98CEA6 = 0.0;

      vehicle._id_B2EE58922A98CEA6 = vehicle._id_B2EE58922A98CEA6 + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B68FCB1B5D940382;

      if(vehicle._id_B2EE58922A98CEA6 < level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_851FFE073082048A) {
        continue;
      }
      vehicle dodamage(_id_C4C191BEFB977DB0, vehicle.origin, undefined, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"));
      vehicle._id_B2EE58922A98CEA6 = 0.0;
    }
  }
}

_id_258C5FD2E0E24E7E() {
  _id_223C23FDCE71AF72 = self;

  foreach(player in _id_223C23FDCE71AF72.trigger._id_78122E18403A8DC4) {
    if(!isDefined(player)) {
      continue;
    }
    if(!player istouching(_id_223C23FDCE71AF72.trigger) && !isDefined(player.vehicle)) {
      _id_E7D74F537AD78F5A(player, _id_223C23FDCE71AF72.trigger);
      continue;
    }

    if(!isDefined(player._id_B2EE58922A98CEA6))
      player._id_B2EE58922A98CEA6 = 0.0;

    player._id_B2EE58922A98CEA6 = player._id_B2EE58922A98CEA6 + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_B68FCB1B5D940382;

    if(_id_AF54A33C2AC9A71F(player, _id_223C23FDCE71AF72._id_27DE1507ED41F01E) && player._id_B2EE58922A98CEA6 >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AB026FC2A155136D) {
      _id_1BBBF7A70EA21B15();
      player._id_B2EE58922A98CEA6 = 0.0;
      continue;
    }

    if(player._id_B2EE58922A98CEA6 >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_4472A2372DDC2CC0) {
      _id_804448EC7E835C44(player);
      player._id_B2EE58922A98CEA6 = 0.0;
    }
  }
}

_id_804448EC7E835C44(player) {
  _id_223C23FDCE71AF72 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_393D26E0E968F852 <= 0) {
    return;
  }
  trigger = _id_223C23FDCE71AF72.trigger;

  if(!isDefined(trigger)) {
    return;
  }
  if(_id_AF54A33C2AC9A71F(player, "plu")) {
    return;
  }
  damage = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_393D26E0E968F852;
  player dodamage(damage, _id_223C23FDCE71AF72.trigger.origin, player, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"), "torso_upper");
  player _id_36F999A7C7ED0D32(1, "elite_arrow_plutonium_far");
  player playlocalsound("evt_elite_arrow_plutonium_damage");
}

_id_1BBBF7A70EA21B15() {
  _id_223C23FDCE71AF72 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F5BFD8CF641D707 <= 0) {
    return;
  }
  if(!isDefined(_id_223C23FDCE71AF72.player) || !isPlayer(_id_223C23FDCE71AF72.player)) {
    return;
  }
  damage = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8F5BFD8CF641D707;
  player = _id_223C23FDCE71AF72.player;
  player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"), "torso_upper");
  player playlocalsound("evt_elite_arrow_plutonium_damage");
}

_id_E0CFB24E950AACE9(position, radius, height) {
  _id_223C23FDCE71AF72 = self;
  trigger = _id_223C23FDCE71AF72 _id_B2E040EF75DE3602(position, radius, height);
  trigger.targetname = "pluTrigger";
  scripts\mp\utility\trigger::makeenterexittrigger(trigger, ::_id_6BA8CBF3F6545034, ::_id_E7D74F537AD78F5A);
  return trigger;
}

_id_6BA8CBF3F6545034(entity, trigger, _id_F8048727716242B0, _id_DC97CEC26EEE3B30) {
  if(!isDefined(entity) || !isPlayer(entity)) {
    return;
  }
  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread _id_44B8AAE5BCDC3081(entity, trigger);
    return;
  }

  _id_1F21AB99F974FB93(entity, trigger, _id_F8048727716242B0, _id_DC97CEC26EEE3B30);
  _id_223C23FDCE71AF72 = trigger._id_F7806D4CF24AACD3;

  if(!isDefined(_id_223C23FDCE71AF72)) {
    return;
  }
  if(istrue(_id_223C23FDCE71AF72._id_F542D3F854D1B90D) && (!entity _id_9BBF676EE447B21A("elite_arrow_plutonium_close") || istrue(_id_DC97CEC26EEE3B30)))
    entity _id_36F999A7C7ED0D32(1, "elite_arrow_plutonium_far", 1.0);
}

_id_E7D74F537AD78F5A(entity, trigger, _id_F8048727716242B0) {
  if(!isDefined(entity) || !isPlayer(entity)) {
    return;
  }
  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread _id_685375BBA20333AD(entity, trigger);
    return;
  }

  _id_95F74C4EEDBBD627(entity, trigger, _id_F8048727716242B0);
  entity _id_36F999A7C7ED0D32(0, "elite_arrow_plutonium_far");
}

_id_36F999A7C7ED0D32(visible, _id_FC0043E95242D5CB, _id_647B7CD7ECE0574A) {
  player = self;

  if(istrue(visible)) {
    if(!_id_9BBF676EE447B21A(_id_FC0043E95242D5CB))
      player scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer(_id_FC0043E95242D5CB, _id_647B7CD7ECE0574A);
  } else if(_id_9BBF676EE447B21A(_id_FC0043E95242D5CB))
    player scripts\cp_mp\utility\game_utility::_visionunsetnakedforplayer(_id_FC0043E95242D5CB);
}

_id_9BBF676EE447B21A(_id_FC0043E95242D5CB) {
  player = self;
  return isDefined(player.activevisionsetlist) && isDefined(player.activevisionsetlist[_id_FC0043E95242D5CB]);
}

_id_30FFFBB28E03BF3C(visible, id, ent, player) {
  _id_223C23FDCE71AF72 = self;

  if(istrue(visible)) {
    if(isDefined(player))
      playfxontagforclients(id, ent, "tag_origin", player);
    else
      playFXOnTag(id, ent, "tag_origin");
  } else if(isDefined(player))
    stopfxontagforclients(id, ent, "tag_origin", player);
  else
    stopFXOnTag(id, ent, "tag_origin");
}

_id_D35BBFF23005617E(_id_27DE1507ED41F01E, position, angles) {
  _id_DB62C0CFC8A661CC = self;
  _id_B98E5A8BFDF4A321 = _id_DB62C0CFC8A661CC _id_8B73CAE3FC8903B2(_id_27DE1507ED41F01E, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF);
  _id_B98E5A8BFDF4A321._id_7F27AFDE2CB12DD7 = 0;
  _id_B98E5A8BFDF4A321._id_8499B021054BA877 = 0;
  _id_B98E5A8BFDF4A321._id_1E4A95A72A733873 = ::_id_609F1F6343DA9422;
  _id_B98E5A8BFDF4A321._id_A527B47D4B5014B2 = ::_id_038DBEC19E95AF4B;
  _id_B98E5A8BFDF4A321._id_B5163896CAAFC5CD = ::_id_CCA3EEE7512BE19D;
  return _id_B98E5A8BFDF4A321;
}

_id_CCA3EEE7512BE19D() {
  _id_B98E5A8BFDF4A321 = self;
  _id_B98E5A8BFDF4A321 _id_F22AD532DDD207BD();
}

_id_98FD63DA9FF160CB(player, value) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  player _id_3B64EB40368C1450::set("deuterium_controls_restrictions", "slide", istrue(value));
  player _id_3B64EB40368C1450::set("deuterium_controls_restrictions", "dtp", istrue(value));
}

_id_609F1F6343DA9422(player, _id_F33DB1522C7885F1) {
  _id_B98E5A8BFDF4A321 = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(istrue(_id_B98E5A8BFDF4A321.firstpickup))
    _id_B98E5A8BFDF4A321._id_7F27AFDE2CB12DD7 = 1;

  if(istrue(_id_F33DB1522C7885F1)) {
    return;
  }
  _id_B98E5A8BFDF4A321 thread _id_D665DD034AD7E956();
}

_id_038DBEC19E95AF4B(player) {
  _id_B98E5A8BFDF4A321 = self;
  _id_B98E5A8BFDF4A321 notify("deuterium_dropped");
  _id_B98E5A8BFDF4A321 _id_F22AD532DDD207BD();
}

_id_F22AD532DDD207BD() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;

  if(!isDefined(player)) {
    return;
  }
  _id_B98E5A8BFDF4A321 _id_A79B0A65151888A5();
  player.movespeedscaler = 1.0;
  player scripts\mp\weapons::updatemovespeedscale();
  player._id_0236CC13E39EF474 = 1.0;
  player _meth_9354C4C50C43ABC0(player._id_0236CC13E39EF474);
  _id_98FD63DA9FF160CB(player, 1);
  player._id_DC6DC154664CF0AA = undefined;
}

_id_D665DD034AD7E956() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;
  level endon("game_ended");
  player endon("death_or_disconnect");
  _id_B98E5A8BFDF4A321 endon("element_cleanup");
  _id_B98E5A8BFDF4A321 endon("deuterium_dropped");
  _id_98FD63DA9FF160CB(player, 0);
  player._id_DC6DC154664CF0AA = ::_id_1053E1C33A004DA2;
  _id_B98E5A8BFDF4A321 thread _id_85A7735661B9312B();

  for(;;) {
    if(istrue(_id_B98E5A8BFDF4A321._id_7F27AFDE2CB12DD7)) {
      _id_B98E5A8BFDF4A321 _id_43284E0BCA45D52E();
      _id_B98E5A8BFDF4A321 _id_88C5A729BC233116();
    }

    waitframe();
  }
}

_id_1053E1C33A004DA2() {
  player = self;

  if(player _meth_635E39FC16A64657())
    _id_F9FA7B3DE81FB81A = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7325CE521FC5E3E7;
  else
    _id_F9FA7B3DE81FB81A = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AA657343E38C0C5C;

  return _id_F9FA7B3DE81FB81A;
}

_id_CCB7898D9AF41C88() {
  player = self;

  if(player _id_73F8D05A3E66BC13())
    return 0;

  if(isDefined(player.vehicle))
    return 0;

  if(player isonladder())
    return 0;

  if(player _meth_9CC921A57FF4DEB5())
    return 0;

  return 1;
}

_id_88C5A729BC233116() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;

  if(!isDefined(player)) {
    return;
  }
  if(!player _id_CCB7898D9AF41C88()) {
    _id_B98E5A8BFDF4A321 _id_A79B0A65151888A5();
    return;
  }

  if(!isDefined(player._id_AA390A45E46F9E6A) || !isDefined(player._id_F59B62DE990A2665)) {
    return;
  }
  switch (player._id_AA390A45E46F9E6A) {
    case 0:
      if(player._id_F59B62DE990A2665 == 0) {
        if(istrue(_id_B98E5A8BFDF4A321._id_CC9EDBA11E6801CB))
          _id_B98E5A8BFDF4A321 _id_A79B0A65151888A5();
      } else if(!istrue(_id_B98E5A8BFDF4A321._id_F939666ECA588C56))
        _id_B98E5A8BFDF4A321 _id_AEC4CF5F49F0125E();

      break;
    case 1:
      if(player._id_F59B62DE990A2665 == 2) {
        if(!istrue(_id_B98E5A8BFDF4A321._id_F939666ECA588C56))
          _id_B98E5A8BFDF4A321 _id_AEC4CF5F49F0125E();
      } else if(player._id_F59B62DE990A2665 == 0)
        _id_B98E5A8BFDF4A321 thread _id_3E6F2483E68D5AA4();

      break;
  }
}

_id_3E6F2483E68D5AA4() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;
  _id_B98E5A8BFDF4A321 endon("deuterium_dropped");
  _id_B98E5A8BFDF4A321 endon("cough_cleared");
  wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_92FB78CA5AF82FE4);

  while(!player isonground())
    waitframe();

  if(!istrue(_id_B98E5A8BFDF4A321._id_F939666ECA588C56))
    _id_B98E5A8BFDF4A321 _id_AEC4CF5F49F0125E();
}

_id_85A7735661B9312B() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;
  level endon("game_ended");
  player endon("death_or_disconnect");
  _id_B98E5A8BFDF4A321 endon("element_cleanup");
  _id_B98E5A8BFDF4A321 endon("deuterium_dropped");

  for(;;) {
    if(istrue(_id_B98E5A8BFDF4A321._id_7F27AFDE2CB12DD7) && isDefined(player) && isPlayer(player)) {
      if(_id_AF54A33C2AC9A71F(player, _id_B98E5A8BFDF4A321._id_27DE1507ED41F01E)) {
        if(player _id_73F8D05A3E66BC13()) {
          _id_B98E5A8BFDF4A321 _id_A79B0A65151888A5();
          player._id_0236CC13E39EF474 = _id_B7C53C2FCC583ABC();

          if(isDefined(player._id_0236CC13E39EF474) && player._id_0236CC13E39EF474 > 0)
            player _meth_9354C4C50C43ABC0(player._id_0236CC13E39EF474);
        } else if(player isonground()) {
          player.movespeedscaler = _id_172CA277E45EB80F();

          if(isDefined(player.movespeedscaler) && player.movespeedscaler > 0)
            player scripts\mp\weapons::updatemovespeedscale();
        }
      }
    }

    waitframe();
  }
}

_id_43284E0BCA45D52E() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(_id_AF54A33C2AC9A71F(player, _id_B98E5A8BFDF4A321._id_27DE1507ED41F01E)) {
    if(!player _id_CCB7898D9AF41C88()) {
      player._id_F59B62DE990A2665 = 0;
      player._id_AA390A45E46F9E6A = 0;
      return;
    }

    if(player isonground()) {
      _id_F9276359D14FEBC5 = player issupersprinting();
      _id_EB87B217FF29DE88 = !istrue(_id_F9276359D14FEBC5) && player issprinting();

      if(isDefined(player._id_AA390A45E46F9E6A))
        player._id_F59B62DE990A2665 = player._id_AA390A45E46F9E6A;

      if(istrue(_id_F9276359D14FEBC5))
        player._id_AA390A45E46F9E6A = 2;
      else if(istrue(_id_EB87B217FF29DE88))
        player._id_AA390A45E46F9E6A = 1;
      else
        player._id_AA390A45E46F9E6A = 0;

      if(!isDefined(player._id_F59B62DE990A2665) && isDefined(player._id_AA390A45E46F9E6A))
        player._id_F59B62DE990A2665 = player._id_AA390A45E46F9E6A;
    }
  }
}

_id_B7C53C2FCC583ABC() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;

  if(!isDefined(player)) {
    return;
  }
  if(player _meth_E40102956C887F7C() && player _meth_6F55D55CCFF20D14()) {
    if(player _meth_635E39FC16A64657())
      return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_C1BCEFE508528799;
    else
      return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_57E8127D75FC9DA9;
  } else if(player _meth_635E39FC16A64657())
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_F9F69D98D83B83C9;
  else
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A4830E9532F7FC59;
}

_id_172CA277E45EB80F() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;

  if(!isDefined(player)) {
    return;
  }
  if(player issprinting())
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CE33E905A8335D56;
  else if(player issupersprinting() || player _meth_038932CC1EF28756())
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_EB5B985CBA8997F9;
  else if(player crouchbuttonPressed() || player getstance() == "crouch" || player getstance() == "prone")
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_38EAC2A5C514C498;
  else if(player issprintsliding())
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_D0B83C7B63C98011;
  else
    return level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_1B9DDC66EA9DC058;
}

_id_73F8D05A3E66BC13() {
  player = self;
  return isDefined(player) && (player _id_4B87F2871B6B025C::_id_C5B59EA2A6C2A709() || player _id_4B87F2871B6B025C::_id_1CF18F5E612E68C5());
}

_id_AEC4CF5F49F0125E() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  player thread scripts\mp\equipment\gas_grenade::gas_applyblur();

  if(!istrue(player.gascoughinprogress)) {
    player thread scripts\mp\equipment\gas_grenade::gas_queuecough(0);
    player scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  }

  _id_DC7D7DB6D1535605 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_1ED92F6D912C9995;

  if(player._id_F59B62DE990A2665 == 2)
    _id_DC7D7DB6D1535605 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_8275FEFD6945052A;

  _id_B98E5A8BFDF4A321._id_F939666ECA588C56 = 1;
  wait(_id_DC7D7DB6D1535605);
  _id_B98E5A8BFDF4A321._id_CC9EDBA11E6801CB = 1;
}

_id_A79B0A65151888A5() {
  _id_B98E5A8BFDF4A321 = self;
  player = _id_B98E5A8BFDF4A321.player;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  player thread scripts\mp\equipment\gas_grenade::gas_clearblur(0);
  player scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
  _id_B98E5A8BFDF4A321._id_F939666ECA588C56 = 0;
  _id_B98E5A8BFDF4A321._id_CC9EDBA11E6801CB = 0;
  _id_B98E5A8BFDF4A321 notify("cough_cleared");
}

_id_80F86D133491DAF8(_id_27DE1507ED41F01E, position, angles) {
  _id_DB62C0CFC8A661CC = self;
  _id_32F9A168F71A15B6 = _id_DB62C0CFC8A661CC _id_8B73CAE3FC8903B2(_id_27DE1507ED41F01E, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF);
  _id_32F9A168F71A15B6._id_8499B021054BA877 = 0;
  _id_32F9A168F71A15B6._id_1E4A95A72A733873 = ::_id_FE48E8ED75E3364C;
  _id_32F9A168F71A15B6._id_A527B47D4B5014B2 = ::_id_024C85B7774638BD;
  _id_32F9A168F71A15B6._id_B5163896CAAFC5CD = ::_id_25C3BF2B50FD1B13;
  _id_32F9A168F71A15B6._id_CADC04348D3CEAA4 = _id_DB62C0CFC8A661CC.champion.team;
  _id_32F9A168F71A15B6 _id_F8BD2935A988BB02();
  return _id_32F9A168F71A15B6;
}

_id_8E9C04AA5FA8A3DB() {
  _id_32F9A168F71A15B6 = self;
  _id_32F9A168F71A15B6.trigger = _id_32F9A168F71A15B6 _id_EE6EF53CDFC9FBA6(_id_32F9A168F71A15B6._id_DB4005060A0C66AF.origin, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_2E0C9DC38097F039, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0481C2689C39BA74);
  _id_32F9A168F71A15B6._id_B722E45993ECCB2A = 1;
}

_id_25C3BF2B50FD1B13() {
  _id_32F9A168F71A15B6 = self;

  if(isDefined(_id_32F9A168F71A15B6) && isDefined(_id_32F9A168F71A15B6.trigger) && isDefined(_id_32F9A168F71A15B6.trigger._id_78122E18403A8DC4)) {
    foreach(player in _id_32F9A168F71A15B6.trigger._id_78122E18403A8DC4) {
      if(isDefined(player) && isPlayer(player) && player.team == _id_32F9A168F71A15B6._id_CADC04348D3CEAA4)
        _id_B43D02BB8F9B51D3(player, _id_32F9A168F71A15B6.trigger, 1);
    }
  }

  _id_32F9A168F71A15B6._id_B722E45993ECCB2A = 0;
  _id_32F9A168F71A15B6 _id_BA8F494325EDE6D7("snapshotgrenade");
  _id_32F9A168F71A15B6 _id_B15E5BA7931DBB41();
}

_id_FE48E8ED75E3364C(player, _id_F33DB1522C7885F1) {
  _id_32F9A168F71A15B6 = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(istrue(_id_F33DB1522C7885F1)) {
    return;
  }
  _id_CF631F26161504DB(_id_32F9A168F71A15B6.trigger, player);

  if(isDefined(_id_32F9A168F71A15B6._id_CADC04348D3CEAA4) && _id_32F9A168F71A15B6._id_CADC04348D3CEAA4 != player.team) {
    _id_32F9A168F71A15B6 _id_E950036EB2177FF2(_id_32F9A168F71A15B6._id_CADC04348D3CEAA4);
    _id_32F9A168F71A15B6._id_CADC04348D3CEAA4 = player.team;
    _id_32F9A168F71A15B6 _id_1ABA029C65714798(player);
  }
}

_id_1ABA029C65714798(player) {
  _id_32F9A168F71A15B6 = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(!isDefined(_id_32F9A168F71A15B6.trigger._id_78122E18403A8DC4)) {
    return;
  }
  foreach(_id_F6C27256472A15A4 in _id_32F9A168F71A15B6.trigger._id_78122E18403A8DC4) {
    if(isDefined(_id_F6C27256472A15A4) && isPlayer(_id_F6C27256472A15A4) && _id_F6C27256472A15A4.team == _id_32F9A168F71A15B6._id_CADC04348D3CEAA4)
      _id_F8FB742951B911D7(_id_F6C27256472A15A4, _id_32F9A168F71A15B6.trigger);
  }
}

_id_024C85B7774638BD(player) {
  _id_32F9A168F71A15B6 = self;
  _id_CF631F26161504DB(_id_32F9A168F71A15B6.trigger, _id_32F9A168F71A15B6.scriptable);
}

_id_E950036EB2177FF2(_id_545DCB938F750B0F) {
  _id_32F9A168F71A15B6 = self;

  if(!isDefined(_id_545DCB938F750B0F) || !isDefined(_id_32F9A168F71A15B6.trigger) || !isDefined(_id_32F9A168F71A15B6.trigger._id_78122E18403A8DC4)) {
    return;
  }
  foreach(player in _id_32F9A168F71A15B6.trigger._id_78122E18403A8DC4) {
    if(isDefined(player) && isPlayer(player) && player.team == _id_545DCB938F750B0F) {
      if(istrue(_id_0266BDD55DA24482(_id_32F9A168F71A15B6, player))) {
        continue;
      }
      _id_32F9A168F71A15B6 _id_37748EF3982539D4(player, 0, "snapshotgrenade");
      _id_32F9A168F71A15B6 _id_8E58DD83353F41DD(player);
      player hudoutlinedisableforclients(level.players);
    }
  }
}

_id_3F345112D7354464(player) {
  _id_32F9A168F71A15B6 = self;
  _id_32F9A168F71A15B6 _id_F3711BF7CE3191D0(player, "snapshotgrenade", "level_script");
  _id_32F9A168F71A15B6 thread _id_7D04786B21E00EA4(player);
  _id_32F9A168F71A15B6 _id_E62674D5DE7043F9(player, "snapshotgrenade");
  player playLoopSound("evt_br_elite_arrow_neon_lp");
}

_id_7D04786B21E00EA4(player) {
  _id_32F9A168F71A15B6 = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("gal_outline_end");

  if(istrue(player._id_13168B1E22513E23)) {
    return;
  }
  player._id_13168B1E22513E23 = 1;
  scripts\engine\utility::_id_7B9E0E7CA4B3B940(_id_32F9A168F71A15B6, "death", _id_32F9A168F71A15B6, "on_drop", player, "death");
  _id_32F9A168F71A15B6 _id_8E58DD83353F41DD(player);
  player._id_13168B1E22513E23 = 0;
}

_id_8E58DD83353F41DD(player) {
  _id_32F9A168F71A15B6 = self;

  if(!isDefined(player)) {
    return;
  }
  player notify("gal_outline_end");
  _id_32F9A168F71A15B6 _id_653C2166507F3631(player);
  _id_32F9A168F71A15B6 _id_E62674D5DE7043F9(player, "snapshotgrenade");
  player stoploopsound("evt_br_elite_arrow_neon_lp");
}

_id_EE6EF53CDFC9FBA6(position, radius, height) {
  _id_32F9A168F71A15B6 = self;
  trigger = _id_32F9A168F71A15B6 _id_B2E040EF75DE3602(position, radius, height);
  trigger.targetname = "galTrigger";
  scripts\mp\utility\trigger::makeenterexittrigger(trigger, ::_id_F8FB742951B911D7, ::_id_B43D02BB8F9B51D3);
  return trigger;
}

_id_F8FB742951B911D7(entity, trigger, _id_F8048727716242B0, _id_DC97CEC26EEE3B30) {
  if(!isDefined(entity)) {
    return;
  }
  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread _id_68C54D8B0AAE409D(entity, trigger);
    thread _id_44B8AAE5BCDC3081(entity, trigger);
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }
  _id_1F21AB99F974FB93(entity, trigger, _id_F8048727716242B0, 1);
  _id_32F9A168F71A15B6 = trigger._id_F7806D4CF24AACD3;

  if(!isDefined(_id_32F9A168F71A15B6)) {
    return;
  }
  if(entity.team == _id_32F9A168F71A15B6._id_CADC04348D3CEAA4 && istrue(_id_32F9A168F71A15B6._id_B722E45993ECCB2A)) {
    _id_32F9A168F71A15B6 _id_3F345112D7354464(entity);
    _id_32F9A168F71A15B6 _id_37748EF3982539D4(entity, 1, "snapshotgrenade");
  }
}

_id_B43D02BB8F9B51D3(entity, trigger, _id_F8048727716242B0) {
  if(!isDefined(entity)) {
    return;
  }
  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread _id_584AA77D250174C1(entity, trigger);
    thread _id_685375BBA20333AD(entity, trigger);
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }
  _id_95F74C4EEDBBD627(entity, trigger, _id_F8048727716242B0);
  _id_32F9A168F71A15B6 = trigger._id_F7806D4CF24AACD3;

  if(!isDefined(_id_32F9A168F71A15B6)) {
    return;
  }
  if(entity.team == _id_32F9A168F71A15B6._id_CADC04348D3CEAA4) {
    if(istrue(_id_0266BDD55DA24482(_id_32F9A168F71A15B6, entity))) {
      return;
    }
    _id_32F9A168F71A15B6 _id_37748EF3982539D4(entity, 0, "snapshotgrenade");
    _id_32F9A168F71A15B6 _id_8E58DD83353F41DD(entity);
    entity hudoutlinedisableforclients(level.players);
  }
}

_id_68C54D8B0AAE409D(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }
  waitframe();

  foreach(_id_F85572CD5F6117C6 in vehicle.occupants) {
    if(isDefined(_id_F85572CD5F6117C6))
      _id_F8FB742951B911D7(_id_F85572CD5F6117C6, trigger, 1);
  }
}

_id_584AA77D250174C1(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }
  waitframe();

  foreach(_id_F85572CD5F6117C6 in vehicle.occupants) {
    if(isDefined(_id_F85572CD5F6117C6))
      _id_B43D02BB8F9B51D3(_id_F85572CD5F6117C6, trigger, 1);
  }
}

_id_0266BDD55DA24482(_id_DDE9A7C23004D59F, player) {
  if(!isDefined(_id_DDE9A7C23004D59F))
    return 0;

  if(!isDefined(player) || !isPlayer(player))
    return 0;

  _id_070A381821EF9DFF = _id_E6B87EEB3ABC7BE0("gal");

  foreach(_id_F7806D4CF24AACD3 in _id_070A381821EF9DFF) {
    if(_id_F7806D4CF24AACD3 == _id_DDE9A7C23004D59F) {
      continue;
    }
    if(!isDefined(_id_F7806D4CF24AACD3.trigger) || !isDefined(_id_F7806D4CF24AACD3.trigger._id_78122E18403A8DC4) || !isDefined(_id_F7806D4CF24AACD3._id_CADC04348D3CEAA4)) {
      continue;
    }
    if(_id_F7806D4CF24AACD3._id_CADC04348D3CEAA4 == player.team && scripts\engine\utility::array_contains(_id_F7806D4CF24AACD3.trigger._id_78122E18403A8DC4, player))
      return 1;
  }

  return 0;
}

_id_3B3B0F3703EBD7E5(_id_27DE1507ED41F01E, position, angles) {
  _id_DB62C0CFC8A661CC = self;
  _id_DE3EE8A977F39530 = _id_DB62C0CFC8A661CC _id_8B73CAE3FC8903B2(_id_27DE1507ED41F01E, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CF64CF3435A371DF);
  _id_DE3EE8A977F39530._id_8499B021054BA877 = 0;
  _id_DE3EE8A977F39530._id_1E4A95A72A733873 = ::_id_04EAF2406B65C6AF;
  _id_DE3EE8A977F39530._id_A527B47D4B5014B2 = ::_id_9DB988480FD8A586;
  _id_DE3EE8A977F39530._id_B5163896CAAFC5CD = ::_id_13A240CA1E1C9A96;
  _id_DE3EE8A977F39530 _id_EF13D077AC0250C9();
  return _id_DE3EE8A977F39530;
}

_id_13A240CA1E1C9A96() {
  _id_DE3EE8A977F39530 = self;
  _id_DE3EE8A977F39530 notify("neptunium_cleanup");

  if(isDefined(_id_DE3EE8A977F39530.player))
    _id_7A31F2723D220056(_id_DE3EE8A977F39530.player, _id_DE3EE8A977F39530.trigger, 1);

  if(isDefined(_id_DE3EE8A977F39530.trigger) && isDefined(_id_DE3EE8A977F39530.trigger._id_78122E18403A8DC4)) {
    foreach(nearbyplayer in _id_DE3EE8A977F39530.trigger._id_78122E18403A8DC4) {
      if(isDefined(nearbyplayer))
        _id_7A31F2723D220056(nearbyplayer, _id_DE3EE8A977F39530.trigger, 1);
    }
  }

  _id_DE3EE8A977F39530 _id_B15E5BA7931DBB41();
}

_id_8932ECA89649C982() {
  _id_DE3EE8A977F39530 = self;
  _id_DE3EE8A977F39530._id_89F6475F0AD33565 = 1;
  _id_DE3EE8A977F39530 _id_46D3CF4A7EBFA52A();
  wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_76014CA6914AD16A);
  _id_DE3EE8A977F39530 notify("neptunium_shock_players");
  _id_DE3EE8A977F39530._id_F542D3F854D1B90D = 1;
  _id_DE3EE8A977F39530 thread _id_DB77677C16F95AAF();
}

_id_04EAF2406B65C6AF(player, _id_F33DB1522C7885F1) {
  _id_DE3EE8A977F39530 = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(istrue(_id_DE3EE8A977F39530.firstpickup))
    _id_DE3EE8A977F39530._id_F542D3F854D1B90D = 1;

  if(istrue(_id_F33DB1522C7885F1)) {
    return;
  }
  if(!isDefined(_id_DE3EE8A977F39530.trigger)) {
    return;
  }
  _id_CF631F26161504DB(_id_DE3EE8A977F39530.trigger, player);
  _id_B6CC60429C9BBE38(player, _id_DE3EE8A977F39530.trigger, undefined, 1);

  if(isDefined(_id_DE3EE8A977F39530.trigger._id_78122E18403A8DC4)) {
    foreach(nearbyplayer in _id_DE3EE8A977F39530.trigger._id_78122E18403A8DC4) {
      if(isDefined(nearbyplayer))
        _id_B6CC60429C9BBE38(nearbyplayer, _id_DE3EE8A977F39530.trigger, undefined, 1);
    }
  }
}

_id_9DB988480FD8A586(player) {
  _id_DE3EE8A977F39530 = self;

  if(!isDefined(_id_DE3EE8A977F39530.trigger)) {
    return;
  }
  _id_CF631F26161504DB(_id_DE3EE8A977F39530.trigger, _id_DE3EE8A977F39530.scriptable);
  _id_B6CC60429C9BBE38(player, _id_DE3EE8A977F39530.trigger, undefined, 1);

  foreach(_id_7DBF76A8B1CF08B1 in level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D.elements) {
    if(!isDefined(_id_7DBF76A8B1CF08B1[_id_DE3EE8A977F39530._id_27DE1507ED41F01E])) {
      continue;
    }
    trigger = _id_7DBF76A8B1CF08B1[_id_DE3EE8A977F39530._id_27DE1507ED41F01E].trigger;

    if(isDefined(trigger) && isDefined(trigger._id_78122E18403A8DC4)) {
      foreach(nearbyplayer in trigger._id_78122E18403A8DC4) {
        if(isDefined(nearbyplayer))
          _id_B6CC60429C9BBE38(nearbyplayer, trigger, undefined, 1);
      }
    }
  }
}

_id_46D3CF4A7EBFA52A() {
  _id_DE3EE8A977F39530 = self;
  _id_DE3EE8A977F39530.trigger = _id_DE3EE8A977F39530 _id_A914B399BEF9DA8D(_id_DE3EE8A977F39530._id_DB4005060A0C66AF.origin, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_16082451127C4A27, level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_AAB3C520B5A4D04E);
}

_id_DB77677C16F95AAF() {
  _id_DE3EE8A977F39530 = self;
  level endon("game_ended");
  _id_DE3EE8A977F39530 endon("element_cleanup");
  _id_DE3EE8A977F39530._id_1E23C49824D7B956 = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A302E223567A930B - level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_7D816906AFE09AF9;
  _id_DE3EE8A977F39530._id_8B4E754800A213D2 = 0;

  for(;;) {
    if(istrue(_id_DE3EE8A977F39530._id_F542D3F854D1B90D))
      _id_DE3EE8A977F39530 _id_3361CE83605026A4();

    wait(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_40159311E3FB11F2);
  }
}

_id_3361CE83605026A4() {
  _id_DE3EE8A977F39530 = self;
  player = _id_DE3EE8A977F39530.player;

  if(!isDefined(_id_DE3EE8A977F39530._id_00BADA4975DF6DFD))
    _id_DE3EE8A977F39530._id_00BADA4975DF6DFD = 0.0;

  _id_DE3EE8A977F39530._id_00BADA4975DF6DFD = _id_DE3EE8A977F39530._id_00BADA4975DF6DFD + level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_40159311E3FB11F2;

  if(isDefined(_id_DE3EE8A977F39530._id_1E23C49824D7B956) && _id_DE3EE8A977F39530._id_00BADA4975DF6DFD < _id_DE3EE8A977F39530._id_1E23C49824D7B956) {
    return;
  }
  if(isDefined(_id_DE3EE8A977F39530._id_8B4E754800A213D2) && !_id_DE3EE8A977F39530._id_8B4E754800A213D2) {
    entity = _id_DE3EE8A977F39530 _id_775F98C18204823E();

    if(!isDefined(entity))
      entity = _id_DE3EE8A977F39530._id_DB4005060A0C66AF;

    if(isDefined(entity))
      entity playsoundonmovingent("evt_br_elite_arrow_neptunium_preload");

    _id_DE3EE8A977F39530._id_8B4E754800A213D2 = 1;
  }

  if(_id_DE3EE8A977F39530._id_00BADA4975DF6DFD >= level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_A302E223567A930B)
    _id_DE3EE8A977F39530 _id_3D5DF5ECA0C3F426();
}

_id_3D5DF5ECA0C3F426() {
  _id_DE3EE8A977F39530 = self;
  player = _id_DE3EE8A977F39530.player;

  if(!isDefined(_id_DE3EE8A977F39530.trigger._id_78122E18403A8DC4) || _id_DE3EE8A977F39530.trigger._id_78122E18403A8DC4.size == 0) {
    _id_DE3EE8A977F39530._id_00BADA4975DF6DFD = 0.0;
    _id_DE3EE8A977F39530._id_8B4E754800A213D2 = 0;
    return;
  } else
    _id_DE3EE8A977F39530 notify("neptunium_shock_players");

  _id_DE3EE8A977F39530._id_00BADA4975DF6DFD = 0.0;
  _id_DE3EE8A977F39530._id_8B4E754800A213D2 = 0;
}

_id_BDA8B7560ADF5719(_id_2DCA4F85444DB1D7) {
  _id_DE3EE8A977F39530 = self;

  if(!isDefined(_id_2DCA4F85444DB1D7) || !isPlayer(_id_2DCA4F85444DB1D7)) {
    return;
  }
  if(!_id_2DCA4F85444DB1D7 istouching(_id_DE3EE8A977F39530.trigger) && !isDefined(_id_2DCA4F85444DB1D7.vehicle)) {
    _id_7A31F2723D220056(_id_2DCA4F85444DB1D7, _id_DE3EE8A977F39530.trigger);
    return;
  }

  if(isDefined(_id_2DCA4F85444DB1D7) && _id_AF54A33C2AC9A71F(_id_2DCA4F85444DB1D7, _id_DE3EE8A977F39530._id_27DE1507ED41F01E)) {
    _id_6D5ED003AF1F9612 = scripts\engine\utility::array_removeundefined(scripts\mp\utility\teams::getteamdata(_id_2DCA4F85444DB1D7.team, "players"));

    if(!scripts\engine\utility::array_contains(_id_6D5ED003AF1F9612, _id_2DCA4F85444DB1D7))
      return;
  }

  if(isDefined(_id_DE3EE8A977F39530.scriptable))
    _id_DE3EE8A977F39530.scriptable _id_F3548416F24B0F48("active");

  _id_DE3EE8A977F39530 _id_08F49FE3C4EAA832(_id_2DCA4F85444DB1D7);
  _id_6F4EEF1AD5D98132 = isDefined(_id_2DCA4F85444DB1D7.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(_id_2DCA4F85444DB1D7);

  if(_id_6F4EEF1AD5D98132)
    _id_DE3EE8A977F39530 _id_979241A2DB4F97D7(_id_2DCA4F85444DB1D7);
  else
    _id_DE3EE8A977F39530 _id_ECAAC672655C907A(_id_2DCA4F85444DB1D7);

  if(isDefined(_id_DE3EE8A977F39530.scriptable))
    _id_DE3EE8A977F39530.scriptable _id_F3548416F24B0F48("visible");
}

_id_08F49FE3C4EAA832(player) {
  _id_DE3EE8A977F39530 = self;

  if(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0198A615BFD3F059 <= 0) {
    return;
  }
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  damage = level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_0198A615BFD3F059;
  player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"), "torso_upper");
}

_id_A914B399BEF9DA8D(position, radius, height) {
  _id_DE3EE8A977F39530 = self;
  trigger = _id_DE3EE8A977F39530 _id_B2E040EF75DE3602(position, radius, height);
  trigger.targetname = "nepTrigger";
  scripts\mp\utility\trigger::makeenterexittrigger(trigger, ::_id_B6CC60429C9BBE38, ::_id_7A31F2723D220056);
  return trigger;
}

_id_B6CC60429C9BBE38(entity, trigger, _id_F8048727716242B0, _id_DC97CEC26EEE3B30) {
  if(!isDefined(entity)) {
    return;
  }
  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread _id_7337DF5EE7F73E11(entity, trigger);
    thread _id_44B8AAE5BCDC3081(entity, trigger);
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }
  _id_1F21AB99F974FB93(entity, trigger, _id_F8048727716242B0, 1);
  _id_DE3EE8A977F39530 = trigger._id_F7806D4CF24AACD3;

  if(!isDefined(_id_DE3EE8A977F39530)) {
    return;
  }
  _id_DE3EE8A977F39530 thread _id_EDCFFFC4F810E828(entity);
  _id_DE3EE8A977F39530 thread _id_1B14A71BA05BD7FE(entity);
}

_id_7A31F2723D220056(entity, trigger, _id_F8048727716242B0) {
  if(!isDefined(entity)) {
    return;
  }
  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread _id_685375BBA20333AD(entity, trigger);
    thread _id_0B7F017790517B80(entity, trigger);
    entity notify("neptunium_trigger_exit");
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }
  _id_95F74C4EEDBBD627(entity, trigger, _id_F8048727716242B0);
  _id_DE3EE8A977F39530 = trigger._id_F7806D4CF24AACD3;

  if(!isDefined(_id_DE3EE8A977F39530)) {
    return;
  }
  if(_id_709DC2FDEAE07ECA(_id_DE3EE8A977F39530, entity)) {
    return;
  }
  if(istrue(entity._id_73F5208CA4D9C1BF))
    _id_DE3EE8A977F39530 _id_7519BB8DABAB4252(entity);

  entity._id_E65D2AA36253717A = 0;
  entity notify("neptunium_trigger_exit");
  entity stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
}

_id_0B7F017790517B80(vehicle, trigger) {
  if(!isDefined(vehicle)) {
    return;
  }
  waitframe();

  if(isDefined(vehicle.occupants)) {
    foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
    _id_7A31F2723D220056(_id_F85572CD5F6117C6, trigger, 1);
  }

  vehicle _id_1699C07D73E1BAC9();
  vehicle stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
}

_id_1B14A71BA05BD7FE(_id_804C1A9C74AF88C1) {
  _id_DE3EE8A977F39530 = self;
  level endon("game_ended");
  _id_DE3EE8A977F39530 endon("element_cleanup");

  if(!isDefined(_id_804C1A9C74AF88C1) || !isPlayer(_id_804C1A9C74AF88C1)) {
    return;
  }
  if(istrue(_id_804C1A9C74AF88C1._id_E65D2AA36253717A)) {
    return;
  }
  _id_804C1A9C74AF88C1._id_E65D2AA36253717A = 1;
  _id_804C1A9C74AF88C1 endon("neptunium_trigger_exit");

  for(;;) {
    _id_DE3EE8A977F39530 waittill("neptunium_shock_players");
    _id_DE3EE8A977F39530 _id_BDA8B7560ADF5719(_id_804C1A9C74AF88C1);
  }
}

_id_7337DF5EE7F73E11(vehicle, trigger) {
  if(!isDefined(vehicle)) {
    return;
  }
  waitframe();

  if(isDefined(vehicle.occupants)) {
    foreach(_id_F85572CD5F6117C6 in vehicle.occupants)
    _id_B6CC60429C9BBE38(_id_F85572CD5F6117C6, trigger, 1);
  }

  vehicle _id_29E4CED10D235C31();
}

_id_EDCFFFC4F810E828(_id_804C1A9C74AF88C1) {
  _id_DE3EE8A977F39530 = self;

  if(!isDefined(_id_804C1A9C74AF88C1) || !isPlayer(_id_804C1A9C74AF88C1)) {
    return;
  }
  if(istrue(_id_804C1A9C74AF88C1._id_BF99F646B48A062C)) {
    return;
  }
  _id_114AB0F9173B2188(_id_804C1A9C74AF88C1, 1);
  _id_804C1A9C74AF88C1._id_BF99F646B48A062C = 1;
  _id_804C1A9C74AF88C1 waittill("neptunium_trigger_exit");

  if(!istrue(_id_804C1A9C74AF88C1._id_BF99F646B48A062C)) {
    return;
  }
  _id_114AB0F9173B2188(_id_804C1A9C74AF88C1, 0);
  _id_804C1A9C74AF88C1._id_BF99F646B48A062C = 0;
}

_id_114AB0F9173B2188(player, state) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }
  if(istrue(state) && !istrue(player._id_73F5208CA4D9C1BF)) {
    player setscriptablepartstate("shockStickVfx", "vfx_start", 1);
    player._id_73F5208CA4D9C1BF = 1;
  } else {
    player setscriptablepartstate("shockStickVfx", "off", 0);
    player._id_73F5208CA4D9C1BF = 0;
  }
}

_id_EF13D077AC0250C9() {
  _id_DE3EE8A977F39530 = self;
  _id_DE3EE8A977F39530._id_D442547D75DFFD09 = spawnStruct();
  _id_DE3EE8A977F39530._id_D442547D75DFFD09._id_77AE83EEDD8CAB0C = 0.8;
  _id_DE3EE8A977F39530._id_D442547D75DFFD09._id_B79E08E886B92D46 = undefined;
  _id_DE3EE8A977F39530._id_D442547D75DFFD09._id_D5798377C05F4EDF = 1;
  _id_DE3EE8A977F39530._id_D442547D75DFFD09._id_07C149D627799674 = undefined;
  _id_DE3EE8A977F39530._id_D442547D75DFFD09._id_E926ABD3E5970492 = 1;
  _id_DE3EE8A977F39530._id_D442547D75DFFD09._id_1D572199F88FB41B = ::_id_78B078214CBC140D;
}

_id_78B078214CBC140D() {
  return;
}

_id_979241A2DB4F97D7(player) {
  if(!isDefined(player) || !isDefined(player.vehicle)) {
    return;
  }
  vehicle = player.vehicle;

  if(!istrue(player._id_12BFB031C0A0EFD8)) {
    vehicle playSound("evt_br_elite_arrow_neptunium_shock_in");
    vehicle playLoopSound("evt_br_elite_arrow_neptunium_shock_lp");
    player scripts\engine\utility::waittill_any_timeout_5(1.0, "haywire_cleared", "shockstick_interrupt", "killed_player", "last_stand_start");
    vehicle stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
    vehicle playSound("evt_br_elite_arrow_neptunium_shock_out");
  }
}

_id_ECAAC672655C907A(player) {
  _id_DE3EE8A977F39530 = self;

  if(!isDefined(player) || !isPlayer(player) || isDefined(player.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(player)) {
    return;
  }
  if(!istrue(player._id_12BFB031C0A0EFD8)) {
    _id_F3EA705A2E523BAD = spawnStruct();
    _id_F3EA705A2E523BAD.victim = player;
    _id_DE3EE8A977F39530 _id_0A35012B9B75A996::_id_C927FD013FC6E502(_id_F3EA705A2E523BAD, _id_DE3EE8A977F39530._id_D442547D75DFFD09);
    player playSound("evt_br_elite_arrow_neptunium_shock_in");
    player playLoopSound("evt_br_elite_arrow_neptunium_shock_lp");
    player scripts\engine\utility::waittill_any_timeout_5(1.0, "haywire_cleared", "shockstick_interrupt", "killed_player", "last_stand_start");
    _id_DE3EE8A977F39530 _id_7519BB8DABAB4252(player);
    player stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
    player playSound("evt_br_elite_arrow_neptunium_shock_out");
  }
}

_id_7519BB8DABAB4252(player) {
  _id_DE3EE8A977F39530 = self;

  if(!isDefined(player) || !isPlayer(player) || isDefined(player.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(player)) {
    return;
  }
  if(istrue(player._id_12BFB031C0A0EFD8)) {
    player._id_12BFB031C0A0EFD8 = undefined;
    _id_FCEF8D217A441961 = !scripts\mp\utility\player::isreallyalive(player);
    player _id_0A35012B9B75A996::_id_6C0A9D95EBB14F2A(_id_FCEF8D217A441961, _id_DE3EE8A977F39530._id_D442547D75DFFD09);
    player notify("haywire_cleared");
  }
}

_id_29E4CED10D235C31() {
  vehicle = self;

  if(!isDefined(vehicle) || istrue(vehicle._id_12BFB031C0A0EFD8)) {
    return;
  }
  if(istrue(vehicle._id_4970CB0EDEF7623B)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle, 0);

    if(occupants.size > 0)
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("shockStickAttached", occupants, vehicle.vehiclename);

    return;
  }

  vehicle._id_4970CB0EDEF7623B = 1;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("shockStickAttached", occupants, vehicle.vehiclename);

  if(vehicle scripts\common\vehicle::ishelicopter()) {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_D0092C44C5588870();
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_EE4B8B879B1B120C();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(vehicle, 0, 0);
  } else {
    vehicle._id_70EC04F736523DD0 = vehicle vehicle_gettopspeedforward();
    vehicle._id_ABDFBC385C923E9F = vehicle vehicle_gettopspeedreverse();
    vehicle vehicle_settopspeedforward(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CE691C052CEDA566);
    vehicle vehicle_settopspeedreverse(level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_CE691C052CEDA566);
  }

  vehicle scripts\common\utility::_id_3677F2BE30FDD581("haywire", "on");
}

_id_1699C07D73E1BAC9() {
  vehicle = self;

  if(!isDefined(vehicle) || istrue(vehicle._id_12BFB031C0A0EFD8)) {
    return;
  }
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("shockStickAttached", occupants, vehicle.vehiclename);

  if(vehicle scripts\common\vehicle::ishelicopter()) {
    if(vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_D419E441D20E67AC()) {
      vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_7C81E0D41CBBCE7F();
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_A91927DF280E94E4();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(vehicle, 1, 0);
    }
  } else {
    if(isDefined(vehicle._id_70EC04F736523DD0))
      vehicle vehicle_settopspeedforward(vehicle._id_70EC04F736523DD0);

    if(isDefined(vehicle._id_ABDFBC385C923E9F))
      vehicle vehicle_settopspeedreverse(vehicle._id_ABDFBC385C923E9F);
  }

  vehicle scripts\common\utility::_id_3677F2BE30FDD581("haywire", "off");
  vehicle._id_4970CB0EDEF7623B = 0;
}

_id_709DC2FDEAE07ECA(_id_DE12F04561B542ED, player) {
  if(!isDefined(_id_DE12F04561B542ED))
    return 0;

  if(!isDefined(player) || !isPlayer(player))
    return 0;

  _id_B57959EA3B480CED = _id_E6B87EEB3ABC7BE0("nep");

  foreach(_id_F7806D4CF24AACD3 in _id_B57959EA3B480CED) {
    if(_id_F7806D4CF24AACD3 == _id_DE12F04561B542ED) {
      continue;
    }
    if(!isDefined(_id_F7806D4CF24AACD3.trigger) || !isDefined(_id_F7806D4CF24AACD3.trigger._id_78122E18403A8DC4)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(_id_F7806D4CF24AACD3.trigger._id_78122E18403A8DC4, player))
      return 1;
  }

  return 0;
}

_id_3A7809BE256ADADB(_id_CB4FAD49263E20C4, player) {
  if(_id_CB4FAD49263E20C4.origin == (0, 0, 0))
    _id_CB4FAD49263E20C4.origin = getclosestpointonnavmesh(player.origin);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gxp_phones.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_813412D28E93B73630819888836E111AFD966F5F", 1)) {
    return;
  }
  scripts\engine\scriptable::_id_12F5B("_encstr_886B0EC03072F83C05CB95D8620FEDC0", ::buy_menu_closed);
  level thread toggle_safehouse_doors();
}

toggle_safehouse_doors() {
  waittillframeend;
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.setheadicon_removeclientfrommask = [];
  level.setcodenumber = [];
  level.setdragonsbreathcorpseflare = [];
  level.setexfiltimer = [];
  level.setgun = [];
  level.disable_super_in_turret.setfaketispawnpoint = getdvarint("_encstr_8CF1229B17EA7E55AB51CC4B7291B9402F8B08E9B791D277F345BDDF4DC9C70B8917D810", 74);
  level.disable_super_in_turret.setextrascore4 = getdvarint("_encstr_91EF296E1B27FA134E7DECC3E0F53886B737597DAD0B3CBECD070BDDDC37EB1C2B4EF5C6B71B0B1D5AF673", 3);
  level.disable_super_in_turret.setdragonsbreathburning = getdvarint("_encstr_BDB72DB01AB28F79F31FF473281F63A95D728849128E19168F4D08E5022FC97FC50A1B301B247F0897630FEFFF0BB3", 23);
  level.disable_super_in_turret.setdeleteabletimer = getdvarint("_encstr_A2D129B9B1397D989CF5761E83F51C1AF637CAFA5B85F0D71BB7733A93ED36EB27BDED6BEB3738B0EE9B9B", 12);
  level.disable_super_in_turret.setdropbagdelay = getdvarint("_encstr_A32823035AA3C870C2079FB930E1A82BAFE2590EA25798B01A199FFF5ED509661B8AB0316A", 45);
  level.disable_super_in_turret.setextractspawninstances = getdvarint("_encstr_8C6E24D2E8628705CB8FBCB301AE2B8A60868A87513FD0A708C880E83FA35010EE52CFC0472F", 45);
  level.disable_super_in_turret.sethasrespawntokenextrainfo = getdvarint("_encstr_A2C424620E2531AA83294703681E708AC7106F91E0892AE289186F23F9D357A1B7BBF6555EDB", 10);
  level.disable_super_in_turret.setincomingcallback = level.disable_super_in_turret.setdropbagdelay + level.disable_super_in_turret.setextractspawninstances + level.disable_super_in_turret.sethasrespawntokenextrainfo;
  level.disable_super_in_turret.sethistorydestination = getdvarint("_encstr_8812215F88DBC7BA450877A88777D388ED889F67B0B331439120BFE7E1339B77E8283B", 20);
  level.disable_super_in_turret.setherodropscriptable = getdvarint("_encstr_8812215F88DBC7BA450877A88777D388ED889F67B0B331439120BFE7E1339B77E86863", 21);
  level.disable_super_in_turret.setgameendflagsandnotifies = getdvarint("_encstr_93B720573F9318A8B21121DAC2B770CBFAA3E387F30A5320C7B76950AE69D1F1F23B", 5);
  level.disable_super_in_turret.setfirsthistorydestination = getdvarint("_encstr_8AB72072D82A2715B28150B0B31F0BCADF75FA515ACBA0CC8783D2A4B2C1FE61570B", 15);
  level.disable_super_in_turret.setheadicon_addclienttomask = getdvarint("_encstr_A7C9211B3E4568439DE1475ACF7792926FB01B192349155F97BB28C8C0AFBFE122C2C3", 10);
  level.disable_super_in_turret.sethasselfrevivetokenextrainfo = getdvarint("_encstr_82C9215F57B679EA1096AF706BA120C280F58F771D5332A7519B64BD80186B09690343", 15);

  switch (level.mapname) {
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      tire_repair_start_air_stop_sfx();
      tire_repair_start_enter_foley_sfx();
      break;
    case "_encstr_A3F50BC8631F6D20CD64F7A155":
    case "_encstr_8CD508CA98A70FAFC01D":
      tire_repair_start_exit_foley_sfx();
      break;
  }

  toggle_safehouse_settings();
  level thread topteam();
}

tire_repair_start_air_stop_sfx() {}

tire_repair_start_exit_foley_sfx() {
  battle_tracks_playbattletrackstoalloccupants("_encstr_A60108C05863AB184BF8", (-22374.9, 19917.6, -160), (0, 115, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A60108C05863AB184BF8", (-17061.8, 19968.1, -355.661), (0, 17, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_91B606B0E49C0B5E", (26960.8, 20389.6, 1379.32), (0, 30, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A12309057F2275CBB14A51", (-25173.4, -12244.5, 107.339), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A12309057F2275CBB14A51", (-28156.3, -17991.5, -171.661), (0, 295, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A12309057F2275CBB14A51", (-27298, -2456.58, -243.15), (0, 345, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_883009BD28232B4B688B98", (24937.1, -14516.3, -155.991), (0, 340, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_883009BD28232B4B688B98", (19984.7, -23085.9, -144), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_883009BD28232B4B688B98", (15022.6, -6416.76, -410), (0, 15, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_BD0208BE67B903152D08", (-4509.41, 6606.26, -155.491), (0, 160, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_B19B09E057A26011D22585", (46111.3, -9402.01, 325.089), (0, 30, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_B19B09E057A26011D22585", (55401, -15242.8, -371.951), (0, 55, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_B19B09E057A26011D22585", (46442.1, -22670.5, -263.051), (0, 130, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_883E0978CAE2A1689B3161", (7421.45, -8370.11, -36.0004), (0, 187, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_883E0978CAE2A1689B3161", (8052.45, -9700.34, -239.901), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_883E0978CAE2A1689B3161", (10335.8, -11269.7, -240.401), (0, 240, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_8E4107C6EA5B135939", (54360.5, 4446.3, 211.214), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_8E4107C6EA5B135939", (49128.9, 2579.8, 123.339), (0, 167, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_8E4107C6EA5B135939", (50568.3, 91.5719, 171.214), (0, 340, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A73C0E2743B91AFC883328B929502312", (5521.67, 51545.2, 1092.36), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A73C0E2743B91AFC883328B929502312", (3255.25, 47791.2, 1321.08), (0, 10, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A73C0E2743B91AFC883328B929502312", (982.65, 45684.8, 1488), (0, 335, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_B6A2056BD2E659", (33229.7, 40102.1, 880.339), (0, 160, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_B6A2056BD2E659", (30807, 40093.7, 880.339), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_B6A2056BD2E659", (27322.3, 35157.4, 896.339), (0, 100, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_810D059BE07D8B", (29918.5, -27964.8, -518.681), (0, 260, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_810D059BE07D8B", (37287.1, -26747.4, -473.991), (0, 75, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_810D059BE07D8B", (37872.6, -15071.6, -514), (0, 330, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A77808BB284B9F27D3C1", (26464.4, 411.112, -75.4279), (0, 150, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_AF680893E530138E1FE0", (-25574.9, 7085.18, -260), (0, 170, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A19407CB0D1807F441", (-23818.5, 52700.6, 2698), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A19407CB0D1807F441", (-26594.8, 51998.5, 2892), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_A19407CB0D1807F441", (-29124.4, 48592.4, 2559.34), (0, 40, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_8BA10B7710B3A5E32FF50D4255", (-14476.3, 7570.5, -349.96), (0, 80, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_8BA10B7710B3A5E32FF50D4255", (-11087.9, 7419.82, -347.428), (0, 7, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ADA606A3E4B04BE6", (-10431.4, -12430.3, 60.5927), (0, 40, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ADA606A3E4B04BE6", (-14157.8, -11729, -91.4333), (0, 180, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_BD680B25565F4BC176737038AA", (15380.1, 17751.4, 187.84), (0, 10, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_BD680B25565F4BC176737038AA", (11801.4, 18815.1, 208.002), (0, 215, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (-36658.9, -12385.2, -62), (0, 65, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (-15256.3, -41109.1, 604), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (-1217.01, -24365.2, -59.0882), (0, 25, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (-26463.4, 9405.66, -259.907), (0, 30, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (-22885.2, 35034.7, 256), (0, 180, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (2152.61, 29778.3, 216.912), (0, 195, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (-7197.45, 57362.9, 1053), (0, 180, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (29759.8, 36364, 694.412), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (44514.4, 13862.6, -310.657), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (52722.6, 1686.83, 25.4118), (0, 0, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (52526.3, -17890.5, -484.907), (0, 170, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_ABAC0D8EE0851B1288080FB3F860F5", (-8668.4, 5080.99, -289.588), (0, 255, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (52251.4, -41466.1, 1768), (0, 200, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (24048.2, -28547.4, -351.5), (0, 100, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (9708.17, -23992.4, -186.428), (0, 190, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (1974.23, -24919.1, -213.011), (0, 275, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-3849.26, -21679.3, -192.661), (0, 290, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-12042.1, -28767.7, 48), (0, 285, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-16742.9, -21605.8, -212.757), (0, 300, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-24362.7, -28695.5, -58), (0, 255, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-4972.35, -3137.29, -241.978), (0, 10, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-11587.7, -4366.5, -125.278), (0, 295, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-19873.9, -2683.02, -271.998), (0, 200, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-35384, -7120.79, -172.661), (0, 25, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (14780.5, 5898.52, -259.067), (0, 180, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (22434.6, 10911.9, -409.951), (0, 180, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (46502.1, 19969.1, -308.278), (0, 200, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (39186.1, 15674.1, -271.978), (0, 45, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (10702.4, 12800.7, -282), (0, 90, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (5179.14, 24678.2, 62.3032), (0, 250, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-1369.85, 30080.8, -38), (0, 70, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-24187.7, 35781.3, 375), (0, 65, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-13242.5, 45519.5, 1836), (0, 100, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (-14262, 58661.4, 2200.05), (0, 50, 0));
  battle_tracks_playbattletrackstoalloccupants("_encstr_979608DF73C8E70B73A1", (14551.2, 36655.2, 1493.32), (0, 100, 0));
}

tire_repair_start_enter_foley_sfx() {
  battle_tracks_playerinlisteningzone("_encstr_86A724E2AA082332B807A7AE13C0313B4D81E92B30F8DB2F716FD0BF0FA0C9A7E5B8C293F9C1");
  battle_tracks_stoptogglethink("_encstr_82EF0594EDAE31", "_encstr_83EE1EA3C1800A5A28F6CF9729E0AFC36501C76B49309205B119449AE3A8CADB");
  battle_tracks_stoptogglethink("_encstr_8E4806A5C56F2BCD", "_encstr_81CB1C4F5AA9326BF7FFA7ABEBAEE17AD06109D2B0D0F6D2C09B8BE3D34B");
  battle_tracks_toggleonstate("_encstr_95D8108B4869283942D39FC7A70B7D7812F5", "_encstr_87181C23C37D26392CFAEC99161BAFE459C8FA1C867B3759BE58C8D8CA27");
}

toggle_safehouse_settings() {
  battle_tracks_playerinlisteningzone("_encstr_86A724E2AA082332B807A7AE13C0313B4D81E92B30F8DB2F716FD0BF0FA0C9A7E5B8C293F9C1");
  battle_tracks_stoptogglethink("_encstr_A60108C05863AB184BF8", "_encstr_83EE1EA3C1800A5A28F6CF9729E0AFC36501C76B49309205B119449AE3A8CADB");
  battle_tracks_stoptogglethink("_encstr_91B606B0E49C0B5E", "_encstr_81CB1C4F5AA9326BF7FFA7ABEBAEE17AD06109D2B0D0F6D2C09B8BE3D34B");
  battle_tracks_stoptogglethink("_encstr_A12309057F2275CBB14A51", "_encstr_97931FA91889486ED7B9A9F122A7B0805F9C5739A06DD03D0742A0F84AE75758B7");
  battle_tracks_stoptogglethink("_encstr_ABAC0D8EE0851B1288080FB3F860F5", "_encstr_8DAF23463CF54C4E85EBEC330BB1D79CACC87DC10DDB7356AFD8EDDC47E4EDB1FA39F6F6AD");
  battle_tracks_stoptogglethink("_encstr_883009BD28232B4B688B98", "_encstr_9AAD1FC80FF526C90BF5CE99B0C6EB93B223AF3886DBB956BEC8B7EECDD17B77E6");
  battle_tracks_stoptogglethink("_encstr_BD0208BE67B903152D08", "_encstr_AD5A1E321EFA98E42CFAEC99C2D8D79C2B19D70E1ADB9B59FA9958D8E8F639CB");
  battle_tracks_stoptogglethink("_encstr_B19B09E057A26011D22585", "_encstr_93B51F7953418628A1112119868B09C65A8B97D9EBAA58A8C737E993AD7C207022");
  battle_tracks_stoptogglethink("_encstr_883E0978CAE2A1689B3161", "_encstr_AFAE1F46C3EB4CE4C2BE3B330B8D7DE4B246EB1C34DB3795BEA1F6B90E4B3A85C6");
  battle_tracks_stoptogglethink("_encstr_8E4107C6EA5B135939", "_encstr_ACBA1DE44396F3EAB391123A588FE9FB89255788D3387BF727E03B8228EB9A");
  battle_tracks_stoptogglethink("_encstr_A73C0E2743B91AFC883328B929502312", "_encstr_A7C524715AA8315B8B4930704826998B4032515282B73062B9A22C79B901387BD8CFE3E787AD");
  battle_tracks_stoptogglethink("_encstr_B6A2056BD2E659", "_encstr_A9381B3A93C9706B0A3F970BAF37716B4F1551727B07B581591F8B9252");
  battle_tracks_stoptogglethink("_encstr_810D059BE07D8B", "_encstr_BDA31B012B39FE40B9090921AE63F12E72A3FFB1C382B0B0EFDA30BB13");
  battle_tracks_stoptogglethink("_encstr_A77808BB284B9F27D3C1", "_encstr_9BD01E2387EB31C916BECE330BD8D74E2B32D7E043BDCDACAFB9E8C24696BADA");
  battle_tracks_stoptogglethink("_encstr_AF680893E530138E1FE0", "_encstr_99C01EE7C3BF227A21E987BB20591F6B9355A19AA3775AB50E60C397D0711FC2");
  battle_tracks_stoptogglethink("_encstr_A19407CB0D1807F441", "_encstr_BEE01DB2FA58736208B7777EE330E18BFDD1997B80280B9F21177D4DE31873");
  battle_tracks_stoptogglethink("_encstr_8BA10B7710B3A5E32FF50D4255", "_encstr_AD4721BCE0FE553EFFD7B72ADA166676A140F7F379D7C83FD91FF8833542376D3D9AC5");
  battle_tracks_stoptogglethink("_encstr_ADA606A3E4B04BE6", "_encstr_82171C8C0FEB31C9B0D7EC338536D74E59237DC1D0DE37B2F5E89CC2B4E6");
  battle_tracks_stoptogglethink("_encstr_BD680B25565F4BC176737038AA", "_encstr_86AD219187AF134EB0BE9DCC0B6CAF4EB291D70E34EDDC567D3ACEEB6ED1583AB47B73");
  battle_tracks_toggleonstate("_encstr_95D8108B4869283942D39FC7A70B7D7812F5", "_encstr_87181C23C37D26392CFAEC99161BAFE459C8FA1C867B3759BE58C8D8CA27");
  battle_tracks_toggleonstate("_encstr_B88F0D59B2E75391BB05BFB92DA240", "_encstr_A5151BAF8B079AB2E9314F43E881A723DB2DF9227BBF92ED76B87B7738");
  battle_tracks_toggleonstate("_encstr_B1F20E40FB21298BC9EB9D9E0342ED30", "_encstr_ADD51CE4D919750E03B1A814CF7937FE6F94B7390842338271DFB9CFCEA1");
  battle_tracks_toggleonstate("_encstr_962F13A3936EE056E8E69B164FD72B58B9D19527DC", "_encstr_B8EE1E0B5876C2836BAF6F277717299A59206FE370A8363A3F2735DB6825E246");
  battle_tracks_toggleonstate("_encstr_B2350D9105586A874D293B53B11E8B", "_encstr_91151B910FEB26E4857D9D99586CEB27B219F50743F6E6B2BE584FBA4E");
  battle_tracks_toggleonstate("_encstr_BEAA137B321B6FFB39AE9F1FD3163B358B48F57876", "_encstr_84ED1C521AB893822897575E835081ABDDF1799BA0086BBF01D5492B93E0");
  battle_tracks_toggleonstate("_encstr_8C760DA611585DC19DEBEFCBDB3E1A", "_encstr_AD311B23C3EB269C85BEB3990B36D7392B32BE0ED07BE659FA98161B59");
  battle_tracks_toggleonstate("_encstr_992C0F999603C5E0F451633942DC98862A", "_encstr_AA311BE350914D50E8F96717311B5E6B0964F0D37888D212F186507620");
  battle_tracks_toggleonstate("_encstr_992C0F999603C5E0F451633942DC98862A", "_encstr_82DA1D4DD0713E5651B8D7850FF7D6F01D9B9063E87B95EF29CEB86552B90A");
  battle_tracks_toggleonstate("_encstr_9B021413D338CDEDEC09508BEB7A89836F1724097E08", "_encstr_A3A12039A8E7A886D2B71F1567DA58907507C633540F7335693B23394B5298980D1A");
  battle_tracks_toggleonstate("_encstr_97DE0F6C4358E4635EEBEE56E64795C937", "_encstr_9A4F1D49E04703EB4E018FB32BB3F96BDF71694B69D745C56F1EE8A81ACBDB");
  battle_tracks_toggleonstate("_encstr_B82B1285F0EA5FBBDF63A39BEFFFD197230F7E37", "_encstr_81A2216CF9F196DBA7F6524A198E37CA48B9DFE071C85D4F4069EAE243D553C418078A");
  battle_tracks_toggleonstate("_encstr_BE210D4C051708B70333763B1D42B3", "_encstr_8CBC1AD5F8112593B9AFF0F03FD34E7DDA67C06754CAF5B95F7BD870");
  battle_tracks_toggleonstate("_encstr_8F380F3B7DFBB3ED38F74407FBA31F4D5B", "_encstr_B2581D191ED7984E85AFEC3358D8F527AC46D71CD0DBDCAC7D91BD5BA5B97B");
  battle_tracks_toggleonstate("_encstr_8D0A0ECC85C92C0DF5EEB2B9A3954E37", "_encstr_97321C2482EF62DAD1F941032126B9CE9350BF220BE0FB28FF0199B3E292");
  battle_tracks_toggleonstate("_encstr_BD6F0E0B6AFE87CEA1AB090391A81223", "_encstr_B6251D461ED7982758F5D9CC0B1BAF27CAC87D1C0DF673B2D79D85E4B14B58");
  battle_tracks_toggleonstate("_encstr_B25E0DE0BAAAC241DF0597DB5D02E8", "_encstr_8DBC1AC80FF5C44E16FAB33358367D395619D7E034DBE6ACAFD9589E");
  battle_tracks_toggleonstate("_encstr_8A830EF8C8DAAFC36F14F0FF418BD6CD", "_encstr_AD641CC483C122DBC1E14705AB9F618AE3F0D1DA61E878DD59B1F8087EDB");
  battle_tracks_toggleonstate("_encstr_9708148E9C3B0D7B6E1D66C2C6CAFADDCADC1D5939B9", "_encstr_851B20A4A9A06DB8B10910BA6243517650BD66BB0CDF1895BF0CC3FD83A3458FDE2D");
  battle_tracks_toggleonstate("_encstr_91560EECDE63CA6BFABB2B37D12BE437", "_encstr_AF3A1C391301C66861D1E1D9464BC9061ACBD7992B6A98E88737E8906F3D");
  battle_tracks_toggleonstate("_encstr_845B0FC1B25908840B3FA79B9723DDE8E6", "_encstr_8B7C1D8DF3D70235432FC7A9686A2F9B058910DB40D76D3B716F1043696F87");
  battle_tracks_toggleonstate("_encstr_91770FE498C3D0F1A9E025F788B1297073", "_encstr_8A7C1D5D99B90E90A036D06322EE4042B711E9439B75FE4D0F482D28D049B2");
  battle_tracks_toggleonstate("_encstr_ADDB11B1614CF87D87B2F0DE5BB7AEA8A7823D", "_encstr_95431D3093C1DD53A7779C0421C7BE85373A71182A650D4987789D0D2BCF40");
  battle_tracks_toggleonstate("_encstr_99E40E8DC22A6B479F37A556BCC88B7A", "_encstr_81731D13406EEAAB5338473F1F7F31A271C887CB58C02E02D74BCB35FD2BDB");
  battle_tracks_toggleonstate("_encstr_847D0E70F7537BF3D97FAFAE13521D20", "_encstr_886B1CD830B9663A010794CEF2038F785BE4A129A3F06E2DC763EBAB26C7");
  battle_tracks_toggleonstate("_encstr_8B7013986B3B5FA5473B405ADBCFEF136B19D99BF5", "_encstr_AB521F8C1EFA9893C2BE7666588DD7E4ACC87DC143DECD56AFB6A573B337C659F2");
  battle_tracks_toggleonstate("_encstr_8456126B8ED2BBA36EBDB6DF4F0C35484BCD6E7A", "_encstr_9B041E5373D1DA6AE16E51FBE36B89D36F4B0FAB7328C32B69626B28F3FB40C2");
  battle_tracks_toggleonstate("_encstr_83860E1B9BEF1A63FEA0B7E790913AB2", "_encstr_AF841DC0930FDD1DD30E078750B6FE95D82F01F00307D573285B53D3DFF38D");
  battle_tracks_toggleonstate("_encstr_8B1B10E7D8E125229366B137C767CBFDEBC0", "_encstr_B8E01E321E7D982716AF9DCC588DF539B246FAE0A17BDC56EBB627D52BCE5927");
  battle_tracks_toggleonstate("_encstr_AC180E49F51290B3FF2A590323CF7630", "_encstr_A7241C46F0BE314E16EB76CC2C8DD727AC46EB0734DB9BB2BEB12B9CD843");
  battle_tracks_toggleonstate("_encstr_A78813B559D116C676437BB93AEB592C3747CA39DC", "_encstr_BE391B8CC3F531932CD7B3660B36EB4ECA23EBC134DB9BACF5D62C8DAC");
  battle_tracks_toggleonstate("_encstr_9B440E5B7F724AA9616385B3A3FBB0C6", "_encstr_8F391B3BB89FA5EA48F74CC7E9B8914D776A47937830B6BDAFDA42682F");
  battle_tracks_toggleonstate("_encstr_880410132A60693348258F372B6E8BA52068", "_encstr_A9151C8BD8F64203EB80EFA7F797A91AD9A0EF63F028B6BABFA1769AE8A5");
  battle_tracks_toggleonstate("_encstr_A3A9101CB35052C9A2D64FBB72862BA3809B", "_encstr_B2151C32F0F531C92CBEEC33C21BFA39B232EB1C347BB995D7DAC2875ADC");
  battle_tracks_toggleonstate("_encstr_93E21223A39B722BC058E3F7919BE5BB71152A5D", "_encstr_8E821EF9D3C106A82191A199060B8946DA0B17596B2AD828477529316DF1D875");
  battle_tracks_toggleonstate("_encstr_8D5E11D62D9BB78EB0679CFAB22C6EE859C973", "_encstr_8B411F71D9D8F5E5B2782FE3B2BA0773D51D97337C90F562DF79E0B0824D8A734B");
  battle_tracks_toggleonstate("_encstr_915F0E78E28AF1B15F5F9D8E34DF1BBD", "_encstr_B4031CC83CAF4C4E857DD9CC2CC67D9C9546EB0ED0B737CAFAB5F6C947AC");
  battle_tracks_toggleonstate("_encstr_AF5412E93922D0CE33BA285321170D28BBFD6DA5", "_encstr_92501BC887F5984E857DEC661636FAC9CA32BE07A1DB7356BE37B09D0B");
  battle_tracks_toggleonstate("_encstr_ACAC10F55F902F6C593B29CB367B04634B78", "_encstr_96E11ECD83613D6B6A27777801AA810BBF6CF8FB2437504991C599B46FA8B980");
  battle_tracks_toggleonstate("_encstr_AC0D113F08973C5B3D07884E583F235DFFFB25", "_encstr_A3B11C4763DF421A4189E71B80F9FF8B73F501FAC3D7FA55AE28D727A350");
  battle_tracks_toggleonstate("_encstr_A1060E7A03B5070A614FCDC351E85263", "_encstr_ABD21C237B492295497F0FBF867FC686E338176B013F73F11985F00315E6");
  battle_tracks_toggleonstate("_encstr_AA480E7463505F7B4F50B2EB7003220B", "_encstr_BEA41B10D36F61CD32C9A43C5ECA4FABBD5B41283BE7B8ABB92AAF3E34");
  battle_tracks_toggleonstate("_encstr_847A0E98DE53D9F5D97FAFAE13521D20", "_encstr_A9331F855051497DF0C78720F9E1F1EACDB8C6F7BB28C0BF99D17A55F3DD879341");
  battle_tracks_toggleonstate("_encstr_B8F90EF1FE2B258A77F399535B35C850", "_encstr_88F01D46E1FAC4E485AF9D66581BEB9CB219D783D0BDCD56F507B7DDCA93CD");
  battle_tracks_toggleonstate("_encstr_925F0E33A0E3F6BFCEA47D633D513B7D", "_encstr_9B951C8C0FF5139385F5CE99858DFA4EAC32EB0E43F6CD59F50E93B4D856");
  battle_tracks_toggleonstate("_encstr_8B3F0F5DEBC3EDCB93783FEF93CB3D73DE", "_encstr_87761D91F0BE4C4EC2FA9D9985B1D7395919AFE043B7CD56FAC90B2D37CA6E");
  battle_tracks_toggleonstate("_encstr_B42D101BB0A827ABE237A1DBE2B003E5DB36", "_encstr_A1821CBC190122331309D772F9F9CE6A05B5FF9B7098903D31ABFFAD42CF");
  battle_tracks_toggleonstate("_encstr_B4A9139BA218ED2BC4BFDBF7BDE0335DB093576220", "_encstr_ACC31C217ADF3A830B4F4F5B612E96034F38EF2AAB4FEEDF9ED57F834AE6");
  battle_tracks_toggleonstate("_encstr_AD3B0FEB20FD770DA85F8D911FA057D310", "_encstr_8D631DF461690E532F4EDAD29176AF42C0315768F940D5F7D8C352FAF858B3");
  battle_tracks_toggleonstate("_encstr_A2750E93B79B2DB9EBDD56B91DB29C73", "_encstr_83B11CE1702F604E6AFF475D1F92AF28ADCF0EFB1C77588DA1A35F45172A");
  battle_tracks_toggleonstate("_encstr_B8840D03C81ABFF918FB333C9BC8FD", "_encstr_A3B61BC7D221BAF37F775F23731669E2A8F9B14A48484E5A5805775B53");
  battle_tracks_toggleonstate("_encstr_8D9F14D14E17D5A5C6B537C2B98CFADD2BE63AACE4DC", "_encstr_AF7E1C323C7D4CE485AFB33385B1BEE42B32D70E86DBDC2BF5CD858D581A");
  battle_tracks_toggleonstate("_encstr_A3A71019AC990BBA63D1EB95589B4756E49B", "_encstr_97BD1A3287FA98C9587DD9CC0B36AF9C5691D70E43F637CAAFDC2D6B");
  battle_tracks_toggleonstate("_encstr_A34110553F02A3F33483B1F8AF43ABD32B65", "_encstr_97BD1A3287FA98C9587DD9CC0B36AF9C5691D70E43F637CAAFDC2D6B");
  battle_tracks_toggleonstate("_encstr_A5390ED3734E6A990903BF025BE0B252", "_encstr_9BAF1B23E1BE264EB0F5B3998536FAC9598CF583437B73CAD79B4BD69B");
  battle_tracks_toggleonstate("_encstr_8B490D6EB7160EF5DD56CDD15693E6", "_encstr_A3AF1B4763DF421A4189E71B80F9FF8B73F501FAC3D7FA55AEC0CF0F20");
  battle_tracks_toggleonstate("_encstr_A3030E414E9B9512E76369A3CB8578C0", "_encstr_A3AF1B4763DF421A4189E71B80F9FF8B73F501FAC3D7FA55AEC0CF3398");
  battle_tracks_toggleonstate("_encstr_A5CB0FCF1B4843235327AB5D2FF4AD5A2E", "_encstr_86F81D91E1F5989385FA3B99B0D8BE935646FAE0D0BD9B95FAB9838527D69B");
  battle_tracks_toggleonstate("_encstr_BA6E1143CAE7E35F7B5E80BF65E10FAB63086A", "_encstr_AAFB1DB7A251CA832F270F1343C6991278C9E13A18789E8A68574B2781FEB2");
  battle_tracks_toggleonstate("_encstr_84580E6B8E53353A78BFBD5AE30522A0", "_encstr_A61E1C13406EEAAB5338473F1F7F31A271C887CB58C02E02D7C68B75F02B");
  battle_tracks_toggleonstate("_encstr_AFF61093F26E0F42D823AF8FCB900BB716F0", "_encstr_85861E717B87C660B6B72F15B11E419637D26E7BE2EF082BC1730135C144A85E");
  battle_tracks_toggleonstate("_encstr_A3E20C27B9A74105379B2B31B333", "_encstr_8CBD1AD5F8112593B9AFF0F03FD34E7DDA67C06754CAF5B95F271898");
  battle_tracks_toggleonstate("_encstr_B15311670D509386A038D3115398DBDB3D65CB", "_encstr_8C9A1C46C3AF269C0BF5D9CCC26CD79CCA23FAE0D0DE7356BEE82C1BDBCD");
  battle_tracks_toggleonstate("_encstr_A5D70FADEAE4E0A197F577CACD47569C73", "_encstr_81F41DF359E1EA635E199CDEDB4F11F2A5E206F8800F03B29E68D84F2B2069");
  battle_tracks_toggleonstate("_encstr_839B0EE84E9BE823D7EE5637E856E4B9", "_encstr_8D4A1D91E1D7262716FAB3CC58D8AF4EB28C7D1C0DB7DC2BEB6785937616DC");
  battle_tracks_toggleonstate("_encstr_ABD41090F5D029A7491DEF7F863FA30DCD68", "_encstr_8CF81E48EBB9B53BFFDF34BCF92F465D9F92197082CDF5912F1ECDA1D967C9DD");
  battle_tracks_toggleonstate("_encstr_8E3711F929D320B7DBAABB06934F7660EFDA45", "_encstr_BE6C1D8C3CFAC4270BF5CECC0B36FA9CAC327D07D0ED9BCAEB77560B67B2C9");
  battle_tracks_toggleonstate("_encstr_A7A0156BD684614A3B3B52600ABF2B17F8AFE369ADB270", "_encstr_938C1BDFCA39A29B070F373B5B3E710A40D19922206066A270270F2B4D");
  battle_tracks_toggleonstate("_encstr_9BDE10F5EB63108724A721DBFDCE941F83FE", "_encstr_ABCF1C1987D726272CAF3BCCB08D7D39598CBEE0A1F6CDACEBBBBDDE329B");
  battle_tracks_toggleonstate("_encstr_B1D4113A9377C9B02D4743BEDD56DCE8AC9CDC", "_encstr_8F011DC81ED71327B0FAD9660B36AF9CB28CFAC1A1B7DCB27DDD932C4BA334");
  battle_tracks_toggleonstate("_encstr_81A10E47316A2385D183BD4E35859620", "_encstr_8A7B1C5D99B90E90A036D06322EE4042B711E9439B75FE4D0FC83B6893AB");
  battle_tracks_toggleonstate("_encstr_A6A40E2FB23B7BE4FA2B2C37E8B2C9B9", "_encstr_8B461C8AC2605B4AD05F8F963B18D9D395B9B15368C033C7493B859FCFB8");
  battle_tracks_toggleonstate("_encstr_8C490D7BF1E87731C0338B74C38085", "_encstr_82F71BFCAB7E1B124B790A1260A78183911D7F60CBED639F0F48928A78");
  battle_tracks_toggleonstate("_encstr_B849107BDB9AF2D9E8B9595BD1E81C0A769D", "_encstr_A59C1C463C7D269CC2FAB3990BD8D74E2B23F50E1AB73756EBD3ACCBB92C");
}

topteam() {
  var_0 = level.disable_super_in_turret.setextrascore4;
  var_1 = level.disable_super_in_turret.setdragonsbreathburning;
  var_2 = level.disable_super_in_turret.setdeleteabletimer;

  if(var_0 <= 0 && var_1 <= 0 && var_2 <= 0) {
    return;
  }
  if(!isDefined(level.setcodenumber)) {
    return;
  }
  var_3 = level.disable_super_in_turret.setfaketispawnpoint;

  if(var_3 <= 0) {
    return;
  }
  var_4 = getarraykeys(level.setcodenumber);
  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_5 = [];
  var_6 = 0;

  for(var_7 = 0; var_6 < var_3 && var_7 < var_4.size; var_7++) {
    var_8 = var_4[var_7 % var_4.size];

    if(var_8 == "_encstr_979608DF73C8E70B73A1")
      var_9 = int(min(level.setcodenumber[var_8].size, var_1));
    else if(var_8 == "_encstr_ABAC0D8EE0851B1288080FB3F860F5")
      var_9 = int(min(level.setcodenumber[var_8].size, var_2));
    else
      var_9 = int(min(level.setcodenumber[var_8].size, var_0));

    if(var_9 <= 0) {
      continue;
    }
    var_10 = randomintrange(0, var_9 + 1);
    var_11 = int(min(var_3 - var_6, var_9));
    var_5[var_8] = var_11;
    var_6 = var_6 + var_11;
  }

  for(var_7 = 0; var_6 < var_3 && var_7 < var_4.size; var_7++) {
    var_8 = var_4[var_7 % var_4.size];

    if(var_5[var_8] < level.setcodenumber[var_8].size) {
      var_11 = int(min(var_3 - var_6, level.setcodenumber[var_8].size - var_5[var_8]));
      var_5[var_8] = var_5[var_8] + var_11;
      var_6 = var_6 + var_11;
    }
  }

  foreach(var_17, var_13 in var_5) {
    var_14 = level.setcodenumber[var_17];

    if(!isarray(var_14)) {
      continue;
    }
    var_15 = scripts\engine\utility::array_randomize(var_14);

    if(var_17 == "_encstr_979608DF73C8E70B73A1")
      var_16 = var_1;
    else if(var_17 == "_encstr_ABAC0D8EE0851B1288080FB3F860F5")
      var_16 = var_2;
    else
      var_16 = var_0;

    for(var_7 = 0; var_7 < var_15.size && var_7 < var_16; var_7++)
      _id_1367C(var_15[var_7].origin, var_15[var_7].angles, var_17);
  }

  level.setcodenumber = [];
  level thread _id_14003();
}

battle_tracks_playerinlisteningzone(var_0) {
  level.setdragonsbreathcorpseflare[level.setdragonsbreathcorpseflare.size] = var_0;
}

battle_tracks_stoptogglethink(var_0, var_1) {
  if(!isarray(level.setexfiltimer[var_0]))
    level.setexfiltimer[var_0] = [];

  var_2 = level.setexfiltimer[var_0].size;
  level.setexfiltimer[var_0][var_2] = var_1;
}

battle_tracks_toggleonstate(var_0, var_1) {
  if(!isarray(level.setgun[var_0]))
    level.setgun[var_0] = [];

  var_2 = level.setgun[var_0].size;
  level.setgun[var_0][var_2] = var_1;
}

battle_tracks_playbattletrackstoalloccupants(var_0, var_1, var_2) {
  if(!isDefined(level.setcodenumber[var_0]))
    level.setcodenumber[var_0] = [];

  var_3 = level.setcodenumber[var_0].size;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_4.angles = var_2;
  level.setcodenumber[var_0][var_3] = var_4;
}

_id_1367C(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = (0, 0, 48);
  var_4 = scripts\engine\trace::ray_trace(var_0 + var_3, var_0 - var_3);
  var_5 = easepower("_encstr_886B0EC03072F83C05CB95D8620FEDC0", var_4["_encstr_BD260953AA97E3F014279D"], var_1);
  var_5.location = var_2;
  level.setheadicon_removeclientfrommask[level.setheadicon_removeclientfrommask.size] = var_5;
}

loadout_updateglobalclassgamemode(var_0) {
  foreach(var_2 in level.setheadicon_removeclientfrommask)
  var_2 disablescriptableplayeruse(var_0);
}

move_to_new_node(var_0) {
  foreach(var_2 in level.setheadicon_removeclientfrommask)
  var_2 enablescriptableplayeruse(var_0);
}

update_track_timer(var_0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return 0;

  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_3 = var_2 * var_2;

  if(distance2dsquared(var_0, var_1) > var_3)
    return 1;
  else
    return 0;
}

_id_14003() {
  if(level.setheadicon_removeclientfrommask.size <= 0) {
    return;
  }
  var_0 = scripts\engine\utility::array_randomize(level.setheadicon_removeclientfrommask);
  wait(randomfloatrange(level.disable_super_in_turret.sethistorydestination, level.disable_super_in_turret.setherodropscriptable));

  for(;;) {
    var_1 = 1;

    if(level.disable_super_in_turret.setheadicon_addclienttomask == level.disable_super_in_turret.sethasselfrevivetokenextrainfo)
      var_2 = level.disable_super_in_turret.setheadicon_addclienttomask;
    else
      var_2 = randomintrange(level.disable_super_in_turret.setheadicon_addclienttomask, level.disable_super_in_turret.sethasselfrevivetokenextrainfo);

    var_2 = min(var_2, var_0.size);
    var_3 = 0;

    foreach(var_5 in var_0) {
      var_3++;

      if(!update_track_timer(var_5.origin)) {
        var_1 = 0;
        thread _id_12D48(var_5);
      }

      if(var_3 >= var_2) {
        wait(randomfloatrange(level.disable_super_in_turret.setgameendflagsandnotifies, level.disable_super_in_turret.setfirsthistorydestination));
        var_3 = 0;
      }
    }

    if(var_1) {
      break;
    }

    waitframe();
  }
}

loadout_updateglobalclass(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
      var_0 disablescriptableplayeruse(var_2);
  }
}

_id_12D48(var_0) {
  var_0 setscriptablepartstate("_encstr_886B0EC03072F83C05CB95D8620FEDC0", "_encstr_A31F056641F582");
  loadout_updateglobalclass(var_0);
  _id_12D44(var_0);
}

_id_12D44(var_0) {
  var_0 endon("_encstr_910807339E3250552B");
  wait 30;
  var_0 setscriptablepartstate("_encstr_886B0EC03072F83C05CB95D8620FEDC0", "_encstr_BA19049F4B2D");
}

buy_menu_closed(var_0, var_1, var_2, var_3, var_4) {
  _encstr_9A1F34B98D3996838EB9BCAD07793B85DAB2D15E1CAC9B7913E4AFEC0BADB2D12F1C2BF59DE11CAF36860B1B3695379DB2CD8B9D37B1::_id_11FD2(var_3);
  thread add_ai_rider_to_decho(var_0, var_1, var_2, var_3);
}

add_ai_rider_to_decho(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("_encstr_910807339E3250552B");
  var_0 setscriptablepartstate("_encstr_886B0EC03072F83C05CB95D8620FEDC0", "_encstr_910807339E3250552B");
  var_5 = "_encstr_88711DC80F7D31396BAF935D9D37EBB5B4B15A1D0B9CE5AFD9F6F691F52603";
  wait 2;
  var_6 = _id_12779(var_0.location, var_3);
  wait(1 + var_6);
  var_0 setscriptablepartstate("_encstr_886B0EC03072F83C05CB95D8620FEDC0", "_encstr_82BD07E8BE86D055F3");
}

_id_12779(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;
  var_4 = randomintrange(0, level.disable_super_in_turret.setincomingcallback);

  if(var_4 < level.disable_super_in_turret.sethasrespawntokenextrainfo) {
    var_5 = var_1 scripts\mp\teams::lookupcurrentoperator(var_1.team);
    var_6 = level.setgun[var_5];

    if(isarray(var_6) && var_6.size > 0)
      var_3 = var_6[randomintrange(0, var_6.size)];
  } else if(var_4 < level.disable_super_in_turret.sethasrespawntokenextrainfo + level.disable_super_in_turret.setextractspawninstances || level.setdragonsbreathcorpseflare.size <= 0) {
    var_7 = level.setexfiltimer[var_0];

    if(isarray(var_7) && var_7.size > 0)
      var_3 = var_7[randomintrange(0, var_7.size)];
  }

  if(!isDefined(var_3)) {
    if(level.setdragonsbreathcorpseflare.size > 0)
      var_3 = level.setdragonsbreathcorpseflare[randomintrange(0, level.setdragonsbreathcorpseflare.size)];
  }

  if(isDefined(var_3)) {
    var_1 playsoundtoplayer(var_3, var_1);
    var_2 = lookupsoundlength(var_3) / 1000;
  }

  return var_2;
}
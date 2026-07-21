/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_t_reflex\mp_t_reflex_game_of_summer_createscript.gsc
***************************************************************************/

main(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("_encstr_8EA42808A3DFA5610AF545591D7099E4CFEA81F6FA634848E3C54BB31291303667C23B3943DF1640FAB4")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_8EA42808A3DFA5610AF545591D7099E4CFEA81F6FA634848E3C54BB31291303667C23B3943DF1640FAB4");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_1, var_2, "_encstr_8EA42808A3DFA5610AF545591D7099E4CFEA81F6FA634848E3C54BB31291303667C23B3943DF1640FAB4");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\so_trigger::wait_for_cs_flag(var_2);

  if(!isDefined(var_0))
    var_0 = "_encstr_B81904B98E5B";

  var_1 scripts\cp\so_trigger::initbunkerdoor(var_0, "_encstr_8EA42808A3DFA5610AF545591D7099E4CFEA81F6FA634848E3C54BB31291303667C23B3943DF1640FAB4");
  scripts\cp\so_trigger::initbunkerbackwallkeypads(var_1);
  level thread createstructs(var_1, var_0, var_2);
  level thread scripts\cp\so_trigger::wait_for_flags(var_1, "_encstr_8EA42808A3DFA5610AF545591D7099E4CFEA81F6FA634848E3C54BB31291303667C23B3943DF1640FAB4");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_AD11247BFE5910331F9A598132277C206E4FA7E799FDB0101F62D3A80B4F0F7209AC6B4F0125";
  var_4.modelscale = "_encstr_A34C02BB";
  var_4.receivevolumedecals = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (404, 1728.5, 230), (0, 300, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_A9F121AEADEB8CAC1BDEE47DC12D6CC6C291B436C697BE9936859DAFC1B7C62BAF6062";
  var_4.modelscale = "_encstr_A34C02BB";
  var_4.receivevolumedecals = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (410, 803.5, 230), (0, 150, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_8B9E276FC856B35207F88E07554F9A6439184F9F58E814797BB7937DC5A7376186D02F0748E046C2BB";
  var_4.modelscale = "_encstr_A34C02BB";
  var_4.receivevolumedecals = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-364, 803.5, 230), (0, 240, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_875D22DB920FD620BF0E9B9F2DE933119F7A1603CA7B8159D5178B9544C17A47BFF3EB49";
  var_4.modelscale = "_encstr_A34C02BB";
  var_4.receivevolumedecals = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (1172, 803.5, 230), (0, 240, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_B46F2683E82897174FFAD17947791808975A0773B6BD05A98517EB386BF73073DFED24337152B049";
  var_4.modelscale = "_encstr_A34C02BB";
  var_4.receivevolumedecals = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-364, 1728.5, 230), (0, 300, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_824021034AD71EE847F65347E5A15869D732DECB02B3D9219DDF735D1C99B28F87CA93";
  var_4.modelscale = "_encstr_A34C02BB";
  var_4.receivevolumedecals = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (1172, 1728.5, 230), (0, 300, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_978B1D7B70973FB771A06257C75B630915C85242B865B9C3C89F7F7348CB7A";
  var_0[[var_3]](var_4, var_1, var_2, (794, 1380, 425), (0, 90, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_978B1D7B70973FB771A06257C75B630915C85242B865B9C3C89F7F7348CB7A";
  var_0[[var_3]](var_4, var_1, var_2, (-358.5, 1280, 425), (0, 270, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_978B1D7B70973FB771A06257C75B630915C85242B865B9C3C89F7F7348CB7A";
  var_0[[var_3]](var_4, var_1, var_2, (-744.5, 1252, 425), (0, 90, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_978B1D7B70973FB771A06257C75B630915C85242B865B9C3C89F7F7348CB7A";
  var_0[[var_3]](var_4, var_1, var_2, (1175, 1272, 425), (0, 270, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-527.93, 1250.23, 18), (0, 8, 0), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", "_encstr_BED10CDEF387B922F9781FB34072", "_encstr_B4180481B8A1");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_87DC2B4B74420BEF5C9F7F6F8AF217D1076A3B69EBD7AB58F978D052DEF9D25F550B619A19E87E0FC1D172208D";
  var_0[[var_3]](var_4, var_1, var_2, (-591, 1451, 9), (0, 330, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (1090.5, 1266.5, 428), (0, 0, 180), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", undefined, "_encstr_99F90506E2DC4D");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-1005.5, 1266.5, 428), (0, 0, 180), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-541.5, 1266.5, 428), (0, 0, 180), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", undefined, "_encstr_AAF905A2683A9D");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (178.5, 1266.5, 428), (0, 0, 180), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", undefined, "_encstr_951804EAB6CA");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-453.5, 1272.5, 50), (0, 0, 0), "_encstr_97080D8E394B2C63EB99C6C2DACA9B");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-745.5, 1542.5, 426), (0, 0, 180), "_encstr_911C19447342666D56A8AB82F93AB231534B473510E2543A1ABF4B", undefined, "_encstr_A14C023B");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-743.5, 974.5, 426), (0, 0, 180), "_encstr_911C19447342666D56A8AB82F93AB231534B473510E2543A1ABF4B", undefined, "_encstr_A14C023B");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (24.5, 1542.5, 426), (0, 0, 180), "_encstr_911C19447342666D56A8AB82F93AB231534B473510E2543A1ABF4B", undefined, "_encstr_A74C0222");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (26.5, 934.5, 426), (0, 0, 180), "_encstr_911C19447342666D56A8AB82F93AB231534B473510E2543A1ABF4B", undefined, "_encstr_A74C0222");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (792.5, 1542.5, 426), (0, 0, 180), "_encstr_911C19447342666D56A8AB82F93AB231534B473510E2543A1ABF4B", undefined, "_encstr_A34C02BB");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (794.5, 950.5, 426), (0, 0, 180), "_encstr_911C19447342666D56A8AB82F93AB231534B473510E2543A1ABF4B", undefined, "_encstr_A34C02BB");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_AAEF31805BC5C509B755988620F753892C62A859821D0563877118F51207D3D157ABF1308AB577194B5F11F9274761213DA238";
  var_0[[var_3]](var_4, var_1, var_2, (-632.5, 1268.16, 112), (0, 0, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_97E22F6EA3DBE40BD9ACBE37D096C1C1B4B99DFA6CEDB93AB096CDB29C7D460366A3EB8D36B7DCAC8CBEC6ADEB2663AB56";
  var_0[[var_3]](var_4, var_1, var_2, (-584, 1095, 9), (0, 30, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_B111395659EBC4ABB436232DB93BCD7D5A3791D59B8E9CB4C2C6FA9C2C19D2B71DF677AC27F5604CF59B163ACA361BA5A3CABE462DDC0DFAC44BEC";
  var_0[[var_3]](var_4, var_1, var_2, (-432, 1268, 10), (45, 360, -90));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-531.93, 1274.23, 28), (0, 8, 0), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", "_encstr_BED10CDEF387B922F9781FB34072", "_encstr_951804EAB6CA");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-529.51, 1224.83, 8), (0, 8, 0), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", "_encstr_BED10CDEF387B922F9781FB34072", "_encstr_AAF905A2683A9D");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-531.93, 1298.23, 18), (0, 8, 0), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", "_encstr_BED10CDEF387B922F9781FB34072", "_encstr_B4180481B8A1");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5";
  var_0[[var_3]](var_4, var_1, var_2, (-537.51, 1322.83, 8), (0, 8, 0), "_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", "_encstr_BED10CDEF387B922F9781FB34072", "_encstr_AAF905A2683A9D");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_0[[var_3]](var_4, var_1, var_2, (0, 0, 0));
  var_0 scripts\engine\utility::ent_flag_set("_encstr_AF75130BBE1E378A8B0A3FE55B7199FA8DC6FC055D");
}
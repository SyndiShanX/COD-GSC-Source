/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicle.gsc
***********************************************/

init_vehicles() {
  scripts\engine\utility::create_func_ref("_encstr_A7370ECC589B3A4E7BC1ACFA1673D2B6", ::fastrope_anim);
  scripts\engine\utility::create_func_ref("_encstr_8A9812CCE71CF0912B19E7C9A87F2D69AEE072C7", ::matchdata_logweaponstat);
  scripts\common\vehicle::init_vehicles();
}

fastrope_anim(var_0, var_1, var_2) {
  var_0 dontinterpolate();
  var_0 scriptmodelclearanim();
  var_0 scriptmodelplayanimdeltamotionfrompos(getanimname(var_1), var_0.origin, var_0.angles, var_2);
}

matchdata_logweaponstat(var_0, var_1) {
  if(isDefined(var_0))
    var_0 vehicleplayanim(var_1, 0);
}

_id_1422B() {
  scripts\engine\utility::create_func_ref("_encstr_97B4166F882BF7CB7B83E41EF91311913040AFE7C1611042", ::_id_1310B);
  scripts\engine\utility::create_func_ref("_encstr_ACFF1A4B5091A1ABC153093B79E94776FD58D2C31913620F39461A31", ::_id_1310C);
  scripts\engine\utility::create_func_ref("_encstr_A1271860AAE3BFCB9F78A3AE44A7D68BCDF21818613E61E05799", ::_id_1310D);
  scripts\engine\utility::create_func_ref("_encstr_A1AB1C2E2BCC31A0ADD8C4E7895F815145B83727770705E788A8F636ACBB", ::_id_1310F);
  scripts\engine\utility::create_func_ref("_encstr_8CA81FA740E32F13B34BDC56A16B59D90898573FF9994D0A81D0A98A18117263B1", ::_id_13110);
  scripts\engine\utility::create_func_ref("_encstr_82231E1F80B35FF3A7C392B2C4FA01192DD96DFFA8E89BB0BBE2E052416015B1", ::_id_13111);
  scripts\engine\utility::create_func_ref("_encstr_851E18F3E8296963199BC1C3A121FF2EB5109A0BD1C3DC575070", ::_id_13112);
  scripts\engine\utility::create_func_ref("_encstr_B84A2367639D51D6B098D45EF058374A789387EFAF495AB1A0401AB28E4059E14305233FA1", ::_id_13113);
  scripts\engine\utility::create_func_ref("_encstr_B2B0180E911049EEF554833BAD1349D1B093850A3746D2300885", ::_id_13116);
  scripts\engine\utility::create_func_ref("_encstr_A6051850D9A317941718D4BF704ABF091D30504BD1CB7076045D", ::_id_13117);
  scripts\engine\utility::create_func_ref("_encstr_81D919CDAC3AF5D95686D26CD8ACFAC2E62DDA6EBEE89CBDD6ACDE", ::_id_13118);
  scripts\engine\utility::create_func_ref("_encstr_8D7618A3C773894402B3B4E1F8A0D9A776E84818E7053D686299", ::_id_13119);
  scripts\engine\utility::create_func_ref("_encstr_84AB19D730937F43E31B6CE6719BA909B8C8276F490BB10AC9A376", ::_id_1311A);
  scripts\engine\utility::create_func_ref("_encstr_B27C1893795357565BD2ABEE5007FFA99042384B21155A38ED51", ::_id_13115);
  scripts\engine\utility::create_func_ref("_encstr_9B930BAE6E56FAA3D527E495D1", ::_id_1405E);
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_1310B(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_A23919CCEC0133E38B9FA040579F1B755A55CF5D890AE7C8628780;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim = % _encstr_993919CE437DB00ED8FADB39CEAFEACDD8EDB08CAF23EDBD39F539;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim = % _encstr_99B71C4EE9C16683F6A6A27B89C0AF1DF07FD1A46FC02DB726DE6A721122;
  var_0[4].vehicle_getoutanim_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_1310C(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_81F01EBB79E1E9675C9716CADB37A2F2A9C341E839055B72FB31DB414BC02845;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_992623AB7C3760D6E2EF656D17699520A95371A32975E0830B1FBF4F1FE26F58476CD9F8CF;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_9ABC22EB3C772096A2AFA5ADD7A955E0E91331E369B520434B5FFF8FDFA22F18876ABBF8;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_8CFF1CC66149EE770B69EBF3F14833A690FF775DB91073FFAF8183FB1839;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % _encstr_954E21B3D8785F02A823828AC3F10AA79653B90A62CB4371A00F8562DB9099CFB52892;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % _encstr_A29C206743F558DC9656392758D7C10BCDB9FA59C34B8EF5C6DBB613B0A3D74EAECD;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[7].vehicle_getoutanim = % _encstr_AD3F1B3B1AFA0BE62DCA2727B07D31958CAFCAE12D8EEBE0858E27BD8D;
  var_0[7].vehicle_getoutanim_clear = 0;
  var_0[7].vehicle_getoutanim_combat = % _encstr_9B1F20BCCB595742788F65DB0BB7622DE7E89773075361E6A7A395C1BBD9C3EABA1F;
  var_0[7].vehicle_getoutanim_combat_clear = 0;
  var_0[7].vehicle_getoutanim_combat_run = % _encstr_9B1F20BCCB595742788F65DB0BB7622DE7E89773075361E6A7A395C1BBD9C3EABA1F;
  var_0[7].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");

_id_1310D(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].vehicle_getoutanim = % _encstr_A96F1A3BECA7E8C992BFD3A7EB3A0FC035458670D7CCF8689A3BD7C1;

  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13112(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_B41D1CB3A1FADA5BA51B7B7D46275A9D599CEBAC3CA5D17D0E85A327DB8D;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_B4EA217B71304AF3D88D5DA9F9F80933F5DD578FF943A38FA048D5EE71E0779ADD0927;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_93B320180BF708770A8D38286753BB93358BC908F3696367F275214E3E0B8F5B8D63;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_BA9F1AD934D7DA6D961B7B7DC12CCD9B7D56F04BE8BEC15847E4DBD8;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % _encstr_BE671F1CBBAF18705B6C20A9B890C792619BA0187C912E87CBBAF6DB37E8D19980;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % _encstr_84051E6743FAD6D6D236DE7D072CE69BD7CA0FB4E8D7C67BD69858A3AF9C5D37;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13113(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_B41D1CB3A1FADA5BA51B7B7D46275A9D599CEBAC3CA5D17D0E85A327DB8D;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_B4EA217B71304AF3D88D5DA9F9F80933F5DD578FF943A38FA048D5EE71E0779ADD0927;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_93B320180BF708770A8D38286753BB93358BC908F3696367F275214E3E0B8F5B8D63;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_BA9F1AD934D7DA6D961B7B7DC12CCD9B7D56F04BE8BEC15847E4DBD8;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % _encstr_BE671F1CBBAF18705B6C20A9B890C792619BA0187C912E87CBBAF6DB37E8D19980;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % _encstr_84051E6743FAD6D6D236DE7D072CE69BD7CA0FB4E8D7C67BD69858A3AF9C5D37;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[4].vehicle_getoutanim_clear = 0;
  var_0[5].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[5].vehicle_getoutanim_clear = 0;
  var_0[6].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[6].vehicle_getoutanim_clear = 0;
  var_0[7].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[7].vehicle_getoutanim_clear = 0;
  var_0[8].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[8].vehicle_getoutanim_clear = 0;
  var_0[9].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[9].vehicle_getoutanim_clear = 0;
  var_0[10].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[10].vehicle_getoutanim_clear = 0;
  var_0[11].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[11].vehicle_getoutanim_clear = 0;
  var_0[12].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[12].vehicle_getoutanim_clear = 0;
  var_0[13].vehicle_getoutanim = % _encstr_B4D91C933BAFC268F648879758A8626FD746DE4E1277DA9459F1B7DB18E3;
  var_0[13].vehicle_getoutanim_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13116(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_8EC21C4B4120BBE3C8F0ADB9E9C8392385CD679F0953939F28B963FAA050;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_A5FA21CE43D79B6DD28DDEEB8C9C2DD92B93FACAC3D2E8FAC6DBB513853AD72D46D895;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_869B206BF809835A533967AF018622DEB0C3A937524B4CD1BE27574373AD8912E8E8;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_B4141F2012417FF007C41818B04FBB07B71A30300BE99B6ADFE40887B92343F75D;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % _encstr_AFD72426B3A7DB0F6299577F53C0C8EFC5E8D87B4E41A538DB5D814EA88AC503A58F1F99BB9D;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % _encstr_86352353708FF2870829774F3FD13F3A13B8CAFA08372F83600D7F6B587833C66999637370;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % _encstr_99871BD91AF5CD5B2D1BBDBE1C859B6ECCFA56875AA3AF830B47C97B36;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % _encstr_927F20BEF32E0F646BD05A5118535AB70BF035389B93772E3FA0928A20D714A39845;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % _encstr_82971FDB9C493AD8B80397A1D3E3783BFE8F10500BDBB11260B199396BE93B232B;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13117(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_965C1CEC86AFA3CAD81AB7AF91C996D9B293D795F04B1DD783B0D19CDE1B;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_B12A21083A69296947B860708C3BD0E54F03C968D33C91662FD779D661CBDE83774A80;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_A2C320238B7F83ADA190679FC8BB696BD31EE11F6BBB3BCFC9C06763089367739BB8;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_9AA81AEC0DF547951B86DED738C26E9BAF2B3CB447D7C116E8E4B7D8;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % _encstr_ACEE1F8B81E00B2D5830EDF92B10633358233B6F5108A2EF6B19663BE6B8BC7A2D;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % _encstr_A62C1ECB63E71B050928CF0783A1EB930F0DD084D5BF22479040EF5361FBA50A;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % _encstr_93661A3B34FA3AB2D81ABDEBB1C289C8F5563C4BA3BE07168EE4B78D;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % _encstr_BE6D1FCE34FAE8561B86DEBE1B16138CEBB2E196E8EBD8DEAD2616A3F5B491D8B2;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % _encstr_8A361E23B8167452CF3BCDC996F31A7ABE489327304EDB3A3BC6563B90BD23FE;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % _encstr_97A31A6734F5A32B8D86EDAFB1851362AF56E15A1DAFC1C2A393B763;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % _encstr_8E8E1FE3E99873553028C5C161089AFF701B231749204A0738717E131E90A46235;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % _encstr_B2101E4DE81F03670F48928016772EB79E39E093A87649384356D719A96D231D;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  var_0[0].vehicle_getinanim = % _encstr_A159219CCA98D7D87B6BD7CEAC4370D7A3566C43DEF5CC36F5C8BDB739AFB11BDE6E95;
  var_0[0].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getinanim = % _encstr_850221932B13D7C67BB5AF3B56A1C1FA8E2BC643DB7DCC93BE19ED7BE4FAD863EDDCCA;
  var_0[1].vehicle_getinanim_clear = 0;
  var_0[2].vehicle_getinanim = % _encstr_880A2156374AD7090FEFA9F8D7502A9F535F46D30D317510D7E32038E34F99014A42CD;
  var_0[2].vehicle_getinanim_clear = 0;
  var_0[3].vehicle_getinanim = % _encstr_93BD216BE17E2F8E20BB3706B3C080E79D19F25208588382C9810F1775511E5348736A;
  var_0[3].vehicle_getinanim_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_1310E(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_96531C3B0DFA32B23643DED7919C96B3CA9CD756874B1DD70E2C1D93BDC6;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_871121D986D732B2B186F6D78C4E2DD9CAE4FAAC0FD2E87DD8EDB631851DD796918DCA;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_816720236A97D5C806B00F77A42AE0A407A39EC9D3E715E1DE9F0305C993896EEFFA;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_BEE61AEB70DE5C6A8773958167AB43F366B04B1F68368012F1169D45;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % _encstr_8CDA1F737908E2C58098555173781B6BE08BD387F950DAB7A8E1CE638E4B54D245;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % _encstr_8B4B1ECE34F58C56D886BD7D070B37377D563CA58E7DC6BDD6262C47D73957B9;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_1310F(var_0) {
  _id_1310E(var_0);
  var_0[2].vehicle_getoutanim = % _encstr_AF631F0368C8FB3768A9EFD757D03BCF87E1EBDB9BA0B7284B8927E06B60424721;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % _encstr_84EB247318B88B4738F95F67874BCB1F5751BBABCB1047F8B0F977238718162FFD0E9262C8D5;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % _encstr_87B223B3326171114FA07878834F3BBF120AB0A07F89BB8A3FC4686E97A7618B7B71306802;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % _encstr_8D9D1FD91AF59195C634F6BE8D2DB37D83C2B96E68BECA3C5A1DBE07C2A339DB63;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % _encstr_97B6247BE04ECCFA778365117E0B83AFF30BD7E79AA605F35BA5611650DB3A59DB893723B059;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % _encstr_B4FB230BDC97E87DE27B3F577F6A3CE950765323532FA8AB3A136737B7F20E500C41FB7B6D;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13110(var_0) {
  _id_1310E(var_0);
  var_0[2].vehicle_getoutanim = % _encstr_A30322450B599D98DBA42826CA8F884332879FD98B035020CFFFB2F8F357A08F1BB34761;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % _encstr_AF0F27BCE0F7015B4E1AD851B36511F86F95503552E7888FB9D258F88B31C7F08F3AC7ADE77F71F91F;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % _encstr_B64F268B9859B2981E80AFB9F80872918702885182130A0F5EBFC8F97157B655EB6E4E6CD8429335;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % _encstr_AAB21BA3EA17554886308FF734AA8028BFF159EA4213AF18DE04BD9F44;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % _encstr_ABF820CEA1FA32CA1B86BD7DA3E457DCD67DAC1E961DD7B1DE6BC42CA37D4B8C362B;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % _encstr_8C861F065B86FB3FA718A2B9E0DD739B78A89D90634BCF4657187A5288AF6A0F70;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13111(var_0) {
  _id_1310E(var_0);
  var_0[2].vehicle_getoutanim = % _encstr_B8CF1AB3912FF36DAE6AC706E2370E93D92A781A9CC1C00AB84DD074;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % _encstr_8F0A1F784A191979578850409B87417BF162801823A14F7007AA6FCD4F8FC9B927;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % _encstr_99571ED3B8182BE7D819BF8727E06EC6A0B1ABAAC3F0FF5DF075A994478073F3;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % _encstr_BDAE1A67D0F5232B8D1AEDFAC62C4C23BE56C3A547BE0EC21D9CDBB1;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % _encstr_8D5F1F670DD732ACB186DBFAB12C4C64D795C32DA3F51B7BD626C2A3F55AC88DAC;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % _encstr_AF331EC69B463BFF67D8627998BBF6AABEF540412DEE7F0513A08AC391B56BA3;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  var_0[4].vehicle_getoutanim = % _encstr_AAB21BA3EA17554886308FF734AA8028BFF159EA4213AF18DE04BD9F44;
  var_0[4].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim_combat = % _encstr_ABF820CEA1FA32CA1B86BD7DA3E457DCD67DAC1E961DD7B1DE6BC42CA37D4B8C362B;
  var_0[4].vehicle_getoutanim_combat_clear = 0;
  var_0[4].vehicle_getoutanim_combat_run = % _encstr_8C861F065B86FB3FA718A2B9E0DD739B78A89D90634BCF4657187A5288AF6A0F70;
  var_0[4].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13118(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_BDF51C1B70D0531AF04BFDCF17802277E06B01521A93EB99E0BBE4DA1FB8;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_BDDB21BB8CD7FB33E7D8FDFAA1C27DBA68BC99B31BE0CCD1E925BFA369643FB8B94175;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_8A2B20BD6841CBC2ED4FD71A27C46AE82DB471A8B8500409BE0D9F4956691E463B88;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % _encstr_B1C020932BC47D36B76BD7CEB20D83BED1B21B1ADEFA4CE47D91DBBD4EFAB7072BB9;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim = % _encstr_96BE208B924B10A06DDD174DFD9442D8BB0A2130DA67369009AC6F47F2B130178712;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getinanim = % _encstr_A159219CCA98D7D87B6BD7CEAC4370D7A3566C43DEF5CC36F5C8BDB739AFB11BDE6E95;
  var_0[0].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getinanim = % _encstr_850221932B13D7C67BB5AF3B56A1C1FA8E2BC643DB7DCC93BE19ED7BE4FAD863EDDCCA;
  var_0[1].vehicle_getinanim_clear = 0;
  var_0[2].vehicle_getinanim = % _encstr_93BD216BE17E2F8E20BB3706B3C080E79D19F25208588382C9810F1775511E5348736A;
  var_0[2].vehicle_getinanim_clear = 0;
  var_0[3].vehicle_getinanim = % _encstr_880A2156374AD7090FEFA9F8D7502A9F535F46D30D317510D7E32038E34F99014A42CD;
  var_0[3].vehicle_getinanim_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13119(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_8DCB1C6DE8A9D0C1D7DAC9B612838B807F6AB733908C60AF5B92E31BCA93;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % _encstr_BD71212B40E0870D10B70D2FB110D44315FB3182EA43DBC928970D1A53081147CD906A;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % _encstr_932720D550E198998F92B1FE4ACB435887A27F7BD8D4D8C8DFCA8841E20B1030DB06;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_8D371FB494796328E9D75891A33923A762BDA4B56A111BB2C14381E0CF445B271A;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % _encstr_A7FC24069C28539A4850CDA6D87FBEBEF548312F7A37D8FAB0ECFF5E62C02981A32FABB3532D;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % _encstr_954323A092C1F3B087439D9830CF3B87379AB0B08B691BEA5F64888E37C7C16BDB119088A2;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % _encstr_B2871EFBF38993C3BFDCED5FB5CBB91718B88A4326C6320196AB2458942CB193;
  var_0[2].vehicle_getoutanim_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_1311A(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_AB87259DD0EBCE96CD46A5B0D79885C6D6FA23BDF639FA95C3963AFAB17B5B13C21DBE5A23C6B2;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim = % _encstr_A7C2255558A8B33795FA4048B9A11709C8819F95F2AAB96280E26B1FB337587ADE9917E3DB29A0;
  var_0[4].vehicle_getoutanim_clear = 0;
  var_0[5].vehicle_getoutanim = % _encstr_A5DC26671AD7675A7332A50B7D9C2DEC34A3AF91DEF6C9F5CAC32DA3AFC6DE5B4C1647FA2D198DCA;
  var_0[5].vehicle_getoutanim_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13114(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_B8F020C002CEE731DF05C04CE52B921FB7EAD0981A29DDA84734D0C8EACF20095FC2;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_8DA9208A7932988E776518731B400A376AF201E0A7DFF105F70985ED95D118F04253;
  var_0[1].vehicle_getoutanim_clear = 0;
  return var_0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_13115(var_0) {
  var_0[0].vehicle_getoutanim = % _encstr_91E92039ACC47D36EDADFA9DCA0D1CD7E856B143DBEBCCC6FA19DE7B4EEBEDE0CAE6;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim = % _encstr_A2672030F23E17C10FD510FCB57BE24FE35A1B68CA99AD3BF7C4B7789A7FF0D90F92;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getinanim = % _encstr_A159219CCA98D7D87B6BD7CEAC4370D7A3566C43DEF5CC36F5C8BDB739AFB11BDE6E95;
  var_0[0].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getinanim = % _encstr_850221932B13D7C67BB5AF3B56A1C1FA8E2BC643DB7DCC93BE19ED7BE4FAD863EDDCCA;
  var_0[1].vehicle_getinanim_clear = 0;
  return var_0;
}

_id_1405E(var_0, var_1) {
  scripts\asm\asm_bb::bb_requestturret(var_0);
  scripts\asm\asm_bb::bb_requestturretpose(var_1);
  var_3 = var_0 gettagorigin("_encstr_92BA0B78CA075F093F9EC04D7A");
  var_4 = var_0 gettagangles("_encstr_92BA0B78CA075F093F9EC04D7A");

  if(self islinked())
    self unlink();

  self forceteleport(var_3, var_4);
  self linktoblendtotag(var_0, "_encstr_92BA0B78CA075F093F9EC04D7A", 0);
}
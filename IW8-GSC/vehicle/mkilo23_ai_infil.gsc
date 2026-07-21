/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\mkilo23_ai_infil.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("_encstr_ADA706A3E4BA1BB6", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);

  if(!isendstr(var_2, "_encstr_A5E109883AA2D373719F90"))
    scripts\common\vehicle_build::build_deathmodel(var_0, "_encstr_9A4D26368D30DAE1EB60E2E970D5E78F4862A1D410D34EB9BFE03A53B027113BE3550F5436ED73FF");

  scripts\common\vehicle_build::build_deathfx("_encstr_93512A9CCE4B48776D9BE8B282C00978BE7CAF1627C78E95D722F0C82A5F9F91BB08A1B7AB5FF09DEDEB8018", undefined, "_encstr_8AFB1BC465A3EEC757F2E1280B6D9F03CF0CD835E06B306FFFAA888863");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_treadfx(var_2, "_encstr_AB18059B2B98F7", "_encstr_8528333B99E1CBB4EE07798D95B3CA1B79D0963B4377C2CB5E9D99E1BED9CA43D26C8D59EB1D27CA163233C3BEC8D5CD8EB8EC66F0");
  scripts\common\vehicle_build::build_treadfx(var_2, "_encstr_96670551849240", "_encstr_B11E338B24E9EE49CBEA8E8B68833DA22F4BD4479B2FC29118A0B3A3A1BBF52A1B561D7FE881ABD5F9D8BBAB8911A1D3C958E337E3");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("_encstr_8E8405EA382B2A");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(var_2, "_encstr_ADDB15893D0E7079EF3230BBD9F32EA0269B5F09A53738", "_encstr_BA6B157338FFF99B08AC7064A8313B3D0568496AB0456B", "_encstr_93161F5BF27318E0DCF3BF2F0B06C0E89B7A31813A4F6480B3C7698D25EE4050D3", "_encstr_8F330BBBD79A4108E9E730C8AF");
  scripts\common\vehicle_build::build_light(var_2, "_encstr_ABD816BA918FD35D4B9F3014D7D0E25F26C841E3F8545B13", "_encstr_91CF1653C6DFF98A38B418500F6DABDDFD33261D9F975434", "_encstr_85161FF394D347581CBBFFAE36EB8BE97B7BDA3CF527B220FB4F9B3A7B60A7DF09", "_encstr_8F330BBBD79A4108E9E730C8AF");
  scripts\common\vehicle_build::build_light(var_2, "_encstr_83F816472C4B1B8DA57634A3EB4727EA6CDAD7274B9D34A3", "_encstr_8D3F1505664A87B859B760B86F6AD1375201FE037F1269", "_encstr_BDFA1F5E142A9E45CB883AF6E0337AA7430FD9CCB950F74CA9D153DB480F74EF3F", "_encstr_8F330BBBD79A4108E9E730C8AF");
  scripts\common\vehicle_build::build_light(var_2, "_encstr_B4EC1573632B5AF4D8619C639EC81203F6EF57ABC3C4A3", "_encstr_BEF9144927D208C8D96FB04B19BAE85E4A77C1E3A30B", "_encstr_ABFA1FCE99C397DA4B378DBC1BC227BEE8852D1BC65AD934E8FAE84EAB8D5BEB26", "_encstr_8F330BBBD79A4108E9E730C8AF");
  scripts\common\vehicle_build::build_light(var_2, "_encstr_87671731C9B0DAB263A53B1AE8AFE8E4AED85BBEE4969D343A", "_encstr_8D3F1505664A87B859B760B86F6AD1375201FE037F1269", "_encstr_B8D220D0ED6B4027FC9727E8A3BF88B7ABCB421F213D0C5FEA5B19C9EEF3BEC0B867", "_encstr_BE4E0C7A02E9BF47EC08F469D993");
  scripts\common\vehicle_build::build_light(var_2, "_encstr_8CF2168853F9F85B4ADCCC437391B10335BF78E9B3951121", "_encstr_BEF9144927D208C8D96FB04B19BAE85E4A77C1E3A30B", "_encstr_8CD2207B28E9DDA720BE63D75EC913190520B222A8A904D738255784EE132F5CD729", "_encstr_BE4E0C7A02E9BF47EC08F469D993");
}

init_local() {
  self.script_badplace = 0;
  self.vehicleanimalias = "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B";
}

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");
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

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 14; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[1].bhasgunwhileriding = 0;
  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 0;
  var_0[2].canshootinvehicle = 1;
  var_0[3].canshootinvehicle = 1;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  var_0[6].canshootinvehicle = 1;
  var_0[7].canshootinvehicle = 1;
  var_0[8].canshootinvehicle = 1;
  var_0[9].canshootinvehicle = 1;
  var_0[10].canshootinvehicle = 1;
  var_0[11].canshootinvehicle = 1;
  var_0[12].canshootinvehicle = 1;
  var_0[13].canshootinvehicle = 1;
  var_0[0].sittag = "_encstr_91A20B79911F31E58B287F0581";
  var_0[1].sittag = "_encstr_96F20EBDD9877601F6992991201F53AF";
  var_0[2].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[3].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[4].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[5].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[6].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[7].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[8].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[9].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[10].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[11].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[12].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[13].sittag = "_encstr_8A480B1D0B76D78C9547C21B34";
  var_0[0].getin = % _encstr_81241B82DBC8491B18A9CA2A43F4D001119BB4CB155B213FCF49B973F8;
  var_0[1].getin = % _encstr_A2AA194E5631BECE1AEB5BAD4B8DB7AF0785E69BF5CE593AEB2DDC;
  var_0[0].idle_anim = "_encstr_AA39225AE338F9EB03D692FA7869D7A1A075C9C60B40315F3DA86AA103352722C0292809";
  var_0[0].idle = % _encstr_AA39225AE338F9EB03D692FA7869D7A1A075C9C60B40315F3DA86AA103352722C0292809;
  var_0[1].idle_anim = "_encstr_A6ED20C54586E12CB3F9A890625B6829DAD94F7FD72C4079AFD16359CA0B16C86261";
  var_0[1].idle = % _encstr_A6ED20C54586E12CB3F9A890625B6829DAD94F7FD72C4079AFD16359CA0B16C86261;
  var_0[2].idle = % _encstr_97731B78A27A574033A7C4B5786788E7648A20FA4F59C193B789C5394D;
  var_0[3].idle = % _encstr_95091B6EC8E47DB683D73B2BA1D7ADD6D2C6B78CCCD7C019D7B491B156;
  var_0[4].idle = % _encstr_AFD61B23B58AF717F3AF330BD231388FC3F898D5EE410F73B7D3588DE9;
  var_0[5].idle = % _encstr_8EC11B5F59B679E58396EB3768A13DF283F1A7C29F48D7F451B8677DE1;
  var_0[6].idle = % _encstr_B2501B58F9F878850177AB0F2141ED372C9487FA3AEF4283914165116D;
  var_0[7].idle = % _encstr_A7251B37C8E4AFAD07EB67CA0D7D5BB62DC6ED2399D70C1BBEA5231B59;
  var_0[8].idle = % _encstr_85B81B16A4409FF10376031D93A62D98D0408F03172FEF0B1FDC9AA477;
  var_0[9].idle = % _encstr_BE5E1B6E345279F25AA7C3C371D97912C9BB787A7279477248AA39B037;
  var_0[10].idle = % _encstr_87FD1B38E23A17AD73E78475B8A74827A4CA60BA0F990152F7C985F98D;
  var_0[11].idle = % _encstr_8EB71B4AA57D69CDAB516B2F8026B55223C9D592B6FF475896D83B73F0;
  var_0[12].idle = % _encstr_8A5B1B78276A97B00A07A5208CB845F0AA80E706F38849FBE870C29473;
  var_0[13].idle = % _encstr_BD7A1B16F14E37997BF17D71E429E8037B6CC0E6CBC136D711F8C9E1BF;
  var_0[0].getout = % _encstr_A1752533B926678360975D5393288D1F5D331AFB0186AFBF38C35C1F9F08D523776BF1B2C9511F;
  var_0[1].getout = % _encstr_A74E23E3F7D2498C3ABF13077F225801784E4B5B913DA8CBD3D70707472A97E03F24113087;
  var_0[2].getout = % _encstr_8FD81BC8E82361655B28C0CF4A083FAB7361406A7617FA8AA7888AE33B;
  var_0[3].getout = % _encstr_B2281B2B91C889D75F86132A88202F7CF819BFD297F91AE290F9EB1213;
  var_0[4].getout = % _encstr_B2711B5A0910DFAA4FCFB3F789E092536090D5728B21F887304393FFA9;
  var_0[5].getout = % _encstr_BD5C1B8F600B179AB1F8C33F5BC752FBB0C8070242063057978D4834BD;
  var_0[6].getout = % _encstr_81731B4FA0CBD75A713803FF9B0712BBF08847C282C67007D7CD88F4FD;
  var_0[7].getout = % _encstr_99071BB851AAC9F929F8D33179B1F524D2B0D2FA9B29CA47FFCDABA939;
  var_0[8].getout = % _encstr_AD1E1B6E914EFADA387DCECA34F5D6B65AB1ED2399BE606EAF59F0961D;
  var_0[9].getout = % _encstr_AAC31B36505BC16FF8EED4CFF871B5E44BCC35FF57A1321A59AD83A1C3;
  var_0[10].getout = % _encstr_88DA1B5853B25663B3799C2D8C795B1801EB30AAE6470383299F932363;
  var_0[11].getout = % _encstr_B21C1BE6C89CEBB61CF5675943D7D6AD5A36F68C66BE62C0F52B1E5AA3;
  var_0[12].getout = % _encstr_A73D1B5F59B679E58396EB3768A13DF283F1A7C29F48C7F15139603CC3;
  var_0[13].getout = % _encstr_839D1BFFF916D945A0F68B5708019D5263110762FF286752B1991E5C63;
  return var_0;
}

unload_groups() {
  var_0 = [];

  for(var_1 = 0; var_1 < 14; var_1++)
    var_0["_encstr_8B1608EC43B8D647A113"][var_1] = var_1;

  return var_0;
}

#using_animtree("_encstr_A35F099B8B0BAA5B5081FA");
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

set_vehicle_anims(var_0) {
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
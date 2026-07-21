/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_quarry2\mp_quarry2.gsc
***********************************************/

main() {
  _encstr_825833CD1BC9A5831DCD79B683E5D60B839B79D638BEC5AE16934E5E8C975B387DC5570B9339E519EBE0C92B6C2CC6D02BE2ECB9C6::main();
  _encstr_85D132F720732943A1F69D055F2FAAE99B380E77500E895BE30ED23866C7C2B520729F8B91A3C5C21D2618E23803CB6C80486F5F::main();
  _encstr_8B1D2D8750033953B1E6AD354FDF5AF9AB287E67601E794BF37EC22896F712901690EFDFE8D3B9C7B71C48F51437CA::main();
  _encstr_87B93363D662582F5BEF77EBFBB6F95018AA6038BAE74065E2C3C5CB9A9E31209F825331A21248BE3943CB8FCBD30B987FCD99CB0E::main();
  scripts\mp\load::main();
  setDvar("_encstr_8C6A0AAFE187993125FC3337", 1);
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    brinit();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 5);

    if(!scripts\mp\utility\game::unset_relic_landlocked())
      brinit();

    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::arm_initoutofbounds();
    thread _id_12E15();
    thread _id_12960();
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_A2AA176CF6B6E02CDC6ED7B50B0EAFB6077DE2AB16E49CBC46");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  level thread scripts\engine\scriptable_door::system_init();
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.mapsafecorners = [];
  level.mapsafecorners[0] = (5000, 6000, 0);
  level.mapsafecorners[1] = (-8000, -200, 0);
  level.mapboundrycorners = [];
  level.mapboundrycorners[0] = (5500, 6500, 0);
  level.mapboundrycorners[1] = (-8500, -500, 0);
  thread player_fired_gun_monitor();
  thread runmisteffects();
  level thread _id_12F8E();
}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_A2BD0EB1D8B438668C1ECC463C23D4C6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (40282, 45823, 1027));
  var_1.angles = (0, 15, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (35248, 45128, 1312));
  var_3.angles = (0, 315, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_96DF0E4EC202196F2F82B0DA8BFF4822", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (35997, 46300, 809));
  var_5.angles = (90, 315, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (29748, 43260, 776));
  var_7.angles = (0, 285, -30);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = scripts\engine\utility::getStructArray("_encstr_A1290F986A27D18BDB7120AA77A373974A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_10 in var_8) {
    if(var_10.origin == (27241.5, 30626.5, 667))
      var_10.origin = (27369.5, 31074.5, 667);
  }
}

brinit() {
  level.br_level = spawnStruct();
  level.br_level.br_corners = [];
  level.br_level.br_corners[0] = (5000, 6000, 0);
  level.br_level.br_corners[1] = (-8000, -200, 0);
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (5500, 6500, 0);
  level.br_level.br_mapbounds[1] = (-8500, -500, 0);
  level.br_level.c130_speedoverride = 1000;
  _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::setc130heightoverrides(6000, 0);
  level.br_level.br_guncount = 50;
  level.br_level.br_equipcount = 50;
  level.br_level.firstclosetime = 60;
  level.br_level.firstdelaytime = 45;
  level.br_level.firstradius = 10500;
  level.br_level.firstminimapradius = 4000;
  level.br_level.br_circleclosetimes = [40, 25, 20, 15];
  level.br_level.br_circledelaytimes = [10, 10, 20, 20];
  level.br_level.br_circleradii = [7000, 4500, 2500, 1000, 0];
  level.br_level.br_circlestaticvfx = ["_encstr_832F1A3B9B7319AE328962173831901F022FEF613B2B1F03BAA9D923", "_encstr_AF711A74B4CBCFD650FF48CA987790018B77B7F7F3A3DE3CD3D728A8", "_encstr_B88A1ABB1293C078FA3FAD8F2667C93ECE0FFB06EB1B07A3D41BDFAF", "_encstr_A3031A45332BAFA0CA698A204D85116F07D2418F8F13D7D8F97E56BB"];
  level.br_level.br_circledynamicvfx = ["_encstr_A278195BF43939B29B210B578051570741B53242F01F87A8AB3917", "_encstr_B69D1876CDC0D18336FEBBD2E0853F83DA0948D7F102B2124893", "_encstr_B89A183B33F0EBC4E4D73D7BE62BEBA19AC060F51953180CBE37", "_encstr_92F418D999F0EB8993FAE9B7732BD7199A8181EB13030306F5CD", "_encstr_86DA153BCCF0F51327BEE9B7B9CAAF4C816060BE18D7E6"];
}

runmisteffects() {
  if(getdvarint("_encstr_9ABD114BFE5AD11DA2F7838DE30AC818E95213", 0) != 0) {
    return;
  }
  var_0 = [];
  var_0[0] = (48357, 15493, 5);
  var_0[1] = (42297, 14001, -749);
  var_0[2] = (36079, 12513, 71);
  var_0[3] = (15187, 24530, 1045);
  var_0[4] = (7000, 44546, 1600);
  var_0[5] = (14070, 53514, 1450);
  var_0[6] = (26040, 16952, 946);
  var_0[7] = (14573, 37152, 1100);
  var_0[8] = (38268, 62782, 1337);
  var_0[9] = (58910, 13559, 639);
  var_0[10] = (15421, 29167, 1200);
  var_0[11] = (52642, 81971, 11466);
  var_0[12] = (45081, 33895, 100);
  var_0[13] = (73746, 59402, 11308);
  var_0[14] = (53767, 54525, 3949);
  var_0[15] = (62131, 65284, 10933);
  var_0[16] = (84427, 61035, 14884);
  var_0[17] = (69933, 47018, 7556);
  wait 15;

  foreach(var_2 in var_0) {
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_2);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(0, 90));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(90, 180));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(180, 270));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
    var_3 = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(270, 359));
    var_3 = var_3 * randomfloatrange(3500, 3501) + var_2 + (0, 0, randomfloatrange(-100, 100));
    playFX(scripts\engine\utility::getfx("_encstr_A59617F3A738B9766B2F91B3A733CFF8EC7179280FB79035C2"), var_3);
  }
}

_id_12E15() {
  level.weaponstocycle = [];
  level.setallclientomnvarot[0] = (9932, 40850, 2000);
  level.setallclientomnvarot[1] = (11813, 24170, 1400);
  level.setallclientomnvarot[2] = (44793, 18312, -300);
  level.setallclientomnvarot[3] = (44321, 50943, 1029);
  level.setallclientomnvarot[4] = (27802, 59766, 4500);
  level.setallclientomnvarot[5] = (17533, 29553, 1600);
  level.setallclientomnvarot[6] = (5654, -1600, 456);
  wait 8;
  thread _id_12E14();
  thread _id_12E13();
  thread _id_12E12();
}

_id_12E11() {
  level.weapons_that_can_stun = [];
  level.weapons_that_can_stun[0] = (19730, 30320, 1541);
  level.weapons_that_can_stun[1] = (17414, 38445, 1100);
  level.weapons_that_can_stun[2] = (46709, 16278, -300);
  level.weapons_that_can_stun[3] = (37746, 26820, 280);
  level.weapons_that_can_stun[4] = (29320, 50046, 2798);
  level.weapons_that_can_stun[5] = (14700, 60220, 2727);
  level.weapons_that_can_stun[6] = (24479, 23645, 1450);
  level.weapons_that_can_stun[7] = (67607, 39784, 6300);
  level.weapons_that_can_stun[8] = (57384, 71389, 9348);

  for(;;) {
    var_0 = randomintrange(0, level.weapons_that_can_stun.size);
    var_1 = level.weapons_that_can_stun[var_0];
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.5;
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait(randomfloatrange(1.0, 2.0));
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
    wait 0.25;
    playFX(scripts\engine\utility::getfx("_encstr_BD5C159B704A173ABFF845FADCC7D2E893C8070790ED6E"), var_1 + (randomfloatrange(-2500, 2500), randomfloatrange(-2500, 2500), 0));
    wait(randomfloatrange(0.5, 1.0));
  }
}

_id_12E14() {
  var_0 = [];
  var_0[0] = (5430, 25860, 100);
  var_0[1] = (7062, 45322, 1453);
  var_0[2] = (46110, 9820, 388);
  var_0[3] = (36891, 18499, 100);
  var_0[4] = (28586, 60279, 4316);
  var_0[5] = (39120, 5927, 240);
  var_0[6] = (23273, 62353, 3500);

  foreach(var_2 in var_0)
  playFX(scripts\engine\utility::getfx("_encstr_9AE3129D5CC117C0FBB8E958874078EF965FE3EB"), var_2 + (randomfloatrange(-1500, 1500), randomfloatrange(-1500, 1500), 0));
}

_id_12E10() {
  playFX(scripts\engine\utility::getfx("_encstr_A32E17DBCDC3099F48067FC5F9909FE29B793BC78FE3B25E80"), (16019, 27466, 1000));
}

_id_12E12() {
  playFX(scripts\engine\utility::getfx("_encstr_B1E7169D33E1AF76EEEB58DA1396CA9B3AFA1C1B2CCD2B37"), (-6683, 31192, 2772), (2, 10, 0));
  playFX(scripts\engine\utility::getfx("_encstr_B1E7169D33E1AF76EEEB58DA1396CA9B3AFA1C1B2CCD2B37"), (37881, 63083, 3712), (7, 251, 0));
}

_id_12E13() {
  foreach(var_1 in level.setallclientomnvarot)
  playFX(scripts\engine\utility::getfx("_encstr_A30E1920DD888120AB6F1252DF50673178BB5BDA27D7CDAF40A2B3"), var_1, (0, 100, 0));
}

_id_12960() {
  wait 5;
  var_0 = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
  var_0 settransientsoundbank("_encstr_95421430E28DD393EF43808F35CF1B85305FFA906AA5", 1);
}

_id_12F8E() {
  level.modifiedspawnpoints["_encstr_A9260CBD435335E3CA03BB9E8159"]["_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD"]["_encstr_A353071677FAF7EB45"] = 1;
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_A54F06D32A2F0498":
      if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        break;
      } else {
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (25726.2, 29493.4, 659.5), (0, 45, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (25870.3, 29474.6, 657), (0, 45, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (26074.3, 29354.6, 657), (0, 45, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (25898.3, 29348.6, 657), (0, 45, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (26311.8, 29375.9, 657), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (26447.8, 29431.9, 657), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (26519.8, 29543.9, 657), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (26575.8, 29391.9, 657), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (27432.7, 29432.4, 653.41), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (27463.5, 29636.7, 653.342), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (27682.2, 29514.2, 653.44), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (27621.7, 29310.4, 653.49), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (39602.8, 47062.1, 962.745), (1.15263, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (39409.4, 47045.8, 963.028), (360, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (39520.9, 47149, 963.028), (360, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (39419.5, 47253.5, 963.028), (360, 225, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (39889, 46619.3, 963.051), (0, 195, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (39939, 46521.4, 963.062), (0, 195, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (39986.9, 46286.3, 963.029), (0, 195, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (40057.8, 46373.9, 963.05), (0, 195, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (38392, 48104, 968), (0, 240, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (38516.4, 47977.5, 963), (0, 240, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (38269.8, 47972.3, 963), (0, 240, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (38546.4, 47977.5, 963), (0, 240, 0));
        break;
      }
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}
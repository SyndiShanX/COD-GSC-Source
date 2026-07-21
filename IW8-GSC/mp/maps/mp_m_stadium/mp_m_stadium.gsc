/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_stadium\mp_m_stadium.gsc
*************************************************/

main() {
  _encstr_B62F37DF4E7AF830153B669DA30838FF18D6A5C20F3735AF4760B932B8B035C7EB0B9903DF23EC59B8527B0776B2CB0F4F31EBB1AF0DC79330::main();
  _encstr_A3CB366B3166C77AC89757ED69EAC52F8FAB2632FBA8AFF9D8B111EC73108D4EBC81AA9E2097AFADE1A71CF171A8538FC8B9E3B3E0E44766::main();
  _encstr_914931CDB1934B83D1CD97DA07796B0B1C9BBCB60EF5D6D7371DC21996EADA796B837DD6F59BA31623B45DB6FA33E11776E66C::main();
  _encstr_9A4D37338E739F2AD9B0D6CA9057A577EB6EE7D59F7E37B9BFE03A52B00B9D1620570F5DA0831BFE491063DA1961D4FF383DB1C6C4808F026F::main();
  scripts\mp\load::main();
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_AC691970EA02896EC74719BA4F231F85D741187763339BADA3DBAB", "_encstr_9BC423EB30090F269FD03A43A1979D8F23AF637340704FAA1FE073A92897D223F985F10DE1");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level thread damage_multiplier();
  level thread _id_12733();
  thread _id_121F4();
  level thread _id_1362A();
}

_id_12733() {
  if(getdvarint("_encstr_B4831502B14887A27F1357C75710AAF3A83B3FCBE94054", 0) == 0)
    level.select_stairway_spawners["_encstr_BDBA0E76F6CDF5CC96C9ACDDED4EB59B"] = loadfx("_encstr_81CE2967990FBCA5EE077D5B3879B32CADB2DAF6915979B3990F7DB3B7CDEB334B9CB2BBDB39AD713B33C3");

  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\utility\game::waslastround()) {
    scripts\engine\utility::exploder("_encstr_88A7079FB7DFC4D95F");
    scripts\engine\utility::exploder("_encstr_81A7076FD70B156F0E");
    var_0 = [];

    if(!isDefined(level._id_1346E)) {
      var_1 = getEntArray("_encstr_8C720C66B05851629697BFA7D331", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2 = getEntArray("_encstr_85B80A1FB898B3E8E1707299", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(var_1.size > 0 && var_2.size > 0) {
        var_3 = spawnStruct();
        var_3.trigger = var_1[0];
        var_3.select_low_roof_spawners = 10;
        var_4 = spawnStruct();
        var_4.trigger = var_2[0];
        var_4.select_low_roof_spawners = 10;
        var_0 = [var_4, var_3];
      }
    } else {
      foreach(var_6 in level._id_1346E)
      var_6.select_low_roof_spawners = 10;

      var_0 = level._id_1346E;
    }

    for(var_8 = 0; var_8 < var_0.size; var_8++)
      var_0[var_8] thread _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::select_lobby_door_two_spawners(1, 0.5);
  }
}

vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "_encstr_AFFF0C6E8FE899DDE6174B068510");
}

damage_multiplier() {
  var_0 = (-459, -498, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-128, -337, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (405, 8, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (213, -44, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (353, 409, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (135, 308, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-332, 988, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (334, 978, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-288, -141, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-456, 381, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-467, 551, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-467, 148, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-358, 180, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-459, 18, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-289, -140, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-271, -199, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (270, -50, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (419, -67, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (331, -89, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (435, 180, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (218, -108, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-3.41, 218.7, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-6, 240, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (327.47, -158.39, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
  var_0 = (-2, 208, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
}

_id_121F4() {
  var_0 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-495, -1237, -348));
  var_1.angles = (0, 330, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

_id_1362A() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-150, -470, -230), 0, 64, 100);
  var_0 thread _id_144FF("_encstr_A35A1093A5850A53C943FD439B4877A25E31");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (177, -46, -200), 0, 64, 100);
  var_1 thread _id_144FF("_encstr_A5B00F4B1BF833FAE89B9FA397AD027B58");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-95, 125, -230), 0, 64, 100);
  var_2 thread _id_144FF("_encstr_A21C0F474EAE1B5BBEDA9632FAEECA6EE8");
}

_id_144FF(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!isDefined(self._id_126CE))
      self._id_126CE = [];

    if(scripts\engine\utility::array_contains(self._id_126CE, var_1.guid)) {
      continue;
    }
    self._id_126CE = scripts\engine\utility::array_add(self._id_126CE, var_1.guid);

    switch (var_0) {
      case "_encstr_A35A1093A5850A53C943FD439B4877A25E31":
        var_1 thread _id_14504(self);
        break;
      case "_encstr_A5B00F4B1BF833FAE89B9FA397AD027B58":
        var_1 thread _id_14502(self);
        break;
      case "_encstr_A21C0F474EAE1B5BBEDA9632FAEECA6EE8":
        var_1 thread _id_14503(self);
        break;
    }
  }
}

_id_14504(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (125, 1115, -335);
  var_4.radius = 64;
  var_3[var_3.size] = var_4;
  var_5 = [];

  foreach(var_7 in var_3)
  var_5[var_5.size] = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 100, var_1, undefined, self, 0, self, 1);

  while(isDefined(self) && self istouching(var_0))
    waitframe();

  foreach(var_10 in var_5)
  scripts\mp\spawnlogic::removespawndangerzone(var_10);

  var_0._id_126CE = scripts\engine\utility::array_remove(var_0._id_126CE, var_2);
}

_id_14502(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-24, 863, -335);
  var_4.radius = 500;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (478, -1005, -335);
  var_4.radius = 225;
  var_3[var_3.size] = var_4;
  var_5 = [];

  foreach(var_7 in var_3)
  var_5[var_5.size] = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 100, var_1, undefined, self, 0, self, 1);

  while(isDefined(self) && self istouching(var_0))
    waitframe();

  foreach(var_10 in var_5)
  scripts\mp\spawnlogic::removespawndangerzone(var_10);

  var_0._id_126CE = scripts\engine\utility::array_remove(var_0._id_126CE, var_2);
}

_id_14503(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-480, 1000, -335);
  var_4.radius = 225;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (348, 1058, -335);
  var_4.radius = 300;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (427, -866, -335);
  var_4.radius = 64;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-437, -864, -335);
  var_4.radius = 64;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (454, -14, -335);
  var_4.radius = 64;
  var_3[var_3.size] = var_4;
  var_5 = [];

  foreach(var_7 in var_3)
  var_5[var_5.size] = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 100, var_1, undefined, self, 0, self, 1);

  while(isDefined(self) && self istouching(var_0))
    waitframe();

  foreach(var_10 in var_5)
  scripts\mp\spawnlogic::removespawndangerzone(var_10);

  var_0._id_126CE = scripts\engine\utility::array_remove(var_0._id_126CE, var_2);
}
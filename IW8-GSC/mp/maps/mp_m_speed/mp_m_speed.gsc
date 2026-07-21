/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_speed\mp_m_speed.gsc
***********************************************/

main() {
  _start_rooftop_raid_heli::keypad_check_levelinput();
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_92F133CD8DE42DC1A39BBCB683795BB0389B79AD07F5D6EB37C156AC3279AD0ED7DAF56E83CA5932AF83932B3658D80DACB89D37B1::main();
  _encstr_88A93212CE1ADA11EBFFA68F300F1D03287FE82DD3B78DA7B81BB590C09541E81EBF622BA9B521470307FB1447C93030A28AE3C0::main();
  _encstr_AB282DF3CE33DF6A99F0968AD01765B72BAE2795DF3E77797F833A02187F5D2B2619CF0377819FFF7FA8F3AE181F16::main();
  _encstr_BEB0334F98CBE18B792E55FD97E712B1D37046BF98C62DA18F47CFF7F5BF2A68DE380F5F30799D5AFF51D46FEBE1A20E61CA77D750::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_BD6A17AE4F972BEBF203C1285A4ADFC0BBD72108CB0B713B1F", "_encstr_A63321F01AF737D93774B53647AFC0E35A42F8E871CD6BB3AF85C7B85D370B61C7EAF8");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  scripts\cp_mp\utility\game_utility::_id_12B3B();
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread _id_139C6();
  level thread player_exfil_struct();
  level thread _id_136AD();
}

_id_139C6() {
  var_0 = getEnt("_encstr_939E06176861F83F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_9A550B6FDAFED02DE7B2A00B4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3 linkTo(var_0);

  var_0._id_12149 = var_0.angles;
  thread _id_139C8(var_0);
}

_id_139C8(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0.75;

  for(;;) {
    var_2 = 4;
    var_1 = var_1 * -1;
    var_0.goalang = var_0._id_12149 + (randomfloatrange(-0.5, 0.5), randomfloatrange(-4, 4), var_1);
    var_0 rotateTo(var_0.goalang, var_2, var_2 * 0.25, var_2 * 0.25);
    wait(var_2 - 0.1);
  }
}

_id_136AD() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-20, 2235, 190), 0, 32, 100);
  var_0 thread _id_144FF("_encstr_86EA077F73A8DAF728");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-216, 2236, 190), 0, 32, 100);
  var_1 thread _id_144FF("_encstr_86EA077F73A8DAF728");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-700, 3040, 65), 0, 128, 100);
  var_2 thread _id_144FF("_encstr_AB590B86222AD7F86FF72878A3");
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-450, 1375, 125), 0, 128, 100);
  var_3 thread _id_144FF("_encstr_8A3009F121DBA6B70C1A48");
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
      case "_encstr_86EA077F73A8DAF728":
        var_1 thread _id_14509(self);
        break;
      case "_encstr_AB590B86222AD7F86FF72878A3":
        var_1 thread _id_144F5(self);
        break;
      case "_encstr_8A3009F121DBA6B70C1A48":
        var_1 thread _id_144E6(self);
        break;
    }
  }
}

_id_14509(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-1022, 2190, 20);
  var_4.radius = 64;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-1725, 2245, 20);
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

_id_144F5(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-790, 2850, 20);
  var_4.radius = 256;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-760, 1290, 20);
  var_4.radius = 220;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-770, 780, 20);
  var_4.radius = 100;
  var_3[var_3.size] = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-750, 1800, 20);
  var_4.radius = 200;
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

_id_144E6(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-1720, 1325, 20);
  var_4.radius = 256;
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

player_exfil_struct() {
  var_0 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-151, 2496, 224));
  var_1.angles = (0, 0, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-279, 2496, 224));
  var_3.angles = (0, 0, -90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-216, 2496, 416));
  var_5.angles = (0, 0, -90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-840, 2230, 224));
  var_7.angles = (0, 0, -90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-712, 2230, 224));
  var_9.angles = (0, 0, -90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-776, 2230, 416));
  var_11.angles = (0, 0, -90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-879, 2705, 224));
  var_13.angles = (0, 0, -90);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-815, 2705, 416));
  var_15.angles = (0, 0, -90);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("_encstr_919109AA5148539DA0FDAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1035, 1444.5, 74));
  var_17.angles = (0, 270, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16, 1);
}
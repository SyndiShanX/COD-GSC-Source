/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_vacant\mp_vacant.gsc
***********************************************/

main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  _encstr_8BC23113A7F03CAB551B8E52839717F6382FF78519F183B7F67192CB40091B21A0F333114D10013B26E95A82D1D387B5507FAB::main();
  _encstr_962A309B364ED207E8E6CBD60ECB6B5838CDBCD6E07DEC851B1637D197CE9573F2B6387DD90B8D0B9B477D85273A5CCEDCC6::main();
  _encstr_85EF2B0BBFE82443BDE3664AAB380F9E5007DF6DF1D9ABCFEE596AE3586133D9988B0BE97568398B0B98F29BB9::main();
  _encstr_A38E31A32118490343E396707957E3AF775685A773A993A12B97CD3398A0E3BFC6B71828EA08CF829337519B1A7DBC4874ABDE::main();
  scripts\mp\load::main();
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (5120, 0, -512), 0, 512, 800);
  var_0.targetname = "_encstr_8A720C48B3AB7729A26778B853CB";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_85B316EED858403A9EC767A7CBC70185582623F6F1801623", "_encstr_AF5520C76FE7E0473FAB4993214708D8BAF96F9F370D481767D2E33EDB273660D544");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  thread player_fired_gun_monitor();
  level thread _id_1362C();
}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_AA9508ADB7EA9BA3C61A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2830, 1212, 112));
  var_1.angles = (270, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0, 1);
}

_id_1362C() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (1720, 1737, 100), 0, 64, 100);
  var_0 thread _id_144FF("_encstr_88190426B73C");
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
      case "_encstr_88190426B73C":
        var_1 thread _id_14491(self);
        break;
    }
  }
}

_id_14491(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (2883, 712, 60);
  var_4.radius = 128;
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
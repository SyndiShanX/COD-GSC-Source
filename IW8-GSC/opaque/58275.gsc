/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58275.gsc
***********************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_138FD = "_encstr_83970FCC5A2BD846D7E45637EA07E0B1E5";
  var_0.assault_update_hint_logic = ::assault_update_hint_logic;
  var_0.isdisconnecting = ::isdisconnecting;
  _keypadscriptableused_bunkeralt::_id_12AF4(var_0);
}

assault_update_hint_logic() {
  _id_135B7();
  self.player playlocalsound("_encstr_AB222D979390AA4FF2C6BB441BF170D355036F6F7338B21F38C877CE73C8AC59BC9BE383F75EEBCDA890E1158B28E3");
  self.player thread _id_12CCC();
  _keypadscriptableused_bunkeralt::_id_12425(self.player, "_encstr_93462B22DE1F9B9BB04E1D7F17C3FF2B5F786BC759384BBFBD7BA1206BD6B7C32B71323F22C6903CB3036BCFF0");
}

_id_12CCC() {
  self.health = self.maxhealth;
  self.br_armorhealth = self.br_maxarmorhealth;
  self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", 1);
  scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::play_hud_reminder_vo();
  scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
  thread _id_12CCB();
}

_id_12CCB() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread scripts\mp\equipment::givescavengerammo();
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

isdisconnecting() {}

_id_135B7() {}

isplatepouch() {
  _encstr_86272063EE5BD1037B9032D850808A4F614F53F7470393A82283E9789593B5978ED7::_id_12B21(::isplacementplayerobstructed);
  level thread isplayerbrsquadleader();
}

isplayerbrsquadleader() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.player))
    waitframe();
}

isplacementplayerobstructed(var_0, var_1) {
  var_2 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_96BD218B124B89416FD9456BC717C8C5DB1AA6737AD7BD70C2A44327F0BDF09DDBA3DB":
      level.player _keypadscriptableused_bunkeralt::_id_1393A("_encstr_83970FCC5A2BD846D7E45637EA07E0B1E5");
      break;
    case "_encstr_8ABE22FBA8A559D858B8B0B7C6B982E78D9B91695B6FFE638322F50327A398470592AB98":
      var_3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("_encstr_956925353B32408074D143BB454A508DB99BB7971FBB1540877728B12D3491BEF20F0BE1E382DB", var_3);
      break;
    case "_encstr_ADDF2A9B025BF9311FA9557BF783B837CFBA71C36A572448B7B40917E22FC085E30368EA5143E8804F822341":
      var_4 = scripts\mp\utility\teams::getteamdata(level.player.team, "_encstr_9775086022BE1B413B8B");
      var_4 = scripts\engine\utility::array_remove(var_4, level.player);
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::_id_1393A("_encstr_83970FCC5A2BD846D7E45637EA07E0B1E5");
      break;
  }
}
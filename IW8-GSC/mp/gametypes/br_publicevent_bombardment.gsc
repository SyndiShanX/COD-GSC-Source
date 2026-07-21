/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_bombardment.gsc
*******************************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_140CF = ::_id_140CF;
  var_0.attackerswaittime = ::attackerswaittime;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8BC10D10BFF87BCF58583BE223A02F;
  var_0.weight = getdvarfloat("_encstr_91331DDC6C93AF9827D7E0CA7DC47BAD980B4E91B5ACE6D1AFBB95A59DA1E8", 1.0);
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(5, var_0);
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  if(getdvarint("_encstr_852B1EFB43FB576A22E14F97915B0F950297D0356B6B8E4B5E3A2D50B0BBC0DA", 1))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D961129070B413DBF7DD107C768087AB93932"] = "_encstr_8D961129070B413DBF7DD107C768087AB93932";
  else {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4EE153765A669F9F0211A639E6B0963FEEB9B8FB76FE7"] = "_encstr_B4EE153765A669F9F0211A639E6B0963FEEB9B8FB76FE7";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9EE1557B68B1629DCF7FDD9F7DD40A663E03C0997A5DA"] = "_encstr_A9EE1557B68B1629DCF7FDD9F7DD40A663E03C0997A5DA";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6EE15F2E99ED7F6D073B2BC6FB0BC3F4620DA7AD6D6A2"] = "_encstr_B6EE15F2E99ED7F6D073B2BC6FB0BC3F4620DA7AD6D6A2";
    _hidesafecircleui::stopusingbomb();
  }
}

_id_140CF() {
  return 0;
}

attackerswaittime() {
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_9BBB180A8D9172E7D831725AD92F63AFA81B8E84BF883BBF76EB");
  var_0 = getdvarfloat("_encstr_AAA1179653FBDEFDE59258587B7FABD133EC088EA94BC0EBCA", 3000);

  if(isDefined(level.delay_turn_laser_trap_back_on))
    var_1 = [[level.delay_turn_laser_trap_back_on]]();
  else
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincurrentcircle(0.2, 0.8);

  var_2 = getdvarfloat("_encstr_BAE519EE8E73EF0127F72838E344B8C31AF370FDE38B5B0B19E730", 70);
  level thread crates_delete_early(var_1, var_0, var_2);

  if(getdvarint("_encstr_852B1EFB43FB576A22E14F97915B0F950297D0356B6B8E4B5E3A2D50B0BBC0DA", 1)) {
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8D961129070B413DBF7DD107C768087AB93932", undefined, undefined, 1);
    level thread _id_1383A(var_1, var_0, var_2);
  } else {
    var_3 = ["_encstr_B4EE153765A669F9F0211A639E6B0963FEEB9B8FB76FE7", "_encstr_A9EE1557B68B1629DCF7FDD9F7DD40A663E03C0997A5DA", "_encstr_B6EE15F2E99ED7F6D073B2BC6FB0BC3F4620DA7AD6D6A2"];
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog(var_3[randomintrange(0, 3)], 1, level.players);
    _hidesafecircleui::changetimertoovertimetimer(var_1, undefined, var_2, var_0);
  }
}

_id_1383A(var_0, var_1, var_2) {
  self notify("_encstr_ACB012EBA319A35058628045D691EA986DA5CD41");
  self endon("_encstr_ACB012EBA319A35058628045D691EA986DA5CD41");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = 2 * level.framedurationseconds;
  var_4 = 5;
  var_5 = getdvarint("_encstr_A5C224E3668A81D9B347AB23D18EB07B2AFF5B0F300DAD5B410640BA5F30F081D20F4AE03D3F", 100);
  var_6 = getdvarint("_encstr_8FE22BC3E8153963AB70A8B568F10FFD5D805B2A3083ADF3E64E94BA1BF8EF899D584372F053A993193D81B52E", 100);
  var_7 = gettime() + var_2 * 1000;

  while(gettime() < var_7) {
    level.create_digit_models = [];

    for(var_8 = 0; var_8 < var_4; var_8++) {
      var_9 = _encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::do_spawn_vo_callout(var_0, var_1);

      if(!isDefined(var_9)) {
        break;
      }

      level thread _encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::dropbrprimaryweapons(var_9, var_5, var_6);

      if(getdvarint("_encstr_B2BA1B309A320FF9739FFF7D876BED239E02B010920FB5F3EFDB856D9E", 0))
        level thread _hidesafecircleui::chase(10, var_9);

      wait(var_3);
    }

    wait 20;
  }
}

crates_delete_early(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = getmaxobjectivecount(var_0[0], var_0[1], var_1);
  wait(var_2);
  var_3 delete();
}

helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = getdvarint("_encstr_A9DB1EDAB6EDF9725BE1E3BFC9712782A5DFE297297B22AC0620AFAFB1C8E11B", 150);
  var_1 = getdvarint("_encstr_B1DB1EC7CF3EF162681EF2BF36C0A76A9E635B13ABEDAA4CD981AD072EC0F992", 25);
  radiusdamage(self.origin, 256, var_0, var_1, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_95E70D8EDBDA85F5839CED35F5B683");
}
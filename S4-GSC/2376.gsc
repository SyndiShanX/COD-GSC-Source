/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2376.gsc
*************************************************/

_id_8046() {
  var_0 = spawnStruct();
  return var_0;
}

_id_D30C() {}

_id_FA0D() {}

_id_8041() {
  var_0 = spawnStruct();
  var_0._id_9D50 = 1.0;
  return var_0;
}

_id_D2FB() {
  self._id_AFAA["health"]._id_9C21 = 125;
  self._id_AFAA["health"]._id_9D50 = 1.0;
}

_id_F9FE() {
  self._id_AFAA["health"]._id_9D50 = 1.0;
}

_id_D2FC() {
  self._id_AFAA["health"]._id_9C21 = 125;
  self.maxhealth = self._id_AFAA["health"]._id_9C21;
  self notify("health_perk_upgrade");
  self._id_AFAA["health"]._id_9D50 = 1.25;
}

_id_F9FF() {
  self._id_AFAA["health"]._id_9D50 = 1.0;
}

_id_D2FD() {
  self._id_AFAA["health"]._id_9C21 = 150;
  self.maxhealth = self._id_AFAA["health"]._id_9C21;
  self notify("health_perk_upgrade");
  self._id_AFAA["health"]._id_9D50 = 1.25;
}

_id_FA00() {
  self._id_AFAA["health"]._id_9D50 = 1.0;
}

_id_D2FE() {
  self._id_AFAA["health"]._id_9C21 = 175;
  self.maxhealth = self._id_AFAA["health"]._id_9C21;
  self notify("health_perk_upgrade");
  self._id_AFAA["health"]._id_9D50 = 1.5;
}

_id_FA01() {
  self._id_AFAA["health"]._id_9D50 = 1.0;
}

_id_D2FF() {
  self._id_AFAA["health"]._id_9C21 = 200;
  self.maxhealth = self._id_AFAA["health"]._id_9C21;
  self notify("health_perk_upgrade");
  self._id_AFAA["health"]._id_9D50 = 2.0;
}

_id_FA02() {
  self._id_AFAA["health"]._id_9D50 = 1.0;
}

_id_803E() {
  var_0 = spawnStruct();
  var_0._id_2D25 = 1.0;
  return var_0;
}

_id_D2EC() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.2;
}

_id_F9EF() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
}

_id_D2ED() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.2;
  scripts\cp\utility::_id_6FC2("specialty_quickswap");
  scripts\cp\utility::_id_6FC2("specialty_stalker");
  scripts\cp\utility::_id_6FC2("specialty_fastoffhand");
}

_id_F9F0() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
}

_id_D2EE() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.2;
  scripts\cp\utility::_id_6FC2("specialty_quickswap");
  scripts\cp\utility::_id_6FC2("specialty_stalker");
  scripts\cp\utility::_id_6FC2("specialty_fastoffhand");
  scripts\cp\utility::_id_6FC2("specialty_quickdraw");
}

_id_F9F1() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
}

_id_D2EF() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.2;
  scripts\cp\utility::_id_6FC2("specialty_quickswap");
  scripts\cp\utility::_id_6FC2("specialty_stalker");
  scripts\cp\utility::_id_6FC2("specialty_fastoffhand");
  scripts\cp\utility::_id_6FC2("specialty_quickdraw");
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
}

_id_F9F2() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
}

_id_D2F0() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.5;
  scripts\cp\utility::_id_6FC2("specialty_quickswap");
  scripts\cp\utility::_id_6FC2("specialty_stalker");
  scripts\cp\utility::_id_6FC2("specialty_fastoffhand");
  scripts\cp\utility::_id_6FC2("specialty_quickdraw");
  self _meth_82D3(0.5);
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
}

_id_F9F3() {
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
  self _meth_82D3(1.0);
  scripts\cp\utility::_unsetperk("specialty_fastreload");
}

_id_8045() {
  var_0 = spawnStruct();
  var_0._id_C7D3 = 1.0;
  var_0._id_6158 = 1.0;
  var_0._id_A200 = 1.0;
  var_0._id_C7BD = 1.0;
  return var_0;
}

_id_D305() {
  self._id_AFAA["medic"]._id_C7D3 = 1.5;
  self._id_A25F = _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
}

_id_FA08() {
  self._id_AFAA["medic"]._id_C7D3 = 1.0;
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
}

_id_D306() {
  self._id_AFAA["medic"]._id_C7D3 = 1.5;
  self._id_A25F = 1.06 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  self._id_AFAA["medic"]._id_C7BD = 0.75;
}

_id_FA09() {
  self._id_AFAA["medic"]._id_C7D3 = 1.0;
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  self._id_AFAA["medic"]._id_C7BD = 1.0;
}

_id_D307() {
  scripts\cp\utility::_id_6FC2("specialty_longersprint");
  thread _id_9CFF(65536.0);
  self._id_AFAA["medic"]._id_C7D3 = 1.5;
  self._id_A25F = 1.06 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  self._id_AFAA["medic"]._id_C7BD = 0.75;
}

_id_FA0A() {
  scripts\cp\utility::_unsetperk("specialty_longersprint");
  self notify("end_medic_health_regen");
  self._id_AFAA["medic"]._id_C7D3 = 1.0;
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  self._id_AFAA["medic"]._id_C7BD = 1.0;
}

_id_D308() {
  self._id_AFAA["medic"]._id_6158 = 0.0;
  scripts\cp\utility::_id_6FC2("specialty_longersprint");
  thread _id_9CFF(65536.0);
  self._id_AFAA["medic"]._id_C7D3 = 1.5;
  self._id_A25F = 1.06 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  self._id_AFAA["medic"]._id_C7BD = 0.75;
}

_id_FA0B() {
  self._id_AFAA["medic"]._id_6158 = 1.0;
  scripts\cp\utility::_unsetperk("specialty_longersprint");
  self notify("end_medic_health_regen");
  self._id_AFAA["medic"]._id_C7D3 = 1.0;
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  self._id_AFAA["medic"]._id_C7BD = 1.0;
}

_id_D309() {
  self._id_AFAA["medic"]._id_C7D3 = 1.5;
  self._id_AFAA["medic"]._id_6158 = 0.0;
  thread _id_9CFF(0.0);
  self._id_A25F = 1.12 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  scripts\cp\utility::_id_6FC2("specialty_longersprint");
  scripts\cp\utility::_id_6FC2("specialty_fastsprintrecovery");
  scripts\cp\utility::_id_6FC2("specialty_reducedsway");
  scripts\cp\utility::_id_6FC2("specialty_bulletpenetration");
  self._id_AFAA["medic"]._id_C7BD = 0.75;
}

_id_FA0C() {
  self._id_AFAA["medic"]._id_C7D3 = 1.0;
  self._id_AFAA["medic"]._id_6158 = 1.0;
  self notify("end_medic_health_regen");
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["medic"]._id_A200 = self._id_A25F;
  scripts\cp\utility::_unsetperk("specialty_longersprint");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  scripts\cp\utility::_unsetperk("specialty_reducedsway");
  scripts\cp\utility::_unsetperk("specialty_bulletpenetration");
  self._id_AFAA["medic"]._id_C7BD = 1.0;
}

_id_9CFF(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  var_1 = var_0 > 0.0;

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var_3._id_9D01)) {
        if(var_1 && distancesquared(self.origin, var_3.origin) > var_0) {
          continue;
        }
        var_3 thread _id_9D00();
      }
    }

    wait 1.0;
  }
}

_id_9D00() {
  self endon("death");
  self endon("disconnect");

  if(!_id_74F3()) {
    self._id_9D01 = 1;
    wait 1.0;
    self.health = int(min(self.maxhealth, self.health + 5.0));
    self._id_9D01 = undefined;
  }
}

_id_8048() {
  var_0 = spawnStruct();
  var_0._id_4F4D = 1.0;
  var_0._id_4F4E = 1.0;
  var_0._id_F4AF = 1;
  var_0._id_F4B7 = 1;
  var_0._id_F4B0 = 1;
  var_0._id_414C = 1.0;
  var_0._id_C543 = 1.0;
  return var_0;
}

_id_D321() {
  self._id_AFAA["rigger"]._id_4F4D = 1.256;
  self._id_AFAA["rigger"]._id_414C = 1.2;
}

_id_FA22() {
  self._id_AFAA["rigger"]._id_4F4D = 1.0;
  self._id_AFAA["rigger"]._id_414C = 1.0;
}

_id_D322() {
  self._id_AFAA["rigger"]._id_4F4D = 1.256;
  self._id_AFAA["rigger"]._id_414C = 1.2;
  self._id_AFAA["rigger"]._id_4F4E = 0.5;
}

_id_FA23() {
  self._id_AFAA["rigger"]._id_4F4D = 1.0;
  self._id_AFAA["rigger"]._id_4F4E = 1.0;
  self._id_AFAA["rigger"]._id_414C = 1.0;
}

_id_D323() {
  self._id_AFAA["rigger"]._id_4F4D = 1.256;
  self._id_AFAA["rigger"]._id_414C = 1.2;
  self._id_AFAA["rigger"]._id_4F4E = 0.5;
  self._id_AFAA["rigger"]._id_F4AF = 0.8;
}

_id_FA24() {
  self._id_AFAA["rigger"]._id_4F4D = 1.0;
  self._id_AFAA["rigger"]._id_4F4E = 1;
  self._id_AFAA["rigger"]._id_F4AF = 1.0;
  self._id_AFAA["rigger"]._id_414C = 1.0;
}

_id_D324() {
  self._id_AFAA["rigger"]._id_4F4D = 1.256;
  self._id_AFAA["rigger"]._id_414C = 1.2;
  self._id_AFAA["rigger"]._id_4F4E = 0.5;
  self._id_AFAA["rigger"]._id_F4AF = 0.8;
  self._id_AFAA["rigger"]._id_F4B7 = 1.5;
  self._id_AFAA["rigger"]._id_C543 = 0.75;
}

_id_FA25() {
  self._id_AFAA["rigger"]._id_4F4D = 1.0;
  self._id_AFAA["rigger"]._id_4F4E = 1;
  self._id_AFAA["rigger"]._id_F4AF = 1.0;
  self._id_AFAA["rigger"]._id_F4B7 = 1;
  self._id_AFAA["rigger"]._id_414C = 1.0;
  self._id_AFAA["rigger"]._id_C543 = 1.0;
}

_id_D325() {
  self._id_AFAA["rigger"]._id_4F4D = 1.256;
  self._id_AFAA["rigger"]._id_414C = 1.2;
  self._id_AFAA["rigger"]._id_4F4E = 0.5;
  self._id_AFAA["rigger"]._id_F4AF = 0.8;
  self._id_AFAA["rigger"]._id_F4B7 = 1.5;
  self._id_AFAA["rigger"]._id_F4B0 = 2;
  self[[level._id_D28B]](8000 * _id_094A::_id_BBFA());
  self._id_AFAA["rigger"]._id_C543 = 0.75;
}

_id_FA26() {
  self._id_AFAA["rigger"]._id_4F4D = 1.0;
  self._id_AFAA["rigger"]._id_4F4E = 1;
  self._id_AFAA["rigger"]._id_F4AF = 1.0;
  self._id_AFAA["rigger"]._id_F4B7 = 1;
  self._id_AFAA["rigger"]._id_F4B0 = 1;
  self._id_AFAA["rigger"]._id_414C = 1.0;
  self[[level._id_D28B]](6000 * _id_094A::_id_BBFA());
  self._id_AFAA["rigger"]._id_C543 = 1.0;
}

_id_8049() {
  var_0 = spawnStruct();
  var_0._id_1B3E = 0;
  var_0._id_1B3C = 0;
  return var_0;
}

_id_D326() {
  self._id_AFAA["robotics"]._id_1B37 = 25;
  self._id_AFAA["robotics"]._id_1B38 = 1;
}

_id_FA27() {
  self._id_AFAA["robotics"]._id_1B37 = 0;
  self._id_AFAA["robotics"]._id_1B38 = 0;
}

_id_D327() {
  self._id_AFAA["robotics"]._id_1B37 = 50;
  self._id_AFAA["robotics"]._id_1B38 = 2;
}

_id_FA28() {
  self._id_AFAA["robotics"]._id_1B37 = 0;
  self._id_AFAA["robotics"]._id_1B38 = 0;
}

_id_D328() {
  self._id_AFAA["robotics"]._id_1B37 = 75;
  self._id_AFAA["robotics"]._id_1B38 = 3;
}

_id_FA29() {
  self._id_AFAA["robotics"]._id_1B37 = 0;
  self._id_AFAA["robotics"]._id_1B38 = 0;
}

_id_D329() {
  self._id_AFAA["robotics"]._id_1B37 = 100;
  self._id_AFAA["robotics"]._id_1B38 = 4;
}

_id_FA2A() {
  self._id_AFAA["robotics"]._id_1B37 = 0;
  self._id_AFAA["robotics"]._id_1B38 = 0;
}

_id_D32A() {
  self._id_AFAA["robotics"]._id_1B37 = 125;
  self._id_AFAA["robotics"]._id_1B38 = 5;
}

_id_FA2B() {
  self._id_AFAA["robotics"]._id_1B37 = 0;
  self._id_AFAA["robotics"]._id_1B38 = 0;
}

_id_803F() {
  var_0 = spawnStruct();
  var_0._id_57E2 = 1.0;
  var_0._id_A943 = 0;
  var_0._id_90F2 = 0;
  return var_0;
}

_id_D2F1() {
  self._id_AFAA["demolition"]._id_57E2 = 1.1;
  self._id_AFAA["demolition"]._id_A943 = 2;
  self._id_AFAA["demolition"]._id_90F2 = 4;
}

_id_F9F4() {
  self._id_AFAA["demolition"]._id_57E2 = 1.0;
  self._id_AFAA["demolition"]._id_A943 = 0;
  self._id_AFAA["demolition"]._id_90F2 = 0;
}

_id_D2F2() {
  self._id_AFAA["demolition"]._id_57E2 = 1.2;
  self._id_AFAA["demolition"]._id_A943 = 3;
  self._id_AFAA["demolition"]._id_90F2 = 6;
}

_id_F9F5() {
  self._id_AFAA["demolition"]._id_57E2 = 1.0;
  self._id_AFAA["demolition"]._id_A943 = 0;
  self._id_AFAA["demolition"]._id_90F2 = 0;
}

_id_D2F3() {
  self._id_AFAA["demolition"]._id_57E2 = 1.3;
  self._id_AFAA["demolition"]._id_A943 = 4;
  self._id_AFAA["demolition"]._id_90F2 = 8;
}

_id_F9F6() {
  self._id_AFAA["demolition"]._id_57E2 = 1.0;
  self._id_AFAA["demolition"]._id_A943 = 0;
  self._id_AFAA["demolition"]._id_90F2 = 0;
}

_id_D2F4() {
  self._id_AFAA["demolition"]._id_57E2 = 1.4;
  self._id_AFAA["demolition"]._id_A943 = 4;
  self._id_AFAA["demolition"]._id_90F2 = 10;
}

_id_F9F7() {
  self._id_AFAA["demolition"]._id_57E2 = 1.0;
  self._id_AFAA["demolition"]._id_A943 = 0;
  self._id_AFAA["demolition"]._id_90F2 = 0;
}

_id_D2F5() {
  self._id_AFAA["demolition"]._id_57E2 = 1.5;
  self._id_AFAA["demolition"]._id_A943 = 5;
  self._id_AFAA["demolition"]._id_90F2 = 12;
}

_id_F9F8() {
  self._id_AFAA["demolition"]._id_57E2 = 1.0;
  self._id_AFAA["demolition"]._id_A943 = 0;
  self._id_AFAA["demolition"]._id_90F2 = 0;
}

_id_C190() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  var_0 = 5;

  for(;;) {
    var_1 = self _meth_8109(makeweapon("aliensemtex_mp"));

    if(var_1 == 0) {
      for(var_2 = 1; var_2 <= _id_0947::_id_AFBC(); var_2++) {
        self _meth_835D("other");
        scripts\cp\utility::_id_5A41(makeweapon("aliensemtex_mp"), 1);
        wait(var_0);
      }
    }

    wait(var_0);
  }
}

_id_8040() {
  var_0 = spawnStruct();
  var_0._id_731F = 1.0;
  return var_0;
}

_id_D2F6() {
  scripts\cp\utility::_id_6FC2("specialty_marathon");
  scripts\cp\utility::_id_6FC2("specialty_fastsprintrecovery");
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
  self _meth_82D3(0.5);
  self._id_AFAA["damagemod"]._id_2D25 = 1.5;
}

_id_F9F9() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self _meth_82D3(1.0);
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
}

_id_D2F7() {
  scripts\cp\utility::_id_6FC2("specialty_marathon");
  scripts\cp\utility::_id_6FC2("specialty_fastsprintrecovery");
  self._id_A25F = 1.1 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
  self _meth_82D3(0.5);
  self._id_AFAA["damagemod"]._id_2D25 = 1.5;
}

_id_F9FA() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self _meth_82D3(1.0);
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
}

_id_D2F8() {
  scripts\cp\utility::_id_6FC2("specialty_marathon");
  scripts\cp\utility::_id_6FC2("specialty_fastsprintrecovery");
  self._id_A25F = 1.15 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
  self _meth_82D3(0.5);
  self._id_AFAA["damagemod"]._id_2D25 = 1.5;
}

_id_F9FB() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self _meth_82D3(1.0);
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
}

_id_D2F9() {
  scripts\cp\utility::_id_6FC2("specialty_marathon");
  scripts\cp\utility::_id_6FC2("specialty_fastsprintrecovery");
  self._id_A25F = 1.2 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
  self _meth_82D3(0.5);
  self._id_AFAA["damagemod"]._id_2D25 = 1.5;
}

_id_F9FC() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self _meth_82D3(1.0);
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
}

_id_D2FA() {
  scripts\cp\utility::_id_6FC2("specialty_marathon");
  scripts\cp\utility::_id_6FC2("specialty_fastsprintrecovery");
  self._id_A25F = 1.25 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_id_6FC2("specialty_fastreload");
  self _meth_82D3(0.0);
  self._id_AFAA["damagemod"]._id_2D25 = 1.5;
}

_id_F9FD() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
  self._id_AFAA["gunslinger"]._id_731F = self._id_A25F;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self _meth_82D3(1.0);
  self._id_AFAA["damagemod"]._id_2D25 = 1.0;
}

_id_D493() {
  level._id_2357 = loadfx("vfx/core/mp/core/vfx_battle_slide_camera");
  thread _id_238E();
}

_id_FA58() {
  self notify("battleSlide_unset");
  _id_2387();
}

_id_238E() {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");

  for(;;) {
    self waittill("sprint_slide_begin");
    _id_2384();
    self waittill("sprint_slide_end");
    _id_2387();
  }

  self notify("battleSlide_unset");
  self._id_2394 = undefined;
}

_id_2384() {
  self._id_2383 = 1;
  self._id_2394 = [];
  thread _id_2391();
  thread _id_238F();
}

_id_2387() {
  self._id_2383 = undefined;
  self._id_2394 = undefined;
}

_id_238F() {
  self endon("death");
  self endon("disconnect");
  self endon("sprint_slide_end");
  self endon("battleSlide_unset");

  for(;;) {
    var_0 = self getvelocity();
    var_1 = _func_0135(var_0);
    var_2 = anglestoup(self.angles);
    var_3 = anglesToForward(self.angles);
    var_4 = (0, 0, 0);
    var_5 = (0, 0, 0);
    var_6 = scripts\engine\trace::_id_3EE5(0, 1, 1, 0, 1, 0);

    if(var_1 > 100) {
      var_7 = vectortoangles(var_0);
      var_3 = anglesToForward(var_7);
      var_2 = anglestoup(var_7);
      var_4 = var_3 * 40;
      var_5 = var_2 * 28.0;
      var_8 = _func_02C1(self getEye(), self.origin + var_4 + var_5, var_6, undefined, 0, "physicsquery_closest");

      if(isDefined(var_8) && var_8.size > 0) {
        var_4 = var_3 * vectordot(var_8[0]["position"] - self.origin, var_3);
        var_4 = var_4 - var_3 * 3;
      }
    }

    var_9 = level._id_E2A4;

    foreach(var_11 in var_9) {
      if(!isDefined(var_11) || var_11 == self || !var_11 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(isDefined(var_11._id_1210) && (var_11._id_1210 == "zombie_brute" || var_11._id_1210 == "zombie_grey")) {
        continue;
      }
      if(_id_238C(var_11)) {
        continue;
      }
      if(!scripts\engine\math::_id_B9C3(var_11 gettagorigin("j_mainroot"), 2304, 56, self.origin + var_4, var_2)) {
        continue;
      }
      if(_id_238A(var_11, var_3)) {
        continue;
      }
      if(_id_2389(var_11, self.origin + var_4 + var_5, var_6)) {
        continue;
      }
      _id_2393(var_11);
      _id_2385(var_11);
      _id_238D(var_11, var_3);
    }

    waitframe();
  }
}

_id_2393(var_0) {
  if(!isDefined(self._id_2394)) {
    self._id_2394 = [];
  }

  if(!_id_238C(var_0)) {
    self._id_2394[self._id_2394.size] = var_0 getentitynumber();
    return 1;
  }

  return 0;
}

_id_2385(var_0) {
  var_1 = int(min(var_0.maxhealth, 1000));

  if(var_1 >= self.health) {
    self._id_426B = 1;
    thread _id_2390(var_0);
  }

  var_0 dodamage(var_1, self.origin, self, self, "MOD_EXPLOSIVE", "battleslide_mp");
  thread _id_2386(var_0);
}

_id_238D(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = length(var_2);

  if(var_3 != 0) {
    var_4 = var_2 / var_3;
    var_5 = var_0 getvelocity();
    var_5 = var_5 - var_4 * vectordot(var_5, var_4);
    var_5 = var_5 + var_4 * 800;
    var_5 = var_5 + (0, 0, 175);
    var_0 setvelocity(var_5);
    var_0 shellshock("battleslide_mp", 1.5);
  }
}

_id_238A(var_0, var_1) {
  return vectordot(var_1, var_0.origin - self.origin) < 0;
}

_id_2389(var_0, var_1, var_2) {
  var_3 = _func_02C1(var_1, var_0 gettagorigin("j_mainroot"), var_2, undefined, 0, "physicsquery_closest");

  if(isDefined(var_3) && var_3.size > 0) {
    return 1;
  }

  return 0;
}

_id_238B(var_0, var_1) {
  if(isDefined(var_0._id_75A5) && var_0._id_75A5) {
    var_2 = var_1 - var_0.origin;
    var_3 = vectornormalize((var_2[0], var_2[1], 0));
    var_4 = anglesToForward(var_0.angles);
    var_5 = vectordot(var_4, var_2);

    if(var_0._id_75A6) {
      if(var_5 > 0.766) {
        return 1;
      }
    } else if(var_5 < -0.766)
      return 1;
  }

  return 0;
}

_id_238C(var_0) {
  if(!isDefined(self._id_2394)) {
    return 0;
  }

  var_1 = var_0 getentitynumber();
  return scripts\engine\utility::array_contains(self._id_2394, var_1);
}

_id_2388(var_0) {
  return isDefined(var_0._id_2388);
}

_id_2386(var_0) {
  self playrumbleonentity("artillery_rumble");
  var_0 playrumbleonentity("artillery_rumble");
  playrumbleonposition("slide_collision", self.origin);
  earthquake(0.5, 0.5, self.origin, 96);
  playsoundatpos(self.origin, "slide_impact");
  self setclientomnvar("ui_hud_shake", 1);
  _id_071B::_id_FC47("standard");
}

_id_2391() {
  self endon("death");
  self endon("disconnect");
  self endon("sprint_slide_end");
  self playlocalsound("melee_boost");
  self _meth_827E("melee_boost_npc");
  var_0 = 0;
  var_1 = 5;

  while(var_1 > var_0) {
    var_2 = _func_020D(level._id_2357, self getEye(), self);
    thread _id_2392(var_2, 0.1);
    triggerfx(var_2);
    earthquake(0.2, 0.25, self.origin, 96);
    self playrumbleonentity("slide_loop");
    var_0++;
    waitframe();
  }
}

_id_2392(var_0, var_1) {
  wait(var_1);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_2390(var_0) {
  var_0 endon("disconnect");
  var_1 = self.origin;
  self waittill("start_instant_ragdoll");
  wait 0.1;
  physicsexplosionsphere(var_1, 68, 48, 2.5);
}

_id_8042() {
  var_0 = spawnStruct();
  return var_0;
}

_id_D300() {
  self._id_A25F = 1.1 * _id_094A::_id_BBF3();
}

_id_FA03() {
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
}

_id_D301() {
  self._id_A25F = 1.1 * _id_094A::_id_BBF3();
}

_id_FA04() {
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
}

_id_D302() {
  self._id_A25F = 1.15 * _id_094A::_id_BBF3();
}

_id_FA05() {
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
}

_id_D303() {
  self._id_A25F = 1.2 * _id_094A::_id_BBF3();
}

_id_FA06() {
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
}

_id_D304() {
  self._id_A25F = 1.25 * _id_094A::_id_BBF3();
}

_id_FA07() {
  self._id_A25F = 1.0 * _id_094A::_id_BBF3();
}

_id_4E96() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");

  for(;;) {
    if(!self isonground() && self jumpbuttonpressed()) {
      wait 0.2;
      earthquake(0.25, 0.75, self.origin + (0, 0, 60), 100);

      while(self jumpbuttonpressed() && !self isonground()) {
        wait 0.05;
      }
    }

    wait 0.05;
  }
}

_id_8047() {
  var_0 = spawnStruct();
  var_0._id_B123 = 0;
  var_0._id_B128 = 0;
  return var_0;
}

_id_3462(var_0, var_1) {
  self._id_90C6 = self._id_0133;
  self._id_B10E = self getweaponammoclip(var_1, "right");
  self._id_B10B = self getweaponammostock(var_1);
}

_id_6F17(var_0) {
  var_1 = var_0;
  scripts\cp\utility::_giveweapon(var_1);
  self setweaponammoclip(var_1, self._id_B10E, "right");
  self setweaponammostock(var_1, self._id_B10B);

  if(!self hasweapon(self._id_90C6) && !scripts\cp\utility::_id_7521() && !scripts\cp\utility::_id_85F4()) {
    self switchtoweapon(var_1);
  }
}

_id_D31C() {}

_id_FA1D() {
  _id_E9B1("iw6_p226_mp");
}

_id_D31D() {
  _id_6F17("iw6_p226_mp_barrelrange02");
}

_id_FA1E() {
  _id_E9B1("iw6_p226_mp");
}

_id_D31E() {
  _id_6F17("iw6_p226_mp_barrelrange02_xmags");
}

_id_FA1F() {
  _id_E9B1("iw6_p226_mp");
}

_id_D31F() {
  _id_6F17("iw6_p226_mp_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA20() {
  _id_E9B1("iw6_p226_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_D320() {
  _id_6F17("iw6_p226_mp_akimbo_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA21() {
  _id_E9B1("iw6_p226_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_D30D() {}

_id_FA0E() {
  _id_E9B1("iw6_magnum_mp");
}

_id_D30E() {
  _id_6F17("iw6_magnum_mp_barrelrange02");
}

_id_FA0F() {
  _id_E9B1("iw6_magnum_mp");
}

_id_D30F() {
  _id_6F17("iw6_magnum_mp_barrelrange02_xmags");
}

_id_FA10() {
  _id_E9B1("iw6_magnum_mp");
}

_id_D310() {
  _id_6F17("iw6_magnum_mp_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA11() {
  _id_E9B1("iw6_magnum_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_D311() {
  _id_6F17("iw6_magnum_mp_akimbo_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA12() {
  _id_E9B1("iw6_alienmagnum_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_D317() {}

_id_FA18() {
  _id_E9B1("iw6_m9a1_mp");
}

_id_D318() {
  _id_6F17("iw6_m9a1_mp_barrelrange02");
}

_id_FA19() {
  _id_E9B1("iw6_m9a1_mp");
}

_id_D319() {
  _id_6F17("iw6_m9a1_mp_barrelrange02_xmags");
}

_id_FA1A() {
  _id_E9B1("iw6_m9a1_mp");
}

_id_D31A() {
  _id_6F17("iw6_m9a1_mp_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA1B() {
  _id_E9B1("iw6_m9a1_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_D31B() {
  _id_6F17("iw6_m9a1_mp_akimbo_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA1C() {
  _id_E9B1("iw6_m9a1_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_E9B1(var_0) {
  var_1 = _id_6428();
  _id_3462(var_0, var_1);
  self takeweapon(var_1);
}

_id_D312() {}

_id_FA13() {
  _id_E9B1("iw6_mp443_mp");
}

_id_D313() {
  _id_6F17("iw6_mp443_mp_barrelrange02");
}

_id_FA14() {
  _id_E9B1("iw6_mp443_mp");
}

_id_D314() {
  _id_6F17("iw6_mp443_mp_barrelrange02_xmags");
}

_id_FA15() {
  _id_E9B1("iw6_mp443_mp");
}

_id_D315() {
  _id_6F17("iw6_mp443_mp_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA16() {
  _id_E9B1("iw6_mp443_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_D316() {
  _id_6F17("iw6_mp443_mp_akimbo_barrelrange02_xmags");
  self._id_AFAA["pistol"]._id_B123 = 1;
}

_id_FA17() {
  _id_E9B1("iw6_mp443_mp");
  self._id_AFAA["pistol"]._id_B123 = 0;
}

_id_10AB2() {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self._id_B133 = 1.0;
  self._id_145B = 1.0;
  self._id_145A = 0;
  self._id_3AC4 = _id_697E();
  self[[level._id_A201]]();

  for(;;) {
    self waittill("weapon_change", var_0);
    var_1 = self getcurrentweapon();
    var_2 = scripts\cp\utility::_id_6CE3(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "nrg" || var_2 == "zmagnum" || var_2 == "zg18" || var_2 == "emc") {
        self._id_B133 = 1.1;
      } else {
        self._id_B133 = 1.0;
      }

      wait 0.05;
      _id_FC38();
    }

    wait 0.05;
  }
}

_id_FC38() {
  self._id_3AC4 = _id_697E();
  self[[level._id_A201]]();
}

_id_697E() {
  return self._id_B133 * self._id_145B;
}

_id_10AEB() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0)) {
      if(var_0.basename == "iw5_alienriotshield4_mp_camo05" && self._id_5B8E == 1.0) {
        playFXOnTag(level._effect["riotshield_fire"], self, "tag_origin");
        continue;
      }

      stopFXOnTag(level._effect["riotshield_fire"], self, "tag_origin");
    }
  }

  wait 0.05;
}

_id_74F3() {
  if(_id_094A::_id_BBF8() != 1.0 && self issprinting()) {
    return 1;
  } else {
    return 0;
  }
}

_id_6428() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = var_2.classname;

    if(var_3 == "weapon_pistol") {
      return var_2;
    }
  }
}

_id_19ED(var_0) {
  if(isDefined(self._id_EAAF)) {
    return self._id_EAAF * var_0;
  } else {
    return var_0;
  }
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3325.gsc
**************************************/

_id_96C9() {
  var_0 = spawnStruct();
  return var_0;
}

_id_F4EC() {}

_id_12C30() {}

_id_96C2() {
  var_0 = spawnStruct();
  var_0.melee_scalar = 1.0;
  return var_0;
}

_id_F4DD() {
  self.perk_data["health"].max_health = 125;
  self.perk_data["health"].melee_scalar = 1.0;
}

_id_12C21() {
  self.perk_data["health"].melee_scalar = 1.0;
}

_id_F4DE() {
  self.perk_data["health"].max_health = 125;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = 1.25;
}

_id_12C22() {
  self.perk_data["health"].melee_scalar = 1.0;
}

_id_F4DF() {
  self.perk_data["health"].max_health = 150;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = 1.25;
}

_id_12C23() {
  self.perk_data["health"].melee_scalar = 1.0;
}

_id_F4E0() {
  self.perk_data["health"].max_health = 175;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = 1.5;
}

_id_12C24() {
  self.perk_data["health"].melee_scalar = 1.0;
}

_id_F4E1() {
  self.perk_data["health"].max_health = 200;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = 2.0;
}

_id_12C25() {
  self.perk_data["health"].melee_scalar = 1.0;
}

_id_96BF() {
  var_0 = spawnStruct();
  var_0.bullet_damage_scalar = 1.0;
  return var_0;
}

_id_F4CE() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
}

_id_12C12() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
}

_id_F4CF() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
}

_id_12C13() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
}

_id_F4D0() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_quickdraw");
}

_id_12C14() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
}

_id_F4D1() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_quickdraw");
  scripts\cp\utility::giveperk("specialty_fastreload");
}

_id_12C15() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
  scripts\cp\utility::giveperk("specialty_fastreload");
}

_id_F4D2() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_quickdraw");
  self setaimspreadmovementscale(0.5);
  scripts\cp\utility::giveperk("specialty_fastreload");
}

_id_12C16() {
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
  self setaimspreadmovementscale(1.0);
  scripts\cp\utility::_unsetperk("specialty_fastreload");
}

_id_96C8() {
  var_0 = spawnStruct();
  var_0.revive_time_scalar = 1.0;
  var_0._id_76AC = 1.0;
  var_0._id_BC6F = 1.0;
  var_0._id_E496 = 1.0;
  return var_0;
}

_id_F4E7() {
  self.perk_data["medic"].revive_time_scalar = 1.5;
  self.movespeedscaler = scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
}

_id_12C2B() {
  self.perk_data["medic"].revive_time_scalar = 1.0;
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
}

_id_F4E8() {
  self.perk_data["medic"].revive_time_scalar = 1.5;
  self.movespeedscaler = 1.06 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  self.perk_data["medic"]._id_E496 = 0.75;
}

_id_12C2C() {
  self.perk_data["medic"].revive_time_scalar = 1.0;
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  self.perk_data["medic"]._id_E496 = 1.0;
}

_id_F4E9() {
  scripts\cp\utility::giveperk("specialty_longersprint");
  thread _id_B526(65536.0);
  self.perk_data["medic"].revive_time_scalar = 1.5;
  self.movespeedscaler = 1.06 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  self.perk_data["medic"]._id_E496 = 0.75;
}

_id_12C2D() {
  scripts\cp\utility::_unsetperk("specialty_longersprint");
  self notify("end_medic_health_regen");
  self.perk_data["medic"].revive_time_scalar = 1.0;
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  self.perk_data["medic"]._id_E496 = 1.0;
}

_id_F4EA() {
  self.perk_data["medic"]._id_76AC = 0.0;
  scripts\cp\utility::giveperk("specialty_longersprint");
  thread _id_B526(65536.0);
  self.perk_data["medic"].revive_time_scalar = 1.5;
  self.movespeedscaler = 1.06 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  self.perk_data["medic"]._id_E496 = 0.75;
}

_id_12C2E() {
  self.perk_data["medic"]._id_76AC = 1.0;
  scripts\cp\utility::_unsetperk("specialty_longersprint");
  self notify("end_medic_health_regen");
  self.perk_data["medic"].revive_time_scalar = 1.0;
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  self.perk_data["medic"]._id_E496 = 1.0;
}

_id_F4EB() {
  self.perk_data["medic"].revive_time_scalar = 1.5;
  self.perk_data["medic"]._id_76AC = 0.0;
  thread _id_B526(0.0);
  self.movespeedscaler = 1.12 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  scripts\cp\utility::giveperk("specialty_longersprint");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\cp\utility::giveperk("specialty_reducedsway");
  scripts\cp\utility::giveperk("specialty_bulletpenetration");
  self.perk_data["medic"]._id_E496 = 0.75;
}

_id_12C2F() {
  self.perk_data["medic"].revive_time_scalar = 1.0;
  self.perk_data["medic"]._id_76AC = 1.0;
  self notify("end_medic_health_regen");
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["medic"]._id_BC6F = self.movespeedscaler;
  scripts\cp\utility::_unsetperk("specialty_longersprint");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  scripts\cp\utility::_unsetperk("specialty_reducedsway");
  scripts\cp\utility::_unsetperk("specialty_bulletpenetration");
  self.perk_data["medic"]._id_E496 = 1.0;
}

_id_B526(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  var_1 = var_0 > 0.0;

  for(;;) {
    foreach(var_3 in level.players) {
      if(scripts\cp\utility::isreallyalive(var_3) && !isDefined(var_3._id_B528)) {
        if(var_1 && distancesquared(self.origin, var_3.origin) > var_0) {
          continue;
        }
        var_3 thread _id_B527();
      }
    }

    wait 1.0;
  }
}

_id_B527() {
  self endon("death");
  self endon("disconnect");

  if(!has_fragile_relic_and_is_sprinting()) {
    self._id_B528 = 1;
    wait 1.0;
    self.health = int(min(self.maxhealth, self.health + 5.0));
    self._id_B528 = undefined;
  }
}

_id_96CB() {
  var_0 = spawnStruct();
  var_0._id_5B99 = 1.0;
  var_0._id_5BB8 = 1.0;
  var_0._id_1269D = 1;
  var_0._id_1269F = 1;
  var_0._id_1269E = 1;
  var_0._id_4B35 = 1.0;
  var_0._id_E18F = 1.0;
  return var_0;
}

_id_F510() {
  self.perk_data["rigger"]._id_5B99 = 1.256;
  self.perk_data["rigger"]._id_4B35 = 1.2;
}

_id_12C54() {
  self.perk_data["rigger"]._id_5B99 = 1.0;
  self.perk_data["rigger"]._id_4B35 = 1.0;
}

_id_F511() {
  self.perk_data["rigger"]._id_5B99 = 1.256;
  self.perk_data["rigger"]._id_4B35 = 1.2;
  self.perk_data["rigger"]._id_5BB8 = 0.5;
}

_id_12C55() {
  self.perk_data["rigger"]._id_5B99 = 1.0;
  self.perk_data["rigger"]._id_5BB8 = 1.0;
  self.perk_data["rigger"]._id_4B35 = 1.0;
}

_id_F512() {
  self.perk_data["rigger"]._id_5B99 = 1.256;
  self.perk_data["rigger"]._id_4B35 = 1.2;
  self.perk_data["rigger"]._id_5BB8 = 0.5;
  self.perk_data["rigger"]._id_1269D = 0.8;
}

_id_12C56() {
  self.perk_data["rigger"]._id_5B99 = 1.0;
  self.perk_data["rigger"]._id_5BB8 = 1;
  self.perk_data["rigger"]._id_1269D = 1.0;
  self.perk_data["rigger"]._id_4B35 = 1.0;
}

_id_F513() {
  self.perk_data["rigger"]._id_5B99 = 1.256;
  self.perk_data["rigger"]._id_4B35 = 1.2;
  self.perk_data["rigger"]._id_5BB8 = 0.5;
  self.perk_data["rigger"]._id_1269D = 0.8;
  self.perk_data["rigger"]._id_1269F = 1.5;
  self.perk_data["rigger"]._id_E18F = 0.75;
}

_id_12C57() {
  self.perk_data["rigger"]._id_5B99 = 1.0;
  self.perk_data["rigger"]._id_5BB8 = 1;
  self.perk_data["rigger"]._id_1269D = 1.0;
  self.perk_data["rigger"]._id_1269F = 1;
  self.perk_data["rigger"]._id_4B35 = 1.0;
  self.perk_data["rigger"]._id_E18F = 1.0;
}

_id_F514() {
  self.perk_data["rigger"]._id_5B99 = 1.256;
  self.perk_data["rigger"]._id_4B35 = 1.2;
  self.perk_data["rigger"]._id_5BB8 = 0.5;
  self.perk_data["rigger"]._id_1269D = 0.8;
  self.perk_data["rigger"]._id_1269F = 1.5;
  self.perk_data["rigger"]._id_1269E = 2;
  self[[level._id_F480]](8000 * scripts\cp\perks\prestige::prestige_getwalletsizescalar());
  self.perk_data["rigger"]._id_E18F = 0.75;
}

_id_12C58() {
  self.perk_data["rigger"]._id_5B99 = 1.0;
  self.perk_data["rigger"]._id_5BB8 = 1;
  self.perk_data["rigger"]._id_1269D = 1.0;
  self.perk_data["rigger"]._id_1269F = 1;
  self.perk_data["rigger"]._id_1269E = 1;
  self.perk_data["rigger"]._id_4B35 = 1.0;
  self[[level._id_F480]](6000 * scripts\cp\perks\prestige::prestige_getwalletsizescalar());
  self.perk_data["rigger"]._id_E18F = 1.0;
}

_id_96CC() {
  var_0 = spawnStruct();
  var_0._id_2183 = 0;
  var_0._id_2182 = 0;
  return var_0;
}

_id_F515() {
  self.perk_data["robotics"]._id_2180 = 25;
  self.perk_data["robotics"]._id_2181 = 1;
}

_id_12C59() {
  self.perk_data["robotics"]._id_2180 = 0;
  self.perk_data["robotics"]._id_2181 = 0;
}

_id_F516() {
  self.perk_data["robotics"]._id_2180 = 50;
  self.perk_data["robotics"]._id_2181 = 2;
}

_id_12C5A() {
  self.perk_data["robotics"]._id_2180 = 0;
  self.perk_data["robotics"]._id_2181 = 0;
}

_id_F517() {
  self.perk_data["robotics"]._id_2180 = 75;
  self.perk_data["robotics"]._id_2181 = 3;
}

_id_12C5B() {
  self.perk_data["robotics"]._id_2180 = 0;
  self.perk_data["robotics"]._id_2181 = 0;
}

_id_F518() {
  self.perk_data["robotics"]._id_2180 = 100;
  self.perk_data["robotics"]._id_2181 = 4;
}

_id_12C5C() {
  self.perk_data["robotics"]._id_2180 = 0;
  self.perk_data["robotics"]._id_2181 = 0;
}

_id_F519() {
  self.perk_data["robotics"]._id_2180 = 125;
  self.perk_data["robotics"]._id_2181 = 5;
}

_id_12C5D() {
  self.perk_data["robotics"]._id_2180 = 0;
  self.perk_data["robotics"]._id_2181 = 0;
}

_id_96C0() {
  var_0 = spawnStruct();
  var_0.explosive_damage_scalar = 1.0;
  var_0.offhand_count = 0;
  var_0._id_AAAA = 0;
  return var_0;
}

_id_F4D3() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.1;
  self.perk_data["demolition"].offhand_count = 2;
  self.perk_data["demolition"]._id_AAAA = 4;
}

_id_12C17() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.0;
  self.perk_data["demolition"].offhand_count = 0;
  self.perk_data["demolition"]._id_AAAA = 0;
}

_id_F4D4() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.2;
  self.perk_data["demolition"].offhand_count = 3;
  self.perk_data["demolition"]._id_AAAA = 6;
}

_id_12C18() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.0;
  self.perk_data["demolition"].offhand_count = 0;
  self.perk_data["demolition"]._id_AAAA = 0;
}

_id_F4D5() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.3;
  self.perk_data["demolition"].offhand_count = 4;
  self.perk_data["demolition"]._id_AAAA = 8;
}

_id_12C19() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.0;
  self.perk_data["demolition"].offhand_count = 0;
  self.perk_data["demolition"]._id_AAAA = 0;
}

_id_F4D6() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.4;
  self.perk_data["demolition"].offhand_count = 4;
  self.perk_data["demolition"]._id_AAAA = 10;
}

_id_12C1A() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.0;
  self.perk_data["demolition"].offhand_count = 0;
  self.perk_data["demolition"]._id_AAAA = 0;
}

_id_F4D7() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.5;
  self.perk_data["demolition"].offhand_count = 5;
  self.perk_data["demolition"]._id_AAAA = 12;
}

_id_12C1B() {
  self.perk_data["demolition"].explosive_damage_scalar = 1.0;
  self.perk_data["demolition"].offhand_count = 0;
  self.perk_data["demolition"]._id_AAAA = 0;
}

_id_DE49() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  var_0 = 5;

  for(;;) {
    var_1 = self getammocount("aliensemtex_mp");

    if(var_1 == 0) {
      for(var_2 = 1; var_2 <= scripts\cp\perks\perk_utility::perk_getoffhandcount(); var_2++) {
        self _meth_831C("other");
        scripts\cp\utility::filloffhandweapons("aliensemtex_mp", 1);
        wait(var_0);
      }
    }

    wait(var_0);
  }
}

_id_96C1() {
  var_0 = spawnStruct();
  var_0._id_8723 = 1.0;
  return var_0;
}

_id_F4D8() {
  scripts\cp\utility::giveperk("specialty_marathon");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\cp\utility::giveperk("specialty_fastreload");
  self setaimspreadmovementscale(0.5);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

_id_12C1C() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self setaimspreadmovementscale(1.0);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
}

_id_F4D9() {
  scripts\cp\utility::giveperk("specialty_marathon");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::giveperk("specialty_fastreload");
  self setaimspreadmovementscale(0.5);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

_id_12C1D() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self setaimspreadmovementscale(1.0);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
}

_id_F4DA() {
  scripts\cp\utility::giveperk("specialty_marathon");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.15 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::giveperk("specialty_fastreload");
  self setaimspreadmovementscale(0.5);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

_id_12C1E() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self setaimspreadmovementscale(1.0);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
}

_id_F4DB() {
  scripts\cp\utility::giveperk("specialty_marathon");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.2 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::giveperk("specialty_fastreload");
  self setaimspreadmovementscale(0.5);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

_id_12C1F() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self setaimspreadmovementscale(1.0);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
}

_id_F4DC() {
  scripts\cp\utility::giveperk("specialty_marathon");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.25 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::giveperk("specialty_fastreload");
  self setaimspreadmovementscale(0.0);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

_id_12C20() {
  scripts\cp\utility::_unsetperk("specialty_marathon");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
  self.perk_data["gunslinger"]._id_8723 = self.movespeedscaler;
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  self setaimspreadmovementscale(1.0);
  self.perk_data["damagemod"].bullet_damage_scalar = 1.0;
}

setbattleslide() {
  level._id_28C9 = loadfx("vfx/core/mp/core/vfx_battle_slide_camera");
  thread _id_28EC();
}

unsetbattleslide() {
  self notify("battleSlide_unset");
  _id_28E5();
}

_id_28EC() {
  self endon("death");
  self endon("disconnect");
  self endon("battleSlide_unset");

  for(;;) {
    self waittill("sprint_slide_begin");
    _id_28E2();
    self waittill("sprint_slide_end");
    _id_28E5();
  }

  self notify("battleSlide_unset");
  self._id_28F7 = undefined;
}

_id_28E2() {
  self._id_28E1 = 1;
  self._id_28F7 = [];
  thread _id_28F3();
  thread _id_28ED();
}

_id_28E5() {
  self._id_28E1 = undefined;
  self._id_28F7 = undefined;
}

_id_28ED() {
  self endon("death");
  self endon("disconnect");
  self endon("sprint_slide_end");
  self endon("battleSlide_unset");

  for(;;) {
    var_0 = self getvelocity();
    var_1 = lengthsquared(var_0);
    var_2 = anglestoup(self.angles);
    var_3 = anglesToForward(self.angles);
    var_4 = (0, 0, 0);
    var_5 = (0, 0, 0);
    var_6 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);

    if(var_1 > 100) {
      var_7 = vectortoangles(var_0);
      var_3 = anglesToForward(var_7);
      var_2 = anglestoup(var_7);
      var_4 = var_3 * 40;
      var_5 = var_2 * 28.0;
      var_8 = physics_raycast(self getEye(), self.origin + var_4 + var_5, var_6, undefined, 0, "physicsquery_closest");

      if(isDefined(var_8) && var_8.size > 0) {
        var_4 = var_3 * vectordot(var_8[0]["position"] - self.origin, var_3);
        var_4 = var_4 - var_3 * 3;
      }
    }

    var_9 = level.spawned_enemies;

    foreach(var_11 in var_9) {
      if(!isDefined(var_11) || var_11 == self || !scripts\cp\utility::isreallyalive(var_11)) {
        continue;
      }
      if(isDefined(var_11.agent_type) && (var_11.agent_type == "zombie_brute" || var_11.agent_type == "zombie_grey")) {
        continue;
      }
      if(_id_28EA(var_11)) {
        continue;
      }
      if(!_id_D64A(2304, 56, self.origin + var_4, var_2, var_11 gettagorigin("j_mainroot"))) {
        continue;
      }
      if(_id_28E8(var_11, var_3)) {
        continue;
      }
      if(_id_28E7(var_11, self.origin + var_4 + var_5, var_6)) {
        continue;
      }
      _id_28F5(var_11);
      _id_28E3(var_11);
      _id_28EB(var_11, var_3);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_28F5(var_0) {
  if(!isDefined(self._id_28F7))
    self._id_28F7 = [];

  if(!_id_28EA(var_0)) {
    self._id_28F7[self._id_28F7.size] = var_0 getentitynumber();
    return 1;
  }

  return 0;
}

_id_28E3(var_0) {
  var_1 = int(min(var_0.maxhealth, 1000));

  if(var_1 >= self.health) {
    self.customdeath = 1;
    thread _id_28F0(var_0);
  }

  var_0 dodamage(var_1, self.origin, self, self, "MOD_EXPLOSIVE", "battleslide_mp");
  thread _id_28E4(var_0);
}

_id_28EB(var_0, var_1) {
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

_id_28E8(var_0, var_1) {
  return vectordot(var_1, var_0.origin - self.origin) < 0;
}

_id_28E7(var_0, var_1, var_2) {
  var_3 = physics_raycast(var_1, var_0 gettagorigin("j_mainroot"), var_2, undefined, 0, "physicsquery_closest");

  if(isDefined(var_3) && var_3.size > 0)
    return 1;

  return 0;
}

_id_28E9(var_0, var_1) {
  if(isDefined(var_0.hasriotshield) && var_0.hasriotshield) {
    var_2 = var_1 - var_0.origin;
    var_3 = vectorNormalize((var_2[0], var_2[1], 0));
    var_4 = anglesToForward(var_0.angles);
    var_5 = vectordot(var_4, var_2);

    if(var_0.hasriotshieldequipped) {
      if(var_5 > 0.766)
        return 1;
    } else if(var_5 < -0.766)
      return 1;
  }

  return 0;
}

_id_28EA(var_0) {
  if(!isDefined(self._id_28F7))
    return 0;

  var_1 = var_0 getentitynumber();
  return scripts\engine\utility::array_contains(self._id_28F7, var_1);
}

_id_28E6(var_0) {
  return isDefined(var_0._id_28E6);
}

_id_28E4(var_0) {
  self playRumbleOnEntity("artillery_rumble");
  var_0 playRumbleOnEntity("artillery_rumble");
  playrumbleonposition("slide_collision", self.origin);
  earthquake(0.5, 0.5, self.origin, 96);
  playsoundatpos(self.origin, "slide_impact");
  self setclientomnvar("ui_hud_shake", 1);
  scripts\cp\cp_damage::updatedamagefeedback("hitcritical");
}

_id_28F3() {
  self endon("death");
  self endon("disconnect");
  self endon("sprint_slide_end");
  self playlocalsound("melee_boost");
  self playsoundonmovingent("melee_boost_npc");
  var_0 = 0;
  var_1 = 5;

  while(var_1 > var_0) {
    var_2 = spawnfxforclient(level._id_28C9, self getEye(), self);
    thread _id_28F4(var_2, 0.1);
    triggerfx(var_2);
    earthquake(0.2, 0.25, self.origin, 96);
    self playRumbleOnEntity("slide_loop");
    var_0++;
    scripts\engine\utility::waitframe();
  }
}

_id_28F4(var_0, var_1) {
  wait(var_1);

  if(isDefined(var_0))
    var_0 delete();
}

_id_28F0(var_0) {
  var_0 endon("disconnect");
  var_1 = self.origin;
  self waittill("start_instant_ragdoll");
  wait 0.1;
  physicsexplosionsphere(var_1, 68, 48, 2.5);
}

_id_D64A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = vectordot(var_5, var_3);

  if(var_6 < 0 || var_6 > var_1)
    return 0;

  var_5 = var_5 - var_6 * var_3;
  var_7 = lengthsquared(var_5);

  if(var_7 > var_0)
    return 0;

  return 1;
}

_id_96C3() {
  var_0 = spawnStruct();
  return var_0;
}

_id_F4E2() {
  self.movespeedscaler = 1.1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_12C26() {
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_F4E3() {
  self.movespeedscaler = 1.1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_12C27() {
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_F4E4() {
  self.movespeedscaler = 1.15 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_12C28() {
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_F4E5() {
  self.movespeedscaler = 1.2 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_12C29() {
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_F4E6() {
  self.movespeedscaler = 1.25 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_12C2A() {
  self.movespeedscaler = 1.0 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

_id_5AD3() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");

  for(;;) {
    if(!self isonground() && self _meth_81CE()) {
      wait 0.2;
      earthquake(0.25, 0.75, self.origin + (0, 0, 60), 100);

      while(self _meth_81CE() && !self isonground())
        wait 0.05;
    }

    wait 0.05;
  }
}

_id_96CA() {
  var_0 = spawnStruct();
  var_0.pistol_overkill = 0;
  var_0._id_CBDC = 0;
  return var_0;
}

_id_3D92(var_0, var_1) {
  self.lastweapon = self getcurrentweapon();
  self._id_CBD8 = self getweaponammoclip(var_1, "right");
  self._id_CBD7 = self getweaponammostock(var_1);
}

_id_82F0(var_0) {
  var_1 = var_0;
  scripts\cp\utility::_giveweapon(var_1);
  self setweaponammoclip(var_1, self._id_CBD8, "right");
  self setweaponammostock(var_1, self._id_CBD7);
  var_2 = self getweaponslistprimaries();

  if(!self hasweapon(self.lastweapon) && !scripts\cp\utility::has_special_weapon() && !scripts\cp\utility::is_holding_deployable())
    self switchtoweapon(var_1);
}

_id_F50B() {}

_id_12C4F() {
  _id_110A1("iw6_p226_mp");
}

_id_F50C() {
  _id_82F0("iw6_p226_mp_barrelrange02");
}

_id_12C50() {
  _id_110A1("iw6_p226_mp");
}

_id_F50D() {
  _id_82F0("iw6_p226_mp_barrelrange02_xmags");
}

_id_12C51() {
  _id_110A1("iw6_p226_mp");
}

_id_F50E() {
  _id_82F0("iw6_p226_mp_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C52() {
  _id_110A1("iw6_p226_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

_id_F50F() {
  _id_82F0("iw6_p226_mp_akimbo_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C53() {
  _id_110A1("iw6_p226_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

_id_F4F2() {}

_id_12C36() {
  _id_110A1("iw6_magnum_mp");
}

_id_F4F3() {
  _id_82F0("iw6_magnum_mp_barrelrange02");
}

_id_12C37() {
  _id_110A1("iw6_magnum_mp");
}

_id_F4F4() {
  _id_82F0("iw6_magnum_mp_barrelrange02_xmags");
}

_id_12C38() {
  _id_110A1("iw6_magnum_mp");
}

_id_F4F5() {
  _id_82F0("iw6_magnum_mp_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C39() {
  _id_110A1("iw6_magnum_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

_id_F4F6() {
  _id_82F0("iw6_magnum_mp_akimbo_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C3A() {
  _id_110A1("iw6_alienmagnum_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

_id_F506() {}

_id_12C4A() {
  _id_110A1("iw6_m9a1_mp");
}

_id_F507() {
  _id_82F0("iw6_m9a1_mp_barrelrange02");
}

_id_12C4B() {
  _id_110A1("iw6_m9a1_mp");
}

_id_F508() {
  _id_82F0("iw6_m9a1_mp_barrelrange02_xmags");
}

_id_12C4C() {
  _id_110A1("iw6_m9a1_mp");
}

_id_F509() {
  _id_82F0("iw6_m9a1_mp_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C4D() {
  _id_110A1("iw6_m9a1_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

_id_F50A() {
  _id_82F0("iw6_m9a1_mp_akimbo_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C4E() {
  _id_110A1("iw6_m9a1_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

_id_110A1(var_0) {
  var_1 = _id_7907();
  _id_3D92(var_0, var_1);
  self takeweapon(var_1);
}

_id_F501() {}

_id_12C45() {
  _id_110A1("iw6_mp443_mp");
}

_id_F502() {
  _id_82F0("iw6_mp443_mp_barrelrange02");
}

_id_12C46() {
  _id_110A1("iw6_mp443_mp");
}

_id_F503() {
  _id_82F0("iw6_mp443_mp_barrelrange02_xmags");
}

_id_12C47() {
  _id_110A1("iw6_mp443_mp");
}

_id_F504() {
  _id_82F0("iw6_mp443_mp_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C48() {
  _id_110A1("iw6_mp443_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

_id_F505() {
  _id_82F0("iw6_mp443_mp_akimbo_barrelrange02_xmags");
  self.perk_data["pistol"].pistol_overkill = 1;
}

_id_12C49() {
  _id_110A1("iw6_mp443_mp");
  self.perk_data["pistol"].pistol_overkill = 0;
}

watchcombatspeedscaler() {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self._id_CBE0 = 1.0;
  self._id_1BD9 = 1.0;
  self._id_1BD8 = 0;
  self.combatspeedscalar = _id_7E3B();
  self[[level.move_speed_scale]]();

  for(;;) {
    self waittill("weapon_change", var_0);
    var_1 = self getcurrentweapon();
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "nrg" || var_2 == "zmagnum" || var_2 == "zg18" || var_2 == "emc")
        self._id_CBE0 = 1.1;
      else
        self._id_CBE0 = 1.0;

      wait 0.05;
      _id_12E78();
    }

    wait 0.05;
  }
}

_id_12E78() {
  self.combatspeedscalar = _id_7E3B();
  self[[level.move_speed_scale]]();
}

_id_7E3B() {
  return self._id_CBE0 * self._id_1BD9;
}

_id_13A29() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0)) {
      if(var_0 == "iw5_alienriotshield4_mp_camo05" && self.fireshield == 1.0) {
        playFXOnTag(level._effect["riotshield_fire"], self, "tag_origin");
        continue;
      }

      stopFXOnTag(level._effect["riotshield_fire"], self, "tag_origin");
    }
  }

  wait 0.05;
}

has_fragile_relic_and_is_sprinting() {
  if(scripts\cp\perks\prestige::prestige_getslowhealthregenscalar() != 1.0 && self issprinting())
    return 1;
  else
    return 0;
}

_id_7907() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\utility::coop_getweaponclass(var_2);

    if(var_3 == "weapon_pistol")
      return var_2;
  }
}

applystunresistence(var_0) {
  if(isDefined(self._id_1119B))
    return self._id_1119B * var_0;
  else
    return var_0;
}
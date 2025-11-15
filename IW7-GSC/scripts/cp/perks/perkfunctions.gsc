/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3325.gsc
************************/

func_96C9() {
	var_00 = spawnStruct();
	return var_00;
}

func_F4EC() {}

func_12C30() {}

func_96C2() {
	var_00 = spawnStruct();
	var_00.melee_scalar = 1;
	return var_00;
}

func_F4DD() {
	self.perk_data["health"].max_health = 125;
	self.perk_data["health"].melee_scalar = 1;
}

func_12C21() {
	self.perk_data["health"].melee_scalar = 1;
}

func_F4DE() {
	self.perk_data["health"].max_health = 125;
	self.maxhealth = self.perk_data["health"].max_health;
	self notify("health_perk_upgrade");
	self.perk_data["health"].melee_scalar = 1.25;
}

func_12C22() {
	self.perk_data["health"].melee_scalar = 1;
}

func_F4DF() {
	self.perk_data["health"].max_health = 150;
	self.maxhealth = self.perk_data["health"].max_health;
	self notify("health_perk_upgrade");
	self.perk_data["health"].melee_scalar = 1.25;
}

func_12C23() {
	self.perk_data["health"].melee_scalar = 1;
}

func_F4E0() {
	self.perk_data["health"].max_health = 175;
	self.maxhealth = self.perk_data["health"].max_health;
	self notify("health_perk_upgrade");
	self.perk_data["health"].melee_scalar = 1.5;
}

func_12C24() {
	self.perk_data["health"].melee_scalar = 1;
}

func_F4E1() {
	self.perk_data["health"].max_health = 200;
	self.maxhealth = self.perk_data["health"].max_health;
	self notify("health_perk_upgrade");
	self.perk_data["health"].melee_scalar = 2;
}

func_12C25() {
	self.perk_data["health"].melee_scalar = 1;
}

func_96BF() {
	var_00 = spawnStruct();
	var_00.bullet_damage_scalar = 1;
	return var_00;
}

func_F4CE() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
}

func_12C12() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
}

func_F4CF() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
	scripts\cp\utility::giveperk("specialty_quickswap");
	scripts\cp\utility::giveperk("specialty_stalker");
	scripts\cp\utility::giveperk("specialty_fastoffhand");
}

func_12C13() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
	scripts\cp\utility::_unsetperk("specialty_quickswap");
	scripts\cp\utility::_unsetperk("specialty_stalker");
	scripts\cp\utility::_unsetperk("specialty_fastoffhand");
}

func_F4D0() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
	scripts\cp\utility::giveperk("specialty_quickswap");
	scripts\cp\utility::giveperk("specialty_stalker");
	scripts\cp\utility::giveperk("specialty_fastoffhand");
	scripts\cp\utility::giveperk("specialty_quickdraw");
}

func_12C14() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
	scripts\cp\utility::_unsetperk("specialty_quickswap");
	scripts\cp\utility::_unsetperk("specialty_stalker");
	scripts\cp\utility::_unsetperk("specialty_fastoffhand");
	scripts\cp\utility::_unsetperk("specialty_quickdraw");
}

func_F4D1() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1.2;
	scripts\cp\utility::giveperk("specialty_quickswap");
	scripts\cp\utility::giveperk("specialty_stalker");
	scripts\cp\utility::giveperk("specialty_fastoffhand");
	scripts\cp\utility::giveperk("specialty_quickdraw");
	scripts\cp\utility::giveperk("specialty_fastreload");
}

func_12C15() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
	scripts\cp\utility::_unsetperk("specialty_quickswap");
	scripts\cp\utility::_unsetperk("specialty_stalker");
	scripts\cp\utility::_unsetperk("specialty_fastoffhand");
	scripts\cp\utility::_unsetperk("specialty_quickdraw");
	scripts\cp\utility::giveperk("specialty_fastreload");
}

func_F4D2() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
	scripts\cp\utility::giveperk("specialty_quickswap");
	scripts\cp\utility::giveperk("specialty_stalker");
	scripts\cp\utility::giveperk("specialty_fastoffhand");
	scripts\cp\utility::giveperk("specialty_quickdraw");
	self setaimspreadmovementscale(0.5);
	scripts\cp\utility::giveperk("specialty_fastreload");
}

func_12C16() {
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
	scripts\cp\utility::_unsetperk("specialty_quickswap");
	scripts\cp\utility::_unsetperk("specialty_stalker");
	scripts\cp\utility::_unsetperk("specialty_fastoffhand");
	scripts\cp\utility::_unsetperk("specialty_quickdraw");
	self setaimspreadmovementscale(1);
	scripts\cp\utility::_unsetperk("specialty_fastreload");
}

func_96C8() {
	var_00 = spawnStruct();
	var_00.revive_time_scalar = 1;
	var_00.var_76AC = 1;
	var_00.var_BC6F = 1;
	var_00.var_E496 = 1;
	return var_00;
}

func_F4E7() {
	self.perk_data["medic"].revive_time_scalar = 1.5;
	self.movespeedscaler = scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
}

func_12C2B() {
	self.perk_data["medic"].revive_time_scalar = 1;
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
}

func_F4E8() {
	self.perk_data["medic"].revive_time_scalar = 1.5;
	self.movespeedscaler = 1.06 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	self.perk_data["medic"].var_E496 = 0.75;
}

func_12C2C() {
	self.perk_data["medic"].revive_time_scalar = 1;
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	self.perk_data["medic"].var_E496 = 1;
}

func_F4E9() {
	scripts\cp\utility::giveperk("specialty_longersprint");
	thread func_B526(65536);
	self.perk_data["medic"].revive_time_scalar = 1.5;
	self.movespeedscaler = 1.06 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	self.perk_data["medic"].var_E496 = 0.75;
}

func_12C2D() {
	scripts\cp\utility::_unsetperk("specialty_longersprint");
	self notify("end_medic_health_regen");
	self.perk_data["medic"].revive_time_scalar = 1;
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	self.perk_data["medic"].var_E496 = 1;
}

func_F4EA() {
	self.perk_data["medic"].var_76AC = 0;
	scripts\cp\utility::giveperk("specialty_longersprint");
	thread func_B526(65536);
	self.perk_data["medic"].revive_time_scalar = 1.5;
	self.movespeedscaler = 1.06 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	self.perk_data["medic"].var_E496 = 0.75;
}

func_12C2E() {
	self.perk_data["medic"].var_76AC = 1;
	scripts\cp\utility::_unsetperk("specialty_longersprint");
	self notify("end_medic_health_regen");
	self.perk_data["medic"].revive_time_scalar = 1;
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	self.perk_data["medic"].var_E496 = 1;
}

func_F4EB() {
	self.perk_data["medic"].revive_time_scalar = 1.5;
	self.perk_data["medic"].var_76AC = 0;
	thread func_B526(0);
	self.movespeedscaler = 1.12 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	scripts\cp\utility::giveperk("specialty_longersprint");
	scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
	scripts\cp\utility::giveperk("specialty_reducedsway");
	scripts\cp\utility::giveperk("specialty_bulletpenetration");
	self.perk_data["medic"].var_E496 = 0.75;
}

func_12C2F() {
	self.perk_data["medic"].revive_time_scalar = 1;
	self.perk_data["medic"].var_76AC = 1;
	self notify("end_medic_health_regen");
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["medic"].var_BC6F = self.movespeedscaler;
	scripts\cp\utility::_unsetperk("specialty_longersprint");
	scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
	scripts\cp\utility::_unsetperk("specialty_reducedsway");
	scripts\cp\utility::_unsetperk("specialty_bulletpenetration");
	self.perk_data["medic"].var_E496 = 1;
}

func_B526(param_00) {
	self endon("death");
	self endon("disconnect");
	self endon("end_medic_health_regen");
	var_01 = param_00 > 0;
	for(;;) {
		foreach(var_03 in level.players) {
			if(scripts\cp\utility::isreallyalive(var_03) && !isDefined(var_03.var_B528)) {
				if(var_01 && distancesquared(self.origin,var_03.origin) > param_00) {
					continue;
				}

				var_03 thread func_B527();
			}
		}

		wait(1);
	}
}

func_B527() {
	self endon("death");
	self endon("disconnect");
	if(!has_fragile_relic_and_is_sprinting()) {
		self.var_B528 = 1;
		wait(1);
		self.health = int(min(self.maxhealth,self.health + 5));
		self.var_B528 = undefined;
	}
}

func_96CB() {
	var_00 = spawnStruct();
	var_00.var_5B99 = 1;
	var_00.var_5BB8 = 1;
	var_00.var_1269D = 1;
	var_00.var_1269F = 1;
	var_00.var_1269E = 1;
	var_00.var_4B35 = 1;
	var_00.var_E18F = 1;
	return var_00;
}

func_F510() {
	self.perk_data["rigger"].var_5B99 = 1.256;
	self.perk_data["rigger"].var_4B35 = 1.2;
}

func_12C54() {
	self.perk_data["rigger"].var_5B99 = 1;
	self.perk_data["rigger"].var_4B35 = 1;
}

func_F511() {
	self.perk_data["rigger"].var_5B99 = 1.256;
	self.perk_data["rigger"].var_4B35 = 1.2;
	self.perk_data["rigger"].var_5BB8 = 0.5;
}

func_12C55() {
	self.perk_data["rigger"].var_5B99 = 1;
	self.perk_data["rigger"].var_5BB8 = 1;
	self.perk_data["rigger"].var_4B35 = 1;
}

func_F512() {
	self.perk_data["rigger"].var_5B99 = 1.256;
	self.perk_data["rigger"].var_4B35 = 1.2;
	self.perk_data["rigger"].var_5BB8 = 0.5;
	self.perk_data["rigger"].var_1269D = 0.8;
}

func_12C56() {
	self.perk_data["rigger"].var_5B99 = 1;
	self.perk_data["rigger"].var_5BB8 = 1;
	self.perk_data["rigger"].var_1269D = 1;
	self.perk_data["rigger"].var_4B35 = 1;
}

func_F513() {
	self.perk_data["rigger"].var_5B99 = 1.256;
	self.perk_data["rigger"].var_4B35 = 1.2;
	self.perk_data["rigger"].var_5BB8 = 0.5;
	self.perk_data["rigger"].var_1269D = 0.8;
	self.perk_data["rigger"].var_1269F = 1.5;
	self.perk_data["rigger"].var_E18F = 0.75;
}

func_12C57() {
	self.perk_data["rigger"].var_5B99 = 1;
	self.perk_data["rigger"].var_5BB8 = 1;
	self.perk_data["rigger"].var_1269D = 1;
	self.perk_data["rigger"].var_1269F = 1;
	self.perk_data["rigger"].var_4B35 = 1;
	self.perk_data["rigger"].var_E18F = 1;
}

func_F514() {
	self.perk_data["rigger"].var_5B99 = 1.256;
	self.perk_data["rigger"].var_4B35 = 1.2;
	self.perk_data["rigger"].var_5BB8 = 0.5;
	self.perk_data["rigger"].var_1269D = 0.8;
	self.perk_data["rigger"].var_1269F = 1.5;
	self.perk_data["rigger"].var_1269E = 2;
	self [[level.var_F480]](8000 * scripts\cp\perks\prestige::prestige_getwalletsizescalar());
	self.perk_data["rigger"].var_E18F = 0.75;
}

func_12C58() {
	self.perk_data["rigger"].var_5B99 = 1;
	self.perk_data["rigger"].var_5BB8 = 1;
	self.perk_data["rigger"].var_1269D = 1;
	self.perk_data["rigger"].var_1269F = 1;
	self.perk_data["rigger"].var_1269E = 1;
	self.perk_data["rigger"].var_4B35 = 1;
	self [[level.var_F480]](6000 * scripts\cp\perks\prestige::prestige_getwalletsizescalar());
	self.perk_data["rigger"].var_E18F = 1;
}

func_96CC() {
	var_00 = spawnStruct();
	var_00.var_2183 = 0;
	var_00.var_2182 = 0;
	return var_00;
}

func_F515() {
	self.perk_data["robotics"].var_2180 = 25;
	self.perk_data["robotics"].var_2181 = 1;
}

func_12C59() {
	self.perk_data["robotics"].var_2180 = 0;
	self.perk_data["robotics"].var_2181 = 0;
}

func_F516() {
	self.perk_data["robotics"].var_2180 = 50;
	self.perk_data["robotics"].var_2181 = 2;
}

func_12C5A() {
	self.perk_data["robotics"].var_2180 = 0;
	self.perk_data["robotics"].var_2181 = 0;
}

func_F517() {
	self.perk_data["robotics"].var_2180 = 75;
	self.perk_data["robotics"].var_2181 = 3;
}

func_12C5B() {
	self.perk_data["robotics"].var_2180 = 0;
	self.perk_data["robotics"].var_2181 = 0;
}

func_F518() {
	self.perk_data["robotics"].var_2180 = 100;
	self.perk_data["robotics"].var_2181 = 4;
}

func_12C5C() {
	self.perk_data["robotics"].var_2180 = 0;
	self.perk_data["robotics"].var_2181 = 0;
}

func_F519() {
	self.perk_data["robotics"].var_2180 = 125;
	self.perk_data["robotics"].var_2181 = 5;
}

func_12C5D() {
	self.perk_data["robotics"].var_2180 = 0;
	self.perk_data["robotics"].var_2181 = 0;
}

func_96C0() {
	var_00 = spawnStruct();
	var_00.explosive_damage_scalar = 1;
	var_00.offhand_count = 0;
	var_00.var_AAAA = 0;
	return var_00;
}

func_F4D3() {
	self.perk_data["demolition"].explosive_damage_scalar = 1.1;
	self.perk_data["demolition"].offhand_count = 2;
	self.perk_data["demolition"].var_AAAA = 4;
}

func_12C17() {
	self.perk_data["demolition"].explosive_damage_scalar = 1;
	self.perk_data["demolition"].offhand_count = 0;
	self.perk_data["demolition"].var_AAAA = 0;
}

func_F4D4() {
	self.perk_data["demolition"].explosive_damage_scalar = 1.2;
	self.perk_data["demolition"].offhand_count = 3;
	self.perk_data["demolition"].var_AAAA = 6;
}

func_12C18() {
	self.perk_data["demolition"].explosive_damage_scalar = 1;
	self.perk_data["demolition"].offhand_count = 0;
	self.perk_data["demolition"].var_AAAA = 0;
}

func_F4D5() {
	self.perk_data["demolition"].explosive_damage_scalar = 1.3;
	self.perk_data["demolition"].offhand_count = 4;
	self.perk_data["demolition"].var_AAAA = 8;
}

func_12C19() {
	self.perk_data["demolition"].explosive_damage_scalar = 1;
	self.perk_data["demolition"].offhand_count = 0;
	self.perk_data["demolition"].var_AAAA = 0;
}

func_F4D6() {
	self.perk_data["demolition"].explosive_damage_scalar = 1.4;
	self.perk_data["demolition"].offhand_count = 4;
	self.perk_data["demolition"].var_AAAA = 10;
}

func_12C1A() {
	self.perk_data["demolition"].explosive_damage_scalar = 1;
	self.perk_data["demolition"].offhand_count = 0;
	self.perk_data["demolition"].var_AAAA = 0;
}

func_F4D7() {
	self.perk_data["demolition"].explosive_damage_scalar = 1.5;
	self.perk_data["demolition"].offhand_count = 5;
	self.perk_data["demolition"].var_AAAA = 12;
}

func_12C1B() {
	self.perk_data["demolition"].explosive_damage_scalar = 1;
	self.perk_data["demolition"].offhand_count = 0;
	self.perk_data["demolition"].var_AAAA = 0;
}

func_DE49() {
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	var_00 = 5;
	for(;;) {
		var_01 = self getrunningforwardpainanim("aliensemtex_mp");
		if(var_01 == 0) {
			for(var_02 = 1;var_02 <= scripts\cp\perks\perk_utility::perk_getoffhandcount();var_02++) {
				self _meth_831C("other");
				scripts\cp\utility::filloffhandweapons("aliensemtex_mp",1);
				wait(var_00);
			}
		}

		wait(var_00);
	}
}

func_96C1() {
	var_00 = spawnStruct();
	var_00.var_8723 = 1;
	return var_00;
}

func_F4D8() {
	scripts\cp\utility::giveperk("specialty_marathon");
	scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
	scripts\cp\utility::giveperk("specialty_fastreload");
	self setaimspreadmovementscale(0.5);
	self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

func_12C1C() {
	scripts\cp\utility::_unsetperk("specialty_marathon");
	scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::_unsetperk("specialty_fastreload");
	self setaimspreadmovementscale(1);
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
}

func_F4D9() {
	scripts\cp\utility::giveperk("specialty_marathon");
	scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1.1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::giveperk("specialty_fastreload");
	self setaimspreadmovementscale(0.5);
	self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

func_12C1D() {
	scripts\cp\utility::_unsetperk("specialty_marathon");
	scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::_unsetperk("specialty_fastreload");
	self setaimspreadmovementscale(1);
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
}

func_F4DA() {
	scripts\cp\utility::giveperk("specialty_marathon");
	scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1.15 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::giveperk("specialty_fastreload");
	self setaimspreadmovementscale(0.5);
	self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

func_12C1E() {
	scripts\cp\utility::_unsetperk("specialty_marathon");
	scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::_unsetperk("specialty_fastreload");
	self setaimspreadmovementscale(1);
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
}

func_F4DB() {
	scripts\cp\utility::giveperk("specialty_marathon");
	scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1.2 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::giveperk("specialty_fastreload");
	self setaimspreadmovementscale(0.5);
	self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

func_12C1F() {
	scripts\cp\utility::_unsetperk("specialty_marathon");
	scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::_unsetperk("specialty_fastreload");
	self setaimspreadmovementscale(1);
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
}

func_F4DC() {
	scripts\cp\utility::giveperk("specialty_marathon");
	scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1.25 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::giveperk("specialty_fastreload");
	self setaimspreadmovementscale(0);
	self.perk_data["damagemod"].bullet_damage_scalar = 1.5;
}

func_12C20() {
	scripts\cp\utility::_unsetperk("specialty_marathon");
	scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
	self.perk_data["gunslinger"].var_8723 = self.movespeedscaler;
	scripts\cp\utility::_unsetperk("specialty_fastreload");
	self setaimspreadmovementscale(1);
	self.perk_data["damagemod"].bullet_damage_scalar = 1;
}

setbattleslide() {
	level.var_28C9 = loadfx("vfx\core\mp\core\vfx_battle_slide_camera");
	thread func_28EC();
}

unsetbattleslide() {
	self notify("battleSlide_unset");
	func_28E5();
}

func_28EC() {
	self endon("death");
	self endon("disconnect");
	self endon("battleSlide_unset");
	for(;;) {
		self waittill("sprint_slide_begin");
		func_28E2();
		self waittill("sprint_slide_end");
		func_28E5();
	}

	self notify("battleSlide_unset");
	self.var_28F7 = undefined;
}

func_28E2() {
	self.var_28E1 = 1;
	self.var_28F7 = [];
	thread func_28F3();
	thread func_28ED();
}

func_28E5() {
	self.var_28E1 = undefined;
	self.var_28F7 = undefined;
}

func_28ED() {
	self endon("death");
	self endon("disconnect");
	self endon("sprint_slide_end");
	self endon("battleSlide_unset");
	for(;;) {
		var_00 = self getvelocity();
		var_01 = lengthsquared(var_00);
		var_02 = anglestoup(self.angles);
		var_03 = anglesToForward(self.angles);
		var_04 = (0,0,0);
		var_05 = (0,0,0);
		var_06 = scripts\common\trace::create_contents(0,1,1,0,1,0);
		if(var_01 > 100) {
			var_07 = vectortoangles(var_00);
			var_03 = anglesToForward(var_07);
			var_02 = anglestoup(var_07);
			var_04 = var_03 * 40;
			var_05 = var_02 * 28;
			var_08 = physics_raycast(self getEye(),self.origin + var_04 + var_05,var_06,undefined,0,"physicsquery_closest");
			if(isDefined(var_08) && var_08.size > 0) {
				var_04 = var_03 * vectordot(var_08[0]["position"] - self.origin,var_03);
				var_04 = var_04 - var_03 * 3;
			}
		}

		var_09 = level.spawned_enemies;
		foreach(var_0B in var_09) {
			if(!isDefined(var_0B) || var_0B == self || !scripts\cp\utility::isreallyalive(var_0B)) {
				continue;
			}

			if(isDefined(var_0B.agent_type) && var_0B.agent_type == "zombie_brute" || var_0B.agent_type == "zombie_grey") {
				continue;
			}

			if(func_28EA(var_0B)) {
				continue;
			}

			if(!func_D64A(2304,56,self.origin + var_04,var_02,var_0B gettagorigin("j_mainroot"))) {
				continue;
			}

			if(func_28E8(var_0B,var_03)) {
				continue;
			}

			if(func_28E7(var_0B,self.origin + var_04 + var_05,var_06)) {
				continue;
			}

			func_28F5(var_0B);
			func_28E3(var_0B);
			func_28EB(var_0B,var_03);
		}

		scripts\engine\utility::waitframe();
	}
}

func_28F5(param_00) {
	if(!isDefined(self.var_28F7)) {
		self.var_28F7 = [];
	}

	if(!func_28EA(param_00)) {
		self.var_28F7[self.var_28F7.size] = param_00 getentitynumber();
		return 1;
	}

	return 0;
}

func_28E3(param_00) {
	var_01 = int(min(param_00.maxhealth,1000));
	if(var_01 >= self.health) {
		self.customdeath = 1;
		thread func_28F0(param_00);
	}

	param_00 dodamage(var_01,self.origin,self,self,"MOD_EXPLOSIVE","battleslide_mp");
	thread func_28E4(param_00);
}

func_28EB(param_00,param_01) {
	var_02 = param_00.origin - self.origin;
	var_03 = length(var_02);
	if(var_03 != 0) {
		var_04 = var_02 / var_03;
		var_05 = param_00 getvelocity();
		var_05 = var_05 - var_04 * vectordot(var_05,var_04);
		var_05 = var_05 + var_04 * 800;
		var_05 = var_05 + (0,0,175);
		param_00 setvelocity(var_05);
		param_00 shellshock("battleslide_mp",1.5);
	}
}

func_28E8(param_00,param_01) {
	return vectordot(param_01,param_00.origin - self.origin) < 0;
}

func_28E7(param_00,param_01,param_02) {
	var_03 = physics_raycast(param_01,param_00 gettagorigin("j_mainroot"),param_02,undefined,0,"physicsquery_closest");
	if(isDefined(var_03) && var_03.size > 0) {
		return 1;
	}

	return 0;
}

func_28E9(param_00,param_01) {
	if(isDefined(param_00.hasriotshield) && param_00.hasriotshield) {
		var_02 = param_01 - param_00.origin;
		var_03 = vectornormalize((var_02[0],var_02[1],0));
		var_04 = anglesToForward(param_00.angles);
		var_05 = vectordot(var_04,var_02);
		if(param_00.hasriotshieldequipped) {
			if(var_05 > 0.766) {
				return 1;
			}
		}
		else if(var_05 < -0.766) {
			return 1;
		}
	}

	return 0;
}

func_28EA(param_00) {
	if(!isDefined(self.var_28F7)) {
		return 0;
	}

	var_01 = param_00 getentitynumber();
	return scripts\engine\utility::array_contains(self.var_28F7,var_01);
}

func_28E6(param_00) {
	return isDefined(param_00.var_28E6);
}

func_28E4(param_00) {
	self playrumbleonentity("artillery_rumble");
	param_00 playrumbleonentity("artillery_rumble");
	playrumbleonposition("slide_collision",self.origin);
	earthquake(0.5,0.5,self.origin,96);
	playsoundatpos(self.origin,"slide_impact");
	self setclientomnvar("ui_hud_shake",1);
	scripts\cp\cp_damage::updatedamagefeedback("hitcritical");
}

func_28F3() {
	self endon("death");
	self endon("disconnect");
	self endon("sprint_slide_end");
	self playlocalsound("melee_boost");
	self playsoundonmovingent("melee_boost_npc");
	var_00 = 0;
	var_01 = 5;
	while(var_01 > var_00) {
		var_02 = spawnfxforclient(level.var_28C9,self getEye(),self);
		thread func_28F4(var_02,0.1);
		triggerfx(var_02);
		earthquake(0.2,0.25,self.origin,96);
		self playrumbleonentity("slide_loop");
		var_00++;
		scripts\engine\utility::waitframe();
	}
}

func_28F4(param_00,param_01) {
	wait(param_01);
	if(isDefined(param_00)) {
		param_00 delete();
	}
}

func_28F0(param_00) {
	param_00 endon("disconnect");
	var_01 = self.origin;
	self waittill("start_instant_ragdoll");
	wait(0.1);
	physicsexplosionsphere(var_01,68,48,2.5);
}

func_D64A(param_00,param_01,param_02,param_03,param_04) {
	var_05 = param_04 - param_02;
	var_06 = vectordot(var_05,param_03);
	if(var_06 < 0 || var_06 > param_01) {
		return 0;
	}

	var_05 = var_05 - var_06 * param_03;
	var_07 = lengthsquared(var_05);
	if(var_07 > param_00) {
		return 0;
	}

	return 1;
}

func_96C3() {
	var_00 = spawnStruct();
	return var_00;
}

func_F4E2() {
	self.movespeedscaler = 1.1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_12C26() {
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_F4E3() {
	self.movespeedscaler = 1.1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_12C27() {
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_F4E4() {
	self.movespeedscaler = 1.15 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_12C28() {
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_F4E5() {
	self.movespeedscaler = 1.2 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_12C29() {
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_F4E6() {
	self.movespeedscaler = 1.25 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_12C2A() {
	self.movespeedscaler = 1 * scripts\cp\perks\prestige::prestige_getmoveslowscalar();
}

func_5AD3() {
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	for(;;) {
		if(!self isonground() && self gettimeremainingpercentage()) {
			wait(0.2);
			earthquake(0.25,0.75,self.origin + (0,0,60),100);
			while(self gettimeremainingpercentage() && !self isonground()) {
				wait(0.05);
			}
		}

		wait(0.05);
	}
}

func_96CA() {
	var_00 = spawnStruct();
	var_00.pistol_overkill = 0;
	var_00.var_CBDC = 0;
	return var_00;
}

func_3D92(param_00,param_01) {
	self.lastweapon = self getcurrentweapon();
	self.var_CBD8 = self getweaponammoclip(param_01,"right");
	self.var_CBD7 = self getweaponammostock(param_01);
}

_meth_82F0(param_00) {
	var_01 = param_00;
	scripts\cp\utility::_giveweapon(var_01);
	self setweaponammoclip(var_01,self.var_CBD8,"right");
	self setweaponammostock(var_01,self.var_CBD7);
	var_02 = self getweaponslistprimaries();
	if(!self hasweapon(self.lastweapon) && !scripts\cp\utility::has_special_weapon() && !scripts\cp\utility::is_holding_deployable()) {
		self switchtoweapon(var_01);
	}
}

func_F50B() {}

func_12C4F() {
	func_110A1("iw6_p226_mp");
}

func_F50C() {
	_meth_82F0("iw6_p226_mp_barrelrange02");
}

func_12C50() {
	func_110A1("iw6_p226_mp");
}

func_F50D() {
	_meth_82F0("iw6_p226_mp_barrelrange02_xmags");
}

func_12C51() {
	func_110A1("iw6_p226_mp");
}

func_F50E() {
	_meth_82F0("iw6_p226_mp_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C52() {
	func_110A1("iw6_p226_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

func_F50F() {
	_meth_82F0("iw6_p226_mp_akimbo_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C53() {
	func_110A1("iw6_p226_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

func_F4F2() {}

func_12C36() {
	func_110A1("iw6_magnum_mp");
}

func_F4F3() {
	_meth_82F0("iw6_magnum_mp_barrelrange02");
}

func_12C37() {
	func_110A1("iw6_magnum_mp");
}

func_F4F4() {
	_meth_82F0("iw6_magnum_mp_barrelrange02_xmags");
}

func_12C38() {
	func_110A1("iw6_magnum_mp");
}

func_F4F5() {
	_meth_82F0("iw6_magnum_mp_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C39() {
	func_110A1("iw6_magnum_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

func_F4F6() {
	_meth_82F0("iw6_magnum_mp_akimbo_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C3A() {
	func_110A1("iw6_alienmagnum_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

func_F506() {}

func_12C4A() {
	func_110A1("iw6_m9a1_mp");
}

func_F507() {
	_meth_82F0("iw6_m9a1_mp_barrelrange02");
}

func_12C4B() {
	func_110A1("iw6_m9a1_mp");
}

func_F508() {
	_meth_82F0("iw6_m9a1_mp_barrelrange02_xmags");
}

func_12C4C() {
	func_110A1("iw6_m9a1_mp");
}

func_F509() {
	_meth_82F0("iw6_m9a1_mp_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C4D() {
	func_110A1("iw6_m9a1_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

func_F50A() {
	_meth_82F0("iw6_m9a1_mp_akimbo_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C4E() {
	func_110A1("iw6_m9a1_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

func_110A1(param_00) {
	var_01 = func_7907();
	func_3D92(param_00,var_01);
	self takeweapon(var_01);
}

func_F501() {}

func_12C45() {
	func_110A1("iw6_mp443_mp");
}

func_F502() {
	_meth_82F0("iw6_mp443_mp_barrelrange02");
}

func_12C46() {
	func_110A1("iw6_mp443_mp");
}

func_F503() {
	_meth_82F0("iw6_mp443_mp_barrelrange02_xmags");
}

func_12C47() {
	func_110A1("iw6_mp443_mp");
}

func_F504() {
	_meth_82F0("iw6_mp443_mp_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C48() {
	func_110A1("iw6_mp443_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

func_F505() {
	_meth_82F0("iw6_mp443_mp_akimbo_barrelrange02_xmags");
	self.perk_data["pistol"].pistol_overkill = 1;
}

func_12C49() {
	func_110A1("iw6_mp443_mp");
	self.perk_data["pistol"].pistol_overkill = 0;
}

watchcombatspeedscaler() {
	self endon("death");
	self endon("disconnect");
	self endon("last_stand");
	self.var_CBE0 = 1;
	self.var_1BD9 = 1;
	self.var_1BD8 = 0;
	self.combatspeedscalar = func_7E3B();
	self [[level.move_speed_scale]]();
	for(;;) {
		self waittill("weapon_change",var_00);
		var_01 = self getcurrentweapon();
		var_02 = scripts\cp\utility::getrawbaseweaponname(var_01);
		if(isDefined(var_02)) {
			if(var_02 == "nrg" || var_02 == "zmagnum" || var_02 == "zg18" || var_02 == "emc") {
				self.var_CBE0 = 1.1;
			}
			else
			{
				self.var_CBE0 = 1;
			}

			wait(0.05);
			func_12E78();
		}

		wait(0.05);
	}
}

func_12E78() {
	self.combatspeedscalar = func_7E3B();
	self [[level.move_speed_scale]]();
}

func_7E3B() {
	return self.var_CBE0 * self.var_1BD9;
}

func_13A29() {
	self endon("death");
	self endon("disconnect");
	for(;;) {
		var_00 = self getcurrentweapon();
		if(isDefined(var_00)) {
			if(var_00 == "iw5_alienriotshield4_mp_camo05" && self.fireshield == 1) {
				playFXOnTag(level._effect["riotshield_fire"],self,"tag_origin");
				continue;
			}

			stopFXOnTag(level._effect["riotshield_fire"],self,"tag_origin");
		}
	}

	wait(0.05);
}

has_fragile_relic_and_is_sprinting() {
	if(scripts\cp\perks\prestige::prestige_getslowhealthregenscalar() != 1 && self issprinting()) {
		return 1;
	}

	return 0;
}

func_7907() {
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00) {
		var_03 = scripts\cp\utility::coop_getweaponclass(var_02);
		if(var_03 == "weapon_pistol") {
			return var_02;
		}
	}
}

applystunresistence(param_00) {
	if(isDefined(self.var_1119B)) {
		return self.var_1119B * param_00;
	}

	return param_00;
}
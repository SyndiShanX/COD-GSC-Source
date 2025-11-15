/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3324.gsc
************************/

func_95C1() {
	self.perk_data = [];
	self.perk_data["health"] = scripts\cp\perks\perkfunctions::func_96C2();
	self.perk_data["damagemod"] = scripts\cp\perks\perkfunctions::func_96BF();
	self.perk_data["medic"] = scripts\cp\perks\perkfunctions::func_96C8();
	self.perk_data["rigger"] = scripts\cp\perks\perkfunctions::func_96CB();
	self.perk_data["robotics"] = scripts\cp\perks\perkfunctions::func_96CC();
	self.perk_data["demolition"] = scripts\cp\perks\perkfunctions::func_96C0();
	self.perk_data["gunslinger"] = scripts\cp\perks\perkfunctions::func_96C1();
	self.perk_data["hybrid"] = scripts\cp\perks\perkfunctions::func_96C3();
	self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::func_96CA();
	self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::func_96CA();
	self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::func_96CA();
	self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::func_96CA();
	self.perk_data["none"] = scripts\cp\perks\perkfunctions::func_96C9();
}

perk_getmeleescalar() {
	return self.perk_data["health"].melee_scalar;
}

perk_getmaxhealth() {
	return self.perk_data["health"].max_health;
}

perk_getbulletdamagescalar() {
	return self.perk_data["damagemod"].bullet_damage_scalar;
}

perk_getrevivetimescalar() {
	return self.perk_data["medic"].revive_time_scalar;
}

func_CA37() {
	return self.perk_data["medic"].var_76AC;
}

func_CA3B() {
	return self.perk_data["medic"].var_BC6F;
}

func_CA40() {
	return self.perk_data["medic"].var_E496;
}

perk_getdrillhealthscalar() {
	return self.perk_data["rigger"].var_5B99;
}

perk_getdrilltimescalar() {
	return self.perk_data["rigger"].var_5BB8;
}

func_CA42() {
	return self.perk_data["rigger"].var_1269D;
}

func_CA43() {
	return self.perk_data["rigger"].var_1269E;
}

func_CA44() {
	return self.perk_data["rigger"].var_1269F;
}

perk_getcurrencyscaleperhive() {
	return self.perk_data["rigger"].var_4B35;
}

func_CA3F() {
	return self.perk_data["rigger"].var_E18F;
}

func_CA30() {
	return self.perk_data["robotics"].var_2180;
}

func_CA31() {
	return self.perk_data["robotics"].var_2181;
}

perk_getexplosivedamagescalar() {
	return self.perk_data["demolition"].explosive_damage_scalar;
}

perk_getoffhandcount() {
	return self.perk_data["demolition"].offhand_count;
}

func_CA38() {
	return self.perk_data["demolition"].var_AAAA;
}

func_CA3E() {
	return self.perk_data["pistol"].var_CBDC;
}

func_CA3D() {
	return self.perk_data["pistol"].pistol_overkill;
}

func_7C4D() {}

func_7C4E() {
	var_00 = "perk_none";
	return var_00;
}

func_E2BC() {
	var_00 = func_7C4D();
	var_01 = func_7B75();
	scripts\cp\cp_persistence::set_perk(func_7B79("perk_0",var_00,var_01));
	var_02 = func_7C4E();
	if(var_02 != "perk_none") {
		var_03 = level.alien_perks["perk_0"][var_02];
		scripts\cp\cp_persistence::set_perk(func_7B79("perk_0",var_03.ref,var_01));
	}
}

func_7B79(param_00,param_01,param_02) {
	return level.alien_perks[param_00][param_01].var_12F7A[param_02].ref;
}

func_7B75() {
	return self getplayerdata("cp","alienSession","perk_0_level");
}

func_7B76() {
	return self getplayerdata("cp","alienSession","perk_1_level");
}

func_7B77() {
	return self getplayerdata("cp","alienSession","perk_2_level");
}
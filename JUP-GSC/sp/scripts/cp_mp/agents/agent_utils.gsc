/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\agents\agent_utils.gsc
***************************************************/

#using script_24fbedba9a7a1ef4;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace agent_utils;

function overridetier1(agent) {
  if(!isDefined(agent)) {
    return;
  }

  if(isint(agent)) {
    return;
  }

  agent.var_685390c6753c2cc7 = 1;
  body = undefined;
  head = undefined;
  weapon = undefined;
  grenade_type = undefined;
  grenadeammo = 0;
  var_7615a935cb1261ef = getdvarint(@ "hash_261e9ce11934ffae", 50);

  if(randomintrange(0, 100) < var_7615a935cb1261ef) {
    if(isDefined(level.var_39643776a698efce)) {
      grenade_type = agent[[level.var_39643776a698efce]](1);
    } else {
      var_7e1ff9afa225e8a1 = ["semtex_mp", "frag_grenade_mp", "gas_mp"];
      grenade_type = random(var_7e1ff9afa225e8a1);
    }

    grenadeammo = getdvarint(@ "hash_31607c7b3be624df", 1);
  }

  armor = getdvarint(@ "hash_82ad0eab483e9f5a", 0);

  if(agent.var_7cea08b66b2ad878 < 0) {
    agent.var_7cea08b66b2ad878 = 0;
  }

  helmet = undefined;
  agent function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor);
  agentpers_setagentpersdata(agent, "tier", 1);
  agent.baseaccuracy = getdvarfloat(@ "hash_8aa5333ca3f377e5", 0.66);
}

function function_198f5137d137e72f(agent, var_80f4bde7090a4773) {
  prefix = "agent_";
  postfix = "";

  if(issubstr(agent.agent_type, "jugg")) {
    postfix = "jugg";
  } else if(issubstr(agent.agent_type, "tier1")) {
    postfix = "tier1";
  } else if(issubstr(agent.agent_type, "tier2")) {
    postfix = "tier2";
  } else if(issubstr(agent.agent_type, "tier3")) {
    postfix = "tier3";
  }

  if(issubstr(agent.agent_type, "riotshield")) {
    postfix = "riotshield";
  }

  if(isDefined(var_80f4bde7090a4773) && tolower(var_80f4bde7090a4773) == "elite") {
    postfix = "elite";
  }

  tbgroup = prefix + postfix;

  if(postfix == "") {
    return;
  }

  if(!threatbiasgroupexists(tbgroup)) {
    createthreatbiasgroup(tbgroup);
    function_ad06babcffc3a43b(tbgroup);
  }

  agent setthreatbiasgroup(tbgroup);
}

function function_ad06babcffc3a43b(tbgroup) {
  setthreatbias(tbgroup, "Drone", getdvarint(@ "hash_4620216a9470ae72", -5000));

  if(issubstr(tbgroup, "tier1")) {}
}

function overridetier2(agent) {
  if(!isDefined(agent)) {
    return;
  }

  if(isint(agent)) {
    return;
  }

  agent.var_685390c6753c2cc7 = 1;
  body = undefined;
  head = undefined;
  weapon = undefined;

  if(isDefined(level.var_39643776a698efce)) {
    grenade_type = agent[[level.var_39643776a698efce]](2);
  } else {
    var_7e1ff9afa225e8a1 = ["semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "gas_mp", "decoy_grenade_mp"];
    grenade_type = random(var_7e1ff9afa225e8a1);
  }

  grenadeammo = getdvarint(@ "hash_31607d7b3be62712", 2);
  armor = getdvarint(@ "hash_82ad0dab483e9d27", 100);

  if(agent.var_7cea08b66b2ad878 < 0) {
    agent.var_7cea08b66b2ad878 = 1;
  }

  helmet = level.var_6855c201495094b6["tier2"];
  agent function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor, helmet);
  agentpers_setagentpersdata(agent, "tier", 2);
  agent.baseaccuracy = getdvarfloat(@ "hash_8aa5303ca3f3714c", 0.9);
}

function overridetier3(agent, noweaponchange) {
  if(!isDefined(agent)) {
    return;
  }

  if(isint(agent)) {
    return;
  }

  agent.var_282d867559c07771 = 1;
  body = undefined;
  head = undefined;
  weapon = undefined;

  if(isDefined(level.var_39643776a698efce)) {
    grenade_type = agent[[level.var_39643776a698efce]](3);
  } else {
    var_7e1ff9afa225e8a1 = ["thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp"];
    grenade_type = random(var_7e1ff9afa225e8a1);
  }

  grenadeammo = getdvarint(@ "hash_31607e7b3be62945", 4);
  armor = getdvarint(@ "hash_82ad0cab483e9af4", 250);

  if(iscp()) {
    agent.var_7cea08b66b2ad878 = 0;
  } else if(agent.var_7cea08b66b2ad878 < 0) {
    agent.var_7cea08b66b2ad878 = 2;
  }

  helmet = level.var_6855c201495094b6["tier3"];
  agent function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor, helmet);
  agentpers_setagentpersdata(agent, "tier", 3);
  agent.baseaccuracy = getdvarfloat(@ "hash_8aa5313ca3f3737f", 1.3);
  agent.var_cbd87a0bc497b778 = 1;
}

function function_1828f1e20e52b418(agent, var_84ecaeab58167d39) {
  if(!isDefined(agent)) {
    return;
  }

  function_ea83c1b372e16f6d(agent, "elite");

  if(isint(agent)) {
    return;
  }

  if(issubstr(agent.agent_type, "merc")) {
    return;
  }

  if(issubstr(agent.agent_type, "ru")) {
    return;
  }

  if(issubstr(agent.agent_type, "cartel")) {
    return;
  }

  if(issubstr(agent.agent_type, "pmc")) {
    return;
  }

  agent.var_685390c6753c2cc7 = 1;

  if(!isDefined(var_84ecaeab58167d39)) {
    if(isDefined(agent.subarea) && isDefined(agent.subarea.var_7da9883d4168b7f1)) {
      var_84ecaeab58167d39 = agent.subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39;
    }

    if(!isDefined(var_84ecaeab58167d39)) {
      return;
    }
  }

  [body, head, clothtype, geartype] = function_5ca105062ad7729(agent.agent_type, var_84ecaeab58167d39);
  armor = undefined;

  switch (var_84ecaeab58167d39) {
    case 3:
      armor = getdvarint(@ "hash_82ad0cab483e9af4", 250) + getdvarint(@ "hash_be76a857caf140ec", 100);
      break;
    case 2:
      armor = getdvarint(@ "hash_82ad0dab483e9d27", 100) + getdvarint(@ "hash_be76a857caf140ec", 100);
      break;
    default:
      break;
  }

  agent function_c37c4f9d687074ff(body, head, undefined, undefined, undefined, armor, undefined);

  if(isDefined(clothtype)) {
    agent setclothtype(clothtype);
  }

  if(isDefined(geartype)) {
    agent setclothtype(geartype);
  }

  var_40e4760e91ebbfb8 = ["thermite_mp", "semtex_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "gas_mp"];
  grenade_type = function_ba0801276542946b(var_40e4760e91ebbfb8);
  grenadeammo = getdvarint(@ "hash_537fa443ce212a8a", 3);
  agent.baseaccuracy *= getdvarfloat(@ "hash_54eaf02373da456d", 2);
  agent agent_sethealth(int(agent.health * getdvarfloat(@ "hash_14fc69230fc4ed30", 1.33)));
  string = "MP_DMZ_MISSIONS/ELITE_GENERIC";
  agentpers_setagentpersdata(agent, "elite", 1);
  rarity = undefined;

  switch (var_84ecaeab58167d39) {
    case 1:
      rarity = 2;
      string = "MP_DMZ_MISSIONS/ELITE_TIER1";
      break;
    case 2:
      rarity = 2;
      string = "MP_DMZ_MISSIONS/ELITE_TIER2";
      break;
    case 3:
      rarity = 3;
      string = "MP_DMZ_MISSIONS/ELITE_TIER3";
      break;
  }

  if(getdvarint(@ "hash_49b37fc622a4d585", 0) == 1) {
    agent function_3de79443c911d4a5(1, 3, string);
  }
}

function function_5ca105062ad7729(agenttype, var_84ecaeab58167d39) {
  switch (var_84ecaeab58167d39) {
    case 1:
      headmodel = random(["head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_al_qatala_ar_2_1"]);
      clothtype = "flowing";
      geartype = "strapsgr";
      return ["body_sp_opforce_al_qatala_tier_1_hardened_1_1", headmodel, clothtype, geartype];
    case 2:
      clothtype = "vestlight";
      geartype = "millghtgr";
      return ["body_sp_opforce_al_qatala_tier_2_hardened_1_1", undefined, clothtype, geartype];
    case 3:
      clothtype = "vestheavy";
      geartype = "milmedgr";
      return ["body_sp_opforce_al_qatala_tier_3_hardened_1_1", undefined, clothtype, geartype];
  }

  return [undefined, undefined];
}

function function_e43f4000cac35ba2(agent, weapon) {
  if(!isDefined(agent)) {
    return;
  }

  agent.var_7d606bec79308eb5 = 1200;
  agent.pursuestopdistance = 512;
  agent.goalheight = 1000;
  agent.var_685390c6753c2cc7 = 0;

  if(utility::iscp()) {
    if(isDefined(level.var_96d46b3de782e4e7)) {
      agent.var_7d606bec79308eb5 = level.var_96d46b3de782e4e7;
    } else {
      agent.var_7d606bec79308eb5 = 512;
    }

    if(isDefined(level.var_47247decd7164a0e)) {
      agent.pursuestopdistance = level.var_47247decd7164a0e;
    } else {
      agent.pursuestopdistance = 350;
    }
  } else if(getDvar(@ "hash_7611a2790a0bf7fe", "br") == "dmz") {
    agentpers_setagentpersdata(agent, "dropWeapon", 0);
  }

  if(getdvarint(@ "hash_60645ea7f5bb11f6", 1) == 1) {
    agent.var_2d670e4d288c86fb = 1;
  } else {
    agent.var_2d670e4d288c86fb = 0;
  }

  body = undefined;
  head = undefined;
  grenade_type = function_ba0801276542946b();
  grenadeammo = getdvarint(@ "hash_537fa443ce212a8a", 4);

  if(isDefined(level.var_5463147f04a33d36)) {
    armor = level.var_5463147f04a33d36;
  }

  armor = 2500;
  helmethealth = getdvarint(@ "hash_4cea285ee071705e", 2500);
  agent.var_895dae193cfaac3a = 1;
  agent function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor, helmethealth, 0);
  agent.allowlongdeath = 0;
  agent.allowpain = 1;

  if(isDefined(level.var_87deb8f6a4c7d50e)) {
    agent.var_2626d6897d71b728 = level.var_87deb8f6a4c7d50e;
  }

  agent.var_f2a62f02827daaa5 = 1;
  agent.baseaccuracy = getdvarfloat(@ "hash_bf81930e3ff6d7eb", 1.2);
}

function overrideriotshield(agent) {
  if(!isDefined(agent)) {
    return;
  }

  agent.var_2d670e4d288c86fb = 1;

  if(isDefined(agent.armorhealth) && agent.armorhealth > 0) {
    agent.minpaindamage = int(agent.armorhealth / 2);
  }

  agent enabletraversals(0);

  if(isDefined(level.var_719b61ca626125ff)) {
    agent.var_2626d6897d71b728 = level.var_719b61ca626125ff;
  }

  agent.baseaccuracy = getdvarfloat(@ "hash_48f1ebb27eaa1abb", 0.8);
}

function function_77ffe273ea3ec3a3(agent, noweaponchange) {
  if(!isDefined(agent)) {
    return;
  }

  body = "body_mp_eastern_velikan_1_1";
  head = "head_mp_eastern_velikan_1_1";
  weapon = undefined;

  if(!istrue(noweaponchange)) {
    weapon = scripts\cp_mp\weapon::buildweapon("iw9_lm_mkilo3_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  }

  grenade_type = function_ba0801276542946b();
  grenadeammo = getdvarint(@ "hash_537fa443ce212a8a", 4);
  armor = 3000;
  helmet = 1;
  agent function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor, helmet, 0);
  agent.var_f2a62f02827daaa5 = 1;
  agent.baseaccuracy = getdvarfloat(@ "hash_298d4ea8b0934e31", 1.2);
}

function function_852d353c00b3d5a1(agent, noweaponchange) {
  if(!isDefined(agent)) {
    return;
  }

  if(isint(agent)) {
    return;
  }

  body = "body_mp_eastern_rodion_7_1";
  head = "head_mp_eastern_rodion_7_1";
  weapon = undefined;
  grenade_type = "smoke_grenade_mp";
  grenadeammo = getdvarint(@ "hash_96aa0c082c47cdcc", 4);
  armor = 500;
  helmet = level.var_6855c201495094b6["tier3"];
  agent function_c37c4f9d687074ff(undefined, undefined, weapon, grenade_type, grenadeammo, armor, helmet);
  agentpers_setagentpersdata(agent, "tier", 3);
  agent.baseaccuracy = getdvarfloat(@ "hash_8aa5313ca3f3737f", 1.1);
}

function overridespecial(agent, weaponstyle) {
  body = "body_mp_milsim_balkan_sf_1_1";
  head = "head_mp_milsim_balkan_sf_1_1";
  weapon = scripts\cp_mp\weapon::buildweapon("iw9_sm_aviktor_mp", ["thermal01", "none", "none", "none", "silencer01_sm", "laserirsmg"], "none", "none");
  grenade_type = "frag_grenade_mp";

  if(!isDefined(weaponstyle)) {
    weaponstyle = random(["smg", "shotgun", "sniper"]);
  }

  switch (weaponstyle) {
    case #"hash_23209741b93850b5":
      body = "body_mp_eastern_nikto_2_1";
      head = "head_mp_eastern_nikto_3_1";
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_sh_charlie725_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      grenade_type = "molotov_mp";
      break;
    case #"hash_6191aaef9f922f96":
      body = "body_mp_eastern_azur_8_1";
      head = "head_mp_eastern_azur_8_1";
      weapon = scripts\cp_mp\weapon::buildweapon("iw8_sn_alpha50_mp", ["none", "none", "none", "laserir", "none", "none"], "none", "none");
      grenade_type = "frag_grenade_mp";
      break;
    case #"hash_900cb96c552c5e8e":
      body = "body_mp_eastern_rodion_7_1";
      head = "head_mp_eastern_rodion_7_1";
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_sm_aviktor", ["thermal01", "none", "none", "none", "silencer01_sm", "laserir_box"], "none", "none");
      grenade_type = "smoke_grenade_mp";
      break;
    default:
      break;
  }

  agentpers_setagentpersdata(agent, "dropWeapon", 0);
  grenadeammo = getdvarint(@ "hash_537fa443ce212a8a", 4);
  armor = 300;
  helmet = 1;
  groupname = undefined;

  if(isDefined(agent.script_stealthgroup)) {
    groupname = agent.script_stealthgroup;
  }

  agent function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor, helmet);

  if(scripts\engine\utility::issharedfuncdefined("ai", "dropLootOnAgentDeath")) {
    agent thread[[scripts\engine\utility::getsharedfunc("ai", "dropLootOnAgentDeath")]](agent, agent.agent_type, groupname);
  }
}

function function_c37c4f9d687074ff(body, head, weapon, grenade_type, grenadeammo, armor, helmet, blockexecution) {
  if(isDefined(body)) {
    self setModel(body);
  }

  if(isDefined(head)) {
    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
    }

    self attach(head, "", 1);
    self.headmodel = head;
  }

  if(isDefined(weapon)) {
    old_pos = undefined;
    weaponname = undefined;

    if(isDefined(self.weapon)) {
      self takeweapon(self.weapon);
      weaponname = getcompleteweaponname(self.weapon);

      if(isDefined(self.weaponinfo[weaponname])) {
        old_pos = self.weaponinfo[weaponname].position;
        self.weaponinfo = array_remove_key(self.weaponinfo, weaponname);
      }
    }

    self.weapon = weapon;
    utility::initweapon(self.weapon);
    agentpers_setagentpersdata(self, "weapon", weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;

    if(isDefined(self.a.weaponpos[old_pos])) {
      weaponname = getcompleteweaponname(self.weapon);
      self.weaponinfo[weaponname].position = old_pos;
      self.a.weaponpos[old_pos] = weapon;
    }
  }

  if(isDefined(grenade_type)) {
    if(!isDefined(level.var_e36af3bfa3484a15)) {
      level.var_e36af3bfa3484a15 = [];
    }

    if(!isDefined(level.var_e36af3bfa3484a15[grenade_type])) {
      level.var_e36af3bfa3484a15[grenade_type] = makeweapon(grenade_type);
    }

    self.grenadeweapon = level.var_e36af3bfa3484a15[grenade_type];

    if(!isDefined(grenadeammo)) {
      grenadeammo = 2;
    }

    self.grenadeammo = grenadeammo;
  }

  if(isDefined(armor)) {
    if(utility::iscp()) {
      if(armor > 0) {
        self.equip_armor = 1;
        self.armor_health = armor;
      }
    }

    self.armorhealth = int(armor);
    self.maxarmorhealth = int(armor);
    self.var_8c5c47f81a1869e5 = &namespace_daa149ca485fd50a::function_7d0d24665d72f13c;
  }

  if(isDefined(helmet)) {
    self.helmethealth = helmet;
    self.var_cfc69e5588a5bed6 = helmet;
    self.var_cd6a3a50f09688b9 = &namespace_daa149ca485fd50a::function_59ea6b2f800cb082;
  }

  if(istrue(blockexecution)) {
    function_1c3709e864d4e8d5(1);
  }

  if(isDefined(armor) && armor > 0) {
    function_1920867ddf76810c(self, armor);
  }
}

function function_b535fe740f1cf507() {
  if(isDefined(self.armorhealth)) {
    var_4ef15edd83080359 = self.var_dcade5065ea1a44;

    if(!isDefined(var_4ef15edd83080359)) {
      var_4ef15edd83080359 = getdvarint(@ "hash_a69c6853620fc61f", 200);
    }

    newhealth = min(self.armorhealth + var_4ef15edd83080359, self.maxarmorhealth);
    scripts\cp_mp\armor::setarmorhealth(newhealth);
    self.var_7cea08b66b2ad878 -= 1;
    self.var_27266ececc1bdbe5 = gettime();
  }
}

function function_1c3709e864d4e8d5(bool) {
  if(bool) {
    self.blockexecution = 1;
    val::set("agent_blockExecution", "execution_victim", 0);
    return;
  }

  self.blockexecution = 0;
  val::reset_all("agent_blockExecution");
}

function function_1920867ddf76810c(agent, armor) {
  if(issubstr(agent.agent_type, "riotshield")) {
    agent.var_9aa77ab756fdca82 = 0;
    agent.minpaindamage = 0;
    return;
  }

  if(issubstr(agent.agent_type, "tier3")) {
    agent.var_9aa77ab756fdca82 = 600;
    agent.var_43e2ad424676b8d4 = 1;
    agent.allowlongdeath = 0;
    return;
  }

  if(isDefined(armor) && armor > 0) {
    var_17b4196235199ba8 = [0, 40, 80];
    var_bbd534a2a8d03eaa = random(var_17b4196235199ba8);
    agent.var_9aa77ab756fdca82 = 240 + var_bbd534a2a8d03eaa;
    agent.var_43e2ad424676b8d4 = 50;
    agent.allowlongdeath = 0;
    return;
  }

  if(agent.var_d5e499e7fe2c490b) {
    agent.var_43e2ad424676b8d4 = 10;
    function_c00e1d676844f7ae(agent);
    return;
  }

  var_17b4196235199ba8 = [0, 50, 80];
  var_bbd534a2a8d03eaa = random(var_17b4196235199ba8);
  agent.var_9aa77ab756fdca82 = 100 + var_bbd534a2a8d03eaa;
  agent.var_43e2ad424676b8d4 = 10;
  agent.allowlongdeath = 0;
}

function function_c00e1d676844f7ae(agent) {
  if(issubstr(agent.agent_type, "tier1")) {
    agent.var_9aa77ab756fdca82 = 100;
    return;
  }

  if(issubstr(agent.agent_type, "tier2")) {
    agent.var_9aa77ab756fdca82 = 240;
    return;
  }

  if(issubstr(agent.agent_type, "tier3")) {
    agent.var_9aa77ab756fdca82 = 600;
  }
}

function function_ea83c1b372e16f6d(agent, var_80f4bde7090a4773) {
  if(isagent(agent)) {
    agent.var_80f4bde7090a4773 = var_80f4bde7090a4773;
    return;
  }

  if(isint(agent)) {
    level.var_879053468f168806[agent].var_80f4bde7090a4773 = var_80f4bde7090a4773;
  }
}

function function_ba0801276542946b(var_7e1ff9afa225e8a1) {
  if(isDefined(var_7e1ff9afa225e8a1)) {
    return random(var_7e1ff9afa225e8a1);
  }

  if(!isDefined(level.var_61312c4c9c8a7cae)) {
    level.var_61312c4c9c8a7cae = ["thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp"];
  }

  return random(level.var_61312c4c9c8a7cae);
}

function function_f5d160902133558() {
  assert(isDefined(level.agentarray));
  level.var_d7b3bd9ad64c74b = [];

  foreach(agent in level.agentarray) {
    level.var_d7b3bd9ad64c74b[agent getentitynumber()] = [];
  }
}

function function_d0563dc9eeac7ff0(agent) {
  if(!isDefined(level.var_d7b3bd9ad64c74b)) {
    function_f5d160902133558();
  }

  return agent getentitynumber();
}

function agentpers_setagentpersdata(agent, key, value) {
  if(!isDefined(level.var_d7b3bd9ad64c74b)) {
    function_f5d160902133558();
  }

  level.var_d7b3bd9ad64c74b[agent getentitynumber()][key] = value;
}

function agentpers_getagentpersdata(agent, key) {
  if(!isDefined(level.var_d7b3bd9ad64c74b)) {
    function_f5d160902133558();
  }

  return level.var_d7b3bd9ad64c74b[agent getentitynumber()][key];
}

function function_b894b8689a6055f3(agent) {
  if(!isDefined(level.var_d7b3bd9ad64c74b)) {
    function_f5d160902133558();
  }

  return level.var_d7b3bd9ad64c74b[agent getentitynumber()].size == 0;
}

function function_51de6da7b0dcf26f(agent) {
  if(!isDefined(level.var_d7b3bd9ad64c74b)) {
    function_f5d160902133558();
  }

  level.var_d7b3bd9ad64c74b[agent getentitynumber()] = [];
}

function function_3bdeb9edd6c6f0a() {
  level.var_c7796321c3d97413 = [];
  level.var_c7796321c3d97413[1] = ["firebug"];
  level.var_c7796321c3d97413[2] = [];
  level.var_c7796321c3d97413[3] = ["strikeunit"];
}

function function_c26ef480e88413bf(agent, aitype) {
  if(issubstr(aitype, "firebug")) {
    agent thread function_36613ffb5ebe56(agent);
    return;
  }

  if(issubstr(aitype, "strike")) {
    agent thread function_9ca698cdffe22968(agent);
    return;
  }

  if(getdvarint(@ "hash_b0e7edf188ddb934", 0) == 1 && !issubstr(aitype, "riotshield") && issubstr(aitype, "biolab")) {
    agent.var_7cea08b66b2ad878 = 0;

    if(isDefined(agent.subclass)) {
      if(agent.subclass == "tier2") {
        agent.suppressionthreshold = 0.8;
        agent.suppressiondecrement = 0.07;
        agent.var_2a4784c6cc07ca59 = 0.25;
        agent.var_cbd87a0bc497b778 = 1;
        agent.var_4268b42fc89d0be9 = 0.03;
        agent.gameskillmisstimedistancefactoroverride = 5e-05;
        agent.aggressivemode = 1;
      } else if(agent.subclass == "tier3") {
        agent.suppressionthreshold = 0.4;
        agent.suppressiondecrement = 0.2;
        agent.var_2a4784c6cc07ca59 = 0.05;
        agent.var_cbd87a0bc497b778 = 1;
        agent.var_4268b42fc89d0be9 = 0.015;
        agent.gameskillmisstimedistancefactoroverride = 1e-05;
        agent.aggressivemode = 1;
      }
    }

    return;
  }

  if(agent.subclass == "tier1") {
    agent.var_4268b42fc89d0be9 = getdvarfloat(@ "hash_6f6b0fce63d51e11", 0.07);
    agent.gameskillmisstimedistancefactoroverride = getdvarfloat(@ "hash_2e0c4c6766ac7ffe", 0.00015);
    return;
  }

  if(agent.subclass == "tier2") {
    agent.var_4268b42fc89d0be9 = getdvarfloat(@ "hash_6f6b0cce63d51778", 0.05);
    agent.gameskillmisstimedistancefactoroverride = getdvarfloat(@ "hash_2e0c4b6766ac7dcb", 0.0001);
    return;
  }

  if(agent.subclass == "tier3") {
    agent.suppressionthreshold = 0.5;
    agent.suppressiondecrement = 0.15;
    agent.var_2a4784c6cc07ca59 = 0.05;
    agent.var_4268b42fc89d0be9 = getdvarfloat(@ "hash_6f6b0dce63d519ab", 0.04);
    agent.gameskillmisstimedistancefactoroverride = getdvarfloat(@ "hash_2e0c4a6766ac7b98", 5e-05);
    agent.aggressivemode = 1;
  }
}

function function_36613ffb5ebe56(agent) {
  agent endon("death");
  agent endon("stop_throwing");
  standardwaittime = 0.5;
  grenadetype = "molotov_mp";
  grenades = 8;
  nextgrenadetime = gettime();
  scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(self, "throwingScriptGrenade", 0);
  scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, undefined, grenadetype, grenades);
  level thread function_d3f59232689f12a0(agent);

  while(true) {
    if(gettime() >= nextgrenadetime) {
      if(!isDefined(agent.enemy)) {
        wait standardwaittime;
        continue;
      }

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) > 1048576 || isDefined(self.pathgoalpos)) {
        wait standardwaittime;
        continue;
      }

      disttoenemy = distancesquared(agent.origin, agent.enemy.origin);

      if(disttoenemy < 65536 || disttoenemy > 2250000) {
        wait standardwaittime;
        continue;
      }

      if(!agent cansee(agent.enemy)) {
        wait standardwaittime;
        continue;
      }

      starttrace = agent.origin;
      endtrace = starttrace + (0, 0, 128);
      trace = scripts\engine\trace::ray_trace(starttrace, endtrace, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait standardwaittime;
        continue;
      }

      starttrace = agent.origin + (0, 0, 100);
      vect = vectorNormalize(agent.enemy.origin - starttrace);
      vect = (vect[0], vect[1], 0) + (0, 0, 1);
      endtrace = starttrace + vect * 1000;
      trace = scripts\engine\trace::ray_trace(starttrace, endtrace, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait standardwaittime;
        continue;
      }

      agent thread function_ae99616202575e39(agent.enemy.origin, grenadetype, 64);
      nextgrenadetime = gettime() + randomintrange(2, 3) * 1000;
      grenades--;
    }

    if(grenades == 0) {
      return;
    }

    wait standardwaittime;
  }
}

function function_d3f59232689f12a0(agent) {
  agent waittill("death", killer, meansofdeath);
  var_c524724829b57a7e = agent doinglongdeath();

  if(!var_c524724829b57a7e && scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "throwingScriptGrenade")) {
    right = anglestoright(agent.angles);
    grenadelocation = agent.origin + anglesToForward(agent.angles) * 5 + right * 20 + (0, 0, 60);
    throwvect = (0, 0, 200) + right * randomfloatrange(-100, 100);
    grenade = agent launchgrenade("molotov_mp", grenadelocation, throwvect);
    grenade.var_88fe704adf00eadf = 1;
    grenade.owner = agent;
    wait 0.1;

    if(scripts\engine\utility::issharedfuncdefined("pyro", "molotov_used")) {
      agent thread[[scripts\engine\utility::getsharedfunc("pyro", "molotov_used")]](grenade);
    }

    wait 1;
    grenade notify("missile_stuck");
  }
}

function function_9ca698cdffe22968(agent, var_37d7c6423323a19e) {
  agent endon("death");
  agent endon("stop_throwing");
  standardwaittime = 0.5;
  grenadetype = "smoke_grenade_mp";
  grenades = 8;
  nextgrenadetime = gettime();
  scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(self, "throwingScriptGrenade", 0);

  if(!istrue(var_37d7c6423323a19e)) {
    agent.baseaccuracy = getdvarfloat(@ "hash_8aa5313ca3f3737f", 1.1);
    armor = 500;
    helmet = level.var_6855c201495094b6["tier3"];
    weapon = scripts\cp_mp\weapon::buildweapon("iw9_ar_mike4_mp", ["laserbox_hip04", "none", "none", "none", "silencer01_ar", "none"], "none", "none");
  } else {
    armor = undefined;
    helmet = undefined;
    weapon = undefined;
  }

  scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, weapon, grenadetype, grenades, armor, helmet);

  if(!istrue(var_37d7c6423323a19e)) {
    agent laseron();
  }

  var_54a2636d2994800f = 75;
  var_3af61c217d8e61b = 15000;
  var_a08068bfbcf2dde = undefined;

  while(true) {
    if(isDefined(agent.enemy) && !isDefined(var_a08068bfbcf2dde) && agent cansee(agent.enemy)) {
      var_a08068bfbcf2dde = gettime();

      if(randomint(100) < var_54a2636d2994800f) {
        magicgrenademanual("smoke_grenade_mp", agent.origin, (0, 0, -10), 0.5);
        thread play_sound_in_space("smoke_grenade_expl_trans", agent.origin);
      }

      nextgrenadetime = gettime() + randomintrange(2, 5) * 1000;
    } else if(!isDefined(agent.enemy) && isDefined(var_a08068bfbcf2dde) && var_a08068bfbcf2dde + var_3af61c217d8e61b < gettime()) {
      var_a08068bfbcf2dde = undefined;
    }

    if(gettime() >= nextgrenadetime) {
      if(!isDefined(agent.enemy)) {
        wait standardwaittime;
        continue;
      }

      if(isDefined(agent getinteractionid())) {
        wait standardwaittime;
        continue;
      }

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) > 1048576 || isDefined(self.pathgoalpos)) {
        wait standardwaittime;
        continue;
      }

      disttoenemy = distancesquared(agent.origin, agent.enemy.origin);

      if(disttoenemy < 16384 || disttoenemy > 1960000) {
        wait standardwaittime;
        continue;
      }

      if(!agent cansee(agent.enemy)) {
        wait standardwaittime;
        continue;
      }

      starttrace = agent.origin;
      endtrace = starttrace + (0, 0, 128);
      trace = scripts\engine\trace::ray_trace(starttrace, endtrace, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait standardwaittime;
        continue;
      }

      starttrace = agent.origin + (0, 0, 100);
      vect = vectorNormalize(agent.enemy.origin - starttrace);
      vect = (vect[0], vect[1], 0) + (0, 0, 1);
      endtrace = starttrace + vect * 1000;
      trace = scripts\engine\trace::ray_trace(starttrace, endtrace, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait standardwaittime;
        continue;
      }

      toenemy = vectorNormalize(agent.enemy.origin - agent.origin);
      disttoenemy = sqrt(disttoenemy);
      halfdist = disttoenemy / 2;
      targetorigin = agent.origin + toenemy * halfdist + (0, 0, 32);
      agent thread function_ae99616202575e39(targetorigin, grenadetype, 128);
      nextgrenadetime = gettime() + randomintrange(2, 5) * 1000;
      grenades--;
    }

    if(grenades == 0) {
      return;
    }

    wait standardwaittime;
  }
}

function turnonlaser() {
  wait 1;

  while(true) {
    self laseron();
    wait 3;
    self laseroff();
    wait 3;
  }
}

function function_ae99616202575e39(targetorigin, grenadetype, offsetdist) {
  self endon("death");
  scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(self, "throwingScriptGrenade", 1);

  if(isDefined(offsetdist)) {
    offsetdist = min(abs(offsetdist), 256);
    targetorigin += (randomfloatrange(-1 * offsetdist, offsetdist), randomfloatrange(-1 * offsetdist, offsetdist), randomfloatrange(-1 * offsetdist, offsetdist));
  }

  [animname, var_7adb38055d0917f, offsetvect] = function_cf56c061947ef668(self.origin, targetorigin);
  [launchpos, throwvect] = function_a615009e6466353a(self, targetorigin, grenadetype, offsetvect);
  self.var_ca01d1496480b62c = targetorigin;
  self.var_624efed57c34c807 = throwvect;
  function_4cb4bb1cff15b987();
  self.var_ca01d1496480b62c = undefined;
  self.var_624efed57c34c807 = undefined;
}

function function_4cb4bb1cff15b987() {
  timeoutnotify = "ai_forceThrowGrenade_timeout";
  finishnotify = "ai_forceThrowGrenade_finish";
  ctimeout = 6;
  self endon(timeoutnotify);
  childthread function_d34200a799950385(ctimeout, timeoutnotify, finishnotify);

  while(!istrue(self.isholdinggrenade) && isDefined(self.var_ca01d1496480b62c)) {
    waitframe();
  }

  scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(self, "throwingScriptGrenade", 1);

  while(istrue(self.isholdinggrenade) && isDefined(self.var_ca01d1496480b62c)) {
    waitframe();
  }

  scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(self, "throwingScriptGrenade", 0);
  self notify(finishnotify);
}

function function_d34200a799950385(t, notifyname, endonname) {
  self endon(endonname);
  wait t;
  self notify(notifyname);
}

function private function_e4e4fefd625a2580(agent) {
  if(isDefined(agent.node)) {
    assert(isDefined(agent.node.angles));
    return anglesToForward(agent.node.angles);
  }

  return anglesToForward(agent.angles);
}

function function_a615009e6466353a(thrower, targetorigin, grenadetype, var_55fba01075efacdb) {
  offset = (0, 0, 100);

  if(isDefined(var_55fba01075efacdb)) {
    offset = var_55fba01075efacdb;
  }

  launchpos = thrower.origin + offset;
  throwvect = targetorigin - launchpos;
  throwvect = vectorNormalize(throwvect);
  throwvect = (throwvect[0], throwvect[1], 0) + (0, 0, 1);
  dist = distance2d(launchpos, targetorigin);
  throwvect = throwvect * dist * function_1bc68105415d304(grenadetype, dist);
  return [launchpos, throwvect];
}

function function_ee72700f22a0e304(thrower, grenadetype) {}

function private function_1bc68105415d304(grenade_type, distancetotarget) {
  switch (grenade_type) {
    case #"hash_5e4ccaa178cac19c":
      return 0.75;
    case #"hash_4cd748aa3895508a":
      return 600;
    case #"hash_ab3485fa6834de47":
      if(isDefined(distancetotarget) && distancetotarget < 512) {
        return 0.8;
      }

      return 0.6;
    case #"hash_34e7a4cd11aed6bc":
      return 180;
    default:
      return 0.6;
  }
}

function function_cf56c061947ef668(sourceorigin, targetorigin) {
  var_6647d06f6e45486c = distance2dsquared(self.origin, targetorigin);

  if(var_6647d06f6e45486c < 262144) {
    return ["grenade_throw_short", 0.6, (0, 10, 50)];
  } else {
    return ["grenade_throw", 0.5, (0, 0, 100)];
  }

  return ["grenade_throw", 0.5, (0, 0, 100)];
}

function function_13812f40f38587c4(agenttype, origin, dormancyid) {
  infopackage = function_2b0e82156fa6075b(dormancyid);
  function_760792071513b00d(dormancyid);

  if(!isDefined(infopackage)) {
    println("<dev string:x1c>");
    return;
  }

  aitype = infopackage.aitype;
  origin = infopackage.origin;
  angles = infopackage.angles;
  priority = function_72d6808216b4d44(infopackage.priority);
  category = infopackage.category;
  subcategory = infopackage.subcategory;
  groupname = infopackage.groupname;
  team = function_30a0d7ca3fae40cc(undefined, infopackage.aitype);
  destination = undefined;
  poiname = infopackage.poi;
  skipstealth = infopackage.skipstealth;
  behaviorpackage = infopackage.behaviorpackage;
  var_80f4bde7090a4773 = infopackage.var_80f4bde7090a4773;
  spawnfunctions = infopackage.functionsonspawn;
  agentstruct = infopackage.agentstruct;
  threatbiasgroup = infopackage.threatbiasgroup;
  var_8a76b06617613d30 = getsharedfunc("ai_mp_controller", "ai_mp_requestSpawnAgent");
  agent = [[var_8a76b06617613d30]](aitype, origin, angles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, 1, undefined, var_80f4bde7090a4773, undefined, undefined, threatbiasgroup);

  if(isDefined(agent)) {
    agent.behaviorpackage = behaviorpackage;
    function_3ea1225bf6192343(agent, agentstruct);
    behavior_executebehaviorpackage = getsharedfunc("ai_mp_controller", "behavior_executeBehaviorPackage");
    [[behavior_executebehaviorpackage]](agent);
    agent.functionsonspawn = spawnfunctions;
    function_e662189d61d1874e(agent);
    return;
  }

  if(isDefined(agentstruct)) {
    if(isDefined(agentstruct.group)) {
      [[agentstruct.var_9e729433fd479f19]](agentstruct, dormancyid);
      return;
    }

    if(isDefined(level.var_59cffb78293fe83c) && isDefined(level.var_59cffb78293fe83c.var_9e729433fd479f19)) {
      [[level.var_59cffb78293fe83c.var_9e729433fd479f19]](agentstruct, dormancyid);
    }
  }
}

function function_9fa011b7807309a8(agent, dormancyid) {
  aitype = agent.agent_type;
  origin = agent.origin;
  angles = agent.angles;
  priority = agent.priority;
  category = agent.category;
  subcategory = agent.subcategory;
  groupname = agent.script_stealthgroup;
  destination = undefined;
  poiname = agent.poi;
  team = agent.team;
  skipstealth = !agent.stealth_enabled;
  behaviorpackage = agent.behaviorpackage;
  var_80f4bde7090a4773 = agent.var_80f4bde7090a4773;
  spawnfunctions = agent.functionsonspawn;
  agentstruct = function_12ee2283db699727(agent);

  if(isDefined(behaviorpackage) && behaviorpackage.behavior == "cqb" && isDefined(behaviorpackage.cqbnodes)) {
    foreach(node in behaviorpackage.cqbnodes) {
      if(isDefined(node)) {
        node.claimed = 0;
      }
    }
  }

  infopackage = function_e83d1f023a2609ff(aitype, origin, angles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, behaviorpackage, var_80f4bde7090a4773, spawnfunctions, agentstruct);
  function_7a9172605e0228df(dormancyid, infopackage);
  subarea_findandassignfordormancyid = getsharedfunc("ai_mp_controller", "subArea_findAndAssignForDormancyID");
  [[subarea_findandassignfordormancyid]](origin, poiname, destination, dormancyid);
  priority_setbydormancyid = getsharedfunc("ai_mp_controller", "priority_setByDormancyId");
  [[priority_setbydormancyid]](dormancyid, priority);
  var_58f203b26c3a3f8a = getsharedfunc("ai_mp_controller", "ai_registerAgent");
  [[var_58f203b26c3a3f8a]](dormancyid, category, subcategory, poiname);

  if(isDefined(agentstruct)) {
    if(isDefined(agentstruct.group)) {
      [[agentstruct.var_90ccd093de8c8c55]](agent, dormancyid);
      return;
    }

    if(isDefined(level.var_59cffb78293fe83c) && isDefined(level.var_59cffb78293fe83c.var_90ccd093de8c8c55)) {
      [[level.var_59cffb78293fe83c.var_90ccd093de8c8c55]](agent, dormancyid);
    }
  }
}

function function_b6131256ee347e8d(priority) {
  if(isint(priority)) {
    return ter_op(priority < 0, 0, ter_op(priority > 5, 5, priority));
  }

  switch (tolower(priority)) {
    case #"hash_c49f372eec1c61c":
      return 1;
    case #"hash_7e89154a96f625d":
      return 2;
    case #"hash_c71b112fe04823d6":
      return 3;
    case #"hash_2f27546c22430661":
      return 4;
    case #"hash_1de65f6f9597841f":
      return 5;
    default:
      return 5;
  }
}

function function_72d6808216b4d44(importance) {
  switch (importance) {
    case 1:
      return "absolute";
    case 2:
      return "high";
    case 3:
      return "medium";
    case 4:
      return "low";
    case 5:
      return "filler";
    default:
      return "filler";
  }
}

function function_e2fa9b378bbf03a6(aitype, origin, angles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, behaviorpackage, threatbiasgroup) {
  priority = function_b6131256ee347e8d(priority);
  infopackage = function_e83d1f023a2609ff(aitype, origin, angles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, behaviorpackage, undefined, undefined, undefined, threatbiasgroup);
  dormancyid = function_4476b9b75cb95d99(origin, aitype, priority);
  assert(dormancyid >= 0, "We've run out of dormancy IDs!");
  function_7a9172605e0228df(dormancyid, infopackage);
  return dormancyid;
}

function function_b04c0433e8107615() {
  level.var_74e9c02b56e4ba52 = &function_13812f40f38587c4;
  level.var_8a42b71f799936ad = &function_9fa011b7807309a8;
  level.var_fe093e9b2b6c3751 = getdvarint(@ "hash_320c4db6af00b215", 0);
  level.var_53db9bacadef066d = spawnStruct();
  level.var_53db9bacadef066d.var_d4053e1a1d2983ce = 0;
  level.var_879053468f168806 = [];
}

function function_e83d1f023a2609ff(aitype, origin, angles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, behaviorpackage, var_80f4bde7090a4773, spawnfunctions, agentstruct, threatbiasgroup) {
  infopackage = spawnStruct();
  infopackage.aitype = aitype;
  infopackage.origin = origin;
  infopackage.angles = angles;
  infopackage.priority = function_b6131256ee347e8d(priority);
  infopackage.category = category;
  infopackage.subcategory = subcategory;
  infopackage.groupname = groupname;
  infopackage.team = team;
  infopackage.destination = destination;
  infopackage.poi = poiname;
  infopackage.skipstealth = skipstealth;
  infopackage.behaviorpackage = behaviorpackage;
  infopackage.var_80f4bde7090a4773 = var_80f4bde7090a4773;
  infopackage.functionsonspawn = spawnfunctions;
  infopackage.agentstruct = agentstruct;
  infopackage.threatbiasgroup = threatbiasgroup;
  return infopackage;
}

function function_7a9172605e0228df(dormancyid, infopackage) {
  level.var_879053468f168806[dormancyid] = infopackage;
}

function function_2b0e82156fa6075b(dormancyid) {
  return level.var_879053468f168806[dormancyid];
}

function function_b27fe8a834c5edda() {
  assert(isDefined(level.var_879053468f168806));
  return level.var_879053468f168806.size;
}

function function_3b45c895d8d984ee() {
  if(!isDefined(level.var_88655f45c7beb22a)) {
    level.var_88655f45c7beb22a = getdvarint(@ "hash_ee8cf30f1e199e42", 200) - 1;
  }

  return level.var_88655f45c7beb22a;
}

function function_4e065f1747aadd51(dormancyid, category) {
  cleardormantaientry(dormancyid);
  infopackage = function_2b0e82156fa6075b(dormancyid);

  if(istrue(level.var_45ca3cfb9dca4f97)) {
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(infopackage.origin, 64, 500, (1, 0, 0));
  }

  if(isDefined(infopackage) && isDefined(infopackage.agentstruct)) {
    if(isDefined(infopackage.agentstruct.group)) {
      [[infopackage.agentstruct.ondeath]](dormancyid);
    } else if(isDefined(level.var_59cffb78293fe83c) && isDefined(level.var_59cffb78293fe83c.ondeath)) {
      [[level.var_59cffb78293fe83c.ondeath]](dormancyid);
    }
  }

  function_760792071513b00d(dormancyid);
}

function function_760792071513b00d(dormancyid, category) {
  if(!isDefined(category)) {
    category = function_2b0e82156fa6075b(dormancyid).poi;
  }

  priorityfunc = getsharedfunc("ai_mp_controller", "priority_removeByDormancyId");
  [[priorityfunc]](dormancyid);
  deregisterfunc = getsharedfunc("ai_mp_controller", "ai_deregisterAgent");
  [[deregisterfunc]](dormancyid, category);
  subarea = level.var_879053468f168806[dormancyid].subarea;

  if(isDefined(subarea)) {
    var_589fe1386325a0cc = getsharedfunc("ai_mp_controller", "subArea_removeAgentFrom");
    [[var_589fe1386325a0cc]](dormancyid, subarea);
  }

  level.var_879053468f168806[dormancyid] = undefined;
}

function function_e662189d61d1874e(agent) {
  if(!isagent(agent)) {
    return;
  }

  if(isDefined(agent.functionsonspawn)) {
    for(i = 0; i < 24; i++) {
      var_964917a4edc12525 = 1 << i;

      if(var_964917a4edc12525 > agent.functionsonspawn) {
        break;
      }

      if((agent.functionsonspawn &var_964917a4edc12525) == var_964917a4edc12525) {
        agent thread[[level.var_5dbbd87fd9e2457f[i]]](agent);
      }
    }
  }
}

function function_58aab2edaec2599f(agent, functionstring, function) {
  if(!isDefined(function) || !isfunction(function) || !isDefined(agent) || !isDefined(functionstring) || !isstring(functionstring)) {
    return;
  }

  function_a1acc0cc2a3cfeaa(functionstring, function);

  if(isagent(agent)) {
    if(!isDefined(agent.functionsonspawn)) {
      agent.functionsonspawn = 0;
    }

    agent.functionsonspawn |= 1 << level.var_8cfccf3b774f4458[functionstring].index;
    return;
  }

  if(isint(agent)) {
    if(!isDefined(level.var_879053468f168806[agent].functionsonspawn)) {
      level.var_879053468f168806[agent].functionsonspawn = 0;
    }

    level.var_879053468f168806[agent].functionsonspawn |= 1 << level.var_8cfccf3b774f4458[functionstring].index;
  }
}

function function_97fbd14bbcf19d9c(agent, functionstring, function) {
  if(!isDefined(function) || !isfunction(function) || !isDefined(agent) || !isDefined(functionstring) || !isstring(functionstring)) {
    return;
  }

  function_a1acc0cc2a3cfeaa(functionstring, function);

  if(isagent(agent)) {
    if(!isDefined(agent.functionsonspawn)) {
      agent.functionsonspawn = 0;
    } else {
      agent.functionsonspawn &= ~(1 << level.var_8cfccf3b774f4458[functionstring].index);
    }

    return;
  }

  if(isint(agent) && isDefined(level.var_879053468f168806[agent])) {
    if(!isDefined(level.var_879053468f168806[agent].functionsonspawn)) {
      level.var_879053468f168806[agent].functionsonspawn = 0;
      return;
    }

    level.var_879053468f168806[agent].functionsonspawn &= ~(1 << level.var_8cfccf3b774f4458[functionstring].index);
  }
}

function private function_a1acc0cc2a3cfeaa(functionstring, function) {
  if(!isDefined(level.var_8cfccf3b774f4458)) {
    level.var_8cfccf3b774f4458 = [];
  }

  if(!isDefined(level.var_5dbbd87fd9e2457f)) {
    level.var_5dbbd87fd9e2457f = [];
  }

  if(!isDefined(level.var_8cfccf3b774f4458[functionstring])) {
    funcstruct = spawnStruct();
    funcstruct.func = function;
    funcstruct.index = level.var_8cfccf3b774f4458.size;
    assert(funcstruct.index < 24, "There are more than 24 dormancy functions. We've run out of bits!");
    level.var_8cfccf3b774f4458[functionstring] = funcstruct;
  }

  index = level.var_8cfccf3b774f4458[functionstring].index;

  if(!isDefined(level.var_5dbbd87fd9e2457f[index])) {
    level.var_5dbbd87fd9e2457f[index] = function;
  }
}

function function_f3d88b5d7353a90(array, agent) {
  newarray = [];

  foreach(item in array) {
    if(isagent(agent) && isagent(item) && agent != item) {
      newarray[newarray.size] = item;
      continue;
    }

    if(isagent(agent) && isint(item) || isint(agent) && isagent(item)) {
      newarray[newarray.size] = item;
      continue;
    }

    if(isint(agent) && isint(item) && agent != item) {
      newarray[newarray.size] = item;
    }
  }

  return newarray;
}

function agent_sethealth(health) {
  self.health = health;
  self.maxhealth = health;
}

function function_3ea1225bf6192343(agent, struct) {
  if(isagent(agent)) {
    agent.agentstruct = struct;
    agentpers_setagentpersdata(agent, "agentStruct", struct);
    return;
  }

  if(isint(agent)) {
    info = function_2b0e82156fa6075b(agent);

    if(isDefined(info)) {
      info.agentstruct = struct;
    }
  }
}

function function_12ee2283db699727(agent) {
  if(isagent(agent)) {
    return agentpers_getagentpersdata(agent, "agentStruct");
  }

  if(isint(agent)) {
    info = function_2b0e82156fa6075b(agent);
    return info.agentstruct;
  }
}

function function_a09756b37f2e0681() {
  level.var_6855c201495094b6 = [];
  level.var_6855c201495094b6["tier2"] = getdvarint(@ "hash_7e5512406a54dd39", 1);
  level.var_6855c201495094b6["tier3"] = getdvarint(@ "hash_7e5511406a54db06", 3);
  level.var_6855c201495094b6["jugg"] = getdvarint(@ "hash_bc69c0296b829cc6", 10);
  level.var_9f0b40fbeb9cdde2 = [];
  level.var_9f0b40fbeb9cdde2["ar"] = [];
  level.var_9f0b40fbeb9cdde2["ar"]["maxfaceenemydist"] = 400;
  level.var_9f0b40fbeb9cdde2["ar"]["maxfacenewenemydist"] = 80;
  level.var_9f0b40fbeb9cdde2["lmg"] = [];
  level.var_9f0b40fbeb9cdde2["lmg"]["maxfaceenemydist"] = 512;
  level.var_9f0b40fbeb9cdde2["lmg"]["maxfacenewenemydist"] = 80;
  level.var_9f0b40fbeb9cdde2["shotgun"] = [];
  level.var_9f0b40fbeb9cdde2["shotgun"]["maxfaceenemydist"] = 80;
  level.var_9f0b40fbeb9cdde2["shotgun"]["maxfacenewenemydist"] = 16;
  level.var_9f0b40fbeb9cdde2["smg"] = [];
  level.var_9f0b40fbeb9cdde2["smg"]["maxfaceenemydist"] = 320;
  level.var_9f0b40fbeb9cdde2["smg"]["maxfacenewenemydist"] = 32;
  level.var_9f0b40fbeb9cdde2["sniper"] = [];
  level.var_9f0b40fbeb9cdde2["sniper"]["maxfaceenemydist"] = 32;
  level.var_9f0b40fbeb9cdde2["sniper"]["maxfacenewenemydist"] = 50;
  level.var_9f0b40fbeb9cdde2["rpg"] = [];
  level.var_9f0b40fbeb9cdde2["rpg"]["maxfaceenemydist"] = 32;
  level.var_9f0b40fbeb9cdde2["rpg"]["maxfacenewenemydist"] = 50;
  level.var_9f0b40fbeb9cdde2["firebug"] = [];
  level.var_9f0b40fbeb9cdde2["firebug"]["maxfaceenemydist"] = 320;
  level.var_9f0b40fbeb9cdde2["firebug"]["maxfacenewenemydist"] = 32;
  level.var_9f0b40fbeb9cdde2["jugg"] = [];
  level.var_9f0b40fbeb9cdde2["jugg"]["maxfaceenemydist"] = 2048;
  level.var_9f0b40fbeb9cdde2["jugg"]["maxfacenewenemydist"] = 512;
  level.var_d0f9a08690a8075 = [];
  level.var_d0f9a08690a8075[0] = getdvarint(@ "hash_9f60e77c0e91da76", -1);
  level.var_d0f9a08690a8075[1] = getdvarint(@ "hash_9f60e67c0e91d843", -1);
  level.var_d0f9a08690a8075[2] = getdvarint(@ "hash_9f60e57c0e91d610", -1);
  function_468420ffd9205765(getdvarint(@ "hash_39fe1e5fe7d89e6e", 8) * 1000);
  function_9f617bb5cf59dbf0(getdvarint(@ "hash_fa88bd128990512b", 200));
}

function function_77b8b5af85f319d8(valuearray) {
  if(isDefined(valuearray["maxfaceenemydist"])) {
    self.maxfaceenemydist = valuearray["maxfaceenemydist"];
  }

  if(isDefined(valuearray["maxfacenewenemydist"])) {
    self.maxfacenewenemydist = valuearray["maxfacenewenemydist"];
  }

  if(isDefined(valuearray["maxengagementdist"]) && isDefined(valuearray["maxengagementfalloff"])) {
    self setengagementmaxdist(valuearray["maxengagementdist"], valuearray["maxengagementfalloff"]);
  }

  if(isDefined(valuearray["minengagementdist"]) && isDefined(valuearray["minengagementfalloff"])) {
    self setengagementmindist(valuearray["minengagementdist"], valuearray["minengagementfalloff"]);
  }

  if(isDefined(valuearray["maxengagementshootdist"])) {
    self function_9215ce6fc83759b9(valuearray["maxengagementshootdist"]);
  }
}

function function_223455a2aefd83e4() {
  for(i = 0; i < level.players.size; i++) {
    self getenemyinfo(level.players[i]);
  }
}

function gethealthmax(aitype) {
  if(!isDefined(aitype)) {
    return;
  }

  if(issubstr(aitype, "tier1")) {
    return level.var_d0f9a08690a8075[0];
  }

  if(issubstr(aitype, "tier2")) {
    return level.var_d0f9a08690a8075[1];
  }

  if(issubstr(aitype, "tier3")) {
    return level.var_d0f9a08690a8075[2];
  }
}

function function_6f88796d2f078da4(aigroup, aileaders, squadleaderfunc) {
  squadleader = random(aigroup);

  if(isDefined(aileaders)) {
    if(isarray(aileaders)) {
      squadleader = random(aileaders);
    } else {
      squadleader = aileaders;
    }
  }

  if(isDefined(squadleaderfunc)) {
    level thread[[squadleaderfunc]](squadleader);
  }

  if(getdvarint(@ "squad_debug", 0) > 0) {
    squadleader hudoutlineenable("<dev string:x6f>");
  }

  while(true) {
    var_53e80078572723e9 = 0;

    foreach(ai in aigroup) {
      if(!isalive(ai) || ai.health < 1) {
        continue;
      }

      var_53e80078572723e9 = 1;
    }

    if(!var_53e80078572723e9) {
      return;
    }

    if(isDefined(squadleader) && isalive(squadleader)) {
      foreach(ai in aigroup) {
        if(!isDefined(ai)) {
          continue;
        }

        if(ai == squadleader) {
          continue;
        }

        if(!isalive(ai) || ai.health < 1) {
          continue;
        }

        if(!isDefined(ai.goalent) || ai.goalent != squadleader) {
          if(getDvar(@ "squad_debug") != "<dev string:x85>") {
            ai hudoutlineenable("<dev string:x86>");
          }

          ai setgoalentity(squadleader);
          ai.goalent = squadleader;
        }

        var_84031f98354ed18 = 0;
        players = level.players;

        if(function_a794fcf9545f2062()) {
          team = ai.team;
          players = getentitiesinradiusfrompartitiongrid(squadleader.origin, squadleader.goalradius, createentitytypemask(["etype_player"]), [], team);

          if(players.size) {
            var_84031f98354ed18 = 1;
          }
        } else {
          foreach(player in players) {
            if(distance2dsquared(squadleader.origin, player.origin) < squared(squadleader.goalradius)) {
              var_84031f98354ed18 = 1;
            }
          }
        }

        ai.goalradius = 256;

        if(var_84031f98354ed18 || distance2dsquared(squadleader.origin, ai.origin) < squared(ai.goalradius)) {
          if(distance2dsquared(squadleader.origin, ai.origin) < squared(ai.goalradius)) {
            ai.goalradius = 1200;
          }
        }
      }
    } else {
      aigroup = array_removeundefined(aigroup);

      if(!aigroup.size) {
        return;
      }

      squadleader = random(aigroup);

      if(isDefined(aileaders)) {
        alive = 0;

        foreach(guy in aileaders) {
          if(!isalive(guy) || guy.health < 1) {
            continue;
          }

          alive = 1;
        }

        if(alive) {
          if(isarray(aileaders)) {
            squadleader = random(aileaders);
          } else {
            squadleader = aileaders;
          }
        }
      }

      if(getDvar(@ "squad_debug") != "<dev string:x85>") {
        squadleader hudoutlineenable("<dev string:x6f>");
      }

      if(isDefined(squadleaderfunc)) {
        level thread[[squadleaderfunc]](squadleader);
      }
    }

    wait 1;
  }
}

function function_e942bea168527f6(trigger) {
  enabled = getdvarint(@ "hash_3d2d2d527cf543f9", 1);

  if(!enabled) {
    return;
  }

  if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
    [[getsharedfunc("game", "makeEnterExitTrigger")]](trigger, &function_3739410667dca712, &function_9643c9b25f0e0c84);
  }
}

function function_3739410667dca712(soldier, trigger) {
  if(!isagent(soldier)) {
    return;
  }

  if(!isalive(soldier)) {
    return;
  }

  if(istrue(soldier.var_ed331803db44891b)) {
    soldier.var_e1b2653a504955e9 = 1;
    soldier allowedstances("stand");
  }

  if(function_f0cb3329588d4015(soldier)) {
    return;
  }

  soldier.var_d1c85ffae04d3ae0 = spawnStruct();
  soldier.var_d1c85ffae04d3ae0.default_arch = soldier getbasearchetype();
  soldier.var_d1c85ffae04d3ae0.allowlongdeath = soldier.allowlongdeath;
  var_2186ab5345fa2b64 = "soldier_water";

  if(soldier.var_d1c85ffae04d3ae0.default_arch == "juggernaut") {
    var_2186ab5345fa2b64 = "juggernaut_water";
  }

  soldier setoverridearchetype("default", var_2186ab5345fa2b64, 0);
  soldier.allowlongdeath = 0;
}

function function_9643c9b25f0e0c84(soldier, trigger) {
  if(!isagent(soldier)) {
    return;
  }

  if(!isalive(soldier)) {
    return;
  }

  if(istrue(soldier.var_e1b2653a504955e9)) {
    soldier allowedstances("crouch", "stand");
  }

  if(function_f0cb3329588d4015(soldier)) {
    return;
  }

  archtoset = "soldier";

  if(isDefined(soldier.var_d1c85ffae04d3ae0) && isDefined(soldier.var_d1c85ffae04d3ae0.default_arch)) {
    archtoset = soldier.var_d1c85ffae04d3ae0.default_arch;
  }

  soldier setoverridearchetype("default", archtoset, 0);

  if(isDefined(soldier.var_d1c85ffae04d3ae0) && isDefined(soldier.var_d1c85ffae04d3ae0.allowlongdeath)) {
    soldier.allowlongdeath = soldier.var_d1c85ffae04d3ae0.allowlongdeath;
  }
}

function function_f0cb3329588d4015(soldier) {
  enabled = getdvarint(@ "hash_cb527a1b28e21dfd", 0);

  if(!enabled) {
    return false;
  }

  arch = soldier getbasearchetype();

  if(arch == "juggernaut") {
    return false;
  }

  return true;
}

function function_30a0d7ca3fae40cc(nationality, agent_type) {
  if(isDefined(nationality)) {
    switch (nationality) {
      case #"hash_fa18d1f6bd5790c7":
        return "team_hundred_ninety_five";
      case #"hash_3931080a2ee4d716":
      case #"hash_fa24c0f6bd607060":
      case #"hash_fa53bdf6bd853c80":
        return "team_hundred_ninety_four";
      case #"hash_4bc0839e1ade7b30":
        return "team_hundred_ninety_seven";
      case #"hash_8915246c51a3d9ff":
        return "team_hundred_ninety_eight";
      case #"hash_19b89634f50eeda4":
        return "team_hundred_ninety_nine";
    }
  }

  if(!isDefined(nationality)) {
    if(issubstr(agent_type, "_aq")) {
      return "team_hundred_ninety_five";
    }

    if(issubstr(agent_type, "_ru") || issubstr(agent_type, "_mx") || issubstr(agent_type, "_cartel")) {
      return "team_hundred_ninety_four";
    }

    if(issubstr(agent_type, "_biolab")) {
      return "team_hundred_ninety_seven";
    }

    if(issubstr(agent_type, "_pmc")) {
      return "team_hundred_ninety_eight";
    }

    if(issubstr(agent_type, "_merc")) {
      return "team_hundred_ninety_nine";
    }

    return "team_hundred_ninety_five";
  }
}

function function_9a024cd909d6e0a3(func) {
  if(!isDefined(level.var_8c2b0fd37157f872)) {
    level.var_8c2b0fd37157f872 = [];
  }

  level.var_8c2b0fd37157f872 = array_add(level.var_8c2b0fd37157f872, func);
}

function function_8ca4e221673e423c() {
  map = [];

  foreach(arr in level.agent_definition) {
    if(isDefined(arr["subclass"])) {
      var_3edaf5784c67ba1d = arr["subclass"];
      map[var_3edaf5784c67ba1d.name] = default_to(map[var_3edaf5784c67ba1d.name], []);
      map[var_3edaf5784c67ba1d.name] = array_add(map[var_3edaf5784c67ba1d.name], aitype);
    }
  }

  return map;
}

function function_3290e192ac188e2d(subclass) {
  level.var_382c29cdfee879a = default_to(level.var_382c29cdfee879a, 0);

  if(!isDefined(level.var_c841584ec7126408) || level.var_382c29cdfee879a != level.agent_definition.size) {
    level.var_382c29cdfee879a = level.agent_definition.size;
    level.var_c841584ec7126408 = [];

    foreach(arr in level.agent_definition) {
      if(isDefined(arr["subclass"])) {
        subname = arr["subclass"].name;

        if(!isDefined(level.var_c841584ec7126408[subname])) {
          level.var_c841584ec7126408[subname] = [];
        }

        level.var_c841584ec7126408[subname][level.var_c841584ec7126408[subname].size] = aitype;
      }
    }
  }

  if(isDefined(level.var_c841584ec7126408[subclass])) {
    return level.var_c841584ec7126408[subclass];
  }

  return [];
}

function function_7056963336f2bbec(bnocorpse) {
  if(!isDefined(self.group)) {
    assertex(self.birthtime < gettime(), "<dev string:x9c>", "<dev string:xcd>", self.origin);
  } else {
    assertex(self.birthtime < gettime(), "<dev string:xcf>" + self.group.group_name, "<dev string:xcd>", self.origin);
  }

  if(self.birthtime >= gettime()) {
    waitframe();
  }

  if(istrue(bnocorpse)) {
    self.nocorpse = 1;
  }

  self.died_poorly = 1;
  self.died_poorly_health = self.health;
  self.var_f543095c3ca1b743 = 1;

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self kill();
}

function despawnagent() {
  function_7056963336f2bbec(1);
}

function getaverageorigin(ent_array) {
  avg_origin = (0, 0, 0);

  if(!ent_array.size) {
    return undefined;
  }

  foreach(ent in ent_array) {
    avg_origin += ent.origin;
  }

  avg_x = int(avg_origin[0] / ent_array.size);
  avg_y = int(avg_origin[1] / ent_array.size);
  avg_z = int(avg_origin[2] / ent_array.size);
  avg_origin = (avg_x, avg_y, avg_z);
  return avg_origin;
}

function function_9ec5f9cfc835208e() {
  if(scripts\engine\utility::issharedfuncdefined("dmz_threat_bias", "init")) {
    level thread[[scripts\engine\utility::getsharedfunc("dmz_threat_bias", "init")]]();
    return;
  }

  level thread function_b54b8baa376d3dbb();
}

function function_b54b8baa376d3dbb() {
  level.var_e354254e70a6b849 = [];
  level.var_e354254e70a6b849[level.var_e354254e70a6b849.size] = "hs";
  level.var_e354254e70a6b849[level.var_e354254e70a6b849.size] = "sc";
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("enemy");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("huntSquad");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("ai_phalanx");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("ai_black_mous");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("ai_white_lotus");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("player_hs0_sc0");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("player_hs1_sc0");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("player_hs0_sc1");
  scripts\cp_mp\agents\agent_utils::function_841f001ae930b5e4("player_hs1_sc1");
  function_3acce87fed325c8f("huntSquad", "enemy");
  function_3acce87fed325c8f("enemy", "huntSquad");
  function_3acce87fed325c8f("player_hs1_sc0", "huntSquad");
  function_3acce87fed325c8f("player_hs1_sc1", "huntSquad");
  var_55daed3b1eccb970 = getdvarint(@ "hash_4620216a9470ae72", -5000);
  function_b5ff3bfb184d0d01("enemy", "Drone", var_55daed3b1eccb970);
  function_b5ff3bfb184d0d01("huntSquad", "Drone", var_55daed3b1eccb970);

  if(scripts\engine\utility::issharedfuncdefined("dmz_threat_bias", "customNationality")) {
    level thread[[scripts\engine\utility::getsharedfunc("dmz_threat_bias", "customNationality")]]();
  }

  level thread function_255e967912274247();
}

function function_255e967912274247() {
  level waittill("matchStartTimer_done");

  foreach(player in level.players) {
    scripts\cp_mp\agents\agent_utils::function_3a458af8ab69f4e(player);
  }
}

function function_841f001ae930b5e4(group) {
  createthreatbiasgroup(group);
}

function function_58203c3739d2d0c6(agent, group, var_33d9708e7f06d603) {
  if(!isDefined(agent)) {
    return;
  }

  if(istrue(agent.var_daf4907411a07a6c)) {
    return;
  }

  if(isagent(agent)) {
    agent setthreatbiasgroup(group);
  } else if(isint(agent)) {
    package = function_2b0e82156fa6075b(agent);
    package.threatbiasgroup = group;
  }

  if(istrue(var_33d9708e7f06d603)) {
    agent.var_daf4907411a07a6c = 1;
  }
}

function function_ca2adce5c7865c20(player, group) {
  if(!isDefined(player)) {
    return;
  }

  player setthreatbiasgroup(group);
}

function function_b5ff3bfb184d0d01(groupa, groupb, bias) {
  if(!isDefined(groupa) || !isDefined(groupb)) {
    return;
  }

  if(!isDefined(bias)) {
    return;
  }

  setthreatbias(groupa, groupb, bias);
}

function function_3acce87fed325c8f(var_b3962262ba71d0ad, var_32a96bf508fbd2f) {
  if(!isDefined(var_b3962262ba71d0ad) || !isDefined(var_32a96bf508fbd2f)) {
    return;
  }

  setignoremegroup(var_b3962262ba71d0ad, var_32a96bf508fbd2f);
}

function function_46c0de7595d8cab2(player, group) {
  return player.var_c6f91882127b4281[group];
}

function function_ab491b16f8423c8e(player, group, status) {
  player.var_c6f91882127b4281[group] = status;
}

function function_ed5140c225d4f337(player) {
  groupname = "player";

  foreach(group in level.var_e354254e70a6b849) {
    groupname = groupname + "_" + group + function_46c0de7595d8cab2(player, group);
  }

  return groupname;
}

function function_3a458af8ab69f4e(player) {
  player.var_c6f91882127b4281 = [];

  foreach(group in level.var_e354254e70a6b849) {
    player.var_c6f91882127b4281[group] = 1;
  }

  startinggroup = function_ed5140c225d4f337(player);
  function_ca2adce5c7865c20(player, startinggroup);
}

function function_1bca33010b895b0b(nationality) {
  switch (nationality) {
    case #"hash_19b89634f50eeda4":
      return "sc";
  }
}
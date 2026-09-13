/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\agents\agent_utils.gsc
************************************************/

_id_DC01679146E5F53C(agent) {
  if(!isDefined(agent)) {
    return;
  }
  if(isint(agent)) {
    return;
  }
  agent._id_685390C6753C2CC7 = 1;
  body = undefined;
  head = undefined;
  weapon = undefined;
  _id_A664AAD02EE98BD2 = undefined;
  grenadeammo = 0;
  _id_7615A935CB1261EF = getdvarint("dvar_261E9CE11934FFAE", 50);

  if(randomintrange(0, 100) < _id_7615A935CB1261EF) {
    if(isDefined(level._id_39643776A698EFCE))
      _id_A664AAD02EE98BD2 = agent[[level._id_39643776A698EFCE]](1);
    else {
      _id_7E1FF9AFA225E8A1 = ["semtex_mp", "frag_grenade_mp", "gas_mp"];
      _id_A664AAD02EE98BD2 = scripts\engine\utility::random(_id_7E1FF9AFA225E8A1);
    }

    grenadeammo = getdvarint("dvar_31607C7B3BE624DF", 1);
  }

  armor = getdvarint("dvar_82AD0EAB483E9F5A", 0);
  agent._id_7CEA08B66B2AD878 = 0;
  helmet = undefined;
  agent _id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor);
  _id_350CF0DB9F5E0CBE(agent, "tier", 1);
  agent.baseaccuracy = getdvarfloat("dvar_8AA5333CA3F377E5", 0.66);
}

_id_198F5137D137E72F(agent, _id_80F4BDE7090A4773) {
  _id_DEC9BCCE93873125 = "agent_";
  _id_A25D9C067A51BCEE = "";

  if(issubstr(agent.agent_type, "jugg"))
    _id_A25D9C067A51BCEE = "jugg";
  else if(issubstr(agent.agent_type, "tier1"))
    _id_A25D9C067A51BCEE = "tier1";
  else if(issubstr(agent.agent_type, "tier2"))
    _id_A25D9C067A51BCEE = "tier2";
  else if(issubstr(agent.agent_type, "tier3"))
    _id_A25D9C067A51BCEE = "tier3";

  if(issubstr(agent.agent_type, "riotshield"))
    _id_A25D9C067A51BCEE = "riotshield";

  if(isDefined(_id_80F4BDE7090A4773) && tolower(_id_80F4BDE7090A4773) == "elite")
    _id_A25D9C067A51BCEE = "elite";

  _id_AA795F8C795AA60E = _id_DEC9BCCE93873125 + _id_A25D9C067A51BCEE;

  if(_id_A25D9C067A51BCEE == "") {
    return;
  }
  if(!threatbiasgroupexists(_id_AA795F8C795AA60E)) {
    createthreatbiasgroup(_id_AA795F8C795AA60E);
    _id_AD06BABCFFC3A43B(_id_AA795F8C795AA60E);
  }

  agent setthreatbiasgroup(_id_AA795F8C795AA60E);
}

_id_AD06BABCFFC3A43B(_id_AA795F8C795AA60E) {
  setthreatbias(_id_AA795F8C795AA60E, "Drone", getdvarint("dvar_4620216A9470AE72", -5000));

  if(issubstr(_id_AA795F8C795AA60E, "tier1"))
    return;
}

_id_DC016A9146E5FBD5(agent) {
  if(!isDefined(agent)) {
    return;
  }
  if(isint(agent)) {
    return;
  }
  agent._id_685390C6753C2CC7 = 1;
  body = undefined;
  head = undefined;
  weapon = undefined;

  if(isDefined(level._id_39643776A698EFCE))
    _id_A664AAD02EE98BD2 = agent[[level._id_39643776A698EFCE]](2);
  else {
    _id_7E1FF9AFA225E8A1 = ["semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "gas_mp", "decoy_grenade_mp"];
    _id_A664AAD02EE98BD2 = scripts\engine\utility::random(_id_7E1FF9AFA225E8A1);
  }

  grenadeammo = getdvarint("dvar_31607D7B3BE62712", 2);
  armor = getdvarint("dvar_82AD0DAB483E9D27", 100);
  agent._id_7CEA08B66B2AD878 = 1;
  helmet = level._id_6855C201495094B6["tier2"];
  agent _id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet);
  _id_350CF0DB9F5E0CBE(agent, "tier", 2);
  agent.baseaccuracy = getdvarfloat("dvar_8AA5303CA3F3714C", 0.9);
}

_id_DC01699146E5F9A2(agent, _id_6C149286380290A2) {
  if(!isDefined(agent)) {
    return;
  }
  if(isint(agent)) {
    return;
  }
  agent._id_282D867559C07771 = 1;
  body = undefined;
  head = undefined;
  weapon = undefined;

  if(isDefined(level._id_39643776A698EFCE))
    _id_A664AAD02EE98BD2 = agent[[level._id_39643776A698EFCE]](3);
  else {
    _id_7E1FF9AFA225E8A1 = ["thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp"];
    _id_A664AAD02EE98BD2 = scripts\engine\utility::random(_id_7E1FF9AFA225E8A1);
  }

  grenadeammo = getdvarint("dvar_31607E7B3BE62945", 4);
  armor = getdvarint("dvar_82AD0CAB483E9AF4", 250);
  agent._id_7CEA08B66B2AD878 = 2;
  helmet = level._id_6855C201495094B6["tier3"];
  agent _id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet);
  _id_350CF0DB9F5E0CBE(agent, "tier", 3);
  agent.baseaccuracy = getdvarfloat("dvar_8AA5313CA3F3737F", 1.3);
  agent._id_CBD87A0BC497B778 = 1;
}

_id_1828F1E20E52B418(agent, _id_84ECAEAB58167D39) {
  if(!isDefined(agent)) {
    return;
  }
  _id_EA83C1B372E16F6D(agent, "elite");

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
  agent._id_685390C6753C2CC7 = 1;

  if(!isDefined(_id_84ECAEAB58167D39)) {
    if(isDefined(agent._id_D1CF55B36FACF5A8) && isDefined(agent._id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1))
      _id_84ECAEAB58167D39 = agent._id_D1CF55B36FACF5A8._id_7DA9883D4168B7F1._id_84ECAEAB58167D39;

    if(!isDefined(_id_84ECAEAB58167D39))
      return;
  }

  [body, head, clothtype, _id_400EF51562606E7A] = _id_05CA105062AD7729(agent.agent_type, _id_84ECAEAB58167D39);
  armor = undefined;

  switch (_id_84ECAEAB58167D39) {
    case 3:
      armor = getdvarint("dvar_82AD0CAB483E9AF4", 250) + getdvarint("dvar_BE76A857CAF140EC", 100);
      break;
    case 2:
      armor = getdvarint("dvar_82AD0DAB483E9D27", 100) + getdvarint("dvar_BE76A857CAF140EC", 100);
      break;
    default:
      break;
  }

  agent _id_C37C4F9D687074FF(body, head, undefined, undefined, undefined, armor, undefined);

  if(isDefined(clothtype))
    agent setclothtype(clothtype);

  if(isDefined(_id_400EF51562606E7A))
    agent setclothtype(_id_400EF51562606E7A);

  _id_40E4760E91EBBFB8 = ["thermite_mp", "semtex_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "gas_mp"];
  _id_A664AAD02EE98BD2 = _id_BA0801276542946B(_id_40E4760E91EBBFB8);
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 3);
  agent.baseaccuracy = agent.baseaccuracy * getdvarfloat("dvar_54EAF02373DA456D", 2.0);
  agent _id_20381A5CA18027FF(int(agent.health * getdvarfloat("dvar_14FC69230FC4ED30", 1.33)));
  string = "MP_DMZ_MISSIONS/ELITE_GENERIC";
  _id_350CF0DB9F5E0CBE(agent, "elite", 1);
  rarity = undefined;

  switch (_id_84ECAEAB58167D39) {
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

  if(getdvarint("dvar_49B37FC622A4D585", 0) == 1)
    agent _meth_3DE79443C911D4A5(1, 3, string);
}

_id_05CA105062AD7729(_id_DCF5E15C58C4152A, _id_84ECAEAB58167D39) {
  switch (_id_84ECAEAB58167D39) {
    case 1:
      headmodel = scripts\engine\utility::random(["head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_grunt_var_01_civ_nohair", "head_sp_opforce_al_qatala_ar_2_1"]);
      clothtype = "flowing";
      _id_400EF51562606E7A = "strapsgr";
      return ["body_sp_opforce_al_qatala_tier_1_hardened_1_1", headmodel, clothtype, _id_400EF51562606E7A];
    case 2:
      clothtype = "vestlight";
      _id_400EF51562606E7A = "millghtgr";
      return ["body_sp_opforce_al_qatala_tier_2_hardened_1_1", undefined, clothtype, _id_400EF51562606E7A];
    case 3:
      clothtype = "vestheavy";
      _id_400EF51562606E7A = "milmedgr";
      return ["body_sp_opforce_al_qatala_tier_3_hardened_1_1", undefined, clothtype, _id_400EF51562606E7A];
  }

  return [undefined, undefined];
}

_id_E43F4000CAC35BA2(agent, weapon) {
  if(!isDefined(agent)) {
    return;
  }
  agent._id_7D606BEC79308EB5 = 1200;
  agent._id_85A0F6383A5DD784 = 512;
  agent.goalheight = 1000;
  agent._id_685390C6753C2CC7 = 0;

  if(scripts\common\utility::iscp()) {
    if(isDefined(level._id_96D46B3DE782E4E7))
      agent._id_7D606BEC79308EB5 = level._id_96D46B3DE782E4E7;
    else
      agent._id_7D606BEC79308EB5 = 512;

    if(isDefined(level._id_47247DECD7164A0E))
      agent._id_85A0F6383A5DD784 = level._id_47247DECD7164A0E;
    else
      agent._id_85A0F6383A5DD784 = 350;
  } else if(getDvar("dvar_7611A2790A0BF7FE", "br") == "dmz")
    _id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);

  if(getdvarint("dvar_60645EA7F5BB11F6", 1) == 1)
    agent._id_2D670E4D288C86FB = 1;
  else
    agent._id_2D670E4D288C86FB = 0;

  body = undefined;
  head = undefined;
  _id_A664AAD02EE98BD2 = _id_BA0801276542946B();
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 4);

  if(isDefined(level._id_5463147F04A33D36))
    armor = level._id_5463147F04A33D36;

  armor = 2500;
  helmethealth = getdvarint("dvar_4CEA285EE071705E", 2500);
  agent._id_895DAE193CFAAC3A = 1;
  agent _id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmethealth, 1);
  agent._id_98ADD129A7ECB962 = 0;
  agent.allowpain = 1;

  if(isDefined(level._id_87DEB8F6A4C7D50E))
    agent._id_2626D6897D71B728 = level._id_87DEB8F6A4C7D50E;

  agent._id_F2A62F02827DAAA5 = 1.0;
  agent.baseaccuracy = getdvarfloat("dvar_BF81930E3FF6D7EB", 1.2);
}

_id_C6EBE7215624D5A2(agent) {
  if(!isDefined(agent)) {
    return;
  }
  agent._id_2D670E4D288C86FB = 1;

  if(isDefined(agent.armorhealth) && agent.armorhealth > 0)
    agent.minpaindamage = int(agent.armorhealth / 2);

  agent enabletraversals(0);

  if(isDefined(level._id_719B61CA626125FF))
    agent._id_2626D6897D71B728 = level._id_719B61CA626125FF;

  agent.baseaccuracy = getdvarfloat("dvar_48F1EBB27EAA1ABB", 0.8);
}

_id_77FFE273EA3EC3A3(agent, _id_6C149286380290A2) {
  if(!isDefined(agent)) {
    return;
  }
  body = "body_mp_eastern_velikan_1_1";
  head = "head_mp_eastern_velikan_1_1";
  weapon = undefined;

  if(!istrue(_id_6C149286380290A2))
    weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_lm_mkilo3_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_A664AAD02EE98BD2 = _id_BA0801276542946B();
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 4);
  armor = 3000;
  helmet = 1;
  agent _id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 0);
  agent._id_F2A62F02827DAAA5 = 1.0;
  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
}

_id_852D353C00B3D5A1(agent, _id_6C149286380290A2) {
  if(!isDefined(agent) || isint(agent)) {
    return;
  }
  body = "body_mp_eastern_rodion_7_1";
  head = "head_mp_eastern_rodion_7_1";
  weapon = undefined;
  _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
  grenadeammo = getdvarint("dvar_96AA0C082C47CDCC", 4);
  armor = 500;
  helmet = level._id_6855C201495094B6["tier3"];
  agent _id_C37C4F9D687074FF(undefined, undefined, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet);
  _id_350CF0DB9F5E0CBE(agent, "tier", 3);
  agent.baseaccuracy = getdvarfloat("dvar_8AA5313CA3F3737F", 1.1);
}

_id_2C222AA74D0401F4(agent, _id_CDF5B236E13A9CAE) {
  body = "body_mp_milsim_balkan_sf_1_1";
  head = "head_mp_milsim_balkan_sf_1_1";
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sm_aviktor_mp", ["thermal01", "none", "none", "none", "silencer01_sm", "laserirsmg"], "none", "none");
  _id_A664AAD02EE98BD2 = "frag_grenade_mp";

  if(!isDefined(_id_CDF5B236E13A9CAE))
    _id_CDF5B236E13A9CAE = scripts\engine\utility::random(["smg", "shotgun", "sniper"]);

  switch (_id_CDF5B236E13A9CAE) {
    case "shotgun":
      body = "body_mp_eastern_nikto_2_1";
      head = "head_mp_eastern_nikto_3_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sh_charlie725_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      _id_A664AAD02EE98BD2 = "molotov_mp";
      break;
    case "sniper":
      body = "body_mp_eastern_azur_8_1";
      head = "head_mp_eastern_azur_8_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sn_alpha50_mp", ["none", "none", "none", "laserir", "none", "none"], "none", "none");
      _id_A664AAD02EE98BD2 = "frag_grenade_mp";
      break;
    case "smg":
      body = "body_mp_eastern_rodion_7_1";
      head = "head_mp_eastern_rodion_7_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sm_aviktor", ["thermal01", "none", "none", "none", "silencer01_sm", "laserir_box"], "none", "none");
      _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
      break;
    default:
      break;
  }

  _id_350CF0DB9F5E0CBE(agent, "dropWeapon", 0);
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 4);
  armor = 300;
  helmet = 1;
  groupname = undefined;

  if(isDefined(agent.script_stealthgroup))
    groupname = agent.script_stealthgroup;

  agent _id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ai", "dropLootOnAgentDeath"))
    agent thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("ai", "dropLootOnAgentDeath")]](agent, agent.agent_type, groupname);
}

_id_D93591A14F62DAA5(agent) {
  agent.armorhealth = int(agent.armorhealth + agent.armorhealth * 0.2);
  agent._id_8790C077C95DB752 = int(agent.armorhealth);
  agent.baseaccuracy = getdvarfloat("dvar_8C8FF70600B7829E", 1.2);

  if(istrue(agent._id_895DAE193CFAAC3A)) {
    agent.goalheight = 2000;
    agent._id_7D606BEC79308EB5 = 3000;
    agent._id_85A0F6383A5DD784 = 512;
    agent _meth_9215CE6FC83759B9(6000);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ai", "affectedLootDrops"))
    agent thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("ai", "affectedLootDrops")]]();
}

_id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, _id_E7DF46025EC50EAC) {
  if(isDefined(body))
    self setModel(body);

  if(isDefined(head)) {
    if(isDefined(self.headmodel))
      self detach(self.headmodel);

    self attach(head, "", 1);
    self.headmodel = head;
  }

  if(isDefined(weapon)) {
    _id_B003E2C45A4BF6F7 = undefined;
    weaponname = undefined;

    if(isDefined(self.weapon)) {
      self takeweapon(self.weapon);
      weaponname = getcompleteweaponname(self.weapon);

      if(isDefined(self.weaponinfo[weaponname])) {
        _id_B003E2C45A4BF6F7 = self.weaponinfo[weaponname].position;
        self.weaponinfo = scripts\engine\utility::array_remove_key(self.weaponinfo, weaponname);
      }
    }

    self.weapon = weapon;
    scripts\common\utility::initweapon(self.weapon);
    _id_350CF0DB9F5E0CBE(self, "weapon", weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;

    if(isDefined(self.a.weaponpos[_id_B003E2C45A4BF6F7])) {
      weaponname = getcompleteweaponname(self.weapon);
      self.weaponinfo[weaponname].position = _id_B003E2C45A4BF6F7;
      self.a.weaponpos[_id_B003E2C45A4BF6F7] = weapon;
    }
  }

  if(isDefined(_id_A664AAD02EE98BD2)) {
    if(!isDefined(level._id_E36AF3BFA3484A15))
      level._id_E36AF3BFA3484A15 = [];

    if(!isDefined(level._id_E36AF3BFA3484A15[_id_A664AAD02EE98BD2]))
      level._id_E36AF3BFA3484A15[_id_A664AAD02EE98BD2] = makeweapon(_id_A664AAD02EE98BD2);

    self.grenadeweapon = level._id_E36AF3BFA3484A15[_id_A664AAD02EE98BD2];

    if(!isDefined(grenadeammo))
      grenadeammo = 2;

    self.grenadeammo = grenadeammo;
  }

  if(isDefined(armor)) {
    if(scripts\common\utility::iscp()) {
      if(armor > 0) {
        self.equip_armor = 1;
        self._id_B5218CF00DAD94EF = armor;
      }
    }

    self.armorhealth = int(armor);
    self._id_8790C077C95DB752 = int(armor);
    self._id_8C5C47F81A1869E5 = _id_24FBEDBA9A7A1EF4::_id_7D0D24665D72F13C;
  }

  if(isDefined(helmet)) {
    self.helmethealth = helmet;
    self._id_CFC69E5588A5BED6 = helmet;
    self._id_CD6A3A50F09688B9 = _id_24FBEDBA9A7A1EF4::_id_59EA6B2F800CB082;
  }

  if(istrue(_id_E7DF46025EC50EAC))
    _id_1C3709E864D4E8D5(1);

  if(isDefined(armor) && armor > 0)
    _id_1920867DDF76810C(self, armor);
}

_id_B535FE740F1CF507() {
  if(isDefined(self.armorhealth)) {
    _id_4EF15EDD83080359 = self._id_0DCADE5065EA1A44;

    if(!isDefined(_id_4EF15EDD83080359))
      _id_4EF15EDD83080359 = getdvarint("dvar_A69C6853620FC61F", 200);

    _id_EDF34A99C4635317 = min(self.armorhealth + _id_4EF15EDD83080359, self._id_8790C077C95DB752);
    _id_07C40FA80892A721::_id_AC7803D45979135C(_id_EDF34A99C4635317);
    self._id_7CEA08B66B2AD878 = self._id_7CEA08B66B2AD878 - 1;
    self._id_27266ECECC1BDBE5 = gettime();
  }
}

_id_1C3709E864D4E8D5(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811) {
    self._id_E7DF46025EC50EAC = 1;
    _id_3B64EB40368C1450::set("agent_blockExecution", "execution_victim", 0);
  } else {
    self._id_E7DF46025EC50EAC = 0;
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("agent_blockExecution");
  }
}

_id_1920867DDF76810C(agent, armor) {
  if(issubstr(agent.agent_type, "riotshield")) {
    agent._id_9AA77AB756FDCA82 = 0;
    agent.minpaindamage = 0;
  } else if(issubstr(agent.agent_type, "tier3")) {
    agent._id_9AA77AB756FDCA82 = 600;
    agent._id_43E2AD424676B8D4 = 1;
    agent._id_BDC4A284F9421FFC = 1000;
    agent._id_98ADD129A7ECB962 = 0;
  } else if(isDefined(armor) && armor > 0) {
    _id_17B4196235199BA8 = [0, 40, 80];
    _id_BBD534A2A8D03EAA = scripts\engine\utility::random(_id_17B4196235199BA8);
    agent._id_9AA77AB756FDCA82 = 240 + _id_BBD534A2A8D03EAA;
    agent._id_43E2AD424676B8D4 = 50;
    agent._id_BDC4A284F9421FFC = 1000;
    agent._id_98ADD129A7ECB962 = 0;
  } else if(agent._id_D5E499E7FE2C490B) {
    agent._id_43E2AD424676B8D4 = 10;
    agent._id_BDC4A284F9421FFC = 1000;
    _id_C00E1D676844F7AE(agent);
  } else {
    _id_17B4196235199BA8 = [0, 50, 80];
    _id_BBD534A2A8D03EAA = scripts\engine\utility::random(_id_17B4196235199BA8);
    agent._id_9AA77AB756FDCA82 = 100 + _id_BBD534A2A8D03EAA;
    agent._id_43E2AD424676B8D4 = 10;
    agent._id_BDC4A284F9421FFC = 1000;
    agent._id_98ADD129A7ECB962 = 0;
  }
}

_id_C00E1D676844F7AE(agent) {
  if(issubstr(agent.agent_type, "tier1"))
    agent._id_9AA77AB756FDCA82 = 100;
  else if(issubstr(agent.agent_type, "tier2"))
    agent._id_9AA77AB756FDCA82 = 240;
  else if(issubstr(agent.agent_type, "tier3"))
    agent._id_9AA77AB756FDCA82 = 600;
}

_id_EA83C1B372E16F6D(agent, _id_80F4BDE7090A4773) {
  if(isagent(agent))
    agent._id_80F4BDE7090A4773 = _id_80F4BDE7090A4773;
  else if(isint(agent))
    level._id_879053468F168806[agent]._id_80F4BDE7090A4773 = _id_80F4BDE7090A4773;
}

_id_BA0801276542946B(_id_7E1FF9AFA225E8A1) {
  if(isDefined(_id_7E1FF9AFA225E8A1))
    return scripts\engine\utility::random(_id_7E1FF9AFA225E8A1);

  if(!isDefined(level._id_61312C4C9C8A7CAE))
    level._id_61312C4C9C8A7CAE = ["thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp"];

  return scripts\engine\utility::random(level._id_61312C4C9C8A7CAE);
}

_id_0F5D160902133558() {
  level._id_0D7B3BD9AD64C74B = [];

  foreach(agent in level.agentarray)
  level._id_0D7B3BD9AD64C74B[agent getentitynumber()] = [];
}

_id_D0563DC9EEAC7FF0(agent) {
  if(!isDefined(level._id_0D7B3BD9AD64C74B))
    _id_0F5D160902133558();

  return agent getentitynumber();
}

_id_350CF0DB9F5E0CBE(agent, key, value) {
  if(!isDefined(level._id_0D7B3BD9AD64C74B))
    _id_0F5D160902133558();

  level._id_0D7B3BD9AD64C74B[agent getentitynumber()][key] = value;
}

_id_E2292DCF63ECCF7A(agent, key) {
  if(!isDefined(level._id_0D7B3BD9AD64C74B))
    _id_0F5D160902133558();

  return level._id_0D7B3BD9AD64C74B[agent getentitynumber()][key];
}

_id_B894B8689A6055F3(agent) {
  if(!isDefined(level._id_0D7B3BD9AD64C74B))
    _id_0F5D160902133558();

  return level._id_0D7B3BD9AD64C74B[agent getentitynumber()].size == 0;
}

_id_51DE6DA7B0DCF26F(agent) {
  if(!isDefined(level._id_0D7B3BD9AD64C74B))
    _id_0F5D160902133558();

  level._id_0D7B3BD9AD64C74B[agent getentitynumber()] = [];
}

_id_03BDEB9EDD6C6F0A() {
  level._id_C7796321C3D97413 = [];
  level._id_C7796321C3D97413[1] = ["firebug"];
  level._id_C7796321C3D97413[2] = [];
  level._id_C7796321C3D97413[3] = ["strikeunit"];
}

_id_C26EF480E88413BF(agent, aitype) {
  if(issubstr(aitype, "firebug"))
    agent thread _id_0036613FFB5EBE56(agent);
  else if(issubstr(aitype, "strike"))
    agent thread _id_9CA698CDFFE22968(agent);
  else if(getdvarint("dvar_B0E7EDF188DDB934", 0) == 1 && !issubstr(aitype, "riotshield") && issubstr(aitype, "biolab")) {
    agent._id_7CEA08B66B2AD878 = 0;

    if(isDefined(agent.subclass)) {
      if(agent.subclass == "tier2") {
        agent.suppressionthreshold = 0.8;
        agent.suppressiondecrement = 0.07;
        agent._id_2A4784C6CC07CA59 = 0.25;
        agent._id_CBD87A0BC497B778 = 1;
        agent._id_4268B42FC89D0BE9 = 0.03;
        agent._id_8A783F4C73C2AE91 = 0.00005;
        agent.aggressivemode = 1;
      } else if(agent.subclass == "tier3") {
        agent.suppressionthreshold = 0.4;
        agent.suppressiondecrement = 0.2;
        agent._id_2A4784C6CC07CA59 = 0.05;
        agent._id_CBD87A0BC497B778 = 1;
        agent._id_4268B42FC89D0BE9 = 0.015;
        agent._id_8A783F4C73C2AE91 = 0.00001;
        agent.aggressivemode = 1;
      }
    }
  } else if(agent.subclass == "tier1") {
    agent._id_4268B42FC89D0BE9 = getdvarfloat("dvar_6F6B0FCE63D51E11", 0.07);
    agent._id_8A783F4C73C2AE91 = getdvarfloat("dvar_2E0C4C6766AC7FFE", 0.00015);
  } else if(agent.subclass == "tier2") {
    agent._id_4268B42FC89D0BE9 = getdvarfloat("dvar_6F6B0CCE63D51778", 0.05);
    agent._id_8A783F4C73C2AE91 = getdvarfloat("dvar_2E0C4B6766AC7DCB", 0.0001);
  } else if(agent.subclass == "tier3") {
    agent.suppressionthreshold = 0.5;
    agent.suppressiondecrement = 0.15;
    agent._id_2A4784C6CC07CA59 = 0.05;
    agent._id_4268B42FC89D0BE9 = getdvarfloat("dvar_6F6B0DCE63D519AB", 0.04);
    agent._id_8A783F4C73C2AE91 = getdvarfloat("dvar_2E0C4A6766AC7B98", 0.00005);
    agent.aggressivemode = 1;
  }
}

_id_0036613FFB5EBE56(agent) {
  agent endon("death");
  agent endon("stop_throwing");
  _id_EE09091EFECA0364 = 0.5;
  _id_195927E09B405481 = "molotov_mp";
  grenades = 8;
  _id_B98850B58450BF4B = gettime();
  _id_350CF0DB9F5E0CBE(self, "throwingScriptGrenade", 0);
  _id_C37C4F9D687074FF(undefined, undefined, undefined, _id_195927E09B405481, grenades);
  level thread _id_D3F59232689F12A0(agent);

  for(;;) {
    if(gettime() >= _id_B98850B58450BF4B) {
      if(!isDefined(agent.enemy)) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) > 1048576 || isDefined(self.pathgoalpos)) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      _id_F2BC2E4B8D09E518 = distancesquared(agent.origin, agent.enemy.origin);

      if(_id_F2BC2E4B8D09E518 < 65536 || _id_F2BC2E4B8D09E518 > 2250000) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      if(!agent cansee(agent.enemy)) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      _id_22C4300CE1D248E8 = agent.origin;
      _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + (0, 0, 128);
      trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      _id_22C4300CE1D248E8 = agent.origin + (0, 0, 100);
      _id_96020725B7899B37 = vectorNormalize(agent.enemy.origin - _id_22C4300CE1D248E8);
      _id_96020725B7899B37 = (_id_96020725B7899B37[0], _id_96020725B7899B37[1], 0) + (0, 0, 1);
      _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + _id_96020725B7899B37 * 1000;
      trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      agent thread _id_AE99616202575E39(agent.enemy.origin, _id_195927E09B405481, 64);
      _id_B98850B58450BF4B = gettime() + randomintrange(2, 3) * 1000;
      grenades--;
    }

    if(grenades == 0) {
      return;
    }
    wait(_id_EE09091EFECA0364);
  }
}

_id_D3F59232689F12A0(agent) {
  agent waittill("death", _id_6181DE250AFA5BB6, meansofdeath);
  _id_C524724829B57A7E = agent scripts\engine\utility::doinglongdeath();

  if(!_id_C524724829B57A7E && _id_E2292DCF63ECCF7A(agent, "throwingScriptGrenade")) {
    right = anglestoright(agent.angles);
    _id_2C04BF9A8CE4F0B2 = agent.origin + anglesToForward(agent.angles) * 5 + right * 20 + (0, 0, 60);
    _id_56EBCB2D4FCB8071 = (0, 0, 200) + right * randomfloatrange(-100, 100);
    grenade = agent launchgrenade("molotov_mp", _id_2C04BF9A8CE4F0B2, _id_56EBCB2D4FCB8071);
    grenade._id_88FE704ADF00EADF = 1;
    grenade.owner = agent;
    wait 0.1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pyro", "molotov_used"))
      agent thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("pyro", "molotov_used")]](grenade);

    wait 1;
    grenade notify("missile_stuck");
  }
}

_id_9CA698CDFFE22968(agent, _id_37D7C6423323A19E) {
  agent endon("death");
  agent endon("stop_throwing");
  _id_EE09091EFECA0364 = 0.5;
  _id_195927E09B405481 = "smoke_grenade_mp";
  grenades = 8;
  _id_B98850B58450BF4B = gettime();
  _id_350CF0DB9F5E0CBE(self, "throwingScriptGrenade", 0);

  if(!istrue(_id_37D7C6423323A19E)) {
    agent.baseaccuracy = getdvarfloat("dvar_8AA5313CA3F3737F", 1.1);
    armor = 500;
    helmet = level._id_6855C201495094B6["tier3"];
    weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_mike4_mp", ["laserbox_hip04", "none", "none", "none", "silencer01_ar", "none"], "none", "none");
  } else {
    armor = undefined;
    helmet = undefined;
    weapon = undefined;
  }

  _id_C37C4F9D687074FF(undefined, undefined, weapon, _id_195927E09B405481, grenades, armor, helmet);

  if(!istrue(_id_37D7C6423323A19E))
    agent laseron();

  _id_54A2636D2994800F = 75;
  _id_03AF61C217D8E61B = 15000;
  _id_0A08068BFBCF2DDE = undefined;

  for(;;) {
    if(isDefined(agent.enemy) && !isDefined(_id_0A08068BFBCF2DDE) && agent cansee(agent.enemy)) {
      _id_0A08068BFBCF2DDE = gettime();

      if(randomint(100) < _id_54A2636D2994800F) {
        magicgrenademanual("smoke_grenade_mp", agent.origin, (0, 0, -10), 0.5);
        thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", agent.origin);
      }

      _id_B98850B58450BF4B = gettime() + randomintrange(2, 5) * 1000;
    } else if(!isDefined(agent.enemy) && isDefined(_id_0A08068BFBCF2DDE) && _id_0A08068BFBCF2DDE + _id_03AF61C217D8E61B < gettime())
      _id_0A08068BFBCF2DDE = undefined;

    if(gettime() >= _id_B98850B58450BF4B) {
      if(!isDefined(agent.enemy)) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      if(isDefined(agent _meth_92435C7A6AE85C3C())) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) > 1048576 || isDefined(self.pathgoalpos)) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      _id_F2BC2E4B8D09E518 = distancesquared(agent.origin, agent.enemy.origin);

      if(_id_F2BC2E4B8D09E518 < 16384 || _id_F2BC2E4B8D09E518 > 1960000) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      if(!agent cansee(agent.enemy)) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      _id_22C4300CE1D248E8 = agent.origin;
      _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + (0, 0, 128);
      trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      _id_22C4300CE1D248E8 = agent.origin + (0, 0, 100);
      _id_96020725B7899B37 = vectorNormalize(agent.enemy.origin - _id_22C4300CE1D248E8);
      _id_96020725B7899B37 = (_id_96020725B7899B37[0], _id_96020725B7899B37[1], 0) + (0, 0, 1);
      _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + _id_96020725B7899B37 * 1000;
      trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, agent);

      if(trace["hittype"] != "hittype_none" && isDefined(trace["position"])) {
        wait(_id_EE09091EFECA0364);
        continue;
      }

      _id_9001DA663C7CDFEC = vectorNormalize(agent.enemy.origin - agent.origin);
      _id_F2BC2E4B8D09E518 = sqrt(_id_F2BC2E4B8D09E518);
      _id_AE64FC8EAD2542D0 = _id_F2BC2E4B8D09E518 / 2;
      targetorigin = agent.origin + _id_9001DA663C7CDFEC * _id_AE64FC8EAD2542D0 + (0, 0, 32);
      agent thread _id_AE99616202575E39(targetorigin, _id_195927E09B405481, 128);
      _id_B98850B58450BF4B = gettime() + randomintrange(2, 5) * 1000;
      grenades--;
    }

    if(grenades == 0) {
      return;
    }
    wait(_id_EE09091EFECA0364);
  }
}

turnonlaser() {
  wait 1;

  for(;;) {
    self laseron();
    wait 3;
    self laseroff();
    wait 3;
  }
}

_id_AE99616202575E39(targetorigin, _id_195927E09B405481, _id_D2666395E6CF4732) {
  self endon("death");
  _id_350CF0DB9F5E0CBE(self, "throwingScriptGrenade", 1);

  if(isDefined(_id_D2666395E6CF4732)) {
    _id_D2666395E6CF4732 = min(abs(_id_D2666395E6CF4732), 256);
    targetorigin = targetorigin + (randomfloatrange(-1.0 * _id_D2666395E6CF4732, _id_D2666395E6CF4732), randomfloatrange(-1.0 * _id_D2666395E6CF4732, _id_D2666395E6CF4732), randomfloatrange(-1.0 * _id_D2666395E6CF4732, _id_D2666395E6CF4732));
  }

  [animname, _id_07ADB38055D0917F, _id_472050D5EBCF25B8] = _id_CF56C061947EF668(self.origin, targetorigin);
  [_id_3EB0E5F5F61F0A10, _id_56EBCB2D4FCB8071] = _id_A615009E6466353A(self, targetorigin, _id_195927E09B405481, _id_472050D5EBCF25B8);
  self._id_CA01D1496480B62C = targetorigin;
  self._id_624EFED57C34C807 = _id_56EBCB2D4FCB8071;
  _id_4CB4BB1CFF15B987();
  self._id_CA01D1496480B62C = undefined;
  self._id_624EFED57C34C807 = undefined;
}

_id_4CB4BB1CFF15B987() {
  _id_22019A90F96BD145 = "ai_forceThrowGrenade_timeout";
  _id_9E4E6B6CA639AF0B = "ai_forceThrowGrenade_finish";
  _id_18D67196C117E2C1 = 6;
  self endon(_id_22019A90F96BD145);
  childthread _id_D34200A799950385(_id_18D67196C117E2C1, _id_22019A90F96BD145, _id_9E4E6B6CA639AF0B);

  while(!istrue(self.isholdinggrenade) && isDefined(self._id_CA01D1496480B62C))
    waitframe();

  _id_350CF0DB9F5E0CBE(self, "throwingScriptGrenade", 1);

  while(istrue(self.isholdinggrenade) && isDefined(self._id_CA01D1496480B62C))
    waitframe();

  _id_350CF0DB9F5E0CBE(self, "throwingScriptGrenade", 0);
  self notify(_id_9E4E6B6CA639AF0B);
}

_id_D34200A799950385(t, notifyname, _id_CB57658B734D4B0C) {
  self endon(_id_CB57658B734D4B0C);
  wait(t);
  self notify(notifyname);
}

_id_E4E4FEFD625A2580(agent) {
  if(isDefined(agent.node))
    return anglesToForward(agent.node.angles);
  else
    return anglesToForward(agent.angles);
}

_id_A615009E6466353A(_id_CF13FDA662AB8288, targetorigin, _id_195927E09B405481, _id_55FBA01075EFACDB) {
  offset = (0, 0, 100);

  if(isDefined(_id_55FBA01075EFACDB))
    offset = _id_55FBA01075EFACDB;

  _id_3EB0E5F5F61F0A10 = _id_CF13FDA662AB8288.origin + offset;
  _id_56EBCB2D4FCB8071 = targetorigin - _id_3EB0E5F5F61F0A10;
  _id_56EBCB2D4FCB8071 = vectorNormalize(_id_56EBCB2D4FCB8071);
  _id_56EBCB2D4FCB8071 = (_id_56EBCB2D4FCB8071[0], _id_56EBCB2D4FCB8071[1], 0) + (0, 0, 1);
  dist = distance2d(_id_3EB0E5F5F61F0A10, targetorigin);
  _id_56EBCB2D4FCB8071 = _id_56EBCB2D4FCB8071 * dist * _id_01BC68105415D304(_id_195927E09B405481, dist);
  return [_id_3EB0E5F5F61F0A10, _id_56EBCB2D4FCB8071];
}

_id_EE72700F22A0E304(_id_CF13FDA662AB8288, _id_195927E09B405481) {}

_id_01BC68105415D304(_id_A664AAD02EE98BD2, _id_D58E3CC99EDAEF16) {
  switch (_id_A664AAD02EE98BD2) {
    case "frag_grenade_mp":
      return 0.75;
    case "gas_mp":
      return 600;
    case "molotov_mp":
      if(isDefined(_id_D58E3CC99EDAEF16) && _id_D58E3CC99EDAEF16 < 512)
        return 0.8;

      return 0.6;
    case "concussion_grenade_mp":
      return 180;
    default:
      return 0.6;
  }
}

_id_CF56C061947EF668(_id_5B18ECAACD37D496, targetorigin) {
  _id_6647D06F6E45486C = distance2dsquared(self.origin, targetorigin);

  if(_id_6647D06F6E45486C < 262144)
    return ["grenade_throw_short", 0.6, (0, 10, 50)];
  else
    return ["grenade_throw", 0.5, (0, 0, 100)];

  return ["grenade_throw", 0.5, (0, 0, 100)];
}

_id_13812F40F38587C4(_id_DCF5E15C58C4152A, origin, _id_451A9D27D63C746B) {
  _id_7D2909FDC2B71387 = _id_2B0E82156FA6075B(_id_451A9D27D63C746B);
  _id_760792071513B00D(_id_451A9D27D63C746B);

  if(!isDefined(_id_7D2909FDC2B71387)) {
    return;
  }
  aitype = _id_7D2909FDC2B71387.aitype;
  origin = _id_7D2909FDC2B71387.origin;
  angles = _id_7D2909FDC2B71387.angles;
  priority = _id_072D6808216B4D44(_id_7D2909FDC2B71387.priority);
  category = _id_7D2909FDC2B71387.category;
  _id_1C9CB43BCF3EB16D = _id_7D2909FDC2B71387._id_1C9CB43BCF3EB16D;
  groupname = _id_7D2909FDC2B71387.groupname;
  team = _id_30A0D7CA3FAE40CC(undefined, _id_7D2909FDC2B71387.aitype);
  destination = undefined;
  _id_171F90B9C4C76D44 = _id_7D2909FDC2B71387._id_B205D90302DA2F07;
  _id_F891E067B8802C0D = _id_7D2909FDC2B71387._id_F891E067B8802C0D;
  _id_F8BC7ECDD324DD79 = _id_7D2909FDC2B71387._id_F8BC7ECDD324DD79;
  _id_80F4BDE7090A4773 = _id_7D2909FDC2B71387._id_80F4BDE7090A4773;
  _id_8124E3F14D523A45 = _id_7D2909FDC2B71387._id_324DFDEE5BDF702E;
  _id_A5DAF6A4BAF26AAF = _id_7D2909FDC2B71387._id_A5DAF6A4BAF26AAF;
  threatbiasgroup = _id_7D2909FDC2B71387.threatbiasgroup;
  _id_8A76B06617613D30 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "ai_mp_requestSpawnAgent");
  agent = [[_id_8A76B06617613D30]](aitype, origin, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, 1, undefined, _id_80F4BDE7090A4773, undefined, undefined, threatbiasgroup);

  if(isDefined(agent)) {
    agent._id_F8BC7ECDD324DD79 = _id_F8BC7ECDD324DD79;
    _id_3EA1225BF6192343(agent, _id_A5DAF6A4BAF26AAF);
    _id_580A150BA253DE13 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "behavior_executeBehaviorPackage");
    [[_id_580A150BA253DE13]](agent);
    agent._id_324DFDEE5BDF702E = _id_8124E3F14D523A45;
    _id_E662189D61D1874E(agent);
  } else if(isDefined(_id_A5DAF6A4BAF26AAF)) {
    if(isDefined(_id_A5DAF6A4BAF26AAF.group))
      [[_id_A5DAF6A4BAF26AAF._id_9E729433FD479F19]](_id_A5DAF6A4BAF26AAF, _id_451A9D27D63C746B);
    else if(isDefined(level._id_59CFFB78293FE83C) && isDefined(level._id_59CFFB78293FE83C._id_9E729433FD479F19))
      [[level._id_59CFFB78293FE83C._id_9E729433FD479F19]](_id_A5DAF6A4BAF26AAF, _id_451A9D27D63C746B);
  }
}

_id_9FA011B7807309A8(agent, _id_451A9D27D63C746B) {
  aitype = agent.agent_type;
  origin = agent.origin;
  angles = agent.angles;
  priority = agent.priority;
  category = agent.category;
  _id_1C9CB43BCF3EB16D = agent._id_1C9CB43BCF3EB16D;
  groupname = agent.script_stealthgroup;
  destination = undefined;
  _id_171F90B9C4C76D44 = agent._id_B205D90302DA2F07;
  team = agent.team;
  _id_F891E067B8802C0D = !agent.stealth_enabled;
  _id_F8BC7ECDD324DD79 = agent._id_F8BC7ECDD324DD79;
  _id_80F4BDE7090A4773 = agent._id_80F4BDE7090A4773;
  _id_8124E3F14D523A45 = agent._id_324DFDEE5BDF702E;
  _id_A5DAF6A4BAF26AAF = _id_12EE2283DB699727(agent);

  if(isDefined(_id_F8BC7ECDD324DD79) && _id_F8BC7ECDD324DD79.behavior == "cqb" && isDefined(_id_F8BC7ECDD324DD79._id_F1548C57038E1B7A)) {
    foreach(node in _id_F8BC7ECDD324DD79._id_F1548C57038E1B7A) {
      if(isDefined(node))
        node.claimed = 0;
    }
  }

  _id_7D2909FDC2B71387 = _id_E83D1F023A2609FF(aitype, origin, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, _id_F8BC7ECDD324DD79, _id_80F4BDE7090A4773, _id_8124E3F14D523A45, _id_A5DAF6A4BAF26AAF);
  _id_7A9172605E0228DF(_id_451A9D27D63C746B, _id_7D2909FDC2B71387);
  _id_ED1DF18568977A9B = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "subArea_findAndAssignForDormancyID");
  [[_id_ED1DF18568977A9B]](origin, _id_171F90B9C4C76D44, destination, _id_451A9D27D63C746B);
  _id_6FDAD75E06D99A21 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "priority_setByDormancyId");
  [[_id_6FDAD75E06D99A21]](_id_451A9D27D63C746B, priority);
  _id_58F203B26C3A3F8A = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "ai_registerAgent");
  [[_id_58F203B26C3A3F8A]](_id_451A9D27D63C746B, category, _id_1C9CB43BCF3EB16D, _id_171F90B9C4C76D44);

  if(isDefined(_id_A5DAF6A4BAF26AAF)) {
    if(isDefined(_id_A5DAF6A4BAF26AAF.group))
      [[_id_A5DAF6A4BAF26AAF._id_90CCD093DE8C8C55]](agent, _id_451A9D27D63C746B);
    else if(isDefined(level._id_59CFFB78293FE83C) && isDefined(level._id_59CFFB78293FE83C._id_90CCD093DE8C8C55))
      [[level._id_59CFFB78293FE83C._id_90CCD093DE8C8C55]](agent, _id_451A9D27D63C746B);
  }
}

_id_B6131256EE347E8D(priority) {
  if(!isDefined(priority))
    return 5;

  if(isint(priority))
    return scripts\engine\utility::ter_op(priority < 0, 0, scripts\engine\utility::ter_op(priority > 5, 5, priority));

  switch (tolower(priority)) {
    case "absolute":
      return 1;
    case "high":
      return 2;
    case "medium":
      return 3;
    case "low":
      return 4;
    case "filler":
      return 5;
    default:
      return 5;
  }
}

_id_072D6808216B4D44(_id_D9A4D73B82707003) {
  switch (_id_D9A4D73B82707003) {
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

_id_E2FA9B378BBF03A6(aitype, origin, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, _id_F8BC7ECDD324DD79, threatbiasgroup) {
  priority = _id_B6131256EE347E8D(priority);
  _id_7D2909FDC2B71387 = _id_E83D1F023A2609FF(aitype, origin, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, _id_F8BC7ECDD324DD79, undefined, undefined, undefined, threatbiasgroup);
  _id_451A9D27D63C746B = _func_4476B9B75CB95D99(origin, aitype, priority);
  _id_7A9172605E0228DF(_id_451A9D27D63C746B, _id_7D2909FDC2B71387);
  return _id_451A9D27D63C746B;
}

_id_B04C0433E8107615() {
  level._id_74E9C02B56E4BA52 = ::_id_13812F40F38587C4;
  level._id_8A42B71F799936AD = ::_id_9FA011B7807309A8;
  level._id_FE093E9B2B6C3751 = getdvarint("ai_allowdormancy", 0);
  level._id_53DB9BACADEF066D = spawnStruct();
  level._id_53DB9BACADEF066D._id_D4053E1A1D2983CE = 0;
  level._id_879053468F168806 = [];
}

_id_E83D1F023A2609FF(aitype, origin, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, _id_F8BC7ECDD324DD79, _id_80F4BDE7090A4773, _id_8124E3F14D523A45, _id_A5DAF6A4BAF26AAF, threatbiasgroup) {
  _id_7D2909FDC2B71387 = spawnStruct();
  _id_7D2909FDC2B71387.aitype = aitype;
  _id_7D2909FDC2B71387.origin = origin;
  _id_7D2909FDC2B71387.angles = angles;
  _id_7D2909FDC2B71387.priority = _id_B6131256EE347E8D(priority);
  _id_7D2909FDC2B71387.category = category;
  _id_7D2909FDC2B71387._id_1C9CB43BCF3EB16D = _id_1C9CB43BCF3EB16D;
  _id_7D2909FDC2B71387.groupname = groupname;
  _id_7D2909FDC2B71387.team = team;
  _id_7D2909FDC2B71387.destination = destination;
  _id_7D2909FDC2B71387._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
  _id_7D2909FDC2B71387._id_F891E067B8802C0D = _id_F891E067B8802C0D;
  _id_7D2909FDC2B71387._id_F8BC7ECDD324DD79 = _id_F8BC7ECDD324DD79;
  _id_7D2909FDC2B71387._id_80F4BDE7090A4773 = _id_80F4BDE7090A4773;
  _id_7D2909FDC2B71387._id_324DFDEE5BDF702E = _id_8124E3F14D523A45;
  _id_7D2909FDC2B71387._id_A5DAF6A4BAF26AAF = _id_A5DAF6A4BAF26AAF;
  _id_7D2909FDC2B71387.threatbiasgroup = threatbiasgroup;
  return _id_7D2909FDC2B71387;
}

_id_7A9172605E0228DF(_id_451A9D27D63C746B, _id_7D2909FDC2B71387) {
  level._id_879053468F168806[_id_451A9D27D63C746B] = _id_7D2909FDC2B71387;
}

_id_2B0E82156FA6075B(_id_451A9D27D63C746B) {
  return level._id_879053468F168806[_id_451A9D27D63C746B];
}

_id_B27FE8A834C5EDDA() {
  return level._id_879053468F168806.size;
}

_id_3B45C895D8D984EE() {
  if(!isDefined(level._id_88655F45C7BEB22A))
    level._id_88655F45C7BEB22A = getdvarint("dvar_EE8CF30F1E199E42", 200) - 1;

  return level._id_88655F45C7BEB22A;
}

_id_4E065F1747AADD51(_id_451A9D27D63C746B, category) {
  _func_EE990C1808DF152B(_id_451A9D27D63C746B);
  _id_7D2909FDC2B71387 = _id_2B0E82156FA6075B(_id_451A9D27D63C746B);

  if(istrue(level._id_45CA3CFB9DCA4F97))
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_7D2909FDC2B71387.origin, 64, 500, (1, 0, 0));

  if(isDefined(_id_7D2909FDC2B71387) && isDefined(_id_7D2909FDC2B71387._id_A5DAF6A4BAF26AAF)) {
    if(isDefined(_id_7D2909FDC2B71387._id_A5DAF6A4BAF26AAF.group))
      [[_id_7D2909FDC2B71387._id_A5DAF6A4BAF26AAF.ondeath]](_id_451A9D27D63C746B);
    else if(isDefined(level._id_59CFFB78293FE83C) && isDefined(level._id_59CFFB78293FE83C.ondeath))
      [[level._id_59CFFB78293FE83C.ondeath]](_id_451A9D27D63C746B);
  }

  _id_760792071513B00D(_id_451A9D27D63C746B);
}

_id_760792071513B00D(_id_451A9D27D63C746B, category) {
  if(!isDefined(category))
    category = _id_2B0E82156FA6075B(_id_451A9D27D63C746B)._id_B205D90302DA2F07;

  _id_F7FD7A99AA002217 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "priority_removeByDormancyId");
  [[_id_F7FD7A99AA002217]](_id_451A9D27D63C746B);
  _id_8632846F44F043E5 = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "ai_deregisterAgent");
  [[_id_8632846F44F043E5]](_id_451A9D27D63C746B, category);
  _id_D1CF55B36FACF5A8 = level._id_879053468F168806[_id_451A9D27D63C746B]._id_D1CF55B36FACF5A8;

  if(isDefined(_id_D1CF55B36FACF5A8)) {
    _id_589FE1386325A0CC = scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "subArea_removeAgentFrom");
    [[_id_589FE1386325A0CC]](_id_451A9D27D63C746B, _id_D1CF55B36FACF5A8);
  }

  level._id_879053468F168806[_id_451A9D27D63C746B] = undefined;
}

_id_E662189D61D1874E(agent) {
  if(!isagent(agent)) {
    return;
  }
  if(isDefined(agent._id_324DFDEE5BDF702E)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 24; _id_AC0E594AC96AA3A8++) {
      _id_964917A4EDC12525 = 1 << _id_AC0E594AC96AA3A8;

      if(_id_964917A4EDC12525 > agent._id_324DFDEE5BDF702E) {
        break;
      }

      if((agent._id_324DFDEE5BDF702E &_id_964917A4EDC12525) == _id_964917A4EDC12525)
        agent thread[[level._id_5DBBD87FD9E2457F[_id_AC0E594AC96AA3A8]]](agent);
    }
  }
}

_id_58AAB2EDAEC2599F(agent, _id_53BD93219C031C08, function) {
  if(!isDefined(agent) || !isDefined(_id_53BD93219C031C08) || !isstring(_id_53BD93219C031C08) || !isDefined(function) || !isfunction(function)) {
    return;
  }
  _id_A1ACC0CC2A3CFEAA(_id_53BD93219C031C08, function);

  if(isagent(agent)) {
    if(!isDefined(agent._id_324DFDEE5BDF702E))
      agent._id_324DFDEE5BDF702E = 0;

    agent._id_324DFDEE5BDF702E = agent._id_324DFDEE5BDF702E | 1 << level._id_8CFCCF3B774F4458[_id_53BD93219C031C08].index;
  } else if(isint(agent)) {
    if(!isDefined(level._id_879053468F168806[agent]._id_324DFDEE5BDF702E))
      level._id_879053468F168806[agent]._id_324DFDEE5BDF702E = 0;

    level._id_879053468F168806[agent]._id_324DFDEE5BDF702E = level._id_879053468F168806[agent]._id_324DFDEE5BDF702E | 1 << level._id_8CFCCF3B774F4458[_id_53BD93219C031C08].index;
  }
}

_id_97FBD14BBCF19D9C(agent, _id_53BD93219C031C08, function) {
  if(!isDefined(function) || !isfunction(function) || !isDefined(agent) || !isDefined(_id_53BD93219C031C08) || !isstring(_id_53BD93219C031C08)) {
    return;
  }
  _id_A1ACC0CC2A3CFEAA(_id_53BD93219C031C08, function);

  if(isagent(agent)) {
    if(!isDefined(agent._id_324DFDEE5BDF702E))
      agent._id_324DFDEE5BDF702E = 0;
    else
      agent._id_324DFDEE5BDF702E = agent._id_324DFDEE5BDF702E &~(1 << level._id_8CFCCF3B774F4458[_id_53BD93219C031C08].index);
  } else if(isint(agent) && isDefined(level._id_879053468F168806[agent])) {
    if(!isDefined(level._id_879053468F168806[agent]._id_324DFDEE5BDF702E))
      level._id_879053468F168806[agent]._id_324DFDEE5BDF702E = 0;
    else
      level._id_879053468F168806[agent]._id_324DFDEE5BDF702E = level._id_879053468F168806[agent]._id_324DFDEE5BDF702E &~(1 << level._id_8CFCCF3B774F4458[_id_53BD93219C031C08].index);
  }
}

_id_A1ACC0CC2A3CFEAA(_id_53BD93219C031C08, function) {
  if(!isDefined(level._id_8CFCCF3B774F4458))
    level._id_8CFCCF3B774F4458 = [];

  if(!isDefined(level._id_5DBBD87FD9E2457F))
    level._id_5DBBD87FD9E2457F = [];

  if(!isDefined(level._id_8CFCCF3B774F4458[_id_53BD93219C031C08])) {
    _id_93F937D4C731DE92 = spawnStruct();
    _id_93F937D4C731DE92.func = function;
    _id_93F937D4C731DE92.index = level._id_8CFCCF3B774F4458.size;
    level._id_8CFCCF3B774F4458[_id_53BD93219C031C08] = _id_93F937D4C731DE92;
  }

  index = level._id_8CFCCF3B774F4458[_id_53BD93219C031C08].index;

  if(!isDefined(level._id_5DBBD87FD9E2457F[index]))
    level._id_5DBBD87FD9E2457F[index] = function;
}

_id_0F3D88B5D7353A90(array, agent) {
  _id_BFC65A378A6D8EFE = [];

  foreach(item in array) {
    if(isagent(agent) && isagent(item) && agent != item) {
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = item;
      continue;
    }

    if(isagent(agent) && isint(item) || isint(agent) && isagent(item)) {
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = item;
      continue;
    }

    if(isint(agent) && isint(item) && agent != item)
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_20381A5CA18027FF(health) {
  self.health = health;
  self.maxhealth = health;
}

_id_3EA1225BF6192343(agent, struct) {
  if(isagent(agent)) {
    agent._id_A5DAF6A4BAF26AAF = struct;
    _id_350CF0DB9F5E0CBE(agent, "agentStruct", struct);
  } else if(isint(agent)) {
    info = _id_2B0E82156FA6075B(agent);

    if(isDefined(info))
      info._id_A5DAF6A4BAF26AAF = struct;
  }
}

_id_12EE2283DB699727(agent) {
  if(isagent(agent))
    return _id_E2292DCF63ECCF7A(agent, "agentStruct");
  else if(isint(agent)) {
    info = _id_2B0E82156FA6075B(agent);
    return info._id_A5DAF6A4BAF26AAF;
  }
}

_id_A09756B37F2E0681() {
  level._id_6855C201495094B6 = [];
  level._id_6855C201495094B6["tier2"] = getdvarint("dvar_7E5512406A54DD39", 1);
  level._id_6855C201495094B6["tier3"] = getdvarint("dvar_7E5511406A54DB06", 3);
  level._id_6855C201495094B6["jugg"] = getdvarint("dvar_BC69C0296B829CC6", 10);
  level._id_9F0B40FBEB9CDDE2 = [];
  level._id_9F0B40FBEB9CDDE2["ar"] = [];
  level._id_9F0B40FBEB9CDDE2["ar"]["maxfaceenemydist"] = 400;
  level._id_9F0B40FBEB9CDDE2["ar"]["maxfacenewenemydist"] = 80;
  level._id_9F0B40FBEB9CDDE2["lmg"] = [];
  level._id_9F0B40FBEB9CDDE2["lmg"]["maxfaceenemydist"] = 512;
  level._id_9F0B40FBEB9CDDE2["lmg"]["maxfacenewenemydist"] = 80;
  level._id_9F0B40FBEB9CDDE2["shotgun"] = [];
  level._id_9F0B40FBEB9CDDE2["shotgun"]["maxfaceenemydist"] = 80;
  level._id_9F0B40FBEB9CDDE2["shotgun"]["maxfacenewenemydist"] = 16;
  level._id_9F0B40FBEB9CDDE2["smg"] = [];
  level._id_9F0B40FBEB9CDDE2["smg"]["maxfaceenemydist"] = 320;
  level._id_9F0B40FBEB9CDDE2["smg"]["maxfacenewenemydist"] = 32;
  level._id_9F0B40FBEB9CDDE2["sniper"] = [];
  level._id_9F0B40FBEB9CDDE2["sniper"]["maxfaceenemydist"] = 32;
  level._id_9F0B40FBEB9CDDE2["sniper"]["maxfacenewenemydist"] = 50;
  level._id_9F0B40FBEB9CDDE2["rpg"] = [];
  level._id_9F0B40FBEB9CDDE2["rpg"]["maxfaceenemydist"] = 32;
  level._id_9F0B40FBEB9CDDE2["rpg"]["maxfacenewenemydist"] = 50;
  level._id_9F0B40FBEB9CDDE2["firebug"] = [];
  level._id_9F0B40FBEB9CDDE2["firebug"]["maxfaceenemydist"] = 320;
  level._id_9F0B40FBEB9CDDE2["firebug"]["maxfacenewenemydist"] = 32;
  level._id_9F0B40FBEB9CDDE2["jugg"] = [];
  level._id_9F0B40FBEB9CDDE2["jugg"]["maxfaceenemydist"] = 2048;
  level._id_9F0B40FBEB9CDDE2["jugg"]["maxfacenewenemydist"] = 512;
  level._id_0D0F9A08690A8075 = [];
  level._id_0D0F9A08690A8075[0] = getdvarint("dvar_9F60E77C0E91DA76", -1);
  level._id_0D0F9A08690A8075[1] = getdvarint("dvar_9F60E67C0E91D843", -1);
  level._id_0D0F9A08690A8075[2] = getdvarint("dvar_9F60E57C0E91D610", -1);
  _func_468420FFD9205765(getdvarint("dvar_39FE1E5FE7D89E6E", 8) * 1000);
  _func_9F617BB5CF59DBF0(getdvarint("dvar_FA88BD128990512B", 200));
}

_id_77B8B5AF85F319D8(_id_AB5627A359C23F27) {
  if(isDefined(_id_AB5627A359C23F27["maxfaceenemydist"]))
    self.maxfaceenemydist = _id_AB5627A359C23F27["maxfaceenemydist"];

  if(isDefined(_id_AB5627A359C23F27["maxfacenewenemydist"]))
    self.maxfacenewenemydist = _id_AB5627A359C23F27["maxfacenewenemydist"];

  if(isDefined(_id_AB5627A359C23F27["maxengagementdist"]) && isDefined(_id_AB5627A359C23F27["maxengagementfalloff"]))
    self setengagementmaxdist(_id_AB5627A359C23F27["maxengagementdist"], _id_AB5627A359C23F27["maxengagementfalloff"]);

  if(isDefined(_id_AB5627A359C23F27["minengagementdist"]) && isDefined(_id_AB5627A359C23F27["minengagementfalloff"]))
    self setengagementmindist(_id_AB5627A359C23F27["minengagementdist"], _id_AB5627A359C23F27["minengagementfalloff"]);

  if(isDefined(_id_AB5627A359C23F27["maxengagementshootdist"]))
    self _meth_9215CE6FC83759B9(_id_AB5627A359C23F27["maxengagementshootdist"]);
}

_id_223455A2AEFD83E4() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    self getenemyinfo(level.players[_id_AC0E594AC96AA3A8]);
}

_id_FB117F8CE12C38E9(aitype) {
  if(isDefined(aitype)) {
    if(issubstr(aitype, "tier1"))
      return level._id_0D0F9A08690A8075[0];
    else if(issubstr(aitype, "tier2"))
      return level._id_0D0F9A08690A8075[1];
    else if(issubstr(aitype, "tier3"))
      return level._id_0D0F9A08690A8075[2];
  }

  return;
}

_id_6F88796D2F078DA4(_id_57F8B4C321038A32, _id_B5DB8D5BF4B6B13F, _id_B81088B6A13A4E22) {
  _id_D6EE3E704C6731D4 = scripts\engine\utility::random(_id_57F8B4C321038A32);

  if(isDefined(_id_B5DB8D5BF4B6B13F)) {
    if(isarray(_id_B5DB8D5BF4B6B13F))
      _id_D6EE3E704C6731D4 = scripts\engine\utility::random(_id_B5DB8D5BF4B6B13F);
    else
      _id_D6EE3E704C6731D4 = _id_B5DB8D5BF4B6B13F;
  }

  if(isDefined(_id_B81088B6A13A4E22))
    level thread[[_id_B81088B6A13A4E22]](_id_D6EE3E704C6731D4);

  for(;;) {
    _id_53E80078572723E9 = 0;

    foreach(ai in _id_57F8B4C321038A32) {
      if(!isalive(ai) || ai.health < 1) {
        continue;
      }
      _id_53E80078572723E9 = 1;
    }

    if(!_id_53E80078572723E9) {
      return;
    }
    if(isDefined(_id_D6EE3E704C6731D4) && isalive(_id_D6EE3E704C6731D4)) {
      foreach(ai in _id_57F8B4C321038A32) {
        if(!isDefined(ai) || !isalive(ai) || ai == _id_D6EE3E704C6731D4 || ai.health < 1) {
          continue;
        }
        if(!isDefined(ai.goalent) || ai.goalent != _id_D6EE3E704C6731D4) {
          ai setgoalentity(_id_D6EE3E704C6731D4);
          ai.goalent = _id_D6EE3E704C6731D4;
        }

        _id_084031F98354ED18 = 0;
        players = level.players;

        if(_func_A794FCF9545F2062()) {
          team = ai.team;
          players = _func_B1EEF70090B5B7B5(_id_D6EE3E704C6731D4.origin, _id_D6EE3E704C6731D4.goalradius, _func_869CCB4E3451B8C6(["etype_player"]), [], team);

          if(players.size)
            _id_084031F98354ED18 = 1;
        } else {
          foreach(player in players) {
            if(distance2dsquared(_id_D6EE3E704C6731D4.origin, player.origin) < squared(_id_D6EE3E704C6731D4.goalradius))
              _id_084031F98354ED18 = 1;
          }
        }

        ai.goalradius = 256;

        if(_id_084031F98354ED18 || distance2dsquared(_id_D6EE3E704C6731D4.origin, ai.origin) < squared(ai.goalradius)) {
          if(distance2dsquared(_id_D6EE3E704C6731D4.origin, ai.origin) < squared(ai.goalradius))
            ai.goalradius = 1200;
        }
      }
    } else {
      _id_57F8B4C321038A32 = scripts\engine\utility::array_removeundefined(_id_57F8B4C321038A32);

      if(!_id_57F8B4C321038A32.size) {
        return;
      }
      _id_D6EE3E704C6731D4 = scripts\engine\utility::random(_id_57F8B4C321038A32);

      if(isDefined(_id_B5DB8D5BF4B6B13F)) {
        alive = 0;

        foreach(guy in _id_B5DB8D5BF4B6B13F) {
          if(!isalive(guy) || guy.health < 1) {
            continue;
          }
          alive = 1;
        }

        if(alive) {
          if(isarray(_id_B5DB8D5BF4B6B13F))
            _id_D6EE3E704C6731D4 = scripts\engine\utility::random(_id_B5DB8D5BF4B6B13F);
          else
            _id_D6EE3E704C6731D4 = _id_B5DB8D5BF4B6B13F;
        }
      }

      if(isDefined(_id_B81088B6A13A4E22))
        level thread[[_id_B81088B6A13A4E22]](_id_D6EE3E704C6731D4);
    }

    wait 1;
  }
}

_id_0E942BEA168527F6(trigger) {
  enabled = getdvarint("dvar_3D2D2D527CF543F9", 1);

  if(!enabled) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "makeEnterExitTrigger"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "makeEnterExitTrigger")]](trigger, ::_id_3739410667DCA712, ::_id_9643C9B25F0E0C84);
}

_id_3739410667DCA712(soldier, trigger) {
  if(!isagent(soldier) || !isalive(soldier)) {
    return;
  }
  if(istrue(soldier._id_ED331803DB44891B)) {
    soldier._id_E1B2653A504955E9 = 1;
    soldier allowedstances("stand");
  }

  if(_id_F0CB3329588D4015(soldier)) {
    return;
  }
  soldier._id_D1C85FFAE04D3AE0 = spawnStruct();
  soldier._id_D1C85FFAE04D3AE0._id_B6AF6A0DE2C14DC3 = soldier getbasearchetype();
  soldier._id_D1C85FFAE04D3AE0._id_98ADD129A7ECB962 = soldier._id_98ADD129A7ECB962;
  _id_2186AB5345FA2B64 = "soldier_water";

  if(soldier._id_D1C85FFAE04D3AE0._id_B6AF6A0DE2C14DC3 == "juggernaut")
    _id_2186AB5345FA2B64 = "juggernaut_water";

  soldier setoverridearchetype("default", _id_2186AB5345FA2B64, 0);
  soldier._id_98ADD129A7ECB962 = 0;
}

_id_9643C9B25F0E0C84(soldier, trigger) {
  if(!isagent(soldier)) {
    return;
  }
  if(!isalive(soldier)) {
    return;
  }
  if(istrue(soldier._id_E1B2653A504955E9))
    soldier allowedstances("crouch", "stand");

  if(_id_F0CB3329588D4015(soldier)) {
    return;
  }
  _id_5DEF1EC79437CE3C = "soldier";

  if(isDefined(soldier._id_D1C85FFAE04D3AE0) && isDefined(soldier._id_D1C85FFAE04D3AE0._id_B6AF6A0DE2C14DC3))
    _id_5DEF1EC79437CE3C = soldier._id_D1C85FFAE04D3AE0._id_B6AF6A0DE2C14DC3;

  soldier setoverridearchetype("default", _id_5DEF1EC79437CE3C, 0);

  if(isDefined(soldier._id_D1C85FFAE04D3AE0) && isDefined(soldier._id_D1C85FFAE04D3AE0._id_98ADD129A7ECB962))
    soldier._id_98ADD129A7ECB962 = soldier._id_D1C85FFAE04D3AE0._id_98ADD129A7ECB962;
}

_id_F0CB3329588D4015(soldier) {
  enabled = getdvarint("dvar_CB527A1B28E21DFD", 0);

  if(!enabled)
    return 0;

  _id_435A2CFD34CF4935 = soldier getbasearchetype();

  if(_id_435A2CFD34CF4935 == "juggernaut")
    return 0;

  return 1;
}

_id_30A0D7CA3FAE40CC(_id_8E5A9B658FA525ED, agent_type) {
  if(isDefined(_id_8E5A9B658FA525ED)) {
    switch (_id_8E5A9B658FA525ED) {
      case "aq":
        return "team_hundred_ninety_five";
      case "mx":
      case "ru":
      case "cartel":
        return "team_hundred_ninety_four";
      case "pmc":
        return "team_hundred_ninety_eight";
      case "merc":
      case "biolab":
        return "team_hundred_ninety_nine";
    }
  }

  if(!isDefined(_id_8E5A9B658FA525ED)) {
    if(issubstr(agent_type, "_aq"))
      return "team_hundred_ninety_five";
    else if(issubstr(agent_type, "_ru") || issubstr(agent_type, "_mx") || issubstr(agent_type, "_cartel"))
      return "team_hundred_ninety_four";
    else if(issubstr(agent_type, "_biolab"))
      return "team_hundred_ninety_seven";
    else if(issubstr(agent_type, "_pmc"))
      return "team_hundred_ninety_eight";
    else if(issubstr(agent_type, "_merc"))
      return "team_hundred_ninety_nine";
    else
      return "team_hundred_ninety_five";
  }
}

getaverageorigin(_id_4A6E62AA769AD290) {
  _id_D8DE9486A89D3332 = (0, 0, 0);

  if(!_id_4A6E62AA769AD290.size)
    return undefined;

  foreach(ent in _id_4A6E62AA769AD290)
  _id_D8DE9486A89D3332 = _id_D8DE9486A89D3332 + ent.origin;

  _id_16C3B0338E3E0298 = int(_id_D8DE9486A89D3332[0] / _id_4A6E62AA769AD290.size);
  _id_16C3B1338E3E04CB = int(_id_D8DE9486A89D3332[1] / _id_4A6E62AA769AD290.size);
  _id_16C3B2338E3E06FE = int(_id_D8DE9486A89D3332[2] / _id_4A6E62AA769AD290.size);
  _id_D8DE9486A89D3332 = (_id_16C3B0338E3E0298, _id_16C3B1338E3E04CB, _id_16C3B2338E3E06FE);
  return _id_D8DE9486A89D3332;
}

_id_9EC5F9CFC835208E() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dmz_threat_bias", "init"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dmz_threat_bias", "init")]]();
  else
    level thread _id_B54B8BAA376D3DBB();
}

_id_B54B8BAA376D3DBB() {
  level._id_E354254E70A6B849 = [];
  level._id_E354254E70A6B849[level._id_E354254E70A6B849.size] = "hs";
  level._id_E354254E70A6B849[level._id_E354254E70A6B849.size] = "sc";
  _id_841F001AE930B5E4("enemy");
  _id_841F001AE930B5E4("huntSquad");
  _id_841F001AE930B5E4("ai_phalanx");
  _id_841F001AE930B5E4("ai_black_mous");
  _id_841F001AE930B5E4("ai_white_lotus");
  _id_841F001AE930B5E4("player_hs0_sc0");
  _id_841F001AE930B5E4("player_hs1_sc0");
  _id_841F001AE930B5E4("player_hs0_sc1");
  _id_841F001AE930B5E4("player_hs1_sc1");
  _id_3ACCE87FED325C8F("huntSquad", "enemy");
  _id_3ACCE87FED325C8F("enemy", "huntSquad");
  _id_3ACCE87FED325C8F("player_hs1_sc0", "huntSquad");
  _id_3ACCE87FED325C8F("player_hs1_sc1", "huntSquad");
  _id_55DAED3B1ECCB970 = getdvarint("dvar_4620216A9470AE72", -5000);
  _id_B5FF3BFB184D0D01("enemy", "Drone", _id_55DAED3B1ECCB970);
  _id_B5FF3BFB184D0D01("huntSquad", "Drone", _id_55DAED3B1ECCB970);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dmz_threat_bias", "customNationality"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dmz_threat_bias", "customNationality")]]();

  level thread _id_255E967912274247();
}

_id_255E967912274247() {
  level waittill("matchStartTimer_done");

  foreach(player in level.players)
  _id_03A458AF8AB69F4E(player);
}

_id_841F001AE930B5E4(group) {
  createthreatbiasgroup(group);
}

_id_58203C3739D2D0C6(agent, group, _id_33D9708E7F06D603) {
  if(!isDefined(agent)) {
    return;
  }
  if(istrue(agent._id_DAF4907411A07A6C)) {
    return;
  }
  if(isagent(agent))
    agent setthreatbiasgroup(group);
  else if(isint(agent)) {
    _id_782866E364DCD2EF = _id_2B0E82156FA6075B(agent);
    _id_782866E364DCD2EF.threatbiasgroup = group;
  }

  if(istrue(_id_33D9708E7F06D603))
    agent._id_DAF4907411A07A6C = 1;
}

_id_CA2ADCE5C7865C20(player, group) {
  if(!isDefined(player)) {
    return;
  }
  player setthreatbiasgroup(group);
}

_id_B5FF3BFB184D0D01(_id_E59027B19D80C1EB, _id_E59028B19D80C41E, _id_8CEF9940EC2F62A0) {
  if(!isDefined(_id_E59027B19D80C1EB) || !isDefined(_id_E59028B19D80C41E)) {
    return;
  }
  if(!isDefined(_id_8CEF9940EC2F62A0)) {
    return;
  }
  setthreatbias(_id_E59027B19D80C1EB, _id_E59028B19D80C41E, _id_8CEF9940EC2F62A0);
}

_id_3ACCE87FED325C8F(_id_B3962262BA71D0AD, _id_032A96BF508FBD2F) {
  if(!isDefined(_id_B3962262BA71D0AD) || !isDefined(_id_032A96BF508FBD2F)) {
    return;
  }
  setignoremegroup(_id_B3962262BA71D0AD, _id_032A96BF508FBD2F);
}

_id_46C0DE7595D8CAB2(player, group) {
  return player._id_C6F91882127B4281[group];
}

_id_AB491B16F8423C8E(player, group, status) {
  player._id_C6F91882127B4281[group] = status;
}

_id_ED5140C225D4F337(player) {
  groupname = "player";

  foreach(group in level._id_E354254E70A6B849)
  groupname = groupname + "_" + group + _id_46C0DE7595D8CAB2(player, group);

  return groupname;
}

_id_03A458AF8AB69F4E(player) {
  player._id_C6F91882127B4281 = [];

  foreach(group in level._id_E354254E70A6B849)
  player._id_C6F91882127B4281[group] = 1;

  _id_CC91F3EAEB2C809C = _id_ED5140C225D4F337(player);
  _id_CA2ADCE5C7865C20(player, _id_CC91F3EAEB2C809C);
}

_id_1BCA33010B895B0B(_id_8E5A9B658FA525ED) {
  switch (_id_8E5A9B658FA525ED) {
    case "merc":
      return "sc";
  }
}
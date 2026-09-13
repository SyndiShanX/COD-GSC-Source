/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\weapon.gsc
***********************************************/

getattachmenttype(_id_659F734FC2A248FF) {
  if(!isDefined(_id_659F734FC2A248FF))
    return "";

  _id_F98BAFD67872A38C = tablelookup("mp/attachmenttable.csv", 4, _id_659F734FC2A248FF, 2);
  return _id_F98BAFD67872A38C;
}

getcompleteweaponnamenoalt(objweapon) {
  if(!isDefined(objweapon))
    return "";

  _id_1B47EC827F34BD5B = getcompleteweaponname(objweapon);

  if(istrue(objweapon.isalternate))
    _id_1B47EC827F34BD5B = getsubstr(_id_1B47EC827F34BD5B, 4);

  return _id_1B47EC827F34BD5B;
}

getweapontype(weapon) {
  if(!isDefined(weapon))
    return "";

  if(iscacprimaryweapon(weapon))
    return "primary";

  if(iscacsecondaryweapon(weapon))
    return "secondary";

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
    return "killstreak";

  if(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(weapon))
    return "killstreak_deploy";

  if(_id_02AABAC61F2AE422::_id_FCEAA660B4DA1C2B(weapon))
    return "super_deploy";

  if(issuperweapon(weapon))
    return "super";

  if(isgamemodeweapon(weapon))
    return "gamemode";

  if(weapon == "iw8_turret_50cal_mp")
    return "turret";

  if(islevelweapon(weapon))
    return "level";

  if(scripts\engine\utility::string_starts_with(weapon, "destructible_"))
    return "destructible";

  if(isvehicleweapon(weapon))
    return "vehicle";

  if(isspecialmeleeweapon(weapon) || weapon == "iw8_defibrillator_mp")
    return "special_melee";

  if(isenvironmentweapon(weapon))
    return "environment";

  _id_11D2F075E9A0E643 = getequipmenttype(weapon);

  if(isDefined(_id_11D2F075E9A0E643))
    return _id_11D2F075E9A0E643;

  if(weapon == "none" || issubstr(weapon, "execution"))
    return "worldspawn";

  if(weapon == "bomb_site_mp")
    return weapon;

  if(weapon == "iw9_racecar_mp")
    return weapon;

  if(weapon == "iw8_gunless" || weapon == "iw8_gunless_infil" || weapon == "iw9_gunless_quickdrop_mp")
    return "gunless";

  if(weapon == "iw9_armor_plate_deploy_mp")
    return weapon;

  if(weapon == "trophy_submunition")
    return "super";

  if(weapon == "flare_dmz_pmc")
    return "super";

  if(weapon == "chopper_gunner_turret_ballistics_dmz")
    return "turret";

  if(weapon == "airdrop_escort_turret_ballistics_champion")
    return "turret";

  if(weapon == "samsite_missile_weapon")
    return "turret";

  if(weapon == "pac_sentry_turret_dmz_biolab")
    return "turret";

  if(weapon == "chopper_gunner_turret_ufo_mp")
    return "turret";

  if(weapon == "swampmonster_spit")
    return "turret";

  if(weapon == "chopper_gunner_turret_ufo_lg_mp")
    return "turret";

  if(isfistsonly(weapon))
    return "fists";

  if(weapon == "zombie_ranged_attack_mp" || weapon == "zombie_melee_attack_mp")
    return "zombie";

  if(weapon == "iw9_nukecore_artifact_mp")
    return weapon;
}

getequipmenttype(objweapon) {
  _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(objweapon);
  _id_57C4945B399F53F4 = undefined;

  switch (_id_49E6EF3EDADD524E) {
    case "claymore_radial":
    case "snowball":
    case "frag_grenade":
    case "thermite_av":
    case "shuriken":
    case "rock":
    case "thermite":
    case "at_mine":
    case "claymore":
    case "semtex":
    case "bunkerbuster":
    case "at_mine_ap":
    case "molotov":
    case "thermite_ap":
    case "throwstar":
    case "throwingknife":
    case "c4":
      _id_57C4945B399F53F4 = "lethal";
      break;
    case "deployed_decoy":
    case "offhand_spotter_scope":
    case "magsnap":
    case "thermal_phone":
    case "adrenaline":
    case "decoy_grenade":
    case "geiger_counter":
    case "pball":
    case "flash_grenade":
    case "emp_grenade":
    case "concussion_grenade":
    case "gas":
    case "hb_sensor":
    case "shock_stick":
    case "snapshot_grenade":
    case "smoke_grenade":
      _id_57C4945B399F53F4 = "tactical";
      break;
    case "adrenaline_br_fake":
    case "bandage_br_fake":
    case "gesture_vest_plate_br":
    case "ks_remote_drone":
      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        _id_57C4945B399F53F4 = "equipment_other";

      break;
    default:
      break;
  }

  return _id_57C4945B399F53F4;
}

isenvironmentweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "gas_can_toxic_mp":
    case "gas_can_mp":
    case "minefield_mp":
    case "danger_circle_br":
      return 1;
    default:
      break;
  }

  return 0;
}

issuperweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  return isDefined(scripts\mp\supers::getsuperrefforsuperweapon(weapon));
}

isakimbo(weapon) {
  return _func_F30A6D3194F97C09(weapon, "specialty_akimbo");
}

issuperdamagesource(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(issuperweapon(weapon))
    return 1;

  if(weaponname == "chargemode_mp")
    return 1;

  if(weaponname == "micro_turret_gun_mp")
    return 1;

  if(weaponname == "super_trophy_mp")
    return 1;

  return 0;
}

isgamemodeweapon(weapon) {
  if(isbombsiteweapon(weapon))
    return 1;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "missile_silo_missile_proj":
    case "missile_silo_cluster_missile_proj":
    case "iw9_lm_dblmg":
    case "iw8_lm_dblmg":
    case "iw8_lm_kilo121jugg_mp":
    case "iw9_cyberemp_mp":
    case "danger_circle_br":
    case "iw7_tdefball_mp":
      return 1;
    default:
      return 0;
  }

  return 0;
}

islevelweapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "iw8_la_gromeoks_mp":
      return 1;
    case "iw9_drown_mp":
      return 1;
    default:
      return 0;
  }

  return 0;
}

getweapongroup(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon))
    return "other";

  if(isstring(weapon) && (weapon == "none" || weapon == "alt_none"))
    return "other";

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  group = _id_2669878CF5A1B6BC::weapongroupmap(_id_AB501F397D3CD312);

  if(!isDefined(group)) {
    if(issuperweapon(weapon))
      group = "super";
    else if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
      group = "killstreak";
    else if(isgamemodeweapon(weapon))
      group = "gamemode";
    else if(isballisticspecial(weapon))
      group = "weapon_ballisticSpecial";
    else if(isdragonsbreath(weapon))
      group = "weapon_dragonsBreath";
    else if(_id_0D3C77884D93D850(weapon))
      group = "weapon_underwater";
    else
      group = "other";
  }

  return group;
}

_id_0D3C77884D93D850(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "iw9_me_diveknife_mp" || weaponname == "iw9_swimfists_mp";
}

_id_3F15E5E526FF94CE(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "iw9_me_climbfists";
}

_id_1E9278BA699927F7(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "iw9_pi_stimpistol_mp";
}

isdragonsbreath(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = "";

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "dragonsbreath_mp";
}

isballisticspecial(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "semtex_xmike109_splash_mp":
    case "thermite_xmike109_radius_mp":
    case "thermite_bolt_mp":
    case "thermite_bolt_radius_mp":
    case "semtex_bolt_splash_mp":
    case "semtex_bolt_mp":
    case "semtex_xmike109_mp":
    case "thermite_xmike109_mp":
      return 1;
    default:
      return 0;
  }
}

getallselectableattachments(weapon) {
  weaponname = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  _id_496432274D3CA31E = strtok(weaponname, "_");
  _id_E21419DD1AEB0D9A = _id_496432274D3CA31E[2];
  attachments = [];

  foreach(_id_DF6D8E005B4B8020, attachment in level.weaponattachments) {
    if(issubstr(_id_DF6D8E005B4B8020, _id_E21419DD1AEB0D9A))
      attachments[attachments.size] = _id_DF6D8E005B4B8020;
  }

  return attachments;
}

getdefaultweaponbasename(basename) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(basename);

  if(isDefined(level.weaponmapdata[_id_AB501F397D3CD312]) && isDefined(level.weaponmapdata[_id_AB501F397D3CD312].assetname))
    basename = level.weaponmapdata[_id_AB501F397D3CD312].assetname;

  return basename;
}

getweaponbasenamescript(weapon) {
  if(isweapon(weapon))
    return weapon.basename;

  if(isstring(weapon) && weapon == "none")
    return "none";

  return getweaponbasename(weapon);
}

getweapongunsmithattachmenttable(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);
  return "mp/gunsmith/" + getsubstr(_id_49E6EF3EDADD524E, 4) + "_attachments.csv";
}

getaltmodeweapon(objweapon) {
  if(isDefined(objweapon.underbarrel))
    return objweapon.underbarrel;

  return undefined;
}

_id_B53839DC08A64FDE(objweapon) {
  if(isDefined(objweapon.underbarrelvarindex))
    return objweapon.underbarrelvarindex;

  return undefined;
}

isaltmodeweapon(weaponname) {
  if(weaponname == "none")
    return 0;

  return weaponinventorytype(weaponname) == "altmode";
}

removealtmodefromweaponname(weaponname) {
  if(isaltmodeweapon(weaponname))
    weaponname = getsubstr(weaponname, 4);

  return weaponname;
}

getvalidextraammoweapons() {
  weaponlist = [];
  _id_BB1809937C416251 = self getweaponslistprimaries();

  foreach(primary in _id_BB1809937C416251) {
    _id_0DD6BF5F9DBA888C = weaponclass(primary);

    if(!_id_2669878CF5A1B6BC::iskillstreakweapon(primary) && _id_0DD6BF5F9DBA888C != "grenade" && _id_0DD6BF5F9DBA888C != "rocketlauncher" && self getweaponammostock(primary) != 0)
      weaponlist[weaponlist.size] = primary;
  }

  return weaponlist;
}

ispickedupweapon(weapon) {
  if(iscacprimaryorsecondary(weapon)) {
    _id_C27E2A04BAB78C1F = undefined;

    if(isweapon(weapon))
      _id_C27E2A04BAB78C1F = getcompleteweaponname(weapon getnoaltweapon());
    else if(isstring(weapon)) {
      _id_C27E2A04BAB78C1F = weapon;

      if(issubstr(_id_C27E2A04BAB78C1F, "alt_"))
        _id_C27E2A04BAB78C1F = getsubstr(_id_C27E2A04BAB78C1F, 4, weapon.size);
    }

    _id_0D721C63A9570D5C = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == _id_C27E2A04BAB78C1F;
    _id_7DF1C1394810BF14 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == _id_C27E2A04BAB78C1F;

    if(!_id_0D721C63A9570D5C && !_id_7DF1C1394810BF14)
      return 1;
  }

  return 0;
}

iscacprimaryweapon(weapon) {
  return iscacprimaryweapongroup(getweapongroup(weapon), weapon);
}

iscacprimaryweapongroup(_id_CF4209C200F8BBF4, weapon) {
  switch (_id_CF4209C200F8BBF4) {
    case "weapon_ballisticSpecial":
    case "weapon_dragonsBreath":
    case "weapon_melee":
    case "weapon_battle":
    case "weapon_smg":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_dmr":
    case "weapon_assault":
      return 1;
    default:
      return 0;
  }
}

iscacsecondaryweapon(weapon) {
  return iscacsecondaryweapongroup(getweapongroup(weapon), weapon);
}

iscacsecondaryweapongroup(_id_CF4209C200F8BBF4, weapon) {
  switch (_id_CF4209C200F8BBF4) {
    case "weapon_pistol":
    case "weapon_projectile":
      return 1;
    case "weapon_melee2":
      return !isspecialmeleeweapon(weapon);
    case "weapon_underwater":
      return 1;
    default:
      return 0;
  }
}

iscacprimaryorsecondary(weapon) {
  _id_CF4209C200F8BBF4 = getweapongroup(weapon);
  return iscacprimaryweapongroup(_id_CF4209C200F8BBF4, weapon) || iscacsecondaryweapongroup(_id_CF4209C200F8BBF4, weapon);
}

iscacmeleeweapon(weapon) {
  group = getweapongroup(weapon);
  return group == "weapon_melee" || group == "weapon_melee2";
}

enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls))
    self.weaponlasercalls = 0;

  self.weaponlasercalls++;
  self laseron();
}

disableweaponlaser() {
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

weaponperkmap(_id_4BB9768282D4260D) {
  if(isDefined(level.weaponmapdata[_id_4BB9768282D4260D]) && isDefined(level.weaponmapdata[_id_4BB9768282D4260D].perk))
    return level.weaponmapdata[_id_4BB9768282D4260D].perk;

  return undefined;
}

getrandomweaponfromgroup(group) {
  index = randomintrange(0, level.weapongroupdata[group].size);
  return level.weapongroupdata[group][index];
}

getweaponvariantids(_id_4BB9768282D4260D, _id_60EE6A5BAE11A91B) {
  if(!isDefined(_id_60EE6A5BAE11A91B))
    _id_60EE6A5BAE11A91B = [];

  id = 1;
  _id_C0AA7602B6BBC954 = [];

  for(;;) {
    _id_A6ED1602A5107749 = _id_4BB9768282D4260D + "|" + id;

    if(!isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749])) {
      break;
    }

    if(!level.weaponlootmapdata[_id_A6ED1602A5107749].islocked && !scripts\engine\utility::array_contains(_id_60EE6A5BAE11A91B, id))
      _id_C0AA7602B6BBC954[_id_C0AA7602B6BBC954.size] = id;

    id++;
  }

  return _id_C0AA7602B6BBC954;
}

getweaponrandomvariantid(_id_4BB9768282D4260D, _id_60EE6A5BAE11A91B) {
  if(!isDefined(_id_60EE6A5BAE11A91B))
    _id_60EE6A5BAE11A91B = [];

  id = 0;
  _id_7C7BEA4A64413C81 = getweaponvariantids(_id_4BB9768282D4260D, _id_60EE6A5BAE11A91B);

  if(_id_7C7BEA4A64413C81.size > 0)
    id = _id_7C7BEA4A64413C81[randomint(_id_7C7BEA4A64413C81.size)];

  return id;
}

weaponexistsinstatstable(_id_4BB9768282D4260D) {
  return isDefined(level.weaponmapdata[_id_4BB9768282D4260D]);
}

weaponisValid(_id_4BB9768282D4260D, variantid) {
  _id_E2027D25381775DD = weaponexistsinstatstable(_id_4BB9768282D4260D);
  _id_36B5867A265820CE = 1;

  if(_id_E2027D25381775DD) {
    if(isDefined(isDefined(variantid)) && variantid > 0) {
      _id_A6ED1602A5107749 = _id_4BB9768282D4260D + "|" + variantid;
      _id_36B5867A265820CE = isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749]) && !istrue(level.weaponlootmapdata[_id_A6ED1602A5107749].islocked);
    }
  }

  return _id_E2027D25381775DD && _id_36B5867A265820CE;
}

weaponattachremoveextraattachments(attachments, weapon) {
  _id_59BF6A1EAE2B42D8 = [];

  foreach(attachment in attachments) {
    _id_F08EEC5E41ED914F = _id_2669878CF5A1B6BC::attachmentmap_toextra(attachment);

    if(isDefined(_id_F08EEC5E41ED914F))
      _id_59BF6A1EAE2B42D8[_id_59BF6A1EAE2B42D8.size] = _id_F08EEC5E41ED914F;
  }

  _id_A7FA676E63077B06 = [];

  foreach(attachment in attachments) {
    _id_22CC204990BC10A0 = 0;

    foreach(_id_79B6F061BE629059 in _id_59BF6A1EAE2B42D8) {
      foreach(_id_DB701CDBDBE476AC in _id_79B6F061BE629059) {
        if(attachment == _id_DB701CDBDBE476AC) {
          _id_22CC204990BC10A0 = 1;
          break;
        }
      }
    }

    if(!_id_22CC204990BC10A0)
      _id_A7FA676E63077B06[_id_A7FA676E63077B06.size] = attachment;
  }

  return _id_A7FA676E63077B06;
}

isattachmentsniperscopedefault(weaponname, _id_FF180C307F2BAFD3) {
  _id_67F14F8315CB0F2F = strtok(weaponname, "_");
  return isattachmentsniperscopedefaulttokenized(_id_67F14F8315CB0F2F, _id_FF180C307F2BAFD3);
}

isattachmentsniperscopedefaulttokenized(_id_F684B277677B66EB, _id_FF180C307F2BAFD3) {
  result = 0;

  if(_id_F684B277677B66EB.size && isDefined(_id_FF180C307F2BAFD3)) {
    _id_FE8F7703F6313ED4 = 0;

    if(_id_F684B277677B66EB[0] == "alt")
      _id_FE8F7703F6313ED4 = 1;

    if(_id_F684B277677B66EB.size >= 3 + _id_FE8F7703F6313ED4 && (_id_F684B277677B66EB[_id_FE8F7703F6313ED4] == "iw6" || _id_F684B277677B66EB[_id_FE8F7703F6313ED4] == "iw7")) {
      if(weaponclass(_id_F684B277677B66EB[_id_FE8F7703F6313ED4] + "_" + _id_F684B277677B66EB[_id_FE8F7703F6313ED4 + 1] + "_" + _id_F684B277677B66EB[_id_FE8F7703F6313ED4 + 2]) == "sniper")
        result = _id_F684B277677B66EB[_id_FE8F7703F6313ED4 + 1] + "scope" == _id_FF180C307F2BAFD3;
    }
  }

  return result;
}

getnonopticattachmentlistbasenames() {
  _id_3A974E1DFD9D5CCC = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(index = 0; index < _id_977F24E61599CBBA; index++) {
    _id_659F734FC2A248FF = tablelookupbyrow("mp/attachmenttable.csv", index, 5);
    group = tablelookupbyrow("mp/attachmenttable.csv", index, 2);

    if(_id_659F734FC2A248FF != "" && group != "none" && group != "rail" && !scripts\engine\utility::array_contains(_id_3A974E1DFD9D5CCC, _id_659F734FC2A248FF))
      _id_3A974E1DFD9D5CCC[_id_3A974E1DFD9D5CCC.size] = _id_659F734FC2A248FF;
  }

  return _id_3A974E1DFD9D5CCC;
}

getopticattachmentlistbasenames() {
  if(isDefined(level.opticattachmentbasenames))
    return level.opticattachmentbasenames;

  _id_3A974E1DFD9D5CCC = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(index = 0; index < _id_977F24E61599CBBA; index++) {
    group = tablelookupbyrow("mp/attachmenttable.csv", index, 2);
    _id_659F734FC2A248FF = tablelookupbyrow("mp/attachmenttable.csv", index, 5);

    if(_id_659F734FC2A248FF != "" && group == "rail" && !scripts\engine\utility::array_contains(_id_3A974E1DFD9D5CCC, _id_659F734FC2A248FF))
      _id_3A974E1DFD9D5CCC[_id_3A974E1DFD9D5CCC.size] = _id_659F734FC2A248FF;
  }

  level.opticattachmentbasenames = _id_3A974E1DFD9D5CCC;
  return level.opticattachmentbasenames;
}

mapweapon(objweapon, inflictor, _id_0A2C7A399AE430EB) {
  _id_EEF5AD438E5FA0C2 = objweapon;

  if(!isDefined(objweapon))
    _id_EEF5AD438E5FA0C2 = nullweapon();

  _id_EA958BD2FA62A2FA = 0;

  if(_id_EEF5AD438E5FA0C2.basename != "none") {
    if(isDefined(inflictor) && !isPlayer(inflictor)) {
      _id_BE014A8D5A4F68F4 = getaltmodeweapon(objweapon);

      if(isDefined(_id_BE014A8D5A4F68F4)) {
        switch (_id_BE014A8D5A4F68F4) {
          case "ub_gl_conc":
          case "ub_gl_conc_scharlie":
          case "ub_gl_conc_mini":
          case "ub_gl_conc_akilo":
            _id_EEF5AD438E5FA0C2 = makeweapon("concussion_grenade_mp");
            break;
          case "ub_gl_flash_scharlie":
          case "ub_gl_flash_mini":
          case "ub_gl_flash_akilo":
          case "ub_gl_flash":
            _id_EEF5AD438E5FA0C2 = makeweapon("flash_grenade_mp");
            break;
          case "ub_gl_snap_scharlie":
          case "ub_gl_snap_mini":
          case "ub_gl_snap_akilo":
          case "ub_gl_snap":
            _id_EEF5AD438E5FA0C2 = makeweapon("snapshot_grenade_mp");
            break;
          case "ub_gl_db_scharlie":
          case "ub_gl_db_mini":
          case "ub_gl_db_akilo":
          case "ub_gl_db":
            _id_EEF5AD438E5FA0C2 = makeweapon("thermite_mp");
            break;
          case "ub_gl_semtex_akilo":
          case "ub_gl_semtex":
          case "ub_gl_semtex_scharlie":
          case "ub_gl_semtex_mini":
            _id_EEF5AD438E5FA0C2 = makeweapon("semtex_mp");
            break;
          case "ub_gl_drill_scharlie":
          case "ub_gl_drill_mini":
          case "ub_gl_drill_akilo":
          case "ub_gl_drill":
            _id_EEF5AD438E5FA0C2 = makeweapon("bunkerbuster_mp");
            break;
        }
      }
    }

    switch (_id_EEF5AD438E5FA0C2.basename) {
      case "pop_rocket_proj_mp":
        _id_EEF5AD438E5FA0C2 = makeweapon("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        _id_EEF5AD438E5FA0C2 = makeweapon("iw8_turret_50cal_mp");
        break;
      case "ks_remote_drone_mp":
        _id_EEF5AD438E5FA0C2 = nullweapon();
        break;
    }
  } else if(isDefined(inflictor)) {
    if(isDefined(inflictor.objweapon)) {
      _id_EEF5AD438E5FA0C2 = makeweapon(inflictor.objweapon.basename);
      _id_EA958BD2FA62A2FA = 1;
    } else if(isDefined(inflictor.weapon_name)) {
      _id_EEF5AD438E5FA0C2 = makeweapon(inflictor.weapon_name);
      _id_EA958BD2FA62A2FA = 1;
    }
  }

  if(_id_EA958BD2FA62A2FA && !istrue(_id_0A2C7A399AE430EB))
    _id_EEF5AD438E5FA0C2 = mapweapon(_id_EEF5AD438E5FA0C2, inflictor, 1);

  return _id_EEF5AD438E5FA0C2;
}

attachmentsfilterforstats(attachments, weapon) {
  _id_7CB19F95DBC68942 = [];

  if(!isDefined(attachments))
    return _id_7CB19F95DBC68942;

  foreach(a in attachments) {
    if(attachmentlogsstats(a, weapon))
      _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = a;
  }

  return _id_7CB19F95DBC68942;
}

attachmentlogsstats(attachment, weapon) {
  if(_id_2669878CF5A1B6BC::attachmentiscosmetic(attachment))
    return 0;

  if(!attachmentisselectable(weapon, attachment))
    return 0;

  if(scripts\engine\utility::string_starts_with(attachment, "laststand_"))
    return 0;

  return 1;
}

weaponhasattachment(weapon, _id_659F734FC2A248FF) {
  weaponattachments = getweaponattachments(weapon);

  foreach(attachment in weaponattachments) {
    if(attachment == _id_659F734FC2A248FF)
      return 1;
  }

  return 0;
}

_id_8A4F25FB9D4C43C8(weapon) {
  if(!isDefined(weapon))
    return 0;

  group = getweapongroup(weapon);

  switch (group) {
    case "weapon_shotgun":
      if(weapon.basename == "iw9_sh_mviktor_mp")
        return 1;
      else
        return 0;
    case "weapon_melee2":
    case "weapon_melee":
    case "weapon_projectile":
      return 0;
  }

  if(isDefined(weapon.basename)) {
    switch (weapon.basename) {
      case "iw9_pi_swhiskey_mp":
      case "iw9_dm_sbeta_mp":
      case "iw9_la_mike32_mp":
      case "iw9_lm_dblmg_mp":
      case "iw9_dm_crossbow_mp":
        return 0;
    }
  }

  return 1;
}

_id_F851BB47702A91EA(weapon) {
  if(isDefined(weapon.basename)) {
    switch (weapon.basename) {
      case "iw9_sh_charlie725_mp":
        if(weapon hasattachment("trigger_heavy_p14"))
          return 0;

        break;
    }
  }

  return 1;
}

setrecoilscale(_id_B7AB28868F552DF5, _id_01E913F08EA31C3D) {
  if(!isDefined(_id_B7AB28868F552DF5))
    _id_B7AB28868F552DF5 = 0;

  if(!isDefined(self.recoilscale))
    self.recoilscale = _id_B7AB28868F552DF5;
  else
    self.recoilscale = self.recoilscale + _id_B7AB28868F552DF5;

  if(isDefined(_id_01E913F08EA31C3D)) {
    if(isDefined(self.recoilscale) && _id_01E913F08EA31C3D < self.recoilscale)
      _id_01E913F08EA31C3D = self.recoilscale;

    scale = 100 - _id_01E913F08EA31C3D;
  } else
    scale = 100 - self.recoilscale;

  scale = int(clamp(scale, 0, 255));

  if(scale == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(scale);
}

_launchgrenade(weaponname, origin, velocity, _id_C301D652D9A73075, notthrown, _id_997A34F6AB5CB7FC, _id_48A4928BAB483049) {
  grenade = self launchgrenade(weaponname, origin, velocity, _id_C301D652D9A73075, _id_997A34F6AB5CB7FC);

  if(!isDefined(notthrown))
    grenade.notthrown = 1;
  else
    grenade.notthrown = notthrown;

  if(isDefined(_id_48A4928BAB483049))
    grenade.tickpercent = _id_48A4928BAB483049;

  grenade setotherent(self);
  return grenade;
}

grenadethrown(grenade) {
  return !isDefined(grenade.notthrown) || !grenade.notthrown;
}

grenadeinpullback() {
  return !isnullweapon(self getheldoffhand());
}

weaponignoresblastshield(objweapon, shitloc) {
  _id_5C3F9357F11D2223 = objweapon.basename;

  if(issuperweapon(_id_5C3F9357F11D2223))
    return 1;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(_id_5C3F9357F11D2223))
    return 1;

  switch (_id_5C3F9357F11D2223) {
    case "butcher_shout_mp":
    case "butcher_slam_mp":
    case "butcher_headbutt_mp":
    case "snapshot_grenade_mp":
    case "flash_grenade_mp":
    case "concussion_grenade_mp":
    case "gas_mp":
    case "bomb_site_mp":
      return 1;
    default:
      return 0;
  }
}

issinglehitweapon(weaponname) {
  weaponname = getweaponbasenamescript(weaponname);

  switch (weaponname) {
    case "jup_jp22_la_dromeo_mp":
    case "jup_jp26_la_mike32_mp":
    case "iw8_la_kgolf_mp":
    case "iw9_la_kgolf_mp":
    case "iw9_la_mike32_mp":
    case "iw9_la_rpapa7_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_mike32_mp":
    case "iw9_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
      return 1;
    default:
      return 0;
  }
}

attachmentisselectable(weaponobj, attachment) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
  return attachmentisselectablerootname(_id_AB501F397D3CD312, attachment);
}

attachmentisselectablerootname(_id_49E6EF3EDADD524E, attachment) {
  if(isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E]) && isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E].assetname)) {
    slot = _func_6730D890F604CABE(level.weaponmapdata[_id_49E6EF3EDADD524E].assetname, attachment);

    if(isDefined(slot) && slot != -1)
      return isDefined(level.weaponattachments[attachment]);
  }

  return 0;
}

weapongetflinchtype(weaponobj) {
  class = "none";
  _id_6651DEF69449C4A3 = -1;

  if(isDefined(weaponobj) && !isnullweapon(weaponobj)) {
    class = weaponclass(weaponobj);

    switch (class) {
      case "pistol":
        _id_6651DEF69449C4A3 = 1;
        break;
      case "sniper":
        if(getweapongroup(weaponobj) == "weapon_dmr")
          _id_6651DEF69449C4A3 = 3;
        else
          _id_6651DEF69449C4A3 = 4;

        break;
      default:
        _id_6651DEF69449C4A3 = 0;
    }
  }

  return _id_6651DEF69449C4A3;
}

isbombsiteweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "briefcase_defuse_silent_mp":
    case "briefcase_silent_mp":
    case "bomb_site_mp":
    case "briefcase_bomb_mp_nuke":
    case "briefcase_bomb_defuse_mp":
    case "briefcase_bomb_mp":
      return 1;
  }

  return 0;
}

iskillstreakvehicleinflictor(einflictor) {
  return isDefined(einflictor) && isDefined(einflictor.vehiclename) && isDefined(einflictor.streakinfo);
}

weaponbypassspawnprotection(weapon) {
  if(!isDefined(weapon))
    return 0;

  _id_B546524B3FD3D9C9 = 1;
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon) && weaponname != "manual_turret_mp" && weaponname != "pac_sentry_turret_mp" && !_id_2669878CF5A1B6BC::isminigunweapon(weaponname))
    _id_B546524B3FD3D9C9 = 0;

  return _id_B546524B3FD3D9C9;
}

isvehicleweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "motorcycle_cruiser_2008_mp":
    case "scooter_eu_mp":
    case "dirt_bike_mp":
    case "armored_acv_mp":
    case "acv_mp":
    case "hummer_mp":
    case "blima_mp":
    case "palfa_mp":
    case "pickup_2014_mp":
    case "techo_rebel_armor_mp":
    case "cougar_mp":
    case "pwc_mp":
    case "sedan_hatchback_1985_hsk_mp":
    case "sedan_hatchback_1985_mp":
    case "chopped_pickup_mp":
    case "overland_2016_mp":
    case "suv_1996_wkd_mp":
    case "suv_1996_mp":
    case "patrol_boat_wkd_mp":
    case "patrol_boat_mp":
    case "jltv_mg_hsk_mp":
    case "jltv_mg_mp":
    case "jltv_hsk_mp":
    case "jltv_mp":
    case "rhib_mp":
    case "tur_gun_little_bird_left_mp":
    case "tur_gun_little_bird_right_mp":
    case "tur_gun_fav_heavy_mp":
    case "tur_gun_cargo_truck_mp":
    case "bradley_tow_proj_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "mrap_mp":
    case "cargo_truck_mg_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mg_mp":
    case "little_bird_mp":
    case "technical_mp":
    case "lighttank_mp":
    case "iw9_mg_light_tank_mp":
    case "iw9_mg_jltv_mp":
    case "iw9_tur_apc_russian_mp":
    case "iw9_tur_light_tank_mp":
    case "iw9_mg_mrap_mp":
    case "iw9_tur_cougar_mp":
    case "iw9_mg_patrol_boat_back_mp":
    case "iw9_mg_cougar_mp":
    case "iw9_mg_patrol_boat_front_mp":
    case "iw9_tur_mrap_mp":
      return 1;
    default:
      return 0;
  }
}

_id_858ED945747DFB28(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "blima_mp":
    case "palfa_mp":
    case "little_bird_mp":
      return 1;
    default:
      return 0;
  }
}

isgesture(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(issubstr(weaponname, "ges_plyr"))
    return 1;
  else if(issubstr(weaponname, "devilhorns_mp"))
    return 1;
  else
    return 0;
}

getweaponfullname(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(isstring(weapon))
    return weapon;
  else
    return getcompleteweaponname(weapon);
}

playdeatomizefx(_id_7729A74A75E8EC18, offset) {
  loc[0][0]["org"] = self gettagorigin("j_spineupper");
  loc[0][0]["angles"] = self gettagangles("j_spineupper");
  loc[0][1]["org"] = self gettagorigin("j_spinelower");
  loc[0][1]["angles"] = self gettagangles("j_spinelower");
  loc[0][2]["org"] = self gettagorigin("j_head");
  loc[0][2]["angles"] = self gettagangles("j_head");
  loc[1][0]["org"] = self gettagorigin("j_knee_ri");
  loc[1][0]["angles"] = self gettagangles("j_knee_ri");
  loc[1][1]["org"] = self gettagorigin("j_knee_le");
  loc[1][1]["angles"] = self gettagangles("j_knee_le");
  loc[1][2]["org"] = self gettagorigin("j_elbow_ri");
  loc[1][2]["angles"] = self gettagangles("j_elbow_ri");
  loc[1][3]["org"] = self gettagorigin("j_elbow_le");
  loc[1][3]["angles"] = self gettagangles("j_elbow_le");
  loc[2][0]["org"] = self gettagorigin("j_ankle_le");
  loc[2][0]["angles"] = self gettagangles("j_ankle_le");
  loc[2][1]["org"] = self gettagorigin("j_ankle_ri");
  loc[2][1]["angles"] = self gettagangles("j_ankle_ri");
  loc[2][2]["org"] = self gettagorigin("j_wrist_le");
  loc[2][2]["angles"] = self gettagangles("j_wrist_le");
  loc[2][3]["org"] = self gettagorigin("j_wrist_ri");
  loc[2][3]["angles"] = self gettagangles("j_wrist_ri");
  _id_90E6BC3A37537C77 = "bullet_atomizer_impact_npc";
  fxoffset = (0, 0, 0);

  if(isDefined(offset))
    fxoffset = offset;

  if(isDefined(_id_7729A74A75E8EC18))
    _id_90E6BC3A37537C77 = _id_7729A74A75E8EC18;

  self playSound(_id_90E6BC3A37537C77);

  foreach(_id_F90358454413407F in loc) {
    foreach(_id_0C3EA9B1A20FF199 in _id_F90358454413407F)
    playFX(level._effect["atomize_body"], _id_0C3EA9B1A20FF199["org"] + fxoffset, anglesToForward(_id_0C3EA9B1A20FF199["angles"]));

    wait 0.01;
  }
}

isprimaryweapon(objweapon) {
  if(isnullweapon(objweapon))
    return 0;

  if(objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode")
    return 0;

  switch (objweapon.classname) {
    case "mg":
    case "rocketlauncher":
    case "sniper":
    case "rifle":
    case "pistol":
    case "smg":
    case "spread":
      return 1;
    default:
      return 0;
  }
}

ismeleeoverrideweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "iw9_knifestab_mp" || weaponname == "iw9_knifestab_mp" || weaponname == "iw8_throwingknife_fire_melee_mp" || weaponname == "iw8_throwingknife_electric_melee_mp";
}

ismeleeonly(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(isstring(weapon)) {}

  return weapon.ismelee;
}

isfistsonly(weapon) {
  if(!isDefined(weapon))
    return 0;

  return _id_2669878CF5A1B6BC::getweaponrootname(weapon) == "iw9_me_fists" || _id_2669878CF5A1B6BC::getweaponrootname(weapon) == "iw9_me_superfists";
}

isballweapon(objweapon) {
  if(!isDefined(objweapon))
    return 0;

  return objweapon.basename == "iw9_cyberemp_mp" || objweapon.basename == "iw7_tdefball_mp";
}

isaxeweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  return _id_2669878CF5A1B6BC::getweaponrootname(weapon) == "iw7_axe";
}

isakimbomeleeweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  return _id_2669878CF5A1B6BC::getweaponrootname(weapon) == "iw8_me_akimboblunt" || _id_2669878CF5A1B6BC::getweaponrootname(weapon) == "iw8_me_akimboblades";
}

isthrowingknife(weapon) {
  if(!isDefined(weapon))
    return 0;

  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return issubstr(_id_C27E2A04BAB78C1F, "throwingknife") || issubstr(_id_C27E2A04BAB78C1F, "shuriken");
}

_id_160A992C78BDF589(weapon) {
  if(!isDefined(weapon))
    return 0;

  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return issubstr(_id_C27E2A04BAB78C1F, "throwstar");
}

isspecialmeleeweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(ismeleeoverrideweapon(weapon))
    return 1;

  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return _id_C27E2A04BAB78C1F == "iw9_me_fists_mp_ls";
}

isgunlessweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return _id_C27E2A04BAB78C1F == "iw8_gunless" || _id_C27E2A04BAB78C1F == "iw8_gunless_infil" || _id_C27E2A04BAB78C1F == "iw8_gunless_last_stand_enter" || _id_C27E2A04BAB78C1F == "iw9_gunless" || _id_C27E2A04BAB78C1F == "iw9_gunless_mp";
}

infiniteammothread(waittime, weapons, _id_B89EBC0D19BC00DC) {
  self endon("death_or_disconnect");
  self endon("stop_infinite_ammo_thread");

  if(!isDefined(waittime))
    waittime = level.framedurationseconds;

  for(;;) {
    if(!isDefined(weapons) || istrue(_id_B89EBC0D19BC00DC))
      weapons = self.equippedweapons;

    foreach(weapon in weapons) {
      self givemaxammo(weapon);
      self setweaponammoclip(weapon, weaponclipsize(weapon));
    }

    wait(waittime);
  }
}

stopinfiniteammothread() {
  self notify("stop_infinite_ammo_thread");
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\loot.gsc
***********************************************/

init() {
  level._id_F984BA508AE5BCB1 = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_319F74ED8FA1A512 = tablelookupbyrow("loot/loot_types.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(_id_319F74ED8FA1A512) || _id_319F74ED8FA1A512 == "") {
      break;
    }

    _id_03A436BD812A2B86 = int(tablelookupbyrow("loot/loot_types.csv", _id_CB89110314447B2F, 1));
    data = spawnStruct();
    data._id_319F74ED8FA1A512 = _id_319F74ED8FA1A512;
    data._id_03A436BD812A2B86 = _id_03A436BD812A2B86;
    level._id_F984BA508AE5BCB1[_id_319F74ED8FA1A512] = data;
    _id_CB89110314447B2F++;
  }
}

_id_6FB104D58E745D61(_id_03A436BD812A2B86) {
  foreach(type, data in level._id_F984BA508AE5BCB1) {
    if(_id_03A436BD812A2B86 == data._id_03A436BD812A2B86)
      return data._id_319F74ED8FA1A512;
  }

  return undefined;
}

_id_8662A0AEF570FF4B(_id_319F74ED8FA1A512) {
  foreach(type, data in level._id_F984BA508AE5BCB1) {
    if(_id_319F74ED8FA1A512 == data._id_319F74ED8FA1A512)
      return data._id_03A436BD812A2B86;
  }

  return undefined;
}

_id_282CF83C9EEDA744(lootid) {
  if(!isDefined(lootid))
    return undefined;

  _id_60CE74182E7C83A7 = _func_3475769C002400F7(lootid);

  if(!isDefined(_id_60CE74182E7C83A7) || !isDefined(_id_60CE74182E7C83A7.category))
    return undefined;

  _id_319F74ED8FA1A512 = _id_60CE74182E7C83A7.category;

  if(_id_319F74ED8FA1A512 == "")
    return undefined;

  return _id_319F74ED8FA1A512;
}

_id_02F80E9272A2074D(lootid, _id_49E6EF3EDADD524E) {
  _id_EE60A5391583079B = _id_793E8A72CEDB8EF3(lootid);
  _id_A3F7381340CF06D9 = _id_2669878CF5A1B6BC::_id_A622D54BB517923A(_id_EE60A5391583079B, ["stat_3BE72D7E1D0B16E5"]);

  if(_id_A3F7381340CF06D9._id_FB5397C466F84C61 != "" && _id_A3F7381340CF06D9._id_FB5397C466F84C61 != _id_EE60A5391583079B) {
    _id_39DD70C4A332B134 = _id_2669878CF5A1B6BC::_id_A622D54BB517923A(_id_A3F7381340CF06D9._id_FB5397C466F84C61, ["stat_8028887F70BF5EBA"]);

    if(_id_39DD70C4A332B134.lootid != 0)
      lootid = _id_39DD70C4A332B134.lootid;
  }

  if(isDefined(level._id_1F4C7D9CB262BA15) && isDefined(level._id_1F4C7D9CB262BA15[_id_49E6EF3EDADD524E])) {
    if(isDefined(level._id_1F4C7D9CB262BA15[_id_49E6EF3EDADD524E][lootid]))
      return level._id_1F4C7D9CB262BA15[_id_49E6EF3EDADD524E][lootid];
  }

  return _id_EE60A5391583079B;
}

_id_793E8A72CEDB8EF3(lootid) {
  if(!isDefined(lootid)) {
    return;
  }
  if(!isDefined(level._id_F41ABE634712663C))
    level._id_F41ABE634712663C = [];

  if(isDefined(level._id_F41ABE634712663C[lootid]))
    return level._id_F41ABE634712663C[lootid];

  _id_CB325DDB4A764623 = undefined;
  _id_60CE74182E7C83A7 = _func_3475769C002400F7(lootid);

  if(isDefined(_id_60CE74182E7C83A7) && isDefined(_id_60CE74182E7C83A7._id_CB325DDB4A764623))
    _id_CB325DDB4A764623 = _id_60CE74182E7C83A7._id_CB325DDB4A764623;

  if(!isDefined(_id_CB325DDB4A764623))
    _id_CB325DDB4A764623 = tablelookup(level.brloottablename, 5, lootid, 1);

  if(isDefined(_id_CB325DDB4A764623) && _id_CB325DDB4A764623 != "")
    level._id_F41ABE634712663C[lootid] = _id_CB325DDB4A764623;

  return _id_CB325DDB4A764623;
}

_id_A50B607D2500DDA5(ref) {
  if(!isDefined(ref))
    return undefined;

  if(!isDefined(level._id_782B4804D4E2D690))
    level._id_782B4804D4E2D690 = [];

  if(isDefined(level._id_782B4804D4E2D690[ref]))
    return level._id_782B4804D4E2D690[ref];

  _id_60CE74182E7C83A7 = _func_E4F08713DC9C53B3(ref);

  if(!isDefined(_id_60CE74182E7C83A7) || !isDefined(_id_60CE74182E7C83A7._id_DB35956D84816F27))
    return 0;

  lootid = _id_60CE74182E7C83A7._id_DB35956D84816F27;
  level._id_782B4804D4E2D690[ref] = lootid;
  return lootid;
}

_id_C2C9FB447C203CB2(type) {
  if(!isDefined(type))
    return undefined;

  switch (type) {
    case "secondary":
    case "primary":
    case "weapon":
      return "weapon";
    case "special_weapon":
      return "special_weapon";
    case "equipment":
    case "lethal":
    case "tactical":
      return "equipment";
    case "fieldupgrade":
    case "field_upgrade":
    case "super":
      return "super";
    case "killstreak":
      return "killstreak";
    case "perk":
      return "perk";
    case "attachment":
      return "attachment";
    case "consumable":
    case "key":
    case "personal":
    case "dogtag":
    case "valuable":
    case "plunder":
    case "gascan":
    case "elite_arrow":
    case "trophy":
    case "weaponcase":
      return "consumable";
    case "operator":
      return "operator";
  }

  return undefined;
}

_id_B88CFB4893CEEDAC(ref) {
  if(!isDefined(ref))
    return undefined;

  if(!isDefined(level.br_pickups)) {
    return;
  }
  if(isDefined(level.br_pickups.br_weapontoscriptable[ref]))
    return level.br_pickups.br_weapontoscriptable[ref];

  if(isDefined(level.br_pickups.br_equipnametoscriptable[ref]))
    return level.br_pickups.br_equipnametoscriptable[ref];

  if(isDefined(level.br_pickups._id_838863C4848D4C26[ref]))
    return level.br_pickups._id_838863C4848D4C26[ref];
}

_id_E1D5A33193DB0133(lootid) {
  if(isDefined(level.br_pickups._id_B13DC7E63676BBE7[lootid]))
    return level.br_pickups._id_B13DC7E63676BBE7[lootid];
  else {
    ref = _id_793E8A72CEDB8EF3(lootid);
    return _id_B88CFB4893CEEDAC(ref);
  }
}

_id_FAE5E1D3DE32D3F7(ref) {
  if(!isDefined(ref))
    return undefined;

  if(isDefined(level.br_pickups._id_7B2BFF2D04EE1017[ref]))
    return level.br_pickups._id_7B2BFF2D04EE1017[ref];

  if(isDefined(level.br_pickups._id_14BD11727C4B6629[ref]) && isDefined(level.br_pickups.br_itemtype[ref])) {
    itemtype = level.br_pickups.br_itemtype[ref];

    if(itemtype == "health")
      itemtype = "consumable";

    return _id_A50B607D2500DDA5(level.br_pickups._id_14BD11727C4B6629[ref]);
  }

  if(isDefined(level.br_pickups.br_equipname[ref]))
    return _id_A50B607D2500DDA5(level.br_pickups.br_equipname[ref]);
}

_id_AFA71C22D9DCFDC5(lootid) {
  cost = tablelookup("loot/consumable_ids.csv", 0, lootid, 3);
  return cost;
}

_id_4068C937EBAA0EBD(scriptablename) {
  lootid = _id_FAE5E1D3DE32D3F7(scriptablename);

  if(!isDefined(lootid))
    return 0;

  return _id_C02E0FB782D242F2(lootid);
}

_id_C02E0FB782D242F2(lootid) {
  _id_4B67A123F86227CE = tablelookup("loot/consumable_ids.csv", 0, lootid, 12);

  if(!isDefined(_id_4B67A123F86227CE))
    return 1;

  if(_id_4B67A123F86227CE == "1")
    return 0;

  return 1;
}

_id_9CA10C69808B00A5(_id_25978461C6E4F61B) {
  if(!isDefined(_id_25978461C6E4F61B))
    return 0;

  return issubstr(getDvar("loot_table_filter", ""), _id_25978461C6E4F61B) || issubstr(getDvar("loot_table_filter_global", ""), _id_25978461C6E4F61B);
}

_id_5D47301F7BB7A6BA(lootid) {
  if(!isDefined(lootid))
    return 0;

  _id_25978461C6E4F61B = _id_E1D5A33193DB0133(lootid);
  return _id_9CA10C69808B00A5(_id_25978461C6E4F61B);
}

_id_54B046AA3BA2678A(_id_9023CEA8F03E72D2) {
  _id_3D329EBB0D03D6DB = tablelookup("mp/buyStation/buyStationDefs.csv", 1, _id_9023CEA8F03E72D2, 0);

  if(_id_3D329EBB0D03D6DB != "")
    return int(_id_3D329EBB0D03D6DB);

  return undefined;
}

_id_151B82E1257F4CDE(ref) {
  if(!isDefined(ref))
    return undefined;

  switch (ref) {
    case "equip_tac_cover":
      return "super_tac_cover";
    case "equip_trophy":
      return "super_trophy";
    case "equip_recondrone":
      return "super_recon_drone";
    case "equip_deadsilence":
      return "super_deadsilence";
    case "equip_stoppingpower":
      return "super_support_box";
    case "equip_munitionsbox":
      return "super_ammo_drop";
    case "equip_armorbox":
      return "super_armor_drop";
    case "equip_hauntedbox":
      return "super_haunted_drop";
    case "equip_battlerage":
      return "super_battlerage";
    case "equip_stimpistol":
      return "super_stimpistol";
    case "equip_deployed_decoy":
      return "super_deployed_decoy";
    case "equip_tacticalcamera":
      return "super_tac_camera";
    case "equip_emppulse":
      return "super_emp_pulse";
    case "equip_advanced_supply_drop":
      return "super_supply_drop";
    case "equip_extract":
      return "super_fulton";
    case "equip_advanced_vehicle_drop":
      return "super_vehicle_drop";
    case "equip_sound_veil":
      return "super_sound_veil";
    case "equip_sonar_pulse":
      return "super_sonar_pulse";
    case "equip_suppression_rounds":
      return "super_suppression_rounds";
    case "equip_reinforcementflare":
      return "super_reinforcement_flare";
    case "equip_personal_redeploy_drone":
      return "super_personal_redeploy_drone";
    case "equip_oxygenmask":
      return "super_oxygen_mask";
  }

  return undefined;
}

_id_2CE015D8F99A66E0(lootid) {
  return _id_0E025BB823276187(_id_E1D5A33193DB0133(lootid));
}

_id_0E025BB823276187(scriptablename) {
  if(!isDefined(scriptablename))
    return 0;

  if(!isDefined(level.br_pickups.counts) || !isDefined(level.br_pickups.counts[scriptablename]))
    return 0;

  return level.br_pickups.counts[scriptablename];
}
/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_perks.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_perkfunctions;

init_perks() {
  init_perks_callback();

  init_perks_from_table();
}

PERK_TABLE = "mp/alien/perks_tree.csv";

init_perks_from_table() {
  if(!isDefined(level.alien_perks_table))
    level.alien_perks_table = PERK_TABLE;

  level.alien_perks = [];

  update_perks_from_table(0, "perk_0");
  update_perks_from_table(100, "perk_1");
}

init_perks_callback() {
  level.alien_perk_callbacks = [];

  register_perk_callback("perk_health", ::set_perk_health_level_0, ::unset_perk_health_level_0);
  register_perk_callback("perk_health_1", ::set_perk_health_level_1, ::unset_perk_health_level_1);
  register_perk_callback("perk_health_2", ::set_perk_health_level_2, ::unset_perk_health_level_2);
  register_perk_callback("perk_health_3", ::set_perk_health_level_3, ::unset_perk_health_level_3);
  register_perk_callback("perk_health_4", ::set_perk_health_level_4, ::unset_perk_health_level_4);

  register_perk_callback("perk_pistol_p226", ::set_perk_pistol_p226_0, ::unset_perk_pistol_p226_0);
  register_perk_callback("perk_pistol_p226_1", ::set_perk_pistol_p226_1, ::unset_perk_pistol_p226_1);
  register_perk_callback("perk_pistol_p226_2", ::set_perk_pistol_p226_2, ::unset_perk_pistol_p226_2);
  register_perk_callback("perk_pistol_p226_3", ::set_perk_pistol_p226_3, ::unset_perk_pistol_p226_3);
  register_perk_callback("perk_pistol_p226_4", ::set_perk_pistol_p226_4, ::unset_perk_pistol_p226_4);

  register_perk_callback("perk_pistol_magnum", ::set_perk_pistol_magnum_0, ::unset_perk_pistol_magnum_0);
  register_perk_callback("perk_pistol_magnum_1", ::set_perk_pistol_magnum_1, ::unset_perk_pistol_magnum_1);
  register_perk_callback("perk_pistol_magnum_2", ::set_perk_pistol_magnum_2, ::unset_perk_pistol_magnum_2);
  register_perk_callback("perk_pistol_magnum_3", ::set_perk_pistol_magnum_3, ::unset_perk_pistol_magnum_3);
  register_perk_callback("perk_pistol_magnum_4", ::set_perk_pistol_magnum_4, ::unset_perk_pistol_magnum_4);

  register_perk_callback("perk_pistol_m9a1", ::set_perk_pistol_m9a1_0, ::unset_perk_pistol_m9a1_0);
  register_perk_callback("perk_pistol_m9a1_1", ::set_perk_pistol_m9a1_1, ::unset_perk_pistol_m9a1_1);
  register_perk_callback("perk_pistol_m9a1_2", ::set_perk_pistol_m9a1_2, ::unset_perk_pistol_m9a1_2);
  register_perk_callback("perk_pistol_m9a1_3", ::set_perk_pistol_m9a1_3, ::unset_perk_pistol_m9a1_3);
  register_perk_callback("perk_pistol_m9a1_4", ::set_perk_pistol_m9a1_4, ::unset_perk_pistol_m9a1_4);

  register_perk_callback("perk_pistol_mp443", ::set_perk_pistol_mp443_0, ::unset_perk_pistol_mp443_0);
  register_perk_callback("perk_pistol_mp443_1", ::set_perk_pistol_mp443_1, ::unset_perk_pistol_mp443_1);
  register_perk_callback("perk_pistol_mp443_2", ::set_perk_pistol_mp443_2, ::unset_perk_pistol_mp443_2);
  register_perk_callback("perk_pistol_mp443_3", ::set_perk_pistol_mp443_3, ::unset_perk_pistol_mp443_3);
  register_perk_callback("perk_pistol_mp443_4", ::set_perk_pistol_mp443_4, ::unset_perk_pistol_mp443_4);

  register_perk_callback("perk_bullet_damage", ::set_perk_bullet_damage_0, ::unset_perk_bullet_damage_0);
  register_perk_callback("perk_bullet_damage_1", ::set_perk_bullet_damage_1, ::unset_perk_bullet_damage_1);
  register_perk_callback("perk_bullet_damage_2", ::set_perk_bullet_damage_2, ::unset_perk_bullet_damage_2);
  register_perk_callback("perk_bullet_damage_3", ::set_perk_bullet_damage_3, ::unset_perk_bullet_damage_3);
  register_perk_callback("perk_bullet_damage_4", ::set_perk_bullet_damage_4, ::unset_perk_bullet_damage_4);

  register_perk_callback("perk_medic", ::set_perk_medic_0, ::unset_perk_medic_0);
  register_perk_callback("perk_medic_1", ::set_perk_medic_1, ::unset_perk_medic_1);
  register_perk_callback("perk_medic_2", ::set_perk_medic_2, ::unset_perk_medic_2);
  register_perk_callback("perk_medic_3", ::set_perk_medic_3, ::unset_perk_medic_3);
  register_perk_callback("perk_medic_4", ::set_perk_medic_4, ::unset_perk_medic_4);

  register_perk_callback("perk_rigger", ::set_perk_rigger_0, ::unset_perk_rigger_0);
  register_perk_callback("perk_rigger_1", ::set_perk_rigger_1, ::unset_perk_rigger_1);
  register_perk_callback("perk_rigger_2", ::set_perk_rigger_2, ::unset_perk_rigger_2);
  register_perk_callback("perk_rigger_3", ::set_perk_rigger_3, ::unset_perk_rigger_3);
  register_perk_callback("perk_rigger_4", ::set_perk_rigger_4, ::unset_perk_rigger_4);

  register_perk_callback("perk_none", ::set_perk_none, ::unset_perk_none);
  register_perk_callback("perk_none_1", ::set_perk_none, ::unset_perk_none);
  register_perk_callback("perk_none_2", ::set_perk_none, ::unset_perk_none);
  register_perk_callback("perk_none_3", ::set_perk_none, ::unset_perk_none);
  register_perk_callback("perk_none_4", ::set_perk_none, ::unset_perk_none);
}

register_perk_callback(perk_name, set_func, unSet_func) {
  perk_callback = spawnStruct();
  perk_callback.Set = set_func;
  perk_callback.unSet = unSet_func;

  level.alien_perk_callbacks[perk_name] = perk_callback;
}

TABLE_INDEX = 0;
TABLE_REF = 1;
TABLE_UNLOCK = 2;
TABLE_POINT_COST = 3;
TABLE_NAME = 4;
TABLE_DESC = 5;
TABLE_ICON = 6;
TABLE_IS_UPGRADE = 7;

TABLE_PERK_MAX_INDEX = 100;

update_perks_from_table(start_idx, perk_type) {
  level.alien_perks[perk_type] = [];

  for(i = start_idx; i <= start_idx + TABLE_PERK_MAX_INDEX; i++) {
    perk_ref = get_perk_ref_by_index(i);
    if(perk_ref == "") {
      break;
    }

    if(!isDefined(level.alien_perks[perk_ref])) {
      perk = spawnStruct();
      perk.upgrades = [];
      perk.unlock = get_unlock_by_ref(perk_ref);
      perk.name = get_name_by_ref(perk_ref);
      perk.icon = get_icon_by_ref(perk_ref);
      perk.ref = perk_ref;
      perk.type = perk_type;
      perk.callbacks = level.alien_perk_callbacks[perk_ref];
      perk.baseIdx = i;

      level.alien_perks[perk_type][perk_ref] = perk;
    }

    for(j = i; j <= start_idx + TABLE_PERK_MAX_INDEX; j++) {
      upgrade_ref = get_perk_ref_by_index(j);
      if(upgrade_ref == "") {
        break;
      }

      if(upgrade_ref == perk_ref || is_perk_set(perk_ref, upgrade_ref)) {
        upgrade = spawnStruct();
        upgrade.ref = upgrade_ref;
        upgrade.desc = get_desc_by_ref(upgrade_ref);
        upgrade.point_cost = get_point_cost_by_ref(upgrade_ref);

        level.alien_perks[perk_type][perk_ref].upgrades[j - i] = upgrade;
      } else {
        break;
      }
    }

    i = j - 1;
  }
}

is_perk_set(perk_ref, upgrade_ref) {
  assert(isDefined(perk_ref) && isDefined(upgrade_ref));

  if(perk_ref == upgrade_ref)
    return false;

  if(!issubstr(upgrade_ref, perk_ref))
    return false;

  perk_toks = StrTok(perk_ref, "_");
  upgrade_toks = StrTok(upgrade_ref, "_");

  if(upgrade_toks.size - perk_toks.size != 1)
    return false;

  for(i = 0; i < upgrade_toks.size - 1; i++) {
    if(upgrade_toks[i] != perk_toks[i])
      return false;
  }

  return true;
}

get_perk_ref_by_index(index) {
  return tablelookup(level.alien_perks_table, TABLE_INDEX, index, TABLE_REF);
}

get_name_by_ref(ref) {
  return tablelookup(level.alien_perks_table, TABLE_REF, ref, TABLE_NAME);
}

get_icon_by_ref(ref) {
  return tablelookup(level.alien_perks_table, TABLE_REF, ref, TABLE_ICON);
}

get_desc_by_ref(ref) {
  return tablelookup(level.alien_perks_table, TABLE_REF, ref, TABLE_DESC);
}

get_point_cost_by_ref(ref) {
  return int(tablelookup(level.alien_perks_table, TABLE_REF, ref, TABLE_POINT_COST));
}

get_unlock_by_ref(ref) {
  return int(tablelookup(level.alien_perks_table, TABLE_REF, ref, TABLE_UNLOCK));
}

get_is_upgrade_by_ref(ref) {
  return int(tablelookup(level.alien_perks_table, TABLE_REF, ref, TABLE_IS_UPGRADE));
}
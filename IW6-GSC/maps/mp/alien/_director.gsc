/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_director.gsc
***************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_utility;

ATTRIBUTE_TABLE = "mp/alien/default_alien_definition.csv";

TABLE_COL_INDEX = 0;
TABLE_COL_ATTRIBUTE = 1;
TABLE_COL_AI_TYPE_BEGIN = 2;
TABLE_COL_AI_TYPE_MAX_TYPES = 16;

alien_attribute_table_init() {
  if(!isDefined(level.default_alien_definition))
    level.default_alien_definition = ATTRIBUTE_TABLE;

  att_idx = [];
  att_idx["ref"] = "0";
  att_idx["name"] = "1";
  att_idx["model"] = "2";
  att_idx["desc"] = "3";
  att_idx["boss"] = 4;
  att_idx["animclass"] = "5";

  att_idx["health"] = 10;
  att_idx["min_cumulative_pain_threshold"] = 11;
  att_idx["min_cumulative_pain_buffer_time"] = 12.0;
  att_idx["accuracy"] = 13.0;
  att_idx["speed"] = 14.0;
  att_idx["scale"] = 15.0;
  att_idx["xp"] = 16;
  att_idx["attacker_difficulty"] = 17.0;
  att_idx["attacker_priority"] = 18;
  att_idx["jump_cost"] = 19.0;
  att_idx["traverse_cost"] = 20.0;
  att_idx["run_cost"] = 21.0;
  att_idx["wall_run_cost"] = 29.0;
  att_idx["heavy_damage_threshold"] = 22.0;
  att_idx["pain_interval"] = 23.0;
  att_idx["emissive_default"] = 24.0;
  att_idx["emissive_max"] = 25.0;
  att_idx["weight_scale"] = 26.0;
  att_idx["reward"] = 27.0;
  att_idx["view_height"] = 28.0;

  att_idx["behavior_cloak"] = 100;
  att_idx["behavior_spit"] = 101;
  att_idx["behavior_lead"] = 102;
  att_idx["behavior_hives"] = 103;

  att_idx["swipe_min_damage"] = 2000;
  att_idx["swipe_max_damage"] = 2001;
  att_idx["leap_min_damage"] = 2002;
  att_idx["leap_max_damage"] = 2003;
  att_idx["wall_min_damage"] = 2004;
  att_idx["wall_max_damage"] = 2005;
  att_idx["charge_min_damage"] = 2006;
  att_idx["charge_max_damage"] = 2007;
  att_idx["explode_min_damage"] = 2008;
  att_idx["explode_max_damage"] = 2009;
  att_idx["slam_min_damage"] = 2010;
  att_idx["slam_max_damage"] = 2011;
  att_idx["synch_min_damage_per_second"] = 2012;
  att_idx["synch_max_damage_per_second"] = 2013;

  loot_index = 1000;
  loot_index_max = 1100;
  for(i = loot_index; i < loot_index_max; i++) {
    loot_ref = TableLookup(level.default_alien_definition, TABLE_COL_INDEX, i, TABLE_COL_ATTRIBUTE);
    if(loot_ref == "") {
      break;
    }

    att_idx[loot_ref] = i * 1.00;
  }

  level.alien_types = [];

  maxIndex = TABLE_COL_AI_TYPE_BEGIN + TABLE_COL_AI_TYPE_MAX_TYPES;
  for(typeIndex = TABLE_COL_AI_TYPE_BEGIN; typeIndex < maxIndex; typeIndex++)
    setup_alien_type(att_idx, typeIndex);

  if(isDefined(level.custom_alien_attribute_table_init))
    [[level.custom_alien_attribute_table_init]]();
}

setup_alien_type(att_idx, type) {
  type_ref = TableLookup(level.default_alien_definition, TABLE_COL_INDEX, att_idx["ref"], type);

  if(type_ref == "") {
    return;
  }
  level.alien_types[type_ref] = spawnStruct();

  level.alien_types[type_ref].attributes = [];
  level.alien_types[type_ref].loots = [];

  foreach(key, index in att_idx) {
    value = TableLookup(level.default_alien_definition, TABLE_COL_INDEX, index, type);

    if(!isString(index)) {
      if(!IsSubStr(value, "."))
        value = int(value);
      else
        value = float(value);
    }

    level.alien_types[type_ref].attributes[key] = value;

    if(IsSubStr(key, "loot_") && value > 0.0) {
      level.alien_types[type_ref].loots[key] = value;
    }
  }
}

CONST_DECLOAK_DIST = 800;
CONST_CLOCK_CHANCE = 1;

alien_cloak() {
  self endon("death");

  self thread near_player_notify();

  while(1) {
    if(any_player_nearby(self.origin, CONST_DECLOAK_DIST)) {
      wait 0.05;
      continue;
    }

    self waittill("jump_launching");

    wait 0.20;

    original_model = self.model;
    self maps\mp\alien\_alien_fx::alien_cloak_fx_on();
    self cloak_fx();
    self setModel(original_model + "_cloak");

    waittill_any_timeout(1, "jump_finished", "damage");

    wait 0.20;

    self maps\mp\alien\_alien_fx::alien_cloak_fx_off();
    self uncloak_fx();
    self setModel(original_model);
  }
}

near_player_notify() {
  self endon("death");
  while(1) {
    if(any_player_nearby(self.origin, CONST_DECLOAK_DIST))
      self notify("near_player");

    wait 0.05;
  }
}

cloak_fx() {
  playFXOnTag(level._effect["alien_cloaking"], self, "j_neck");
}

uncloak_fx() {
  playFXOnTag(level._effect["alien_uncloaking"], self, "j_neck");
}

smoke_puff() {
  playFXOnTag(level._effect["alien_teleport"], self, "tag_origin");

  playFXOnTag(level._effect["alien_teleport_dist"], self, "tag_origin");
}
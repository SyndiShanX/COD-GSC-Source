/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_fx.gsc
***********************************************/

#namespace zm_white_fx;

init() {
  level._effect[#"large_ceiling_dust"] = #"dirt/fx8_dust_fall_impact_lg";
  level._effect[#"dog_gib"] = #"hash_7d69ee9822b45157";
  level._effect[#"teleport_depart"] = #"hash_1a6b5072e162ccd4";
  level._effect[#"teleport_arrive"] = #"hash_50655ac7dc942305";
  level._effect[#"portal_origin"] = #"maps/zm_office/fx8_teleporter_origin";
  level._effect[#"portal_dest"] = #"maps/zm_office/fx8_teleporter_destination";
  level._effect[#"poltergeist"] = #"hash_2f079a0d04b14a46";
  level._effect[#"portal_spawn"] = #"maps/zm_office/fx8_teleporter_spawn";
  level._effect[#"portal_despawn"] = #"maps/zm_office/fx8_teleporter_despawn";
}
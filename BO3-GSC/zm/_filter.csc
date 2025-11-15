/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_filter.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\filter_shared;
#namespace filter;

function init_filter_zm_turned(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_zm_turned");
}

function enable_filter_zm_turned(player, filterid, overlayid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, level.filter_matid["generic_filter_zm_turned"]);
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function disable_filter_zm_turned(player, filterid, overlayid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}
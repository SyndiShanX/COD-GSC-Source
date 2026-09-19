/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_missile_strike.gsc
***********************************************************/

init() {
  level._id_80B7["missile_strike"] = 450;
  level._id_80B8["missile_strike"] = 300;
  level._id_80B6["missile_strike"] = 0;
  level._id_80B9["missile_strike"] = 1.0;
  level._id_80B5["missile_strike"] = 18.0;
  level._id_5A61["missile_strike"] = ::_id_9E31;
  level._id_5A7D["missile_strike_projectile_mp"] = "missile_strike";
  level._id_5A7D["missile_strike_projectile_axis_mp"] = "missile_strike";
}

_id_9E31(var_0) {
  return _id_052A::_id_9E39(var_0, "missile_strike");
}
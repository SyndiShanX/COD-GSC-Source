/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2660.gsc
*************************************************/

_id_80EC() {
  level._id_BF15 = 40;
  level._id_11DD = 30;
  level._id_F8F3 = 40;
  scripts\mp\killstreaks\killstreaks::_id_C26A("uav", _id_09BD::_id_F7A6);
  scripts\mp\killstreaks\killstreaks::_id_C26A("directional_uav", _id_09BD::_id_F7A6);
  scripts\mp\killstreaks\killstreaks::_id_C26A("counter_spy_plane", _id_09BD::_id_F7A6);
  level._id_F902 = [];
  level._id_F902["uav"] = spawnStruct();
  level._id_F902["uav"]._id_F224 = level._id_BF15;
  level._id_F902["uav"].health = 999999;
  level._id_F902["uav"].maxhealth = 500;
  level._id_F902["uav"].streakname = "uav";
  level._id_F902["uav"].modelbase = "plane_pindigoj5a_00";
  level._id_F902["uav"]._id_9FD1 = "plane_pindigoj5a_00";
  level._id_F902["uav"].fxid_damaged = loadfx("vfx/s4/killstreaks/vfx_recon_damage_01.vfx");
  level._id_F902["uav"]._id_6090 = loadfx("vfx/iw8_mp/killstreak/vfx_uav_death.vfx");
  level._id_F902["uav"]._id_606B = "tag_origin";
  level._id_F902["uav"]._id_608F = undefined;
  level._id_F902["uav"]._id_6061 = undefined;
  level._id_F902["uav"]._id_5D46 = "kstreak_uav_enter";
  level._id_F902["uav"]._id_5D48 = "kstreak_uav_exit";
  level._id_F902["uav"]._id_E053 = "kstreak_uav_death";
  level._id_F902["uav"]._id_EFAC = "used_uav";
  level._id_F902["uav"]._id_106B4 = "timeout_uav";
  level._id_F902["uav"]._id_2F7B = "callout_destroyed_uav";
  level._id_F902["uav"]._id_10AF = _id_09BD::_id_1088;
  level._id_F902["uav"]._id_C4C5 = _id_09BD::_id_C468;
  level._id_F902["counter_spy_plane"] = spawnStruct();
  level._id_F902["counter_spy_plane"]._id_F224 = level._id_F8F3;
  level._id_F902["counter_spy_plane"].health = 999999;
  level._id_F902["counter_spy_plane"].maxhealth = 600;
  level._id_F902["counter_spy_plane"].streakname = "counter_spy_plane";
  level._id_F902["counter_spy_plane"].modelbase = "plane_papa61_vista";
  level._id_F902["counter_spy_plane"].fxid_damaged = loadfx("vfx/s4/killstreaks/vfx_recon_damage_01.vfx");
  level._id_F902["counter_spy_plane"]._id_6090 = loadfx("vfx/s4/killstreaks/vfx_counter_uav_explosion.vfx");
  level._id_F902["counter_spy_plane"]._id_606B = "tag_origin";
  level._id_F902["counter_spy_plane"]._id_608F = undefined;
  level._id_F902["counter_spy_plane"]._id_6061 = undefined;
  level._id_F902["counter_spy_plane"]._id_E053 = "kstreak_uav_death";
  level._id_F902["counter_spy_plane"]._id_106B4 = "counter_uav_timeout";
  level._id_F902["counter_spy_plane"]._id_EFAC = "used_counter_spy_plane";
  level._id_F902["counter_spy_plane"]._id_2F7B = "callout_destroyed_counter_uav";
  level._id_F902["counter_spy_plane"]._id_10AF = _id_09BD::_id_1087;
  level._id_F902["counter_spy_plane"]._id_C4C5 = _id_09BD::_id_C466;
  level._id_F902["directional_uav"] = spawnStruct();
  level._id_F902["directional_uav"]._id_F224 = level._id_11DD;
  level._id_F902["directional_uav"].health = 999999;
  level._id_F902["directional_uav"].maxhealth = 2000;
  level._id_F902["directional_uav"].streakname = "directional_uav";
  level._id_F902["directional_uav"].modelbase = "";
  level._id_F902["directional_uav"]._id_9FD1 = "";
  level._id_F902["directional_uav"]._id_6090 = loadfx("vfx/iw8_mp/killstreak/vfx_auav_death.vfx");
  level._id_F902["directional_uav"]._id_606B = "tag_origin";
  level._id_F902["directional_uav"]._id_608F = undefined;
  level._id_F902["directional_uav"]._id_6061 = "tag_jet_trail";
  level._id_F902["directional_uav"]._id_5D46 = "kstreak_uav_enter";
  level._id_F902["directional_uav"]._id_5D48 = "kstreak_uav_exit";
  level._id_F902["directional_uav"]._id_E053 = "kstreak_uav_death";
  level._id_F902["directional_uav"]._id_106B4 = "timeout_directional_uav";
  level._id_F902["directional_uav"]._id_EFAC = "used_directional_uav";
  level._id_F902["directional_uav"]._id_2F7B = "callout_destroyed_directional_uav";
  level._id_F902["directional_uav"]._id_10AF = _id_09BD::_id_1088;
  level._id_F902["directional_uav"]._id_C4C5 = _id_09BD::_id_C468;
  _id_0AA3::_id_C28D(_id_09BD::onplayerspawned);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "remoteUAV_processTaggedAssist", _id_0A5E::_id_C35F);
}
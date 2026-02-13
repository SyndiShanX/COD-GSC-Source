/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2653.gsc
*************************************************/

init() {
  level._id_F89C = [];
  level._id_F89C["mg_turret"] = "remote_mg_turret";
  scripts\mp\killstreaks\killstreaks::_id_C26A("remote_mg_turret", ::_id_F798);
  level._id_F898 = [];
  level._id_F898["mg_turret"] = spawnStruct();
  level._id_F898["mg_turret"]._id_D0F8 = "manual";
  level._id_F898["mg_turret"]._id_D0F7 = "sentry_offline";
  level._id_F898["mg_turret"]._id_F224 = 60.0;
  level._id_F898["mg_turret"].health = 999999;
  level._id_F898["mg_turret"].maxhealth = 1000;
  level._id_F898["mg_turret"].streakname = "remote_mg_turret";
  level._id_F898["mg_turret"].weaponinfo = "remote_turret_mp";
  level._id_F898["mg_turret"].modelbase = "mp_remote_turret";
  level._id_F898["mg_turret"]._id_9FDD = "mp_remote_turret_placement";
  level._id_F898["mg_turret"]._id_9FDE = "mp_remote_turret_placement_failed";
  level._id_F898["mg_turret"]._id_9FD5 = "mp_remote_turret";
  level._id_F898["mg_turret"]._id_EFAC = "used_remote_mg_turret";
  level._id_F898["mg_turret"]._id_7987 = &"KILLSTREAKS_ENTER_REMOTE_TURRET";
  level._id_F898["mg_turret"]._id_7988 = &"KILLSTREAKS/EARLY_EXIT";
  level._id_F898["mg_turret"]._id_7995 = &"KILLSTREAKS_DOUBLE_TAP_TO_CARRY";
  level._id_F898["mg_turret"]._id_B17C = &"KILLSTREAKS_TURRET_PLACE";
  level._id_F898["mg_turret"]._id_31A4 = &"KILLSTREAKS_TURRET_CANNOT_PLACE";
  level._id_F898["mg_turret"]._id_1068F = "remote_sentry_destroyed";
  level._id_F898["mg_turret"]._id_8EBA = "killstreak_remote_turret_laptop_mp";
  level._id_F898["mg_turret"]._id_C33D = "killstreak_remote_turret_remote_mp";
  level._effect["sentry_explode_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["antenna_light_mp"] = loadfx("vfx/core/lights/light_detonator_blink");
}

_id_F798(var_0, var_1) {}
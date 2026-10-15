/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\proximity_grenade.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;

#namespace proximity_grenade;

init_shared() {
  clientfield::register("toplayer", "tazered", 1, 1, "int", undefined, 0, 0);
  level._effect[#"prox_grenade_friendly_default"] = #"weapon/fx_prox_grenade_scan_blue";
  level._effect[#"prox_grenade_friendly_warning"] = #"weapon/fx_prox_grenade_wrn_grn";
  level._effect[#"prox_grenade_enemy_default"] = #"weapon/fx_prox_grenade_scan_orng";
  level._effect[#"prox_grenade_enemy_warning"] = #"weapon/fx_prox_grenade_wrn_red";
  level._effect[#"prox_grenade_player_shock"] = #"weapon/fx_prox_grenade_impact_player_spwner";
  callback::add_weapon_type(#"proximity_grenade", &proximity_spawned);
  level thread watchforproximityexplosion();
}

proximity_spawned(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }

  self.equipmentfriendfx = level._effect[#"prox_grenade_friendly_default"];
  self.equipmentenemyfx = level._effect[#"prox_grenade_enemy_default"];
  self.equipmenttagfx = "tag_fx";
  self thread weaponobjects::equipmentteamobject(localclientnum);
}

watchforproximityexplosion() {
  if(getactivelocalclients() > 1) {
    return;
  }

  weapon_proximity = getweapon(#"proximity_grenade");

  while(true) {
    waitresult = level waittill(#"explode");
    weapon = waitresult.weapon;
    owner_cent = waitresult.owner_cent;
    position = waitresult.position;
    localclientnum = waitresult.localclientnum;

    if(weapon.rootweapon != weapon_proximity) {
      continue;
    }

    if(!util::is_player_view_linked_to_entity(localclientnum)) {
      explosionradius = weapon.explosionradius;
      localplayer = function_5c10bd79(localclientnum);

      if(distancesquared(localplayer.origin, position) < explosionradius * explosionradius) {
        if(isDefined(owner_cent)) {
          if(owner_cent function_21c0fa55() || !owner_cent function_83973173()) {
            localplayer thread postfx::playpostfxbundle("pstfx_shock_charge");
          }
        }
      }
    }
  }
}
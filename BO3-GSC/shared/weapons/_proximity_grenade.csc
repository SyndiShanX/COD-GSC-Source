/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_proximity_grenade.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace proximity_grenade;

function init_shared() {
  clientfield::register("toplayer", "tazered", 1, 1, "int", undefined, 0, 0);
  level._effect["prox_grenade_friendly_default"] = "weapon/fx_prox_grenade_scan_blue";
  level._effect["prox_grenade_friendly_warning"] = "weapon/fx_prox_grenade_wrn_grn";
  level._effect["prox_grenade_enemy_default"] = "weapon/fx_prox_grenade_scan_orng";
  level._effect["prox_grenade_enemy_warning"] = "weapon/fx_prox_grenade_wrn_red";
  level._effect["prox_grenade_player_shock"] = "weapon/fx_prox_grenade_impact_player_spwner";
  callback::add_weapon_type("proximity_grenade", &proximity_spawned);
  level thread watchforproximityexplosion();
}

function proximity_spawned(localclientnum) {
  if(self isgrenadedud()) {
    return;
  }
  self.equipmentfriendfx = level._effect["prox_grenade_friendly_default"];
  self.equipmentenemyfx = level._effect["prox_grenade_enemy_default"];
  self.equipmenttagfx = "tag_fx";
  self thread weaponobjects::equipmentteamobject(localclientnum);
}

function watchforproximityexplosion() {
  if(getactivelocalclients() > 1) {
    return;
  }
  weapon_proximity = getweapon("proximity_grenade");
  while(true) {
    level waittill("explode", localclientnum, position, mod, weapon, owner_cent);
    if(weapon.rootweapon != weapon_proximity) {
      continue;
    }
    localplayer = getlocalplayer(localclientnum);
    if(!localplayer util::is_player_view_linked_to_entity(localclientnum)) {
      explosionradius = weapon.explosionradius;
      if(distancesquared(localplayer.origin, position) < (explosionradius * explosionradius)) {
        if(isDefined(owner_cent)) {
          if(owner_cent == localplayer || !owner_cent util::friend_not_foe(localclientnum, 1)) {
            localplayer thread postfx::playpostfxbundle("pstfx_shock_charge");
          }
        }
      }
    }
  }
}
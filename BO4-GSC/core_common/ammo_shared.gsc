/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ammo_shared.gsc
***********************************************/

#include scripts\core_common\ai\systems\shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\throttle_shared;
#include scripts\weapons\weaponobjects;

#namespace ammo;

autoexec main() {
  if(!isDefined(level.ai_ammo_throttle)) {
    level.ai_ammo_throttle = new throttle();
    [[level.ai_ammo_throttle]] - > initialize(1, 0.1);
  }
}

dropaiammo() {
  self endon(#"death");

  if(!isDefined(self.ammopouch)) {
    return;
  }

  if(isDefined(self.disableammodrop) && self.disableammodrop) {
    return;
  }

  [[level.ai_ammo_throttle]] - > waitinqueue(self);
  droppedweapon = shared::throwweapon(self.ammopouch, "tag_stowed_back", 1, 0);

  if(isDefined(droppedweapon)) {
    droppedweapon thread ammo_pouch_think();
    droppedweapon setcontents(droppedweapon setcontents(0)&~(32768 | 67108864 | 8388608 | 33554432));
  }
}

ammo_pouch_think() {
  self endon(#"death");
  waitresult = self waittill(#"scavenger");
  player = waitresult.player;
  primary_weapons = player getweaponslistprimaries();
  offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
  arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
  offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
  player playSound(#"wpn_ammo_pickup");
  player playlocalsound(#"wpn_ammo_pickup");

  if(isDefined(level.b_disable_scavenger_icon) && level.b_disable_scavenger_icon) {
    player hud::flash_scavenger_icon();
  }

  for(i = 0; i < offhand_weapons_and_alts.size; i++) {
    weapon = offhand_weapons_and_alts[i];
    maxammo = 0;
    loadout = player loadout::find_loadout_slot(weapon);

    if(isDefined(loadout)) {
      if(loadout.count > 0) {
        maxammo = loadout.count;
      } else if(weapon.isheavyweapon && isDefined(level.overrideammodropheavyweapon) && level.overrideammodropheavyweapon) {
        maxammo = weapon.maxammo;
      }
    } else if(weapon == player.grenadetypeprimary && isDefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
      maxammo = player.grenadetypeprimarycount;
    } else if(weapon == player.grenadetypesecondary && isDefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
      maxammo = player.grenadetypesecondarycount;
    } else if(weapon.isheavyweapon && isDefined(level.overrideammodropheavyweapon) && level.overrideammodropheavyweapon) {
      maxammo = weapon.maxammo;
    }

    if(isDefined(level.customloadoutscavenge)) {
      maxammo = self[[level.customloadoutscavenge]](weapon);
    }

    if(maxammo == 0) {
      continue;
    }

    if(weapon.rootweapon == level.weaponsatchelcharge) {
      if(player weaponobjects::anyobjectsinworld(weapon.rootweapon)) {
        continue;
      }
    }

    stock = player getweaponammostock(weapon);

    if(weapon.isheavyweapon && isDefined(level.overrideammodropheavyweapon) && level.overrideammodropheavyweapon) {
      ammo = stock + weapon.clipsize;

      if(ammo > maxammo) {
        ammo = maxammo;
      }

      player setweaponammostock(weapon, ammo);
      player.scavenged = 1;
      continue;
    }

    if(stock < maxammo) {
      ammo = stock + 1;

      if(ammo > maxammo) {
        ammo = maxammo;
      } else if(isDefined(loadout)) {
        if("primarygrenade" == player loadout::function_8435f729(weapon)) {
          player notify(#"scavenged_primary_grenade");
        }
      }

      player setweaponammostock(weapon, ammo);
      player.scavenged = 1;
    }
  }

  for(i = 0; i < primary_weapons.size; i++) {
    weapon = primary_weapons[i];
    stock = player getweaponammostock(weapon);
    start = player getfractionstartammo(weapon);
    clip = weapon.clipsize;
    clip *= getdvarfloat(#"scavenger_clip_multiplier", 1);
    clip = int(clip);
    maxammo = weapon.maxammo;

    if(stock < maxammo - clip * 3) {
      ammo = stock + clip * 3;
      player setweaponammostock(weapon, ammo);
      continue;
    }

    player setweaponammostock(weapon, maxammo);
  }
}
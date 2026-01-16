/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\pickup_ammo.gsc
***********************************************/

#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\struct;
#include scripts\mp_common\dynamic_loadout;

#namespace pickup_ammo;

function_cff1656d() {
  pickup_ammos = getEntArray("pickup_ammo", "targetname");

  foreach(pickup in pickup_ammos) {
    pickup.trigger = spawn("trigger_radius_use", pickup.origin + (0, 0, 15), 0, 120, 100);
    pickup.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    pickup.trigger triggerignoreteam();
    pickup.gameobject = gameobjects::create_use_object(#"neutral", pickup.trigger, [], (0, 0, 60), "pickup_ammo");
    pickup.gameobject gameobjects::set_objective_entity(pickup.gameobject);
    pickup.gameobject gameobjects::set_visible_team(#"any");
    pickup.gameobject gameobjects::allow_use(#"any");
    pickup.gameobject gameobjects::set_use_time(0);
    pickup.gameobject.usecount = 0;
    pickup.gameobject.parentobj = pickup;
    pickup.gameobject.onuse = &function_5bb13b48;
  }
}

function_4827d817(weapon) {
  if(weapon.maxammo <= 0) {
    return false;
  }

  package = struct::get_script_bundle("bountyhunterpackage", level.bountypackagelist[0]);
  slot = undefined;

  if(isDefined(self.pers[#"dynamic_loadout"].weapons[0]) && self.pers[#"dynamic_loadout"].weapons[0].name == weapon.name) {
    slot = 0;
  } else if(isDefined(self.pers[#"dynamic_loadout"].weapons[1]) && self.pers[#"dynamic_loadout"].weapons[1].name == weapon.name) {
    slot = 1;
  }

  if(!isDefined(slot)) {
    return false;
  }

  weapindex = self.pers[#"dynamic_loadout"].clientfields[slot].val - 1;
  package = struct::get_script_bundle("bountyhunterpackage", level.bountypackagelist[weapindex]);
  var_e6e3de63 = package.var_ef921c3c;
  maxammo = package.refillammo;

  if(!isDefined(maxammo) || maxammo == 0) {
    maxammo = weapon.maxammo / weapon.clipsize;

    if(weapon.clipsize == 1) {
      maxammo += 1;
    }
  }

  clipammo = self getweaponammoclip(weapon);
  stockammo = self getweaponammostock(weapon);
  currentammo = float(clipammo + stockammo) / weapon.clipsize;

  if(weapon.statname == #"smg_capacity_t8" && weaponhasattachment(weapon, "uber")) {
    self setweaponammostock(weapon, weapon.clipsize);
  } else {
    if(currentammo >= maxammo) {
      return false;
    }

    currentammo += var_e6e3de63;

    if(currentammo > maxammo) {
      currentammo = maxammo;
    }

    self setweaponammostock(weapon, int(currentammo * weapon.clipsize) - clipammo);
  }

  return true;
}

private function_5bb13b48(player) {
  if(isDefined(player) && isplayer(player)) {
    var_bd3d7a99 = 0;
    primaries = player getweaponslistprimaries();

    foreach(weapon in primaries) {
      ammogiven = player function_4827d817(weapon);

      if(ammogiven) {
        var_bd3d7a99 = 1;
      }
    }

    if(var_bd3d7a99) {
      if(isDefined(self.objectiveid)) {
        objective_setinvisibletoplayer(self.objectiveid, player);
      }

      self.parentobj setinvisibletoplayer(player);
      self.trigger setinvisibletoplayer(player);
      self playsoundtoplayer(#"hash_587fec4cf4ba3ebb", player);
      self.usecount++;
      player gestures::function_56e00fbf(#"gestable_grab", undefined, 0);

      if(isDefined(level.var_aff59367) && level.var_aff59367) {
        self thread function_7a80944d(player);
      }
    } else {
      player iprintlnbold(#"hash_2ea29b19d0e205e7");
      self playsoundtoplayer(#"uin_unavailable_charging", player);
    }
  }

  if(!(isDefined(level.var_aff59367) && level.var_aff59367) && self.usecount >= level.var_ad9d03e7) {
    self.parentobj delete();
    self gameobjects::disable_object(1);
  }
}

private function_7a80944d(player) {
  level endon(#"game_ended");
  self endon(#"death");
  player endon(#"disconnect");
  wait isDefined(level.pickup_respawn_time) ? level.pickup_respawn_time : 0;

  if(isDefined(self.objectiveid)) {
    objective_setvisibletoplayer(self.objectiveid, player);
  }

  self.parentobj setvisibletoplayer(player);
  self.trigger setvisibletoplayer(player);
}
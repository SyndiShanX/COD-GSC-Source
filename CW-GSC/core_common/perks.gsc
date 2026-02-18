/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\perks.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace perks;

function private autoexec __init__system__() {
  system::register(#"perks_shared", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.tactical", 1, 5, "float", 0);
  clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.lethal", 1, 5, "float", 0);
  callback::on_spawned(&on_player_spawned);
  level.var_b8e083d0 = &function_b8e083d0;
}

function perk_setperk(str_perk) {
  if(!isDefined(self.var_fb3c9d6a)) {
    self.var_fb3c9d6a = [];
  }

  if(!isDefined(self.var_fb3c9d6a[str_perk])) {
    self.var_fb3c9d6a[str_perk] = 0;
  }

  assert(self.var_fb3c9d6a[str_perk] >= 0, "<dev string:x38>");
  assert(self.var_fb3c9d6a[str_perk] < 23, "<dev string:x53>");
  self.var_fb3c9d6a[str_perk]++;
  self setperk(str_perk);
}

function perk_unsetperk(str_perk) {
  if(!isDefined(self.var_fb3c9d6a)) {
    self.var_fb3c9d6a = [];
  }

  if(!isDefined(self.var_fb3c9d6a[str_perk])) {
    self.var_fb3c9d6a[str_perk] = 0;
  }

  self.var_fb3c9d6a[str_perk]--;
  assert(self.var_fb3c9d6a[str_perk] >= 0, "<dev string:x38>");

  if(self.var_fb3c9d6a[str_perk] <= 0) {
    self unsetperk(str_perk);
  }
}

function perk_hasperk(str_perk) {
  if(isDefined(self.var_fb3c9d6a) && isDefined(self.var_fb3c9d6a[str_perk]) && self.var_fb3c9d6a[str_perk] > 0) {
    return true;
  }

  return false;
}

function perk_reset_all() {
  self clearperks();
  self.var_fb3c9d6a = [];
}

function private on_player_spawned() {
  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.lethal", 0);
}

function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  weapon = eventstruct.weapon;

  if(isPlayer(self) && self hasperk("specialty_equipmentrecharge") && (weapon.offhandslot == "Lethal grenade" || weapon.offhandslot == "Tactical grenade")) {
    self endon(#"death");
    waittillframeend();

    if(is_true(eventstruct.projectile.throwback) || !isalive(self)) {
      return;
    }

    var_acddd81e = isDefined(weapon.var_7d4c12af) && weapon.var_7d4c12af != "None";
    var_e0ca50e9 = {
      #slot: weapon.offhandslot, #weapon: weapon, #var_acddd81e: var_acddd81e
    };

    if(!isDefined(self.var_7cedc725)) {
      self.var_7cedc725 = [];
    } else if(!isarray(self.var_7cedc725)) {
      self.var_7cedc725 = array(self.var_7cedc725);
    }

    self.var_7cedc725[self.var_7cedc725.size] = var_e0ca50e9;
    cf = var_e0ca50e9.slot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
    self clientfield::set_player_uimodel(cf, 0);

    if(self.var_7cedc725.size == 1) {
      self thread function_78976b52();
    }
  }
}

function private event_handler[gadget_on] function_7d697841(eventstruct) {
  player = eventstruct.entity;
  weapon = eventstruct.weapon;

  if(level.var_222e62a6 === 1) {
    if(isPlayer(player) && weapon.name == # "eq_stimshot") {
      player thread function_845e1139();
    }

    return;
  }

  if(isPlayer(player) && player hasperk("specialty_equipmentrecharge") && weapon.name == # "eq_stimshot") {
    var_e0ca50e9 = {
      #slot: weapon.offhandslot, #weapon: weapon, #var_acddd81e: 0
    };

    if(!isDefined(player.var_7cedc725)) {
      player.var_7cedc725 = [];
    } else if(!isarray(player.var_7cedc725)) {
      player.var_7cedc725 = array(player.var_7cedc725);
    }

    player.var_7cedc725[player.var_7cedc725.size] = var_e0ca50e9;
    cf = var_e0ca50e9.slot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
    player clientfield::set_player_uimodel(cf, 0);

    if(player.var_7cedc725.size == 1) {
      player thread function_78976b52();
    }
  }
}

function private function_845e1139() {
  self endoncallback(&function_c2b5717d, #"death", #"resupply");
  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
  success = self function_e5f5216f("hudItems.ammoCooldowns.equipment.tactical");

  if(is_true(success)) {
    weapon = getweapon(#"eq_stimshot");

    if(self hasweapon(weapon)) {
      currentcount = self getammocount(weapon);

      if(currentcount < self getclipsize(weapon)) {
        self setweaponammoclip(weapon, currentcount + 1);
      }
    }
  }

  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
}

function private function_78976b52() {
  self endoncallback(&function_4ed3bc25, #"death", #"resupply");
  offhandslot = self.var_7cedc725[0].slot;
  weapon = self.var_7cedc725[0].weapon;
  cf = offhandslot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
  success = self function_691948bf(cf);

  if(is_true(success)) {
    arrayremoveindex(self.var_7cedc725, 0);

    if(self hasweapon(weapon)) {
      currentoffhand = weapon;
    } else {
      if(offhandslot == "Lethal grenade") {
        var_396a7de9 = self function_826ed2dd();
      } else {
        var_396a7de9 = getweapon(self function_b958b70d(self.class_num, "secondarygrenade"));
      }

      if(self hasweapon(var_396a7de9)) {
        currentoffhand = var_396a7de9;
      }
    }

    if(isDefined(currentoffhand)) {
      currentcount = self getammocount(currentoffhand);

      if(currentcount < self getclipsize(currentoffhand)) {
        self setweaponammoclip(currentoffhand, currentcount + 1);
      }
    }
  }

  self clientfield::set_player_uimodel(cf, 0);

  if(self.var_7cedc725.size) {
    self thread function_78976b52();
    return;
  }

  self.var_7cedc725 = undefined;
}

function private function_e5f5216f(cf) {
  rechargetime = getdvarint(#"hash_72fe00ba2b98e139", 11);
  elapsedtime = 0;
  starttime = gettime();

  while(elapsedtime < rechargetime) {
    progress = elapsedtime / rechargetime;
    self clientfield::set_player_uimodel(cf, progress);
    waitframe(1);
    elapsedtime = float(gettime() - starttime) / 1000;
  }

  self playsoundtoplayer(#"hash_23df0ddc8d4048a2", self);
  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 1);
  return true;
}

function private function_691948bf(cf) {
  self endon(#"hash_5c998eb8e3fcffe5");
  rechargetime = getdvarint(#"hash_3d104eb411be9f06", 25);
  elapsedtime = 0;
  starttime = gettime();

  while(elapsedtime < rechargetime) {
    progress = elapsedtime / rechargetime;
    self clientfield::set_player_uimodel(cf, progress);
    waitframe(1);
    elapsedtime = gettime() - starttime;
    elapsedtime = float(elapsedtime) / 1000;
  }

  sound = cf == "hudItems.ammoCooldowns.equipment.lethal" ? # "hash_6d4b6b0490117874" : # "hash_23df0ddc8d4048a2";
  self playsoundtoplayer(sound, self);
  self clientfield::set_player_uimodel(cf, 1);
  return true;
}

function private function_b8e083d0(weapon) {
  if(isDefined(self.var_7cedc725)) {
    for(i = 0; i < self.var_7cedc725.size; i++) {
      if(weapon == self.var_7cedc725[i].weapon) {
        if(i == 0) {
          if(self.var_7cedc725.size > 1) {
            for(j = 1; j < self.var_7cedc725.size; j++) {
              if(weapon == self.var_7cedc725[j].weapon) {
                arrayremoveindex(self.var_7cedc725, j);
                return;
              }
            }
          }

          self notify(#"hash_5c998eb8e3fcffe5");
        }

        arrayremoveindex(self.var_7cedc725, i);
        return;
      }
    }
  }
}

function private function_4ed3bc25(notifyhash) {
  offhandslot = self.var_7cedc725[0].slot;

  if(isDefined(offhandslot)) {
    cf = offhandslot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
    self clientfield::set_player_uimodel(cf, 0);
  } else {
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.lethal", 0);
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
  }

  self.var_7cedc725 = undefined;
}

function private function_c2b5717d(notifyhash) {
  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
}
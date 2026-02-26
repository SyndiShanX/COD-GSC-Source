/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6e4eed37837ebc7.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_2d7ccca3;

function private autoexec __init__system__() {
  system::register(#"hash_3dcfc06bf6bfc5f5", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.ammoCooldowns.fieldUpgrade", 1, 5, "float", 0);
  callback::on_connect(&function_39a250e3);
  clientfield::register("missile", "fieldUpgradeActive", 1, 1, "int");
}

function private function_39a250e3() {
  if(isDefined(self.pers[#"fieldupgrades"])) {
    return;
  }

  if(!isDefined(self.pers[#"fieldupgrades"])) {
    self.pers[#"fieldupgrades"] = [];
  }

  if(!isDefined(self.pers[#"fieldupgrades"][#"ammo"])) {
    self.pers[#"fieldupgrades"][#"ammo"] = 0;
  }

  if(isDefined(game.playabletimepassed) && game.playabletimepassed > 0) {
    self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"] = float(game.playabletimepassed) / 1000;
  }
}

function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  weapon = eventstruct.weapon;

  if(function_62c1bfaa(weapon)) {
    if(level.var_c8f28fd7 === 1) {
      self replaceweapon(weapon, 0, level.var_43a51921);
      return;
    }

    if(level.var_d89ef54a !== 1) {
      projectile = eventstruct.projectile;

      if(isDefined(projectile)) {
        projectile clientfield::set("fieldUpgradeActive", 1);
      }

      self.pers[#"fieldupgrades"][#"ammo"]--;
      self function_1326b4ce(self.pers[#"fieldupgrades"][#"ammo"]);
      self function_42ee343f(#"hash_1af96128a3b1b348", self.pers[#"fieldupgrades"][#"ammo"]);
      self thread function_e7085388(weapon);
    }
  }
}

function private event_handler[player_loadoutchanged] function_688d2014(eventstruct) {
  if(eventstruct.event != "give_weapon" || level.var_c8f28fd7 === 1) {
    return;
  }

  weapon = eventstruct.weapon;

  if(function_62c1bfaa(weapon) && getgametypesetting(#"hash_2f0beae14bf17810") !== 1) {
    weaponindex = getitemindexfromref(weapon.name);
    self notify(#"hash_5e15609b9205fae8");
    self function_18afabb5(weaponindex);
    clipsize = self getweaponammoclipsize(weapon);
    self function_e7f8957a(clipsize);
    self function_42ee343f(#"hash_14ebcb39234f4126", weaponindex);
    self thread function_63ac35a3(weapon);
  }
}

function private function_63ac35a3(weapon) {
  self notify(#"hash_36a1ce93b922198d");
  self endon(#"death", #"hash_36a1ce93b922198d");
  clipsize = self getweaponammoclipsize(weapon);
  self function_e7f8957a(clipsize);

  if(self function_e3774219(weapon)) {
    self notify(#"switched_field_upgrade", {
      #var_51246a31: 1
    });
    var_e3774219 = 1;
    currentclip = 0;
  } else {
    currentclip = int(min(self.pers[#"fieldupgrades"][#"ammo"], clipsize));
  }

  waitframe(1);

  if(!self hasweapon(weapon)) {
    return;
  }

  self setweaponammoclip(weapon, currentclip);

  if(getdvarint(#"hash_559c662aa3277aeb", 0)) {
    self setweaponammoclip(weapon, 0);
  }

  if(self getweaponammoclip(weapon) >= clipsize) {
    self notify(#"hash_50ce27022d3b38c");
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 0);
    self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = undefined;

    if(is_true(var_e3774219)) {
      weaponindex = getitemindexfromref(weapon.name);
      self luinotifyevent(#"hash_14ebcb39234f4126", 1, weaponindex);
    }

    self function_1326b4ce(self getweaponammoclip(weapon));
    self function_cfb0d7cc(0);
    return;
  }

  var_d6dbd305 = 0;

  while(level.inprematchperiod || !self.hasspawned) {
    if(!var_d6dbd305) {
      var_d6dbd305 = 1;

      if(isDefined(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"])) {
        if(self hasperk(#"hash_46e52ae259ccc1e1")) {
          var_cdd95e58 = 1;
        }

        cooldown = function_e7967fc8(weapon, var_cdd95e58);
        self function_f6621fe5(int(cooldown));
        self function_cfb0d7cc(int(floor(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"])));
        progress = self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] / cooldown;
        self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", progress);
      }
    }

    waitframe(1);
  }

  self thread function_e7085388(weapon, var_e3774219);
}

function private function_e7085388(weapon, var_e3774219 = 0) {
  self notify(#"hash_50ce27022d3b38c");
  self endon(#"disconnect", #"hash_50ce27022d3b38c", #"round_ended", #"switched_field_upgrade");
  var_4dcb7b2e = self.pers[#"fieldupgrades"][#"hash_1f9e227d7c859634"];

  if(self hasperk(#"hash_46e52ae259ccc1e1")) {
    var_cdd95e58 = 1;
    self.pers[#"fieldupgrades"][#"hash_1f9e227d7c859634"] = 1;
  } else {
    self.pers[#"fieldupgrades"][#"hash_1f9e227d7c859634"] = undefined;
  }

  previousweapon = self.pers[#"fieldupgrades"][#"cooldownweapon"];
  weaponindex = getitemindexfromref(weapon.name);
  self.pers[#"fieldupgrades"][#"cooldownweapon"] = weapon;
  clipsize = self getweaponammoclipsize(weapon);
  self function_e7f8957a(clipsize);
  cooldown = function_e7967fc8(weapon, var_cdd95e58);
  self function_f6621fe5(int(cooldown));

  if(var_e3774219 || isDefined(self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"])) {
    if(var_e3774219) {
      var_d3239b6b = function_e7967fc8(previousweapon, var_4dcb7b2e);
      var_1b634dac = self.pers[#"fieldupgrades"][#"ammo"] * var_d3239b6b;

      if(isDefined(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"])) {
        var_1b634dac += self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"];
      }
    } else {
      var_1b634dac = self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"];
    }

    self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"] = undefined;
    var_e42bf9b2 = int(min(clipsize, floor(var_1b634dac / cooldown)));

    if(self hasweapon(weapon)) {
      self setweaponammoclip(weapon, var_e42bf9b2);
    }

    self.pers[#"fieldupgrades"][#"ammo"] = var_e42bf9b2;
    self function_1326b4ce(self.pers[#"fieldupgrades"][#"ammo"]);

    if(var_e42bf9b2 > 0) {
      self luinotifyevent(#"hash_14ebcb39234f4126", 1, weaponindex);
    }

    if(var_e42bf9b2 < clipsize) {
      self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = var_1b634dac - var_e42bf9b2 * cooldown;
      self function_cfb0d7cc(int(floor(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"])));
    } else {
      self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 0);
      self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = undefined;
      self function_cfb0d7cc(0);
      return;
    }
  }

  elapsedtime = isDefined(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"]) ? self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] : 0;

  if(is_true(var_cdd95e58) && !is_true(var_4dcb7b2e)) {
    elapsedtime *= 0.75;
  }

  var_9d2ffe1e = int(floor(elapsedtime));
  self function_cfb0d7cc(var_9d2ffe1e);

  while(elapsedtime < cooldown) {
    progress = elapsedtime / cooldown;
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", progress);

    if(var_9d2ffe1e < int(floor(elapsedtime))) {
      var_9d2ffe1e = int(floor(elapsedtime));
      self function_cfb0d7cc(var_9d2ffe1e);
    }

    waitframe(1);
    util::function_5355d311();
    elapsedtime += float(function_60d95f53()) / 1000;
    self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = elapsedtime;
  }

  self function_cfb0d7cc(int(floor(elapsedtime)));
  self.pers[#"fieldupgrades"][#"ammo"]++;
  self function_1326b4ce(self.pers[#"fieldupgrades"][#"ammo"]);

  if(isalive(self) && self hasweapon(weapon)) {
    self setweaponammoclip(weapon, self.pers[#"fieldupgrades"][#"ammo"]);
  }

  self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = undefined;
  self luinotifyevent(#"hash_14ebcb39234f4126", 1, weaponindex);
  self playsoundtoplayer(#"hash_55f9d99ffab775e1", self);

  if(self getweaponammoclip(weapon) < clipsize) {
    self thread function_e7085388(weapon);
    return;
  }

  self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 1);
}

function private function_e7967fc8(weapon, var_cdd95e58 = 0) {
  cooldown = weapon.var_2adfbb2f;

  if(cooldown <= 0) {
    cooldown = 60;
  }

  if(getdvarint(#"hash_ecac33069a44354", 0)) {
    cooldown = getdvarint(#"hash_ecac33069a44354", 0);
  }

  if(var_cdd95e58) {
    cooldown *= 0.75;
  }

  return cooldown;
}

function private function_62c1bfaa(weapon) {
  return weapon.offhandslot == "Special" && weapon.inventorytype == "ability";
}

function private function_e3774219(weapon) {
  previousweapon = self.pers[#"fieldupgrades"][#"cooldownweapon"];
  return isDefined(previousweapon) && previousweapon != weapon;
}

function private function_42ee343f(eventstring, data) {
  self function_6bf621ea(eventstring, 2, self getentitynumber(), data);
}
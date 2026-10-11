/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_443d99fe707f1d9f.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_485622d93fa7e4cf;
#using script_5032ed8da1128621;
#using script_6bffae1b97f70547;
#using script_cbdac3b4a48bb8f;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\values;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\weapons;
#namespace namespace_736197e4d378b91b;

function function_cbd6a7a14d9bb07b() {
  function_900f562c61c6a5d6("weapon", &function_a8315d7427925f00, &function_70024d27cb2942f5, &function_b9257704034d2b80, &function_61f99d560d896d24, &function_d5143d7900e7160a);
  function_5958815b72ad58a0("weapon", #"bundlenamefromlootid", &function_f4e4fc18f92ec23b);

  function_5958815b72ad58a0("<dev string:x1c>", #"hash_3483a973fd1fe5b8", &function_cb5a17997d502c15);

  function_5958815b72ad58a0("weapon", #"hash_79cd484b40e882b", &function_b5be5fff64626153);
  level callback::add("player_connect", &function_88d309900aaee871);
  level callback::add("player_spawned", &function_94cbe3c6bcb49cb1);
  level callback::add("player_weapon_change", &function_9942fa0e68e83f4c);
  utility::registersharedfunc("zombie", "GetPlayerWeaponRarity", &function_75e73212bbe447d9);
  level.commonitem.var_37d10554e6936847 = [];
  level.commonitem.var_b8ba13385a2bb5 = strtok(getDvar(@ "hash_56243d40ec08cee4", ""), ",");
  level.commonitem.var_feea62f594ad9284 = getdvarint(@ "hash_ac1ee90233495500", 0);

  thread function_95cd4c99989f7140();
}

function private function_88d309900aaee871(params) {
  self.var_dd3d589a27a0b26 = [];
}

function private function_94cbe3c6bcb49cb1(params) {
  if(namespace_2b1145f62aa835b8::isteamreviveenabledsharedfunc() && isDefined(self.revivecount)) {
    reviveweapons = self.primaryweapons;
    var_958c14c8fe2b530b = [];

    foreach(weapon in reviveweapons) {
      if(!isundefinedweapon(weapon)) {
        ammostruct = spawnStruct();
        ammostruct.clipammo = self getweaponammoclip(weapon);
        ammostruct.stockammo = self getweaponammostock(weapon);

        if(weapon.hasalternate) {
          altweapon = weapon getaltweapon();
          ammostruct.altclipammo = self getweaponammoclip(altweapon);
          ammostruct.altstockammo = self getweaponammostock(altweapon);
        }

        var_958c14c8fe2b530b[var_958c14c8fe2b530b.size] = ammostruct;
        inventory_utility::_takeweapon(weapon);
      }
    }

    maxindex = 0;
    var_cd77ac1b769e9c52 = 0;
    var_be1684f3e95e1024 = [];
    var_e9bd5ef4af54882a = [];
    reviveweaponindex = 0;

    while(reviveweaponindex < reviveweapons.size) {
      var_5db61256ca3c39bd = 0;

      while(var_5db61256ca3c39bd < self.var_dd3d589a27a0b26.size) {
        if(reviveweapons[reviveweaponindex].basename == self.var_dd3d589a27a0b26[var_5db61256ca3c39bd].baseweapon) {
          var_be1684f3e95e1024[var_5db61256ca3c39bd] = reviveweapons[reviveweaponindex];
          var_e9bd5ef4af54882a[var_5db61256ca3c39bd] = var_958c14c8fe2b530b[reviveweaponindex];

          if(var_5db61256ca3c39bd > maxindex) {
            maxindex = var_5db61256ca3c39bd;
          }

          if(reviveweaponindex == 0) {
            var_cd77ac1b769e9c52 = var_5db61256ca3c39bd;
          }

          break;
        }

        var_5db61256ca3c39bd += 1;
      }

      reviveweaponindex += 1;
    }

    i = 0;

    while(i <= maxindex) {
      weapon = var_be1684f3e95e1024[i];
      ammostruct = var_e9bd5ef4af54882a[i];

      if(isundefinedweapon(weapon)) {
        inventory_utility::_giveweapon(makeweapon("iw9_me_fists_mp"), undefined, undefined, 1);
      } else {
        inventory_utility::_giveweapon(weapon, undefined, undefined, 1);
        self setweaponammoclip(weapon, ammostruct.clipammo);
        self setweaponammostock(weapon, ammostruct.stockammo);

        if(weapon.hasalternate) {
          altweapon = weapon getaltweapon();
          self setweaponammoclip(altweapon, ammostruct.altclipammo);
          self setweaponammostock(altweapon, ammostruct.altstockammo);
        }
      }

      i += 1;
    }

    var_cd77ac1b769e9c52 = var_cd77ac1b769e9c52 >= self.primaryweapons.size ? self.primaryweapons.size - 1 : var_cd77ac1b769e9c52;
    inventory_utility::_switchtoweapon(self.primaryweapons[var_cd77ac1b769e9c52]);
    self setspawnweapon(self.primaryweapons[var_cd77ac1b769e9c52]);
  }
}

function private function_9942fa0e68e83f4c(params) {
  function_dcc83e7e97a52bf4();
}

function private function_dcc83e7e97a52bf4(weapon) {
  if(hasomnvar("ui_primary_weapon_rarity")) {
    primaryweaponobj = function_2aeaf88105d3b617(0);

    if(isDefined(primaryweaponobj)) {
      primaryweaponrarity = function_75e73212bbe447d9(primaryweaponobj);
      self setclientomnvar("ui_primary_weapon_rarity", primaryweaponrarity);
    } else {
      self setclientomnvar("ui_primary_weapon_rarity", 0);
    }
  }

  if(hasomnvar("ui_secondary_weapon_rarity")) {
    secondaryweaponobj = function_2aeaf88105d3b617(1);

    if(isDefined(secondaryweaponobj)) {
      secondaryweaponrarity = function_75e73212bbe447d9(secondaryweaponobj);
      self setclientomnvar("ui_secondary_weapon_rarity", secondaryweaponrarity);
    } else {
      self setclientomnvar("ui_secondary_weapon_rarity", 0);
    }
  }

  if(hasomnvar("ui_current_weapon_tier")) {
    weapon = isDefined(weapon) ? weapon : self getcurrentweapon();

    if(isnullweapon(weapon) || weapon.basename == "iw9_me_fists_mp" || weapon.basename == "iw8_gunless") {
      self setclientomnvar("ui_current_weapon_tier", 0);
      return;
    }

    n_rarity = function_75e73212bbe447d9(weapon);

    if(isDefined(n_rarity)) {
      self setclientomnvar("ui_current_weapon_tier", n_rarity);
      return;
    }

    self setclientomnvar("ui_current_weapon_tier", 0);
  }
}

function function_f4e4fc18f92ec23b(lootid) {
  blueprintindex = function_64ccc54bdbae5cf6(lootid);

  if(isDefined(blueprintindex) && blueprintindex != 0) {
    baseweapon = function_1cc3fd00b6ccc3ba(lootid);

    if(isDefined(baseweapon)) {
      if(isDefined(level.commonitem.var_37d10554e6936847[baseweapon]) && isDefined(level.commonitem.var_37d10554e6936847[baseweapon].bundles[blueprintindex])) {
        return level.commonitem.var_37d10554e6936847[baseweapon].bundles[blueprintindex][0];
      } else if(weaponinventorytype(baseweapon) == "offhand") {
        return namespace_f808ba0ae0debcf5::function_62fa129f91896347(lootid);
      }
    }
  }

  return level.commonitem.var_b09fc2aeb718c263[lootid];
}

function function_b5be5fff64626153(itembundlename) {
  itembundle = getscriptbundlefieldvalues("itemspawnentry:" + itembundlename, [#"baseweapon", #"weaponblueprint", #"ref", #"rarity", #"hash_b9a3752dc7a3d626", #"scriptable", #"hash_2eb67660fdfdf8a7", #"hash_ac804a3619667e5a"]);

  if(!isDefined(itembundle.baseweapon)) {
    return;
  }

  if(!isDefined(level.commonitem.var_37d10554e6936847[itembundle.baseweapon])) {
    level.commonitem.var_37d10554e6936847[itembundle.baseweapon] = {
      #bundles: []
    };
  }

  blueprintindex = 0;

  if(isDefined(itembundle.weaponblueprint) && isDefined(itembundle.ref)) {
    blueprintlootid = common_item::function_6d15e119c2779a93(itembundle);

    if(isDefined(blueprintlootid)) {
      blueprintindex = function_64ccc54bdbae5cf6(blueprintlootid);

      if(!isDefined(blueprintindex)) {
        assertmsg("<dev string:x26>" + itembundlename + "<dev string:x4f>" + getxhashhexname(itembundle.weaponblueprint) + "<dev string:x71>" + itembundle.baseweapon + "<dev string:xb5>");
        return;
      }
    }
  }

  rarity = isDefined(itembundle.rarity) ? itembundle.rarity : 0;

  if(!isDefined(level.commonitem.var_37d10554e6936847[itembundle.baseweapon].bundles[blueprintindex])) {
    level.commonitem.var_37d10554e6936847[itembundle.baseweapon].bundles[blueprintindex] = [];
  }

  if(!isDefined(level.commonitem.var_37d10554e6936847[itembundle.baseweapon].bundles[blueprintindex][rarity])) {
    level.commonitem.var_37d10554e6936847[itembundle.baseweapon].bundles[blueprintindex][rarity] = itembundlename;
  } else {
    print("<dev string:xbb>" + getxhashsourcename(level.commonitem.var_37d10554e6936847[itembundle.baseweapon].bundles[blueprintindex][rarity]) + "<dev string:xf9>" + itembundlename + "<dev string:x104>" + getxhashsourcename(itembundle.baseweapon) + "<dev string:x113>" + rarity + "<dev string:x12a>");
  }

  if(!istrue(itembundle.var_5a5e50bc261c907a)) {
    if(!isDefined(level.commonitem.var_37d10554e6936847[itembundle.baseweapon].scriptable)) {
      level.commonitem.var_37d10554e6936847[itembundle.baseweapon].scriptable = itembundle.scriptable;

      level.commonitem.var_37d10554e6936847[itembundle.baseweapon].var_35799804650f8bea = itembundlename;
    } else {
      print("<dev string:xbb>" + getxhashsourcename(level.commonitem.var_37d10554e6936847[itembundle.baseweapon].var_35799804650f8bea) + "<dev string:xf9>" + itembundlename + "<dev string:x104>" + getxhashsourcename(itembundle.baseweapon) + "<dev string:x113>" + rarity + "<dev string:x12a>");
    }

    if(isDefined(itembundle.var_64a5f9f552b5c973) || isDefined(itembundle.var_89616f2bce6b4ee6)) {
      if(!isDefined(level.commonitem.var_37d10554e6936847[itembundle.baseweapon].transform)) {
        level.commonitem.var_37d10554e6936847[itembundle.baseweapon].transform = spawnStruct();

        if(isDefined(itembundle.var_64a5f9f552b5c973)) {
          level.commonitem.var_37d10554e6936847[itembundle.baseweapon].transform.translation = (isDefined(itembundle.var_64a5f9f552b5c973.x) ? itembundle.var_64a5f9f552b5c973.x : 0, isDefined(itembundle.var_64a5f9f552b5c973.y) ? itembundle.var_64a5f9f552b5c973.y : 0, isDefined(itembundle.var_64a5f9f552b5c973.z) ? itembundle.var_64a5f9f552b5c973.z : 0);
        }

        if(isDefined(itembundle.var_89616f2bce6b4ee6)) {
          level.commonitem.var_37d10554e6936847[itembundle.baseweapon].transform.rotation = (isDefined(itembundle.var_89616f2bce6b4ee6.x) ? itembundle.var_89616f2bce6b4ee6.x : 0, isDefined(itembundle.var_89616f2bce6b4ee6.y) ? itembundle.var_89616f2bce6b4ee6.y : 0, isDefined(itembundle.var_89616f2bce6b4ee6.z) ? itembundle.var_89616f2bce6b4ee6.z : 0);
        }

        level.commonitem.var_37d10554e6936847[itembundle.baseweapon].transform.bundle = itembundlename;

        return;
      }

      print("<dev string:xbb>" + getxhashsourcename(level.commonitem.var_37d10554e6936847[itembundle.baseweapon].transform.bundle) + "<dev string:xf9>" + getxhashsourcename(itembundlename) + "<dev string:x184>" + getxhashsourcename(itembundle.baseweapon) + "<dev string:x19f>");
    }
  }
}

function function_70024d27cb2942f5(itembundle, item, autouse, allowswap) {
  if(!val::get("weapon_pickup")) {
    return false;
  }

  if(istrue(self.insertingarmorplate)) {
    return false;
  }

  currentweapon = self getcurrentweapon();

  if(istrue(scripts\cp_mp\weapon::iskillstreakweapon(currentweapon))) {
    return false;
  }

  var_4781343684fdc257 = function_7d4684238ed31570(itembundle, item);

  if(inventory_isenabled()) {
    var_cc7e6ebb30ea246c = function_e2b4c63cab73c1f1();

    if(isDefined(var_cc7e6ebb30ea246c) && issameweapon(var_4781343684fdc257, var_cc7e6ebb30ea246c)) {
      return false;
    }
  }

  return true;
}

function function_b9257704034d2b80(itembundle, item, autouse, allowswap) {
  return function_70024d27cb2942f5(itembundle, item, autouse, allowswap);
}

function function_278858bf72df5d3(weaponidx) {
  return scripts\cp_mp\loot\common_item::function_7ab86debeff1fefd("weapon", weaponidx);
}

function function_a8315d7427925f00(itembundle, item, autouse) {
  newweaponobj = undefined;

  if(isDefined(item.weaponobj)) {
    newweaponobj = item.weaponobj;
  } else if(isDefined(item.var_4f74f0aef2b2a8bf)) {
    newweaponobj = function_7d4684238ed31570(itembundle, item);
  } else {
    newweaponobj = function_777497d9d98fa0b8(itembundle);
  }

  if(!isDefined(newweaponobj)) {
    return;
  }

  newweaponstockammo = 0;

  if(isDefined(item.weaponstockammo)) {
    newweaponstockammo = item.weaponstockammo;
  } else {
    clipammo = function_b8bfea9514c89a77(item.count);
    maxclipammo = weaponclipsize(newweaponobj);

    if(clipammo > maxclipammo) {
      newweaponstockammo = clipammo - maxclipammo;
    }
  }

  if(function_d4246bdfe5eb28b5() > 1) {
    [oldweaponidx, oldweaponobj] = function_90aed8ec6b3a7796(newweaponobj);

    if(isDefined(oldweaponobj) && self hasweapon(oldweaponobj)) {
      oldammomod = undefined;

      if(namespace_dc2e59577d3a271f::has_ammo_mod(oldweaponobj)) {
        oldammomod = namespace_dc2e59577d3a271f::get_ammo_mod_name(oldweaponobj);
        namespace_dc2e59577d3a271f::function_b4da81e43557ada1(oldweaponobj);
      }

      var_b4e4346fea6a4cfd = scripts\cp_mp\pack_a_punch::get_pap_level(oldweaponobj);
      scripts\cp_mp\pack_a_punch::function_2756cd1449650568(oldweaponobj, undefined);

      if(oldweaponobj.basename != "iw9_me_fists_mp") {
        oldweaponstockammo = self getweaponammostock(oldweaponobj);
        var_e37e1e658de3f31c = getweaponammopoolname(oldweaponobj);
        var_96c1ababaeb1c163 = getweaponammopoolname(newweaponobj);

        if(var_e37e1e658de3f31c == var_96c1ababaeb1c163 && oldweaponstockammo > 0) {
          [oldweaponstockammo, newweaponstockammo] = function_f3045c1e8c70d171(oldweaponstockammo, newweaponobj, newweaponstockammo);
        }

        weaponinfostruct = spawnStruct();
        weaponinfostruct.ammoclipright = self getweaponammoclip(oldweaponobj);
        weaponinfostruct.ammoclipleft = self getweaponammoclip(oldweaponobj, "left");
        weaponinfostruct.var_9bfd50804dd2553c = function_aedc908c4a79d05e(oldweaponobj) ? 0 : self getweaponammoclip(oldweaponobj getaltweapon());
        weaponinfostruct.ammostock = oldweaponstockammo;
        weaponinfostruct.ammomod = oldammomod;
        weaponinfostruct.paplv = var_b4e4346fea6a4cfd;
        weaponinfostruct.rarity = function_75e73212bbe447d9(oldweaponobj);
        weaponinfostruct.camo = oldweaponobj.camo;
        weaponinfostruct.reticle = oldweaponobj.reticle;

        if(isDefined(self.var_c37e65eb7cc773eb)) {
          weaponinfostruct.var_dbd4f3fc1d4f4d53 = self.var_c37e65eb7cc773eb[oldweaponobj.var_9d7facbe889e667c];
          self.var_c37e65eb7cc773eb[oldweaponobj.var_9d7facbe889e667c] = undefined;
        }

        if(isDefined(oldweaponobj.stickerslot0) && oldweaponobj.stickerslot0 != "none") {
          weaponinfostruct.stickerslot0 = oldweaponobj.stickerslot0;
        }

        if(isDefined(oldweaponobj.stickerslot1) && oldweaponobj.stickerslot1 != "none") {
          weaponinfostruct.stickerslot1 = oldweaponobj.stickerslot1;
        }

        if(isDefined(oldweaponobj.stickerslot2) && oldweaponobj.stickerslot2 != "none") {
          weaponinfostruct.stickerslot2 = oldweaponobj.stickerslot2;
        }

        if(isDefined(oldweaponobj.stickerslot3) && oldweaponobj.stickerslot3 != "none") {
          weaponinfostruct.stickerslot3 = oldweaponobj.stickerslot3;
        }

        if(isDefined(oldweaponobj.var_b39ac546cc8621f8) && oldweaponobj.var_b39ac546cc8621f8 != "none") {
          weaponinfostruct.var_b39ac546cc8621f8 = oldweaponobj.var_b39ac546cc8621f8;
        }

        lifetimeoverride = function_278858bf72df5d3(oldweaponidx);
        function_23a822141e1e87f1(oldweaponobj, weaponinfostruct, lifetimeoverride);
      }

      function_ffe562ebbdab55fc(oldweaponidx);
      _takeweapon(oldweaponobj);
    } else {
      assertmsg("<dev string:x1eb>" + newweaponobj.basename + "<dev string:x235>");
      return;
    }
  }

  if(istrue(level.var_bfa98c9dd6edb929)) {
    if(isDefined(item.ammomod_name)) {
      namespace_dc2e59577d3a271f::add_ammo_mod_to_weapon(newweaponobj, item.ammomod_name);
    }
  }

  if(isDefined(item.var_dbd4f3fc1d4f4d53)) {
    self.var_c37e65eb7cc773eb[newweaponobj.var_9d7facbe889e667c] = item.var_dbd4f3fc1d4f4d53;
  }

  if(isDefined(item.n_pap_level) && item.n_pap_level > 0) {
    newweaponobj = scripts\cp_mp\pack_a_punch::function_a0537467c5341047(newweaponobj, item.n_pap_level);
    scripts\cp_mp\pack_a_punch::function_2756cd1449650568(newweaponobj, item.n_pap_level);
  }

  function_b2d47c265afcb72a(newweaponobj, item.count, newweaponstockammo);
  primaryweaponindex = function_2f5e1422c4b1932b(newweaponobj);

  if(isDefined(primaryweaponindex)) {
    if(isDefined(item.var_4f74f0aef2b2a8bf)) {
      self.var_dd3d589a27a0b26[primaryweaponindex] = item.var_4f74f0aef2b2a8bf;
    } else {
      var_4f74f0aef2b2a8bf = function_b5f358d46f69b20e(newweaponobj, itembundle.rarity, primaryweaponindex);
      var_4f74f0aef2b2a8bf.rarity = itembundle.rarity;
    }
  }

  return [0, newweaponobj];
}

function function_61f99d560d896d24(weapindex) {
  itembundle = undefined;
  quantity = 0;
  components = [];
  weapon = function_2aeaf88105d3b617(weapindex);

  if(isDefined(weapon) && !isnullweapon(weapon) && !weapons::isfistweapon(weapon)) {
    itembundle = function_2c85d7675de2e251(weapon);
    quantity = self getweaponammostock(weapon) + self getweaponammoclip(weapon);

    if(namespace_9571f642f38c8169::function_a6172e49f7313fd8()) {
      components = namespace_9571f642f38c8169::function_dec054b294d48a5c(weapon);
    }
  }

  return [itembundle, quantity, components];
}

function function_d5143d7900e7160a(weapindex, overridelifetime) {
  weapon = function_2aeaf88105d3b617(weapindex);

  if(!isDefined(weapon) || isnullweapon(weapon) || weapons::isfistweapon(weapon)) {
    return false;
  }

  oldammomod = undefined;

  if(namespace_dc2e59577d3a271f::has_ammo_mod(weapon)) {
    oldammomod = namespace_dc2e59577d3a271f::get_ammo_mod_name(weapon);
    namespace_dc2e59577d3a271f::function_b4da81e43557ada1(weapon);
  }

  var_b4e4346fea6a4cfd = scripts\cp_mp\pack_a_punch::get_pap_level(weapon);
  scripts\cp_mp\pack_a_punch::function_2756cd1449650568(weapon, undefined);
  weaponinfostruct = spawnStruct();
  weaponinfostruct.ammoclipright = self getweaponammoclip(weapon);
  weaponinfostruct.ammoclipleft = self getweaponammoclip(weapon, "left");
  weaponinfostruct.var_9bfd50804dd2553c = function_aedc908c4a79d05e(weapon) ? 0 : self getweaponammoclip(weapon getaltweapon());
  weaponinfostruct.ammostock = self getweaponammostock(weapon);
  weaponinfostruct.ammomod = oldammomod;
  weaponinfostruct.paplv = var_b4e4346fea6a4cfd;
  weaponinfostruct.rarity = function_75e73212bbe447d9(weapon);
  weaponinfostruct.camo = weapon.camo;
  weaponinfostruct.reticle = weapon.reticle;

  if(isDefined(self.var_c37e65eb7cc773eb)) {
    weaponinfostruct.var_dbd4f3fc1d4f4d53 = self.var_c37e65eb7cc773eb[weapon.var_9d7facbe889e667c];
    self.var_c37e65eb7cc773eb[weapon.var_9d7facbe889e667c] = undefined;
  }

  if(isDefined(weapon.stickerslot0) && weapon.stickerslot0 != "none") {
    weaponinfostruct.stickerslot0 = weapon.stickerslot0;
  }

  if(isDefined(weapon.stickerslot1) && weapon.stickerslot1 != "none") {
    weaponinfostruct.stickerslot1 = weapon.stickerslot1;
  }

  if(isDefined(weapon.stickerslot2) && weapon.stickerslot2 != "none") {
    weaponinfostruct.stickerslot2 = weapon.stickerslot2;
  }

  if(isDefined(weapon.stickerslot3) && weapon.stickerslot3 != "none") {
    weaponinfostruct.stickerslot3 = weapon.stickerslot3;
  }

  if(isDefined(weapon.var_b39ac546cc8621f8) && weapon.var_b39ac546cc8621f8 != "none") {
    weaponinfostruct.var_b39ac546cc8621f8 = weapon.var_b39ac546cc8621f8;
  }

  function_23a822141e1e87f1(weapon, weaponinfostruct, overridelifetime);

  if(weapindex == 2) {
    function_bd059d6c2e0ece90();
    return true;
  }

  function_ffe562ebbdab55fc(weapindex);
  _takeweapon(weapon);

  if(function_d4246bdfe5eb28b5() < 2) {
    fistsweapon = makeweapon("iw9_me_fists_mp");
    self giveweapon(fistsweapon);
    switchindex = ter_op(weapindex == 1, 0, 1);
    weapontoswitch = function_2aeaf88105d3b617(switchindex);

    if(!isDefined(weapontoswitch)) {
      weapontoswitch = fistsweapon;
    }

    _switchtoweaponimmediate(weapontoswitch);
  }

  return true;
}

function function_ad6e2b653093328a() {
  weaponobj = function_e2b4c63cab73c1f1();

  if(!isDefined(weaponobj)) {
    return;
  }

  weaponname = getcompleteweaponname(weaponobj);
  count = ter_op(isDefined(self.var_8a265f7b950a8d5d), self.var_8a265f7b950a8d5d, weaponclipsize(weaponobj));
  altammo = ter_op(weaponobj.hasalternate && isDefined(self.var_86b32aff94b5714e), self.var_86b32aff94b5714e, weaponclipsize(weaponobj getaltweapon()));
  ammocount = function_7209c8cd4b2e3afd(count, undefined, altammo);
  function_bd059d6c2e0ece90();
  function_b2d47c265afcb72a(weaponobj, ammocount);
}

function private function_b2d47c265afcb72a(weaponobj, ammocount, stockammo) {
  self giveweapon(weaponobj);
  self notify("pickedupweapon", weaponobj);
  var_c1192c297bbf292f = function_b8bfea9514c89a77(ammocount);
  var_7b7b94efe2e96d4b = function_9f9adbfb9db3d2ab(ammocount);
  clipsize = weaponclipsize(weaponobj);
  var_31b36738ff4eacd = 0;

  if(var_c1192c297bbf292f > clipsize) {
    var_31b36738ff4eacd += var_c1192c297bbf292f - clipsize;
    var_c1192c297bbf292f = clipsize;
  }

  if(isDefined(var_7b7b94efe2e96d4b) && var_7b7b94efe2e96d4b > clipsize) {
    var_31b36738ff4eacd += var_7b7b94efe2e96d4b - clipsize;
    var_7b7b94efe2e96d4b = clipsize;
  }

  self setweaponammoclip(weaponobj, var_c1192c297bbf292f);
  self setweaponammoclip(weaponobj, var_7b7b94efe2e96d4b, "left");

  if(!isaxeweapon(weaponobj)) {
    newstockammo = var_31b36738ff4eacd;

    if(isDefined(stockammo)) {
      newstockammo = stockammo;
    }

    newstockammo = int(min(newstockammo, weaponmaxammo(weaponobj)));
    self setweaponammostock(weaponobj, newstockammo);
  }

  if(weaponobj.hasalternate && !function_aedc908c4a79d05e(weaponobj)) {
    altweaponobj = weaponobj getaltweapon();
    var_dfd1fd5d26dd4e12 = function_8fd389f931f45c66(ammocount);
    altclipsize = weaponclipsize(altweaponobj);

    if(!isDefined(var_dfd1fd5d26dd4e12) || var_dfd1fd5d26dd4e12 > altclipsize) {
      var_dfd1fd5d26dd4e12 = altclipsize;
    }

    self setweaponammoclip(altweaponobj, var_dfd1fd5d26dd4e12);
  }

  self assignweaponprimaryslot(weaponobj);
  _switchtoweaponimmediate(weaponobj);
}

function function_23a822141e1e87f1(weaponobj, weaponinfostruct, overridelifetime) {
  var_4f74f0aef2b2a8bf = function_b5f358d46f69b20e(weaponobj, weaponinfostruct.rarity);

  if(!isDefined(var_4f74f0aef2b2a8bf)) {
    return undefined;
  }

  dropstruct = function_59a2e61d79065dca();
  dropstruct.var_8ee5ee589d379b1 = -30;
  dropstruct.var_91170e589f9e8ff = 30;
  dropstruct.var_82839e7264d5d15e = -30;
  dropstruct.var_8260b07264afb13c = 30;
  dropinfo = function_49b86047c8a8b228(dropstruct, self.origin, self.angles, self);
  item = function_6cf4b48de9a4bc39(weaponobj, weaponinfostruct, dropinfo.origin, dropinfo.angles, undefined, undefined, dropinfo.payload, undefined, overridelifetime);

  if(!isDefined(item)) {
    return undefined;
  }

  if(getdvarint(@ "hash_52f4a8ccedf61788", 1) == 1) {
    if(isaxeweapon(weaponobj) && item.count == 0) {
      if(isDefined(self.var_b4657c497095e74b)) {
        function_c14962ea14e58968(self.var_b4657c497095e74b);
      }

      self.var_b4657c497095e74b = item;
    }
  }

  if(isDefined(var_4f74f0aef2b2a8bf.itembundlename)) {
    itembundle = getscriptbundle("itemspawnentry:" + var_4f74f0aef2b2a8bf.itembundlename);
    lootid = function_6d15e119c2779a93(itembundle);
    self dlog_recordplayerevent("dlog_event_player_common_item", ["dropped", lootid, "stowed", 0, "equipped", 0, "bought", 0, "sold", 0, "type", itembundle.type, "from_cache", 0, "from_rift_reward", 0]);
    function_43272b9595268864(itembundle, dropinfo.origin);
  }

  item.var_4f74f0aef2b2a8bf = var_4f74f0aef2b2a8bf;
  params = spawnStruct();
  params.item = item;
  params.itembundlename = item.var_4f74f0aef2b2a8bf.itembundlename;
  callback::callback("player_item_drop", params);
  return item;
}

function function_c069cffb4cbd1707(itembundle, origin, angles, var_1d3bb1a1505a7fc7, var_763c4bec5399cf2e, var_14c85b39207719b8, var_57266f5ca6feebd7, payload1, payload2) {
  baseweapon = itembundle.baseweapon;

  if(!isDefined(baseweapon)) {
    return undefined;
  }

  weaponobj = function_777497d9d98fa0b8(itembundle);
  weaponinfostruct = spawnStruct();
  weaponinfostruct.ammoclipright = weaponclipsize(weaponobj);
  weaponinfostruct.ammoclipleft = weaponclipsize(weaponobj);
  weaponinfostruct.var_9bfd50804dd2553c = min(function_aedc908c4a79d05e(weaponobj) ? 0 : weaponclipsize(weaponobj getaltweapon()), 64 - 1);
  weaponinfostruct.ammostock = weaponmaxammo(weaponobj);
  weaponinfostruct.ammomod = var_1d3bb1a1505a7fc7;
  weaponinfostruct.paplv = var_763c4bec5399cf2e;
  weaponinfostruct.rarity = itembundle.rarity;
  angles = isDefined(angles) ? angles : (0, 0, 0);
  item = function_6cf4b48de9a4bc39(weaponobj, weaponinfostruct, origin, angles, var_14c85b39207719b8, var_57266f5ca6feebd7, payload1, payload2);

  if(!isDefined(item)) {
    return undefined;
  }

  function_43272b9595268864(itembundle, origin);
  item.var_4f74f0aef2b2a8bf = spawnStruct();
  item.var_4f74f0aef2b2a8bf.itembundlename = function_46423e80a0fa8f2(baseweapon, itembundle.rarity, weaponobj.variantid);
  item.var_4f74f0aef2b2a8bf.attachments = weaponobj.attachments;
  item.var_4f74f0aef2b2a8bf.rarity = itembundle.rarity;
  item.var_4f74f0aef2b2a8bf.baseweapon = baseweapon;
  item.var_4f74f0aef2b2a8bf.variantid = weaponobj.variantid;
  return item;
}

function function_6cf4b48de9a4bc39(weaponobj, weaponinfostruct, origin, angles, nodrop, nocleanup, payload1, payload2, overridelifetime) {
  baseweapon = weaponobj.basename;

  if(!isDefined(baseweapon)) {
    return undefined;
  }

  spawntransform = function_5898445f4e50bcdb(baseweapon);

  if(isDefined(spawntransform)) {
    if(isDefined(spawntransform.translation)) {
      origin += spawntransform.translation;
    }

    if(isDefined(spawntransform.rotation)) {
      angles += spawntransform.rotation;
    }
  }

  lootscriptable = weapon::iswonderweapon(weaponobj) ? % "hash_730e20a5158e3a0d" : % "obloot_custom_weapon";
  raritypayload = [#"customperkpackage", isDefined(weaponinfostruct.rarity) ? weaponinfostruct.rarity : 0, 0, 0, 0];
  item = spawncustomweaponscriptable(lootscriptable, origin, angles, undefined, weaponobj, raritypayload, payload1, payload2);

  if(isDefined(item)) {
    item.customweaponname = getcompleteweaponname(weaponobj);
  } else {
    assertmsg("<dev string:x28b>");
    return undefined;
  }

  item.count = function_7209c8cd4b2e3afd(weaponinfostruct.ammoclipright, weaponinfostruct.ammoclipleft, weaponinfostruct.var_9bfd50804dd2553c, weaponinfostruct.rarity);
  item.weaponstockammo = weaponinfostruct.ammostock;
  item.ammomod_name = weaponinfostruct.ammomod;
  item.n_pap_level = weaponinfostruct.paplv;
  item.var_dbd4f3fc1d4f4d53 = weaponinfostruct.var_dbd4f3fc1d4f4d53;
  item.weaponobj = weaponobj;

  if(!istrue(nodrop)) {
    item setscriptablepartstate(item.type, "dropped");
  }

  function_8908e7c9faba929a(item);
  item callback::callback("scriptable_item_spawned", {
    #angles: angles, #origin: origin, #itembundle: weaponinfostruct, #item: item
  });

  if(!istrue(nocleanup)) {
    var_2ae27d8437947d56 = default_to(overridelifetime, 90);
    item thread function_33ee459f817ccf86(var_2ae27d8437947d56);
  }

  return item;
}

function function_7d4684238ed31570(itembundle, item) {
  baseweaponname = itembundle.baseweapon;
  attachmentsarray = [];
  variantid = undefined;
  camo = undefined;
  reticle = undefined;

  if(isDefined(item.var_4f74f0aef2b2a8bf)) {
    if(isDefined(item.var_4f74f0aef2b2a8bf.baseweapon)) {
      baseweaponname = item.var_4f74f0aef2b2a8bf.baseweapon;
    }

    if(isDefined(item.var_4f74f0aef2b2a8bf.attachments)) {
      attachmentsarray = item.var_4f74f0aef2b2a8bf.attachments;
    }

    if(isDefined(item.var_4f74f0aef2b2a8bf.variantid)) {
      variantid = item.var_4f74f0aef2b2a8bf.variantid;
    }

    camo = item.var_4f74f0aef2b2a8bf.camo;
    reticle = item.var_4f74f0aef2b2a8bf.reticle;
  }

  stickers = [];

  if(isDefined(item.stickerslot0)) {
    stickers[stickers.size] = item.stickerslot0;
  }

  if(isDefined(item.stickerslot1)) {
    stickers[stickers.size] = item.stickerslot1;
  }

  if(isDefined(item.stickerslot2)) {
    stickers[stickers.size] = item.stickerslot2;
  }

  if(isDefined(item.stickerslot3)) {
    stickers[stickers.size] = item.stickerslot3;
  }

  if(isDefined(item.var_b39ac546cc8621f8)) {
    stickers[stickers.size] = item.var_b39ac546cc8621f8;
  }

  if(isDefined(variantid) && variantid != 0) {
    return weapon::buildweapon_blueprint(weapon::getweaponrootname(baseweaponname), camo, reticle, variantid, undefined, stickers);
  }

  return weapon::buildweapon(baseweaponname, attachmentsarray, camo, reticle, undefined, undefined, undefined, stickers);
}

function function_777497d9d98fa0b8(itembundle) {
  if(!isDefined(itembundle)) {
    assertmsg("<dev string:x2ef>");
    return undefined;
  }

  if(!isDefined(itembundle.baseweapon)) {
    assertmsg("<dev string:x363>");
    return undefined;
  }

  baseweaponname = itembundle.baseweapon;

  if(isDefined(itembundle.weaponblueprint)) {
    var_a1cb298d90255f53 = function_ce5e32676f572482(itembundle);
    assertex(var_a1cb298d90255f53 != 0, "<dev string:x3ea>" + common_item::function_467f0c241ad05cfb(itembundle.ref) + "<dev string:x43e>" + itembundle.ref + "<dev string:xb5>");
    lootid = common_item::function_6d15e119c2779a93(itembundle);
    blueprintcamo = function_c7771194200d360e(lootid);
    return weapon::buildweapon_blueprint(weapon::getweaponrootname(baseweaponname), blueprintcamo, undefined, var_a1cb298d90255f53);
  }

  attachmentsarray = [];

  if(getdvarint(@ "hash_fe8c3a210d6855dd") == 0) {
    attachmentsarray = function_4a20d0b8693d4656(itembundle);
  }

  return weapon::buildweapon(baseweaponname, attachmentsarray);
}

function function_c9fa4fbe86fb1c75(itembundlename) {
  if(!isDefined(itembundlename)) {
    return [];
  }

  var_b91e11f33e2a122d = getscriptbundlefieldvalues("itemspawnentry:" + itembundlename, [#"baseweapon", #"maxattachments", #"attachmentslots", #"hash_b48a8e8b021298fc", #"hash_582faf4b19c656ec"]);

  if(!isDefined(var_b91e11f33e2a122d)) {
    return [];
  }

  return function_4a20d0b8693d4656(var_b91e11f33e2a122d);
}

function function_4a20d0b8693d4656(itembundle) {
  weapon = itembundle.baseweapon;
  maxattachments = isDefined(itembundle.maxattachments) ? itembundle.maxattachments : 0;

  if(maxattachments == 0) {
    return [];
  }

  var_89eb760f6b8df087 = [];
  var_4aed501ce3a50793 = [];
  var_f6aae36b60d6e67f = [];
  var_c228159a2bfd2b4c = [];

  if(isDefined(itembundle.var_a70439f6a789d930)) {
    chance_offset = 0;
    random = randomfloat(100);

    foreach(var_151f9918b41e699d in itembundle.var_a70439f6a789d930) {
      if(!isDefined(var_151f9918b41e699d.chance)) {
        var_4aed501ce3a50793[var_4aed501ce3a50793.size] = var_151f9918b41e699d.attachment;
        continue;
      }

      if(random < chance_offset + var_151f9918b41e699d.chance && !arraycontains(level.commonitem.var_b8ba13385a2bb5, var_151f9918b41e699d.attachment)) {
        var_89eb760f6b8df087[var_89eb760f6b8df087.size] = var_151f9918b41e699d.attachment;

        if(var_89eb760f6b8df087.size >= maxattachments) {
          return var_89eb760f6b8df087;
        }

        var_f6aae36b60d6e67f[var_f6aae36b60d6e67f.size] = getattachmentslot(weapon, var_151f9918b41e699d.attachment);

        foreach(var_3a7356eec5bf4552 in getattachmentsblocked(weapon, var_151f9918b41e699d.attachment)) {
          var_4aed501ce3a50793[var_4aed501ce3a50793.size] = var_3a7356eec5bf4552;
        }

        foreach(blockedslot in getattachmentslotsblocked(weapon, var_151f9918b41e699d.attachment)) {
          var_f6aae36b60d6e67f[var_f6aae36b60d6e67f.size] = blockedslot;
        }

        foreach(var_c60000b703c5b2ea in getattachmentsblocked(weapon, var_151f9918b41e699d.attachment)) {
          var_c228159a2bfd2b4c[var_c228159a2bfd2b4c.size] = var_c60000b703c5b2ea;
        }

        break;
      } else {
        var_4aed501ce3a50793[var_4aed501ce3a50793.size] = var_151f9918b41e699d.attachment;
      }

      chance_offset += var_151f9918b41e699d.chance;
    }
  }

  if(!isDefined(itembundle.attachmentslots)) {
    return var_89eb760f6b8df087;
  }

  var_52e58fb32a89b835 = [];

  if(!isDefined(itembundle.var_71f90b307a0c6978) || itembundle.var_71f90b307a0c6978 == 1) {
    defaultattachments = getweapondefaultattachments(weapon);

    foreach(attachment in defaultattachments) {
      var_52e58fb32a89b835[getattachmentslot(weapon, attachment)] = attachment;
    }
  }

  var_273875869946e27c = [];
  var_b6f364a2adcb0e33 = [];

  foreach(var_b733f7b6e209a5ab in itembundle.attachmentslots) {
    if(arraycontains(var_f6aae36b60d6e67f, var_b733f7b6e209a5ab.slot)) {
      continue;
    }

    var_6eb6799cfc6da135 = [];

    if(istrue(var_b733f7b6e209a5ab.includeall)) {
      var_6eb6799cfc6da135 = function_75b035199842693d(weapon, var_b733f7b6e209a5ab.slot, level.commonitem.var_feea62f594ad9284);
    } else if(isDefined(var_b733f7b6e209a5ab.includelist)) {
      foreach(attachmententry in var_b733f7b6e209a5ab.includelist) {
        if(isDefined(attachmententry.attachment) && attachmententry.attachment != "") {
          var_6eb6799cfc6da135[var_6eb6799cfc6da135.size] = attachmententry.attachment;
        }
      }
    } else {
      continue;
    }

    var_a54649baf68ead4d = [];

    foreach(var_b7febab1f5c4c2c8 in var_6eb6799cfc6da135) {
      if(isDefined(var_52e58fb32a89b835[var_b733f7b6e209a5ab.slot]) && var_b7febab1f5c4c2c8 == var_52e58fb32a89b835[var_b733f7b6e209a5ab.slot]) {
        continue;
      }

      var_c79c00b942994a52 = getattachmentslot(weapon, var_b7febab1f5c4c2c8);

      if(var_c79c00b942994a52 != var_b733f7b6e209a5ab.slot) {
        if(var_c79c00b942994a52 == "") {
          assertmsg("<dev string:x453>" + var_b7febab1f5c4c2c8 + "<dev string:x46f>" + weapon + "<dev string:xb5>");
        } else {
          assertmsg("<dev string:x453>" + var_b7febab1f5c4c2c8 + "<dev string:x494>" + var_b733f7b6e209a5ab.slot + "<dev string:x4ad>" + var_c79c00b942994a52 + "<dev string:x4ee>" + weapon + "<dev string:xb5>");
        }

        continue;
      }

      if(arraycontains(level.commonitem.var_b8ba13385a2bb5, var_b7febab1f5c4c2c8)) {
        continue;
      }

      if(isDefined(var_b733f7b6e209a5ab.excludelist)) {
        excluded = 0;

        foreach(var_d352968aae470c76 in var_b733f7b6e209a5ab.excludelist) {
          if(var_d352968aae470c76.attachment == var_b7febab1f5c4c2c8) {
            excluded = 1;
            break;
          }
        }

        if(excluded) {
          continue;
        }
      }

      if(arraycontains(var_4aed501ce3a50793, var_b7febab1f5c4c2c8)) {
        continue;
      }

      basetype = getattachmentbasetype(weapon, var_b7febab1f5c4c2c8);

      if(isDefined(basetype) && arraycontains(var_c228159a2bfd2b4c, basetype)) {
        continue;
      }

      var_ea9750936cb9726b = 0;
      var_d30865ebf0ce910e = function_6dc98654fb071228(weapon, var_b7febab1f5c4c2c8);

      foreach(var_8630243a2ab728c9 in var_d30865ebf0ce910e) {
        if(!arraycontains(var_89eb760f6b8df087, var_8630243a2ab728c9)) {
          var_ea9750936cb9726b = 1;
          break;
        }
      }

      if(var_ea9750936cb9726b) {
        continue;
      }

      var_a54649baf68ead4d[var_a54649baf68ead4d.size] = var_b7febab1f5c4c2c8;
    }

    if(var_a54649baf68ead4d.size > 0) {
      if(istrue(var_b733f7b6e209a5ab.forced)) {
        attachment = var_a54649baf68ead4d[randomint(var_a54649baf68ead4d.size)];
        var_89eb760f6b8df087[var_89eb760f6b8df087.size] = attachment;

        if(var_89eb760f6b8df087.size >= maxattachments) {
          return var_89eb760f6b8df087;
        }

        foreach(var_3a7356eec5bf4552 in getattachmentsblocked(weapon, attachment)) {
          var_4aed501ce3a50793[var_4aed501ce3a50793.size] = var_3a7356eec5bf4552;
        }

        foreach(blockedslot in getattachmentslotsblocked(weapon, attachment)) {
          var_f6aae36b60d6e67f[var_f6aae36b60d6e67f.size] = blockedslot;
        }

        foreach(var_c60000b703c5b2ea in getattachmentsblocked(weapon, attachment)) {
          var_c228159a2bfd2b4c[var_c228159a2bfd2b4c.size] = var_c60000b703c5b2ea;
        }

        continue;
      }

      var_273875869946e27c[var_273875869946e27c.size] = var_b733f7b6e209a5ab.slot;
      var_b6f364a2adcb0e33[var_b733f7b6e209a5ab.slot] = var_a54649baf68ead4d;
    }
  }

  var_273875869946e27c = utility::array_randomize(var_273875869946e27c);

  foreach(slot in var_273875869946e27c) {
    if(arraycontains(var_f6aae36b60d6e67f, slot)) {
      continue;
    }

    var_b6f364a2adcb0e33[slot] = utility::array_randomize(var_b6f364a2adcb0e33[slot]);

    foreach(attachment in var_b6f364a2adcb0e33[slot]) {
      basetype = getattachmentbasetype(weapon, attachment);

      if(isDefined(basetype) && arraycontains(var_c228159a2bfd2b4c, basetype) || arraycontains(var_4aed501ce3a50793, attachment)) {
        continue;
      }

      var_ea9750936cb9726b = 0;
      var_d30865ebf0ce910e = function_6dc98654fb071228(weapon, attachment);

      foreach(var_8630243a2ab728c9 in var_d30865ebf0ce910e) {
        if(!arraycontains(var_89eb760f6b8df087, var_8630243a2ab728c9)) {
          var_ea9750936cb9726b = 1;
          break;
        }
      }

      if(var_ea9750936cb9726b) {
        continue;
      }

      var_89eb760f6b8df087[var_89eb760f6b8df087.size] = attachment;

      if(var_89eb760f6b8df087.size >= maxattachments) {
        return var_89eb760f6b8df087;
      }

      foreach(var_3a7356eec5bf4552 in getattachmentsblocked(weapon, attachment)) {
        var_4aed501ce3a50793[var_4aed501ce3a50793.size] = var_3a7356eec5bf4552;
      }

      foreach(blockedslot in getattachmentslotsblocked(weapon, attachment)) {
        var_f6aae36b60d6e67f[var_f6aae36b60d6e67f.size] = blockedslot;
      }

      foreach(var_c60000b703c5b2ea in getattachmentsblocked(weapon, attachment)) {
        var_c228159a2bfd2b4c[var_c228159a2bfd2b4c.size] = var_c60000b703c5b2ea;
      }

      break;
    }
  }

  return var_89eb760f6b8df087;
}

function function_46e8a35ad122218e(itembundle) {
  weapondata = spawnStruct();
  weapondata.baseweapon = itembundle.baseweapon;
  weapondata.rarity = itembundle.rarity;
  weapondata.attachments = function_4a20d0b8693d4656(itembundle);
  weapondata.variantid = function_ce5e32676f572482(itembundle);
  weapondata.itembundlename = function_46423e80a0fa8f2(itembundle.baseweapon, itembundle.rarity, weapondata.variantid);
  return weapondata;
}

function private function_23cdd58f4d4fa1ba(weaponobject, rarity, primaryweaponindex) {
  weapondata = spawnStruct();
  weapondata.baseweapon = weaponobject.basename;
  weapondata.rarity = default_to(rarity, 0);
  weapondata.attachments = weaponobject.attachments;
  weapondata.variantid = weaponobject.variantid;
  weapondata.itembundlename = function_46423e80a0fa8f2(weaponobject.basename, weapondata.rarity, weaponobject.variantid);
  self.var_dd3d589a27a0b26[primaryweaponindex] = weapondata;
  return weapondata;
}

function function_b5f358d46f69b20e(weaponobject, rarity, primaryweaponindex) {
  if(!isDefined(weaponobject)) {
    assertmsg("<dev string:x508>");
    return undefined;
  }

  if(!isPlayer(self)) {
    assertmsg("<dev string:x572>");
    return undefined;
  }

  if(!isDefined(primaryweaponindex)) {
    primaryweaponindex = function_2f5e1422c4b1932b(weaponobject);
  }

  if(!isDefined(primaryweaponindex) || primaryweaponindex < 0 || primaryweaponindex >= 2) {
    println("<dev string:x5d7>" + (isDefined(weaponobject.basename) ? weaponobject.basename : "<dev string:x63a>") + "<dev string:x649>" + (isDefined(primaryweaponindex) ? primaryweaponindex : "<dev string:x679>"));
    return undefined;
  }

  if(!isDefined(self.var_dd3d589a27a0b26[primaryweaponindex])) {
    function_23cdd58f4d4fa1ba(weaponobject, rarity, primaryweaponindex);
  }

  return self.var_dd3d589a27a0b26[primaryweaponindex];
}

function function_ffe562ebbdab55fc(primaryweaponindex) {
  if(!isDefined(primaryweaponindex) || primaryweaponindex < 0 || primaryweaponindex >= 2) {
    assertmsg("<dev string:x686>" + primaryweaponindex);
    return undefined;
  }

  self.var_dd3d589a27a0b26[primaryweaponindex] = undefined;
}

function function_2c85d7675de2e251(weaponobject) {
  primaryweaponindex = function_2f5e1422c4b1932b(weaponobject);

  if(!isDefined(primaryweaponindex) || !isDefined(self.var_dd3d589a27a0b26[primaryweaponindex]) || !isDefined(self.var_dd3d589a27a0b26[primaryweaponindex].itembundlename)) {
    return undefined;
  }

  itembundlename = self.var_dd3d589a27a0b26[primaryweaponindex].itembundlename;
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  return itembundle;
}

function function_3a0412b800f3331d(weapon, rarity) {
  weapondata = function_b5f358d46f69b20e(weapon, rarity);

  if(isDefined(weapondata)) {
    weapondata.rarity = rarity;
    function_dcc83e7e97a52bf4(weapon);
  }
}

function function_75e73212bbe447d9(weapon) {
  weapondata = function_b5f358d46f69b20e(weapon);

  if(isDefined(weapondata)) {
    return (isDefined(weapondata.rarity) ? weapondata.rarity : 0);
  }

  return 0;
}

function function_2aeaf88105d3b617(weapindex) {
  if(isDefined(weapindex)) {
    if(weapindex == 2) {
      return function_e2b4c63cab73c1f1();
    } else {
      indexcounter = 0;

      for(i = 0; i < self.primaryweapons.size; i++) {
        weapon = self.primaryweapons[i];

        if(weapon.basename != "none") {
          if(indexcounter == weapindex) {
            return weapon;
          }

          indexcounter++;
        }
      }
    }
  }

  return undefined;
}

function function_2f5e1422c4b1932b(weaponobject) {
  if(!isDefined(weaponobject)) {
    return undefined;
  }

  if(!isDefined(self.primaryweapons)) {
    assertmsg("<dev string:x6ed>");
    return undefined;
  }

  primaryweaponslist = self.primaryweapons;
  var_5ee0dd3a9ede9aa0 = weaponobject getnoaltweapon();

  for(i = 0; i < primaryweaponslist.size; i++) {
    weapon = primaryweaponslist[i];

    if(issameweapon(weaponobject, weapon) || isDefined(var_5ee0dd3a9ede9aa0) && !isnullweapon(var_5ee0dd3a9ede9aa0) && issameweapon(var_5ee0dd3a9ede9aa0, weapon)) {
      return i;
    }
  }

  return undefined;
}

function private function_90aed8ec6b3a7796(newweapon) {
  primaryweaponslist = self.primaryweapons;

  for(i = 0; i < primaryweaponslist.size; i++) {
    weapon = primaryweaponslist[i];

    if(newweapon.basename == weapon.basename) {
      return [i, weapon];
    }
  }

  for(i = 0; i < primaryweaponslist.size; i++) {
    weapon = primaryweaponslist[i];

    if(weapon.basename == "iw9_me_fists_mp") {
      return [i, weapon];
    }
  }

  currentweapon = self getcurrentweapon();
  currentweaponindex = function_2f5e1422c4b1932b(currentweapon);

  if(isDefined(currentweaponindex) && currentweaponindex < primaryweaponslist.size) {
    return [currentweaponindex, primaryweaponslist[currentweaponindex]];
  }

  return [undefined, undefined];
}

function function_c14b2cb6d5a65def(weapindex) {
  var_17d89f18c1d0eb4f = function_2aeaf88105d3b617(weapindex);
  switchindex = ter_op(weapindex == 1, 0, 1);

  if(!isDefined(var_17d89f18c1d0eb4f)) {
    return;
  }

  if(var_17d89f18c1d0eb4f.basename == "iw9_me_fists_mp") {
    return;
  }

  if(function_ced2abb96f1d86a5()) {
    function_ad6e2b653093328a();
  } else {
    fistsweapon = makeweapon("iw9_me_fists_mp");

    if(!self hasweapon("iw9_me_fists_mp")) {
      self giveweapon(fistsweapon);
    }

    weapontoswitch = function_2aeaf88105d3b617(switchindex);

    if(!isDefined(weapontoswitch)) {
      weapontoswitch = fistsweapon;
    }

    _switchtoweaponimmediate(weapontoswitch);
  }

  function_ad55c4cd0426138d(var_17d89f18c1d0eb4f);
  self takeweapon(var_17d89f18c1d0eb4f);
}

function private function_d4246bdfe5eb28b5() {
  numprimaries = self.primaryweapons.size;

  foreach(weap in self.primaryweapons) {
    if(isnullweapon(weap)) {
      numprimaries--;
    }
  }

  return numprimaries;
}

function private function_f3045c1e8c70d171(oldweaponstockammo, newweaponobj, newweaponstockammo) {
  var_315cd02a520438bf = weaponmaxammo(newweaponobj);
  var_d0de2243627d6414 = var_315cd02a520438bf - newweaponstockammo;

  if(oldweaponstockammo > var_d0de2243627d6414) {
    oldweaponstockammo -= var_d0de2243627d6414;
    newweaponstockammo = var_315cd02a520438bf;
  } else {
    newweaponstockammo += oldweaponstockammo;
    oldweaponstockammo = 0;
  }

  return [oldweaponstockammo, newweaponstockammo];
}

function function_aedc908c4a79d05e(weaponobj) {
  if(istrue(weaponobj.hasalternate)) {
    return (getattachmentbasetype(weaponobj, weaponobj.underbarrel) == "selectfire");
  }

  return false;
}

function function_9f04c40e25433451(baseweapon) {
  if(!isDefined(baseweapon)) {
    assertmsg("<dev string:x74f>");
    return undefined;
  }

  var_37d10554e6936847 = level.commonitem.var_37d10554e6936847[baseweapon];

  if(isDefined(var_37d10554e6936847)) {
    return var_37d10554e6936847.scriptable;
  }

  return undefined;
}

function function_5898445f4e50bcdb(baseweapon) {
  if(!isDefined(baseweapon)) {
    assertmsg("<dev string:x7c2>");
    return undefined;
  }

  var_37d10554e6936847 = level.commonitem.var_37d10554e6936847[baseweapon];

  if(isDefined(var_37d10554e6936847)) {
    return var_37d10554e6936847.transform;
  }

  return undefined;
}

function function_46423e80a0fa8f2(baseweapon, rarity, blueprintindex) {
  if(!isDefined(baseweapon)) {
    assertmsg("<dev string:x83b>");
    return undefined;
  }

  var_37d10554e6936847 = level.commonitem.var_37d10554e6936847[baseweapon];

  if(isDefined(var_37d10554e6936847)) {
    if(!isDefined(rarity)) {
      rarity = 0;
    }

    if(!isDefined(blueprintindex)) {
      blueprintindex = 0;
    }

    if(isDefined(var_37d10554e6936847.bundles[blueprintindex])) {
      return var_37d10554e6936847.bundles[blueprintindex][rarity];
    } else if(isDefined(var_37d10554e6936847.bundles[0])) {
      return var_37d10554e6936847.bundles[0][rarity];
    }
  }

  return undefined;
}

function function_ce5e32676f572482(itembundle) {
  if(isDefined(itembundle.ref)) {
    blueprintlootid = common_item::function_6d15e119c2779a93(itembundle);

    if(isDefined(blueprintlootid)) {
      blueprintindex = function_64ccc54bdbae5cf6(blueprintlootid);
      return (isDefined(blueprintindex) ? blueprintindex : 0);
    }
  }

  return 0;
}

function private function_95cd4c99989f7140() {
  if(getdvarint(@ "hash_10f0811105fc2f93", 0) == 0) {
    return;
  }

  setdvarifuninitialized(@ "hash_e981f2369f02b682", 350);
  setdvarifuninitialized(@ "hash_21adc9eb44b3d7ed", 20);
  setdvarifuninitialized(@ "hash_aac79e2ab4af9ee7", 1);
  setdvarifuninitialized(@ "hash_8b93e6e651c920bb", 1);

  if(!isDefined(level.var_61e6e1b83a8f3486)) {
    level.var_61e6e1b83a8f3486 = spawnStruct();
  }

  level.var_61e6e1b83a8f3486.weapondevgui = [];
  level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822 = [];
  level.var_61e6e1b83a8f3486.var_47020c5cf3e4b050 = [];
  devgui::function_6e7290c8ee4f558b("<dev string:x8a7>");
  devgui::function_b2159fbbd7ac094e("<dev string:x8bd>", @ "hash_d1415bb7a04b48f9");
  devgui::function_b23a59dfb4ca49a1("<dev string:x8d4>", "<dev string:x8f5>", &function_2388563f2076e75e, 0);
  devgui::function_b23a59dfb4ca49a1("<dev string:x90c>", "<dev string:x92f>", &function_2388563f2076e75e, 1);
  devgui::function_b23a59dfb4ca49a1("<dev string:x946>", "<dev string:x964>", &function_2388563f2076e75e, 2);
  devgui::function_b23a59dfb4ca49a1("<dev string:x97b>", "<dev string:x99b>", &function_2388563f2076e75e, 3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x9b2>", "<dev string:x9d7>", &function_2388563f2076e75e, 4);
  devgui::function_b23a59dfb4ca49a1("<dev string:x9ee>", "<dev string:xa07>", &function_c6fb716427c35c50, 0);
  devgui::function_b2159fbbd7ac094e("<dev string:xa30>", @ "hash_8b93e6e651c920bb", 1);
  devgui::function_df648211d66cd3dd("<dev string:xa4e>", "<dev string:xa66>", 2);
  devgui::function_df648211d66cd3dd("<dev string:xaa7>", "<dev string:xabf>", 3);
  devgui::function_df648211d66cd3dd("<dev string:xb00>", "<dev string:xb15>", 4);
  devgui::function_fe953f000498048f();
}

function private function_cb5a17997d502c15(var_9ec97bdad14a0a5b) {
  item_bundle = getscriptbundlefieldvalues("<dev string:xb54>" + var_9ec97bdad14a0a5b, [#"ref", #"subtype", #"rarity"]);

  if(!isDefined(item_bundle.ref) || getdvarint(@ "hash_10f0811105fc2f93", 0) == 0) {
    return;
  }

  subtype = isDefined(item_bundle.subtype) ? item_bundle.subtype : "<dev string:xb67>";
  rarity = isDefined(item_bundle.rarity) ? "<dev string:xb6c>" + item_bundle.rarity : "<dev string:xb70>";

  if(!isDefined(level.var_61e6e1b83a8f3486.weapondevgui[subtype])) {
    level.var_61e6e1b83a8f3486.weapondevgui[subtype] = {
      #refs: [], #generated: 0
    };
    devgui::function_b23a59dfb4ca49a1("<dev string:xb75>" + subtype, "<dev string:xb93>" + subtype, &function_acbdc55d88b2babd, 0, 0);
  }

  if(!isDefined(level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_bundle.ref])) {
    level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_bundle.ref] = {
      #rarities: [], #generated: 0
    };
  }

  level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_bundle.ref].rarities[rarity] = var_9ec97bdad14a0a5b;

  if(level.var_61e6e1b83a8f3486.weapondevgui[subtype].generated) {
    if(level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_bundle.ref].generated) {
      function_acbdc55d88b2babd([subtype, item_bundle.ref, rarity]);
      return;
    }

    function_acbdc55d88b2babd([subtype, item_bundle.ref]);
  }
}

function private function_2388563f2076e75e(params) {
  foreach(player in level.players) {
    player function_3a0412b800f3331d(player getcurrentweapon(), int(params[0]));
  }
}

function private function_acbdc55d88b2babd(params) {
  subtype = params[0];
  item_ref = params[1];
  rarity = params[2];

  if(isDefined(rarity)) {
    rarity_menu = "<dev string:xbba>" + rarity + "<dev string:xbc0>";

    switch (rarity) {
      case #"hash_311010bc01bd3a0f":
        rarity_menu = "<dev string:xbc5>";
        break;
      case #"hash_31100fbc01bd387c":
        rarity_menu = "<dev string:xbe1>";
        break;
      case #"hash_311012bc01bd3d35":
        rarity_menu = "<dev string:xbff>";
        break;
      case #"hash_311011bc01bd3ba2":
        rarity_menu = "<dev string:xc18>";
        break;
      case #"hash_31100cbc01bd33c3":
        rarity_menu = "<dev string:xc33>";
        break;
      case #"hash_31100bbc01bd3230":
        rarity_menu = "<dev string:xb6c>";
        break;
    }

    devgui_menu = "<dev string:xb75>" + subtype + "<dev string:xc53>" + item_ref + rarity_menu + "<dev string:xc58>";
    devgui::add_debug_command("<dev string:xc5e>" + devgui_menu + "<dev string:xc71>");
    var_9ec97bdad14a0a5b = level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_ref].rarities[rarity];
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xc77>", "<dev string:xc81>" + var_9ec97bdad14a0a5b, &common_item::function_f8162124bbb6ece3, 0, 0);
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xc90>", "<dev string:xc9a>" + var_9ec97bdad14a0a5b, &function_d26496ac40030d8a, 0, 1);
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xcb0>", "<dev string:xcbc>" + var_9ec97bdad14a0a5b, &function_9ea2acdd3cda26a2, 0, 2);
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xcd4>", "<dev string:xce9>" + var_9ec97bdad14a0a5b, &function_c6fb716427c35c50, 0, 3);
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xd13>", "<dev string:xd28>" + var_9ec97bdad14a0a5b, &function_c6fb716427c35c50, 0, 4);
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xd52>", "<dev string:xd67>" + var_9ec97bdad14a0a5b, &function_c6fb716427c35c50, 0, 5);
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xd91>", "<dev string:xda7>" + var_9ec97bdad14a0a5b, &function_c6fb716427c35c50, 0, 6);
    devgui::add_debug_command("<dev string:xdd2>" + devgui_menu + "<dev string:xc71>");
    level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_ref].rarities[rarity] = undefined;
    return;
  }

  if(isDefined(item_ref)) {
    if(level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_ref].generated) {
      return;
    }

    level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_ref].generated = 1;
    devgui_menu = "<dev string:xb75>" + subtype + "<dev string:xc53>" + item_ref + "<dev string:xc58>";
    devgui::add_debug_command("<dev string:xc5e>" + devgui_menu + "<dev string:xc71>");

    foreach(rarity, rarity_info in level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs[item_ref].rarities) {
      rarity_menu = "<dev string:xbba>" + rarity + "<dev string:xbc0>";

      switch (rarity) {
        case #"hash_311010bc01bd3a0f":
          rarity_menu = "<dev string:xbc5>";
          break;
        case #"hash_31100fbc01bd387c":
          rarity_menu = "<dev string:xbe1>";
          break;
        case #"hash_311012bc01bd3d35":
          rarity_menu = "<dev string:xbff>";
          break;
        case #"hash_311011bc01bd3ba2":
          rarity_menu = "<dev string:xc18>";
          break;
        case #"hash_31100cbc01bd33c3":
          rarity_menu = "<dev string:xc33>";
          break;
        case #"hash_31100bbc01bd3230":
          function_acbdc55d88b2babd([subtype, item_ref, rarity]);
          return;
      }

      devgui::function_b23a59dfb4ca49a1(devgui_menu + rarity_menu, "<dev string:xb93>" + subtype + "<dev string:xde3>" + item_ref + "<dev string:xde3>" + rarity, &function_acbdc55d88b2babd, 0, 0);
    }

    devgui::add_debug_command("<dev string:xdd2>" + devgui_menu + "<dev string:xc71>");
    return;
  }

  if(level.var_61e6e1b83a8f3486.weapondevgui[subtype].generated) {
    return;
  }

  level.var_61e6e1b83a8f3486.weapondevgui[subtype].generated = 1;
  devgui_menu = "<dev string:xb75>" + subtype + "<dev string:xc58>";
  devgui::add_debug_command("<dev string:xc5e>" + devgui_menu + "<dev string:xc71>");

  foreach(item_ref, ref_info in level.var_61e6e1b83a8f3486.weapondevgui[subtype].refs) {
    devgui::function_b23a59dfb4ca49a1(devgui_menu + "<dev string:xc53>" + item_ref, "<dev string:xb93>" + subtype + "<dev string:xde3>" + item_ref, &function_acbdc55d88b2babd, 0, 0);
  }

  devgui::add_debug_command("<dev string:xdd2>" + devgui_menu + "<dev string:xc71>");
}

function private function_d26496ac40030d8a(params) {
  itembundle = getscriptbundle(hashcat(%"itemspawnentry:", params[0]));
  item = function_c069cffb4cbd1707(itembundle, (0, 0, 0));

  foreach(player in level.players) {
    player common_item::function_de489fa2ffdb7f2d(item, 0);
  }
}

function private function_9ea2acdd3cda26a2(params) {
  itembundle = getscriptbundle(hashcat(%"itemspawnentry:", params[0]));
  item = function_c069cffb4cbd1707(itembundle, (0, 0, 0));

  foreach(player in level.players) {
    currentweaponobj = player getcurrentweapon();
    currentweaponindex = player function_2f5e1422c4b1932b(currentweaponobj);

    if(isDefined(currentweaponindex)) {
      player function_ffe562ebbdab55fc(currentweaponindex);
    }

    player inventory_utility::_takeweapon(currentweaponobj);
    player common_item::function_de489fa2ffdb7f2d(item, 0);
  }
}

function private function_c6fb716427c35c50(params) {
  command = params[0];
  var_9ec97bdad14a0a5b = params[1];

  if(command == "<dev string:xde8>") {
    if(isDefined(var_9ec97bdad14a0a5b)) {
      if(isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b])) {
        level.var_61e6e1b83a8f3486.var_47020c5cf3e4b050[level.var_61e6e1b83a8f3486.var_47020c5cf3e4b050.size] = level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].index;
        level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b] = undefined;
      }
    } else {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822 = [];
      level.var_61e6e1b83a8f3486.var_f06c14a7fd07855 = [];
    }

    return;
  }

  if(command == "<dev string:xdf1>") {
    if(isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b])) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].paused = 1;
    }

    return;
  }

  if(command == "<dev string:xdfa>") {
    free_index = level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822.size;
    lowest_index = 9999;

    foreach(index in level.var_61e6e1b83a8f3486.var_47020c5cf3e4b050) {
      if(index < lowest_index) {
        lowest_index = index;
        free_index = index;
      }
    }

    level.var_61e6e1b83a8f3486.var_47020c5cf3e4b050 = utility::array_remove(level.var_61e6e1b83a8f3486.var_47020c5cf3e4b050, free_index);

    if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b])) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b] = spawnStruct();
    }

    if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].iterations)) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].iterations = 0;
    }

    if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].index)) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].index = free_index;
    }

    if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].bundle)) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].bundle = getscriptbundle(hashcat(%"itemspawnentry:", var_9ec97bdad14a0a5b));
    }

    if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments)) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments = [];
    }

    if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].slots)) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].slots = [];
    }

    level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].paused = 0;

    if(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].iterations == 0) {
      thread function_a99e8a91fa0b3b39(var_9ec97bdad14a0a5b);
    }

    return;
  }

  if(command == "<dev string:xe03>") {
    if(isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b])) {
      total_count = level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].iterations;
      count_str = "<dev string:xb6c>" + total_count + (total_count > 9 ? total_count > 99 ? total_count > 999 ? "<dev string:xe0d>" : "<dev string:xe12>" : "<dev string:xe18>" : "<dev string:xe1f>");
      print(count_str + var_9ec97bdad14a0a5b);

      foreach(slot, attachments in level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments) {
        slot_count = level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].slots[slot];
        count_str = "<dev string:xb6c>" + slot_count + (slot_count > 9 ? slot_count > 99 ? slot_count > 999 ? "<dev string:xe12>" : "<dev string:xe18>" : "<dev string:xe1f>" : "<dev string:xe27>");
        percent_str = "<dev string:xe30>" + 100 * float(slot_count) / float(total_count) + "<dev string:xe36>";
        print(count_str + slot + percent_str);

        foreach(attachment, att_count in level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments[slot]) {
          count_str = "<dev string:xb6c>" + att_count + (att_count > 9 ? att_count > 99 ? att_count > 999 ? "<dev string:xe18>" : "<dev string:xe1f>" : "<dev string:xe27>" : "<dev string:xe3c>");
          percent_str = "<dev string:xe30>" + 100 * float(att_count) / float(slot_count) + "<dev string:xe36>";
          print(count_str + attachment + percent_str);
        }
      }
    }
  }
}

function private function_a99e8a91fa0b3b39(var_9ec97bdad14a0a5b) {
  while(true) {
    if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b])) {
      return;
    }

    if(!istrue(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].paused)) {
      level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].iterations += 1;
      var_aa3d2a34a5a7ab67 = function_4a20d0b8693d4656(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].bundle);

      foreach(attachment in var_aa3d2a34a5a7ab67) {
        slot = getattachmentslot(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].bundle.baseweapon, attachment);

        if(!isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments[slot])) {
          level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments[slot] = [];
        }

        if(isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].slots[slot])) {
          level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].slots[slot] += 1;
        } else {
          level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].slots[slot] = 1;
        }

        if(isDefined(level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments[slot][attachment])) {
          level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments[slot][attachment] += 1;
          continue;
        }

        level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments[slot][attachment] = 1;
      }
    }

    if(getdvarint(@ "hash_8b93e6e651c920bb", 1)) {
      scale = getdvarfloat(@ "hash_aac79e2ab4af9ee7", 1);
      space = int(8 * scale);
      line_height = int(12 * scale);
      x = getdvarint(@ "hash_e981f2369f02b682", 350);
      x += 350 * scale * level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].index;
      y = getdvarint(@ "hash_21adc9eb44b3d7ed", 20);
      frames = int(1000 * getdvarfloat(@ "hash_33348a07cb3e791b", 0.1) / getframeduration()) + 1;
      total_count = level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].iterations;
      printtoscreen2d(x, y, "<dev string:xb6c>" + total_count, (1, 1, 1), scale, frames);
      printtoscreen2d(x + 4 * space, y, "<dev string:xe0d>", (1, 1, 1), scale, frames);
      printtoscreen2d(x + 5 * space, y, var_9ec97bdad14a0a5b, (1, 1, 1), scale, frames);
      y += line_height;

      foreach(slot, attachments in level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments) {
        slot_count = level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].slots[slot];
        percent = "<dev string:xe30>" + 100 * float(slot_count) / float(total_count) + "<dev string:xe36>";
        printtoscreen2d(x, y, "<dev string:xb6c>" + slot_count, (1, 1, 1), scale, frames);
        printtoscreen2d(x + 5 * space, y, "<dev string:xe0d>", (1, 1, 1), scale, frames);
        printtoscreen2d(x + 6 * space, y, slot + percent, (1, 1, 1), scale, frames);
        y += line_height;

        foreach(attachment, att_count in level.var_61e6e1b83a8f3486.var_bdbda066e5e5a822[var_9ec97bdad14a0a5b].attachments[slot]) {
          percent = "<dev string:xe30>" + 100 * float(att_count) / float(slot_count) + "<dev string:xe36>";
          printtoscreen2d(x, y, "<dev string:xb6c>" + att_count, (1, 1, 1), scale, frames);
          printtoscreen2d(x + 6 * space, y, "<dev string:xe0d>", (1, 1, 1), scale, frames);
          printtoscreen2d(x + 7 * space, y, attachment + percent, (1, 1, 1), scale, frames);
          y += line_height;
        }
      }
    }

    wait getdvarfloat(@ "hash_33348a07cb3e791b", 0.1);
  }
}

# /
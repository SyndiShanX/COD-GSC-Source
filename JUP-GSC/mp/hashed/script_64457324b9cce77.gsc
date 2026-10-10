/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_64457324b9cce77.gsc
************************************************/

#using script_443d99fe707f1d9f;
#using script_6bffae1b97f70547;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace namespace_77804604a7f8a031;

function function_e365b9e0c732498c() {
  level.var_202c7fdc43f4a2cd = [];
  level.var_202c7fdc43f4a2cd[0] = "iw9_me_fists_mp";
  level.var_202c7fdc43f4a2cd[1] = "iw9_mg_jltv_mp";
  level.var_202c7fdc43f4a2cd[2] = "iw9_mg_patrol_boat_front_mp";
  level.var_202c7fdc43f4a2cd[3] = "iw9_mg_patrol_boat_back_mp";
  function_900f562c61c6a5d6("upgrade", &use_upgrade, &function_24d050ba31898496, &function_24d050ba31898496, &function_9f3d2876de4f5272);
}

function use_upgrade(itembundle, item, auto_use) {
  weapon = self getcurrentweapon();
  return function_450e4cf17da1bc5(weapon, itembundle, item, auto_use);
}

function function_450e4cf17da1bc5(weapon, itembundle, item, auto_use) {
  upgradetype = itembundle.subtype;

  if(upgradetype == "ammomod") {
    if(isDefined(itembundle.ammomodname)) {
      if(namespace_dc2e59577d3a271f::function_6a22621172a35366(weapon) && !namespace_dc2e59577d3a271f::function_60ade27585bef67(weapon, itembundle.ammomodname)) {
        self playsoundtoplayer("uin_ob_ammomod_used_" + itembundle.ammomodname, self);
        namespace_dc2e59577d3a271f::function_6c40f58b29a952a9(weapon, itembundle.ammomodname);

        if(namespace_dc2e59577d3a271f::has_ammo_mod(weapon)) {
          return (item.count - 1);
        }
      }
    }
  } else if(upgradetype == "aethertool") {
    var_84bda2c733869e7c = itembundle.rarity;
    rarity = function_75e73212bbe447d9(weapon);
    raritytoset = 0;

    if(isint(rarity) && rarity < 4) {
      switch (var_84bda2c733869e7c) {
        case 1:
          if(rarity < 1) {
            raritytoset = 1;
          }

          break;
        case 2:
          if(rarity < 2) {
            raritytoset = 2;
          }

          break;
        case 3:
          if(rarity < 3) {
            raritytoset = 3;
          }

          break;
        case 4:
          raritytoset = 4;
          break;
      }
    }

    if(raritytoset != 0) {
      self playsoundtoplayer("evt_aetherium_tool_use", self);
      function_3a0412b800f3331d(weapon, raritytoset);
      return (item.count - 1);
    }
  } else if(upgradetype == "aethercrystal") {
    if(scripts\cp_mp\pack_a_punch::can_pap(weapon)) {
      paplv = scripts\cp_mp\pack_a_punch::get_pap_level(weapon);
      var_84bda2c733869e7c = itembundle.rarity;

      if(isDefined(var_84bda2c733869e7c)) {
        switch (var_84bda2c733869e7c) {
          case 2:
            if(paplv == 0) {
              self playsoundtoplayer("evt_aetherium_crystal_use", self);
              scripts\cp_mp\pack_a_punch::pap_weapon(weapon, paplv);
              return (item.count - 1);
            }

            break;
          case 3:
            if(paplv == 0 || paplv == 1) {
              var_26a62bdd3e2cd19a = 0;

              if(paplv == 0) {
                var_26a62bdd3e2cd19a = 1;
              }

              paplv = 1;
              self playsoundtoplayer("evt_aetherium_crystal_use", self);
              scripts\cp_mp\pack_a_punch::pap_weapon(weapon, paplv, undefined, var_26a62bdd3e2cd19a);
              return (item.count - 1);
            }

            break;
          case 4:
            if(paplv != 3) {
              var_26a62bdd3e2cd19a = 0;

              if(paplv == 0) {
                var_26a62bdd3e2cd19a = 1;
              }

              paplv = 2;
              self playsoundtoplayer("evt_aetherium_crystal_use", self);
              scripts\cp_mp\pack_a_punch::pap_weapon(weapon, paplv, undefined, var_26a62bdd3e2cd19a);
              return (item.count - 1);
            }

            break;
        }
      }
    }
  } else if(upgradetype == "golden_armor_plate") {
    if(issharedfuncdefined("ob_armor", "set_golden_armor")) {
      self playsoundevent("sndevent_classified_acquisition_used");
      self[[getsharedfunc("ob_armor", "set_golden_armor")]]();
      return (item.count - 1);
    }
  } else if(upgradetype == "dog_whistle") {
    if(issharedfuncdefined("ob_dog_whistle", "spawn_hellhound_pet")) {
      self playsoundevent("sndevent_classified_acquisition_used");
      self[[getsharedfunc("ob_dog_whistle", "spawn_hellhound_pet")]]();
      return (item.count - 1);
    }
  } else if(upgradetype == "golden_ammo") {
    if(issharedfuncdefined("ob_golden_ammo", "set_goldenAmmo")) {
      self playsoundevent("sndevent_classified_acquisition_used");
      self[[getsharedfunc("ob_golden_ammo", "set_goldenAmmo")]]();
      return (item.count - 1);
    }
  } else if(upgradetype == "warlord_afo_beret" || upgradetype == "warlord_chemist_mask" || upgradetype == "warlord_maestro_mod") {
    if(issharedfuncdefined("ob_warlord_schematic_upgrade", "applyWarlordSchematicUpgrade")) {
      self playsoundevent("sndevent_classified_acquisition_used");
      function_f3bb4f4911a1beb2("ob_warlord_schematic_upgrade", "applyWarlordSchematicUpgrade", upgradetype);
      return (item.count - 1);
    }
  } else if(upgradetype == "grenade_bandolier") {
    if(issharedfuncdefined("ob_grenade_bandolier", "grenade_bandolier_give")) {
      self playsoundevent("sndevent_classified_acquisition_used");
      function_f3bb4f4911a1beb2("ob_grenade_bandolier", "grenade_bandolier_give");
      return (item.count - 1);
    }
  } else if(upgradetype == "disciple_bottle") {
    if(issharedfuncdefined("ob_disciple_bottle", "companion_spawn_disciple")) {
      self playsoundevent("sndevent_classified_acquisition_used");
      self[[getsharedfunc("ob_disciple_bottle", "companion_spawn_disciple")]]();
      return (item.count - 1);
    }
  }

  if(!isDefined(item.count)) {
    item.count = 1;
  }

  return item.count;
}

function function_d56493bc318d5c5a(itembundle, item) {
  if(issharedfuncdefined("killstreak", "can_upgrade")) {
    return function_f3bb4f4911a1beb2("killstreak", "can_upgrade", itembundle, item);
  }

  return 0;
}

function function_24d050ba31898496(itembundle, item, autouse, allowswap) {
  if(!isPlayer(self)) {
    return false;
  }

  upgradetype = itembundle.subtype;
  weapon = self getcurrentweapon();

  if(istrue(self.insertingarmorplate) || self isswitchingweapon()) {
    return false;
  }

  if(istrue(scripts\cp_mp\weapon::iskillstreakweapon(weapon)) && !function_d56493bc318d5c5a(itembundle, item)) {
    return false;
  }

  if(upgradetype == "ammomod") {
    if(weapon == level.weaponnone) {
      return false;
    }

    if(namespace_dc2e59577d3a271f::function_6a22621172a35366(weapon)) {
      return true;
    }
  } else if(upgradetype == "aethertool") {
    if(weapon == level.weaponnone) {
      return false;
    }

    foreach(weaponname in level.var_202c7fdc43f4a2cd) {
      if(weaponname == weapon.basename) {
        return false;
      }
    }

    if(istrue(iswonderweapon(weapon))) {
      return false;
    }

    var_84bda2c733869e7c = itembundle.rarity;
    rarity = function_75e73212bbe447d9(weapon);

    if(isint(rarity) && rarity < 4) {
      switch (var_84bda2c733869e7c) {
        case 1:
          if(rarity < 1) {
            return true;
          }

          break;
        case 2:
          if(rarity < 2) {
            return true;
          }

          break;
        case 3:
          if(rarity < 3) {
            return true;
          }

          break;
        case 4:
          if(rarity < 4) {
            return true;
          }

          break;
      }
    }
  } else if(upgradetype == "aethercrystal") {
    if(weapon == level.weaponnone) {
      return false;
    }

    if(!scripts\cp_mp\pack_a_punch::can_pap(weapon)) {
      return false;
    }

    paplv = scripts\cp_mp\pack_a_punch::get_pap_level(weapon);
    var_84bda2c733869e7c = itembundle.rarity;

    if(isDefined(var_84bda2c733869e7c)) {
      switch (var_84bda2c733869e7c) {
        case 2:
          if(paplv == 0) {
            return true;
          }

          break;
        case 3:
          if(paplv == 0 || paplv == 1) {
            return true;
          }

          break;
        case 4:
          if(paplv != 3) {
            return true;
          }

          break;
      }
    }
  } else if(upgradetype == "golden_armor_plate") {
    if(!istrue(self.var_28c033c3c5b37f1f)) {
      return true;
    }
  } else if(upgradetype == "golden_ammo") {
    if(!istrue(self.hasgoldenammo)) {
      return true;
    }
  } else if(upgradetype == "dog_whistle") {
    return true;
  } else if(upgradetype == "warlord_afo_beret" || upgradetype == "warlord_chemist_mask" || upgradetype == "grenade_bandolier" || upgradetype == "warlord_maestro_mod") {
    return true;
  } else if(upgradetype == "disciple_bottle") {
    return true;
  }

  return false;
}

function function_9f3d2876de4f5272() {
  itembundle = undefined;
  quantity = 0;
  return [itembundle, quantity];
}
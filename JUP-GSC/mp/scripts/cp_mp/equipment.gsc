/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\equipment.gsc
***********************************************/

#using script_13865ca76df87ea;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\geiger_counter;
#using scripts\cp_mp\equipment\hb_sensor;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\equipment\throwstar;
#using scripts\cp_mp\equipment_interact;
#using scripts\cp_mp\killstreaks\emp_drone;
#using scripts\cp_mp\killstreaks\emp_drone_targeted;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace equipment;

function init() {
  level.equipment = spawnStruct();
  inititems();

  if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.equipment_list)) {
    level.equipmenttable = "equipmentlist:" + level.gamemodebundle.equipment_list;
  } else if(getdvarint(@ "t10", 0) > 0) {
    level.equipmenttable = "equipmentlist:equipment_list_t10_mp";

    utility::scriptbundlewarning("<dev string:x1c>", level.equipmenttable);
  } else if(getdvarint(@ "mgl", 0) > 0) {
    level.equipmenttable = "equipmentlist:equipment_list_mgl_mp";

    utility::scriptbundlewarning("<dev string:x1c>", level.equipmenttable);
  } else if(utility::iscp()) {
    level.equipmenttable = "equipmentlist:equipment_list_iw9_cp";

    utility::scriptbundlewarning("<dev string:x1c>", level.equipmenttable);
  } else {
    level.equipmenttable = "equipmentlist:equipment_list_iw9_mp";

    utility::scriptbundlewarning("<dev string:x1c>", level.equipmenttable);
  }

  loadequipmentbundles();
  initlethalmaxoffsetmap();
  function_f8d145900d997580();

  if(!isDefined(level.onplayerspawncallbacks)) {
    level.onplayerspawncallbacks = [];
  }

  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = &equiponplayerspawned;
}

function inititems() {
  level.equipment.callbacks = [];
  globals = level.equipment;
  scripts\cp_mp\equipment_interact::equipmentinteract_init();

  if(issharedfuncdefined("equipment", "equipment_init")) {
    globals = [[getsharedfunc("equipment", "equipment_init")]](globals);
  }

  scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  scripts\cp_mp\equipment\throwstar::function_12d7ca3ff609caba();
  globals.callbacks["equip_throwing_knife"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  globals.callbacks["equip_throwing_knife"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  globals.callbacks["equip_throwing_knife_fire"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  globals.callbacks["equip_throwing_knife_fire"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  globals.callbacks["equip_throwing_knife_electric"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  globals.callbacks["equip_throwing_knife_electric"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  globals.callbacks["equip_throwstar"]["onGive"] = &scripts\cp_mp\equipment\throwstar::function_e7715ffb329c1b40;
  globals.callbacks["equip_throwstar"]["onTake"] = &scripts\cp_mp\equipment\throwstar::function_92e126d1a5d3fb2;
  globals.callbacks["equip_geigercounter"]["onGive"] = &scripts\cp_mp\equipment\geiger_counter::function_60cba38635fd35cb;
  globals.callbacks["equip_geigercounter"]["onTake"] = &scripts\cp_mp\equipment\geiger_counter::function_bdd02627bcafe359;
  globals.callbacks["equip_rfid"]["onGive"] = &scripts\cp_mp\equipment\geiger_counter::function_60cba38635fd35cb;
  globals.callbacks["equip_rfid"]["onTake"] = &scripts\cp_mp\equipment\geiger_counter::function_bdd02627bcafe359;
  thread watchlethaldelay();

  if(issharedfuncdefined("game", "registerOnDisconnectEventCallback")) {
    [[getsharedfunc("game", "registerOnDisconnectEventCallback")]](&onownerdisconnect);
  }

  thread debughackequipment();
  thread debugemp();
  thread debugempdrone();
  thread debugdestroyempdrones();
}

function private function_f8d145900d997580() {
  if(issharedfuncdefined("thermobaric_grenade", "thermobaric_grenade_init")) {
    [[getsharedfunc("thermobaric_grenade", "thermobaric_grenade_init")]]();
  }

  if(issharedfuncdefined("emp_grenade", "emp_grenade_init")) {
    [[getsharedfunc("emp_grenade", "emp_grenade_init")]]();
  }
}

function getcallback(ref, callback) {
  if(!isDefined(level.equipment.callbacks[ref])) {
    return undefined;
  }

  return level.equipment.callbacks[ref][callback];
}

function loadtable() {
  level.equipment.table = [];
  level.var_415476758ec47760 = [];

  for(row = 1; true; row++) {
    ref = tablelookupbyrow(level.equipmenttable, row, 1);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    lowerref = tolower(ref);
    struct = spawnStruct();
    struct.ref = lowerref;
    weaponname = tablelookupbyrow(level.equipmenttable, row, 6);
    assertex(isDefined(weaponname) && weaponname != "<dev string:x43>", "<dev string:x47>" + lowerref + "<dev string:x66>");

    if(weaponname != "none") {
      attachname = tablelookupbyrow(level.equipmenttable, row, 19);
      attachments = undefined;

      if(attachname != "") {
        baseweapon = makeweapon(weaponname);

        if(!isnullweapon(baseweapon)) {
          attachments = [attachname];
        }
      }

      struct.objweapon = makeweapon(weaponname, attachments);

      if(!isDefined(level.var_415476758ec47760[weaponname])) {
        level.var_415476758ec47760[weaponname] = lowerref;
      }
    }

    struct.id = row;
    struct.image = tablelookupbyrow(level.equipmenttable, row, 4);
    struct.defaultslot = ter_op(tablelookupbyrow(level.equipmenttable, row, 7) == "2", "secondary", "primary");
    struct.scavengerammo = int(tablelookupbyrow(level.equipmenttable, row, 10));
    struct.ispassive = tolower(tablelookupbyrow(level.equipmenttable, row, 11)) == "true";
    struct.isselectable = tablelookupbyrow(level.equipmenttable, row, 8) != "-1";
    struct.weaponname = weaponname;
    var_da24fa61707aa57f = tablelookupbyrow(level.equipmenttable, row, 12);

    if(var_da24fa61707aa57f == "none") {} else if(var_da24fa61707aa57f == "") {
      if(weaponname != "none") {
        struct.damageweaponnames = [weaponname];
      }
    } else {
      damageweaponnames = [];

      if(weaponname != "none") {
        damageweaponnames[damageweaponnames.size] = weaponname;
      }

      var_a2643f257ee064a3 = strtok(var_da24fa61707aa57f, " ");

      foreach(damageweaponname in var_a2643f257ee064a3) {
        damageweaponnames[damageweaponnames.size] = damageweaponname;
      }

      struct.damageweaponnames = damageweaponnames;
    }

    level.equipment.table[lowerref] = struct;
  }
}

function loadequipmentbundles() {
  level.equipment.table = [];
  level.equipmentblueprints = [];
  level.var_415476758ec47760 = [];
  var_9df9fe298aef6003 = getscriptbundle(level.equipmenttable);

  if(isDefined(var_9df9fe298aef6003)) {
    for(i = 0; i < var_9df9fe298aef6003.equipment_list.size; i++) {
      equipmentref = var_9df9fe298aef6003.equipment_list[i].ref;
      equipmentbundlename = var_9df9fe298aef6003.equipment_list[i].bundle;

      if(isDefined(equipmentbundlename)) {
        equipmentbundle = getscriptbundle("equipment:" + equipmentbundlename);

        if(isDefined(equipmentbundle)) {
          struct = spawnStruct();
          struct.ref = equipmentref;
          weaponname = equipmentbundle.useweapon;
          assertex(isDefined(weaponname), level.equipmenttable + "<dev string:x79>" + equipmentref + "<dev string:x66>");

          if(weaponname != "none") {
            attachments = undefined;
            baseweapon = makeweapon(weaponname);

            if(!isnullweapon(baseweapon)) {
              attachments = function_6527364c1ecca6c6(weaponname);
            }

            struct.objweapon = makeweapon(weaponname, attachments);
            blueprints = getweaponblueprintnames(weaponname);

            foreach(blueprint, id in blueprints) {
              var_1092bc40c58c1c9a = weaponname + "|" + string(id);
              level.equipmentblueprints[var_1092bc40c58c1c9a] = function_3211981142ec5aee(weaponname, blueprint);
            }

            if(!isDefined(level.var_415476758ec47760[weaponname])) {
              level.var_415476758ec47760[weaponname] = equipmentref;
            }
          }

          struct.id = i;
          struct.image = equipmentbundle.image;
          struct.defaultslot = ter_op(isDefined(equipmentbundle.uislot) && equipmentbundle.uislot == 2, "secondary", "primary");
          struct.scavengerammo = ter_op(isDefined(equipmentbundle.scavengerammo), equipmentbundle.scavengerammo, 0);
          struct.ispassive = isDefined(equipmentbundle.ispassive) && equipmentbundle.ispassive;
          struct.isselectable = !isDefined(equipmentbundle.uiorder) || equipmentbundle.uiorder != -1;
          struct.weaponname = weaponname;
          struct.bundle = equipmentbundle;
          var_da24fa61707aa57f = equipmentbundle.damageweapons;

          if(!isDefined(var_da24fa61707aa57f)) {
            if(weaponname != "none") {
              struct.damageweaponnames = [weaponname];
            }
          } else if(var_da24fa61707aa57f == "none") {} else {
            damageweaponnames = [];

            if(weaponname != "none") {
              damageweaponnames[damageweaponnames.size] = weaponname;
            }

            var_a2643f257ee064a3 = strtok(var_da24fa61707aa57f, " ");

            foreach(damageweaponname in var_a2643f257ee064a3) {
              damageweaponnames[damageweaponnames.size] = damageweaponname;
            }

            struct.damageweaponnames = damageweaponnames;
          }

          level.equipment.table[equipmentref] = struct;
        }
      }
    }
  }
}

function getequipmenttableinfo(ref) {
  if(isDefined(ref) && !isDefined(level.equipment.table[ref])) {
    assertmsg("<dev string:x88>" + ref + "<dev string:xde>");
  }

  return level.equipment.table[ref];
}

function function_f4f687e4e1edb923(equipmentname) {
  tokens = strtok(equipmentname, "_");
  tokens = array_remove_index(tokens, tokens.size - 1);

  if(tokens[0] == "jup") {
    tokens = array_remove_index(tokens, 0);
  }

  equipmentroot = "";
  counter = 0;

  foreach(tok in tokens) {
    if(counter == 0) {
      equipmentroot += tok;
      counter++;
      continue;
    }

    equipmentroot = equipmentroot + "_" + tok;
  }

  return equipmentroot;
}

function buildequipment(weaponname, variantid) {
  if(!isDefined(weaponname)) {
    return undefined;
  }

  if(isDefined(variantid) && variantid > 0) {
    weapon = makeweapon(weaponname, [], undefined, undefined, variantid);
    var_1092bc40c58c1c9a = weaponname + "|" + string(variantid);
    attachments = level.equipmentblueprints[var_1092bc40c58c1c9a];

    foreach(attachment, variant in attachments) {
      weapon = weapon withattachment(attachment, variant);
    }
  } else {
    weapon = makeweapon(weaponname);
  }

  return weapon;
}

function giveequipment(ref, slot, class, variantid) {
  assert(isDefined(ref));
  assert(isDefined(slot));

  if(!isDefined(self.equipment)) {
    self.equipment = [];
  }

  if(ref == "none") {
    return;
  }

  tableinfo = getequipmenttableinfo(ref);
  assertex(isDefined(tableinfo), "<dev string:xe3>" + ref + "<dev string:x10f>");

  if(!isDefined(tableinfo)) {
    return;
  }

  if(slot == "super") {
    supername = level.br_pickups.var_14bd11727c4b6629[level.br_pickups.br_equipnametoscriptable[ref]];

    if(issharedfuncdefined("supers", "getSuperID")) {
      tableinfo.id = [[getsharedfunc("supers", "getSuperID")]](supername);
    }
  }

  takeequipment(slot);
  weapon = undefined;

  if(isDefined(variantid)) {
    weapon = buildequipment(tableinfo.weaponname, variantid);
    var_9b32d1936831f5aa = function_71efed8bf57f1d39(tableinfo.bundle, variantid);

    if(isDefined(var_9b32d1936831f5aa)) {
      self function_53c61cc39f6a3b11(var_9b32d1936831f5aa);
    }
  } else {
    weapon = tableinfo.objweapon;
  }

  if(isDefined(weapon) && is_equipment_slot_allowed(slot) && !tableinfo.ispassive) {
    self giveweapon(weapon);

    if(slot == "primary") {
      self assignweaponoffhandprimary(weapon);
    } else if(slot == "secondary") {
      self assignweaponoffhandsecondary(weapon);
    } else if(slot == "super") {
      self assignweaponoffhandspecial(weapon);
    }
  }

  sethudslot(slot, tableinfo.id);
  self.equipment[slot] = ref;
  var_645972186625daee = getcallback(ref, "onGive");

  if(isDefined(var_645972186625daee)) {
    self thread[[var_645972186625daee]](ref, slot, variantid);
  }

  function_22bf78eca6578d7d(slot, class);
  isthrowing = ref == "equip_throwing_knife" || ref == "equip_throwing_knife_fire" || ref == "equip_throwing_knife_electric" || ref == "equip_shuriken" || ref == "equip_throwstar";

  if(issharedfuncdefined("game", "getGameType") && [[getsharedfunc("game", "getGameType")]]() == "arena" && isthrowing) {} else {
    thread watchlethaldelayplayer(ref, slot);
  }

  self notify("equipment_given", ref);
}

function takeequipment(slot) {
  assert(isDefined(slot));
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return;
  }

  tableinfo = getequipmenttableinfo(ref);

  if(isDefined(tableinfo.objweapon)) {
    if(self hasweapon(tableinfo.objweapon)) {
      _takeweapon(tableinfo.objweapon);

      if(slot == "primary") {
        self clearoffhandprimary();
      } else if(slot == "secondary") {
        self clearoffhandsecondary();
      } else if(slot == "super") {
        self clearoffhandspecial();
      }
    }
  }

  sethudslot(slot, 0);
  self.equipment[slot] = undefined;
  var_c96c25b8a1f6fe18 = getcallback(ref, "onTake");

  if(isDefined(var_c96c25b8a1f6fe18)) {
    self thread[[var_c96c25b8a1f6fe18]](ref, slot);
  }

  function_22bf78eca6578d7d(slot);
  self notify("equipment_taken_" + ref);
}

function equiponplayerdamaged(data) {
  weaponname = data.objweapon.basename;

  foreach(ref, tableinfo in level.equipment.table) {
    var_148e2d88d1deffd3 = getcallback(ref, "onPlayerDamaged");

    if(isDefined(var_148e2d88d1deffd3) && isDefined(tableinfo.damageweaponnames)) {
      foreach(damageweaponname in tableinfo.damageweaponnames) {
        if(damageweaponname == weaponname) {
          callbackstarttime = gettime();
          result = [[var_148e2d88d1deffd3]](data);
          assertex(gettime() == callbackstarttime, "<dev string:x114>" + ref + "<dev string:x134>");
          return result;
        }
      }
    }
  }
}

function ondestroyedbytrophy() {
  if(isDefined(self.equipmentref)) {
    var_99115207769478ff = getcallback(self.equipmentref, "onDestroyedByTrophy");

    if(isDefined(var_99115207769478ff)) {
      self thread[[var_99115207769478ff]]();
      return true;
    } else if(issharedfuncdefined("equipment", "isPlantedEquipment") && [[getsharedfunc("equipment", "isPlantedEquipment")]](self)) {
      if(issharedfuncdefined("equipment", "deleteExplosive")) {
        self thread[[getsharedfunc("equipment", "deleteExplosive")]]();
        return true;
      }
    }
  }

  return false;
}

function is_equipment_slot_allowed(slot) {
  switch (slot) {
    case #"hash_325cb2e66f67d5b9":
      return val::get("equipment_primary");
    case #"hash_511d3c24fcedcdb1":
      return val::get("equipment_secondary");
    default:
      return 1;
  }
}

function sethudslot(slot, id) {
  if(slot != "super") {
    self setclientomnvar("ui_equipment_id_" + slot, id);
    return;
  }

  if(level.gametype == "dungeons") {
    self setclientomnvar("ui_field_upgrade_icon", id);
    return;
  }

  self setclientomnvar("ui_perk_package_super1", id);
}

function getcurrentequipment(slot) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[slot];
}

function clearallequipment() {
  if(!isDefined(self.equipment)) {
    return;
  }

  foreach(slot, ref in self.equipment) {
    takeequipment(slot);
  }
}

function function_f528e58424d9c3e3(classtype, isprimary) {}

function function_11a4d197e8db4f(classtype) {
  if(!isDefined(level.gamemodebundle) || !istrue(level.gamemodebundle.var_e12ed09bf2e43167)) {
    if(issharedfuncdefined("loadout", "getExtraEquipmentPrimary")) {
      return [[getsharedfunc("loadout", "getExtraEquipmentPrimary")]](self.class_num);
    }
  } else {
    switch (classtype) {
      case #"hash_44e999799ff10fce":
        if(issharedfuncdefined("loadout", "cac_getFlcExtraEquipmentPrimary")) {
          return [[getsharedfunc("loadout", "cac_getFlcExtraEquipmentPrimary")]](self.class_num);
        }

        break;
      default:
        if(issharedfuncdefined("loadout", "table_getFlcExtraEquipmentPrimary")) {
          return [[getsharedfunc("loadout", "table_getFlcExtraEquipmentPrimary")]](level.classtablename, self.class_num);
        }

        break;
    }
  }

  return 0;
}

function function_58ea099b568dbfaf(classtype) {
  if(!isDefined(level.gamemodebundle) || !istrue(level.gamemodebundle.var_e12ed09bf2e43167)) {
    if(issharedfuncdefined("loadout", "getExtraEquipmentSecondary")) {
      return [[getsharedfunc("loadout", "getExtraEquipmentSecondary")]](self.class_num);
    }
  } else {
    switch (classtype) {
      case #"hash_44e999799ff10fce":
        if(issharedfuncdefined("loadout", "cac_getFlcExtraEquipmentSecondary")) {
          return [[getsharedfunc("loadout", "cac_getFlcExtraEquipmentSecondary")]](self.class_num);
        }

        break;
      default:
        if(issharedfuncdefined("loadout", "table_getFlcExtraEquipmentSecondary")) {
          return [[getsharedfunc("loadout", "table_getFlcExtraEquipmentSecondary")]](level.classtablename, self.class_num);
        }

        break;
    }
  }

  return 0;
}

function getequipmentmaxammo(ref, class) {
  tableinfo = getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    return undefined;
  }

  if(!isDefined(tableinfo.objweapon)) {
    return 0;
  }

  if(isDefined(level.commonitem)) {
    if(ref == "equip_armorplate") {
      return scripts\cp_mp\armor::function_47320a25b8ee003();
    }

    maxammo = weaponmaxammo(tableinfo.objweapon);
  } else if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    slot = findequipmentslot(ref);
    maxammo = undefined;

    if(isDefined(level.var_7ea1a9db4c78be14) && isDefined(slot) && (slot == "primary" || slot == "secondary")) {
      maxammo = self[[level.var_7ea1a9db4c78be14]](ref, slot);
    }

    if(!isDefined(maxammo)) {
      if(ref == "equip_armorplate") {
        return scripts\cp_mp\armor::function_47320a25b8ee003();
      }

      if(issharedfuncdefined("perk", "hasPerk")) {
        var_3002827bca3dc613 = self[[getsharedfunc("perk", "hasPerk")]]("specialty_extraoffhandammo");
      } else {
        var_3002827bca3dc613 = 0;
      }

      maxammo = weaponmaxammo(tableinfo.objweapon, var_3002827bca3dc613);

      switch (ref) {
        case #"hash_6d194c409057b2":
        case #"hash_48d3196b46b0ba61":
        case #"hash_4b4a6458f00d9319":
        case #"hash_8770d1da0d7395b9":
        case #"hash_aa60ec2aec479ec8":
          break;
        default:
          if(level.gametype != "missions" && level.gametype != "dungeons") {
            maxammo--;
          }

          break;
      }

      isprimary = isDefined(slot) && slot == "primary" || isequipmentlethal(ref);
      issecondary = isDefined(slot) && slot == "secondary" || isequipmenttactical(ref);

      if(issharedfuncdefined("perk", "hasPerk")) {
        if(self[[getsharedfunc("perk", "hasPerk")]]("specialty_extra_deadly") && isprimary) {
          if(self[[getsharedfunc("perk", "hasPerk")]]("specialty_ninja_vest")) {
            if(issubstr(ref, "throwing_knife") || issubstr(ref, "throwstar") || issubstr(ref, "shuriken")) {
              maxammo++;
            }
          } else {
            maxammo++;
          }
        }

        if(self[[getsharedfunc("perk", "hasPerk")]]("specialty_extra_tactical") && issecondary) {
          maxammo++;
        }
      }

      if(isDefined(class)) {
        classtype = undefined;

        if(issharedfuncdefined("loadout", "loadout_getClassType")) {
          classtype = [[getsharedfunc("loadout", "loadout_getClassType")]](class);
        }

        var_1bc3bf54ae8e6ed7 = function_11a4d197e8db4f(classtype);
        var_20327dd6b8d19acf = function_58ea099b568dbfaf(classtype);

        if(var_1bc3bf54ae8e6ed7 && isprimary) {
          maxammo++;
        }

        if(var_20327dd6b8d19acf && issecondary) {
          maxammo++;
        }
      }
    }
  } else {
    equipmentname = level.br_pickups.br_equipnametoscriptable[tableinfo.ref];
    assertex(isDefined(level.br_pickups.maxcounts[equipmentname]), "<dev string:x14b>" + equipmentname + "<dev string:x159>");
    maxammo = level.br_pickups.maxcounts[equipmentname];

    if(!isDefined(maxammo)) {
      maxammo = 0;
    }

    if(ref == "equip_armorplate") {
      if(issharedfuncdefined("equipment", "hasPlatePouch")) {
        if(self[[getsharedfunc("equipment", "hasPlatePouch")]]()) {
          maxammo += getdvarint(@ "hash_a5ab8ed6cc1b486a", 3);
        }
      }
    }
  }

  return maxammo;
}

function getequipmentstartammo(ref) {
  tableinfo = getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    return undefined;
  }

  if(!isDefined(tableinfo.objweapon)) {
    return 0;
  }

  if(issharedfuncdefined("perk", "hasPerk")) {
    var_3002827bca3dc613 = self[[getsharedfunc("perk", "hasPerk")]]("specialty_extraoffhandammo");
  } else {
    var_3002827bca3dc613 = 0;
  }

  return weaponstartammo(tableinfo.objweapon, var_3002827bca3dc613);
}

function getequipmentammo(ref) {
  tableinfo = getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    return undefined;
  }

  if(!isDefined(tableinfo.objweapon)) {
    return 0;
  }

  ammocount = self getammocount(tableinfo.objweapon);

  if(ammocount == 0 && isDefined(tableinfo.objweapon.basename)) {
    tableweaponname = tableinfo.objweapon.basename;

    if(isDefined(self) && isDefined(self.offhandinventory)) {
      foreach(weaponobj in self.offhandinventory) {
        if(isDefined(weaponobj) && isDefined(weaponobj.basename) && weaponobj.basename == tableweaponname) {
          ammocount = self getammocount(weaponobj);
        }
      }
    }
  }

  return ammocount;
}

function setequipmentammo(ref, amount) {
  tableinfo = getequipmenttableinfo(ref);

  if(!isDefined(tableinfo) || !isDefined(tableinfo.objweapon)) {
    return;
  }

  equipmentlist = self getweaponslistoffhands();

  foreach(equip in equipmentlist) {
    equipref = function_7f245729fcb6414d(equip.basename);

    if(isDefined(equipref) && equipref == ref) {
      variantid = undefined;
      weapon = undefined;

      if(isDefined(equip.variantid) && equip.variantid > 0) {
        variantid = equip.variantid;
        weapon = scripts\cp_mp\equipment::buildequipment(equip.basename, variantid);
      } else {
        weapon = tableinfo.objweapon;
      }

      self setweaponammoclip(weapon, amount);
      break;
    }
  }

  function_22bf78eca6578d7d(findequipmentslot(ref));
}

function function_1ab06e1478168800() {
  gaveprimary = 0;
  primary = getcurrentequipment("primary");

  if(isDefined(primary)) {
    gaveprimary = incrementequipmentammo(primary, getequipmentmaxammo(primary));
  }

  gavesecondary = 0;
  secondary = getcurrentequipment("secondary");

  if(isDefined(secondary)) {
    gavesecondary = incrementequipmentammo(secondary, getequipmentmaxammo(secondary));
  }

  return gaveprimary || gavesecondary;
}

function function_f1c136649b4207d6() {
  chargedprimary = 0;
  primary = getcurrentequipment("primary");

  if(isDefined(primary)) {
    chargedprimary = chargeequipment(primary);
  }

  chargedsecondary = 0;
  secondary = getcurrentequipment("secondary");

  if(isDefined(secondary)) {
    chargedsecondary = chargeequipment(secondary);
  }

  return chargedprimary || chargedsecondary;
}

function function_91bd2a98062313cb(slot, amount) {
  ref = getcurrentequipment(slot);
  tableinfo = getequipmenttableinfo(ref);

  if(!isDefined(tableinfo.objweapon)) {
    return;
  }

  self setweaponammoclip(tableinfo.objweapon, amount);
  function_22bf78eca6578d7d(findequipmentslot(ref));
}

function incrementequipmentammo(ref, var_930290d7f474a0ae, class) {
  if(!isDefined(var_930290d7f474a0ae)) {
    var_930290d7f474a0ae = 1;
  }

  currammo = getequipmentammo(ref);
  newammo = int(min(currammo + var_930290d7f474a0ae, getequipmentmaxammo(ref, class)));
  setequipmentammo(ref, newammo);
  return currammo != newammo;
}

function decrementequipmentammo(ref, var_7d2e0ea9107a4c02, class) {
  if(!isDefined(var_7d2e0ea9107a4c02)) {
    var_7d2e0ea9107a4c02 = 1;
  }

  currammo = getequipmentammo(ref);
  var_7d2e0ea9107a4c02 = int(min(var_7d2e0ea9107a4c02, currammo));

  if(var_7d2e0ea9107a4c02 > 0) {
    newammo = int(min(currammo - var_7d2e0ea9107a4c02, getequipmentmaxammo(ref, class)));
    setequipmentammo(ref, newammo);
  }
}

function incrementequipmentslotammo(slot, var_930290d7f474a0ae) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return undefined;
  }

  if(!isDefined(var_930290d7f474a0ae)) {
    var_930290d7f474a0ae = 1;
  }

  currammo = getequipmentammo(ref);
  newammo = int(min(currammo + var_930290d7f474a0ae, getequipmentmaxammo(ref)));
  setequipmentammo(ref, newammo);
}

function decrementequipmentslotammo(slot, var_7d2e0ea9107a4c02) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return undefined;
  }

  if(!isDefined(var_7d2e0ea9107a4c02)) {
    var_7d2e0ea9107a4c02 = 1;
  }

  currammo = getequipmentammo(ref);
  newammo = int(min(currammo - var_7d2e0ea9107a4c02, getequipmentmaxammo(ref)));
  setequipmentammo(ref, newammo);
}

function getequipmentslotammo(slot) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return undefined;
  }

  return getequipmentammo(ref);
}

function setequipmentslotammo(slot, count) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return undefined;
  }

  return setequipmentammo(ref, count);
}

function chargeequipment(ref) {
  switch (ref) {
    case #"hash_4b4a6458f00d9319":
      return scripts\cp_mp\equipment\hb_sensor::function_8803b12c07518865();
    default:
      return 0;
  }
}

function function_7f245729fcb6414d(weaponname) {
  if(!isDefined(weaponname)) {
    return undefined;
  }

  return level.var_415476758ec47760[weaponname];
}

function function_2113b6f7cb462692(weaponname) {
  if(!isDefined(weaponname)) {
    return undefined;
  }

  foreach(tableinfo in level.equipment.table) {
    if(isDefined(tableinfo.weaponname) && weaponname == tableinfo.weaponname) {
      return tableinfo.bundle;
    }
  }

  return undefined;
}

function mapequipmentweaponforref(objweapon) {
  weaponname = undefined;

  switch (objweapon.basename) {
    case #"hash_34f28162f0f54c6e":
    case #"hash_53d34fb712dd4235":
      weaponname = "throwingknife_mp";
      break;
    case #"hash_5701898d598fdb27":
      weaponname = "claymore_mp";
      break;
    case #"hash_1608b7d163aaf95f":
      weaponname = "jup_claymore_ob";
      break;
    case #"hash_cce14c95e4764532":
      weaponname = "at_mine_mp";
      break;
    case #"hash_8fd6158eb96a1f15":
    case #"hash_b2a8e1829f433bd7":
      weaponname = "thermite_mp";
      break;
    case #"hash_6547ec525f1340da":
    case #"hash_a009d256608f52ce":
    case #"hash_c4b9b21ecac2ced4":
      weaponname = "bunkerbuster_mp";
      break;
    case #"hash_9286c53dccee4e99":
    case #"hash_a50980582cd5f387":
    case #"hash_adcbea12d23c5553":
      weaponname = "jup_bunkerbuster_br";
      break;
    case #"hash_9276d33dcce198b0":
    case #"hash_a51366582cde195e":
    case #"hash_adeee012d2581c12":
      weaponname = "jup_bunkerbuster_ob";
      break;
    case #"hash_5e5b9bb1e397e30a":
      weaponname = "shock_stick_mp";
      break;
    case #"hash_fd386aff9acf671":
      weaponname = "butterfly_mine_mp";
      break;
    case #"hash_aee3b09360147621":
      weaponname = "tracker_grenade_mp";
      break;
  }

  if(isDefined(weaponname)) {
    return scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(weaponname);
  }

  return objweapon;
}

function getequipmentreffromweapon(objweapon) {
  objweapon = mapequipmentweaponforref(objweapon);
  return level.var_415476758ec47760[objweapon.basename];
}

function getweaponfromequipmentref(equipref) {
  equip = level.equipment.table[equipref];

  if(isDefined(equip)) {
    return equip.objweapon;
  }

  return undefined;
}

function hasequipment(ref) {
  if(!isDefined(self.equipment)) {
    if(iscp() && isDefined(self.powers)) {
      foreach(key, value in self.powers) {
        if(key == ref) {
          return true;
        }
      }
    }

    return false;
  }

  foreach(equippedref in self.equipment) {
    if(equippedref == ref) {
      return true;
    }
  }

  return false;
}

function findequipmentslot(ref) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  foreach(slot, equippedref in self.equipment) {
    if(equippedref == ref) {
      return slot;
    }
  }
}

function isequipmentlethal(ref) {
  return isequipmentprimary(ref);
}

function isequipmentprimary(ref) {
  if(isDefined(ref) && isDefined(level.equipment.table[ref])) {
    return (level.equipment.table[ref].defaultslot == "primary");
  }

  return 0;
}

function isequipmenttactical(ref) {
  return isequipmentsecondary(ref);
}

function isequipmentsecondary(ref) {
  if(isDefined(ref) && isDefined(level.equipment.table[ref])) {
    return (level.equipment.table[ref].defaultslot == "secondary");
  }

  return 0;
}

function isequipmentselectable(ref) {
  if(!isDefined(ref)) {
    return 0;
  }

  if(isDefined(level.equipment.table[ref])) {
    return istrue(level.equipment.table[ref].isselectable);
  }

  return 0;
}

function function_22bf78eca6578d7d(slot, class) {
  if(!isDefined(self.equipment) || self.equipment.size == 0) {
    return;
  }

  ammo = 0;
  maxammo = 0;
  ref = getcurrentequipment(slot);

  if(isDefined(ref)) {
    ammo = getequipmentslotammo(slot);
    maxammo = getequipmentmaxammo(ref, class);
  }

  if(slot == "primary") {
    self setclientomnvar("ui_power_num_charges", ammo);
    self setpowerammo("primary", ammo, maxammo);
    return;
  }

  if(slot == "secondary") {
    self setclientomnvar("ui_power_secondary_num_charges", ammo);
    self setpowerammo("secondary", ammo, maxammo);
    return;
  }

  if(slot == "health") {
    if(isDefined(self.pers["telemetry"].armor_collected)) {
      self.pers["telemetry"].armor_collected++;
    }

    self setclientomnvar("ui_equipment_id_health_numCharges", ammo, maxammo);
  }
}

function equiponplayerspawned() {
  thread watchoffhandfired();
}

function resetequipment() {
  self.equipment = [];
}

function executeoffhandfired(objweapon) {
  foreach(slot, ref in self.equipment) {
    tableinfo = getequipmenttableinfo(ref);

    if(isDefined(tableinfo.objweapon) && objweapon == tableinfo.objweapon) {
      if(issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]()) {
        if(issharedfuncdefined("dlog", "brAnalytics_equipmentUse")) {
          item_type = "";

          if(isDefined(tableinfo.bundle) && isDefined(tableinfo.bundle.equipmenttype)) {
            item_type = tableinfo.bundle.equipmenttype;
          }

          [[getsharedfunc("dlog", "brAnalytics_equipmentUse")]](self, objweapon, item_type);
        }
      }

      if(issharedfuncdefined("equipment", "getEquipmentRefFromWeapon")) {
        weaponref = [[getsharedfunc("equipment", "getEquipmentRefFromWeapon")]](objweapon);

        if(issharedfuncdefined("damage", "combatRecordEquipmentUsed")) {
          self[[getsharedfunc("damage", "combatRecordEquipmentUsed")]](weaponref);
        }
      }

      onfiredcallback = getcallback(ref, "onFired");

      if(isDefined(onfiredcallback)) {
        self thread[[onfiredcallback]](ref, slot, objweapon);
      }

      ammo = 0;
      ref = getcurrentequipment(slot);

      if(isDefined(ref)) {
        ammo = getequipmentslotammo(slot);
      }

      if(ammo == 0 && isDefined(level.var_87a4731d4dce4c3f)) {
        success = self[[level.var_87a4731d4dce4c3f]](self, slot, ref);

        if(istrue(success)) {
          break;
        }
      }

      function_22bf78eca6578d7d(slot);
      break;
    }
  }
}

function watchoffhandfired() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("offhand_fired", objweapon);
    executeoffhandfired(objweapon);
  }
}

function givescavengerammo() {
  foreach(ref in self.equipment) {
    tableinfo = getequipmenttableinfo(ref);

    if(tableinfo.scavengerammo > 0) {
      incrementequipmentammo(ref, tableinfo.scavengerammo);
    }
  }
}

function getdefaultslot(ref) {
  tableinfo = getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    return undefined;
  }

  return tableinfo.defaultslot;
}

function watchlethaldelay() {
  level endon("lethal_delay_end");
  level endon("round_end");
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  currentgametypestopsclock = currentgametypestopsclock();

  if(currentgametypestopsclock) {
    level.lethaldelaystarttime = gettime();
  } else if(issharedfuncdefined("game", "getTimePassed")) {
    level.lethaldelaystarttime = [[getsharedfunc("game", "getTimePassed")]]();
  }

  if(level.lethaldelay == 0) {
    level.lethaldelayendtime = level.lethaldelaystarttime;
    level notify("lethal_delay_end");
  }

  level.lethaldelayendtime = level.lethaldelaystarttime + level.lethaldelay * 1000;
  level notify("lethal_delay_start");

  while(true) {
    currenttime = undefined;

    if(currentgametypestopsclock) {
      currenttime = gettime();
    } else if(issharedfuncdefined("game", "getTimePassed")) {
      currenttime = [[getsharedfunc("game", "getTimePassed")]]();
    }

    if(currenttime >= level.lethaldelayendtime) {
      break;
    }

    waitframe();
  }

  level notify("lethal_delay_end");
}

function watchlethaldelayplayer(equipmentref, slot) {
  self endon("death_or_disconnect");
  level endon("round_end");
  level endon("game_ended");

  if(lethaldelaypassed()) {
    return;
  }

  self notify("watchLethalDelayPlayer_" + slot);
  self endon("watchLethalDelayPlayer_" + slot);
  self endon("equipment_taken_" + equipmentref);

  if(!isDefined(self.lethaldelayallows) || !istrue(self.lethaldelayallows[slot])) {
    if(!isDefined(self.lethaldelayallows)) {
      self.lethaldelayallows = [];
    }

    self.lethaldelayallows[slot] = 1;

    if(slot == "primary ") {
      val::set("watchLethalDelayPlayer", "equipment_primary", 0);
    } else {
      val::set("watchLethalDelayPlayer", "equipment_secondary", 0);
    }
  }

  watchlethaldelayfeedbackplayer(self, slot);

  if(isDefined(self.lethaldelayallows) && istrue(self.lethaldelayallows[slot])) {
    self.lethaldelayallows[slot] = undefined;

    if(self.lethaldelayallows.size == 0) {
      self.lethaldelayallows = undefined;
    }

    val::reset_all("watchLethalDelayPlayer");
  }
}

function watchlethaldelayfeedbackplayer(player, slot) {
  level endon("lethal_delay_end");

  if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    level waittill("lethal_delay_start");
  }

  command = "+frag";

  if(slot != "primary") {
    command = "+smoke";
  }

  if(!isai(player)) {
    player notifyonplayercommand("lethal_attempt_" + slot, command);
  }

  currentgametypestopsclock = currentgametypestopsclock();

  while(true) {
    self waittill("lethal_attempt_" + slot);
    currenttime = undefined;

    if(currentgametypestopsclock) {
      currenttime = gettime();
    } else if(issharedfuncdefined("game", "getTimePassed")) {
      currenttime = [[getsharedfunc("game", "getTimePassed")]]();
    }

    n = (level.lethaldelayendtime - currenttime) / 1000;
    n = int(max(0, ceil(n)));

    if(issharedfuncdefined("hud", "showErrorMessage")) {
      player[[getsharedfunc("hud", "showErrorMessage")]]("MP/LETHALS_UNAVAILABLE_FOR_N", n);
    }
  }
}

function cancellethaldelay() {
  level.lethaldelay = 0;

  if(currentgametypestopsclock()) {
    level.lethaldelaystarttime = gettime();
  } else if(issharedfuncdefined("game", "getTimePassed")) {
    level.lethaldelaystarttime = [[getsharedfunc("game", "getTimePassed")]]();
  }

  level.lethaldelayendtime = level.lethaldelaystarttime;
  level notify("lethal_delay_end");
}

function lethaldelaypassed() {
  if(isDefined(level.lethaldelay) && level.lethaldelay == 0) {
    return true;
  }

  if(isDefined(level.lethaldelayendtime)) {
    currenttime = undefined;

    if(currentgametypestopsclock()) {
      currenttime = gettime();
    } else if(issharedfuncdefined("game", "getTimePassed")) {
      currenttime = [[getsharedfunc("game", "getTimePassed")]]();
    }

    return (currenttime > level.lethaldelayendtime);
  }

  return false;
}

function currentgametypestopsclock() {
  if(issharedfuncdefined("game", "getGameType")) {
    gametype = [[getsharedfunc("game", "getGameType")]]();

    if(gametype == "hq" || gametype == "grnd" || gametype == "koth") {
      return true;
    }
  }

  return false;
}

function onownerdisconnect(player) {
  if(issharedfuncdefined("equipment", "getAllEquip")) {
    allequip = player[[getsharedfunc("equipment", "getAllEquip")]]();

    foreach(equip in allequip) {
      equip notify("owner_disconnect");
    }
  }
}

function hackequipment(hacker) {
  self.ishacked = 1;
  newowner = hacker;

  if(isDefined(hacker.owner) && hacker.equipmentref == "equip_capture_bot") {
    newowner = hacker.owner;
  }

  if(issharedfuncdefined("game", "setHasDoneCombat")) {
    newowner[[getsharedfunc("game", "setHasDoneCombat")]](newowner, 1);
  }

  hacker scripts\cp_mp\challenges::onhack(self.equipmentref);
  changeowner(newowner);

  if(level.teambased) {
    self filteroutplayermarks(newowner.team);
  } else {
    self filteroutplayermarks(newowner);
  }

  if(issharedfuncdefined("killstreak", "giveScoreForHack")) {
    newowner[[getsharedfunc("killstreak", "giveScoreForHack")]]();
  }
}

function function_24fce6c89fd2bee3(capturebot) {
  if(isDefined(capturebot)) {
    if(!isDefined(self.var_134d6db4538498ee)) {
      self.var_134d6db4538498ee = [];
    }

    self.var_134d6db4538498ee[self.var_134d6db4538498ee.size] = capturebot;
  }
}

function function_f5cbee8dfc1dc4f0(var_2c6dc87bb9f89da0) {
  if(isDefined(self.var_134d6db4538498ee)) {
    foreach(oldbot in self.var_134d6db4538498ee) {
      if(isDefined(var_2c6dc87bb9f89da0) && oldbot == var_2c6dc87bb9f89da0) {
        return false;
      }
    }
  }

  return true;
}

function changeowner(newowner) {
  oldowner = self.owner;

  if(!is_equal(self.turrettype, "sentry_turret")) {
    self setentityowner(newowner);
  }

  self.owner = newowner;
  self.team = newowner.team;
  self setotherent(newowner);

  if(issharedfuncdefined("equipment", "removeEquip")) {
    oldowner[[getsharedfunc("equipment", "removeEquip")]](self);
  }

  if(issharedfuncdefined("equipment", "updatePlantedArray")) {
    self.owner[[getsharedfunc("equipment", "updatePlantedArray")]](self);
  }

  onownerchanged = undefined;

  if(isDefined(self.equipmentref)) {
    onownerchanged = getcallback(self.equipmentref, "onOwnerChanged");
  }

  self notify("ownerChanged");

  if(isDefined(onownerchanged)) {
    self[[onownerchanged]](oldowner);
  }
}

function debughackequipment() {
  setdevdvar(@ "hash_aa4a28e418803dd5", 0);

  while(true) {
    if(getdvarint(@ "hash_aa4a28e418803dd5") != 0) {
      setdevdvar(@ "hash_aa4a28e418803dd5", 0);
      mainplayer = level.players[0];
      enemyplayer = undefined;

      for(i = 1; i < level.players.size; i++) {
        if(issharedfuncdefined("<dev string:x1c7>", "<dev string:x1d1>") && mainplayer[[getsharedfunc("<dev string:x1c7>", "<dev string:x1d1>")]](level.players[i])) {
          enemyplayer = level.players[i];
          break;
        }
      }

      if(!isDefined(enemyplayer)) {
        iprintlnbold("<dev string:x1dc>");
        continue;
      }

      if(issharedfuncdefined("<dev string:x219>", "<dev string:x226>")) {
        allequip = mainplayer[[getsharedfunc("<dev string:x219>", "<dev string:x226>")]]();
        equipment = undefined;

        if(allequip.size > 0) {
          equipment = allequip[0];
        }

        if(!isDefined(equipment)) {
          iprintlnbold("<dev string:x235>");
          continue;
        }

        equipment hackequipment(enemyplayer);
      }
    }

    waitframe();
  }
}

function debugemp() {
  setdevdvar(@ "hash_d39ba2fefaffd043", 0);

  while(true) {
    if(getdvarint(@ "hash_d39ba2fefaffd043") != 0) {
      setdevdvar(@ "hash_d39ba2fefaffd043", 0);

      if(level.players.size < 2) {
        iprintlnbold("<dev string:x289>");
        continue;
      }

      secondplayer = level.players[1];

      if(issharedfuncdefined("<dev string:x2bc>", "<dev string:x2c7>")) {
        secondplayer[[getsharedfunc("<dev string:x2bc>", "<dev string:x2c7>")]]("<dev string:x2d9>", (0, 0, 0), (0, 0, 0), 0.05, 0);
      }
    }

    waitframe();
  }
}

function debugempdrone() {
  setdevdvar(@ "hash_a6ef3bcfa25b1aef", 0);

  while(true) {
    if(getdvarint(@ "hash_a6ef3bcfa25b1aef") != 0) {
      setdevdvar(@ "hash_a6ef3bcfa25b1aef", 0);

      if(level.players.size < 2) {
        iprintlnbold("<dev string:x2eb>");
        continue;
      }

      firstplayer = level.players[0];
      secondplayer = level.players[1];
      streakinfo = spawnStruct();
      streakinfo.streakname = "<dev string:x31c>";
      streakinfo.owner = secondplayer;
      streakinfo.id = scripts\cp_mp\utility\killstreak_utility::getuniquekillstreakid(secondplayer);
      streakinfo.lifeid = 0;
      targetpos = firstplayer.origin;
      drone = secondplayer scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_createdrone(streakinfo, targetpos);
    }

    waitframe();
  }
}

function debugdestroyempdrones() {
  setdevdvar(@ "hash_196b4febb9f4dd1f", 0);

  while(true) {
    if(getdvarint(@ "hash_196b4febb9f4dd1f") != 0) {
      setdevdvar(@ "hash_196b4febb9f4dd1f", 0);

      foreach(killstreak in level.activekillstreaks) {
        if(isDefined(killstreak.streakinfo) && killstreak.streakinfo.streakname == "<dev string:x31c>") {
          killstreak scripts\cp_mp\killstreaks\emp_drone::empdrone_destroy();
        }
      }
    }

    waitframe();
  }
}

function initlethalmaxoffsetmap() {
  level.lethal_equipmentmaskoffsets = [];
  bitindex = 0;

  foreach(equipment in level.equipment.table) {
    if(!equipment.isselectable) {
      continue;
    }

    if(equipment.id <= 0) {
      continue;
    }

    if(equipment.defaultslot == "secondary") {
      continue;
    }

    level.lethal_equipmentmaskoffsets[equipment.ref] = 1 << bitindex;
    bitindex++;
  }
}

function function_707926e6ce8ddc60(slot, var_317d7e8b927bd393) {
  if(slot == "primary") {
    primary_gren = getcurrentequipment(slot);
    tableinfo = getequipmenttableinfo(primary_gren);

    if(!isDefined(tableinfo)) {
      primary_gren = "equip_frag";
    }

    thread giveequipment(primary_gren, "primary");
    setequipmentammo(primary_gren, var_317d7e8b927bd393);
    return;
  }

  if(slot == "secondary") {
    secondary_gren = getcurrentequipment(slot);
    tableinfo = getequipmenttableinfo(secondary_gren);

    if(!isDefined(tableinfo)) {
      secondary_gren = "equip_flash";
    }

    thread giveequipment(secondary_gren, "secondary");
    setequipmentammo(secondary_gren, var_317d7e8b927bd393);
  }
}
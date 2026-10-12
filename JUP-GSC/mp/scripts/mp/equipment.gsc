/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment.gsc
***********************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\geiger_counter;
#using scripts\cp_mp\equipment\hb_sensor;
#using scripts\cp_mp\equipment\thermal_phone;
#using scripts\cp_mp\equipment\thermobaric_grenade;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\equipment\throwstar;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\killstreaks\emp_drone;
#using scripts\cp_mp\killstreaks\emp_drone_targeted;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\adrenaline;
#using scripts\mp\equipment\at_mine;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\equipment\binoculars;
#using scripts\mp\equipment\bunkerbuster;
#using scripts\mp\equipment\butterfly_mine;
#using scripts\mp\equipment\c4;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment\combataxe;
#using scripts\mp\equipment\concussion_grenade;
#using scripts\mp\equipment\decoy_grenade;
#using scripts\mp\equipment\deployed_decoy;
#using scripts\mp\equipment\flash_grenade;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\iodine_pills;
#using scripts\mp\equipment\molotov;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\equipment\snapshot_grenade;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\equipment\thermite;
#using scripts\mp\equipment\trophy_system;
#using scripts\mp\equipment\weapon_drop;
#using scripts\mp\equipment_interact;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\perks\headgear;
#using scripts\mp\supers;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace equipment;

function init() {
  if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.equipment_list)) {
    level.equipmenttable = "equipmentlist:" + level.gamemodebundle.equipment_list;
  } else if(getdvarint(@ "t10", 0) > 0) {
    level.equipmenttable = "equipmentlist:equipment_list_t10_mp";

    utility::scriptbundlewarning("<dev string:x1c>", level.equipmenttable);
  } else if(getdvarint(@ "mgl", 0) > 0) {
    level.equipmenttable = "equipmentlist:equipment_list_mgl_mp";

    utility::scriptbundlewarning("<dev string:x1c>", level.equipmenttable);
  } else {
    level.equipmenttable = "equipmentlist:equipment_list_iw9_mp";

    utility::scriptbundlewarning("<dev string:x1c>", level.equipmenttable);
  }

  level.equipment = spawnStruct();
  level.equipment.table = [];
  inititems();
  loadequipmentbundles(level.equipmenttable);
  initlethalmaxoffsetmap();
  function_f8d145900d997580();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&equiponplayerspawned);
  level notify("mp_equipment_init");
}

function inititems() {
  level.equipment.callbacks = [];

  if(getdvarint(@ "hash_742caa13b3c2e685")) {
    return;
  }

  globals = level.equipment;
  scripts\mp\equipment_interact::equipmentinteract_init();

  if(!istrue(game["isLaunchChunk"])) {
    scripts\mp\perks\headgear::init();
    scripts\mp\equipment\tactical_cover::tac_cover_init();
    scripts\mp\equipment\trophy_system::trophy_init();
    scripts\mp\equipment\decoy_grenade::decoy_init();
    scripts\mp\equipment\at_mine::at_mine_init();
    scripts\mp\equipment\tac_insert::tacinsert_init();
  }

  scripts\cp_mp\equipment\geiger_counter::function_58bf160252f94e21();
  scripts\mp\equipment\claymore::claymore_init();
  scripts\mp\equipment\molotov::molotov_init();
  scripts\mp\equipment\weapon_drop::weapondrop_init();
  scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  scripts\cp_mp\equipment\throwstar::function_12d7ca3ff609caba();
  scripts\mp\equipment\deployed_decoy::function_35f02578b0c90838();
  scripts\mp\equipment\iodine_pills::function_80b2d6867c192094();
  scripts\cp_mp\equipment\thermal_phone::function_7c59b9d44aff939b();
  scripts\mp\equipment\combataxe::function_d80165ad0154bb7e();

  if(issharedfuncdefined("equip_butterfly_mine", "init")) {
    callsharedfunc("equip_butterfly_mine", "init");
  }

  globals.callbacks["equip_helmet"]["onGive"] = &scripts\mp\perks\headgear::runheadgear;
  globals.callbacks["equip_helmet"]["onTake"] = &scripts\mp\perks\headgear::removeheadgear;
  globals.callbacks["equip_adrenaline"]["onFired"] = &scripts\mp\equipment\adrenaline::onequipmentfired;
  globals.callbacks["equip_adrenaline"]["onTake"] = &scripts\mp\equipment\adrenaline::onequipmenttaken;
  globals.callbacks["equip_c4"]["onGive"] = &scripts\mp\equipment\c4::c4_set;
  globals.callbacks["equip_trophy"]["onGive"] = &scripts\mp\equipment\trophy_system::trophy_set;
  globals.callbacks["equip_trophy"]["onTake"] = &scripts\mp\equipment\trophy_system::trophy_unset;
  globals.callbacks["equip_throwing_knife"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  globals.callbacks["equip_throwing_knife"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  globals.callbacks["equip_throwing_knife"]["onIncrement"] = &scripts\cp_mp\equipment\throwing_knife::function_d763df6d36a1e34a;
  globals.callbacks["equip_throwing_knife_fire"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  globals.callbacks["equip_throwing_knife_fire"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  globals.callbacks["equip_throwing_knife_electric"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  globals.callbacks["equip_throwing_knife_electric"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  globals.callbacks["equip_throwstar"]["onGive"] = &scripts\cp_mp\equipment\throwstar::function_e7715ffb329c1b40;
  globals.callbacks["equip_throwstar"]["onTake"] = &scripts\cp_mp\equipment\throwstar::function_92e126d1a5d3fb2;
  globals.callbacks["equip_molotov"]["onGive"] = &scripts\mp\equipment\molotov::molotov_on_give;
  globals.callbacks["equip_molotov"]["onTake"] = &scripts\mp\equipment\molotov::molotov_on_take;
  globals.callbacks["equip_tac_cover"]["onGive"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_give;
  globals.callbacks["equip_tac_cover"]["onTake"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_take;
  globals.callbacks["equip_tac_cover"]["onFired"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_fired;
  globals.callbacks["equip_tac_insert"]["onGive"] = &scripts\mp\equipment\tac_insert::tacinsert_set;
  globals.callbacks["equip_tac_insert"]["onTake"] = &scripts\mp\equipment\tac_insert::tacinsert_unset;
  globals.callbacks["equip_binoculars"]["onGive"] = &scripts\mp\equipment\binoculars::binoculars_ongive;
  globals.callbacks["equip_binoculars"]["onTake"] = &scripts\mp\equipment\binoculars::binoculars_ontake;
  globals.callbacks["equip_iodine_pills"]["onGive"] = &scripts\mp\equipment\iodine_pills::function_43fe8ccc8b4e6146;
  globals.callbacks["equip_iodine_pills"]["onTake"] = &scripts\mp\equipment\iodine_pills::function_d41fe283435e26c4;
  globals.callbacks["equip_geigercounter"]["onGive"] = &scripts\cp_mp\equipment\geiger_counter::function_60cba38635fd35cb;
  globals.callbacks["equip_geigercounter"]["onTake"] = &scripts\cp_mp\equipment\geiger_counter::function_bdd02627bcafe359;

  if(issharedfuncdefined("equip_aethercounter", "onGive") && issharedfuncdefined("equip_aethercounter", "onTake")) {
    globals.callbacks["equip_aethercounter"]["onGive"] = getsharedfunc("equip_aethercounter", "onGive");
    globals.callbacks["equip_aethercounter"]["onTake"] = getsharedfunc("equip_aethercounter", "onTake");
  }

  globals.callbacks["equip_hb_sensor"]["onIncrement"] = &scripts\cp_mp\equipment\hb_sensor::function_3efd622905908041;
  globals.callbacks["equip_thermal_phone"]["onGive"] = &scripts\cp_mp\equipment\thermal_phone::function_d7b50d4592cd5421;
  globals.callbacks["equip_thermal_phone"]["onTake"] = &scripts\cp_mp\equipment\thermal_phone::function_e49fa2736f79e04b;
  globals.callbacks["equip_battlerage"]["onFired"] = &scripts\mp\equipment\battlerage::function_d04e75b8e793111f;
  globals.callbacks["equip_battlerage"]["onTake"] = &scripts\mp\equipment\battlerage::function_bd68ba32d66dde65;
  globals.callbacks["equip_armor_onehanded"]["onFired"] = &scripts\cp_mp\armor::function_df0c4be0709e8116;
  globals.callbacks["equip_armor_onehanded"]["onTake"] = &scripts\cp_mp\armor::function_dd4193b50e36fb2c;
  globals.callbacks["equip_flash"]["onFired"] = &scripts\mp\equipment\flash_grenade::onfired;
  globals.callbacks["equip_concussion"]["onFired"] = &scripts\mp\equipment\concussion_grenade::onfired;
  globals.callbacks["equip_gas_grenade"]["onPlayerDamaged"] = &scripts\mp\equipment\gas_grenade::gas_onplayerdamaged;
  globals.callbacks["equip_flash"]["onPlayerDamaged"] = &scripts\mp\equipment\flash_grenade::onplayerdamaged;
  globals.callbacks["equip_concussion"]["onPlayerDamaged"] = &scripts\mp\equipment\concussion_grenade::onplayerdamaged;
  globals.callbacks["equip_thermite"]["onPlayerDamaged"] = &scripts\mp\equipment\thermite::thermite_onplayerdamaged;
  globals.callbacks["equip_molotov"]["onPlayerDamaged"] = &scripts\mp\equipment\molotov::molotov_on_player_damaged;
  globals.callbacks["equip_shockstick"]["onPlayerDamaged"] = &scripts\mp\equipment\shock_stick::function_ca6c37e5d8f35c8b;
  globals.callbacks["equip_bunkerbuster"]["onPlayerDamaged"] = &scripts\mp\equipment\bunkerbuster::function_66629d921c921905;
  globals.callbacks["equip_thermobaric_grenade"]["onPlayerDamaged"] = &scripts\cp_mp\equipment\thermobaric_grenade::onplayerdamaged;
  globals.callbacks["equip_at_mine"]["onOwnerChanged"] = &scripts\mp\equipment\at_mine::at_mine_onownerchanged;
  globals.callbacks["equip_claymore"]["onOwnerChanged"] = &scripts\mp\equipment\claymore::claymore_onownerchanged;
  globals.callbacks["equip_c4"]["onOwnerChanged"] = &scripts\mp\equipment\c4::c4_onownerchanged;
  globals.callbacks["equip_butterfly_mine"]["onOwnerChanged"] = &scripts\mp\equipment\butterfly_mine::function_e1d976fb5e329d97;
  globals.callbacks["equip_trophy"]["onOwnerChanged"] = &scripts\mp\equipment\trophy_system::function_d70f6fa2c37c1230;

  if(issharedfuncdefined("equip_tracker_mine", "tracker_mine_onOwnerChanged")) {
    globals.callbacks["equiup_tracker_mine"]["onOwnerChanged"] = getsharedfunc("equip_tracker_mine", "tracker_mine_onOwnerChanged");
  }

  globals.callbacks["equip_at_mine"]["onDestroyedByTrophy"] = &scripts\mp\equipment\at_mine::at_mine_delete;
  globals.callbacks["equip_claymore"]["onDestroyedByTrophy"] = &scripts\mp\equipment\claymore::claymore_delete;
  globals.callbacks["equip_trophy"]["onDestroyedByTrophy"] = &scripts\mp\equipment\trophy_system::trophy_delete;
  globals.callbacks["equip_c4"]["onDestroyedByTrophy"] = &scripts\mp\equipment\c4::c4_delete;
  globals.callbacks["equip_snapshot_grenade"]["onDestroyedByTrophy"] = &scripts\mp\equipment\snapshot_grenade::snapshot_grenade_delete;
  globals.callbacks["equip_deployed_decoy"]["onDestroyedByTrophy"] = &scripts\mp\equipment\deployed_decoy::function_ec4ed8b35f49093;
  globals.callbacks["cluster_spike"]["onDestroyedByTrophy"] = &scripts\cp_mp\killstreaks\cluster_spike::function_b89726dbbc1c74f6;
  globals.callbacks["cluster_spike_proj"]["onDestroyedByTrophy"] = &scripts\cp_mp\killstreaks\cluster_spike::function_b89726dbbc1c74f6;
  thread watchlethaldelay();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onownerdisconnect);

  thread debughackequipment();
  thread debugemp();
  thread debugempdrone();
  thread debugdestroyempdrones();
}

function private function_f8d145900d997580() {
  scripts\mp\equipment\adrenaline::function_22fd49689920fdb1();

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

function loadequipmentbundles(equipmenttable) {
  level.equipmentblueprints = [];
  level.var_415476758ec47760 = [];
  var_9df9fe298aef6003 = getscriptbundle(equipmenttable);

  for(i = 0; i < var_9df9fe298aef6003.equipment_list.size; i++) {
    equipmentref = var_9df9fe298aef6003.equipment_list[i].ref;
    equipmentbundlename = var_9df9fe298aef6003.equipment_list[i].bundle;

    if(isDefined(equipmentbundlename)) {
      equipmentbundle = getscriptbundle("equipment:" + equipmentbundlename);

      if(isDefined(equipmentbundle)) {
        struct = spawnStruct();
        struct.ref = equipmentref;
        weaponname = equipmentbundle.useweapon;
        assertex(isDefined(weaponname), equipmenttable + "<dev string:x43>" + equipmentref + "<dev string:x52>");

        if(weaponname != "none") {
          struct.objweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(weaponname);
          blueprints = getweaponblueprintnames(weaponname);

          foreach(blueprint, id in blueprints) {
            svariantid = weaponname + "|" + string(id);
            level.equipmentblueprints[svariantid] = function_3211981142ec5aee(weaponname, blueprint);
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

function getequipmenttableinfo(ref) {
  if(!isDefined(ref)) {
    return undefined;
  }

  return level.equipment.table[ref];
}

function giveequipment(ref, slot, class, variantid) {
  assert(isDefined(ref));
  assert(isDefined(slot));

  if(!isDefined(self.equipment)) {
    self.equipment = [];
  }

  if(!isDefined(ref) || ref == "none") {
    return;
  }

  tableinfo = getequipmenttableinfo(ref);
  assertex(isDefined(tableinfo), "<dev string:x65>" + ref + "<dev string:x91>");

  if(!isDefined(tableinfo)) {
    return;
  }

  takeequipment(slot);
  weapon = undefined;

  if(!isDefined(variantid) && isDefined(self.var_a6dd5c7e74106ce3) && isDefined(self.var_a6dd5c7e74106ce3[ref])) {
    variantid = self.var_a6dd5c7e74106ce3[ref];
  }

  if(isDefined(variantid) && variantid > 0) {
    weapon = scripts\cp_mp\equipment::buildequipment(tableinfo.weaponname, variantid);
  } else {
    weapon = tableinfo.objweapon;
  }

  if(isDefined(weapon)) {
    self giveweapon(weapon);
    var_afdcb24f5375ac21 = is_equipment_slot_allowed(slot) || istrue(level.var_aefa27a676322b3f) && !scripts\mp\flags::gameflag("prematch_done");

    if(var_afdcb24f5375ac21 && !tableinfo.ispassive) {
      if(slot == "primary") {
        self assignweaponoffhandprimary(weapon);
      } else if(slot == "secondary") {
        self assignweaponoffhandsecondary(weapon);
      } else if(slot == "super") {
        self assignweaponoffhandspecial(weapon);
      }
    }
  }

  sethudslot(slot, tableinfo.id);
  self.equipment[slot] = ref;
  var_645972186625daee = getcallback(ref, "onGive");

  if(isDefined(var_645972186625daee)) {
    self thread[[var_645972186625daee]](ref, slot, variantid);
  }

  function_22bf78eca6578d7d(slot, class);
  isthrowing = ref == "equip_throwing_knife" || ref == "equip_throwing_knife_fire" || ref == "equip_throwing_knife_electric" || ref == "equip_shuriken";

  if(scripts\engine\utility::issharedfuncdefined("game", "getGameType") && [[scripts\engine\utility::getsharedfunc("game", "getGameType")]]() == "arena" && isthrowing) {} else {
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

  if(isDefined(tableinfo) && isDefined(tableinfo.objweapon)) {
    var_d3ebb1f5dda2d6e0 = undefined;

    if(getdvarint(@ "hash_22541071c575fe17", 1)) {
      equipmentlist = self getweaponslistoffhands();

      foreach(equip in equipmentlist) {
        equipref = function_7f245729fcb6414d(equip.basename);

        if(isDefined(equipref) && equipref == ref) {
          if(isDefined(equip.variantid) && equip.variantid > 0) {
            var_d3ebb1f5dda2d6e0 = scripts\cp_mp\equipment::buildequipment(equip.basename, equip.variantid);
          } else {
            var_d3ebb1f5dda2d6e0 = tableinfo.objweapon;
          }

          break;
        }
      }
    } else {
      var_d3ebb1f5dda2d6e0 = tableinfo.objweapon;
    }

    if(isDefined(var_d3ebb1f5dda2d6e0) && self hasweapon(var_d3ebb1f5dda2d6e0)) {
      _takeweapon(var_d3ebb1f5dda2d6e0);

      if(slot == "primary") {
        self clearoffhandprimary();
      } else if(slot == "secondary") {
        self clearoffhandsecondary();
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
          assertex(gettime() == callbackstarttime, "<dev string:x96>" + ref + "<dev string:xb6>");
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
    } else if(scripts\mp\weapons::isplantedequipment(self)) {
      thread scripts\mp\weapons::deleteexplosive();
      return true;
    }
  }

  return false;
}

function function_4967838290cb31b9(index) {
  switch (index) {
    case 0:
      return "primary";
    case 1:
      return "secondary";
    case 2:
      return "health";
    default:
      assert(0, "<dev string:xcd>" + index);
      break;
  }
}

function disableslotinternal(slot) {
  if(slot == "primary") {
    self clearoffhandprimary();
    return;
  }

  if(slot == "secondary") {
    self clearoffhandsecondary();
    return;
  }

  if(slot == "super") {
    self clearoffhandspecial();
  }
}

function enableslotinternal(slot) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return;
  }

  tableinfo = getequipmenttableinfo(ref);

  if(isDefined(tableinfo) && isDefined(tableinfo.objweapon) && !tableinfo.ispassive) {
    if(slot == "primary") {
      self assignweaponoffhandprimary(tableinfo.objweapon);
      return;
    }

    if(slot == "secondary") {
      self assignweaponoffhandsecondary(tableinfo.objweapon);
      return;
    }

    if(slot == "super") {
      self assignweaponoffhandspecial(tableinfo.objweapon);
    }
  }
}

function is_equipment_slot_allowed(slot) {
  switch (slot) {
    case #"hash_325cb2e66f67d5b9":
      return val::get("equipment_primary");
    case #"hash_511d3c24fcedcdb1":
      return val::get("equipment_secondary");
    default:
      return (val::get("equipment_primary") && val::get("equipment_secondary"));
  }
}

function sethudslot(slot, id) {
  if(slot != "super") {
    self setclientomnvar("ui_equipment_id_" + slot, id);
  }
}

function getcurrentequipment(slot) {
  if(!(isDefined(self.equipment) && isDefined(slot))) {
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
    if(ref == "equip_armorplate") {
      return scripts\cp_mp\armor::function_47320a25b8ee003();
    }

    var_3002827bca3dc613 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
    maxammo = weaponmaxammo(tableinfo.objweapon, var_3002827bca3dc613);

    switch (ref) {
      case #"hash_6d194c409057b2":
      case #"hash_4b4a6458f00d9319":
      case #"hash_8770d1da0d7395b9":
      case #"hash_aa60ec2aec479ec8":
      case #"hash_cbcb2b145327e750":
        break;
      default:
        maxammo--;
        break;
    }

    slot = findequipmentslot(ref);

    if(!isDefined(slot)) {
      return maxammo;
    }

    if(_hasperk("specialty_extra_deadly") && slot == "primary") {
      if(_hasperk("specialty_ninja_vest")) {
        if(issubstr(ref, "throwing_knife") || issubstr(ref, "throwstar") || issubstr(ref, "shuriken")) {
          maxammo++;
        }
      } else {
        maxammo++;
      }
    }

    if(_hasperk("specialty_extra_tactical") && slot == "secondary") {
      maxammo++;
    }

    if(isDefined(class)) {
      classtype = scripts\mp\class::loadout_getclasstype(class);
      var_1bc3bf54ae8e6ed7 = function_11a4d197e8db4f(classtype);
      var_20327dd6b8d19acf = function_58ea099b568dbfaf(classtype);

      if((var_1bc3bf54ae8e6ed7 || function_ba9b7632e5af58c1()) && slot == "primary") {
        maxammo++;
      }

      if((var_20327dd6b8d19acf || function_a81e1cac79744c02()) && slot == "secondary") {
        maxammo++;
      }
    } else if(function_ba9b7632e5af58c1() && slot == "primary") {
      maxammo++;
    } else if(function_a81e1cac79744c02() && slot == "secondary") {
      maxammo++;
    }
  } else {
    if(!isDefined(tableinfo.ref)) {
      return 0;
    }

    if(isDefined(level.br_pickups.br_equipnametoscriptable[tableinfo.ref])) {
      equipmentname = level.br_pickups.br_equipnametoscriptable[tableinfo.ref];
    } else {
      equipmentname = level.br_pickups.br_equipnametoscriptable[getxhash(tableinfo.ref)];
    }

    assertex(isDefined(level.br_pickups.maxcounts[equipmentname]), "<dev string:x101>" + equipmentname + "<dev string:x10f>");
    maxammo = level.br_pickups.maxcounts[equipmentname];

    if(!isDefined(maxammo)) {
      maxammo = 0;
    }

    if(ref == "equip_armorplate") {
      if(scripts\mp\gametypes\br_public::hasplatepouch()) {
        maxammo += getdvarint(@ "hash_a5ab8ed6cc1b486a", 5);
      }

      if(istrue(level.var_6d1d9e1b59c6f37)) {
        maxammo = level.var_6d1d9e1b59c6f37;
      }
    }
  }

  return maxammo;
}

function function_ba9b7632e5af58c1() {
  return _hasperk("specialty_grenadier_vest") || _hasperk("specialty_rhino_rig") || _hasperk("specialty_pistol_vest");
}

function function_a81e1cac79744c02() {
  return _hasperk("specialty_tac_vest") || _hasperk("specialty_rhino_rig") || _hasperk("specialty_pistol_vest") || _hasperk("specialty_pistol_vest");
}

function getequipmentstartammo(ref) {
  tableinfo = getequipmenttableinfo(ref);

  if(!isDefined(tableinfo)) {
    return undefined;
  }

  if(!isDefined(tableinfo.objweapon)) {
    return 0;
  }

  var_3002827bca3dc613 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
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

  if(ammocount == 0) {
    tableweaponname = tableinfo.objweapon.basename;

    foreach(weaponobj in self.offhandinventory) {
      if(weaponobj.basename == tableweaponname) {
        ammocount = self getammocount(weaponobj);
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
  found = 0;

  foreach(equip in equipmentlist) {
    equipref = function_7f245729fcb6414d(equip.basename);

    if(isDefined(equipref) && equipref == ref) {
      variantid = undefined;
      weapon = undefined;
      found = 1;

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

  if(!istrue(found)) {
    weapon = tableinfo.objweapon;
    self setweaponammoclip(weapon, amount);
  }

  function_22bf78eca6578d7d(findequipmentslot(ref));
}

function incrementequipmentammo(ref, var_930290d7f474a0ae, class, var_7af3206c6ef0c3f0) {
  if(!isDefined(var_930290d7f474a0ae)) {
    var_930290d7f474a0ae = 1;
  }

  currammo = getequipmentammo(ref);
  newammo = int(min(currammo + var_930290d7f474a0ae, getequipmentmaxammo(ref, class)));

  if(!istrue(var_7af3206c6ef0c3f0)) {
    var_cd1c409bf48e2722 = getcallback(ref, "onIncrement");

    if(isDefined(var_cd1c409bf48e2722)) {
      self thread[[var_cd1c409bf48e2722]](ref, currammo);
    }
  }

  setequipmentammo(ref, newammo);
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

function function_fe48baf929906883(slot) {
  ammo = getequipmentslotammo(slot);
  ref = getcurrentequipment(slot);

  if(isDefined(ref)) {
    if(issharedfuncdefined(ref, "modifyGetEquipmentAmmoForDrop")) {
      ammo = [[getsharedfunc(ref, "modifyGetEquipmentAmmoForDrop")]](ref, ammo);
    }
  }

  return ammo;
}

function setequipmentslotammo(slot, count) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return undefined;
  }

  return setequipmentammo(ref, count);
}

function function_7f245729fcb6414d(weaponname) {
  return level.var_415476758ec47760[weaponname];
}

function mapequipmentweaponforref(objweapon) {
  weaponname = undefined;

  switch (objweapon.basename) {
    case #"hash_34f28162f0f54c6e":
    case #"hash_53d34fb712dd4235":
      weaponname = "throwingknife_mp";
      break;
    case #"hash_209a406e8931b2bd":
      weaponname = "throwstar_mp_jup";
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
    case #"hash_6547ec525f1340da":
    case #"hash_a009d256608f52ce":
    case #"hash_c4b9b21ecac2ced4":
      weaponname = "bunkerbuster_mp";
      break;
    case #"hash_9276d33dcce198b0":
    case #"hash_a51366582cde195e":
    case #"hash_adeee012d2581c12":
      weaponname = "jup_bunkerbuster_ob";
      break;
    case #"hash_9286c53dccee4e99":
    case #"hash_a50980582cd5f387":
    case #"hash_adcbea12d23c5553":
      weaponname = "jup_bunkerbuster_br";
      break;
    case #"hash_379caca7e143e75e":
    case #"hash_4a359b7b4364d9ac":
    case #"hash_66c5fe0e48af6b38":
      weaponname = "t10_bunkerbuster_mp";
      break;
    case #"hash_8fd6158eb96a1f15":
    case #"hash_b2a8e1829f433bd7":
      weaponname = "thermite_mp";
      break;
    case #"hash_82c54c49e3242f5b":
      weaponname = "trophy_mp";
      break;
    case #"hash_fd386aff9acf671":
      weaponname = "butterfly_mine_mp";
      break;
    case #"hash_fd964aff9b13e19":
      weaponname = "jup_butterfly_mine_ob";
      break;
    case #"hash_e36b3928a0e518fa":
      weaponname = "breacher_drone_mp";
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
  if(!isDefined(objweapon) || !isweapon(objweapon)) {
    return "";
  }

  objweapon = mapequipmentweaponforref(objweapon);
  return level.var_415476758ec47760[objweapon.basename];
}

function getequipmentbundlefromweaponname(weaponname) {
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

function function_2cbf1e7261f0c42a(equipmentref) {
  if(!isDefined(equipmentref)) {
    return undefined;
  }

  foreach(tableinfo in level.equipment.table) {
    if(isDefined(tableinfo.ref) && equipmentref == tableinfo.ref) {
      return tableinfo.bundle;
    }
  }

  return undefined;
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
  if(isDefined(level.equipment.table[ref])) {
    return (level.equipment.table[ref].defaultslot == "primary");
  }

  return 0;
}

function isequipmenttactical(ref) {
  return isequipmentsecondary(ref);
}

function isequipmentsecondary(ref) {
  if(isDefined(level.equipment.table[ref])) {
    return (level.equipment.table[ref].defaultslot == "secondary");
  }

  return 0;
}

function isequipmentselectable(ref) {
  if(isDefined(level.equipment.table[ref])) {
    return istrue(level.equipment.table[ref].isselectable);
  }

  return 0;
}

function function_22bf78eca6578d7d(slot, class) {
  if(!(isDefined(self.equipment) && isDefined(slot))) {
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

    self setclientomnvar("ui_equipment_id_health_numCharges", ammo);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      var_3312a64d533c3a0d = scripts\cp_mp\armor::function_6a84ae8b37bed447();
      scripts\mp\gametypes\br_public::updatebrscoreboardstat("armorPlateCount", ammo + var_3312a64d533c3a0d);
    }
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

    if(isDefined(tableinfo) && isDefined(tableinfo.objweapon) && objweapon == tableinfo.objweapon) {
      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        item_type = "";

        if(isDefined(tableinfo.bundle) && isDefined(tableinfo.bundle.equipmenttype)) {
          item_type = tableinfo.bundle.equipmenttype;
        }

        scripts\mp\gametypes\br_analytics::branalytics_equipmentuse(self, objweapon, item_type);
      }

      weaponref = scripts\mp\equipment::getequipmentreffromweapon(objweapon);
      assertex(isDefined(weaponref), "<dev string:x17d>" + ter_op(isDefined(objweapon) && isDefined(objweapon.basename), objweapon.basename), "<dev string:x19e>");
      scripts\mp\damage::combatrecordequipmentused(weaponref);
      onfiredcallback = getcallback(ref, "onFired");

      if(isDefined(onfiredcallback)) {
        self thread[[onfiredcallback]](ref, slot, objweapon);
      }

      if(isDefined(self.team)) {
        level notify("equipment_used_" + self.team, weaponref);
      }

      var_aeea6e0c86512100 = 0;
      ref = getcurrentequipment(slot);

      if(isDefined(ref)) {
        var_aeea6e0c86512100 = function_fe48baf929906883(slot) == 0;
      }

      if(var_aeea6e0c86512100 && isDefined(level.var_87a4731d4dce4c3f)) {
        success = self[[level.var_87a4731d4dce4c3f]](self, slot, ref);

        if(istrue(success)) {
          break;
        }
      }

      function_22bf78eca6578d7d(slot);

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && namespace_aead94004cf4c147::isbackpackinventoryenabled() && !getdvarint(@ "hash_ced962345ff6ecd0", 0) && !namespace_aead94004cf4c147::function_5bf048439a846222(ref)) {
        scriptablename = level.br_pickups.br_equipnametoscriptable[ref];

        if(scripts\mp\gametypes\br_public::function_6b531c76815d77f3(scriptablename) && !scripts\mp\gametypes\br_public::function_ac3376fecc550ef0(scriptablename)) {
          namespace_aead94004cf4c147::removesmallestitemstackbackpack(scriptablename, 1);
          scripts\mp\equipment::incrementequipmentammo(ref, 1);
        }
      }

      persstr = "tacticalsUsed";

      if(isequipmentlethal(weaponref)) {
        persstr = "lethalsUsed";
      }

      if(isDefined(self.pers[persstr])) {
        scripts\mp\utility\stats::incpersstat(persstr, 1);
      }

      if(isDefined(tableinfo.bundle.var_a2d48adbe4702769)) {
        level thread battlechatter_mp::trysaylocalsound(self, tableinfo.bundle.var_a2d48adbe4702769);
      }

      break;
    }
  }
}

function watchoffhandfired() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("offhand_fired", objweapon);

    if(scripts\mp\supers::function_36c4aa603286c24f(objweapon)) {
      self notify("special_weapon_fired", objweapon);
      continue;
    }

    executeoffhandfired(objweapon);
  }
}

function function_312cbcf07904565d() {
  foreach(ref in self.equipment) {
    if(!issubstr(ref, "throwing_knife")) {
      continue;
    }

    tableinfo = getequipmenttableinfo(ref);

    if(isDefined(tableinfo) && tableinfo.scavengerammo > 0) {
      incrementequipmentammo(ref, tableinfo.scavengerammo);
    }
  }
}

function givescavengerammo() {
  foreach(ref in self.equipment) {
    tableinfo = getequipmenttableinfo(ref);

    if(isDefined(tableinfo) && tableinfo.scavengerammo > 0) {
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
  } else {
    level.lethaldelaystarttime = gettimepassed();
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
    } else {
      currenttime = gettimepassed();
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

    if(slot == "primary") {
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
    } else {
      currenttime = gettimepassed();
    }

    n = (level.lethaldelayendtime - currenttime) / 1000;
    n = int(max(0, ceil(n)));
    player scripts\mp\hud_message::showerrormessage("MP/LETHALS_UNAVAILABLE_FOR_N", n);
  }
}

function cancellethaldelay() {
  level.lethaldelay = 0;

  if(currentgametypestopsclock()) {
    level.lethaldelaystarttime = gettime();
  } else {
    level.lethaldelaystarttime = gettimepassed();
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
    } else {
      currenttime = gettimepassed();
    }

    return (currenttime > level.lethaldelayendtime);
  }

  return false;
}

function currentgametypestopsclock() {
  gametype = getgametype();

  if(gametype == "hq" || gametype == "grnd" || gametype == "koth") {
    return true;
  }

  return false;
}

function onownerdisconnect(player) {
  allequip = player scripts\mp\weapons::getallequip();

  foreach(equip in allequip) {
    equip notify("owner_disconnect");
  }
}

function hackequipment(hacker) {
  self.ishacked = 1;
  newowner = hacker;

  if(isDefined(hacker.owner) && hacker.equipmentref == "equip_capture_bot") {
    newowner = hacker.owner;
  }

  newowner scripts\mp\gamelogic::sethasdonecombat(newowner, 1);
  hacker scripts\cp_mp\challenges::onhack(self.equipmentref);
  changeowner(newowner);

  if(level.teambased) {
    self filteroutplayermarks(newowner.team);
  } else {
    self filteroutplayermarks(newowner);
  }

  newowner scripts\mp\killstreaks\killstreaks::givescoreforhack();
}

function changeowner(newowner) {
  oldowner = self.owner;
  self setentityowner(newowner);
  self.owner = newowner;
  self.team = newowner.team;
  self setotherent(newowner);
  oldowner scripts\mp\weapons::removeequip(self);
  self.owner scripts\mp\weapons::updateplantedarray(self);
  onownerchanged = getcallback(self.equipmentref, "onOwnerChanged");
  self notify("ownerChanged");

  if(isDefined(onownerchanged)) {
    self[[onownerchanged]](oldowner);
  }
}

function function_f69ed22535d90b78() {
  self endon("death");
  level endon("game_ended");
  stuckdata = spawnStruct();
  childthread function_bdde0931accf955b(stuckdata);
  childthread function_449e67a68fa04968(stuckdata);
  self waittill("missile_impact");
  return stuckdata;
}

function function_bdde0931accf955b(stuckdata) {
  self endon("missile_impact");
  self waittill("missile_stuck", stuckto);

  if(isDefined(stuckto)) {
    stuckdata.stuckto = stuckto;
  }

  self notify("missile_impact");
}

function function_449e67a68fa04968(stuckdata) {
  self endon("missile_impact");
  self waittill("missile_water_impact");
  stuckdata.isunderwater = 1;
  self notify("missile_impact");
}

function function_4af015619e2534ba(stuckto, destroyfunc, isimmediate) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  if(isagent(stuckto)) {
    return;
  }

  stuckto waittill_any_2("death", "destroy");
  self thread[[destroyfunc]](isimmediate);
}

function debughackequipment() {
  setdevdvar(@ "hash_aa4a28e418803dd5", 0);

  while(true) {
    if(getdvarint(@ "hash_aa4a28e418803dd5") != 0) {
      setdevdvar(@ "hash_aa4a28e418803dd5", 0);
      mainplayer = level.players[0];
      enemyplayer = undefined;

      for(i = 1; i < level.players.size; i++) {
        if(mainplayer scripts\cp_mp\utility\player_utility::isenemy(level.players[i])) {
          enemyplayer = level.players[i];
          break;
        }
      }

      if(!isDefined(enemyplayer)) {
        iprintlnbold("<dev string:x1ab>");
        continue;
      }

      allequip = mainplayer scripts\mp\weapons::getallequip();
      equipment = undefined;

      if(allequip.size > 0) {
        equipment = allequip[0];
      }

      if(!isDefined(equipment)) {
        iprintlnbold("<dev string:x1e8>");
        continue;
      }

      equipment hackequipment(enemyplayer);
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
        iprintlnbold("<dev string:x23c>");
        continue;
      }

      secondplayer = level.players[1];
      secondplayer scripts\mp\utility\weapon::_launchgrenade("<dev string:x26f>", (0, 0, 0), (0, 0, 0), 0.05, 0);
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
        iprintlnbold("<dev string:x281>");
        continue;
      }

      firstplayer = level.players[0];
      secondplayer = level.players[1];
      streakinfo = spawnStruct();
      streakinfo.streakname = "<dev string:x2b2>";
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
        if(isDefined(killstreak.streakinfo) && killstreak.streakinfo.streakname == "<dev string:x2b2>") {
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
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\loot_system.gsc
***********************************************/

function init_loot() {
  level.disable_loot_drop = 1;
  level.active_loot_spots = [];
  level.assault_weapons_array = ["brloot_weapon_ak47", "brloot_weapon_famas", "brloot_weapon_m4", "brloot_weapon_mcx"];
  level.lmg_weapons_array = ["brloot_weapon_hk121", "brloot_weapon_pkm"];
  level.smg_weapons_array = ["brloot_weapon_aug", "brloot_weapon_mp5", "brloot_weapon_mp7", "brloot_weapon_p90"];
  level.shotgun_weapons_array = ["brloot_weapon_dp12", "brloot_weapon_m870"];
  level.sniper_weapons_array = ["brloot_weapon_as50", "brloot_weapon_kar98", "brloot_weapon_m14", "brloot_weapon_marlin"];
  level.pistol_weapons_array = ["brloot_weapon_g21", "brloot_weapon_python"];
  init_loot_scriptables();
}

function init_loot_scriptables() {
  scripts\engine\scriptable::scriptable_addusedcallback(&loot_pickup);
}

function loot_pickup(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "visible") {
    var_5 = give_loot_based_on_pickup(var_1, var_3);

    if(istrue(var_5)) {
      thread ref_119F4(level, var_0, var_1, var_2);
      return;
    }

    return;
  }
}

function ref_119F4(var_0, var_1, var_2, var_3) {
  var_4 = strtok(var_1, "_");
  var_5 = var_4[1];
  var_6 = var_4[2];
  var_3 playsoundtoplayer("scavenger_pack_pickup", var_3);
  var_0 setscriptablepartstate(var_1, "hidden");
  level notify("pickedupweapon_kill_callout_" + var_0.type + var_0.origin);

  if(var_5 == "munition") {
    var_7 = spawn("script_model", var_0.origin);
    var_7 setModel("offhand_wm_supportbox_killstreak");
    var_7.angles = var_0.angles;
    var_7 setscriptablepartstate("effects", "plant");
    var_7 setscriptablepartstate("anims", "open");
    var_3 scripts\cp\utility::playerplaypickupanim("iw8_ges_pickup_br");
    wait 1;
    var_7 delete();
    return;
  }
}

function give_loot_based_on_pickup(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = var_2[1];
  var_4 = var_2[2];
  var_5 = 0;

  switch (var_3) {
    case "ammo":
      var_5 = give_ammo(var_0, var_1);
      break;
    case "armor":
      break;
    case "attach":
      break;
    case "health":
      break;
    case "offhand":
      var_5 = give_offhands(var_4, var_1);
      break;
    case "weapon":
      var_5 = give_ammo_from_scavenged_weapon(var_0, var_1);
      break;
    case "munition":
      var_5 = give_munition(var_0, var_1);
      break;
    default:
      return var_5;
  }

  return var_5;
}

function give_munition(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = "";

  for(var_4 = 2; var_4 < var_2.size; var_4++) {
    if(isDefined(var_2[var_4])) {
      if(var_3 == "") {
        var_3 += var_2[var_4];
        continue;
      }

      var_3 = var_3 + "_" + var_2[var_4];
    }
  }

  var_5 = undefined;
  var_6 = var_1 getplayerdata("cp", "inventorySlots", "totalSlots");

  if(var_6 < 4) {
    var_5 = var_6;
  } else {
    var_5 = var_1.dpad_selection_index - 1;
  }

  var_7 = get_empty_munition_slot(var_1);

  if(isDefined(var_7)) {
    var_5 = var_7;
  } else {
    var_1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
    return 0;
  }

  switch (var_3) {
    case "grenade_launcher":
      var_1 scripts\cp\cp_munitions::give_munition_to_slot("grenade_launcher", var_5);
      return 1;
    case "ammo":
      return try_give_munition_to_slot(var_1, var_3, var_5, "ammo_crate", "pickup");
    case "turret":
      return try_give_munition_to_slot(var_1, var_3, var_5, "manual_turret", "pickup");
    case "air_drop":
    case "white_phos":
    case "trophysystem":
    case "cluster_strike":
    case "deployable_cover":
    case "cruise_missile":
    case "grenade_crate":
    case "uav":
    case "precision_airstrike":
    case "manual_turret":
    case "sentry":
    case "armor":
    case "juggernaut":
      return try_give_munition_to_slot(var_1, var_3, var_5, undefined, "pickup");
    default:
      break;
  }

  var_1 iprintlnbold("^1 Can't pick this up unknown munition: " + var_0);
  return 0;
}

function try_give_munition_to_slot(var_0, var_1, var_2, var_3) {
  var_4 = var_0;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  scripts\cp\cp_munitions::give_munition_to_slot(var_4, var_1, var_3);
  return true;
}

function force_hint_prompt_timer(var_0, var_1) {
  self forceusehinton(var_0);
  wait var_1;
  self forceusehintoff();
}

function get_empty_munition_slot(var_0) {
  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(is_empty_or_none(var_0, var_1)) {
      return var_1;
    }
  }
}

function is_empty_or_none(var_0) {
  var_1 = self;

  if(!isDefined(var_1.munition_slots)) {
    return true;
  }

  if(var_1.munition_slots[var_0].ref == "none" || var_1.munition_slots[var_0].ref == "empty1" || var_1.munition_slots[var_0].ref == "empty2" || var_1.munition_slots[var_0].ref == "empty3") {
    return true;
  }

  return false;
}

function give_ammo_from_scavenged_weapon(var_0, var_1) {
  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\utility::getweaponrootname(var_2);
  var_4 = scripts\cp\utility::weapongroupmap(var_3);

  if(scripts\engine\utility::array_contains(level.assault_weapons_array, var_0) && var_4 == "weapon_assault") {
    return give_ammo(var_0, var_1);
  }

  if(scripts\engine\utility::array_contains(level.smg_weapons_array, var_0) && var_4 == "weapon_smg") {
    return give_ammo(var_0, var_1);
  }

  if(scripts\engine\utility::array_contains(level.sniper_weapons_array, var_0) && (var_4 == "weapon_sniper" || var_4 == "weapon_dmr")) {
    return give_ammo(var_0, var_1);
  }

  if(scripts\engine\utility::array_contains(level.lmg_weapons_array, var_0) && var_4 == "weapon_lmg") {
    return give_ammo(var_0, var_1);
  }

  if(scripts\engine\utility::array_contains(level.shotgun_weapons_array, var_0) && var_4 == "weapon_shotgun") {
    return give_ammo(var_0, var_1);
  }

  if(scripts\engine\utility::array_contains(level.pistol_weapons_array, var_0) && var_4 == "weapon_pistol") {
    return give_ammo(var_0, var_1);
  }

  return 0;
}

function give_offhands(var_0, var_1) {
  var_2 = "primary";

  switch (var_0) {
    case "smoke":
    case "flash":
      var_2 = "secondary";
      break;
  }

  var_3 = scripts\cp\cp_powers::power_getpowerkeys();

  foreach(var_6, var_5 in var_1.powers) {
    if(var_1.powers[var_6].slot == var_2) {
      if(var_1.powers[var_6].charges + 1 > var_1.powers[var_6].maxcharges) {
        return false;
      }
    }
  }

  var_1 scripts\cp\cp_powers::power_adjustcharges(1, var_2);
  var_1 playlocalsound("weap_ammo_pickup");
  return true;
}

function give_ammo(var_0, var_1) {
  return give_ammo_clip(var_1);
}

function give_ammo_clip() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\utility::getrawbaseweaponname(var_0);
  var_2 = weaponclipsize(var_0);

  if(weapontype(var_0) == "riotshield" || scripts\cp\cp_weapon::is_incompatible_weapon(var_0)) {
    var_3 = self getweaponslistprimaries();

    foreach(var_5 in var_3) {
      if(var_5 == var_0) {
        continue;
      }

      if(!scripts\cp\cp_weapon::isbulletweapon(var_0)) {
        continue;
      }

      var_2 = weaponclipsize(var_5);
      var_1 = scripts\cp\utility::getrawbaseweaponname(var_5);

      if(self getweaponammostock(var_5) < weaponmaxammo(var_5)) {
        var_6 = self getweaponammostock(var_5);
        self setweaponammostock(var_5, var_2 + var_6);
        self.itempicked = createheadicon(var_5);
      } else if(self getweaponammoclip(var_5) < weaponclipsize(var_5)) {
        self setweaponammoclip(var_5, weaponclipsize(var_5));
      } else {
        return false;
      }

      return true;
    }
  } else if(self getweaponammostock(var_0) < weaponmaxammo(var_0)) {
    var_6 = self getweaponammostock(var_0);
    self setweaponammostock(var_0, var_2 + var_6);
    self.itempicked = createheadicon(var_0);
  } else if(self getweaponammoclip(var_0) < weaponclipsize(var_0)) {
    self setweaponammoclip(var_0, weaponclipsize(var_0));
  } else {
    return false;
  }

  self playlocalsound("weap_ammo_pickup");
  return true;
}
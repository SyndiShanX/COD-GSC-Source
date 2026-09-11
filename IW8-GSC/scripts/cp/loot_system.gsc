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

function loot_pickup(var0, var1, var2, var3, var4) {
  if(var2 == "visible") {
    var5 = give_loot_based_on_pickup(var1, var3);

    if(istrue(var5)) {
      thread ref_119f4(level, var0, var1, var2);
      return;
    }

    return;
  }
}

function ref_119f4(var0, var1, var2, var3) {
  var4 = strtok(var1, "_");
  var5 = var4[1];
  var6 = var4[2];
  var3 playsoundtoplayer("scavenger_pack_pickup", var3);
  var0 setscriptablepartstate(var1, "hidden");
  level notify("pickedupweapon_kill_callout_" + var0.type + var0.origin);

  if(var5 == "munition") {
    var7 = spawn("script_model", var0.origin);
    var7 setModel("offhand_wm_supportbox_killstreak");
    var7.angles = var0.angles;
    var7 setscriptablepartstate("effects", "plant");
    var7 setscriptablepartstate("anims", "open");
    var3 scripts\cp\utility::playerplaypickupanim("iw8_ges_pickup_br");
    wait 1;
    var7 delete();
    return;
  }
}

function give_loot_based_on_pickup(var0, var1) {
  var2 = strtok(var0, "_");
  var3 = var2[1];
  var4 = var2[2];
  var5 = 0;

  switch (var3) {
    case "ammo":
      var5 = give_ammo(var0, var1);
      break;
    case "armor":
      break;
    case "attach":
      break;
    case "health":
      break;
    case "offhand":
      var5 = give_offhands(var4, var1);
      break;
    case "weapon":
      var5 = give_ammo_from_scavenged_weapon(var0, var1);
      break;
    case "munition":
      var5 = give_munition(var0, var1);
      break;
    default:
      return var5;
  }

  return var5;
}

function give_munition(var0, var1) {
  var2 = strtok(var0, "_");
  var3 = "";

  for(var4 = 2; var4 < var2.size; var4++) {
    if(isDefined(var2[var4])) {
      if(var3 == "") {
        var3 += var2[var4];
        continue;
      }

      var3 = var3 + "_" + var2[var4];
    }
  }

  var5 = undefined;
  var6 = var1 getplayerdata("cp", "inventorySlots", "totalSlots");

  if(var6 < 4) {
    var5 = var6;
  } else {
    var5 = var1.dpad_selection_index - 1;
  }

  var7 = get_empty_munition_slot(var1);

  if(isDefined(var7)) {
    var5 = var7;
  } else {
    var1 scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
    return 0;
  }

  switch (var3) {
    case "grenade_launcher":
      var1 scripts\cp\cp_munitions::give_munition_to_slot("grenade_launcher", var5);
      return 1;
    case "ammo":
      return try_give_munition_to_slot(var1, var3, var5, "ammo_crate", "pickup");
    case "turret":
      return try_give_munition_to_slot(var1, var3, var5, "manual_turret", "pickup");
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
      return try_give_munition_to_slot(var1, var3, var5, undefined, "pickup");
    default:
      break;
  }

  var1 iprintlnbold("^1 Can't pick this up unknown munition: " + var0);
  return 0;
}

function try_give_munition_to_slot(var0, var1, var2, var3) {
  var4 = var0;

  if(isDefined(var2)) {
    var4 = var2;
  }

  scripts\cp\cp_munitions::give_munition_to_slot(var4, var1, var3);
  return true;
}

function force_hint_prompt_timer(var0, var1) {
  self forceusehinton(var0);
  wait var1;
  self forceusehintoff();
}

function get_empty_munition_slot(var0) {
  for(var1 = 0; var1 < var0.munition_slots.size; var1++) {
    if(is_empty_or_none(var0, var1)) {
      return var1;
    }
  }
}

function is_empty_or_none(var0) {
  var1 = self;

  if(!isDefined(var1.munition_slots)) {
    return true;
  }

  if(var1.munition_slots[var0].ref == "none" || var1.munition_slots[var0].ref == "empty1" || var1.munition_slots[var0].ref == "empty2" || var1.munition_slots[var0].ref == "empty3") {
    return true;
  }

  return false;
}

function give_ammo_from_scavenged_weapon(var0, var1) {
  var2 = var1 getcurrentweapon();
  var3 = scripts\cp\utility::getweaponrootname(var2);
  var4 = scripts\cp\utility::weapongroupmap(var3);

  if(scripts\engine\utility::array_contains(level.assault_weapons_array, var0) && var4 == "weapon_assault") {
    return give_ammo(var0, var1);
  }

  if(scripts\engine\utility::array_contains(level.smg_weapons_array, var0) && var4 == "weapon_smg") {
    return give_ammo(var0, var1);
  }

  if(scripts\engine\utility::array_contains(level.sniper_weapons_array, var0) && (var4 == "weapon_sniper" || var4 == "weapon_dmr")) {
    return give_ammo(var0, var1);
  }

  if(scripts\engine\utility::array_contains(level.lmg_weapons_array, var0) && var4 == "weapon_lmg") {
    return give_ammo(var0, var1);
  }

  if(scripts\engine\utility::array_contains(level.shotgun_weapons_array, var0) && var4 == "weapon_shotgun") {
    return give_ammo(var0, var1);
  }

  if(scripts\engine\utility::array_contains(level.pistol_weapons_array, var0) && var4 == "weapon_pistol") {
    return give_ammo(var0, var1);
  }

  return 0;
}

function give_offhands(var0, var1) {
  var2 = "primary";

  switch (var0) {
    case "smoke":
    case "flash":
      var2 = "secondary";
      break;
  }

  var3 = scripts\cp\cp_powers::power_getpowerkeys();

  foreach(var6, var5 in var1.powers) {
    if(var1.powers[var6].slot == var2) {
      if(var1.powers[var6].charges + 1 > var1.powers[var6].maxcharges) {
        return false;
      }
    }
  }

  var1 scripts\cp\cp_powers::power_adjustcharges(1, var2);
  var1 playlocalsound("weap_ammo_pickup");
  return true;
}

function give_ammo(var0, var1) {
  return give_ammo_clip(var1);
}

function give_ammo_clip() {
  var0 = self getcurrentweapon();
  var1 = scripts\cp\utility::getrawbaseweaponname(var0);
  var2 = weaponclipsize(var0);

  if(weapontype(var0) == "riotshield" || scripts\cp\cp_weapon::is_incompatible_weapon(var0)) {
    var3 = self getweaponslistprimaries();

    foreach(var5 in var3) {
      if(var5 == var0) {
        continue;
      }

      if(!scripts\cp\cp_weapon::isbulletweapon(var0)) {
        continue;
      }

      var2 = weaponclipsize(var5);
      var1 = scripts\cp\utility::getrawbaseweaponname(var5);

      if(self getweaponammostock(var5) < weaponmaxammo(var5)) {
        var6 = self getweaponammostock(var5);
        self setweaponammostock(var5, var2 + var6);
        self.itempicked = createheadicon(var5);
      } else if(self getweaponammoclip(var5) < weaponclipsize(var5)) {
        self setweaponammoclip(var5, weaponclipsize(var5));
      } else {
        return false;
      }

      return true;
    }
  } else if(self getweaponammostock(var0) < weaponmaxammo(var0)) {
    var6 = self getweaponammostock(var0);
    self setweaponammostock(var0, var2 + var6);
    self.itempicked = createheadicon(var0);
  } else if(self getweaponammoclip(var0) < weaponclipsize(var0)) {
    self setweaponammoclip(var0, weaponclipsize(var0));
  } else {
    return false;
  }

  self playlocalsound("weap_ammo_pickup");
  return true;
}
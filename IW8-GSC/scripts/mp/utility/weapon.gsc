/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\weapon.gsc
***********************************************/

function getattachmenttype(var_0) {
  var_1 = tablelookup("mp/attachmenttable.csv", 4, var_0, 2);
  return var_1;
}

function getcompleteweaponnamenoalt(var_0) {
  var_1 = createheadicon(var_0);

  if(istrue(var_0.isalternate)) {
    var_1 = getsubstr(var_1, 4);
  }

  return var_1;
}

function getweapontype(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(iscacprimaryweapon(var_0)) {
    return "primary";
  }

  if(iscacsecondaryweapon(var_0)) {
    return "secondary";
  }

  if(iskillstreakweapon(var_0)) {
    return "killstreak";
  }

  if(issuperweapon(var_0)) {
    return "super";
  }

  if(isgamemodeweapon(var_0)) {
    return "gamemode";
  }

  if(var_0 == "iw8_turret_50cal_mp" || var_0 == "manual_turret_payload_mp" || var_0 == "manual_turret_flak_mp" || var_0 == "manual_turret_flak_vehicle") {
    return "turret";
  }

  if(var_0 == "armored_train_mg_turret_mp" || var_0 == "armored_train_tank_turret_mp" || var_0 == "armored_train_mortar_turret_mp" || var_0 == "armored_train_locomotive_turret_mp" || var_0 == "armored_train_mg_turret_buffed_mp" || var_0 == "armored_train_tank_turret_buffed_mp" || var_0 == "armored_train_locomotive_turret_buffed_mp") {
    return "turret";
  }

  if(islevelweapon(var_0)) {
    return "level";
  }

  if(scripts\mp\utility\script::isstrstart(var_0, "destructible_")) {
    return "destructible";
  }

  if(isvehicleweapon(var_0)) {
    return "vehicle";
  }

  if(isspecialmeleeweapon(var_0) || var_0 == "iw8_defibrillator_mp") {
    return "special_melee";
  }

  if(isenvironmentweapon(var_0)) {
    return "environment";
  }

  var_1 = getequipmenttype(var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  if(var_0 == "none") {
    return "worldspawn";
  }

  if(var_0 == "bomb_site_mp") {
    return var_0;
  }

  if(var_0 == "iw8_gunless") {
    return "gunless";
  }

  if(var_0 == "zombie_ranged_attack_mp" || var_0 == "zombie_melee_attack_mp") {
    return "zombie";
  }
}

function getequipmenttype(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "rock_mp":
    case "claymore_radial_mp":
    case "snowball_mp":
    case "coal_mp":
    case "throwingknife_drill_mp":
    case "throwingknife_electric_mp":
    case "throwingknife_fire_mp":
    case "throwingknife_mp":
    case "claymore_mp":
    case "at_mine_mp":
    case "at_mine_ap_mp":
    case "c4_mp_p":
    case "semtex_mp":
    case "frag_grenade_mp":
    case "thermite_av_mp":
    case "thermite_ap_mp":
    case "thermite_mp":
    case "molotov_mp":
      var_1 = "lethal";
      break;
    case "smoke_grenade_mp":
    case "numbers_grenade_mp":
    case "geiger_counter_mp":
    case "offhand_spotter_scope_mp":
    case "pball_mp":
    case "hb_sensor_mp":
    case "adrenaline_mp":
    case "gas_grenade_mp":
    case "gas_mp":
    case "decoy_grenade_mp":
    case "emp_gadget_mp":
    case "snapshot_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
      var_1 = "tactical";
      break;
    case "bandage_br_fake":
    case "gesture_vest_plate_br":
    case "adrenaline_br_fake":
    case "ks_remote_drone_mp":
      if(scripts\mp\utility\game::getgametype() == "br") {
        var_1 = "equipment_other";
      }

      break;
    default:
      break;
  }

  return var_1;
}

function isenvironmentweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "lava_bomb_mp":
    case "gasoline_can_mp":
    case "electric_rail_mp":
    case "gas_can_toxic_mp":
    case "gas_can_mp":
    case "minefield_mp":
    case "danger_circle_br":
      return true;
    default:
      break;
  }

  return false;
}

function issuperweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  return isDefined(scripts\mp\supers::getsuperrefforsuperweapon(var_0));
}

function turnexfiltoside(var_0) {
  if(isDefined(var_0.others)) {
    foreach(var_2 in var_0.others) {
      if(issubstr(var_2, "akimbo")) {
        return true;
      }
    }
  }

  if(isDefined(var_0.attachments)) {
    foreach(var_2 in var_0.attachments) {
      if(issubstr(var_2, "akimbo")) {
        return true;
      }
    }
  }

  return false;
}

function issuperdamagesource(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(issuperweapon(var_0)) {
    return true;
  }

  if(var_1 == "chargemode_mp") {
    return true;
  }

  if(var_1 == "micro_turret_gun_mp") {
    return true;
  }

  if(var_1 == "super_trophy_mp") {
    return true;
  }

  return false;
}

function isgamemodeweapon(var_0) {
  if(isbombsiteweapon(var_0)) {
    return true;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "iw8_lm_dblmg":
    case "iw8_lm_kilo121jugg_mp":
    case "danger_circle_br":
    case "iw7_tdefball_mp":
    case "iw8_cyberemp_mp":
      return true;
    default:
      return false;
  }

  return false;
}

function islevelweapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "iw8_la_gromeoks_mp":
      return true;
    default:
      return false;
  }

  return false;
}

function getweapongroup(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return "other";
  }

  if(isstring(var_0) && (var_0 == "none" || var_0 == "alt_none")) {
    return "other";
  }

  var_1 = getweaponrootname(var_0);
  var_2 = weapongroupmap(var_1);

  if(!isDefined(var_2)) {
    if(issuperweapon(var_0)) {
      var_2 = "super";
    } else if(iskillstreakweapon(var_0)) {
      var_2 = "killstreak";
    } else if(isgamemodeweapon(var_0)) {
      var_2 = "gamemode";
    } else if(tut_loadout(var_0)) {
      var_2 = "weapon_ballisticSpecial";
    } else if(unlockableindex(var_0)) {
      var_2 = "weapon_dragonsBreath";
    } else {
      var_2 = "other";
    }
  }

  return var_2;
}

function runpubliceventoftype(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return "other";
  }

  if(isstring(var_0) && (var_0 == "none" || var_0 == "alt_none")) {
    return "other";
  }

  var_1 = getweaponrootname(var_0);
  var_2 = ref_14594(var_1);

  if(!isDefined(var_2)) {
    if(issuperweapon(var_0)) {
      var_2 = "super";
    } else if(iskillstreakweapon(var_0)) {
      var_2 = "killstreak";
    } else if(isgamemodeweapon(var_0)) {
      var_2 = "gamemode";
    } else if(tut_loadout(var_0)) {
      var_2 = "weapon_ballisticSpecial";
    } else if(unlockableindex(var_0)) {
      var_2 = "weapon_dragonsBreath";
    } else {
      var_2 = "other";
    }
  }

  return var_2;
}

function unlockableindex(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  return var_1 == "dragonsbreath_mp";
}

function tut_loadout(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "semtex_aalpha12_splash_mp":
    case "semtex_xmike109_splash_mp":
    case "thermite_xmike109_radius_mp":
    case "semtex_bolt_splash_mp":
    case "thermite_bolt_radius_mp":
    case "semtex_aalpha12_mp":
    case "semtex_xmike109_mp":
    case "thermite_xmike109_mp":
    case "semtex_bolt_mp":
    case "thermite_bolt_mp":
      return 1;
    default:
      return 0;
  }
}

function register_wave_spawner(var_0) {
  var_1 = getweaponrootname(var_0);
  var_2 = level.weaponattachments[var_1];

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  return var_2;
}

function attachmentscompatible(var_0, var_1, var_2) {
  if(attachmentiscosmetic(var_1) && attachmentiscosmetic(var_2)) {
    return 0;
  }

  var_1 = attachmentmap_tobase(var_1);
  var_2 = attachmentmap_tobase(var_2);
  var_3 = 1;

  if(var_1 == var_2) {
    var_3 = 0;
  } else if(isDefined(level.carryitem2omnvar)) {
    if(!isDefined(level.carryitem2omnvar[var_0])) {
      var_0 = "default";
    }

    var_3 = !(isDefined(level.carryitem2omnvar[var_0][var_1]) && isDefined(level.carryitem2omnvar[var_0][var_1][var_2]));
  } else if(var_1 != "none" && var_2 != "none") {
    if(!isDefined(level.cash_hud_bink[var_0])) {
      var_0 = "default";
    }

    var_4 = level.cash_hud_bink[var_0];
    var_5 = tablelookuprownum(var_4, 0, var_2);

    if(tablelookup(var_4, 0, var_1, var_5) == "no") {
      var_3 = 0;
    }
  }

  return var_3;
}

function attachmentsconflict(var_0, var_1, var_2, var_3, var_4) {
  if(attachmentiscosmetic(var_0) && attachmentiscosmetic(var_1)) {
    return var_0;
  }

  var_5 = undefined;

  if(issameweapon(var_2)) {
    var_5 = createheadicon(var_2);
  } else {
    var_5 = var_2;
  }

  if(!isDefined(var_3)) {
    var_3 = attachmentmap_tounique(var_0, var_5);
  }

  if(!isDefined(var_4)) {
    var_4 = attachmentmap_tounique(var_1, var_5);
  }

  if(add_head_icon_on_allies(var_3, var_4)) {
    return var_0;
  }

  if(add_head_icon_on_allies(var_4, var_3)) {
    return var_0;
  }

  var_0 = attachmentmap_tobase(var_0);
  var_1 = attachmentmap_tobase(var_1);
  var_6 = scripts\mp\weapons::safechecknum(var_5);

  if(isDefined(level.carryitem2omnvar) && !isDefined(level.carryitem2omnvar[var_6])) {
    var_6 = "default";
  }

  var_7 = "";

  if(var_0 == var_1) {
    var_7 = var_0;
  } else if(isDefined(level.carryitem2omnvar) && isDefined(level.carryitem2omnvar[var_6]) && isDefined(level.carryitem2omnvar[var_6][var_0])) {
    var_8 = level.carryitem2omnvar[var_6][var_0][var_1];

    if(isDefined(var_8)) {
      if(var_8 == "no") {
        var_7 = var_0;
      } else {
        var_7 = var_8;
      }
    }
  }

  return var_7;
}

function add_head_icon_on_allies(var_0, var_1) {
  var_2 = carryitemomnvar(var_0);
  var_3 = carryiteminfo(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_3 == var_2;
}

function getweaponrootname(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = level.weaponrootcache[var_1];

  if(isDefined(var_2)) {
    return var_2;
  }

  var_3 = var_1;
  var_4 = strtok(var_1, "_");

  if(!isDefined(var_4) || var_4.size == 0) {
    return "";
  }

  var_5 = 0;

  if(var_4[0] == "alt") {
    var_5++;
  }

  if(var_4[var_5] == "iw8" || var_4[var_5] == "s4") {
    var_6 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "mg", "mr"];

    if(scripts\engine\utility::array_contains(var_6, var_4[var_5 + 1])) {
      var_1 = var_4[var_5] + "_" + var_4[var_5 + 1] + "_" + var_4[var_5 + 2];
    } else {
      var_1 = var_4[var_5] + "_" + var_4[var_5 + 1];
    }
  }

  if(level.weaponrootcache.size < 100) {
    level.weaponrootcache[var_3] = var_1;
  }

  return var_1;
}

function relic_nuketimer_globalthread(var_0) {
  var_1 = getweaponrootname(var_0);

  if(isDefined(level.weaponmapdata[var_1]) && isDefined(level.weaponmapdata[var_1].assetname)) {
    var_0 = level.weaponmapdata[var_1].assetname;
  }

  return var_0;
}

function getweaponvarianttablename(var_0) {
  if(scripts\mp\utility\script::isstrstart(var_0, "iw8_")) {
    var_0 = getsubstr(var_0, 4);
  }

  if(scripts\mp\utility\script::isstrstart(var_0, "s4_")) {}

  return "mp/gunsmith/" + var_0 + "_variants.csv";
}

function getweaponbasenamescript(var_0) {
  if(issameweapon(var_0)) {
    return var_0.basename;
  }

  if(isstring(var_0) && var_0 == "none") {
    return "none";
  }

  return getweaponbasename(var_0);
}

function getweapongunsmithattachmenttable(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = getweaponrootname(var_1);
  return "mp/gunsmith/" + getsubstr(var_2, 4) + "_attachments.csv";
}

function getaltmodeweapon(var_0) {
  foreach(var_2 in var_0.attachments) {
    var_3 = attachmentmap_tobase(var_2);

    if(var_3 == "gl" || var_3 == "glsmoke" || var_3 == "glgas" || var_3 == "glconc" || var_3 == "glflash" || var_3 == "glincendiary" || var_3 == "glsemtex" || var_3 == "glsnap") {
      return var_3;
    }
  }

  return undefined;
}

function isaltmodeweapon(var_0) {
  if(var_0 == "none") {
    return false;
  }

  return weaponinventorytype(var_0) == "altmode";
}

function removealtmodefromweaponname(var_0) {
  if(isaltmodeweapon(var_0)) {
    var_0 = getsubstr(var_0, 4);
  }

  return var_0;
}

function getvalidextraammoweapons() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = weaponclass(var_3);

    if(!iskillstreakweapon(var_3) && var_4 != "grenade" && var_4 != "rocketlauncher" && self getweaponammostock(var_3) != 0) {
      var_0 = var_3;
    }
  }

  return var_0;
}

function ispickedupweapon(var_0) {
  if(iscacprimaryorsecondary(var_0)) {
    var_1 = undefined;

    if(issameweapon(var_0)) {
      var_1 = createheadicon(var_0 getnoaltweapon());
    } else if(isstring(var_0)) {
      var_1 = var_0;

      if(issubstr(var_1, "alt_")) {
        var_1 = getsubstr(var_1, 4, var_0.size);
      }
    }

    var_2 = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var_1;
    var_3 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var_1;

    if(!var_2 && !var_3) {
      return true;
    }
  }

  return false;
}

function iscacprimaryweapon(var_0) {
  return tv_station_fastrope_one_infil_start_targetname_array(getweapongroup(var_0), var_0);
}

function tv_station_fastrope_one_infil_start_targetname_array(var_0, var_1) {
  switch (var_0) {
    case "weapon_melee":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_dmr":
    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_smg":
    case "weapon_dragonsBreath":
    case "weapon_ballisticSpecial":
    case "weapon_tactical":
      return 1;
    default:
      return 0;
  }
}

function iscacsecondaryweapon(var_0) {
  return tv_station_fastrope_one_infil_start_targetname_array_index(getweapongroup(var_0), var_0);
}

function tv_station_fastrope_one_infil_start_targetname_array_index(var_0, var_1) {
  switch (var_0) {
    case "weapon_projectile":
    case "weapon_pistol":
      return 1;
    case "weapon_melee2":
      return !isspecialmeleeweapon(var_1);
    default:
      return 0;
  }
}

function iscacprimaryorsecondary(var_0) {
  var_1 = getweapongroup(var_0);
  return tv_station_fastrope_one_infil_start_targetname_array(var_1, var_0) || tv_station_fastrope_one_infil_start_targetname_array_index(var_1, var_0);
}

function iscacmeleeweapon(var_0) {
  var_1 = getweapongroup(var_0);
  return var_1 == "weapon_melee" || var_1 == "weapon_melee2";
}

function enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls)) {
    self.weaponlasercalls = 0;
  }

  self.weaponlasercalls++;
  self laseron();
}

function disableweaponlaser() {
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
    return;
  }
}

function attachmentmap_tounique(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_1)) {
    var_2 = createheadicon(var_1);
  } else {
    var_2 = var_1;
  }

  var_3 = getweaponrootname(var_1);

  if(var_3 != var_2) {
    var_4 = getweaponbasename(var_1);

    if(isDefined(var_4)) {
      if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_uniquetobase[var_0]) && isDefined(level.attachmentmap_basetounique[var_4][level.attachmentmap_uniquetobase[var_0]])) {
        var_5 = level.attachmentmap_uniquetobase[var_0];
        return level.attachmentmap_basetounique[var_4][var_5];
      } else if(isDefined(level.attachmentmap_basetounique[var_5]) && isDefined(level.attachmentmap_basetounique[var_5][var_1])) {
        return level.attachmentmap_basetounique[var_5][var_1];
      } else {
        var_6 = strtok(var_5, "_");

        if(var_6.size > 3) {
          var_7 = var_6[0] + "_" + var_6[1] + "_" + var_6[2];

          if(isDefined(level.attachmentmap_basetounique[var_7]) && isDefined(level.attachmentmap_basetounique[var_7][var_1])) {
            return level.attachmentmap_basetounique[var_7][var_1];
          }
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_basetounique[var_4][var_1])) {
    return level.attachmentmap_basetounique[var_4][var_1];
  } else {
    var_8 = weapongroupmap(var_4);

    if(isDefined(level.attachmentmap_basetounique[var_8]) && isDefined(level.attachmentmap_basetounique[var_8][var_1])) {
      return level.attachmentmap_basetounique[var_8][var_1];
    }
  }

  return var_1;
}

function attachmentmap_extratovariantid(var_0, var_1, var_2) {
  var_3 = var_1 + "|" + var_2;

  if(isDefined(level.weaponlootmapdata[var_3]) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap[var_0])) {
    return level.weaponlootmapdata[var_3].attachextratoidmap[var_0];
  }

  return 0;
}

function attachmentperkmap(var_0) {
  if(isDefined(level.attachmentmap_attachtoperk[var_0])) {
    return level.attachmentmap_attachtoperk[var_0];
  }

  return undefined;
}

function carryiteminfo(var_0) {
  if(isDefined(level.carrier_remove_carriable_weapon[var_0])) {
    return level.carrier_remove_carriable_weapon[var_0];
  }

  return undefined;
}

function carryitemomnvar(var_0) {
  if(isDefined(level.carryobjects_onjuggernaut[var_0])) {
    return level.carryobjects_onjuggernaut[var_0];
  }

  var_1 = attachmentmap_tobase(var_0);

  if(isDefined(level.carry_ref[var_1])) {
    return level.carry_ref[var_1];
  }

  return undefined;
}

function weaponassetnamemap(var_0, var_1) {
  if(iskillstreakweapon(var_0)) {
    return var_0;
  }

  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].assetoverridename)) {
      return level.weaponlootmapdata[var_2].assetoverridename;
    }
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].assetname)) {
    return level.weaponmapdata[var_0].assetname;
  }

  return var_0;
}

function weaponperkmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].perk)) {
    return level.weaponmapdata[var_0].perk;
  }

  return undefined;
}

function risktokens(var_0) {
  var_1 = randomintrange(0, level.ref_14589[var_0].size);
  return level.ref_14589[var_0][var_1];
}

function weapongroupmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].group)) {
    return level.weaponmapdata[var_0].group;
  }

  return undefined;
}

function ref_14594(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].ref_11bd1)) {
    return level.weaponmapdata[var_0].ref_11bd1;
  }

  return undefined;
}

function weaponnumbermap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].number)) {
    return level.weaponmapdata[var_0].number;
  }

  return undefined;
}

function weaponattachdefaulttoidmap(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachdefaulttoidmap)) {
      return level.weaponlootmapdata[var_2].attachdefaulttoidmap;
    }
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaulttoidmap)) {
    return level.weaponmapdata[var_0].attachdefaulttoidmap;
  }

  return undefined;
}

function weaponattachcustomtoidmap(var_0, var_1) {
  if(isDefined(var_1) && var_1 >= 0) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachcustomtoidmap)) {
      return level.weaponlootmapdata[var_2].attachcustomtoidmap;
    }
  }

  return undefined;
}

function safedestroy(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  var_2 = 1;
  var_3 = [];

  for(;;) {
    var_4 = var_0 + "|" + var_2;

    if(!isDefined(level.weaponlootmapdata[var_4])) {
      break;
    }

    if(!level.weaponlootmapdata[var_4].update_focus_fire_objective && !scripts\engine\utility::array_contains(var_1, var_2)) {
      var_3 = var_2;
    }

    var_2++;
  }

  return var_3;
}

function runspawnmodule_isolated(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  var_2 = 0;
  var_3 = safedestroy(var_0, var_1);

  if(var_3.size > 0) {
    var_2 = var_3[randomint(var_3.size)];
  }

  return var_2;
}

function weaponexistsinstatstable(var_0) {
  return isDefined(level.weaponmapdata[var_0]);
}

function ref_1458c(var_0, var_1) {
  var_2 = weaponexistsinstatstable(var_0);
  var_3 = 1;

  if(var_2) {
    if(isDefined(isDefined(var_1)) && var_1 > 0) {
      var_4 = var_0 + "|" + var_1;
      var_3 = isDefined(level.weaponlootmapdata[var_4]) && !level.weaponlootmapdata[var_4].update_focus_fire_objective;
    }
  }

  return var_2 && var_3;
}

function weaponattachremoveextraattachments(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = attachmentmap_tounique(var_4, var_1);
    var_6 = attachmentmap_toextra(var_5);

    if(isDefined(var_6)) {
      var_2 = var_6;
    }
  }

  var_8 = [];

  foreach(var_4 in var_0) {
    var_10 = 0;

    foreach(var_6 in var_2) {
      if(var_4 == var_6) {
        var_10 = 1;
        break;
      }
    }

    if(!var_10) {
      var_8 = var_4;
    }
  }

  return var_8;
}

function isattachmentsniperscopedefault(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  return isattachmentsniperscopedefaulttokenized(var_2, var_1);
}

function isattachmentsniperscopedefaulttokenized(var_0, var_1) {
  var_2 = 0;

  if(var_0.size && isDefined(var_1)) {
    var_3 = 0;

    if(var_0[0] == "alt") {
      var_3 = 1;
    }

    if(var_0.size >= 3 + var_3 && (var_0[var_3] == "iw6" || var_0[var_3] == "iw7")) {
      if(weaponclass(var_0[var_3] + "_" + var_0[var_3 + 1] + "_" + var_0[var_3 + 2]) == "sniper") {
        var_2 = var_0[var_3 + 1] + "scope" == var_1;
      }
    }
  }

  return var_2;
}

function getweaponattachmentsbasenames(var_0) {
  if(isstring(var_0)) {
    if(var_0 == "none") {
      return [];
    }
  } else if(var_0.basename == "none") {
    return [];
  }

  var_1 = getweaponattachments(var_0);

  if(!isDefined(var_1)) {
    return [];
  }

  foreach(var_3 in var_1) {
    var_1 = attachmentmap_tobase(var_3);
  }

  return var_1;
}

function getattachmentbasenames(var_0) {
  foreach(var_2 in var_0) {
    var_0 = attachmentmap_tobase(var_2);
  }

  return var_0;
}

function getattachmentlist(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = tablelookupbyrow("mp/attachmenttable.csv", var_6, 5);

    if(var_7 == "") {
      continue;
    }

    var_8 = tablelookupbyrow("mp/attachmenttable.csv", var_6, 2);

    if(isDefined(var_2) && (var_8 == "none" || var_8 == var_2)) {
      continue;
    }

    if(isDefined(var_3) && var_8 != var_3) {
      continue;
    }

    if(var_1) {
      var_9 = tablelookupbyrow("mp/attachmenttable.csv", var_6, 4);
      var_4 = var_9;
      continue;
    }

    if(scripts\engine\utility::array_contains(var_4, var_7)) {
      continue;
    }

    var_4 = var_7;
  }

  return var_4;
}

function getnonopticattachmentlistbasenames() {
  return getattachmentlist(5, 0, "rail", undefined);
}

function getopticattachmentlistbasenames() {
  if(isDefined(level.opticattachmentbasenames)) {
    return level.opticattachmentbasenames;
  }

  level.opticattachmentbasenames = getattachmentlist(5, 0, undefined, "rail");
  return level.opticattachmentbasenames;
}

function attachmentmap_tobase(var_0) {
  if(isDefined(level.attachmentmap_uniquetobase[var_0])) {
    var_0 = level.attachmentmap_uniquetobase[var_0];
  }

  return var_0;
}

function attachmentmap_toextra(var_0) {
  var_1 = undefined;

  if(isDefined(level.attachmentmap_uniquetoextra[var_0])) {
    var_1 = level.attachmentmap_uniquetoextra[var_0];
  }

  return var_1;
}

function mapweapon(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_0)) {
    var_3 = isundefinedweapon();
  }

  var_4 = 0;

  if(var_3.basename != "none") {
    if(isDefined(var_1) && !isPlayer(var_1)) {
      var_5 = getaltmodeweapon(var_0);

      if(isDefined(var_5)) {
        switch (var_5) {
          case "glconc":
            var_3 = getcompleteweaponname("concussion_grenade_mp");
            break;
          case "glflash":
            var_3 = getcompleteweaponname("flash_grenade_mp");
            break;
          case "glsnap":
            var_3 = getcompleteweaponname("snapshot_grenade_mp");
            break;
          case "glincendiary":
            var_3 = getcompleteweaponname("thermite_mp");
            break;
        }
      }
    }

    switch (var_3.basename) {
      case "pop_rocket_proj_mp":
        var_3 = getcompleteweaponname("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        var_3 = getcompleteweaponname("iw8_turret_50cal_mp");
        break;
      case "tur_bradley_mp":
      case "tur_gun_lighttank_mp":
        var_3 = getcompleteweaponname("lighttank_tur_mp");
        break;
      case "tur_bradley_ks_mp":
      case "tur_gun_lighttank_ks_mp":
        var_3 = getcompleteweaponname("lighttank_tur_ks_mp");
        break;
      case "ks_remote_drone_mp":
        var_3 = isundefinedweapon();
        break;
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_1.objweapon)) {
      var_3 = getcompleteweaponname(var_1.objweapon.basename);
      var_4 = 1;
    } else if(isDefined(var_1.weapon_name)) {
      var_3 = getcompleteweaponname(var_1.weapon_name);
      var_4 = 1;
    }
  }

  if(var_4 && !istrue(var_2)) {
    var_3 = mapweapon(var_3, var_1, 1);
  }

  return var_3;
}

function attachmentsfilterforstats(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(attachmentlogsstats(var_4, var_1)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function attachmentlogsstats(var_0, var_1) {
  if(attachmentiscosmetic(var_0)) {
    return false;
  }

  if(!carriedpunchcard(var_1, var_0)) {
    return false;
  }

  if(scripts\engine\utility::string_starts_with(var_0, "laststand_")) {
    return false;
  }

  return true;
}

function weaponhasattachment(var_0, var_1) {
  var_2 = getweaponattachmentsbasenames(var_0);

  foreach(var_4 in var_2) {
    if(var_4 == var_1) {
      return true;
    }
  }

  return false;
}

function setrecoilscale(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = var_0;
  } else {
    self.recoilscale += var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(self.recoilscale) && var_1 < self.recoilscale) {
      var_1 = self.recoilscale;
    }

    var_2 = 100 - var_1;
  } else {
    var_2 = 100 - self.recoilscale;
  }

  var_2 = int(clamp(var_2, 0, 255));

  if(var_2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_2);
}

function _launchgrenade(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);

  if(!isDefined(var_4)) {
    var_6.notthrown = 1;
  } else {
    var_6.notthrown = var_4;
  }

  var_6 setotherent(self);
  return var_6;
}

function grenadethrown(var_0) {
  return !isDefined(var_0.notthrown) || !var_0.notthrown;
}

function grenadeinpullback() {
  return !nullweapon(self getheldoffhand());
}

function getgrenadeinpullback() {
  var_0 = self getheldoffhand();

  if(isDefined(self.gestureweapon) && var_0 == asmdevgetallstates(self.gestureweapon)) {
    var_0 = isundefinedweapon();
  }

  return var_0;
}

function weaponignoresblastshield(var_0, var_1) {
  var_2 = var_0.basename;

  if(issuperweapon(var_2)) {
    return 1;
  }

  if(iskillstreakweapon(var_2)) {
    return 1;
  }

  switch (var_2) {
    case "gas_mp":
    case "snapshot_grenade_mp":
    case "concussion_grenade_mp":
    case "flash_grenade_mp":
    case "bomb_site_mp":
    case "iw8_sm_t9flechette_mp":
      return 1;
    default:
      return 0;
  }
}

function weaponsupportslaserir(var_0) {
  switch (var_0) {
    case "iw8_knife_mp":
    case "iw8_me_riotshield_mpv8":
    case "iw8_me_riotshield_mpv7":
    case "iw8_me_riotshield_mpv6":
    case "iw8_me_riotshield_mpv5":
    case "iw8_me_riotshield_mpv4":
    case "iw8_me_riotshield_mpv3":
    case "iw8_me_riotshield_mpv2":
    case "iw8_me_riotshield_mp":
    case "iw8_lm_dblmg_mp":
    case "iw8_minigunksjugg_reload_mp":
    case "iw8_la_juliet_mp":
    case "iw8_fists_mp":
    case "iw8_minigunksjugg_mp":
      return false;
  }

  if(iskillstreakweapon(var_0)) {
    return false;
  }

  var_1 = weaponclass(var_0);
  return var_1 == "rifle" || var_1 == "mg" || var_1 == "sniper" || var_1 == "smg" || var_1 == "spread";
}

function getweaponnvgattachment(var_0) {
  return "laserir";
}

function issinglehitweapon(var_0) {
  var_0 = getweaponbasenamescript(var_0);

  switch (var_0) {
    case "s4_la_palpha_mp":
    case "s4_la_mkilo1_mp":
    case "s4_la_palpha42_mp":
    case "s4_la_m1bravo_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_mike32_mp":
    case "iw8_la_t9launcher_mp":
    case "iw8_la_t9freefire_mp":
    case "iw8_la_t9standard_mp":
      return 1;
    default:
      return 0;
  }
}

function attachmentiscosmetic(var_0) {
  return isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "cos_");
}

function carriedpunchcard(var_0, var_1) {
  var_2 = getweaponrootname(var_0);
  return carrier_cleanup(var_2, var_1);
}

function carrier_cleanup(var_0, var_1) {
  var_2 = level.weaponattachments[var_0];
  return isDefined(var_2) && isDefined(var_2[var_1]);
}

function ref_12bbb(var_0) {
  switch (var_0) {
    case "laserads":
    case "laserbalanced":
    case "laserrange":
      var_0 = "laser";
      break;
    case "barsil2":
    case "barsil":
    case "silencer4":
    case "silencer3":
    case "silencer2":
      var_0 = "silencer";
      break;
    case "barcustnoguard":
    case "barcust2":
    case "barcust":
    case "barlong":
    case "barmid":
    case "barshortnoguard":
    case "barshort":
      var_0 = "barlong";
      break;
  }

  return var_0;
}

function ref_14584(var_0) {
  var_1 = "none";
  var_2 = -1;
  var_3 = getweaponrootname(var_0);

  if(isDefined(var_0) && !nullweapon(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "pistol":
        var_2 = 1;
        break;
      case "sniper":
        if(getweapongroup(var_0) == "weapon_dmr") {
          if(var_3 == "iw8_sn_kilo98" || var_3 == "iw8_sn_romeo700" || var_3 == "iw8_sn_t9crossbow" || var_3 == "iw8_sn_crossbow") {
            var_2 = 2;
          } else {
            var_2 = 4;
          }
        } else if(var_3 == "iw8_sn_t9accurate" || var_3 == "s4_mr_kalpha98" || var_3 == "iw8_sn_delta" || var_3 == "iw8_sn_t9quickscope" || var_3 == "iw8_sn_t9standard" || var_3 == "s4_mr_aromeo99") {
          var_2 = 6;
        } else if(var_3 == "iw8_sn_xmike109" || var_3 == "iw8_sn_t9powersemi" || var_3 == "s4_mr_ptango41") {
          var_2 = 3;
        } else {
          var_2 = 5;
        }

        break;
      default:
        var_2 = 0;
        break;
    }
  }

  return var_2;
}

function isbombsiteweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "bomb_site_mp":
    case "briefcase_bomb_mp":
      return true;
  }

  return false;
}

function iskillstreakweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[var_1])) {
    return true;
  }

  return false;
}

function unsetreduceregendelayonkills(var_0) {
  return isDefined(var_0) && isDefined(var_0.vehiclename) && isDefined(var_0.streakinfo);
}

function weaponbypassspawnprotection(var_0) {
  var_1 = 1;
  var_2 = undefined;

  if(issameweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  if(iskillstreakweapon(var_0) && var_2 != "manual_turret_mp" && var_2 != "pac_sentry_turret_mp" && !update_health_on_spawn(var_2)) {
    var_1 = 0;
  }

  return var_1;
}

function isvehicleweapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "carpoc_rocket_proj_mp":
    case "tur_gun_carpoc_mp_rocket":
    case "tur_gun_carpoc_mp":
    case "big_bird_mp":
    case "tur_gun_carpoc_mp_pass":
    case "open_jeep_carpoc_mp":
    case "open_jeep_mp":
    case "motorcycle_mp":
    case "little_bird_mg_mp":
    case "van_mp":
    case "med_transport_mp":
    case "jeep_mp":
    case "pickup_truck_mp":
    case "large_transport_mp":
    case "tac_rover_mp":
    case "cargo_truck_mg_mp":
    case "technical_mp":
    case "hoopty_truck_mp":
    case "hoopty_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "cargo_truck_mp":
    case "atv_mp":
    case "lighttank_mp":
    case "tur_gun_fd_mp_seeking":
    case "tur_gun_bt_mp_bomb":
    case "tur_gun_bt_mp":
    case "tur_apc_rus_mp":
    case "little_bird_mp":
    case "tur_gun_little_bird_left_mp":
    case "tur_gun_little_bird_right_mp":
    case "tur_gun_payload_truck_mp":
    case "tur_gun_cargo_truck_mp":
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
      return 1;
    default:
      return 0;
  }
}

function isgesture(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(issubstr(var_1, "ges_plyr")) {
    return 1;
  }

  if(issubstr(var_1, "devilhorns_mp")) {
    return 1;
  }

  return 0;
}

function getweaponfullname(var_0) {
  if(isstring(var_0)) {
    return var_0;
  }

  return createheadicon(var_0);
}

function playdeatomizefx(var_0, var_1) {
  GscBinSkip1(0x45, 0, 0, "org", self gettagorigin("j_spineupper"));
}

function isprimaryweapon(var_0) {
  if(nullweapon(var_0)) {
    return 0;
  }

  if(var_0.inventorytype != "primary" && var_0.inventorytype != "altmode") {
    return 0;
  }

  switch (var_0.classname) {
    case "smg":
    case "pistol":
    case "sniper":
    case "spread":
    case "mg":
    case "rifle":
    case "rocketlauncher":
      return 1;
    default:
      return 0;
  }
}

function update_health_bar_to_player(var_0) {
  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_1;
  }

  return var_1 == "iw8_knifestab_mp" || var_1 == "iw8_knifestab_mp" || var_1 == "iw8_throwingknife_fire_melee_mp" || var_1 == "iw8_throwingknife_electric_melee_mp" || var_1 == "iw8_throwingknife_drill_melee_mp";
}

function isknifeonly(var_0) {
  return getweaponrootname(var_0) == "iw8_knife";
}

function ismeleeonly(var_0) {
  if(isstring(var_0)) {}

  return var_0.ismelee;
}

function isfistsonly(var_0) {
  return getweaponrootname(var_0) == "iw8_fists";
}

function isballweapon(var_0) {
  return var_0.basename == "iw8_cyberemp_mp" || var_0.basename == "iw7_tdefball_mp";
}

function isaxeweapon(var_0) {
  var_1 = getweaponrootname(var_0);
  return var_1 == "iw7_axe" || var_1 == "s4_me_icepick" || var_1 == "s4_me_axe";
}

function validatefuelstability(var_0, var_1) {
  return isaxeweapon(var_0) && isDefined(var_1.classname) && var_1.classname == "grenade";
}

function turret_aimed_at_last_known(var_0) {
  return getweaponrootname(var_0) == "iw8_me_akimboblunt" || getweaponrootname(var_0) == "iw8_me_akimboblades";
}

function isthrowingknife(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return 0;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return 0;
    }

    var_1 = var_0;
  }

  return issubstr(var_1, "throwingknife");
}

function isspecialmeleeweapon(var_0) {
  if(update_health_bar_to_player(var_0)) {
    return true;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return false;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return false;
    }

    var_1 = var_0;
  }

  return var_1 == "iw8_fists_mp_ls";
}

function unset_relic_mythic(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return false;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return false;
    }

    var_1 = var_0;
  }

  return var_1 == "iw8_gunless" || var_1 == "iw8_gunless_infil" || var_1 == "iw8_gunless_last_stand_enter";
}

function update_health_on_spawn(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return false;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return false;
    }

    var_1 = var_0;
  }

  return var_1 == "iw8_minigunksjugg_mp" || var_1 == "iw8_minigunksjugg_reload_mp" || var_1 == "iw8_lm_dblmg_mp";
}

function unset_jugg_ignoreall_after_notify(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return false;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return false;
    }

    var_1 = var_0;
  }

  return var_1 == "iw8_sn_t9explosivebow_mp";
}

function infiniteammothread(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("stop_infinite_ammo_thread");
  jumpiftrue(isDefined(var_0)) LOC_0000001e;
  var_0 = level.framedurationseconds;

  for(;;) {
    if(!isDefined(var_1)) {
      var_1 = self.equippedweapons;
    }

    foreach(var_3 in var_1) {
      self givemaxammo(var_3);
      self setweaponammoclip(var_3, weaponclipsize(var_3));
    }

    wait var_0;
  }
}

function stopinfiniteammothread() {
  self notify("stop_infinite_ammo_thread");
}

function russianletter(var_0) {
  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_weapontoscriptable) && isDefined(level.br_pickups.delay_hide_player_clip)) {
    var_1 = createheadicon(var_0);
    var_2 = level.br_pickups.br_weapontoscriptable[var_1];

    if(isDefined(var_2)) {
      return level.br_pickups.delay_hide_player_clip[var_2];
    }
  }

  var_3 = scripts\mp\loot::getlootinfoforweapon(var_0.basename, var_0.variantid);

  if(isDefined(var_3)) {
    return var_3.quality;
  }

  return undefined;
}

function safe_to_authenticate(var_0) {
  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_weapontoscriptable) && isDefined(level.br_pickups.delay_hide_player_clip)) {
    var_1 = createheadicon(var_0);
    var_2 = level.br_pickups.br_weapontoscriptable[var_1];

    if(isDefined(var_2)) {
      return level.br_pickups.delay_hide_player_clip[var_2];
    }
  }

  return undefined;
}

function unset_relic_damage_from_above(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = getweaponbasename(var_0);
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "manual_turret_flak_vehicle":
    case "manual_turret_flak_mp":
    case "manual_turret_flak_mp_highrof":
      return 1;
    default:
      return 0;
  }
}
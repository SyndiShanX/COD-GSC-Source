/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\weapon.gsc
***********************************************/

function getattachmenttype(var0) {
  var1 = tablelookup("mp/attachmenttable.csv", 4, var0, 2);
  return var1;
}

function getcompleteweaponnamenoalt(var0) {
  var1 = createheadicon(var0);

  if(istrue(var0.isalternate)) {
    var1 = getsubstr(var1, 4);
  }

  return var1;
}

function getweapontype(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(iscacprimaryweapon(var0)) {
    return "primary";
  }

  if(iscacsecondaryweapon(var0)) {
    return "secondary";
  }

  if(iskillstreakweapon(var0)) {
    return "killstreak";
  }

  if(issuperweapon(var0)) {
    return "super";
  }

  if(isgamemodeweapon(var0)) {
    return "gamemode";
  }

  if(var0 == "iw8_turret_50cal_mp" || var0 == "manual_turret_payload_mp" || var0 == "manual_turret_flak_mp" || var0 == "manual_turret_flak_vehicle") {
    return "turret";
  }

  if(var0 == "armored_train_mg_turret_mp" || var0 == "armored_train_tank_turret_mp" || var0 == "armored_train_mortar_turret_mp" || var0 == "armored_train_locomotive_turret_mp" || var0 == "armored_train_mg_turret_buffed_mp" || var0 == "armored_train_tank_turret_buffed_mp" || var0 == "armored_train_locomotive_turret_buffed_mp") {
    return "turret";
  }

  if(islevelweapon(var0)) {
    return "level";
  }

  if(scripts\mp\utility\script::isstrstart(var0, "destructible_")) {
    return "destructible";
  }

  if(isvehicleweapon(var0)) {
    return "vehicle";
  }

  if(isspecialmeleeweapon(var0) || var0 == "iw8_defibrillator_mp") {
    return "special_melee";
  }

  if(isenvironmentweapon(var0)) {
    return "environment";
  }

  var1 = getequipmenttype(var0);

  if(isDefined(var1)) {
    return var1;
  }

  if(var0 == "none") {
    return "worldspawn";
  }

  if(var0 == "bomb_site_mp") {
    return var0;
  }

  if(var0 == "iw8_gunless") {
    return "gunless";
  }

  if(var0 == "zombie_ranged_attack_mp" || var0 == "zombie_melee_attack_mp") {
    return "zombie";
  }
}

function getequipmenttype(var0) {
  var1 = undefined;

  switch (var0) {
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
      var1 = "lethal";
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
      var1 = "tactical";
      break;
    case "bandage_br_fake":
    case "gesture_vest_plate_br":
    case "adrenaline_br_fake":
    case "ks_remote_drone_mp":
      if(scripts\mp\utility\game::getgametype() == "br") {
        var1 = "equipment_other";
      }

      break;
    default:
      break;
  }

  return var1;
}

function isenvironmentweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
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

function issuperweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  return isDefined(scripts\mp\supers::getsuperrefforsuperweapon(var0));
}

function turnexfiltoside(var0) {
  if(isDefined(var0.others)) {
    foreach(var2 in var0.others) {
      if(issubstr(var2, "akimbo")) {
        return true;
      }
    }
  }

  if(isDefined(var0.attachments)) {
    foreach(var2 in var0.attachments) {
      if(issubstr(var2, "akimbo")) {
        return true;
      }
    }
  }

  return false;
}

function issuperdamagesource(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  if(issuperweapon(var0)) {
    return true;
  }

  if(var1 == "chargemode_mp") {
    return true;
  }

  if(var1 == "micro_turret_gun_mp") {
    return true;
  }

  if(var1 == "super_trophy_mp") {
    return true;
  }

  return false;
}

function isgamemodeweapon(var0) {
  if(isbombsiteweapon(var0)) {
    return true;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
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

function islevelweapon(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
    case "iw8_la_gromeoks_mp":
      return true;
    default:
      return false;
  }

  return false;
}

function getweapongroup(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return "other";
  }

  if(isstring(var0) && (var0 == "none" || var0 == "alt_none")) {
    return "other";
  }

  var1 = getweaponrootname(var0);
  var2 = weapongroupmap(var1);

  if(!isDefined(var2)) {
    if(issuperweapon(var0)) {
      var2 = "super";
    } else if(iskillstreakweapon(var0)) {
      var2 = "killstreak";
    } else if(isgamemodeweapon(var0)) {
      var2 = "gamemode";
    } else if(tut_loadout(var0)) {
      var2 = "weapon_ballisticSpecial";
    } else if(unlockableindex(var0)) {
      var2 = "weapon_dragonsBreath";
    } else {
      var2 = "other";
    }
  }

  return var2;
}

function runpubliceventoftype(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return "other";
  }

  if(isstring(var0) && (var0 == "none" || var0 == "alt_none")) {
    return "other";
  }

  var1 = getweaponrootname(var0);
  var2 = ref_14594(var1);

  if(!isDefined(var2)) {
    if(issuperweapon(var0)) {
      var2 = "super";
    } else if(iskillstreakweapon(var0)) {
      var2 = "killstreak";
    } else if(isgamemodeweapon(var0)) {
      var2 = "gamemode";
    } else if(tut_loadout(var0)) {
      var2 = "weapon_ballisticSpecial";
    } else if(unlockableindex(var0)) {
      var2 = "weapon_dragonsBreath";
    } else {
      var2 = "other";
    }
  }

  return var2;
}

function unlockableindex(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  return var1 == "dragonsbreath_mp";
}

function tut_loadout(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
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

function register_wave_spawner(var0) {
  var1 = getweaponrootname(var0);
  var2 = level.weaponattachments[var1];

  if(!isDefined(var2)) {
    var2 = [];
  }

  return var2;
}

function attachmentscompatible(var0, var1, var2) {
  if(attachmentiscosmetic(var1) && attachmentiscosmetic(var2)) {
    return 0;
  }

  var1 = attachmentmap_tobase(var1);
  var2 = attachmentmap_tobase(var2);
  var3 = 1;

  if(var1 == var2) {
    var3 = 0;
  } else if(isDefined(level.carryitem2omnvar)) {
    if(!isDefined(level.carryitem2omnvar[var0])) {
      var0 = "default";
    }

    var3 = !(isDefined(level.carryitem2omnvar[var0][var1]) && isDefined(level.carryitem2omnvar[var0][var1][var2]));
  } else if(var1 != "none" && var2 != "none") {
    if(!isDefined(level.cash_hud_bink[var0])) {
      var0 = "default";
    }

    var4 = level.cash_hud_bink[var0];
    var5 = tablelookuprownum(var4, 0, var2);

    if(tablelookup(var4, 0, var1, var5) == "no") {
      var3 = 0;
    }
  }

  return var3;
}

function attachmentsconflict(var0, var1, var2, var3, var4) {
  if(attachmentiscosmetic(var0) && attachmentiscosmetic(var1)) {
    return var0;
  }

  var5 = undefined;

  if(issameweapon(var2)) {
    var5 = createheadicon(var2);
  } else {
    var5 = var2;
  }

  if(!isDefined(var3)) {
    var3 = attachmentmap_tounique(var0, var5);
  }

  if(!isDefined(var4)) {
    var4 = attachmentmap_tounique(var1, var5);
  }

  if(add_head_icon_on_allies(var3, var4)) {
    return var0;
  }

  if(add_head_icon_on_allies(var4, var3)) {
    return var0;
  }

  var0 = attachmentmap_tobase(var0);
  var1 = attachmentmap_tobase(var1);
  var6 = scripts\mp\weapons::safechecknum(var5);

  if(isDefined(level.carryitem2omnvar) && !isDefined(level.carryitem2omnvar[var6])) {
    var6 = "default";
  }

  var7 = "";

  if(var0 == var1) {
    var7 = var0;
  } else if(isDefined(level.carryitem2omnvar) && isDefined(level.carryitem2omnvar[var6]) && isDefined(level.carryitem2omnvar[var6][var0])) {
    var8 = level.carryitem2omnvar[var6][var0][var1];

    if(isDefined(var8)) {
      if(var8 == "no") {
        var7 = var0;
      } else {
        var7 = var8;
      }
    }
  }

  return var7;
}

function add_head_icon_on_allies(var0, var1) {
  var2 = carryitemomnvar(var0);
  var3 = carryiteminfo(var1);
  return isDefined(var2) && isDefined(var3) && var3 == var2;
}

function getweaponrootname(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  var2 = level.weaponrootcache[var1];

  if(isDefined(var2)) {
    return var2;
  }

  var3 = var1;
  var4 = strtok(var1, "_");

  if(!isDefined(var4) || var4.size == 0) {
    return "";
  }

  var5 = 0;

  if(var4[0] == "alt") {
    var5++;
  }

  if(var4[var5] == "iw8" || var4[var5] == "s4") {
    var6 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "mg", "mr"];

    if(scripts\engine\utility::array_contains(var6, var4[var5 + 1])) {
      var1 = var4[var5] + "_" + var4[var5 + 1] + "_" + var4[var5 + 2];
    } else {
      var1 = var4[var5] + "_" + var4[var5 + 1];
    }
  }

  if(level.weaponrootcache.size < 100) {
    level.weaponrootcache[var3] = var1;
  }

  return var1;
}

function relic_nuketimer_globalthread(var0) {
  var1 = getweaponrootname(var0);

  if(isDefined(level.weaponmapdata[var1]) && isDefined(level.weaponmapdata[var1].assetname)) {
    var0 = level.weaponmapdata[var1].assetname;
  }

  return var0;
}

function getweaponvarianttablename(var0) {
  if(scripts\mp\utility\script::isstrstart(var0, "iw8_")) {
    var0 = getsubstr(var0, 4);
  }

  if(scripts\mp\utility\script::isstrstart(var0, "s4_")) {}

  return "mp/gunsmith/" + var0 + "_variants.csv";
}

function getweaponbasenamescript(var0) {
  if(issameweapon(var0)) {
    return var0.basename;
  }

  if(isstring(var0) && var0 == "none") {
    return "none";
  }

  return getweaponbasename(var0);
}

function getweapongunsmithattachmenttable(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  var2 = getweaponrootname(var1);
  return "mp/gunsmith/" + getsubstr(var2, 4) + "_attachments.csv";
}

function getaltmodeweapon(var0) {
  foreach(var2 in var0.attachments) {
    var3 = attachmentmap_tobase(var2);

    if(var3 == "gl" || var3 == "glsmoke" || var3 == "glgas" || var3 == "glconc" || var3 == "glflash" || var3 == "glincendiary" || var3 == "glsemtex" || var3 == "glsnap") {
      return var3;
    }
  }

  return undefined;
}

function isaltmodeweapon(var0) {
  if(var0 == "none") {
    return false;
  }

  return weaponinventorytype(var0) == "altmode";
}

function removealtmodefromweaponname(var0) {
  if(isaltmodeweapon(var0)) {
    var0 = getsubstr(var0, 4);
  }

  return var0;
}

function getvalidextraammoweapons() {
  var0 = [];
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    var4 = weaponclass(var3);

    if(!iskillstreakweapon(var3) && var4 != "grenade" && var4 != "rocketlauncher" && self getweaponammostock(var3) != 0) {
      var0 = var3;
    }
  }

  return var0;
}

function ispickedupweapon(var0) {
  if(iscacprimaryorsecondary(var0)) {
    var1 = undefined;

    if(issameweapon(var0)) {
      var1 = createheadicon(var0 getnoaltweapon());
    } else if(isstring(var0)) {
      var1 = var0;

      if(issubstr(var1, "alt_")) {
        var1 = getsubstr(var1, 4, var0.size);
      }
    }

    var2 = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var1;
    var3 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var1;

    if(!var2 && !var3) {
      return true;
    }
  }

  return false;
}

function iscacprimaryweapon(var0) {
  return tv_station_fastrope_one_infil_start_targetname_array(getweapongroup(var0), var0);
}

function tv_station_fastrope_one_infil_start_targetname_array(var0, var1) {
  switch (var0) {
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

function iscacsecondaryweapon(var0) {
  return tv_station_fastrope_one_infil_start_targetname_array_index(getweapongroup(var0), var0);
}

function tv_station_fastrope_one_infil_start_targetname_array_index(var0, var1) {
  switch (var0) {
    case "weapon_projectile":
    case "weapon_pistol":
      return 1;
    case "weapon_melee2":
      return !isspecialmeleeweapon(var1);
    default:
      return 0;
  }
}

function iscacprimaryorsecondary(var0) {
  var1 = getweapongroup(var0);
  return tv_station_fastrope_one_infil_start_targetname_array(var1, var0) || tv_station_fastrope_one_infil_start_targetname_array_index(var1, var0);
}

function iscacmeleeweapon(var0) {
  var1 = getweapongroup(var0);
  return var1 == "weapon_melee" || var1 == "weapon_melee2";
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

function attachmentmap_tounique(var0, var1) {
  var2 = undefined;

  if(issameweapon(var1)) {
    var2 = createheadicon(var1);
  } else {
    var2 = var1;
  }

  var3 = getweaponrootname(var1);

  if(var3 != var2) {
    var4 = getweaponbasename(var1);

    if(isDefined(var4)) {
      if(isDefined(level.attachmentmap_basetounique[var4]) && isDefined(level.attachmentmap_uniquetobase[var0]) && isDefined(level.attachmentmap_basetounique[var4][level.attachmentmap_uniquetobase[var0]])) {
        var5 = level.attachmentmap_uniquetobase[var0];
        return level.attachmentmap_basetounique[var4][var5];
      } else if(isDefined(level.attachmentmap_basetounique[var5]) && isDefined(level.attachmentmap_basetounique[var5][var1])) {
        return level.attachmentmap_basetounique[var5][var1];
      } else {
        var6 = strtok(var5, "_");

        if(var6.size > 3) {
          var7 = var6[0] + "_" + var6[1] + "_" + var6[2];

          if(isDefined(level.attachmentmap_basetounique[var7]) && isDefined(level.attachmentmap_basetounique[var7][var1])) {
            return level.attachmentmap_basetounique[var7][var1];
          }
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var4]) && isDefined(level.attachmentmap_basetounique[var4][var1])) {
    return level.attachmentmap_basetounique[var4][var1];
  } else {
    var8 = weapongroupmap(var4);

    if(isDefined(level.attachmentmap_basetounique[var8]) && isDefined(level.attachmentmap_basetounique[var8][var1])) {
      return level.attachmentmap_basetounique[var8][var1];
    }
  }

  return var1;
}

function attachmentmap_extratovariantid(var0, var1, var2) {
  var3 = var1 + "|" + var2;

  if(isDefined(level.weaponlootmapdata[var3]) && isDefined(level.weaponlootmapdata[var3].attachextratoidmap) && isDefined(level.weaponlootmapdata[var3].attachextratoidmap[var0])) {
    return level.weaponlootmapdata[var3].attachextratoidmap[var0];
  }

  return 0;
}

function attachmentperkmap(var0) {
  if(isDefined(level.attachmentmap_attachtoperk[var0])) {
    return level.attachmentmap_attachtoperk[var0];
  }

  return undefined;
}

function carryiteminfo(var0) {
  if(isDefined(level.carrier_remove_carriable_weapon[var0])) {
    return level.carrier_remove_carriable_weapon[var0];
  }

  return undefined;
}

function carryitemomnvar(var0) {
  if(isDefined(level.carryobjects_onjuggernaut[var0])) {
    return level.carryobjects_onjuggernaut[var0];
  }

  var1 = attachmentmap_tobase(var0);

  if(isDefined(level.carry_ref[var1])) {
    return level.carry_ref[var1];
  }

  return undefined;
}

function weaponassetnamemap(var0, var1) {
  if(iskillstreakweapon(var0)) {
    return var0;
  }

  if(isDefined(var1)) {
    var2 = var0 + "|" + var1;

    if(isDefined(level.weaponlootmapdata[var2]) && isDefined(level.weaponlootmapdata[var2].assetoverridename)) {
      return level.weaponlootmapdata[var2].assetoverridename;
    }
  }

  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].assetname)) {
    return level.weaponmapdata[var0].assetname;
  }

  return var0;
}

function weaponperkmap(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].perk)) {
    return level.weaponmapdata[var0].perk;
  }

  return undefined;
}

function risktokens(var0) {
  var1 = randomintrange(0, level.ref_14589[var0].size);
  return level.ref_14589[var0][var1];
}

function weapongroupmap(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].group)) {
    return level.weaponmapdata[var0].group;
  }

  return undefined;
}

function ref_14594(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].ref_11bd1)) {
    return level.weaponmapdata[var0].ref_11bd1;
  }

  return undefined;
}

function weaponnumbermap(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].number)) {
    return level.weaponmapdata[var0].number;
  }

  return undefined;
}

function weaponattachdefaulttoidmap(var0, var1) {
  if(isDefined(var1)) {
    var2 = var0 + "|" + var1;

    if(isDefined(level.weaponlootmapdata[var2]) && isDefined(level.weaponlootmapdata[var2].attachdefaulttoidmap)) {
      return level.weaponlootmapdata[var2].attachdefaulttoidmap;
    }
  }

  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].attachdefaulttoidmap)) {
    return level.weaponmapdata[var0].attachdefaulttoidmap;
  }

  return undefined;
}

function weaponattachcustomtoidmap(var0, var1) {
  if(isDefined(var1) && var1 >= 0) {
    var2 = var0 + "|" + var1;

    if(isDefined(level.weaponlootmapdata[var2]) && isDefined(level.weaponlootmapdata[var2].attachcustomtoidmap)) {
      return level.weaponlootmapdata[var2].attachcustomtoidmap;
    }
  }

  return undefined;
}

function safedestroy(var0, var1) {
  if(!isDefined(var1)) {
    var1 = [];
  }

  var2 = 1;
  var3 = [];

  for(;;) {
    var4 = var0 + "|" + var2;

    if(!isDefined(level.weaponlootmapdata[var4])) {
      break;
    }

    if(!level.weaponlootmapdata[var4].update_focus_fire_objective && !scripts\engine\utility::array_contains(var1, var2)) {
      var3 = var2;
    }

    var2++;
  }

  return var3;
}

function runspawnmodule_isolated(var0, var1) {
  if(!isDefined(var1)) {
    var1 = [];
  }

  var2 = 0;
  var3 = safedestroy(var0, var1);

  if(var3.size > 0) {
    var2 = var3[randomint(var3.size)];
  }

  return var2;
}

function weaponexistsinstatstable(var0) {
  return isDefined(level.weaponmapdata[var0]);
}

function ref_1458c(var0, var1) {
  var2 = weaponexistsinstatstable(var0);
  var3 = 1;

  if(var2) {
    if(isDefined(isDefined(var1)) && var1 > 0) {
      var4 = var0 + "|" + var1;
      var3 = isDefined(level.weaponlootmapdata[var4]) && !level.weaponlootmapdata[var4].update_focus_fire_objective;
    }
  }

  return var2 && var3;
}

function weaponattachremoveextraattachments(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    var5 = attachmentmap_tounique(var4, var1);
    var6 = attachmentmap_toextra(var5);

    if(isDefined(var6)) {
      var2 = var6;
    }
  }

  var8 = [];

  foreach(var4 in var0) {
    var10 = 0;

    foreach(var6 in var2) {
      if(var4 == var6) {
        var10 = 1;
        break;
      }
    }

    if(!var10) {
      var8 = var4;
    }
  }

  return var8;
}

function isattachmentsniperscopedefault(var0, var1) {
  var2 = strtok(var0, "_");
  return isattachmentsniperscopedefaulttokenized(var2, var1);
}

function isattachmentsniperscopedefaulttokenized(var0, var1) {
  var2 = 0;

  if(var0.size && isDefined(var1)) {
    var3 = 0;

    if(var0[0] == "alt") {
      var3 = 1;
    }

    if(var0.size >= 3 + var3 && (var0[var3] == "iw6" || var0[var3] == "iw7")) {
      if(weaponclass(var0[var3] + "_" + var0[var3 + 1] + "_" + var0[var3 + 2]) == "sniper") {
        var2 = var0[var3 + 1] + "scope" == var1;
      }
    }
  }

  return var2;
}

function getweaponattachmentsbasenames(var0) {
  if(isstring(var0)) {
    if(var0 == "none") {
      return [];
    }
  } else if(var0.basename == "none") {
    return [];
  }

  var1 = getweaponattachments(var0);

  if(!isDefined(var1)) {
    return [];
  }

  foreach(var3 in var1) {
    var1 = attachmentmap_tobase(var3);
  }

  return var1;
}

function getattachmentbasenames(var0) {
  foreach(var2 in var0) {
    var0 = attachmentmap_tobase(var2);
  }

  return var0;
}

function getattachmentlist(var0, var1, var2, var3) {
  var4 = [];
  var5 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var6 = 0; var6 < var5; var6++) {
    var7 = tablelookupbyrow("mp/attachmenttable.csv", var6, 5);

    if(var7 == "") {
      continue;
    }

    var8 = tablelookupbyrow("mp/attachmenttable.csv", var6, 2);

    if(isDefined(var2) && (var8 == "none" || var8 == var2)) {
      continue;
    }

    if(isDefined(var3) && var8 != var3) {
      continue;
    }

    if(var1) {
      var9 = tablelookupbyrow("mp/attachmenttable.csv", var6, 4);
      var4 = var9;
      continue;
    }

    if(scripts\engine\utility::array_contains(var4, var7)) {
      continue;
    }

    var4 = var7;
  }

  return var4;
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

function attachmentmap_tobase(var0) {
  if(isDefined(level.attachmentmap_uniquetobase[var0])) {
    var0 = level.attachmentmap_uniquetobase[var0];
  }

  return var0;
}

function attachmentmap_toextra(var0) {
  var1 = undefined;

  if(isDefined(level.attachmentmap_uniquetoextra[var0])) {
    var1 = level.attachmentmap_uniquetoextra[var0];
  }

  return var1;
}

function mapweapon(var0, var1, var2) {
  var3 = var0;

  if(!isDefined(var0)) {
    var3 = isundefinedweapon();
  }

  var4 = 0;

  if(var3.basename != "none") {
    if(isDefined(var1) && !isPlayer(var1)) {
      var5 = getaltmodeweapon(var0);

      if(isDefined(var5)) {
        switch (var5) {
          case "glconc":
            var3 = getcompleteweaponname("concussion_grenade_mp");
            break;
          case "glflash":
            var3 = getcompleteweaponname("flash_grenade_mp");
            break;
          case "glsnap":
            var3 = getcompleteweaponname("snapshot_grenade_mp");
            break;
          case "glincendiary":
            var3 = getcompleteweaponname("thermite_mp");
            break;
        }
      }
    }

    switch (var3.basename) {
      case "pop_rocket_proj_mp":
        var3 = getcompleteweaponname("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        var3 = getcompleteweaponname("iw8_turret_50cal_mp");
        break;
      case "tur_bradley_mp":
      case "tur_gun_lighttank_mp":
        var3 = getcompleteweaponname("lighttank_tur_mp");
        break;
      case "tur_bradley_ks_mp":
      case "tur_gun_lighttank_ks_mp":
        var3 = getcompleteweaponname("lighttank_tur_ks_mp");
        break;
      case "ks_remote_drone_mp":
        var3 = isundefinedweapon();
        break;
    }
  } else if(isDefined(var1)) {
    if(isDefined(var1.objweapon)) {
      var3 = getcompleteweaponname(var1.objweapon.basename);
      var4 = 1;
    } else if(isDefined(var1.weapon_name)) {
      var3 = getcompleteweaponname(var1.weapon_name);
      var4 = 1;
    }
  }

  if(var4 && !istrue(var2)) {
    var3 = mapweapon(var3, var1, 1);
  }

  return var3;
}

function attachmentsfilterforstats(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(attachmentlogsstats(var4, var1)) {
      var2 = var4;
    }
  }

  return var2;
}

function attachmentlogsstats(var0, var1) {
  if(attachmentiscosmetic(var0)) {
    return false;
  }

  if(!carriedpunchcard(var1, var0)) {
    return false;
  }

  if(scripts\engine\utility::string_starts_with(var0, "laststand_")) {
    return false;
  }

  return true;
}

function weaponhasattachment(var0, var1) {
  var2 = getweaponattachmentsbasenames(var0);

  foreach(var4 in var2) {
    if(var4 == var1) {
      return true;
    }
  }

  return false;
}

function setrecoilscale(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = var0;
  } else {
    self.recoilscale += var0;
  }

  if(isDefined(var1)) {
    if(isDefined(self.recoilscale) && var1 < self.recoilscale) {
      var1 = self.recoilscale;
    }

    var2 = 100 - var1;
  } else {
    var2 = 100 - self.recoilscale;
  }

  var2 = int(clamp(var2, 0, 255));

  if(var2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var2);
}

function _launchgrenade(var0, var1, var2, var3, var4, var5) {
  var6 = self launchgrenade(var0, var1, var2, var3, var5);

  if(!isDefined(var4)) {
    var6.notthrown = 1;
  } else {
    var6.notthrown = var4;
  }

  var6 setotherent(self);
  return var6;
}

function grenadethrown(var0) {
  return !isDefined(var0.notthrown) || !var0.notthrown;
}

function grenadeinpullback() {
  return !nullweapon(self getheldoffhand());
}

function getgrenadeinpullback() {
  var0 = self getheldoffhand();

  if(isDefined(self.gestureweapon) && var0 == asmdevgetallstates(self.gestureweapon)) {
    var0 = isundefinedweapon();
  }

  return var0;
}

function weaponignoresblastshield(var0, var1) {
  var2 = var0.basename;

  if(issuperweapon(var2)) {
    return 1;
  }

  if(iskillstreakweapon(var2)) {
    return 1;
  }

  switch (var2) {
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

function weaponsupportslaserir(var0) {
  switch (var0) {
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

  if(iskillstreakweapon(var0)) {
    return false;
  }

  var1 = weaponclass(var0);
  return var1 == "rifle" || var1 == "mg" || var1 == "sniper" || var1 == "smg" || var1 == "spread";
}

function getweaponnvgattachment(var0) {
  return "laserir";
}

function issinglehitweapon(var0) {
  var0 = getweaponbasenamescript(var0);

  switch (var0) {
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

function attachmentiscosmetic(var0) {
  return isDefined(var0) && scripts\engine\utility::string_starts_with(var0, "cos_");
}

function carriedpunchcard(var0, var1) {
  var2 = getweaponrootname(var0);
  return carrier_cleanup(var2, var1);
}

function carrier_cleanup(var0, var1) {
  var2 = level.weaponattachments[var0];
  return isDefined(var2) && isDefined(var2[var1]);
}

function ref_12bbb(var0) {
  switch (var0) {
    case "laserads":
    case "laserbalanced":
    case "laserrange":
      var0 = "laser";
      break;
    case "barsil2":
    case "barsil":
    case "silencer4":
    case "silencer3":
    case "silencer2":
      var0 = "silencer";
      break;
    case "barcustnoguard":
    case "barcust2":
    case "barcust":
    case "barlong":
    case "barmid":
    case "barshortnoguard":
    case "barshort":
      var0 = "barlong";
      break;
  }

  return var0;
}

function ref_14584(var0) {
  var1 = "none";
  var2 = -1;
  var3 = getweaponrootname(var0);

  if(isDefined(var0) && !nullweapon(var0)) {
    var1 = weaponclass(var0);

    switch (var1) {
      case "pistol":
        var2 = 1;
        break;
      case "sniper":
        if(getweapongroup(var0) == "weapon_dmr") {
          if(var3 == "iw8_sn_kilo98" || var3 == "iw8_sn_romeo700" || var3 == "iw8_sn_t9crossbow" || var3 == "iw8_sn_crossbow") {
            var2 = 2;
          } else {
            var2 = 4;
          }
        } else if(var3 == "iw8_sn_t9accurate" || var3 == "s4_mr_kalpha98" || var3 == "iw8_sn_delta" || var3 == "iw8_sn_t9quickscope" || var3 == "iw8_sn_t9standard" || var3 == "s4_mr_aromeo99") {
          var2 = 6;
        } else if(var3 == "iw8_sn_xmike109" || var3 == "iw8_sn_t9powersemi" || var3 == "s4_mr_ptango41") {
          var2 = 3;
        } else {
          var2 = 5;
        }

        break;
      default:
        var2 = 0;
        break;
    }
  }

  return var2;
}

function isbombsiteweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
    case "bomb_site_mp":
    case "briefcase_bomb_mp":
      return true;
  }

  return false;
}

function iskillstreakweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[var1])) {
    return true;
  }

  return false;
}

function unsetreduceregendelayonkills(var0) {
  return isDefined(var0) && isDefined(var0.vehiclename) && isDefined(var0.streakinfo);
}

function weaponbypassspawnprotection(var0) {
  var1 = 1;
  var2 = undefined;

  if(issameweapon(var0)) {
    var2 = var0.basename;
  } else {
    var2 = var0;
  }

  if(iskillstreakweapon(var0) && var2 != "manual_turret_mp" && var2 != "pac_sentry_turret_mp" && !update_health_on_spawn(var2)) {
    var1 = 0;
  }

  return var1;
}

function isvehicleweapon(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
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

function isgesture(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  if(issubstr(var1, "ges_plyr")) {
    return 1;
  }

  if(issubstr(var1, "devilhorns_mp")) {
    return 1;
  }

  return 0;
}

function getweaponfullname(var0) {
  if(isstring(var0)) {
    return var0;
  }

  return createheadicon(var0);
}

function playdeatomizefx(var0, var1) {
  GscBinSkip1(0x45, 0, 0, "org", self gettagorigin("j_spineupper"));
}

function isprimaryweapon(var0) {
  if(nullweapon(var0)) {
    return 0;
  }

  if(var0.inventorytype != "primary" && var0.inventorytype != "altmode") {
    return 0;
  }

  switch (var0.classname) {
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

function update_health_bar_to_player(var0) {
  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var1;
  }

  return var1 == "iw8_knifestab_mp" || var1 == "iw8_knifestab_mp" || var1 == "iw8_throwingknife_fire_melee_mp" || var1 == "iw8_throwingknife_electric_melee_mp" || var1 == "iw8_throwingknife_drill_melee_mp";
}

function isknifeonly(var0) {
  return getweaponrootname(var0) == "iw8_knife";
}

function ismeleeonly(var0) {
  if(isstring(var0)) {}

  return var0.ismelee;
}

function isfistsonly(var0) {
  return getweaponrootname(var0) == "iw8_fists";
}

function isballweapon(var0) {
  return var0.basename == "iw8_cyberemp_mp" || var0.basename == "iw7_tdefball_mp";
}

function isaxeweapon(var0) {
  var1 = getweaponrootname(var0);
  return var1 == "iw7_axe" || var1 == "s4_me_icepick" || var1 == "s4_me_axe";
}

function validatefuelstability(var0, var1) {
  return isaxeweapon(var0) && isDefined(var1.classname) && var1.classname == "grenade";
}

function turret_aimed_at_last_known(var0) {
  return getweaponrootname(var0) == "iw8_me_akimboblunt" || getweaponrootname(var0) == "iw8_me_akimboblades";
}

function isthrowingknife(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    if(nullweapon(var0)) {
      return 0;
    }

    var1 = var0.basename;
  } else {
    if(var0 == "none") {
      return 0;
    }

    var1 = var0;
  }

  return issubstr(var1, "throwingknife");
}

function isspecialmeleeweapon(var0) {
  if(update_health_bar_to_player(var0)) {
    return true;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    if(nullweapon(var0)) {
      return false;
    }

    var1 = var0.basename;
  } else {
    if(var0 == "none") {
      return false;
    }

    var1 = var0;
  }

  return var1 == "iw8_fists_mp_ls";
}

function unset_relic_mythic(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    if(nullweapon(var0)) {
      return false;
    }

    var1 = var0.basename;
  } else {
    if(var0 == "none") {
      return false;
    }

    var1 = var0;
  }

  return var1 == "iw8_gunless" || var1 == "iw8_gunless_infil" || var1 == "iw8_gunless_last_stand_enter";
}

function update_health_on_spawn(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    if(nullweapon(var0)) {
      return false;
    }

    var1 = var0.basename;
  } else {
    if(var0 == "none") {
      return false;
    }

    var1 = var0;
  }

  return var1 == "iw8_minigunksjugg_mp" || var1 == "iw8_minigunksjugg_reload_mp" || var1 == "iw8_lm_dblmg_mp";
}

function unset_jugg_ignoreall_after_notify(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    if(nullweapon(var0)) {
      return false;
    }

    var1 = var0.basename;
  } else {
    if(var0 == "none") {
      return false;
    }

    var1 = var0;
  }

  return var1 == "iw8_sn_t9explosivebow_mp";
}

function infiniteammothread(var0, var1) {
  self endon("death_or_disconnect");
  self endon("stop_infinite_ammo_thread");
  jumpiftrue(isDefined(var0)) LOC_0000001e;
  var0 = level.framedurationseconds;

  for(;;) {
    if(!isDefined(var1)) {
      var1 = self.equippedweapons;
    }

    foreach(var3 in var1) {
      self givemaxammo(var3);
      self setweaponammoclip(var3, weaponclipsize(var3));
    }

    wait var0;
  }
}

function stopinfiniteammothread() {
  self notify("stop_infinite_ammo_thread");
}

function russianletter(var0) {
  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_weapontoscriptable) && isDefined(level.br_pickups.delay_hide_player_clip)) {
    var1 = createheadicon(var0);
    var2 = level.br_pickups.br_weapontoscriptable[var1];

    if(isDefined(var2)) {
      return level.br_pickups.delay_hide_player_clip[var2];
    }
  }

  var3 = scripts\mp\loot::getlootinfoforweapon(var0.basename, var0.variantid);

  if(isDefined(var3)) {
    return var3.quality;
  }

  return undefined;
}

function safe_to_authenticate(var0) {
  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_weapontoscriptable) && isDefined(level.br_pickups.delay_hide_player_clip)) {
    var1 = createheadicon(var0);
    var2 = level.br_pickups.br_weapontoscriptable[var1];

    if(isDefined(var2)) {
      return level.br_pickups.delay_hide_player_clip[var2];
    }
  }

  return undefined;
}

function unset_relic_damage_from_above(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = getweaponbasename(var0);
  } else {
    var1 = var0;
  }

  switch (var1) {
    case "manual_turret_flak_vehicle":
    case "manual_turret_flak_mp":
    case "manual_turret_flak_mp_highrof":
      return 1;
    default:
      return 0;
  }
}
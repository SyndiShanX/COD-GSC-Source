/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\validation.gsc
***********************************************/

#using script_5c80e17482acb972;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\loot;
#using scripts\mp\perks\perks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#namespace validation;

function validationerror(errortype, slot, item) {
  errorstring = errortype;

  if(isDefined(slot)) {
    errorstring = errorstring + "_" + slot;
  }

  if(isDefined(item)) {
    errorstring = errorstring + " - " + item;
  }

  if(getdvarint(@ "hash_58bbcc3e1ff538d1", 0) == 1) {
    println(errorstring);
  }

  if(getdvarint(@ "hash_49f347129c31c40c", 0) == 1) {
    assertmsg(errorstring);
  }

  if(getdvarint(@ "hash_93c750a2b4a79e93", 0) == 1) {
    scripts\mp\class::recordvalidationinfraction();
  }
}

function isvalidattachmentunlock(weaponrootname, attachmentbasename) {
  var_338c04a2f19ba8b6 = getdvarint(@ "scr_checkvalidattachmentunlock", 0) == 1;

  if(var_338c04a2f19ba8b6) {
    return attachmentisselectablerootname(weaponrootname, attachmentbasename);
  }

  return 1;
}

function function_f6d25a34b1d286b1() {
  var_cfbd5dfab1e96cb1 = getdvarint(@ "hash_838359d5ebdcc7e0", 0);

  if(var_cfbd5dfab1e96cb1 == 0) {
    return;
  }

  for(loadoutindex = 0; loadoutindex < 12; loadoutindex++) {
    loadoutisinuse = self getplayerdata(level.loadoutdata, "squadMembers", "loadouts", loadoutindex, "inUse");

    if(loadoutisinuse == 1) {
      for(weaponindex = 0; weaponindex < 2; weaponindex++) {
        weaponname = scripts\mp\class::cac_getweapon(loadoutindex, weaponindex);
        weaponvariantid = scripts\mp\class::cac_getweaponvariantid(loadoutindex, weaponindex);
        weaponlootitemid = scripts\mp\class::cac_getweaponlootitemid(loadoutindex, weaponindex);
        attachments = [];
        attachmentsids = [];
        maxattachments = ter_op(weaponindex == 0, scripts\mp\class::getmaxprimaryattachments(), scripts\mp\class::getmaxsecondaryattachments());
        var_6c85232fcab7882d = ter_op(weaponindex == 0, scripts\mp\class::function_ed8babbe1912171f(), scripts\mp\class::function_fba1013e19eb56c3());

        for(attachmentindex = 0; attachmentindex < maxattachments; attachmentindex++) {
          attachmentname = scripts\mp\class::cac_getweaponattachment(loadoutindex, weaponindex, attachmentindex);
          attachments[attachmentindex] = attachmentname;
          attachmentsids[attachmentindex] = scripts\mp\class::cac_getweaponattachmentid(loadoutindex, weaponindex, attachmentindex);
        }

        camoname = scripts\mp\class::cac_getweaponcamo(loadoutindex, weaponindex);
        var_bd1db6dd9710a427 = scripts\mp\class::cac_getweaponcosmeticattachment(loadoutindex, weaponindex);
        stickers = [];

        for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < var_6c85232fcab7882d; var_36d2abbdcbcb186c++) {
          stickers[var_36d2abbdcbcb186c] = scripts\mp\class::cac_getweaponsticker(loadoutindex, weaponindex, var_36d2abbdcbcb186c);
        }

        function_503f87754be2d15c(weaponname, weaponvariantid, weaponlootitemid, attachments, attachmentsids, camoname, var_bd1db6dd9710a427, stickers);
      }
    }
  }
}

function function_18b8c4c4fa0f6d1c(weaponname, weaponcamo) {
  category = getscriptbundlefieldvalue(hashcat(%"hash_1345cc24140e89b8", weaponcamo), #"camocategory");

  if(isDefined(category) && category == "camo_category_completion") {
    if(isDefined(level.weaponmappedcamos[weaponname]) && isDefined(level.weaponmappedcamos[weaponname][weaponcamo])) {
      return level.weaponmappedcamos[weaponname][weaponcamo];
    } else {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref(weaponcamo);

      if(lootid == 0) {
        scripts\mp\utility\script::demoforcesre("getCamoLootID: weaponName/weaponCamo [" + weaponname + "/" + weaponcamo + "] not in level.weaponMappedCamos");
      }

      return lootid;
    }

    return;
  }

  if(isDefined(category) && category == "camo_category_events") {
    weaponclass = "";
    weaponscriptbundle = scripts\cp_mp\weapon::function_8477d8595e0364a7(weaponname, [#"menuclass"]);

    if(isDefined(weaponscriptbundle)) {
      weaponclass = weaponscriptbundle.menuclass;
    }

    if(isDefined(weaponclass) && weaponclass != "" && isDefined(level.weaponmappedcamos[weaponclass]) && isDefined(level.weaponmappedcamos[weaponclass][weaponcamo])) {
      return level.weaponmappedcamos[weaponclass][weaponcamo];
    } else {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref(weaponcamo);

      if(lootid == 0) {
        scripts\mp\utility\script::demoforcesre("getCamoLootID: weaponName/weaponCamo [" + weaponname + "/" + weaponcamo + "] not in level.weaponMappedCamos");
      }

      return lootid;
    }

    return;
  }

  return scripts\cp_mp\utility\loot::getlootidfromref(weaponcamo);
}

function function_2c4d04305e3c9601(weaponlootid) {
  if(getdvarint(@ "hash_272c95c93da464bb", 0) == 0) {
    return false;
  }

  var_e7a7288f46dee8e7 = [11354, 11344, 11338, 11352, 11318, 11337, 11340, 11323, 11331, 11307, 11317, 11324, 11328, 11351, 11357, 11355, 11315, 11367, 11320, 11353];
  var_4b40391f47f1d3ea = [11354, 11356, 11374, 11344, 11317, 11352];

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    foreach(var_8c996f399d5e3282 in var_e7a7288f46dee8e7) {
      if(var_8c996f399d5e3282 == weaponlootid) {
        return true;
      }
    }
  } else if(scripts\common\utility::ismp() || scripts\common\utility::iscp()) {
    foreach(var_8c996f399d5e3282 in var_4b40391f47f1d3ea) {
      if(var_8c996f399d5e3282 == weaponlootid) {
        return true;
      }
    }
  }

  return false;
}

function function_503f87754be2d15c(weaponname, weaponvariantid, weaponlootitemid, attachments, attachmentsids, camoname, var_bd1db6dd9710a427, stickers) {
  var_4a654bd9a395c1ff = [];
  var_a4146e4eaf636ef2 = getdvarint(@ "hash_c876f19dd06eb2cf", 0);
  var_989c8eafe834f9de = weaponvariantid != 0;
  weaponvariantkey = weaponname + "|" + weaponvariantid;
  var_fe506348d9341132 = 0;

  if(weaponlootitemid != 0) {
    var_fe506348d9341132 = weaponlootitemid;
  } else if(isDefined(level.weaponmapdata[weaponname])) {
    var_fe506348d9341132 = level.weaponmapdata[weaponname].weaponlootid;
  }

  if(!function_2c4d04305e3c9601(var_fe506348d9341132)) {
    var_4a654bd9a395c1ff[var_4a654bd9a395c1ff.size] = var_fe506348d9341132;
  }

  weaponclass = "";
  weaponscriptbundle = scripts\cp_mp\weapon::function_8477d8595e0364a7(weaponname, [#"menuclass"]);

  if(isDefined(weaponscriptbundle)) {
    weaponclass = weaponscriptbundle.menuclass;
  }

  if(isDefined(weaponclass) && weaponclass != "weapon_melee" && weaponclass != "weapon_melee2") {
    var_ad61ffb38ec2a6b0 = getweapondefaultattachments(getdefaultweaponbasename(weaponname));

    foreach(attachmentindex, attachmentname in attachments) {
      if(attachmentname != "none") {
        var_763d626a0644c430 = 1;

        if(var_a4146e4eaf636ef2 == 1 && isattachmentironsdefault(attachmentname)) {
          continue;
        }

        if(attachmentsids[attachmentindex] != 0) {
          weaponbasename = getdefaultweaponbasename(weaponname);
          blueprints = function_4527f44d851c9afd(weaponbasename, attachmentname);

          foreach(variantindex, attachmentdata in blueprints) {
            if(variantindex == attachmentsids[attachmentindex] && isDefined(attachmentdata)) {
              var_4a654bd9a395c1ff[var_4a654bd9a395c1ff.size] = attachmentdata.lootid;

              if(var_989c8eafe834f9de && isDefined(level.weaponlootmapdata) && isDefined(level.weaponlootmapdata[weaponvariantkey]) && isDefined(level.weaponlootmapdata[weaponvariantkey].attachdefaulttoidmap[attachmentname]) && level.weaponlootmapdata[weaponvariantkey].attachdefaulttoidmap[attachmentname] == variantindex) {
                var_763d626a0644c430 = 0;
              }

              break;
            }
          }
        }

        if(var_763d626a0644c430) {
          attachmentcategory = getscriptbundlefieldvalue(hashcat(%"hash_3c2c9813bb16552f", attachmentname), #"category");

          if(attachmentcategory == "RECEIVER") {
            continue;
          }

          isdefaultattachment = 0;

          foreach(var_c7b8980d348eb4dc in var_ad61ffb38ec2a6b0) {
            if(var_c7b8980d348eb4dc == attachmentname) {
              isdefaultattachment = 1;
              break;
            }
          }

          if(isdefaultattachment) {
            continue;
          }

          attachmentscriptbundle = getscriptbundle(hashcat(%"hash_3c2c9813bb16552f", attachmentname));

          if(isDefined(attachmentscriptbundle)) {
            var_4a654bd9a395c1ff[var_4a654bd9a395c1ff.size] = attachmentscriptbundle.lootid;
          }
        }
      }
    }
  }

  camoid = function_18b8c4c4fa0f6d1c(weaponname, camoname);
  var_4a654bd9a395c1ff[var_4a654bd9a395c1ff.size] = camoid;
  charmid = scripts\cp_mp\utility\loot::getlootidfromref(var_bd1db6dd9710a427);
  var_4a654bd9a395c1ff[var_4a654bd9a395c1ff.size] = charmid;

  foreach(sticker in stickers) {
    if(sticker != "none") {
      stickerlootid = scripts\cp_mp\utility\loot::getlootidfromref(sticker);
      var_4a654bd9a395c1ff[var_4a654bd9a395c1ff.size] = stickerlootid;
    }
  }

  self function_616c0ca219597829(var_4a654bd9a395c1ff);
}

function function_5a92673db4ece37f(classstruct) {
  var_cfbd5dfab1e96cb1 = getdvarint(@ "hash_838359d5ebdcc7e0", 0);

  if(var_cfbd5dfab1e96cb1 == 0) {
    return;
  }

  if(utility::iscp() || scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.leagueplaymatch || !level.rankedmatch || !level.matchmakingmatch || !level.onlinestatsenabled) {
    return;
  }

  function_503f87754be2d15c(classstruct.loadoutprimary, classstruct.loadoutprimaryvariantid, classstruct.loadoutprimarylootitemid, classstruct.loadoutprimaryattachments, classstruct.loadoutprimaryattachmentids, classstruct.loadoutprimarycamo, classstruct.loadoutprimarycosmeticattachment, classstruct.loadoutprimarystickers);
  function_503f87754be2d15c(classstruct.loadoutsecondary, classstruct.loadoutsecondaryvariantid, classstruct.loadoutsecondarylootitemid, classstruct.loadoutsecondaryattachments, classstruct.loadoutsecondaryattachmentids, classstruct.loadoutsecondarycamo, classstruct.loadoutsecondarycosmeticattachment, classstruct.loadoutsecondarystickers);
}

function validateloadout(loadout) {
  if(getdvarint(@ "hash_955ca650f9a9bdef", 0) == 1) {
    return loadout;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && (getsubgametype() == "dmz" || getsubgametype() == "exgm") && getdvarint(@ "ui_use_dmz_loadouts", 0) == 1) {
    return loadout;
  }

  var_8b3060936146ce59 = isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_e12ed09bf2e43167);
  var_60dc2c23348c27e = 0;

  if(var_8b3060936146ce59) {
    loadout = namespace_89e4915e27d8b4fc::overrideweapons(loadout);
    vestperk = namespace_89e4915e27d8b4fc::function_ec995ec88ab7fb6c(loadout);

    if(vestperk == "specialty_null" && istrue(level.allowperks)) {
      var_60dc2c23348c27e = 1;
    }
  }

  fallbackloadout = function_9480a79a4852090f();
  function_5a92673db4ece37f(loadout);
  replaceweapon = 0;

  if(!function_89497fa763d431c0(loadout.loadoutprimary)) {
    replaceweapon = 1;
  } else if(isweaponuihidden(loadout.loadoutprimary)) {
    replaceweapon = 1;
  }

  var_de6cf437be756ee1 = istrue(getdvarint(@ "scr_loadout_validate_banned_items", 0));

  if(var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(loadout.loadoutprimary)) {
    replaceweapon = 1;
  }

  underkillperkname = "specialty_underkill";
  var_6940a6d9400f329b = !perkisrestricted(underkillperkname) && array_contains(loadout.loadoutperks, underkillperkname);

  if(var_8b3060936146ce59 && loadout.loadoutprimary != "none" && level.perkbundles[vestperk].var_885724e5007453be.primary == 0) {
    var_60dc2c23348c27e = 1;
  }

  if(!var_8b3060936146ce59 && !iscacprimaryweapon(loadout.loadoutprimary) && !var_6940a6d9400f329b) {
    replaceweapon = 1;
  }

  var_bc72f32b1575d517 = 0;
  var_e1388376a5be9b75 = 0;
  primaryweaponclass = function_b8811a0fc04e4b9d(loadout.loadoutprimary, #"menuclass");

  if(weaponisrestricted(loadout.loadoutprimary) || isDefined(primaryweaponclass) && weaponclassisrestricted(primaryweaponclass)) {
    replaceweapon = 1;
    var_bc72f32b1575d517 = 1;
  }

  var_121e73d335b0a04c = getdvarint(@ "hash_ba24827ea58aa4aa", 1);
  var_dc7742ef149dccd4 = strtok(getDvar(@ "scr_validate_required_attachments_list", ""), ",");

  if(replaceweapon) {
    loadout = replaceprimaryweapon(loadout);
  } else {
    if(isweaponvariantlocked(loadout.loadoutprimary, loadout.loadoutprimaryvariantid)) {
      loadout.loadoutprimaryvariantid = -1;
    }

    tempweapon = buildweapon(loadout.loadoutprimary, loadout.loadoutprimaryattachments);

    for(i = 0; i < loadout.loadoutprimaryattachments.size; i++) {
      attachment = loadout.loadoutprimaryattachments[i];

      if(attachment != "none") {
        attachmentscriptbundle = getscriptbundle(hashcat(%"hash_3c2c9813bb16552f", attachment));

        if(attachmentisrestricted(attachment, loadout.loadoutprimary) || var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(attachment)) {
          if(isDefined(attachmentscriptbundle) && attachmentscriptbundle.isamp) {
            for(j = 0; j < loadout.loadoutprimaryattachments.size; j++) {
              loadout.loadoutprimaryattachments[j] = "none";
            }

            break;
          }

          loadout.loadoutprimaryattachments[i] = "none";
          var_e1388376a5be9b75 = 1;
          tempweapon = buildweapon(loadout.loadoutprimary, loadout.loadoutprimaryattachments);
          continue;
        }

        if(var_121e73d335b0a04c && (var_dc7742ef149dccd4.size == 0 || arraycontains(var_dc7742ef149dccd4, attachment))) {
          var_ea9750936cb9726b = 0;
          var_d30865ebf0ce910e = function_6dc98654fb071228(getdefaultweaponbasename(loadout.loadoutprimary), attachment);

          foreach(var_8630243a2ab728c9 in var_d30865ebf0ce910e) {
            if(!tempweapon hasattachment(var_8630243a2ab728c9)) {
              var_ea9750936cb9726b = 1;
              break;
            }
          }

          if(var_ea9750936cb9726b) {
            loadout.loadoutprimaryattachments[i] = "none";
            tempweapon = buildweapon(loadout.loadoutprimary, loadout.loadoutprimaryattachments);
          }
        }
      }
    }
  }

  replaceweapon = 0;

  if(!function_89497fa763d431c0(loadout.loadoutsecondary)) {
    replaceweapon = 1;
  } else if(isweaponuihidden(loadout.loadoutsecondary)) {
    replaceweapon = 1;
  }

  if(var_8b3060936146ce59 && loadout.loadoutsecondary != "none" && level.perkbundles[vestperk].var_885724e5007453be.secondary == 0) {
    var_60dc2c23348c27e = 1;
  }

  if(var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(loadout.loadoutsecondary)) {
    replaceweapon = 1;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && !var_8b3060936146ce59) {
    overkillperkname = "specialty_munitions_2";
    var_df3d6a2ffc2e83c1 = !perkisrestricted(overkillperkname) && array_contains(loadout.loadoutperks, overkillperkname);

    if(iscacprimaryweapon(loadout.loadoutsecondary) && !var_df3d6a2ffc2e83c1) {
      replaceweapon = 1;
    }
  }

  secondaryweaponclass = function_b8811a0fc04e4b9d(loadout.loadoutsecondary, #"menuclass");

  if(weaponisrestricted(loadout.loadoutsecondary) || isDefined(secondaryweaponclass) && weaponclassisrestricted(secondaryweaponclass)) {
    replaceweapon = 1;
    var_bc72f32b1575d517 = 1;
  }

  if(replaceweapon) {
    loadout = replacesecondaryweapon(loadout);
  } else {
    if(isweaponvariantlocked(loadout.loadoutsecondary, loadout.loadoutsecondaryvariantid)) {
      loadout.loadoutsecondaryvariantid = -1;
    }

    tempweapon = buildweapon(loadout.loadoutsecondary, loadout.loadoutsecondaryattachments);

    for(i = 0; i < loadout.loadoutsecondaryattachments.size; i++) {
      attachment = loadout.loadoutsecondaryattachments[i];

      if(attachment != "none") {
        if(attachmentisrestricted(attachment, loadout.loadoutsecondary) || var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(attachment)) {
          attachmentscriptbundle = getscriptbundle(hashcat(%"hash_3c2c9813bb16552f", attachment));

          if(isDefined(attachmentscriptbundle) && attachmentscriptbundle.isamp) {
            for(j = 0; j < loadout.loadoutsecondaryattachments.size; j++) {
              loadout.loadoutsecondaryattachments[j] = "none";
            }

            break;
          }

          loadout.loadoutsecondaryattachments[i] = "none";
          var_e1388376a5be9b75 = 1;
          tempweapon = buildweapon(loadout.loadoutsecondary, loadout.loadoutsecondaryattachments);
          continue;
        }

        if(var_121e73d335b0a04c && (var_dc7742ef149dccd4.size == 0 || arraycontains(var_dc7742ef149dccd4, attachment))) {
          var_ea9750936cb9726b = 0;
          var_d30865ebf0ce910e = function_6dc98654fb071228(getdefaultweaponbasename(loadout.loadoutsecondary), attachment);

          foreach(var_8630243a2ab728c9 in var_d30865ebf0ce910e) {
            if(!tempweapon hasattachment(var_8630243a2ab728c9)) {
              var_ea9750936cb9726b = 1;
              break;
            }
          }

          if(var_ea9750936cb9726b) {
            loadout.loadoutsecondaryattachments[i] = "none";
            tempweapon = buildweapon(loadout.loadoutsecondary, loadout.loadoutsecondaryattachments);
          }
        }
      }
    }
  }

  if(istrue(level.tertiaryweaponslotenabled)) {}

  var_5e76ad052ba12845 = 0;
  var_a0f3cd42271b8f4a = getmatchrulesdata("commonOption", "replaceIndividualRestrictedPerks");
  var_cf6e4e07bffcbf2e = 0;
  var_cd857b8539e7f332 = 0;
  var_3e44eb1af492ae49 = 0;
  var_55b5518be09f25f5 = 0;
  var_5e6c1f1aa70d60ce = 0;
  var_442df125f92806b2 = [];
  var_cfca7aa9f4fab29 = [];

  foreach(idx, perk in loadout.loadoutperks) {
    banned = var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(perk);

    if(banned) {
      if(var_8b3060936146ce59) {
        var_cfca7aa9f4fab29[var_cfca7aa9f4fab29.size] = perk;
      } else {
        var_5e76ad052ba12845 = 1;
      }

      continue;
    }

    if(!function_f45c19871b412ea5(perk)) {
      continue;
    }

    slot = scripts\mp\perks\perks::getperkslot(perk);

    if(var_8b3060936146ce59 && isDefined(perk) && isDefined(level.perkbundles[perk])) {
      if(!namespace_89e4915e27d8b4fc::function_8cdbad2a3681247e(perk, vestperk)) {
        var_60dc2c23348c27e = 1;
        var_5e6c1f1aa70d60ce = 1;
        break;
      }

      if(level.perkbundles[perk].var_70774aeb81261100 == "vest") {
        var_cf6e4e07bffcbf2e += 1;
      } else if(level.perkbundles[perk].var_70774aeb81261100 == "gloves") {
        var_cd857b8539e7f332 += 1;
      } else if(level.perkbundles[perk].var_70774aeb81261100 == "footwear") {
        var_3e44eb1af492ae49 += 1;
      } else if(level.perkbundles[perk].var_70774aeb81261100 == "gear") {
        var_55b5518be09f25f5 += 1;
        var_442df125f92806b2[var_442df125f92806b2.size] = perk;
      }
    }

    if(isDefined(fallbackloadout.perks) && !isDefined(slot)) {
      var_5e76ad052ba12845 = 1;
      break;
    }

    if(perkisrestricted(perk) || isDefined(level.var_b6883bde144a226e) && ![[level.var_b6883bde144a226e]](perk)) {
      if(var_a0f3cd42271b8f4a) {
        if(idx < fallbackloadout.perks.size) {
          loadout.loadoutperks[idx] = fallbackloadout.perks[idx];
        }

        continue;
      }

      var_5e76ad052ba12845 = 1;
      break;
    }
  }

  if(var_8b3060936146ce59) {
    foreach(var_d2c4eb6f370de4d in var_cfca7aa9f4fab29) {
      if(isDefined(level.perkbundles[var_d2c4eb6f370de4d])) {
        var_70774aeb81261100 = level.perkbundles[var_d2c4eb6f370de4d].var_70774aeb81261100;

        if(var_70774aeb81261100 == "vest") {
          var_60dc2c23348c27e = 1;
          var_5e6c1f1aa70d60ce = 1;
          break;
        } else if(var_70774aeb81261100 == "gloves") {
          var_cd11aa2ab4e50561 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(getdvarint(@ "hash_b3bbb60b1e889be1", 27383));

          if(!isDefined(var_cd11aa2ab4e50561) || var_cd11aa2ab4e50561 == "") {
            assertmsg("<dev string:x1c>");
            var_60dc2c23348c27e = 1;
            var_5e6c1f1aa70d60ce = 1;
            break;
          }

          idx = array_find(loadout.loadoutperks, var_d2c4eb6f370de4d);
          loadout.loadoutperks[idx] = var_cd11aa2ab4e50561;
          continue;
        } else if(var_70774aeb81261100 == "footwear") {
          var_3d608179cc46a728 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(getdvarint(@ "hash_53905541db28577e", 27380));

          if(!isDefined(var_3d608179cc46a728) || var_3d608179cc46a728 == "") {
            assertmsg("<dev string:x46>");
            var_60dc2c23348c27e = 1;
            var_5e6c1f1aa70d60ce = 1;
            break;
          }

          idx = array_find(loadout.loadoutperks, var_d2c4eb6f370de4d);
          loadout.loadoutperks[idx] = var_3d608179cc46a728;
          continue;
        } else if(var_70774aeb81261100 == "gear") {
          var_2270803e1bea8673 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(getdvarint(@ "hash_4b76b53b637fdc12", 27396));
          var_2270813e1bea88a6 = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(getdvarint(@ "hash_526440cce2f5bb00", 27367));

          if(!isDefined(var_2270803e1bea8673) || var_2270803e1bea8673 == "") {
            assertmsg("<dev string:x72>");
            var_60dc2c23348c27e = 1;
            var_5e6c1f1aa70d60ce = 1;
            break;
          }

          if(!isDefined(var_2270813e1bea88a6) || var_2270813e1bea88a6 == "") {
            assertmsg("<dev string:x9a>");
            var_60dc2c23348c27e = 1;
            var_5e6c1f1aa70d60ce = 1;
            break;
          }

          var_3ca5dd53c6c1aaf0 = var_2270803e1bea8673;

          if(isDefined(array_find(loadout.loadoutperks, var_2270803e1bea8673))) {
            var_3ca5dd53c6c1aaf0 = var_2270813e1bea88a6;
          }

          idx = array_find(loadout.loadoutperks, var_d2c4eb6f370de4d);
          loadout.loadoutperks[idx] = var_3ca5dd53c6c1aaf0;
          continue;
        }
      }

      loadout.loadoutperks = array_remove(loadout.loadoutperks, var_d2c4eb6f370de4d);
    }

    if(var_cf6e4e07bffcbf2e > 1 || var_cd857b8539e7f332 > 1 || var_3e44eb1af492ae49 > 1 || var_55b5518be09f25f5 > 2) {
      var_60dc2c23348c27e = 1;
      var_5e6c1f1aa70d60ce = 1;
    } else if(var_55b5518be09f25f5 == 2 && (level.perkbundles[vestperk].var_885724e5007453be.gearone == 0 || level.perkbundles[vestperk].var_885724e5007453be.geartwo == 0)) {
      if(level.perkbundles[vestperk].var_885724e5007453be.gearone == 0 && level.perkbundles[vestperk].var_885724e5007453be.geartwo == 0) {
        loadout.loadoutperks = array_remove(loadout.loadoutperks, var_442df125f92806b2[0]);
        loadout.loadoutperks = array_remove(loadout.loadoutperks, var_442df125f92806b2[1]);
      } else {
        loadout.loadoutperks = array_remove(loadout.loadoutperks, var_442df125f92806b2[1]);
      }
    }
  }

  if(!isDefined(loadout.loadoutperks) || var_5e76ad052ba12845 == 1) {
    if(var_8b3060936146ce59) {
      var_60dc2c23348c27e = 1;
      var_5e6c1f1aa70d60ce = 1;
    } else {
      loadout = function_5e76ad052ba12845(loadout);
    }
  }

  if(killstreakisrestricted("specialist_perk_1") || killstreakisrestricted("specialist_perk_2") || killstreakisrestricted("specialist_perk_3")) {
    loadout.loadoutusingspecialist = 0;
  }

  if(var_8b3060936146ce59) {
    if(loadout.loadoutequipmentprimary != "none") {
      if(level.perkbundles[vestperk].var_885724e5007453be.lethal == 0) {
        var_60dc2c23348c27e = 1;
      } else if(!scripts\mp\equipment::isequipmentprimary(loadout.loadoutequipmentprimary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutequipmentprimary) || equipmentisrestricted(loadout.loadoutequipmentprimary)) {
        loadout = namespace_89e4915e27d8b4fc::function_625a1bdd25647c6b(loadout);
      }
    } else if(loadout.loadoutextraequipmentprimary != 0) {
      if(level.perkbundles[vestperk].var_885724e5007453be.lethaltwo == 0) {
        var_60dc2c23348c27e = 1;
      } else if(!scripts\mp\equipment::isequipmentprimary(loadout.loadoutextraequipmentprimary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutextraequipmentprimary) || equipmentisrestricted(loadout.loadoutextraequipmentprimary)) {
        loadout = namespace_89e4915e27d8b4fc::function_625a1bdd25647c6b(loadout);
      }
    }
  } else if(!scripts\mp\equipment::isequipmentprimary(loadout.loadoutequipmentprimary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutequipmentprimary)) {
    loadout.loadoutequipmentprimary = fallbackloadout.var_223912952e2fcaa5;
  } else if(equipmentisrestricted(loadout.loadoutequipmentprimary)) {
    loadout.loadoutequipmentprimary = fallbackloadout.var_223912952e2fcaa5;
    var_bc72f32b1575d517 = 1;
  }

  if(var_8b3060936146ce59) {
    if(loadout.loadoutequipmentsecondary != "none") {
      if(level.perkbundles[vestperk].var_885724e5007453be.tactical == 0) {
        var_60dc2c23348c27e = 1;
      } else if(!scripts\mp\equipment::isequipmentsecondary(loadout.loadoutequipmentsecondary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutequipmentsecondary) || equipmentisrestricted(loadout.loadoutequipmentsecondary)) {
        loadout = namespace_89e4915e27d8b4fc::function_1ccfa7dccda7da0f(loadout);
      }
    } else if(loadout.loadoutextraequipmentsecondary != 0) {
      if(level.perkbundles[vestperk].var_885724e5007453be.tacticaltwo == 0) {
        var_60dc2c23348c27e = 1;
      } else if(!scripts\mp\equipment::isequipmentsecondary(loadout.loadoutextraequipmentsecondary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutextraequipmentsecondary) || equipmentisrestricted(loadout.loadoutextraequipmentsecondary)) {
        loadout = namespace_89e4915e27d8b4fc::function_1ccfa7dccda7da0f(loadout);
      }
    }
  } else if(!scripts\mp\equipment::isequipmentsecondary(loadout.loadoutequipmentsecondary) || !scripts\mp\equipment::isequipmentselectable(loadout.loadoutequipmentsecondary)) {
    loadout.loadoutequipmentsecondary = fallbackloadout.var_56507f15843909c5;
  } else if(equipmentisrestricted(loadout.loadoutequipmentsecondary)) {
    loadout.loadoutequipmentsecondary = fallbackloadout.var_56507f15843909c5;
    var_bc72f32b1575d517 = 1;
  }

  if(var_8b3060936146ce59) {
    if(level.perkbundles[vestperk].var_885724e5007453be.super == 0) {
      if(loadout.loadoutfieldupgrade1 != "none") {
        var_60dc2c23348c27e = 1;
      }
    } else {
      banned = var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(loadout.loadoutfieldupgrade1);

      if(banned) {
        loadout = namespace_89e4915e27d8b4fc::overridesuper(loadout);
      }
    }
  }

  replacekillstreaks = 0;

  for(i = 0; i < 3; i++) {
    if(killstreakisrestricted(fallbackloadout.fallbackkillstreaks[i])) {
      var_35bd18d6d22e7106[i] = "none";
    }
  }

  if(!isanymlgmatch() && (loadout.loadoutkillstreak1 == "none" || loadout.loadoutkillstreak2 == "none" || loadout.loadoutkillstreak3 == "none")) {
    replacekillstreaks = 1;
  }

  if(!replacekillstreaks) {
    bundle = level.streakglobals.streakbundles[loadout.loadoutkillstreak1];

    if(!(isanymlgmatch() && loadout.loadoutkillstreak1 == "none") && (!isDefined(bundle) || !isDefined(bundle.showninmenu) || !bundle.showninmenu)) {
      replacekillstreaks = 1;
    }

    bundle = level.streakglobals.streakbundles[loadout.loadoutkillstreak2];

    if(!(isanymlgmatch() && loadout.loadoutkillstreak2 == "none") && (!isDefined(bundle) || !isDefined(bundle.showninmenu) || !bundle.showninmenu)) {
      replacekillstreaks = 1;
    }

    bundle = level.streakglobals.streakbundles[loadout.loadoutkillstreak3];

    if(!(isanymlgmatch() && loadout.loadoutkillstreak3 == "none") && (!isDefined(bundle) || !isDefined(bundle.showninmenu) || !bundle.showninmenu)) {
      replacekillstreaks = 1;
    }
  }

  if(!replacekillstreaks) {
    if(killstreakisrestricted(loadout.loadoutkillstreak1) || var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(loadout.loadoutkillstreak1)) {
      loadout.loadoutkillstreak1 = fallbackloadout.fallbackkillstreaks[0];
      var_bc72f32b1575d517 = 1;
    }

    if(killstreakisrestricted(loadout.loadoutkillstreak2) || var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(loadout.loadoutkillstreak2)) {
      loadout.loadoutkillstreak2 = fallbackloadout.fallbackkillstreaks[1];
      var_bc72f32b1575d517 = 1;
    }

    if(killstreakisrestricted(loadout.loadoutkillstreak3) || var_de6cf437be756ee1 && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4(loadout.loadoutkillstreak3)) {
      loadout.loadoutkillstreak3 = fallbackloadout.fallbackkillstreaks[2];
      var_bc72f32b1575d517 = 1;
    }
  }

  if(!replacekillstreaks) {
    if(loadout.loadoutkillstreak1 == loadout.loadoutkillstreak2 && loadout.loadoutkillstreak1 != "none") {
      replacekillstreaks = 1;
    } else if(loadout.loadoutkillstreak1 == loadout.loadoutkillstreak3 && loadout.loadoutkillstreak1 != "none") {
      replacekillstreaks = 1;
    } else if(loadout.loadoutkillstreak2 == loadout.loadoutkillstreak3 && loadout.loadoutkillstreak2 != "none") {
      replacekillstreaks = 1;
    }
  }

  if(!replacekillstreaks) {
    bundle = level.streakglobals.streakbundles[loadout.loadoutkillstreak1];

    if(isDefined(bundle) && isDefined(bundle.kills)) {
      cost1 = bundle.kills;
    } else {
      cost1 = 0;
    }

    bundle = level.streakglobals.streakbundles[loadout.loadoutkillstreak2];

    if(isDefined(bundle) && isDefined(bundle.kills)) {
      cost2 = bundle.kills;
    } else {
      cost2 = 0;
    }

    bundle = level.streakglobals.streakbundles[loadout.loadoutkillstreak3];

    if(isDefined(bundle) && isDefined(bundle.kills)) {
      cost3 = bundle.kills;
    } else {
      cost3 = 0;
    }

    if(cost1 != 0 && cost1 == cost2) {
      replacekillstreaks = 1;
    } else if(cost1 != 0 && cost1 == cost3) {
      replacekillstreaks = 1;
    } else if(cost2 != 0 && cost2 == cost3) {
      replacekillstreaks = 1;
    }
  }

  if(replacekillstreaks) {
    loadout.loadoutkillstreak1 = fallbackloadout.fallbackkillstreaks[0];
    loadout.loadoutkillstreak2 = fallbackloadout.fallbackkillstreaks[1];
    loadout.loadoutkillstreak3 = fallbackloadout.fallbackkillstreaks[2];
  }

  if(var_8b3060936146ce59 && var_60dc2c23348c27e) {
    loadout = namespace_89e4915e27d8b4fc::function_2981e0130f5d0598(loadout);
  }

  if(level.gametype == "conf_v") {
    loadout.loadoutkillstreak1 = "none";
    loadout.loadoutkillstreak2 = "electric_discharge";
    loadout.loadoutkillstreak3 = "laser_charge";
  }

  if(istrue(level.var_44815c2275fee420)) {
    loadout.loadoutkillstreak1 = getDvar(hashcat(@ "hash_7129c8b31055dff8", 1), "switchblade_drone");
    loadout.loadoutkillstreak2 = getDvar(hashcat(@ "hash_7129c8b31055dff8", 2), "cruise_predator");
    loadout.loadoutkillstreak3 = getDvar(hashcat(@ "hash_7129c8b31055dff8", 3), "fuel_airstrike");
  }

  return loadout;
}

function validateweapon(validationdata, weapon, attachments, camo, reticle, lootitemid, variantid, issecondary) {
  rootweaponname = getweaponrootname(weapon);
  var_99c561069f2eb71 = iscacsecondaryweapon(weapon);
  weaponslot = ter_op(issecondary, "secondary", "primary");
  itemslot = ter_op(issecondary, 4, 1);

  if(isDefined(weapon) && weapon != "none" && weapon != "iw9_me_fists") {
    validationdata.pointcost++;

    if(issecondary) {
      if(!var_99c561069f2eb71) {
        validationdata.pointcost++;
        validationdata.wildcards["overkill"] = 1;
      }
    } else if(var_99c561069f2eb71) {
      validationerror("secondaryAsPrimary", undefined, weapon);
      validationdata.invaliditems[itemslot] = 1;
    }

    if(!function_89497fa763d431c0(rootweaponname)) {
      validationerror("unknownWeapon", weaponslot, weapon);
      validationdata.invaliditems[itemslot] = 1;
    } else if(istrue(level.weaponmapdata[rootweaponname].uihidden)) {
      validationerror("unreleasedWeapon", weaponslot, weapon);
      validationdata.invaliditems[itemslot] = 1;
    }

    if(!self isitemunlocked(rootweaponname, "weapon") && !weaponunlocksvialoot(rootweaponname)) {
      validationerror("lockedWeapon", weaponslot, weapon);
      validationdata.invaliditems[itemslot] = 1;
    }

    if(lootitemid == 0) {
      if(variantid != -1) {
        validationerror("emptyItemIDMismatch", weaponslot, weapon);
        validationdata.invaliditems[itemslot] = 1;
      }
    } else if(variantid == -1) {
      validationerror("emptyVariantIDMismatch", weaponslot, weapon);
      validationdata.invaliditems[itemslot] = 1;
    } else {
      if(!scripts\mp\loot::isweaponitem(lootitemid)) {
        validationerror("nonWeaponLootItemID", weaponslot, weapon);
        validationdata.invaliditems[itemslot] = 1;
      }

      var_157c94951634cbc9 = scripts\mp\loot::getlootweaponref(lootitemid);

      if(!isDefined(var_157c94951634cbc9)) {
        validationerror("badLootItemID", weaponslot, weapon);
        validationdata.invaliditems[itemslot] = 1;
      } else {
        variantref = scripts\mp\loot::lookupvariantref(weapon, variantid);

        if(!isDefined(variantref)) {
          validationerror("badVariantRef", weaponslot, weapon);
          validationdata.invaliditems[itemslot] = 1;
        } else if(variantref != var_157c94951634cbc9) {
          validationerror("lootDataMismatch", weaponslot, weapon);
          validationdata.invaliditems[itemslot] = 1;
        }
      }
    }

    validateattachments(validationdata, attachments, weapon, rootweaponname, weaponslot);
  }
}

function validateattachments(validationdata, attachments, weapon, rootweaponname, weaponslot) {
  weapongroup = weapongroupmap(weapon);
  unlockcategory = getsubstr(weapongroup, 7) + "Attach";
  itemslot = ter_op(weaponslot == "primary", 2, 5);
  var_80553b9ee292c3e6 = 0;
  var_38ce0ee62103d3fb = 0;
  var_2501ca5a023e0655 = ter_op(weaponslot == "primary", 2, 2);

  foreach(attachmentindex, attachment in attachments) {
    isoptic = 0;

    if(isDefined(attachment) && attachment != "none") {
      attachmenttype = scripts\mp\utility\weapon::getattachmenttype(attachment);

      if(isDefined(attachmenttype) && attachmenttype != "") {
        if(isDefined(attachment)) {
          if(attachmenttype == "rail") {
            isoptic = 1;
          }
        }
      }

      unlockitem = rootweaponname + "+" + attachment;

      if(!self isitemunlocked(unlockitem, unlockcategory)) {
        validationerror("lockedAttachment", weaponslot, attachment);
        validationdata.invaliditems[itemslot][validationdata.invaliditems[itemslot].size] = attachmentindex;
      }

      if(!attachmentisselectable(rootweaponname, attachment)) {
        validationerror("nonSelectableAttachment", weaponslot, attachment);
        validationdata.invaliditems[itemslot][validationdata.invaliditems[itemslot].size] = attachmentindex;
      }

      if(isoptic) {
        var_80553b9ee292c3e6++;
        validationdata.pointcost++;
        continue;
      }

      var_38ce0ee62103d3fb++;

      if(var_38ce0ee62103d3fb <= var_2501ca5a023e0655) {
        validationdata.pointcost++;
        continue;
      }

      validationdata.wildcards[weaponslot + "_attachment_" + var_38ce0ee62103d3fb + 1] = 1;
      validationdata.pointcost += 2;
    }
  }

  if(var_38ce0ee62103d3fb > 5) {
    validationerror("tooManyAttachments", weaponslot, var_38ce0ee62103d3fb);
    validationdata.invaliditems[ter_op(weaponslot == "primary", 3, 6)] = 1;
  }

  if(var_80553b9ee292c3e6 > 1) {
    validationerror("tooManyOpticAttachments", weaponslot, var_80553b9ee292c3e6);
    validationdata.invaliditems[ter_op(weaponslot == "primary", 3, 6)] = 1;
  }
}

function validatepower(validationdata, power, powerslot, hasextra) {
  itemslot = ter_op(powerslot == "primary", 7, 8);

  if(isDefined(power) && power != "none") {
    if(!isDefined(level.powers[power])) {
      validationerror("unknownPower", powerslot, power);
      validationdata.invaliditems[itemslot] = 1;
    }

    if(!self isitemunlocked(power, "power")) {
      validationerror("lockedPower", powerslot, power);
      validationdata.invaliditems[itemslot] = 1;
    }

    var_a9f5ef46ba07c23f = lookuppowerslot(power);

    if(!isDefined(var_a9f5ef46ba07c23f)) {
      validationerror("unknownMenuPower", powerslot, power);
      validationdata.invaliditems[itemslot] = 1;
    } else if(var_a9f5ef46ba07c23f != powerslot) {
      validationerror("powerInWrongSlot", powerslot, power);
      validationdata.invaliditems[itemslot] = 1;
    }

    validationdata.pointcost++;
  }

  if(istrue(hasextra)) {
    validationdata.pointcost += 2;
    wildcardname = ter_op(powerslot == "primary", "extra_lethal", "extra_tactical");
    validationdata.wildcards[wildcardname] = 1;
  }
}

function validateperks(validationdata, perks, archetype) {
  perkcounts = [];
  perkcounts[1] = 0;
  perkcounts[2] = 0;
  perkcounts[3] = 0;

  foreach(perk in perks) {
    if(isDefined(perk) && perk != "none") {
      if(!function_f45c19871b412ea5(perk)) {
        validationerror("invalidPerk", undefined, perk);
        validationdata.invaliditems[9][validationdata.invaliditems[9].size] = perk;
      }

      slot = scripts\mp\perks\perks::getperkslot(perk);

      if(isDefined(slot)) {
        perkcounts[slot]++;

        if(perkcounts[slot] > 2) {
          validationerror("tooManyPerks", slot, perk);
          validationdata.invaliditems[9][validationdata.invaliditems[9].size] = perk;
        }

        if(!self isitemunlocked(perk, "perk")) {
          validationerror("lockedPerk", slot, perk);
          validationdata.invaliditems[9][validationdata.invaliditems[9].size] = perk;
        }

        if(perkcounts[slot] == 1) {
          validationdata.pointcost++;
        } else {
          validationdata.wildcards["extra_perk_" + slot] = 1;
          validationdata.pointcost += 2;
        }

        continue;
      }

      if(isDefined(level.menurigperks[perk])) {
        if(level.menurigperks[perk].archetype != archetype) {
          validationerror("rigPerkOnWrongRig", undefined, perk);
          validationdata.invaliditems[9][validationdata.invaliditems[9].size] = perk;
        }

        if(!self isitemunlocked(perk, "trait")) {
          validationerror("lockedRigPerk", slot, perk);
          validationdata.invaliditems[9][validationdata.invaliditems[9].size] = perk;
        }

        continue;
      }

      validationerror("unknownPerkType", undefined, perk);
      validationdata.invaliditems[9][validationdata.invaliditems[9].size] = perk;
    }
  }
}

function validatestreaks(validationdata, streak1, streak2, streak3) {
  streaks = [streak1, streak2, streak3];

  foreach(streak in streaks) {
    if(streak == "none") {
      continue;
    }

    setupinfo = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(streak);

    if(!isDefined(setupinfo)) {
      validationerror("unknownStreak", undefined, streak);
      validationdata.invaliditems[12] = 1;
    }

    if(!self isitemunlocked(streak, "killstreak")) {
      validationerror("lockedStreak", undefined, streak);
      validationdata.invaliditems[12] = 1;
    }
  }

  if(streak1 == streak2 && streak1 != "none") {
    validationerror("duplicateStreak", undefined, streak1);
    validationdata.invaliditems[12] = 1;
    return;
  }

  if(streak1 == streak3 && streak1 != "none") {
    validationerror("duplicateStreak", undefined, streak1);
    validationdata.invaliditems[12] = 1;
    return;
  }

  if(streak2 == streak3 && streak2 != "none") {
    validationerror("duplicateStreak", undefined, streak2);
    validationdata.invaliditems[12] = 1;
  }
}

function validatearchetype(validationdata, archetype) {
  if(!isDefined(level.archetypeids[archetype])) {
    validationerror("unknownArchetype", undefined, archetype);
    validationdata.invaliditems[10] = 1;
  }

  if(!self isitemunlocked(archetype, "rig")) {
    validationerror("lockedArchetype", undefined, archetype);
    validationdata.invaliditems[10] = 1;
  }
}

function validatesuper(validationdata, super) {
  if(!isDefined(super) || super == "none") {
    return;
  }

  superdata = level.superglobals.staticsuperdata[super];

  if(!isDefined(superdata)) {
    validationerror("unknownSuper", undefined, super);
    validationdata.invaliditems[11] = 1;
  }

  if(!self isitemunlocked(super, "super")) {
    validationerror("lockedSuper", undefined, super);
    validationdata.invaliditems[11] = 1;
  }
}

function validatewildcards(validationdata) {}

function fixloadout(loadout) {
  newloadout = scripts\mp\class::loadout_getclassstruct();
  newloadout.loadoutarchetype = "archetype_assault";
  newloadout.loadoutprimary = "iw9_ar_mike4";
  return newloadout;
}

function fixweapon(loadout, weaponslot) {
  assert(isxhash(weaponslot));

  if(weaponslot == #"primary") {
    loadout.loadoutprimary = "iw9_ar_mike4";
    loadout.loadoutprimarycamo = "none";
    loadout.loadoutprimaryreticle = "none";
    loadout.loadoutprimarylootitemid = 0;
    loadout.loadoutprimaryvariantid = -1;

    for(attachindex = 0; attachindex < scripts\mp\class::getmaxprimaryattachments(); attachindex++) {
      loadout.loadoutprimaryattachments[attachindex] = "none";
    }

    return;
  }

  if(weaponslot == #"secondary") {
    loadout.loadoutsecondary = "none";
    loadout.loadoutsecondarycamo = "none";
    loadout.loadoutsecondaryreticle = "none";
    loadout.loadoutsecondarylootitemid = 0;
    loadout.loadoutsecondaryvariantid = -1;

    for(attachindex = 0; attachindex < scripts\mp\class::getmaxsecondaryattachments(); attachindex++) {
      loadout.loadoutsecondaryattachments[attachindex] = "none";
    }

    return;
  }

  loadout.loadouttertiary = "none";
  loadout.loadouttertiarycamo = "none";
  loadout.loadouttertiaryreticle = "none";
  loadout.var_64e57707d385a2f5 = 0;
  loadout.loadouttertiaryvariantid = -1;

  for(attachindex = 0; attachindex < scripts\mp\class::function_4073b3f145413cd(); attachindex++) {
    loadout.var_494870a5978b5a09[attachindex] = "none";
  }
}

function fixattachment(loadout, weaponslot, attachmentindex) {
  assert(isxhash(weaponslot));

  if(weaponslot == #"primary") {
    loadout.loadoutprimaryattachments[attachmentindex] = "none";
    return;
  }

  if(weaponslot == #"secondary") {
    loadout.loadoutsecondaryattachments[attachmentindex] = "none";
    return;
  }

  loadout.var_494870a5978b5a09[attachmentindex] = "none";
}

function fixpower(loadout, powerslot) {
  if(powerslot == "primary") {
    loadout.loadoutpowerprimary = "none";
    loadout.loadoutextrapowerprimary = 0;
    return;
  }

  loadout.loadoutpowersecondary = "none";
  loadout.loadoutextrapowersecondary = 0;
}

function fixperk(loadout, perk) {
  loadout.loadoutperks = array_remove(loadout.loadoutperks, perk);
}

function fixkillstreaks(loadout) {
  loadout.loadoutkillstreak1 = "none";
  loadout.loadoutkillstreak2 = "none";
  loadout.loadoutkillstreak3 = "none";
}

function fixarchetype(loadout) {
  loadout.loadoutarchetype = "archetype_assault";
  fixsuper(loadout);

  foreach(perk in loadout.loadoutperks) {
    if(isDefined(level.menurigperks[perk])) {
      fixperk(loadout, perk);
      break;
    }
  }
}

function fixsuper(loadout) {
  loadout.loadoutsuper = "none";
}

function fixinvaliditems(loadout, invaliditems) {
  if(isDefined(invaliditems[0])) {
    loadout = fixloadout(loadout);
    return loadout;
  }

  if(isDefined(invaliditems[1])) {
    fixweapon(loadout, #"primary");
  } else if(isDefined(invaliditems[3])) {
    for(attachindex = 0; attachindex < scripts\mp\class::getmaxprimaryattachments(); attachindex++) {
      fixattachment(loadout, #"primary", attachindex);
    }
  } else {
    foreach(attachindex in invaliditems[2]) {
      fixattachment(loadout, #"primary", attachindex);
    }
  }

  if(isDefined(invaliditems[4])) {
    fixweapon(loadout, #"secondary");
  } else if(isDefined(invaliditems[6])) {
    for(attachindex = 0; attachindex < scripts\mp\class::getmaxsecondaryattachments(); attachindex++) {
      fixattachment(loadout, #"secondary", attachindex);
    }
  } else {
    foreach(attachindex in invaliditems[5]) {
      fixattachment(loadout, #"secondary", attachindex);
    }
  }

  if(istrue(level.tertiaryweaponslotenabled)) {}

  if(isDefined(invaliditems[7])) {
    fixpower(loadout, "primary");
  }

  if(isDefined(invaliditems[8])) {
    fixpower(loadout, "secondary");
  }

  foreach(perk in invaliditems[9]) {
    fixperk(loadout, perk);
  }

  if(isDefined(invaliditems[10])) {
    fixarchetype(loadout);
  } else if(isDefined(invaliditems[11])) {
    fixarchetype(loadout);
  }

  if(isDefined(invaliditems[12])) {
    fixkillstreaks(loadout);
  }

  return loadout;
}

function lookuppowerslot(powerref) {
  tableslot = tablelookup("mp/menuPowers.csv", 3, powerref, 2);

  if(!isDefined(tableslot) || tableslot != "1" && tableslot != "2") {
    return undefined;
  }

  return ter_op(tableslot == "1", "primary", "secondary");
}

function weaponunlocksvialoot(weaponref) {
  return false;
}

function isweaponuihidden(weaponrootname) {
  return isDefined(level.weaponmapdata[weaponrootname]) && istrue(level.weaponmapdata[weaponrootname].uihidden);
}

function isweaponvariantlocked(weaponrootname, variantid) {
  if(isanymlgmatch()) {
    return true;
  }

  if(!isDefined(variantid) || variantid <= 0) {
    return false;
  }

  variantkey = weaponrootname + "|" + variantid;
  return isDefined(level.weaponlootmapdata[variantkey]) && istrue(level.weaponlootmapdata[variantkey].islocked);
}

function isattachmentvariantinvalid(weaponrootname, weaponvariantid, attachment, attachmentvariantid) {
  if(isanymlgmatch()) {
    return true;
  }

  var_c0123fb0fce151e5 = isDefined(attachmentvariantid) && attachmentvariantid > 0 && attachment != "none";

  if(!var_c0123fb0fce151e5) {
    return false;
  }

  var_d54114842c617892 = getdvarint(@ "hash_14e87ea13737cdbb", 1);
  isweaponvariant = isDefined(weaponvariantid) && weaponvariantid > 0;

  if(!var_d54114842c617892 && !isweaponvariant) {
    return true;
  }

  var_e88b89f1334a1506 = weaponrootname + "|" + weaponvariantid;
  attachmentisvalid = 0;

  for(variantindex = 1; true; variantindex++) {
    variantkey = weaponrootname + "|" + variantindex;

    if(!isDefined(level.weaponlootmapdata[variantkey])) {
      break;
    }

    if(var_d54114842c617892 || variantkey == var_e88b89f1334a1506) {
      if(!istrue(level.weaponlootmapdata[variantkey].islocked)) {
        if(isDefined(level.weaponlootmapdata[variantkey].attachcustomtoidmap)) {
          foreach(key, id in level.weaponlootmapdata[variantkey].attachcustomtoidmap) {
            if(attachmentvariantid == id && attachment == key) {
              attachmentisvalid = 1;
              break;
            }
          }
        }

        if(attachmentisvalid) {
          break;
        }
      }
    }
  }

  return !attachmentisvalid;
}

function function_8ad31470a4d15065(fallbackloadout) {
  primary = getmatchrulesdata("commonOption", "restrictedPrimaryFallback");

  if(isDefined(primary) && primary != "") {
    fallbackloadout.fallbackprimary = primary;
  }

  secondary = getmatchrulesdata("commonOption", "restrictedSecondaryFallback");

  if(isDefined(secondary) && secondary != "") {
    fallbackloadout.fallbacksecondary = secondary;
  }

  perk1 = getmatchrulesdata("commonOption", "restrictedPerk1Fallback");

  if(isDefined(perk1) && perk1 != "") {
    fallbackloadout.baseperks[0] = perk1;
    fallbackloadout.perks[0] = perk1;
  }

  perk2 = getmatchrulesdata("commonOption", "restrictedPerk2Fallback");

  if(isDefined(perk2) && perk2 != "") {
    fallbackloadout.baseperks[1] = perk2;
    fallbackloadout.perks[1] = perk2;
  }

  perk3 = getmatchrulesdata("commonOption", "restrictedPerk3Fallback");

  if(isDefined(perk3) && perk3 != "") {
    fallbackloadout.bonusperk = perk3;
    fallbackloadout.perks[2] = perk3;
  }

  perk4 = getmatchrulesdata("commonOption", "restrictedUltimatePerkFallback");

  if(isDefined(perk4) && perk4 != "") {
    fallbackloadout.ultimateperk = perk4;
    fallbackloadout.perks[3] = perk4;
  }

  lethal = getmatchrulesdata("commonOption", "restrictedLethalFallback");

  if(isDefined(lethal) && lethal != "none") {
    fallbackloadout.var_223912952e2fcaa5 = lethal;
  }

  tactical = getmatchrulesdata("commonOption", "restrictedTacticalFallback");

  if(isDefined(tactical) && tactical != "none") {
    fallbackloadout.var_56507f15843909c5 = tactical;
  }
}

function function_9480a79a4852090f() {
  fallbackloadout = spawnStruct();
  var_59896658f6aa750c = getdvarint(@ "hash_1c46edd4b28ec23", 32081);
  var_9e921d97a928ff80 = getdvarint(@ "hash_3ac8e9ebdf483563", 17211);
  fallbackloadout.fallbackprimary = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(var_59896658f6aa750c);
  fallbackloadout.var_2aabec7bb44d89cb = [];
  fallbackloadout.var_2aabec7bb44d89cb[0] = "none";
  fallbackloadout.var_2aabec7bb44d89cb[1] = "none";
  fallbackloadout.var_2aabec7bb44d89cb[2] = "none";
  fallbackloadout.var_2aabec7bb44d89cb[3] = "none";
  fallbackloadout.var_2aabec7bb44d89cb[4] = "none";
  fallbackloadout.var_2aabec7bb44d89cb[5] = "none";
  fallbackloadout.var_606482762a976e6b = "none";
  fallbackloadout.fallbackprimaryreticle = "none";
  fallbackloadout.var_a2746a3326ffd02d = -1;
  fallbackloadout.var_dbd72ebf429c33cc = [];
  fallbackloadout.var_ab71722736d6300d = "none";
  fallbackloadout.var_21edf78f47f80693[0] = "none";
  fallbackloadout.var_21edf78f47f80693[1] = "none";
  fallbackloadout.var_21edf78f47f80693[2] = "none";
  fallbackloadout.var_21edf78f47f80693[3] = "none";
  fallbackloadout.var_21edf78f47f80693[4] = "none";
  fallbackloadout.fallbacksecondary = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(var_9e921d97a928ff80);
  fallbackloadout.var_8db17208eee8983f = [];
  fallbackloadout.var_8db17208eee8983f[0] = "none";
  fallbackloadout.var_8db17208eee8983f[1] = "none";
  fallbackloadout.var_8db17208eee8983f[2] = "none";
  fallbackloadout.var_8db17208eee8983f[3] = "none";
  fallbackloadout.var_8db17208eee8983f[4] = "none";
  fallbackloadout.var_fe85ac60e4c42827 = "none";
  fallbackloadout.fallbacksecondaryreticle = "none";
  fallbackloadout.var_5ccacfeceb8f0b91 = -1;
  fallbackloadout.var_541023c8262ad6a8 = [];
  fallbackloadout.var_28c73c08c5f76289 = "none";
  fallbackloadout.var_6ff9bdde98b6c7af[0] = "none";
  fallbackloadout.var_6ff9bdde98b6c7af[1] = "none";
  fallbackloadout.var_6ff9bdde98b6c7af[2] = "none";
  fallbackloadout.var_6ff9bdde98b6c7af[3] = "none";
  fallbackloadout.var_6ff9bdde98b6c7af[4] = "none";
  fallbackloadout.baseperks = [];
  fallbackloadout.baseperks[0] = "specialty_scavenger_br";
  fallbackloadout.baseperks[1] = "specialty_tac_resist_br";
  fallbackloadout.bonusperk = "specialty_contract_payout";
  fallbackloadout.ultimateperk = "specialty_combat_scout";
  fallbackloadout.perks = [];
  fallbackloadout.perks[0] = fallbackloadout.baseperks[0];
  fallbackloadout.perks[1] = fallbackloadout.baseperks[1];
  fallbackloadout.perks[2] = fallbackloadout.bonusperk;
  fallbackloadout.perks[3] = fallbackloadout.ultimateperk;
  fallbackloadout.var_223912952e2fcaa5 = "equip_frag";
  fallbackloadout.var_56507f15843909c5 = "equip_flash";
  fallbackloadout.fallbackkillstreaks = [];
  fallbackloadout.fallbackkillstreaks[0] = getDvar(@ "hash_84f9a8460ee12f06", "uav");
  fallbackloadout.fallbackkillstreaks[1] = getDvar(@ "hash_84f9a7460ee12cd3", "cruise_predator");
  fallbackloadout.fallbackkillstreaks[2] = getDvar(@ "hash_84f9a6460ee12aa0", "fuel_airstrike");

  if(isanymlgmatch()) {
    leagueplaybundle = getscriptbundle("leagueplaybundle:" + level.projectbundle.var_b1e3933dec92ebff);
    var_effe6f81e1a11b81 = getscriptbundle("classtableentry:" + leagueplaybundle.fallbackloadout);
    var_9f9e341110bf6f8e = getscriptbundle("killstreaklist:" + leagueplaybundle.fallbackkillstreaks);
    fallbackloadout.fallbackprimary = var_effe6f81e1a11b81.primaryweapon.weapon;
    fallbackloadout.var_2aabec7bb44d89cb = [];
    fallbackloadout.var_2aabec7bb44d89cb[0] = var_effe6f81e1a11b81.primaryweapon.attachment1;
    fallbackloadout.var_2aabec7bb44d89cb[1] = var_effe6f81e1a11b81.primaryweapon.attachment2;
    fallbackloadout.var_2aabec7bb44d89cb[2] = var_effe6f81e1a11b81.primaryweapon.attachment3;
    fallbackloadout.var_2aabec7bb44d89cb[3] = var_effe6f81e1a11b81.primaryweapon.attachment4;
    fallbackloadout.var_2aabec7bb44d89cb[4] = var_effe6f81e1a11b81.primaryweapon.attachment5;
    fallbackloadout.var_2aabec7bb44d89cb[5] = var_effe6f81e1a11b81.primaryweapon.attachment6;
    fallbackloadout.var_606482762a976e6b = var_effe6f81e1a11b81.primaryweapon.camo;
    fallbackloadout.var_5a68d67fc469e1e7 = var_effe6f81e1a11b81.primaryweapon.reticle;
    fallbackloadout.var_a2746a3326ffd02d = ter_op(isDefined(var_effe6f81e1a11b81.primaryweapon.variantid), int(var_effe6f81e1a11b81.primaryweapon.variantid), -1);
    fallbackloadout.fallbacksecondary = var_effe6f81e1a11b81.secondaryweapon.weapon;
    fallbackloadout.var_8db17208eee8983f = [];
    fallbackloadout.var_8db17208eee8983f[0] = var_effe6f81e1a11b81.secondaryweapon.attachment1;
    fallbackloadout.var_8db17208eee8983f[1] = var_effe6f81e1a11b81.secondaryweapon.attachment2;
    fallbackloadout.var_8db17208eee8983f[2] = var_effe6f81e1a11b81.secondaryweapon.attachment3;
    fallbackloadout.var_8db17208eee8983f[3] = var_effe6f81e1a11b81.secondaryweapon.attachment4;
    fallbackloadout.var_8db17208eee8983f[4] = var_effe6f81e1a11b81.secondaryweapon.attachment5;
    fallbackloadout.var_fe85ac60e4c42827 = var_effe6f81e1a11b81.secondaryweapon.camo;
    fallbackloadout.fallbacksecondaryreticle = var_effe6f81e1a11b81.secondaryweapon.reticle;
    fallbackloadout.var_5ccacfeceb8f0b91 = ter_op(isDefined(var_effe6f81e1a11b81.secondaryweapon.variantid), int(var_effe6f81e1a11b81.secondaryweapon.variantid), -1);
    fallbackloadout.var_541023c8262ad6a8 = [];
    fallbackloadout.baseperks = [];
    fallbackloadout.baseperks[0] = var_effe6f81e1a11b81.perks.perk1;
    fallbackloadout.baseperks[1] = var_effe6f81e1a11b81.perks.perk2;
    fallbackloadout.bonusperk = var_effe6f81e1a11b81.perks.perk3;
    fallbackloadout.ultimateperk = var_effe6f81e1a11b81.extraperks.perk1;
    fallbackloadout.var_223912952e2fcaa5 = var_effe6f81e1a11b81.equipment.primary;
    fallbackloadout.var_56507f15843909c5 = var_effe6f81e1a11b81.equipment.secondary;
    fallbackloadout.fallbackkillstreaks[0] = var_9f9e341110bf6f8e.killstreak_list[0].ref;
    fallbackloadout.fallbackkillstreaks[1] = var_9f9e341110bf6f8e.killstreak_list[1].ref;
    fallbackloadout.fallbackkillstreaks[2] = var_9f9e341110bf6f8e.killstreak_list[2].ref;
  } else if(function_f24e99a2f548d0b8()) {
    fallbackloadout.fallbacksecondary = "none";
  } else {
    function_8ad31470a4d15065(fallbackloadout);
  }

  return fallbackloadout;
}

function replaceprimaryweapon(loadout) {
  fallbackloadout = function_9480a79a4852090f();
  loadout.loadoutprimary = fallbackloadout.fallbackprimary;
  loadout.loadoutprimaryattachments = fallbackloadout.var_2aabec7bb44d89cb;
  loadout.loadoutprimarycamo = fallbackloadout.var_606482762a976e6b;
  loadout.loadoutprimaryreticle = fallbackloadout.fallbackprimaryreticle;
  loadout.loadoutprimaryvariantid = fallbackloadout.var_a2746a3326ffd02d;
  loadout.loadoutprimaryattachmentids = fallbackloadout.var_dbd72ebf429c33cc;
  loadout.loadoutprimarycosmeticattachment = fallbackloadout.var_ab71722736d6300d;
  loadout.loadoutprimarystickers[0] = fallbackloadout.var_21edf78f47f80693[0];
  loadout.loadoutprimarystickers[1] = fallbackloadout.var_21edf78f47f80693[1];
  loadout.loadoutprimarystickers[2] = fallbackloadout.var_21edf78f47f80693[2];
  loadout.loadoutprimarystickers[3] = fallbackloadout.var_21edf78f47f80693[3];
  loadout.loadoutprimarystickers[4] = fallbackloadout.var_21edf78f47f80693[4];
  return loadout;
}

function replacesecondaryweapon(loadout) {
  fallbackloadout = function_9480a79a4852090f();
  loadout.loadoutsecondary = fallbackloadout.fallbacksecondary;
  loadout.loadoutsecondaryattachments = fallbackloadout.var_8db17208eee8983f;
  loadout.loadoutsecondarycamo = fallbackloadout.var_fe85ac60e4c42827;
  loadout.loadoutsecondaryreticle = fallbackloadout.fallbacksecondaryreticle;
  loadout.loadoutsecondaryvariantid = fallbackloadout.var_5ccacfeceb8f0b91;
  loadout.loadoutsecondaryattachmentids = fallbackloadout.var_541023c8262ad6a8;
  loadout.loadoutsecondarycosmeticattachment = fallbackloadout.var_28c73c08c5f76289;
  loadout.loadoutsecondarystickers[0] = fallbackloadout.var_6ff9bdde98b6c7af[0];
  loadout.loadoutsecondarystickers[1] = fallbackloadout.var_6ff9bdde98b6c7af[1];
  loadout.loadoutsecondarystickers[2] = fallbackloadout.var_6ff9bdde98b6c7af[2];
  loadout.loadoutsecondarystickers[3] = fallbackloadout.var_6ff9bdde98b6c7af[3];
  loadout.loadoutsecondarystickers[4] = fallbackloadout.var_6ff9bdde98b6c7af[4];
  return loadout;
}

function function_5e76ad052ba12845(loadout) {
  fallbackloadout = function_9480a79a4852090f();

  for(i = 0; i < loadout.loadoutperks.size; i++) {
    if(i >= fallbackloadout.perks.size) {
      println("<dev string:xc3>");
      continue;
    }

    loadout.loadoutperks[i] = fallbackloadout.perks[i];
  }

  return loadout;
}
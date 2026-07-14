/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\weapon.gsc
**************************************/

#using scripts\common\system;
#using scripts\engine\utility;
#namespace weapon;

function private autoexec __init__system__() {
  system::register(#"common_weapons", undefined, &weapons_init, undefined);
}

function weapons_init() {
  initializemines();
  level.maxattachments = [];
  maxattachments = level.gamemodebundle.maxattachments;
  maxattachmentsprimary = {
    #gunfighter: level.gamemodebundle.maxattachments.gunfighterprimary, #standard: isDefined(maxattachments) ? maxattachments.defaultprimary : 8
  };
  level.maxattachments[level.maxattachments.size] = maxattachmentsprimary;
  maxattachmentssecondary = {
    #gunfighter: level.gamemodebundle.maxattachments.gunfightersecondary, #standard: isDefined(maxattachments) ? maxattachments.defaultsecondary : 5
  };
  level.maxattachments[level.maxattachments.size] = maxattachmentssecondary;
  maxattachmentstertiary = {
    #gunfighter: level.gamemodebundle.gunfightertertiary, #standard: isDefined(maxattachments) ? maxattachments.defaulttertiary : 5
  };
  level.maxattachments[level.maxattachments.size] = maxattachmentstertiary;
  level.var_e0dc368290d94a40 = [];

  if(isDefined(level.gamemodebundle.var_74c8e9104c137cd4)) {
    foreach(attachment in level.gamemodebundle.var_74c8e9104c137cd4) {
      level.var_e0dc368290d94a40[level.var_e0dc368290d94a40.size] = attachment.attachment;
    }

    return;
  }

  level.var_e0dc368290d94a40 = ["laserir_box", "laserir_cyl", "laserir_pstl"];
}

function validateweapon(rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg) {
  if(!iskillstreakplayerweapon(rootname)) {
    rootname = getweaponrootname(rootname);
  }

  if(!validateweaponassetnamemap(rootname)) {
    return 0;
  }

  return 1;
}

function function_a972ae5c8fb5933(weaponinfo) {
  return buildweapon(weaponinfo.weaponref, weaponinfo.attachmentrefs, weaponinfo.weaponcamo, weaponinfo.weaponreticle, weaponinfo.weaponvariant, weaponinfo.attachmentids, weaponinfo.weaponcosmetic, weaponinfo.weaponstickers, weaponinfo.hasnvg, weaponinfo.attachmenttuning, weaponinfo.iscustom, weaponinfo.var_daad5d0a48a7283e);
}

function buildweapon(rootname, attachments, camo = "camo_none", reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg, attachmenttuning, iscustom, var_daad5d0a48a7283e) {
  if("none" == rootname) {
    return level.weaponnone;
  }

  if(isDefined(attachments)) {
    assert(isarray(attachments), "<dev string:x24>");
  } else {
    attachments = [];
  }

  if(isstring(reticle)) {
    if(reticle == "none") {
      reticle = % "";
    } else {
      if(!isstartstr(reticle, "reticledata:")) {
        reticle = "reticledata:" + reticle;
      }

      reticle = getxhashasset(reticle);
    }
  }

  if(isDefined(variantid) && (isstring(variantid) && variantid == "-1" || isint(variantid) && variantid <= 0)) {
    variantid = undefined;
  }

  weaponassetname = weaponassetnamemap(rootname);
  weaponobj = buildweaponinternal(weaponassetname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, iscustom, var_daad5d0a48a7283e);

  if(isDefined(weaponobj.camo)) {
    assert(function_2b94fc4d332569a5(weaponobj), "<dev string:x56>" + weaponobj.camo + "<dev string:x7f>" + weaponobj.basename);
  }

  if(!isDefined(weaponobj)) {
    return;
  }

  if(hasnvg) {
    if(weaponsupportslaserir(weaponobj) && function_ad2262e5ff0331a3(weaponobj)) {
      nvgattachment = getweaponnvgattachment(weaponobj);

      if(nvgattachment != "invalid" && (isDefined(weaponobj.attachments) && !arraycontains(weaponobj.attachments, nvgattachment) || !isDefined(weaponobj.attachments))) {
        weaponobj = weaponobj withattachment(nvgattachment);
      }
    }
  }

  if(isDefined(level.var_cfde89929188f64e) && isDefined(weaponobj)) {
    weaponobj = self[[level.var_cfde89929188f64e]](weaponobj);
  }

  return weaponobj;
}

function function_bfc8095d723355fa(weaponassetname, blueprint, camo) {
  if(!weaponexists(weaponassetname)) {
    if(isDefined(level.weaponmapdata[weaponassetname])) {
      weaponassetname = level.weaponmapdata[weaponassetname].assetname;
    } else {
      return undefined;
    }
  }

  variantid = 0;

  if(isxhashasset(blueprint)) {
    blueprints = getweaponblueprintnames(weaponassetname);

    foreach(variant, id in blueprints) {
      if(blueprint == variant) {
        variantid = id;
        break;
      }
    }
  } else {
    variantid = blueprint ?? 0;
  }

  return buildweapon(weaponassetname, undefined, camo, undefined, variantid);
}

function function_15140c189cc65e1e() {
  return &buildweapon;
}

function isattachmentironsdefault(attachment) {
  return issubstr(attachment, "ironsdefault_");
}

function attachmentmap_tocategory(attachmentname) {
  assert(isDefined(level.var_cd6bd69e56b4e5b4), "<dev string:x95>");

  if(isDefined(level.var_cd6bd69e56b4e5b4[attachmentname])) {
    return level.var_cd6bd69e56b4e5b4[attachmentname];
  }

  return undefined;
}

function attachmentmap_toextra(attachmentname) {
  assert(isDefined(level.var_2e4b961b65909f5a), "<dev string:xe6>");

  if(isDefined(level.var_2e4b961b65909f5a[attachmentname])) {
    extraattachments = [];
    extraattachmentlist = level.var_2e4b961b65909f5a[attachmentname];

    foreach(entry in extraattachmentlist) {
      if(!isDefined(entry.attachmentextra) || entry.attachmentextra == "") {
        continue;
      }

      extraattachments[entry.attachmentextra] = entry.attachmentextra;
    }

    return extraattachments;
  }

  return undefined;
}

function private buildattachmentmaps() {
  assert(!isDefined(level.var_2e4b961b65909f5a), "<dev string:x134>");
  assert(!isDefined(level.weaponattachments), "<dev string:x17c>");
  assert(!isDefined(level.weaponattachmentsmap), "<dev string:x1c9>");
  assert(isDefined(level.weaponmapdata), "<dev string:x21a>");

  if(game[#"levelcache"].weaponattachments) {
    level.var_2e4b961b65909f5a = game[#"levelcache"].var_2e4b961b65909f5a;
    level.weaponattachments = game[#"levelcache"].weaponattachments;
    level.var_cd6bd69e56b4e5b4 = game[#"levelcache"].var_cd6bd69e56b4e5b4;
    return;
  }

  level.var_2e4b961b65909f5a = [];
  level.weaponattachments = [];
  level.var_cd6bd69e56b4e5b4 = [];
  function_ea865062f19beca0();
  slotarray = [];

  foreach(slot in level.attachmentslotarray) {
    slotarray[slotarray.size] = slot;
  }

  var_e5042059ee422f62 = [#"lootid", #"category", #"hideinui", #"hash_febd8701371cdffe"];

  foreach(weaponnamekey in level.weaponmapdata) {
    if(isDefined(weaponnamekey.assetname) && isDefined(weaponnamekey.group)) {
      foreach(slot in slotarray) {
        var_bba76b2d884ae9dc = function_2e5ecdd8ac47f308(weaponnamekey.assetname, slot, 1);

        if(isDefined(var_bba76b2d884ae9dc)) {
          foreach(attachment in var_bba76b2d884ae9dc) {
            attachmentdataname = function_333a08591af6b59(weaponnamekey.assetname, attachment);

            if(isDefined(attachmentdataname)) {
              bundle = getscriptbundlefieldvalues(attachmentdataname, var_e5042059ee422f62);

              if(isDefined(bundle.lootid)) {
                if(isDefined(level.weaponattachments[attachment])) {
                  continue;
                }

                if((bundle.var_7253350d567fa007.size ?? 0) > 0) {
                  if(!isDefined(level.var_2e4b961b65909f5a[attachment])) {
                    level.var_2e4b961b65909f5a[attachment] = bundle.var_7253350d567fa007;
                  }
                }

                if(bundle.hideinui) {
                  level.weaponattachments[attachment] = 0;
                  continue;
                }

                category = bundle.category;

                if(isDefined(category) && bundle.category != "NONE") {
                  level.weaponattachments[attachment] = bundle.lootid;
                  level.var_cd6bd69e56b4e5b4[attachment] = category;
                }
              }
            }
          }
        }
      }
    }
  }

  if(!isDefined(game[#"levelcache"])) {
    game[#"levelcache"] = {};
  }

  game[#"levelcache"].var_2e4b961b65909f5a = level.var_2e4b961b65909f5a;
  game[#"levelcache"].weaponattachments = level.weaponattachments;
  game[#"levelcache"].var_cd6bd69e56b4e5b4 = level.var_cd6bd69e56b4e5b4;
}

function function_f0809b09de2ec21b() {
  assert(isDefined(level.weaponmapdata), "<dev string:x25c>");
  blueprintsarray = [];

  foreach(weapon in level.weaponmapdata) {
    blueprints = getweaponblueprintnames(weapon.assetname);

    if(blueprints.size > 0) {
      blueprintsarray[weapon.assetname] = [];

      foreach(id in blueprints) {
        blueprintsarray[weapon.assetname][blueprintsarray[weapon.assetname].size] = id;
      }
    }
  }

  return blueprintsarray;
}

function weaponattachremoveextraattachments(attachments) {
  assert(isDefined(level.var_2e4b961b65909f5a), "<dev string:x2a9>");
  extraattachmentlist = [];

  foreach(attachment in attachments) {
    var_f14127ae795ac414 = attachmentmap_toextra(attachment);

    if(isDefined(var_f14127ae795ac414)) {
      extraattachmentlist[extraattachmentlist.size] = var_f14127ae795ac414;
    }
  }

  attachmentsfiltered = [];

  foreach(attachment in attachments) {
    isextraattachment = 0;

    foreach(extraattachments in extraattachmentlist) {
      foreach(extraattach in extraattachments) {
        if(attachment == extraattach) {
          isextraattachment = 1;
          break;
        }
      }
    }

    if(!isextraattachment) {
      attachmentsfiltered[attachmentsfiltered.size] = attachment;
    }
  }

  return attachmentsfiltered;
}

function isakimbo(weapon) {
  return getweaponhasperk(weapon, "specialty_akimbo");
}

function getattachmentlootid(weaponname, attachref) {
  if(!isDefined(level.weaponattachments[attachref])) {
    lootinfo = utility::callsharedfunc(#"loot", #"getLootItemInfoFromRef", attachref);
    level.weaponattachments[attachref] = lootinfo.itemid ?? 0;
  }

  return level.weaponattachments[attachref];
}

function buildweaponrootlist() {
  rootweapons = [];

  foreach(weapon, data in level.weaponmapdata) {
    if(isDefined(data.group)) {
      if(!issubstr(data.group, "weapon_")) {
        continue;
      }

      if(data.group == "weapon_other") {
        continue;
      }

      rootweapons[rootweapons.size] = weapon;
    }
  }

  return rootweapons;
}

function validateweaponassetnamemap(weaponroot) {
  if(iskillstreakweapon(weaponroot)) {
    return 1;
  }

  return isDefined(level.weaponmapdata[weaponroot].assetname);
}

function weaponassetnamemap(weaponroot) {
  if(weaponexists(weaponroot)) {
    return weaponroot;
  }

  if(iskillstreakweapon(weaponroot)) {
    return weaponroot;
  }

  var_7237854e3be197ca = level.weaponmapdata[weaponroot].assetname;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  assertmsg("<dev string:x300>" + weaponroot);
  return weaponroot;
}

function weapongroupmap(weaponroot) {
  var_7237854e3be197ca = level.weaponmapdata[weaponroot].group;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  assert(isDefined(level.weaponmapdata), "<dev string:x341>");
  return undefined;
}

function function_56e69ba2c15e84a1(weaponroot) {
  assert(isDefined(level.weaponmapdata), "<dev string:x384>");
  return isDefined(level.weaponmapdata[weaponroot]);
}

function private buildweaponmap() {
  assert(!isDefined(level.weaponmapdata), "<dev string:x3c8>");

  if(game[#"levelcache"].weaponmapdata) {
    level.weaponmapdata = game[#"levelcache"].weaponmapdata;
    level.weapongroupdata = game[#"levelcache"].weapongroupdata;
    level.weaponlistbundle = game[#"levelcache"].weaponlistbundle;
    return;
  }

  level.weaponmapdata = [];
  level.weapongroupdata = [];
  weaponsscriptbundle = function_16ff7d597f441100();

  if(isDefined(weaponsscriptbundle)) {
    bundlevalues = [#"ref", #"group", #"displayorder", #"asset", #"assetrefsp", #"name", #"perk", #"speedscale", #"hash_1469d2b702a6d5f8", #"lootid", #"botpersonality", #"isactivearmory", #"isknife", #"issharpmelee", #"hash_33b5234e67b833b8"];

    foreach(weaponname in weaponsscriptbundle) {
      weaponscriptbundle = function_659a3e10e8d1c91c(weaponname, bundlevalues);
      weapon = weaponscriptbundle.ref;
      weapon_asset = undefined;

      if(weaponexists(weaponscriptbundle.asset)) {
        weapon_asset = weaponscriptbundle.asset;
      } else if(weaponexists(weaponscriptbundle.assetrefsp)) {
        weapon_asset = weaponscriptbundle.assetrefsp;
      }

      if(isDefined(weapon_asset)) {
        level.weaponmapdata[weapon] = spawnStruct();
        group = weaponscriptbundle.group;

        if(isDefined(group) && group != "") {
          level.weaponmapdata[weapon].group = group;
          uidisplayorder = weaponscriptbundle.displayorder ?? 0;

          if(isDefined(uidisplayorder) && uidisplayorder > -1) {
            if(!isDefined(level.weapongroupdata[group])) {
              level.weapongroupdata[group] = [];
            }

            level.weapongroupdata[group][level.weapongroupdata[group].size] = weapon;
          } else {
            level.weaponmapdata[weapon].uihidden = 1;
          }
        }

        assetname = weapon_asset;

        if(isDefined(assetname) && assetname != "") {
          level.weaponmapdata[weapon].assetname = assetname;
        }

        locname = weaponscriptbundle.name;

        if(isDefined(locname) && locname != &"") {
          level.weaponmapdata[weapon].locname = locname;
        }

        perk = weaponscriptbundle.perk;

        if(isDefined(perk) && perk != "") {
          level.weaponmapdata[weapon].perk = perk;
        }

        level.weaponmapdata[weapon].weaponlootid = weaponscriptbundle.lootid;
        movespeed = weaponscriptbundle.speedscale;

        if(isDefined(movespeed)) {
          level.weaponmapdata[weapon].speed = movespeed;
          assert(isDefined(movespeed) && movespeed > 0 && movespeed <= 1, "<dev string:x3fd>" + weapon);
        }

        var_d1f25dd2efe2402f = weaponscriptbundle.var_d1f25dd2efe2402f;

        if(isDefined(var_d1f25dd2efe2402f)) {
          level.weaponmapdata[weapon].var_d1f25dd2efe2402f = var_d1f25dd2efe2402f;
        }

        botpersonalities = weaponscriptbundle.botpersonality;

        if(isDefined(botpersonalities)) {
          level.weaponmapdata[weapon].botpersonalities = strtok(botpersonalities, "|");
        }

        activearmoryenabled = weaponscriptbundle.isactivearmory;

        if(isDefined(activearmoryenabled)) {
          level.weaponmapdata[weapon].activearmoryenabled = activearmoryenabled;
        }

        if(isequipmentaddon(weapon)) {
          level.weaponmapdata[weapon].isequipmentaddon = 1;
        }

        isknife = weaponscriptbundle.isknife;

        if(isknife) {
          level.weaponmapdata[weapon].isknife = 1;
        }

        issharpmelee = weaponscriptbundle.issharpmelee;

        if(issharpmelee) {
          level.weaponmapdata[weapon].issharpmelee = 1;
        }

        var_f95b721efa3c0163 = weaponscriptbundle.var_f95b721efa3c0163;

        if(var_f95b721efa3c0163) {
          level.weaponmapdata[weapon].var_f95b721efa3c0163 = 1;
        }
      }
    }
  }

  if(!isDefined(game[#"levelcache"])) {
    game[#"levelcache"] = {};
  }

  game[#"levelcache"].weaponmapdata = level.weaponmapdata;
  game[#"levelcache"].weapongroupdata = level.weapongroupdata;
  game[#"levelcache"].weaponlistbundle = level.weaponlistbundle;
}

function private function_47c21f91a5f180b8() {
  assert(!isDefined(level.weaponmappedcamos), "<dev string:x436>");

  if(game[#"levelcache"].weaponmappedcamos) {
    level.weaponmappedcamos = game[#"levelcache"].weaponmappedcamos;
    return;
  }

  level.weaponmappedcamos = [];
  camolistbundle = undefined;
  camofields = [#"ref", #"weaponref", #"lootid", #"weaponclass"];

  if(isDefined(level.gamemodebundle.weaponcamolist)) {
    camolistbundle = getscriptbundle(level.gamemodebundle.weaponcamolist);
  }

  if(!(isDefined(camolistbundle) && isDefined(camolistbundle.camo_list))) {
    return;
  }

  foreach(camoname in camolistbundle.camo_list) {
    if(!isDefined(camoname.camodata)) {
      continue;
    }

    camobundle = getscriptbundlefieldvalues(camoname.camodata, camofields);

    function_ce79080c3dd2d8ba(camobundle.ref, camoname.camodata);

    mappings = [camobundle.weaponref, camobundle.weaponclass];
    pathway = undefined;

    foreach(param in mappings) {
      if(tolower(param) != "none") {
        if(isDefined(pathway)) {
          assertmsg("<dev string:x475>");
          println(getxhashsourcename(camoname.camodata) + "<dev string:x4ac>");
          break;
        }

        pathway = param;
      }
    }

    if(isDefined(pathway)) {
      if(!isDefined(level.weaponmappedcamos[pathway])) {
        level.weaponmappedcamos[pathway] = [];
      }

      level.weaponmappedcamos[pathway][camobundle.ref] = camobundle.lootid;
    }
  }

  function_1f7dda67483b1149();

  if(!isDefined(game[#"levelcache"])) {
    game[#"levelcache"] = {};
  }

  game[#"levelcache"].weaponmappedcamos = level.weaponmappedcamos;
}

function function_ce79080c3dd2d8ba(camoreference, bundlename) {
  if(!isDefined(level.var_63473892ef2a718e)) {
    level.var_63473892ef2a718e = [];
  }

  if(!isDefined(level.var_63473892ef2a718e[camoreference])) {
    level.var_63473892ef2a718e[camoreference] = [];
  }

  level.var_63473892ef2a718e[camoreference][level.var_63473892ef2a718e[camoreference].size] = bundlename;
}

function function_1f7dda67483b1149() {
  if(!isDefined(level.var_63473892ef2a718e)) {
    println("<dev string:x4ee>");
    return;
  }

  foreach(camoname, camo in level.var_63473892ef2a718e) {
    if(camo.size == 1) {
      level.var_63473892ef2a718e[camoname] = undefined;
    }
  }

  level.var_63473892ef2a718e = function_f943bef551ff028c(level.var_63473892ef2a718e);
}

function function_2b94fc4d332569a5(objweapon) {
  if(!isweapon(objweapon)) {
    assertmsg("<dev string:x524>");
    return undefined;
  } else if(!isDefined(objweapon.camo)) {
    return undefined;
  }

  rootname = getweaponrootstring(objweapon);
  weaponclass = level.weaponmapdata[rootname].group ?? undefined;
  mappings = [rootname, weaponclass];
  lootid = function_9fda321f45a32fa3(mappings, objweapon.camo);

  if(!isDefined(lootid)) {
    if(isDefined(level.var_63473892ef2a718e[objweapon.camo])) {
      assertmsg("<dev string:x551>" + objweapon.camo + "<dev string:x55f>" + level.var_63473892ef2a718e[objweapon.camo].size + "<dev string:x571>");
    }

    itemstruct = utility::callsharedfunc(#"loot", #"getLootItemInfoFromRef", objweapon.camo);

    if(isDefined(itemstruct)) {
      lootid = itemstruct.itemid;
    }
  }

  return lootid;
}

function function_9fda321f45a32fa3(mappings, camo) {
  foreach(param in mappings) {
    var_7237854e3be197ca = level.weaponmappedcamos[param][camo];

    if(isDefined(var_7237854e3be197ca)) {
      return var_7237854e3be197ca;
    }
  }

  return undefined;
}

function getweaponattachmentdefaultattachments(weaponassetname, attachments) {
  if(isDefined(attachments)) {
    sortedattachments = utility::alphabetize(attachments);

    for(attachmentindex = 0; attachmentindex < sortedattachments.size; attachmentindex++) {
      attachment = sortedattachments[attachmentindex];

      if(attachment != "none" && (attachmentindex == 0 || attachment != sortedattachments[attachmentindex - 1])) {
        weaponassetname = weaponassetname + "+" + attachment;
      }
    }
  }

  return getweapondefaultattachments(weaponassetname);
}

function getbaseweaponattachdefaulttoidmap(weapon, attachments) {
  assetname = getweaponassetname(weapon);

  if(!isDefined(assetname)) {
    assetname = weapon;
  }

  defaultattachments = getweaponattachmentdefaultattachments(assetname, attachments);

  if(isDefined(defaultattachments) && defaultattachments.size > 0) {
    defaulttoidmap = [];

    foreach(defaultattachment in defaultattachments) {
      defaulttoidmap[defaultattachment] = 0;
    }

    return defaulttoidmap;
  }

  return undefined;
}

function parseattachdefaulttoidmap(attachmentdefaults) {
  if(attachmentdefaults != "") {
    defaultkvps = strtok(attachmentdefaults, " ");
    defaulttoidmap = [];

    foreach(kvp in defaultkvps) {
      pair = strtok(kvp, "|");

      if(pair.size == 2) {
        defaulttoidmap[pair[0]] = int(pair[1]);
        continue;
      }

      defaulttoidmap[pair[0]] = 0;
    }

    return defaulttoidmap;
  }

  return undefined;
}

function getweaponassetname(rootname) {
  return level.weaponmapdata[rootname].assetname;
}

function getweaponname(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x5e2>");
    return "none";
  }

  if(isweapon(weapon)) {
    return weapon.basename;
  }

  return getweaponassetname(weapon) ?? weapon;
}

function isfistweaponobject(weaponobj) {
  if(weaponobj === level.defaultfist) {
    return 1;
  }

  rootname = getweaponrootname(weaponobj);
  return level.weaponmapdata[rootname].var_f95b721efa3c0163;
}

function isfistweapon(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);
  return isfistweaponobject(weaponobj);
}

function isunderwaterweaponobject(weaponobj) {
  return weaponobj === level.defaultswimweapon || weaponobj === level.var_f51157de397416bd;
}

function isunderwaterweapon(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);
  return isunderwaterweaponobject(weaponobj);
}

function isclimbweaponobject(weaponobj) {
  return weaponobj === level.var_f8ac15ada97a702a;
}

function isclimbweapon(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);
  return isclimbweaponobject(weaponobj);
}

function function_170e300815e9c1a2(weaponobj) {
  cachedvalue = level.weaponrootcache[weaponobj.basename];

  if(isDefined(cachedvalue)) {
    return cachedvalue;
  }

  return function_bed9d35e3ab4a80c(weaponobj.basename);
}

function getweaponrootname(weapon) {
  if(isweapon(weapon)) {
    return function_170e300815e9c1a2(weapon);
  } else if(isstring(weapon)) {
    cachedvalue = level.weaponrootcache[weapon];

    if(isDefined(cachedvalue)) {
      return cachedvalue;
    }

    return function_bed9d35e3ab4a80c(weapon);
  } else if(!isDefined(weapon)) {
    return "none";
  }

  assertmsg("<dev string:x61f>");
  return "none";
}

function private function_bed9d35e3ab4a80c(weaponname) {
  if(!isstring(weaponname)) {
    return "none";
  }

  if(!isDefined(level.weaponrootcache)) {
    level.weaponrootcache = [];
  }

  if(getdvarint(@ "hash_4d6608977410d9b7", 0) == 1) {
    rootname = undefined;

    if(isDefined(level.weaponmapdata[weaponname])) {
      return weaponname;
    } else {
      foreach(rootname, data in level.weaponmapdata) {
        if(weaponname === level.weaponmapdata[rootname].assetname) {
          level.weaponrootcache[weaponname] = rootname;
          return rootname;
        }
      }
    }
  }

  if(weaponname == "iw9_lm_dblmg_jup_sp_v1" || weaponname == "iw9_lm_dblmg_jup_mp" || weaponname == "iw9_lm_dblmg_jup") {
    return "iw9_lm_dblmg_jup";
  }

  if(weaponname == "jup_p33_me_tac_knife03_v6501") {
    return "iw9_me_knife";
  }

  originalname = weaponname;
  tokens = strtok(weaponname, "_");
  toksize = tokens.size;

  if(toksize == 0) {
    return "none";
  }

  index = 0;

  if(tokens[0] == "alt") {
    index++;
  }

  if(tokens[index] == "iw8" || tokens[index] == "iw9" || tokens[index] == "t10" || tokens[index] == "jup" || tokens[index] == "sat" || tokens[index] == "rex" || tokens[index] == "zul") {
    var_aedd151289ff3a0d = 0;
    classtokens = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "br", "sl", "ks", "pw", "ww"];

    if(tokens[index] == "jup" && toksize >= 4 && arraycontains(classtokens, tokens[index + 2])) {
      weaponname = function_5d044133536d0766("_", tokens, index, 4);
      var_aedd151289ff3a0d = isDefined(level.weaponmapdata[weaponname]);

      if(!var_aedd151289ff3a0d) {
        var_75f736509be71099 = 0;
        tmptokens = [];

        if(tokens[index + 1] == "iw9") {
          var_75f736509be71099 = index + 1;
        } else {
          var_75f736509be71099 = index + 2;
          tmptokens[tmptokens.size] = "iw9";
        }

        for(i = var_75f736509be71099; i < tokens.size; i++) {
          tmptokens[tmptokens.size] = tokens[i];
        }

        tokens = tmptokens;
        toksize = tokens.size;
      }
    }

    if(!var_aedd151289ff3a0d) {
      if(isDefined(tokens[index + 1]) && arraycontains(classtokens, tokens[index + 1])) {
        var_2c5926d25fc093da = tokens.size >= index + 2 && tokens[index + 2] == "zombie";

        if(tokens.size >= index + 4 && tokens[index] == "t10" && tokens[index + 3] != "mp" || var_2c5926d25fc093da) {
          weaponname = tokens[index] + "_" + tokens[index + 1] + "_" + tokens[index + 2] + "_" + tokens[index + 3];
        } else if(tokens.size >= index + 4 && tokens[index] == "zul" && tokens[index + 1] == "pw") {
          weaponname = tokens[index] + "_" + tokens[index + 1] + "_" + tokens[index + 2] + "_" + tokens[index + 3];
        } else {
          weaponname = tokens[index] + "_" + tokens[index + 1] + "_" + tokens[index + 2];
        }
      } else {
        weaponname = tokens[index] + "_" + tokens[index + 1];
      }
    }
  }

  if(level.weaponrootcache.size > 400) {
    level.weaponrootcache = [];
  }

  level.weaponrootcache[originalname] = weaponname;
  return weaponname;
}

function getweaponclasstoken(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);
  rootname = getweaponrootname(weaponobj);
  weapongroup = weapongroupmap(rootname);
  potentialtoken = "ar";

  switch (weapongroup) {
    case #"hash_8af0086b038622b5":
    case #"hash_dd616da0b395a0b0":
      potentialtoken = "ar";
      break;
    case #"hash_bef5ec0b3e197ae":
      potentialtoken = "lm";
      break;
    case #"hash_c095d67337b1f5a1":
      potentialtoken = "ar";
      break;
    case #"hash_47368bc0d2ef1565":
      potentialtoken = "dm";
      break;
    case #"hash_34340d457a63e7f1":
      potentialtoken = "ar";
      break;
    case #"hash_ab10f9c080fe4faf":
      potentialtoken = "sm";
      break;
    case #"hash_16cf6289ab06bd30":
      potentialtoken = "sh";
      break;
    case #"hash_9d18adab1b65a661":
      potentialtoken = "la";
      break;
    case #"hash_86b11ac21f992552":
    case #"hash_a1f27f97be15d620":
      potentialtoken = "me";
      break;
    case #"hash_2535634d8bb5c955":
    default:
      assertmsg("<dev string:x667>" + weaponobj.basenamehash);
      return undefined;
  }

  return potentialtoken;
}

function function_2374da6f1b4fad4e(weaponname, variantid) {
  if(!isDefined(weaponname) || weaponname == "none" || !isDefined(variantid) || variantid == 0) {
    return [];
  }

  ignorelist = [];
  var_3c796252addcd009 = function_7d4df70b836c0973(weaponname, variantid);
  var_b19fd3e8f03cc95c = % "hash_6064c8c15b75fb65";

  foreach(attachment, override in var_3c796252addcd009) {
    category = attachmentmap_tocategory(attachment);

    if(isDefined(category) && category != var_b19fd3e8f03cc95c) {
      ignorelist[ignorelist.size] = attachment;
    }
  }

  return ignorelist;
}

function issilencerattach(weapon, attachment) {
  return issilencedattachment(weapon, attachment);
}

function weaponsupportslaserir(weaponobj) {
  switch (weaponobj.basenamehash) {
    case % "iw9_minigunksjugg_reload_mp":
    case % "hash_73d81ba1da5e262":
    case % "iw9_minigunksjugg_mp":
    case % "iw9_lm_dblmg2_cp":
    case % "iw9_lm_dblmg_execution_mp":
    case % "iw9_me_riotshield_mp":
    case % "iw9_lm_dblmg_mp":
      return false;
  }

  if(iskillstreakweapon(weaponobj)) {
    return false;
  }

  if(isDefined(weaponobj.extra) && isDefined(weaponobj) && isDefined(weaponobj.variantid) && weaponobj.extra == "charlie725_doom_blueprint_tuning") {
    return false;
  }

  class = weaponclass(weaponobj);
  return class == "rifle" || class == "mg" || class == "sniper" || class == "smg" || class == "spread";
}

function iskillstreakplayerweapon(weapon) {
  weapname = getweaponname(weapon);

  if(issubstr(weapname, "_mp")) {
    if(iskillstreakweaponname(weapname)) {
      if(function_10d338d2560c67b2(weapname) || isminigunweapon(weapname)) {
        return true;
      }
    }
  }

  return false;
}

function issuperuseweapon(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x6b8>");
    return false;
  }

  weaponnamekey = isstring(weapon) ? getxhashasset(weapon) : isxhashasset(weapon) ? weapon : weapon.basenamehash;

  if(function_bebce04e93b55bfc(weaponnamekey)) {
    return true;
  }

  return isDefined(level.superglobals.superweapons[weaponnamekey]);
}

function issupergestureweapon(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weaponobj)) {
    return false;
  }

  switch (weaponobj.basenamehash) {
    case % "battlerage_nebulizer_mp":
    case % "electric_discharge_mp":
    case % "tempv_mp":
    case % "emp_pulse_device_mp":
      return true;
  }

  return false;
}

function function_bebce04e93b55bfc(var_b541b98c7febbc0) {
  if(!isDefined(var_b541b98c7febbc0)) {
    assertmsg("<dev string:x6fd>");
    return 0;
  }

  switch (var_b541b98c7febbc0) {
    case % "iw9_pi_stimpistol_mp":
    case % "iw9_oxygenmask_mp":
      return 1;
    default:
      return 0;
  }
}

function function_dec9dc19786bb57a(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x747>");
    return false;
  }

  weapname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon)) {
      return false;
    }

    weapname = weapon.basename;
  } else {
    if(weapon == "none") {
      return false;
    }

    weapname = weapon;
  }

  return weapname == "iw9_oxygenmask" || weapname == "iw9_oxygenmask_mp";
}

function isminigunweapon(weapon) {
  weapon = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x78e>");
    return false;
  }

  switch (weapon.basenamehash) {
    case % "iw9_minigunksjugg_reload_mp":
    case % "iw9_minigunksjugg_mp":
    case % "iw9_lm_dblmg2_cp":
    case % "iw9_lm_dblmg_jup_mp":
    case % "iw9_lm_dblmg_mp":
      return true;
  }

  return false;
}

function iskillstreakweaponname(weaponname) {
  return isDefined(level.killstreakweaponmap[weaponname]);
}

function iskillstreakweapon(weapon) {
  return iskillstreakweaponname(getweaponname(weapon));
}

function function_10d338d2560c67b2(weaponname) {
  return isDefined(level.var_4d7a26dff433ac89[weaponname]);
}

function function_597e1c0b6df2fada(weaponname) {
  return isDefined(level.var_4295719b442b453d[weaponname]);
}

function function_1344ad15d2d7bd21(weapon) {
  weaponname = getweaponname(weapon);
  return function_597e1c0b6df2fada(weaponname);
}

function function_6011e4dd56d52c6f(weapon) {
  weaponname = getweaponname(weapon);

  if(!isDefined(level.killstreakweaponmap[weaponname])) {
    return false;
  }

  streakname = level.killstreakweaponmap[weaponname];
  bundle = level.streakglobals.streakbundles[streakname];

  if(bundle.var_6437ad480a081375) {
    return false;
  }

  return true;
}

function registerkillstreakweaponmap(streakname, var_bf295ddc16ebf8a0) {
  if(!isDefined(level.killstreakweaponmap)) {
    level.killstreakweaponmap = [];
  }

  level.killstreakweaponmap[var_bf295ddc16ebf8a0] = streakname;
  registerkillstreakweapon(getxhashasset(streakname));
}

function registerplayerkillstreakweapon(weaponname) {
  if(!isDefined(level.var_4d7a26dff433ac89)) {
    level.var_4d7a26dff433ac89 = [];
  }

  level.var_4d7a26dff433ac89[weaponname] = 1;
}

function initkillstreakweaponmap() {
  if(!isDefined(level.killstreakweaponmap)) {
    level.killstreakweaponmap = [];
  }

  level.killstreakweaponmap["tacops_beacon_mp"] = "marker";
  level.killstreakweaponmap["radar_drone_proj_mp"] = "radar_drone_recon";
  level.killstreakweaponmap["gunship_105mm_mp"] = "gunship";
  level.killstreakweaponmap["manual_turret_mp"] = "manual_turret";
  level.killstreakweaponmap["nuke_mp"] = "nuke";
  level.killstreakweaponmap["artillery_mp"] = "precision_airstrike";
  level.killstreakweaponmap["iw9_spotter_scope_mp"] = "precision_airstrike";
  level.killstreakweaponmap["deploy_airdrop_mp"] = "airdrop";
  level.killstreakweaponmap["deploy_airdrop_sticky_mp"] = "airdrop";
  level.killstreakweaponmap["nuke_multi_mp"] = "nuke_multi";
  level.killstreakweaponmap["cruise_proj_mp"] = "cruise_predator";
  level.killstreakweaponmap["pac_sentry_turret_mp"] = "pac_sentry";
  level.killstreakweaponmap["toma_proj_mp"] = "toma_strike";
  level.killstreakweaponmap["iw9_laser_large_ir_mp"] = "toma_strike";
  level.killstreakweaponmap["chopper_gunner_turret_mp"] = "chopper_gunner";
  level.killstreakweaponmap["chopper_gunner_proj_mp"] = "chopper_gunner";
  level.killstreakweaponmap["chopper_gunner_turret_cp"] = "chopper_gunner";
  level.killstreakweaponmap["chopper_gunner_proj_cp"] = "chopper_gunner";
  level.killstreakweaponmap["fuelstrike_proj_mp"] = "fuel_airstrike";
  level.killstreakweaponmap["chopper_support_turret_mp"] = "chopper_support";
  level.killstreakweaponmap["chopper_support_turret_br"] = "chopper_support";
  level.killstreakweaponmap["deploy_sentry_mp"] = "sentry_gun";
  level.killstreakweaponmap["sentry_turret_mp"] = "sentry_gun";
  level.killstreakweaponmap["hover_jet_turret_mp"] = "hover_jet";
  level.killstreakweaponmap["hover_jet_proj_mp"] = "hover_jet";
  level.killstreakweaponmap["hover_jet_bomb_mp"] = "hover_jet";
  level.killstreakweaponmap["iw9_minigunksjugg_mp"] = "juggernaut";
  level.killstreakweaponmap["iw9_minigunksjugg_reload_mp"] = "juggernaut";
  level.killstreakweaponmap["deploy_juggernaut_mp"] = "juggernaut";
  level.killstreakweaponmap["assault_drone_mp"] = "assault_drone";
  level.killstreakweaponmap["assault_drone_danger_mp"] = "assault_drone";
  level.killstreakweaponmap["airdrop_escort_turret_mp"] = "airdrop_escort";
  level.killstreakweaponmap["super_laser_charge_mp"] = "super_laser_charge";
  level.killstreakweaponmap["electric_discharge_mp"] = "super_electric_discharge";
  level.killstreakweaponmap["high_jump_mp"] = "super_high_jump";
  level.killstreakweaponmap["airdrop_escort_turret_ballistics_mp"] = "airdrop_escort";
  level.killstreakweaponmap["chopper_gunner_turret_ballistics_mp"] = "chopper_gunner";
  level.killstreakweaponmap["hover_jet_turret_ballistics_mp"] = "hover_jet";
  level.killstreakweaponmap["switchblade_drone_mp"] = "switchblade_drone";
  level.killstreakweaponmap["lrad_mp"] = "lrad";
  level.killstreakweaponmap["deploy_remote_turret_mp"] = "remote_turret";
  level.killstreakweaponmap["remote_turret_mp"] = "remote_turret";
  level.killstreakweaponmap["loitering_munition_proj_mp"] = "loitering_munition";
  level.killstreakweaponmap["deploy_missileturret_jup_mp"] = "missile_turret";
  level.killstreakweaponmap["missile_turret_proj_jup_mp"] = "missile_turret";
  level.killstreakweaponmap["drone_swarm_drone_mp"] = "drone_swarm";
  level.killstreakweaponmap["toma_proj_jup_mp"] = "toma_strike";
  level.killstreakweaponmap["bunker_buster_proj_jup_mp"] = "bunker_buster";

  foreach(killstreak, killstreakweapon in level.killstreakweaponmap) {
    registerkillstreakweapon(getxhashasset(killstreak));
  }
}

function function_ea0f95c57e71d5b4(weapon) {
  weaponname = getweaponname(weapon);

  if(isDefined(level.killstreakweaponmap[weaponname])) {
    switch (weaponname) {
      case #"hash_10480ca9423043c7":
      case #"hash_4cdc20240e59faaf":
      case #"hash_9acbd2b1e30a8e0e":
        return true;
    }
  }

  return false;
}

function function_47517374aa9c98b7(weapon, attachmentname) {
  if(attachmentname == "none") {
    return true;
  }

  if(!isDefined(weapon) || isstring(weapon) && (weapon == "none" || weapon == "")) {
    return false;
  }

  rootname = getweaponrootname(weapon);
  weaponasset = weaponassetnamemap(rootname);
  weaponattachments = function_94e534c2a4d98789(weaponasset);
  attachmentslot = getattachmentslot(weaponasset, attachmentname);
  attachmentarray = weaponattachments[attachmentslot];

  if(isDefined(attachmentarray) && arraycontains(attachmentarray, attachmentname)) {
    return true;
  }

  return false;
}

function function_668a13182805f553(weapon, playerdatavalue) {
  if(function_47517374aa9c98b7(weapon, playerdatavalue)) {
    return playerdatavalue;
  }

  println("<dev string:x7d3>" + playerdatavalue);
  rootname = getweaponrootname(weapon);
  weaponasset = weaponassetnamemap(rootname);
  return getattachmentfromslotandindex(weaponasset, "receiver", 0);
}

function getweaponnvgattachment(weaponobj) {
  foreach(attachment in level.var_e0dc368290d94a40) {
    if(weaponobj canuseattachment(attachment)) {
      return attachment;
    }
  }

  return "invalid";
}

function function_12fc9c4fd8c1475(itemname, rarity, lootid, baseweapon, attachments, fullweaponname, titlestring, descstring, icon, pickupsound) {
  str = "<dev string:x802>";
  str += "<dev string:x80a>" + itemname;
  str += "<dev string:x80a>" + "<dev string:x810>";
  str += "<dev string:x80a>" + rarity;
  str += "<dev string:x80a>";
  str += "<dev string:x80a>" + lootid;
  str += "<dev string:x80a>";
  str += "<dev string:x80a>";
  str += "<dev string:x80a>" + baseweapon;
  str += "<dev string:x80a>";
  str += "<dev string:x80a>" + attachments;
  str += "<dev string:x80a>" + fullweaponname;
  str += "<dev string:x80a>" + function_a31c333e503a3fb0(titlestring);
  str += "<dev string:x80a>" + function_a31c333e503a3fb0(descstring);
  str += "<dev string:x80a>" + icon;
  str += "<dev string:x80a>" + pickupsound;
  return str;
}

function function_f763315b54ffbd() {
  attachmentlist = [];
  numrows = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(index = 0; index < numrows; index++) {
    attachmentname = tablelookupbyrow("mp/attachmenttable.csv", index, 4);

    if(attachmentname == "") {
      continue;
    }

    assert(!isDefined(attachmentlist[attachmentname]), "<dev string:x81a>" + attachmentname);
    attachmentlist[attachmentname] = attachmentname;
  }

  return attachmentlist;
}

function function_16ff7d597f441100() {
  var_7237854e3be197ca = level.weaponlistbundle;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  weaponslist = level.gametypebundle.weaponlist ?? level.gamemodebundle.weaponlist;

  if(weaponslist) {
    weaponlistbundle = getscriptbundle(weaponslist);

    if(isDefined(weaponlistbundle.weapons)) {
      level.weaponlistbundle = [];

      foreach(index, struct in weaponlistbundle.weapons) {
        if(isDefined(struct.weapondata)) {
          level.weaponlistbundle[index] = struct.weapondata;
        }
      }

      return level.weaponlistbundle;
    }
  }
}

function function_659a3e10e8d1c91c(weapon, keys) {
  return getscriptbundlefieldvalues(hashcat(%"hash_31705bf9ed477170", weapon), keys);
}

function function_e0801e95ac4c4925(attachment, keys) {
  return getscriptbundlefieldvalues(hashcat(%"hash_3c2c9813bb16552f", attachment), keys);
}

function function_c37ac3c4f987e506(weapon, key, def) {
  if(!isDefined(weapon)) {
    return undefined;
  }

  value = getscriptbundlefieldvalue(hashcat(%"hash_31705bf9ed477170", weapon), key);

  if(!isDefined(value)) {
    return def;
  }

  return value;
}

function function_94e534c2a4d98789(weapon) {
  slotarray = function_ea865062f19beca0();
  allattachments = [];

  foreach(slot in slotarray) {
    var_bba76b2d884ae9dc = function_2e5ecdd8ac47f308(weapon, slot);
    allattachments[slot] = var_bba76b2d884ae9dc;
  }

  return allattachments;
}

function function_ea865062f19beca0() {
  if(!isDefined(level.attachmentslotarray)) {
    level.attachmentslotarray = [];
    level.attachmentslotarray[level.attachmentslotarray.size] = "receiver";
    level.attachmentslotarray[level.attachmentslotarray.size] = "frontpiece";
    level.attachmentslotarray[level.attachmentslotarray.size] = "backpiece";
    level.attachmentslotarray[level.attachmentslotarray.size] = "magazine";
    level.attachmentslotarray[level.attachmentslotarray.size] = "override";
    level.attachmentslotarray[level.attachmentslotarray.size] = "muzzle";
    level.attachmentslotarray[level.attachmentslotarray.size] = "reargrip";
    level.attachmentslotarray[level.attachmentslotarray.size] = "trigger";
    level.attachmentslotarray[level.attachmentslotarray.size] = "extra";
    level.attachmentslotarray[level.attachmentslotarray.size] = "scope";
    level.attachmentslotarray[level.attachmentslotarray.size] = "underbarrel";
    level.attachmentslotarray[level.attachmentslotarray.size] = "modifier";
    level.attachmentslotarray[level.attachmentslotarray.size] = "conversionkit";
    level.attachmentslotarray[level.attachmentslotarray.size] = "other";
  }

  return level.attachmentslotarray;
}

function function_42e884104fc16220(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weaponobj)) {
    return 0;
  }

  currentweapon = 0;

  switch (weaponobj.basenamehash) {
    case % "super_remote_map_mp":
    case % "ks_remote_map_mp":
      currentweapon = 1;
      break;
  }

  return currentweapon;
}

function isdeploytablet(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weaponobj)) {
    return 0;
  }

  currentweapon = 0;

  switch (weaponobj.basenamehash) {
    case % "ks_remote_device_mp":
    case % "super_remote_device_mp":
    case % "hash_6faa69ebfba55c59":
      currentweapon = 1;
      break;
  }

  return currentweapon;
}

function function_2c9350ef77bdf665(weapon) {
  weaponname = weapon.basename;

  if(!isDefined(weaponname)) {
    return false;
  }

  return weaponname == "super_remote_map_mp";
}

function getweaponlootid(weaponobj) {
  if(!isweapon(weaponobj)) {
    assertmsg("<dev string:x860>");
    return false;
  }

  return weaponobj.weaponblueprint.lootid ?? weaponobj.baseweaponlootid;
}

function function_d54329f1701d6349(weapon) {
  weaponlootid = 0;
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    assert(isstring(weapon));
    weaponname = weapon;
  }

  if(isDefined(weaponname)) {
    weaponrootname = getweaponrootname(weaponname);

    if(isDefined(level.weaponmapdata[weaponrootname].weaponlootid)) {
      weaponlootid = level.weaponmapdata[weaponrootname].weaponlootid;
    }
  }

  return weaponlootid;
}

function function_57559cfce1d2812d(weapon) {
  if(getdvarint(@ "hash_8f727124cb64ae24", 1) == 1) {
    weaponlootid = function_d54329f1701d6349(weapon);

    if(weaponlootid != 0) {
      return weaponlootid;
    }
  }

  if(!isDefined(level.specialweaponlist)) {
    level.specialweaponlist = [];
  }

  weaponname = function_59714dddb66e6b88(weapon);

  if(!isDefined(weaponname)) {
    return 0;
  }

  if(isDefined(level.specialweaponlist[weaponname])) {
    return level.specialweaponlist[weaponname];
  }

  id = tablelookup("loot/special_weapon_ids.csv", 1, weaponname, 0);

  if(!isDefined(id) || id == "0" || id == "") {
    return 0;
  }

  id = int(id);

  if(isDefined(id)) {
    level.specialweaponlist[weaponname] = id;
    return id;
  }

  return getweaponlootid(weapon);
}

function function_59714dddb66e6b88(weapon) {
  weaponname = "";
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weaponobj)) {
    return weaponname;
  }

  switch (weaponobj.basenamehash) {
    case % "iw9_mg_mrap_mp":
    case % "iw9_tur_mrap_mp":
      weaponname = "iw9_tur_mrap_mp";
      break;
    case % "iw9_mg_patrol_boat_back_mp":
    case % "iw9_mg_patrol_boat_front_mp":
      weaponname = "iw9_mg_patrol_boat_front_mp";
      break;
    case % "iw9_mg_cougar_mp":
    case % "iw9_tur_cougar_mp":
      weaponname = "iw9_tur_cougar_mp";
      break;
  }

  return weaponname;
}

function getgrenadeinpullback() {
  offhandweapon = self getheldoffhand();

  if(isDefined(self.gestureweapon) && offhandweapon == makeweaponfromstring(self.gestureweapon)) {
    offhandweapon = nullweapon();
  }

  return offhandweapon;
}

function isweaponequipment(weapon) {
  return istrue(weapon.inventorytype == "offhand");
}

function isequipmentaddon(weapon) {
  if(weapon == "iw9_knifestab") {
    return true;
  }

  return false;
}

function getweaponbotpersonalities(weapon) {
  rootname = getweaponrootname(weapon);
  return level.weaponmapdata[rootname].botpersonalities;
}

function function_ad2262e5ff0331a3(weapon) {
  if(function_180f246714b6c204(weapon)) {
    return false;
  }

  if(function_7974b348bf7596e9(weapon)) {
    return false;
  }

  return true;
}

function isspreadweapon(objweapon) {
  return isDefined(objweapon) && isDefined(weaponclass(objweapon)) && weaponclass(objweapon) == "spread";
}

function iswonderweapon(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x89c>");
    return 0;
  }

  if(!isDefined(level.weaponmetadata)) {
    return 0;
  }

  hash_weapon_name = weapon.var_1616e6fbba9a722d;

  if(!isDefined(hash_weapon_name)) {
    return 0;
  }

  metadata = level.weaponmetadata[hash_weapon_name];

  if(isDefined(metadata.iswonderweapon)) {
    return metadata.iswonderweapon;
  }

  return 0;
}

function isbackuppistol(weapon) {
  return weapon hasattachmenthash(%"backup_pistol");
}

function private autoexec function_99b866e5ee9fe6d3() {
  setdevdvar(@ "hash_c30411f274497e85", "<dev string:x8de>");

  buildweaponmap();
  buildattachmentmaps();
  function_47c21f91a5f180b8();
}

function fixupplayerweapons(player, weapon) {
  currentplayerweapons = player getweaponslistprimaries();
  dirtyprimary = 1;
  dirtysecondary = 1;
  weaponname = undefined;
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(isweapon(weapon)) {
    weaponname = getcompleteweaponname(weapon);
  }

  foreach(currentweapon in currentplayerweapons) {
    if(isDefined(player.primaryweaponobj) && player.primaryweaponobj == currentweapon) {
      dirtyprimary = 0;
      continue;
    }

    if(isDefined(player.secondaryweaponobj) && player.secondaryweaponobj == currentweapon) {
      dirtysecondary = 0;
    }
  }

  if(dirtyprimary) {
    player.primaryweapon = weaponname;
    player.primaryweaponobj = weaponobj;
  } else if(dirtysecondary) {
    player.secondaryweapon = weaponname;
    player.secondaryweaponobj = weaponobj;
  }

  return dirtyprimary || dirtysecondary;
}

function getmaxattachments(slot, wildcard) {
  maxattachments = level.maxattachments[slot];

  if(wildcard == "wildcard_gunfighter") {
    return maxattachments.gunfighter;
  }

  return maxattachments.standard;
}

function getmaxprimaryattachments(wildcard) {
  return getmaxattachments(0, wildcard);
}

function getmaxsecondaryattachments(wildcard) {
  return getmaxattachments(1, wildcard);
}

function function_222f1c49e082a080(wildcard) {
  return getmaxattachments(2, wildcard);
}

function function_45ab75ece154ca8f() {
  return getmaxprimaryattachments("wildcard_gunfighter");
}

function function_a7a39da0cf2d5b5b() {
  return getmaxsecondaryattachments("wildcard_gunfighter");
}

function function_bedf9f9cfa13920d() {
  return function_222f1c49e082a080("wildcard_gunfighter");
}

function getslotcount() {
  return level.maxattachments.size;
}

function function_89d2d0588f2def25() {
  return self.mineid && level.var_4aa2b67bae0df4a0[self.mineid];
}

function registermine() {
  function_684646ff6cec7318();
}

function deregistermine() {
  function_dbdd90c189df6c61();
}

function function_438072bd0efdcff3() {
  return arraycopy(level.var_4aa2b67bae0df4a0);
}

function function_3aafcaf7ff6dea9e() {
  return level.var_4aa2b67bae0df4a0;
}

function private initializemines() {
  level.var_4aa2b67bae0df4a0 = [];
  level.var_f7303e01ed5fe77f = 9999;
}

function private function_684646ff6cec7318() {
  self.mineid = level.var_f7303e01ed5fe77f;
  level.var_f7303e01ed5fe77f++;
  level.var_4aa2b67bae0df4a0[self.mineid] = self;
}

function private function_dbdd90c189df6c61() {
  assert(isDefined(self.mineid));
  level.var_4aa2b67bae0df4a0[self.mineid] = undefined;
}
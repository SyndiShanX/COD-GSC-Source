/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\scripted_weapon_assignment.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace scripted_weapon_assignment;

function private autoexec __init__system__() {
  system::register(#"scripted_weapon_assignment", #"hash_5be25b1b277ec962", &pre_main, &post_main);
}

function private pre_main() {
  if(function_9c44e6874f16932e(1 | 64 | 2 | 4 | 8 | 16 | 32)) {
    return;
  }

  function_3a64cad36d140362();

  setdvarifuninitialized(@ "hash_3e61c087abf09c8e", 0);

  setdvarifuninitialized(@ "scr_debug_loot_items", 0);

  level.player thread function_17f51b17cfb0aa3e();
}

function private post_main() {
  if(function_9c44e6874f16932e(1 | 64 | 2 | 4 | 8 | 16 | 32)) {
    return;
  }

  level thread function_712211a62183a93d();
}

function private function_3a64cad36d140362() {
  level.lootitemdefs = [];
  level.var_7ed09656a10939f1 = [];
  level.lootitemdefsweapon = [];
  level.var_3b92c361776fbe01 = [];

  if(!isDefined(level.gamemodebundle.var_4f35c36a61d1db54)) {
    return;
  }

  list = getscriptbundle(level.gamemodebundle.var_4f35c36a61d1db54);

  if(!isDefined(list.defsets)) {
    return;
  }

  globalindex = -1;

  foreach(setindex, defset in list.defsets) {
    tags = undefined;

    if(isDefined(defset.tags)) {
      tags = strtok(defset.tags, "\b\x85\x9d\x11");
      hashtags = [];
      assettags = [];

      foreach(tag in tags) {
        hashtags[getxhash(tag)] = tag;
        assettags[getxhashasset(tag)] = tag;
      }

      tags = hashtags;
      var_351af79b4dc57da5 = !isDefined(level.var_9647332d18e30c8f);

      foreach(tag in assettags) {
        if(isDefined(level.var_9647332d18e30c8f[hash])) {
          var_351af79b4dc57da5 = 1;
          break;
        }
      }

      if(!var_351af79b4dc57da5) {
        continue;
      }
    }

    foreach(itemindex, def in defset.deflist) {
      if(!isDefined(def.defitem)) {
        continue;
      }

      defbundle = getscriptbundle(def.defitem);

      if(!isDefined(defbundle)) {
        continue;
      }

      if((defbundle.deckcount ?? 1) <= 0) {
        continue;
      }

      if(!isDefined(defbundle.bulletweapon)) {
        continue;
      }

      assert(setindex <= 15);
      assert(setindex >= 0);
      assert(itemindex <= 2047);
      assert(itemindex >= 0);
      globalindex = setindex << 11 | itemindex;
      assert(globalindex <= 32767);
      bulletweaponhash = getxhashasset(defbundle.bulletweapon);
      attachments = [];
      attachmentscount = undefined;

      if(isDefined(defbundle.attachments)) {
        foreach(index, att in defbundle.attachments) {
          if(att.attachment == "") {
            att.attachment = undefined;
          }

          attachments[index] = att.attachment;
        }

        if(attachments.size != defbundle.attachments.size) {
          attachmentscount = defbundle.attachments.size;
        }
      }

      attachmentsa = undefined;
      attachmentsacount = undefined;

      if(isDefined(defbundle.attachmentsa)) {
        attachmentsa = [];

        foreach(index, att in defbundle.attachmentsa) {
          if(att.attachment == "") {
            att.attachment = undefined;
          }

          attachmentsa[index] = att.attachment;
        }

        if(attachmentsa.size != defbundle.attachmentsa.size) {
          attachmentsacount = defbundle.attachmentsa.size;
        }
      }

      attachmentsb = undefined;
      attachmentsbcount = undefined;

      if(isDefined(defbundle.attachmentsb)) {
        attachmentsb = [];

        foreach(index, att in defbundle.attachmentsb) {
          if(att.attachment == "") {
            att.attachment = undefined;
          }

          attachmentsb[index] = att.attachment;
        }

        if(attachmentsb.size != defbundle.attachmentsb.size) {
          attachmentsbcount = defbundle.attachmentsb.size;
        }
      }

      attachmentsc = undefined;
      attachmentsccount = undefined;

      if(isDefined(defbundle.attachmentsc)) {
        attachmentsc = [];

        foreach(index, att in defbundle.attachmentsc) {
          if(att.attachment == "") {
            att.attachment = undefined;
          }

          attachmentsc[index] = att.attachment;
        }

        if(attachmentsc.size != defbundle.attachmentsc.size) {
          attachmentsccount = defbundle.attachmentsc.size;
        }
      }

      attachmentsd = undefined;
      attachmentsdcount = undefined;

      if(isDefined(defbundle.attachmentsd)) {
        attachmentsd = [];

        foreach(index, att in defbundle.attachmentsd) {
          if(att.attachment == "") {
            att.attachment = undefined;
          }

          attachmentsd[index] = att.attachment;
        }

        if(attachmentsd.size != defbundle.attachmentsd.size) {
          attachmentsdcount = defbundle.attachmentsd.size;
        }
      }

      attachmentse = undefined;
      attachmentsecount = undefined;

      if(isDefined(defbundle.attachmentse)) {
        attachmentse = [];

        foreach(att in defbundle.attachmentse) {
          if(att.attachment == "") {
            att.attachment = undefined;
          }

          attachmentse[index] = att.attachment;
        }

        if(attachmentse.size != defbundle.attachmentse.size) {
          attachmentsecount = defbundle.attachmentse.size;
        }
      }

      if(!isDefined(level.lootitemdefs[bulletweaponhash])) {
        level.lootitemdefs[bulletweaponhash] = [];
      }

      if(!isDefined(level.lootitemdefsweapon[bulletweaponhash])) {
        level.lootitemdefsweapon[bulletweaponhash] = [];
      }

      if(!isDefined(level.var_1bf4a91706167988)) {
        level.var_1bf4a91706167988 = [];
      }

      itemdef = {
        #tags: tags, #basename: defbundle.bulletweapon, #index: globalindex
      };
      itemdef.attachments = attachments;
      itemdef.attachmentscount = attachmentscount;
      itemdef.attachmentsa = attachmentsa;
      itemdef.attachmentsacount = attachmentsacount;
      itemdef.attachmentsb = attachmentsb;
      itemdef.attachmentsbcount = attachmentsbcount;
      itemdef.attachmentsc = attachmentsc;
      itemdef.attachmentsccount = attachmentsccount;
      itemdef.attachmentsd = attachmentsd;
      itemdef.attachmentsdcount = attachmentsdcount;
      itemdef.attachmentse = attachmentse;
      itemdef.attachmentsecount = attachmentsecount;
      level.lootitemdefnames[def.defitem] = itemdef;
      level.lootitemdefsweapon[bulletweaponhash][level.lootitemdefsweapon[bulletweaponhash].size] = itemdef;
      level.var_1bf4a91706167988[def.defitem] = itemdef;
      deckcount = defbundle.deckcount ?? 1;

      if(getdvarint(@ "hash_3e61c087abf09c8e", 0)) {
        deckcount = 1;
      }

      for(i = 0; i < deckcount; i++) {
        newindex = level.lootitemdefs[bulletweaponhash].size;
        level.lootitemdefs[bulletweaponhash][newindex] = itemdef;
      }
    }
  }

  buckets = [];
  alltags = [];

  foreach(bulletweaponhash, itemdefs in level.lootitemdefs) {
    foreach(itemdef in itemdefs) {
      if(isDefined(itemdef.tags)) {
        foreach(taghash, tag in itemdef.tags) {
          alltags[taghash] = tag;
        }
      }
    }
  }

  foreach(bulletweaponhash, itemdefs in level.lootitemdefs) {
    buckets[bulletweaponhash] = [];

    foreach(itemdef in itemdefs) {
      if(isDefined(itemdef.tags)) {
        foreach(taghash, tag in itemdef.tags) {
          if(!isDefined(buckets[bulletweaponhash][taghash])) {
            buckets[bulletweaponhash][taghash] = [];
          }

          buckets[bulletweaponhash][taghash][buckets[bulletweaponhash][taghash].size] = itemdef;
        }

        continue;
      }

      if(!isDefined(buckets[bulletweaponhash]["r \x83"])) {
        buckets[bulletweaponhash]["r \x83"] = [];
      }

      buckets[bulletweaponhash]["r \x83"][buckets[bulletweaponhash]["r \x83"].size] = itemdef;

      foreach(taghash, tag in alltags) {
        if(!isDefined(buckets[bulletweaponhash][taghash])) {
          buckets[bulletweaponhash][taghash] = [];
        }

        buckets[bulletweaponhash][taghash][buckets[bulletweaponhash][taghash].size] = itemdef;
      }
    }
  }

  foreach(bulletweaponhash, tags in buckets) {
    foreach(itemdefs in tags) {
      foreach(itemdef in itemdefs) {
        itemdef.tags = undefined;
      }
    }
  }

  foreach(bulletweaponhash, tags in buckets) {
    level.lootitemdefs[bulletweaponhash] = [];

    foreach(tag, itemdefs in tags) {
      level.lootitemdefs[bulletweaponhash][tag] = utility::create_deck(itemdefs, 1, 1);
    }
  }
}

function private function_712211a62183a93d() {
  waitframe();
  ents = getEntArray();

  foreach(ent in ents) {
    if(!isDefined(ent.classname)) {
      continue;
    }

    if(getsubstr(ent.classname, 0, "r\x15U\xae\x95\xae\xc3".size) == "r\x15U\xae\x95\xae\xc3") {
      ent function_497263086ba32120(ent.spawnflags);
    }
  }
}

function getweapondeck(tag, basename, var_2b49818b367b5a9) {
  deck = undefined;
  basenamehash = getxhashasset(basename);
  decks = level.lootitemdefs[basenamehash];

  if(!isDefined(decks)) {
    decks = level.lootitemdefs[var_2b49818b367b5a9];
  }

  if(isDefined(decks)) {
    deck = decks[tag];

    if(!isDefined(deck)) {
      deck = decks["r \x83"];
    }
  }

  return deck;
}

function function_2b4c9a30f41b2a6f(weapon) {
  if(!isweapon(weapon) && isDefined(weapon.classname)) {
    completename = getsubstr(weapon.classname, "r\x15U\xae\x95\xae\xc3".size);
    parts = strtok(completename, "\x90\x9f");

    if(parts.size == 0) {
      return 0;
    }

    basename = parts[0];
    attachments = arrayremove(parts, basename);
    weapon = makeweapon(basename, attachments);
  }

  if(!isweapon(weapon)) {
    return 0;
  }

  lootitem = function_ce2f6db79985e942(weapon);

  if(isDefined(lootitem)) {
    return lootitem;
  }

  return 0;
}

function function_497263086ba32120(spawnflags = 0) {
  if(isstring(self.var_8e196322b25b48e1)) {
    assethash = getxhashasset("\x8a\\\xcd\x06\xa9\xc5_\x98\x9c\xdc-E\x06ml\x1f\xb8J\xf9\x14\x80`N" + self.var_8e196322b25b48e1);
    itemdef = level.lootitemdefnames[assethash];

    if(isDefined(itemdef)) {
      weapon = function_51940adc23c9833f(itemdef);

      if(isweapon(weapon)) {
        weaponcompletename = getcompleteweaponname(weapon);
        origin = self.origin;
        angles = self.angles;
        self delete();
        droppedweaponentity = spawn("r\x15U\xae\x95\xae\xc3" + weaponcompletename, origin, spawnflags);

        if(isDefined(droppedweaponentity)) {
          droppedweaponentity.angles = angles;
          thread utility::callsharedfunc(#"loot", #"dropWeaponPost", droppedweaponentity);
          droppedweaponentity function_a40aafc5a10e20da(itemdef.index);
          return droppedweaponentity;
        }
      }
    } else {
      iprintlnbold("<dev string:x24>" + self.var_8e196322b25b48e1);
    }
  }

  lootitem = function_ce2f6db79985e942(self);

  if(isDefined(lootitem)) {
    self function_a40aafc5a10e20da(lootitem);
  }

  return self;
}

function function_66de7803f693e3a5(itemdef) {
  useattachments = itemdef.attachments;

  if(isarray(itemdef.attachmentsa) && itemdef.attachmentsa.size > 0) {
    range = itemdef.attachmentsacount ?? itemdef.attachmentsa.size;
    useattachments[useattachments.size] = itemdef.attachmentsa[randomint(range)];
  }

  if(isarray(itemdef.attachmentsb) && itemdef.attachmentsb.size > 0) {
    range = itemdef.attachmentsbcount ?? itemdef.attachmentsb.size;
    useattachments[useattachments.size] = itemdef.attachmentsb[randomint(range)];
  }

  if(isarray(itemdef.attachmentsc) && itemdef.attachmentsc.size > 0) {
    range = itemdef.attachmentsccount ?? itemdef.attachmentsc.size;
    useattachments[useattachments.size] = itemdef.attachmentsc[randomint(range)];
  }

  if(isarray(itemdef.attachmentsd) && itemdef.attachmentsd.size > 0) {
    range = itemdef.attachmentsdcount ?? itemdef.attachmentsd.size;
    useattachments[useattachments.size] = itemdef.attachmentsd[randomint(range)];
  }

  if(isarray(itemdef.attachmentse) && itemdef.attachmentse.size > 0) {
    range = itemdef.attachmentsecount ?? itemdef.attachmentse.size;
    useattachments[useattachments.size] = itemdef.attachmentse[randomint(range)];
  }

  return useattachments;
}

function function_51940adc23c9833f(itemdef) {
  useattachments = function_66de7803f693e3a5(itemdef);
  return utility_sp::make_weapon(itemdef.basename, useattachments);
}

function function_2a6fcb0d09b14b12(itemdefhash) {
  itemdef = level.var_1bf4a91706167988[itemdefhash];

  if(isDefined(itemdef)) {
    weapon = function_51940adc23c9833f(itemdef);

    if(isweapon(weapon)) {
      fullname = getcompleteweaponname(weapon);
      level.var_3b92c361776fbe01[fullname] = itemdef.index;
    }

    return weapon;
  }

  return undefined;
}

function function_ce2f6db79985e942(weapon) {
  basename = weapon;

  if(!isstring(basename)) {
    basename = getweaponbasename(weapon);
  }

  basename = getxhashasset(basename);
  defs = level.lootitemdefsweapon[basename];

  if(!isDefined(defs)) {
    return undefined;
  }

  if(isstring(weapon)) {
    weapon = makeweapon(weapon);
  }

  if(!isweapon(weapon) && isDefined(weapon.classname)) {
    completename = getsubstr(weapon.classname, "r\x15U\xae\x95\xae\xc3".size);
    parts = strtok(completename, "\x90\x9f");

    if(parts.size == 0) {
      return 0;
    }

    basename = parts[0];
    attachments = arrayremove(parts, basename);
    weapon = makeweapon(basename, attachments);
  }

  foreach(itemdef in defs) {
    if(function_eb5b8078822e71bf(itemdef, weapon)) {
      return itemdef.index;
    }
  }
}

function private function_eb5b8078822e71bf(itemdef, weapon) {
  attachments = getweaponattachments(weapon);
  defattachments = getweapondefaultattachments(weapon);

  foreach(key, attachment in attachments) {
    foreach(att in defattachments) {
      if(att == attachment) {
        attachments[key] = undefined;
        break;
      }
    }
  }

  alwaysattached = arraycopy(itemdef.attachments ?? []);
  lists = [alwaysattached, itemdef.attachmentsa, itemdef.attachmentsb, itemdef.attachmentsc, itemdef.attachmentsd, itemdef.attachmentse];

  foreach(attachment in attachments) {
    foreach(listindex, list in lists) {
      foreach(att in list) {
        if(att == attachment) {
          attachments[key] = undefined;

          if(listindex == 0) {
            alwaysattached[attachindex] = undefined;
            continue;
          }

          lists[listindex] = undefined;
          break;
        }
      }
    }
  }

  return attachments.size == 0 && alwaysattached.size == 0 && lists.size == 1 && isDefined(lists[0]);
}

function getscriptedweapon(weaponname, weaponposition) {
  setdvarifuninitialized(@ "hash_45281f93550798", 0);

  if(!isDefined(weaponname)) {
    return nullweapon();
  }

  if(isweapon(weaponname)) {
    if(isundefinedweapon(weaponname)) {
      return weaponname;
    }

    weaponname = weaponname.basename;
  }

  if(!isarray(weaponname) && weaponname == "") {
    return nullweapon();
  }

  if(isstring(weaponname) && issubstr(weaponname, "k\xad\xb8<9\xcey\xdc\x14\xac")) {
    return [[level.fnbuildweapon]](weaponname);
  }

  if(isDefined(weaponposition) && weaponposition == "\xd64*\xa3I\x12\xef") {
    weapon = getweapon(weaponname, "\x8e\xfcc\xbe\xdf\xa6");
  } else {
    weapon = getweapon(weaponname, self.scriptedweaponclassprimary);
  }

  return weapon;
}

function function_17f51b17cfb0aa3e() {
  self endon("<dev string:x40>");

  while(true) {
    waitframe();

    if(getdvarint(@ "scr_debug_loot_items", 0)) {
      ents = getEntArray();
      bestdot = 0;
      bestweapon = undefined;
      offset = (0, 0, 40);
      lookangles = self getplayerangles();
      lookdir = anglesToForward(lookangles);
      lookright = anglestoright(lookangles);

      foreach(ent in ents) {
        if(!isDefined(ent.classname)) {
          continue;
        }

        if(getsubstr(ent.classname, 0, "<dev string:x57>".size) == "<dev string:x57>") {
          delta = ent.origin + offset - self getEye();

          if(lengthsquared(delta) < 10000) {
            dot = vectordot(vectorNormalize(delta), lookdir);

            if(dot > bestdot) {
              bestdot = dot;
              bestweapon = ent;
            }
          }
        }
      }

      foreach(ent in ents) {
        if(!isDefined(ent.classname)) {
          continue;
        }

        if(getsubstr(ent.classname, 0, "<dev string:x57>".size) == "<dev string:x57>") {
          ent function_92c11effe29be46b(offset, ent == bestweapon, lookright, ent.weapondeck);
        }
      }

      continue;
    }

    wait 1;
  }
}

function function_92c11effe29be46b(offset, fullinfo, lookright, deck) {
  if(!isDefined(fullinfo)) {
    fullinfo = 0;
  }

  if(!isDefined(lookright)) {
    lookright = undefined;
  }

  if(!isDefined(deck)) {
    deck = undefined;
  }

  if(!isweapon(self) || !isent(self)) {
    return;
  }

  lootindex = self function_16d66b550caccc16();
  itemindex = lootindex & 2047;
  setindex = (lootindex &~2047) >> 11;
  settext = "<dev string:x62>";
  itemtext = "<dev string:x62>";
  decktext = "<dev string:x62>";
  loctext = "<dev string:x62>";
  scale = 0.07;
  step = (0, 0, -1);
  idcolor = (1, 1, 1);
  idtext = "<dev string:x66>";

  if(lootindex) {
    idtext = "<dev string:x78>" + lootindex;
    idcolor = (0.5, 0.5, 1);
  }

  txtpos = self.origin;

  if(self tagexists("<dev string:x80>")) {
    txtpos = self gettagorigin("<dev string:x80>");
  }

  txtpos += offset;

  if(fullinfo) {
    linecolor = (1, 1, 1);
    linealpha = 0.75;
    line(txtpos + (0, 0, 1), txtpos - offset, linecolor, linealpha, 0, 1);
  }

  if(isvector(lookright)) {
    txtpos += lookright * 0.5;
  }

  if(lootindex && isDefined(level.gamemodebundle.var_4f35c36a61d1db54)) {
    list = getscriptbundle(level.gamemodebundle.var_4f35c36a61d1db54);

    if(isDefined(list.defsets)) {
      set = list.defsets[setindex];

      if(isDefined(set.tags)) {
        settext = set.tags;
      }

      defitem = set.deflist[itemindex].defitem;

      if(isDefined(defitem)) {
        itemtext = getsubstr(getxhashsourcename(defitem), "<dev string:x8d>".size);
        item = getscriptbundle(defitem);

        if(isDefined(item)) {
          loctext = isDefined(item.title) ? function_30e4f86dded0873(item.title) : "<dev string:xa8>";

          if(isDefined(deck.items)) {
            decktext = "<dev string:x62>" + (item.deckcount ?? 1) + "<dev string:xb7>" + deck.items.size + "<dev string:xbc>" + int(float(item.deckcount ?? 1) / float(deck.items.size) * 100) + "<dev string:xc3>";
          }

          if(isDefined(item.title)) {
            idcolor = (1, 1, 0);
          }
        }
      }
    }
  }

  if(lootindex) {
    print3d(txtpos, idtext, idcolor, 1, scale, 1);
    txtpos += step;
  }

  if(fullinfo) {
    if(lootindex) {
      print3d(txtpos, "<dev string:xca>" + setindex + "<dev string:xd3>" + settext, (1, 1, 1), 1, scale, 1);
      txtpos += step;
      print3d(txtpos, "<dev string:xd8>" + itemindex + "<dev string:xd3>" + itemtext, (1, 1, 1), 1, scale, 1);
      txtpos += step;
      print3d(txtpos, "<dev string:xe2>" + loctext, (1, 1, 1), 1, scale, 1);
      txtpos += step;

      if(isDefined(deck)) {
        print3d(txtpos, "<dev string:xeb>" + decktext, (1, 1, 1), 1, scale, 1);
        txtpos += step;
      }
    }

    txtpos += step;
    print3d(txtpos, "<dev string:xf5>" + getweaponbasename(self) + "<dev string:xfa>", (0.85, 0.85, 0.85), 1, scale, 1);
    txtpos += step;
    attachments = getweaponattachments(self);

    foreach(att in attachments) {
      print3d(txtpos, att, (0.75, 0.75, 0.75), 1, scale, 1);
      txtpos += step;
    }
  }
}

function getweapon(weaponname, weapontype) {
  weaponarray = [];

  if(isarray(weaponname)) {
    weaponarray = weaponname;
    weaponname = weaponname[randomint(weaponname.size)];
  } else {
    weaponarray[0] = weaponname;
  }

  low_classname = tolower(self.classname);

  if(!issubstr(low_classname, "_[O/\xd9") && !issubstr(low_classname, "4\x17\xcc4\x87") && !issubstr(low_classname, "\x88\x1a\x8e\x04\xbf")) {
    function_67673f10d815ddc9();

    return utility_sp::make_weapon(weaponname);
  }

  if(issubstr(low_classname, "\x88\x1a\x8e\x04\xbf")) {
    if(issubstr(low_classname, "\xd82\xd6\xae\xa2V0")) {
      return function_1aed348fc628ee06(weapontype, weaponname, weaponarray);
    } else {
      function_67673f10d815ddc9();

      return utility_sp::make_weapon(weaponname);
    }
  } else if(issubstr(low_classname, "4\x17\xcc4\x87")) {
    if(issubstr(low_classname, "\xfah+\x9c\xf6\xfa") || issubstr(low_classname, "\x8c\xfcnT\xccW\xaaU\xe5")) {
      return function_73dd1597fcc39671(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xc7\xdcJ\xe5O\xe1E\xed\xfd") || issubstr(low_classname, "\xe5INh\a\xc0eq\x90")) {
      return function_4a4e093e68d8b794(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\x0e\xc37f!\f\xb1/")) {
      return function_8b9385c23c890c79(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xa3T\xef?\xa06")) {
      return function_ebd10db200336aa0(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\x0e\xc1\xcd\xd4\f\x93\xe9\xc0f\xb5\xa5")) {
      return function_c8692a6471afc64a(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, ",&'9f\xfb\xb1\xef")) {
      return function_7610ded771ec8704(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "C\xc0\xa4\xe0\x9f\xe3\xd6\xf6\xcd\xa7\xa3")) {
      return function_b949642ebbf4c9e5(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "BU\xe0N\x9c\xdd\xfa\"\xa8\xa5\xde#\xbc") || issubstr(low_classname, "+\xe0V\xb3N\x1d\x06\xdf\xdb\x9d")) {
      return function_49a6236512619d95(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "2\xbd\xa2g\x0e")) {
      return function_cc70fa21e5c25570(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xf9\xef\x13\xec\x06}\xd08\xdc\x14\xfe")) {
      return function_30aab1919ebf9407(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "n\x85\xb9\xbe\x98N\x85g\xde\xaf")) {
      return function_67d60e1bb16ef10f(weapontype, weaponname, weaponarray);
    } else {
      function_67673f10d815ddc9();

      return utility_sp::make_weapon(weaponname);
    }
  } else if(issubstr(low_classname, "_[O/\xd9")) {
    if(issubstr(low_classname, "\xfah+\x9c\xf6\xfa") || issubstr(low_classname, "\x8c\xfcnT\xccW\xaaU\xe5")) {
      return function_db843fe55ef1e21d(weaponname, weaponarray);
    } else if(issubstr(low_classname, "@\x05\xfe\x96\x118\x97:")) {
      return function_b99cc07e9e44a17b(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "&h8m\xe97\x957\xe7\xe4\x97\xdd")) {
      return function_b99cc07e9e44a17b(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xfa\xb6\x95\xc3\xd7")) {
      return function_33633a8040e8673f(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "2\xbd\xa2g\x0e")) {
      return function_4cec8b8c6b92da5c(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xecx\xa7d,\xb2")) {
      return function_2d98a2e7aeff82a5(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xfe\xa3'\xe7\xe1%\xfe\x87u;k\x9b\xc5\xaf")) {
      return function_ac95f98c94c57bb0(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "D@\xd9\xa9\x90F\xd7\x03")) {
      return function_1e6528055a7fdafa(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xc7\xdcJ\xe5O\xe1E\xed\xfd")) {
      return function_4eb113a0d62bba80(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "lY~i;")) {
      return function_c96fe324b16a84a1(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "\xfa\xcf\b\xb1\x87\x1a'\xb7\xdf")) {
      return function_d7a0967da3cd1433(weapontype, weaponname, weaponarray);
    } else if(issubstr(low_classname, "v\xfb\xf9x")) {
      return function_864a7b254c5ce41f(weapontype, weaponname, weaponarray);
    } else {
      function_67673f10d815ddc9();

      return utility_sp::make_weapon(weaponname);
    }
  } else {
    function_67673f10d815ddc9();

    return utility_sp::make_weapon(weaponname);
  }

  return weaponname;
}

function function_73dd1597fcc39671(type, weaponname, weaponarray) {
  if(self.classname == "e%\x89\xcf\xedZ\xbd:[\xa5\xa1q\xc0\x80\vX\xe9\xad\xf1\xa4E\xa10x\x18" || self.classname == "\f{{\xf2\x06\x80>\"\xb4>\xb8\xdc\x88\xed\xfa\xb3\xe3\xd2=p\x1d\x10y\xad\x83\x92\x80<\xe8\t" || self.classname == "\xdb\xd4\xa0\x80|;\xb5[Q\xdfF<\xe6\x8a\xa0\xc9\xd3\xf2\x86\xc00E\xc5sa\x9fo\x0e\x02\x80\xfa\xdb") {
    switch (weaponname) {
      case #"hash_a89739756fa439cf":
        return utility_sp::make_weapon_special("\xc3vL\xfa\x86\n\a\xd3\xc7K>\x9a\xc2\xf2\xf0");
    }
  } else if(self.classname == "\x90\x1f\xd4[\xea\x1cJ\x14\x7fU\x84\x02IY\x13\"\x81uo\xb2o\xae5\xf7\x85\x91\xfb\xbdus\xd8") {
    switch (weaponname) {
      case #"hash_82d03e9871615139":
        return utility_sp::make_weapon_special("\xea\xed8\x8fiQ\xfb\xa7\xa8\xb8\xb9=\xday\x139-");
    }
  } else if(self.classname == "P\x15\xa6\xef\xdc\xa3K\xbbv\x06\xfe-\xc2\x9f`\x16\x15\xac]\xcd\xa8\x03\xb3\xc2\x94\x82\x05gz&\xa7\x9d") {
    switch (weaponname) {
      case #"hash_aa1268e549fd317":
        return utility_sp::make_weapon_special("\x98\x95\xd6\xf4\x82\xd6\xe8<?0\x0fc\xc8\xce\xcf");
    }
  } else if(self.classname == "2\x7f\xb5z\b\xd6\x92dw`i@4\xf65'1F:-C@^+\xe3u\x1dl-\\P") {
    switch (weaponname) {
      case #"hash_accc6d1d86e48732":
        return utility_sp::make_weapon_special("\x96mRYHy@,\xedr\x11\xd6\x12\x92\x1c\xf3=p2");
    }
  } else if(self.classname == "\x19m\xe7\xb0\xb3O\x8e\xf3\xebRG\x1ep\x9bQW\xb5H\xe8F\x06j\xf7\xf3") {
    switch (weaponname) {
      case #"hash_7e1d746d4a36491e":
        return utility_sp::make_weapon_special("\f\xd9\xf7J\xdf\ru\x92\x02E\x9a\v\xd46\xee\xd1");
    }
  } else if(self.classname == "0\x9d\xd1sJo\xc4\x93F\x9f\x88\x94\xe0\xdb\xd4\x052S\xc1[\x0f\xe3\xc1\xed\xbf\xb6>\xfe\x88\x8as") {
    switch (weaponname) {
      case #"hash_73753b6a3bde7482":
        return utility_sp::make_weapon_special("@\x99,\xa0I3T\xdcC\xad\x8a\xac\x1et\x80X\xe8K");
    }
  }

  return utility_sp::make_weapon(weaponname, []);
}

function function_4a4e093e68d8b794(type, weaponname, weaponarray) {
  camos = getweapon_camos("\xe4\xabn\xfa\a\xb6\x1b");
  var_3c1147f3a07e0b51 = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_fa18d2f6bd57925a":
      weaponprobabilities["F\xf6\xd0^\x1dJ\x04\x80\x1a\xcd\xce\xef@vP"] = 30;
      weaponprobabilities["q\xe5\x93\x03V\x87\x84;\xf49\xd3{\xc1T\xbc\x18\x87\x9b"] = 30;
      weaponprobabilities["=\x13\x16g\x89\xd02\xb0}(\xf5\xe6_\x9a\xd9\xba\x10\x05\x03g\xb9"] = 40;
      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

      switch (weaponname) {
        case #"hash_2253efe9671d59b5":
          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
          }\
          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
              }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\x8eoT\\\xbf|_\x1d\x12uIn0\x95\xc2\xe8\xab\xb7\xdc"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0", "\xb5\xc2\xd9_X\xe4_\xc6\xce\x1dxc\xc2\xc9\xb3e_\xe0\xc0C"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "G\x87n?\x03\x1c`@\b\xb5\x7f"];
              break;
              case #"hash_a89739756fa439cf":
              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "}\x98u\xa1>\xa7,\xe5Xj*\xe3\x19\xa6K\x05\x1eQ\xbf\xbe\xae\xf3<\xcf", "\xdc:\xcf\xb7\xf0W\xfe\xb1\x8cL\x1f~Z\xfe\x1b", "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\xc2\xfc\xd5\xb0\xfcze\x16\xb6\xc1\xae\xb8\x8a\x1anG\xa0\xcf*s@\f`b\xc1"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xba\x9e\x83w\x9f0[v|\xd2", "u\xfd\x10\x8d\xc1\xbc\x8a|\x1c\x1b\x98\r\x02\xbch`", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
              }\
              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                  n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "G\x87n?\x03\x1c`@\b\xb5\x7f"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                break;
                case #"hash_6558b7569b2f833c":
                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "\xe5\xf7\xdb\xc94c{\xb0\"\xb5\x05\x11\xfe\x1cP\xa0uq9", "\xed[\xf8MHoq\xf0\xf5\xf3i", "o\x0e\xcc\x987]g\x96\xa8\xff\x9e", "5\xba\x83\xaf\x93V\x996\xb2\x0f\x81\x89\xeb:\x16\x8d\xb1", "\xe6f\xfbH\xdb\x02\x80'E\x04\x04\xf9\xd3E\x11j^5\xe7m\x19", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j", "/4q\xcf/\xbf\xa2\x99", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xa0}xk.2\xb2\xb8\x13\xbf\xf5C5\xb8\xc4\xab3\xe2\xfb\x18\xae\x9ed\xd0g\x7f\xa8<", "\xe8+w\x80 \xca\x90\xb5^\xb19\xe6\xbd)Th\xaf\xb7q\xb6b\xae\x94u\xb5\x1c\x0e:\x9f\xd2\xb8I", "M[D\xeb^\xd3\xe4]\x98\xfct\xf3\x95\x9fEP\xc7\x9f^\xadr\\\xdaQcm\xcdp\xcd"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xa9\x9a\xfc\xf8\x1a%\x164COA}W\xb0b*\x9aJR\xae\x8e\xd4mJ\xa6\xb6\xb9#", "\x18=\x96\x84`\xa5w^/\xc3}\x8f\n\xd5Ec\x03\x94\xdd\xd9\xc0k{Y\xd0\xfd\xb4=\x11\xec\x1b\xb2\xa8u"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "-\x05g\xa7m\xc4\x87\x01Z*\xd1\xf0QwKj\xb9\x1fv\x048>\x994hA8\ax\x9b", "\xa6\xae\x1c\xaf\xa9\xc1\x18\x98_\v9\xaf\xd9\xbd\xc633\x1b_\xb5\v\xd9\xf5\x860\xd7\xd4\xa9\xc6n"]; var_3c1147f3a07e0b51["VwXl+"] = [30, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99"];
                break;
              }

              break;
              case #"hash_2f2d546c2247838f":
              switch (weaponname) {
                case #"hash_c82a1fa1c794832c":
                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"];
                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"];
                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"];
                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                  }\
                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                      var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                      break;
                      case #"hash_ff9799d32cdfe811" :
                      var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x91t\xf3C\x86xi\xc3,l1\xe6\xb0\x12\xaahd]P\xed\x1a\xf2>H\x8b\xa8m@", "\xa0n\xed\xac\xa8k\x9f1$\x88\xb6\xd1\xb0\xfbR2\x88\b\xf1N\xb4\x80P\"#\xba\x17\x1e", "\xc8\xf5{UE`w\x90\x11\rC\x03\x10\xd9\xc0^7\xc3?\xc51b\xcb\x95H\xc5v\xe7"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x9a\xea\a\xeb5\xe006\xd7\x1bm\xafpk-6o8\xfa\x9b\xe8\xdb\x1b\xad_he\v;y2", "*\xc7\xab\xdcn\xe1\xc5\xab\x1d\x12\x92kt\xc7\xc8Hx\x867p0\x9aQ^}\xd4\xa3W", "v\x1e\x9d\xd1}H\"*\x99\xa4\xb8Ms\x05\xf5\xec\x04;P\x12\xaf\xb8\xde[\xd1\xc0\xdaTaz\xf3"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [40, "\xb9\xae{\xfcg\xa8R\x9e\xed\xfa\x80\x9b\xd8L\xdc\xfafe\xb9co\xfcZ\x939\xaf\xa2\x84Ro-\x8c"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                      }\
                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                        break;
                      }

                      break;
                      case #"hash_719417cb1de832b6":
                      switch (weaponname) {
                        case #"hash_67577d66829ce1b5":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                          break;
                        case #"hash_9f2f7b2ffa667962":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd5c\n\xc6\x8e\f(V:\xc9\xdd\x91\x88)\xe6\xac\xa2\xbc\\\x94\xde\x85k\x13\xcf!\x8e\x02\xb7", "\xd5c\n\xc6\x8e\f(V:\xc9\xdd\x91\x88)\xe6\xac\xa2\xbc\\\x94\xde\x85k\x13\xcf!\x8e\x02\xb7"];
                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x9a\x98 \x9a\x9b\xd6U\x04?\xee\t\x02A\x13\xb3C?5'\xf8\xa6D\xf5\x7f\xb1N\xac\xbb\x94\x85\xc6\x99"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                          break;
                      }

                      break;
                      case #"hash_23209741b93850b5":
                      switch (weaponname) {
                        case #"hash_9551957c74ed1495":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                          break;
                        case #"hash_f9a81f8a7ac2c955":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x04\xf5\xb9\xd8\xf6g\xe1c\xd1wfD|Ug\xd8;y\xfa\xda\\)G\x83\x8b\xd8\xa6\xcdk?p\xe6\xf81", "\xc2\xdf*C\x1e[\xab\x99\xf0&\xe1\xb4\xd7\x8a\xd0V|\x17\xa7\xe1\x18\xd7\x8f\xa8\x98\xba\x18\v\x86\xa7\xb7A7\xaaq\x8b\xf9"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\xe6f\xfbH\xdb\x02\x80'E\x04\x04\xf9\xd3E\x11j^5\xe7m\x19", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                          attachment_combos[attachment_combos.size] = ["\xadX\xf7\xe9\xd2\xc3\x9f\xc1p\x9a\xcf\x1c2\xe1\x04\xe5\x1f%\xb7\x04\x13\xfc]\xbb\x1b\x82\xfeV=\xc9", "\x11\xda8\xd9\xa0\xadxy6\xaa\x99a\x92\xc8\xc0\x87\xd5K\xea\xf0Z\x13\xb9l\n\xa7\xb7\xf3\xac3"];
                          attachment_combos[attachment_combos.size] = ["`\x10\xf4\xdepRHo\x998\xb3E\xb3\xd0\x95B0O\xe9\xf1}\xde\xf9\xfaZ\x1e\xeeze\xa0\xccS", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                          attachment_combos[attachment_combos.size] = ["5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9\xd7\x8d?\rA\x94yS\x01\xa2\xf3\xf5\xf2", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                          break;
                      }

                      break;
                      case #"hash_900cb96c552c5e8e":
                      weaponprobabilities["\x89\x12\xe9*\xf6\xdaR\xfc\x8d\x10.%CtT\x95\x8e"] = 30; weaponprobabilities["n\xf9\xc6a\xc1\x16D\xcd\xb6\xa9\xa7\r\xb7H\x19\xa9Q\xc0\x92V'\xebYF"] = 40; weaponprobabilities[":w\xb6`\xbf\xbchq\x1ai\xd7\xad\xd6\xf3\x973=\xcf\xf5\x82"] = 30; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                      switch (weaponname) {
                        case #"hash_bb0038e8e0e9d620":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf7\xf9g;\x90Q\xb89\x9e0"];
                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xde\xe0\x90\xd7E\xd1d\xa8\xc0\f\x86\xfd\xd7\xd8^\n"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                          var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                          break;
                        case #"hash_7b1f2fae55545887":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x06\xdb\xaf\x88\x0e\x10\x82\xba\xf6\xb9m\x88f\xbe\t3_IN\xdd\x852\x94\xbdyo\xbaD\xd6\xedkhM\xee", "S\xd58_5\a`\x91\xbes\xad\xbenlh\xc2'\x8d\x96e\x99\xf5\x98X\x9c\xfa\x1b\x96\xec4\x8e"];
                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xcb\xb1.\xa5\xcb\xb6\x13bK\x1e\xb9_1~}\xa8y\xf0ZW\x17\xe2\x10\xc7\xe0,\"9ye\x11\xef", "\xb4\x82\x19\x12m\xf8\xffK\x1e\xd94|\xe4\x9dC\x94j\xb1\x0e\xb3\x9b\xfd\x91r\xfb\xc0x\xffu~+eu\x18o", "\vh\xa7\x82XC\xc0\xd9=s\xb0)\xe7\x9bT\xc6\xe1\xd5\x9f\xbc\xb6?[=n\xd9\xc6aE\xf9\x9cT\nJ\x8d-", "\xdep\xc8\x81\xbad\xfa\x0f\x87\xbc\r\b\x1c\x94\xb9u\xdf1\x1b\xdbT\xee\x02e\x1b\xd9\xa5\xd3\x8bD\xb8"];
                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xd1*\x93\x1f\xcd\xe8\x8c\xbc&\xb9\xbc\xed\x8c\x1f\x8b\xb4p\xa9c\x8fJ\xe3\x90+x\xf9\xd5\x17\xe3\xab\x89P"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                          break;
                        case #"hash_e5ce91052a286344":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xaf\x10\xbf\x14\xc9\xc9X\xc0\x03D\x85\x1a[\x1e=\xe3\x96^Y\x0e\vO\x98\xfd?\x14w"];
                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8c\x1b\xfe\\W\x8f\xdc6\xc6\xcc\x83.\xad\xcc\xf9\xef^z\x99\x17\xeb\x17\x83C\xa8C\x02<;", "\xb0\xa4\xa4lN\xe0\xf3\xce\x1bL\xf5\x14\x8am\x06\x1e\x18~O\fF~\x17m\xd3\xeb\x1a\x97\x1e\x14\xf3", "\xed\x83\xe7W\xfa\x90>\xba\x97\xed\xa6p\vlp\xf6S\xa7\xfbm\xee\r\rf\xaf\xef_\xe8T\xe4\xdb\x17q", "\x84\x1c!d\x96\xaf\x91\xc8\xfd\x1f,\v@U\x83\xc1\xe4h\xfd\x1c0^\xbbz\x9d\x7f\xae\xdd\x82\xeb\xd6", "\xa9/\xf3\xa3\xfd\x81\xe87\x9bV\xfa\x10-\xca9\xe9Xy\xe6\xf6DW\xb8Y\r\x86`\\}K\x1a"];
                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xa2E\x9b6\x90\x03o\xef\xf8w\x856su\xc5\x90\xbc\x14\xb5\xf11\x8cw'\xb8O\xb91\xb1\x1b"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                          break;
                      }

                      break;
                      case #"hash_6191aaef9f922f96":
                      weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 50; weaponprobabilities["{\xab|R\xd4Z#+Awn\x8f\x10h\xbcr\xa5\x1dp\x96\x8f\x16t"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                      switch (weaponname) {
                        case #"hash_4fd524ce5cfa34e4":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed"];
                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                          break;
                        case #"hash_fa420c3b943390d7":
                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "T\xba\xb9\f$8\xfb\xe1\xe3\x15\x01\x9f\xe6l\x1c\xf2K\xfe6\x82\x9d\xdf\xc5m\x9b\xfa$\f\xdaw"];
                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xab\xc7X\xbb\xc5t>\x9f\x8cgf0\x05^F\xb1\xac$\xfay\xf1pN\x80\x9b\x9b]\xbdS\xeb", "\xc5\x87s\xcc\xabH\x1e\f\xbbOUb\x8f~\x04\x01\x9d\xe6p\xf9b\xcbV{I\x9b\xe7i@", "\x0e\x8d\x06s\xc9\xd2-\xf3\xef\xfdEC\x01\xbb?\xce\xd24\xa9PP\xc4\xbe>\xbey\xb4`\\g"];
                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xaf\x10\xbf\x14\xc9\xc9Z\xce\x03\x81\x85\x1aC\xd8=\xa3\x87\xdf\xd9\x04&V\xd0\xf5\xdc\x9a\xfe\x9b\xa6\xa6\xd6\x86", "\xd4\xc4\xb0G\xe6\xbb\xa0I\x8f\xf0\xff\xb2\xcb7K\xba\xc4\x12=\xe5\xcb\xb9M\xf4\xca&\xf8\xd3\x9b!\a\xcd"];
                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [100, "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "G\xf0\xc0;\xa2w\x83\x82\xf2"];
                          attachment_combos[attachment_combos.size] = ["?\x93b\xc1\xe3\xbd\n[8\xa0\x96J\x80Rs\xf4OCr@Jm\x88Q8\x98]\xbb\xe0zsw", "\xc8\xf5{UE`u\x12\x11\x8dC\x03\x16z\xc0\xbf\x012\x9a\x87\x0fc\x92T^\xc7\x1f\xcd\xb2\xd9", "\xc5\xe4\xb2\b.\x87i \x1d\x8eL\vxJ\xe5-,x\xb5\xc3\xda\xd8Kcr3\x057b\xe3", "G\xf0\xc0;\xa2w\x83\x82\xf2"];
                          break;
                      }

                      break;
                    }

                    return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                  }

                  function function_8b9385c23c890c79(type, weaponname, weaponarray) {
                    camos = getweapon_camos("dT\xdd");
                    var_3c1147f3a07e0b51 = [];
                    attachment_combos = [];

                    switch (type) {
                      case #"hash_fa18d2f6bd57925a":
                        weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 50;
                        weaponprobabilities["q\xe5\x93\x03V\x87\x84;\xf49\xd3{\xc1T\xbc\x18\x87\x9b"] = 50;
                        weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                        switch (weaponname) {
                          case #"hash_2253efe9671d59b5":
                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                            }\
                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                              }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\x8eoT\\\xbf|_\x1d\x12uIn0\x95\xc2\xe8\xab\xb7\xdc"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0", "\xb5\xc2\xd9_X\xe4_\xc6\xce\x1dxc\xc2\xc9\xb3e_\xe0\xc0C"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "G\x87n?\x03\x1c`@\b\xb5\x7f"];
                              break;
                            }

                            break;
                          case #"hash_719417cb1de832b6":
                            switch (weaponname) {
                              case #"hash_67577d66829ce1b5":
                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                break;
                            }

                            break;
                          case #"hash_23209741b93850b5":
                            switch (weaponname) {
                              case #"hash_9551957c74ed1495":
                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                break;
                              case #"hash_f9a81f8a7ac2c955":
                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x04\xf5\xb9\xd8\xf6g\xe1c\xd1wfD|Ug\xd8;y\xfa\xda\\)G\x83\x8b\xd8\xa6\xcdk?p\xe6\xf81", "\xc2\xdf*C\x1e[\xab\x99\xf0&\xe1\xb4\xd7\x8a\xd0V|\x17\xa7\xe1\x18\xd7\x8f\xa8\x98\xba\x18\v\x86\xa7\xb7A7\xaaq\x8b\xf9"];
                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\xe6f\xfbH\xdb\x02\x80'E\x04\x04\xf9\xd3E\x11j^5\xe7m\x19", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                attachment_combos[attachment_combos.size] = ["\xadX\xf7\xe9\xd2\xc3\x9f\xc1p\x9a\xcf\x1c2\xe1\x04\xe5\x1f%\xb7\x04\x13\xfc]\xbb\x1b\x82\xfeV=\xc9", "\x11\xda8\xd9\xa0\xadxy6\xaa\x99a\x92\xc8\xc0\x87\xd5K\xea\xf0Z\x13\xb9l\n\xa7\xb7\xf3\xac3"];
                                attachment_combos[attachment_combos.size] = ["`\x10\xf4\xdepRHo\x998\xb3E\xb3\xd0\x95B0O\xe9\xf1}\xde\xf9\xfaZ\x1e\xeeze\xa0\xccS", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                                attachment_combos[attachment_combos.size] = ["5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9\xd7\x8d?\rA\x94yS\x01\xa2\xf3\xf5\xf2", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                                break;
                            }

                            break;
                          case #"hash_900cb96c552c5e8e":
                            weaponprobabilities["\x89\x12\xe9*\xf6\xdaR\xfc\x8d\x10.%CtT\x95\x8e"] = 50;
                            weaponprobabilities["\xec\xf7w\xb9\xef5zH\xa8\"\"\xc5K|\x06t"] = 50;
                            weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                            switch (weaponname) {
                              case #"hash_bb0038e8e0e9d620":
                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf7\xf9g;\x90Q\xb89\x9e0"];
                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xde\xe0\x90\xd7E\xd1d\xa8\xc0\f\x86\xfd\xd7\xd8^\n"];
                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                break;
                              case #"hash_252ac91b23d22c17":
                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "_\x12\a\xb1\xc0F\xd1\xc3\xab\x1e", "\x0fmTdI\x0eS\xf1H\x16\xbd#3\x88\xfeU"];
                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xf5.@\x84\xf61\x84\xad,\xb2\xf1\xd1\x11\x83:\xed\xecv", "}\x8dY\x86\xa6M\xf9ud\xc2V\xc2\v\x9aF|\xea8\x16)/", "\xf7\xccl\xd2\x81f\x99\x86\x99\xb4]\x80", ")\x86\xc9?\xcd\xb2\xc1?\\\xcf:\xd7\xb8N", "\xabA\xbd+\x14\xb4]\xeb\xdb\x8a\xf9w\x1d\xa1V\x9bZ\xc0\xf6", ")\xb4\xc5/\xcam\xef\xe5\x9bHl#\t\xce\xdc^\xd2jt\xb3d~Y\xe5\xb4", "\xbb[n\x9fp\xc8\xbat\x97qU\xd2\x1a\xbb\xb6\x10n^$\x92\xddSK\xe14t\xf0\xa8"];
                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x01\x9b\x87\x97\xeb:I5M*", "\xc0\xc6\xc6\xe4j~S\x87\xeb\x01\xd4"];
                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                break;
                            }

                            break;
                        }

                        return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                    }

                    function function_7610ded771ec8704(type, weaponname, weaponarray) {
                      camos = getweapon_camos("dT\xdd");
                      var_3c1147f3a07e0b51 = [];
                      attachment_combos = [];

                      switch (type) {
                        case #"hash_fa18d2f6bd57925a":
                          weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 50;
                          weaponprobabilities["q\xe5\x93\x03V\x87\x84;\xf49\xd3{\xc1T\xbc\x18\x87\x9b"] = 50;
                          weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                          switch (weaponname) {
                            case #"hash_2253efe9671d59b5":
                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                              }\
                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                  n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\x8eoT\\\xbf|_\x1d\x12uIn0\x95\xc2\xe8\xab\xb7\xdc"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0", "\xb5\xc2\xd9_X\xe4_\xc6\xce\x1dxc\xc2\xc9\xb3e_\xe0\xc0C"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "G\x87n?\x03\x1c`@\b\xb5\x7f"];
                                break;
                                case #"hash_15d131b492bdb596":
                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                break;
                              }

                              break;
                            case #"hash_2f2d546c2247838f":
                              switch (weaponname) {
                                case #"hash_c82a1fa1c794832c":
                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"];
                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"];
                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"];
                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                  }\
                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                      var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                      break;
                                    }

                                    break;
                                    case #"hash_719417cb1de832b6":
                                    switch (weaponname) {
                                      case #"hash_67577d66829ce1b5":
                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                        break;
                                    }

                                    break;
                                    case #"hash_23209741b93850b5":
                                    switch (weaponname) {
                                      case #"hash_9551957c74ed1495":
                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                        break;
                                    }

                                    break;
                                    case #"hash_900cb96c552c5e8e":
                                    weaponprobabilities["\x89\x12\xe9*\xf6\xdaR\xfc\x8d\x10.%CtT\x95\x8e"] = 50; weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                    switch (weaponname) {
                                      case #"hash_bb0038e8e0e9d620":
                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf7\xf9g;\x90Q\xb89\x9e0"];
                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xde\xe0\x90\xd7E\xd1d\xa8\xc0\f\x86\xfd\xd7\xd8^\n"];
                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                        var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                        break;
                                      case #"hash_294ef3868701b31a":
                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                        break;
                                    }

                                    break;
                                    case #"hash_6191aaef9f922f96":
                                    weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                    switch (weaponname) {
                                      case #"hash_4fd524ce5cfa34e4":
                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                        break;
                                    }

                                    break;
                                  }

                                  return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                              }

                              function function_ebd10db200336aa0(type, weaponname, weaponarray) {
                                camos = getweapon_camos("dT\xdd");
                                var_3c1147f3a07e0b51 = [];
                                attachment_combos = [];

                                switch (type) {
                                  case #"hash_fa18d2f6bd57925a":
                                    weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 50;
                                    weaponprobabilities["q\xe5\x93\x03V\x87\x84;\xf49\xd3{\xc1T\xbc\x18\x87\x9b"] = 50;
                                    weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                    switch (weaponname) {
                                      case #"hash_2253efe9671d59b5":
                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                        }\
                                        xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                            n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                          }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\x8eoT\\\xbf|_\x1d\x12uIn0\x95\xc2\xe8\xab\xb7\xdc"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0", "\xb5\xc2\xd9_X\xe4_\xc6\xce\x1dxc\xc2\xc9\xb3e_\xe0\xc0C"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "G\x87n?\x03\x1c`@\b\xb5\x7f"];
                                          break;
                                          case #"hash_15d131b492bdb596":
                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                          break;
                                        }
                                      case #"hash_2f2d546c2247838f":
                                        switch (weaponname) {
                                          case #"hash_c82a1fa1c794832c":
                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"];
                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"];
                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"];
                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                            }\
                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                break;
                                              }

                                              break;
                                              case #"hash_719417cb1de832b6":
                                              switch (weaponname) {
                                                case #"hash_67577d66829ce1b5":
                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                  break;
                                              }

                                              break;
                                              case #"hash_23209741b93850b5":
                                              switch (weaponname) {
                                                case #"hash_9551957c74ed1495":
                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                  break;
                                              }

                                              break;
                                              case #"hash_900cb96c552c5e8e":
                                              weaponprobabilities["\x89\x12\xe9*\xf6\xdaR\xfc\x8d\x10.%CtT\x95\x8e"] = 50; weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                              switch (weaponname) {
                                                case #"hash_bb0038e8e0e9d620":
                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf7\xf9g;\x90Q\xb89\x9e0"];
                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xde\xe0\x90\xd7E\xd1d\xa8\xc0\f\x86\xfd\xd7\xd8^\n"];
                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                  break;
                                                case #"hash_294ef3868701b31a":
                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                  break;
                                              }

                                              break;
                                              case #"hash_6191aaef9f922f96":
                                              weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                              switch (weaponname) {
                                                case #"hash_4fd524ce5cfa34e4":
                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                  break;
                                              }

                                              break;
                                            }

                                            return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                        }

                                        function function_b949642ebbf4c9e5(type, weaponname, weaponarray) {
                                          camos = getweapon_camos("dT\xdd");
                                          var_3c1147f3a07e0b51 = [];
                                          attachment_combos = [];

                                          switch (type) {
                                            case #"hash_fa18d2f6bd57925a":
                                              weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 50;
                                              weaponprobabilities["q\xe5\x93\x03V\x87\x84;\xf49\xd3{\xc1T\xbc\x18\x87\x9b"] = 50;
                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                              switch (weaponname) {
                                                case #"hash_2253efe9671d59b5":
                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                  }\
                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                      n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                    }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                    var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\x8eoT\\\xbf|_\x1d\x12uIn0\x95\xc2\xe8\xab\xb7\xdc"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0", "\xb5\xc2\xd9_X\xe4_\xc6\xce\x1dxc\xc2\xc9\xb3e_\xe0\xc0C"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "G\x87n?\x03\x1c`@\b\xb5\x7f"];
                                                    break;
                                                    case #"hash_15d131b492bdb596":
                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                    break;
                                                  }

                                                  break;
                                                case #"hash_2f2d546c2247838f":
                                                  switch (weaponname) {
                                                    case #"hash_c82a1fa1c794832c":
                                                      var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"];
                                                      var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"];
                                                      var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"];
                                                      var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                      }\
                                                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                          var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                          break;
                                                        }

                                                        break;
                                                        case #"hash_719417cb1de832b6":
                                                        switch (weaponname) {
                                                          case #"hash_67577d66829ce1b5":
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                            break;
                                                        }

                                                        break;
                                                        case #"hash_23209741b93850b5":
                                                        switch (weaponname) {
                                                          case #"hash_9551957c74ed1495":
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                            break;
                                                        }

                                                        break;
                                                        case #"hash_900cb96c552c5e8e":
                                                        weaponprobabilities["\x89\x12\xe9*\xf6\xdaR\xfc\x8d\x10.%CtT\x95\x8e"] = 50; weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                        switch (weaponname) {
                                                          case #"hash_bb0038e8e0e9d620":
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf7\xf9g;\x90Q\xb89\x9e0"];
                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xde\xe0\x90\xd7E\xd1d\xa8\xc0\f\x86\xfd\xd7\xd8^\n"];
                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                            break;
                                                          case #"hash_294ef3868701b31a":
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                            break;
                                                        }

                                                        break;
                                                        case #"hash_6191aaef9f922f96":
                                                        weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                        switch (weaponname) {
                                                          case #"hash_4fd524ce5cfa34e4":
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                            break;
                                                        }

                                                        break;
                                                      }

                                                      return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                  }

                                                  function function_cc70fa21e5c25570(type, weaponname, weaponarray) {
                                                    camos = getweapon_camos("\x14/P");
                                                    var_3c1147f3a07e0b51 = [];
                                                    attachment_combos = [];

                                                    switch (type) {
                                                      case #"hash_fa18d2f6bd57925a":
                                                        switch (weaponname) {
                                                          case #"hash_d587b8872645b598":
                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [100, "k\x19\x87v-M\xd2\f\x84>\x8b7\xf3"];
                                                            break;
                                                        }

                                                        break;
                                                    }

                                                    return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                  }

                                                  function function_c8692a6471afc64a(type, weaponname, weaponarray) {
                                                    camos = getweapon_camos("dT\xdd");
                                                    var_3c1147f3a07e0b51 = [];
                                                    attachment_combos = [];

                                                    switch (type) {
                                                      case #"hash_fa18d2f6bd57925a":
                                                        weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 30;
                                                        weaponprobabilities["=\x13\x16g\x89\xd02\xb0}(\xf5\xe6_\x9a\xd9\xba\x10\x05\x03g\xb9"] = 30;
                                                        weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                        switch (weaponname) {
                                                          case #"hash_aa1268e549fd317":
                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                            }\
                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                            var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                            var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                            break;
                                                          case #"hash_6558b7569b2f833c":
                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "\xe5\xf7\xdb\xc94c{\xb0\"\xb5\x05\x11\xfe\x1cP\xa0uq9", "\xed[\xf8MHoq\xf0\xf5\xf3i", "o\x0e\xcc\x987]g\x96\xa8\xff\x9e", "5\xba\x83\xaf\x93V\x996\xb2\x0f\x81\x89\xeb:\x16\x8d\xb1", "\xe6f\xfbH\xdb\x02\x80'E\x04\x04\xf9\xd3E\x11j^5\xe7m\x19", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j", "/4q\xcf/\xbf\xa2\x99", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xa0}xk.2\xb2\xb8\x13\xbf\xf5C5\xb8\xc4\xab3\xe2\xfb\x18\xae\x9ed\xd0g\x7f\xa8<", "\xe8+w\x80 \xca\x90\xb5^\xb19\xe6\xbd)Th\xaf\xb7q\xb6b\xae\x94u\xb5\x1c\x0e:\x9f\xd2\xb8I", "M[D\xeb^\xd3\xe4]\x98\xfct\xf3\x95\x9fEP\xc7\x9f^\xadr\\\xdaQcm\xcdp\xcd"];
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xa9\x9a\xfc\xf8\x1a%\x164COA}W\xb0b*\x9aJR\xae\x8e\xd4mJ\xa6\xb6\xb9#", "\x18=\x96\x84`\xa5w^/\xc3}\x8f\n\xd5Ec\x03\x94\xdd\xd9\xc0k{Y\xd0\xfd\xb4=\x11\xec\x1b\xb2\xa8u"];
                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "-\x05g\xa7m\xc4\x87\x01Z*\xd1\xf0QwKj\xb9\x1fv\x048>\x994hA8\ax\x9b", "\xa6\xae\x1c\xaf\xa9\xc1\x18\x98_\v9\xaf\xd9\xbd\xc633\x1b_\xb5\v\xd9\xf5\x860\xd7\xd4\xa9\xc6n"];
                                                            var_3c1147f3a07e0b51["VwXl+"] = [30, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99"];
                                                            break;
                                                        }

                                                        break;
                                                      case #"hash_2f2d546c2247838f":
                                                        switch (weaponname) {
                                                          case #"hash_3a85891c63542117":
                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xca\xedp\xf9\f \x95q\x99\xbeO\xba\xc7K\x17'\x99\"\xf7\xdd\xcfp\x1a\x13\x03\xbe\x92\xf0\x18"];
                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "!\xd5\xe3\x9erb\xe6j\x8c\xf1\x1e\x0f\xa8\xafWA\xe1`j\x9aSr3Oy=ry\xa6#\xc9\x91\xe0\xfe", "\xc3q\x1e\xe2\x11\x12\xa9\xd3\x0f\x11(y\xbe\xd1C\xc1\xdb\xfas\xc2\xa0\x1egWGG\x1e\x84\xa2", "B\xd4\xed\xdbH\x01=\xd4\x06\xecB\x8f /\xaf\xae\x89\x93\x8e\xfd\x84\x10\xa7\xfe\x10\xf8\x88[\xa8\x81\xd1\x13\x8b"];
                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "|\xe3\xe6\xeb\xc7u\x90\xfd\xcb\x93)\x98\xd1\xc7\xabX\x87\x97-\xc2\fI\xdc\xf6\xdcA\xa5u\x16\xd6\xde\x06\x86", "\x1e\t\xa8\xbe\x10d\xbd\xf3\xbe7\xdb&\xf0\v\x02\xe2\x9b\xd9`\xb0`VQ>\xd3\xb8\x95\x1b\xf1\xa1*"];
                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\xd9c\xf4\x14m\xd3\xad&\xd9\xcb\xd41 y_\xf1\xb7\xae\xfd\xb1", "}
                                                            }\
                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                var_3c1147f3a07e0b51["VwXl+"] = [50, "\x9a\xba\x83\xf5\x9d\x9cK\a\xeb\xc27;\x1b\xca\x19}\x03\x13", ",N\xe8\xe5\x05\xdb\xf9\xbe\x11>i\xe6\x9ds\xf8\xc6\xb3\xd0"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "N\x10dL\xef7\xb2\xbf<\x99", "T\x87w\x8eq+\x01\xc1\xcb\x88", "`\x10\xf4\xdey._\v\x99\xbc\xdbE\xf1\x81", "\xa6\xbap\xbef\xb1Xn\x1a\xbe\x85\x93\xaf0&"];
                                                                break;
                                                              }

                                                              break;
                                                              case #"hash_719417cb1de832b6":
                                                              switch (weaponname) {
                                                                case #"hash_9f2f7b2ffa667962":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd5c\n\xc6\x8e\f(V:\xc9\xdd\x91\x88)\xe6\xac\xa2\xbc\\\x94\xde\x85k\x13\xcf!\x8e\x02\xb7", "\xd5c\n\xc6\x8e\f(V:\xc9\xdd\x91\x88)\xe6\xac\xa2\xbc\\\x94\xde\x85k\x13\xcf!\x8e\x02\xb7"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x9a\x98 \x9a\x9b\xd6U\x04?\xee\t\x02A\x13\xb3C?5'\xf8\xa6D\xf5\x7f\xb1N\xac\xbb\x94\x85\xc6\x99"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                  break;
                                                              }

                                                              break;
                                                              case #"hash_23209741b93850b5":
                                                              switch (weaponname) {
                                                                case #"hash_f9a81f8a7ac2c955":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x04\xf5\xb9\xd8\xf6g\xe1c\xd1wfD|Ug\xd8;y\xfa\xda\\)G\x83\x8b\xd8\xa6\xcdk?p\xe6\xf81", "\xc2\xdf*C\x1e[\xab\x99\xf0&\xe1\xb4\xd7\x8a\xd0V|\x17\xa7\xe1\x18\xd7\x8f\xa8\x98\xba\x18\v\x86\xa7\xb7A7\xaaq\x8b\xf9"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\xe6f\xfbH\xdb\x02\x80'E\x04\x04\xf9\xd3E\x11j^5\xe7m\x19", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                  attachment_combos[attachment_combos.size] = ["\xadX\xf7\xe9\xd2\xc3\x9f\xc1p\x9a\xcf\x1c2\xe1\x04\xe5\x1f%\xb7\x04\x13\xfc]\xbb\x1b\x82\xfeV=\xc9", "\x11\xda8\xd9\xa0\xadxy6\xaa\x99a\x92\xc8\xc0\x87\xd5K\xea\xf0Z\x13\xb9l\n\xa7\xb7\xf3\xac3"];
                                                                  attachment_combos[attachment_combos.size] = ["`\x10\xf4\xdepRHo\x998\xb3E\xb3\xd0\x95B0O\xe9\xf1}\xde\xf9\xfaZ\x1e\xeeze\xa0\xccS", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                                                                  attachment_combos[attachment_combos.size] = ["5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9\xd7\x8d?\rA\x94yS\x01\xa2\xf3\xf5\xf2", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                                                                  break;
                                                              }

                                                              break;
                                                              case #"hash_900cb96c552c5e8e":
                                                              weaponprobabilities["\xda\xee\xf5\xe6\xbc\xf0|*\xcb\x89!\x05B\xcb\xbcC"] = 50; weaponprobabilities["\xab\xc7X\xbb\xc5t.^\x8c\x16f0y_V\xebmd\xed1\xf1p\x0e"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                              switch (weaponname) {
                                                                case #"hash_175809755197c4da":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xfe\xa7\xe1\xc7\xd4\xb2\xec\x83\x87*", "\x98\xc2\x93\xebnk\xd7l\xb7\xdcg\xbe8\f2", "\xf7\xc7Np\n\xb6\xd8\xad\xb6\xd0\x8e\x06PBn|", ">\xf6M\x83\x0e(@\xf9sg#\xa0\xce\x83\x84."];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xe4|!.\xf6\x99\x84J\xf3\xf3r\xaeb*\xee\x1c\xa6\xc3\xad", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "B\x87\xa6q\xdd\x13\x84\x06\x14\xd1", "\xe82\xf5\x98k\xfd\x8c\x99\x1f\xd2?\x02\x8e@\x01V", "\x83),\xc0\xab\xab\xa5\xdf\xb8\x9f&\xb4\n\xf8\xb6\xf0", "\x13\x99\x123Y\xe8\vw\xbc\\\xb8"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x83\x18\xc7R\xe8\x81?\xfcG\xe7\xc0\xbe\xaa\xae\x1d\x9c\xf8\xda"];
                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                  break;
                                                                case #"hash_26f99e329f475eb7":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x9a\xab\x83\xeb\x9a\xc1\x03\x86\xf5\xb9m\xd7l\xeeCi\x9b\xb6\xb2\xbc\xfa\x13\xc2\x9c\xf5h\xca\xb0\xd9\xf2", "P\xbe\x90z{e\xa8\x7f\x1cb\v\xaf\x8f\xe5\x85\xb4\v\x93\x06\f\xe3A\xbey\xfe}l\xf8\xccg\xe4\xf7"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xa6\xd0\x18\xcb\xa5\x81\x8a\x80\xa47vy\xc4\xa1\x95\x93~C\xddf\xbby\xe1\xe5\xd5\rsyn\x81\x9cR$\xd9", "\x99:\x9eG\xb0\a\xd0\xa0;\x82\xca\x05\xddyx\t\xa5\x9f\xcb&\x12\xcb\x05\x1ei\"\xce\xae\x06\xc8J\xbd", "^\xef\xe4\x88\xed\x01HU\x9b\xed\x15\xd8\x92g\x9c\xcci\xbco/D\xbdf^\x9a\x9b\x7f\xc0>9F\xd3\xc9\xd1"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "*\xba\xe7\xdd%H\xf2A\xbb\xfa\x142\xf89\x18\xab\xee\x87G\xc9\x04@\x0f\xbf\xb7\x12.\xd4? \x1e"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                  break;
                                                              }

                                                              break;
                                                              case #"hash_6191aaef9f922f96":
                                                              weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                              switch (weaponname) {
                                                                case #"hash_4fd524ce5cfa34e4":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                                  break;
                                                              }

                                                              break;
                                                            }

                                                            return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                        }

                                                        function function_67d60e1bb16ef10f(type, weaponname, weaponarray) {
                                                          camos = getweapon_camos("dT\xdd");
                                                          var_3c1147f3a07e0b51 = [];
                                                          attachment_combos = [];

                                                          switch (type) {
                                                            case #"hash_fa18d2f6bd57925a":
                                                              weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 100;
                                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                              switch (weaponname) {
                                                                case #"hash_aa1268e549fd317":
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                  }\
                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                                  var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                  break;
                                                              }

                                                              break;
                                                            case #"hash_2f2d546c2247838f":
                                                              switch (weaponname) {
                                                                case #"hash_9e82f4346600ccc5":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd(\xf7?\xaa\xef_?;\xd6", "\xf0\x04\x81\xc3%\x0e<}\xb5@\xf4\xbc\x1d\x8et"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "\xce\x06V\x86\x82PL~\xd8\x0e:T'o2LL\f^~", "eu\xa7\x01\x9e\xdbU<\xd9^\xef\x87\xdb\xd4Q,C& 9\x1f\xf7]\xb2>w\xfb\xf9h\xf8", "\xf7\x1a\x87\xf5`!\x8cj}$\x90\xfaw\xe8\xdbh\xea\xd0\x1bb*p\x12J\xe5\xf3"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xeb\xbe\xa4\xc2\x9b\xce\xf3\xc4GT\x96", "\xcd\xf7\xde\x11\x14B\x14\xb7L&\xc0\x10#XZx\xe9"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x13R\x1a+G\x94\xa1\xf3\xf5\x7fh0\xc1", "I\xca\xc5\xe9g\x12c\x1e\x85\x14\xc4\x13\x14", "\xd9y<\x03\x9b\x06R\xff\xc97\xba\x03P\xf1a\xbeo", "\xdc\x9f2\xfa\x0e\x82BH'i\b\xc6b", "\x161V\xb2\xda\x99", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "<\xc7~\x1d|C", "\xcao\xa0\xe54u", "\x9b\xba\xab\x19\x0eW*", "}
                                                                  }\
                                                                  xeaZ\b\x8b\xd8 ", "f\xdb\xbaN\x1e`\x86\xd7\x83\x18L", "\x16\x13\x93\xca\x1e\xdc\xf1", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j", "/4q\xcf/\xbf\xa2\x99", "BQq\xa2o\x8ao\x19", "\x9d\xabQo?W\xe1V"];
var_3c1147f3a07e0b51["VwXl+"] = [75, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xc7\xf0\xa6\xf1\x1d\x8d\xe4fe\xc1\xa1\xa7j\x92Y9\xd3", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                  "] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7 ", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91 ", "\xf6\xd4\n\xb5\xc9\x8b: \xab, J\xe0 "];
                                                                  break;
                                                              }

                                                              break;
                                                            case #"hash_23209741b93850b5":
                                                              switch (weaponname) {
                                                                case #"hash_9551957c74ed1495":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                  break;
                                                              }

                                                              break;
                                                            case #"hash_900cb96c552c5e8e":
                                                              weaponprobabilities["\xf0\xf8\xe1KPJ\xb2+\x96\xe5\x9di\xb3\x95\xa7\x95"] = 100;
                                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                              switch (weaponname) {
                                                                case #"hash_394fc57f759066f4":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xee\xf3\xcea\xe2Q?\xec\xd9\x80", "\x1d\x1c9\xab\xbf\xc7'\x19\x9a\xb7i\x81\xc8x\x7f\xbe[\x94\x03", "\x11\r\xb7\x9d\vb\x14\xf6\xc2p\x01-\x1f\xf1\xf8R", "|\x95\xf6\x16P\x15?~\xbdX\xaa\x7f\xd2\x826", "e]\x99'\xe6\xbaV=\xf1\xe4\xb1+\b=IT0\xb0", "\x89\x85r\xebn\xb6\xbe\xd0+\x85\xd9\xf2\xfa\x1c\xc09", "\xe0@\x8b\xc54+!SX \xe9l\xc7K\x19\xbb", "\xf9\xb1\xce\xd8\xf3i\xa9\xe76\xe1j\x92\xdbZ\xa7\x17l[\xab"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x81N\x1a\x1a\xc89\xb0\x9e2lX\xe8\xb7\xab}AU\x03", "\x1f\x97?g\xb3_\xb2\x1b]\xa4\xbb\xd3}\xef\xe3\xd8\xcb\x92", "`y\x05A\x12\xe3\xc1]\a\x80\xfe&", "\x03\r\xd9QE\x12T\xb5\xba\xe4\xdf$\xb4pU\xa6D{h\xc5;", "Kh{\xb3w\x84\x9c\xee\xb4XmtQ\xba"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, " Jn\xc8\xe1j\xab\x1e\xe4/", "\xdb\xc8\xf7g\xa2\x83D\x156\xf3q,\xe5)\xa5\xa9", "\x87a\xf0\xfbfFA-f&\xcb\xe0\xcfd\xd3\xb7", "S\n\xef\xb3~\xae\x1c>\x02\x96\x95\xd7\x0e8\xe3|g"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                  break;
                                                              }

                                                              break;
                                                            case #"hash_6191aaef9f922f96":
                                                              weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100;
                                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                              switch (weaponname) {
                                                                case #"hash_4fd524ce5cfa34e4":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                                  break;
                                                              }

                                                              break;
                                                          }

                                                          return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                        }

                                                        function function_30aab1919ebf9407(type, weaponname, weaponarray) {
                                                          camos = getweapon_camos("o\xdd\xec\x18(\xf8\xa4\x18n");
                                                          var_3c1147f3a07e0b51 = [];
                                                          attachment_combos = [];

                                                          switch (type) {
                                                            case #"hash_fa18d2f6bd57925a":
                                                              weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 30;
                                                              weaponprobabilities["u\x13\x18\xbc\x89\xb0\xbb\xd2\xa9\xf2\x85{\xdccu\xde\xc3\xc9{\x0e\xce\xd5\xb8"] = 30;
                                                              weaponprobabilities["\nE|\xde\x18\xb03>Ya2W\xf8iy\v\x05\x05S\xf3x"] = 40;
                                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                              switch (weaponname) {
                                                                case #"hash_aa1268e549fd317":
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                  }\
                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                                  var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                  break;
                                                                case #"hash_4239df718437dccd":
                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94\x1c?\xe4T\xe1L\x1fN.\xa69\f;\x16,\xb0Bf\xff~\x1e}U\xe5\x15\xb2&\x95\xfa", "m\xf3p\x14\x98p\x87\r\xe9,\x1e|\xf7\xba7\x7f\t\xe6\x84\xdb\xff\xbb\xf9\xd5G\x98\xbdgn\xa2|\x84\xbc", "\xd5\xef\xfcAE\xad\xb2\xa8\x8ajV\a\xcd\xe4?\xe8\x8f\xfe\xea\x7fr\xfe+\xd1\x9aN\xa4F\x19s\xebYg\xc8"];
                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, ".5\xaa\xc3R\xa7\xd9\xc0\xe03q\x8eI\xc8\xee\x1cO\x80\xce\xc0~NX\x15\x18)\xf3b\x87\x8a\x063", "\xa0vC\x18L\x1a\xe4\x1d<YJ8\xc7\xc5\xb1\xfe\x7f;;\x06\x91h\xbe/\x7f\xb3f.\xb2\xd1", "\xd2\x95!\xa6U\xfc\x92\x12\xde2\xf8?\xda\a\xcf\xc4\xe2\xc7\x13\xd2?\xfa\x18\xbe\xa6&\xa2Q\xd2\x03\xd3\xf4"];
                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "S\xab8\xf5\xa6\abr\xbe\vr\xaf\xc2\x1b\xa1\xc2\x93\xc6K+\xaf\xb6a;\xeb\x86\x81\xf5\xd4\xa6\xb1\xcd"];
                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                  }\
                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                        n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                      }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                      var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                      break;
                                                                      case #"hash_32e8b17eac7d6589":
                                                                      var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x02\xc8\xdb\x82\x03h\xc1\x15\x9c\xcc4\xbf\x05Y\xe9\xd2\xb8\xdf\x86\xb3\x90\x1b\xbf\x17\xe4\xccP\\", "M\x8d\xdf\xd7\a\v\x06\xa1\xfa\xf4B\xd9\xfe#\xc0\xcb \xf0\x1b\x06\xb1\x10\xbb\x91d\xef4\xda", "\x80L\xb4(\x8a\xdc\xc8\xf14<1\x9d\xd8\xa4\x11\xcb\xfaE\r\xa3\x8fP0\x1b\x10bA\x9f/\xaa\xc1", "\x02\xc8\xdb\x82\x03h\xc1\x15\x9c\xcc4\xbf\x05Y\xe9\xd2\xb8\xdf\x86\xb3\x90\x1b\xbf\x17\xe4\xccP\\"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "MW\x1c\xbe\xb18\x18\x1c\xfa&'\xeb<m\x96\xda+j\xd77G\xde\x8dm\xfa\x99\xf6\x8d#Z\xb9\xce", "\x13s\xa5\xbd\xb9cC\xbf\x01Sy\xe6\x9e\xbeE`<\xb9C\xed\xc4\xe1]M\xb0>\xf8\xa9\xb1\xd8", "\x1b\xf9\x05H0\xbcC\xee]9\x84Qy?{\x95\x9e\xf2[!\b\x86\x19G]\xe8\x92\x8b!\x01\xfb\x9f\x9a97\xf9Y", "R\xef\x8e\x8f\xf8\x1dI\x94\x97\xcf\b\x8ej5#j\xda\xd0!\x1e\xd6\xd7\x93\x19`\xe1\x1f\x10\xc7O\x1f\x06#U\v\x7f\x18", "za\xaa\xc1\xb8H+\t\"KL-\xa8\x1e\xb8\x9e\xc9\xbf\xfcn\xe4\x17]\xd0\x8bx\xd3\xa8V>"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xef\xf8\xa7y0\xf51\x98\xbb\xb0\a\x9b\xac\xa9o*+K\xa0:ae\x1f\xb3\xcci\xf55h\x85", "\xc6\xfa\xb3_:\x89\xf8\x84|{\xec[\x80\xb2\x81\x11\x8b\xee\xdf\xa9@\x0f\x9e\xa6VLm\xef-\xe5"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                      }\
                                                                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                          n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                        }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                        var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99"];
                                                                        break;
                                                                      }

                                                                      break;
                                                                      case #"hash_2f2d546c2247838f":
                                                                      switch (weaponname) {
                                                                        case #"hash_3a85891c63542117":
                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xca\xedp\xf9\f \x95q\x99\xbeO\xba\xc7K\x17'\x99\"\xf7\xdd\xcfp\x1a\x13\x03\xbe\x92\xf0\x18"];
                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "!\xd5\xe3\x9erb\xe6j\x8c\xf1\x1e\x0f\xa8\xafWA\xe1`j\x9aSr3Oy=ry\xa6#\xc9\x91\xe0\xfe", "\xc3q\x1e\xe2\x11\x12\xa9\xd3\x0f\x11(y\xbe\xd1C\xc1\xdb\xfas\xc2\xa0\x1egWGG\x1e\x84\xa2", "B\xd4\xed\xdbH\x01=\xd4\x06\xecB\x8f /\xaf\xae\x89\x93\x8e\xfd\x84\x10\xa7\xfe\x10\xf8\x88[\xa8\x81\xd1\x13\x8b"];
                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "|\xe3\xe6\xeb\xc7u\x90\xfd\xcb\x93)\x98\xd1\xc7\xabX\x87\x97-\xc2\fI\xdc\xf6\xdcA\xa5u\x16\xd6\xde\x06\x86", "\x1e\t\xa8\xbe\x10d\xbd\xf3\xbe7\xdb&\xf0\v\x02\xe2\x9b\xd9`\xb0`VQ>\xd3\xb8\x95\x1b\xf1\xa1*"];
                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\xd9c\xf4\x14m\xd3\xad&\xd9\xcb\xd41 y_\xf1\xb7\xae\xfd\xb1", "}
                                                                          }\
                                                                          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                              var_3c1147f3a07e0b51["VwXl+"] = [50, "\x9a\xba\x83\xf5\x9d\x9cK\a\xeb\xc27;\x1b\xca\x19}\x03\x13", ",N\xe8\xe5\x05\xdb\xf9\xbe\x11>i\xe6\x9ds\xf8\xc6\xb3\xd0"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "N\x10dL\xef7\xb2\xbf<\x99", "T\x87w\x8eq+\x01\xc1\xcb\x88", "`\x10\xf4\xdey._\v\x99\xbc\xdbE\xf1\x81", "\xa6\xbap\xbef\xb1Xn\x1a\xbe\x85\x93\xaf0&"];
                                                                              break;
                                                                            }

                                                                            break;
                                                                            case #"hash_719417cb1de832b6":
                                                                            switch (weaponname) {
                                                                              case #"hash_9f2f7b2ffa667962":
                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd5c\n\xc6\x8e\f(V:\xc9\xdd\x91\x88)\xe6\xac\xa2\xbc\\\x94\xde\x85k\x13\xcf!\x8e\x02\xb7", "\xd5c\n\xc6\x8e\f(V:\xc9\xdd\x91\x88)\xe6\xac\xa2\xbc\\\x94\xde\x85k\x13\xcf!\x8e\x02\xb7"];
                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x9a\x98 \x9a\x9b\xd6U\x04?\xee\t\x02A\x13\xb3C?5'\xf8\xa6D\xf5\x7f\xb1N\xac\xbb\x94\x85\xc6\x99"];
                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [30, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                break;
                                                                            }

                                                                            break;
                                                                            case #"hash_23209741b93850b5":
                                                                            switch (weaponname) {
                                                                              case #"hash_f9a81f8a7ac2c955":
                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x04\xf5\xb9\xd8\xf6g\xe1c\xd1wfD|Ug\xd8;y\xfa\xda\\)G\x83\x8b\xd8\xa6\xcdk?p\xe6\xf81", "\xc2\xdf*C\x1e[\xab\x99\xf0&\xe1\xb4\xd7\x8a\xd0V|\x17\xa7\xe1\x18\xd7\x8f\xa8\x98\xba\x18\v\x86\xa7\xb7A7\xaaq\x8b\xf9"];
                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\xe6f\xfbH\xdb\x02\x80'E\x04\x04\xf9\xd3E\x11j^5\xe7m\x19", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                                attachment_combos[attachment_combos.size] = ["\xadX\xf7\xe9\xd2\xc3\x9f\xc1p\x9a\xcf\x1c2\xe1\x04\xe5\x1f%\xb7\x04\x13\xfc]\xbb\x1b\x82\xfeV=\xc9", "\x11\xda8\xd9\xa0\xadxy6\xaa\x99a\x92\xc8\xc0\x87\xd5K\xea\xf0Z\x13\xb9l\n\xa7\xb7\xf3\xac3"];
                                                                                attachment_combos[attachment_combos.size] = ["`\x10\xf4\xdepRHo\x998\xb3E\xb3\xd0\x95B0O\xe9\xf1}\xde\xf9\xfaZ\x1e\xeeze\xa0\xccS", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                                                                                attachment_combos[attachment_combos.size] = ["5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9\xd7\x8d?\rA\x94yS\x01\xa2\xf3\xf5\xf2", "5=d\xed\xe8&\xe6\xb6K\x96\xc27\xf7.\xc1J\xed\xcc\xa3f\xb9VIK\b-"];
                                                                                break;
                                                                            }

                                                                            break;
                                                                            case #"hash_900cb96c552c5e8e":
                                                                            weaponprobabilities["\xab\xc7X\xbb\xc5t.^\x8c\x16f0y_V\xebmd\xed1\xf1p\x0e"] = 50; weaponprobabilities["\xec\xf7w\xb9\xef5zH\xa8\"\"\xc5K|\x06t"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                            switch (weaponname) {
                                                                              case #"hash_26f99e329f475eb7":
                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x9a\xab\x83\xeb\x9a\xc1\x03\x86\xf5\xb9m\xd7l\xeeCi\x9b\xb6\xb2\xbc\xfa\x13\xc2\x9c\xf5h\xca\xb0\xd9\xf2", "P\xbe\x90z{e\xa8\x7f\x1cb\v\xaf\x8f\xe5\x85\xb4\v\x93\x06\f\xe3A\xbey\xfe}l\xf8\xccg\xe4\xf7"];
                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xa6\xd0\x18\xcb\xa5\x81\x8a\x80\xa47vy\xc4\xa1\x95\x93~C\xddf\xbby\xe1\xe5\xd5\rsyn\x81\x9cR$\xd9", "\x99:\x9eG\xb0\a\xd0\xa0;\x82\xca\x05\xddyx\t\xa5\x9f\xcb&\x12\xcb\x05\x1ei\"\xce\xae\x06\xc8J\xbd", "^\xef\xe4\x88\xed\x01HU\x9b\xed\x15\xd8\x92g\x9c\xcci\xbco/D\xbdf^\x9a\x9b\x7f\xc0>9F\xd3\xc9\xd1"];
                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "*\xba\xe7\xdd%H\xf2A\xbb\xfa\x142\xf89\x18\xab\xee\x87G\xc9\x04@\x0f\xbf\xb7\x12.\xd4? \x1e"];
                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                break;
                                                                              case #"hash_252ac91b23d22c17":
                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "_\x12\a\xb1\xc0F\xd1\xc3\xab\x1e", "\x0fmTdI\x0eS\xf1H\x16\xbd#3\x88\xfeU"];
                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xf5.@\x84\xf61\x84\xad,\xb2\xf1\xd1\x11\x83:\xed\xecv", "}\x8dY\x86\xa6M\xf9ud\xc2V\xc2\v\x9aF|\xea8\x16)/", "\xf7\xccl\xd2\x81f\x99\x86\x99\xb4]\x80", ")\x86\xc9?\xcd\xb2\xc1?\\\xcf:\xd7\xb8N", "\xabA\xbd+\x14\xb4]\xeb\xdb\x8a\xf9w\x1d\xa1V\x9bZ\xc0\xf6", ")\xb4\xc5/\xcam\xef\xe5\x9bHl#\t\xce\xdc^\xd2jt\xb3d~Y\xe5\xb4", "\xbb[n\x9fp\xc8\xbat\x97qU\xd2\x1a\xbb\xb6\x10n^$\x92\xddSK\xe14t\xf0\xa8"];
                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x01\x9b\x87\x97\xeb:I5M*", "\xc0\xc6\xc6\xe4j~S\x87\xeb\x01\xd4"];
                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                break;
                                                                            }

                                                                            break;
                                                                            case #"hash_6191aaef9f922f96":
                                                                            weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                            switch (weaponname) {
                                                                              case #"hash_4fd524ce5cfa34e4":
                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                                                break;
                                                                            }

                                                                            break;
                                                                          }

                                                                          return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                      }

                                                                      function function_49a6236512619d95(type, weaponname, weaponarray) {
                                                                        camos = getweapon_camos("dT\xdd");
                                                                        var_3c1147f3a07e0b51 = [];
                                                                        attachment_combos = [];

                                                                        switch (type) {
                                                                          case #"hash_fa18d2f6bd57925a":
                                                                            weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 50;
                                                                            weaponprobabilities["X\xff\xae\x88\xfbA\xbe`\x83\x919\xee^e\x9f"] = 50;
                                                                            weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                            switch (weaponname) {
                                                                              case #"hash_15d131b492bdb596":
                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"];
                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"];
                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [20, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                var_3c1147f3a07e0b51["VwXl+"] = [20, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [20, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                break;
                                                                              case #"hash_127d6ae747a36c62":
                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [30, "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4="];
                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [30, "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU"];
                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xce\xf5bN_\x1c\x182", ",\x9d\xb7\xbd\xd6\xfa\xec\x98n!`b\x80\x12\x8eb"];
                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [30, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                }\
                                                                                xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                    var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [30, "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "l\xb7\xb5\x83}&r_\f\x89"];
                                                                                    break;
                                                                                  }

                                                                                  break;
                                                                                  case #"hash_2f2d546c2247838f":
                                                                                  switch (weaponname) {
                                                                                    case #"hash_ff9799d32cdfe811":
                                                                                      var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x91t\xf3C\x86xi\xc3,l1\xe6\xb0\x12\xaahd]P\xed\x1a\xf2>H\x8b\xa8m@", "\xa0n\xed\xac\xa8k\x9f1$\x88\xb6\xd1\xb0\xfbR2\x88\b\xf1N\xb4\x80P\"#\xba\x17\x1e", "\xc8\xf5{UE`w\x90\x11\rC\x03\x10\xd9\xc0^7\xc3?\xc51b\xcb\x95H\xc5v\xe7"];
                                                                                      var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x9a\xea\a\xeb5\xe006\xd7\x1bm\xafpk-6o8\xfa\x9b\xe8\xdb\x1b\xad_he\v;y2", "*\xc7\xab\xdcn\xe1\xc5\xab\x1d\x12\x92kt\xc7\xc8Hx\x867p0\x9aQ^}\xd4\xa3W", "v\x1e\x9d\xd1}H\"*\x99\xa4\xb8Ms\x05\xf5\xec\x04;P\x12\xaf\xb8\xde[\xd1\xc0\xdaTaz\xf3"];
                                                                                      var_3c1147f3a07e0b51["H\xecq\xdd"] = [40, "\xb9\xae{\xfcg\xa8R\x9e\xed\xfa\x80\x9b\xd8L\xdc\xfafe\xb9co\xfcZ\x939\xaf\xa2\x84Ro-\x8c"];
                                                                                      var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                      }\
                                                                                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                        break;
                                                                                      }

                                                                                      break;
                                                                                    case #"hash_719417cb1de832b6":
                                                                                      switch (weaponname) {
                                                                                        case #"hash_67577d66829ce1b5":
                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [10, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                          break;
                                                                                      }

                                                                                      break;
                                                                                    case #"hash_23209741b93850b5":
                                                                                      switch (weaponname) {
                                                                                        case #"hash_568cc2d89894d1e4":
                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "b\x169\xa3]1+\xaf7\x86\xf5\x1c\xc4f", "\xad9t\x8e%b\vf\xaf_\xe1S\a\vl\x0f\xcf\x03eN", "\x8e\xbd\xb3LU\x93=\\J7t\x9f\x84\x11\xaf\x85\x10\x9e\xdfV", "`A\x8f\x14b\xae8\x87\xeb\xacc\x1e\x95\xb0\vuR\x1b\a\xa1"];
                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "T\xb3\xce\xb9\xd4\x13$\x16\xce\x99\x8e\a\x1e", "\xf2\xa9\x11;8\x15DO\x93\xb8\x11V\xccb\xeb\xd27\xd1\xda", "dX\xdc2\xe3\xc5\xc524Z\x8a.\x94\x87\xabS]wP\xac\xce", "\xbe,\x9fPR\x8b\xab\xe49\x14\x1eQ\x82\xd9\xe4~.\xfb", "\xd6\x93\xde\xd8E`\xa2@\x06 z\x90g\xa9", "\x1fPx\x15\xfa\xc5G\xa0\xb8\xffSjP<\xa8\x11[@\xb7\x18"];
                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [30, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                          var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "p\xad\x9a[\x1b\xa9\xca\xb8\xf9", " o\xec\xeas\x8e\x1a\xbf\xfdX>\b\xdd\xce\xc2\x02\xd1\xf7", "\t\xe9\x8ecRU\xe9A\xe8\x96\xa4\xe6\xee\xce\xe8", "\x11\xe5d\xb3\xaacE\x8e\x89K\xf5G\xb1L\xd6"];
                                                                                          var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L"];
                                                                                          break;
                                                                                      }

                                                                                      break;
                                                                                    case #"hash_900cb96c552c5e8e":
                                                                                      weaponprobabilities["\xda\xee\xf5\xe6\xbc\xf0|*\xcb\x89!\x05B\xcb\xbcC"] = 50;
                                                                                      weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 50;
                                                                                      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                      switch (weaponname) {
                                                                                        case #"hash_175809755197c4da":
                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xfe\xa7\xe1\xc7\xd4\xb2\xec\x83\x87*", "\x98\xc2\x93\xebnk\xd7l\xb7\xdcg\xbe8\f2", "\xf7\xc7Np\n\xb6\xd8\xad\xb6\xd0\x8e\x06PBn|", ">\xf6M\x83\x0e(@\xf9sg#\xa0\xce\x83\x84."];
                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xe4|!.\xf6\x99\x84J\xf3\xf3r\xaeb*\xee\x1c\xa6\xc3\xad", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed"];
                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "B\x87\xa6q\xdd\x13\x84\x06\x14\xd1", "\xe82\xf5\x98k\xfd\x8c\x99\x1f\xd2?\x02\x8e@\x01V", "\x83),\xc0\xab\xab\xa5\xdf\xb8\x9f&\xb4\n\xf8\xb6\xf0", "\x13\x99\x123Y\xe8\vw\xbc\\\xb8"];
                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                          var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x83\x18\xc7R\xe8\x81?\xfcG\xe7\xc0\xbe\xaa\xae\x1d\x9c\xf8\xda"];
                                                                                          var_3c1147f3a07e0b51["VwXl+"] = [50, "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                          break;
                                                                                        case #"hash_294ef3868701b31a":
                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                          break;
                                                                                      }

                                                                                      break;
                                                                                    case #"hash_6191aaef9f922f96":
                                                                                      weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100;
                                                                                      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                      switch (weaponname) {
                                                                                        case #"hash_4fd524ce5cfa34e4":
                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                                                          break;
                                                                                      }

                                                                                      break;
                                                                                  }

                                                                                  return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                }

                                                                                function function_db843fe55ef1e21d(weaponname, weaponarray) {
                                                                                  if(self.classname == ".\x88\xb0\x7f\r\xab\xa3\xbb\x81}\x13^X\xf3%\xc7\xd6\x94\xa7\x97v\\y\xbb\xb5iJJ\xfa\v%") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_4fd524ce5cfa34e4":
                                                                                        return utility_sp::make_weapon_special("\xc4i6\xc7{\x94\x9c\xff2\xf8\xf9dw\xb9\xaf\x81");
                                                                                    }
                                                                                  } else if(self.classname == ",\x8dt\xdb\xc9\xaf\x96\xee\x9c\xeba\x8d\xb1\xe5\xf5hYNo}\xb9\xdb\v\xe0\xbe[\xac\x87K\xb1{" || self.classname == "\v6\xa3\xed\xe4\xfa\xb4\xee'\xd7\v\x1b6\xf2\xd7h\xca\xe4\xf6\xeb\xcd{X\xc1\xeb\xb3\xba\xe6s\xd0\x96\a") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_accc6d1d86e48732":
                                                                                        return utility_sp::make_weapon_special("\x96mRYHy@,\xedr\x11\xd6\x12\x92\x1c\xf3=p2");
                                                                                    }
                                                                                  } else if(self.classname == "\x856\x8e\xde\xc9\xf5-\xee9\xeb\x166\xb1\xcb\xaf\xd0V'\xdb\xbe\xec\xe4\xb0\xd9\xb2\x9b\xebs\xd0\xd2\x0e\x163" || self.classname == ":\x98\xd1<\x1f?\xde\xef5]\x88\t\nB\x8d\xe1\x92\x82\xf8\x82\x1f\xe1\xbf\xbf\xf8\xc7\xd4\x1e\x83\x13/\xa3\x81:\xcc\x86d\xa4m" || self.classname == "\xfa\x9c}\x98\xcb[b\x1f\xfc]M\xa5\x0f{C\xfeyTp\x96 \xcab\x97VGS\x8a\x9dv") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_dd873e17fc65c845":
                                                                                        return utility_sp::make_weapon_special("\xfe\xccvsy-e \xfa:qa\xd6_~[\x18");
                                                                                    }
                                                                                  } else if(self.classname == "\xfa\xb0\xee\x01\xac\x1a\xd5\xc1$Xc\xc5\x0e\xe4\xf1\xd7\xae\x93}\xb3\xbf\x15I\xc1\x81" || self.classname == "8\x86\xa8d\xf2\xea\xbf\x97s6\x02\xccg\x9fI\xc8x\xc2\xc5T\xc7\x06>\xd5\xa726\xa5x\xed\xc2\t" || self.classname == ",6:\xde\xc9_Z\xbbr_\x16c\x8d^\xafhV'\xed\xf5\xec\r\xdes\xe8\xfa\x8c\xac\xb9e\x9c:\xafg\xd57n\x86\x96\xe0") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_82d03e9871615139":
                                                                                        return utility_sp::make_weapon_special("\xea\xed8\x8fiQ\xfb\xa7\xa8\xb8\xb9=\xday\x139-");
                                                                                    }
                                                                                  } else if(self.classname == "\xe6\xb3\x1b\xd5\a\n\xed\xf6\x05\xc6\x84\xd9%\x10\xfaL\xda\xdc\x97y\xfb\xf6$\xa1\xe0\x8f\xd1\xf2pE\xa2:" || self.classname == "F\"6\x8f\x7f\x85\x1e\xb9\v\v\x04\xec\xe4\xef\xd5\xc4\x80h\x0e:\x9b\xf0\xdc\xddl\x06z`\xb7g\xf9Si\xeb") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_aa1268e549fd317":
                                                                                        return utility_sp::make_weapon_special("\x98\x95\xd6\xf4\x82\xd6\xe8<?0\x0fc\xc8\xce\xcf");
                                                                                    }
                                                                                  } else if(self.classname == "\xf1\fV2\n\xa2\rw\xe8\x8a\xaf\x8d\xf1\x05\xe2\xf33\xe9\x909\xee\xef\x144\xe2\xc8l\xea0" || self.classname == "*<\x8fo\xd7\xfe\xec\x86%\x01\xb3B\x8e\xf02\xe9\xabwmB\x01r/\xc13M0\xd3\xaee\xb1\xee\xea\xb4)" || self.classname == "i\xe6\xf0\xd4\xecs,7\x89YTpFs\x9e0\xff\xefv\x14\xcc\xfd\x94Y\x857\xe2-\x02m\xae\xa8?l\xfa\x1a\x89") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_252ac91b23d22c17":
                                                                                        return utility_sp::make_weapon_special("\xbc\x89\x1e\xaa.\xc6\xc1_\xbc\xe4\xa6JCw\xd5L%^\n");
                                                                                    }
                                                                                  } else if(self.classname == "\x04)U\xb2\xd3T\x92\x92\x1aA\x91Q\vim\x99\x1b8\xf8?\xacQy\x03\x9a\x9f\x97\x97M\xb4\x9b?") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_a89739756fa439cf":
                                                                                        return utility_sp::make_weapon_special("\xc3vL\xfa\x86\n\a\xd3\xc7K>\x9a\xc2\xf2\xf0");
                                                                                    }
                                                                                  } else if(self.classname == "KA\x86\xce\xc5\xda\x0e\x8e\x11\xc2\xe4\xbby\x06\xc8I)\b\xef\xb2\xee\x95\xfdkQ" || self.classname == "[\xa2\\q>\x04$}>\x87.\xb3}\xbee\xfdq\xb1\xe7\x95U\xd6\xaa\xc8") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_aa1268e549fd317":
                                                                                        return utility_sp::make_weapon_special("\xbb\xd9o\xfd\xf6\x14G \x87\xa8\xf8\x9c\xadv\x14");
                                                                                    }
                                                                                  } else if(self.classname == "\xbfN\xd1\xe7wp\xd0]\x99>\xf7\x8a\r\x02kC:\x86 {\xf9\x80\v\xe5/mx") {
                                                                                    switch (weaponname) {
                                                                                      case #"hash_73753b6a3bde7482":
                                                                                        return utility_sp::make_weapon_special("\x98Z\xd9\x11Ns\xe5\x83\xdd1\x83\x19\xc4\xf6\xe1\v2!");
                                                                                    }
                                                                                  }

                                                                                  if(getdvarint(@ "hash_45281f93550798")) {
                                                                                    iprintln(self.classname + "\xda" + weaponname + "-x~tR\x0e\x84\x88ca\xe6\xf5}DaY\xdfa\x8b{hHe\xc3\xff\xb4\xf6GG>3\xe0\xfa1H2@0-\x01\xdae\xb5");
                                                                                  }

                                                                                  return utility_sp::make_weapon(weaponname, []);
                                                                                }

                                                                                function function_4cec8b8c6b92da5c(type, weaponname, weaponarray) {
                                                                                  camos = getweapon_camos("\x14/P");
                                                                                  var_3c1147f3a07e0b51 = [];
                                                                                  attachment_combos = [];

                                                                                  switch (type) {
                                                                                    case #"hash_fa18d2f6bd57925a":
                                                                                      weaponprobabilities["F\xf6\xd0^\x1dJ\x04\x80\x1a\xcd\xce\xef@vP"] = 50;
                                                                                      weaponprobabilities["\xf8s\x8aO.\xfa\xd7~\b\xad\xd3\xf0\x19\x11`\xac"] = 50;
                                                                                      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                      switch (weaponname) {
                                                                                        case #"hash_a89739756fa439cf":
                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "}\x98u\xa1>\xa7,\xe5Xj*\xe3\x19\xa6K\x05\x1eQ\xbf\xbe\xae\xf3<\xcf", "\xdc:\xcf\xb7\xf0W\xfe\xb1\x8cL\x1f~Z\xfe\x1b", "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\xc2\xfc\xd5\xb0\xfcze\x16\xb6\xc1\xae\xb8\x8a\x1anG\xa0\xcf*s@\f`b\xc1"];
                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ"];
                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xba\x9e\x83w\x9f0[v|\xd2", "u\xfd\x10\x8d\xc1\xbc\x8a|\x1c\x1b\x98\r\x02\xbch`", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM"];
                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                          }\
                                                                                          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                              n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                            }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                            var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "G\x87n?\x03\x1c`@\b\xb5\x7f"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                            break;
                                                                                            case #"hash_aa74a17ec13f0a08":
                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [100, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\x16z\x01\xd0\xfc\xff-S\xda\x9b"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x90@T\x19`\xa0\xc0\xf7D\xeb", "\x9c~t\x1c\xb0TLa0\xe2\xec\xd1\x1ct9:", "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                            }\
                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x94\x03\x03~\xf4\x19*", "]\xc4\xeb\xce\xc601\xf5\a\x18\x98", "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                            break;
                                                                                          }

                                                                                          break;
                                                                                        case #"hash_f4b0076c03d93738":
                                                                                          weaponprobabilities["X\xff\xae\x88\xfbA\xbe`\x83\x919\xee^e\x9f"] = 50;
                                                                                          weaponprobabilities["\x96\xee\xe4\xaf1'\xf5n\xdbn\x1b,\xc9\x13h\xd7\xe6\x0e"] = 25;
                                                                                          weaponprobabilities["\xea-3\xe4\xa9=\xd1\x87w\xbf\x9f\x87I\xad\xf6\xb1"] = 25;
                                                                                          weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                          switch (weaponname) {
                                                                                            case #"hash_127d6ae747a36c62":
                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4="];
                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU"];
                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xce\xf5bN_\x1c\x182", ",\x9d\xb7\xbd\xd6\xfa\xec\x98n!`b\x80\x12\x8eb"];
                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                              }\
                                                                                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                    var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "l\xb7\xb5\x83}&r_\f\x89"];
                                                                                                    break;
                                                                                                    case #"hash_45c546e6f731646e" :
                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xcd;\xd9F\xc8\xd0\xa2\xb7\x97o\xaaP\xc5\xb9?L\xc5\x9bQ", "1\x85\x93\xbe\xc8\xd6\xfa\x1a\x95\x85\xce\x97_\xe0\x13\x83_s\xdesl,\x93L4", "\xdd\xe3\xee0\x1d\xbbyO\a.\xa9\xdc\xb0\xf6\"\xfc\xb9s\x86", "b\xc2\x9c_\x98'\xaf\x1aea\xec\x97\xaf\x83\x98\x0e\xfa\xcd\xdb\x9b6\xc2\x93bh"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "c\b\xbc\f\x95\xb1\feQ(,\xd5\xb4y\xe4`\xe1\xf9\xb1uU\xaa\fo~YK", "\x92D\xafH\xe7\xb3\x19<\xbd>\xb8\x7f\x80}F\xb9$\x11\xa5\xc6\xa5\v"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "c\xa1\xafC\xcb\x94!\xf4\x1c\xd7\xd9", "\nn\x1f\xc5k|\xe5\x8f'n\x8f\xddw\xf5\x87\xe4", "\xfcZ\xd0\\\x17\x8e\xa7'\xa8\x96\x9av+K\xf3\xe5/\x9c\x17"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                    }\
                                                                                                    xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                      "] = [50, "l\xb7\xb5\x83
                                                                                                    } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                    break;
                                                                                                    case #"hash_de04cb31d20ef327" :
                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xcfwr\x06P\xd6\xe8$m\x96\xcdUu\xaa\xf6\xb2\x88"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "`P\x86w\x91\xed\xc3\x95\xdd\xc3\xbd+m", "p]\xd4\x81G+\xa1\xe2\xdb\xcf\x13f\xa6\xdc\x13\x8b\xe8v\x81", "H\xceg\x9d\xc5\xdbH\x96u\xcfs\x86\xa1QY6\xe2\x1b\xe4\xfa\x89X"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xb3\xfa#m}\xc1\x19\x03", "\x06[\x9a\xea\xf4\x1a\x9c\xde\xbdr\xb8\xe0k\xeb\x10Q"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                    }\
                                                                                                    xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                      "] = [50, "l\xb7\xb5\x83
                                                                                                    } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                    break;
                                                                                                  }

                                                                                                  break;
                                                                                                  case #"hash_ba39cac9c099d4f1":
                                                                                                  break;
                                                                                                  case #"hash_2f2d546c2247838f":
                                                                                                  weaponprobabilities["\xcb\x9f\xc5\xd1\xe5\xa7\x99j;V\xfd\xa2\xb3\x91g9"] = 55; weaponprobabilities["baa\x1dH\xe6|\xc3\xfa\x8a\xe0\x03\x9a;b"] = 45; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                  switch (weaponname) {
                                                                                                    case #"hash_62459cc0741ed82f":
                                                                                                      var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe5\xc6q\xcc*U\xf8\x19\x16\n", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4=", "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "\xf0\x04\x81\xc3\xe4\xf6<}4\xc4\x15\xe5\xf8\xaed\xa0", "\xf4\xab\b\x9ba\xba\x7f_\x0ef\xc9\b\xc9g&\x0e"];
                                                                                                      var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a"];
                                                                                                      var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xc4Vl\xe8}6k_\xe0\x81#", "s\xaf1\x98\xa0E\x11\x93]\x1ar\xcc\xcb\x0f\x9c\xa9\x1a"];
                                                                                                      var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                      }\
                                                                                                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\x01\xfc\xa3M\x99\xd4O$\x95\x9eUu\xc6*\xc0"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                            break;
                                                                                                            case #"hash_c82a1fa1c794832c" :
                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                            }\
                                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                break;
                                                                                                              }

                                                                                                              break;
                                                                                                              case #"hash_719417cb1de832b6":
                                                                                                              weaponname = "\xef\x99m\xfe\x86\x14\x7fn\xe6\xce\xe8.d\x02\xdc\xf2";

                                                                                                              switch (weaponname) {
                                                                                                                case #"hash_7e15428d3b55ef10":
                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xc6\xe0\xb0\x7fZ\x8ds\xc3J\x8b\x9f1\xaf\xce8\xbf", "\xf7\xf9g;\x90Q\xb89\x9c0"];
                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8a\x0e\x90gr_\xba\xefu:`\xc8SC"];
                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "3[\t_L2;\xac\xe2\xf3", "m\xc2;\xaf\xc1Z\xbe\x8d\xb0\xc9\xb3+\xbe\x83#C"];
                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80"];
                                                                                                                  break;
                                                                                                              }

                                                                                                              break;
                                                                                                              case #"hash_23209741b93850b5":
                                                                                                              weaponprobabilities["Si\xbd\xf8;}D7\xbb\xf3\x81\xceO0i\xfd"] = 50; weaponprobabilities["o\xff\xe4~\xb7\x01aq\x9e'By\x92\x05\xc7%\xbc\xf8\xb7\xa9"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                              switch (weaponname) {
                                                                                                                case #"hash_568cc2d89894d1e4":
                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "b\x169\xa3]1+\xaf7\x86\xf5\x1c\xc4f", "\xad9t\x8e%b\vf\xaf_\xe1S\a\vl\x0f\xcf\x03eN", "\x8e\xbd\xb3LU\x93=\\J7t\x9f\x84\x11\xaf\x85\x10\x9e\xdfV", "`A\x8f\x14b\xae8\x87\xeb\xacc\x1e\x95\xb0\vuR\x1b\a\xa1"];
                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "T\xb3\xce\xb9\xd4\x13$\x16\xce\x99\x8e\a\x1e", "\xf2\xa9\x11;8\x15DO\x93\xb8\x11V\xccb\xeb\xd27\xd1\xda", "dX\xdc2\xe3\xc5\xc524Z\x8a.\x94\x87\xabS]wP\xac\xce", "\xbe,\x9fPR\x8b\xab\xe49\x14\x1eQ\x82\xd9\xe4~.\xfb", "\xd6\x93\xde\xd8E`\xa2@\x06 z\x90g\xa9", "\x1fPx\x15\xfa\xc5G\xa0\xb8\xffSjP<\xa8\x11[@\xb7\x18"];
                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "p\xad\x9a[\x1b\xa9\xca\xb8\xf9", " o\xec\xeas\x8e\x1a\xbf\xfdX>\b\xdd\xce\xc2\x02\xd1\xf7", "\t\xe9\x8ecRU\xe9A\xe8\x96\xa4\xe6\xee\xce\xe8", "\x11\xe5d\xb3\xaacE\x8e\x89K\xf5G\xb1L\xd6"];
                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L"];
                                                                                                                  break;
                                                                                                                case #"hash_81f38f52e4aaecf5":
                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x17\xd2\x10\x18\xc2\x84W\xa7\xc2{", "s\x97\x01?\xe9\x1d\\\\0\x9cU\xfd\xbf\x19\xd2\xeb", "\x9a\xc7\x12\a3\te\x1c\x1b\xec;k{\x97D"];
                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe0\x88\x85\xb6\xb2\x1b*r\x80^o\x90", "\xf7\xccl\xd2\x81\xc3\xb5EE\xeaL\x15\x90\x96\xbd\xbb\xdb\x804\x9d\xc8T", "\nty9<|\x19c\xf6_\x94\"\x13\xb7\xfa\x84wP\x14", "\\b\xc0\x17\xbb\\P-SA\xb2\x8e\xcf+"];
                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\xc0]\xa0.\xf8O.W\xfc", "v\xab\v\x9c2\xeb\x86+X\xcey\xbe8&\xd0", "Op@\x921O\xac\x1f]M\rt\xb93\x1a", "\x8c\xf8f\x0e\xdf\x04Q\xd77\rU\x06\x9e\xe8\xe0\xfb\x969"];
                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                  break;
                                                                                                              }

                                                                                                              break;
                                                                                                              case #"hash_900cb96c552c5e8e":
                                                                                                              weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 40; weaponprobabilities["\xda\xee\xf5\xe6\xbc\xf0|*\xcb\x89!\x05B\xcb\xbcC"] = 30; weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 30; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                              switch (weaponname) {
                                                                                                                case #"hash_15d131b492bdb596":
                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"];
                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"];
                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                  break;
                                                                                                                case #"hash_175809755197c4da":
                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xfe\xa7\xe1\xc7\xd4\xb2\xec\x83\x87*", "\x98\xc2\x93\xebnk\xd7l\xb7\xdcg\xbe8\f2", "\xf7\xc7Np\n\xb6\xd8\xad\xb6\xd0\x8e\x06PBn|", ">\xf6M\x83\x0e(@\xf9sg#\xa0\xce\x83\x84."];
                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xe4|!.\xf6\x99\x84J\xf3\xf3r\xaeb*\xee\x1c\xa6\xc3\xad", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed"];
                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "B\x87\xa6q\xdd\x13\x84\x06\x14\xd1", "\xe82\xf5\x98k\xfd\x8c\x99\x1f\xd2?\x02\x8e@\x01V", "\x83),\xc0\xab\xab\xa5\xdf\xb8\x9f&\xb4\n\xf8\xb6\xf0", "\x13\x99\x123Y\xe8\vw\xbc\\\xb8"];
                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x83\x18\xc7R\xe8\x81?\xfcG\xe7\xc0\xbe\xaa\xae\x1d\x9c\xf8\xda"];
                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                  break;
                                                                                                                case #"hash_294ef3868701b31a":
                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                  break;
                                                                                                              }

                                                                                                              break;
                                                                                                              case #"hash_6191aaef9f922f96":
                                                                                                              weaponprobabilities["\x84\xd0\x05V\xfcn\xb7\x16cy\xab~3\xf4aU"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                              switch (weaponname) {
                                                                                                                case #"hash_3fd5bba485c2aea6":
                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x98\x85\x93\xfa\xdc\xe6\xf5p\f\xc8"];
                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "s\x1d{\xc6\xb6\xeb,9_\vss\xc2\xae\xb1t\xbe\a\x18\x19\xfa\x1c\xec\xdb\x1bf&", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88"];
                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdf\x7f\xc1N\b\xe2v]\x7f\\", "\xd4#\x03\xdf\x86\xc5\xb7\x96\xc0\xd02\xf4\xeey\x8c\xe2"];
                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [100, "2\x11\xa3\xd5Z\xe0\x99V\xb5\xce\x19z\x01\x17u"];
                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [40, "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                  break;
                                                                                                              }

                                                                                                              break;
                                                                                                            }

                                                                                                            return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                          }

                                                                                                          function function_33633a8040e8673f(type, weaponname, weaponarray) {
                                                                                                            camos = getweapon_camos("kjT\xb4\xea[");
                                                                                                            var_3c1147f3a07e0b51 = [];
                                                                                                            attachment_combos = [];

                                                                                                            switch (type) {
                                                                                                              case #"hash_fa18d2f6bd57925a":
                                                                                                                weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 50;
                                                                                                                weaponprobabilities["X\xff\xae\x88\xfbA\xbe`\x83\x919\xee^e\x9f"] = 50;
                                                                                                                weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                switch (weaponname) {
                                                                                                                  case #"hash_aa1268e549fd317":
                                                                                                                    var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                    }\
                                                                                                                    xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                    var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                                                                                    var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                                                                                    var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                                                                                    var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                    var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                    break;
                                                                                                                  case #"hash_127d6ae747a36c62":
                                                                                                                    var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                    }\
                                                                                                                    xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                        n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                      }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                      var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU", "\xce\xe6\xd5\xda\x86P4\xc1\xdb\x0e\xb5\x8f'W0Q4\x88", "\xe6UP\xf7\x1c\xe2\x85Cx\x19\x91\xe2/\xff\x1f\xd0i\x93", "\x88s\x10\xca\xbac]\xce\x87g^\xaa\xbc\xedo\x89\x02;\xf00u\x91\xbf?@c", "w(n\xd3T\x9d`\xea]\xf5^V\xd7z??\x8bC\x81\xc4\"\xfc\xe2\x9f\x92`Z"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [100, "\xf0\x04\x81\xc3\xe4\xf6<}4\xc4\x15\xe5\xf8\xaed\xa0", "\xf4\xab\b\x9ba\xba\x7f_\x0ef\xc9\b\xc9g&\x0e", "\x1b[\xa4\xbd\xf9b\xfe\xfd\xdfY\xef\xe1|\x9e\xa4k", "\x01\xa2\xcbW\xc9\x14\x18\xa5'j^!\xd3;\f/\x99\xa2\xd8K\xa1=", "\xf4\xe0\xc0O\x06\b\xf9kk\xd6\x97\x99\xfb\n\xff\x98\xed\xaa|\x9dc\x9b", "6\x9a\xc9\xfc\xdbe\xbd\xff\x1f^L\x05lPS\xcc\xe6\xd3\xf8\xb1?\xeb"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xce\xf5bN_\x1c\x182", ",\x9d\xb7\xbd\xd6\xfa\xec\x98n!`b\x80\x12\x8eb", "G \xde\xcd\xfc\xf9!\xe2\x9cP\xbf\xfc\xaf,\xca\x11\xd6+\x91\xb8\xd3\xc1", "\xc9Pa0yx\x94\x9738\x8d\a\xb2\xfd&&"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\xde'O\x15\xd7\xa3\xd6O\xd06", "\xb7Q\x9c@e|U!\xca9", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "P\xf4\xb5\x80FT\xdb\xe3\xb6\xb8", "4\xbd\xdei\xf9\xcc\xf5\x06UlA", "\xbcrn\x85G\xe2\xc2\xbe\xcb\xe2\x97", "1\xca\xd4\xcf<\xf2\xc7\x87\r\x94\xdb"];
                                                                                                                      break;
                                                                                                                    }

                                                                                                                    break;
                                                                                                                  case #"hash_f4b0076c03d93738":
                                                                                                                    switch (weaponname) {
                                                                                                                      case #"hash_63a6ddf69b9373c9":
                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9pj", "}\x10\xa1\x0e\x1e\xd2\xa6\x8d\xab\x1fO\x1e\x7f\xf8H"];
                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "Z\xd9\x8e\x065\x83\xbf\xb3\xfd>\xca\xa9\x18\x9e\xac9\xae\xfc", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6"];
                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdfS\xe4d\x83\x1e\x1c\x03P\v", "fn5\xb9\x02|\x19,/\r|\v\x18\x7f\x1c\xb5", "\xc1,WgBv0{A,r\xe6\xf6H\fh\xec"];
                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                        }\
                                                                                                                        xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                        "] = [50, "l\xb7\xb5\x83
                                                                                                                      } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                      break;
                                                                                                                    }

                                                                                                                    break;
                                                                                                                  case #"hash_2f2d546c2247838f":
                                                                                                                    weaponprobabilities["\xcb\x9f\xc5\xd1\xe5\xa7\x99j;V\xfd\xa2\xb3\x91g9"] = 50;
                                                                                                                    weaponprobabilities["\x81\xf7 \xb1J\x02OH\xd7`\n\xaar\x13\x1d\x9bf"] = 50;
                                                                                                                    weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                    switch (weaponname) {
                                                                                                                      case #"hash_62459cc0741ed82f":
                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe5\xc6q\xcc*U\xf8\x19\x16\n", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4=", "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "\xf0\x04\x81\xc3\xe4\xf6<}4\xc4\x15\xe5\xf8\xaed\xa0"];
                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a"];
                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xc4Vl\xe8}6k_\xe0\x81#", "s\xaf1\x98\xa0E\x11\x93]\x1ar\xcc\xcb\x0f\x9c\xa9\x1a"];
                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x13R\x1a+G\x94\xa1\xf3\xf5\x7fh0\xc1", "I\xca\xc5\xe9g\x12c\x1e\x85\x14\xc4\x13\x14", "\x15\xcc\x19\xbc\xcbg\xc2\xd9zW\xcf\x17W", "\xdc\x9f2\xfa\x0e\x82BH'i\b\xc6b", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "<\xc7~\x1d|C", "\xcao\xa0\xe54u", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                        }\
                                                                                                                        xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                          var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\x01\xfc\xa3M\x99\xd4O$\x95\x9eUu\xc6*\xc0"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                          break;
                                                                                                                          case #"hash_9e82f4346600ccc5" :
                                                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd(\xf7?\xaa\xef_?;\xd6", "\xf0\x04\x81\xc3%\x0e<}\xb5@\xf4\xbc\x1d\x8et"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "\xce\x06V\x86\x82PL~\xd8\x0e:T'o2LL\f^~", "eu\xa7\x01\x9e\xdbU<\xd9^\xef\x87\xdb\xd4Q,C& 9\x1f\xf7]\xb2>w\xfb\xf9h\xf8", "\xf7\x1a\x87\xf5`!\x8cj}$\x90\xfaw\xe8\xdbh\xea\xd0\x1bb*p\x12J\xe5\xf3"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xeb\xbe\xa4\xc2\x9b\xce\xf3\xc4GT\x96", "\xcd\xf7\xde\x11\x14B\x14\xb7L&\xc0\x10#XZx\xe9"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x13R\x1a+G\x94\xa1\xf3\xf5\x7fh0\xc1", "I\xca\xc5\xe9g\x12c\x1e\x85\x14\xc4\x13\x14", "\xd9y<\x03\x9b\x06R\xff\xc97\xba\x03P\xf1a\xbeo", "\xdc\x9f2\xfa\x0e\x82BH'i\b\xc6b", "\x161V\xb2\xda\x99", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "<\xc7~\x1d|C", "\xcao\xa0\xe54u", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                          }\
                                                                                                                          xeaZ\b\x8b\xd8 ", "f\xdb\xbaN\x1e`\x86\xd7\x83\x18L", "\x16\x13\x93\xca\x1e\xdc\xf1", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j", "/4q\xcf/\xbf\xa2\x99", "BQq\xa2o\x8ao\x19", "\x9d\xabQo?W\xe1V"];
var_3c1147f3a07e0b51["VwXl+"] = [75, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xc7\xf0\xa6\xf1\x1d\x8d\xe4fe\xc1\xa1\xa7j\x92Y9\xd3", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                          "] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7 ", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91 ", "\xf6\xd4\n\xb5\xc9\x8b: \xab, J\xe0 "];
                                                                                                                          break;
                                                                                                                        }
                                                                                                                      case #"hash_719417cb1de832b6":
                                                                                                                        switch (weaponname) {
                                                                                                                          case #"hash_67577d66829ce1b5":
                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                                                            break;
                                                                                                                        }

                                                                                                                        break;
                                                                                                                      case #"hash_23209741b93850b5":
                                                                                                                        switch (weaponname) {
                                                                                                                          case #"hash_568cc2d89894d1e4":
                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "b\x169\xa3]1+\xaf7\x86\xf5\x1c\xc4f", "\xad9t\x8e%b\vf\xaf_\xe1S\a\vl\x0f\xcf\x03eN", "\x8e\xbd\xb3LU\x93=\\J7t\x9f\x84\x11\xaf\x85\x10\x9e\xdfV", "`A\x8f\x14b\xae8\x87\xeb\xacc\x1e\x95\xb0\vuR\x1b\a\xa1"];
                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "T\xb3\xce\xb9\xd4\x13$\x16\xce\x99\x8e\a\x1e", "\xf2\xa9\x11;8\x15DO\x93\xb8\x11V\xccb\xeb\xd27\xd1\xda", "dX\xdc2\xe3\xc5\xc524Z\x8a.\x94\x87\xabS]wP\xac\xce", "\xbe,\x9fPR\x8b\xab\xe49\x14\x1eQ\x82\xd9\xe4~.\xfb"];
                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "|U\x96-\xcd\xe7o&\xbaU", "]\v-\xa8S\xf8*\x060\xad", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                                                                            break;
                                                                                                                        }

                                                                                                                        break;
                                                                                                                      case #"hash_900cb96c552c5e8e":
                                                                                                                        weaponprobabilities["\xda\xee\xf5\xe6\xbc\xf0|*\xcb\x89!\x05B\xcb\xbcC"] = 65;
                                                                                                                        weaponprobabilities["\xd5\x0f\xf8\xe9\xbd_\xdd\x02<3\x13}l\x13M\xfc"] = 35;
                                                                                                                        weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                        switch (weaponname) {
                                                                                                                          case #"hash_175809755197c4da":
                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "}x\xe2\x1b\x94\xfe(xk\x1f\xf0\xc9\x91\xbal\xa3\\\x9e\x97\x9a\xc3", "\x856\x15\x8f\xc4`\"\xc0\xdf_\x9a\x1d\x87\xbe\xb0\x01\x7f\xe3\bUm", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x13R\x1a+G\x94\xa1\xf3\xf5\x7fh0\xc1", "I\xca\xc5\xe9g\x12c\x1e\x85\x14\xc4\x13\x14", "\x15\xcc\x19\xbc\xcbg\xc2\xd9zW\xcf\x17W", "\xdc\x9f2\xfa\x0e\x82BH'i\b\xc6b", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "<\xc7~\x1d|C", "\xcao\xa0\xe54u"];
                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xfe\xa7\xe1\xc7\xd4\xb2\xec\x83\x87*", "\xf7\xc7Np\n\xb6\xd8\xad\xb6\xd0\x8e\x06PBn|", ">\xf6M\x83\x0e(@\xf9sg#\xa0\xce\x83\x84."];
                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xe4|!.\xf6\x99\x84J\xf3\xf3r\xaeb*\xee\x1c\xa6\xc3\xad", "Y\xe3 \xc2\x96\xe1\x9b\xcd\xcd\x0et\xb1A\xb8\x88\xf5\xc4\xed$\x14\x96\xc4\x19\xbf\x0e\xebY", "Q*\xe2\xc0\xb1(\x81,;b\xcc}\x1dgnI\x9b\x85\xde\x82\xbf\xdda h\xe4\xd1\x02", "\\\x06E\x97\xc3\x17x\x1cx_\x99{oG\n\x9e\xb44\xf4", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed", "\x8a\xc9\xa8B3\xa0\x9626\f\xbc\xb7\xb2z"];
                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "B\x87\xa6q\xdd\x13\x84\x06\x14\xd1", "\x83),\xc0\xab\xab\xa5\xdf\xb8\x9f&\xb4\n\xf8\xb6\xf0", "\x13\x99\x123Y\xe8\vw\xbc\\\xb8"];
                                                                                                                            var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x83\x18\xc7R\xe8\x81?\xfcG\xe7\xc0\xbe\xaa\xae\x1d\x9c\xf8\xda"];
                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\xe1\xe0\x96h@\x0e\x1a1\x05\xb2\xd5", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 ", "\xdc\xbfQ\x0fiEv<\x13\xdb\x96\x9a\x1a-\x82m", "\xec\xc9i\x1c};VN:nh\xed\xc9\xd1\x037"];
                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                            break;
                                                                                                                          case #"hash_119b48de90786a23":
                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "}x\xe2\x1b\x94\xfe(xk\x1f\xf0\xc9\x91\xbal\xa3\\\x9e\x97\x9a\xc3", "\x856\x15\x8f\xc4`\"\xc0\xdf_\x9a\x1d\x87\xbe\xb0\x01\x7f\xe3\bUm", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x13R\x1a+G\x94\xa1\xf3\xf5\x7fh0\xc1", "I\xca\xc5\xe9g\x12c\x1e\x85\x14\xc4\x13\x14", "\x15\xcc\x19\xbc\xcbg\xc2\xd9zW\xcf\x17W", "\xdc\x9f2\xfa\x0e\x82BH'i\b\xc6b", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "<\xc7~\x1d|C", "\xcao\xa0\xe54u"];
                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "]\xe2Pi\x1e\x1d\x95m\x96\x84\b\xb5\xe4\xfc\x1e\b", "\xe7\x92\xc1\xd25\xa3\xc4\xcfo\x82"];
                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x81N\x1a\x1a\xc89\xb0\x9e2lX\xe8\xb7\xab}AU\r", "\x1fs\xe4\x13~\xe8!.\xa6\xc5\xb0\xa7", "\xdc:\xf66\xad\xeb\xb9[\xebt\x85\xb1\xd1\xb4\xd8,6\xbep0\xb9", "UU\x1eh\xf7\xed\r\x15\xa12PL\xb0\x95c\xea6j>\xa7", "J\xael\xe4\xb0=\x8488e\xc7\x8c\xf7\xdb\xe5\x1a\x9c\xe5"];
                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                            break;
                                                                                                                        }

                                                                                                                        break;
                                                                                                                    }

                                                                                                                    return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                }

                                                                                                                function function_b99cc07e9e44a17b(type, weaponname, weaponarray) {
                                                                                                                  camos = getweapon_camos("kjT\xb4\xea[");
                                                                                                                  var_3c1147f3a07e0b51 = [];
                                                                                                                  attachment_combos = [];

                                                                                                                  switch (type) {
                                                                                                                    case #"hash_fa18d2f6bd57925a":
                                                                                                                      weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 50;
                                                                                                                      weaponprobabilities["c_\x92\xb1f\xf73\x9a\xf0\xf6j\x83R\x99\xb3\xf6\xd6\xbb"] = 50;
                                                                                                                      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                      switch (weaponname) {
                                                                                                                        case #"hash_aa1268e549fd317":
                                                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                          }\
                                                                                                                          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                                                                                          var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                                                                                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                          var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                          break;
                                                                                                                        case #"hash_1902daff8e078b20":
                                                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                          }\
                                                                                                                          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                              n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                            }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6", "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "\xca* \xdb\x97\x15a\x10\x86x\xcd\x0f\x06\xf9\x9e\v\xa5`\xfeP\x1c", "3\x8c\xe8\x91\x87\xba\xae\xc1X\xb4\\\xa9"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb4\xbf\x0e|\x1bu\xfb @\xea", "\x80L\b\xbd\x9f\xdd\xd6f9\x04\f\xbbZK{\\"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x81vhP\x91\xa4')+d", "\xeb\xce\xb8dlX\x81\x14\x15r#\x0e\x0ef\x8fB", "\xd2V^\xfd\xa3o!\rUm{\xd5\x02\xc28\x9c&"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "^jxl\xe9s\xd2Q\x82f", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xdbm\x97\x87)\x0f\xa6\x1e\n\xd2@\x19\xb3\xc3"];
                                                                                                                            break;
                                                                                                                          }

                                                                                                                          break;
                                                                                                                        case #"hash_f4b0076c03d93738":
                                                                                                                          switch (weaponname) {
                                                                                                                            case #"hash_63a6ddf69b9373c9":
                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9pj", "}\x10\xa1\x0e\x1e\xd2\xa6\x8d\xab\x1fO\x1e\x7f\xf8H"];
                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "Z\xd9\x8e\x065\x83\xbf\xb3\xfd>\xca\xa9\x18\x9e\xac9\xae\xfc", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6"];
                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdfS\xe4d\x83\x1e\x1c\x03P\v", "fn5\xb9\x02|\x19,/\r|\v\x18\x7f\x1c\xb5", "\xc1,WgBv0{A,r\xe6\xf6H\fh\xec"];
                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                              }\
                                                                                                                              xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                              "] = [50, "l\xb7\xb5\x83
                                                                                                                            } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                            break;
                                                                                                                          }

                                                                                                                          break;
                                                                                                                        case #"hash_719417cb1de832b6":
                                                                                                                          switch (weaponname) {
                                                                                                                            case #"hash_67577d66829ce1b5":
                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                                                              break;
                                                                                                                          }

                                                                                                                          break;
                                                                                                                        case #"hash_900cb96c552c5e8e":
                                                                                                                          switch (weaponname) {
                                                                                                                            case #"hash_394fc57f759066f4":
                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xee\xf3\xcea\xe2Q?\xec\xd9\x80", "\x1d\x1c9\xab\xbf\xc7'\x19\x9a\xb7i\x81\xc8x\x7f\xbe[\x94\x03", "\x11\r\xb7\x9d\vb\x14\xf6\xc2p\x01-\x1f\xf1\xf8R", "|\x95\xf6\x16P\x15?~\xbdX\xaa\x7f\xd2\x826", "e]\x99'\xe6\xbaV=\xf1\xe4\xb1+\b=IT0\xb0", "\x89\x85r\xebn\xb6\xbe\xd0+\x85\xd9\xf2\xfa\x1c\xc09", "\xe0@\x8b\xc54+!SX \xe9l\xc7K\x19\xbb", "\xf9\xb1\xce\xd8\xf3i\xa9\xe76\xe1j\x92\xdbZ\xa7\x17l[\xab"];
                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x81N\x1a\x1a\xc89\xb0\x9e2lX\xe8\xb7\xab}AU\x03", "\x1f\x97?g\xb3_\xb2\x1b]\xa4\xbb\xd3}\xef\xe3\xd8\xcb\x92", "`y\x05A\x12\xe3\xc1]\a\x80\xfe&", "\x03\r\xd9QE\x12T\xb5\xba\xe4\xdf$\xb4pU\xa6D{h\xc5;", "Kh{\xb3w\x84\x9c\xee\xb4XmtQ\xba"];
                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, " Jn\xc8\xe1j\xab\x1e\xe4/", "\xdb\xc8\xf7g\xa2\x83D\x156\xf3q,\xe5)\xa5\xa9", "\x87a\xf0\xfbfFA-f&\xcb\xe0\xcfd\xd3\xb7", "S\n\xef\xb3~\xae\x1c>\x02\x96\x95\xd7\x0e8\xe3|g"];
                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                              var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                              var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                              break;
                                                                                                                          }

                                                                                                                          break;
                                                                                                                      }

                                                                                                                      return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                  }

                                                                                                                  function function_2d98a2e7aeff82a5(type, weaponname, weaponarray) {
                                                                                                                    camos = getweapon_camos("A4\xf7o");
                                                                                                                    var_3c1147f3a07e0b51 = [];
                                                                                                                    attachment_combos = [];

                                                                                                                    switch (type) {
                                                                                                                      case #"hash_fa18d2f6bd57925a":
                                                                                                                        weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 40;
                                                                                                                        weaponprobabilities["c_\x92\xb1f\xf73\x9a\xf0\xf6j\x83R\x99\xb3\xf6\xd6\xbb"] = 30;
                                                                                                                        weaponprobabilities["*_\xcb\xf4\xe3\xcf\x9a\x05\xa6\xa1\x7f\xb3g\xb1[\xbf;L"] = 30;
                                                                                                                        weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                        switch (weaponname) {
                                                                                                                          case #"hash_aa1268e549fd317":
                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                            }\
                                                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                            var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                            break;
                                                                                                                          case #"hash_1902daff8e078b20":
                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                            }\
                                                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                              }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6", "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "\xca* \xdb\x97\x15a\x10\x86x\xcd\x0f\x06\xf9\x9e\v\xa5`\xfeP\x1c", "3\x8c\xe8\x91\x87\xba\xae\xc1X\xb4\\\xa9"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb4\xbf\x0e|\x1bu\xfb @\xea", "\x80L\b\xbd\x9f\xdd\xd6f9\x04\f\xbbZK{\\"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x81vhP\x91\xa4')+d", "\xeb\xce\xb8dlX\x81\x14\x15r#\x0e\x0ef\x8fB", "\xd2V^\xfd\xa3o!\rUm{\xd5\x02\xc28\x9c&"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xdbm\x97\x87)\x0f\xa6\x1e\n\xd2@\x19\xb3\xc3"];
                                                                                                                              break;
                                                                                                                              case #"hash_73753b6a3bde7482":
                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                              }\
                                                                                                                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                  n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xd5\xdf\x1d\xbd\xed\xd3\x1a,~sa+", "}\x8dY\x86\xa6M\xf9ud\xc2V\xc2\v\x9aF|\xea8\x16)/", "\xf7\xccl\xd2\x81f\x99\x86\x99\xb4]\x80", "\xf5.@\x84\xf61\x84\xad,\xb2\xf1\xd1\x11\x83:\xed\xecv"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "l\xc9\x06\xdd-\xd2\n\xc4\xf2@", "\x14\x95\xbc\xf4s/!\xa1\xfe\xab\x86<\x02\x81:"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "m\xc2;\xaf\x85\x9c\xbe\x0e\x18\xe0", "!\xa8\x88\xc6\xf2<5\x06nt!\xdeF\x03\xdc(\xe8", "t]\x11\xe4x\xe5?J2b\x0eM\x13\nNI"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                                break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                              case #"hash_f4b0076c03d93738":
                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_63a6ddf69b9373c9":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9pj", "}\x10\xa1\x0e\x1e\xd2\xa6\x8d\xab\x1fO\x1e\x7f\xf8H"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "Z\xd9\x8e\x065\x83\xbf\xb3\xfd>\xca\xa9\x18\x9e\xac9\xae\xfc", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6"];
                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdfS\xe4d\x83\x1e\x1c\x03P\v", "fn5\xb9\x02|\x19,/\r|\v\x18\x7f\x1c\xb5", "\xc1,WgBv0{A,r\xe6\xf6H\fh\xec"];
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                  }\
                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                  "] = [50, "l\xb7\xb5\x83
                                                                                                                                } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                              case #"hash_ba39cac9c099d4f1":
                                                                                                                              break;
                                                                                                                              case #"hash_2f2d546c2247838f":
                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_9e82f4346600ccc5":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd(\xf7?\xaa\xef_?;\xd6", "\xf0\x04\x81\xc3%\x0e<}\xb5@\xf4\xbc\x1d\x8et", "N\x82\x04\xb6\xa2'\x1e!\xab\xef\xa2a-\x86\xe8\xa0"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7"];
                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xeb\xbe\xa4\xc2\x9b\xce\xf3\xc4GT\x96", "\xcd\xf7\xde\x11\x14B\x14\xb7L&\xc0\x10#XZx\xe9"];
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                  }\
                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "BQq\xa2o\x8ao\x19", "\x9d\xabQo?W\xe1V"];
                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                  break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                              case #"hash_719417cb1de832b6":
                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_67577d66829ce1b5":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                                                                  break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                              case #"hash_23209741b93850b5":
                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_9551957c74ed1495":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "|U\x96-\xcd\xe7o&\xbaU", "]\v-\xa8S\xf8*\x060\xad", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                                                                                  break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                              case #"hash_900cb96c552c5e8e":
                                                                                                                              weaponprobabilities["\xf0\xf8\xe1KPJ\xb2+\x96\xe5\x9di\xb3\x95\xa7\x95"] = 50; weaponprobabilities["\xb4\xdd\x9c_n\xb6}\xc28,\a\xc2\xf5\xb9\x1c"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_394fc57f759066f4":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xee\xf3\xcea\xe2Q?\xec\xd9\x80", "\x1d\x1c9\xab\xbf\xc7'\x19\x9a\xb7i\x81\xc8x\x7f\xbe[\x94\x03", "\x11\r\xb7\x9d\vb\x14\xf6\xc2p\x01-\x1f\xf1\xf8R", "|\x95\xf6\x16P\x15?~\xbdX\xaa\x7f\xd2\x826", "e]\x99'\xe6\xbaV=\xf1\xe4\xb1+\b=IT0\xb0", "\x89\x85r\xebn\xb6\xbe\xd0+\x85\xd9\xf2\xfa\x1c\xc09", "\xe0@\x8b\xc54+!SX \xe9l\xc7K\x19\xbb", "\xf9\xb1\xce\xd8\xf3i\xa9\xe76\xe1j\x92\xdbZ\xa7\x17l[\xab"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x81N\x1a\x1a\xc89\xb0\x9e2lX\xe8\xb7\xab}AU\x03", "\x1f\x97?g\xb3_\xb2\x1b]\xa4\xbb\xd3}\xef\xe3\xd8\xcb\x92", "`y\x05A\x12\xe3\xc1]\a\x80\xfe&", "\x03\r\xd9QE\x12T\xb5\xba\xe4\xdf$\xb4pU\xa6D{h\xc5;", "Kh{\xb3w\x84\x9c\xee\xb4XmtQ\xba"];
                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, " Jn\xc8\xe1j\xab\x1e\xe4/", "\xdb\xc8\xf7g\xa2\x83D\x156\xf3q,\xe5)\xa5\xa9", "\x87a\xf0\xfbfFA-f&\xcb\xe0\xcfd\xd3\xb7", "S\n\xef\xb3~\xae\x1c>\x02\x96\x95\xd7\x0e8\xe3|g"];
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                  break;
                                                                                                                                case #"hash_de5d1bd3a9f86945":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2D\xdb{?c\vLA\xbc\xbe\xb8\xbf='V", "\x02-\x95\xb1\x9f\xf1\x89\x9c\b\""];
                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xcf\x11\x1bv\xe3\xc2\xfd\xc4\xa5G\xa8\xdb", "\xd6\xaaGY\xbfW\x12b=uzs", "\nq*\\\xb8\xf42\x15\x01\x11Xk"];
                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x96\\\xa5P\xe8\xc1\x12\xa5\xff\xb8", "Mo\xef\\\xf7\x84_\x1f\x99~L\xcfP\x9d\xd3."];
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                  break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                              case #"hash_6191aaef9f922f96":
                                                                                                                              weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_4fd524ce5cfa34e4":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                                                                                                  break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                            }

                                                                                                                            return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                        }

                                                                                                                        function function_ac95f98c94c57bb0(type, weaponname, weaponarray) {
                                                                                                                          var_3c1147f3a07e0b51 = [];
                                                                                                                          attachment_combos = [];

                                                                                                                          switch (type) {
                                                                                                                            case #"hash_719417cb1de832b6":
                                                                                                                              weaponname = "\xe7b\xaa\x911qD@ \x1c\r{WYr/";

                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_b2d9146c8c4f36fb":
                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, ";\xf8\\\xd0{\x8c\xb7\xe6\xef\x1a", "S\xc9X\x1a,\x8b\xd5{h\xe6\xd7-\x9aV\xca\xe5", "\x1e\xfa&\\\x7f\x85\xfcd\x16:\xa8\x7fc\xefr\x12"];
                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "3[\t_L2;\xac\xe2\xf3", "m\xc2;\xaf\xc1Z\xbe\x8d\xb0\xc9\xb3+\xbe\x83#C"];
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                                                                  break;
                                                                                                                              }

                                                                                                                              break;
                                                                                                                          }

                                                                                                                          return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, undefined);
                                                                                                                        }

                                                                                                                        function function_1e6528055a7fdafa(type, weaponname, weaponarray) {
                                                                                                                          camos = getweapon_camos("\xde6K\x81\xc9\f");
                                                                                                                          var_3c1147f3a07e0b51 = [];
                                                                                                                          attachment_combos = [];

                                                                                                                          switch (type) {
                                                                                                                            case #"hash_fa18d2f6bd57925a":
                                                                                                                              weaponprobabilities["F\xf6\xd0^\x1dJ\x04\x80\x1a\xcd\xce\xef@vP"] = 30;
                                                                                                                              weaponprobabilities["q\xe5\x93\x03V\x87\x84;\xf49\xd3{\xc1T\xbc\x18\x87\x9b"] = 15;
                                                                                                                              weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 15;
                                                                                                                              weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 15;
                                                                                                                              weaponprobabilities["\xf8s\x8aO.\xfa\xd7~\b\xad\xd3\xf0\x19\x11`\xac"] = 25;
                                                                                                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                              switch (weaponname) {
                                                                                                                                case #"hash_a89739756fa439cf":
                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                  }\
                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                        n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                      }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                      var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "}\x98u\xa1>\xa7,\xe5Xj*\xe3\x19\xa6K\x05\x1eQ\xbf\xbe\xae\xf3<\xcf", "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\xc2\xfc\xd5\xb0\xfcze\x16\xb6\xc1\xae\xb8\x8a\x1anG\xa0\xcf*s@\f`b\xc1"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "u\xfd\x10\x8d\xc1\xbc\x8a|\x1c\x1b\x98\r\x02\xbch`", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xcc\xe7aK\xd6\xa0h~\xa1t\x9dJD\xcf3\xd7'"];
                                                                                                                                      break;
                                                                                                                                      case #"hash_2253efe9671d59b5":
                                                                                                                                      var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                      }\
                                                                                                                                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                          n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                        }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x9a\\\xd2\x91\xa9HC\xa8\xb9\x88\xedE\v\xee\xb4\x17\x12\xf8\xf9\x96\xf0\x18\x18U\x8dd:", "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\x8eoT\\\xbf|_\x1d\x12uIn0\x95\xc2\xe8\xab\xb7\xdc"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0", "\xb5\xc2\xd9_X\xe4_\xc6\xce\x1dxc\xc2\xc9\xb3e_\xe0\xc0C"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "G\x87n?\x03\x1c`@\b\xb5\x7f"];
                                                                                                                                        break;
                                                                                                                                        case #"hash_15d131b492bdb596":
                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                        }\
                                                                                                                                        xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                            n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                          }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                          break;
                                                                                                                                          case #"hash_aa1268e549fd317":
                                                                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                          }\
                                                                                                                                          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                                          break;
                                                                                                                                          case #"hash_aa74a17ec13f0a08":
                                                                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                          }\
                                                                                                                                          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [100, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\x16z\x01\xd0\xfc\xff-S\xda\x9b", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x9c~t\x1c\xb0TLa0\xe2\xec\xd1\x1ct9:", "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                                          break;
                                                                                                                                        }

                                                                                                                                        break;
                                                                                                                                        case #"hash_f4b0076c03d93738":
                                                                                                                                        weaponprobabilities["\xac\xeb#\x9c\xb5\xc8\xa0Caj\x1c\x98\xbd\xf0\xb7\xf2"] = 40; weaponprobabilities["\x1eu\x8f\xc3\x93O\xb7\xe5\x98Q\xffFA\b\xd9=o"] = 30; weaponprobabilities["HWG\xe6\xa1u\x9f2\x90\xd4'\x0f\x8b\x87\x97J"] = 30; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                        switch (weaponname) {
                                                                                                                                          case #"hash_9f12123b6ecde9b3":
                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x0e{\b3\xde\xd3\xa5sp\xad\xc4\x988\xa9o\xde", "\xc5f\b\xc6\x86\x8c\x9d]\xfc\xe7\x9d\x04\v\x11\xcdN\xdek\xccE\xdf\xc7\x1f", "=\xdc\xb3\xc0*\xbb\xb0\xdcq\b\xf6t\xdf\x95\xe6#\x18", "\xab!\xfa\x1a`M\x98\xea\xe5o\xc6\xff[\x99w~\xaa\x068k\xfe\x97"];
                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7"];
                                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, ")\xbf\xbd\xad\xdb\xf9_\t\xa9\x1a", "\xdbf\x1d\xc6\x8a\x8c\x9d\xbe|\xeb\x9c\b\v\x11\xcdN", "\xd3v\xeeV,%\xe8\xdef\xbaa\x1a2\xa0\bk"];
                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [80, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                            }\
                                                                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\xd5\xcf!\xb1\x97\xbb\xb1L\xb6\xa0z | 2 c)\xb9\x05\xe3w "];
                                                                                                                                              var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "jnk\vP\x10\x1f\x9f\x04;", "\xf0%Obh\x8fQ\x86\xf3\x8a", "\xf0[\xd0\x17M[\x84D?4", "\xc3\x1fy\xf6rN\x89 \x9c\xf3P"];
                                                                                                                                              break;
                                                                                                                                              case #"hash_63a6ddf69b9373c9" :
                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9pj", "}\x10\xa1\x0e\x1e\xd2\xa6\x8d\xab\x1fO\x1e\x7f\xf8H"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "Z\xd9\x8e\x065\x83\xbf\xb3\xfd>\xca\xa9\x18\x9e\xac9\xae\xfc", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdfS\xe4d\x83\x1e\x1c\x03P\v", "fn5\xb9\x02|\x19,/\r|\v\x18\x7f\x1c\xb5", "\xc1,WgBv0{A,r\xe6\xf6H\fh\xec"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [80, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                              }\
                                                                                                                                              xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                "] = [50, "l\xb7\xb5\x83
                                                                                                                                              } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                              break;
                                                                                                                                              case #"hash_7e1d746d4a36491e" :
                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "J`\x8d\xb1\xf3\xf0\xf8 y#\xde\x9fD\xc7(\xe7\xa7", "\x9b`{\x9c\xbd\x13y\xec\xd8G\xa2\xda\x9c\x1bqr\xef/\n\x91\x9d\xd2\"", "\x91\x91\xd9\xa5\x8ah^\xd0\xb0\xb23\xa5\xc5L\xa3?\x82\xf5\x1e,\xc1\x84\xb9", "&X9\xeb\x98\xe4\xeb\x1c\x89\x1c\xd7[\xd2\xad\xca1\xd0"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "~\xed\x7f1h\x02\xa0\x92\x91\xe0\xcb\xd80\x81\xcb~5\x9c", "\xe3s\xe4\xe8\x02\xc9>[3\xfd\xd4-\xaew\x9cn\x9d8", "m\xd0M\xe2\x82\b\x9cz\xe0\xd5W\x84\xdc\xc1F\xd0"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xbeO\\1e-C\x88\x13J", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\xdd\x06", "q9eE<\xbb\x93\xec\x1a$'\xadk$\xb2O\""]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [80, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                              }\
                                                                                                                                              xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                "] = [50, "l\xb7\xb5\x83
                                                                                                                                              } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                              break;
                                                                                                                                            }

                                                                                                                                            break;
                                                                                                                                          case #"hash_ba39cac9c099d4f1":
                                                                                                                                            break;
                                                                                                                                          case #"hash_2f2d546c2247838f":
                                                                                                                                            weaponprobabilities["\xcb\x9f\xc5\xd1\xe5\xa7\x99j;V\xfd\xa2\xb3\x91g9"] = 55;
                                                                                                                                            weaponprobabilities["baa\x1dH\xe6|\xc3\xfa\x8a\xe0\x03\x9a;b"] = 45;
                                                                                                                                            weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                            switch (weaponname) {
                                                                                                                                              case #"hash_62459cc0741ed82f":
                                                                                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe5\xc6q\xcc*U\xf8\x19\x16\n", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4=", "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "\xf0\x04\x81\xc3\xe4\xf6<}4\xc4\x15\xe5\xf8\xaed\xa0", "\xf4\xab\b\x9ba\xba\x7f_\x0ef\xc9\b\xc9g&\x0e"];
                                                                                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a"];
                                                                                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xc4Vl\xe8}6k_\xe0\x81#", "s\xaf1\x98\xa0E\x11\x93]\x1ar\xcc\xcb\x0f\x9c\xa9\x1a"];
                                                                                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                }\
                                                                                                                                                xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                      var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\x01\xfc\xa3M\x99\xd4O$\x95\x9eUu\xc6*\xc0"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                      break;
                                                                                                                                                      case #"hash_c82a1fa1c794832c" :
                                                                                                                                                      var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                      }\
                                                                                                                                                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                          var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                          break;
                                                                                                                                                        }

                                                                                                                                                        break;
                                                                                                                                                        case #"hash_719417cb1de832b6":
                                                                                                                                                        weaponname = "X\xff\xae\x88\xd9\"\xbeP\x86\xad\x01\xc0^e\x9f";

                                                                                                                                                        switch (weaponname) {
                                                                                                                                                          case #"hash_f9ce3b8ea4b8701e":
                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd2!\xbf\xb6H[\xbd\xa9\xd4j", "c\xa2;\xe4\xa9\xed[\x8b\xcf\x13\x90U\rw;", "\xa4\xb5\xa4P\xb4r\x89\xeb@\xb4*vL\x8e", "\x1b\x83\xe8\xbeCCP\xd8\xb8t\x8a6Q\xe1A", "\xb4>\xf8\xbe\xab\xb9\xb0H\xbe!4mon\x1d\x90\r\xc6"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xdcG\xb7\xc6\xb6\xe6\xdb\xf5p-\xd7\x832\xa6"];
                                                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xb6,\xce\xbe\x83-\xafp\x8cj", "\x0f\xben\xf3\xf3p\xc9j\xe2\"\xf0\xfe\x93^\xe9X", "\x82\xea(\xe9\x1f\x03~\f\x85\xe9+e\x8dKI3\xeb"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x90tf\x18\xcf\x963M\x99\x19\xcf\xd4\xdb\xb4s\xd6", "\xbf\xf7\x8b\xe1}@\xc8\xa4jA\xc0\xbc:\x85\xd1j", "\xb5\x03Q\xbc\xf9\x93N\xd8{\xf0\xe4\xe6\xe4M\x14\xfb", "\xd07?\xa2X\x1e\x10\xf0\x1c?6}\xcd\x8bz\x9d"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x88Eq\xf6C\xce]\"\x87\x98T\xbc\xd2", "l\xbd\xd6\a_\x19\xca6ho\xf5\x062", "$\xb0\x10y\xc7,_'\x93yg(1", "\x1b\xb7\xb5\x83\xd7\xc8\xb2\xd8\x86\xf6}\x814", "\xbb\xc2\xd0\x10\x8bo\xe1\x9d\xe2\x85\x1f&\xf2\x18"];
                                                                                                                                                            break;
                                                                                                                                                        }

                                                                                                                                                        break;
                                                                                                                                                        case #"hash_23209741b93850b5":
                                                                                                                                                        weaponprobabilities["\x1f\x8f\xeet5a\xef\xaa\x8bB\xc6\xb3\xfeW\xa9\xfc\xde."] = 50; weaponprobabilities["Si\xbd\xf8;}D7\xbb\xf3\x81\xceO0i\xfd"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                        switch (weaponname) {
                                                                                                                                                          case #"hash_9551957c74ed1495":
                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "|U\x96-\xcd\xe7o&\xbaU", "]\v-\xa8S\xf8*\x060\xad", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                                                                                                            break;
                                                                                                                                                          case #"hash_568cc2d89894d1e4":
                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "b\x169\xa3]1+\xaf7\x86\xf5\x1c\xc4f", "\xad9t\x8e%b\vf\xaf_\xe1S\a\vl\x0f\xcf\x03eN", "\x8e\xbd\xb3LU\x93=\\J7t\x9f\x84\x11\xaf\x85\x10\x9e\xdfV", "`A\x8f\x14b\xae8\x87\xeb\xacc\x1e\x95\xb0\vuR\x1b\a\xa1"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "T\xb3\xce\xb9\xd4\x13$\x16\xce\x99\x8e\a\x1e", "\xf2\xa9\x11;8\x15DO\x93\xb8\x11V\xccb\xeb\xd27\xd1\xda", "dX\xdc2\xe3\xc5\xc524Z\x8a.\x94\x87\xabS]wP\xac\xce", "\xbe,\x9fPR\x8b\xab\xe49\x14\x1eQ\x82\xd9\xe4~.\xfb"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "|U\x96-\xcd\xe7o&\xbaU", "]\v-\xa8S\xf8*\x060\xad", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                                                                                                            break;
                                                                                                                                                        }

                                                                                                                                                        break;
                                                                                                                                                        case #"hash_900cb96c552c5e8e":
                                                                                                                                                        weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 50; weaponprobabilities["\xb4\xdd\x9c_n\xb6}\xc28,\a\xc2\xf5\xb9\x1c"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                        switch (weaponname) {
                                                                                                                                                          case #"hash_15d131b492bdb596":
                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                            break;
                                                                                                                                                          case #"hash_394fc57f759066f4":
                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xee\xf3\xcea\xe2Q?\xec\xd9\x80", "\x1d\x1c9\xab\xbf\xc7'\x19\x9a\xb7i\x81\xc8x\x7f\xbe[\x94\x03", "\x11\r\xb7\x9d\vb\x14\xf6\xc2p\x01-\x1f\xf1\xf8R", "|\x95\xf6\x16P\x15?~\xbdX\xaa\x7f\xd2\x826", "e]\x99'\xe6\xbaV=\xf1\xe4\xb1+\b=IT0\xb0", "\x89\x85r\xebn\xb6\xbe\xd0+\x85\xd9\xf2\xfa\x1c\xc09", "\xe0@\x8b\xc54+!SX \xe9l\xc7K\x19\xbb", "\xf9\xb1\xce\xd8\xf3i\xa9\xe76\xe1j\x92\xdbZ\xa7\x17l[\xab"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x81N\x1a\x1a\xc89\xb0\x9e2lX\xe8\xb7\xab}AU\x03", "\x1f\x97?g\xb3_\xb2\x1b]\xa4\xbb\xd3}\xef\xe3\xd8\xcb\x92", "`y\x05A\x12\xe3\xc1]\a\x80\xfe&", "\x03\r\xd9QE\x12T\xb5\xba\xe4\xdf$\xb4pU\xa6D{h\xc5;", "Kh{\xb3w\x84\x9c\xee\xb4XmtQ\xba"];
                                                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, " Jn\xc8\xe1j\xab\x1e\xe4/", "\xdb\xc8\xf7g\xa2\x83D\x156\xf3q,\xe5)\xa5\xa9", "\x87a\xf0\xfbfFA-f&\xcb\xe0\xcfd\xd3\xb7", "S\n\xef\xb3~\xae\x1c>\x02\x96\x95\xd7\x0e8\xe3|g"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                            break;
                                                                                                                                                          case #"hash_de5d1bd3a9f86945":
                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2D\xdb{?c\vLA\xbc\xbe\xb8\xbf='V", "\x02-\x95\xb1\x9f\xf1\x89\x9c\b\""];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xcf\x11\x1bv\xe3\xc2\xfd\xc4\xa5G\xa8\xdb", "\xd6\xaaGY\xbfW\x12b=uzs", "\nq*\\\xb8\xf42\x15\x01\x11Xk"];
                                                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x96\\\xa5P\xe8\xc1\x12\xa5\xff\xb8", "Mo\xef\\\xf7\x84_\x1f\x99~L\xcfP\x9d\xd3."];
                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                            break;
                                                                                                                                                        }

                                                                                                                                                        break;
                                                                                                                                                        case #"hash_6191aaef9f922f96":
                                                                                                                                                        weaponprobabilities["\x84\xd0\x05V\xfcn\xb7\x16cy\xab~3\xf4aU"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                        switch (weaponname) {
                                                                                                                                                          case #"hash_3fd5bba485c2aea6":
                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x98\x85\x93\xfa\xdc\xe6\xf5p\f\xc8"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "s\x1d{\xc6\xb6\xeb,9_\vss\xc2\xae\xb1t\xbe\a\x18\x19\xfa\x1c\xec\xdb\x1bf&", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88"];
                                                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdf\x7f\xc1N\b\xe2v]\x7f\\", "\xd4#\x03\xdf\x86\xc5\xb7\x96\xc0\xd02\xf4\xeey\x8c\xe2"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [100, "\x05\xaeQzJ%\xdf\xe2\xf5\xe8TO_"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [40, "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                                                            var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                            break;
                                                                                                                                                        }

                                                                                                                                                        break;
                                                                                                                                                      }

                                                                                                                                                      return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                                                    }

                                                                                                                                                    function function_d7a0967da3cd1433(type, weaponname, weaponarray) {
                                                                                                                                                      camos = getweapon_camos("A4\xf7o");
                                                                                                                                                      var_3c1147f3a07e0b51 = [];
                                                                                                                                                      attachment_combos = [];

                                                                                                                                                      switch (type) {
                                                                                                                                                        case #"hash_fa18d2f6bd57925a":
                                                                                                                                                          weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 50;
                                                                                                                                                          weaponprobabilities["c_\x92\xb1f\xf73\x9a\xf0\xf6j\x83R\x99\xb3\xf6\xd6\xbb"] = 50;
                                                                                                                                                          weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                          switch (weaponname) {
                                                                                                                                                            case #"hash_aa1268e549fd317":
                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                              }\
                                                                                                                                                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                                                                                                                              var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                                                                                                                              var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                              var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                                                              break;
                                                                                                                                                            case #"hash_1902daff8e078b20":
                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                              }\
                                                                                                                                                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                                                  n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                                                }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6", "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "\xca* \xdb\x97\x15a\x10\x86x\xcd\x0f\x06\xf9\x9e\v\xa5`\xfeP\x1c", "3\x8c\xe8\x91\x87\xba\xae\xc1X\xb4\\\xa9"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb4\xbf\x0e|\x1bu\xfb @\xea", "\x80L\b\xbd\x9f\xdd\xd6f9\x04\f\xbbZK{\\"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x81vhP\x91\xa4')+d", "\xeb\xce\xb8dlX\x81\x14\x15r#\x0e\x0ef\x8fB", "\xd2V^\xfd\xa3o!\rUm{\xd5\x02\xc28\x9c&"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xdbm\x97\x87)\x0f\xa6\x1e\n\xd2@\x19\xb3\xc3"];
                                                                                                                                                                break;
                                                                                                                                                              }

                                                                                                                                                              break;
                                                                                                                                                            case #"hash_f4b0076c03d93738":
                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                case #"hash_63a6ddf69b9373c9":
                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9pj", "}\x10\xa1\x0e\x1e\xd2\xa6\x8d\xab\x1fO\x1e\x7f\xf8H"];
                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "Z\xd9\x8e\x065\x83\xbf\xb3\xfd>\xca\xa9\x18\x9e\xac9\xae\xfc", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6"];
                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdfS\xe4d\x83\x1e\x1c\x03P\v", "fn5\xb9\x02|\x19,/\r|\v\x18\x7f\x1c\xb5", "\xc1,WgBv0{A,r\xe6\xf6H\fh\xec"];
                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                  }\
                                                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                                  "] = [50, "l\xb7\xb5\x83
                                                                                                                                                                } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                                                break;
                                                                                                                                                              }

                                                                                                                                                              break;
                                                                                                                                                            case #"hash_719417cb1de832b6":
                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                case #"hash_67577d66829ce1b5":
                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                                                                                                  break;
                                                                                                                                                              }

                                                                                                                                                              break;
                                                                                                                                                            case #"hash_900cb96c552c5e8e":
                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                case #"hash_394fc57f759066f4":
                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xee\xf3\xcea\xe2Q?\xec\xd9\x80", "\x1d\x1c9\xab\xbf\xc7'\x19\x9a\xb7i\x81\xc8x\x7f\xbe[\x94\x03", "\x11\r\xb7\x9d\vb\x14\xf6\xc2p\x01-\x1f\xf1\xf8R", "|\x95\xf6\x16P\x15?~\xbdX\xaa\x7f\xd2\x826", "e]\x99'\xe6\xbaV=\xf1\xe4\xb1+\b=IT0\xb0", "\x89\x85r\xebn\xb6\xbe\xd0+\x85\xd9\xf2\xfa\x1c\xc09", "\xe0@\x8b\xc54+!SX \xe9l\xc7K\x19\xbb", "\xf9\xb1\xce\xd8\xf3i\xa9\xe76\xe1j\x92\xdbZ\xa7\x17l[\xab"];
                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x81N\x1a\x1a\xc89\xb0\x9e2lX\xe8\xb7\xab}AU\x03", "\x1f\x97?g\xb3_\xb2\x1b]\xa4\xbb\xd3}\xef\xe3\xd8\xcb\x92", "`y\x05A\x12\xe3\xc1]\a\x80\xfe&", "\x03\r\xd9QE\x12T\xb5\xba\xe4\xdf$\xb4pU\xa6D{h\xc5;", "Kh{\xb3w\x84\x9c\xee\xb4XmtQ\xba"];
                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, " Jn\xc8\xe1j\xab\x1e\xe4/", "\xdb\xc8\xf7g\xa2\x83D\x156\xf3q,\xe5)\xa5\xa9", "\x87a\xf0\xfbfFA-f&\xcb\xe0\xcfd\xd3\xb7", "S\n\xef\xb3~\xae\x1c>\x02\x96\x95\xd7\x0e8\xe3|g"];
                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                  break;
                                                                                                                                                              }

                                                                                                                                                              break;
                                                                                                                                                          }

                                                                                                                                                          return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                                                      }

                                                                                                                                                      function function_4eb113a0d62bba80(type, weaponname, weaponarray) {
                                                                                                                                                        camos = [];
                                                                                                                                                        var_3c1147f3a07e0b51 = [];
                                                                                                                                                        attachment_combos = [];

                                                                                                                                                        switch (type) {
                                                                                                                                                          case #"hash_fa18d2f6bd57925a":
                                                                                                                                                            weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 40;
                                                                                                                                                            weaponprobabilities["q\xe5\x93\x03V\x87\x84;\xf49\xd3{\xc1T\xbc\x18\x87\x9b"] = 60;
                                                                                                                                                            weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                            switch (weaponname) {
                                                                                                                                                              case #"hash_2253efe9671d59b5":
                                                                                                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                }\
                                                                                                                                                                xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                                                      n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                                                    }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                                                    var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\x8eoT\\\xbf|_\x1d\x12uIn0\x95\xc2\xe8\xab\xb7\xdc"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0", "\xb5\xc2\xd9_X\xe4_\xc6\xce\x1dxc\xc2\xc9\xb3e_\xe0\xc0C"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "G\x87n?\x03\x1c`@\b\xb5\x7f"];
                                                                                                                                                                    break;
                                                                                                                                                                    case #"hash_15d131b492bdb596":
                                                                                                                                                                    var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [75, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                    }\
                                                                                                                                                                    xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                                                        n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                                                      }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                                                      var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [100, "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                                      break;
                                                                                                                                                                    }

                                                                                                                                                                    break;
                                                                                                                                                                    case #"hash_f4b0076c03d93738":
                                                                                                                                                                    switch (weaponname) {
                                                                                                                                                                      case #"hash_63a6ddf69b9373c9":
                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9pj", "}\x10\xa1\x0e\x1e\xd2\xa6\x8d\xab\x1fO\x1e\x7f\xf8H"];
                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "Z\xd9\x8e\x065\x83\xbf\xb3\xfd>\xca\xa9\x18\x9e\xac9\xae\xfc", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6"];
                                                                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdfS\xe4d\x83\x1e\x1c\x03P\v", "fn5\xb9\x02|\x19,/\r|\v\x18\x7f\x1c\xb5", "\xc1,WgBv0{A,r\xe6\xf6H\fh\xec"];
                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                        }\
                                                                                                                                                                        xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                                        "] = [50, "l\xb7\xb5\x83
                                                                                                                                                                      } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                                                      break;
                                                                                                                                                                    }

                                                                                                                                                                    break;
                                                                                                                                                                    case #"hash_ba39cac9c099d4f1":
                                                                                                                                                                    break;
                                                                                                                                                                    case #"hash_2f2d546c2247838f":
                                                                                                                                                                    switch (weaponname) {
                                                                                                                                                                      case #"hash_c82a1fa1c794832c":
                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"];
                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"];
                                                                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"];
                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                        }\
                                                                                                                                                                        xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                            break;
                                                                                                                                                                          }

                                                                                                                                                                          break;
                                                                                                                                                                          case #"hash_719417cb1de832b6":
                                                                                                                                                                          switch (weaponname) {
                                                                                                                                                                            case #"hash_67577d66829ce1b5":
                                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                                                                                                              break;
                                                                                                                                                                          }

                                                                                                                                                                          break;
                                                                                                                                                                          case #"hash_23209741b93850b5":
                                                                                                                                                                          switch (weaponname) {
                                                                                                                                                                            case #"hash_9551957c74ed1495":
                                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "|U\x96-\xcd\xe7o&\xbaU", "]\v-\xa8S\xf8*\x060\xad", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                                                                                                                              break;
                                                                                                                                                                          }

                                                                                                                                                                          break;
                                                                                                                                                                          case #"hash_900cb96c552c5e8e":
                                                                                                                                                                          weaponprobabilities["\x89\x12\xe9*\xf6\xdaR\xfc\x8d\x10.%CtT\x95\x8e"] = 50; weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                          switch (weaponname) {
                                                                                                                                                                            case #"hash_bb0038e8e0e9d620":
                                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf7\xf9g;\x90Q\xb89\x9e0"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xde\xe0\x90\xd7E\xd1d\xa8\xc0\f\x86\xfd\xd7\xd8^\n"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                              var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xd9\x9ci\xe0\xafXs\x9d\xc6\xb2d0M", "g9i8\xafa\xdc\xb3c+d\x066", "\xe63\xca\xfb\xc2\xd6\xb5VN\xcd\xa9\x81\xf6", "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xd1c", "?-mj]\x84\xe0\bH\xb7\xc7\x95l", "q\x8e7K3\x8b\xed\xc2#\xabY\xf8[", "\x8a\x90\xbax\xae\xdc\x05G\x88]\x8a\xb1\xbc", "\xfd\xc5F\xcb\x90\x9f\xf0_\xd2\xf5_\xb1\x88", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\xb9\r[\xd17\xb5?\xf9\xcd\xba\x10", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xce\x93i\xe0\xbevYNt\x9b\x86\xf6\xe4\x8e03", "\xbb\xa8F[\x86(\xb0\x05\xc2\x03\v\x1f\xe5V\xb4W", "r\xaa)_\xdb\xf5\xbc'v\xe8\xa9[u\xa7\xb6 "];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_294ef3868701b31a":
                                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                                                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                              break;
                                                                                                                                                                          }

                                                                                                                                                                          break;
                                                                                                                                                                          case #"hash_6191aaef9f922f96":
                                                                                                                                                                          weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                          switch (weaponname) {
                                                                                                                                                                            case #"hash_4fd524ce5cfa34e4":
                                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                                                                                                                                              break;
                                                                                                                                                                          }

                                                                                                                                                                          break;
                                                                                                                                                                        }

                                                                                                                                                                        return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                                                                    }

                                                                                                                                                                    function function_c96fe324b16a84a1(type, weaponname, weaponarray) {
                                                                                                                                                                      camos = getweapon_camos("dT\xdd");
                                                                                                                                                                      var_3c1147f3a07e0b51 = [];
                                                                                                                                                                      attachment_combos = [];

                                                                                                                                                                      switch (type) {
                                                                                                                                                                        case #"hash_fa18d2f6bd57925a":
                                                                                                                                                                          weaponprobabilities["\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'"] = 40;
                                                                                                                                                                          weaponprobabilities["c_\x92\xb1f\xf73\x9a\xf0\xf6j\x83R\x99\xb3\xf6\xd6\xbb"] = 60;
                                                                                                                                                                          weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                          switch (weaponname) {
                                                                                                                                                                            case #"hash_aa1268e549fd317":
                                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                              }\
                                                                                                                                                                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "Sp\x9e\xdb\xc4\xb3\x95v\xf5?\xc0\x8a", "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7", "\x03\xdb\xa4])\xc6\xcd\x9d)8?W\xb3\xb2"];
                                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\xb4}\x96\xa4?M\x047,?UK\x1f\a\x1e\xfc\xab\f,", "1\xb0N\xf5a9\xaf6-\xd9ht\xbe\x1c\x18\x89", "\x9a2\x93\x88]\xb2%\xdd0\x8c\xcd+V\xa2\x17l"];
                                                                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"];
                                                                                                                                                                              var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                                              var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"];
                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_1902daff8e078b20":
                                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                              }\
                                                                                                                                                                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                                                                  n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                                                                }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [80, "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6", "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "\xca* \xdb\x97\x15a\x10\x86x\xcd\x0f\x06\xf9\x9e\v\xa5`\xfeP\x1c", "3\x8c\xe8\x91\x87\xba\xae\xc1X\xb4\\\xa9"]; var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb4\xbf\x0e|\x1bu\xfb @\xea", "\x80L\b\xbd\x9f\xdd\xd6f9\x04\f\xbbZK{\\"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x81vhP\x91\xa4')+d", "\xeb\xce\xb8dlX\x81\x14\x15r#\x0e\x0ef\x8fB", "\xd2V^\xfd\xa3o!\rUm{\xd5\x02\xc28\x9c&"]; var_3c1147f3a07e0b51["VwXl+"] = [70, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [65, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [50, "\xdbm\x97\x87)\x0f\xa6\x1e\n\xd2@\x19\xb3\xc3"];
                                                                                                                                                                                break;
                                                                                                                                                                              }

                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_f4b0076c03d93738":
                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                case #"hash_63a6ddf69b9373c9":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9pj", "}\x10\xa1\x0e\x1e\xd2\xa6\x8d\xab\x1fO\x1e\x7f\xf8H"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe,\x9fPR\x8b\xabe9\x13H\xc5", "Z\xd9\x8e\x065\x83\xbf\xb3\xfd>\xca\xa9\x18\x9e\xac9\xae\xfc", "\x80\xa8\xcc/ \xdeT\x10\xd0:\x85\xf1\n\xed0\x05\x98i", "n:\xbd\x1b\xad\xf5ar\xd7\x83\xc0\xa6"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdfS\xe4d\x83\x1e\x1c\x03P\v", "fn5\xb9\x02|\x19,/\r|\v\x18\x7f\x1c\xb5", "\xc1,WgBv0{A,r\xe6\xf6H\fh\xec"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                  }\
                                                                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                                                  "] = [50, "l\xb7\xb5\x83
                                                                                                                                                                                } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                                                                break;
                                                                                                                                                                              }

                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_ba39cac9c099d4f1":
                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_2f2d546c2247838f":
                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                case #"hash_9e82f4346600ccc5":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd(\xf7?\xaa\xef_?;\xd6", "\xf0\x04\x81\xc3%\x0e<}\xb5@\xf4\xbc\x1d\x8et", "N\x82\x04\xb6\xa2'\x1e!\xab\xef\xa2a-\x86\xe8\xa0"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xeb\xbe\xa4\xc2\x9b\xce\xf3\xc4GT\x96", "\xcd\xf7\xde\x11\x14B\x14\xb7L&\xc0\x10#XZx\xe9"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                  }\
                                                                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "BQq\xa2o\x8ao\x19", "\x9d\xabQo?W\xe1V"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                                                  break;
                                                                                                                                                                              }

                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_719417cb1de832b6":
                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                case #"hash_67577d66829ce1b5":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xd8S(\xd9\xf6\xef\x93\x83 \x1e", "b\xb0r\xaf8i\xbe6{sg\xebp\x8c\xcd", "\x02 \xe3R\xb9\x84q\xcfUF\xf8Z\x93\a\xf4A", "#\xbc\xf4\x1f{l\x81\x9a\xf9\x01\xb9{\x8f\xf5&\x89"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\xc2v\xeb8\xd2_p\x8c\xcd", "\xedY\x1f\fI\xd8^K\x9b\xb2\x8cGW\x8f\xe7W"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80", "/\"H\xb3u9\x0eP\x95{\x1a#\xfb\x81C\x13\xf8!\x9dHa", " ss\xe7\x86Bg\x83\xe87@\x04\xf9s\xb3\xa8\v\xa0\\\xed\xf0", "=\xfbz\xc1\xd1\v\xd4\xde\xd8\x1cK\\\x13k\xa5\xd9\v\xc2\xbeQV"];
                                                                                                                                                                                  break;
                                                                                                                                                                              }

                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_23209741b93850b5":
                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                case #"hash_9551957c74ed1495":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xf2m\xd7?\xaa\xe9\x86\xbd\xf8\x8en\x8b8WY\xa6", "9\xa0\xf7\xfd\xa2v\x9d,\xfe\xef}\x1cM\xa8\xa5\xe2", "D\x1f\xd5\xc6\xdbU\xdfh\xb3\xd1\x8c\xfb@/\xbf@\xa7\xe1\x1c\xdc", "\xc9q\x14\x1b\x8bE\xf8\xe5\xdf0Y\x1f%\\", "\xe3\xcau%JK\x15\x84\xb1\xde\x16\x932g\xf9g"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "eu\xa7\x01\x9e\xdbG\x9d\xd9Fo\xc7X\xeemh\xf9M", "\x7f@jw\x1d\x9c\x14\xdd\x1b\xf4R\xb4\xd3l", "\xdcG\xf6cm9\xeb\xcd\xa1\xbe\re\x16\xb3^\xaf\x1cL\x91", "\xba\xc9#\xd4\xff&;@\xa2%\x96\xcd"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\xc6{\xad\x83\xf5\xb9C\xf5\x03L", "|U\x96-\xcd\xe7o&\xbaU", "]\v-\xa8S\xf8*\x060\xad", "\xe7\x02\x05`\xcb\xf1\x1bN\xac\xe3<"];
                                                                                                                                                                                  break;
                                                                                                                                                                              }

                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_900cb96c552c5e8e":
                                                                                                                                                                              weaponprobabilities["\xec\xf7w\xb9\xef5zH\xa8\"\"\xc5K|\x06t"] = 50;
                                                                                                                                                                              weaponprobabilities["\xb4\xdd\x9c_n\xb6}\xc28,\a\xc2\xf5\xb9\x1c"] = 50;
                                                                                                                                                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                case #"hash_252ac91b23d22c17":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "_\x12\a\xb1\xc0F\xd1\xc3\xab\x1e", "\x0fmTdI\x0eS\xf1H\x16\xbd#3\x88\xfeU"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xf5.@\x84\xf61\x84\xad,\xb2\xf1\xd1\x11\x83:\xed\xecv", "}\x8dY\x86\xa6M\xf9ud\xc2V\xc2\v\x9aF|\xea8\x16)/", "\xf7\xccl\xd2\x81f\x99\x86\x99\xb4]\x80", ")\x86\xc9?\xcd\xb2\xc1?\\\xcf:\xd7\xb8N", "\xabA\xbd+\x14\xb4]\xeb\xdb\x8a\xf9w\x1d\xa1V\x9bZ\xc0\xf6", ")\xb4\xc5/\xcam\xef\xe5\x9bHl#\t\xce\xdc^\xd2jt\xb3d~Y\xe5\xb4", "\xbb[n\x9fp\xc8\xbat\x97qU\xd2\x1a\xbb\xb6\x10n^$\x92\xddSK\xe14t\xf0\xa8"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x01\x9b\x87\x97\xeb:I5M*", "\xc0\xc6\xc6\xe4j~S\x87\xeb\x01\xd4"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [90, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                                  break;
                                                                                                                                                                                case #"hash_de5d1bd3a9f86945":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2D\xdb{?c\vLA\xbc\xbe\xb8\xbf='V", "\x02-\x95\xb1\x9f\xf1\x89\x9c\b\""];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xcf\x11\x1bv\xe3\xc2\xfd\xc4\xa5G\xa8\xdb", "\xd6\xaaGY\xbfW\x12b=uzs", "\nq*\\\xb8\xf42\x15\x01\x11Xk"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x96\\\xa5P\xe8\xc1\x12\xa5\xff\xb8", "Mo\xef\\\xf7\x84_\x1f\x99~L\xcfP\x9d\xd3."];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                                  break;
                                                                                                                                                                              }

                                                                                                                                                                              break;
                                                                                                                                                                            case #"hash_6191aaef9f922f96":
                                                                                                                                                                              weaponprobabilities["\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0"] = 100;
                                                                                                                                                                              weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                case #"hash_4fd524ce5cfa34e4":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x94?\xd9)r\\\xdb\xd9q\xea", "\xc5f\b\xc6\xce\x8b\x9d]<\xf5^\x91\xf9\x95\xed", "\b|\x9f\xce,\x83O$\x89rtUE6\xef\f\x8c\xd2"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xb7~x<<.\xa7\x15\xbc\x1f^\xeb", "uU\xbdrE#\n69HE\xfa\xf5\x0f\xa2\xff\xfc'", "\xf4\a#;\x18\xa10u\x17h8\x85\x1a\xaeX\xf1y3", "\xbe,\x9fPR\x8b\xabe9\x12\x1cP\x85\x9e\xeb:y\xe0\xd9\x04\xc5"];
                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdd=\x8c\x84\xb8\xdd\xef^\xc5\xda", "\xc1,WgBv0\xfe\xc1,\xb1\xbe'\xad\x88\xe8", "\x10\x8a\xcf\x1f\\\x18z+\xa9\xbb>\x99\xa0.\x1d\x14"];
                                                                                                                                                                                  break;
                                                                                                                                                                              }

                                                                                                                                                                              break;
                                                                                                                                                                          }

                                                                                                                                                                          return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                                                                      }

                                                                                                                                                                      function function_864a7b254c5ce41f(type, weaponname, weaponarray) {
                                                                                                                                                                        camos = getweapon_camos("Q\xa3");
                                                                                                                                                                        var_3c1147f3a07e0b51 = [];
                                                                                                                                                                        attachment_combos = [];

                                                                                                                                                                        switch (type) {
                                                                                                                                                                          case #"hash_fa18d2f6bd57925a":
                                                                                                                                                                            weaponprobabilities["F\xf6\xd0^\x1dJ\x04\x80\x1a\xcd\xce\xef@vP"] = 50;
                                                                                                                                                                            weaponprobabilities["\xf8s\x8aO.\xfa\xd7~\b\xad\xd3\xf0\x19\x11`\xac"] = 50;
                                                                                                                                                                            weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                            switch (weaponname) {
                                                                                                                                                                              case #"hash_a89739756fa439cf":
                                                                                                                                                                                var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "}\x98u\xa1>\xa7,\xe5Xj*\xe3\x19\xa6K\x05\x1eQ\xbf\xbe\xae\xf3<\xcf", "\xdc:\xcf\xb7\xf0W\xfe\xb1\x8cL\x1f~Z\xfe\x1b", "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\xc2\xfc\xd5\xb0\xfcze\x16\xb6\xc1\xae\xb8\x8a\x1anG\xa0\xcf*s@\f`b\xc1"];
                                                                                                                                                                                var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ"];
                                                                                                                                                                                var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xba\x9e\x83w\x9f0[v|\xd2", "u\xfd\x10\x8d\xc1\xbc\x8a|\x1c\x1b\x98\r\x02\xbch`", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM"];
                                                                                                                                                                                var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                }\
                                                                                                                                                                                xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                                                                    n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                                                                  }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "G\x87n?\x03\x1c`@\b\xb5\x7f"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"]; var_3c1147f3a07e0b51["\xc1\x94\v\xb7\\"] = [50, "\xc3x\xf1\xe9\xc8\x7fl\xf2\xa7\xad8"];
                                                                                                                                                                                  break;
                                                                                                                                                                                  case #"hash_aa74a17ec13f0a08":
                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [100, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\x16z\x01\xd0\xfc\xff-S\xda\x9b"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x90@T\x19`\xa0\xc0\xf7D\xeb", "\x9c~t\x1c\xb0TLa0\xe2\xec\xd1\x1ct9:", "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                  }\
                                                                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x94\x03\x03~\xf4\x19*", "]\xc4\xeb\xce\xc601\xf5\a\x18\x98", "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                                                  break;
                                                                                                                                                                                }

                                                                                                                                                                                break;
                                                                                                                                                                              case #"hash_f4b0076c03d93738":
                                                                                                                                                                                weaponprobabilities["X\xff\xae\x88\xfbA\xbe`\x83\x919\xee^e\x9f"] = 50;
                                                                                                                                                                                weaponprobabilities["\x96\xee\xe4\xaf1'\xf5n\xdbn\x1b,\xc9\x13h\xd7\xe6\x0e"] = 25;
                                                                                                                                                                                weaponprobabilities["\xea-3\xe4\xa9=\xd1\x87w\xbf\x9f\x87I\xad\xf6\xb1"] = 25;
                                                                                                                                                                                weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                switch (weaponname) {
                                                                                                                                                                                  case #"hash_127d6ae747a36c62":
                                                                                                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4="];
                                                                                                                                                                                    var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU"];
                                                                                                                                                                                    var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xce\xf5bN_\x1c\x182", ",\x9d\xb7\xbd\xd6\xfa\xec\x98n!`b\x80\x12\x8eb"];
                                                                                                                                                                                    var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                    }\
                                                                                                                                                                                    xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                                                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                          break;
                                                                                                                                                                                          case #"hash_45c546e6f731646e" :
                                                                                                                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xcd;\xd9F\xc8\xd0\xa2\xb7\x97o\xaaP\xc5\xb9?L\xc5\x9bQ", "1\x85\x93\xbe\xc8\xd6\xfa\x1a\x95\x85\xce\x97_\xe0\x13\x83_s\xdesl,\x93L4", "\xdd\xe3\xee0\x1d\xbbyO\a.\xa9\xdc\xb0\xf6\"\xfc\xb9s\x86", "b\xc2\x9c_\x98'\xaf\x1aea\xec\x97\xaf\x83\x98\x0e\xfa\xcd\xdb\x9b6\xc2\x93bh"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "c\b\xbc\f\x95\xb1\feQ(,\xd5\xb4y\xe4`\xe1\xf9\xb1uU\xaa\fo~YK", "\x92D\xafH\xe7\xb3\x19<\xbd>\xb8\x7f\x80}F\xb9$\x11\xa5\xc6\xa5\v"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "c\xa1\xafC\xcb\x94!\xf4\x1c\xd7\xd9", "\nn\x1f\xc5k|\xe5\x8f'n\x8f\xddw\xf5\x87\xe4", "\xfcZ\xd0\\\x17\x8e\xa7'\xa8\x96\x9av+K\xf3\xe5/\x9c\x17"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                          }\
                                                                                                                                                                                          xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                                                            "] = [50, "l\xb7\xb5\x83
                                                                                                                                                                                          } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                                                                          break;
                                                                                                                                                                                          case #"hash_de04cb31d20ef327" :
                                                                                                                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xcfwr\x06P\xd6\xe8$m\x96\xcdUu\xaa\xf6\xb2\x88"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "`P\x86w\x91\xed\xc3\x95\xdd\xc3\xbd+m", "p]\xd4\x81G+\xa1\xe2\xdb\xcf\x13f\xa6\xdc\x13\x8b\xe8v\x81", "H\xceg\x9d\xc5\xdbH\x96u\xcfs\x86\xa1QY6\xe2\x1b\xe4\xfa\x89X"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xb3\xfa#m}\xc1\x19\x03", "\x06[\x9a\xea\xf4\x1a\x9c\xde\xbdr\xb8\xe0k\xeb\x10Q"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                          }\
                                                                                                                                                                                          xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                                                            "] = [50, "l\xb7\xb5\x83
                                                                                                                                                                                          } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                                                                          break;
                                                                                                                                                                                        }

                                                                                                                                                                                        break;
                                                                                                                                                                                        case #"hash_ba39cac9c099d4f1":
                                                                                                                                                                                        break;
                                                                                                                                                                                        case #"hash_2f2d546c2247838f":
                                                                                                                                                                                        weaponprobabilities["\xcb\x9f\xc5\xd1\xe5\xa7\x99j;V\xfd\xa2\xb3\x91g9"] = 55; weaponprobabilities["baa\x1dH\xe6|\xc3\xfa\x8a\xe0\x03\x9a;b"] = 45; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                        switch (weaponname) {
                                                                                                                                                                                          case #"hash_62459cc0741ed82f":
                                                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe5\xc6q\xcc*U\xf8\x19\x16\n", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4=", "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "\xf0\x04\x81\xc3\xe4\xf6<}4\xc4\x15\xe5\xf8\xaed\xa0", "\xf4\xab\b\x9ba\xba\x7f_\x0ef\xc9\b\xc9g&\x0e"];
                                                                                                                                                                                            var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a"];
                                                                                                                                                                                            var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xc4Vl\xe8}6k_\xe0\x81#", "s\xaf1\x98\xa0E\x11\x93]\x1ar\xcc\xcb\x0f\x9c\xa9\x1a"];
                                                                                                                                                                                            var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                            }\
                                                                                                                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\x01\xfc\xa3M\x99\xd4O$\x95\x9eUu\xc6*\xc0"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                  break;
                                                                                                                                                                                                  case #"hash_c82a1fa1c794832c" :
                                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                  }\
                                                                                                                                                                                                  xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                                                                      var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                      break;
                                                                                                                                                                                                    }

                                                                                                                                                                                                    break;
                                                                                                                                                                                                    case #"hash_719417cb1de832b6":
                                                                                                                                                                                                    weaponname = "\xef\x99m\xfe\x86\x14\x7fn\xe6\xce\xe8.d\x02\xdc\xf2";

                                                                                                                                                                                                    switch (weaponname) {
                                                                                                                                                                                                      case #"hash_7e15428d3b55ef10":
                                                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xc6\xe0\xb0\x7fZ\x8ds\xc3J\x8b\x9f1\xaf\xce8\xbf", "\xf7\xf9g;\x90Q\xb89\x9c0"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8a\x0e\x90gr_\xba\xefu:`\xc8SC"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "3[\t_L2;\xac\xe2\xf3", "m\xc2;\xaf\xc1Z\xbe\x8d\xb0\xc9\xb3+\xbe\x83#C"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80"];
                                                                                                                                                                                                        break;
                                                                                                                                                                                                    }

                                                                                                                                                                                                    break;
                                                                                                                                                                                                    case #"hash_23209741b93850b5":
                                                                                                                                                                                                    weaponprobabilities["Si\xbd\xf8;}D7\xbb\xf3\x81\xceO0i\xfd"] = 50; weaponprobabilities["o\xff\xe4~\xb7\x01aq\x9e'By\x92\x05\xc7%\xbc\xf8\xb7\xa9"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                    switch (weaponname) {
                                                                                                                                                                                                      case #"hash_568cc2d89894d1e4":
                                                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "b\x169\xa3]1+\xaf7\x86\xf5\x1c\xc4f", "\xad9t\x8e%b\vf\xaf_\xe1S\a\vl\x0f\xcf\x03eN", "\x8e\xbd\xb3LU\x93=\\J7t\x9f\x84\x11\xaf\x85\x10\x9e\xdfV", "`A\x8f\x14b\xae8\x87\xeb\xacc\x1e\x95\xb0\vuR\x1b\a\xa1"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "T\xb3\xce\xb9\xd4\x13$\x16\xce\x99\x8e\a\x1e", "\xf2\xa9\x11;8\x15DO\x93\xb8\x11V\xccb\xeb\xd27\xd1\xda", "dX\xdc2\xe3\xc5\xc524Z\x8a.\x94\x87\xabS]wP\xac\xce", "\xbe,\x9fPR\x8b\xab\xe49\x14\x1eQ\x82\xd9\xe4~.\xfb", "\xd6\x93\xde\xd8E`\xa2@\x06 z\x90g\xa9", "\x1fPx\x15\xfa\xc5G\xa0\xb8\xffSjP<\xa8\x11[@\xb7\x18"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "p\xad\x9a[\x1b\xa9\xca\xb8\xf9", " o\xec\xeas\x8e\x1a\xbf\xfdX>\b\xdd\xce\xc2\x02\xd1\xf7", "\t\xe9\x8ecRU\xe9A\xe8\x96\xa4\xe6\xee\xce\xe8", "\x11\xe5d\xb3\xaacE\x8e\x89K\xf5G\xb1L\xd6"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "]\v-\xa8S\xf8*\x060\xad"];
                                                                                                                                                                                                        break;
                                                                                                                                                                                                      case #"hash_81f38f52e4aaecf5":
                                                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x17\xd2\x10\x18\xc2\x84W\xa7\xc2{", "s\x97\x01?\xe9\x1d\\\\0\x9cU\xfd\xbf\x19\xd2\xeb", "\x9a\xc7\x12\a3\te\x1c\x1b\xec;k{\x97D"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe0\x88\x85\xb6\xb2\x1b*r\x80^o\x90", "\xf7\xccl\xd2\x81\xc3\xb5EE\xeaL\x15\x90\x96\xbd\xbb\xdb\x804\x9d\xc8T", "\nty9<|\x19c\xf6_\x94\"\x13\xb7\xfa\x84wP\x14", "\\b\xc0\x17\xbb\\P-SA\xb2\x8e\xcf+"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\xc0]\xa0.\xf8O.W\xfc", "v\xab\v\x9c2\xeb\x86+X\xcey\xbe8&\xd0", "Op@\x921O\xac\x1f]M\rt\xb93\x1a", "\x8c\xf8f\x0e\xdf\x04Q\xd77\rU\x06\x9e\xe8\xe0\xfb\x969"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                        break;
                                                                                                                                                                                                    }

                                                                                                                                                                                                    break;
                                                                                                                                                                                                    case #"hash_900cb96c552c5e8e":
                                                                                                                                                                                                    weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 40; weaponprobabilities["\xda\xee\xf5\xe6\xbc\xf0|*\xcb\x89!\x05B\xcb\xbcC"] = 30; weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 30; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                    switch (weaponname) {
                                                                                                                                                                                                      case #"hash_15d131b492bdb596":
                                                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                                                                        break;
                                                                                                                                                                                                      case #"hash_175809755197c4da":
                                                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xfe\xa7\xe1\xc7\xd4\xb2\xec\x83\x87*", "\x98\xc2\x93\xebnk\xd7l\xb7\xdcg\xbe8\f2", "\xf7\xc7Np\n\xb6\xd8\xad\xb6\xd0\x8e\x06PBn|", ">\xf6M\x83\x0e(@\xf9sg#\xa0\xce\x83\x84."];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xe4|!.\xf6\x99\x84J\xf3\xf3r\xaeb*\xee\x1c\xa6\xc3\xad", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "B\x87\xa6q\xdd\x13\x84\x06\x14\xd1", "\xe82\xf5\x98k\xfd\x8c\x99\x1f\xd2?\x02\x8e@\x01V", "\x83),\xc0\xab\xab\xa5\xdf\xb8\x9f&\xb4\n\xf8\xb6\xf0", "\x13\x99\x123Y\xe8\vw\xbc\\\xb8"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x83\x18\xc7R\xe8\x81?\xfcG\xe7\xc0\xbe\xaa\xae\x1d\x9c\xf8\xda"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["VwXl+"] = [50, "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                                                        break;
                                                                                                                                                                                                      case #"hash_294ef3868701b31a":
                                                                                                                                                                                                        var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                                        var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                                                        break;
                                                                                                                                                                                                    }

                                                                                                                                                                                                    break;
                                                                                                                                                                                                    case #"hash_6191aaef9f922f96":
                                                                                                                                                                                                    weaponprobabilities["\x84\xd0\x05V\xfcn\xb7\x16cy\xab~3\xf4aU"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                    switch (weaponname) {
                                                                                                                                                                                                      case #"hash_3fd5bba485c2aea6":
                                                                                                                                                                                                        if(getDvar(@ "g_mapname") == "\xa7\xea`\xcbg\x80") {
                                                                                                                                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x98\x85\x93\xfa\xdc\xe6\xf5p\f\xc8"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "s\x1d{\xc6\xb6\xeb,9_\vss\xc2\xae\xb1t\xbe\a\x18\x19\xfa\x1c\xec\xdb\x1bf&", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdf\x7f\xc1N\b\xe2v]\x7f\\", "\xd4#\x03\xdf\x86\xc5\xb7\x96\xc0\xd02\xf4\xeey\x8c\xe2"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [100, "i\xd3a\xb3\x9e\x9f\xceFH\b~\xeb"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [40, "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                        } else {
                                                                                                                                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x98\x85\x93\xfa\xdc\xe6\xf5p\f\xc8"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "s\x1d{\xc6\xb6\xeb,9_\vss\xc2\xae\xb1t\xbe\a\x18\x19\xfa\x1c\xec\xdb\x1bf&", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdf\x7f\xc1N\b\xe2v]\x7f\\", "\xd4#\x03\xdf\x86\xc5\xb7\x96\xc0\xd02\xf4\xeey\x8c\xe2"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [100, "2\x11\xa3\xd5Z\xe0\x99V\xb5\xce\x19z\x01\x17u"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [40, "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                        }

                                                                                                                                                                                                        break;
                                                                                                                                                                                                    }

                                                                                                                                                                                                    break;
                                                                                                                                                                                                  }

                                                                                                                                                                                                  return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                                                                                                }

                                                                                                                                                                                                function function_1aed348fc628ee06(type, weaponname, weaponarray) {
                                                                                                                                                                                                  camos = [];
                                                                                                                                                                                                  var_3c1147f3a07e0b51 = [];
                                                                                                                                                                                                  attachment_combos = [];

                                                                                                                                                                                                  switch (type) {
                                                                                                                                                                                                    case #"hash_fa18d2f6bd57925a":
                                                                                                                                                                                                      weaponprobabilities["F\xf6\xd0^\x1dJ\x04\x80\x1a\xcd\xce\xef@vP"] = 50;
                                                                                                                                                                                                      weaponprobabilities["\xf8s\x8aO.\xfa\xd7~\b\xad\xd3\xf0\x19\x11`\xac"] = 50;
                                                                                                                                                                                                      weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                      switch (weaponname) {
                                                                                                                                                                                                        case #"hash_a89739756fa439cf":
                                                                                                                                                                                                          var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "}\x98u\xa1>\xa7,\xe5Xj*\xe3\x19\xa6K\x05\x1eQ\xbf\xbe\xae\xf3<\xcf", "\xdc:\xcf\xb7\xf0W\xfe\xb1\x8cL\x1f~Z\xfe\x1b", "\xe1h\x85\xfb\v\xda%\xb3\x98\xf5Grv\n\xaaC", "\xc2\xfc\xd5\xb0\xfcze\x16\xb6\xc1\xae\xb8\x8a\x1anG\xa0\xcf*s@\f`b\xc1"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xba\x9e\x83w\x9f0[v|\xd2", "u\xfd\x10\x8d\xc1\xbc\x8a|\x1c\x1b\x98\r\x02\xbch`", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM"];
                                                                                                                                                                                                          var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                          }\
                                                                                                                                                                                                          xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\x15\x85\xec\x92 {
                                                                                                                                                                                                              n\x96\x1b\xf2 - \a\xa5\x05 ", "\xc1_\x8a &\xf0K\xf3I2t\xd8\xc4\xa7 ", "\xe4e3\x8d\x95\xf0\xc03
                                                                                                                                                                                                            }: \vc\xc6 ", "\x8an\x04: \xaf, 03\x86x\xcd\xee6 "];
                                                                                                                                                                                                            var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "G\x87n?\x03\x1c`@\b\xb5\x7f"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"]; var_3c1147f3a07e0b51["\xc1\x94\v\xb7\\"] = [50, "\xc3x\xf1\xe9\xc8\x7fl\xf2\xa7\xad8"];
                                                                                                                                                                                                            break;
                                                                                                                                                                                                            case #"hash_aa74a17ec13f0a08":
                                                                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [100, "\x10\x1b\x1f\xb6V\x13$\x9b\xfa\x16\x8d#\xc6:)\x80", "\x16z\x01\xd0\xfc\xff-S\xda\x9b"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "5\x14\xe8;\xe4\x14fF\xf2v\xd2b\xb3\t\xed)\x850]\xa7", "\x8b\x89\xc1&\xfaXf\xc5\x7f\xb3\xe7u", "\xf0\xf6A\xfe:\x1e\x8fvk\xbbQ\xb8\xaf\xf8\xabco]\x86\xeb\x9d", "J\xd6=Q\xf9\xce\xa2\xc6\xfcc\xa3\xb7\x96\x02\xc2h\xa1\xef", "A\xa1\x05\xf0r\xa4%MS\x83\x01\xc7"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x90@T\x19`\xa0\xc0\xf7D\xeb", "\x9c~t\x1c\xb0TLa0\xe2\xec\xd1\x1ct9:", "\xad\x85\xb3\xbeXN}\xc6\xc29g\x95_p\x18&", "\x85+\xd09w\xce\x16\x83\xca9&\xb7o\xb9\xb1PA"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "`\n\x0e\xb0\xce\xd7H\xdd\x1d\xc0\xbc\x801h7\xb2\xd3\x11\xf0\xa8\xc4g\xe8\x1f\x7f", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                            }\
                                                                                                                                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "\x90\x83\"&\x96:\xa4\"\xbdN", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"]; var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x94\x03\x03~\xf4\x19*", "]\xc4\xeb\xce\xc601\xf5\a\x18\x98", "\xa2\\\xeb\x88\t\xdf*$\x1f\xc6\xd6\x87{"]; var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                                                                            break;
                                                                                                                                                                                                          }

                                                                                                                                                                                                          break;
                                                                                                                                                                                                        case #"hash_f4b0076c03d93738":
                                                                                                                                                                                                          weaponprobabilities["X\xff\xae\x88\xfbA\xbe`\x83\x919\xee^e\x9f"] = 50;
                                                                                                                                                                                                          weaponprobabilities["\x96\xee\xe4\xaf1'\xf5n\xdbn\x1b,\xc9\x13h\xd7\xe6\x0e"] = 25;
                                                                                                                                                                                                          weaponprobabilities["\xea-3\xe4\xa9=\xd1\x87w\xbf\x9f\x87I\xad\xf6\xb1"] = 25;
                                                                                                                                                                                                          weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                          switch (weaponname) {
                                                                                                                                                                                                            case #"hash_127d6ae747a36c62":
                                                                                                                                                                                                              var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4="];
                                                                                                                                                                                                              var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU"];
                                                                                                                                                                                                              var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xce\xf5bN_\x1c\x182", ",\x9d\xb7\xbd\xd6\xfa\xec\x98n!`b\x80\x12\x8eb"];
                                                                                                                                                                                                              var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                              }\
                                                                                                                                                                                                              xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                                    break;
                                                                                                                                                                                                                    case #"hash_45c546e6f731646e" :
                                                                                                                                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xcd;\xd9F\xc8\xd0\xa2\xb7\x97o\xaaP\xc5\xb9?L\xc5\x9bQ", "1\x85\x93\xbe\xc8\xd6\xfa\x1a\x95\x85\xce\x97_\xe0\x13\x83_s\xdesl,\x93L4", "\xdd\xe3\xee0\x1d\xbbyO\a.\xa9\xdc\xb0\xf6\"\xfc\xb9s\x86", "b\xc2\x9c_\x98'\xaf\x1aea\xec\x97\xaf\x83\x98\x0e\xfa\xcd\xdb\x9b6\xc2\x93bh"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "c\b\xbc\f\x95\xb1\feQ(,\xd5\xb4y\xe4`\xe1\xf9\xb1uU\xaa\fo~YK", "\x92D\xafH\xe7\xb3\x19<\xbd>\xb8\x7f\x80}F\xb9$\x11\xa5\xc6\xa5\v"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "c\xa1\xafC\xcb\x94!\xf4\x1c\xd7\xd9", "\nn\x1f\xc5k|\xe5\x8f'n\x8f\xddw\xf5\x87\xe4", "\xfcZ\xd0\\\x17\x8e\xa7'\xa8\x96\x9av+K\xf3\xe5/\x9c\x17"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                                    }\
                                                                                                                                                                                                                    xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                                                                                      "] = [50, "l\xb7\xb5\x83
                                                                                                                                                                                                                    } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                                                                                                    break;
                                                                                                                                                                                                                    case #"hash_de04cb31d20ef327" :
                                                                                                                                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xcfwr\x06P\xd6\xe8$m\x96\xcdUu\xaa\xf6\xb2\x88"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "`P\x86w\x91\xed\xc3\x95\xdd\xc3\xbd+m", "p]\xd4\x81G+\xa1\xe2\xdb\xcf\x13f\xa6\xdc\x13\x8b\xe8v\x81", "H\xceg\x9d\xc5\xdbH\x96u\xcfs\x86\xa1QY6\xe2\x1b\xe4\xfa\x89X"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "[\x16\xb3\xfa#m}\xc1\x19\x03", "\x06[\x9a\xea\xf4\x1a\x9c\xde\xbdr\xb8\xe0k\xeb\x10Q"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [70, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                                    }\
                                                                                                                                                                                                                    xeaZ\b\x8b\xd8 ", "\x86\x0e[\xfc\x8a) 4 ", "\x16\x13\x93\xca\x1e\xdc\xf1 ", ": \xd8\xdc6\x94\xcf\xa4\x12c\xf4\x8a$ ", "x\xcaG\xa6\x8f @\xc6v\a\x96\xba + ", ")\x127\xe6\x18\xcb\xb8\x03 % \xd5\xa2: ", "\xec\xf3\x17E\xef\x94\n = 1!\xaf\x05 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x9d\xabQo ? W\xe1V ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "\x16N\xdcc\xbd\x83\x95`#", "\x94\xe8\x15\xe7^\xe4\x1b\xe1\x97", "\xb3l\x7f^\x93\x87ig\x03\x16\x99\xc6"];
var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`
                                                                                                                                                                                                                      "] = [50, "l\xb7\xb5\x83
                                                                                                                                                                                                                    } &r_\f\x89 ", "\xebb\xd9\x824\xe3\\\xf3\xfca ", "\x9b8\xc3\xe0 | \x8b * \xac\xc2\xe2 ", "4\xbd\xdei\xf9\xcc\xf5\x06UlA "];
                                                                                                                                                                                                                    break;
                                                                                                                                                                                                                  }

                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                  case #"hash_ba39cac9c099d4f1":
                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                  case #"hash_2f2d546c2247838f":
                                                                                                                                                                                                                  weaponprobabilities["\xcb\x9f\xc5\xd1\xe5\xa7\x99j;V\xfd\xa2\xb3\x91g9"] = 55; weaponprobabilities["baa\x1dH\xe6|\xc3\xfa\x8a\xe0\x03\x9a;b"] = 45; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                                  switch (weaponname) {
                                                                                                                                                                                                                    case #"hash_62459cc0741ed82f":
                                                                                                                                                                                                                      var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe5\xc6q\xcc*U\xf8\x19\x16\n", "l~\xd6\x1c`jL\x1d \xde\xe7\xe2\xd7\xf4=", "\xdd\xd0\xac\xe0 a\xdfQ\xd1\x05", "\xf0\x04\x81\xc3\xe4\xf6<}4\xc4\x15\xe5\xf8\xaed\xa0", "\xf4\xab\b\x9ba\xba\x7f_\x0ef\xc9\b\xc9g&\x0e"];
                                                                                                                                                                                                                      var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x89\x89p\xfc>IX?p\xa9t\xb3\xdb\x15\xf6\xec\x85\xceXU", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a"];
                                                                                                                                                                                                                      var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xc4Vl\xe8}6k_\xe0\x81#", "s\xaf1\x98\xa0E\x11\x93]\x1ar\xcc\xcb\x0f\x9c\xa9\x1a"];
                                                                                                                                                                                                                      var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                                      }\
                                                                                                                                                                                                                      xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                                                                                            var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\x01\xfc\xa3M\x99\xd4O$\x95\x9eUu\xc6*\xc0"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                                            break;
                                                                                                                                                                                                                            case #"hash_c82a1fa1c794832c" :
                                                                                                                                                                                                                            var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xb2\x93\x7f8\xaa\xddiY\x11\xc0", "\xc1\xd9U1\xf0\xf4\x90V\x16s\x91\xf9\xfa\xf5T", "r\xd76\x89fbY\xacT\xc4\xfctP8Yx", "m6\xac+)Ai\xbdW\x01\x96\xf4Q.\xc6n\xe7\xd3"]; var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "1x\xa8\xf1\xf0R\xderWC\xc1n\xfe", "\a\x17\x81sK\x10\xf2\xdf\xce}\xa8@rYG\xe9\xafr\x81", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", "\xe8!\x01\x16\xf7A\xbbH\x94\x10\x99]\xf9\xe1=\x82hw"]; var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x88\x81\"\x9bM7\xfa\x87)j\xc1", "\xba\x9e\x83w\x9f0[v|\xd2", "\t\x98E\xa1\xebu\xb0\xed7AP_\x90\x92BM", "\xf3\xaaY\x8e\xdbs\xb8\xf5u\xc9\bZ\x97\x15\xb7*}"]; var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\x9b\xba\xab\x19\x0eW*", "}
                                                                                                                                                                                                                            }\
                                                                                                                                                                                                                            xeaZ\b\x8b\xd8 ", "\x0f\x8aXl\xd5F\xf5(", "\x83\xbdqz\x95W\x98j ", " / 4 q\xcf / \xbf\xa2\x99 ", "\x161V\xb2\xda\x99 ", "3\x03\x04\x15CG ", "\xb6\xbb\xe0QT_ ", "\xe9\xf7p\xc3\xeaH[k\x02 ", "BQq\xa2o\x8ao\x19 ", "\x9d\xabQo ? W\xe1V "];
                                                                                                                                                                                                                                var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu"]; var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                                                break;
                                                                                                                                                                                                                              }

                                                                                                                                                                                                                              break;
                                                                                                                                                                                                                              case #"hash_719417cb1de832b6":
                                                                                                                                                                                                                              weaponname = "\xef\x99m\xfe\x86\x14\x7fn\xe6\xce\xe8.d\x02\xdc\xf2";

                                                                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                                                                case #"hash_7e15428d3b55ef10":
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xc6\xe0\xb0\x7fZ\x8ds\xc3J\x8b\x9f1\xaf\xce8\xbf", "\xf7\xf9g;\x90Q\xb89\x9c0"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x8a\x0e\x90gr_\xba\xefu:`\xc8SC"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "3[\t_L2;\xac\xe2\xf3", "m\xc2;\xaf\xc1Z\xbe\x8d\xb0\xc9\xb3+\xbe\x83#C"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "\bK\xbd&\xc2\xe8F\xf9\x7f\xd5\xf8\x8dX3}\xf1y\xd1\xf5*\x80"];
                                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                              }

                                                                                                                                                                                                                              break;
                                                                                                                                                                                                                              case #"hash_23209741b93850b5":
                                                                                                                                                                                                                              weaponprobabilities["Si\xbd\xf8;}D7\xbb\xf3\x81\xceO0i\xfd"] = 50; weaponprobabilities["o\xff\xe4~\xb7\x01aq\x9e'By\x92\x05\xc7%\xbc\xf8\xb7\xa9"] = 50; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                                                                case #"hash_568cc2d89894d1e4":
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "b\x169\xa3]1+\xaf7\x86\xf5\x1c\xc4f", "\xad9t\x8e%b\vf\xaf_\xe1S\a\vl\x0f\xcf\x03eN", "\x8e\xbd\xb3LU\x93=\\J7t\x9f\x84\x11\xaf\x85\x10\x9e\xdfV", "`A\x8f\x14b\xae8\x87\xeb\xacc\x1e\x95\xb0\vuR\x1b\a\xa1"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "T\xb3\xce\xb9\xd4\x13$\x16\xce\x99\x8e\a\x1e", "\xf2\xa9\x11;8\x15DO\x93\xb8\x11V\xccb\xeb\xd27\xd1\xda", "dX\xdc2\xe3\xc5\xc524Z\x8a.\x94\x87\xabS]wP\xac\xce", "\xbe,\x9fPR\x8b\xab\xe49\x14\x1eQ\x82\xd9\xe4~.\xfb", "\xd6\x93\xde\xd8E`\xa2@\x06 z\x90g\xa9", "\x1fPx\x15\xfa\xc5G\xa0\xb8\xffSjP<\xa8\x11[@\xb7\x18"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "p\xad\x9a[\x1b\xa9\xca\xb8\xf9", " o\xec\xeas\x8e\x1a\xbf\xfdX>\b\xdd\xce\xc2\x02\xd1\xf7", "\t\xe9\x8ecRU\xe9A\xe8\x96\xa4\xe6\xee\xce\xe8", "\x11\xe5d\xb3\xaacE\x8e\x89K\xf5G\xb1L\xd6"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xb3rK\a\xfa\xb0\xb9v\xd8e\x91\xc03", "C8[\xe0\\\xdbQ!\x17\xd4\xcf7\xf3", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "]\v-\xa8S\xf8*\x060\xad"];
                                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                                case #"hash_81f38f52e4aaecf5":
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x17\xd2\x10\x18\xc2\x84W\xa7\xc2{", "s\x97\x01?\xe9\x1d\\\\0\x9cU\xfd\xbf\x19\xd2\xeb", "\x9a\xc7\x12\a3\te\x1c\x1b\xec;k{\x97D"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xbe0\x88\x85\xb6\xb2\x1b*r\x80^o\x90", "\xf7\xccl\xd2\x81\xc3\xb5EE\xeaL\x15\x90\x96\xbd\xbb\xdb\x804\x9d\xc8T", "\nty9<|\x19c\xf6_\x94\"\x13\xb7\xfa\x84wP\x14", "\\b\xc0\x17\xbb\\P-SA\xb2\x8e\xcf+"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\xc0]\xa0.\xf8O.W\xfc", "v\xab\v\x9c2\xeb\x86+X\xcey\xbe8&\xd0", "Op@\x921O\xac\x1f]M\rt\xb93\x1a", "\x8c\xf8f\x0e\xdf\x04Q\xd77\rU\x06\x9e\xe8\xe0\xfb\x969"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\xff\xc3\xf7\xaco#!\xfd\xef\x0f:Xu", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                              }

                                                                                                                                                                                                                              break;
                                                                                                                                                                                                                              case #"hash_900cb96c552c5e8e":
                                                                                                                                                                                                                              weaponprobabilities["\xb7\v\xa6\xefn\xa0\xc5\xd8\xa7\x98\x1eD\xb1\xf6\x01\xaa\f"] = 40; weaponprobabilities["\xda\xee\xf5\xe6\xbc\xf0|*\xcb\x89!\x05B\xcb\xbcC"] = 30; weaponprobabilities["\xccF\xb4\xc4\x96\xbcG\xf57v\x14\xe6x\xa1"] = 30; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                                                                case #"hash_15d131b492bdb596":
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xe0\x15\xfc\xde{Z\xd3;\xea?\xdbn\x9e\x84A\x87", "\x86\x95\xa3\xf7\tA\x1d\t-\rZyE\x19\xb8\x89", "\x90\x05f\xdf\xed\x8e\xd1\xa6u\x9e\xdf/\xc1\x89K\xb3\xfd\xae\xf2\xa6", "\xa4\xb5\xa4(uL\xd7r\xf8\x8eru9f\x9b?\xe0\x83\x99"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\x84\xd2\xbfR\xf0d.\xcd\xdf\x11^`q,T\x14\x8aZ", "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb", "\x0fL\xe4l\x8d\x1a\xf9\xd8Ug\xffo\xfa\xe7"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x02\xfe\x84\xcd\x91\xe0\xe6\xf5\xdd!\x16\x0f\xac\x8a\xda\xc8", "F\x8c\xf5e\xc5\x01\xa5>\xc8\xd4\v\xd6D\xf0m\xf5\xe3.\x95", "\xc3\xd0\x86\xe0&a\xdfi\x7f\x89\\&\xda\xb6\xd4\xa7\xf9v0"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\xbb\xe1\x8b[\xa6Bv\xb9\xd8\x15\xea\xdbX", "\xbf1\xca\t\xf5\x10\xa7|m\xa4\xe7\xcff", "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x16\xc7\x1f\xa3\x0f\xee\x9b9J\xc7", "\xc6\xdbm\xc1\xfa\v\x93\xfa\f\x91", "N\x10dL\xef7\xb2\xbf<\x99", "\xf6\xd4\n\xb5\xc9\x8b:\xab,J\xe0"];
                                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                                case #"hash_175809755197c4da":
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xfe\xa7\xe1\xc7\xd4\xb2\xec\x83\x87*", "\x98\xc2\x93\xebnk\xd7l\xb7\xdcg\xbe8\f2", "\xf7\xc7Np\n\xb6\xd8\xad\xb6\xd0\x8e\x06PBn|", ">\xf6M\x83\x0e(@\xf9sg#\xa0\xce\x83\x84."];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "\xe4|!.\xf6\x99\x84J\xf3\xf3r\xaeb*\xee\x1c\xa6\xc3\xad", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "B\x87\xa6q\xdd\x13\x84\x06\x14\xd1", "\xe82\xf5\x98k\xfd\x8c\x99\x1f\xd2?\x02\x8e@\x01V", "\x83),\xc0\xab\xab\xa5\xdf\xb8\x9f&\xb4\n\xf8\xb6\xf0", "\x13\x99\x123Y\xe8\vw\xbc\\\xb8"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [25, "\x83\x18\xc7R\xe8\x81?\xfcG\xe7\xc0\xbe\xaa\xae\x1d\x9c\xf8\xda"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["VwXl+"] = [50, "\xfbo\xf3H\x1b=\xe7\xff\x9f\x82\xd0", "\x03\b\xfa}\xec\xdd\x12\xf9r\xb5\xcf", "\x9d\xe4-\x83\xfa\xec\xb2\xe4:\x81\x99", "\x9f\xbf\x135A)+{\xf9.\x8ei\xf7Bo\x8a", "\xceWk\x1d;V\xa06\xe4\x98\xba%\xf7b\x89p"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                                case #"hash_294ef3868701b31a":
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\xbd\x19\xea\x89\xd6\xdf\x91\xd0\xb9\v\x8f\x03P\x82d\xbf\x11\xd0\xc3", "\t\x90w\x98iP\xc3\xfbJO\xef\xa8\x88\xb4\xda\xc5"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "2\xd8>\xa4\x94\x19\x90\xb2>\xf2\x81\x9f", "\x04}$\xde\xad:\xd9\xa7[\x93*\xb8\xb8t\xe5V\x11y\xfd_\xa0", ";\x83\x91O/gre\xadG\x16\xad\x16i\x9f\xfc\x10o\x18D\x80", "\x87\xc2\xb7\xa0\xc2?\x9b\xdf\xc0\x99\xf95", "\xd6s\x9a\xaf\b?\x978\xb1\xf3Q\xc1\xf1S\xd1\xcf\xff\xdb"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\x80G\x91\x1bPZ\x8cD%\x84<\xfa7\xfb", "\xe0\x167\x10\xe5\x9a\xc7\xa7\x95\xdf\x83 \x9b\xc5a\xcb\xd3\xeb"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [60, "<\xd9\xc0\xbc\xda\xe8z\x95\xd5\xf5\x85c\b()\x95\x9c\x9f\xc5\xc1&", "^MH\xde\xb96\xb4\xf1\xf7\xd3\xa4\xbd\xd5VH\xca\xf9v\xb7\xbc\xb9", "\xa3\x91\xfev\xbd\xf2d\x14\xae`\xc2\xdeG\xeb\x04m\xb0\t}\xf9\xdf", "8\x1d\x89\xbc\x83`\xc1\xa4\xbe\xe5\xb7{KA\x8bP\xf6j\v\xfa\xf2", "\x161V\xb2\xda\x99", "3\x03\x04\x15CG", "\xb6\xbb\xe0QT_", "\x15\x85\xec\x92{n\x96\x1b\xf2-\a\xa5\x05", "\xc1_\x8a&\xf0K\xf3I2t\xd8\xc4\xa7", "\xe4e3\x8d\x95\xf0\xc03}:\vc\xc6", "\x8an\x04:\xaf,03\x86x\xcd\xee6"];
                                                                                                                                                                                                                                  var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "\x81;\x8d\xab\xe4;&\xb2)\x89", "\xe4\xb8\xbbw\x90\x87_\xeb\x7fg", "\xea\xc0:\xbd^\xe2\x16\xc1~\x10", "3\xb1a\xdch\xfa\xdcm\xeb\f\x13"];
                                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                              }

                                                                                                                                                                                                                              break;
                                                                                                                                                                                                                              case #"hash_6191aaef9f922f96":
                                                                                                                                                                                                                              weaponprobabilities["\x84\xd0\x05V\xfcn\xb7\x16cy\xab~3\xf4aU"] = 100; weaponname = utility::get_weapon_weighted(weaponarray, weaponprobabilities);

                                                                                                                                                                                                                              switch (weaponname) {
                                                                                                                                                                                                                                case #"hash_3fd5bba485c2aea6":
                                                                                                                                                                                                                                  if(getDvar(@ "g_mapname") == "\xa7\xea`\xcbg\x80") {
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x98\x85\x93\xfa\xdc\xe6\xf5p\f\xc8"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "s\x1d{\xc6\xb6\xeb,9_\vss\xc2\xae\xb1t\xbe\a\x18\x19\xfa\x1c\xec\xdb\x1bf&", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdf\x7f\xc1N\b\xe2v]\x7f\\", "\xd4#\x03\xdf\x86\xc5\xb7\x96\xc0\xd02\xf4\xeey\x8c\xe2"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [100, "i\xd3a\xb3\x9e\x9f\xceFH\b~\xeb"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [40, "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                                                  } else {
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["&a''\x95ls"] = [50, "\x98\x85\x93\xfa\xdc\xe6\xf5p\f\xc8"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xd5\xdf\x1d\xbd\xedc"] = [50, "S4nk\xe8Owh]\f\xee\xb2", "\xc2\x1c:\xe1A_\xa5-\x12\b:\x86", "\x05\x8d\x7f\xe0\xbf*\x1b]\x02n\xa9\xb7\xfab>\xc0\x84\xd9\x0f\xe7a", "s\x1d{\xc6\xb6\xeb,9_\vss\xc2\xae\xb1t\xbe\a\x18\x19\xfa\x1c\xec\xdb\x1bf&", "\xa6\xf47\xfeA`\xd9\xb09\x89\xbe\xed", "k\x0e\xd8\v.\nm\xa9\x93@\x1c\x88"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["H\xecq\xdd"] = [50, "\xdf\x7f\xc1N\b\xe2v]\x7f\\", "\xd4#\x03\xdf\x86\xc5\xb7\x96\xc0\xd02\xf4\xeey\x8c\xe2"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xeb9\xd6\xee9\xc9"] = [100, "2\x11\xa3\xd5Z\xe0\x99V\xb5\xce\x19z\x01\x17u"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xb5\x9d7`\xc7\t3}\x1d\xc7\xc7\xb8"] = [40, "\x17\xd3\x11\x1b\a\xdc\xb1"];
                                                                                                                                                                                                                                    var_3c1147f3a07e0b51["\xd4\x12Z\x99 \xc2\aR`"] = [50, "l\xb7\xb5\x83}&r_\f\x89", "\xebb\xd9\x824\xe3\\\xf3\xfca", "\x9b8\xc3\xe0|\x8b*\xac\xc2\xe2", "4\xbd\xdei\xf9\xcc\xf5\x06UlA"];
                                                                                                                                                                                                                                  }

                                                                                                                                                                                                                                  break;
                                                                                                                                                                                                                              }

                                                                                                                                                                                                                              break;
                                                                                                                                                                                                                            }

                                                                                                                                                                                                                            return utility::make_weapon_random(weaponname, var_3c1147f3a07e0b51, attachment_combos, camos);
                                                                                                                                                                                                                          }

                                                                                                                                                                                                                          function function_67673f10d815ddc9() {
                                                                                                                                                                                                                            if(getdvarint(@ "hash_45281f93550798")) {
                                                                                                                                                                                                                              iprintln("<dev string:xff>");
                                                                                                                                                                                                                            }
                                                                                                                                                                                                                          }

                                                                                                                                                                                                                          function getweapon_camos(type) {
                                                                                                                                                                                                                            if(getdvarint(@ "hash_f9de3dfe4b6a8b1d") == 1) {
                                                                                                                                                                                                                              return undefined;
                                                                                                                                                                                                                            }

                                                                                                                                                                                                                            if(!isDefined(type)) {
                                                                                                                                                                                                                              type = "";
                                                                                                                                                                                                                            }

                                                                                                                                                                                                                            camos = [];
                                                                                                                                                                                                                            return camos;
                                                                                                                                                                                                                          }
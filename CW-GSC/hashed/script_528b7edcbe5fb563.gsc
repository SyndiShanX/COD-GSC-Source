/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_528b7edcbe5fb563.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace bot_cac;

function private autoexec __init__system__() {
  system::register(#"bot_cac", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::is_frontend_map()) {
    return;
  }

  if(currentsessionmode() == 4 || currentsessionmode() == 2) {
    return;
  }

  callback::on_connect(&on_player_connect);
  callback::add_callback(#"hash_730d00ef91d71acf", &function_8481733a);

  level thread function_3dd3f3b6();
}

function private on_player_connect() {
  if(!isbot(self) || isautocontrolledplayer(self) || is_true(self.pers[# "hash_6dcf8b0dc38e9166"])) {
    return;
  }

  self function_293c5838(0);
  self.pers[# "hash_6dcf8b0dc38e9166"] = 1;
}

function private function_8481733a() {
  if(!isbot(self) || isautocontrolledplayer(self)) {
    return;
  }

  if(is_true(level.disablecustomcac) || is_true(level.disableclassselection)) {
    return;
  }

  if(!isstruct(self.bot) || !isstruct(self.bot.difficulty) || !isarray(self.bot.difficulty.var_ded0efe5) || self.bot.difficulty.var_ded0efe5.size <= 0) {
    return;
  }

  var_543fda24 = self.bot.difficulty.var_ded0efe5;
  var_3ea84edb = var_543fda24[randomint(var_543fda24.size)];

  if(isDefined(var_3ea84edb)) {
    var_3b0cd6f4 = function_d55845e(var_3ea84edb.name);

    if(isDefined(var_3b0cd6f4)) {
      function_5d3cc643(0, var_3b0cd6f4);
    }
  }
}

function private function_293c5838(loadoutclass) {
  loadouts = function_798e35b8();

  if(isstruct(loadouts) && isarray(loadouts.defaultloadouts) && loadouts.defaultloadouts.size > 0) {
    defaultindex = randomint(loadouts.defaultloadouts.size);
    self function_6692a2a5(loadoutclass, loadouts.defaultloadouts[defaultindex], loadouts.killstreaks);
  }
}

function private function_798e35b8() {
  sessionmode = currentsessionmode();

  if(sessionmode == 1) {
    return getscriptbundle(#"mp_default_loadouts");
  } else if(sessionmode == 3) {
    return getscriptbundle(#"wz_default_loadouts");
  }

  return undefined;
}

function private function_6692a2a5(loadoutclass, loadout, killstreaks) {
  self function_b4a1d42a(loadoutclass);
  self function_3d2e4133(loadoutclass, loadout.primary, loadout.primaryattachments, &function_29b482e0, &function_9d5e1230);
  self function_3d2e4133(loadoutclass, loadout.secondary, loadout.secondaryattachments, &function_7db40dda, &function_25ac8c68);
  self function_cbd58d72(loadoutclass, loadout.primarygrenade, loadout.var_1c89585f, &function_9a75f033);
  self function_cbd58d72(loadoutclass, loadout.secondarygrenade, loadout.var_285151c1, &function_ac5568db);
  self function_cbd58d72(loadoutclass, loadout.specialgrenade, loadout.var_919cf3d3, &function_493daf47);
  self function_64f67be5(loadoutclass, loadout.talents);
  self function_29b0ec15(loadoutclass, loadout.bonuscards);
  self function_9d82de06(loadoutclass, killstreaks);
}

function private function_3d2e4133(loadoutclass, weaponname, attachments, var_c2575532, var_1b426c77) {
  if(!isDefined(weaponname) || isitemrestricted(weaponname)) {
    return;
  }

  self[[var_c2575532]](loadoutclass, weaponname);

  if(isDefined(attachments)) {
    foreach(i, attachment in attachments) {
      attachmentname = attachment.attachment;

      if(isDefined(attachmentname) && !isattachmentrestricted(weaponname, attachmentname)) {
        self[[var_1b426c77]](loadoutclass, attachmentname, i);
      }
    }
  }
}

function private function_cbd58d72(loadoutclass, grenadename, extragrenade, var_632ae174) {
  if(!isDefined(grenadename) || isitemrestricted(grenadename)) {
    return;
  }

  if(!isDefined(extragrenade)) {
    extragrenade = 0;
  }

  self[[var_632ae174]](loadoutclass, grenadename, extragrenade);
}

function private function_64f67be5(loadoutclass, talents) {
  if(!isDefined(talents)) {
    return;
  }

  foreach(i, talent in talents) {
    talentname = talent.talent;

    if(isDefined(talentname)) {
      self function_5a385365(loadoutclass, talentname, i);
    }
  }
}

function private function_29b0ec15(loadoutclass, bonuscards) {
  if(!isDefined(bonuscards)) {
    return;
  }

  foreach(i, bonuscard in bonuscards) {
    bonuscardname = bonuscard.bonuscard;

    if(isDefined(bonuscardname)) {
      self function_f9b438ba(loadoutclass, bonuscardname, i);
    }
  }
}

function private function_9d82de06(loadoutclass, killstreaks) {
  if(!isDefined(killstreaks)) {
    return;
  }

  foreach(i, killstreak in killstreaks) {
    killstreakname = killstreak.killstreak;

    if(isDefined(killstreakname) || isitemrestricted(killstreakname)) {
      self function_60c5f1d4(loadoutclass, killstreakname, i);
    }
  }
}

function private function_d55845e(var_581102ed) {
  if(!isDefined(var_581102ed)) {
    return undefined;
  }

  return getscriptbundle(var_581102ed);
}

function private function_5d3cc643(loadoutclass, var_3b0cd6f4) {
  self function_b4a1d42a(loadoutclass);
  bonuses = spawnStruct();
  bonuscards = function_20d254c4(var_3b0cd6f4.bonuscards, 6, #"hash_6400e1885e5d8aba");
  self function_73e20080(loadoutclass, bonuscards, 1, bonuses);
  primaryweapons = function_20d254c4(var_3b0cd6f4.primaryweapons, 1, #"hash_5b5f44e15bfa8dee");
  secondaryweapons = function_20d254c4(var_3b0cd6f4.secondaryweapons, 1, #"hash_41674514bd7e81e2");
  var_6c866ac3 = function_ef026df8(var_3b0cd6f4.primaryattachments, #"hash_27073088eb9a1e37");
  var_1084a9e2 = function_ef026df8(var_3b0cd6f4.secondaryattachments, #"hash_1b2fbf16c3b98c7b");
  var_bc1ac364 = 5;

  if(is_true(bonuses.var_e22b188d)) {
    var_bc1ac364 = 8;
  }

  var_81b9e082 = 0;

  if(is_true(bonuses.var_c38351d8)) {
    var_81b9e082 = randomint(3);
  }

  switch (var_81b9e082) {
    case 1:
      self function_fccfb0af(loadoutclass, primaryweapons, var_6c866ac3, var_bc1ac364, &function_29b482e0, &function_9d5e1230);
      self function_fccfb0af(loadoutclass, primaryweapons, var_6c866ac3, 5, &function_7db40dda, &function_25ac8c68);
      break;
    case 2:
      self function_fccfb0af(loadoutclass, secondaryweapons, var_1084a9e2, var_bc1ac364, &function_29b482e0, &function_9d5e1230);
      self function_fccfb0af(loadoutclass, secondaryweapons, var_1084a9e2, 5, &function_7db40dda, &function_25ac8c68);
      break;
    default:
      self function_fccfb0af(loadoutclass, primaryweapons, var_6c866ac3, var_bc1ac364, &function_29b482e0, &function_9d5e1230);
      self function_fccfb0af(loadoutclass, secondaryweapons, var_1084a9e2, 5, &function_7db40dda, &function_25ac8c68);
      break;
  }

  var_414c7d4d = function_20d254c4(var_3b0cd6f4.var_414c7d4d, 1, #"hash_5c063c13c25c3b6a");
  self function_4426827d(loadoutclass, var_414c7d4d, bonuses.var_1c89585f, &function_9a75f033);
  var_6a79474d = function_20d254c4(var_3b0cd6f4.var_6a79474d, 1, #"hash_60b994f55d1226dd");
  self function_4426827d(loadoutclass, var_6a79474d, 0, &function_ac5568db);
  var_137939d4 = function_20d254c4(var_3b0cd6f4.var_137939d4, 1, #"hash_539a0aed726d68e0");
  self function_4426827d(loadoutclass, var_137939d4, 0, &function_493daf47);
  var_378cddbe = function_20d254c4(var_3b0cd6f4.var_378cddbe, 5, #"hash_7e8686a7207f1d0f");
  var_455c795d = function_20d254c4(var_3b0cd6f4.var_455c795d, 5, #"hash_7e8687a7207f1ec2");
  var_4c2986fb = function_20d254c4(var_3b0cd6f4.var_4c2986fb, 5, #"hash_7e8688a7207f2075");

  if(is_true(bonuses.var_65dd1449)) {
    var_b38ebfd8 = arraycombine(var_378cddbe, var_455c795d);
    var_b38ebfd8 = arraycombine(var_b38ebfd8, var_4c2986fb);
    self function_db9633ae(loadoutclass, var_b38ebfd8, 0, &function_5a385365);
    self function_db9633ae(loadoutclass, var_b38ebfd8, 1, &function_5a385365);
    self function_db9633ae(loadoutclass, var_b38ebfd8, 2, &function_5a385365);
  } else if(is_true(bonuses.extraperks)) {
    self function_db9633ae(loadoutclass, var_378cddbe, 0, &function_5a385365);
    self function_db9633ae(loadoutclass, var_378cddbe, 1, &function_5a385365);
    self function_db9633ae(loadoutclass, var_455c795d, 2, &function_5a385365);
    self function_db9633ae(loadoutclass, var_455c795d, 3, &function_5a385365);
    self function_db9633ae(loadoutclass, var_4c2986fb, 4, &function_5a385365);
    self function_db9633ae(loadoutclass, var_4c2986fb, 5, &function_5a385365);
  } else {
    self function_db9633ae(loadoutclass, var_378cddbe, 0, &function_5a385365);
    self function_db9633ae(loadoutclass, var_455c795d, 1, &function_5a385365);
    self function_db9633ae(loadoutclass, var_4c2986fb, 2, &function_5a385365);
  }

  killstreaks = function_20d254c4(var_3b0cd6f4.killstreaks, 1, #"hash_510ea418ef874618");

  for(i = 0; i < 3; i++) {
    self function_db9633ae(loadoutclass, killstreaks, i, &function_60c5f1d4);
  }
}

function private function_fccfb0af(loadoutclass, &var_19546df5, var_38e0e278, count, var_c2575532, var_1b426c77) {
  weaponname = function_ec884214(var_19546df5);

  if(!isDefined(weaponname)) {
    return;
  }

  if(!self[[var_c2575532]](loadoutclass, weaponname)) {
    return;
  }

  groupnames = [];

  foreach(groupname, attachments in var_38e0e278) {
    if(groupname != # "none") {
      groupnames[groupnames.size] = groupname;
    }
  }

  var_b8a59e38 = 0;
  var_41a600fd = 0;

  while(var_b8a59e38 < count && groupnames.size > 0) {
    groupindex = randomint(groupnames.size);
    groupname = groupnames[groupindex];
    attachments = var_38e0e278[groupname];
    attachment = self function_ec884214(attachments);

    if(isattachmentrestricted(weaponname, attachment)) {
      if(attachments.size <= 0) {
        arrayremoveindex(groupnames, groupindex, 0);
      }

      continue;
    }

    attachmentindex = var_b8a59e38;

    if(groupname == # "optic") {
      attachmentindex = 0;
    } else if(!var_41a600fd) {
      attachmentindex++;
    }

    if(self[[var_1b426c77]](loadoutclass, attachment, attachmentindex)) {
      var_b8a59e38++;
      var_41a600fd |= groupname == # "optic";
      arrayremoveindex(groupnames, groupindex, 0);
      continue;
    }

    if(attachments.size <= 0) {
      arrayremoveindex(groupnames, groupindex, 0);
    }
  }
}

function private function_4426827d(loadoutclass, &var_4e165b9c, extragrenade, var_632ae174) {
  grenadename = function_ec884214(var_4e165b9c);

  if(!isDefined(grenadename)) {
    return;
  }

  if(!isDefined(extragrenade)) {
    extragrenade = 0;
  }

  self[[var_632ae174]](loadoutclass, grenadename, extragrenade);
}

function private function_db9633ae(loadoutclass, &itemnames, itemindex, var_9fe65064) {
  name = function_ec884214(itemnames);

  if(!isDefined(name)) {
    return;
  }

  self[[var_9fe65064]](loadoutclass, name, itemindex);
}

function private function_73e20080(loadoutclass, &var_44518c47, count, bonuses) {
  var_b8a59e38 = 0;

  while(var_b8a59e38 < count && var_44518c47.size > 0) {
    bonuscard = function_ec884214(var_44518c47);

    if(self function_f9b438ba(loadoutclass, bonuscard, var_b8a59e38)) {
      var_b8a59e38++;
      function_13aa0d3(bonuscard, bonuses);
    }
  }
}

function private function_13aa0d3(bonuscard, bonuses) {
  switch (bonuscard) {
    case # "hash_44e17bf715d7ac82":
      bonuses.var_1c89585f = 1;
      break;
    case # "hash_639ebbcda56447e7":
      bonuses.var_c38351d8 = 1;
      bonuses.var_3f5d0ded = 1;
      break;
    case # "bonuscard_primary_gunfighter":
      bonuses.var_e22b188d = 1;
      break;
    case # "hash_4c417275f7523978":
      bonuses.extraperks = 1;
      break;
  }
}

function private function_20d254c4(var_543fda24, statindexoffset, overridedvar = undefined) {
  if(isDefined(overridedvar)) {
    dvarstr = getdvarstring(overridedvar, "<dev string:x38>");

    if(dvarstr == # "none") {
      return [];
    }

    names = strtok(dvarstr, "<dev string:x3c>");

    if(names.size > 0) {
      return names;
    }
  }

  if(!isDefined(var_543fda24)) {
    return [];
  }

  names = [];

  foreach(item in var_543fda24) {
    if(!isDefined(item.name)) {
      names[names.size] = # "none";
      continue;
    }

    if(function_f83425a6(item.name) && !isitemrestricted(item.name)) {
      itemindex = getitemindexfromref(item.name);

      if(itemindex > 0) {
        iteminfo = getunlockableiteminfofromindex(itemindex, statindexoffset);

        if(!is_true(iteminfo.hideinmenu)) {
          names[names.size] = item.name;
        }
      }
    }
  }

  return names;
}

function private function_ec884214(&names) {
  if(names.size <= 0) {
    return undefined;
  }

  i = randomint(names.size);
  name = names[i];
  arrayremoveindex(names, i);
  return name;
}

function private function_ef026df8(attachments, overridedvar = undefined) {
  if(isDefined(overridedvar)) {
    dvarstr = getdvarstring(overridedvar, "<dev string:x38>");

    if(dvarstr == # "none") {
      return [];
    }

    names = strtok(dvarstr, "<dev string:x3c>");

    if(names.size > 0) {
      attachments = names;
    }
  }

  if(!isDefined(attachments)) {
    return [];
  }

  names = strtok(attachments, " ");
  groups = [];

  foreach(name in names) {
    groupname = function_788fb3bd(name);

    if(isDefined(groupname)) {
      if(!isDefined(groups[groupname])) {
        groups[groupname] = [];
      }

      group = groups[groupname];
      group[group.size] = name;
    }
  }

  return groups;
}

function private function_3dd3f3b6() {
  level endon(#"game_ended");
  var_ec9c0769 = [# "talent": 6, #"bonuscard": 3, #"killstreak": 4];

  while(true) {
    slot = getdvarstring(#"hash_601d0ce91dfa4b22", "<dev string:x41>");

    if(slot == "<dev string:x41>") {
      waitframe(1);
      continue;
    }

    bots = function_b16926ea();
    teamcounts = [];

    foreach(bot in bots) {
      if(!isDefined(level.teams[bot.team])) {
        continue;
      }

      slotcount = teamcounts[bot.team];

      if(!isDefined(slotcount)) {
        slotcount = [];
        teamcounts[bot.team] = slotcount;
      }

      var_4deb6126 = var_ec9c0769[slot];

      if(isDefined(var_4deb6126)) {
        for(i = 1; i <= var_4deb6126; i++) {
          slotkey = slot + i;
          itemname = bot function_b958b70d(0, slotkey);

          if(!isDefined(slotcount[slotkey][itemname])) {
            slotcount[slotkey][itemname] = 0;
          }

          slotcount[slotkey][itemname]++;
        }

        continue;
      }

      itemname = bot function_b958b70d(0, slot);

      if(!isDefined(slotcount[slot][itemname])) {
        slotcount[slot][itemname] = 0;
      }

      slotcount[slot][itemname]++;
    }

    x = 30;

    foreach(team, slotcount in teamcounts) {
      y = 30;
      debug2dtext((x, y, 0), function_9e72a96(team), undefined, undefined, undefined, 1);
      y += 22;
      x += 20;

      foreach(slot, itemnames in slotcount) {
        debug2dtext((x, y, 0), function_9e72a96(slot), undefined, undefined, undefined, 1);
        y += 22;
        x += 20;

        foreach(itemname, count in itemnames) {
          debug2dtext((x, y, 0), function_9e72a96(itemname) + "<dev string:x49>" + count, undefined, undefined, undefined, 1);
          y += 22;
        }

        x -= 20;
      }

      x -= 20;
      x += 300;
    }

    waitframe(1);
  }
}
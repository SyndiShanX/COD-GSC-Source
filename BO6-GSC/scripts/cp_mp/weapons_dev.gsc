/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\weapons_dev.gsc
*****************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\weapon;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace weapons_dev;

function function_4104f01b5a640281() {
  if(getbuildversion() != "SHIP") {
    thread function_53c9fec4685894a8();
    setDvar(@ "scr_giveweaponblueprintname", "");
  }

  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  if(!isDefined(level.weapdev)) {
    level.weapdev = spawnStruct();
  }

  thread function_1870827b286edc80();
  thread function_edc16b21cfd6ebd4();
  thread function_e497e457bfd53f9f();
  thread function_5007e34ad8f974e6();
  level callback::add(#"player_connect", &function_96fffde153b023ff);
  level callback::add(#"player_disconnect", &function_e35a926b56357031);
  level callback::add(#"player_weapon_change", &function_ae91286911ea949c);
  level callback::add(#"player_spawned", &function_d11a902aeffe8e8f);
  setdevdvar(@ "hash_eab5f19fea65c5c2", "<dev string:x24>");
  setdevdvar(@ "hash_a1c77cb5b109ab77", "<dev string:x24>");
  setdevdvar(@ "hash_19234cfdaa9d6a8b", 0);
}

function function_53c9fec4685894a8() {
  if(getbuildversion() != "SHIP") {
    for(;;) {
      if(getDvar(@ "scr_giveweaponblueprintname", "") != "") {
        thread function_a8e5e272f2e32525();
      }

      waitframe();
    }
  }
}

function function_a8e5e272f2e32525() {
  if(getbuildversion() != "SHIP") {
    blueprintname = getDvar(@ "scr_giveweaponblueprintname");
    weapon = weapon::getweaponrootname(blueprintname);
    weaponasset = undefined;

    if(isDefined(level.weaponmapdata[weapon])) {
      weaponasset = level.weaponmapdata[weapon].assetname;
    }

    weaponblueprint = getxhashasset(blueprintname);

    if(isDefined(weaponasset) && isDefined(weaponblueprint)) {
      foreach(player in level.players) {
        var_dd2db255da3902ac = weapon::function_bfc8095d723355fa(weaponasset, weaponblueprint);
        currentweapon = player.currentweapon;
        player.droppeddeathweapon = undefined;

        if(utility::issharedfuncdefined(#"weapons", #"dropweaponfordeath")) {
          player thread[[utility::getsharedfunc(#"weapons", #"dropweaponfordeath")]](undefined, "");
        }

        player.droppeddeathweapon = undefined;

        if(player hasweapon(var_dd2db255da3902ac)) {
          player inventory_utility::_takeweapon(var_dd2db255da3902ac);
        }

        player giveweapon(var_dd2db255da3902ac);
        player setweaponammoclip(var_dd2db255da3902ac, weaponclipsize(var_dd2db255da3902ac));
        player setweaponammostock(var_dd2db255da3902ac, weaponmaxammo(var_dd2db255da3902ac));
        player inventory_utility::_switchtoweaponimmediate(var_dd2db255da3902ac);
        weapon::fixupplayerweapons(player, weapon);
      }
    }

    setDvar(@ "scr_giveweaponblueprintname", "");
  }
}

function function_3fed1b5a7249c0ef(group) {
  class = undefined;

  if(isDefined(group)) {
    class = "<dev string:x28>";

    switch (group) {
      case #"hash_8af0086b038622b5":
        class = "<dev string:x42>";
        break;
      case #"hash_dd616da0b395a0b0":
        class = "<dev string:x64>";
        break;
      case #"hash_47368bc0d2ef1565":
        class = "<dev string:x82>";
        break;
      case #"hash_bef5ec0b3e197ae":
        class = "<dev string:x97>";
        break;
      case #"hash_86b11ac21f992552":
      case #"hash_a1f27f97be15d620":
        class = "<dev string:xbf>";
        break;
      case #"hash_34340d457a63e7f1":
        class = "<dev string:xd9>";
        break;
      case #"hash_9d18adab1b65a661":
        class = "<dev string:xf8>";
        break;
      case #"hash_16cf6289ab06bd30":
        class = "<dev string:x116>";
        break;
      case #"hash_ab10f9c080fe4faf":
        class = "<dev string:x12f>";
        break;
      case #"hash_c095d67337b1f5a1":
        class = "<dev string:x147>";
        break;
      case #"hash_2535634d8bb5c955":
        class = "<dev string:x162>";
        break;
      case #"hash_cd7f87dc1cdeaa54":
        class = "<dev string:x188>";
        break;
    }
  }

  return class;
}

function function_1870827b286edc80() {
  devgui::function_9082edeb5db93280("<dev string:x193>" + "<dev string:x1a4>");
  sorted_weapons = arraysort(getarraykeys(level.weaponmapdata), undefined, undefined, 0, undefined, 1);

  for(i = 0; i < sorted_weapons.size; i++) {
    data = level.weaponmapdata[sorted_weapons[i]];
    weaponclass = function_3fed1b5a7249c0ef(data.group);

    if(isDefined(weaponclass)) {
      devgui::add_devgui_command(weaponclass + "<dev string:x1b6>" + data.assetname, "<dev string:x1bb>" + data.assetname);
      continue;
    }

    devgui::add_devgui_command("<dev string:x1f3>" + data.assetname, "<dev string:x1bb>" + data.assetname);
  }

  devgui::function_77df7fe7dd273e10();
  devgui::function_9082edeb5db93280("<dev string:x193>" + "<dev string:x205>");

  for(i = 0; i < sorted_weapons.size; i++) {
    data = level.weaponmapdata[sorted_weapons[i]];
    weaponclass = function_3fed1b5a7249c0ef(data.group);

    if(!isDefined(weaponclass)) {
      continue;
    }

    blueprints = getweaponblueprintnames(data.assetname);

    foreach(entry, index in blueprints) {
      var_e3763051b410419c = getxhashsourcename(entry);
      devgui::add_devgui_command(weaponclass + "<dev string:x1b6>" + data.assetname + "<dev string:x1b6>" + var_e3763051b410419c, "<dev string:x221>" + var_e3763051b410419c);
    }
  }

  devgui::function_77df7fe7dd273e10();
  devgui::function_9082edeb5db93280("<dev string:x193>" + "<dev string:x248>");
  devgui::add_devgui_command("<dev string:x25c>", "<dev string:x273>");
  devgui::add_devgui_command("<dev string:x29a>", "<dev string:x2b8>");
  devgui::function_77df7fe7dd273e10();
  devgui::function_9082edeb5db93280("<dev string:x193>");
  devgui::add_devgui_command("<dev string:x2e5>", "<dev string:x300>", 7);
  devgui::add_devgui_command("<dev string:x324>", "<dev string:x33e>", 8);
  devgui::add_devgui_command("<dev string:x368>", "<dev string:x383>", 3);
  devgui::add_devgui_command("<dev string:x3c9>", "<dev string:x3e4>", 4);
  devgui::function_77df7fe7dd273e10();
}

function function_156bc0617974c0(dvar, defaultvalue, func, isthreaded, unarchived) {
  if(!isDefined(level.weapdev.dvars)) {
    level.weapdev.dvars = [];
  }

  setdvarifuninitialized(dvar, defaultvalue);
  struct = spawnStruct();
  struct.func = func;
  struct.dvar = dvar;
  struct.defaultvalue = defaultvalue;

  if(isDefined(isthreaded)) {
    struct.threaded = isthreaded;
  }

  if(isDefined(unarchived)) {
    struct.unarchived = unarchived;
  }

  level.weapdev.dvars[dvar] = struct;
}

function function_93a456a1c453c3c6() {
  if(!isDefined(level.weapdev.dvars)) {
    return;
  }

  for(;;) {
    foreach(dvarstr, data in level.weapdev.dvars) {
      dvarval = undefined;

      if(isDefined(data.unarchived)) {
        dvarval = getunarchiveddebugdvar(dvarstr);
      } else {
        dvarval = getDvar(dvarstr);
      }

      if(!isDefined(dvarval)) {
        continue;
      }

      if(dvarval == data.defaultvalue) {
        continue;
      }

      if(isDefined(data.threaded)) {
        thread[[data.func]](dvarval);
      } else {
        [[data.func]](dvarval);
      }

      setDvar(dvarstr, data.defaultvalue);
    }

    wait 0.2;
  }
}

function function_edc16b21cfd6ebd4() {
  function_156bc0617974c0(@ "hash_5a6ac095cce29d6a", "<dev string:x406>", &function_58d113b62185c59f, 0, 0);
  function_156bc0617974c0(@ "hash_b8fb8e495524a25c", "<dev string:x40b>", &function_53427573125f0445, 0, 0);
  function_156bc0617974c0(@ "hash_5d287f84a6f89b43", "<dev string:x40b>", &function_cb8b365f038e66ac, 0, 0);
  function_156bc0617974c0(@ "hash_61d2d8e5a629ef89", "<dev string:x406>", &function_b94d6f4bbb849350, 0, 0);
  function_156bc0617974c0(@ "hash_dba288284435008a", "<dev string:x406>", &function_1d66de57a6d2a6ed, 0, 0);
  function_156bc0617974c0(@ "hash_b72466ac81416f5a", "<dev string:x406>", &function_77396855a5d69ccd, 0, 0);
  function_156bc0617974c0(@ "weapdev_give_weapon", "<dev string:x24>", &function_a17738bafec31f2a, 0, 0);
  function_156bc0617974c0(@ "hash_c2957735560e95b2", "<dev string:x24>", &function_73fcc7f0bf876477, 0, 0);
  thread function_93a456a1c453c3c6();
}

function function_a17738bafec31f2a(weaponname) {
  weapnew = weaponname;
  variant = -1;
  toks = strtok(weaponname, "<dev string:x411>");

  if(toks.size > 1) {
    weapnew = toks[0];
    variant = int(toks[1]);
  }

  if(isDefined(weapnew)) {
    var_f9d549c3e76fc2cc = weapon::getweaponrootname(weapnew);
    playerarray = function_4bf8fbed95838f12();

    foreach(player in playerarray) {
      hasnvg = istrue(level.nightmap);
      var_dd2db255da3902ac = weapon::buildweapon(var_f9d549c3e76fc2cc, undefined, undefined, undefined, variant, undefined, undefined, undefined, hasnvg);

      if(utility::issharedfuncdefined(#"dev", #"spawnweapon")) {
        player[[utility::getsharedfunc(#"dev", #"spawnweapon")]](var_dd2db255da3902ac, 1, undefined);
        continue;
      }

      currentweapon = player.currentweapon;
      player function_a56eb9ae7659b798(currentweapon, var_dd2db255da3902ac, 0);
    }
  }
}

function function_73fcc7f0bf876477(val) {
  if(isDefined(val)) {
    params = strtok(val, "<dev string:x416>");
    weaponobj = undefined;
    attachmentname = undefined;

    if(params.size > 1) {
      var_f9d549c3e76fc2cc = weapon::getweaponrootname(params[0]);
      hasnvg = istrue(level.nightmap);
      weaponobj = weapon::buildweapon(var_f9d549c3e76fc2cc, undefined, undefined, undefined, undefined, undefined, undefined, undefined, hasnvg);
      attachmentname = params[1];
    } else {
      attachmentname = params[0];
    }

    if(isDefined(attachmentname)) {
      playerarray = function_4bf8fbed95838f12();

      foreach(player in playerarray) {
        currentweapon = player.currentweapon;

        if(isDefined(currentweapon)) {
          if(!isDefined(weaponobj)) {
            weaponobj = currentweapon;
          } else if(currentweapon.var_1616e6fbba9a722d == weaponobj.var_1616e6fbba9a722d) {
            weaponobj = currentweapon;
          }
        }

        if(!isDefined(weaponobj)) {
          if(!isbot(player)) {
            player iprintlnbold("<dev string:x41b>");
          }

          continue;
        }

        var_dd2db255da3902ac = function_198e4dddd15424e7(weaponobj, attachmentname);

        if(!isDefined(var_dd2db255da3902ac)) {
          if(!isbot(player)) {
            player iprintlnbold("<dev string:x435>" + attachmentname + "<dev string:x44d>" + weaponobj.basename + "<dev string:x45f>");
          }

          continue;
        }

        if(utility::issharedfuncdefined(#"dev", #"spawnweapon")) {
          player[[utility::getsharedfunc(#"dev", #"spawnweapon")]](var_dd2db255da3902ac, 1, undefined);
          continue;
        }

        player function_a56eb9ae7659b798(currentweapon, var_dd2db255da3902ac, 1);
      }

      return;
    }

    iprintlnbold("<dev string:x465>");
  }
}

function function_198e4dddd15424e7(weaponobj, attachmentname) {
  var_b864fe801fd30f7a = weaponobj getnoaltweapon();
  attachmenttoidmap = var_b864fe801fd30f7a.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in attachmenttoidmap) {
    attachments[attachments.size] = attachment;
  }

  failed = !var_b864fe801fd30f7a canuseattachment(attachmentname);

  if(failed) {
    return undefined;
  }

  attachments = weapon::weaponattachremoveextraattachments(attachments);
  var_c84cf1d3502a1321 = [];

  foreach(idx, attachment in attachments) {
    var_c84cf1d3502a1321[idx] = attachmenttoidmap[attachment];
  }

  camo = var_b864fe801fd30f7a.camo;
  stickers = [];

  if(isDefined(var_b864fe801fd30f7a.stickerslot0)) {
    stickers[stickers.size] = var_b864fe801fd30f7a.stickerslot0;
  }

  if(isDefined(var_b864fe801fd30f7a.stickerslot1)) {
    stickers[stickers.size] = var_b864fe801fd30f7a.stickerslot1;
  }

  if(isDefined(var_b864fe801fd30f7a.stickerslot2)) {
    stickers[stickers.size] = var_b864fe801fd30f7a.stickerslot2;
  }

  if(isDefined(var_b864fe801fd30f7a.stickerslot3)) {
    stickers[stickers.size] = var_b864fe801fd30f7a.stickerslot3;
  }

  if(isDefined(var_b864fe801fd30f7a.var_73762c7cb8b2063)) {
    stickers[stickers.size] = var_b864fe801fd30f7a.var_73762c7cb8b2063;
  }

  hasnvg = istrue(level.nightmap);
  attachment1slot = getattachmentslot(var_b864fe801fd30f7a, attachmentname);
  replaced = 0;

  foreach(idx, a in attachments) {
    attachment2slot = getattachmentslot(var_b864fe801fd30f7a, attachments[idx]);

    if(attachment1slot == attachment2slot) {
      attachments[idx] = attachmentname;
      replaced = 1;
    }
  }

  if(!replaced) {
    attachments[attachments.size] = attachmentname;
    var_c84cf1d3502a1321[var_c84cf1d3502a1321.size] = 0;
  }

  variantid = getweaponvariantindex(weaponobj);
  var_2b8dd15b4fd235fa = weapon::buildweapon(weapon::getweaponrootname(weaponobj), attachments, camo, "<dev string:x47c>", variantid, var_c84cf1d3502a1321, undefined, stickers, hasnvg);
  return var_2b8dd15b4fd235fa;
}

function function_a56eb9ae7659b798(currentweapon, var_dd2db255da3902ac, giveammo) {
  player = self;

  if(player hasweapon(var_dd2db255da3902ac)) {
    player takeweapon(var_dd2db255da3902ac);
  } else if(isDefined(currentweapon)) {
    if(utility::issharedfuncdefined(#"weapons", #"dropweaponfordeath")) {
      player.droppeddeathweapon = undefined;
      player thread[[utility::getsharedfunc(#"weapons", #"dropweaponfordeath")]](undefined, "<dev string:x24>");
      player.droppeddeathweapon = undefined;
    } else {
      player dropitem(currentweapon);
    }
  }

  player inventory_utility::_giveweapon(var_dd2db255da3902ac);

  if(giveammo) {
    player setweaponammoclip(var_dd2db255da3902ac, weaponclipsize(var_dd2db255da3902ac));
    player setweaponammostock(var_dd2db255da3902ac, weaponmaxammo(var_dd2db255da3902ac));
  }

  if(level.tertiaryweaponslotenabled && var_dd2db255da3902ac.ismelee && var_dd2db255da3902ac != level.defaultfist) {
    player assignweaponmeleeslot(var_dd2db255da3902ac);
  }

  player inventory_utility::_switchtoweaponimmediate(var_dd2db255da3902ac);
  weapon::fixupplayerweapons(player, var_dd2db255da3902ac);
}

function function_58d113b62185c59f(entnum) {
  host = function_7b72be42471b5133();
  target = host function_b8745e837d180bbd();

  if(!isDefined(target)) {
    return;
  }

  function_53427573125f0445(target getentitynumber());
}

function function_53427573125f0445(entnum) {
  entnum = int(entnum);

  if(!isDefined(level.players[entnum])) {
    iprintln("<dev string:x484>");
    return;
  }

  level.weapdev.var_ceefa46f8106bbca = spawnStruct();
  level.weapdev.var_ceefa46f8106bbca.entnum = entnum;
  level.weapdev.var_ceefa46f8106bbca.ent = level.players[entnum];
  iprintln("<dev string:x49e>" + level.weapdev.var_ceefa46f8106bbca.ent.name);
}

function function_cb8b365f038e66ac(entnum) {
  entnum = int(entnum);
  level.weapdev.var_243b9e172963f2f0 = spawnStruct();
  level.weapdev.var_243b9e172963f2f0.entnum = entnum;
  level.weapdev.var_243b9e172963f2f0.ent = level.players[entnum];
}

function function_b94d6f4bbb849350(dummy) {
  level.weapdev.var_ceefa46f8106bbca = undefined;
  iprintln("<dev string:x4b1>");
}

function function_1d66de57a6d2a6ed(dummy) {
  level.weapdev.var_6792629e6cc7466 = !level.weapdev.var_6792629e6cc7466;

  if(level.weapdev.var_6792629e6cc7466) {
    iprintln("<dev string:x4cb>");
    return;
  }

  iprintln("<dev string:x522>");
}

function function_77396855a5d69ccd(dummy) {
  level.weapdev.var_6c6c8577d1e758a5 = !level.weapdev.var_6c6c8577d1e758a5;

  if(level.weapdev.var_6c6c8577d1e758a5) {
    iprintln("<dev string:x546>");
    return;
  }

  iprintln("<dev string:x591>");
}

function function_4bf8fbed95838f12() {
  if(level.weapdev.var_6c6c8577d1e758a5) {
    return level.players;
  }

  if(isDefined(level.weapdev.var_243b9e172963f2f0) && isDefined(level.weapdev.var_243b9e172963f2f0.ent)) {
    players = [level.weapdev.var_243b9e172963f2f0.ent];
    level.weapdev.var_243b9e172963f2f0 = undefined;
    return players;
  }

  if(getdvarint(@ "hash_13d8008e8edc58d5", -1) != -1) {
    entnum = int(getDvar(@ "hash_13d8008e8edc58d5"));
    setDvar(@ "hash_13d8008e8edc58d5", "<dev string:x40b>");
    return [level.players[entnum]];
  }

  if(isDefined(level.weapdev.var_ceefa46f8106bbca) && isDefined(level.weapdev.var_ceefa46f8106bbca.ent)) {
    return [level.weapdev.var_ceefa46f8106bbca.ent];
  }

  return level.players;
}

function function_7b72be42471b5133() {
  hostplayer = level.players[0];

  foreach(player in level.players) {
    if(player ishost()) {
      hostplayer = player;
      break;
    }
  }

  return hostplayer;
}

function function_b8745e837d180bbd() {
  startpos = self getEye();
  viewangles = self getplayerangles();
  fwd = anglesToForward(viewangles);
  endpos = startpos + fwd * 10000;
  playercontent = ["<dev string:x5b5>"];
  var_e1c801cb433b89d0 = physics_createcontents(playercontent);
  playertrace = trace::sphere_trace(startpos, endpos, 5, self, var_e1c801cb433b89d0, 0);
  traceent = playertrace["<dev string:x5d7>"];

  if(isPlayer(traceent)) {
    return traceent;
  }

  return undefined;
}

function function_96fffde153b023ff(params) {}

function function_d11a902aeffe8e8f(params) {
  if(level.weapdev.var_6792629e6cc7466) {
    thread function_723a97c59eb1c766();
  }
}

function function_723a97c59eb1c766() {
  player = self;
  player utility::waittill_any_timeout(1, "<dev string:x5e1>");

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(player)) {
    return;
  }

  if(isDefined(level.weapdev)) {
    if(isDefined(level.weapdev.players)) {
      entnum = self getentitynumber();

      if(isDefined(level.weapdev.players[entnum])) {
        if(isDefined(level.weapdev.players[entnum].spawnweapon)) {
          if(utility::issharedfuncdefined(#"dev", #"spawnweapon")) {
            player[[utility::getsharedfunc(#"dev", #"spawnweapon")]](level.weapdev.players[entnum].spawnweapon, 1, undefined);
            return;
          }

          player function_a56eb9ae7659b798(self.currentweapon, level.weapdev.players[entnum].spawnweapon, 1);
        }
      }
    }
  }
}

function function_e35a926b56357031(params) {
  function_8cd7608c8e337615(params);
}

function function_ae91286911ea949c(params) {
  function_8cd7608c8e337615(params);
}

function function_8cd7608c8e337615(params) {
  player = self;
  entnum = player getentitynumber();

  if(!isDefined(level.weapdev.players)) {
    level.weapdev.players = [];
  }

  if(entnum != 0) {
    return;
  }

  totalbots = 0;
  totalplayers = 0;

  foreach(idx, devplayer in level.weapdev.players) {
    var_fa3cf494395ea9e5 = level.players[idx];

    if(entnum != idx) {
      if(isbot(var_fa3cf494395ea9e5)) {
        totalbots++;
      }

      totalplayers++;
    }
  }

  if(totalbots > 2 || totalplayers > 5) {
    return;
  }

  var_d3f1f0f9cfae0fc8 = undefined;
  spawnweapon = undefined;

  if(isDefined(level.weapdev.players[entnum])) {
    if(isDefined(level.weapdev.players[entnum].var_dc909bd2150544fd)) {
      var_d3f1f0f9cfae0fc8 = level.weapdev.players[entnum].var_dc909bd2150544fd;
    }

    if(isDefined(level.weapdev.players[entnum].spawnweapon)) {
      spawnweapon = level.weapdev.players[entnum].spawnweapon;
    }
  }

  if(!isDefined(player) || player.isdisconnecting) {
    level.weapdev.players[entnum] = undefined;

    if(isDefined(var_d3f1f0f9cfae0fc8)) {
      pathtoremove = "<dev string:x193>" + "<dev string:x5fb>" + var_d3f1f0f9cfae0fc8;
      cmd = "<dev string:x611>" + pathtoremove + "<dev string:x624>";
      adddebugcommand(cmd + "<dev string:x629>");
    }

    return;
  }

  if(!(isDefined(params) && isDefined(params.weapon)) || !isweapon(params.weapon) || isnullweapon(params.weapon)) {
    return;
  }

  level.weapdev.players[entnum] = undefined;
  var_dc909bd2150544fd = player.name;

  if(isDefined(var_d3f1f0f9cfae0fc8) && var_dc909bd2150544fd != var_d3f1f0f9cfae0fc8) {
    pathtoremove = "<dev string:x193>" + "<dev string:x5fb>" + var_d3f1f0f9cfae0fc8;
    cmd = "<dev string:x611>" + pathtoremove + "<dev string:x624>";
    adddebugcommand(cmd + "<dev string:x629>");
  }

  prevweapon = weapon::getweaponrootname(params.lastweapon);
  curweapon = weapon::getweaponrootname(params.weapon);
  followweapon = weapon::getweaponrootname(spawnweapon);
  level.weapdev.players[entnum] = spawnStruct();
  level.weapdev.players[entnum].var_dc909bd2150544fd = var_dc909bd2150544fd;
  level.weapdev.players[entnum].spawnweapon = params.weapon;

  if(!isDefined(level.weapdev.attaches)) {
    level.weapdev.attaches = [];
  }

  devgui::function_9082edeb5db93280("<dev string:x193>" + "<dev string:x5fb>");

  if(isDefined(spawnweapon) && curweapon != followweapon) {
    if(level.weapdev.attaches.size > 0) {
      foreach(path in level.weapdev.attaches) {
        path = "<dev string:x193>" + "<dev string:x5fb>" + path;
        cmd = "<dev string:x611>" + path + "<dev string:x624>";
        adddebugcommand(cmd + "<dev string:x629>");
      }
    }
  }

  if(!isnullweapon(player.currentweapon)) {
    noaltweapon = player.currentweapon getnoaltweapon();
    defaultattachments = getweapondefaultattachments(player.currentweapon);

    if(isDefined(level.attachmentslotarray)) {
      var_1c6cd63de98ba7ee = arraycopy(level.attachmentslotarray);
      var_1c6cd63de98ba7ee[var_1c6cd63de98ba7ee.size] = "<dev string:x62e>";

      foreach(slot in var_1c6cd63de98ba7ee) {
        attachments = function_2e5ecdd8ac47f308(noaltweapon, slot, 1);

        foreach(attachmentname in attachments) {
          attachmentdataname = hashcat(%"hash_3c2c9813bb16552f", attachmentname);
          categorybundle = getscriptbundlefieldvalue(attachmentdataname, #"category");
          category = "<dev string:x24>";
          isdefaultattachment = 0;

          if(isDefined(categorybundle)) {
            category = getscriptbundlefieldvalue(categorybundle, #"ref");
          }

          foreach(attachment in defaultattachments) {
            if(attachment == attachmentname) {
              isdefaultattachment = 1;
              break;
            }
          }

          if(category != "<dev string:x24>") {
            if(!arraycontains(level.weapdev.attaches, category)) {
              level.weapdev.attaches[level.weapdev.attaches.size] = category;
            }

            if(isdefaultattachment) {
              path = category + "<dev string:x63a>" + attachmentname;
            } else {
              path = category + "<dev string:x1b6>" + attachmentname;
            }
          } else {
            if(!arraycontains(level.weapdev.attaches, slot)) {
              level.weapdev.attaches[level.weapdev.attaches.size] = slot;
            }

            if(isdefaultattachment) {
              path = slot + "<dev string:x63a>" + attachmentname;
            } else {
              path = slot + "<dev string:x640>" + attachmentname;
            }
          }

          devgui::add_devgui_command(path, "<dev string:x64a>" + entnum + "<dev string:x689>" + noaltweapon.basename + "<dev string:x416>" + attachmentname);
        }
      }
    }
  }

  devgui::function_77df7fe7dd273e10();
}

function function_cfa6895b527cb550(weaponobj, attachmentname) {
  var_b864fe801fd30f7a = weaponobj getnoaltweapon();
  attachmenttoidmap = var_b864fe801fd30f7a.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in attachmenttoidmap) {
    attachments[attachments.size] = attachment;
  }

  hasattachment = 0;

  if(arraycontains(attachments, attachmentname)) {
    hasattachment = 1;
  }

  return hasattachment;
}

function function_6ac230339288f89b(entnum) {
  if(!isDefined(level.weapdev.var_ceefa46f8106bbca)) {
    return 0;
  }

  if(!isDefined(level.weapdev.var_ceefa46f8106bbca.entnum)) {
    return 0;
  }

  return entnum == level.weapdev.var_ceefa46f8106bbca.entnum;
}

function function_e497e457bfd53f9f() {
  for(;;) {
    if(getDvar(@ "hash_eab5f19fea65c5c2", "<dev string:x24>") != "<dev string:x24>") {
      thread function_3db7a06bbdc83881();
    }

    if(getdvarint(@ "hash_19234cfdaa9d6a8b") != 0) {
      thread function_d44b12f71684a627();
    }

    waitframe();
  }
}

function function_5007e34ad8f974e6() {
  level.charmlist = [];
  struct = spawnStruct();
  struct.charmdata = % "weaponcharmsdata:";
  level.charmlist[level.charmlist.size] = struct;
  var_2d7f6fde86b5beb1 = getscriptbundle(level.projectbundle.charmslist).charmlist;

  foreach(charm in var_2d7f6fde86b5beb1) {
    if(isDefined(charm.charmdata)) {
      level.charmlist[level.charmlist.size] = charm;
    }
  }

  setdevdvarifuninitialized(@ "hash_b4dda58a659a339d", 0, 0, level.charmlist.size - 1);
  devgui::function_9082edeb5db93280("<dev string:x193>" + "<dev string:x6ab>");
  devgui::function_581b7f2e243b8ae4("<dev string:x6bf>", "<dev string:x6d1>");
  devgui::function_77df7fe7dd273e10();
  thread function_8c7a9cfdd076bd8c();
}

function function_8c7a9cfdd076bd8c() {
  currcharm = 0;
  charmname = "<dev string:x47c>";

  while(true) {
    var_3da5fb72e156ceb0 = getdvarint(@ "hash_b4dda58a659a339d");

    if(var_3da5fb72e156ceb0 != currcharm) {
      var_2d7f6fde86b5beb1 = level.charmlist;
      var_d09b52449f919e3e = var_2d7f6fde86b5beb1[var_3da5fb72e156ceb0].charmdata;
      tokens = strtok(getxhashsourcename(var_d09b52449f919e3e), "<dev string:x6f1>");
      charmname = tokens[1];

      if(0 == var_3da5fb72e156ceb0) {
        var_d09b52449f919e3e = undefined;
        charmname = "<dev string:x47c>";
      }

      foreach(player in level.players) {
        player function_9e65167f78d5842(var_d09b52449f919e3e);
      }

      currcharm = var_3da5fb72e156ceb0;
    }

    if(var_3da5fb72e156ceb0 > 0) {
      printtoscreen2d(10, 925, "<dev string:x6f6>", (1, 1, 1), 2);
      printtoscreen2d(10, 950, charmname, (1, 1, 1), 2);
    }

    waitframe();
  }
}

function function_9e65167f78d5842(charm) {
  objweapon = self getcurrentweapon();

  if(isnullweapon(objweapon)) {
    return;
  }

  newweaponobj = objweapon withcharm(charm);

  if(isnullweapon(newweaponobj) || newweaponobj == objweapon) {
    return;
  }

  self giveweapon(newweaponobj);
  self takeweapon(objweapon);
  self switchtoweaponimmediate(newweaponobj);
}

function function_3db7a06bbdc83881() {
  var_9e0a7c53714af77e = getDvar(@ "hash_eab5f19fea65c5c2");

  if(isDefined(getscriptbundle("<dev string:x70a>" + var_9e0a7c53714af77e))) {
    foreach(player in level.players) {
      player function_9e65167f78d5842(var_9e0a7c53714af77e);
    }
  }

  setdevdvar(@ "hash_eab5f19fea65c5c2", "<dev string:x24>");
}

function function_d44b12f71684a627() {
  foreach(player in level.players) {
    if(!player ishost()) {
      continue;
    }

    player forceweaponinspect();
  }

  setdevdvar(@ "hash_19234cfdaa9d6a8b", 0);
}

# /
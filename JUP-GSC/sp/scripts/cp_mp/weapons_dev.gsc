/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\weapons_dev.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace weapons_dev;

function function_b8a2a2faf79dc08e() {
  if(!isDefined(level.weapdev)) {
    level.weapdev = spawnStruct();
  }

  thread function_355de3fc37e0bd45();
  thread function_4770632c00748149();
  thread function_17cdeb7626afb432();
  level callback::add("<dev string:x1c>", &function_c7979dea29932f4e);
  level callback::add("<dev string:x2b>", &function_7973fcc15a7b9d52);
  level callback::add("<dev string:x3d>", &function_51eab65eec69);
  setdevdvar(@ "hash_588557f97f081a7e", "<dev string:x52>");
  setdevdvarifuninitialized(@ "hash_94cfa401914bb582", "<dev string:x52>");
}

function function_71d0871062111cb8(group) {
  class = undefined;

  if(isDefined(group)) {
    class = "<dev string:x53>";

    switch (group) {
      case #"hash_8af0086b038622b5":
        class = "<dev string:x67>";
        break;
      case #"hash_dd616da0b395a0b0":
        class = "<dev string:x83>";
        break;
      case #"hash_47368bc0d2ef1565":
        class = "<dev string:x9b>";
        break;
      case #"hash_bef5ec0b3e197ae":
        class = "<dev string:xaa>";
        break;
      case #"hash_86b11ac21f992552":
      case #"hash_a1f27f97be15d620":
        class = "<dev string:xc9>";
        break;
      case #"hash_34340d457a63e7f1":
        class = "<dev string:xdd>";
        break;
      case #"hash_9d18adab1b65a661":
        class = "<dev string:xf6>";
        break;
      case #"hash_16cf6289ab06bd30":
        class = "<dev string:x10e>";
        break;
      case #"hash_ab10f9c080fe4faf":
        class = "<dev string:x121>";
        break;
      case #"hash_c095d67337b1f5a1":
        class = "<dev string:x133>";
        break;
      case #"hash_2535634d8bb5c955":
        class = "<dev string:x148>";
        break;
    }
  }

  return class;
}

function function_355de3fc37e0bd45() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x14f>" + "<dev string:x163>");
  key_weapons = getarraykeys(level.weaponmapdata);
  sorted_weapons = scripts\engine\utility::array_sort_with_func(key_weapons, &function_86b38dd39a0aea86);

  for(i = 0; i < sorted_weapons.size; i++) {
    data = level.weaponmapdata[sorted_weapons[i]];
    weaponclass = function_71d0871062111cb8(data.group);

    if(isDefined(weaponclass)) {
      scripts\common\devgui::add_devgui_command(weaponclass + "<dev string:x16e>" + data.assetname, "<dev string:x170>" + data.assetname);
    }
  }

  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x14f>" + "<dev string:x1a1>");
  scripts\common\devgui::add_devgui_command("<dev string:x1b2>", "<dev string:x1c6>");
  scripts\common\devgui::add_devgui_command("<dev string:x1e8>", "<dev string:x203>");
  scripts\common\devgui::function_fe953f000498048f();
}

function function_86b38dd39a0aea86(a, b) {
  if(!isDefined(a)) {
    return 0;
  }

  if(!isDefined(b)) {
    return 1;
  }

  return stricmp(a, b) < 0;
}

function function_7aa60ff4574743(dvar, defaultvalue, func, isthreaded, unarchived) {
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

function function_56f3108c7ef4ae1d() {
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

function function_4770632c00748149() {
  function_7aa60ff4574743(@ "hash_5a6ac095cce29d6a", "<dev string:x22b>", &function_c8daabfa780ac4c6, 0, 0);
  function_7aa60ff4574743(@ "hash_b8fb8e495524a25c", "<dev string:x22d>", &function_fbfe774dd8a2b0a6, 0, 0);
  function_7aa60ff4574743(@ "hash_5d287f84a6f89b43", "<dev string:x22d>", &function_333a596bee56937d, 0, 0);
  function_7aa60ff4574743(@ "hash_61d2d8e5a629ef89", "<dev string:x22b>", &function_d214bc8897a77197, 0, 0);
  function_7aa60ff4574743(@ "hash_5e29683a6750ed67", "<dev string:x52>", &function_9a2bcf3ce7449979, 0, 0);
  function_7aa60ff4574743(@ "hash_c2957735560e95b2", "<dev string:x52>", &function_dd9d05980fc62610, 0, 0);
  thread function_56f3108c7ef4ae1d();
}

function function_9a2bcf3ce7449979(weaponname) {
  weapnew = weaponname;
  variant = -1;
  toks = strtok(weaponname, "<dev string:x230>");

  if(toks.size > 1) {
    weapnew = toks[0];
    variant = int(toks[1]);
  }

  if(isDefined(weapnew)) {
    var_8c78fd98c6c91e0f = scripts\cp_mp\weapon::getweaponrootname(weapnew);
    playerarray = function_2d7fd129a52dd44b();

    foreach(player in playerarray) {
      hasnvg = istrue(level.nightmap);
      var_c88b10f789adf8eb = scripts\cp_mp\weapon::buildweapon_blueprint(var_8c78fd98c6c91e0f, undefined, undefined, variant, undefined, undefined, hasnvg);
      currentweapon = player.currentweapon;
      player function_71bd21b34346c599(currentweapon, var_c88b10f789adf8eb, 0);
    }
  }
}

function function_dd9d05980fc62610(val) {
  if(isDefined(val)) {
    params = strtok(val, "<dev string:x232>");
    weaponobj = undefined;
    attachmentname = undefined;

    if(params.size > 1) {
      var_8c78fd98c6c91e0f = scripts\cp_mp\weapon::getweaponrootname(params[0]);
      hasnvg = istrue(level.nightmap);
      weaponobj = scripts\cp_mp\weapon::buildweapon_blueprint(var_8c78fd98c6c91e0f, undefined, undefined, -1, undefined, undefined, hasnvg);
      attachmentname = params[1];
    } else {
      attachmentname = params[0];
    }

    if(isDefined(attachmentname)) {
      playerarray = function_2d7fd129a52dd44b();

      foreach(player in playerarray) {
        currentweapon = player.currentweapon;

        if(!isDefined(weaponobj)) {
          weaponobj = currentweapon;
        }

        var_c88b10f789adf8eb = function_f3cafbcac7b5f838(weaponobj, attachmentname);

        if(!isDefined(var_c88b10f789adf8eb)) {
          if(!isbot(player)) {
            player iprintlnbold("<dev string:x234>" + attachmentname + "<dev string:x249>" + weaponobj.basename + "<dev string:x258>");
          }

          continue;
        }

        player function_71bd21b34346c599(currentweapon, var_c88b10f789adf8eb, 1);
      }
    }
  }
}

function function_f3cafbcac7b5f838(weaponobj, attachmentname) {
  var_b8ca516f1a797a1f = weaponobj getnoaltweapon();
  attachmenttoidmap = var_b8ca516f1a797a1f.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in attachmenttoidmap) {
    attachments[attachments.size] = attachment;
  }

  failed = !var_b8ca516f1a797a1f canuseattachment(attachmentname);

  if(failed) {
    return undefined;
  }

  attachments = scripts\cp_mp\weapon::weaponattachremoveextraattachments(attachments);
  var_7809ad191e44fe6a = [];

  foreach(idx, attachment in attachments) {
    var_7809ad191e44fe6a[idx] = attachmenttoidmap[attachment];
  }

  camo = var_b8ca516f1a797a1f.camo;
  stickers = [];

  if(isDefined(var_b8ca516f1a797a1f.stickerslot0)) {
    stickers[stickers.size] = var_b8ca516f1a797a1f.stickerslot0;
  }

  if(isDefined(var_b8ca516f1a797a1f.stickerslot1)) {
    stickers[stickers.size] = var_b8ca516f1a797a1f.stickerslot1;
  }

  if(isDefined(var_b8ca516f1a797a1f.stickerslot2)) {
    stickers[stickers.size] = var_b8ca516f1a797a1f.stickerslot2;
  }

  if(isDefined(var_b8ca516f1a797a1f.stickerslot3)) {
    stickers[stickers.size] = var_b8ca516f1a797a1f.stickerslot3;
  }

  if(isDefined(var_b8ca516f1a797a1f.var_b39ac546cc8621f8)) {
    stickers[stickers.size] = var_b8ca516f1a797a1f.var_b39ac546cc8621f8;
  }

  hasnvg = istrue(level.nightmap);
  attachment1slot = function_4add228b999c26aa(var_b8ca516f1a797a1f, attachmentname);
  replaced = 0;

  foreach(idx, a in attachments) {
    attachment2slot = function_4add228b999c26aa(var_b8ca516f1a797a1f, attachments[idx]);

    if(attachment1slot == attachment2slot && attachment1slot != "<dev string:x25b>") {
      attachments[idx] = attachmentname;
      replaced = 1;
    }
  }

  if(!replaced) {
    attachments[attachments.size] = attachmentname;
    var_7809ad191e44fe6a[var_7809ad191e44fe6a.size] = 0;
  }

  variantid = getweaponvariantindex(weaponobj);
  var_1558cf422ec0ea75 = scripts\cp_mp\weapon::buildweapon(scripts\cp_mp\weapon::getweaponrootname(weaponobj), attachments, camo, "<dev string:x261>", variantid, var_7809ad191e44fe6a, undefined, stickers, hasnvg);
  return var_1558cf422ec0ea75;
}

function function_71bd21b34346c599(currentweapon, var_c88b10f789adf8eb, giveammo) {
  player = self;
  player dropitem(currentweapon);

  if(player hasweapon(var_c88b10f789adf8eb)) {
    player dropitem(var_c88b10f789adf8eb);
  }

  player giveweapon(var_c88b10f789adf8eb);

  if(giveammo) {
    player setweaponammoclip(var_c88b10f789adf8eb, weaponclipsize(var_c88b10f789adf8eb));
    player setweaponammostock(var_c88b10f789adf8eb, weaponmaxammo(var_c88b10f789adf8eb));
  }

  player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_c88b10f789adf8eb);
  scripts\cp_mp\weapon::fixupplayerweapons(player, var_c88b10f789adf8eb);
}

function function_c8daabfa780ac4c6(entnum) {
  host = function_3b6bb4498000be82();
  target = host function_ba794adeb36ca952();

  if(!isDefined(target)) {
    return;
  }

  function_fbfe774dd8a2b0a6(target getentitynumber());
}

function function_fbfe774dd8a2b0a6(entnum) {
  entnum = int(entnum);

  if(!isDefined(level.players[entnum])) {
    iprintln("<dev string:x266>");
    return;
  }

  level.weapdev.var_3b3b12cc96932083 = spawnStruct();
  level.weapdev.var_3b3b12cc96932083.entnum = entnum;
  level.weapdev.var_3b3b12cc96932083.ent = level.players[entnum];
  iprintln("<dev string:x27d>" + level.weapdev.var_3b3b12cc96932083.ent.name);
}

function function_333a596bee56937d(entnum) {
  entnum = int(entnum);
  level.weapdev.var_4dc56e3237d18ff5 = spawnStruct();
  level.weapdev.var_4dc56e3237d18ff5.entnum = entnum;
  level.weapdev.var_4dc56e3237d18ff5.ent = level.players[entnum];
}

function function_d214bc8897a77197(dummy) {
  level.weapdev.var_3b3b12cc96932083 = undefined;
  iprintln("<dev string:x28d>");
}

function function_2d7fd129a52dd44b() {
  if(isDefined(level.weapdev.var_4dc56e3237d18ff5) && isDefined(level.weapdev.var_4dc56e3237d18ff5.ent)) {
    players = [level.weapdev.var_4dc56e3237d18ff5.ent];
    level.weapdev.var_4dc56e3237d18ff5 = undefined;
    return players;
  }

  if(getDvar(@ "hash_13d8008e8edc58d5", "<dev string:x22d>") != "<dev string:x22d>") {
    entnum = int(getDvar(@ "hash_13d8008e8edc58d5"));
    setDvar(@ "hash_13d8008e8edc58d5", "<dev string:x22d>");
    return [level.players[entnum]];
  }

  if(isDefined(level.weapdev.var_3b3b12cc96932083) && isDefined(level.weapdev.var_3b3b12cc96932083.ent)) {
    return [level.weapdev.var_3b3b12cc96932083.ent];
  }

  return level.players;
}

function function_3b6bb4498000be82() {
  hostplayer = level.players[0];

  foreach(player in level.players) {
    if(player ishost()) {
      hostplayer = player;
      break;
    }
  }

  return hostplayer;
}

function function_ba794adeb36ca952() {
  startpos = self getEye();
  viewangles = self getplayerangles();
  fwd = anglesToForward(viewangles);
  endpos = startpos + fwd * 10000;
  playercontent = ["<dev string:x2a4>"];
  var_30d537ea3164e799 = physics_createcontents(playercontent);
  playertrace = scripts\engine\trace::sphere_trace(startpos, endpos, 5, self, var_30d537ea3164e799, 0);
  traceent = playertrace["<dev string:x2c3>"];

  if(isDefined(traceent) && isPlayer(traceent)) {
    return traceent;
  }

  return undefined;
}

function function_c7979dea29932f4e(params) {}

function function_7973fcc15a7b9d52(params) {
  entnum = self getentitynumber();
  function_61f7f6b3f6c5c082(entnum);
}

function function_51eab65eec69(params) {
  entnum = self getentitynumber();
  function_61f7f6b3f6c5c082(entnum);
}

function function_68e5f0be62d590ef() {
  if(!isDefined(level.weapdev.players)) {
    level.weapdev.players = [];
  }
}

function function_61f7f6b3f6c5c082(entnum) {
  player = self;

  if(isbot(player)) {
    return;
  }

  if(!isDefined(level.weapdev.players)) {
    level.weapdev.players = [];
  }

  var_9c51960a22deee7f = undefined;

  if(isDefined(level.weapdev.players[entnum]) && isDefined(level.weapdev.players[entnum].var_3fe49be7e53a9302)) {
    var_9c51960a22deee7f = level.weapdev.players[entnum].var_3fe49be7e53a9302;
  }

  level.weapdev.players[entnum] = undefined;

  if(!isDefined(player) || istrue(player.isdisconnecting)) {
    if(isDefined(var_9c51960a22deee7f)) {
      pathtoremove = "<dev string:x14f>" + "<dev string:x2ca>" + var_9c51960a22deee7f;
      cmd = "<dev string:x2d9>" + pathtoremove + "<dev string:x2e9>";
      adddebugcommand(cmd + "<dev string:x2eb>");
    }

    return;
  }

  var_3fe49be7e53a9302 = player.name;

  if(isDefined(var_9c51960a22deee7f) && var_3fe49be7e53a9302 != var_9c51960a22deee7f) {
    pathtoremove = "<dev string:x14f>" + "<dev string:x2ca>" + var_9c51960a22deee7f;
    cmd = "<dev string:x2d9>" + pathtoremove + "<dev string:x2e9>";
    adddebugcommand(cmd + "<dev string:x2eb>");
  }

  level.weapdev.players[entnum] = spawnStruct();
  level.weapdev.players[entnum].var_3fe49be7e53a9302 = var_3fe49be7e53a9302;
  var_84850b87803d306 = "<dev string:x14f>" + "<dev string:x2ca>" + var_3fe49be7e53a9302 + "<dev string:x2ed>" + entnum + "<dev string:x16e>";
  scripts\common\devgui::function_6e7290c8ee4f558b(var_84850b87803d306);

  if(!isnullweapon(player.currentweapon)) {
    noaltweapon = player.currentweapon getnoaltweapon();
    weaponpath = noaltweapon.basename + "<dev string:x2ef>";
    path = weaponpath + "<dev string:x2f3>";
    scripts\common\devgui::add_devgui_command(path, "<dev string:x2ff>" + entnum + "<dev string:x33b>" + noaltweapon.basename);

    foreach(slot in level.var_c7008cff883cd615) {
      if(slot == "<dev string:x356>") {
        continue;
      }

      attachments = function_75b035199842693d(noaltweapon, slot);

      foreach(attachmentname in attachments) {
        attachmentdataname = hashcat(%"hash_3c2c9813bb16552f", attachmentname);
        category = getscriptbundlefieldvalue(attachmentdataname, #"category");

        if(isDefined(category)) {
          path = weaponpath + category + "<dev string:x16e>" + attachmentname;
        } else {
          path = weaponpath + slot + "<dev string:x16e>" + attachmentname;
        }

        scripts\common\devgui::add_devgui_command(path, "<dev string:x2ff>" + entnum + "<dev string:x35d>" + noaltweapon.basename + "<dev string:x232>" + attachmentname);
      }
    }
  }

  scripts\common\devgui::add_devgui_command("<dev string:x37c>", "<dev string:x38e>" + entnum, 100);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_92cc0e279ea9f719(weaponobj, attachmentname) {
  var_b8ca516f1a797a1f = weaponobj getnoaltweapon();
  attachmenttoidmap = var_b8ca516f1a797a1f.attachmentvarindices;
  attachments = [];

  foreach(id in attachmenttoidmap) {
    attachments[attachments.size] = attachment;
  }

  hasattachment = 0;

  if(scripts\engine\utility::array_contains(attachments, attachmentname)) {
    hasattachment = 1;
  }

  return hasattachment;
}

function function_b263d5c9745dc016(entnum) {
  if(!isDefined(level.weapdev.var_3b3b12cc96932083)) {
    return 0;
  }

  if(!isDefined(level.weapdev.var_3b3b12cc96932083.entnum)) {
    return 0;
  }

  return entnum == level.weapdev.var_3b3b12cc96932083.entnum;
}

function function_17cdeb7626afb432() {
  for(;;) {
    if(getDvar(@ "hash_588557f97f081a7e") != "<dev string:x52>") {
      thread function_416220a2493c9ec();
    } else if(getDvar(@ "hash_94cfa401914bb582") != "<dev string:x52>") {
      thread function_72bdcbf68a00d590();
    }

    waitframe();
  }
}

function function_416220a2493c9ec() {
  variantid = 0;
  blueprintname = getDvar(@ "hash_588557f97f081a7e");
  weapon = getweaponrootname(blueprintname);
  weaponasset = undefined;

  if(isDefined(level.weaponmapdata[weapon])) {
    weaponasset = level.weaponmapdata[weapon].assetname;
  }

  weaponblueprint = function_40fd49171fad19d3(blueprintname);

  if(isDefined(weaponasset)) {
    weaponvariants = getweaponblueprintnames(weaponasset);

    foreach(id in weaponvariants) {
      if(weaponblueprint == variant) {
        foreach(player in level.players) {
          variantid = id;
          hasnvg = istrue(level.nightmap);
          var_c88b10f789adf8eb = scripts\cp_mp\weapon::buildweapon_blueprint(weapon, undefined, undefined, variantid, undefined, undefined, hasnvg);
          currentweapon = player.currentweapon;
          player.droppeddeathweapon = undefined;

          if(issharedfuncdefined("<dev string:x3ad>", "<dev string:x3b5>")) {
            player thread[[getsharedfunc("<dev string:x3ad>", "<dev string:x3b5>")]](undefined, "<dev string:x52>");
          }

          player.droppeddeathweapon = undefined;

          if(player hasweapon(var_c88b10f789adf8eb)) {
            player _takeweapon(var_c88b10f789adf8eb);
          }

          if(scripts\common\utility::iscp()) {
            player scripts\cp_mp\utility\inventory_utility::_takeweapon(currentweapon);
          }

          var_c88b10f789adf8eb = var_c88b10f789adf8eb function_7e483d6e6b4b5688(id);
          player giveweapon(var_c88b10f789adf8eb);
          player setweaponammoclip(var_c88b10f789adf8eb, weaponclipsize(var_c88b10f789adf8eb));
          player setweaponammostock(var_c88b10f789adf8eb, weaponmaxammo(var_c88b10f789adf8eb));
          player _switchtoweaponimmediate(var_c88b10f789adf8eb);
          scripts\cp_mp\weapon::fixupplayerweapons(player, weapon);
        }

        break;
      }
    }
  }

  setdevdvar(@ "hash_588557f97f081a7e", "<dev string:x52>");
}

function function_72bdcbf68a00d590() {
  camo = getDvar(@ "hash_94cfa401914bb582");

  if(isDefined(camo) && camo != "<dev string:x52>") {
    camolist = [];

    for(rowindex = 0; tablelookupbyrow("<dev string:x3c8>", rowindex, 1) != "<dev string:x52>"; rowindex++) {
      camolist[camolist.size] = tablelookupbyrow("<dev string:x3c8>", rowindex, 1);
    }

    foreach(player in level.players) {
      weapon = player.currentweapon;
      player dropitem(weapon);
      weapon = weapon getnoaltweapon();
      camoindex = int(camo);

      if(camoindex < camolist.size) {
        weapon = weapon withcamo(camolist[camoindex]);
      } else {
        weapon = weapon withoutcamo();
      }

      player giveweapon(weapon);
      player setweaponammoclip(weapon, weaponclipsize(weapon));
      player setweaponammostock(weapon, weaponmaxammo(weapon));
      player _switchtoweaponimmediate(weapon);
    }
  }

  setdevdvar(@ "hash_94cfa401914bb582", "<dev string:x52>");
}

# /
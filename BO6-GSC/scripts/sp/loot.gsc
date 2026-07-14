/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\loot.gsc
**************************************/

#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\script_items;
#using scripts\sp\utility;
#namespace loot;

function init() {
  setdvarifuninitialized(@ "hash_7dfe19d75d304409", 0);

  setdvarifuninitialized(@ "hash_759557e6189ead37", "<dev string:x24>");

  if(!isDefined(level.loot)) {
    level.loot = spawnStruct();
  }

  level.loot.types = [];
  level.loot.notifications = [];
  level.loot.classexceptions = [];
  level.loot.lastloottime = 0;
  level.loot.spawntags = ["$\x9b\xd1\xd1(A\x8c@f\x80\xf6\xfd"];
  level.loot.sfx = utility::spawn_script_origin(level.player.origin);
  level.loot.sfx linkTo(level.player);
  level.loot.offhands = [];
  level.loot.primaryweapons = [];
  level.loot.ammo_types = [];
  level.loot.pickupgesture = undefined;
  level.loot.resourcetypes = [];
  level.loot.wheelweapons = undefined;
  level.loot.probability = [];
  level.loot.probability["\x11\xca\xcc\v\xab\xd8:"] = undefined;
  level.loot.probability["\x12\x89\xc9I\x96$\x8f"] = &probabilityoffhand;
  level.loot.probability["\a\xb3H\xeed\x82\x1e\xce\xa0q0S"] = &probabilityoffhandwheel;
  level.loot.probability["\xe5\x14\x16\xc5\xc8"] = &probabilityzero;
  level.loot.probability["P\xe4m\xdb\x9c\xf4s\x11\xb2m\vs\x91"] = &function_8247fb1a0e7ba828;
  level.loot.probability["\xb5\x86\x8b=\xaaPu\xa9>\xbfv"] = &probabilityarmorneeded;
  level.loot.probability["v\x1c\xf4aa\xbf\xa6\xc0@\xfaNn\xb5"] = &function_58e1c43b94dfb591;
  level.loot.lootfuncs = [];
  level.loot.lootfuncs["\f+x5"] = [ &donothing, &inactive];
  level.loot.lootfuncs["\xddB\x84D"] = [ &lootammo, &inactiveplayermaxammo];
  level.loot.lootfuncs["\x1f\xa5P\x94ls\x11\xc9D!\xf2"] = [ &lootammorestock, &inactiveammorestock];
  level.loot.lootfuncs["K`K}1\xa7\xeb("] = [ &lootammopool, undefined];
  level.loot.lootfuncs["\xf3~{\xb1\x14"] = [ &lootarmor, &inactiveplayermaxarmor];
  level.loot.lootfuncs["\xe1\xdc\xdc\x8d#\xafI\x93\xf8"] = [ &lootarmorvest, &function_d000d246d525d29b];
  level.loot.lootfuncs["\x12\x89\xc9I\x96$\x8f"] = [ &lootoffhand, &inactiveoffhand];
  level.loot.lootfuncs["\n\xfc\xf6\xe6t\xe3{\xddF\xb0"] = [ &function_505a7281acdf1fb3, &function_6e81a37dc8596cc4];
  level.loot.lootfuncs["\xe5WI\xf1\\y\x11\x03T'\xf3\xe8\xb5"] = [ &lootprimaryweapon, &inactive];
  level.loot.lootfuncs["m\xb8\xd7\x99\x19\xcd\xa6\x14"] = [ &lootresource, undefined];
  level.loot.lootfuncs["\x1e\xfc:\x10\x8c\xff)\nQ4"] = [ &lootcontraband, undefined];
  level.loot.lootfuncs["\"Ok\xfd\xf6\x7f\x16"] = [ &lootgeneral, undefined];
  level.loot.lootfuncs["\"\x94\x9d\x9c\x81\x04\xce\x1a'5"] = [ &lootattachment, undefined];
  level.loot.lootfuncs["\v\xb5P\xd3\x10\xc6\x80]\xa0\x98"] = [ &lootconsumable, undefined];
  level.loot.prespawnfuncs["v\x1c\xf4aa\xbf\xa6\xc0@\xfaNn\xb5"] = &function_9f195bcc2ee74a33;
  level.loot.lastspawntime = [];

  if(isDefined(level.gamemodebundle)) {
    function_20b1e0a7ce7bee1e(level.gamemodebundle.campaignlootlist);
  }

  if(utility::playerarmorenabled()) {
    thread updatearmordroptimer();
  }

  thread setworldloot();
  level thread function_d823113d922c73f9();
  level thread function_393f7eea73e67b6();
  level.loot.droppedweapons = [];
  level.loot.droppeditems = [];
  level.loot.lootall = [];

  if(!isDefined(level.loot.autopickup)) {
    level.loot.autopickup = [];
  }

  utility::registersharedfunc(#"loot", #"dropweapon", &ondropweapon);
  utility::registersharedfunc(#"loot", #"dropitem", &ondropitem);

  if(level.loot.lootpresent == "\xe5c\x0f\x18X,h\x1f\a") {
    utility::registersharedfunc(#"loot", #"dropWeaponPost", &ondropweaponpost);
  }

  utility::registersharedfunc(#"game", #"spawnnewitem", &spawnlootitem);
  setdvarifuninitialized(@ "hash_d746cc65cda5dd48", 0.2);
  level.player thread function_b123a1c1f86ebef6();
  val::register("xh\xf2J\xc3\x166\xc5\x9dz\x88P\x99\x8f", 1, 0);
  scene::function_f0326a3dac1e025a("T^\x83\xca7\xeb\n6a\xcber", "xh\xf2J\xc3\x166\xc5\x9dz\x88P\x99\x8f", 0);

  thread function_12be0b72ffed3a1e();
}

function function_20b1e0a7ce7bee1e(campaignlootlistname) {
  if(!isDefined(campaignlootlistname)) {
    return;
  }

  level.loot.types = [];
  level.loot.classexceptions = [];
  level.loot.pickupgesture = undefined;
  level.loot.wheelweapons = undefined;
  level.loot.offhandswap = undefined;
  level.loot.var_5f580e70140f0241 = undefined;
  bundlelist = getscriptbundle("\x87eX\xbaayH\xa4h~{\xf4mk9\x16\xf8" + campaignlootlistname);

  if(isDefined(bundlelist)) {
    level.loot.armorplateweapon = bundlelist.armorplateweapon;
    level.loot.armorplateoffhand = bundlelist.armorplateoffhand;
    level.loot.var_7d19d42036e22ee3 = bundlelist.var_7d19d42036e22ee3;
    level.loot.pickupgesture = bundlelist.pickupgesture;
    level.loot.splashwidget = bundlelist.pickupwidget;
    level.loot.lootpresent = bundlelist.lootpresent ?? "\x11\xca\xcc\v\xab\xd8:";
    level.loot.offhandswap = bundlelist.offhandswap ?? undefined;
    level.loot.physicsdelay = bundlelist.physicsdelay;
    level.loot.var_5f580e70140f0241 = bundlelist.var_5f580e70140f0241 ?? undefined;
    cursorhintbundlename = bundlelist.cursorhintbundle ?? "\xdd\xfc\xbc\x182a\xb1CM\xc99$\x01\x96\xfa\xfb\xc9\xd4\x9e5\x1c";
    level.loot.var_1d7747e9521cf370 = getscriptbundle("\xd8\xea'n\xb7\xe4hi\x9b\x1d:" + cursorhintbundlename);
    level.loot.var_c9a7590cf97bdd19 = [];

    if(isDefined(bundlelist.var_c9a7590cf97bdd19)) {
      temp = [];

      foreach(struct in bundlelist.var_c9a7590cf97bdd19) {
        temp[temp.size] = getscriptbundlefieldvalue("\xbc5\xd1a\xacW\x84\xe0}S\x87\xd6\x84" + struct.loot, #"name_id");
      }

      level.loot.var_c9a7590cf97bdd19 = temp;
      temp = undefined;
    }

    var_9f713c67ed872f4e = (bundlelist.var_bc7ef46ad101aac1 ?? 0, bundlelist.var_e78c5bbbe150b50a ?? 0, bundlelist.var_7c38be631d302037 ?? 0);
    setsaveddvar(@ "hash_4f51f346f5292b74", var_9f713c67ed872f4e);

    if(isDefined(bundlelist.exceptions)) {
      foreach(exception in bundlelist.exceptions) {
        if(isDefined(exception.classname)) {
          level.loot.classexceptions[exception.classname] = 1;
        }
      }
    }

    if(isDefined(bundlelist.lootlist)) {
      level.loot.maxloot = bundlelist.maxloot ?? 25;
      level.loot.maxweapons = bundlelist.maxweapons ?? 25;
      listindex = -1;

      foreach(lootlistitem in bundlelist.lootlist) {
        lootbundle = getscriptbundle("\xbc5\xd1a\xacW\x84\xe0}S\x87\xd6\x84" + lootlistitem.loot);
        listindex++;

        if(!isDefined(lootbundle)) {
          continue;
        }

        probabilitytype = lootbundle.probability;
        probabilityfunc = level.loot.probability[probabilitytype ?? "\x11\xca\xcc\v\xab\xd8:"];
        lootfuncstype = lootbundle.lootfunc;
        lootfuncs = level.loot.lootfuncs[lootfuncstype ?? "\f+x5"];
        prespawnfunc = undefined;
        prespawnfunctype = lootbundle.prespawnfunctype ?? undefined;

        if(isDefined(prespawnfunctype)) {
          prespawnfunc = level.loot.prespawnfuncs[prespawnfunctype];
        }

        backpackmaxstacksize = lootbundle.backpackslotamountmax;
        lootid = lootbundle.lootid;
        name = registerloot(lootbundle, lootfuncs[0], lootfuncs[1], probabilityfunc, undefined, prespawnfunc, backpackmaxstacksize, lootid);
        assert(isDefined(name));
        level.loot.types[name].listindex = listindex;
      }
    }

    if(isDefined(bundlelist.equipmentwheel)) {
      wheeltable = getscriptbundle("gH+\x83]\xf7\x91Bo\xad\xe3P\xc0\x19\xf1\xdegGNxv\x0e\xaa\xa3\x06`\xe5\xc5" + bundlelist.equipmentwheel);

      if(isDefined(wheeltable)) {
        level.loot.wheelweapons = [];

        foreach(item in wheeltable.var_f7668fe6431f6431) {
          itembundle = getscriptbundle("\xcdh6\t\xb6\xef\xb7\xde\x7f\xdb\xd0\xa2\x012\x18M\xcd\x185\x01\xb2\xf9g\x1a" + item.bundle);

          if(isDefined(itembundle.equipmentitemref) && itembundle.equipmentitemref != "\r+x5") {
            level.loot.wheelweapons[itembundle.equipmentitemref] = itembundle.equipmentitemref;
          }
        }
      }
    }
  }

  level.player notify("\x94\x95\xf0\x1f1\xac\x85l<M\x82\xa1\xfc\xf9\xedP\t\xfd\xf0\xde\xf8\xca\x05\xbc4");
}

function private function_b123a1c1f86ebef6() {
  self notify("\x86\xcb\xbfm\\\x84\xb3[\xaf\x8c6Gl\x89hA");
  self endon("\x86\xcb\xbfm\\\x84\xb3[\xaf\x8c6Gl\x89hA");
  assert(isPlayer(self));
  player = self;

  while(true) {
    player waittill("\x0e\x8f(A>'\x17=0\nw", amount, ammo, weapclass);

    if(getdvarint(@ "hash_7dfe19d75d304409", 0)) {
      iprintlnbold("<dev string:x28>" + (weapclass ?? "<dev string:x37>") + "<dev string:x44>" + amount);
    }

    poolname = undefined;

    if(isstring(weapclass)) {
      poolname = function_cee2e72dc24da568(weapclass);
    }

    if(!isstring(poolname) || !isDefined(level.loot.types[poolname])) {
      poolname = undefined;

      if(isDefined(level.loot.types["\x99\x13\xcb+\xb2\x1c\x0f[R\x1f\x86X"])) {
        poolname = "\x99\x13\xcb+\xb2\x1c\x0f[R\x1f\x86X";
      }
    }

    if(isstring(poolname)) {
      dummyitem = spawnStruct();
      dummyitem.script_count = amount;
      dummyitem thread lootnotification(poolname);
    }
  }
}

function corpselootthink() {
  if(!cancarryloot()) {
    return;
  }

  self waittill("\x1e\xfd\xd1\xa2\a", attacker);

  if(!shoulddroploot(attacker)) {
    return;
  }

  spawncorpseloot();
}

function cancarryloot() {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(level.loot)) {
    return false;
  }

  if(self.team != "?\xb1\xc0\x9a") {
    return false;
  }

  if(istrue(level.loot.classexceptions[self.classname]) || istrue(level.loot.classexceptions[self.unittype])) {
    return false;
  }

  return true;
}

function shoulddroploot(attacker) {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(level.loot)) {
    return false;
  }

  if(!utility_sp::playerlootenabled()) {
    return false;
  }

  if(indonotspawnlootvolume(self)) {
    return false;
  }

  if(force_armor_drop()) {
    return true;
  }

  if(istrue(self.alwaysloot)) {
    return true;
  }

  if(istrue(self.noloot)) {
    return false;
  }

  if(attacker != level.player) {
    return false;
  }

  if(isDefined(self.nodrop)) {
    return false;
  }

  return true;
}

function onspawnloot() {
  self.loot = [];

  foreach(name, type in level.loot.types) {
    if(isDefined(level.loot.types[name].onspawnfunc) && isDefined(level.loot.types[name].probabilityfunc)) {
      if([[level.loot.types[name].probabilityfunc]](name, self.origin)) {
        self thread[[level.loot.types[name].onspawnfunc]]();
        self.loot[name] = 1;
      }
    }
  }
}

function function_5a473b51b0aa77d1(name, lootfunc, inactivefunc, promptupdate, probabilityfunc, onspawnfunc) {
  if(!isDefined(level.loot.types[name])) {
    return;
  }

  level.loot.types[name].lootfunc = lootfunc;
  level.loot.types[name].inactivefunc = inactivefunc;
  level.loot.types[name].promptupdate = promptupdate;
  level.loot.types[name].probabilityfunc = probabilityfunc;
  level.loot.types[name].onspawnfunc = onspawnfunc;
}

function registerloot(loot, lootfunc, inactivefunc, probabilityfunc, onspawnfunc, prespawnfunc, backpackmaxstacksize, lootid) {
  name = loot.name_id;

  if(!isstring(name) || name == "") {
    name = "\x13\\_\xd4" + level.loot.types.size + 1;
  }

  if(isDefined(loot.model) && isDefined(loot.xcompositemodel)) {
    assertmsg("<dev string:x4b>" + name + "<dev string:x58>");
  }

  loot.model = loot.model ?? loot.xcompositemodel;
  createnotification = loot.hudnotify ?? 1;
  interactoffset = (loot.interactoffsetx ?? 0, loot.interactoffsety ?? 0, loot.interactoffsetz ?? 0.5);

  if(isDefined(level.loot.types[name])) {
    assertmsg("<dev string:x8e>" + name);
  }

  level.loot.types[name] = spawnStruct();
  level.loot.types[name].type = loot.type ?? "\"Ok\xfd\xf6\x7f\x16";
  level.loot.types[name].image = loot.image;
  level.loot.types[name].shader = loot.shader;
  level.loot.types[name].loc = loot.name;
  level.loot.types[name].model = loot.model;
  level.loot.types[name].modellooted = loot.modellooted;
  level.loot.types[name].sound = loot.interactsound;
  level.loot.types[name].rumble = loot.interactrumble;
  level.loot.types[name].weapon = loot.weapongrenade;
  level.loot.types[name].weaponprimary = loot.weaponprimary;
  level.loot.types[name].ammoname = loot.ammoname;
  level.loot.types[name].hinttake = loot.hinttake;
  level.loot.types[name].hintswap = loot.hintswap;
  level.loot.types[name].hintinactive = loot.hintinactive;
  level.loot.types[name].chance = float(loot.probabilitychance ?? 40);
  level.loot.types[name].requireuse = istrue(loot.requireuse);
  level.loot.types[name].infiniteuse = istrue(loot.infiniteuse);
  level.loot.types[name].takedownstyle = loot.takedownstyle;
  level.loot.types[name].prespawnfunc = prespawnfunc;
  level.loot.types[name].createnotification = createnotification;
  level.loot.types[name].lootfunc = lootfunc;
  level.loot.types[name].inactivefunc = inactivefunc;
  level.loot.types[name].probabilityfunc = probabilityfunc;
  level.loot.types[name].onspawnfunc = onspawnfunc;
  level.loot.types[name].interactoffset = interactoffset;
  level.loot.types[name].index = level.loot.types.size;
  level.loot.types[name].groundoffsetz = loot.groundoffsetz;
  level.loot.types[name].groundpitch = loot.groundpitch;
  level.loot.types[name].resourceamount = loot.resourceamount;
  level.loot.types[name].resourceamountmax = loot.resourceamountmax;
  level.loot.types[name].resourceamountinterval = loot.resourceamountinterval;
  level.loot.types[name].backpackmaxstacksize = backpackmaxstacksize;
  level.loot.types[name].lootid = lootid;

  if(loot.type === "m\xb8\xd7\x99\x19\xcd\xa6\x14" && isDefined(loot.ammoname)) {
    level.loot.resourcetypes[loot.ammoname] = loot.ammoname;
  }

  if(isDefined(loot.name)) {
    precachestring(loot.name);
  }

  if(isDefined(loot.hinttake)) {
    precachestring(loot.hinttake);
  }

  if(isDefined(loot.hintswap)) {
    precachestring(loot.hintswap);
  }

  if(isDefined(loot.model)) {
    precachemodel(loot.model);
  }

  if(isDefined(loot.modellooted)) {
    precachemodel(loot.modellooted);
  }

  if(isDefined(loot.shader)) {
    precacheshader(loot.shader);
  }

  return name;
}

function function_ad6326ebbced72ab(name, scale) {
  if(!isDefined(level.loot.resourcescale)) {
    level.loot.resourcescale = [];
  }

  if(!isDefined(level.loot.resourcescale[name])) {
    level.loot.resourcescale[name] = [];
  }

  level.loot.resourcescale[name][level.loot.resourcescale[name].size] = {
    #scale: scale, #time: gettime()
  };
}

function overrideloot(name, sound, lootfunc, inactivefunc, probabilityfunc, weaponname) {
  if(!isDefined(level.loot.types[name])) {
    assertmsg("<dev string:xaa>" + name + "<dev string:xc8>");
    return;
  }

  level.loot.types[name].sound = sound;
  level.loot.types[name].lootfunc = lootfunc;
  level.loot.types[name].inactivefunc = inactivefunc;
  level.loot.types[name].probabilityfunc = probabilityfunc;
  level.loot.types[name].weapon = weaponname;
}

function overridelootcallbacks(name, lootfunc, inactivefunc) {
  if(!isDefined(level.loot.types[name])) {
    assertmsg("<dev string:xaa>" + name + "<dev string:xc8>");
    return;
  }

  if(isDefined(lootfunc)) {
    level.loot.types[name].lootfunc = lootfunc;
  }

  if(isDefined(inactivefunc)) {
    level.loot.types[name].inactivefunc = inactivefunc;
  }
}

function deregisterloot(name) {
  level.loot.types[name] = undefined;
  level.loot.types = utility::array_remove_key(level.loot.types, name);
}

function removeoffhandloot(offhand) {
  assert(isDefined(level.loot), "<dev string:xcd>");

  if(isstring(offhand)) {
    weaponname = offhand;
  } else {
    weaponname = offhand.basename;
  }

  key = offhands::getweaponoffhandtype(weaponname);

  if(isDefined(level.loot.offhands[key])) {
    level.loot.offhands = utility::array_remove_key(level.loot.offhands, key);
  }

  level.player notify("\xcdY4\x11\xcfAx\x81\xbah\x83\xa5.\xa2\"\x1bt\xfc\xa0");
}

function setoffhandloot(offhand) {
  assert(isDefined(level.loot), "<dev string:x108>");

  if(isstring(offhand)) {
    weaponname = offhand;
  } else {
    weaponname = offhand.basename;
  }

  key = offhands::getweaponoffhandtype(weaponname);

  if(isDefined(level.loot.offhands[key])) {
    level.loot.offhands = utility::array_remove_key(level.loot.offhands, key);
  }

  level.loot.offhands[key] = weaponname;
  level.player notify("\xcdY4\x11\xcfAx\x81\xbah\x83\xa5.\xa2\"\x1bt\xfc\xa0");
}

function updatearmordroptimer() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level.loot.lastdroppedarmortime = -2000;
  level.loot.armordroptimer = 0;

  while(true) {
    if(level.player enemynearplayer() && !level.player player_sp::hasarmor()) {
      level.loot.armordroptimer += 0.05;
    }

    waitframe();
  }
}

function enemynearplayer() {
  foreach(enemy in getaiarray("?\xb1\xc0\x9a")) {
    if(distancesquared(self.origin, enemy.origin) <= 1048576) {
      return true;
    }
  }

  return false;
}

function private function_232b60f07fb2ac77(lootarray, droppedent, limit) {
  if(!isDefined(droppedent)) {
    return;
  }

  entid = droppedent getentitynumber();
  lootarray[entid] = droppedent;

  if(lootarray.size <= limit) {
    return lootarray;
  }

  lootarray = utility::array_removeundefined(lootarray, 1);

  if(lootarray.size <= limit) {
    return lootarray;
  }

  sortedarray = sortbydistance(lootarray, level.player.origin);
  fallbackitem = undefined;

  for(i = sortedarray.size - 1; i >= 0; i--) {
    item = sortedarray[i];

    if(level.player math::point_in_fov(item.origin)) {
      if(!isDefined(fallbackitem)) {
        fallbackitem = item;
      }

      continue;
    }

    worstitem = item;
    worstitemkey = item getentitynumber();
    worstitem cleanuplootorweaponitem();
    lootarray[worstitemkey] = undefined;
    fallbackitem = undefined;

    if(lootarray.size <= limit) {
      break;
    }
  }

  if(isDefined(fallbackitem)) {
    worstitemkey = fallbackitem getentitynumber();
    fallbackitem cleanuplootorweaponitem();
    lootarray[worstitemkey] = undefined;
  }

  return lootarray;
}

function private ondropweapon(weaponent) {
  level.loot.droppedweapons = function_232b60f07fb2ac77(level.loot.droppedweapons, weaponent, level.loot.maxweapons);
}

function private ondropitem(itement) {
  level.loot.droppeditems = function_232b60f07fb2ac77(level.loot.droppeditems, itement, level.loot.maxloot);
}

function private ondropweaponpost(weapon) {
  assert(level.loot.lootpresent == "<dev string:x140>");

  if(!isent(weapon)) {
    return;
  }

  weapon makeunusable();
  weapon endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  weapon.var_e703a981d06a1192 = 1;

  if(isent(weapon.cursor_hint_ent)) {
    weapon.cursor_hint_ent delete();
    weapon.cursor_hint_ent = undefined;
  }

  weapon function_53d48c75649d729();

  if(isent(weapon.cursor_hint_ent)) {
    weapon.cursor_hint_ent delete();
    weapon.cursor_hint_ent = undefined;
  }

  weapon notify("\xc3\x11$U%\xb3\xf3\xfb\x89\xb9.\x96\x8ap\xef|\x96\xbft\x85\xa5Y");
  weapon.hinttypeoverride = "fpP%W7Uj\xeb\x815";
  weapon cursor_hint::function_c63b4e299f9d1e4("\x8durs\xb7\xe4\xd0\xa57\x1d\xd7\xbb+X8\xdb\xcd8-\xd8k]\xc1", undefined, undefined, undefined, undefined, 1);
  weapon makeusable();

  if(isent(weapon.cursor_hint_ent)) {
    weapon thread utility::delete_on_death(weapon.cursor_hint_ent);
  }

  hintent = isDefined(weapon.cursor_hint_ent) ? weapon.cursor_hint_ent : weapon;
  level.player thread function_ca8c8f0a131bf9e8(weapon, hintent);
}

function private function_ca8c8f0a131bf9e8(weapon, hintent) {
  hintent endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");
  weaponinfo = weapon function_828ff62b0fea4793();
  ammoname = player_sp::getammoname(weaponinfo);

  while(true) {
    while(hintent isusable() && self hasweapon(weaponinfo)) {
      if(player_sp::getammonameamount(ammoname) >= weaponinfo.maxammo) {
        hintent sethintinoperable(1);
      } else {
        hintent sethintinoperable(0);
      }

      waitframe();
    }

    if(hintent isusable()) {
      hintent sethintinoperable(0);
    }

    self waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
  }
}

function spawncorpseloot() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.loot)) {
    self.loot = [];
  }

  spawnpool = getspawnpool(undefined, undefined, 1);
  itemcount = self.loot.size;
  itemindex = 0;

  if(spawnpool.size > 0) {
    spawnpool = utility::array_randomize(spawnpool);
  }

  while(itemcount < 4 && spawnpool.size > itemindex) {
    name = spawnpool[itemindex];
    tag = level.loot.spawntags[randomint(level.loot.spawntags.size)];
    origin = self gettagorigin(tag);
    origin += rotatevector((1, 0, 0) * randomfloatrange(5, 20), (0, randomfloat(360), 0));
    origin = getgroundposition(origin, 1);

    if(getdvarint(@ "hash_7dfe19d75d304409", 0)) {
      iprintln("<dev string:x14d>" + name);
    }

    usephysicsimpulse = undefined;

    if(isDefined(level.loot.types[name].groundoffsetz)) {
      origin = (origin[0], origin[1], origin[2] + level.loot.types[name].groundoffsetz);
      usephysicsimpulse = 0;
    }

    angles = undefined;

    if((level.loot.types[name].groundpitch ?? -180) > -180) {
      angles = (level.loot.types[name].groundpitch, randomfloatrange(-180, 180), 0);
    }

    item = spawnlootitem(name, origin, angles, 685, 0, 0, undefined, usephysicsimpulse);

    if(isDefined(item) && isDefined(self.var_5a82d6263130177c)) {
      self[[self.var_5a82d6263130177c]](name, item);
    }

    itemcount++;
    itemindex++;
  }
}

function getspawnpool(typefilter, fallbacklootname, debugdisplay) {
  if(isDefined(typefilter) && !isarray(typefilter)) {
    typefilter = [typefilter];
  }

  spawnpool = [];

  foreach(name, loottype in level.loot.types) {
    if(isDefined(typefilter) && !arraycontains(typefilter, loottype.type)) {
      continue;
    }

    if(isDefined(level.loot.types[name].onspawnfunc)) {
      continue;
    }

    if(istrue(level.loot.spawn_filter[name])) {
      continue;
    }

    if(isDefined(self.loot) && istrue(self.loot[name])) {
      continue;
    }

    probabilityfunc = level.loot.types[name].probabilityfunc;

    if(isDefined(probabilityfunc)) {
      canspawnloot = self[[probabilityfunc]](name, self.origin);

      if(canspawnloot) {
        spawnpool[spawnpool.size] = name;
      }
    }
  }

  if(isDefined(fallbacklootname) && spawnpool.size == 0) {
    spawnpool = [fallbacklootname];
  }

  if(isfunction(self.var_8471c20a853343f6)) {
    spawnpool = [[self.var_8471c20a853343f6]](spawnpool);
  }

  if(getDvar(@ "hash_759557e6189ead37", "<dev string:x24>") != "<dev string:x24>") {
    forceloot = getDvar(@ "hash_759557e6189ead37", "<dev string:x24>");

    if(!arraycontains(spawnpool, forceloot)) {
      spawnpool[spawnpool.size] = forceloot;
    }
  }

  if(istrue(debugdisplay) && getdvarint(@ "hash_7dfe19d75d304409", 0)) {
    msg = "<dev string:x15a>";

    if(spawnpool.size > 0) {
      foreach(item in spawnpool) {
        msg = msg + item + "<dev string:x169>";
      }
    } else {
      msg += "<dev string:x16e>";
    }

    if(spawnpool.size > 0) {
      iprintln(msg);
    }
  }

  return spawnpool;
}

function spawnlootitem(name, origin, angles, force, worldplaced, shouldsuspend, usephysics, usephysicsimpulse) {
  if(!isDefined(level.loot.types[name])) {
    iprintlnbold("<dev string:x178>" + (name ?? "<dev string:x18f>"));

    return undefined;
  }

  if((islootarmor(name) || islootarmorvest(name)) && !utility::playerarmorenabled()) {
    return;
  }

  if(istrue(shouldsuspend) && !isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(angles)) {
    angles = utility::randomvectorrange(0, 360);

    if(islootarmor(name)) {
      angles = (-90, angles[1], 0);
    }
  }

  if(!isDefined(force)) {
    force = 1;
  }

  usedelay = usephysics;

  if(isDefined(shouldsuspend) && !isDefined(usephysics)) {
    usephysics = !shouldsuspend;
  }

  spawnflags = script_items::scriptitem_buildspawnflags(shouldsuspend, usephysics, 1, 0, 1);
  model = level.loot.types[name].model;
  impulse = (randomfloat(0.5), randomfloat(0.5), 1) * force;

  if(isDefined(usephysicsimpulse) && usephysicsimpulse == 0) {
    impulse = (0, 0, 0);
  }

  name = lootprespawn(name);
  item = spawnscriptitem("q\x91\xce\xaa\xf0/\xa9g2\xd9\xed_" + name, origin, angles, spawnflags, model, "", impulse, origin);
  level.loot.lastspawntime[name] = gettime();

  if(isDefined(item)) {
    item endon("\x1e\xfd\xd1\xa2\a");
    loottype = level.loot.types[name].type;
    item.script_count = 0;

    if(isDefined(self.script_count) && int(self.script_count) != 0) {
      item.script_count = int(self.script_count);
    } else if(isDefined(self.script_count_min) && isDefined(self.script_count_max)) {
      item.script_count = int(math::lerp(int(self.script_count_min), int(self.script_count_max), randomfloat(1)));
    }

    if(item.script_count == 0 && loottype == "m\xb8\xd7\x99\x19\xcd\xa6\x14") {
      amountmin = level.loot.types[name].resourceamount;
      amountmax = level.loot.types[name].resourceamountmax;
      amountinterval = level.loot.types[name].resourceamountinterval;
      backpackmaxstacksize = level.loot.types[name].backpackmaxstacksize;
      scale = 1;

      if(isDefined(level.loot.types[name].ammoname) && isDefined(level.loot.resourcescale[level.loot.types[name].ammoname])) {
        now = gettime();
        scales = level.loot.resourcescale[level.loot.types[name].ammoname];

        foreach(entry in scales) {
          if(entry.time == now) {
            scale = max(scale, entry.scale);
            continue;
          }

          scales[key] = undefined;
        }
      }

      item.script_count = int(amountmin ?? 0);

      if(isDefined(amountmax) && int(amountmax) > item.script_count) {
        item.script_count = int(math::lerp(int(item.script_count), int(amountmax), randomfloat(1)));
      }

      item.script_count *= scale;

      if(isDefined(amountinterval) && int(amountinterval) > 1) {
        units = int(round(float(item.script_count) / float(amountinterval)));
        item.script_count = amountinterval * (units <= 0 ? 1 : units);
      }
    }

    if(!istrue(worldplaced)) {
      utility::callsharedfunc(#"loot", #"dropitem", item);
    } else if(isDefined(level.loot.types[name].modellooted)) {
      item thread prestream_handler(level.loot.types[name].modellooted, "\xa3P~\x0f0Z\xf5&\x1e\xe5\x9f\xe3\x7f\x0e\xa6\xfe\x83\xe0\x01E\xc0\xfd\xf7");
    }

    setitemasloot(item, name, worldplaced, usedelay);
    level.loot.lootall[item getentitynumber()] = item;
  }

  return item;
}

function lootprespawn(name) {
  if(isDefined(level.loot.types[name].prespawnfunc)) {
    name = [[level.loot.types[name].prespawnfunc]](name);
  }

  return name;
}

function function_9f195bcc2ee74a33(offhandloot) {
  offhandtospawn = function_1af8629f85bdb4e2();
  loot_id = function_d592e91422d8eba4(offhandtospawn);

  function_56d230fc3f79cad0("<dev string:x19e>" + loot_id);

  pouchloot = level.loot.types[offhandloot];
  var_3ca75eee28762ee3 = structcopy(level.loot.types[loot_id], 1);
  var_3ca75eee28762ee3.interactoffset = (pouchloot.interactoffset[0] ?? 0, pouchloot.interactoffset[1] ?? 0, pouchloot.interactoffset[2] ?? 0.5);
  var_3ca75eee28762ee3.probabilityfunc = pouchloot.probabilityfunc;
  var_3ca75eee28762ee3.model = pouchloot.model;

  if(isDefined(pouchloot.prespawnfunc)) {
    var_3ca75eee28762ee3.prespawnfunc = pouchloot.prespawnfunc;
  }

  level.loot.types[offhandloot] = var_3ca75eee28762ee3;
  return offhandloot;
}

function setitemasloot(item, name, worldplaced, usedelay) {
  item.name = name;
  item.worldplaced = worldplaced;
  item thread cleanuplootitemondelete();
  item thread checkforlootitemtrigger(name, usedelay);

  if(name == "'X\x99\x94\xd9\xcc^\x9d\xb7\x15") {
    if(!itemworldplaced(item)) {
      level.loot.lastdroppedarmortime = gettime();
      level.loot.armordroptimer = 0;
    }
  }
}

function itemworldplaced(item) {
  return item.worldplaced;
}

function cleanuplootitemondelete() {
  self endon("\xa3P~\x0f0Z\xf5&\x1e\xe5\x9f\xe3\x7f\x0e\xa6\xfe\x83\xe0\x01E\xc0\xfd\xf7");
  self waittill("\x1e\xfd\xd1\xa2\a");
  thread cleanuplootorweaponitem();
}

function prestream_handler(fnlootarray, endonevent) {
  self notify("C\xc1\x99M1\a3\x99\f'7\xc8\x1bF\xd4\x8d");
  self endon("C\xc1\x99M1\a3\x99\f'7\xc8\x1bF\xd4\x8d");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(endonevent);

  while(true) {
    waitframe();
    distsq = distancesquared(level.player getEye(), self.origin);

    if(distsq < 250000) {
      lootarray = fnlootarray;

      if(isfunction(lootarray)) {
        lootarray = self[[lootarray]]();
      }

      if(!isDefined(lootarray)) {
        continue;
      }

      if(!isarray(lootarray)) {
        lootarray = [lootarray];
      }

      dist = round(sqrt(distsq), 50);

      foreach(lootname in lootarray) {
        assert(isstring(lootname));
        model = level.loot.types[lootname].model;

        if(!isDefined(model)) {
          model = lootname;
        }

        if(isDefined(model)) {
          level.player utility::function_c47b5325ebd03f27("\xff\xb2\x0e\xc5\xc8", model, dist);
        }
      }

      continue;
    }

    if(distsq > 1000000) {
      wait randomfloatrange(0.75, 1.25);
    }
  }
}

function cleanuplootorweaponitem(nodelete) {
  self notify("\xa3P~\x0f0Z\xf5&\x1e\xe5\x9f\xe3\x7f\x0e\xa6\xfe\x83\xe0\x01E\xc0\xfd\xf7");

  if(isDefined(self.cursor_hint_ent)) {
    self.cursor_hint_ent delete();
    self.cursor_hint_ent = undefined;
  }

  if(!istrue(nodelete) && isDefined(self)) {
    self delete();
  }
}

function checkforlootitemtrigger(name, usedelay) {
  self endon("\x1e\xfd\xd1\xa2\a");
  lootcards = level.loot.lootpresent == "\xe5c\x0f\x18X,h\x1f\a";
  placeduse = istrue(self.worldplaced) || level.loot.types[name].requireuse;

  while(true) {
    useprompt = placeduse || lootcards;
    useautopickup = !placeduse && !level.loot.types[name].requireuse;

    if(istrue(level.loot.autopickup[name])) {
      useautopickup = 1;
    }

    lootinteractwaitpickup(name, useprompt, useautopickup, usedelay);
    waittillplayercanloot();
    waittillnextloottime();
    inactivefunc = level.loot.types[name].inactivefunc;

    if(isDefined(inactivefunc) && [[inactivefunc]](name)) {
      continue;
    }

    if(istrue(self.worldplaced) && isDefined(level.loot.pickupgesture)) {
      if(level.player isweaponsenabled() && isDefined(level.player.currentweapon) && !istrue(level.player.currentweapon.basename == "\r+x5")) {
        level.player playgestureviewmodel(level.loot.pickupgesture, self);
      }
    }

    lootfuncandnotification(name);

    if(!istrue(level.loot.types[name].infiniteuse)) {
      if(istrue(self.worldplaced) && isDefined(level.loot.types[name].modellooted)) {
        self setModel(level.loot.types[name].modellooted);
        cleanuplootorweaponitem(1);
        continue;
      }

      self delete();
    }
  }
}

function function_d592e91422d8eba4(name) {
  var_c5207406ec44f985 = name;

  foreach(loottype in level.loot.types) {
    if(isDefined(loottype.weapon) && loottype.weapon == name) {
      var_c5207406ec44f985 = lootname;
      break;
    }
  }

  return var_c5207406ec44f985;
}

function function_bb460f0a90e8b8bf(name, offsetoverride = undefined) {
  if(isDefined(self.cursor_hint_ent)) {
    return;
  }

  lootentry = level.loot.types[name];

  if(!isDefined(lootentry)) {
    return;
  }

  cursorhintstring = lootentry.loc;
  index = lootentry.index;
  offset = level.loot.types[name].interactoffset;

  if(isDefined(offsetoverride)) {
    offset = offsetoverride;
  }

  self.var_e703a981d06a1192 = 1;
  return cursor_hint::function_2b9474820aa9d4a1(level.loot.var_1d7747e9521cf370, cursorhintstring, undefined, offset, index);
}

function function_4c12e327d0a714b2(name, offsetoverride = undefined) {
  return function_bb460f0a90e8b8bf(function_d592e91422d8eba4(name), offsetoverride);
}

function private function_53d48c75649d729() {
  if(!self islinked() || (level.loot.physicsdelay ?? 0) > 0) {
    end_time = isDefined(level.loot.physicsdelay) ? gettime() + 1000 * level.loot.physicsdelay : 0;
    prev_origin = undefined;

    while(prev_origin != self.origin && (end_time <= 0 || end_time > gettime())) {
      prev_origin = self.origin;
      waitframe();
    }
  }
}

function lootinteractwaitpickup(name, isprompt = 0, isautopickup = 0, usedelay = 0) {
  if(!isprompt && !isautopickup) {
    assertmsg("<dev string:x1bb>" + name + "<dev string:x1c9>");
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xc3\x11$U%\xb3\xf3\xfb\x89\xb9.\x96\x8ap\xef|\x96\xbft\x85\xa5Y");

  if(istrue(usedelay)) {
    function_53d48c75649d729();
  }

  if(isprompt) {
    function_bb460f0a90e8b8bf(name);

    if(isDefined(level.loot.types[name].promptupdate)) {
      self thread[[level.loot.types[name].promptupdate]](name, self.cursorhintstring);
    } else {
      thread function_e4435ec87ba0872c(name, self.cursorhintstring);
    }

    thread waittilltriggerforent(self.cursor_hint_ent, "U(\x8c@r\x8c5E`", undefined, 1);
  }

  if(isautopickup) {
    thread waittilltriggerforent(self, "U(\x8c@r\x8c5E`");
  }

  self waittill("U(\x8c@r\x8c5E`");
}

function private waittilltriggerforent(triggerent, notifymsg, notifymsgalt, isprompt) {
  if(isDefined(notifymsgalt)) {
    self endon(notifymsgalt);
  }

  self endon(notifymsg);
  self endon("\x1e\xfd\xd1\xa2\a");
  singletonevent = "\xc9\xfer=\xf5\xe0\xe4\xe4\xef\xf3@V[\x1f\xb7\xcf\xaa4\x18YrQ" + triggerent getentitynumber();
  self notify(singletonevent);
  self endon(singletonevent);

  while(true) {
    triggerent waittill("\x91`\xb1\xe7T\x97>", who);

    if(who != level.player) {
      continue;
    }

    if(!istrue(isprompt) && !level.player val::get("xh\xf2J\xc3\x166\xc5\x9dz\x88P\x99\x8f")) {
      continue;
    }

    break;
  }

  self.usedprompt = isprompt;
  self notify(notifymsg);
}

function function_e4435ec87ba0872c(name, displayname) {
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.cursor_hint_ent endon("\x1e\xfd\xd1\xa2\a");
  loottype = level.loot.types[name].type;
  fulltext = level.loot.types[name].hintinactive ?? &"equipment/full";

  if(loottype == "m\xb8\xd7\x99\x19\xcd\xa6\x14") {
    self.cursor_hint_ent sethintstringparams(int(self.script_count ?? 0));
    return;
  }

  if(loottype == "\xea\x02%\xeb\xe5%") {
    return;
  }

  lootisammo = islootammo(name);
  lootisammopool = isammopool(name);
  currentammo = -1;
  var_a069dcd84760a8e1 = 1;
  isoffhand = function_163bcf82608ed438(name);

  while(true) {
    previousammo = currentammo;
    distsq = distancesquared(self.origin, level.player.origin);

    if(distsq > 90000) {
      wait randomfloatrange(0.75, 1.25);
      continue;
    }

    if(lootisammo) {
      if(lootisammopool) {
        classnames = function_eaf728ebef207892(name);

        if(!level.player player_sp::function_bdab4da6ef4b173d(classnames)) {
          var_a069dcd84760a8e1 = 0;
        }

        currentammo = level.player player_sp::function_5a7a4ad70cd8f8bd(classnames);
      } else {
        currentammo = level.player player_sp::getammonameamount(name);
      }

      if(lootdebugenabled()) {
        print3d(self.origin + (0, 0, 20), currentammo, (1, 1, 1), 1, 1, 1, 1);
      }
    } else if(islootarmor(name) && !level.player player_sp::function_421fb62426747763()) {
      currentammo = level.player player_sp::getarmoramount();
    } else if(islootarmor(name)) {
      currentammo = level.player player_sp::function_b77a5b6ee26de43();
    } else if(islootarmorvest(name)) {
      currentammo = level.player player_sp::getarmoramount();
    } else if(islootweapon(name)) {
      currentammo = -1;
    } else if(isoffhand) {
      currentammo = getoffhandcurrentammo(name);
    }

    if(currentammo == -1 || function_163bcf82608ed438(name)) {
      self.cursor_hint_ent sethintinoperable(0);
      self.cursor_hint_ent show();
      inactivefunc = level.loot.types[name].inactivefunc;

      if(isDefined(inactivefunc)) {
        inactive = [[inactivefunc]](name);

        if(inactive) {
          self.cursor_hint_ent sethintinoperable(1);

          if(inactive == 2) {
            self.cursor_hint_ent hide();
          }
        }
      }
    }

    if(currentammo != previousammo) {
      var_811a9e1c837ea6d0 = istrue(lootisammopool) && level.player function_c80d8755527f35fc(classnames);

      if(islootammo(name)) {
        maxammo = level.player player_sp::getammonamemaxamount(name);
      } else if(islootarmor(name) && !level.player player_sp::function_421fb62426747763()) {
        maxammo = level.player player_sp::getarmormaxamount();
      } else if(islootarmor(name)) {
        maxammo = level.player player_sp::function_9828b76d9dcaef2d();
      } else if(islootarmorvest(name)) {
        maxammo = level.player player_sp::getarmormaxamountever();
      } else {
        maxammo = function_747691235db172f6(name);
      }

      enablehint = 0;

      if(istrue(var_811a9e1c837ea6d0)) {
        enablehint = 1;
      } else if(currentammo < maxammo) {
        enablehint = 1;
      } else if(isoffhand && swapoffhands()) {
        enablehint = 1;
      }

      hintstring = displayname;

      if(!enablehint) {
        self.cursor_hint_ent sethintinoperable(1);

        if(lootisammopool) {
          if(var_a069dcd84760a8e1) {
            hintstring = fulltext;
          }
        } else {
          hintstring = fulltext;
        }
      } else {
        self.cursor_hint_ent sethintinoperable(0);
      }

      if(level.loot.lootpresent != "\xe5c\x0f\x18X,h\x1f\a") {
        self.cursor_hint_ent setHintString(hintstring);
      }
    }

    waitframe();
  }
}

function isammopool(name) {
  return name == "\x81\xf9j\xd3\xa3\\\xb4<\xef\xb4\xbf\x98\xf3\x1a" || name == "-\xa0\xad\xd7\xa1C\xcfAx\xf7\xa5\xc8\xa7" || name == "\x0fd|\xe7/\vLO\x89Ds" || name == "\xf7\x86{\xb1N\x0e\x9d\xd03&\x9d:";
}

function function_eaf728ebef207892(name) {
  if(!isDefined(level.loot.ammopools)) {
    level.loot.ammopoolclass = [];
    level.loot.ammopoolclass["\x81\xf9j\xd3\xa3\\\xb4<\xef\xb4\xbf\x98\xf3\x1a"] = ["\x93\xa536Y", "\b5"];
    level.loot.ammopoolclass["-\xa0\xad\xd7\xa1C\xcfAx\xf7\xa5\xc8\xa7"] = ["\xff\x9el", "\x8e\xfcc\xbe\xdf\xa6"];
    level.loot.ammopoolclass["\x0fd|\xe7/\vLO\x89Ds"] = ["\xff\x12\x9a\xbe.a"];
    level.loot.ammopoolclass["\xf7\x86{\xb1N\x0e\x9d\xd03&\x9d:"] = ["\n\x1f+\x8dob"];
  }

  return level.loot.ammopoolclass[name];
}

function function_cee2e72dc24da568(weapclass) {
  if(!isDefined(level.loot.ammopoolclass)) {
    function_eaf728ebef207892("Y\xc2n\x83\xf2\x7f\x1eT\xd1\x9d");
    level.loot.var_74d03d7315f4e302 = [];

    foreach(poolclasses in level.loot.ammopoolclass) {
      foreach(class in poolclasses) {
        level.loot.var_74d03d7315f4e302[class] = poolname;
      }
    }
  }

  return level.loot.var_74d03d7315f4e302[weapclass];
}

function function_c80d8755527f35fc(weaponclassarray) {
  foreach(weapon in self getweaponslistprimaries()) {
    if(weapon == self.swimweapon) {
      continue;
    }

    if(weapon.inventorytype == "\xf0\n\x7fXb{\xcf") {
      continue;
    }

    classname = weaponclass(weapon);

    if(arraycontains(weaponclassarray, classname)) {
      if(self getweaponammostock(weapon) < weapon.maxammo) {
        return true;
      }
    }
  }

  return false;
}

function lootsetautopickup(name, autopickup) {
  if(!isDefined(level.loot)) {
    level.loot = spawnStruct();
  }

  level.loot.autopickup[name] = istrue(autopickup) ? 1 : undefined;

  if(!isDefined(level.loot.lootall)) {
    return;
  }

  foreach(item in level.loot.lootall) {
    if(!isDefined(item) || item.name != name) {
      continue;
    }

    if(istrue(autopickup)) {
      item thread waittilltriggerforent(item, "U(\x8c@r\x8c5E`", "\xd8L\v\x9b\xcb\xb6\x7f\a18\f");
      continue;
    }

    item notify("\xd8L\v\x9b\xcb\xb6\x7f\a18\f");
  }
}

function lootfuncandnotification(name) {
  self thread[[level.loot.types[name].lootfunc]](name);
  lootnotification(name);
}

function lootnotification(name, rumble) {
  analytics::analytics_event_upload("x\x8f[>`\x85\xcc\x1c3u\xcc", level.loot.types[name].listindex);

  if(level.loot.types[name].type === "m\xb8\xd7\x99\x19\xcd\xa6\x14" && isDefined(level.loot.types[name].ammoname)) {
    analytics::analytics_event_upload("\x16\x97\xe5\xc1\xa3\xda\x8f\xfb\xdf\xdf\xa6;\n\x1f" + level.loot.types[name].ammoname, self.script_count ?? 0);
  }

  level.player notify("L\xf3NF\x8a{\xcf\xa3^", name);

  if(isDefined(self.lootstruct)) {
    self.lootstruct notify("L\xf3NF\x8a{\xcf\xa3^", name);
  }

  playlootsound(name);
  function_3ca04b6aa51422e5(name);
  thread createnotification(name);
}

function inactiveplayermaxarmor(name) {
  if(level.player player_sp::function_421fb62426747763()) {
    if(level.player player_sp::hasmaxarmorplates()) {
      return true;
    }
  } else if(level.player player_sp::getarmoramount() >= level.player player_sp::getarmormaxamount()) {
    return true;
  }

  return false;
}

function function_d000d246d525d29b(name) {
  if(level.player player_sp::function_6e8ed8adbf3f8987()) {
    return true;
  }

  return false;
}

function inactiveplayermaxammo(name) {
  switch (name) {
    case #"hash_f8d2ba02e1a42ffd":
      primaries = level.player getweaponslistprimaries();

      foreach(weapon in primaries) {
        if(!level.player utility_sp::isweaponmaxammo(weapon)) {
          return false;
        }
      }

      return true;
    default:
      if(level.player player_sp::getammonameamount(name) >= level.player player_sp::getammonamemaxamount(name)) {
        return true;
      }

      break;
  }

  return false;
}

function inactiveoffhand(name) {
  if(swapoffhands()) {
    return 0;
  }

  itement = self;
  parent = itement getlinkedparent();

  if(isai(parent) && isalive(parent)) {
    return 2;
  }

  weaponname = getoffhandweaponname(name);

  if(!isDefined(weaponname)) {
    assertmsg("<dev string:x1e7>" + name + "<dev string:x1f3>");
  }

  if(utility::issharedfuncdefined(#"loot", #"_isinactiveoffhand", 0)) {
    if(istrue(level.player[[utility::getsharedfunc(#"loot", #"_isinactiveoffhand")]](name, weaponname))) {
      return 1;
    } else {
      return 0;
    }
  }

  if(!utility_sp::player_has_equipment(weaponname)) {
    offhandtype = offhands::getweaponoffhandtype(weaponname);

    if(!player_offhand_empty(offhandtype)) {
      return 1;
    }
  }

  currentammo = getoffhandcurrentammo(name);
  maxammo = function_747691235db172f6(name);

  if(currentammo >= maxammo) {
    return 1;
  }

  return 0;
}

function inactive(name) {
  return false;
}

function function_6e81a37dc8596cc4(name) {
  if(isfunction(level.loot.var_e21c95af51c7bd6e)) {
    if([[level.loot.var_e21c95af51c7bd6e]](name)) {
      return true;
    }
  }

  return false;
}

function player_offhand_empty(offhandtype) {
  offhand = level.player getcurrentoffhand(offhandtype);

  if(!isDefined(offhand) || offhand.basename == "\r+x5") {
    return 1;
  }

  return 0;
}

function function_6f9c3f5361bb9156(weapon) {
  foreach(loot in level.loot.types) {
    if(loot.weapon === weapon) {
      return name;
    }
  }

  return undefined;
}

function getoffhandprobabilityfromname(name) {
  return level.loot.types[name].chance;
}

function getoffhandweaponname(name) {
  return level.loot.types[name].weapon;
}

function function_5e9f15787cb849b(name) {
  if(!isDefined(level.loot.types[name].weaponobj) && isDefined(level.loot.types[name].weapon)) {
    level.loot.types[name].weaponobj = makeweapon(level.loot.types[name].weapon);
  }

  if(isDefined(level.loot.types[name].weaponobj)) {
    return level.loot.types[name].weaponobj;
  }

  return undefined;
}

function getoffhandcurrentammo(name) {
  if(!isDefined(level.loot.ammocache)) {
    level.loot.ammocache = [];
  }

  now = gettime();
  lasttime = level.loot.ammocache[name][0];

  if(!isDefined(lasttime) || now != lasttime) {
    weaponname = getoffhandweaponname(name);
    result = 0;
    func = utility::getsharedfunc(#"loot", #"_getoffhandcurrentammo");

    if(isDefined(func)) {
      result = level.player[[func]](name, weaponname);
    } else if(utility_sp::player_has_equipment(weaponname)) {
      equiplist = level.player.offhandinventory;

      foreach(weapon in equiplist) {
        if(weapon.basename == weaponname) {
          result = level.player getweaponammostock(weapon);
          break;
        }
      }
    }

    level.loot.ammocache[name][0] = now;
    level.loot.ammocache[name][1] = result;
  }

  return level.loot.ammocache[name][1];
}

function function_2390a1b6afacb609(type) {
  assert(type == "<dev string:x218>" || type == "<dev string:x223>");

  foreach(objweapon in level.player.offhandinventory) {
    if(objweapon.offhandtype === type) {
      return true;
    }
  }

  return false;
}

function function_747691235db172f6(name) {
  if(isDefined(level.loot.types[name].maxammo)) {
    return level.loot.types[name].maxammo;
  }

  weaponname = getoffhandweaponname(name);
  return weaponclipsize(weaponname);
}

function function_157cc02036b46d1a(name, maxammo) {
  level.loot.types[name].maxammo = maxammo;
}

function inactiveammorestock(name) {
  primaries = level.player getweaponslistprimaries();

  foreach(weapon in primaries) {
    if(istrue(weapon.reloaddisabled)) {
      continue;
    }

    if(!level.player utility_sp::isweaponmaxammo(weapon)) {
      return false;
    }
  }

  return true;
}

function lootammorestock(name) {
  primaries = level.player getweaponslistprimaries();

  foreach(weapon in primaries) {
    if(istrue(weapon.reloaddisabled)) {
      continue;
    }

    level.player utility_sp::giveweaponmaxammo(weapon);
  }
}

function lootammo(name) {
  itement = self;
  ogammo = player_sp::getammonameamount(name);
  maxammo = player_sp::getammonamemaxamount(name);
  var_d8ed6511865db55 = getammolootamount(ogammo, maxammo);
  finalammo = int(min(maxammo, ogammo + var_d8ed6511865db55));

  if(finalammo != ogammo) {
    level.player player_sp::setammonameamount(name, finalammo);

    function_56d230fc3f79cad0("<dev string:x230>" + var_d8ed6511865db55 + "<dev string:x23d>" + name);
  }
}

function lootammopool(name) {
  weaponclassarray = function_eaf728ebef207892(name);

  foreach(weapon in level.player getweaponslistprimaries()) {
    if(weapon == level.player.swimweapon) {
      continue;
    }

    if(weapon.inventorytype == "\xf0\n\x7fXb{\xcf") {
      continue;
    }

    classname = weaponclass(weapon);

    if(arraycontains(weaponclassarray, classname)) {
      level.player givemaxammo(weapon);

      function_56d230fc3f79cad0("<dev string:x244>" + name);
    }
  }
}

function getammolootamount(ogammo, maxammo) {
  ammofrac = math::normalize_value(0, maxammo, ogammo);
  ammomaxfrac = math::factor_value(0.5, 0.1, ammofrac);
  return max(1, int(ammomaxfrac * maxammo));
}

function lootarmor(name) {
  itement = self;

  if(level.player player_sp::function_421fb62426747763()) {
    lastarmorplateamount = level.player player_sp::function_b77a5b6ee26de43();
    level.player player_sp::function_38272a9887d2838(lastarmorplateamount + 1);
  } else {
    level.player notify("\xces\x03\xd0\xe4 \x99\x8c\xb6\xa6f\x94\xb8");
  }

  thread createnotification("'X\x99\x94\xd9\xcc^\x9d\xb7\x15");
}

function lootarmorvest(name) {
  itement = self;
  newarmoramount = level.player player_sp::getarmormaxamount();
  player_sp::function_1ce6325d5bcc22a1(newarmoramount);
  level.player player_sp::give_player_max_armor();
  thread createnotification("\xe0\xdc\xdc\x8d#\xabI\x93\xf8");
}

function function_66fd18b91c03699() {
  return level.loot.var_c9a7590cf97bdd19;
}

function lootoffhand(name) {
  weaponname = getoffhandweaponname(name);

  if(!isDefined(weaponname)) {
    assertmsg("<dev string:x1e7>" + name + "<dev string:x1f3>");
  }

  if(utility::issharedfuncdefined(#"loot", #"_lootoffhand", 0)) {
    level.player[[utility::getsharedfunc(#"loot", #"_lootoffhand")]](name, weaponname);
    return;
  }

  weaponobj = function_5e9f15787cb849b(name);
  type = weaponobj.offhandtype;
  itement = self;

  if(utility_sp::player_has_equipment(weaponname, 1)) {
    equiplist = level.player.offhandinventory;

    foreach(weapon in equiplist) {
      if(isweapon(weapon)) {
        if(weapon.basename == weaponname) {
          ogammo = level.player getweaponammostock(weapon);
          function_e579ffd1d23e9ce6(ogammo, weapon, name, type);
        }

        continue;
      }

      if(isstring(weapon)) {
        if(weapon == weaponname) {
          attachments = getweapondefaultattachments(weapon);

          if(istrue(attachments.size)) {
            objweapon = makeweapon(weapon, attachments);

            foreach(attachment in attachments) {
              ogammo = level.player getweaponammostock(objweapon);
              function_e579ffd1d23e9ce6(ogammo, objweapon, name, type);
            }
          }
        }
      }
    }

    return;
  }

  if(level.player.offhandinventory.size > 0 && function_2390a1b6afacb609(type) && swapoffhands()) {
    if(!function_6b1990ad3882d587()) {
      dropcurrentoffhands(type, itement.origin);
    } else {
      function_2e72e7478d1d73ec(type);
    }
  }

  if(!function_6b1990ad3882d587()) {
    level.player utility_sp::give_offhand(weaponname, 1);
    return;
  }

  lootitem = itement.name;

  if(isDefined(lootitem)) {
    backpackammo = utility::callsharedfunc(#"backpack", #"getbackpackitemcount", level.loot.types[lootitem].lootid);

    if(isDefined(backpackammo) && backpackammo > 0) {
      maxammo = weaponmaxammo(weaponname);

      if(1 < maxammo) {
        availableammo = int(min(backpackammo, maxammo - 1));
        finalammo = int(min(1 + availableammo, maxammo));
        level.player utility_sp::give_offhand(weaponname, finalammo);
        utility::callsharedfunc(#"backpack", #"hash_525b278b43682d10", level.loot.types[lootitem].lootid, finalammo);
      }

      return;
    }
  }

  level.player utility_sp::give_offhand(weaponname, 1);
}

function function_e579ffd1d23e9ce6(ogammo, weapon, name, type) {
  maxammo = function_747691235db172f6(name);

  if(ogammo == maxammo) {
    function_2e72e7478d1d73ec(type, 1);
    return;
  }

  finalammo = int(min(ogammo + 1, maxammo));
  level.player setweaponammoclip(weapon, finalammo);
}

function function_2e72e7478d1d73ec(type, countoverride) {
  itemcount = getcurrentoffhandcount(type);

  if(isDefined(countoverride)) {
    itemcount = countoverride;
  }

  lootitem = getcurrentoffhandlootid(type);
  utility::callsharedfunc(#"backpack", #"addtobackpack", level.loot.types[lootitem], itemcount);
}

function getcurrentoffhandlootid(type) {
  loot_id = undefined;

  foreach(objweapon in level.player.offhandinventory) {
    if(objweapon.offhandtype === type) {
      loot_id = function_6f9c3f5361bb9156(objweapon.basename);
      break;
    }
  }

  return loot_id;
}

function getcurrentoffhandcount(type) {
  itemcount = undefined;

  foreach(objweapon in level.player.offhandinventory) {
    if(objweapon.offhandtype === type) {
      itemcount = level.player getweaponammostock(objweapon);
      break;
    }
  }

  return itemcount;
}

function dropcurrentoffhands(type, origin = level.player.origin) {
  assert(type == "<dev string:x218>" || type == "<dev string:x223>");
  var_15c9543b2339b1d0 = undefined;
  var_fe9c75eb62a5ea2c = 0;
  loot_id = undefined;

  foreach(objweapon in level.player.offhandinventory) {
    if(objweapon.offhandtype === type) {
      var_15c9543b2339b1d0 = objweapon;
      loot_id = function_6f9c3f5361bb9156(objweapon.basename);
      var_fe9c75eb62a5ea2c = level.player getweaponammostock(objweapon);
      break;
    }
  }

  if(isDefined(loot_id)) {
    level.player takeweapon(var_15c9543b2339b1d0);

    for(i = 0; i < var_fe9c75eb62a5ea2c; i++) {
      angles = (0, randomint(270), 0);
      spawnlootitem(loot_id, origin + utility::randomvectorrangeflat(3, 6), angles, 0, 0, 0, 1);
    }
  }
}

function lootprimaryweapon(name) {
  level.player giveweapon(level.loot.types[name].weaponprimary);
  level.player switchtoweapon(level.loot.types[name].weaponprimary);
}

function function_505a7281acdf1fb3(name) {
  itement = self;

  if(isfunction(level.loot.var_2d59a69eef0ef553)) {
    self[[level.loot.var_2d59a69eef0ef553]](name);
  }
}

function lootgeneral(name) {
  utility::callsharedfunc(#"backpack", #"addtobackpack", level.loot.types[name], 1);
}

function lootconsumable(name) {
  utility::callsharedfunc(#"backpack", #"addconsumable", 1, level.loot.types[name]);
}

function lootattachment(name) {
  utility::callsharedfunc(#"gunwall", #"hash_d248b5c493e970d2", name);
}

function lootcontraband(name) {
  thread utility::callsharedfunc(#"loot", #"collectcontraband", name);

  if(issubstr(name, "\\\x92\xed\xd6\x81\x99\xe8\x12\xb5_\xcb6~\x81a\x9d")) {
    return;
  }

  utility::callsharedfunc(#"backpack", #"addtobackpack", level.loot.types[name], 1);
}

function lootresource(name) {
  itement = self;

  if(isDefined(level.fnlootresource)) {
    itement[[level.fnlootresource]](name);
    return;
  }

  resourcetype = level.loot.types[name].ammoname;

  if(!isstring(resourcetype)) {
    return;
  }

  if((itement.script_count ?? 0) != 0) {
    resourceadd = itement.script_count;
    resourcegive = int(clamp(resourceadd, 10, 1000));

    if(resourceadd != resourcegive) {
      analytics::analytics_event_upload(" qqP\xd3{\xd1\r\a\x8b\xa7,\x1d\xa1\xa6\xde8\xc3" + level.loot.types[name].ammoname, resourceadd);
    }

    curpending = level.player getplayerprogression("|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", resourcetype);
    curpending += resourcegive;
    level.player setplayerprogression("|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", resourcetype, curpending);

    if(getdvarint(@ "hash_7dfe19d75d304409", 0)) {
      curbanked = level.player getplayerprogression("<dev string:x261>", resourcetype);
      iprintlnbold("<dev string:x26d>" + resourcetype + "<dev string:x276>" + curbanked + curpending);
    }
  }
}

function private function_d823113d922c73f9() {
  if(level.loot.resourcetypes.size == 0) {
    return;
  }

  while(true) {
    level waittill("\xff\x0e\xef\xae\xe4z\xfeO\x1e[");
    waittillframeend();

    foreach(resourcetype in level.loot.resourcetypes) {
      curbanked = level.player getplayerprogression("-\xb8\xd7\x99\x19\xcd\xa6\x14", resourcetype);
      curpending = level.player getplayerprogression("|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", resourcetype);
      curpendinguse = int(clamp(curpending, 0, 10000));

      if(curpending != curpendinguse) {
        analytics::analytics_event_upload("\x1ax&\x06U\xf5\xc00\r*\xa0gc\x8c\a\xc4\xe8V\xe2\x1e|\x16M" + resourcetype, curpending);
      }

      level.player setplayerprogression("-\xb8\xd7\x99\x19\xcd\xa6\x14", resourcetype, curbanked + curpendinguse);
      level.player setplayerprogression("|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", resourcetype, 0);

      if(getdvarint(@ "hash_7dfe19d75d304409", 0)) {
        iprintlnbold("<dev string:x26d>" + resourcetype + "<dev string:x276>" + curbanked + curpendinguse);
      }

      validatebanked = level.player getplayerprogression("-\xb8\xd7\x99\x19\xcd\xa6\x14", resourcetype);
      var_3aaea5d5a5d57a33 = int(clamp(validatebanked, 0, 30000));

      if(validatebanked != var_3aaea5d5a5d57a33) {
        analytics::analytics_event_upload("vxp\xd3\xfd\x83\x8d\xc8i\v\x11\xb8\a8\x9a`2~\xf1vE\xdaen\x9e\x9f\x9ea" + resourcetype, validatebanked);
      }
    }
  }
}

function private function_393f7eea73e67b6() {
  if(level.loot.resourcetypes.size == 0) {
    return;
  }

  while(true) {
    level waittill("l\xce\x9a\x10\x10\xb9\x99\x0eT\xb7C");

    foreach(resourcetype in level.loot.resourcetypes) {
      level.player setplayerprogression("|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", resourcetype, 0);
    }
  }
}

function donothing(name) {}

function private function_8247fb1a0e7ba828(name, origin) {
  if(istrue(self.noarmor)) {
    function_56d230fc3f79cad0("<dev string:x27d>");

    return false;
  }

  if(force_armor_drop()) {
    function_56d230fc3f79cad0("<dev string:x2a1>");

    return true;
  }

  return false;
}

function private probabilityarmorneeded(name, origin) {
  if(!level.player player_sp::hasarmor() && !istrue(level.var_6e4b6f7c620f45ab)) {
    return false;
  }

  if(level.player player_sp::hasmaxarmorplates()) {
    function_56d230fc3f79cad0(name + "<dev string:x2c1>");

    return false;
  }

  distancesq = distancesquared(origin, level.player.origin);

  if(isDefined(level.loot.items)) {
    foreach(item in level.loot.items) {
      if(item.name != name) {
        continue;
      }

      itemdistancesq = distancesquared(origin, item.origin);

      if(itemdistancesq <= 40000) {
        function_56d230fc3f79cad0("<dev string:x2df>");

        return false;
      }
    }
  }

  droptimedifference = (gettime() - level.loot.lastdroppedarmortime) / 1000;

  if(droptimedifference < 2) {
    function_56d230fc3f79cad0("<dev string:x30b>");

    return false;
  }

  level.player.lootarmorchance = getdvarfloat(@ "hash_d746cc65cda5dd48");

  if(level.player.lootarmorchance > 0) {
    if(!isDefined(level.player.var_17fcd332f4fb7f18)) {
      level.player.var_17fcd332f4fb7f18 = 0;
    }

    droparmor = randomfloat(1) < level.player.lootarmorchance;

    if(!droparmor) {
      level.player.var_17fcd332f4fb7f18++;

      if(level.player.var_17fcd332f4fb7f18 >= 1 / level.player.lootarmorchance) {
        droparmor = 1;
      }
    }

    if(droparmor) {
      function_56d230fc3f79cad0("<dev string:x341>" + level.player.lootarmorchance);

      level.player.var_17fcd332f4fb7f18 = 0;
      return true;
    }
  }

  ratios = [armorinventoryratio(), armorhealthratio(), armordistanceratio(distancesq)];
  chance = armormaxprobability() * utility::array_sum(ratios);

  function_56d230fc3f79cad0("<dev string:x362>" + chance);

  if(randomint(100) > chance) {
    return false;
  }

  function_56d230fc3f79cad0("<dev string:x374>");

  worldcount = 0;

  if(isDefined(level.loot.spawned)) {
    foreach(item in level.loot.spawned) {
      if(item.name == name && !itemworldplaced(item)) {
        worldcount++;
      }
    }
  }

  var_95a1f453b61ab83f = level.player player_sp::function_b77a5b6ee26de43() + worldcount < level.player player_sp::function_9828b76d9dcaef2d();

  if(var_95a1f453b61ab83f) {
    return true;
  }

  return false;
}

function armorinventoryratio() {
  ratio = 1 - level.player player_sp::function_b77a5b6ee26de43() / level.player player_sp::function_9828b76d9dcaef2d();
  return 0.15 * ratio;
}

function armorhealthratio() {
  if(!level.player player_sp::hasarmor()) {
    return 0.1;
  }

  ratio = 1 - level.player player_sp::getarmoramount() / level.player player_sp::getarmormaxamount();
  return 0.1 * ratio;
}

function armordistanceratio(distancesq) {
  constant = 1 / 2250000;
  ratio = constant * distancesq;
  return 0.75 * ratio;
}

function armormaxprobability() {
  ratio = min(level.loot.armordroptimer / 120, 1);
  addedprobability = 82 * ratio;
  return 3 + addedprobability;
}

function probabilityzero(name, origin) {
  return false;
}

function get_stowed_primary_weapon() {
  foreach(weapon in self.primaryinventory) {
    if(!issameweapon(weapon, self.currentprimaryweapon, 1)) {
      return weapon;
    }
  }

  return nullweapon();
}

function function_58e1c43b94dfb591(name, origin) {
  if(isDefined(self.team) && self.team != "?\xb1\xc0\x9a") {
    return false;
  }

  if(isDefined(level.loot.lastspawntime[name])) {
    if(gettime() - level.loot.lastspawntime[name] < 1000) {
      function_56d230fc3f79cad0(name + "<dev string:x38d>");

      return false;
    }
  }

  if(isDefined(level.loot.items)) {
    foreach(item in level.loot.items) {
      if(item.name != name) {
        continue;
      }

      itemdistancesq = distancesquared(origin, item.origin);

      if(itemdistancesq <= 40000) {
        function_56d230fc3f79cad0("<dev string:x3a5>");

        return false;
      }
    }
  }

  chance = corpseoffhandchance();
  diceroll = randomint(100);

  if(diceroll > chance) {
    function_56d230fc3f79cad0(chance + "<dev string:x3d8>" + name + "<dev string:x3e8>" + diceroll);

    return false;
  }

  return true;
}

function corpseoffhandchance() {
  if(isDefined(self.corpseoffhandchance)) {
    return self.corpseoffhandchance;
  }

  if(isDefined(level.corpseoffhandchance)) {
    return level.corpseoffhandchance;
  }

  return 33;
}

function function_fbdae5a9562f6a11(num) {
  assert(isai(self) && isalive(self), "<dev string:x403>");
  self.corpseoffhandchance = num;
}

function function_7dac91bf902df1b4(num) {
  level.corpseoffhandchance = num;
}

function function_1af8629f85bdb4e2() {
  currentmapoffhands = function_66fd18b91c03699();
  var_531e21248cb5a41e = [];
  var_b8cc7b93e41776ef = [];
  offhandsempty = currentmapoffhands;

  foreach(objweapon in level.player.offhandinventory) {
    currentammo = level.player getweaponammoclip(objweapon);
    maxammo = weaponmaxammo(objweapon);

    if(currentammo > 0 && arraycontains(offhandsempty, objweapon.basename)) {
      offhandsempty = arrayremove(offhandsempty, objweapon.basename);
    }

    if(currentammo == maxammo) {
      var_531e21248cb5a41e[var_531e21248cb5a41e.size] = objweapon.basename;
      continue;
    }

    if(currentammo < maxammo) {
      if(arraycontains(currentmapoffhands, objweapon.basename)) {
        var_b8cc7b93e41776ef[var_b8cc7b93e41776ef.size] = objweapon.basename;
      }
    }
  }

  if(offhandsempty.size) {
    return offhandsempty[randomint(offhandsempty.size)];
  }

  if(var_b8cc7b93e41776ef.size) {
    return var_b8cc7b93e41776ef[randomint(var_b8cc7b93e41776ef.size)];
  }

  return currentmapoffhands[randomint(currentmapoffhands.size)];
}

function probabilityoffhand(name, origin) {
  weaponname = getoffhandweaponname(name);

  if(!isDefined(weaponname)) {
    assertmsg("<dev string:x1e7>" + name + "<dev string:x1f3>");
  }

  if(!arraycontains(level.loot.offhands, weaponname)) {
    return false;
  }

  if(!offhands::offhandisprecached(name)) {
    return false;
  }

  distancesq = distancesquared(origin, level.player.origin);

  if(distancesq > 2250000) {
    return false;
  }

  chance = offhandchance(name);

  if(randomint(100) >= chance) {
    return false;
  }

  return true;
}

function probabilityoffhandwheel(name, origin) {
  if(!isDefined(self.var_1875a6eff5e45a1)) {
    self.var_1875a6eff5e45a1 = randomfloat(1) < 0.2;
  }

  if(self.var_1875a6eff5e45a1) {
    return false;
  }

  weaponname = getoffhandweaponname(name);

  if(!isDefined(weaponname)) {
    assertmsg("<dev string:x1e7>" + name + "<dev string:x1f3>");
  }

  if(!(isDefined(level.loot.wheelweapons) && isDefined(level.loot.wheelweapons[weaponname]))) {
    return false;
  }

  if(!offhands::offhandisprecached(weaponname)) {
    return false;
  }

  distancesq = distancesquared(origin, level.player.origin);

  if(distancesq > 2250000) {
    return false;
  }

  if(!isDefined(level.player.equipmentwheel.items)) {
    return false;
  }

  if(!isDefined(level.player.equipmentwheel.items[weaponname])) {
    return false;
  }

  chance = offhandchance(name);

  if(randomint(100) >= chance) {
    return false;
  }

  return true;
}

function function_5f1af072cf3fdbc7(name) {
  if(!isDefined(level.loot)) {
    return 0;
  }

  if(!isDefined(level.loot.items)) {
    return 0;
  }

  worldcount = 0;

  foreach(item in level.loot.items) {
    if((!isDefined(name) || item.name == name) && !itemworldplaced(item)) {
      worldcount++;
    }
  }

  return worldcount;
}

function private offhandchance(name) {
  maxchance = getoffhandprobabilityfromname(name);

  if(maxchance <= 0) {
    return 0;
  }

  currentammo = getoffhandcurrentammo(name);
  maxammo = function_747691235db172f6(name);
  worldcount = function_5f1af072cf3fdbc7(name);
  var_a39dd322c59ac454 = clamp(1 - (currentammo + worldcount) / maxammo, 0, 1);
  var_f3738907da301d04 = level.var_f3738907da301d04;

  if(isDefined(self.var_f3738907da301d04)) {
    var_f3738907da301d04 = self.var_f3738907da301d04;
  }

  if(isDefined(var_f3738907da301d04)) {
    var_a39dd322c59ac454 = clamp(var_a39dd322c59ac454, var_f3738907da301d04, 1);
  }

  chance = maxchance * var_a39dd322c59ac454;
  return chance;
}

function waittillplayercanloot() {
  while(level.player ismeleeing()) {
    waitframe();
  }
}

function playlootsound(name) {
  if(isDefined(level.loot.types[name].sound) && soundexists(level.loot.types[name].sound)) {
    level.loot.sfx utility::delaycall(0.2, &playsound, level.loot.types[name].sound);
  }
}

function function_3ca04b6aa51422e5(name) {
  if(isDefined(level.loot.types[name].rumble)) {
    level.player playRumbleOnEntity(level.loot.types[name].rumble);
  }
}

function createnotification(name, showinrealism) {
  isvalidname = isDefined(name);

  if(!isvalidname) {
    return;
  }

  isvalidtype = isDefined(level.loot.types[name]);

  if(!isvalidtype) {
    foreach(loottype in level.loot.types) {
      if(isDefined(loottype.weapon) && getweaponbasename(loottype.weapon) == name) {
        name = lootname;
        isvalidname = 1;
        isvalidtype = 1;
        break;
      }
    }
  }

  if(!isvalidtype) {
    return;
  }

  shouldcreatenotification = istrue(level.loot.types[name].createnotification);

  if(!shouldcreatenotification) {
    return;
  }

  shouldcreatenotif = !utility_sp::in_realism_mode() || istrue(showinrealism);

  if(shouldcreatenotif) {
    if(isDefined(level.loot.splashwidget)) {
      if(!level.player hud_management::function_48c98ea9a4f0da89("1\xc7\n\x1e^\x82\xc0\x8b\xc5}\xa4\xeeS\x0f=\x86\x84\x03\x01")) {
        level.player hud_management::function_35924dfcb78711f4("1\xc7\n\x1e^\x82\xc0\x8b\xc5}\xa4\xeeS\x0f=\x86\x84\x03\x01", level.loot.splashwidget);
        level.player hud_management::function_85d8a0ba2e35b6f2("1\xc7\n\x1e^\x82\xc0\x8b\xc5}\xa4\xeeS\x0f=\x86\x84\x03\x01", 0, 150, 2, 1);
      }

      level.player hud_management::function_d3b457baa69dec73("1\xc7\n\x1e^\x82\xc0\x8b\xc5}\xa4\xeeS\x0f=\x86\x84\x03\x01", "KJ\xf5\x8a\xbf\xf5\xcd\a\xc6i\x9at\x06\xde\xfad\x127\xebZ", level.loot.types[name].index);

      if(isDefined(self.script_count)) {
        level.player hud_management::function_d3b457baa69dec73("1\xc7\n\x1e^\x82\xc0\x8b\xc5}\xa4\xeeS\x0f=\x86\x84\x03\x01", "\xb6\x9d\xbd\xca\xae\xdb\x03\xbf\x1f\x14#.\xc4\xf7u\xcb'", self.script_count);
        level.player hud_management::function_d3b457baa69dec73("1\xc7\n\x1e^\x82\xc0\x8b\xc5}\xa4\xeeS\x0f=\x86\x84\x03\x01", "\xee\x1dnK\xb9\xd5^\xaaZ\xb5\xc4VW\xcfI\x14\xc8\xb2\xaf[O\xec\xcb}>!", 1);
      }
    } else {
      shader = level.loot.types[name].shader;
      locname = level.loot.types[name].loc;
      setomnvar("5\x82\x15\xeeu4\xe3\xf7\xda:\x16\xc3\xe7\xda\xa1j\xa6\x81G", locname);
      setomnvar("\xea\xb4\xebc\xed\xdb\xd1}\xdc\xc1c,\xb9\xd0\xfa\xa5\x8d\xde\xcd", shader);
    }

    waitframe();
    destroylootnotification();
  }
}

function waittillnextloottime() {
  currenttime = gettime();
  goaltime = level.loot.lastloottime + 250;

  if(currenttime > goaltime) {
    level.loot.lastloottime = currenttime;
    return;
  }

  level.loot.lastloottime = goaltime;

  while(gettime() < goaltime) {
    waitframe();
  }
}

function destroylootnotification() {
  if(isDefined(level.loot.splashwidget)) {
    level.player hud_management::function_d3b457baa69dec73("1\xc7\n\x1e^\x82\xc0\x8b\xc5}\xa4\xeeS\x0f=\x86\x84\x03\x01", "KJ\xf5\x8a\xbf\xf5\xcd\a\xc6i\x9at\x06\xde\xfad\x127\xebZ", 0);
    return;
  }

  setomnvar("5\x82\x15\xeeu4\xe3\xf7\xda:\x16\xc3\xe7\xda\xa1j\xa6\x81G", "\r+x5");
  setomnvar("\xea\xb4\xebc\xed\xdb\xd1}\xdc\xc1c,\xb9\xd0\xfa\xa5\x8d\xde\xcd", "\r+x5");
}

function setworldloot() {
  waittillframeend();

  if(istrue(level.loot.var_5f580e70140f0241)) {
    foreach(struct in utility::getStructArray("\x13|mq%\x8a\x1d+'lG\xads/I\x8fo2\x8an\xc2#\x0e\xce\xb0\x16", "!DOn\xba'\xed\x8e&!\\")) {
      assert(isDefined(struct.script_asset), "<dev string:x431>");
      name_id = getscriptbundlefieldvalue("\xbc5\xd1a\xacW\x84\xe0}S\x87\xd6\x84" + struct.script_asset, #"name_id");
      assert(isDefined(name_id), "<dev string:x467>");
      ent = struct spawnlootitem(name_id, struct.origin, struct.angles, 0, 1, istrue(struct.script_suspend));

      if(isDefined(ent)) {
        ent.lootstruct = struct;
      }
    }
  }

  foreach(struct in utility::getStructArray("P!\x88N8<\xd1\x9f\xb4", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc")) {
    isrefloot = struct isrefloot();

    if(!isDefined(struct.script_noteworthy)) {
      if(!isrefloot) {
        struct thread worldlootwaitproximity();
      }

      continue;
    }

    if(!isDefined(level.loot.types[struct.script_noteworthy])) {
      iprintlnbold("<dev string:x48b>" + struct.script_noteworthy + "<dev string:x4b4>" + struct.origin + "<dev string:x4be>");
      continue;
    }

    if(!isrefloot) {
      ent = struct spawnlootitem(struct.script_noteworthy, struct.origin, struct.angles, 0, 1, istrue(struct.script_suspend));

      if(isDefined(ent)) {
        ent.lootstruct = struct;
      }
    }
  }
}

function private worldlootwaitproximity(radius) {
  self notify(")R3z\x1e\x06e'\x94G\x98x\xa9\x82\x9cs\x93O\xa1\x8d\x1e\xd2");
  self endon(")R3z\x1e\x06e'\x94G\x98x\xa9\x82\x9cs\x93O\xa1\x8d\x1e\xd2");

  if(!isDefined(radius)) {
    radius = 1000;
  }

  radiussq = squared(radius);

  while(isDefined(self)) {
    wait randomfloatrange(0.5, 1);

    if(!isDefined(self)) {
      return;
    }

    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < radiussq) {
        spawnpool = getspawnpool("\x12\x89\xc9I\x96$\x8f", "\xf8\xd6\xf0\xd7");

        if(spawnpool.size > 0) {
          self.script_noteworthy = spawnpool[randomintrange(0, spawnpool.size)];
        }

        if(!isDefined(self.script_noteworthy)) {
          return;
        }

        itement = spawnlootitem(self.script_noteworthy, self.origin, self.angles, 0, 1, istrue(self.script_suspend));

        if(isDefined(itement)) {
          itement.lootstruct = self;
        }

        return;
      }
    }
  }
}

function isrefloot() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1) {
    return 1;
  }

  return 0;
}

function islootammo(name) {
  return arraycontains(level.loot.ammo_types, name);
}

function islootarmor(name) {
  return tolower("'X\x99\x94\xd9\xcc^\x9d\xb7\x15") == tolower(name);
}

function islootarmorvest(name) {
  return tolower("\xe0\xdc\xdc\x8d#\xabI\x93\xf8") == tolower(name);
}

function islootweapon(name) {
  return level.loot.types[name].type == "\xe5WI\xf1\\y\x11\x03T'\xf3\xe8\xb5";
}

function function_163bcf82608ed438(name) {
  return level.loot.types[name].type == "\x12\x89\xc9I\x96$\x8f";
}

function createpickupicon(shader) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(distancesquared(level.player.origin, self.origin) > 2250000) {
    waitframe();
  }

  target_alloc(self, (0, 0, 10));
  target_drawsquare(self);
  target_drawsingle(self);
  target_setcolor(self, (1, 1, 1), 0);
  target_setscaledrendermode(self, 0);
  target_showtoplayer(self, level.player);
  target_setshader(self, shader);
  target_flush(self);
  childthread updatepickupicon();
}

function updatepickupicon() {
  self.alpha = 0;
  self.iconsize = 0;
  spawntime = gettime();

  while(true) {
    distance = distance(level.player.origin, self.origin);
    iconisnew = gettime() < spawntime + 2150;
    playercanseeicon = isalive(level.player) && level.player trace::can_see_origin(self.origin + (0, 0, 10), 0);

    if(iconisnew || playercanseeicon) {
      normalizedalpha = 1 - math::normalize_value(0, 1000, distance);
      goalalpha = normalizedalpha * 1.25;
    } else {
      goalalpha = 0;
    }

    if(goalalpha != self.alpha) {
      var_933505b66226933c = clamp((goalalpha - self.alpha) * 0.45, -0.125, 0.125);
      var_17f9e1cf718960b6 = self.alpha + var_933505b66226933c;
      target_setcolor(self, (1, 1, 1), var_17f9e1cf718960b6);
      self.alpha = var_17f9e1cf718960b6;
    }

    normalizedsize = math::normalize_value(100, 1000, distance);
    iconsize = int(math::factor_value(32, 8, normalizedsize) * 1);

    if(iconsize != self.iconsize) {
      target_setminsize(self, iconsize, 0);
      target_setmaxsize(self, iconsize, 0);
      self.iconsize = iconsize;
    }

    waitframe();
  }
}

function indonotspawnlootvolume(entity) {
  var_f501db0f7c897af8 = getEntArray("\xaf\xa5\xa6a\x1cZ&\x13\xae\xd3@\x10\x7f|", #targetname);

  foreach(volume in var_f501db0f7c897af8) {
    if(entity istouching(volume)) {
      return true;
    }
  }

  return false;
}

function has_weapon(weapon) {
  primaryoffhand = self getoffhandprimaryclass();
  secondaryoffhand = self getoffhandsecondaryclass();

  if(isstring(weapon)) {
    all_weapons = self getweaponslistall();

    foreach(item in all_weapons) {
      if(isnullweapon(item)) {
        continue;
      }

      if(weapontype(item) == ",\xe1\x93So\x98\r" && item.basename != primaryoffhand && item.basename != secondaryoffhand) {
        if(item.basename != "\xba\xd7{<Y\x82\x0f\xe8KmT") {
          continue;
        }
      }

      if(item.basename == weapon) {
        return 1;
      }
    }

    return 0;
  }

  assert(isweapon(weapon));
  return self hasweapon(weapon);
}

function set_force_armor_drop(boolean) {
  self.lootforcearmordrop = boolean;
}

function force_armor_drop() {
  return istrue(self.lootforcearmordrop);
}

function function_d9965b34acc04a6b(lootid_array) {
  foreach(loot_id in lootid_array) {
    assert(isDefined(level.loot.types[loot_id]), loot_id + "<dev string:x4c3>");
    grenadename = level.loot.types[loot_id].weapon;
    assert(arraycontains(level.offhands.precached, grenadename) == 1, grenadename + "<dev string:x4de>");
  }

  level.loot.var_c9a7590cf97bdd19 = lootid_array;
}

function swapoffhands() {
  return istrue(level.loot.offhandswap);
}

function function_6b1990ad3882d587(bundlelist) {
  if(!isDefined(bundlelist)) {
    bundlelist = getscriptbundle("\x87eX\xbaayH\xa4h~{\xf4mk9\x16\xf8" + level.gamemodebundle.campaignlootlist);
  }

  if(!isDefined(bundlelist.inventorytype)) {
    return false;
  }

  if(bundlelist.inventorytype != "\xc4\x1f\xf7>\x8b5^e") {
    return false;
  }

  if(level.script != "#\xaf=\xa7g\xcb?n\x0f\n\xc4j\xf67\a\xfb" && level.script != "YkQ\xad\xae\xb6\xcexN\bz") {
    if(getdvarint(@ "sp_inventory", 0) >= 1) {
      setDvar(@ "sp_inventory", 0);
    }
  }

  if(getdvarint(@ "sp_inventory", 0) == 0) {
    return false;
  }

  return true;
}

function function_56d230fc3f79cad0(string) {
  if(lootdebugenabled()) {
    iprintln(string);
  }
}

function function_12be0b72ffed3a1e() {
  thread function_1fb3faf1b2a462eb();
  wait 0.65;

  if(isDefined(level.loot.var_c9a7590cf97bdd19)) {
    foreach(loot_id in level.loot.var_c9a7590cf97bdd19) {
      grenadename = level.loot.types[loot_id].weapon;

      if(!arraycontains(level.offhands.precached, grenadename)) {
        iprintln("<dev string:x4fe>" + grenadename + "<dev string:x51b>");
      }
    }
  }
}

function function_1fb3faf1b2a462eb() {
  while(true) {
    if(!lootdebugenabled()) {
      waitframe();
      continue;
    }

    if(isDefined(level.loot.items)) {
      foreach(item in level.loot.items) {
        line(item.origin, item.origin + (0, 0, 120), (0, 0, 1), 1, 0, 1);
        print3d(item.origin, item.name, (0, 0, 1), 1, 0.5, 1);

        if(islootarmor(item.name)) {
          if(itemworldplaced(item)) {
            sphere(item.origin, 15, (0, 0, 1), 0, 1);
            continue;
          }

          sphere(item.origin, 15, (0, 1, 0), 0, 1);
        }
      }
    }

    waitframe();
  }
}

function lootdebugenabled() {
  return getdvarint(@ "hash_7dfe19d75d304409");
}

# /
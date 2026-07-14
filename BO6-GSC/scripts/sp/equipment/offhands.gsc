/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\offhands.gsc
*********************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\loot;
#using scripts\sp\player\cursor_hint;
#namespace offhands;

function init() {
  if(isDefined(level.offhands)) {
    return;
  }

  level.offhands = spawnStruct();
  level.offhands.firefuncs = [];
  level.offhands.precached = [];
  level.offhands.getammooverridefunctions = [];
  level.player = getEntArray("K_p\x84a\x01", #classname)[0];
  level.player.offhands = spawnStruct();
}

function registerprecachefunc(offhand, precachefunc) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  init();

  if(!arraycontains(level.offhands.precached, offhand)) {
    [[precachefunc]](offhand);
    level.offhands.precached = utility::array_add(level.offhands.precached, offhand);
  }
}

function registeroffhandfirefunc(offhand, firefunc) {
  level.offhands.firefuncs[offhand] = firefunc;
}

function function_96370f3451fa67a0(offhand, firefunc) {
  level.offhands.var_fa509612fac1d668[offhand] = firefunc;
}

function function_165e4499ef04c19(offhand, cursorhintoffset) {
  assert(isDefined(level.offhands));

  if(!isDefined(level.offhands.cursorhintoffsets)) {
    level.offhands.cursorhintoffsets = [];
  }

  level.offhands.cursorhintoffsets[offhand] = cursorhintoffset;
}

function offhandisprecached(offhand) {
  if(arraycontains(level.offhands.precached, offhand)) {
    return 1;
  }

  return 0;
}

function offhandfiremanager() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.offhands)) {
    self.offhands = spawnStruct();
  }

  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;
  childthread function_a9e541565625591b();

  while(true) {
    self waittill("+\xdaq\x17\x8c\xac/\xc0\xa4(*\x81\xf9", weapon);

    if(isDefined(level.offhands.var_fa509612fac1d668) && isDefined(level.offhands.var_fa509612fac1d668[weapon.basename])) {
      self thread[[level.offhands.var_fa509612fac1d668[weapon.basename]]](weapon);
    }

    if(loot::function_6b1990ad3882d587()) {
      lootitem = loot::getcurrentoffhandlootid(weapon.offhandtype);

      if(isDefined(lootitem)) {
        backpackammo = utility::callsharedfunc(#"backpack", #"getbackpackitemcount", level.loot.types[lootitem].lootid);

        if(backpackammo > 0) {
          currammo = level.player getweaponammostock(weapon);
          maxammo = weaponmaxammo(weapon);

          if(currammo < maxammo) {
            availableammo = int(min(backpackammo, maxammo - currammo));
            finalammo = int(min(currammo + availableammo, maxammo));
            level.player setweaponammoclip(weapon, finalammo);
            utility::callsharedfunc(#"backpack", #"hash_525b278b43682d10", level.loot.types[lootitem].lootid, finalammo);
          }
        }
      }
    }

    self.offhands.lastusedoffhandweapon = weapon;
    self.offhands.lastusedoffhandtime = gettime();
    thread analytics::function_5ebdee87090ce61d(weapon);
  }
}

function private function_a9e541565625591b() {
  while(true) {
    self waittill("\xe0\x99\xc7\xf1\a3\x81c\xa5\xe17G", grenade, weapon);

    if(isDefined(level.offhands.firefuncs[weapon.basename])) {
      self thread[[level.offhands.firefuncs[weapon.basename]]](grenade, weapon);
    }
  }
}

function playeroffhandthread(offhandplayerthread) {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level.player childthread[[offhandplayerthread]]();
}

function getweaponoffhandclass(weapon) {
  if(isstring(weapon)) {
    weaponname = weapon;
  } else {
    weaponname = weapon.basename;
  }

  return weaponoffhandclass(weaponname);
}

function overrideweaponoffhandtype(weaponname, isprimarytype) {
  assert(isDefined(weaponname));
  assert(isDefined(isprimarytype));
  assert(isDefined(level.offhands));

  if(!isDefined(level.offhands.weapontypeoverrides)) {
    level.offhands.weapontypeoverrides = [];
  }

  if(isprimarytype) {
    level.offhands.weapontypeoverrides[weaponname] = "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e";
    return;
  }

  level.offhands.weapontypeoverrides[weaponname] = "\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e";
}

function getweaponoffhandtype(weapon) {
  primarytype = "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e";
  secondarytype = "\xfe\x06E\x80wqb\x96\xaa\xa0\x8b\xaaY\x92e\x9e";
  null = "\r+x5";
  weaponobj = isweapon(weapon) ? weapon : makeweapon(weapon);
  weaponname = weaponobj.basename;

  if(isDefined(level.offhands.weapontypeoverrides) && isDefined(level.offhands.weapontypeoverrides[weaponname])) {
    return level.offhands.weapontypeoverrides[weaponname];
  }

  if(weaponobj.offhandtype == "\xe6\xaa6=\x93`Y") {
    return primarytype;
  }

  if(weaponobj.offhandtype == "\x1f^\xe8UA\nY\xd7!") {
    return secondarytype;
  }

  assertmsg(weaponname + "<dev string:x24>");
}

function function_832cbd825d73c35a(gesture, grenadeorigin, visionset, radius) {
  if(!isalive(level.player)) {
    return;
  }

  traceoffset = (0, 0, 18);

  if(!trace::ray_trace_passed(level.player.origin + traceoffset, grenadeorigin + traceoffset, level.player)) {
    return;
  }

  level.player shellshock("\x04d\xff]x\xf00\xa1\v\xffu\x12m)T", 2);
  thread function_24489ae90ea932b8(grenadeorigin, visionset, radius);

  if(level.player isweaponsenabled() && isDefined(level.player.currentweapon) && level.player.currentweapon.basename != "\r+x5") {
    level.player forceplaygestureviewmodel(gesture, undefined, 0.5, 0, 1, 0);
  }
}

function function_24489ae90ea932b8(grenadeorigin, visionset, radius) {
  starttime = gettime();
  playerinradius = 0;
  duration = 10;
  fadeintime = 0.5;
  fadeouttime = 0.2;
  radiussquared = radius * radius;

  while(!utility::time_has_passed(starttime, duration)) {
    transitiontime = 0.05;
    wasplayerinradius = playerinradius;
    playerinradius = distancesquared(level.player.origin, grenadeorigin) <= radiussquared;

    if(playerinradius) {
      if(!wasplayerinradius) {
        transitiontime = fadeintime;
        visionsetnaked(visionset, transitiontime);
      }
    } else if(wasplayerinradius) {
      transitiontime = fadeouttime;
      visionsetnaked("", transitiontime);
    }

    wait transitiontime;
  }

  if(playerinradius) {
    visionsetnaked("", fadeouttime);
  }
}

function function_f11ad2956f075d73() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  var_d3521470f4ad6c1d = 500;
  var_9f1276b53657fe26 = -1;

  while(true) {
    player waittill(":\x8dYuZ$\xf8\x8b^<(");
    currenttime = gettime();
    candetonate = var_9f1276b53657fe26 > 0 && currenttime - var_9f1276b53657fe26 < var_d3521470f4ad6c1d;
    var_9f1276b53657fe26 = currenttime;

    if(candetonate) {
      return 1;
    }
  }
}

function function_1ddd67f9826838b(throwngrenade, ownerweaponobj, pickupstring, pickupsound) {
  self endon("\x1e\xfd\xd1\xa2\a");
  usinglootcards = level.loot.lootpresent == "\xe5c\x0f\x18X,h\x1f\a";

  while(true) {
    if(usinglootcards) {
      throwngrenade.displayfovoverride = 55;
      throwngrenade.displaydistoverride = 130;
      throwngrenade.usedistoverride = 70;
      throwngrenade loot::function_4c12e327d0a714b2(ownerweaponobj.basename, function_ae7e42c967ccbe54(ownerweaponobj.basename));
    } else {
      throwngrenade cursor_hint::create_cursor_hint(undefined, function_ae7e42c967ccbe54(ownerweaponobj.basename), pickupstring, 55, 100, 70, 0);
    }

    cursorhintent = throwngrenade.cursor_hint_ent;
    cursorhintent childthread function_5a3d8556cf563b1c(pickupstring, ownerweaponobj);
    throwngrenade thread function_6f92489777de2414();
    outcome = cursorhintent utility::waittill_any_return("\x91`\xb1\xe7T\x97>", "\x1e\xfd\xd1\xa2\a");

    if(outcome == "\x1e\xfd\xd1\xa2\a") {
      if(isDefined(cursorhintent)) {
        cursorhintent cursor_hint::remove_cursor_hint();
        cursorhintent delete();
      }

      return;
    }

    pickedup = function_55036eabed198cc9(ownerweaponobj);

    if(!pickedup) {
      continue;
    }

    if(isDefined(throwngrenade)) {
      if(isDefined(throwngrenade.trigger)) {
        throwngrenade.trigger delete();
      }

      loot::createnotification(ownerweaponobj.basename);

      if(isDefined(pickupsound)) {
        playsoundatpos(throwngrenade.origin, pickupsound);
      }

      throwngrenade delete();
    }

    break;
  }

  cursorhintent cursor_hint::remove_cursor_hint();
  cursorhintent delete();
}

function private function_6f92489777de2414() {
  self notify("^\x1d\x14\x93\x1b\x8c\xa8a6\xbc@\xba\xb42V^");
  self endon("^\x1d\x14\x93\x1b\x8c\xa8a6\xbc@\xba\xb42V^");

  while(isent(self)) {
    self waittill("\x1e\xfd\xd1\xa2\a");

    if(isent(self)) {
      continue;
    }

    if(isDefined(self.cursor_hint_ent)) {
      self.cursor_hint_ent cursor_hint::remove_cursor_hint();
      self.cursor_hint_ent delete();
    }
  }
}

function function_ae7e42c967ccbe54(weaponname) {
  offset = (0, 0, 5);

  if(isDefined(level.offhands.cursorhintoffsets) && isDefined(level.offhands.cursorhintoffsets[weaponname])) {
    offset = level.offhands.cursorhintoffsets[weaponname];
  }

  return offset;
}

function function_55036eabed198cc9(objweapon) {
  assert(isweapon(objweapon), "<dev string:x57>");

  if(utility::issharedfuncdefined(#"offhands", #"hash_73aa1370e9574af7", 0)) {
    return utility::callsharedfunc(#"offhands", #"hash_73aa1370e9574af7", objweapon);
  }

  hasoffhand = 0;

  foreach(offhand in level.player.offhandinventory) {
    if(issameweapon(offhand, objweapon, 1)) {
      hasoffhand = 1;
      break;
    }
  }

  if(hasoffhand) {
    currentammo = level.player getweaponammoclip(objweapon);
    maxammo = weaponmaxammo(objweapon);

    if(currentammo < maxammo) {
      playsoundatpos(level.player.origin, "\xddV,\xe0}\a-lk\xae\a");
      level.player setweaponammoclip(objweapon, currentammo + 1);
      return 1;
    }
  } else {
    playsoundatpos(level.player.origin, "\xddV,\xe0}\a-lk\xae\a");
    level.player utility_sp::give_offhand(objweapon.basename, 1);
    return 1;
  }

  return 0;
}

function function_5a3d8556cf563b1c(pickupstring, weaponobj) {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\x91`\xb1\xe7T\x97>");
  self endon("\x1e\xfd\xd1\xa2\a");
  currentammo = level.player getweaponammoclip(weaponobj);
  maxammo = weaponmaxammo(weaponobj);
  previousammo = currentammo;

  if(currentammo >= maxammo) {
    self sethintinoperable(1);
    self setHintString(&"equipment/full");
  } else {
    self sethintinoperable(0);
    self setHintString(pickupstring);
  }

  while(true) {
    currentammo = level.player getweaponammoclip(weaponobj);

    if(currentammo != previousammo) {
      if(currentammo >= maxammo) {
        self sethintinoperable(1);
        self setHintString(&"equipment/full");
      } else {
        self sethintinoperable(0);
        self setHintString(pickupstring);
      }
    }

    previousammo = currentammo;
    wait 0.1;
  }
}

function function_e3faa7863b80181e() {
  return !level.player getlocalplayerprofiledata("\x941\xad\xb5\"\xd6\x90\x19\v\x06\xa3\x1f\xa6\xde");
}

function function_6420d132b1547bb7() {
  return level.player getlocalplayerprofiledata("\x941\xad\xb5\"\xd6\x90\x19\v\x06\xa3\x1f\xa6\xde");
}

function function_7bc10723ffa9b0ef(weapon_basename) {
  return isDefined(level.player getheldoffhand()) && level.player getheldoffhand().basename == weapon_basename;
}

function function_b005596bc9960ff8() {
  if(function_9c44e6874f16932e(1 | 64 | 2 | 4 | 8 | 16 | 32)) {
    return false;
  }

  return istrue(level.gamemodebundle.var_87c15807be879e4e);
}
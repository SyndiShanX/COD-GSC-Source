/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_3798db193e76a866.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using script_232f31def1450dbb;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#namespace killstreaks;

function private autoexec __init__system__() {
  system::register("\x01\xdacvmB\xda\xcd\xf1\x81.\x8d(", undefined, undefined, &init);
}

function private init() {
  if(isDefined(level.streakglobals)) {
    return;
  }

  level.streakglobals = spawnStruct();
  level.streakglobals.nextid = 1;
  killstreaklistbundlename = hashcat(%"killstreaklist:", "\x18\xb1\xed\xad\x95\x1a\xe5I\xb2\xf6v}\xdeYp\\Pz\xe0\xd2\x93~");
  utility::flag_wait("p\xdb\xf4\x85c\xa0e\xbe\xcbn\x8a\xcd\x858\x96\xca5");

  if(killstreak_shared::parsestreakbundles(killstreaklistbundlename)) {
    killstreak_shared::function_8ff66c8aa7307817();
  }

  setdevdvarifuninitialized(@ "hash_2c01d701bac5d9d3", 0);

  utility::registersharedfunc(#"ai", #"addactivesmoke", &function_57a13c37de0d91d4);
  utility::registersharedfunc(#"killstreak", #"hash_bf0d4876dd42e072", &function_114f2134914acc09);
  utility::registersharedfunc(#"killstreak", #"hash_63f802e00dc24246", &function_96ab35c78c0d4065);
  utility::registersharedfunc(#"killstreak", #"chopper_door_gunner_destroyed", &function_96ab35c78c0d4065);
}

function createstreakinfo(streakname, owner) {
  streakinfo = spawnStruct();
  streakinfo.streakname = streakname;
  streakinfo.owner = owner;
  streakinfo.id = level.streakglobals.nextid;
  streakinfo.lifeid = 0;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;
  streakinfo.blueprintindex = 0;
  streakinfo.issp = 1;
  level.streakglobals.nextid += 1;

  if(utility::issharedfuncdefined(#"killstreak", #"createcustomstreakdata")) {
    streakinfo = [[utility::getsharedfunc(#"killstreak", #"createcustomstreakdata")]](streakinfo, streakname);
  }

  if(isDefined(streakname) && isDefined(level.streakglobals)) {
    streakindex = level.streakglobals.var_3ec1b34fdde2c734[streakname];
  } else {
    streakindex = 0;
  }

  if(!isDefined(streakindex)) {
    streakindex = -1;
  }

  streakinfo.streakindex = streakindex;
  return streakinfo;
}

function getkillstreakairstrikeheightent() {
  return level.player;
}

function function_1b81d98bbcabbe2(streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_43d0dd62f311ced0, var_5ef14d7356ae07b7, var_35b4a4596c589c7, var_32cc640c2f8eed8a, var_25bc64ea873b36ce) {
  level.player notify("\x02\xeb\x11\xc1\x14Z\xf9\xf5V\x87MP\x85\xf8\xe7\xae\xa4");
  weaponbasename = var_43d0dd62f311ced0 ?? "\xc6\x85\xa3\xf7!\xc1\x1d\x17M\x19byX`\xe9\xa3Y>\xb5\v\n\xec\xf8";
  weaponobj = utility_sp::make_weapon(weaponbasename);
  tabletanimlength = streakinfo.var_9db92fdc0216afae ?? 0;
  tabletanimlength = var_35b4a4596c589c7 ?? tabletanimlength;

  if(!candeploykillstreak(streakinfo, weaponobj, var_32cc640c2f8eed8a)) {
    return false;
  }

  ondeploystart(streakinfo);
  self.lastdroppableweaponobj = self getcurrentweapon();
  switchresult = switchtodeployweapon(weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback);

  if(!istrue(switchresult)) {
    ondeployfinished(streakinfo);
    return false;
  }

  animresult = watchdeployweaponanimtransition(streakinfo, tabletanimlength, var_5ef14d7356ae07b7);
  ondeployfinished(streakinfo);
  return istrue(animresult);
}

function killstreak_setmainvision(visionsetname) {
  if(visionsetname == "") {
    self visionsetthermalforplayer("");
    self visionsetkillstreakforplayer("");
    return;
  }

  visionsetinfo = killstreak_shared::function_a321967789f8fbb5(visionsetname);

  if(!isDefined(visionsetinfo)) {
    return;
  }

  fadeintime = visionsetinfo.fadeintime;

  if(isDefined(visionsetinfo.type) && visionsetinfo.type == "\x16N\xa2*f\xf0~") {
    self visionsetthermalforplayer(visionsetname, fadeintime);
    return;
  }

  self visionsetkillstreakforplayer(visionsetname, fadeintime);
}

function killstreak_setsubvision(visionsetinfo) {}

function function_e6afb7791ed8cc3b(streakname, scorepopup, vodestroyed, destroyedsplash) {
  self.vehiclename = streakname;
  self.scorepopup = scorepopup;
  self.vodestroyed = vodestroyed;
  self.destroyedsplash = destroyedsplash;
}

function registervisibilityomnvarforkillstreak(streakname, omnvarid, omnvarvalue) {
  if(!isDefined(level.killstreak_visbilityomnvarlist)) {
    level.killstreak_visbilityomnvarlist = [];
  }

  assert(isDefined(omnvarid) && omnvarid != "<dev string:x24>", "<dev string:x2b>");

  if(isDefined(level.killstreak_visbilityomnvarlist[streakname]) && isDefined(level.killstreak_visbilityomnvarlist[streakname][omnvarid])) {
    assertmsg("<dev string:x8d>");
    return;
  }

  omnvarvalueexists = 0;

  foreach(var_d22ef51f4a2d0e35 in level.killstreak_visbilityomnvarlist) {
    foreach(existingvalue in var_d22ef51f4a2d0e35) {
      if(omnvarvalue == existingvalue) {
        omnvarvalueexists = 1;
        break;
      }
    }

    if(istrue(omnvarvalueexists)) {
      assertmsg("<dev string:xe3>");
      return;
    }
  }

  level.killstreak_visbilityomnvarlist[streakname][omnvarid] = omnvarvalue;
}

function setvisibiilityomnvarforkillstreak(streakname, omnvarstate) {
  omnvarvalue = undefined;

  if(omnvarstate == "\xf8\x88m") {
    omnvarvalue = 0;
  } else {
    assert(isDefined(level.killstreak_visbilityomnvarlist[streakname][omnvarstate]), "<dev string:x185>");
    omnvarvalue = level.killstreak_visbilityomnvarlist[streakname][omnvarstate];
  }

  self setclientomnvar("\x95\xf8\x93j .ePLu\x96J\xef\xa8\xac\xf8\x81h\xa5j<v", omnvarvalue);
}

function restorekillstreakplayerangles(player) {
  if(player.health <= 0) {
    return;
  }

  waitframe();

  if(isDefined(player.restoreangles)) {
    player setplayerangles((player.restoreangles[0], player.restoreangles[1], 0));
  }

  player.restoreangles = undefined;
}

function killstreak_assigntargetmarkers(user) {
  enemies = [];
  vehicles = [];
  ents = [];
  friendlies = [];

  if(isent(user) && isDefined(level.var_d6ae5339e797f14e)) {
    enemies = getaiarrayinradius(user.origin, level.var_d6ae5339e797f14e, "?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1");
    vehicles = utility_sp::getvehiclearray_in_radius(user.origin, level.var_d6ae5339e797f14e, ["?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1"]);
    ents = getentarrayinradius("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", #classname, user.origin, level.var_d6ae5339e797f14e);
    friendlies = getaiarrayinradius(user.origin, level.var_d6ae5339e797f14e, "O\x15\x1b\xad\x9ff", "75\xffQ\x95\xfe`\x9a");
  } else {
    enemies = getaiarray("?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1");
    vehicles = utility_sp::getteamvehiclearray(["?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1"]);
    ents = getEntArray("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", #classname);
    friendlies = getaiarray("O\x15\x1b\xad\x9ff", "75\xffQ\x95\xfe`\x9a");
  }

  enemiesall = utility::array_combine_unique(enemies, vehicles);

  foreach(ent in ents) {
    if(ent utility::ent_flag("\xb160\xc9\x01\x94N\x81\xa1\x96\xc9\xf8\xf5\xe8|\t!\x06p\x19\x01F\xc6\xe9\xb1\xee\x9e") && !arraycontains(enemiesall, ent)) {
      enemiesall[enemiesall.size] = ent;
    }
  }

  friendlies[friendlies.size] = level.player;
  groupsstruct = spawnStruct();
  groupsstruct.enemytargetmarkergroup = enemiesall;
  groupsstruct.friendlytargetmarkergroup = friendlies;
  groupsstruct.var_344488cff00a0dfc = enemies;
  return groupsstruct;
}

function killstreak_explosionnearai(explodepos, range, team, killstreak) {
  aiarray = getaiarrayinradius(explodepos, range, team);

  if(isarray(aiarray) && aiarray.size > 0) {
    level notify("\xed\xf4\xb1r\xbbx&|\xf6|\x88\xdf{\x8b\x17\xbe\rF\x87k\xff\xa3\xf8\xf3j~" + team, killstreak, aiarray);
  }
}

function killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_99a6a2e0cd210c23, var_f11f4e6a9398d349, premoddamagecallback, postmoddamagecallback, deathcallback) {
  if(isDefined(var_99a6a2e0cd210c23)) {
    [[var_99a6a2e0cd210c23]](streakname);
  }

  if(isDefined(var_f11f4e6a9398d349)) {
    [[var_f11f4e6a9398d349]](streakname);
  }

  if(utility::issharedfuncdefined(#"killstreak", #"killstreakmakevehicle")) {
    killstreakvehicle[[utility::getsharedfunc(#"killstreak", #"killstreakmakevehicle")]](streakname, scorepopup, vodestroyed, destroyedsplash);
  }

  if(utility::issharedfuncdefined(#"killstreak", #"killstreaksetpremoddamagecallback")) {
    killstreakvehicle[[utility::getsharedfunc(#"killstreak", #"killstreaksetpremoddamagecallback")]](streakname, premoddamagecallback);
  }

  if(utility::issharedfuncdefined(#"killstreak", #"killstreaksetpostmoddamagecallback")) {
    killstreakvehicle[[utility::getsharedfunc(#"killstreak", #"killstreaksetpostmoddamagecallback")]](streakname, postmoddamagecallback);
  }

  if(isDefined(postmoddamagecallback)) {
    thread function_eed0e1db9f4f92e5(postmoddamagecallback);
  }

  if(isDefined(deathcallback)) {
    thread function_138573b3d703f2be(deathcallback);
  }
}

function function_eed0e1db9f4f92e5(damagefunc) {
  if(isDefined(self.lastdamagedata)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self.lastdamagedata = spawnStruct();

  while(true) {
    self waittill("\fU`\xc0y\x95", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.lastdamagedata.attacker = eattacker;
    self.lastdamagedata.objweapon = objweapon;
    self.lastdamagedata.meansofdeath = smeansofdeath;
    self.lastdamagedata.damage = idamage;
    self.lastdamagedata.idflags = idflags;
    self.lastdamagedata.origin = origin;
    self.lastdamagedata.angles = angles;

    if(isDefined(damagefunc)) {
      self[[damagefunc]](self.lastdamagedata);
    }
  }
}

function function_138573b3d703f2be(deathfunc) {
  thread function_eed0e1db9f4f92e5(undefined);
  self waittill("\x1e\xfd\xd1\xa2\a");
  self[[deathfunc]](self.lastdamagedata);
}

function function_4e6d4115da4697a1(streakinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_8be31567f21c0cfe) {
  if(!candeploykillstreak(streakinfo, weaponobj)) {
    return false;
  }

  ondeploystart(streakinfo);
  assert(isDefined(weaponobj) && weaponobj.basename != "<dev string:x1ec>", "<dev string:x1f4>" + streakinfo.streakname + "<dev string:x204>");
  cleanupwaitfunc = istrue(keepweapon) ? &waituntilfinishedwithdeployweapon : undefined;
  self.lastdroppableweaponobj = self getcurrentweapon();
  switchresult = switchtodeployweapon(weaponobj, streakinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback);

  if(!istrue(switchresult)) {
    ondeployfinished(streakinfo);
    return false;
  }

  ondeployfinished(streakinfo);
  return true;
}

function ondeploystart(streakinfo) {
  assert(!istrue(streakinfo.isdeploying), "<dev string:x248>" + streakinfo.streakname + "<dev string:x25c>");
  streakinfo.isdeploying = 1;
  streakinfo.owner.isdeploying = 1;
  streakinfo.owner val::set("\xe7];\xa9\xdcL", "z\xbepTa\xd3\xde\xcb\x9a", 0);
  streakinfo.owner val::set("\xe7];\xa9\xdcL", "Q\xb4\x05\xdb\xba:\t\xfdX\xcb\x1b\xd9", 0);
}

function ondeployfinished(streakinfo) {
  streakinfo.isdeploying = 0;
  streakinfo.owner.isdeploying = 0;
  streakinfo.owner val::reset_all("\xe7];\xa9\xdcL");
}

function candeploykillstreak(streakinfo, deployweaponobj, var_32cc640c2f8eed8a) {
  if(!isDefined(var_32cc640c2f8eed8a)) {
    var_32cc640c2f8eed8a = 1;
  }

  if(isDefined(deployweaponobj)) {
    errormsg = candeploykillstreakweapon(streakinfo, deployweaponobj);

    if(isDefined(errormsg)) {
      if(streakinfo.streakname == "t\xb0\x1b\x8e\x966al\x86\x85\xb5+'\v" || streakinfo.streakname == "|'\xf3Fz\xb7\x9bhQ\xcb\x94\x9b") {
        return false;
      }

      if(utility::issharedfuncdefined(#"hud", #"showerrormessage") && istrue(var_32cc640c2f8eed8a)) {
        self[[utility::getsharedfunc(#"hud", #"showerrormessage")]](errormsg);
      }

      return false;
    }
  }

  return true;
}

function candeploykillstreakweapon(streakinfo, objweapon) {
  if(isDefined(objweapon) && self hasweapon(objweapon)) {
    return % "killstreaks/cannot_be_used";
  }

  if(!val::get("\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e") || !val::get("\xe5\x06\xb0\bE\x16")) {
    return % "killstreaks/cannot_be_used";
  }

  if(utility::isusingremote()) {
    return % "killstreaks/cannot_be_used";
  }

  if(istrue(self.oob)) {
    return % "killstreaks/cannot_be_used_outofbounds";
  }

  if(streakinfo.streakname == "7\x11\xd3\xaf\xcd\xa2Y-\bw\xc9\x06\xd7" || streakinfo.streakname == "\"-WR\xd3T\x14\x98\xb6\xc8\x81\xc8\xeau\xae\x85z" || streakinfo.streakname == "\xd3j\\\t\b\n:Vb5") {
    if(istrue(self.isinsideelevator)) {
      return % "killstreaks/cannot_be_used";
    }
  }

  if(istrue(self.hashostage)) {
    return % "killstreaks/cannot_be_used";
  }

  if(self isonladder()) {
    return % "killstreaks/cannot_be_used";
  }

  if(self ismantling()) {
    return % "killstreaks/cannot_be_used";
  }

  if(self isswimming()) {
    return % "killstreaks/cannot_be_used_water";
  }

  if(!self isonground() && !self isswimming()) {
    return % "killstreaks/cannot_be_used";
  }
}

function function_65f8dabf1a67c54d(streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  firedresult = 1;
  weaponobj = makeweapon("\x89>:\xf2\xa3\xf7\x01\x96\xca\x9d\xbc\x13\x9c\x9c\x16\xce\x82\xf2\xe6\xf9\xc2");
  firednotify = "\x86\xad\xfb\xd6\xcba@l*$\xd1\xfaO:";
  self.lastdroppableweaponobj = self getcurrentweapon();
  switchresult = switchtodeployweapon(weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback);

  if(!istrue(switchresult)) {
    return false;
  }

  if(isDefined(streakinfo) && isDefined(streakinfo.var_b41370a4decc071)) {
    val::group_set(streakinfo.var_b41370a4decc071, 0);
    firedresult = watchdeployweaponfired(streakinfo, firednotify, weaponobj, weaponfiredcallback);
    val::group_reset(streakinfo.var_b41370a4decc071);
  } else {
    val::set("\x82\xfc\xfe\xcc\xa8V\x7f\x11\x9a?\x04", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
    firedresult = watchdeployweaponfired(streakinfo, firednotify, weaponobj, weaponfiredcallback);
    val::reset_all("\x82\xfc\xfe\xcc\xa8V\x7f\x11\x9a?\x04");
  }

  return istrue(firedresult);
}

function switchtodeployweapon(deployweaponobj, streakinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(self hasweapon(deployweaponobj)) {
    return 0;
  }

  if(!isDefined(skipfirstraise)) {
    skipfirstraise = 0;
  }

  self giveweapon(deployweaponobj, 0, 0, 0, skipfirstraise);
  switchresult = 1;
  givencallbackresult = callweapongivencallback(streakinfo, weapongivencallback);

  if(!istrue(givencallbackresult)) {
    level.player takeweapon(deployweaponobj);
    return 0;
  }

  thread watchforcancelduringweaponswitch(streakinfo, deployweaponobj);
  thread watchformeleeduringweaponswitch(streakinfo, deployweaponobj);
  switchresult = namespace_ce85794d215160e3::domonitoredweaponswitch(deployweaponobj, isbot(self), streakinfo.var_a0173ee0631cd5e7);
  streakinfo notify("\x04\xc9\xf6\xee:h\xf0\x19P\xff\xec:\xdf\xe0\xc6\x81\x82O|\xec!N\xf8\x90P\x8d");

  if(isDefined(weaponswitchendedcallback)) {
    self thread[[weaponswitchendedcallback]](streakinfo, switchresult);
  }

  waitframe();

  if(!switchresult) {
    cleanupwaitfunc = undefined;
  }

  if(!isalive(self)) {
    return 0;
  }

  thread cleanupdeployweapon(switchresult, streakinfo, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback);
  return switchresult;
}

function callweapongivencallback(streakinfo, weapongivencallback) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x82L\x8b\xb2\x8fZ\xd6G\xb9hVJAEl\x7fN\x9c\xbf+\xfcW\x05z\xc7\xaaj\x11\xcc?:@I");

  if(isDefined(weapongivencallback)) {
    return self[[weapongivencallback]](streakinfo);
  }

  return 1;
}

function private waituntilfinishedwithdeployweapon(streakinfo) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  childthread function_272cc4db5e89c2f6(streakinfo, "~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  childthread function_272cc4db5e89c2f6(self, "\x82L\x8b\xb2\x8fZ\xd6G\xb9hVJAEl\x7fN\x9c\xbf+\xfcW\x05z\xc7\xaaj\x11\xcc?:@I");
  childthread function_272cc4db5e89c2f6(self, "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");

  while(true) {
    self waittill("\xaaa.K\xb9\xc5\x98\xea:\x9f\xecK\xceNGM\xb0\xf3\x8f\x8b\xff\xcc)\xf1?)`Y\xb5z\xd1\xc7\xae\xf8m\r\xc6L", result);

    if(isDefined(result) && result == "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY") {
      if(utility::isusingremote()) {
        continue;
      }
    }

    break;
  }

  self notify("\x83;\x88\xf5?\xcd\xb3R\x1ax\xb0\xe3oH\x89\f\t?\xa0\xfc\x03{\x8bzB\xa1\xe8\xbf$8i\x87\x9c\xd3\xb8E?\x1b&\x83JiW']");
}

function private function_272cc4db5e89c2f6(ent, finishednotify) {
  self endon("\x83;\x88\xf5?\xcd\xb3R\x1ax\xb0\xe3oH\x89\f\t?\xa0\xfc\x03{\x8bzB\xa1\xe8\xbf$8i\x87\x9c\xd3\xb8E?\x1b&\x83JiW']");
  ent waittill(finishednotify);
  self notify("\xaaa.K\xb9\xc5\x98\xea:\x9f\xecK\xceNGM\xb0\xf3\x8f\x8b\xff\xcc)\xf1?)`Y\xb5z\xd1\xc7\xae\xf8m\r\xc6L", finishednotify);
}

function watchforcancelduringweaponswitch(streakinfo, deployweaponobj) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  streakinfo endon("\x04\xc9\xf6\xee:h\xf0\x19P\xff\xec:\xdf\xe0\xc6\x81\x82O|\xec!N\xf8\x90P\x8d");
  self waittill("\x82L\x8b\xb2\x8fZ\xd6G\xb9hVJAEl\x7fN\x9c\xbf+\xfcW\x05z\xc7\xaaj\x11\xcc?:@I");

  if(namespace_ce85794d215160e3::isswitchingtoweaponwithmonitoring(deployweaponobj)) {
    namespace_ce85794d215160e3::abortmonitoredweaponswitch(deployweaponobj);
  }
}

function watchformeleeduringweaponswitch(streakinfo, deployweaponobj) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  streakinfo endon("\x04\xc9\xf6\xee:h\xf0\x19P\xff\xec:\xdf\xe0\xc6\x81\x82O|\xec!N\xf8\x90P\x8d");
  self waittill("qynX\xfd\xe1\x85\xf0\xd8k\x1d\x9f_X\xa2\xee2");

  if(namespace_ce85794d215160e3::isswitchingtoweaponwithmonitoring(deployweaponobj)) {
    namespace_ce85794d215160e3::abortmonitoredweaponswitch(deployweaponobj);
    return;
  }

  self takeweapon(deployweaponobj);
  thread namespace_ce85794d215160e3::domonitoredweaponswitch(self.lastdroppableweaponobj, isbot(self));
}

function watchdeployweaponfired(streakinfo, firednotify, var_44d9a9b10a3ccebf, weaponfiredcallback) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
  self endon("\x82L\x8b\xb2\x8fZ\xd6G\xb9hVJAEl\x7fN\x9c\xbf+\xfcW\x05z\xc7\xaaj\x11\xcc?:@I");

  while(true) {
    firedweaponobj = undefined;
    firedprojectile = undefined;

    switch (firednotify) {
      case #"hash_21a23ad4b32e4f8e":
        self waittill(firednotify, firedweaponobj);
        break;
      case #"hash_77f5cb8818a754f0":
        self waittill(firednotify, firedweaponobj);
        break;
      case #"hash_3989359e2b52d1ba":
        self waittill(firednotify, firedprojectile, firedweaponobj);
        break;
      default:
        self waittill(firednotify);
        break;
    }

    if(!isDefined(firedweaponobj) && self getcurrentweapon() == var_44d9a9b10a3ccebf || isDefined(firedweaponobj) && firedweaponobj == var_44d9a9b10a3ccebf) {
      if(isDefined(weaponfiredcallback)) {
        firedresult = [[weaponfiredcallback]](streakinfo, firedweaponobj, firedprojectile);

        if(!isDefined(firedresult)) {
          assert(isDefined(firedresult), "<dev string:x28f>");
          return false;
        } else if(firedresult == "+\xf80\x1co\xe0_") {
          return false;
        } else if(firedresult == "Pk\xde|T\xf3a\x1d") {
          if(isDefined(level.killstreakweaponfiredcontinue)) {
            [[level.killstreakweaponfiredcontinue]]();
          }

          continue;
        } else if(firedresult == "\xe6]66\x95\xb97") {
          return true;
        } else {
          assertmsg("<dev string:x2f5>");
          return false;
        }
      }

      return true;
    }
  }

  return false;
}

function private watchdeployweaponanimtransition(streakinfo, animlength, var_5ef14d7356ae07b7) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(!isDefined(var_5ef14d7356ae07b7)) {
    var_5ef14d7356ae07b7 = 1;
  }

  utility::callsharedfunc(#"player", #"freezecontrols", 1, undefined, "\xbd/m\x18\x10d~\xffP\xb6p\xd1\x12\x1b\xb0\x1c");

  if(istrue(var_5ef14d7356ae07b7)) {
    thread startweapontabletfadetransition(animlength - 0.3, streakinfo);
  }

  if(istrue(streakinfo.usingtablet)) {
    killstreak_shared::starttabletscreen(streakinfo.streakname, 0.05);
  }

  result = utility::waittill_any_timeout(animlength, "\x1e\xfd\xd1\xa2\a", "Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY", "\x82L\x8b\xb2\x8fZ\xd6G\xb9hVJAEl\x7fN\x9c\xbf+\xfcW\x05z\xc7\xaaj\x11\xcc?:@I");
  utility::callsharedfunc(#"player", #"freezecontrols", 0, undefined, "\xbd/m\x18\x10d~\xffP\xb6p\xd1\x12\x1b\xb0\x1c");

  if(!isDefined(result) || result != "\xb5B\xd7\x904}\x11") {
    streakinfo notify("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
    killstreak_shared::stoptabletscreen(streakinfo.streakname);
    self notify("|\xc9\x8f\x8e\xea\x11\xf9\x9d\xaaE\x17,\xa4\x8f\xfd9\xae\xc8\xf1\xa1N\xfa");
    return false;
  }

  self notify("\x8b\xfa?%o#~0\xc7\xe9\va\xd5Kk$\xb7P\xdc\xfe\xc57\xee\x91\x05\xfd\xef\xa7\xdc");
  return true;
}

function private startweapontabletfadetransition(timedelay, streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  result = utility::waittill_any_timeout(timedelay, "|\xc9\x8f\x8e\xea\x11\xf9\x9d\xaaE\x17,\xa4\x8f\xfd9\xae\xc8\xf1\xa1N\xfa");

  if(!isDefined(result) || result == "|\xc9\x8f\x8e\xea\x11\xf9\x9d\xaaE\x17,\xa4\x8f\xfd9\xae\xc8\xf1\xa1N\xfa") {
    return;
  }

  if(namespace_bc7cdace2d7445a5::isalivesharedfunc()) {
    self playlocalsound("B\xa5\xbaE\xd0\x93\xe26\x9cQ\x8e\xca\xfb\x98\xd1\xb98m\xaf\xc2\x1a\xc7\x882\xfe\xebI\x84\xac\xc3\xc8");
    transitionvision = streakinfo.var_3f048785d9dd35ac ?? "\x96\xe2d\x9f\xfd\a\x86\xc0m\xbc\x9a\x9b%\x93b\x93\xb7\x9c\xd4\xe6\xa9";
    namespace_bc7cdace2d7445a5::function_bfe8df8d71fb2e33(transitionvision);
    result = utility::waittill_any_timeout(0.7, "\x1e\xfd\xd1\xa2\a");

    if(!isDefined(result) || result == "\x1e\xfd\xd1\xa2\a") {
      self stoplocalsound("B\xa5\xbaE\xd0\x93\xe26\x9cQ\x8e\xca\xfb\x98\xd1\xb98m\xaf\xc2\x1a\xc7\x882\xfe\xebI\x84\xac\xc3\xc8");
    }

    namespace_bc7cdace2d7445a5::function_bfe8df8d71fb2e33("");
  }
}

function private cleanupdeployweapon(switchresult, streakinfo, weaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(isDefined(cleanupwaitfunc)) {
    self[[cleanupwaitfunc]](streakinfo);
  }

  if(self hasweapon(weaponobj)) {
    remotetabletweapon = 0;
    mapselectkillstreak = 0;
    isnukeweapon = 0;
    val::set("\"V[\x1a\xa34^e\xceD\xfe\x0f\xee", "mV\x8d+e", 0);
    val::set("\"V[\x1a\xa34^e\xceD\xfe\x0f\xee", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);

    if(istrue(streakinfo.usingtablet)) {
      killstreak_shared::stoptabletscreen(streakinfo.streakname, 0.05, 1);
    }

    if(isDefined(weaponcleanupcallback)) {
      self[[weaponcleanupcallback]](streakinfo, switchresult, weaponobj);
    } else {
      getridofkillstreakdeployweapon(weaponobj);
    }

    val::reset_all("\"V[\x1a\xa34^e\xceD\xfe\x0f\xee");
  }

  if(isDefined(weapontakencallback)) {
    self[[weapontakencallback]](streakinfo);
  }
}

function getridofkillstreakdeployweapon(weaponobj) {
  namespace_ce85794d215160e3::getridofweapon(weaponobj, istrue(self.var_3fe5adfbd1a21c27));
  self.var_3fe5adfbd1a21c27 = undefined;
  currentweapon = self getcurrentweapon();

  if(currentweapon.basename == "\r+x5") {
    namespace_ce85794d215160e3::forcevalidweapon();
  }
}

function registerkillstreakdamagedealingweapon(streakname, var_c8401648e347928c, damagesize) {
  if(!isDefined(level.killstreakweaponmap)) {
    level.killstreakweaponmap = [];
  }

  level.killstreakweaponmap[var_c8401648e347928c] = streakname;
  assert(damagesize == #"oneshot" || damagesize == #"large" || damagesize == #"medium" || damagesize == #"low" || damagesize == #"tick" || damagesize == #"donotregister");

  if(damagesize == #"donotregister") {
    return;
  }

  level.var_ba0e7e71539f4606[var_c8401648e347928c] = damagesize;
}

function killstreak_switchbacklastweapon(deployweapon, immediateswitch, optionaltimedelay) {
  if(isDefined(optionaltimedelay) && optionaltimedelay > 0) {
    self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
    level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
    namespace_bc7cdace2d7445a5::function_3c424b8d0d9f5c37(optionaltimedelay);
  }

  lastweaponobj = self.lastdroppableweaponobj;

  if(!isDefined(lastweaponobj) || !self hasweapon(lastweaponobj)) {
    if(isDefined(self.lastnormalweaponobj)) {
      lastweaponobj = self.lastnormalweaponobj;
    } else {
      lastweaponobj = makeweapon("\x8e\x97\x90cn\xe3\x7f\x88\x81xe");
    }
  }

  if(istrue(immediateswitch)) {
    self switchtoweaponimmediate(lastweaponobj);
  } else {
    self switchtoweapon(lastweaponobj);
  }

  self takeweapon(deployweapon);
}

function function_5fd89a40ee5194a8(streakinfo) {
  assert(isDefined(streakinfo), "<dev string:x36f>");
  self.killstreakinfoinuse = streakinfo;
  thread function_d7761791f5486abd(streakinfo);
}

function function_f4a27de0d6d04f3f(streakinfo) {
  streakinfo notify("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
}

function private function_d7761791f5486abd(streakinfo) {
  self notify("S b\xd5\xba\\\xa1\xe7\xf5\x1e\x9bZ\x05B]\xca}r\xf8\x9c\x1a[\xfd");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("S b\xd5\xba\\\xa1\xe7\xf5\x1e\x9bZ\x05B]\xca}r\xf8\x9c\x1a[\xfd");
  streakinfo waittill("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  self.killstreakinfoinuse = undefined;
  self notify("\x91\x0fv\xb1\xee\x17\xdd\x11( i\n|k\xccd\xecQ:");
}

function getkillstreakinuse() {
  return isDefined(self.killstreakinfoinuse);
}

function function_db9abbb1cebd0770() {
  return self.killstreakinfoinuse;
}

function cantriggerkillstreak() {
  if(getkillstreakinuse() || !val::get("\xe1P+\x1a \xe4\xd7-\xeel]") || istrue(val::get(";\x9eH\n\xc0Y\xf4iI\x03\x90\xa8l\xd7\xa5\x82`\xfd\x84\xdb\x1eb")) || istrue(trigger::isplayeroutofbounds()) || !self isonground() && !self isswimming()) {
    return false;
  }

  return true;
}

function private function_57a13c37de0d91d4(origin, duration, lightradius, heavyradius) {
  addactivesmoke(origin, duration, lightradius, heavyradius);
}

function private function_9190503109dfe26() {
  helper_prompts = [];
  helper_prompts["\xa9\n\xc2\xc9\x1a\x1a%\x92X\xc5"] = &"hash_7829a41cbe38589a";
  helper_prompts["\xaa\f\x14:q\xb8\xc0r\x12J\xe1"] = &"hash_7bac8a8e554a82e2";
  return helper_prompts;
}

function private function_114f2134914acc09(vehicle) {
  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"add_array")) {
    level.player utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\xc0n\xab\"\x13T\"L3nF\xa1\xf1\xf9", function_9190503109dfe26());
  }

  utility::hidehudenable();
}

function private function_96ab35c78c0d4065(streakinfo) {
  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    level.player utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\xc0n\xab\"\x13T\"L3nF\xa1\xf1\xf9");
  }

  utility::hidehuddisable();
}

function function_416a3c5aa9911a6c(streakinfo, endnotification) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo.killnum = 0;
  enemies = getaiarray("?\xb1\xc0\x9a");

  foreach(e in enemies) {
    e childthread function_3481c93038099f1b(streakinfo, self);
  }

  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &function_3481c93038099f1b, streakinfo, self);
  self waittill(endnotification ?? "\x91\x0fv\xb1\xee\x17\xdd\x11( i\n|k\xccd\xecQ:");
  waitframe();
  utility_sp::remove_global_spawn_function("?\xb1\xc0\x9a", &function_3481c93038099f1b);

  iprintln("<dev string:x396>" + streakinfo.killnum);

  if(streakinfo.killnum >= 5) {
    iprintln("<dev string:x3b1>");

    level thread utility_sp::giveachievement_wrapper("\xf4wI\xc1`\xacn2\xa0\xa06\xdfu\xaf\xa48\xc1");
  }
}

function private function_3481c93038099f1b(streakinfo, player) {
  self waittill("\x1e\xfd\xd1\xa2\a", attacker, cause, weaponobj);

  if(!isDefined(weaponobj)) {
    return;
  }

  weaponrootname = getweaponrootstring(weaponobj);

  if(isent(attacker) && attacker == player && isstring(weaponrootname) && issubstr(weaponrootname, streakinfo.streakname)) {
    streakinfo.killnum++;
  }
}

function iskillstreakaffectedbyobb(streakinfo) {
  switch (streakinfo.streakname) {
    case #"hash_11368ff3af541278":
    case #"hash_363a333139801cbd":
      return false;
  }

  return true;
}

function playerkillstreakgetownerlookatignoreents() {
  if(isPlayer(self) || isactor(self)) {
    return [self];
  }

  return undefined;
}
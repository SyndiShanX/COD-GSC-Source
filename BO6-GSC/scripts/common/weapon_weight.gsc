/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\weapon_weight.gsc
********************************************/

#using scripts\common\weapon;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\weapon;
#namespace weapon_weight;

function main() {
  if(!istrue(level.gamemodebundle.weaponweightenabled)) {
    return;
  }

  if(common_inventory::inventory_isenabled()) {
    return;
  }

  if(utility::issharedfuncdefined(#"inventory", #"isbackpackinventoryenabled")) {
    if([[utility::getsharedfunc(#"inventory", #"isbackpackinventoryenabled")]]()) {
      return;
    }
  }

  if(getdvarint(@ "hash_627262dcb37d25cc", 1) == 1) {
    return;
  }

  if(!function_9ed3f515e2439095()) {
    function_b9c9a404b5a0ee(#"hash_b5e67d5d645fe7cf");

    return;
  }

  function_2bf34f2731680abe();

  while(!utility::issharedfuncdefined(#"aggregator", #"registeronplayerspawncallback")) {
    waitframe();
  }

  [[utility::getsharedfunc(#"aggregator", #"registeronplayerspawncallback")]](&function_4d2052877fd34517);
}

function function_2bf34f2731680abe() {
  level.weaponweightdata = [];
  level.weaponweightdata["\xd6T\xe2:&\x88\xb2n\x8fl\xb1E"] = 1;
  level.weaponweightdata["\xfb\x8d\x82Y\x87\x10Y$\xa9a\xb5\x7f\x9e"] = 1.2;
  level.weaponweightdata["\r+x5"] = 1.2;
  level.weaponweightdata["7\x8a\xdf2J"] = 1;
  level.weaponweightdata[":A$\xf2\xf7\xbeZCd=4w\xc3"] = 1;
  level.weaponweightdata["\xc96\x8e\xeao\"\xe8\xa2\xa6\xaf"] = 0.97;
  level.weaponweightdata["P\xaa\xb7\xaf\x06\xa1p\xa7V\xd3\f\x83\x97\b"] = 0.94;
  level.weaponweightdata["\xf4\fkX\xf1>\xd1\xb7m\xbc\xbf\t(\x1f"] = 0.91;
  level.weaponweightdata["lMl$\x02\x89\xc1\x98_O(\xb9\x06"] = 0.88;
  level.weaponweightdata["\xa8\xfb1^\x05\x0e\xef\xf1mE"] = 0.85;
  level.weaponweightdata["\x05\x1cx\xf6\xf2e\x1e\xc0\x01\x86"] = 0.82;
  level.weaponweightdata["\xb6\\\xb9/4\xa7\xff\xfd5<La\xbc"] = 0.8;
  level.weaponweightdata["\xc1)\xc4\xbcb\x82D\x8e\x18rhe\xeb\xce\x8d\xdc\x0e"] = 0.8;
  level.weaponweightdata["\x98\xd5\xc7\x8cBn\x13\x03\xc8O\x90\x98\x97"] = makeweapon("\xb8\x84$/n\xce\xc8$l\xff\xd3U\x87");
}

function function_4d2052877fd34517() {
  if(isbot(self)) {
    return;
  }

  while(!isDefined(self getcurrentweapon()) || isnullweapon(self getcurrentweapon())) {
    waitframe();
  }

  thread monitorweaponthrow();
  thread monitorstowedweapon();
}

function function_783d25f67c875f60(currentweapon, stowedweapon) {
  assert(isDefined(currentweapon), "<dev string:x24>");
  assert(isDefined(stowedweapon), "<dev string:x24>");
  currentweapongroup = weapon::getweapongroup(currentweapon);
  stowedweapongroup = weapon::getweapongroup(stowedweapon);

  if(weapon::isfistweapon(currentweapon)) {
    currentweapongroup = "\r+x5";
  }

  if(weapon::isfistweapon(stowedweapon)) {
    stowedweapongroup = "\r+x5";
  }

  if(!isDefined(currentweapongroup)) {
    stowedweapongroup = "\r+x5";
  }

  if(!isDefined(stowedweapongroup)) {
    stowedweapongroup = "\r+x5";
  }

  stowedspeedscale = level.weaponweightdata[stowedweapongroup];
  currentspeedscale = level.weaponweightdata[currentweapongroup];
  assert(isDefined(stowedspeedscale) && isDefined(currentspeedscale), "<dev string:x82>");
  return (stowedspeedscale + currentspeedscale) / 2;
}

function monitorstowedweapon() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self setmovespeedscale(1);

  while(true) {
    thread function_7fff6040e44eb73d();
    thread monitorweapondrop();
    thread monitorweaponswitch();
    thread monitorweapontaken();
    self waittill("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
  }
}

function function_cfa61ab4d03ed7a6(currentweapon, stowedweapon) {
  if(function_7da2ca0943cb171b(currentweapon, stowedweapon)) {
    if(!perk::_hasperk("|t\xe7\x88d\xb1\a\xc3\xfe\x9f\x81\xf07\x9c\xf0\xabDX\x14\xc9P2")) {
      perk::giveperk("|t\xe7\x88d\xb1\a\xc3\xfe\x9f\x81\xf07\x9c\xf0\xabDX\x14\xc9P2");
    }

    return;
  }

  if(perk::_hasperk("|t\xe7\x88d\xb1\a\xc3\xfe\x9f\x81\xf07\x9c\xf0\xabDX\x14\xc9P2")) {
    perk::removeperk("|t\xe7\x88d\xb1\a\xc3\xfe\x9f\x81\xf07\x9c\xf0\xabDX\x14\xc9P2");
  }
}

function function_7da2ca0943cb171b(currentweapon, stowedweapon) {
  return function_a8fbaa1be31a12e6(currentweapon) && function_a8fbaa1be31a12e6(stowedweapon);
}

function function_a8fbaa1be31a12e6(weapon) {
  weapongroup = weapon::getweapongroup(weapon);

  switch (weapongroup) {
    case #"hash_34340d457a63e7f1":
    case #"hash_86b11ac21f992552":
    case #"hash_a1f27f97be15d620":
    case #"hash_db653a4972b3c13b":
      return 1;
    case #"hash_f4cd588fc5c3d2d5":
      if(weapon::isfistweapon(weapon)) {
        return 1;
      } else {
        return 0;
      }
    default:
      return 0;
  }
}

function monitorweapondrop() {
  self endon("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
  self waittill("\xcfdJW\x7f#y\xdc\x84I\xc2\x98\x12Z");
  self notify("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
}

function monitorweaponswitch() {
  self endon("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
  self waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY");
  self notify("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
}

function monitorweapontaken() {
  self endon("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
  self waittill("\xd7&^\xb1\xfa\xb1\x87fC>\xc7*");
  self notify("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
}

function function_7fff6040e44eb73d() {
  self notify("o\xd7\xce\f\xf7\xc4\x91\x1b\xb0\x06\xb7~1\xd1\xd0\x95\xf0\r\x18\xed");
  self endon("o\xd7\xce\f\xf7\xc4\x91\x1b\xb0\x06\xb7~1\xd1\xd0\x95\xf0\r\x18\xed");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("5\xa8V\xb2\am\xe3\x10^7\xa9\x1e:V\xd4\x98\xfb\xf1\xd5\xc2\x94\xec\x12");
  wait 1;
  currentweapon = self getcurrentweapon();
  stowedweapon = function_926c1ce98e85f66a(currentweapon);

  if(function_60e800c2bd6a975f(currentweapon, stowedweapon)) {
    function_cfa61ab4d03ed7a6(currentweapon, stowedweapon);
  }
}

function function_60e800c2bd6a975f(currentweapon, stowedweapon) {
  return !function_fe0b742c122a066f(currentweapon) && !function_fe0b742c122a066f(stowedweapon);
}

function monitorweaponthrow() {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self notify("c{\xda4\x1e\xa25{}]B\xd9][\x7f\xf7d)\x194\xc0\xc3Y\xf5~O\xe58$\x19\xdf");
  self endon("c{\xda4\x1e\xa25{}]B\xd9][\x7f\xf7d)\x194\xc0\xc3Y\xf5~O\xe58$\x19\xdf");

  while(true) {
    success = function_e4ea67ef825addcc();

    if(!success) {
      continue;
    }

    if(!isalive(self)) {
      continue;
    }

    if(self isthrowinggrenade()) {
      continue;
    }

    eyeposition = self getEye();
    fwdvec = anglesToForward(self getplayerangles());
    fwdvelocity = getdvarint(@ "hash_f8a1a4bd815c29d6", 2300);
    upvelocity = getdvarint(@ "hash_c969401c8c8c438c", 900);
    rightvelocity = getdvarint(@ "hash_6ca568f473c39feb", 0);
    weaponobj = self.currentweapon;
    curweapon = self dropitem(weaponobj);
    nextweapon = function_926c1ce98e85f66a(weaponobj);
    inventory_utility::forcevalidweapon(nextweapon);

    if(!isDefined(curweapon)) {
      continue;
    }

    itemcenterofmass = curweapon physics_getentitycenterofmass();

    if(isDefined(itemcenterofmass)) {
      itemcenterofmass = itemcenterofmass["-\x9d\x16\xf4m}\x12M"];
    } else {
      itemcenterofmass = curweapon.origin;
    }

    velocityvector = (0, 0, 0);
    velocityvector += anglesToForward(self getplayerangles()) * fwdvelocity;
    velocityvector += anglestoup(self getplayerangles()) * upvelocity;
    velocityvector += anglestoright(self getplayerangles()) * rightvelocity;
    weaponangles = curweapon gettagangles("\xfd\xef\xc3\r\xb4\xad\x84p\x84", 1);

    if(!isDefined(weaponangles)) {
      weaponangles = curweapon.angles;
    }

    weaponangles = vectortoangles(anglestoleft(weaponangles));
    curweapon.angles = weaponangles;
    curweapon physicslaunchserveritem(itemcenterofmass, velocityvector);
    reductionamount = getdvarfloat(@ "hash_c114337411a669ce", 0.4);
    bodyid = curweapon physics_getbodyid(0);
    bodyangvel = physics_getbodyangvel(bodyid) * reductionamount;
    physics_setbodyangvel(bodyid, bodyangvel[0], bodyangvel[1], bodyangvel[2]);
    curweapon.owner = self;
    curweapon.isweaponent = 1;
    curweapon thread function_9113f3acfed00f6b();
    curweapon thread function_e5493718ce028683();

    curweapon thread function_862b40a762768987();
  }
}

function function_9113f3acfed00f6b() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xfc\xc7\x7fM\x92\x03sjD;\xa1\xa1b\x8b>\xf4\xa4\xd05\x8ca");
  self endon("c{\xda4\x1e\xa25{}]B\xd9][\x7f\xf7d)\x194\xc0\xc3Y\xf5~O\xe58$\x19\xdf");
  setDvar(@ "hash_951759aeea8e4651", self getentitynumber());
  self.var_5effb6bd0e756d75 = 0;
  self.velocity = (0, 0, 0);

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.lastorigin)) {
      self.lastorigin = self.origin;
    }

    if(self.lastorigin == self.origin) {
      self.var_5effb6bd0e756d75++;
    } else {
      self.var_5effb6bd0e756d75 = 0;
      self.velocity = self.origin - self.lastorigin;
      self.lastorigin = self.origin;
    }

    waitframe();
  }
}

function weaponent_ismoving() {
  if(!isDefined(self.velocity)) {
    self.velocity = (0, 0, 0);
  }

  if(!isDefined(self.var_5effb6bd0e756d75)) {
    self.var_5effb6bd0e756d75 = 0;
  }

  return self.var_5effb6bd0e756d75 < 3;
}

function function_e5493718ce028683() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.owner endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xfc\xc7\x7fM\x92\x03cjD;\xa1\xa1b\x8b>\xf4\xa4\xd0u\x8ca");
  self endon("c{\xda4\x1e\xa25{}]B\xd9][\x7f\xf7d)\x194\xc0\xc3Y\xf5~O\xe58$\x19\xdf");

  while(true) {
    self waittill("H\xa7\x16?g", ent);
    print(ent);

    if(!weaponent_ismoving()) {
      return;
    }

    if(istrue(player_utility::playersareenemies(ent, self.owner))) {
      ent dodamage(1, self.origin, self.owner, self, "\xac6\xc1;\x9c|\xd5]5\x80\xcb~\xb5\xe7\xb4\xa1", level.weaponweightdata["\x98\xd5\xc7\x8cBn\x13\x03\xc8O\x90\x98\x97"]);
      thread function_74098bcfcea563e3(ent);
      self notify("\xfc\xc7\x7fM\x92\x03cjD;\xa1\xa1b\x8b>\xf4\xa4\xd0u\x8ca");
    }
  }
}

function function_74098bcfcea563e3(victim) {
  itemcenterofmass = self physics_getentitycenterofmass();

  if(isDefined(itemcenterofmass)) {
    itemcenterofmass = itemcenterofmass["-\x9d\x16\xf4m}\x12M"];
  } else {
    itemcenterofmass = self.origin;
  }

  velocityvector = (0, 0, 0);
  var_27a5fc1624eb7fd5 = utility::flatten_vector(victim.origin - self.origin);
  horizontaldir = vectorNormalize(var_27a5fc1624eb7fd5) * -1;
  verticaldir = (0, 0, 1);
  directionvec = vectorcross(horizontaldir, verticaldir);
  fwdvelocity = getdvarint(@ "hash_80fc8b66727e455b", 575);
  upvelocity = getdvarint(@ "hash_5fe48f197d41a48b", 450);
  rightvelocity = getdvarint(@ "hash_6aba3378104e2482", 0);
  velocityvector = (directionvec[0] * fwdvelocity, directionvec[1] * rightvelocity, directionvec[2] * upvelocity);
  weaponangles = self gettagangles("\xfd\xef\xc3\r\xb4\xad\x84p\x84", 1);

  if(!isDefined(weaponangles)) {
    weaponangles = self.angles;
  }

  weaponangles = vectortoangles(anglestoleft(weaponangles));
  self.angles = weaponangles;
  self physicslaunchserveritem(itemcenterofmass, velocityvector);
  reductionamount = getdvarfloat(@ "hash_c114337411a669ce", 0.4);
  bodyid = self physics_getbodyid(0);
  bodyangvel = physics_getbodyangvel(bodyid) * reductionamount;
  physics_setbodyangvel(bodyid, bodyangvel[0], bodyangvel[1], bodyangvel[2]);
}

function function_926c1ce98e85f66a(curweapon) {
  if(!isDefined(self.equippedweapons)) {
    return;
  }

  if(!isDefined(curweapon)) {
    return;
  }

  retweapon = undefined;

  foreach(weapon in self.equippedweapons) {
    if(!isDefined(weapon)) {
      continue;
    }

    if(!weapon::iscacprimaryorsecondary(weapon) && !weapon::isfistweapon(weapon)) {
      continue;
    }

    if(isDefined(curweapon.basename) && curweapon.basename == weapon.basename) {
      continue;
    }

    if(function_fe0b742c122a066f(weapon)) {
      continue;
    }

    retweapon = weapon;
    break;
  }

  if(!isDefined(retweapon) || isnullweapon(retweapon)) {
    retweapon = makeweapon(level.defaultfist);
    inventory_utility::_giveweapon(retweapon);
  }

  return retweapon;
}

function function_fe0b742c122a066f(objweapon) {
  if(!isDefined(objweapon)) {
    return false;
  }

  if(weapon::isunderwaterweapon(objweapon) || weapon::isclimbweapon(objweapon)) {
    return true;
  }

  return false;
}

function function_e4ea67ef825addcc() {
  childthread function_382ff7d56197b0ce();
  childthread function_567312eb1195a968();
  self waittill("B~\xdf\x98(g\x16\x1e\xe4s\xf9\xce\xe6\xf5", msg);
  self notifyonplayercommandremove("\xbb\xb2,\ao7*4N\xdbwC\xde\x9b:\x93o\x1bcY\xc9", "\xca\xc2c\x1dZ\xf6s\xcd6o\xa3\x01\xc8");
  self notifyonplayercommandremove("\xeee,\xe0{\xdc\xa249{w\xd2\x84S", "\x90\xf7*V\x96\x12\x01\xaaA\\Y=\x93C");
  return msg == "\xe6]66\x95\xb97";
}

function function_382ff7d56197b0ce() {
  self endon("B~\xdf\x98(g\x16\x1e\xe4s\xf9\xce\xe6\xf5");
  self notifyonplayercommand("\xeee,\xe0{\xdc\xa249{w\xd2\x84S", "\x90\xf7*V\x96\x12\x01\xaaA\\Y=\x93C");
  self waittill("\xeee,\xe0{\xdc\xa249{w\xd2\x84S");
  self notify("B~\xdf\x98(g\x16\x1e\xe4s\xf9\xce\xe6\xf5", "\xe6]66\x95\xb97");
}

function function_567312eb1195a968() {
  self endon("B~\xdf\x98(g\x16\x1e\xe4s\xf9\xce\xe6\xf5");
  self notifyonplayercommand("\xbb\xb2,\ao7*4N\xdbwC\xde\x9b:\x93o\x1bcY\xc9", "\xca\xc2c\x1dZ\xf6s\xcd6o\xa3\x01\xc8");
  var_10f4ea091f76afd8 = ["\xbb\xb2,\ao7*4N\xdbwC\xde\x9b:\x93o\x1bcY\xc9"];
  msg = utility::function_a3a76e5682afb6a0(var_10f4ea091f76afd8, ["B~\xdf\x98(g\x16\x1e\xe4s\xf9\xce\xe6\xf5"], 0.75);
  self notify("B~\xdf\x98(g\x16\x1e\xe4s\xf9\xce\xe6\xf5", msg);
}

function function_cd2c666320c32290(var_7292a66bd45390b5, var_17e6ade2eba9c6a4, time) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  ent = spawnStruct();
  ent.threads = 0;

  foreach(endonnotify in var_17e6ade2eba9c6a4) {
    self endon(endonnotify);
  }

  foreach(stringnotify in var_7292a66bd45390b5) {
    childthread utility::waittill_string_no_endon_death(stringnotify, ent);
    ent.threads++;
  }

  while(ent.threads) {
    if(ent.threads == 1) {
      if(isDefined(time)) {
        ent childthread utility::timeout_struct(time);
        ent waittill("s>H\xe6\xfb\xe6Gn", msg);

        if(msg == "\xb5B\xd7\x904}\x11") {
          self notify("\xa5 \xa1\x99\xf0\x10\xcf\xba\xf2'w\b\xbd\xd9\xa8|\xed\xd1I\xa1", "\xb5B\xd7\x904}\x11");
        } else {
          self notify("\xa5 \xa1\x99\xf0\x10\xcf\xba\xf2'w\b\xbd\xd9\xa8|\xed\xd1I\xa1", "\xe6]66\x95\xb97");
        }

        ent.threads--;
      }

      continue;
    }

    ent waittill("s>H\xe6\xfb\xe6Gn", message);
    ent.threads--;
  }

  ent notify("&\xc7\xee");
}

function function_862b40a762768987() {
  self endon("<dev string:xda>");
  self.owner endon("<dev string:xe3>");
  self endon("<dev string:xf1>");

  setdevdvarifuninitialized(@ "hash_5b1da1bb2986067d", 0);

  cacheddvarvalue = 0;

  while(true) {
    if(!weaponent_ismoving()) {
      return;
    }

    currentdvarval = getdvarint(@ "hash_5b1da1bb2986067d", 0);

    if(currentdvarval != cacheddvarvalue) {
      if(currentdvarval == 1) {
        self.owner dodamage(10, self.origin, self.owner, self, "<dev string:x114>", level.weaponweightdata["<dev string:x128>"]);
      }

      cacheddvarvalue = currentdvarval;
    }

    wait 0.25;
  }
}

# /
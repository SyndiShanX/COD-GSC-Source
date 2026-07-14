/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\damagefeedback.gsc
*****************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#using scripts\sp\fakeactor;
#namespace damagefeedback;

function init() {
  function_9ed56afce1bd1ec();

  if(getdvarint(@ "hash_f07ae454d79d2299")) {
    return;
  }

  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["\xc6\xf6\xee\xeb#\xc2\xadXg+"] = 35;
  level.hitmarkerpriorities["7\xfd\x90\xc0\b\xb3L\xe5"] = 50;
  level.hitmarkerpriorities["\xc9\x95q\x89\xdb\xc5\xae\x92^\xc5\xb0"] = 50;
  level.hitmarkerpriorities["\x86s}\xea\xe7\xf5\xebQS3\xcd"] = 85;
  utility::registersharedfunc(#"hitmarker", #"updateDamageFeedback_SharedFunc", &updatedamagefeedback);
  ui::lui_registercallback("m\xbe\a\x7fD,\xabu\xf482S\xb3c\xe0\xd1\xf4^G\xbe\xac\xf5\xb5\xc1\x9f\x8f\xe2\xf01\xe4u\x9a\xab", &function_1e2b773efc04ca2b);
}

function private function_1e2b773efc04ca2b(value) {
  level.hitmarkersvisible = level.player getlocalplayerprofiledata("\xc11\xf7\xa4\xbf\"\xa7\xd2T\xf9c\xc0\x9e\xe3\x94\xd6\xd7\x7fj\xb3\xbe\x05\xa5U\xd2\xbd");
}

function damagefeedback_took_damage(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon) {
  if(getdvarint(@ "hash_f07ae454d79d2299")) {
    return;
  }

  if(!isDefined(attacker) || !function_d1db8b7d17da9780(attacker) || attacker == self || damage <= 0) {
    return;
  }

  bhflags = function_a8255750442cc222();
  typehit = function_a8bb30a94d5ee8e6("7\xfd\x90\xc0\b\xb3L\xe5", bhflags);
  hitmarkertype = "7\xfd\x90\xc0\b\xb3L\xe5";

  if(isDefined(objweapon)) {
    if(damage <= weapongetdamagemin(objweapon)) {
      hitmarkertype = "\xc6\xf6\xee\xeb#\xc2\xadXg+";
    } else if(damage >= weapongetdamagemax(objweapon)) {
      hitmarkertype = "\x86s}\xea\xe7\xf5\xebQS3\xcd";
    }
  }

  waskilled = 0;
  headshot = 0;

  if(isai(self)) {
    waskilled = !isalive(self);
    headshot = isheadshot(partname);
  }

  level.player thread updatedamagefeedback(typehit, waskilled, headshot, hitmarkertype, self, direction_vec, point, meansofdeath, objweapon);
}

function private function_d1db8b7d17da9780(attacker) {
  if(isPlayer(attacker)) {
    return true;
  }

  if(attacker vehicle::is_vehicle() && isent(attacker.driver) && isPlayer(attacker.driver)) {
    return true;
  }

  return false;
}

function updatedamagefeedback(icontype, killingblow, headshot, hitmarkertype, victim, direction_vec, point, meansofdeath, objweapon) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(hitmarkertype)) {
    hitmarkertype = "7\xfd\x90\xc0\b\xb3L\xe5";
  }

  switch (icontype) {
    case #"hash_b7211051d1c74da":
    case #"hash_251e2c7ad46ab2a1":
    case #"hash_2f87b65a1756fbc1":
    case #"hash_2fc100f2b74f0620":
    case #"hash_37478a6383bb736d":
    case #"hash_5f73db46ecb712e5":
    case #"hash_83eadc5c16357f57":
    case #"hash_a1c8ae5eec4e0bc2":
    case #"hash_a38fa9efabd2c0a4":
    case #"hash_eafcd4d14551921f":
    case #"hash_f3a481e6812a61ae":
    case #"hash_ff2b6c8c33ed9959":
      setomnvar("(\xff\x0fkq4\xa9\xb8V\x9dJL2\xd8\xd08;\xf29\xc6", icontype);
      self setclientomnvar("\xcak_\x06\xac5\xb0_\xda\x92\xf0\x1e\xa3\xcf\xb8\x97\"\xfa\xbd\x95i~\x80+h#\xd1", gettime());
      updatehitmarker(hitmarkertype, killingblow, headshot, victim, direction_vec, point, meansofdeath, objweapon);
      break;
    case #"hash_db653a4972b3c13b":
      break;
    default:
      updatehitmarker(hitmarkertype, killingblow, headshot, victim, direction_vec, point, meansofdeath, objweapon);
      break;
  }
}

function updatehitmarker(markertype, killingblow, headshot, victim, direction_vec, point, meansofdeath, objweapon) {
  if(getdvarint(@ "hash_2fb5684532ad1a80")) {
    return;
  }

  if(!isDefined(markertype)) {
    return;
  }

  if(!isDefined(killingblow)) {
    killingblow = 0;
  }

  if(!isDefined(headshot)) {
    headshot = 0;
  }

  if(isDefined(victim) && isDefined(victim.team) && victim.team == "O\x15\x1b\xad\x9ff") {
    return;
  }

  priority = gethitmarkerpriority(markertype);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;
  bhflags = 0;

  if(istrue(killingblow)) {
    bhflags |= 16;
  }

  if(istrue(headshot)) {
    bhflags |= 8;
  }

  if(isent(victim)) {
    bhflags |= victim function_a8255750442cc222();

    if(!victim fakeactor::is_fakeactor() && !isai(victim) && !isPlayer(victim)) {
      bhflags |= 64;
    }
  }

  markertype = function_a8bb30a94d5ee8e6(markertype, bhflags);
  bhflags = function_c989e148bc907320(markertype, bhflags);

  if(isDefined(objweapon) && isDefined(victim) && isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.hitmarkersounds) && !istrue(level.damagefeedbacknosound)) {
    self function_cea605637d2087ea(victim, objweapon, point, direction_vec, bhflags, meansofdeath);
  }

  if(!isDefined(level.hitmarkersvisible)) {
    level.hitmarkersvisible = level.player getlocalplayerprofiledata("\xc11\xf7\xa4\xbf\"\xa7\xd2T\xf9c\xc0\x9e\xe3\x94\xd6\xd7\x7fj\xb3\xbe\x05\xa5U\xd2\xbd");
  }

  if(isusingstackablehitmarker()) {
    playstackablehitmarker(markertype, killingblow, headshot, victim, meansofdeath, objweapon);
    return;
  }

  if(level.hitmarkersvisible) {
    playhitmarker(markertype, headshot, killingblow);
  }
}

function private playstackablehitmarker(markertype, killingblow, headshot, victim, meansofdeath, objweapon) {
  if(level.hitmarkersvisible) {
    hitmarkertype = function_1c99856edc1180bb(self, objweapon, meansofdeath);
    markerflag = 0;

    switch (hitmarkertype) {
      case 1:
        markerflag |= 1 << 0;

        switch (markertype) {
          case #"hash_2f87b65a1756fbc1":
          case #"hash_ff2b6c8c33ed9959":
            markerflag |= 1 << 4;
            break;
          case #"hash_a38fa9efabd2c0a4":
            markerflag |= 1 << 5;
            break;
          default:
            break;
        }

        if(killingblow) {
          markerflag |= 1 << 1;
        }

        if(headshot) {
          markerflag |= 1 << 3;
        }

        utility::callsharedfunc(#"hud", #"hash_82fe4f75d53751e1", "\x97\x92l\xbf\xbey\xfdQ\xd1>8\xa3?\xe6 YS\xd0\xe0{\x952", markerflag);
        break;
      case 2:
        markerflag |= 1 << 0;

        if(istrue(killingblow)) {
          markerflag |= 1 << 1;
        }

        utility::callsharedfunc(#"hud", #"hash_82fe4f75d53751e1", "]{UK\x89c1}\x9b\xf0\x8eJx\\77\b:Tf\xb0", markerflag);
        break;
    }
  }

  if(istrue(victim.var_b65b56245fb71fbc)) {
    if(isDefined(victim.var_ecdf7ff158ce47bf) && !istrue(killingblow)) {
      alias = victim.var_ecdf7ff158ce47bf;
    } else if(isDefined(victim.var_6e8b1256c89629a6) && istrue(killingblow)) {
      alias = victim.var_6e8b1256c89629a6;
    }

    if(isDefined(alias)) {
      namespace_bc7cdace2d7445a5::playsoundtoplayersharedfunc(alias, self, victim);
    }
  }
}

function private playhitmarker(markertype, headshot, killingblow) {
  setomnvar("\xd8\xf8\x96g\xf1U\xc3\x85\x9d\x12\x1d\xa9\xe7\xf6\xc8", markertype);
  self setclientomnvar("F\xb0\xd6,\x9d+\xbe\x99e\x95F1\v\xb1\xad_\xcd\xb7tK\xcc\xe5", gettime());

  if(killingblow) {
    setomnvar("\x1e\xf4\x87\x05\x8e\x13\xe8]_\xd0\x0e\xd19\xdb\x95\x95\"\x1b\xc8H", 1);
  } else {
    setomnvar("\x1e\xf4\x87\x05\x8e\x13\xe8]_\xd0\x0e\xd19\xdb\x95\x95\"\x1b\xc8H", 0);
  }

  if(headshot) {
    setomnvar("h\x88\x1f\x8c\x19:\xd0\xf8\xd98\x9d\x89\x97\x1cR\xa6\x89\xca1K\xabg7\xa3", 1);
    return;
  }

  setomnvar("h\x88\x1f\x8c\x19:\xd0\xf8\xd98\x9d\x89\x97\x1cR\xa6\x89\xca1K\xabg7\xa3", 0);
}

function private isusingstackablehitmarker() {
  return istrue(level.gamemodebundle.var_d461051800a7f85e);
}

function private function_1c99856edc1180bb(attacker, objweapon, meansofdeath, isbulletdamage) {
  if(utility::isweaponthrowingknife(objweapon)) {
    return 1;
  }

  if(isDefined(meansofdeath)) {
    if(utility::isbulletdamage(meansofdeath)) {
      return 1;
    }

    if(utility::ismeleedamage(meansofdeath)) {
      return 1;
    }
  }

  return 2;
}

function private function_a8bb30a94d5ee8e6(markertype, bhflags) {
  if(bhflags & 4) {
    return "5\x96\x1dny\x19\x15\xd4\xb8v\xcdPG";
  }

  if(bhflags & 2) {
    return "\x91\xe29V!|\x8a[";
  }

  return markertype;
}

function private function_c989e148bc907320(markertype, bhflags) {
  if(markertype == "5\x96\x1dny\x19\x15\xd4\xb8v\xcdPG") {
    return (bhflags | 4);
  }

  if(markertype == "\x91\xe29V!|\x8a[") {
    return (bhflags | 2);
  }

  return bhflags;
}

function gethitmarkerpriority(hitmarkertype) {
  if(!isDefined(level.hitmarkerpriorities[hitmarkertype])) {
    return 0;
  }

  return level.hitmarkerpriorities[hitmarkertype];
}

function isheadshot(partname) {
  if(!isDefined(partname)) {
    return false;
  }

  if(isstring(partname) && !isxhash(partname)) {
    partname = getxhash(partname);
  }

  switch (partname) {
    case #"j_head_pv_z":
    case #"j_neck":
    case #"j_head_pv_horizontal":
    case #"j_head":
      return true;
    default:
      return false;
  }

  return false;
}

function function_cba21d645862bfd5(bhflags) {
  now = gettime();

  if((self.var_2b03ba19b8a99b99 ?? 0) != now) {
    self.bullethitflags = 0;
  }

  self.bullethitflags = (self.bullethitflags ?? 0) | bhflags;
  self.var_2b03ba19b8a99b99 = now;
}

function function_a8255750442cc222() {
  if(!isDefined(self.bullethitflags)) {
    return 0;
  }

  now = gettime();

  if((self.var_2b03ba19b8a99b99 ?? 0) != now) {
    self.bullethitflags = 0;
  }

  return self.bullethitflags;
}

function function_9ed56afce1bd1ec() {
  if(!isDefined(level.var_a27d9834e7957cf6)) {
    level.var_a27d9834e7957cf6 = [];
  }

  function_897bf9557f2742a6("\xa6\xeb\x1ae\x85#");
  function_897bf9557f2742a6("\xf8\xe6^\xd1\x93\a.\xe3");
  function_897bf9557f2742a6("\xc1\xaf\x82\xc1\t\xf9");
  function_897bf9557f2742a6("\xc7\xae?f\x10\xbcr");
  function_897bf9557f2742a6("\"/\x92c\xacl|");
  function_897bf9557f2742a6("\xb8y\xb4\x8fk\x05b\x03(U\xe7\xf3");
  function_897bf9557f2742a6("\x13'$\xc4\xf8l\x16\xdf");
  function_897bf9557f2742a6("$\x9b\xd1\xd1(A\x8c@f\x80\xf6\xfd");
  function_897bf9557f2742a6("\x06\xdf%q\xfe,\x91n\xbeF\xe5\xe2\xc0");
  function_897bf9557f2742a6("\xf1\x9c\xaa0x\xfb\xbcP\x02=\x0fV\f");
  function_897bf9557f2742a6("\ae'\xfe\x15\xc9\x0e\x0e\xa8J\x86\xdc\f");
  function_897bf9557f2742a6("\x96\xbd\x11i\xfb|\xe1G\x8f\xafQnO");
  function_897bf9557f2742a6("\xealQ\x95\xc1qO\xba\x9a\xae\xd3\xd5G");
  function_897bf9557f2742a6("\x8e*\xf05\xc0\x01R\xbeu\x06");
  function_897bf9557f2742a6("\xcd\xb0\x81\xed\xf3/\r\xa5,H");
  function_897bf9557f2742a6("4\xac\x01\xc2\xc9A\x93<\x91\x8c");
  function_897bf9557f2742a6("*\x11\x9f\xb9!()w%\xd1");
  function_897bf9557f2742a6("\xa7>4.\x83\x91\xac\x10");
  function_897bf9557f2742a6("\f\xf4\x8e\xbeZ\x98i0");
  function_897bf9557f2742a6("\xb0\xe1)\x0e\xbe\xf5\x9c\xed\xb4");
  function_897bf9557f2742a6("\xc1F\"to\x9c\xd8\x9c\x1c");
  function_897bf9557f2742a6("Un\xdf\xd5\x99\x87}w!\xf5");
  function_897bf9557f2742a6("T\x93x\x82&,77\xfb7");
}

function private function_897bf9557f2742a6(str) {
  level.var_a27d9834e7957cf6[getxhash(str)] = str;
}
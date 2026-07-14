/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_8bb904f2c00c7c7.gsc
****************************************************/

#using scripts\common\system;
#using scripts\engine\utility;
#using scripts\sp\scripted_weapon_assignment;
#using scripts\sp\utility;
#namespace namespace_fe30ea31c12643b7;

function private autoexec __init__system__() {
  system::register(#"hash_5be25b1b277ec962", undefined, &pre_main, &post_main);
}

function private pre_main() {
  if(function_9c44e6874f16932e(1 | 64 | 2 | 4 | 8 | 16 | 32)) {
    return;
  }

  function_65dd33617e58d1bb();
}

function private post_main() {
  if(function_9c44e6874f16932e(1 | 64 | 2 | 4 | 8 | 16 | 32)) {
    return;
  }

  level.fnscriptedweaponassignment = &getscriptedweapon;
}

function private function_65dd33617e58d1bb() {
  level.var_9647332d18e30c8f = [];
  level.var_9647332d18e30c8f[%"mission_loadouts"] = % "mission_loadouts";
  level.var_9647332d18e30c8f[%"scripted_weapons"] = % "scripted_weapons";
  mapassethash = getxhashasset(getDvar(@ "ui_mapname"));
  level.var_9647332d18e30c8f[mapassethash] = mapassethash;
  ents = utility::array_combine(getEntArray(), getspawnerarray());

  foreach(ent in ents) {
    if(isspawner(ent) && issubstr(ent.classname, "\x8ezH\xa8v\xe7")) {
      def = ent function_81945ca9a451f1e8();

      if(isDefined(def.voicelist)) {
        foreach(voice in def.voicelist) {
          level.var_9647332d18e30c8f[voice] = voice;
        }
      }
    }
  }

  if(getDvar(@ "ui_mapname") == "<dev string:x24>") {
    level.var_9647332d18e30c8f = undefined;
  }
}

function getscriptedweapon(weaponname, weaponposition) {
  setdvarifuninitialized(@ "hash_45281f93550798", 0);

  if(!isDefined(weaponname)) {
    return nullweapon();
  }

  var_2b49818b367b5a9 = undefined;

  if(isweapon(weaponname)) {
    if(isundefinedweapon(weaponname)) {
      return weaponname;
    }

    var_2b49818b367b5a9 = weaponname.var_2b49818b367b5a9;
    weaponname = weaponname.basename;
  }

  if(!isarray(weaponname) && weaponname == "") {
    return nullweapon();
  }

  if(isstring(weaponname) && issubstr(weaponname, "k\xad\xb8<9\xcey\xdc\x14\xac")) {
    return [[level.fnbuildweapon]](weaponname);
  }

  if(isDefined(weaponposition) && weaponposition == "\xd64*\xa3I\x12\xef") {
    weapon = getweapon(weaponname, "\x8e\xfcc\xbe\xdf\xa6", var_2b49818b367b5a9);
  } else {
    weapon = getweapon(weaponname, self.scriptedweaponclassprimary, var_2b49818b367b5a9);
  }

  return weapon;
}

function getweapon(basename, weapontype, var_2b49818b367b5a9) {
  useattachments = [];

  if(level utility::flag("\x1f\\vI:\x1e5X\x19Y\x82to\x83\xf51x\xc2\xfb\x89\vX\n\xbc") || !isDefined(var_2b49818b367b5a9)) {
    return utility_sp::make_weapon(basename, useattachments);
  }

  if(!isDefined(level.var_4bd0f59cb3fbcac7)) {
    level.var_4bd0f59cb3fbcac7 = [];
    level.var_4bd0f59cb3fbcac7[level.var_4bd0f59cb3fbcac7.size] = "\xf1\xf3X\x18Y";
    level.var_4bd0f59cb3fbcac7[level.var_4bd0f59cb3fbcac7.size] = "\xfc\x9e\xf82\x90(\x8a\xbf\xa6";
    level.var_4bd0f59cb3fbcac7[level.var_4bd0f59cb3fbcac7.size] = "\xcf\xf03\xc5\xd6.";
    level.var_4bd0f59cb3fbcac7[level.var_4bd0f59cb3fbcac7.size] = "\xa0Nj\xf6\x87\xddgV";
    level.var_3e5f18af3abfffa3["\xf1\xf3X\x18Y"] = 75;
    level.var_3e5f18af3abfffa3["\xfc\x9e\xf82\x90(\x8a\xbf\xa6"] = 50;
    level.var_3e5f18af3abfffa3["\xcf\xf03\xc5\xd6."] = 65;
    level.var_3e5f18af3abfffa3["\xa0Nj\xf6\x87\xddgV"] = 80;
  }

  itemdef = undefined;
  deck = scripted_weapon_assignment::getweapondeck(self.voice, basename, var_2b49818b367b5a9);

  if(isDefined(deck)) {
    itemdef = deck utility::deck_draw();
    self.weaponlootitem[basename] = itemdef.index;
    useattachments = scripted_weapon_assignment::function_66de7803f693e3a5(itemdef);
  }

  if(!isDefined(itemdef)) {
    foreach(slot in level.var_4bd0f59cb3fbcac7) {
      if(randomint(100) < level.var_3e5f18af3abfffa3[slot]) {
        atlist = function_f2b80d3e974b3594(basename, slot, 1);

        if(atlist.size > 0) {
          attachment = atlist[randomint(atlist.size)];

          if(!function_1a25dee1d10201a(var_2b49818b367b5a9, attachment, slot)) {
            useattachments[useattachments.size] = attachment;
          }
        }
      }
    }
  }

  useattachments = arrayremove(useattachments, "");

  foreach(attachment in useattachments) {
    if(issubstr(attachment, "RL\xb86B\xca\x16zt")) {
      useattachments = arrayremove(useattachments, attachment);
      break;
    }
  }

  return utility_sp::make_weapon(basename, useattachments);
}

function function_1a25dee1d10201a(weapon, attachment, slot) {
  if(!isDefined(level.var_7cb0b942486953eb)) {
    level.var_7cb0b942486953eb[%"t10_ar_p05_rmary2"]["\v\x8ae\xe6\xe1q.[\n\xdf\x11\xe6&i\x8cCk\xc9Y&\xe5\x05|\xda\xfb}\x05\xd9\x05A\x1eg"] = 1;
    level.var_7cb0b942486953eb[%"t10_ar_p05_rmary2"]["\xdcp\xb4\xe4\fOO\b\xe3\"\xc2\x8fWX|\xe23\x9f\xd4\x01\xfb\xd3\xdaI?\x96"] = 1;
    level.var_7cb0b942486953eb[%"t10_ar_p05_rmary2"]["\x96\xc81\x9c\xcd\xcf\x89\xa1\x82j\x14\xaf4f\x96*\xca\xd9~\xc4\xf9C\xa4\xe2\x85\xcd\xe4"] = 1;
    level.var_7cb0b942486953eb[%"t10_ar_p05_rmary2"]["\x9d\xa7\xe4\xeb\x06\xf7\xda\xb6R\xb7\x15\x98\xd1\xff\xbcH\x0e\xdd>\x0e\x8cd\x9d\x8a\xdc\x02\xd0`\xc4\xe7\x1f"] = 1;
    level.var_7cb0b942486953eb[%"t10_pi_p13_usugar9"]["\xdfOR\xd3h\xca\xeb\xfeaw\xd2\xcc'\xb5\xcbf\x82\xca"] = 1;
    level.var_7cb0b942486953eb[%"t10_ar_p02_aking74"]["\x1c|m\xd9\xa6\rc\xd6Aa\xbb\x89h\xe7T\x8d"] = 1;
    level.var_7cb0b942486953eb[%"t10_sn_p08_ultiger"]["\xd1&\x06\xf5\x86^L'-d\x81\x89\xfa\xcdn"] = 1;
    level.var_7cb0b942486953eb[%"t10_sn_p08_ultiger"]["\x95ilR\xf4\x8d\x8c\xf8\x95*5;\xe1\x9bG"] = 1;
    level.var_7cb0b942486953eb[%"t10_sn_p08_ultiger"]["+\xa37\x80\xe3\xc6\xc5\xafG\xb1\xc9\xe6\x0e)T w\x15b"] = 1;
    level.var_7cb0b942486953eb[%"t10_sn_p08_ultiger"]["\x03U2\x81`\xebv\xe4\xea\x13.\"\xd4_]\xb0"] = 1;
    level.var_7cb0b942486953eb[%"t10_lm_p01_aroger10"]["K\xe0\xb2bM;\xd1x\xbePi\x13a\xf5\xe7\x83"] = 1;
    level.var_7cb0b942486953eb[%"t10_lm_p01_aroger10"]["\x8c\xea\v\xe8\xd8\xf2\xec\xb3?\x9c\xdcj{\x1f\xf6\x19"] = 1;
    level.var_7cb0b942486953eb[%"t10_sm_p03_safox"]["\xb3q\x9b\xb6\xa0\x1b>\xaa\x0e'\xe9\xc8\x16\xf1b\x81\xf5\x9cQ\x85\n\xa2"] = 1;
    level.var_67f40708c20485c6[%"t10_sm_p06_sroger3"]["\xcf\xf03\xc5\xd6."] = 1;
    level.var_398cb0f3218f7f10[%"hash_2d2c81e1962b7eb5"] = 1;
    level.var_398cb0f3218f7f10[%"t10_sm_p02_geasy9"] = 1;
    level.var_398cb0f3218f7f10[%"t10_sm_p21_pparis90"] = 1;
    level.var_398cb0f3218f7f10[%"t10_sm_p06_sroger3"] = 1;
    level.var_398cb0f3218f7f10[%"t10_sh_p25_uncle12"] = 1;
    level.var_398cb0f3218f7f10[%"t10_ar_p06_asvalor"] = 1;
    level.var_8e592cf00f220d2a[%"t10_lm_p02_puncle21"] = 1;
    level.var_745141a012be56a1["Cb\x84ot\xc4<<\xe0\a\x8e\xa1\xfd\x8c0\x9cd\xff$8"] = 1;
    level.var_745141a012be56a1["\x1c|m\xd9\xa6\rc\xd6Aa\xbb\x89h\xe7T\x8d"] = 1;
    level.var_745141a012be56a1["\x9c7\xe4\x11\x8b\xaa\xfa\x85\xa7\n4i0\xa6\x1a"] = 1;
    level.var_745141a012be56a1["Cb\x84ot\xc4<<\xe0\a\x8e\xa1\xfd\x8c0\x9cd\xff$8"] = 1;
    level.var_745141a012be56a1["\xf7\x8dc_U\xc1 q}\x81\xaa\x86\xd2\xbfZ\xcaF"] = 1;
    level.var_745141a012be56a1["\xa6\x9d\xda\xd1\xc8\x19\xfc\x13\x18\xba\x90\xea\xbe!\xbf"] = 1;
    level.var_745141a012be56a1["\xc2\xcd\xa8\x97Z\x9fI\x8cBC%\xcb\x83\xb3J"] = 1;
    level.var_745141a012be56a1["\x11Y\x84\xc2\xcdo\xf3\x9d\xc5$\x9ez\xbfN\xcf"] = 1;
    level.var_745141a012be56a1["\xc0Pe0\xf6\xafx{\xd1\xb8E\xc5\x8do\xf9\xba9\xc37[|"] = 1;
    level.var_745141a012be56a1["tCX\x96>0w\x1a\xe47\xedD\xf9%r\x121\xfd\xa2?,"] = 1;
    level.var_745141a012be56a1["\x93\xd0\xfa\xc8=\t\x82Wm,\xfcZ(=\f\x06R!"] = 1;
    level.var_745141a012be56a1["x\xfasJ\xef]\x81q\x02J\xcf\v\xbfW(c"] = 1;
    level.var_745141a012be56a1["L\xf9\x1eL\x05W\xb3\xd5\xd5\xf2\xa7\xa7l\x98r\xd4"] = 1;
    level.var_745141a012be56a1["GL`\xbe\x99\xb7\xab\xe4\x87\x06&\xf5\xcd\xd6\x9d"] = 1;
    level.var_745141a012be56a1["\xc25\x90\xd0\xb7\xac=0\xc5\xacnY_\\e}7z"] = 1;
    level.var_745141a012be56a1["q\x1fF\xebb\xe3N5\x81\xfcH\x05\xf0\x87\xa6\xd5\xed"] = 1;
    level.var_745141a012be56a1["Y\x9f\x15}\xc8\x84b;\xc0w\xc6\xde\\\xdb8\xfc$\xd7uV"] = 1;
    level.var_745141a012be56a1["t&\x18\xberY2d\xdb\x8e\x06L\xebsh"] = 1;
    level.var_745141a012be56a1["WX\xbf\xe44\xcb\xe6H.z\xb4\xe3\x13:\x16"] = 1;
    level.var_745141a012be56a1["U\xf0\x8a\x88}zzp@\x1f\x91\xb4\xaeW\xe7"] = 1;
    level.var_745141a012be56a1["w\x93\x99\x12M\xb0\xb6J\xc6\xf7\xe1\xe7\xf2\x1dC"] = 1;
    level.var_745141a012be56a1["#\xd8\xdf,,\rjC\x9bx`\xba$\xf6\xdf"] = 1;
    level.var_745141a012be56a1["\xcb\xcb*\x89%'\xa8\xd8\x8f\xd7)\x96\xb1"] = 1;
    level.var_745141a012be56a1["\x96\xc81\x9c\x05\xd2q\xa0\xa2k\x9b\xaf\x1c\xe8F\nD\xd2_"] = 1;
    level.var_745141a012be56a1["G\xc4\x18\xf5\xd6Zl\xc9\xde\x93\xcaf\xd8V\xc3\x063\xebsh"] = 1;
    level.var_745141a012be56a1["\x93\xca\xfa\t\xe9\x8bRU\xc1#\xca\xa8\b`\x83\x9e\x9d\xbfBI"] = 1;
    level.var_16f6f272cca07646[%"t10_pi_p13_usugar9"] = 1;
    level.var_16f6f272cca07646[%"t10_pi_p12_paris30"] = 1;
    level.var_16f6f272cca07646[%"t10_pi_p14_mable"] = 1;
    level.var_16f6f272cca07646[%"t10_pi_p14_stiger"] = 1;
  }

  if(istrue(level.var_398cb0f3218f7f10[weapon]) && slot != "\xf1\xf3X\x18Y") {
    return true;
  }

  if(istrue(level.var_8e592cf00f220d2a[weapon])) {
    return true;
  }

  if(istrue(level.var_745141a012be56a1[attachment])) {
    return true;
  }

  if(isarray(level.var_67f40708c20485c6[weapon])) {
    if(istrue(level.var_67f40708c20485c6[weapon][slot])) {
      return true;
    }
  }

  if(isarray(level.var_7cb0b942486953eb[weapon])) {
    if(istrue(level.var_7cb0b942486953eb[weapon][attachment])) {
      return true;
    }
  }

  if(istrue(level.var_7b6e441803f69c02) && slot == "\xcf\xf03\xc5\xd6.") {
    if(!istrue(level.var_16f6f272cca07646[weapon]) && issubstr(attachment, "\xef\xdf\x02\xf6\x8a\xc9\xdb\x19\xd1\x9e\xea\x8f")) {
      return true;
    }
  }

  return false;
}
/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\notetracks_sp.gsc
******************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\death;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#using scripts\asm\shared\utility;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\pip_util;
#using scripts\sp\utility;
#namespace notetracks_sp;

function registernotetracksifnot() {
  if(isDefined(anim.notetracks)) {
    return;
  }

  anim.notetracks = [];
  registernotetracks();
}

function registernotetracks() {
  level._defaultnotetrackhandler = &handlenotetrack;
  level.fnnotetrackprefixhandler = &notetrack_prefix_handler_sp;
  level.fnnotetrackmodeltranslate = &notetrack_model_translate;
  notetracks::registernotetracks();
  anim.notetracks["k`P\x1e=\x9b\xc5\xc8\x10\x9az\xde\v\"\xbfGX\xbe\x03_v\xd8L\x98uc\xd1"] = &notetrackfingerposeoffleft;
  anim.notetracks["/x\xc2<O}g\xbc\xb7sUe@\xe6\xf0:\x9b\x0e\x86(\x05\xe4b\xbdya\xfcK"] = &notetrackfingerposeoffright;
  anim.notetracks["i\xb3\xfay\x16\x90\xb7\x1b\xe6t\xe5\xbe\t\xc1\xa3\xf9\xe3\xd6\xa1^\xeb\xad\xc2\x01\xc8#"] = &notetrackfingerposeonleft;
  anim.notetracks["\xec\xf0\f\xe7>\x98\xd2\xec*\xe1t?\x86\f\xb3\xe7\x8f5\xc3qh\xe6\xb9*\x15\xc4W"] = &notetrackfingerposeonright;
  anim.notetracks["\"\xcf\x01`\xaf\xe1\x7fW]g\xedp:\b\xc9\xa4/\x84"] = &notetrackfacialidle;
  anim.notetracks["\xbe\n\xd8\x80\xf8\xe3\x9e3\x9d\x06\x06q\xfao\x95{\xd7"] = &notetrackfacialrun;
  anim.notetracks["\x9ax\xf7e9g\xd3#\xf4Sn\x92\x82\xa0\xfa^\xff\""] = &notetrackfacialpain;
  anim.notetracks["Y;\xd6\xf0^\a_\xb6\xf6YF\xf3\xc2y\xdb9Y\xd9p"] = &notetrackfacialdeath;
  anim.notetracks["\xd8\xc8\x82DV\xc9\x83gs\x83\xdf\xb8\x850\xf4\xd8\xc2\xc2"] = &function_7c2d34956fa5a7;
  anim.notetracks["\x17,g\xd6\x8bX\x1bL\xb3{\xea1\xb0\xf0\xdc\xc0\x84\xed\xea\xf0\xcb"] = &function_8b1c31dabe8c17ce;
  anim.notetracks["t\x80Z\x81\xbc\xd1\xf9\xfd\x7fH\xd0c\xaf>\xcd|\xea\"\x81\x87\x01"] = &function_217109de1b078cde;
  anim.notetracks["N78\x1aG\xdca\x98\x9dm\x8eg\x94\xdc\xc2\v\xa5\x1ai8\x99"] = &function_7c2d34956fa5a7;
  anim.notetracks["\x9b\a\x8fv\xc8Ad*\x11\x82^z?/\xdb@\xa6l\xb1"] = &notetrackfacialcheer;
  anim.notetracks["\x1e\x88\b-\xc9\x04\xf3\xa7\x87\xdb9\x06\xc5\xea\xd0\x96\xa2\xa3P"] = &notetrackfacialhappy;
  anim.notetracks["\xd9}\xdd \xd4\x9f\xe8\x12\x1eUC\x12+\x88^\x95\xef\x80f"] = &notetrackfacialangry;
  anim.notetracks["8\xc2\x88\xdc\xec\xab\bGo\x18\xc3\x12\xed\xad\xf6\x10\x18\xf0\xb2\xb8"] = &notetrackfacialscared;
  anim.notetracks["\x96\f\xb9w3\x86EA\x0e\xd6\xc1\xc2\xb9q\x8f\x9e\xa4\xaen\xed|_\xde"] = &notetrackfacialgasdeath;
  anim.notetracks["C\xbf*q\xa3\xb9tt\xect6"] = &notetrackvisorraise;
  anim.notetracks["\x04\x9e\xcc\xf5\x16\xd1\xef\t\xea\x96z"] = &notetrackvisorlower;
  anim.notetracks["O1\a\xe0DN\x11\xfb}\xca\xf0\tz\xc1\xe6mQ\x01\xb2"] = &notetrackvisorlower_instant;
  anim.notetracks["\xb3K\xb9\xf6'\xf5\xe4\xc2\xd2\x9be\xaf\xd2s\xcd\xe8\v\xe6\xa3"] = &notetrackvisorraise_instant;
  anim.notetracks["\xab\xf0\xae\xe5\x18|\xe0\xba;t\xaf\xe6\x16\xac\x88\xea\xaa\x9b\x11\xf7$\xcf0\xaa\x03"] = &notetrackvisorpricelower_instant;
  anim.notetracks["\x03\x8c\xc1J\x89\xe7qF|\xf3-\x0e\x9c\x82\x81\xd3\xa5\x8f\x170\a1\xa1b\xb1"] = &notetrackvisorpriceraise_instant;
  anim.notetracks["w\x85\x16\xbd\x8c\xe2\x83J\xa6N\\8X\xdc\v"] = &notetrackvisorraise_clear;
  anim.notetracks["_\xf2\xe3\xba\x18\xee\x030j"] = &anim_death::play_blood_pool;
  anim.notetracks["?x\x99\xf7|M\x9e\x95\xbf\xc4\xc0\x99\xd6"] = &notetrackmovement;
  anim.notetracks["\t\x9f\xd5\xffv\xd1\x0fd\\L\xb5\xf0\x10\xf0"] = &notetrackmovement;
  anim.notetracks["l\x89\x14h\xcc8\xcc\x14\xe7\xe0O\xeab\xd4@\xacu\xa8\xc4"] = &notetrackbodyfall;
  anim.notetracks["\xf2\x9f\x98\x15\xb8^?n\x19\x1a\xa8?\xb4\x1aP\xe9R\x8a\x1c"] = &notetrackbodyfall;
  anim.notetracks["\x13\xde\x8c\xbc\x99a\xc6c}\r\xaca\xc8"] = &notetrackbodyfall;
  anim.notetracks["$\xeb\xdf.\xea\xadv\"\x96\x1b\x87Z\xe2/"] = &notetrackbodyfall;
  anim.notetracks["{\x7f\xb2MY\x1fv\x1e\a\a"] = &notetrackfootscrape;
  anim.notetracks["h\xf2[\xed"] = &notetrackland;
  anim.notetracks["\x95\xd2\x1e\xab\xc2\x98\xf4\xa7\xf5\xfej$\xf1"] = &notetrackhandstep;
  anim.notetracks["\x1a\vs\x8c\xdc\xd1V\x0e\xf59i\xd9h\x8e"] = &notetrackhandstep;
  anim.notetracks["\x8dP\x10,\x92\x9fw\xf6"] = &notetracklaser;
  anim.notetracks["^\xdey\xad\xa4\xf6\x8e\xef\x10"] = &notetracklaser;
  anim.notetracks["\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j"] = &notetrackstartragdoll;
  anim.notetracks["\xd6p\xfe\x02@\x01K*\x8b\xb0\x9di\"\x02a)"] = &notetrackragdollblendinit;
  anim.notetracks["\xfcp\x16#\x14\x8cu\x9c\xd4@\xec(\xd6\xd6i\xde\xe4"] = &notetrackragdollblendstart;
  anim.notetracks["\xf4\xfc\xa5V\xf3&qa\x8c\xd4\xc9\x86\xb2\xe2\x8c"] = &notetrackragdollblendend;
  anim.notetracks["6S\xa5\xe5>V\xd83k\"\xa9A\xa5\x9aO\x05\xc0\xc7s\xdb"] = &notetrackragdollblendrootanim;
  anim.notetracks["\xbfsW]\x13\xf9\xda,\xe8\x87e\xa0\x18_?\xd4\xaakg\xb1}P\xae"] = &notetrackragdollblendrootragdoll;
  anim.notetracks["\xda\xd2l6\xc2Z"] = &notetrackkillai;
  anim.notetracks["\xd8-\x9d+\x9c\v\xced\xbd\xc6\x8d\xfa\x9b\xa3\xb0\x9cG"] = &notetrackstartliveragdoll;
  anim.notetracks["\x83(\x11\nQQ\"'\xf3"] = &notetrackdropclip;
  anim.notetracks["\xd0\xdd\\\xf9$\x87\xbb\x03`\x19"] = &notetrackhelmetpop;
  anim.notetracks["OD\xc19\xcaMwq"] = &notetrackgundrop;
  anim.notetracks["\xf7\xe8>`\xf4\x93q"] = &notetrackgundrop;
  anim.notetracks["\xee\xa8{&\x9f\xf1\xa3\xb6l\xedA\x92\x95\x10r.\x9by\xc7\xe7\x98&o\x88"] = &notetrackgunhand;
  anim.notetracks["\xc3\xcd\xe2\xe9_1[-\xe9sm-\xbe%$ZY9}"] = &notetrackgunhand;
  anim.notetracks[".\xadoi\xc8\x11\xa0\xdf\x18\xc6\x9b\xd8\xd8 \xa5\\\xde\xc0\xc9\xef\xb2=\xe7\x0ew"] = &notetrackgunhand;
  anim.notetracks["+_\x066i\xf5\xc2\xd2\x8a\xcf\xe4\xec\xb0\xc9\xae{q\xc3\xd3\x13"] = &notetrackgunhand;
  anim.notetracks["\xb0\xb9Z\xd6}vun\x86a\xb9\x8c\b\xf4 \xcd\xed\xcdY"] = &notetrackgunhand;
  anim.notetracks["\xb7\x84d{\x13=\xeb\xa7\xf7\x19\x1d#C\xc2'e+\x85+"] = &notetrackposestand;
  anim.notetracks["\xfc\x97\x10\x9f\x7f3\xa0\xe3\xbfQb\xe9-\xb5\x0f\rl\xbepP"] = &notetrackposecrouch;
  anim.notetracks["\x97\x01\x83\xe9v\xd3\x1e/\xa8]\xcd\xb7!vK\x9f\xbf7%"] = &notetrackposeprone;
  anim.notetracks["\xcb\xd9\x12m\xb7\xa7Y\t;\xf8\xd1\xc1\x18\xfd\xe5)\x84\xec\xee"] = &notetrackposecrawl;
  anim.notetracks["\xac\x1f@\x9cP\xb1EpT\x9b\x84\x12\xcfM\x059\xb4\x99"] = &notetrackposeback;
  anim.notetracks["\f\xf5 \xcdj\x7fI\xc9>g*\xdb\xb9\xcc#\x1c\xce\x11\xdb\xbc\xa2"] = &notetrackgunhand;
  anim.notetracks["\x85nZm\xfa\xd9\xab\xe6ha\xdcF\x01\xd3\x80\x88\xc9K\xceCG\x11"] = &notetrackgunhand;
  anim.notetracks["p\x8aX\xcb\x82}\bb\xfax[\xa3Z\x8bN\xa0\xb3\xc2\xe0\xbb#"] = &notetrackgunhand;
  anim.notetracks["[aE8\xe1:\x97_x\xd8\xea\xbf\xa7\xd4aeI"] = &notetrackposestand;
  anim.notetracks["\x99\xd3\xa5\x04!2E\xddX\xb19\x7f.\x82\xfcN}\f"] = &notetrackposecrouch;
  anim.notetracks["\xdd\x95\xa0\x15\a\x12|J\x16G\xa4\x8an\xc4\xd1\xe1L"] = &notetrackposeprone;
  anim.notetracks["\v\x9btbW\xe3\x92\x10\xdeo\x1a\xb8\xdb\x19z\x89\xaa"] = &notetrackposecrawl;
  anim.notetracks["\x85\\\x1f\xa4\x81\xd1\"\xc1{\xb9\xec\xed\xdf\x97K\xc9"] = &notetrackposeback;
  anim.notetracks["3\xbc\xb4T\xbbCl"] = &eyeonnotehandler;
  anim.notetracks["\x9bF\a\xffw\xda\x93{"] = &eyeoffnotehandler;
  anim.notetracks["Li\f\xdfJ\xf3|\xe8\x9a?QG,\x7f"] = &notetrackenableweapons;
  anim.notetracks["\xd1\xcb\x8dF,\x11\xbf/\xf3t\x87\x8f\x8f\x80f"] = &notetrackdisableweapons;
  anim.notetracks["\x1f\x92H\xd0\xd1q\xcd 0\x04\x1d\xd9\x8d"] = &function_d3c514dbbc1da583;
}

function handlenotetrack(note, flagname, customfunction, customparams) {
  if(notetracks::hascustomnotetrackhandler(note)) {
    return notetracks::handlecustomnotetrackhandler(note, flagname, customfunction, customparams);
  }

  retval = notetracks::handlecommonnotetrack(note, flagname, customfunction, customparams);

  if(isDefined(retval) && retval == "\xa9PS\x99\x84XByiuW") {
    retval = undefined;

    switch (note) {
      case #"hash_96500ba43eb6e086":
        utility_sp::anim_stopanimScripted();
        return note;
      case #"hash_d9f86e4c127286b2":
        if(utility_common::weapon_pump_action_shotgun()) {
          self playSound("\xd7\x15\x981\xc1\xaa\xc6\xb9\xb1\xee\x14\xe1)\xf0\x05L\xd7U\xe0T\x98\x92\x96Y0\x96\xb8\xe0");
        }

        break;
      case #"hash_88cce8d6571fe7e1":
        if(utility_common::usingrocketlauncher()) {
          notetrackrocketlauncherammoattach();
        }

        break;
      default:
        if(isDefined(customfunction)) {
          if(isDefined(customparams)) {
            return [[customfunction]](note, customparams);
          } else {
            return [[customfunction]](note);
          }
        }

        break;
    }

    if(utility::string_starts_with(note, "\xb5\xf8\x1f\x9d")) {
      if(!isai(self)) {
        assertmsg("<dev string:x24>" + note + "<dev string:x29>");
        return 1;
      }

      data = strtok(tolower(note), "\x16");
      data[0] = getsubstr(data[0], 4);
      function_96af245867510885(data);
    }
  }

  return retval;
}

function notetrackvisorraise(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  asm_sp::asm_playvisorraise();
}

function notetrackvisorlower(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  asm_sp::asm_playvisorraise();
}

function notetrackvisorlower_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  asm_sp::asm_playvisorraise("\xec\xcc\xe5\x18#1\xa8\f");
}

function notetrackvisorraise_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  asm_sp::asm_playvisorraise("\xec\xcc\xe5\x18#1\xa8\f");
}

function notetrackvisorpricelower_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  asm_sp::asm_playvisorraise("\xfc\x88\xdb\x17|\xa2X\xcc\xa1\x99\xda\xf4%Y");
}

function notetrackvisorpriceraise_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  asm_sp::asm_playvisorraise("\xfc\x88\xdb\x17|\xa2X\xcc\xa1\x99\xda\xf4%Y");
}

function notetrackvisorraise_clear(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  asm_sp::asm_clearvisoranim();
}

function notetrackfingerposeoffleft(note, flagname) {
  asm_sp::asm_clearikfingeranim("=\xff0b");
}

function notetrackfingerposeonleft(note, flagname) {
  asm_sp::asm_ikfingeranim("=\xff0b");
}

function notetrackfingerposeoffright(note, flagname) {
  asm_sp::asm_clearikfingeranim("=\xff0b");
}

function notetrackfingerposeonright(note, flagname) {
  asm_sp::asm_ikfingeranim("o0\xee\xc1\x8c");
}

function notetrackfacialidle(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\x91\x88\xc2*");
}

function notetrackfacialrun(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\x14+`");
}

function notetrackfacialpain(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\x80\xb5\xc7J");
}

function notetrackfacialdeath(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\x1e\xfd\xd1\xa2\a");
}

function function_8b1c31dabe8c17ce(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\xee\x1a\xb5\xd1\x8b_\x0f");
}

function function_217109de1b078cde(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\x98\xbe\x8a\x0fQ\x90~");
}

function function_7c2d34956fa5a7(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("o\xbc\x89n\x9c\xf5\xed");
}

function notetrackfacialcheer(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("#\x16\x95ly");
}

function notetrackfacialhappy(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\x86\x85\x1c\x83y");
}

function notetrackfacialscared(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\xbbB\xef\xf1a\xb1");
}

function notetrackfacialangry(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("\x1d\xc08h\x14");
}

function notetrackfacialgasdeath(note, flagname) {
  asm_sp::asm_playfacialanimfromnotetrack("WO\\\xebB\xf9F\xf5\x03");
}

function notetrackmovement(note, flagname) {
  if(isDefined(self.classname) && self.classname != "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
    lead_type = 1;

    if(issubstr(note, "\xb0\xce@\x17")) {
      lead_type = 2;
    }

    run_type = get_notetrack_movement();
    self playclothmovesound(run_type, lead_type);
  }
}

function notetrackbodyfall(note, flagname) {
  switch (note) {
    case #"hash_2ef23a13196222ab":
      soundalias = "\x8e\xdb7|\xf3oY-\xee\xc8\xbb\xb1\xac\xf7\xa3\x193\xfe";
      break;
    case #"hash_2e9368be03b7a895":
      soundalias = "\xf1N\x88\x1c\xc57\xfa\xc4\xb4J{\x9e\xb0\x11M\xbd\ru\x1a\x1b\xff\xcf%C";
      break;
    case #"hash_53bc96d0ea50bbf9":
      soundalias = "Nz\xda:a\n\x85\xc1\b\xb5\x1e\xe9\x8c`L\x14\x7f\x10\xf9 \x9ec\xca\v";
      break;
    case #"hash_cabf23769ef0902c":
      soundalias = "\t\xa0\x11\x13\xdeh\x15\x92\x1a\x90\x92\xc5\x82\xce4\xe3|g5";
      break;
    default:
      soundalias = "\xf1N\x88\x1c\xc57\xfa\xc4\xb4J{\x9e\xb0\x11M\xbd\ru\x1a\x1b\xff\xcf%C";
      break;
  }

  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "ek\x9a\x9c\xe0\xe3p\xbc\xb5\xb9$\x10";
  }

  self playsurfacesound(soundalias, groundtype);
}

function notetrackfootscrape(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
    return;
  }

  groundtype = "Ee\x12\x18";
}

function notetrackland(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "Ee\x12\x18";
  }

  self playsurfacesound("\xb9:\xac\a_2\xb23,]lt\xbe\x9b8\x1b_\x1b\v\x9b\x91", groundtype);
  self playclothmovesound("h\xf2[\xed", 2);
  self playequipmovesound("h\xf2[\xed", self.weapon);
}

function playfootstep(is_left, is_large, is_vfxonly) {
  if(!isai(self)) {
    if(isDefined(self.fnplayfootstep)) {
      [[self.fnplayfootstep]](is_left, is_large, is_vfxonly);
      return;
    }

    if(!is_vfxonly) {
      utility_sp::function_29f2a13ad5e570b0("Ee\x12\x18", "\xc5q\x85\xc5", "\x14+`");
    }

    return;
  }

  groundtype = undefined;
  actiontype = "\xc5q\x85\xc5";
  stairsstate = self.stairsstate;

  if(stairsstate == "\xf3\xf2") {
    actiontype = "z\x15q[hE23\xf6\xf1\xc1";
  } else if(stairsstate == "\x7f5\xe8e") {
    actiontype = "2k\xb3QQ\xd36lw\x12\xd5\x16\x80";
  }

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      if(!is_vfxonly) {
        utility_sp::function_29f2a13ad5e570b0("Ee\x12\x18", actiontype, "\x14+`");
      }

      return;
    }

    groundtype = self.lastgroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  foot = "\x9a\xf4`\xe1=\x90\xd1\x9c\xea";

  if(is_left) {
    foot = "\x9a\xf4`\xe1=\x90\xd1\x82\xec";
  }

  run_type = get_notetrack_movement();

  if(!is_vfxonly) {
    utility_sp::function_29f2a13ad5e570b0(groundtype, actiontype, run_type);
  }

  if(is_large) {
    if(![[anim.fnfootstepeffect]](foot, groundtype)) {
      playfootstepeffectsmall(foot, groundtype);
    }
  } else if(![[anim.fnfootstepeffectsmall]](foot, groundtype)) {
    playfootstepeffect(foot, groundtype);
  }

  if(![[anim.fnfootprinteffect]](foot, groundtype)) {
    playfootprinteffect(foot, groundtype);
  }
}

function notetrackhandstep(note, flagname) {
  assertmsg("<dev string:x47>");
}

function playfootprinteffect(foot, groundtype) {
  if(!isDefined(anim.optionalfootprinteffects[groundtype])) {
    return false;
  }

  footorg = self gettagorigin(foot);
  footangles = self gettagangles(foot);
  footup = anglestoright(footangles) * -1;
  footforward = anglesToForward(footangles);
  tracestart = footorg + footup * -5;
  traceend = footorg + footup * 20;
  trace = trace::_bullet_trace(tracestart, traceend, 0, self, 0, 0, 0, 0);

  if(trace["\xda\x16\x81\aw}^i"] == 1) {
    return true;
  }

  if(!isDefined(level._effect["#h\xbd<\xfc\x1e=K\"\xf7" + groundtype][self.unittype])) {
    println("<dev string:x6f>" + self.unittype + "<dev string:x85>" + "<dev string:xa3>" + groundtype);
    level._effect["#h\xbd<\xfc\x1e=K\"\xf7" + groundtype][self.unittype] = level._effect["#h\xbd<\xfc\x1e=K\"\xf7" + groundtype]["\xb9\xdb6d-\xb2\xc9"];
  }

  if(!anim.flirfootprinteffects) {
    playFX(level._effect["#h\xbd<\xfc\x1e=K\"\xf7" + groundtype][self.unittype], trace["\xc1\xbd\xdci\xe8i{7"], trace["+0a<s,"], footforward);
  } else {
    thread track_flir_footstep(level._effect["#h\xbd<\xfc\x1e=K\"\xf7" + groundtype][self.unittype], trace["\xc1\xbd\xdci\xe8i{7"], trace["+0a<s,"], footforward);
  }

  return true;
}

function track_flir_footstep(effectid, org, forwardv, upv) {
  footstep = spawnStruct();
  footstep.effectid = effectid;
  footstep.org = org;
  footstep.forwardv = forwardv;
  footstep.upv = upv;
  footstep.spawntime = gettime();
  footstep.active = 0;
  anim.flirfootprints[anim.flirfootprints.size] = footstep;

  if(level.player isnightvisionon() && level.player utility_sp::is_flir_vision_on()) {
    footstep thread play_flir_footstep_fx();
  }

  wait 10;
  anim.flirfootprints = arrayremove(anim.flirfootprints, footstep);
}

function play_flir_footstep_fx() {
  if(self.active) {
    return;
  }

  self.active = 1;
  self.fx = spawnfx(self.effectid, self.org, self.forwardv, self.upv);
  triggerfx(self.fx, self.spawntime / 1000);
}

function kill_flir_footstep_fx() {
  if(!self.active) {
    return;
  }

  self.active = 0;
  self.fx delete();
}

function playfootstepeffect(foot, groundtype) {
  if(!isDefined(anim.optionalstepeffects[groundtype])) {
    return false;
  }

  org = self gettagorigin(foot);
  angles = self.angles;
  forward = anglesToForward(angles);
  up = anglestoup(angles);

  if(!isDefined(level._effect["H#\xe1\xa8\xa7" + groundtype][self.unittype])) {
    println("<dev string:xb1>" + self.unittype + "<dev string:xc5>" + "<dev string:xe7>" + groundtype);
    level._effect["H#\xe1\xa8\xa7" + groundtype][self.unittype] = level._effect["H#\xe1\xa8\xa7" + groundtype]["\xb9\xdb6d-\xb2\xc9"];
  }

  playFX(level._effect["H#\xe1\xa8\xa7" + groundtype][self.unittype], org, forward, up);
  return true;
}

function playfootstepeffectsmall(foot, groundtype) {
  if(!isDefined(anim.optionalstepeffectssmall[groundtype])) {
    return false;
  }

  org = self gettagorigin(foot);
  angles = self.angles;
  forward = anglesToForward(angles);
  up = anglestoup(angles);

  if(!isDefined(level._effect["5\x1c\x1bv\xd0\x18\xe8A\xa9j\x93" + groundtype][self.unittype])) {
    println("<dev string:xf0>" + self.unittype + "<dev string:x85>" + "<dev string:x10a>" + groundtype);
    level._effect["5\x1c\x1bv\xd0\x18\xe8A\xa9j\x93" + groundtype][self.unittype] = level._effect["5\x1c\x1bv\xd0\x18\xe8A\xa9j\x93" + groundtype]["\xb9\xdb6d-\xb2\xc9"];
  }

  playFX(level._effect["5\x1c\x1bv\xd0\x18\xe8A\xa9j\x93" + groundtype][self.unittype], org, forward, up);
  return true;
}

function get_notetrack_movement() {
  if(isai(self) && !isbot(self)) {
    return self function_8b59d8b97b92782f();
  }

  run_type = "\x14+`";
  animsetname = undefined;

  if(isDefined(self.asm)) {
    animsetname = self getbasearchetype();
  }

  if(isDefined(animsetname) && animspeedthresholdsexist(animsetname) && hasanimspeedthresholdstring(animsetname, "\x05\xb1\x1c\x86\x11\xc7") && isDefined(self.velocity)) {
    sprintspeed = getanimspeedbetweenthresholds(animsetname, "\x14+`", "\x05\xb1\x1c\x86\x11\xc7", 0.8);

    if(length2d(self.velocity) > sprintspeed) {
      run_type = "\x05\xb1\x1c\x86\x11\xc7";
    }
  }

  if(isDefined(self._blackboard)) {
    if(self._blackboard.movetype == "\x82}\xeb\x93" || self._blackboard.movetype == "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5" || self._blackboard.movetype == "T\x1d\xd9\x0e L" || self._blackboard.movetype == "#yDV,\xd6") {
      run_type = "\x82}\xeb\x93";
    }

    if(asm_bb::bb_getrequestedstance() == "GX\xa9]\x82") {
      run_type = "GX\xa9]\x82";
    }
  } else if(isDefined(self.a)) {
    if(isDefined(self.a.movement)) {
      if(self.a.movement == "\x82}\xeb\x93") {
        run_type = "\x82}\xeb\x93";
      }
    }

    if(isDefined(self.currentpose)) {
      if(self.currentpose == "GX\xa9]\x82") {
        run_type = "GX\xa9]\x82";
      }
    }
  }

  return run_type;
}

function notetracklaser(note, flagname) {
  if(note == "\x8dP\x10,\x92\x9fw\xf6") {
    self.laserenabled = 1;
  } else {
    self.laserenabled = 0;
  }

  self updatelaserstatus();
}

function notetrackgunhand(note, flagname) {
  if(issubstr(note, "=\xff0b")) {
    shared::placeweaponon(self.weapon, "=\xff0b");
    self notify("\xe5\x06\xb0\bE\x16<\xba\xb3\xc3\x96]\x1e9!\xf7[#");
    return;
  }

  if(issubstr(note, "o0\xee\xc1\x8c")) {
    shared::placeweaponon(self.weapon, "o0\xee\xc1\x8c");
    self notify("\xe5\x06\xb0\bE\x16<\xba\xb3\xc3\x96]\x1e9!\xf7[#");
    return;
  }

  if(issubstr(note, "\r+x5")) {
    shared::placeweaponon(self.weapon, "\r+x5");
  }
}

function notetrackposestand(note, flagname) {
  if(!isai(self)) {
    return;
  }

  if(isDefined(self.notetrackposestandfunc)) {
    self[[self.notetrackposestandfunc]]();
    return;
  }

  if(self.currentpose == "GX\xa9]\x82") {
    utility::exitpronewrapper(1);
  }

  setpose("\x8b\x90\xb5\xc4W");
}

function notetrackposecrouch(note, flagname) {
  if(!isai(self)) {
    return;
  }

  if(self.currentpose == "GX\xa9]\x82") {
    utility::exitpronewrapper(1);
  }

  setpose("1x\xc5\xb4\xabx");
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function notetrackposeprone(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self setproneanimnodes(-45, 45, %iY\xd5 > 8\xd3\xdb\xa4\xa4CS\v 'o\xda, %\xe7(c+5\xff\xaeL\x1az\xb9, %\x99\x93\x8b&\xca\xd2)\xde\xf3\xab\x89R\xeb );
    utility::enterpronewrapper(0.5); setpose("GX\xa9]\x82");

    if(isDefined(self.a.goingtoproneaim)) {
      self.a.proneaiming = 1;
      return;
    }

    self.a.proneaiming = undefined;
  }

  function notetrackposecrawl(note, flagname) {
    if(!isai(self)) {
      return;
    }

    if(isDefined(self.notetrackposecrawlfunc)) {
      self[[self.notetrackposecrawlfunc]]();
      return;
    }

    self setproneanimnodes(-45, 45, %iY\xd5 > 8\xd3\xdb\xa4\xa4CS\v 'o\xda, %\xe7(c+5\xff\xaeL\x1az\xb9, %\x99\x93\x8b&\xca\xd2)\xde\xf3\xab\x89R\xeb );
      utility::enterpronewrapper(1); setpose("GX\xa9]\x82"); self.a.proneaiming = undefined;
    }

    function notetrackposeback(note, flagname) {
      if(!isai(self)) {
        return;
      }

      if(!issentient(self)) {
        return;
      }

      setpose("1x\xc5\xb4\xabx");
      self.a.onback = 1;
      self.a.movement = "\x04M\xed\xab";
      self setproneanimnodes(-90, 90, %iY\xd5 > 8\xd3\xdb\xa4\xa4CS\v 'o\xda, %\xe7(c+5\xff\xaeL\x1az\xb9, %\x99\x93\x8b&\xca\xd2)\xde\xf3\xab\x89R\xeb );
        utility::enterpronewrapper(1);
      }

      function notetrackrocketlauncherammoattach() {
        assert(isDefined(self));

        if(!isalive(self)) {
          return;
        }

        if(!utility_common::usingrocketlauncher()) {
          return;
        }

        if(self tagexists("r\xfc}\xb0\xfc>\xe2~\xf7\x80\xa0\xa2\xd2\xae\x0e}\xf8G") && self tagexists("G\xb0v\xeb\xc9{\xc6\xdae\xd1")) {
          self showpart("G\xb0v\xeb\xc9{\xc6\xdae\xd1");
        }
      }

      function notetrackdropclip(note, flagname) {
        thread shared::handledropclip(flagname);
      }

      function notetrackhelmetpop(note, flagname) {
        if(isDefined(self.fnhelmetpop)) {
          self[[self.fnhelmetpop]]();
          self.dontbreakhelmet = 1;
        }
      }

      function notetrackstartragdoll(note, flagname) {
        if(isDefined(self.noragdoll)) {
          return;
        }

        if(isDefined(self.ragdolltime)) {
          return;
        }

        if(!isDefined(self.dont_unlink_ragdoll)) {
          thread unlinknextframe();
        }

        if(isDefined(self._blackboard)) {
          if(isDefined(self._blackboard.awaitingdropgunnotetrack) && self._blackboard.awaitingdropgunnotetrack == 1) {
            shared::dropaiweapon();
            self.lastweapon = self.weapon;
          }
        }

        if(isDefined(self.fnpreragdoll)) {
          self[[self.fnpreragdoll]]();
        }

        if(isDefined(self)) {
          self startragdoll();
        }

        if(isalive(self)) {
          println("<dev string:x119>");
        }
      }

      function notetrackstartliveragdoll(note, flagname) {
        if(isDefined(self.var_2bfa9e6b91820fc2)) {
          self[[self.var_2bfa9e6b91820fc2]]();
        }
      }

      function notetrackragdollblendinit(note, flagname) {
        if(isDefined(self.noragdoll)) {
          return;
        }

        if(isDefined(self.ragdolltime)) {
          return;
        }

        if(!isDefined(self.dont_unlink_ragdoll)) {
          thread unlinknextframe();
        }

        if(isDefined(self._blackboard)) {
          if(isDefined(self._blackboard.awaitingdropgunnotetrack) && self._blackboard.awaitingdropgunnotetrack == 1) {
            shared::dropaiweapon();
            self.lastweapon = self.weapon;
          }
        }

        if(isDefined(self.fnpreragdoll)) {
          self[[self.fnpreragdoll]]();
        }

        self ragdollblendinit();
      }

      function notetrackragdollblendstart(note, flagname) {}

      function notetrackragdollblendend(note, flagname) {}

      function notetrackragdollblendrootanim(note, flagname) {}

      function notetrackragdollblendrootragdoll(note, flagname) {}

      function notetrackkillai(note, flagname) {
        if(!isai(self)) {
          return;
        }

        if(isalive(self)) {
          self startragdoll();
          wait 1;
          self kill();
        }
      }

      function notetrackgundrop(note, flagname) {
        if(!isai(self)) {
          println("<dev string:x140>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x155>" + note + "<dev string:x16b>");
          return;
        }

        shared::dropaiweapon();

        if(isDefined(self._blackboard)) {
          self._blackboard.awaitingdropgunnotetrack = 0;
        }

        self.lastweapon = self.weapon;
      }

      function setpose(pose) {
        self.currentpose = pose;

        if(isDefined(self.a.onback)) {
          utility::stoponback();
        }

        asm_bb::bb_requeststance(pose);
        self notify("\x1c\xb1.\x96/\x18d\xb0\xbfA\vh" + pose);
      }

      function unlinknextframe() {
        wait 0.1;

        if(isDefined(self)) {
          self unlink();
        }
      }

      function notetrack_model_translate(model) {
        result = model;

        switch (model) {
          case #"hash_325cb2e66f67d5b9":
          case #"hash_719417cb1de832b6":
          case #"hash_f731f17ca0fe624f":
            if(isDefined(self.weaponinfo)) {
              foreach(info in self.weaponinfo) {
                weaponname = strtok(key, "H")[0];
                weap = nullweapon();

                if(isDefined(weaponname) && weaponname != "\r+x5" && weaponname != "") {
                  weap = utility_sp::make_weapon(weaponname);
                }

                if(model == "\x8e\xfcc\xbe\xdf\xa6" && weap.classname == "\x8e\xfcc\xbe\xdf\xa6") {
                  result = getweaponmodel(weap);
                  continue;
                }

                if(model != "\x8e\xfcc\xbe\xdf\xa6" && weap.inventorytype == model && result == model) {
                  result = getweaponmodel(weap);
                }
              }
            }

            if(result == model) {
              result = "\r+x5";
            }

            break;
        }

        return result;
      }

      function notetrack_vo(alias) {
        if(isDefined(self.anim_playsound_func)) {
          self thread[[self.anim_playsound_func]](alias, "\xa6\xeb\x1ae\x85#", 1);
          return;
        }

        if(isDefined(self.anim_playvo_func)) {
          self thread[[self.anim_playvo_func]](alias, "\xa6\xeb\x1ae\x85#", 1);
          return;
        }

        if(!issentient(self)) {
          thread utility::playsoundontag(alias, "\xa6\xeb\x1ae\x85#", 1, alias);
          return;
        }

        anim_sp::play_sound_at_viewheight(alias, "\xdc\xf6\xba\xdcFF\xdb\xe6e", 1);
      }

      function notetrack_prefix_handler_sp(notetrack) {
        prefix3 = getsubstr(notetrack, 0, 3);

        switch (prefix3) {
          case #"hash_8966586c51e34031":
            alias = getsubstr(notetrack, 3);

            if(isDefined(self.anim_playsound_func)) {
              self thread[[self.anim_playsound_func]](alias, "\xa6\xeb\x1ae\x85#", 1);
            } else {
              params = strtok(alias, "\x16");
              soundsendondeath = 1;

              if(istrue(self.var_d19a8537548cadb3)) {
                soundsendondeath = undefined;
              }

              if(params.size < 2) {
                thread utility::playsoundontag(alias, undefined, soundsendondeath);
              } else {
                thread utility::playsoundontag(params[0], params[1], soundsendondeath);
              }
            }

            return 1;
          case #"hash_7b1f866c4a8d9d17":
            if(canplaynotetrackvo()) {
              alias = getsubstr(notetrack, 3);
              notetrack_vo(alias);
              return 1;
            }

            break;
          case #"hash_212b5a6c1b27bb77":
            if(canplaynotetrackvo()) {
              custom_bc = getsubstr(notetrack, 3);
              prefix = battlechatter::executeevent(custom_bc);
              return 1;
            }

            break;
          case #"hash_8fefc16c551511d7":
            if(canplaynotetrackvo()) {
              alias = getsubstr(notetrack, 3);

              if(isDefined(self.anim_smartdialog_func)) {
                self thread[[self.anim_smartdialog_func]](alias);
              } else {
                thread utility_sp::smart_dialogue(alias);
              }

              return 1;
            }

            break;
          case #"hash_900fc16c552ea9bd":
            if(canplaynotetrackvo()) {
              alias = getsubstr(notetrack, 3);
              level thread utility_sp::smart_radio_dialogue(alias);
              return 1;
            }

            break;
          case #"hash_256b66c0ab12624":
            vector_str = strtok(tolower(notetrack), "\xa7\xc0");
            str = strtok(getsubstr(vector_str[0], 3), "\x83D\x8b\x9a");
            vectors = [];

            if(vector_str.size > 1) {
              for(i = 1; i < vector_str.size; i++) {
                vector = strtok(vector_str[i], "\x16");

                if(vector.size > 1) {
                  assert(vector.size == 3, "<dev string:x194>" + vector.size);
                  str[str.size] = (float(vector[0]), float(vector[1]), float(vector[2]));
                  continue;
                }

                str[str.size] = vector[0];
              }
            }

            if(str.size == 2) {
              if(str[0] == "\xac\xe18\xd8\xdb\x8c\x95'") {
                utility::exploder(str[1]);
                return 1;
              } else if(str[0] == "h\x11\x93\x97U{\xaf\xbd]\x81kN\x16") {
                utility::stop_exploder(str[1]);
                return 1;
              } else {
                playFXOnTag(level._effect[str[0]], self, str[1]);
                return 1;
              }
            } else if(str.size == 3) {
              if(str[0] == "p\xb1,/\x99\xf0o\xe6\x1d\x16\xb3") {
                fx_name = str[1];
                fx = level._effect[fx_name];
                assert(isDefined(fx), "<dev string:x1be>" + fx_name + "<dev string:x1ca>");
                tag_name = str[2];
                playFXOnTag(fx, self, tag_name);
                return 1;
              } else if(str[0] == "\xfd\xbd\xd7\xdc@\xc0\xb8tt\xe69") {
                stopFXOnTag(level._effect[str[1]], self, str[2]);
                return 1;
              } else if(str[0] == "?\x1e\xe2*-\x1b\x1eW\x96\xfbz") {
                killfxontag(level._effect[str[1]], self, str[2]);
                return 1;
              }
            } else if(str.size == 6) {
              if(str[0] == "*\xec,\xc7\xf1\xe3") {
                playFXOnTag(level._effect[str[1]], self, str[2]);
                self hidepart(str[2], str[3]);
                return 1;
              }
            } else if(str.size == 11) {
              p = (float(str[2]), float(str[3]), float(str[4]));
              f = (float(str[5]), float(str[6]), float(str[7]));
              u = (float(str[8]), float(str[9]), float(str[10]));
              playFX(level._effect[str[1]], p, f, u);
            }

            break;
          case #"hash_4e4e106c32fa68d2":
            if(!isai(self)) {
              return 1;
            }

            suffix = getsubstr(notetrack, 3, notetrack.size);

            if(suffix == "\xb8\"" || suffix == "Pv\xfd:") {
              if(!isDefined(self.ht_on)) {
                self.ht_on = 1;
              }

              utility::lookatentity(level.player, 0);
            } else if(suffix == "\xba\r&\xc6") {
              if(!isDefined(self.ht_on)) {
                self.ht_on = 1;
              }

              utility::lookatentity(level.player, 1);
            } else {
              utility::cleanupanimscriptedheadlook();
            }

            return 1;
          case #"hash_286f036c1eec89aa":
            var_4cd82e9ac125df33 = getsubstr(notetrack, 3, notetrack.size);
            archetype = self getbasearchetype();
            assert(isDefined(archetype));
            desiredspeed = getanimspeedthreshold(archetype, var_4cd82e9ac125df33);
            self aisetdesiredspeed(desiredspeed);
            self aisettargetspeed(desiredspeed);
            return 1;
          case #"hash_4e5ad06c3304916e":
            parms = getsubstr(notetrack, 3);

            switch (parms) {
              case #"hash_fa2ad6f6bd651030":
                if(isai(self)) {
                  self setlookatstate("\xf7x\xb7\xf3\xdf\xf3\x13");
                  self setlookatplayer(level.player);
                }

                return 1;
              case #"hash_23a4247209319a1":
                if(isai(self)) {
                  self setlookatstate("\xf7x\xb7\xf3\xdf\xf3\x13");
                  self setlookatpos();
                }

                return 1;
              case #"hash_3699ac6c262c25ea":
                if(isai(self)) {
                  self setlookatstate("Y\xd5\x8e\r7$\xfc5");
                }

                return 1;
            }

            break;
          case #"hash_901bbd6c55379dcd":
            parmlist = strtok(notetrack, "\xe2$<");
            right = isDefined(parmlist[1]) ? float(parmlist[1]) : 0;
            left = isDefined(parmlist[2]) ? float(parmlist[2]) : 0;
            top = isDefined(parmlist[3]) ? float(parmlist[3]) : 0;
            bottom = isDefined(parmlist[4]) ? float(parmlist[4]) : 0;
            blend = isDefined(parmlist[5]) ? float(parmlist[5]) : 0;
            level.player lerpviewangleclamp(blend, blend * 0.5, blend * 0.5, right, left, top, bottom, 1);
            return 1;
          case #"hash_7b3b466c4aa2fea6":
            if(level.player islinked()) {
              viewfraction = getsubstr(notetrack, 3, notetrack.size);
              viewfraction = float(viewfraction);

              if(isDefined(level.player getlinkedparent())) {
                level.player playerlinkedviewfraction(viewfraction);
              }
            }

            return 1;
          case #"hash_8927586c51b1a365":
            gesture = getsubstr(notetrack, 3, notetrack.size);
            level.player forceplaygestureviewmodel(gesture);
            return 1;
          case #"hash_ed53bb6c000173b4":
            parmlist = strtok(notetrack, "\xe2$<");
            scale = isDefined(parmlist[1]) ? float(parmlist[1]) : 1;
            duration = isDefined(parmlist[2]) ? float(parmlist[2]) : 1;
            level.player earthquakeforplayer(scale, duration, level.player.origin, 1000);
            return 1;
          case #"hash_f493246c03c20b90":
            if(isDefined(level.dyndof)) {
              utility::dyndofexp_stop();
            }

            fstop = undefined;
            focusspeed = undefined;
            aperturespeed = undefined;
            angles = undefined;
            focalbone = undefined;
            ignoreplayer = undefined;
            ignorecollision = undefined;
            parms = getsubstr(notetrack, 3, notetrack.size);
            parmlist = strtok(parms, "\xf8\x01");

            switch (parmlist.size) {
              case 8:
                ignorecollision = function_60537f66a8eecd80(parmlist[7]);
              case 7:
                ignoreplayer = function_60537f66a8eecd80(parmlist[6]);
              case 6:
                focalbone = parmlist[5];

                if(focalbone == "Bf") {
                  focalbone = undefined;
                }
              case 5:
                angles = float(parmlist[4]);

                if(angles < 0) {
                  angles = undefined;
                }
              case 4:
                aperturespeed = float(parmlist[3]);

                if(aperturespeed < 0) {
                  aperturespeed = undefined;
                }
              case 3:
                focusspeed = float(parmlist[2]);

                if(focusspeed < 0) {
                  focusspeed = undefined;
                }
              case 2:
                fstop = float(parmlist[1]);

                if(fstop < 0) {
                  fstop = undefined;
                }
              case 1:
                break;
            }

            ignorelist = [];

            if(istrue(ignoreplayer)) {
              ignorelist = [level.player];

              if(isDefined(level.player_rig)) {
                ignorelist[ignorelist.size] = level.player_rig;
              }
            }

            level.player thread utility::dof_enable_autofocus(fstop, self, focusspeed, aperturespeed, angles, focalbone, ignorelist, ignorecollision);
            return 1;
          case #"hash_8937186c51be0a98":
            parmlist = strtok(notetrack, "\xe2$<");
            enabled = isDefined(parmlist[1]) ? int(parmlist[1]) : 1;

            if(enabled) {
              utility_sp::enable_procedural_bones();
            } else {
              utility_sp::disable_procedural_bones();
            }

            return 1;
          case #"hash_6d3c746c4385b41d":
            parmlist = strtok(notetrack, "\xe2$<");
            from = isDefined(parmlist[1]) ? float(parmlist[1]) : 1;
            to = isDefined(parmlist[2]) ? float(parmlist[2]) : 1;
            duration = isDefined(parmlist[3]) ? float(parmlist[3]) : 1;
            setslowmotion(from, to, duration);
            return 1;
        }

        prefix4 = getsubstr(notetrack, 0, 4);

        switch (prefix4) {
          case #"hash_2ee8a084e861ef57":
            if(canplaynotetrackvo()) {
              alias = getsubstr(notetrack, 4);
              utility_sp::radio_dialogue(alias);
              return 1;
            }

            break;
          case #"hash_8c1d5a8493291b9b":
            if(canplaynotetrackvo()) {
              alias = getsubstr(notetrack, 4);

              if(isDefined(self.anim_playsound_func)) {
                self thread[[self.anim_playsound_func]](alias, "\xa6\xeb\x1ae\x85#", 1);
              } else {
                thread pip_util::pip_dialogue(alias);
              }

              return 1;
            }

            break;
          case #"hash_1a446584ddfd0cd9":
            if(canplaynotetrackvo()) {
              alias = getsubstr(notetrack, 4);

              if(isDefined(level.var_b51adaa1b35e5117)) {
                self thread[[level.var_b51adaa1b35e5117]](alias);
              } else {
                thread utility_sp::smart_player_dialogue(alias);
              }

              return 1;
            }

            break;
          case #"hash_77915f8488d69295":
            if(!isai(self)) {
              assertmsg("<dev string:x24>" + notetrack + "<dev string:x29>");
              return 1;
            }

            data = strtok(tolower(notetrack), "\x16");
            data[0] = getsubstr(data[0], 4);
            function_96af245867510885(data);
            return 1;
          case #"hash_a22f1814f7af01f5":
            var_96734369e22f6233 = strtok(notetrack, "w");
            var_1d37a3b421f5df06 = float(var_96734369e22f6233[1]);
            var_9dea69d0e1d0a27c = float(var_96734369e22f6233[2]);
            level.player lerpfovscalefactor(var_1d37a3b421f5df06, var_9dea69d0e1d0a27c);
            return 1;
          case #"hash_f94a040a056fe52b":
            dof_values = strtok(notetrack, "w");
            dof_values_count = dof_values.size;
            dof_fstop = float(dof_values[1]);
            dof_focusdistance = float(dof_values[2]);
            var_ee36be1303d59b84 = undefined;
            dof_aperturespeed = undefined;

            if(dof_values_count > 3) {
              var_ee36be1303d59b84 = float(dof_values[3]);
            }

            if(dof_values_count > 4) {
              dof_aperturespeed = float(dof_values[4]);
            }

            level.player thread utility::dof_enable(dof_fstop, dof_focusdistance, undefined, var_ee36be1303d59b84, dof_aperturespeed);
            return 1;
        }

        return notetracks::notetrack_prefix_handler_common(notetrack);
      }

      function canplaynotetrackvo() {
        if(level.missionfailed && !level.notetrackmissionfailedvo) {
          return false;
        }

        if(!level.notetrackvo) {
          return false;
        }

        return true;
      }

      function eyeonnotehandler(note, flagname) {
        self setanim(%1 $\x01\x83 {
            \
            x80\x83\x96\xc6\xc6B\xaf\xa7n\x1a, 1, 0.2, 1);
        }

        function eyeoffnotehandler(note, flagname) {
          self clearanim(%1 $\x01\x83 {
              \
              x80\x83\x96\xc6\xc6B\xaf\xa7n\x1a, 0.2);
          }

          function notetrackenableweapons(note, flagname) {
            if(isai(self)) {
              return;
            }

            level.player enableoffhandweapons();
            level.player enableweapons();
          }

          function notetrackdisableweapons(note, flagname) {
            if(isai(self)) {
              return;
            }

            level.player disableoffhandweapons();
            level.player disableweapons();
          }

          function function_96af245867510885(parameters) {
            mode = parameters[0];

            switch (mode) {
              case #"hash_628ffe6f4a417560":
                function_ad049502a3ced9b1(parameters);
                break;
              case #"hash_f6706428c38f0019":
                function_ffbed1fe1bff9cd0(parameters);
                break;
              case #"hash_87d1443ef2805760":
                function_f4edf82b8d206265(parameters);
                break;
              case #"hash_cdd656b8cc7b709c":
                function_d2efece0a010a05d(parameters);
                break;
              case #"hash_148c417c2690352d":
                function_cb2bd95de6bd8288(parameters);
                break;
              case #"hash_6aeeafe63b5fd92f":
                function_86ad9886200ba336(parameters);
                break;
              case #"hash_fa2ad6f6bd651030":
                self setlookatapproved(1, ",U\xdf.");
                break;
              case #"hash_3699ac6c262c25ea":
                self setlookatapproved(0, ",U\xdf.");
                break;
              case #"hash_76d9f4ac5d921342":
                self setlookatblocked(1, ",U\xdf.");
                break;
              case #"hash_f54ad023c463669f":
                self setlookatblocked(0, ",U\xdf.");
                break;
              default:
                assertmsg("<dev string:x1f2>" + mode + "<dev string:x24>");
                break;
            }
          }

          function function_ad049502a3ced9b1(parameters) {
            if(parameters.size != 2) {
              assertmsg("<dev string:x220>");
              return;
            }

            if(self function_ab101a90947d29bf() == 0) {
              return;
            }

            speed = int(parameters[1]);
            self function_67db1c853c0e3be0(speed);
          }

          function function_ffbed1fe1bff9cd0(parameters) {
            if(parameters.size != 4) {
              assertmsg("<dev string:x263>");
              return;
            }

            if(self function_ab101a90947d29bf() == 0) {
              return;
            }

            spine = float(parameters[1]);
            neck = float(parameters[2]);
            head = float(parameters[3]);
            self function_cd57abbe997befc1(spine, neck, head);
          }

          function function_f4edf82b8d206265(parameters) {
            if(parameters.size != 2) {
              assertmsg("<dev string:x2b4>");
              return;
            }

            if(self function_ab101a90947d29bf() == 0) {
              return;
            }

            switch (tolower(parameters[1])) {
              case #"hash_31100fbc01bd387c":
              case #"hash_fa2ad6f6bd651030":
                self setlookatplayer(level.player);
                break;
              case #"hash_311010bc01bd3a0f":
              case #"hash_3699ac6c262c25ea":
                self setlookatpos();
                break;
              default:
                assertmsg("<dev string:x2f2>" + parameters[1] + "<dev string:x31b>");
                break;
            }
          }

          function function_d2efece0a010a05d(parameters) {
            if(parameters.size != 3) {
              assertmsg("<dev string:x333>");
              return;
            }

            if(self function_ab101a90947d29bf() == 0) {
              return;
            }

            horizontal = float(parameters[1]);
            vertical = float(parameters[2]);
            self function_6ceaed4c898162d1(horizontal, vertical);
          }

          function function_cb2bd95de6bd8288(parameters) {
            if(parameters.size != 5) {
              assertmsg("<dev string:x380>");
              return;
            }

            if(self function_ab101a90947d29bf() == 0) {
              return;
            }

            left = float(parameters[1]);
            right = float(parameters[2]);
            up = float(parameters[3]);
            down = float(parameters[4]);
            self function_fb686ff72b0c0a0d(left, right, up, down);
          }

          function function_86ad9886200ba336(parameters) {
            if(parameters.size != 2) {
              assertmsg("<dev string:x3d7>");
              return;
            }

            if(self function_ab101a90947d29bf() == 0) {
              return;
            }

            self setlookatheadoffset(float(parameters[1]));
          }

          function function_d3c514dbbc1da583(note, flagname, customparams) {
            if(customparams.size == 3) {
              params = strtok(customparams[2], "\x16");

              if(params.size >= 3) {
                modelname = params[0];
                tagname = params[1];
                entitytargetname = params[2];
                positionoffset = [0, 0, 0];
                angleoffset = [0, 0, 0];
                var_8189951eedfff693 = 3;
                var_e1b2b81b37cac49 = 6;

                for(paramindex = var_8189951eedfff693; paramindex < params.size && paramindex < var_e1b2b81b37cac49; paramindex++) {
                  positionoffset[paramindex - var_8189951eedfff693] = float(params[paramindex]);
                }

                for(paramindex = var_e1b2b81b37cac49; paramindex < params.size; paramindex++) {
                  angleoffset[paramindex - var_e1b2b81b37cac49] = float(params[paramindex]);
                }

                spawnedentity = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", level.player.origin);
                spawnedentity setModel(modelname);
                spawnedentity linktoplayerviewignoreparentrot(level.player, tagname, (positionoffset[0], positionoffset[1], positionoffset[2]), (angleoffset[0], angleoffset[1], angleoffset[2]), 0, 0, 0, 0);
                spawnedentity.targetname = entitytargetname;
              }
            }
          }

          function function_60537f66a8eecd80(str) {
            if(tolower(str) == "at\xea\xb9") {
              return true;
            }

            return int(str) && true;
          }
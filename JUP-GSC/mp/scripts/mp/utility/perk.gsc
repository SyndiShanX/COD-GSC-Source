/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\perk.gsc
***********************************************/

#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\utility\perk_shared;
#namespace perk;

function perksenabled() {
  return level.allowperks;
}

function _hasperk(perkname) {
  return scripts\mp\utility\perk_shared::function_56ad1b98a0613f8a(perkname);
}

function giveperk(perkname) {
  assertex(isDefined(perkname), "<dev string:x1c>");
  assertex(perkname != "<dev string:x4b>", "<dev string:x5d>");
  assertex(perkname != "<dev string:xa0>", "<dev string:xa8>");
  scripts\mp\perks\perks::_setperk(perkname);
  scripts\mp\perks\perks::_setextraperks(perkname);
}

function resetperkpackage() {
  scripts\mp\perks\perkpackage::perkpackage_reset();
}

function removeperk(perkname) {
  if(istrue(level.gameended)) {
    return;
  }

  assertex(isDefined(perkname), "<dev string:xe1>");
  assertex(perkname != "<dev string:x4b>", "<dev string:x112>");
  assertex(perkname != "<dev string:xa0>", "<dev string:x145>");

  if(!isDefined(self)) {
    return;
  }

  scripts\mp\perks\perks::_unsetperk(perkname);
  scripts\mp\perks\perks::_unsetextraperks(perkname);
}

function blockperkfunction(perkname) {
  assertex(isDefined(perkname), "<dev string:x16e>");
  assertex(perkname != "<dev string:x4b>", "<dev string:x1a0>");
  assertex(perkname != "<dev string:xa0>", "<dev string:x1d4>");

  if(!function_8641edd897d42547(perkname)) {
    self.perksblocked[perkname] = 1;
  } else {
    self.perksblocked[perkname]++;
  }

  if(self.perksblocked[perkname] == 1 && _hasperk(perkname)) {
    scripts\mp\perks\perks::_unsetperkinternal(perkname);

    foreach(perk, array in level.extraperkmap) {
      if(perkname == perk) {
        foreach(extraperk in array) {
          if(!function_8641edd897d42547(perkname)) {
            self.perksblocked[extraperk] = 1;
          } else {
            self.perksblocked[extraperk]++;
          }

          if(self.perksblocked[extraperk] == 1) {
            scripts\mp\perks\perks::_unsetperkinternal(extraperk);
          }
        }

        break;
      }
    }
  }

  level notify("<dev string:x1fe>");
}

function unblockperkfunction(perkname) {
  assertex(isDefined(perkname), "<dev string:x213>");
  assertex(perkname != "<dev string:x4b>", "<dev string:x24d>");
  assertex(perkname != "<dev string:xa0>", "<dev string:x289>");
  assertex(function_8641edd897d42547(perkname) && istrue(self.perksblocked[perkname] > 0) || isDefined(level.perks_suppressasserts), "<dev string:x2bb>");
  self.perksblocked[perkname]--;

  if(self.perksblocked[perkname] == 0) {
    self.perksblocked[perkname] = undefined;

    if(_hasperk(perkname)) {
      scripts\mp\perks\perks::_setperkinternal(perkname);

      foreach(perk, array in level.extraperkmap) {
        if(perkname == perk) {
          foreach(extraperk in array) {
            assertex(function_8641edd897d42547(extraperk) && istrue(self.perksblocked[extraperk] > 0) || isDefined(level.perks_suppressasserts), "<dev string:x2f6>");
            self.perksblocked[extraperk]--;

            if(self.perksblocked[extraperk] == 0) {
              scripts\mp\perks\perks::_setperkinternal(extraperk);
              self.perksblocked[extraperk] = undefined;
            }
          }

          break;
        }
      }
    }
  }

  level notify("<dev string:x1fe>");
}

function getbaseperkname(perkname) {
  if(isendstr(perkname, "_ks")) {
    perkname = getsubstr(perkname, 0, perkname.size - 3);
  }

  return perkname;
}

function lightweightscalar() {
  return 1.06;
}

function function_8641edd897d42547(perkname) {
  if(!isDefined(perkname)) {
    return false;
  }

  if(!isDefined(self.perksblocked)) {
    return false;
  }

  return isDefined(self.perksblocked[perkname]);
}

function function_97cbc67b162a70f4() {
  if(getdvarint(@ "hash_bd3e4943999de33b", 0)) {
    return 0;
  }

  if(isDefined(level.gamemodebundle)) {
    return istrue(level.gamemodebundle.var_ac36c9085edf4e44);
  }

  return getdvarint(@ "perk_package_enabled", 1);
}

function function_ea4c5dc15c3bbdd9() {
  if(isDefined(level.gamemodebundle)) {
    return istrue(level.gamemodebundle.var_e12ed09bf2e43167);
  }

  return getdvarint(@ "hash_7a1dc05c581af6f8", 0);
}

function function_d327b07e25d475e1() {
  if(isDefined(level.gamemodebundle)) {
    return istrue(level.gamemodebundle.var_9b88563ac5ace911);
  }

  return false;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\perk.gsc
***********************************************/

function perksenabled() {
  return level.allowperks;
}

function _hasperk(var0) {
  return isDefined(self.perks) && isDefined(self.perks[var0]);
}

function giveperk(var0) {
  scripts\mp\perks\perks::_setperk(var0);
  scripts\mp\perks\perks::_setextraperks(var0);
}

function resetperkpackage() {
  scripts\mp\perks\perkpackage::perkpackage_reset();
}

function removeperk(var0) {
  if(istrue(level.gameended)) {
    return;
  }

  scripts\mp\perks\perks::_unsetperk(var0);
  scripts\mp\perks\perks::_unsetextraperks(var0);
}

function blockperkfunction(var0) {
  if(!isDefined(self.perksblocked[var0])) {
    self.perksblocked[var0] = 1;
  } else {
    self.perksblocked[var0]++;
  }

  if(self.perksblocked[var0] == 1 && _hasperk(var0)) {
    scripts\mp\perks\perks::_unsetperkinternal(var0);

    foreach(var2 in level.extraperkmap) {
      if(var0 == var6) {
        foreach(var4 in var2) {
          if(!isDefined(self.perksblocked[var4])) {
            self.perksblocked[var4] = 1;
          } else {
            self.perksblocked[var4]++;
          }

          if(self.perksblocked[var4] == 1) {
            scripts\mp\perks\perks::_unsetperkinternal(var4);
          }
        }

        break;
      }
    }

    return;
  }
}

function unblockperkfunction(var0) {
  self.perksblocked[var0]--;

  if(self.perksblocked[var0] == 0) {
    self.perksblocked[var0] = undefined;

    if(_hasperk(var0)) {
      scripts\mp\perks\perks::_setperkinternal(var0);

      foreach(var2 in level.extraperkmap) {
        if(var0 == var6) {
          foreach(var4 in var2) {
            self.perksblocked[var4]--;

            if(self.perksblocked[var4] == 0) {
              scripts\mp\perks\perks::_setperkinternal(var4);
              self.perksblocked[var4] = undefined;
            }
          }

          break;
        }
      }

      return;
    }

    return;
  }
}

function getbaseperkname(var0) {
  if(isendstr(var0, "_ks")) {
    var0 = getsubstr(var0, 0, var0.size - 3);
  }

  return var0;
}

function lightweightscalar() {
  return 1.1;
}
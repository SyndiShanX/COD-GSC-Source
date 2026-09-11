/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\perk.gsc
***********************************************/

function perksenabled() {
  return level.allowperks;
}

function _hasperk(var_0) {
  return isDefined(self.perks) && isDefined(self.perks[var_0]);
}

function giveperk(var_0) {
  scripts\mp\perks\perks::_setperk(var_0);
  scripts\mp\perks\perks::_setextraperks(var_0);
}

function resetperkpackage() {
  scripts\mp\perks\perkpackage::perkpackage_reset();
}

function removeperk(var_0) {
  if(istrue(level.gameended)) {
    return;
  }

  scripts\mp\perks\perks::_unsetperk(var_0);
  scripts\mp\perks\perks::_unsetextraperks(var_0);
}

function blockperkfunction(var_0) {
  if(!isDefined(self.perksblocked[var_0])) {
    self.perksblocked[var_0] = 1;
  } else {
    self.perksblocked[var_0]++;
  }

  if(self.perksblocked[var_0] == 1 && _hasperk(var_0)) {
    scripts\mp\perks\perks::_unsetperkinternal(var_0);

    foreach(var_2 in level.extraperkmap) {
      if(var_0 == var_6) {
        foreach(var_4 in var_2) {
          if(!isDefined(self.perksblocked[var_4])) {
            self.perksblocked[var_4] = 1;
          } else {
            self.perksblocked[var_4]++;
          }

          if(self.perksblocked[var_4] == 1) {
            scripts\mp\perks\perks::_unsetperkinternal(var_4);
          }
        }

        break;
      }
    }

    return;
  }
}

function unblockperkfunction(var_0) {
  self.perksblocked[var_0]--;

  if(self.perksblocked[var_0] == 0) {
    self.perksblocked[var_0] = undefined;

    if(_hasperk(var_0)) {
      scripts\mp\perks\perks::_setperkinternal(var_0);

      foreach(var_2 in level.extraperkmap) {
        if(var_0 == var_6) {
          foreach(var_4 in var_2) {
            self.perksblocked[var_4]--;

            if(self.perksblocked[var_4] == 0) {
              scripts\mp\perks\perks::_setperkinternal(var_4);
              self.perksblocked[var_4] = undefined;
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

function getbaseperkname(var_0) {
  if(isendstr(var_0, "_ks")) {
    var_0 = getsubstr(var_0, 0, var_0.size - 3);
  }

  return var_0;
}

function lightweightscalar() {
  return 1.1;
}
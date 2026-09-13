/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\perk.gsc
***********************************************/

perksenabled() {
  return level.allowperks;
}

_hasperk(perkname) {
  return isDefined(perkname) && isDefined(self.perks) && isDefined(self.perks[perkname]);
}

giveperk(perkname) {
  scripts\mp\perks\perks::_setperk(perkname);
  scripts\mp\perks\perks::_setextraperks(perkname);
}

resetperkpackage() {
  scripts\mp\perks\perkpackage::perkpackage_reset();
}

removeperk(perkname) {
  if(istrue(level.gameended)) {
    return;
  }
  scripts\mp\perks\perks::_unsetperk(perkname);
  scripts\mp\perks\perks::_unsetextraperks(perkname);
}

blockperkfunction(perkname) {
  if(!_id_8641EDD897D42547(perkname))
    self.perksblocked[perkname] = 1;
  else
    self.perksblocked[perkname]++;

  if(self.perksblocked[perkname] == 1 && _hasperk(perkname)) {
    scripts\mp\perks\perks::_unsetperkinternal(perkname);

    foreach(perk, array in level.extraperkmap) {
      if(perkname == perk) {
        foreach(_id_43596460393338E5 in array) {
          if(!_id_8641EDD897D42547(perkname))
            self.perksblocked[_id_43596460393338E5] = 1;
          else
            self.perksblocked[_id_43596460393338E5]++;

          if(self.perksblocked[_id_43596460393338E5] == 1)
            scripts\mp\perks\perks::_unsetperkinternal(_id_43596460393338E5);
        }

        break;
      }
    }
  }
}

unblockperkfunction(perkname) {
  self.perksblocked[perkname]--;

  if(self.perksblocked[perkname] == 0) {
    self.perksblocked[perkname] = undefined;

    if(_hasperk(perkname)) {
      scripts\mp\perks\perks::_setperkinternal(perkname);

      foreach(perk, array in level.extraperkmap) {
        if(perkname == perk) {
          foreach(_id_43596460393338E5 in array) {
            self.perksblocked[_id_43596460393338E5]--;

            if(self.perksblocked[_id_43596460393338E5] == 0) {
              scripts\mp\perks\perks::_setperkinternal(_id_43596460393338E5);
              self.perksblocked[_id_43596460393338E5] = undefined;
            }
          }

          break;
        }
      }
    }
  }
}

getbaseperkname(perkname) {
  if(isendstr(perkname, "_ks"))
    perkname = getsubstr(perkname, 0, perkname.size - 3);

  return perkname;
}

lightweightscalar() {
  return 1.1;
}

_id_8641EDD897D42547(perkname) {
  if(!isDefined(perkname))
    return 0;

  if(!isDefined(self.perksblocked))
    return 0;

  return isDefined(self.perksblocked[perkname]);
}
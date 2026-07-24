/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3650.gsc
**************************************/

init() {
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.player.perks = [];
  level.player.perksblocked = [];
  level._id_12F75 = [];
  level._id_12F79 = [];
  level.scriptperks = [];
  level.scriptperks["specialty_steadyaim"] = 1;
  level.scriptperks["specialty_quickswap"] = 1;
  level.scriptperks["specialty_quickdraw"] = 1;
  level.scriptperks["specialty_focus"] = 1;
  level.scriptperks["specialty_fastreload"] = 1;
  level.scriptperks["specialty_agility"] = 1;
  level.scriptperks["specialty_extraequipment"] = 1;
  level.scriptperks["specialty_blastshield"] = 1;
  level.scriptperks["specialty_fastregen"] = 1;
  level.scriptperks["specialty_slasher"] = 1;
  level.scriptperks["specialty_shocker"] = 1;
  level.scriptperks["upgrade_frag_1"] = 1;
  level.scriptperks["upgrade_frag_2"] = 1;
  level.scriptperks["upgrade_shock_1"] = 1;
  level.scriptperks["upgrade_shock_2"] = 1;
  level.scriptperks["upgrade_antigrav_1"] = 1;
  level.scriptperks["upgrade_antigrav_2"] = 1;
  level.scriptperks["upgrade_seeker_1"] = 1;
  level.scriptperks["upgrade_seeker_2"] = 1;
  level.scriptperks["upgrade_hack_1"] = 1;
  level.scriptperks["upgrade_shield_1"] = 1;
  level.scriptperks["upgrade_drone_1"] = 1;
  level.scriptperks["upgrade_cover_1"] = 1;
  level.perksetfuncs["specialty_fastreload"] = _id_0E41::_id_F701;
  level.perkunsetfuncs["specialty_fastreload"] = _id_0E41::_id_12CBC;
  level.perksetfuncs["specialty_steadyaim"] = _id_0E41::setstaticuicircles;
  level.perkunsetfuncs["specialty_steadyaim"] = _id_0E41::unsetspotter;
  level.perksetfuncs["specialty_quickswap"] = _id_0E41::setquickswap;
  level.perkunsetfuncs["specialty_quickswap"] = _id_0E41::unsetquickswap;
  level.perksetfuncs["specialty_focus"] = _id_0E41::_id_F712;
  level.perkunsetfuncs["specialty_focus"] = _id_0E41::_id_12CBE;
  level.perksetfuncs["specialty_quickdraw"] = _id_0E41::_id_F80F;
  level.perkunsetfuncs["specialty_quickdraw"] = _id_0E41::_id_12D12;
  level.perksetfuncs["specialty_agility"] = _id_0E41::_id_F636;
  level.perkunsetfuncs["specialty_agility"] = _id_0E41::_id_12C6F;
  level.perksetfuncs["specialty_extraequipment"] = _id_0E41::setextraequipment;
  level.perkunsetfuncs["specialty_extraequipment"] = _id_0E41::unsetextraequipment;
  level.perksetfuncs["specialty_blastshield"] = _id_0E41::setblastshield;
  level.perkunsetfuncs["specialty_blastshield"] = _id_0E41::unsetblastshield;
  level.perksetfuncs["specialty_fastregen"] = _id_0E41::_id_F700;
  level.perkunsetfuncs["specialty_fastregen"] = _id_0E41::_id_12CBB;
  level.perksetfuncs["specialty_slasher"] = _id_0E41::_id_F849;
  level._id_12F75["specialty_slasher"] = "specialty_shocker";
  level.perkunsetfuncs["specialty_slasher"] = _id_0E41::_id_12D2F;
  level.perksetfuncs["specialty_shocker"] = _id_0E41::_id_F83E;
  level._id_12F75["specialty_shocker"] = "specialty_slasher";
  level.perkunsetfuncs["specialty_shocker"] = _id_0E41::_id_12D2A;
  level.perksetfuncs["upgrade_frag_1"] = _id_0E41::_id_FAB8;
  level.perkunsetfuncs["upgrade_frag_1"] = _id_0E41::_id_12D5A;
  level._id_12F79[level._id_12F79.size] = "upgrade_frag_1";
  level.perksetfuncs["upgrade_frag_2"] = _id_0E41::_id_FAB9;
  level.perkunsetfuncs["upgrade_frag_2"] = _id_0E41::_id_12D5B;
  level._id_12F75["upgrade_frag_2"] = "upgrade_frag_1";
  level._id_12F79[level._id_12F79.size] = "upgrade_frag_2";
  level.perksetfuncs["upgrade_shock_1"] = _id_0E41::_id_FAC0;
  level.perkunsetfuncs["upgrade_shock_1"] = _id_0E41::_id_12D62;
  level._id_12F79[level._id_12F79.size] = "upgrade_shock_1";
  level.perksetfuncs["upgrade_shock_2"] = _id_0E41::_id_FAC1;
  level.perkunsetfuncs["upgrade_shock_2"] = _id_0E41::_id_12D63;
  level._id_12F75["upgrade_shock_2"] = "upgrade_shock_1";
  level._id_12F79[level._id_12F79.size] = "upgrade_shock_2";
  level.perksetfuncs["upgrade_antigrav_1"] = _id_0E41::_id_FAB2;
  level.perkunsetfuncs["upgrade_antigrav_1"] = _id_0E41::_id_12D54;
  level._id_12F79[level._id_12F79.size] = "upgrade_antigrav_1";
  level.perksetfuncs["upgrade_antigrav_2"] = _id_0E41::_id_FAB3;
  level.perkunsetfuncs["upgrade_antigrav_2"] = _id_0E41::_id_12D55;
  level._id_12F75["upgrade_antigrav_2"] = "upgrade_antigrav_1";
  level._id_12F79[level._id_12F79.size] = "upgrade_antigrav_2";
  level.perksetfuncs["upgrade_seeker_1"] = _id_0E41::_id_FABC;
  level.perkunsetfuncs["upgrade_seeker_1"] = _id_0E41::_id_12D5E;
  level._id_12F79[level._id_12F79.size] = "upgrade_seeker_1";
  level.perksetfuncs["upgrade_seeker_2"] = _id_0E41::_id_FABD;
  level.perkunsetfuncs["upgrade_seeker_2"] = _id_0E41::_id_12D5F;
  level._id_12F75["upgrade_seeker_2"] = "upgrade_seeker_1";
  level._id_12F79[level._id_12F79.size] = "upgrade_seeker_2";
  level.perksetfuncs["upgrade_hack_1"] = _id_0E41::_id_FABA;
  level.perkunsetfuncs["upgrade_hack_1"] = _id_0E41::_id_12D5C;
  level._id_12F79[level._id_12F79.size] = "upgrade_hack_1";
  level.perksetfuncs["upgrade_shield_1"] = _id_0E41::_id_FABE;
  level.perkunsetfuncs["upgrade_shield_1"] = _id_0E41::_id_12D60;
  level._id_12F79[level._id_12F79.size] = "upgrade_shield_1";
  level.perksetfuncs["upgrade_drone_1"] = _id_0E41::_id_FAB6;
  level.perkunsetfuncs["upgrade_drone_1"] = _id_0E41::_id_12D58;
  level._id_12F79[level._id_12F79.size] = "upgrade_drone_1";
  level.perksetfuncs["upgrade_cover_1"] = _id_0E41::_id_FAB4;
  level.perkunsetfuncs["upgrade_cover_1"] = _id_0E41::_id_12D56;
  level._id_12F79[level._id_12F79.size] = "upgrade_cover_1";
  _id_98B0();
}

_id_98B0() {}

giveperks(var_0) {
  foreach(var_2 in var_0) {
    giveperk(var_2);
  }
}

giveperk(var_0) {
  _setperk(var_0);
}

removeperk(var_0) {
  _unsetperk(var_0);
}

_id_83B7(var_0) {
  foreach(var_2 in var_0) {
    _id_83B6(var_2);
  }
}

_id_83B6(var_0) {
  if(isDefined(level._id_12F75[var_0])) {
    var_1 = level._id_12F75[var_0];

    while(_hasperk(var_1)) {
      _unsetperk(var_1);
    }
  }

  _setperk(var_0);
}

_id_E187(var_0) {
  _unsetperk(var_0);
}

_setperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    self.perks[var_0] = 1;
  } else {
    self.perks[var_0]++;
  }

  if(self.perks[var_0] == 1 && !isDefined(self.perksblocked[var_0])) {
    _id_13D2(var_0);
  }
}

_id_13D2(var_0) {
  var_1 = level.perksetfuncs[var_0];

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_unsetperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    return;
  }
  self.perks[var_0]--;

  if(self.perks[var_0] == 0) {
    if(!isDefined(self.perksblocked[var_0])) {
      _id_1431(var_0);
    }

    self.perks[var_0] = undefined;
  }
}

_id_1431(var_0) {
  if(isDefined(level.perkunsetfuncs[var_0])) {
    self thread[[level.perkunsetfuncs[var_0]]]();
  }
}

_hasperk(var_0) {
  return isDefined(self.perks) && isDefined(self.perks[var_0]);
}

_clearperks() {
  foreach(var_2, var_1 in self.perks) {
    if(_id_12F9(var_2)) {
      continue;
    }
    if(isDefined(level.perkunsetfuncs[var_2])) {
      self[[level.perkunsetfuncs[var_2]]]();
    }

    self.perks[var_2] = undefined;
  }

  self.perksblocked = [];
}

_id_11AB() {
  foreach(var_2, var_1 in self.perks) {
    if(!_id_12F9(var_2)) {
      continue;
    }
    if(isDefined(level.perkunsetfuncs[var_2])) {
      self[[level.perkunsetfuncs[var_2]]]();
    }

    self.perks[var_2] = undefined;
  }

  self.perksblocked = [];
}

_id_12F9(var_0) {
  if(scripts\engine\utility::array_contains(level._id_12F79, var_0)) {
    return 1;
  }

  return 0;
}

_id_8059(var_0) {
  return tablelookup("sp/perkTable.csv", 1, var_0, 3);
}

_id_805B(var_0) {
  return tablelookupistring("sp/perkTable.csv", 1, var_0, 2);
}

blockperkfunction(var_0) {
  if(!isDefined(self.perksblocked[var_0])) {
    self.perksblocked[var_0] = 1;
  } else {
    self.perksblocked[var_0]++;
  }

  if(self.perksblocked[var_0] == 1 && _hasperk(var_0)) {
    _id_1431(var_0);
  }
}

unblockperkfunction(var_0) {
  self.perksblocked[var_0]--;

  if(self.perksblocked[var_0] == 0) {
    self.perksblocked[var_0] = undefined;

    if(_hasperk(var_0)) {
      _id_13D2(var_0);
    }
  }
}
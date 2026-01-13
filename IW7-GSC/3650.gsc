/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3650.gsc
*********************************************/

init() {
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.player.perks = [];
  level.player.perksblocked = [];
  level.var_12F75 = [];
  level.var_12F79 = [];
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
  level.perksetfuncs["specialty_fastreload"] = ::lib_0E41::func_F701;
  level.perkunsetfuncs["specialty_fastreload"] = ::lib_0E41::func_12CBC;
  level.perksetfuncs["specialty_steadyaim"] = ::lib_0E41::setstaticuicircles;
  level.perkunsetfuncs["specialty_steadyaim"] = ::lib_0E41::unsetspotter;
  level.perksetfuncs["specialty_quickswap"] = ::lib_0E41::setquickswap;
  level.perkunsetfuncs["specialty_quickswap"] = ::lib_0E41::unsetquickswap;
  level.perksetfuncs["specialty_focus"] = ::lib_0E41::func_F712;
  level.perkunsetfuncs["specialty_focus"] = ::lib_0E41::func_12CBE;
  level.perksetfuncs["specialty_quickdraw"] = ::lib_0E41::func_F80F;
  level.perkunsetfuncs["specialty_quickdraw"] = ::lib_0E41::func_12D12;
  level.perksetfuncs["specialty_agility"] = ::lib_0E41::func_F636;
  level.perkunsetfuncs["specialty_agility"] = ::lib_0E41::func_12C6F;
  level.perksetfuncs["specialty_extraequipment"] = ::lib_0E41::setextraequipment;
  level.perkunsetfuncs["specialty_extraequipment"] = ::lib_0E41::unsetextraequipment;
  level.perksetfuncs["specialty_blastshield"] = ::lib_0E41::setblastshield;
  level.perkunsetfuncs["specialty_blastshield"] = ::lib_0E41::unsetblastshield;
  level.perksetfuncs["specialty_fastregen"] = ::lib_0E41::func_F700;
  level.perkunsetfuncs["specialty_fastregen"] = ::lib_0E41::func_12CBB;
  level.perksetfuncs["specialty_slasher"] = ::lib_0E41::func_F849;
  level.var_12F75["specialty_slasher"] = "specialty_shocker";
  level.perkunsetfuncs["specialty_slasher"] = ::lib_0E41::func_12D2F;
  level.perksetfuncs["specialty_shocker"] = ::lib_0E41::func_F83E;
  level.var_12F75["specialty_shocker"] = "specialty_slasher";
  level.perkunsetfuncs["specialty_shocker"] = ::lib_0E41::func_12D2A;
  level.perksetfuncs["upgrade_frag_1"] = ::lib_0E41::func_FAB8;
  level.perkunsetfuncs["upgrade_frag_1"] = ::lib_0E41::func_12D5A;
  level.var_12F79[level.var_12F79.size] = "upgrade_frag_1";
  level.perksetfuncs["upgrade_frag_2"] = ::lib_0E41::func_FAB9;
  level.perkunsetfuncs["upgrade_frag_2"] = ::lib_0E41::func_12D5B;
  level.var_12F75["upgrade_frag_2"] = "upgrade_frag_1";
  level.var_12F79[level.var_12F79.size] = "upgrade_frag_2";
  level.perksetfuncs["upgrade_shock_1"] = ::lib_0E41::func_FAC0;
  level.perkunsetfuncs["upgrade_shock_1"] = ::lib_0E41::func_12D62;
  level.var_12F79[level.var_12F79.size] = "upgrade_shock_1";
  level.perksetfuncs["upgrade_shock_2"] = ::lib_0E41::func_FAC1;
  level.perkunsetfuncs["upgrade_shock_2"] = ::lib_0E41::func_12D63;
  level.var_12F75["upgrade_shock_2"] = "upgrade_shock_1";
  level.var_12F79[level.var_12F79.size] = "upgrade_shock_2";
  level.perksetfuncs["upgrade_antigrav_1"] = ::lib_0E41::func_FAB2;
  level.perkunsetfuncs["upgrade_antigrav_1"] = ::lib_0E41::func_12D54;
  level.var_12F79[level.var_12F79.size] = "upgrade_antigrav_1";
  level.perksetfuncs["upgrade_antigrav_2"] = ::lib_0E41::func_FAB3;
  level.perkunsetfuncs["upgrade_antigrav_2"] = ::lib_0E41::func_12D55;
  level.var_12F75["upgrade_antigrav_2"] = "upgrade_antigrav_1";
  level.var_12F79[level.var_12F79.size] = "upgrade_antigrav_2";
  level.perksetfuncs["upgrade_seeker_1"] = ::lib_0E41::func_FABC;
  level.perkunsetfuncs["upgrade_seeker_1"] = ::lib_0E41::func_12D5E;
  level.var_12F79[level.var_12F79.size] = "upgrade_seeker_1";
  level.perksetfuncs["upgrade_seeker_2"] = ::lib_0E41::func_FABD;
  level.perkunsetfuncs["upgrade_seeker_2"] = ::lib_0E41::func_12D5F;
  level.var_12F75["upgrade_seeker_2"] = "upgrade_seeker_1";
  level.var_12F79[level.var_12F79.size] = "upgrade_seeker_2";
  level.perksetfuncs["upgrade_hack_1"] = ::lib_0E41::func_FABA;
  level.perkunsetfuncs["upgrade_hack_1"] = ::lib_0E41::func_12D5C;
  level.var_12F79[level.var_12F79.size] = "upgrade_hack_1";
  level.perksetfuncs["upgrade_shield_1"] = ::lib_0E41::func_FABE;
  level.perkunsetfuncs["upgrade_shield_1"] = ::lib_0E41::func_12D60;
  level.var_12F79[level.var_12F79.size] = "upgrade_shield_1";
  level.perksetfuncs["upgrade_drone_1"] = ::lib_0E41::func_FAB6;
  level.perkunsetfuncs["upgrade_drone_1"] = ::lib_0E41::func_12D58;
  level.var_12F79[level.var_12F79.size] = "upgrade_drone_1";
  level.perksetfuncs["upgrade_cover_1"] = ::lib_0E41::func_FAB4;
  level.perkunsetfuncs["upgrade_cover_1"] = ::lib_0E41::func_12D56;
  level.var_12F79[level.var_12F79.size] = "upgrade_cover_1";
  func_98B0();
}

func_98B0() {}

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

takeallweapons(var_0) {
  foreach(var_2 in var_0) {
    switchtoweaponimmediate(var_2);
  }
}

switchtoweaponimmediate(var_0) {
  if(isDefined(level.var_12F75[var_0])) {
    var_1 = level.var_12F75[var_0];
    while(_hasperk(var_1)) {
      _unsetperk(var_1);
    }
  }

  _setperk(var_0);
}

func_E187(var_0) {
  _unsetperk(var_0);
}

_setperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    self.perks[var_0] = 1;
  } else {
    self.perks[var_0]++;
  }

  if(self.perks[var_0] == 1 && !isDefined(self.perksblocked[var_0])) {
    func_13D2(var_0);
  }
}

func_13D2(var_0) {
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
      func_1431(var_0);
    }

    self.perks[var_0] = undefined;
  }
}

func_1431(var_0) {
  if(isDefined(level.perkunsetfuncs[var_0])) {
    self thread[[level.perkunsetfuncs[var_0]]]();
  }
}

_hasperk(var_0) {
  return isDefined(self.perks) && isDefined(self.perks[var_0]);
}

_clearperks() {
  foreach(var_2, var_1 in self.perks) {
    if(func_12F9(var_2)) {
      continue;
    }

    if(isDefined(level.perkunsetfuncs[var_2])) {
      self[[level.perkunsetfuncs[var_2]]]();
    }

    self.perks[var_2] = undefined;
  }

  self.perksblocked = [];
}

func_11AB() {
  foreach(var_2, var_1 in self.perks) {
    if(!func_12F9(var_2)) {
      continue;
    }

    if(isDefined(level.perkunsetfuncs[var_2])) {
      self[[level.perkunsetfuncs[var_2]]]();
    }

    self.perks[var_2] = undefined;
  }

  self.perksblocked = [];
}

func_12F9(var_0) {
  if(scripts\engine\utility::array_contains(level.var_12F79, var_0)) {
    return 1;
  }

  return 0;
}

cameraunlink(var_0) {
  return tablelookup("sp\perkTable.csv", 1, var_0, 3);
}

cancelmantle(var_0) {
  return tablelookupistring("sp\perkTable.csv", 1, var_0, 2);
}

blockperkfunction(var_0) {
  if(!isDefined(self.perksblocked[var_0])) {
    self.perksblocked[var_0] = 1;
  } else {
    self.perksblocked[var_0]++;
  }

  if(self.perksblocked[var_0] == 1 && _hasperk(var_0)) {
    func_1431(var_0);
  }
}

unblockperkfunction(var_0) {
  self.perksblocked[var_0]--;
  if(self.perksblocked[var_0] == 0) {
    self.perksblocked[var_0] = undefined;
    if(_hasperk(var_0)) {
      func_13D2(var_0);
    }
  }
}
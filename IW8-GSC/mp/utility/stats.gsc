/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\stats.gsc
***********************************************/

initpersstat(var_0) {
  if(!isDefined(self.pers[var_0]))
    self.pers[var_0] = 0;
}

getpersstat(var_0) {
  return self.pers[var_0];
}

incpersstat(var_0, var_1) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }
  if(isagent(self) || scripts\mp\utility\entity::isturret(self)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(self.watchvehicleingas[var_0]))
    self.watchvehicleingas[var_0] = self.watchvehicleingas[var_0] + var_1;

  objective_sethideformlgspectator(self, var_0, var_1);
}

timedrun_finishlinevfx(var_0) {
  if(!isDefined(self.watchvehicleingas[var_0]))
    self.watchvehicleingas[var_0] = 0;
}

setextrascore0(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && (level.disable_super_in_turret.name == "_encstr_A254085207A6B7334B5A" || level.disable_super_in_turret.name == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || level.disable_super_in_turret.name == "_encstr_AD300C932B4C969CD1D0AF911346" || level.disable_super_in_turret.name == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95")) {
    return;
  }
  if(var_0 >= 65000)
    var_0 = 65000;

  self.extrascore0 = var_0;
  self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"] = var_0;
}

_id_1314C(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }
  if(var_0 >= 65000)
    var_0 = 65000;

  self.packarenaomnvardata = var_0;
  self.pers["_encstr_AA220C89385CB89F03B79FADC71F"] = var_0;
}

setextrascore1(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }
  if(var_0 >= 255)
    var_0 = 255;

  self.extrascore1 = var_0;
  self.pers["_encstr_84220CB23C8E9CC2CD36DB27AC4C"] = var_0;
}

setextrascore2(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }
  if(var_0 >= 65000)
    var_0 = 65000;

  self.extrascore2 = var_0;
  self.pers["_encstr_AD220CACE18E93C2B98DEDE4B223"] = var_0;
}

setextrascore3(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }
  if(var_0 >= 65000)
    var_0 = 65000;

  self.extrascore3 = var_0;
  self.pers["_encstr_85220C92C329223FDB1EC7D225EB"] = var_0;
}

loadout_updateclassdefault_weaponsheadless() {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"]))
    return 1;

  if(istrue(level.disablestattracking))
    return 1;

  return 0;
}

getplayerdataloadoutgroup() {
  if(isgamebattlematch())
    return "_encstr_A6DC101B53ABFB7E88FB542F8B7085BF4DEB";

  var_0 = istrue(level._id_14434) && getdvarint("_encstr_A7910B319C629AF44A9A05A2A9");

  if(level.rankedmatch && !scripts\mp\utility\game::isanymlgmatch()) {
    if(var_0)
      return "_encstr_99991143D208F9723A4313CBAFD71A3FE8BBFA";
    else
      return "_encstr_B8A30FC8463D282A65B07FF929C89DD3F0";
  }

  if(var_0)
    return "_encstr_8B5F12DD9E38932DEC0BE8951BDE2C8CBDEA3AB9";
  else
    return "_encstr_A6DC101B53ABFB7E88FB542F8B7085BF4DEB";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

canrecordcombatrecordstats() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163")
    return 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 0;

  return level.rankedmatch && !istrue(level.ignorescoring);
}

getstreakrecordtype(var_0) {
  if(isenumvaluevalid("_encstr_8C07031599", "_encstr_9ABE1BAC7F5C689FF27787979B0ADED0F2D7B1C06AA4E8CD98F3F38BA7", var_0))
    return "_encstr_97C417B1ED5B80538DA9B8D093E72F5B2B954FBA73E369B1B2";

  if(isenumvaluevalid("_encstr_8C07031599", "_encstr_B2D31C69F367A3BDF8992BE35793C7678D8B82F298AECB76E0CB04ED7B20", var_0))
    return "_encstr_81671883BB2BDF9842AC770FAF2A802643A3D949E20F15101B83";

  return undefined;
}
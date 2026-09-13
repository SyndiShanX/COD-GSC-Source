/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\throwstar.gsc
*************************************************/

_id_12D7CA3FF609CABA() {
  level._id_A96456706E7C0324 = getdvarfloat("dvar_0378F4895FD171E8", 12);
  level._id_474A06DE6DB75B6A = getdvarfloat("dvar_085766DCC125EDAC", 20);
  level._effect["thorwstar_impact_stick"] = loadfx("vfx/iw9/core/equipment/throwstar/vfx_throwstar_impact_stick.vfx");
  level._effect["thorwstar_impact_reflect"] = loadfx("vfx/iw9/core/equipment/throwstar/vfx_throwstar_impact_reflect.vfx");
  level._effect["thorwstar_impact_flesh"] = loadfx("vfx/iw9/core/equipment/throwstar/vfx_throwstar_impact_flesh.vfx");
  level._effect["thorwstar_impact_water"] = loadfx("vfx/iw9/core/equipment/throwstar/vfx_throwstar_impact_water.vfx");
  setdvarifuninitialized("dvar_E34DBB045AD712E7", 0);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("throwstar", "init");
}

_id_E7715FFB329C1B40(equipmentref, _id_CBB2B3D05E48BD27, variantid) {
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("throwstar", "onGive");
}

_id_092E126D1A5D3FB2(equipmentref, _id_CBB2B3D05E48BD27) {
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("throwstar", "onTake");
}

_id_709581D70EBB07CD(grenade) {
  grenade endon("death");
  grenade._id_AB13877362519A4F = scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5();
  grenade thread _id_A4294DFCD472070B();
  grenade makeunusable();
  _id_88C9497E3683F50D = grenade.angles;
  grenade endon("throwstar_cancel_stuck_wait");
  grenade waittill("missile_stuck", stuckto, _id_16A48D7056E5C472, surfacetype, _id_AA416133E3CF5BF5, position, _id_3E293ABD063AA9F5);

  if(getdvarint("dvar_E34DBB045AD712E7")) {
    grenade setscriptablepartstate("showLocation", "active", 0);
    grenade _id_1F6C16AC84EF5C16();
  } else {
    thread _id_F206558A684B471A(stuckto, _id_16A48D7056E5C472, _id_88C9497E3683F50D, surfacetype, _id_AA416133E3CF5BF5, position, _id_3E293ABD063AA9F5);
    grenade delete();
  }
}

_id_1F6C16AC84EF5C16() {
  self makeunusable();
  trigger = spawn("trigger_radius", self.origin, 0, 64, 64);
  trigger enablelinkTo();
  trigger linkTo(self);
  self._id_6F09A59AEE157204 = trigger;

  if(!isDefined(level._id_1E54D8B3480E52FC))
    level._id_1E54D8B3480E52FC = [];

  _id_5C397C9CF7A06802 = [self];

  foreach(_id_04E61FB962583D67 in level._id_1E54D8B3480E52FC) {
    if(_id_5C397C9CF7A06802.size >= level._id_A96456706E7C0324) {
      if(isDefined(_id_04E61FB962583D67))
        _id_04E61FB962583D67 _id_8485894AF3536C3B();

      continue;
    }

    if(isDefined(_id_04E61FB962583D67))
      _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_04E61FB962583D67;
  }

  level._id_1E54D8B3480E52FC = _id_5C397C9CF7A06802;
  thread _id_F54C5164B830FFFB();
  thread _id_FF1F6E7881A17EA6();
}

_id_F54C5164B830FFFB() {
  self endon("death");
  _id_8B121DD10A442DD2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("inventory", "isBackpackInventoryEnabled"))
    _id_8B121DD10A442DD2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("inventory", "isBackpackInventoryEnabled")]]();

  for(;;) {
    self._id_6F09A59AEE157204 waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.owner) && self.owner != player) {
      continue;
    }
    if(!player hasweapon(self.weapon_object) && !_id_8B121DD10A442DD2) {
      continue;
    }
    if(player _id_10769923B31F128C(self.equipmentref))
      thread _id_8485894AF3536C3B();
  }
}

_id_10769923B31F128C(equipmentref) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwstar", "tryToPickup")) {
    _id_985A9A19392D5FA7 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwstar", "tryToPickup")]](equipmentref);
    return _id_985A9A19392D5FA7;
  }

  return 1;
}

_id_8485894AF3536C3B() {
  if(isDefined(self._id_6F09A59AEE157204))
    self._id_6F09A59AEE157204 delete();

  self delete();
}

_id_FF1F6E7881A17EA6() {
  self endon("death");
  wait(level._id_474A06DE6DB75B6A);
  thread _id_8485894AF3536C3B();
}

_id_A4294DFCD472070B() {
  self endon("explode");
  self endon("death");
  self endon("missile_stuck");

  if(istrue(self._id_8DB81EA21F0B9283))
    return 0;

  self waittill("missile_water_impact", _id_7842E9E94384087B);
  self._id_AB13877362519A4F = 1;
  thread _id_0C759DE2F9501126();
}

_id_0C759DE2F9501126() {
  level endon("game_end");
  self endon("missile_stuck");
  owner = self.owner;
  _id_AE73793772B8710A = self.origin;
  _id_0F59B0D71AB63AF6 = self.weapon_object;
  _id_88C9497E3683F50D = self.angles;
  _id_C6A9083AC855BC53 = "throwstar_mp_inert";
  self waittill("missile_change_to_dud", _id_69BC556674E879A4);
  owner notify("throwstar_cancel_stuck_wait");

  if(getdvarint("dvar_E34DBB045AD712E7")) {
    if(isDefined(_id_69BC556674E879A4)) {
      _id_AE73793772B8710A = _id_69BC556674E879A4;
      _id_63C5BB28E243C08F = owner launchgrenade(_id_C6A9083AC855BC53, _id_AE73793772B8710A, (0, 0, 0), undefined, undefined);
      _id_63C5BB28E243C08F._id_8DB81EA21F0B9283 = 1;
      _id_63C5BB28E243C08F._id_0F59B0D71AB63AF6 = _id_0F59B0D71AB63AF6;
      _id_63C5BB28E243C08F.angles = _id_88C9497E3683F50D;
    }
  } else if(isDefined(_id_69BC556674E879A4)) {
    _id_AE73793772B8710A = _id_69BC556674E879A4;
    _id_54E5D17BDA41F63A(_id_AE73793772B8710A, _id_88C9497E3683F50D);
  }
}

_id_DB4BBCFE23F19148(einflictor, victim, idamage, partname) {
  if(scripts\cp_mp\utility\damage_utility::_id_B656251147D7D40B(partname)) {
    idamage = 250;

    if(isDefined(victim))
      victim._id_F83C15ACB64C91B7 = 1;
  } else if(isDefined(victim))
    victim._id_F83C15ACB64C91B7 = undefined;

  if(isDefined(einflictor._id_AB13877362519A4F) && istrue(einflictor._id_AB13877362519A4F))
    idamage = _id_CE1D250379DB9655(victim);

  if(isDefined(victim) && isDefined(victim.inlaststand) && istrue(victim.inlaststand))
    idamage = victim.health;

  return idamage;
}

_id_FC924820627E1C55() {
  return 130;
}

_id_CE1D250379DB9655(victim) {
  _id_81BD886BA4CAE915 = 45;
  _id_00451F4DC5070C2A = victim.health - 45 <= 0;

  if(_id_00451F4DC5070C2A)
    _id_81BD886BA4CAE915 = int(max(victim.health - 1, 1));

  return _id_81BD886BA4CAE915;
}

_id_F206558A684B471A(stuckto, _id_16A48D7056E5C472, _id_5BF254E86BE4A055, surfacetype, _id_AA416133E3CF5BF5, position, _id_3E293ABD063AA9F5) {
  if(_id_81814781949469B5(stuckto))
    _id_24B586E36BF90639(_id_5BF254E86BE4A055, position, _id_3E293ABD063AA9F5);
  else if(_id_9453E7A6466C7E47(stuckto, _id_16A48D7056E5C472, surfacetype))
    _id_D621DBDC62927DB7(_id_5BF254E86BE4A055, _id_AA416133E3CF5BF5, position);
  else if(_id_100E72CA4FF67C80(position))
    _id_54E5D17BDA41F63A(position, _id_5BF254E86BE4A055);
  else
    _id_083388FBA79E562C(_id_5BF254E86BE4A055, _id_AA416133E3CF5BF5, position, _id_3E293ABD063AA9F5);
}

_id_81814781949469B5(stuckto) {
  if(isDefined(stuckto) && (isPlayer(stuckto) || isbot(stuckto) || isagent(stuckto)))
    return 1;
  else
    return 0;
}

_id_9453E7A6466C7E47(stuckto, _id_16A48D7056E5C472, surfacetype) {
  if(isDefined(stuckto) || isDefined(_id_16A48D7056E5C472))
    return 0;

  if(!isDefined(surfacetype))
    return 0;

  switch (surfacetype) {
    case "drywall":
    case "wood_floor":
    case "foliage_wet":
    case "carpet_solid":
    case "wood_Solid":
    case "flesh":
    case "snow":
    case "paper":
    case "slush":
    case "cloth":
    case "bark":
      return 1;
    default:
      return 0;
  }
}

_id_100E72CA4FF67C80(position) {
  if(scripts\engine\utility::_id_06C71C72547BB931(position))
    return 1;

  return 0;
}

_id_24B586E36BF90639(_id_5BF254E86BE4A055, position, _id_3E293ABD063AA9F5) {
  playFX(level._effect["thorwstar_impact_flesh"], position, _id_3E293ABD063AA9F5, anglestoup(_id_5BF254E86BE4A055));
}

_id_D621DBDC62927DB7(_id_5BF254E86BE4A055, _id_AA416133E3CF5BF5, position) {
  forward = vectorNormalize(_id_AA416133E3CF5BF5);
  playFX(level._effect["thorwstar_impact_stick"], position, forward, anglestoup(_id_5BF254E86BE4A055));
}

_id_54E5D17BDA41F63A(position, _id_5BF254E86BE4A055) {
  playFX(level._effect["thorwstar_impact_water"], position, anglesToForward(_id_5BF254E86BE4A055), anglestoup(_id_5BF254E86BE4A055));
}

_id_083388FBA79E562C(_id_5BF254E86BE4A055, _id_AA416133E3CF5BF5, position, _id_3E293ABD063AA9F5) {
  _id_507444FDCF69DA44 = scripts\engine\math::vector_reflect(_id_AA416133E3CF5BF5, _id_3E293ABD063AA9F5);
  playFX(level._effect["thorwstar_impact_reflect"], position, _id_507444FDCF69DA44, anglestoup(_id_5BF254E86BE4A055));
}
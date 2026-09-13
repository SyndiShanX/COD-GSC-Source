/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_268c558ddb2267aa.gsc
***********************************************/

_id_41C4A42AE28C7E16() {
  if(!isDefined(level._id_B35FC6D4A1B9424F)) {
    return;
  }
  if(!isDefined(level._id_B35FC6D4A1B9424F.powers)) {
    return;
  }
  level._id_B35FC6D4A1B9424F.powers["melee"] = _id_EA71E04A720A17AE();
}

_id_EA71E04A720A17AE() {
  config = spawnStruct();
  config.maxhealth = 1000;
  config.startinghealth = config.maxhealth;
  config.movespeedscalar = getdvarfloat("dvar_8E4A9B19254B5834", 0.5);
  config.maxvehicledamagedivisor = 3;
  config.classstruct = _id_0FB01D574364A561();
  config._id_E83263899DAAA528 = ::_id_D3796B128EC7A952;
  config.perks = ["specialty_huntmaster", "specialty_tac_resist", "specialty_hustle", "specialty_eod"];
  return config;
}

_id_8DB15A70B73B907E() {
  return level._id_B35FC6D4A1B9424F.powers["melee"];
}

_id_D3796B128EC7A952(isactivated) {
  if(isactivated) {
    _id_6944DA8624CCDF1D = ["ads", "weapon_switch", "weapon_pickup", "weapon_switch_clip", "reload"];
    _id_3B64EB40368C1450::_id_59C053B89257BC95("melee_superpower", _id_6944DA8624CCDF1D, 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("melee_superpower");
}

_id_C54F7DA664700B4B() {
  self._id_2BB368ACF8B4DF7D = 1;
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
  _id_912CD62CF459E05C = _id_8DB15A70B73B907E();
  _id_2E37BFD92800E030 = spawnStruct();
  _id_2E37BFD92800E030.config = _id_912CD62CF459E05C;
  _id_2E37BFD92800E030.prevhealth = self.health;
  _id_2E37BFD92800E030.maxhealth = self.maxhealth;
  _id_2E37BFD92800E030.prevspeedscale = scripts\engine\utility::ter_op(isDefined(self.playerstreakspeedscale), self.playerstreakspeedscale, 0);
  _id_2E37BFD92800E030.maskomnvar = "ui_gas_mask_juggernaut";
  self.maxhealth = _id_912CD62CF459E05C.maxhealth;
  self.health = _id_912CD62CF459E05C.startinghealth;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(isDefined(level.clearbrinventory))
    self[[level.clearbrinventory]]();

  self.lastdroppableweaponobj = undefined;

  if(isDefined(_id_912CD62CF459E05C.classstruct)) {
    _id_2E37BFD92800E030.prevclass = self.lastclass;
    _id_2E37BFD92800E030.prevclassstruct = self.classstruct;
    scripts\mp\class::loadout_updateclass(_id_912CD62CF459E05C.classstruct, "superpower");
    scripts\mp\class::preloadandqueueclassstruct(_id_912CD62CF459E05C.classstruct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "superpower", 0, 1);
  }

  foreach(perk in _id_912CD62CF459E05C.perks)
  scripts\mp\utility\perk::giveperk(perk);

  self[[_id_912CD62CF459E05C._id_E83263899DAAA528]](1);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  self.playerstreakspeedscale = _id_912CD62CF459E05C.movespeedscalar;
  scripts\mp\weapons::updatemovespeedscale();
  self._id_0EEEDA506D0A854E = _id_2E37BFD92800E030;
  _id_D0D55FBCCB850211();
  scripts\cp_mp\utility\killstreak_utility::_id_3F55C1FB553A4775(self);
  self notify("tempV_start", "melee");
  thread _id_3A82A23975071040();
  thread _id_4A4634FD5341FAA5();
  thread _id_EBBDB959C319DBF4();
  thread _id_4BDE88943FE1ED4A(self._id_0EEEDA506D0A854E);
  _id_6A5D3BF7A5B7064A::onexitdeathsdoor(1);
}

_id_0FB01D574364A561() {
  classstruct = scripts\mp\class::loadout_getclassstruct();
  classstruct.loadoutarchetype = "archetype_assault";
  classstruct.loadoutprimary = "iw9_me_superfists_mp";
  classstruct.loadoutsecondary = "none";
  classstruct.loadoutequipmentprimary = "equip_throwing_knife";
  return classstruct;
}

_id_3A82A23975071040() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  _id_09C66ADBB62A5EF8();
}

_id_4A4634FD5341FAA5() {
  self endon("disconnect");
  self endon("tempV_meleeEnd");
  level waittill("game_ended");
  self.maxhealth = self._id_0EEEDA506D0A854E.prevmaxhealth;
  self.health = self._id_0EEEDA506D0A854E.prevhealth;
  _id_09C66ADBB62A5EF8();
}

_id_EBBDB959C319DBF4() {
  level endon("game_ended");
  self endon("tempV_meleeEnd");
  _id_0EEEDA506D0A854E = self._id_0EEEDA506D0A854E;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = _id_0EEEDA506D0A854E.prevmaxhealth;
    self.health = _id_0EEEDA506D0A854E.prevhealth;
  }
}

_id_D0D55FBCCB850211() {
  self notify("tempV_melee_mask_on");
  _id_0EEEDA506D0A854E = self._id_0EEEDA506D0A854E;

  if(!isDefined(self._id_FFA2B1EE380F2EA4) && !isDefined(self._id_F7DD37E04DE8FF0E)) {
    self._id_FFA2B1EE380F2EA4 = "mask_on";
    self._id_F7DD37E04DE8FF0E = 1;
  }

  self setclientomnvar("ui_assault_suit_on", 0);
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self._id_FFA2B1EE380F2EA4);
  self setclientomnvar(_id_0EEEDA506D0A854E.maskomnvar, self._id_F7DD37E04DE8FF0E);
}

_id_1210F1BC7A0D8940(_id_0EEEDA506D0A854E, _id_A2C3DD1BE38A2035) {
  self notify("tempV_melee_mask_off");

  if(!istrue(_id_A2C3DD1BE38A2035)) {
    self._id_FFA2B1EE380F2EA4 = undefined;
    self._id_F7DD37E04DE8FF0E = undefined;
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  self setclientomnvar(_id_0EEEDA506D0A854E.maskomnvar, 0);
}

_id_09C66ADBB62A5EF8() {
  if(!isDefined(self)) {
    return;
  }
  self notify("tempV_end");
  _id_0EEEDA506D0A854E = self._id_0EEEDA506D0A854E;
  _id_912CD62CF459E05C = _id_0EEEDA506D0A854E.config;
  self.musicplaying = undefined;
  self._id_0A23031C04DF01BF = undefined;
  self._id_59651A2893429638 = undefined;
  _id_1210F1BC7A0D8940(self._id_0EEEDA506D0A854E);
  self[[_id_912CD62CF459E05C._id_E83263899DAAA528]](1);
  scripts\cp_mp\utility\killstreak_utility::_id_17576A4CDCD447A7(self);

  if(scripts\mp\utility\player::isreallyalive(self)) {
    self.maxhealth = _id_0EEEDA506D0A854E.prevmaxhealth;
    self.health = _id_0EEEDA506D0A854E.prevhealth;
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

    if(isDefined(_id_912CD62CF459E05C.classstruct)) {
      scripts\mp\class::respawnitems_assignrespawnitems(_id_0EEEDA506D0A854E.respawnitems);
      scripts\mp\class::giveloadout(self.team, _id_0EEEDA506D0A854E.prevclass, 0, 1, 1);
    }

    foreach(perk, _id_97282C14346A7FCF in _id_912CD62CF459E05C.perks)
    scripts\mp\utility\perk::removeperk(perk);
  }

  self.playerstreakspeedscale = _id_0EEEDA506D0A854E.prevspeedscale;
  scripts\mp\weapons::updatemovespeedscale();
  self._id_0EEEDA506D0A854E = undefined;
  self._id_2BB368ACF8B4DF7D = undefined;
}

_id_4BDE88943FE1ED4A(_id_0EEEDA506D0A854E) {
  self endon("juggernaut_end");
  self endon("death or disconnect");
  level endon("game_ended");
  startinghealth = self.health;
  _id_4EB5162696BAFF69 = startinghealth - startinghealth * 0.1;
  _id_5C8E464293ED834C = startinghealth - startinghealth * 0.35;
  _id_EED2946CC87372BB = startinghealth - startinghealth * 0.6;
  _id_1F9CEBCA13994806 = startinghealth - startinghealth * 0.85;
  _id_654EBA19046746E8 = 1;
  _id_EA0A3076FB747A79 = _id_654EBA19046746E8;
  _id_4F287978D27B5156 = "mask_on";

  for(;;) {
    scripts\engine\utility::waittill_any_2("damage", "jugg_health_regen");

    if(self.health <= _id_1F9CEBCA13994806) {
      _id_4F287978D27B5156 = "mask_damage_critical";
      _id_654EBA19046746E8 = 5;
    } else if(self.health <= _id_EED2946CC87372BB) {
      _id_4F287978D27B5156 = "mask_damage_high";
      _id_654EBA19046746E8 = 4;
    } else if(self.health <= _id_5C8E464293ED834C) {
      _id_4F287978D27B5156 = "mask_damage_med";
      _id_654EBA19046746E8 = 3;
    } else if(self.health <= _id_4EB5162696BAFF69) {
      _id_4F287978D27B5156 = "mask_damage_low";
      _id_654EBA19046746E8 = 2;
    } else {
      _id_4F287978D27B5156 = "mask_on";
      _id_654EBA19046746E8 = 1;
    }

    if(_id_EA0A3076FB747A79 != _id_654EBA19046746E8) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", _id_4F287978D27B5156);
      self setclientomnvar(_id_0EEEDA506D0A854E.maskomnvar, _id_654EBA19046746E8);
      _id_EA0A3076FB747A79 = _id_654EBA19046746E8;
      self._id_FFA2B1EE380F2EA4 = _id_4F287978D27B5156;
      self._id_F7DD37E04DE8FF0E = _id_654EBA19046746E8;
    }
  }
}
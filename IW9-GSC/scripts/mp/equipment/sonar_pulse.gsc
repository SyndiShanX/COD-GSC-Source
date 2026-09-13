/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\sonar_pulse.gsc
************************************************/

_id_A09BD8D12B478568() {}

_id_2D117EEB564F6EA3(grenade) {
  grenade endon("death");
  self endon("disconnect");
  grenade scripts\cp_mp\ent_manager::registerspawn(1, ::_id_2564841F84F5470C);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      scripts\mp\supers::refundsuper();
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      grenade delete();
      return;
    }
  }

  grenade setscriptablepartstate("plant", "active", 0);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.issuper = 1;
  grenade.superid = level.superglobals.staticsuperdata["super_sonar_pulse"].id;
  grenade.usedcount = 0;
  grenade.deployingplayer = self;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, undefined, 1);
  _id_307667D0142F2035 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");
  scripts\mp\weapons::onequipmentplanted(grenade, "sonar_pulse_mp", ::_id_2564841F84F5470C);
  level thread scripts\mp\weapons::monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  maxhealth = scripts\engine\utility::ter_op(_id_307667D0142F2035, 100, 50);
  grenade thread scripts\mp\damage::monitordamage(maxhealth, "hitequip", ::_id_CE4C686B86693133, ::_id_87B9594A020ED3FD, 0);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_93FD2CDCD109695B);
  grenade _id_49197CD063A740EA(::_id_2564841F84F5470C);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
  }

  if(isDefined(stuckto) && isPlayer(stuckto)) {
    grenade.owner thread scripts\mp\weapons::grenadestuckto(grenade, stuckto);
    grenade thread _id_4AE3BCDC7576EBE4(stuckto);
  }

  grenade thread _id_60D095CD40221AEA();
  grenade thread _id_B562D405020E0724();
  grenade _id_4B1FCC56668622D1();
  grenade scripts\mp\supers::_id_235470B268F029CA(::_id_2564841F84F5470C);
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_sonar_pulse", 0);
}

_id_4AE3BCDC7576EBE4(_id_1E68C31B55F99759) {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  _id_1E68C31B55F99759 waittill("death_or_disconnect");
  self unlink();
}

_id_60D095CD40221AEA() {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");

  for(;;) {
    self waittill("enable_sonar");
    thread _id_6F9BE6B35F3DD478();
  }
}

_id_6F9BE6B35F3DD478() {
  self endon("death");
  self endon("destroyed");
  self endon("disable_sonar");
  level endon("game_ended");
  wait 0.5;

  for(;;) {
    _id_489BFE1C59FE7D65 = 650;
    _id_2FF0B7294CDE30F8 = 1;

    if(scripts\cp_mp\utility\game_utility::islargemap())
      _id_489BFE1C59FE7D65 = 1500;

    thread _id_10EC22D7A74CE832(_id_2FF0B7294CDE30F8);
    thread _id_0E6F69EA82CB18D6();

    if(level.teambased)
      triggerportableradarpingteam(self.origin, self.owner.team, _id_489BFE1C59FE7D65, int(_id_2FF0B7294CDE30F8 * 1000));
    else
      triggerportableradarping(self.origin, self.owner, _id_489BFE1C59FE7D65, int(_id_2FF0B7294CDE30F8 * 1000));

    wait 2;
  }
}

_id_10EC22D7A74CE832(_id_2FF0B7294CDE30F8) {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  self setscriptablepartstate("pulse", "active", 0);
  wait(min(0.1, _id_2FF0B7294CDE30F8 - 0.5));
  self setscriptablepartstate("pulse", "neutral", 0);
}

_id_0E6F69EA82CB18D6() {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  self setscriptablepartstate("anims", "open", 0);
  wait(_id_0E2AD1107CFFCF46());
  self setscriptablepartstate("anims", "close", 0);
}

#using_animtree("scriptables");

_id_0E2AD1107CFFCF46() {
  return getanimlength(%wm_sonar_pulse_ground_open);
}

_id_B562D405020E0724() {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  wait 20;
  _id_2564841F84F5470C();
}

_id_16C572662ACAAF67(player) {
  self endon("death");
  self endon("destroyed");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = scripts\engine\utility::waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }
  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  _id_3A7F0173B03F5767 = -2000.0;
  _id_8B39E5984DA1FFAF = self.origin + (0.0, 0.0, _id_3A7F0173B03F5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, _id_FBCABD62B8F66EB8);
  groundentity = traceresults["entity"];

  if(isDefined(groundentity)) {
    if(scripts\cp_mp\utility\train_utility::is_train_ent(groundentity)) {
      self.origin = self.origin + (0, 0, 1.6);
      self linkTo(groundentity);
    }
  }
}

_id_87B9594A020ED3FD(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\damage::handlemeleedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);
  scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, type);
  return _id_702BFC08FABD86CB;
}

_id_CE4C686B86693133(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }

  _id_2564841F84F5470C(data);
}

_id_2564841F84F5470C(data) {
  _id_FFE0D0BDD9BD7D44 = 0;

  if(isDefined(data) && isDefined(data.attacker)) {
    _id_FFE0D0BDD9BD7D44 = 1;
    _id_248B0FBBC5DE7E43(data.attacker);
  }

  if(isDefined(self.headiconid))
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);

  thread _id_9C91A67E3F179AFD(_id_FFE0D0BDD9BD7D44);
  self setscriptablepartstate("destroy", "active", 0);
  self notify("destroyed");
}

_id_9C91A67E3F179AFD(_id_4FAC8B8CE36E09F1) {
  self endon("death");

  if(!isDefined(self)) {}

  self.exploding = 1;
  _id_A8D0B1AFB1554B5A();

  if(isDefined(self.owner)) {
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(_id_4FAC8B8CE36E09F1));
    self.owner scripts\mp\weapons::removeequip(self);
  }

  wait 2;
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self))
    self delete();
}

_id_248B0FBBC5DE7E43(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

_id_93FD2CDCD109695B(data) {
  data.victim endon("destroyed");
  data.victim setscriptablepartstate("empd", "active", 0);
  data.victim _id_A8D0B1AFB1554B5A();
  wait 6;
  data.victim setscriptablepartstate("empd", "neutral", 0);
  data.victim _id_4B1FCC56668622D1();
}

_id_4B1FCC56668622D1() {
  if(isDefined(self.owner) && istrue(level._id_12226443217B5474)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
  }

  self notify("enable_sonar");
}

_id_A8D0B1AFB1554B5A() {
  if(isDefined(self.owner) && istrue(level._id_12226443217B5474)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap"))
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
  }

  self setscriptablepartstate("pulse", "neutral", 0);
  self notify("disable_sonar");
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}
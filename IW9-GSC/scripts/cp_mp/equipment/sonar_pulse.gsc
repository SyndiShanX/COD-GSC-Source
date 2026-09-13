/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\sonar_pulse.gsc
***************************************************/

_id_A09BD8D12B478568() {}

_id_12248061AABB5B60() {
  self endon("offhand_pullback");

  for(;;) {
    _id_237727B2372DD267 = _id_74502A9E0EF1F19C::waittill_grenade_fire();

    if(!isDefined(_id_237727B2372DD267)) {
      continue;
    }
    if(!isDefined(_id_237727B2372DD267.weapon_name)) {
      continue;
    }
    if(_id_237727B2372DD267.weapon_name != "sonar_pulse_mp") {
      continue;
    }
    self notify("portable_radar_thrown", _id_237727B2372DD267);
    return _id_237727B2372DD267;
  }
}

_id_2D117EEB564F6EA3(grenade) {
  grenade endon("death");
  self endon("disconnect");
  grenade scripts\cp_mp\ent_manager::registerspawn(1, ::_id_2564841F84F5470C);
  thread _id_74502A9E0EF1F19C::monitordisownedgrenade(self, grenade);
  grenade setscriptablepartstate("visibility", "show", 1);
  grenade waittill("missile_stuck", stuckto);
  grenade setscriptablepartstate("plant", "active", 0);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.deployingplayer = self;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  _id_74502A9E0EF1F19C::onequipmentplanted(grenade, "sonar_pulse_mp", ::_id_2564841F84F5470C);
  level thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, grenade);
  grenade thread _id_74502A9E0EF1F19C::monitordamage(50, "hitequip", ::_id_CE4C686B86693133, ::_id_87B9594A020ED3FD, 0);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_93FD2CDCD109695B);

  if(isDefined(stuckto) && isPlayer(stuckto)) {
    thread _id_74502A9E0EF1F19C::grenadestuckto(grenade, stuckto);
    grenade thread _id_4AE3BCDC7576EBE4(stuckto);
  }

  grenade thread _id_60D095CD40221AEA();
  grenade thread _id_B562D405020E0724();
  grenade _id_4B1FCC56668622D1();
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
    _id_489BFE1C59FE7D65 = 2000;
    _id_2FF0B7294CDE30F8 = 1;

    if(scripts\cp_mp\utility\game_utility::islargemap())
      _id_489BFE1C59FE7D65 = 2500;

    thread _id_10EC22D7A74CE832(_id_2FF0B7294CDE30F8);
    thread _id_0E6F69EA82CB18D6();

    if(!isDefined(level._id_FEB482868C0EE195))
      level._id_FEB482868C0EE195 = [];

    _id_D0DE4C8ED7F47A01 = getaiarrayinradius(self.origin, 2000, "axis");
    _id_3BA658FB6EE90FA0 = getentarrayinradius("drone_turret", "targetname", self.origin, 2000);
    enemies = scripts\engine\utility::array_combine(_id_D0DE4C8ED7F47A01, _id_3BA658FB6EE90FA0);
    level._id_FEB482868C0EE195 = scripts\cp\utility::array_merge(enemies, level._id_FEB482868C0EE195);
    _id_BE2203D59EE928B6 = enemies.size;
    self.owner scripts\cp\challenges_cp::_id_613A81F77B1154D0(_id_BE2203D59EE928B6);
    outlineids = [];

    foreach(enemy in enemies) {
      enemy._id_2EC3E2A60DB662FB = scripts\cp\cp_outline_utility::outlineenableforall(enemy, "snapshotgrenade", "equipment");
      outlineids[outlineids.size] = enemy._id_2EC3E2A60DB662FB;
    }

    wait 1.0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < enemies.size; _id_AC0E594AC96AA3A8++) {
      scripts\cp\cp_outline_utility::outlinedisable(outlineids[_id_AC0E594AC96AA3A8], enemies[_id_AC0E594AC96AA3A8]);
      enemies[_id_AC0E594AC96AA3A8]._id_2EC3E2A60DB662FB = undefined;
    }

    wait 1.0;
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
  _id_702BFC08FABD86CB = _id_25845ACA699D038D::handlemeleedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = _id_25845ACA699D038D::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);
  return _id_702BFC08FABD86CB;
}

_id_CE4C686B86693133(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)))
    attacker notify("destroyed_equipment");

  _id_2564841F84F5470C(data);
}

_id_2564841F84F5470C(data) {
  _id_FFE0D0BDD9BD7D44 = 0;

  if(isDefined(data) && isDefined(data.attacker)) {
    _id_FFE0D0BDD9BD7D44 = 1;
    _id_248B0FBBC5DE7E43(data.attacker);
  }

  if(isDefined(self.headiconid)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
    self.headiconid = undefined;
  }

  thread _id_9C91A67E3F179AFD(_id_FFE0D0BDD9BD7D44);
  self setscriptablepartstate("destroy", "active", 0);
  self notify("destroyed");
}

_id_9C91A67E3F179AFD(_id_4FAC8B8CE36E09F1) {
  self endon("death");

  if(!isDefined(self)) {}

  if(isDefined(level._id_FEB482868C0EE195)) {
    foreach(enemy in level._id_FEB482868C0EE195) {
      if(isDefined(enemy._id_2EC3E2A60DB662FB))
        scripts\cp\cp_outline_utility::outlinedisable(enemy._id_2EC3E2A60DB662FB, enemy);
    }

    level._id_FEB482868C0EE195 = undefined;
  }

  self.exploding = 1;

  if(isDefined(self.owner))
    self.owner scripts\cp_mp\challenges::_id_BD59AA7E8CECE1AB("super_sonar_pulse", self.usedcount);

  wait 2;
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self))
    self delete();
}

_id_248B0FBBC5DE7E43(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)))
    attacker notify("destroyed_equipment");
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
  self notify("enable_sonar");
}

_id_A8D0B1AFB1554B5A() {
  self setscriptablepartstate("pulse", "neutral", 0);
  self notify("disable_sonar");
}
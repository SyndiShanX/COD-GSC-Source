/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\deployed_decoy.gsc
***************************************************/

_id_35F02578B0C90838() {
  if(istrue(game["isLaunchChunk"])) {
    return;
  }
  minetriggerdata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_deployed_decoy", 1);
  minetriggerdata.triggercallback = ::_id_81D957F621CB0552;
  level.superglobals.staticsuperdata["super_deployed_decoy"]._id_F6604EEBABCAC6C2 = ::_id_F4231EED765CE56C;
}

_id_752B8EC64BC01517() {
  self notify("deployedDecoy_unset");

  if(isDefined(self._id_7F0AD61B396C9477)) {
    foreach(_id_A335666A563C40C0 in self._id_7F0AD61B396C9477)
    _id_A335666A563C40C0 thread _id_183A7478C53FD2F2();
  }

  _id_46FF5657C998DCE8();
}

_id_ABA5CD3449E22124(_id_E036BEB70DA584EC) {
  if(_id_E036BEB70DA584EC)
    scripts\mp\supers::_id_7203E7AA96FF0BA9(38);
  else
    scripts\mp\supers::_id_7203E7AA96FF0BA9(0, 1);
}

_id_3750D0E9AD3887F2() {
  self notify("deployedDecoy_parkedReady");
  self setclientomnvar("ui_deployed_decoy_use", 1);
  _id_ABA5CD3449E22124(1);
}

_id_B53A82180C76B481() {
  self endon("disconnect");
  self endon("deployedDecoy_parkedReady");
  level endon("game_ended");
  self setclientomnvar("ui_deployed_decoy_use", 2);
  wait 2.0;
  _id_ABA5CD3449E22124(0);
}

_id_46FF5657C998DCE8() {
  self setclientomnvar("ui_deployed_decoy_use", 0);
  _id_ABA5CD3449E22124(0);
}

_id_9AA20ECDD4292776() {
  thread scripts\mp\damage::monitordamage(150, "hitequip", ::_id_1621F495789F13E3, ::_id_19411386FD3D2E2D);
}

_id_1621F495789F13E3(data) {
  attacker = data.attacker;

  if(!isDefined(self.owner) || istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_813AC6F7A5A8CFB3");
  }

  _id_5D24D48D0B8EB170(1);
}

_id_19411386FD3D2E2D(data) {
  _id_4FB949CE5DA41ECA = 0;

  if(isDefined(data.objweapon.basename)) {
    if(data.objweapon.basename == "deployed_decoy_mp")
      return _id_4FB949CE5DA41ECA;
  }

  if(!isDefined(self))
    return _id_4FB949CE5DA41ECA;

  _id_8D480ACE410E1F75 = self.origin;
  _id_B404D98CCC440862 = self.team;
  _id_7CA58B9D801CFA0E = self.owner;
  _id_780FFFABE38CB3B5 = self.maxhealth;
  hits = _id_1E1A5A07121E30F8(data);

  if(isDefined(hits)) {
    if(isDefined(_id_8D480ACE410E1F75) && isDefined(_id_B404D98CCC440862) && isDefined(_id_7CA58B9D801CFA0E))
      pinglocationenemyteams(_id_8D480ACE410E1F75, _id_B404D98CCC440862, _id_7CA58B9D801CFA0E);

    thread _id_3972A29B456EBEEC(data);
    _id_4FB949CE5DA41ECA = int(ceil(min(1, hits / 10) * _id_780FFFABE38CB3B5));
  }

  if(isDefined(data.attacker) && !_id_69ADB0B10BAE1BE4(data))
    data.attacker _id_5762AC2F22202BA2::updatedamagefeedback("hitequip", 0, 0, "hitequip", 0, 1);

  thread _id_C71D3EEFA843DA49(data);
  return _id_4FB949CE5DA41ECA;
}

_id_C71D3EEFA843DA49(data) {
  self endon("death");
  self notify("deployedDecoy_animateHitReact");
  self endon("deployedDecoy_animateHitReact");
  self endon("deployedDecoy_queueDummyDestroy_Interupt");

  if(istrue(self._id_3FE87ED1237724CC))
    return 0;

  _id_2DC841AFF232FB90 = _id_5D2CE17E3DE0719B(data);

  if(isDefined(_id_2DC841AFF232FB90)) {
    self setscriptablepartstate("hitreact", "neutral", 0);
    waitframe();

    switch (_id_2DC841AFF232FB90) {
      case "frontToBack":
        thread _id_6F3C08A3A1B58895();
        break;
      case "backToFront":
        thread _id_B6E412B5E07835A5();
        break;
      case "rightToLeft":
        thread _id_AFF778CCCE490BAE();
        break;
      case "leftToRight":
        thread _id_2FC8C731D6BFD24A();
        break;
      default:
        break;
    }
  } else {}

  thread _id_1C5E39BEB07F8BB3();
}

_id_5D2CE17E3DE0719B(data) {
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  direction = data.direction_vec;
  _id_DD4FEC1F7555332C = vectordot(forward, direction);
  _id_8BBCF51FF5504B0D = vectordot(right, direction);

  if(_id_DD4FEC1F7555332C <= -0.705)
    return "frontToBack";

  if(_id_DD4FEC1F7555332C >= 0.705)
    return "backToFront";

  if(_id_8BBCF51FF5504B0D >= 0.705)
    return "leftToRight";

  if(_id_8BBCF51FF5504B0D <= -0.705)
    return "rightToLeft";
}

#using_animtree("scriptables");

_id_6F3C08A3A1B58895() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self._id_9AADBD8D704D2FAB) {
    case "dummy_standing":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_front", 0);
      wait(getanimlength(%iw9_mp_decoymine_hitreac_front));
      break;
    case "dummy_crouching":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_front", 0);
      wait(getanimlength(%iw9_mp_decoymine_crouch_hitreac_front));
      break;
    case "dummy_swimming":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_front", 0);
      wait(getanimlength(%iw9_mp_decoymine_swim_hitreac_front));
      break;
    default:
      break;
  }
}

_id_B6E412B5E07835A5() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self._id_9AADBD8D704D2FAB) {
    case "dummy_standing":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_back", 0);
      wait(getanimlength(%iw9_mp_decoymine_hitreac_back));
      break;
    case "dummy_crouching":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_back", 0);
      wait(getanimlength(%iw9_mp_decoymine_crouch_hitreac_back));
      break;
    case "dummy_swimming":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_back", 0);
      wait(getanimlength(%iw9_mp_decoymine_swim_hitreac_back));
      break;
    default:
      break;
  }
}

_id_AFF778CCCE490BAE() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self._id_9AADBD8D704D2FAB) {
    case "dummy_standing":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_right", 0);
      wait(getanimlength(%iw9_mp_decoymine_hitreac_right));
      break;
    case "dummy_crouching":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_right", 0);
      wait(getanimlength(%iw9_mp_decoymine_crouch_hitreac_right));
      break;
    case "dummy_swimming":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_right", 0);
      wait(getanimlength(%iw9_mp_decoymine_crouch_hitreac_right));
      break;
    default:
      break;
  }
}

_id_2FC8C731D6BFD24A() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self._id_9AADBD8D704D2FAB) {
    case "dummy_standing":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_left", 0);
      wait(getanimlength(%iw9_mp_decoymine_hitreac_left));
      break;
    case "dummy_crouching":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_left", 0);
      wait(getanimlength(%iw9_mp_decoymine_crouch_hitreac_left));
      break;
    case "dummy_swimming":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_left", 0);
      wait(getanimlength(%iw9_mp_decoymine_swim_hitreac_left));
      break;
    default:
      break;
  }
}

_id_1C5E39BEB07F8BB3() {
  self endon("deployedDecoy_animateHitReact");
  self endon("deployedDecoy_resumeIdleAnimation_cancel");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 2;

  if(!isDefined(self))
    return 0;

  if(istrue(self._id_3FE87ED1237724CC))
    return 0;

  self setscriptablepartstate("idle", "neutral", 0);
  waitframe();

  switch (self._id_9AADBD8D704D2FAB) {
    case "dummy_standing":
      self setscriptablepartstate("idle", "iw9_mp_decoymine_idle", 0);
      break;
    case "dummy_crouching":
      self setscriptablepartstate("idle", "iw9_mp_decoymine_crouch_idle", 0);
      break;
    case "dummy_swimming":
      self setscriptablepartstate("idle", "iw9_mp_decoymine_swim_idle", 0);
      break;
    default:
      break;
  }
}

_id_69ADB0B10BAE1BE4(data) {
  if(!isDefined(self.owner))
    return 0;

  if(self.owner == data.attacker)
    return 0;

  return !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, data.attacker);
}

_id_1E1A5A07121E30F8(data) {
  _id_7E6D3ACF41D01437 = ["MOD_GRENADE_SPLASH", "MOD_GRENADE", "MOD_EXPLOSIVE"];

  if(isDefined(data.inflictor) && isDefined(data.inflictor.classname) && data.inflictor.classname == "script_vehicle")
    return 10;

  if(_id_69ADB0B10BAE1BE4(data))
    return 0;

  if(scripts\engine\utility::array_contains(_id_7E6D3ACF41D01437, data.meansofdeath))
    return 10;

  if(data.meansofdeath == "MOD_IMPACT")
    return 2;

  hits = 0;

  if(data.damage >= 100)
    return hits + 9;
  else if(data.damage >= 40)
    return hits + 4;
  else
    return hits + 2;
}

_id_255BED505249BC85(grenade) {
  grenade._id_BDEF88E59DC867F4 = gettime();
  self._id_7F0AD61B396C9477[grenade._id_BDEF88E59DC867F4] = grenade;

  if(self._id_7F0AD61B396C9477.size > 2) {
    _id_37239B3E8021E7C1 = scripts\engine\utility::array_get_first_item(self._id_7F0AD61B396C9477);

    if(isDefined(_id_37239B3E8021E7C1))
      _id_37239B3E8021E7C1 thread _id_183A7478C53FD2F2();
  }

  if(isDefined(self._id_B79B9AA464C929BD)) {
    if(self._id_B79B9AA464C929BD.size > 1) {
      _id_10987E27E7131C9A = scripts\engine\utility::array_get_first_item(self._id_B79B9AA464C929BD);
      _id_10987E27E7131C9A thread _id_5D24D48D0B8EB170();
    }
  }

  grenade._id_2FD40475457DFFDF = grenade.owner.angles;
  grenade._id_1AE0630643036981 = 0;
  grenade.issuper = 1;
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade thread _id_02482348A6042306();
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

  if(isDefined(stuckto))
    grenade._id_4E068E1C487DBEBC = stuckto;

  grenade.angles = grenade._id_2FD40475457DFFDF;
  grenade._id_2FD40475457DFFDF = undefined;
  grenade _id_85364189C6F041D7();
  grenade thread _id_D030DD50CE502CE4();
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_deployed_decoy", 0);
}

_id_85364189C6F041D7() {
  self endon("death");
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  self._id_21B8BE41B5B72905 = [self.origin];
  ignorelist = [];
  ignorelist[0] = self;
  contents = scripts\engine\trace::create_default_contents(1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 8; _id_AC0E594AC96AA3A8++) {
    _id_D90439D9C610BE2A = 0 + 45 * _id_AC0E594AC96AA3A8;
    _id_CB89120314447D62 = rotatepointaroundvector(up, forward, _id_D90439D9C610BE2A);
    _id_CB89120314447D62 = vectorNormalize(_id_CB89120314447D62) * 28;
    _id_CB89120314447D62 = self.origin + _id_CB89120314447D62;
    _id_E021C2744CC7ED68 = scripts\engine\trace::ray_trace(self.origin, _id_CB89120314447D62, ignorelist, contents, 0, 1, 0);
    _id_0193CBB3CC7CCCDF = isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0 && _id_E021C2744CC7ED68["hittype"] != "hittype_none";

    if(_id_0193CBB3CC7CCCDF) {
      _id_92890A1F9C92F102 = _id_E021C2744CC7ED68["position"] - _id_CB89120314447D62;
      _id_92890A1F9C92F102 = _id_92890A1F9C92F102 * 2;
      _id_92890A1F9C92F102 = self.origin + _id_92890A1F9C92F102;
      self._id_21B8BE41B5B72905[self._id_21B8BE41B5B72905.size] = _id_92890A1F9C92F102;
    }

    waitframe();
  }

  for(self._id_94981AF7E247F403 = undefined; isDefined(self._id_21B8BE41B5B72905) && self._id_21B8BE41B5B72905.size > 0; self._id_21B8BE41B5B72905 = scripts\engine\utility::array_remove(self._id_21B8BE41B5B72905, _id_114AB88507847C50)) {
    _id_C56AC98044693987 = undefined;

    if(isDefined(self._id_21B8BE41B5B72905) && self._id_21B8BE41B5B72905.size > 1)
      _id_C56AC98044693987 = averagepoint(self._id_21B8BE41B5B72905);
    else
      _id_C56AC98044693987 = self._id_21B8BE41B5B72905[0];

    _id_4EE1C3D63BD43D9A = scripts\engine\trace::ray_trace(_id_C56AC98044693987, _id_C56AC98044693987 + (0, 0, -24), ignorelist, contents);
    _id_0193CBB3CC7CCCDF = isDefined(_id_4EE1C3D63BD43D9A) && _id_4EE1C3D63BD43D9A.size > 0 && _id_4EE1C3D63BD43D9A["hittype"] != "hittype_none";

    if(_id_0193CBB3CC7CCCDF) {
      self._id_94981AF7E247F403 = _id_4EE1C3D63BD43D9A["position"];

      if(1) {
        _id_2FA8C5E0C76EFE74 = (1, 1, 0);
        _id_9F92884414AA49FB = level.framedurationseconds * 60 * 10;
        thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_4EE1C3D63BD43D9A["position"], 1, _id_9F92884414AA49FB, _id_2FA8C5E0C76EFE74);
      }

      _id_A813EA1A33D83ACA = _id_0DB978960F126D2B();

      if(_id_A813EA1A33D83ACA != 0) {
        break;
      }
    }

    _id_114AB88507847C50 = self._id_21B8BE41B5B72905[0];

    foreach(point in self._id_21B8BE41B5B72905) {
      if(distancesquared(_id_114AB88507847C50, _id_C56AC98044693987) > distancesquared(point, _id_C56AC98044693987))
        _id_114AB88507847C50 = point;
    }
  }
}

_id_02482348A6042306() {
  self endon("explode");
  self endon("death");
  self endon("missile_stuck");
  self waittill("missile_water_impact", _id_850FDF3FB1C7EB84, _id_53F81081D4E7F40B, _id_71C76F81EB0C95EE);

  if(isDefined(_id_53F81081D4E7F40B)) {
    self._id_87DF5E3D4BE5E294 = _id_53F81081D4E7F40B;
    self._id_D2F74CAC2EF25448 = self.owner _meth_6F55D55CCFF20D14();
  }
}

_id_D030DD50CE502CE4() {
  self.owner endon("disconnect");
  self endon("death");
  scripts\cp_mp\ent_manager::registerspawn(1, ::_id_0EC4ED8B35F49093);
  self.owner scripts\mp\weapons::onequipmentplanted(self, "equip_deployed_decoy", ::_id_0EC4ED8B35F49093);
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  _id_536A359E6FA67DF2();
  self setentityowner(self.owner);
  self setotherent(self.owner);
  self setnodeploy(1);
  self missilethermal();
  self missileoutline();
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread scripts\mp\weapons::minedamagemonitor();
  thread _id_9B581BB90DFE8E0F();

  if(!isbot(self.owner))
    self.owner thread _id_60135177A2FAEC7C(self);

  scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_3BF15B6532C44F8D);
  _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_A6D1FD8A98751A36);
  self.owner _id_3750D0E9AD3887F2();
  _id_49197CD063A740EA(::_id_183A7478C53FD2F2);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(self);
  }

  _id_FC9EAF4F16837717();
  self setscriptablepartstate("plant", "active", 0);
  _id_91B48467F9DA9F0E();
  self.owner thread _id_26408BD5A0A9179C();
  wait 0.5;
  thread _id_8BF9FB0F704ECEB0();
}

_id_536A359E6FA67DF2() {
  if(isDefined(self._id_87DF5E3D4BE5E294)) {
    _id_9BB71E2186BDAC1F = self.origin + (0, 0, 2000);
    ignorelist = _id_3AD49688E4D76BF0();
    contents = scripts\engine\trace::_id_B88B8BD51EA7FE24();
    _id_E021C2744CC7ED68 = scripts\engine\trace::ray_trace(self.origin, _id_9BB71E2186BDAC1F, ignorelist, contents, 0, 1, 0);

    if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68["hittype"] != "hittype_none")
      self._id_FFE647A3E2FC6A87 = distance(self.origin, _id_E021C2744CC7ED68["position"]);
    else
      self._id_FFE647A3E2FC6A87 = undefined;
  }

  return self._id_FFE647A3E2FC6A87;
}

_id_8BF9FB0F704ECEB0() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  _id_A7C5AFF6BE6DCE49 = 0;

  while(!_id_A7C5AFF6BE6DCE49) {
    self waittill("trigger_grenade", _id_F9B008542CD70A05);

    if(istrue(self.stunned)) {
      continue;
    }
    foreach(ent in _id_F9B008542CD70A05) {
      if(!_id_B49D2E0ECA61DB98(ent)) {
        continue;
      }
      _id_05FA9E8666A1B8DA(ent);

      if(self._id_820C08BC4A68289F._id_2B7FCECFEF6352B4) {
        thread _id_81D957F621CB0552(ent);
        _id_A7C5AFF6BE6DCE49 = 1;
        break;
      }
    }
  }
}

_id_B49D2E0ECA61DB98(ent) {
  if(ent == self.owner)
    return 0;

  if(!isDefined(ent.team) || ent.team == self.team)
    return 0;

  if(!isDefined(ent.classname))
    return 0;

  if(!isPlayer(ent) && !isagent(ent))
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(ent))
    return 0;

  return 1;
}

_id_26408BD5A0A9179C() {
  self notify("deployedDecoy_watchForDetonate");
  self endon("deployedDecoy_watchForDetonate");
  self endon("mine_destroyed");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("detonate");

    if(self getheldoffhand().basename == "deployed_decoy_mp" || self getheldoffhand().basename == "none" && istrue(self.isusingcamera)) {
      _id_8C54DFF0AD6753D4();
      break;
    }
  }
}

_id_8C54DFF0AD6753D4() {
  self._id_972E08BB6F0816F1 = undefined;

  if(isDefined(self._id_7F0AD61B396C9477)) {
    foreach(_id_A335666A563C40C0 in self._id_7F0AD61B396C9477)
    _id_A335666A563C40C0 _id_A5577C168F2CD487();
  }
}

_id_6438A3C103F573EE(ent) {
  _id_44060504F23C16AF = [];

  if(isDefined(ent)) {
    _id_AD283A45677A1EA3 = ent gettagorigin("j_mainroot");
    _id_44060504F23C16AF = [_id_AD283A45677A1EA3];
    _id_44060504F23C16AF[_id_44060504F23C16AF.size] = ent gettagorigin("j_spineupper");
    _id_44060504F23C16AF[_id_44060504F23C16AF.size] = ent.origin;
  }

  return _id_44060504F23C16AF;
}

_id_05FA9E8666A1B8DA(ent) {
  self._id_820C08BC4A68289F = undefined;
  _id_820C08BC4A68289F = spawnStruct();
  _id_820C08BC4A68289F.iscomplete = 0;
  _id_44060504F23C16AF = _id_6438A3C103F573EE(ent);

  foreach(_id_A00164B06F60F5E6 in _id_44060504F23C16AF) {
    _id_820C08BC4A68289F = spawnStruct();
    _id_820C08BC4A68289F.targetpos = _id_A00164B06F60F5E6;
    _id_820C08BC4A68289F.iscomplete = 1;
    _id_820C08BC4A68289F._id_F2A216076F977490 = 0;
    _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC = 0;
    _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 = 0;
    _id_820C08BC4A68289F._id_E9B7D63908996C9E = 0;
    _id_820C08BC4A68289F._id_3045266DFC71B133 = 0;
    _id_820C08BC4A68289F._id_2B7FCECFEF6352B4 = 0;
    _id_820C08BC4A68289F._id_F2A216076F977490 = _id_1F54BEB17865D9C2(_id_A00164B06F60F5E6);
    _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC = _id_284789987BABCE6E(_id_A00164B06F60F5E6);
    _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 = _id_5992CD0B16E52700(_id_A00164B06F60F5E6, 58);
    _id_820C08BC4A68289F._id_E9B7D63908996C9E = _id_5992CD0B16E52700(_id_A00164B06F60F5E6, 40);

    if(isDefined(self._id_FFE647A3E2FC6A87) && istrue(self._id_FFE647A3E2FC6A87 >= 72))
      _id_820C08BC4A68289F._id_3045266DFC71B133 = _id_5992CD0B16E52700(_id_A00164B06F60F5E6, self._id_FFE647A3E2FC6A87);

    if(isDefined(self._id_87DF5E3D4BE5E294))
      _id_820C08BC4A68289F._id_2B7FCECFEF6352B4 = _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC && (_id_820C08BC4A68289F._id_3045266DFC71B133 || _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26);
    else
      _id_820C08BC4A68289F._id_2B7FCECFEF6352B4 = _id_820C08BC4A68289F._id_F2A216076F977490 && _id_820C08BC4A68289F._id_37E9B11A3F0F2AFC && (_id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 || _id_820C08BC4A68289F._id_E9B7D63908996C9E);

    if(_id_820C08BC4A68289F._id_2B7FCECFEF6352B4) {
      break;
    }
  }

  _id_820C08BC4A68289F._id_E4CBF98C9AAD2678 = 0;
  _id_820C08BC4A68289F._id_E4CBF98C9AAD2678 = _id_0DB978960F126D2B();
  self._id_820C08BC4A68289F = _id_820C08BC4A68289F;
  return self._id_820C08BC4A68289F;
}

_id_0DB978960F126D2B() {
  ignorelist = _id_3AD49688E4D76BF0();
  contents = _id_FB584D71AF834F48();
  caststart = scripts\engine\utility::ter_op(isDefined(self._id_94981AF7E247F403), self._id_94981AF7E247F403, self.origin);
  caststart = caststart + (0, 0, 17);
  castend = caststart + (0, 0, 66);
  _id_E021C2744CC7ED68 = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents, 0, 0);
  _id_0E229E51F9FF9A0E = 0;
  _id_5700902C7EDD5163 = undefined;

  if(isDefined(_id_E021C2744CC7ED68["hittype"])) {
    if(_id_E021C2744CC7ED68["hittype"] == "hittype_world" && isDefined(_id_E021C2744CC7ED68["position"])) {
      _id_5700902C7EDD5163 = distance(caststart, _id_E021C2744CC7ED68["position"]);
      thread scripts\cp_mp\utility\debug_utility::drawsphere(_id_E021C2744CC7ED68["position"], 1, 100, (1, 0, 0));
    }
  }

  if(isDefined(_id_5700902C7EDD5163)) {
    if(_id_5700902C7EDD5163 >= 53)
      _id_0E229E51F9FF9A0E = 1;

    if(_id_5700902C7EDD5163 >= 66)
      _id_0E229E51F9FF9A0E = 2;
  } else
    _id_0E229E51F9FF9A0E = 2;

  return _id_0E229E51F9FF9A0E;
}

_id_5992CD0B16E52700(_id_A00164B06F60F5E6, _id_AA95611290376282) {
  ignorelist = _id_3AD49688E4D76BF0();
  contents = _id_BA2606CFB4C66281();
  _id_E021C2744CC7ED68 = scripts\engine\trace::ray_trace(self.origin + (0, 0, _id_AA95611290376282), _id_A00164B06F60F5E6, ignorelist, contents, 0, 1, 0);
  _id_0193CBB3CC7CCCDF = isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0 && _id_E021C2744CC7ED68["hittype"] == "hittype_entity";
  return _id_0193CBB3CC7CCCDF;
}

_id_74514723C815EECA(_id_47293B1E94FF8FB0) {
  if(!isDefined(_id_47293B1E94FF8FB0))
    return 0;

  forward = anglesToForward(self.angles);
  _id_1650A941C8770F2F = vectorNormalize(_id_47293B1E94FF8FB0 - self.origin);
  _id_3FE3A3DD483D56C9 = vectordot(forward, _id_1650A941C8770F2F);
  return _id_3FE3A3DD483D56C9 > 0.866 && _id_3FE3A3DD483D56C9 > -0.866;
}

_id_284789987BABCE6E(_id_A00164B06F60F5E6) {
  _id_27789E85BFA3EA1F = abs(self.origin[2] - _id_A00164B06F60F5E6[2]);
  return 384 >= _id_27789E85BFA3EA1F;
}

_id_1F54BEB17865D9C2(_id_A00164B06F60F5E6) {
  return 350 >= distance2d(_id_A00164B06F60F5E6, self.origin);
}

_id_81D957F621CB0552(attacker, ent) {
  if(isDefined(attacker))
    attacker endon("death_or_disconnect");
  else
    attacker = self.owner;

  scripts\mp\utility\print::printgameaction("Decoy triggered", self.owner);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("trigger", "active", 0);
  thread _id_A5577C168F2CD487(attacker);
  self notify("mine_triggered");
}

_id_9B581BB90DFE8E0F() {
  self endon("death");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);
  self.detonatingplayer = attacker;
  thread _id_A5577C168F2CD487(attacker);
}

_id_786A7189AD105A77(_id_B8F96BD12748F572) {
  if(!isDefined(self._id_7F0AD61B396C9477) || self._id_7F0AD61B396C9477.size == 0)
    return 0;

  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_B8F96BD12748F572);
  self clearoffhandspecial();
  self._id_972E08BB6F0816F1 = 1;
  self notify("activateDecoy", "success");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_B8F96BD12748F572);
  self assignweaponoffhandspecial(_id_B8F96BD12748F572);
  return 1;
}

_id_7168B5644ECFC7B7() {
  if(istrue(self.isjuggernaut))
    return 0;

  if(self isinfreefall())
    return 0;

  if(scripts\mp\supers::issuperready() && !istrue(self._id_972E08BB6F0816F1))
    return 0;

  if(self _meth_415FE9EECA7B2E2B())
    return 0;

  if(self isthrowinggrenade())
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    return 0;

  return 1;
}

_id_60135177A2FAEC7C(mine) {
  level endon("game_ended");
  self endon("deployedDecoy_unset");
  self notify("deployedDecoy_monitoringDetonation");
  self endon("deployedDecoy_monitoringDetonation");
  self endon("disconnect");
  weaponobj = makeweapon("iw9_detonator_mp");

  for(;;) {
    success = _id_91132A4FD7767609();

    if(!success) {
      continue;
    }
    if(!_id_7168B5644ECFC7B7()) {
      continue;
    }
    _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();

    if(!isDefined(_id_19163E14365D9264)) {
      continue;
    }
    if(_id_19163E14365D9264.staticdata.ref == "super_select") {
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ppmenu");
      waitframe();
    }

    _id_B8518D272E4C3423 = scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(weaponobj);

    if(!_id_B8518D272E4C3423) {}

    thread _id_8C54DFF0AD6753D4();
    return;
    waitframe();
  }
}

_id_91132A4FD7767609() {
  childthread _id_8711CC188D381233();
  childthread _id_2708229FAEA7E5FD();
  self waittill("activateDecoy", msg);
  self notifyonplayercommandremove("tacButtonPress", "+smoke");
  self notifyonplayercommandremove("fragButtonPress", "+frag");
  self notifyonplayercommandremove("cameraActive", "+special");
  return msg == "success";
}

_id_8711CC188D381233() {
  self endon("activateDecoy");
  self notifyonplayercommand("decoyExplodeKBM", "+special");
  self waittill("decoyExplodeKBM");
  self notify("activateDecoy", "success");
}

_id_2708229FAEA7E5FD() {
  self endon("activateDecoy");
  self notifyonplayercommand("tacButtonPress", "+smoke");
  self notifyonplayercommand("fragButtonPress", "+frag");
  _id_BD1267E9DEA3DBA9 = ["tacButtonPress", "fragButtonPress"];
  thread scripts\mp\supers::_id_8D6D95114B2C9B0D(_id_BD1267E9DEA3DBA9, [], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("activateDecoy", msg);
}

_id_BA2606CFB4C66281() {
  contents = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 1, 1, 1);
  return contents;
}

_id_FB584D71AF834F48() {
  contents = scripts\engine\trace::create_contents(1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0);
  return contents;
}

_id_3AD49688E4D76BF0() {
  ignorelist = _id_E0F66654476DC4F4();
  return ignorelist;
}

_id_E0F66654476DC4F4() {
  _id_F755FDDCDBF39420 = 1;
  ignorelist = [];

  if(_id_F755FDDCDBF39420) {
    ignorelist[ignorelist.size] = self.owner;
    linkedents = self getlinkedchildren(1);

    if(!isDefined(linkedents))
      linkedents = [];

    linkedents[linkedents.size] = self getlinkedparent();

    foreach(linkedent in linkedents) {
      if(isDefined(linkedent) && linkedent.classname == "grenade")
        ignorelist[ignorelist.size] = linkedent;
    }
  }

  if(isDefined(level.dynamicladders)) {
    foreach(struct in level.dynamicladders)
    ignorelist[ignorelist.size] = struct.ents[0];
  }

  return ignorelist;
}

_id_3BF15B6532C44F8D(data) {
  scripts\mp\equipment\claymore::claymore_empapplied(data);
}

_id_A6D1FD8A98751A36(data) {
  _id_A5577C168F2CD487(data.attacker);
}

_id_3B1D270B83DCDD41() {
  return 1;
}

_id_2A3ABC2B830FF7D2(dummy) {
  if(isDefined(dummy._id_44736CEE8AFAD49B)) {
    foreach(door in dummy._id_44736CEE8AFAD49B)
    door thread _id_3033EBEB29280A95(dummy);
  }
}

_id_3033EBEB29280A95(dummy) {
  doorstate = self getscriptablepartstate("door", 1);

  if(isDefined(doorstate) && doorstate != "frozen" && doorstate != "locked")
    self _meth_0C7F3AC96DD01424("away", dummy.origin);
}

_id_FAB47AE10A7EC712(stuckto) {
  self endon("death");
  level endon("game_ended");
  stuckto waittill("death");
  _id_5D24D48D0B8EB170(1);
}

_id_A5577C168F2CD487(attacker) {
  _id_859C5E9D6C961151 = self.origin;
  _id_29AC1222D3DC6D3E = self.team;
  _id_3A8872B8E0BE346A = self.owner;

  if(!_id_3B1D270B83DCDD41()) {
    return;
  }
  level.mines[self getentitynumber()] = undefined;
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\mp\weapons::makeexplosiveunusuabletag();

  if(isDefined(self.useobj))
    self.useobj delete();

  self.exploding = 1;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  _id_A199D96200A367D6 = self.angles;

  if(isDefined(attacker)) {
    if(!isDefined(self._id_820C08BC4A68289F) || !istrue(self._id_820C08BC4A68289F.iscomplete))
      _id_05FA9E8666A1B8DA(attacker);

    if(attacker == self.owner)
      _id_A199D96200A367D6 = self.angles;
    else {
      _id_A199D96200A367D6 = vectortoangles(attacker.origin - self.origin);
      _id_A199D96200A367D6 = (0, _id_A199D96200A367D6[1], 0);
    }
  } else
    _id_05FA9E8666A1B8DA(undefined);

  self.dummy = _id_8958B19A2ECC8D46();
  self.owner._id_B79B9AA464C929BD[self._id_BDEF88E59DC867F4] = self.dummy;
  self.dummy._id_9AADBD8D704D2FAB = self._id_9AADBD8D704D2FAB;
  self.dummy.angles = _id_A199D96200A367D6;
  self.dummy._id_BDEF88E59DC867F4 = self._id_BDEF88E59DC867F4;
  self.dummy._id_44736CEE8AFAD49B = self._id_44736CEE8AFAD49B;
  self.dummy setentityowner(self.owner);
  self.dummy setotherent(self.owner);

  if(isDefined(self._id_4E068E1C487DBEBC) && scripts\cp_mp\utility\killstreak_utility::_id_3C5C5D86EF14420E(self._id_4E068E1C487DBEBC))
    self.dummy linkTo(self._id_4E068E1C487DBEBC);
  else if(isDefined(self._id_4E068E1C487DBEBC))
    self.dummy thread _id_FAB47AE10A7EC712(self._id_4E068E1C487DBEBC);

  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  thread _id_ECF65E63998A0845();
  glassradiusdamage(self.origin, 85, 75, 25);
  _id_2A3ABC2B830FF7D2(self.dummy);

  if(isDefined(self.dummy)) {
    self.dummy thread _id_2AE474EB2C763DCA(self._id_9AADBD8D704D2FAB);
    self.dummy thread _id_38042B771A7DE69D(1);
    self.dummy _id_49197CD063A740EA(::_id_5D24D48D0B8EB170);

    if(isDefined(self._id_4E068E1C487DBEBC)) {
      self.dummy.moving_platform = self._id_4E068E1C487DBEBC;
      data = spawnStruct();
      data.linkparent = self.dummy.moving_platform;
      data.deathoverridecallback = ::_id_56A30EBF54077E71;
      data.validateaccuratetouching = 1;
      self.dummy thread scripts\mp\movers::handle_moving_platforms(data);
      self.dummy thread _id_19C1FFF6756BCA97();
    } else if(isDefined(level.wztrain_info)) {
      data = spawnStruct();
      data.deathoverridecallback = ::_id_56A30EBF54077E71;
      self.dummy thread scripts\mp\movers::handle_moving_platforms(data);
    }
  }

  if(isDefined(_id_859C5E9D6C961151) && isDefined(_id_29AC1222D3DC6D3E) && isDefined(_id_3A8872B8E0BE346A))
    pinglocationenemyteams(_id_859C5E9D6C961151, _id_29AC1222D3DC6D3E, _id_3A8872B8E0BE346A);

  if(isDefined(level) && isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      if(!isDefined(elevators)) {
        continue;
      }
      if(!isDefined(self)) {
        continue;
      }
      if(!isDefined(self.dummy)) {
        continue;
      }
      elevators thread _id_5F903436642211AF::_id_29DE8F099A0A63DF(self.dummy);
    }
  }

  self.owner thread _id_B53A82180C76B481();

  if(isDefined(self.dummy) && isDefined(self._id_820C08BC4A68289F) && self._id_820C08BC4A68289F._id_E4CBF98C9AAD2678 == 0)
    self.dummy thread _id_5D24D48D0B8EB170(1);

  _id_183A7478C53FD2F2();
}

_id_ECF65E63998A0845() {
  level endon("game_ended");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    if(16 >= distance2dsquared(self.origin, player.origin))
      player dodamage(125, self.origin, self.owner, self, undefined, "deployed_decoy_mp", undefined, undefined);
  }
}

_id_19C1FFF6756BCA97() {
  self endon("death");

  while(isDefined(self getlinkedparent()))
    waitframe();

  _id_5D24D48D0B8EB170(1);
}

_id_FC9EAF4F16837717() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }
  if(isDefined(self.dangerzone))
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

_id_A6856182B82CBC63(_id_629E073572854F50, _id_A50D4AC45EC0F007) {
  if(!isDefined(_id_A50D4AC45EC0F007))
    spawnpos = scripts\engine\utility::ter_op(isDefined(self._id_94981AF7E247F403), self._id_94981AF7E247F403, self.origin);
  else
    spawnpos = scripts\engine\utility::ter_op(isDefined(self._id_94981AF7E247F403), self._id_94981AF7E247F403, self.origin) + _id_A50D4AC45EC0F007;

  model = spawn("script_model", spawnpos);
  model setModel(_id_629E073572854F50);
  model.weapon_name = "deployed_decoy_mp";
  model.team = self.owner.team;
  model.owner = self.owner;
  model scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner, 1);
  return model;
}

_id_8958B19A2ECC8D46() {
  dummy = undefined;

  if(isDefined(self._id_FFE647A3E2FC6A87) && self._id_FFE647A3E2FC6A87 > 40)
    dummy = _id_120277E9245ABEF8();
  else if(isDefined(self._id_820C08BC4A68289F) && istrue(self._id_820C08BC4A68289F.iscomplete) && istrue(self._id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 && !self._id_820C08BC4A68289F._id_E9B7D63908996C9E && self._id_820C08BC4A68289F._id_E4CBF98C9AAD2678 >= 2))
    dummy = _id_65BAB2B826C7C79F();
  else if(isDefined(self._id_820C08BC4A68289F) && istrue(self._id_820C08BC4A68289F.iscomplete) && istrue(!self._id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 && self._id_820C08BC4A68289F._id_E9B7D63908996C9E && self._id_820C08BC4A68289F._id_E4CBF98C9AAD2678 >= 1))
    dummy = _id_A9B9F466BD2859C7();
  else {
    _id_F4CAE9D2914CC11B = randomint(2);

    if(_id_F4CAE9D2914CC11B > 0)
      dummy = _id_65BAB2B826C7C79F();
    else
      dummy = _id_A9B9F466BD2859C7();
  }

  dummy _id_9AA20ECDD4292776();
  dummy scripts\cp_mp\ent_manager::registerspawn(1, ::_id_D3862975BB307EE3);
  return dummy;
}

_id_65BAB2B826C7C79F() {
  _id_32255DAB0BC79F68 = _id_A6856182B82CBC63("offhand_2h_wm_decoy_mine_dummy01_v0_mp");
  self._id_9AADBD8D704D2FAB = "dummy_standing";
  return _id_32255DAB0BC79F68;
}

_id_A9B9F466BD2859C7() {
  _id_32255DAB0BC79F68 = _id_A6856182B82CBC63("offhand_2h_wm_decoy_mine_dummy02_v0_mp");
  self._id_9AADBD8D704D2FAB = "dummy_crouching";
  return _id_32255DAB0BC79F68;
}

_id_120277E9245ABEF8() {
  _id_32255DAB0BC79F68 = _id_A6856182B82CBC63("offhand_2h_wm_decoy_mine_dummy03_v0_mp", (0, 0, self._id_FFE647A3E2FC6A87 - 8));
  self._id_9AADBD8D704D2FAB = "dummy_swimming";
  return _id_32255DAB0BC79F68;
}

_id_2AE474EB2C763DCA(_id_F3F6E0AEF7920E0B) {
  self.owner endon("disconnect");
  self endon("death");
  level endon("endgame");

  if(!isDefined(_id_F3F6E0AEF7920E0B))
    return 0;

  switch (_id_F3F6E0AEF7920E0B) {
    case "dummy_standing":
      self setscriptablepartstate("inflate", "iw9_mp_decoymine_inflate", 0);
      wait(getanimlength(%iw9_mp_decoymine_inflate));
      self setscriptablepartstate("idle", "iw9_mp_decoymine_idle", 0);
      self setscriptablepartstate("inflate", "neutral", 0);
      break;
    case "dummy_crouching":
      self setscriptablepartstate("inflate", "iw9_mp_decoymine_crouch_inflate", 0);
      wait(getanimlength(%iw9_mp_decoymine_crouch_inflate));
      self setscriptablepartstate("idle", "iw9_mp_decoymine_crouch_idle", 0);
      self setscriptablepartstate("inflate", "neutral", 0);
      break;
    case "dummy_swimming":
      self setscriptablepartstate("inflate", "iw9_mp_decoymine_swim_inflate", 0);
      wait(getanimlength(%iw9_mp_decoymine_swim_inflate));
      self setscriptablepartstate("idle", "iw9_mp_decoymine_swim_idle", 0);
      self setscriptablepartstate("inflate", "neutral", 0);
      break;
    default:
      break;
  }
}

_id_3F3CE37397B66E92(_id_F3F6E0AEF7920E0B, _id_4BA1C61DF5B425CC) {
  self endon("death");

  switch (_id_F3F6E0AEF7920E0B) {
    case "dummy_standing":
      if(istrue(_id_4BA1C61DF5B425CC)) {
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_pop", 0);
        wait(getanimlength(%iw9_mp_decoymine_pop));
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        wait 0.4;
        glassradiusdamage(self.origin, 72, 75, 25);
        self setscriptablepartstate("deflate", "neutral", 0);
      } else {
        self setscriptablepartstate("hitreact", "neutral", 0);
        self setscriptablepartstate("idle", "neutral", 0);
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_deflate", 0);
        wait(getanimlength(%iw9_mp_decoymine_deflate));
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        self setscriptablepartstate("deflate", "neutral", 0);
      }

      break;
    case "dummy_crouching":
      if(istrue(_id_4BA1C61DF5B425CC)) {
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_crouch_pop", 0);
        wait(getanimlength(%iw9_mp_decoymine_crouch_pop));
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        wait 0.4;
        glassradiusdamage(self.origin, 72, 75, 25);
        self setscriptablepartstate("deflate", "neutral", 0);
      } else {
        self setscriptablepartstate("hitreact", "neutral", 0);
        self setscriptablepartstate("idle", "neutral", 0);
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_crouch_deflate", 0);
        wait(getanimlength(%iw9_mp_decoymine_crouch_deflate));
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        self setscriptablepartstate("deflate", "neutral", 0);
      }

      break;
    case "dummy_swimming":
      if(istrue(_id_4BA1C61DF5B425CC)) {
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_swim_pop", 0);
        wait(getanimlength(%iw9_mp_decoymine_swim_pop));
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        wait 0.4;
        glassradiusdamage(self.origin, 72, 75, 25);
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        self setscriptablepartstate("deflate", "neutral", 0);
      } else {
        self setscriptablepartstate("hitreact", "neutral", 0);
        self setscriptablepartstate("idle", "neutral", 0);
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_swim_deflate", 0);
        wait(getanimlength(%iw9_mp_decoymine_swim_deflate));
        self setscriptablepartstate("deflate", "neutral", 0);
      }

      break;
    default:
      break;
  }
}

_id_38042B771A7DE69D(delay) {
  level endon("game_ended");
  self endon("death");
  self endon("destroy");

  if(isDefined(delay))
    wait(delay);

  switch (self._id_9AADBD8D704D2FAB) {
    case "dummy_standing":
      self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 65, undefined, undefined, undefined, 0, 1, 0, undefined, 0);
      break;
    case "dummy_crouching":
      self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 52, undefined, undefined, undefined, 0, 1, 0, undefined, 0);
      break;
    case "dummy_swimming":
      self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 29, undefined, undefined, undefined, 0, 1, 0, undefined, 0);
      break;
    default:
      break;
  }
}

_id_91B48467F9DA9F0E() {
  _id_913576E1DC1762B5 = getentitylessscriptablearray(undefined, undefined, self.origin, 75);
  self._id_44736CEE8AFAD49B = [];

  foreach(_id_1109E0CCF82E9964 in _id_913576E1DC1762B5) {
    if(_id_1109E0CCF82E9964 scriptableisdoor() || _id_1109E0CCF82E9964 scriptabledoorisdouble())
      self._id_44736CEE8AFAD49B[self._id_44736CEE8AFAD49B.size] = _id_1109E0CCF82E9964;
  }
}

_id_183A7478C53FD2F2() {
  level endon("endgame");

  if(isDefined(self)) {
    self setscriptablepartstate("destroy", "active", 0);
    childthread _id_0EC4ED8B35F49093();
  }
}

_id_0EC4ED8B35F49093() {
  self endon("death");
  level endon("endgame");

  if(isDefined(self)) {
    self setscriptablepartstate("hack_usable", "off");

    if(isDefined(self.owner) && isDefined(self.owner._id_7F0AD61B396C9477))
      self.owner._id_7F0AD61B396C9477 = scripts\engine\utility::array_remove(self.owner._id_7F0AD61B396C9477, self);

    scripts\mp\damage::monitordamageend();
    level.mines[self getentitynumber()] = undefined;
    self setCanDamage(0);
    scripts\mp\weapons::makeexplosiveunusuabletag();
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
    self.headiconid = undefined;
    self.exploding = 1;

    if(isDefined(self.dangerzone)) {
      scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
      self.dangerzone = undefined;
    }

    if(isDefined(self.dummy))
      self.dummy thread _id_13249D21F9C1C453(30);

    scripts\cp_mp\ent_manager::deregisterspawn();

    if(isDefined(self.owner))
      self.owner scripts\mp\weapons::removeequip(self);

    waitframe();
    self delete();
  }
}

_id_D3862975BB307EE3() {
  self endon("death");
  level endon("game_ended");
  scripts\mp\damage::monitordamageend();
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;

  if(isDefined(self.owner) && isDefined(self.owner._id_B79B9AA464C929BD))
    self.owner._id_B79B9AA464C929BD = scripts\engine\utility::array_remove(self.owner._id_B79B9AA464C929BD, self);

  waittillframeend;
  self delete();
}

_id_56A30EBF54077E71(data) {
  _id_5D24D48D0B8EB170(1);
}

_id_5D24D48D0B8EB170(_id_4BA1C61DF5B425CC) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self._id_3FE87ED1237724CC = 1;
  self notify("deployedDecoy_resumeIdleAnimation_cancel");
  self notify("deployedDecoy_queueDummyDestroy_Interupt");
  self setscriptablepartstate("hitreact", "neutral", 0);
  self notify("destroy");
  _id_3F3CE37397B66E92(self._id_9AADBD8D704D2FAB, _id_4BA1C61DF5B425CC);
  waittillframeend;
  _id_D3862975BB307EE3();
}

_id_13249D21F9C1C453(_id_CBF7BE4F62A0DDB2) {
  self endon("deployedDecoy_queueDummyDestroy_Interupt");

  if(!isDefined(_id_CBF7BE4F62A0DDB2))
    _id_CBF7BE4F62A0DDB2 = 0;

  wait(_id_CBF7BE4F62A0DDB2);
  thread _id_5D24D48D0B8EB170();
}

_id_34669788FDE2926B(objweapon, _id_7004DB721E68783E) {
  if(istrue(_id_7004DB721E68783E))
    return isDefined(objweapon) && istrue(objweapon.basename == "deployed_decoy_mp");

  return isDefined(objweapon) && istrue(objweapon.basename == "deployed_decoy_mp");
}

_id_31ABC24CEAA8D163(_id_F357880CC9ACABDA) {
  if(!isDefined(_id_F357880CC9ACABDA) || !isDefined(_id_F357880CC9ACABDA.owner))
    return 0;

  self notify("deployedDecoy_watchScoringThread");
  self endon("deployedDecoy_watchScoringThread");
  _id_F357880CC9ACABDA.owner endon("disconnect");
  level endon("game_ended");
  self._id_A4D803F0A1114E87 = _id_F357880CC9ACABDA getentitynumber();
  self._id_B8B8B6B0AF551E03 = _id_F357880CC9ACABDA.owner;
  scripts\engine\utility::waittill_any_timeout_1(10, "decoyDummyEndScoring");
  self._id_A4D803F0A1114E87 = undefined;
  self._id_B8B8B6B0AF551E03 = undefined;
}

_id_3972A29B456EBEEC(data) {
  if(data.attacker != self.owner) {
    if(!data.attacker _id_A26953A3E8E58A3F(self)) {
      if(isDefined(self.owner))
        self.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_218B72EF391E7F09");
    }

    data.attacker thread _id_31ABC24CEAA8D163(self);
  }
}

_id_A22D831B624CCCD2() {
  if(_id_A26953A3E8E58A3F()) {
    self._id_B8B8B6B0AF551E03 thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_63DDB3737FCC850D");
    self notify("decoyDummyEndScoring");
  }

  self._id_A4D803F0A1114E87 = undefined;
  self._id_B8B8B6B0AF551E03 = undefined;
}

_id_A26953A3E8E58A3F(_id_734C4B4E112907B2) {
  if(!isDefined(_id_734C4B4E112907B2) && isDefined(self._id_A4D803F0A1114E87))
    _id_734C4B4E112907B2 = getentbynum(self._id_A4D803F0A1114E87);

  return isDefined(self._id_A4D803F0A1114E87) && isDefined(self._id_B8B8B6B0AF551E03) && isDefined(_id_734C4B4E112907B2) && istrue(_id_734C4B4E112907B2 getentitynumber() == self._id_A4D803F0A1114E87);
}

_id_F4231EED765CE56C() {
  return isDefined(self._id_7F0AD61B396C9477) && self._id_7F0AD61B396C9477.size > 0;
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_50e8db995ab7bb75.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("missile_turret", ::_id_7B0ACDB995EFBCD0);
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC["missile_turret"];

  if(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09._id_661E446067D68053))
    scripts\mp\killstreaks\killstreaks::_id_9336A3981B59677B("missile_turret", _id_D442547D75DFFD09._id_661E446067D68053, "stat_B0408FEC4209F8D4");

  scripts\cp_mp\utility\script_utility::registersharedfunc("missile_turret", "handleMovingPlatform", scripts\mp\killstreaks\manual_turret_mp::manual_turret_handlemovingplatform);
  _id_A0A5114BB65FCECD();
}

_id_B750543C3BF3D80F(streakinfo, _id_41BF9BF4918115AC, weaponobj) {
  if(!istrue(_id_41BF9BF4918115AC))
    scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
}

_id_463F566C8CFDDEA5(streakname) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, self);
  return _id_7B0ACDB995EFBCD0(streakinfo);
}

_id_7B0ACDB995EFBCD0(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      self._id_35CB2404E29573CE = 0;
      return 0;
    }
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("deploy_sentry_mp"), 1, undefined, undefined, ::_id_B750543C3BF3D80F);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    self._id_35CB2404E29573CE = 0;
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      self._id_35CB2404E29573CE = 0;
      return 0;
    }
  }

  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(0);
  turret = _id_993008EF9F603AA6("missile_turret", streakinfo);

  if(!isDefined(turret)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
    self._id_35CB2404E29573CE = 0;
    return 0;
  }

  marker = _id_159A8E5FA750161C(turret, streakinfo, 0, 1.25);

  if(!isDefined(marker)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
    turret delete();
    self._id_35CB2404E29573CE = 0;
    return 0;
  }

  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_BFDCEC13005413A5);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_4D4513E6AFB21E9C);
  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
  _id_56D5F8C1988C64EB(turret, marker);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("missile_turret", "munitionUsed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("missile_turret", "munitionUsed")]]();

  return 1;
}

_id_159A8E5FA750161C(turret, streakinfo, _id_6152D24062D26039, _id_290B1442271AB369) {
  self._id_35CB2404E29573CE = 1;
  turret laseroff();
  thread _id_3133DAA58B56FB69(_id_290B1442271AB369);
  marker = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("missile_turret", "watchForPlayerEnteringLastStand"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("missile_turret", "watchForPlayerEnteringLastStand")]]();

  marker = _id_98C72B3604B1124D(streakinfo, _id_6152D24062D26039);
  self notify("turret_placement_finished");

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive())
      scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp");

    return undefined;
  }

  turret thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon("deploy_sentry_mp"))
    thread scripts\cp_mp\killstreaks\manual_turret::manualturret_switchbacklastweapon("deploy_sentry_mp", 1, 1);

  _id_85CDA42514DC11D2 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_85CDA42514DC11D2);
  return marker;
}

_id_3133DAA58B56FB69(_id_74B5B12BB6514385) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  self setclientomnvar("ui_turret_placement", 1);
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("death");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("turret_placement_finished");
}

_id_993008EF9F603AA6(turrettype, streakinfo) {
  config = level._id_7D48025EA3734FA2[turrettype];
  turret = spawnturret("misc_turret", self.origin, level._id_7D48025EA3734FA2[turrettype].weaponinfo);
  turret.owner = self;
  turret.team = self.team;
  turret.angles = self.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.streakinfo = streakinfo;
  turret.turrettype = turrettype;
  turret.shouldsplash = 1;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;
  turret._id_8F7BA18BC776BE33 = config._id_E843DE3404005D56;
  turret.carriedby = self;
  turret _id_70C8684C2C29BF59("placed");
  turret setturretowner(turret.owner);
  turret setturretteam(turret.team);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret hide();
  turret setautorotationdelay(0.2);
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 0.1;

  switch (turrettype) {
    case "missile_turret":
    default:
      turret maketurretinoperable();
      turret setleftarc(180);
      turret setrightarc(180);
      turret setbottomarc(50);
      turret settoparc(120);
      turret setconvergencetime(0.2, "pitch");
      turret setconvergencetime(0.2, "yaw");
      turret setconvergenceheightpercent(0.65);
      turret setdefaultdroppitch(-89.0);
      break;
  }

  turret setturretmodechangewait(1);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  _id_0D3DC97C59992D51 = anglesToForward(turret.angles);
  _id_A8AE5E047A5B6CB6 = turret gettagorigin("tag_laser") + (0, 0, 10);
  _id_A8AE5E047A5B6CB6 = _id_A8AE5E047A5B6CB6 - _id_0D3DC97C59992D51 * 20;
  killcament = spawn("script_model", _id_A8AE5E047A5B6CB6);
  killcament linkTo(turret);
  turret.killcament = killcament;
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  return turret;
}

_id_56D5F8C1988C64EB(turret, marker) {
  config = level._id_7D48025EA3734FA2[turret.turrettype];
  turret _id_70C8684C2C29BF59("placed");

  if(!isDefined(self.placedsentries))
    self.placedsentries = [];

  if(!isDefined(self.placedsentries[turret.turrettype]))
    self.placedsentries[turret.turrettype] = [];

  if(istrue(turret.shouldsplash)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, turret.streakinfo.streakname);

    splashname = config.teamsplash;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](splashname, self);

    turret.shouldsplash = 0;
  }

  turret show();
  turret dontinterpolate();
  turret.angles = marker.angles;
  turret.carriedby = undefined;

  if(isDefined(marker.moving_platform)) {
    turret.moving_platform = marker.moving_platform;
    turret.moving_platform_offset = marker.moving_platform_offset;
    turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
  }

  self._id_35CB2404E29573CE = 0;
  turret.origin = marker.location;
  turret playSound("sentry_gun_plant");
  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret, "tag_aim_pivot");
  _id_F96E4256F03C5F42 = "hud_icon_minimap_killstreak_sentry";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    turret.minimapid = turret.colmodel[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](_id_F96E4256F03C5F42, turret.team, undefined, 1, 1);

  _id_11D7F05662DF0482 = self.placedsentries[turret.turrettype].size;
  self.placedsentries[turret.turrettype][_id_11D7F05662DF0482] = turret;

  if(_id_11D7F05662DF0482 + 1 > 2)
    self.placedsentries[turret.turrettype][0] notify("kill_turret", 0, 0);

  headiconoffset = 70;

  if(turret.model == level._id_7D48025EA3734FA2[turret.turrettype].modelbasecover)
    headiconoffset = 35;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    turret[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried");

  turret setmode(level._id_7D48025EA3734FA2[turret.turrettype].sentrymodeon);
  _id_5E8EB3C31F9C265C = "bi_base";

  if(!isDefined(turret.useownerobj)) {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);
    turret.useownerobj = _id_F43B6A78213DBAE8(_id_963953C3478BF4FE, "HINT_BUTTON", undefined, config.ownerusehintstring);
  } else {
    _id_963953C3478BF4FE = turret gettagorigin(_id_5E8EB3C31F9C265C);
    turret.useownerobj _meth_DFB78B3E724AD620(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = _id_963953C3478BF4FE;
  }

  turret.useownerobj linkTo(turret, _id_5E8EB3C31F9C265C);

  foreach(guy in level.players) {
    if(guy != turret.owner)
      turret.useownerobj disableplayeruse(guy);
  }

  scripts\mp\killstreaks\manual_turret_mp::manual_turret_handlemovingplatform(turret);
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", self);
  turret _id_E43A156FF3CDAF09();
  turret thread _id_973E8BBEDDC12392(undefined, self);
  turret thread _id_C27484CA7994B7D0();
  thread _id_755AEBB2552F8720(turret, marker);
  thread _id_D02D69714FBAFFC1(turret);
  thread _id_389EBC5025C28934(turret);
  thread _id_14AA40AE092FE7B1(turret);
  thread _id_7F22F5F0AE012BD4(turret);
  thread _id_35A05B3758E712CD(turret);
  thread _id_ABAE0285AFE8AA60(turret);
  turret notify("turret_place_successful");
  thread _id_A3AFDDCD4AA1EBF8(turret);
}

_id_A3AFDDCD4AA1EBF8(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level endon("game_ended");

  for(;;) {
    wait 1;
    targetent = turret gettargetentity();

    if(!isDefined(targetent)) {
      contents = ["physicscontents_vehicle", "physicscontents_item"];
      _id_A018E61307A26F1A = scripts\mp\utility\entity::getentitiesinradius(turret.origin, 100000, undefined, undefined, physics_createcontents(contents));
      _id_6D3E2E28D8D8C23F = [];

      foreach(ent in _id_A018E61307A26F1A) {
        if(isDefined(ent.isairkillstreak) && ent.isairkillstreak == 1 && ent.team != turret.team)
          _id_6D3E2E28D8D8C23F[_id_6D3E2E28D8D8C23F.size] = ent;
      }

      _id_75A5140E267338B3 = ["chopper_gunner", "counter_uav", "uav"];
      targetent = undefined;

      foreach(category in _id_75A5140E267338B3) {
        foreach(ent in _id_6D3E2E28D8D8C23F) {
          if(ent.streakname == category)
            targetent = ent;

          break;
        }

        if(isDefined(targetent)) {
          break;
        }
      }

      if(isDefined(targetent))
        turret settargetentity(targetent);

      turret._id_149B5B3B30C502F0 = targetent;
    }
  }
}

_id_74CE833622F356F8(turret, player) {
  _id_B8BCDC58B18DF00D = 0;

  if(isDefined(turret) && isDefined(turret._id_149B5B3B30C502F0) && isDefined(turret._id_CB4684B16AE2AFE4) && istrue(turret._id_CB4684B16AE2AFE4)) {
    _id_D58E3CC99EDAEF16 = distance(turret.origin, turret._id_149B5B3B30C502F0.origin);

    if(_id_D58E3CC99EDAEF16 <= level._id_7D48025EA3734FA2[turret.turrettype]._id_624E594FAF861476) {
      _id_74633421FC7FBF27 = turret gettagorigin("tag_flash");
      _id_0429AAE2E6E20F85 = _id_74633421FC7FBF27;
      _id_85FA3CDCB19D2A9C = turret._id_149B5B3B30C502F0.origin;
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("chopper_gunner_proj_mp"), _id_0429AAE2E6E20F85, _id_85FA3CDCB19D2A9C, player, turret._id_149B5B3B30C502F0);
      _id_D758F8009BB2AB35 = (0, 0, 0);
      _id_A6C20B9563F43F6C = turret._id_149B5B3B30C502F0._id_E54550E04B65EF78;
      _id_A6C20B9563F43F6C = scripts\engine\utility::ter_op(!isDefined(_id_A6C20B9563F43F6C), "tag_deathfx", _id_A6C20B9563F43F6C);
      _id_C73607C288AD6F7C = undefined;
      hastag = turret._id_149B5B3B30C502F0 tagexists(_id_A6C20B9563F43F6C);

      if(hastag)
        _id_C73607C288AD6F7C = turret._id_149B5B3B30C502F0 gettagorigin(_id_A6C20B9563F43F6C);

      if(isDefined(_id_C73607C288AD6F7C)) {
        _id_A125E253339EBEE8 = _id_C73607C288AD6F7C - turret._id_149B5B3B30C502F0.origin;
        _id_D758F8009BB2AB35 = rotatevectorinverted(_id_A125E253339EBEE8, turret._id_149B5B3B30C502F0.angles);
      }

      missile missile_settargetEnt(turret._id_149B5B3B30C502F0, _id_D758F8009BB2AB35);
      _id_B8BCDC58B18DF00D = 1;
    }
  }

  return _id_B8BCDC58B18DF00D;
}

_id_AD3BCD8EC77BA7A0(turret) {
  turret endon("kill_turret");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
    self notify("switched_from_minigun");

    while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp")
      waitframe();
  }

  if(isDefined(turret.moving_platform)) {
    turret.moving_platform = undefined;
    turret.moving_platform_offset = undefined;
    turret.moving_platform_angles_offset = undefined;
    turret unlink();
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  turret scripts\mp\sentientpoolmanager::unregistersentient(turret.sentientpool, turret.sentientpoolindex);
  _id_E478AC91AF0E92CB = turret getlinkedchildren();

  foreach(child in _id_E478AC91AF0E92CB) {
    if(isDefined(child))
      child unlink();
  }

  if(isDefined(turret.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);

    turret.minimapid = undefined;
  }

  turret.colmodel unlink();
  turret.colmodel hide();
  _id_2239198274531067(turret);
  turret hide();
  turret.carriedby = self;
  turret notify("carried");
  turret playSound("sentry_pickup");
  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_sentry_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_sentry_mp");
  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(0);
  marker = _id_159A8E5FA750161C(turret, turret.streakinfo, 1, 2);

  if(!isDefined(marker)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
    return 0;
  }

  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
  _id_56D5F8C1988C64EB(turret, marker);
}

_id_6B113BCA399DF0C9(_id_EAF9953FB1B05AC6) {
  if(istrue(_id_EAF9953FB1B05AC6))
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self.lastdroppableweaponobj);
  else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);

  scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_sentry_mp");
}

_id_2239198274531067(turret) {
  turret setdefaultdroppitch(30);
  turret setmode(level._id_7D48025EA3734FA2[turret.turrettype].sentrymodeoff);
  turret.useownerobj _meth_DFB78B3E724AD620(0);
  turret.useownerobj unlink();
}

_id_755AEBB2552F8720(turret, marker) {
  turret endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(marker.visual))
    marker.visual delete();
}

_id_C118279C97AE457F(turret, useobj) {
  if(isDefined(turret)) {
    turret endon("kill_turret");
    turret endon("carried");
  }

  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    useobj disableplayeruse(player);
  }
}

_id_D02D69714FBAFFC1(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    turret.useownerobj waittill("trigger", player);

    if(player != self) {
      continue;
    }
    if(!player _id_AABCEA95D6584154()) {
      continue;
    }
    if(istrue(player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");

      continue;
    }

    turret.useownerobj _meth_DFB78B3E724AD620(0);
    turret setmode(level._id_7D48025EA3734FA2[turret.turrettype].sentrymodeoff);
    self.placedsentries[turret.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[turret.turrettype], turret);
    thread _id_AD3BCD8EC77BA7A0(turret);
  }
}

_id_CD59A28CBD743B74(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player waittill("spawned_player");
    turret.useownerobj disableplayeruse(player);
  }
}

_id_919C2CB7CF831EB8(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    if(level.teambased) {
      if(player.team != self.team)
        continue;
    } else if(player != self)
      continue;
  }

  thread _id_B78B342431EEF863(turret);

  for(;;) {
    turret.dismantleobj waittill("trigger", player);
    turret notify("kill_turret", 0, 1);
    break;
  }
}

_id_389EBC5025C28934(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");
  _id_3073D3141C30BBE5(turret);
}

_id_B78B342431EEF863(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(level.teambased) {
      if(player.team != self.team)
        continue;
    }
  }
}

_id_BFDCEC13005413A5(data) {
  if(isDefined(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("disabled_sentry_gun");
  }

  _id_E43A156FF3CDAF09();
}

_id_4D4513E6AFB21E9C(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  _id_E43A156FF3CDAF09();
}

_id_E43A156FF3CDAF09() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level._id_7D48025EA3734FA2[self.turrettype].sentrymodeoff);
    self laseroff();
  } else {
    self turretfireenable();
    self setmode(level._id_7D48025EA3734FA2[self.turrettype].sentrymodeon);
  }
}

_id_14AA40AE092FE7B1(turret) {
  turret endon("carried");
  turret waittill("kill_turret", _id_0B2797481A55C620, _id_4FAC8B8CE36E09F1);

  if(isDefined(self)) {
    self.placedsentries[turret.turrettype] = scripts\engine\utility::array_remove(self.placedsentries[turret.turrettype], turret);
    _id_2239198274531067(turret);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);

    turret.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(turret.streakinfo);
  }

  turret _id_70C8684C2C29BF59("destroyed");
  turret setturretowner(undefined);

  if(!istrue(_id_0B2797481A55C620)) {
    turret playSound("sentry_explode_smoke");
    turret setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("explode", "regular");
  } else
    turret setscriptablepartstate("explode", "violent");

  turret playSound("mp_equip_destroyed");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](turret.streakinfo);

  if(isDefined(turret.killcament))
    turret.killcament delete();

  if(isDefined(turret.useownerobj))
    turret.useownerobj delete();

  if(isDefined(turret.useotherobj))
    turret.useotherobj delete();

  if(isDefined(turret.colmodel))
    turret.colmodel delete();

  if(isDefined(turret.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);

    turret.minimapid = undefined;
  }

  wait 0.2;
  turret delete();
}

_id_7F22F5F0AE012BD4(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(turret.timeout > 0) {
    turret.timeout = turret.timeout - 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  while(turret._id_8F7BA18BC776BE33 > 0)
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(turret.streakinfo.streakname, "destroyed_" + turret.streakinfo.streakname);
  turret notify("kill_turret", 0, 0);
}

_id_35A05B3758E712CD(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  turret notify("kill_turret", 0, 0);
}

_id_ABAE0285AFE8AA60(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level waittill("game_ended");
  turret notify("kill_turret", 0, 0);
}

_id_70C8684C2C29BF59(type) {
  turretmodel = undefined;

  if(type == "placed")
    turretmodel = level._id_7D48025EA3734FA2[self.turrettype].modelbaseground;
  else
    turretmodel = level._id_7D48025EA3734FA2[self.turrettype].modeldestroyedground;

  self setModel(turretmodel);
}

_id_973E8BBEDDC12392(_id_630AF5192659DD3B, player) {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  self.momentum = 0;

  for(;;) {
    self waittill("turretstatechange");

    if(self isfiringturret()) {
      self laseron();
      thread _id_D335A0D787014372(_id_630AF5192659DD3B, player);
      continue;
    }

    self laseroff();
    _id_BB2747086C8BE5E4();
    thread _id_471AF36224E1CEB2();
  }
}

_id_0D60FFC368C740A5() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
}

_id_230DBF81556410E5(_id_630AF5192659DD3B) {
  thread _id_0D60FFC368C740A5();

  while(self.momentum < _id_630AF5192659DD3B.spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

_id_BB2747086C8BE5E4() {
  self.momentum = 0;
}

_id_D335A0D787014372(_id_630AF5192659DD3B, player) {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  _id_50651DF7C1EF6241 = undefined;

  if(isDefined(_id_630AF5192659DD3B))
    _id_50651DF7C1EF6241 = _id_630AF5192659DD3B;
  else
    _id_50651DF7C1EF6241 = level._id_7D48025EA3734FA2[self.turrettype];

  _id_230DBF81556410E5(_id_50651DF7C1EF6241);
  firetime = weaponfiretime(_id_50651DF7C1EF6241.weaponinfo);

  for(;;) {
    if(self._id_8F7BA18BC776BE33 == _id_50651DF7C1EF6241._id_E843DE3404005D56)
      wait(_id_50651DF7C1EF6241._id_D06874D7F3CCF3A6);

    if(self._id_8F7BA18BC776BE33 > 0) {
      self._id_CB4684B16AE2AFE4 = 1;
      _id_B8BCDC58B18DF00D = _id_74CE833622F356F8(self, player);

      if(_id_B8BCDC58B18DF00D)
        self._id_8F7BA18BC776BE33--;
    }

    wait(_id_50651DF7C1EF6241.cooldowntime);
  }
}

_id_471AF36224E1CEB2() {
  self._id_CB4684B16AE2AFE4 = 0;
  self notify("stop_shooting");
}

turret_heatmonitor() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  overheattime = level._id_7D48025EA3734FA2[self.turrettype].overheattime;

  for(;;) {
    if(self.heatlevel > overheattime) {
      self.overheated = 1;

      while(self.heatlevel)
        wait 0.1;

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level._id_7D48025EA3734FA2[self.turrettype].fxtime);
  }
}

turret_coolmonitor() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0)
        self.heatlevel = max(0, self.heatlevel - 0.05);
      else
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
    }

    wait 0.05;
  }
}

_id_C27484CA7994B7D0() {
  self endon("death");
  self endon("carried");
  self endon("kill_turret");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }

    self playSound("sentry_gun_beep");
  }
}

_id_98C72B3604B1124D(streakinfo, _id_6152D24062D26039) {
  return scripts\mp\killstreaks\target_marker::gettargetmarker(streakinfo, _id_6152D24062D26039);
}

_id_F43B6A78213DBAE8(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  return scripts\mp\gameobjects::createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
}

_id_3073D3141C30BBE5(turret) {
  turret thread scripts\mp\damage::monitordamage(turret.maxhealth, "hitequip", ::_id_242DED3CFE2E5D3B, ::_id_6886C78F9664C089, 1);
}

_id_242DED3CFE2E5D3B(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level._id_7D48025EA3734FA2[self.turrettype];
  _id_3737240CEFE2C793 = scripts\mp\damage::onkillstreakkilled(config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);

  if(_id_3737240CEFE2C793)
    attacker notify("destroyed_equipment");

  _id_A93F9D30441FFED1 = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH")
    _id_A93F9D30441FFED1 = 1;

  self notify("kill_turret", _id_A93F9D30441FFED1, 1);
}

_id_6886C78F9664C089(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, type, _id_702BFC08FABD86CB, self.maxhealth, 2, 3, 4, 12, 400);
  return _id_702BFC08FABD86CB;
}

_id_A0A5114BB65FCECD() {
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC["missile_turret"];

  if(!isDefined(_id_D442547D75DFFD09))
    _id_D442547D75DFFD09 = spawnStruct();

  level._id_7D48025EA3734FA2["missile_turret"] = spawnStruct();
  level._id_7D48025EA3734FA2["missile_turret"].health = 999999;
  level._id_7D48025EA3734FA2["missile_turret"].maxhealth = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_925B4160B2218327, 650);
  level._id_7D48025EA3734FA2["missile_turret"].burstmin = 10;
  level._id_7D48025EA3734FA2["missile_turret"].burstmax = 20;
  level._id_7D48025EA3734FA2["missile_turret"].pausemin = 1.0;
  level._id_7D48025EA3734FA2["missile_turret"].pausemax = 1.25;
  level._id_7D48025EA3734FA2["missile_turret"].lockstrength = 6;
  level._id_7D48025EA3734FA2["missile_turret"].sentrymodeon = "sentry";
  level._id_7D48025EA3734FA2["missile_turret"].sentrymodeoff = "sentry_offline";
  level._id_7D48025EA3734FA2["missile_turret"].timeout = 75;
  level._id_7D48025EA3734FA2["missile_turret"].spinuptime = 0.65;
  level._id_7D48025EA3734FA2["missile_turret"].overheattime = 8.0;
  level._id_7D48025EA3734FA2["missile_turret"].cooldowntime = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_1D3AEF3FC310DFF4, 1.25);
  level._id_7D48025EA3734FA2["missile_turret"].fxtime = 0.3;
  level._id_7D48025EA3734FA2["missile_turret"].streakname = "missile_turret";
  level._id_7D48025EA3734FA2["missile_turret"].weaponinfo = _id_D442547D75DFFD09._id_661E446067D68053;
  level._id_7D48025EA3734FA2["missile_turret"].playerweaponinfo = _id_D442547D75DFFD09._id_661E446067D68053;
  level._id_7D48025EA3734FA2["missile_turret"].scriptable = "ks_sentry_turret_mp";
  level._id_7D48025EA3734FA2["missile_turret"].modelbasecover = "killstreak_wm_mounted_turret";
  level._id_7D48025EA3734FA2["missile_turret"].modelbaseground = "weapon_wm_mg_sentry_turret";
  level._id_7D48025EA3734FA2["missile_turret"].modeldestroyedcover = "killstreak_wm_mounted_turret";
  level._id_7D48025EA3734FA2["missile_turret"].modeldestroyedground = "weapon_wm_mg_sentry_turret";
  level._id_7D48025EA3734FA2["missile_turret"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level._id_7D48025EA3734FA2["missile_turret"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level._id_7D48025EA3734FA2["missile_turret"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level._id_7D48025EA3734FA2["missile_turret"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level._id_7D48025EA3734FA2["missile_turret"].headicon = 1;
  level._id_7D48025EA3734FA2["missile_turret"].teamsplash = "used_sentry_gun";
  level._id_7D48025EA3734FA2["missile_turret"].destroyedsplash = "callout_destroyed_sentry_gun";
  level._id_7D48025EA3734FA2["missile_turret"].shouldsplash = 1;
  level._id_7D48025EA3734FA2["missile_turret"].votimeout = "sentry_gun_teamleader_crash";
  level._id_7D48025EA3734FA2["missile_turret"].vodestroyed = "sentry_gun_teamleader_crash";
  level._id_7D48025EA3734FA2["missile_turret"].scorepopup = "destroyed_sentry";
  level._id_7D48025EA3734FA2["missile_turret"].lightfxtag = "tag_fx";
  level._id_7D48025EA3734FA2["missile_turret"].iskillstreak = 1;
  level._id_7D48025EA3734FA2["missile_turret"].headiconoffset = (0, 0, 75);
  level._id_7D48025EA3734FA2["missile_turret"]._id_E843DE3404005D56 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_B870B20BAEDE47AE, 8);
  level._id_7D48025EA3734FA2["missile_turret"]._id_624E594FAF861476 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_0FABD4037E21EAAE, 100000.0);
  level._id_7D48025EA3734FA2["missile_turret"]._id_D06874D7F3CCF3A6 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_0BA2CE898BFB0A9E, 3.0);
}

_id_AABCEA95D6584154() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    return 0;

  if(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon()))
    return 0;

  return 1;
}
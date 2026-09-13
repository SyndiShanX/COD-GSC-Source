/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\gunship_cp.gsc
*************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "findBoxCenter", ::gunship_findboxcenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "getBombingPoint", ::gunship_getbombingpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "br_respawn", ::gunship_startbrrespawn);

  if(!scripts\cp\utility::is_specops_gametype())
    scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "assignTargetMarkers", ::gunship_assigntargetmarkers);
}

gunship_findboxcenter(_id_3C59120EE220BF08, _id_C978C20E8E5AA292) {
  return _id_116171939929AF39::findboxcenter(_id_3C59120EE220BF08, _id_C978C20E8E5AA292);
}

gunship_getbombingpoints(_id_01E2777328B6B536, _id_0DB715BCDE296BEC, _id_A0EDD3F59D938FB1) {
  _id_953968CE39783E28 = [];
  _id_01E2777328B6B536 = _id_01E2777328B6B536 - anglesToForward(self.angles) * 100;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0DB715BCDE296BEC; _id_AC0E594AC96AA3A8++) {
    _id_A0A41BA05E16FFE6 = randomint(_id_A0EDD3F59D938FB1);
    _id_9E5D403038E4C071 = randomint(360);
    x = _id_01E2777328B6B536[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
    y = _id_01E2777328B6B536[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
    z = _id_01E2777328B6B536[2];
    point = (x, y, z);
    trace = scripts\engine\trace::ray_trace(point + (0, 0, 2000), point - (0, 0, 10000), level.players);

    if(isDefined(trace["position"]))
      point = trace["position"];

    _id_953968CE39783E28[_id_953968CE39783E28.size] = point;
  }

  return _id_953968CE39783E28;
}

gunship_startbrrespawn(player) {
  if(isDefined(player) && isPlayer(player)) {
    if(!istrue(player.fauxdead))
      player.shouldskiplaststand = 0;
  }
}

gunship_assigntargetmarkers(gunner) {
  _id_2CD52BBC2A67B7CF = [];
  _id_FF93381949523976 = [];
  _id_4496855DEC276732 = [];
  _id_01D4621C77C9108F = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  _id_45D25409ACB2D4F9 = level.players;
  _id_EBA1C5743194000D = [];

  if(isDefined(level.killstreak_additional_targets)) {
    foreach(target in level.killstreak_additional_targets)
    _id_EBA1C5743194000D = scripts\engine\utility::array_add(_id_EBA1C5743194000D, target);
  }

  _id_4496855DEC276732 = scripts\engine\utility::array_combine(_id_EBA1C5743194000D, _id_01D4621C77C9108F, _id_45D25409ACB2D4F9);

  foreach(enemy in _id_4496855DEC276732) {
    if(level.teambased && enemy.team == self.team) {
      continue;
    }
    if(enemy == self.owner) {
      continue;
    }
    if(enemy scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    _id_2CD52BBC2A67B7CF[_id_2CD52BBC2A67B7CF.size] = enemy;
  }

  foreach(player in _id_45D25409ACB2D4F9) {
    if(level.teambased && player.team != self.team) {
      continue;
    }
    _id_FF93381949523976[_id_FF93381949523976.size] = player;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, _id_2CD52BBC2A67B7CF, self.owner, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, _id_FF93381949523976, self.owner, 1, 1);
  level thread gunship_assignedtargetmarkers_onnewai(self.enemytargetmarkergroup, 0);
}

gunship_assignedtargetmarkers_onnewai(_id_4226C12910D867D4, _id_262F4B55AA151DE1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + _id_4226C12910D867D4);

  for(;;) {
    level waittill("spawned_group_soldier", soldier);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(soldier, _id_4226C12910D867D4, _id_262F4B55AA151DE1);
  }
}

enemygunship_spawngunship(_id_2ACD6736C2BC3EDB, _id_A2C5157971449C35, _id_53453E9C96325450, _id_E5BD279D3767139F, _id_45ACCFF1681E0276, _id_B4A73EF4935724BE) {
  if(!istrue(_id_B4A73EF4935724BE)) {
    if(isDefined(_id_2ACD6736C2BC3EDB) && (isint(_id_2ACD6736C2BC3EDB) || isfloat(_id_2ACD6736C2BC3EDB)))
      wait(_id_2ACD6736C2BC3EDB);

    if(isDefined(_id_A2C5157971449C35) && isstring(_id_A2C5157971449C35))
      level waittill(_id_A2C5157971449C35);
  }

  _id_8945C22A67231E20 = randomint(360);
  _id_0234183E65CC4B94 = 15000;

  if(isDefined(_id_E5BD279D3767139F))
    _id_0234183E65CC4B94 = _id_E5BD279D3767139F;

  xoffset = cos(_id_8945C22A67231E20) * _id_0234183E65CC4B94;
  yoffset = sin(_id_8945C22A67231E20) * _id_0234183E65CC4B94;
  zoffset = 8000;

  if(isDefined(_id_45ACCFF1681E0276))
    zoffset = _id_45ACCFF1681E0276;

  _id_78AC3C5EF5263D4F = vectorNormalize((xoffset, yoffset, zoffset));
  _id_78AC3C5EF5263D4F = _id_78AC3C5EF5263D4F * zoffset;
  _id_BC737640DD23DD18 = "veh8_mil_air_acharlie130_small_east";
  center = level.gunship.origin;

  if(isDefined(_id_53453E9C96325450) && isvector(_id_53453E9C96325450)) {
    center = _id_53453E9C96325450;
    level.gunship.origin = _id_53453E9C96325450;
  }

  _id_74A3B0688680D1FB = spawn("script_model", center);
  _id_74A3B0688680D1FB setModel("tag_origin");
  _id_74A3B0688680D1FB.team = "axis";
  gunship = spawn("script_model", center);
  gunship setModel(_id_BC737640DD23DD18);
  gunship setCanDamage(1);
  gunship.currenthealth = 1000;
  gunship.maxhealth = gunship.currenthealth;
  gunship.health = 9999999;
  gunship.owner = _id_74A3B0688680D1FB;
  gunship.timeout = 6669;
  gunship.currentdamagestate = 0;
  gunship.team = "axis";
  gunship.ogflaresreservecount = 2;
  gunship.flaresreservecount = 2;
  gunship scriptmoveroutline();
  gunship scriptmoverthermal();
  minimapid = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    minimapid = gunship[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", gunship.team, 1, 1, 1);

  if(isDefined(minimapid))
    objective_setshowoncompass(minimapid, 1);

  gunship.minimapid = minimapid;
  _id_74A3B0688680D1FB linkTo(level.gunship, "tag_origin");
  gunship linkTo(level.gunship, "tag_origin", _id_78AC3C5EF5263D4F, (0, _id_8945C22A67231E20 + 90, -30));
  _id_74A3B0688680D1FB.pers = [];
  gunship.streakinfo = _id_74A3B0688680D1FB scripts\cp_mp\utility\killstreak_utility::createstreakinfo("gunship", _id_74A3B0688680D1FB);
  gunship thread enemygunship_watchdamage();
  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_watchgameend(undefined);

  if(level.script == "cp_arms_dealer")
    gunship thread enemygunship_watchexfilsequencestart(undefined, 1);
  else
    gunship thread enemygunship_watchexfilsequencestart(undefined);

  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_linklightfxent();
  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_linkwingfxents();
  gunship thread scripts\cp_mp\killstreaks\gunship::gunship_trackvelocity();
  gunship thread scripts\cp\cp_flares::flares_monitor(gunship.flaresreservecount);
  gunship thread enemygunship_watchtargets();
  _id_74502A9E0EF1F19C::add_to_special_lockon_target_list(gunship);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger"))
    gunship thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::enemygunship_handlemissiledetection);

  gunship playLoopSound("iw8_ks_ac130_lp");
}

play_fake_vo_for_gunship() {
  _id_5AB0DC648937D4EA = "stat_7966E41DE8CB58E2";
  _id_93A0836A10E99C34 = self;
  _id_4D0CE2D79BF45D54 = _id_93A0836A10E99C34;
  _id_A542114A7EE5ABB5 = _id_4D0CE2D79BF45D54 scripts\cp_mp\calloutmarkerping::calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(_id_5AB0DC648937D4EA);
  _id_A53CEB4A7EDF2F4C = _id_4D0CE2D79BF45D54 scripts\cp_mp\calloutmarkerping::calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias3d(_id_5AB0DC648937D4EA);
  _id_C197335AAD9F5E31 = soundexists(_id_A542114A7EE5ABB5);
  _id_C1934D5AAD9BA188 = soundexists(_id_A53CEB4A7EDF2F4C);
  _id_196FFC81C8206C2A = scripts\cp_mp\calloutmarkerping::calloutmarkerpingvo_getmaxsoundaliaslength(_id_C197335AAD9F5E31, _id_A542114A7EE5ABB5, _id_C1934D5AAD9BA188, _id_A53CEB4A7EDF2F4C);
  _id_57D0946B275FEA34 = 1;

  if(istrue(_id_57D0946B275FEA34)) {
    _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](self.team, 1);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6) {
      if(_id_4D0CE2D79BF45D54 == _id_F0EA4030349A33D5) {
        if(_id_C197335AAD9F5E31)
          _id_4D0CE2D79BF45D54 playsoundtoplayer(_id_A542114A7EE5ABB5, _id_F0EA4030349A33D5);

        continue;
      }

      if(_id_C1934D5AAD9BA188)
        _id_4D0CE2D79BF45D54 playsoundtoplayer(_id_A53CEB4A7EDF2F4C, _id_F0EA4030349A33D5);
    }
  }
}

enemygunship_watchexfilsequencestart(gunner, _id_FA9457CAF94A8D20) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(istrue(_id_FA9457CAF94A8D20)) {
    for(;;) {
      level waittill("exfil_sequence_started");

      if(istrue(level.bloadinghvt)) {
        continue;
      }
      break;
    }
  } else
    level waittill("exfil_sequence_started");

  thread scripts\cp_mp\killstreaks\gunship::gunship_leave(gunner);
}

enemygunship_watchdamage(gunner) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 8192);
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(isDefined(level.teambased) && isPlayer(attacker) && attacker.team == self.team) {
      continue;
    }
    if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }
    if(isPlayer(attacker)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
        attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
    }

    thread run_suppression_logic(7);
    self.wasdamaged = 1;
    _id_702BFC08FABD86CB = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage"))
      _id_702BFC08FABD86CB = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, smeansofdeath, damage, self.maxhealth, 4, 5, 6);

    self.damagetaken = self.damagetaken + _id_702BFC08FABD86CB;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(self.currenthealth <= 500 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
    } else if(self.currenthealth <= 250 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_light", "off");
      self setscriptablepartstate("body_damage_medium", "on");
    } else if(self.currenthealth <= 0 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("body_damage_medium", "off");
      self setscriptablepartstate("contrails", "off");
      thread scripts\cp_mp\killstreaks\gunship::gunship_startengineblowoutfx();
    }

    if(self.damagetaken >= self.maxhealth) {
      streakname = self.streakinfo.streakname;
      _id_D95DA0355CF4CCB4 = undefined;
      _id_92D090CE35588AD2 = "destroyed_" + streakname;
      leaderdialog = undefined;
      _id_6342E2DA1DC12454 = "callout_destroyed_" + streakname;
      _id_DC695757F69ED065 = 1;

      if(isPlayer(attacker)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
          thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](_id_6342E2DA1DC12454, attacker);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled"))
        _id_3737240CEFE2C793 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](streakname, attacker, objweapon, _id_D95DA0355CF4CCB4, damage, _id_92D090CE35588AD2, leaderdialog, _id_6342E2DA1DC12454, _id_DC695757F69ED065);

      self.owner delete();
      level.disableannouncer = 1;
      thread scripts\cp_mp\killstreaks\gunship::gunship_crash(8, gunner);
    }
  }
}

run_suppression_logic(delay) {
  self notify("run_suppression_logic");
  self endon("run_suppression_logic");
  self endon("death");
  level endon("game_ended");
  self.suppressedgunner = 1;
  childthread removesuppressioneffectsaftertimeout(delay);
}

removesuppressioneffectsaftertimeout(timeout) {
  self notify("removeSuppressionEffectsAfterTimeout");
  self endon("removeSuppressionEffectsAfterTimeout");
  self endon("death");
  level endon("game_ended");
  wait(timeout);
  self.suppressedgunner = undefined;
}

enemygunship_handlemissiledetection(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](_id_6D87867F43E1D612);

      _id_6D87867F43E1D612 scripts\cp_mp\killstreaks\gunship::gunship_playflaresfx(_id_5991F0E5DA9F9BD5);

      if(isDefined(_id_6D87867F43E1D612.owner) && isPlayer(_id_6D87867F43E1D612.owner))
        _id_6D87867F43E1D612 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_flares", 1);

      newtarget = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
        newtarget = _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    } else if(_id_6B40B4C28ABE0A05 < 300 && _id_6D87867F43E1D612.flaresreservecount <= 0) {
      _id_6D87867F43E1D612 thread scripts\cp_mp\killstreaks\gunship::gunship_playfakebodyexplosion();
      _id_CBBB045B041FFEBE = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner) && isPlayer(self.owner))
        _id_6D87867F43E1D612 dodamage(_id_CBBB045B041FFEBE, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      else
        _id_6D87867F43E1D612 dodamage(_id_CBBB045B041FFEBE, _id_6D87867F43E1D612.origin, undefined, self, "MOD_EXPLOSIVE", self.weapon_name);

      self delete();
    }

    waitframe();
  }
}

gunship_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_missile_lock");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

enemygunship_watchtargets(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    _id_C26B9F481753E189 = [];

    foreach(player in level.players) {
      if(!isDefined(player) || !player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(level.teambased && player.team == self.team) {
        continue;
      }
      if(istrue(player.respawn_in_progress)) {
        continue;
      }
      if(istrue(player.inlaststand)) {
        continue;
      }
      if(player isskydiving()) {
        continue;
      }
      if(isDefined(player.vehicle) && isent(player.vehicle)) {} else if(player scripts\cp\utility::is_indoors(player))
        continue;
      else if(!sighttracepassed(self.origin, player.origin, 0, undefined, 1)) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye") || player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_ghost")) {
          if(player.stealthtimeelapsed <= 3.0) {
            player.stealthtimeelapsed = player.stealthtimeelapsed + 0.05;
            continue;
          } else
            player.stealthtimeelapsed = 0.0;
        }
      }

      _id_C26B9F481753E189 = enemygunship_getnearbytargets(player);
      break;
      wait 0.05;
    }

    if(_id_C26B9F481753E189.size > 0 && _id_C26B9F481753E189.size < 2) {
      foreach(guy in _id_C26B9F481753E189) {
        if(isPlayer(guy)) {
          guy thread play_fake_vo_for_gunship();
          thread enemygunship_firerounds(guy);
          guy thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_single_spotted");
          self notify("gunship_shoot_debug_location");
        }
      }
    } else if(_id_C26B9F481753E189.size >= 2) {
      foreach(guy in _id_C26B9F481753E189) {
        if(isPlayer(guy)) {
          thread enemygunship_firerounds(guy);
          guy thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship", "gunship_multi_spotted");
          self notify("gunship_shoot_debug_location");
        }
      }
    }

    wait(randomintrange(3, 15));
  }
}

enemygunship_getnearbytargets(_id_0050ED806F04C63D) {
  _id_69338CA0BF9D8D91 = scripts\common\utility::playersinsphere(_id_0050ED806F04C63D.origin, 666);
  _id_BC19A29ED084D79C = [];

  foreach(player in _id_69338CA0BF9D8D91) {
    if(level.teambased && player.team != _id_0050ED806F04C63D.team) {
      continue;
    }
    _id_BC19A29ED084D79C[_id_BC19A29ED084D79C.size] = player;
  }

  return _id_BC19A29ED084D79C;
}

enemygunship_watchplanedistance() {
  self endon("death");
  self.owner endon("gunship_switch_debug_weapon");
  self.owner endon("gunship_shoot_debug_location");

  for(;;) {
    trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 40000), self);
    waitframe();
  }
}

enemygunship_watchdebuglocation(tagname, _id_22C53C353885FE59) {
  self endon("death");

  for(;;) {
    _id_55C90B7FE840F6BB = self.origin;

    if(isDefined(tagname))
      _id_55C90B7FE840F6BB = self gettagorigin(tagname);

    if(istrue(_id_22C53C353885FE59)) {
      _id_2E7CD5CF380E26B6 = anglesToForward(self.angles);
      _id_56F3B0DA31462A71 = anglestoright(self.angles);
      _id_36A9564BF283F04C = anglestoup(self.angles);
    }

    wait 0.05;
  }
}

enemygunship_firerounds(target) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self notify(target.name + "enemyGunship_fireRounds");
  self endon(target.name + "enemyGunship_fireRounds");

  if(!isDefined(self.currentgunshipweapon)) {
    self.weaponstocycle = ["gunship_105mm_mp", "gunship_40mm_mp", "gunship_25mm_mp"];
    self.currentdebugweaponindex = 0;
    self.currentdebugweapon = self.weaponstocycle[0];
    self.currentgunshipweapon = self.currentdebugweapon;
  }

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_2("gunship_switch_debug_weapon", "gunship_shoot_debug_location");

    if(!isDefined(result)) {
      waitframe();
      continue;
    }

    if(result == "gunship_switch_debug_weapon") {
      self.currentdebugweaponindex++;

      if(self.currentdebugweaponindex > 2)
        self.currentdebugweaponindex = 0;

      self.currentdebugweapon = self.weaponstocycle[self.currentdebugweaponindex];
      self.currentgunshipweapon = self.currentdebugweapon;
      continue;
    }

    if(istrue(self.suppressedgunner)) {
      waitframe();
      continue;
    }

    _id_4D9C1A0E282C25EA = enemygunship_getshotgoal(target);
    thread enemygunship_attackgoal(_id_4D9C1A0E282C25EA, self.currentdebugweapon);
  }
}

enemygunship_getfiretime(weapon) {
  return weaponfiretime(weapon);
}

enemygunship_getshotgoal(target) {
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_22C4300CE1D248E8 = self.origin;
  vdir = vectorNormalize(target.origin - self.origin);
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + vdir * 50000;
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, self, contentoverride);
  endpos = trace["position"];
  return endpos;
}

enemygunship_attackgoal(_id_4D9C1A0E282C25EA, currentdebugweapon) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("gunship_shoot_debug_location");
  self endon("gunship_switch_debug_weapon");

  for(;;) {
    _id_04F04B15053655BA = weaponmaxammo(currentdebugweapon);

    while(_id_04F04B15053655BA > 0) {
      if(istrue(self.suppressedgunner)) {
        waitframe();
        continue;
      }

      _id_0E84B952249E4ABE = undefined;
      _id_BF366EB7073782AF = scripts\cp_mp\killstreaks\toma_strike::tomastrike_getrandombombingpoint(_id_4D9C1A0E282C25EA, 333);
      _id_0E84B952249E4ABE = _id_BF366EB7073782AF.point;
      owner = undefined;
      projectile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(currentdebugweapon), self.origin, _id_0E84B952249E4ABE, owner);
      projectile.weapon_name = currentdebugweapon;
      projectile.team = self.team;
      _id_04F04B15053655BA--;

      if(_id_04F04B15053655BA == 0) {
        wait 1;
        self notify("gunship_switch_debug_weapon");
        _id_1AEB3C9F2E6B11B9 = level.weaponreloadtime[currentdebugweapon] + getdvarint("dvar_C38108A3A770D64C", 0);

        while(_id_1AEB3C9F2E6B11B9 > 0) {
          _id_1AEB3C9F2E6B11B9--;
          wait 1;
        }
      }

      wait(enemygunship_getfiretime(currentdebugweapon));
    }
  }
}

enemygunship_watchweaponimpact(projectile) {}

enemygunship_updatedebugflashlight(_id_4D9C1A0E282C25EA) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("gunship_switch_debug_weapon");
  self.owner endon("gunship_shoot_debug_location");

  for(;;) {
    self.flashlight.angles = vectortoangles(_id_4D9C1A0E282C25EA - self.origin);
    waitframe();
  }
}
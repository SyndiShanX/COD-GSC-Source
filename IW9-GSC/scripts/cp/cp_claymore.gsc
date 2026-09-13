/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_claymore.gsc
***********************************************/

claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw9/core/equipment/vfx_equip_claymore_trigger.vfx");
}

claymore_use(grenade) {
  self endon("death");
  self endon("disconnect");
  grenade endon("death");
  grenade.exploding = 1;
  grenade.owner_name = self.name;
  thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, grenade);
  _id_F99216CEE573EA7E = spawnStruct();
  _id_F99216CEE573EA7E.throwspeedforward = 100;
  _id_F99216CEE573EA7E.throwspeedup = -50;
  _id_F99216CEE573EA7E.castdivisions = 3;
  _id_F99216CEE573EA7E.castmaxtime = 0.5;
  _id_F99216CEE573EA7E.castdetail = 1;
  _id_F99216CEE573EA7E.plantmaxtime = 0.5;
  _id_F99216CEE573EA7E.plantmaxroll = 15;
  _id_F99216CEE573EA7E.plantmindistbeloweye = 12;
  _id_F99216CEE573EA7E.plantmaxdistbelowownerfeet = 20;
  _id_F99216CEE573EA7E.plantmindisteyetofeet = 45;
  _id_F99216CEE573EA7E.plantnormalcos = 0.342;
  _id_F99216CEE573EA7E.plantoffsetz = 3;
  _id_129FA79CDE973B37 = scripts\cp\cp_equipment::plant(grenade, _id_F99216CEE573EA7E);

  if(!istrue(_id_129FA79CDE973B37)) {
    grenade.owner notify("pickup_equipment", grenade.weapon_name);
    grenade delete();
  } else {
    _id_BF8E5F003146AF44 = grenade getlinkedparent();

    if(isDefined(_id_BF8E5F003146AF44))
      grenade _id_74502A9E0EF1F19C::explosivehandlemovers(_id_BF8E5F003146AF44);

    grenade.exploding = 0;
    grenade thread claymore_plant();
  }
}

claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  if(isDefined(self.owner) && isPlayer(self.owner))
    self.owner endon("disconnect");

  owner = self.owner;
  thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    owner _id_74502A9E0EF1F19C::onlethalequipmentplanted(self, "claymore_mp");
    thread _id_74502A9E0EF1F19C::monitordisownedequipment(owner, self);
  } else
    level thread _id_74502A9E0EF1F19C::add_to_mine_list(self);

  self missilethermal();
  self missileoutline();

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self setentityowner(owner);
    self setotherent(owner);
  }

  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread _id_74502A9E0EF1F19C::minedamagemonitor();
  thread claymore_explodeonnotify();
  thread claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);
  owner setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  wait 1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  thread claymore_watchfortrigger();
}

claymore_watchfortrigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);

  for(;;) {
    self waittill("trigger_grenade", _id_F9B008542CD70A05);

    if(istrue(self.stunned)) {
      continue;
    }
    foreach(ent in _id_F9B008542CD70A05) {
      if(isDefined(ent.classname)) {
        if(ent.classname == "script_vehicle") {
          if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(ent, self)) {
            continue;
          }
          scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(ent, self);
          break;
        }

        if(ent.classname == "agent" || ent.classname == "player") {
          if(!isPlayer(ent) && !isagent(ent)) {
            continue;
          }
          if(!isalive(ent)) {
            continue;
          }
          forward = anglesToForward(self.angles);
          up = anglestoup(self.angles);
          _id_2CC97E113610CA14 = self.origin + up * 0;
          ignorelist = get_mine_ignore_list();
          _id_AD283A45677A1EA3 = ent gettagorigin("j_mainroot");
          _id_44060504F23C16AF = [_id_AD283A45677A1EA3];
          _id_340D59422336E85A = _id_2CC97E113610CA14 - _id_AD283A45677A1EA3;

          if(vectordot(_id_340D59422336E85A, (0, 0, 1)) >= 0)
            _id_44060504F23C16AF[_id_44060504F23C16AF.size] = ent gettagorigin("j_spineupper");
          else
            _id_44060504F23C16AF[_id_44060504F23C16AF.size] = ent.origin;

          _id_5C00DD368E0AC921 = 0;

          foreach(_id_A00164B06F60F5E6 in _id_44060504F23C16AF) {
            _id_340D59422336E85A = _id_A00164B06F60F5E6 - self.origin;
            _id_CC00B910BD1D69C8 = vectordot(_id_340D59422336E85A, forward);

            if(_id_CC00B910BD1D69C8 > 90) {
              continue;
            }
            _id_69211973F7D7BBD6 = vectordot(_id_340D59422336E85A, up);

            if(abs(_id_69211973F7D7BBD6) > 32) {
              continue;
            }
            _id_A3D051EF761EFD24 = vectorNormalize(_id_340D59422336E85A);
            _id_74876E67651C79A6 = vectordot(_id_A3D051EF761EFD24, forward);

            if(_id_74876E67651C79A6 < 0.86602) {
              continue;
            }
            _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_A00164B06F60F5E6, contents, ignorelist, 0, "physicsquery_closest", 1);

            if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
              continue;
            }
            _id_5C00DD368E0AC921 = 1;
            thread claymore_trigger(ent);
          }

          if(_id_5C00DD368E0AC921) {
            break;
          }
        }
      }
    }
  }
}

get_mine_ignore_list() {
  ignorelist = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(struct in level.dynamicladders)
    ignorelist[ignorelist.size] = struct.ents[0];
  }

  linkedents = self getlinkedchildren(1);

  if(!isDefined(linkedents))
    linkedents = [];

  linkedents[linkedents.size] = self getlinkedparent();

  foreach(linkedent in linkedents) {
    if(isDefined(linkedent) && linkedent.classname == "grenade")
      ignorelist[ignorelist.size] = linkedent;
  }

  return ignorelist;
}

claymore_trigger(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  _id_74502A9E0EF1F19C::explosivetrigger(ent, 0.3);
  thread claymore_explode(self.owner, ent);
}

claymore_explode(attacker, _id_95938587DB4F6823) {
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();

  if(isDefined(self.useobj))
    self.useobj delete();

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isDefined(owner.plantedlethalequip))
    owner.plantedlethalequip = scripts\engine\utility::array_remove(owner.plantedlethalequip, self);

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, forward, up);
  owner = scripts\engine\utility::ter_op(isent(self.owner), self.owner, undefined);
  self radiusdamage(self.origin, 75, 1000, 200, owner, "MOD_EXPLOSIVE", "claymore_radial_mp");
  level notify("grenade_exploded_during_stealth", self.origin, "claymore_mp", self.owner_name);
  _id_310236DBF257FBB5 = getaiarrayinradius(self.origin, 2048, "axis");

  foreach(ai in _id_310236DBF257FBB5) {
    ai aieventlistenerevent("combat", _id_95938587DB4F6823, self.origin);

    if(isDefined(_id_95938587DB4F6823) && isPlayer(_id_95938587DB4F6823))
      ai getenemyinfo(_id_95938587DB4F6823);
  }

  if(isDefined(_id_95938587DB4F6823) && isPlayer(_id_95938587DB4F6823)) {
    _id_95938587DB4F6823._id_230A3287F9AD2965 = 1;
    _id_95938587DB4F6823.shouldskipdeathsshield = 1;
  }

  level notify("trigger_reinforcements_if_applicable");
  earthquake(0.45, 0.7, self.origin, 800);
  self detonate();
}

_id_6C884EEE24235C94(attacker, _id_95938587DB4F6823) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();

  if(isDefined(self.useobj))
    self.useobj delete();

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isDefined(owner.plantedlethalequip))
    owner.plantedlethalequip = scripts\engine\utility::array_remove(owner.plantedlethalequip, self);

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, forward, up);
  level notify("grenade_exploded_during_stealth", self.origin, "claymore_mp", self.owner_name);
  _id_310236DBF257FBB5 = getaiarrayinradius(self.origin, 2048, "axis");

  foreach(ai in _id_310236DBF257FBB5) {
    ai aieventlistenerevent("combat", _id_95938587DB4F6823, self.origin);

    if(isDefined(_id_95938587DB4F6823) && isPlayer(_id_95938587DB4F6823))
      ai getenemyinfo(_id_95938587DB4F6823);
  }

  if(isDefined(_id_95938587DB4F6823) && isPlayer(_id_95938587DB4F6823)) {
    _id_95938587DB4F6823._id_230A3287F9AD2965 = 1;
    _id_95938587DB4F6823.shouldskipdeathsshield = 1;
  }

  level notify("trigger_reinforcements_if_applicable");
  self detonate();
}

claymore_explodeonnotify() {
  self endon("death");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  level endon("game_ended");
  self waittill("detonateExplosive", attacker);
  thread claymore_explode(attacker);
}

claymore_destroy(_id_29E6836DE56DA9DC) {
  if(!isDefined(_id_29E6836DE56DA9DC))
    _id_29E6836DE56DA9DC = 0;

  thread claymore_delete(_id_29E6836DE56DA9DC + 0.2);
  wait(_id_29E6836DE56DA9DC);
  self setscriptablepartstate("destroy", "active", 0);
}

claymore_destroyonemp() {
  self endon("death");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  level endon("game_ended");

  for(;;) {
    self waittill("emp_applied", data);
    attacker = data.attacker;

    if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
      attacker notify("destroyed_equipment");
      damagefeedback = "";

      if(istrue(self.hasruggedeqp))
        damagefeedback = "hitequip";

      thread claymore_destroy();
    }
  }
}

claymore_delete(_id_CBF7BE4F62A0DDB2) {
  if(!isDefined(_id_CBF7BE4F62A0DDB2))
    _id_CBF7BE4F62A0DDB2 = 0;

  self notify("death");

  if(isDefined(self.useobj))
    self.useobj delete();

  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner))
    owner.plantedlethalequip = scripts\engine\utility::array_remove(owner.plantedlethalequip, self);

  wait(_id_CBF7BE4F62A0DDB2);
  self delete();
}

claymore_modifieddamage(victim, objweapon, inflictor, meansofdeath, damage) {
  if(!isDefined(inflictor))
    return damage;

  if(isnullweapon(objweapon))
    return damage;

  if(objweapon != makeweapon("claymore_mp"))
    return damage;

  if(!isexplosivedamagemod(meansofdeath))
    return damage;

  dist = distance2d(inflictor.origin, victim.origin);
  _id_6C8D21B2E54B2478 = 1 - clamp((dist - 75) / 181, 0, 1);
  damage = 70 + 70 * _id_6C8D21B2E54B2478;
  return damage;
}

remotedefusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  hintstring = &"PERKS/REMOTE_DEFUSE_HINT";
  _id_E213CDC03C01A000 = 0;
  self.useobj = scripts\cp\utility::createhintobject(self.origin + anglestoup(self.angles) * 7, "HINT_BUTTON", undefined, hintstring, _id_E213CDC03C01A000, undefined, "show", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(player in level.players)
  self.useobj disableplayeruse(player);

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("defused", player);

    if(isPlayer(player))
      thread claymore_trigger(player);
  }
}

defuseusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.1;

    foreach(player in level.players)
    self.useobj enableplayeruse(player);
  }
}

defusethink() {
  self endon("restarting_physics");
  _id_88032DC5704DA634 = self.useobj;
  _id_DBCE45A33308630D = undefined;

  if(istrue(level.gameended) && !isDefined(_id_88032DC5704DA634)) {
    return;
  }
  while(isDefined(self)) {
    _id_88032DC5704DA634 waittill("trigger", player);

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }
    player.iscapturingcrate = 1;
    _id_DBCE45A33308630D = scripts\cp\utility::createuseent();
    _id_DBCE45A33308630D.id = "breach_defuse";
    result = _id_DBCE45A33308630D scripts\cp\cp_deployablebox::useholdthink(player, getdvarfloat("perk_defuse_equipment_time"));

    if(!isDefined(player)) {
      return;
    }
    if(!result) {
      player.iscapturingcrate = 0;
      continue;
    }

    player.iscapturingcrate = 0;
    self notify("defused", player);
  }
}

spawn_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A, floating) {
  parent = undefined;
  _id_656F0AE440B1B5D5 = undefined;

  if(istrue(floating)) {
    parent = scripts\engine\utility::spawn_tag_origin(origin, angles);
    _id_656F0AE440B1B5D5 = magicgrenademanual("claymore_mp", origin + (0, 0, 10), (0, 0, 0));
  } else
    _id_656F0AE440B1B5D5 = magicgrenademanual("claymore_mp", origin + (0, 0, 10), (0, 0, 10));

  _id_656F0AE440B1B5D5 childthread plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A, parent);
  return _id_656F0AE440B1B5D5;
}

plant_enemy_claymore(origin, angles, _id_F8F2EBF05B9AF55A, parent) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.angles = angles;
  self.owner = spawnStruct();
  self.owner.angles = angles;
  self.owner.team = "neutral";
  self.team = "neutral";
  self.weapon_object = makeweapon("claymore_mp");
  owner = self.owner;

  if(!isDefined(self.weapon_name))
    self.weapon_name = "claymore_mp";

  if(isDefined(parent)) {
    self.parent = parent;
    thread _id_1E994DD89F124753();
  }

  thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);
  self setHintString(&"COOP_GAME_PLAY/DISABLE_TRAP");
  self missilethermal();
  self missileoutline();
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread _id_74502A9E0EF1F19C::minedamagemonitor();
  thread claymore_explodeonnotify();
  thread claymore_destroyonemp();
  self setscriptablepartstate("plant", "active", 0);

  if(!isDefined(level._id_804A2874C0323DA7))
    level._id_804A2874C0323DA7 = [];

  level._id_804A2874C0323DA7[level._id_804A2874C0323DA7.size] = self;
  wait 1;
  self enableplayermarks("equipment");
  self setscriptablepartstate("arm", "active", 0);
  thread custom_explode_mine(origin);
  thread enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A);
  thread _id_553142ED1D7441E4();
}

_id_1E994DD89F124753() {
  level endon("game_ended");
  self endon("death");
  _id_0454EBDDE3D9DCF4 = self.origin;

  while(self.origin == _id_0454EBDDE3D9DCF4)
    wait 0.05;

  wait 0.5;
  self.origin = self.parent.origin;
  self.angles = self.parent.angles;
  self linkTo(self.parent, "tag_origin");
}

_id_553142ED1D7441E4() {
  level endon("game_ended");
  self waittill("death");
  scripts\cp\cp_juggernaut::_id_84BAE1E96A725EC5();
  level._id_804A2874C0323DA7 = scripts\engine\utility::array_removedead(level._id_804A2874C0323DA7);
}

custom_explode_mine(origin) {
  self endon("clean_custom_explode");
  _id_B9CE53DAD043E9E4 = origin + (0, 0, 50) + anglesToForward(self.angles) * 95;
  _id_419BFD33C72E7EF9 = origin + (0, 0, 50) + anglesToForward(self.angles) * 30;
  self waittill("death");
  attacker = getaiarray("axis")[0];
  radiusdamage(_id_419BFD33C72E7EF9, 30, 1000, 200, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
  radiusdamage(_id_B9CE53DAD043E9E4, 75, 1000, 20, attacker, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

enemy_claymore_watchfortrigger(_id_F8F2EBF05B9AF55A) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("hacked");
  scripts\cp\cp_juggernaut::_id_91ED8C25C9B88686();

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water"]);

  for(;;) {
    _id_00AF3B9624C6AB60 = level.players;
    forward = anglesToForward(self.angles);
    up = anglestoup(self.angles);
    _id_2CC97E113610CA14 = self.origin + up * 0;
    ignorelist = [self];

    if(isDefined(level.dynamicladders)) {
      foreach(struct in level.dynamicladders)
      ignorelist[ignorelist.size] = struct.ents[0];
    }

    if(istrue(_id_F8F2EBF05B9AF55A))
      _id_00AF3B9624C6AB60 = scripts\engine\utility::array_combine(_id_00AF3B9624C6AB60, getaiarray("allies"));

    _id_6E67552299FA6895 = [];

    foreach(player in level.players) {
      if(isDefined(player.vehicle))
        _id_6E67552299FA6895[_id_6E67552299FA6895.size] = player.vehicle;
    }

    _id_00AF3B9624C6AB60 = scripts\engine\utility::array_combine(_id_6E67552299FA6895, _id_00AF3B9624C6AB60);

    foreach(_id_548B9F6609CE3883 in _id_00AF3B9624C6AB60) {
      if(!isDefined(_id_548B9F6609CE3883) || !isDefined(_id_548B9F6609CE3883.classname)) {
        continue;
      }
      if(isPlayer(_id_548B9F6609CE3883) && _id_0AFB7E332AEE4BF2::player_in_laststand(_id_548B9F6609CE3883) || isagent(_id_548B9F6609CE3883) && !isalive(_id_548B9F6609CE3883)) {
        continue;
      }
      if(_id_548B9F6609CE3883.classname != "script_vehicle" && lengthsquared(_id_548B9F6609CE3883 getentityvelocity()) < 10) {
        continue;
      }
      if(distance2dsquared(_id_548B9F6609CE3883.origin, self.origin) > 50625) {
        continue;
      }
      _id_AD283A45677A1EA3 = _id_548B9F6609CE3883.origin;

      if(_id_548B9F6609CE3883 tagexists("j_mainroot"))
        _id_AD283A45677A1EA3 = _id_548B9F6609CE3883 gettagorigin("j_mainroot");

      _id_44060504F23C16AF = [_id_AD283A45677A1EA3];
      _id_340D59422336E85A = _id_2CC97E113610CA14 - _id_AD283A45677A1EA3;

      if(_id_548B9F6609CE3883 tagexists("j_spineupper") && vectordot(_id_340D59422336E85A, (0, 0, 1)) >= 0)
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883 gettagorigin("j_spineupper");
      else
        _id_44060504F23C16AF[_id_44060504F23C16AF.size] = _id_548B9F6609CE3883.origin;

      foreach(_id_A00164B06F60F5E6 in _id_44060504F23C16AF) {
        _id_340D59422336E85A = _id_A00164B06F60F5E6 - self.origin;
        _id_CC00B910BD1D69C8 = vectordot(_id_340D59422336E85A, forward);

        if(_id_548B9F6609CE3883.classname == "script_vehicle") {
          if(_id_CC00B910BD1D69C8 > 130 || _id_CC00B910BD1D69C8 < 20)
            continue;
        } else if(_id_CC00B910BD1D69C8 > 90 || _id_CC00B910BD1D69C8 < 20) {
          continue;
        }
        _id_69211973F7D7BBD6 = vectordot(_id_340D59422336E85A, up);

        if(_id_548B9F6609CE3883.classname == "script_vehicle") {
          if(abs(_id_69211973F7D7BBD6) > 64)
            continue;
        } else if(abs(_id_69211973F7D7BBD6) > 32) {
          continue;
        }
        _id_A3D051EF761EFD24 = vectorNormalize(_id_340D59422336E85A);
        _id_74876E67651C79A6 = vectordot(_id_A3D051EF761EFD24, forward);

        if(_id_548B9F6609CE3883.classname != "script_vehicle" && _id_74876E67651C79A6 < 0.86602) {
          continue;
        }
        _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_A00164B06F60F5E6, contents, ignorelist, 0, "physicsquery_closest", 1);

        if(_id_548B9F6609CE3883.classname == "script_vehicle") {
          if(!isDefined(_id_E021C2744CC7ED68) || !_id_E021C2744CC7ED68.size)
            continue;
        } else if(!_id_E021C2744CC7ED68.size) {
          thread claymore_trigger(_id_548B9F6609CE3883);
          return;
        }

        _id_781A64FE27BE0F73 = 0;

        foreach(result in _id_E021C2744CC7ED68) {
          if(!isDefined(result["entity"])) {
            continue;
          }
          if(result["entity"] == _id_548B9F6609CE3883)
            _id_781A64FE27BE0F73 = 1;
        }

        if(!_id_781A64FE27BE0F73) {
          continue;
        }
        thread claymore_trigger(_id_548B9F6609CE3883);
      }
    }

    wait 0.05;
  }
}
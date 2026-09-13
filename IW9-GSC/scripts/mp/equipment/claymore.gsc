/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\claymore.gsc
***********************************************/

claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw9/core/equipment/vfx_equip_claymore_trigger.vfx");

  if(istrue(game["isLaunchChunk"])) {
    return;
  }
  minetriggerdata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_claymore", 1);
  minetriggerdata.triggercallback = ::claymore_triggerfromvehicle;
}

claymore_use(grenade) {
  self endon("death_or_disconnect");
  grenade endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp"))
    grenade.hasruggedeqp = 1;

  grenade.exploding = 1;
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);

  if(isDefined(scripts\cp_mp\utility\player_utility::getvehicle())) {
    scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    waitframe();
    grenade delete();
  }

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

  if(scripts\cp_mp\utility\train_utility::player_standing_on_train()) {
    _id_F99216CEE573EA7E.plantoffsetz = _id_F99216CEE573EA7E.plantoffsetz + 2;
    _id_F99216CEE573EA7E.contents = scripts\cp_mp\utility\train_utility::_id_D699841D5E241043();
  } else
    _id_F99216CEE573EA7E.contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass"]);

  _id_129FA79CDE973B37 = scripts\mp\utility\equipment::plant(grenade, _id_F99216CEE573EA7E);

  if(!istrue(_id_129FA79CDE973B37)) {
    scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    grenade delete();
  } else {
    if(isDefined(level._id_CA4E08767CBDAE12)) {
      _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

      if(!_id_425925A45729DEAE) {
        scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
        scripts\mp\equipment::incrementequipmentslotammo("primary");
        grenade delete();
        return;
      }
    }

    _id_BF8E5F003146AF44 = grenade getlinkedparent();

    if(isDefined(_id_BF8E5F003146AF44))
      grenade scripts\mp\weapons::explosivehandlemovers(_id_BF8E5F003146AF44);

    grenade.exploding = 0;
    grenade thread claymore_plant();
  }
}

claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  owner = self.owner;
  team = self.owner.team;
  scripts\cp_mp\ent_manager::registerspawn(1, ::sweepclaymore);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", owner, 1);
  thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  owner scripts\mp\weapons::onequipmentplanted(self, "equip_claymore", ::claymore_delete);
  thread scripts\mp\weapons::monitordisownedequipment(owner, self);
  self missilethermal();
  self missileoutline();
  self setentityowner(owner);
  self setotherent(owner);
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread scripts\mp\weapons::minedamagemonitor();
  thread claymore_explodeonnotify();
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(::claymore_empapplied);
  _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_4373872960A2D51A);
  _id_49197CD063A740EA(::claymore_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(self);
  }

  claymore_updatedangerzone();
  self setscriptablepartstate("plant", "active", 0);
  owner setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  thread claymore_forceclampangles();
  wait 1;
  self setscriptablepartstate("arm", "active", 0);
  thread claymore_watchfortrigger();
  thread scripts\mp\equipment_interact::remoteinteractsetup(::claymore_trigger, 1, 1);
}

claymore_updatedangerzone() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }
  if(isDefined(self.dangerzone))
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

claymore_forceclampangles() {
  self endon("mine_selfdestruct");
  self endon("death");
  endtime = gettime() + 2000;

  while(endtime > gettime()) {
    _id_3EE87D07F44102BE = (0, self.angles[1], 0);
    _id_C3471647FBD93C0A = 15;
    self.angles = anglelerpquat(_id_3EE87D07F44102BE, self.angles, _id_C3471647FBD93C0A);
    waitframe();
  }
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
          if(ent scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
            continue;
          }
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
          if(!scripts\mp\utility\player::isreallyalive(ent)) {
            continue;
          }
          forward = anglesToForward(self.angles);
          up = anglestoup(self.angles);
          _id_2CC97E113610CA14 = self.origin + up * 0;
          ignorelist = scripts\mp\utility\equipment::get_mine_ignore_list();
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

            if(_id_CC00B910BD1D69C8 > 192) {
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

claymore_trigger(ent, attacker) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(attacker))
    attacker endon("disconnect");
  else
    attacker = self.owner;

  self notify("mine_triggered");
  scripts\mp\utility\print::printgameaction("claymore triggered", self.owner);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\mp\weapons::explosivetrigger(ent, 0.3);
  thread claymore_explode(attacker);
}

claymore_triggerfromvehicle(vehicle, mine) {
  mine endon("mine_destroyed");
  mine endon("death");
  mine.owner endon("disconnect");
  mine notify("mine_triggered");
  mine scripts\mp\weapons::makeexplosiveunusuabletag();
  mine setscriptablepartstate("arm", "neutral", 0);
  mine setscriptablepartstate("trigger", "active", 0);
  wait 0.1;
  mine thread claymore_explodefromvehicletrigger(vehicle);
}

claymore_explodefromvehicletrigger(vehicle) {
  vehicle dodamage(140, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("claymore_mp"));
  ignoredamageid = vehicle scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, makeweapon("claymore_mp"), self, "MOD_EXPLOSIVE");
  thread claymore_explode();
  waitframe();

  if(isDefined(vehicle))
    vehicle scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(ignoredamageid);
}

claymore_explode(attacker) {
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\mp\weapons::makeexplosiveunusuabletag();

  if(isDefined(self.useobj))
    self.useobj delete();

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner))
    owner scripts\mp\weapons::removeequip(self);

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, forward, up);
  self radiusdamage(self.origin, 75, 100, 100, self.owner, "MOD_EXPLOSIVE", "claymore_radial_mp");
  earthquake(0.45, 0.7, self.origin, 800);
  self detonate(attacker);
}

claymore_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);
  self.detonatingplayer = attacker;
  thread claymore_explode(attacker);
}

sweepclaymore() {
  claymore_destroy();
}

claymore_destroy(_id_29E6836DE56DA9DC) {
  if(!isDefined(_id_29E6836DE56DA9DC))
    _id_29E6836DE56DA9DC = 0;

  thread claymore_delete(_id_29E6836DE56DA9DC + 0.2);
  wait(_id_29E6836DE56DA9DC);
  self setscriptablepartstate("destroy", "active", 0);
}

claymore_empapplied(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) || getdvarint("dvar_58254C61DE76BFFE", 0)) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp))
    damagefeedback = "hitequip";

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);

  thread _id_8EBAB9DB1B5BE748(attacker);
}

_id_4373872960A2D51A(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp))
    damagefeedback = "hitequip";

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);

  claymore_explode(attacker);
}

_id_8EBAB9DB1B5BE748(attacker) {
  self endon("death");
  self setscriptablepartstate("empd", "active", 0);
  claymore_stunned(attacker, 6.0);
  self setscriptablepartstate("empd", "neutral", 0);
}

claymore_delete(_id_CBF7BE4F62A0DDB2) {
  if(!isDefined(_id_CBF7BE4F62A0DDB2))
    _id_CBF7BE4F62A0DDB2 = 0;

  self setscriptablepartstate("hack_usable", "off");
  self notify("death");
  scripts\cp_mp\ent_manager::deregisterspawn();
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

  owner = self.owner;

  if(isDefined(self.owner))
    owner scripts\mp\weapons::removeequip(self);

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  self delete();
}

claymore_modifieddamage(victim, objweapon, inflictor, meansofdeath, damage) {
  if(!isDefined(inflictor))
    return damage;

  if(isnullweapon(objweapon))
    return damage;

  if(objweapon.basename == "claymore_mp") {
    if(isDefined(self.claymoreshitby)) {
      foreach(_id_656F0AE440B1B5D5 in self.claymoreshitby) {
        if(isDefined(_id_656F0AE440B1B5D5) && _id_656F0AE440B1B5D5 == inflictor)
          return 0;
      }
    }
  } else if(objweapon.basename == "claymore_radial_mp") {
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(victim, inflictor.owner)))
      return 0;

    thread claymore_blockdamageuntilframeend(inflictor);
  } else
    return damage;

  if(isDefined(level.gametype) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return damage;

  if(!isexplosivedamagemod(meansofdeath))
    return damage;

  _id_340D59422336E85A = victim.origin - inflictor.origin;
  dist = vectordot(_id_340D59422336E85A, anglestoup(inflictor.angles));

  if(dist > 65)
    return 0;

  _id_340D59422336E85A = inflictor.origin - victim getEye();
  dist = vectordot(_id_340D59422336E85A, anglestoup(inflictor.angles));

  if(dist > 65)
    return 0;

  forward = anglesToForward(inflictor.angles);
  forward = (forward[0], forward[1], 0);
  _id_452088725D788A39 = victim.origin - inflictor.origin;
  _id_452088725D788A39 = (_id_452088725D788A39[0], _id_452088725D788A39[1], 0);
  dot = vectordot(forward, _id_452088725D788A39);

  if(dot < 0)
    return 0;

  dist = distance2d(inflictor.origin, victim.origin);
  _id_6C8D21B2E54B2478 = 1 - clamp((dist - 75) / 130, 0, 1);
  damage = 70 + 70 * _id_6C8D21B2E54B2478;

  if(isDefined(inflictor.detonatingplayer)) {
    _id_68C7B0CD4C501AF6 = isDefined(inflictor.owner) && inflictor.detonatingplayer == inflictor.owner;
    _id_A38DC5334101941B = inflictor.detonatingplayer == victim;

    if(!_id_68C7B0CD4C501AF6 && _id_A38DC5334101941B)
      damage = min(damage, 80);
  }

  return damage;
}

claymore_blockdamageuntilframeend(inflictor) {
  self endon("disconnect");
  self notify("claymore_blockDamageUntilFrameEnd");
  self endon("claymore_blockDamageUntilFrameEnd");

  if(!isDefined(self.claymoreshitby))
    self.claymoreshitby = [];

  self.claymoreshitby[self.claymoreshitby.size] = inflictor;
  waittillframeend;
  self.claymoreshitby = undefined;
}

claymore_onownerchanged(_id_C0F9139FFD72E62D) {
  self setscriptablepartstate("hacked", "active", 0);
  claymore_updatedangerzone();
  sentientpool = self.sentientpool;
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient(sentientpool, self.owner, 1);
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}

claymore_stunned(attacker, duration) {
  self endon("death");

  if(!isDefined(duration))
    duration = 3.0;

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback("hitequip");

  self notify("claymore_stunned");
  self endon("claymore_stunned");
  attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_812FD700EEEF3C6E");
  self setscriptablepartstate("arm", "neutral", 0);
  self.stunned = 1;
  wait(duration);
  self.stunned = 0;
  self setscriptablepartstate("arm", "active", 0);
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}
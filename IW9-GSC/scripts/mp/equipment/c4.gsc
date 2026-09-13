/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\c4.gsc
***********************************************/

c4_set(equipmentref, slot, variantid) {
  thread c4_watchforaltdetonation();
}

c4_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  scripts\mp\utility\print::printgameaction("c4 spawn", grenade.owner);
  grenade.throwtime = gettime();
  grenade scripts\cp_mp\ent_manager::registerspawn(1, ::sweepc4);
  c4_addtoarray(grenade.owner, grenade);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp"))
    grenade.hasruggedeqp = 1;

  grenade thread scripts\mp\weapons::minedamagemonitor();
  grenade thread c4_explodeonnotify();
  grenade thread c4_destroyongameend();
  grenade thread scripts\mp\equipment_interact::remoteinteractsetup(::c4_detonate, 1, 0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade waittill("missile_stuck");

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      scripts\mp\equipment::incrementequipmentslotammo("primary");
      grenade delete();
      return;
    }
  }

  grenade setotherent(self);
  grenade setnodeploy(1);
  scripts\mp\weapons::onequipmentplanted(grenade, "equip_c4", ::c4_delete);
  thread scripts\mp\weapons::monitordisownedequipment(self, grenade);
  grenade thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  grenade scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", grenade.owner, 1);
  grenade.owner setclientomnvar("ui_mgl_c4_state", 1);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::c4_empapplied);
  grenade _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_3F54618AC84AA89F);
  grenade _id_49197CD063A740EA(::c4_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
  }

  grenade thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  grenade setscriptablepartstate("effects", "plant", 0);
  thread scripts\mp\weapons::outlineequipmentforowner(grenade);
  grenade missilethermal();
  grenade missileoutline();
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
  grenade c4_updatedangerzone();
}

c4_updatedangerzone() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }
  if(isDefined(self.dangerzone))
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);

  _id_D8695B9748C307BE = (self.origin[0], self.origin[1], self.origin[2] - 50.0);
  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(_id_D8695B9748C307BE, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 100, self.owner.team, undefined, self.owner, 0, self, 1);
}

c4_detonate(attacker) {
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(attacker))
    attacker endon("disconnect");
  else
    attacker = self.owner;

  wait 0.1;
  thread c4_explode(attacker);
}

c4_explode(attacker) {
  scripts\mp\utility\print::printgameaction("c4 triggered", self.owner);
  level notify("explosion_extinguish", self.origin, 256, self.owner, self);
  _id_CBF7BE4F62A0DDB2 = undefined;
  statename = undefined;
  caststart = self.origin;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1, 0, 0, 0);
  _id_89E70A63B116955B = vectordot((0, 0, 1), anglestoup(self.angles));

  if(abs(_id_89E70A63B116955B) <= 0.81915) {
    castend = caststart - anglestoup(self.angles) * 5;
    _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
      _id_CBF7BE4F62A0DDB2 = 5;
      statename = "explode";
    }
  } else if(_id_89E70A63B116955B <= -0.96592) {
    castend = caststart - anglestoup(self.angles) * 5;
    _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
      _id_CBF7BE4F62A0DDB2 = 5;
      statename = "explode";
    }
  }

  if(!isDefined(_id_CBF7BE4F62A0DDB2)) {
    castend = caststart - (0, 0, 20);
    _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(!isDefined(_id_E021C2744CC7ED68) || _id_E021C2744CC7ED68.size <= 0) {
      _id_CBF7BE4F62A0DDB2 = 5;
      statename = "explodeAir";
    }
  }

  if(!isDefined(_id_CBF7BE4F62A0DDB2)) {
    _id_CBF7BE4F62A0DDB2 = 5;
    statename = "explode";
  }

  if(getdvarint("mgl", 0))
    thread scripts\common\ai::_id_F8903387EA945165(self.origin, 2);

  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("effects", statename, 0);
  thread c4_delete(_id_CBF7BE4F62A0DDB2);
}

sweepc4() {
  thread c4_delete();
}

c4_destroy(attacker) {
  thread c4_delete(5);
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

c4_delete(_id_CBF7BE4F62A0DDB2) {
  if(!isDefined(self) || isDefined(self) && istrue(self.isdestroyed)) {
    return;
  }
  self.isdestroyed = 1;
  self.exploding = 1;
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  owner = self.owner;

  if(isDefined(owner)) {
    c4_removefromarray(owner, self, self getentitynumber());
    owner setclientomnvar("ui_mgl_c4_state", 0);
    owner scripts\mp\weapons::removeequip(self);
    owner notify("c4_update", 0);
  }

  thread c4_resetscriptableonunlink();

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  if(isDefined(self))
    self delete();
}

c4_resetscriptableonunlink() {
  self endon("death");
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }
  parent = self getlinkedparent();

  if(isDefined(parent)) {
    parent waittill("death");

    if(isDefined(self))
      self setscriptablepartstate("effects", "neutral", 0);
  }
}

c4_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker))
    thread c4_explode(attacker);
  else
    thread c4_explode(owner);
}

c4_empapplied(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp))
    damagefeedback = "hitequip";

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);

  thread _id_156475610BE70CED(attacker);
}

_id_3F54618AC84AA89F(data) {
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

  c4_explode(attacker);
}

_id_156475610BE70CED(attacker) {
  self endon("death");
  attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C45CD96BCAAF28D9");
  self.isdisabled = 1;
  self setscriptablepartstate("emp", "on", 0);
  wait 6.0;
  self setscriptablepartstate("emp", "off", 0);
  self.isdisabled = 0;
}

c4_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread c4_destroy();
}

c4_validdetonationstate() {
  if(!scripts\mp\utility\player::isreallyalive(self))
    return 0;

  if(scripts\mp\utility\player::isusingremote())
    return 0;

  if(!isDefined(self.c4s) || self.c4s.size <= 0)
    return 0;

  return 1;
}

c4_candetonate() {
  if(istrue(self.isdisabled))
    return 0;

  return (gettime() - self.throwtime) / 1000 > 0.3;
}

c4_watchfordetonation() {
  self endon("death_or_disconnect");
  self endon("equipment_taken_equip_c4");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");

  for(;;) {
    self waittill("detonate");
    _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(self getheldoffhand());

    if(self getheldoffhand().basename == "c4_mp" || self getheldoffhand().basename == "c4_empty_mp" || self getheldoffhand().basename == "none" && isDefined(self.isusingcamera) && self.isusingcamera || _id_49E6EF3EDADD524E == "c4")
      thread c4_detonateall();
  }
}

c4_watchforaltdetonation() {
  self endon("death_or_disconnect");
  self endon("equipment_taken_equip_c4");
  level endon("game_ended");

  if(!getdvarint("scr_altdetonationenabled", 0)) {
    return;
  }
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self useButtonPressed())
    waitframe();

  starttime = gettime();
  _id_8B07FA3892A3A8A4 = 0;
  _id_038FC7BD1495C4B2 = level.framedurationseconds;

  for(;;) {
    if(self useButtonPressed()) {
      _id_8B07FA3892A3A8A4 = 0;

      while(self useButtonPressed()) {
        _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + _id_038FC7BD1495C4B2;
        wait(_id_038FC7BD1495C4B2);
      }

      if(_id_8B07FA3892A3A8A4 >= 0.5) {
        continue;
      }
      _id_8B07FA3892A3A8A4 = 0;

      while(!self useButtonPressed() && _id_8B07FA3892A3A8A4 < 0.25) {
        _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + _id_038FC7BD1495C4B2;
        wait(_id_038FC7BD1495C4B2);
      }

      if(_id_8B07FA3892A3A8A4 >= 0.25) {
        continue;
      }
      if(c4_validdetonationstate())
        thread c4_animdetonate();
    }

    waitframe();
  }
}

c4_animdetonate() {
  objweapon = makeweapon("c4_empty_mp");
  self giveandfireoffhand(objweapon);
  thread c4_animdetonatecleanup();
}

c4_animdetonatecleanup() {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  objweapon = makeweapon("c4_empty_mp");
  wait 1;

  if(self hasweapon(objweapon))
    self takeweapon(objweapon);
}

c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(c4 in self.c4s) {
      if(c4 c4_candetonate())
        c4 thread c4_detonate();
    }
  }
}

c4_onownerchanged(_id_C0F9139FFD72E62D) {
  if(istrue(self.exploding)) {
    return;
  }
  c4_removefromarray(_id_C0F9139FFD72E62D, self, self getentitynumber());
  sentientpool = self.sentientpool;
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient(sentientpool, self.owner, 1);
  thread c4_destroy();
}

c4_resetaltdetonpickup() {
  if(scripts\mp\equipment::hasequipment("equip_c4"))
    thread c4_watchforaltdetonation();
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}

c4_addtoarray(owner, grenade) {
  if(!isDefined(owner.c4s))
    owner.c4s = [];

  entnum = grenade getentitynumber();
  owner.c4s[entnum] = grenade;
  owner _meth_BCC86382F02470E6(1);
  thread c4_removefromarrayondeath(owner, grenade, entnum);
}

c4_removefromarray(owner, grenade, entnum) {
  if(isDefined(grenade))
    grenade notify("c4_removeFromArray");

  if(isDefined(owner) && isDefined(owner.c4s)) {
    owner.c4s[entnum] = undefined;

    foreach(c4 in owner.c4s) {
      if(isDefined(c4))
        return;
    }

    owner _meth_BCC86382F02470E6(0);
  }
}

c4_removefromarrayondeath(owner, grenade, entnum) {
  grenade endon("c4_removeFromArray");
  owner endon("disconnect");
  grenade waittill("death");
  thread c4_removefromarray(owner, grenade, entnum);
}
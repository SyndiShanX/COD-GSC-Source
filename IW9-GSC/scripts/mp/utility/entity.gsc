/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\entity.gsc
***********************************************/

getaverageorigin(_id_4A6E62AA769AD290) {
  _id_D8DE9486A89D3332 = (0, 0, 0);

  if(!_id_4A6E62AA769AD290.size)
    return undefined;

  foreach(ent in _id_4A6E62AA769AD290)
  _id_D8DE9486A89D3332 = _id_D8DE9486A89D3332 + ent.origin;

  _id_16C3B0338E3E0298 = int(_id_D8DE9486A89D3332[0] / _id_4A6E62AA769AD290.size);
  _id_16C3B1338E3E04CB = int(_id_D8DE9486A89D3332[1] / _id_4A6E62AA769AD290.size);
  _id_16C3B2338E3E06FE = int(_id_D8DE9486A89D3332[2] / _id_4A6E62AA769AD290.size);
  _id_D8DE9486A89D3332 = (_id_16C3B0338E3E0298, _id_16C3B1338E3E04CB, _id_16C3B2338E3E06FE);
  return _id_D8DE9486A89D3332;
}

touchingbadtrigger() {
  _id_62A9E105632784D0 = getEntArray("trigger_hurt", "classname");

  foreach(trigger in _id_62A9E105632784D0) {
    if(self istouching(trigger))
      return 1;
  }

  radtriggers = getEntArray("radiation", "targetname");

  foreach(trigger in radtriggers) {
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

touchingoobtrigger() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level.outofboundstriggers))
    return 0;

  foreach(trigger in level.outofboundstriggers) {
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

touchingballallowedtrigger() {
  if(!istrue(level.ballallowedtriggers.size))
    return 0;

  self.allowedintrigger = 0;

  foreach(trigger in level.ballallowedtriggers) {
    if(self istouching(trigger)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

touchingplayerallowedtrigger() {
  if(!istrue(level.playerallowedtriggers.size))
    return 0;

  self.allowedintrigger = 0;

  foreach(trigger in level.playerallowedtriggers) {
    if(self istouching(trigger)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

findisfacing(_id_6848D0559BA20855, _id_6848CD559BA201BC, tolerance) {
  _id_5762B77F73EDA7C0 = cos(tolerance);
  _id_4911F9A2A7F63E01 = anglesToForward(_id_6848D0559BA20855.angles);
  _id_039166B57B87F75D = _id_6848CD559BA201BC.origin - _id_6848D0559BA20855.origin;
  _id_4911F9A2A7F63E01 = _id_4911F9A2A7F63E01 * (1, 1, 0);
  _id_039166B57B87F75D = _id_039166B57B87F75D * (1, 1, 0);
  _id_039166B57B87F75D = vectorNormalize(_id_039166B57B87F75D);
  _id_4911F9A2A7F63E01 = vectorNormalize(_id_4911F9A2A7F63E01);
  _id_466E87CE09CA407B = vectordot(_id_039166B57B87F75D, _id_4911F9A2A7F63E01);

  if(_id_466E87CE09CA407B >= _id_5762B77F73EDA7C0)
    return 1;
  else
    return 0;
}

isaiteamparticipant(ent) {
  if(isagent(ent) && ent.agent_teamparticipant == 1)
    return 1;

  if(isbot(ent))
    return 1;

  return 0;
}

isteamparticipant(ent) {
  if(isaiteamparticipant(ent))
    return 1;

  if(isPlayer(ent))
    return 1;

  return 0;
}

isvalidteamtarget(attacker, victimteam, target) {
  return isDefined(target.team) && target.team == victimteam;
}

isvalidffatarget(attacker, victimteam, target) {
  return 1;
}

getlinknamenodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    _id_B11F91C17FEEAB8F = strtok(self.script_linkto, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B11F91C17FEEAB8F.size; _id_AC0E594AC96AA3A8++) {
      ent = getnode(_id_B11F91C17FEEAB8F[_id_AC0E594AC96AA3A8], "script_linkname");

      if(isDefined(ent))
        array[array.size] = ent;
    }
  }

  return array;
}

_id_D9CE8FB00F0E5FA1(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A) {
  return getentitiesinradius(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A, scripts\engine\trace::create_character_contents());
}

getentitiesinradius(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A, _id_D1BDD6B42771114C) {
  if(radius <= 0)
    return [];

  _id_2649564EBA242B56 = undefined;

  if(isDefined(_id_24EE99FA6D091C2A)) {
    if(isarray(_id_24EE99FA6D091C2A))
      _id_2649564EBA242B56 = _id_24EE99FA6D091C2A;
    else
      _id_2649564EBA242B56 = [_id_24EE99FA6D091C2A];
  }

  results = physics_querypoint(origin, radius, _id_D1BDD6B42771114C, _id_2649564EBA242B56, "physicsquery_all");
  _id_815AAE0BD650B698 = [];

  if(!isDefined(_id_BEB392BBB338D308)) {
    foreach(result in results) {
      e = result["entity"];

      if(isDefined(e))
        _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  } else {
    foreach(result in results) {
      e = result["entity"];

      if(isDefined(e) && isDefined(e.team) && e.team == _id_BEB392BBB338D308)
        _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  }

  return _id_815AAE0BD650B698;
}

watchentitiesinradius(_id_40EA85AA56FCCDC4, _id_4063CDC9B79E33F2, _id_ECEA6CDA97E5F7AE, _id_26E2CA9B2AD77B37, _id_9DC460B17444614F) {
  self endon("disconnect");
  self endon("end_entities_in_radius");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    _id_A018E61307A26F1A = undefined;

    if(_id_9DC460B17444614F)
      _id_A018E61307A26F1A = scripts\mp\utility\player::getplayersinradius(self.origin, _id_40EA85AA56FCCDC4);
    else
      _id_A018E61307A26F1A = getentitiesinradius(self.origin, _id_40EA85AA56FCCDC4);

    if(_id_A018E61307A26F1A.size > 0) {
      if(!_id_26E2CA9B2AD77B37)
        self notify(_id_4063CDC9B79E33F2, _id_A018E61307A26F1A);
      else {
        entities = [];

        foreach(_id_52C2589580AE5782 in _id_A018E61307A26F1A) {
          _id_C8E7BDC8418B520F = self getorigin();
          targetposition = scripts\engine\utility::ter_op(_id_9DC460B17444614F, _id_52C2589580AE5782 getEye(), _id_52C2589580AE5782.origin);
          _id_68E6F05A4EE24DEE = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
          _id_97DB5D48F2509E02 = physics_raycast(_id_C8E7BDC8418B520F, targetposition, _id_68E6F05A4EE24DEE, undefined, 0, "physicsquery_closest");

          if(_id_97DB5D48F2509E02.size <= 0)
            entities[entities.size] = _id_52C2589580AE5782;
        }

        self notify(_id_4063CDC9B79E33F2, entities);
      }
    }

    wait(_id_ECEA6CDA97E5F7AE);
  }
}

cancelentitiesinradius() {
  self notify("end_entities_in_radius");
}

placeequipmentfailed(weapon, _id_DACCA504F8875146, position, angles) {
  self playlocalsound("scavenger_pack_pickup");

  if(istrue(_id_DACCA504F8875146)) {
    fxent = undefined;

    if(isDefined(angles))
      fxent = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), position, self, anglesToForward(angles), anglestoup(angles));
    else
      fxent = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), position, self);

    triggerfx(fxent);
    thread placeequipmentfailedcleanup(fxent);
  }

  switch (weapon) {
    case "micro_turret_mp":
    case "deployable_cover_mp":
    case "trip_mine_mp":
    case "cryo_mine_mp":
    case "trophy_mp":
      if(isPlayer(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
        self iprintlnbold("Placement Failed");
        return;
      }
  }
}

placeequipmentfailedinit() {
  level._effect["placeEquipmentFailed"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
}

placeequipmentfailedcleanup(fxent) {
  wait 2;
  fxent delete();
}

isspidergrenade(ent) {
  return istrue(ent.isspidergrenade);
}

issupertrophy(ent) {
  entnum = ent getentitynumber();

  if(!isDefined(level.supertrophy))
    return 0;

  if(!isDefined(level.supertrophy.trophies))
    return 0;

  if(!isDefined(level.supertrophy.trophies[entnum]))
    return 0;

  return level.supertrophy.trophies[entnum] == ent;
}

ismicroturret(ent) {
  entnum = ent getentitynumber();

  if(!isDefined(level.microturrets))
    return 0;

  if(!isDefined(level.microturrets[entnum]))
    return 0;

  return level.microturrets[entnum] == ent;
}

ischoppergunner(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_8AB8EB8DEF8AC7AC = ent.streakinfo.streakname == "chopper_gunner";
  return _id_8AB8EB8DEF8AC7AC;
}

issupporthelo(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_8AB8EB8DEF8AC7AC = ent.streakinfo.streakname == "chopper_support";
  return _id_8AB8EB8DEF8AC7AC;
}

isclusterstrike(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_30C3CED8E8637755 = ent.streakinfo.streakname == "toma_strike";
  return _id_30C3CED8E8637755;
}

isuav(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  if(ent.streakinfo.streakname == "uav" || ent.streakinfo.streakname == "counter_uav" || ent.streakinfo.streakname == "directional_uav")
    return 1;

  return 0;
}

isgunship(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_F930E97582EAEA73 = ent.streakinfo.streakname == "gunship";
  return _id_F930E97582EAEA73;
}

isradardrone(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_15D89ECD7562A1E7 = ent.streakinfo.streakname == "radar_drone_escort" || ent.streakinfo.streakname == "radar_drone_recon";
  return _id_15D89ECD7562A1E7;
}

isscramblerdrone(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_152BE1BDA3C25940 = ent.streakinfo.streakname == "scrambler_drone_guard" || ent.streakinfo.streakname == "counter_uav";
  return _id_152BE1BDA3C25940;
}

isradarhelicopter(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_15D89ECD7562A1E7 = ent.streakinfo.streakname == "radar_drone_overwatch";
  return _id_15D89ECD7562A1E7;
}

isassaultdrone(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_15D89ECD7562A1E7 = ent.streakinfo.streakname == "assault_drone";
  return _id_15D89ECD7562A1E7;
}

isturret(ent) {
  return isDefined(ent.classname) && ent.classname == "misc_turret";
}

isdronepackage(ent) {
  return isDefined(ent.cratetype);
}

_enableequipdeployvfx() {
  if(!isDefined(self.enabledequipdeployvfx))
    self.enabledequipdeployvfx = 0;

  if(self.enabledequipdeployvfx == 0)
    self enableequipdeployvfx(1);

  self.enabledequipdeployvfx++;
}

_disableequipdeployvfx() {
  if(self.enabledequipdeployvfx == 1)
    self enableequipdeployvfx(0);

  self.enabledequipdeployvfx--;
}

register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  for(;;) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);
    level notify("physSnd", self, body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);
  }
}

global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", _id_C92EF281C1D335FC, body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, _id_0B941BAEEBCA428D);

    if(isDefined(_id_C92EF281C1D335FC) && isDefined(_id_C92EF281C1D335FC.phys_sound_func))
      level thread[[_id_C92EF281C1D335FC.phys_sound_func]](_id_C92EF281C1D335FC, body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, _id_0B941BAEEBCA428D);
  }
}

register_physics_collision_func(entity, _id_9BC7C47CBF86E43D) {
  entity.phys_sound_func = _id_9BC7C47CBF86E43D;
}

istouchingboundstrigger(ent) {
  return istrue(ent.alreadytouchingtrigger);
}

istouchingboundsnullify(ent) {
  _id_05C40098B82789B9 = 0;

  if(isDefined(level.outofboundstriggerpatches) && level.outofboundstriggerpatches.size > 0) {
    foreach(_id_5996E55B74173B55 in level.outofboundstriggerpatches) {
      if(ent istouching(_id_5996E55B74173B55)) {
        _id_05C40098B82789B9 = 1;
        break;
      }
    }
  }

  return _id_05C40098B82789B9;
}

deleteonplayerdeathdisconnect(player) {
  self endon("death");
  player waittill("death_or_disconnect");
  self delete();
}

deleteatframeend() {
  self endon("death");
  waittillframeend;
  self delete();
}
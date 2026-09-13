/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\door.gsc
***********************************************/

stealth_suspicious_doors_init() {
  if(istrue(level.ship_assault)) {
    return;
  }
  if(isDefined(level.stealth)) {
    if(!isDefined(level.stealth.suspicious_door)) {
      level.stealth.suspicious_door = spawnStruct();
      level.stealth.suspicious_door.doors = [];
      level.stealth.suspicious_door.reset_time = 30;
      level.stealth.suspicious_door.sight_distsqrd = squared(600);
      level.stealth.suspicious_door.detect_distsqrd = squared(200);
      level.stealth.suspicious_door.found_distsqrd = squared(128);
    }

    level scripts\stealth\utility::set_stealth_func("suspicious_door", ::suspicious_door_found);
    level scripts\stealth\event::event_severity_set("investigate", "suspicious_door", 20);
  }
}

_id_22C3DC642B82A544() {
  self notify("suspicious_door_thread");
  self endon("suspicious_door_thread");
  self endon("death");
  self endon("pain_death");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");

    if(!scripts\stealth\utility::_id_6A86DD83C01F8FAA())
      suspicious_door_sighting();

    wait 0.1;
  }
}

suspicious_door_sighting() {
  if(!isDefined(self.stealth.suspicious_door))
    self.stealth.suspicious_door = spawnStruct();

  if(isDefined(self.stealth.suspicious_door.nexttime) && gettime() < self.stealth.suspicious_door.nexttime) {
    return;
  }
  if(self.ignoreall) {
    return;
  }
  if(istrue(self._id_2D74676FACF9C5A9)) {
    return;
  }
  if(istrue(self.stealth.suspicious_door.investigating)) {
    return;
  }
  if(isDefined(self.stealth.suspicious_door.ent))
    debounce = 100;
  else
    debounce = 1000;

  self.stealth.suspicious_door.nexttime = gettime() + debounce;
  doors = level.stealth.suspicious_door.doors;
  _id_29026875611B1B94 = undefined;
  _id_73F46F47832FB6AB = undefined;
  door = undefined;

  foreach(door in doors) {
    _id_315888925E4DECFA = door getentitynumber();

    if(isDefined(door.found)) {
      continue;
    }
    _id_20510600314FE827 = door.origin;
    distsq = distancesquared(self.origin, _id_20510600314FE827);
    _id_93D7B440350B1CED = level.stealth.suspicious_door.found_distsqrd;
    _id_2A44E35FA659E850 = level.stealth.suspicious_door.sight_distsqrd;
    _id_22E09CBF7A5ED764 = level.stealth.suspicious_door.detect_distsqrd;

    if(_id_20510600314FE827[2] - self.origin[2] > 128) {
      continue;
    }
    if(isDefined(self.stealth.suspicious_door.ent)) {
      if(self.stealth.suspicious_door.ent == door) {
        continue;
      }
      _id_56F0BE36CB2408C7 = self.stealth.suspicious_door.ent.origin;
      _id_AF7F4B45B0E027D9 = distancesquared(self.origin, _id_56F0BE36CB2408C7);

      if(_id_AF7F4B45B0E027D9 <= distsq)
        continue;
    }

    if(distsq < _id_93D7B440350B1CED) {
      if(abs(self.origin[2] - _id_20510600314FE827[2]) < 60) {
        _id_29026875611B1B94 = door;
        break;
      }
    }

    if(distsq > _id_2A44E35FA659E850) {
      continue;
    }
    if(distsq < _id_22E09CBF7A5ED764) {
      if(_id_3C9FF376D2F1D12C(door, debounce)) {
        _id_29026875611B1B94 = door;
        break;
      }
    }

    _id_628A780318ECCF12 = anglesToForward(self gettagangles("tag_eye"));
    _id_7755D77530405278 = vectorNormalize(_id_20510600314FE827 + (0, 0, 30) - self getEye());

    if(vectordot(_id_628A780318ECCF12, _id_7755D77530405278) > 0.55) {
      if(_id_3C9FF376D2F1D12C(door, debounce)) {
        _id_29026875611B1B94 = door;
        break;
      }
    }
  }

  if(isDefined(_id_29026875611B1B94)) {
    _id_29026875611B1B94.found = 1;
    _id_0C3EA9B1A20FF199 = undefined;

    if(isDefined(door.cam_structs))
      _id_0C3EA9B1A20FF199 = door.cam_structs[0].origin;
    else
      _id_0C3EA9B1A20FF199 = door.origin;

    self aieventlistenerevent("suspicious_door", _id_29026875611B1B94, _id_0C3EA9B1A20FF199);
  }
}

_id_3C9FF376D2F1D12C(door, debounce) {
  result = 0;
  debugorigin = door.origin;

  if(!isDefined(door.seen)) {
    if(self cansee(door, debounce))
      result = 1;
    else {
      _id_C5105247C3137A24 = rotatevectorinverted(door.open_struct.origin - door.origin, door.true_start_angles);
      _id_BE68D20226B914F1 = door.origin + rotatevector(_id_C5105247C3137A24, door.pivot_ent.angles);
      ignoreents = scripts\engine\utility::array_add(_func_067E2B3DDA1BEE8A(), door);

      if(isDefined(door.clip))
        ignoreents[ignoreents.size] = door.clip;

      if(isDefined(door.clip_nosight))
        ignoreents[ignoreents.size] = door.clip_nosight;

      startorigin = self getEye();
      _id_CD386984671B320B = [door.origin, _id_BE68D20226B914F1];

      foreach(origin in _id_CD386984671B320B) {
        debugorigin = origin;
        trace = scripts\engine\trace::ray_trace(startorigin, origin, ignoreents);

        if(scripts\engine\utility::is_equal(trace["hittype"], "hittype_none")) {
          result = 1;
          break;
        }
      }
    }
  }

  return result;
}

suspicious_door_found(event) {
  door = event.entity;

  if(isDefined(door.aiopener)) {
    return;
  }
  door.aiopener = self;

  if(isDefined(door.cam_structs) && isDefined(door.cam_structs[0]))
    _id_0C3EA9B1A20FF199 = door.cam_structs[0].origin;
  else
    _id_0C3EA9B1A20FF199 = door.origin;

  point = getclosestpointonnavmesh(_id_0C3EA9B1A20FF199, self);
  _id_808B4CAFF75E3E3D = 75;
  _id_7BF201849AE293CD = anglestoright(door.true_start_angles);
  _id_D9C3CA36E13ED26A = vectorNormalize(self.origin - door.origin);

  if(vectordot(_id_7BF201849AE293CD, _id_D9C3CA36E13ED26A) > 0)
    _id_808B4CAFF75E3E3D = _id_808B4CAFF75E3E3D * -1;

  event.origin = _id_0C3EA9B1A20FF199 + _id_7BF201849AE293CD * _id_808B4CAFF75E3E3D;
  event.investigate_pos = getclosestpointonnavmesh(event.origin, self);

  if(self._id_FE5EBEFA740C7106 < 2)
    scripts\stealth\enemy::bt_set_stealth_state("investigate", event);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\event.gsc
***********************************************/

event_init_entity() {
  thread event_listener_thread();
  self _meth_4CD0EAF5381F92DB(1);
}

event_init_level() {
  if(!isDefined(level.stealth.event_priority))
    level.stealth.event_priority = [];

  level.stealth.event_priority["investigate"] = 0;
  level.stealth.event_priority["cover_blown"] = 1;
  level.stealth.event_priority["combat"] = 2;
  level scripts\stealth\utility::set_stealth_func("broadcast", ::event_broadcast_generic);
}

event_severity_compare(_id_E1B6AF8308EE295D, _id_E1B6AC8308EE22C4) {
  result = level.stealth.event_priority[_id_E1B6AF8308EE295D] - level.stealth.event_priority[_id_E1B6AC8308EE22C4];
  return result;
}

event_severity_shift(_id_F945CC6444AD364E, direction) {
  priority = level.stealth.event_priority[_id_F945CC6444AD364E] + direction;

  foreach(_id_9339B42BBF1C7735, _id_96BC11F18055BC8C in level.stealth.event_priority) {
    if(_id_96BC11F18055BC8C == priority)
      return _id_9339B42BBF1C7735;
  }

  return _id_F945CC6444AD364E;
}

event_severity_set(_id_F945CC6444AD364E, eventname, _id_A3A9959B0A31F7BC, _id_6E7A5F49FCA478A9, _id_691D20C978D21CD1) {
  if(!isDefined(_id_A3A9959B0A31F7BC))
    _id_A3A9959B0A31F7BC = 0;

  if(!isDefined(_id_6E7A5F49FCA478A9))
    _id_6E7A5F49FCA478A9 = 0.0;

  if(!isDefined(level.stealth.event_severity))
    level.stealth.event_severity = [];

  if(!isDefined(level.stealth.event_escalation))
    level.stealth.event_escalation = [];

  if(!isDefined(level.stealth.event_escalation_scalars))
    level.stealth.event_escalation_scalars = [];

  if(!isDefined(level.stealth.event_escalation_to_combat))
    level.stealth.event_escalation_to_combat = [];

  level.stealth.event_severity[eventname] = _id_F945CC6444AD364E;
  level.stealth.event_escalation[eventname] = _id_A3A9959B0A31F7BC;
  level.stealth.event_escalation_scalars[eventname] = _id_6E7A5F49FCA478A9;
  level.stealth.event_escalation_to_combat[eventname] = _id_691D20C978D21CD1;
}

event_severity_get(eventname) {
  return _func_DF4360488E5C458E(eventname);
}

event_escalation_get(eventname) {
  return _func_9846F68B2EDD52D5(eventname);
}

event_escalation_scalar_get(eventname) {
  return _func_1473E5C0181C7AD0(eventname);
}

event_escalation_to_combat_get(eventname) {
  return _func_67FEE9F22662295C(eventname);
}

_id_CE9FDD8D28D5D8DD(eventname) {
  return _func_63C101C16F5F40BE(eventname);
}

event_escalation_clear() {
  self.stealth.event_escalation_count = undefined;
  self.event_escalation_scalar = 0.0;
}

_id_1F4D13D0F711BA69(event, _id_F44AAAEEDD6BF35B) {
  if(isDefined(level._id_01A6C1600565C49A))
    thread[[level._id_01A6C1600565C49A]](event);
}

event_listener_thread() {
  self notify("event_listener_thread");
  self endon("event_listener_thread");
  self endon("death");
  _id_8E9D5073BB8A9872 = ["footstep", "footstep_sprint", "footstep_walk", "swim", "swim_sprint", "silenced_shot_impact", "gunshot_impact"];

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    self waittill("ai_events", events);

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }
    if(self.ignoreall || self isragdoll()) {
      continue;
    }
    _id_BA0AE3F9F364B7F3 = 0;

    foreach(event in events) {
      if(!isDefined(event.entity)) {
        continue;
      }
      if(istrue(event._id_F049A0914F8EEB8A)) {
        _id_1F4D13D0F711BA69(event, 1);
        continue;
      }

      if(issentient(event.entity) && (event.entity.ignoreme || event.entity.notarget)) {
        continue;
      }
      if(isDefined(event.entity.ownervehicle)) {
        if(event.entity.ownervehicle.vehicletype == "capital_ship")
          continue;
      }

      event.typeorig = event.type;
      event.receiver = self;
      _id_69F56E266D8FD66E = event_severity_get(event.type);
      _id_A3A9959B0A31F7BC = undefined;
      _id_6E7A5F49FCA478A9 = undefined;
      _id_691D20C978D21CD1 = undefined;

      if(isDefined(_id_69F56E266D8FD66E)) {
        if(!istrue(self.disableescalation) && _id_69F56E266D8FD66E != "combat") {
          _id_A3A9959B0A31F7BC = event_escalation_get(event.type);
          _id_6E7A5F49FCA478A9 = event_escalation_scalar_get(event.type);
          _id_691D20C978D21CD1 = event_escalation_to_combat_get(event.type);

          if(_id_A3A9959B0A31F7BC > 0) {
            if(!isDefined(self.stealth.event_escalation_count))
              self.stealth.event_escalation_count = [];

            if(!isDefined(self.stealth.event_escalation_count[event.type]))
              self.stealth.event_escalation_count[event.type] = 0;

            if(isDefined(_id_691D20C978D21CD1) && self.stealth.event_escalation_count[event.type] + 1 >= _id_691D20C978D21CD1) {
              _id_69F56E266D8FD66E = event_severity_shift(_id_69F56E266D8FD66E, 2);
              self._id_1CE6CC13577E5C02 = 1;
              self._id_B53DBEA738760E5B = event.entity;
              event.origin = event.entity.origin;
            } else if(self.stealth.event_escalation_count[event.type] + 1 >= _id_A3A9959B0A31F7BC)
              _id_69F56E266D8FD66E = event_severity_shift(_id_69F56E266D8FD66E, 1);
            else if(isDefined(_id_691D20C978D21CD1) && self.event_escalation_scalar + _id_6E7A5F49FCA478A9 >= 4.0) {
              _id_69F56E266D8FD66E = event_severity_shift(_id_69F56E266D8FD66E, 2);
              self._id_1CE6CC13577E5C02 = 1;
              self._id_B53DBEA738760E5B = event.entity;
              event.origin = event.entity.origin;
            } else if(self.event_escalation_scalar + _id_6E7A5F49FCA478A9 >= 1.0)
              _id_69F56E266D8FD66E = event_severity_shift(_id_69F56E266D8FD66E, 1);
          }
        }

        _id_982EACB9C5D8EAFC = _id_CE9FDD8D28D5D8DD(event.type);

        if(_id_69F56E266D8FD66E == "cover_blown" && _id_982EACB9C5D8EAFC >= 0) {
          if(distancesquared(self.origin, event.origin) <= _id_982EACB9C5D8EAFC)
            _id_69F56E266D8FD66E = event_severity_shift(_id_69F56E266D8FD66E, 1);
        }

        event.type = _id_69F56E266D8FD66E;
      }

      eventpriority = level.stealth.event_priority[event.type];
      _id_1CAE237216505434 = isDefined(eventpriority);

      if(!_id_1CAE237216505434 || eventpriority >= _id_BA0AE3F9F364B7F3) {
        if(_id_1CAE237216505434)
          _id_BA0AE3F9F364B7F3 = eventpriority;

        if(!isDefined(self.stealth._id_4C1415714F92586F))
          self.stealth._id_4C1415714F92586F = [];

        if(!scripts\engine\utility::array_contains(_id_8E9D5073BB8A9872, event.typeorig)) {
          if(!isDefined(self.stealth._id_4C1415714F92586F[event.typeorig])) {
            self.stealth._id_4C1415714F92586F[event.typeorig] = gettime();
            _id_F44AAAEEDD6BF35B = scripts\stealth\callbacks::stealth_call_thread(event.type, event);
          } else if(gettime() >= self.stealth._id_4C1415714F92586F[event.typeorig] + 320) {
            self.stealth._id_4C1415714F92586F[event.typeorig] = gettime();
            _id_F44AAAEEDD6BF35B = scripts\stealth\callbacks::stealth_call_thread(event.type, event);
          } else
            _id_F44AAAEEDD6BF35B = 0;
        } else
          _id_F44AAAEEDD6BF35B = scripts\stealth\callbacks::stealth_call_thread(event.type, event);

        if(istrue(_id_F44AAAEEDD6BF35B) && isDefined(_id_A3A9959B0A31F7BC) && event.type != "combat") {
          if(_id_A3A9959B0A31F7BC > 0 && isDefined(self.stealth.event_escalation_count) && isDefined(self.stealth.event_escalation_count[event.typeorig]))
            self.stealth.event_escalation_count[event.typeorig]++;

          self.event_escalation_scalar = self.event_escalation_scalar + _id_6E7A5F49FCA478A9;
        }

        _id_1F4D13D0F711BA69(event, _id_F44AAAEEDD6BF35B);
      }
    }
  }
}

entity_is_approved(entity) {
  switch (entity.classname) {
    case "script_vehicle_blackhornet":
      return 1;
    default:
      return 0;
  }
}

event_broadcast_axis(eventtype, _id_AD9E88AD94128D67, enemy, _id_448A418E975E9B01, _id_6A01DAAB475B44AB) {
  _id_8BAB3203A26744B8 = getaiunittypearray("bad_guys", "all");
  _id_B2E38CD9C1E056A5 = squared(_id_448A418E975E9B01);
  _id_6292D181CC8B8F1B = squared(_id_6A01DAAB475B44AB);
  _id_A20AF37D85939806 = self.team;

  if(!isDefined(_id_A20AF37D85939806))
    _id_A20AF37D85939806 = self.agentteam;

  _id_291D5EED4387426D = issentient(enemy);

  foreach(ai in _id_8BAB3203A26744B8) {
    if(!isalive(ai)) {
      continue;
    }
    if(ai == self) {
      continue;
    }
    if(ai.team != _id_A20AF37D85939806) {
      continue;
    }
    if(!isDefined(ai.stealth)) {
      continue;
    }
    _id_B786F626CEF686D0 = 0;
    distsq = distancesquared(ai.origin, self.origin);

    if(distsq <= _id_B2E38CD9C1E056A5)
      _id_B786F626CEF686D0 = self hastacvis(ai);

    if(!_id_B786F626CEF686D0 && distsq <= _id_6292D181CC8B8F1B) {
      if(ai scripts\stealth\utility::is_visible(self) || ai scripts\stealth\utility::is_visible(enemy))
        _id_B786F626CEF686D0 = 1;
    }

    if(ai[[ai.fnisinstealthcombat]]()) {
      if(_id_B786F626CEF686D0)
        ai getenemyinfo(enemy);

      continue;
    }

    if(_id_B786F626CEF686D0) {
      if(_id_291D5EED4387426D && ai lastknowntime(enemy) == 0) {
        ai aieventlistenerevent(eventtype, enemy, self.origin);
        continue;
      }

      ai aieventlistenerevent(eventtype, enemy, enemy.origin);
    }
  }
}

event_broadcast_generic(eventtype, _id_43F256778AC8F6A8, _id_9836DF1FB7E76589, _id_F23A20B5D39DBF34) {
  _id_8BAB3203A26744B8 = getaiunittypearray("bad_guys");

  if(!isDefined(_id_F23A20B5D39DBF34))
    _id_F23A20B5D39DBF34 = level.player;

  _id_B2E38CD9C1E056A5 = squared(_id_9836DF1FB7E76589);

  foreach(ai in _id_8BAB3203A26744B8) {
    if(!isalive(ai)) {
      continue;
    }
    if(!isDefined(ai.stealth)) {
      continue;
    }
    if(distancesquared(ai.origin, _id_43F256778AC8F6A8) <= _id_B2E38CD9C1E056A5)
      ai aieventlistenerevent(eventtype, _id_F23A20B5D39DBF34, _id_43F256778AC8F6A8);
  }
}

event_broadcast_axis_by_tacsight(eventtype, enemy, _id_43F256778AC8F6A8, _id_9836DF1FB7E76589, _id_BE714C91530BA6CA, _id_33D9F922BB21C778, _id_81A2FB4F638BBCE8) {
  _id_8BAB3203A26744B8 = getaiunittypearray("bad_guys", "all");
  _id_29B1911EEE2BCB5C = _id_9836DF1FB7E76589 * _id_9836DF1FB7E76589;

  if(!isDefined(_id_BE714C91530BA6CA))
    _id_BE714C91530BA6CA = 1;

  _id_8DFD9C1CB37614B0 = undefined;

  if(isDefined(_id_81A2FB4F638BBCE8))
    _id_8DFD9C1CB37614B0 = _id_81A2FB4F638BBCE8 * _id_81A2FB4F638BBCE8;

  if(!isDefined(_id_33D9F922BB21C778))
    _id_33D9F922BB21C778 = _id_43F256778AC8F6A8;

  foreach(ai in _id_8BAB3203A26744B8) {
    if(!isalive(ai)) {
      continue;
    }
    if(!isDefined(ai.stealth)) {
      continue;
    }
    _id_DBB6869E366C8AA4 = distancesquared(ai.origin, _id_43F256778AC8F6A8);

    if(_id_DBB6869E366C8AA4 > _id_29B1911EEE2BCB5C) {
      continue;
    }
    _id_771837493A52B2F7 = _id_BE714C91530BA6CA;

    if(_id_BE714C91530BA6CA && isDefined(_id_8DFD9C1CB37614B0) && _id_DBB6869E366C8AA4 <= _id_8DFD9C1CB37614B0)
      _id_771837493A52B2F7 = 0;

    if(!ai hastacvis(_id_33D9F922BB21C778, _id_771837493A52B2F7)) {
      continue;
    }
    ai aieventlistenerevent(eventtype, enemy, _id_43F256778AC8F6A8);
  }
}

event_broadcast_axis_by_sight(eventtype, enemy, _id_43F256778AC8F6A8, _id_9836DF1FB7E76589, _id_BE714C91530BA6CA, _id_33D9F922BB21C778, _id_601D79340374BC27) {
  thread event_broadcast_axis_by_sight_thread(eventtype, enemy, _id_43F256778AC8F6A8, _id_9836DF1FB7E76589, _id_BE714C91530BA6CA, _id_33D9F922BB21C778, _id_601D79340374BC27);
}

event_broadcast_axis_by_sight_thread(eventtype, enemy, _id_43F256778AC8F6A8, _id_9836DF1FB7E76589, _id_BE714C91530BA6CA, _id_33D9F922BB21C778, _id_601D79340374BC27) {
  _id_8BAB3203A26744B8 = getaiunittypearray("bad_guys", "all");
  _id_29B1911EEE2BCB5C = _id_9836DF1FB7E76589 * _id_9836DF1FB7E76589;

  if(!isDefined(_id_BE714C91530BA6CA))
    _id_BE714C91530BA6CA = 1;

  if(!isDefined(_id_33D9F922BB21C778))
    _id_33D9F922BB21C778 = _id_43F256778AC8F6A8;

  _id_2068A3EFD793AFBA = 3;
  _id_C9787ABB0668D729 = 0;

  foreach(ai in _id_8BAB3203A26744B8) {
    if(!isalive(ai)) {
      continue;
    }
    if(!isDefined(ai.stealth)) {
      continue;
    }
    distsq = distancesquared(ai.origin, _id_43F256778AC8F6A8);

    if(distsq > _id_29B1911EEE2BCB5C) {
      continue;
    }
    if(isDefined(_id_601D79340374BC27) && distsq <= _id_601D79340374BC27 * _id_601D79340374BC27) {
      ai aieventlistenerevent(eventtype, enemy, _id_43F256778AC8F6A8);
      continue;
    }

    if(!ai hastacvis(_id_33D9F922BB21C778, _id_BE714C91530BA6CA)) {
      if(_id_BE714C91530BA6CA && !ai aipointinfov(_id_43F256778AC8F6A8)) {
        continue;
      }
      _id_C9787ABB0668D729++;

      if(_id_C9787ABB0668D729 > _id_2068A3EFD793AFBA) {
        waitframe();
        _id_C9787ABB0668D729 = 0;

        if(!isalive(ai))
          continue;
      }

      if(!sighttracepassed(ai getEye(), _id_43F256778AC8F6A8, 0, enemy))
        continue;
    }

    ai aieventlistenerevent(eventtype, enemy, _id_43F256778AC8F6A8);
  }
}

_id_1D0ABF2C82B32237() {
  return getdvarint("ai_debugEntIndex");
}
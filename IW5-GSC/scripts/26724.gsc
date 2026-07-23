/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26724.gsc
**************************************/

ge_createeventmanager(var_0, var_1, var_2) {
  if(!isDefined(level._gameeventmanagers)) {
    thread _ge_processthread();
  }
  var_3 = spawnStruct();
  level._gameeventmanagers[var_0] = var_3;
  var_3.availablecost = var_1;

  if(isarray(var_1)) {
    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_3.currentactivecost[var_4] = 0;
    }
  } else {
    var_3.currentactivecost = 0;
  }
  var_3.waiting = spawnStruct();
  var_3.active = spawnStruct();
  var_3.classes = var_2;
  var_3.index = 0;
}

_ge_countevents(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_0.head)) {
    for(var_0 = var_0.head; isDefined(var_0); var_0 = var_0._next) {
      if(!isDefined(var_1) || var_0.class == var_1) {
        var_2++;
      }
    }
  }

  return var_2;
}

ge_initdebugging() {}

_ge_canafford(var_0, var_1) {
  if(var_0.priority >= 100) {
    return 1;
  }
  if(isarray(var_1.availablecost)) {
    for(var_2 = 0; var_2 < var_1.availablecost.size; var_2++) {
      if(var_0._id_3EC1[var_2] + var_1.currentactivecost[var_2] > var_1.availablecost[var_2]) {
        return 0;
      }
    }
  } else if(var_0._id_3EC1 + var_1.currentactivecost > var_1.availablecost) {
    return 0;
  }
  return 1;
}

_ge_addcosttoactive(var_0, var_1) {
  if(isarray(var_1.availablecost)) {
    for(var_2 = 0; var_2 < var_1.availablecost.size; var_2++) {
      var_1.currentactivecost[var_2] = var_1.currentactivecost[var_2] + var_0._id_3EC1[var_2];
    }
  } else {
    var_1.currentactivecost = var_1.currentactivecost + var_0._id_3EC1;
  }
}

_ge_subtractcosttoactive(var_0, var_1) {
  if(isarray(var_1.availablecost)) {
    for(var_2 = 0; var_2 < var_1.availablecost.size; var_2++) {
      var_1.currentactivecost[var_2] = var_1.currentactivecost[var_2] - var_0._id_3EC1[var_2];
    }
  } else {
    var_1.currentactivecost = var_1.currentactivecost - var_0._id_3EC1;
  }
}

_ge_processmanager(var_0, var_1) {
  if(isDefined(var_1.waiting.head)) {
    var_2 = var_1.waiting.head;

    if(_ge_canafford(var_2, var_1)) {
      var_1.waiting.head = var_2._next;

      if(isDefined(var_1.waiting.head)) {
        var_1.waiting.head._prev = undefined;
      } else {
        var_1.waiting.tail = undefined;
      }
      var_2._next = undefined;

      if(isDefined(var_1.active.tail)) {
        var_1.active.tail._next = var_2;
        var_2._prev = var_1.active.tail;
        var_1.active.tail = var_2;
      } else {
        var_1.active.head = var_2;
        var_1.active.tail = var_2;
      }

      var_2._active = 1;
      _ge_addcosttoactive(var_2, var_1);

      if(isDefined(var_2.activate_cb)) {
        thread[[var_2.activate_cb]](var_2);
      }
    }
  }
}

_ge_processthread() {
  for(;;) {
    if(isDefined(level._gameeventmanagers)) {
      foreach(var_2, var_1 in level._gameeventmanagers) {}
      _ge_processmanager(var_2, var_1);
    }

    wait 0.05;
  }
}

ge_createevent(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.priority = var_1;
  var_3.class = var_2;
  var_3._id_3EC1 = var_0;
  var_3._active = 0;
  return var_3;
}

ge_addevent(var_0, var_1) {
  var_2 = level._gameeventmanagers[var_0];
  var_1._mgr = var_2;
  var_1.id = var_2.index;
  var_2.index++;
  var_7 = var_2.waiting.head;
  var_8 = undefined;

  while(isDefined(var_7)) {
    if(var_1.priority > var_7.priority) {
      if(isDefined(var_8)) {
        var_8._next = var_1;
        var_1._prev = var_8;
      } else {
        var_2.waiting.head = var_1;
      }
      var_1._next = var_7;
      var_7._prev = var_1;
      break;
    } else {
      var_8 = var_7;
      var_7 = var_7._next;
    }
  }

  if(!isDefined(var_7)) {
    if(isDefined(var_8)) {
      var_8._next = var_1;
      var_1._prev = var_8;
    } else {
      var_2.waiting.head = var_1;
    }
  }

  if(!isDefined(var_1._next)) {
    var_2.waiting.tail = var_1;
  }
}

_ge_removeevent(var_0, var_1) {
  var_2 = var_1._prev;
  var_3 = var_1._next;

  if(isDefined(var_2)) {
    var_2._next = var_3;
  } else {
    var_0.head = var_1._next;
  }
  if(isDefined(var_3)) {
    var_3._prev = var_2;
  } else {
    var_0.tail = var_1._prev;
  }
  var_1._prev = undefined;
  var_1._next = undefined;
  var_1._active = -1;
}

_ge_removeactiveevent(var_0, var_1, var_2) {
  if(var_2 && isDefined(var_1.kill_cb)) {
    [[var_1.kill_cb]](var_1);
  }
  _ge_subtractcosttoactive(var_1, var_0);
  _ge_removeevent(var_0.active, var_1);
  var_1 notify("killed");
}

_ge_removewaitingevent(var_0, var_1, var_2) {
  if(var_2 && isDefined(var_1.cancel_cb)) {
    [[var_1.cancel_cb]](var_1);
  }
  _ge_removeevent(var_0.waiting, var_1);
}

ge_flushevents(var_0, var_1) {
  var_2 = level._gameeventmanagers[var_0];

  for(var_3 = var_2.waiting.head; isDefined(var_3); var_3 = var_4) {
    var_4 = var_3._next;

    if(isarray(var_1)) {
      foreach(var_6 in var_1) {
        if(var_3.class == var_6) {
          _ge_removewaitingevent(var_2, var_3, 1);
          break;
        }
      }

      continue;
    }

    if(var_3.class == var_1) {
      _ge_removewaitingevent(var_2, var_3, 1);
    }
  }

  for(var_3 = var_2.active.head; isDefined(var_3); var_3 = var_4) {
    var_4 = var_3._next;

    if(isarray(var_1)) {
      foreach(var_6 in var_1) {
        if(var_3.class == var_6) {
          _ge_removeactiveevent(var_2, var_3, 1);
          break;
        }
      }

      continue;
    }

    if(var_3.class == var_1) {
      _ge_removeactiveevent(var_2, var_3, 1);
    }
  }
}

ge_eventfinished(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0._active < 0) {
    return;
  }
  var_2 = var_0._mgr;

  if(var_0._active) {
    _ge_removeactiveevent(var_2, var_0, 0);
  } else {
    _ge_removewaitingevent(var_2, var_0, 0);
  }
}

ge_findnexteventbyname(var_0, var_1) {
  if(isDefined(var_0)) {
    while(isDefined(var_0)) {
      if(isDefined(var_0.name) && var_0.name == var_1) {
        break;
      }

      var_0 = var_0._next;
    }
  }

  return var_0;
}

ge_findwaitingeventbyname(var_0, var_1) {
  var_2 = level._gameeventmanagers[var_0];
  var_3 = var_2.waiting.head;
  return ge_findnexteventbyname(var_3, var_1);
}

ge_findactiveeventbyname(var_0, var_1) {
  var_2 = level._gameeventmanagers[var_0];
  var_3 = var_2.active.head;
  return ge_findnexteventbyname(var_3, var_1);
}

_ge_counteventsbyname(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    while(isDefined(var_0)) {
      if(isDefined(var_0.name) && var_0.name == var_1) {
        var_2++;
      }
      var_0 = var_0._next;
    }
  }

  return var_2;
}

ge_countwaitingeventbyname(var_0, var_1) {
  var_2 = level._gameeventmanagers[var_0];
  var_3 = var_2.waiting.head;
  return _ge_counteventsbyname(var_3, var_1);
}

ge_countactiveeventbyname(var_0, var_1) {
  var_2 = level._gameeventmanagers[var_0];
  var_3 = var_2.active.head;
  return _ge_counteventsbyname(var_3, var_1);
}

ge_addeffect(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }
  var_5 = _ge_addeffectevent(var_2, var_3, var_4);
  var_5.fxname = var_0;
  var_5.lifetime = var_1;
  return var_5;
}

_ge_addeffectevent(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 100;
  }
  if(!isDefined(var_1)) {
    var_1 = 100;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  var_3 = ge_createevent(var_0, var_1, var_2);
  var_3.activate_cb = ::_ge_activateeffect;
  var_3.cancel_cb = ::_ge_canceleffect;
  var_3.kill_cb = ::_ge_killeffect;
  ge_addevent("fx", var_3);
  return var_3;
}

_ge_activateeffect(var_0) {
  var_0 endon("killed");
}

_ge_canceleffect(var_0) {}

_ge_killeffect(var_0) {}

ge_addexploder(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }
  var_5 = _ge_addexploderevent(var_2, var_3, var_4);
  var_5.fxnid = var_0;
  var_5.lifetime = var_1;
}

_ge_addexploderevent(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 100;
  }
  if(!isDefined(var_1)) {
    var_1 = 100;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  var_3 = ge_createevent(var_0, var_1, var_2);
  var_3.activate_cb = ::_ge_activateexploder;
  var_3.kill_cb = ::_ge_killexploder;
  ge_addevent("fx", var_3);
  return var_3;
}

_ge_activateexploder(var_0) {
  var_0 endon("killed");
  common_scripts\utility::exploder(var_0.fxid);

  if(isDefined(var_0.lifetime)) {
    if(var_0.lifetime == 0) {
      ge_eventfinished("fx", var_0);
    } else if(var_0.lifetime > 0) {
      wait(var_0.lifetime);
      ge_eventfinished("fx", var_0);
    }
  }
}

_ge_killexploder(var_0) {}

ge_addnotify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = ge_createevent(var_4, var_5, var_6);
  var_8.activate_msg = var_1;
  var_8.cancel_msg = var_2;
  var_8.kill_msg = var_3;
  var_8.activate_cb = ::_ge_activatenotify;
  var_8.cancel_cb = ::_ge_cancelnotify;
  var_8.kill_cb = ::_ge_killnotify;
  var_8.name = var_7;
  ge_addevent(var_0, var_8);
  return var_8;
}

ge_addnotifywait(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = ge_addnotify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  var_8 waittill(var_1);
  return var_8;
}

_ge_notify(var_0, var_1) {
  var_0 notify(var_1);

  if(isDefined(var_0.ent)) {
    var_0.ent notify(var_1);
  }
}

_ge_activatenotify(var_0) {
  _ge_notify(var_0, var_0.activate_msg);
}

_ge_cancelnotify(var_0) {
  _ge_notify(var_0, var_0.cancel_msg);
}

_ge_killnotify(var_0) {
  _ge_notify(var_0, var_0.kill_msg);
}

ge_addfxnotify(var_0, var_1, var_2, var_3, var_4, var_5) {
  return ge_addnotify("fx", var_0, var_1, var_2, var_3, var_4, var_5);
}

ge_addfxnotifywait(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return ge_addnotifywait("fx", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

ge_addalways(var_0, var_1, var_2, var_3) {
  var_4 = ge_createevent(var_1, var_2, var_3);
  ge_addevent(var_0, var_4);
}
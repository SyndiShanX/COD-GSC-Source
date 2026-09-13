/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\callbacks.gsc
***********************************************/

callback(event, params) {
  if(!isDefined(params))
    params = spawnStruct();

  _id_F3847410A67A3098(level, event, params);

  if(self != level)
    _id_F3847410A67A3098(self, event, params);
}

_id_A9A73BDC67341ED1(event, params) {
  _id_8BAB3203A26744B8 = getaiarray();

  foreach(ai in _id_8BAB3203A26744B8)
  ai _id_F3847410A67A3098(ai, event, params);
}

_id_1F1EB4CB8C61E6BF(event, params) {
  players = level.players;

  foreach(player in players) {
    player _id_F3847410A67A3098(level, event, params);
    player _id_F3847410A67A3098(player, event, params);
  }
}

_id_F3847410A67A3098(ent, event, params) {
  callbacks = undefined;

  if(isDefined(ent._id_9C44B69C1812847A))
    callbacks = ent._id_9C44B69C1812847A[event];

  if(isDefined(callbacks)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < callbacks.size; _id_AC0E594AC96AA3A8++) {
      _id_AC99309FBA88094E = callbacks[_id_AC0E594AC96AA3A8];

      if(!isarray(_id_AC99309FBA88094E)) {
        continue;
      }
      callback = _id_AC99309FBA88094E[0];

      if(!isfunction(callback)) {
        return;
      }
      _id_732AD454C46F92FD = _id_AC99309FBA88094E[1];

      if(isDefined(_id_732AD454C46F92FD)) {
        self thread[[callback]](params, _id_732AD454C46F92FD);
        continue;
      }

      self thread[[callback]](params);
    }

    ent._id_9C44B69C1812847A[event] = _id_48EBCAEB418901B9(callbacks);
  }
}

_id_52004C7A02FCFFD6(event, func, _id_732AD454C46F92FD) {
  if(!isfunction(func)) {
    return;
  }
  if(!isDefined(self._id_9C44B69C1812847A) || !isDefined(self._id_9C44B69C1812847A[event]))
    self._id_9C44B69C1812847A[event] = [];

  self._id_9C44B69C1812847A[event][self._id_9C44B69C1812847A[event].size] = [func, _id_732AD454C46F92FD];
}

_id_99B0CBEEC73DD75D(event, func, _id_5E0065A1DC2434B6) {
  if(!isDefined(self._id_9C44B69C1812847A)) {
    return;
  }
  if(isDefined(func) && isstring(func) && func == "all") {
    self._id_9C44B69C1812847A[event] = [];
    return;
  }

  if(!isDefined(self._id_9C44B69C1812847A[event])) {
    return;
  }
  if(istrue(_id_5E0065A1DC2434B6)) {
    self._id_9C44B69C1812847A[event] = _id_48EBCAEB418901B9(self._id_9C44B69C1812847A[event]);
    return;
  }

  foreach(index, _id_265771CC82FC994F in self._id_9C44B69C1812847A[event]) {
    if(isarray(_id_265771CC82FC994F) && _id_265771CC82FC994F[0] == func) {
      self._id_9C44B69C1812847A[event][index] = 0;
      break;
    }
  }
}

_id_48EBCAEB418901B9(callbacks) {
  result = [];

  foreach(_id_CE174178F5680DFC in callbacks) {
    if(isint(_id_CE174178F5680DFC) && _id_CE174178F5680DFC == 0) {
      continue;
    }
    result[result.size] = _id_CE174178F5680DFC;
  }

  return result;
}
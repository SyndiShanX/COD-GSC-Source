/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\script.gsc
***********************************************/

waittillslowprocessallowed(_id_57AF160DEA220AAC) {
  if(level.lastslowprocessframe == gettime()) {
    if(isDefined(_id_57AF160DEA220AAC) && _id_57AF160DEA220AAC) {
      while(level.lastslowprocessframe == gettime())
        wait 0.05;
    } else {
      wait 0.05;

      if(level.lastslowprocessframe == gettime()) {
        wait 0.05;

        if(level.lastslowprocessframe == gettime()) {
          wait 0.05;

          if(level.lastslowprocessframe == gettime())
            wait 0.05;
        }
      }
    }
  }

  level.lastslowprocessframe = gettime();
}

queuecreate(_id_475B35E5FA06C837) {
  if(!isDefined(level.queues))
    level.queues = [];

  level.queues[_id_475B35E5FA06C837] = [];
}

queueadd(_id_475B35E5FA06C837, entity) {
  level.queues[_id_475B35E5FA06C837][level.queues[_id_475B35E5FA06C837].size] = entity;
}

queueremovefirst(_id_475B35E5FA06C837) {
  _id_19E7EC57B8CFB985 = undefined;
  _id_DE3092683946E980 = [];

  foreach(_id_F7806D4CF24AACD3 in level.queues[_id_475B35E5FA06C837]) {
    if(!isDefined(_id_F7806D4CF24AACD3)) {
      continue;
    }
    if(!isDefined(_id_19E7EC57B8CFB985)) {
      _id_19E7EC57B8CFB985 = _id_F7806D4CF24AACD3;
      continue;
    }

    _id_DE3092683946E980[_id_DE3092683946E980.size] = _id_F7806D4CF24AACD3;
  }

  level.queues[_id_475B35E5FA06C837] = _id_DE3092683946E980;
  return _id_19E7EC57B8CFB985;
}

quicksort(array, _id_D35FC50E2F1F14DF) {
  return quicksortmid(array, 0, array.size - 1, _id_D35FC50E2F1F14DF);
}

quicksortmid(array, start, end, _id_D35FC50E2F1F14DF) {
  _id_AC0E594AC96AA3A8 = start;
  _id_AC0E5B4AC96AA80E = end;

  if(!isDefined(_id_D35FC50E2F1F14DF))
    _id_D35FC50E2F1F14DF = ::quicksort_compare;

  if(end - start >= 1) {
    pivot = array[start];

    while(_id_AC0E5B4AC96AA80E > _id_AC0E594AC96AA3A8) {
      while([[_id_D35FC50E2F1F14DF]](array[_id_AC0E594AC96AA3A8], pivot) && _id_AC0E594AC96AA3A8 <= end && _id_AC0E5B4AC96AA80E > _id_AC0E594AC96AA3A8)
        _id_AC0E594AC96AA3A8++;

      while(![[_id_D35FC50E2F1F14DF]](array[_id_AC0E5B4AC96AA80E], pivot) && _id_AC0E5B4AC96AA80E >= start && _id_AC0E5B4AC96AA80E >= _id_AC0E594AC96AA3A8)
        _id_AC0E5B4AC96AA80E--;

      if(_id_AC0E5B4AC96AA80E > _id_AC0E594AC96AA3A8)
        array = swap(array, _id_AC0E594AC96AA3A8, _id_AC0E5B4AC96AA80E);
    }

    array = swap(array, start, _id_AC0E5B4AC96AA80E);
    array = quicksortmid(array, start, _id_AC0E5B4AC96AA80E - 1, _id_D35FC50E2F1F14DF);
    array = quicksortmid(array, _id_AC0E5B4AC96AA80E + 1, end, _id_D35FC50E2F1F14DF);
  } else
    return array;

  return array;
}

quicksort_compare(left, right) {
  return left <= right;
}

swap(array, _id_5A488D6BAE780D02, _id_5A488C6BAE780ACF) {
  temp = array[_id_5A488D6BAE780D02];
  array[_id_5A488D6BAE780D02] = array[_id_5A488C6BAE780ACF];
  array[_id_5A488C6BAE780ACF] = temp;
  return array;
}

limitdecimalplaces(value, _id_B25F7BC9B6613CC9) {
  modifier = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B25F7BC9B6613CC9; _id_AC0E594AC96AA3A8++)
    modifier = modifier * 10;

  _id_8F617FFD000EB682 = value * modifier;
  _id_8F617FFD000EB682 = int(_id_8F617FFD000EB682);
  _id_8F617FFD000EB682 = _id_8F617FFD000EB682 / modifier;
  return _id_8F617FFD000EB682;
}

rounddecimalplaces(value, _id_B25F7BC9B6613CC9, style) {
  if(!isDefined(style))
    style = "nearest";

  modifier = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B25F7BC9B6613CC9; _id_AC0E594AC96AA3A8++)
    modifier = modifier * 10;

  _id_8F617FFD000EB682 = value * modifier;

  if(style == "up")
    _id_CE526F59E2A5AD3F = ceil(_id_8F617FFD000EB682);
  else if(style == "down")
    _id_CE526F59E2A5AD3F = floor(_id_8F617FFD000EB682);
  else
    _id_CE526F59E2A5AD3F = _id_8F617FFD000EB682 + 0.5;

  _id_8F617FFD000EB682 = int(_id_CE526F59E2A5AD3F);
  _id_8F617FFD000EB682 = _id_8F617FFD000EB682 / modifier;
  return _id_8F617FFD000EB682;
}

stringtofloat(_id_E0C16711B32B5FE3) {
  _id_1B23D4BE061900E8 = strtok(_id_E0C16711B32B5FE3, ".");
  _id_26BAF6C49C8EDB98 = int(_id_1B23D4BE061900E8[0]);

  if(isDefined(_id_1B23D4BE061900E8[1])) {
    modifier = 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1B23D4BE061900E8[1].size; _id_AC0E594AC96AA3A8++)
      modifier = modifier * 0.1;

    _id_26BAF6C49C8EDB98 = _id_26BAF6C49C8EDB98 + int(_id_1B23D4BE061900E8[1]) * modifier;
  }

  return _id_26BAF6C49C8EDB98;
}

isstrstart(string, _id_DE8A45DD2BF968EC) {
  return getsubstr(string, 0, _id_DE8A45DD2BF968EC.size) == _id_DE8A45DD2BF968EC;
}

array_remove_keep_index(ents, _id_F7E215BD10CC45E9) {
  _id_D674D7970EEF9653 = [];

  foreach(index, ent in ents) {
    if(ent != _id_F7E215BD10CC45E9)
      _id_D674D7970EEF9653[index] = ent;
  }

  return _id_D674D7970EEF9653;
}

delayentdelete(time) {
  self endon("death");
  wait(time);

  if(isDefined(self))
    self delete();
}

roundup(_id_B4A0DB97EE6D9256) {
  if(_id_B4A0DB97EE6D9256 - int(_id_B4A0DB97EE6D9256) >= 0.5)
    return int(_id_B4A0DB97EE6D9256 + 1);
  else
    return int(_id_B4A0DB97EE6D9256);
}

bufferednotify(_id_EA3E3B2121E6713A, param1, param2, param3, param4, param5, param6, param7, param8) {
  thread bufferednotify_internal(_id_EA3E3B2121E6713A, param1, param2, param3, param4, param5, param6, param7, param8);
}

bufferednotify_internal(_id_EA3E3B2121E6713A, param1, param2, param3, param4, param5, param6, param7, param8) {
  self endon("disconnect");
  level endon("game_ended");
  _id_42BC8CAB1454C047 = "bufferedNotify_" + _id_EA3E3B2121E6713A;
  self notify(_id_42BC8CAB1454C047);
  self endon(_id_42BC8CAB1454C047);

  if(!isDefined(self.bufferednotifications))
    self.bufferednotifications = [];

  if(!isDefined(self.bufferednotifications[_id_EA3E3B2121E6713A]))
    self.bufferednotifications[_id_EA3E3B2121E6713A] = [];

  _id_6C1755E925291505 = spawnStruct();
  _id_6C1755E925291505.param1 = param1;
  _id_6C1755E925291505.param2 = param2;
  _id_6C1755E925291505.param3 = param3;
  _id_6C1755E925291505.param4 = param4;
  _id_6C1755E925291505.param5 = param5;
  _id_6C1755E925291505.param6 = param6;
  _id_6C1755E925291505.param7 = param7;
  _id_6C1755E925291505.param8 = param8;
  self.bufferednotifications[_id_EA3E3B2121E6713A][self.bufferednotifications[_id_EA3E3B2121E6713A].size] = _id_6C1755E925291505;
  waittillframeend;

  while(self.bufferednotifications[_id_EA3E3B2121E6713A].size > 0) {
    _id_6C1755E925291505 = self.bufferednotifications[_id_EA3E3B2121E6713A][0];
    self notify(_id_EA3E3B2121E6713A, _id_6C1755E925291505.param1, _id_6C1755E925291505.param2, _id_6C1755E925291505.param3, _id_6C1755E925291505.param4, _id_6C1755E925291505.param5, _id_6C1755E925291505.param6, _id_6C1755E925291505.param7, _id_6C1755E925291505.param8);
    self.bufferednotifications[_id_EA3E3B2121E6713A] = scripts\engine\utility::array_remove_index(self.bufferednotifications[_id_EA3E3B2121E6713A], 0);
    waitframe();
  }
}

notifyafterframeend(_id_9FACC6F327E1E6B4, _id_7239F8830EF22B43) {
  self waittill(_id_9FACC6F327E1E6B4);
  waittillframeend;
  self notify(_id_7239F8830EF22B43);
}

delaysetclientomnvar(_id_74B5B12BB6514385, omnvar, value) {
  self endon("disconnect");
  wait(_id_74B5B12BB6514385);
  self setclientomnvar(omnvar, value);
}

strip_suffix(_id_A3C267C12168AE42, _id_7C7C8BEF8B9787B0) {
  if(_id_A3C267C12168AE42.size <= _id_7C7C8BEF8B9787B0.size)
    return _id_A3C267C12168AE42;

  if(getsubstr(_id_A3C267C12168AE42, _id_A3C267C12168AE42.size - _id_7C7C8BEF8B9787B0.size, _id_A3C267C12168AE42.size) == _id_7C7C8BEF8B9787B0)
    return getsubstr(_id_A3C267C12168AE42, 0, _id_A3C267C12168AE42.size - _id_7C7C8BEF8B9787B0.size);

  return _id_A3C267C12168AE42;
}

isleft2d(startpos, _id_49E63390E090A2A8, _id_990BC5D950404EE5) {
  _id_7799A293BF13FE15 = (startpos[0], startpos[1], 0);
  _id_4C711FE4D7900B43 = (_id_990BC5D950404EE5[0], _id_990BC5D950404EE5[1], 0);
  _id_79868B365E4D18F8 = _id_4C711FE4D7900B43 - _id_7799A293BF13FE15;
  _id_9D9E76097A59CB60 = (_id_49E63390E090A2A8[0], _id_49E63390E090A2A8[1], 0);
  return _id_79868B365E4D18F8[0] * _id_9D9E76097A59CB60[1] - _id_79868B365E4D18F8[1] * _id_9D9E76097A59CB60[0] < 0;
}

vectortoanglessafe(forward, up) {
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  return angles;
}

heap(type) {
  h = spawnStruct();
  h.nvals = 0;
  h.vals = [];

  if(type == "max")
    h.swap = ::_heaplessthan;
  else if(type == "min")
    h.swap = ::_heapgreaterthan;

  return h;
}

heapsize() {
  return self.nvals;
}

heappeek() {
  return self.vals[1];
}

heappop() {
  if(self.nvals == 0)
    return undefined;
  else if(self.nvals == 1) {
    val = self.vals[1];
    self.vals[1] = undefined;
    self.nvals = 0;
    return val;
  } else {
    val = self.vals[1];
    self.vals[1] = self.vals[self.nvals];
    self.vals[self.nvals] = undefined;
    _heapify(1);
    self.nvals = self.nvals - 1;
    return val;
  }
}

heapinsert(val) {
  self.vals[self.nvals + 1] = val;
  _id_AC0E594AC96AA3A8 = self.nvals + 1;
  parent = _heapparent(_id_AC0E594AC96AA3A8);

  while(isDefined(parent)) {
    if([[self.swap]](parent, _id_AC0E594AC96AA3A8)) {
      temp = self.vals[parent];
      self.vals[parent] = self.vals[_id_AC0E594AC96AA3A8];
      self.vals[_id_AC0E594AC96AA3A8] = temp;
      _id_AC0E594AC96AA3A8 = parent;
      parent = _heapparent(_id_AC0E594AC96AA3A8);
      continue;
    }

    break;
  }

  self.nvals = self.nvals + 1;
}

printheap() {
  vals = [];
  _id_A61C75B156FC1EE0 = self.nvals;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++)
    vals[_id_AC0E594AC96AA3A8] = heappop();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < vals.size; _id_AC0E594AC96AA3A8++)
    heapinsert(vals[_id_AC0E594AC96AA3A8]);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < vals.size; _id_AC0E594AC96AA3A8++) {}
}

_heapgreaterthan(_id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41) {
  return self.vals[_id_AC0E594AC96AA3A8] > self.vals[_id_AC0E5C4AC96AAA41];
}

_heaplessthan(_id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41) {
  return self.vals[_id_AC0E594AC96AA3A8] < self.vals[_id_AC0E5C4AC96AAA41];
}

_heapify(_id_AC0E594AC96AA3A8) {
  _id_CE482278F59E590C = _heapleftchild(_id_AC0E594AC96AA3A8);
  _id_CDD54A78F51F882E = _heaprightchild(_id_AC0E594AC96AA3A8);
  _id_D2E8EC5A21155950 = undefined;
  _id_9D2E8C63B1BFD1EF = 0;

  if(isDefined(_id_CE482278F59E590C))
    _id_9D2E8C63B1BFD1EF = self[[self.swap]](_id_AC0E594AC96AA3A8, _id_CE482278F59E590C);

  _id_CAC9AA5D2653CBE0 = 0;

  if(isDefined(_id_CDD54A78F51F882E))
    _id_CAC9AA5D2653CBE0 = self[[self.swap]](_id_AC0E594AC96AA3A8, _id_CDD54A78F51F882E);

  if(!_id_9D2E8C63B1BFD1EF && !_id_CAC9AA5D2653CBE0)
    return;
  else if(_id_9D2E8C63B1BFD1EF && !_id_CAC9AA5D2653CBE0)
    _id_D2E8EC5A21155950 = _id_CE482278F59E590C;
  else if(!_id_9D2E8C63B1BFD1EF && _id_CAC9AA5D2653CBE0)
    _id_D2E8EC5A21155950 = _id_CDD54A78F51F882E;
  else if(self[[self.swap]](_id_CE482278F59E590C, _id_CDD54A78F51F882E))
    _id_D2E8EC5A21155950 = _id_CDD54A78F51F882E;
  else
    _id_D2E8EC5A21155950 = _id_CE482278F59E590C;

  temp = self.vals[_id_AC0E594AC96AA3A8];
  self.vals[_id_AC0E594AC96AA3A8] = self.vals[_id_D2E8EC5A21155950];
  self.vals[_id_D2E8EC5A21155950] = temp;
  _heapify(_id_D2E8EC5A21155950);
}

_heapleftchild(_id_AC0E594AC96AA3A8) {
  if(!isDefined(self.vals[2 * _id_AC0E594AC96AA3A8]))
    return undefined;

  return 2 * _id_AC0E594AC96AA3A8;
}

_heaprightchild(_id_AC0E594AC96AA3A8) {
  if(!isDefined(self.vals[2 * _id_AC0E594AC96AA3A8 + 1]))
    return undefined;

  return 2 * _id_AC0E594AC96AA3A8 + 1;
}

_heapparent(_id_AC0E594AC96AA3A8) {
  if(_id_AC0E594AC96AA3A8 == 1)
    return undefined;

  return int(floor(_id_AC0E594AC96AA3A8 / 2));
}

isnumbermultipleof(number, _id_CCBBA16287668F0A) {
  return number > 0 && number % _id_CCBBA16287668F0A == 0;
}
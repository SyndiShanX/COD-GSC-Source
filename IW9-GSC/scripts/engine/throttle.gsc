/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\throttle.gsc
***********************************************/

_id_9520A7D8B5AEE737(_id_AF6D3CFEC354E8E9) {
  while(isDefined(_id_AF6D3CFEC354E8E9)) {
    _id_4707C765D202D592(_id_AF6D3CFEC354E8E9);
    wait(_id_AF6D3CFEC354E8E9._id_6AF931D445601537);
  }
}

_id_4707C765D202D592(_id_AF6D3CFEC354E8E9) {
  _id_39F9541005AD43FF = 0;

  foreach(item in _id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9) {
    if(!isDefined(item)) {
      continue;
    }
    _id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9 = scripts\engine\utility::array_remove(_id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9, item);
    item notify(_id_AF6D3CFEC354E8E9._id_35615E062783AF3E);
    _id_39F9541005AD43FF++;

    if(_id_39F9541005AD43FF >= _id_AF6D3CFEC354E8E9._id_EC0F28E6EC5932D6) {
      break;
    }
  }
}

_id_E4C99B0F178FFB98(name, _id_0F279291EA98078D, _id_038FC7BD1495C4B2, _id_7CE3DDC2C6EA96FF) {
  _id_AF6D3CFEC354E8E9 = spawnStruct();
  _id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9 = [];
  _id_AF6D3CFEC354E8E9._id_35615E062783AF3E = name + "_wake_up";
  _id_AF6D3CFEC354E8E9._id_EC0F28E6EC5932D6 = scripts\engine\utility::_id_53C4C53197386572(_id_0F279291EA98078D, 1);
  _id_AF6D3CFEC354E8E9._id_6AF931D445601537 = scripts\engine\utility::_id_53C4C53197386572(_id_038FC7BD1495C4B2, level.framedurationseconds);
  _id_AF6D3CFEC354E8E9._id_93B7535B75E941E0 = _id_7CE3DDC2C6EA96FF;
  thread _id_9520A7D8B5AEE737(_id_AF6D3CFEC354E8E9);
  return _id_AF6D3CFEC354E8E9;
}

_id_F632348CBB773537(_id_AF6D3CFEC354E8E9, entity) {
  while(isDefined(_id_AF6D3CFEC354E8E9._id_93B7535B75E941E0) && _id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9.size > _id_AF6D3CFEC354E8E9._id_93B7535B75E941E0)
    _id_4707C765D202D592(_id_AF6D3CFEC354E8E9);

  if(!isDefined(entity)) {
    return;
  }
  if(!isent(entity) && !isstruct(entity)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(_id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9, entity))
    _id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9[_id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9.size] = entity;

  entity endon("death");
  entity endon("delete");
  entity waittill(_id_AF6D3CFEC354E8E9._id_35615E062783AF3E);
}

_id_11AB6D104BF77779(_id_AF6D3CFEC354E8E9, entity) {
  return scripts\engine\utility::array_contains(_id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9, entity);
}

_id_8CE6C42C18618555(_id_AF6D3CFEC354E8E9, entity) {
  _id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9 = scripts\engine\utility::array_remove(_id_AF6D3CFEC354E8E9._id_14CA2465D606A4F9, entity);
}

_id_FFC20A0CD9408D3E() {
  _id_B997916F30000D4A();
  _id_F0E537FAB28CA40B();
  _id_EE075C49B3A71BC5();
  _id_7402D747B0D4D1EB();
  _id_682C4176F0CCF633();
}

test_print(msg) {
  msg = "THROTTLE_TEST: " + msg;
}

_id_B997916F30000D4A() {
  test_print("BEGIN throttle_UT_initialize");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_1", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( test_throttle_1, 1, " + level.framedurationseconds + ")");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_2", 2, level.framedurationseconds);
  test_print("CALL - throttle_initialize( test_throttle_2, 2, " + level.framedurationseconds + ")");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_queueLimit", 1, level.framedurationseconds, 3);
  test_print("CALL - throttle_initialize( test_throttle_queueLimit, 1, " + level.framedurationseconds + ", " + 3 + ")");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_defaults");
  test_print("CALL - throttle_initialize( test_throttle_defaults )");
  test_print("END throttle_UT_initialize");
}

_id_F0E537FAB28CA40B() {
  test_print("BEGIN throttle_UT_queue");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( 1, " + level.framedurationseconds + ")");
  entity = spawn("script_model", (0, 0, 0));
  _id_F632348CBB773537(_id_577D39197B4842C6, entity);
  test_print("CALL - wait_in_queue");
  _id_415A37C3A18FF3C5 = _id_11AB6D104BF77779(_id_577D39197B4842C6, entity);
  test_print("Ent in queue: " + _id_415A37C3A18FF3C5);
  test_print("END throttle_UT_queue");
}

_id_EE075C49B3A71BC5() {
  test_print("BEGIN throttle_UT_queue_10");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( 1, " + level.framedurationseconds + ")");
  ents = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 10; _id_AC0E594AC96AA3A8++) {
    ents[ents.size] = spawn("script_model", (0, 0, 0));
    _id_F632348CBB773537(_id_577D39197B4842C6, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + _id_AC0E594AC96AA3A8);
    test_print("Time - " + gettime());
    test_print("Ents in Queue - " + _id_577D39197B4842C6._id_14CA2465D606A4F9.size);
  }

  _id_415A37C3A18FF3C5 = _id_11AB6D104BF77779(_id_577D39197B4842C6, ents[3]);
  test_print("Ent 3 in queue: " + _id_415A37C3A18FF3C5);
  test_print("END throttle_UT_queue_10");
}

_id_7402D747B0D4D1EB() {
  test_print("BEGIN throttle_UT_queue_10_threaded");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( 1, " + level.framedurationseconds + ")");
  ents = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 10; _id_AC0E594AC96AA3A8++) {
    ents[ents.size] = spawn("script_model", (0, 0, 0));
    thread _id_F632348CBB773537(_id_577D39197B4842C6, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + _id_AC0E594AC96AA3A8);
    test_print("Time - " + gettime());
    test_print("Ents in Queue - " + _id_577D39197B4842C6._id_14CA2465D606A4F9.size);
  }

  _id_415A37C3A18FF3C5 = _id_11AB6D104BF77779(_id_577D39197B4842C6, ents[3]);
  test_print("Ent 3 in queue: " + _id_415A37C3A18FF3C5);
  test_print("END throttle_UT_queue_10_threaded");
}

_id_682C4176F0CCF633() {
  test_print("BEGIN throttle_UT_leave_queue");
  _id_577D39197B4842C6 = _id_E4C99B0F178FFB98("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( 1, " + level.framedurationseconds + ")");
  ents = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 10; _id_AC0E594AC96AA3A8++) {
    ents[ents.size] = spawn("script_model", (0, 0, 0));
    thread _id_F632348CBB773537(_id_577D39197B4842C6, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + _id_AC0E594AC96AA3A8);
    test_print("Time - " + gettime());
  }

  _id_415A37C3A18FF3C5 = _id_11AB6D104BF77779(_id_577D39197B4842C6, ents[3]);
  test_print("ent 3 in queue: " + _id_415A37C3A18FF3C5);
  _id_8CE6C42C18618555(_id_577D39197B4842C6, ents[3]);
  test_print("CALL - leave_queue");
  _id_415A37C3A18FF3C5 = _id_11AB6D104BF77779(_id_577D39197B4842C6, ents[3]);
  test_print("ent 3 in queue: " + _id_415A37C3A18FF3C5);
  test_print("END throttle_UT_leave_queue");
}
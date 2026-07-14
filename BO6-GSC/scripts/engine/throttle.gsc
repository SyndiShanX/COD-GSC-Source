/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\throttle.gsc
***************************************/

#namespace throttle;

function private function_8280c88863030872(throttle) {
  throttle endon(throttle.var_538c5b918e960f74);

  while(isDefined(throttle)) {
    function_302d031d90fb290d(throttle);
    wait throttle.updaterate_;
  }
}

function private function_302d031d90fb290d(throttle) {
  profilestart();
  processed = 0;

  for(index = 0; index < throttle.queue_.size; index++) {
    item = throttle.queue_[index];
    throttle.queue_[index] = undefined;

    if(!isDefined(item)) {
      continue;
    }

    item notify(throttle.var_9aff5df0dbb7c83);
    processed++;

    if(processed >= throttle.processlimit_) {
      break;
    }
  }

  throttle.queue_ = function_5713d46873b29625(throttle.queue_);
  profilestop();
}

function throttle_initialize(name, processlimit = 1, updaterate, queuelimit) {
  if(processlimit == 0) {
    return undefined;
  }

  assert(isstring(name));
  throttle = spawnStruct();
  throttle.queue_ = [];
  throttle.var_9aff5df0dbb7c83 = name + "_wake_up";
  throttle.var_538c5b918e960f74 = name + "_stop_threads";
  throttle.processlimit_ = processlimit;
  throttle.updaterate_ = updaterate ?? level.framedurationseconds;
  throttle.queuelimit_ = queuelimit;

  if(!isDefined(throttle.updaterate_)) {
    if(getdvarint(@ "g_connectpaths", 0) > 0) {
      return undefined;
    }

    assertmsg("<dev string:x24>");
  }

  thread function_8280c88863030872(throttle);
  return throttle;
}

function is_empty(throttle) {
  return !throttle.queue_.size;
}

function function_eed893c053dbf304(throttle) {
  if(!isDefined(throttle.queue_)) {
    return true;
  }

  foreach(item in throttle.queue_) {
    if(isDefined(item)) {
      return false;
    }
  }

  return true;
}

function throttle_destroy(throttle) {
  if(isDefined(throttle)) {
    throttle notify(throttle.var_538c5b918e960f74);
    throttle = undefined;
  }
}

function throttle_wait_in_queue(throttle, entity) {
  assert(!isDefined(throttle.gate), "<dev string:x85>");
  throttle endon(throttle.var_538c5b918e960f74);

  if(!isDefined(throttle)) {
    assertmsg("<dev string:xde>");
    return;
  }

  while(throttle.queue_.size > throttle.queuelimit_) {
    function_302d031d90fb290d(throttle);
  }

  if(!isDefined(entity)) {
    return;
  }

  if(!isent(entity) && !isstruct(entity)) {
    return;
  }

  if(!arraycontains(throttle.queue_, entity)) {
    throttle.queue_[throttle.queue_.size] = entity;
  }

  entity endon("death");
  entity endon("delete");
  entity waittill(throttle.var_9aff5df0dbb7c83);
}

function function_311421fabea78894(throttle, entity) {
  return arraycontains(throttle.queue_, entity);
}

function throttle_leave_queue(throttle, entity) {
  throttle.queue_ = arrayremove(throttle.queue_, entity);
}

function throttle_initialize_gate(name, processlimit = 1, updaterate) {
  if(processlimit == 0) {
    return undefined;
  }

  assert(isstring(name));
  throttle = spawnStruct();
  throttle.var_538c5b918e960f74 = name + "_stop_threads";
  throttle.var_13c10823fd93bc91 = 0;
  throttle.processlimit_ = processlimit;
  throttle.updaterate_ = updaterate ?? level.framedurationseconds;

  throttle.gate = 1;

  return throttle;
}

function function_793863e476bf1524(throttle) {
  if(!isDefined(throttle)) {
    assertmsg("<dev string:xde>");
    return;
  }

  assert(throttle.gate, "<dev string:xfa>");

  if(throttle.var_13c10823fd93bc91 >= throttle.processlimit_) {
    throttle endon(throttle.var_538c5b918e960f74);
    wait throttle.updaterate_;
    throttle.var_13c10823fd93bc91 = 1;
    return 1;
  }

  throttle.var_13c10823fd93bc91++;
  return 0;
}

function function_ac02df3f2e81cbab(name, processlimit = 1, updaterate, gatefrequency) {
  if(processlimit == 0) {
    return undefined;
  }

  assert(isstring(name));
  throttle = spawnStruct();
  throttle.var_538c5b918e960f74 = name + "_stop_threads";
  throttle.var_13c10823fd93bc91 = 0;
  throttle.processlimit_ = processlimit;
  throttle.updaterate_ = updaterate ?? level.framedurationseconds;
  throttle.var_e064ce760682c986 = int((gatefrequency ?? level.framedurationseconds) * 1000);
  throttle.var_659ff8afcce5a7c9 = -1;

  throttle.var_8e7b3e975fdd2a97 = 1;

  return throttle;
}

function function_706ed379a3746335(throttle) {
  if(!isDefined(throttle)) {
    assertmsg("<dev string:xde>");
    return;
  }

  assert(throttle.var_8e7b3e975fdd2a97, "<dev string:x154>");
  timenow = gettime();

  if(timenow < throttle.var_659ff8afcce5a7c9) {
    throttle endon(throttle.var_538c5b918e960f74);
    secondstowait = (throttle.var_659ff8afcce5a7c9 - timenow) * 0.001;
    wait secondstowait;
  } else if(throttle.var_659ff8afcce5a7c9 != -1) {
    waitframe();
  }

  throttle.var_659ff8afcce5a7c9 = gettime() + throttle.var_e064ce760682c986;
  throttle.var_13c10823fd93bc91 = 0;
}

function function_1302aa73badc74f0(throttle) {
  if(!isDefined(throttle)) {
    assertmsg("<dev string:xde>");
    return;
  }

  assert(throttle.var_8e7b3e975fdd2a97, "<dev string:x1cb>");

  if(throttle.var_13c10823fd93bc91 >= throttle.processlimit_) {
    throttle endon(throttle.var_538c5b918e960f74);
    wait throttle.updaterate_;
    throttle.var_13c10823fd93bc91 = 0;
  }

  throttle.var_13c10823fd93bc91++;
}

function function_fd10bab4295ec41f() {
  throttle_ut_initialize();
  throttle_ut_queue();
  throttle_ut_queue_10();
  throttle_ut_queue_10_threaded();
  throttle_ut_leave_queue();
  function_d4806c82433d6d48();
}

function test_print(msg) {
  msg = "<dev string:x239>" + msg;
  println(msg);
}

function throttle_ut_initialize() {
  test_print("BEGIN throttle_UT_initialize");
  test_throttle = throttle_initialize("test_throttle_1", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( test_throttle_1, " + 1 + ", " + level.framedurationseconds + ")");
  assert(isarray(test_throttle.queue_) && test_throttle.queue_.size == 0);
  assert(test_throttle.var_9aff5df0dbb7c83 == "<dev string:x24c>" + "<dev string:x25f>");
  assert(test_throttle.processlimit_ == 1);
  assert(test_throttle.updaterate_ == level.framedurationseconds);
  assert(!isDefined(test_throttle.queuelimit_));
  test_throttle = throttle_initialize("test_throttle_2", 2, level.framedurationseconds);
  test_print("CALL - throttle_initialize( test_throttle_2, " + 2 + ", " + level.framedurationseconds + ")");
  assert(test_throttle.processlimit_ == 2);
  test_throttle = throttle_initialize("test_throttle_queueLimit", 1, level.framedurationseconds, 3);
  test_print("CALL - throttle_initialize( test_throttle_queueLimit, " + 1 + ", " + level.framedurationseconds + ", " + 3 + ")");
  assert(test_throttle.queuelimit_ == 3);
  test_throttle = throttle_initialize("test_throttle_defaults");
  test_print("CALL - throttle_initialize( test_throttle_defaults )");
  assert(isarray(test_throttle.queue_) && test_throttle.queue_.size == 0);
  assert(test_throttle.var_9aff5df0dbb7c83 == "<dev string:x26b>" + "<dev string:x25f>");
  assert(test_throttle.processlimit_ == 1);
  assert(test_throttle.updaterate_ == level.framedurationseconds);
  assert(!isDefined(test_throttle.queuelimit_));
  test_print("END throttle_UT_initialize");
}

function throttle_ut_queue() {
  test_print("BEGIN throttle_UT_queue");
  test_throttle = throttle_initialize("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")");
  entity = spawn("script_model", (0, 0, 0));
  throttle_wait_in_queue(test_throttle, entity);
  test_print("CALL - wait_in_queue");
  isinqueue = function_311421fabea78894(test_throttle, entity);
  test_print("Ent in queue: " + isinqueue);
  assert(!isinqueue);
  test_print("END throttle_UT_queue");
}

function throttle_ut_queue_10() {
  test_print("BEGIN throttle_UT_queue_10");
  test_throttle = throttle_initialize("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")");
  ents = [];

  for(i = 1; i <= 10; i++) {
    ents[ents.size] = spawn("script_model", (0, 0, 0));
    throttle_wait_in_queue(test_throttle, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + i);
    test_print("Time - " + gettime());
    test_print("Ents in Queue - " + test_throttle.queue_.size);
  }

  isinqueue = function_311421fabea78894(test_throttle, ents[3]);
  test_print("Ent 3 in queue: " + isinqueue);
  assert(!isinqueue);
  test_print("END throttle_UT_queue_10");
}

function throttle_ut_queue_10_threaded() {
  test_print("BEGIN throttle_UT_queue_10_threaded");
  test_throttle = throttle_initialize("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")");
  ents = [];

  for(i = 1; i <= 10; i++) {
    ents[ents.size] = spawn("script_model", (0, 0, 0));
    thread throttle_wait_in_queue(test_throttle, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + i);
    test_print("Time - " + gettime());
    test_print("Ents in Queue - " + test_throttle.queue_.size);
  }

  isinqueue = function_311421fabea78894(test_throttle, ents[3]);
  test_print("Ent 3 in queue: " + isinqueue);
  assert(isinqueue);
  test_print("END throttle_UT_queue_10_threaded");
}

function throttle_ut_leave_queue() {
  test_print("BEGIN throttle_UT_leave_queue");
  test_throttle = throttle_initialize("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")");
  ents = [];

  for(i = 1; i <= 10; i++) {
    ents[ents.size] = spawn("script_model", (0, 0, 0));
    thread throttle_wait_in_queue(test_throttle, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + i);
    test_print("Time - " + gettime());
  }

  isinqueue = function_311421fabea78894(test_throttle, ents[3]);
  test_print("ent 3 in queue: " + isinqueue);
  assert(isinqueue);
  throttle_leave_queue(test_throttle, ents[3]);
  test_print("CALL - leave_queue");
  isinqueue = function_311421fabea78894(test_throttle, ents[3]);
  test_print("ent 3 in queue: " + isinqueue);
  assert(!isinqueue);
  test_print("END throttle_UT_leave_queue");
}

function function_d4806c82433d6d48() {
  test_print("<dev string:x285>");
  test_throttle = function_ac02df3f2e81cbab("<dev string:x2ae>", 2, undefined, 0.5);
  assert(test_throttle.var_13c10823fd93bc91 == 0);
  assert(test_throttle.processlimit_ == 2);
  assert(test_throttle.updaterate_ == level.framedurationseconds);
  assert(isint(test_throttle.var_e064ce760682c986));
  assert(test_throttle.var_e064ce760682c986 == 500);
  assert(test_throttle.var_659ff8afcce5a7c9 == -1);
  assert(test_throttle.var_8e7b3e975fdd2a97);
  timenow = gettime();
  origtime = timenow;
  function_706ed379a3746335(test_throttle);
  assert(gettime() == timenow);
  assert(test_throttle.var_659ff8afcce5a7c9 != -1);
  function_706ed379a3746335(test_throttle);
  var_e6bedfc791723be4 = level.frameduration * int(500 / level.frameduration);
  assert(gettime() == timenow + var_e6bedfc791723be4);
  timenow = gettime();
  origtime = timenow;
  function_1302aa73badc74f0(test_throttle);
  assert(gettime() == timenow);
  assert(test_throttle.var_13c10823fd93bc91 == 1);
  function_1302aa73badc74f0(test_throttle);
  assert(gettime() == timenow);
  assert(test_throttle.var_13c10823fd93bc91 == 2);
  function_1302aa73badc74f0(test_throttle);
  assert(gettime() == timenow + test_throttle.updaterate_ * 1000);
  assert(test_throttle.var_13c10823fd93bc91 == 1);
  function_1302aa73badc74f0(test_throttle);
  assert(gettime() == timenow + test_throttle.updaterate_ * 1000);
  assert(test_throttle.var_13c10823fd93bc91 == 2);
  timenow = gettime();
  function_1302aa73badc74f0(test_throttle);
  assert(gettime() == timenow + test_throttle.updaterate_ * 1000);
  assert(test_throttle.var_13c10823fd93bc91 == 1);
  timenow = gettime();
  assert(origtime < timenow);
  function_706ed379a3746335(test_throttle);
  assert(test_throttle.var_13c10823fd93bc91 == 0);
  assert(gettime() != timenow + var_e6bedfc791723be4);
  assert(gettime() == origtime + var_e6bedfc791723be4);
  testframes = int(test_throttle.var_e064ce760682c986 / level.frameduration * test_throttle.processlimit_) + 1;

  for(i = 0; i < testframes; i++) {
    function_1302aa73badc74f0(test_throttle);
  }

  timenow = gettime();
  function_706ed379a3746335(test_throttle);
  assert(gettime() == timenow + level.frameduration);
  test_print("<dev string:x2c5>");
}
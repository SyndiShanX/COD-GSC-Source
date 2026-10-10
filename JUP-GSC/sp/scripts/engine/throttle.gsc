/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\engine\throttle.gsc
***********************************************/

#using scripts\engine\utility;
#namespace throttle;

function private function_9520a7d8b5aee737(throttle) {
  while(isDefined(throttle)) {
    function_4707c765d202d592(throttle);
    wait throttle.updaterate_;
  }
}

function private function_4707c765d202d592(throttle) {
  processed = 0;

  foreach(item in throttle.queue_) {
    if(!isDefined(item)) {
      continue;
    }

    throttle.queue_ = array_remove(throttle.queue_, item);
    item notify(throttle.var_35615e062783af3e);
    processed++;

    if(processed >= throttle.processlimit_) {
      break;
    }
  }
}

function throttle_initialize(name, processlimit, updaterate, queuelimit) {
  assert(isDefined(name) && isstring(name));
  throttle = spawnStruct();
  throttle.queue_ = [];
  throttle.var_35615e062783af3e = name + "_wake_up";
  throttle.processlimit_ = default_to(processlimit, 1);
  throttle.updaterate_ = default_to(updaterate, level.framedurationseconds);
  throttle.queuelimit_ = queuelimit;
  thread function_9520a7d8b5aee737(throttle);
  return throttle;
}

function function_f632348cbb773537(throttle, entity) {
  while(isDefined(throttle.queuelimit_) && throttle.queue_.size > throttle.queuelimit_) {
    function_4707c765d202d592(throttle);
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
  entity waittill(throttle.var_35615e062783af3e);
}

function function_11ab6d104bf77779(throttle, entity) {
  return array_contains(throttle.queue_, entity);
}

function function_8ce6c42c18618555(throttle, entity) {
  throttle.queue_ = array_remove(throttle.queue_, entity);
}

function function_ffc20a0cd9408d3e() {
  throttle_ut_initialize();
  throttle_ut_queue();
  throttle_ut_queue_10();
  throttle_ut_queue_10_threaded();
  throttle_ut_leave_queue();
}

function test_print(msg) {
  msg = "<dev string:x1c>" + msg;
  println(msg);
}

function throttle_ut_initialize() {
  test_print("BEGIN throttle_UT_initialize");
  test_throttle = throttle_initialize("test_throttle_1", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( test_throttle_1, " + 1 + ", " + level.framedurationseconds + ")");
  assert(isarray(test_throttle.queue_) && test_throttle.queue_.size == 0);
  assert(test_throttle.var_35615e062783af3e == "test_throttle_1" + "_wake_up");
  assert(test_throttle.processlimit_ == 1);
  assert(test_throttle.updaterate_ == level.framedurationseconds);
  assert(test_throttle.queuelimit_ == undefined);
  test_throttle = throttle_initialize("test_throttle_2", 2, level.framedurationseconds);
  test_print("CALL - throttle_initialize( test_throttle_2, " + 2 + ", " + level.framedurationseconds + ")");
  assert(test_throttle.processlimit_ == 2);
  test_throttle = throttle_initialize("test_throttle_queueLimit", 1, level.framedurationseconds, 3);
  test_print("CALL - throttle_initialize( test_throttle_queueLimit, " + 1 + ", " + level.framedurationseconds + ", " + 3 + ")");
  assert(test_throttle.queuelimit_ == 3);
  test_throttle = throttle_initialize("test_throttle_defaults");
  test_print("CALL - throttle_initialize( test_throttle_defaults )");
  assert(isarray(test_throttle.queue_) && test_throttle.queue_.size == 0);
  assert(test_throttle.var_35615e062783af3e == "test_throttle_defaults" + "_wake_up");
  assert(test_throttle.processlimit_ == 1);
  assert(test_throttle.updaterate_ == level.framedurationseconds);
  assert(test_throttle.queuelimit_ == undefined);
  test_print("END throttle_UT_initialize");
}

function throttle_ut_queue() {
  test_print("BEGIN throttle_UT_queue");
  test_throttle = throttle_initialize("test_throttle_wait", 1, level.framedurationseconds);
  test_print("CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")");
  entity = spawn("script_model", (0, 0, 0));
  function_f632348cbb773537(test_throttle, entity);
  test_print("CALL - wait_in_queue");
  isinqueue = function_11ab6d104bf77779(test_throttle, entity);
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
    function_f632348cbb773537(test_throttle, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + i);
    test_print("Time - " + gettime());
    test_print("Ents in Queue - " + test_throttle.queue_.size);
  }

  isinqueue = function_11ab6d104bf77779(test_throttle, ents[3]);
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
    thread function_f632348cbb773537(test_throttle, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + i);
    test_print("Time - " + gettime());
    test_print("Ents in Queue - " + test_throttle.queue_.size);
  }

  isinqueue = function_11ab6d104bf77779(test_throttle, ents[3]);
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
    thread function_f632348cbb773537(test_throttle, ents[ents.size - 1]);
    test_print("CALL - wait_in_queue " + i);
    test_print("Time - " + gettime());
  }

  isinqueue = function_11ab6d104bf77779(test_throttle, ents[3]);
  test_print("ent 3 in queue: " + isinqueue);
  assert(isinqueue);
  function_8ce6c42c18618555(test_throttle, ents[3]);
  test_print("CALL - leave_queue");
  isinqueue = function_11ab6d104bf77779(test_throttle, ents[3]);
  test_print("ent 3 in queue: " + isinqueue);
  assert(!isinqueue);
  test_print("END throttle_UT_leave_queue");
}
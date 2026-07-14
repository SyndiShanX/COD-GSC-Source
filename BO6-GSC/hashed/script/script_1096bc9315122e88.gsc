/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1096bc9315122e88.gsc
*****************************************************/

#namespace namespace_2bea2dead016342c;

function init() {
  thread activities_init();
}

function activities_init() {
  if(isplatformps5()) {
    while(!isDefined(level.mapname)) {
      waitframe();
    }

    level.ps5activity = level.mapname;

    setdvarifuninitialized(@ "hash_f270b4040fc5585b", 0);

    println("<dev string:x24>" + level.ps5activity);
    startactivity(level.ps5activity);
  }
}

function function_673db5ae4485e7b0(activityname, state, stopstate) {
  if(!isplatformps5()) {
    return;
  }

  if(!isDefined(activityname)) {
    return;
  }

  if(!isDefined(state)) {
    return;
  }

  if(state == "\x17\xad\v\xde8") {
    startactivity(activityname);
    return;
  }

  if(state == "\x04M\xed\xab") {
    if(!isDefined(stopstate)) {
      stopstate = "s\xef\xf1lff\xcc\xee\xf5";
    }

    stopactivity(activityname, stopstate);
    return;
  }

  return;
}

function function_cf660fd61c136e76(taskname, state, stopstate) {
  if(!isplatformps5()) {
    return;
  }

  if(!isDefined(taskname)) {
    return;
  }

  if(!isDefined(state)) {
    return;
  }

  if(state == "\x17\xad\v\xde8") {
    startactivitytask(taskname);
    return;
  }

  if(state == "\x04M\xed\xab") {
    if(!isDefined(stopstate)) {
      stopstate = "s\xef\xf1lff\xcc\xee\xf5";
    }

    stopactivitytask(taskname, stopstate);
    return;
  }

  return;
}

function function_ea7fbdcc4f60b9b2(first_task) {
  if(!isplatformps5()) {
    return;
  }

  assert(isstring(first_task), "<dev string:x47>");

  if(getdvarint(@ "hash_f270b4040fc5585b")) {
    iprintln("<dev string:x71>" + first_task);
  }

  function_cf660fd61c136e76(first_task, "\x17\xad\v\xde8");
}

function function_86fd668de9f422ad(last_task, next_task) {
  if(!isplatformps5()) {
    return;
  }

  assert(isstring(last_task) && isstring(next_task), "<dev string:xa9>");

  if(getdvarint(@ "hash_f270b4040fc5585b")) {
    iprintln("<dev string:xf2>" + last_task + "<dev string:x121>" + next_task);
  }

  function_cf660fd61c136e76(last_task, "\x04M\xed\xab", "s\xef\xf1lff\xcc\xee\xf5");
  function_cf660fd61c136e76(next_task, "\x17\xad\v\xde8");
}

function function_2351c47cd1da720b(last_task) {
  if(!isplatformps5()) {
    return;
  }

  assert(isstring(last_task), "<dev string:x129>");

  if(getdvarint(@ "hash_f270b4040fc5585b")) {
    iprintln("<dev string:x16c>" + last_task + "<dev string:x1a2>");
  }

  function_cf660fd61c136e76(last_task, "\x04M\xed\xab", "s\xef\xf1lff\xcc\xee\xf5");
}
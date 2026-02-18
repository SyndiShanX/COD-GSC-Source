/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3ea297119bcbdb4d.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#namespace namespace_a376209a;

function event_handler[gametype_start] main(eventstruct) {
  callback::on_gameplay_started(&on_gameplay_started);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  level thread function_807e8ee9(localclientnum);
}

function function_807e8ee9(localclientnum) {
  var_296d73cb = getent(localclientnum, "clock_min_hand", "targetname");
  var_30bcd607 = getent(localclientnum, "clock_sec_hand", "targetname");
  timelimit = getgametypesetting(#"timelimit");

  if(!getdvarint(#"hash_151d18a5663d31ce", 1) || !isDefined(var_296d73cb) || !isDefined(var_30bcd607) || !isDefined(timelimit)) {
    return;
  }

  if(timelimit > 0) {
    var_296d73cb rotatepitch(360, timelimit * 60);
    var_30bcd607 rotatepitch(360 * timelimit, timelimit * 60);
    return;
  }

  var_30bcd607 thread function_da8da832();
}

function function_da8da832() {
  while(isDefined(self) && getdvarint(#"hash_151d18a5663d31ce", 1)) {
    self rotatepitch(360, 60);
    self waittill(#"rotatedone");
  }
}
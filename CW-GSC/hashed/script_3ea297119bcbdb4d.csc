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
  level thread nuked_doomsday_clock_init(localclientnum);
}

function nuked_doomsday_clock_init(localclientnum) {
  min_hand_model = getEnt(localclientnum, "clock_min_hand", "targetname");
  sec_hand_model = getEnt(localclientnum, "clock_sec_hand", "targetname");
  timelimit = getgametypesetting(#"timelimit");

  if(!getdvarint(#"hash_151d18a5663d31ce", 1) || !isDefined(min_hand_model) || !isDefined(sec_hand_model) || !isDefined(timelimit)) {
    return;
  }

  if(timelimit > 0) {
    min_hand_model rotatepitch(360, timelimit * 60);
    sec_hand_model rotatepitch(360 * timelimit, timelimit * 60);
    return;
  }

  sec_hand_model thread nuked_doomsday_clock_seconds_think();
}

function nuked_doomsday_clock_seconds_think() {
  while(isDefined(self) && getdvarint(#"hash_151d18a5663d31ce", 1)) {
    self rotatepitch(360, 60);
    self waittill(#"rotatedone");
  }
}
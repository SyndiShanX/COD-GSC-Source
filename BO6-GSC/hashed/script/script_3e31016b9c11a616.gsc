/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_3e31016b9c11a616.gsc
*****************************************************/

#using scripts\common\progress_tracker;
#namespace namespace_30f3ea5d3d3c7b6c;

function function_6fab2e7402cb70db() {
  self.progresstrackers = [];
}

function function_8e30b4ee29db5678() {
  return isDefined(self) && isDefined(self.progresstrackers);
}

function getprogresstracker(uniquename) {
  assert(function_8e30b4ee29db5678(), "<dev string:x24>");
  assert(isDefined(self.progresstrackers[uniquename]), "<dev string:x68>");
  return self.progresstrackers[uniquename];
}

function addprogresstracker(uniquename, progresstracker) {
  assert(function_8e30b4ee29db5678(), "<dev string:x24>");
  assert(!isDefined(self.progresstrackers[uniquename]), "<dev string:xb8>");
  progresstracker progress_tracker::setuniquename(uniquename);
  self.progresstrackers[uniquename] = progresstracker;
}

function endprogresstracker(uniquename) {
  assert(function_8e30b4ee29db5678(), "<dev string:x24>");
  assert(isDefined(self.progresstrackers[uniquename]), "<dev string:x68>");
  self.progresstrackers[uniquename] notify("\xcbAoe\x18\xdf\x11{\xb9e\xaf\x05'=\x88:\x8a\x9b\xb1\xe7\xf5\xbe\xe0\x1b\x02t\xce");
  self.progresstrackers[uniquename] = undefined;
}

function function_2f71f40668878478(uniquename, incrementvalue) {
  assert(function_8e30b4ee29db5678(), "<dev string:x24>");
  assert(isDefined(self.progresstrackers[uniquename]), "<dev string:x111>");
  self.progresstrackers[uniquename] progress_tracker::incrementcurrentprogress(incrementvalue);
}

function function_ffc5f2708009bdc0(uniquename, decrementvalue) {
  assert(function_8e30b4ee29db5678(), "<dev string:x24>");
  assert(isDefined(self.progresstrackers[uniquename]), "<dev string:x111>");
  self.progresstrackers[uniquename] progress_tracker::decrementcurrentprogress(decrementvalue);
}

function function_1d7c5cdd210011df(uniquename, progressvalue) {
  assert(function_8e30b4ee29db5678(), "<dev string:x24>");
  assert(isDefined(self.progresstrackers[uniquename]), "<dev string:x111>");
  self.progresstrackers[uniquename] progress_tracker::setcurrentprogress(progressvalue);
}

function function_bc2b80475ed457be(uniquename, finalvalue) {
  assert(function_8e30b4ee29db5678(), "<dev string:x24>");
  assert(isDefined(self.progresstrackers[uniquename]), "<dev string:x111>");
  self.progresstrackers[uniquename] progress_tracker::setfinalvalue(finalvalue);
}
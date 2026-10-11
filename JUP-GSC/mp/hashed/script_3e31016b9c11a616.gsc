/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e31016b9c11a616.gsc
*************************************************/

#using scripts\common\progress_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_a81ff4b57c69b411;

function function_25599e7b57187fba() {
  self.progresstrackers = [];
}

function function_2cd8a95641b4e4f1() {
  return isDefined(self) && isDefined(self.progresstrackers);
}

function getprogresstracker(uniquename) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.progresstrackers[uniquename]), "<dev string:x60>");
  return self.progresstrackers[uniquename];
}

function addprogresstracker(uniquename, progresstracker) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(!isDefined(self.progresstrackers[uniquename]), "<dev string:xb0>");
  progresstracker setuniquename(uniquename);
  self.progresstrackers[uniquename] = progresstracker;
}

function endprogresstracker(uniquename) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.progresstrackers[uniquename]), "<dev string:x60>");
  self.progresstrackers[uniquename] notify("progress_tracking_concluded");
  self.progresstrackers[uniquename] = undefined;
}

function function_a1a1d73d3e5772a5(uniquename, incrementvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.progresstrackers[uniquename]), "<dev string:x109>");
  self.progresstrackers[uniquename] incrementcurrentprogress(incrementvalue);
}

function function_a6663c5b87c63d51(uniquename, decrementvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.progresstrackers[uniquename]), "<dev string:x109>");
  self.progresstrackers[uniquename] decrementcurrentprogress(decrementvalue);
}

function function_82a2f59593fe059e(uniquename, progressvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.progresstrackers[uniquename]), "<dev string:x109>");
  self.progresstrackers[uniquename] setcurrentprogress(progressvalue);
}

function function_34a7c2ed4dbe722b(uniquename, finalvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.progresstrackers[uniquename]), "<dev string:x109>");
  self.progresstrackers[uniquename] setfinalvalue(finalvalue);
}
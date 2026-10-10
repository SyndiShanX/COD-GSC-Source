/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e31016b9c11a616.gsc
*************************************************/

#using scripts\common\progress_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_a81ff4b57c69b411;

function function_25599e7b57187fba() {
  self.var_e3d833b1e5d30b03 = [];
}

function function_2cd8a95641b4e4f1() {
  return isDefined(self) && isDefined(self.var_e3d833b1e5d30b03);
}

function function_6ef305e92aa56110(uniquename) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.var_e3d833b1e5d30b03[uniquename]), "<dev string:x60>");
  return self.var_e3d833b1e5d30b03[uniquename];
}

function function_53a8c0ab528f44cd(uniquename, progresstracker) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(!isDefined(self.var_e3d833b1e5d30b03[uniquename]), "<dev string:xb0>");
  progresstracker function_5cd1865af5a5edcf(uniquename);
  self.var_e3d833b1e5d30b03[uniquename] = progresstracker;
}

function function_11bf7ad9c1fdc527(uniquename) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.var_e3d833b1e5d30b03[uniquename]), "<dev string:x60>");
  self.var_e3d833b1e5d30b03[uniquename] notify("progress_tracking_concluded");
  self.var_e3d833b1e5d30b03[uniquename] = undefined;
}

function function_a1a1d73d3e5772a5(uniquename, incrementvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.var_e3d833b1e5d30b03[uniquename]), "<dev string:x109>");
  self.var_e3d833b1e5d30b03[uniquename] function_a370b85e4225923c(incrementvalue);
}

function function_a6663c5b87c63d51(uniquename, decrementvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.var_e3d833b1e5d30b03[uniquename]), "<dev string:x109>");
  self.var_e3d833b1e5d30b03[uniquename] function_1e9e5153831d8c68(decrementvalue);
}

function function_82a2f59593fe059e(uniquename, progressvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.var_e3d833b1e5d30b03[uniquename]), "<dev string:x109>");
  self.var_e3d833b1e5d30b03[uniquename] function_7681e7890758b69b(progressvalue);
}

function function_34a7c2ed4dbe722b(uniquename, finalvalue) {
  assertex(function_2cd8a95641b4e4f1(), "<dev string:x1c>");
  assertex(isDefined(self.var_e3d833b1e5d30b03[uniquename]), "<dev string:x109>");
  self.var_e3d833b1e5d30b03[uniquename] function_ea45d380408d2922(finalvalue);
}
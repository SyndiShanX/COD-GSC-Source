/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4052c3bdceef3430.gsc
*****************************************************/

#using scripts\common\objective_marker_bundle_helper;
#using scripts\common\system;
#using scripts\engine\utility;
#namespace namespace_1176a97e2c692c2c;

function private autoexec __init__system__() {
  system::register(#"hash_4e9ed9a664d64cb5", undefined, &function_14daa79134e59164, undefined);
}

function private function_14daa79134e59164() {
  utility::registersharedfunc(#"objective_marker_bundle_helper", #"createobjectivemarkerfrombundlexhash", &sp_createobjectivemarkerfrombundlexhash);
}

function sp_createobjectivemarkerfrombundlexhash(bundlexhash) {
  if(!objective_marker_bundle_helper::function_3f7a7e77df30b499()) {
    objective_marker_bundle_helper::function_1c089f633622f371();
  }

  assertmsg("<dev string:x24>" + getxhashsourcename(bundlexhash) + "<dev string:x4b>");
  return -1;
}
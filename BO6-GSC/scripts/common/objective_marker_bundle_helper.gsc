/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\objective_marker_bundle_helper.gsc
*************************************************************/

#using scripts\engine\utility;
#namespace objective_marker_bundle_helper;

function function_1c089f633622f371() {
  if(function_3f7a7e77df30b499()) {
    return;
  }

  level.var_4e46e5cd539005db = function_36838fe7ed9f5688();
}

function function_a6c94c4f3c5bfa4(bundlename) {
  bundlexhash = bundlename;

  if(!isxhashasset(bundlename)) {
    bundlexhash = hashcat(%"hash_334a4b8da1c7fd3f", bundlename);
  }

  return utility::callsharedfunc(#"objective_marker_bundle_helper", #"createobjectivemarkerfrombundlexhash", bundlexhash);
}

function function_3f7a7e77df30b499() {
  return isDefined(level.var_4e46e5cd539005db);
}

function private function_36838fe7ed9f5688() {
  var_4e46e5cd539005db = spawnStruct();
  var_4e46e5cd539005db.backgroundoptions = [];
  var_4e46e5cd539005db.backgroundoptions["\x91\xca\xcc\v\xab\xd8:"] = 0;
  var_4e46e5cd539005db.backgroundoptions["\x9aBM\x19a\x02\xd6\xb9UT\xc8\x10\xd3"] = 1;
  var_4e46e5cd539005db.backgroundoptions["\xad\x97\x13\x03\x8b\x1d\x15\xab\x150\x93\xc9"] = 2;
  var_4e46e5cd539005db.backgroundoptions["\xb6\xa5\x9b7\x96on"] = 3;
  var_4e46e5cd539005db.backgroundoptions["\x1c=\xb5s\xbfR\x11\xc2\x80(\x91\xd6{u\xde"] = 4;
  var_4e46e5cd539005db.backgroundoptions["\xfa!\xa3"] = 5;
  var_4e46e5cd539005db.backgroundoptions["\x1bi\x93\xd8\xc6+"] = 6;
  var_4e46e5cd539005db.backgroundoptions["\xcc(\xe5u\x0e\xfe\x8c"] = 7;
  var_4e46e5cd539005db.backgroundoptions["\xf7\xcc+\xd4\x03a\x82\xc6U\x9c"] = 8;
  var_4e46e5cd539005db.backgroundoptions["\xf7\a\xdft\bH\xac\x12\x8c\"\x90r\x1f"] = 9;
  return var_4e46e5cd539005db;
}
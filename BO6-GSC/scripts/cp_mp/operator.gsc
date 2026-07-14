/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\operator.gsc
**************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#namespace operator;

function function_c79f6a12d91ad551() {
  projectname = getprojectname();

  if(projectname == "T10" || projectname == "WZ2") {
    return getdvarint(@ "hash_1fd86bdad9333d2", 0);
  } else if(level.projectbundle.var_5929f3f4d2dc1f06) {
    return getdvarint(@ "hash_1fd86bdad9333d2", 1);
  }

  return 0;
}

function private isbuildingmap() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 1) {
    return true;
  }

  if(getdvarint(@ "hash_742caa13b3c2e685") == 1) {
    return true;
  }

  return false;
}

function private function_7412a0b60cad7aec() {
  if(level.var_a2929374d108d239) {
    return;
  }

  level.var_a2929374d108d239 = 1;
  profilestart();
  devgui::function_9082edeb5db93280("<dev string:x24>");

  foreach(operator in level.var_b3fc180d242c4d12) {
    operatorbundle = getoperatorbundle(operator);
    operatorgender = operatorbundle.gender ?? "<dev string:x37>";
    gender = undefined;

    switch (operatorgender) {
      case #"hash_5e9616b9548f69b9":
        gender = "<dev string:x49>";
        break;
      case #"hash_b411a9fa1c94e739":
        gender = "<dev string:x6d>";
        break;
      default:
        gender = "<dev string:x88>";
        break;
    }

    faction = (operatorbundle.superfaction ?? "<dev string:x9d>") == "<dev string:x9d>" ? "<dev string:xa5>" : "<dev string:xba>";

    if(isDefined(level.var_ff43edef64cd11ef[operator])) {
      foreach(skin in level.var_ff43edef64cd11ef[operator]) {
        if(issubstr(getxhashsourcename(skin), "<dev string:xcf>")) {
          devgui::add_devgui_command("<dev string:xd7>" + "<dev string:xdf>" + getxhashsourcename(skin), "<dev string:xe4>" + getxhashsourcename(skin));
        }

        project = "<dev string:xfe>";

        if(issubstr(tolower(getxhashsourcename(skin)), "<dev string:x107>")) {
          project = "<dev string:x10e>";
        } else if(issubstr(tolower(getxhashsourcename(skin)), "<dev string:x118>")) {
          project = "<dev string:x11f>";
        } else if(issubstr(tolower(getxhashsourcename(skin)), "<dev string:x129>")) {
          project = "<dev string:x130>";
        }

        devgui::add_devgui_command(project + gender + getxhashsourcename(operator) + "<dev string:xdf>" + getxhashsourcename(skin), "<dev string:xe4>" + getxhashsourcename(skin));
        devgui::add_devgui_command(project + faction + getxhashsourcename(operator) + "<dev string:xdf>" + getxhashsourcename(skin), "<dev string:xe4>" + getxhashsourcename(skin));
      }
    }
  }

  utility::callsharedfunc(#"bodysize", #"hash_77e79f676746c38d");
  devgui::add_devgui_command("<dev string:x13a>", "<dev string:x158>");
  devgui::add_devgui_command("<dev string:x17a>", "<dev string:x191>");
  devgui::add_devgui_command("<dev string:x1b3>", "<dev string:x1cb>");
  devgui::add_devgui_command("<dev string:x1ed>", "<dev string:x20e>");
  devgui::add_devgui_command("<dev string:x230>", "<dev string:x24f>");
  devgui::add_devgui_command("<dev string:x273>", "<dev string:x28d>");
  devgui::add_devgui_command("<dev string:x31e>", "<dev string:x339>");
  devgui::add_devgui_command("<dev string:x355>", "<dev string:x370>");
  devgui::function_77df7fe7dd273e10();
  profilestop();
}

function function_d846e5ddf3fe819() {
  if(level.var_53d46e3fba9849a5) {
    function_b32394f15d245bec();
  }

  if(!level.var_b4c751094ee885a7) {
    if(getdvarint(@ "hash_2e21b938e2994ff5", 0) == 0) {
      level.var_53d46e3fba9849a5 = 1;
      function_e5efd24ec4dbf5d9();
      waitframe();
      level.var_53d46e3fba9849a5 = undefined;
    }
  }

  if(!level.var_472d401a5207883e) {
    if(getdvarint(@ "hash_2e21b938e2994ff5", 0) == 0) {
      level.var_53d46e3fba9849a5 = 1;
      function_a3de63ccf4242040();
      waitframe();
      level.var_53d46e3fba9849a5 = undefined;
    }
  }
}

function private function_b32394f15d245bec() {
  var_b0d06f51bf884f15 = 0;

  while(level.var_53d46e3fba9849a5) {
    var_b0d06f51bf884f15++;

    if(var_b0d06f51bf884f15 > 10) {
      level.var_53d46e3fba9849a5 = undefined;
      return;
    }

    waitframe();
  }
}

function function_2a088dd032a61c0a() {
  function_c0a88ddbad609f58();
}

function private function_c0a88ddbad609f58() {
  if(isDefined(level.var_b3fc180d242c4d12)) {
    return;
  }

  function_91b15d3a8ac032c0();
}

function private function_91b15d3a8ac032c0() {
  level.var_b3fc180d242c4d12 = [];

  if(isbuildingmap()) {
    return;
  }

  gamemodebundle = level.gamemodebundle;

  if(!isDefined(gamemodebundle.operatorlist)) {
    return;
  }

  operatorlistbundle = getoperatorlistscriptbundle(gamemodebundle.operatorlist);

  if(!isDefined(operatorlistbundle)) {
    println("<dev string:x38c>" + gamemodebundle.operatorlist);
    return;
  }

  operatorlist = operatorlistbundle.operatorlist;
  level.defaultoperator = [];
  level.defaultoperator["allies"] = operatorlistbundle.var_c2b6e3c927c2a5e4;
  level.defaultoperator["axis"] = operatorlistbundle.var_8597bc9b07f488ee;

  for(i = 0; i < operatorlist.size; i++) {
    operatorref = operatorlist[i].operator;

    if(!isDefined(operatorref)) {
      continue;
    }

    operatorbundle = getoperatorscriptbundle(operatorref, #"defaultexecution");

    if(!isDefined(operatorbundle)) {
      println("<dev string:x3ba>" + gamemodebundle.operatorlist + "<dev string:x3f1>" + getxhashsourcename(operatorref));
      continue;
    }

    if(getdvarint(@ "hash_fe759d6fbaec1079", 0) == 1) {
      assert(isDefined(operatorbundle.defaultexecution), "<dev string:x3f7>" + getxhashsourcename(operatorref) + "<dev string:x404>");
    }

    level.var_b3fc180d242c4d12[level.var_b3fc180d242c4d12.size] = operatorref;
  }

  level.var_55b857e48f4f0dab[0] = operatorlistbundle.var_c2b6e3c927c2a5e4;
  level.var_55b857e48f4f0dab[1] = operatorlistbundle.var_8597bc9b07f488ee;
}

function function_449035ab2454100(operatorref) {
  if(isbuildingmap()) {
    return;
  }

  operatorbundle = getoperatorscriptbundle(operatorref, [#"Skins", #"defaultskin"]);

  if(!isDefined(operatorbundle)) {
    println("<dev string:x472>" + operatorref);
    return;
  }

  level.var_b3fc180d242c4d12[level.var_b3fc180d242c4d12.size] = operatorref;
  function_6c240cb0de0e0db1(operatorref, operatorbundle);
}

function getoperatorrefs() {
  function_c0a88ddbad609f58();
  return level.var_b3fc180d242c4d12;
}

function function_fb3ad5cd3a9ae76b(operatorref) {
  if(!operatorref) {
    return 0;
  }

  return arraycontains(getoperatorrefs(), operatorref);
}

function getoperatorbundle(operatorref, var_5c6c42708a3dc0c) {
  operatorbundle = getoperatorscriptbundle(operatorref, var_5c6c42708a3dc0c);

  if(!isDefined(operatorbundle)) {
    assertmsg("<dev string:x49b>" + getxhashsourcename(operatorref));
  }

  return operatorbundle;
}

function getoperatorsuperfaction(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, #"superfaction");

  if(operatorbundle.superfaction == "EAST") {
    return true;
  }

  return false;
}

function function_bc6d8ad64545fc57(operatorref, operatorSkinRef) {
  value = undefined;
  skinbundle = getoperatorskinscriptbundle(operatorSkinRef);

  if(skinbundle.var_6ff78a8c39146e65) {
    value = skinbundle.var_83dee9f4a0c1845;
  } else {
    operatorbundle = getoperatorbundle(operatorref);
    value = operatorbundle.var_83dee9f4a0c1845 ?? #"";
  }

  if(!isxhash(value)) {
    value = getxhash(value);
  }

  return value;
}

function function_66a3fbacf1fcad50(operatorref) {
  operatorbundle = getoperatorbundle(operatorref);

  if(isDefined(operatorbundle.var_32f1671d700d69b6)) {
    return getscriptbundle(operatorbundle.var_32f1671d700d69b6);
  }

  return undefined;
}

function function_82d89269854f2e0f(operatorref) {
  operatorbundle = getoperatorbundle(operatorref);

  if(isDefined(operatorbundle.var_52e9517775f84ce5)) {
    return getscriptbundle(operatorbundle.var_52e9517775f84ce5);
  }

  return undefined;
}

function getoperatorvoice(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"voice"]);

  if(isDefined(operatorbundle.voice)) {
    return operatorbundle.voice;
  }

  return "";
}

function getoperatorgender(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"gender"]);

  if(operatorbundle.gender == "FEMALE") {
    return "female";
  }

  return "male";
}

function function_db4f41253b282a4f(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"defaultexecution"]);

  if(isDefined(operatorbundle.defaultexecution)) {
    return operatorbundle.defaultexecution;
  }

  return "";
}

function function_d5a18e550f529e2c(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"defaultquip"]);

  if(isDefined(operatorbundle.defaultquip)) {
    return operatorbundle.defaultquip;
  }

  return "";
}

function isoperatorunlocked(operatorref) {
  return getoperatorbundle(operatorref, #"hash_1aad59b5bb5eb9fe").var_ffaa6b376f7925ff ?? 1;
}

function function_2b34573c920ee585(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, #"botinvalid");

  if(isDefined(operatorbundle)) {
    if(isDefined(operatorbundle.botinvalid)) {
      return !operatorbundle.botinvalid;
    } else {
      return 1;
    }

    return;
  }

  return 0;
}

function function_d0589f3304fb58da(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"botgroup"]);

  if(isDefined(operatorbundle.botgroup)) {
    return operatorbundle.botgroup;
  }

  return "";
}

function getoperatorteambyref(operatorref) {
  operatorbundle = getoperatorbundle(operatorref);
  team = (operatorbundle.superfaction ?? "WEST") == "WEST" ? "allies" : "axis";
  return team;
}

function function_f3a3ee0b2758d139(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"lootid"]);

  if(isDefined(operatorbundle.lootid)) {
    return operatorbundle.lootid;
  }

  return 0;
}

function function_ba9b1d7b8bbd957e(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"overridedefaultsuit"]);
  return operatorbundle.overridedefaultsuit ?? 0;
}

function function_a47e3481b8d81aa7(operatorref) {
  operatorbundle = getoperatorbundle(operatorref, [#"suit"]);
  return operatorbundle.suit ?? "";
}

function function_1e97ddc0ff6d0c40() {
  return level.var_55b857e48f4f0dab[0];
}

function function_8d28c3fcfc8cc4a2() {
  return level.var_55b857e48f4f0dab[1];
}

function function_297589994c9a9eff(var_a3559c3721faf851) {
  if(var_a3559c3721faf851 == 1) {
    return function_8d28c3fcfc8cc4a2();
  }

  return function_1e97ddc0ff6d0c40();
}

function private function_e5efd24ec4dbf5d9() {
  if(isDefined(level.var_b4c751094ee885a7)) {
    return;
  }

  function_84302cb6ff5837f();
}

function private function_84302cb6ff5837f() {
  function_c0a88ddbad609f58();
  level.var_aea805ad236a525f = [];
  level.var_b4c751094ee885a7 = [];
  level.var_ff43edef64cd11ef = [];
  level.var_7c09484f1926c102 = [];
  level.var_212650972ad1a958 = [];

  if(isbuildingmap()) {
    return;
  }

  foreach(operatorref in level.var_b3fc180d242c4d12) {
    operatorbundle = getoperatorbundle(operatorref, [#"Skins", #"defaultskin"]);

    if(!isDefined(operatorbundle)) {
      continue;
    }

    foreach(skinentry in operatorbundle.skins) {
      skinref = skinentry.skin;

      if(!isDefined(skinref)) {
        continue;
      }

      var_6739a9c997eec5c5 = getoperatorskinscriptbundle(skinref, #"hash_ac7fd2c9c6408186").var_6739a9c997eec5c5;
      level.var_aea805ad236a525f[level.var_aea805ad236a525f.size] = skinref;
      level.var_b4c751094ee885a7[skinref] = operatorref;

      if(function_35303b94875f6d5b(var_6739a9c997eec5c5)) {
        level.var_212650972ad1a958[getoperatorskinscriptbundle(skinref, #"lootid").lootid] = var_6739a9c997eec5c5;
      }

      if(!isDefined(level.var_ff43edef64cd11ef[operatorref])) {
        level.var_ff43edef64cd11ef[operatorref] = [];
      }

      level.var_ff43edef64cd11ef[operatorref][level.var_ff43edef64cd11ef[operatorref].size] = skinref;
    }

    assert(isDefined(level.var_ff43edef64cd11ef[operatorref]), "<dev string:x4bb>" + getxhashsourcename(operatorref) + "<dev string:x4c9>");

    if(isDefined(operatorbundle.defaultskin)) {
      skinref = operatorbundle.defaultskin;
      skinbundle = getoperatorskinscriptbundle(skinref, [#"hash_ac7fd2c9c6408186", #"lootid"]);

      if(isDefined(skinbundle)) {
        level.var_7c09484f1926c102[operatorref] = skinref;

        if(function_35303b94875f6d5b(skinbundle.var_6739a9c997eec5c5)) {
          level.var_212650972ad1a958[skinbundle.lootid] = skinbundle.var_6739a9c997eec5c5;
        }

        continue;
      }

      assertmsg("<dev string:x3f7>" + getxhashsourcename(operatorref) + "<dev string:x4ec>");
    }
  }

  function_7412a0b60cad7aec();
}

function private function_6c240cb0de0e0db1(operatorref, operatorbundle) {
  if(isbuildingmap()) {
    return;
  }

  assert(isDefined(level.var_b4c751094ee885a7));

  foreach(skinentry in operatorbundle.skins) {
    if(!isDefined(skinentry.skin)) {
      continue;
    }

    skinref = skinentry.skin;
    var_6739a9c997eec5c5 = getoperatorskinscriptbundle(skinref, #"hash_ac7fd2c9c6408186").var_6739a9c997eec5c5;
    level.var_aea805ad236a525f[level.var_aea805ad236a525f.size] = skinref;
    level.var_b4c751094ee885a7[skinref] = operatorref;

    if(function_35303b94875f6d5b(var_6739a9c997eec5c5)) {
      level.var_212650972ad1a958[getoperatorskinscriptbundle(skinref, #"lootid").lootid] = var_6739a9c997eec5c5;
    }

    if(!isDefined(level.var_ff43edef64cd11ef[operatorref])) {
      level.var_ff43edef64cd11ef[operatorref] = [];
    }

    level.var_ff43edef64cd11ef[operatorref][level.var_ff43edef64cd11ef[operatorref].size] = skinref;
  }

  if(isDefined(operatorbundle.defaultskin)) {
    skinbundle = getoperatorskinscriptbundle(operatorbundle.defaultskin, [#"hash_ac7fd2c9c6408186", #"lootid"]);
    skinref = operatorbundle.defaultskin;

    if(isDefined(skinbundle)) {
      level.var_7c09484f1926c102[operatorref] = skinref;

      if(function_35303b94875f6d5b(skinbundle.var_6739a9c997eec5c5)) {
        level.var_212650972ad1a958[skinbundle.lootid] = skinbundle.var_6739a9c997eec5c5;
      }
    }
  }
}

function function_10ad0df66b5a20a7(skinlootid) {
  if(!skinlootid || loot::function_52cf8374c44a4ff5(skinlootid) != "operator_skin") {
    return false;
  }

  operatorSkinRef = loot::function_f54ecb89dfab8e8c(skinlootid);
  operatorref = function_30f20ce375c4ee40(operatorSkinRef);
  return arraycontains(getoperatorrefs(), operatorref) && arraycontains(function_98bc5ea0c0c97599(operatorref), operatorSkinRef);
}

function function_447fce2531e40d0e(operatorref) {
  function_e5efd24ec4dbf5d9();

  if(isDefined(level.var_7c09484f1926c102[operatorref])) {
    return level.var_7c09484f1926c102[operatorref];
  }

  return % "";
}

function function_98bc5ea0c0c97599(operatorref) {
  function_e5efd24ec4dbf5d9();
  return level.var_ff43edef64cd11ef[operatorref] ?? [];
}

function function_27f5412663e0a09() {
  function_e5efd24ec4dbf5d9();
  return level.var_aea805ad236a525f;
}

function function_30f20ce375c4ee40(skinref) {
  function_e5efd24ec4dbf5d9();

  if(isstring(skinref)) {
    skinref = getxhashasset(skinref);
  }

  if(!isDefined(level.var_b4c751094ee885a7[skinref])) {
    assertmsg("<dev string:x544>" + getxhashsourcename(skinref));
  }

  return level.var_b4c751094ee885a7[skinref];
}

function function_d1e10cddb12fbe17(skinref, var_5c6c42708a3dc0c) {
  skinbundle = getoperatorskinscriptbundle(skinref, var_5c6c42708a3dc0c);

  if(!isDefined(skinbundle)) {
    assertmsg("<dev string:x56b>" + getxhashsourcename(skinref));
  }

  return skinbundle;
}

function function_115f78fb5f506daa(skinref) {
  head = function_d1e10cddb12fbe17(skinref, #"head").head;

  if(head) {
    return getscriptbundlefieldvalue(head, #"model");
  }

  return % "";
}

function function_4e6b11f7340acc24(skinref) {
  body = function_d1e10cddb12fbe17(skinref, #"body").body;

  if(body) {
    return getscriptbundlefieldvalue(body, #"model");
  }

  return % "";
}

function function_5c6e83213643805(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"nvgmodeldown").var_6d14360d020a276c ?? % "";
}

function function_4dcee1262a4ab410(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"nvgmodelup").var_594edf28884a02ad ?? % "";
}

function function_faa5d37f28e6d925(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"canequip").canequip ?? 1;
}

function function_6261fa1bcd3ce668(skinref) {
  skinbundle = function_d1e10cddb12fbe17(skinref, #"botinvalid");

  if(isDefined(skinbundle)) {
    if(isDefined(skinbundle.botinvalid)) {
      return !skinbundle.botinvalid;
    } else {
      return 1;
    }

    return;
  }

  return 0;
}

function function_82781d300aee973e(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"lootimage").lootimage ?? "";
}

function function_b1788ccf1b3c0ae9(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"sfxclothtype").var_561cd3d671f43fef ?? "";
}

function function_d633420b529828e8(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"sfxgeartype").var_792276a508ec7f1a ?? "";
}

function function_5f1afd050db1579b(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"hash_e5cac6afd35e1f45").var_a61af6bf6ea49f06 ?? "";
}

function function_c203df33ce95f84c(skinref) {
  return function_d1e10cddb12fbe17(skinref, #"lootid").lootid ?? 0;
}

function getreactiveoperator(skinref) {
  return function_d1e10cddb12fbe17(skinref, [#"reactiveoperator"]).reactiveoperator;
}

function function_bb4618718e086740(skinref) {
  return function_d1e10cddb12fbe17(skinref, [#"hash_b74126130fe1bde8"]).var_ba5ef8ce1f6a6aa3;
}

function function_4c7f17b5ae87e7be(skinref) {
  return function_d1e10cddb12fbe17(skinref, [#"hash_a30796472eab0efe"]).var_1a6762affce6e181;
}

function function_4c23b4a4c457f40b(skinref) {
  return function_d1e10cddb12fbe17(skinref, [#"hash_babfddf124746871"]).var_ce1ec4a85f852e14;
}

function function_233474e80ffd30(skinref) {
  return function_d1e10cddb12fbe17(skinref, [#"hash_321fae418d44abbc"]).var_430f23d923c86ba3;
}

function function_5b6aad02fe43f871(skinref) {
  return function_d1e10cddb12fbe17(skinref, [#"hash_3f979bdff8dd6b0d"]).var_5f51bf7f6da09282;
}

function function_a3de63ccf4242040() {
  if(isDefined(level.var_472d401a5207883e)) {
    return;
  }

  function_11ee19e7029ad088();
}

function private function_11ee19e7029ad088() {
  function_e5efd24ec4dbf5d9();
  level.var_472d401a5207883e = [];
  level.defaultbody = {};

  if(isbuildingmap()) {
    return;
  }

  var_6c8af3a3a8df953b = [#"model", #"defaultbody", #"armmodel", #"defaultarms"];

  foreach(skinref in level.var_aea805ad236a525f) {
    bodybundlename = getoperatorskinscriptbundle(skinref, #"body").body;

    if(isDefined(bodybundlename) && bodybundlename != % "") {
      bodydata = getscriptbundlefieldvalues(bodybundlename, var_6c8af3a3a8df953b);
      level.var_472d401a5207883e[bodydata.model] = bodydata;
    }
  }
}

function function_b79d18c6c2337724(bodymodel) {
  function_a3de63ccf4242040();
  bodydata = level.var_472d401a5207883e[bodymodel];

  if(isDefined(bodydata)) {
    return bodydata;
  }

  assertmsg("<dev string:x590>" + bodymodel);
  return level.defaultbody;
}

function function_1ff6a02a2046ba2c(bodymodel) {
  bodydata = function_b79d18c6c2337724(bodymodel);
  return bodydata.armmodel ?? bodydata.defaultarms;
}

function function_35303b94875f6d5b(var_e1488ff65b74a26c) {
  if(!isDefined(var_e1488ff65b74a26c) || var_e1488ff65b74a26c == #"") {
    return false;
  }

  assert(isxhash(var_e1488ff65b74a26c));

  if(!isDefined(level.var_c769fc53a092c8b4)) {
    var_f2961c59221ccf42 = strtok(getDvar(@ "hash_888c1a8e6ebb7178", ""), ",");
    level.var_c769fc53a092c8b4 = [];

    foreach(skinset in var_f2961c59221ccf42) {
      level.var_c769fc53a092c8b4[getxhash(skinset)] = 1;
    }
  }

  return isDefined(level.var_c769fc53a092c8b4[var_e1488ff65b74a26c]);
}

function function_647772866281c051(lootid) {
  function_e5efd24ec4dbf5d9();

  if(isDefined(level.var_212650972ad1a958[lootid])) {
    return level.var_212650972ad1a958[lootid];
  }

  return undefined;
}

function private function_e0f57a7fe250f216() {
  if(isDefined(level.var_ba16f6b55c830dd7)) {
    return;
  }

  level.var_ba16f6b55c830dd7 = [];
  level.var_e671d0cb401c31b4 = [];

  if(isbuildingmap()) {
    return;
  }

  gamemodebundle = level.gamemodebundle;

  if(!isDefined(gamemodebundle.execution_list)) {
    return;
  }

  var_a16dfa195494bfb0 = getscriptbundle(hashcat(%"hash_3cf279fa8ccaf24e", gamemodebundle.execution_list));

  if(!isDefined(var_a16dfa195494bfb0)) {
    println("<dev string:x5bc>" + gamemodebundle.execution_list);
    return;
  }

  executionlist = var_a16dfa195494bfb0.operatorexecutionlist;

  for(i = 0; i < executionlist.size; i++) {
    if(!isDefined(executionlist[i].operatorexecution)) {
      continue;
    }

    executionbundle = getscriptbundlefieldvalues(hashcat(%"hash_3c0bcccfd8362f86", executionlist[i].operatorexecution), [#"lootid", #"execution", #"propweapon"]);
    executionref = executionlist[i].operatorexecution;

    if(!isDefined(executionbundle)) {
      println("<dev string:x5ec>" + gamemodebundle.execution_list + "<dev string:x3f1>" + executionlist[i].operatorexecution);
      continue;
    }

    level.var_ba16f6b55c830dd7[executionref] = executionbundle;
    level.var_e671d0cb401c31b4[level.var_e671d0cb401c31b4.size] = executionref;
  }
}

function private function_2480f61a1b8bce30(executionref) {
  function_e0f57a7fe250f216();
  assert(isDefined(level.var_ba16f6b55c830dd7[executionref]), "<dev string:x624>" + executionref);
  return level.var_ba16f6b55c830dd7[executionref];
}

function private isexecutionvalid(executionref) {
  if(isDefined(executionref) && executionref != "") {
    return (utility::callsharedfunc(#"execution", #"validate", executionref) ?? 1);
  }

  return false;
}

function private function_10f49a11ea83fafe() {
  return function_3f565e1417cc2505(0);
}

function function_17165c3055f66282() {
  function_e0f57a7fe250f216();
  return level.var_e671d0cb401c31b4;
}

function function_3f565e1417cc2505(executionid) {
  function_e0f57a7fe250f216();
  assert(isDefined(level.var_e671d0cb401c31b4[executionid]), "<dev string:x64e>" + executionid);
  return level.var_e671d0cb401c31b4[executionid];
}

function function_dc3356e535601e05(executionref) {
  function_e0f57a7fe250f216();
  executionid = function_f02c63b99c9614c9(level.var_e671d0cb401c31b4, executionref);
  assert(isDefined(executionid), "<dev string:x679>" + executionref);
  return executionid;
}

function function_81f3e01100510bff(executionref) {
  var_7237854e3be197ca = function_2480f61a1b8bce30(executionref).lootid;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return 0;
}

function function_843ab3d2e4282f00(executionref) {
  var_7237854e3be197ca = function_2480f61a1b8bce30(executionref).execution;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return "none";
}

function function_4bd4a8df3ca7ae0c(executionref) {
  var_7237854e3be197ca = function_2480f61a1b8bce30(executionref).propweapon;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return "none";
}

function getoperatorcustomization() {
  customization = [];
  body = undefined;
  head = undefined;
  operatorSkinRef = undefined;

  if(!isDefined(self.operatorcustomization)) {
    createoperatorcustomization();
  }

  operatorSkinRef = self.operatorcustomization.skinref;

  if(isDefined(level.modegetforceoperatorcustomization)) {
    operatorref = function_30f20ce375c4ee40(operatorSkinRef);
    [operatorIndex, operatorSkinRef] = [[level.modegetforceoperatorcustomization]](self, operatorref, operatorSkinRef);
  }

  body = function_4e6b11f7340acc24(operatorSkinRef);
  head = function_115f78fb5f506daa(operatorSkinRef);

  if(body == "" || head == "") {
    assertmsg("<dev string:x6a5>" + getxhashsourcename(operatorSkinRef) + "<dev string:x6f0>" + getxhashsourcename(head) + "<dev string:x6fd>" + getxhashsourcename(body));
    defaultskin = function_447fce2531e40d0e(self.operatorcustomization.operatorref);
    body = function_4e6b11f7340acc24(defaultskin);
    head = function_115f78fb5f506daa(defaultskin);
  }

  self.bodymodelname = body;
  self.backuphead = head;
  customization[0] = body;
  customization[1] = head;
  return customization;
}

function createoperatorcustomization(operatorref, operatorskin) {
  if(isbuildingmap()) {
    return;
  }

  self function_16332a7775f10aa9();
  self.operatorcustomization = undefined;
  operatorcustomization = spawnStruct();

  var_19dac495352462f2 = getDvar(@ "hash_17a1591e3fe7c036");
  var_bae05cfc6db1421e = getdvarint(@ "hash_18d61f3fa39645ac", 0);

  if(isDefined(var_19dac495352462f2) && var_19dac495352462f2 != "<dev string:x70a>") {
    var_1d6c368bd4334 = strtok(var_19dac495352462f2, "<dev string:x70e>");
    operatorskin = getxhashasset(var_1d6c368bd4334[randomint(var_1d6c368bd4334.size)]);
    operatorref = function_30f20ce375c4ee40(operatorskin);
  } else if(var_bae05cfc6db1421e == 1 && isDefined(level.gamemodebundle.var_e8fe08e7fc3b1dd8)) {
    skinlist = level.gamemodebundle.var_e8fe08e7fc3b1dd8;

    if(skinlist.size > 0) {
      operatorskin = getxhashasset(skinlist[randomint(skinlist.size)].skin);
      operatorref = function_30f20ce375c4ee40(operatorskin);
    }
  }

  if(!(isDefined(operatorref) && isDefined(operatorskin))) {
    operatorref = function_899f4c5b97e8a453();
    operatorskin = function_cc5d60d5178c5007();
  }

  var_3349ff2ffef57c34 = istrue(getdvarint(@ "scr_loadout_validate_banned_items", 0));

  if(var_3349ff2ffef57c34 && loot::function_72263d7f509cd8cd(operatorskin)) {
    operatorskin = function_447fce2531e40d0e(operatorref);
  }

  if(var_3349ff2ffef57c34 && loot::function_72263d7f509cd8cd(operatorref)) {
    operatorref = function_297589994c9a9eff(self.team == "allies" ? 0 : 1);
    operatorskin = function_447fce2531e40d0e(operatorref);
  }

  operatorcustomization.operatorref = operatorref;
  operatorcustomization.skinref = operatorskin;
  operatorcustomization.reactiveoperator = getreactiveoperator(operatorskin);
  operatorcustomization.skinlootid = function_c203df33ce95f84c(operatorskin);
  operatorcustomization.gender = getoperatorgender(operatorref);
  operatorcustomization.voice = getoperatorvoice(operatorref);
  operatorcustomization.clothtype = function_b1788ccf1b3c0ae9(operatorskin);
  operatorcustomization.geartype = function_d633420b529828e8(operatorskin);
  operatorcustomization.superfaction = getoperatorsuperfaction(operatorref);
  operatorcustomization.execution = function_4308bc9472e8e835();
  operatorcustomization.parachute = function_e6885d5990982272();
  operatorcustomization.contrail = function_4202dbfeb87e9ddb();
  operatorcustomization.dialogset = function_bc6d8ad64545fc57(operatorref, operatorskin);

  if(utility::issharedfuncdefined(#"bodysize", #"hash_db91c8d9ee604746")) {
    operatorcustomization.suit = utility::callsharedfunc(#"bodysize", #"hash_db91c8d9ee604746", operatorref);
  } else {
    operatorcustomization.suit = utility::function_f825237e0eda5adf();
  }

  operatorcustomization.rebuild = 0;
  self.operatorcustomization = operatorcustomization;
  customization = getoperatorcustomization();
  body = customization[0];
  head = customization[1];

  if(!isagent(self)) {
    function_c8490391be6bc57e(body, head);
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    var_1595237faa50b3e8 = self getcustomizationviewmodel();
    viewmodelname = function_1ff6a02a2046ba2c(body);
  }

  if(!level.projectbundle.var_672cd1b066200001) {
    operatorcustomization.chroma = function_54b61a935e8d6ed2();
    self setoperatorchroma(operatorcustomization.chroma);
  }

  self.operatorcustomization.body = body;
  self.operatorcustomization.defaultbody = bodymodelname;
  self.operatorcustomization.head = head;
  self.operatorcustomization.defaulthead = headmodelname;
  self.operatorcustomization.vm = viewmodelname;
  self.operatorcustomization.defaultvm = var_1595237faa50b3e8;

  if(!isagent(self) && !isbot(self) && !isDefined(self.vehiclecustomization)) {
    self.vehiclecustomization = vehicle::create_customization();
  }

  function_d94a89bd1eb20033(self.operatorcustomization);
  callback::callback(#"hash_1c82c96d0d334fcc");
}

function private function_d94a89bd1eb20033(operatorcustomization) {
  var_d275275b9c49f288 = getdvarint(@ "hash_838359d5ebdcc7e0", 0);

  if(var_d275275b9c49f288 == 0) {
    return;
  }

  var_e0ab867b479dae36 = getdvarint(@ "hash_b77bb859108e69cd", 0);
  var_94e77c4dc77013b7 = getdvarint(@ "hash_91b801ddfb57ae8a", 0);

  if(!level.rankedmatch || !level.matchmakingmatch || !level.onlinestatsenabled) {
    return;
  }

  var_8a9fe7aa2cde3afe = [];

  if(var_e0ab867b479dae36 == 1) {
    var_8a9fe7aa2cde3afe[var_8a9fe7aa2cde3afe.size] = self.operatorcustomization.skinlootid;
  }

  if(var_94e77c4dc77013b7 == 1) {
    var_8a9fe7aa2cde3afe[var_8a9fe7aa2cde3afe.size] = loot::getlootidfromref(self.operatorcustomization.execution);
  }

  self function_49bdd1291f4756ca(var_8a9fe7aa2cde3afe);
}

function function_c8490391be6bc57e(body, head) {
  if(!self isvalidcustomization(body, head)) {
    assertmsg("<dev string:x713>" + getxhashsourcename(head) + "<dev string:x6fd>" + getxhashsourcename(body));
    return;
  }

  self setcustomization(body, head);
}

function function_99f3495eb915fb96() {
  if(isDefined(level.var_77fb663123a79288)) {
    return;
  }

  level.var_77fb663123a79288 = [];
  setDvar(@ "hash_2b669ad6c3e1d864", 1);

  if(!isDefined(level.var_77fb663123a79288["allies"])) {
    level.var_77fb663123a79288["allies"] = [];
  }

  if(!isDefined(level.var_77fb663123a79288["axis"])) {
    level.var_77fb663123a79288["axis"] = [];
  }

  operatorrefs = getoperatorrefs();
  var_c14f2aed1868e9bc = getdvarint(@ "hash_88e9180e81267df2", 0);

  foreach(operatorref in operatorrefs) {
    if(!isDefined(operatorref) || operatorref == % "") {
      continue;
    }

    unlocked = isoperatorunlocked(operatorref);

    if(!unlocked && !var_c14f2aed1868e9bc) {
      continue;
    }

    if(!function_2b34573c920ee585(operatorref) && !var_c14f2aed1868e9bc) {
      continue;
    }

    superfaction = getoperatorsuperfaction(operatorref);
    team = superfaction == 0 ? "allies" : "axis";
    level.var_77fb663123a79288[team][operatorref] = [];
  }

  skinRefs = function_27f5412663e0a09();

  foreach(skinref in skinRefs) {
    if(!skinref) {
      continue;
    }

    if(!function_faa5d37f28e6d925(skinref)) {
      continue;
    }

    if(!function_6261fa1bcd3ce668(skinref)) {
      continue;
    }

    operatorref = function_30f20ce375c4ee40(skinref);
    superfaction = getoperatorsuperfaction(operatorref);
    team = superfaction == 0 ? "allies" : "axis";

    if(!level.var_77fb663123a79288[team][operatorref]) {
      continue;
    }

    level.var_77fb663123a79288[team][operatorref][level.var_77fb663123a79288[team][operatorref].size] = skinref;
  }

  teams = [];
  teams = ["allies", "axis"];

  foreach(team in teams) {
    newarray = [];

    foreach(key, entry in level.var_77fb663123a79288[team]) {
      if(entry.size > 0) {
        newarray[key] = entry;
      }
    }

    level.var_77fb663123a79288[team] = newarray;
  }
}

function function_4d6b18d1d4da29bd() {
  if(level.multiteambased || !level.teambased) {
    return true;
  }

  if(isDefined(level.gametypebundle)) {
    if(level.gametypebundle.teambased == 1) {
      return (level.gametypebundle.var_4b6318add901104c == 1);
    }
  }

  return false;
}

function function_2d5c14a8c98cf89d() {
  assert(isPlayer(self));
  var_a3559c3721faf851 = self.team == "allies" ? 0 : 1;

  if(function_4d6b18d1d4da29bd() && !level.projectbundle.var_5929f3f4d2dc1f06) {
    var_a3559c3721faf851 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  }

  return var_a3559c3721faf851;
}

function function_ce41b4b58036e41c(var_a3559c3721faf851) {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(var_a3559c3721faf851 == 0 || var_a3559c3721faf851 == 1);
  operatorlootid = 0;

  if(function_c79f6a12d91ad551()) {
    operatorlootid = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperator", var_a3559c3721faf851, "operatorLootId");
  } else {
    operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var_a3559c3721faf851);
    operatorlootid = loot::getlootidfromref(operatorref);
  }

  if(loot::function_52cf8374c44a4ff5(operatorlootid) == "operator") {
    return operatorlootid;
  }

  return 0;
}

function function_dc48b1d8163a5d60(var_a3559c3721faf851) {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(var_a3559c3721faf851 == 0 || var_a3559c3721faf851 == 1);
  defaultoperatorteam = function_1e32019139bf7206();

  if(getdvarint(@ "hash_9377281fd8d98b6e", 0) == 1 || self.pers["forceDefaultLoadouts"]) {
    return level.defaultoperator[defaultoperatorteam];
  }

  operatorlootid = function_ce41b4b58036e41c(var_a3559c3721faf851);

  if(operatorlootid != 0) {
    ref = loot::function_f54ecb89dfab8e8c(operatorlootid);

    if(isDefined(ref)) {
      operatorref = getxhashasset(ref);
    }
  }

  if(!function_fb3ad5cd3a9ae76b(operatorref)) {
    operatorref = level.defaultoperator[defaultoperatorteam];
  }

  return operatorref;
}

function function_88393e18041634ac(superfaction) {
  assert(isai(self) || self isplayerheadless());
  function_99f3495eb915fb96();
  operatorref = "";

  if(isDefined(self.botoperatorref)) {
    return self.botoperatorref;
  }

  var_6e8217c1a6d26f54 = getDvar(@ "hash_803cefdbe23f6bfe", "");
  var_8e142dbf8e355048 = getDvar(@ "hash_536fb96e928e1c53", "");

  if(var_6e8217c1a6d26f54 != "") {
    var_1d6c368bd4334 = strtok(var_6e8217c1a6d26f54, ",");
    var_a011809dacf9838f = getxhashasset(var_1d6c368bd4334[randomint(var_1d6c368bd4334.size)]);
    var_2006406403e406f8 = function_30f20ce375c4ee40(var_a011809dacf9838f);

    if(function_fb3ad5cd3a9ae76b(var_2006406403e406f8)) {
      self.botoperatorref = var_2006406403e406f8;
      self.var_a011809dacf9838f = var_a011809dacf9838f;
      return self.botoperatorref;
    }
  } else if(var_8e142dbf8e355048 != "") {
    assert(level.botloadouts);
    assert(level.botloadouts.overrideskins.size > 0);
    skinoverride = utility::array_random(level.botloadouts.overrideskins);
    var_a011809dacf9838f = getxhashasset(skinoverride);
    var_2006406403e406f8 = function_30f20ce375c4ee40(var_a011809dacf9838f);

    if(function_fb3ad5cd3a9ae76b(var_2006406403e406f8)) {
      self.botoperatorref = var_2006406403e406f8;
      self.var_a011809dacf9838f = var_a011809dacf9838f;
      return self.botoperatorref;
    }
  }

  if(!isDefined(self.pers["operatorTeam"])) {
    team = self.team;

    if(isDefined(superfaction)) {
      team = superfaction == 0 ? "allies" : "axis";
    } else {
      assert(isDefined(team));
    }

    if(!isDefined(level.var_77fb663123a79288[team])) {
      var_1bfdfe698f07f365 = getarraykeys(level.var_77fb663123a79288);
      self.pers["operatorTeam"] = utility::random(var_1bfdfe698f07f365);
    } else {
      self.pers["operatorTeam"] = team;
    }
  }

  if(!isDefined(self.pers["operatorIndex"])) {
    self.pers["operatorIndex"] = randomint(level.var_77fb663123a79288[self.pers["operatorTeam"]].size);
  }

  currentindex = 0;

  foreach(operatorkey, skinarray in level.var_77fb663123a79288[self.pers["operatorTeam"]]) {
    if(currentindex == self.pers["operatorIndex"]) {
      self.botoperatorref = operatorkey;
      break;
    }

    currentindex++;
  }

  return self.botoperatorref;
}

function function_1e32019139bf7206() {
  var_a3559c3721faf851 = function_2d5c14a8c98cf89d();

  if(var_a3559c3721faf851 == 0) {
    return "allies";
  }

  return "axis";
}

function function_899f4c5b97e8a453(superfaction) {
  if(!isPlayer(self) && !isai(self)) {
    assert(0, "<dev string:x738>");
    return "";
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.operatorref)) {
    return self.operatorcustomization.operatorref;
  }

  operatorref = undefined;

  if(isai(self) || self isplayerheadless()) {
    return function_88393e18041634ac(superfaction);
  } else {
    operatorlootid = utility::callsharedfunc(#"instanceInventory", #"getActiveOperatorLootID", self);

    if(isDefined(operatorlootid) && operatorlootid != 0) {
      operatorref = getxhashasset(loot::function_f54ecb89dfab8e8c(operatorlootid));
    } else {
      var_a3559c3721faf851 = function_2d5c14a8c98cf89d();
      operatorref = function_dc48b1d8163a5d60(var_a3559c3721faf851);
    }
  }

  return operatorref;
}

function private function_4c56ad6bdf59f32d(superfaction) {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(superfaction == 0 || superfaction == 1);

  if(self.pers["forceDefaultLoadouts"]) {
    return 0;
  }

  operatorskinlootid = 0;

  if(function_c79f6a12d91ad551()) {
    operatorskinlootid = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperator", superfaction, "skinLootId");
  } else {
    operatorref = function_dc48b1d8163a5d60(superfaction);

    if(operatorref && function_fb3ad5cd3a9ae76b(operatorref)) {
      operatorSkinRef = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "skin");
      operatorskinlootid = loot::getlootidfromref(operatorSkinRef);
    }
  }

  if(!function_10ad0df66b5a20a7(operatorskinlootid)) {
    return 0;
  }

  return operatorskinlootid;
}

function function_cc5d60d5178c5007(superfaction) {
  assert(isPlayer(self));

  if(!isPlayer(self)) {
    return "";
  }

  if(isDefined(self.operatorcustomization.skinref)) {
    return self.operatorcustomization.skinref;
  }

  skinref = "";

  if(!isagent(self)) {
    lootid = utility::callsharedfunc(#"instanceInventory", #"getActiveOperatorSkinLootID", self);

    if(isDefined(lootid) && lootid != 0) {
      return getxhashasset(loot::function_f54ecb89dfab8e8c(lootid));
    }
  }

  if(isbot(self) || self isplayerheadless()) {
    operatorref = function_899f4c5b97e8a453(superfaction);

    if(isDefined(self.var_a011809dacf9838f)) {
      return self.var_a011809dacf9838f;
    }

    if(!isDefined(level.var_77fb663123a79288)) {
      function_99f3495eb915fb96();
    }

    team = self.pers["operatorTeam"] ?? self.team;
    randomindex = randomint(level.var_77fb663123a79288[team][operatorref].size);
    return level.var_77fb663123a79288[team][operatorref][randomindex];
  }

  superfaction = function_2d5c14a8c98cf89d();
  operatorskinlootid = function_4c56ad6bdf59f32d(superfaction);
  lootref = loot::function_f54ecb89dfab8e8c(operatorskinlootid);

  if(lootref) {
    skinref = getxhashasset(lootref);
  }

  if(!isDefined(skinref) || skinref == % "") {
    operatorref = function_899f4c5b97e8a453();
    return function_447fce2531e40d0e(operatorref);
  }

  return skinref;
}

function function_d24f366ea9117af1() {
  return function_cc5d60d5178c5007(0);
}

function function_ef2efa78a5ae293f() {
  return function_cc5d60d5178c5007(1);
}

function private function_11ab18dc0f9b6e54(var_a3559c3721faf851) {
  assert(isDefined(self));
  assert(isPlayer(self));

  if(self.pers["forceDefaultLoadouts"]) {
    return 0;
  }

  if(!isDefined(var_a3559c3721faf851)) {
    var_a3559c3721faf851 = function_2d5c14a8c98cf89d();
  }

  if(function_c79f6a12d91ad551()) {
    executionlootid = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperator", var_a3559c3721faf851, "executionLootId");
  } else {
    operatorref = function_dc48b1d8163a5d60(var_a3559c3721faf851);

    if(operatorref && function_fb3ad5cd3a9ae76b(operatorref)) {
      executionlootid = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "execution");
    }
  }

  if(loot::function_52cf8374c44a4ff5(executionlootid) != "executions") {
    return 0;
  }

  return executionlootid;
}

function function_4308bc9472e8e835() {
  assert(isPlayer(self));

  if(!isPlayer(self)) {
    return "";
  }

  operatorref = function_899f4c5b97e8a453();
  executionlootid = 0;

  if(!isagent(self)) {
    executionlootid = utility::callsharedfunc(#"instanceInventory", #"getActiveOperatorExecutionLootID", self) ?? 0;

    if(executionlootid == 0) {
      executionlootid = function_11ab18dc0f9b6e54();
    }
  }

  if(isDefined(executionlootid) && executionlootid != 0) {
    var_795640b75d113220 = loot::function_f54ecb89dfab8e8c(executionlootid);

    if(isexecutionvalid(var_795640b75d113220)) {
      return var_795640b75d113220;
    }

    assertmsg("<dev string:x76b>" + var_795640b75d113220 + "<dev string:x794>");
  }

  var_83d21bf52ce92f15 = getDvar(@ "hash_57210a2c6c50497b");

  if(isexecutionvalid(var_83d21bf52ce92f15)) {
    return var_83d21bf52ce92f15;
  }

  var_b9390f534fcde91c = function_db4f41253b282a4f(operatorref);

  if(isexecutionvalid(var_b9390f534fcde91c)) {
    return var_b9390f534fcde91c;
  }

  var_3e9e7a054da76197 = function_10f49a11ea83fafe();

  if(isexecutionvalid(var_3e9e7a054da76197)) {
    return var_3e9e7a054da76197;
  }

  return "";
}

function function_54b61a935e8d6ed2() {
  if(!isagent(self)) {
    if(function_c79f6a12d91ad551()) {
      return getxhashasset("none");
    } else {
      operatorref = function_899f4c5b97e8a453();

      if(!self hasplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "chroma")) {
        return getxhashasset("none");
      }

      chromalootid = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "chroma");
    }
  }

  return chromalootid;
}

function function_f88d52fd5e48c60a() {
  var_805ecfacf843aea7 = function_54b61a935e8d6ed2();
  return getxhashasset(loot::function_f54ecb89dfab8e8c(var_805ecfacf843aea7));
}

function function_e6885d5990982272() {
  parachutelootid = self getplayerdata("common", "commonCustomization", "parachute");
  parachuteref = loot::function_f54ecb89dfab8e8c(parachutelootid);

  if(!parachuteref) {
    return undefined;
  }

  return getxhashasset(parachuteref);
}

function function_4202dbfeb87e9ddb() {
  contraillootid = self getplayerdata("common", "commonCustomization", "contrail");
  contrailref = loot::function_f54ecb89dfab8e8c(contraillootid);

  if(!contrailref) {
    return undefined;
  }

  return getxhashasset(contrailref);
}

function function_b518cf4ab4b71ede() {
  if(getdvarint(@ "hash_4753586a2ac8718f", 0) == 0) {
    println("<dev string:x7d0>" + "<dev string:x80f>");
    return;
  }

  headsize = 1;
  head = self.operatorcustomization.head;
  var_5b99f965fcb3c896 = head[head.size - 1];

  switch (var_5b99f965fcb3c896) {
    case #"hash_31103fbc01bd840c":
      headsize = 1;
      break;
    case #"hash_311042bc01bd88c5":
      headsize = 2;
      break;
    case #"hash_311041bc01bd8732":
      headsize = 3;
      break;
  }

  return headsize;
}

function isfemale() {
  return isDefined(self.operatorcustomization) && self.operatorcustomization.gender == "female";
}

function private function_17f449ac974622de() {
  result = "";

  if(isDefined(self.operatorcustomization.operatorref)) {
    operatorbundle = getoperatorbundle(self.operatorcustomization.operatorref, [#"gendersoundcontext"]);
    result = operatorbundle.gendersoundcontext ?? result;
  }

  if(isDefined(self.operatorcustomization.skinref)) {
    skinbundle = function_d1e10cddb12fbe17(self.operatorcustomization.skinref, [#"hash_b05b686f13e4736e", #"gendersoundcontext"]);

    if(skinbundle.var_866e482772f02fe1) {
      result = skinbundle.gendersoundcontext ?? result;
    }
  }

  if(result == "male") {
    result = "";
  }

  return result;
}

function setgendersoundcontext() {
  if(getdvarint(@ "hash_42eedfce002ae468", 1)) {
    self setwearinggasmask(0);
    return;
  }

  self setclientgender("");

  if(isDefined(self.operatorcustomization)) {
    self setclientgender(function_17f449ac974622de());
  }
}

function function_89e5e91ee0fb0836() {
  if(getdvarint(@ "hash_42eedfce002ae468", 1)) {
    self setwearinggasmask(1);
    return;
  }

  if(isfemale()) {
    self setclientgender("gasmask_female");
    return;
  }

  self setclientgender("gasmask_male");
}
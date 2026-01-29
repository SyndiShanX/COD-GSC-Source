/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\battlechatter.gsc
*****************************************/

_id_0B6B() {
  if(isDefined(anim._id_0AAB) && anim._id_0AAB) {
    return;
  }
  setdvarifuninitialized("bcs_enable", "on");

  if(getdvar("bcs_enable", "on") == "off") {
    anim._id_0AAB = 0;
    anim.player._id_0AAB = 0;
    return;
  }

  anim._id_0AAB = 1;
  anim.player._id_0AAB = 0;
  setdvarifuninitialized("bcs_filterThreat", "off");
  setdvarifuninitialized("bcs_filterInform", "off");
  setdvarifuninitialized("bcs_filterOrder", "off");
  setdvarifuninitialized("bcs_filterReaction", "off");
  setdvarifuninitialized("bcs_filterResponse", "off");
  setdvarifuninitialized("bcs_forceEnglish", "0");
  setdvarifuninitialized("bcs_allowsamevoiceresponse", "off");
  setdvarifuninitialized("debug_bcprint", "off");
  setdvarifuninitialized("debug_bcprintdump", "off");
  setdvarifuninitialized("debug_bcprintdumptype", "csv");
  setdvarifuninitialized("debug_bcshowqueue", "off");
  anim._id_0B41 = "^3***** BCS FAILURE: ";
  anim._id_0B6C = "^3***** BCS WARNING: ";
  _id_0B8B();
  _id_0B8C();
  anim._id_0AD0["american"] = "1";
  anim._id_0AD0["seal"] = "1";
  anim._id_0AD0["taskforce"] = "1";
  anim._id_0AD0["secretservice"] = "1";
  anim._id_0AD0["delta"] = "1";
  thread _id_0B9F();
  anim._id_0ABB = [];
  anim._id_0ABB["russian"] = [];
  anim._id_0ABB["russian"][0] = spawnStruct();
  anim._id_0ABB["russian"][0].count = 0;
  anim._id_0ABB["russian"][0]._id_0AB6 = "0";
  anim._id_0ABB["russian"][1] = spawnStruct();
  anim._id_0ABB["russian"][1].count = 0;
  anim._id_0ABB["russian"][1]._id_0AB6 = "1";
  anim._id_0ABB["russian"][2] = spawnStruct();
  anim._id_0ABB["russian"][2].count = 0;
  anim._id_0ABB["russian"][2]._id_0AB6 = "2";
  anim._id_0ABB["russian"][3] = spawnStruct();
  anim._id_0ABB["russian"][3].count = 0;
  anim._id_0ABB["russian"][3]._id_0AB6 = "3";
  anim._id_0ABB["russian"][4] = spawnStruct();
  anim._id_0ABB["russian"][4].count = 0;
  anim._id_0ABB["russian"][4]._id_0AB6 = "4";
  anim._id_0ABB["portuguese"] = [];
  anim._id_0ABB["portuguese"][0] = spawnStruct();
  anim._id_0ABB["portuguese"][0].count = 0;
  anim._id_0ABB["portuguese"][0]._id_0AB6 = "0";
  anim._id_0ABB["portuguese"][1] = spawnStruct();
  anim._id_0ABB["portuguese"][1].count = 0;
  anim._id_0ABB["portuguese"][1]._id_0AB6 = "1";
  anim._id_0ABB["portuguese"][2] = spawnStruct();
  anim._id_0ABB["portuguese"][2].count = 0;
  anim._id_0ABB["portuguese"][2]._id_0AB6 = "2";
  anim._id_0ABB["shadowcompany"] = [];
  anim._id_0ABB["shadowcompany"][0] = spawnStruct();
  anim._id_0ABB["shadowcompany"][0].count = 0;
  anim._id_0ABB["shadowcompany"][0]._id_0AB6 = "0";
  anim._id_0ABB["shadowcompany"][1] = spawnStruct();
  anim._id_0ABB["shadowcompany"][1].count = 0;
  anim._id_0ABB["shadowcompany"][1]._id_0AB6 = "1";
  anim._id_0ABB["shadowcompany"][2] = spawnStruct();
  anim._id_0ABB["shadowcompany"][2].count = 0;
  anim._id_0ABB["shadowcompany"][2]._id_0AB6 = "2";
  anim._id_0ABB["shadowcompany"][3] = spawnStruct();
  anim._id_0ABB["shadowcompany"][3].count = 0;
  anim._id_0ABB["shadowcompany"][3]._id_0AB6 = "3";
  anim._id_0ABB["british"] = [];
  anim._id_0ABB["british"][0] = spawnStruct();
  anim._id_0ABB["british"][0].count = 0;
  anim._id_0ABB["british"][0]._id_0AB6 = "0";
  anim._id_0ABB["british"][1] = spawnStruct();
  anim._id_0ABB["british"][1].count = 0;
  anim._id_0ABB["british"][1]._id_0AB6 = "1";
  anim._id_0ABB["american"] = [];
  anim._id_0ABB["american"][0] = spawnStruct();
  anim._id_0ABB["american"][0].count = 0;
  anim._id_0ABB["american"][0]._id_0AB6 = "0";
  anim._id_0ABB["american"][1] = spawnStruct();
  anim._id_0ABB["american"][1].count = 0;
  anim._id_0ABB["american"][1]._id_0AB6 = "1";
  anim._id_0ABB["american"][2] = spawnStruct();
  anim._id_0ABB["american"][2].count = 0;
  anim._id_0ABB["american"][2]._id_0AB6 = "2";
  anim._id_0ABB["seal"] = [];
  anim._id_0ABB["seal"][0] = spawnStruct();
  anim._id_0ABB["seal"][0].count = 0;
  anim._id_0ABB["seal"][0]._id_0AB6 = "0";
  anim._id_0ABB["seal"][1] = spawnStruct();
  anim._id_0ABB["seal"][1].count = 0;
  anim._id_0ABB["seal"][1]._id_0AB6 = "1";
  anim._id_0ABB["seal"][2] = spawnStruct();
  anim._id_0ABB["seal"][2].count = 0;
  anim._id_0ABB["seal"][2]._id_0AB6 = "2";
  anim._id_0ABB["seal"][3] = spawnStruct();
  anim._id_0ABB["seal"][3].count = 0;
  anim._id_0ABB["seal"][3]._id_0AB6 = "3";
  anim._id_0ABB["taskforce"] = [];
  anim._id_0ABB["taskforce"][0] = spawnStruct();
  anim._id_0ABB["taskforce"][0].count = 0;
  anim._id_0ABB["taskforce"][0]._id_0AB6 = "0";
  anim._id_0ABB["secretservice"] = [];
  anim._id_0ABB["secretservice"][0] = spawnStruct();
  anim._id_0ABB["secretservice"][0].count = 0;
  anim._id_0ABB["secretservice"][0]._id_0AB6 = "0";
  anim._id_0ABB["secretservice"][1] = spawnStruct();
  anim._id_0ABB["secretservice"][1].count = 0;
  anim._id_0ABB["secretservice"][1]._id_0AB6 = "1";
  anim._id_0ABB["secretservice"][2] = spawnStruct();
  anim._id_0ABB["secretservice"][2].count = 0;
  anim._id_0ABB["secretservice"][2]._id_0AB6 = "2";
  anim._id_0ABB["secretservice"][3] = spawnStruct();
  anim._id_0ABB["secretservice"][3].count = 0;
  anim._id_0ABB["secretservice"][3]._id_0AB6 = "3";
  anim._id_0ABB["arab"] = [];
  anim._id_0ABB["arab"][0] = spawnStruct();
  anim._id_0ABB["arab"][0].count = 0;
  anim._id_0ABB["arab"][0]._id_0AB6 = "0";
  anim._id_0ABB["arab"][1] = spawnStruct();
  anim._id_0ABB["arab"][1].count = 0;
  anim._id_0ABB["arab"][1]._id_0AB6 = "1";
  anim._id_0ABB["arab"][2] = spawnStruct();
  anim._id_0ABB["arab"][2].count = 0;
  anim._id_0ABB["arab"][2]._id_0AB6 = "2";
  anim._id_0ABB["delta"] = [];
  anim._id_0ABB["delta"][0] = spawnStruct();
  anim._id_0ABB["delta"][0].count = 0;
  anim._id_0ABB["delta"][0]._id_0AB6 = "0";
  anim._id_0ABB["delta"][1] = spawnStruct();
  anim._id_0ABB["delta"][1].count = 0;
  anim._id_0ABB["delta"][1]._id_0AB6 = "1";
  anim._id_0ABB["delta"][2] = spawnStruct();
  anim._id_0ABB["delta"][2].count = 0;
  anim._id_0ABB["delta"][2]._id_0AB6 = "2";
  anim._id_0ABB["french"] = [];
  anim._id_0ABB["french"][0] = spawnStruct();
  anim._id_0ABB["french"][0].count = 0;
  anim._id_0ABB["french"][0]._id_0AB6 = "0";
  anim._id_0ABB["african"] = [];
  anim._id_0ABB["african"][0] = spawnStruct();
  anim._id_0ABB["african"][0].count = 0;
  anim._id_0ABB["african"][0]._id_0AB6 = "0";
  anim._id_0ABB["african"][1] = spawnStruct();
  anim._id_0ABB["african"][1].count = 0;
  anim._id_0ABB["african"][1]._id_0AB6 = "1";
  anim._id_0ABB["african"][2] = spawnStruct();
  anim._id_0ABB["african"][2].count = 0;
  anim._id_0ABB["african"][2]._id_0AB6 = "2";
  anim._id_0ABB["czech"] = [];
  anim._id_0ABB["czech"][0] = spawnStruct();
  anim._id_0ABB["czech"][0].count = 0;
  anim._id_0ABB["czech"][0]._id_0AB6 = "0";
  anim._id_0ABB["czech"][1] = spawnStruct();
  anim._id_0ABB["czech"][1].count = 0;
  anim._id_0ABB["czech"][1]._id_0AB6 = "1";
  anim._id_0ABB["czech"][2] = spawnStruct();
  anim._id_0ABB["czech"][2].count = 0;
  anim._id_0ABB["czech"][2]._id_0AB6 = "2";
  anim._id_0ABB["pmc"] = [];
  anim._id_0ABB["pmc"][0] = spawnStruct();
  anim._id_0ABB["pmc"][0].count = 0;
  anim._id_0ABB["pmc"][0]._id_0AB6 = "0";
  anim._id_0ABB["pmc"][1] = spawnStruct();
  anim._id_0ABB["pmc"][1].count = 0;
  anim._id_0ABB["pmc"][1]._id_0AB6 = "1";
  anim._id_0ABB["pmc"][2] = spawnStruct();
  anim._id_0ABB["pmc"][2].count = 0;
  anim._id_0ABB["pmc"][2]._id_0AB6 = "2";
  _id_0B90();

  if(!isDefined(level._id_0AD3)) {
    level._id_0AD3 = 0;

  }
  anim._id_0B6D = [];
  anim._id_0B6D["threat"] = [];
  anim._id_0B6D["response"] = [];
  anim._id_0B6D["reaction"] = [];
  anim._id_0B6D["order"] = [];
  anim._id_0B6D["inform"] = [];
  anim._id_0B6D["custom"] = [];
  anim._id_0B6D["direction"] = [];

  if(isDefined(level._id_0B6E)) {
    anim._id_0B6F["threat"]["self"] = 20000;
    anim._id_0B6F["threat"]["squad"] = 30000;
  } else {
    anim._id_0B6F["threat"]["self"] = 12500;
    anim._id_0B6F["threat"]["squad"] = 7500;
  }

  anim._id_0B6F["threat"]["location_repeat"] = 5000;
  anim._id_0B6F["response"]["self"] = 1000;
  anim._id_0B6F["response"]["squad"] = 1000;
  anim._id_0B6F["reaction"]["self"] = 1000;
  anim._id_0B6F["reaction"]["squad"] = 1000;
  anim._id_0B6F["order"]["self"] = 8000;
  anim._id_0B6F["order"]["squad"] = 10000;
  anim._id_0B6F["inform"]["self"] = 6000;
  anim._id_0B6F["inform"]["squad"] = 8000;
  anim._id_0B6F["custom"]["self"] = 0;
  anim._id_0B6F["custom"]["squad"] = 0;
  anim._id_0B6D["playername"] = 50000;
  anim._id_0B6D["reaction"]["casualty"] = 14000;
  anim._id_0B6D["reaction"]["friendlyfire"] = 5000;
  anim._id_0B6D["reaction"]["taunt"] = 30000;
  anim._id_0B6D["inform"]["reloading"] = 20000;
  anim._id_0B6D["inform"]["killfirm"] = 15000;
  anim._id_0B70["threat"]["infantry"] = 0.5;
  anim._id_0B70["threat"]["vehicle"] = 0.7;
  anim._id_0B70["response"]["ack"] = 0.9;
  anim._id_0B70["response"]["exposed"] = 0.8;
  anim._id_0B70["response"]["callout"] = 0.9;
  anim._id_0B70["response"]["echo"] = 0.9;
  anim._id_0B70["reaction"]["casualty"] = 0.5;
  anim._id_0B70["reaction"]["friendlyfire"] = 1.0;
  anim._id_0B70["reaction"]["taunt"] = 0.9;
  anim._id_0B70["order"]["action"] = 0.3;
  anim._id_0B70["order"]["move"] = 0.3;
  anim._id_0B70["order"]["displace"] = 0.5;
  anim._id_0B70["inform"]["attack"] = 0.9;
  anim._id_0B70["inform"]["incoming"] = 0.9;
  anim._id_0B70["inform"]["reloading"] = 0.2;
  anim._id_0B70["inform"]["suppressed"] = 0.2;
  anim._id_0B70["inform"]["killfirm"] = 0.7;
  anim._id_0B70["custom"]["generic"] = 1.0;
  anim._id_0B71["threat"]["infantry"] = 1000;
  anim._id_0B71["threat"]["vehicle"] = 1000;
  anim._id_0B71["response"]["exposed"] = 2000;
  anim._id_0B71["response"]["callout"] = 2000;
  anim._id_0B71["response"]["echo"] = 2000;
  anim._id_0B71["response"]["ack"] = 1750;
  anim._id_0B71["reaction"]["casualty"] = 2000;
  anim._id_0B71["reaction"]["friendlyfire"] = 1000;
  anim._id_0B71["reaction"]["taunt"] = 2000;
  anim._id_0B71["order"]["action"] = 3000;
  anim._id_0B71["order"]["move"] = 3000;
  anim._id_0B71["order"]["displace"] = 3000;
  anim._id_0B71["inform"]["attack"] = 1000;
  anim._id_0B71["inform"]["incoming"] = 1500;
  anim._id_0B71["inform"]["reloading"] = 1000;
  anim._id_0B71["inform"]["suppressed"] = 2000;
  anim._id_0B71["inform"]["killfirm"] = 2000;
  anim._id_0B71["custom"]["generic"] = 1000;
  anim._id_0B2D["response"]["exposed"] = 75;
  anim._id_0B2D["response"]["reload"] = 65;
  anim._id_0B2D["response"]["callout"] = 75;
  anim._id_0B2D["response"]["callout_negative"] = 20;
  anim._id_0B2D["response"]["order"] = 40;
  anim._id_0B2D["moveEvent"]["coverme"] = 70;
  anim._id_0B2D["moveEvent"]["ordertoplayer"] = 10;
  anim._id_0B72 = 620;
  anim._id_0B73 = 12;
  anim._id_0B74 = 24;
  anim._id_0B75 = 2;
  anim._id_0B76 = 5;
  anim._id_0B77 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(level._id_0B78)) {
    level._id_0B78 = 1500;

  }
  if(!isDefined(level._id_0B1D)) {
    level._id_0B1D = 2500;

  }
  level._id_0B79 = 96.0;
  level._id_0B7A = 8.0;
  level._id_0B7B = 45.0;
  maps\_bcs_location_trigs::_id_0B4F();
  anim._id_0B7C = [];
  anim._id_0B7D = 4000;
  anim._id_0B7E = 3000;
  anim._id_0A60[anim._id_0A60.size] = ::_id_0AAC;
  anim._id_0A61[anim._id_0A61.size] = "::init_squadBattleChatter";

  foreach(var_1 in anim._id_0B7F) {
    anim.isteamspeaking[var_1] = 0;
    anim._id_0B81[var_1]["threat"] = 0;
    anim._id_0B81[var_1]["order"] = 0;
    anim._id_0B81[var_1]["reaction"] = 0;
    anim._id_0B81[var_1]["response"] = 0;
    anim._id_0B81[var_1]["inform"] = 0;
    anim._id_0B81[var_1]["custom"] = 0;
  }

  _id_0B8D();

  if(!isDefined(anim._id_0B82)) {
    anim._id_0B82 = [];
    anim._id_0B82["american"] = 1;
    anim._id_0B82["delta"] = 0;
    anim._id_0B82["french"] = 0;
    anim._id_0B82["czech"] = 0;
    anim._id_0B82["pmc"] = 0;
    anim._id_0B82["african"] = 0;
    anim._id_0B82["shadowcompany"] = 1;
    anim._id_0B82["seal"] = 0;
    anim._id_0B82["taskforce"] = 0;
    anim._id_0B82["secretservice"] = 0;
    anim._id_0B82["british"] = 0;
  }

  _id_0B8F();
  anim._id_0B83 = [];
  anim._id_0B84 = [];
  anim._id_0B85 = [];

  foreach(var_1 in anim._id_0B7F) {
    anim._id_0B83[var_1] = -50000;
    anim._id_0B84[var_1] = "none";
    anim._id_0B85[var_1] = -100000;
  }

  anim._id_0B86 = 120000;

  for(var_5 = 0; var_5 < anim._id_0A63.size; var_5++) {
    if(isDefined(anim._id_0A63[var_5]._id_0AAB) && anim._id_0A63[var_5]._id_0AAB) {
      continue;
    }
    anim._id_0A63[var_5] _id_0AAC();
  }

  anim._id_0B87 = [];
  anim._id_0B87["rpg"] = 100;
  anim._id_0B87["exposed"] = 25;
  anim._id_0B87["player_distance"] = 25;
  anim._id_0B87["player_obvious"] = 25;
  anim._id_0B87["player_contact_clock"] = 25;
  anim._id_0B87["player_target_clock"] = 25;
  anim._id_0B87["player_target_clock_high"] = 25;
  anim._id_0B87["player_cardinal"] = 20;
  anim._id_0B87["ai_distance"] = 25;
  anim._id_0B87["ai_obvious"] = 25;
  anim._id_0B87["ai_contact_clock"] = 20;
  anim._id_0B87["ai_target_clock"] = 20;
  anim._id_0B87["ai_target_clock_high"] = 75;
  anim._id_0B87["ai_cardinal"] = 10;
  anim._id_0B87["player_location"] = 95;
  anim._id_0B87["ai_location"] = 100;
  anim._id_0B87["generic_location"] = 90;
  anim._id_0B88 = [];
  anim._id_0B89 = [];

  foreach(var_1 in anim._id_0B7F) {
    anim._id_0B88[var_1] = undefined;
    anim._id_0B89[var_1] = undefined;
  }

  anim._id_0B8A = 120000;
  level notify("battlechatter initialized");
  anim notify("battlechatter initialized");
}

_id_0B8B() {
  if(!isDefined(anim._id_0B7F)) {
    anim._id_0B7F = [];
    anim._id_0B7F[anim._id_0B7F.size] = "axis";
    anim._id_0B7F[anim._id_0B7F.size] = "allies";
    anim._id_0B7F[anim._id_0B7F.size] = "team3";
    anim._id_0B7F[anim._id_0B7F.size] = "neutral";
  }
}

_id_0B8C() {
  if(!isDefined(anim._id_0AB3)) {
    anim._id_0AB3["british"] = "UK";
    anim._id_0AB3["american"] = "US";
    anim._id_0AB3["seal"] = "NS";
    anim._id_0AB3["taskforce"] = "TF";
    anim._id_0AB3["secretservice"] = "SS";
    anim._id_0AB3["russian"] = "RU";
    anim._id_0AB3["arab"] = "AB";
    anim._id_0AB3["portuguese"] = "PG";
    anim._id_0AB3["shadowcompany"] = "SC";
    anim._id_0AB3["delta"] = "DF";
    anim._id_0AB3["french"] = "FR";
    anim._id_0AB3["african"] = "AF";
    anim._id_0AB3["czech"] = "CZ";
    anim._id_0AB3["pmc"] = "PC";
  }
}

_id_0B8D() {
  _id_0B8B();

  if(!isDefined(level._id_0AAF)) {
    level._id_0AAF = [];

    foreach(var_1 in anim._id_0B7F) {}
    maps\_utility::_id_0B8E(var_1, 1);
  }
}

_id_0B8F() {
  _id_0B8B();

  if(!isDefined(level._id_0AB0)) {
    level._id_0AB0 = [];

    foreach(var_1 in anim._id_0B7F) {}
    level._id_0AB0[var_1] = 1;
  }
}

_id_0B90() {
  anim._id_0AB0["american"] = [];
  var_0 = 41;
  var_1 = [];

  if(level.script == "roadkill" || level.script == "trainer") {
    var_1[var_1.size] = 13;
    var_1[var_1.size] = 15;
    var_1[var_1.size] = 16;
    var_1[var_1.size] = 19;
    var_1[var_1.size] = 20;
    var_1[var_1.size] = 30;
    var_1[var_1.size] = 31;
    var_1[var_1.size] = 33;
    var_1[var_1.size] = 38;
  }

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(var_1.size) {
      var_3 = 0;

      foreach(var_5 in var_1) {
        if(var_5 == var_2) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        continue;
      }
    }

    anim._id_0AB0["american"][var_2] = maps\_utility::string(var_2 + 1);
  }

  anim._id_0AB0["shadowcompany"] = [];
  var_0 = 9;

  for(var_2 = 1; var_2 <= var_0; var_2++) {
    anim._id_0AB0["shadowcompany"][var_2] = maps\_utility::string(var_2 + 1);

  }
  anim._id_0B92 = [];
}

_id_0B93() {
  anim._id_0AB3 = undefined;
  anim._id_0B6D = undefined;
  anim._id_0B6F = undefined;
  anim._id_0B6D = undefined;
  anim._id_0B70 = undefined;
  anim._id_0B71 = undefined;
  anim._id_0B77 = undefined;
  anim._id_0B7D = undefined;
  anim._id_0B7E = undefined;
  anim._id_0B7C = undefined;
  anim._id_0ABB = undefined;
  anim._id_0B92 = undefined;
  anim._id_0B88 = undefined;
  anim._id_0B89 = undefined;
  anim._id_0B86 = undefined;
  anim._id_0B84 = undefined;
  anim._id_0B85 = undefined;
  anim._id_0AAB = 0;
  anim.player._id_0AAB = 0;
  level._id_0AAF = undefined;

  for(var_0 = 0; var_0 < anim._id_0A60.size; var_0++) {
    if(anim._id_0A61[var_0] != "::init_squadBattleChatter") {
      continue;
    }
    if(var_0 != anim._id_0A60.size - 1) {
      anim._id_0A60[var_0] = anim._id_0A60[anim._id_0A60.size - 1];
      anim._id_0A61[var_0] = anim._id_0A61[anim._id_0A61.size - 1];
    }

    anim._id_0A60[anim._id_0A60.size - 1] = undefined;
    anim._id_0A61[anim._id_0A61.size - 1] = undefined;
  }

  level notify("battlechatter disabled");
  anim notify("battlechatter disabled");
}

_id_0AAC() {
  var_0 = self;
  var_0._id_0B94 = 0;
  var_0._id_0B95 = 1;
  var_0._id_0AC7 = gettime() + 50;
  var_0._id_0AC8["threat"] = gettime() + 50;
  var_0._id_0AC8["order"] = gettime() + 50;
  var_0._id_0AC8["reaction"] = gettime() + 50;
  var_0._id_0AC8["response"] = gettime() + 50;
  var_0._id_0AC8["inform"] = gettime() + 50;
  var_0._id_0AC8["custom"] = gettime() + 50;
  var_0._id_0B96["threat"] = [];
  var_0._id_0B96["order"] = [];
  var_0._id_0B96["reaction"] = [];
  var_0._id_0B96["response"] = [];
  var_0._id_0B96["inform"] = [];
  var_0._id_0B96["custom"] = [];
  var_0._id_0B97["threat"] = 0;
  var_0._id_0B97["order"] = 0;
  var_0._id_0B97["reaction"] = 0;
  var_0._id_0B97["response"] = 0;
  var_0._id_0B97["inform"] = 0;
  var_0._id_0B97["custom"] = 0;
  var_0._id_0B98 = "";
  var_0._id_0A6F[var_0._id_0A6F.size] = animscripts\battlechatter_ai::_id_0AA9;
  var_0._id_0A70[var_0._id_0A70.size] = "::addToSystem";
  var_0._id_0A71[var_0._id_0A71.size] = animscripts\battlechatter_ai::_id_0AC5;
  var_0._id_0A72[var_0._id_0A72.size] = "::removeFromSystem";
  var_0._id_0A73[var_0._id_0A73.size] = ::_id_0C1E;
  var_0._id_0A74[var_0._id_0A74.size] = "::initContact";
  var_0._id_0B99 = 1;
  var_0._id_0B9A = undefined;

  for(var_1 = 0; var_1 < anim._id_0A63.size; var_1++) {
    var_0 thread _id_0C1E(anim._id_0A63[var_1]._id_0A66);

  }
  var_0 thread animscripts\battlechatter_ai::_id_0B1F();
  var_0 thread animscripts\battlechatter_ai::_id_0AE8();
  var_0 thread _id_0C22();
  var_0._id_0AAB = 1;
  var_0 notify("squad chat initialized");
}

_id_0B9B() {
  var_0 = self;
  var_0._id_0B94 = undefined;
  var_0._id_0B95 = undefined;
  var_0._id_0AC7 = undefined;
  var_0._id_0AC8 = undefined;
  var_0._id_0B96 = undefined;
  var_0._id_0B97 = undefined;
  var_0._id_0B99 = undefined;
  var_0._id_0B9A = undefined;

  for(var_1 = 0; var_1 < var_0._id_0A6F.size; var_1++) {
    if(var_0._id_0A70[var_1] != "::addToSystem") {
      continue;
    }
    if(var_1 != var_0._id_0A6F.size - 1) {
      var_0._id_0A6F[var_1] = var_0._id_0A6F[var_0._id_0A6F.size - 1];
      var_0._id_0A70[var_1] = var_0._id_0A70[var_0._id_0A70.size - 1];
    }

    var_0._id_0A6F[var_0._id_0A6F.size - 1] = undefined;
    var_0._id_0A70[var_0._id_0A70.size - 1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0._id_0A71.size; var_1++) {
    if(var_0._id_0A72[var_1] != "::removeFromSystem") {
      continue;
    }
    if(var_1 != var_0._id_0A71.size - 1) {
      var_0._id_0A71[var_1] = var_0._id_0A71[var_0._id_0A71.size - 1];
      var_0._id_0A72[var_1] = var_0._id_0A72[var_0._id_0A72.size - 1];
    }

    var_0._id_0A71[var_0._id_0A71.size - 1] = undefined;
    var_0._id_0A72[var_0._id_0A72.size - 1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0._id_0A73.size; var_1++) {
    if(var_0._id_0A74[var_1] != "::initContact") {
      continue;
    }
    if(var_1 != var_0._id_0A73.size - 1) {
      var_0._id_0A73[var_1] = var_0._id_0A73[var_0._id_0A73.size - 1];
      var_0._id_0A74[var_1] = var_0._id_0A74[var_0._id_0A74.size - 1];
    }

    var_0._id_0A73[var_0._id_0A73.size - 1] = undefined;
    var_0._id_0A74[var_0._id_0A74.size - 1] = undefined;
  }

  for(var_1 = 0; var_1 < anim._id_0A63.size; var_1++) {
    var_0 _id_0C1F(anim._id_0A63[var_1]._id_0A66);

  }
  var_0._id_0AAB = 0;
}

_id_0AAA() {
  return anim._id_0AAB;
}

_id_0B9C() {
  var_0 = getdvar("bcs_enable", "on");

  for(;;) {
    var_1 = getdvar("bcs_enable", "on");

    if(var_1 != var_0) {
      switch (var_1) {
        case "on":
          if(!anim._id_0AAB) {
            _id_0B9D();

          }
          break;
        case "off":
          if(anim._id_0AAB) {
            _id_0B9E();

          }
          break;
      }

      var_0 = var_1;
    }

    wait 1.0;
  }
}

_id_0B9D() {
  _id_0B6B();
  anim.player thread animscripts\battlechatter_ai::_id_0AA9();
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] animscripts\battlechatter_ai::_id_0AA9();
  }
}

_id_0B9E() {
  _id_0B93();
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]._id_0A7A) && var_0[var_1]._id_0A7A._id_0AAB) {
      var_0[var_1]._id_0A7A _id_0B9B();

    }
    var_0[var_1] animscripts\battlechatter_ai::_id_0AC5();
  }
}

_id_0B9F(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    level.player._id_0BA0 = var_0;
    level.player._id_0BA1 = var_1;
    return;
  }

  while(!isDefined(level._id_0BA2)) {
    wait 0.1;

  }
  var_2 = level._id_0BA2;
  var_3 = anim._id_0AD0[var_2];
  var_4 = anim._id_0AB3[var_2];

  if(isDefined(var_3)) {
    level.player._id_0BA0 = var_3;

  }
  if(isDefined(var_4)) {
    level.player._id_0BA1 = var_4;
  }
}

_id_0ABF() {
  if(!isalive(self)) {
    return;
  }
  if(!_id_0AAA()) {
    return;
  }
  if(self._id_0BA3 > 0) {
    return;
  }
  if(isDefined(self._id_0AC9) && self._id_0AC9) {
    return;
  }
  if(self.team == "allies" && isDefined(anim._id_0BA4)) {
    if(anim._id_0BA4 + anim._id_0B7D > gettime()) {
      return;
    }
  }

  if(_id_0C37()) {
    return;
  }
  if(!isDefined(self._id_0AAF) || !self._id_0AAF) {
    return;
  }
  if(self.team == "allies" && getdvarint("bcs_forceEnglish", 0)) {
    return;
  }
  if(anim.isteamspeaking[self.team]) {
    return;
  }
  self endon("death");
  var_0 = _id_0BE2();

  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "custom":
      thread _id_0BD7();
      break;
    case "response":
      thread _id_0BC9();
      break;
    case "order":
      thread _id_0BCD();
      break;
    case "threat":
      thread _id_0BA5();
      break;
    case "reaction":
      thread _id_0BC5();
      break;
    case "inform":
      thread _id_0BD1();
      break;
  }
}

_id_0BA5() {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self._id_0BA6 = self._id_0AC6["threat"];
  var_0 = self._id_0AC6["threat"]._id_0AD9;

  if(!isalive(var_0)) {
    return;
  }
  if(_id_0AD7(var_0) && !isplayer(var_0)) {
    return;
  }
  anim thread _id_0BDF(self, "threat");
  var_1 = 0;

  switch (self._id_0AC6["threat"]._id_0BA7) {
    case "infantry":
      if(isplayer(var_0) || !isDefined(var_0 getturret())) {
        var_1 = _id_0BAA(var_0);
      } else {}

      break;
    case "dog":
      var_1 = _id_0BC1(var_0);
      break;
    case "vehicle":
      break;
  }

  self notify("done speaking");

  if(!var_1) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0._id_0AAE[self._id_0A7A._id_0A66] = spawnStruct();
  var_0._id_0AAE[self._id_0A7A._id_0A66]._id_0BA8 = self;
  var_0._id_0AAE[self._id_0A7A._id_0A66]._id_0BA9 = self._id_0AC6["threat"]._id_0BA7;
  var_0._id_0AAE[self._id_0A7A._id_0A66]._id_0ACB = gettime() + anim._id_0B7E;

  if(isDefined(var_0._id_0A7A)) {
    self._id_0A7A._id_0A6E[var_0._id_0A7A._id_0A66]._id_0AAE = 1;
  }
}

_id_0AD7(var_0) {
  if(isDefined(var_0._id_0AAE) && isDefined(var_0._id_0AAE[self._id_0A7A._id_0A66])) {
    if(var_0._id_0AAE[self._id_0A7A._id_0A66]._id_0ACB < gettime()) {
      return 1;
    }
  }

  return 0;
}

_id_0BAA(var_0, var_1) {
  self endon("cancel speaking");
  var_2 = _id_0B45();
  var_2._id_0BAB = 1;
  var_2._id_0BAC = var_0;
  var_3 = _id_0BB4(var_0);

  if(!isDefined(var_3) || isDefined(var_3) && !isDefined(var_3.type)) {
    return 0;

  }
  switch (var_3.type) {
    case "rpg":
      var_2 _id_0BC4(var_0);
      break;
    case "exposed":
      var_4 = _id_0BB1(var_3._id_0BAD);

      if(var_4 && _id_0C08(var_3._id_0BAD)) {
        var_2 _id_0B4D(var_3._id_0BAD._id_0AC2);
        var_2._id_0BAE = var_3._id_0BAD;
      }

      var_2 _id_0BC2(var_0);

      if(var_4) {
        if(randomint(100) < anim._id_0B2D["response"]["callout_negative"]) {
          var_3._id_0BAD animscripts\battlechatter_ai::_id_0ADB("callout", "neg", self, 0.9);
        } else {
          var_3._id_0BAD animscripts\battlechatter_ai::_id_0ADB("exposed", "acquired", self, 0.9);
        }
      }

      break;
    case "player_obvious":
      var_2 _id_0C05();
      var_2 _id_0C0E();
      break;
    case "player_distance":
      var_5 = _id_0BFF(level.player.origin, var_0.origin);
      var_2 _id_0C05();
      var_2 _id_0C0F(var_5);
      break;
    case "player_contact_clock":
      var_2 _id_0C05();
      var_2 _id_0C15("contactclock", var_3._id_0BAF);
      break;
    case "player_target_clock":
      var_2 _id_0C05();
      var_2 _id_0C15("targetclock", var_3._id_0BAF);
      break;
    case "player_target_clock_high":
      var_2 _id_0C05();
      var_6 = _id_0C02(level.player.origin, var_0.origin);

      if(var_6 >= 20 && var_6 <= 50) {
        var_2 _id_0C15("targetclock", var_3._id_0BAF);
        var_2 _id_0C10(var_6);
      } else {
        var_2 _id_0C15("targetclock", var_3._id_0BAF + "_high");

      }
      break;
    case "player_cardinal":
      var_2 _id_0C05();
      var_7 = _id_0BFD(level.player.origin, var_0.origin);
      var_8 = _id_0BFC(var_7);

      if(var_8 == "impossible") {
        return 0;

      }
      var_2 _id_0C15("cardinal", var_8);
      break;
    case "ai_obvious":
      if(isDefined(var_3._id_0BAD) && _id_0C08(var_3._id_0BAD)) {
        var_2 _id_0B4D(var_3._id_0BAD._id_0AC2);
        var_2._id_0BAE = var_3._id_0BAD;
      }

      var_2 _id_0C0E();
      var_2 _id_0BB3(self, var_3, var_0);
      break;
    case "ai_distance":
      var_9 = self;

      if(self.team == "allies") {
        var_9 = level.player;
      } else if(isDefined(var_3._id_0BAD) && randomint(100) < anim._id_0B2D["response"]["callout"]) {
        var_9 = var_3._id_0BAD;

      }
      var_5 = _id_0BFF(var_9.origin, var_0.origin);
      var_2 _id_0C0F(var_5);
      var_2 _id_0BB3(self, var_3, var_0);
      break;
    case "ai_contact_clock":
      var_9 = self;

      if(self.team == "allies") {
        var_9 = level.player;
      } else if(isDefined(var_3._id_0BAD) && randomint(100) < anim._id_0B2D["response"]["callout"]) {
        var_9 = var_3._id_0BAD;

      }
      var_10 = _id_0BF9(var_9);
      var_11 = _id_0C01(var_10, var_9.origin, var_0.origin);
      var_2 _id_0C15("contactclock", var_11);
      var_2 _id_0BB3(self, var_3, var_0);
      break;
    case "ai_target_clock":
      var_9 = self;

      if(self.team == "allies") {
        var_9 = level.player;
      } else if(isDefined(var_3._id_0BAD) && randomint(100) < anim._id_0B2D["response"]["callout"]) {
        var_9 = var_3._id_0BAD;

      }
      var_10 = _id_0BF9(var_9);
      var_11 = _id_0C01(var_10, var_9.origin, var_0.origin);
      var_2 _id_0C15("targetclock", var_11);
      var_2 _id_0BB3(self, var_3, var_0);
      break;
    case "ai_target_clock_high":
      var_9 = self;

      if(self.team == "allies") {
        var_9 = level.player;
      } else if(isDefined(var_3._id_0BAD) && randomint(100) < anim._id_0B2D["response"]["callout"]) {
        var_9 = var_3._id_0BAD;

      }
      var_10 = _id_0BF9(var_9);
      var_11 = _id_0C01(var_10, var_9.origin, var_0.origin);
      var_6 = _id_0C02(var_9.origin, var_0.origin);

      if(var_6 >= 20 && var_6 <= 50) {
        var_2 _id_0C15("targetclock", var_11);
        var_2 _id_0C10(var_6);
      } else {
        var_2 _id_0C15("targetclock", var_11 + "_high");

      }
      var_2 _id_0BB3(self, var_3, var_0);
      break;
    case "ai_cardinal":
      var_9 = self;

      if(self.team == "allies") {
        var_9 = level.player;

      }
      var_7 = _id_0BFD(var_9.origin, var_0.origin);
      var_8 = _id_0BFC(var_7);

      if(var_8 == "impossible") {
        return 0;

      }
      var_2 _id_0C15("cardinal", var_8);
      break;
    case "generic_location":
      var_12 = var_2 _id_0BB2(var_3);

      if(!var_12) {
        return 0;

      }
      break;
    case "player_location":
      var_2 _id_0C05();
      var_12 = var_2 _id_0BB2(var_3);

      if(!var_12) {
        return 0;

      }
      break;
    case "ai_location":
      if(_id_0C08(var_3._id_0BAD)) {
        var_2 _id_0B4D(var_3._id_0BAD._id_0AC2);
        var_2._id_0BAE = var_3._id_0BAD;
      }

      var_12 = var_2 _id_0BB2(var_3);

      if(!var_12) {
        return 0;

      }
      var_13 = var_2._id_0BB0.size - 1;
      var_14 = var_2._id_0BB0[var_13];

      if(_id_0BBA(var_14)) {
        var_3._id_0BAD animscripts\battlechatter_ai::_id_0ADB("callout", "echo", self, 0.9, var_14);
      } else if(_id_0BBB(var_14, self)) {
        var_3._id_0BAD animscripts\battlechatter_ai::_id_0ADB("callout", "QA", self, 0.9, var_14, var_3.location);
      } else if(randomint(100) < anim._id_0B2D["response"]["callout_negative"]) {
        var_3._id_0BAD animscripts\battlechatter_ai::_id_0ADB("callout", "neg", self, 0.9);
      } else {
        var_3._id_0BAD animscripts\battlechatter_ai::_id_0ADB("exposed", "acquired", self, 0.9);

      }
      break;
  }

  _id_0BBF(var_3.type);
  _id_0BD9(var_2);
  return 1;
}

_id_0BB1(var_0) {
  if(!isDefined(var_0)) {
    return 0;

  }
  if(var_0._id_0AB4 != "US" && var_0._id_0AB4 != "NS" && var_0._id_0AB4 != "TF") {
    return 0;

  }
  if(randomint(100) > anim._id_0B2D["response"]["exposed"]) {
    return 0;

  }
  return 1;
}

_id_0BB2(var_0) {
  var_1 = _id_0C18(var_0.location);
  return var_1;
}

_id_0BB3(var_0, var_1, var_2) {
  if(!isDefined(var_1._id_0BAD)) {
    return;
  }
  if(randomint(100) > anim._id_0B2D["response"]["callout"]) {
    return;
  }
  var_3 = "affirm";

  if(!var_1._id_0BAD cansee(var_2) && randomint(100) < anim._id_0B2D["response"]["callout_negative"]) {
    var_3 = "neg";

  }
  var_1._id_0BAD animscripts\battlechatter_ai::_id_0ADB("callout", var_3, var_0, 0.9);
}

_id_0BB4(var_0) {
  var_1 = var_0 _id_0AED();
  var_2 = _id_0C01(self.angles, self.origin, var_0.origin);
  var_3 = _id_0B2C(64, 1024, "response");
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_4 = _id_0C01(var_3.angles, var_3.origin, var_0.origin);

  }
  var_5 = _id_0C01(level.player.angles, level.player.origin, var_0.origin);

  if(self.team == "allies") {
    var_6 = var_5;
    var_7 = level.player;
  } else if(isDefined(var_3)) {
    var_6 = var_4;
    var_7 = var_3;
  } else {
    var_6 = var_2;
    var_7 = self;
  }

  var_8 = _id_0BFE(var_7.origin, var_0.origin);
  self._id_0BB5 = [];

  if(!isplayer(var_0) && var_0 animscripts\utility::_id_0BB6()) {
    _id_0BBD("rpg");

  }
  if(var_0 _id_0AA8()) {
    _id_0BBD("exposed");

  }
  if(self.team == "allies") {
    var_9 = 0;

    if(var_0.origin[2] - var_7.origin[2] >= level._id_0B79) {
      if(_id_0BBD("player_target_clock_high")) {
        var_9 = 1;
      }
    }

    if(!var_9) {
      if(var_6 == "12") {
        _id_0BBD("player_obvious");

        if(var_8 > level._id_0B7A && var_8 < level._id_0B7B) {
          _id_0BBD("player_distance");
        }
      }

      if(_id_0C0A() && var_6 != "12") {
        _id_0BBD("player_contact_clock");
        _id_0BBD("player_target_clock");
        _id_0BBD("player_cardinal");
      }
    }
  }

  var_9 = 0;

  if(var_0.origin[2] - var_7.origin[2] >= level._id_0B79) {
    if(_id_0BBD("ai_target_clock_high")) {
      var_9 = 1;
    }
  }

  if(!var_9) {
    if(var_6 == "12") {
      _id_0BBD("ai_distance");

      if(var_8 > level._id_0B7A && var_8 < level._id_0B7B) {
        _id_0BBD("ai_obvious");
      }
    }

    _id_0BBD("ai_contact_clock");
    _id_0BBD("ai_target_clock");
    _id_0BBD("ai_cardinal");
  }

  if(isDefined(var_1)) {
    var_10 = var_1 _id_0BB8(self);

    if(isDefined(var_10)) {
      if(isDefined(var_3)) {
        _id_0BBD("ai_location");
      } else {
        if(_id_0C0A()) {
          _id_0BBD("player_location");

        }
        _id_0BBD("generic_location");
      }
    } else {
      if(isDefined(var_3)) {
        _id_0BBD("ai_location");

      }
      if(_id_0C0A()) {
        _id_0BBD("player_location");

      }
      _id_0BBD("generic_location");
    }
  }

  if(!self._id_0BB5.size) {
    return undefined;

  }
  var_12 = _id_0BC0(self._id_0BB5, anim._id_0B87);
  var_13 = spawnStruct();
  var_13.type = var_12;
  var_13._id_0BAD = var_3;
  var_13._id_0BB7 = var_4;
  var_13._id_0BAF = var_5;

  if(isDefined(var_1)) {
    var_13.location = var_1;

  }
  return var_13;
}

_id_0BB8(var_0) {
  var_1 = undefined;
  var_2 = self._id_0B54;

  foreach(var_4 in var_2) {
    if(_id_0BBB(var_4, var_0) && !isDefined(self._id_0BB9)) {
      var_1 = var_4;
      break;
    }

    if(_id_0BBA(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_0BBA(var_0) {
  return issubstr(var_0, "_report");
}

_id_0BBB(var_0, var_1) {
  if(issubstr(var_0, "_qa") && soundexists(var_0)) {
    return 1;

  }
  var_2 = var_1 _id_0BBC(var_0, 0);

  if(soundexists(var_2)) {
    return 1;

  }
  return 0;
}

_id_0BBC(var_0, var_1) {
  var_2 = self._id_0AB4 + "_" + self._id_0AB6 + "_co_";
  var_2 = var_2 + var_0;
  var_2 = var_2 + ("_qa" + var_1);
  return var_2;
}

_id_0ACF(var_0) {
  self._id_0ACE[self._id_0ACE.size] = var_0;
}

_id_0BBD(var_0) {
  var_1 = 0;

  foreach(var_3 in self._id_0ACE) {
    if(var_3 == var_0) {
      if(!_id_0BBE(var_0)) {
        var_1 = 1;

      }
      break;
    }
  }

  if(!var_1) {
    return var_1;

  }
  self._id_0BB5[self._id_0BB5.size] = var_0;
  return var_1;
}

_id_0BBE(var_0) {
  if(!isDefined(anim._id_0B88[self.team])) {
    return 0;

  }
  if(!isDefined(anim._id_0B89[self.team])) {
    return 0;

  }
  var_1 = anim._id_0B88[self.team];
  var_2 = anim._id_0B89[self.team];
  var_3 = anim._id_0B8A;

  if(var_0 == var_1 && gettime() - var_2 < var_3) {
    return 1;

  }
  return 0;
}

_id_0BBF(var_0) {
  anim._id_0B88[self.team] = var_0;
  anim._id_0B89[self.team] = gettime();
}

_id_0BC0(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(var_1[var_5] <= 0) {
      continue;
    }
    var_6 = randomint(var_1[var_5]);

    if(isDefined(var_2) && var_1[var_2] >= 100) {
      if(var_1[var_5] < 100) {
        continue;
      }
    } else {
      if(var_1[var_5] >= 100) {
        var_2 = var_5;
        var_3 = var_6;
        continue;
      }

      if(var_6 > var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

_id_0BC1(var_0, var_1) {
  self endon("cancel speaking");
  var_2 = _id_0B45();
  var_2._id_0BAB = 1;
  var_2._id_0BAC = var_0;
  var_2 _id_0C0C("dog", "generic");
  _id_0BD9(var_2);
  return 1;
}

_id_0BC2(var_0) {
  var_1 = [];
  var_1 = maps\_utility::_id_0BC3(var_1, "open");
  var_1 = maps\_utility::_id_0BC3(var_1, "breaking");

  if(self.owner.team == "allies" && self.owner._id_0AB4 != "RU") {
    var_1 = maps\_utility::_id_0BC3(var_1, "movement");

  }
  var_2 = var_1[randomint(var_1.size)];
  _id_0C0D(var_2);
}

_id_0BC4(var_0) {
  _id_0C0C("rpg");
}

_id_0BC5() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_0BA6 = self._id_0AC6["reaction"];
  var_0 = self._id_0AC6["reaction"]._id_0AE5;
  var_1 = self._id_0AC6["reaction"]._id_0AE0;
  anim thread _id_0BDF(self, "reaction");

  switch (self._id_0AC6["reaction"]._id_0BA7) {
    case "casualty":
      _id_0BC6(var_0, var_1);
      break;
    case "taunt":
      _id_0BC7(var_0, var_1);
      break;
    case "friendlyfire":
      _id_0BC8(var_0, var_1);
      break;
  }

  self notify("done speaking");
}

_id_0BC6(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = _id_0B45();
  var_2 _id_0C1A("casualty", "generic");
  _id_0BD9(var_2);
}

_id_0BC7(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = _id_0B45();

  if(isDefined(var_1) && var_1 == "hostileburst") {
    var_2 _id_0C1D();
  } else {
    var_2 _id_0C1C("taunt", "generic");

  }
  _id_0BD9(var_2);
}

_id_0BC8(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = _id_0B45();
  var_2 _id_0C1B();
  _id_0BD9(var_2);
}

_id_0BC9() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_0BA6 = self._id_0AC6["response"];
  var_0 = self._id_0AC6["response"]._id_0AE0;
  var_1 = self._id_0AC6["response"]._id_0ADF;

  if(!isalive(var_1)) {
    return;
  }
  if(self._id_0AC6["response"]._id_0AE0 == "follow" && self.a._id_0A98 != "move") {
    return;
  }
  anim thread _id_0BDF(self, "response");

  switch (self._id_0AC6["response"]._id_0BA7) {
    case "exposed":
      _id_0BCA(var_1, var_0);
      break;
    case "callout":
      _id_0BCB(var_1, var_0);
      break;
    case "ack":
      _id_0BCC(var_1, var_0);
      break;
  }

  self notify("done speaking");
}

_id_0BCA(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_2 = _id_0B45();
  var_2 _id_0C0D(var_1);
  var_2._id_0BAE = var_0;
  var_2._id_0BAB = 1;
  _id_0BD9(var_2);
}

_id_0BCB(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_2 = _id_0B45();
  var_3 = 0;

  if(var_1 == "echo") {
    var_3 = var_2 _id_0C11(self._id_0BA6._id_0ADE, var_0);
  } else if(var_1 == "QA") {
    var_3 = var_2 _id_0C13(var_0, self._id_0BA6._id_0ADE, self._id_0BA6.location);
  } else {
    var_3 = var_2 _id_0C12(var_1);

  }
  if(!var_3) {
    return;
  }
  var_2._id_0BAE = var_0;
  var_2._id_0BAB = 1;
  _id_0BD9(var_2);
}

_id_0BCC(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_2 = self._id_0AC6["response"]._id_0BA7;
  var_3 = _id_0B45();
  var_3 _id_0C19(var_2, var_1);
  var_3._id_0BAE = var_0;
  var_3._id_0BAB = 1;
  _id_0BD9(var_3);
}

_id_0BCD() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_0BA6 = self._id_0AC6["order"];
  var_0 = self._id_0AC6["order"]._id_0AE0;
  var_1 = self._id_0AC6["order"]._id_0AE7;
  anim thread _id_0BDF(self, "order");

  switch (self._id_0AC6["order"]._id_0BA7) {
    case "action":
      _id_0BCE(var_0, var_1);
      break;
    case "move":
      _id_0BCF(var_0, var_1);
      break;
    case "displace":
      _id_0BD0(var_0);
      break;
  }

  self notify("done speaking");
}

_id_0BCE(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = _id_0B45();
  _id_0B43(var_2, var_1);
  var_2 _id_0B47("action", var_0);
  _id_0BD9(var_2);
}

_id_0BCF(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = _id_0B45();
  _id_0B43(var_2, var_1);
  var_2 _id_0B47("move", var_0);
  _id_0BD9(var_2);
}

_id_0BD0(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = _id_0B45();
  var_1 _id_0B47("displace", var_0);
  _id_0BD9(var_1, 1);
}

_id_0B43(var_0, var_1) {
  if(randomint(100) > anim._id_0B2D["response"]["order"]) {
    if(!isDefined(var_1) || isDefined(var_1) && !isplayer(var_1)) {
      return;
    }
  }

  if(isDefined(var_1) && isplayer(var_1) && isDefined(level.player._id_0BA0)) {
    var_0 _id_0C05();
    var_0._id_0BAE = level.player;
  } else if(isDefined(var_1) && _id_0C08(var_1)) {
    var_0 _id_0B4D(var_1._id_0AC2);
    var_0._id_0BAE = var_1;
    var_1 animscripts\battlechatter_ai::_id_0ADB("ack", "yes", self, 0.9);
  } else {
    level notify("follow order", self);
  }
}

_id_0BD1() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_0BA6 = self._id_0AC6["inform"];
  var_0 = self._id_0AC6["inform"]._id_0AE0;
  anim thread _id_0BDF(self, "inform");

  switch (self._id_0AC6["inform"]._id_0BA7) {
    case "incoming":
      _id_0BD4(var_0);
      break;
    case "attack":
      _id_0BD5(var_0);
      break;
    case "reloading":
      _id_0BD2(var_0);
      break;
    case "suppressed":
      _id_0BD3(var_0);
      break;
    case "killfirm":
      _id_0BD6(var_0);
      break;
  }

  self notify("done speaking");
}

_id_0BD2(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = _id_0B45();
  var_1 _id_0B4B("reloading", var_0);
  _id_0BD9(var_1);
}

_id_0BD3(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = _id_0B45();
  var_1 _id_0B4B("suppressed", var_0);
  _id_0BD9(var_1);
}

_id_0BD4(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = _id_0B45();

  if(var_0 == "grenade") {
    var_1._id_0BAB = 1;

  }
  var_1 _id_0B4B("incoming", var_0);
  _id_0BD9(var_1);
}

_id_0BD5(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = _id_0B45();
  var_1 _id_0B4B("attack", var_0);
  _id_0BD9(var_1);
}

_id_0BD6(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = _id_0B45();
  var_1 _id_0B4B("killfirm", var_0);
  _id_0BD9(var_1);
}

_id_0BD7() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_0BA6 = self._id_0AC6["custom"];
  anim thread _id_0BDF(self, self._id_0BA6.type, 1);
  _id_0BD9(self._id_0B42);
  self notify("done speaking");
  self._id_0BD8 = undefined;
  self._id_0B42 = undefined;
}

_id_0BD9(var_0, var_1) {
  anim endon("battlechatter disabled");
  self endon("death");

  if(isDefined(var_1)) {
    return;
  }
  if(_id_0C2C() || _id_0C2D()) {
    var_2 = [];

    foreach(var_4 in var_0._id_0BB0) {}
    var_2[var_2.size] = var_4;

    if(_id_0C2C()) {
      _id_0C2E(var_2);

    }
    if(_id_0C2D()) {
      var_6 = self._id_0BA6._id_0BDA + "_" + self._id_0BA6._id_0BA7;

      if(isDefined(self._id_0BA6._id_0AE0)) {
        var_6 = var_6 + ("_" + self._id_0BA6._id_0AE0);

      }
      thread _id_0C2F(var_2, var_6);
    }
  }

  for(var_7 = 0; var_7 < var_0._id_0BB0.size; var_7++) {
    if(!self._id_0AAF) {
      if(!_id_0BDC(self._id_0BA6)) {
        continue;
      } else if(!_id_0C38(0)) {
        continue;
      }
    }

    if(self._id_0BA3 > 0) {
      continue;
    }
    if(_id_0BE6(self._id_0BA6._id_0BDA)) {
      wait 0.85;
      continue;
    }

    if(!soundexists(var_0._id_0BB0[var_7])) {
      continue;
    }
    var_8 = gettime();
    var_9 = spawn("script_origin", self gettagorigin("j_head"));
    var_9 linkto(self);

    if(var_0._id_0BAB && self.team == "allies") {
      thread maps\_anim::_id_0BDB(var_0._id_0BB0[var_7], var_0._id_0BAE);
      var_9 playsoundasmaster(var_0._id_0BB0[var_7], var_0._id_0BB0[var_7], 1);
      var_9 waittill(var_0._id_0BB0[var_7]);
      self notify(var_0._id_0BB0[var_7]);
    } else {
      thread maps\_anim::_id_0BDB(var_0._id_0BB0[var_7], var_0._id_0BAE);

      if(getdvarint("bcs_forceEnglish", 0)) {
        var_9 playsoundasmaster(var_0._id_0BB0[var_7], var_0._id_0BB0[var_7], 1);
      } else {
        var_9 playSound(var_0._id_0BB0[var_7], var_0._id_0BB0[var_7], 1);

      }
      var_9 waittill(var_0._id_0BB0[var_7]);
      self notify(var_0._id_0BB0[var_7]);
    }

    var_9 delete();

    if(gettime() < var_8 + 250) {}
  }

  self notify("playPhrase_done");
  _id_0BE9(self._id_0BA6._id_0BDA, self._id_0BA6._id_0BA7);
}

_id_0BDC(var_0) {
  if(!isDefined(var_0._id_0BDA) || !isDefined(var_0._id_0BA7)) {
    return 0;

  }
  if(var_0._id_0BDA == "reaction" && var_0._id_0BA7 == "friendlyfire") {
    return 1;

  }
  return 0;
}

_id_0BDD(var_0) {
  self endon("death");
  wait 25;
  _id_0BDE(var_0);
}

_id_0BDE(var_0) {
  self._id_0AC9 = 0;
  self._id_0AC6[var_0]._id_0ACB = 0;
  self._id_0AC6[var_0].priority = 0.0;
  self._id_0AC8[var_0] = gettime() + anim._id_0B6F[var_0]["self"];
}

_id_0BDF(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  var_3 = var_0._id_0A7A;
  var_4 = var_0.team;
  var_0._id_0AC9 = 1;
  var_0 thread _id_0BDD(var_1);
  var_3._id_0B97[var_1] = 1;
  var_3._id_0B94++;
  anim.isteamspeaking[var_4] = 1;
  anim._id_0B81[var_4][var_1] = 1;
  var_5 = var_0 common_scripts\utility::waittill_any_return("death", "done speaking", "cancel speaking");
  var_3._id_0B97[var_1] = 0;
  var_3._id_0B94--;
  anim.isteamspeaking[var_4] = 0;
  anim._id_0B81[var_4][var_1] = 0;

  if(var_5 == "cancel speaking") {
    return;
  }
  anim._id_0B83[var_4] = gettime();

  if(isalive(var_0)) {
    var_0 _id_0BDE(var_1);

  }
  var_3._id_0AC8[var_1] = gettime() + anim._id_0B6F[var_1]["squad"];
}

_id_0ADA(var_0, var_1) {
  if(gettime() - self._id_0A6E[var_0]._id_0BE0 > 10000) {
    var_2 = 0;

    for(var_3 = 0; var_3 < self._id_0A6B.size; var_3++) {
      if(self._id_0A6B[var_3] != var_1 && isalive(self._id_0A6B[var_3].enemy) && isDefined(self._id_0A6B[var_3].enemy._id_0A7A) && self._id_0A6B[var_3].enemy._id_0A7A._id_0A66 == var_0) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      self._id_0A6E[var_0]._id_0BE1 = gettime();
      self._id_0A6E[var_0]._id_0AAE = 0;
    }
  }

  self._id_0A6E[var_0]._id_0BE0 = gettime();
}

_id_0AD6(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(isplayer(self)) {
    return 0;

  }
  if(distance(level.player.origin, self.origin) > level._id_0B78) {
    return 0;

  }
  if(!isDefined(self._id_0AAF) || !self._id_0AAF) {
    return 0;

  }
  if(isDefined(var_2) && var_2 >= 1) {
    return 1;

  }
  if(gettime() + anim._id_0B6F[var_0]["self"] < self._id_0AC8[var_0]) {
    return 0;

  }
  if(gettime() + anim._id_0B6F[var_0]["squad"] < self._id_0A7A._id_0AC8[var_0]) {
    return 0;

  }
  if(isDefined(var_1) && _id_0BE8(var_0, var_1)) {
    return 0;

  }
  if(isDefined(var_1) && anim._id_0B70[var_0][var_1] < self._id_0ACD) {
    return 0;

  }
  return 1;
}

_id_0BE2() {
  var_0 = undefined;
  var_1 = -999999999;

  foreach(var_4, var_3 in self._id_0AC6) {
    if(_id_0BE7(var_4)) {
      if(var_3.priority > var_1) {
        var_0 = var_4;
        var_1 = var_3.priority;
      }
    }
  }

  return var_0;
}

_id_0BE3(var_0) {
  var_1 = self._id_0A7A;
  var_2 = [];

  for(var_3 = 0; var_3 < var_1._id_0A6B.size; var_3++) {
    if(isDefined(var_1._id_0A6B[var_3].enemy) && var_1._id_0A6B[var_3].enemy == var_0) {
      var_2[var_2.size] = var_1._id_0A6B[var_3];
    }
  }

  if(!isDefined(var_2[0])) {
    return undefined;

  }
  var_4 = undefined;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] _id_0AD6("response")) {
      return var_4;
    }
  }

  return maps\_utility::_id_0AE9(self.origin, var_2);
}

_id_0BE4() {
  var_0 = [];
  var_1 = [];
  var_0[0] = "custom";
  var_0[1] = "response";
  var_0[2] = "order";
  var_0[3] = "threat";
  var_0[4] = "inform";

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(self._id_0AC6[var_0[var_3 - 1]].priority < self._id_0AC6[var_0[var_3]].priority) {
        var_4 = var_0[var_3 - 1];
        var_0[var_3 - 1] = var_0[var_3];
        var_0[var_3] = var_4;
      }
    }
  }

  var_5 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_6 = _id_0BE5(var_0[var_2]);

    if(var_6 == " valid" && !var_5) {
      var_5 = 1;
      var_1[var_2] = "g " + var_0[var_2] + var_6 + " " + self._id_0AC6[var_0[var_2]].priority;
      continue;
    }

    if(var_6 == " valid") {
      var_1[var_2] = "y " + var_0[var_2] + var_6 + " " + self._id_0AC6[var_0[var_2]].priority;
      continue;
    }

    if(self._id_0AC6[var_0[var_2]]._id_0ACB == 0) {
      var_1[var_2] = "b " + var_0[var_2] + var_6 + " " + self._id_0AC6[var_0[var_2]].priority;
      continue;
    }

    var_1[var_2] = "r " + var_0[var_2] + var_6 + " " + self._id_0AC6[var_0[var_2]].priority;
  }

  return var_1;
}

_id_0BE5(var_0) {
  var_1 = "";

  if(self._id_0A7A._id_0B97[var_0]) {
    var_1 = var_1 + " playing";

  }
  if(gettime() > self._id_0AC6[var_0]._id_0ACB) {
    var_1 = var_1 + " expired";

  }
  if(gettime() < self._id_0A7A._id_0AC8[var_0]) {
    var_1 = var_1 + " cantspeak";

  }
  if(var_1 == "") {
    var_1 = " valid";

  }
  return var_1;
}

_id_0BE6(var_0) {
  if(getdvar("bcs_filter" + var_0, "off") == "on" || getdvar("bcs_filter" + var_0, "off") == "1") {
    return 1;

  }
  return 0;
}

_id_0BE7(var_0) {
  if(!self._id_0A7A._id_0B97[var_0] && !anim._id_0B81[self.team][var_0] && gettime() < self._id_0AC6[var_0]._id_0ACB && gettime() > self._id_0A7A._id_0AC8[var_0]) {
    if(!_id_0BE8(var_0, self._id_0AC6[var_0]._id_0BA7)) {
      return 1;
    }
  }

  return 0;
}

_id_0BE8(var_0, var_1) {
  if(!isDefined(anim._id_0B6D[var_0][var_1])) {
    return 0;

  }
  if(!isDefined(self._id_0A7A._id_0B96[var_0][var_1])) {
    return 0;

  }
  if(gettime() > self._id_0A7A._id_0B96[var_0][var_1]) {
    return 0;

  }
  return 1;
}

_id_0BE9(var_0, var_1) {
  if(!isDefined(anim._id_0B6D[var_0][var_1])) {
    return;
  }
  self._id_0A7A._id_0B96[var_0][var_1] = gettime() + anim._id_0B6D[var_0][var_1];
}

_id_0BEA() {
  if(isplayer(self)) {
    return 0;

  }
  if(_id_0AA8()) {
    return 0;

  }
  return animscripts\utility::_id_0BEB(self.weapon);
}

_id_0AA8() {
  if(distance(self.origin, level.player.origin) > 1500) {
    return 0;

  }
  if(isDefined(_id_0AED())) {
    return 0;

  }
  var_0 = _id_0BED();

  if(!isDefined(var_0)) {
    return 1;

  }
  if(!_id_0B2B()) {
    return 0;

  }
  return 1;
}

_id_0B2B() {
  var_0 = self.node;

  if(!isDefined(var_0)) {
    return 0;

  }
  if(issubstr(var_0.type, "Cover") || issubstr(var_0.type, "Conceal")) {
    return 1;

  }
  return 0;
}

_id_0BEC(var_0) {
  if(var_0._id_0A6D > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_0A83() {
  var_0 = getrank();

  if(!isDefined(var_0)) {
    return 0;

  }
  if(var_0 == "sergeant" || var_0 == "lieutenant" || var_0 == "captain" || var_0 == "sergeant") {
    return 1;

  }
  return 0;
}

_id_0BED() {
  if(isplayer(self)) {
    return self.node;
  } else {
    return animscripts\utility::_id_0BEE();
  }
}

_id_0BEF() {
  if(self isbadguy()) {
    return 1;
  } else {
    return 0;
  }
}

_id_0AC1() {
  if(_id_0BEF()) {
    var_0 = self._id_0BF0;
  } else if(self.team == "allies") {
    var_0 = self.name;
  } else {
    var_0 = undefined;

  }
  if(!isDefined(var_0)) {
    return undefined;

  }
  var_1 = strtok(var_0, " ");

  if(var_1.size < 2) {
    return var_0;

  }
  return var_1[1];
}

getrank() {
  return self._id_0BF1;
}

_id_0BF2(var_0) {
  var_1 = _id_0BF3(var_0, self.team);
  var_2 = maps\_utility::_id_0AE9(self.origin, var_1);
  return var_2;
}

_id_0BF3(var_0, var_1) {
  var_2 = [];
  var_3 = getaiarray(var_1);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_3[var_4] == self) {
      continue;
    }
    if(!var_3[var_4] _id_0AD6(var_0)) {
      continue;
    }
    var_2[var_2.size] = var_3[var_4];
  }

  return var_2;
}

_id_0B2C(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_2)) {
    var_2 = "response";

  }
  var_4 = maps\_utility::_id_0B53(self._id_0A7A._id_0A6B);
  var_0 = var_0 * var_0;
  var_1 = var_1 * var_1;

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] == self) {
      continue;
    }
    if(!isalive(var_4[var_5])) {
      continue;
    }
    var_6 = distancesquared(self.origin, var_4[var_5].origin);

    if(var_6 < var_0) {
      continue;
    }
    if(var_6 > var_1) {
      continue;
    }
    if(_id_0ADD(var_4[var_5])) {
      continue;
    }
    if(!var_4[var_5] _id_0AD6(var_2)) {
      continue;
    }
    var_3 = var_4[var_5];

    if(_id_0C08(var_3)) {
      break;
    }
  }

  return var_3;
}

_id_0AED() {
  var_0 = _id_0BF4();
  var_0 = maps\_utility::_id_0B53(var_0);

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(!_id_0BF6(var_2)) {
        return var_2;
      }
    }

    foreach(var_2 in var_0) {
      if(!_id_0AEE(var_2)) {
        return var_2;
      }
    }
  }

  return undefined;
}

_id_0BF4() {
  var_0 = anim._id_0B52;
  var_1 = [];

  foreach(var_3 in var_0) {
    if(self istouching(var_3) && isDefined(var_3._id_0B54)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_0BF5() {
  if(isDefined(anim._id_0B52)) {
    anim._id_0B52 = common_scripts\utility::array_removeundefined(anim._id_0B52);
  }
}

_id_0B22() {
  var_0 = _id_0BF4();

  foreach(var_2 in var_0) {
    if(!_id_0AEE(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_0BF6(var_0) {
  var_1 = _id_0BF8(var_0);

  if(!isDefined(var_1)) {
    return 0;

  }
  return 1;
}

_id_0AEE(var_0) {
  var_1 = _id_0BF8(var_0);

  if(!isDefined(var_1)) {
    return 0;

  }
  var_2 = var_1 + anim._id_0B6F["threat"]["location_repeat"];

  if(gettime() < var_2) {
    return 1;

  }
  return 0;
}

_id_0BF7(var_0) {
  anim._id_0B7C[var_0.classname] = gettime();
}

_id_0BF8(var_0) {
  if(isDefined(anim._id_0B7C[var_0.classname])) {
    return anim._id_0B7C[var_0.classname];

  }
  return undefined;
}

_id_0BF9(var_0) {
  var_1 = var_0.angles;

  if(!isplayer(var_0)) {
    var_2 = var_0 _id_0BED();

    if(isDefined(var_2)) {
      var_1 = var_2.angles;
    }
  }

  return var_1;
}

_id_0BFA(var_0) {
  if(var_0 == "left" || var_0 == "right") {
    return 1;

  }
  return 0;
}

_id_0BFB(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2);
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = var_3[1] - var_4[1];
  var_5 = var_5 + 360;
  var_5 = int(var_5) % 360;

  if(var_5 > 315 || var_5 < 45) {
    var_6 = "front";
  } else if(var_5 < 135) {
    var_6 = "right";
  } else if(var_5 < 225) {
    var_6 = "rear";
  } else {
    var_6 = "left";

  }
  return var_6;
}

_id_0BFC(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "north":
      var_1 = "n";
      break;
    case "northwest":
      var_1 = "nw";
      break;
    case "west":
      var_1 = "w";
      break;
    case "southwest":
      var_1 = "sw";
      break;
    case "south":
      var_1 = "s";
      break;
    case "southeast":
      var_1 = "se";
      break;
    case "east":
      var_1 = "e";
      break;
    case "northeast":
      var_1 = "ne";
      break;
    case "impossible":
      var_1 = "impossible";
      break;
    default:
      return;
  }

  return var_1;
}

_id_0BFD(var_0, var_1) {
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = var_2[1];
  var_4 = getnorthyaw();
  var_3 = var_3 - var_4;

  if(var_3 < 0) {
    var_3 = var_3 + 360;
  } else if(var_3 > 360) {
    var_3 = var_3 - 360;

  }
  if(var_3 < 22.5 || var_3 > 337.5) {
    var_5 = "north";
  } else if(var_3 < 67.5) {
    var_5 = "northwest";
  } else if(var_3 < 112.5) {
    var_5 = "west";
  } else if(var_3 < 157.5) {
    var_5 = "southwest";
  } else if(var_3 < 202.5) {
    var_5 = "south";
  } else if(var_3 < 247.5) {
    var_5 = "southeast";
  } else if(var_3 < 292.5) {
    var_5 = "east";
  } else if(var_3 < 337.5) {
    var_5 = "northeast";
  } else {
    var_5 = "impossible";

  }
  return var_5;
}

_id_0BFE(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 0.0254 * var_2;
  return var_3;
}

_id_0BFF(var_0, var_1) {
  var_2 = _id_0BFE(var_0, var_1);

  if(var_2 < 15.0) {
    return "10";
  } else if(var_2 < 25.0) {
    return "20";
  } else if(var_2 < 35.0) {
    return "30";
  } else {
    return "40";
  }
}

_id_0C00(var_0) {
  var_1 = "undefined";

  if(var_0 == "10" || var_0 == "11") {
    var_1 = "10";
  } else if(var_0 == "12") {
    var_1 = var_0;
  } else if(var_0 == "1" || var_0 == "2") {
    var_1 = "2";

  }
  return var_1;
}

_id_0C01(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;

  if(var_7 > 345 || var_7 < 15) {
    var_8 = "12";
  } else if(var_7 < 45) {
    var_8 = "1";
  } else if(var_7 < 75) {
    var_8 = "2";
  } else if(var_7 < 105) {
    var_8 = "3";
  } else if(var_7 < 135) {
    var_8 = "4";
  } else if(var_7 < 165) {
    var_8 = "5";
  } else if(var_7 < 195) {
    var_8 = "6";
  } else if(var_7 < 225) {
    var_8 = "7";
  } else if(var_7 < 255) {
    var_8 = "8";
  } else if(var_7 < 285) {
    var_8 = "9";
  } else if(var_7 < 315) {
    var_8 = "10";
  } else {
    var_8 = "11";

  }
  return var_8;
}

_id_0C02(var_0, var_1) {
  var_2 = var_1[2] - var_0[2];
  var_3 = distance2d(var_0, var_1);
  var_4 = atan(var_2 / var_3);

  if(var_4 < 15 || var_4 > 55) {
    return var_4;
  } else if(var_4 < 25) {
    return 20;
  } else if(var_4 < 35) {
    return 30;
  } else if(var_4 < 45) {
    return 40;
  } else if(var_4 < 55) {
    return 50;
  }
}

getvectorrightangle(var_0) {
  return (var_0[1], 0 - var_0[0], var_0[2]);
}

_id_0C04(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];

  }
  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

_id_0B4D(var_0) {
  self._id_0BB0[self._id_0BB0.size] = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_name_" + var_0;
  anim._id_0B84[self.owner.team] = var_0;
  anim._id_0B85[self.owner.team] = gettime();
}

_id_0C05() {
  if(!self.owner _id_0C0A()) {
    return;
  }
  anim._id_0C06 = gettime();
  var_0 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_name_player_" + level.player._id_0BA1 + "_" + level.player._id_0BA0;
  self._id_0BB0[self._id_0BB0.size] = var_0;
  self._id_0BAE = level.player;
}

_id_0C07(var_0) {
  self._id_0BB0[self._id_0BB0.size] = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_rank_" + var_0;
}

_id_0C08(var_0) {
  if(_id_0BEF()) {
    return 0;

  }
  if(!isDefined(var_0._id_0AC2)) {
    return 0;

  }
  if(var_0._id_0AAF == 0) {
    return 0;

  }
  if(!isDefined(var_0._id_0AB4)) {
    return 0;

  }
  if(self._id_0AB4 != var_0._id_0AB4) {
    return 0;

  }
  if(_id_0C09(var_0)) {
    return 0;

  }
  var_1 = self._id_0AB4 + "_" + self._id_0AB6 + "_name_" + var_0._id_0AC2;

  if(soundexists(var_1)) {
    return 1;

  }
  return 0;
}

_id_0C09(var_0) {
  if(anim._id_0B84[self.team] == var_0._id_0AC2 || gettime() - anim._id_0B85[self.team] < anim._id_0B86) {
    return 1;

  }
  return 0;
}

_id_0C0A() {
  if(_id_0BEF()) {
    return 0;

  }
  if(!isDefined(level.player._id_0BA0) || !isDefined(level.player._id_0BA1)) {
    return 0;

  }
  if(_id_0C0B()) {
    return 0;

  }
  var_0 = self._id_0AB4 + "_" + self._id_0AB6 + "_name_player_" + level.player._id_0BA1 + "_" + level.player._id_0BA0;

  if(soundexists(var_0)) {
    return 1;

  }
  return 0;
}

_id_0C0B() {
  if(!isDefined(anim._id_0C06)) {
    return 0;

  }
  if(gettime() - anim._id_0C06 >= anim._id_0B6D["playername"]) {
    return 0;

  }
  return 1;
}

_id_0ADD(var_0) {
  if(isstring(self._id_0AB6) && isstring(var_0._id_0AB6) && self._id_0AB6 == var_0._id_0AB6) {
    return 1;
  } else if(!isstring(self._id_0AB6) && !isstring(var_0._id_0AB6) && self._id_0AB6 == var_0._id_0AB6) {
    return 1;
  } else {
    return 0;
  }
}

_id_0C0C(var_0, var_1) {
  var_2 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_threat_" + var_0;

  if(isDefined(var_1)) {
    var_2 = var_2 + ("_" + var_1);

  }
  self._id_0BB0 = maps\_utility::_id_0BC3(self._id_0BB0, var_2);
  return 1;
}

_id_0C0D(var_0) {
  var_1 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_exposed_" + var_0;
  self._id_0BB0[self._id_0BB0.size] = var_1;
  return 1;
}

_id_0C0E() {
  var_0 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_order_action_suppress";
  self._id_0BB0[self._id_0BB0.size] = var_0;
  return 1;
}

_id_0C0F(var_0) {
  var_1 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_co_dist_" + var_0;
  self._id_0BB0[self._id_0BB0.size] = var_1;
  return 1;
}

_id_0C10(var_0) {
  var_1 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_co_elev_" + var_0;
  self._id_0BB0[self._id_0BB0.size] = var_1;
  return 1;
}

_id_0C11(var_0, var_1) {
  var_2 = _id_0C14(var_0, var_1);

  if(!soundexists(var_2)) {
    return 0;

  }
  self._id_0BB0[self._id_0BB0.size] = var_2;
  return 1;
}

_id_0C12(var_0) {
  var_1 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_resp_ack_co_gnrc_" + var_0;

  if(!soundexists(var_1)) {
    return 0;

  }
  self._id_0BB0[self._id_0BB0.size] = var_1;
  return 1;
}

_id_0C13(var_0, var_1, var_2) {
  var_3 = undefined;

  foreach(var_5 in var_2._id_0B54) {
    if(issubstr(var_1, var_5)) {
      var_3 = var_5;
      break;
    }
  }

  var_7 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_co_";
  var_8 = getsubstr(var_1, var_1.size - 1, var_1.size);
  var_9 = int(var_8) + 1;
  var_10 = var_7 + var_3 + "_qa" + var_9;

  if(!soundexists(var_10)) {
    if(randomint(100) < anim._id_0B2D["response"]["callout_negative"]) {
      var_0 animscripts\battlechatter_ai::_id_0ADB("callout", "neg", self.owner, 0.9);
    } else {
      var_0 animscripts\battlechatter_ai::_id_0ADB("exposed", "acquired", self.owner, 0.9);

    }
    var_2._id_0BB9 = 1;
    return 0;
  }

  var_0 animscripts\battlechatter_ai::_id_0ADB("callout", "QA", self.owner, 0.9, var_10, var_2);
  self._id_0BB0[self._id_0BB0.size] = var_10;
  return 1;
}

_id_0C14(var_0, var_1) {
  var_2 = "_report";
  var_3 = "_echo";
  var_4 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_";
  var_5 = var_0.size - var_2.size;
  var_6 = self.owner._id_0AB4 + "_" + var_1._id_0AB6 + "_";
  var_7 = var_6.size;
  var_8 = getsubstr(var_0, var_7, var_5);
  var_9 = var_4 + var_8 + var_3;
  return var_9;
}

_id_0C15(var_0, var_1) {
  var_2 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_callout_" + var_0 + "_" + var_1;
  self._id_0BB0[self._id_0BB0.size] = var_2;
  return 1;
}

_id_0C16(var_0, var_1, var_2) {
  var_3 = var_0._id_0C17;

  if(!isDefined(var_2)) {
    var_2 = 0;

  }
  var_4 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_callout_obj_" + var_3;

  if(var_2) {
    var_4 = var_4 + "_y";

  }
  var_4 = var_4 + ("_" + var_1);

  if(!soundexists(var_4)) {
    return 0;

  }
  self._id_0BB0[self._id_0BB0.size] = var_4;
  return 1;
}

_id_0C18(var_0) {
  var_1 = undefined;
  var_2 = var_0._id_0B54;
  var_3 = var_2[0];

  if(var_2.size > 1) {
    var_4 = undefined;
    var_4 = var_0 _id_0BB8(self.owner);

    if(isDefined(var_4)) {
      var_3 = var_4;
    } else {
      var_3 = common_scripts\utility::random(var_2);
    }
  }

  var_5 = undefined;

  if(!isDefined(var_0._id_0BB9) && _id_0BBB(var_3, self.owner)) {
    var_5 = self.owner _id_0BBC(var_3, 0);
  } else {
    var_6 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_";

    if(!issubstr(var_3, "callout")) {
      var_6 = var_6 + "co_";

    }
    var_5 = var_6 + var_3;
  }

  if(soundexists(var_5)) {
    var_1 = var_5;

  }
  if(!isDefined(var_1)) {
    return 0;

  }
  _id_0BF7(var_0);
  self._id_0BB0[self._id_0BB0.size] = var_1;
  return 1;
}

_id_0B4B(var_0, var_1) {
  var_2 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_inform_" + var_0 + "_" + var_1;
  self._id_0BB0[self._id_0BB0.size] = var_2;
}

_id_0C19(var_0, var_1) {
  var_2 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_response_" + var_0 + "_" + var_1;
  self._id_0BB0[self._id_0BB0.size] = var_2;
  return 1;
}

_id_0C1A(var_0, var_1) {
  var_2 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_reaction_" + var_0 + "_" + var_1;
  self._id_0BB0[self._id_0BB0.size] = var_2;
  return 1;
}

_id_0C1B() {
  var_0 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_check_fire";
  self._id_0BB0[self._id_0BB0.size] = var_0;
  return 1;
}

_id_0C1C(var_0, var_1) {
  var_2 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_taunt";
  self._id_0BB0[self._id_0BB0.size] = var_2;
  return 1;
}

_id_0C1D() {
  var_0 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_hostile_burst";
  self._id_0BB0[self._id_0BB0.size] = var_0;
  return 1;
}

_id_0B47(var_0, var_1) {
  var_2 = self.owner._id_0AB4 + "_" + self.owner._id_0AB6 + "_order_" + var_0 + "_" + var_1;
  self._id_0BB0[self._id_0BB0.size] = var_2;
  return 1;
}

_id_0C1E(var_0) {
  if(!isDefined(self._id_0A6E[var_0]._id_0AAE)) {
    self._id_0A6E[var_0]._id_0AAE = 0;

  }
  if(!isDefined(self._id_0A6E[var_0]._id_0BE1)) {
    self._id_0A6E[var_0]._id_0BE1 = 2000000000;

  }
  if(!isDefined(self._id_0A6E[var_0]._id_0BE0)) {
    self._id_0A6E[var_0]._id_0BE0 = 0;
  }
}

_id_0C1F(var_0) {
  self._id_0A6E[var_0]._id_0AAE = undefined;
  self._id_0A6E[var_0]._id_0BE1 = undefined;
  self._id_0A6E[var_0]._id_0BE0 = undefined;
}

_id_0AD8(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.owner = self;
  var_3._id_0BA7 = var_1;
  var_3._id_0BDA = var_0;

  if(isDefined(var_2)) {
    var_3.priority = var_2;
  } else {
    var_3.priority = anim._id_0B70[var_0][var_1];

  }
  var_3._id_0ACB = gettime() + anim._id_0B71[var_0][var_1];
  return var_3;
}

_id_0B45() {
  var_0 = spawnStruct();
  var_0.owner = self;
  var_0._id_0BB0 = [];
  var_0._id_0BAB = 0;
  return var_0;
}

_id_0C20(var_0) {
  return maps\_utility::within_fov(self.origin, self.angles, var_0, 0.766);
}

_id_0B1E(var_0) {
  return maps\_utility::within_fov(self.origin, self.angles, var_0.origin, 0);
}

_id_0C22() {
  anim endon("battlechatter disabled");
  self endon("squad_deleting");

  if(self.team != "allies") {
    if(level.script != "af_caves") {
      return;
    }
  }

  while(self._id_0A6A <= 0) {
    wait 0.5;

  }
  var_0 = 0;

  while(isDefined(self)) {
    if(!_id_0C23(self)) {
      var_0 = 1;
      wait 1;
      continue;
    } else if(self._id_0B99) {
      if(!var_0) {
        wait(randomfloat(anim._id_0B73));

      }
      if(var_0) {
        var_0 = 0;

      }
      self._id_0B99 = 0;
    } else {
      if(!var_0) {
        wait(randomfloatrange(anim._id_0B73, anim._id_0B74));

      }
      if(var_0) {
        var_0 = 0;
      }
    }

    var_1 = _id_0C25(self);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = var_1.voice;
    var_3 = _id_0C27(self, var_2);
    var_4 = _id_0C29(var_2, var_3);

    foreach(var_8, var_6 in var_4) {
      if(!var_1 _id_0C24() || distance(level.player.origin, var_1.origin) > anim._id_0B72) {
        for(var_7 = 0; var_7 < self._id_0A6B.size; var_7++) {
          var_1 = _id_0C25(self);

          if(!isDefined(var_1)) {
            continue;
          }
          if(var_1.voice == var_2) {
            break;
          }
        }

        if(!isDefined(var_1) || var_1.voice != var_2) {
          break;
        }
      }

      thread _id_0C2A(var_1, var_6);
      self waittill("burst_line_done");

      if(var_8 != var_4.size - 1) {
        wait(randomfloatrange(anim._id_0B75, anim._id_0B76));
      }
    }
  }
}

_id_0C23(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0._id_0A6B) {
    if(var_3 _id_0C24()) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_0C24() {
  var_0 = 0;

  if(!isplayer(self) && isalive(self) && self.classname != "actor_enemy_dog" && level._id_0AB0[self.team] && _id_0AD2() && self._id_0AB0) {
    var_0 = 1;

  }
  return var_0;
}

_id_0AD2() {
  if(isDefined(anim._id_0B82[self.voice]) && anim._id_0B82[self.voice]) {
    return 1;

  }
  return 0;
}

_id_0C25(var_0) {
  var_1 = undefined;
  var_2 = maps\_utility::_id_0C26(level.player.origin, var_0._id_0A6B);

  foreach(var_4 in var_2) {
    if(var_4 _id_0C24()) {
      var_1 = var_4;

      if(!isDefined(var_0._id_0B9A)) {
        break;
      }

      if(isDefined(var_0._id_0B9A) && var_0._id_0B9A == var_1.unique_id) {
        continue;
      }
    }
  }

  if(isDefined(var_1)) {
    var_0._id_0B9A = var_1.unique_id;

  }
  return var_1;
}

_id_0C27(var_0, var_1) {
  var_2 = maps\_utility::_id_0B53(anim._id_0AB0[var_1]);

  if(anim._id_0B92.size >= var_2.size) {
    anim._id_0B92 = [];

  }
  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_3 = var_5;

    if(!_id_0C28(var_3)) {
      break;
    }
  }

  anim._id_0B92[anim._id_0B92.size] = var_3;
  return var_3;
}

_id_0C28(var_0) {
  if(!anim._id_0B92.size) {
    return 0;

  }
  var_1 = 0;

  foreach(var_3 in anim._id_0B92) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_0C29(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  var_3 = var_2;
  var_4 = [];

  for(;;) {
    var_5 = "FB_" + anim._id_0AB3[var_0] + "_" + var_1 + "_" + var_3;
    var_3++;

    if(soundexists(var_5)) {
      var_4[var_4.size] = var_5;
      continue;
    }

    break;
  }

  return var_4;
}

_id_0C2A(var_0, var_1) {
  anim endon("battlechatter disabled");
  var_2 = spawn("script_origin", var_0 gettagorigin("j_head"));
  var_2 linkto(var_0);
  var_2 playSound(var_1, var_1, 1);
  var_2 waittill(var_1);
  var_2 delete();

  if(isDefined(self)) {
    self notify("burst_line_done");
  }
}

_id_0C2B(var_0, var_1) {
  self endon("burst_line_done");

  for(;;) {
    wait 0.05;
  }
}

_id_0C2C() {
  return 0;
}

_id_0C2D() {
  return 0;
}

_id_0C2E(var_0) {
  if(var_0.size <= 0) {
    return;
  }
  if(!_id_0C2C()) {
    return;
  }
  var_1 = "^5 ";

  if(_id_0BEF()) {
    var_1 = "^6 ";

  }
  foreach(var_3 in var_0) {}
}

_id_0C2F(var_0, var_1) {}

_id_0C30(var_0) {
  var_1 = self._id_0AB4 + "_" + self._id_0AB6 + "_";
  var_2 = getsubstr(var_0, var_1.size, var_0.size);
  return var_2;
}

_id_0C31(var_0, var_1, var_2) {
  if(common_scripts\utility::flag(var_2)) {
    common_scripts\utility::flag_wait(var_2);

  }
  common_scripts\utility::flag_set(var_2);
  common_scripts\utility::flag_clear(var_2);
}

_id_0C32() {
  for(var_0 = 0; var_0 < anim._id_0B52.size; var_0++) {
    var_1 = anim._id_0B52[var_0]._id_0B54;

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = "";

    foreach(var_4 in var_1) {}
    var_2 = var_2 + var_4;

    thread _id_0C33("Location: " + var_2, anim._id_0B52[var_0] getorigin(), (0, 0, 8), (1, 1, 1));
  }
}

_id_0C33(var_0, var_1, var_2, var_3) {
  for(;;) {
    if(distance(level.player.origin, var_1) > 2048) {
      wait 0.1;
      continue;
    }

    wait 0.05;
  }
}

_id_0C34(var_0, var_1, var_2) {
  var_3 = var_0 getorigin();

  for(;;) {
    if(distance(level.player.origin, var_3) > 2048) {
      wait 0.1;
      continue;
    }

    var_4 = _id_0BFD(level.player.origin, var_3);
    var_4 = _id_0BFC(var_4);
    var_5 = _id_0C01(level.player.angles, level.player.origin, var_3);
    var_6 = var_4 + ", " + var_5 + ":00";
    wait 0.05;
  }
}

_id_0C35(var_0, var_1) {
  var_2 = getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }
    if(!isDefined(var_4._id_0AAF)) {
      continue;
    }
    var_4._id_0AC8[var_1] = gettime() + 350;
    var_4._id_0A7A._id_0AC8[var_1] = gettime() + 350;
  }
}

_id_0C36() {
  self endon("death");

  if(self.voice == "british") {
    return 1;
  } else {
    return 0;
  }
}

_id_0C37() {
  if(!_id_0C38()) {
    return 0;

  }
  _id_0BE9("reaction", "friendlyfire");
  thread _id_0BC5();
  return 1;
}

_id_0C38(var_0) {
  if(isDefined(self._id_0C39)) {
    return 0;

  }
  if(!isDefined(self._id_0AC6)) {
    return 0;

  }
  if(!isDefined(self._id_0AC6["reaction"]) || !isDefined(self._id_0AC6["reaction"]._id_0BA7)) {
    return 0;

  }
  if(self._id_0AC6["reaction"]._id_0BA7 != "friendlyfire") {
    return 0;

  }
  if(gettime() > self._id_0AC6["reaction"]._id_0ACB) {
    return 0;

  }
  if(!isDefined(var_0)) {
    var_0 = 1;

  }
  if(var_0) {
    if(isDefined(self._id_0A7A._id_0B96["reaction"]["friendlyfire"])) {
      if(gettime() < self._id_0A7A._id_0B96["reaction"]["friendlyfire"]) {
        return 0;
      }
    }
  }

  return 1;
}
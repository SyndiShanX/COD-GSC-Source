/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4fdefae8b7bcdf73.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_2707474774db34b;
#using scripts\mp\objective_marker_bundle_helper;
#using script_3ac7886f9e4eceef;
#using script_41387eecc35b88bf;
#using script_4d39bd4c621e7680;
#using script_7956d56c4922bd1;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace namespace_c669075cf56436f4;

function function_36a95c9de2ace25a(bundlename, shouldpin, var_777b269d7a4d5633) {
  bundlexhash = hashcat(%"hash_334a4b8da1c7fd3f", bundlename);
  return function_f7680f0db96cad7b(bundlexhash, shouldpin, var_777b269d7a4d5633);
}

function function_f7680f0db96cad7b(bundlexhash, shouldpin, var_777b269d7a4d5633) {
  var_777b269d7a4d5633 = default_to(var_777b269d7a4d5633, 1);
  shouldpin = default_to(shouldpin, 0);
  var_e18422fb39577bb4 = namespace_871f41e67db0bf7a::createobjectivemarkerfrombundlexhash(bundlexhash);

  if(isDefined(var_e18422fb39577bb4) && var_e18422fb39577bb4 != -1) {
    function_6f02ac608d44fdbf(var_e18422fb39577bb4, shouldpin, var_777b269d7a4d5633);
  } else {
    assertmsg("<dev string:x1c>" + getxhashsourcename(bundlexhash) + "<dev string:x50>" + namespace_68dc261109a9503f::function_a4748b32a824c79c(self));
  }

  return var_e18422fb39577bb4;
}

function function_6f02ac608d44fdbf(markerid, shouldpin, var_777b269d7a4d5633) {
  var_777b269d7a4d5633 = default_to(var_777b269d7a4d5633, 1);
  self.objectivemarkers[markerid] = spawnStruct();
  self.objectivemarkers[markerid].id = markerid;
  self.objectivemarkers[markerid].shouldpin = istrue(shouldpin);
  self.objectivemarkers[markerid].var_1a64187243779c27 = var_777b269d7a4d5633;
  activitynexuslog("MARKER IS BEING MANAGED:" + function_203add19f2f26253(markerid), @ "hash_ee2680c4a8804012", self);

  if(var_777b269d7a4d5633) {
    objective_removeallfrommask(markerid);
    function_c32880b1943fa8ba(self.playerparticipants, markerid);
  }

  return markerid;
}

function function_70fba69479c7f650(markerid) {
  if(!isDefined(self.objectivemarkers[markerid])) {
    return;
  }

  self.objectivemarkers = array_remove_key(self.objectivemarkers, markerid);
  activitynexuslog("MARKER IS NO LONGER BEING MANAGED:" + function_203add19f2f26253(markerid), @ "hash_ee2680c4a8804012", self);
}

function function_765b706dc170e214(markerid) {
  if(!isDefined(markerid) || !isDefined(self.objectivemarkers[markerid])) {
    return;
  }

  self.objectivemarkers = array_remove_key(self.objectivemarkers, markerid);
  scripts\mp\objidpoolmanager::returnobjectiveid(markerid);
  activitynexuslog("MARKER RETURNED TO OBJECTIVE POOL:" + function_203add19f2f26253(markerid), @ "hash_ee2680c4a8804012", self);
}

function function_2a691f6f7cceb283(markerid) {
  assertex(isDefined(self.objectivemarkers[markerid]), "<dev string:x6f>");
  self.objectivemarkers[markerid].shouldpin = 1;
  function_8e26a7c882870c4(self.playerparticipants, markerid);
}

function function_48f5297a819ff2e(markerid) {
  assertex(isDefined(self.objectivemarkers[markerid]), "<dev string:x6f>");
  self.objectivemarkers[markerid].shouldpin = 0;
  function_5aade87a12c96e0d(self.playerparticipants, markerid);
}

function function_47a5129abc55bd53(activityinstance, activitymoment) {
  if(function_cdea2ef0bf179c63(activityinstance)) {
    type = function_c3f893aeddade548(activityinstance);
    spawnmoment = function_ec3073136fa5be4f(activityinstance);
    destroymoment = function_77041690eb55db6e(activityinstance);

    if(spawnmoment == activitymoment) {
      if(type == "Scriptable") {
        function_9dd7c4ff55eca947(activityinstance);
      } else {
        function_293783f421e3bdc0(activityinstance);
      }

      return;
    }

    if(destroymoment == activitymoment) {
      if(type == "GSCScript") {
        function_dd2abd81ef1b965d(activityinstance);
      }
    }
  }
}

function function_592fd3b0ebcfd2dc(activityinstance) {
  return activityinstance.var_d953047f1b4c7c9;
}

function function_451ffc1b7133042f(player) {
  foreach(marker in self.objectivemarkers) {
    if(marker.var_1a64187243779c27) {
      function_c32880b1943fa8ba([player], marker.id);

      if(marker.shouldpin) {
        function_8e26a7c882870c4([player], marker.id);
      }
    }
  }
}

function function_2d38888e45d6a28a(player) {
  foreach(marker in self.objectivemarkers) {
    if(marker.var_1a64187243779c27) {
      function_271c0af82f71d8b8([player], marker.id);

      if(marker.shouldpin) {
        function_5aade87a12c96e0d([player], marker.id);
      }
    }
  }
}

function function_1c5d0098478465a() {
  foreach(marker in self.objectivemarkers) {
    scripts\mp\objidpoolmanager::returnobjectiveid(marker.id);
  }

  self.objectivemarkers = [];
}

function function_c32880b1943fa8ba(players, markerid) {
  foreach(player in players) {
    objective_addclienttomask(markerid, player);
    objective_showtoplayersinmask(markerid);
    activitynexuslog("PLAYER ADDED TO MARKER VISIBILITY MASK:" + function_203add19f2f26253(markerid), @ "hash_ee2680c4a8804012", self, players);
  }
}

function function_271c0af82f71d8b8(players, markerid) {
  foreach(player in players) {
    objective_removeclientfrommask(markerid, player);
    activitynexuslog("PLAYER REMOVED FROM MARKER VISIBILITY MASK:" + function_203add19f2f26253(markerid), @ "hash_ee2680c4a8804012", self, players);
  }
}

function private function_8e26a7c882870c4(players, markerid) {
  foreach(player in players) {
    scripts\mp\objidpoolmanager::objective_pin_player(markerid, player);
  }
}

function private function_5aade87a12c96e0d(players, markerid) {
  foreach(player in players) {
    scripts\mp\objidpoolmanager::objective_unpin_player(markerid, player);
  }
}

function private function_9dd7c4ff55eca947(activityinstance) {
  var_4619ceba115b296 = function_aa0f1a318b382e70(activityinstance);
  origin = namespace_68dc261109a9503f::function_8988a4c89289d7f4(activityinstance);
  destroymoment = function_77041690eb55db6e(activityinstance);
  scriptable = namespace_779ebc650a9ef856::function_cb2e672e5fb4f3(activityinstance, var_4619ceba115b296, origin, destroymoment);
  var_d953047f1b4c7c9 = function_b75091dec6ad315a("Scriptable", scriptable);
  activityinstance.var_d953047f1b4c7c9 = var_d953047f1b4c7c9;
}

function private function_293783f421e3bdc0(activityinstance) {
  var_8ab21a9034ddd977 = function_aa0f1a318b382e70(activityinstance);
  var_637960f33380a722 = function_dff7dd2b4e3cf89e(activityinstance);
  shouldpin = function_1574d7fd9a2d904a(activityinstance);
  var_cbb2c370f6f0d524 = activityinstance function_f7680f0db96cad7b(var_8ab21a9034ddd977, shouldpin, var_637960f33380a722);
  origin = namespace_68dc261109a9503f::function_8988a4c89289d7f4(activityinstance);
  scripts\mp\objidpoolmanager::update_objective_position(var_cbb2c370f6f0d524, origin);
  var_d953047f1b4c7c9 = function_b75091dec6ad315a("GSCScript", var_cbb2c370f6f0d524);
  activityinstance.var_d953047f1b4c7c9 = var_d953047f1b4c7c9;
}

function private function_dd2abd81ef1b965d(activityinstance) {
  var_d953047f1b4c7c9 = function_592fd3b0ebcfd2dc(activityinstance);

  if(isDefined(var_d953047f1b4c7c9)) {
    activityinstance function_765b706dc170e214(var_d953047f1b4c7c9.objectivemarkerid);
  }
}

function private function_b75091dec6ad315a(var_9062a4b6d1047da9, var_d2471cfb79096bfe) {
  var_d953047f1b4c7c9 = spawnStruct();
  var_d953047f1b4c7c9.objectivemarkertype = var_9062a4b6d1047da9;

  if(var_9062a4b6d1047da9 == "Scriptable") {
    var_d953047f1b4c7c9.scriptable = var_d2471cfb79096bfe;
  } else {
    var_d953047f1b4c7c9.objectivemarkerid = var_d2471cfb79096bfe;
  }

  return var_d953047f1b4c7c9;
}

function private function_203add19f2f26253(markerid) {
  return " objective marker id: " + markerid;
}
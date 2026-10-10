/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4fa7e9e11630166c.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_2707474774db34b;
#using scripts\common\data_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_cfbb837b74e21e93;

function function_61cd287166c3f695(stringreference) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));
  activityinstance function_eefe3b65a6590ed2(stringreference, activityinstance.var_6c29f2fdb0054bbe);
}

function function_eefe3b65a6590ed2(stringreference, players) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));
  function_686af2a965066763(activityinstance, stringreference, players);
}

function function_641bc1548cff8210(stringreference, players) {
  function_686af2a965066763(undefined, stringreference, players);
}

function function_716949a1eeeb1f47() {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));
  activityinstance function_96517b0d8aacf068(activityinstance.var_6c29f2fdb0054bbe);
}

function function_96517b0d8aacf068(players) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));
  function_5ce919b476495152(players, activityinstance, "ui_br_objective_index", 0);
}

function function_b8b15f7f0820954e(players) {
  foreach(player in players) {
    player setclientomnvar("ui_br_objective_index", 0);
  }
}

function function_c661dba3e304266b(value) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));
  activityinstance function_5f6fd55a55ffbc6c(value, activityinstance.var_6c29f2fdb0054bbe);
}

function function_5f6fd55a55ffbc6c(value, players) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));

  var_3bc5bab0e50c10e3 = scripts\common\data_tracker::function_6a26856f16c6a207("<dev string:x1c>");

  if(istrue(var_3bc5bab0e50c10e3)) {
    var_5ce85f49892885d8 = namespace_68dc261109a9503f::function_297dc42ebf4f3b04(activityinstance, "<dev string:x1c>");
    var_5ce85f49892885d8 = tablelookuprownum("<dev string:x35>", 0, var_5ce85f49892885d8);
    var_999f08c4e99afaac = tablelookupbyrow("<dev string:x35>", var_5ce85f49892885d8, 10);
    var_aad88477a8d4a46f = tablelookupbyrow("<dev string:x35>", var_5ce85f49892885d8, 1);

    if(var_999f08c4e99afaac != "<dev string:x4b>") {
      assertmsg("<dev string:x50>" + "<dev string:x35>" + "<dev string:x7e>" + var_aad88477a8d4a46f + "<dev string:xa5>");
    }

    var_828020d43184936c = tablelookupbyrow("<dev string:x35>", var_5ce85f49892885d8, 9);

    if(isint(value) && var_828020d43184936c != "<dev string:xf8>") {
      assertmsg("<dev string:xfd>" + "<dev string:x35>" + "<dev string:x120>" + var_aad88477a8d4a46f + "<dev string:x147>");
    } else if(isfloat(value) && var_828020d43184936c != "<dev string:x199>") {
      assertmsg("<dev string:xfd>" + "<dev string:x35>" + "<dev string:x19e>" + var_aad88477a8d4a46f + "<dev string:x1c5>");
    } else if(isPlayer(value) && var_828020d43184936c != "<dev string:x214>") {
      assertmsg("<dev string:xfd>" + "<dev string:x35>" + "<dev string:x219>" + var_aad88477a8d4a46f + "<dev string:x240>");
    } else if(isstring(value) && var_828020d43184936c != "<dev string:x290>") {
      assertmsg("<dev string:xfd>" + "<dev string:x35>" + "<dev string:x295>" + var_aad88477a8d4a46f + "<dev string:x2bc>");
    }
  }

  function_5ce919b476495152(players, activityinstance, "ui_br_objective_param", value);
}

function function_474722293c221d5c(timeinseconds) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));
  activityinstance function_c1c25690399031a3(timeinseconds, activityinstance.var_6c29f2fdb0054bbe);
}

function function_c1c25690399031a3(timeinseconds, players) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));

  var_3bc5bab0e50c10e3 = scripts\common\data_tracker::function_6a26856f16c6a207("<dev string:x1c>");

  if(istrue(var_3bc5bab0e50c10e3)) {
    var_5ce85f49892885d8 = namespace_68dc261109a9503f::function_297dc42ebf4f3b04(activityinstance, "<dev string:x1c>");
    var_5ce85f49892885d8 = tablelookuprownum("<dev string:x35>", 0, var_5ce85f49892885d8);
    var_4d662194144d997f = tablelookupbyrow("<dev string:x35>", var_5ce85f49892885d8, 8);
    var_aad88477a8d4a46f = tablelookupbyrow("<dev string:x35>", var_5ce85f49892885d8, 1);

    if(var_4d662194144d997f != "<dev string:x4b>") {
      assertmsg("<dev string:x30c>" + "<dev string:x35>" + "<dev string:x7e>" + var_aad88477a8d4a46f + "<dev string:x32a>");
    }
  }

  var_ea2c1a117f714d0c = int(timeinseconds) * 1000;
  var_c7f1f3c8a79d424d = gettime() + var_ea2c1a117f714d0c;
  function_5ce919b476495152(players, activityinstance, "ui_br_objective_countdown_timer", var_c7f1f3c8a79d424d);
}

function function_f0361294db9d74a7(var_e953cfb99ec0d4ac, var_dea46a181189fa4b) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));
  activityinstance function_24d7e633e4a9c5c8(var_e953cfb99ec0d4ac, var_dea46a181189fa4b, activityinstance.var_6c29f2fdb0054bbe);
}

function function_24d7e633e4a9c5c8(var_e953cfb99ec0d4ac, var_dea46a181189fa4b, players) {
  activityinstance = self;
  assertex(namespace_68dc261109a9503f::isactivityinstance(activityinstance));

  if(isDefined(var_dea46a181189fa4b)) {
    function_5ce919b476495152(players, activityinstance, "ui_br_objective_progress_bar_threshold", var_dea46a181189fa4b, 0);
  }

  function_5ce919b476495152(players, activityinstance, "ui_br_objective_progress_bar", var_e953cfb99ec0d4ac, -1);
}

function private function_686af2a965066763(activityinstance, stringreference, players) {
  var_5ce85f49892885d8 = tablelookuprownum("ob/ob_missions.csv", 1, stringreference);
  var_f1a21b880815d306 = var_5ce85f49892885d8 != -1;

  if(var_f1a21b880815d306) {
    contractindexstring = tablelookupbyrow("ob/ob_missions.csv", var_5ce85f49892885d8, 0);
    contractindex = int(contractindexstring);

    if(isDefined(activityinstance) && namespace_68dc261109a9503f::isactivityinstance(activityinstance)) {
      function_5ce919b476495152(players, activityinstance, "ui_br_objective_index", contractindex, 0);
    } else {
      foreach(player in players) {
        player setclientomnvar("ui_br_objective_index", contractindex);
      }
    }

    return;
  }

  assertmsg("<dev string:x352>" + stringreference + "<dev string:x368>" + "<dev string:x35>" + "<dev string:x381>");
}
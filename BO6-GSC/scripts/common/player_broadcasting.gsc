/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\player_broadcasting.gsc
**************************************************/

#using scripts\common\conditional_container;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace player_broadcasting;

function function_ebe5e369860d93f6() {
  if(!isDefined(level.var_5852c84f1c0b0039)) {
    level.var_5852c84f1c0b0039 = [];
  }
}

function function_b316d063f57a67f3(broadcasttype, handofffunction) {
  if(!isDefined(level.var_5852c84f1c0b0039)) {
    level.var_5852c84f1c0b0039 = [];
  }

  level.var_5852c84f1c0b0039[broadcasttype] = handofffunction;
}

function broadcasttoplayer(player, broadcastinstance) {
  var_d71931fba5547b5f = function_d8bcf9b053be9ab1(player, broadcastinstance);

  if(!var_d71931fba5547b5f) {
    var_59725bb69a99432c = spawnStruct();
    var_59725bb69a99432c.player = player;
    var_59725bb69a99432c.broadcastinstance = broadcastinstance;
    var_cb48e3079f181a46 = broadcastinstance function_6dff0b7650fa500();
    playermetbroadcastconditionsfunc = utility::getsharedfunc(#"player_broadcasting", #"playermetbroadcastconditions");

    if(!isDefined(playermetbroadcastconditionsfunc)) {
      playermetbroadcastconditionsfunc = &function_22549deeebb67041;
    }

    if(isDefined(var_cb48e3079f181a46) && var_cb48e3079f181a46 > 0) {
      conditional_container::function_686ab16ee1028ef8(broadcastinstance, player, playermetbroadcastconditionsfunc, var_59725bb69a99432c, var_cb48e3079f181a46);
    } else {
      var_e7a882b03103ab91 = conditional_container::function_ac8003c33335a40f(broadcastinstance, player);

      if(var_e7a882b03103ab91) {
        [[playermetbroadcastconditionsfunc]](var_59725bb69a99432c);
      } else {
        function_7aef8e4e20174928(player, broadcastinstance, 0, "<dev string:x24>");
      }
    }

    return;
  }

  function_7aef8e4e20174928(player, broadcastinstance, 0, "<dev string:x66>");
}

function broadcasttoplayers(playerlist, broadcastinstance) {
  foreach(player in playerlist) {
    broadcasttoplayer(player, broadcastinstance);
  }
}

function function_5f83660de1065dc(player, broadcastinstancearray) {
  foreach(broadcastinstance in broadcastinstancearray) {
    broadcasttoplayer(player, broadcastinstance);
  }
}

function updatebroadcast(broadcastinstance) {
  foreach(player in level.players) {
    if(function_d8bcf9b053be9ab1(player, broadcastinstance)) {
      handoffbroadcast(player, broadcastinstance, 1);
    }
  }
}

function updatebroadcastarray(broadcastinstancearray) {
  foreach(broadcastinstance in broadcastinstancearray) {
    updatebroadcast(broadcastinstance);
  }
}

function function_4832a16037637d9f(player, broadcastinstance) {
  if(!function_d8bcf9b053be9ab1(player, broadcastinstance)) {
    function_7aef8e4e20174928(player, broadcastinstance, 2, "<dev string:x91>");

    return;
  }

  function_cd08c6800c536694(player, broadcastinstance);
  handoffbroadcast(player, broadcastinstance, 2);
}

function function_ae1c9688d4af6d10(player, broadcastinstancearray) {
  foreach(broadcastinstance in broadcastinstancearray) {
    function_4832a16037637d9f(player, broadcastinstance);
  }
}

function function_46b7385da4a5b6cb(broadcastinstance) {
  foreach(player in level.players) {
    if(function_d8bcf9b053be9ab1(player, broadcastinstance)) {
      handoffbroadcast(player, broadcastinstance, 2);
    }
  }
}

function function_9e4fbd57e6f5cc6a(playerlist, broadcastinstance) {
  foreach(player in playerlist) {
    function_4832a16037637d9f(player, broadcastinstance);
  }
}

function function_1db5bc1596f94873(broadcastinstance) {
  broadcasttoplayers(level.players, broadcastinstance);
}

function function_66ec8f084c39d4c4(broadcastorigin, maxdistancefromorigin, broadcastinstance) {
  foreach(player in level.players) {
    if(utility::playerwithindistance(player, broadcastorigin, maxdistancefromorigin)) {
      broadcasttoplayer(player, broadcastinstance);
    }
  }
}

function function_552fcfff4afff671(broadcasttype) {
  broadcastinstance = spawnStruct();
  broadcastinstance.var_ea770d85bcef8cd7 = 0;
  broadcastinstance.broadcasttype = broadcasttype;
  broadcastinstance.broadcastdataobjects = [];
  broadcastinstance.associateddatatracker = undefined;
  broadcastinstance.var_afe445f55d867ca3 = 1;
  broadcastinstance.var_f94565de1a503f00 = 0;

  if(!isDefined(level.broadcastuniqueid)) {
    level.broadcastuniqueid = 0;
  }

  broadcastinstance.uniqueid = level.broadcastuniqueid;
  broadcastinstance.groupid = broadcastinstance.uniqueid;
  level.broadcastuniqueid++;
  broadcastinstance.var_954da664048cda = [];
  broadcastinstance conditional_container::function_e235be9fe32422e8();
  return broadcastinstance;
}

function function_280e4798f9a5dd2(messagetext) {
  broadcastinstance = function_552fcfff4afff671("<dev string:xe3>");
  broadcastinstance.text = messagetext;
  return broadcastinstance;
}

function function_626c091782971df8(broadcastinstance) {
  return istrue(broadcastinstance.var_afe445f55d867ca3);
}

function function_aa63b6befa67f2b7() {
  return istrue(self.var_ea770d85bcef8cd7);
}

function function_242ee4b760cb7bf() {
  return self.broadcastdataobjects;
}

function getbroadcasttype() {
  assert(isDefined(self.broadcasttype), "<dev string:xec>");
  return self.broadcasttype;
}

function getbroadcastuniqueid() {
  return self.uniqueid;
}

function function_7ac3632c771b968d() {
  return self.groupid;
}

function function_6dff0b7650fa500() {
  return self.var_f94565de1a503f00;
}

function function_21198624b23fa66() {
  return self.associateddatatracker;
}

function function_f8ecc98eac1d300a(datatracker) {
  self.associateddatatracker = datatracker;
}

function function_961e9fbe7aa8742(var_cb48e3079f181a46) {
  self.var_f94565de1a503f00 = var_cb48e3079f181a46;
}

function function_d8bcf9b053be9ab1(player, broadcastinstance) {
  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  playerseen = broadcastinstance.var_954da664048cda[playerguid];
  return istrue(playerseen);
}

function handoffbroadcast(player, broadcastinstance, broadcastcommand) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x15a>" + broadcastinstance getbroadcastuniqueid() + "<dev string:x1bf>" + broadcastcommand);
    return;
  }

  broadcasttype = broadcastinstance getbroadcasttype();

  if(isDefined(broadcasttype)) {
    assert(isDefined(level.var_5852c84f1c0b0039[broadcasttype]), "<dev string:x1d3>");
    [[level.var_5852c84f1c0b0039[broadcasttype]]](player, broadcastinstance, broadcastcommand);

    function_6fd88d031932d802(player, broadcastinstance, broadcastcommand);
  }
}

function function_a1ec679e30382813(player, broadcastinstance) {
  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  broadcastinstance.var_954da664048cda[playerguid] = 1;
}

function private function_22549deeebb67041(var_59725bb69a99432c) {
  player = var_59725bb69a99432c.player;
  broadcastinstance = var_59725bb69a99432c.broadcastinstance;
  function_a1ec679e30382813(player, broadcastinstance);
  handoffbroadcast(player, broadcastinstance, 0);
}

function private function_cd08c6800c536694(player, broadcastinstance) {
  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  broadcastinstance.var_954da664048cda[playerguid] = 0;
}

function private function_6a22727d64d714cc(player, params) {
  return true;
}

function function_7880b6179d76efc0(broadcastinstance) {
  generalbroadcastinstance = "<dev string:x22a>" + broadcastinstance getbroadcasttype() + "<dev string:x240>" + broadcastinstance getbroadcastuniqueid();
  return generalbroadcastinstance;
}

function private function_c263c8628f26760d() {
  enableddvar = getdvarint(@ "hash_26b7e4a2ecc0df79", 0);
  return enableddvar != 0;
}

function private function_6fd88d031932d802(player, broadcastinstance, broadcastcommand) {
  if(!function_c263c8628f26760d()) {
    return;
  }

  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  iprintln(function_7d7a90479d04d7d3() + "<dev string:x250>" + "<dev string:x268>" + playerguid + function_7880b6179d76efc0(broadcastinstance) + function_eedd01cf1a24f6e9(broadcastcommand));
}

function private function_7aef8e4e20174928(player, broadcastinstance, broadcastcommand, details) {
  if(!function_c263c8628f26760d()) {
    return;
  }

  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  iprintln(function_7d7a90479d04d7d3() + "<dev string:x275>" + "<dev string:x268>" + playerguid + function_7880b6179d76efc0(broadcastinstance) + function_eedd01cf1a24f6e9(broadcastcommand) + "<dev string:x294>" + details);
}

function private function_eedd01cf1a24f6e9(broadcastcommand) {
  commandstring = "<dev string:x2a2>";

  if(broadcastcommand == 1) {
    commandstring = "<dev string:x2a9>";
  } else if(broadcastcommand == 2) {
    commandstring = "<dev string:x2b3>";
  }

  return "<dev string:x2bd>" + commandstring;
}

function private function_7d7a90479d04d7d3() {
  return "<dev string:x2d0>";
}

# /
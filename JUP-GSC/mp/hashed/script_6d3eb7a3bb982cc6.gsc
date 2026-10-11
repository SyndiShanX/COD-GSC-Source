/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6d3eb7a3bb982cc6.gsc
*************************************************/

#using script_24f248b33b79e48d;
#using script_41387eecc35b88bf;
#using script_6617e2f2bb62b52b;
#using script_72ef6b9f0cf1f55a;
#using scripts\common\data_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#namespace namespace_20c011482c0cdeb0;

function function_16fe68fcacc54f0f() {
  if(!function_ada0825249682644("string_messaging")) {
    function_90de31b2cbef19f9("string_messaging", "scripted_widget_objective_group");
  }

  if(!isDefined(self.var_92f4eecabdc55527)) {
    function_52eefbdaca62890f();
  }

  if(!isDefined(self.var_f950fdb9893b4448)) {
    function_5818764082f27b98();
  }

  if(!isDefined(self.var_10ef8425f61dad4c)) {
    function_472f3ec43b453640();
  }
}

function function_52eefbdaca62890f() {
  self.var_e606088079f4b1aa = [];
  self.var_92f4eecabdc55527 = [];

  for(i = 0; i < 2; i++) {
    toast = spawnStruct();
    toast.idx = i;
    display_idx = 6 + i;
    toast.omnvar_param = "objective_param_" + display_idx;
    toast.omnvar_data1 = "objective_count_" + display_idx;
    toast.omnvar_data2 = "objective_max_count_" + display_idx;
    toast.omnvar_state = "objective_state_" + display_idx;
    toast thread function_2d6129b5199a8578(self);
    self.var_e606088079f4b1aa = array_add(self.var_e606088079f4b1aa, toast);
  }
}

function function_472f3ec43b453640() {
  self.var_eb666c0aadcb83f = [];
  self.var_10ef8425f61dad4c = [];

  for(i = 0; i < 2; i++) {
    dialog = spawnStruct();
    dialog.idx = i;
    display_idx = 8 + i;
    dialog.omnvar_param = "objective_param_" + display_idx;
    dialog.omnvar_data1 = "objective_count_" + display_idx;
    dialog.omnvar_data2 = "objective_max_count_" + display_idx;
    dialog.omnvar_state = "objective_state_" + display_idx;
    dialog thread function_135c6d3761c72e5(self);
    self.var_eb666c0aadcb83f = array_add(self.var_eb666c0aadcb83f, dialog);
  }
}

function function_33b31258dfa4019e(broadcast, message) {
  var_7bf6ef44012436e7 = spawnStruct();
  var_7bf6ef44012436e7.uniqueid = broadcast getbroadcastuniqueid();

  if(isnumber(var_7bf6ef44012436e7.uniqueid)) {
    var_7bf6ef44012436e7.uniqueid = string(var_7bf6ef44012436e7.uniqueid);
  }

  var_7bf6ef44012436e7.groupid = broadcast function_178a0ef658e52420();

  if(isnumber(var_7bf6ef44012436e7.groupid)) {
    var_7bf6ef44012436e7.groupid = string(var_7bf6ef44012436e7.groupid);
  }

  message_priority = broadcast function_c0e15a98cb263ae6();
  var_7bf6ef44012436e7.priority = message_priority;
  var_7bf6ef44012436e7.group_priority = message_priority;
  var_7bf6ef44012436e7.param = function_2756e9e9dc98a709(message);
  var_e224abe1b8496ede = function_b683ad721a792a8e(message);
  message_style = var_e224abe1b8496ede.var_9c774b4866e33235;
  broadcast_style = function_4e3ccf5ebd81daea(message);

  if(broadcast_style == "StringMessagingUtil_Splash") {
    switch (message_style) {
      case #"hash_a30f8a4037eef549":
        var_7bf6ef44012436e7.state = "show_title_toast";
        break;
      case #"hash_176327485b96c4a9":
        var_7bf6ef44012436e7.state = "show_desc_toast";
        break;
      case #"hash_e2bf296211079750":
        var_7bf6ef44012436e7.state = "success";
        break;
      case #"hash_c70936445ab69671":
        var_7bf6ef44012436e7.state = "failure";
        break;
      default:
        var_7bf6ef44012436e7.state = "show_title_toast";
        break;
    }
  } else if(broadcast_style == "StringMessagingUtil_Dialog") {
    switch (message_style) {
      case #"hash_a30f8a4037eef549":
        var_7bf6ef44012436e7.state = "show_title_dialog";
        break;
      case #"hash_176327485b96c4a9":
        var_7bf6ef44012436e7.state = "show_desc_dialog";
        break;
      case #"hash_e2bf296211079750":
        var_7bf6ef44012436e7.state = "success";
        break;
      case #"hash_c70936445ab69671":
        var_7bf6ef44012436e7.state = "failure";
        break;
      default:
        var_7bf6ef44012436e7.state = "show_title_dialog";
        break;
    }
  } else {
    switch (message_style) {
      case #"hash_a30f8a4037eef549":
        var_7bf6ef44012436e7.state = "show_title";
        break;
      case #"hash_176327485b96c4a9":
        var_7bf6ef44012436e7.state = "show_desc";
        break;
      case #"hash_e2bf296211079750":
        var_7bf6ef44012436e7.state = "success";
        break;
      case #"hash_c70936445ab69671":
        var_7bf6ef44012436e7.state = "failure";
        break;
      default:
        var_7bf6ef44012436e7.state = "show_title";
        break;
    }
  }

  function_a089f504ca0b69(broadcast, message, var_7bf6ef44012436e7);
  return var_7bf6ef44012436e7;
}

function private function_a089f504ca0b69(broadcast, data_object, var_f2fbc144bdaf1629) {
  var_fba0765ddf2a220f = 0;
  var_2f0f46533ea736d6 = 0;

  for(var_949db43ec6f96c1e = function_684411bce1d1c8bc(broadcast, data_object, var_fba0765ddf2a220f); isDefined(var_949db43ec6f96c1e) && var_2f0f46533ea736d6 < 2; var_949db43ec6f96c1e = function_684411bce1d1c8bc(broadcast, data_object, var_fba0765ddf2a220f)) {
    if(var_949db43ec6f96c1e.type == "ProgressTracker") {
      var_5414a0c8b564c288 = var_949db43ec6f96c1e.value;
      progress_data = function_298a9e5ee57b3737(var_949db43ec6f96c1e.format, var_5414a0c8b564c288.startingprogressvalue, var_5414a0c8b564c288.currentprogressvalue, var_5414a0c8b564c288.finalprogressvalue);

      if(isDefined(progress_data[0])) {
        var_de55a99e4d89d8c4 = function_9b777cc810bb4b7f(var_f2fbc144bdaf1629, progress_data[0], "Integer", var_2f0f46533ea736d6);

        if(var_de55a99e4d89d8c4) {
          var_2f0f46533ea736d6++;
        }
      }

      if(isDefined(progress_data[1])) {
        var_de55a99e4d89d8c4 = function_9b777cc810bb4b7f(var_f2fbc144bdaf1629, progress_data[1], "Integer", var_2f0f46533ea736d6);

        if(var_de55a99e4d89d8c4) {
          var_2f0f46533ea736d6++;
        }
      }
    } else {
      var_de55a99e4d89d8c4 = function_9b777cc810bb4b7f(var_f2fbc144bdaf1629, var_949db43ec6f96c1e.value, var_949db43ec6f96c1e.type, var_2f0f46533ea736d6);

      if(var_de55a99e4d89d8c4) {
        var_2f0f46533ea736d6++;
      }
    }

    var_fba0765ddf2a220f++;
  }
}

function private function_9b777cc810bb4b7f(var_3dce99648a5de321, value, type, index) {
  if(index < 2) {
    if(type == "Integer" || type == "Float") {
      if(index == 0) {
        var_3dce99648a5de321.data1 = int(value);
        return true;
      } else if(index == 1) {
        var_3dce99648a5de321.data2 = int(value);
        return true;
      }
    }
  }

  return false;
}

function function_8aed3f7a425cb7f9(players, remove_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    foreach(message in player.var_92f4eecabdc55527) {
      if(remove_message.uniqueid == message.uniqueid) {
        message.display_time = 0;
      }
    }
  }
}

function function_cf9e932200fe6f5a(players, remove_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    foreach(message in player.var_10ef8425f61dad4c) {
      if(remove_message.uniqueid == message.uniqueid) {
        message.display_time = 0;
      }
    }
  }
}

function function_2d6129b5199a8578(player) {
  player endon("disconnect");

  while(isDefined(player) && isDefined(player.var_92f4eecabdc55527)) {
    if(player.var_92f4eecabdc55527.size <= self.idx || !isDefined(player.var_92f4eecabdc55527[self.idx])) {
      if(isDefined(self.param)) {
        player function_7bcc010e56714f9e("hidden", self.omnvar_state);
        self.param = undefined;
        self.state = undefined;
        self.data1 = undefined;
        self.data2 = undefined;
      }
    } else if(!isDefined(self.param) || player.var_92f4eecabdc55527[self.idx].is_new) {
      self.param = player.var_92f4eecabdc55527[self.idx].param;
      player function_c410a369495445aa(self.param, self.omnvar_param);
      self.state = player.var_92f4eecabdc55527[self.idx].state;
      player function_7bcc010e56714f9e(self.state, self.omnvar_state);

      if(isDefined(player.var_92f4eecabdc55527[self.idx].data1)) {
        self.data1 = player.var_92f4eecabdc55527[self.idx].data1;
        player function_b32b3c68376b18fd(self.data1, self.omnvar_data1);
      }

      if(isDefined(player.var_92f4eecabdc55527[self.idx].data2)) {
        self.data2 = player.var_92f4eecabdc55527[self.idx].data2;
        player function_b32b3c68376b18fd(self.data2, self.omnvar_data2);
      }

      player.var_92f4eecabdc55527[self.idx].is_new = 0;
    } else if(player.var_92f4eecabdc55527[self.idx].should_remove) {
      player.var_92f4eecabdc55527 = array_remove(player.var_92f4eecabdc55527, player.var_92f4eecabdc55527[self.idx]);
    } else {
      if(player.var_92f4eecabdc55527[self.idx].display_time > 0) {
        player.var_92f4eecabdc55527[self.idx].display_time -= 0.1;
      }

      if(self.param != player.var_92f4eecabdc55527[self.idx].param) {
        self.param = player.var_92f4eecabdc55527[self.idx].param;
        player function_c410a369495445aa(self.param, self.omnvar_param);
      }

      if(self.state != player.var_92f4eecabdc55527[self.idx].state) {
        self.state = player.var_92f4eecabdc55527[self.idx].state;
        player function_7bcc010e56714f9e(self.state, self.omnvar_state);
      }

      if(isDefined(player.var_92f4eecabdc55527[self.idx].data1)) {
        if(!isDefined(self.data1) || self.data1 != player.var_92f4eecabdc55527[self.idx].data1) {
          self.data1 = player.var_92f4eecabdc55527[self.idx].data1;
          player function_b32b3c68376b18fd(self.data1, self.omnvar_data1);
        }
      }

      if(isDefined(player.var_92f4eecabdc55527[self.idx].data2)) {
        if(!isDefined(self.data2) || self.data2 != player.var_92f4eecabdc55527[self.idx].data2) {
          self.data2 = player.var_92f4eecabdc55527[self.idx].data2;
          player function_b32b3c68376b18fd(self.data2, self.omnvar_data2);
        }
      }
    }

    if(isDefined(player.var_92f4eecabdc55527[self.idx])) {
      if(isDefined(player.var_92f4eecabdc55527[self.idx].display_time) && player.var_92f4eecabdc55527[self.idx].display_time <= 0) {
        if(self.state != "hidden") {
          player.var_92f4eecabdc55527[self.idx].state = "hidden";
          self.state = "hidden";
          player.var_92f4eecabdc55527[self.idx].display_time = 0.5;
          player function_7bcc010e56714f9e(self.state, self.omnvar_state);
        } else {
          player.var_92f4eecabdc55527[self.idx].should_remove = 1;
        }
      }
    }

    wait 0.1;
  }
}

function function_135c6d3761c72e5(player) {
  player endon("disconnect");

  while(isDefined(player) && isDefined(player.var_10ef8425f61dad4c)) {
    if(player.var_10ef8425f61dad4c.size <= self.idx || !isDefined(player.var_10ef8425f61dad4c[self.idx])) {
      if(isDefined(self.param)) {
        player function_7bcc010e56714f9e("hidden", self.omnvar_state);
        self.param = undefined;
        self.state = undefined;
        self.data1 = undefined;
        self.data2 = undefined;
      }
    } else if(!isDefined(self.param) || player.var_10ef8425f61dad4c[self.idx].is_new) {
      self.param = player.var_10ef8425f61dad4c[self.idx].param;
      player function_c410a369495445aa(self.param, self.omnvar_param);
      self.state = player.var_10ef8425f61dad4c[self.idx].state;
      player function_7bcc010e56714f9e(self.state, self.omnvar_state);

      if(isDefined(player.var_10ef8425f61dad4c[self.idx].data1)) {
        self.data1 = player.var_10ef8425f61dad4c[self.idx].data1;
        player function_b32b3c68376b18fd(self.data1, self.omnvar_data1);
      }

      if(isDefined(player.var_10ef8425f61dad4c[self.idx].data2)) {
        self.data2 = player.var_10ef8425f61dad4c[self.idx].data2;
        player function_b32b3c68376b18fd(self.data2, self.omnvar_data2);
      }

      player.var_10ef8425f61dad4c[self.idx].is_new = 0;
    } else if(player.var_10ef8425f61dad4c[self.idx].should_remove) {
      player.var_10ef8425f61dad4c = array_remove(player.var_10ef8425f61dad4c, player.var_10ef8425f61dad4c[self.idx]);
    } else {
      if(player.var_10ef8425f61dad4c[self.idx].display_time > 0) {
        player.var_10ef8425f61dad4c[self.idx].display_time -= 0.1;
      }

      if(self.param != player.var_10ef8425f61dad4c[self.idx].param) {
        self.param = player.var_10ef8425f61dad4c[self.idx].param;
        player function_c410a369495445aa(self.param, self.omnvar_param);
      }

      if(self.state != player.var_10ef8425f61dad4c[self.idx].state) {
        self.state = player.var_10ef8425f61dad4c[self.idx].state;
        player function_7bcc010e56714f9e(self.state, self.omnvar_state);
      }

      if(isDefined(player.var_10ef8425f61dad4c[self.idx].data1)) {
        if(!isDefined(self.data1) || self.data1 != player.var_10ef8425f61dad4c[self.idx].data1) {
          self.data1 = player.var_10ef8425f61dad4c[self.idx].data1;
          player function_b32b3c68376b18fd(self.data1, self.omnvar_data1);
        }
      }

      if(isDefined(player.var_10ef8425f61dad4c[self.idx].data2)) {
        if(!isDefined(self.data2) || self.data2 != player.var_10ef8425f61dad4c[self.idx].data2) {
          self.data2 = player.var_10ef8425f61dad4c[self.idx].data2;
          player function_b32b3c68376b18fd(self.data2, self.omnvar_data2);
        }
      }
    }

    if(isDefined(player.var_10ef8425f61dad4c[self.idx])) {
      if(isDefined(player.var_10ef8425f61dad4c[self.idx].display_time) && player.var_10ef8425f61dad4c[self.idx].display_time <= 0) {
        if(self.state != "hidden") {
          player.var_10ef8425f61dad4c[self.idx].state = "hidden";
          self.state = "hidden";
          player.var_10ef8425f61dad4c[self.idx].display_time = 0.5;
          player function_7bcc010e56714f9e(self.state, self.omnvar_state);
        } else {
          player.var_10ef8425f61dad4c[self.idx].should_remove = 1;
        }
      }
    }

    wait 0.1;
  }
}

function function_516fd8a6749c3726(players, splash_broadcast, broadcast_command) {
  broadcast_messages = splash_broadcast function_7437a8d48556e45e();

  for(message_id = 0; message_id < broadcast_messages.size; message_id++) {
    broadcast_message = broadcast_messages[message_id];
    new_message = function_33b31258dfa4019e(splash_broadcast, broadcast_message);
    new_message.uniqueid = splash_broadcast getbroadcastuniqueid() + "_messageId:_" + message_id;
    broadcast_style = function_4e3ccf5ebd81daea(broadcast_message);

    if(broadcast_style == "StringMessagingUtil_Splash") {
      if(broadcast_command == 2) {
        function_8aed3f7a425cb7f9(players, new_message);
      } else if(broadcast_command == 0) {
        function_90aa487b23e54e57(players, new_message);
      }

      continue;
    }

    if(broadcast_style == "StringMessagingUtil_Dialog") {
      if(broadcast_command == 2) {
        function_cf9e932200fe6f5a(players, new_message);
      } else if(broadcast_command == 0) {
        function_818b83330689fe30(players, new_message);
      }

      continue;
    }

    if(broadcast_style == "StringMessagingUtil_MinimapWidget") {
      if(broadcast_command == 0) {
        function_aadccf880d10d728(players, new_message);
        continue;
      }

      if(broadcast_command == 1) {
        function_f1ecaebb6fbfe630(players, new_message);
        continue;
      }

      if(broadcast_command == 2) {
        function_db2e4b8d29881d41(players, new_message);
      }
    }
  }
}

function function_90aa487b23e54e57(players, new_message) {
  if(!isarray(players)) {
    players = [players];
  }

  if(!isDefined(new_message.priority)) {
    new_message.priority = 999;
  }

  if(!isDefined(new_message.display_time)) {
    new_message.display_time = 12;
  }

  new_message.is_new = 1;
  new_message.should_remove = 0;

  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    if(!isDefined(player.var_92f4eecabdc55527)) {
      player function_16fe68fcacc54f0f();
    }

    msg_added = 0;

    for(i = 0; i < player.var_92f4eecabdc55527.size; i++) {
      if(new_message.priority < player.var_92f4eecabdc55527[i].priority) {
        player.var_92f4eecabdc55527 = array_insert(player.var_92f4eecabdc55527, new_message, i);
        message_added = 1;
        break;
      }
    }

    if(!msg_added) {
      player.var_92f4eecabdc55527 = array_add(player.var_92f4eecabdc55527, new_message);
    }

    if(player.var_92f4eecabdc55527.size > player.var_e606088079f4b1aa.size) {
      player.var_92f4eecabdc55527 = array_remove_index(player.var_92f4eecabdc55527, 0);
    }
  }
}

function function_818b83330689fe30(players, new_message) {
  if(!isarray(players)) {
    players = [players];
  }

  if(!isDefined(new_message.priority)) {
    new_message.priority = 999;
  }

  if(!isDefined(new_message.display_time)) {
    new_message.display_time = 12;
  }

  new_message.is_new = 1;
  new_message.should_remove = 0;

  foreach(player in players) {
    if(!isDefined(player.var_10ef8425f61dad4c)) {
      player function_16fe68fcacc54f0f();
    }

    msg_added = 0;

    for(i = 0; i < player.var_10ef8425f61dad4c.size; i++) {
      if(new_message.priority < player.var_10ef8425f61dad4c[i].priority) {
        player.var_10ef8425f61dad4c = array_insert(player.var_10ef8425f61dad4c, new_message, i);
        message_added = 1;
        break;
      }
    }

    if(!msg_added) {
      player.var_10ef8425f61dad4c = array_add(player.var_10ef8425f61dad4c, new_message);
    }

    if(player.var_10ef8425f61dad4c.size > player.var_eb666c0aadcb83f.size) {
      player.var_10ef8425f61dad4c = array_remove_index(player.var_10ef8425f61dad4c, 0);
    }
  }
}

function function_5818764082f27b98() {
  self.var_3f98b2e95a91cc7b = [];
  self.var_f950fdb9893b4448 = [];

  for(i = 0; i < 5; i++) {
    slot = spawnStruct();
    slot.idx = i;
    display_idx = 1 + i;
    slot.omnvar_param = "objective_param_" + display_idx;
    slot.omnvar_data1 = "objective_count_" + display_idx;
    slot.omnvar_data2 = "objective_max_count_" + display_idx;
    slot.omnvar_state = "objective_state_" + display_idx;
    slot.var_85ddfa37e9569787 = 0;
    slot.group_hidden = 0;
    slot thread function_d5f74832bcb9e4cd(self);
    self.var_3f98b2e95a91cc7b = array_add(self.var_3f98b2e95a91cc7b, slot);
  }
}

function function_d5f74832bcb9e4cd(player) {
  player endon("disconnect");

  while(isDefined(player) && isDefined(player.var_f950fdb9893b4448)) {
    self.var_85ddfa37e9569787 = function_752ef78bc0af677f(player);

    if(player.var_3f98b2e95a91cc7b.size - self.idx - 1 < self.var_85ddfa37e9569787) {
      if(isDefined(self.state) && self.state != "hidden") {
        self.state = "hidden";
        player function_7bcc010e56714f9e(self.state, self.omnvar_state);
      }
    } else if(player.var_f950fdb9893b4448.size <= self.idx || !isDefined(player.var_f950fdb9893b4448[self.idx])) {
      if(isDefined(self.param)) {
        player function_7bcc010e56714f9e("hidden", self.omnvar_state);
        self.param = undefined;
        self.state = undefined;
        self.data1 = undefined;
        self.data2 = undefined;
      }
    } else if(!isDefined(self.param) || player.var_f950fdb9893b4448[self.idx].is_new) {
      self.param = player.var_f950fdb9893b4448[self.idx].param;
      player function_c410a369495445aa(self.param, self.omnvar_param);
      self.state = player.var_f950fdb9893b4448[self.idx].state;
      player function_7bcc010e56714f9e(self.state, self.omnvar_state);

      if(isDefined(player.var_f950fdb9893b4448[self.idx].data1)) {
        self.data1 = player.var_f950fdb9893b4448[self.idx].data1;
        player function_b32b3c68376b18fd(self.data1, self.omnvar_data1);
      }

      if(isDefined(player.var_f950fdb9893b4448[self.idx].data2)) {
        self.data2 = player.var_f950fdb9893b4448[self.idx].data2;
        player function_b32b3c68376b18fd(self.data2, self.omnvar_data2);
      }

      player.var_f950fdb9893b4448[self.idx].is_new = 0;
    } else if(player.var_f950fdb9893b4448[self.idx].should_remove) {
      player.var_f950fdb9893b4448 = array_remove(player.var_f950fdb9893b4448, player.var_f950fdb9893b4448[self.idx]);
    } else {
      if(self.param != player.var_f950fdb9893b4448[self.idx].param) {
        self.param = player.var_f950fdb9893b4448[self.idx].param;
        player function_c410a369495445aa(self.param, self.omnvar_param);
      }

      if(self.state != player.var_f950fdb9893b4448[self.idx].state) {
        self.state = player.var_f950fdb9893b4448[self.idx].state;
        player function_7bcc010e56714f9e(self.state, self.omnvar_state);
      }

      if(isDefined(player.var_f950fdb9893b4448[self.idx].data1)) {
        if(!isDefined(self.data1) || self.data1 != player.var_f950fdb9893b4448[self.idx].data1) {
          self.data1 = player.var_f950fdb9893b4448[self.idx].data1;
          player function_b32b3c68376b18fd(self.data1, self.omnvar_data1);
        }
      }

      if(isDefined(player.var_f950fdb9893b4448[self.idx].data2)) {
        if(!isDefined(self.data2) || self.data2 != player.var_f950fdb9893b4448[self.idx].data2) {
          self.data2 = player.var_f950fdb9893b4448[self.idx].data2;
          player function_b32b3c68376b18fd(self.data2, self.omnvar_data2);
        }
      }
    }

    wait 0.1;
  }
}

function function_752ef78bc0af677f(player) {
  line_count = 0;

  for(i = player.var_f950fdb9893b4448.size - 1; i > self.idx; i--) {
    if(player.var_f950fdb9893b4448[i].groupid == player.var_f950fdb9893b4448[self.idx].groupid) {
      line_count += 1;
    }
  }

  return line_count;
}

function function_aadccf880d10d728(players, new_message) {
  if(!isarray(players)) {
    players = [players];
  }

  new_message.is_new = 1;
  new_message.should_remove = 0;

  if(!isDefined(new_message.priority)) {
    new_message.priority = 999;
  }

  if(!isDefined(new_message.group_priority)) {
    new_message.group_priority = 999;
  }

  foreach(player in players) {
    if(!isDefined(player.var_f950fdb9893b4448)) {
      player function_16fe68fcacc54f0f();
    }

    message_found = 0;
    message_added = 0;
    group_start = -1;

    for(i = 0; i < player.var_f950fdb9893b4448.size; i++) {
      if(player.var_f950fdb9893b4448[i].uniqueid == new_message.uniqueid) {
        message_found = 1;
      }

      if(player.var_f950fdb9893b4448[i].groupid == new_message.groupid && group_start < 0) {
        group_start = i;
      }
    }

    if(!message_found) {
      if(group_start >= 0) {
        for(i = group_start; i < player.var_f950fdb9893b4448.size; i++) {
          my_group = 0;

          if(player.var_f950fdb9893b4448[i].groupid == new_message.groupid) {
            my_group = 1;
          }

          if(my_group && player.var_f950fdb9893b4448[i].priority > new_message.priority) {
            player.var_f950fdb9893b4448 = array_insert(player.var_f950fdb9893b4448, new_message, i);
            message_added = 1;
            break;
          }

          if(!my_group) {
            player.var_f950fdb9893b4448 = array_insert(player.var_f950fdb9893b4448, new_message, i);
            message_added = 1;
            break;
          }
        }
      } else {
        for(i = 0; i < player.var_f950fdb9893b4448.size; i++) {
          if(player.var_f950fdb9893b4448[i].group_priority > new_message.group_priority) {
            player.var_f950fdb9893b4448 = array_insert(player.var_f950fdb9893b4448, new_message, i);
            message_added = 1;
            break;
          }
        }
      }

      if(!message_added) {
        player.var_f950fdb9893b4448 = array_add(player.var_f950fdb9893b4448, new_message);
      }
    }
  }
}

function function_db2e4b8d29881d41(players, remove_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    foreach(message in player.var_f950fdb9893b4448) {
      if(message.uniqueid == remove_message.uniqueid) {
        message.should_remove = 1;
      }
    }
  }
}

function function_f1ecaebb6fbfe630(players, update_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    message_found = 0;

    foreach(message in player.var_f950fdb9893b4448) {
      if(message.uniqueid == update_message.uniqueid) {
        message_found = 1;

        if(isDefined(update_message.param)) {
          if(message.param != update_message.param) {
            message.param = update_message.param;
          }
        }

        if(isDefined(update_message.state)) {
          if(message.state != update_message.state) {
            message.state = update_message.state;
          }
        }

        if(isDefined(update_message.data1)) {
          if(isDefined(message.data1) && message.data1 != update_message.data1) {
            message.data1 = update_message.data1;
          }
        }

        if(isDefined(update_message.data2)) {
          if(isDefined(message.data2) && message.data2 != update_message.data2) {
            message.data2 = update_message.data2;
          }
        }
      }
    }

    if(!message_found) {
      function_aadccf880d10d728(players, update_message);
    }
  }
}

function function_157ef4a3b9c1af16() {
  level.var_b3efbddcabfb0fe0 = [];
  level.var_b3efbddcabfb0fe0["create"] = &function_fb241036d1b1909d;
  level.var_b3efbddcabfb0fe0["update"] = &function_d4ef0f8a2c8f16bb;
  level.var_b3efbddcabfb0fe0["cleanup"] = &function_d037c4085e209ab2;
  function_8b5b2a3392fc7e2a("ActivityEnd", &function_d037c4085e209ab2);
}

function function_fb241036d1b1909d(player) {
  text = newclienthudelem(player);
  text.alpha = 0;
  text.alignx = "center";
  text.aligny = "top";
  text.fontscale = 3;
  text.x = 320;
  text.y = 115;
  text.color = (1, 0, 0);
  player.var_472652e4cdbaf2e7 = text;
  return text;
}

function function_d4ef0f8a2c8f16bb(player, time) {
  if(!isDefined(player.var_472652e4cdbaf2e7)) {
    return;
  }

  player.var_472652e4cdbaf2e7.alpha = 1;
  countdown_time = ceil(5 - time);

  if(!isDefined(player.var_472652e4cdbaf2e7.time_tracking) || countdown_time < player.var_472652e4cdbaf2e7.time_tracking) {
    player.var_472652e4cdbaf2e7.time_tracking = countdown_time;
    string_time = string(countdown_time);

    switch (string_time) {
      case #"hash_31100bbc01bd3230":
        player.var_472652e4cdbaf2e7 settext(&"JUP_OB_OBJECTIVES/LEAVE_WARNING_5_DESC");
        break;
      case #"hash_31100cbc01bd33c3":
        player.var_472652e4cdbaf2e7 settext(&"JUP_OB_OBJECTIVES/LEAVE_WARNING_4_DESC");
        break;
      case #"hash_311011bc01bd3ba2":
        player.var_472652e4cdbaf2e7 settext(&"JUP_OB_OBJECTIVES/LEAVE_WARNING_3_DESC");
        break;
      case #"hash_311012bc01bd3d35":
        player.var_472652e4cdbaf2e7 settext(&"JUP_OB_OBJECTIVES/LEAVE_WARNING_2_DESC");
        break;
      case #"hash_31100fbc01bd387c":
        player.var_472652e4cdbaf2e7 settext(&"JUP_OB_OBJECTIVES/LEAVE_WARNING_1_DESC");
        break;
      default:
        player.var_472652e4cdbaf2e7 settext(&"JUP_OB_OBJECTIVES/LEAVE_WARNING_1_DESC");
        break;
    }
  }
}

function function_d037c4085e209ab2(var_b381b0883bcd4847) {
  foreach(player in var_b381b0883bcd4847.playerlist) {
    if(isPlayer(player) && isDefined(player.var_472652e4cdbaf2e7)) {
      player.var_472652e4cdbaf2e7 destroy();
    }
  }
}

function function_fdbb9c9eed1c0159(stringreference, broadcaststyle, var_7a9374539cd2a477, priority) {
  broadcaststyle = default_to(broadcaststyle, "StringMessagingUtil_Splash");
  var_7a9374539cd2a477 = default_to(var_7a9374539cd2a477, "Title");
  priority = default_to(priority, "Medium");
  broadcast = function_3186d88f9311acf4("StringReference");
  broadcast.broadcastdefinition = spawnStruct();
  broadcast.broadcastdefinition.variant_object = spawnStruct();
  broadcast.broadcastdefinition.variant_object.priority = priority;
  broadcastdataobject = spawnStruct();
  broadcastdataobject.variant_object = spawnStruct();
  broadcastdataobject.variant_object.stringreference = stringreference;
  broadcastdataobject.variant_object.stylesettings = [];
  broadcastdataobject.variant_object.stylesettings[0] = spawnStruct();
  broadcastdataobject.variant_object.stylesettings[0].variant_object = spawnStruct();
  broadcastdataobject.variant_object.stylesettings[0].variant_object.broadcaststyle = broadcaststyle;
  broadcastdataobject.variant_object.stylesettings[0].variant_object.var_9c774b4866e33235 = var_7a9374539cd2a477;
  broadcast.broadcastdataobjects[0] = broadcastdataobject;
  return broadcast;
}

function function_c410a369495445aa(param, omnvar) {
  function_af4f62f0f944a8f1("scripted_widget_objective_text", param, omnvar);
}

function function_7bcc010e56714f9e(state, omnvar) {
  function_d28fa5295a04d555("scripted_widget_objective_text", state, omnvar);
}

function function_b32b3c68376b18fd(data, omnvar) {
  function_b52897e8afbb0968("scripted_widget_objective_text", data, omnvar);
}
/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_7df192c4714a34bb.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_4e1f1a7ef824ddd5;
#using scripts\common\player_broadcasting;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace namespace_c16c7425341147cd;

function function_50672487530eb076() {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!hud_management::function_48c98ea9a4f0da89("[-Is\xf8\x81\xa5{\xbf}\x03H\f\xcbyi")) {
    hud_management::function_35924dfcb78711f4("[-Is\xf8\x81\xa5{\xbf}\x03H\f\xcbyi", "7\xd8\x93\xb4\x0e\xe8Y\x8c\xebwK\x91\xec\xac\x1d\xbe\xdb\x13\xd4Y\xb1:\xb4gY\xfa\xb3N\xdb\xae\a");
  }

  if(!isDefined(self.var_d135226fb89b5d5e)) {
    function_5ea4314b35befa62();
  }

  if(!isDefined(self.var_79dc3da9a8aceb01)) {
    function_cf0548c4ecaa24b5();
  }

  if(!isDefined(self.var_c61967d9534ee269)) {
    function_186dccca712f2b69();
  }
}

function function_5ea4314b35befa62() {
  self.var_acd4cfafe4b338a7 = [];
  self.var_d135226fb89b5d5e = [];

  for(i = 0; i < 2; i++) {
    toast = spawnStruct();
    toast.idx = i;
    display_idx = 6 + i;
    toast.omnvar_param = "`V\x9cl-B\n\x81\xdecW\xe8\xd2\xee\xa2A" + display_idx;
    toast.omnvar_data1 = "\x87\xa3\x89`\xba\x1b#\bU\x84{\xde\xd3{\xb1\xc3" + display_idx;
    toast.omnvar_data2 = "mUiK\xd1\xc5\x98\b\x1b\x9f\xdcCn}O\x95\xac\x92\xde[" + display_idx;
    toast.omnvar_state = "474E\x0e\xd6P\xca\xb7\x9f\x8dc\xc8;6f" + display_idx;
    toast thread function_1557670ec0d115f5(self);
    self.var_acd4cfafe4b338a7[self.var_acd4cfafe4b338a7.size] = toast;
  }
}

function function_186dccca712f2b69() {
  self.var_e78d66a6f0d0964a = [];
  self.var_c61967d9534ee269 = [];

  for(i = 0; i < 2; i++) {
    dialog = spawnStruct();
    dialog.idx = i;
    display_idx = 8 + i;
    dialog.omnvar_param = "`V\x9cl-B\n\x81\xdecW\xe8\xd2\xee\xa2A" + display_idx;
    dialog.omnvar_data1 = "\x87\xa3\x89`\xba\x1b#\bU\x84{\xde\xd3{\xb1\xc3" + display_idx;
    dialog.omnvar_data2 = "mUiK\xd1\xc5\x98\b\x1b\x9f\xdcCn}O\x95\xac\x92\xde[" + display_idx;
    dialog.omnvar_state = "474E\x0e\xd6P\xca\xb7\x9f\x8dc\xc8;6f" + display_idx;
    dialog thread function_2b317acf3029b0a8(self);
    self.var_e78d66a6f0d0964a[self.var_e78d66a6f0d0964a.size] = dialog;
  }
}

function function_1283ad2a7f9720df(broadcast, message) {
  var_cf7a66ad689d736a = spawnStruct();
  var_cf7a66ad689d736a.uniqueid = broadcast player_broadcasting::getbroadcastuniqueid();

  if(isnumber(var_cf7a66ad689d736a.uniqueid)) {
    var_cf7a66ad689d736a.uniqueid = utility::string(var_cf7a66ad689d736a.uniqueid);
  }

  var_cf7a66ad689d736a.groupid = broadcast player_broadcasting::function_7ac3632c771b968d();

  if(isnumber(var_cf7a66ad689d736a.groupid)) {
    var_cf7a66ad689d736a.groupid = utility::string(var_cf7a66ad689d736a.groupid);
  }

  message_priority = broadcast namespace_59b081b19a436abb::function_8bee93cd57209ba3();
  var_cf7a66ad689d736a.priority = message_priority;
  var_cf7a66ad689d736a.group_priority = message_priority;
  var_cf7a66ad689d736a.param = namespace_59b081b19a436abb::function_763987466ce76d78(message);
  var_74183fdf701a836f = namespace_59b081b19a436abb::function_637235bbeb1edd3(message);
  message_style = var_74183fdf701a836f.var_80b03a962e2a5ffc;
  broadcast_style = namespace_59b081b19a436abb::function_263bfc890cd94533(message);

  if(broadcast_style == "j\xa3r\xa5\xb9;\xa6+\xcd\xdc\v\x9d-n\xec\xaa\xd1i\x8d\xbe\xa9p\xb1,\xcd\xa1") {
    switch (message_style) {
      case #"hash_a30f8a4037eef549":
        var_cf7a66ad689d736a.state = "8\x1e\xdbn\xaf\x95Y\xd9\x9f\xd4K\x8e\xb7sh\xed";
        break;
      case #"hash_176327485b96c4a9":
        var_cf7a66ad689d736a.state = "pZ\xd4\x95\x97\xe9I\x93\x1a\xcf\x1d\xc6\xa6\xc8\t";
        break;
      case #"hash_e2bf296211079750":
        var_cf7a66ad689d736a.state = "\xe6]66\x95\xb97";
        break;
      case #"hash_c70936445ab69671":
        var_cf7a66ad689d736a.state = "+\xf80\x1co\xe0_";
        break;
      default:
        var_cf7a66ad689d736a.state = "8\x1e\xdbn\xaf\x95Y\xd9\x9f\xd4K\x8e\xb7sh\xed";
        break;
    }
  } else if(broadcast_style == "j\a8j#\x95nUw\x1bM\xc6A\xc9\x90^\x16\xd1\xaa\xd4\x87[,Ph\x17") {
    switch (message_style) {
      case #"hash_a30f8a4037eef549":
        var_cf7a66ad689d736a.state = "\x94\x98\x9bl\xbb\xb7y\xa5\x8ar\x11\xd6\xea\x94\xec\xb9\xfc";
        break;
      case #"hash_176327485b96c4a9":
        var_cf7a66ad689d736a.state = "oM\f0yH'\nt\xd4\xc0*tI\xf9\xf3";
        break;
      case #"hash_e2bf296211079750":
        var_cf7a66ad689d736a.state = "\xe6]66\x95\xb97";
        break;
      case #"hash_c70936445ab69671":
        var_cf7a66ad689d736a.state = "+\xf80\x1co\xe0_";
        break;
      default:
        var_cf7a66ad689d736a.state = "\x94\x98\x9bl\xbb\xb7y\xa5\x8ar\x11\xd6\xea\x94\xec\xb9\xfc";
        break;
    }
  } else {
    switch (message_style) {
      case #"hash_a30f8a4037eef549":
        var_cf7a66ad689d736a.state = "\xf1K \xb2{\x1a\x1bYi\x03";
        break;
      case #"hash_176327485b96c4a9":
        var_cf7a66ad689d736a.state = "~~\xe8w9px\xd8\x9b";
        break;
      case #"hash_e2bf296211079750":
        var_cf7a66ad689d736a.state = "\xe6]66\x95\xb97";
        break;
      case #"hash_c70936445ab69671":
        var_cf7a66ad689d736a.state = "+\xf80\x1co\xe0_";
        break;
      default:
        var_cf7a66ad689d736a.state = "\xf1K \xb2{\x1a\x1bYi\x03";
        break;
    }
  }

  function_3189937c66627174(broadcast, message, var_cf7a66ad689d736a);
  return var_cf7a66ad689d736a;
}

function private function_3189937c66627174(broadcast, data_object, var_21116e0a4308f5ac) {
  var_e0bf98efa2e5226 = 0;
  var_a5bc7cebc43e6c37 = 0;

  for(var_4aec629fced68273 = namespace_59b081b19a436abb::function_9dcfbc1e2bb032c5(broadcast, data_object, var_e0bf98efa2e5226); isDefined(var_4aec629fced68273) && var_a5bc7cebc43e6c37 < 2; var_4aec629fced68273 = namespace_59b081b19a436abb::function_9dcfbc1e2bb032c5(broadcast, data_object, var_e0bf98efa2e5226)) {
    if(var_4aec629fced68273.type == "gvA@\xe7\xf3\tO\x9e\x82\x94gjD3") {
      var_f327c42642ddc581 = var_4aec629fced68273.value;
      progress_data = namespace_59b081b19a436abb::function_a7a2f1c10488d00e(var_4aec629fced68273.format, var_f327c42642ddc581.startingprogressvalue, var_f327c42642ddc581.currentprogressvalue, var_f327c42642ddc581.finalprogressvalue);

      if(isDefined(progress_data[0])) {
        var_65aec05a6bfb965d = function_e5dab02b41d0e946(var_21116e0a4308f5ac, progress_data[0], "D*\x17-c\xf8\xc7", var_a5bc7cebc43e6c37);

        if(var_65aec05a6bfb965d) {
          var_a5bc7cebc43e6c37++;
        }
      }

      if(isDefined(progress_data[1])) {
        var_65aec05a6bfb965d = function_e5dab02b41d0e946(var_21116e0a4308f5ac, progress_data[1], "D*\x17-c\xf8\xc7", var_a5bc7cebc43e6c37);

        if(var_65aec05a6bfb965d) {
          var_a5bc7cebc43e6c37++;
        }
      }
    } else {
      var_65aec05a6bfb965d = function_e5dab02b41d0e946(var_21116e0a4308f5ac, var_4aec629fced68273.value, var_4aec629fced68273.type, var_a5bc7cebc43e6c37);

      if(var_65aec05a6bfb965d) {
        var_a5bc7cebc43e6c37++;
      }
    }

    var_e0bf98efa2e5226++;
  }
}

function private function_e5dab02b41d0e946(var_480eef80a1d00f14, value, type, index) {
  if(index < 2) {
    if(type == "D*\x17-c\xf8\xc7" || type == "\xbe\x93\xa9\aw") {
      if(index == 0) {
        var_480eef80a1d00f14.data1 = int(value);
        return true;
      } else if(index == 1) {
        var_480eef80a1d00f14.data2 = int(value);
        return true;
      }
    }
  }

  return false;
}

function function_4b225d7aed9fe758(players, remove_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    foreach(message in player.var_d135226fb89b5d5e) {
      if(remove_message.uniqueid == message.uniqueid) {
        message.display_time = 0;
      }
    }
  }
}

function function_da69cfa5b38a06af(players, remove_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    foreach(message in player.var_c61967d9534ee269) {
      if(remove_message.uniqueid == message.uniqueid) {
        message.display_time = 0;
      }
    }
  }
}

function function_1557670ec0d115f5(player) {
  player endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  while(isDefined(player) && isDefined(player.var_d135226fb89b5d5e)) {
    if(player.var_d135226fb89b5d5e.size <= self.idx || !isDefined(player.var_d135226fb89b5d5e[self.idx])) {
      if(isDefined(self.param)) {
        player function_cea5b687d7229897("\xf8VZW\xd3\xad", self.omnvar_state);
        self.param = undefined;
        self.state = undefined;
        self.data1 = undefined;
        self.data2 = undefined;
      }
    } else if(!isDefined(self.param) || player.var_d135226fb89b5d5e[self.idx].is_new) {
      self.param = player.var_d135226fb89b5d5e[self.idx].param;
      player function_55aea3f98fe5ec3(self.param, self.omnvar_param);
      self.state = player.var_d135226fb89b5d5e[self.idx].state;
      player function_cea5b687d7229897(self.state, self.omnvar_state);

      if(isDefined(player.var_d135226fb89b5d5e[self.idx].data1)) {
        self.data1 = player.var_d135226fb89b5d5e[self.idx].data1;
        player function_9f60260e8537084c(self.data1, self.omnvar_data1);
      }

      if(isDefined(player.var_d135226fb89b5d5e[self.idx].data2)) {
        self.data2 = player.var_d135226fb89b5d5e[self.idx].data2;
        player function_9f60260e8537084c(self.data2, self.omnvar_data2);
      }

      player.var_d135226fb89b5d5e[self.idx].is_new = 0;
    } else if(player.var_d135226fb89b5d5e[self.idx].should_remove) {
      player.var_d135226fb89b5d5e = arrayremove(player.var_d135226fb89b5d5e, player.var_d135226fb89b5d5e[self.idx]);
    } else {
      if(player.var_d135226fb89b5d5e[self.idx].display_time > 0) {
        player.var_d135226fb89b5d5e[self.idx].display_time -= 0.1;
      }

      if(self.param != player.var_d135226fb89b5d5e[self.idx].param) {
        self.param = player.var_d135226fb89b5d5e[self.idx].param;
        player function_55aea3f98fe5ec3(self.param, self.omnvar_param);
      }

      if(self.state != player.var_d135226fb89b5d5e[self.idx].state) {
        self.state = player.var_d135226fb89b5d5e[self.idx].state;
        player function_cea5b687d7229897(self.state, self.omnvar_state);
      }

      if(isDefined(player.var_d135226fb89b5d5e[self.idx].data1)) {
        if(!isDefined(self.data1) || self.data1 != player.var_d135226fb89b5d5e[self.idx].data1) {
          self.data1 = player.var_d135226fb89b5d5e[self.idx].data1;
          player function_9f60260e8537084c(self.data1, self.omnvar_data1);
        }
      }

      if(isDefined(player.var_d135226fb89b5d5e[self.idx].data2)) {
        if(!isDefined(self.data2) || self.data2 != player.var_d135226fb89b5d5e[self.idx].data2) {
          self.data2 = player.var_d135226fb89b5d5e[self.idx].data2;
          player function_9f60260e8537084c(self.data2, self.omnvar_data2);
        }
      }
    }

    if(isDefined(player.var_d135226fb89b5d5e[self.idx])) {
      if(isDefined(player.var_d135226fb89b5d5e[self.idx].display_time) && player.var_d135226fb89b5d5e[self.idx].display_time <= 0) {
        if(self.state != "\xf8VZW\xd3\xad") {
          player.var_d135226fb89b5d5e[self.idx].state = "\xf8VZW\xd3\xad";
          self.state = "\xf8VZW\xd3\xad";
          player.var_d135226fb89b5d5e[self.idx].display_time = 0.5;
          player function_cea5b687d7229897(self.state, self.omnvar_state);
        } else {
          player.var_d135226fb89b5d5e[self.idx].should_remove = 1;
        }
      }
    }

    wait 0.1;
  }
}

function function_2b317acf3029b0a8(player) {
  player endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  while(isDefined(player) && isDefined(player.var_c61967d9534ee269)) {
    if(player.var_c61967d9534ee269.size <= self.idx || !isDefined(player.var_c61967d9534ee269[self.idx])) {
      if(isDefined(self.param)) {
        player function_cea5b687d7229897("\xf8VZW\xd3\xad", self.omnvar_state);
        self.param = undefined;
        self.state = undefined;
        self.data1 = undefined;
        self.data2 = undefined;
      }
    } else if(!isDefined(self.param) || player.var_c61967d9534ee269[self.idx].is_new) {
      self.param = player.var_c61967d9534ee269[self.idx].param;
      player function_55aea3f98fe5ec3(self.param, self.omnvar_param);
      self.state = player.var_c61967d9534ee269[self.idx].state;
      player function_cea5b687d7229897(self.state, self.omnvar_state);

      if(isDefined(player.var_c61967d9534ee269[self.idx].data1)) {
        self.data1 = player.var_c61967d9534ee269[self.idx].data1;
        player function_9f60260e8537084c(self.data1, self.omnvar_data1);
      }

      if(isDefined(player.var_c61967d9534ee269[self.idx].data2)) {
        self.data2 = player.var_c61967d9534ee269[self.idx].data2;
        player function_9f60260e8537084c(self.data2, self.omnvar_data2);
      }

      player.var_c61967d9534ee269[self.idx].is_new = 0;
    } else if(player.var_c61967d9534ee269[self.idx].should_remove) {
      player.var_c61967d9534ee269 = arrayremove(player.var_c61967d9534ee269, player.var_c61967d9534ee269[self.idx]);
    } else {
      if(player.var_c61967d9534ee269[self.idx].display_time > 0) {
        player.var_c61967d9534ee269[self.idx].display_time -= 0.1;
      }

      if(self.param != player.var_c61967d9534ee269[self.idx].param) {
        self.param = player.var_c61967d9534ee269[self.idx].param;
        player function_55aea3f98fe5ec3(self.param, self.omnvar_param);
      }

      if(self.state != player.var_c61967d9534ee269[self.idx].state) {
        self.state = player.var_c61967d9534ee269[self.idx].state;
        player function_cea5b687d7229897(self.state, self.omnvar_state);
      }

      if(isDefined(player.var_c61967d9534ee269[self.idx].data1)) {
        if(!isDefined(self.data1) || self.data1 != player.var_c61967d9534ee269[self.idx].data1) {
          self.data1 = player.var_c61967d9534ee269[self.idx].data1;
          player function_9f60260e8537084c(self.data1, self.omnvar_data1);
        }
      }

      if(isDefined(player.var_c61967d9534ee269[self.idx].data2)) {
        if(!isDefined(self.data2) || self.data2 != player.var_c61967d9534ee269[self.idx].data2) {
          self.data2 = player.var_c61967d9534ee269[self.idx].data2;
          player function_9f60260e8537084c(self.data2, self.omnvar_data2);
        }
      }
    }

    if(isDefined(player.var_c61967d9534ee269[self.idx])) {
      if(isDefined(player.var_c61967d9534ee269[self.idx].display_time) && player.var_c61967d9534ee269[self.idx].display_time <= 0) {
        if(self.state != "\xf8VZW\xd3\xad") {
          player.var_c61967d9534ee269[self.idx].state = "\xf8VZW\xd3\xad";
          self.state = "\xf8VZW\xd3\xad";
          player.var_c61967d9534ee269[self.idx].display_time = 0.5;
          player function_cea5b687d7229897(self.state, self.omnvar_state);
        } else {
          player.var_c61967d9534ee269[self.idx].should_remove = 1;
        }
      }
    }

    wait 0.1;
  }
}

function function_e3bfdf803348071b(players, splash_broadcast, broadcast_command) {
  broadcast_messages = splash_broadcast player_broadcasting::function_242ee4b760cb7bf();

  for(message_id = 0; message_id < broadcast_messages.size; message_id++) {
    broadcast_message = broadcast_messages[message_id];
    new_message = function_1283ad2a7f9720df(splash_broadcast, broadcast_message);
    new_message.uniqueid = splash_broadcast player_broadcasting::getbroadcastuniqueid() + "\xa8\x13Jb5\xaf\xfc\xda\x8a\x18Q)" + message_id;
    broadcast_style = namespace_59b081b19a436abb::function_263bfc890cd94533(broadcast_message);

    if(broadcast_style == "j\xa3r\xa5\xb9;\xa6+\xcd\xdc\v\x9d-n\xec\xaa\xd1i\x8d\xbe\xa9p\xb1,\xcd\xa1") {
      if(broadcast_command == 2) {
        function_4b225d7aed9fe758(players, new_message);
      } else if(broadcast_command == 0) {
        function_789aa79aa298248a(players, new_message);
      }

      continue;
    }

    if(broadcast_style == "j\a8j#\x95nUw\x1bM\xc6A\xc9\x90^\x16\xd1\xaa\xd4\x87[,Ph\x17") {
      if(broadcast_command == 2) {
        function_da69cfa5b38a06af(players, new_message);
      } else if(broadcast_command == 0) {
        function_7e14bed58775ab9(players, new_message);
      }

      continue;
    }

    if(broadcast_style == "\x93H\xea;\xc81>Ej\xf6\xe2C\x91KwQ\x01\xf0(\x10XQ\xb3\xbd<\xf8\xf2l\x89\xa2c\xc4\xc4") {
      if(broadcast_command == 0) {
        function_89c92a32c10a068d(players, new_message);
        continue;
      }

      if(broadcast_command == 1) {
        function_6167f12f7754c099(players, new_message);
        continue;
      }

      if(broadcast_command == 2) {
        function_4c0b6929652fddc0(players, new_message);
      }
    }
  }
}

function function_789aa79aa298248a(players, new_message) {
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
    if(!isDefined(player.var_d135226fb89b5d5e)) {
      player function_50672487530eb076();
    }

    msg_added = 0;

    for(i = 0; i < player.var_d135226fb89b5d5e.size; i++) {
      if(new_message.priority < player.var_d135226fb89b5d5e[i].priority) {
        player.var_d135226fb89b5d5e = utility::array_insert(player.var_d135226fb89b5d5e, new_message, i);
        message_added = 1;
        break;
      }
    }

    if(!msg_added) {
      player.var_d135226fb89b5d5e[player.var_d135226fb89b5d5e.size] = new_message;
    }

    if(player.var_d135226fb89b5d5e.size > player.var_acd4cfafe4b338a7.size) {
      player.var_d135226fb89b5d5e = utility::array_remove_index(player.var_d135226fb89b5d5e, 0);
    }
  }
}

function function_7e14bed58775ab9(players, new_message) {
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
    if(!isDefined(player.var_c61967d9534ee269)) {
      player function_50672487530eb076();
    }

    msg_added = 0;

    for(i = 0; i < player.var_c61967d9534ee269.size; i++) {
      if(new_message.priority < player.var_c61967d9534ee269[i].priority) {
        player.var_c61967d9534ee269 = utility::array_insert(player.var_c61967d9534ee269, new_message, i);
        message_added = 1;
        break;
      }
    }

    if(!msg_added) {
      player.var_c61967d9534ee269[player.var_c61967d9534ee269.size] = new_message;
    }

    if(player.var_c61967d9534ee269.size > player.var_e78d66a6f0d0964a.size) {
      player.var_c61967d9534ee269 = utility::array_remove_index(player.var_c61967d9534ee269, 0);
    }
  }
}

function function_cf0548c4ecaa24b5() {
  self.var_959bc51f6366352 = [];
  self.var_79dc3da9a8aceb01 = [];

  for(i = 0; i < 5; i++) {
    slot = spawnStruct();
    slot.idx = i;
    display_idx = 1 + i;
    slot.omnvar_param = "`V\x9cl-B\n\x81\xdecW\xe8\xd2\xee\xa2A" + display_idx;
    slot.omnvar_data1 = "\x87\xa3\x89`\xba\x1b#\bU\x84{\xde\xd3{\xb1\xc3" + display_idx;
    slot.omnvar_data2 = "mUiK\xd1\xc5\x98\b\x1b\x9f\xdcCn}O\x95\xac\x92\xde[" + display_idx;
    slot.omnvar_state = "474E\x0e\xd6P\xca\xb7\x9f\x8dc\xc8;6f" + display_idx;
    slot.var_792a034401b45ae2 = 0;
    slot.group_hidden = 0;
    slot thread function_29f9502a43044b74(self);
    self.var_959bc51f6366352[self.var_959bc51f6366352.size] = slot;
  }
}

function function_29f9502a43044b74(player) {
  player endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  while(isDefined(player) && isDefined(player.var_79dc3da9a8aceb01)) {
    self.var_792a034401b45ae2 = function_be1b4547d4875076(player);

    if(player.var_959bc51f6366352.size - self.idx - 1 < self.var_792a034401b45ae2) {
      if(isDefined(self.state) && self.state != "\xf8VZW\xd3\xad") {
        self.state = "\xf8VZW\xd3\xad";
        player function_cea5b687d7229897(self.state, self.omnvar_state);
      }
    } else if(player.var_79dc3da9a8aceb01.size <= self.idx || !isDefined(player.var_79dc3da9a8aceb01[self.idx])) {
      if(isDefined(self.param)) {
        player function_cea5b687d7229897("\xf8VZW\xd3\xad", self.omnvar_state);
        self.param = undefined;
        self.state = undefined;
        self.data1 = undefined;
        self.data2 = undefined;
      }
    } else if(!isDefined(self.param) || player.var_79dc3da9a8aceb01[self.idx].is_new) {
      self.param = player.var_79dc3da9a8aceb01[self.idx].param;
      player function_55aea3f98fe5ec3(self.param, self.omnvar_param);
      self.state = player.var_79dc3da9a8aceb01[self.idx].state;
      player function_cea5b687d7229897(self.state, self.omnvar_state);

      if(isDefined(player.var_79dc3da9a8aceb01[self.idx].data1)) {
        self.data1 = player.var_79dc3da9a8aceb01[self.idx].data1;
        player function_9f60260e8537084c(self.data1, self.omnvar_data1);
      }

      if(isDefined(player.var_79dc3da9a8aceb01[self.idx].data2)) {
        self.data2 = player.var_79dc3da9a8aceb01[self.idx].data2;
        player function_9f60260e8537084c(self.data2, self.omnvar_data2);
      }

      player.var_79dc3da9a8aceb01[self.idx].is_new = 0;
    } else if(player.var_79dc3da9a8aceb01[self.idx].should_remove) {
      player.var_79dc3da9a8aceb01 = arrayremove(player.var_79dc3da9a8aceb01, player.var_79dc3da9a8aceb01[self.idx]);
    } else {
      if(self.param != player.var_79dc3da9a8aceb01[self.idx].param) {
        self.param = player.var_79dc3da9a8aceb01[self.idx].param;
        player function_55aea3f98fe5ec3(self.param, self.omnvar_param);
      }

      if(self.state != player.var_79dc3da9a8aceb01[self.idx].state) {
        self.state = player.var_79dc3da9a8aceb01[self.idx].state;
        player function_cea5b687d7229897(self.state, self.omnvar_state);
      }

      if(isDefined(player.var_79dc3da9a8aceb01[self.idx].data1)) {
        if(!isDefined(self.data1) || self.data1 != player.var_79dc3da9a8aceb01[self.idx].data1) {
          self.data1 = player.var_79dc3da9a8aceb01[self.idx].data1;
          player function_9f60260e8537084c(self.data1, self.omnvar_data1);
        }
      }

      if(isDefined(player.var_79dc3da9a8aceb01[self.idx].data2)) {
        if(!isDefined(self.data2) || self.data2 != player.var_79dc3da9a8aceb01[self.idx].data2) {
          self.data2 = player.var_79dc3da9a8aceb01[self.idx].data2;
          player function_9f60260e8537084c(self.data2, self.omnvar_data2);
        }
      }
    }

    wait 0.1;
  }
}

function function_be1b4547d4875076(player) {
  line_count = 0;

  for(i = player.var_79dc3da9a8aceb01.size - 1; i > self.idx; i--) {
    if(player.var_79dc3da9a8aceb01[i].groupid == player.var_79dc3da9a8aceb01[self.idx].groupid) {
      line_count += 1;
    }
  }

  return line_count;
}

function function_89c92a32c10a068d(players, new_message) {
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
    if(!isDefined(player.var_79dc3da9a8aceb01)) {
      player function_50672487530eb076();
    }

    message_found = 0;
    message_added = 0;
    group_start = -1;

    for(i = 0; i < player.var_79dc3da9a8aceb01.size; i++) {
      if(player.var_79dc3da9a8aceb01[i].uniqueid == new_message.uniqueid) {
        message_found = 1;
      }

      if(player.var_79dc3da9a8aceb01[i].groupid == new_message.groupid && group_start < 0) {
        group_start = i;
      }
    }

    if(!message_found) {
      if(group_start >= 0) {
        for(i = group_start; i < player.var_79dc3da9a8aceb01.size; i++) {
          my_group = 0;

          if(player.var_79dc3da9a8aceb01[i].groupid == new_message.groupid) {
            my_group = 1;
          }

          if(my_group && player.var_79dc3da9a8aceb01[i].priority > new_message.priority) {
            player.var_79dc3da9a8aceb01 = utility::array_insert(player.var_79dc3da9a8aceb01, new_message, i);
            message_added = 1;
            break;
          }

          if(!my_group) {
            player.var_79dc3da9a8aceb01 = utility::array_insert(player.var_79dc3da9a8aceb01, new_message, i);
            message_added = 1;
            break;
          }
        }
      } else {
        for(i = 0; i < player.var_79dc3da9a8aceb01.size; i++) {
          if(player.var_79dc3da9a8aceb01[i].group_priority > new_message.group_priority) {
            player.var_79dc3da9a8aceb01 = utility::array_insert(player.var_79dc3da9a8aceb01, new_message, i);
            message_added = 1;
            break;
          }
        }
      }

      if(!message_added) {
        player.var_79dc3da9a8aceb01[player.var_79dc3da9a8aceb01.size] = new_message;
      }
    }
  }
}

function function_4c0b6929652fddc0(players, remove_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    foreach(message in player.var_79dc3da9a8aceb01) {
      if(message.uniqueid == remove_message.uniqueid) {
        message.should_remove = 1;
      }
    }
  }
}

function function_6167f12f7754c099(players, update_message) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    message_found = 0;

    foreach(message in player.var_79dc3da9a8aceb01) {
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
      function_89c92a32c10a068d(players, update_message);
    }
  }
}

function function_5e85741ad20f2787() {
  level.var_55e3c6982c284449 = [];
  level.var_55e3c6982c284449["\x1bNV\xb0\x8e+"] = &function_cb02aebeb8133278;
  level.var_55e3c6982c284449["\xeb\x8fq\xaa\xb4i"] = &function_48842951b659fc2e;
  level.var_55e3c6982c284449["\xc0Z'\v\x9eS\xce"] = &function_89cae2cb25714ac7;
  activity_common::function_cbc923662b03cacb("(\xbd%\xa1\x18I\xd2xur\xcb", &function_89cae2cb25714ac7);
}

function function_cb02aebeb8133278(player) {
  text = newclienthudelem(player);
  text.alpha = 0;
  text.alignx = "O\xd5!\xe8\xd4\x9d";
  text.aligny = "\x1d Q";
  text.fontscale = 3;
  text.x = 320;
  text.y = 115;
  text.color = (1, 0, 0);
  player.var_51d90b2c6a21b1be = text;
  return text;
}

function function_48842951b659fc2e(player, time) {
  if(!isDefined(player.var_51d90b2c6a21b1be)) {
    return;
  }

  player.var_51d90b2c6a21b1be.alpha = 1;
  var_acd345d76ccdfc20 = 5;
  countdown_time = ceil(var_acd345d76ccdfc20 - time);

  if(!isDefined(player.var_51d90b2c6a21b1be.time_tracking) || countdown_time < player.var_51d90b2c6a21b1be.time_tracking) {
    player.var_51d90b2c6a21b1be.time_tracking = countdown_time;
    string_time = utility::string(countdown_time);

    switch (string_time) {
      case #"hash_31100bbc01bd3230":
        player.var_51d90b2c6a21b1be settext(&"jup_ob_objectives/leave_warning_5_desc");
        break;
      case #"hash_31100cbc01bd33c3":
        player.var_51d90b2c6a21b1be settext(&"jup_ob_objectives/leave_warning_4_desc");
        break;
      case #"hash_311011bc01bd3ba2":
        player.var_51d90b2c6a21b1be settext(&"jup_ob_objectives/leave_warning_3_desc");
        break;
      case #"hash_311012bc01bd3d35":
        player.var_51d90b2c6a21b1be settext(&"jup_ob_objectives/leave_warning_2_desc");
        break;
      case #"hash_31100fbc01bd387c":
        player.var_51d90b2c6a21b1be settext(&"jup_ob_objectives/leave_warning_1_desc");
        break;
      default:
        player.var_51d90b2c6a21b1be settext(&"jup_ob_objectives/leave_warning_1_desc");
        break;
    }
  }
}

function function_89cae2cb25714ac7(var_6107e232511f4626) {
  foreach(player in var_6107e232511f4626.playerlist) {
    if(isPlayer(player) && isDefined(player.var_51d90b2c6a21b1be)) {
      player.var_51d90b2c6a21b1be destroy();
    }
  }
}

function function_c5f7a310bda5ccc0(stringreference, broadcaststyle = "j\xa3r\xa5\xb9;\xa6+\xcd\xdc\v\x9d-n\xec\xaa\xd1i\x8d\xbe\xa9p\xb1,\xcd\xa1", var_c9c0a756e180b516 = "\xb3\xc4\xb0&&", priority = "\x7f=&\x15\xbd\xae") {
  broadcast = player_broadcasting::function_552fcfff4afff671("\x9a\xd1\x93\xb4\x9bv\x92+3\xb2\xe4e\xdccV");
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
  broadcastdataobject.variant_object.stylesettings[0].variant_object.var_80b03a962e2a5ffc = var_c9c0a756e180b516;
  broadcast.broadcastdataobjects[0] = broadcastdataobject;
  return broadcast;
}

function function_55aea3f98fe5ec3(param, omnvar) {
  hud_management::function_b683400f784cb7dc("lPa\xbcQLq\xc2\xc3\xdb\n\xbb\x9fSc*H1\x8b\xef1\v\x7f\x1b\xf4\xf9\x05\xffd^", param, omnvar);
}

function function_cea5b687d7229897(state, omnvar) {
  hud_management::function_d8d634ceece460("lPa\xbcQLq\xc2\xc3\xdb\n\xbb\x9fSc*H1\x8b\xef1\v\x7f\x1b\xf4\xf9\x05\xffd^", state, omnvar);
}

function function_9f60260e8537084c(data, omnvar) {
  hud_management::function_e1c7789812cc6311("lPa\xbcQLq\xc2\xc3\xdb\n\xbb\x9fSc*H1\x8b\xef1\v\x7f\x1b\xf4\xf9\x05\xffd^", data, omnvar);
}
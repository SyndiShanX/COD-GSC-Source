/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_5a38602f6a9ab5d4.gsc
*****************************************************/

#using script_2e61bcf54eaedd23;
#using script_e9bca00ec07d3c6;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#namespace ai_spawn_director;

function private function_b0b866cbbd61be7(requestid, data) {
  agent = data.agent;

  if(!isDefined(agent)) {
    return;
  }

  agent.directorambient = istrue(data.ambient);
  agent.directorrequestid = requestid;
  agent.directorspawndata = data;
  reinforcementareaindex = function_cbc37bb2b6f91c2b(requestid);

  if(isDefined(reinforcementareaindex)) {
    agent thread function_b0b8d6f082ee0f73(reinforcementareaindex);
  }

  if(isDefined(level.var_735f9bb845b0853c)) {
    agent[[level.var_735f9bb845b0853c]]();
  }

  callbackstruct = function_30fa9b3e59df8157(":{\x1d\x19\x89Z\xcdU\x15", requestid);

  if(isDefined(callbackstruct)) {
    thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata, agent, data);
  }

  foreach(entry in level.var_6d62ed2c92ce6095) {
    thread[[entry]](agent, requestid, data);
  }

  if(agent.unittype == "75\xffQ\x95\xfe`\x9a") {
    agent function_272bfbdafb9ee1be(640);
    return;
  }

  if(isDefined(data.script_stealthgroup)) {
    agent thread function_1cd1da22365009c3(data);
  }

  agent.var_ba2cbe72aa748ebe = data.var_ba2cbe72aa748ebe;
  isvehiclespawn = 0;

  if(isDefined(data.vehiclespawntarget)) {
    isvehiclespawn = 1;
    data.vehiclespawntarget thread vehicle_aianim::guy_enter(agent);
    agent thread function_cf5b68c82e02aac3(requestid);
  } else if(isDefined(data.vehiclepathtargetname)) {
    assert(agent.behaviortreeasset != % "riotshield_cp", "<dev string:x24>");
    agent.var_5bc580d92d8e427a = 1;
    isvehiclespawn = 1;

    if(!isDefined(level.var_f93e405ca717ad72[requestid])) {
      vehicleinfostruct = spawnStruct();
      vehicleinfostruct.vehicle = data.vehicle;
      vehicleinfostruct.vehiclepathtargetname = data.vehiclepathtargetname;
      vehicleinfostruct.vehicle_index = data.vehicle_index;
      vehicleinfostruct.riders = [];
      vehicleinfostruct.riders[0] = agent;
      vehicleinfostruct.unload_pos = data.var_c7f4803189fc52c3;
      vehicleinfostruct.var_41458ebc080e368d = data.var_41458ebc080e368d;

      if(isDefined(data.vehicleskin)) {
        vehicleinfostruct.var_d22ac03c16b6e075 = data.vehicleskin;
      }

      level.var_f93e405ca717ad72[requestid] = vehicleinfostruct;
    } else {
      agent.var_5bc580d92d8e427a = 1;
      ridersarray = level.var_f93e405ca717ad72[requestid].riders;
      level.var_f93e405ca717ad72[requestid].riders = utility::function_e86d2ca144f6bde8(ridersarray, agent);
    }
  }

  if(isDefined(data.var_e59f8d2fa4f179bf)) {
    isvehiclespawn = 1;

    if(isDefined(level.var_873d5aab65777ef6)) {
      agent thread[[level.var_873d5aab65777ef6]](requestid, data);
    }
  }

  if(!isvehiclespawn) {
    if(istrue(data.smokebombinfil)) {
      if(isDefined(level.var_b77efaa6ba00d0e5)) {
        agent hide();
        agent utility::delaycall(0.5, &show);
        agent thread[[level.var_b77efaa6ba00d0e5]](agent.origin, requestid);
      }
    }

    agent _precombat(data);
  }

  function_956118af8da9aef7(requestid, agent, data, !istrue(data.spawninggroup));

  if(getdvarint(@ "hash_bf14cfde8e249160", 0) == 1 && agent.type == "\x9b\x11\"\xd6\xfb;" && data.ambient) {
    agent thread function_a85f2d7c65ab279e(data.encounterradius);
  }

  if(data.spawnspeed != 2) {
    var_18c34e84555a7180 = istrue(data.alert) || data.spawnspeed == 1 ? "n\xc1\x16\xdd\x9b\xd7\x99\xc2\xe6G" : "\xb5\xe2\xd8\xcd/";
    spawn_anim_alias = data.animscripted_alias ?? var_18c34e84555a7180;

    if(isDefined(level.var_f36886349969a6f6)) {
      thread[[level.var_f36886349969a6f6]](agent, data, spawn_anim_alias);
    }
  }

  if(getdvarint(@ "hash_fe20797ad12b2dbe", 0) == 1) {
    if(isDefined(level.var_b48125be4d47305c)) {
      agent thread[[level.var_b48125be4d47305c]]();
    }
  }

}

function private function_956118af8da9aef7(requestid, agent, data, groupfinished) {
  if(!isDefined(level.var_88998ce454963317[requestid])) {
    level.var_88998ce454963317[requestid] = [];
  }

  currententry = level.var_88998ce454963317[requestid].size;
  level.var_88998ce454963317[requestid][currententry] = spawnStruct();
  level.var_88998ce454963317[requestid][currententry].agent = agent;
  level.var_88998ce454963317[requestid][currententry].data = data;

  if(groupfinished) {
    function_1746aeeca5dc1d8b(requestid);
    level.var_88998ce454963317[requestid][currententry] = undefined;
  }
}

function _precombat(data) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(self.unittype == "\xb9\xdb6d-\xb2\xc9") {
    if(isDefined(data.interaction_id)) {
      interactdatanode = spawnStruct();
      interactdatanode.script_delay = data.script_delay;
      interactdatanode.script_delay_min = data.script_delay_min;
      interactdatanode.script_delay_max = data.script_delay_max;

      if(data.script_delay_min == data.script_delay_max) {
        if(data.script_delay_min != 0) {
          interactdatanode.script_delay = data.script_delay_min;
        }

        interactdatanode.script_delay_min = undefined;
        interactdatanode.script_delay_max = undefined;
      }

      if(isDefined(data.repeat_interaction) && istrue(int(data.repeat_interaction))) {
        interactdatanode.repeat_interaction = 1;
      }

      if(istrue(data.script_faceangles)) {
        interactdatanode.script_faceangles = 1;
      }

      if(istrue(data.script_cleanexit)) {
        interactdatanode.script_cleanexit = 1;
      }

      self._blackboard.idlenode = interactdatanode;
      _setgoalpos(function_658a8c3245e83656(data.interaction_id), 64, 1);
      self function_47127b28b1fb3f1e(data.interaction_id);

      if(isDefined(data.path_array)) {
        thread function_fbd9197b74578b0d(data.path_array);
      }

      if(isDefined(data.var_899bab25230c46ff)) {
        thread function_2e4da1926d7716a5(data.var_899bab25230c46ff);
      }

      return;
    }

    if(isDefined(data.path_array)) {
      var_f4f1ad935c377784 = 0;

      if(istrue(data.restored)) {
        var_f4f1ad935c377784 = 1;
      }

      function_fb89dad19c0406db(data.path_array, var_f4f1ad935c377784);

      if(isDefined(data.var_899bab25230c46ff)) {
        thread function_2e4da1926d7716a5(data.var_899bab25230c46ff);
      }

      return;
    }

    if(isDefined(data.covernodetarget)) {
      node = getnode(data.covernodetarget, #targetname);

      if(isDefined(node)) {
        if(self usecovernodeifpossible(node)) {
          self setgoalnode(node);
        }
      }

      return;
    }

    if(istrue(data.ambient)) {
      wanderorigin = self.origin;
      wanderradius = 500;

      if(isDefined(data.var_899bab25230c46ff)) {
        goalvol = function_ac311f3d6717d47d(data.var_899bab25230c46ff, #targetname);

        if(!isDefined(goalvol) || goalvol.size == 0) {
          goalstruct = utility::getStruct(data.var_899bab25230c46ff, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

          if(isDefined(goalstruct)) {
            wanderorigin = goalstruct.origin;
            wanderradius = goalstruct.radius;
          } else {
            assertmsg("<dev string:x55>" + data.var_899bab25230c46ff + "<dev string:x79>");
          }
        } else {
          wanderorigin = goalvol.origin;
          wanderradius = goalvol.radius;
        }
      }

      thread _wander(self, wanderradius, 0, wanderorigin);
    }
  }
}

function private function_1cd1da22365009c3(data) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(data.script_stealthgroup)) {
    self.script_stealthgroup = data.script_stealthgroup;
    thread enemy::main();

    if(isDefined(level.var_e80ecd15494e215a)) {
      thread[[level.var_e80ecd15494e215a]]();
    }

    waitframe();

    if(istrue(data.alert) && isDefined(self.fnsetstealthstate)) {
      self[[self.fnsetstealthstate]]("\xe3\xd0\xc3e\x85h");
    }
  }
}

function private function_1746aeeca5dc1d8b(requestid) {
  if(isDefined(level.var_4dadada59b63fa85)) {
    [[level.var_4dadada59b63fa85]](requestid, level.var_88998ce454963317[requestid]);
  }
}

function private function_9c77e9dbd3efd626(requestid) {
  callbackstruct = function_30fa9b3e59df8157("%\xcaP1\x8c$\xc8i\xf8?\xb5\a", requestid);

  if(isDefined(callbackstruct)) {
    thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata);
    return;
  }

  function_954d9d7f9ce9a086(requestid);
}

function private function_38fea6e099fda7a6(requestid, data) {
  callbackstruct = function_30fa9b3e59df8157("\x96\xa5\x18O\xb6\x04\xaeba\x0f\x98hO\xdaR\xae\xb5\x0em\xee\xe0f", requestid);

  if(isDefined(callbackstruct)) {
    [[callbackstruct.fncallback]](requestid, callbackstruct.userdata);
  }

  function_41555b3a441636e5(requestid, data);
}

function private function_95128a414fea4a87(requestid, data) {
  assert(isDefined(level.var_bbd85d958a110a1f[requestid]), "<dev string:xe3>");
  callbackstruct = function_30fa9b3e59df8157("g}\xadE\x94\x89Q\x8f5\xef\"\xc9H\xa7w", requestid);

  if(isDefined(callbackstruct)) {
    return [[callbackstruct.fncallback]](requestid, callbackstruct.userdata, data.wavenumber);
  }

  assertmsg("<dev string:x145>" + requestid);
  return 1;
}

function private function_5a99665cd5809f44(requestid) {
  level notify("\bk!\xa1\xe0{_\xb3\xa8\x13';\xe6c\xa9\x8d\x10\xc9\xb8)p!\xffCjS)j\xda\x7f\xea\x99\xb5\\^\x90\x89\x04!" + requestid);
  level endon("\bk!\xa1\xe0{_\xb3\xa8\x13';\xe6c\xa9\x8d\x10\xc9\xb8)p!\xffCjS)j\xda\x7f\xea\x99\xb5\\^\x90\x89\x04!" + requestid);
  level endon("\x9c\xb93'\xfcU\xc7o/\xa8\xcc\xa6b\xa8\x88F\xdc\xeb\x91\x1bo\xd6" + requestid);

  while(true) {
    callbackstruct = function_30fa9b3e59df8157("\x9a\ro\xd56\x8c5\r\xeaG2\xb7w\x9b\x91\xb1\xed\xde2F\xb46c", requestid);

    if(isDefined(callbackstruct)) {
      if([[callbackstruct.fncallback]](requestid, callbackstruct.userdata)) {
        break;
      }
    } else {
      assertmsg("<dev string:x18f>" + requestid);
      break;
    }

    waitframe();
  }

  function_46ddac66ff95c970(requestid);
}

function private function_d13d288c6b612a59(requestid) {
  level thread function_5a99665cd5809f44(requestid);
}

function private function_539e490c29ccb2cb(requestid) {
  level notify("\x18K2l\x18\xea>\xd5c\x91\xf2Cz\xdf\xe5\xe0\x14\x11\xdfk\x04`\xbc\xcc\x9f\xb8\x7f\x88\xdf\xd8\x86\x14<\xab\x1c\xff" + requestid);
  level endon("\x18K2l\x18\xea>\xd5c\x91\xf2Cz\xdf\xe5\xe0\x14\x11\xdfk\x04`\xbc\xcc\x9f\xb8\x7f\x88\xdf\xd8\x86\x14<\xab\x1c\xff" + requestid);
  level endon("\x9c\xb93'\xfcU\xc7o/\xa8\xcc\xa6b\xa8\x88F\xdc\xeb\x91\x1bo\xd6" + requestid);

  while(true) {
    callbackstruct = function_30fa9b3e59df8157("T\x87\x80\xd8\xc8wz\x8c}\xfcx\x8d\xb9c\xe1\xfc\xfc$\xc0\x16", requestid);

    if(isDefined(callbackstruct)) {
      requestinfo = function_60dad16c45753a36(requestid);
      assert(requestinfo.status == 1 || requestinfo.status == 9);

      if([[callbackstruct.fncallback]](requestid, callbackstruct.userdata)) {
        break;
      }
    } else {
      assertmsg("<dev string:x1d5>" + requestid);
      break;
    }

    waitframe();
  }

  function_1ace93df73a0e647(requestid);
}

function private function_c90ff5bd73226780(requestid, ready) {
  if(ready) {
    level thread function_539e490c29ccb2cb(requestid);
    return;
  }

  level notify("\x18K2l\x18\xea>\xd5c\x91\xf2Cz\xdf\xe5\xe0\x14\x11\xdfk\x04`\xbc\xcc\x9f\xb8\x7f\x88\xdf\xd8\x86\x14<\xab\x1c\xff" + requestid);
}

function function_bb2f9ccaec38220e(requestid, fncallback, userdata) {
  add_callback("p;o \xa2\xc3\x9d\xc6", requestid, fncallback, userdata);
}

function function_9076e2c9c605a712(requestid, fncallback, userdata) {
  add_callback("T\x87\x80\xd8\xc8wz\x8c}\xfcx\x8d\xb9c\xe1\xfc\xfc$\xc0\x16", requestid, fncallback, userdata);
}

function function_828da040bb6476b9(requestid, fncallback, userdata) {
  add_callback("\x9a\ro\xd56\x8c5\r\xeaG2\xb7w\x9b\x91\xb1\xed\xde2F\xb46c", requestid, fncallback, userdata);
}

function private function_6c2a004e626bb75d(requestid, data) {
  shutdowncallbackstruct = function_30fa9b3e59df8157("p;o \xa2\xc3\x9d\xc6", requestid);

  if(istrue(data.iscomplete)) {
    if(isDefined(level.var_bbd85d958a110a1f[requestid])) {
      foreach(callbackstruct in level.var_bbd85d958a110a1f[requestid]) {
        if(callbackname != "p;o \xa2\xc3\x9d\xc6") {
          callbackstruct notify("6\xb0l\xd8&\x85\xd8m\xd7\xc6\xb1+\xb0n\xae\xc1");
        }
      }

      level.var_bbd85d958a110a1f[requestid] = undefined;
    }

    if(istrue(data.var_3951611316322d24)) {
      level.var_bbd85d958a110a1f[requestid] = [];
    }

    if(isDefined(level.var_fe423ca9a5b9f51d[requestid])) {
      level.var_fe423ca9a5b9f51d[requestid] = undefined;
    }
  }

  if(isDefined(shutdowncallbackstruct)) {
    thread[[shutdowncallbackstruct.fncallback]](requestid, shutdowncallbackstruct.userdata, data);
  }

  if(istrue(data.iscomplete)) {
    level notify("\x9c\xb93'\xfcU\xc7o/\xa8\xcc\xa6b\xa8\x88F\xdc\xeb\x91\x1bo\xd6" + requestid);
  }
}

function private function_9fdce4e0cb13caba(requestid, data) {
  if(getdvarint(@ "ai_spawn_director_enable_despawn_behaviors", 0) == 1) {
    foreach(guy in data) {
      assert(!istrue(guy.var_3400cb7eb30eaa75));
      guy.var_3400cb7eb30eaa75 = 1;
      level.var_1186e9c93441116f[level.var_1186e9c93441116f.size] = guy;
    }
  }

  level notify("2u\x7f\xda\xe872di6mO\xf8\xb1\xbb\x96`U\xbb\xe9NB\xdf\xce" + requestid);
  level notify("<\x1e\xf74\x90 \x839(\xf8z\xbe\xf8\xfe\x7f\xc8\x01\r\xb0\x87\xc6@\xf9\xa5\xd8\xc5\x8e\xbd");
}

function private function_edef9b71960c7fd7() {
  while(true) {
    level waittill("<\x1e\xf74\x90 \x839(\xf8z\xbe\xf8\xfe\x7f\xc8\x01\r\xb0\x87\xc6@\xf9\xa5\xd8\xc5\x8e\xbd");
    despawncount = 0;

    while(level.var_1186e9c93441116f.size > 0) {
      guy = level.var_1186e9c93441116f[0];
      level.var_1186e9c93441116f = utility::array_remove_index(level.var_1186e9c93441116f, 0);

      if(isalive(guy)) {
        guy thread function_fd6bfb18b49d3435(guy.directorrequestid);
        despawncount++;
      }

      if(despawncount >= getdvarint(@ "hash_54dc66a37e679beb", 5)) {
        despawncount = 0;
        waitframe();
      }
    }
  }
}

function private function_616aa1e6adfb165d(callbackname, requestid, data) {
  switch (callbackname) {
    case #"hash_9e98220b6f353a3f":
      return function_b0b866cbbd61be7(requestid, data);
    case #"hash_58235f15856f6160":
      data function_2fd04d6b5090696e();
      return;
    case #"hash_d88f6ad5755dfe30":
    case #"hash_eb099bd287e41597":
      function_9c77e9dbd3efd626(requestid);
      break;
    case #"hash_b9a32efd84fd32d0":
      function_38fea6e099fda7a6(requestid, data);
      break;
    case #"hash_9667ea6cd44b8ec8":
      return function_95128a414fea4a87(requestid, data);
    case #"hash_95c6a6d49e8ed085":
      function_c90ff5bd73226780(requestid, data);
      break;
    case #"hash_79765d0de58f935c":
      function_d13d288c6b612a59(requestid);
      break;
    case #"hash_45fc965fd1793461":
      function_9fdce4e0cb13caba(requestid, data);
      break;
    case #"hash_d432f1ec297228ab":
      function_6c2a004e626bb75d(requestid, data);
      break;
    case #"hash_4e0fcd24c9caa04":
      function_2e744129be1e5b9b(requestid);
      break;
    case #"hash_7c1d8e0a9e3c904f":
      function_379b5320278e59b9(requestid);
      break;
  }
}

function function_1395e152d9e24f42(requestid, fncallback, userdata) {
  add_callback("\xea\xfbg-\x12\x82~B", requestid, fncallback, userdata);
}

function private function_379b5320278e59b9(requestid) {
  callbackstruct = function_30fa9b3e59df8157("\xea\xfbg-\x12\x82~B", requestid);

  if(isDefined(callbackstruct)) {
    thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata);
  }
}

function private function_2e744129be1e5b9b(zoneindex) {
  subzones = function_e1e5912e0a352fc2(zoneindex);

  foreach(entry in level.var_f3b4ca73dd283c27) {
    thread[[entry]](zoneindex, subzones);
  }
}

function add_callback(callbackname, requestid, fncallback, userdata) {
  if(!(isDefined(requestid) && isDefined(level.var_bbd85d958a110a1f[requestid]))) {
    assertmsg("<dev string:x218>" + callbackname);
    return;
  }

  if(isDefined(fncallback)) {
    level.var_bbd85d958a110a1f[requestid][callbackname] = spawnStruct();
    level.var_bbd85d958a110a1f[requestid][callbackname].fncallback = fncallback;
    level.var_bbd85d958a110a1f[requestid][callbackname].userdata = userdata;
  }
}

function remove_callback(callbackname, requestid) {
  if(isDefined(level.var_bbd85d958a110a1f[requestid]) && isDefined(level.var_bbd85d958a110a1f[requestid][callbackname])) {
    level.var_bbd85d958a110a1f[requestid][callbackname] notify("6\xb0l\xd8&\x85\xd8m\xd7\xc6\xb1+\xb0n\xae\xc1");
    level.var_bbd85d958a110a1f[requestid][callbackname] = undefined;
  }
}

function function_30fa9b3e59df8157(callbackname, requestid) {
  if(isDefined(level.var_bbd85d958a110a1f[requestid]) && isDefined(level.var_bbd85d958a110a1f[requestid][callbackname])) {
    return level.var_bbd85d958a110a1f[requestid][callbackname];
  }

  return undefined;
}

function private _notify_callback(requestid, callbackname, ...) {
  callbackstruct = function_30fa9b3e59df8157(callbackname, requestid);
  callbackstruct notify(callbackname);
}

function function_c1ea4b08ec9ef61f(callbackname, requestid) {
  assert(!isDefined(function_30fa9b3e59df8157(callbackname, requestid)), "<dev string:x263>");
  add_callback(callbackname, requestid, &_notify_callback, callbackname);
  callbackstruct = function_30fa9b3e59df8157(callbackname, requestid);
  result = callbackstruct utility::waittill_any_return(callbackname, "6\xb0l\xd8&\x85\xd8m\xd7\xc6\xb1+\xb0n\xae\xc1");

  if(result == callbackname) {
    thread remove_callback(callbackname, requestid);
    return true;
  }

  return false;
}

function function_28643de380868319() {
  self notify("\x02\xef\b\x87\x01 \xe0\xb5\x15\xa4%\xcf\xd4\x90<d\"?{\x88\xc8\xb5T\x05\xc5\xa8");
}

function function_12a9f8b1e663068a() {
  if(isDefined(self.directorspawndata) && isDefined(self.directorspawndata.path_array)) {
    function_fb89dad19c0406db(self.directorspawndata.path_array);
    return;
  }

  assertmsg("<dev string:x2cf>" + self.directorrequestid + "<dev string:x313>");
}

function function_fa74e65cf8af0e10(targetname) {
  assert(istrue(level.var_bccf7e6f4cb1946e), "<dev string:x338>");
  requestid = function_72dfeaf35d42fad5(targetname);

  if(!getdvarint(@ "hash_d9375e00b5f54c59", 0) && !isDefined(requestid)) {
    assertmsg("<dev string:x35f>" + targetname + "<dev string:x389>");
  }

  if(isDefined(requestid) && !isDefined(level.var_bbd85d958a110a1f[requestid])) {
    level.var_bbd85d958a110a1f[requestid] = [];
  }

  return requestid;
}

function function_327b14b1d06b7887(targetname) {
  assert(istrue(level.var_bccf7e6f4cb1946e), "<dev string:x338>");
  requestids = function_80a7dfdc32f0f701(targetname);

  foreach(requestid in requestids) {
    if(isDefined(requestid) && !isDefined(level.var_bbd85d958a110a1f[requestid])) {
      level.var_bbd85d958a110a1f[requestid] = [];
    }
  }

  return requestids;
}

function function_de3986dd4c684111(fncallback) {
  assert(isDefined(fncallback));
  assert(isDefined(level.var_6d62ed2c92ce6095), "<dev string:x3b2>");
  level.var_6d62ed2c92ce6095 = utility::function_e86d2ca144f6bde8(level.var_6d62ed2c92ce6095, fncallback);
}

function function_3eabe5bf184bc91a(fncallback) {
  assert(isDefined(fncallback));
  level.var_6d62ed2c92ce6095 = arrayremove(level.var_6d62ed2c92ce6095, fncallback);
}

function function_ff59da2009036943(fncallback) {
  assert(isDefined(fncallback));
  assert(isDefined(level.var_f3b4ca73dd283c27), "<dev string:x3b2>");
  level.var_f3b4ca73dd283c27 = utility::function_e86d2ca144f6bde8(level.var_f3b4ca73dd283c27, fncallback);
}

function function_f690fe5dc269fae(fncallback) {
  assert(isDefined(fncallback));
  level.var_f3b4ca73dd283c27 = arrayremove(level.var_f3b4ca73dd283c27, fncallback);
}

function function_b74d3b902e3a0027(requestid, fncallback, userdata) {
  add_callback("%\xcaP1\x8c$\xc8i\xf8?\xb5\a", requestid, fncallback, userdata);
}

function function_a7384e68e6948e48(requestid, fncallback, userdata) {
  add_callback(":{\x1d\x19\x89Z\xcdU\x15", requestid, fncallback, userdata);
}

function function_9890804f7e1fabe9(requestid, fncallback, userdata) {
  add_callback("\xed-F\xa2\\-{\x01\x9b+a8!U~\x86", requestid, fncallback, userdata);
}

function function_5849c366a9f3c1d6(requestid, fncallback, userdata) {
  add_callback("\x99\xa0_[\xe1\xb2e\xe1!\xef", requestid, fncallback, userdata);
}

function function_9221b309d6b5d248(requestid, fncallback, userdata) {
  add_callback("\xd3\xe6\x05aN\xb0l\xa1\xd5\xe8\xacL\x16s\x19\xb2\x19", requestid, fncallback, userdata);
}

function function_a4fd12dec593963f(requestid, fncallback, userdata) {
  add_callback("g}\xadE\x94\x89Q\x8f5\xef\"\xc9H\xa7w", requestid, fncallback, userdata);
}

function function_bdeb645c49b56fc7(requestid, fncallback, userdata) {
  add_callback("\x96\xa5\x18O\xb6\x04\xaeba\x0f\x98hO\xdaR\xae\xb5\x0em\xee\xe0f", requestid, fncallback, userdata);
}

function function_b9425ddc2afe7ac9(requestid, fncallback, userdata) {
  add_callback("\xc6*Q\x85\"\x02\x89|.Cf\xf2\x01O\xec2", requestid, fncallback, userdata);
}

function spawn_request(encounterbundlename, origin, radius, enabled, readytospawn, isambient, var_8a8a46909cb29a40) {
  assert(level.var_bccf7e6f4cb1946e);
  assert(isDefined(getscriptbundle(encounterbundlename)), "<dev string:x3ee>" + getxhashsourcename(encounterbundlename));

  if(!isDefined(isambient)) {
    isambient = 0;
  }

  if(!isDefined(var_8a8a46909cb29a40)) {
    var_8a8a46909cb29a40 = 1;
  }

  requestid = function_74ea370aadce81ef(encounterbundlename, origin, radius, enabled, readytospawn, isambient, var_8a8a46909cb29a40);

  if(isDefined(requestid)) {
    level.var_bbd85d958a110a1f[requestid] = [];
  }

  return requestid;
}

function function_9ded1e6b967479e0(requestid, shouldrespawn) {
  assert(level.var_bccf7e6f4cb1946e);
  function_4f4347dda5dc0f61(requestid, shouldrespawn);
}

function function_88bfca9ca42806ae(requestid, prioritylevel) {
  assert(level.var_bccf7e6f4cb1946e);
  function_2d4a3ad7dd873c76(requestid, prioritylevel);
}

function function_58c3f73f3ee16ffd(createscriptflag) {
  if(!isDefined(level.var_1795d11c9f0c35ca)) {
    level.var_1795d11c9f0c35ca = [];
  }

  numflags = level.var_1795d11c9f0c35ca.size;
  level.var_1795d11c9f0c35ca[numflags] = createscriptflag + "\b6\x13X\x1e[\xcf\x05\xc0K";
}

function process_create_script() {
  if(isDefined(level.var_1795d11c9f0c35ca)) {
    foreach(createscriptflag in level.var_1795d11c9f0c35ca) {
      utility::flag_wait(createscriptflag);
    }

    level.var_1795d11c9f0c35ca = [];
  }

  interactions = utility::getStructArray("QB\x92\xc2 \xf0\xbd\xe2", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
  interactionlist = [];

  foreach(interaction in interactions) {
    if(!isDefined(interaction.ai_interaction)) {
      continue;
    }

    interactionid = spawninteraction(interaction.ai_interaction, interaction.origin, interaction.angles);

    if(isDefined(interaction.targetname)) {
      interactionlist[interaction.targetname] = interactionid;
    }

    function_c9d8e8e3af9cee1f(interactionid, interaction.origin);
  }

  patrolpointsold = utility::getStructArray("\xfdAi?r,f\xe5\xe6l\x10p0aky`\xb8$\xd6\x1bK\xb4\x8e\xa9", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
  patrolpointsnew = utility::getStructArray("\xfdAi?r,f\xe5\xe6l\x10p0aky`\xb8$\xd6\x1bK\xb4\x8e\xa9", "!DOn\xba'\xed\x8e&!\\");
  patrolpoints = utility::array_combine_unique(patrolpointsold, patrolpointsnew);

  foreach(point in patrolpoints) {
    if(isDefined(point.move_speed)) {
      point.move_speed = float(point.move_speed);
    }

    if(isDefined(point.var_112052805d49c3fe)) {
      point.var_112052805d49c3fe = float(point.var_112052805d49c3fe);
    }

    if(isDefined(point.max_wait_time)) {
      point.max_wait_time = float(point.max_wait_time);
    }

    point.start_point = isDefined(point.start_point) && point.start_point == "\x87";
    point.reverse_route = isDefined(point.reverse_route) && point.reverse_route == "\x87";
    point.loop_route = isDefined(point.loop_route) && point.loop_route == "\x87";

    if(isDefined(point.var_fd588e06aaff4479) && isDefined(interactionlist[point.var_fd588e06aaff4479])) {
      point.var_fd588e06aaff4479 = interactionlist[point.var_fd588e06aaff4479];
    } else {
      point.var_fd588e06aaff4479 = undefined;
    }

    if(isDefined(point.var_979387ba608965f6)) {
      point.var_979387ba608965f6 = int(point.var_979387ba608965f6);
    }

    function_79283e92cb226d4(point);
  }

  parachutestartpoints = utility::getStructArray("\x9ez[\x99X\x9a\xa8H\xc5\xfb\xaa8@\x05z\x19\x9c85\x11\b\x92\x9eK\xc8I\xb8\x8b", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
  spawnpointsold = utility::getStructArray("\xdf$\x87A\xb5\xa7\x91e\x1bq/2\xc2\x8fe\xcf\v\xa3z\xa9{\xc9\x10", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
  spawnpointsnew = utility::getStructArray("\xdf$\x87A\xb5\xa7\x91e\x1bq/2\xc2\x8fe\xcf\v\xa3z\xa9{\xc9\x10", "!DOn\xba'\xed\x8e&!\\");
  wanderpoints = utility::getStructArray(">F\x18\x14A\r^\xef}$\f\t\x0e\a\xe4|x\xb9\xb34\xcd\x9dH\x1e\xdeet\xc1\xcd\x93", "!DOn\xba'\xed\x8e&!\\");
  patrolstartpoints = utility::getStructArray("Y\x02\xb3\xacNZ\xd7\x93\xd2|\xa1\x93?m\x04\x91\x97\xcb\x8e\x1f\xd1*\xae3\xb77\xa5\xdb\x11p\xa2\x97buO", "!DOn\xba'\xed\x8e&!\\");
  locationpoints = utility::getStructArray("\x85K\xaf\xac7\x8d\xb7Ws\xe8V\xe4_l\xf6\xb1\xb0G\xa5{s\xeb\xe68Xw\xcd\xe0\xdb-7:", "!DOn\xba'\xed\x8e&!\\");
  spawnpoints = utility::array_combine(utility::array_combine_unique(spawnpointsold, spawnpointsnew), wanderpoints);
  spawnpoints = utility::array_combine(patrolstartpoints, spawnpoints);
  spawnpoints = utility::array_combine(locationpoints, spawnpoints);

  foreach(point in spawnpoints) {
    if(isDefined(point.var_a365ec37ef032354)) {
      point.var_a365ec37ef032354 = float(point.var_a365ec37ef032354);
    } else {
      point.var_a365ec37ef032354 = 5000;
    }

    point.preferred_spawnpoint = isDefined(point.preferred_spawnpoint) && point.preferred_spawnpoint == "\x87";
    point.reinforcement_spawn = isDefined(point.reinforcement_spawn) && point.reinforcement_spawn == "\x87";
    point.is_elite = isDefined(point.is_elite) && point.is_elite == "\x87";

    if(isDefined(point.script_stealthgroup) && point.script_stealthgroup == "Bf") {
      point.script_stealthgroup = undefined;
    }

    point.var_6c387e649f14ab54 = isDefined(point.var_6c387e649f14ab54) && point.var_6c387e649f14ab54 == "\x87";

    if(point.var_6c387e649f14ab54) {
      if(isDefined(point.targetname)) {
        foreach(parachutepoint in parachutestartpoints) {
          if(isDefined(parachutepoint.target) && parachutepoint.target == point.targetname) {
            point.var_e59f8d2fa4f179bf = parachutepoint.origin;
          }
        }

        if(!isDefined(point.var_e59f8d2fa4f179bf)) {
          point.var_e59f8d2fa4f179bf = (point.origin[0], point.origin[1], point.origin[2] + point.var_a365ec37ef032354);
        }
      } else {
        point.var_e59f8d2fa4f179bf = (point.origin[0], point.origin[1], point.origin[2] + point.var_a365ec37ef032354);
      }
    }

    if(isDefined(point.var_fd588e06aaff4479) && isDefined(interactionlist[point.var_fd588e06aaff4479])) {
      point.var_fd588e06aaff4479 = interactionlist[point.var_fd588e06aaff4479];
    } else {
      point.var_fd588e06aaff4479 = undefined;
    }

    if(isDefined(point.minspawns)) {
      point.minspawns = int(point.minspawns);
    }

    if(isDefined(point.maxspawns)) {
      point.maxspawns = int(point.maxspawns);
    }

    if(isDefined(point.location_spawnpoint)) {
      point.location_spawnpoint = point.location_spawnpoint == "\x87";
    } else {
      point.location_spawnpoint = isDefined(point.variantname) && point.variantname == "\x85K\xaf\xac7\x8d\xb7Ws\xe8V\xe4_l\xf6\xb1\xb0G\xa5{s\xeb\xe68Xw\xcd\xe0\xdb-7:";
    }

    if(isDefined(point.reusecooldown)) {
      point.reusecooldown = float(point.reusecooldown);
    }

    function_ddb2a7686544f7d5(point);
  }

  function_73a4e61bfad24be1();
  volumes = utility::getStructArray("(\xdd\xe5W\x1a\xb9!79\x95\xa5P\xf3i\xf87\xe5V}~\xad\xb5\x13\xca\xa9\x03c\xa7", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

  foreach(volume in volumes) {
    volume.var_138b84104e30193e = isDefined(volume.var_138b84104e30193e) && volume.var_138b84104e30193e == "\x87";
    volume.var_9c1a74c0401eea86 = isDefined(volume.var_9c1a74c0401eea86) && volume.var_9c1a74c0401eea86 == "\x87";
    volume.var_fb87f7c9b5fca3af = isDefined(volume.var_fb87f7c9b5fca3af) && volume.var_fb87f7c9b5fca3af == "\x87";
    volume.var_246a52f58332d6b6 = isDefined(volume.var_246a52f58332d6b6) && volume.var_246a52f58332d6b6 == "\x87";
    volume.is_ambient = isDefined(volume.is_ambient) && volume.is_ambient == "\x87";

    if(isDefined(volume.script_stealthgroup) && volume.script_stealthgroup == "Bf") {
      volume.script_stealthgroup = undefined;
    }

    function_dfc11c62a9b4c02c(volume);
  }

  if(getdvarint(@ "hash_6c2c138ca17a4631", 1) == 1) {
    thread function_f45a4a6ebfde89f3();
  }
}

function function_99d9ba018978b880() {
  encounterselectors = utility::getStructArray("[\x03Is\b\xe3\xa5t7\x7f\xc3\x10\x94\rgnM\x7f+,\x10\xc7G\xb7\x7f\xfc\x82\xf0\x1dK\x7fk\xe0k\x88", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

  foreach(selector in encounterselectors) {
    if(selector.target != "") {
      encounters = function_327b14b1d06b7887(selector.target);

      if(isDefined(encounters) && encounters.size > 0) {
        foreach(encounter in encounters) {
          function_36fcb84d1ddc8c4(encounter, 0);
        }

        filteredencounters = [];

        foreach(encounter in encounters) {
          if(isDefined(selector.script_required_tag) && selector.script_required_tag != "" && !function_5e2f03dd0992df68(encounter, selector.script_required_tag)) {
            continue;
          }

          if(isDefined(selector.script_ignore_tag) && selector.script_ignore_tag != "" && function_5e2f03dd0992df68(encounter, selector.script_ignore_tag)) {
            continue;
          }

          filteredencounters[filteredencounters.size] = encounter;
        }

        if(filteredencounters.size == 0) {
          continue;
        }

        mincount = 1;
        maxcount = 1;
        selectcount = 1;

        if(isDefined(selector.script_count_min)) {
          mincount = int(selector.script_count_min);
        }

        if(isDefined(selector.script_count_max)) {
          maxcount = int(selector.script_count_max);
        }

        assert(mincount <= maxcount, "<dev string:x416>" + selector.target);

        if(mincount <= maxcount) {
          selectcount = randomintrange(mincount, maxcount + 1);
        }

        if(selectcount <= 0) {
          continue;
        }

        filteredencounters = utility::array_randomize(filteredencounters);

        for(encounterindex = 0; encounterindex < filteredencounters.size && encounterindex < selectcount; encounterindex++) {
          function_36fcb84d1ddc8c4(filteredencounters[encounterindex], 1);
        }
      }
    }
  }
}

function private function_f45a4a6ebfde89f3() {
  var_7bb19890935c0035 = getdvarint(@ "hash_59839a5de33b3ef6", 5);
  level thread function_20577f7999c12858("!DOn\xba'\xed\x8e&!\\", "\xfdAi?r,f\xe5\xe6l\x10p0aky`\xb8$\xd6\x1bK\xb4\x8e\xa9", var_7bb19890935c0035);
  level thread function_20577f7999c12858("\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*", "\xfdAi?r,f\xe5\xe6l\x10p0aky`\xb8$\xd6\x1bK\xb4\x8e\xa9", var_7bb19890935c0035);
  level thread function_20577f7999c12858("!DOn\xba'\xed\x8e&!\\", "\x9ez[\x99X\x9a\xa8H\xc5\xfb\xaa8@\x05z\x19\x9c85\x11\b\x92\x9eK\xc8I\xb8\x8b", var_7bb19890935c0035);
  level thread function_20577f7999c12858("!DOn\xba'\xed\x8e&!\\", "\xdf$\x87A\xb5\xa7\x91e\x1bq/2\xc2\x8fe\xcf\v\xa3z\xa9{\xc9\x10", var_7bb19890935c0035);
  level thread function_20577f7999c12858("\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*", "\xdf$\x87A\xb5\xa7\x91e\x1bq/2\xc2\x8fe\xcf\v\xa3z\xa9{\xc9\x10", var_7bb19890935c0035);
  level thread function_20577f7999c12858("!DOn\xba'\xed\x8e&!\\", ">F\x18\x14A\r^\xef}$\f\t\x0e\a\xe4|x\xb9\xb34\xcd\x9dH\x1e\xdeet\xc1\xcd\x93", var_7bb19890935c0035);
  level thread function_20577f7999c12858("!DOn\xba'\xed\x8e&!\\", "Y\x02\xb3\xacNZ\xd7\x93\xd2|\xa1\x93?m\x04\x91\x97\xcb\x8e\x1f\xd1*\xae3\xb77\xa5\xdb\x11p\xa2\x97buO", var_7bb19890935c0035);
  level thread function_20577f7999c12858("!DOn\xba'\xed\x8e&!\\", "\x85K\xaf\xac7\x8d\xb7Ws\xe8V\xe4_l\xf6\xb1\xb0G\xa5{s\xeb\xe68Xw\xcd\xe0\xdb-7:", var_7bb19890935c0035);
  level thread function_20577f7999c12858("\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*", "(\xdd\xe5W\x1a\xb9!79\x95\xa5P\xf3i\xf87\xe5V}~\xad\xb5\x13\xca\xa9\x03c\xa7", var_7bb19890935c0035);
}

function private function_20577f7999c12858(type, typevalue, var_37d2f643bb3a6c98) {
  structs = level.struct_class_names[type][typevalue];

  if(!isDefined(structs) || !isarray(structs)) {
    return;
  }

  level.struct_class_names[type][typevalue] = [];

  while(istrue(level.var_b57fbdb4bc515ec6)) {
    waitframe();
  }

  level.var_b57fbdb4bc515ec6 = 1;
  var_1768caff055ba48d = 0;

  foreach(struct in structs) {
    if(isDefined(struct.targetname)) {
      level.struct_class_names["\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc"][struct.targetname] = [];
    }

    if(isDefined(struct.target)) {
      level.struct_class_names["\x7fw*%A\xff"][struct.target] = [];
    }

    if(isDefined(struct.script_linkname)) {
      level.struct_class_names["F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13"][struct.script_linkname] = [];
    }

    var_1768caff055ba48d++;

    if(var_1768caff055ba48d >= var_37d2f643bb3a6c98) {
      waitframe();
      var_1768caff055ba48d = 0;
    }
  }

  waitframe();
  level.var_b57fbdb4bc515ec6 = 0;
}

function private function_35adc1c39a7c7548() {
  wait 3;
  function_6edd4ac6c50157bb("<dev string:x474>", "<dev string:x484>");
  waitframe();
  adddebugcommand("<dev string:x4a6>");
  waitframe();
  adddebugcommand("<dev string:x4fc>");
  waitframe();
  adddebugcommand("<dev string:x551>");
  waitframe();
  adddebugcommand("<dev string:x5c2>");
  waitframe();
  adddebugcommand("<dev string:x635>");
  waitframe();
  adddebugcommand("<dev string:x69f>");
  waitframe();
  adddebugcommand("<dev string:x70a>");
  waitframe();
  adddebugcommand("<dev string:x76b>");
  waitframe();
  adddebugcommand("<dev string:x7c9>");

  if(!utility::issp()) {
    test_names = [["<dev string:x823>", "<dev string:x82d>", "<dev string:x840>"], ["<dev string:x823>", "<dev string:x84a>", "<dev string:x85a>"], ["<dev string:x823>", "<dev string:x86c>", "<dev string:x87c>"], ["<dev string:x823>", "<dev string:x88d>", "<dev string:x89a>"], ["<dev string:x823>", "<dev string:x8b3>", "<dev string:x8ba>"], ["<dev string:x8c8>", "<dev string:x82d>", "<dev string:x8d7>"], ["<dev string:x8c8>", "<dev string:x84a>", "<dev string:x8e6>"], ["<dev string:x8c8>", "<dev string:x86c>", "<dev string:x8fd>"], ["<dev string:x8c8>", "<dev string:x88d>", "<dev string:x913>"], ["<dev string:x8c8>", "<dev string:x8b3>", "<dev string:x931>"], ["<dev string:x944>", "<dev string:x82d>", "<dev string:x94d>"], ["<dev string:x944>", "<dev string:x84a>", "<dev string:x956>"], ["<dev string:x944>", "<dev string:x86c>", "<dev string:x967>"], ["<dev string:x944>", "<dev string:x88d>", "<dev string:x977>"], ["<dev string:x944>", "<dev string:x8b3>", "<dev string:x98f>"], ["<dev string:x8b3>", "<dev string:x82d>", "<dev string:x99c>"], ["<dev string:x8b3>", "<dev string:x84a>", "<dev string:x9b8>"], ["<dev string:x8b3>", "<dev string:x86c>", "<dev string:x9dc>"], ["<dev string:x8b3>", "<dev string:x88d>", "<dev string:x9ff>"], ["<dev string:x8b3>", "<dev string:x8b3>", "<dev string:xa2a>"]];

    foreach(test_name in test_names) {
      commandstring = "<dev string:xa4a>" + test_name[0] + "<dev string:xa87>" + test_name[1] + "<dev string:xa8e>" + test_name[2] + "<dev string:xac2>";
      adddebugcommand(commandstring);
    }
  }

  activerequests = [];

  while(true) {
    if(getdvarint(@ "hash_c2967f1425f47dcf", 0) == 1) {
      foreach(requestid in activerequests) {
        function_9ded1e6b967479e0(requestid);
      }

      activerequests = [];
      setDvar(@ "hash_c2967f1425f47dcf", 0);
    }

    bundlename = getDvar(@ "hash_338fd6962a58ef94", "<dev string:xac8>");

    if(isDefined(bundlename) && bundlename != "<dev string:xac8>" && isalive(level.players[0])) {
      fullbundlename = hashcat(%"ai_encounter:", bundlename);
      requestid = spawn_request(fullbundlename, level.players[0].origin, 1000, 1, 1);
      activerequests[activerequests.size] = requestid;
    }

    setDvar(@ "hash_338fd6962a58ef94", "<dev string:xac8>");
    tagname = getDvar(@ "hash_cb77d3c82e353f1d", "<dev string:xac8>");

    if(isDefined(tagname) && tagname != "<dev string:xac8>") {
      function_865271e6009cfb86(tagname, 1);
      setDvar(@ "hash_cb77d3c82e353f1d", "<dev string:xac8>");
    }

    tagname = getDvar(@ "hash_648b265962adac34", "<dev string:xac8>");

    if(isDefined(tagname) && tagname != "<dev string:xac8>") {
      function_865271e6009cfb86(tagname, 0);
      setDvar(@ "hash_648b265962adac34", "<dev string:xac8>");
    }

    if(getdvarint(@ "hash_7560a9c3d8fb8030", 0) == 1) {
      if(isDefined(level.players[0])) {
        function_49600568b241f00e("<dev string:xacc>", level.players[0].origin, 2000);
      }

      setDvar(@ "hash_7560a9c3d8fb8030", 0);
    }

    if(getdvarint(@ "hash_a9bfe570a4470e77", 0) == 1) {
      if(isDefined(level.players[0])) {
        function_8f0ed22bc152e4eb("<dev string:xacc>");
      }

      setDvar(@ "hash_a9bfe570a4470e77", 0);
    }

    if(getdvarint(@ "hash_b887180c55479401", 0) == 1) {
      converted = 0;
      encounters = function_750ddeb5e5e81b9(0, 1);

      foreach(encounter in encounters) {
        data = function_60dad16c45753a36(encounter);

        if(data.status != 1) {
          function_c15aea90f8f85ed1(encounter);
          iprintlnbold("<dev string:xade>" + encounter + "<dev string:xaf7>");
        }
      }

      if(!converted) {
        iprintlnbold("<dev string:xb07>");
      }

      setDvar(@ "hash_b887180c55479401", 0);
    }

    if(getdvarint(@ "hash_5052dcf9e0cb4ce1", 0) == 1) {
      if(isDefined(level.players[0])) {
        zoneindex = function_24d750c377e84b79(level.players[0].origin);
        function_234dbc00c710b2b2(zoneindex);
      }

      setDvar(@ "hash_5052dcf9e0cb4ce1", 0);
    }

    if(getdvarint(@ "hash_e1ca0daaa71ada82", 0) == 1) {
      if(isDefined(level.players[0])) {
        subzone = function_38abc66c7da06907(level.players[0].origin);

        if(isDefined(subzone)) {
          function_ab5c2b8125c7ff56(subzone.zoneindex, subzone.subzoneindex, !subzone.enabled);
        }
      }

      setDvar(@ "hash_e1ca0daaa71ada82", 0);
    }

    settag = getDvar(@ "hash_6c37cbeecb7d7215", "<dev string:xac8>");

    if(isDefined(settag) && settag != "<dev string:xac8>") {
      subzone = function_38abc66c7da06907(level.players[0].origin);

      if(isDefined(subzone)) {
        function_dc9030e7cc553ceb(subzone.zoneindex, subzone.subzoneindex, settag, 1);
      }

      setDvar(@ "hash_6c37cbeecb7d7215", "<dev string:xac8>");
    }

    cleartag = getDvar(@ "hash_226b7063f48ab77a", "<dev string:xac8>");

    if(isDefined(cleartag) && cleartag != "<dev string:xac8>") {
      subzone = function_38abc66c7da06907(level.players[0].origin);

      if(isDefined(subzone)) {
        function_dc9030e7cc553ceb(subzone.zoneindex, subzone.subzoneindex, cleartag, 0);
      }

      setDvar(@ "hash_226b7063f48ab77a", "<dev string:xac8>");
    }

    test_name = getDvar(@ "hash_25688c988df289c3", "<dev string:xac8>");

    if(test_name != "<dev string:xac8>") {
      if(isDefined(level.var_f244062a0253bc61)) {
        thread[[level.var_f244062a0253bc61]](test_name);
      }

      setDvar(@ "hash_25688c988df289c3", "<dev string:xac8>");
    }

    var_c09665a4ed2cbf59 = getDvar(@ "hash_76a02dcfeaf85e8a", "<dev string:xac8>");

    if(var_c09665a4ed2cbf59 != "<dev string:xac8>") {
      thread[[level.var_33199ed192d1ba4c]](var_c09665a4ed2cbf59);
      setDvar(@ "hash_76a02dcfeaf85e8a", "<dev string:xac8>");
    }

    if(getdvarint(@ "hash_b8cb86dbb04715e2", 0) == 1) {
      function_865271e6009cfb86("<dev string:xb2f>", 1);
      function_865271e6009cfb86("<dev string:xb44>", 0);
      setDvar(@ "hash_19f0eb1fd6a2f87d", 1);
      setDvar(@ "hash_b8cb86dbb04715e2", 0);
    }

    if(getdvarint(@ "hash_48e36b0fa33ce48f", 0) == 1) {
      function_865271e6009cfb86("<dev string:xb2f>", 0);
      function_865271e6009cfb86("<dev string:xb44>", 1);
      setDvar(@ "hash_19f0eb1fd6a2f87d", 1);
      setDvar(@ "hash_48e36b0fa33ce48f", 0);
    }

    lwagentid = getdvarint(@ "hash_14b4dd6c9138d7a6", -1);

    if(lwagentid != -1) {
      function_dc5721f63ba47169(lwagentid, 10000);
      setDvar(@ "hash_14b4dd6c9138d7a6", -1);
    }

    encounterid = getdvarint(@ "hash_ff2bcf56da809d00", -1);

    if(encounterid != -1) {
      function_d7ad7d403f75f142(encounterid, 10000);
      setDvar(@ "hash_ff2bcf56da809d00", -1);
    }

    waitframe();
  }
}

function private function_6edd4ac6c50157bb(var_fb9132725915ffa4, dvarname) {
  bundlenames = getscriptbundlenames(var_fb9132725915ffa4);

  foreach(bundlename in bundlenames) {
    bundlenamestring = getxhashsourcename(bundlename);
    array = strtok(bundlenamestring, "<dev string:xb58>");

    if(!(isDefined(array) && isDefined(array[1]))) {
      continue;
    }

    cmdstring = "<dev string:xb5d>" + array[1] + "<dev string:xb89>" + dvarname + "<dev string:xb94>" + array[1] + "<dev string:xac2>";
    adddebugcommand(cmdstring);
    waitframe();
  }
}

function private function_837ea02406905690() {
  if(getdvarint(@ "ai_spawn_director_check_out_of_bounds", 0) == 1 && isDefined(level.outofboundstriggers)) {
    function_b048404d5a0b295d(level.outofboundstriggers);
  }
}

function private function_4648ff7c0e150e15() {
  wait 1;

  while(true) {
    settag = getDvar(@ "hash_c1b168fb1d959c2f", "");

    if(isDefined(settag) && settag != "") {
      function_865271e6009cfb86(settag, 1);
      setDvar(@ "hash_c1b168fb1d959c2f", "");
    }

    cleartag = getDvar(@ "hash_91f3192aa5d2ec6c", "");

    if(isDefined(cleartag) && cleartag != "") {
      function_865271e6009cfb86(cleartag, 0);
      setDvar(@ "hash_91f3192aa5d2ec6c", "");
    }

    wait 1;
  }
}

function private function_6a22b3dc8e663ef5() {
  waitframe();

  if(!function_2c9bd3508482a542()) {
    return;
  }

  if(isDefined(level.var_bccf7e6f4cb1946e)) {
    return;
  }

  level.var_b57fbdb4bc515ec6 = 0;
  level.var_bccf7e6f4cb1946e = 1;
  level.var_46b956684f9e54fa = &function_616aa1e6adfb165d;
  level.var_bbd85d958a110a1f = [];
  level.aipatrolpaths = [];

  if(!isDefined(level.var_6d62ed2c92ce6095)) {
    level.var_6d62ed2c92ce6095 = [];
  }

  if(!isDefined(level.var_f3b4ca73dd283c27)) {
    level.var_f3b4ca73dd283c27 = [];
  }

  level.var_f93e405ca717ad72 = [];
  level.var_1186e9c93441116f = [];
  level.var_fe423ca9a5b9f51d = [];
  level.var_88998ce454963317 = [];
  level.var_bfd92fe24051ccf8 = &function_30fa9b3e59df8157;
  level.var_a13289363545c979 = &function_cf098fa4b25dc3e3;
  level.var_45c0327152b99d94 = &function_4527f06dc38a14d2;
  level.var_fc3586f4808e11b9 = &function_cf5b68c82e02aac3;
  level.var_f289dce7e41b6a63 = &function_e89f6c8e766781b6;
  level.var_d18c8320030cf07f = &function_2bbaa80c8a9e0e49;
  level.var_8461a992eaec43c3 = &function_193376262b3a031d;
  level.var_3f77b0d0d1a5c975 = &function_bd31093e9959063f;
  level.var_6f2033beed99efb9 = &namespace_cd46d422f152c4f5::function_a8996b6bad9cbfb7;
  level.var_59554315c8f65e96 = &function_301e66f53df17c28;
  level.var_d738957173814f2b = &_precombat;
  namespace_5a0ff95f3569ef9c::function_2667f225f2e4c2bc();
  thread function_edef9b71960c7fd7();
  thread function_4648ff7c0e150e15();
  function_837ea02406905690();
  function_93671d8129ddf828();

  level thread function_35adc1c39a7c7548();

  if(isDefined(level.outofboundstriggers)) {
    function_b42a50571be31122(level.outofboundstriggers);
  }

  assert(istrue(level.var_f15b6a4bedd7efcd), "<dev string:xb99>");
  function_4d3fe812795abf59();
  utility::flag_set("\xb3\xa2\xd5\x7f\x9c\xef~`\xe6\xe1S\xa8\x88\xa2\aS\xc5ohnP98\f\xd0\x91\x17\xdb\x88");
}

function autoexec director_init() {
  thread function_6a22b3dc8e663ef5();
}

function function_bac6dbbc3e0b72da() {
  level.var_9acc1b54ef6eed83 = function_750ddeb5e5e81b9(1, 0);
  level.var_3e95068bc85ccddf = [];
  level.var_6bf95020fdd3541c = [];
  reinforcementareas = utility::getStructArray("\xcf\xc0\x19\x0f\x85\x8d\x93\xb4\x12\xc2\x8d<\xbf\xd4\xd0x8\x80t7\xedu\x90\xc2\x10B\x15M\a\xe8", "!DOn\xba'\xed\x8e&!\\");

  foreach(area in reinforcementareas) {
    bundlename = hashcat(%"hash_4f99210e7aa63124", area.var_27d85720f7c46aa);

    if(!isDefined(level.var_6bf95020fdd3541c[bundlename])) {
      bundle = getscriptbundle(bundlename);

      if(!isDefined(bundle)) {
        assertmsg("<dev string:xbf0>" + bundlename);
        continue;
      } else {
        level.var_6bf95020fdd3541c[bundlename] = bundle;
      }
    }

    areaindex = function_b9dad8d9a28d7a6d(area, bundlename);
  }
}

function function_b9dad8d9a28d7a6d(structpoi, reinforcementbundlename) {
  areaindex = level.var_3e95068bc85ccddf.size;
  reinforcementarea = spawnStruct();
  reinforcementarea.var_4c7051d64bb23f5 = [];
  reinforcementarea.numaideaths = 0;
  reinforcementarea.reinforcementareaindex = areaindex;
  reinforcementarea.reinforcementbundlename = reinforcementbundlename;
  reinforcementarea.targetname = structpoi.targetname;
  reinforcementarea.enabled = 1;
  level.var_3e95068bc85ccddf[areaindex] = reinforcementarea;

  foreach(encounterid in level.var_9acc1b54ef6eed83) {
    encountercenter = function_1a0240c35d1fd2ff(encounterid);
    encounterradius = function_21ea67cea5d5d53c(encounterid);

    if(function_b6d47680202b60be(structpoi.origin, structpoi.radius, encountercenter, encounterradius)) {
      var_ff9b32096d1fbc0f = level.var_3e95068bc85ccddf[areaindex].var_4c7051d64bb23f5.size;
      level.var_3e95068bc85ccddf[areaindex].var_4c7051d64bb23f5[var_ff9b32096d1fbc0f] = encounterid;
    }
  }

  level thread function_5aed42aa4ea74449(areaindex);
  return areaindex;
}

function function_cbc37bb2b6f91c2b(requestid) {
  if(isDefined(level.var_3e95068bc85ccddf)) {
    foreach(area in level.var_3e95068bc85ccddf) {
      foreach(trackedrequest in area.var_4c7051d64bb23f5) {
        if(requestid == trackedrequest) {
          return area.reinforcementareaindex;
        }
      }
    }
  }

  return undefined;
}

function function_6acb2509a7dac0e6(areaname) {
  if(isDefined(level.var_3e95068bc85ccddf)) {
    foreach(area in level.var_3e95068bc85ccddf) {
      if(areaname == area.targetname) {
        return area.reinforcementareaindex;
      }
    }
  }

  return undefined;
}

function function_2d27833e6b824100(areaindex, shoulddisable) {
  if(isDefined(level.var_3e95068bc85ccddf[areaindex])) {
    level.var_3e95068bc85ccddf[areaindex].enabled = !shoulddisable;
  }
}

function function_b4b5b1330cdefd8a(reinforcementareaindex) {
  thread function_b0b8d6f082ee0f73(reinforcementareaindex);
}

function private function_b6d47680202b60be(firstcenter, firstradius, secondcenter, secondradius) {
  distsq = distancesquared(firstcenter, secondcenter);
  radiisum = firstradius + secondradius;
  radiisumsq = radiisum * radiisum;
  return distsq <= radiisumsq;
}

function private function_b0b8d6f082ee0f73(areaindex) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self waittill("\x1e\xfd\xd1\xa2\a", attacker);

  if(isDefined(attacker) && isPlayer(attacker)) {
    if(!istrue(level.var_3e95068bc85ccddf[areaindex].enabled)) {
      return;
    }

    level.var_3e95068bc85ccddf[areaindex].numaideaths++;
    level.var_3e95068bc85ccddf[areaindex].var_2c71224255917a82 = self.origin;
    level.var_3e95068bc85ccddf[areaindex].var_c2378a553b59744c = self.directorrequestid;
  }
}

function private function_5aed42aa4ea74449(areaindex) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  reinforcementarea = level.var_3e95068bc85ccddf[areaindex];
  areaname = reinforcementarea.targetname;
  bundle = level.var_6bf95020fdd3541c[reinforcementarea.reinforcementbundlename];
  deaththreshold = bundle.reinforcementareatuning.deathcountthreshold;

  if(!isDefined(reinforcementarea.var_25ab3b9cbee9c714)) {
    level.var_3e95068bc85ccddf[areaindex].var_25ab3b9cbee9c714 = gettime();
  }

  var_8e7969aa904d57c4 = getdvarfloat(@ "hash_9f4f1e52992402ae");
  var_94c75f20531629cf = 0;

  while(!var_94c75f20531629cf) {
    reinforcementarea = level.var_3e95068bc85ccddf[areaindex];

    if(reinforcementarea.numaideaths >= deaththreshold && gettime() > reinforcementarea.var_25ab3b9cbee9c714) {
      var_4f942d0986d30682 = function_f5cf0a13a008a17e(reinforcementarea.var_2c71224255917a82);

      if(var_4f942d0986d30682 >= var_8e7969aa904d57c4 && istrue(reinforcementarea.enabled)) {
        var_94c75f20531629cf = 1;
      }
    }

    waitframe();
  }

  encounterstruct = function_59f0fd2bb209bdb1(areaindex, bundle);

  if(!isDefined(encounterstruct.encounterbundlename)) {
    assertmsg("<dev string:xc23>" + areaname + "<dev string:xc60>" + reinforcementarea.var_2c71224255917a82);
    return;
  }

  function_3577e8e98d026e2e(areaindex, encounterstruct, bundle);
  level thread function_5aed42aa4ea74449(areaindex);
}

function private function_59f0fd2bb209bdb1(areaindex, bundle) {
  encounterstruct = spawnStruct();
  validencounters = [];

  foreach(encounter in bundle.potentialencounters) {
    var_7de8f58d349982fc = getxhashasset(encounter.encounter);
    potentialencounterbundle = getscriptbundle(var_7de8f58d349982fc);
    requiresalltags = encounter.requiredalltags;

    foreach(requiredtag in potentialencounterbundle.requiredtags) {
      hastags = 1;
      tagsvalid = function_5e2f03dd0992df68(level.var_3e95068bc85ccddf[areaindex].var_2c71224255917a82, requiredtag.tag);

      if(!tagsvalid && istrue(requiresalltags) || tagsvalid && !istrue(requiresalltags)) {
        break;
      }
    }

    if(!istrue(tagsvalid) && istrue(hastags)) {
      continue;
    }

    if(encounter.radiusmin < encounter.radiusmax) {
      encounterstruct.reinforceradius = randomfloatrange(encounter.radiusmin, encounter.radiusmax);
    } else {
      encounterstruct.reinforceradius = encounter.radiusmin;
    }

    encounterstruct.vehiclespawntype = potentialencounterbundle.potentialbuckets[0].vehiclespawntype;
    encounterstruct.encounterbundlename = encounter.encounter;
    validencounters[validencounters.size] = encounterstruct;
  }

  encounterstruct = utility::array_random(validencounters);
  return encounterstruct;
}

function private function_3577e8e98d026e2e(areaindex, encounterstruct, bundle) {
  reinforcementarea = level.var_3e95068bc85ccddf[areaindex];
  reinforcementorigin = reinforcementarea.var_2c71224255917a82;
  vehiclespawntype = encounterstruct.vehiclespawntype;
  validlocationspawnpoints = [];
  locationspawns = function_d606f067e096b865(reinforcementarea.var_2c71224255917a82, 5000);

  if(isDefined(vehiclespawntype) && isDefined(locationspawns)) {
    foreach(point in locationspawns) {
      validlocationspawnpoint = spawnStruct();

      if(#"parachute" == vehiclespawntype && istrue(point.isparachutespawn)) {
        validlocationspawnpoint.point = point;
        validlocationspawnpoint.influence = function_f5cf0a13a008a17e(point.location);
        validlocationspawnpoints[validlocationspawnpoints.size] = validlocationspawnpoint;
        continue;
      }

      if(#"groundvehicle" == vehiclespawntype || #"airvehicle" == vehiclespawntype) {
        if(isDefined(point.vehiclepathtargetname)) {
          validlocationspawnpoint.point = point;
          validlocationspawnpoint.influence = function_f5cf0a13a008a17e(point.location);
          validlocationspawnpoints[validlocationspawnpoints.size] = validlocationspawnpoint;
        }
      }
    }

    if(validlocationspawnpoints.size >= 1) {
      if(validlocationspawnpoints.size == 1) {
        spawnorigin = validlocationspawnpoints[0].location;
      } else {
        maxinfluence = -1;

        foreach(locspawn in validlocationspawnpoints) {
          if(locspawn.influence > maxinfluence) {
            maxinfluence = locspawn.influence;
            spawnorigin = locspawn.point.location;
          }
        }
      }
    }
  }

  if(!isDefined(spawnorigin)) {
    spawnorigin = reinforcementorigin;
  }

  requestid = spawn_request(encounterstruct.encounterbundlename, reinforcementorigin, encounterstruct.reinforceradius, 0, 1, 0, 1);
  function_158235c9829edd62(requestid, spawnorigin, encounterstruct.reinforceradius, 0);
  function_36fcb84d1ddc8c4(requestid, 1);
  cooldowntime = randomfloatrange(bundle.reinforcementareatuning.cooldownmin, bundle.reinforcementareatuning.cooldownmax) * 1000;
  level.var_3e95068bc85ccddf[areaindex].numaideaths = 0;
  level.var_3e95068bc85ccddf[areaindex].var_d8987c646c23b361 = gettime();
  level.var_3e95068bc85ccddf[areaindex].var_25ab3b9cbee9c714 = gettime() + cooldowntime;
}

function private _wander(agent, radius, radiusvariance, origin) {
  savedorigin = origin;

  if(isagent(agent) && !isDefined(origin)) {
    savedorigin = agent.origin;
  }

  if(!isDefined(radius)) {
    radius = 100;
  }

  if(!isDefined(radiusvariance) || radiusvariance <= 0) {
    radiusvariance = 50;
  }

  agent endon("\x1e\xfd\xd1\xa2\a");
  agent endon("\x16\x1c\x87\xe3\xdf\x8f`\xc9\x1fL=\xfa\xb7d\xe3\r.\x8c\xa7");
  agent endon("\xb6\x15\xa8U\xb5\xfd\a<\\b\xec\xd9");
  agent endon("'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ");
  agent endon("\x13\xc0\xb5\x99\xf3\xe9\xcfE\x9a\xbf`3I\xa4\xce");
  wait 1;

  if(isDefined(origin) && distance2dsquared(origin, agent.origin) > 4096) {
    _setgoalpos(origin, 32, 1);
    agent waittill("\x83\xd6\xaf\x11");
  }

  originalorigin = agent.origin;
  min = radius - radiusvariance;
  max = radius + radiusvariance;

  while(true) {
    random_x = randomfloatrange(min, max) * (randomint(100) > 50 ? 1 : -1);
    random_y = randomfloatrange(min, max) * (randomint(100) > 50 ? 1 : -1);
    var_920553849e9f803a = (originalorigin[0] + random_x, originalorigin[1] + random_y, originalorigin[2]);

    if(distance2d(agent.origin, var_920553849e9f803a) > 20) {
      agent _setgoalpos(var_920553849e9f803a, 8);
      agent thread function_ed36f75e8c29acc5(agent);
      agent utility::waittill_any("\x83\xd6\xaf\x11", "\xb3\xebF?~\x9f\xbdiw\xd0y\xe4i\xa8");
    }

    wait randomfloatrange(4.5, 5.5);
  }
}

function private _setgoalpos(origin, goalradius, var_19c223695f9f3a3c, bunbounded = 0) {
  if(istrue(self.fixednode) || !isalive(self)) {
    return;
  }

  if(!istrue(var_19c223695f9f3a3c)) {
    function_272bfbdafb9ee1be(goalradius);
  }

  safeorigin = self getclosestreachablepointonnavmesh(origin, bunbounded);

  if(!isDefined(safeorigin)) {
    println("<dev string:xc70>" + origin);
    return;
  }

  if(!isDefined(self.origin)) {
    assertmsg("<dev string:xcb2>");
    return;
  }

  if(distance2d(self.origin, safeorigin) > 20) {
    self setgoalpos(safeorigin);
  }
}

function private function_ed36f75e8c29acc5(agent, time) {
  agent endon("\x83\xd6\xaf\x11");
  agent endon("\x1e\xfd\xd1\xa2\a");
  waittime = 5;

  if(isDefined(time)) {
    waittime = time;
  }

  wait waittime;
  agent notify("\xb3\xebF?~\x9f\xbdiw\xd0y\xe4i\xa8");
}

function private function_2e4da1926d7716a5(var_ce49a59e14cf2fd8) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  utility::waittill_any("'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ", "\x13\xc0\xb5\x99\xf3\xe9\xcfE\x9a\xbf`3I\xa4\xce");
  goalvol = function_ac311f3d6717d47d(var_ce49a59e14cf2fd8, #targetname);

  if(!isDefined(goalvol[0])) {
    goalstruct = utility::getStruct(var_ce49a59e14cf2fd8, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

    if(isDefined(goalstruct)) {
      _setgoalpos(goalstruct.origin, goalstruct.radius);
    } else {
      assertmsg("<dev string:x55>" + var_ce49a59e14cf2fd8 + "<dev string:x79>");
    }

    return;
  }

  self setgoalvolumeauto(goalvol[0]);
}

function private function_272bfbdafb9ee1be(goalradius) {
  if(!isDefined(goalradius)) {
    goalradius = 128;
  }

  self.goalradius = int(goalradius);
  self.script_goalradius = goalradius;
}

function function_fb89dad19c0406db(path_array, var_e3cac5fdaf641916) {
  if(!isDefined(level.aipatrolpaths[path_array[0].id])) {
    pathstruct = spawnStruct();
    pathstruct.current_ai = [];
    pathstruct.current_ai[pathstruct.current_ai.size] = self;
    pathstruct.patrolpath = path_array;
    pathstruct.var_42952beda7059763 = path_array[0].var_42952beda7059763;
    pathstruct.var_834180893f408555 = path_array[0].var_834180893f408555;
    level.aipatrolpaths[path_array[0].id] = pathstruct;
    level thread function_39f80c835b52c403(path_array[0].id, pathstruct, var_e3cac5fdaf641916);
  } else if(isDefined(level.aipatrolpaths[path_array[0].id]) && level.aipatrolpaths[path_array[0].id].current_ai.size == 0) {
    patrolpath = level.aipatrolpaths[path_array[0].id];
    patrolpath.current_ai[patrolpath.current_ai.size] = self;
    level thread function_39f80c835b52c403(path_array[0].id, patrolpath, var_e3cac5fdaf641916);
  } else {
    patrolpath = level.aipatrolpaths[path_array[0].id];
    patrolpath.current_ai[patrolpath.current_ai.size] = self;
  }

  if(!isDefined(self.patroldata)) {
    patroldata = spawnStruct();
    patroldata.patrolpath = level.aipatrolpaths[path_array[0].id];
    patroldata.nodeindex = 0;
    self.patroldata = patroldata;
  }
}

function private function_fbd9197b74578b0d(path_array) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x16\x1c\x87\xe3\xdf\x8f`\xc9\x1fL=\xfa\xb7d\xe3\r.\x8c\xa7");
  self endon("\xb6\x15\xa8U\xb5\xfd\a<\\b\xec\xd9");
  self endon("'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ");
  self endon("\x13\xc0\xb5\x99\xf3\xe9\xcfE\x9a\xbf`3I\xa4\xce");
  self waittill("\xa4\xc8\xbas\x90\x8b\xbe\xd1\xef<R\xda\xc4\xe3\x9b\x9f\x0f");
  function_fb89dad19c0406db(path_array);
}

function private function_39f80c835b52c403(pathindex, pathstruct, var_f4f1ad935c377784) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  endon_agents = [];
  patrolpath = pathstruct.patrolpath;
  pathstruct.claimed = 1;
  index = 0;
  forwarddirection = 1;

  while(true) {
    var_d9a615b5c0c7ca68 = level.aipatrolpaths[pathindex].current_ai;
    point = patrolpath[index].origin;

    foreach(agentindex, agent in var_d9a615b5c0c7ca68) {
      if(istrue(agent.var_dfe89c2b73dc3659)) {
        continue;
      }

      if(!isDefined(endon_agents[agentindex])) {
        agent endon("\x1e\xfd\xd1\xa2\a");
        agent endon("\x16\x1c\x87\xe3\xdf\x8f`\xc9\x1fL=\xfa\xb7d\xe3\r.\x8c\xa7");
        agent endon("\xb6\x15\xa8U\xb5\xfd\a<\\b\xec\xd9");
        agent endon("'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ");
        agent endon("\x13\xc0\xb5\x99\xf3\xe9\xcfE\x9a\xbf`3I\xa4\xce");
        agent endon("\x02\xef\b\x87\x01 \xe0\xb5\x15\xa4%\xcf\xd4\x90<d\"?{\x88\xc8\xb5T\x05\xc5\xa8");
        endon_agents[agentindex] = agent;

        if(isDefined(agent.patroldata.nodeindex)) {
          index = agent.patroldata.nodeindex;
          point = patrolpath[index].origin;
        }

        if(istrue(var_f4f1ad935c377784)) {
          nodeindex = 0;

          foreach(patrolnode in patrolpath) {
            patrolnode.nodeindex = nodeindex;
            nodeindex++;
          }

          sortedpathnodes = utility::get_array_of_closest(agent.origin, patrolpath);
          index = sortedpathnodes[0].nodeindex;
          point = patrolpath[index].origin;
        }

        agent thread function_532d836172bc0d88(pathindex);
        agent thread function_94b4d75f92e5d96d(pathindex);
      }

      if(agentindex != 0) {
        random_x = randomfloatrange(30, 31) * (utility::cointoss() ? 1 : -1);
        random_y = randomfloatrange(30, 31) * (utility::cointoss() ? 1 : -1);
        point = (point[0] + random_x, point[1] + random_y, point[2]);
      }

      if(isDefined(patrolpath[index].interaction_id) && patrolpath[index].interaction_id != -1) {
        if(isDefined(patrolpath[index].script_delay_min) && patrolpath[index].script_delay_min == patrolpath[index].script_delay_max) {
          if(patrolpath[index].script_delay_min != 0) {
            patrolpath[index].script_delay = patrolpath[index].script_delay_min;
          }

          patrolpath[index].script_delay_min = undefined;
          patrolpath[index].script_delay_max = undefined;
        }

        agent._blackboard.idlenode = patrolpath[index];
        agent leaveinteraction();
        agent _setgoalpos(function_658a8c3245e83656(patrolpath[index].interaction_id), 64);
        agent function_47127b28b1fb3f1e(patrolpath[index].interaction_id);

        if(isDefined(patrolpath[index].repeat_interaction) && istrue(int(patrolpath[index].repeat_interaction))) {
          agent.var_dfe89c2b73dc3659 = 1;
        }
      } else {
        agent leaveinteraction();
        agent _setgoalpos(point, 64);
      }

      if(istrue(patrolpath[index].var_48058383e8809395)) {
        agent.customarrivalangles = patrolpath[index].angles;
      }

      if(var_d9a615b5c0c7ca68.size > 1 && agentindex == 0) {
        wait 3;
      }

      if(var_d9a615b5c0c7ca68.size > 1 && agentindex != 0) {
        wait randomfloatrange(1.5, 2.5);
      }
    }

    shouldcontinue = 0;

    foreach(agentindex, agent in var_d9a615b5c0c7ca68) {
      if(!istrue(agent.var_dfe89c2b73dc3659)) {
        shouldcontinue = 1;
        break;
      }
    }

    if(!shouldcontinue) {
      break;
    }

    waitframe();
    var_d9a615b5c0c7ca68[0] utility::waittill_any("\x83\xd6\xaf\x11", "]7\x90\xc1\x84\x9f\x1e");

    if(isDefined(var_d9a615b5c0c7ca68[0] getinteractionid())) {
      var_d9a615b5c0c7ca68[0] waittill("\xa4\xc8\xbas\x90\x8b\xbe\xd1\xef<R\xda\xc4\xe3\x9b\x9f\x0f");
    }

    if(patrolpath[index].var_e5424e5771aec0e9 < patrolpath[index].var_98a8e883b6a69fd7) {
      wait randomfloatrange(patrolpath[index].var_e5424e5771aec0e9, patrolpath[index].var_98a8e883b6a69fd7);
    } else {
      wait patrolpath[index].var_e5424e5771aec0e9;
    }

    if(forwarddirection) {
      index++;
    } else {
      index--;
    }

    foreach(agent in var_d9a615b5c0c7ca68) {
      agent.customarrivalangles = undefined;
    }

    if(!isDefined(patrolpath[index])) {
      if(!pathstruct.var_42952beda7059763 && !pathstruct.var_834180893f408555) {
        break;
      } else if(pathstruct.var_834180893f408555) {
        index = 0;
      } else if(forwarddirection) {
        index = int(max(patrolpath.size - 2, 0));
        forwarddirection = 0;
      } else {
        index = int(min(1, patrolpath.size - 1));
        forwarddirection = 1;
      }
    }

    agent.patroldata.nodeindex = index;
  }
}

function private function_94b4d75f92e5d96d(pathindex) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  utility::waittill_any("\x16\x1c\x87\xe3\xdf\x8f`\xc9\x1fL=\xfa\xb7d\xe3\r.\x8c\xa7", "\xb6\x15\xa8U\xb5\xfd\a<\\b\xec\xd9", "'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ", "\x13\xc0\xb5\x99\xf3\xe9\xcfE\x9a\xbf`3I\xa4\xce", "\x02\xef\b\x87\x01 \xe0\xb5\x15\xa4%\xcf\xd4\x90<d\"?{\x88\xc8\xb5T\x05\xc5\xa8");
  self.customarrivalangles = undefined;
  function_cd6526a97702bb93(pathindex);
}

function private function_532d836172bc0d88(pathindex) {
  self waittill("\x1e\xfd\xd1\xa2\a");
  function_cd6526a97702bb93(pathindex);
}

function private function_cd6526a97702bb93(pathindex) {
  foreach(agent in level.aipatrolpaths[pathindex].current_ai) {
    if(agent == self) {
      level.aipatrolpaths[pathindex].current_ai[agentindex] = undefined;
      break;
    }
  }

  if(istrue(level.aipatrolpaths[pathindex].claimed) && level.aipatrolpaths[pathindex].current_ai.size == 0) {
    level.aipatrolpaths[pathindex].claimed = 0;
  }
}

function private function_fd6bfb18b49d3435(requestid) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(self.unittype == "\xb9\xdb6d-\xb2\xc9") {
    function_ae4bceb730956639();
    return;
  }

  function_2bffb0559000b00b();
}

function private function_ae4bceb730956639() {
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(self.unittype == "<dev string:xced>");
  requestid = self.directorrequestid;
  callbackstruct = function_30fa9b3e59df8157("\xc6*Q\x85\"\x02\x89|.Cf\xf2\x01O\xec2", requestid);

  if(isDefined(callbackstruct)) {
    thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata);
  }

  while(!function_676b09a44f1f5661(self)) {
    var_217558789f009033 = 0;

    while(isDefined(self.enemy) && isalive(self.enemy) && isPlayer(self.enemy) && distancesquared(self.origin, self.enemy.origin) <= 262144) {
      var_217558789f009033 = 1;
      self.pathenemyfightdist = 0;
      self.pathenemylookahead = 0;
      self.var_a80c7aea6e094817 = 0;
      self setbtgoalRadius(2, 256);
      self setbtgoalpos(2, self.enemy.origin);
      wait 5;
    }

    if(var_217558789f009033) {
      continue;
    }

    despawnpos = function_71b76b435a1d7b54(self);
    starttime = gettime();

    if(isDefined(despawnpos)) {
      self setbtgoalpos(2, despawnpos);
      self setbtgoalRadius(2, 256);
      self waittill("]7\x90\xc1\x84\x9f\x1e");
    }

    waittime = getdvarfloat(@ "hash_273a7f3e61e64e35", 10);
    timediffseconds = (gettime() - starttime) / 1000;

    if(timediffseconds < waittime) {
      wait waittime - timediffseconds;
    }
  }

  function_1af3b0e01261018d(1);
}

function private function_246f2c2128369826() {
  self endon("\x1e\xfd\xd1\xa2\a");
  despawntime = randomfloatrange(getdvarint(@ "hash_96955f67517b7611", 5), getdvarint(@ "hash_96b8716751a1e55f", 10));
  wait despawntime;
  function_2fd04d6b5090696e();
}

function private function_2fd04d6b5090696e() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(self.type == "\x9b\x11\"\xd6\xfb;") {
    _zombiekill(0);
    return;
  }

  function_1af3b0e01261018d(0);
}

function private function_1af3b0e01261018d(var_f7e4f988e625d7bf) {
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(self.type != "<dev string:xcf8>");
  self.nocorpse = 1;
  self.var_918e9d9ff7329f1a = 1;
  self.dropweapon = 0;

  if(istrue(self.magic_bullet_shield)) {
    ai::stop_magic_bullet_shield();
  }

  if(isDefined(level.var_291ff58abadc3b95)) {
    self[[level.var_291ff58abadc3b95]](var_f7e4f988e625d7bf);
  }
}

function private function_a85f2d7c65ab279e(encounterradius) {
  self endon("\x1e\xfd\xd1\xa2\a");
  spawnpoint = self.origin;
  maxdistance = encounterradius * getdvarfloat(@ "hash_a99b215bdc4d8f7d", 5);
  maxdistancesqr = maxdistance * maxdistance;

  while(true) {
    wait randomfloatrange(5, 7);

    if(distancesquared(self.origin, spawnpoint) > maxdistancesqr) {
      function_ec175cd6d5393d40("<dev string:xd02>" + self getentitynumber() + "<dev string:xd18>" + self.directorrequestid);

      function_2bffb0559000b00b();
    }
  }
}

function private function_2bffb0559000b00b() {
  self endon("\x1e\xfd\xd1\xa2\a");
  requestid = self.directorrequestid;
  callbackstruct = function_30fa9b3e59df8157("\xc6*Q\x85\"\x02\x89|.Cf\xf2\x01O\xec2", requestid);

  if(isDefined(callbackstruct)) {
    thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata);
  }

  if(function_f5cf0a13a008a17e(self.origin) > getdvarfloat(@ "hash_d31bf82a85c7351", 0)) {
    if(istrue(self._blackboard.zombieindespawn)) {
      return;
    }

    self notify("~\x12\xb1w\x8eC\x80");

    if(self asmhasstate(self.asmname, "\xda\xb6\x84_ ax\xd6\xb5\xd2")) {
      self.nocorpse = 1;
      asm::asm_setstate("\xda\xb6\x84_ ax\xd6\xb5\xd2");
      return;
    }
  }

  _zombiekill(1);
}

function private _zombiekill(var_f7e4f988e625d7bf) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!var_f7e4f988e625d7bf) {
    requestid = self.directorrequestid;
    callbackstruct = function_30fa9b3e59df8157("\xc6*Q\x85\"\x02\x89|.Cf\xf2\x01O\xec2", requestid);

    if(isDefined(callbackstruct)) {
      thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata);
    }
  }

  if(istrue(self.magic_bullet_shield)) {
    ai::stop_magic_bullet_shield();
  }

  self.nocorpse = 1;
  self.var_918e9d9ff7329f1a = 1;
  self kill();
}

function private function_4527f06dc38a14d2(requestid, unload_pos) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\xb47\xe8Q\xb4\xec7<\xda\x01\xf8\xbc\xb1\x90+\x02");
  self vehphys_parkingbrake(1);
  self setconfigvalue("\xf5C'", "\xedp\xc2t_\x9cGw5cT", utility::mph_to_ips(0));
  self vehicle_setspeedimmediate(0, 1, 1);
  self vehicle_cleardrivingstate();
  riders = self.riders;

  foreach(rider in self.riders) {
    rider thread function_cf5b68c82e02aac3(requestid, unload_pos);
  }

  vehicle_code::_vehicle_unload("\x91\xca\xcc\v\xab\xd8:");

  if(vehicle_aianim::riders_unloadable("\x91\xca\xcc\v\xab\xd8:")) {
    self waittill("\x9er\x94D?\xa3\x0f\xe2");
  }

  if(self hascomponent("\xf5C'")) {
    self removecomponent("\xf5C'");
  }

  if(self hascomponent("D\xc7\xb3\x91")) {
    self removecomponent("D\xc7\xb3\x91");
  }

  self vehphys_parkingbrake(0);

  if(isDefined(level.var_3e76fa2d370cb33a)) {
    self[[level.var_3e76fa2d370cb33a]]();
  }

  vehicle_occupancy::set_team(self, "\xba\xa5\x1f\xc9m\x80i");
  vehicle_interact::allow_use(self, 1);
  function_60fd7d4376c1cfe6(requestid);
}

function private function_2bbaa80c8a9e0e49(requestid) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  entnum = self getentitynumber();
  self waittill("\x1e\xfd\xd1\xa2\a", attacker, meansofdeath);
  function_e48c8bf9cb11d9b7(requestid, entnum);
}

function private function_193376262b3a031d(requestid) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\xb7pc=\x05X\xba\x8f\x85\xd1R\xf5\xd5\xb9\x7f\x06*\xdd\xce\xca");
  function_e48c8bf9cb11d9b7(requestid, self getentitynumber());
}

function private function_cf5b68c82e02aac3(requestid, unload_pos) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\a-\xf8\xc8 \x9b");

  while(self islinked()) {
    waitframe();
  }

  wait 1;

  if(!isDefined(unload_pos)) {
    unload_pos = self.origin;
  }

  _setgoalpos(unload_pos, 512);
  function_e89f6c8e766781b6(requestid);
  thread _precombat(self.directorspawndata);
}

function private function_4395ace3069093bf(vehiclenodeindex) {
  result = undefined;
  vehiclenodestart = getvehiclenode(vehiclenodeindex);

  if(isDefined(vehiclenodestart)) {
    pathnodes = [];
    pathnodes[pathnodes.size] = vehiclenodestart;

    while(true) {
      currentnode = pathnodes[pathnodes.size - 1];

      if(!isDefined(currentnode.target)) {
        break;
      }

      nextnode = getvehiclenode(currentnode.target, #targetname);

      if(!isDefined(nextnode) || arraycontains(pathnodes, nextnode)) {
        break;
      }

      pathnodes[pathnodes.size] = nextnode;
    }

    result = pathnodes[pathnodes.size - 1];
  }

  return result;
}

function function_cf098fa4b25dc3e3(spawnedvehicle, goalpoint, pathindex, vehspeed) {
  if(!spawnedvehicle hascomponent("\xf5C'")) {
    spawnedvehicle addcomponent("\xf5C'");
  }

  if(!spawnedvehicle hascomponent("D\xc7\xb3\x91")) {
    spawnedvehicle addcomponent("D\xc7\xb3\x91");
  }

  if(!spawnedvehicle hascomponent("_\xb5\x13\x10x)k\x15")) {
    spawnedvehicle addcomponent("_\xb5\x13\x10x)k\x15");
  }

  spawnedvehicle setconfigvalue("\xf5C'", "Zl\x05\xde\xd5q~\x03\xb9\x1f", 0);
  spawnedvehicle setconfigvalue("\xf5C'", "9\xb8\xd70\x19\xe3\xfd26YF", 1);
  spawnedvehicle setconfigvalue("\xf5C'", "\xb6\xad\xb5wC:\xcc\xc8;\xb5d{\x82\f}", 1);
  spawnedvehicle setconfigvalue("\xf5C'", "z\xdb\xb7\x99\xa6\xe3A\xaa\xb6\xeb\x14\x82\x92\x86\xdbD,\xdb\xc7", 1);
  spawnedvehicle setconfigvalue("\xf5C'", "\x89T?\xb4\xbd2.Oj", goalpoint);
  spawnedvehicle setconfigvalue("\xf5C'", ";M\xb5Z\xf7\xb0\xf6U\xb8;\xb8\xf4k", 200);
  spawnedvehicle setconfigvalue("\xf5C'", ":4\x93\xb7\xa3G\x1b\xb2\xa9\x0e++\x8c\xa1\xc6\xed\xcd\x95", 1);
  spawnedvehicle setconfigvalue("\xf5C'", "\x99\x1a+\x17\xb5\x98\xc2\xd4\x10\xf08\x92Y\x1e\x9aY\xfb\x96\xf1_\x81\xf0", 1);
  spawnedvehicle setconfigvalue("\xf5C'", "z])\xe3\x06Jm\x8e]l\x02\x87$\xb8W<\xcbJ\x85\xdfMo\x0f,\x10\x86\x16\xb1\xc5", 1);
  spawnedvehicle setconfigvalue("\xf5C'", "\xdbHC\x7fS\xf1)\x7f\xfa\x0f\x8b\x1a<\xadxK\x9b\x888\xa7\xab", 1);
  spawnedvehicle setconfigvalue("\xf5C'", "\xd8\xea\xee\xa8\xb6\xbb\xae\x06@\xa8\xaa\x95Jvq\xfe\x149\xbd\xa81", 4);
  spawnedvehicle setconfigvalue("\xf5C'", ":4\x93\xb7\xa3G\x1b\xb2\xa9\x0e++\x8c\xa1\xc6\xed\xcd\x95", 2);
  spawnedvehicle setconfigvalue("\xf5C'", "OP\x10\xe8\xe6_l\xb6rO\xf4B pT\x1d\xfb", 0.9);
  spawnedvehicle setconfigvalue("\xf5C'", "\xbd\x1a\xdb'\xc4\xf5\xc6N\xbe\xb8Hfy\x98\x8c~\xcd[", 2);
  spawnedvehicle setconfigvalue("D\xc7\xb3\x91", "\xe2\xbd\t\xcak\xfaX\xbe\xc6\x18\xd6a", 300);
  spawnedvehicle setconfigvalue("\xf5C'", "\xedp\xc2t_\x9cGw5cT", vehspeed);
  var_14c13f23343d5208 = 0;

  if(getdvarint(@ "hash_46c9c4287e87fcfd", 0)) {
    goalvehiclenode = function_4395ace3069093bf(pathindex);

    if(isDefined(goalvehiclenode)) {
      adddebugcommand("<dev string:xd3c>");
      adddebugcommand("<dev string:xd60>");

      spawnedvehicle vehicle_code::vehicle_disable_navobstacles();
      startlocation = spawnedvehicle.origin;
      goallocation = goalvehiclenode.origin;
      vehicleforward = anglesToForward(spawnedvehicle.angles);
      var_15e34bc0c84cdad8 = isnavmeshloaded("\xf9\xd0\xed.\x17\xa2(\x91\xb2xk?\xda");
      var_729521f87a39d608 = isnavmeshloaded("K\\O\xf8@\xeb}\x12\xccS\xe0\xf8");
      navmeshlayer = var_729521f87a39d608 ? "K\\O\xf8@\xeb}\x12\xccS\xe0\xf8" : var_15e34bc0c84cdad8 ? "\xf9\xd0\xed.\x17\xa2(\x91\xb2xk?\xda" : undefined;
      splinepoints = spawnedvehicle function_899334be4045235(startlocation, goallocation, 50, 200, 100, vehicleforward, (0, 0, 0), 300, 0.4, 0, 1, navmeshlayer, 0, 1);

      if(isDefined(splinepoints) && splinepoints.size > 0) {
        var_14c13f23343d5208 = 1;
        spawnedvehicle thread vehicle_paths::checkvehiclenavsplinestuck();
        spawnedvehicle thread vehicle_paths::checkvehiclenavsplineinterrupted();
      }

      spawnedvehicle thread vehicle_paths::function_50618e09b06667b9(splinepoints, isDefined(navmeshlayer) ? (1, 1, 1) : (1, 0, 0));
      spawnedvehicle thread vehicle_paths::function_e77b0d4f81610c1e(navmeshlayer, utility::ips_to_mph(vehspeed));
    }
  }

  if(!var_14c13f23343d5208) {
    spawnedvehicle setconfigvalue("D\xc7\xb3\x91", ",\\@l\xe6b\x1e\x11\xf9", pathindex);
  }
}

function private function_41555b3a441636e5(requestid, data) {
  if(isDefined(level.var_f93e405ca717ad72[requestid])) {
    if(level.var_f93e405ca717ad72[requestid].var_41458ebc080e368d == 0) {
      if(isDefined(level.var_b6a7930a78028898)) {
        level thread[[level.var_b6a7930a78028898]](requestid, data.aifaction);
      }

      return;
    }

    if(level.var_f93e405ca717ad72[requestid].var_41458ebc080e368d == 2) {
      if(isDefined(level.var_199e355afc7e6b21)) {
        level thread[[level.var_199e355afc7e6b21]](requestid, data.aifaction);
      }
    }
  }
}

function function_bd31093e9959063f(riders) {
  var_1a02e6d76dcb0d7f = [];

  foreach(rider in riders) {
    if(rider.var_ba2cbe72aa748ebe != -1) {
      if(!self.usedpositions[rider.var_ba2cbe72aa748ebe]) {
        rider.script_startingposition = rider.var_ba2cbe72aa748ebe;
        self.usedpositions[rider.var_ba2cbe72aa748ebe] = 1;
      } else {
        assertmsg("<dev string:xd8b>" + rider.var_ba2cbe72aa748ebe);
      }

      continue;
    }

    var_1a02e6d76dcb0d7f[var_1a02e6d76dcb0d7f.size] = rider;
  }

  availableseats = vehicle_aianim::get_availablepositions();
  seatsindex = 0;

  foreach(rider in var_1a02e6d76dcb0d7f) {
    seatnumber = availableseats.availablepositions[seatsindex].vehicle_position;
    rider.script_startingposition = seatnumber;
    self.usedpositions[seatnumber] = 1;
    seatsindex++;
  }
}

function function_e89f6c8e766781b6(requestid) {
  callbackstruct = function_30fa9b3e59df8157("\x99\xa0_[\xe1\xb2e\xe1!\xef", requestid);

  if(isDefined(callbackstruct)) {
    thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata, self);
  }
}

function function_301e66f53df17c28(requestid) {
  self function_650e8ee41a00ebdb(0);
  callbackstruct = function_30fa9b3e59df8157("\xd3\xe6\x05aN\xb0l\xa1\xd5\xe8\xacL\x16s\x19\xb2\x19", requestid);

  if(isDefined(callbackstruct)) {
    thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata, self);
  }
}

function function_8f22e3665a7a36f9() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.directorrequestid)) {
    return;
  }

  utility::waittill_any("\x16\x1c\x87\xe3\xdf\x8f`\xc9\x1fL=\xfa\xb7d\xe3\r.\x8c\xa7", "\xb6\x15\xa8U\xb5\xfd\a<\\b\xec\xd9", "'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ", "\x13\xc0\xb5\x99\xf3\xe9\xcfE\x9a\xbf`3I\xa4\xce");
  requestdata = function_60dad16c45753a36(self.directorrequestid);

  if(isDefined(requestdata)) {
    self setgoalpos(requestdata.origin, requestdata.radius);
  }
}

function private function_93671d8129ddf828() {}

function private function_ec175cd6d5393d40(text) {
  shouldlog = getDvar(@ "ai_spawn_director_log", 0);

  if(isDefined(shouldlog) && (isstring(shouldlog) && shouldlog == "<dev string:xdd7>" || !isstring(shouldlog) && shouldlog == 1)) {
    println("<dev string:xddc>" + text);
  }
}

# /
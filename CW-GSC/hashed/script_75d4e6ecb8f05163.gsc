/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_75d4e6ecb8f05163.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#namespace namespace_13fefac0;

function init() {
  level thread function_26ecdeeb();
  level thread function_8e536d77();
}

function function_26ecdeeb() {
  self notify("19ba4246a0d44eb1");
  self endon("19ba4246a0d44eb1");

  for(count = 0; true; count = 0) {
    wait randomfloatrange(5, 35);

    if(gettimescale() > 1.1) {
      count++;

      if(count >= 5) {
        function_17cf7de1(1);
        return;
      }

      continue;
    }
  }
}

function function_8e536d77() {
  self notify("3c12f3aea776c15e");
  self endon("3c12f3aea776c15e");
  var_7db82908 = [{
    #key: # "hash_3cccb7d9e336696a", #threshold: 400, #trace: 3, #keytype: 2, #mode: 1
  }, {
    #key: # "hash_3f0689f4ecc2fbab", #threshold: 600, #trace: 4, #keytype: 2, #mode: 0
  }, {
    #key: # "hash_4a9ebeef00abd6cb", #threshold: 2.1, #trace: 5, #keytype: 1, #mode: 1
  }, {
    #key: # "hash_4ad8c9ef00dd61c3", #threshold: 2.1, #trace: 6, #keytype: 1, #mode: 0
  }, {
    #key: # "hash_25b1fd96e365b875", #threshold: 2.1, #trace: 7, #keytype: 3
  }, {
    #key: # "hash_6767c669a9321f55", #threshold: 2.1, #trace: 8, #keytype: 3
  }, {
    #key: # "hash_29745170b0d7f97", #threshold: 2.1, #trace: 9, #keytype: 3
  }, {
    #key: # "hash_16a3b3072a1b1e64", #threshold: 5.5, #trace: 10, #keytype: 4
  }, {
    #key: # "hash_15dc4c705c20e0db", #threshold: 5.5, #trace: 11, #keytype: 4
  }, {
    #key: # "hash_6be8efea7e9a9b0f", #threshold: 5.5, #trace: 12, #keytype: 4
  }, {
    #key: # "hash_31b5b9e273560fa9", #threshold: 5.5, #trace: 13, #keytype: 4
  }, {
    #key: # "hash_4cbba40de74aa531", #threshold: 5.5, #trace: 14, #keytype: 4
  }, {
    #key: # "hash_59e3029d696683fa", #threshold: 5.5, #trace: 15, #keytype: 4
  }, {
    #key: # "hash_2aab2762450675b4", #threshold: 5.5, #trace: 16, #keytype: 4
  }, {
    #key: # "hash_1f866ae0a3a62832", #threshold: 5.5, #trace: 17, #keytype: 4
  }, {
    #key: # "hash_71fab2192fa2537d", #threshold: 5.5, #trace: 18, #keytype: 4
  }, {
    #key: # "hash_2873049796893c2", #threshold: 5.5, #trace: 19, #keytype: 4
  }, {
    #key: # "hash_5873106a43bbf0a9", #threshold: 5.5, #trace: 20, #keytype: 4
  }, {
    #key: # "hash_164e590374876a39", #threshold: 5.5, #trace: 21, #keytype: 4
  }];

  while(true) {
    wait randomfloatrange(5, 35);
    var_760d7bc4 = 0;
    var_b4320b5b = function_7a2da789();

    foreach(item in var_7db82908) {
      if((isDefined(item.mode) ? item.mode : currentsessionmode()) != currentsessionmode()) {
        continue;
      }

      val = 0;

      switch (item.keytype) {
        case 1:
          val = getdvarfloat(item.key, 0);
          break;
        case 2:
          val = getdvarint(item.key, 0);
          break;
        case 3:
          val = isDefined(function_82c5e33d(item.key)) ? function_82c5e33d(item.key) : 0;
          break;
        case 4:
          if(isDefined(var_b4320b5b)) {
            val = isDefined(var_b4320b5b[item.key]) ? var_b4320b5b[item.key] : 0;
          }

          break;
      }

      if(val >= item.threshold) {
        function_17cf7de1(item.trace);
        var_760d7bc4 = 1;
      }
    }

    if(var_760d7bc4) {
      return 1;
    }
  }
}

function function_35cb919f(params) {
  if(!isPlayer(params.eattacker) || !isDefined(self.spawn_pos)) {
    return;
  }

  var_3749a388 = self.spawn_pos.spawned_timestamp;

  if(!isDefined(var_3749a388)) {
    return;
  }

  n_current_time = gettime();

  if(n_current_time - var_3749a388 < int(1 * 1000)) {
    n_distance = distance(self.spawn_pos.origin, self.origin);

    if(n_distance > 1000) {
      if(!isDefined(level.var_11f03ada)) {
        if(!isDefined(level.var_11f03ada)) {
          level.var_11f03ada = 0;
        }

        level thread function_b36f8acc();
      }

      level.var_11f03ada++;
    }
  }
}

function function_b36f8acc() {
  level endon(#"end_game", #"hash_61e567fec60cf9b9");
  wait 5;

  if(level.var_11f03ada >= 10) {
    function_17cf7de1(22);
    level flag::set(#"hash_61e567fec60cf9b9");
  }

  level.var_11f03ada = undefined;
}
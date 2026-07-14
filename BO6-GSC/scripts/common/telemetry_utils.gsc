/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\telemetry_utils.gsc
**********************************************/

#namespace telemetry_utils;

function function_5995f9c2ef729dbd(callback, func) {
  if(!isDefined(level.telemetry_callbacks)) {
    level.telemetry_callbacks = [];
  }

  if(!isDefined(level.telemetry_callbacks[callback])) {
    level.telemetry_callbacks[callback] = [];
  }

  level.telemetry_callbacks[callback][level.telemetry_callbacks[callback].size] = func;
}

function function_7ffb9ee91a85ee0d(callback) {
  return isDefined(level.telemetry_callbacks[callback]);
}

function function_af2d366f9522f76f(callback, data) {
  callbacks = level.telemetry_callbacks[callback];

  if(!isDefined(callbacks)) {
    return;
  }

  if(isDefined(data)) {
    foreach(callbackfunc in callbacks) {
      thread[[callbackfunc]](data);
    }

    return;
  }

  foreach(callbackfunc in callbacks) {
    thread[[callbackfunc]]();
  }
}

function function_bce6584b90db3f0d(eventname, position) {
  assert(isPlayer(self));
  telemetry_data = {
    #position: position ?? self.origin, #eventname: eventname, #player: self
  };
  function_af2d366f9522f76f("callback_on_game_event", telemetry_data);
}

function function_7f67db3f792cdc72(basetime) {
  timefrom = basetime;

  if(isDefined(level.starttimefrommatchstart)) {
    timefrom -= level.starttimefrommatchstart;

    if(timefrom < 0) {
      timefrom = 0;
    }
  } else {
    timefrom = 0;
  }

  return timefrom;
}

function function_cae236c583ce98fe() {
  mountstring = self playermounttype();

  if(isDefined(mountstring)) {
    switch (mountstring) {
      case #"hash_b882c19d3b9f4eb6":
        return "MOUNT_LEFT";
      case #"hash_c00b1399e3e96eeb":
        return "MOUNT_RIGHT";
      case #"hash_d45b94ed344be47e":
        return "MOUNT_TOP";
    }
  }

  return "MOUNT_NONE";
}

function is_valid_client(client) {
  if(game["isLaunchChunk"]) {
    return false;
  }

  if(!isDefined(client)) {
    return false;
  } else if(isagent(client)) {
    return false;
  } else if(!isPlayer(client)) {
    return false;
  }

  return true;
}

function function_ac165ec93ebac8d5(data) {
  if(!isDefined(data.player)) {
    return false;
  }

  if(!isDefined(data.player.pers)) {
    return false;
  }

  if(!isDefined(data.player.pers["telemetry"])) {
    return false;
  }

  if(!isDefined(data.player.pers["telemetry"].life)) {
    return false;
  }

  return true;
}

function get_objective_type() {
  objectivetype = "hub";

  if(isDefined(level.active_objectives_string)) {
    objectivetype = level.active_objectives_string;
  } else if(isDefined(level.contentmanager) && isDefined(level.contentmanager.activeobjective)) {
    instance = level.contentmanager.activeobjective;
    location = instance.targetname;

    if(isDefined(location)) {
      objectivetype = location;
    }
  } else if(isDefined(level.lastobjective)) {
    objectivetype = level.lastobjective;
  }

  return objectivetype;
}

function function_5e023df7bfb08695(client) {
  if(is_valid_client(client)) {
    return (client.clientid < level.maxlogclients);
  }

  return 0;
}

function function_e6eefbdfebae39bf(player) {
  if(is_valid_client(player) && !isbot(player) && getdvarint(@ "hash_5e2f0f222e2d7721") > 0) {
    var_954f21fb207ebeb6 = player function_28ce5f44a5393018();
    return (var_954f21fb207ebeb6 >= getdvarint(@ "hash_5e2f0f222e2d7721") * 1000);
  }

  return false;
}

function function_c54601d44e7b8e8a(player) {
  if(!function_e6eefbdfebae39bf(player) && player.pers["telemetry"].reached_match_end == 0) {
    player.pers["telemetry"].reached_match_end = 1;
  }
}

function validatetuningdata(value) {
  if(!isDefined(value) || !isfloat(value)) {
    assert("<dev string:x24>");
    value = -1e+06;
  }

  return value;
}
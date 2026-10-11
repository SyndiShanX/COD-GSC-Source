/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4a6760982b403bad.gsc
*************************************************/

#namespace telemetry_utils;

function function_aacbbe63c26687ae(callback, func) {
  if(!isDefined(level.telemetry_callbacks)) {
    level.telemetry_callbacks = [];
  }

  if(!isDefined(level.telemetry_callbacks[callback])) {
    level.telemetry_callbacks[callback] = [];
  }

  level.telemetry_callbacks[callback][level.telemetry_callbacks[callback].size] = func;
}

function function_9ce94b15ee6758ee(callback) {
  if(!isDefined(level.telemetry_callbacks)) {
    return false;
  }

  if(!isDefined(level.telemetry_callbacks[callback])) {
    return false;
  }

  return true;
}

function function_80820d6d364c1836(callback, data) {
  if(!function_9ce94b15ee6758ee(callback)) {
    return;
  }

  if(isDefined(data)) {
    for(i = 0; i < level.telemetry_callbacks[callback].size; i++) {
      thread[[level.telemetry_callbacks[callback][i]]](data);
    }

    return;
  }

  for(i = 0; i < level.telemetry_callbacks[callback].size; i++) {
    thread[[level.telemetry_callbacks[callback][i]]]();
  }
}

function function_1b15450e092933cf(basetime) {
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

function function_50989a55805a440b() {
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
  if(istrue(game["isLaunchChunk"])) {
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

function function_4b974d822d418a06(data) {
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

function function_ff48d255c865806(client) {
  if(is_valid_client(client)) {
    return (client.clientid < level.maxlogclients);
  }

  return 0;
}

function validatetuningdata(value) {
  if(!isDefined(value) || !isfloat(value)) {
    assert("value is not a \"Float\". Defaulting to -1000000.0, since it is currently outside the scope of tuning values.");
    value = -1e+06;
  }

  return value;
}
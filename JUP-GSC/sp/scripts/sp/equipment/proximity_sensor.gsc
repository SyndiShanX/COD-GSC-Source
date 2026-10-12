/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\proximity_sensor.gsc
*****************************************************/



#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\utility;
#namespace proximity_sensor;

function function_d95667e1f430febd(var_34f47f14c6e790e2, var_4d911eca2b018af3, fx_allowed, min_distance, max_distance, var_c1d6e94f98d2793, var_f428363b0493ab85, max_height, lookat_scalar) {
  level.proximity_sensor = spawnStruct();

  if(isDefined(min_distance)) {
    function_98347594501950ee(min_distance);
  } else {
    function_98347594501950ee(50);
  }

  if(isDefined(max_distance)) {
    function_d50ea3ea79aa3904(max_distance);
  } else {
    function_d50ea3ea79aa3904(600);
  }

  if(isDefined(var_c1d6e94f98d2793)) {
    function_1a4b1d45cb84a1ca(var_c1d6e94f98d2793);
  } else {
    function_1a4b1d45cb84a1ca(0.6);
  }

  if(isDefined(var_f428363b0493ab85)) {
    function_da5957bb5e105e1c(var_f428363b0493ab85);
  } else {
    function_da5957bb5e105e1c(7);
  }

  if(isDefined(max_height)) {
    assert(max_height <= function_8185e6789fcd7280(), "max height cannot be greater than max distance");
    function_12b7794c48c124e4(max_height);
  } else {
    function_12b7794c48c124e4(600);
  }

  if(isDefined(lookat_scalar)) {
    function_9c3eea918fd3d2f(lookat_scalar);
  } else {
    function_9c3eea918fd3d2f(0.5);
  }

  precacheshader("cursor_hint_circle");
  thread function_809d91ac8143e1a6();

  if(istrue(var_34f47f14c6e790e2)) {
    function_d185ec5f9609dd11(var_4d911eca2b018af3, fx_allowed);
  }
}

function function_809d91ac8143e1a6() {
  flag_init("proximity_sensor_ready");
  waitframe();
  flag_set("proximity_sensor_ready");
}

function function_d185ec5f9609dd11(var_4d911eca2b018af3, fx_allowed) {
  thread function_7f98da5ffc7830b0(var_4d911eca2b018af3, fx_allowed);
}

function stop_proximity_detection() {
  level notify("stop_proximity_detection");
}

function function_7f98da5ffc7830b0(var_4d911eca2b018af3, fx_allowed) {
  flag_wait("proximity_sensor_ready");
  elem = newhudelem();
  elem.x = 400;
  elem.y = 360;
  elem.alignx = "center";
  elem.aligny = "middle";
  elem.sort = 1;
  elem.foreground = 1;
  elem.hidewhendead = 1;
  elem.hidewheninmenu = 1;
  elem.alpha = 0;
  elem.fontscale = 1;
  elem.font = "objective";
  elem setshader("cursor_hint_circle", 1, 1);
  function_cc3cc81b074b6622(elem, var_4d911eca2b018af3, fx_allowed);
  function_34717ab6792d27b5(elem, var_4d911eca2b018af3);
}

function function_cc3cc81b074b6622(elem, var_4d911eca2b018af3, fx_allowed) {
  level endon("stop_proximity_detection");

  childthread function_c79c0f5856d2403a();

  if(istrue(var_4d911eca2b018af3)) {
    childthread function_4447945e071f9035();
  }

  while(true) {
    function_6b1e1eeb77706ec6();
    thread do_blink(fx_allowed);
  }
}

function function_4447945e071f9035() {
  level.player notifyonplayercommand("tag_enemy", "+actionslot 1");

  while(true) {
    level.player waittill("tag_enemy");
    start = level.player getEye();
    player_forward = anglesToForward(level.player getgunangles());
    result = ray_trace(start, start + player_forward * 2000, level.player);

    if(isDefined(result["entity"]) && isDefined(result["entity"].team) && result["entity"].team == "neutral") {
      if(!istrue(result["entity"].var_1ecff25d607a7651)) {
        iprintlnbold("TAGGED CIVILIAN");
      }

      result["entity"].var_1ecff25d607a7651 = 1;
    }
  }
}

function function_6b1e1eeb77706ec6() {
  time_passed = 0;

  while(true) {
    dist = function_6ae5cddccb732765(function_8185e6789fcd7280(), function_a3257413d5785298());

    if(isDefined(dist)) {
      threshold = function_a8c7a844722dfe7(dist, function_da492569e9e63e72(), function_8185e6789fcd7280(), function_c12007fb94985006(), function_7a3cdbe9dfff6160(), 1.7);

      if(time_passed > threshold) {
        return;
      }
    }

    waitframe();
    time_passed += 0.05;
  }
}

function function_6ae5cddccb732765(max_dist, max_height) {
  ai_array = getaiarrayinradius(level.player.origin, max_dist, "axis");
  civ_array = getaiarrayinradius(level.player.origin, max_dist, "neutral");

  foreach(civ in civ_array) {
    if(!istrue(civ.var_1ecff25d607a7651)) {
      ai_array[ai_array.size] = civ;
    }
  }

  if(ai_array.size == 0) {
    return undefined;
  }

  shortest_dist = undefined;
  target_ai = undefined;

  foreach(ai in ai_array) {
    if(abs(level.player.origin[2] - ai.origin[2]) > level.proximity_sensor.max_height) {
      continue;
    }

    dist = distance(level.player.origin, ai.origin);

    if(!isDefined(shortest_dist) || dist < shortest_dist) {
      shortest_dist = dist;
      target_ai = ai;
    }
  }

  if(isDefined(shortest_dist) && shortest_dist <= max_dist) {
    dot = math::get_dot(level.player getEye(), level.player getgunangles(), target_ai.origin + (0, 0, 45));

    if(dot >= 0.766044) {
      scalar = function_a8c7a844722dfe7(1 - dot, 0, 0.233956, function_6bca348b685237b3(), 1, 1.7);
      shortest_dist *= scalar;
    }
  }

  return shortest_dist;
}

function do_blink(fx_allowed) {
  level.player playSound("motiontracker_pong");

  if(istrue(fx_allowed)) {
    level.player setscriptablepartstate("player_fx", "proximitysensor_blink");
    wait 0.3;
    level.player setscriptablepartstate("player_fx", "fx_off");
  }
}

function function_11a1811a31f152aa(elem) {
  level.player playSound("motiontracker_pong");
  elem.alpha = 1;
  elem scaleovertime(0.4, 70, 70);
  wait 0.2;
  elem fadeovertime(0.1);
  elem.alpha = 0;
  wait 0.3;
  elem scaleovertime(0.1, 1, 1);
}

function function_34717ab6792d27b5(elem, var_4d911eca2b018af3) {
  if(istrue(var_4d911eca2b018af3)) {
    level.player notifyonplayercommandremove("tag_enemy", "+actionslot 1");
  }

  elem destroy();
}

function function_98347594501950ee(min_distance) {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to set its parameters.");
  level.proximity_sensor.min_distance = min_distance;
}

function function_d50ea3ea79aa3904(max_distance) {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to set its parameters.");
  level.proximity_sensor.max_distance = max_distance;
}

function function_1a4b1d45cb84a1ca(var_c1d6e94f98d2793) {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to set its parameters.");
  level.proximity_sensor.var_c1d6e94f98d2793 = var_c1d6e94f98d2793;
}

function function_da5957bb5e105e1c(var_f428363b0493ab85) {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to set its parameters.");
  level.proximity_sensor.var_f428363b0493ab85 = var_f428363b0493ab85;
}

function function_12b7794c48c124e4(max_height) {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to set its parameters.");
  level.proximity_sensor.max_height = max_height;
}

function function_9c3eea918fd3d2f(scalar) {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to set its parameters.");
  level.proximity_sensor.lookat_scalar = scalar;
}

function function_da492569e9e63e72() {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to get its parameters.");
  return level.proximity_sensor.min_distance;
}

function function_8185e6789fcd7280() {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to get its parameters.");
  return level.proximity_sensor.max_distance;
}

function function_c12007fb94985006() {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to get its parameters.");
  return level.proximity_sensor.var_c1d6e94f98d2793;
}

function function_7a3cdbe9dfff6160() {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to get its parameters.");
  return level.proximity_sensor.var_f428363b0493ab85;
}

function function_a3257413d5785298() {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to get its parameters.");
  return level.proximity_sensor.max_height;
}

function function_6bca348b685237b3() {
  assertex(isDefined(level.proximity_sensor), "Proximity Sensor needs to be initialized to get its parameters.");
  return level.proximity_sensor.lookat_scalar;
}

function function_c79c0f5856d2403a() {
  setdvarifuninitialized(@ "hash_720160b832829829", 0);

  for(;;) {
    if(getdvarint(@ "hash_720160b832829829")) {
      ai_array = getaiarrayinradius(level.player.origin, function_8185e6789fcd7280(), "<dev string:x1c>");
      civ_array = getaiarrayinradius(level.player.origin, function_8185e6789fcd7280(), "<dev string:x21>");

      foreach(civ in civ_array) {
        if(!istrue(civ.var_1ecff25d607a7651)) {
          ai_array[ai_array.size] = civ;
        }
      }

      closest = getclosest(level.player.origin, ai_array);

      foreach(ai in ai_array) {
        dist = distance(level.player.origin, ai.origin);
        percent = function_1eb704cb6d755987(dist, function_da492569e9e63e72(), function_8185e6789fcd7280(), 100, 0);
        print3d(ai gettagorigin("<dev string:x29>") + (0, 0, 20), simple_round(dist) + "<dev string:x30>", (1, 1, ai != closest), 1, 0.8, 1, 1);
        print3d(ai gettagorigin("<dev string:x29>") + (0, 0, 12), "<dev string:x33>" + simple_round(percent) + "<dev string:x35>", (1, 1, ai != closest), 1, 0.6, 1, 1);
      }
    }

    waitframe();
  }
}

function function_1eb704cb6d755987(value, min1, max1, min2, max2) {
  value = min2 + (value - min1) * (max2 - min2) / (max1 - min1);
  return clamp(value, min(min2, max2), max(min2, max2));
}

function function_a8c7a844722dfe7(value, min1, max1, min2, max2, power) {
  ratio = clamp((value - min1) / (max1 - min1), 0, 1);
  value = min2 + (value - min1) * (max2 - min2) / (max1 - min1) * easepower(ratio, power, 1, 0);
  return clamp(value, min2, max2);
}

function simple_round(value) {
  floored = floor(value);
  decimal = value - floored;

  if(decimal < 0.5) {
    return floored;
  }

  return floored + 1;
}
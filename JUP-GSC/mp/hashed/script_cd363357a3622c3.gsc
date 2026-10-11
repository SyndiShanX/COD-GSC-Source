/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_cd363357a3622c3.gsc
************************************************/

#using script_5fd79768b8941cfb;
#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_movingtrain;
#namespace namespace_8d21700b75348f98;

function init() {
  function_4eb0bb5b9718da16();
  scripts\engine\scriptable::scriptable_addusedcallback(&train_control_used);

  scripts\mp\gametypes\br_dev::registerhandlecommand(&function_c96d7535862e245c);

  thread function_6897c2cb1d85fbce();
}

function function_4eb0bb5b9718da16() {
  level.wztrain_info.var_164f7d6ed6e374a9 = [];
  level.wztrain_info.var_164f7d6ed6e374a9["cargo_train"] = function_dd750d5096824adf();
}

function function_6897c2cb1d85fbce() {
  level endon("game_ended");
  waitframe();
  function_e3c620206b7b1178(&function_21d9e76c22c14c60);

  foreach(train_name, controls in level.wztrain_info.var_164f7d6ed6e374a9) {
    thread function_1ce68ec392d1950a(train_name);
  }

  flag_wait("wztrain_anim_playing");

  foreach(train_name, controls in level.wztrain_info.var_164f7d6ed6e374a9) {
    function_bc93036ea42dca0(train_name);
    var_f1c8827adb8d65b6 = level.wztrain_info.trains[train_name][0].linked_model;
    var_f1c8827adb8d65b6 setscriptablepartstate("train_control_horn", "moving");

    if(var_f1c8827adb8d65b6 getscriptablehaspart("train_part")) {
      var_f1c8827adb8d65b6 setscriptablepartstate("train_part", "moving");
    }

    level thread function_cb3e15ba0b19f1f(controls, level.wztrain_info.trains[train_name]);
  }

  if(getdvarint(@ "hash_2c16009ad16f1d64", 0)) {
    foreach(train_name, train_cars in level.wztrain_info.trains) {
      if(!isDefined(level.wztrain_info.var_164f7d6ed6e374a9[train_name])) {
        continue;
      }

      train_cars[0] thread function_3c251653418a4e3d();
      train_cars[train_cars.size - 1] thread function_c3f6cedf4261e108();
    }
  }

}

function function_dd750d5096824adf() {
  controls = spawnStruct();
  controls.accel_rate = getdvarfloat(@ "hash_d29dc09dffa5807", 0.208);
  controls.var_34b5b36b72aa61e2 = getdvarfloat(@ "hash_f2e7d1767a506f1b", 0.6);
  controls.speeds = [0, 0.5];
  controls.speed_setting = 1;
  controls.backwards_anim = getdvarint(@ "hash_aafd86e488bc3ce5", 1);
  controls.brake_state = "free";
  controls.var_c10fe7f57dc50f60 = 0;
  return controls;
}

function private function_1ce68ec392d1950a(train_name) {
  level endon("game_ended");
  locomotive = level.wztrain_info.trains[train_name][0];

  while(true) {
    locomotive waittill("reset_train_controls");
    train_controls_reset(train_name);
  }
}

function function_7e0ab31db5a32c39(train_name, delay_seconds) {
  level endon("game_ended");
  controls = level.wztrain_info.var_164f7d6ed6e374a9[train_name];

  if(!isDefined(controls)) {
    return;
  }

  now = gettime();
  var_9c31e31440c8df79 = now + delay_seconds * 1000;

  if(isDefined(controls.var_9c31e31440c8df79) && controls.var_9c31e31440c8df79 > var_9c31e31440c8df79) {
    return;
  }

  controls.var_9c31e31440c8df79 = var_9c31e31440c8df79;
  locomotive = level.wztrain_info.trains[train_name][0];
  locomotive notify("train_control_reset_delayed");
  locomotive endon("train_control_reset_delayed");
  wait delay_seconds;
  train_controls_reset(train_name);
}

function train_controls_reset(train_name) {
  controls = level.wztrain_info.var_164f7d6ed6e374a9[train_name];

  if(!isDefined(controls)) {
    return;
  }

  controls.brake_state = "free";
  controls.var_c10fe7f57dc50f60 = 0;
  controls.speed_setting = 1;
  function_bc93036ea42dca0(train_name);
  function_6e71ccb81deeb55b(train_name, controls.accel_rate);

  if(isDefined(controls.var_4116cb12fcdf92cf) && isPlayer(controls.var_4116cb12fcdf92cf)) {
    controls.var_4116cb12fcdf92cf function_39b5cec1323e813e(0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 1);
    controls.var_4116cb12fcdf92cf = undefined;
  }
}

function function_7e9ea79eb0196f0d(train, state) {
  controls = level.wztrain_info.var_164f7d6ed6e374a9[train];

  if(!isDefined(controls)) {
    return;
  }

  if(controls.brake_state == state) {
    return;
  }

  controls.brake_state = state;

  if(getdvarint(@ "hash_4eee316904a2408c", 0) == 1) {
    if(state == "free") {
      function_6ec6dbd953660756(train, "dx_br_jpbm_wztr_trco_brdi", 1);
    } else if(state == "engaged") {
      function_6ec6dbd953660756(train, "dx_br_jpbm_wztr_trco_brtr", 1);
    }
  }

  function_6e71ccb81deeb55b(train, controls.var_34b5b36b72aa61e2);
  function_bc93036ea42dca0(train);
  function_21d9e76c22c14c60(train);
}

function train_control_used(instance, part, state, player, bautouse, usestring) {
  if(!function_7bafeacef59f5c1(part)) {
    return;
  }

  train = function_7583cb74034d366c(instance);

  if(!isDefined(train)) {
    return;
  }

  controls = level.wztrain_info.var_164f7d6ed6e374a9[train];

  if(!isDefined(controls)) {
    return;
  }

  result_part = part;
  result_player = player;
  result_success = 0;
  player thread function_21c30228852aebeb();

  if(part == "train_control_horn") {
    instance function_e5b02b44240eb902("train_control_horn");
    level thread function_c344e131688312f(train);
    player function_39b5cec1323e813e(0, 0, 1);
    result_success = 1;
  } else if(part == "train_control_brake") {
    if(controls.brake_state == "engaged") {
      function_7e9ea79eb0196f0d(train, "free");

      if(controls.speed_setting != 0) {
        function_10cce231da3f017a(train, "train_accelerate");
      }
    } else {
      function_7e9ea79eb0196f0d(train, "engaged");

      if(controls.speed_setting != 0) {
        function_10cce231da3f017a(train, "handbrake_engaged");
      }
    }

    player function_39b5cec1323e813e(0, 0, 0, 1);
    result_success = 1;
  } else if(controls.brake_state == "engaged") {
    announcement(train + "<dev string:x1c>");
  } else {
    if(part == "train_control_speed") {
      if(controls.speed_setting == 0) {
        controls.speed_setting = 1;

        if(getdvarint(@ "hash_4eee316904a2408c", 0) == 1) {
          function_6ec6dbd953660756(train, "dx_br_jpbm_wztr_trco_acce", 1);
        }

        function_10cce231da3f017a(train, "train_accelerate");
      } else {
        controls.speed_setting = 0;

        if(getdvarint(@ "hash_4eee316904a2408c", 0) == 1) {
          function_6ec6dbd953660756(train, "dx_br_jpbm_wztr_trco_stop", 1);
        }

        function_10cce231da3f017a(train, "train_brake");
      }

      player function_39b5cec1323e813e(0, 1);
    } else if(part == "train_control_direction") {
      controls.var_c10fe7f57dc50f60 = !controls.var_c10fe7f57dc50f60;
      function_81c2bfe1e0c366a1(train);
      player function_39b5cec1323e813e(1);
    }

    controls.speed_setting = abs(controls.speed_setting) * ter_op(controls.var_c10fe7f57dc50f60, -1, 1);
    function_6e71ccb81deeb55b(train, controls.accel_rate);
    result_success = 1;
  }

  if(result_success) {
    if(scripts\engine\utility::issharedfuncdefined("ftue", "player_action")) {
      player[[scripts\engine\utility::getsharedfunc("ftue", "player_action")]]("br_ftue_train_controls");
    }
  }

  var_740ed0893c883b16 = getdvarfloat(@ "hash_a54fa6f96163c9ec", 60);

  if(var_740ed0893c883b16 >= 0 && result_success && function_22210d8bc6894d7f(part)) {
    level thread function_7e0ab31db5a32c39(train, var_740ed0893c883b16);
  }

  controls.var_4116cb12fcdf92cf = player;
  traincar = instance.entity.linked_brush;
  traincar notify("train_control_used", result_part, result_player, result_success);
}

function private function_6e71ccb81deeb55b(train_name, accelerationrate) {
  controls = level.wztrain_info.var_164f7d6ed6e374a9[train_name];

  if(!isDefined(controls)) {
    return;
  }

  targetrate = sign(controls.speed_setting) * controls.speeds[int(abs(controls.speed_setting))];

  if(controls.brake_state == "engaged") {
    targetrate = 0;
  }

  level thread train_change_speed(train_name, accelerationrate, targetrate);
}

function function_21c30228852aebeb() {
  self endon("death_or_disconnect");
  weapobj = makeweapon("iw8_ges_plyr_loot_pickup");
  self giveandfireoffhand(weapobj);
  nearbyplayers = getplayersandaiarrayinradius(self.origin, 40);

  foreach(player in nearbyplayers) {
    vehicle_allowplayeruse(player, 0);
  }

  wait 1.17;

  foreach(player in nearbyplayers) {
    vehicle_allowplayeruse(player, 1);
  }

  if(self hasweapon(weapobj)) {
    self takeweapon(weapobj);
  }
}

function train_control_speed(train) {
  level endon("game_ended");
  flag_wait("wztrain_anim_playing");
  function_bc93036ea42dca0(train);

  control = level.wztrain_info.var_164f7d6ed6e374a9[train];

  if(!isDefined(control)) {
    return;
  }

  while(true) {
    wait 1;
    targetrate = getdvarfloat(@ "hash_d73a064cedac973c", -2);

    if(targetrate != -2) {
      targetrate = clamp(targetrate, -1, 1);

      if(!control.backwards_anim) {
        targetrate = max(targetrate, 0);
      }

      level thread train_change_speed(train, control.accel_rate, targetrate);
      announcement("<dev string:x42>" + train + "<dev string:x51>" + targetrate);
      setDvar(@ "hash_d73a064cedac973c", -2);
    }

    if(getdvarint(@ "hash_aa31e3c9a2144a3c", 0) > 0) {
      level thread function_7af6d73425acffca(train);
      setDvar(@ "hash_aa31e3c9a2144a3c", 0);
    }
  }

}

function train_change_speed(train, accelerationrate, targetrate) {
  level endon("game_ended");
  level notify("train_change_speed");
  level endon("train_change_speed");
  currentrate = level.wztrain_info.animrate[train];
  animent = level.wztrain_info.animent[train];
  animtoplay = animent.anim_override;
  animref = level.scr_anim[train][animtoplay];

  if(isarray(animref)) {
    animref = level.scr_anim[train][animtoplay][0];
  }

  car_array = level.wztrain_info.trains[train];

  if(currentrate != 0) {
    foreach(traincar in car_array) {
      temp = traincar.linked_model getlinkedscriptableinstance();

      if(traincar.linked_model getscriptablehaspart("train_speed_vfx")) {
        traincar.linked_model setscriptablepartstate("train_speed_vfx", "slowing");
      }
    }
  }

  while(true) {
    currentrate = function_a2865fbe60ae30a8(train, accelerationrate, targetrate);
    function_bc93036ea42dca0(train);

    if(currentrate == targetrate) {
      break;
    }

    waitframe();
  }

  var_dfd7cd7e4ca1ca61 = "stopped";

  if(currentrate != 0) {
    var_dfd7cd7e4ca1ca61 = "moving";
  }

  foreach(traincar in car_array) {
    if(traincar.linked_model getscriptablehaspart("train_speed_vfx")) {
      traincar.linked_model setscriptablepartstate("train_speed_vfx", var_dfd7cd7e4ca1ca61);
    }
  }

  function_fa60abd0913d1578(train, targetrate);
  function_bc93036ea42dca0(train);
}

function function_bc93036ea42dca0(train) {
  last_index = level.wztrain_info.trains[train].size - 1;
  var_f1c8827adb8d65b6 = level.wztrain_info.trains[train][0].linked_model;
  var_d4bd4a2dc32512f8 = level.wztrain_info.trains[train][last_index].linked_model;
  controls = level.wztrain_info.var_164f7d6ed6e374a9[train];

  if(!isDefined(controls)) {
    return;
  }

  currentsetting = controls.speed_setting;
  var_e9a4c0a810ecf2d = controls.var_c10fe7f57dc50f60;
  maxsetting = controls.speeds.size - 1;

  if(function_69a53edae2615588()) {
    if(controls.brake_state == "locked_gas" && scripts\mp\gametypes\br_circle::function_24c5a8d31ae262f(var_f1c8827adb8d65b6.origin)) {
      var_f1c8827adb8d65b6 function_6486de250ce58910("train_control_speed");
    } else if(controls.brake_state == "engaged") {
      var_f1c8827adb8d65b6 function_e5b02b44240eb902("train_control_speed");
    } else if(currentsetting != 0) {
      var_f1c8827adb8d65b6 function_ee91d3658ebaf03e("train_control_speed");
    } else {
      var_f1c8827adb8d65b6 function_11d65d952fe2f131("train_control_speed");
    }

    if(controls.brake_state == "engaged") {
      var_f1c8827adb8d65b6 function_e5b02b44240eb902("train_control_direction");
    } else if(!var_e9a4c0a810ecf2d) {
      var_f1c8827adb8d65b6 function_ee91d3658ebaf03e("train_control_direction");
    } else {
      var_f1c8827adb8d65b6 function_11d65d952fe2f131("train_control_direction");
    }

    if(controls.brake_state == "locked_gas" && scripts\mp\gametypes\br_circle::function_24c5a8d31ae262f(var_f1c8827adb8d65b6.origin)) {
      var_d4bd4a2dc32512f8 function_6486de250ce58910("train_control_brake");
    } else if(controls.brake_state == "engaged") {
      var_d4bd4a2dc32512f8 function_ee91d3658ebaf03e("train_control_brake");
    } else {
      var_d4bd4a2dc32512f8 function_6166908ef79c21eb("train_control_brake");
    }
  }

  hornstate = var_f1c8827adb8d65b6 getscriptablepartstate("train_control_horn");

  if(hornstate != "locked") {
    speed_state = ter_op(currentsetting != 0, "moving", "stopped");
    var_f1c8827adb8d65b6 setscriptablepartstate("train_control_horn", speed_state);
  }
}

function function_ee91d3658ebaf03e(part) {
  function_8fe9e563b974b56(part, "active");
}

function function_b0b5dbf3a3303a8d(part) {
  function_8fe9e563b974b56(part, "inactive");
}

function function_6166908ef79c21eb(part) {
  function_8fe9e563b974b56(part, "neutral");
}

function function_11d65d952fe2f131(part) {
  function_8fe9e563b974b56(part, "inverted");
}

function function_ae7becf37e2c0913(part) {
  function_8fe9e563b974b56(part, "saturated");
}

function function_e5b02b44240eb902(part) {
  function_8fe9e563b974b56(part, "locked");
}

function function_6486de250ce58910(part) {
  function_8fe9e563b974b56(part, "locked_gas");
}

function function_8fe9e563b974b56(part, state) {
  var_b60a7b508801fee5 = self;

  if(isDefined(var_b60a7b508801fee5) && var_b60a7b508801fee5 getscriptablehaspart(part)) {
    var_b60a7b508801fee5 setscriptablepartstate(part, state);
  }
}

function private function_21d9e76c22c14c60(train_name) {
  controls = level.wztrain_info.var_164f7d6ed6e374a9[train_name];

  if(!isDefined(controls)) {
    return;
  }

  car_array = level.wztrain_info.trains[train_name];
  currentspeed = abs(level.wztrain_info.animrate[train_name]);
  is_moving = currentspeed > 0;

  switch (controls.brake_state) {
    case #"hash_a8f0b714fb0cb53b":
      brakes_state = "free";
      break;
    case #"hash_457675bf573bc05e":
      brakes_state = ter_op(is_moving, "engaged_moving", "engaged_stopped");
      break;
    case #"hash_1a60086c17c232a3":
      brakes_state = ter_op(is_moving, "cut_moving", "cut_stopped");
      break;
  }

  foreach(traincar in car_array) {
    if(traincar.linked_model getscriptablehaspart("train_brakes_vfx") && controls.brake_state != "locked_gas") {
      traincar.linked_model setscriptablepartstate("train_brakes_vfx", brakes_state);
    }
  }
}

function function_10cce231da3f017a(train_name, sfx_state) {
  car_array = level.wztrain_info.trains[train_name];
  assertex(isarray(car_array), "<dev string:x71>");

  if(!isarray(level.wztrain_info.var_132b68e7763c2410)) {
    level.wztrain_info.var_132b68e7763c2410 = [];
  }

  train_state = level.wztrain_info.var_132b68e7763c2410[train_name];

  if(isstring(train_state) && train_state == sfx_state) {
    return;
  } else {
    level.wztrain_info.var_132b68e7763c2410[train_name] = sfx_state;
  }

  i = 0;

  while(i < car_array.size) {
    traincar = car_array[i];

    if(traincar.linked_model getscriptablehaspart("train_control_sfx")) {
      traincar.linked_model setscriptablepartstate("train_control_sfx", sfx_state);
    }

    i += 2;
  }
}

function function_c344e131688312f(train_name) {
  wait 1.2;
  currentrate = level.wztrain_info.animrate[train_name];
  var_f1c8827adb8d65b6 = level.wztrain_info.trains[train_name][0].linked_model;
  speed_state = ter_op(currentrate != 0, "moving", "stopped");
  var_f1c8827adb8d65b6 setscriptablepartstate("train_control_horn", speed_state);
}

function function_81c2bfe1e0c366a1(train_name) {
  function_10cce231da3f017a(train_name, "train_brake");
  delaythread(3, &function_10cce231da3f017a, train_name, "train_accelerate");
}

function function_cb3e15ba0b19f1f(controls, train) {
  if(!getdvarint(@ "hash_424b8a3a18e485d6", 1)) {
    return;
  }

  level endon("game_ended");
  train_engine = train[0];
  animent = level.wztrain_info.animent[train_engine.train_name];

  while(!istrue(animent.animtimeset)) {
    waitframe();
  }

  while(true) {
    var_1c1ca1171e5d6bc2 = train_engine.linked_model getscriptablepartstate("train_control_speed");

    if(scripts\mp\gametypes\br_circle::function_24c5a8d31ae262f(train_engine.origin)) {
      if(controls.speed_setting == 0 || controls.brake_state == "engaged") {
        train_controls_reset(train_engine.train_name);
      }

      train_engine.linked_model function_6486de250ce58910("train_control_speed");
      function_7e9ea79eb0196f0d(train_engine.train_name, "locked_gas");
    } else if(var_1c1ca1171e5d6bc2 == "locked_gas") {
      train_engine.linked_model function_ee91d3658ebaf03e("train_control_speed");
      function_7e9ea79eb0196f0d(train_engine.train_name, "free");
    }

    wait 5;
  }
}

function function_7583cb74034d366c(car_instance) {
  foreach(train_name, car_entities in level.wztrain_info.trains) {
    foreach(car_entity in car_entities) {
      if(car_instance.entity == car_entity.linked_model) {
        return train_name;
      }
    }
  }

  return undefined;
}

function function_7bafeacef59f5c1(part) {
  return part == "train_control_speed" || part == "train_control_direction" || part == "train_control_horn" || part == "train_control_brake";
}

function function_69a53edae2615588() {
  return istrue(level.wztrain_info.var_8fff939a9d90ecab) && !istrue(level.var_a34a94a1dea4ff9d);
}

function function_87fbf04f38e7d4ba() {
  if(function_69a53edae2615588()) {
    return false;
  }

  return istrue(level.var_1737daa0a28a71f4);
}

function private function_22210d8bc6894d7f(part) {
  return part == "train_control_brake" || part == "train_control_speed" || part == "train_control_direction";
}

function private function_c96d7535862e245c(command, args) {
  firstplayer = level.players[0];

  if(!isDefined(firstplayer)) {
    return;
  }

  switch (command) {
    case #"hash_2899e5a679a1e049":
      if(!isDefined(args[0])) {
        break;
      }

      switch (args[0]) {
        case #"hash_1cf09102712cef10":
          if(!isDefined(args[1])) {
            break;
          }

          if(args[1] == "cut" || args[1] == "engaged" || args[1] == "free") {
            function_7e9ea79eb0196f0d("cargo_train", args[1]);
          }

          break;
      }

      break;
  }
}

function function_3c251653418a4e3d() {
  level endon("game_ended");
  var_19eaf2b704a9fa99 = (96, 0, 60);
  var_250d564bc5afa2c2 = (-96, 0, 60);
  var_8e5fb7ac062f72a5 = (0, 0, 60);
  var_2ce41e65c3b440c9 = (0, 1, 0);
  var_b0cdc5bf8cf8ba12 = (1, 0, 0);
  var_9bcaa2cd4b55a075 = (0.5, 0, 1);
  ctl_radius = 20;

  while(true) {
    utility::draw_capsule(self localtoworldcoords(var_19eaf2b704a9fa99) + (0, 0, ctl_radius * -1), ctl_radius, ctl_radius * 2, (0, 0, 0), var_2ce41e65c3b440c9, 0);
    utility::draw_capsule(self localtoworldcoords(var_250d564bc5afa2c2) + (0, 0, ctl_radius * -1), ctl_radius, ctl_radius * 2, (0, 0, 0), var_b0cdc5bf8cf8ba12, 0);
    utility::draw_capsule(self localtoworldcoords(var_8e5fb7ac062f72a5) + (0, 0, ctl_radius * -1), ctl_radius, ctl_radius * 2, (0, 0, 0), var_9bcaa2cd4b55a075, 0);
    waitframe();
  }
}

function function_c3f6cedf4261e108() {
  level endon("game_ended");
  var_b34c2ff00f78169c = (0, 0, 60);
  var_5686441a1d2fd1ac = (1, 0, 0);
  ctl_radius = 20;

  while(true) {
    utility::draw_capsule(self localtoworldcoords(var_b34c2ff00f78169c) + (0, 0, ctl_radius * -1), ctl_radius, ctl_radius * 2, (0, 0, 0), var_5686441a1d2fd1ac, 0);
    waitframe();
  }
}
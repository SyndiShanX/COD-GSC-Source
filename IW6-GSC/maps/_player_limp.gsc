/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_player_limp.gsc
*****************************************************/

init_player_limp() {
  precacheshellshock("player_limp");
  precacheshader("black");
}

init_default_limp() {
  level.player_limp = [];
  level.player_limp["pitch"]["min"] = 2;
  level.player_limp["pitch"]["max"] = 5;
  level.player_limp["yaw"]["min"] = -8;
  level.player_limp["yaw"]["max"] = 5;
  level.player_limp["roll"]["min"] = 3;
  level.player_limp["roll"]["max"] = 5;
}

set_custom_limp(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.player_limp["pitch"]["min"] = var_0["min"];
    level.player_limp["pitch"]["max"] = var_0["max"];
  }

  if(isDefined(var_1)) {
    level.player_limp["yaw"]["min"] = var_1["min"];
    level.player_limp["yaw"]["max"] = var_1["max"];
  }

  if(isDefined(var_2)) {
    level.player_limp["roll"]["min"] = var_2["min"];
    level.player_limp["roll"]["max"] = var_2["max"];
  }
}

reset_default_limp(var_0, var_1, var_2) {
  if(!isDefined(var_0) && !isDefined(var_1) && !isDefined(var_2)) {
    level.player_limp["pitch"]["min"] = 2;
    level.player_limp["pitch"]["max"] = 5;
    level.player_limp["yaw"]["min"] = -8;
    level.player_limp["yaw"]["max"] = 5;
    level.player_limp["roll"]["min"] = 3;
    level.player_limp["roll"]["max"] = 5;
    return;
  }

  if(isDefined(var_0)) {
    level.player_limp["pitch"]["min"] = 2;
    level.player_limp["pitch"]["max"] = 5;
  }

  if(isDefined(var_1)) {
    level.player_limp["yaw"]["min"] = -8;
    level.player_limp["yaw"]["max"] = 5;
  }

  if(isDefined(var_2)) {
    level.player_limp["roll"]["min"] = 3;
    level.player_limp["roll"]["max"] = 5;
  }
}

enable_limp(var_0, var_1) {
  if(!maps\_utility::ent_flag_exist("fall")) {
    maps\_utility::ent_flag_init("fall");
    maps\_utility::ent_flag_init("collapse");
  }

  if(!isDefined(level.player_limp)) {
    init_default_limp();
  }

  self.limp = 1;
  self.sprinting = undefined;
  self.allow_fall = 1;
  self.limp_strength = 1.0;
  level.default_heartbeat_rate = 0.75;
  create_ground_ref_ent();
  level.originalvisionset = self.vision_set_transition_ent.vision_set;

  if(!isDefined(var_0)) {
    var_0 = 75;
  }

  maps\_utility::player_speed_percent(var_0, 0.05);
  self.player_speed = var_0;
  thread limp();

  if(isDefined(var_1)) {
    thread fade_limp(var_1);
  }
}

disable_limp(var_0, var_1) {
  self notify("stop_limp");
  self notify("stop_random_blur");
  self fadeoutshellshock();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self playersetgroundreferenceent(undefined);
    setsaveddvar("player_sprintUnlimited", "0");
    self notify("stop_limp_forgood");
  } else {
    var_2 = randomfloatrange(0.65, 1.25);
    var_3 = adjust_angles_to_player((0, 0, 0));
    self.ground_ref_ent rotateto(var_3, var_2, 0, var_2 / 2);
    self.ground_ref_ent waittill("rotatedone");
  }

  level.player maps\_utility::vision_set_fog_changes(level.originalvisionset, 0);
  setblur(0, randomfloatrange(0.5, 0.75));
  self allowstand(1);
  self allowcrouch(1);
  self allowprone(1);
  self allowsprint(1);
  self allowjump(1);
}

fade_limp(var_0) {
  self endon("stop_limp");
  wait(var_0);
  thread disable_limp();
}

limp(var_0) {
  self endon("stop_limp");
  self shellshock("player_limp", 9999);
  self allowsprint(0);
  self allowjump(0);
  thread player_random_blur();
  thread player_hurt_sounds();
  level waittill("blah blah blah");
  var_1 = 0;
  var_2 = self.vision_set_transition_ent.vision_set;

  for(;;) {
    if(self playerads() > 0.3) {
      wait 0.05;
      continue;
    }

    var_3 = level.player getstance();

    if(var_3 == "crouch" || var_3 == "prone") {
      wait 0.05;
      continue;
    }

    var_4 = self getvelocity();
    var_5 = abs(var_4[0]) + abs(var_4[1]);

    if(var_5 < 10) {
      wait 0.05;
      continue;
    }

    var_6 = var_5 / self.player_speed;
    var_7 = randomfloatrange(level.player_limp["pitch"]["min"], level.player_limp["pitch"]["max"]);

    if(randomint(100) < 20) {
      var_7 = var_7 * 1.5;
    }

    var_8 = randomfloatrange(level.player_limp["roll"]["min"], level.player_limp["roll"]["max"]);
    var_9 = randomfloatrange(level.player_limp["yaw"]["min"], level.player_limp["yaw"]["max"]);
    var_10 = (var_7, var_9, var_8);
    var_10 = var_10 * var_6;
    var_10 = var_10 * self.limp_strength;
    var_11 = randomfloatrange(0.15, 0.45);
    var_12 = randomfloatrange(0.65, 1.25);

    if(self.vision_set_transition_ent.vision_set != "aftermath_pain") {
      var_2 = self.vision_set_transition_ent.vision_set;
    }

    thread maps\_utility::vision_set_fog_changes("aftermath_pain", 3);
    thread stumble(var_10, var_11, var_12);
    wait(var_11);
    thread maps\_utility::vision_set_fog_changes(var_2, var_12);
    self waittill("recovered");
  }
}

stumble(var_0, var_1, var_2, var_3) {
  self endon("stop_stumble");
  self endon("stop_limp");

  if(maps\_utility::ent_flag("collapse")) {
    return;
  }
  var_0 = adjust_angles_to_player(var_0);
  self notify("stumble");
  create_ground_ref_ent();
  self.ground_ref_ent rotateto(var_0, var_1, var_1 / 4 * 3, var_1 / 4);
  self.ground_ref_ent waittill("rotatedone");
  var_4 = (randomfloat(4) - 4, randomfloat(5), 0);
  var_4 = adjust_angles_to_player(var_4);
  self.ground_ref_ent rotateto(var_4, var_2, 0, var_2 / 2);
  self.ground_ref_ent waittill("rotatedone");

  if(!isDefined(var_3)) {
    self notify("recovered");
  }
}

player_random_sway() {
  self endon("stop_random_sway");

  for(;;) {
    var_0 = self getvelocity();

    if(var_0 > 0) {
      wait 0.05;
      continue;
    }

    wait 0.05;
  }
}

player_random_blur() {
  self endon("dying");
  self endon("stop_random_blur");

  for(;;) {
    wait 0.05;

    if(randomint(100) > 10) {
      continue;
    }
    var_0 = randomint(3) + 4;
    var_1 = randomfloatrange(0.1, 0.3);
    var_2 = randomfloatrange(0.3, 1);
    setblur(var_0 * 1.2, var_1);
    wait(var_1);
    setblur(0, var_2);
    wait(var_2);
    wait(randomfloatrange(0, 1.5));
    common_scripts\utility::waittill_notify_or_timeout("blur", 5);
  }
}

player_hurt_sounds() {
  self endon("stop_limp");

  for(;;) {
    if(player_playing_hurt_sounds()) {
      wait 0.05;
      continue;
    }

    self notify("blur");
    common_scripts\utility::play_sound_in_space("breathing_limp_start");
    common_scripts\utility::play_sound_in_space("breathing_limp_better");
    wait(randomfloatrange(0, 1));
    common_scripts\utility::waittill_notify_or_timeout("stumble", randomintrange(5, 7));
  }
}

player_heartbeat() {
  self endon("stop_limp");
  level.player_heartbeat_rate = 0.75;

  for(;;) {
    common_scripts\utility::play_sound_in_space("breathing_limp_heartbeat");
    wait(level.player_heartbeat_rate);
  }
}

set_player_hearbeat_rate(var_0) {
  if(!isDefined(var_0) || isstring(var_0)) {
    level.player_heartbeat_rate = 0.75;
  } else {
    level.player_heartbeat_rate = var_0;
  }
}

player_playing_hurt_sounds() {
  if(level.player.health < 50) {
    return 1;
  } else {
    return 0;
  }
}

player_jump_punishment() {
  self endon("stop_limp_forgood");
  wait 1;

  for(;;) {
    wait 0.05;

    if(self isonground()) {
      continue;
    }
    wait 0.2;

    if(self isonground()) {
      continue;
    }
    for(;;) {
      if(self isonground()) {
        break;
      } else
        wait 0.05;
    }

    self notify("stop_stumble");
    wait 0.2;
    limp();
    self notify("start_limp");
  }
}

recover() {
  var_0 = adjust_angles_to_player((-5, -5, 0));
  self.ground_ref_ent rotateto(var_0, 0.4, 0.4, 0);
  self.ground_ref_ent waittill("rotatedone");
  var_0 = adjust_angles_to_player((-15, -20, 0));
  self.ground_ref_ent rotateto(var_0, 1, 0, 1);
  self.ground_ref_ent waittill("rotatedone");
  var_0 = adjust_angles_to_player((5, 5, 0));
  self.ground_ref_ent rotateto(var_0, 0.9, 0.7, 0.1);
  self.ground_ref_ent waittill("rotatedone");
  self.ground_ref_ent rotateto((0, 0, 0), 1, 0.2, 0.8);
}

adjust_angles_to_player(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}

create_ground_ref_ent() {
  if(isDefined(self.ground_ref_ent)) {
    return;
  }
  self.ground_ref_ent = spawn("script_model", (0, 0, 0));
  self playersetgroundreferenceent(self.ground_ref_ent);
}
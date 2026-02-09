/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_drunk_player.gsc
************************************************/

main() {
  common_scripts\utility::flag_init("force_limp");
  common_scripts\utility::flag_init("fall");
  common_scripts\utility::flag_init("collapse");
  common_scripts\utility::flag_init("collapse_done");
  common_scripts\utility::flag_init("aftermath_dont_do_wakeup");
  common_scripts\utility::flag_init("start_doing_aftermath_walk");
  common_scripts\utility::flag_init("player_heartbeat_sound");
  common_scripts\utility::flag_init("player_limping");
  common_scripts\utility::flag_init("stop_being_stunned");
  common_scripts\utility::flag_init("stop_fade_in_out");
  waittillframeend;
  level._id_5984 = 0.8;
  level.player._id_141D = 0.7;
}

_id_5985() {
  waittillframeend;
  waittillframeend;

  if(common_scripts\utility::flag("stop_aftermath_player")) {
    return;
  }
  level endon("stop_aftermath_player");
  level._id_5258 = spawn("script_model", (0, 0, 0));
  level.player playersetgroundreferenceent(level._id_5258);
  level childthread _id_5986();
  level notify("slowview");

  if(common_scripts\utility::flag("aftermath_dont_do_wakeup")) {
    return;
  }
  _id_598B();
}

_id_5986() {
  for(;;) {
    level waittill("slowview", var_0);

    if(isDefined(var_0)) {
      wait(var_0);
    }
    childthread _id_5987();
  }
}

_id_5987() {
  level endon("slowview");
  wait 10;
  level notify("slowview");
}

_id_5988() {
  common_scripts\utility::flag_set("player_heartbeat_sound");
  thread _id_4BCB();
}

_id_4BCB() {
  level notify("stop_heart");
  level endon("stop_heart");

  for(;;) {
    if(!common_scripts\utility::flag("fall")) {
      if(isDefined(level._id_5989)) {
        [[level._id_5989]]();
      }
      if(common_scripts\utility::flag("player_heartbeat_sound")) {
        wait 0.05;
        level.player playrumbleonentity("damage_light");
      }

      wait(level._id_5984);
    }

    wait(0 + randomfloat(0.1));

    if(randomint(50) > level.player._id_141D * 190) {
      wait(randomfloat(1));
    }
  }
}

_id_4F51() {}

_id_598A() {
  while(!common_scripts\utility::flag("stop_fade_in_out")) {
    maps\hijack_code::_id_09FA(0.3, randomfloatrange(0.5, 0.8));
    wait(randomfloatrange(0.2, 0.35));
    maps\hijack_code::_id_17CC(0.3);
    wait(randomfloatrange(2, 5));
  }
}

_id_598B() {
  common_scripts\utility::flag_wait("start_doing_aftermath_walk");
  thread _id_598F();
  level.player childthread _id_51E6();
}

_id_51E5(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(level.player.angles);
  var_4 = anglesToForward(level.player.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}

_id_5717() {
  thread _id_5993();
}

_id_598C(var_0) {
  level endon("stop_drunk_walk");
  var_1 = 1;
  var_2 = 1;

  for(;;) {
    var_3 = var_2 * level._id_598D;
    var_4 = randomfloatrange(var_3 * 0.5, var_3);
    var_1--;

    if(var_1 <= 0) {
      var_1 = randomint(3);
      var_4 = var_4 * -1;
    }

    var_5 = var_4 - var_0.origin[0];
    var_5 = abs(var_5);
    var_6 = var_5 * 0.05;

    if(var_6 < 0.05) {
      var_6 = 0.05;
    }
    var_7 = gettime();
    var_0 moveto((var_4, 0, 0), var_6, var_6 * 0.5, var_6 * 0.5);
    wait(var_6);
    maps\_utility::_id_1254(var_7, 0.6);

    for(;;) {
      var_8 = distance((0, 0, 0), level.player getvelocity());

      if(var_8 >= 80) {
        break;
      }

      wait 0.05;
    }
  }
}

_id_598E() {
  level waittill("stop_drunk_walk");
  var_0 = 0.8;
  level._id_5258 rotateto((0, 0, 0), var_0, var_0 * 0.5, var_0 * 0.5);
  wait(var_0);
  level._id_5258 delete();
  level.player playersetgroundreferenceent(undefined);
  setslowmotion(0.95, 1, 0.5);
}

_id_598F() {
  thread _id_598E();
  level endon("stop_drunk_walk");
  level._id_598D = 5.0;
  var_0 = 0;
  var_1 = 0;
  var_2 = 0.1;

  for(;;) {
    var_3 = distance((0, 0, 0), level.player getvelocity());
    var_0 = var_0 + var_3 * 0.026 * level._id_598D;

    if(var_3 == 0) {
      var_0 = var_0 + 1.5;
    } else {
      var_0 = var_0 + randomfloatrange(0, 2);
    }
    var_1 = var_1 + var_3 * 0.01 * level._id_598D;

    if(var_3 == 0) {
      var_1 = var_1 + 1.5;
    } else {
      var_1 = var_1 + randomfloatrange(0, 2);
    }
    if(cos(var_0) > 0) {
      var_0 = var_0 + var_3 * 0.1;
    }
    var_4 = sin(var_0) - 1;
    var_5 = var_4 * 1.8 * level._id_598D;
    var_6 = sin(var_0) * 1.26 * level._id_598D;
    var_7 = sin(var_1) * 1.8 * level._id_598D;

    if(!common_scripts\utility::flag("player_limping")) {
      level._id_5258 rotateto((var_5, var_7, var_6), var_2, var_2 * 0.5, var_2 * 0.5);
    }
    wait 0.05;
  }
}

_id_5990(var_0) {
  level notify("swivel_stunplayer");
  level endon("swivel_stunplayer");
  level.player allowcrouch(0);
  level.player allowprone(0);
  wait(var_0);
  level.player allowcrouch(1);
  level.player allowprone(1);
}

_id_5991() {
  level endon("stop_drunk_walk");
  var_0 = 1;
  var_1 = 0.15;
  var_2 = 4;
  wait 3;

  for(;;) {
    setslowmotion(var_0, 0.89, var_2);
    wait(var_2);
    setslowmotion(var_0, 1.06, var_2);
    wait(var_2);
  }
}

_id_5992(var_0) {
  level endon("stop_drunk_walk");
  var_1 = 0;
  var_2 = 140;
  var_3 = common_scripts\utility::getstruct("limp_yaw_ent", "targetname");
  var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
  var_5 = vectortoangles(var_4.origin - var_3.origin);
  var_6 = anglesToForward(var_5);
  var_7 = 0;

  for(;;) {
    var_8 = distance((0, 0, 0), level.player getvelocity());
    var_9 = var_8 > 80;
    var_10 = level.player getplayerangles();
    var_11 = anglesToForward(var_10);
    var_12 = vectordot(var_11, var_6) >= 0.8;

    if(var_9 && var_12) {
      var_1 = var_1 + 2;
    } else {
      var_1 = var_1 - 1;
    }
    var_1 = clamp(var_1, 0, var_2);

    if(var_1 < var_2) {
      wait 0.05;
      continue;
    }

    var_1 = 0;

    if(!var_7) {
      var_7 = 1;
      _id_5717();
      var_13 = 2;
      var_14 = common_scripts\utility::spawn_tag_origin();
      var_14.origin = (level._id_598D, 0, 0);
      var_14 moveto((1, 0, 0), var_13, var_13 * 0.5, var_13 * 0.5);

      for(;;) {
        level._id_598D = var_14.origin[0];

        if(level._id_598D == 1) {
          break;
        }

        wait 0.05;
      }

      var_14 delete();
      return;
    }

    var_2 = randomintrange(70, 125);
    var_13 = 0.45;
    var_15 = randomfloatrange(-16, -11);
    var_0 moveto((var_15, 0, 0), var_13, 0, var_13);
    wait(var_13);
    var_13 = var_13 * 0.8;
    var_16 = randomfloatrange(-2, 2);
    var_0 moveto((var_16, 0, 0), var_13, var_13 * 0.5, var_13 * 0.5);
    wait(var_13);
  }
}

_id_5993() {
  level notify("kill_limp");
  level endon("kill_limp");

  for(;;) {
    var_0 = distance((0, 0, 0), level.player getvelocity());

    if(var_0 < 80) {
      wait 0.05;
      continue;
    }

    var_1 = 2.3;
    level.player thread _id_5990(var_1);
    level notify("not_random_blur");
    common_scripts\utility::noself_delaycall(0.5, ::setblur, 4, 0.25);
    common_scripts\utility::noself_delaycall(1.2, ::setblur, 0, 1);
    maps\_utility::delaythread(var_1, ::_id_51E6);
    level.player playrumbleonentity("damage_light");
    level.player maps\_utility::_id_279B(0.35, 0.3);
    level.player maps\_utility::delaythread(var_1 * 0.5, maps\_utility::_id_279B, 0.7, var_1);
    common_scripts\utility::flag_clear("force_limp");
    wait(var_1);
    break;
  }
}

_id_5994() {
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    var_2 = randomfloatrange(2, 4);
    wait(var_2);
    var_3 = level.player getvelocity();
    var_4 = abs(var_3[0]) + abs(var_3[1]);

    if(var_4 < 10 && !common_scripts\utility::flag("force_limp")) {
      wait 0.05;
      continue;
    }

    var_5 = var_4 / (level.player._id_141D * 190);
    var_6 = randomfloatrange(3, 5);

    if(randomint(100) < 20) {
      var_6 = var_6 * 1.5;
    }
    var_7 = randomfloatrange(0.35, 0.45);
    var_8 = randomfloatrange(0.65, 0.8);

    if(common_scripts\utility::flag("force_limp")) {
      common_scripts\utility::flag_clear("force_limp");
      var_5 = 0.35;
      var_6 = var_6 * 3;
      var_7 = randomfloatrange(0.7, 0.85);
      var_8 = randomfloatrange(1.65, 1.8);
    }

    var_9 = randomfloatrange(3, 7);
    var_10 = randomfloatrange(-8, -2);
    var_11 = (var_6, var_10, var_9);
    var_11 = var_11 * var_5;
    var_0++;

    if(var_5 > 1.3) {
      var_0++;
    }
    common_scripts\utility::flag_set("player_limping");
    childthread _id_51E4(var_11, var_7, var_8);
    level common_scripts\utility::waittill_either("recovered", "force_limp");
    common_scripts\utility::flag_clear("player_limping");
  }
}

_id_5995() {
  level waittill("not_random_blur");
  setblur(0, 0.1);
}

_id_51E6() {
  thread _id_5995();
  level endon("dying");
  level endon("not_random_blur");

  for(;;) {
    wait 0.05;

    if(randomint(100) > 10) {
      continue;
    }
    var_0 = randomint(5) + 2;
    var_1 = randomfloatrange(0.3, 0.9);
    var_2 = randomfloatrange(0.3, 1);
    setblur(var_0 * 1.2, var_1);
    wait(var_1);
    setblur(0, var_2);
    wait 5;
  }
}

_id_5996() {
  wait 2;

  for(;;) {
    if(level.player isonground()) {
      break;
    }

    wait 0.05;
  }

  for(;;) {
    wait 0.05;

    if(level.player isonground()) {
      continue;
    }
    wait 0.2;

    if(level.player isonground()) {
      continue;
    }
    level notify("stop_stumble");
    wait 0.2;
  }
}

_id_51E4(var_0, var_1, var_2, var_3) {
  level endon("stop_stumble");

  if(common_scripts\utility::flag("collapse")) {
    return;
  }
  var_0 = _id_51E5(var_0);
  level._id_5258 rotateto(var_0, var_1, var_1 / 4 * 3, var_1 / 4);
  level._id_5258 waittill("rotatedone");
  var_4 = (randomfloat(4) - 4, randomfloat(5), 0);
  var_4 = _id_51E5(var_4);
  level._id_5258 rotateto(var_4, var_2, 0, var_2 / 2);
  level._id_5258 waittill("rotatedone");

  if(!isDefined(var_3)) {
    level notify("recovered");
  }
}

_id_5997() {
  var_0 = _id_51E5((-5, -5, 0));
  level._id_5258 rotateto(var_0, 0.6, 0.6, 0);
  level._id_5258 waittill("rotatedone");
  var_0 = _id_51E5((-15, -20, 0));
  level._id_5258 rotateto(var_0, 2.5, 0, 2.5);
  level._id_5258 waittill("rotatedone");
  var_0 = _id_51E5((5, 5, 0));
  level._id_5258 rotateto(var_0, 2.5, 2, 0.5);
  level._id_5258 waittill("rotatedone");
  level._id_5258 rotateto((0, 0, 0), 1, 0.2, 0.8);
}

_id_4595(var_0) {
  wait 0.1;
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("compass", "0");
  setsaveddvar("ammoCounterHide", "1");
}
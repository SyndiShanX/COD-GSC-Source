/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mute_smoke.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;

#namespace mute_smoke;

init_shared() {
  level.var_1850a22d = getweapon(#"mute_smoke");

  if(isDefined(level.var_1850a22d) && level.var_1850a22d.name != "none") {
    function_783a1c07(level.var_1850a22d);
    clientfield::register("allplayers", "in_enemy_mute_smoke", 1, 1, "int", &function_b2248deb, 0, 0);
    clientfield::register("allplayers", "inFriendlyMuteSmoke", 1, 1, "int", &function_baebe8c4, 0, 0);
    level thread function_12e09509();
    level.var_1726ea2d = [];
    level.var_1726ea2d[#"stand"] = 62;
    level.var_1726ea2d[#"crouch"] = 42;
    level.var_1726ea2d[#"prone"] = 13;
  }
}

function_3e8d9b27(previs_weapon) {
  previs_model = self;

  if(isDefined(previs_weapon.var_4bcd08b0)) {
    previs_model setModel(previs_weapon.var_4bcd08b0);
  } else {
    previs_model setModel(#"hash_7a80bed4a96537e6");
  }

  previs_model notsolid();
}

function_783a1c07(weapon) {
  assert(isDefined(weapon.customsettings), "<dev string:x38>" + weapon.name);
  level.mute_smoke_custom_settings = getscriptbundle(weapon.customsettings);
}

function_12e09509(localclientnum = 0) {
  level notify("previs_mute_smoke_" + localclientnum);
  level endon("previs_mute_smoke_" + localclientnum);
  wait 10;
  var_46e1fb08 = spawn(localclientnum, (0, 0, 0), "script_model");
  var_37b85cb5 = spawn(localclientnum, (0, 0, 0), "script_model");
  var_618fb067 = spawn(localclientnum, (0, 0, 0), "script_model");
  previs_weapon = level.var_1850a22d;
  var_46e1fb08 function_3e8d9b27(previs_weapon);
  var_37b85cb5 function_3e8d9b27(previs_weapon);
  var_618fb067 function_3e8d9b27(previs_weapon);
  var_46e1fb08 duplicate_render::set_player_threat_detected(localclientnum, 1);
  var_37b85cb5 duplicate_render::set_player_threat_detected(localclientnum, 1);
  var_618fb067 duplicate_render::set_player_threat_detected(localclientnum, 1);
  var_5929417d = 0;
  var_34bb1a09 = 0;

  while(true) {
    var_fdadca2a = previs_weapon;

    if(getdvarint(#"hash_292cfff396e8aa70", 0) == 0) {
      var_5929417d = 0;
    }

    if(!var_5929417d) {
      if(!isDefined(var_46e1fb08) || !isDefined(var_37b85cb5) || !isDefined(var_618fb067)) {
        break;
      }

      var_46e1fb08 hide();
      var_37b85cb5 hide();
      var_618fb067 hide();

      if(previs_weapon == level.var_1850a22d) {
        waitframe(1);
      } else {
        wait 0.2;
      }
    } else {
      waitframe(1);
    }

    var_5929417d = 0;
    player = function_5c10bd79(localclientnum);

    if(!isDefined(player)) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(!player function_8e51b4f(0)) {
      if(var_34bb1a09) {

        function_e08f51f(var_46e1fb08.origin);
        function_e08f51f(var_37b85cb5.origin);
        function_e08f51f(var_618fb067.origin);

      }

      var_34bb1a09 = 0;
      continue;
    }

    var_34bb1a09 = 1;
    previs_weapon = getcurrentweapon(localclientnum);

    if(!(previs_weapon === level.var_1850a22d)) {
      continue;
    }

    var_5929417d = 1;

    if(var_46e1fb08 ishidden()) {
      var_46e1fb08 show();
      var_37b85cb5 show();
      var_618fb067 show();
    }

    function_783a1c07(previs_weapon);

      settings = level.mute_smoke_custom_settings;
    var_91f40e9 = max(isDefined(settings.var_91f40e9) ? settings.var_91f40e9 : 1, 0.01);
    var_46e1fb08 setscale(var_91f40e9);
    var_37b85cb5 setscale(var_91f40e9);
    var_618fb067 setscale(var_91f40e9);
    var_a19445f = isads(localclientnum);
    var_de0fa6f1 = isDefined(settings.var_de0fa6f1) ? settings.var_de0fa6f1 : var_a19445f ? isDefined(settings.fx_done) ? settings.fx_done : 0 : 0;
    var_46f48578 = max(isDefined(settings.var_46f48578) ? settings.var_46f48578 : var_a19445f ? isDefined(settings.var_bdb59983) ? settings.var_bdb59983 : 0 : 0, 0.1);
    var_71c4a0d9 = var_a19445f ? isDefined(settings.var_75171533) ? settings.var_75171533 : 0 : 0;
    var_99803ce = isDefined(settings.var_99803ce) ? settings.var_99803ce : var_a19445f ? isDefined(settings.var_8db2ddd7) ? settings.var_8db2ddd7 : 0 : 0;
    var_3300383 = max(isDefined(settings.var_3300383) ? settings.var_3300383 : var_a19445f ? isDefined(settings.var_ca506691) ? settings.var_ca506691 : 0 : 0, 0.1);
    var_6b0817d7 = var_a19445f ? isDefined(settings.var_7163a11a) ? settings.var_7163a11a : 0 : 0;
    facing_angles = getlocalclientangles(localclientnum);
    forward = anglesToForward(facing_angles);
    up = anglestoup(facing_angles);
    velocity = function_711c258(forward, up, previs_weapon);
    grenadeangles = vectortoangles(velocity);
    eye_pos = getlocalclienteyepos(localclientnum);
    trace1 = projectiletrace(eye_pos, velocity, 0);
    var_46e1fb08.origin = trace1[#"position"];
    var_46e1fb08.angles = (angleclamp180(vectortoangles(trace1[#"normal"])[0] + 90), vectortoangles(trace1[#"normal"])[1], 0);
    speed = length(velocity);
    var_2571f440 = grenadeangles + (var_de0fa6f1, var_71c4a0d9, 0);
    var_d2922c1e = vectorscale(anglesToForward(var_2571f440), speed * var_46f48578);
    trace2 = projectiletrace(eye_pos, var_d2922c1e, 0);
    var_37b85cb5.origin = trace2[#"position"];
    var_37b85cb5.angles = (angleclamp180(vectortoangles(trace2[#"normal"])[0] + 90), vectortoangles(trace2[#"normal"])[1], 0);
    var_c1917dbc = grenadeangles + (var_99803ce, var_6b0817d7, 0);
    var_c0cb8891 = vectorscale(anglesToForward(var_c1917dbc), speed * var_3300383);
    trace3 = projectiletrace(eye_pos, var_c0cb8891, 0);
    var_618fb067.origin = trace3[#"position"];
    var_618fb067.angles = (angleclamp180(vectortoangles(trace3[#"normal"])[0] + 90), vectortoangles(trace3[#"normal"])[1], 0);
  }
}

function_e08f51f(origin, color) {
  if(getdvarint(#"hash_23f044f7a5117090", 0)) {
    if(!isDefined(color)) {
      color = (0.5, 0, 0);
    }

    sphere(origin, 6, color, 0.5, 1, 20, int(62.5) * 15);
  }
}

  function function_b2248deb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_7aeda665(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }

function_baebe8c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_24dbaaee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function_24dbaaee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    audio::snd_set_snapshot("cod_mute_smoke_enemy");
    return;
  }

  audio::snd_set_snapshot("default");
}

function_7aeda665(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;
  var_f0120993 = function_5778f82(localclientnum, #"hash_410c46b5ff702c96");

  if(var_f0120993 && !player function_83973173()) {
    if(newval == 0) {
      player stoprenderoverridebundle("rob_mute_smoke_outline");
      return;
    }

    player playrenderoverridebundle("rob_mute_smoke_outline");
  }
}

function_12d5587e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = self;
  var_f0120993 = function_5778f82(localclientnum, #"hash_410c46b5ff702c96");

  if(var_f0120993 && !player function_83973173()) {
    if(newval == 0) {
      local_player = function_5c10bd79(localclientnum);
      local_player notify("stop_watching_enemy_visibility" + player getentitynumber());
      player duplicate_render::set_hacker_tool_hacked(localclientnum, 0);
      return;
    }

    local_player thread function_a189ab2e(localclientnum, player);
  }
}

function_a189ab2e(localclientnum, enemy) {
  local_player = self;
  local_player notify("stop_watching_enemy_visibility" + enemy getentitynumber());
  local_player endon(#"death", "stop_watching_enemy_visibility" + enemy getentitynumber());
  enemy endon(#"death", #"disconnect");
  can_see_enemy = 0;

  while(true) {
    var_936b9149 = enemy function_775916af();
    enemy_eye_pos = enemy.origin + (0, 0, var_936b9149);
    player_eye_pos = local_player getEye();
    trace = bulletTrace(player_eye_pos, enemy_eye_pos, 1, enemy);
    var_8c0e537d = can_see_enemy;
    can_see_enemy = trace[#"fraction"] > 0.95;

    if(var_8c0e537d != can_see_enemy) {
      enemy duplicate_render::set_hacker_tool_hacked(localclientnum, can_see_enemy);
    }

    wait 0.016;
  }
}

function_775916af() {
  if(!isplayer(self)) {
    return 62;
  }

  stance = self getstance();
  return isDefined(level.var_1726ea2d[stance]) ? level.var_1726ea2d[stance] : 62;
}
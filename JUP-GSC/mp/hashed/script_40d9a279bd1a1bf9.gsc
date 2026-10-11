/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_40d9a279bd1a1bf9.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_3390b73ac3318fe;
#using script_3559130ee2bb3a29;
#using script_485622d93fa7e4cf;
#using script_6f65366f542f6627;
#using script_7f9409b703dad400;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pmc_missions;
#using scripts\mp\utility\player;
#namespace namespace_59f1784f5951dcb9;

function function_b30e7d622f569725() {
  load_vfx();
  level thread create_portal();
  level flag_wait("ob_infil_completed");
  init_portal();
}

function load_vfx() {
  level._effect["acv_distortion"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_riftrun_traversal_distortion.vfx");
  level._effect["protection_bubble"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_acv_protection_bubble.vfx");
}

function create_portal() {
  flag_wait("create_script_initialized");
  spawndata = getStruct("ob_s5_story_mission_portal", "targetname");

  if(isDefined(spawndata)) {
    spawndata.initai = 0;
    spawndata.preventrespawn = 1;
    level.var_d930589c2bd20abd = utility::spawn_model("jup_zm_rift_portal_small", spawndata.origin, spawndata.angles);
    waitframe();
    level.var_d930589c2bd20abd setscriptablepartstate("aether_exit_body", "rift_mission_infil_s5");
    var_885095f29666fd07 = scripts\cp_mp\interaction::register_interact(level.var_d930589c2bd20abd, 140, &function_dd50de34ad9f5b2f);
    var_885095f29666fd07 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_816b580f6517f4fa);
    level.var_d930589c2bd20abd hide();
    return;
  }

  println("<dev string:x1c>");
}

function function_5db463c76967e543() {
  while(true) {
    level.var_35171ed239f57586 = getdvarfloat(@ "hash_5e8f51ae1a49e3dd", 24000);

    if(isDefined(level.var_d930589c2bd20abd.origin) && isDefined(level.var_35171ed239f57586)) {
      level.var_d930589c2bd20abd.nearby_players = scripts\mp\utility\player::getplayersinradius(level.var_d930589c2bd20abd.origin, level.var_35171ed239f57586);

      foreach(player in level.var_d930589c2bd20abd.nearby_players) {
        squadmates = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

        foreach(squadmate in squadmates) {
          if(!istrue(squadmate.var_bf5ad13ead32ce83)) {
            scripts\cp_mp\overlord::playconversation("s5_intro", [squadmate]);
            squadmate.var_bf5ad13ead32ce83 = 1;
          }
        }

        if(!istrue(player.var_bf5ad13ead32ce83)) {
          scripts\cp_mp\overlord::playconversation("s5_intro", [player]);
          player.var_bf5ad13ead32ce83 = 1;
        }
      }
    }

    level.var_33034a8465b1c317 = getdvarfloat(@ "hash_1bb3e3ddf9c210b0", 18000);

    if(isDefined(level.var_d930589c2bd20abd.origin) && isDefined(level.var_33034a8465b1c317)) {
      level.var_d930589c2bd20abd.nearby_players = scripts\mp\utility\player::getplayersinradius(level.var_d930589c2bd20abd.origin, level.var_33034a8465b1c317);

      foreach(player in level.var_d930589c2bd20abd.nearby_players) {
        squadmates = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

        foreach(squadmate in squadmates) {
          if(!istrue(squadmate.var_2d0ea8c48fd0548b)) {
            scripts\cp_mp\overlord::playconversation("s5_traversal", [squadmate]);
            squadmate.var_2d0ea8c48fd0548b = 1;
          }
        }

        if(!istrue(player.var_bf5ad13ead32ce83)) {
          scripts\cp_mp\overlord::playconversation("s5_traversal", [player]);
          player.var_2d0ea8c48fd0548b = 1;
        }
      }
    }

    level.var_1921321c661f4ef4 = getdvarfloat(@ "hash_4f68b051926055dd", 500);

    if(isDefined(level.var_d930589c2bd20abd.origin) && isDefined(level.var_1921321c661f4ef4)) {
      level.var_d930589c2bd20abd.nearby_players = scripts\mp\utility\player::getplayersinradius(level.var_d930589c2bd20abd.origin, level.var_1921321c661f4ef4);

      foreach(player in level.var_d930589c2bd20abd.nearby_players) {
        squadmates = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

        foreach(squadmate in squadmates) {
          if(!istrue(squadmate.var_c5211570e6c28fd8)) {
            scripts\cp_mp\overlord::playconversation("s5_portal_arrival", squadmates);
            squadmate.var_c5211570e6c28fd8 = 1;
          }
        }

        if(!istrue(player.var_c5211570e6c28fd8)) {
          scripts\cp_mp\overlord::playconversation("s5_portal_arrival", [player]);
          player.var_c5211570e6c28fd8 = 1;
        }
      }
    }

    wait 1;
  }
}

function function_816b580f6517f4fa(interact, player) {
  if(isDefined(player.team) && isDefined(player.sessionsquadid)) {
    votinginprogress = namespace_af93597583d94051::function_755c94f4a8509b03(player.team, player.sessionsquadid);
  }

  if(istrue(votinginprogress)) {
    return {
      #string: &"JUP_OB_S3/RIFT_TOKEN_VOTE_IN_PROGRESS", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_S5/MISSION_RIFT_ENTRY_HINT", #type: "HINT_BUTTON"};
}

function init_portal() {
  foreach(player in level.players) {
    if(player namespace_9571f642f38c8169::function_3bb8b73991355a1(19) || function_3296d5cb0ee5af26(player) || getdvarint(@ "hash_6b481b4f7f70f7fd", 0)) {
      level.var_d930589c2bd20abd showtoplayer(player);
      player thread function_771cbd84a236e2ba(level.var_d930589c2bd20abd.origin);
    }
  }
}

function function_88ff0f838d5cb41b(player) {
  return player namespace_9571f642f38c8169::function_3bb8b73991355a1(19) || function_3296d5cb0ee5af26(player) || getdvarint(@ "hash_6b481b4f7f70f7fd", 0);
}

function function_3296d5cb0ee5af26(player) {
  return scripts\mp\pmc_missions::function_c7d3c1cb4a3958cf(player, 41372) || getdvarint(@ "hash_c2acc91041184029", 0);
}

function function_dc7ea1dd836df0e3() {
  return getdvarint(@ "hash_3ee6bd48b53d3ff0", 0);
}

function function_8b67e03b991ac60f(obj_id) {
  if(function_dc7ea1dd836df0e3()) {
    level thread scripts\cp_mp\overlord::playevent("s5_intro", [self]);
  }

  objective_playermask_addshowplayer(obj_id, self);
}

function function_771cbd84a236e2ba(portalloc) {
  level endon("game_ended");

  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(distance2dsquared(portalloc, player.origin) < squared(900)) {
          level thread scripts\cp_mp\overlord::playevent("s5_portal_arrival", player getsquadmembers(undefined, 0));
          return;
        }
      }
    }

    wait 0.2;
  }
}

function function_eedd40fa46e83c7(player) {
  if(isDefined(player.team) && isDefined(player.sessionsquadid)) {
    votinginprogress = namespace_af93597583d94051::function_755c94f4a8509b03(player.team, player.sessionsquadid);
  }

  if(istrue(votinginprogress)) {
    return;
  }

  player_squad = player getsquadmembers(undefined, 0);

  foreach(var_3329887886bd6a4b in player_squad) {
    self disableplayeruse(var_3329887886bd6a4b);
  }

  namespace_af93597583d94051::function_fd5211de155982af(player.team, player.sessionsquadid, 1);
  namespace_6c57c664b4288f88::function_93c8f90c3bd798c6(player, 30, &function_d7cf952e6f352615);
  namespace_af93597583d94051::function_fd5211de155982af(player.team, player.sessionsquadid, 0);

  foreach(var_3329887886bd6a4b in player_squad) {
    self enableplayeruse(var_3329887886bd6a4b);
  }
}

function function_dd50de34ad9f5b2f(player) {
  thread function_eedd40fa46e83c7(player);
}

function function_d7cf952e6f352615(player) {
  a_squad = player getsquadmembers(undefined, 0);
  n_time_limit = 10;
  timer = namespace_26c5a699d7cb84a2::function_3eec8a169e8a0936(n_time_limit);
  waitframe();

  while(timer.progresscomplete != 1) {
    n_time_remaining = int(timer.currentprogressvalue);

    foreach(squaddie in a_squad) {
      squaddie setclientomnvar("ui_is_exfil_countdown", 1);
      squaddie setclientomnvar("ui_match_start_countdown", n_time_remaining);
    }

    wait 0.5;
  }

  var_de86fccc00b662d7 = [];

  foreach(player in a_squad) {
    if(isalive(player) && player.sessionstate == "playing") {
      var_de86fccc00b662d7[var_de86fccc00b662d7.size] = player;
    }
  }

  a_squad = var_de86fccc00b662d7;

  foreach(player in a_squad) {
    player scripts\common\values::set("rift_gate_teleport", "ignoreme", 1);
    player scripts\common\values::set("rift_gate_teleport", "damage", 0);
    player scripts\common\values::set("rift_gate_teleport", "fire", 0);
    player playerhide();
    player thread namespace_cc781f142d33c074::function_2241b80779e319a0();
  }

  wait 5;
  namespace_cddd3ad399b210ff::function_e229d89e0c38206d(a_squad, 1013);
}
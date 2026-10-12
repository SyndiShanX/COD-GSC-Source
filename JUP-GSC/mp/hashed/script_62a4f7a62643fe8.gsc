/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_62a4f7a62643fe8.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\mp\objective_marker_bundle_helper;
#using script_41387eecc35b88bf;
#using script_4e6e58ab5d96c2b0;
#using script_4fa22bc28608e9bd;
#using script_638d701d263ee1ed;
#using script_645acc6422636f9f;
#using script_686729055b66c6e4;
#using script_749ff6f56673a813;
#using script_7d3e27aa82b5d70b;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\radiation;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#namespace aether_storm;

function private autoexec __init__system__() {
  system::register(#"aether_storm", #"radiation", undefined, &function_13dad5c9339829d7);
}

function private function_13dad5c9339829d7() {
  function_1e80b64e11b75717(4);
  utility::flag_set("aether_storm_post_main");
}

function init(var_736128b97152603e, no_timer, disable_ai) {
  if(!isDefined(var_736128b97152603e)) {
    var_736128b97152603e = 0;
  }

  if(!isDefined(no_timer)) {
    no_timer = 0;
  }

  if(!isDefined(disable_ai)) {
    disable_ai = 0;
  }

  if(getdvarint(@ "hash_3dd989b5ea61ba6f", 1) == 0) {
    return;
  }

  utility::flag_wait("aether_storm_post_main");
  level.aether_storm = spawnStruct();
  level.aether_storm.announcement_handler = getdvarint(@ "hash_5a70272ae9c13aba", randomint(4));
  level.aether_storm.difficulty = getDvar(@ "hash_3570a73528bc6c57", "difficulty_hard");
  level.aether_storm.difficulty_round = namespace_f721fc7d0d2d0f47::function_300a6f8c556edf34(level.aether_storm.difficulty);
  level.aether_storm.var_ad737473be1f0d04 = getdvarfloat(@ "hash_48fce4738c89906d", 2);
  level.aether_storm.var_ab66a0c49f0e8d6e = getdvarint(@ "hash_ef880dd4dd945267", 1);
  level.aether_storm.var_9a2fdb386cc15ae0 = getdvarint(@ "hash_b1cf46e1d5ae423", 40) / 100;
  level.aether_storm.var_31068981fd9277c6 = getdvarint(@ "hash_dfb596b3039b2ce8", 4000);

  if(level.aether_storm.var_ad737473be1f0d04 == 0) {
    assertmsg("<dev string:x1c>");
    level.aether_storm.var_ad737473be1f0d04 = 2;
  }

  level.aether_storm.damage_initial = getdvarfloat(@ "hash_189419721d7412a4", 1);
  level.aether_storm.var_8f7178eaf2132d21 = getdvarfloat(@ "hash_e726f57a75564644", 1);
  level.aether_storm.expansion_radius = getdvarfloat(@ "hash_73fb2647d04d8532", 150000);
  level.aether_storm.var_647bf2cbf73994dd = getdvarfloat(@ "hash_fbacce5f528debee", 900);

  if(level.aether_storm.var_647bf2cbf73994dd == 0) {
    assertmsg("<dev string:x64>");
    level.aether_storm.var_647bf2cbf73994dd = 900;
  }

  level.aether_storm.var_719deb8a1a45bb85 = var_736128b97152603e;
  level.aether_storm.var_be0e041e85848a6d = getdvarfloat(@ "hash_def8fa242a39f28a", 120);
  level.aether_storm.var_94ea725a035aef57 = getdvarint(@ "hash_bd3120ea0bb6d372", 1);
  level.aether_storm.var_284270df3a99404 = getdvarint(@ "hash_72ba177e9302417d", 4);
  level.aether_storm.var_ade6a22953100a52 = getdvarint(@ "hash_9d525c99ff116a6b", 5);
  level.aether_storm.var_a89d2433198e329e = getdvarint(@ "hash_29c4e4b3ff6b2159", 10);
  level.aether_storm.var_6da5e5e442abcb81 = getdvarint(@ "hash_bff453f82de0cd52", 2000);
  level.aether_storm.var_913f0729da2f7bf7 = getdvarint(@ "hash_22cc44afa6458c74", 200);
  level.aether_storm.var_4f4ea0d0cc4b762e = getdvarint(@ "hash_9d54b97a0913a26f", 300);
  level.aether_storm.var_100cbabc49ba5983 = getdvarint(@ "hash_ec4801d38e2142fa", 1);
  level.aether_storm.var_43db6b44cd164b89 = getdvarint(@ "hash_10a9552d616d06e", 600);
  level.aether_storm.var_a60ecdae78f1434 = getdvarint(@ "hash_337a9a81a2f1f609", 1000);
  level.aether_storm.starting_origin = getdvarvector(@ "hash_e87112fd790d0025", (0, 0, 0));
  level.aether_storm.starting_radius = getdvarfloat(@ "hash_ca78b25fa9294859", 2048);
  level.aether_storm.quest_circle = getDvar(@ "hash_3129af15e2d3b58d", "Radiation_Ob");
  level.aether_storm.var_8b570b76600ddee9 = getdvarint(@ "hash_c48e636b439fd3d4", 1);
  level.aether_storm.var_a75317daa0bd7ff9 = getdvarint(@ "hash_53f5aebc06cfbfaa", 1);
  level.aether_storm.var_2115c7dedd7891f6 = getdvarfloat(@ "hash_2f9db323da7ff325", 0);
  level.aether_storm.timer_disabled = no_timer;
  level.ontimelimit = &start_expansion;
  utility::registersharedfunc("exfil", "setupHeliGasmasks", &function_698d99f6cc939e34);
  callback::add("aether_storm_expansion_started", &function_fad17bd00c6aaaa2);
  level.var_5a7da78693d33e77 = &function_d090388a81292bef;

  if(!isdvardefined(@ "hash_e87112fd790d0025")) {
    start_points = utility::getStructArray("aether_storm_spawnpoint", "targetname");

    if(start_points.size == 1) {
      level.aether_storm.starting_origin = start_points[0].origin;
    } else if(start_points.size > 1) {
      level.aether_storm.starting_origin = start_points[randomint(start_points.size)].origin;
    }
  }

  assert(isDefined(level.aether_storm.starting_origin));

  if(!isdvardefined(@ "hash_fde13d1db062b032")) {
    region_difficulty = namespace_f721fc7d0d2d0f47::function_4d8bb2d866771a10(level.aether_storm.starting_origin);

    switch (region_difficulty) {
      case #"hash_7bb2cd766703d463":
        level.aether_storm.difficulty = "difficulty_normal";
        break;
      case #"hash_af83e47edfa8900a":
        level.aether_storm.difficulty = "difficulty_hard";
        break;
    }
  }

  assert(isDefined(level.aether_storm.difficulty));
  assert(level.aether_storm.difficulty != "<dev string:xaf>" && level.aether_storm.difficulty != "<dev string:xc7>", "<dev string:xda>");
  level.aether_storm.radiation = radiation::create(level.aether_storm.starting_origin, level.aether_storm.starting_radius, level.aether_storm.var_8f7178eaf2132d21, level.aether_storm.quest_circle, 1);
  level.aether_storm.radiation radiation::set_damage(level.aether_storm.damage_initial);
  level.aether_storm.radiation callback::add("player_entered_radiation", &function_f4df458e2841cbf1);
  level.aether_storm.radiation callback::add("player_exited_radiation", &function_38b3b1600f7440b1);
  level callback::add("player_death", &function_d0f8b9fdea272469);

  if(!istrue(disable_ai)) {
    thread function_a143c9a0fa3af9f6();
    thread function_e427c341b9abc409();
  }

  thread function_d8626a2206442680();
  thread function_db25872d3eb4f360();
  thread function_abc28a284657371f();
  thread function_9a4d5d4bcc9e2c58();
  thread function_ebf8ee98cf7a3be0();

  thread _debug_init();

  utility::flag_set("aether_storm_initialized");
}

function function_d090388a81292bef() {
  if(flag("aether_storm_expansion_started")) {
    return getdvarint(@ "hash_5dcbbf68e812db67", 60);
  }

  return undefined;
}

function expansion_started() {
  return isDefined(level.aether_storm.radiation) && istrue(level.aether_storm.radiation.transforming);
}

function start_expansion() {
  assert(isDefined(level.aether_storm.radiation), "<dev string:x170>");

  if(expansion_started() || getdvarint(@ "hash_d255f69a6c34b1ac", 0)) {
    return;
  }

  if(!isDefined(level.aether_storm.var_3f24322be8ae1969)) {
    if(!level.aether_storm.var_719deb8a1a45bb85) {
      assertmsg("<dev string:x1d3>");
    }

    level.aether_storm.var_3f24322be8ae1969 = level.aether_storm.var_647bf2cbf73994dd;
  }

  level.aether_storm.radiation callback::add("radiation_transform_update", &function_dd834b585f86b332);
  level.aether_storm.radiation callback::add("radiation_transform_completed", &function_8f95016c770a1f8c);
  level.aether_storm.radiation radiation::transform(level.aether_storm.starting_origin, level.aether_storm.expansion_radius, level.aether_storm.var_3f24322be8ae1969);
  level.aether_storm.radiation radiation::set_damage(getdvarfloat(@ "hash_8130f3d5e4e1de85", 2));
  level callback::callback("aether_storm_expansion_started");
  utility::flag_set("aether_storm_expansion_started");
  level thread ob_music::function_68692864a2e0769b();
  var_edb92fd48d975084 = exfil::function_c51a46f4a60b13d5();

  foreach(exfil in var_edb92fd48d975084) {
    exfil.var_64f10a0f19df265f = "aether_storm_exfil_called_acknowledged";
  }

  setomnvar("ui_dmz_radiation_spreading", 1);
  set_timer_time(level.aether_storm.var_647bf2cbf73994dd);
  function_1e80b64e11b75717(9);
}

function function_dd834b585f86b332(params) {
  if(isDefined(level.aether_storm.update_waiting)) {
    return;
  }

  level.aether_storm.update_waiting = 1;
  wait 0.5;
  level.aether_storm.update_waiting = undefined;
  profilebeginevent(#"hash_5657a7ea701d8256");

  if(isDefined(level.var_5b7c4eafd38d35c) && isDefined(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38)) {
    i = 0;

    while(i < level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38.size) {
      activity_starter = level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38[i];

      if(isDefined(activity_starter) && radiation::function_1b4f63fa623de69a(activity_starter.origin)) {
        level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38[i] namespace_848c7a35c6f1e038::function_9c2b62cf9d5bcdeb();
      }

      i += 1;
    }

    level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38 = utility::array_removeundefined(level.var_5b7c4eafd38d35c.var_915f0d3c3a61e38);
  }

  if(!istrue(level.aether_storm.var_194513d38c471d7a) && !level.aether_storm.var_719deb8a1a45bb85) {
    var_edb92fd48d975084 = exfil::function_c51a46f4a60b13d5();
    var_def119cc47a8fb6f = 0;

    foreach(exfil in var_edb92fd48d975084) {
      if(exfil == level.aether_storm.final_exfil) {
        continue;
      }

      if(radiation::function_1b4f63fa623de69a(exfil.origin)) {
        exfil.var_589c572c53eeeeb6 = 1;

        if(!istrue(exfil.b_disabled)) {
          exfil::function_4b5e408a00f4ddd8(exfil);
        }

        continue;
      }

      if(!istrue(exfil.b_disabled)) {
        var_def119cc47a8fb6f += 1;
      }
    }

    if(var_def119cc47a8fb6f == 0) {
      thread function_4b40a61f53dd9122();
    }
  }

  profileendevent();
}

function function_8f95016c770a1f8c(params) {
  if(level.aether_storm.var_719deb8a1a45bb85) {
    wait 5;
  }

  if(!istrue(level.aether_storm.var_194513d38c471d7a)) {
    wait 60;

    if(istrue(level.aether_storm.var_194513d38c471d7a)) {
      return;
    }

    assertmsg("<dev string:x226>");
  } else {
    level.aether_storm.final_exfil endon("exfil_complete_timeout");
    wait 180;
    assertmsg("<dev string:x2a8>");
  }

  function_d52bfc09d86c8636();
}

function private function_698d99f6cc939e34(heli) {
  if(expansion_started()) {
    var_af1e35abee93b10d = getscriptbundle(%"hash_d03ed75a2d0089");

    if(!isDefined(var_af1e35abee93b10d)) {
      assertmsg("<dev string:x32d>" + getxhashsourcename(%"hash_d03ed75a2d0089") + "<dev string:x379>");
      return;
    }

    var_bf80f581fdce86d2 = heli.angles + (0, 90, 0);
    var_840c2ee92c8f78fe = [(33, 40, -198), (-15, 40, -198), (-58, 40, -198), (-105, 40, -198)];

    foreach(offset in var_840c2ee92c8f78fe) {
      var_9d5552b198734eb8 = heli.origin + rotatevector(offset, heli.angles);
      gasmask = common_item::function_c465d27f3f6066b4(var_af1e35abee93b10d, var_9d5552b198734eb8, var_bf80f581fdce86d2, 1, 1);
      thread function_6203604aa47a23a3(heli, gasmask);
    }
  }
}

function private function_6203604aa47a23a3(heli, gasmask) {
  gasmask endon("death");
  heli waittill("exfil_vehicle_gone");
  common_item::function_c14962ea14e58968(gasmask);
}

function function_7bf6e6f83216f4bd() {
  if(level.var_2562ea48235e90b5.size == 0) {
    assertmsg("<dev string:x396>");
    return;
  }

  level.aether_storm.final_exfil = sortbydistance(level.var_2562ea48235e90b5, level.aether_storm.starting_origin)[level.var_2562ea48235e90b5.size - 1];

  if(!isDefined(level.aether_storm.final_exfil)) {
    assertmsg("<dev string:x3f0>");
    level.aether_storm.final_exfil = {
      #origin: (50000, 50000, 0)
    };
  }

  activity_common::function_86f446036c3c25a3("exfil_final_activity_ob_definition", "FINAL_EXFIL_OB");
  level.aether_storm.final_exfil.var_8d00284a103c5803 = "FINAL_EXFIL_OB";
  radius_delta = distance2d(level.aether_storm.final_exfil.origin, level.aether_storm.starting_origin) - level.aether_storm.starting_radius;
  level.aether_storm.var_3f24322be8ae1969 = level.aether_storm.expansion_radius / radius_delta / level.aether_storm.var_647bf2cbf73994dd;
  return level.aether_storm.final_exfil;
}

function function_4b40a61f53dd9122() {
  if(!isDefined(level.aether_storm.final_exfil)) {
    assertmsg("<dev string:x45c>");
    delay = (level.aether_storm.var_3d51670b31c0dbc0 - gettime()) / 1000;

    if(delay > 0) {
      wait delay;
    }

    function_d52bfc09d86c8636();
    return;
  }

  if(istrue(level.aether_storm.var_194513d38c471d7a)) {
    return;
  }

  level.aether_storm.var_194513d38c471d7a = 1;
  level.aether_storm.final_exfil.var_d182b8d3f3aaa93b = spawnscriptable("cp_mp_exfil_site_entityless", level.aether_storm.final_exfil.origin, level.aether_storm.final_exfil.angles);
  level.aether_storm.final_exfil.var_d182b8d3f3aaa93b setscriptablepartstate("cp_mp_exfil_site", "standby");
  level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id = objidpoolmanager::requestobjectiveid(1);
  objidpoolmanager::objective_add_objective(level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id, "invisible", level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.origin, "ui_map_icon_cp_mp_exfil", "icon_regular");
  objective_state(level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id, "current");
  objective_setlabel(level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id, &"JUP_OB/FINAL_EXFIL");
  objective_setplayintro(level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id, 1);

  foreach(player in level.players) {
    if(isDefined(player) && !player function_aa1f91da154a3d90()) {
      objective_addclienttomask(level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id, player);
    }
  }

  objective_showtoplayersinmask(level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id);
  thread overlord::playevent("aether_storm_final_exfil_revealed", level.players, 0, 1);
  var_49a313cc785a2410 = (level.aether_storm.var_3d51670b31c0dbc0 - gettime()) / 1000;
  var_49a313cc785a2410 -= level.aether_storm.var_be0e041e85848a6d;
  var_49a313cc785a2410 -= getdvarint(@ "hash_eb873c5e99093d11", 50);
  var_49a313cc785a2410 -= getdvarint(@ "hash_346baccb7a031727", 7);

  if(var_49a313cc785a2410 > 0) {
    level.aether_storm.var_e42fed415ee7a4eb = 1;

    level utility::waittill_notify_or_timeout("aether_storm_force_start_final_exfil", var_49a313cc785a2410);

    level.aether_storm.var_e42fed415ee7a4eb = 0;
  }

  level.aether_storm.final_exfil.b_disabled = undefined;
  level.aether_storm.final_exfil.var_1265336893f89f10 = 1;
  level.aether_storm.final_exfil.var_81fff6332116316f = level.aether_storm.var_be0e041e85848a6d;
  level.aether_storm.final_exfil.var_74144fabf9631d37 = min(80, level.aether_storm.var_be0e041e85848a6d);
  level.aether_storm.final_exfil.var_9dae2c1a677985a8 = 1;
  level.aether_storm.final_exfil.var_1c13f1737dccef9a = 1;
  level.aether_storm.final_exfil.var_bab7d5b1eb545062 = 1;
  level.aether_storm.final_exfil.var_bff042c325c612a0 = 1;
  level.aether_storm.final_exfil.var_4cdfc3869e61bd9b = "dmzwhite";
  level.aether_storm.final_exfil.var_64f10a0f19df265f = "aether_storm_exfil_called_acknowledged";
  level.aether_storm.final_exfil.var_ba71f0b6b1b651f5 = "aether_storm_final_exfil_leaving";
  level.aether_storm.final_exfil.var_651b83653ae1f156 = &function_2deaea362f60497a;
  exfil::function_1590a66b9f6c2c3b(level.aether_storm.final_exfil, level.aether_storm.var_be0e041e85848a6d);
  activity_common::function_8b5b2a3392fc7e2a("PlayerLeave", &function_52be02397ea5f937, "REV_OB_EXFIL");
  activity_common::function_8b5b2a3392fc7e2a("ActivityEnd", &function_52be02397ea5f937, "REV_OB_EXFIL");

  foreach(player in level.players) {
    player thread hud_message::showsplash("aether_storm_final_exfil_inbound", undefined, undefined, undefined, 1, "splash_list_jup_ob");
  }

  while(true) {
    level waittill("exfil_time_remaining", time_remaining, exfil);

    if(exfil != level.aether_storm.final_exfil) {
      continue;
    }

    if(time_remaining <= 60) {
      thread overlord::playevent("aether_storm_final_exfil_warning", level.players, 0, 1);
      break;
    }
  }

  if(!level.aether_storm.final_exfil ent_flag("exfil_complete_timeout")) {
    level.aether_storm.final_exfil utility::waittill_any_2("exfil_complete_timeout", "exfil_players_dead");
  }

  objidpoolmanager::returnobjectiveid(level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id);
  level.aether_storm.final_exfil.var_d182b8d3f3aaa93b.n_obj_id = undefined;
  level.aether_storm.final_exfil utility::waittill_notify_or_timeout("exfil_vehicle_gone", getdvarfloat(@ "hash_98a99c8faf0974fd", 20));
  var_a9f9fc95bb88af53 = 1;

  foreach(player in level.players) {
    if(!isDefined(player) || player.sessionstate != "playing") {
      continue;
    }

    if(!istrue(player.var_f52eb40ba99ffa4c) && !istrue(player.var_68b9486f4adbcb62)) {
      var_a9f9fc95bb88af53 = 0;
      break;
    }
  }

  thread overlord::playconversation(var_a9f9fc95bb88af53 ? "aether_storm_final_exfil_success" : "aether_storm_final_exfil_missing", level.players);
  wait 5;
  thread function_d52bfc09d86c8636();
}

function function_2deaea362f60497a(s_exfil) {
  var_35ef5a1b78538d84 = max(0, (level.aether_storm.var_3d51670b31c0dbc0 - gettime()) / 1000);
  level.aether_storm.final_exfil.var_74144fabf9631d37 = min(80, var_35ef5a1b78538d84);
  return var_35ef5a1b78538d84;
}

function function_52be02397ea5f937(info_struct) {
  waitframe();

  foreach(player in info_struct.playerlist) {
    if(isalive(player) && player.sessionstate == "playing" && !istrue(player.var_f52eb40ba99ffa4c)) {
      player exfil::function_f4f52d20f1fb7650(level.aether_storm.final_exfil);
    }
  }
}

function function_d52bfc09d86c8636(params) {
  foreach(player in level.players) {
    if(isDefined(player) && !istrue(player.var_f52eb40ba99ffa4c)) {
      player thread ob::function_922c3629c545df86();

      if(isalive(player) && player.sessionstate == "playing") {
        player kill();
      }
    }
  }

  if(!istrue(level.gameended)) {
    wait getdvarint(@ "hash_28f9cb938ede4706", 60);
    level notify("game_ended_aether_storm");
    level thread gamelogic::endgame("none", game["end_reason"]["time_limit_reached"], game["end_reason"]["time_limit_reached"]);
  }
}

function function_1e80b64e11b75717(state) {
  setomnvar("ui_br_circle_state", state);
}

function set_timer_time(seconds) {
  level.aether_storm.var_3d51670b31c0dbc0 = gettime() + int(seconds * 1000);
  setomnvar("ui_hardpoint_timer", level.aether_storm.var_3d51670b31c0dbc0);
}

function private function_d8626a2206442680() {
  if(level.aether_storm.timer_disabled) {
    return;
  }

  flags::gameflagwait("prematch_done");
  level.aether_storm.prematch_done_time = gettime();

  childthread function_82d15002698f32a8();

  if(level.aether_storm.var_2115c7dedd7891f6 > 0) {
    wait level.aether_storm.var_2115c7dedd7891f6;
  }

  if(!expansion_started()) {
    function_1e80b64e11b75717(5);
  }
}

function private function_82d15002698f32a8() {
  level endon("<dev string:x4e0>");

  while(true) {
    level waittill("<dev string:x4fb>");

    if(expansion_started()) {
      break;
    }

    if(gettime() >= level.aether_storm.prematch_done_time + level.aether_storm.var_2115c7dedd7891f6) {
      function_1e80b64e11b75717(9);
      break;
    }
  }
}

function private function_abc28a284657371f() {
  level endon("game_ended");
  flags::gameflagwait("prematch_done");
  wait_time = game_utility::gettimelimit() - float(gettime()) / 1000 - 600;

  if(wait_time > 0) {
    utility::waittill_notify_or_timeout("aether_storm_expansion_started", wait_time);
  }

  if(!istrue(utility::flag("aether_storm_expansion_started"))) {
    switch (level.aether_storm.announcement_handler) {
      case 0:
        thread overlord::playconversation("aether_storm_expansion_warning_barrera", level.players);
        break;
      case 1:
        thread overlord::playconversation("aether_storm_expansion_warning_dobbs", level.players);
        break;
      case 2:
        thread overlord::playconversation("aether_storm_expansion_warning_kapoor", level.players);
        break;
      case 3:
        thread overlord::playconversation("aether_storm_expansion_warning_miller", level.players);
        break;
    }
  }

  level utility::flag_wait("aether_storm_expansion_started");

  foreach(player in level.players) {
    player thread hud_message::showsplash("aether_storm_expansion_started", undefined, undefined, undefined, 1, "splash_list_jup_ob");
  }

  switch (level.aether_storm.announcement_handler) {
    case 0:
      thread overlord::playconversation("aether_storm_expansion_started_barrera", level.players);
      break;
    case 1:
      thread overlord::playconversation("aether_storm_expansion_started_dobbs", level.players);
      break;
    case 2:
      thread overlord::playconversation("aether_storm_expansion_started_kapoor", level.players);
      break;
    case 3:
      thread overlord::playconversation("aether_storm_expansion_started_miller", level.players);
      break;
  }

  wait 600;

  switch (level.aether_storm.announcement_handler) {
    case 0:
      thread overlord::playevent("aether_storm_intensity_increasing_barrera", level.players);
      break;
    case 1:
      thread overlord::playevent("aether_storm_intensity_increasing_dobbs", level.players);
      break;
    case 2:
      thread overlord::playevent("aether_storm_intensity_increasing_kapoor", level.players);
      break;
    case 3:
      thread overlord::playevent("aether_storm_intensity_increasing_miller", level.players);
      break;
  }
}

function private function_9a4d5d4bcc9e2c58() {
  level endon("game_ended");
  flags::gameflagwait("prematch_done");
  level utility::flag_wait("aether_storm_expansion_started");
  wait 600;

  foreach(player in level.players) {
    if(!istrue(player.defeated) && !istrue(player.var_f52eb40ba99ffa4c) && !istrue(player.var_488872571019cd6c)) {
      player ob_music::function_2431d3e1b4e70519();
      player setplayermusicstate("mx_jup_ob_storm_1");
    }
  }

  wait 150;

  foreach(player in level.players) {
    if(!istrue(player.defeated) && !istrue(player.var_f52eb40ba99ffa4c) && !istrue(player.var_488872571019cd6c)) {
      player ob_music::function_2431d3e1b4e70519();
      player setplayermusicstate("mx_jup_ob_storm_2");
    }
  }
}

function function_a143c9a0fa3af9f6() {
  if(!level.aether_storm.var_ab66a0c49f0e8d6e) {
    return;
  }

  utility::flag_wait("ai_spawn_director_initialized");
  requestid = ai_spawn_director::spawn_request(%"hash_35507329b13b885d", level.aether_storm.starting_origin, level.aether_storm.starting_radius, 1, 1, 1);
  function_d37068aac7785c04(requestid, level.aether_storm.difficulty, 1);
  ai_spawn_director::function_73147cdf5c28d10c(requestid, &function_8adcb7c5489211ae);
}

function private function_8adcb7c5489211ae(requestid, instance, agent, ai_data) {
  if(expansion_started()) {
    if(getdvarint(@ "hash_729c0e8d0666b374", 1)) {
      function_18790a3cb3f88db7(requestid);
    }

    return true;
  }

  return false;
}

function function_e427c341b9abc409() {
  if(!level.aether_storm.var_8b570b76600ddee9) {
    return;
  }

  utility::flag_wait("ai_spawn_director_initialized");
  spawnpoint = getclosestpointonnavmesh(level.aether_storm.starting_origin);
  var_957d0419ff6605b9 = namespace_2b1145f62aa835b8::get_aitype_by_subclass_sharedfunc("zombie_disciple_hvt_stormcaller");
  base_aitype = undefined;

  foreach(aitype in var_957d0419ff6605b9) {
    strlen = aitype.size;

    if(!isDefined(base_aitype) || base_aitype.size > strlen) {
      base_aitype = aitype;
    }
  }

  while(!isDefined(level.aether_storm.stormcaller)) {
    wait 1;
    level.aether_storm.stormcaller = namespace_2b1145f62aa835b8::spawnnewaitype_sharedfunc(base_aitype, spawnpoint, (0, 0, 0), "team_two_hundred");
  }

  level.aether_storm.var_9be93da34100a104 = [];
  level.aether_storm.stormcaller._blackboard.zombiewanderorigin = spawnpoint;
  difficulty = getDvar(@ "hash_a80863b2558da960", level.aether_storm.difficulty);
  level.aether_storm.stormcaller namespace_f721fc7d0d2d0f47::function_4a4fab5fd0b06d7b(difficulty);
  level.aether_storm.stormcaller callback::add("on_zombie_ai_damaged", &function_ff996236e6d7763e);
  level.aether_storm.stormcaller callback::add("on_zombie_ai_killed", &function_1852c6ed3ffb360e);
  thread function_94ed84e06d08efd3();
  level utility::flag_set("aether_storm_stormcaller_spawned");
  level.aether_storm.var_126361603ff7a9b7 = ai_spawn_director::spawn_request(%"hash_142f7ced2439e733", level.aether_storm.starting_origin, level.aether_storm.starting_radius, 1, 1);
  function_d37068aac7785c04(level.aether_storm.var_126361603ff7a9b7, level.aether_storm.difficulty, 1);
  ai_spawn_director::function_e4a67fe4ddca7ed5(level.aether_storm.var_126361603ff7a9b7, &function_9b971ebaff7c3eaa);
}

function private function_9b971ebaff7c3eaa(requestid, instance, agent, ai_data) {
  waitframe();
  level utility::flag_wait("aether_storm_stormcaller_spawned");
  agent namespace_f721fc7d0d2d0f47::function_4a4fab5fd0b06d7b(level.aether_storm.difficulty);

  if(!agent utility::ent_flag("disciple_bound")) {
    level.aether_storm.stormcaller namespace_4d4755f6eec0fa1b::function_1fca749b9ae92b76(agent);
  }
}

function private function_ff996236e6d7763e(params) {
  if(isPlayer(params.eattacker) && isDefined(params.idamage) && params.idamage >= level.aether_storm.var_a75317daa0bd7ff9) {
    level.aether_storm.var_9be93da34100a104[params.eattacker getentitynumber()] = params.eattacker;
  }
}

function private function_1852c6ed3ffb360e(params) {
  if(!isDefined(params.smeansofdeath) || params.smeansofdeath == "MOD_SUICIDE" || params.smeansofdeath == "MOD_TRIGGER_HURT") {
    spawnpoint = getclosestpointonnavmesh(level.aether_storm.starting_origin);
    var_957d0419ff6605b9 = namespace_2b1145f62aa835b8::get_aitype_by_subclass_sharedfunc("zombie_disciple_hvt_stormcaller");
    level.aether_storm.stormcaller = namespace_2b1145f62aa835b8::spawnnewaitype_sharedfunc(var_957d0419ff6605b9[0], spawnpoint, (0, 0, 0), "team_two_hundred");
    level.aether_storm.stormcaller._blackboard.zombiewanderorigin = spawnpoint;
    level.aether_storm.stormcaller namespace_f721fc7d0d2d0f47::function_4a4fab5fd0b06d7b(getDvar(@ "hash_a80863b2558da960", level.aether_storm.difficulty));
    level.aether_storm.stormcaller callback::add("on_zombie_ai_damaged", &function_ff996236e6d7763e);
    level.aether_storm.stormcaller callback::add("on_zombie_ai_killed", &function_1852c6ed3ffb360e);
    return;
  }

  ai_spawn_director::function_9950e6e485bf5261(level.aether_storm.var_126361603ff7a9b7);

  foreach(player in level.aether_storm.var_9be93da34100a104) {
    player thread hud_message::showsplash("aether_storm_stormcaller_eliminated", undefined, undefined, undefined, 1, "splash_list_jup_ob");
  }

  level.aether_storm.var_126361603ff7a9b7 = undefined;
  level.aether_storm.var_9be93da34100a104 = undefined;
  level.aether_storm.stormcaller = undefined;
}

function private function_94ed84e06d08efd3() {
  level endon("aether_storm_expansion_started");

  while(isDefined(level.aether_storm.stormcaller)) {
    if(distance2dsquared(level.aether_storm.stormcaller.origin, level.aether_storm.radiation.origin) > level.aether_storm.radiation.radiussq * 1.5) {
      wait 30;

      if(isDefined(level.aether_storm.stormcaller) && distance2dsquared(level.aether_storm.stormcaller.origin, level.aether_storm.radiation.origin) > level.aether_storm.radiation.radiussq * 1.5) {
        restore_health = level.aether_storm.stormcaller.health;
        level.aether_storm.stormcaller.var_7e4b076a06c6df27 = 1;
        level.aether_storm.stormcaller kill(level.aether_storm.stormcaller.origin, level.aether_storm.stormcaller, level.aether_storm.stormcaller, "MOD_SUICIDE");
        waitframe();
        level.aether_storm.stormcaller.health = restore_health;
      }
    }

    wait 5;
  }
}

function private function_fad17bd00c6aaaa2(params) {
  while(true) {
    if(!isDefined(level.aether_storm.stormcaller)) {
      return;
    }

    var_5414206430871118 = level.aether_storm.stormcaller.origin;
    between_vector = (level.aether_storm.radiation.origin[0], level.aether_storm.radiation.origin[1], 0) - (var_5414206430871118[0], var_5414206430871118[1], 0);
    distance_between = length(between_vector);
    var_b5c57e3f326eb194 = distance_between + level.aether_storm.starting_radius - level.aether_storm.radiation.radius;

    if(var_b5c57e3f326eb194 > 0) {
      push_direction = between_vector / distance_between;
      var_5414206430871118 = getclosestpointonnavmesh(var_5414206430871118 + var_b5c57e3f326eb194 * push_direction);
    }

    level.aether_storm.stormcaller._blackboard.zombiewanderorigin = var_5414206430871118;
    wait 5;
  }
}

function private function_db25872d3eb4f360() {
  level endon("game_ended");
  level.aether_storm.radiation endon("radiation_destroyed");
  updated_counter = 0;
  var_b31e57d1a1fc8871 = [];
  var_da6f20045ba9ee8 = undefined;
  var_3277e397d70bf9e5 = undefined;
  var_6fd91f67f0ed50e9 = undefined;

  while(level.aether_storm.radiation.active) {
    var_b31e57d1a1fc8871 = getaiarrayinradius(level.aether_storm.radiation.origin, level.aether_storm.radiation.radius * 1.25, "all");

    foreach(agent in var_b31e57d1a1fc8871) {
      if(!isalive(agent) || istrue(agent.var_102a9d2cf99ab325)) {
        updated_counter += 0.1;
        continue;
      }

      if(isDefined(agent.agent_type) && (issubstr(agent.agent_type, "warlord") || issubstr(agent.agent_type, "bodyguard"))) {
        updated_counter += 0.1;
        continue;
      }

      if(isDefined(agent.var_66c1831357048c02)) {
        updated_counter += 0.1;
        continue;
      }

      var_6fd91f67f0ed50e9 = level.aether_storm.radiation radiation::function_1b4f63fa623de69a(agent.origin);

      if(agent.type == "zombie") {
        if(isDefined(level.aether_storm.stormcaller) && agent == level.aether_storm.stormcaller || !isDefined(agent.zombieaisettings)) {
          updated_counter += 0.1;
          continue;
        } else if(var_6fd91f67f0ed50e9) {
          if(!istrue(agent.var_52e05f199428179)) {
            agent.var_52e05f199428179 = 1;
            region_difficulty = namespace_f721fc7d0d2d0f47::function_4d8bb2d866771a10(agent.origin);

            if(agent.difficulty == region_difficulty) {
              switch (region_difficulty) {
                case #"hash_7bb2cd766703d463":
                  agent namespace_f721fc7d0d2d0f47::function_4a4fab5fd0b06d7b("difficulty_normal");
                  break;
                case #"hash_af83e47edfa8900a":
                  agent namespace_f721fc7d0d2d0f47::function_4a4fab5fd0b06d7b("difficulty_hard");
                  break;
                case #"hash_5343b465e56ec9a4":
                  agent.difficulty_round = namespace_f721fc7d0d2d0f47::function_300a6f8c556edf34("difficulty_darkaether");

                  if(isDefined(agent.zombieaisettings.healthscriptbundle)) {
                    agent.maxhealth = namespace_22b8ba12655bf3f2::get_starting_health(agent.zombieaisettings.healthscriptbundle, agent.difficulty_round);
                  }

                  namespace_f721fc7d0d2d0f47::function_4fd50faaf7767e65(agent, "difficulty_darkaether", agent.difficulty_round);
                  break;
              }

              agent ai::function_dd21d67ede8ba22(int(agent.maxhealth * level.aether_storm.var_ad737473be1f0d04));
              agent.health = agent.maxhealth;
            }

            if(issubstr(agent.subclass, "zombie_base") && !agent utility::ent_flag("disciple_bound")) {
              agent utility::function_3ab9164ef76940fd("bound", "bound_on");
            }
          }
        } else if(istrue(agent.var_52e05f199428179)) {
          agent.var_52e05f199428179 = 0;
          old_health = agent.health;
          agent namespace_f721fc7d0d2d0f47::function_4a4fab5fd0b06d7b(namespace_f721fc7d0d2d0f47::function_4d8bb2d866771a10(agent.origin));

          if(isDefined(agent.max_health) && old_health < agent.max_health) {
            agent.health = old_health;
          }

          if(issubstr(agent.subclass, "zombie_base") && !agent utility::ent_flag("disciple_bound")) {
            agent utility::function_3ab9164ef76940fd("bound", "bound_off");
          }
        }
      } else {
        if(var_6fd91f67f0ed50e9 && !istrue(agent.var_a32530404b862f7b)) {
          if(!isDefined(agent.var_fe0cb6be740c6685) || gettime() - agent.var_fe0cb6be740c6685 >= level.aether_storm.var_31068981fd9277c6) {
            damage = (isDefined(agent.maxhealth) ? agent.maxhealth : 100) * level.aether_storm.var_9a2fdb386cc15ae0;
            agent dodamage(damage, agent.origin, undefined, undefined, "MOD_TRIGGER_HURT", level.radiation.damageweapon, "torso_upper");
            agent.var_fe0cb6be740c6685 = gettime();
          }
        }

        if(isalive(agent) && !istrue(agent.var_b43f6cad28078a05)) {
          var_da6f20045ba9ee8 = agent.origin + 2000 * vectorNormalize(agent.origin - level.aether_storm.radiation.origin);
          var_3277e397d70bf9e5 = getclosestpointonnavmesh(var_da6f20045ba9ee8);

          if(lengthsquared(var_da6f20045ba9ee8 - var_3277e397d70bf9e5) < 1000000) {
            thread ai_behavior::function_a5117518725da028(agent, var_da6f20045ba9ee8);
          }
        }
      }

      updated_counter += 1;

      if(updated_counter > 5) {
        updated_counter = 0;
        waitframe();
      }
    }

    updated_counter = 0;
    wait 1;
  }
}

function private function_ebf8ee98cf7a3be0() {
  level endon("game_ended");
  level.aether_storm.radiation endon("radiation_destroyed");

  level endon("<dev string:x50f>");

  if(!level.aether_storm.var_94ea725a035aef57) {
    return;
  }

  level.aether_storm.var_bcf79bebe2066931 = spawnscriptable(%"hash_67315e48e910687f", level.aether_storm.starting_origin);
  scriptable::scriptable_addnotifycallback("aether_storm_lightning_strike_damage", &_lightning_strike_damage);
  scriptable::scriptable_addnotifycallback("aether_storm_lightning_strike_finished", &_lightning_strike_finished);
  level.aether_storm.var_d5422504409025bf = objective_marker_bundle_helper::createobjectivemarkerfrombundlexhash(%"hash_528cbe8d883829a4");
  objidpoolmanager::function_f21e9b2e78de984b(level.aether_storm.var_d5422504409025bf, level.aether_storm.var_43db6b44cd164b89, level.aether_storm.var_a60ecdae78f1434);
  objective_disableping(level.aether_storm.var_d5422504409025bf, 1);
  objective_setpings(level.aether_storm.var_d5422504409025bf, 0);
  function_a16750cd44f57931(level.aether_storm.var_d5422504409025bf, 0);
  function_1a20f52de11ba2ef(level.aether_storm.var_d5422504409025bf, 1);
  players_inside = [];
  cluster_origin = (0, 0, 0);

  while(true) {
    if(randomintrange(0, 100) < level.aether_storm.var_ade6a22953100a52) {
      players_inside = namespace_2b1145f62aa835b8::getplayersinradiussharedfunc(level.aether_storm.radiation.origin, level.aether_storm.radiation.radius);

      if(players_inside.size) {
        random_player = players_inside[randomintrange(0, players_inside.size)];
        cluster_origin = random_player.origin;
        var_3d6b4222f967d915 = vectornormalize2(cluster_origin - level.aether_storm.radiation.origin);
        var_1970a7d6465931da = level.aether_storm.radiation.origin + var_3d6b4222f967d915 * level.aether_storm.radiation.radius;
        var_98ccf2925acd2d29 = distance2d(cluster_origin, var_1970a7d6465931da);

        if(var_98ccf2925acd2d29 < level.aether_storm.var_6da5e5e442abcb81) {
          cluster_origin = var_1970a7d6465931da + var_3d6b4222f967d915 * -1 * (level.aether_storm.var_6da5e5e442abcb81 - var_98ccf2925acd2d29);
        }
      } else {
        var_1b0771204b2e73e4 = randomfloat(360);
        var_a16770fce4e9602d = randomfloat(level.aether_storm.radiation.radius);
        cluster_origin = (level.aether_storm.radiation.origin[0] + cos(var_1b0771204b2e73e4) * var_a16770fce4e9602d, level.aether_storm.radiation.origin[1] + sin(var_1b0771204b2e73e4) * var_a16770fce4e9602d, level.aether_storm.radiation.origin[2]);
      }

      function_ea13f5b63d920d2f(cluster_origin);
      wait level.aether_storm.var_a89d2433198e329e;
      continue;
    }

    wait 1;
  }
}

function function_ea13f5b63d920d2f(cluster_origin) {
  var_fa5600de20617e5a = undefined;
  var_8e155dfa53d66acb = undefined;
  strike_origin = undefined;

  level.aether_storm.var_6dbf82211b027b64 = cluster_origin;

  strike_count = 0;

  while(strike_count < level.aether_storm.var_284270df3a99404) {
    var_fa5600de20617e5a = randomfloat(360);
    var_8e155dfa53d66acb = randomfloat(level.aether_storm.var_6da5e5e442abcb81);
    strike_origin = (cluster_origin[0] + cos(var_fa5600de20617e5a) * var_8e155dfa53d66acb, cluster_origin[1] + sin(var_fa5600de20617e5a) * var_8e155dfa53d66acb, cluster_origin[2]);
    strike_origin = getgroundposition(strike_origin, 1, 2048, 1024);
    objidpoolmanager::update_objective_position(level.aether_storm.var_d5422504409025bf, strike_origin);
    objidpoolmanager::update_objective_state(level.aether_storm.var_d5422504409025bf, "current");
    objidpoolmanager::objective_playermask_showtoall(level.aether_storm.var_d5422504409025bf);
    level.aether_storm.var_bcf79bebe2066931.origin = strike_origin;
    level.aether_storm.var_bcf79bebe2066931 setscriptablepartstate(#"strike", #"on");
    level.aether_storm.var_bcf79bebe2066931 waittill("aether_storm_lightning_strike_finished");
    objidpoolmanager::objective_playermask_hidefromall(level.aether_storm.var_d5422504409025bf);
    objidpoolmanager::update_objective_state(level.aether_storm.var_d5422504409025bf, "empty");
    strike_count += 1;
  }

  level.aether_storm.var_6dbf82211b027b64 = undefined;
}

function private _lightning_strike_damage(instance, note, param, instigator) {
  profilebeginevent(#"hash_a37010fcd4308e33");
  radiusdamage(instance.origin, level.aether_storm.var_4f4ea0d0cc4b762e, level.aether_storm.var_913f0729da2f7bf7, level.aether_storm.var_913f0729da2f7bf7, undefined, undefined, undefined, 1, 1);
  players = namespace_2b1145f62aa835b8::getplayersinradiussharedfunc(instance.origin, level.aether_storm.var_4f4ea0d0cc4b762e);

  foreach(player in players) {
    thread function_1ccf067179383388(player, level.aether_storm.var_100cbabc49ba5983, level.aether_storm.var_913f0729da2f7bf7);
  }

  zombies = getaiarrayinradius(instance.origin, level.aether_storm.var_4f4ea0d0cc4b762e, "team_two_hundred");

  foreach(zombie in zombies) {
    thread function_1e93e4747cd83387(zombie, level.aether_storm.var_100cbabc49ba5983, level.aether_storm.var_913f0729da2f7bf7);
  }

  soldiers = getaiarrayinradius(instance.origin, level.aether_storm.var_4f4ea0d0cc4b762e, "team_hundred_ninety");

  foreach(soldier in soldiers) {
    if(!istrue(soldier.var_a32530404b862f7b)) {
      thread function_88888e5d4a0feebd(soldier, level.aether_storm.var_100cbabc49ba5983, level.aether_storm.var_913f0729da2f7bf7);
    }
  }

  profileendevent();
}

function private _lightning_strike_finished(instance, note, param, instigator) {
  instance notify("aether_storm_lightning_strike_finished");
}

function function_1ccf067179383388(victim, shock_duration, damage) {
  victim shock_stick::function_a9a57668997e3c85(1);

  if(istrue(victim.revivingteammate)) {
    victim.var_4a2f2f50a9020e2e = 1;
  }

  victim utility::function_3ab9164ef76940fd("shockStickVfx", "vfx_start");
  victim dodamage(damage, victim.origin, victim, undefined, "MOD_TRIGGER_HURT", "danger_circle_br", "none", undefined, 65536);

  if(isPlayer(victim)) {
    gestureref = "vm_ges_shockstick_react";
    curweapon = victim getcurrentweapon();

    if(curweapon.basename == "iw9_me_fists_mp") {
      gestureref = "vm_ges_shockstick_react_fists";
    }

    attempts = 0;

    while(!victim isgestureplaying(gestureref) && attempts < 5) {
      victim forceplaygestureviewmodel(gestureref);
      attempts += 1;
      waitframe();
    }
  }

  victim startforcedfire();
  victim shock_stick::function_600c7c4c73c6a773(1);
  victim setmovespeedscale(0.8);
  victim setempjammed(1);
  wait shock_duration;
  victim shock_stick::function_a9a57668997e3c85(0);
  victim stopgestureviewmodel(gestureref);
  victim stopforcedfire();
  victim utility::function_3ab9164ef76940fd("shockStickVfx", "off");
  victim shock_stick::function_600c7c4c73c6a773(0);
  victim setmovespeedscale(1);
  victim setempjammed(0);
}

function function_1e93e4747cd83387(victim, shock_duration, damage) {
  victim zombie_stun::stun_ai(shock_duration);
  victim utility::function_3ab9164ef76940fd("shockStickVfx", "vfx_start");
  victim dodamage(damage, victim.origin, victim, undefined, "MOD_TRIGGER_HURT", "danger_circle_br", "none", undefined, 65536);
  wait shock_duration;

  if(isalive(victim)) {
    victim utility::function_3ab9164ef76940fd("shockStickVfx", "off");
  }
}

function function_88888e5d4a0feebd(victim, shock_duration, damage) {
  firstshock = gettime() > victim._blackboard.var_dc51d4ea36da3ae1 + 1;
  victim._blackboard.var_dc51d4ea36da3ae1 = gettime();

  if(victim asmhaspainstate(victim.asmname) && firstshock) {
    victim asmevalpaintransition(victim.asmname);
  }

  victim utility::function_3ab9164ef76940fd("shockStickVfx", "vfx_start");
  victim dodamage(damage, victim.origin, victim, undefined, "MOD_TRIGGER_HURT", "danger_circle_br", "none", undefined, 65536);
  wait shock_duration;

  if(isalive(victim)) {
    victim utility::function_3ab9164ef76940fd("shockStickVfx", "off");
  }
}

function function_f4df458e2841cbf1(params) {
  player = params.player;

  if(isDefined(player)) {
    player utility::function_3ab9164ef76940fd("aether_storm_sfx", "activate");
  }
}

function function_38b3b1600f7440b1(params) {
  player = params.player;

  if(isDefined(player)) {
    player utility::function_3ab9164ef76940fd("aether_storm_sfx", "off");
  }
}

function function_d0f8b9fdea272469(sparams) {
  if(isDefined(self)) {
    utility::function_3ab9164ef76940fd("aether_storm_sfx", "off");
  }
}

function private _debug_init() {
  level endon("<dev string:x53f>");
  devgui::function_6e7290c8ee4f558b("<dev string:x54d>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x561>", "<dev string:x58c>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x5dc>", "<dev string:x607>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x657>", "<dev string:x680>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x6ce>", "<dev string:x6f8>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x747>", "<dev string:x771>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x7c0>", "<dev string:x7eb>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x83b>", "<dev string:x866>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x8b6>", "<dev string:x8df>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x92d>", "<dev string:x957>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:x9a6>", "<dev string:x9d0>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xa1f>", "<dev string:xa4d>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xaa0>", "<dev string:xace>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xb21>", "<dev string:xb4d>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xb9e>", "<dev string:xbcb>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xc1d>", "<dev string:xc4a>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xc9c>", "<dev string:xcc0>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xd10>", "<dev string:xd36>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xd81>", "<dev string:xda6>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xdf0>", "<dev string:xe15>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xe5f>", "<dev string:xe84>", &debug_announcement);
  devgui::function_b23a59dfb4ca49a1("<dev string:xece>", "<dev string:xef3>", &debug_announcement);
  devgui::function_b2159fbbd7ac094e("<dev string:xf3c>", @ "hash_c970fe9ef25b9a04");
  devgui::function_b23a59dfb4ca49a1("<dev string:xf4f>", "<dev string:xf60>", &function_108d531ae15fcc87);
  devgui::function_b23a59dfb4ca49a1("<dev string:xf8f>", "<dev string:xfa0>", &function_108d531ae15fcc87);
  devgui::function_b23a59dfb4ca49a1("<dev string:xfcf>", "<dev string:xfe0>", &function_108d531ae15fcc87);
  devgui::function_b23a59dfb4ca49a1("<dev string:x100f>", "<dev string:x1020>", &function_108d531ae15fcc87);
  devgui::function_b23a59dfb4ca49a1("<dev string:x104f>", "<dev string:x1060>", &function_108d531ae15fcc87);
  devgui::function_b23a59dfb4ca49a1("<dev string:x108f>", "<dev string:x10a1>", &function_108d531ae15fcc87);
  devgui::function_b2159fbbd7ac094e("<dev string:x10d1>", @ "hash_e2d799f3be57182c");
  devgui::function_b2159fbbd7ac094e("<dev string:x10ec>", @ "hash_15f2625555966cc5");
  devgui::function_b2159fbbd7ac094e("<dev string:x1107>", @ "hash_427ed1f525368516");
  devgui::function_b2159fbbd7ac094e("<dev string:x1122>", @ "hash_bd3120ea0bb6d372");
  devgui::function_b2159fbbd7ac094e("<dev string:x113f>", @ "hash_d6c6f72d0fa198e1");
  devgui::function_b2159fbbd7ac094e("<dev string:x115a>", @ "hash_1ba1d0074052d695");
  devgui::function_b2159fbbd7ac094e("<dev string:x1174>", @ "hash_e240cfe5c52e96b9");
  devgui::function_b2159fbbd7ac094e("<dev string:x118f>", @ "hash_e045509608ce5be3");
  devgui::function_fe953f000498048f();
  thread function_8c073da924b036f8();
  setDvar(@ "hash_bd3120ea0bb6d372", level.aether_storm.var_94ea725a035aef57);

  while(true) {
    waitframe();

    if(getdvarint(@ "hash_c970fe9ef25b9a04", 0)) {
      setDvar(@ "hash_c970fe9ef25b9a04", 0);
      println("<dev string:x11a9>");
      start_expansion();
    }

    if(getdvarint(@ "hash_578143de415fb426", 0)) {
      percent = getdvarfloat(@ "hash_578143de415fb426", 0);
      setDvar(@ "hash_578143de415fb426", 0);
      println("<dev string:x11eb>" + percent + "<dev string:x1245>");

      if(isDefined(level.aether_storm.radiation)) {
        function_108d531ae15fcc87([percent]);
      }
    }

    if(getdvarint(@ "hash_15f2625555966cc5", 0)) {
      setDvar(@ "hash_15f2625555966cc5", 0);

      if(!isDefined(level.aether_storm.final_exfil)) {
        println("<dev string:x124b>");
        continue;
      }

      println("<dev string:x127f>" + level.aether_storm.final_exfil.origin);

      foreach(player in level.players) {
        x = level.aether_storm.final_exfil.origin[0];
        y = level.aether_storm.final_exfil.origin[1];
        z = level.aether_storm.final_exfil.origin[2] + 128;
        player setOrigin((x, y, z));
      }
    }

    if(getdvarint(@ "hash_427ed1f525368516", 0)) {
      setDvar(@ "hash_427ed1f525368516", 0);
      println("<dev string:x12c9>");

      if(!istrue(level.aether_storm.final_exfil.var_1326008dc390c510) && !istrue(level.aether_storm.var_e42fed415ee7a4eb)) {
        thread function_4b40a61f53dd9122();
      }

      level notify("<dev string:x12fe>");
    }

    if(getdvarint(@ "hash_bd3120ea0bb6d372", 1) != level.aether_storm.var_94ea725a035aef57) {
      level.aether_storm.var_94ea725a035aef57 = getdvarint(@ "hash_bd3120ea0bb6d372", 1);

      if(level.aether_storm.var_94ea725a035aef57) {
        println("<dev string:x1326>");
        thread function_ebf8ee98cf7a3be0();
      } else {
        println("<dev string:x135f>");
        level notify("<dev string:x50f>");
      }
    }

    if(getdvarint(@ "hash_e240cfe5c52e96b9", 0)) {
      setDvar(@ "hash_e240cfe5c52e96b9", 0);
      player = level.players[0];
      forward = anglesToForward(player getplayerangles());
      trace = trace::ray_trace(player getEye(), player getEye() + forward * 150000);

      if(isDefined(trace["<dev string:x1399>"]) && isDefined(trace["<dev string:x13a5>"]) && trace["<dev string:x13a5>"] < 1) {
        function_ea13f5b63d920d2f(trace["<dev string:x1399>"]);
      }
    }

    if(getdvarint(@ "hash_e045509608ce5be3", 0)) {
      setDvar(@ "hash_e045509608ce5be3", 0);
      player = level.players[0];
      forward = anglesToForward(player getplayerangles());
      trace = trace::ray_trace(player getEye(), player getEye() + forward * 150000);

      if(isDefined(trace["<dev string:x1399>"]) && isDefined(trace["<dev string:x13a5>"]) && trace["<dev string:x13a5>"] < 1) {
        objidpoolmanager::update_objective_position(level.aether_storm.var_d5422504409025bf, trace["<dev string:x1399>"]);
        objidpoolmanager::objective_playermask_showtoall(level.aether_storm.var_d5422504409025bf);
        level.aether_storm.var_bcf79bebe2066931.origin = trace["<dev string:x1399>"];
        level.aether_storm.var_bcf79bebe2066931 setscriptablepartstate(#"strike", #"on");
        level.aether_storm.var_bcf79bebe2066931 waittill("<dev string:x13b1>");
        objidpoolmanager::objective_playermask_hidefromall(level.aether_storm.var_d5422504409025bf);
      }
    }
  }
}

function private function_8c073da924b036f8() {
  level endon("<dev string:x53f>");

  for(timer = 0; true; timer = 0) {
    if(getdvarint(@ "hash_e2d799f3be57182c", 0) && timer == 0) {
      print3d(level.aether_storm.final_exfil.origin + (0, 0, 300), "<dev string:x13db>", (1, 1, 1), 1, 25, 5, 1);
      sphere(level.aether_storm.final_exfil.origin, 360, (1, 1, 1), 0, 5);
    }

    if(getdvarint(@ "hash_d6c6f72d0fa198e1", 0) && isDefined(level.aether_storm.var_6dbf82211b027b64)) {
      cylinder(level.aether_storm.var_6dbf82211b027b64, level.aether_storm.var_6dbf82211b027b64 + (0, 0, 1), level.aether_storm.var_6da5e5e442abcb81, (1, 0, 1), 0, 1);
    }

    if(getdvarint(@ "hash_1ba1d0074052d695", 0) && isDefined(level.aether_storm.var_bcf79bebe2066931)) {
      cylinder(level.aether_storm.var_bcf79bebe2066931.origin, level.aether_storm.var_bcf79bebe2066931.origin + (0, 0, 1), level.aether_storm.var_4f4ea0d0cc4b762e, (0.5, 0, 1), 0, 1);
      line(level.aether_storm.var_bcf79bebe2066931.origin, level.aether_storm.var_bcf79bebe2066931.origin + (0, 0, 1024), (0.5, 0, 1), 1, 0, 1);
    }

    waitframe();
    timer++;

    if(timer >= 5) {}
  }
}

function function_108d531ae15fcc87(params) {
  percent = float(params[0]) / 100;

  if(!istrue(level.aether_storm.radiation.transforming)) {
    start_expansion();
    waitframe();
  }

  level.aether_storm.radiation.var_b6b423f4ed3f7a2d = percent * level.aether_storm.var_647bf2cbf73994dd;
  var_29af21d31db6158c = level.aether_storm.var_647bf2cbf73994dd - level.aether_storm.radiation.var_b6b423f4ed3f7a2d;
  set_timer_time(var_29af21d31db6158c);

  if(istrue(level.aether_storm.final_exfil.var_1326008dc390c510) && isDefined(level.aether_storm.final_exfil.var_18da16a5ee3e8314) && isDefined(level.aether_storm.final_exfil.var_18da16a5ee3e8314.progresstrackers["<dev string:x13f7>"])) {
    foreach(player in level.aether_storm.final_exfil.var_c9164736baf0694a) {
      if(isalive(player) && player.sessionstate == "<dev string:x1406>") {
        player thread exfil_timer_player_ui(var_29af21d31db6158c, level.aether_storm.final_exfil);
      }
    }

    level thread exfil_timer(level.aether_storm.final_exfil, var_29af21d31db6158c);
  }

  progress = level.aether_storm.radiation.var_b6b423f4ed3f7a2d / level.aether_storm.radiation.var_7bf9ce32347ac445;
  level.aether_storm.radiation.origin = vectorlerp(level.aether_storm.radiation.var_b70884a49ee01c84, level.aether_storm.radiation.var_828323b769725dbf, progress);
  level.aether_storm.radiation.radius = math::lerp(level.aether_storm.radiation.var_c939535a8d2d4870, level.aether_storm.radiation.var_89748805c0fc52e3, progress);
  var_49a313cc785a2410 = (level.aether_storm.var_3d51670b31c0dbc0 - gettime()) / 1000;
  var_49a313cc785a2410 -= level.aether_storm.var_be0e041e85848a6d;
  var_49a313cc785a2410 -= getdvarint(@ "hash_eb873c5e99093d11", 50);
  var_49a313cc785a2410 -= getdvarint(@ "hash_346baccb7a031727", 7);

  if(var_49a313cc785a2410 > 0) {
    thread function_fb316270994fd943("<dev string:x12fe>", var_49a313cc785a2410);
  } else {
    if(!istrue(level.aether_storm.final_exfil.var_1326008dc390c510) && !istrue(level.aether_storm.var_e42fed415ee7a4eb)) {
      thread function_4b40a61f53dd9122();
    }

    level notify("<dev string:x12fe>");
  }

  if(isDefined(level.aether_storm.radiation.brcircle)) {
    level.aether_storm.radiation.brcircle delete();
    level.aether_storm.radiation.brcircle = spawnbrcircle(level.aether_storm.radiation.origin[0], level.aether_storm.radiation.origin[1], level.aether_storm.radiation.radius);

    if(level.aether_storm.radiation.var_b6b423f4ed3f7a2d < level.aether_storm.radiation.var_7bf9ce32347ac445) {
      level.aether_storm.radiation.brcircle brcirclemoveTo(level.aether_storm.radiation.var_828323b769725dbf[0], level.aether_storm.radiation.var_828323b769725dbf[1], level.aether_storm.radiation.var_89748805c0fc52e3, level.aether_storm.radiation.var_7bf9ce32347ac445 - level.aether_storm.radiation.var_b6b423f4ed3f7a2d);
    }
  }
}

function debug_announcement(params) {
  switch (params[0]) {
    case #"hash_11b12a173b095faa":
    case #"hash_1eac9737b00b8d4f":
    case #"hash_2d4ef0849822310c":
    case #"hash_85c6684d3cc86f5b":
    case #"hash_c579023a5e0694ad":
      foreach(player in level.players) {
        player thread hud_message::showsplash("<dev string:x14df>", undefined, undefined, undefined, 1, "<dev string:x1501>");
      }

      break;
    case #"hash_c0f39f4bc1059d04":
      foreach(player in level.players) {
        player thread hud_message::showsplash("<dev string:x1517>", undefined, undefined, undefined, 1, "<dev string:x1501>");
      }

      break;
  }

  if(params[0] == "<dev string:x153b>") {
    switch (level.aether_storm.announcement_handler) {
      case 0:
        thread overlord::playconversation("<dev string:x1565>", level.players);
        break;
      case 1:
        thread overlord::playconversation("<dev string:x158f>", level.players);
        break;
      case 2:
        thread overlord::playconversation("<dev string:x15b7>", level.players);
        break;
      case 3:
        thread overlord::playconversation("<dev string:x15e0>", level.players);
        break;
    }

    return;
  }

  if(params[0] == "<dev string:x1411>") {
    switch (level.aether_storm.announcement_handler) {
      case 0:
        thread overlord::playconversation("<dev string:x143b>", level.players);
        break;
      case 1:
        thread overlord::playconversation("<dev string:x1465>", level.players);
        break;
      case 2:
        thread overlord::playconversation("<dev string:x148d>", level.players);
        break;
      case 3:
        thread overlord::playconversation("<dev string:x14b6>", level.players);
        break;
    }

    return;
  }

  if(params[0] == "<dev string:x1609>") {
    switch (level.aether_storm.announcement_handler) {
      case 0:
        thread overlord::playevent("<dev string:x1636>", level.players);
        break;
      case 1:
        thread overlord::playevent("<dev string:x1663>", level.players);
        break;
      case 2:
        thread overlord::playevent("<dev string:x168e>", level.players);
        break;
      case 3:
        thread overlord::playevent("<dev string:x16ba>", level.players);
        break;
    }

    return;
  }

  if(params[1] == "<dev string:x16e6>") {
    thread overlord::playconversation(params[0], level.players);
    return;
  }

  thread overlord::playevent(params[0], level.players);
}

function function_fb316270994fd943(notification, delay) {
  level endon(notification);
  wait delay;
  level notify(notification);
}

# /
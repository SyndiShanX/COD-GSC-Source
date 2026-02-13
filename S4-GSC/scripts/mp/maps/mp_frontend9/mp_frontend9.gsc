/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontend9\mp_frontend9.gsc
*********************************************************/

_id_AB5F() {
  level endon("game_ended");
  self endon("disconnect");
  level._id_B812 = self;

  if(isDefined(level._id_B67F)) {
    return;
  }
  level._id_B67F = 1;
  scripts\engine\utility::_id_80CB();

  if(getdvarint("#x312d49106d8ba6b77", 0)) {
    scripts\engine\utility::delaythread(1, scripts\mp\team_mvp_characters_util::file_print_generate_animation_data_function);
  }

  scripts\mp\team_mvp_characters_util::_id_C1C9();
  scripts\mp\team_mvp_characters_util::register_animation_camera_data();
  zombiefrontendsetup();

  if(getdvarint("#x383a93be8954d7ef5", 0)) {
    level thread endlesslobbyfloor3tiles();
  } else {
    level thread endlesslobbyfloor2tiles();
  }

  thread _id_0791::_id_D815();
  _id_0791::_id_81D9();
  self _meth_865D();
  wait 0.5;
  scripts\engine\utility::_id_0FDC("vfx_frag_gren_im", "vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
}

run_explosions() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("frontend3_explosion_struct", "targetname");
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");

  for(;;) {
    wait 1;

    foreach(var_3 in var_1) {
      playFX(scripts\engine\utility::getfx("vfx_frag_gren_im"), var_3.origin);
      wait(randomint(3) + 2);
    }
  }
}

_id_2F2A() {
  thread _id_AB5F();
  thread _id_0791::_id_5FDA(_id_0791::_id_3079);
  thread _id_0791::_id_5541();
  thread _id_0791::_id_990D();
}

main() {
  scripts\mp\maps\mp_frontend9\mp_frontend9_precache::main();
  scripts\mp\maps\mp_frontend9\gen\mp_frontend9_art::main();
  scripts\mp\maps\mp_frontend9\mp_frontend9_fx::main();
  scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::main();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  _id_0791::_id_3EDF();
  _id_0791::_id_D7D1();
  scripts\cp_mp\gunbench_adjustiments::gunbench_startup();
  level._id_F48A = 0;
  level._id_2F4B = ::_id_2F2A;
  init_frontend_lighting_transitions();
  scripts\engine\utility::_id_5C11("floor1");
  setDvar("#x3a913fc7ea6721d71", 0);
}

init_frontend_lighting_transitions() {
  add_frontend_transition("squad_lobby", "squad_lobby_detail", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::lobby_far);
  add_frontend_transition("squad_lobby_detail", "squad_lobby", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::lobby_close);
  add_frontend_transition("loadout_showcase_overview", "character_faction_select", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_far);
  add_frontend_transition("loadout_showcase_overview", "squad_lobby_detail", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_far);
  add_frontend_transition("loadout_showcase_s", "loadout_showcase_p", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_close);
  add_frontend_transition("loadout_showcase_perks", "loadout_showcase_s", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_far);
  add_frontend_transition("loadout_showcase_l", "loadout_showcase_perks", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_close);
  add_frontend_transition("loadout_showcase_p", "loadout_showcase_t", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_far);
  add_frontend_transition("loadout_showcase_t", "loadout_showcase_p", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_close);
  add_frontend_transition("loadout_showcase_perks", "loadout_showcase_l", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_far);
  add_frontend_transition("loadout_showcase_s", "loadout_showcase_perks", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_close);
  add_frontend_transition("loadout_showcase_p", "loadout_showcase_s", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_far);
  add_frontend_transition("loadout_showcase_watch", "loadout_showcase_overview", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_watch);
  add_frontend_transition("loadout_showcase_overview", "loadout_showcase_watch", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::weapons_far);
  add_frontend_transition("character_tango", "default", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select", "operator_far", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select", "character_faction_select_detail", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select", "character_faction_select_quips", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select", "character_faction_select_animation_preview", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_detail", "default", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_detail", "character_faction_select", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_detail", "character_faction_select_quips", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_quips", "default", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_quips", "character_faction_select_detail", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_quips", "character_faction_select_animation_preview", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_animation_preview", "default", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_preview_select", "default", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_preview_select", "character_preview_select_detail", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_preview_select", "character_faction_select_quips", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_preview_select_detail", "default", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_preview_select_detail", "character_preview_select", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select", "squad_lobby", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select", "loadout_showcase_overview", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_animation_preview", "character_faction_select_quips", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
  add_frontend_transition("character_faction_select_animation_preview", "character_faction_select_detail", "lighting_change", scripts\mp\maps\mp_frontend9\mp_frontend9_lighting::operator_far);
}

add_frontend_transition(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.frontend_transition_adds)) {
    level.frontend_transition_adds = [];
  }

  var_4 = spawnStruct();
  var_4.from = var_0;
  var_4.to = var_1;
  var_4.name = var_2;
  var_4._id_6016 = var_3;
  level.frontend_transition_adds[level.frontend_transition_adds.size] = var_4;
}

endlesslobbyfloor2tiles() {
  wait 0.1;
  var_0 = getent("lobby_floor_01", "targetname");
  var_1 = getEntArray("lobby_floor_01_collection", "targetname");
  var_2 = getent("lobby_floor_02", "targetname");
  var_3 = getEntArray("lobby_floor_02_collection", "targetname");
  var_4 = getEntArray("lobby_floor_03_collection", "targetname");

  if(getdvarint("#x377ae86419e72a881", 0)) {
    foreach(var_6 in scripts\engine\utility::array_combine(var_1, var_3)) {
      var_6 delete();
    }

    var_1 = [];
    var_3 = [];
  }

  foreach(var_6 in var_4) {
    var_6 delete();
  }

  var_4 = [];

  if(!isDefined(var_0) || !isDefined(var_2)) {
    return;
  }
  if(isDefined(var_1) && var_1.size >= 1) {
    foreach(var_11 in var_1) {
      var_11 linkto(var_0);
    }
  }

  if(isDefined(var_3) && var_3.size >= 1) {
    foreach(var_11 in var_3) {
      var_11 linkto(var_2);
    }
  }

  var_15 = var_0.origin;
  var_16 = var_2.origin;
  var_17 = distance(var_15, var_16);
  var_18 = 25.662 * getdvarfloat("#x326cace33648f89f8", 1.0);
  var_19 = var_17 / var_18;
  var_20 = var_15 + vectornormalize(var_15 - var_16) * var_17;
  var_21 = 1;
  wait 0.05;

  for(;;) {
    if(var_21) {
      scripts\engine\utility::_id_5C1B("floor1");
      var_2 hide();
      var_2 dontinterpolate();
      var_2.origin = var_2.origin + (0, 0, -1000);
      waitframe();
      var_2 dontinterpolate();
      var_2.origin = var_16 + (0, 0, -1000);
      waitframe();
      var_2 dontinterpolate();
      var_2.origin = var_16;
      var_2 show();
      var_2 moveto(var_15, var_19);
      var_0 moveto(var_20, var_19);
    } else {
      scripts\engine\utility::_id_5C04("floor1");
      var_0 hide();
      var_0 dontinterpolate();
      var_0.origin = var_0.origin + (0, 0, -1000);
      waitframe();
      var_0 dontinterpolate();
      var_0.origin = var_16 + (0, 0, -1000);
      waitframe();
      var_0 dontinterpolate();
      var_0.origin = var_16;
      var_0 show();
      var_0 moveto(var_15, var_19);
      var_2 moveto(var_20, var_19);
    }

    var_21 = !var_21;
    wait(var_19);
  }
}

endlesslobbyfloor3tiles() {
  wait 0.1;
  var_0 = getent("lobby_floor_01", "targetname");
  var_1 = getEntArray("lobby_floor_01_collection", "targetname");
  var_2 = getent("lobby_floor_02", "targetname");
  var_3 = getEntArray("lobby_floor_02_collection", "targetname");
  var_4 = getent("lobby_floor_03", "targetname");
  var_5 = getEntArray("lobby_floor_03_collection", "targetname");

  if(getdvarint("#x377ae86419e72a881", 0)) {
    foreach(var_7 in scripts\engine\utility::array_combine(var_1, var_3, var_5)) {
      var_7 delete();
    }

    var_1 = [];
    var_3 = [];
    var_5 = [];
  }

  if(!isDefined(var_0) || !isDefined(var_2) || !isDefined(var_4)) {
    return;
  }
  if(isDefined(var_1) && var_1.size >= 1) {
    foreach(var_10 in var_1) {
      var_10 linkto(var_0);
    }
  }

  if(isDefined(var_3) && var_3.size >= 1) {
    foreach(var_10 in var_3) {
      var_10 linkto(var_2);
    }
  }

  if(isDefined(var_5) && var_5.size >= 1) {
    foreach(var_10 in var_5) {
      var_10 linkto(var_4);
    }
  }

  var_16 = var_0.origin;
  var_17 = var_2.origin;
  var_18 = var_4.origin;
  var_19 = distance(var_17, var_18) / 2;
  var_20 = 25.662 * getdvarfloat("#x326cace33648f89f8", 1.0);
  var_21 = var_19 / var_20;
  var_22 = var_21 * 0.5;
  var_23 = var_18 + vectornormalize(var_18 - var_16) * var_19;
  var_24 = 2;
  wait 0.05;

  for(;;) {
    if(var_24 == 1) {
      var_0 hide();
      var_0 dontinterpolate();
      var_0.origin = var_0.origin + (0, 0, -1000);
      waitframe();
      var_0 dontinterpolate();
      var_0.origin = var_17 + (0, 0, -1000);
      waitframe();
      var_0 dontinterpolate();
      var_0.origin = var_17;
      var_0 show();
      var_0 moveto(var_16, var_21);
      var_2 moveto(var_23, var_21);
      var_4 moveto(var_18, var_21);
    } else if(var_24 == 2) {
      var_2 hide();
      var_2 dontinterpolate();
      var_2.origin = var_2.origin + (0, 0, -1000);
      waitframe();
      var_2 dontinterpolate();
      var_2.origin = var_17 + (0, 0, -1000);
      waitframe();
      var_2 dontinterpolate();
      var_2.origin = var_17;
      var_2 show();
      var_2 moveto(var_16, var_21);
      var_4 moveto(var_23, var_21);
      var_0 moveto(var_18, var_21);
    } else {
      var_4 hide();
      var_4 dontinterpolate();
      var_4.origin = var_4.origin + (0, 0, -1000);
      waitframe();
      var_4 dontinterpolate();
      var_4.origin = var_17 + (0, 0, -1000);
      waitframe();
      var_4 dontinterpolate();
      var_4.origin = var_17;
      var_4 show();
      var_4 moveto(var_16, var_21);
      var_0 moveto(var_23, var_21);
      var_2 moveto(var_18, var_21);
    }

    wait(var_21);
    var_24 = var_24 + 1;

    if(var_24 > 3) {
      var_24 = 1;
    }
  }
}

zombiefrontendsetup() {
  var_0 = getEntArray("zombie_collection", "script_noteworthy");

  if(getDvar("#x3a30c33efc8281eb1") == "zombie" || getdvarint("#x36db083359e44ef53", 0) == 1) {
    foreach(var_2 in var_0) {
      var_2.origin = var_2.origin + (0, 0, 4096);
    }
  } else {
    foreach(var_2 in var_0) {
      var_2 delete();
    }
  }
}
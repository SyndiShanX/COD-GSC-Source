/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: core\gametypes\frontend.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\core\gametypes\frontend_zm_bgb_chance;
#using scripts\shared\ai\animation_selector_table_evaluators;
#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_damage_effects;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\behavior_state_machine_planners_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\player_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using_animtree("all_player");
#namespace frontend;

function callback_void() {}

function callback_actorspawnedfrontend(spawner) {
  self thread spawner::spawn_think(spawner);
}

function main() {
  level.callbackstartgametype = & callback_void;
  level.callbackplayerconnect = & callback_playerconnect;
  level.callbackplayerdisconnect = & callback_void;
  level.callbackentityspawned = & callback_void;
  level.callbackactorspawned = & callback_actorspawnedfrontend;
  level.orbis = getdvarstring("orbisGame") == "true";
  level.durango = getdvarstring("durangoGame") == "true";
  scene::add_scene_func("sb_frontend_black_market", & black_market_play, "play");
  clientfield::register("world", "first_time_flow", 1, getminbitcountfornum(1), "int");
  clientfield::register("world", "cp_bunk_anim_type", 1, getminbitcountfornum(1), "int");
  clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
  clientfield::register("scriptmover", "dni_eyes", 1000, 1, "int");
  level.weaponnone = getweapon("none");
  level thread dailychallengedevguiinit();
  level thread function_4afc218();
  setdvar("", 0);
  adddebugcommand("");
  setdvar("", "");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  level thread zm_frontend_zombie_logic();
  level thread zm_frontend_zm_bgb_chance::zm_frontend_bgb_slots_logic();
  level thread set_current_safehouse_on_client();
}

function set_current_safehouse_on_client() {
  wait(0.05);
  if(world.is_first_time_flow !== 0) {
    world.cp_bunk_anim_type = 0;
    level clientfield::set("first_time_flow", 1);
    printtoprightln("", (1, 1, 1));
  } else {
    if(math::cointoss()) {
      world.cp_bunk_anim_type = 0;
      printtoprightln("", (1, 1, 1));
    } else {
      world.cp_bunk_anim_type = 1;
      printtoprightln("", (1, 1, 1));
    }
    level clientfield::set("cp_bunk_anim_type", world.cp_bunk_anim_type);
  }
}

function zm_frontend_zombie_logic() {
  wait(5);
  a_sp_zombie = getentarray("sp_zombie_frontend", "targetname");
  while (true) {
    a_sp_zombie = array::randomize(a_sp_zombie);
    foreach(sp_zombie in a_sp_zombie) {
      while (getaicount() >= 20) {
        wait(1);
      }
      ai_zombie = sp_zombie spawnfromspawner();
      if(isdefined(ai_zombie)) {
        ai_zombie sethighdetail(1);
        ai_zombie setavoidancemask("avoid all");
        ai_zombie pushactors(0);
        ai_zombie clientfield::set("zombie_has_eyes", 1);
        ai_zombie.delete_on_path_end = 1;
        ai_zombie.disabletargetservice = 1;
        ai_zombie.ignoreall = 1;
        sp_zombie.count++;
      }
      wait(randomfloatrange(3, 8));
    }
  }
}

function callback_playerconnect() {
  self thread black_market_dialog();
  self thread dailychallengedevguithink();
  self thread function_ead1dc1a();
}

function black_market_play(a_ents) {
  level.blackmarketsceneorigin = self.origin;
  level.blackmarketsceneangles = self.angles;
  level.blackmarketdealer = a_ents["sb_frontend_black_market_character"];
  level.blackmarketdealertumbler = a_ents["lefthand"];
  level.blackmarketdealerpistol = a_ents["righthand"];
  level scene::stop("sb_frontend_black_market");
  level.blackmarketdealer clientfield::set("dni_eyes", 1);
}

function black_market_dialog() {
  self endon("disconnect");
  while (true) {
    self waittill("menuresponse", menu, response);
    if(menu != "BlackMarket") {
      continue;
    }
    switch (response) {
      case "greeting": {
        thread play_black_market_greeting_animations();
        break;
      }
      case "greeting_first": {
        play_black_market_dialog("vox_mark_greeting_first");
        break;
      }
      case "greeting_broke": {
        thread play_black_market_broke_animations();
        break;
      }
      case "roll": {
        play_black_market_dialog("vox_mark_roll_in_progress");
        break;
      }
      case "complete_common": {
        play_black_market_dialog("vox_mark_complete_common");
        break;
      }
      case "complete_rare": {
        play_black_market_dialog("vox_mark_complete_rare");
        break;
      }
      case "complete_legendary": {
        play_black_market_dialog("vox_mark_complete_legendary");
        break;
      }
      case "complete_epic": {
        play_black_market_dialog("vox_mark_complete_epic");
        break;
      }
      case "burn_duplicates": {
        thread play_black_market_burn_animations();
        break;
      }
      case "stopsounds": {
        level.blackmarketdealer stopsounds();
        break;
      }
      case "closed": {
        level.blackmarketdealer stopsounds();
        level.blackmarketdealer thread animation::stop(0.2);
        level.blackmarketdealertumbler thread animation::stop(0.2);
        level.blackmarketdealerpistol thread animation::stop(0.2);
        level.blackmarketdealer notify("closed");
        break;
      }
    }
  }
}

function play_black_market_dialog(dialogalias) {
  if(!isdefined(dialogalias)) {
    return;
  }
  level.blackmarketdealer stopsounds();
  level.blackmarketdealer playsoundontag(dialogalias, "J_Head");
}

function play_black_market_1st_greeting() {
  if(getlocalprofileint("com_firsttime_blackmarket")) {
    return false;
  }
  level.blackmarketdealer endon("closed");
  play_black_market_animations("pb_black_marketeer_1st_time_greeting_", "o_black_marketeer_tumbler_1st_time_greeting_", "o_black_marketeer_pistol_1st_time_greeting_", "01");
  level.blackmarketdealer waittill("finished_black_market_animation");
  setlocalprofilevar("com_firsttime_blackmarket", 1);
  return true;
}

function play_black_market_greeting_animations() {
  level.blackmarketdealer endon("closed");
  if(play_black_market_1st_greeting()) {
    return;
  }
  animnumber = pick_black_market_anim(11);
  play_black_market_animations("pb_black_marketeer_greeting_", "o_black_marketeer_tumbler_greeting_", "o_black_marketeer_pistol_greeting_", animnumber);
}

function play_black_market_broke_animations() {
  level.blackmarketdealer endon("closed");
  if(play_black_market_1st_greeting()) {
    return;
  }
  animnumber = pick_black_market_anim(10);
  play_black_market_animations("pb_black_marketeer_insufficient_funds_", "o_black_marketeer_tumbler_insufficient_funds_", "o_black_marketeer_pistol_insufficient_funds_", animnumber);
}

function play_black_market_burn_animations() {
  animnumber = pick_black_market_anim(6);
  play_black_market_animations("pb_black_marketeer_burn_dupes_", "o_black_marketeer_tumbler_burn_dupes_", "o_black_marketeer_pistol_burn_dupes_", animnumber);
}

function pick_black_market_anim(animcount) {
  animnumber = randomint(animcount);
  if(animnumber < 10) {
    return "0" + animnumber;
  }
  return animnumber;
}

function play_black_market_animations(dealeranim, tumbleranim, pistolanim, animnumber = "") {
  level.blackmarketdealer stopsounds();
  level.blackmarketdealer thread play_black_market_animation(dealeranim + animnumber, "pb_black_marketeer_idle", level.blackmarketsceneorigin, level.blackmarketsceneangles);
  level.blackmarketdealertumbler thread play_black_market_animation(tumbleranim + animnumber, "o_black_marketeer_tumbler_idle", level.blackmarketdealer, "tag_origin");
  level.blackmarketdealerpistol thread play_black_market_animation(pistolanim + animnumber, "o_black_marketeer_pistol_idle", level.blackmarketdealer, "tag_origin");
}

function play_black_market_animation(animname, idleanimname, originent, tagangles) {
  self notify("play_black_market_animation");
  self endon("play_black_market_animation");
  level.blackmarketdealer endon("closed");
  self thread animation::stop(0.2);
  self animation::play(animname, originent, tagangles, 1, 0.2, 0.2);
  self notify("finished_black_market_animation");
  self thread animation::play(idleanimname, originent, tagangles, 1, 0.2, 0);
}

function dailychallengedevguiinit() {
  setdvar("", 0);
  num_rows = tablelookuprowcount("");
  for (row_num = 2; row_num < num_rows; row_num++) {
    challenge_name = tablelookupcolumnforrow("", row_num, 5);
    challenge_name = getsubstr(challenge_name, 11);
    display_row_num = row_num - 2;
    devgui_string = ((((("" + "") + (display_row_num < 10 ? "" + display_row_num : display_row_num) + "") + challenge_name) + "") + row_num) + "";
    adddebugcommand(devgui_string);
  }
}

function dailychallengedevguithink() {
  self endon("disconnect");
  while (true) {
    daily_challenge_cmd = getdvarint("");
    if(daily_challenge_cmd == 0 || !sessionmodeiszombiesgame()) {
      wait(1);
      continue;
    }
    daily_challenge_row = daily_challenge_cmd;
    daily_challenge_index = tablelookupcolumnforrow("", daily_challenge_row, 0);
    daily_challenge_stat = tablelookupcolumnforrow("", daily_challenge_row, 4);
    adddebugcommand((("" + daily_challenge_stat) + "") + "");
    adddebugcommand(("" + daily_challenge_index) + "");
    adddebugcommand("" + "");
    setdvar("", 0);
  }
}

function function_4afc218() {
  setdvar("", 0);
  while (true) {
    if(getdvarint("") <= 0 || !sessionmodeiszombiesgame()) {
      wait(1);
      continue;
    }
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    adddebugcommand("");
    break;
  }
}

function function_ead1dc1a() {
  self endon("disconnect");
  while (true) {
    if(getdvarstring("") == "") {
      wait(0.2);
      continue;
    }
    var_a508ba69 = getdvarstring("");
    command = getsubstr(var_a508ba69, 0, 3);
    map_name = getsubstr(var_a508ba69, 4, var_a508ba69.size);
    switch (command) {
      case "": {
        adddebugcommand((("" + map_name) + "") + "");
        adddebugcommand(("" + map_name) + "");
        adddebugcommand("");
        break;
      }
      case "": {
        adddebugcommand(("" + map_name) + "");
        adddebugcommand(("" + map_name) + "");
        adddebugcommand("");
        break;
      }
    }
    setdvar("", "");
    wait(0.2);
  }
}
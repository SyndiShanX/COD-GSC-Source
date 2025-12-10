/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_clone.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\archetype_clone;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_behavior;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_ai_clone;

function autoexec __init__sytem__() {
  system::register("zm_ai_clone", &__init__, &__main__, undefined);
}

function __init__() {
  level flag::init("thrasher_round");
  execdevgui("");
  thread function_78933fc2();
  init();
}

function __main__() {
  register_clientfields();
}

function register_clientfields() {}

function init() {
  precache();
}

function precache() {}

function function_78933fc2() {
  level flagsys::wait_till("");
  zm_devgui::add_custom_devgui_callback(&clone_devgui_callback);
}

function clone_devgui_callback(cmd) {
  switch (cmd) {
    case "": {
      players = getplayers();
      queryresult = positionquery_source_navigation(players[0].origin, 128, 256, 128, 20);
      if(isDefined(queryresult) && queryresult.data.size > 0) {
        clone = spawnactor("", queryresult.data[0].origin, (0, 0, 0), "", 1);
        clone cloneserverutils::cloneplayerlook(clone, players[0], players[0]);
      }
      break;
    }
    case "": {
      clones = getaiarchetypearray("");
      if(clones.size > 0) {
        foreach(clone in clones) {
          clone kill();
        }
      }
      break;
    }
  }
}
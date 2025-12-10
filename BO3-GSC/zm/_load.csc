/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_load.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_oob;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfaceanim_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\footsteps_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\load_shared;
#using scripts\shared\music_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_ambient;
#using scripts\zm\_callbacks;
#using scripts\zm\_destructible;
#using scripts\zm\_global_fx;
#using scripts\zm\_radiant_live_update;
#using scripts\zm\_sticky_grenade;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_playerhealth;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_traps;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\gametypes\_weaponobjects;
#namespace load;

function levelnotifyhandler(clientnum, state, oldstate) {
  if(state != "") {
    level notify(state, clientnum);
  }
}

function warnmissilelocking(localclientnum, set) {}

function warnmissilelocked(localclientnum, set) {}

function warnmissilefired(localclientnum, set) {}

function main() {
  /
  #
  assert(isDefined(level.first_frame), "");
  zm::init();
  level thread server_time();
  level thread util::init_utility();
  util::register_system("levelNotify", &levelnotifyhandler);
  register_clientfields();
  level.createfx_disable_fx = getdvarint("disable_fx") == 1;
  if(isDefined(level._uses_sticky_grenades) && level._uses_sticky_grenades) {
    level thread _sticky_grenade::main();
  }
  system::wait_till("all");
  level thread art_review();
  level flagsys::set("load_main_complete");
}

function server_time() {
  for(;;) {
    level.servertime = getservertime(0);
    wait(0.01);
  }
}

function register_clientfields() {
  clientfield::register("allplayers", "zmbLastStand", 1, 1, "int", &zm::laststand, 0, 1);
  clientfield::register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmhud.swordState", 1, 4, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter", undefined, 0, 0);
}
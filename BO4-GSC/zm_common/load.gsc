/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\load.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\dialog_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\load_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\weapons\zm\weaponobjects;
#include scripts\zm_common\art;
#include scripts\zm_common\bots\zm_bot;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\gametypes\clientids;
#include scripts\zm_common\gametypes\serversettings;
#include scripts\zm_common\gametypes\shellshock;
#include scripts\zm_common\gametypes\spawnlogic;
#include scripts\zm_common\gametypes\spectating;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_aoe;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_clone;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_power;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_zonemgr;

#namespace load;

main() {
  assert(isDefined(level.first_frame), "<dev string:x38>");
  zm::init();
  level._loadstarted = 1;
  register_clientfields();
  level.aitriggerspawnflags = getaitriggerflags() | 8192;
  level.vehicletriggerspawnflags = getvehicletriggerflags();
  level thread start_intro_screen_zm();
  footsteps();
  system::wait_till("all");
  level thread art_review();
  level flagsys::set(#"load_main_complete");
}

footsteps() {
  if(isDefined(level.fx_exclude_footsteps) && level.fx_exclude_footsteps) {
    return;
  }

  zombie_utility::setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
  zombie_utility::setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
  zombie_utility::setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
  zombie_utility::setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
  zombie_utility::setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
  zombie_utility::setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
  zombie_utility::setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

start_intro_screen_zm() {
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    players[i] lui::screen_fade_out(0, undefined);
    players[i] val::set(#"start_intro_screen_zm", "freezecontrols");
  }

  wait 1;
}

register_clientfields() {
  clientfield::register("allplayers", "zmbLastStand", 1, 1, "int");
}
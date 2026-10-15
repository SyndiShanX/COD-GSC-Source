/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\load.csc
***********************************************/

#include scripts\core_common\clientfaceanim_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\footsteps_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\load_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\vehicles\driving_fx;
#include scripts\weapons\zm\weaponobjects;
#include scripts\zm_common\ambient;
#include scripts\zm_common\global_fx;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_aoe;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_traps;

#namespace load;

levelnotifyhandler(clientnum, state, oldstate) {
  if(state != "") {
    level notify(state, clientnum);
  }
}

warnmissilelocking(localclientnum, set) {}

warnmissilelocked(localclientnum, set) {}

warnmissilefired(localclientnum, set) {}

main() {
  assert(isDefined(level.first_frame), "<dev string:x38>");
  zm::init();
  level thread util::init_utility();
  util::register_system(#"levelnotify", &levelnotifyhandler);
  register_clientfields();
  level.createfx_disable_fx = getdvarint(#"disable_fx", 0) == 1;
  system::wait_till("all");
  level thread art_review();
  level flagsys::set(#"load_main_complete");
}

register_clientfields() {
  clientfield::register("allplayers", "zmbLastStand", 1, 1, "int", &zm::laststand, 0, 1);
}
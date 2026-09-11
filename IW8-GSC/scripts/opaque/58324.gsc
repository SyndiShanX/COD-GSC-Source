/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58324.gsc
***********************************************/

function bot_item_matches_purpose() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_a10fd", "spawnCallback", &bot_landing_spots);
  bot_known_flag_carrier_loc();
  bot_killstreak_setup_func();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("veh_a10fd", &_calloutmarkerping_isvehicleoccupiedbyenemy::bot_get_stored_custom_classes);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh_a10fd", "endEnterInternal", &bot_is_protecting_hq_zone);
  level.restoreweaponstates = &scripts\mp\utility\player::getplayersinradius;
  level.little_bird_mg_mp_initspawning = &scripts\mp\gametypes\br_armory_kiosk::little_bird_mg_mp_initmines;
  level.ref_13352 = &scripts\mp\hud_message::showerrormessage;
  level.ref_11a22 = &scripts\mp\gametypes\br_pickups::ref_11a21;
  level.br_pickups_init = &scripts\mp\hud_message::showsplash;
  level.br_movingcirclemovedistmin = &scripts\mp\utility\perk::_hasperk;
  level.br_pickupdenyalreadyhaveplatepouch = &scripts\mp\gametypes\br_public::isplayeringulag;
  level.br_movingcirclegulagcloseoffset = &scripts\mp\utility\points::sec_sys_struct_1;
  level.bot_shotguns = &scripts\mp\gametypes\br_gametype_dmz::get_unique_id;
  level.phase_one_combat = getdvarint("scr_fd_allow_dauntless_respawn", 1);
}

function bot_known_flag_carrier_loc() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_a10fd", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
  var0.areplayersnear = 60;
  var1 = getdvarfloat("scr_fd_respawn_delay", 45);

  if(var1 >= 0) {
    var0.ref_12ca1 = var1;
    return;
  }
}

function bot_killstreak_setup_func() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("veh_a10fd", 1);
  var0.frontextents = 165;
  var0.backextents = 168;
  var0.leftextents = 57;
  var0.rightextents = 57;
  var0.bottomextents = 35;
  var0.distancetobottom = 50;
  var0.loscheckoffset = (0, 0, 70);
}

function bot_landing_spots(var0, var1) {
  var2 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var0, var1);
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_a10fd");
  var4 = isDefined(var3) && isDefined(var3.ref_12ca1);

  if(isDefined(var2) && (istrue(level.phase_one_combat) || var4)) {
    var2.ondeathrespawn = &bot_koth_think;
  }

  return var2;
}

function bot_koth_think() {
  thread bot_last_loadout_num();
}

function bot_last_loadout_num() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var1.ref = var0.ref;
  var1.rallypointhealth = var0.rallypointhealth;
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("veh_a10fd", var1, var2);
}

function bot_is_protecting_hq_zone(var0, var1, var2, var3, var4) {
  var0 scripts\mp\gametypes\arm::ref_141ff(var3.team);
}
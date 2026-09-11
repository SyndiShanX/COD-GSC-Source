/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_warp_door.gsc
*************************************************/

function init() {
  setdvarifuninitialized("scr_br_warpdoor_maxnum", 100);
  setdvarifuninitialized("scr_br_warpDoorMaxUses", 4);
  setdvarifuninitialized("scr_br_warpDoorInactiveTime", 10);
  setdvarifuninitialized("scr_br_warpDoorMaxOpenTime", 30);
  setdvarifuninitialized("scr_br_warpDoorUseMapLocs", 1);
  setdvarifuninitialized("scr_br_warpDoorAllowTimeout", 0);
  setdvarifuninitialized("scr_br_warpDoorKillTrespassers", 1);
  setdvarifuninitialized("scr_br_warpDoorHweenEnabled", 0);
  scripts\engine\scriptable::ref_12f5b("warpdoor", &ref_1442e);
  level._effect["warp_door_in"] = loadfx("vfx/iw8_br/gameplay/reddoor/vfx_br_reddoor_warp_in");
  level._effect["warp_door_out"] = loadfx("vfx/iw8_br/gameplay/reddoor/vfx_br_reddoor_warp_out");

  if(getdvarint("scr_br_warpDoorUseMapLocs", 1)) {
    thread ref_136b0();
  }

  scripts\mp\gametypes\br_red_door_riddle_event::init();
  thread initdropbagvo();
  thread zombiepowersenabled();
  thread zombieregendelayscaleoutgas();

  if(getdvarint("scr_br_warpDoorHweenEnabled", 0)) {
    scripts\mp\gametypes\br_red_door_riddle_event::supersbyextraweapon();
    thermiteboltburnout();
    return;
  }
}

function thermiteboltburnout() {
  level._effect["warp_door_hween_bats"] = loadfx("vfx/iw8_br/gameplay/reddoor/vfx_br_red_door_hween_bats");
  level._effect["warp_door_hween_footprints"] = loadfx("vfx/iw8_br/gameplay/reddoor/vfx_br_red_door_hween_footprints");
  level._effect["warp_door_hween_ghost"] = loadfx("vfx/iw8_br/gameplay/reddoor/vfx_br_red_door_hween_ghost");
  level._effect["warp_door_hween_skelhand"] = loadfx("vfx/iw8_br/gameplay/reddoor/vfx_br_red_door_hween_skelhand");
}

function get_bulletwhizby_alias() {
  if(!isDefined(level.audio_start_obj_room_fires)) {
    level.audio_start_obj_room_fires = [];
    return true;
  }

  if(level.audio_start_obj_room_fires.size < getdvarint("scr_br_warpdoor_maxnum", 100)) {
    return true;
  }

  return false;
}

function ref_136af(var_0, var_1, var_2) {
  if(!get_bulletwhizby_alias()) {
    return;
  }

  var_3 = spawn("script_model", var_0);
  var_3 setModel("t9_vnm_door_bunker_metal_01_rig");
  var_3.angles = var_1;
  var_3.usable = 1;
  cargobaywatch(var_3);

  if(getdvarint("scr_br_warpDoorHallwayEnabled", 1)) {
    ref_13288(var_3, 2);
  } else {
    ref_13288(var_3, 1);
  }

  if(isDefined(var_2)) {
    var_3.doorid = var_2;
  }

  level.audio_start_obj_room_fires[level.audio_start_obj_room_fires.size] = var_3;

  if(!istrue(level.br_circle_disabled)) {
    thread ref_1449a();
  }

  return var_3;
}

function ref_13288(var_0) {
  var_1 = relic_nuketimer_waitforobjectives();
  var_2 = "";

  if(isDefined(var_1.launcherfired)) {
    var_2 = var_1 getscriptablepartstate("warpdoor");

    if(validateplundereventtype(var_1.launcherfired)) {
      var_2 = getsubstr(var_2, 8, var_2.size);
    }
  } else {
    var_2 = "closed";
  }

  var_3 = var_2;
  var_1.launcherfired = var_0;

  if(validateplundereventtype(var_1.launcherfired)) {
    var_3 = "trapped_" + var_2;
  }

  if(var_1.launcherfired != 2 && !isDefined(var_1.ref_13a98)) {
    thread ref_136a0(var_1);
  }

  var_1 setscriptablepartstate("warpdoor", var_3);
}

function ref_13289() {
  ref_13288(5);
}

function ref_136a0(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  wait 0.2;
  var_1 = var_0.origin + anglestoleft(var_0.angles) * 25 + anglesToForward(var_0.angles) * -5 + (0, 0, 16);
  var_0.ref_13a98 = spawn("trigger_radius", var_1, 0, 16, 32);
  var_0.ref_13a98.ref_121d7 = var_0;
  scripts\mp\utility\trigger::makeenterexittrigger(var_0.ref_13a98, &ref_13a99, undefined);
}

function ref_13a99(var_0, var_1) {
  if(isDefined(var_1.should_wait_before_spawn_chopper_boss)) {
    return;
  }

  var_2 = ["dx_brm_adl_door_open_10", "dx_brm_adl_door_secrets_10", "dx_brm_adl_job_got_10", "dx_brm_adl_ready_this_10"];
  var_3 = ["dx_brm_stc_correct_alive_10", "dx_brm_stc_correct_quit_10", "dx_brm_stc_danger_change_10", "dx_brm_stc_danger_choice_10", "dx_brm_stc_muffled_come_10", "dx_brm_stc_muffled_open_10", "dx_brm_stc_muffled_secrets_10"];
  var_1.should_wait_before_spawn_chopper_boss = 1;

  if(unload_vehicles_on_weapons_free_thread(var_1.ref_121d7)) {
    playsoundatpos(var_1.origin, scripts\engine\utility::random(var_3));
    return;
  }

  playsoundatpos(var_1.origin, scripts\engine\utility::random(var_2));
}

function runjoininprogresstimeout() {
  return relic_nuketimer_waitforobjectives().launcherfired;
}

function relic_nuketimer_waitforobjectives() {
  var_0 = self;

  if(!isDefined(var_0.entity)) {
    var_0 = var_0 getlinkedscriptableinstance();
  }

  return var_0;
}

function ref_13281() {
  level.ref_145a7 = [];
  level.ref_145a7[0] = [1, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine", "gulag", "boneyard", "transit", "hospital", "layover"];
  level.ref_145a7[1] = [0.3, "downtown", "summit", "old_mine"];
  level.ref_145a7[2] = [0.3, "hills", "factory", "stadium"];
  level.ref_145a7[3] = [0.3, "farms", "salt_mine"];
  level.ref_145a7[4] = [1, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine"];
  level.ref_145a7[5] = [0.4, "old_mine", "hills", "hospital"];
  level.ref_145a7[6] = [0.4, "factory", "stadium"];
  level.ref_145a7[7] = [0.4, "farms", "salt_mine", "boneyard"];
  level.ref_145a7[8] = [0.4, "factory", "stadium", "layover"];
  level.ref_145a7[9] = [0.5, "downtown", "summit", "farms", "salt_mine", "hospital"];
  level.ref_145a7[10] = [0.5, "downtown", "summit", "transit"];
  level.ref_145a7[11] = [0.5, "hills", "stadium", "boneyard", "hospital"];
  level.ref_145a7[12] = [0.5, "old_mine", "factory", "layover"];
  level.ref_145a7[13] = [1, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine", "gulag", "boneyard", "transit", "layover"];
  level.ref_145a7[14] = [0.6, "summit", "hills", "farms", "hospital"];
  level.ref_145a7[15] = [0.6, "downtown"];
  level.ref_145a7[16] = [0.6, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine", "transit", "hospital", "layover"];
  level.ref_145a7[17] = [1, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine", "gulag", "hospital", "layover"];
  level.ref_145a7[18] = [1, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine", "gulag", "boneyard", "layover"];
  level.ref_145a7[19] = [1, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine", "gulag", "boneyard", "transit"];
  level.ref_145a7[20] = [1, "downtown", "summit", "old_mine", "hills", "factory", "stadium", "farms", "salt_mine", "gulag", "boneyard", "transit", "hospital", "layover"];
}

function unset_vehicle_only_wave() {
  var_0 = self;

  if(!isDefined(var_0.ref_14728)) {
    var_0.ref_14728 = "none";
  }

  var_1 = getdvarint("scr_br_warpDoorWeekID", 0);
  var_2 = level.ref_145a7[var_1];
  var_3 = var_2[0];

  for(var_4 = 1; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(var_5 == var_0.ref_14728) {
      if(randomfloat(1) > var_3) {
        return false;
      }

      return true;
    }
  }

  return false;
}

function latetoinfil() {
  var_0 = self;
  level endon("game_ended");

  if(!isDefined(var_0) || istrue(var_0.dead)) {
    return;
  }

  var_0.dead = 1;

  while(istrue(var_0.tv_station_fastrope_one_infil_rider_start_targetname)) {
    waitframe();
  }

  if(isDefined(var_0.ref_13a98)) {
    var_0.ref_13a98 delete();
  }

  var_0 notify("end_warp_queue");
  var_0.entity.usable = 0;
  var_0.entity notify("warpdoor_despawn");
  level.audio_start_obj_room_fires = scripts\engine\utility::array_remove(level.audio_start_obj_room_fires, var_0 getscriptablelinkedentity());
  var_0 setscriptablepartstate("warpdoor", "dying");

  while(var_0 getscriptablepartstate("warpdoor") != "dead") {
    waitframe();
  }

  var_0 getscriptablelinkedentity() delete();
}

function ref_136b0() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait 5;
  scripts\mp\gametypes\red_door_locations::traceresults();
  ref_13281();

  foreach(var_1 in level.disable_super_in_turret.ref_1442c) {
    var_2 = ref_136af(var_1.origin, var_1.angles, var_1.id);

    if(!unset_vehicle_only_wave(var_2)) {
      var_2 = var_2 getlinkedscriptableinstance();
      latetoinfil(var_2);
    }
  }

  if(isDefined(level.ref_1442d)) {
    level thread[[level.ref_1442d]]();
    return;
  }
}

function cargobaywatch() {
  var_0 = self;

  if(!isDefined(level.calloutglobals.calloutzones)) {
    level.calloutglobals.calloutzones = getEntArray("location_volume", "targetname");
  }

  if(!level.calloutglobals.calloutzones.size) {
    return;
  }

  var_1 = var_0 getscriptablelinkedentity();

  foreach(var_3 in level.calloutglobals.calloutzones) {
    if(var_1 istouching(var_3)) {
      var_0.ref_14728 = var_3.script_noteworthy;
      return;
    }
  }

  var_0.ref_14728 = "none";
}

function initdropbagvo() {
  var_0 = "mp/warpdoor_controlroom_locations.csv";
  var_1 = tablelookupgetnumrows(var_0);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = [];
    var_3 = (int(tablelookupbyrow(var_0, var_2, 1)), int(tablelookupbyrow(var_0, var_2, 2)), int(tablelookupbyrow(var_0, var_2, 3)));
    var_3 = (int(tablelookupbyrow(var_0, var_2, 4)), int(tablelookupbyrow(var_0, var_2, 5)), int(tablelookupbyrow(var_0, var_2, 6)));
    var_3 = (int(tablelookupbyrow(var_0, var_2, 7)), int(tablelookupbyrow(var_0, var_2, 8)), int(tablelookupbyrow(var_0, var_2, 9)));
    var_3 = (int(tablelookupbyrow(var_0, var_2, 10)), int(tablelookupbyrow(var_0, var_2, 11)), int(tablelookupbyrow(var_0, var_2, 12)));

    foreach(var_5 in var_3) {
      var_6 = 500;
      scripts\mp\gametypes\br_bunker_utility::little_bird_mg_playercontrolmg(var_5, var_6);
    }
  }
}

function zombiepowersenabled() {
  level endon("game_ended");

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  while(!isDefined(level.disable_super_in_turret)) {
    waitframe();
  }

  var_0 = "mp/warpdoor_controlroom_locations.csv";
  var_1 = tablelookupgetnumrows(var_0);
  level.hud_set_progress = [];
  scripts\mp\gametypes\red_door_locations::teleport_reference_juggmaze();
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = spawnStruct();
    var_4.id = int(tablelookupbyrow(var_0, var_3, 0));
    var_4.ignore_spawn_scoring_pois = [];
    var_4.ignore_spawn_scoring_pois[0] = (int(tablelookupbyrow(var_0, var_3, 1)), int(tablelookupbyrow(var_0, var_3, 2)), int(tablelookupbyrow(var_0, var_3, 3)));
    var_4.ignore_spawn_scoring_pois[1] = (int(tablelookupbyrow(var_0, var_3, 4)), int(tablelookupbyrow(var_0, var_3, 5)), int(tablelookupbyrow(var_0, var_3, 6)));
    var_4.ignore_spawn_scoring_pois[2] = (int(tablelookupbyrow(var_0, var_3, 7)), int(tablelookupbyrow(var_0, var_3, 8)), int(tablelookupbyrow(var_0, var_3, 9)));
    var_4.ignore_spawn_scoring_pois[3] = (int(tablelookupbyrow(var_0, var_3, 10)), int(tablelookupbyrow(var_0, var_3, 11)), int(tablelookupbyrow(var_0, var_3, 12)));
    var_4.doors = play_sound_countdown(var_0, var_3);
    heli_group_nextspawntime(var_4.doors);
    var_4.debug_reach_icbm_launch = int(tablelookupbyrow(var_0, var_3, 19));
    var_4.debug_reach_pipe_room = int(tablelookupbyrow(var_0, var_3, 20));
    var_4.crates = play_smuggler_arriving_vo(var_4);
    var_4.index = var_2;
    var_4.visited = 0;
    var_4.shouldburnfromdamage = 0;
    var_4.ref_12699 = [];
    ref_12218(var_4.crates);
    var_5 = getdvarint("scr_br_warpDoor_allowIgnores", 1) == 1;
    var_6 = int(tablelookupbyrow(var_0, var_3, 21)) != 0;
    var_7 = var_5 && var_6;

    if(!var_7) {
      level.hud_set_progress[var_2] = var_4;
      var_2++;
    }
  }

  if(!istrue(level.br_circle_disabled)) {
    thread ref_11d01();
    return;
  }
}

function ref_13d00(var_0) {
  var_0.ref_13d02 = 1;

  if(isDefined(var_0.crates) && var_0.crates.size > 0) {
    ref_13d01(var_0);
    return;
  }
}

function play_sound_countdown(var_0, var_1) {
  var_2 = [];
  var_3 = 13;

  while(var_3 <= 18) {
    var_4 = (int(tablelookupbyrow(var_0, var_1, var_3)), int(tablelookupbyrow(var_0, var_1, var_3 + 1)), int(tablelookupbyrow(var_0, var_1, var_3 + 2)));

    if(var_4 == (0, 0, 0)) {} else {
      var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_4, 64, "door");

      if(!isDefined(var_5[0]) || !var_5[0] scriptableisdoor()) {} else {
        var_2 = var_5[0];
      }
    }

    var_3 += 3;
  }

  return var_2;
}

function ref_13626(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.disable_super_in_turret.hoverjet_watchgameend) {
    if(distance2d(var_3.origin, var_0) <= 35) {
      var_1 = easepower("br_control_room_lock_bar", var_3.origin, var_3.angles);
      break;
    }
  }

  return var_1;
}

function ref_13625(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(getdvarint("scr_br_warpDoorKillTrespassers", 1) == 0) {
    return undefined;
  }

  var_1 = var_0.origin + anglestoleft(var_0.angles) * -45 + (0, 0, -40);
  var_2 = spawn("trigger_radius", var_1, 0, 30, 64);
  thread ref_11d00();
  return var_2;
}

function ref_138d8(var_0) {
  if(getdvarint("scr_br_warpDoorKillTrespassers", 1) == 0) {
    return;
  }

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2.vindia_assault3)) {
        var_2.vindia_assault3 delete();
      }
    }

    return;
  }
}

function ref_11d00() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      var_0 dodamage(10000, var_0.origin, self, self, "MOD_TRIGGER_HURT");
    }
  }
}

function heli_group_nextspawntime() {
  var_0 = self;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("lock") != "idle") {
      continue;
    }

    var_0[var_1] setscriptablepartstate("lock", "locked");
    var_0[var_1] scriptabledoorfreeze(1);
    var_0[var_1].ref_1199c = ref_13626(var_0[var_1].origin);
    var_0[var_1].vindia_assault3 = ref_13625(var_0[var_1].ref_1199c);
  }
}

function ref_12122() {
  var_0 = self;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("lock") != "locked") {
      continue;
    }

    var_0[var_1] setscriptablepartstate("lock", "unlocking");
    var_0[var_1] scriptabledoorfreeze(0);

    if(isDefined(var_0[var_1].ref_1199c)) {
      var_0[var_1].ref_1199c freescriptable();
    }
  }
}

function play_smuggler_arriving_vo(var_0) {
  var_1 = canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[0], var_0.debug_reach_pipe_room);
  var_1 = scripts\engine\utility::array_combine_unique(var_1, canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[1], var_0.debug_reach_pipe_room));
  var_1 = scripts\engine\utility::array_combine_unique(var_1, canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[2], var_0.debug_reach_pipe_room));
  var_1 = scripts\engine\utility::array_combine_unique(var_1, canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[3], var_0.debug_reach_pipe_room));

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!uav_dangernotifyplayersinbrrange(var_1[var_2].type)) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_1[var_2]);
      var_2--;
      continue;
    }

    if(abs(var_1[var_2].origin[2] - var_0.debug_reach_icbm_launch) > 3) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_1[var_2]);
      var_2--;
    }
  }

  return var_1;
}

function ref_12218(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("body") != "closed") {
      continue;
    }

    var_0[var_1] setscriptablepartstate("body", "closed_noaudio");
  }
}

function ref_1245b(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("body") != "closed_noaudio") {
      continue;
    }

    var_0[var_1] setscriptablepartstate("body", "set_to_closed");
  }
}

function ref_13d01(var_0) {
  var_1 = scripts\engine\utility::array_randomize(var_0.crates);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3.type != "br_loot_cache_reddoor") {
      var_0.ref_13d03 = scripts\mp\gametypes\br_loot_cache_trapped::ref_136a2(var_3.origin, var_3.angles);
      var_3 setscriptablepartstate("body", "hidden");
      var_0.crates = scripts\engine\utility::array_remove(var_1, var_3);
      var_0.ref_13d03.hud_racetrack_timer = var_0.index;
      return;
    }
  }
}

function uav_dangernotifyplayersinbrrange(var_0) {
  if(var_0 == "br_loot_cache" || var_0 == "br_loot_cache_reddoor" || var_0 == "br_loot_cache_lege") {
    return true;
  }

  return false;
}

function show_regroup_text() {
  foreach(var_1 in level.hud_set_progress) {
    if(!var_1.visited) {
      return false;
    }
  }

  return true;
}

function ref_11b05() {
  self.visited = 1;
}

function ref_11d01() {
  level endon("game_ended");
  level waittill("prematch_done");
  jumpiftrue(isDefined(level.hud_set_progress)) LOC_0000001a;
  return;
}

function ref_1442e(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "warpdoor" && (var_2 == "closed" || var_2 == "trapped_closed") && istrue(var_0.entity.usable)) {
    thread ref_12130();
    return;
  }
}

function ref_1442b(var_0, var_1) {
  var_2 = var_1.ref_121d7;

  if(!istrue(var_2.entity.usable)) {
    return;
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_0.vehicle)) {
    if(getdvarint("scr_br_warpdoor_kill_vehicles", 0) == 0) {
      return;
    }

    var_3 = var_0;

    if(!var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_3 = var_0.vehicle;
    }

    setupprop(var_2, var_3);
    return;
  }

  if(var_1 isinexecutionvictim() || var_1 isinexecutionattack()) {
    return;
  }

  var_4 = var_1.origin - var_3.origin;

  if(vectordot(var_4, anglestoleft(var_3.angles)) < 0) {
    return;
  }

  var_5 = huddopulse(var_1, var_3.ref_14429[0]);
  var_6 = "mp_donetsk_red_door_tunnel";

  if(getdvarint("scr_br_warpDoorHweenEnabled", 0) && veh_updateomnvarsperframeforclient(var_3) && validateplundereventtype(runjoininprogresstimeout(var_3))) {
    var_6 = "mp_donetsk_red_door_ghostface_tunnel";
  }

  thread ref_1386b(var_1, var_5, (0, 90, 0), var_3);

  if(runjoininprogresstimeout(var_3) == 2) {
    if(!isDefined(var_3.ref_13b99)) {
      var_3.ref_13b99 = 0;
    }

    var_3.ref_13b99++;

    if(var_3.ref_13b99 >= 4) {
      var_3.ref_13b99 = 0;
      thread helicleanup();
      return;
    }

    return;
  }
}

function ref_1386b(var_0, var_1, var_2, var_3) {
  var_4 = self;
  level endon("game_ended");
  var_4 endon("death");
  var_4 endon("disconnect");
  thread ref_126ef(var_4);
  ref_12853(var_4, var_3);
  ref_1277f(var_4);
  wait 0.15;
  ref_1277c(var_4, var_3);
  var_4 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
  wait 0.1;

  if(var_4 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_4.vehicle)) {
    var_4 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
    var_4 notify("player_done_warping");
    ref_138f8(var_4);
    return;
  }

  if(isDefined(var_2)) {
    ref_12869(var_2, var_4);
    battle_tracks_updatetogglestate(var_2, var_4);
  }

  var_4 setOrigin(var_0);
  var_4 setplayerangles(var_1);
  wait 4;
  var_4.ref_12a4a = 1;
}

function ref_12869(var_0) {
  var_1 = self;

  if(veh_updateomnvarsperframeforclient(var_1)) {
    var_0 notify("entered_door_in_hallway");
    nuke_vault_key(var_1);
  }

  switch (var_1.launcherfired) {
    case 3:
    case 1:
      ref_138d8(var_1.hoverpos);
      thread ref_1449d(level.hud_set_progress[var_1.hud_racetrack_timer]);
      battle_tracks_updatebattletracksfromplayerdata(level.hud_set_progress[var_1.hud_racetrack_timer], var_0);

      if(!level.hud_set_progress[var_1.hud_racetrack_timer].shouldburnfromdamage) {
        hud_lap_scoreboard(level.hud_set_progress[var_1.hud_racetrack_timer]);
      }

      break;
    case 4:
      break;
    case 2:
      if(isDefined(var_1.setteamhealthhud)) {
        ref_12549(var_0, var_1.setteamhealthhud);
      }

      break;
    case 5:
      break;
  }
}

function ref_12548(var_0) {
  var_1 = self;
  var_1.show_charge = 1;

  if(isDefined(var_0.hud_racetrack_info)) {
    var_1 thread scripts\mp\hud_message::showsplash("br_red_door_control_room_splash", var_0.hud_racetrack_info);
    var_2 = level.hud_set_progress[var_0.hud_racetrack_timer];
    var_3 = var_2.ignore_spawn_scoring_pois[0];
    level thread scripts\mp\gametypes\br_red_door_riddle_event::ref_13871(var_0.hud_racetrack_info, var_3);
    var_4 = relic_grounded_reload_monitor(var_0.hud_racetrack_info);
    scripts\mp\gametypes\br_analytics::dialog_monitor_waitreload(var_1, var_0.entity.doorid, var_4);
    return;
  }
}

function hud_lap_scoreboard() {
  var_0 = self;
  var_0.shouldburnfromdamage = 1;

  if(isDefined(var_0.doors)) {
    ref_12122(var_0.doors);
  }

  ref_1245b(var_0.crates);
  var_0.maxkills = [];
  var_1 = 32;
  var_2 = 64;

  foreach(var_4 in var_0.doors) {
    var_5 = var_4.origin + anglesToForward(var_4.angles) * 26 + (0, 0, 16);
    var_6 = spawn("trigger_radius", var_5, 0, var_1, var_2);
    var_6.door = var_4;
    var_6.hud_racetrack_timer = var_0.index;
    var_6.matchstarttimer_black_screen = var_6.door.angles;
    scripts\mp\utility\trigger::makeenterexittrigger(var_6, &maxelderrank, &maxextractions);
    var_0.maxkills[var_0.maxkills.size] = var_6;
  }

  thread ref_13e21(level);
}

function ref_1449d(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("gas_end");
  var_2 = 1;

  while(var_2) {
    var_3 = var_0 scripts\engine\utility::ref_143af("death", "disconnect", "control_room_exit", "control_room_enter");

    switch (var_3) {
      case "control_room_enter":
        battle_tracks_updatebattletracksfromplayerdata(var_1, var_0);
        break;
      case "control_room_exit":
        ref_12c19(var_1, var_0);
        break;
      case "death":
        ref_12c19(var_1, var_0);
        break;
      case "disconnect":
        var_1.ref_12699 = scripts\engine\utility::array_removeundefined(var_1.ref_12699);
        var_2 = 0;
        break;
      default:
        break;
    }
  }
}

function battle_tracks_updatebattletracksfromplayerdata(var_0) {
  var_1 = self;

  if(!updatefobindanger(var_0)) {
    var_1.ref_12699[var_1.ref_12699.size] = var_0;
    return;
  }
}

function ref_12c19(var_0) {
  var_1 = self;
  var_1.ref_12699 = scripts\engine\utility::array_remove(var_1.ref_12699, var_0);
}

function ref_13e21(var_0) {
  level endon("game_ended");
  var_1 = getdvarfloat("scr_br_warpDoorControlRoomTimeBeforeClosing", 30) * 1000;
  var_2 = getdvarfloat("scr_br_warpDoorCloseRadius", 350);
  var_3 = 1;

  while(var_3) {
    if(var_0.ref_12699.size <= 0 && gettime() - var_0.ref_13b7a > var_1) {
      var_4 = 1;

      foreach(var_6 in var_0.doors) {
        var_7 = var_6.origin;
        var_8 = var_2;
        var_9 = scripts\mp\utility\player::getplayersinradius(var_7, var_8);

        if(var_9.size > 0) {
          var_4 = 0;
        }
      }

      if(var_4) {
        foreach(var_6 in var_0.doors) {
          scripts\mp\equipment\tactical_cover::ref_139f1(var_6.origin);
          latespawnsnatchtoc130(var_6.origin, 75, 0);
        }

        waitframe();

        foreach(var_6 in var_0.doors) {
          var_6 vehicle_getinputvalue();
        }

        wait getdvarfloat("scr_br_warpDoorControlRoomDoorCloseTime", 1.2);

        foreach(var_6 in var_0.doors) {
          var_6 setscriptablepartstate("door", 0);
        }

        var_17 = 1;

        foreach(var_6 in var_0.doors) {
          if(!var_6 scriptabledoorisclosed()) {
            var_17 = 0;
            break;
          }
        }

        if(var_17) {
          foreach(var_6 in var_0.doors) {
            var_6 setscriptablepartstate("lock", "locked");
            var_6 scriptabledoorfreeze(1);
            var_6.ref_1199c = ref_13626(var_6.origin);
          }

          var_3 = 0;
        }
      }
    }

    wait 0.1;
  }
}

function updatefobindanger(var_0) {
  var_1 = self;
  return scripts\engine\utility::array_contains(var_1.ref_12699, var_0);
}

function playac130animinternal(var_0, var_1, var_2) {
  var_3 = self;
  level endon("game_ended");
  var_3 endon("death");
  var_3 endon("disconnect");

  while(!istrue(var_3.ref_12a4a)) {
    waitframe();
  }

  var_3.ref_12a4a = 0;
  var_4 = 7.5;
  var_5 = var_2;
  var_3 scripts\mp\gametypes\br_public::ref_126b9(var_5, var_4);
  var_3 waittill("playerPrestreamComplete");

  if(isDefined(var_0)) {
    var_5 = give_objective_xp_to_all_players(var_3, var_0.ref_14429);
  }

  var_3 setOrigin(var_5);
  waitframe();
  ref_1277e(var_3);
  wait 0.25;
  var_3 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  ref_138f8(var_3);

  if(isDefined(var_0)) {
    switch (var_0.launcherfired) {
      case 1:
        var_6 = ["dx_brm_adl_ready_this_10", "dx_brm_adl_mission_intel_10"];
        var_3 playsoundtoplayer(scripts\engine\utility::random(var_6), var_3);
        ref_12548(var_0);
        break;
      case 3:
        var_7 = ["dx_brm_stc_wrong_travel_10", "dx_brm_stc_wrong_travel_20"];
        var_3 playsoundtoplayer(scripts\engine\utility::random(var_7), var_3);
        ref_12548(var_0);
        break;
      case 4:
        break;
      case 2:
        if(isDefined(var_0.setteamhealthhud)) {
          thread ref_1384f();
        }

        break;
      case 5:
        break;
    }
  }

  var_3 notify("player_done_warping");
}

function ref_126ef(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 playerhide();
  var_1 freezecontrols(1);
  var_1 vehiclepinonminimap(1);
  var_1.validateboltent = 1;

  if(isDefined(var_0)) {
    var_0.ref_1269a[var_1.guid] = var_1;
  }

  var_2 = 7.5;
  var_3 = scripts\engine\utility::ref_143bd(var_2, "player_done_warping", "prematch_end", "warpqueue_done_warping", "death", "disconnect");

  if(isDefined(var_0)) {
    if(var_3 == "disconnect") {
      var_0.ref_1269a = scripts\engine\utility::array_removeundefined(var_0.ref_1269a);
      return;
    } else {
      var_0.ref_1269a = scripts\engine\utility::array_remove(var_0.ref_1269a, var_1);
    }
  }

  var_1 vehiclepinonminimap(0);
  var_1 freezecontrols(0);
  var_1 playershow();
  var_1.validateboltent = undefined;
}

function setupprop(var_0, var_1) {
  var_0.entity.usable = 0;
  var_2 = scripts\cp_mp\vehicles\vehicle::ref_1418f(var_1.vehiclename);

  if(isDefined(var_2)) {
    var_1[[var_2]]();
  }

  wait 2;
  helicleanup(var_0);
  var_0.entity.usable = 1;
}

function ref_12342() {
  var_0 = undefined;

  if(!isDefined(var_0)) {
    var_0 = give_killstreak_airstrike();
  }

  if(show_regroup_text()) {
    heli_go_to_exfil_point();
  }

  return var_0;
}

function heli_go_to_exfil_point() {
  foreach(var_1 in level.audio_start_obj_room_fires) {
    if(runjoininprogresstimeout(var_1) == 2) {
      var_2 = var_1 getscriptablepartstate("warpdoor");

      if(!(var_2 == "open" || var_2 == "opening")) {
        thread heli_goto_pos();
      }
    }
  }
}

function give_killstreak_airstrike() {
  var_0 = 0;
  var_1 = spawnStruct();
  var_2 = level.hud_set_progress;
  var_3 = getdvarint("scr_br_warpDoorVisitPreMatch", 0);

  while(!var_0) {
    if(var_2.size <= 0) {
      return spawnStruct();
    }

    var_4 = randomint(var_2.size);
    var_1 = var_2[var_4];
    var_2 = scripts\engine\utility::array_remove(var_2, var_1);

    if(!var_1.visited) {
      var_0 = 1;
      ref_11b05(level.hud_set_progress[var_1.index]);

      if(!istrue(level.br_circle_disabled) && var_3 == 0) {
        var_0 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_1.ignore_spawn_scoring_pois[0]);
      }
    }
  }

  return level.hud_set_progress[var_1.index];
}

function give_objective_xp_to_all_players(var_0) {
  foreach(var_2 in var_0) {
    if(capsuletracepassed(var_2, 16, 32)) {
      return huddopulse(var_2);
    }
  }

  return huddopulse(var_0[0]);
}

function huddopulse(var_0) {
  if(isDefined(var_0)) {
    return (var_0 + (0, 0, -45));
  }

  return self.origin;
}

function updaterotatedebug(var_0) {
  var_1 = distance2dsquared(scripts\mp\gametypes\br_circle::getdangercircleorigin(), var_0);
  var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius() * scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(var_2 == 0) {
    return false;
  }

  return var_1 > var_2;
}

function ref_14431() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("end_warp_queue");
  jumpiftrue(isDefined(var_0.ref_14430)) LOC_0000002d;
  var_0.ref_14430 = [];

  for(;;) {
    waitframe();

    if(!isDefined(var_0.ref_14430) || var_0.ref_14430.size <= 0) {
      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      continue;
    }

    var_0.tv_station_fastrope_one_infil_rider_start_targetname = 1;
    var_1 = var_0.ref_14430[0];

    if(!isDefined(var_1) || !isalive(var_1)) {
      var_0.ref_14430 = ref_12c1b(var_0, var_1);
      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      var_1 notify("warpqueue_done_warping");
      continue;
    }

    thread playac130animinternal(var_1, var_0, (0, 90, 0));
    var_1 scripts\engine\utility::ref_143a5("player_done_warping", "death");
    var_0.ref_14430 = ref_12c1b(var_0, var_1);
    var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
    var_1 notify("warpqueue_done_warping");
  }
}

function battle_tracks_updatetogglestate(var_0) {
  var_1 = self;

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }

  if(!isDefined(var_1.ref_14430)) {
    var_1.ref_14430 = [];
  }

  if(scripts\engine\utility::array_contains(var_1.ref_14430, var_0)) {
    return;
  }

  var_1.ref_13b7c = gettime();
  var_1.ref_14430[var_1.ref_14430.size] = var_0;
}

function ref_12c1b(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::array_remove(var_1.ref_14430, var_0);
  return var_2;
}

function ref_1338a() {
  var_0 = self;

  if(!isDefined(var_0.ref_14430)) {
    return;
  }

  level endon("game_ended");
  var_0 endon("death");
  wait 0.1;

  while(istrue(var_0.tv_station_fastrope_one_infil_rider_start_targetname)) {
    waitframe();
  }

  var_0 notify("end_warp_queue");
  var_0.ref_14430 = undefined;
  var_0.ref_1442f = undefined;
}

function wp_watchforsmokedisowned(var_0, var_1) {
  var_2 = level.hud_set_progress[var_1];
  var_0.hud_racetrack_info = var_2.id;
  var_0.ref_14429 = var_2.ignore_spawn_scoring_pois;
  var_0.hoverpos = var_2.doors;
  var_0.crates = var_2.crates;
  var_0.hud_racetrack_timer = var_2.index;

  if(!isDefined(var_0.ref_14429)) {
    var_0.ref_14429 = [];

    if(level.mapname == "mp_br_mechanics") {
      var_0.ref_14429[0] = (3307, -2480, 64);
    } else {
      var_3 = risktokencountroll();
      var_0.ref_14429[0] = var_3;
      var_0.ref_1442f = 1;
    }
  }

  var_2.ref_13b7a = gettime();
  return var_2;
}

function maxelderrank(var_0, var_1) {
  if(!isDefined(var_1.linkedto)) {
    var_2 = level.hud_set_progress[var_1.hud_racetrack_timer];
    var_3 = var_0.origin - var_1.origin;
    var_4 = anglestoleft(var_1.matchstarttimer_black_screen);

    if(updatefobindanger(var_2, var_0)) {
      if(vectordot(var_3, var_4) > 0) {
        var_1.linkedto = var_4;
        return;
      }

      var_1.linkedto = -1 * var_4;
      return;
    }

    if(vectordot(var_3, var_4) > 0) {
      var_1.linkedto = -1 * var_4;
      return;
    }

    var_1.linkedto = var_4;
    return;
  }
}

function maxextractions(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_3 = anglestoleft(var_1.matchstarttimer_black_screen);

  if(vectordot(var_1.linkedto, var_2) > 0) {
    var_0 notify("control_room_enter");
    return;
  }

  var_0 notify("control_room_exit");
}

function wp_watchgameend(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.ref_1442a.size; var_2++) {
    if(!istrue(level.ref_1442a[var_2].inuse)) {
      level.ref_1442a[var_2].inuse = 1;
      var_1 = 1;
      break;
    }
  }

  if(!var_1) {
    var_2 = undefined;
  }

  var_0.setteamhealthhud = var_2;

  if(isDefined(var_0.setteamhealthhud)) {
    var_0.ref_14429 = [level.ref_1442a[var_2].ignore_spawn_scoring_pois[0]];
    level.ref_1442a[var_2].maxagents = [];
    var_3 = [0, 1, 2, 3, 4, 5];
    var_3 = scripts\engine\utility::array_randomize(var_3);
    var_4 = 0;
    var_5 = ref_12342();

    for(var_6 = 0; var_6 < 4; var_6++) {
      var_7 = var_3[var_6];
      var_8 = level.ref_1442a[var_2].maxcastsperframe[var_7].origin;
      var_9 = level.ref_1442a[var_2].maxcastsperframe[var_7].angles;
      var_10 = ref_136af(var_8, var_9);
      var_11 = relic_nuketimer_waitforobjectives(var_10);

      switch (var_6) {
        case 0:
          ref_13288(var_11, 1);
          var_11.hud_racetrack_timer = var_5.index;
          var_11.setteamhealthhud = var_2;
          break;
        case 2:
        case 1:
          ref_13288(var_11, 3);
          var_11.hud_racetrack_timer = var_5.index;
          var_11.setteamhealthhud = var_2;
          break;
        case 3:
          ref_13288(var_11, 4);
          var_11.setteamhealthhud = var_2;
          break;
        default:
          ref_13288(var_11, 4);
          var_11.setteamhealthhud = var_2;
          break;
      }

      level.ref_1442a[var_2].maxagents[level.ref_1442a[var_2].maxagents.size] = var_10;
    }

    thread ref_144dd(level, var_2);
    return;
  }

  var_12 = risktokencountroll();
  var_0.ref_14429 = [var_12];
  var_0.ref_1442f = 1;
}

function veh_updateomnvarsperframeforclient(var_0) {
  if(isDefined(var_0.setteamhealthhud) && var_0.launcherfired != 2) {
    return true;
  }

  return false;
}

function risktokencountroll() {
  var_0 = undefined;

  if(level.br_circle_disabled) {
    var_0 = scripts\mp\gametypes\br_circle::getrandompointincircle((0, 0, 0), getdvarfloat("scr_br_warpDoorFallbackRandomCircleRadius", 20000));
  } else {
    var_0 = scripts\mp\gametypes\br_circle::risk_modifyflagstieronrespawn();
  }

  var_1 = scripts\mp\gametypes\br_c130::relic_ammo_drain_take_ammo();
  return (var_0[0], var_0[1], var_1);
}

function wp_watchplanedisowned(var_0) {
  var_1 = undefined;

  if(getdvarint("scr_br_warpDoorHotDropEnabled", 1) != 0) {
    var_1 = scripts\mp\gametypes\br_circle::relic_focusfire_modifyplayerdamage(getdvarint("scr_br_warpDoorHotdropClusters", 6));
  }

  if(!isDefined(var_1) || isDefined(var_1) && updaterotatedebug(var_1)) {
    var_1 = risktokencountroll();
  }

  var_2 = scripts\mp\gametypes\br_c130::relic_ammo_drain_take_ammo();
  var_0.ref_14429 = [(var_1[0], var_1[1], var_2)];
  var_0.ref_1442f = 1;
}

function wrapindex(var_0, var_1) {
  var_2 = var_1.origin;
  var_3 = scripts\mp\gametypes\br_c130::relic_ammo_drain_take_ammo();
  var_0.ref_14429 = [(var_2[0], var_2[1], var_3)];
  var_0.ref_1442f = 1;
}

function ref_12130() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("warpdoor_close");
  var_0.entity endon("warpdoor_despawn");
  var_0.ref_1269a = [];

  if(unload_vehicles_on_weapons_free_thread(var_0)) {
    var_0 setscriptablepartstate("warpdoor", "trapped_opening");
  } else {
    var_0 setscriptablepartstate("warpdoor", "opening");
  }

  var_0 notify("warpdoor_open");

  if(getdvarint("scr_br_warpDoorHweenEnabled", 0) && veh_updateomnvarsperframeforclient(var_0)) {
    ref_1277d(var_0);
  }

  switch (var_0.launcherfired) {
    case 3:
    case 1:
      if(!isDefined(var_0.hud_racetrack_timer)) {
        var_1 = ref_12342();

        if(!isDefined(var_1.index)) {
          var_0.launcherfired = 4;
          wp_watchplanedisowned(var_0);
          break;
        }

        <
        error > .hud_racetrack_timer = var_0.index;
      }

      wp_watchforsmokedisowned( < error > , < error > .hud_racetrack_timer);
      break;
    case 4:
      wp_watchplanedisowned( < error > );
      break;
    case 5:
      var_4 = scripts\mp\gametypes\br_numbers_tower::propheight();

      if(isDefined(var_4)) {
        wrapindex( < error > , var_4);
        thread ref_13c64();
        break;
      }
    case 2:
      wp_watchgameend( < error > );
      thread ref_13c64();
      break;
  }

  wait 1;
  var_5 = < error > .origin + anglestoleft( < error > .angles) * 15 + anglesToForward( < error > .angles) * 26 + (0, 0, 16); <
  error > .ref_14432 = spawn("trigger_radius", var_5, 0, 25, 32); <
  error > .ref_14432.ref_121d7 = < error > ;
  scripts\mp\utility\trigger::makeenterexittrigger( < error > .ref_14432, &ref_1442b, undefined);
  thread ref_14431();
}

function ref_13c64() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("warpdoor_close");
  var_0.entity endon("warpdoor_despawn");
  var_0.ref_13b81 = gettime();
  var_0.ref_13b7c = undefined;

  for(;;) {
    if(isDefined(var_0.ref_13b7c) && (gettime() - var_0.ref_13b7c) / 1000 >= getdvarint("scr_br_warpDoorInactiveTime", 10)) {
      thread helicleanup(var_0);
      return;
    }

    if((gettime() - var_0.ref_13b81) / 1000 >= getdvarint("scr_br_warpDoorMaxOpenTime", 30)) {
      thread helicleanup(var_0);
      return;
    }

    wait 1;
  }
}

function validateplundereventtype(var_0) {
  return var_0 == 3 || var_0 == 4;
}

function unload_vehicles_on_weapons_free_thread() {
  var_0 = relic_nuketimer_waitforobjectives();

  if(isDefined(var_0.launcherfired)) {
    return validateplundereventtype(var_0.launcherfired);
  }

  return false;
}

function helicleanup(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("warpdoor_open");

  if(isDefined(var_1.ref_14432)) {
    var_1.ref_14432 delete();
  }

  var_1.ref_13b99 = 0;

  if(unload_vehicles_on_weapons_free_thread(var_1)) {
    var_1 setscriptablepartstate("warpdoor", "trapped_closing");
  } else {
    var_1 setscriptablepartstate("warpdoor", "closing");
  }

  var_1.entity.usable = 0;

  while(var_1.ref_1269a.size != 0) {
    wait 0.1;
  }

  var_1.entity.usable = 1;
  var_1.setteamhealthhud = undefined;
  var_1 notify("warpdoor_close");
  thread ref_1338a();

  if(isDefined(level.hud_set_progress) && show_regroup_text() && runjoininprogresstimeout(var_1) == 2) {
    thread heli_goto_pos();
    return;
  }
}

function ref_1449b() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("warpdoor_open");
  var_0.entity endon("warpdoor_despawn");
  var_0 waittill("end_warp_queue");
  wait 5;
  thread latetoinfil();
}

function unload_type() {
  var_0 = self getscriptablepartstate("warpdoor");
  return var_0 == "open" || var_0 == "opening" || var_0 == "trapped_open" || var_0 == "trapped_opening";
}

function heli_goto_pos() {
  var_0 = self;

  if(!isDefined(var_0.entity)) {
    var_0 = var_0 getlinkedscriptableinstance();
  }

  level endon("game_ended");
  var_0 endon("death");
  var_0.entity endon("warpdoor_despawn");
  var_0.entity.usable = 0;

  if(unload_type(var_0)) {
    helicleanup(var_0);
  }

  while(!(var_0 getscriptablepartstate("warpdoor") == "closed" || var_0 getscriptablepartstate("warpdoor") == "trapped_closed")) {
    waitframe();
  }

  wait 1;
  thread latetoinfil();
}

function ref_1449a() {
  var_0 = self;
  var_1 = var_0 getlinkedscriptableinstance();
  level endon("game_ended");
  var_0 endon("death");
  var_1 endon("death");
  wait 5;

  if(var_1.launcherfired != 2) {
    return;
  }

  while(!updaterotatedebug(var_0.origin)) {
    wait 1;
  }

  heli_goto_pos(var_0);
}

function zombieregendelayscaleoutgas() {
  level endon("game_ended");

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  while(!isDefined(level.disable_super_in_turret)) {
    waitframe();
  }

  var_0 = "mp/warpdoor_hallway_locations.csv";
  var_1 = tablelookupgetnumrows(var_0);
  level.ref_1442a = [];

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = spawnStruct();
    var_4 = var_2;
    var_3.id = int(tablelookupbyrow(var_0, var_4, 0));
    var_3.ignore_spawn_scoring_pois = [];
    var_3.ignore_spawn_scoring_pois[0] = (int(tablelookupbyrow(var_0, var_4, 1)), int(tablelookupbyrow(var_0, var_4, 2)), int(tablelookupbyrow(var_0, var_4, 3)));
    var_3.inuse = 0;
    var_3.ref_126be = [];
    var_3.maxcastsperframe = remove_flag_trigs(var_3.ignore_spawn_scoring_pois[0]);
    level.ref_1442a[level.ref_1442a.size] = var_3;
  }
}

function remove_flag_trigs(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray("hallway_door_spawn", "targetname");

  foreach(var_4 in var_2) {
    if(abs(var_0[0] - var_4.origin[0]) <= 500) {
      var_1 = var_4;
    }
  }

  return var_1;
}

function unset_relic_no_ammo_mun() {
  if(!isDefined(level.ref_1442a)) {
    return false;
  }

  foreach(var_1 in level.ref_1442a) {
    if(var_1.inuse) {
      return false;
    }
  }

  return true;
}

function ref_12549(var_0) {
  var_1 = self;
  var_1.unset_relic_thirdperson = 1;
  var_2 = getdvarint("scr_br_warpDoorAllowKillstreaksInHallway", 0) != 0;

  if(!var_2) {
    var_1 scripts\common\utility::allow_killstreaks(0);
    var_1 disableoffhandweapons();
  }

  level.ref_1442a[var_0].ref_126be[level.ref_1442a[var_0].ref_126be.size] = var_1;
  thread ref_11d19(var_1);
}

function ref_144dd(var_0, var_1) {
  level endon("game_ended");
  var_1 waittill("warpdoor_close");
  wait 3;

  while(level.ref_1442a[var_0].ref_126be.size != 0) {
    wait 1;
  }

  ref_13389(var_0);
}

function mark_coop_bomb_defusal_ended() {
  var_0 = self;

  if(istrue(var_0.validateboltent)) {
    return;
  }

  var_0 notify("mental_break");
  var_1 = risktokencountroll();
  var_2 = var_1;
  thread ref_1386b(var_0, var_2, var_0.angles, undefined);
  thread playac130animinternal(var_0, undefined, var_0.angles);
}

function ref_11d19(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_2 = scripts\engine\utility::ref_143af("entered_door_in_hallway", "death", "mental_break", "disconnect");

  if(var_2 == "disconnect") {
    level.ref_1442a[var_0].ref_126be = scripts\engine\utility::array_removeundefined(level.ref_1442a[var_0].ref_126be);
    return;
  }

  level.ref_1442a[var_0].ref_126be = scripts\engine\utility::array_remove(level.ref_1442a[var_0].ref_126be, var_1);
  var_1.unset_relic_thirdperson = 0;
  var_3 = getdvarint("scr_br_warpDoorAllowKillstreaksInHallway", 0) != 0;

  if(!var_3) {
    var_1 scripts\common\utility::allow_killstreaks(1);
    var_1 enableoffhandweapons();
  }

  var_1 notify("leave_hallway");
}

function ref_1384f() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("entered_door_in_hallway");
  var_0 endon("death");
  var_0 endon("leave_hallway");
  var_1 = getdvarint("scr_br_warpDoorHallwayTimeout", 20);
  var_2 = getdvarint("scr_br_warpDoorHallwayCountdownStart", 5);
  wait var_1 - var_2;

  for(var_3 = var_2; var_3 >= 0; var_3--) {
    var_4 = "dx_brm_stc_numbers_";
    var_4 += var_3;
    var_4 += "_10";
    var_0 playsoundtoplayer(var_4, var_0);
    wait 1;
  }

  mark_coop_bomb_defusal_ended(var_0);
}

function ref_13389(var_0) {
  wait 7.5;

  foreach(var_2 in level.ref_1442a[var_0].maxagents) {
    thread heli_goto_pos();
  }

  wait 3;
  var_4 = level.ref_1442a[var_0].ignore_spawn_scoring_pois[0];
  var_5 = getdvarfloat("scr_br_warpDoorCleanupRadius", 500);
  latespawnsnatchtoc130(var_4, var_5, getdvarint("scr_br_warpDoorKillPlayerOnEntityCleanup", 1));
  level.ref_1442a[var_0].ref_126be = [];
  level.ref_1442a[var_0].inuse = 0;
}

function latespawnsnatchtoc130(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::sphere_trace_get_all_results(var_0, var_0, var_1, undefined, undefined, 0, 1);

  for(var_4 = 0; var_4 < var_3.size - 1; var_4++) {
    var_5 = var_3[var_4]["entity"];

    if(isDefined(var_5)) {
      if(isPlayer(var_5) && (!var_2 || istrue(var_5.validateboltent))) {
        continue;
      }

      var_5 dodamage(15000, var_5.origin, var_5, undefined, "MOD_EXPLOSIVE");
    }
  }
}

function nuke_vault_key(var_0) {
  if(isDefined(var_0.hud_racetrack_timer)) {
    var_1 = level.hud_set_progress[var_0.hud_racetrack_timer];

    if(var_1.shouldburnfromdamage) {
      return;
    }
  }

  var_2 = level.ref_1442a[var_0.setteamhealthhud];

  switch (var_0.launcherfired) {
    case 1:
      foreach(var_4 in var_2.maxagents) {
        if(relic_nuketimer_waitforobjectives(var_4) != var_0) {
          ref_13288(var_4, 4);
          wp_watchplanedisowned(relic_nuketimer_waitforobjectives(var_4));
        }
      }

      break;
    case 3:
      var_1 = level.hud_set_progress[var_0.hud_racetrack_timer];
      ref_13d00(var_1);

      foreach(var_4 in var_2.maxagents) {
        if(runjoininprogresstimeout(var_4) == 1) {
          ref_13288(var_4, 3);
        }
      }

      break;
  }
}

function ref_12853(var_0) {
  var_1 = self;
  var_1 skydive_cutparachuteon(var_0);
  var_1 setclientomnvar("ui_br_bink_overlay_state", 10);
}

function ref_1277c(var_0) {
  var_1 = self;
  var_1 preloadcinematicforplayer(var_0);
}

function ref_138f8() {
  var_0 = self;
  var_0 setclientomnvar("ui_br_bink_overlay_state", 0);
  var_0 skydive_cutparachuteoff();
}

function ref_1277f() {
  var_0 = self;
  playFX(level._effect["warp_door_out"], var_0.origin);
}

function ref_1277e() {
  var_0 = self;
  playFX(level._effect["warp_door_in"], var_0.origin);
}

function ref_1277d() {
  var_0 = self;
  var_1 = randomint(4);
  var_2 = "warp_door_hween_";

  switch (var_1) {
    case 0:
      var_2 += "bats";
      break;
    case 1:
      var_2 += "footprints";
      break;
    case 2:
      var_2 += "ghost";
      break;
    case 3:
      var_2 += "skelhand";
      break;
    default:
      var_2 += "bats";
      break;
  }

  playFX(level._effect[var_2], var_0.origin, anglesToForward(var_0.angles));
}

function relic_grounded_reload_monitor(var_0) {
  var_1 = "";

  if(var_0 < 10) {
    var_1 = "0";
  }

  var_2 = "MP_DONETSK/CALLOUT_RED_DOOR_CONTROL_ROOM_" + var_1 + var_0;
  return var_2;
}
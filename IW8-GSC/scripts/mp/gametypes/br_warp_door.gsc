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

function ref_136af(var0, var1, var2) {
  if(!get_bulletwhizby_alias()) {
    return;
  }

  var3 = spawn("script_model", var0);
  var3 setModel("t9_vnm_door_bunker_metal_01_rig");
  var3.angles = var1;
  var3.usable = 1;
  cargobaywatch(var3);

  if(getdvarint("scr_br_warpDoorHallwayEnabled", 1)) {
    ref_13288(var3, 2);
  } else {
    ref_13288(var3, 1);
  }

  if(isDefined(var2)) {
    var3.doorid = var2;
  }

  level.audio_start_obj_room_fires[level.audio_start_obj_room_fires.size] = var3;

  if(!istrue(level.br_circle_disabled)) {
    thread ref_1449a();
  }

  return var3;
}

function ref_13288(var0) {
  var1 = relic_nuketimer_waitforobjectives();
  var2 = "";

  if(isDefined(var1.launcherfired)) {
    var2 = var1 getscriptablepartstate("warpdoor");

    if(validateplundereventtype(var1.launcherfired)) {
      var2 = getsubstr(var2, 8, var2.size);
    }
  } else {
    var2 = "closed";
  }

  var3 = var2;
  var1.launcherfired = var0;

  if(validateplundereventtype(var1.launcherfired)) {
    var3 = "trapped_" + var2;
  }

  if(var1.launcherfired != 2 && !isDefined(var1.ref_13a98)) {
    thread ref_136a0(var1);
  }

  var1 setscriptablepartstate("warpdoor", var3);
}

function ref_13289() {
  ref_13288(5);
}

function ref_136a0(var0) {
  level endon("game_ended");
  var0 endon("death");
  wait 0.2;
  var1 = var0.origin + anglestoleft(var0.angles) * 25 + anglesToForward(var0.angles) * -5 + (0, 0, 16);
  var0.ref_13a98 = spawn("trigger_radius", var1, 0, 16, 32);
  var0.ref_13a98.ref_121d7 = var0;
  scripts\mp\utility\trigger::makeenterexittrigger(var0.ref_13a98, &ref_13a99, undefined);
}

function ref_13a99(var0, var1) {
  if(isDefined(var1.should_wait_before_spawn_chopper_boss)) {
    return;
  }

  var2 = ["dx_brm_adl_door_open_10", "dx_brm_adl_door_secrets_10", "dx_brm_adl_job_got_10", "dx_brm_adl_ready_this_10"];
  var3 = ["dx_brm_stc_correct_alive_10", "dx_brm_stc_correct_quit_10", "dx_brm_stc_danger_change_10", "dx_brm_stc_danger_choice_10", "dx_brm_stc_muffled_come_10", "dx_brm_stc_muffled_open_10", "dx_brm_stc_muffled_secrets_10"];
  var1.should_wait_before_spawn_chopper_boss = 1;

  if(unload_vehicles_on_weapons_free_thread(var1.ref_121d7)) {
    playsoundatpos(var1.origin, scripts\engine\utility::random(var3));
    return;
  }

  playsoundatpos(var1.origin, scripts\engine\utility::random(var2));
}

function runjoininprogresstimeout() {
  return relic_nuketimer_waitforobjectives().launcherfired;
}

function relic_nuketimer_waitforobjectives() {
  var0 = self;

  if(!isDefined(var0.entity)) {
    var0 = var0 getlinkedscriptableinstance();
  }

  return var0;
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
  var0 = self;

  if(!isDefined(var0.ref_14728)) {
    var0.ref_14728 = "none";
  }

  var1 = getdvarint("scr_br_warpDoorWeekID", 0);
  var2 = level.ref_145a7[var1];
  var3 = var2[0];

  for(var4 = 1; var4 < var2.size; var4++) {
    var5 = var2[var4];

    if(var5 == var0.ref_14728) {
      if(randomfloat(1) > var3) {
        return false;
      }

      return true;
    }
  }

  return false;
}

function latetoinfil() {
  var0 = self;
  level endon("game_ended");

  if(!isDefined(var0) || istrue(var0.dead)) {
    return;
  }

  var0.dead = 1;

  while(istrue(var0.tv_station_fastrope_one_infil_rider_start_targetname)) {
    waitframe();
  }

  if(isDefined(var0.ref_13a98)) {
    var0.ref_13a98 delete();
  }

  var0 notify("end_warp_queue");
  var0.entity.usable = 0;
  var0.entity notify("warpdoor_despawn");
  level.audio_start_obj_room_fires = scripts\engine\utility::array_remove(level.audio_start_obj_room_fires, var0 getscriptablelinkedentity());
  var0 setscriptablepartstate("warpdoor", "dying");

  while(var0 getscriptablepartstate("warpdoor") != "dead") {
    waitframe();
  }

  var0 getscriptablelinkedentity() delete();
}

function ref_136b0() {
  level endon("game_ended");
  level waittill("prematch_done");
  wait 5;
  scripts\mp\gametypes\red_door_locations::traceresults();
  ref_13281();

  foreach(var1 in level.disable_super_in_turret.ref_1442c) {
    var2 = ref_136af(var1.origin, var1.angles, var1.id);

    if(!unset_vehicle_only_wave(var2)) {
      var2 = var2 getlinkedscriptableinstance();
      latetoinfil(var2);
    }
  }

  if(isDefined(level.ref_1442d)) {
    level thread[[level.ref_1442d]]();
    return;
  }
}

function cargobaywatch() {
  var0 = self;

  if(!isDefined(level.calloutglobals.calloutzones)) {
    level.calloutglobals.calloutzones = getEntArray("location_volume", "targetname");
  }

  if(!level.calloutglobals.calloutzones.size) {
    return;
  }

  var1 = var0 getscriptablelinkedentity();

  foreach(var3 in level.calloutglobals.calloutzones) {
    if(var1 istouching(var3)) {
      var0.ref_14728 = var3.script_noteworthy;
      return;
    }
  }

  var0.ref_14728 = "none";
}

function initdropbagvo() {
  var0 = "mp/warpdoor_controlroom_locations.csv";
  var1 = tablelookupgetnumrows(var0);

  for(var2 = 0; var2 < var1; var2++) {
    var3 = [];
    var3 = (int(tablelookupbyrow(var0, var2, 1)), int(tablelookupbyrow(var0, var2, 2)), int(tablelookupbyrow(var0, var2, 3)));
    var3 = (int(tablelookupbyrow(var0, var2, 4)), int(tablelookupbyrow(var0, var2, 5)), int(tablelookupbyrow(var0, var2, 6)));
    var3 = (int(tablelookupbyrow(var0, var2, 7)), int(tablelookupbyrow(var0, var2, 8)), int(tablelookupbyrow(var0, var2, 9)));
    var3 = (int(tablelookupbyrow(var0, var2, 10)), int(tablelookupbyrow(var0, var2, 11)), int(tablelookupbyrow(var0, var2, 12)));

    foreach(var5 in var3) {
      var6 = 500;
      scripts\mp\gametypes\br_bunker_utility::little_bird_mg_playercontrolmg(var5, var6);
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

  var0 = "mp/warpdoor_controlroom_locations.csv";
  var1 = tablelookupgetnumrows(var0);
  level.hud_set_progress = [];
  scripts\mp\gametypes\red_door_locations::teleport_reference_juggmaze();
  var2 = 0;

  for(var3 = 0; var3 < var1; var3++) {
    var4 = spawnStruct();
    var4.id = int(tablelookupbyrow(var0, var3, 0));
    var4.ignore_spawn_scoring_pois = [];
    var4.ignore_spawn_scoring_pois[0] = (int(tablelookupbyrow(var0, var3, 1)), int(tablelookupbyrow(var0, var3, 2)), int(tablelookupbyrow(var0, var3, 3)));
    var4.ignore_spawn_scoring_pois[1] = (int(tablelookupbyrow(var0, var3, 4)), int(tablelookupbyrow(var0, var3, 5)), int(tablelookupbyrow(var0, var3, 6)));
    var4.ignore_spawn_scoring_pois[2] = (int(tablelookupbyrow(var0, var3, 7)), int(tablelookupbyrow(var0, var3, 8)), int(tablelookupbyrow(var0, var3, 9)));
    var4.ignore_spawn_scoring_pois[3] = (int(tablelookupbyrow(var0, var3, 10)), int(tablelookupbyrow(var0, var3, 11)), int(tablelookupbyrow(var0, var3, 12)));
    var4.doors = play_sound_countdown(var0, var3);
    heli_group_nextspawntime(var4.doors);
    var4.debug_reach_icbm_launch = int(tablelookupbyrow(var0, var3, 19));
    var4.debug_reach_pipe_room = int(tablelookupbyrow(var0, var3, 20));
    var4.crates = play_smuggler_arriving_vo(var4);
    var4.index = var2;
    var4.visited = 0;
    var4.shouldburnfromdamage = 0;
    var4.ref_12699 = [];
    ref_12218(var4.crates);
    var5 = getdvarint("scr_br_warpDoor_allowIgnores", 1) == 1;
    var6 = int(tablelookupbyrow(var0, var3, 21)) != 0;
    var7 = var5 && var6;

    if(!var7) {
      level.hud_set_progress[var2] = var4;
      var2++;
    }
  }

  if(!istrue(level.br_circle_disabled)) {
    thread ref_11d01();
    return;
  }
}

function ref_13d00(var0) {
  var0.ref_13d02 = 1;

  if(isDefined(var0.crates) && var0.crates.size > 0) {
    ref_13d01(var0);
    return;
  }
}

function play_sound_countdown(var0, var1) {
  var2 = [];
  var3 = 13;

  while(var3 <= 18) {
    var4 = (int(tablelookupbyrow(var0, var1, var3)), int(tablelookupbyrow(var0, var1, var3 + 1)), int(tablelookupbyrow(var0, var1, var3 + 2)));

    if(var4 == (0, 0, 0)) {} else {
      var5 = getentitylessscriptablearrayinradius(undefined, undefined, var4, 64, "door");

      if(!isDefined(var5[0]) || !var5[0] scriptableisdoor()) {} else {
        var2 = var5[0];
      }
    }

    var3 += 3;
  }

  return var2;
}

function ref_13626(var0) {
  var1 = undefined;

  foreach(var3 in level.disable_super_in_turret.hoverjet_watchgameend) {
    if(distance2d(var3.origin, var0) <= 35) {
      var1 = easepower("br_control_room_lock_bar", var3.origin, var3.angles);
      break;
    }
  }

  return var1;
}

function ref_13625(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  if(getdvarint("scr_br_warpDoorKillTrespassers", 1) == 0) {
    return undefined;
  }

  var1 = var0.origin + anglestoleft(var0.angles) * -45 + (0, 0, -40);
  var2 = spawn("trigger_radius", var1, 0, 30, 64);
  thread ref_11d00();
  return var2;
}

function ref_138d8(var0) {
  if(getdvarint("scr_br_warpDoorKillTrespassers", 1) == 0) {
    return;
  }

  if(isDefined(var0)) {
    foreach(var2 in var0) {
      if(isDefined(var2.vindia_assault3)) {
        var2.vindia_assault3 delete();
      }
    }

    return;
  }
}

function ref_11d00() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(isPlayer(var0)) {
      var0 dodamage(10000, var0.origin, self, self, "MOD_TRIGGER_HURT");
    }
  }
}

function heli_group_nextspawntime() {
  var0 = self;

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1] getscriptablepartstate("lock") != "idle") {
      continue;
    }

    var0[var1] setscriptablepartstate("lock", "locked");
    var0[var1] scriptabledoorfreeze(1);
    var0[var1].ref_1199c = ref_13626(var0[var1].origin);
    var0[var1].vindia_assault3 = ref_13625(var0[var1].ref_1199c);
  }
}

function ref_12122() {
  var0 = self;

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1] getscriptablepartstate("lock") != "locked") {
      continue;
    }

    var0[var1] setscriptablepartstate("lock", "unlocking");
    var0[var1] scriptabledoorfreeze(0);

    if(isDefined(var0[var1].ref_1199c)) {
      var0[var1].ref_1199c freescriptable();
    }
  }
}

function play_smuggler_arriving_vo(var0) {
  var1 = canceljoins(undefined, undefined, var0.ignore_spawn_scoring_pois[0], var0.debug_reach_pipe_room);
  var1 = scripts\engine\utility::array_combine_unique(var1, canceljoins(undefined, undefined, var0.ignore_spawn_scoring_pois[1], var0.debug_reach_pipe_room));
  var1 = scripts\engine\utility::array_combine_unique(var1, canceljoins(undefined, undefined, var0.ignore_spawn_scoring_pois[2], var0.debug_reach_pipe_room));
  var1 = scripts\engine\utility::array_combine_unique(var1, canceljoins(undefined, undefined, var0.ignore_spawn_scoring_pois[3], var0.debug_reach_pipe_room));

  for(var2 = 0; var2 < var1.size; var2++) {
    if(!uav_dangernotifyplayersinbrrange(var1[var2].type)) {
      var1 = scripts\engine\utility::array_remove(var1, var1[var2]);
      var2--;
      continue;
    }

    if(abs(var1[var2].origin[2] - var0.debug_reach_icbm_launch) > 3) {
      var1 = scripts\engine\utility::array_remove(var1, var1[var2]);
      var2--;
    }
  }

  return var1;
}

function ref_12218(var0) {
  if(!isDefined(var0)) {
    return;
  }

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1] getscriptablepartstate("body") != "closed") {
      continue;
    }

    var0[var1] setscriptablepartstate("body", "closed_noaudio");
  }
}

function ref_1245b(var0) {
  if(!isDefined(var0)) {
    return;
  }

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1] getscriptablepartstate("body") != "closed_noaudio") {
      continue;
    }

    var0[var1] setscriptablepartstate("body", "set_to_closed");
  }
}

function ref_13d01(var0) {
  var1 = scripts\engine\utility::array_randomize(var0.crates);

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(var3.type != "br_loot_cache_reddoor") {
      var0.ref_13d03 = scripts\mp\gametypes\br_loot_cache_trapped::ref_136a2(var3.origin, var3.angles);
      var3 setscriptablepartstate("body", "hidden");
      var0.crates = scripts\engine\utility::array_remove(var1, var3);
      var0.ref_13d03.hud_racetrack_timer = var0.index;
      return;
    }
  }
}

function uav_dangernotifyplayersinbrrange(var0) {
  if(var0 == "br_loot_cache" || var0 == "br_loot_cache_reddoor" || var0 == "br_loot_cache_lege") {
    return true;
  }

  return false;
}

function show_regroup_text() {
  foreach(var1 in level.hud_set_progress) {
    if(!var1.visited) {
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

function ref_1442e(var0, var1, var2, var3, var4) {
  if(var1 == "warpdoor" && (var2 == "closed" || var2 == "trapped_closed") && istrue(var0.entity.usable)) {
    thread ref_12130();
    return;
  }
}

function ref_1442b(var0, var1) {
  var2 = var1.ref_121d7;

  if(!istrue(var2.entity.usable)) {
    return;
  }

  if(var0 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var0.vehicle)) {
    if(getdvarint("scr_br_warpdoor_kill_vehicles", 0) == 0) {
      return;
    }

    var3 = var0;

    if(!var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var3 = var0.vehicle;
    }

    setupprop(var2, var3);
    return;
  }

  if(var1 isinexecutionvictim() || var1 isinexecutionattack()) {
    return;
  }

  var4 = var1.origin - var3.origin;

  if(vectordot(var4, anglestoleft(var3.angles)) < 0) {
    return;
  }

  var5 = huddopulse(var1, var3.ref_14429[0]);
  var6 = "mp_donetsk_red_door_tunnel";

  if(getdvarint("scr_br_warpDoorHweenEnabled", 0) && veh_updateomnvarsperframeforclient(var3) && validateplundereventtype(runjoininprogresstimeout(var3))) {
    var6 = "mp_donetsk_red_door_ghostface_tunnel";
  }

  thread ref_1386b(var1, var5, (0, 90, 0), var3);

  if(runjoininprogresstimeout(var3) == 2) {
    if(!isDefined(var3.ref_13b99)) {
      var3.ref_13b99 = 0;
    }

    var3.ref_13b99++;

    if(var3.ref_13b99 >= 4) {
      var3.ref_13b99 = 0;
      thread helicleanup();
      return;
    }

    return;
  }
}

function ref_1386b(var0, var1, var2, var3) {
  var4 = self;
  level endon("game_ended");
  var4 endon("death");
  var4 endon("disconnect");
  thread ref_126ef(var4);
  ref_12853(var4, var3);
  ref_1277f(var4);
  wait 0.15;
  ref_1277c(var4, var3);
  var4 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
  wait 0.1;

  if(var4 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var4.vehicle)) {
    var4 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
    var4 notify("player_done_warping");
    ref_138f8(var4);
    return;
  }

  if(isDefined(var2)) {
    ref_12869(var2, var4);
    battle_tracks_updatetogglestate(var2, var4);
  }

  var4 setOrigin(var0);
  var4 setplayerangles(var1);
  wait 4;
  var4.ref_12a4a = 1;
}

function ref_12869(var0) {
  var1 = self;

  if(veh_updateomnvarsperframeforclient(var1)) {
    var0 notify("entered_door_in_hallway");
    nuke_vault_key(var1);
  }

  switch (var1.launcherfired) {
    case 3:
    case 1:
      ref_138d8(var1.hoverpos);
      thread ref_1449d(level.hud_set_progress[var1.hud_racetrack_timer]);
      battle_tracks_updatebattletracksfromplayerdata(level.hud_set_progress[var1.hud_racetrack_timer], var0);

      if(!level.hud_set_progress[var1.hud_racetrack_timer].shouldburnfromdamage) {
        hud_lap_scoreboard(level.hud_set_progress[var1.hud_racetrack_timer]);
      }

      break;
    case 4:
      break;
    case 2:
      if(isDefined(var1.setteamhealthhud)) {
        ref_12549(var0, var1.setteamhealthhud);
      }

      break;
    case 5:
      break;
  }
}

function ref_12548(var0) {
  var1 = self;
  var1.show_charge = 1;

  if(isDefined(var0.hud_racetrack_info)) {
    var1 thread scripts\mp\hud_message::showsplash("br_red_door_control_room_splash", var0.hud_racetrack_info);
    var2 = level.hud_set_progress[var0.hud_racetrack_timer];
    var3 = var2.ignore_spawn_scoring_pois[0];
    level thread scripts\mp\gametypes\br_red_door_riddle_event::ref_13871(var0.hud_racetrack_info, var3);
    var4 = relic_grounded_reload_monitor(var0.hud_racetrack_info);
    scripts\mp\gametypes\br_analytics::dialog_monitor_waitreload(var1, var0.entity.doorid, var4);
    return;
  }
}

function hud_lap_scoreboard() {
  var0 = self;
  var0.shouldburnfromdamage = 1;

  if(isDefined(var0.doors)) {
    ref_12122(var0.doors);
  }

  ref_1245b(var0.crates);
  var0.maxkills = [];
  var1 = 32;
  var2 = 64;

  foreach(var4 in var0.doors) {
    var5 = var4.origin + anglesToForward(var4.angles) * 26 + (0, 0, 16);
    var6 = spawn("trigger_radius", var5, 0, var1, var2);
    var6.door = var4;
    var6.hud_racetrack_timer = var0.index;
    var6.matchstarttimer_black_screen = var6.door.angles;
    scripts\mp\utility\trigger::makeenterexittrigger(var6, &maxelderrank, &maxextractions);
    var0.maxkills[var0.maxkills.size] = var6;
  }

  thread ref_13e21(level);
}

function ref_1449d(var0) {
  var1 = self;
  level endon("game_ended");
  var1 endon("gas_end");
  var2 = 1;

  while(var2) {
    var3 = var0 scripts\engine\utility::ref_143af("death", "disconnect", "control_room_exit", "control_room_enter");

    switch (var3) {
      case "control_room_enter":
        battle_tracks_updatebattletracksfromplayerdata(var1, var0);
        break;
      case "control_room_exit":
        ref_12c19(var1, var0);
        break;
      case "death":
        ref_12c19(var1, var0);
        break;
      case "disconnect":
        var1.ref_12699 = scripts\engine\utility::array_removeundefined(var1.ref_12699);
        var2 = 0;
        break;
      default:
        break;
    }
  }
}

function battle_tracks_updatebattletracksfromplayerdata(var0) {
  var1 = self;

  if(!updatefobindanger(var0)) {
    var1.ref_12699[var1.ref_12699.size] = var0;
    return;
  }
}

function ref_12c19(var0) {
  var1 = self;
  var1.ref_12699 = scripts\engine\utility::array_remove(var1.ref_12699, var0);
}

function ref_13e21(var0) {
  level endon("game_ended");
  var1 = getdvarfloat("scr_br_warpDoorControlRoomTimeBeforeClosing", 30) * 1000;
  var2 = getdvarfloat("scr_br_warpDoorCloseRadius", 350);
  var3 = 1;

  while(var3) {
    if(var0.ref_12699.size <= 0 && gettime() - var0.ref_13b7a > var1) {
      var4 = 1;

      foreach(var6 in var0.doors) {
        var7 = var6.origin;
        var8 = var2;
        var9 = scripts\mp\utility\player::getplayersinradius(var7, var8);

        if(var9.size > 0) {
          var4 = 0;
        }
      }

      if(var4) {
        foreach(var6 in var0.doors) {
          scripts\mp\equipment\tactical_cover::ref_139f1(var6.origin);
          latespawnsnatchtoc130(var6.origin, 75, 0);
        }

        waitframe();

        foreach(var6 in var0.doors) {
          var6 vehicle_getinputvalue();
        }

        wait getdvarfloat("scr_br_warpDoorControlRoomDoorCloseTime", 1.2);

        foreach(var6 in var0.doors) {
          var6 setscriptablepartstate("door", 0);
        }

        var17 = 1;

        foreach(var6 in var0.doors) {
          if(!var6 scriptabledoorisclosed()) {
            var17 = 0;
            break;
          }
        }

        if(var17) {
          foreach(var6 in var0.doors) {
            var6 setscriptablepartstate("lock", "locked");
            var6 scriptabledoorfreeze(1);
            var6.ref_1199c = ref_13626(var6.origin);
          }

          var3 = 0;
        }
      }
    }

    wait 0.1;
  }
}

function updatefobindanger(var0) {
  var1 = self;
  return scripts\engine\utility::array_contains(var1.ref_12699, var0);
}

function playac130animinternal(var0, var1, var2) {
  var3 = self;
  level endon("game_ended");
  var3 endon("death");
  var3 endon("disconnect");

  while(!istrue(var3.ref_12a4a)) {
    waitframe();
  }

  var3.ref_12a4a = 0;
  var4 = 7.5;
  var5 = var2;
  var3 scripts\mp\gametypes\br_public::ref_126b9(var5, var4);
  var3 waittill("playerPrestreamComplete");

  if(isDefined(var0)) {
    var5 = give_objective_xp_to_all_players(var3, var0.ref_14429);
  }

  var3 setOrigin(var5);
  waitframe();
  ref_1277e(var3);
  wait 0.25;
  var3 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  ref_138f8(var3);

  if(isDefined(var0)) {
    switch (var0.launcherfired) {
      case 1:
        var6 = ["dx_brm_adl_ready_this_10", "dx_brm_adl_mission_intel_10"];
        var3 playsoundtoplayer(scripts\engine\utility::random(var6), var3);
        ref_12548(var0);
        break;
      case 3:
        var7 = ["dx_brm_stc_wrong_travel_10", "dx_brm_stc_wrong_travel_20"];
        var3 playsoundtoplayer(scripts\engine\utility::random(var7), var3);
        ref_12548(var0);
        break;
      case 4:
        break;
      case 2:
        if(isDefined(var0.setteamhealthhud)) {
          thread ref_1384f();
        }

        break;
      case 5:
        break;
    }
  }

  var3 notify("player_done_warping");
}

function ref_126ef(var0) {
  var1 = self;
  level endon("game_ended");
  var1 playerhide();
  var1 freezecontrols(1);
  var1 vehiclepinonminimap(1);
  var1.validateboltent = 1;

  if(isDefined(var0)) {
    var0.ref_1269a[var1.guid] = var1;
  }

  var2 = 7.5;
  var3 = scripts\engine\utility::ref_143bd(var2, "player_done_warping", "prematch_end", "warpqueue_done_warping", "death", "disconnect");

  if(isDefined(var0)) {
    if(var3 == "disconnect") {
      var0.ref_1269a = scripts\engine\utility::array_removeundefined(var0.ref_1269a);
      return;
    } else {
      var0.ref_1269a = scripts\engine\utility::array_remove(var0.ref_1269a, var1);
    }
  }

  var1 vehiclepinonminimap(0);
  var1 freezecontrols(0);
  var1 playershow();
  var1.validateboltent = undefined;
}

function setupprop(var0, var1) {
  var0.entity.usable = 0;
  var2 = scripts\cp_mp\vehicles\vehicle::ref_1418f(var1.vehiclename);

  if(isDefined(var2)) {
    var1[[var2]]();
  }

  wait 2;
  helicleanup(var0);
  var0.entity.usable = 1;
}

function ref_12342() {
  var0 = undefined;

  if(!isDefined(var0)) {
    var0 = give_killstreak_airstrike();
  }

  if(show_regroup_text()) {
    heli_go_to_exfil_point();
  }

  return var0;
}

function heli_go_to_exfil_point() {
  foreach(var1 in level.audio_start_obj_room_fires) {
    if(runjoininprogresstimeout(var1) == 2) {
      var2 = var1 getscriptablepartstate("warpdoor");

      if(!(var2 == "open" || var2 == "opening")) {
        thread heli_goto_pos();
      }
    }
  }
}

function give_killstreak_airstrike() {
  var0 = 0;
  var1 = spawnStruct();
  var2 = level.hud_set_progress;
  var3 = getdvarint("scr_br_warpDoorVisitPreMatch", 0);

  while(!var0) {
    if(var2.size <= 0) {
      return spawnStruct();
    }

    var4 = randomint(var2.size);
    var1 = var2[var4];
    var2 = scripts\engine\utility::array_remove(var2, var1);

    if(!var1.visited) {
      var0 = 1;
      ref_11b05(level.hud_set_progress[var1.index]);

      if(!istrue(level.br_circle_disabled) && var3 == 0) {
        var0 = scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var1.ignore_spawn_scoring_pois[0]);
      }
    }
  }

  return level.hud_set_progress[var1.index];
}

function give_objective_xp_to_all_players(var0) {
  foreach(var2 in var0) {
    if(capsuletracepassed(var2, 16, 32)) {
      return huddopulse(var2);
    }
  }

  return huddopulse(var0[0]);
}

function huddopulse(var0) {
  if(isDefined(var0)) {
    return (var0 + (0, 0, -45));
  }

  return self.origin;
}

function updaterotatedebug(var0) {
  var1 = distance2dsquared(scripts\mp\gametypes\br_circle::getdangercircleorigin(), var0);
  var2 = scripts\mp\gametypes\br_circle::getdangercircleradius() * scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(var2 == 0) {
    return false;
  }

  return var1 > var2;
}

function ref_14431() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("end_warp_queue");
  jumpiftrue(isDefined(var0.ref_14430)) LOC_0000002d;
  var0.ref_14430 = [];

  for(;;) {
    waitframe();

    if(!isDefined(var0.ref_14430) || var0.ref_14430.size <= 0) {
      var0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      continue;
    }

    var0.tv_station_fastrope_one_infil_rider_start_targetname = 1;
    var1 = var0.ref_14430[0];

    if(!isDefined(var1) || !isalive(var1)) {
      var0.ref_14430 = ref_12c1b(var0, var1);
      var0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      var1 notify("warpqueue_done_warping");
      continue;
    }

    thread playac130animinternal(var1, var0, (0, 90, 0));
    var1 scripts\engine\utility::ref_143a5("player_done_warping", "death");
    var0.ref_14430 = ref_12c1b(var0, var1);
    var0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
    var1 notify("warpqueue_done_warping");
  }
}

function battle_tracks_updatetogglestate(var0) {
  var1 = self;

  if(!isDefined(var0) || !isPlayer(var0)) {
    return;
  }

  if(!isDefined(var1.ref_14430)) {
    var1.ref_14430 = [];
  }

  if(scripts\engine\utility::array_contains(var1.ref_14430, var0)) {
    return;
  }

  var1.ref_13b7c = gettime();
  var1.ref_14430[var1.ref_14430.size] = var0;
}

function ref_12c1b(var0) {
  var1 = self;
  var2 = scripts\engine\utility::array_remove(var1.ref_14430, var0);
  return var2;
}

function ref_1338a() {
  var0 = self;

  if(!isDefined(var0.ref_14430)) {
    return;
  }

  level endon("game_ended");
  var0 endon("death");
  wait 0.1;

  while(istrue(var0.tv_station_fastrope_one_infil_rider_start_targetname)) {
    waitframe();
  }

  var0 notify("end_warp_queue");
  var0.ref_14430 = undefined;
  var0.ref_1442f = undefined;
}

function wp_watchforsmokedisowned(var0, var1) {
  var2 = level.hud_set_progress[var1];
  var0.hud_racetrack_info = var2.id;
  var0.ref_14429 = var2.ignore_spawn_scoring_pois;
  var0.hoverpos = var2.doors;
  var0.crates = var2.crates;
  var0.hud_racetrack_timer = var2.index;

  if(!isDefined(var0.ref_14429)) {
    var0.ref_14429 = [];

    if(level.mapname == "mp_br_mechanics") {
      var0.ref_14429[0] = (3307, -2480, 64);
    } else {
      var3 = risktokencountroll();
      var0.ref_14429[0] = var3;
      var0.ref_1442f = 1;
    }
  }

  var2.ref_13b7a = gettime();
  return var2;
}

function maxelderrank(var0, var1) {
  if(!isDefined(var1.linkedto)) {
    var2 = level.hud_set_progress[var1.hud_racetrack_timer];
    var3 = var0.origin - var1.origin;
    var4 = anglestoleft(var1.matchstarttimer_black_screen);

    if(updatefobindanger(var2, var0)) {
      if(vectordot(var3, var4) > 0) {
        var1.linkedto = var4;
        return;
      }

      var1.linkedto = -1 * var4;
      return;
    }

    if(vectordot(var3, var4) > 0) {
      var1.linkedto = -1 * var4;
      return;
    }

    var1.linkedto = var4;
    return;
  }
}

function maxextractions(var0, var1) {
  var2 = var0.origin - var1.origin;
  var3 = anglestoleft(var1.matchstarttimer_black_screen);

  if(vectordot(var1.linkedto, var2) > 0) {
    var0 notify("control_room_enter");
    return;
  }

  var0 notify("control_room_exit");
}

function wp_watchgameend(var0) {
  var1 = 0;

  for(var2 = 0; var2 < level.ref_1442a.size; var2++) {
    if(!istrue(level.ref_1442a[var2].inuse)) {
      level.ref_1442a[var2].inuse = 1;
      var1 = 1;
      break;
    }
  }

  if(!var1) {
    var2 = undefined;
  }

  var0.setteamhealthhud = var2;

  if(isDefined(var0.setteamhealthhud)) {
    var0.ref_14429 = [level.ref_1442a[var2].ignore_spawn_scoring_pois[0]];
    level.ref_1442a[var2].maxagents = [];
    var3 = [0, 1, 2, 3, 4, 5];
    var3 = scripts\engine\utility::array_randomize(var3);
    var4 = 0;
    var5 = ref_12342();

    for(var6 = 0; var6 < 4; var6++) {
      var7 = var3[var6];
      var8 = level.ref_1442a[var2].maxcastsperframe[var7].origin;
      var9 = level.ref_1442a[var2].maxcastsperframe[var7].angles;
      var10 = ref_136af(var8, var9);
      var11 = relic_nuketimer_waitforobjectives(var10);

      switch (var6) {
        case 0:
          ref_13288(var11, 1);
          var11.hud_racetrack_timer = var5.index;
          var11.setteamhealthhud = var2;
          break;
        case 2:
        case 1:
          ref_13288(var11, 3);
          var11.hud_racetrack_timer = var5.index;
          var11.setteamhealthhud = var2;
          break;
        case 3:
          ref_13288(var11, 4);
          var11.setteamhealthhud = var2;
          break;
        default:
          ref_13288(var11, 4);
          var11.setteamhealthhud = var2;
          break;
      }

      level.ref_1442a[var2].maxagents[level.ref_1442a[var2].maxagents.size] = var10;
    }

    thread ref_144dd(level, var2);
    return;
  }

  var12 = risktokencountroll();
  var0.ref_14429 = [var12];
  var0.ref_1442f = 1;
}

function veh_updateomnvarsperframeforclient(var0) {
  if(isDefined(var0.setteamhealthhud) && var0.launcherfired != 2) {
    return true;
  }

  return false;
}

function risktokencountroll() {
  var0 = undefined;

  if(level.br_circle_disabled) {
    var0 = scripts\mp\gametypes\br_circle::getrandompointincircle((0, 0, 0), getdvarfloat("scr_br_warpDoorFallbackRandomCircleRadius", 20000));
  } else {
    var0 = scripts\mp\gametypes\br_circle::risk_modifyflagstieronrespawn();
  }

  var1 = scripts\mp\gametypes\br_c130::relic_ammo_drain_take_ammo();
  return (var0[0], var0[1], var1);
}

function wp_watchplanedisowned(var0) {
  var1 = undefined;

  if(getdvarint("scr_br_warpDoorHotDropEnabled", 1) != 0) {
    var1 = scripts\mp\gametypes\br_circle::relic_focusfire_modifyplayerdamage(getdvarint("scr_br_warpDoorHotdropClusters", 6));
  }

  if(!isDefined(var1) || isDefined(var1) && updaterotatedebug(var1)) {
    var1 = risktokencountroll();
  }

  var2 = scripts\mp\gametypes\br_c130::relic_ammo_drain_take_ammo();
  var0.ref_14429 = [(var1[0], var1[1], var2)];
  var0.ref_1442f = 1;
}

function wrapindex(var0, var1) {
  var2 = var1.origin;
  var3 = scripts\mp\gametypes\br_c130::relic_ammo_drain_take_ammo();
  var0.ref_14429 = [(var2[0], var2[1], var3)];
  var0.ref_1442f = 1;
}

function ref_12130() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("warpdoor_close");
  var0.entity endon("warpdoor_despawn");
  var0.ref_1269a = [];

  if(unload_vehicles_on_weapons_free_thread(var0)) {
    var0 setscriptablepartstate("warpdoor", "trapped_opening");
  } else {
    var0 setscriptablepartstate("warpdoor", "opening");
  }

  var0 notify("warpdoor_open");

  if(getdvarint("scr_br_warpDoorHweenEnabled", 0) && veh_updateomnvarsperframeforclient(var0)) {
    ref_1277d(var0);
  }

  switch (var0.launcherfired) {
    case 3:
    case 1:
      if(!isDefined(var0.hud_racetrack_timer)) {
        var1 = ref_12342();

        if(!isDefined(var1.index)) {
          var0.launcherfired = 4;
          wp_watchplanedisowned(var0);
          break;
        }

        <
        error > .hud_racetrack_timer = var0.index;
      }

      wp_watchforsmokedisowned( < error > , < error > .hud_racetrack_timer);
      break;
    case 4:
      wp_watchplanedisowned( < error > );
      break;
    case 5:
      var4 = scripts\mp\gametypes\br_numbers_tower::propheight();

      if(isDefined(var4)) {
        wrapindex( < error > , var4);
        thread ref_13c64();
        break;
      }
    case 2:
      wp_watchgameend( < error > );
      thread ref_13c64();
      break;
  }

  wait 1;
  var5 = < error > .origin + anglestoleft( < error > .angles) * 15 + anglesToForward( < error > .angles) * 26 + (0, 0, 16); <
  error > .ref_14432 = spawn("trigger_radius", var5, 0, 25, 32); <
  error > .ref_14432.ref_121d7 = < error > ;
  scripts\mp\utility\trigger::makeenterexittrigger( < error > .ref_14432, &ref_1442b, undefined);
  thread ref_14431();
}

function ref_13c64() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("warpdoor_close");
  var0.entity endon("warpdoor_despawn");
  var0.ref_13b81 = gettime();
  var0.ref_13b7c = undefined;

  for(;;) {
    if(isDefined(var0.ref_13b7c) && (gettime() - var0.ref_13b7c) / 1000 >= getdvarint("scr_br_warpDoorInactiveTime", 10)) {
      thread helicleanup(var0);
      return;
    }

    if((gettime() - var0.ref_13b81) / 1000 >= getdvarint("scr_br_warpDoorMaxOpenTime", 30)) {
      thread helicleanup(var0);
      return;
    }

    wait 1;
  }
}

function validateplundereventtype(var0) {
  return var0 == 3 || var0 == 4;
}

function unload_vehicles_on_weapons_free_thread() {
  var0 = relic_nuketimer_waitforobjectives();

  if(isDefined(var0.launcherfired)) {
    return validateplundereventtype(var0.launcherfired);
  }

  return false;
}

function helicleanup(var0) {
  var1 = self;
  level endon("game_ended");
  var1 endon("death");
  var1 endon("warpdoor_open");

  if(isDefined(var1.ref_14432)) {
    var1.ref_14432 delete();
  }

  var1.ref_13b99 = 0;

  if(unload_vehicles_on_weapons_free_thread(var1)) {
    var1 setscriptablepartstate("warpdoor", "trapped_closing");
  } else {
    var1 setscriptablepartstate("warpdoor", "closing");
  }

  var1.entity.usable = 0;

  while(var1.ref_1269a.size != 0) {
    wait 0.1;
  }

  var1.entity.usable = 1;
  var1.setteamhealthhud = undefined;
  var1 notify("warpdoor_close");
  thread ref_1338a();

  if(isDefined(level.hud_set_progress) && show_regroup_text() && runjoininprogresstimeout(var1) == 2) {
    thread heli_goto_pos();
    return;
  }
}

function ref_1449b() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("warpdoor_open");
  var0.entity endon("warpdoor_despawn");
  var0 waittill("end_warp_queue");
  wait 5;
  thread latetoinfil();
}

function unload_type() {
  var0 = self getscriptablepartstate("warpdoor");
  return var0 == "open" || var0 == "opening" || var0 == "trapped_open" || var0 == "trapped_opening";
}

function heli_goto_pos() {
  var0 = self;

  if(!isDefined(var0.entity)) {
    var0 = var0 getlinkedscriptableinstance();
  }

  level endon("game_ended");
  var0 endon("death");
  var0.entity endon("warpdoor_despawn");
  var0.entity.usable = 0;

  if(unload_type(var0)) {
    helicleanup(var0);
  }

  while(!(var0 getscriptablepartstate("warpdoor") == "closed" || var0 getscriptablepartstate("warpdoor") == "trapped_closed")) {
    waitframe();
  }

  wait 1;
  thread latetoinfil();
}

function ref_1449a() {
  var0 = self;
  var1 = var0 getlinkedscriptableinstance();
  level endon("game_ended");
  var0 endon("death");
  var1 endon("death");
  wait 5;

  if(var1.launcherfired != 2) {
    return;
  }

  while(!updaterotatedebug(var0.origin)) {
    wait 1;
  }

  heli_goto_pos(var0);
}

function zombieregendelayscaleoutgas() {
  level endon("game_ended");

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  while(!isDefined(level.disable_super_in_turret)) {
    waitframe();
  }

  var0 = "mp/warpdoor_hallway_locations.csv";
  var1 = tablelookupgetnumrows(var0);
  level.ref_1442a = [];

  for(var2 = 0; var2 < var1; var2++) {
    var3 = spawnStruct();
    var4 = var2;
    var3.id = int(tablelookupbyrow(var0, var4, 0));
    var3.ignore_spawn_scoring_pois = [];
    var3.ignore_spawn_scoring_pois[0] = (int(tablelookupbyrow(var0, var4, 1)), int(tablelookupbyrow(var0, var4, 2)), int(tablelookupbyrow(var0, var4, 3)));
    var3.inuse = 0;
    var3.ref_126be = [];
    var3.maxcastsperframe = remove_flag_trigs(var3.ignore_spawn_scoring_pois[0]);
    level.ref_1442a[level.ref_1442a.size] = var3;
  }
}

function remove_flag_trigs(var0) {
  var1 = [];
  var2 = scripts\engine\utility::getStructArray("hallway_door_spawn", "targetname");

  foreach(var4 in var2) {
    if(abs(var0[0] - var4.origin[0]) <= 500) {
      var1 = var4;
    }
  }

  return var1;
}

function unset_relic_no_ammo_mun() {
  if(!isDefined(level.ref_1442a)) {
    return false;
  }

  foreach(var1 in level.ref_1442a) {
    if(var1.inuse) {
      return false;
    }
  }

  return true;
}

function ref_12549(var0) {
  var1 = self;
  var1.unset_relic_thirdperson = 1;
  var2 = getdvarint("scr_br_warpDoorAllowKillstreaksInHallway", 0) != 0;

  if(!var2) {
    var1 scripts\common\utility::allow_killstreaks(0);
    var1 disableoffhandweapons();
  }

  level.ref_1442a[var0].ref_126be[level.ref_1442a[var0].ref_126be.size] = var1;
  thread ref_11d19(var1);
}

function ref_144dd(var0, var1) {
  level endon("game_ended");
  var1 waittill("warpdoor_close");
  wait 3;

  while(level.ref_1442a[var0].ref_126be.size != 0) {
    wait 1;
  }

  ref_13389(var0);
}

function mark_coop_bomb_defusal_ended() {
  var0 = self;

  if(istrue(var0.validateboltent)) {
    return;
  }

  var0 notify("mental_break");
  var1 = risktokencountroll();
  var2 = var1;
  thread ref_1386b(var0, var2, var0.angles, undefined);
  thread playac130animinternal(var0, undefined, var0.angles);
}

function ref_11d19(var0) {
  var1 = self;
  level endon("game_ended");
  var2 = scripts\engine\utility::ref_143af("entered_door_in_hallway", "death", "mental_break", "disconnect");

  if(var2 == "disconnect") {
    level.ref_1442a[var0].ref_126be = scripts\engine\utility::array_removeundefined(level.ref_1442a[var0].ref_126be);
    return;
  }

  level.ref_1442a[var0].ref_126be = scripts\engine\utility::array_remove(level.ref_1442a[var0].ref_126be, var1);
  var1.unset_relic_thirdperson = 0;
  var3 = getdvarint("scr_br_warpDoorAllowKillstreaksInHallway", 0) != 0;

  if(!var3) {
    var1 scripts\common\utility::allow_killstreaks(1);
    var1 enableoffhandweapons();
  }

  var1 notify("leave_hallway");
}

function ref_1384f() {
  var0 = self;
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("entered_door_in_hallway");
  var0 endon("death");
  var0 endon("leave_hallway");
  var1 = getdvarint("scr_br_warpDoorHallwayTimeout", 20);
  var2 = getdvarint("scr_br_warpDoorHallwayCountdownStart", 5);
  wait var1 - var2;

  for(var3 = var2; var3 >= 0; var3--) {
    var4 = "dx_brm_stc_numbers_";
    var4 += var3;
    var4 += "_10";
    var0 playsoundtoplayer(var4, var0);
    wait 1;
  }

  mark_coop_bomb_defusal_ended(var0);
}

function ref_13389(var0) {
  wait 7.5;

  foreach(var2 in level.ref_1442a[var0].maxagents) {
    thread heli_goto_pos();
  }

  wait 3;
  var4 = level.ref_1442a[var0].ignore_spawn_scoring_pois[0];
  var5 = getdvarfloat("scr_br_warpDoorCleanupRadius", 500);
  latespawnsnatchtoc130(var4, var5, getdvarint("scr_br_warpDoorKillPlayerOnEntityCleanup", 1));
  level.ref_1442a[var0].ref_126be = [];
  level.ref_1442a[var0].inuse = 0;
}

function latespawnsnatchtoc130(var0, var1, var2) {
  var3 = scripts\engine\trace::sphere_trace_get_all_results(var0, var0, var1, undefined, undefined, 0, 1);

  for(var4 = 0; var4 < var3.size - 1; var4++) {
    var5 = var3[var4]["entity"];

    if(isDefined(var5)) {
      if(isPlayer(var5) && (!var2 || istrue(var5.validateboltent))) {
        continue;
      }

      var5 dodamage(15000, var5.origin, var5, undefined, "MOD_EXPLOSIVE");
    }
  }
}

function nuke_vault_key(var0) {
  if(isDefined(var0.hud_racetrack_timer)) {
    var1 = level.hud_set_progress[var0.hud_racetrack_timer];

    if(var1.shouldburnfromdamage) {
      return;
    }
  }

  var2 = level.ref_1442a[var0.setteamhealthhud];

  switch (var0.launcherfired) {
    case 1:
      foreach(var4 in var2.maxagents) {
        if(relic_nuketimer_waitforobjectives(var4) != var0) {
          ref_13288(var4, 4);
          wp_watchplanedisowned(relic_nuketimer_waitforobjectives(var4));
        }
      }

      break;
    case 3:
      var1 = level.hud_set_progress[var0.hud_racetrack_timer];
      ref_13d00(var1);

      foreach(var4 in var2.maxagents) {
        if(runjoininprogresstimeout(var4) == 1) {
          ref_13288(var4, 3);
        }
      }

      break;
  }
}

function ref_12853(var0) {
  var1 = self;
  var1 skydive_cutparachuteon(var0);
  var1 setclientomnvar("ui_br_bink_overlay_state", 10);
}

function ref_1277c(var0) {
  var1 = self;
  var1 preloadcinematicforplayer(var0);
}

function ref_138f8() {
  var0 = self;
  var0 setclientomnvar("ui_br_bink_overlay_state", 0);
  var0 skydive_cutparachuteoff();
}

function ref_1277f() {
  var0 = self;
  playFX(level._effect["warp_door_out"], var0.origin);
}

function ref_1277e() {
  var0 = self;
  playFX(level._effect["warp_door_in"], var0.origin);
}

function ref_1277d() {
  var0 = self;
  var1 = randomint(4);
  var2 = "warp_door_hween_";

  switch (var1) {
    case 0:
      var2 += "bats";
      break;
    case 1:
      var2 += "footprints";
      break;
    case 2:
      var2 += "ghost";
      break;
    case 3:
      var2 += "skelhand";
      break;
    default:
      var2 += "bats";
      break;
  }

  playFX(level._effect[var2], var0.origin, anglesToForward(var0.angles));
}

function relic_grounded_reload_monitor(var0) {
  var1 = "";

  if(var0 < 10) {
    var1 = "0";
  }

  var2 = "MP_DONETSK/CALLOUT_RED_DOOR_CONTROL_ROOM_" + var1 + var0;
  return var2;
}
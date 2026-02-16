/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_brg_sq.gsc
****************************************/

init_sidequest() {
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("main", ::init_main_sidequest, ::sidequest_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage1", ::stage1_init, ::stage1_logic, ::stage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage2", ::stage2_init, ::stage2_logic, ::stage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage3", ::stage3_init, ::stage3_logic, ::stage3_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage4", ::stage4_init, ::stage4_logic, ::stage4_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage5", ::stage5_init, ::stage5_logic, ::stage5_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage6", ::stage6_init, ::stage6_logic, ::stage6_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage7", ::stage7_init, ::stage7_logic, ::stage7_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage8", ::stage8_init, ::stage8_logic, ::stage8_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage9", ::stage9_init, ::stage9_logic, ::stage9_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage10", ::stage10_init, ::stage10_logic, ::stage10_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage11", ::stage11_init, ::stage11_logic, ::stage11_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage12", ::stage12_init, ::stage12_logic, ::stage12_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage13", ::stage13_init, ::stage13_logic, ::stage13_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage14", ::stage14_init, ::stage14_logic, ::stage14_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage15", ::stage15_init, ::stage15_logic, ::stage15_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage16", ::stage16_init, ::stage16_logic, ::stage16_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage17", ::stage17_init, ::stage17_logic, ::stage17_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("song", ::init_song_sidequest, ::sidequest_logic_song);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage1", ::songstage1_init, ::songstage1_logic, ::songstage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage2", ::songstage2_init, ::songstage2_logic, ::songstage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage3", ::songstage3_init, ::songstage3_logic, ::songstage3_end);
  precachemodel("det_basement_valve_01_anim");
  precachemodel("dlc2_brg_bun");
  precachemodel("dlc2_brg_burger_bomb");
  precachemodel("dlc2_zom_gib_arm_pickup");
  precachempanim("mp_dogtag_spin");
  precachempanim("zom_mbot_activation_yumm");
  precachempanim("zom_mbot_activation_key");
  precachestring(&"ZOMBIE_BRG_BOMB_THROW");
  common_scripts\utility::flag_init("sewermain_to_sewercave");
  common_scripts\utility::flag_init("sewer_to_burgertown");
  common_scripts\utility::create_dvar("battery_open", 0);
  common_scripts\utility::create_dvar("secret_cave_open", 0);
  level thread randomizemeatchunks();
  level thread start_brg_sidequest();
  level thread beauford_greetings();
  level thread beauford_interact();
  level thread beauford_hit();
  level thread beauford_kills();
  thread toilet_interact();
  thread fingerprint_scanner_fail_fx();
  level thread onplayerconnected();
  level thread onanyplayerspawned();
  level thread initvo();
}

start_brg_sidequest() {
  wait 3;
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

init_main_sidequest() {
  level.sidequeststarted = 0;
  level.burgerhatchlocked = 1;
  thread sidequest_init_hidden();
  thread init_burger_teleporter();
  thread burger_room_valve_lock("locked");
  thread burger_room_locked_audio();

  foreach(var_1 in level.players) {
    thread init_player_variables();
    thread playertakeitemondisconnect();
  }
}

init_burger_teleporter() {
  common_scripts\utility::flag_wait("sewer_to_burgertown");

  foreach(var_1 in level.zombieteleporters) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "burgertower_teleport") {
      var_1 thread maps\mp\zombies\_teleport::teleporter_disable();
    }
  }
}

init_player_variables() {
  self.hasskilletgolden = undefined;
  self.hasskilletseasoned = undefined;
  self.hasmeat = 0;
  self.batteryisopen = undefined;
  self.hasbun = undefined;
  self.hasburgerinfected = undefined;
  self.hasburger = undefined;
  self.hasbatterydepleted = undefined;
  self.hasbatterycharged = undefined;
  self.hasarm = undefined;
  self.hasdriveencrypted = undefined;
  self.hasdrivedecrypted = undefined;
  self.haskey = undefined;
}

sidequest_init_hidden() {
  var_0 = getEntArray("sq_hidden", "target");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  var_4 = getEntArray("burger_rocket_fin", "targetname");

  foreach(var_6 in var_4) {
    var_6 hide();
  }

  var_8 = getEntArray("zombie_meat_chunk_gs", "targetname");
  var_9 = getEntArray("zombie_meat_chunk_ac", "targetname");
  var_10 = getEntArray("zombie_meat_chunk_sw", "targetname");
  var_11 = getEntArray("zombie_meat_chunk_bt", "targetname");
  var_12 = common_scripts\utility::array_combine(var_8, var_9);
  var_13 = common_scripts\utility::array_combine(var_10, var_11);
  var_14 = common_scripts\utility::array_combine(var_12, var_13);

  foreach(var_16 in var_14) {
    var_16 hide();
  }
}

sidequest_logic() {
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage1");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage2");
  level common_scripts\utility::waittill_multiple("main_stage1_over", "main_stage2_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage3");
  level waittill("main_stage3_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage4");
  level waittill("main_stage4_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage5");
  level waittill("main_stage5_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage6");
  level waittill("main_stage6_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage7");
  level waittill("main_stage7_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage8");
  level waittill("main_stage8_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage9");
  level waittill("main_stage9_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage10");
  level waittill("main_stage10_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage11");
  level waittill("main_stage11_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage12");
  level waittill("main_stage12_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage13");
  level waittill("main_stage13_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage14");
  level waittill("main_stage14_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage15");
  level waittill("main_stage15_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage16");
  level waittill("main_stage16_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage17");
  level waittill("main_stage17_over");
}

complete_sidequest() {}

generic_stage_start() {
  level._stage_active = 1;
}

generic_stage_complete() {
  level._stage_active = 0;
}

onanyplayerspawned() {
  for(;;) {
    level waittill("player_spawned", var_0);

    if(isDefined(var_0) && isDefined(var_0.hasskilletgolden)) {
      var_0 setclientomnvar("ui_zm_ee_int", 4);
    }

    if(isDefined(var_0) && isDefined(var_0.hasskilletseasoned)) {
      var_0 setclientomnvar("ui_zm_ee_int", 2);
    }

    if(isDefined(var_0) && isDefined(var_0.hasmeat) && var_0.hasmeat) {
      var_0 setclientomnvar("ui_zm_ee_int", 1);
    }

    if(isDefined(var_0) && isDefined(var_0.hasbun)) {
      var_0 setclientomnvar("ui_zm_ee_int", 11);
    }

    if(isDefined(var_0) && isDefined(var_0.hasburgerinfected)) {
      var_0 setclientomnvar("ui_zm_ee_int", 7);
      var_0 thread stage8_infected_burger();
    }

    if(isDefined(var_0) && isDefined(var_0.hasburger)) {
      var_0 setclientomnvar("ui_zm_ee_int", 8);
    }

    if(isDefined(var_0) && isDefined(var_0.hasbatterydepleted)) {
      var_0 setclientomnvar("ui_zm_ee_int", 10);
    }

    if(isDefined(var_0) && isDefined(var_0.hasbatterycharged)) {
      var_0 setclientomnvar("ui_zm_ee_int", 9);
    }

    if(isDefined(var_0) && isDefined(var_0.haskey)) {
      var_0 setclientomnvar("ui_zm_ee_int", 12);
    }

    if(isDefined(var_0) && isDefined(var_0.hasarm)) {
      var_0 setclientomnvar("ui_zm_ee_int", 3);
    }

    if(isDefined(var_0) && isDefined(var_0.hasdriveencrypted)) {
      var_0 setclientomnvar("ui_zm_ee_int", 5);
    }

    if(isDefined(var_0) && isDefined(var_0.hasdrivedecrypted)) {
      var_0 setclientomnvar("ui_zm_ee_int", 6);
    }
  }
}

onplayerconnected() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 init_player_variables();
  }
}

playertakeitemondisconnect() {
  self waittill("disconnect");
  self setclientomnvar("ui_zm_ee_int", 0);
}

initvo() {
  waitframe();
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "sq", "sq", "dlc2_easter", undefined);
  var_0 = spawn("script_model", (329, -4087, 240));
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_beauford", "beauford_", var_0, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford", "machine_all_players", "greeting", "greeting", undefined, 50);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford", "machine_all_players", "response", "response", undefined, 50);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford", "machine_all_players", "hit", "hit", undefined, 25);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford", "machine_all_players", "killzombie", "killzombie", undefined, 75);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_beauford", "machine_all_players", "sq", "sq", undefined);
}

playerplaysqvo(var_0, var_1) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(maps\mp\zombies\_util::is_true(self.speaking)) {
    self waittill("done_speaking");
  }

  thread maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq", "sq", undefined, var_0);
}

waittilldonespeaking(var_0) {
  var_0 endon("disconnect");

  if(maps\mp\zombies\_util::is_true(var_0.isspeaking)) {
    var_0 waittill("done_speaking");
  }
}

playsqvowaittilldone(var_0, var_1, var_2) {
  var_3 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(var_0);

  if(isDefined(var_3)) {
    var_3 playerplaysqvo(var_1, 0);
    waitframe();
    waittilldonespeaking(var_3);

    if(isDefined(var_2)) {
      wait(var_2);
    }
  }
}

playbeaufordsqvo(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
  var_3 = var_2[0];

  if(!isDefined(var_3)) {
    return;
  }
  if(maps\mp\zombies\_util::is_true(var_3.speaking)) {
    var_3 waittill("done_speaking");
  }

  var_3 thread maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players", "sq", undefined, var_0);
}

playbeaufordsqvowaitilldone(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
  var_3 = var_2[0];

  if(!isDefined(var_3)) {
    return;
  }
  if(maps\mp\zombies\_util::is_true(var_3.speaking)) {
    var_3 waittill("done_speaking");
  }

  if(var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players", "sq", undefined, var_0)) {
    var_3 waittill("done_speaking");
  }
}

playbeaufordvo(var_0) {
  var_1 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
  var_2 = var_1[0];

  if(!isDefined(var_2)) {
    return;
  }
  return var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players", var_0);
}

murderbot_animate(var_0) {
  var_1 = getent("murderbot_animscripted", "targetname");
  var_1 scriptmodelplayanim(var_0);
  var_1 playSound("sq_burger_offering");
}

toilet_interact() {
  level endon("game_ended");
  var_0 = common_scripts\utility::getstruct("toilet_use", "targetname");

  for(;;) {
    var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("flushed", undefined, undefined, undefined, 80);
    var_0 waittill("flushed", var_1);
    maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Toilet flushed!!");
    playsoundatpos(var_0.origin, "ee_toilet_flush");
    wait 3;
  }
}

fingerprint_scanner_fail_fx() {
  level endon("main_stage13_over");
  var_0 = common_scripts\utility::getstruct("warehouse_safe_use", "targetname");
  var_1 = getent("fingerprint_scanner", "targetname");

  for(;;) {
    wait 1;
    var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "main_stage13_over", 80);
    var_0 waittill("activated", var_2);
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_fail"), var_1, "tag_origin");
    var_1 playSound("sq_safe_denied");
  }
}

stage1_init() {}

stage1_logic() {
  var_0 = getent("golden_skillet_roof", "targetname");
  var_1 = common_scripts\utility::getstruct("golden_skillet_roof_use", "targetname");
  var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("grabbed", undefined, undefined, "main_stage1_over", 100);
  var_1 waittill("grabbed", var_2);
  playsoundatpos(var_0.origin, "sq_skillet_grab");
  var_2 playerplaysqvo(14);
  var_0 delete();
  var_2 playergiveskillet("unseasoned");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage1");
}

stage1_end(var_0) {
  level.sidequeststarted = 1;
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I got the skillet");
}

playerhasskilletgolden() {
  return maps\mp\zombies\_util::is_true(self.hasskilletgolden);
}

playerhasskilletseasoned() {
  return maps\mp\zombies\_util::is_true(self.hasskilletseasoned);
}

playergiveskillet(var_0) {
  switch (var_0) {
    case "unseasoned":
      self setclientomnvar("ui_zm_ee_int", 4);
      self.hasskilletgolden = 1;
      break;
    case "seasoned":
      self setclientomnvar("ui_zm_ee_int", 2);
      self.hasskilletseasoned = 1;
      break;
  }
}

playertakeitem(var_0) {
  switch (var_0) {
    case "skillet_golden":
      self.hasskilletgolden = undefined;
      break;
    case "skillet_seasoned":
      self.hasskilletseasoned = undefined;
      break;
    case "meat":
      self.hasmeat = 0;
      break;
    case "bun":
      self.hasbun = undefined;
      break;
    case "burger":
      self.hasburger = undefined;
      break;
    case "battery_depleted":
      self.hasbatterydepleted = undefined;
      break;
    case "battery_charged":
      self.hasbatterycharged = undefined;
      break;
    case "key":
      self.haskey = undefined;
      break;
    case "arm":
      self.hasarm = undefined;
      break;
    case "drive_encrypted":
      self.hasdriveencrypted = undefined;
      break;
    case "drive_decrypted":
      self.hasdrivedecrypted = undefined;
      break;
  }

  self setclientomnvar("ui_zm_ee_int", 0);
}

stage2_init() {
  thread maps\mp\mp_zombie_brg::initgranulardoors("sewermain_to_sewercave", 0.05);
}

stage2_logic() {
  level.sewer_cave_valve_count = 0;
  thread stage2_cave_valves();

  while(level.sewer_cave_valve_count < 4) {
    if(getdvarint("secret_cave_open") > 0) {
      break;
    } else {
      wait 0.5;
    }
  }

  level notify("sewer_cave_open");
  level thread stage2_open_door();
  common_scripts\utility::flag_set("sewermain_to_sewercave");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage2");
}

stage2_open_door() {
  level.zmbstage2dooropen = 1;
  var_0 = getEntArray("sewers_waterfall", "targetname");

  foreach(var_2 in var_0) {
    var_2 movez(-256, 0.5);
    var_2 connectpaths();
  }

  var_4 = getEntArray("secret_cave_door", "targetname");

  foreach(var_2 in var_4) {
    var_2 movey(-128, 3);
    var_2 connectpaths();
    playsoundatpos((3233, -2112, -329), "sq_door_stone_open");
  }
}

stage2_cave_valves() {
  var_0 = common_scripts\utility::getStructArray("cave_valve_loc", "targetname");

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_2 = common_scripts\utility::random(var_0);
    var_0 = common_scripts\utility::array_remove(var_0, var_2);
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("det_basement_valve_01_anim");
    var_3.origin = var_2.origin;
    var_3.angles = var_2.angles;
    var_3.target = var_2.target;
    var_4 = 0;

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "downward_steam") {
      var_4 = 1;
    }

    var_3 thread stage2_cave_triggers(var_4);
  }
}

stage2_cave_triggers(var_0) {
  if(var_0 == 1) {
    var_1 = spawnfx(common_scripts\utility::getfx("steam_pipe_leak_interior_sm"), self.origin, (1, 0, 0), (0, 1, 0));
  } else {
    var_1 = spawnfx(common_scripts\utility::getfx("steam_pipe_leak_interior_sm"), self.origin, anglesToForward(self.angles + (0, -90, 0)));
  }

  var_2 = common_scripts\utility::getstruct(self.target, "targetname");
  var_2 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "main_stage2_over", 100);
  var_2 waittill("activated", var_3);

  if(!isDefined(var_3.playedstage2vo)) {
    var_3 thread playerplaysqvo(10, 1);
    var_3.playedstage2vo = 1;
  }

  playsoundatpos(self.origin, "sq_sewer_valve_turn");
  self rotateroll(-270, 2);
  wait 2;
  level.sewer_cave_valve_count++;
  triggerfx(var_1);
  self playLoopSound("sq_sewer_valve_steam");
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I wonder what that did...");
  level waittill("sewer_cave_open");

  if(isDefined(var_3)) {
    var_3 thread playerplaysqvo(11);
  }

  wait 5;
  self stoploopsound();
  var_1 delete();

  if(level.currentgen) {
    self delete();
  }
}

stage2_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I feel a draft coming from somewhere");
}

stage3_init() {
  level.sacrificekillcount = 0;
}

stage3_logic() {
  level thread stage3_playerenter();
  var_0 = getent("golden_skillet_unseasoned", "targetname");
  var_1 = common_scripts\utility::getstruct("skillet_unseasoned_use", "targetname");
  var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed", ::playerhasskilletgolden, undefined, "main_stage3_over", 80);

  if(level.nextgen) {
    thread maps\mp\mp_zombie_brg::alterjumpexploit(var_1);
  }

  var_1 waittill("placed", var_2);
  var_0 playsoundonmovingent("sq_skillet_put_down_altar");
  var_2 playertakeitem("skillet_golden");
  var_0 show();
  var_3 = getent("golden_skillet_seasoned", "targetname");
  var_4 = getent("skillet_altar", "targetname");
  var_5 = getent("skillet_altar_coll", "targetname");
  var_3 linkto(var_4);
  var_0 linkto(var_4);
  var_4 thread stage3_altar_move();
  var_5 thread stage3_altar_move();
  earthquake(0.15, 3.0, var_4.origin, 200);
  playrumbleonposition("artillery_rumble", var_4.origin);
  var_5 waittill("lowered");
  var_5 connectpaths();
  earthquake(0.15, 3.0, var_4.origin, 200);
  level.sacrificeactive = 1;
  thread stage3_sacrifice_setup();
  thread stage3_sacrifice_killcounter();
  level waittill("sq_raise_altar");
  earthquake(0.15, 3.0, var_4.origin, 200);
  playrumbleonposition("artillery_rumble", var_4.origin);
  level waittill("sq_altar_raised");
  earthquake(0.15, 3.0, var_4.origin, 200);
}

stage3_playerenter() {
  level endon("main_stage3_over");
  var_0 = getent("sacrifice_trigger", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 istouching(var_0)) {
        var_2 thread playerplaysqvo(12);
        return;
      }
    }

    waitframe();
  }
}

stage3_altar_move() {
  self movez(-32, 3);
  self playSound("sq_alter_lower");
  playFX(common_scripts\utility::getfx("brg_altar_dust"), self.origin);
  wait 3;
  self notify("lowered");
  level waittill("sq_raise_altar");
  self movez(32, 3);
  self playSound("sq_alter_raise");
  playFX(common_scripts\utility::getfx("brg_altar_dust"), self.origin);
  wait 3;
  level notify("sq_altar_raised");
}

stage3_sacrifice_setup() {
  level endon("main_stage3_over");
  var_0 = getent("sacrifice_trigger", "targetname");
  var_1 = getent("blood_pool_mover", "targetname");
  var_1 thread stage3_raise_blood();

  while(level.sacrificeactive == 1) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      continue;
    } else if(isDefined(var_2.agentteam) && var_2.agentteam == level.playerteam) {
      continue;
    } else if(!isDefined(var_2.alreadytriggered)) {
      var_2 thread stage3_sacrifice_trigmonitor(var_0);
      var_2 thread stage3_sacrifice_killmonitor(var_1);
    }

    var_2.alreadytriggered = 1;
  }
}

stage3_sacrifice_trigmonitor(var_0) {
  self endon("death");
  level endon("main_stage3_over");

  while(self istouching(var_0)) {
    wait 0.1;
  }

  self notify("ZombieLeftSacrificeArea");
  self.alreadytriggered = 0;
}

stage3_sacrifice_killmonitor(var_0) {
  self endon("ZombieLeftSacrificeArea");
  level endon("main_stage3_over");
  var_1 = common_scripts\utility::getstruct("skillet_glow_fx", "targetname");

  if(!isDefined(self.alreadytriggered)) {
    self.alreadytriggered = 0;
  }

  if(self.alreadytriggered == 0) {
    self waittill("death", var_2);

    if(level.sacrificekillcount < 66) {
      if(isDefined(var_2) && !isDefined(var_2.playedseasoningvo)) {
        var_2 playerplaysqvo(15);
        var_2.playedseasoningvo = 1;
      }

      level.sacrificekillcount++;
      playFX(common_scripts\utility::getfx("brg_skillet_gleam"), var_1.origin);
      maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Number of Sacrifices:" + level.sacrificekillcount);
    }
  }
}

stage3_raise_blood() {
  level endon("main_stage3_over");
  var_0 = self.origin;

  for(;;) {
    wait 2;

    if(level.sacrificekillcount > 0 && level.sacrificekillcount < 66) {
      var_1 = level.sacrificekillcount * 2;
      self moveto(var_0 + (0, 0, var_1), 2);
    }
  }
}

stage3_sacrifice_killcounter() {
  while(level.sacrificekillcount < 66) {
    wait 0.1;
  }

  level.sacrificeactive = 0;
  var_0 = getent("golden_skillet_unseasoned", "targetname");
  var_1 = getent("golden_skillet_seasoned", "targetname");
  var_0 delete();
  var_1 show();
  level notify("sq_raise_altar");
  level waittill("sq_altar_raised");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage3");
}

stage3_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Ritual complete. The skillet is properly seasoned");
}

stage4_init() {}

stage4_logic() {
  var_0 = getent("golden_skillet_seasoned", "targetname");
  var_1 = common_scripts\utility::getstruct("skillet_unseasoned_use", "targetname");
  var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", undefined, undefined, "main_stage4_over", 80);
  var_1 waittill("acquired", var_2);
  playsoundatpos(var_0.origin, "sq_skillet_grab");
  var_0 hide();
  var_2 playergiveskillet("seasoned");
  var_3 = getent("golden_skillet_stove", "targetname");
  var_4 = common_scripts\utility::getstruct("burgertown_stove_interact", "targetname");
  var_4 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed", ::playerhasskilletseasoned, undefined, "main_stage4_over");
  var_4 waittill("placed", var_2);
  var_3 show();
  var_3 playsoundonmovingent("sq_skillet_put_down_stove");
  var_2 playertakeitem("skillet_seasoned");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage4");
}

stage4_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Put down the skillet");
}

stage5_init() {}

randomizemeatchunks() {
  stage5_initrandommeatchunks(getEntArray("zombie_meat_chunk_gs", "targetname"));
  stage5_initrandommeatchunks(getEntArray("zombie_meat_chunk_ac", "targetname"));
  stage5_initrandommeatchunks(getEntArray("zombie_meat_chunk_sw", "targetname"));
  stage5_initrandommeatchunks(getEntArray("zombie_meat_chunk_bt", "targetname"));
}

stage5_initrandommeatchunks(var_0) {
  var_1 = common_scripts\utility::random(var_0);
  var_0 = common_scripts\utility::array_remove(var_0, var_1);

  foreach(var_3 in var_0) {
    var_3 delete();
  }
}

stage5_logic() {
  var_0 = getent("zombie_meat_chunk_gs", "targetname");

  if(isDefined(var_0)) {
    var_0 thread stage5_meat_handler();
  }

  var_1 = getent("zombie_meat_chunk_ac", "targetname");

  if(isDefined(var_1)) {
    var_1 thread stage5_meat_handler();
  }

  var_2 = getent("zombie_meat_chunk_sw", "targetname");

  if(isDefined(var_2)) {
    var_2 thread stage5_meat_handler();
  }

  var_3 = getent("zombie_meat_chunk_bt", "targetname");

  if(isDefined(var_3)) {
    var_3 thread stage5_meat_handler();
  }

  var_4 = common_scripts\utility::getstruct("burgertown_stove_interact", "targetname");
  var_4 thread stage5_stove_handler();
}

stage5_meat_handler() {
  level endon("main_stage5_over");
  self show();
  var_0 = spawnfx(common_scripts\utility::getfx("insects_flies_landing"), self.origin);
  triggerfx(var_0);
  var_1 = common_scripts\utility::getstruct(self.target, "targetname");
  var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", ::playerhasnomeat, undefined, "main_stage5_over", 80);
  var_1 waittill("acquired", var_2);

  if(!isDefined(var_2.playedpickupmeat)) {
    var_2 thread playerplaysqvo(1, 0.5);
    var_2.playedpickupmeat = 1;
  }

  var_2 playergivemeat();
  playsoundatpos(self.origin, "sq_pick_up_meat");
  self delete();
  var_0 delete();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("This looks tasty. Just need a place to cook it.");
}

playerhasmeat() {
  return maps\mp\zombies\_util::is_true(self.hasmeat);
}

playerhasnomeat() {
  return maps\mp\zombies\_util::is_true(!self.hasmeat);
}

playergivemeat() {
  self setclientomnvar("ui_zm_ee_int", 1);
  self.hasmeat = 1;
}

stage5_stove_handler() {
  level endon("main_stage5_over");
  var_0 = getEntArray("placed_zombie_meat_chunks", "targetname");
  var_1 = undefined;

  while(var_0.size > 0) {
    thread maps\mp\zombies\_zombies_sidequests::fake_use("used", ::playerhasmeat, undefined, "main_stage5_over");
    self waittill("used", var_1);
    var_2 = common_scripts\utility::random(var_0);
    var_2 show();
    playFX(common_scripts\utility::getfx("dlc_zombie_blood_splat_sm"), var_2.origin);
    playsoundatpos(var_2.origin, "sq_place_meat");
    var_0 = common_scripts\utility::array_remove(var_0, var_2);
    var_1 thread playertakeitem("meat");

    if(!isDefined(var_1.playedstovemeat)) {
      var_1 thread playerplaysqvo(2, 0.5);
      var_1.playedstovemeat = 1;
    }

    maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Hmm...gonna need more meat than this");
  }

  if(isDefined(var_1)) {
    var_1 thread playerplaysqvo(6, 1);
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage5");
}

stage5_end(var_0) {
  var_4 = getEntArray("placed_zombie_meat_chunks", "targetname");

  foreach(var_6 in var_4) {
    var_6 delete();
  }

  var_8 = getent("zombie_patty_raw", "targetname");
  var_8 show();
  playFX(common_scripts\utility::getfx("dlc_zombie_blood_splat_sm"), var_8.origin);
  playsoundatpos(var_8.origin, "sq_meat_patty");
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Looks like we need something to cook it with");
}

stage6_init() {}

stage6_logic() {
  var_0 = getent("zombie_patty_raw", "targetname");
  level waittill("burger_patty_cooked", var_1);

  if(isDefined(var_1)) {
    var_1 thread playerplaysqvo(7, 0.5);
  }

  var_0 thread stage6_cookedpattyfx();
  playsoundatpos(var_0.origin, "sq_patty_finished");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage6");
}

stage6_cookedpattyfx() {
  var_0 = spawnfx(common_scripts\utility::getfx("brg_skillet_charbroil"), self.origin);
  triggerfx(var_0);
  self playLoopSound("sq_meat_patty_cook");
  self waittill("kill_cooked_fx");
  var_0 delete();
}

stage6_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("It's cooked to perfection! Now all we need is a bun...");
}

stage7_init() {
  level.processenemykilledfunc = ::processenemykilled;
  level.sq_droppedbuns = [];
  level.pickedupbun = 0;
}

stage7_logic() {
  while(level.pickedupbun == 0) {
    wait 0.05;
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage7");
}

playerhasbun() {
  return maps\mp\zombies\_util::is_true(self.hasbun);
}

playergivebun() {
  self setclientomnvar("ui_zm_ee_int", 11);
  self.hasbun = 1;
}

processenemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("main_stage7_over");

  if(level.pickedupbun == 1) {
    return;
  }
  if(!isDefined(self.burgertownemployee) || !self.burgertownemployee) {
    return;
  }
  if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self)) {
    return;
  }
  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    return;
  }
  if(maps\mp\zombies\_util::istrapweapon(var_4)) {
    return;
  }
  if(level.sq_droppedbuns.size >= 1) {
    return;
  }
  var_9 = randomfloat(1);

  if(var_9 < 0.25) {
    level thread dropbun(self.origin);
  }
}

dropbun(var_0) {
  level endon("main_stage7_over");
  var_0 = var_0 + (0, 0, 16);
  var_1 = spawn("script_model", var_0);
  var_1.angles = (0, 0, 0);
  var_1 setModel("dlc2_brg_bun");
  var_1 notsolid();
  var_2 = spawn("trigger_radius", var_0, 0, 32, 32);
  var_1.trigger = var_2;
  level.sq_droppedbuns[level.sq_droppedbuns.size] = var_1;
  var_1 thread bunpickup();
  var_1 thread buntimer();
  var_1 thread bunbounce();
}

bunbounce() {
  self scriptmodelplayanimdeltamotion("mp_dogtag_spin");
}

bunpickup() {
  self endon("deleted");
  level endon("main_stage7_over");
  var_0 = self.origin;

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(isPlayer(var_1) && !var_1 playerhasbun()) {
      var_1 playergivebun();
      var_1 playlocalsound("sq_bun_pickup");
      level.pickedupbun = 1;
      thread removebun(self);
      return;
    }
  }
}

buntimer() {
  self endon("deleted");
  wait 15;
  thread bunstartflashing();
  wait 8;
  level thread removebun(self);
}

bunstartflashing() {
  self endon("deleted");
  level endon("main_stage7_over");

  for(;;) {
    self ghost();
    wait 0.25;
    self show();
    wait 0.25;
  }
}

removebun(var_0, var_1) {
  var_0 notify("deleted");
  waitframe();

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
  }

  var_0 delete();

  if(!maps\mp\zombies\_util::is_true(var_1)) {
    level.sq_droppedbuns = common_scripts\utility::array_removeundefined(level.sq_droppedbuns);
  }
}

stage7_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("I've got the bun.");
}

stage8_init() {}

playergiveburgerinfected() {
  self setclientomnvar("ui_zm_ee_int", 7);
  self.hasburgerinfected = 1;
  thread playerplaysqvo(8, 0.5);
}

stage8_logic() {
  var_0 = getent("zombie_patty_raw", "targetname");
  var_1 = getent("zombie_burger", "targetname");
  var_2 = common_scripts\utility::getstruct("burgertown_stove_interact", "targetname");
  var_2 thread maps\mp\zombies\_zombies_sidequests::fake_use("assembled", ::playerhasbun, undefined, "main_stage8_over");
  var_2 waittill("assembled", var_3);
  var_3 thread playertakeitem("bun");
  var_0 notify("kill_cooked_fx");
  var_0 stoploopsound();
  var_0 delete();
  var_1 show();
  var_1 playSound("sq_burger_created");
  var_4 = spawnfx(common_scripts\utility::getfx("brg_infected_burger"), var_1.origin);
  triggerfx(var_4);
  wait 1;
  var_2 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", undefined, undefined, "main_stage8_over");
  var_2 waittill("acquired", var_3);
  playsoundatpos(var_1.origin, "sq_burger_pickup");
  var_4 delete();
  var_1 delete();
  var_3 playergiveburgerinfected();
  var_3 thread stage8_infected_burger();
}

stage8_infected_burger() {
  thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
  self waittill("cured");
  thread playergiveburger();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage8");
}

stage8_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Cured from infected burger");
}

stage9_init() {}

playergiveburger() {
  self setclientomnvar("ui_zm_ee_int", 8);
  self.hasburger = 1;
  self.hasburgerinfected = undefined;
  thread playerplaysqvo(9, 1);
}

playerhasburger() {
  return maps\mp\zombies\_util::is_true(self.hasburger);
}

stage9_logic() {
  var_0 = getent("murderbot_static_thumbsup", "targetname");
  var_1 = getent("murderbot_animscripted", "targetname");
  level.zmbsqbeaufordnoresponse = 1;
  var_2 = common_scripts\utility::getstruct("murderbot_use", "targetname");
  var_2 thread maps\mp\zombies\_zombies_sidequests::fake_use("feed", ::playerhasburger, undefined, "main_stage9_over", 80);
  var_2 waittill("feed", var_3);
  var_0 delete();
  var_1 show();
  thread murderbot_animate("zom_mbot_activation_yumm");
  var_3 playertakeitem("burger");
  playsoundatpos((325, -4086, 209), "zmb_murderbot_bellyrub");
  level thread beaufordburgerbatteryhint();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage9");
}

beaufordburgerbatteryhint() {
  playbeaufordsqvo(4, 0.5);
  var_0 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
  var_1 = var_0[0];

  if(!isDefined(var_1)) {
    return;
  }
  var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
  var_2 = 2;

  if(common_scripts\utility::cointoss()) {
    var_2 = 3;
  }

  playbeaufordsqvo(var_2);
  wait 2;
  level.zmbsqbeaufordnoresponse = undefined;
}

stage9_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Beauford enjoyed your offering!");
  var_4 = getent("battery_screen_on", "targetname");
  var_4 playLoopSound("sq_screen_on_lp");
  var_5 = getent("battery_screen_off", "targetname");
  var_5 hide();
  var_4 show();
  var_4 playSound("sq_screen_on");
}

stage10_init() {
  level.batteryacquired = 0;
  var_0 = common_scripts\utility::getstruct("battery_pickup_use", "targetname");
  var_0 thread stage10_battery_pickup();
}

batterydooropen() {
  return maps\mp\zombies\_util::is_true(self.batteryisopen);
}

playerhasbatteryempty() {
  return maps\mp\zombies\_util::is_true(self.hasbatterydepleted);
}

playerhasbatteryfull() {
  return maps\mp\zombies\_util::is_true(self.hasbatterycharged);
}

playergivebattery(var_0) {
  switch (var_0) {
    case "depleted":
      self setclientomnvar("ui_zm_ee_int", 10);
      self.hasbatterydepleted = 1;
      thread playerplaysqvo(16, 0.5);
      break;
    case "charged":
      self setclientomnvar("ui_zm_ee_int", 9);
      self.hasbatterycharged = 1;
      thread playerplaysqvo(17, 0.5);
      break;
  }
}

stage10_logic() {
  var_0 = common_scripts\utility::getstruct("battery_compartment_activate", "targetname");
  var_1 = getent("battery_door", "targetname");

  while(level.batteryacquired == 0) {
    if(getdvarint("battery_open") == 0) {
      var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened", undefined, undefined, "main_stage10_over", 80);
      var_0 waittill("opened", var_2);
      var_2 thread playbatterysounds(var_1);

      foreach(var_2 in level.players) {
        var_2.batteryisopen = 1;
      }

      var_1 movez(12, 0.25);
      wait 7;
      var_1 movez(-12, 0.25);
      var_1 playSound("sq_battery_door_close");
      wait 0.25;

      foreach(var_2 in level.players) {
        var_2.batteryisopen = 0;
      }

      continue;
    }

    wait 3;
    var_1 movez(12, 0.25);
    wait 7;
    var_1 movez(-12, 0.25);
  }
}

playbatterysounds(var_0) {
  self playlocalsound("sq_screen_interact");
  wait 1.3;
  var_0 playSound("sq_battery_door_open");
}

stage10_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got battery");
}

stage10_battery_pickup() {
  var_0 = getent("battery_depleted", "targetname");
  thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", ::batterydooropen, undefined, "main_stage10_over");
  self waittill("acquired", var_1);
  var_0 playSound("sq_battery_grab");
  var_0 delete();
  level.batteryacquired = 1;
  var_1 thread playergivebattery("depleted");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage10");
}

stage11_init() {
  createthreatbiasgroup("charging_battery");
  level.batterychargecount = 0;
}

stage11_logic() {
  var_0 = getent("battery_charging", "targetname");
  var_1 = getent("battery_charged", "targetname");
  var_2 = getent("battery_charge_fxorg", "targetname");
  var_0.charged = 0;
  var_0 thread stage11_battery_fx(var_2);
  var_3 = common_scripts\utility::getstruct("battery_charge_use", "targetname");
  var_3 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed", ::playerhasbatteryempty, undefined, "main_stage11_over");
  var_3 waittill("placed", var_4);
  var_0 playSound("sq_battery_plugin");
  var_4 thread playertakeitem("battery_depleted");
  var_0 thread stage11_battery_setup();
  var_0 thread stage11_battery_charge_counter();
}

stage11_battery_setup() {
  self show();
  self.charging = 1;
  self notify("charging");
  self makeentitysentient("allies");
  self setthreatbiasgroup("charging_battery");
  setthreatbias("zombies", "charging_battery", 1000);
  self playLoopSound("sq_battery_charge");
  thread maps\mp\gametypes\_damage::setentitydamagecallback(100000, undefined, ::stage11_onbatterydeath);
  thread stage11_monitor_battery_damage();
  thread stage11_knockout_battery();
  thread stage11_battery_charge_monitor();
  thread stage11_swap_batteries();
}

stage11_monitor_battery_damage() {
  level endon("main_stage11_over");
  self endon("death");

  for(;;) {
    if(self.damagetaken < 200) {
      wait 0.5;
      continue;
    } else {
      self notify("removed");
      self.charging = 0;
      maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Battery down!!");
      self waittill("charging");
    }

    wait 0.5;
  }
}

stage11_knockout_battery() {
  level endon("main_stage11_over");
  self endon("charged");
  var_0 = getent("battery_removed", "targetname");
  var_1 = common_scripts\utility::getstruct("battery_replace_use", "targetname");

  for(;;) {
    self waittill("removed");
    var_2 = spawnfx(common_scripts\utility::getfx("spark_burst_runner_brg"), var_0.origin);
    triggerfx(var_2);
    self stoploopsound();
    self freeentitysentient();
    self.damagetaken = 0;
    stage11_battery_move(var_0);
    var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("replaced", undefined, undefined, "main_stage11_over");
    var_1 waittill("replaced", var_3);
    var_2 delete();
    var_0 hide();
    self show();
    self makeentitysentient("allies");
    self setthreatbiasgroup("charging_battery");
    self.charging = 1;
    self notify("charging");
    self playLoopSound("sq_battery_charge");
  }
}

stage11_battery_move(var_0) {
  var_1 = self.origin;
  var_2 = self.angles;
  self moveto(var_0.origin, 0.35);
  self rotateto(var_0.angles, 0.35);
  wait 0.35;
  self hide();
  var_0 show();
  self.origin = var_1;
  self.angles = var_2;
}

stage11_battery_fx(var_0) {
  level endon("game_ended");
  var_1 = spawnfx(common_scripts\utility::getfx("dlc_elec_panel_charging"), var_0.origin, anglesToForward(var_0.angles + (0, 0, 0)), anglestoup(var_0.angles + (0, 0, 90)));

  while(self.charged == 0) {
    self waittill("charging");

    if(!isDefined(var_1)) {
      var_1 = spawnfx(common_scripts\utility::getfx("dlc_elec_panel_charging"), var_0.origin, anglesToForward(var_0.angles + (0, 0, 0)), anglestoup(var_0.angles + (0, 0, 90)));
    }

    triggerfx(var_1);
    common_scripts\utility::waittill_any("removed", "charged");
    var_1 delete();
  }

  var_2 = spawnfx(common_scripts\utility::getfx("dlc_elec_panel_charge_full"), var_0.origin, anglesToForward(var_0.angles + (0, 0, 0)), anglestoup(var_0.angles + (0, 0, 90)));
  triggerfx(var_2);
}

stage11_battery_charge_monitor() {
  while(level.batterychargecount < 60) {
    wait 0.5;
  }

  self notify("charged");
  self.charged = 1;
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Battery is fully charged!");
}

stage11_battery_charge_counter() {
  self endon("charged");

  for(;;) {
    if(self.charging == 1) {
      wait 1;
      level.batterychargecount++;
      continue;
    }

    self waittill("charging");
  }
}

stage11_swap_batteries() {
  var_0 = getent("battery_charging", "targetname");
  var_1 = getent("battery_charged", "targetname");
  var_2 = common_scripts\utility::getstruct("battery_charge_use", "targetname");
  self waittill("charged");
  self stoploopsound();
  var_0 delete();
  var_1 show();
  var_1 playSound("sq_battery_charged");
  var_2 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", undefined, undefined, "main_stage11_over");
  var_2 waittill("acquired", var_3);
  var_1 playSound("sq_battery_grab");
  var_3 thread playergivebattery("charged");
  var_1 delete();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage11");
}

stage11_onbatterydeath(var_0, var_1, var_2, var_3) {
  self notify("damaged", var_0, var_2, var_1);
}

stage11_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got charged battery");
}

stage12_init() {
  thread burger_room_escape();
}

playerhaskey() {
  return maps\mp\zombies\_util::is_true(self.haskey);
}

playergivekey() {
  self setclientomnvar("ui_zm_ee_int", 12);
  self.haskey = 1;
  playerplaysqvo(13, 1);
}

stage12_logic() {
  level.zmbsqbeaufordnoresponse = 1;
  var_0 = common_scripts\utility::getstruct("murderbot_use", "targetname");
  var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("offered", undefined, undefined, "main_stage12_over", 80);
  var_0 waittill("offered", var_1);
  var_1 playlocalsound("sq_battery_grab");
  var_1 thread playertakeitem("battery_charged");
  thread murderbot_animate("zom_mbot_activation_key");
  playsoundatpos((325, -4086, 209), "zmb_murderbot_give_key");
  thread stage12_spawn_key();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Beauford is energized!");
  level thread playbeaufordsqvo(5);
  var_2 = common_scripts\utility::getstruct("burger_tower_use", "targetname");
  var_2 thread stage12_tower_access();
}

stage12_spawn_key() {
  var_0 = common_scripts\utility::getstruct("burgerkey_use", "targetname");
  var_1 = getent("burger_tower_key", "targetname");
  wait 1.5;
  var_1 show();
  var_1 scriptmodelplayanimdeltamotion("mp_dogtag_spin");
  var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", undefined, undefined, "main_stage12_over", 80);
  var_0 waittill("acquired", var_2);
  var_1 playSound("sq_key_receive");
  var_1 delete();
  var_2 thread playergivekey();
  level notify("player_has_key");
  wait 4;
  level.zmbsqbeaufordnoresponse = undefined;
}

stage12_tower_access() {
  var_0 = common_scripts\utility::getStructArray("burger_tower_destination", "targetname");
  var_1 = common_scripts\utility::getstruct("drive_decrypted_use", "targetname");
  var_2 = getent("burger_screen_disabled", "targetname");
  var_3 = getent("burger_screen_decrypt", "targetname");
  thread maps\mp\zombies\_zombies_sidequests::fake_use("unlocked", ::playerhaskey, undefined, "main_stage12_over", 100);
  self waittill("unlocked", var_4);
  level.burgerhatchlocked = 0;
  var_4 playlocalsound("sq_burger_door_opened_2D");
  playsoundatpos((1135, -3494, 494), "sq_burger_door_opened");
  var_4 playertakeitem("key");
  var_5 = common_scripts\utility::random(var_0);
  var_4 thread burger_teleport(var_5.origin, var_5.angles);
  level notify("burger_is_occupied");
  level.burgerhatchlocked = 1;
  thread burger_room_valve_lock("locked");
  var_4 playerhide();
  var_4 thread burger_room_monitor();
  level thread burger_room_free_access();
  var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "main_stage12_over", 80);
  var_1 waittill("activated", var_4);
  var_3 hide();
  var_2 show();
  var_2 playSound("screen_negative_interact");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage12");
}

burger_room_valve_lock(var_0) {
  var_1 = getent("burger_tower_valve", "targetname");
  var_1.islocked = 1;

  switch (var_0) {
    case "locked":
      level.burgerislocked = 1;
      var_1 rotateto((0, -90, 90), 0.2);
      break;
    case "unlocked":
      level.burgerislocked = 0;
      var_1 rotateto((0, 0, 90), 0.2);
      break;
  }
}

burger_room_locked_audio() {
  level endon("game_ended");
  var_0 = common_scripts\utility::getstruct("burger_tower_lock_use", "targetname");

  for(;;) {
    var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("used", undefined, undefined, undefined, 80);
    var_0 waittill("used", var_1);

    if(level.burgerhatchlocked == 1) {
      var_1 playlocalsound("sq_burger_door_locked");
    }

    wait 1;
  }
}

burger_room_free_access() {
  level endon("close_burger_for_rocket");

  if(isDefined(level.zmbsqburgerroomopen)) {
    return;
  }
  level.zmbsqburgerroomopen = 1;
  var_0 = common_scripts\utility::getStructArray("burger_tower_destination", "targetname");
  var_1 = common_scripts\utility::getstruct("burger_tower_use", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  for(;;) {
    level waittill("burger_is_empty");

    if(isDefined(level.burgerislocked) && !level.burgerislocked) {
      thread burger_room_valve_lock("locked");
    }

    level.burgerhatchlocked = 1;
    wait 10;
    level.burgerhatchlocked = 0;
    var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened", undefined, undefined, undefined, 100);

    if(isDefined(level.burgerislocked) && level.burgerislocked) {
      thread burger_room_valve_lock("unlocked");
    }

    var_1 waittill("opened", var_2);
    var_3 = common_scripts\utility::random(var_0);
    var_2 thread burger_teleport(var_3.origin, var_3.angles);
    level notify("burger_is_occupied");
    level.burgerhatchlocked = 1;
    var_2 thread burger_room_monitor();

    if(isDefined(level.burgerislocked) && !level.burgerislocked) {
      thread burger_room_valve_lock("locked");
    }

    var_2 maps\mp\zombies\_util::setallignoreme(1);
    var_2 playerhide();
    var_2 playlocalsound("sq_burger_door_opened_2D");
    playsoundatpos((1135, -3494, 494), "sq_burger_door_opened");
  }
}

burger_room_lockdown() {
  var_0 = common_scripts\utility::getStructArray("burger_tower_exit", "targetname");
  var_1 = getent("burger_tower_vol", "targetname");
  wait 2;
  level notify("close_burger_for_rocket");

  if(isDefined(level.burgerislocked) && !level.burgerislocked) {
    thread burger_room_valve_lock("locked");
  }

  level.burgerhatchlocked = 1;

  foreach(var_3 in level.players) {
    if(var_3 istouching(var_1)) {
      var_4 = common_scripts\utility::random(var_0);
      var_3 thread burger_teleport(var_4.origin, var_4.angles);
      var_3 maps\mp\zombies\_util::setallignoreme(0);
      var_3 playershow();
      level notify("burger_is_empty");
    }
  }

  level waittill("drive_is_decrypted");
  level.zmbsqburgerroomopen = undefined;
  level thread burger_room_free_access();
  waitframe();
  level notify("burger_is_empty");
}

burger_room_monitor() {
  var_0 = common_scripts\utility::getStructArray("burger_tower_exit", "targetname");
  var_1 = getent("burger_tower_vol", "targetname");
  var_2 = gettime() + 20000;

  while(gettime() < var_2) {
    wait 0.2;

    if(self istouching(var_1)) {
      continue;
    } else {
      return;
    }
  }

  foreach(var_4 in level.players) {
    if(var_4 istouching(var_1)) {
      var_5 = common_scripts\utility::random(var_0);
      var_4 thread burger_teleport(var_5.origin, var_5.angles);
      var_4 maps\mp\zombies\_util::setallignoreme(0);
      var_4 playershow();
      level notify("burger_is_empty");
    }
  }
}

burger_room_escape() {
  var_0 = common_scripts\utility::getStructArray("burger_tower_exit", "targetname");
  var_1 = common_scripts\utility::getstruct("burger_tower_escape_use", "targetname");

  for(;;) {
    var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("used", undefined, undefined, undefined, 80);
    var_1 waittill("used", var_2);
    var_3 = common_scripts\utility::random(var_0);
    var_2 thread burger_teleport(var_3.origin, var_3.angles);
    var_2 maps\mp\zombies\_util::setallignoreme(0);
    var_2 playershow();
    level notify("burger_is_empty");
    var_2 playlocalsound("sq_burger_door_closed_2D");
  }
}

burger_teleport(var_0, var_1) {
  thread maps\mp\zombies\_teleport::player_teleport(var_0, var_1);
}

stage12_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Finished burger room");
}

stage13_init() {
  level.gator_kills_active = 1;
}

playerhasarm() {
  return maps\mp\zombies\_util::is_true(self.hasarm);
}

playergivearm() {
  self setclientomnvar("ui_zm_ee_int", 3);
  self.hasarm = 1;
  thread playerplaysqvo(19, 0.5);
}

stage13_logic() {
  var_0 = common_scripts\utility::getstruct("warehouse_safe_use", "targetname");

  for(;;) {
    var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened", undefined, undefined, "main_stage13_over");
    var_0 waittill("opened", var_1);
    playsoundatpos(var_0.origin, "ui_button_error");

    if(!isDefined(var_1.playedseveredhandhint)) {
      var_1 playerplaysqvo(18);
      var_1.playedseveredhandhint = 1;
    }

    wait 1;
  }
}

stage13_spawn_arm() {
  level notify("arm_spawned");
  level.sqarmspawned = 1;
  var_0 = common_scripts\utility::getstruct("gator_water_level", "script_noteworthy");
  var_1 = var_0.origin[2] - self.origin[2];
  var_2 = spawn("script_model", self.origin + (0, 0, var_1));
  var_2 setModel("dlc2_zom_gib_arm_pickup");
  var_2 scriptmodelplayanimdeltamotion("mp_dogtag_spin");
  var_3 = spawn("script_origin", var_2.origin);
  var_3 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", undefined, undefined, "main_stage13_over", 100);
  var_3 waittill("acquired", var_4);
  var_4 thread playergivearm();
  playsoundatpos(var_2.origin, "sq_severedhand_grab");
  var_2 delete();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage13");
}

stage13_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got severed arm");
  level.gator_kills_active = 0;
}

stage14_init() {}

playerhasdriveencrypted() {
  return maps\mp\zombies\_util::is_true(self.hasdriveencrypted);
}

playergivedriveencrypted() {
  self setclientomnvar("ui_zm_ee_int", 5);
  self.hasdriveencrypted = 1;
  var_0 = 20;

  if(maps\mp\zombies\_util::get_player_index(self) == maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix("it")) {
    if(randomint(100) < 10) {
      var_0 = 23;
    }
  }

  thread playerplaysqvo(var_0, 0.5);
}

stage14_logic() {
  var_0 = getent("safe_door_org", "targetname");
  var_1 = getEntArray("warehouse_safe_door", "targetname");
  var_2 = getent("thumb_drive_encrypted", "targetname");
  var_3 = getent("fingerprint_scanner", "targetname");

  foreach(var_5 in var_1) {
    var_5 linktosynchronizedparent(var_0);
  }

  var_7 = common_scripts\utility::getstruct("warehouse_safe_use", "targetname");
  var_7 thread maps\mp\zombies\_zombies_sidequests::fake_use("opened", ::playerhasarm, undefined, "main_stage14_over", 80);
  var_7 waittill("opened", var_8);
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_pass"), var_3, "tag_origin");
  var_8 playertakeitem("arm");
  var_0 rotateyaw(-125, 1);
  var_0 playSound("sq_safe_door_open");
  var_9 = common_scripts\utility::getstruct("thumb_drive_use", "targetname");
  var_9 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", undefined, undefined, "main_stage14_over", 80);
  var_9 waittill("acquired", var_8);
  var_2 playSound("sq_drive_grab");
  var_2 delete();
  var_8 thread playergivedriveencrypted();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage14");
}

stage14_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Took encrypted thumb drive");
}

stage15_init() {}

stage15_logic() {
  var_0 = getent("thumb_drive_decrypting", "targetname");
  var_1 = getent("burger_screen_decrypt", "targetname");
  var_2 = getent("burger_screen_disabled", "targetname");
  var_3 = common_scripts\utility::getstruct("drive_decrypted_use", "targetname");
  var_3 thread maps\mp\zombies\_zombies_sidequests::fake_use("placed", ::playerhasdriveencrypted, undefined, "main_stage15_over", 80);
  var_3 waittill("placed", var_4);
  var_0 show();
  var_2 delete();
  var_1 show();
  var_4 playertakeitem("drive_encrypted");
  thread drive_decrypt_audio(var_0, var_1);
  level thread stage15_decryptiontimer();
  thread burger_firing_event();
  thread burger_room_lockdown();
  level waittill("drive_is_decrypted");
  var_1 stoploopsound();
  var_1 playSound("sq_drive_finished");
}

drive_decrypt_audio(var_0, var_1) {
  var_0 playSound("sq_drive_plugin");
  wait 0.2;
  var_1 playLoopSound("sq_drive_decrypt");
}

stage15_decryptiontimer() {
  wait 30;

  foreach(var_1 in level.players) {
    var_1 thread rocket_countdowntimer();
  }

  level waittill("rocket_countdown_complete");
  level notify("drive_is_decrypted");
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Drive is Decrypted!!");
  thread burger_rocket_launch();
}

rocket_countdowntimer() {
  self endon("disconnect");
  var_0 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, 0);
  var_0 thread update_countdown();
  var_0.fontscale = 2;
  level waittill("rocket_countdown_complete");
  var_0 maps\mp\gametypes\_hud_util::destroyelem();
}

update_countdown() {
  self endon("disconnect");

  for(var_0 = 0; var_0 < 5; var_0++) {
    var_1 = undefined;

    switch (5 - var_0) {
      case 5:
        var_1 = &"ZOMBIE_CIVILIANS_5";
        break;
      case 4:
        var_1 = &"ZOMBIE_CIVILIANS_4";
        break;
      case 3:
        var_1 = &"ZOMBIE_CIVILIANS_3";
        break;
      case 2:
        var_1 = &"ZOMBIE_CIVILIANS_2";
        break;
      case 1:
        var_1 = &"ZOMBIE_CIVILIANS_1";
        break;
    }

    self settext(var_1);
    playsoundatpos((0, 0, 0), "zmb_weapon_upgrade_countdown");
    wait 1;
  }

  level notify("rocket_countdown_complete");
}

burger_rocket_launch() {
  var_0 = getent("burger_rocket_org", "targetname");
  var_1 = getent("burger_rocket_dest", "targetname");
  var_2 = getent("burger_rocket", "targetname");
  var_3 = getent("burger_rocket_fins", "targetname");
  var_4 = getEntArray("burger_rocket_static", "targetname");
  var_0 thread rocket_attach(var_2, var_3);
  var_0 thread rocket_thruster_fx();
  var_0 thread rocket_move();
  var_4 thread rocket_static_hide();
  playrumblelooponposition("artillery_rumble", var_0.origin);
  earthquake(0.5, 8, var_0.origin, 1500);
  playsoundatpos((1217, -3418, 459), "sq_rocket_screen_shake_front");
  wait 8;
  stopallrumbles();
  var_0 waittill("finished");
}

rocket_attach(var_0, var_1) {
  var_0 linktosynchronizedparent(self);

  if(level.nextgen) {
    var_1 linktosynchronizedparent(self);
    wait 2;
    var_1 show();
  }

  self waittill("finished");
  var_0 delete();

  if(level.nextgen) {
    var_1 delete();
  }

  self delete();
}

rocket_thruster_fx() {
  var_0 = getent("burger_rocket_fx", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("dlc2_brg_burger_bomb");
  var_1 linktosynchronizedparent(self);
  var_2 = spawnlinkedfx(common_scripts\utility::getfx("brg_rocket_thruster"), var_1, "tag_fx");
  wait 2;
  triggerfx(var_2);
  playsoundatpos((1217, -3418, 459), "sq_rocket_launch");
  self waittill("finished");
  var_2 delete();
  var_1 delete();
}

rocket_move() {
  self movez(11744, 20, 4);
  wait 20;
  self notify("finished");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage15");
}

rocket_static_hide() {
  foreach(var_1 in self) {
    var_1 notsolid();
    var_1 delete();
  }

  if(level.nextgen) {
    maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (2200, -4840, 444), (90, 0, 0));
  }
}

burger_firing_event() {
  bombs_init();
  var_0 = level.bombsonstandby.size;
  level.bomb_targets = common_scripts\utility::array_randomize(level.bomb_targets);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(isDefined(level.bombsonstandby[0])) {
      level.bombsonstandby[0] bomb_fires(var_1);
      wait 4;
    }
  }

  wait 1;
}

bombs_init() {
  wait 1;
  level.bombsonstandby = [];
  level.launch_point = common_scripts\utility::getstruct("org_bomb_launch", "targetname");
  level.bomb_targets = common_scripts\utility::getStructArray("org_bomb_targets", "targetname");
  level.bomb_count_max = 12;
  level.bomb_count_min = 2;

  for(var_0 = 0; var_0 < level.bomb_count_max; var_0++) {
    var_1 = spawn("script_model", (0, 0, -10));
    var_1 setModel("dlc2_brg_burger_bomb");
    var_1 thread bomb_physics_impact_watch();
    var_2 = 24;
    var_3 = getent("bomb_pickup_" + (var_0 + 1), "targetname");

    if(isDefined(var_3)) {
      var_3.origin = var_1.origin;
    } else {
      var_3 = spawn("trigger_radius", var_1.origin - (0, 0, var_2 / 2), 0, var_2, var_2);
    }

    var_3 enablelinkto();
    var_3 linkto(var_1);
    var_3.no_moving_platfrom_unlink = 1;
    var_4 = [var_1];
    var_5 = maps\mp\gametypes\_gameobjects::createcarryobject("any", var_3, var_4, (0, 0, 32));
    var_5 maps\mp\gametypes\_gameobjects::allowcarry("any");
    var_5 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    var_5.objidpingenemy = 1;
    var_5.objpingdelay = 1.0;
    var_5.allowweapons = 0;
    var_5.carryweapon = "iw5_dlc2burgergun_mp";
    var_5.keepcarryweapon = 1;
    var_5.waterbadtrigger = 0;
    var_5.visualgroundoffset = (0, 0, 30);
    var_5.canuseobject = ::bomb_can_pickup;
    var_5.onpickup = ::bomb_on_pickup;
    var_5.setdropped = ::bomb_set_dropped;
    var_5.carryweaponthink = ::bomb_throw;
    var_5.requireslos = 1;
    maps\mp\_utility::_objective_delete(var_5.objidallies);
    maps\mp\_utility::_objective_delete(var_5.objidaxis);
    maps\mp\_utility::_objective_delete(var_5.objidmlgspectator);
    var_5.compassicons = undefined;
    var_5.objidallies = undefined;
    var_5.objidaxis = undefined;
    var_5.objidmlgspectator = undefined;
    level.bombsonstandby[level.bombsonstandby.size] = var_5;
    waitframe();
  }
}

bomb_fires(var_0) {
  var_1 = level.bomb_targets[var_0];
  var_2 = self.visuals[0];
  var_2 show();
  var_2 dontinterpolate();
  self.bomb_fx_active = 0;
  var_2 physicsstop();
  var_2.origin = level.launch_point.origin;
  level.mines[level.mines.size] = var_2;
  var_3 = var_1.origin + (randomfloatrange(-10, 10), randomfloatrange(-10, 10), randomfloatrange(-10, 10));
  var_1.origin = (var_1.origin[0], var_1.origin[1], var_2.origin[2] + 600);
  var_4 = vectornormalize(var_1.origin - var_2.origin) * randomintrange(200, 300);
  var_5 = (0, 0, 0);
  var_2 physicslaunchserver(var_2.origin + var_5, var_4);
  aud_event_fire_bomb();
  thread bomb_fuse_default();
  level.bombsonstandby = common_scripts\utility::array_remove(level.bombsonstandby, self);
  bomb_fx_start();
  playFX(common_scripts\utility::getfx("cannon_firing"), level.launch_point.origin + (0, 0, 35));
  var_6 = anglesToForward(level.launch_point.origin);
  var_7 = anglestoup(level.launch_point.origin);
}

bomb_fuse_default() {
  self endon("stop_fuse");
  self endon("pickup_object");
  var_0 = 30;
  var_1 = self.visuals[0];
  playFXOnTag(common_scripts\utility::getfx("burger_bomb_fuse"), var_1, "tag_fx");

  while(var_0 > 0) {
    if(isDefined(self) && var_0 < 4) {
      playFX(common_scripts\utility::getfx("ball_flash"), self.visuals[0].origin);
    }

    wait 1;
    var_0 = var_0 - 1;
  }

  magicgrenademanual("iw5_dlc2burgerbomb_mp", self.visuals[0].origin, (0, 0, 0), 0);
  thread bomb_cleanup();
}

bomb_fuse_short() {
  self endon("stop_fuse");
  self endon("pickup_object");

  for(var_0 = 3; var_0 > 0; var_0 = var_0 - 1) {
    if(isDefined(self) && var_0 < 4) {
      playFX(common_scripts\utility::getfx("ball_flash"), self.visuals[0].origin);
    }

    wait 1;
  }

  magicgrenademanual("iw5_dlc2burgerbomb_mp", self.visuals[0].origin, (0, 0, 0), 0);
  thread bomb_cleanup();
}

bomb_can_pickup(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0.underwater) && var_0.underwater) {
    return 0;
  }

  if(isDefined(self.droptime) && self.droptime >= gettime()) {
    return 0;
  }

  if(!var_0 common_scripts\utility::isweaponenabled()) {
    return 0;
  }

  if(var_0 isusingturret()) {
    return 0;
  }

  if(isDefined(var_0.manuallyjoiningkillstreak) && var_0.manuallyjoiningkillstreak) {
    return 0;
  }

  var_1 = var_0 getcurrentweapon();

  if(isDefined(var_1)) {
    if(!valid_bomb_pickup_weapon(var_1)) {
      return 0;
    }
  }

  var_2 = var_0.changingweapon;

  if(isDefined(var_2) && var_0 isreloading()) {
    if(!valid_bomb_pickup_weapon(var_2)) {
      return 0;
    }
  }

  if(isDefined(var_0.exo_shield_on) && var_0.exo_shield_on == 1) {
    return 0;
  }

  if(var_0 maps\mp\_utility::isjuggernaut()) {
    return 0;
  }

  if(isbot(var_0) || isagent(var_0)) {
    return 0;
  }

  if(var_0 player_no_pickup_time()) {
    return 0;
  }

  return 1;
}

valid_bomb_pickup_weapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(var_0 == "iw5_dlc2burgergun_mp") {
    return 0;
  }

  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return 0;
  }

  if(var_0 == "iw5_combatknifegoliath_mp") {
    return 0;
  }

  return 1;
}

player_no_pickup_time() {
  return isDefined(self.nopickuptime) && self.nopickuptime > gettime();
}

bomb_on_pickup(var_0) {
  level.usestartspawns = 0;
  self notify("pickup_object");
  level.mines = common_scripts\utility::array_remove(level.mines, self.visuals[0]);
  var_1 = self.visuals[0] getlinkedparent();

  if(isDefined(var_1)) {
    self.visuals[0] unlink();
  }

  self.visuals[0] physicsstop();
  self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
  self.visuals[0] show();
  self.visuals[0] ghost();
  self.trigger maps\mp\_movers::stop_handling_moving_platforms();
  bomb_fx_stop();
  var_0 setweaponammoclip("iw5_dlc2burgergun_mp", 1);
  var_0 maps\mp\_utility::giveperk("specialty_ballcarrier", 0);
  var_0 thread display_bomb_prompt();
  thread bomb_last_stand(var_0);
  thread bomb_infected(var_0);
  var_0.hasbomb = 1;
  var_0 common_scripts\utility::_disableusability();
}

display_bomb_prompt() {
  var_0 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, 145);
  var_0 settext(&"ZOMBIE_BRG_BOMB_THROW");
  var_0.fontscale = 0.65;
  common_scripts\utility::waittill_any("weapon_fired", "drop_object", "begin_last_stand", "player_infected");
  self.hasbomb = 0;
  var_0 maps\mp\gametypes\_hud_util::destroyelem();
}

bomb_last_stand(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("drop_object");
  var_0 endon("weapon_fired");
  var_0 waittill("enter_last_stand");
  var_0 thread bomb_player_revived();
  thread bomb_carrier_cleanup();
  maps\mp\gametypes\_gameobjects::clearcarrier();
}

bomb_player_revived() {
  self waittill("revive");
  var_0 = self getweaponslistprimaries();
  self switchtoweaponimmediate(var_0[0]);
}

bomb_infected(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("weapon_fired");
  var_0 waittill("player_infected");
  thread bomb_carrier_cleanup();
  maps\mp\gametypes\_gameobjects::clearcarrier();
}

bomb_throw() {
  self endon("disconnect");
  thread bomb_throw_watch();
  self.carryobject waittill("dropped");
}

bomb_throw_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  var_0 = getdvarfloat("scr_ball_shoot_extra_pitch", -12);
  var_1 = getdvarfloat("scr_ball_shoot_force", 320);

  for(;;) {
    self waittill("weapon_fired", var_2);

    if(var_2 != "iw5_dlc2burgergun_mp") {
      continue;
    }
    break;
  }

  if(isDefined(self.carryobject)) {
    var_3 = self getangles();
    var_3 = var_3 + (var_0, 0, 0);
    var_3 = (clamp(var_3[0], -85, 85), var_3[1], var_3[2]);
    var_4 = anglesToForward(var_3);
    thread bomb_throw_active();
    wait 0.25;
    self playSound("mp_ul_ball_throw");
    self.carryobject bomb_create_killcam_ent();
    self.carryobject thread bomb_physics_launch_drop(var_4 * var_1, self);
  }
}

bomb_physics_impact_watch() {
  self endon("death");

  for(;;) {
    self waittill("physics_impact", var_0, var_1, var_2, var_3);
    var_4 = level._effect["ball_physics_impact"];

    if(isDefined(var_3) && isDefined(level._effect["ball_physics_impact_" + var_3])) {
      var_4 = level._effect["ball_physics_impact_" + var_3];
    }

    playFX(var_4, var_0, var_1);
    wait 0.3;
  }
}

bomb_throw_active() {
  self endon("death");
  self endon("disconnect");
  self.pass_or_throw_active = 1;
  self allowmelee(0);

  while("iw5_dlc2burgergun_mp" == self getcurrentweapon()) {
    waitframe();
  }

  self allowmelee(1);
  self.pass_or_throw_active = 0;
}

bomb_physics_launch_drop(var_0, var_1) {
  bomb_carrier_cleanup();
  self.ownerteam = "any";
  maps\mp\gametypes\_gameobjects::clearcarrier();
  bomb_physics_launch(var_0, var_1);
}

bomb_physics_launch(var_0, var_1) {
  var_2 = self.visuals[0];
  var_2.origin_prev = undefined;
  bomb_cleanup();
  var_3 = anglesToForward(var_1 getangles()) * 940 + anglestoup(var_1 getangles()) * 120;
  var_4 = var_1 getEye();
  var_5 = magicgrenademanual("iw5_dlc2burgerbomb_mp", var_4, var_3, 2, var_1);
}

bomb_create_killcam_ent() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self.killcament = spawn("script_model", self.visuals[0].origin);
  self.killcament linkto(self.visuals[0]);
  self.killcament setcontents(0);
  self.killcament setscriptmoverkillcam("explosive");
}

bomb_set_dropped(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self.isresetting = 1;
  self.droptime = gettime();
  self notify("dropped");
  var_1 = self.carrier;

  if(isDefined(var_1) && var_1.team != "spectator") {
    var_2 = var_1.origin;
  } else {
    var_2 = self.safeorigin;
  }

  var_3 = self.visuals[0];
  var_3.origin = var_2;
  var_3 show();
  var_3 physicslaunchserver(var_3.origin + (0, 1, 0));
  level.mines[level.mines.size] = var_3;
  thread bomb_fuse_short();
  bomb_carrier_cleanup();
  bomb_fx_start();
  self.ownerteam = "any";
  maps\mp\gametypes\_gameobjects::clearcarrier();
  return 1;
}

bomb_carrier_cleanup() {
  if(isDefined(self.carrier)) {
    self.carrier.nopickuptime = gettime() + 500;
    self.carrier maps\mp\_utility::_unsetperk("specialty_ballcarrier");
    self.carrier common_scripts\utility::_enableusability();
  }
}

bomb_dont_interpolate() {
  self.visuals[0] dontinterpolate();
  self.bomb_fx_active = 0;
}

bomb_cleanup() {
  self notify("stop_fuse");
  bomb_fx_stop();
  self.visuals[0] dontinterpolate();
  self.bomb_fx_active = 0;
  self.visuals[0] physicsstop();
  self.visuals[0].origin = (0, 0, 0);
  level.mines = common_scripts\utility::array_remove(level.mines, self.visuals[0]);

  foreach(var_1 in self.visuals) {
    var_1 delete();
  }

  self.trigger delete();
}

bomb_fx_start() {
  if(!bomb_fx_active()) {
    var_0 = self.visuals[0];
    playFXOnTag(common_scripts\utility::getfx("dlc_burger_bomb_trail"), var_0, "body_animate_jnt");
    playFXOnTag(common_scripts\utility::getfx("ball_idle"), var_0, "body_animate_jnt");
    var_0 hudoutlineenable(0, 0);
    self.bomb_fx_active = 1;
  }
}

bomb_fx_stop() {
  if(bomb_fx_active()) {
    var_0 = self.visuals[0];
    stopFXOnTag(common_scripts\utility::getfx("dlc_burger_bomb_trail"), var_0, "body_animate_jnt");
    killfxontag(common_scripts\utility::getfx("ball_idle"), var_0, "body_animate_jnt");
    killfxontag(common_scripts\utility::getfx("burger_bomb_fuse"), var_0, "tag_fx");
    var_0 hudoutlinedisable();
    var_0 stopsounds();
  }

  self.bomb_fx_active = 0;
}

bomb_fx_active() {
  return isDefined(self.bomb_fx_active) && self.bomb_fx_active;
}

aud_play_bomb_bounce() {
  if(isDefined(self)) {
    maps\mp\_audio::snd_play_in_space("wpn_clown_bomb_bounce", self.origin);
  }
}

aud_event_fire_bomb() {
  maps\mp\_audio::snd_play_in_space("ct3_cannon_shot", level.launch_point.origin);
}

stage15_end(var_0) {
  level thread playbeaufordsqvo(6, 3);
}

stage16_init() {
  var_0 = getent("thumb_drive_decrypted", "targetname");
  var_1 = getent("thumb_drive_decrypting", "targetname");
  var_1 delete();
  var_0 show();
}

playerhasdrivedecrypted() {
  return maps\mp\zombies\_util::is_true(self.hasdrivedecrypted);
}

playergivedrivedecrypted() {
  self setclientomnvar("ui_zm_ee_int", 6);
  self.hasdrivedecrypted = 1;
  thread playerplaysqvo(21, 0.5);
}

stage16_logic() {
  var_0 = getent("thumb_drive_decrypted", "targetname");
  var_1 = common_scripts\utility::getstruct("drive_decrypted_use", "targetname");
  var_1 thread maps\mp\zombies\_zombies_sidequests::fake_use("acquired", undefined, undefined, "main_stage16_over", 80);
  var_1 waittill("acquired", var_2);
  var_0 playSound("sq_drive_grab");
  var_0 delete();
  var_2 thread playergivedrivedecrypted();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage16");
}

stage16_end(var_0) {}

stage17_init() {}

stage17_logic() {
  level.zmbsqbeaufordnoresponse = 1;
  var_0 = common_scripts\utility::getstruct("murderbot_use", "targetname");
  var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::playerhasdrivedecrypted, undefined, "main_stage17_over", 80);
  var_0 waittill("activated", var_1);
  var_1 playertakeitem("drive_decrypted");
  playsoundatpos(var_0.origin, "sq_drive_grab");
  spawn_murderbot(var_1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage17");
}

stage17_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Beauford is loose!!");
  maps\mp\gametypes\zombies::giveplayerszombieachievement("DLC2_ZOMBIE_MEATISMURDER");
  set_side_quest_coop_data_burgertown();
}

set_side_quest_coop_data_burgertown() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.joinedround1) || !var_1.joinedround1) {
      continue;
    }
    var_2 = var_1 getcoopplayerdatareservedint("eggData");
    var_2 = var_2 | 4;
    var_1.sidequest = 1;
    var_1 setcoopplayerdatareservedint("eggData", var_2);
    setmatchdata("players", var_1.clientid, "startPrestige", var_1.sidequest);
  }
}

murderbot_test_setup() {
  var_0 = common_scripts\utility::getstruct("murderbot_use", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "main_stage1_over");
    var_0 waittill("activated", var_1);

    if(getdvarint("scr_zombieSidequestDebug", 0) == 1 && level.sidequeststarted == 0 && (!isDefined(level.zmbsqmurderbotstarted) || !level.zmbsqmurderbotstarted)) {
      spawn_murderbot(var_1);
    }

    wait 1;
  }
}

beauford_greetings() {
  level endon("main_stage16_over");

  while(!isDefined(level.players)) {
    waitframe();
  }

  var_0 = 10000;
  var_1 = common_scripts\utility::getstruct("murderbot_use", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  for(;;) {
    if(maps\mp\zombies\_util::is_true(level.zmbsqbeaufordnoresponse)) {
      waitframe();
      continue;
    }

    foreach(var_3 in level.players) {
      var_4 = distancesquared(var_3.origin, var_1.origin);

      if(var_4 < var_0) {
        playbeaufordvo("greeting");
        wait 30;
      }
    }

    waitframe();
  }
}

playercanhearbeaufordresponse() {
  return !playerhasburger() && !playerhasbatteryfull() && !playerhasdriveencrypted() && !playerhasdrivedecrypted() && !maps\mp\zombies\_util::is_true(level.zmbsqbeaufordnoresponse);
}

beauford_interact() {
  level endon("main_stage16_over");
  var_0 = common_scripts\utility::getstruct("murderbot_use", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::playercanhearbeaufordresponse, undefined, "main_stage16_over");
    var_0 waittill("activated", var_1);
    playbeaufordvo("response");
    wait 20;
  }
}

beauford_hit() {
  level endon("main_stage16_over");
  var_0 = getent("murderbot_static_thumbsup", "targetname");
  var_0.health = 99999;
  var_0.maxhealth = 99999;
  var_0 setCanDamage(1);
  var_0 setdamagecallbackon(1);
  var_0.damagecallback = ::_beauford_hit_internal;
  level.zmbsqbeaufordnexthitvo = 0;
}

_beauford_hit_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(gettime() > level.zmbsqbeaufordnexthitvo && !maps\mp\zombies\_util::is_true(level.zmbsqbeaufordnoresponse)) {
    if(playbeaufordvo("hit")) {
      level.zmbsqbeaufordnexthitvo = gettime() + 20000;
    }
  }
}

beauford_kills() {
  waitframe();
  var_0 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
  var_1 = var_0[0];

  if(!isDefined(var_1)) {
    return;
  }
  level waittill("beauford_spawned", var_2);
  var_2 endon("death");

  for(;;) {
    level waittill("zombie_damaged", var_3, var_4);

    if(isDefined(var_4) && var_4 == var_2) {
      playbeaufordvo("killzombie");
      wait 3;
    }
  }
}

spawn_murderbot(var_0) {
  level.zmbsqmurderbotstarted = 1;
  var_1 = getent("murderbot_animscripted", "targetname");
  var_2 = getent("speaker_box", "targetname");
  var_3 = getEntArray("speaker_box_coll", "targetname");
  var_4 = getent("bubby_clip", "targetname");
  var_4 notsolid();
  var_4 delete();

  foreach(var_6 in var_3) {
    var_6 notsolid();
    var_6 delete();
  }

  var_8 = common_scripts\utility::getstruct("murderbot_start", "script_noteworthy");
  var_9 = maps\mp\zombies\zombie_murderbot::spawnmurderbot(var_8, var_1, var_2);
  level notify("beauford_spawned", var_9);
  var_10 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("beauford");
  var_11 = var_10[0];

  if(isDefined(var_11)) {
    var_11 linkto(var_9, "j_head", (0, 0, 0), (0, 0, 0));
  }

  level thread spawn_murderbot_vo(var_0);
}

spawn_murderbot_vo(var_0) {
  waitframe();
  playbeaufordsqvowaitilldone(1, 0.5);
  wait 0.5;

  if(isDefined(var_0)) {
    var_0 thread playerplaysqvo(22, 0.5);
  }
}

init_song_sidequest() {
  level.sq_song_ent = getent("sq_song", "targetname");

  if(!isDefined(level.sq_song_ent)) {
    level.sq_song_ent = spawn("script_model", (0, 0, 0));
  }
}

sidequest_logic_song() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage1");
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage2");
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage3");
  var_3 = 0;

  for(;;) {
    var_4 = level common_scripts\utility::waittill_any_return_no_endon_death("song_stage1_over", "song_stage2_over", "song_stage3_over");
    var_3++;

    if(var_3 < 3) {
      thread song_play(var_3);
      continue;
    }

    thread song_play();
    break;
  }
}

song_play(var_0) {
  level notify("sq_song_play");
  level endon("sq_song_play");
  level endon("sq_song_stop");

  if(maps\mp\zombies\_util::is_true(level.sq_song_ent.playing)) {
    level.sq_song_ent stopsounds();
    level.sq_song_ent.playing = 0;
    wait 0.2;
  }

  var_1 = "zmb_mus_ee_02";

  if(!isDefined(var_0) || var_0 <= 0) {
    var_0 = musiclength("zmb_mus_ee_02");
  } else {
    var_1 = "zmb_mus_ee_02_prvw";
  }

  level.sq_song_ent playsoundonmovingent(var_1);
  level.sq_song_ent.playing = 1;
  wait(var_0);
  level.sq_song_ent scalevolume(0, 0.2);
  wait 0.2;
  level.sq_song_ent stopsounds();
  level.sq_song_ent.playing = 0;
  level.sq_song_ent scalevolume(1);
}

song_stop() {
  level.sq_song_ent stopsounds();
  level.sq_song_ent.playing = 0;
  level notify("sq_song_stop");
}

song_fake_use(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "song_stage" + var_1 + "_over", var_2);
  var_3 waittill("activated", var_4);
  return var_4;
}

songstage1_init() {}

songstage1_logic() {
  var_0 = common_scripts\utility::getstruct("song_use_1", "targetname");
  var_1 = song_fake_use(var_0.origin, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage1");
}

songstage1_end(var_0) {}

songstage2_init() {}

songstage2_logic() {
  var_0 = common_scripts\utility::getstruct("song_use_2", "targetname");
  var_1 = song_fake_use(var_0.origin, 2);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage2");
}

songstage2_end(var_0) {}

songstage3_init() {}

songstage3_logic() {
  var_0 = common_scripts\utility::getstruct("song_use_3", "targetname");
  var_1 = song_fake_use(var_0.origin, 3);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage3");
}

songstage3_end(var_0) {}

musiclength(var_0) {
  var_1 = tablelookup(level.zmbsoundlengthpath, 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    return 2;
  }

  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}
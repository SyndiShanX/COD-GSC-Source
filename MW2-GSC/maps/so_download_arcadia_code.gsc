/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\so_download_arcadia_code.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_hud_util;
#include maps\_specialops;
#include maps\_specialops_code;
#include maps\so_download_arcadia;

STRYKER_SUPPRESSION_RADIUS = 1500 * 1500;
level.downloadObjectiveStr = objStr;
level.downloadObjectiveIdx = objIdx;
level.downloadsComplete = 0;

level.downloads = getStructArray("download", "targetname");

foreach(index, download in level.downloads) {
  download.objPos = index;
}
Objective_Add(level.downloadObjectiveIdx, "current", objStr, level.downloads[0].origin);
for(i = 1; i < level.downloads.size; i++) {
  download = level.downloads[i];
  Objective_AdditionalPosition(level.downloadObjectiveIdx, download.objPos, download.origin);
}

array_thread(level.players, ::ent_flag_init, "download_hint_on");
array_thread(level.downloads, ::download_obj_setup);
}
download_obj_setup() {
  computer = spawn("script_model", self.origin);
  computer setModel("com_laptop_rugged_open");
  computer.angles = self.angles;

  dsmSpot = GetStruct(self.target, "targetname");
  dsm = spawn("script_model", dsmSpot.origin);
  dsm setModel("mil_wireless_dsm");
  dsm.angles = dsmSpot.angles;

  dsm_obj = spawn("script_model", dsm.origin);
  dsm_obj setModel("mil_wireless_dsm_obj");
  dsm_obj.angles = dsm.angles;

  dsm Hide();

  self.computer = computer;
  self.dsm = dsm;
  self.dsm_obj = dsm_obj;

  self.trig = GetEnt(self.target, "targetname");
  self.trig download_trig_sethintstring();

  self thread download_obj_think();
}

download_trig_sethintstring() {
  self SetHintString(&"SO_DOWNLOAD_ARCADIA_DSM_USE_HINT");
}

download_trig_clearhintstring() {
  self SetHintString("");
}

download_obj_think() {
  self ent_flag_init("download_stopped");
  self.downloading = false;
  self.firstDownload = true;
  self.downloadTimeElapsed = 0;
  self.filesDone = 0;
  self.download_complete = false;

  while(1) {
    self.trig waittill("trigger");

    self.dsm_obj Hide();
    self.dsm Show();

    self.trig download_trig_clearhintstring();

    success = self download_files();

    if(success) {
      self.dsm Hide();
      break;
    } else {
      self.trig download_trig_sethintstring();
      self.dsm Hide();
      self.dsm_obj Show();
    }
  }

  level.downloadsComplete++;
  self.download_complete = true;

  thread download_obj_dialogue();

  if(level.downloadsComplete >= level.downloads.size) {
    Objective_Complete(level.downloadObjectiveIdx);
    flag_set("all_downloads_finished");
  } else {
    Objective_AdditionalPosition(level.downloadObjectiveIdx, self.objPos, (0, 0, 0));

    Objective_String(level.downloadObjectiveIdx, level.downloadObjectiveStr);
    Objective_Ring(level.downloadObjectiveIdx);
  }
}

download_obj_dialogue() {
  downloadsLeft = level.downloads.size - level.downloadsComplete;

  if(downloadsLeft == 2) {
    return;
  } else if(downloadsLeft == 1) {
    return;
  } else if(downloadsLeft == 0) {
    bugWaitTime = 30;

    aliases = [];

    level endon("stryker_extraction_done");

    while(1) {
      foreach(alias in aliases) {
        wait(bugWaitTime);
        so_radio_dialogue(alias);
      }
    }
  }
}

so_radio_dialogue(alias) {
  if(!flag("special_op_terminated")) {
    radio_dialogue(alias);
  }
}

so_character_dialogue(alias) {
  if(!flag("special_op_terminated")) {
    self dialogue_queue(alias);
  }
}

download_files() {
  downloadTime = level.DOWNLOAD_TIME - self.downloadTimeElapsed;

  if(!flag("first_download_started")) {
    flag_set("first_download_started");
  }

  self.downloading = true;
  self notify("downloading");

  success = false;

  startTime = GetTime();
  endTime = GetTime() + milliseconds(downloadTime);

  if(!isDefined(self.defenders_spawned)) {
    self.defenders_spawned = true;
    self.waveDead = false;
    self thread download_files_enemies_attack(downloadTime);
  }

  self delaythread(0.1, ::download_files_wave_death);
  self thread download_files_catch_interrupt();

  self ent_flag_clear("download_stopped");

  downloadTime = download_files_hud_countdown(downloadTime);

  if(self.waveDead) {
    wait(downloadTime);
  } else {
    self waittill_any_timeout(downloadTime, "download_interrupted");
  }

  self notify("downloading_stopped");
  self.downloading = false;

  self.downloadTimeElapsed += seconds(GetTime() - startTime);

  if(self.waveDead || GetTime() >= endTime) {
    success = true;
  }

  self ent_flag_set("download_stopped");

  if(!success) {
    self thread download_files_hud_countdown_abort();
    thread download_interrupt_dialogue();
  } else {
    self thread download_files_hud_finish();
  }

  return success;
}

download_interrupt_dialogue() {
  wait(1);

  lines = [];

  if(!isDefined(level.interruptLineIndex) || (level.interruptLineIndex >= lines.size)) {
    level.interruptLineIndex = 0;
  }

  so_radio_dialogue(lines[level.interruptLineIndex]);

  level.interruptLineIndex++;
}

download_files_wave_death() {
  self endon("downloading_stopped");

  while(!self.waveDead) {
    wait(0.05);
  }

  self notify("download_interrupted");
}

dsm_wait(hudelem, time) {
  hudelem SetValue(0);
  wait(1);

  delay = 0.1;
  steps = time / delay;
  for(i = 0; i < steps; i++) {
    num = clamp(int((i / steps) * 100), 0, 100);
    hudelem SetValue(num);
    wait(delay);
  }

  hudelem SetValue(100);
  wait(0.5);
}

download_files_hud_countdown(timeLeft) {
  functionStartTime = GetTime();

  x = -200;
  y_offset = 50;
  if(IsSplitscreen()) {
    x = -220;
    y_offset = 120;
  }

  if(self.firstDownload) {
    y = y_offset + (level.hud_download_count * 20);
    level.hud_download_count++;
    self.hudelem_y = y;

    hudelem = get_countdown_hud(x, self.hudelem_y);
    hudelem.alignX = "right";
    hudelem SetPulseFX(30, 900000, 700);
    hudelem.label = &"SO_DOWNLOAD_ARCADIA_DSM_FRAME";
    wait 0.65;

    hudelem_status = get_countdown_hud(x, self.hudelem_y);
    hudelem_status SetPulseFX(30, 900000, 700);
    hudelem_status.label = &"SO_DOWNLOAD_ARCADIA_DSM_INIT";

    dsm_wait(hudelem_status, 2.5);

    hudelem_status Destroy();

    hudelem_status = get_countdown_hud(x, self.hudelem_y);
    hudelem_status SetPulseFX(30, 900000, 700);
    hudelem_status.label = &"SO_DOWNLOAD_ARCADIA_DSM_CONNECTING";

    dsm_wait(hudelem_status, 0.9);

    hudelem_status Destroy();

    hudelem_status = get_countdown_hud(x, self.hudelem_y);
    hudelem_status SetPulseFX(30, 900000, 700);
    hudelem_status.label = &"SO_DOWNLOAD_ARCADIA_DSM_LOGIN";

    dsm_wait(hudelem_status, 3.75);

    hudelem_status Destroy();

    hudelem_status = get_countdown_hud(x, self.hudelem_y);
    hudelem_status SetPulseFX(30, 900000, 700);
    hudelem_status.label = &"SO_DOWNLOAD_ARCADIA_DSM_LOCATE";

    dsm_wait(hudelem_status, 1.5);

    hudelem Destroy();
    hudelem_status Destroy();

    self.firstDownload = false;
  }

  x = -250;
  x_offset = x + 170;
  hudelem = get_countdown_hud(x, self.hudelem_y, undefined, true);
  hudelem SetPulseFX(30, 900000, 700);
  hudelem.label = &"SO_DOWNLOAD_ARCADIA_DSM_PROGRESS";

  hudelem_status = get_download_state_hud(x_offset, self.hudelem_y, undefined, true);
  hudelem_status.alignX = "right";
  hudelem_status SetPulseFX(30, 900000, 700);

  hudelem_status_total = get_countdown_hud(x_offset, self.hudelem_y, undefined, true);
  hudelem_status_total SetPulseFX(30, 900000, 700);

  if(!isDefined(self.totalFiles)) {
    self.totalFiles = RandomIntRange(level.NUM_FILES_MIN, level.NUM_FILES_MAX);
  }

  hudelem_status_total.label = &"SO_DOWNLOAD_ARCADIA_DSM_TOTALFILES";
  hudelem_status_total SetValue(self.totalfiles);

  timeLeft -= seconds(GetTime() - functionStartTime);

  if(self.waveDead && timeLeft > 3) {
    timeLeft = 3;
  }

  self thread download_files_update(hudelem, hudelem_status, hudelem_status_total, timeLeft);

  return timeLeft;
}

download_files_update(hudelem, hudelem_status, hudelem_status_total, timeLeft) {
  endtime = GetTime() + milliseconds(timeLeft);
  filesLeft = self.totalfiles - self.filesDone;
  incrementTime = 0.05;
  file_inc = incrementTime / (timeLeft / filesLeft);

  while(GetTime() < endtime && !self ent_flag("download_stopped")) {
    self.filesDone += file_inc;
    hudelem_status SetValue(int(self.filesDone));
    wait(incrementTime);
  }

  if(!self ent_flag("download_stopped")) {
    hudelem_status SetValue(self.totalfiles);
  }

  hudelem Destroy();
  hudelem_status Destroy();
  hudelem_status_total Destroy();
}

download_files_hud_countdown_abort() {
  x = -200;
  if(IsSplitscreen()) {
    x = -220;
  }
  hudelem = get_countdown_hud(x, self.hudelem_y);
  hudelem.alignx = "right";

  hudelem.label = &"SO_DOWNLOAD_ARCADIA_DSM_FRAME";
  hudelem.fontScale = 1.4;
  hudelem set_hud_red();

  hudelem_status = get_countdown_hud(x, self.hudelem_y);
  hudelem_status.label = &"SO_DOWNLOAD_ARCADIA_DOWNLOAD_INTERRUPTED";
  hudelem_status.fontScale = 1.4;
  hudelem_status set_hud_red();

  hudelem thread hud_blink();
  hudelem_status thread hud_blink();

  self waittill_any_timeout(25, "downloading");
  hudelem Destroy();
  hudelem_status Destroy();
}

download_files_hud_finish() {
  x = -200;
  if(IsSplitscreen()) {
    x = -220;
  }
  hudelem = get_countdown_hud(x, self.hudelem_y);
  hudelem.alignx = "right";
  hudelem.label = &"SO_DOWNLOAD_ARCADIA_DSM_FRAME";
  hudelem.fontScale = 1.4;
  hudelem set_hud_blue();

  hudelem_status = get_countdown_hud(x, self.hudelem_y);
  hudelem_status.label = &"SO_DOWNLOAD_ARCADIA_DOWNLOAD_COMPLETE";
  hudelem_status.fontScale = 1.4;
  hudelem_status set_hud_blue();

  hudelem thread hud_blink();
  hudelem_status thread hud_blink();

  wait(10);
  hudelem Destroy();
  hudelem_status Destroy();
}

hud_blink(maxFontScale) {
  self endon("death");

  fadeTime = 0.1;
  stateTime = 0.5;

  while(1) {
    self FadeOverTime(fadeTime);
    self.alpha = 1;
    wait(stateTime);

    self FadeOverTime(fadeTime);
    self.alpha = 0;
    wait(stateTime);
  }
}

download_files_enemies_attack(downloadTime) {
  self.spawned = [];
  self.totalDefenders = 0;

  self.totalDefenders = self download_files_nearby_defenders_charge();
  self.totalDefenders += self download_files_spawn_chargers();

  self thread download_enemies_attack_dialogue();

  while(self.spawned.size < self.totalDefenders) {
    wait(0.05);
  }

  waittill_dead_or_dying(self.spawned, (self.spawned.size - level.NUM_ENEMIES_LEFT_TOLERANCE), downloadTime);

  self.waveDead = true;
}

download_enemies_attack_dialogue() {
  alias = undefined;
  waitTime = undefined;
  alias2 = undefined;

  switch (self.script_parameters) {
    case "download_1_charger":

      break;

    case "download_2_charger":

      break;

    case "download_3_charger":

      waitTime = 10;

      break;
  }

  if(isDefined(alias)) {
    so_radio_dialogue(alias);
  }

  if(isDefined(waitTime)) {
    wait(waitTime);
  }

  if(isDefined(alias2)) {
    so_radio_dialogue(alias2);
  }
}

download_files_nearby_defenders_charge() {
  axis = GetAiArray("axis");
  close = [];

  foreach(guy in axis) {
    if(Distance(guy.origin, self.origin) <= level.NEARBY_CHARGE_RADIUS) {
      close[close.size] = guy;
      self.spawned[self.spawned.size] = guy;
    }
  }

  array_thread(close, ::defender_charge_dsm, self);

  return close.size;
}

download_files_spawn_chargers() {
  chargers = getEntArray(self.script_parameters, "targetname");
  chargers = array_randomize(chargers);
  array_thread(chargers, ::download_files_spawn_charger, self);

  return chargers.size;
}

download_files_spawn_charger(download) {
  self script_delay();

  wait(RandomFloat(8));

  guy = self spawn_ai();

  if(spawn_failed(guy)) {
    download.totalDefenders--;
    return;
  }

  download.spawned[download.spawned.size] = guy;
  guy thread defender_charge_dsm(download);
}

defender_charge_dsm(download) {
  goal_ent = GetEnt(download.script_linkto, "script_linkname");

  self.goalradius = 1800;
  self SetGoalEntity(goal_ent);
  self thread ai_delayed_seek_think(download, goal_ent);
}

ai_delayed_seek_think(download, goal_ent) {
  self endon("death");

  player1_max_seekers = 3;
  player2_max_seekers = 3;

  while(IsAlive(self)) {
    if(self.goalradius > 200) {
      self.goalradius -= 200;
    }

    if(self.goalradius < 200) {
      self.goalradius = 200;
    }

    count = 0;
    player1_seek_count = 0;
    player2_seek_count = 0;
    ais = GetAiArray("axis");
    foreach(ai in ais) {
      if(isDefined(ai.seeking_player)) {
        if(ai.seeking_player == level.player) {
          player1_seek_count++;
        } else if(isDefined(level.player2) && ai.seeking_player == level.player2) {
          player2_seek_count++;
        }
      }

      if(ai == self) {
        continue;
      }

      if(DistanceSquared(ai.origin, goal_ent.origin) < 250 * 250) {
        count++;
      }
    }

    if(count > 2 || download.download_complete) {
      if(!isDefined(self.seeking_player)) {
        array = level.players;
        array = array_randomize(array);

        goal_player = undefined;

        foreach(player in array) {
          if(player == level.player && player1_seek_count < player1_max_seekers) {
            goal_player = level.player;
            break;
          } else if(isDefined(level.player2) && player == level.player2 && player2_seek_count < player2_max_seekers) {
            goal_player = level.player2;
            break;
          }
        }

        if(isDefined(goal_player)) {
          self.seeking_player = goal_player;

          self SetGoalEntity(goal_player);
          self.goalradius = 1000;
        }
      }

      if(!isDefined(self.seek_player)) {
        self.goalradius = 1000;
      }
    }

    wait(RandomFloatRange(6, 9));
  }
}

download_files_catch_interrupt() {
  self endon("downloading_stopped");

  while(1) {
    axis = GetAiArray("axis");

    foreach(guy in axis) {
      if(self ai_near_download(guy)) {
        self notify("download_interrupted");
        break;
      }
    }

    wait(2);
  }
}

ai_near_download(guy) {
  verticalDist = abs(guy GetTagOrigin("J_SpineLower")[2] - self.origin[2]);
  if(verticalDist > 50) {
    return false;
  }

  if(Distance(guy.origin, self.origin) < level.DOWNLOAD_INTERRUPT_RADIUS) {
    return true;
  }

  return false;
}
stryker = maps\_vehicle::spawn_vehicle_from_targetname("stryker");
ASSERT(isDefined(stryker));
level.stryker = stryker;
org = spawn("script_origin", stryker.origin);
org LinkTo(stryker);
org.animname = "foley";
level.foley = org;

CreateThreatBiasGroup("stryker");
CreateThreatBiasGroup("stryker_ignoreme");
stryker.threatBiasGroup = "stryker";
SetIgnoreMeGroup("stryker_ignoreme", "stryker");

stryker.target = "stryker_pathstart";
pathStart = GetVehicleNode(stryker.target, "targetname");
stryker AttachPath(pathStart);

stryker.veh_pathtype = "follow";
stryker vehPhys_DisableCrashing();
stryker maps\_vehicle::godon();
stryker setVehicleLookAtText("Honey Badger", &"");

foreach(player in level.players) {
  player.remotemissile_actionslot = 4;
  level thread maps\arcadia_code::laser_targeting_device(player);
}

level.stryker.lastTarget = level.stryker;
stryker maps\arcadia_stryker::setup_stryker_modes();
stryker thread maps\arcadia_stryker::stryker_setmode_ai();
stryker thread stryker_so_download_arcadia_laser_reminder_dialogue();

stryker thread stryker_greenlight_enemies_in_suppression_zone();
stryker thread stryker_disable_laser_reminder_thread();
waittill_both_players_touch_targetname("trig_bridge_end");
stryker StartPath();
firstMoveNode = GetVehicleNode("vnode_bridge", "script_noteworthy");
stryker stryker_move_to_node(firstMoveNode, false);

stryker thread stryker_move_with_players();
stryker thread stryker_extraction();
}

stryker_so_download_arcadia_laser_reminder_dialogue() {
  foreach(player in level.players) {
    player thread so_laser_input();
  }

  flag_wait("intro_dialogue_done");

  self thread stryker_laser_reminder_dialog_prethink();

  self thread so_laser_hint_print();

  self thread maps\arcadia_code::stryker_dialog();

  if(flag("used_laser")) {
    return;
  }

  level endon("used_laser");
  self endon("laser_coordinates_received");

  wait(45);

  while(flag("no_living_enemies")) {
    wait(5);
  }

  wait(45);

  while(flag("no_living_enemies")) {
    wait(5);
  }
}

so_laser_hint_print() {
  foreach(player in level.players) {
    if(!IsAlive(player)) {
      continue;
    }

    player thread so_laser_hint_print_internal();
  }
}

so_laser_input() {
  self NotifyOnPlayerCommand("use_laser", "+actionslot 4");
  self NotifyOnPlayerCommand("fired_laser", "+attack");

  if(flag("used_laser")) {
    self ent_flag_set("used_laser1");
    self ent_flag_set("used_laser2");
  }

  self waittill_either("use_laser", "used_laser");
  self ent_flag_set("used_laser1");

  if(flag("used_laser")) {
    self ent_flag_set("used_laser1");
    self ent_flag_set("used_laser2");
  }

  self waittill_either("fired_laser", "used_laser");
  self ent_flag_set("used_laser2");
}

so_laser_hint_print_internal() {
  self thread display_hint("use_laser1");
  self ent_flag_wait("used_laser1");

  wait(0.1);

  self thread display_hint("use_laser2");
}

so_stop_laser_hint1() {
  if(flag("used_laser")) {
    return true;
  }

  if(self ent_flag("used_laser1")) {
    return true;
  }

  return false;
}

so_stop_laser_hint2() {
  if(flag("used_laser")) {
    return true;
  }

  if(self ent_flag("used_laser2")) {
    return true;
  }

  return false;
}

stryker_laser_reminder_dialog_prethink() {
  self waittill("laser_coordinates_received");

  wait(30);
  self thread maps\arcadia_stryker::stryker_laser_reminder_dialog();
}

stryker_greenlight_enemies_in_suppression_zone() {
  while(1) {
    if(!isDefined(self.targetSearchOrigin)) {
      wait(0.1);
      continue;
    }

    axis = GetAiArray("axis");

    foreach(guy in axis) {
      if(!IsAlive(guy)) {
        continue;
      }

      if(DistanceSquared(guy.origin, self.targetSearchOrigin) <= STRYKER_SUPPRESSION_RADIUS) {
        if(guy GetThreatBiasGroup() == "stryker_ignoreme") {
          guy SetThreatBiasGroup("axis");
          self thread stryker_enemy_reset_to_ignore(guy);
        }
      }
    }

    wait(0.25);
  }
}

stryker_disable_laser_reminder_thread() {
  while(1) {
    wait(0.5);

    count = 0;
    enemies = GetAiArray("axis");
    count = enemies.size;

    if(!count) {
      flag_set("no_living_enemies");
    } else {
      flag_clear("no_living_enemies");
    }
  }
}

stryker_enemy_reset_to_ignore(guy) {
  guy endon("death");

  while(isDefined(self.targetSearchOrigin)) {
    wait(0.1);
  }

  if(IsAlive(guy)) {
    guy SetThreatBiasGroup("stryker_ignoreme");
  }
}

stryker_move_with_players() {
  level endon("all_downloads_finished");

  trig1 = GetEnt("trig_stryker_house1", "targetname");
  node1 = GetVehicleNode("vnode_house1", "script_noteworthy");
  trig2 = GetEnt("trig_stryker_house2", "targetname");
  node2 = GetVehicleNode("vnode_house2", "script_noteworthy");
  trig3 = GetEnt("trig_stryker_house3", "targetname");
  node3 = GetVehicleNode("vnode_house3", "script_noteworthy");

  trigs[0] = trig1;
  trigs[1] = trig2;
  trigs[2] = trig3;
  nodes[0] = node1;
  nodes[1] = node2;
  nodes[2] = node3;

  timeInTrig = 5;

  currNode = undefined;

  while(1) {
    activeTrigIndex = undefined;
    foreach(index, trig in trigs) {
      if(all_players_istouching(trig)) {
        endTime = GetTime() + milliseconds(timeInTrig);

        while(GetTime() < endTime) {
          if(!all_players_istouching(trig)) {
            break;
          }

          wait(0.1);
        }

        if(GetTime() >= endTime) {
          activeTrigIndex = index;
          break;
        }
      }
    }

    if(isDefined(activeTrigIndex)) {
      thenode = nodes[activeTrigIndex];

      if(!isDefined(currNode) || (isDefined(currNode) && currNode != thenode)) {
        currNode = thenode;
        self stryker_move_to_node(thenode);
      }
    }

    wait(0.5);
  }
}

stryker_move_to_node(node, doDialogue) {
  goalradius = 96;

  if(node.origin[0] < self.origin[0]) {
    self.veh_pathdir = "reverse";
    self.veh_transmission = "reverse";
    self maps\_vehicle::vehicle_wheels_backward();
  } else {
    self.veh_pathdir = "forward";
    self.veh_transmission = "forward";
    self maps\_vehicle::vehicle_wheels_forward();
  }

  if(!isDefined(doDialogue) || (isDefined(doDialogue) && doDialogue)) {
    self notify("resuming speed");
  }

  self maps\_vehicle::vehicle_setspeed_wrapper(10, 5, "stryker_rolling");

  while(Distance(self.origin, node.origin) > goalradius) {
    wait(0.05);
  }

  self maps\_vehicle::vehicle_setspeed_wrapper(0, 5, "stryker_stopping");

  if(!isDefined(doDialogue) || (isDefined(doDialogue) && doDialogue)) {
    self notify("wait for gate");
  }
}

stryker_extraction() {
  flag_wait("all_downloads_finished");

  node = GetVehicleNode("vnode_house1", "script_noteworthy");
  level.stryker thread stryker_move_to_node(node);

  strykerObjIdx = level.downloadObjectiveIdx + 1;
  Objective_Add(strykerObjIdx, "current", &"SO_DOWNLOAD_ARCADIA_OBJ_EXTRACT", self.origin);
  Objective_OnEntity(strykerObjIdx, self);

  thread stryker_extraction_enemies();

  while(!all_players_closeto(self, 280)) {
    wait(0.05);
  }

  flag_set("stryker_extraction_done");

  level notify("golf_course_mansion");

  fade_challenge_out();
}

stryker_extraction_enemies() {
  org = level.players[0].origin;

  if(level.players.size > 1) {
    for(i = 1; i < level.players.size; i++) {
      org += level.players[i].origin;
    }

    org /= level.players.size;
  }

  spawners = GetSpawnerTeamArray("axis");
  spawners = get_array_of_farthest(org, spawners);
  arr = [];

  foreach(index, spawner in spawners) {
    if(index > 15) {
      break;
    }

    spawner.count = 3;
    arr[arr.size] = spawner;
  }

  array_thread(spawners, ::stryker_extraction_spawn_enemy);
}

stryker_extraction_spawn_enemy() {
  wait(RandomFloat(10));

  guy = self spawn_ai();

  if(spawn_failed(guy)) {
    return;
  }

  guy endon("death");

  guy SetThreatBiasGroup("axis");
  guy SetGoalPos(level.stryker.origin);
}
player_laser_targeting_think() {
  is_laser_disabled = false;

  while(1) {
    disable_laser = should_laser_disabled();

    if(disable_laser) {
      if(!is_laser_disabled) {
        is_laser_disabled = true;
        self laser_targeting_device_remove();
      }
    } else {
      if(is_laser_disabled) {
        is_laser_disabled = false;
        level thread maps\arcadia_code::laser_targeting_device(self);
      }
    }

    wait(0.05);
  }
}

should_laser_disabled() {
  if(!self ent_flag_exist("coop_downed")) {
    return false;
  }

  return self ent_flag("coop_downed") && isDefined(self.down_part2_proc_ran);
}
laser_targeting_device_remove() {
  self notify("remove_laser_targeting_device");

  self SetWeaponHudIconOverride("actionslot4", "none");

  if(!self.laserForceOn) {
    return;
  }

  self notify("cancel_laser");
  self laserForceOff();
  self allowFire(true);
  self.laserForceOn = false;
}
level.enemies = [];

allspawners = GetSpawnerTeamArray("axis");
array_thread(allspawners, ::add_spawn_function, ::so_download_arcadia_enemy_spawnfunc);

insideGuys = [];
outsideGuys = [];

foreach(spawner in allspawners) {
  if(!isDefined(spawner.targetname)) {
    continue;
  }

  if(IsSubStr(spawner.targetname, "inside")) {
    insideGuys[insideGuys.size] = spawner;
  } else if(IsSubStr(spawner.targetname, "outside")) {
    outsideGuys[outsideGuys.size] = spawner;
  }
}

array_thread(outsideGuys, ::add_spawn_function, ::so_download_arcadia_outside_enemy_spawnfunc);

level.enemyspawners = allspawners;
}

so_download_arcadia_enemy_spawnfunc() {
  if(RandomInt(100) > 10) {
    self SetThreatBiasGroup("stryker_ignoreme");
  }

  self pathrandompercent_set(800);

  level.activeEnemies[level.enemies.size] = self;
  self thread so_download_arcadia_enemy_deathcleanup();
}

so_download_arcadia_enemy_deathcleanup() {
  self waittill("death");
  level.activeEnemies = array_remove(level.enemies, self);
}

so_download_arcadia_outside_enemy_spawnfunc() {
  self endon("death");

  if(isDefined(self.script_linkto) && isDefined(self.script_parameters)) {
    retreatTrig = GetEnt(self.script_linkto, "script_linkname");
    retreatVol = GetEnt(self.script_parameters, "targetname");

    ASSERT(isDefined(retreatTrig) && isDefined(retreatVol));

    retreatTrig waittill("trigger");

    self.combatMode = "ambush";
    self SetGoalVolumeAuto(retreatVol);
  }
}
foundOne = false;
foreach(player in level.players) {
  if(Distance(player.origin, ent.origin) > dist) {
    foundOne = true;
    break;
  }
}

if(foundOne) {
  return false;
}

return true;
}

waittill_both_players_touch_targetname(tn) {
  trig = GetEnt(tn, "targetname");
  touchers = [];

  while(touchers.size < level.players.size) {
    trig waittill("trigger", other);

    if(isPlayer(other) && !is_in_array(touchers, other)) {
      touchers[touchers.size] = other;
    }
  }
}
any_player_can_see_ai(ai) {
  feetOrigin = ai.origin;
  if(any_player_can_see_origin(feetOrigin))
    return true;

  midOrigin = ai GetTagOrigin("J_SpineLower");
  if(any_player_can_see_origin(midOrigin))
    return true;

  eyeOrigin = ai getEye();
  if(any_player_can_see_origin(eyeOrigin))
    return true;

  return false;
}

any_player_can_see_origin(origin) {
  foreach(player in level.players) {
    player.canSeeOrigin = true;

    if(!level.player animscripts\battlechatter::pointInFov(origin)) {
      player.canSeeOrigin = false;
    }

    if(!SightTracePassed(player getEye(), origin, true, player)) {
      player.canSeeOrigin = false;
    }
  }

  foreach(player in level.players) {
    if(player.canSeeOrigin) {
      return true;
    }
  }

  return false;
}

milliseconds(seconds) {
  return seconds * 1000;
}

seconds(milliseconds) {
  return milliseconds / 1000;
}
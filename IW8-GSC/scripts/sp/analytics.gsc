/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\analytics.gsc
***********************************************/

function main() {
  setdvarifuninitialized("scr_debug_analytics", 0);
  setdvarifuninitialized("scr_analytics_upload", 0);
  level.analytics = spawnStruct();
  level.analytics.missionstarttime = level.player getplayerprogression("totalGameplayTime");
  level.analytics.startingdifficulty = getdifficultylevel();
  level.analytics.sp_counter = 0;
  level.analytics.sp_skip = 0;
  setDvar("scr_analytics_playerJustDied", 0);
  thread analyticsthread();
}

function analyticsthread() {
  level.player setplayerprogression("kleenexSessionGameplayTime", 0);
  level.player setplayerprogression("playerMountCounter", 0);
  level.player setplayerprogression("focusCounter", 0);

  if(getdvarint("scr_analytics_upload") == 1) {
    thread analytics_tracking_player_mount();
    thread analytics_upload_during_nextmission();
  }

  for(;;) {
    if(!isalive(level.player)) {
      wait 10;
      continue;
    }

    if(issaverecentlyloaded() || getdvarint("scr_analytics_playerJustDied")) {
      setDvar("scr_analytics_playerJustDied", 0);
      setDvar("scr_analytics_playerStartTime", gettime());
      setDvar("scr_analytics_kleenexStartTime", gettime());
    }

    wait 0.5;
  }
}

function analytics_tracking_player_mount() {
  for(;;) {
    while(self playermount() < 0.5) {
      wait 0.2;
    }

    self notify("start_player_mount");
    var0 = level.player getplayerprogression("playerMountCounter");
    level.player setplayerprogression("playerMountCounter", var0 + 1);

    while(self playermount() >= 0.5) {
      wait 0.2;
    }

    wait 0.1;
  }
}

function analytics_upload_during_nextmission() {
  level waittill("nextmission");
  analytics_event_upload(level.script + " Mount Total", level.player getplayerprogression("playerMountCounter"));
}

function analytics_lui_mission_end_dlog() {
  setomnvar("ui_mission_end_dlog", 1);
}

function analytics_skip_start_point() {
  level.analytics.sp_skip = 1;
}

function analytics_fake_start_point(var0, var1) {
  if(istrue(var1)) {
    level.analytics.sp_counter++;
    var0 += level.analytics.sp_counter;
  }

  start_point_update(var0);
  start_point_reset();
}

function analytics_kleenex_update(var0) {
  if(getdvarint("scr_analytics_upload") == 1) {
    analytics_kleenex_upload(var0);
    return;
  }
}

function analytics_kleenex_upload(var0) {
  var1 = int((gettime() - getdvarint("scr_analytics_kleenexStartTime")) / 1000);
  var2 = float(var1 + level.player getplayerprogression("kleenexSessionGameplayTime"));
  getentitylessscriptablearray("dlog_event_analytics_sp_kleenex_session", ["levelname", level.script, "Section", var0, "Duration", var2]);
  setDvar("scr_analytics_kleenexStartTime", gettime());
  level.player setplayerprogression("kleenexSessionGameplayTime", 0);
}

function start_point_setup() {
  if(level.analytics.sp_skip) {
    level.analytics.sp_skip = 0;
    return;
  }

  start_point_reset();
}

function start_point_check(var0) {
  if(!level.analytics.sp_skip) {
    start_point_update(var0);
    return;
  }
}

function start_point_reset() {
  setDvar("scr_analytics_playerStartTime", gettime());
  level.player setplayerprogression("startPointDeaths", 0);
  level.player setplayerprogression("startPointFails", 0);
  level.player setplayerprogression("sessionGameplayTime", 0);
  level.player setplayerprogression("focusCounter", 0);
}

function start_point_update(var0, var1) {
  if(istrue(level.nextmission) && !isDefined(var1)) {
    return;
  }

  var2 = int((gettime() - getdvarint("scr_analytics_playerStartTime")) / 1000);
  var3 = float(var2 + level.player getplayerprogression("sessionGameplayTime"));
  var4 = level.player getplayerprogression("startPointDeaths");
  var5 = level.player getplayerprogression("startPointFails");
  var6 = get_gameskill_as_string();
  level.analytics.sp_counter++;
  getentitylessscriptablearray("dlog_event_analytics_sp_start_points", ["levelname", level.script, "Start", var0, "Duration", var3, "Deaths", var4, "Fails", var5, "difficulty", var6]);

  if(getdvarint("scr_analytics_upload") == 1) {
    var7 = level.player getplayerprogression("focusCounter");
    analytics_event_upload(var0, var7);
    return;
  }
}

function get_gameskill_as_string() {
  var0 = level.player scripts\engine\sp\utility::get_player_gameskill();

  if(var0 == 0) {
    return "Recruit";
  }

  if(var0 == 1) {
    return "Regular";
  }

  if(var0 == 2) {
    return "Hardened";
  }

  if(var0 == 3) {
    return "Veteran";
  }

  if(var0 == 4) {
    return "Realism";
  }
}

function analytics_obj_failed() {
  var0 = level.player getplayerprogression("startPointFails");
  level.player setplayerprogression("startPointFails", var0 + 1);
}

function update_focus_counter() {
  var0 = level.player getplayerprogression("focusCounter");
  level.player setplayerprogression("focusCounter", var0 + 1);
}

function playerdeath() {
  updatetotalgameplaytime();
  var0 = level.player getplayerprogression("startPointDeaths");
  level.player setplayerprogression("startPointDeaths", var0 + 1);
  setDvar("scr_analytics_playerJustDied", 1);
}

function updatetotalgameplaytime() {
  var0 = level.player getplayerprogression("totalGameplayTime");
  var1 = level.player getplayerprogression("sessionGameplayTime");
  var2 = int((gettime() - getdvarint("scr_analytics_playerStartTime")) / 1000);
  var3 = var1 + var2;
  level.player setplayerprogression("sessionGameplayTime", var3);
  var4 = level.player getplayerprogression("kleenexSessionGameplayTime");
  var5 = int((gettime() - getdvarint("scr_analytics_kleenexStartTime")) / 1000);
  var6 = var4 + var5;
  level.player setplayerprogression("kleenexSessionGameplayTime", var6);

  if(var2 > 0) {
    var0 += var2;
    level.player setplayerprogression("totalGameplayTime", var0);
  }

  return var0;
}

function getdifficultylevel() {
  var0 = getdvarint("TTMRSTRO") + 1;

  if(scripts\sp\utility::in_specialist_mode()) {
    var0 = 5;
  } else if(scripts\sp\utility::in_yolo_mode()) {
    var0 = 6;
  }

  return var0;
}

function analytics_event_upload(var0, var1) {
  if(getdvarint("scr_analytics_upload") == 1) {
    getentitylessscriptablearray("dlog_event_analytics_sp_kleenex_event", ["levelname", level.script, "Event", var0, "Integer", var1]);
    return;
  }
}
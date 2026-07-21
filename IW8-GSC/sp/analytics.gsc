/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\analytics.gsc
***********************************************/

main() {
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

analyticsthread() {
  level.player setplayerprogression("kleenexSessionGameplayTime", 0);
  level.player setplayerprogression("playerMountCounter", 0);
  level.player setplayerprogression("focusCounter", 0);

  if(getdvarint("scr_analytics_upload") == 1) {
    level.player thread analytics_tracking_player_mount();
    level.player thread analytics_upload_during_nextmission();
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

analytics_tracking_player_mount() {
  for(;;) {
    while(self playermount() < 0.5)
      wait 0.2;

    self notify("start_player_mount");
    var_0 = level.player getplayerprogression("playerMountCounter");
    level.player setplayerprogression("playerMountCounter", var_0 + 1);

    while(self playermount() >= 0.5)
      wait 0.2;

    wait 0.1;
  }
}

analytics_upload_during_nextmission() {
  level waittill("nextmission");
  analytics_event_upload(level.script + " Mount Total", level.player getplayerprogression("playerMountCounter"));
}

analytics_lui_mission_end_dlog() {
  setomnvar("ui_mission_end_dlog", 1);
}

analytics_skip_start_point() {
  level.analytics.sp_skip = 1;
}

analytics_fake_start_point(var_0, var_1) {
  if(istrue(var_1)) {
    level.analytics.sp_counter++;
    var_0 = var_0 + level.analytics.sp_counter;
  }

  start_point_update(var_0);
  start_point_reset();
}

analytics_kleenex_update(var_0) {
  if(getdvarint("scr_analytics_upload") == 1)
    analytics_kleenex_upload(var_0);
}

analytics_kleenex_upload(var_0) {
  var_1 = int((gettime() - getdvarint("scr_analytics_kleenexStartTime")) / 1000);
  var_2 = float(var_1 + level.player getplayerprogression("kleenexSessionGameplayTime"));
  getentitylessscriptablearray("dlog_event_analytics_sp_kleenex_session", ["levelname", level.script, "Section", var_0, "Duration", var_2]);
  setDvar("scr_analytics_kleenexStartTime", gettime());
  level.player setplayerprogression("kleenexSessionGameplayTime", 0);
}

start_point_setup() {
  if(level.analytics.sp_skip)
    level.analytics.sp_skip = 0;
  else
    start_point_reset();
}

start_point_check(var_0) {
  if(!level.analytics.sp_skip)
    start_point_update(var_0);
}

start_point_reset() {
  setDvar("scr_analytics_playerStartTime", gettime());
  level.player setplayerprogression("startPointDeaths", 0);
  level.player setplayerprogression("startPointFails", 0);
  level.player setplayerprogression("sessionGameplayTime", 0);
  level.player setplayerprogression("focusCounter", 0);
}

start_point_update(var_0, var_1) {
  if(istrue(level.nextmission) && !isDefined(var_1)) {
    return;
  }
  var_2 = int((gettime() - getdvarint("scr_analytics_playerStartTime")) / 1000);
  var_3 = float(var_2 + level.player getplayerprogression("sessionGameplayTime"));
  var_4 = level.player getplayerprogression("startPointDeaths");
  var_5 = level.player getplayerprogression("startPointFails");
  var_6 = get_gameskill_as_string();
  level.analytics.sp_counter++;
  getentitylessscriptablearray("dlog_event_analytics_sp_start_points", ["levelname", level.script, "Start", var_0, "Duration", var_3, "Deaths", var_4, "Fails", var_5, "difficulty", var_6]);

  if(getdvarint("scr_analytics_upload") == 1) {
    var_7 = level.player getplayerprogression("focusCounter");
    analytics_event_upload(var_0, var_7);
  }
}

get_gameskill_as_string() {
  var_0 = level.player scripts\engine\sp\utility::get_player_gameskill();

  if(var_0 == 0)
    return "Recruit";
  else if(var_0 == 1)
    return "Regular";
  else if(var_0 == 2)
    return "Hardened";
  else if(var_0 == 3)
    return "Veteran";
  else if(var_0 == 4)
    return "Realism";
}

analytics_obj_failed() {
  var_0 = level.player getplayerprogression("startPointFails");
  level.player setplayerprogression("startPointFails", var_0 + 1);
}

update_focus_counter() {
  var_0 = level.player getplayerprogression("focusCounter");
  level.player setplayerprogression("focusCounter", var_0 + 1);
}

playerdeath() {
  updatetotalgameplaytime();
  var_0 = level.player getplayerprogression("startPointDeaths");
  level.player setplayerprogression("startPointDeaths", var_0 + 1);
  setDvar("scr_analytics_playerJustDied", 1);
}

updatetotalgameplaytime() {
  var_0 = level.player getplayerprogression("totalGameplayTime");
  var_1 = level.player getplayerprogression("sessionGameplayTime");
  var_2 = int((gettime() - getdvarint("scr_analytics_playerStartTime")) / 1000);
  var_3 = var_1 + var_2;
  level.player setplayerprogression("sessionGameplayTime", var_3);
  var_4 = level.player getplayerprogression("kleenexSessionGameplayTime");
  var_5 = int((gettime() - getdvarint("scr_analytics_kleenexStartTime")) / 1000);
  var_6 = var_4 + var_5;
  level.player setplayerprogression("kleenexSessionGameplayTime", var_6);

  if(var_2 > 0) {
    var_0 = var_0 + var_2;
    level.player setplayerprogression("totalGameplayTime", var_0);
  }

  return var_0;
}

getdifficultylevel() {
  var_0 = getdvarint("TTMRSTRO") + 1;

  if(scripts\sp\utility::in_specialist_mode())
    var_0 = 5;
  else if(scripts\sp\utility::in_yolo_mode())
    var_0 = 6;

  return var_0;
}

analytics_event_upload(var_0, var_1) {
  if(getdvarint("scr_analytics_upload") == 1)
    getentitylessscriptablearray("dlog_event_analytics_sp_kleenex_event", ["levelname", level.script, "Event", var_0, "Integer", var_1]);
}
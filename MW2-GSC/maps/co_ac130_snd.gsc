/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\co_ac130_snd.gsc
********************************************************/

#include maps\_utility;

main() {
  level.scr_sound["fco"]["ac130_fco_firingtoclose"] = "ac130_fco_firingtoclose";

  add_context_sensative_dialog("ai", "in_sight", 1, "ac130_fco_getthatguy");
  add_context_sensative_dialog("ai", "in_sight", 2, "ac130_fco_guymovin");
  add_context_sensative_dialog("ai", "in_sight", 3, "ac130_fco_getperson");
  add_context_sensative_dialog("ai", "in_sight", 4, "ac130_fco_guyrunnin");
  add_context_sensative_dialog("ai", "in_sight", 5, "ac130_fco_gotarunner");
  add_context_sensative_dialog("ai", "in_sight", 6, "ac130_fco_backonthose");
  add_context_sensative_dialog("ai", "in_sight", 7, "ac130_fco_gonnagethim");
  add_context_sensative_dialog("ai", "in_sight", 8, "ac130_fco_personnelthere");
  add_context_sensative_dialog("ai", "in_sight", 9, "ac130_fco_nailthoseguys");
  add_context_sensative_dialog("ai", "in_sight", 10, "ac130_fco_clearedtoengage");
  add_context_sensative_dialog("ai", "in_sight", 11, "ac130_fco_lightemup");
  add_context_sensative_dialog("ai", "in_sight", 12, "ac130_fco_takehimout");
  add_context_sensative_dialog("ai", "in_sight", 13, "ac130_plt_clearedtoengage");
  add_context_sensative_dialog("ai", "in_sight", 13, "ac130_plt_cleartoengage");
  add_context_sensative_dialog("ai", "in_sight", 14, "ac130_plt_yeahcleared");
  add_context_sensative_dialog("ai", "in_sight", 15, "ac130_plt_copysmoke");
  add_context_sensative_dialog("ai", "in_sight", 16, "ac130_fco_rightthere");
  add_context_sensative_dialog("ai", "in_sight", 17, "ac130_fco_tracking");

  add_context_sensative_dialog("ai", "wounded_crawl", 0, "ac130_fco_movingagain");
  add_context_sensative_timeout("ai", "wounded_crawl", undefined, 6);

  add_context_sensative_dialog("ai", "wounded_pain", 0, "ac130_fco_doveonground");
  add_context_sensative_dialog("ai", "wounded_pain", 1, "ac130_fco_knockedwind");
  add_context_sensative_dialog("ai", "wounded_pain", 2, "ac130_fco_downstillmoving");
  add_context_sensative_dialog("ai", "wounded_pain", 3, "ac130_fco_gettinbackup");
  add_context_sensative_dialog("ai", "wounded_pain", 4, "ac130_fco_yepstillmoving");
  add_context_sensative_dialog("ai", "wounded_pain", 5, "ac130_fco_stillmoving");
  add_context_sensative_timeout("ai", "wounded_pain", undefined, 12);

  add_context_sensative_dialog("weapons", "105mm_ready", 0, "ac130_gnr_gunready1");

  add_context_sensative_dialog("weapons", "105mm_fired", 0, "ac130_gnr_shot1");

  add_context_sensative_dialog("plane", "rolling_in", 0, "ac130_plt_rollinin");

  add_context_sensative_dialog("explosion", "secondary", 0, "ac130_nav_secondaries1");
  add_context_sensative_dialog("explosion", "secondary", 1, "ac130_tvo_directsecondary1");
  add_context_sensative_dialog("explosion", "secondary", 1, "ac130_tvo_directsecondary2");
  add_context_sensative_timeout("explosion", "secondary", undefined, 7);

  add_context_sensative_dialog("kill", "single", 0, "ac130_plt_gottahurt");
  add_context_sensative_dialog("kill", "single", 1, "ac130_fco_iseepieces");
  add_context_sensative_dialog("kill", "single", 2, "ac130_fco_oopsiedaisy");
  add_context_sensative_dialog("kill", "single", 3, "ac130_fco_goodkill");
  add_context_sensative_dialog("kill", "single", 4, "ac130_fco_yougothim");
  add_context_sensative_dialog("kill", "single", 5, "ac130_fco_yougothim2");
  add_context_sensative_dialog("kill", "single", 6, "ac130_fco_thatsahit");
  add_context_sensative_dialog("kill", "single", 7, "ac130_fco_directhit");
  add_context_sensative_dialog("kill", "single", 8, "ac130_fco_rightontarget");
  add_context_sensative_dialog("kill", "single", 9, "ac130_fco_okyougothim");
  add_context_sensative_dialog("kill", "single", 10, "ac130_fco_within2feet");

  add_context_sensative_dialog("kill", "small_group", 0, "ac130_fco_nice");
  add_context_sensative_dialog("kill", "small_group", 1, "ac130_fco_directhits");
  add_context_sensative_dialog("kill", "small_group", 2, "ac130_fco_iseepieces");
  add_context_sensative_dialog("kill", "small_group", 3, "ac130_fco_goodkill");
  add_context_sensative_dialog("kill", "small_group", 4, "ac130_fco_yougothim");
  add_context_sensative_dialog("kill", "small_group", 5, "ac130_fco_yougothim2");
  add_context_sensative_dialog("kill", "small_group", 6, "ac130_fco_thatsahit");
  add_context_sensative_dialog("kill", "small_group", 7, "ac130_fco_directhit");
  add_context_sensative_dialog("kill", "small_group", 8, "ac130_fco_rightontarget");
  add_context_sensative_dialog("kill", "small_group", 9, "ac130_fco_okyougothim");

  add_context_sensative_dialog("kill", "large_group", 0, "ac130_fco_hotdamn1");
  add_context_sensative_dialog("kill", "large_group", 0, "ac130_fco_hotdamn2");
  add_context_sensative_dialog("kill", "large_group", 0, "ac130_fco_hotdamn3");
  add_context_sensative_dialog("kill", "large_group", 1, "ac130_tvo_whoa1");
  add_context_sensative_dialog("kill", "large_group", 1, "ac130_tvo_whoa2");
  add_context_sensative_dialog("kill", "large_group", 1, "ac130_tvo_whoa3");
  add_context_sensative_dialog("kill", "large_group", 2, "ac130_fco_kaboom");

  add_context_sensative_dialog("location", "car", 0, "ac130_fco_guybycar");
  add_context_sensative_timeout("location", "car", undefined, 40);

  add_context_sensative_dialog("location", "truck", 0, "ac130_fco_guybytruck");
  add_context_sensative_timeout("location", "truck", undefined, 12);

  add_context_sensative_dialog("location", "building", 0, "ac130_fco_nailbybuilding1");
  add_context_sensative_timeout("location", "building", undefined, 20);

  add_context_sensative_dialog("location", "wall", 0, "ac130_tvo_coverbywall1");
  add_context_sensative_timeout("location", "wall", undefined, 20);

  add_context_sensative_dialog("location", "field", 0, "ac130_fco_crossingfield");
  add_context_sensative_timeout("location", "field", undefined, 20);

  add_context_sensative_dialog("location", "road", 0, "ac130_fco_enemyonroad");
  add_context_sensative_timeout("location", "road", undefined, 20);

  add_context_sensative_dialog("location", "church", 0, "ac130_fco_outofchurch");
  add_context_sensative_timeout("location", "church", undefined, 20);

  add_context_sensative_dialog("location", "ditch", 0, "ac130_fco_headinforditch");
  add_context_sensative_timeout("location", "ditch", undefined, 20);

  add_context_sensative_dialog("vehicle", "incoming", 0, "ac130_fco_movingvehicle");
  add_context_sensative_dialog("vehicle", "incoming", 1, "ac130_fco_vehicleonmove");
  add_context_sensative_dialog("vehicle", "incoming", 2, "ac130_plt_engvehicle");
  add_context_sensative_dialog("vehicle", "incoming", 3, "ac130_fco_getvehicle");

  add_context_sensative_dialog("vehicle", "death", 0, "ac130_fco_confirmed");
  add_context_sensative_dialog("vehicle", "death", 1, "ac130_fco_fulltank");

  add_context_sensative_dialog("misc", "action", 0, "ac130_plt_scanrange");
  add_context_sensative_timeout("misc", "action", 0, 70);

  add_context_sensative_dialog("misc", "action", 1, "ac130_plt_cleanup");
  add_context_sensative_timeout("misc", "action", 1, 80);

  add_context_sensative_dialog("misc", "action", 2, "ac130_plt_targetreset");
  add_context_sensative_timeout("misc", "action", 2, 55);

  add_context_sensative_dialog("misc", "action", 3, "ac130_plt_azimuthsweep");
  add_context_sensative_timeout("misc", "action", 3, 100);
}

add_context_sensative_dialog(name1, name2, group, soundAlias) {
  assert(isDefined(name1));
  assert(isDefined(name2));
  assert(isDefined(group));
  assert(isDefined(soundAlias));
  assert(soundexists(soundAlias) == true);

  if((!isDefined(level.scr_sound[name1])) || (!isDefined(level.scr_sound[name1][name2])) || (!isDefined(level.scr_sound[name1][name2][group]))) {
    level.scr_sound[name1][name2][group] = spawnStruct();
    level.scr_sound[name1][name2][group].played = false;
    level.scr_sound[name1][name2][group].sounds = [];
  }

  index = level.scr_sound[name1][name2][group].sounds.size;
  level.scr_sound[name1][name2][group].sounds[index] = soundAlias;
}

add_context_sensative_timeout(name1, name2, groupNum, timeoutDuration) {
  if(!isDefined(level.context_sensative_dialog_timeouts))
    level.context_sensative_dialog_timeouts = [];

  createStruct = false;
  if(!isDefined(level.context_sensative_dialog_timeouts[name1]))
    createStruct = true;
  else if(!isDefined(level.context_sensative_dialog_timeouts[name1][name2]))
    createStruct = true;
  if(createStruct)
    level.context_sensative_dialog_timeouts[name1][name2] = spawnStruct();

  if(isDefined(groupNum)) {
    level.context_sensative_dialog_timeouts[name1][name2].groups = [];
    level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupNum)] = spawnStruct();
    level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupNum)].v["timeoutDuration"] = timeoutDuration * 1000;
    level.context_sensative_dialog_timeouts[name1][name2].groups[string(groupNum)].v["lastPlayed"] = (timeoutDuration * -1000);
  } else {
    level.context_sensative_dialog_timeouts[name1][name2].v["timeoutDuration"] = timeoutDuration * 1000;
    level.context_sensative_dialog_timeouts[name1][name2].v["lastPlayed"] = (timeoutDuration * -1000);
  }
}
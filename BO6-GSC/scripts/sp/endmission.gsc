/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\endmission.gsc
**************************************/

#using scripts\common\ui;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\utility;
#namespace endmission;

function main() {
  if(!isDefined(level.missionsettings)) {
    level.missionsettings = spawnStruct();
  }

  level.lowestgameskill = getdvarint(@ "g_gameskill");
  function_614c4d14b6187105();

  if(isDefined(level.endmission_main_func)) {
    [[level.endmission_main_func]]();
    level.endmission_main_func = undefined;
  }

  if(!isDefined(level.mapinfoname) || level.mapinfoname == % "" || level.mapinfoname == "") {
    println("<dev string:x24>");
    level.mapinfoname = getxhashasset(function_898fa1abdeddc5b8(level.start_point));
  }

  println("<dev string:x98>", getxhashsourcename(level.mapinfoname));

  level thread function_ec825c9c2911e3d7();

  ui::lui_registercallback("F\xb2g\xf5GYn:\xeb\x9b+<\x1d\xbe\xb5-\x9b\xcd\xa5\xb7\xe6", &debug_test_next_mission);
  ui::function_6a872e488c8a38e9("\xb0]c2v\\\x0f\x8f\xed\xce\xcd\xa9\x9f\xceI\x0f\x1c\xe6\x8d", &function_8804527b749885b0);
  thread function_62f12c6ea0df21cc();
}

function private function_614c4d14b6187105() {
  if(!isDefined(level.missionsettings)) {
    level.missionsettings = spawnStruct();
  }

  level.missionsettings.levels = [];
  mapinfolist = function_220bd94c75c87c75();
  mapinfonames = function_97507fa2cb6f9fba();

  foreach(mapinfo in mapinfolist) {
    preloadtransients = undefined;

    if(isDefined(mapinfo.preloadtransients)) {
      preloadtransients = strtok(mapinfo.preloadtransients, "\xf8\x01");
    }

    count = level.missionsettings.levels.size;
    level.missionsettings.levels[count] = spawnStruct();
    level.missionsettings.levels[count].mapinfoname = getxhashasset(mapinfonames[index]);
    level.missionsettings.levels[count].mapname = mapinfo.mapname;
    level.missionsettings.levels[count].startpoint = mapinfo.startpoint;
    level.missionsettings.levels[count].missiontype = tolower(mapinfo.missiontype ?? "");
    level.missionsettings.levels[count].achievement = mapinfo.achievement == "" ? undefined : mapinfo.achievement;
    level.missionsettings.levels[count].hardened_achievement = mapinfo.achievementhardened == "" ? undefined : mapinfo.achievementhardened;
    level.missionsettings.levels[count].veteran_achievement = mapinfo.achievementveteran == "" ? undefined : mapinfo.achievementveteran;
    level.missionsettings.levels[count].loadbink = mapinfo.loadingmoviename == "" ? undefined : mapinfo.loadingmoviename;
    level.missionsettings.levels[count].settletime = mapinfo.settletime ?? 10;
    level.missionsettings.levels[count].clientsettletime = mapinfo.clientsettletime ?? 100;
    level.missionsettings.levels[count].preload_transients = preloadtransients;
    level.missionsettings.levels[count].persistentinventory = 0;
    level.missionsettings.levels[count].fadetime = 0;
    level.missionsettings.levels[count].streamsync = 0;
  }
}

function private getmissionlevels() {
  if(!isDefined(level.missionsettings.levels)) {
    function_614c4d14b6187105();
  }

  return level.missionsettings.levels;
}

function private function_ec825c9c2911e3d7() {
  self notify("\x13MN`\xcc1h\xb9\x89\xb1676\x99,\xb0");
  self endon("\x13MN`\xcc1h\xb9\x89\xb1676\x99,\xb0");
  setdvarifuninitialized(@ "hash_c67db63d93cf13e6", 0);
  waitframe();
  level.debuggameskill = [];

  while(true) {
    if(!getdvarint(@ "hash_c67db63d93cf13e6", 0)) {
      wait 1;
      continue;
    }

    lineindex = 0;
    lineindex = function_2c76786645d2ed35(lineindex, "<dev string:xaf>" + level.lowestgameskill, function_fb8188c713c28614(level.lowestgameskill));
    lineindex = function_2c76786645d2ed35(lineindex, "<dev string:xc6>");
    missionarray = level.player function_c281144d1096fa40();
    missionlevels = getmissionlevels();
    completedmissioncount = min(missionarray.size, missionlevels.size);
    highestdifficultycompleted = 9999;

    for(index = 0; index < completedmissioncount; index++) {
      var_3f97ada1315431d2 = int(max(0, missionarray[index] - 1));
      highestdifficultycompleted = int(min(highestdifficultycompleted, var_3f97ada1315431d2));
      indexstr = "<dev string:xc6>" + index;

      if(index < 10) {
        indexstr = "<dev string:xca>" + indexstr;
      }

      mapinfoname = getxhashsourcename(missionlevels[index].mapinfoname);
      var_8d7b9ae85235804a = "<dev string:xcf>" + indexstr + "<dev string:xdd>" + var_3f97ada1315431d2 + "<dev string:xca>" + mapinfoname;
      lineindex = function_2c76786645d2ed35(lineindex, var_8d7b9ae85235804a, function_fb8188c713c28614(var_3f97ada1315431d2));
    }

    lineindex = function_2c76786645d2ed35(lineindex, "<dev string:xc6>");
    lineindex = function_2c76786645d2ed35(lineindex, "<dev string:xe4>" + highestdifficultycompleted, function_fb8188c713c28614(highestdifficultycompleted));
    waitframe();
  }
}

function private function_fb8188c713c28614(gameskill) {
  switch (gameskill) {
    case 0:
      return (0.75, 0.75, 0.75);
    case 1:
      return (1, 1, 0);
    case 2:
      return (1, 0.75, 0);
    case 3:
      return (1, 0.5, 0);
    case 4:
      return (1, 0.25, 0);
    default:
      return (1, 0, 1);
  }
}

function private function_2c76786645d2ed35(index, text, color) {
  if(!isDefined(color)) {
    color = (0.75, 0.75, 0.75);
  }

  printtoscreen2d(60, 50 + index * 20, text, color, 1, 1);
  return index + 1;
}

function function_8804527b749885b0(unused, args) {
  channel = args[0];
  start_name = args[1];
  setDvar(@ "start", start_name);
}

function debug_test_next_mission(unused) {
  nextmission_internal();
}

function function_62f12c6ea0df21cc() {
  version = getbuildversion();

  if(version == "gy\x8b\xd7") {
    return;
  }

  setdvarifuninitialized(@ "test_next_mission", 0);
  wait 10;

  while(getdvarint(@ "test_next_mission") < 1) {
    wait 3;
  }

  setDvar(@ "test_next_mission", 0);
  nextmission_internal();
}

function nextmission_preload_internal(type, var_e2c8bbdadab97cd4, var_382282fcd89214ce) {
  nextlevelindex = getnextlevelindex(var_382282fcd89214ce);

  if(!isDefined(nextlevelindex)) {
    return;
  }

  if(!utility::flag_exist("f\xf9\xda8\xd8\x98\x98\x13\xd3Z8\x90Y\x94\xf96FAR<\x1b\xb8\x18\xf3\xf2\xdb\xdb\xc1")) {
    utility::flag_init("f\xf9\xda8\xd8\x98\x98\x13\xd3Z8\x90Y\x94\xf96FAR<\x1b\xb8\x18\xf3\xf2\xdb\xdb\xc1");
  }

  utility::flag_clear("f\xf9\xda8\xd8\x98\x98\x13\xd3Z8\x90Y\x94\xf96FAR<\x1b\xb8\x18\xf3\xf2\xdb\xdb\xc1");

  if(!isDefined(type)) {
    type = "\x84\x9b\x8cB";
  }

  if(!isDefined(var_e2c8bbdadab97cd4)) {
    var_e2c8bbdadab97cd4 = 1;
  }

  missionlevels = getmissionlevels();
  preload_transients = missionlevels[nextlevelindex].preload_transients;

  if(var_e2c8bbdadab97cd4) {
    level thread utility_sp::nextmission_primeloadbink();
  }

  if(getdvarint(@ "fastload", 1)) {
    levelmapname = getlevelmapname(nextlevelindex);

    switch (type) {
      case #"hash_af9a1714fe58109c":
        if(isDefined(preload_transients)) {
          array = utility::array_combine([levelmapname], preload_transients);
          preloadzones(array);
        } else {
          preloadzones(levelmapname);
        }

        break;
      case #"hash_4d3e1f9017db6ba5":
        preloadzones(levelmapname);
        break;
      case #"hash_ce8bfbd622fff22a":
        if(isDefined(preload_transients)) {
          preloadzones(preload_transients);
        }

        break;
    }

    while(!ispreloadzonescomplete()) {
      waitframe();
    }
  }

  utility::flag_set("f\xf9\xda8\xd8\x98\x98\x13\xd3Z8\x90Y\x94\xf96FAR<\x1b\xb8\x18\xf3\xf2\xdb\xdb\xc1");
}

function nextmission_primeloadbink_internal(var_382282fcd89214ce) {
  nextlevelindex = getnextlevelindex(var_382282fcd89214ce);

  if(!isDefined(nextlevelindex)) {
    return;
  }

  if(!utility::flag_exist("\xd9E\xe8\xf4d\xc9N\xf6\x90\xect\xfd\x93J\x13\x1f4i\xb2+\xfb\fYy\x81PWYj\x10\x01M\xddL")) {
    utility::flag_init("\xd9E\xe8\xf4d\xc9N\xf6\x90\xect\xfd\x93J\x13\x1f4i\xb2+\xfb\fYy\x81PWYj\x10\x01M\xddL");
  }

  mission_bink = function_d8cad167a4c8308(nextlevelindex);
  setsaveddvar(@ "bg_cinematicfullscreen", "\xfe");
  setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
  stopcinematicingame();
  waitframe();

  if(!isDefined(mission_bink)) {
    iprintlnbold("<dev string:xfb>");

    mission_bink = "\x91\xca\xcc\v\xab\xd8:";
  }

  cinematicingame(mission_bink, 1, 1, 1, 0, 0, 1);

  while(!iscinematicplaying()) {
    waitframe();
  }

  println("<dev string:x166>" + mission_bink);
  utility::flag_set("\xd9E\xe8\xf4d\xc9N\xf6\x90\xect\xfd\x93J\x13\x1f4i\xb2+\xfb\fYy\x81PWYj\x10\x01M\xddL");
}

function nextmission_internal(var_382282fcd89214ce) {
  if(getdvarint(@ "nextmission_disable")) {
    iprintlnbold("<dev string:x17a>");
    return;
  }

  if(utility_sp::is_demo()) {
    changelevel("", 0);
    return;
  }

  analytics::analytics_upload_during_nextmission();
  level notify("Bd2\xaa\xa2}2\xb13\xf4\xf5");
  level.nextmission = 1;
  level.player enableinvulnerability();
  levelindex = undefined;
  setDvar(@ "ui_showpopup", "\xfe");
  setDvar(@ "hash_b5229012ccf8e014", "");
  setDvar(@ "hash_3e810e7dcf052f5d", level.mapname);
  game["f\x807\xf6h\xc7\xebO\xdd\x82\x9c\xde"] = undefined;
  levelindex = getlevelindex(level.mapinfoname);

  if(!isDefined(levelindex)) {
    missionsuccess(level.mapinfoname);
    return;
  }

  if(!islastlevel()) {
    utility_sp::level_end_save();
  }

  function_8f0b0c19bebdc291(level.mapinfoname);
  println("<dev string:x19d>");

  if(getdvarint(@ "hash_bc76f1b9a1f7ba07") != 0) {
    var_78eb2dfa05cd5522 = getdvarint(@ "hash_b50de240594f8df4");
    var_2583846163ef3bd3 = function_46da7bb93c30e3a5(var_78eb2dfa05cd5522);
    highestmission_ifnotcheating_set(var_2583846163ef3bd3);
    function_8f0b0c19bebdc291(var_2583846163ef3bd3);
    setDvar(@ "hash_bc76f1b9a1f7ba07", "<dev string:xc6>");
  }

  difficultystring = "<dev string:xc6>";
  difficultyarray = level.player function_c281144d1096fa40();

  for(index = 0; index < difficultyarray.size; index++) {
    difficultystring += utility::string(difficultyarray[index]);
    difficultystring += "<dev string:x1c5>";
  }

  missionlevels = getmissionlevels();
  println("<dev string:x1ca>" + difficultystring + "<dev string:x1ed>");
  println("<dev string:x1f2>" + levelindex + "<dev string:x1ed>");
  println("<dev string:x215>" + getxhashsourcename(level.mapinfoname) + "<dev string:x1ed>");
  println("<dev string:x238>" + missionlevels.size + "<dev string:x1ed>");

  updategamerprofile();

  if(isDefined(function_6c9fa67ed0918657(levelindex))) {
    utility_sp::giveachievement_wrapper(function_6c9fa67ed0918657(levelindex));
  }

  if(isDefined(function_987e3639dfe83f66(levelindex)) && function_c8bad80d477196b0(levelindex) >= 3) {
    utility_sp::giveachievement_wrapper(function_987e3639dfe83f66(levelindex));
  }

  if(isDefined(function_cf4274f2a4079690(levelindex)) && function_c8bad80d477196b0(levelindex) >= 4) {
    utility_sp::giveachievement_wrapper(function_cf4274f2a4079690(levelindex));
  }

  if(islastlevel()) {
    if(isDefined(function_c294c287bfa24e07())) {
      utility_sp::giveachievement_wrapper(function_c294c287bfa24e07());
    }

    if(isDefined(function_fafbe974feee8300()) && function_58ddf2e4e6bc5eb6() >= 4) {
      utility_sp::giveachievement_wrapper(function_fafbe974feee8300());
    }
  }

  analytics::start_point_update("\x87\x8d\xb8\xad\x9e$_()$'", 1);

  if(isplatformps5()) {
    if(isDefined(level.ps5activity)) {
      stopactivity(level.ps5activity, "s\xef\xf1lff\xcc\xee\xf5");
    }
  }

  if(islastlevel()) {
    playcredits();
    changelevel("", 0);
    level.player waittill("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  }

  if(!isDefined(var_382282fcd89214ce)) {
    nextlevelindex = getnextlevelindex();
    assert(isDefined(nextlevelindex));
    var_382282fcd89214ce = function_46da7bb93c30e3a5(nextlevelindex);
  } else {
    nextlevelindex = getnextlevelindex(var_382282fcd89214ce);
    assert(isDefined(nextlevelindex));
  }

  assert(isxhashasset(var_382282fcd89214ce));
  function_619436c4b0c586f3(var_382282fcd89214ce);
  println("<dev string:x252>" + getxhashsourcename(var_382282fcd89214ce) + "<dev string:x1ed>");
  mission_bink = function_d8cad167a4c8308(nextlevelindex);

  if(isDefined(mission_bink) && !istrue(level.endmission_bink_skip)) {
    println("<dev string:x26c>" + mission_bink + "<dev string:x1ed>");
    setDvar(@ "hash_4967b5f5316f16af", mission_bink);

    if(!utility::flag_exist("\xd9E\xe8\xf4d\xc9N\xf6\x90\xect\xfd\x93J\x13\x1f4i\xb2+\xfb\fYy\x81PWYj\x10\x01M\xddL")) {
      utility::flag_init("\xd9E\xe8\xf4d\xc9N\xf6\x90\xect\xfd\x93J\x13\x1f4i\xb2+\xfb\fYy\x81PWYj\x10\x01M\xddL");
    }

    setomnvar("v\x01\xd7\xc7\x1ft/<\x80\x16\xdc", 1);

    if(!level.player islinked()) {
      tag = level.player utility::spawn_tag_origin();
      level.player playerlinktoabsolute(tag);
    }

    level.player freezecontrols(1);

    if(utility::flag("\xd9E\xe8\xf4d\xc9N\xf6\x90\xect\xfd\x93J\x13\x1f4i\xb2+\xfb\fYy\x81PWYj\x10\x01M\xddL")) {
      print("<dev string:x288>");
      setsaveddvar(@ "bg_cinematicfullscreen", "\x87");
      setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
      pausecinematicingame(0);
    } else {
      print("<dev string:x2ae>");
      setsaveddvar(@ "bg_cinematicfullscreen", "\x87");
      setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
      flags = 128 | 2048 | 8192;
      cinematicingame(mission_bink, flags);
    }
  }

  analytics::analytics_lui_mission_end_dlog();

  if(getlevelstreamsync(nextlevelindex)) {
    setstreamsynconnextlevel();
  }

  keepinventory = function_77b6bbd7a36c7525(levelindex);
  fade_time = function_465ab2835cf64d1d(levelindex);
  changelevel(var_382282fcd89214ce, keepinventory, fade_time);
}

function playcredits() {
  level.player openmenu("\xd0\x9ce\xc8\xb4\x1d\x9b5V7u");

  while(true) {
    level.player waittill("\xa6\xbd&nnj\xb4\x10\xf1\x12.cW.p", message, value);

    if(message == "y\r\xe8\x915\xedHl\xf3\xa6\x9ao") {
      break;
    }
  }
}

function function_619436c4b0c586f3(mapinfoname) {
  assert(isxhashasset(mapinfoname));

  while(!isDefined(level.player)) {
    waitframe();
  }

  if(!isprogressionlevel(mapinfoname)) {
    return;
  }

  if(isprogressionmismatch(mapinfoname)) {
    function_ed2a7c35cdae788f();
    return;
  }

  if(getdvarint(@ "hash_b8b8e25bb75b206d") == 0) {
    state = level.player getplayerprogression("1o\x9f4\xdc,\xcar\xbf\x0fi\xdf\xf6\x1b\br", mapinfoname);

    if(state == "!\x90l\x94\xcfU") {
      level.player setplayerprogression("1o\x9f4\xdc,\xcar\xbf\x0fi\xdf\xf6\x1b\br", mapinfoname, "v\xc4\xcf\x83\xd8K\x14B");

      if(getprojectname() == "_\xde_") {
        level.player function_627840b8a7387643("1o\x9f4\xdc,\xcar\xbf\x0fi\xdf\xf6\x1b\br", mapinfoname, "v\xc4\xcf\x83\xd8K\x14B");
      }
    }
  }
}

function function_8f0b0c19bebdc291(var_c6b208e36e654433 = level.mapinfoname) {
  assert(isxhashasset(var_c6b208e36e654433));

  if(!isprogressionlevel(var_c6b208e36e654433)) {
    return;
  }

  levelindex = getlevelindex(var_c6b208e36e654433);
  level.player setplayerprogression("1o\x9f4\xdc,\xcar\xbf\x0fi\xdf\xf6\x1b\br", var_c6b208e36e654433, "\xb1ok\ac\xb2\xd1V");

  if(getprojectname() == "_\xde_") {
    level.player function_627840b8a7387643("1o\x9f4\xdc,\xcar\xbf\x0fi\xdf\xf6\x1b\br", var_c6b208e36e654433, "\xb1ok\ac\xb2\xd1V");
  }

  lasthighestdifficulty = level.player function_bc821a59e1940c9d(levelindex);

  if(level.lowestgameskill + 1 > lasthighestdifficulty) {
    difficultycomplete = level.lowestgameskill + 1;

    if(function_6b082fd6a5e48d85(levelindex)) {
      difficultycomplete = 5;
    }

    level.player function_ba489b48a5efd7f9(levelindex, difficultycomplete);
  }
}

function isprogressionlevel(mapinfoname) {
  levelindex = getlevelindex(mapinfoname);
  return isDefined(levelindex);
}

function function_cb092bc2fe4a871c() {
  missionlevels = getmissionlevels();
  return missionlevels.size - 1;
}

function islastlevel() {
  levelindex = getlevelindex(level.mapinfoname);
  return levelindex == function_cb092bc2fe4a871c();
}

function getlevelindex(var_c6b208e36e654433) {
  missionlevels = getmissionlevels();

  if(!isDefined(var_c6b208e36e654433)) {
    var_c6b208e36e654433 = level.mapinfoname;
  }

  assert(isxhashasset(var_c6b208e36e654433));

  foreach(so_level in missionlevels) {
    if(so_level.mapinfoname == var_c6b208e36e654433) {
      return levelindex;
    }
  }

  return undefined;
}

function getnextlevelindex(var_382282fcd89214ce) {
  levelindex = getlevelindex(level.mapinfoname);

  if(!isDefined(levelindex)) {
    return;
  }

  if(isDefined(var_382282fcd89214ce)) {
    nextlevelindex = getlevelindex(var_382282fcd89214ce);
  } else {
    nextlevelindex = levelindex + 1;
  }

  missionlevels = getmissionlevels();

  if(isDefined(nextlevelindex) && nextlevelindex < missionlevels.size) {
    return nextlevelindex;
  }

  return undefined;
}

function getlevelmapname(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].mapname;
}

function function_46da7bb93c30e3a5(levelindex) {
  if(!isDefined(levelindex)) {
    return level.mapinfoname;
  }

  missionlevels = getmissionlevels();
  return missionlevels[levelindex].mapinfoname;
}

function function_4ed6bc4cca4dcf99() {
  missionlevels = getmissionlevels();

  if(missionlevels.size == 0) {
    return level.mapinfoname;
  }

  levelindex = function_cb092bc2fe4a871c();
  return function_46da7bb93c30e3a5(levelindex);
}

function function_334b199b4d675b0a(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].missiontype;
}

function function_6b082fd6a5e48d85(levelindex) {
  missiontype = function_334b199b4d675b0a(levelindex);
  return missiontype == "n\vf\x95\xa1{\xba\x9b\x95";
}

function function_6c9fa67ed0918657(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].achievement;
}

function function_987e3639dfe83f66(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].hardened_achievement;
}

function function_cf4274f2a4079690(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].veteran_achievement;
}

function function_c294c287bfa24e07() {
  gamemodebundle = getgamemodescriptbundle();
  return gamemodebundle.achievementcampaign;
}

function function_fafbe974feee8300(levelindex) {
  gamemodebundle = getgamemodescriptbundle();
  return gamemodebundle.achievementcampaignveteran;
}

function getlevelcompleted(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  return level.player function_bc821a59e1940c9d(levelindex);
}

function highestmission_ifnotcheating_set(mission) {
  if(getDvar(@ "hash_b8b8e25bb75b206d") == "\x87") {
    return;
  }
}

function function_c8bad80d477196b0(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  return level.player function_bc821a59e1940c9d(levelindex);
}

function function_58ddf2e4e6bc5eb6() {
  missionarray = level.player function_c281144d1096fa40();
  highestdifficultycompleted = 5;
  missionlevels = getmissionlevels();
  completedmissioncount = min(missionarray.size, missionlevels.size);

  for(index = 0; index < completedmissioncount; index++) {
    if(missionarray[index] < highestdifficultycompleted) {
      highestdifficultycompleted = missionarray[index];
    }
  }

  return highestdifficultycompleted;
}

function clearall() {
  missionarray = [];
  arraycount = level.player function_fa757958e48e187d();

  for(index = 0; index < arraycount; index++) {
    missionarray[index] = 0;
  }

  level.player function_84c5d60cb83a1964(missionarray);
}

function function_ed2a7c35cdae788f() {
  setomnvar("\a\x9c{\xb3N\xca\xdcn-\xf6s}-\xcd\x9d\xc2\x1bK\xc8", 1);
}

function isprogressionmismatch(mapinfoname) {
  levelindex = getlevelindex(mapinfoname);

  if(previouslevelcompleted(levelindex) || isdevbuild() || getdvarint(@ "fpstool_run")) {
    return false;
  } else {
    return true;
  }

  return false;
}

function function_cb4c673529c8614f(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);

  if(!isDefined(levelindex)) {
    return false;
  }

  mapinfoname = function_46da7bb93c30e3a5(levelindex);

  if(!isDefined(mapinfoname)) {
    return false;
  }

  state = level.player getplayerprogression("1o\x9f4\xdc,\xcar\xbf\x0fi\xdf\xf6\x1b\br", mapinfoname);

  if(state != "\xb1ok\ac\xb2\xd1V") {
    return false;
  }

  return true;
}

function previouslevelcompleted(levelindex) {
  if(levelindex == 0) {
    return true;
  }

  return function_cb4c673529c8614f(levelindex - 1);
}

function isdevbuild() {
  devbuild = 0;
  setdvarifuninitialized(@ "hash_b3fcf6e357e30812", 0);

  if(!getdvarint(@ "hash_b3fcf6e357e30812")) {
    devbuild = 1;
  }

  return devbuild;
}

function function_898fa1abdeddc5b8(start_point) {
  if(!isDefined(start_point)) {
    start_point = getDvar(@ "start", "");
  }

  currentlevelmapname = level.mapname;

  if(start_point == "") {
    return currentlevelmapname;
  }

  var_755175938c0823d = [];
  missionlevels = getmissionlevels();

  foreach(so_level in missionlevels) {
    if(so_level.mapname == currentlevelmapname) {
      if(isDefined(so_level.startpoint)) {
        if(so_level.startpoint == start_point) {
          return so_level.mapinfoname;
        }

        if(so_level.startpoint != "") {
          var_755175938c0823d[so_level.startpoint] = so_level.mapinfoname;
        }
      }
    }
  }

  startindex = -1;

  for(index = level.start_functions.size - 1; index >= 0; index--) {
    var_6faafdc99e13680a = level.start_functions[index]["\xf4\x1f\x13\xee"];

    if(isDefined(var_6faafdc99e13680a)) {
      if(var_6faafdc99e13680a == start_point) {
        startindex = index;
      }

      if(index <= startindex) {
        if(isDefined(var_755175938c0823d[var_6faafdc99e13680a])) {
          return var_755175938c0823d[var_6faafdc99e13680a];
        }
      }
    }
  }

  return currentlevelmapname;
}

function function_d8cad167a4c8308(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  loadbink = undefined;
  missionlevels = getmissionlevels();

  if(levelindex < missionlevels.size) {
    loadbink = missionlevels[levelindex].loadbink;
  }

  return loadbink;
}

function level_settle_time_get(var_c6b208e36e654433) {
  assert(isDefined(var_c6b208e36e654433));
  index = getlevelindex(var_c6b208e36e654433);

  if(!isDefined(index)) {
    return 0;
  }

  missionlevels = getmissionlevels();
  return missionlevels[index].settletime;
}

function client_settle_time_get(var_c6b208e36e654433) {
  assert(isDefined(var_c6b208e36e654433));
  index = getlevelindex(var_c6b208e36e654433);

  if(!isDefined(index)) {
    return 0;
  }

  missionlevels = getmissionlevels();
  return missionlevels[index].clientsettletime;
}

function level_settle_time_wait(var_c6b208e36e654433) {
  if(!isDefined(var_c6b208e36e654433)) {
    var_c6b208e36e654433 = level.mapinfoname;
  }

  settletime = level_settle_time_get(var_c6b208e36e654433);
  clientsettletime = client_settle_time_get(var_c6b208e36e654433);

  if(!isDefined(settletime)) {
    settletime = 0;
  }

  if(!isDefined(clientsettletime)) {
    clientsettletime = 0;
  } else {
    clientsettletime *= 0.02;
  }

  totalsettletime = settletime + clientsettletime;

  if(isDefined(totalsettletime)) {
    wait totalsettletime * 0.05;
  }

  if(isDefined(clientsettletime) && clientsettletime <= 0) {
    waitframe();
    return;
  }

  if(!isDefined(settletime) || settletime <= 0) {
    waitframe();
  }
}

function function_465ab2835cf64d1d(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].fadetime;
}

function function_77b6bbd7a36c7525(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].persistentinventory;
}

function getlevelstreamsync(levelindex) {
  levelindex = levelindex ?? getlevelindex(level.mapinfoname);
  missionlevels = getmissionlevels();
  return missionlevels[levelindex].streamsync;
}

function collateraldamageassessment(var_c6b208e36e654433) {
  grade = getcollateraldamagegrade();
  level.player setplayerprogression("+\"_Y\x8b\xfbM\xffW*\xf1\x86^qv\xae\xd8i\xb6\xb9", var_c6b208e36e654433, grade);
  best = level.player getplayerprogression("l\xb4\xd9K\xb1\x96an\xdcZ\xa5\x8d\x1b\xac#\xd1'\x16\xc8\xcaB\xb2\xe6\xe8", var_c6b208e36e654433);

  if(grade > best) {
    level.player setplayerprogression("l\xb4\xd9K\xb1\x96an\xdcZ\xa5\x8d\x1b\xac#\xd1'\x16\xc8\xcaB\xb2\xe6\xe8", var_c6b208e36e654433, grade);
  }
}

function getcollateraldamagegrade() {
  var_d300c96a475dbf6f = 4;
  grade = int(min(level.friendlyfire["\x81\x94\xd0\xcc\x86=\x19\x06\xc8]\xfd`\x8f-\x12\a"], var_d300c96a475dbf6f));
  grade = var_d300c96a475dbf6f - grade;
  return int(grade);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\progression.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_relics;
#using scripts\cp\progression;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\engine\utility;
#namespace progression;

function init() {
  level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&function_f7b1518e621a2ca5);
}

function function_f7b1518e621a2ca5() {
  function_ba3b90db77bd6f5c();

  self.var_b77b2a2fff31d1e1 = spawnStruct();
  self.var_b77b2a2fff31d1e1.careerstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x2b>");
  self.var_b77b2a2fff31d1e1.assaultstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x37>", "<dev string:x41>", "<dev string:x4d>");
  self.var_b77b2a2fff31d1e1.medicstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x37>", "<dev string:x41>", "<dev string:x5a>");
  self.var_b77b2a2fff31d1e1.reconstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x37>", "<dev string:x41>", "<dev string:x65>");
  self.var_b77b2a2fff31d1e1.currentkit = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x37>", "<dev string:x70>");
  self.var_b77b2a2fff31d1e1.currentmission = self getplayerdata("<dev string:x1c>", "<dev string:x7b>", "<dev string:x8d>");

  function_7b360ae0833008d6();
  function_80a2b94f26708876();
  self setplayerdata("cp", "CPSession", "weeklyStarsEarnedLastMatch", 0);
  thread function_46408ac32c846594();
}

function function_80a2b94f26708876() {
  if(!istrue(self.pers["intelTrackingInitialized"])) {
    self setplayerdata("cp", "intelCollectFiveRewardAmount", 0);
    self.pers["intelTrackingInitialized"] = 1;
  }

  if(istrue(self getplayerdata("cp", "receivedIntelStars", "hasReceivedIntelStars"))) {
    return;
  }

  totalintel = self getplayerdata("cp", "totalIntel");
  var_55accf4a36543cc0 = int(floor(totalintel / 5));

  for(i = 0; i < var_55accf4a36543cc0; i++) {
    scripts\cp\progression::function_9b50c58f20b295a0(2);
  }

  self setplayerdata("cp", "receivedIntelStars", "hasReceivedIntelStars", 1);
}

function function_46408ac32c846594() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("luinotifyserver", message, category);

    if(message != "completed_cp_challenge") {
      continue;
    }

    switch (category) {
      case 2:
      case 3:
        function_9b50c58f20b295a0(1);
        break;
      default:
        break;
    }
  }
}

function function_ba3b90db77bd6f5c() {
  self.var_61429815f304f542 = function_1d4995f917dff69e();
  var_72d06b8f947025a3 = getdvarint(@ "hash_9c953c01fc5249dd", 0);

  if(var_72d06b8f947025a3 == 0) {
    return;
  }

  if(self.var_61429815f304f542 == 0) {
    function_732f1ae955e959ea(var_72d06b8f947025a3);
    return;
  }

  if(var_72d06b8f947025a3 > self.var_61429815f304f542) {
    function_732f1ae955e959ea(var_72d06b8f947025a3);
    function_2f934ec3b9bf0670();
  }
}

function function_1d4995f917dff69e() {
  return self getplayerdata("cp", "weeklyProgression", "weeklyResetTime");
}

function function_732f1ae955e959ea(var_c377a7dec55fca7a) {
  return self setplayerdata("cp", "weeklyProgression", "weeklyResetTime", var_c377a7dec55fca7a);
}

function function_2f934ec3b9bf0670() {
  function_6a736b3cccb5bdfb();
}

function function_cbaa41c477d4c53f() {
  var_97d7cb191ff67887 = self getplayerdata("cp", "progression", "careerStars");

  self.var_b77b2a2fff31d1e1.careerstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x2b>");

  assertex(isDefined(var_97d7cb191ff67887), "Player's current career stars is undefined");
  return var_97d7cb191ff67887;
}

function function_79bd9667e0db0f6b(var_bd955de25b902a62) {
  var_97d7cb191ff67887 = function_cbaa41c477d4c53f();
  self setplayerdata("cp", "progression", "careerStars", var_97d7cb191ff67887 + var_bd955de25b902a62);

  self.var_b77b2a2fff31d1e1.careerstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x2b>");

  return var_97d7cb191ff67887 + var_bd955de25b902a62;
}

function function_9b50c58f20b295a0(var_30c2b3c99058169e) {
  current_kit = function_5801d9069ff58385();
  assertex(isDefined(current_kit), "You cannot add bonus stars to an undefined kit");
  function_79bd9667e0db0f6b(var_30c2b3c99058169e);
  function_13189a21870c2539(current_kit, var_30c2b3c99058169e, var_30c2b3c99058169e, 1);
}

function function_9f35ebf8db17e8d9(current_kit) {
  assertex(isDefined(current_kit), "Cannot get stars for undefined kit");

  switch (current_kit) {
    case #"hash_f7803221ec64d903":
      return function_900cc31798521e59("medicStars");
    case #"hash_36cdfbfaeba9a21a":
      return function_900cc31798521e59("assaultStars");
    case #"hash_2b0e6b98c99852f2":
      return function_900cc31798521e59("reconStars");
  }

  assertmsg("No kit found to get stars from. Kit = ", current_kit);
  return 0;
}

function function_13189a21870c2539(current_kit, var_c8be13b6bd8f7e05, stars_earned, var_38e0188a424bc7a7) {
  assertex(isDefined(current_kit), "Cannot add stars for undefined kit");

  if(!istrue(var_38e0188a424bc7a7)) {
    if(stars_earned <= function_e7af75648059f540()) {
      return function_e7af75648059f540();
    }
  }

  var_ef0442bca1ad6307 = function_9f35ebf8db17e8d9(current_kit);
  var_9126bdab27208dff = int(var_ef0442bca1ad6307 + clamp(stars_earned, 0, var_c8be13b6bd8f7e05));

  switch (current_kit) {
    case #"hash_f7803221ec64d903":
      function_14bb942461a90723("medicStars", var_9126bdab27208dff);

      self.var_b77b2a2fff31d1e1.medicstars = function_900cc31798521e59("<dev string:x5a>");

      return var_9126bdab27208dff;
    case #"hash_36cdfbfaeba9a21a":
      function_14bb942461a90723("assaultStars", var_9126bdab27208dff);

      self.var_b77b2a2fff31d1e1.assaultstars = function_900cc31798521e59("<dev string:x4d>");

      return var_9126bdab27208dff;
    case #"hash_2b0e6b98c99852f2":
      function_14bb942461a90723("reconStars", var_9126bdab27208dff);

      self.var_b77b2a2fff31d1e1.reconstars = function_900cc31798521e59("<dev string:x65>");

      return var_9126bdab27208dff;
  }

  assertmsg("No kit found to add stars to. Kit = ", current_kit);
  return 0;
}

function function_1d9eeda30f722f43(stars_earned, game_length) {
  foreach(player in level.players) {
    current_kit = player function_5801d9069ff58385();
    player function_79bd9667e0db0f6b(stars_earned);
    var_c8be13b6bd8f7e05 = player function_7b3e5617c1a872a4();
    player function_13189a21870c2539(current_kit, var_c8be13b6bd8f7e05, stars_earned);
    player function_3180567d942c0eac(stars_earned);
    player function_490eaaddb15805df(stars_earned, game_length);
  }
}

function function_490eaaddb15805df(stars_earned, game_length) {
  current_mission = function_3e1f4ec9f2ea7f0a();

  if(!isDefined(current_mission) || current_mission == "") {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    var_97acf04b1260e998 = level.players[i] getplayerdata("cp", "careerstarsdata", current_mission, "careerStarsDataPerMission", "starsRewarded");

    if(!isDefined(var_97acf04b1260e998) || stars_earned > var_97acf04b1260e998) {
      level.players[i] setplayerdata("cp", "careerstarsdata", current_mission, "careerStarsDataPerMission", "starsRewarded", stars_earned);
    }

    best_time = level.players[i] getplayerdata("cp", "careerstarsdata", current_mission, "careerStarsDataPerMission", "personalBestTime");

    if(!isDefined(best_time) || best_time <= 0 || game_length < best_time) {
      level.players[i] setplayerdata("cp", "careerstarsdata", current_mission, "careerStarsDataPerMission", "personalBestTime", game_length);
      level.players[i] setclientomnvar("ui_aar_is_personal_best", 1);
      continue;
    }

    level.players[i] setclientomnvar("ui_aar_is_personal_best", 0);
  }
}

function function_7b360ae0833008d6() {
  current_mission = function_399ccfe790a8b2eb();

  if(!isDefined(current_mission) || current_mission == "") {
    return;
  }

  self setplayerdata("cp", "weeklyProgression", "missionName", current_mission);

  self.var_b77b2a2fff31d1e1.currentmission = current_mission;

  return current_mission;
}

function function_3e1f4ec9f2ea7f0a() {
  self.var_b77b2a2fff31d1e1.currentmission = self getplayerdata("<dev string:x1c>", "<dev string:x7b>", "<dev string:x8d>");

  return self getplayerdata("cp", "weeklyProgression", "missionName");
}

function function_14bb942461a90723(var_43175630d0b22405, star_amount) {
  return self setplayerdata("cp", "progression", "playerKit", "kitProgress", var_43175630d0b22405, star_amount);
}

function function_900cc31798521e59(var_43175630d0b22405) {
  switch (var_43175630d0b22405) {
    case #"hash_36cdfbfaeba9a21a":
      self.var_b77b2a2fff31d1e1.assaultstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x37>", "<dev string:x41>", var_43175630d0b22405);
      break;
    case #"hash_f7803221ec64d903":
      self.var_b77b2a2fff31d1e1.medicstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x37>", "<dev string:x41>", var_43175630d0b22405);
      break;
    case #"hash_2b0e6b98c99852f2":
      self.var_b77b2a2fff31d1e1.reconstars = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", "<dev string:x37>", "<dev string:x41>", var_43175630d0b22405);
      break;
  }

  return self getplayerdata("cp", "progression", "playerKit", "kitProgress", var_43175630d0b22405);
}

function function_5801d9069ff58385() {
  current_kit = self getplayerdata("cp", "progression", "playerKit", "currentKit");

  self.var_b77b2a2fff31d1e1.currentkit = current_kit;

  assertex(isDefined(current_kit), "Player Data kit cannot be undefined.");
  return current_kit;
}

function function_3180567d942c0eac(var_9126bdab27208dff) {
  current_mission = function_3e1f4ec9f2ea7f0a();

  if(!isDefined(current_mission) || current_mission == "") {
    return;
  }

  var_965d95bdc550c95b = 3;
  var_86ac4a7077d1d602 = function_e7af75648059f540();
  var_ab92344a22e80d75 = var_965d95bdc550c95b - var_86ac4a7077d1d602;
  var_1ae4b05aa2a8f73d = int(clamp(var_9126bdab27208dff, 0, var_ab92344a22e80d75));
  var_522ddeaec1a60937 = var_86ac4a7077d1d602 + var_1ae4b05aa2a8f73d;
  self setplayerdata("cp", "CPSession", "weeklyStarsEarnedLastMatch", var_1ae4b05aa2a8f73d);

  switch (current_mission) {
    case #"hash_669c74f156249b88":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyBadSituationStars", var_522ddeaec1a60937);
      break;
    case #"hash_a2cea08b38879015":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyHeliEscortStars", var_522ddeaec1a60937);
      break;
    case #"hash_cbb70c11866ca750":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyVehicleEscapeStars", var_522ddeaec1a60937);
      break;
    case #"hash_444ff8acbd3c5ce7":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyObservatoryStars", var_522ddeaec1a60937);
      break;
    case #"hash_b2ea240705358444":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyGunGameObservatoryStars", var_522ddeaec1a60937);
      break;
    case #"hash_5cb3232a9c6e69e7":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyOITCBadSituationStars", var_522ddeaec1a60937);
      break;
    case #"hash_ec79f57248c8017a":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyDefenderLoneStars", var_522ddeaec1a60937);
      break;
    case #"hash_ee49e7b293a87947":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1VeteranStars", var_522ddeaec1a60937);
      break;
    case #"hash_3446049904a6d9a0":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1Stars", var_522ddeaec1a60937);
      break;
    case #"hash_6a54415020264238":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2VeteranStars", var_522ddeaec1a60937);
      break;
    case #"hash_3446079904a6de59":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2Stars", var_522ddeaec1a60937);
      break;
    case #"hash_180a622ab6492fdd":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3VeteranStars", var_522ddeaec1a60937);
      break;
    case #"hash_3446069904a6dcc6":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3Stars", var_522ddeaec1a60937);
      break;
    case #"hash_8c20388f9b54cd7e":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4VeteranStars", var_522ddeaec1a60937);
      break;
    case #"hash_3446099904a6e17f":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4Stars", var_522ddeaec1a60937);
      break;
  }

  return var_522ddeaec1a60937;
}

function function_e7af75648059f540() {
  current_mission = function_3e1f4ec9f2ea7f0a();

  if(!isDefined(current_mission) || current_mission == "") {
    return;
  }

  switch (current_mission) {
    case #"hash_669c74f156249b88":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyBadSituationStars");
    case #"hash_a2cea08b38879015":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyHeliEscortStars");
    case #"hash_cbb70c11866ca750":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyVehicleEscapeStars");
    case #"hash_444ff8acbd3c5ce7":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyObservatoryStars");
    case #"hash_b2ea240705358444":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyGunGameObservatoryStars");
    case #"hash_5cb3232a9c6e69e7":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyOITCBadSituationStars");
    case #"hash_ec79f57248c8017a":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyDefenderLoneStars");
    case #"hash_ee49e7b293a87947":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1VeteranStars");
    case #"hash_3446049904a6d9a0":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1Stars");
    case #"hash_6a54415020264238":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2VeteranStars");
    case #"hash_3446079904a6de59":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2Stars");
    case #"hash_180a622ab6492fdd":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3VeteranStars");
    case #"hash_3446069904a6dcc6":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3Stars");
    case #"hash_8c20388f9b54cd7e":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4VeteranStars");
    case #"hash_3446099904a6e17f":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4Stars");
  }

  return "";
}

function function_399ccfe790a8b2eb() {
  switch (level.script) {
    case #"hash_d9c138fad5b09bff":
      if(istrue(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber"))) {
        return "BadSituationModified";
      } else {
        return "BadSituation";
      }
    case #"hash_e7978e13d7ba3321":
      if(istrue(level.var_5f694efafeb95d7)) {
        return "HeliEscort";
      } else {
        return "VehicleEscape";
      }
    case #"hash_fac4357bd021125d":
      if(istrue(scripts\cp\cp_relics::function_30d732f612695ba8())) {
        return "ObservatoryModified";
      } else {
        return "Observatory";
      }
    case #"hash_a53278cce220cfff":
      return "DefenderLone";
    case #"hash_5e656a0bf62ec176":
      if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
        return "Raid1Veteran";
      }

      return "Raid1";
    case #"hash_e8510abc4b5e935c":
      if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
        return "Raid2Veteran";
      }

      return "Raid2";
    case #"hash_1a6467aaad3208f1":
      if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
        return "Raid3Veteran";
      }

      return "Raid3";
    case #"hash_1725f94e0ec2b5f2":
      if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
        return "Raid4Veteran";
      }

      return "Raid4";
  }

  return "";
}

function private function_6a736b3cccb5bdfb() {
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyBadSituationStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyHeliEscortStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyVehicleEscapeStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyObservatoryStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyGunGameObservatoryStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyOITCBadSituationStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyDefenderLoneStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1VeteranStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2VeteranStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3VeteranStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4VeteranStars", 0);
}

function private function_7b3e5617c1a872a4() {
  var_86ac4a7077d1d602 = function_e7af75648059f540();
  return 3 - var_86ac4a7077d1d602;
}
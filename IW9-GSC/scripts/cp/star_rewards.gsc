/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\star_rewards.gsc
***********************************************/

init() {
  level._id_2E42F69F0C1E31C3 = spawnStruct();
  level._id_2E42F69F0C1E31C3.start_time = gettime() / 1000;
  level._id_2E42F69F0C1E31C3.times = [];
  level._id_2E42F69F0C1E31C3._id_F21776669A3B6BB4 = 0;
  level._id_2E42F69F0C1E31C3._id_E0BE7D747D6A32BE = [];
  _id_A133C2FF48B59DD7("time");
  _id_6CCB377E839D87C4(2100, 1500, 900);
}

_id_A133C2FF48B59DD7(type) {
  level._id_2E42F69F0C1E31C3._id_F90445E7C6431F6B = type;

  if(type == "scripted") {
    level notify("stars_reduceDifficultyAtOneStar");
    level._id_2E42F69F0C1E31C3._id_0FF63BC215227A6D = 3;
  } else if(type == "score") {
    level notify("stars_reduceDifficultyAtOneStar");
    level._id_2E42F69F0C1E31C3._id_A35AEBD49653C31C = 0;
  }
}

_id_4204D481F7D65D23(_id_F21776669A3B6BB4, type) {
  level._id_2E42F69F0C1E31C3._id_F21776669A3B6BB4 = level._id_2E42F69F0C1E31C3._id_F21776669A3B6BB4 + _id_F21776669A3B6BB4;

  if(isDefined(type)) {
    if(!isDefined(level._id_2E42F69F0C1E31C3._id_E0BE7D747D6A32BE[type]))
      level._id_2E42F69F0C1E31C3._id_E0BE7D747D6A32BE[type] = _id_F21776669A3B6BB4;
    else
      level._id_2E42F69F0C1E31C3._id_E0BE7D747D6A32BE[type] = level._id_2E42F69F0C1E31C3._id_E0BE7D747D6A32BE[type] + _id_F21776669A3B6BB4;
  }
}

_id_0F601F9FACF5F2C1() {
  [_id_96ED04D8C80C6220, _id_CFBCB02C4E5EA638, _id_0230FDCC18AE6D0D] = _id_C6A366DD2FF66E19();
  setomnvar("zm_time_survived", int(_id_96ED04D8C80C6220));
  setomnvar("ui_so_stars_given", _id_CFBCB02C4E5EA638);

  if(_id_CFBCB02C4E5EA638 == 3)
    level thread scripts\cp\cp_achievement::_id_57B06AC64F28DC4A();

  if(_id_CFBCB02C4E5EA638 >= 1) {
    level thread scripts\cp\cp_achievement::_id_42AE9DFC72534D75();
    scripts\cp\challenges_cp::_id_FF3FFCCAC94C5578(level.script, _id_CFBCB02C4E5EA638);
    _id_0998572FF3C96EE5::_id_1D9EEDA30F722F43(_id_CFBCB02C4E5EA638, _id_96ED04D8C80C6220);

    if(scripts\cp\utility::is_raid_gamemode()) {
      _id_3D5DC66341D1ED92::_id_2CA23024661E30AE();
      _id_3D5DC66341D1ED92::_id_4EC90E865BD62BF5();
      _id_3D5DC66341D1ED92::_id_31124F4DD33AD7F2();

      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        _id_3D5DC66341D1ED92::_id_E0E2F13DEC46E52E();
      else {
        foreach(player in level.players)
        player setplayerdata("cp", "lastRaidVeteranReward", "None");
      }
    }
  }

  foreach(player in level.players) {
    if(!scripts\cp\utility::is_raid_gamemode())
      player setplayerdata("cp", "lastRaidReward", "None");
  }

  if(isDefined(_id_0230FDCC18AE6D0D) && _id_0230FDCC18AE6D0D <= 3)
    setomnvar("ui_so_next_score", _id_0230FDCC18AE6D0D);
}

_id_C6A366DD2FF66E19() {
  _id_96ED04D8C80C6220 = undefined;
  _id_81779B5376410A19 = undefined;
  _id_0230FDCC18AE6D0D = undefined;

  if(level._id_2E42F69F0C1E31C3._id_F90445E7C6431F6B == "time")
    [_id_96ED04D8C80C6220, _id_81779B5376410A19, _id_0230FDCC18AE6D0D] = _id_09856DAAFE612467();
  else if(level._id_2E42F69F0C1E31C3._id_F90445E7C6431F6B == "scripted") {
    [_id_96ED04D8C80C6220, _id_07B37E3F68E66B28] = _id_51C95119BE8BD65B();
    _id_81779B5376410A19 = _id_5B09D746BD349182();

    if(_id_81779B5376410A19 + 1 <= 3)
      _id_0230FDCC18AE6D0D = _id_81779B5376410A19 + 1;
  }

  return [_id_96ED04D8C80C6220, _id_81779B5376410A19, _id_0230FDCC18AE6D0D];
}

_id_EEB437CBA958D31E() {
  _id_06D101F245B62B65 = 0;

  if(isDefined(game["star_rewards_times"]))
    _id_06D101F245B62B65 = game["star_rewards_times"];

  return [_id_06D101F245B62B65, level._id_2E42F69F0C1E31C3._id_F21776669A3B6BB4];
}

_id_09856DAAFE612467(_id_96ED04D8C80C6220, _id_81779B5376410A19, _id_0230FDCC18AE6D0D) {
  [_id_5841214B3C91C15B, _id_07B37E3F68E66B28] = _id_51C95119BE8BD65B();
  times = _id_F0B5555693BB9DEA();
  _id_81779B5376410A19 = 1;
  keys = getarraykeys(times);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    key = keys[_id_AC0E594AC96AA3A8];

    if(_id_5841214B3C91C15B <= level._id_2E42F69F0C1E31C3.times[key]) {
      _id_81779B5376410A19 = _id_AC0E594AC96AA3A8 + 1;
      _id_0230FDCC18AE6D0D = _id_81779B5376410A19 + 1;
    }
  }

  return [_id_5841214B3C91C15B, _id_81779B5376410A19, _id_0230FDCC18AE6D0D];
}

_id_51C95119BE8BD65B() {
  [_id_07B37E3F68E66B28, _id_13FACE5B7D5CE7B4] = _id_EEB437CBA958D31E();
  _id_5841214B3C91C15B = _id_07B37E3F68E66B28 + _id_13FACE5B7D5CE7B4;
  return [_id_5841214B3C91C15B, _id_07B37E3F68E66B28];
}

_id_F0B5555693BB9DEA() {
  return level._id_2E42F69F0C1E31C3.times;
}

_id_6CCB377E839D87C4(_id_F6535FF1AD23A66F, _id_798321C2BB6FEA88, _id_0143A08386FA1981) {
  level._id_2E42F69F0C1E31C3.times["star_1_time"] = _id_F6535FF1AD23A66F;
  level._id_2E42F69F0C1E31C3.times["star_2_time"] = _id_798321C2BB6FEA88;
  level._id_2E42F69F0C1E31C3.times["star_3_time"] = _id_0143A08386FA1981;
  level thread _id_2AFFE72A18280F97(_id_798321C2BB6FEA88);
}

_id_2AFFE72A18280F97(_id_798321C2BB6FEA88) {
  level notify("stars_reduceDifficultyAtOneStar");
  level endon("stars_reduceDifficultyAtOneStar");
  level endon("game_ended");

  if(getdvarint("dvar_C7C02892F746A20C", 0)) {
    waittime = _id_798321C2BB6FEA88;
    _id_06D101F245B62B65 = undefined;

    if(isDefined(game["star_rewards_times"]))
      _id_06D101F245B62B65 = game["star_rewards_times"] / 1000;

    if(isDefined(_id_06D101F245B62B65))
      waittime = _id_798321C2BB6FEA88 - _id_06D101F245B62B65;

    if(waittime >= 0.05) {
      wait(waittime);
      _id_8C503B084FC2BF04();
    }
  }
}

_id_8C503B084FC2BF04() {
  if(scripts\cp\utility::is_raid_gamemode()) {
    scripts\cp\cp_gameskill::_id_2B72A5CF9E5597F9(1);

    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
      scripts\cp\cp_gameskill::_id_2B72A5CF9E5597F9(2);
  } else
    scripts\cp\cp_gameskill::_id_2B72A5CF9E5597F9(0);

  scripts\cp\cp_gameskill::updategameskill();
  setomnvar("cp_difficulty_level", level.gameskill);
  scripts\cp\cp_gameskill::_id_1FC33D9E5389101F();
}

_id_9D2F4B3314C3BDB8(_id_1D050853A654A442) {
  _id_B41968A309ED014E = _id_5B09D746BD349182();

  if(istrue(_id_1D050853A654A442)) {
    _id_1F34C3EFAD7A70F5 = _id_B41968A309ED014E - 1;
    _id_26DC2F0B0BD90E86(_id_1F34C3EFAD7A70F5);
  } else {
    _id_1F34C3EFAD7A70F5 = _id_B41968A309ED014E + 1;
    _id_26DC2F0B0BD90E86(_id_1F34C3EFAD7A70F5);
  }
}

_id_26DC2F0B0BD90E86(count) {
  if(count > 3 || count < 1)
    level._id_2E42F69F0C1E31C3._id_0FF63BC215227A6D = 1;
  else
    level._id_2E42F69F0C1E31C3._id_0FF63BC215227A6D = count;

  if(level._id_2E42F69F0C1E31C3._id_0FF63BC215227A6D <= 1)
    _id_8C503B084FC2BF04();
}

_id_5B09D746BD349182() {
  return level._id_2E42F69F0C1E31C3._id_0FF63BC215227A6D;
}

_id_578C2B4D51D13B9A() {
  _id_96ED04D8C80C6220 = getomnvar("zm_time_survived");

  foreach(player in level.players) {
    player setplayerdata("cp", "CPSession", "timeSurvivedLastMatch", _id_96ED04D8C80C6220);
    _id_C6CCC4B27ADEBE5B = player getclientomnvar("ui_aar_is_personal_best");
    player setplayerdata("cp", "CPSession", "isPersonalBestLastMatch", _id_C6CCC4B27ADEBE5B);
    player setclientomnvar("ui_aar_is_personal_best", 0);
  }

  setomnvar("zm_time_survived", 0);
  setomnvar("ui_so_stars_given", -1);
  setomnvar("ui_so_next_score", 0);
  setomnvar("ui_so_iwbest", 0);
}
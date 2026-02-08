/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\ber3b.csc
**************************************/

#include clientscripts\_utility;

main() {
  clientscripts\_load::main();

  clientscripts\ber3b_fx::main();
  thread clientscripts\_audio::audio_init(0);

  thread clientscripts\ber3b_amb::main();

  clientscripts\_vehicle::build_treadfx("il2");

  thread diary_reading();

  thread waitforclient(0);
}

diary_reading() {
  level waittill("diaryreading_start");

  level.readingDiary = true;

  player = GetLocalPlayers()[0];

  soundAlias = "diary_neutral";
  alignment = clientscripts\_russian_diary::diary_award_think();

  if(alignment == level.diary_outcome_good) {
    soundAlias = "diary_merciful";
  } else if(alignment == level.diary_outcome_evil) {
    soundAlias = "diary_merciless";
  }

  level.diaryID = playSound(0, soundAlias, player.origin);
  level.pagesID = playSound(0, "pages", player.origin);
  thread diary_reading_skip();

  while(SoundPlaying(level.diaryID) && level.readingDiary) {
    wait(0.1);
  }

  if(SoundPlaying(level.diaryID)) {
    fadeOutAndStopSound(level.diaryID, 0.25);
    fadeOutAndStopSound(level.pagesID, 0.25);
  }

  level notify("diary_reading_stop");
}

diary_reading_skip() {
  level endon("diary_reading_stop");

  level waittill("diary_skip");

  level.readingDiary = false;
}

fadeOutAndStopSound(id, time) {
  rate = 0;

  if(time != 0) {
    rate = 1.0 / time;
  }

  SetSoundVolumeRate(id, rate);
  SetSoundVolume(id, 0.0);

  while(GetSoundVolume(id) > .0001) {
    wait(0.1);
  }

  StopSound(id);
}
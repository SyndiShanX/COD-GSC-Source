/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\frontend_amb.csc
******************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_audio;

main() {
  declareambientroom("frontend", 1);
  setambientroomreverb("frontend", "black_bridge_room", 1, 1);
  setambientroomcontext("frontend", "ringoff_plr", "indoor");
  setambientroomtone("frontend", "amb_frontend_bg", 1, 1);
  declareambientpackage("frontend");
  declareambientroom("frontend_briefing_room");
  setambientroomreverb("frontend_briefing_room", "black_bridge_room", 1, 1);
  setambientroomcontext("frontend_briefing_room", "ringoff_plr", "indoor");
  setambientroomtone("frontend_briefing_room", "amb_bg_briefing_room", 1, 1);
  declareambientpackage("frontend_briefing_room");
  declareambientroom("frontend_osprey");
  setambientroomreverb("frontend_osprey", "black_bridge_room", 1, 1);
  setambientroomcontext("frontend_osprey", "ringoff_plr", "indoor");
  setambientroomtone("frontend_osprey", "amb_bg_osprey_internal", 1, 1);
  declareambientpackage("frontend_osprey");
  declaremusicstate("FRONT_END_START");
  musicaliasloop("mus_fe_start", 2, 4);
  declaremusicstate("FRONT_END_MAIN");
  musicaliasloop("mus_fe_main", 2, 4);
  declaremusicstate("MUS_FE_STRIKEFORCE");
  musicaliasloop("null", 4, 2);
  declaremusicstate("CREDITS");
  musicaliasloop("mus_fe_credits", 0, 2);
  declaremusicstate("FRONT_END_NO_MUSIC");
  musicaliasloop("null", 0, 0);
  level thread menu_snapshot_sets();
}

menu_snapshot_sets() {
  level thread menu_snapshot_noamb();
  level thread menu_snapshot_amb();
}

menu_snapshot_noamb() {
  while(true) {
    level waittill("sndNOAMB");
    snd_set_snapshot("spl_frontend_amb_mute");
  }
}

menu_snapshot_amb() {
  while(true) {
    level waittill("sndAMB");
    snd_set_snapshot("default");
  }
}

sndcreditsmusic(num, section) {
  level.credits_track = [];
  level.credits_track[1] = [];
  level.credits_track[2] = [];
  level.credits_trackid = undefined;

  switch (num) {
    case 0:
      level.credits_track[1][0] = "mus_fe_credits_ninoprecioso";
      level.credits_track[1][1] = "mus_fe_credits_fillthegap";
      level.credits_track[2][0] = "mus_fe_credits_reznor";
      level.credits_track[2][1] = "mus_fe_credits_skrillex";
      level.credits_track[2][2] = "mus_fe_credits_evacuate";
      level.credits_track[2][3] = "mus_fe_credits_pakistan_end";
      break;
    case 1:
      level.credits_track[1][0] = "mus_fe_credits_reunite";
      level.credits_track[1][1] = "mus_fe_credits_fillthegap";
      level.credits_track[2][0] = "mus_fe_credits_skrillex";
      level.credits_track[2][1] = "mus_fe_credits_evacuate";
      level.credits_track[2][2] = "mus_fe_credits_socotra";
      level.credits_track[2][3] = "mus_fe_credits_jeepevac";
      level.credits_track[2][4] = "mus_fe_credits_pakistan_end";
      break;
    case 2:
      level.credits_track[1][0] = "mus_fe_credits_menendez";
      level.credits_track[1][1] = "mus_fe_credits_fillthegap";
      level.credits_track[2][0] = "mus_fe_credits_skrillex";
      level.credits_track[2][1] = "mus_fe_credits_evacuate";
      level.credits_track[2][2] = "mus_fe_credits_socotra";
      level.credits_track[2][3] = "mus_fe_credits_jeepevac";
      level.credits_track[2][4] = "mus_fe_credits_pakistan_end";
      break;
  }

  level thread sndplaycreditsmusic(section);
}

sndplaycreditsmusic(section) {
  level endon("stopCreditsMusic");

  for(i = 0; i < level.credits_track[section].size; i++) {
    level.credits_trackid = playsound(0, level.credits_track[section][i], (0, 0, 0));

    while(soundplaying(level.credits_trackid))
      wait 0.1;
  }
}

sndstopcreditsmusic() {
  level notify("stopCreditsMusic");
  level thread clientscripts\_music::fadeoutandstopsound(level.credits_trackid, 4);
}
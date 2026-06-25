/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber2_amb.gsc
**************************************/

#include maps\_utility;
#include maps\_ambientpackage;
#include maps\_music;
#include common_scripts\utility;

main() {
  /
  level thread play_arty_sound();
  level thread play_metro_arty_sound();
  level thread play_metro_rats_sound();
  level thread play_wave_arty_sound();
  level thread play_rumble_sound();
  level thread play_wave_sound();
  level thread play_tinnitus();

  level thread destructible_speakers_init();
}

/
play_tinnitus() {
  level waittill("tinnitus");
  tinnitus = getEnt("2d_origin", "targetname");
  cough_player = getEnt("rats_2d", "targetname");
  wait 2;
  tinnitus playLoopSound("player_explosion_loop", 3);
  wait 3.5;
  tinnitus stoploopsound(2);
  cough_player playSound("cough_player_self");
}
play_arty_sound() {
  level endon("subway_gate_opened");

  while(1) {
    level waittill("ber2_earthquake");
    ber2_earthquake = getEnt("2d_origin", "targetname");
    ber2_earthquake playSound("art_int");
  }
}
play_metro_arty_sound() {
  level endon("subway_exitgate_startDefenders");

  while(1) {
    level waittill("metro_arty");
    metro_arty = getEnt("2d_origin", "targetname");
    metro_arty playSound("metro_arty");
  }
}
play_metro_rats_sound() {
  level endon("wave_finished");

  while(1) {
    level waittill("start_rats");
    start_rats = getEnt("rats_2d", "targetname");
    start_rats playSound("rats");
  }
}
play_wave_arty_sound() {
  level endon("wave_finished");

  while(1) {
    level waittill("wave_arty");
    wave_arty = getEnt("2d_origin", "targetname");
    wave_arty playSound("wave_arty");
  }
}
play_rumble_sound() {
  level endon("wave_finished");

  while(1) {
    level waittill("rumble");
    rumble = getEnt("rumble_2d", "targetname");
    rattle1 = getEnt("rattle1", "targetname");
    rattle2 = getEnt("rattle2", "targetname");

    rumble playLoopSound("rumble", 1);

    wait 7;

    rattle1 playSound("rattle1");
    rattle2 playSound("rattle2");

    level waittill("stop_wave_sound");
    rumble stoploopsound(.2);
  }
}
play_wave_sound() {
  level waittill("subway_exitgate_startRunners");

  subway_exitgate_startRunners = getEnt("smodel_metrowave", "targetname");
  wave_impact = getEnt("wave_impact", "targetname");
  underwater_loop1 = getEnt("underwater_loop1", "targetname");
  underwater_loop2 = getEnt("underwater_loop2", "targetname");
  underwater_scream1 = getEnt("underwater_scream1", "targetname");
  underwater_scream2 = getEnt("underwater_scream2", "targetname");
  slow_shatter = getEnt("slow_shatter", "targetname");

  subway_exitgate_startRunners playLoopSound("wave");

  level waittill("slow_shatter");

  slow_shatter playSound("slow_shatterL");
  slow_shatter playSound("slow_shatterLrev");
  slow_shatter playSound("dewww");

  level waittill("stop_wave_sound");

  subway_exitgate_startRunners stoploopsound(.1);
  wave_impact playSound("wave_impactF");
  underwater_loop1 playLoopSound("under_waterF", 1);
  underwater_loop2 playLoopSound("under_waterR", 1);

  wave_impact playSound("water_passF");

  level waittill("water_scream");

  underwater_scream1 playSound("water_scream1");

  level waittill("water_scream");

  underwater_scream2 playSound("water_scream3");

  level waittill("loops_stop");

  underwater_loop1 stoploopsound(5);
  underwater_loop2 stoploopsound(5);
}
state_timer(time, state_name) {
  wait(time);
  setmusicstate(state_name);
}
destructible_speakers_init() {
  flag_wait("all_players_connected");

  speakers = getEntArray("destructible_speaker", "targetname");

  for(i = 0; i < speakers.size; i++) {
    if(!isDefined(speakers[i].script_noteworthy)) {
      ASSERTMSG("Destructible speaker at origin " + speakers[i].origin + " must have script_noteworthy set to the soundalias you want it to loop.");
    }

    level thread destructible_speaker(speakers[i]);
  }
}

destructible_speaker(speaker) {
  alias = speaker.script_noteworthy;
  speakerDmg = maps\ber2_util::getent_safe(speaker.target, "targetname");

  speakerDmg Hide();
  speaker playLoopSound(alias);
  speaker setCanDamage(true);

  while(1) {
    speaker waittill("damage", dmg, attacker, direction_vec, point, type);

    if(isPlayer(attacker)) {
      if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
        break;
      }
    }
  }

  speakerDmg Show();
  speakerDmg playSound("speaker_break");
  playFX(level._effect["wire_sparks"], speakerDmg.origin);

  speaker Delete();

  if(arcademode()) {
    arcademode_assignpoints("arcademode_score_generic500", attacker);
  }
}
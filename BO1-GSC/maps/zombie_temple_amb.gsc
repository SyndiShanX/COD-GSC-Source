/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_amb.gsc
**************************************/

#include maps\_ambientpackage;
#include common_scripts\utility;
#include maps\_utility;

main() {
  level._audio_custom_weapon_check = ::weapon_type_check_custom;
  level._custom_intro_vox = ::intro_vox_or_skit;
  level._audio_alias_override = ::audio_alias_override;
  level thread setup_music_egg();
  level thread visual_trigger_vox("location_maze");
  level thread visual_trigger_vox("location_waterfall");
  level thread visual_trigger_vox("mine_see");
  level thread endgame_vox();
}

audio_alias_override() {
  level.plr_vox["kill"]["explosive"] = "kill_explosive";
  level.plr_vox["kill"]["explosive_response"] = undefined;
}

endgame_vox() {
  level waittill("end_game");
  wait(2);
  winner = undefined;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i]._has_anti115) && players[i]._has_anti115 == true) {
      winner = players[i];
      break;
    }
  }
  if(isDefined(winner)) {
    num = winner getEntityNumber();
    if(isDefined(winner.zm_random_char)) {
      num = winner.zm_random_char;
    }
    if(num == 3) {
      playsoundatposition("vox_plr_3_gameover_1", (0, 0, 0));
    } else {
      playsoundatposition("vox_plr_3_gameover_0", (0, 0, 0));
    }
  }
}

weapon_type_check_custom(weapon) {
  if(!isDefined(self.entity_num))
    return "crappy";
  switch (self.entity_num) {
    case 0:
      if(weapon == "m16_zm")
        return "favorite";
      else if(weapon == "m16_gl_upgraded_zm")
        return "favorite_upgrade";
      break;
    case 1:
      if(weapon == "fnfal_zm")
        return "favorite";
      else if(weapon == "hk21_upgraded_zm")
        return "favorite_upgrade";
      break;
    case 2:
      if(weapon == "ak74u_zm")
        return "favorite";
      else if(weapon == "m14_upgraded_zm")
        return "favorite_upgrade";
      break;
    case 3:
      if(weapon == "spectre_zm")
        return "favorite";
      else if(weapon == "g11_lps_upgraded_zm")
        return "favorite_upgrade";
      break;
  }
  if(IsSubStr(weapon, "upgraded"))
    return "upgrade";
  else
    return level.zombie_weapons[weapon].vox;
}

setup_music_egg() {
  wait(3);
  level.meteor_counter = 0;
  level.music_override = false;
  array_thread(getstructarray("mus_easteregg", "targetname"), ::music_egg);
}

music_egg() {
  if(!isDefined(self)) {
    return;
  }
  temp_ent = spawn("script_origin", self.origin);
  temp_ent playLoopSound("zmb_meteor_loop");
  player = self music_egg_wait();
  temp_ent stopLoopSound(1);
  player PlaySound("zmb_meteor_activate");
  player maps\_zombiemode_audio::create_and_play_dialog("eggs", "meteors", undefined, level.meteor_counter);
  level.meteor_counter = level.meteor_counter + 1;
  if(level.meteor_counter == 3) {
    level thread play_music_egg(player);
  }
  wait(1.5);
  temp_ent Delete();
}

music_egg_wait() {
  music_egg_trig = spawn("trigger_radius", self.origin - (0, 0, 200), 0, 50, 400);
  music_egg_trig.completed = false;
  while(1) {
    music_egg_trig waittill("trigger", who);
    while(who IsTouching(music_egg_trig)) {
      if(who UseButtonPressed()) {
        music_egg_trig.completed = true;
        break;
      }
      wait(.05);
    }
    if(music_egg_trig.completed == true) {
      break;
    }
  }
  music_egg_trig Delete();
  return who;
}

play_music_egg(player) {
  level.music_override = true;
  level thread maps\_zombiemode_audio::change_zombie_music("egg");
  wait(4);
  if(isDefined(player)) {
    player maps\_zombiemode_audio::create_and_play_dialog("eggs", "music_activate");
  }
  wait(360);
  level.music_override = false;
  if(level.music_round_override == false)
    level thread maps\_zombiemode_audio::change_zombie_music("wave_loop");
}

intro_vox_or_skit() {
  playsoundatposition("evt_warp_in", (0, 0, 0));
  wait(3);
  players = get_players();
  if(players.size == 4 && randomintrange(0, 101) <= 10) {
    if(randomintrange(0, 101) <= 10 && maps\_zombiemode::is_sidequest_previously_completed("COTD")) {
      players[randomintrange(0, players.size)] thread maps\_zombiemode_audio::create_and_play_dialog("eggs", "rod");
    } else {
      num = randomintrange(0, 2);
      level thread maps\zombie_temple_sq_skits::start_skit("start" + num, players);
    }
  } else {
    players[randomintrange(0, players.size)] thread maps\_zombiemode_audio::create_and_play_dialog("general", "start");
  }
}

visual_trigger_vox(place) {
  wait(3);
  struct = getstruct("vox_" + place, "targetname");
  if(!isDefined(struct)) {
    return;
  }
  vox_trig = spawn("trigger_radius", struct.origin - (0, 0, 100), 0, 250, 200);
  while(1) {
    vox_trig waittill("trigger", who);
    if(isPlayer(who)) {
      who thread maps\_zombiemode_audio::create_and_play_dialog("general", place);
      if(place == "location_maze") {
        wait(90);
      } else {
        break;
      }
    }
  }
  vox_trig delete();
}
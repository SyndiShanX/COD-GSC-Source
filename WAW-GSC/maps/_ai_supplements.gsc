/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ai_supplements.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

is_valid_spawner(spawner, type) {
  if(isDefined(spawner) && isDefined(spawner.tosser)) {
    spawnerType = spawner.tosser;
    if(spawnerType == "banzai") {
      if(type == spawnerType) {
        return true;
      }
    } else if(spawnerType == "grenadesuicide") {
      if(type == spawnerType) {
        return true;
      }
    } else if(spawnerType == "standard") {
      if(type == spawnerType) {
        return true;
      }
    } else {
      return true;
    }
  }
  return false;
}

ai_supplements_think() {
  level waittill("first_player_ready");

  for(;;) {
    wait 1;

    type = need_more_enemies();
    if(!isDefined(type)) {
      continue;
    }

    wait 0.05;
    aiarray = GetAIArray("axis");

    if(level.ais_possesion_mode == 1 && type != "standard") {
      for(i = 0; i < aiarray.size; i++) {
        if(ok_to_possess(aiarray[i])) {
          aiarray[i] thread ai_supplement_tracker(type, 1);
          break;
        }
        wait 0.05;
      }
      continue;
    }

    if(aiarray.size < 3) {
      continue;
    }

    enemy_origins = [];
    for(i = 0; i < aiarray.size; i++) {
      if(!isDefined(aiarray[i].ai_supplement_type)) {
        enemy_origins[enemy_origins.size] = aiarray[i].origin;
      }
    }

    if(enemy_origins.size < 3) {
      continue;
    }

    spawners = getspawnerarray();
    best_spawner_score = 0;
    best_spawner = undefined;

    for(i = 0; i < spawners.size; i++) {
      spawner = spawners[i];
      if(is_valid_spawner(spawner, type)) {
        score = score_spawner(spawner, type, enemy_origins);

        if(score > best_spawner_score) {
          best_spawner_score = score;
          best_spawner = spawner;
        }
      }
    }

    if(isDefined(best_spawner)) {
      best_spawner spawn_ai_supplement(type);

      wait 1;
    }
  }
}

display_ai_supplements_menu() {
  if(getdebugdvar("debug_ai_supplement") == "") {
    setDvar("debug_ai_supplement", "0");
  }

  for(;;) {
    if(getdvarInt("debug_ai_supplement")) {
      wait .5;
      setDvar("debug_ai_supplement", 0);
      setsaveddvar("hud_drawhud", 1);
      display_ai_supplements();
    }
    wait(0.05);
  }
}

add_to_max_aisupplements(type, settings_index, incr) {
  if(type == 0) {
    level.ai_supplements_settings[settings_index].extra_standard_min += incr;
    if(level.ai_supplements_settings[settings_index].extra_standard_min < 0) {
      level.ai_supplements_settings[settings_index].extra_standard_min = 0;
    }
  } else if(type == 1) {
    level.ai_supplements_settings[settings_index].extra_banzai_min += incr;
    if(level.ai_supplements_settings[settings_index].extra_banzai_min < 0) {
      level.ai_supplements_settings[settings_index].extra_banzai_min = 0;
    }
  } else if(type == 2) {
    level.ai_supplements_settings[settings_index].extra_grenadesuicide_min += incr;
    if(level.ai_supplements_settings[settings_index].extra_grenadesuicide_min < 0) {
      level.ai_supplements_settings[settings_index].extra_grenadesuicide_min = 0;
    }
  } else if(type == 3) {
    level.extra_standard_queue += incr;
    if(level.extra_standard_queue < 0) {
      level.extra_standard_queue = 0;
    }
  } else if(type == 4) {
    level.extra_banzai_queue += incr;
    if(level.extra_banzai_queue < 0) {
      level.extra_banzai_queue = 0;
    }
  } else if(type == 5) {
    level.extra_grenadesuicide_queue += incr;
    if(level.extra_grenadesuicide_queue < 0) {
      level.extra_grenadesuicide_queue = 0;
    }
  } else if(type == 6) {
    if(level.ais_possesion_mode == 0) {
      level.ais_possesion_mode = 1;
    } else {
      level.ais_possesion_mode = 0;
    }
  }
}

create_ais_hudelem(message, index) {
  hudelem = newHudElem();
  hudelem.alignX = "left";
  hudelem.alignY = "middle";
  hudelem.x = 0;
  hudelem.y = 83 + index * 18;
  hudelem.label = message;
  hudelem.alpha = 0;
  hudelem.color = (0.7, 0.7, 0.7);

  hudelem.fontScale = 1.7;
  hudelem fadeOverTime(0.5);
  hudelem.alpha = 1;
  return hudelem;
}

display_ai_supplements() {
    title = create_ais_hudelem("AI Supplementals", 0);

    elems = [];
    elems[0] = create_ais_hudelem("", 1);
    elems[1] = create_ais_hudelem("", 2);
    elems[2] = create_ais_hudelem("", 3);
    elems[3] = create_ais_hudelem("", 4);
    elems[4] = create_ais_hudelem("", 5);
    elems[5] = create_ais_hudelem("", 6);
    elems[6] = create_ais_hudelem("", 7);
    elems[7] = create_ais_hudelem("Exit Menu", 8);

    selected = 0;

    up_pressed = false;
    down_pressed = false;
    right_pressed = false;
    left_pressed = false;

    for(;;) {
      players = get_players();
      if(isDefined(players)) {
        settings_index = players.size - 1;
      } else {
        settings_index = 0;
      }

      for(i = 0; i < 8; i++) {
        elems[i].color = (0.7, 0.7, 0.7);
      }
      elems[0].label = "Min Standard: " + level.ai_supplements_settings[settings_index].extra_standard_min + "Cur: " + level.extra_standard_current;
      elems[1].label = "Min BanzaiCh: " + level.ai_supplements_settings[settings_index].extra_banzai_min + "Cur: " + level.extra_banzai_current;
      elems[2].label = "Min GrenSuic: " + level.ai_supplements_settings[settings_index].extra_grenadesuicide_min + "Cur: " + level.extra_grenadesuicide_current;
      elems[3].label = "Queue Standard: " + level.extra_standard_queue;
      elems[4].label = "Queue BanzaiCh: " + level.extra_banzai_queue;
      elems[5].label = "Queue GrenSuic: " + level.extra_grenadesuicide_queue;
      elems[6].label = "Possesion: " + level.ais_possesion_mode;

      elems[selected].color = (1, 1, 0);

      if(!up_pressed) {
        if(players[0] buttonPressed("UPARROW") || players[0] buttonPressed("DPAD_UP")) {
          up_pressed = true;
          selected--;
        }
      } else {
        if(!players[0] buttonPressed("UPARROW") && !players[0] buttonPressed("DPAD_UP")) {
          up_pressed = false;
        }
      }
      if(!down_pressed) {
        if(players[0] buttonPressed("DOWNARROW") || players[0] buttonPressed("DPAD_DOWN")) {
          down_pressed = true;
          selected++;
        }
      } else {
        if(!players[0] buttonPressed("DOWNARROW") && !players[0] buttonPressed("DPAD_DOWN")) {
          down_pressed = false;
        }
      }
      if(!left_pressed) {
        if(players[0] buttonPressed("LEFTARROW") || players[0] buttonPressed("DPAD_LEFT")) {
          left_pressed = true;
          add_to_max_aisupplements(selected, settings_index, -1);
        }
      } else {
        if(!players[0] buttonPressed("LEFTARROW") && !players[0] buttonPressed("DPAD_LEFT")) {
          left_pressed = false;
        }
      }
      if(!right_pressed) {
        if(players[0] buttonPressed("RIGHTARROW") || players[0] buttonPressed("DPAD_RIGHT")) {
          right_pressed = true;
          add_to_max_aisupplements(selected, settings_index, 1);
        }
      } else {
        if(!players[0] buttonPressed("RIGHTARROW") && !players[0] buttonPressed("DPAD_RIGHT")) {
          right_pressed = false;
        }
      }

      if(players[0] buttonPressed("kp_enter") || players[0] buttonPressed("BUTTON_A") || players[0] buttonPressed("enter")) {
        if(selected == 7) {
          title destroy();
          for(i = 0; i < elems.size; i++) {
            elems[i] destroy();
          }
          break;
        }
      }

      if(selected < 0) {
        selected = 7;
      } else if(selected > 7) {
        selected = 0;
      }
      wait(0.05);
    }
  }
  */
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dds.gsc
**************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include maps\_utility;

dds_init() {
  level.dds = spawnStruct();
  level.dds.heartbeat = 0.25;
  level.dds.variant_limit = 18;
  level.dds.category_backoff_limit = 6;
  level.dds.scripted_line_delay = 2;
  level.dds.response_distance_min = 500;
  level.dds.history = [];
  level.dds.history_count = 15;
  level.dds.history_index = 0;
  level.dds.player_character_name = "mas";
  level.dds.event_override_name = undefined;
  level.dds.event_override_probability = .5;
  level.dds.response_wait = 0.25;
  level.dds.response_wait_axis = 0.25;
  init_dds_countryIDs();
  init_dds_flags();
  init_dds_categories();
  init_dds_categories_axis();
  init_dds_active_events();
}

init_dds_countryIDs(voice, dds_label) {
  level.dds.characterID_count = 0;
  level.dds.character_names = [];
  level.dds.character_names["allies"] = array("american", "russian", "russian_english");
  level.dds.character_names["axis"] = array("russian", "vietnamese", "cuban", "british", "german");
  level.dds.character_names["default"] = array_combine(level.dds.character_names["allies"], level.dds.character_names["axis"]);
  level.dds.countryIDs = [];
  add_dds_countryID("american", "us", 5);
  add_dds_countryID("russian", "ru", 4);
  add_dds_countryID("vietnamese", "vc", 4);
  add_dds_countryID("cuban", "cb", 4);
  add_dds_countryID("german", "ge", 3);
  add_dds_countryID("british", "br", 2);
  add_dds_countryID("russian_english", "rn", 3);
}

add_dds_countryID(voice, dds_label, max_voices) {
  level.dds.countryIDs[voice] = spawnStruct();
  level.dds.countryIDs[voice].label = dds_label;
  level.dds.countryIDs[voice].count = 0;
  level.dds.countryIDs[voice].max_voices = max_voices;
}

init_dds_flags() {
  flag_init("dds_running_allies");
  level thread dds_send_team_notify_on_disable("allies");
  flag_init("dds_running_axis");
  level thread dds_send_team_notify_on_disable("axis");
}

init_dds_categories() {
  level.dds.categories = [];
  add_dds_category("low_health", "health_low", 1.0, "", true, ::dds_sort_ent_dist, ::get_nearest_not_plr, 5000, 8, 1, true);
  add_dds_category("react_grenade", "react_grenade", 1.25, "grenade_rspns", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .8, 0.5, false);
  add_dds_category("thrt", "thrt", 3, "thrt_rspns", true, ::dds_sort_ent_dist, ::get_nearest_not_plr, 5000, .75, 2, true);
  add_dds_category("thrt_rspns", "rspns_lm", 3, "", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .7, 0.5, true);
  add_dds_category("multikill", "multkill", 1.5, "kill_rspns", true, ::dds_sort_ent_dist, ::get_nearest_not_plr, 5000, 1, 0.5, true);
  add_dds_category("fragout", "act_fragout", 0.5, "action_rspns", true, ::dds_sort_ent_dist, ::get_self_ent, 5000, .8, 0.5, true);
  add_dds_category("kill_confirm", "killfirm", 2, "kill_rspns", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .3, 0.5, true);
  add_dds_category("kill_rspns", "rspns_killfirm", 2, "", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .7, 0, true);
  add_dds_category("action_rspns", "rspns_act", 3, "", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .6, 0.5, true);
  add_dds_category("casualty", "casualty", .75, "", true, ::dds_sort_ent_dist, ::get_nearest_not_plr, 800, .9, 1, true);
  add_dds_category("reload", "act_reload", 2, "action_rspns", true, ::dds_sort_ent_dist, ::get_self_ent, 5000, .2, 0.5, false);
  add_dds_category("smokeout", "act_smokeout", 1.25, "action_rspns", true, ::dds_sort_ent_dist, ::get_self_ent, 5000, 1, 1, true);
  add_dds_category("headshot", "hs", .75, "kill_rspns", true, ::dds_sort_ent_dist, ::get_attacker, 1000, 1, 1, true);
  add_dds_category("friendly_fire", "frndly_fire", 1.25, "", true, ::dds_sort_ent_dist, ::get_self_ent, 5000, .9, 1, true);
  add_dds_category("civ_fire", "frndly_fire", 1, "", true, ::dds_sort_ent_dist, ::get_nearest_not_plr, 5000, .9, 1, true);
  add_dds_category("kill_melee", "kill_melee", .75, "", true, ::dds_sort_ent_dist, ::get_attacker, 400, 1, 0.5, false);
}

init_dds_categories_axis() {
  level.dds.categories_axis = [];
  add_dds_category_axis("react_grenade", "react_grenade", 1, "grenade_rspns", true, ::dds_sort_ent_dist, ::get_nearest, 5000, 1, 0.5);
  add_dds_category_axis("fragout", "act_fragout", .5, "action_rspns", true, ::dds_sort_ent_dist, ::get_self_ent, 5000, .7, 2);
  add_dds_category_axis("kill_confirm", "killfirm", 1, "kill_rspns", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .9, 0.5);
  add_dds_category_axis("kill_rspns", "rspns_killfirm", 1, "", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .7, 0.5);
  add_dds_category_axis("thrt", "rspns_lm", 2, "thrt_rspns", true, ::dds_sort_ent_dist, ::get_nearest, 5000, 1, 0.5);
  add_dds_category_axis("thrt_rspns", "rspns_lm", 2, "", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .9, 0.75);
  add_dds_category_axis("action_rspns", "rspns_act", .75, "", true, ::dds_sort_ent_dist, ::get_nearest, 5000, .8, 1);
  add_dds_category_axis("casualty", "casualty", 1, "", true, ::dds_sort_ent_dist, ::get_nearest_not_plr, 1500, 1, 3);
  add_dds_category_axis("low_health", "health_low", 1, "", true, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3500, 1, 1);
  add_dds_category_axis("reload", "act_reload", .50, "action_rspns", true, ::dds_sort_ent_dist, ::get_self_ent, 2400, .3, 3);
  add_dds_category_axis("smokeout", "act_smokeout", .5, "action_rspns", true, ::dds_sort_ent_dist, ::get_self_ent, 2600, 1, 1);
  add_dds_category_axis("headshot", "hs", .75, "kill_rspns", true, ::dds_sort_ent_dist, ::get_attacker, 2000, .8, 1);
  add_dds_category_axis("kill_melee", "kill_melee", .25, "", true, ::dds_sort_ent_dist, ::get_attacker, 400, 1, 3);
}

add_dds_category(name, alias_name, duration, rspns_cat_name, clear_category_on_action_success, priority_sort, get_talker_func, distance, probability, timeout_reset, should_squelch) {
  new_category = spawnStruct();
  new_category.name = name;
  new_category.alias_name = alias_name;
  new_category.duration = duration;
  new_category.priority_sort = priority_sort;
  new_category.probability = probability;
  new_category.get_talker_func = get_talker_func;
  new_category.speaker_distance = distance;
  new_category.last_time = GetTime();
  new_category.backoff_count = 0;
  new_category.timeout = randomInt(10);
  new_category.last_timeout = new_category.timeout;
  new_category.timeout_reset = timeout_reset;
  new_category.rspns_cat_name = rspns_cat_name;
  new_category.clear_on_action_success = clear_category_on_action_success;
  new_category.should_squelch = should_squelch;
  level.dds.categories[level.dds.categories.size] = new_category;
}

add_dds_category_axis(name, alias_name, duration, rspns_cat_name, clear_category_on_action_success, priority_sort, get_talker_func, distance, probability, timeout_reset) {
  new_category_axis = spawnStruct();
  new_category_axis.name = name;
  new_category_axis.alias_name = alias_name;
  new_category_axis.duration = duration;
  new_category_axis.priority_sort = priority_sort;
  new_category_axis.probability = probability;
  new_category_axis.get_talker_func = get_talker_func;
  new_category_axis.speaker_distance = distance;
  new_category_axis.last_time = GetTime();
  new_category_axis.backoff_count = 0;
  new_category_axis.timeout = randomInt(10);
  new_category_axis.last_timeout = new_category_axis.timeout;
  new_category_axis.timeout_reset = timeout_reset;
  new_category_axis.rspns_cat_name = rspns_cat_name;
  new_category_axis.clear_on_action_success = clear_category_on_action_success;
  level.dds.categories_axis[level.dds.categories_axis.size] = new_category_axis;
}

init_dds_active_events() {
  level.dds.active_events = [];
  level.dds.active_events_axis = [];
  for(i = 0; i < level.dds.categories.size; i++) {
    level.dds.active_events[level.dds.categories[i].name] = [];
  }
  for(i = 0; i < level.dds.categories_axis.size; i++) {
    level.dds.active_events_axis[level.dds.categories_axis[i].name] = [];
  }
}

dds_clear_old_expired_events() {
  for(i = 0; i < level.dds.categories.size; i++) {
    category = level.dds.categories[i];
    for(j = 0; j < level.dds.active_events[category.name].size; j++) {
      level.dds.active_events[category.name][j].duration -= level.dds.heartbeat;
      if(level.dds.active_events[category.name][j].duration <= 0 ||
        level.dds.active_events[category.name][j].clear_event_on_prob) {
        level.dds.active_events[category.name] = array_remove(level.dds.active_events[category.name], level.dds.active_events[category.name][j]);
      }
    }
  }
}

dds_clear_old_expired_events_axis() {
  for(i = 0; i < level.dds.categories_axis.size; i++) {
    category = level.dds.categories_axis[i];
    for(j = 0; j < level.dds.active_events_axis[category.name].size; j++) {
      level.dds.active_events_axis[category.name][j].duration -= level.dds.heartbeat;
      if(level.dds.active_events_axis[category.name][j].duration <= 0 ||
        level.dds.active_events_axis[category.name][j].clear_event_on_prob) {
        level.dds.active_events_axis[category.name] = array_remove(level.dds.active_events_axis[category.name], level.dds.active_events_axis[category.name][j]);
      }
    }
  }
}

dds_clear_all_queued_events() {
  for(i = 0; i < level.dds.categories.size; i++) {
    for(j = 0; j < level.dds.active_events[level.dds.categories[i].name].size; j++) {
      level.dds.active_events[level.dds.categories[i].name] = [];
    }
  }
}

dds_clear_all_queued_events_axis() {
  for(i = 0; i < level.dds.categories_axis.size; i++) {
    for(j = 0; j < level.dds.active_events_axis[level.dds.categories_axis[i].name].size; j++) {
      level.dds.active_events_axis[level.dds.categories_axis[i].name] = [];
    }
  }
}

dds_main_process() {
  if(flag("dds_running_allies")) {
    return;
  }
  flag_set("dds_running_allies");
  dds_find_threats("allies", "axis");
  should_delay_dds = false;
  while(flag("dds_running_allies")) {
    dds_clear_old_expired_events();
    if(isDefined(level.NumberOfImportantPeopleTalking) && level.NumberOfImportantPeopleTalking > 0) {
      should_delay_dds = true;
      wait(level.dds.heartbeat);
      continue;
    }
    if(should_delay_dds) {
      wait(level.dds.scripted_line_delay);
      dds_clear_all_queued_events();
      should_delay_dds = false;
    }
    if(!dds_process_active_events()) {
      wait(level.dds.heartbeat);
    } else {
      wait(0.1);
    }
  }
}

dds_main_process_axis() {
  if(flag("dds_running_axis")) {
    return;
  }
  flag_set("dds_running_axis");
  dds_find_threats("axis", "allies");
  should_delay_dds = false;
  while(flag("dds_running_axis")) {
    dds_clear_old_expired_events_axis();
    if(isDefined(level.NumberOfImportantPeopleTalking) && level.NumberOfImportantPeopleTalking > 0) {
      should_delay_dds = true;
      wait(level.dds.heartbeat);
      continue;
    }
    if(should_delay_dds) {
      wait(level.dds.scripted_line_delay);
      dds_clear_all_queued_events_axis();
      should_delay_dds = false;
    }
    if(dds_process_active_events_axis()) {
      wait(level.dds.heartbeat);
    } else {
      wait(0.1);
    }
  }
}

dds_find_threats(us, them) {
  level thread dds_find_infantry_threat(us, them);
}

dds_enable(team) {
  if(!isDefined(team)) {
    level thread dds_main_process();
    level thread dds_main_process_axis();
  } else {
    if(team == "allies") {
      level thread dds_main_process();
    } else if(team == "axis") {
      level thread dds_main_process_axis();
    }
  }
}

dds_disable(team) {
  if(!isDefined(team)) {
    dds_clear_all_queued_events();
    flag_clear("dds_running_allies");
    dds_clear_all_queued_events_axis();
    flag_clear("dds_running_axis");
  } else {
    switch (team) {
      case "axis":
        dds_clear_all_queued_events_axis();
        flag_clear("dds_running_axis");
        break;
      case "allies":
        dds_clear_all_queued_events();
        flag_clear("dds_running_allies");
        break;
      default:
        break;
    }
  }
}

dds_send_team_notify_on_disable(team) {
  while(1) {
    flag_waitopen("dds_running_" + team);
    level notify("dds_running_" + team);
    flag_wait("dds_running_" + team);
  }
}

is_dds_enabled() {
  if(level.createFX_enabled || (!flag("dds_running_allies") && !flag("dds_running_axis"))) {
    return false;
  }
  return true;
}

exponent(base, power) {
  assert(power >= 0);
  if(power == 0) {
    return 1;
  }
  return base * exponent(base, (power - 1));
}

dds_process_active_events() {
  for(i = 0; i < level.dds.categories.size; i++) {
    category = level.dds.categories[i];
    if(category.timeout > 0) {
      category.timeout -= level.dds.heartbeat;
      continue;
    }
    if(level.dds.active_events[category.name].size != 0) {
      level.dds.active_events[category.name] = [
        [category.priority_sort]
      ](level.dds.active_events[category.name]);
      for(j = 0; j < level.dds.active_events[category.name].size; j++) {
        if(randomFloat(1) >= category.probability) {
          level.dds.active_events[category.name][j].clear_event_on_prob = true;
          continue;
        }
        if(level.dds.active_events[category.name][j].processed) {
          continue;
        }
        if(dds_event_activate(level.dds.active_events[category.name][j], category.get_talker_func, category.speaker_distance,
            category.rspns_cat_name, category.should_squelch)) {
          if(!category.timeout_reset) {
            category.timeout = category.timeout_reset;
          } else {
            if((GetTime() - category.last_time) < (category.last_timeout * 1.5 * 1000)) {
              category.backoff_count++;
              if(category.backoff_count > level.dds.category_backoff_limit) {
                category.backoff_count = level.dds.category_backoff_limit;
              }
            } else {
              category.backoff_count--;
              if(category.backoff_count < 0) {
                category.backoff_count = 0;
              }
            }
            category.timeout = category.timeout_reset * (exponent(2, category.backoff_count)) + randomInt(2);
            category.last_timeout = category.timeout;
            category.last_time = GetTime();
          }
          if(category.clear_on_action_success) {
            level.dds.active_events[category.name] = [];
          }
          return true;
        } else {
          wait(level.dds.heartbeat);
        }
      }
    }
  }
  return false;
}

dds_process_active_events_axis() {
  for(i = 0; i < level.dds.categories_axis.size; i++) {
    category = level.dds.categories_axis[i];
    if(category.timeout > 0) {
      category.timeout -= level.dds.heartbeat;
      continue;
    }
    if(level.dds.active_events_axis[category.name].size != 0) {
      level.dds.active_events_axis[category.name] = [
        [category.priority_sort]
      ](level.dds.active_events_axis[category.name]);
      for(j = 0; j < level.dds.active_events_axis[category.name].size; j++) {
        if(randomFloat(1) >= category.probability) {
          level.dds.active_events_axis[category.name][j].clear_event_on_prob = true;
          continue;
        }
        if(level.dds.active_events_axis[category.name][j].processed) {
          continue;
        }
        if(dds_event_activate(level.dds.active_events_axis[category.name][j], category.get_talker_func, category.speaker_distance,
            category.rspns_cat_name, false)) {
          if(!category.timeout_reset) {
            category.timeout = category.timeout_reset;
          } else {
            if((GetTime() - category.last_time) < (category.last_timeout * 1.5 * 1000)) {
              category.backoff_count++;
              if(category.backoff_count > level.dds.category_backoff_limit) {
                category.backoff_count = level.dds.category_backoff_limit;
              }
            } else {
              category.backoff_count--;
              if(category.backoff_count < 0) {
                category.backoff_count = 0;
              }
            }
            category.timeout = category.timeout_reset * (exponent(2, category.backoff_count)) + randomInt(2);
            category.last_timeout = category.timeout;
            category.last_time = GetTime();
          }
          if(category.clear_on_action_success) {
            level.dds.active_events_axis[category.name] = [];
          }
          return true;
        } else {
          wait(level.dds.heartbeat);
        }
      }
    }
  }
  return false;
}

dds_event_activate(event, get_talker_func, distance, rspns_cat_name, should_squelch) {
  if(!isDefined(event)) {
    return false;
  }
  category_name = event.category_name;
  if(isDefined(event.category_response_name)) {
    category_name = event.category_response_name;
  }
  talker = event[[get_talker_func]](isDefined(event.category_response_name), distance);
  if(!isDefined(talker) || !isAlive(talker)) {
    event.processed = true;
    return false;
  }
  phrase = dds_get_alias_from_event(talker, event.category_alias_name, event.ent);
  if(!isDefined(phrase)) {
    return false;
  }
  if(isDefined(event.category_response_name)) {
    if(event.isAlliesLine) {
      wait(level.dds.response_wait);
    } else {
      wait(level.dds.response_wait_axis);
    }
  }
  if(!getdvarint("snd_dsp_futz")) {
    should_squelch = false;
  }
  if(IsAlive(talker)) {
    if(should_squelch && !IsPlayer(talker) && (talker.voice != "russian_english")) {
      talker animscripts\face::PlayFaceThread(undefined, "dds_squelch_strt", .5, "dds_squelch_strt");
    }
    talker animscripts\face::PlayFaceThread(undefined, phrase, .5, phrase);
  }
  if(should_squelch && !IsPlayer(talker) && IsAlive(talker) && (talker.voice != "russian_english")) {
    talker animscripts\face::PlayFaceThread(undefined, "dds_squelch_end", .5, "dds_squelch_end");
  }
  event.talker = talker;
  event.talker_origin = talker.origin;
  event.phrase = phrase;
  event.processed = true;
  add_phrase_to_history(phrase);
  if(rspns_cat_name != "") {
    dds_notify_response(event, talker, phrase, rspns_cat_name);
  }
  return true;
}

add_phrase_to_history(phrase) {
  level.dds.history[level.dds.history_index] = phrase;
  level.dds.history_index = (level.dds.history_index + 1) % level.dds.history_count;
}

get_nearest_common(response, player_can_say_line, distance) {
  player = get_players()[0];
  if(self.isAlliesLine) {
    ai_array = GetAIArray("allies");
    if(player_can_say_line) {
      ai_array[ai_array.size] = player;
    }
  } else {
    ai_array = GetAIArray("axis");
  }
  if(ai_array.size <= 0) {
    return undefined;
  }
  if(response && isDefined(self.talker)) {
    ai_array = remove_all_actors_with_same_characterID(ai_array, self.talker.dds_characterID);
    closest_ent = get_closest_living(self.talker.origin, ai_array);
  } else {
    closest_ent = get_closest_living(self.ent_origin, ai_array);
  }
  if(!isDefined(closest_ent)) {
    return undefined;
  }
  dis_from_player = distance(player.origin, closest_ent.origin);
  if(dis_from_player > distance) {
    return undefined;
  }
  if(response && (dis_from_player < level.dds.response_distance_min)) {
    return undefined;
  }
  return closest_ent;
}

remove_all_actors_with_same_characterID(ai_array, talker_characterID) {
  for(i = 0; i < ai_array.size;) {
    if(!isDefined(ai_array[i].dds_characterID)) {
      ai_array = array_remove(ai_array, ai_array[i]);
      continue;
    }
    if(ai_array[i].dds_characterID == talker_characterID) {
      ai_array = array_remove(ai_array, ai_array[i]);
      continue;
    }
    i++;
  }
  return ai_array;
}

get_nearest(response, distance) {
  return get_nearest_common(response, true, distance);
}

get_nearest_not_plr(response, distance) {
  return get_nearest_common(response, false, distance);
}

get_attacker(response, distance) {
  if(isDefined(self.ent_attacker) && IsAlive(self.ent_attacker)) {
    if(isDefined(self.ent_team)) {
      if(isDefined(self.ent_attacker.team) && self.ent_team == self.ent_attacker.team) {
        return undefined;
      }
      if(isDefined(self.ent_attacker.vteam) && self.ent_team == self.ent_attacker.vteam) {
        return undefined;
      }
    }
    return self.ent_attacker;
  }
  return undefined;
}

get_self_ent(response, distance) {
  if(isDefined(self.ent) && isAlive(self.ent)) {
    return self.ent;
  }
  return undefined;
}

dds_get_alias_from_event(talker, category_alias_name, event_ent) {
  if(!IsAlive(talker)) {
    return undefined;
  }
  if(!isDefined(talker.dds_characterID)) {
    return undefined;
  }
  alias = "dds_" + talker.dds_characterID + "_" + category_alias_name + "_";
  if(isDefined(event_ent) && category_alias_name == "thrt") {
    qualifier = event_ent get_landmark_qualifier(alias);
    if(isDefined(qualifier)) {
      alias += qualifier + "_";
    }
  }
  variant_num = 0;
  variant_count_array = dds_variant_count_for_alias(alias);
  if(variant_count_array.size > 0) {
    for(i = 0; i < variant_count_array.size; i++) {
      variant_num = random(variant_count_array);
      temp_alias = alias;
      if(variant_num < 10) {
        temp_alias += "0";
      }
      temp_alias += variant_num;
      if(!is_phrase_in_history(temp_alias)) {
        return temp_alias;
      }
    }
  } else {
    return undefined;
  }
  return undefined;
}

is_phrase_in_history(phrase) {
  for(i = 0; i < level.dds.history.size; i++) {
    if(level.dds.history[i] == phrase) {
      return true;
    }
  }
  return false;
}

dds_variant_count_for_alias(alias) {
  variant_count_array = [];
  for(i = 0; i < level.dds.variant_limit; i++) {
    prefix = "";
    if(i < 10) {
      prefix = "0";
    }
    if(SoundExists(alias + prefix + i)) {
      variant_count_array[variant_count_array.size] = i;
    }
  }
  return variant_count_array;
}

get_landmark_qualifier(alias) {
  lm_script_area = undefined;
  lm_script_area_origin = undefined;
  if(!isDefined(self.node)) {
    nodeArray = GetAnyNodeArray(self.origin, 100);
    for(i = 0;
      (i < nodeArray.size && i < 3); i++) {
      if(isDefined(nodeArray[i].script_area)) {
        lm_script_area = nodeArray[i].script_area;
        lm_script_area_origin = nodeArray[i].origin;
        break;
      }
    }
  } else if(isDefined(self.node.script_area)) {
    lm_script_area = self.node.script_area;
    lm_script_area_origin = self.node.origin;
  }
  if(!isDefined(lm_script_area) || !isDefined(lm_script_area_origin)) {
    return undefined;
  }
  if((distance(self.origin, lm_script_area_origin) < 400) && SoundExists(alias + lm_script_area + "_00")) {
    return lm_script_area;
  }
  return undefined;
}

get_event_override(alias) {
  if(isDefined(level.dds.event_override_name) && (randomFloat(1) >= level.dds.event_override_probability) &&
    SoundExists(alias + level.dds.event_override_name + "_00")) {
    return level.dds.event_override_name;
  }
  return undefined;
}

dds_find_infantry_threat(us, them) {
  THRT_INF_NOTIFY_DISTANCE = 4000;
  while(flag("dds_running_" + us)) {
    player = get_players()[0];
    our_team = GetAIArray(us);
    other_team = GetAIArray(them);
    success = false;
    for(i = 0; i < our_team.size; i++) {
      for(j = 0; j < other_team.size; j++) {
        if((other_team.size > 1) && (randomFloat(1) < .5)) {
          if(other_team[j] canSee(our_team[i]) && (distance(other_team[j].origin, our_team[i].origin) < THRT_INF_NOTIFY_DISTANCE) &&
            (distance(other_team[j].origin, player.origin) < THRT_INF_NOTIFY_DISTANCE)) {
            other_team[j] dds_notify("thrt", (them != "allies"));
            success = true;
            break;
          }
        }
      }
      if(success) {
        break;
      }
    }
    wait(2);
  }
}

player_init() {
  if(!IsPlayer(self)) {
    PrintLn("dds::player_init not called on a player; did not set up dds player flags and threads.");
    return;
  }
  self.isKillstreakTimerRunning = false;
  self.killstreakcounter = 0;
  self ent_flag_init("dds_killstreak");
  self ent_flag_init("dds_low_health");
  self thread dds_killstreak_timer();
  self thread dds_watch_player_health();
  self thread dds_multikill_tracker();
  self.dds_characterID = level.dds.player_character_name;
}

dds_multikill_tracker() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    level flag_wait("dds_running_" + self.team);
    self waittill("multikill");
    self dds_notify("multikill", (self.team == "allies"));
  }
}

dds_watch_player_health() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    level flag_wait("dds_running_" + self.team);
    wait(0.5);
    if(self.health < self.maxhealth * 0.4) {
      self dds_notify("low_health", self.team == "allies");
      self ent_flag_set("dds_low_health");
      self thread reset_player_health();
    }
    self ent_flag_waitopen("dds_low_health");
  }
}

reset_player_health() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    if(self.health > self.maxhealth * 0.75) {
      self ent_flag_clear("dds_low_health");
      return;
    }
    wait(1);
  }
}

dds_killstreak_timer() {
  self endon("death");
  self endon("disconnect");
  kills = getDvarIntDefault(#"dds_killstreak_kills", 3);
  time = getDvarIntDefault(#"dds_killstreak_timer", 10);
  while(1) {
    level flag_wait("dds_running_" + self.team);
    self ent_flag_wait("dds_killstreak");
    self.killstreakcounter++;
    if(!self.isKillstreakTimerRunning) {
      self.isKillstreakTimerRunning = true;
      self thread track_kills_over_time(kills, time);
    }
    self ent_flag_clear("dds_killstreak");
  }
}

track_kills_over_time(kills, time) {
  timer = GetTime() + (time * 1000);
  while(GetTime() < timer) {
    if(self.killstreakcounter >= kills) {
      self dds_notify("killstreak", self.team == "allies");
      self.killstreakcounter = 0;
      timer = -1;
    }
    wait(0.1);
  }
  self.killstreakcounter = 0;
  self.isKillstreakTimerRunning = false;
}

dds_ai_init() {
  self dds_get_ai_id();
  self thread dds_watch_grenade_flee();
  self thread dds_watch_friendly_fire();
}

dds_get_ai_id() {
  classname = ToLower(self.classname);
  tokens = StrTok(classname, "_");
  if(tokens.size >= 2) {
    switch (tokens[1]) {
      case "clark":
      case "mason":
      case "carlos":
        return;
      case "barnes":
        self.dds_characterID = "woo";
        return;
      case "lewis":
        self.dds_characterID = "bow";
        return;
      case "reznov":
      case "woods":
      case "bowman":
      case "weaver":
      case "hudson":
        self.dds_characterID = GetSubStr(tokens[1], 0, 3);
        return;
    }
  }
  if(self.team != "neutral") {
    for(i = 0; i < level.dds.character_names[self.team].size; i++) {
      if(self.voice == level.dds.character_names[self.team][i]) {
        self.dds_characterID = level.dds.countryIDs[self.voice].label + (level.dds.countryIDs[self.voice].count % level.dds.countryIDs[self.voice].max_voices);
        level.dds.countryIDs[self.voice].count++;
        return;
      }
    }
  } else {
    return;
  }
  printLn("dds: didn't set this AI with a dds_characterID");
}

dds_watch_grenade_flee() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    self waittill("grenade_flee", weaponName);
    if(weaponName == "frag_grenade_sp") {
      self dds_notify("react_grenade", (self.team == "allies"));
    }
  }
}

dds_watch_friendly_fire() {
  self endon("death");
  self endon("disconnect");
  while(1) {
    self waittill("dds_friendly_fire");
    self dds_notify("friendly_fire", (self.team == "allies"));
  }
}

update_player_damage(eAttacker) {
  if(!is_dds_enabled()) {
    return;
  }
  self.dds_dmg_attacker = eAttacker;
}

update_actor_damage(eAttacker, damage_mod) {
  if(!is_dds_enabled()) {
    return;
  }
  self.dds_dmg_attacker = eAttacker;
  if(IsPlayer(eAttacker)) {
    switch (damage_mod) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_IMPACT":
        return;
    }
    if(self.team == eAttacker.team) {
      self notify("dds_friendly_fire");
    } else if(self.team == "neutral") {
      self dds_notify("civ_fire", (eAttacker.team == "allies"));
    }
  }
}

check_kill_damage(mod, dmg_mod) {
  if(isDefined(self.dds_dmg_attacker) && isDefined(self.dds_dmg_attacker.dds_dmg_attacker)) {
    if(self == self.dds_dmg_attacker.dds_dmg_attacker) {
      return ("kill_dmg_" + dmg_mod);
    }
  }
  return mod;
}

dds_notify_mod(isAlliesLine, category_name) {
  if(!is_dds_enabled()) {
    return;
  }
  if(!isDefined(self.damagemod)) {
    return;
  }
  if(isDefined(self.dds_dmg_attacker) && isDefined(self.team)) {
    if(isDefined(self.dds_dmg_attacker.team) && ((self.dds_dmg_attacker.team == self.team) || (self.team == "neutral"))) {
      return;
    } else if(isDefined(self.dds_dmg_attacker.vteam) && (self.dds_dmg_attacker.vteam == self.team)) {
      return;
    }
  }
  is_bullet_kill = false;
  if(!isDefined(category_name)) {
    switch (self.damagemod) {
      case "MOD_CRUSH":
      case "MOD_TELEFRAG":
      case "MOD_FALLING":
      case "MOD_SUICIDE":
      case "MOD_TRIGGER_HURT":
      case "MOD_BURNED":
      case "MOD_HIT_BY_OBJECT":
      case "MOD_DROWN":
        break;
      case "MOD_UNKNOWN":
      case "MOD_PROJECTILE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_BAYONET":
        break;
      case "MOD_MELEE":
        self dds_notify(check_kill_damage("kill_melee", "melee"), isAlliesLine);
        break;
      case "MOD_EXPLOSIVE":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
        self dds_notify("kill_explo", isAlliesLine);
        break;
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        self dds_notify(check_kill_damage("kill_confirm", "shot"), isAlliesLine);
        is_bullet_kill = true;
        break;
      case "MOD_HEAD_SHOT":
        is_bullet_kill = true;
        break;
      default:
        printLn("^5 MOD: " + self.damagemod + " \n");
        break;
    }
  } else {
    self dds_notify(category_name, isAlliesLine);
    is_bullet_kill = true;
  }
  if(IsPlayer(self.attacker) && is_bullet_kill) {
    self.attacker ent_flag_set("dds_killstreak");
  }
}

dds_notify_casualty() {
  self dds_notify("casualty", (self.team == "allies"));
}

dds_notify_grenade(grenade_name, isAlliesLine, isThrowBack) {
  if(!is_dds_enabled()) {
    return;
  }
  if(!isThrowBack) {
    switch (grenade_name) {
      case "frag_grenade_sp":
        self dds_notify("fragout", isAlliesLine);
        break;
      case "willy_pete_sp":
        self dds_notify("smokeout", isAlliesLine);
        break;
      case "flash_grenade_sp":
      case "m8_white_smoke_sp":
      case "claymore_sp":
      case "molotov_sp":
      case "vc_grenade_sp":
        break;
      default:
        break;
    }
  } else {
    self dds_notify("frag_throwback", isAlliesLine);
  }
}

dds_notify_reload(weaponName, isAlliesLine) {
  if(!isDefined(weaponName)) {
    self dds_notify("reload", isAlliesLine);
    return;
  } else if((self GetCurrentWeaponClipAmmo() > 0)) {
    return;
  }
  switch (weaponName) {
    case "crossbow_sp":
    case "crossbow_vzoom_alt_sp":
    case "crossbow_explosive_alt_sp":
      break;
    default:
      self dds_notify("reload", isAlliesLine);
      break;
  }
}

dds_notify(category_name, isAlliesLine) {
  if(!flag("dds_running_allies") && isAlliesLine) {
    return;
  }
  if(!flag("dds_running_axis") && !isAlliesLine) {
    return;
  }
  if(isAlliesLine && !isDefined(level.dds.active_events[category_name])) {
    return;
  }
  if(!isAlliesLine && !isDefined(level.dds.active_events_axis[category_name])) {
    return;
  }
  assertEx(isDefined(level.dds), "dds not init.");
  assertEx(isDefined(isAlliesLine), "isAlliesLine is not defined.");
  event = spawnStruct();
  event.category_name = category_name;
  event.ent = self;
  event.ent_origin = self.origin;
  event.ent_team = self.team;
  event.clear_event_on_prob = false;
  event.processed = false;
  event.ent_attacker = self.dds_dmg_attacker;
  event.isAlliesLine = isAlliesLine;
  if(!isAlliesLine) {
    dds_category = find_dds_category_by_name(level.dds.categories_axis, category_name);
    if(!isDefined(dds_category)) {
      return;
    }
    event.duration = dds_category.duration;
    event.category_alias_name = dds_category.alias_name;
    level.dds.active_events_axis[category_name][level.dds.active_events_axis[category_name].size] = event;
  } else {
    dds_category = find_dds_category_by_name(level.dds.categories, category_name);
    if(!isDefined(dds_category)) {
      return;
    }
    event.duration = dds_category.duration;
    event.category_alias_name = dds_category.alias_name;
    level.dds.active_events[category_name][level.dds.active_events[category_name].size] = event;
  }
}

dds_notify_response(event, talker, phrase, rspns_cat_name) {
  event.category_response_name = rspns_cat_name;
  event.processed = false;
  if((rspns_cat_name == "grenade_rspns") && isDefined(event.ent) && isDefined(event.ent.grenade) && isDefined(event.ent.grenade.originalowner) &&
    (isDefined(event.ent.grenade.originalowner.team != event.ent_team)))
    return;
  if(!event.isAlliesLine) {
    dds_category = find_dds_category_by_name(level.dds.categories_axis, event.category_response_name);
    if(!isDefined(dds_category)) {
      return;
    }
    event.duration = dds_category.duration;
    event.category_alias_name = dds_category.alias_name;
    level.dds.active_events_axis[event.category_response_name][level.dds.active_events_axis[event.category_response_name].size] = event;
  } else {
    dds_category = find_dds_category_by_name(level.dds.categories, event.category_response_name);
    if(!isDefined(dds_category)) {
      return;
    }
    event.duration = dds_category.duration;
    event.category_alias_name = dds_category.alias_name;
    level.dds.active_events[event.category_response_name][level.dds.active_events[event.category_response_name].size] = event;
  }
}

find_dds_category_by_name(category_array, category_name) {
  for(i = 0; i < category_array.size; i++) {
    if(category_array[i].name == category_name) {
      return category_array[i];
    }
  }
  return undefined;
}

dds_sort_ent_dist(eventArray) {
  player = get_players()[0];
  dist_array = [];
  index_array = [];
  for(i = 0; i < eventArray.size; i++) {
    length = distance(player.origin, eventArray[i].ent_origin);
    dist_array[dist_array.size] = length;
    index_array[index_array.size] = i;
  }
  temp = undefined;
  for(i = 0; i < dist_array.size - 1; i++) {
    if(dist_array[i] <= dist_array[i + 1]) {
      continue;
    }
    temp = dist_array[i];
    dist_array[i] = dist_array[i + 1];
    dist_array[i + 1] = temp;
    temp = index_array[i];
    index_array[i] = index_array[i + 1];
    index_array[i + 1] = temp;
  }
  new_array = [];
  for(i = 0; i < index_array.size; i++) {
    new_array[i] = eventArray[index_array[i]];
  }
  return new_array;
}

dds_sort_ent_duration(eventArray) {
  return eventArray;
}

dds_sort_ent_damage(eventArray) {
  return eventArray;
}

getDvarIntDefault(dvarName, defaultValue) {
  returnVal = defaultValue;
  if(getDvar(dvarName) != "") {
    return getDvarInt(dvarName);
  }
  return returnVal;
}

dds_set_event_override(event_name) {
  level.dds.event_override_name = event_name;
}

dds_clear_event_override() {
  level.dds.event_override_name = undefined;
}

dds_set_event_override_probability(probability_value) {
  if(probability_value < 0 || probability_value > 1) {
    PrintLn(probability_value + " is invalid event override probability. value must be between 0 and 1. resetting to default.");
    dds_reset_event_override_probability();
  } else {
    level.dds.event_override_probability = probability_value;
  }
}

dds_reset_event_override_probability() {
  level.dds.event_override_probability = .5;
}
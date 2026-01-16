/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dds.gsc
**************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include maps\_utility;
#include animscripts\face;
#include animscripts\combat_utility;

dds_init() {
  level.dds = spawnstruct();
  level.dds.heartbeat = 0.25;
  level.dds.max_active_events = 6;
  level.dds.variant_limit = 17;
  level.dds.category_backoff_limit = 2;
  level.dds.scripted_line_delay = 2;
  level.dds.response_distance_min = 500;
  level.dds.history = [];
  level.dds.history_count = 15;
  level.dds.history_index = 0;
  level.dds.player_character_name = "mas";
  level.dds.event_override_name = undefined;
  level.dds.event_override_probability = 0.5;
  level.dds.response_wait = 0.25;
  level.dds.response_wait_axis = 0.25;
  init_dds_countryids();
  init_dds_flags();
  init_dds_categories();
  init_dds_categories_axis();
  init_dds_active_events();

  level.debug_dds_on = getdvar(#"_id_38E629E6");

  if(level.debug_dds_on != "")
    level thread dds_debug();
}

init_dds_countryids(voice, dds_label) {
  level.dds.characterid_count = 0;
  level.dds.character_names = [];
  level.dds.character_names["allies"] = array("american", "russian", "russian_english", "yemeni", "lapd", "secretservice", "unita", "mujahideen", "pdf");
  level.dds.character_names["axis"] = array("digbat", "american", "russian", "unita", "cuban", "mujahideen", "pdf", "pmc", "isi", "terrorist", "chinese");
  level.dds.character_names["default"] = arraycombine(level.dds.character_names["allies"], level.dds.character_names["axis"], 1, 0);
  level.dds.countryids = [];
  add_dds_countryid("american", "us", 2);
  add_dds_countryid("russian", "ru", 2);
  add_dds_countryid("unita", "mp", 2);
  add_dds_countryid("cuban", "pm", 3);
  add_dds_countryid("mujahideen", "mu", 2);
  add_dds_countryid("pdf", "pm", 3);
  add_dds_countryid("pmc", "pm", 3);
  add_dds_countryid("isi", "is", 2);
  add_dds_countryid("digbat", "pm", 3);
  add_dds_countryid("yemeni", "tr", 2);
  add_dds_countryid("terrorist", "tr", 2);
  add_dds_countryid("lapd", "la", 2);
  add_dds_countryid("secretservice", "us", 2);
  add_dds_countryid("chinese", "ch", 2);
}

add_dds_countryid(voice, dds_label, max_voices) {
  level.dds.countryids[voice] = spawnstruct();
  level.dds.countryids[voice].label = dds_label;
  level.dds.countryids[voice].count = 0;
  level.dds.countryids[voice].max_voices = max_voices;
}

init_dds_flags() {
  flag_init("dds_running_allies");
  level thread dds_send_team_notify_on_disable("allies");
  flag_init("dds_running_axis");
  level thread dds_send_team_notify_on_disable("axis");
}

init_dds_categories() {
  level.dds.categories = [];
  add_dds_category("react_grenade", "react_grenade", 1.25, "grenade_rspns", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.8, 1.5, 0);
  add_dds_category("react_emp", "react_emp", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.8, 1.5, 0);
  add_dds_category("react_sniper", "react_sniper", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0);
  add_dds_category("rspns_neg", "rspns_neg", 1.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.05, 4.5, 0);
  add_dds_category("thrt_acquired", "thrt_acquired", 0.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 16.5, 0);
  add_dds_category("kill_confirm", "act_kill_confirm", 2, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.3, 6.5, 0);
  add_dds_category("headshot", "act_kill_confirm", 0.75, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.3, 7, 0);
  add_dds_category("rspns_killfirm", "rspns_killfirm", 0.75, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.3, 7, 0);
  add_dds_category("rspns_movement", "rspns_movement", 0.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.2, 13.5, 0);
  add_dds_category("react_move", "react_move", 0.5, "rspns_movement", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 16.5, 0);
  add_dds_category("fragout", "act_fragout", 0.75, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.8, 1.5, 0);
  add_dds_category("empout", "act_empout", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.7, 1.5, 0);
  add_dds_category("smokeout", "act_smokeout", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.7, 1.5, 0);
  add_dds_category("react_cover", "react_cover", 1.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.1, 4.5, 0);
  add_dds_category("thrt_dist10", "thrt_dist10", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category("thrt_dist20", "thrt_dist20", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category("thrt_dist30", "thrt_dist30", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category("thrt_dist40", "thrt_dist40", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category("thrt_open", "thrt_open", 0.5, "rspns_suppress", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0);
  add_dds_category("thrt_movement", "thrt_movement", 0.5, "thrt_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0);
  add_dds_category("thrt_breaking", "thrt_breaking", 0.5, "rspns_lm", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.1, 7.5, 0);
  add_dds_category("rspns_act", "rspns_act", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.2, 4, 0);
  add_dds_category("thrt_clock1", "thrt_clock1", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock10", "thrt_clock10", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock11", "thrt_clock11", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock12", "thrt_clock12", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock2", "thrt_clock2", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock3", "thrt_clock3", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock4", "thrt_clock4", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock5", "thrt_clock5", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock6", "thrt_clock6", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock7", "thrt_clock7", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock8", "thrt_clock8", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("thrt_clock9", "thrt_clock9", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category("rspns_suppress", "react_suppress", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.8, 14, 0);
  add_dds_category("thrt", "thrt_acquired", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.2, 5, 1);
  add_dds_category("rspns_lm", "rspns_thrt", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.7, 3.5, 1);
  add_dds_category("casualty", "react_casualty", 0.55, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2800, 0.2, 16, 0);
  add_dds_category("reload", "act_reload", 2, "action_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 3.5, 0);
  add_dds_category("kill_melee", "kill_melee", 0.75, "", 1, ::dds_sort_ent_dist, ::get_attacker, 400, 1, 3.5, 0);
}

init_dds_categories_axis() {
  level.dds.categories_axis = [];
  add_dds_category_axis("react_grenade", "react_grenade", 1.25, "grenade_rspns", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.8, 1.5, 0);
  add_dds_category_axis("react_emp", "react_emp", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.8, 1.5, 0);
  add_dds_category_axis("react_sniper", "react_sniper", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0);
  add_dds_category_axis("rspns_neg", "rspns_neg", 1.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.05, 4.5, 0);
  add_dds_category_axis("thrt_acquired", "thrt_acquired", 0.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 16.5, 0);
  add_dds_category_axis("kill_confirm", "act_kill_confirm", 2, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.3, 6.5, 0);
  add_dds_category_axis("headshot", "act_kill_confirm", 0.75, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.3, 7, 0);
  add_dds_category_axis("rspns_killfirm", "rspns_killfirm", 0.75, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.3, 7, 0);
  add_dds_category_axis("rspns_movement", "rspns_movement", 0.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.2, 13.5, 0);
  add_dds_category_axis("react_move", "react_move", 0.5, "rspns_movement", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 16.5, 0);
  add_dds_category_axis("fragout", "act_fragout", 0.75, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.8, 1.5, 0);
  add_dds_category_axis("empout", "act_empout", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.7, 1.5, 0);
  add_dds_category_axis("smokeout", "act_smokeout", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.7, 1.5, 0);
  add_dds_category_axis("react_cover", "react_cover", 1.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.1, 4.5, 0);
  add_dds_category_axis("thrt_dist10", "thrt_dist10", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category_axis("thrt_dist20", "thrt_dist20", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category_axis("thrt_dist30", "thrt_dist30", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category_axis("thrt_dist40", "thrt_dist40", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0);
  add_dds_category_axis("thrt_open", "thrt_open", 0.5, "rspns_suppress", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0);
  add_dds_category_axis("thrt_movement", "thrt_movement", 0.5, "thrt_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0);
  add_dds_category_axis("thrt_breaking", "thrt_breaking", 0.5, "rspns_lm", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.1, 7.5, 0);
  add_dds_category_axis("rspns_act", "rspns_act", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.2, 4, 0);
  add_dds_category_axis("thrt_clock1", "thrt_clock1", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock10", "thrt_clock10", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock11", "thrt_clock11", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock12", "thrt_clock12", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock2", "thrt_clock2", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock3", "thrt_clock3", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock4", "thrt_clock4", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock5", "thrt_clock5", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock6", "thrt_clock6", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock7", "thrt_clock7", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock8", "thrt_clock8", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("thrt_clock9", "thrt_clock9", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 5, 1);
  add_dds_category_axis("rspns_suppress", "react_suppress", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.8, 14, 0);
  add_dds_category_axis("thrt", "thrt_acquired", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.2, 5, 1);
  add_dds_category_axis("rspns_lm", "rspns_thrt", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.7, 3.5, 1);
  add_dds_category_axis("casualty", "react_casualty", 0.55, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2800, 0.2, 16, 0);
  add_dds_category_axis("reload", "act_reload", 2, "action_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 3.5, 0);
  add_dds_category_axis("kill_melee", "kill_melee", 0.75, "", 1, ::dds_sort_ent_dist, ::get_attacker, 400, 1, 3.5, 0);
}

add_dds_category(name, alias_name, duration, rspns_cat_name, clear_category_on_action_success, priority_sort, get_talker_func, distance, probability, timeout_reset, should_squelch) {
  new_category = spawnstruct();
  new_category.name = name;
  new_category.alias_name = alias_name;
  new_category.duration = duration;
  new_category.priority_sort = priority_sort;
  new_category.probability = probability;
  new_category.get_talker_func = get_talker_func;
  new_category.speaker_distance = distance;
  new_category.last_time = gettime();
  new_category.backoff_count = 0;
  new_category.timeout = randomint(10);
  new_category.last_timeout = new_category.timeout;
  new_category.timeout_reset = timeout_reset;
  new_category.rspns_cat_name = rspns_cat_name;
  new_category.clear_on_action_success = clear_category_on_action_success;
  new_category.should_squelch = should_squelch;
  level.dds.categories[level.dds.categories.size] = new_category;
}

add_dds_category_axis(name, alias_name, duration, rspns_cat_name, clear_category_on_action_success, priority_sort, get_talker_func, distance, probability, timeout_reset, notused) {
  new_category_axis = spawnstruct();
  new_category_axis.name = name;
  new_category_axis.alias_name = alias_name;
  new_category_axis.duration = duration;
  new_category_axis.priority_sort = priority_sort;
  new_category_axis.probability = probability;
  new_category_axis.get_talker_func = get_talker_func;
  new_category_axis.speaker_distance = distance;
  new_category_axis.last_time = gettime();
  new_category_axis.backoff_count = 0;
  new_category_axis.timeout = randomint(10);
  new_category_axis.last_timeout = new_category_axis.timeout;
  new_category_axis.timeout_reset = timeout_reset;
  new_category_axis.rspns_cat_name = rspns_cat_name;
  new_category_axis.clear_on_action_success = clear_category_on_action_success;
  level.dds.categories_axis[level.dds.categories_axis.size] = new_category_axis;
}

init_dds_active_events() {
  level.dds.active_events = [];
  level.dds.active_events_axis = [];

  for(i = 0; i < level.dds.categories.size; i++)
    level.dds.active_events[level.dds.categories[i].name] = [];

  for(i = 0; i < level.dds.categories_axis.size; i++)
    level.dds.active_events_axis[level.dds.categories_axis[i].name] = [];
}

dds_clear_old_expired_events() {
  for(i = 0; i < level.dds.categories.size; i++) {
    category = level.dds.categories[i];

    for(j = 0; j < level.dds.active_events[category.name].size; j++) {
      level.dds.active_events[category.name][j].duration = level.dds.active_events[category.name][j].duration - level.dds.heartbeat;

      if(level.dds.active_events[category.name][j].duration <= 0 || level.dds.active_events[category.name][j].clear_event_on_prob)
        arrayremovevalue(level.dds.active_events[category.name], level.dds.active_events[category.name][j]);
    }
  }
}

dds_clear_old_expired_events_axis() {
  for(i = 0; i < level.dds.categories_axis.size; i++) {
    category = level.dds.categories_axis[i];

    for(j = 0; j < level.dds.active_events_axis[category.name].size; j++) {
      level.dds.active_events_axis[category.name][j].duration = level.dds.active_events_axis[category.name][j].duration - level.dds.heartbeat;

      if(level.dds.active_events_axis[category.name][j].duration <= 0 || level.dds.active_events_axis[category.name][j].clear_event_on_prob)
        arrayremovevalue(level.dds.active_events_axis[category.name], level.dds.active_events_axis[category.name][j]);
    }
  }
}

dds_clear_all_queued_events() {
  for(i = 0; i < level.dds.categories.size; i++) {
    for(j = 0; j < level.dds.active_events[level.dds.categories[i].name].size; j++)
      level.dds.active_events[level.dds.categories[i].name] = [];
  }
}

dds_clear_all_queued_events_axis() {
  for(i = 0; i < level.dds.categories_axis.size; i++) {
    for(j = 0; j < level.dds.active_events_axis[level.dds.categories_axis[i].name].size; j++)
      level.dds.active_events_axis[level.dds.categories_axis[i].name] = [];
  }
}

dds_main_process() {
  if(flag("dds_running_allies")) {
    return;
  }
  flag_set("dds_running_allies");
  dds_find_threats("allies", "axis");
  should_delay_dds = 0;

  while(flag("dds_running_allies")) {
    dds_clear_old_expired_events();

    if(isDefined(level.numberofimportantpeopletalking) && level.numberofimportantpeopletalking > 0) {
      should_delay_dds = 1;
      wait(level.dds.heartbeat);
      continue;
    }

    if(should_delay_dds) {
      wait(level.dds.scripted_line_delay);
      dds_clear_all_queued_events();
      should_delay_dds = 0;
    }

    if(!dds_process_active_events())
      wait(level.dds.heartbeat);
    else
      wait 0.1;
  }
}

dds_main_process_axis() {
  if(flag("dds_running_axis")) {
    return;
  }
  flag_set("dds_running_axis");
  dds_find_threats("axis", "allies");
  should_delay_dds = 0;

  while(flag("dds_running_axis")) {
    dds_clear_old_expired_events_axis();

    if(isDefined(level.numberofimportantpeopletalking) && level.numberofimportantpeopletalking > 1) {
      should_delay_dds = 1;
      wait(level.dds.heartbeat);
      continue;
    }

    if(should_delay_dds) {
      wait(level.dds.scripted_line_delay);
      dds_clear_all_queued_events_axis();
      should_delay_dds = 0;
    }

    if(dds_process_active_events_axis())
      wait(level.dds.heartbeat);
    else
      wait 0.1;
  }
}

dds_find_threats(us, them) {
  level thread dds_find_infantry_threat(us, them);
}

dds_enable(team) {
  if(!isDefined(team)) {
    level thread dds_main_process();
    level thread dds_main_process_axis();
  } else if(team == "allies")
    level thread dds_main_process();
  else if(team == "axis")
    level thread dds_main_process_axis();
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

        println("unknown team: " + team + " to disable dds.");

        break;
    }
  }
}

dds_send_team_notify_on_disable(team) {
  while(true) {
    flag_waitopen("dds_running_" + team);
    level notify("dds_running_" + team);
    flag_wait("dds_running_" + team);
  }
}

is_dds_enabled() {
  if(level.createfx_enabled || !flag("dds_running_allies") && !flag("dds_running_axis"))
    return false;

  return true;
}

exponent(base, power) {
  assert(power >= 0);

  if(power == 0)
    return 1;

  return base * exponent(base, power - 1);
}

dds_process_active_events() {
  for(i = 0; i < level.dds.categories.size; i++) {
    category = level.dds.categories[i];

    if(level.debug_dds_on != "")
      debug_update_timeouts(category.name, category.timeout, category.last_timeout, 1);

    if(category.timeout > 0) {
      category.timeout = category.timeout - level.dds.heartbeat;
      continue;
    }

    if(level.dds.active_events[category.name].size != 0) {
      level.dds.active_events[category.name] = [
        [category.priority_sort]
      ](level.dds.active_events[category.name]);

      for(j = 0; j < level.dds.active_events[category.name].size; j++) {
        if(randomfloat(1) >= category.probability) {
          if(level.debug_dds_on != "")
            debug_active_event_stat(category.name, "probability_skipped", 1);

          level.dds.active_events[category.name][j].clear_event_on_prob = 1;
          continue;
        }

        if(level.dds.active_events[category.name][j].processed) {
          continue;
        }
        if(dds_event_activate(level.dds.active_events[category.name][j], category.get_talker_func, category.speaker_distance, category.rspns_cat_name, category.should_squelch)) {
          if(!category.timeout_reset)
            category.timeout = category.timeout_reset;
          else {
            if(gettime() - category.last_time < category.last_timeout * 1.5 * 1000) {
              category.backoff_count++;

              if(category.backoff_count > level.dds.category_backoff_limit)
                category.backoff_count = level.dds.category_backoff_limit;
            } else {
              category.backoff_count--;

              if(category.backoff_count < 0)
                category.backoff_count = 0;
            }

            category.timeout = category.timeout_reset * exponent(2, category.backoff_count) + randomint(2);
            category.last_timeout = category.timeout;
            category.last_time = gettime();

            if(level.debug_dds_on != "")
              debug_reset_timeouts(category.name, category.timeout, category.last_timeout, category.last_time, 1);

          }

          if(level.debug_dds_on != "")
            debug_sphere_draw_type("process", category.name, level.dds.active_events[category.name][j], undefined);

          if(category.clear_on_action_success)
            level.dds.active_events[category.name] = [];

          return true;
        } else
          wait(level.dds.heartbeat);
      }
    }
  }

  return false;
}

dds_process_active_events_axis() {
  for(i = 0; i < level.dds.categories_axis.size; i++) {
    category = level.dds.categories_axis[i];

    if(level.debug_dds_on != "")
      debug_update_timeouts(category.name, category.timeout, category.last_timeout, 0);

    if(category.timeout > 0) {
      category.timeout = category.timeout - level.dds.heartbeat;
      continue;
    }

    if(level.dds.active_events_axis[category.name].size != 0) {
      level.dds.active_events_axis[category.name] = [
        [category.priority_sort]
      ](level.dds.active_events_axis[category.name]);

      for(j = 0; j < level.dds.active_events_axis[category.name].size; j++) {
        if(randomfloat(1) >= category.probability) {
          if(level.debug_dds_on != "")
            debug_active_event_stat(category.name, "probability_skipped", 0);

          level.dds.active_events_axis[category.name][j].clear_event_on_prob = 1;
          continue;
        }

        if(level.dds.active_events_axis[category.name][j].processed) {
          continue;
        }
        if(dds_event_activate(level.dds.active_events_axis[category.name][j], category.get_talker_func, category.speaker_distance, category.rspns_cat_name, 0)) {
          if(!category.timeout_reset)
            category.timeout = category.timeout_reset;
          else {
            if(gettime() - category.last_time < category.last_timeout * 1.5 * 1000) {
              category.backoff_count++;

              if(category.backoff_count > level.dds.category_backoff_limit)
                category.backoff_count = level.dds.category_backoff_limit;
            } else {
              category.backoff_count--;

              if(category.backoff_count < 0)
                category.backoff_count = 0;
            }

            category.timeout = category.timeout_reset * exponent(2, category.backoff_count) + randomint(2);
            category.last_timeout = category.timeout;
            category.last_time = gettime();

            if(level.debug_dds_on != "")
              debug_reset_timeouts(category.name, category.timeout, category.last_timeout, category.last_time, 0);

          }

          if(level.debug_dds_on != "")
            debug_sphere_draw_type("process", category.name, level.dds.active_events_axis[category.name][j], undefined);

          if(category.clear_on_action_success)
            level.dds.active_events_axis[category.name] = [];

          return true;
        } else
          wait(level.dds.heartbeat);
      }
    }
  }

  return false;
}

dds_event_activate(event, get_talker_func, distance, rspns_cat_name, should_squelch) {
  if(!isDefined(event)) {
    iprintlnbold("event not defined\\n");

    return false;
  }

  category_name = event.category_name;

  if(isDefined(event.category_response_name))
    category_name = event.category_response_name;

  talker = event[[get_talker_func]](isDefined(event.category_response_name), distance);

  if(!isDefined(talker) || !isalive(talker)) {
    if(level.debug_dds_on != "")
      debug_active_event_stat(category_name, "no_one_to_talk_count", event.isalliesline);

    event.processed = 1;
    return false;
  }

  phrase = dds_get_alias_from_event(talker, event.category_alias_name, event.ent);

  if(!isDefined(phrase))
    return false;

  if(isDefined(event.category_response_name)) {
    if(event.isalliesline)
      wait(level.dds.response_wait);
    else
      wait(level.dds.response_wait_axis);
  }

  if(level.debug_dds_on != "") {
    print_dds = getdvarintdefault("dds_usingDebug", 0);

    if(isDefined(print_dds) && print_dds == 1)
      talker thread debug_print_dialogue(phrase);

    debug_active_event_stat(category_name, "processed_count", event.isalliesline);
    debug_sphere_draw_type("speaker", category_name, event, talker);
  }

  if(!getdvarint(#"_id_5C6D79F8"))
    should_squelch = 0;

  if(isalive(talker)) {
    if(should_squelch && !isplayer(talker) && talker.voice != "russian_english")
      talker animscripts\face::playfacethread(undefined, "dds_squelch_strt", 0.5, "dds_squelch_strt");

    talker animscripts\face::playfacethread(undefined, phrase, 0.5, phrase);
  }

  if(should_squelch && !isplayer(talker) && isalive(talker) && talker.voice != "russian_english")
    talker animscripts\face::playfacethread(undefined, "dds_squelch_end", 0.5, "dds_squelch_end");

  event.talker = talker;
  event.talker_origin = talker.origin;
  event.phrase = phrase;
  event.processed = 1;
  add_phrase_to_history(phrase);

  if(rspns_cat_name != "")
    dds_notify_response(event, talker, phrase, rspns_cat_name);

  return true;
}

add_phrase_to_history(phrase) {
  level.dds.history[level.dds.history_index] = phrase;
  level.dds.history_index = (level.dds.history_index + 1) % level.dds.history_count;
}

get_nearest_common(response, player_can_say_line, distance) {
  player = get_players()[0];

  if(self.isalliesline) {
    ai_array = getaiarray("allies");

    if(player_can_say_line)
      ai_array[ai_array.size] = player;
  } else
    ai_array = getaiarray("axis");

  if(ai_array.size <= 0)
    return undefined;

  ai_array = remove_all_actors_that_are_squelched(ai_array);

  if(response && isDefined(self.talker)) {
    ai_array = remove_all_actors_with_same_characterid(ai_array, self.talker.dds_characterid);
    closest_ent = get_closest_living(self.talker.origin, ai_array);
  } else
    closest_ent = get_closest_living(self.ent_origin, ai_array);

  if(!isDefined(closest_ent))
    return undefined;

  dis_sq_from_player = distancesquared(player.origin, closest_ent.origin);

  if(dis_sq_from_player > distance * distance)
    return undefined;

  if(response && dis_sq_from_player < level.dds.response_distance_min * level.dds.response_distance_min)
    return undefined;

  return closest_ent;
}

remove_all_actors_that_are_squelched(ai_array) {
  non_squelched = [];

  foreach(ai in ai_array) {
    if(!isDefined(ai.bsc_squelched))
      non_squelched[non_squelched.size] = ai;
  }

  return non_squelched;
}

remove_all_actors_with_same_characterid(ai_array, talker_characterid) {
  i = 0;

  while(i < ai_array.size) {
    if(!isDefined(ai_array[i].dds_characterid))
      arrayremovevalue(ai_array, ai_array[i]);
    else if(ai_array[i].dds_characterid == talker_characterid)
      arrayremovevalue(ai_array, ai_array[i]);
    else
      i++;
  }

  return ai_array;
}

get_nearest(response, distance) {
  return get_nearest_common(response, 1, distance);
}

get_nearest_not_plr(response, distance) {
  return get_nearest_common(response, 0, distance);
}

get_attacker(response, distance) {
  if(isDefined(self.ent_attacker) && isalive(self.ent_attacker)) {
    if(isDefined(self.ent_team)) {
      if(isDefined(self.ent_attacker.team) && self.ent_team == self.ent_attacker.team)
        return undefined;

      if(isDefined(self.ent_attacker.vteam) && self.ent_team == self.ent_attacker.vteam) {
        println("^5 killed by a vehicle");

        return undefined;
      }
    }

    return self.ent_attacker;
  }

  return undefined;
}

get_self_ent(response, distance) {
  if(isDefined(self.ent) && isalive(self.ent))
    return self.ent;

  return undefined;
}

dds_get_alias_from_event(talker, category_alias_name, event_ent) {
  if(!isalive(talker)) {
    println("talker is dead");

    return undefined;
  }

  if(!isDefined(talker.dds_characterid)) {
    println("character name could not be found for this speaker.");

    return undefined;
  }

  alias = "dds_" + talker.dds_characterid + "_" + category_alias_name + "_";

  if(isDefined(event_ent) && category_alias_name == "thrt") {
    qualifier = event_ent get_landmark_qualifier(alias);

    if(isDefined(qualifier))
      alias = alias + (qualifier + "_");
  }

  variant_num = 0;
  variant_count_array = dds_variant_count_for_alias(alias);

  if(variant_count_array.size > 0) {
    for(i = 0; i < variant_count_array.size; i++) {
      variant_num = random(variant_count_array);
      temp_alias = alias;

      if(variant_num < 10)
        temp_alias = temp_alias + "0";

      temp_alias = temp_alias + variant_num;

      if(!is_phrase_in_history(temp_alias))
        return temp_alias;
    }
  } else {
    missing_dds = getdvarintdefault("dds_usingDebug", 0);

    if(isDefined(missing_dds) && missing_dds == 1)
      println("^5 did not find an alias: '" + alias + "'");

    return undefined;
  }

  missing_dds = getdvarintdefault("dds_usingDebug", 0);

  if(isDefined(missing_dds) && missing_dds == 1)
    println("^6all variants for alias: '" + alias + "' are in the phrase history.");

  return undefined;
}

is_phrase_in_history(phrase) {
  for(i = 0; i < level.dds.history.size; i++) {
    if(level.dds.history[i] == phrase)
      return true;
  }

  return false;
}

dds_variant_count_for_alias(alias) {
  variant_count_array = [];

  for(i = 0; i < level.dds.variant_limit; i++) {
    prefix = "";

    if(i < 10)
      prefix = "0";

    if(soundexists(alias + prefix + i))
      variant_count_array[variant_count_array.size] = i;
  }

  return variant_count_array;
}

get_landmark_qualifier(alias) {
  lm_script_area = undefined;
  lm_script_area_origin = undefined;

  if(!isDefined(self.node)) {
    nodearray = getanynodearray(self.origin, 100);

    for(i = 0; i < nodearray.size && i < 3; i++) {
      if(isDefined(nodearray[i].script_area)) {
        lm_script_area = nodearray[i].script_area;
        lm_script_area_origin = nodearray[i].origin;
        break;
      }
    }
  } else if(isDefined(self.node.script_area)) {
    lm_script_area = self.node.script_area;
    lm_script_area_origin = self.node.origin;
  }

  if(!isDefined(lm_script_area) || !isDefined(lm_script_area_origin))
    return undefined;

  if(distancesquared(self.origin, lm_script_area_origin) < 160000 && soundexists(alias + lm_script_area + "_00"))
    return lm_script_area;

  return undefined;
}

get_event_override(alias) {
  if(isDefined(level.dds.event_override_name) && randomfloat(1) >= level.dds.event_override_probability && soundexists(alias + level.dds.event_override_name + "_00"))
    return level.dds.event_override_name;

  return undefined;
}

dds_find_infantry_threat(us, them) {
  while(flag("dds_running_" + us)) {
    player = get_players()[0];
    our_team = getaiarray(us);
    other_team = getaiarray(them);
    success = 0;

    for(i = 0; i < our_team.size; i++) {
      for(j = 0; j < other_team.size; j++) {
        if(other_team.size > 1 && randomfloat(1) < 0.5) {
          if(other_team[j] cansee(our_team[i]) && distancesquared(other_team[j].origin, our_team[i].origin) < 4000 * 4000 && distancesquared(other_team[j].origin, player.origin) < 4000 * 4000) {
            other_team[j] dds_threat_notify(them != "allies");
            success = 1;
            break;
          }
        }
      }

      if(success) {
        break;
      }
    }

    wait 2;
  }
}

dds_getclock_position(pos) {
  if(!isDefined(level.player)) {
    return;
  }
  playerangles = level.player getplayerangles();
  playerforwardvec = anglestoforward(playerangles);
  playerunitforwardvec = vectornormalize(playerforwardvec);
  playerpos = level.player getorigin();
  playertobanzaivec = pos - playerpos;
  playertobanzaiunitvec = vectornormalize(playertobanzaivec);
  forwarddotbanzai = vectordot(playerunitforwardvec, playertobanzaiunitvec);
  anglefromcenter = acos(forwarddotbanzai);
  crossplayerenemy = vectorcross(playerunitforwardvec, playertobanzaiunitvec);
  dir = vectordot(crossplayerenemy, anglestoup(playerangles));

  if(dir < 0)
    anglefromcenter = anglefromcenter * -1;

  a = anglefromcenter + 180;
  hour = 6;

  for(i = 15; i < 375; i = i + 30) {
    if(a < i) {
      break;
    }

    hour = hour - 1;

    if(hour < 1)
      hour = 12;
  }

  return hour;
}

dds_threat_notify(isalliesline) {
  if(!isDefined(level.player)) {
    return;
  }
  aipos = self.origin;
  playerpos = level.player.origin;
  distance = distancesquared(playerpos, aipos);

  if(distance < 200)
    self dds_notify("thrt_dist10", isalliesline);
  else if(distance < 500)
    self dds_notify("thrt_dist20", isalliesline);
  else if(distance < 1000)
    self dds_notify("thrt_dist30", isalliesline);
  else if(randomint(100) > 50)
    self dds_notify("thrt_open", isalliesline);
  else {
    oclock = dds_getclock_position(aipos);
    self dds_notify("thrt_clock" + oclock, isalliesline);
  }
}

player_init() {
  if(!isplayer(self)) {
    println("dds::player_init not called on a player; did not set up dds player flags and threads.");

    return;
  }

  self.iskillstreaktimerrunning = 0;
  self.killstreakcounter = 0;
  self ent_flag_init("dds_killstreak");
  self ent_flag_init("dds_low_health");
  self thread dds_killstreak_timer();
  self thread dds_watch_player_health();
  self thread dds_multikill_tracker();
  self.dds_characterid = level.dds.player_character_name;
}

dds_multikill_tracker() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    level flag_wait("dds_running_" + self.team);
    self waittill("multikill");
    self dds_notify("multikill", self.team == "allies");
  }
}

dds_watch_player_health() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    level flag_wait("dds_running_" + self.team);
    wait 0.5;

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

  while(true) {
    if(self.health > self.maxhealth * 0.75) {
      self ent_flag_clear("dds_low_health");
      return;
    }

    wait 1;
  }
}

dds_killstreak_timer() {
  self endon("death");
  self endon("disconnect");
  kills = getdvarintdefault("dds_killstreak_kills", 3);
  time = getdvarintdefault("dds_killstreak_timer", 10);

  while(true) {
    level flag_wait("dds_running_" + self.team);
    self ent_flag_wait("dds_killstreak");
    self.killstreakcounter++;

    if(!self.iskillstreaktimerrunning) {
      self.iskillstreaktimerrunning = 1;
      self thread track_kills_over_time(kills, time);
    }

    self ent_flag_clear("dds_killstreak");
  }
}

track_kills_over_time(kills, time) {
  timer = gettime() + time * 1000;

  while(gettime() < timer) {
    if(self.killstreakcounter >= kills) {
      self dds_notify("killstreak", self.team == "allies");
      self.killstreakcounter = 0;
      timer = -1;
    }

    wait 0.1;
  }

  self.killstreakcounter = 0;
  self.iskillstreaktimerrunning = 0;
}

dds_ai_init() {
  self dds_get_ai_id();
  self thread dds_watch_grenade_flee();
  self thread dds_watch_friendly_fire();
}

dds_get_ai_id() {
  classname = tolower(self.classname);
  tokens = strtok(classname, "_");

  if(tokens.size >= 2) {
    switch (tokens[1]) {
      case "carlos":
      case "clark":
      case "mason":
        return;
      case "barnes":
        self.dds_characterid = "woo";
        return;
      case "lewis":
        self.dds_characterid = "bow";
        return;
      case "bowman":
      case "hudson":
      case "reznov":
      case "weaver":
      case "woods":
        self.dds_characterid = getsubstr(tokens[1], 0, 3);
        return;
    }
  }

  if(self.team != "neutral") {
    for(i = 0; i < level.dds.character_names[self.team].size; i++) {
      if(self.voice == level.dds.character_names[self.team][i]) {
        self.dds_characterid = level.dds.countryids[self.voice].label + level.dds.countryids[self.voice].count % level.dds.countryids[self.voice].max_voices;
        level.dds.countryids[self.voice].count++;
        return;
      }
    }
  } else
    return;

  println("dds: didn't set this AI with a dds_characterID");
}

dds_watch_grenade_flee() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("grenade_flee", weaponname);

    if(weaponname == "frag_grenade_sp" || weaponname == "frag_grenade_future_sp" || weaponname == "frag_grenade_80s_sp")
      self dds_notify("react_grenade", self.team == "allies");

    if(weaponname == "emp_grenade_sp")
      self dds_notify("react_emp", self.team == "allies");
  }
}

dds_watch_friendly_fire() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("dds_friendly_fire");
    self dds_notify("friendly_fire", self.team == "allies");
  }
}

update_player_damage(eattacker) {
  if(!is_dds_enabled()) {
    return;
  }
  self.dds_dmg_attacker = eattacker;
}

update_actor_damage(eattacker, damage_mod) {
  if(!is_dds_enabled()) {
    return;
  }
  self.dds_dmg_attacker = eattacker;

  if(isplayer(eattacker)) {
    switch (damage_mod) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_IMPACT":
        return;
    }

    if(self.team == eattacker.team)
      self notify("dds_friendly_fire");
    else if(self.team == "neutral")
      self dds_notify("civ_fire", eattacker.team == "allies");
  }
}

check_kill_damage(mod, dmg_mod) {
  if(isDefined(self.dds_dmg_attacker) && isDefined(self.dds_dmg_attacker.dds_dmg_attacker)) {
    if(self == self.dds_dmg_attacker.dds_dmg_attacker)
      return "kill_dmg_" + dmg_mod;
  }

  return mod;
}

dds_notify_mod(isalliesline, category_name) {
  if(!is_dds_enabled()) {
    return;
  }
  if(!isDefined(self.damagemod)) {
    return;
  }
  if(isDefined(self.dds_dmg_attacker) && isDefined(self.team)) {
    if(isDefined(self.dds_dmg_attacker.team) && (self.dds_dmg_attacker.team == self.team || self.team == "neutral"))
      return;
    else if(isDefined(self.dds_dmg_attacker.vteam) && self.dds_dmg_attacker.vteam == self.team)
      return;
  }

  is_bullet_kill = 0;

  if(!isDefined(category_name)) {
    switch (self.damagemod) {
      case "MOD_BURNED":
      case "MOD_CRUSH":
      case "MOD_DROWN":
      case "MOD_FALLING":
      case "MOD_HIT_BY_OBJECT":
      case "MOD_SUICIDE":
      case "MOD_TELEFRAG":
      case "MOD_TRIGGER_HURT":
        break;
      case "MOD_BAYONET":
      case "MOD_PROJECTILE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_UNKNOWN":
        break;
      case "MOD_MELEE":
        self dds_notify(check_kill_damage("kill_melee", "melee"), isalliesline);
        break;
      case "MOD_EXPLOSIVE":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
        self dds_notify("kill_explo", isalliesline);
        break;
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        if(animscripts\combat_utility::issniperrifle(self.damageweapon)) {
          self dds_notify(check_kill_damage("react_sniper", "shot"), !isalliesline);
          is_bullet_kill = 1;
          break;
        } else {
          self dds_notify(check_kill_damage("kill_confirm", "shot"), isalliesline);
          is_bullet_kill = 1;
          break;
        }
      case "MOD_HEAD_SHOT":
        is_bullet_kill = 1;
        break;
      default:

        println("^5 MOD: " + self.damagemod + " \\n");

        break;
    }
  } else {
    self dds_notify(category_name, isalliesline);
    is_bullet_kill = 1;
  }

  if(isplayer(self.attacker) && is_bullet_kill)
    self.attacker ent_flag_set("dds_killstreak");
}

dds_notify_casualty() {
  self dds_notify("casualty", self.team == "allies");
}

dds_notify_grenade(grenade_name, isalliesline, isthrowback) {
  if(!is_dds_enabled()) {
    return;
  }
  if(!isthrowback) {
    switch (grenade_name) {
      case "frag_grenade_80s_sp":
      case "frag_grenade_future_sp":
      case "frag_grenade_sp":
        self dds_notify("fragout", isalliesline);
        break;
      case "willy_pete_80s_sp":
      case "willy_pete_sp":
        self dds_notify("smokeout", isalliesline);
        break;
      case "emp_grenade_sp":
        self dds_notify("empout", isalliesline);
        break;
      case "claymore_80s_sp":
      case "claymore_sp":
      case "flash_grenade_80s_sp":
      case "flash_grenade_sp":
      case "m8_white_smoke_sp":
      case "molotov_sp":
      case "vc_grenade_sp":

        println("dds should we say something about this category grenade type: " + grenade_name + "?");

        break;
      default:

        println("dds do you want to add a category for this grenade type: " + grenade_name + "?");

        break;
    }
  } else
    self dds_notify("frag_throwback", isalliesline);
}

dds_notify_reload(weaponname, isalliesline) {
  if(!isDefined(weaponname)) {
    self dds_notify("reload", isalliesline);
    return;
  } else if(self getcurrentweaponclipammo() > 0) {
    return;
  }
  switch (weaponname) {
    case "crossbow_80s_sp":
    case "crossbow_explosive_alt_sp":
    case "crossbow_sp":
    case "crossbow_vzoom_alt_sp":
      break;
    default:
      self dds_notify("reload", isalliesline);
      break;
  }
}

dds_notify(category_name, isalliesline) {
  if(!flag("dds_running_allies") && isalliesline) {
    return;
  }
  if(!flag("dds_running_axis") && !isalliesline) {
    return;
  }
  if(isalliesline && !isDefined(level.dds.active_events[category_name])) {
    return;
  }
  if(!isalliesline && !isDefined(level.dds.active_events_axis[category_name])) {
    return;
  }
  assert(isDefined(level.dds), "dds not init.");
  assert(isDefined(isalliesline), "isAlliesLine is not defined.");

  if(!isalliesline) {
    if(level.dds.active_events_axis[category_name].size > level.dds.max_active_events)
      return;
  } else if(level.dds.active_events[category_name].size > level.dds.max_active_events) {
    return;
  }
  event = spawnstruct();
  event.category_name = category_name;
  event.ent = self;
  event.ent_origin = self.origin;
  event.ent_team = self.team;
  event.clear_event_on_prob = 0;
  event.processed = 0;
  event.ent_attacker = self.dds_dmg_attacker;
  event.isalliesline = isalliesline;

  if(level.debug_dds_on != "") {
    event.ent_number = self getentitynumber();
    debug_sphere_draw_type("notify", event.category_name, event, undefined);
    debug_active_event_stat(category_name, "total_notify_count", isalliesline);
  }

  if(!isalliesline) {
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
  event.processed = 0;

  if(rspns_cat_name == "grenade_rspns" && isDefined(event.ent) && isDefined(event.ent.grenade) && isDefined(event.ent.grenade.originalowner) && isDefined(event.ent.grenade.originalowner.team != event.ent_team)) {
    return;
  }
  if(level.debug_dds_on != "") {
    debug_sphere_draw_type("notify", event.category_response_name, event, undefined);
    debug_active_event_stat(event.category_response_name, "total_notify_count", event.isalliesline);
  }

  if(!event.isalliesline) {
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
    if(category_array[i].name == category_name)
      return category_array[i];
  }

  return undefined;
}

dds_sort_ent_dist(eventarray) {
  player = get_players()[0];
  dist_array = [];
  index_array = [];

  for(i = 0; i < eventarray.size; i++) {
    length = distancesquared(player.origin, eventarray[i].ent_origin);
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

  for(i = 0; i < index_array.size; i++)
    new_array[i] = eventarray[index_array[i]];

  return new_array;
}

dds_sort_ent_duration(eventarray) {
  return eventarray;
}

dds_sort_ent_damage(eventarray) {
  return eventarray;
}

debug_destroy_hud_elem() {
  if(getdvarint(#"_id_3B52EA17") != 1) {
    if(isDefined(level.dds.debug.hud_categories)) {
      for(i = 0; i < level.dds.debug.hud_categories.size; i++) {
        if(isDefined(level.dds.debug.hud_categories) && isDefined(level.dds.debug.hud_categories[i]) && isDefined(level.dds.debug.hud_stats) && isDefined(level.dds.debug.hud_stats[i])) {
          for(j = 0; j < level.dds.debug.hud_stats[i].size; j++) {
            if(isDefined(level.dds.debug.hud_stats) && isDefined(level.dds.debug.hud_stats[i][j]))
              level.dds.debug.hud_stats[i][j] destroy();
          }

          level.dds.debug.hud_categories[i] destroy();
        }
      }

      level.dds.debug.hud_categories = undefined;
    }

    if(isDefined(level.dds.debug_hud_columns)) {
      for(i = 0; i < level.dds.debug_hud_columns.size; i++) {
        if(isDefined(level.dds.debug_hud_columns) && isDefined(level.dds.debug_hud_columns[i]))
          level.dds.debug_hud_columns[i] destroy();
      }

      level.dds.debug_hud_columns = undefined;
    }

    if(isDefined(level.dds.debug.hud_player_name)) {
      level.dds.debug.hud_player_name destroy();
      level.dds.debug.hud_player_name = undefined;
    }

    if(isDefined(level.dds.debug.hud_event_override)) {
      level.dds.debug.hud_event_override destroy();
      level.dds.debug.hud_event_override = undefined;
    }

    if(isDefined(level.dds.debug.hud_event_override_probability)) {
      level.dds.debug.hud_event_override_probability destroy();
      level.dds.debug.hud_event_override_probability = undefined;
    }
  }

}

dds_debug() {
  level.dds.debug = spawnstruct();
  level.dds.debug.active_event_stats = [];
  level.dds.debug.active_event_stats_axis = [];
  level.dds.debug.stat_types = array("A. Events: ", "T. Notifies: ", "Processed: ", "Time1: ", "Cat. T.O.: ", "Backoff T.O.: ");

  for(i = 0; i < level.dds.categories.size; i++) {
    level.dds.debug.active_event_stats[level.dds.categories[i].name] = spawnstruct();
    level.dds.debug.active_event_stats[level.dds.categories[i].name].cur_active_events = 0;
    level.dds.debug.active_event_stats[level.dds.categories[i].name].total_notify_count = 0;
    level.dds.debug.active_event_stats[level.dds.categories[i].name].processed_count = 0;
    level.dds.debug.active_event_stats[level.dds.categories[i].name].no_one_to_talk_count = 0;
    level.dds.debug.active_event_stats[level.dds.categories[i].name].probability_skipped = 0;
    level.dds.debug.active_event_stats[level.dds.categories[i].name].time_since_last_timeout = 0;
    level.dds.debug.active_event_stats[level.dds.categories[i].name].category_timeout = 0;
    level.dds.debug.active_event_stats[level.dds.categories[i].name].backoff_timeout = 0;
  }

  for(i = 0; i < level.dds.categories_axis.size; i++) {
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name] = spawnstruct();
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].cur_active_events = 0;
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].total_notify_count = 0;
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].processed_count = 0;
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].no_one_to_talk_count = 0;
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].probability_skipped = 0;
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].time_since_last_timeout = 0;
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].category_timeout = 0;
    level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].backoff_timeout = 0;
  }

  while(true) {
    if(getdvarint(#"_id_3B52EA17") != 1) {
      wait 1;
      debug_destroy_hud_elem();
      continue;
    }

    for(i = 0; i < level.dds.categories.size; i++)
      level.dds.debug.active_event_stats[level.dds.categories[i].name].cur_active_events = level.dds.active_events[level.dds.categories[i].name].size;

    for(i = 0; i < level.dds.categories_axis.size; i++)
      level.dds.debug.active_event_stats_axis[level.dds.categories_axis[i].name].cur_active_events = level.dds.active_events_axis[level.dds.categories_axis[i].name].size;

    debug_hud_update();
    wait(level.dds.heartbeat);
  }

}

debug_update_timeouts(category_name, timeout, last_timeout, isallies) {
  if(isallies) {
    if(level.dds.debug.active_event_stats[category_name].category_timeout > 0)
      level.dds.debug.active_event_stats[category_name].category_timeout = level.dds.debug.active_event_stats[category_name].category_timeout - level.dds.heartbeat;

    if(level.dds.debug.active_event_stats[category_name].backoff_timeout > 0)
      level.dds.debug.active_event_stats[category_name].backoff_timeout = level.dds.debug.active_event_stats[category_name].backoff_timeout - level.dds.heartbeat;
  } else {
    if(level.dds.debug.active_event_stats_axis[category_name].category_timeout > 0)
      level.dds.debug.active_event_stats_axis[category_name].category_timeout = level.dds.debug.active_event_stats_axis[category_name].category_timeout - level.dds.heartbeat;

    if(level.dds.debug.active_event_stats_axis[category_name].backoff_timeout > 0)
      level.dds.debug.active_event_stats_axis[category_name].backoff_timeout = level.dds.debug.active_event_stats_axis[category_name].backoff_timeout - level.dds.heartbeat;
  }

}

debug_reset_timeouts(category_name, timeout, last_timeout, last_time, isallies) {
  if(isallies) {
    level.dds.debug.active_event_stats[category_name].time_since_last_timeout = last_time;
    level.dds.debug.active_event_stats[category_name].category_timeout = timeout;
    level.dds.debug.active_event_stats[category_name].backoff_timeout = timeout * 1.5;
  } else {
    level.dds.debug.active_event_stats_axis[category_name].time_since_last_timeout = last_time;
    level.dds.debug.active_event_stats_axis[category_name].category_timeout = timeout;
    level.dds.debug.active_event_stats_axis[category_name].backoff_timeout = timeout * 1.5;
  }

}

debug_hud_update() {
  if(getdvarint(#"_id_3B52EA17") != 0) {
    if(!isDefined(level.dds.debug_hud_columns)) {
      level.dds.debug_hud_columns = [];

      for(i = 0; i < level.dds.debug.stat_types.size; i++) {
        level.dds.debug_hud_columns[i] = newdebughudelem();
        level.dds.debug_hud_columns[i].alignx = "left";
        level.dds.debug_hud_columns[i].x = (i + 1) * 85 - 50;
        level.dds.debug_hud_columns[i].y = 20;
        level.dds.debug_hud_columns[i].color = (0.1, 0.1, 0.7);
        level.dds.debug_hud_columns[i] settext(level.dds.debug.stat_types[i]);
      }
    }

    if(!isDefined(level.dds.debug.hud_categories)) {
      level.dds.debug.hud_categories = [];

      for(i = 0; i < level.dds.categories.size; i++) {
        level.dds.debug.hud_categories[i] = newdebughudelem();
        level.dds.debug.hud_categories[i].alignx = "left";
        level.dds.debug.hud_categories[i].x = -70;
        level.dds.debug.hud_categories[i].y = 15 + (i + 1) * 15;
        level.dds.debug.hud_categories[i].color = (0.7, 0.1, 0.1);
        level.dds.debug.hud_categories[i] settext(level.dds.categories[i].name + ": ");
      }
    }

    if(!isDefined(level.dds.debug.hud_stats))
      level.dds.debug.hud_stats = [];

    for(i = 0; i < level.dds.categories.size; i++) {
      if(!isDefined(level.dds.debug.hud_stats[i]))
        level.dds.debug.hud_stats[i] = [];

      for(j = 0; j < level.dds.debug.stat_types.size; j++) {
        if(!isDefined(level.dds.debug.hud_stats[i][j])) {
          level.dds.debug.hud_stats[i][j] = newdebughudelem();
          level.dds.debug.hud_stats[i][j].alignx = "left";
          level.dds.debug.hud_stats[i][j].x = (j + 1) * 85 - 50;
          level.dds.debug.hud_stats[i][j].y = 15 + (i + 1) * 15;
        }
      }

      level.dds.debug.hud_stats[i][0] setvalue(level.dds.debug.active_event_stats[level.dds.categories[i].name].cur_active_events);
      level.dds.debug.hud_stats[i][1] setvalue(level.dds.debug.active_event_stats[level.dds.categories[i].name].total_notify_count);
      level.dds.debug.hud_stats[i][2] setvalue(level.dds.debug.active_event_stats[level.dds.categories[i].name].processed_count);
      level.dds.debug.hud_stats[i][3] setvalue(gettime() - level.dds.debug.active_event_stats[level.dds.categories[i].name].time_since_last_timeout);
      level.dds.debug.hud_stats[i][4] setvalue(level.dds.debug.active_event_stats[level.dds.categories[i].name].category_timeout);
      level.dds.debug.hud_stats[i][5] setvalue(level.dds.debug.active_event_stats[level.dds.categories[i].name].backoff_timeout);
    }
  }

}

debug_active_event_stat(category_name, stat, isallies) {
  if(isallies) {
    if(!isDefined(level.dds.debug.active_event_stats[category_name])) {
      return;
    }
    switch (stat) {
      case "total_notify_count":
        level.dds.debug.active_event_stats[category_name].total_notify_count++;
        break;
      case "processed_count":
        level.dds.debug.active_event_stats[category_name].processed_count++;
        break;
      case "no_one_to_talk_count":
        level.dds.debug.active_event_stats[category_name].no_one_to_talk_count++;
        break;
      case "probability_skipped":
        level.dds.debug.active_event_stats[category_name].probability_skipped++;
        break;
    }
  } else {
    if(!isDefined(level.dds.debug.active_event_stats_axis[category_name])) {
      return;
    }
    switch (stat) {
      case "total_notify_count":
        level.dds.debug.active_event_stats_axis[category_name].total_notify_count++;
        break;
      case "processed_count":
        level.dds.debug.active_event_stats_axis[category_name].processed_count++;
        break;
      case "no_one_to_talk_count":
        level.dds.debug.active_event_stats_axis[category_name].no_one_to_talk_count++;
        break;
      case "probability_skipped":
        level.dds.debug.active_event_stats_axis[category_name].probability_skipped++;
        break;
    }
  }

}

debug_sphere_draw_type(event_type, category_name, event, speaker) {
  if(!isDefined(event)) {
    return;
  }
  draw_info = spawnstruct();
  draw_info.event_type = event_type;
  draw_info.ent_number = event.ent_number;
  draw_info.ent_origin = event.ent_origin;
  draw_info.category_name = category_name;
  draw_info.color = level.color_debug["white"];

  if(isDefined(event.category_response_name) && event.category_response_name == category_name)
    draw_info.ent_origin = event.talker_origin;

  switch (event_type) {
    case "notify":
      draw_info.color = level.color_debug["cyan"];
      break;
    case "process":
      draw_info.color = level.color_debug["orange"];
      break;
    case "speaker":
      draw_info.color = level.color_debug["green"];

      if(isDefined(speaker)) {
        draw_info.speaker_ent_number = speaker getentitynumber();
        draw_info.speaker_ent_origin = speaker.origin;
      }

      if(isDefined(event.category_response_name)) {
        draw_info.color = level.color_debug["magenta"];
        draw_info.ent_origin = event.talker_origin;
      }

      break;
    default:
      iprintlnbold("no known type of event notify: " + event_type + ". setting color to white\\n");
      break;
  }

  draw_info debug_draw_info();
}

debug_draw_info() {
  if(isDefined(self.ent_number))
    ent_print_text = "ent triggered: " + self.ent_number;
  else
    ent_print_text = "ent triggered: unknown";

  display_ent_origin = self.ent_origin;

  if(isDefined(self.speaker_ent_number) && isDefined(self.speaker_ent_origin)) {
    ent_print_text = "ent speaker: " + self.speaker_ent_number;
    display_ent_origin = self.speaker_ent_origin;
  }

  draw_3d_sphere = getdvarintdefault("dds_drawDebug", 0);

  if(isDefined(draw_3d_sphere) && draw_3d_sphere == 1) {
    debugstar(display_ent_origin + vectorscale((0, 0, 1), 70.0), int(100), self.color);

    if(isDefined(self.speaker_ent_number))
      line(self.ent_origin + vectorscale((0, 0, 1), 70.0), self.speaker_ent_origin + vectorscale((0, 0, 1), 70.0), self.color, 1, 1, int(100));
  }

  draw_3d_text = getdvarintdefault("dds_drawDebugText", 0);

  if(isDefined(draw_3d_text) && draw_3d_text == 1) {
    print3d(display_ent_origin + vectorscale((0, 0, 1), 70.0), "event: " + self.event_type, self.color, 1, 0.7, int(100));
    print3d(display_ent_origin + vectorscale((0, 0, 1), 80.0), ent_print_text, self.color, 1, 0.7, int(100));
    print3d(display_ent_origin + vectorscale((0, 0, 1), 90.0), "category: " + self.category_name, self.color, 1, 0.7, int(100));
  }

}

dds_debug_player_health() {
  self endon("death");
  self endon("disconnect");
  player_health_hud = undefined;

  if(!isDefined(player_health_hud)) {
    player_health_hud = newdebughudelem();
    player_health_hud.alignx = "left";
    player_health_hud.x = -75;
    player_health_hud.y = 255;
    player_health_hud.color = (0, 0, 1);
  }

  while(true) {
    player_health_hud setvalue(self.health);
    wait 0.5;
  }

}

debug_print_dialogue(soundalias) {
  if(!is_dds_enabled()) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self notify("stop_dds_dialogue_print");
  self endon("stop_dds_dialogue_print");
  size = soundalias.size;
  time = gettime() + 3000;

  if(size > 25)
    time = gettime() + size * 0.1 * 1000;

  while(gettime() < time && isalive(self)) {
    print3d(self.origin + vectorscale((0, 0, 1), 72.0), soundalias);
    wait 0.05;
  }

}

dds_set_event_override(event_name) {
  level.dds.event_override_name = event_name;
}

dds_clear_event_override() {
  level.dds.event_override_name = undefined;
}

dds_set_event_override_probability(probability_value) {
  if(probability_value < 0 || probability_value > 1) {
    println(probability_value + " is invalid event override probability. value must be between 0 and 1. resetting to default.");

    dds_reset_event_override_probability();
  } else
    level.dds.event_override_probability = probability_value;
}

dds_reset_event_override_probability() {
  level.dds.event_override_probability = 0.5;
}
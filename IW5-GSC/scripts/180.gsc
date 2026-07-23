/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\180.gsc
**************************************/

init() {
  anim.so = spawnStruct();
  anim.so.eventtypes = [];
  anim.so.eventtypes["check_fire"] = "threat_friendly_fire";
  anim.so.eventtypes["reload"] = "inform_reload_generic";
  anim.so.eventtypes["frag_out"] = "inform_attack_grenade";
  anim.so.eventtypes["flash_out"] = "inform_attack_flashbang";
  anim.so.eventtypes["smoke_out"] = "inform_attack_smoke";
  anim.so.eventtypes["c4_plant"] = "inform_attack_c4";
  anim.so.eventtypes["claymore_plant"] = "inform_plant_claymore";
  anim.so.eventtypes["downed"] = "inform_suppressed";
  anim.so.eventtypes["bleedout"] = "inform_bleedout";
  anim.so.eventtypes["reviving"] = "inform_reviving";
  anim.so.eventtypes["revived"] = "inform_revived";
  anim.so.eventtypes["sentry_out"] = "inform_place_sentry";
  anim.so.eventtypes["area_secure"] = "inform_area_secure";
  anim.so.eventtypes["kill_generic"] = "inform_kill_generic";
  anim.so.eventtypes["kill_infantry"] = "inform_kill_infantry";
  anim.so.eventtypes["affirmative"] = "inform_roger";
  anim.so.eventtypes["negative"] = "inform_negative";
  anim.so.eventtypes["on_comms"] = "inform_comms";
  anim.so.eventtypes["mark_dropzone"] = "inform_markdz";
  anim.so.eventtypes["glowstick_out"] = "inform_use_glowstick";
  anim.so.eventtypeminwait = [];
  anim.so.eventtypeminwait["check_fire"] = 4;
  anim.so.eventtypeminwait["reload"] = 8;
  anim.so.eventtypeminwait["frag_out"] = 3;
  anim.so.eventtypeminwait["flash_out"] = 3;
  anim.so.eventtypeminwait["smoke_out"] = 3;
  anim.so.eventtypeminwait["c4_plant"] = 2;
  anim.so.eventtypeminwait["claymore_plant"] = 2;
  anim.so.eventtypeminwait["downed"] = 0.5;
  anim.so.eventtypeminwait["bleedout"] = 0.5;
  anim.so.eventtypeminwait["reviving"] = 2;
  anim.so.eventtypeminwait["revived"] = 2;
  anim.so.eventtypeminwait["sentry_out"] = 3;
  anim.so.eventtypeminwait["kill_generic"] = 2;
  anim.so.eventtypeminwait["kill_infantry"] = 2;
  anim.so.eventtypeminwait["area_secure"] = 0.5;
  anim.so.eventtypeminwait["affirmative"] = 2;
  anim.so.eventtypeminwait["negative"] = 2;
  anim.so.eventtypeminwait["on_comms"] = 0.5;
  anim.so.eventtypeminwait["mark_dropzone"] = 0.5;
  anim.so.eventtypeminwait["glowstick_out"] = 3;
  anim.so.skipdistancecheck = [];
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "affirmative";
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "negative";
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "area_secure";
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "on_comms";
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "mark_dropzone";
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "downed";
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "bleedout";
  anim.so.skipdistancecheck[anim.so.skipdistancecheck.size] = "check_fire";
  anim.so.noreloadcalloutweapons = [];
  anim.so.noreloadcalloutweapons[anim.so.noreloadcalloutweapons.size] = "m79";
  anim.so.noreloadcalloutweapons[anim.so.noreloadcalloutweapons.size] = "ranger";
  anim.so.noreloadcalloutweapons[anim.so.noreloadcalloutweapons.size] = "claymore";
  anim.so.noreloadcalloutweapons[anim.so.noreloadcalloutweapons.size] = "rpg";
  anim.so.noreloadcalloutweapons[anim.so.noreloadcalloutweapons.size] = "rpg_player";
  anim.so.bcmaxdistsqd = 640000;
  anim.so.bcprintfailprefix = "^3***** BCS FAILURE: ";
  common_scripts\utility::array_thread(level.players, ::enable_chatter_on_player);
  enable_chatter();
}

enable_chatter() {
  level.so_player_chatter_enabled = 1;
}

disable_chatter() {
  level.so_player_chatter_enabled = 0;
}

enable_chatter_on_player() {
  self.so_isspeaking = 0;
  self.bc_eventtypelastusedtime = [];
  thread revive_tracking();
  thread claymore_tracking();
  thread reload_tracking();
  thread grenade_tracking();
  thread friendlyfire_tracking();
  thread friendlyfire_whizby_tracking();
  thread sentry_tracking();
  thread kill_generic_tracking();
  thread kill_infantry_tracking();
  thread area_secure_tracking();
  thread affirmative_tracking();
  thread negative_tracking();
  thread on_comms_tracking();
  thread mark_dropzone_tracking();
  thread glowstick_tracking();
}

revive_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("so_downed", "so_bleedingout", "so_reviving", "so_revived");

    if(var_0 == "so_downed") {
      play_so_chatter("downed");
      continue;
    }

    if(var_0 == "so_bleedingout") {
      play_so_chatter("bleedout");
      continue;
    }

    if(var_0 == "so_reviving") {
      play_so_chatter("reviving");
      continue;
    }

    if(var_0 == "so_revived") {
      play_so_chatter("revived");
    }
  }
}

claymore_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("begin_firing");
    var_0 = self getcurrentweapon();

    if(var_0 == "claymore") {
      play_so_chatter("claymore_plant");
    }
  }
}

sentry_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("sentry_placement_finished");
    play_so_chatter("sentry_out");
  }
}

kill_generic_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_kill_generic");
    play_so_chatter("kill_generic");
  }
}

kill_infantry_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_kill_infantry");
    play_so_chatter("kill_infantry");
  }
}

area_secure_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_area_secure");
    play_so_chatter("area_secure");
  }
}

affirmative_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_affirmative");
    play_so_chatter("area_secure");
  }
}

negative_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_negative");
    play_so_chatter("negative");
  }
}

on_comms_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_on_comms");
    play_so_chatter("on_comms");
  }
}

mark_dropzone_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_bcs_mark_dropzone");
    play_so_chatter("mark_dropzone");
  }
}

glowstick_tracking() {}

reload_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();

    if(weapon_no_reload_callout(var_0)) {
      continue;
    }
    if(is_downed()) {
      continue;
    }
    play_so_chatter("reload");
  }
}

weapon_no_reload_callout(var_0) {
  foreach(var_2 in anim.so.noreloadcalloutweapons) {
    if(var_0 == var_2) {
      return 1;
    }
  }

  return 0;
}

grenade_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = undefined;

    if(var_1 == "fraggrenade") {
      var_2 = "frag_out";
    } else if(var_1 == "semtex_grenade") {
      var_2 = "frag_out";
    } else if(var_1 == "flash_grenade") {
      var_2 = "flash_out";
    } else if(var_1 == "smoke_grenade_american") {
      var_2 = "smoke_out";
    } else if(var_1 == "c4") {
      var_2 = "c4_plant";
    }
    if(isDefined(var_2)) {
      play_so_chatter(var_2);
    }
  }
}

friendlyfire_tracking() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!friendlyfire_is_valid(var_0, var_1, var_4)) {
      continue;
    }
    play_so_chatter("check_fire");
  }
}

friendlyfire_is_valid(var_0, var_1, var_2) {
  if(var_0 <= 0) {
    return 0;
  }
  if(!isPlayer(var_1)) {
    return 0;
  }
  if(var_1 == self) {
    return 0;
  }
  if(var_2 == "MOD_MELEE") {
    return 0;
  }
  if(isDefined(level.friendlyfire_warnings) && !level.friendlyfire_warnings) {
    return 0;
  }
  return 1;
}

friendlyfire_whizby_tracking() {
  level endon("special_op_terminated");
  self endon("death");
  self addaieventlistener("bulletwhizby");

  for(;;) {
    self waittill("ai_event", var_0, var_1, var_2);

    if(var_0 == "bulletwhizby") {
      if(!friendlyfire_whizby_is_valid(var_1, var_2)) {
        continue;
      }
      play_so_chatter("check_fire");
    }
  }
}

friendlyfire_whizby_is_valid(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return 0;
  }
  if(var_0 == self) {
    return 0;
  }
  if(is_downed()) {
    return 0;
  }
  if(abs(var_1[2] - self.origin[2] > 128)) {
    return 0;
  }
  var_2 = distance2d(self.origin, var_1);

  if(!animscripts\battlechatter_ai::friendlyfire_whizby_distances_valid(var_0, var_2)) {
    return 0;
  }
  if(isDefined(level.friendlyfire_warnings) && !level.friendlyfire_warnings) {
    return 0;
  }
  return 1;
}

play_revive_nag() {
  var_0 = get_nag_event_type();
  play_so_chatter(var_0);
}

get_nag_event_type() {
  var_0 = "downed";
  var_1 = self.laststand_info.bleedout_time;
  var_2 = self.laststand_info.bleedout_time_default;

  if(var_1 < var_2 * level.laststand_stage2_multiplier) {
    var_0 = "bleedout";
  }
  return var_0;
}

can_say_current_nag_event_type() {
  var_0 = get_nag_event_type();
  return can_say_event_type(var_0);
}

play_so_chatter(var_0) {
  level endon("special_op_terminated");
  self endon("death");

  if(!can_say_event_type(var_0)) {
    return;
  }
  if(!close_enough_to_other_player(var_0)) {
    return;
  }
  var_1 = get_player_team_prefix(self) + anim.so.eventtypes[var_0];
  var_1 = check_overrides(var_0, var_1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!soundexists(var_1)) {
    return;
  }
  self.so_isspeaking = 1;
  self playSound(var_1, "bc_done", 1);
  self waittill("bc_done");
  self.so_isspeaking = 0;
  update_event_type(var_0);
}

can_say_event_type(var_0) {
  if(!isDefined(level.so_player_chatter_enabled) || !level.so_player_chatter_enabled) {
    return 0;
  }
  if(self.so_isspeaking) {
    return 0;
  }
  if(!isDefined(self.bc_eventtypelastusedtime[var_0])) {
    return 1;
  }
  var_1 = self.bc_eventtypelastusedtime[var_0];
  var_2 = anim.so.eventtypeminwait[var_0] * 1000;

  if(gettime() - var_1 >= var_2) {
    return 1;
  }
  return 0;
}

update_event_type(var_0) {
  self.bc_eventtypelastusedtime[var_0] = gettime();
}

check_overrides(var_0, var_1) {
  if(var_0 == "reload") {
    if(isDefined(level.so_override["skip_inform_reloading"]) && level.so_override["skip_inform_reloading"]) {
      return undefined;
    }
    if(isDefined(level.so_override["inform_reloading"])) {
      return level.so_override["inform_reloading"];
    }
  }

  return var_1;
}

get_player_team_prefix(var_0) {
  var_1 = "";

  if(isDefined(level.so_stealth) && level.so_stealth) {
    var_1 = "STEALTH_";
  }
  var_2 = "1";

  if(var_0 == level.player2) {
    var_2 = "2";
  }
  switch (level.so_campaign) {
    case "fso":
    case "hijack":
    case "delta":
    case "ranger":
      return "SO_US_" + var_2 + "_" + var_1;
    case "seal":
      return "SO_NS_" + var_2 + "_" + var_1;
    case "sas":
    case "ghillie":
    case "woodland":
    case "desert":
    case "arctic":
      return "SO_UK_" + var_2 + "_" + var_1;
    default:
  }
}

close_enough_to_other_player(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in anim.so.skipdistancecheck) {
      if(var_2 == var_0) {
        return 1;
      }
    }
  }

  var_4 = maps\_utility::get_other_player(self);

  if(distancesquared(var_4.origin, self.origin) > anim.so.bcmaxdistsqd) {
    return 0;
  }
  return 1;
}

is_downed() {
  if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed")) {
    return 1;
  }
  return 0;
}
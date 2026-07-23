/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\184.gsc
**************************************/

main() {
  thread setdeadquote();
}

setdeadquote() {
  level endon("mine death");
  level notify("new_quote_string");
  level endon("new_quote_string");

  if(isalive(level.player)) {
    level.player waittill("death");
  }
  if(!level.missionfailed) {
    var_0 = int(tablelookup("sp/deathQuoteTable.csv", 1, "size", 0));
    var_1 = randomint(var_0);

    if(getDvar("cycle_deathquotes") != "") {
      if(getDvar("ui_deadquote_index") == "") {
        setDvar("ui_deadquote_index", "0");
      }
      var_1 = getdvarint("ui_deadquote_index");
      setDvar("ui_deadquote", lookupdeathquote(var_1));
      var_1++;

      if(var_1 > var_0 - 1) {
        var_1 = 0;
      }
      setDvar("ui_deadquote_index", var_1);
    } else {
      setDvar("ui_deadquote", lookupdeathquote(var_1));
    }
  }
}

lookupdeathquote(var_0) {
  var_1 = tablelookup("sp/deathQuoteTable.csv", 0, var_0, 1);

  if(tolower(var_1[0]) != tolower("@")) {
    var_1 = "@" + var_1;
  }
  return var_1;
}

setdeadquote_so() {
  level notify("new_quote_string");
  var_0 = [];
  var_0 = so_builddeadquote();
  var_0 = maps\_utility::array_randomize(var_0);
  var_1 = randomint(var_0.size);

  if(!maps\_utility::is_coop_online()) {
    var_2 = var_0.size > 1;
    var_3 = var_1;

    while(var_2) {
      if(deadquote_recently_used(var_0[var_1])) {
        var_1++;

        if(var_1 >= var_0.size) {
          var_1 = 0;
        }
        if(var_1 == var_3) {
          var_2 = 0;
        }
        continue;
      }

      var_2 = 0;
    }

    setDvar("ui_deadquote_v3", getDvar("ui_deadquote_v2"));
    setDvar("ui_deadquote_v2", getDvar("ui_deadquote_v1"));
    setDvar("ui_deadquote_v1", var_0[var_1]);
  }

  switch (var_0[var_1]) {
    case "@DEADQUOTE_SO_ICON_PARTNER":
      maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_partner");
      break;
    case "@DEADQUOTE_SO_ICON_OBJ":
      maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_obj");
      break;
    case "@DEADQUOTE_SO_ICON_OBJ_OFFSCREEN":
      maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_obj_offscreen");
      break;
    case "@DEADQUOTE_SO_STAR_RANKINGS":
      maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_stars");
      break;
    case "@DEADQUOTE_SO_CLAYMORE_ENEMIES_SHOOT":
    case "@DEADQUOTE_SO_CLAYMORE_POINT_ENEMY":
      maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_claymore");
      break;
    case "@DEADQUOTE_SO_STEALTH_STAY_LOW":
      maps\_specialops_code::so_special_failure_hint_reset_dvars("ui_icon_stealth_stance");
      break;
  }

  setDvar("ui_deadquote", var_0[var_1]);
}

deadquote_recently_used(var_0) {
  if(var_0 == getDvar("ui_deadquote_v1")) {
    return 1;
  }
  if(var_0 == getDvar("ui_deadquote_v2")) {
    return 1;
  }
  if(var_0 == getDvar("ui_deadquote_v3")) {
    return 1;
  }
  return 0;
}

so_builddeadquote() {
  if(should_use_custom_deadquotes()) {
    return level.so_deadquotes;
  }
  var_0 = [];
  var_0[var_0.size] = "@DEADQUOTE_SO_TOGGLE_WEAP_ALT_MODE";
  var_0[var_0.size] = "@DEADQUOTE_SO_RED_FIND_COVER";
  var_0[var_0.size] = "@DEADQUOTE_SO_THROW_FLASHBANG";
  var_0[var_0.size] = "@DEADQUOTE_SO_GRENADES_ROLL";

  if(!maps\_utility::is_survival()) {
    var_0[var_0.size] = "@DEADQUOTE_SO_TRY_NEW_DIFFICULTY";
    var_0[var_0.size] = "@DEADQUOTE_SO_BEAT_BEST_TIME";
    var_0[var_0.size] = "@DEADQUOTE_SO_SEARCH_FOR_WEAPONS";
    var_0[var_0.size] = "@DEADQUOTE_SO_ICON_OBJ";
  } else {
    var_0[var_0.size] = "@DEADQUOTE_SO_TURRET_PLACEMENT";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_AMMO_REFILL";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_BUY_NEW_WEAPON";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_ATTACHMENT";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_WAVE_BONUS";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_CHALLENGE_REWARD";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_LAST_STAND";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_RIOT_SHIELD_DAMAGE";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_ARMOR_RESTOCK";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_FRIENDLY_RIOTSHIELD";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_ARMORY_UNLOCK";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_SENTRY_UNATTENDED";
    var_0[var_0.size] = "@DEADQUOTE_SO_SURVIVAL_KILL_CHEMICAL_ENEMIES";
  }

  if(isDefined(self.so_infohud_toggle_state) && self.so_infohud_toggle_state != "none") {
    var_0[var_0.size] = "@DEADQUOTE_SO_TOGGLE_TIMER";
  }
  if(maps\_utility::is_coop()) {
    var_0[var_0.size] = "@DEADQUOTE_SO_CRAWL_TO_TEAMMATE";
    var_0[var_0.size] = "@DEADQUOTE_SO_STAY_NEAR_TEAMMATE";
    var_0[var_0.size] = "@DEADQUOTE_SO_FRIENDLY_FIRE_HINT";
    var_0[var_0.size] = "@DEADQUOTE_SO_ICON_PARTNER";
  }

  return var_0;
}

should_use_custom_deadquotes() {
  if(!isDefined(level.so_deadquotes)) {
    return 0;
  }
  if(level.so_deadquotes.size <= 0) {
    return 0;
  }
  return level.so_deadquotes_chance >= randomfloat(1.0);
}
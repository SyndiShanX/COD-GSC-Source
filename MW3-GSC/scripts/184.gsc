/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\184.gsc
**************************************/

main() {
  thread _id_18A8();
}

_id_18A8() {
  level endon("mine death");
  level notify("new_quote_string");
  level endon("new_quote_string");

  if(isalive(level.player)) {
    level.player waittill("death");

  }
  if(!level._id_16C9) {
    var_0 = int(tablelookup("sp/deathQuoteTable.csv", 1, "size", 0));
    var_1 = randomint(var_0);

    if(getdvar("cycle_deathquotes") != "") {
      if(getdvar("ui_deadquote_index") == "") {
        setdvar("ui_deadquote_index", "0");

      }
      var_1 = getdvarint("ui_deadquote_index");
      setdvar("ui_deadquote", _id_18A9(var_1));
      var_1++;

      if(var_1 > var_0 - 1) {
        var_1 = 0;

      }
      setdvar("ui_deadquote_index", var_1);
    } else {
      setdvar("ui_deadquote", _id_18A9(var_1));
    }
  }
}

_id_18A9(var_0) {
  var_1 = tablelookup("sp/deathQuoteTable.csv", 0, var_0, 1);

  if(tolower(var_1[0]) != tolower("@")) {
    var_1 = "@" + var_1;

  }
  return var_1;
}

_id_18AA() {
  level notify("new_quote_string");
  var_0 = [];
  var_0 = _id_18AD();
  var_0 = maps\_utility::_id_0B53(var_0);
  var_1 = randomint(var_0.size);

  if(!maps\_utility::_id_18AB()) {
    var_2 = var_0.size > 1;
    var_3 = var_1;

    while(var_2) {
      if(_id_18AC(var_0[var_1])) {
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

    setdvar("ui_deadquote_v3", getdvar("ui_deadquote_v2"));
    setdvar("ui_deadquote_v2", getdvar("ui_deadquote_v1"));
    setdvar("ui_deadquote_v1", var_0[var_1]);
  }

  switch (var_0[var_1]) {
    case "@DEADQUOTE_SO_ICON_PARTNER":
      maps\_specialops_code::_id_17ED("ui_icon_partner");
      break;
    case "@DEADQUOTE_SO_ICON_OBJ":
      maps\_specialops_code::_id_17ED("ui_icon_obj");
      break;
    case "@DEADQUOTE_SO_ICON_OBJ_OFFSCREEN":
      maps\_specialops_code::_id_17ED("ui_icon_obj_offscreen");
      break;
    case "@DEADQUOTE_SO_STAR_RANKINGS":
      maps\_specialops_code::_id_17ED("ui_icon_stars");
      break;
    case "@DEADQUOTE_SO_CLAYMORE_ENEMIES_SHOOT":
    case "@DEADQUOTE_SO_CLAYMORE_POINT_ENEMY":
      maps\_specialops_code::_id_17ED("ui_icon_claymore");
      break;
    case "@DEADQUOTE_SO_STEALTH_STAY_LOW":
      maps\_specialops_code::_id_17ED("ui_icon_stealth_stance");
      break;
  }

  setdvar("ui_deadquote", var_0[var_1]);
}

_id_18AC(var_0) {
  if(var_0 == getdvar("ui_deadquote_v1")) {
    return 1;

  }
  if(var_0 == getdvar("ui_deadquote_v2")) {
    return 1;

  }
  if(var_0 == getdvar("ui_deadquote_v3")) {
    return 1;

  }
  return 0;
}

_id_18AD() {
  if(_id_18AE()) {
    return level._id_1840;

  }
  var_0 = [];
  var_0[var_0.size] = "@DEADQUOTE_SO_TOGGLE_WEAP_ALT_MODE";
  var_0[var_0.size] = "@DEADQUOTE_SO_RED_FIND_COVER";
  var_0[var_0.size] = "@DEADQUOTE_SO_THROW_FLASHBANG";
  var_0[var_0.size] = "@DEADQUOTE_SO_GRENADES_ROLL";

  if(!maps\_utility::_id_12DC()) {
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

  if(isDefined(self._id_1862) && self._id_1862 != "none") {
    var_0[var_0.size] = "@DEADQUOTE_SO_TOGGLE_TIMER";

  }
  if(maps\_utility::_id_12C1()) {
    var_0[var_0.size] = "@DEADQUOTE_SO_CRAWL_TO_TEAMMATE";
    var_0[var_0.size] = "@DEADQUOTE_SO_STAY_NEAR_TEAMMATE";
    var_0[var_0.size] = "@DEADQUOTE_SO_FRIENDLY_FIRE_HINT";
    var_0[var_0.size] = "@DEADQUOTE_SO_ICON_PARTNER";
  }

  return var_0;
}

_id_18AE() {
  if(!isDefined(level._id_1840)) {
    return 0;

  }
  if(level._id_1840.size <= 0) {
    return 0;

  }
  return level._id_17E0 >= randomfloat(1.0);
}
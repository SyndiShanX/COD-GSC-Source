#include maps\mp\gametypes\_playerlogic;
#include scripts\utility;

main() {
  replacefunc(maps\mp\_skill::isskillenabled, ::isskillenabled);

  // battlechatter: change some voice stuff (cpt price)
  replacefunc(maps\mp\gametypes\_battlechatter_mp::onplayerspawned, ::onplayerspawned_stub);

  // damagefeedback: change some of the feedbacks
  replacefunc(maps\mp\gametypes\_damagefeedback::updatedamagefeedback, ::updatedamagefeedback_stub);

  // dom: setup flags for custom teams
  replacefunc(maps\mp\gametypes\dom::precacheflags, ::precacheflags_stub);

  // TODO: match iw4 values for wait times (we override events, so put that hook there?)
  replacefunc(maps\mp\gametypes\_rank::xppointspopup, ::xppointspopup_stub);
  replacefunc(maps\mp\_events::updaterecentkills, ::updaterecentkills_stub);

  // killcam: add copycat logic to killcam
  replacefunc(maps\mp\gametypes\_killcam::killcam, ::killcam_stub);

  // music and dialog: new battlechatter, callouts and in-game music
  replacefunc(maps\mp\gametypes\_music_and_dialog::init, ::init_stub);
  replacefunc(maps\mp\gametypes\_music_and_dialog::onplayerspawned, ::music_onplayerspawned_stub);

  // sanitise names for iw4madmin
  replacefunc(maps\mp\gametypes\_playerlogic::callback_playerconnect, ::callback_playerconnect_stub);
  replacefunc(maps\mp\gametypes\_playerlogic::callback_playerdisconnect, ::callback_playerdisconnect_stub);
}

should_use_old_lightgrids() {
  if(scripts\mp_patches\common::is_iw4_map()) {
    // TODO: disable for certain maps atm
    switch (getDvar("mapname")) {
      case "mp_favela": // shadows need fixed
      case "mp_fuel2": // map looks way too dark, vision/lightset touchups might fix?
      case "mp_invasion": // hit or miss
      case "mp_rundown": // ^
      case "mp_checkpoint": // ^
        return 0;
      default:
        break;
    }

    return 1;
  }

  return 0;
}

init() {
  setDvar("r_lightgridnoncompressed", should_use_old_lightgrids());
}

init_stub() {
  game["music"]["spawn_allies"] = getteamspawnmusic("allies");
  game["music"]["victory_allies"] = getteamwinmusic("allies");
  game["music"]["defeat_allies"] = getteamlosemusic("allies");
  game["music"]["winning_allies"] = "time_running_out_winning";
  game["music"]["losing_allies"] = "time_running_out_losing";
  game["voice"]["allies"] = getteamvoiceprefix("allies") + "1mc_";
  game["music"]["spawn_axis"] = getteamspawnmusic("axis");
  game["music"]["victory_axis"] = getteamwinmusic("axis");
  game["music"]["defeat_axis"] = getteamlosemusic("axis");
  game["music"]["winning_axis"] = "time_running_out_winning";
  game["music"]["losing_axis"] = "time_running_out_losing";
  game["voice"]["axis"] = getteamvoiceprefix("axis") + "1mc_";
  game["music"]["losing_time"] = "null";
  game["music"]["suspense"] = [];
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_01";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_02";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_03";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_04";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_05";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_06";
  game["dialog"]["mission_success"] = "mission_success";
  game["dialog"]["mission_failure"] = "mission_fail";
  game["dialog"]["mission_draw"] = "draw";
  game["dialog"]["round_success"] = "encourage_win";
  game["dialog"]["round_failure"] = "encourage_lost";
  game["dialog"]["round_draw"] = "draw";
  game["dialog"]["timesup"] = "timesup";
  game["dialog"]["winning_time"] = "winning";
  game["dialog"]["losing_time"] = "losing";
  game["dialog"]["winning_score"] = "winning";
  game["dialog"]["losing_score"] = "losing";
  game["dialog"]["lead_lost"] = "lead_lost";
  game["dialog"]["lead_tied"] = "tied";
  game["dialog"]["lead_taken"] = "lead_taken";
  game["dialog"]["last_alive"] = "lastalive";
  game["dialog"]["boost"] = "boost";

  if(!isDefined(game["dialog"]["offense_obj"]))
    game["dialog"]["offense_obj"] = "boost";

  if(!isDefined(game["dialog"]["defense_obj"]))
    game["dialog"]["defense_obj"] = "boost";

  game["dialog"]["hardcore"] = "hardcore";
  game["dialog"]["highspeed"] = "highspeed";
  game["dialog"]["tactical"] = "tactical";
  game["dialog"]["challenge"] = "challengecomplete";
  game["dialog"]["promotion"] = "promotion";
  game["dialog"]["bomb_taken"] = "acheive_bomb";
  game["dialog"]["bomb_lost"] = "bomb_lost";
  game["dialog"]["bomb_planted"] = "bomb_planted";
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["obj_taken"] = "securedobj";
  game["dialog"]["obj_lost"] = "lostobj";
  game["dialog"]["obj_defend"] = "obj_defend";
  game["dialog"]["obj_destroy"] = "obj_destroy";
  game["dialog"]["obj_capture"] = "gbl_secureobj";
  game["dialog"]["objs_capture"] = "gbl_secureobjs";
  game["dialog"]["move_to_new"] = "new_positions";
  game["dialog"]["push_forward"] = "gbl_rally";
  game["dialog"]["attack"] = "attack";
  game["dialog"]["defend"] = "defend";
  game["dialog"]["offense"] = "offense";
  game["dialog"]["defense"] = "defense";
  game["dialog"]["halftime"] = "halftime";
  game["dialog"]["overtime"] = "overtime";
  game["dialog"]["side_switch"] = "switching";
  game["dialog"]["flag_taken"] = "ctf_retrieveflagally";
  game["dialog"]["enemy_flag_taken"] = "ctf_enemyflagcapd";
  game["dialog"]["flag_dropped"] = "ctf_enemydropflag";
  game["dialog"]["enemy_flag_dropped"] = "ctf_allydropflag";
  game["dialog"]["flag_returned"] = "ctf_allyflagback";
  game["dialog"]["enemy_flag_returned"] = "ctf_enemyflagback";
  game["dialog"]["flag_captured"] = "ctf_enemycapflag";
  game["dialog"]["enemy_flag_captured"] = "ctf_allycapflag";
  game["dialog"]["flag_getback"] = "ctf_retrieveflagally";
  game["dialog"]["enemy_flag_bringhome"] = "ctf_bringhomflag";
  game["dialog"]["hq_located"] = "hq_located";
  game["dialog"]["hq_enemy_captured"] = "hq_captured";
  game["dialog"]["hq_enemy_destroyed"] = "hq_destroyed";
  game["dialog"]["hq_secured"] = "hq_secured";
  game["dialog"]["hq_offline"] = "hq_offline";
  game["dialog"]["hq_online"] = "hq_online";
  game["dialog"]["hp_online"] = "hpt_identified";
  game["dialog"]["hp_lost"] = "hpt_enemycap";
  game["dialog"]["hp_contested"] = "hpt_contested";
  game["dialog"]["hp_secured"] = "hpt_allyown";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["secured_a"] = "secure_a";
  game["dialog"]["secured_b"] = "secure_b";
  game["dialog"]["secured_c"] = "secure_c";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
  game["dialog"]["enemy_has_a"] = "enemy_has_a";
  game["dialog"]["enemy_has_b"] = "enemy_has_b";
  game["dialog"]["enemy_has_c"] = "enemy_has_c";
  game["dialog"]["lost_all"] = "take_positions";
  game["dialog"]["secure_all"] = "positions_lock";
  game["dialog"]["destroy_sentry"] = "ks_sentrygun_destroyed";
  game["dialog"]["sentry_gone"] = "sentry_gone";
  game["dialog"]["sentry_destroyed"] = "sentry_destroyed";
  game["dialog"]["ti_gone"] = "ti_cancelled";
  game["dialog"]["ti_destroyed"] = "ti_blocked";
  game["dialog"]["ims_destroyed"] = "ims_destroyed";
  game["dialog"]["lbguard_destroyed"] = "lbguard_destroyed";
  game["dialog"]["ballistic_vest_destroyed"] = "ballistic_vest_destroyed";
  game["dialog"]["remote_sentry_destroyed"] = "remote_sentry_destroyed";
  game["dialog"]["sam_destroyed"] = "sam_destroyed";
  game["dialog"]["sam_gone"] = "sam_gone";
  game["dialog"]["claymore_destroyed"] = "null";
  game["dialog"]["mine_destroyed"] = "null";
  game["dialog"]["ti_destroyed"] = "gbl_tactinsertlost";
  game["dialog"]["lockouts"] = [];
  game["dialog"]["lockouts"]["ks_uav_allyuse"] = 6;
  level thread maps\mp\gametypes\_music_and_dialog::onplayerconnect();
  level thread maps\mp\gametypes\_music_and_dialog::onlastalive();
  level thread maps\mp\gametypes\_music_and_dialog::musiccontroller();
  level thread maps\mp\gametypes\_music_and_dialog::ongameended();
  level thread maps\mp\gametypes\_music_and_dialog::onroundswitch();
}

getteamvoiceprefix(var_0) {
  switch (game[var_0]) {
    case "rangers":
    case "marines":
      return "US_";

    case "opfor":
      return "AB_";

    case "russian":
      return "RU_";

    case "militia":
      return "PG_";

    case "sas":
    case "tf141":
      return "UK_";

    case "seals":
      return "NS_";

    default:
      return maps\mp\gametypes\_teams::factiontablelookup(var_0, maps\mp\gametypes\_teams::getteamvoiceprefixcol());
  }
}

getteamspawnmusic(var_0) {
  return (getteamvoiceprefix(var_0) + "spawn_music");
}

getteamwinmusic(var_0) {
  return (getteamvoiceprefix(var_0) + "victory_music");
}

getteamlosemusic(var_0) {
  return (getteamvoiceprefix(var_0) + "defeat_music");
}

music_onplayerspawned_stub() {
  self endon("disconnect");
  self waittill("spawned_player");

  wait 0.05;

  if(getDvar("virtuallobbyactive") == "0") {
    if(!level.splitscreen || level.splitscreen && !isDefined(level.playedstartingmusic)) {
      if(!maps\mp\_utility::issecondarysplitscreenplayer())
        self playlocalsound(game["music"]["spawn_" + self.team]);

      if(level.splitscreen)
        level.playedstartingmusic = 1;
    }

    if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
      if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies")
        maps\mp\_utility::leaderdialogonplayer("allies_gametype");
      else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis")
        maps\mp\_utility::leaderdialogonplayer("axis_gametype");
      else if(!maps\mp\_utility::issecondarysplitscreenplayer())
        maps\mp\_utility::leaderdialogonplayer("gametype");
    }

    maps\mp\_utility::gameflagwait("prematch_done");

    if(self.team == game["attackers"]) {
      if(!maps\mp\_utility::issecondarysplitscreenplayer())
        maps\mp\_utility::leaderdialogonplayer("offense_obj", "introboost");
    } else if(!maps\mp\_utility::issecondarysplitscreenplayer())
      maps\mp\_utility::leaderdialogonplayer("defense_obj", "introboost");
  }
}

isskillenabled() {
  return 0;
}

set_flag_fx_id_data(team) {
  level.flagfxid[team] = [];
  level.flagfxid[team]["friendly"] = undefined;
  level.flagfxid[team]["enemy"] = undefined;
}

map_h2m_team_to_h1(team, team_two) {
  level.flagmodels[team] = [];
  level.flagmodels[team]["friendly"] = level.flagmodels[team_two]["friendly"];
  level.flagmodels[team]["enemy"] = level.flagmodels[team_two]["enemy"];

  // set flag fx id data
  set_flag_fx_id_data(team);

  // copy boarder data
  points = ["_a", "_b", "_c"];
  foreach(point in points) {
    level.boarderfxid[team]["friendly"] = [];
    level.boarderfxid[team]["friendly"][point] = level.boarderfxid[team_two]["friendly"][point];
    level.boarderfxid[team]["enemy"] = [];
    level.boarderfxid[team]["enemy"][point] = level.boarderfxid[team_two]["enemy"][point];
  }
}

precacheflags_stub() {
  game["neutral"] = "neutral";

  // stock flag models
  level.flagmodels["marines"]["friendly"] = "h1_flag_mp_domination_usmc_blue";
  level.flagmodels["marines"]["enemy"] = "h1_flag_mp_domination_usmc_red";
  level.flagmodels["sas"]["friendly"] = "h1_flag_mp_domination_sas_blue";
  level.flagmodels["sas"]["enemy"] = "h1_flag_mp_domination_sas_red";
  level.flagmodels["opfor"]["friendly"] = "h1_flag_mp_domination_arab_blue";
  level.flagmodels["opfor"]["enemy"] = "h1_flag_mp_domination_arab_red";
  level.flagmodels["russian"]["friendly"] = "h1_flag_mp_domination_spetsnaz_blue";
  level.flagmodels["russian"]["enemy"] = "h1_flag_mp_domination_spetsnaz_red";
  level.flagmodels["neutral"]["friendly"] = "h1_flag_mp_domination_default";
  level.flagmodels["neutral"]["enemy"] = "h1_flag_mp_domination_default";

  set_flag_fx_id_data("marines");
  set_flag_fx_id_data("sas");
  set_flag_fx_id_data("opfor");
  set_flag_fx_id_data("russian");
  set_flag_fx_id_data("neutral");

  stock_teams = ["marines", "sas", "opfor", "russian", "neutral"];

  level.domborderfx = [];
  level.domborderfx["friendly"] = [];
  level.domborderfx["friendly"]["_a"] = "vfx/unique/vfx_marker_ctf";
  level.domborderfx["friendly"]["_b"] = "vfx/unique/vfx_marker_ctf";
  level.domborderfx["friendly"]["_c"] = "vfx/unique/vfx_marker_ctf";
  level.domborderfx["enemy"] = [];
  level.domborderfx["enemy"]["_a"] = "vfx/unique/vfx_marker_ctf_red";
  level.domborderfx["enemy"]["_b"] = "vfx/unique/vfx_marker_ctf_red";
  level.domborderfx["enemy"]["_c"] = "vfx/unique/vfx_marker_ctf_red";
  level.domborderfx["neutral"] = [];
  level.domborderfx["neutral"]["_a"] = "vfx/unique/vfx_marker_ctf_drk";
  level.domborderfx["neutral"]["_b"] = "vfx/unique/vfx_marker_ctf_drk";
  level.domborderfx["neutral"]["_c"] = "vfx/unique/vfx_marker_ctf_drk";

  foreach(team in stock_teams) {
    level.boarderfxid[team] = [];
    sides = ["friendly", "enemy"];

    foreach(side in sides) {
      level.boarderfxid[team][side] = [];
      var_6 = ["_a", "_b", "_c"];

      foreach(var_8 in var_6) {
        if(team == "neutral") {
          level.boarderfxid[team][side][var_8] = loadfx(level.domborderfx[team][var_8]);
          continue;
        }

        level.boarderfxid[team][side][var_8] = loadfx(level.domborderfx[side][var_8]);
      }
    }
  }

  // set custom flag models for teams
  map_h2m_team_to_h1("tf141", "sas");
  map_h2m_team_to_h1("militia", "opfor");
  map_h2m_team_to_h1("rangers", "marines");
  map_h2m_team_to_h1("spetsnaz", "russian");
  map_h2m_team_to_h1("seals", "marines");
}

onplayerspawned_stub() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");

    if(maps\mp\_utility::is_true(level.virtuallobbyactive)) {
      continue;
    }
    self.bcinfo = [];
    var_0 = getteamvoiceprefix(self.team);
    if(!isDefined(self.pers["voiceIndex"])) {
      var_1 = 4;
      var_2 = 4;
      var_3 = "m";

      if(!isagent(self) && self hasfemalecustomizationmodel())
        var_3 = "fe";

      self.pers["voiceNum"] = level.voice_count[self.team][var_3] + 1;

      if(var_3 == "fe")
        level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_2;
      else
        level.voice_count[self.team][var_3] = (level.voice_count[self.team][var_3] + 1) % var_1;

      self.pers["voicePrefix"] = var_0 + "1_";
    }

    if(level.splitscreen || !level.teambased) {
      continue;
    }
    thread maps\mp\gametypes\_battlechatter_mp::reloadtracking();
    thread maps\mp\gametypes\_battlechatter_mp::grenadetracking();
    thread maps\mp\gametypes\_battlechatter_mp::claymoretracking();
  }
}

updatedamagefeedback_stub(var_0, var_1) {
  if(!isPlayer(self) || !isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "scavenger":
      self playlocalsound("scavenger_pack_pickup");

      if(!level.hardcoremode)
        self setclientomnvar("damage_feedback", var_0);

      break;
    case "hitpainkiller":
      self set_hud_feedback("specialty_painkiller");
      self playlocalsound("mp_hit_armor");
      break;
    case "hitblastshield":
    case "hitlightarmor":
    case "hitjuggernaut":
      self playlocalsound("mp_hit_armor");
      self set_hud_feedback("h2_blastshield");
      break;
    case "dogs":
      self set_hud_feedback("hud_dog_melee");
      self playlocalsound("mp_hit_default");
      break;
    case "laser":
      if(isDefined(level.sentrygun)) {
        if(!isDefined(self.shouldloopdamagefeedback)) {
          if(isDefined(level.mapkillstreakdamagefeedbacksound))
            self thread[[level.mapkillstreakdamagefeedbacksound]](level.sentrygun);
        }
      }

      break;
    case "headshot":
      self playlocalsound("mp_hit_headshot");
      self setclientomnvar("damage_feedback", "headshot");
      break;
    case "hitmorehealth":
      self playlocalsound("mp_hit_armor");
      self setclientomnvar("damage_feedback", "hitmorehealth");
      break;
    case "killshot":
      self playlocalsound("mp_hit_kill");
      self setclientomnvar("damage_feedback", "killshot");
      break;
    case "killshot_headshot":
      self playlocalsound("mp_hit_kill_headshot");
      self setclientomnvar("damage_feedback", "killshot_headshot");
      break;
    case "none":
      break;
    default:
      self playlocalsound("mp_hit_default");
      self setclientomnvar("damage_feedback", "standard");
      break;
  }
}

set_hud_feedback(icon) {
  if(!isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback = newclienthudelem(self);
    self.hud_damagefeedback.horzAlign = "center";
    self.hud_damagefeedback.vertAlign = "middle";
    self.hud_damagefeedback.x = -12;
    self.hud_damagefeedback.y = -12;
    self.hud_damagefeedback.alpha = 0;
    self.hud_damagefeedback.archived = true;

    self.hud_damagefeedbackText = newclienthudelem(self);
    self.hud_damagefeedbackText.horzAlign = "center";
    self.hud_damagefeedbackText.vertAlign = "middle";
    self.hud_damagefeedbackText.x = -11;
    self.hud_damagefeedbackText.y = 12;
    self.hud_damagefeedbackText.alpha = 0;
    self.hud_damagefeedbackText.archived = true;
  }

  hitmark = "damage_feedback";
  hitmark_weight = 42;
  hitmark_height = 78;
  icon_weight = 25;
  icon_height = 25;
  fadeoutTime = 1;

  x = -21;
  y = -20;

  if(getDvarInt("camera_thirdPerson"))
    yOffset = self GetThirdPersonCrosshairOffset() * 240;
  else
    yOffset = getdvarfloat("cg_crosshairVerticalOffset") * 240;

  self.hud_damagefeedback setShader(hitmark, hitmark_weight, hitmark_height);
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeOverTime(fadeoutTime);
  self.hud_damagefeedback.alpha = 0;

  // only update hudelem positioning when necessary
  if(self.hud_damagefeedback.x != x)
    self.hud_damagefeedback.x = x;

  y = (y - int(yOffset));
  if(self.hud_damagefeedback.y != y)
    self.hud_damagefeedback.y = y;

  if(isDefined(icon)) {
    self.hud_damagefeedbackText setShader(icon, icon_weight, icon_height);
    self.hud_damagefeedbackText.alpha = 1;
    self.hud_damagefeedbackText fadeOverTime(fadeoutTime);
    self.hud_damagefeedbackText.alpha = 0;

    y = (12 - int(yOffset));
    if(self.hud_damagefeedbackText.y != y)
      self.hud_damagefeedbackText.y = y;
  }
}

xppointspopup_stub(event, amount) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  if(amount == 0) {
    return;
  }
  self notify("xpPointsPopup");
  self endon("xpPointsPopup");

  event_id = tablelookuprownum("mp/xp_event_table.csv", 0, event);

  if(getdvarint("scr_lua_score") == 1) {
    if(event_id >= 0) {
      self luinotifyevent(&"score_event", 2, event_id, amount);
      self _meth_8579(&"score_event", 2, event_id, amount);
    }

    return;
  }

  self.xpupdatetotal += amount;
  self setclientomnvar("ui_points_popup", self.xpupdatetotal);
  if(isDefined(event_id) && event_id != -1)
    self setclientomnvar("ui_points_popup_event", event_id);

  wait 1.1; // update stack timer to match iw4

  self.xpupdatetotal = 0;
}

updaterecentkills_stub(killId, weapon) {
  self endon("disconnect");
  level endon("game_ended");

  self notify("updateRecentKills");
  self endon("updateRecentKills");

  if(!isDefined(weapon))
    weapon = "";

  self.recentkillcount++;

  was_aiming = int(self playerads() >= 0.2);

  wait 1.1; // update stack timer to match iw4

  if(self.recentkillcount > 1)
    self maps\mp\_events::multikillevent(killId, self.recentkillcount, weapon, was_aiming);

  self.recentkillcount = 0;
}

killcam_stub(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");

  if(var_1 < 0 || !isDefined(var_13)) {
    return;
  }
  level.numplayerswaitingtoenterkillcam++;
  var_19 = level.numplayerswaitingtoenterkillcam * 0.05;

  if(level.numplayerswaitingtoenterkillcam > 1)
    wait(0.05 * (level.numplayerswaitingtoenterkillcam - 1));

  wait 0.05;
  level.numplayerswaitingtoenterkillcam--;
  var_20 = maps\mp\gametypes\_killcam::killcamtime(var_3, var_4, var_8, var_11, var_12, var_18, level.showingfinalkillcam);

  if(getDvar("scr_killcam_posttime") == "")
    var_21 = 2;
  else {
    var_21 = getdvarfloat("scr_killcam_posttime");

    if(var_21 < 0.05)
      var_21 = 0.05;
  }

  var_22 = var_20 + var_21;

  if(isDefined(var_12) && var_22 > var_12) {
    if(var_12 < 2) {
      return;
    }
    if(var_12 - var_20 >= 1)
      var_21 = var_12 - var_20;
    else {
      var_21 = 1;
      var_20 = var_12 - 1;
    }

    var_22 = var_20 + var_21;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", 0);

  if(isagent(var_13) && !isDefined(var_13.isactive)) {
    return;
  }
  if(isPlayer(var_14))
    self setclientomnvar("ui_killcam_victim_id", var_14 getentitynumber());
  else
    self setclientomnvar("ui_killcam_victim_id", -1);

  if(isPlayer(var_13))
    self setclientomnvar("ui_killcam_killedby_id", var_13 getentitynumber());
  else if(isagent(var_13))
    self setclientomnvar("ui_killcam_killedby_id", -1);

  if(isDefined(level.killstreakwieldweapons[var_4])) {
    self setclientomnvar("ui_killcam_killedby_killstreak", maps\mp\_utility::getkillstreakrownum(level.killstreakwieldweapons[var_4]));
    self setclientomnvar("ui_killcam_killedby_weapon", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_custom", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_alt", 0);
    self setclientomnvar("ui_killcam_copycat", 0);
  } else {
    var_24 = [];
    var_25 = getweaponbasename(var_4);

    if(isDefined(var_25)) {
      if(maps\mp\_utility::ismeleemod(var_15) && !maps\mp\gametypes\_weapons::isriotshield(var_4))
        var_25 = "iw5_combatknife";
      else {
        var_25 = maps\mp\_utility::strip_suffix(var_25, "_lefthand");
        var_25 = maps\mp\_utility::strip_suffix(var_25, "_mp");
      }

      self setclientomnvar("ui_killcam_killedby_weapon", var_5);
      self setclientomnvar("ui_killcam_killedby_weapon_custom", var_6);
      self setclientomnvar("ui_killcam_killedby_weapon_alt", var_7);
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);

      if(var_25 != "iw5_combatknife")
        var_24 = getweaponattachments(var_4);

      if(!level.showingfinalkillcam && (isPlayer(var_13) && !isbot(self) && !isagent(self)) && self maps\mp\_utility::_hasPerk("specialty_copycat")) {
        self setclientomnvar("ui_killcam_copycat", 1);
        thread waitcopycatkillcambutton(var_13);
      } else
        self setclientomnvar("ui_killcam_copycat", 0);
    } else {
      self setclientomnvar("ui_killcam_killedby_weapon", -1);
      self setclientomnvar("ui_killcam_killedby_weapon_custom", -1);
      self setclientomnvar("ui_killcam_killedby_weapon_alt", 0);
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);
      self setclientomnvar("ui_killcam_copycat", 0);
    }
  }

  if(isPlayer(var_14) && var_14.pers["nemesis_guid"] == var_13.guid && var_14.pers["nemesis_tracking"][var_13.guid] >= 2)
    self setclientomnvar("ui_killcam_killedby_nemesis", 1);
  else
    self setclientomnvar("ui_killcam_killedby_nemesis", 0);

  if(!var_11 && !level.gameended)
    self setclientomnvar("ui_killcam_text", "skip");
  else if(!level.gameended)
    self setclientomnvar("ui_killcam_text", "respawn");
  else
    self setclientomnvar("ui_killcam_text", "none");

  switch (var_16) {
    case "score":
      self setclientomnvar("ui_killcam_type", 1);
      break;
    case "normal":
    default:
      self setclientomnvar("ui_killcam_type", 0);
      break;
  }

  var_26 = var_20 + var_8 + var_19;
  var_27 = gettime();
  self notify("begin_killcam", var_27);

  if(!isagent(var_13) && isDefined(var_13) && isPlayer(var_14))
    var_13 visionsyncwithplayer(var_14);

  maps\mp\_utility::updatesessionstate("spectator");
  self.spectatekillcam = 1;

  if(isagent(var_13))
    var_1 = var_14 getentitynumber();

  self onlystreamactiveweapon(0);
  self.forcespectatorclient = var_1;
  self.killcamentity = -1;
  var_28 = maps\mp\gametypes\_killcam::setkillcamerastyle(var_0, var_1, var_2, var_4, var_14, var_20);

  if(!var_28)
    thread maps\mp\gametypes\_killcam::setkillcamentity(var_2, var_26, var_3);

  var_17 = maps\mp\gametypes\_killcam::killcamadjustalivetime(var_17, var_1, var_2);

  if(var_26 > var_17)
    var_26 = var_17;

  self.archivetime = var_26;
  self.killcamlength = var_22;
  self.psoffsettime = var_9;
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(level.multiteambased) {
    foreach(var_30 in level.teamnamelist)
    self allowspectateteam(var_30, 1);
  }

  foreach(var_30 in level.teamnamelist)
  self allowspectateteam(var_30, 1);

  thread maps\mp\gametypes\_killcam::endedkillcamcleanup();
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  var_20 = self.archivetime - 0.05 - var_8;
  var_22 = var_20 + var_21;
  self.killcamlength = var_22;

  if(var_20 <= 0) {
    maps\mp\_utility::updatesessionstate("dead");
    maps\mp\_utility::clearkillcamstate();
    self notify("killcam_ended");
    return;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", int(var_22 * 1000) + gettime());

  if(level.showingfinalkillcam)
    thread maps\mp\gametypes\_killcam::dofinalkillcamfx(var_20, var_2);

  self.killcam = 1;
  thread maps\mp\gametypes\_killcam::spawnedkillcamcleanup();
  self.skippedkillcam = 0;
  self.killcamstartedtimedeciseconds = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();

  if(!level.showingfinalkillcam)
    thread maps\mp\gametypes\_killcam::waitskipkillcambutton(var_10);
  else
    self notify("showing_final_killcam");

  thread maps\mp\gametypes\_killcam::endkillcamifnothingtoshow();
  maps\mp\gametypes\_killcam::waittillkillcamover();

  if(level.showingfinalkillcam) {
    if(self == var_13)
      var_13 maps\mp\gametypes\_missions::processchallenge("ch_moviestar");

    thread maps\mp\gametypes\_playerlogic::spawnendofgame();
    return;
  }

  thread maps\mp\gametypes\_killcam::killcamcleanup(1);
}

waitcopycatkillcambutton(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  self notifyonplayercommand("KillCamCopyCat", "weapnext");
  self waittill("KillCamCopyCat");
  self setclientomnvar("ui_killcam_copycat", 0);
  self playlocalsound("h2_copycat_steal_class");

  var_1 = var_0 maps\mp\gametypes\_class::cloneloadout();

  self.pers["copyCatLoadout"] = var_1;
  self.pers["copyCatLoadout"]["inUse"] = 1;
}

callback_playerconnect_stub() {
  var_0 = getrandomspectatorspawnpoint();
  self setspectatedefaults(var_0.origin, var_0.angles);
  thread notifyconnecting();
  self waittill("begin");
  self.connecttime = gettime();
  level notify("connected", self);
  self.connected = 1;

  if(self ishost())
    level.player = self;

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();

  if(getDvar("r_reflectionProbeGenerate") == "1")
    level waittill("eternity");

  self.guid = self getguid();
  self.xuid = self getxuid();
  self.totallifetime = 0;
  var_1 = 0;

  if(!isDefined(self.pers["clientid"])) {
    if(game["clientid"] >= 30)
      self.pers["clientid"] = getlowestavailableclientid();
    else
      self.pers["clientid"] = game["clientid"];

    if(game["clientid"] < 30)
      game["clientid"]++;

    var_1 = 1;
  }

  if(var_1)
    streamprimaryweapons();

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  self.pers["suicideSpawnDelay"] = 0;

  if(var_1)
    reconevent("script_mp_playerjoin: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());

  logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + sanitise_name(self.name) + "\n");

  if(game["clientid"] <= 30 && game["clientid"] != getmatchdata("playerCount")) {
    var_2 = 0;
    var_3 = 0;

    if(!isai(self) && maps\mp\_utility::matchmakinggame())
      self registerparty(self.clientid);

    setmatchdata("playerCount", game["clientid"]);
    setmatchdata("players", self.clientid, "playerID", "xuid", self getxuid());
    setmatchdata("players", self.clientid, "playerID", "ucdIDHigh", self getucdidhigh());
    setmatchdata("players", self.clientid, "playerID", "ucdIDLow", self getucdidlow());
    setmatchdata("players", self.clientid, "playerID", "clanIDHigh", self getclanidhigh());
    setmatchdata("players", self.clientid, "playerID", "clanIDLow", self getclanidlow());
    setmatchdata("players", self.clientid, "gamertag", truncateplayername(self.name));
    setmatchdata("players", self.clientid, "isBot", isai(self));
    var_4 = self getentitynumber();
    setmatchdata("players", self.clientid, "codeClientNum", maps\mp\_utility::clamptobyte(var_4));
    var_5 = getcodanywherecurrentplatform();
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "connectionIDChunkLow", var_5);
    var_2 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "connectionIDChunkHigh", var_5);
    setmatchdata("players", self.clientid, "connectionIDChunkLow", var_3);
    setmatchdata("players", self.clientid, "connectionIDChunkHigh", var_2);
    setmatchclientip(self, self.clientid);
    setmatchdata("players", self.clientid, "joinType", self getjointype());
    setmatchdata("players", self.clientid, "connectTimeUTC", getsystemtime());
    setmatchdata("players", self.clientid, "isSplitscreen", issplitscreen());
    logplayerconsoleidandonwifiinmatchdata();

    if(self ishost())
      setmatchdata("players", self.clientid, "wasAHost", 1);

    if(maps\mp\_utility::rankingenabled())
      maps\mp\_matchdata::loginitialstats();

    if(istestclient(self) || isai(self))
      var_6 = 1;
    else
      var_6 = 0;

    if(maps\mp\_utility::matchmakinggame() && maps\mp\_utility::allowteamchoice() && !var_6)
      setmatchdata("players", self.clientid, "team", self.sessionteam);

    if(maps\mp\_utility::isaiteamparticipant(self)) {
      if(!isDefined(level.matchdata))
        level.matchdata = [];

      if(!isDefined(level.matchdata["botJoinCount"]))
        level.matchdata["botJoinCount"] = 1;
      else
        level.matchdata["botJoinCount"]++;
    }
  }

  if(!level.teambased)
    game["roundsWon"][self.guid] = 0;

  self.leaderdialogqueue = [];
  self.leaderdialoglocqueue = [];
  self.leaderdialogactive = "";
  self.leaderdialoggroups = [];
  self.leaderdialoggroup = "";

  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
    self.killstreakcount = 0;
    self setclientomnvar("ks_count1", 0);
  }

  if(!isDefined(self.pers["cur_death_streak"]))
    self.pers["cur_death_streak"] = 0;

  if(!isDefined(self.pers["cur_kill_streak_for_nuke"]))
    self.pers["cur_kill_streak_for_nuke"] = 0;

  if(maps\mp\_utility::rankingenabled())
    self.kill_streak = maps\mp\gametypes\_persistence::statget("killStreak");

  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = level.baseplayermovescale;
  self.killstreakscaler = 1;
  self.objectivescaler = 1;
  self.issniper = 0;
  setupsavedactionslots();
  level thread monitorplayersegments(self);
  thread maps\mp\_flashgrenades::monitorflash();
  resetuidvarsonconnect();
  maps\mp\_snd_common_mp::snd_mp_player_join();
  waittillframeend;
  level.players[level.players.size] = self;
  level notify("playerCountChanged");
  maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();
  maps\mp\gametypes\_spawnlogic::addtocharactersarray();

  if(level.teambased)
    self updatescores();

  if(!isDefined(self.pers["absoluteJoinTime"]))
    self.pers["absoluteJoinTime"] = getsystemtime();

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    spawnintermission();
  } else {
    if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"]))
      self thread[[level.bot_funcs["think"]]]();

    level endon("game_ended");

    if(isDefined(level.hostmigrationtimer)) {
      if(!isDefined(self.hostmigrationcontrolsfrozen) || self.hostmigrationcontrolsfrozen == 0) {
        self.hostmigrationcontrolsfrozen = 0;
        thread maps\mp\gametypes\_hostmigration::hostmigrationtimerthink();
      }
    }

    if(isDefined(level.onplayerconnectaudioinit))
      [[level.onplayerconnectaudioinit]]();

    if(!isDefined(self.pers["team"])) {
      if(maps\mp\_utility::matchmakinggame() && self.sessionteam != "none") {
        thread spawnspectator();

        if(isDefined(level.waitingforplayers) && level.waitingforplayers)
          maps\mp\_utility::freezecontrolswrapper(1);

        thread maps\mp\gametypes\_menus::setteam(self.sessionteam);

        if(maps\mp\_utility::allowclasschoice())
          thread setuioptionsmenu(2);

        thread kickifdontspawn();
        return;
      } else if(!maps\mp\_utility::matchmakinggame() && !maps\mp\_utility::forceautoassign() && maps\mp\_utility::allowteamchoice()) {
        maps\mp\gametypes\_menus::menuspectator();
        thread setuioptionsmenu(1);

        if(self ismlgspectator())
          maps\mp\_utility::freezecontrolswrapper(1);
      } else {
        thread spawnspectator();
        self[[level.autoassign]]();

        if(maps\mp\_utility::allowclasschoice())
          thread setuioptionsmenu(2);

        if(maps\mp\_utility::matchmakinggame())
          thread kickifdontspawn();

        return;
      }
    } else {
      maps\mp\gametypes\_menus::addtoteam(self.pers["team"], 1);

      if(maps\mp\_utility::isvalidclass(self.pers["class"]) && !maps\mp\_utility::ishodgepodgeph()) {
        thread spawnclient();
        return;
      }

      thread spawnspectator();

      if(self.pers["team"] == "spectator") {
        if(maps\mp\_utility::allowteamchoice()) {
          maps\mp\gametypes\_menus::beginteamchoice();
          return;
        }

        self[[level.autoassign]]();
        return;
        return;
      }

      maps\mp\gametypes\_menus::beginclasschoice();
    }
  }
}

callback_playerdisconnect_stub(var_0) {
  if(!isDefined(self.connected)) {
    return;
  }
  maps\mp\gametypes\_damage::handlelaststanddisconnect();
  setmatchdata("players", self.clientid, "disconnectTimeUTC", getsystemtime());
  setmatchdata("players", self.clientid, "disconnectReason", var_0);

  if(maps\mp\_utility::rankingenabled())
    maps\mp\_matchdata::logfinalstats();

  if(isDefined(self.pers["confirmed"]))
    maps\mp\_matchdata::logkillsconfirmed();

  if(isDefined(self.pers["denied"]))
    maps\mp\_matchdata::logkillsdenied();

  logplayerstats();

  if(maps\mp\_utility::isroundbased()) {
    var_1 = game["roundsPlayed"] + 1;
    setmatchdata("players", self.clientid, "playerQuitRoundNumber", var_1);

    if(isDefined(self.team) && (self.team == "allies" || self.team == "axis")) {
      if(self.team == "allies") {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", game["roundsWon"]["allies"]);
        setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["roundsWon"]["axis"]);
      } else {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", game["roundsWon"]["axis"]);
        setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["roundsWon"]["allies"]);
      }
    }
  } else if(isDefined(self.team) && (self.team == "allies" || self.team == "axis") && level.teambased) {
    if(self.team == "allies") {
      setmatchdata("players", self.clientid, "playerQuitTeamScore", game["teamScores"]["allies"]);
      setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["teamScores"]["axis"]);
    } else {
      setmatchdata("players", self.clientid, "playerQuitTeamScore", game["teamScores"]["axis"]);
      setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["teamScores"]["allies"]);
    }
  }

  maps\mp\_skill::processplayer();
  removeplayerondisconnect();
  maps\mp\gametypes\_spawnlogic::removefromparticipantsarray();
  maps\mp\gametypes\_spawnlogic::removefromcharactersarray();
  var_2 = self getentitynumber();

  if(!level.teambased)
    game["roundsWon"][self.guid] = undefined;

  if(!level.gameended)
    maps\mp\_utility::logxpgains();

  if(level.splitscreen) {
    var_3 = level.players;

    if(var_3.size <= 1)
      level thread maps\mp\gametypes\_gamelogic::forceend();
  }

  maps\mp\gametypes\_gamelogic::setplayerrank(self);
  reconevent("script_mp_playerquit: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());
  var_4 = self getentitynumber();
  var_5 = self.guid;
  logprint("Q;" + var_5 + ";" + var_4 + ";" + sanitise_name(self.name) + "\n");
  thread maps\mp\_events::disconnected();

  if(level.gameended)
    maps\mp\gametypes\_gamescore::removedisconnectedplayerfromplacement();

  if(isDefined(self.team))
    removefromteamcount();

  if(self.sessionstate == "playing" && !(isDefined(self.fauxdead) && self.fauxdead))
    removefromalivecount(1);
  else if(self.sessionstate == "spectator" || self.sessionstate == "dead")
    level thread maps\mp\gametypes\_gamelogic::updategameevents();
}
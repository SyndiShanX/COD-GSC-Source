/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_jugg_common.gsc
***************************************************/

function init() {
  level.battle_tracks_stopbattletracksforplayer = &ref_13140;
  level.battle_tracks_standingonvehicletimeout = &battle_tracks_standingonvehicletimeout;
  level.headiconbox = &minigun_wait_between_shot_rounds;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateActivate", &ref_1200D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateUse", &ref_1200F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateDestroy", &ref_1200E);
  level thread scripts\mp\gametypes\br_c130airdrop::init();
  level.activejuggernauts = [];
  level.display_hint_for_player = [];
  thread toggleusbstickinhand();
}

function toggleusbstickinhand() {
  waittillframeend();
  terminal_pusher_approaches_init();
  level.ref_11F2C = 0;
}

function ref_13140() {
  self.ref_12173 = 100;
  self.ref_12172 = 3;
  self.ref_12176 = 1;
  self.ref_12175 = 0.5;
  self.ref_12174 = 5;
  self.infiniteammo = 0;
  self.maxhealth = getdvarint("scr_br_jugg_health", 2000);
  self.startinghealth = getdvarint("scr_br_jugg_health", 2000);
  self.ref_14232 = int(self.maxhealth / self.ref_11B7D);
  var_0 = getdvarint("scr_br_jugg_weapon_pickup", 0);
  self.ref_140A7 = var_0;
  var_1 = getdvarint("scr_br_jugg_reload", 1);

  if(var_1) {
    self.classstruct.loadoutprimary = "iw8_minigunksjugg_reload_mp";
    self.ref_14092 = var_1;
  }

  self.allows["reload"] = undefined;
}

function ref_11C95(var_0) {
  var_1 = getdvarfloat("scr_br_jugg_vs_gas_scale", 7);
  var_2 = var_0 * var_1;
  return int(var_2);
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1 scripts\mp\utility\killstreak::isjuggernaut() && getdvarint("scr_jugg_regen_health_on_kill", 1)) {
    var_10 = var_1.health;
    var_11 = int(var_1.maxhealth / 6);
    var_12 = var_10 + var_11;

    if(var_12 > var_1.maxhealth) {
      var_12 = var_1.maxhealth;
    }

    var_1.health = var_12;
    var_1 notify("jugg_health_regen");
  }

  if(isDefined(self) && scripts\mp\utility\killstreak::isjuggernaut()) {
    self.stadium_puzzle = undefined;
    return;
  }
}

function battle_tracks_standingonvehicletimeout() {
  var_0 = self.juggcontext.juggconfig;
  var_1 = getdvarint("scr_br_jugg_overheat", 0);

  if(var_1) {
    thread ref_144EA(var_0);
    thread ref_144DE(var_0);
  }

  thread ref_11AB6(var_0);
}

function minigun_wait_between_shot_rounds() {
  var_0 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_pickups::minplunderextractions(var_0);
  scripts\mp\gametypes\br_pickups::missiontime(var_0);
  scripts\mp\gametypes\br_pickups::mintokensdropondeath(var_0);
  scripts\mp\gametypes\br_pickups::missedinfilplayerhandler(var_0);
  scripts\mp\gametypes\br_pickups::missing_window_blockers(var_0);
  scripts\mp\gametypes\br_pickups::mix_loot_pickups(var_0);
  scripts\mp\gametypes\br_pickups::missions_clearinappropriaterewards(var_0);
  scripts\mp\gametypes\br_pickups::missed_shots(var_0);
  scripts\mp\gametypes\br_pickups::mix(var_0);
  scripts\mp\gametypes\br_pickups::modifycrushdamage(var_0);
}

function terminal_pusher_approaches_init() {
  if(!isDefined(level.calloutglobals.calloutzones) || level.calloutglobals.calloutzones.size == 0) {
    return;
  }

  level.vehicle_isneutraltoplayer = [];
  level.vehicle_occupancy_isenemytoplayer = [];

  foreach(var_1 in level.calloutglobals.calloutzones) {
    var_2 = spawnStruct();
    var_2.id = var_3;
    var_2.origin = var_1.origin;
    var_2.occupied = 0;
    level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var_2;
  }
}

function relic_punchbullets_track_previous_bullet_weapon(var_0) {
  var_1 = undefined;

  if(isDefined(level.vehicle_isneutraltoplayer) && level.vehicle_isneutraltoplayer.size > 0) {
    foreach(var_3 in level.vehicle_isneutraltoplayer) {
      if(!isDefined(level.ref_12D05)) {
        if(!updatesmokinggunhud(var_3, var_0)) {
          continue;
        }
      }

      if(istrue(var_3.occupied)) {
        continue;
      }

      if(update_objective_mlgicon_reset(var_3.origin)) {
        continue;
      }

      if(update_last_stand_id(var_3.origin)) {
        continue;
      }

      if(update_keypad_currentdisplay_models(var_3.origin)) {
        continue;
      }

      var_1 = var_3;
      var_3.occupied = 1;
      level.vehicle_occupancy_isenemytoplayer[level.vehicle_occupancy_isenemytoplayer.size] = var_3;
      break;
    }

    if(!isDefined(var_1)) {
      var_1 = init_season3_intel_challenges();
    }
  } else {
    var_5 = undefined;
    var_1 = init_season3_intel_challenges(var_5);
  }

  return var_1;
}

function updatesmokinggunhud(var_0, var_1) {
  if(level.br_circle_disabled || !isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
    return true;
  }

  var_2 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_3 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_4 = var_3 + var_1;
  var_5 = var_4 * var_4;

  if(distance2dsquared(var_0.origin, var_2) <= var_5) {
    return true;
  }

  return false;
}

function update_last_stand_id(var_0) {
  var_1 = getdvarint("scr_br_jugg_min_dist_crate", 20000);
  var_2 = var_1 * var_1;

  foreach(var_4 in level.focus_fire_attacker_timeout) {
    if(distance2dsquared(var_0, var_4.origin) < var_2) {
      return true;
    }
  }

  return false;
}

function update_keypad_currentdisplay_models(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_2 = int(var_1 - var_1 / 3);
  var_3 = var_2 * var_2;

  foreach(var_5 in level.activejuggernauts) {
    if(isDefined(var_5) && distance2dsquared(var_0, var_5.origin) < var_3) {
      return true;
    }
  }

  return false;
}

function update_objective_mlgicon_reset(var_0) {
  var_1 = getdvarint("scr_br_jugg_circle_size", 5000);
  var_2 = 1000;
  var_3 = var_1 * 2 + var_2;
  var_4 = var_3 * var_3;

  foreach(var_6 in level.vehicle_occupancy_isenemytoplayer) {
    if(distance2dsquared(var_0, var_6.origin) < var_4) {
      return true;
    }
  }

  return false;
}

function init_season3_intel_challenges(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0)) {
    if(istrue(level.ref_14089) && isscriptabledefined()) {
      var_0 = getclosestpointonnavmesh(var_0);
    }

    var_1.origin = var_0;
  } else {
    var_2 = 10;

    while(!isDefined(var_1.origin)) {
      var_3 = scripts\mp\gametypes\br_circle::risk_modifyflagstieronrespawn();

      if(istrue(level.ref_14089) && isscriptabledefined()) {
        var_3 = getclosestpointonnavmesh(var_3);
      }

      if(isDefined(level.activejuggernauts) && level.activejuggernauts.size > 0) {
        if(!update_keypad_currentdisplay_models(var_3)) {
          var_1.origin = var_3;
        }
      } else {
        var_1.origin = var_3;
      }

      var_2--;

      if(var_2 == 0 && !isDefined(var_1.origin)) {
        var_1.origin = var_3;
      }

      waitframe();
    }
  }

  return var_1;
}

function ref_1334B(var_0, var_1) {
  level endon("game_ended");
  var_2 = getdvarint("scr_br_jugg_circle_size", 5000);
  var_3 = 50000;

  if(istrue(var_1)) {
    if(!istrue(level.br_circle_disabled)) {
      level waittill("br_circle_set");
    }
  } else {
    var_3 = 0;
  }

  var_4 = [];

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = relic_punchbullets_track_previous_bullet_weapon(var_3);
    var_6.clear_legacy_pickup_munitions = spawn("script_model", var_6.origin);
    var_6.clear_legacy_pickup_munitions setModel("ks_airdrop_crate_br");
    var_6.clear_legacy_pickup_munitions setscriptablepartstate("jugg_drop_beacon", "on", 0);
    var_6 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, 6, 2, var_6.origin);
    var_6 scripts\mp\gametypes\br_quest_util::ref_1316F(var_2);
    var_6 scripts\mp\gametypes\br_quest_util::ref_13369();
    var_4 = var_6;
  }

  return var_4;
}

function ref_1383F(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\engine\utility::ter_op(istrue(level.ref_1408B), "br_pe_juggernaut_start", "br_juggdrop_incoming");
  scripts\mp\gametypes\br_gametype_dmz::ref_13371(var_2);

  foreach(var_4 in var_0) {
    thread mlgiconfullflag(level, var_4);
    wait randomfloatrange(5, 10);
  }
}

function mlgiconfullflag(var_0, var_1) {
  level endon("game_ended");
  var_2 = getdvarint("scr_br_jugg_circle_size", 5000);

  if(!isDefined(var_0.modify_blast_shield_damage)) {
    var_0.modify_blast_shield_damage = var_2;
  }

  var_3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_0.origin, var_0.modify_blast_shield_damage);
  var_4 = scripts\mp\gametypes\br_c130airdrop::fn_spec_op_post_customization(undefined, var_3, 1);
  var_5 = distance(var_4.startpt, var_4.endpt);
  var_6 = scripts\mp\gametypes\br_c130::getc130speed();
  var_7 = var_5 / var_6;
  var_8 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var_4, var_5, var_6, var_7);
  var_8.mode_can_play_ending = &mode_can_play_ending;
  var_8.ref_134E2 = var_1;
  var_8 scripts\mp\gametypes\br_c130airdrop::fob(1, "battle_royale_juggernaut", "jugg_world", var_0);
}

function mode_can_play_ending(var_0, var_1, var_2, var_3) {
  var_4 = self.startpt;
  var_5 = self.centerpt;
  var_6 = self.speed;
  var_7 = distance2d(var_4, var_5) / var_6;
  var_8 = 0;
  var_9 = 0;
  level.ref_11F2C += var_0;

  while(var_8 < var_0) {
    wait var_7;
    var_10 = scripts\mp\gametypes\br_c130airdrop::fnchildscorefunc(self.origin, 1);

    if(istrue(level.ref_14089) && isscriptabledefined()) {
      var_10 = getclosestpointonnavmesh(var_10);
    }

    var_11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_10 + (0, 0, level.fnhidefoundintel - 100), var_10, self.angles, var_1, var_2, var_3.ref_11EAB);
    var_8++;
    var_11.ml_p2_func = var_3;
    var_11.ref_134E2 = self.ref_134E2;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var_11;
    var_12 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_11);
    var_12.ref_140A0 = relic_laststand_modifyplayerdamage();
  }
}

function ref_144EA(var_0) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var_1 = var_0.ref_12173;
  var_2 = var_0.ref_12172;
  var_0.showtutsplash = 0;

  for(;;) {
    self waittill("weapon_fired");
    var_0.showtutsplash++;
    var_0.waittorumbleonslam = gettime();

    if(var_0.showtutsplash >= var_1) {
      iprintlnbold("OVERHEAT");
      scripts\common\utility::allow_fire(0);
      wait var_2;
      iprintlnbold("COOLDOWN");
      scripts\common\utility::allow_fire(1);
    }
  }
}

function ref_144DE(var_0) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var_1 = var_0.ref_12176;
  var_2 = var_0.ref_12175;
  var_3 = var_0.ref_12174;

  for(;;) {
    if(var_0.showtutsplash > 0 && gettime() - var_0.waittorumbleonslam >= var_1 * 1000) {
      var_4 = var_0.showtutsplash - var_2;

      if(var_4 < 0) {
        var_4 = 0;
      }

      var_0.showtutsplash = int(var_4);
    }

    wait 0.05;
  }
}

function ref_11AB6(var_0) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var_1 = 5;

  for(;;) {
    var_2 = scripts\engine\utility::ref_143AD("deaths_door_enter", "jugg_health_regen");
    var_3 = 1;

    if(var_2 == "deaths_door_enter") {
      var_3 = 0;
      self.stadium_puzzle = 1;
      wait var_1;
    } else if(var_2 == "jugg_health_regen") {
      var_4 = self.health / self.maxhealth;

      if(var_4 >= 0.75) {
        if(istrue(self.stadium_puzzle)) {
          self.stadium_puzzle = undefined;
        }
      }
    }

    scripts\mp\healthoverlay::onexitdeathsdoor(var_3);
  }
}

function droponplayerdeath(var_0) {
  scripts\mp\gametypes\br_gametypes::ref_12E05("onJuggDropOnDeath", var_0);
  level.ref_11F2C--;
}

function modeaddtoteamlives() {
  var_0 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  var_1 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 40), self.origin - (0, 0, 10000), self, var_0);
  var_2 = self.origin;

  if(isDefined(var_1) && isDefined(var_1["hittype"]) && var_1["hittype"] != "hittype_none") {
    var_2 = var_1["position"];
  }

  var_3 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(self.origin + (0, 0, 10), var_2, self.angles, "battle_royale_juggernaut", "jugg_world");

  if(isDefined(var_3)) {
    var_4 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_3);
    var_4.ref_140A0 = relic_laststand_modifyplayerdamage();
    return;
  }
}

function ref_1200D(var_0) {
  scripts\mp\gametypes\br_gametypes::ref_12E05("onJuggCrateActivate", var_0);

  if(istrue(var_0)) {
    thread ref_14498();
    thread ref_14497();
  }

  var_1 = getdvarint("scr_br_pe_keep_jugg_crate_vfx_until_opened", 0) == 1;

  if(!var_1 && isDefined(self.ml_p2_func)) {
    infilvideopreload(self.ml_p2_func);
    return;
  }
}

function ref_14498() {
  self endon("death");
  var_0 = getdvarint("scr_br_jugg_crate_lifetime", 300);
  wait var_0;
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

function ref_14497() {
  self endon("death");

  if(istrue(level.br_circle_disabled)) {
    return;
  }

  var_0 = getdvarint("scr_br_jugg_crate_gas_lifetime", 30);

  for(;;) {
    wait 0.05;

    if(!isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
      continue;
    }

    var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

    if(distance2dsquared(var_1, self.origin) > var_2 * var_2) {
      break;
    }
  }

  wait var_0;
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

function ref_1200F(var_0) {
  var_0.vehicle_handleflarefire = self.ref_134E2;
  scripts\mp\gametypes\br_gametypes::ref_12E05("onJuggCrateUse", var_0);
  ref_11ECB(var_0);
  infilvideoplay();
}

function ref_11ECB(var_0) {
  var_1 = self.origin;
  var_2 = getdvarint("scr_br_jugg_circle_size", 5000);
  var_3 = scripts\common\utility::playersincylinder(var_1, var_2);

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && scripts\mp\utility\player::isreallyalive(var_5) && var_5 != var_0) {
      var_6 = "br_jugg_capture_positive";

      if(var_5.team != var_0.team) {
        var_6 = "br_jugg_capture_negative";
      }

      var_5 playlocalsound(var_6);
    }
  }
}

function ref_1200E(var_0) {
  scripts\mp\gametypes\br_gametypes::ref_12E05("onJuggCrateDestroy", var_0);
  level.ref_11F2C--;
  infilvideoplay();
}

function infilvideoplay() {
  if(isDefined(self.ml_p2_func)) {
    infilvideopreload(self.ml_p2_func);
  }

  if(isDefined(level.focus_fire_attacker_timeout)) {
    level.focus_fire_attacker_timeout = scripts\engine\utility::array_remove(level.focus_fire_attacker_timeout, self);
    return;
  }
}

function infilvideopreload(var_0) {
  var_0.occupied = 0;

  if(isDefined(var_0.mapcircle)) {
    var_0 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }

  if(isDefined(var_0.clear_legacy_pickup_munitions)) {
    var_0.clear_legacy_pickup_munitions setscriptablepartstate("jugg_drop_beacon", "off");
    var_0.clear_legacy_pickup_munitions delete();
    return;
  }
}

function strafe_internal(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  if(!isDefined(level.display_hint_for_player[var_2])) {
    level.display_hint_for_player[var_2] = [];
  }

  level.display_hint_for_player[var_2][var_0] = var_1;
}

function process_struct_path_tilts(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    if(isDefined(level.display_hint_for_player[var_1])) {
      var_2 = level.display_hint_for_player[var_1][var_0];
    }
  }

  if(!isDefined(var_2)) {
    var_2 = level.display_hint_for_player["default"][var_0];
  }

  return var_2;
}

function relic_laststand_modifyplayerdamage() {
  return getdvarfloat("scr_br_jugg_crate_use_time", 5);
}

function resetafkchecks(var_0) {
  if(istrue(var_0)) {
    var_1 = scripts\mp\utility\teams::resetchallengetimer();
    var_2 = getdvarint("scr_br_jugg_num_teams_per_drop", 3);
    var_3 = 1;
    var_4 = max(floor(var_1 / var_2), var_3);
    var_5 = getdvarint("scr_br_jugg_num_drops", 3);
    return min(var_5, var_4);
  }

  return getdvarint("scr_br_jugg_num_drops", 3);
}

function remove_spawners_that_can_be_seen() {
  return getdvarfloat("scr_br_jugg_vs_jugg_scale", 1);
}

function reservedplacement() {
  return getdvarfloat("scr_br_jugg_minigun_scale", 1.25);
}
/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_jugg_common.gsc
***************************************************/

function init() {
  level.battle_tracks_stopbattletracksforplayer = &ref_13140;
  level.battle_tracks_standingonvehicletimeout = &battle_tracks_standingonvehicletimeout;
  level.headiconbox = &minigun_wait_between_shot_rounds;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateActivate", &ref_1200d);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateUse", &ref_1200f);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateDestroy", &ref_1200e);
  level thread scripts\mp\gametypes\br_c130airdrop::init();
  level.activejuggernauts = [];
  level.display_hint_for_player = [];
  thread toggleusbstickinhand();
}

function toggleusbstickinhand() {
  waittillframeend();
  terminal_pusher_approaches_init();
  level.ref_11f2c = 0;
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
  self.ref_14232 = int(self.maxhealth / self.ref_11b7d);
  var0 = getdvarint("scr_br_jugg_weapon_pickup", 0);
  self.ref_140a7 = var0;
  var1 = getdvarint("scr_br_jugg_reload", 1);

  if(var1) {
    self.classstruct.loadoutprimary = "iw8_minigunksjugg_reload_mp";
    self.ref_14092 = var1;
  }

  self.allows["reload"] = undefined;
}

function ref_11c95(var0) {
  var1 = getdvarfloat("scr_br_jugg_vs_gas_scale", 7);
  var2 = var0 * var1;
  return int(var2);
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1) && isPlayer(var1) && var1 scripts\mp\utility\killstreak::isjuggernaut() && getdvarint("scr_jugg_regen_health_on_kill", 1)) {
    var10 = var1.health;
    var11 = int(var1.maxhealth / 6);
    var12 = var10 + var11;

    if(var12 > var1.maxhealth) {
      var12 = var1.maxhealth;
    }

    var1.health = var12;
    var1 notify("jugg_health_regen");
  }

  if(isDefined(self) && scripts\mp\utility\killstreak::isjuggernaut()) {
    self.stadium_puzzle = undefined;
    return;
  }
}

function battle_tracks_standingonvehicletimeout() {
  var0 = self.juggcontext.juggconfig;
  var1 = getdvarint("scr_br_jugg_overheat", 0);

  if(var1) {
    thread ref_144ea(var0);
    thread ref_144de(var0);
  }

  thread ref_11ab6(var0);
}

function minigun_wait_between_shot_rounds() {
  var0 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  scripts\mp\gametypes\br_pickups::minplunderextractions(var0);
  scripts\mp\gametypes\br_pickups::missiontime(var0);
  scripts\mp\gametypes\br_pickups::mintokensdropondeath(var0);
  scripts\mp\gametypes\br_pickups::missedinfilplayerhandler(var0);
  scripts\mp\gametypes\br_pickups::missing_window_blockers(var0);
  scripts\mp\gametypes\br_pickups::mix_loot_pickups(var0);
  scripts\mp\gametypes\br_pickups::missions_clearinappropriaterewards(var0);
  scripts\mp\gametypes\br_pickups::missed_shots(var0);
  scripts\mp\gametypes\br_pickups::mix(var0);
  scripts\mp\gametypes\br_pickups::modifycrushdamage(var0);
}

function terminal_pusher_approaches_init() {
  if(!isDefined(level.calloutglobals.calloutzones) || level.calloutglobals.calloutzones.size == 0) {
    return;
  }

  level.vehicle_isneutraltoplayer = [];
  level.vehicle_occupancy_isenemytoplayer = [];

  foreach(var1 in level.calloutglobals.calloutzones) {
    var2 = spawnStruct();
    var2.id = var3;
    var2.origin = var1.origin;
    var2.occupied = 0;
    level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var2;
  }
}

function relic_punchbullets_track_previous_bullet_weapon(var0) {
  var1 = undefined;

  if(isDefined(level.vehicle_isneutraltoplayer) && level.vehicle_isneutraltoplayer.size > 0) {
    foreach(var3 in level.vehicle_isneutraltoplayer) {
      if(!isDefined(level.ref_12d05)) {
        if(!updatesmokinggunhud(var3, var0)) {
          continue;
        }
      }

      if(istrue(var3.occupied)) {
        continue;
      }

      if(update_objective_mlgicon_reset(var3.origin)) {
        continue;
      }

      if(update_last_stand_id(var3.origin)) {
        continue;
      }

      if(update_keypad_currentdisplay_models(var3.origin)) {
        continue;
      }

      var1 = var3;
      var3.occupied = 1;
      level.vehicle_occupancy_isenemytoplayer[level.vehicle_occupancy_isenemytoplayer.size] = var3;
      break;
    }

    if(!isDefined(var1)) {
      var1 = init_season3_intel_challenges();
    }
  } else {
    var5 = undefined;
    var1 = init_season3_intel_challenges(var5);
  }

  return var1;
}

function updatesmokinggunhud(var0, var1) {
  if(level.br_circle_disabled || !isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
    return true;
  }

  var2 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var3 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var4 = var3 + var1;
  var5 = var4 * var4;

  if(distance2dsquared(var0.origin, var2) <= var5) {
    return true;
  }

  return false;
}

function update_last_stand_id(var0) {
  var1 = getdvarint("scr_br_jugg_min_dist_crate", 20000);
  var2 = var1 * var1;

  foreach(var4 in level.focus_fire_attacker_timeout) {
    if(distance2dsquared(var0, var4.origin) < var2) {
      return true;
    }
  }

  return false;
}

function update_keypad_currentdisplay_models(var0) {
  var1 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var2 = int(var1 - var1 / 3);
  var3 = var2 * var2;

  foreach(var5 in level.activejuggernauts) {
    if(isDefined(var5) && distance2dsquared(var0, var5.origin) < var3) {
      return true;
    }
  }

  return false;
}

function update_objective_mlgicon_reset(var0) {
  var1 = getdvarint("scr_br_jugg_circle_size", 5000);
  var2 = 1000;
  var3 = var1 * 2 + var2;
  var4 = var3 * var3;

  foreach(var6 in level.vehicle_occupancy_isenemytoplayer) {
    if(distance2dsquared(var0, var6.origin) < var4) {
      return true;
    }
  }

  return false;
}

function init_season3_intel_challenges(var0) {
  var1 = spawnStruct();

  if(isDefined(var0)) {
    if(istrue(level.ref_14089) && isscriptabledefined()) {
      var0 = getclosestpointonnavmesh(var0);
    }

    var1.origin = var0;
  } else {
    var2 = 10;

    while(!isDefined(var1.origin)) {
      var3 = scripts\mp\gametypes\br_circle::risk_modifyflagstieronrespawn();

      if(istrue(level.ref_14089) && isscriptabledefined()) {
        var3 = getclosestpointonnavmesh(var3);
      }

      if(isDefined(level.activejuggernauts) && level.activejuggernauts.size > 0) {
        if(!update_keypad_currentdisplay_models(var3)) {
          var1.origin = var3;
        }
      } else {
        var1.origin = var3;
      }

      var2--;

      if(var2 == 0 && !isDefined(var1.origin)) {
        var1.origin = var3;
      }

      waitframe();
    }
  }

  return var1;
}

function ref_1334b(var0, var1) {
  level endon("game_ended");
  var2 = getdvarint("scr_br_jugg_circle_size", 5000);
  var3 = 50000;

  if(istrue(var1)) {
    if(!istrue(level.br_circle_disabled)) {
      level waittill("br_circle_set");
    }
  } else {
    var3 = 0;
  }

  var4 = [];

  for(var5 = 0; var5 < var0; var5++) {
    var6 = relic_punchbullets_track_previous_bullet_weapon(var3);
    var6.clear_legacy_pickup_munitions = spawn("script_model", var6.origin);
    var6.clear_legacy_pickup_munitions setModel("ks_airdrop_crate_br");
    var6.clear_legacy_pickup_munitions setscriptablepartstate("jugg_drop_beacon", "on", 0);
    var6 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, 6, 2, var6.origin);
    var6 scripts\mp\gametypes\br_quest_util::ref_1316f(var2);
    var6 scripts\mp\gametypes\br_quest_util::ref_13369();
    var4 = var6;
  }

  return var4;
}

function ref_1383f(var0, var1) {
  level endon("game_ended");
  var2 = scripts\engine\utility::ter_op(istrue(level.ref_1408b), "br_pe_juggernaut_start", "br_juggdrop_incoming");
  scripts\mp\gametypes\br_gametype_dmz::ref_13371(var2);

  foreach(var4 in var0) {
    thread mlgiconfullflag(level, var4);
    wait randomfloatrange(5, 10);
  }
}

function mlgiconfullflag(var0, var1) {
  level endon("game_ended");
  var2 = getdvarint("scr_br_jugg_circle_size", 5000);

  if(!isDefined(var0.modify_blast_shield_damage)) {
    var0.modify_blast_shield_damage = var2;
  }

  var3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var0.origin, var0.modify_blast_shield_damage);
  var4 = scripts\mp\gametypes\br_c130airdrop::fn_spec_op_post_customization(undefined, var3, 1);
  var5 = distance(var4.startpt, var4.endpt);
  var6 = scripts\mp\gametypes\br_c130::getc130speed();
  var7 = var5 / var6;
  var8 = scripts\mp\gametypes\br_c130airdrop::fntrapdeactivation(var4, var5, var6, var7);
  var8.mode_can_play_ending = &mode_can_play_ending;
  var8.ref_134e2 = var1;
  var8 scripts\mp\gametypes\br_c130airdrop::fob(1, "battle_royale_juggernaut", "jugg_world", var0);
}

function mode_can_play_ending(var0, var1, var2, var3) {
  var4 = self.startpt;
  var5 = self.centerpt;
  var6 = self.speed;
  var7 = distance2d(var4, var5) / var6;
  var8 = 0;
  var9 = 0;
  level.ref_11f2c += var0;

  while(var8 < var0) {
    wait var7;
    var10 = scripts\mp\gametypes\br_c130airdrop::fnchildscorefunc(self.origin, 1);

    if(istrue(level.ref_14089) && isscriptabledefined()) {
      var10 = getclosestpointonnavmesh(var10);
    }

    var11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var10 + (0, 0, level.fnhidefoundintel - 100), var10, self.angles, var1, var2, var3.ref_11eab);
    var8++;
    var11.ml_p2_func = var3;
    var11.ref_134e2 = self.ref_134e2;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var11;
    var12 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var11);
    var12.ref_140a0 = relic_laststand_modifyplayerdamage();
  }
}

function ref_144ea(var0) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var1 = var0.ref_12173;
  var2 = var0.ref_12172;
  var0.showtutsplash = 0;

  for(;;) {
    self waittill("weapon_fired");
    var0.showtutsplash++;
    var0.waittorumbleonslam = gettime();

    if(var0.showtutsplash >= var1) {
      iprintlnbold("OVERHEAT");
      scripts\common\utility::allow_fire(0);
      wait var2;
      iprintlnbold("COOLDOWN");
      scripts\common\utility::allow_fire(1);
    }
  }
}

function ref_144de(var0) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var1 = var0.ref_12176;
  var2 = var0.ref_12175;
  var3 = var0.ref_12174;

  for(;;) {
    if(var0.showtutsplash > 0 && gettime() - var0.waittorumbleonslam >= var1 * 1000) {
      var4 = var0.showtutsplash - var2;

      if(var4 < 0) {
        var4 = 0;
      }

      var0.showtutsplash = int(var4);
    }

    wait 0.05;
  }
}

function ref_11ab6(var0) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var1 = 5;

  for(;;) {
    var2 = scripts\engine\utility::ref_143ad("deaths_door_enter", "jugg_health_regen");
    var3 = 1;

    if(var2 == "deaths_door_enter") {
      var3 = 0;
      self.stadium_puzzle = 1;
      wait var1;
    } else if(var2 == "jugg_health_regen") {
      var4 = self.health / self.maxhealth;

      if(var4 >= 0.75) {
        if(istrue(self.stadium_puzzle)) {
          self.stadium_puzzle = undefined;
        }
      }
    }

    scripts\mp\healthoverlay::onexitdeathsdoor(var3);
  }
}

function droponplayerdeath(var0) {
  scripts\mp\gametypes\br_gametypes::ref_12e05("onJuggDropOnDeath", var0);
  level.ref_11f2c--;
}

function modeaddtoteamlives() {
  var0 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  var1 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 40), self.origin - (0, 0, 10000), self, var0);
  var2 = self.origin;

  if(isDefined(var1) && isDefined(var1["hittype"]) && var1["hittype"] != "hittype_none") {
    var2 = var1["position"];
  }

  var3 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(self.origin + (0, 0, 10), var2, self.angles, "battle_royale_juggernaut", "jugg_world");

  if(isDefined(var3)) {
    var4 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var3);
    var4.ref_140a0 = relic_laststand_modifyplayerdamage();
    return;
  }
}

function ref_1200d(var0) {
  scripts\mp\gametypes\br_gametypes::ref_12e05("onJuggCrateActivate", var0);

  if(istrue(var0)) {
    thread ref_14498();
    thread ref_14497();
  }

  var1 = getdvarint("scr_br_pe_keep_jugg_crate_vfx_until_opened", 0) == 1;

  if(!var1 && isDefined(self.ml_p2_func)) {
    infilvideopreload(self.ml_p2_func);
    return;
  }
}

function ref_14498() {
  self endon("death");
  var0 = getdvarint("scr_br_jugg_crate_lifetime", 300);
  wait var0;
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

function ref_14497() {
  self endon("death");

  if(istrue(level.br_circle_disabled)) {
    return;
  }

  var0 = getdvarint("scr_br_jugg_crate_gas_lifetime", 30);

  for(;;) {
    wait 0.05;

    if(!isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
      continue;
    }

    var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

    if(distance2dsquared(var1, self.origin) > var2 * var2) {
      break;
    }
  }

  wait var0;
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

function ref_1200f(var0) {
  var0.vehicle_handleflarefire = self.ref_134e2;
  scripts\mp\gametypes\br_gametypes::ref_12e05("onJuggCrateUse", var0);
  ref_11ecb(var0);
  infilvideoplay();
}

function ref_11ecb(var0) {
  var1 = self.origin;
  var2 = getdvarint("scr_br_jugg_circle_size", 5000);
  var3 = scripts\common\utility::playersincylinder(var1, var2);

  foreach(var5 in var3) {
    if(isDefined(var5) && scripts\mp\utility\player::isreallyalive(var5) && var5 != var0) {
      var6 = "br_jugg_capture_positive";

      if(var5.team != var0.team) {
        var6 = "br_jugg_capture_negative";
      }

      var5 playlocalsound(var6);
    }
  }
}

function ref_1200e(var0) {
  scripts\mp\gametypes\br_gametypes::ref_12e05("onJuggCrateDestroy", var0);
  level.ref_11f2c--;
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

function infilvideopreload(var0) {
  var0.occupied = 0;

  if(isDefined(var0.mapcircle)) {
    var0 scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }

  if(isDefined(var0.clear_legacy_pickup_munitions)) {
    var0.clear_legacy_pickup_munitions setscriptablepartstate("jugg_drop_beacon", "off");
    var0.clear_legacy_pickup_munitions delete();
    return;
  }
}

function strafe_internal(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "default";
  }

  if(!isDefined(level.display_hint_for_player[var2])) {
    level.display_hint_for_player[var2] = [];
  }

  level.display_hint_for_player[var2][var0] = var1;
}

function process_struct_path_tilts(var0, var1) {
  var2 = undefined;

  if(isDefined(var1)) {
    if(isDefined(level.display_hint_for_player[var1])) {
      var2 = level.display_hint_for_player[var1][var0];
    }
  }

  if(!isDefined(var2)) {
    var2 = level.display_hint_for_player["default"][var0];
  }

  return var2;
}

function relic_laststand_modifyplayerdamage() {
  return getdvarfloat("scr_br_jugg_crate_use_time", 5);
}

function resetafkchecks(var0) {
  if(istrue(var0)) {
    var1 = scripts\mp\utility\teams::resetchallengetimer();
    var2 = getdvarint("scr_br_jugg_num_teams_per_drop", 3);
    var3 = 1;
    var4 = max(floor(var1 / var2), var3);
    var5 = getdvarint("scr_br_jugg_num_drops", 3);
    return min(var5, var4);
  }

  return getdvarint("scr_br_jugg_num_drops", 3);
}

function remove_spawners_that_can_be_seen() {
  return getdvarfloat("scr_br_jugg_vs_jugg_scale", 1);
}

function reservedplacement() {
  return getdvarfloat("scr_br_jugg_minigun_scale", 1.25);
}
/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_challenges.gsc
**************************************************/

function init() {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  level.br_challengeevaluatorfunc = &getallspawninstances;
  ref_12B14("br_mastery_fiveContracts", &player_equipment_init);
  ref_12B14("br_mastery_pointBlank_airstrike", &ref_127DB);
  ref_12B14("br_mastery_pointBlank_tomahawk", &ref_127DC);
  ref_12B14("br_mastery_c4VehicleMultKill", &force_dismount);
  ref_12B14("br_mastery_ghostRideWhip", &scavenger_vo_when_close);
  ref_12B14("br_mastery_roundKillExecute", &ref_12DB8);
  ref_12B14("br_mastery_travelogue", &ref_13D08);
}

function ref_12B14(var_0, var_1) {
  if(!isDefined(level.debugprintteams)) {
    level.debugprintteams = [];
  }

  level.debugprintteams[var_0] = var_1;
}

function getallspawninstances(var_0, var_1) {
  if(!isDefined(level.debugprintteams)) {
    return;
  }

  if(istrue(level.getarenapickupattachmentoverrides)) {
    return;
  }

  var_2 = level.debugprintteams[var_0];

  if(isDefined(var_2)) {
    self thread[[var_2]](var_0, var_1);
    return;
  }
}

function cheesewedgeprompt(var_0) {
  if(getdvarint("scr_br_challenge_debug", 0)) {
    iprintlnbold("Mastery Challenge: " + var_0 + " completed!");
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12004(var_0);
}

function ref_11B1D(var_0) {
  if(!isDefined(level.teamdata[var_0])) {
    return;
  }

  foreach(var_2 in level.teamdata[var_0]["players"]) {
    ref_13D07(var_2);
  }

  if(getdvarint("scr_br_core_trios_or_quads", 0)) {
    ref_13F74(var_0);
    ref_11E54(var_0);
    return;
  }
}

function ref_13F74(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = 0;
  var_2 = 0;
  var_3 = max(1, level.maxteamsize);

  foreach(var_5 in level.teamdata[var_0]["players"]) {
    var_1 += var_5.deaths;

    if(isDefined(var_5.ref_11BE1)) {
      var_1 += var_5.ref_11BE1;
    }

    if(scripts\mp\utility\player::isreallyalive(var_5)) {
      var_2++;
    }
  }

  if(var_1 == 0) {
    foreach(var_5 in level.teamdata[var_0]["players"]) {
      cheesewedgeprompt(var_5, "br_mastery_untouchable");
    }

    return;
  }
}

function ref_11E53() {
  if(!isDefined(self) || !isDefined(self.team)) {
    return;
  }

  var_0 = self.deaths;
  var_1 = self.team;

  foreach(var_3 in level.teamdata[var_1]["players"]) {
    if(scripts\mp\utility\player::isreallyalive(var_3)) {
      if(!isDefined(var_3.ref_11BE1)) {
        var_3.ref_11BE1 = 0;
      }

      var_3.ref_11BE1 += var_0;
      break;
    }
  }
}

function ref_11E54(var_0) {
  var_1 = 7;

  if(!isDefined(var_0)) {
    return;
  }

  if(scripts\mp\gametypes\br::usingtacmap()) {
    return;
  }

  var_2 = 0;

  foreach(var_4 in level.teamdata[var_0]["players"]) {
    var_2 += var_4.deaths;

    if(isDefined(var_4.ref_11BE1)) {
      var_2 += var_4.ref_11BE1;
    }
  }

  if(var_2 >= var_1) {
    foreach(var_4 in level.teamdata[var_0]["players"]) {
      cheesewedgeprompt(var_4, "br_mastery_neverSayDie");
    }

    return;
  }
}

function player_equipment_init(var_0, var_1) {
  if(!isDefined(self.team)) {
    return;
  }

  if(scripts\mp\gametypes\br::get_int_or_0(self.egress_landlord_vo) < 5) {
    return;
  }

  var_2 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  foreach(var_4 in level.teamdata[self.team]["players"]) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      return;
    }

    if(var_2 && var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      return;
    }
  }

  cheesewedgeprompt(var_0);
}

function ref_127DB(var_0, var_1) {
  var_2 = var_1.ref_123A1;
  var_3 = var_1.ref_13A8A;

  if(!isDefined(var_2) || !isDefined(var_2.brbonusxpallowed) || !isDefined(var_2.streakinfo) || !isDefined(var_3)) {
    return;
  }

  var_4 = var_2.streakinfo;

  if(distancesquared(self.origin, var_3) > squared(432)) {
    return;
  }

  self endon("death_or_disconnect");
  self notify("pointBlank_airstrike_killtracker");
  self endon("pointBlank_airstrike_killtracker");
  scripts\engine\utility::ref_143B9(10, "airstrike_finished_" + var_2.brbonusxpallowed);

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  if(var_4.kills >= 3) {
    cheesewedgeprompt("br_mastery_pointBlankStreakKill");
    return;
  }
}

function ref_127DC(var_0, var_1) {
  var_2 = var_1.streakinfo;
  var_3 = var_1.ref_13A8A;

  if(!isDefined(var_2)) {
    return;
  }

  if(!isDefined(var_3)) {
    return;
  }

  if(distancesquared(self.origin, var_3) > squared(432)) {
    return;
  }

  self endon("death_or_disconnect");
  self notify("pointBlank_tomahawk_killtracker");
  self endon("pointBlank_tomahawk_killtracker");
  scripts\engine\utility::ref_143BA(20, "cluster_strike_finished");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  if(var_2.kills >= 3) {
    cheesewedgeprompt("br_mastery_pointBlankStreakKill");
  }
}

function force_dismount(var_0, var_1) {
  var_2 = var_1.meansofdeath;
  var_3 = var_1.inflictor;

  if(!isDefined(var_2) || var_2 != "MOD_EXPLOSIVE") {
    return;
  }

  if(!vandalize_attack_nodes(var_3)) {
    return;
  }

  self endon("disconnect");
  level endon("game_ended");
  self notify("updateC4VehicleMultKill");
  self endon("updateC4VehicleMultKill");

  if(!isDefined(self.ref_12A83)) {
    self.ref_12A83 = 0;
  }

  self.ref_12A83++;
  wait 4;

  if(isDefined(self.ref_12A83) && self.ref_12A83 >= 3) {
    cheesewedgeprompt(var_0);
    var_4 = force_call_lz(var_3);
    var_5 = isDefined(var_4) && isDefined(var_4.team) && isDefined(self.team) && var_4.team == self.team;

    if(var_5) {
      cheesewedgeprompt(var_4, var_0);
    }
  }

  self.ref_12A83 = undefined;
}

function vandalize_attack_nodes(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_0.vehiclename) && !var_0 scripts\common\vehicle_code::vehicle_is_stopped()) {
    var_1 = var_0 getlinkedchildren();

    foreach(var_3 in var_1) {
      if(isDefined(var_3.weapon_name) && var_3.weapon_name == "c4_mp_p") {
        return true;
      }
    }
  } else if(isDefined(var_0.weapon_name) && var_0.weapon_name == "c4_mp_p") {
    var_5 = var_0 getlinkedparent();

    if(isDefined(var_5) && isDefined(var_5.vehiclename) && !var_5 scripts\common\vehicle_code::vehicle_is_stopped()) {
      return true;
    }
  }

  return false;
}

function force_call_lz(var_0) {
  if(isDefined(var_0) && isDefined(var_0.weapon_name) && var_0.weapon_name == "c4_mp_p") {
    var_1 = var_0 getlinkedparent();

    if(isDefined(var_1)) {
      return var_1.owner;
    }
  }

  return undefined;
}

function ref_12DB8(var_0, var_1) {
  var_2 = var_1.player;

  if(!isDefined(var_2)) {
    return;
  }

  if(isDefined(var_2.modifiers["execution"]) && var_2.modifiers["execution"] == 1) {
    cheesewedgeprompt(var_2, "br_mastery_roundKillExecute");
    return;
  }
}

function scavenger_vo_when_close(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  var_2 = var_1.onplayerkillednew;
  var_3 = var_1.ref_11A6C;

  if(istrue(var_2)) {
    if(istrue(self.should_run_sp_stealth) && self.ref_12A84 != 0) {
      return;
    }

    self.should_run_sp_stealth = 1;
  }

  if(!istrue(self.should_run_sp_stealth)) {
    return;
  }

  self notify("ghostRideWhip");
  self endon("ghostRideWhip");

  if(!isDefined(self.ref_12A84)) {
    self.ref_12A84 = 0;
  }

  if(istrue(var_3)) {
    self.ref_12A84++;
  }

  wait 4;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.ref_12A84) && self.ref_12A84 >= 3) {
    cheesewedgeprompt(var_0);
  }

  self.ref_12A84 = undefined;
  self.should_run_sp_stealth = undefined;
}

function ref_13D08(var_0, var_1) {
  var_2 = -1;

  if(getdvarint("scr_br_core_trios_or_quads", 0) == 0) {
    return;
  }

  var_3 = var_1.inflictor;

  if(!isDefined(var_3)) {
    return;
  }

  if(!isPlayer(var_3)) {
    if(isDefined(var_3.owner) && isPlayer(var_3.owner)) {
      var_3 = var_3.owner;
    } else {
      return;
    }
  }

  var_4 = var_1.victim;

  if(!isDefined(var_4) || !isPlayer(var_4)) {
    return;
  }

  var_5 = 0;
  var_6 = var_3 scripts\mp\gametypes\br_callouts::removematchingents_bymodel(var_3);

  if(var_6 != var_2) {
    var_5 |= 1 << var_6;
  }

  var_6 = var_4 scripts\mp\gametypes\br_callouts::removematchingents_bymodel(var_4);

  if(var_6 != var_2) {
    var_5 |= 1 << var_6;
  }

  if(var_5 == 0) {
    return;
  }

  foreach(var_8 in level.teamdata[var_3.team]["players"]) {
    if(!isDefined(var_8.ref_14727)) {
      var_8.ref_14727 = 0;
    }

    var_8.ref_14727 |= var_5;
  }
}

function ref_13D07(var_0) {
  var_1 = 12;

  if(!isDefined(var_0.ref_14727) || var_0.ref_14727 == 0) {
    return;
  }

  var_2 = 0;

  for(var_3 = 0; var_3 < level.calloutglobals.ref_11E29.size; var_3++) {
    var_4 = var_0.ref_14727 & 1 << var_3;

    if(var_4) {
      var_2++;
    }
  }

  if(var_2 >= var_1) {
    cheesewedgeprompt(var_0, "br_mastery_travelogue");
  }
}
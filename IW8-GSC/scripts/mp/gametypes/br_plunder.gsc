/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_plunder.gsc
***********************************************/

function init() {
  level.br_plunder_enabled = getdvarint("scr_br_plunder", 1) != 0;

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  thread setupplunderextractionsites();
  thermite_linktostuck();
  thermite_watchglstuck();
  level._effect["vfx_extract_smoke"] = loadfx("vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker");

  if(scripts\mp\gametypes\br_public::shouldusegoldbarassets()) {
    level._effect["vfx_br_cashLeaderBag"] = loadfx("vfx/iw8_br/gameplay/vfx_br_gold_backpack.vfx");
  } else {
    level._effect["vfx_br_cashLeaderBag"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx");
  }

  level.br_plunder_lobby = getdvarint("scr_br_plunder_lobby", 0) != 0 && istrue(level.allowprematchdamage);
  level.br_plunder = spawnStruct();
  level.br_plunder.ref_127BF = 65535;
  level.br_plunder.ref_12790 = 0;
  level.br_plunder.ref_127AD = 0;
  level.br_plunder.ref_1278F = 0;
  level.br_plunder.ref_127AC = 0;
  level.br_plunder.wait_for_all_players_in_airlock = 0;
  level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes = 0;
  level.br_plunder.oscope_freq_think = 0;
  level.br_plunder.oscope_freq = 0;
  level.br_plunder.oscope_sign_think = 0;
  level.br_plunder.oscope_sign = 0;
  level.br_plunder.ref_12784 = 0;
  level.delete_on_unloaded = getdvarfloat("scr_br_plunder_death_tax_pct", 3);
  level.delete_on_track_delete = getdvarfloat("scr_br_plunder_death_keep_pct", 2);
  level.delete_on_exit_icon_trigger_pre_race = getdvarfloat("scr_br_plunder_death_drop_pct", 5);
  setupquantities();
  tracegroundheightexfil();
  toggle_wind();
  level.br_depots = [];
  thread ref_12788();
  thread ref_1278D();

  if(inplunderlivelobby()) {
    level.br_plunder_ents = [];
    thread plunderlivelobby();
  }

  toggle_trap();
  ref_1278E();
  _debug_rooftopobjstart::playertimestamp();
  scripts\mp\gametypes\br_rat_race_base::ref_140F9();
  touchdown_origin();
  thermite_watchstucktoterrain();

  if(getdvarint("scr_enablePlunderPileOverrides", 0) == 1) {
    ref_128A7();
    return;
  }
}

function ref_12788(var_0, var_1, var_2) {
  level endon("game_ended");
  level waittill("prematch_started");

  for(;;) {
    level waittill("br_circle_started");
    var_3 = scripts\mp\gametypes\br_quest_util::getvalidplayersinarray(level.players, level.questinfo.defaultfilter);
    scripts\mp\gametypes\br_analytics::destroy_jammer_relocate(var_3);
  }
}

function ref_1278D() {
  var_0 = getdvarint("scr_br_plunder_start_amount", 0);

  if(!var_0) {
    return;
  }

  level waittill("infils_ready");

  foreach(var_2 in level.players) {
    playersetplundercount(var_2, var_0);
  }
}

function ref_11C91(var_0, var_1) {
  if(level.br_plunder_enabled) {
    level.br_plunder.vehicle_collision_updateinstance[var_0] += var_1;
    return;
  }
}

function setupquantities() {
  level.br_plunder.ref_12954 = [];
  level.br_plunder.names = [];
  level.br_plunder.vehicle_collision_updateinstance = [];

  foreach(var_2, var_1 in level.br_pickups.counts) {
    if(!issubstr(var_2, "brloot_plunder_cash")) {
      continue;
    }

    level.br_plunder.names[level.br_plunder.names.size] = var_2;
  }

  for(var_3 = 0; var_3 < level.br_plunder.names.size; var_3++) {
    level.br_plunder.ref_12954[var_3] = level.br_pickups.counts[level.br_plunder.names[var_3]];
  }

  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_common_1"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_common_1");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_uncommon_1"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_uncommon_1");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_uncommon_2"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_uncommon_2");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_uncommon_3"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_uncommon_3");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_rare_1"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_rare_1");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_rare_2"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_rare_2");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_epic_1"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_epic_1");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_epic_2"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_epic_2");
  level.br_plunder.vehicle_collision_updateinstance["brloot_plunder_cash_legendary_1"] = getscriptablelootspawnedcountbyrarity("brloot_plunder_cash_legendary_1");
  level.br_plunder.vehicle_collision_updateinstance["br_loot_cache"] = getscriptablelootspawnedcountbyrarity("br_loot_cache");
  level.br_plunder.vehicle_collision_updateinstance["brloot_mission_tablet"] = getscriptablelootspawnedcountbyrarity("brloot_mission_tablet");

  foreach(var_2, var_1 in level.br_plunder.names) {
    if(!isDefined(level.br_plunder.ref_12954[var_2])) {
      level.br_plunder.vehicle_collision_updateinstance[var_2] = getscriptablelootspawnedcountbyrarity(var_2);
    }
  }

  if(level.br_plunder.names.size <= 1) {
    return;
  }

  var_5 = 0;

  while(var_5 == 0) {
    var_5 = 1;

    for(var_3 = 0; var_3 < level.br_plunder.names.size - 1; var_3++) {
      if(level.br_plunder.ref_12954[var_3] > level.br_plunder.ref_12954[var_3 + 1]) {
        var_5 = 0;
        var_6 = level.br_plunder.ref_12954[var_3];
        level.br_plunder.ref_12954[var_3] = level.br_plunder.ref_12954[var_3 + 1];
        level.br_plunder.ref_12954[var_3 + 1] = var_6;
        var_7 = level.br_plunder.names[var_3];
        level.br_plunder.names[var_3] = level.br_plunder.names[var_3 + 1];
        level.br_plunder.names[var_3 + 1] = var_7;
      }
    }
  }
}

function tracegroundheightexfil() {
  game["dialog"]["plunder_extract_requested"] = "plunder_plunder_extract_requested";
  game["dialog"]["plunder_extract_chopper_arrive"] = "plunder_plunder_extract_chopper_arrive";
  game["dialog"]["plunder_extract_chopper_leave"] = "plunder_plunder_extract_chopper_leave";
  game["dialog"]["plunder_extract_success"] = "plunder_plunder_extract_success";
  game["dialog"]["plunder_extract_fail_chopper"] = "plunder_plunder_extract_fail_chopper";
}

function toggle_wind() {
  level.ref_127C5 = getEntArray("extract_pad", "targetname");
}

function playerplaybankanim() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing()) {
    return;
  }

  scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_cash_handoff", 1.84);
}

function playerremoveplunderfrominventory() {
  foreach(var_1 in self.br_inventory_slots) {
    if(var_1.scriptablename == "brloot_plunder_cash_uncommon_1") {
      scripts\mp\gametypes\br_public::removeitemfrominventory(var_2);
      return;
    }
  }
}

function disablealldepotsforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_depots.size; var_1++) {
    var_2 = level.br_depots[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled)) {
      depotmakeunusabletoplayer(var_2, var_0);
    }
  }
}

function enablealldepotsforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_depots.size; var_1++) {
    var_2 = level.br_depots[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled)) {
      depotmakeusabletoplayer(var_2, var_0);
    }
  }
}

function depotmakeusabletoplayer(var_0) {
  self enableplayeruse(var_0);

  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, var_0);
    return;
  }
}

function depotmakeunusabletoplayer(var_0) {
  self disableplayeruse(var_0);

  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, var_0);
    return;
  }
}

function depotmakeunsabletoall() {
  self makeunusable();

  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
    return;
  }
}

function initplayer() {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  if(!isDefined(self.plundercount)) {
    self.plundercount = 0;
  }

  if(!isDefined(self.plunderbanked)) {
    self.plunderbanked = 0;
  }

  if(!isDefined(self.haspickedupplunderyet)) {
    self.haspickedupplunderyet = 0;
  }

  if(self.plundercount == 0) {
    playersetplundercount(0);
    return;
  }
}

function playerdropplunder() {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  playersetplundercount(0);
}

function bankplunderongameended() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(isDefined(var_1.plundercount) && var_1.plundercount > 0) {
      ref_12618(var_1, var_1.plundercount);
    }
  }
}

function playerdropplunderondeath(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::ref_12E05("playerDropPlunderOnDeath", var_0, var_1))) {
    return;
  }

  var_2 = level.delete_on_track_delete + level.delete_on_unloaded + level.delete_on_exit_icon_trigger_pre_race;
  var_3 = level.delete_on_track_delete / var_2;
  var_4 = level.delete_on_unloaded / var_2;
  var_5 = level.delete_on_exit_icon_trigger_pre_race / var_2;

  if(isDefined(self.plundercount) && self.plundercount > 0) {
    var_6 = self.plundercount;
  } else {
    var_6 = 0;
  }

  var_7 = int(min(var_6, max(2, int(var_6 * var_4))) + 0.5);
  var_8 = int(max(1, int(var_6 * var_6)));
  self.plundercountondeath = var_7;
  playersetplundercount(var_7);

  if(var_8 <= 0) {
    return;
  }

  ml_p3_func(var_8, var_1);
}

function takeplunderpickup(var_0) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var_1 = 1;

  if(isDefined(var_0.count)) {
    var_1 = var_0.count;
  }

  if(var_1 < 0) {
    scripts\mp\utility\script::laststand_dogtags("takePlunderPickup - amount less than 0: " + var_1 + ", pickupEnt.scriptableName: " + var_0.scriptablename);
  }

  if(scripts\engine\utility::array_contains(level.br_plunder.names, var_0.scriptablename)) {
    ref_12627(var_1);
    level.br_plunder.ref_12790 += 1;
    level.br_plunder.ref_127AD += var_1;
    ref_11C91(var_0.scriptablename, -1);
    var_2 = "loot";

    if(isDefined(var_0.tracknonoobplayerlocation.ref_11A40)) {
      var_2 = var_0.tracknonoobplayerlocation.ref_11A40;
    }

    scripts\mp\gametypes\br_analytics::ref_13C44(self, var_2, var_1);
    return;
  }

  scripts\mp\gametypes\br_pickups::trypickupitem(var_0.scriptablename, var_1);
}

function registerpostplundercallback(var_0) {
  if(!isDefined(level.postplundercallbacks)) {
    level.postplundercallbacks = [];
  }

  level.postplundercallbacks[level.postplundercallbacks.size] = var_0;
}

function toggle_trap() {
  var_0 = [];
  var_0[1] = "ui_br_plunder_pickedup";
  var_0[2] = "ui_br_plunder_pickedup";
  var_0[8] = "ui_br_plunder_pickedup";
  level.ref_12621 = var_0;
  var_1 = [];
  var_1[1] = ::ref_12628;
  var_1[2] = ::ref_1261D;
  var_1[8] = ::playerplunderstealcallback;
  var_1[3] = ::ref_12619;
  var_1[4] = ::ref_12624;
  var_1[5] = ::ref_1261B;
  var_1[6] = ::ref_12626;
  level.ref_12620 = var_1;
}

function ref_12627(var_0, var_1) {
  return ref_1261F(var_0, 1, undefined, var_1);
}

function playerplundersteal(var_0, var_1, var_2) {
  return ref_1261F(var_0, 8, var_1, var_2);
}

function ref_1261C(var_0, var_1, var_2) {
  return ref_1261F(var_0, 2, var_1, var_2);
}

function ref_12618(var_0, var_1, var_2) {
  return ref_1261F(var_0, 3, var_1, var_2);
}

function ref_12623(var_0, var_1) {
  return ref_1261F(var_0, 4, undefined, var_1);
}

function ref_1261A(var_0, var_1, var_2) {
  return ref_1261F(var_0, 5, var_1, var_2);
}

function ref_12625(var_0, var_1, var_2) {
  return ref_1261F(var_0, 6, var_1, var_2);
}

function ref_12622(var_0, var_1) {
  return ref_1261F(var_0, 4, undefined, var_1);
}

function ref_1261E(var_0, var_1) {
  return ref_1261F(var_0, 4, undefined, var_1);
}

function ref_1261F(var_0, var_1, var_2, var_3) {
  if(!istrue(level.br_plunder_enabled) || !isDefined(self.plundercount)) {
    return;
  }

  if(var_1 == 7) {
    if(self.team == var_2.team) {
      var_1 = 2;
    } else {
      var_1 = 8;
    }
  }

  if(var_0 < 0) {
    scripts\mp\utility\script::laststand_dogtags("playerPlunderEvent - amount less than 0: " + var_0 + ", type: " + var_1);
  }

  if(var_1 == 2 || var_1 == 3 || var_1 == 4) {
    var_0 = int(min(self.plundercount, var_0));
  } else if(var_1 == 8) {
    var_0 = int(min(var_2.ref_127D0, var_0));
  }

  if(!isDefined(self.ref_127B8)) {
    self.ref_127B8 = [];
  }

  if(!isDefined(self.ref_127B9)) {
    self.ref_127B9 = [];
  }

  if(!isDefined(self.warningclearcallbacks)) {
    self.warningclearcallbacks = 0;
  }

  var_5 = scripts\engine\utility::ter_op(var_1 == 5, 3, var_1);
  var_6 = level.ref_12621[var_5];
  var_7 = self.ref_127B9[var_1];
  var_8 = self.ref_127B8[var_1];

  if(!isDefined(var_8) || gettime() - var_8 > 2000) {
    var_7 = 0;
  }

  var_7 += var_0;

  if(isPlayer(self) && isDefined(var_6)) {
    var_9 = int(min(var_7, self.plundercount + var_0));
    self setclientomnvar(var_6, var_9);
  }

  self.warningclearcallbacks = var_1;
  self.ref_127B8[var_1] = gettime();
  self.ref_127B9[var_1] = var_7;
  var_10 = level.ref_12620[var_1];

  if(isDefined(var_10)) {
    var_3 = self[[var_10]](var_0, var_2, var_3);
  }

  if(isDefined(var_3)) {
    if(isDefined(var_3.player) && !var_3.player scripts\mp\gametypes\br_public::isplayeringulag()) {
      if(isDefined(var_3.ref_126AF) && var_3.ref_126AF != "none") {
        if(var_3.ref_126AF != "br_plunder_first_pickup" || !istrue(var_3.player.haspickedupplunderyet)) {
          if(isDefined(level.ref_127CD)) {
            if(var_0 + self.plundercount > level.ref_127CD) {
              var_3.player thread scripts\mp\hud_message::showsplash(var_3.ref_126AF);

              if(var_3.ref_126AF == "br_plunder_first_pickup") {
                var_3.player.haspickedupplunderyet = 1;
              }
            }
          } else {
            var_3.player thread scripts\mp\hud_message::showsplash(var_3.ref_126AF);

            if(var_3.ref_126AF == "br_plunder_first_pickup") {
              var_3.player.haspickedupplunderyet = 1;
            }
          }
        }
      }

      if(isDefined(var_3.ref_12667) && (!isDefined(var_3.ref_12668) || var_3.ref_12668 > 0)) {
        var_3.player thread scripts\mp\utility\points::giveunifiedpoints(var_3.ref_12667, undefined, var_3.ref_12668);
      }
    }

    if(istrue(var_3.ref_1244D)) {
      if(var_1 == 3) {
        thread playerplaybankanim();
      } else if(var_1 == 2 || var_1 == 8) {
        thread ref_12615();
      }
    }

    if(isDefined(var_3.amount)) {
      var_0 = var_3.amount;
    }

    if(istrue(var_3.ref_1275C)) {
      var_11 = scripts\engine\utility::ter_op(isDefined(var_3.ref_127CC), var_3.ref_127CC, var_0);
      ref_1275D(self, var_11);
    }
  }

  switch (var_1) {
    case 4:
    case 3:
    case 2:
      var_0 *= -1;
      break;
    case 8:
    case 6:
    case 5:
      var_0 = 0;
      break;
    case 1:
      break;
  }

  if(isDefined(var_0)) {
    var_3.ref_127B4 = var_0;
    thread playersetplundercount(self.plundercount + var_0, var_3);
  }

  scripts\mp\gametypes\br_gametype_dmz::ref_121B6();
  return var_3;
}

function ref_140D2(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
    case 2:
    case 1:
      return 1;
    default:
      return 0;
  }
}

function ref_12628(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = init_subway_cars(self);
  }

  if(!istrue(self.haspickedupplunderyet)) {
    var_2.ref_126AF = "br_plunder_first_pickup";
    thread scripts\mp\gametypes\br_armory_kiosk::ref_1334A();
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12060(var_0);
  return var_2;
}

function playerplunderstealcallback(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = init_subway_cars(self);
  }

  if(!isDefined(var_2.ref_1275C)) {
    var_2.ref_1275C = 1;
    var_2.ref_127CC = undefined;
  }

  if(!isDefined(var_2.ref_1244D)) {
    var_2.ref_1244D = 1;
  }

  if(isDefined(var_1)) {
    var_3 = ref_1278C(var_1.ref_127C8);
    thread scripts\mp\gametypes\br::ref_13AC7("br_gametype_rat_race_your_team_stole_from_enemy_base", undefined, self.team);
    thread scripts\mp\gametypes\br::ref_13AC7("br_gametype_rat_race_enemy_stole_from_your_base", undefined, var_1.team);
    entityplunderlosedeposited(var_1, var_0, 1, var_3.maxnumplunderobjectstodropforsteal, var_2);
  }

  return var_2;
}

function ref_1261D(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = init_subway_cars(self);
  }

  if(!isDefined(var_2.ref_1275C)) {
    var_2.ref_1275C = 1;
    var_2.ref_127CC = undefined;
  }

  if(!isDefined(var_2.ref_1244D)) {
    var_2.ref_1244D = 1;
  }

  if(isDefined(var_1)) {
    var_3 = ref_1278C(var_1.ref_127C8);

    if(isDefined(var_3.get_closest_enemy_near_turret) && var_3.get_closest_enemy_near_turret > 0) {
      var_4 = var_1.ref_127D0 + var_0 - var_3.get_closest_enemy_near_turret;

      if(var_4 >= 0) {
        var_0 -= var_4;

        if(!istrue(var_1.ref_127AE)) {
          ref_12799(var_1);
        }
      }
    }

    var_5 = 1;

    foreach(var_7 in var_1.plunder) {
      var_8 = var_7.player;

      if(isDefined(var_8) && var_8 == self) {
        var_7.plundercount += var_0;
        var_5 = 0;
        break;
      }
    }

    if(var_5) {
      var_7 = spawnStruct();
      var_7.player = self;
      var_7.team = self.team;
      var_7.plundercount = var_0;
      var_10 = var_1.plunder.size;

      for(var_11 = 0; var_11 < var_1.plunder.size; var_11++) {
        if(!isDefined(var_1.plunder[var_11])) {
          var_10 = var_11;
          break;
        }
      }

      var_1.plunder[var_10] = var_7;
    }
  }

  var_2.amount = var_0;
  var_1.ref_127D0 += var_0;

  if(!isDefined(level.teamdata[self.team]["plunderInDeposit"])) {
    level.teamdata[self.team]["plunderInDeposit"] = int(var_0);
  } else {
    level.teamdata[self.team]["plunderInDeposit"] = level.teamdata[self.team]["plunderInDeposit"] + int(var_0);
  }

  return var_2;
}

function ref_12619(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = init_subway_cars(self);
  }

  if(!isDefined(var_2.ref_126AF)) {
    var_2.ref_126AF = "br_plunder_banked";
  }

  if(!isDefined(var_2.ref_12667)) {
    var_2.ref_12667 = scripts\engine\utility::ter_op(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war", "plunder_cash_blood_money", "plunder_cash");
  }

  if(!isDefined(var_2.ref_12668)) {
    var_2.ref_12668 = int(scripts\mp\rank::getscoreinfovalue(var_2.ref_12667) * var_0 / 10);
  }

  if(!isDefined(var_2.ref_1275C)) {
    var_2.ref_1275C = 1;
    var_2.ref_127CC = undefined;
  }

  if(!isDefined(var_2.ref_1244D)) {
    var_2.ref_1244D = 1;
  }

  self.plunderbanked += var_0;

  if(self.plunderbanked > level.br_plunder.ref_127BF) {
    self.plunderbanked = level.br_plunder.ref_127BF;
  }

  if(!isDefined(level.teamdata[self.team]["plunderBanked"])) {
    level.teamdata[self.team]["plunderBanked"] = var_0;
  } else {
    level.teamdata[self.team]["plunderBanked"] = level.teamdata[self.team]["plunderBanked"] + var_0;
  }

  foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex)) {
    var_4 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("dmz_bank", var_0);
  }

  return var_2;
}

function ref_12624(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = init_subway_cars(self);
  }

  return var_2;
}

function ref_1261B(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = init_subway_cars(self);
  }

  if(!isDefined(var_2.ref_127CC)) {
    var_2.ref_127CC = 0;
  }

  var_2.ref_131AB = 1;
  var_3 = self.team;

  if(isDefined(var_1) && isDefined(var_1.plunder)) {
    foreach(var_5 in var_1.plunder) {
      if(isDefined(var_5.player) && var_5.player == self) {
        var_3 = var_5.team;

        if(!isDefined(var_0)) {
          var_0 = var_5.plundercount;
        } else {
          var_0 = min(var_0, var_5.plundercount);
        }

        var_5.plundercount -= var_0;

        if(var_5.plundercount == 0) {
          var_1.plunder[var_6] = undefined;
        }

        self.plunderbanked += var_0;

        if(self.plunderbanked > level.br_plunder.ref_127BF) {
          self.plunderbanked = level.br_plunder.ref_127BF;
        }

        break;
      }
    }

    if(!isDefined(var_2.ref_12667)) {
      var_2.ref_12667 = scripts\engine\utility::ter_op(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war", "plunder_cash_blood_money", "plunder_cash");
    }

    if(!isDefined(var_2.ref_12668)) {
      var_2.ref_12668 = int(scripts\mp\rank::getscoreinfovalue(var_2.ref_12667) * var_0 / 10);
    }
  }

  var_0 = int(var_0);
  level.teamdata[var_3]["plunderInDeposit"] = level.teamdata[var_3]["plunderInDeposit"] - var_0;
  level.teamdata[var_3]["plunderBanked"] = level.teamdata[var_3]["plunderBanked"] + var_0;

  foreach(var_8 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex)) {
    var_8 scripts\cp\vehicles\vehicle_compass_cp::ref_12004("dmz_bank", var_0);
  }

  return var_2;
}

function ref_12626(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = init_subway_cars(self);
  }

  var_2.ref_131AB = 1;
  var_3 = self.team;

  if(isDefined(var_1) && isDefined(var_1.plunder)) {
    foreach(var_5 in var_1.plunder) {
      if(isDefined(var_5.player) && var_5.player == self) {
        var_3 = var_5.team;

        if(!isDefined(var_0)) {
          var_0 = var_5.plundercount;
        } else {
          var_0 = min(var_0, var_5.plundercount);
        }

        var_5.plundercount -= var_0;

        if(var_5.plundercount == 0) {
          var_1.plunder[var_6] = undefined;
        }

        break;
      }
    }
  }

  var_0 = int(var_0);
  level.teamdata[var_3]["plunderInDeposit"] = level.teamdata[var_3]["plunderInDeposit"] - var_0;
  return var_2;
}

function num_players_in_safehouse(var_0) {
  var_1 = istrue(level..disableplunderbanking);

  if(!isDefined(self.plunder)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = init_subway_cars();
  }

  var_0.brwatchforminplayersmatchstart = 0;
  var_0.teams = [];
  var_0.ref_11F3A = 0;

  foreach(var_3 in self.plunder) {
    if(isDefined(var_3.player) || var_3.plundercount <= 0) {
      continue;
    }

    var_4 = var_3.team;
    var_5 = var_3.plundercount;

    if(!var_1) {
      level.teamdata[var_4]["plunderInDeposit"] = level.teamdata[var_4]["plunderInDeposit"] - var_5;
      level.teamdata[var_4]["plunderBanked"] = level.teamdata[var_4]["plunderBanked"] + var_5;
    }

    var_0.brwatchforminplayersmatchstart += var_5;
    var_0.teams[var_0.teams.size] = var_4;
    self.plunder[var_6] = undefined;
  }

  foreach(var_3 in self.plunder) {
    if(var_3.plundercount <= 0) {
      continue;
    }

    var_8 = var_3.player;
    var_4 = var_3.team;
    var_5 = var_3.plundercount;
    var_9 = undefined;

    if(isDefined(var_0)) {
      var_9 = ignoregulagredeploysplash(var_0, var_8, var_4);
    }

    if(!var_1) {
      var_9 = ref_1261A(var_8, var_5, self, var_9);
    }

    if(isDefined(var_9) && isDefined(var_9.amount)) {
      var_5 = var_9.amount;
    }

    var_0.brwatchforminplayersmatchstart += var_5;
    var_0.teams[var_0.teams.size] = var_4;
    var_0.ref_11F3A++;
  }

  var_0.teams = scripts\engine\utility::array_remove_duplicates(var_0.teams);
  var_11 = 0;

  if(var_0.teams.size > 1) {
    var_11 = 1;
  } else if(var_0.teams.size == 1 && var_0.teams[0] != self.team) {
    var_11 = 1;
  }

  var_12 = ref_1278C(self.ref_127C8, undefined, 1);

  if(isDefined(var_12) && isDefined(var_12.outline_enemy_ai_for_duration)) {
    scripts\mp\gametypes\br_analytics::detonatefx(var_0.ref_11F3A, var_0.brwatchforminplayersmatchstart, var_12.outline_enemy_ai_for_duration, var_11, self.origin);
  }

  self.plunder = [];
  return var_0;
}

function entityplunderlosedeposited(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.plunder)) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = init_subway_cars();
  }

  var_3.brwatchforminplayersmatchstart = 0;
  var_3.teams = [];
  var_4 = var_0;

  foreach(var_6 in self.plunder) {
    if(var_4 <= 0) {
      break;
    }

    if(isDefined(var_6.player) || var_6.plundercount <= 0) {
      continue;
    }

    var_7 = var_6.team;
    var_8 = min(var_6.plundercount, var_4);
    var_6.plundercount -= var_8;
    level.teamdata[var_7]["plunderInDeposit"] = level.teamdata[var_7]["plunderInDeposit"] - var_8;
    var_4 -= var_8;
    self.ref_127D0 -= var_8;
    var_3.brwatchforminplayersmatchstart += var_8;
    var_3.teams[var_3.teams.size] = var_7;

    if(var_6.plundercount == 0) {
      self.plunder[var_9] = undefined;
    }
  }

  foreach(var_6 in self.plunder) {
    if(var_4 <= 0) {
      break;
    }

    if(var_6.plundercount <= 0) {
      continue;
    }

    var_11 = var_6.player;
    var_7 = var_6.team;
    var_8 = min(var_6.plundercount, var_4);
    var_12 = undefined;

    if(isDefined(var_3)) {
      var_12 = ignoregulagredeploysplash(var_3, var_11, var_7);
    }

    ref_12625(var_11, var_8, self, var_12);

    if(isDefined(var_12) && isDefined(var_12.amount)) {
      var_8 = var_12.amount;
    }

    var_4 -= var_8;
    self.ref_127D0 -= var_8;
    var_3.brwatchforminplayersmatchstart += var_8;
    var_3.teams[var_3.teams.size] = var_7;
  }

  if(istrue(var_1)) {
    var_14 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    dropplunderbyrarity(var_0, var_14, var_2);
  }

  if(self.ref_127D0 <= 0) {
    self.ref_127D0 = 0;
    var_3.amount = 0;
  }

  if(level.teamdata[self.team]["plunderInDeposit"] < 0) {
    level.teamdata[self.team]["plunderInDeposit"] = 0;
  }

  return var_3;
}

function num_rocket_per_attack(var_0, var_1, var_2) {
  if(!isDefined(self.plunder)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = init_subway_cars();
  }

  var_2.brwatchforminplayersmatchstart = 0;
  var_2.teams = [];
  var_3 = 0;

  foreach(var_5 in self.plunder) {
    if(isDefined(var_5.player) || var_5.plundercount <= 0) {
      continue;
    }

    var_6 = var_5.team;
    var_7 = var_5.plundercount;
    level.teamdata[var_6]["plunderInDeposit"] = level.teamdata[var_6]["plunderInDeposit"] - var_7;
    var_2.brwatchforminplayersmatchstart += var_7;
    var_2.teams[var_2.teams.size] = var_6;
    self.plunder[var_8] = undefined;
  }

  foreach(var_5 in self.plunder) {
    if(var_5.plundercount <= 0) {
      continue;
    }

    var_10 = var_5.player;
    var_6 = var_5.team;
    var_7 = var_5.plundercount;
    var_11 = undefined;

    if(isDefined(var_2)) {
      var_11 = ignoregulagredeploysplash(var_2, var_10, var_6);
    }

    ref_12625(var_10, var_7, self, var_11);

    if(isDefined(var_11) && isDefined(var_11.amount)) {
      var_7 = var_11.amount;
    }

    var_2.brwatchforminplayersmatchstart += var_7;
    var_2.teams[var_2.teams.size] = var_6;
    var_3 += var_7;
  }

  self.plunder = [];

  if(istrue(var_0)) {
    var_13 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    dropplunderbyrarity(var_2.brwatchforminplayersmatchstart, var_13, var_1);
  }

  return var_2;
}

function init_subway_cars(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = undefined;

  if(isDefined(var_0)) {
    var_2.player = var_0;
  }

  var_2.ref_126AF = undefined;
  var_2.ref_12667 = undefined;
  var_2.ref_12668 = undefined;
  var_2.ref_131AB = undefined;
  var_2.ref_1275C = undefined;
  var_2.ref_127CC = undefined;
  var_2.ref_1244D = undefined;
  return var_2;
}

function ignoregulagredeploysplash(var_0, var_1, var_2) {
  var_3 = init_subway_cars();

  if(isDefined(var_0.player)) {
    var_3.player = var_0.player;
    var_1 = var_0.player;
  } else if(isDefined(var_1)) {
    var_3.player = var_1;
  }

  if(isDefined(var_0.ref_126AF)) {
    var_3.ref_126AF = var_0.ref_126AF;
  }

  if(isDefined(var_0.ref_12667)) {
    var_3.ref_12667 = var_0.ref_12667;
  }

  if(isDefined(var_0.ref_12668)) {
    var_3.ref_12668 = var_0.ref_12668;
  }

  if(isDefined(var_0.ref_131AB)) {
    var_3.ref_131AB = var_0.ref_131AB;
  }

  if(isDefined(var_0.ref_1275C)) {
    var_3.ref_1275C = var_0.ref_1275C;
  }

  if(isDefined(var_0.ref_127CC)) {
    var_3.ref_127CC = var_0.ref_127CC;
  }

  if(isDefined(var_0.ref_1244D)) {
    var_3.ref_1244D = var_0.ref_1244D;
  }

  return var_3;
}

function playersetplundercount(var_0, var_1) {
  if(!isDefined(self.plundercount)) {
    self.plundercount = 0;
  }

  var_2 = self.plundercount;
  var_3 = var_0 - self.plundercount;

  if((!isDefined(var_1) || !istrue(var_1.ref_131AB)) && var_3 == 0) {
    return;
  }

  self.plundercount = var_0;

  if(self.plundercount > level.br_plunder.ref_127BF) {
    scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED");
    self.plundercount = level.br_plunder.ref_127BF;
  }

  if(isDefined(self.petwatch)) {
    scripts\cp_mp\pet_watch::ref_1206D();
  }

  var_4 = self.plundercount;
  ref_1268A(var_4);

  if(var_0 > 0) {
    if(istrue(level.ref_127D4) && var_3 != 0) {
      ref_12781(self, 1, 1);
    }

    enablealldepotsforplayer(self);

    if(inplunderlivelobby() && var_0 >= 10) {
      thread playerdelayautobankplunder();
    }
  } else {
    if(istrue(level.ref_127D4) && var_3 != 0) {
      ref_12781(self, 0, 1);
    }

    disablealldepotsforplayer(self);
  }

  if(isDefined(level.teamdata[self.team]["plunderTeamTotal"]) && isDefined(var_1) && isDefined(var_1.ref_127B4)) {
    if(getDvar("scr_br_gametype", "") == "rat_race") {
      level.teamdata[self.team]["plunderTeamTotal"] = level.teamdata[self.team]["plunderTeamTotal"] + self.plundercount - var_2;
    } else {
      level.teamdata[self.team]["plunderTeamTotal"] = level.teamdata[self.team]["plunderTeamTotal"] + var_1.ref_127B4;
    }
  }

  thread scripts\mp\gametypes\br_gametypes::ref_12E05("postPlunder", var_1);

  if(isDefined(level.postplundercallbacks)) {
    foreach(var_6 in level.postplundercallbacks) {
      [[var_6]](var_1);
    }

    return;
  }
}

function ref_1268A(var_0) {
  var_1 = ref_12577();
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];
  var_1 = undefined;
  var_5 = scripts\mp\gametypes\br_public::round_at_max(self.team, self.squadindex, var_4);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = respawn_used_once(var_0, var_5, var_2, var_3);
  scripts\mp\gametypes\br_public::ref_131C3(self.team, self.squadindex, var_4, var_6);
  var_7 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_9 in var_7) {
    if(isbot(var_9) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var_9 setclientomnvar(var_4, var_6);
  }
}

function respawn_used_once(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_0 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = var_1 &var_6;
  var_8 = var_7 + var_5;
  return var_8;
}

function ref_12577() {
  var_0 = 0;
  var_1 = 0;
  var_2 = "";

  switch (self.pers["squadMemberIndex"]) {
    case 1:
      var_3 = [0, 16, "ui_br_plunder_count"];
      var_0 = var_3[0];
      var_1 = var_3[1];
      var_2 = var_3[2];
      var_3 = undefined;
      break;
    case 2:
      var_4 = [16, 16, "ui_br_plunder_count"];
      var_0 = var_4[0];
      var_1 = var_4[1];
      var_2 = var_4[2];
      var_4 = undefined;
      break;
    case 3:
      var_5 = [0, 16, "ui_br_plunder_count2"];
      var_0 = var_5[0];
      var_1 = var_5[1];
      var_2 = var_5[2];
      var_5 = undefined;
      break;
    case 4:
      var_6 = [16, 16, "ui_br_plunder_count2"];
      var_0 = var_6[0];
      var_1 = var_6[1];
      var_2 = var_6[2];
      var_6 = undefined;
      break;
    default:
      break;
  }

  return [var_0, var_1, var_2];
}

function dangercircletick(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var_2 = var_1 * var_1;

  for(var_3 = 0; var_3 < level.br_depots.size; var_3++) {
    var_4 = level.br_depots[var_3];

    if(isDefined(var_4) && !istrue(var_4.disabled) && distance2dsquared(var_0, var_4.origin) > var_2) {
      var_4.disabled = 1;
      depotmakeunsabletoall(var_4);
    }
  }

  for(var_3 = 0; var_3 < level.br_plunder_sites.size; var_3++) {
    var_5 = level.br_plunder_sites[var_3];

    if(isDefined(var_5) && !istrue(var_5.disabled) && distance2dsquared(var_0, var_5.origin) > var_2) {
      var_5.disabled = 1;
      var_5 setscriptablepartstate(var_5.type, var_5.load_relics_from_playlistdvars);
    }
  }
}

function ref_12615() {
  self endon("death_or_disconnect");

  if(!scripts\mp\gametypes\br_public::ref_12518() || self isgestureplaying()) {
    return;
  }

  scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_cash_handoff", 1.84);
}

function cratedropplunder() {
  if(!isDefined(self.plunder)) {
    return;
  }

  var_0 = 0;

  for(var_1 = 0; var_1 < self.plunder.size; var_1++) {
    var_0 += self.plunder[var_1].plundercount;
  }

  self.angles = (0, 0, 0);
  var_2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  dropplunderbyrarity(var_0, var_2);
}

function dropplundersounds(var_0, var_1) {
  if(var_1 <= 0) {
    return;
  }

  var_2 = var_0 + (0, 0, 24);
  var_3 = "";
  wait 0.5;

  switch (var_1) {
    case 0:
      break;
    case 1:
      var_3 = "br_drop_plunder_01";
      break;
    case 2:
      var_3 = "br_drop_plunder_02";
      break;
    case 3:
      var_3 = "br_drop_plunder_03";
      break;
    case 4:
      var_3 = "br_drop_plunder_04";
      break;
    case 5:
      var_3 = "br_drop_plunder_05";
      break;
    case 6:
    default:
      var_3 = "br_drop_plunder_06";
      break;
  }

  playsoundatpos(var_2, var_3);
}

function dropplunderbyrarity(var_0, var_1, var_2, var_3) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var_4 = [];
  var_5 = [];
  var_6 = 0;
  var_7 = 6;

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  for(var_8 = level.br_plunder.ref_12954.size - 1; var_8 >= 0; var_8--) {
    var_5 = int(var_0 / level.br_plunder.ref_12954[var_8]);
    var_5 = int(clamp(var_5[var_8], 0, var_7 - var_6));
    var_6 += var_5[var_8];

    if(var_0 <= 0 || var_6 >= var_7) {
      break;
    }

    var_0 -= var_5[var_8] * level.br_plunder.ref_12954[var_8];
  }

  for(var_9 = level.br_plunder.ref_12954.size - 1; var_9 >= 0; var_9--) {
    if(!isDefined(var_5[var_9])) {
      continue;
    }

    for(var_10 = 0; var_10 < var_5[var_9]; var_10++) {
      var_11 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self, var_3);
      var_12 = scripts\mp\gametypes\br_pickups::spawnpickup(level.br_plunder.names[var_9], var_11, level.br_plunder.ref_12954[var_9], 1);
      ref_11C91(level.br_plunder.names[var_9], 1);

      if(isDefined(var_12)) {
        var_4 = var_12;

        if(inplunderlivelobby()) {
          level.br_plunder_ents[level.br_plunder_ents.size] = var_12;
        }
      }
    }
  }

  level.br_plunder.ref_1278F += var_6;
  level.br_plunder.ref_127AC += var_0;
  thread dropplundersounds(level, self.origin);
  return var_4;
}

function ml_p3_func(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;

  for(var_5 = level.br_plunder.names.size - 1; var_5 >= 0; var_5--) {
    if(var_0 >= level.br_plunder.ref_12954[var_5]) {
      var_4 = var_5;
      break;
    }
  }

  var_6 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  var_7 = scripts\mp\gametypes\br_pickups::spawnpickup(level.br_plunder.names[var_4], var_6, var_0, 1);
  ref_11C91(level.br_plunder.names[var_4], 1);

  if(isDefined(var_7)) {
    var_2 = var_7;

    if(inplunderlivelobby()) {
      level.br_plunder_ents[level.br_plunder_ents.size] = var_7;
    }
  }

  level.br_plunder.ref_1278F++;
  level.br_plunder.ref_127AC += var_0;
  thread dropplundersounds(level, self.origin);
  return var_2;
}

function updateplayerspawninputtype() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("plunderSites")) {
    return false;
  }

  return istrue(level.br_plunder_enabled) && level.br_plunder_sites.size != 0 && getdvarint("scr_br_plunder_sites", 0) != 0;
}

#using_animtree("");

function thermite_linktostuck() {
  level.scr_anim["plunder_extract_heli"]["heli_in"] = % iw8_br_plunder_heli_in;
  level.scr_anim["plunder_extract_heli"]["heli_loop"] = $iw8_br_plunder_heli_loop;
  level.scr_anim["plunder_extract_heli"]["heli_out"] = % iw8_br_plunder_heli_out;
}

function thermite_watchglstuck() {
  level.scr_animtree["plunder_extract_heli"] = #animtree;
  level.scr_anim["plunder_extract_heli"]["rope_in"] = $iw8_br_plunder_heli_rope_in;
  level.scr_animname["plunder_extract_heli"]["rope_in"] = "iw8_br_plunder_heli_rope_in";
  level.scr_anim["plunder_extract_heli"]["rope_loop"] = % iw8_br_plunder_heli_rope_loop;
  level.scr_animname["plunder_extract_heli"]["rope_loop"] = "iw8_br_plunder_heli_rope_loop";
  level.scr_anim["plunder_extract_heli"]["rope_out"] = % iw8_br_plunder_heli_rope_out;
  level.scr_animname["plunder_extract_heli"]["rope_out"] = "iw8_br_plunder_heli_rope_out";
  level.scr_anim["plunder_extract_heli"]["bag_in"] = % iw8_br_plunder_heli_bag_in;
  level.scr_animname["plunder_extract_heli"]["bag_in"] = "iw8_br_plunder_heli_bag_in";
  level.scr_anim["plunder_extract_heli"]["bag_loop"] = % iw8_br_plunder_heli_bag_loop;
  level.scr_animname["plunder_extract_heli"]["bag_loop"] = "iw8_br_plunder_heli_bag_loop";
  level.scr_anim["plunder_extract_heli"]["bag_out"] = % iw8_br_plunder_heli_bag_out;
  level.scr_animname["plunder_extract_heli"]["bag_out"] = "iw8_br_plunder_heli_bag_out";
}

function thermite_watchstucktoterrain() {
  var_0 = [];
  var_1 = ref_1278C("plunderHelipad1", 1);
  var_1.ref_12F7D = "brloot_plunder_extraction_site_01";
  var_0 = var_1;
  var_1 = ref_1278C("plunderHelipad2", 1);
  var_1.ref_12F7D = "brloot_plunder_extraction_site_02";
  var_0 = var_1;
  var_1 = ref_1278C("extractHelipadPlunder", 1);
  var_1.ref_12F7D = "brloot_quest_extract_site_plunder";
  var_0 = var_1;
  var_1 = ref_1278C("extractHelipadBR", 1);
  var_1.ref_12F7D = "brloot_quest_extract_site_br";
  var_0 = var_1;

  foreach(var_1 in var_0) {
    var_1.type = 1;
    var_1.usetime = 0;
    var_1.ref_14077 = 3;
    var_1.ref_14075 = getdvarint("scr_plunderHeliUseAmount", 20000);
    var_1.ref_13ACC = 0;
    var_1.ref_14078 = "MP/CANNOT_DEPOSIT_CASH_HELI_FULL";
    var_1.ref_14079 = "MP/CANNOT_DEPOSIT_CASH_HELI_LEAVING";
    var_1.ref_12F7E = "activedepositcurrent";
    var_1.ref_12F77 = "visiblecurrent";
    var_1.origin_delta = 0;
    var_1.overrideviewkickscaledmr = getdvarint("scr_plunderHeliCountdown", 30);
    var_1.original_disablelongdeath = "MP/CASH_HELI_LEAVING_IN_N";
    var_1.get_closest_enemy_near_turret = 0;
    var_1.impactwatcher = &smokekill;
    var_1.org_in_bad_place = &snowfx;
    var_1.carriable_error_messsage_watch = &smodelcollections;
    var_1.outline_enemy_ai_for_duration = "little_bird";
  }
}

function retrieve_data_objective() {
  var_0 = [];

  if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    var_0 = getentitylessscriptablearrayinradius("extract_pad", "targetname");
    var_1 = getentitylessscriptablearrayinradius("extract_pad_boneyard", "targetname");

    if(var_1.size > 0) {
      var_0 = scripts\engine\utility::array_combine(var_0, var_1);
    }
  } else {
    var_2 = getentitylessscriptablearrayinradius("plunder_extraction_01", "targetname");
    var_3 = getentitylessscriptablearrayinradius("plunder_extraction_02", "targetname");
    var_0 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  if(var_0.size > 0) {
    foreach(var_6, var_5 in var_0) {
      var_5.audio_shf_kill_hangar_lights = "active";
      var_5.audio_jugg_spawn = "activeCurrent";
      var_5.load_relics_from_playlistdvars = "visible";
      var_5.little_bird_onexitheavydamagestate = "visible";
    }

    return var_0;
  }

  var_6 = getentitylessscriptablearrayinradius("plunder_extraction", "targetname");

  foreach(var_5 in var_6) {
    var_5.audio_shf_kill_hangar_lights = "visible";
    var_5.audio_jugg_spawn = "visibleCurrent";
    var_5.load_relics_from_playlistdvars = "hidden";
  }

  return var_6;
}

function setupplunderextractionsites() {
  level.br_plunder_sites = retrieve_data_objective();
  level.delete_old_gate = [];
  level.delete_old_gate[level.delete_old_gate.size] = "brloot_plunder_extraction_site";
  level.delete_old_gate[level.delete_old_gate.size] = "brloot_plunder_extraction_site_01";
  level.delete_old_gate[level.delete_old_gate.size] = "brloot_plunder_extraction_site_02";
  level.delete_old_gate[level.delete_old_gate.size] = "brloot_quest_extract_site_br";
  level.delete_old_gate[level.delete_old_gate.size] = "brloot_quest_extract_site_plunder";
  level.delete_on_death_or_dissconnect = [];
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "active";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "active2";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "activecurrent";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "activecurrentnight";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "visiblecurrent";

  if(!updateplayerspawninputtype()) {
    var_0 = getEntArray("plunder_extraction_visual", "targetname");

    foreach(var_2 in var_0) {
      var_2 delete();
    }

    foreach(var_5 in level.br_plunder_sites) {
      var_5 setscriptablepartstate(var_5.type, "hidden");
    }

    level.br_plunder_sites = [];
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallback(&plundersiteused);

  if(isDefined(level.ref_11B3F) && level.ref_11B3F > 0 && !istrue(level.ref_14086)) {
    wait level.ref_11B3F;
  } else if(istrue(level.ref_14086)) {
    scripts\mp\flags::gameflagwait("activate_cash_lzs");
  }

  foreach(var_8 in level.players) {
    if(isDefined(var_8)) {
      if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
        var_8 scripts\mp\hud_message::showsplash("bm_extract_heli_start");
      }
    }
  }

  foreach(var_5 in level.br_plunder_sites) {
    var_11 = scripts\engine\utility::ter_op(istrue(level.ref_13368) && !istrue(level.ref_13363), var_5.audio_jugg_spawn, var_5.audio_shf_kill_hangar_lights);
    var_5 setscriptablepartstate(var_5.type, var_11);
  }
}

function register_vfx() {
  if(!updateplayerspawninputtype()) {
    return;
  }

  var_0 = retrieve_data_objective();
  return var_0;
}

function ref_1314B(var_0) {
  foreach(var_2 in level.br_plunder_sites) {
    if(!scripts\engine\utility::array_contains(var_0, var_2)) {
      var_2 setscriptablepartstate(var_2.type, "hidden");
    }
  }

  level.br_plunder_sites = var_0;
}

function isspecialistbonus(var_0) {
  var_1 = spawn("script_model", var_0.origin + (0, 0, 1000));
  var_1 setModel("veh8_mil_air_mindia8_plunder_x");
  var_2 = var_0.origin[0];
  var_3 = var_0.origin[1];
  var_4 = 800;
  var_5 = tracegroundpoint(var_1, var_2, var_3);
  var_6 = var_5 + var_4;
  var_7 = (var_2, var_3, var_6);
  var_1.origin = var_7;

  for(;;) {
    waitframe();
  }
}

function plundersiteused(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }

  if(!isDefined(level.delete_old_gate) || !isDefined(level.delete_on_death_or_dissconnect)) {
    return;
  }

  var_5 = 1;

  foreach(var_7 in level.delete_old_gate) {
    if(var_7 != var_1) {
      continue;
    }

    var_5 = 0;
    break;
  }

  if(var_5) {
    return;
  }

  var_5 = 1;

  foreach(var_10 in level.delete_on_death_or_dissconnect) {
    if(var_10 != var_2) {
      continue;
    }

    var_5 = 0;
    break;
  }

  if(var_5) {
    return;
  }

  thread plundersiteusedinternal(var_0, var_1, var_2, var_3);
}

function plundersiteusedinternal(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.disabled)) {
    return;
  }

  if(isDefined(var_0.heli)) {
    playerdenyextraction(var_3, undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return;
  }

  var_4 = scripts\engine\utility::ter_op(istrue(level.ref_13368) && !istrue(level.ref_13363), "inuseCurrent", "inuse");
  var_0 setscriptablepartstate(var_0.type, var_4);
  var_5 = getgroundposition(var_0.origin, 1) + (0, 0, 2);
  var_6 = playerspawnextractchopper(var_3, var_5, var_0);

  if(isDefined(var_6)) {
    var_6.site = var_0;
    var_0.heli = var_6;
    var_0.team = var_3.team;
    thread init_trap_room_spawning_module(var_5);
    ref_126C7(var_3);

    if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_requested", var_3.team, 1);
    }

    level thread scripts\mp\gametypes\br::ref_13AC7("br_extract_heli_incoming", var_3, var_3.team);
    thread so_endgame(var_6);
  } else {
    playerdenyextraction(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    var_4 = scripts\engine\utility::ter_op(istrue(level.ref_13368) && !istrue(level.ref_13363), var_0.audio_jugg_spawn, var_0.audio_shf_kill_hangar_lights);
    var_0 setscriptablepartstate(var_0.type, var_4);
    return;
  }

  if(istrue(level.ref_127BA)) {
    var_7 = scripts\common\utility::playersincylinder(var_0.origin, 15000);
    var_8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_3.team, var_3.squadindex);

    foreach(var_10 in var_7) {
      if(!scripts\engine\utility::array_contains(var_8, var_10)) {
        var_10 thread scripts\mp\hud_message::showsplash("br_extract_heli_incoming_them", undefined, var_3);
      }
    }
  }

  if(istrue(level.ref_11DAD)) {
    var_0.disabled = 1;
    var_4 = scripts\engine\utility::ter_op(istrue(level.ref_13368) && !istrue(level.ref_13363), var_0.little_bird_onexitheavydamagestate, var_0.load_relics_from_playlistdvars);
    var_0 setscriptablepartstate(var_0.type, var_4);
    level thread scripts\mp\gametypes\br_gametype_dmz::play_tape_machine_animations(var_0);
  }
}

function ref_126C7() {
  self endon("death_or_disconnect");
  scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_plunder_smoke", 1.867);
}

function playerdenyextraction(var_0, var_1) {
  self iprintlnbold(var_1);
  self playlocalsound("br_pickup_deny");

  if(isDefined(var_0)) {
    var_2 = self getweaponammoclip(var_0);
    self setweaponammoclip(var_0, var_2 + 1);
    return;
  }
}

function init_trap_room_spawning_module(var_0) {
  wait 1.35;
  var_1 = spawn("script_model", var_0);
  var_1 setModel("scr_smoke_grenade");
  var_1.angles = (0, 90, 90);
  var_1 playSound("smoke_carepackage_expl_trans");
  var_1 playLoopSound("smoke_carepackage_smoke_lp");
  var_1 setscriptablepartstate("smoke", "on");
  wait 17;
  var_1 endon("death");
  var_1 setscriptablepartstate("smoke", "dissipate");
  var_1 playSound("smoke_canister_tail_dissipate");
  wait 1;
  var_1 stoploopsound();
  wait 4.5;
  var_1 delete();
}

function playerspawnextractchopper(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, 2000);
  var_4 = var_2 + (0, 0, 8000);
  var_5 = var_2 + (0, 0, 800);
  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = getdvarint("scr_dmz_plunder_use_structs", 0);

  if(var_8) {
    var_9 = relic_squadlink_turn_team_headobjectives(var_2);

    if(isDefined(var_9)) {
      var_10 = var_9.script_noteworthy;
      var_7 = var_10.angles;
    } else {
      var_6 = relic_award_one_bullet(var_1, var_4, var_3);
      var_7 = (0, var_6, 0);
    }
  } else {
    var_6 = relic_award_one_bullet(var_1, var_4, var_3);
    var_7 = (0, var_6, 0);
  }

  if(getdvarint("scr_br_plunder_heli_adjust_bag", 0) == 1) {
    var_11 = -100;
    var_12 = 60;
    var_13 = anglesToForward(var_7);
    var_14 = anglestoright(var_7);
    var_2 = var_2 + var_13 * var_11 + var_14 * var_12;
    var_3 = var_2 + (0, 0, 2000);
    var_5 = var_2 + (0, 0, 800);
  }

  var_15 = var_4 - anglesToForward(var_7) * 20000;
  var_16 = spawnheli(self, var_15, var_3, var_5, var_2);
  return var_16;
}

function relic_squadlink_turn_team_headobjectives(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.ref_127C5) {
    if(isDefined(var_3) && distance2dsquared(var_3.origin, var_0) <= 10000) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

function relic_award_one_bullet(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_0.player_respawn)) {
    return var_0.player_respawn;
  }

  var_3 = 10;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  var_5 = 0;
  var_6 = 0;

  while(var_6 < 360) {
    var_5 += var_6;
    var_7 = (0, var_5, 0);
    var_8 = var_1 - anglesToForward(var_7) * 20000;
    var_9 = var_2;
    var_10 = scripts\engine\trace::sphere_trace(var_8, var_9, 100, undefined, var_4, 1);

    if(var_10["fraction"] == 1) {
      if(isDefined(var_0)) {
        var_0.player_respawn = var_5;
      }

      return var_5;
    }

    if(var_6 % 3 == 0) {
      waitframe();
    }

    var_6 += var_3;
  }

  return var_5;
}

function drophelicrate(var_0) {
  if(!isDefined(var_0.plunder)) {
    return;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_fail_chopper", self.team, 1);
  ref_12782(self.crate, 0);
  var_1 = self.crate;
  self.crate = undefined;
  var_1.plunder = var_0.plunder;
  var_2 = var_1.origin;
  var_3 = (var_2[0], var_2[1], -12000);
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0, var_4);
  var_6 = var_5["position"];
  var_7 = var_2[2] - var_6[2];

  if(var_7 > 0) {
    var_8 = sqrt(2 * var_7 / 800);
    var_1 moveTo(var_6, var_8, var_8, 0);
    wait var_8;
  }

  var_1.origin = var_6;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_6);
  num_rocket_per_attack(var_1, 1);
  thread smokinggunprogress(var_1);
}

function frag_crate_spawn(var_0, var_1, var_2) {
  var_3 = var_0 * 1.57828e-05;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + sqrt(var_5 * var_5 - 4 * var_4 * var_6)) / 2 * var_4;
  var_7 *= 3600;
  var_7 += 1.5;
  return var_7;
}

function frag_crate_player_at_max_ammo(var_0) {
  var_1 = frag_crate_spawn(20000, 100, 125);
  var_2 = frag_crate_spawn(var_0, 25, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

function so_endgame(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = self.originalangle[2];
  var_2 = self.lastweaponfiretimeend[2] - var_1;
  self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var_2);
  thread heliwatchgameendleave();
  self.ref_1287C = 1;
  helidescend();
  self.ref_1287C = undefined;
  self setscriptablepartstate("vector_field", "on");

  if(!istrue(level.gameended)) {
    if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_chopper_arrive", self.team, 1);
    }

    thread sound_distraction_mechanic_init(var_0);
    return;
  }

  thread sol_3_4_pool(1);
}

function sound_distraction_mechanic_init(var_0) {
  var_1 = undefined;

  if(var_0.type == "brloot_plunder_extraction_site_01") {
    var_1 = "plunderHelipad1";
  } else if(var_0.type == "brloot_plunder_extraction_site_02") {
    var_1 = "plunderHelipad2";
  } else if(var_0.type == "brloot_quest_extract_site_plunder") {
    var_1 = "extractHelipadPlunder";
  } else if(var_0.type == "brloot_quest_extract_site_br") {
    var_1 = "extractHelipadBR";
  }

  ref_12796(var_0, var_1);
  var_2 = undefined;

  if(isDefined(self.team)) {
    var_2 = scripts\mp\utility\teams::getfriendlyplayers(self.team);
  }

  thread ref_127A4(var_0, var_2);
  ref_127AA(var_0, var_2);
}

function smoke_door(var_0) {
  if(!istrue(level.gameended) && !scripts\mp\gametypes\br_public::uniquelootitemid()) {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_success", self.team, 1);
  }

  var_1 = num_players_in_safehouse(var_0);

  if(isDefined(var_1) && isDefined(var_1.brwatchforminplayersmatchstart) && var_1.brwatchforminplayersmatchstart > 0) {
    level.br_plunder.oscope_sign_think += var_1.brwatchforminplayersmatchstart;
    level.br_plunder.oscope_sign++;
    return;
  }
}

function ref_13694(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("misc_rapelling_rope_01_fiber_br");
  var_1 linkTo(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  var_1.animname = var_0.animname;
  var_1 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "rope_in", "origin_animate_jnt");
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("br_plunder_extraction_delivery_bag");
  var_2 linkTo(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  var_2.animname = var_0.animname;
  var_2 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "bag_in", "origin_animate_jnt");
  var_0.rope = var_1;
  var_0.crate = var_2;
}

function spawnheli(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = vectortoangles(var_2 * (1, 1, 0) - var_1 * (1, 1, 0));
  var_7 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_1, var_6, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x");

  if(!isDefined(var_7)) {
    return;
  }

  var_7.damagecallback = &callback_vehicledamage;
  var_7.speed = 100;
  var_7.accel = 125;
  var_7.health = scripts\engine\utility::ter_op(scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war", level.overheatlimit, 1000);
  var_7.maxhealth = var_7.health;
  var_7.team = var_0.team;
  var_7.owner = var_0;
  var_7.lifeid = 0;
  var_7.flaresreservecount = var_5;
  var_7.nuke_vault_riotshield_internal = var_1;
  var_7.lastweaponfiretimeend = var_2;
  var_7.spawn_sentries_from_targetname = var_3;
  var_7.originalangle = var_4;
  var_7.ref_12EE8 = var_6;
  var_7.vehiclename = "magma_plunder_chopper";
  var_7.animname = "plunder_extract_heli";
  var_7 setCanDamage(1);
  var_7 setmaxpitchroll(10, 25);
  var_7 vehicle_setspeed(var_7.speed, var_7.accel);
  var_7 sethoverparams(1, 1, 1);
  var_7 setturningability(0.05);
  var_7 setyawspeed(45, 25, 25, 0.5);
  var_7 setotherent(var_0);
  var_7 setscriptablepartstate("engine", "on");
  var_7 setscriptablepartstate("tail_light", "red");
  var_7 setscriptablepartstate("cockpit_light", "on");
  var_7 setscriptablepartstate("infil_lights", "on");
  var_7.scenenode = spawn("script_model", var_7.originalangle);
  var_7.scenenode.angles = var_7.ref_12EE8;
  var_7.scenenode setModel("tag_origin");
  var_7.scenenode scripts\common\anim::anim_first_frame_solo(var_7, "heli_in");
  ref_13694(var_7);
  return var_7;
}

function smokinggunprogress(var_0) {
  ref_12786(self);
  self hide();

  if(isDefined(var_0)) {
    var_0.crate = undefined;
  }

  waitframe();
  self delete();
}

function smuggler_post_tele_kill() {
  self endon("heli_gone");
  var_0 = self.owner;
  self waittill("death", var_1, var_2, var_3, var_4);
  var_5 = 0;

  if(isDefined(self.plunder)) {
    foreach(var_7 in self.plunder) {
      var_5 += var_7.plundercount;
    }
  }

  scripts\mp\gametypes\br_analytics::detonatefunc(var_5, "little_bird", self.originalangle, self.origin);
  thread drophelicrate(self);
  smoke_enemy_think();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread smokesignal(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  snowballfighthint(var_1);
}

function smoke_enemy_think() {
  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(isDefined(self.crate)) {
    thread smokinggunprogress(self.crate);
  }

  if(isDefined(self.scenenode)) {
    self.scenenode delete();
    return;
  }
}

function snowballfighthint(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread scripts\mp\gametypes\br::ref_13AC7("br_extract_heli_shot_down", self.owner, self.team);
  smuggler_killed_early();
}

function smuggler_killed_early() {
  smoke_enemy_think();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function smokesignal(var_0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if(istrue(level.overheatreductionamount)) {
    return;
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function sol_3_4_pool(var_0) {
  if(istrue(self.ref_13E15) || istrue(self.leaving)) {
    return;
  }

  self endon("death");
  self notify("try_to_leave");
  self.ref_13E15 = 1;

  if(!istrue(level.gameended) && !scripts\mp\gametypes\br_public::uniquelootitemid()) {
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("plunder_extract_chopper_leave", self.team, 1);
  }

  var_1 = self.site;

  if(isDefined(var_1)) {
    ref_1279A(var_1);
    smoke_door(var_1);

    if(isDefined(var_1.heli) && var_1.heli == self) {
      var_1.heli = undefined;
      var_1.team = undefined;
      var_1 notify("heli_left");
    }

    thread skip_charge_plant(var_1);
    self.site = undefined;
  }

  self.ref_12A47 = 1;
  self waittill("ready_to_leave");
  self notify("leaving");
  self.leaving = 1;
  self.ref_13E15 = undefined;
  var_2 = getanimlength(level.scr_anim[self.animname]["heli_out"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_out");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_out", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "bag_out", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  self stoploopsound();
  self notify("heli_gone");
  smuggler_killed_early();
}

function skip_charge_plant(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(level.ref_13368) && !istrue(level.ref_13363), "inuseCurrent", "inuse");
  self setscriptablepartstate(var_0, var_1);
  wait 6;

  if(isDefined(self)) {
    var_1 = scripts\engine\utility::ter_op(istrue(level.ref_13368) && !istrue(level.ref_13363), self.audio_jugg_spawn, self.audio_shf_kill_hangar_lights);
    self setscriptablepartstate(var_0, var_1);
    return;
  }
}

function helidescend() {
  self endon("death");
  var_0 = getanimlength(level.scr_anim[self.animname]["heli_in"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_in");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_in", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "bag_in", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  thread soldier_agent_lwfn9();
  thread sololink();
  thread soldier_encounter_test();
}

function soldier_agent_lwfn9() {
  self endon("death");
  self.scenenode endon("death");
  var_0 = getanimlength(level.scr_anim[self.animname]["heli_loop"]);

  for(;;) {
    self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_loop");
    wait var_0;

    if(istrue(self.ref_12A47) && !istrue(self.ref_1287C)) {
      self notify("ready_to_leave");
      break;
    }
  }
}

function sololink() {
  self endon("death");
  var_0 = getanimlength(level.scr_anim[self.animname]["rope_loop"]);

  for(;;) {
    thread scripts\common\anim::anim_single_solo(self.rope, "rope_loop", "origin_animate_jnt");
    wait var_0;

    if(istrue(self.ref_12A47)) {
      break;
    }
  }
}

function soldier_encounter_test() {
  self endon("death");
  var_0 = getanimlength(level.scr_anim[self.animname]["bag_loop"]);

  for(;;) {
    thread scripts\common\anim::anim_single_solo(self.crate, "bag_loop", "origin_animate_jnt");
    wait var_0;

    if(istrue(self.ref_12A47)) {
      break;
    }
  }
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function snapplayertotoppos() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && nuke_vault_suicidebomber_internal(var_0)) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

function snappointtooutofboundstriggertrace() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::create_vehicle_contents();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("test_f", var_2) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_m", var_3) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("test_b", var_4) + (0, 0, getdvarfloat("test_d", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && nuke_vault_suicidebomber_internal(var_10)) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

function tracegroundheight(var_0) {
  var_1 = 800;
  var_2 = tracegroundpoint(var_0);
  var_3 = var_2 + var_1;
  return var_3;
}

function tracegroundpoint(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = -99999;
  var_2 = (var_0[0], var_0[1], var_1);
  var_3 = [self];
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 1, 1, 0);
  var_5 = scripts\engine\trace::sphere_trace(var_0, var_2, 100, var_3, var_4, 1);
  var_6 = var_5["position"][2];
  return var_6;
}

function heliwatchgameendleave() {
  self endon("death");
  self endon("try_to_leave");
  level waittill("game_ended");
  thread sol_3_4_pool(0);
}

function smokekill(var_0, var_1) {
  ref_1279D(var_0);
}

function snowfx(var_0) {
  if(isDefined(var_0.heli)) {
    thread sol_3_4_pool(var_0.heli);
    return;
  }
}

function smodelcollections(var_0) {}

function plunderlivelobby() {
  thread autopickupplunder();
}

function inplunderlivelobby() {
  return istrue(level.br_plunder_enabled) && istrue(level.br_plunder_lobby) && !scripts\mp\flags::gameflag("prematch_done");
}

function autopickupplunder() {
  var_0 = 0.1;
  var_1 = 25;
  var_2 = var_1 * var_1;

  while(inplunderlivelobby()) {
    for(var_3 = 0; var_3 < level.br_plunder_ents.size; var_3++) {
      var_4 = level.br_plunder_ents[var_3];

      if(!isDefined(var_4)) {
        continue;
      }

      var_5 = var_4.origin;

      for(var_6 = 0; var_6 < level.players.size; var_6++) {
        var_7 = level.players[var_6];

        if(!isalive(var_7)) {
          continue;
        }

        var_8 = distancesquared(var_7.origin, var_5);

        if(var_8 < var_2) {
          var_7 scripts\mp\gametypes\br_pickups::brpickupsusecallback(var_4, var_7);
          break;
        }
      }
    }

    wait var_0;
  }
}

function playerdelayautobankplunder() {
  self notify("playerDelayAutoBankPlunder");
  self endon("playerDelayAutoBankPlunder");
  self endon("death");
  level endon("prematch_done");
  level endon("game_ended");
  wait 2;
  ref_12618(self.plundercount);
}

function playerplunderlivelobbydropondeath(var_0) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  if(inplunderlivelobby()) {
    var_1 = var_0 == "MOD_MELEE";
    var_2 = 1;

    if(var_1 && isDefined(self.plundercount) && self.plundercount > 1) {
      var_2 = self.plundercount;
      playersetplundercount(0);
    }

    if(var_2 <= 0) {
      return;
    }

    if(level.br_plunder_ents.size > 0) {
      level.br_plunder_ents = scripts\engine\utility::array_removeundefined(level.br_plunder_ents);
    }

    var_3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    return ml_p3_func(var_2, var_3);
  }
}

function touchdown_origin() {
  foreach(var_1 in level.teamnamelist) {
    level.teamdata[var_1]["plunderTeamTotal"] = 0;
    level.teamdata[var_1]["plunderInDeposit"] = 0;
    level.teamdata[var_1]["plunderBanked"] = 0;
  }

  if(getDvar("scr_br_gametype", "") == "risk") {
    foreach(var_1 in level.teamnamelist) {
      level.teamdata[var_1]["tokensTeamTotal"] = 0;
      level.teamdata[var_1]["tokensInDeposit"] = 0;
      level.teamdata[var_1]["tokensBanked"] = 0;
    }

    return;
  }
}

function retry_no_votes(var_0) {
  var_1 = level.br_plunder.names[0];

  for(var_2 = level.br_plunder.ref_12954.size - 1; var_2 > 0; var_2--) {
    if(var_0 >= level.br_plunder.ref_12954[var_2]) {
      var_1 = level.br_plunder.names[var_2];
      break;
    }
  }

  return var_1;
}

function ref_1275D(var_0, var_1) {
  if(var_1 == 0) {
    return;
  }

  var_2 = retry_no_votes(var_1);
  var_3 = scripts\mp\gametypes\br_pickups::getcashsoundaliasforplayer(var_0, var_2);
  var_0 playsoundtoplayer(var_3, self);
}

function ref_128A7() {
  var_0 = getdvarint("scr_plunderPileOverride_scalar", 1);

  if(var_0 <= 1) {
    return;
  }

  foreach(var_9, var_2 in level.br_pickups.counts) {
    if(!issubstr(var_9, "brloot_plunder_cash")) {
      continue;
    }

    var_3 = level.br_pickups.counts[var_9];
    var_4 = var_3 * var_0;
    level.br_pickups.counts[var_9] = var_4;
    var_5 = getentitylessscriptablearrayinradius(var_9);

    if(var_5.size >= 1) {
      foreach(var_7 in var_5) {
        var_7.count = var_4;
      }
    }
  }

  for(var_10 = 0; var_10 < level.br_plunder.names.size; var_10++) {
    level.br_plunder.ref_12954[var_10] = level.br_pickups.counts[level.br_plunder.names[var_10]];
  }
}

function ref_128A6(var_0) {
  foreach(var_7, var_2 in level.br_plunder.names) {
    level.br_plunder.ref_12954[var_7] = int(float(level.br_plunder.ref_12954[var_7]) * var_0);
    level.br_pickups.counts[var_2] = level.br_plunder.ref_12954[var_7];
    var_3 = getentitylessscriptablearrayinradius(var_2);

    foreach(var_5 in var_3) {
      var_5.count = level.br_plunder.ref_12954[var_7];
    }

    waitframe();
  }
}

function ismountconfigenabled() {
  var_0 = 0;

  foreach(var_2 in level.br_plunder.names) {
    var_3 = getentitylessscriptablearrayinradius(var_2);
    var_0 += var_3.size * level.br_pickups.counts[var_2];
  }

  var_0 *= 100;
  level.ref_13BEC = var_0;
}

function ref_1278E() {
  level.ref_127C7 = spawnStruct();
  level.ref_127C7.data = [];
  level.ref_127C7.instances = [];
  level.ref_127C7.uniqueinstanceid = 0;
  level.ref_127C7.ref_13AA6 = [];
  level.ref_127C7.ref_13AA3 = [];
  level.ref_127C7.ref_13AA4 = [];

  for(var_0 = 1; var_0 <= 4; var_0++) {
    level.ref_127C7.ref_13AA3[var_0] = "ui_br_plunder_repo_ent_" + var_0;
    level.ref_127C7.ref_13AA4[var_0] = "ui_br_plunder_repo_info_" + var_0;
  }

  scripts\common\interactive::interactive_addusedcallback(&ref_127A1, "plunderRepository");
  scripts\engine\scriptable::scriptable_addusedcallback(&ref_127A3);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&ref_12795);
  level.ref_127D4 = getdvarint("scr_br_plunderUseDisabledWhenEmpty", 0) > 0;
}

function ref_1278C(var_0, var_1, var_2) {
  var_3 = level.ref_127C7;
  var_4 = var_3.data[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.data[var_0] = var_4;
      var_4.usetime = 0.75;
      var_4.ref_14077 = 2;
      var_4.ref_14075 = 250;
      var_4.ref_13ACC = 1;
      var_4.ref_13AA5 = 0;
      var_4.ref_1407A = "MP/CANNOT_DEPOSIT_LS";
      var_4.ref_1407C = "MP/CANNOT_DEPOSIT_VEHICLE";
      var_4.ref_14078 = "MP/PLACEHOLDER_CANNOT_DEPOSIT_FULL";
      var_4.ref_1407B = "MP/CANNOT_DEPOSIT_NO_CASH";
      var_4.ref_14079 = "MP/PLACEHOLDER_CANNOT_DEPOSIT_LEAVING";
      var_4.ref_12F7D = undefined;
      var_4.ref_12F7E = undefined;
      var_4.ref_12F77 = undefined;
      var_4.origin_delta = 60;
      var_4.overrideviewkickscaledmr = 0;
      var_4.original_disablelongdeath = "MP/PLACEHOLDER_LEAVING_IN_N";
      var_4.get_closest_enemy_near_turret = 2000;
      var_4.ref_14098 = undefined;
      var_4.ref_14068 = &ref_1279F;
      var_4.impactwatcher = undefined;
      var_4.org_in_bad_place = undefined;
      var_4.outline_enemy_ai_for_duration = undefined;
    }
  }

  return var_4;
}

function ref_12796(var_0, var_1) {
  var_2 = level.ref_127C7;
  var_3 = ref_1278C(var_1);
  var_0.ref_127C8 = var_1;
  var_0.startorigin = var_0.origin;
  var_0.plunder = [];
  var_0.ref_127D0 = 0;
  var_0.ref_127BD = level.ref_127C7.uniqueinstanceid;
  level.ref_127C7.uniqueinstanceid++;
  var_0.ref_126BE = [];
  var_2.instances[var_0.ref_127BD] = var_0;
  ref_12780(var_0);

  if(!isDefined(var_3.ref_12F7D)) {
    var_0 scripts\common\interactive::interactive_addusedcallbacktoentity("plunderRepository");
  }

  ref_12782(var_0, 1);
}

function ref_12786(var_0) {
  var_1 = level.ref_127C7;
  var_0 notify("plunder_instance_deregistered");
  ref_12782(var_0, 0, 1);
  var_0.ref_127C8 = undefined;
  var_0.ref_127D3 = undefined;
  var_0.ref_127AE = undefined;
  var_0.startorigin = undefined;
  var_0.plunder = undefined;
  var_0.ref_127D0 = undefined;
  ref_1279A(var_0);
  var_0.ref_126BE = undefined;

  if(isDefined(var_0.ref_127BD)) {
    var_1.instances[var_0.ref_127BD] = undefined;
  }

  ref_12797(var_0);
  var_0 scripts\common\interactive::interactive_removeusedcallbackfromentity();
}

function ref_1279E(var_0) {
  var_1 = level.ref_127C7;

  if(!isDefined(var_1)) {
    return false;
  }

  var_2 = undefined;

  if(isDefined(var_0.ref_127BD)) {
    var_2 = var_1.instances[var_0.ref_127BD];
  }

  return isDefined(var_2) && var_2 == var_0;
}

function ref_12782(var_0, var_1, var_2) {
  var_0 notify("plunder_allowRepositoryUse");
  var_3 = undefined;

  if(isDefined(var_0.ref_127C8)) {
    var_3 = ref_1278C(var_0.ref_127C8, undefined, var_2);
  }

  if(isDefined(var_3)) {
    if(isDefined(var_3.ref_12F7D)) {
      if(var_1) {
        var_0 setscriptablepartstate(var_3.ref_12F7D, var_3.ref_12F7E, 0);
      } else {
        var_0 setscriptablepartstate(var_3.ref_12F7D, var_3.ref_12F77, 0);
      }
    } else if(var_1) {
      var_0 makeusable();
    } else {
      var_0 makeunusable();
    }

    var_4 = istrue(var_0.ref_127D3);
    var_0.ref_127D3 = scripts\engine\utility::ter_op(var_1, var_1, undefined);

    if(!var_4) {
      if(var_1) {
        foreach(var_6 in level.players) {
          ref_12783(var_0, var_6, ref_12793(var_0, var_6));
        }

        return;
      }

      return;
    }

    if(!var_4) {
      var_3 notify("repository_use_disabled");
      return;
    }

    return;
  }
}

function ref_12783(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_0.ref_127C8)) {
    var_4 = ref_1278C(var_0.ref_127C8, undefined, var_3);
  }

  if(isDefined(var_4)) {
    if(isDefined(var_4.ref_12F7D)) {
      if(var_2) {
        var_0 enablescriptablepartplayeruse(var_4.ref_12F7D, var_1);
      } else {
        var_0 disablescriptablepartplayeruse(var_4.ref_12F7D, var_1);
      }
    } else if(var_2) {
      var_0 enableplayeruse(var_1);
    } else {
      var_0 disableplayeruse(var_1);
    }
  }

  if(!var_2) {
    var_0 notify("repository_use_disabled_for_" + var_1 getentitynumber());
    return;
  }
}

function ref_12781(var_0, var_1, var_2) {
  var_3 = level.ref_127C7;

  foreach(var_5 in var_3.instances) {
    if(isDefined(var_5)) {
      ref_12783(var_5, var_0, var_1, 1);
    }
  }
}

function ref_12793(var_0, var_1) {
  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(scripts\mp\utility\player::unset_relic_trex(var_1)) {
    return false;
  }

  var_2 = ref_1278C(var_0.ref_127C8);
  var_3 = istrue(var_2.ref_13ACC) || istrue(var_0.playerplunderbankdepositcallback);

  if(var_3 && isDefined(var_0.team) && var_1.team != var_0.team) {
    return false;
  }

  return true;
}

function ref_12794(var_0, var_1, var_2) {
  var_3 = ref_1278C(var_0.ref_127C8);

  if(!istrue(var_0.ref_127D3)) {
    return 0;
  }

  if(var_3.ref_14077 == 7) {
    if(var_0.team != var_1.team) {
      if(!isDefined(var_3.brking_ispointinmovingcircle) || !istrue(var_3.brking_ispointinmovingcircle)) {
        var_1 playlocalsound("br_plunder_atm_cancel");

        if(isDefined(var_3.stealfailmsg7) && var_3.stealfailmsg7 != "") {
          var_1 scripts\mp\hud_message::showerrormessage(var_3.stealfailmsg7);
        }

        return 0;
      }

      if(var_0.ref_127D0 <= 0) {
        var_1 playlocalsound("br_plunder_atm_cancel");
        var_1 scripts\mp\hud_message::showerrormessage(var_3.stealfailmsg7);
        return 0;
      }
    } else if(var_0.team == var_1.team && (!isDefined(var_1.plundercount) || var_1.plundercount <= 0)) {
      if(istrue(var_2) && isDefined(var_3.ref_1407B) && var_3.ref_1407B != "") {
        var_1 playlocalsound("br_plunder_atm_cancel");
        var_1 scripts\mp\hud_message::showerrormessage(var_3.ref_1407B);
      }

      return 0;
    }
  }

  if(var_3.ref_14077 == 2 || var_3.ref_14077 == 3) {
    if(!isDefined(var_1.plundercount) || var_1.plundercount <= 0 && (!isDefined(var_1.overheatreductiontime) || isDefined(var_1.override_minimap_hide) && isDefined(var_0.index) && var_1.override_minimap_hide != var_0.index)) {
      if(istrue(var_2) && isDefined(var_3.ref_1407B) && var_3.ref_1407B != "") {
        var_1 playlocalsound("br_plunder_atm_cancel");
        var_1 scripts\mp\hud_message::showerrormessage(var_3.ref_1407B);
      }

      return 0;
    } else if(istrue(var_0.ref_127AE)) {
      if(istrue(var_2) && isDefined(var_3.ref_14078) && var_3.ref_14078 != "") {
        var_1 playlocalsound("br_plunder_atm_cancel");
        var_1 scripts\mp\hud_message::showerrormessage(var_3.ref_14078);
      }

      return 0;
    }
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(istrue(var_2) && isDefined(var_3.ref_1407C) && var_3.ref_1407C != "") {
      var_1 playlocalsound("br_plunder_atm_cancel");
      var_1 scripts\mp\hud_message::showerrormessage(var_3.ref_1407C);
    }

    return 0;
  }

  if(scripts\mp\utility\player::unset_relic_trex(var_1)) {
    if(istrue(var_2) && isDefined(var_3.ref_1407A) && var_3.ref_1407A != "") {
      var_1 playlocalsound("br_plunder_atm_cancel");
      var_1 scripts\mp\hud_message::showerrormessage(var_3.ref_1407A);
    }

    return 0;
  }

  if(var_1 isparachuting() || var_1 isskydiving()) {
    return 0;
  }

  if(var_1 isinexecutionattack() || var_1 isinexecutionvictim()) {
    return 0;
  }

  if(isDefined(var_3.ref_14098)) {
    return [[var_3.ref_14098]](var_0, var_1, var_2);
  }

  return 1;
}

function ref_127A3(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  var_5 = var_0.entity;

  if(!isDefined(var_5) || isDefined(var_5.playermaxheath)) {
    var_5 = var_0;
  }

  if(!ref_1279E(var_5)) {
    return;
  }

  var_6 = ref_1278C(var_5.ref_127C8);

  if(!isDefined(var_6.ref_12F7D)) {
    return;
  }

  if(var_1 != var_6.ref_12F7D) {
    return;
  }

  if(var_2 != var_6.ref_12F7E) {
    return;
  }

  if(!ref_12794(var_5, var_3, 1)) {
    return;
  }

  thread ref_127A2(var_5, var_3);
}

function ref_127A1(var_0, var_1) {
  if(!ref_1279E(var_0)) {
    return;
  }

  if(!ref_12794(var_0, var_1, 1)) {
    return;
  }

  thread ref_127A2(var_0, var_1);
}

function ref_127A2(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = gettime();
  ref_1279B(var_1, 1);
  ref_12783(var_0, var_1, 0);
  ref_127A5(var_0, var_1);

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      ref_12783(var_0, var_1, 1);
    }

    if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      ref_1279B(var_1, 0);
    }

    var_1.ref_127C9 = undefined;

    if(isPlayer(var_1)) {
      var_4 = 0;
      var_5 = undefined;

      if(!var_4 && var_1 scripts\cp_mp\utility\player_utility::_isalive() && !var_1 scripts\cp_mp\utility\player_utility::isinvehicle() && !scripts\mp\utility\player::unset_relic_trex(var_1)) {
        if(istrue(var_0.oscope_ampl)) {
          var_5 = 2;
        } else if(isDefined(var_1.ref_127CA) && isDefined(var_1.ref_127CA.ref_14076) && var_1.ref_127CA.ref_14076 - gettime() <= 1.5) {
          var_5 = 1.5;
        }
      }

      thread ref_12785(var_1, var_5);
    }
  }

  if(isDefined(var_0) && isDefined(var_0.ref_126BE)) {
    var_0.ref_126BE[var_2] = undefined;
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    ref_127AA(var_0, var_1);
    return;
  }
}

function ref_127A5(var_0, var_1) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_0 endon("death");
  var_0 endon("repository_use_disabled");
  var_0 endon("repository_use_disabled_for_" + var_1 getentitynumber());
  level endon("game_ended");
  var_2 = ref_1278C(var_0.ref_127C8);
  var_0.ref_126BE[var_1 getentitynumber()] = var_1;
  ref_127AB(var_1, var_0.ref_127BD, var_2.type, 1, var_0.ref_127AF, var_0.ref_127D0);
  ref_127A6(var_1);
  ref_127AA(var_0, var_1);
  var_3 = 0;
  var_4 = 0;
  var_5 = var_2.usetime;
  var_6 = 0;
  var_7 = 0;

  while(var_1 useButtonPressed()) {
    var_8 = undefined;

    if(var_3) {
      var_3 = 0;
      var_8 = 0;
    } else {
      var_8 = 1;
    }

    if(!ref_12794(var_0, var_1, var_8)) {
      return;
    }

    if(var_4 >= var_5) {
      if(var_2.ref_14077 == 7 && var_0.team != var_1.team) {
        var_7 = int(var_2.stealamount);
        var_5 = var_4 + var_2.stealtime;
      } else {
        var_7 = int(min(var_1.plundercount, var_2.ref_14075));
        var_5 = var_4 + var_2.usetime;
      }

      if(isDefined(var_2.ref_14068)) {
        thread[[var_2.ref_14068]](var_0, var_1, var_7);
      }

      var_6 = var_4;

      if(isDefined(var_1.ref_127CA)) {
        var_1.ref_127CA.ref_14076 = gettime();
      }

      var_3 = 1;
    }

    wait 0.05;
    var_4 += 0.05;
  }
}

function ref_1279F(var_0, var_1, var_2) {
  var_3 = ref_1278C(var_0.ref_127C8);
  var_4 = ref_1261F(var_1, var_2, var_3.ref_14077, var_0);

  if(isDefined(var_4) && isDefined(var_4.amount)) {
    var_2 = var_4.amount;
  }

  if(var_2 > 0) {
    ref_127AB(var_1, undefined, undefined, undefined, undefined, var_0.ref_127D0, var_2);
    ref_127A6(var_1);
    return;
  }
}

function ref_1279B(var_0, var_1) {
  var_2 = ["movement", "usability", "weapon_switch", "equipment", "supers", "killstreaks", "fire", "melee", "reload", "ads", "mantle", "mount_top", "mount_side", "execution_attack", "vehicle_use", "cough_gesture"];

  if(istrue(var_0.ref_127C9) && var_1) {
    return;
  }

  if(!istrue(var_0.ref_127C9) && !var_1) {
    return;
  }

  var_0 scripts\common\utility::allow_array(var_2, !var_1);

  if(var_1) {
    var_0.ref_127C9 = 1;
    return;
  }

  var_0.ref_127C9 = undefined;
}

function ref_127A4(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("plunder_instance_deregistered");
  var_0 notify("plunder_repositoryWatchCountdown");
  var_0 endon("plunder_repositoryWatchCountdown");
  level endon("game_ended");
  var_2 = ref_1278C(var_0.ref_127C8);

  if(!isDefined(var_0.ref_127B1)) {
    var_0.ref_127B1 = [];
    var_0.ref_127B2 = 0;
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2.overrideviewkickscaledmr), var_2.overrideviewkickscaledmr, 0);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_2.origin_delta), var_2.origin_delta, 0);
    var_0.ref_127CB = gettime() + var_3 * 1000;
    var_0.ref_127AF = gettime() + (var_3 + var_4) * 1000;
  }

  if(isDefined(var_1)) {
    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_6 in var_1) {
      if(isDefined(var_6) && isPlayer(var_6)) {
        var_0.ref_127B1[var_6 getentitynumber()] = var_6;
      }
    }
  }

  while(gettime() <= var_0.ref_127AF) {
    if(gettime() - var_0.ref_127B2 >= 1000) {
      if(gettime() > var_0.ref_127CB) {
        var_8 = int(max(0, (var_0.ref_127AF - gettime()) / 1000));

        foreach(var_6 in var_0.ref_127B1) {
          if(isDefined(var_6)) {
            thread ref_127A0(var_6, var_0, var_8);
          }
        }
      }

      var_0.ref_127B2 = gettime();
    }

    wait 0.05;
  }

  thread ref_1279C(var_0, 1);
}

function ref_1279C(var_0, var_1) {
  ref_1279A(var_0);
  var_2 = ref_1278C(var_0.ref_127C8);

  if(isDefined(var_2.impactwatcher)) {
    [[var_2.impactwatcher]](var_0, var_1);
    return;
  }
}

function ref_1279A(var_0) {
  var_0 notify("plunder_repositoryWatchCountdown");
  var_0.ref_127B1 = undefined;
  var_0.ref_127AF = undefined;
  var_0.ref_127B2 = undefined;
}

function ref_127A0(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_0 notify("plunder_repositorySendCountdownMessage");
  var_0 endon("plunder_repositorySendCountdownMessage");
  level endon("game_ended");

  if(!isDefined(var_0.ref_127B0)) {
    var_0.ref_127B0 = [];
  }

  var_3 = ref_1278C(var_1.ref_127C8);

  if(isDefined(var_3.original_disablelongdeath)) {
    var_4 = spawnStruct();
    var_4.origin = var_1.origin;
    var_4.msg = var_3.original_disablelongdeath;
    var_4.value = var_2;
    var_0.ref_127B0[var_0.ref_127B0.size] = var_4;
  }

  waittillframeend();

  if(!var_0 scripts\mp\gametypes\br_public::isplayeringulag() && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_5 = undefined;
    var_6 = 2147483647;

    foreach(var_4 in var_0.ref_127B0) {
      var_8 = distance2dsquared(var_0.origin, var_4.origin);

      if(var_8 < var_6) {
        var_6 = var_8;
        var_5 = var_4;
      }
    }
  }

  var_0.ref_127B0 = undefined;
}

function ref_1279D(var_0) {
  var_0.oscope_ampl = 1;
  ref_1279A(var_0);
  ref_12782(var_0, 0);
  ref_12797(var_0);
  var_1 = ref_1278C(var_0.ref_127C8);

  if(isDefined(var_1.org_in_bad_place)) {
    [[var_1.org_in_bad_place]](var_0);
    return;
  }
}

function ref_12799(var_0) {
  var_0.ref_127AE = 1;
  ref_12782(var_0, 0);
  var_1 = ref_1278C(var_0.ref_127C8);

  if(isDefined(var_1.carriable_error_messsage_watch)) {
    [[var_1.carriable_error_messsage_watch]](var_0);
    return;
  }
}

function ref_12795() {
  ref_12781(self, 1, 1);
}

function ref_127AB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3) && !var_3) {
    ref_12785(var_0);
    return;
  }

  var_7 = var_0.ref_127CA;

  if(!isDefined(var_7)) {
    var_7 = spawnStruct();
    var_0.ref_127CA = var_7;
    var_7.ref_127BD = var_1;
    var_7.type = var_2;
    var_7.visible = 0;
    var_7.endtime = undefined;
    var_7.ref_127D0 = undefined;
    var_7.ref_127B7 = undefined;
    var_7.timestamp = undefined;
  } else if(isDefined(var_1) && isDefined(var_7.ref_127BD) && var_1 != var_7.ref_127BD) {
    return;
  }

  var_8 = 0;

  if(istrue(var_3)) {
    var_8 = !var_7.visible;
    var_7.visible = 1;
  }

  if(isDefined(var_4)) {
    var_7.endtime = var_4;
  }

  if(isDefined(var_5)) {
    var_7.ref_127D0 = var_5;
  }

  if(isDefined(var_6)) {
    var_7.ref_127B7 = var_6;
    var_9 = level.ref_127C7.instances[var_7.ref_127BD];

    foreach(var_11 in var_9.ref_126BE) {
      if(var_11 != var_0) {
        ref_127AB(var_0, undefined, undefined, undefined, undefined, var_5, undefined);
        ref_127A6(var_0);
      }
    }

    if(isDefined(var_9.team)) {
      ref_127AA(var_9, scripts\mp\utility\teams::getfriendlyplayers(var_9.team));
    }
  } else if(isDefined(var_7.timestamp) && var_7.timestamp < gettime()) {
    var_7.ref_127B7 = undefined;
  }

  var_7.timestamp = gettime();
}

function ref_12785(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("plunder_sendRepositoryWidgetOmnvar");
  var_0.ref_127CA = undefined;

  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  var_0 setclientomnvar("ui_br_plunder_repository", 0);
}

function ref_127A6(var_0) {
  var_0 notify("plunder_sendRepositoryWidgetOmnvar");
  var_1 = var_0.ref_127CA;

  if(!isDefined(var_1)) {
    var_0 setclientomnvar("ui_br_plunder_repository", 0);
    return;
  }

  var_2 = 0;
  var_3 = 0;
  var_4 = var_1.visible;
  var_5 = 1;

  if(isDefined(var_4)) {
    var_2 |= int(var_4) << var_3;
  }

  var_3 += var_5;
  var_4 = var_1.type;
  var_5 = 1;

  if(isDefined(var_4)) {
    var_2 |= int(var_4) << var_3;
  }

  var_3 += var_5;
  var_4 = var_1.endtime;
  var_5 = 14;

  if(isDefined(var_4)) {
    var_4 = int(var_4 / 250);
    var_4 &= 16383;
    var_2 |= int(var_4) << var_3;
  }

  var_3 += var_5;
  var_6 = getDvar("scr_br_gametype", "") == "gold_war";

  if(var_1.type == 0) {
    var_4 = var_1.ref_127D0;
    var_5 = 9;

    if(isDefined(var_4)) {
      var_7 = 5;

      if(var_6) {
        var_7 = 50;
      }

      var_4 = int(var_4 / var_7);
      var_4 &= 511;
      var_2 |= int(var_4) << var_3;
    }

    var_3 += var_5;
    var_4 = var_1.ref_127B7;
    var_5 = 6;

    if(isDefined(var_4)) {
      var_7 = 5;

      if(var_6) {
        var_7 = 50;
      }

      var_4 = int(var_4 / var_7);
      var_4 &= 63;
      var_2 |= int(var_4) << var_3;
    }
  } else {
    var_4 = var_1.ref_127B7;
    var_5 = 15;

    if(isDefined(var_4)) {
      var_4 = int(var_4 / 5);
      var_4 &= 32767;
      var_2 |= int(var_4) << var_3;
    }
  }

  var_0 setclientomnvar("ui_br_plunder_repository", var_2);
}

function ref_12780(var_0) {
  var_1 = level.ref_127C7;
  var_2 = ref_1278C(var_0.ref_127C8);

  if(!istrue(var_2.ref_13AA5)) {
    return;
  }

  if(!isDefined(var_1.ref_13AA6[var_0.team])) {
    var_1.ref_13AA6[var_0.team] = [];
  }

  var_3 = [];

  for(var_4 = 1; var_4 <= 4; var_4++) {
    var_3 = var_4;
  }

  foreach(var_6 in var_1.ref_13AA6[var_0.team]) {
    var_3[var_6.building_magic_grenade_damage] = undefined;
  }

  foreach(var_9 in var_3) {
    var_0.building_magic_grenade_damage = var_9;
    break;
  }

  if(isDefined(var_0.building_magic_grenade_damage)) {
    var_1.ref_13AA6[var_0.team] = scripts\engine\utility::array_add(var_1.ref_13AA6[var_0.team], var_0);
    var_11 = var_1.ref_13AA3[var_0.building_magic_grenade_damage];

    foreach(var_13 in scripts\mp\utility\teams::getfriendlyplayers(var_0.team)) {
      var_13 setclientomnvar(var_11, var_0 getentitynumber());
    }

    return;
  }
}

function ref_12797(var_0) {
  var_1 = level.ref_127C7;
  var_2 = var_0.building_magic_grenade_damage;

  if(!isDefined(var_2)) {
    return;
  }

  var_0.building_magic_grenade_damage = undefined;
  var_1.ref_13AA6[var_0.team] = scripts\engine\utility::array_remove(var_1.ref_13AA6[var_0.team], var_0);

  if(var_1.ref_13AA6[var_0.team].size == 0) {
    var_1.ref_13AA6[var_0.team] = undefined;
  }

  var_3 = var_1.ref_13AA3[var_2];
  var_4 = var_1.ref_13AA4[var_2];

  foreach(var_6 in scripts\mp\utility\teams::getfriendlyplayers(var_0.team)) {
    var_6 setclientomnvar(var_3, -1);
    var_6 setclientomnvar(var_4, 0);
  }
}

function ref_127AA(var_0, var_1) {
  var_2 = level.ref_127C7;

  if(!isDefined(var_0.building_magic_grenade_damage)) {
    return;
  }

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  if(var_1.size == 0) {
    return;
  }

  var_3 = 0;
  var_4 = 0;
  var_5 = 1;
  var_6 = 1;
  var_3 += var_5;
  var_4 += var_6;
  var_5 = var_0.ref_127AF;
  var_6 = 14;

  if(isDefined(var_5)) {
    var_5 /= 250;
    var_5 = int(min(var_5, 16383));
    var_3 += var_5 << var_4;
  }

  var_4 += var_6;
  var_5 = var_0.ref_127D0;
  var_6 = 9;

  if(isDefined(var_5)) {
    var_5 /= 5;
    var_5 = int(min(var_5, 511));
    var_3 += var_5 << var_4;
  }

  var_7 = var_2.ref_13AA4[var_0.building_magic_grenade_damage];

  foreach(var_9 in var_1) {
    if(scripts\engine\utility::array_contains(var_0.ref_126BE, var_9)) {
      var_9 setclientomnvar(var_7, var_3 &~1);
      continue;
    }

    var_9 setclientomnvar(var_7, var_3);
  }
}
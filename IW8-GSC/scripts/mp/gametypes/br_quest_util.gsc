/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_quest_util.gsc
**************************************************/

function init_quest_util() {
  if(!getdvarint("scr_br_quests_enabled", 1)) {
    return;
  }

  level.questinfo = spawnStruct();
  level.questinfo.quests = [];
  level.questinfo.thinkers = [];
  level.questinfo.tabletinfo = [];
  level.questinfo.ref_13745 = [];
  level.questinfo.teamsonquests = [];
  level.questinfo.thinkindex = 0;
  level.questinfo.ref_139ec = [];
  level.questinfo.ref_12d2f = spawnStruct();
  level.questinfo.ref_12d2f.get_vehicle_idle_anim = [];
  level.questinfo.ref_12d2f.set_look_at_ent = [];
  level.questinfo.ref_12d2f.ref_12ec4 = [];
  level.questinfo.ref_12d2f.ref_12d31 = [];
  level.questinfo.ref_12d2f.ref_12d32 = [];
  level.questinfo.ref_13b62 = [];
  level.questinfo.ref_13f19 = [];
  level.questinfo.ref_132e8 = scripts\mp\menus::ref_13733() && getdvarint("scr_contracts_for_squad_only", 0);
  level.questinfo.defaultfilter = [];
  level.questinfo.defaultfilter[0] = &filtercondition_isdead;
  level.questinfo.defaultfilter[1] = &filtercondition_ingulag;
  level.questinfo.register_seat_data = &register_vehicle_spawners;
  ref_11963();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  ref_12c08();
  scripts\mp\gametypes\br_assassination_quest::init();
  scripts\mp\gametypes\br_dom_quest::init();
  scripts\mp\gametypes\br_scavenger_quest::init();
  scripts\mp\gametypes\br_vip_quest::init();
  scripts\mp\gametypes\br_timedrun_quest::init();
  scripts\mp\gametypes\br_extract_quest::init();
  scripts\mp\gametypes\br_lep_quest::init();
  scripts\mp\gametypes\br_supply_quest::init();
  scripts\mp\gametypes\br_masterassassination_quest::init();
  scripts\mp\gametypes\br_sabotage_quest::init();
  scripts\mp\gametypes\br_black_market_quest::init();
  scripts\mp\gametypes\br_blueprint_extract_spawn::init();

  if(istrue(level.tryupdategenericprogress)) {
    scripts\mp\gametypes\br_scavenger_quest_soa_tower::init();
  }

  if(level.script == "mp_don4") {
    if(getdvarint("scr_br_disableLootBunkerCaches", 1) == 1) {
      scripts\mp\gametypes\br_bunker_utility::loadout_given();
    }

    if(getdvarint("scr_br_disableBunker11Caches", 0) == 1) {
      scripts\mp\gametypes\br_bunker_utility::little_bird_mg_onenterheavydamagestate();
    }

    if(getdvarint("scr_br_open_abandoned_mines", 0) != 1) {
      scripts\mp\gametypes\br_gametype_lep::doextractionevent();
    }
  }

  if(isDefined(level.disablelootfunction)) {
    [[level.disablelootfunction]]();
  }

  if(isDefined(level.disablelootfunctionprematchdone)) {
    thread disablelootfunctionprematchdone(level.disablelootfunctionprematchdone);
  }

  thread inittablets();
  thread ref_13234();
  game["dialog"]["mission_gen_accept"] = "mission_mission_gen_accept";
  game["dialog"]["mission_misc_success"] = "contract_misc_success";
  game["dialog"]["mission_obj_change"] = "mission_mission_obj_change";
  game["dialog"]["mission_obj_moved"] = "mission_mission_obj_moved";
  game["dialog"]["mission_obj_next_ptarget"] = "mission_mission_obj_next_ptarget";
  game["dialog"]["mission_obj_next_nptarget"] = "mission_mission_obj_next_nptarget";
  game["dialog"]["mission_obj_warning_time"] = "mission_mission_obj_warning_time";
  game["dialog"]["mission_obj_warning_capture"] = "mission_mission_obj_warning_capture";
  game["dialog"]["mission_obj_circle_fail"] = "mission_mission_obj_circle_fail";
  game["dialog"]["mission_gen_fail"] = "mission_mission_gen_fail";
  game["dialog"]["mission_teammate_down"] = "mission_teammate_down";
  game["dialog"]["mission_enemy_down"] = "mission_enemy_down";
  level._effect["vfx_dom_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_dom");
  level._effect["vfx_doom_flare"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_flare_doomstation.vfx");
  level._effect["vfx_revive_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_revive");
  level._effect["vfx_smktrail_mortar"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail");
  level._effect["vfx_marker_base_orange_pulse"] = loadfx("vfx/iw8_br/gameplay/vfx_br_tr_marker.vfx");
  level.elevator_lights_toggle = undefined;
  level.questinfo.hotfootabsloops = 1;
  level.ref_14060 = getdvarint("scr_br_usealtrewardtable", 0);
}

function ref_11963() {
  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/brmission_unlockables.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = spawnStruct();
    var_2.ref_13f18 = int(var_1);
    var_2.ref_11a23 = int(tablelookup("mp/brmission_unlockables.csv", 0, var_1, 1));
    var_2.ref_13f17 = [];

    for(var_3 = 0;; var_3++) {
      var_4 = tablelookup("mp/brmission_unlockables.csv", 0, var_1, 3 + var_3);

      if(!isDefined(var_4) || var_4 == "") {
        break;
      }

      var_2.ref_13f17[var_3] = int(var_4);
    }

    level.questinfo.ref_13f19[scripts\engine\utility::string(var_2.ref_11a23)] = var_2;
  }
}

function disablelootfunctionprematchdone(var_0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  [[var_0]]();
}

function little_bird_mg_playercontrolmg(var_0, var_1, var_2, var_3) {
  var_4 = 175;
  var_5 = 100;

  if(!isDefined(var_1)) {
    var_1 = var_4;
  }

  if(!isDefined(var_2)) {
    var_2 = var_5;
  }

  var_6 = getlootspawnpoint(var_0, var_1, 0, 1);

  foreach(var_8 in var_6) {
    if(tv_station_marker_player_connect_monitor(var_0[2], var_8.origin[2], var_2)) {
      getlootspawnpointcount(var_8.index);
    }
  }
}

function disabletabletsaroundorigin(var_0, var_1, var_2) {
  foreach(var_4 in level.questinfo.tabletinfo) {
    var_5 = canceljoins(removepatchablecollision_delayed(var_9), undefined, var_0, var_1);

    foreach(var_7 in var_5) {
      if(tv_station_marker_player_connect_monitor(var_0[2], var_7.origin[2], var_2)) {
        var_7.invalidforreplace = 1;
        scripts\mp\gametypes\br_pickups::ref_11a21(var_7);
      }
    }
  }
}

function tv_station_marker_player_connect_monitor(var_0, var_1, var_2) {
  return abs(var_0 - var_1) <= var_2;
}

function debugdrawlootdisableradius(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = (0, 0, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;

  for(;;) {
    wait 1;
  }
}

function inittablets() {
  level.questinfo.activetablets = [];
  var_3 = getdvarfloat("scr_br_quest_tablet_hide_percent", 0.667);
  var_4 = [];

  foreach(var_2, var_1 in level.questinfo.tabletinfo) {
    var_6 = removepatchablecollision_delayed(var_2);
    var_7 = getlootscriptablearrayinradius(var_6);

    if(!var_1.enabled) {
      continue;
    }

    if(var_7.size > 0) {
      var_8 = getdvarfloat("scr_br_quest_tablet_kiosk_dist", 1200);

      if(var_8 > 0) {
        var_9 = 0;

        foreach(var_11 in level.br_armory_kiosk.scriptables) {
          var_12 = canceljoins(var_6, undefined, var_11.origin, var_8);

          foreach(var_14 in var_12) {
            if(istrue(var_14.ref_13840)) {
              continue;
            }

            var_14.ref_13840 = 1;
            var_9++;
          }
        }

        for(var_17 = var_7.size - 1; var_17 >= 0 && var_9; var_17--) {
          if(istrue(var_7[var_17].ref_13840)) {
            var_7 = var_7[var_7.size - 1];
            var_7[var_7.size - 1] = undefined;
            var_9--;
          }
        }
      }
    }

    if(istrue(level.ref_11a5e) && scripts\mp\gametypes\br::ref_11a5c()) {
      var_18 = getdvarfloat("scr_br_quest_tablet_lowpop_percent", 0.8);
      var_19 = int(min(var_7.size, var_7.size * (1 - var_18) + 0.5));

      for(var_17 = 0; var_17 < var_19; var_17++) {
        var_20 = randomintrange(0, var_7.size);
        var_7[var_20].ref_13840 = 1;
        var_7 = var_7[var_7.size - 1];
        var_7[var_7.size - 1] = undefined;
      }
    }

    for(var_17 = var_7.size - 1; var_17 >= 0; var_17--) {
      var_21 = var_7[var_17];
      tabletinit(var_21, var_2);

      if(!var_21.init) {
        var_7[var_17].ref_13840 = 1;
        var_7 = var_7[var_7.size - 1];
        var_7[var_7.size - 1] = undefined;
      }
    }

    if(var_7.size) {
      ref_13180(var_2);
    }

    var_22 = revivingteammate(rewards(var_6));

    if(isDefined(level.br_circle) && isDefined(var_22) && var_22 > 0) {
      var_23 = var_7.size;
    } else {
      var_24 = var_7.size * var_3;
      var_23 = int(var_24);
      var_25 = var_24 - var_23;

      if(randomfloat(1) < var_25) {
        var_23++;
      }
    }

    for(var_17 = 0; var_17 < var_23; var_17++) {
      var_20 = randomintrange(0, var_7.size);
      var_21 = var_7[var_20];
      var_7[var_20].ref_13840 = 1;
      var_4 = var_7[var_20];
      var_7 = var_7[var_7.size - 1];
      var_7[var_7.size - 1] = undefined;
    }
  }

  var_26 = getarraykeys(level.calloutglobals.ref_11e29);
  var_27 = [];
  var_28 = getdvarint("scr_br_quest_tablet_location_min", 1);

  if(var_28 > 0) {
    foreach(var_30 in var_26) {
      var_27 = var_28;
    }
  }

  var_32 = 0;

  foreach(var_2, var_1 in level.questinfo.tabletinfo) {
    var_7 = getlootscriptablearrayinradius(removepatchablecollision_delayed(var_2));
    var_32 += var_7.size;

    if(var_1.enabled) {
      foreach(var_21 in var_7) {
        if(istrue(var_21.ref_13840)) {
          tablethide(var_21);
          continue;
        }

        tabletshow(var_21);

        if(var_27.size > 0) {
          var_35 = scripts\mp\gametypes\br_callouts::removeminigunrestrictions(var_21.origin);

          if(isDefined(var_27[var_35])) {
            var_27--;

            if(!var_27[var_35]) {
              var_27[var_35] = undefined;
            }
          }
        }
      }

      continue;
    }

    foreach(var_21 in var_7) {
      tablethide(var_21);
    }
  }

  if(var_27.size) {
    var_4 = scripts\engine\utility::array_randomize(var_4);
    var_17 = 0;

    while(var_17 < var_4.size) {
      var_21 = var_4[var_17];
      var_22 = revivingteammate(var_21.ref_139eb);

      if(isDefined(level.br_circle) && isDefined(var_22) && var_22 > 0) {
        var_17++;
      } else {
        var_35 = scripts\mp\gametypes\br_callouts::removeminigunrestrictions(var_21.origin);

        if(isDefined(var_27[var_35])) {
          tabletshow(var_21);
          var_27--;

          if(!var_27[var_35]) {
            var_27[var_35] = undefined;

            if(!var_27.size) {
              break;
            }
          }
        }
      }

      var_7++;
    }
  }

  var_40 = level.questinfo.activetablets.size;
  var_41 = var_3.size;
  scripts\mp\gametypes\br_analytics::destroypropspecatehud(var_28, var_40, var_41, < error > );

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("tabletReplace")) {
    thread ref_139e9(var_3);
    return;
  }

  thread ks_airdropcratearmor(var_3);
}

function ref_13180(var_0) {
  if(issubstr(var_0, "_redacted")) {
    if(!isDefined(level.ref_12aac)) {
      level.ref_12aac = "";
    }

    if(level.ref_12aac == "") {
      var_1 = getquestindex(var_0);
      setomnvarbit("ui_br_objective_types", var_1, 1);
      level.ref_12aac = var_0;
      return;
    }

    return;
  }

  var_1 = getquestindex(var_1);
  setomnvarbit("ui_br_objective_types", var_1, 1);
}

function ref_139e9(var_0) {
  if(!isDefined(level.br_level)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = 0;
  var_2 = level.ref_139ea;
  var_3 = 0;
  var_4 = var_0.size;

  foreach(var_6 in var_0) {
    if(!isDefined(var_6.circleindex)) {
      var_6.circleindex = scripts\mp\gametypes\br_circle::relic_amped_reset_deathshield_on_revived(var_6.origin);
    }
  }

  while(var_3 < var_4) {
    var_8 = var_0[var_3];

    if(istrue(var_8.invalidforreplace)) {
      var_3++;
      continue;
    }

    level waittill("quest_started");
    var_9 = obj_room_fire_01(var_8);

    if(var_9 < 1) {
      var_10 = 0;

      while(var_3 < var_4) {
        if(var_9 == 1 && var_8.circleindex >= relic_mythic_modifyplayerdamage()) {
          break;
        }

        if(var_9 == 0 && var_8.circleindex >= relic_mythic_modifyplayerdamage()) {
          var_0 = var_8;
        }

        var_3++;
        var_8 = var_0[var_3];
        var_9 = obj_room_fire_01(var_8);
      }
    }

    if(var_3 == var_4) {
      var_4 = var_0.size;
      continue;
    }

    if(isDefined(level.ref_139ea) && level.ref_139ea != -1) {
      var_1++;

      if(var_1 >= var_2) {
        tabletshow(var_8);
        var_2 += level.ref_139ea;
        var_3++;
        var_4 = var_0.size;
      }

      continue;
    }

    tabletshow(var_8);
    var_3++;
    var_4 = var_0.size;
  }
}

function ks_airdropcratearmor(var_0) {
  if(!isDefined(level.br_level)) {
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("delayedShowTablets")) {
    level thread scripts\mp\gametypes\br_gametypes::ref_12e05("delayedShowTablets", var_0);
    return;
  }

  var_1 = getdvarfloat("scr_br_quest_tablet_show_percent", 0.3);
  var_2 = getdvarint("scr_br_quest_tablet_show_circle_disable_override", 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  var_3 = level.br_level.br_circledelaytimes.size - 1 - getdvarint("scr_br_quest_tablet_show_circle_disable", 4);

  if(getdvarint("scr_br_resurgence_respawn_enable", 0) == 1) {
    var_3 = scripts\mp\gametypes\br_gametype_rebirth::rocket_attack_min_cooldown();
  } else if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("gulag")) {
    var_3 = scripts\mp\gametypes\br_gulag::remove_engineer_class();
  }

  if(var_2 > 0) {
    var_3 = var_2;
  }

  var_4 = [];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];
    var_6.circleindex = scripts\mp\gametypes\br_circle::relic_amped_reset_deathshield_on_revived(var_6.origin);

    if(var_6.circleindex >= 0) {
      var_4 = var_6;
    }
  }

  var_0 = scripts\engine\utility::array_randomize(var_4);

  for(;;) {
    level waittill("br_circle_set");

    if(!level.br_circle.circleindex) {
      scripts\mp\gametypes\br_analytics::destorder(0, var_1, var_4.size, 0);
      continue;
    }

    var_4 = [];
    var_7 = [];

    for(var_5 = 0; var_5 < var_0.size; var_5++) {
      var_6 = var_0[var_5];

      if(var_6.circleindex >= relic_mythic_modifyplayerdamage()) {
        if(obj_room_fire_01(var_6) == 1) {
          var_4 = var_6;
          continue;
        }

        if(obj_room_fire_01(var_6) == 0) {
          var_7 = var_6;
        }
      }
    }

    var_8 = int(ceil(var_4.size * var_1));
    var_9 = int(max(0, getdvarint("scr_br_quest_tablet_show_max", 100) - level.questinfo.activetablets.size));
    var_8 = int(min(var_8, var_9));

    for(var_5 = 0; var_5 < var_8; var_5++) {
      var_6 = var_4[var_5];
      tabletshow(var_6);
    }

    var_0 = [];

    for(var_5 = 0; var_5 < var_7.size; var_5++) {
      var_0 = var_7[var_5];
    }

    for(var_5 = var_8; var_5 < var_4.size; var_5++) {
      var_0 = var_4[var_5];
    }

    scripts\mp\gametypes\br_analytics::destorder(level.br_circle.circleindex, var_1, var_4.size, var_8);

    if(level.br_circle.circleindex >= var_3) {
      break;
    }
  }
}

function little_bird_mg_mp_enterendinternal() {
  foreach(var_1 in level.questinfo.tabletinfo) {
    var_2 = getlootscriptablearrayinradius(removepatchablecollision_delayed(var_6));

    if(var_1.enabled) {
      foreach(var_4 in var_2) {
        tablethide(var_4);
      }
    }
  }
}

function tablethide() {
  thread anim_pause_fracs();
}

function anim_pause_fracs() {
  self endon("show");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\gametypes\br_pickups::ref_11a21(self);
}

function tabletshow() {
  self notify("show");
  var_0 = self.type;
  self setscriptablepartstate(var_0, "visible");
  level.questinfo.activetablets["" + self.index] = self;
  scripts\mp\gametypes\br_analytics::dialog_hurry(self);
}

function tabletinit(var_0) {
  if(isDefined(self.init)) {
    return;
  }

  self.init = 1;
  self.ref_139eb = var_0;
  var_1 = level.questinfo.quests[var_0].funcs["tabletInit"];

  if(isDefined(var_1)) {
    self.init = self[[var_1]]();

    if(!self.init) {
      scripts\mp\gametypes\br_analytics::destroyscoreevent(self);
      return;
    }

    return;
  }
}

function ref_1207a(var_0) {
  if(isDefined(level.questinfo.activetablets["" + var_0.index])) {
    level.questinfo.activetablets["" + var_0.index] = undefined;
    return;
  }
}

function removepatchablecollision_delayed(var_0) {
  var_1 = undefined;

  if(isDefined(level.questinfo.tabletinfo[var_0])) {
    var_1 = level.questinfo.tabletinfo[var_0].ref_11a3c;
  }

  if(!isDefined(var_1)) {
    var_1 = "brloot_" + var_0 + "_tablet";
  }

  return var_1;
}

function registerteamonquest(var_0, var_1) {
  scripts\mp\gametypes\br_analytics::determinetrackingcirclesize(self, var_1);

  if(istrue(level.questinfo.ref_132e8)) {
    var_2 = var_0 + var_1.squadindex;
    level.questinfo.ref_13745 = scripts\engine\utility::array_add(level.questinfo.ref_13745, var_2);
  } else {
    level.questinfo.teamsonquests = scripts\engine\utility::array_add(level.questinfo.teamsonquests, var_0);
  }

  if(!isDefined(level.questinfo.ref_11b69)) {
    level.questinfo.ref_11b69 = [];
  }

  level.questinfo.ref_11b69[var_0] = rewardangles(var_0, 1);
  level notify("quest_started", var_0, var_1.squadindex);
}

function releaseteamonquest(var_0) {
  if(scripts\mp\menus::ref_13733()) {}

  if(isDefined(level.questinfo.ref_11b69)) {
    level.questinfo.ref_11b69[var_0] = undefined;
    scripts\mp\perks\perkfunctions::ref_14022(var_0);
  }

  if(istrue(level.questinfo.ref_132e8)) {
    var_1 = var_0 + self.squadindex;
    level.questinfo.ref_13745 = scripts\engine\utility::array_remove(level.questinfo.ref_13745, var_1);
  } else {
    level.questinfo.teamsonquests = scripts\engine\utility::array_remove(level.questinfo.teamsonquests, var_0);
  }

  var_2 = ringing(var_0);
  var_3 = [];

  if(isDefined(self.result) && self.result == "success") {
    foreach(var_5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
      if(isbot(var_5) && scripts\mp\gametypes\br_public::validtousesticker()) {
        continue;
      }

      var_5.egress_landlord_vo = scripts\mp\gametypes\br::get_int_or_0(var_5.egress_landlord_vo) + 1;
      var_5 scripts\mp\gametypes\br_public::updatebrscoreboardstat("missionsCompleted", var_5.egress_landlord_vo);
      var_5 scripts\mp\utility\stats::incpersstat("contracts", 1);

      if(!isDefined(var_5.ejectplayerfromturret)) {
        var_5.ejectplayerfromturret = [];
      }

      var_5.ejectplayerfromturret[self.questcategory] = scripts\mp\gametypes\br::get_int_or_0(var_5.ejectplayerfromturret[self.questcategory]) + 1;
      var_5 scripts\mp\gametypes\br_challenges::getallspawninstances("br_mastery_fiveContracts");
    }

    if(!isDefined(self.ref_11eba) || self.ref_11eba == 0) {
      if(isDefined(self.ref_12d2e) && isDefined(self.ref_12d2b) && isDefined(self.ref_12d30)) {
        var_3 = search_speed(var_0, self.ref_12d2e, self.ref_12d2b, self.ref_12d30, self.house_enter_animate_and_kill_player);
      }
    }
  }

  if(isDefined(self.result)) {
    var_7 = scripts\engine\utility::ter_op(self.result == "success", 1, 2);
    var_8 = self.category;

    foreach(var_5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
      if(isbot(var_5) && scripts\mp\gametypes\br_public::validtousesticker()) {
        continue;
      }

      var_5 scripts\cp\vehicles\vehicle_compass_cp::ref_12009(self.category, var_7, 1);
      var_5 scripts\mp\gametypes\br_gametypes::ref_12e05("onContractEnd", var_7);
      var_5 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    if(isDefined(self.targetteam)) {
      var_11 = scripts\engine\utility::ter_op(self.result == "success", 2, 1);

      foreach(var_5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
        if(isbot(var_5) && scripts\mp\gametypes\br_public::validtousesticker()) {
          continue;
        }

        var_5 scripts\cp\vehicles\vehicle_compass_cp::ref_12009(self.category, var_11, 2);
      }
    }
  }

  var_14 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex);
  var_15 = var_14.size;
  scripts\mp\gametypes\br_analytics::determinetrackingcircleoffset(self, var_2, var_3, var_15);
  self notify("questEnded");

  if(isDefined(self.ref_12d30)) {
    self.ref_12d30 notify("questEnded");
    return;
  }
}

function ref_13879(var_0, var_1, var_2) {
  foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_2, self.squadindex)) {
    if(isbot(var_4) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var_4 scripts\cp\vehicles\vehicle_compass_cp::ref_1200a(var_0, var_1);
  }
}

function ref_13a38(var_0) {
  switch (var_0.type) {
    case "brloot_redacted_assassination_tablet":
    case "brloot_assassination_tablet":
      scripts\mp\gametypes\br_assassination_quest::takequestitem(var_0);
      break;
    case "brloot_redacted_domination_tablet":
    case "brloot_domination_tablet":
      if(scripts\mp\utility\game::round_vehicle_logic() == "payload") {
        scripts\mp\gametypes\br_capshoot_quest::takequestitem(var_0);
      } else {
        scripts\mp\gametypes\br_dom_quest::takequestitem(var_0);
      }

      break;
    case "brloot_redacted_scavenger_tablet":
    case "brloot_scavenger_tablet":
      scripts\mp\gametypes\br_scavenger_quest::takequestitem(var_0);
      break;
    case "brloot_redacted_vip_tablet":
    case "brloot_vip_tablet":
      scripts\mp\gametypes\br_vip_quest::takequestitem(var_0);
      break;
    case "brloot_redacted_timedrun_tablet":
    case "brloot_timedrun_tablet":
      scripts\mp\gametypes\br_timedrun_quest::takequestitem(var_0);
      break;
    case "brloot_geigerstash_tablet":
      scripts\mp\gametypes\br_geigerstash_quest::takequestitem(var_0);
      break;
    case "brloot_blueprintextract_tablet":
      scripts\mp\gametypes\br_extract_quest::takequestitem(var_0);
      break;
    case "brloot_scavenger_tablet_adler":
      scripts\mp\gametypes\br_scavenger_quest_adler::takequestitem(var_0);
      break;
    case "brloot_scavenger_tablet_soa_tower":
      scripts\mp\gametypes\br_scavenger_quest_soa_tower::takequestitem(var_0);
      break;
    case "brloot_lep_tablet":
      scripts\mp\gametypes\br_lep_quest::dropoff_sound_hvt_handler(var_0);
      break;
    case "brloot_supply_tablet":
      scripts\mp\gametypes\br_supply_quest::takequestitem(var_0);
      break;
    case "brloot_masterassassination_tablet":
      scripts\mp\gametypes\br_masterassassination_quest::takequestitem(var_0);
      break;
    case "brloot_redacted_sabotage_tablet":
    case "brloot_sabotage_tablet":
      scripts\mp\gametypes\br_sabotage_quest::takequestitem(var_0);
      break;
    case "brloot_black_market_tablet":
      scripts\mp\gametypes\br_black_market_quest::takequestitem(var_0);
      break;
  }

  scripts\mp\gametypes\br_plunder::ref_11c91("brloot_mission_tablet", -1);
}

function dangercircletick(var_0, var_1, var_2) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var_4 in level.questinfo.activetablets) {
    if(distance2dsquared(var_0, var_4.origin) > var_1 * var_1) {
      scripts\mp\gametypes\br_pickups::ref_11a21(var_4);
      scripts\mp\gametypes\br_plunder::ref_11c91("brloot_mission_tablet", -1);
    }
  }

  foreach(var_7 in level.questinfo.quests) {
    if(isDefined(var_7.funcs["circleTick"])) {
      foreach(var_9 in var_7.instances) {
        var_9[[var_7.funcs["circleTick"]]](var_0, var_2);
      }
    }
  }
}

function createquestinstance(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.questcategory = var_0;
  var_5.enabled = 1;
  var_5.category = var_0;
  var_5.id = var_1;
  var_5.ref_11c4e = "" + var_2;
  var_5.ref_12d30 = var_3;
  _assignthinkoffset(var_5);
  var_5.squadindex = var_4;
  return var_5;
}

function addquestinstance(var_0, var_1) {
  if(!istrue(level.questinfo.ismanagerthreadthinking)) {
    _initmanagerquestthread();
    thread _questmanagerthread();
  }

  if(!_isquestthreaded(var_0) && isDefined(level.questinfo.quests[var_0].numthinkfuncs)) {
    if(_checkforregister(var_0, "initQuestVars")) {
      _runinitquestvars(level.questinfo.quests[var_0], var_0);
    }

    _runaddquestinstance(var_0, var_1);
    _runaddquestthread(var_0);
    return;
  }

  _runaddquestinstance(var_0, var_1);
}

function removequestinstance() {
  if(istrue(self.removed)) {
    return;
  }

  self.removed = 1;
  self notify("marked_to_remove");
  var_0 = self.questcategory;
  _runremovequestinstance(var_0);

  if(isDefined(self.ref_1393b)) {
    leavequestlocale();
  }

  if(_questinstancesactive(var_0) <= 0) {
    if(_checkforregister(var_0, "clearQuestVars")) {
      _runclearquestvars(level.questinfo.quests[var_0], var_0);
    }

    if(_questthreadsactive() <= 0) {
      _removemanagerquestthread();
      return;
    }

    return;
  }
}

function upper_door_coll(var_0) {
  return isDefined(var_0.subscribedinstances);
}

function _initmanagerquestthread() {
  level.questinfo.ismanagerthreadthinking = 1;
}

function _removemanagerquestthread() {
  level notify("end_quest_manager_thread");
  level.questinfo.ismanagerthreadthinking = 0;
}

function _questmanagerthread() {
  level endon("game_ended");
  level endon("end_quest_manager_thread");

  for(;;) {
    wait 0.05;
    level.questinfo.thinkindex++;

    foreach(var_1 in level.questinfo.thinkers) {
      if(!level.questinfo.quests[var_1].enabled) {
        continue;
      }

      foreach(var_3 in level.questinfo.quests[var_1].instances) {
        if(var_3.enabled) {
          _runquestthinkfunctions(var_3, var_1);
        }
      }
    }
  }
}

function _runquestthinkfunctions(var_0) {
  for(var_1 = 0; var_1 < level.questinfo.quests[var_0].numthinkfuncs; var_1++) {
    if((level.questinfo.thinkindex - self.thinkoffset + self.firstthink) % level.questinfo.quests[var_0].thinkrates[var_1] == 0) {
      var_2 = "questThink" + var_1;
      [[level.questinfo.quests[var_0].funcs[var_2]]]();
    }
  }
}

function _assignthinkoffset() {
  if(!isDefined(level.questinfo.thinkoffset)) {
    level.questinfo.thinkoffset = 0;
  }

  self.thinkoffset = level.questinfo.thinkoffset;
  self.firstthink = level.questinfo.thinkindex;
  level.questinfo.thinkoffset++;
}

function _registerquestfunc(var_0, var_1, var_2) {
  level.questinfo.quests[var_0].funcs[var_2] = var_1;
}

function _checkforregister(var_0, var_1) {
  return isDefined(level.questinfo.quests[var_0].funcs[var_1]);
}

function registerquestcategory(var_0, var_1) {
  var_2 = upload_station_players_manager(var_0, var_1);
  var_3 = spawnStruct();
  var_3.enabled = var_2;
  level.questinfo.tabletinfo[var_0] = var_3;

  if(!var_2) {
    return false;
  }

  _registerquestcategory(var_0);
  return true;
}

function upload_station_players_manager(var_0, var_1) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("missions")) {
    return false;
  }

  return getdvarint("scr_br_" + var_0 + "_quest", var_1) == 1;
}

function registerquestlocale(var_0) {
  _registerquestcategory(var_0);
}

function _registerquestcategory(var_0) {
  if(!isDefined(level.questinfo.quests[var_0])) {
    level.questinfo.quests[var_0] = spawnStruct();
    level.questinfo.quests[var_0].initflag = 0;
    level.questinfo.quests[var_0].hasinitfunc = 0;
    level.questinfo.quests[var_0].funcs = [];
    level.questinfo.quests[var_0].instances = [];
    level.questinfo.quests[var_0].enabled = 1;
    ref_12b38(var_0);
    return;
  }
}

function ref_12b38(var_0) {
  level.questinfo.ref_139ec[var_0] = spawnStruct();
  level.questinfo.ref_139ec[var_0].index = getquesttableindex(var_0);
}

function registerinitquestvars(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "initQuestVars");
  level.questinfo.quests[var_0].hasinitfunc = 1;
}

function registerquestthink(var_0, var_1, var_2) {
  if(!isDefined(level.questinfo.quests[var_0].numthinkfuncs)) {
    level.questinfo.quests[var_0].numthinkfuncs = 0;
  }

  var_3 = int(var_2 * 20);
  level.questinfo.quests[var_0].thinkrates[level.questinfo.quests[var_0].numthinkfuncs] = var_3;
  var_4 = "questThink" + level.questinfo.quests[var_0].numthinkfuncs;
  _registerquestfunc(var_0, var_1, var_4);
  level.questinfo.quests[var_0].numthinkfuncs += 1;
}

function registerquestcircletick(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "circleTick");
}

function registerremovequestinstance(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "removeInstance");
}

function registerclearquestvars(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "clearQuestVars");
}

function registerplayerfilter(var_0, var_1, var_2) {
  if(!isDefined(level.questinfo.quests[var_0].filters)) {
    level.questinfo.quests[var_0].filters = [];
  }

  if(isDefined(var_2)) {
    level.questinfo.quests[var_0].filters[var_2] = var_1;
    return;
  }

  var_3 = level.questinfo.quests[var_0].filters.size;
  level.questinfo.quests[var_0].filters[var_3] = var_1;
}

function registeronplayerkilled(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "onPlayerKilled");
}

function ref_12b2e(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "onPlayerDisconnect");
}

function ref_12b2d(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "onEnterGulag");
}

function ref_12b30(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "onRespawn");
}

function ref_12b32(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "onTimerUpdate");
}

function ref_12b31(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "onTimerExpired");
}

function ref_12b3d(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "tabletInit");
}

function ref_12b2a(var_0, var_1) {
  level.questinfo.tabletinfo[var_0].ref_11a3c = var_1;
}

function _clearregisters(var_0) {
  var_1 = [];
}

function onplayerkilled(var_0, var_1) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var_3 in level.questinfo.quests) {
    if(isDefined(var_3.funcs["onPlayerKilled"])) {
      foreach(var_5 in var_3.instances) {
        var_5[[var_3.funcs["onPlayerKilled"]]](var_0, var_1);
      }
    }
  }
}

function onplayerconnect(var_0) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  if(!isDefined(var_0.team)) {
    return;
  }

  ref_131b0(var_0.team, ringing(var_0.team), var_0.squadindex);
}

function onplayerdisconnect(var_0) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var_2 in level.questinfo.quests) {
    if(isDefined(var_2.funcs["onPlayerDisconnect"])) {
      foreach(var_4 in var_2.instances) {
        var_4[[var_2.funcs["onPlayerDisconnect"]]](var_0);
      }
    }
  }
}

function ref_1206c() {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var_1 in level.questinfo.quests) {
    if(isDefined(var_1.funcs["onEnterGulag"])) {
      foreach(var_3 in var_1.instances) {
        var_3[[var_1.funcs["onEnterGulag"]]](self);
      }
    }
  }
}

function ref_12072() {
  if(!isDefined(level.questinfo)) {
    return;
  }

  self setclientomnvar("ui_player_spawned_notify", gettime());

  foreach(var_1 in level.questinfo.quests) {
    if(isDefined(var_1.funcs["onRespawn"])) {
      foreach(var_3 in var_1.instances) {
        var_3[[var_1.funcs["onRespawn"]]](self);
      }
    }
  }
}

function _runinitquestvars(var_0) {
  [[level.questinfo.quests[var_0].funcs["initQuestVars"]]]();
}

function _runaddquestthread(var_0) {
  if(!_isquestthreaded(var_0)) {
    var_2 = level.questinfo.thinkers.size;
    level.questinfo.thinkers[var_2] = var_0;
    level.questinfo.quests[var_0].enabled = 1;
    return;
  }
}

function _runaddquestinstance(var_0, var_1) {
  level.questinfo.quests[var_0].instances[var_1.id] = var_1;
}

function _runremovequestinstance(var_0) {
  self[[level.questinfo.quests[var_0].funcs["removeInstance"]]]();
  self notify("removed");
  level.questinfo.quests[var_0].instances[self.id] = undefined;
}

function _runclearquestvars(var_0) {
  [[level.questinfo.quests[var_0].funcs["clearQuestVars"]]]();
  level.questinfo.thinkers = scripts\engine\utility::array_remove(level.questinfo.thinkers, var_0);
  level.questinfo.quests[var_0].enabled = 0;
}

function _isquestthreaded(var_0) {
  if(scripts\engine\utility::array_contains(level.questinfo.thinkers, var_0)) {
    return true;
  }

  return false;
}

function _questinstancesactive(var_0) {
  if(isDefined(level.questinfo.quests[var_0].instances)) {
    return level.questinfo.quests[var_0].instances.size;
  }

  return 0;
}

function _questthreadsactive() {
  if(isDefined(level.questinfo.thinkers)) {
    return level.questinfo.thinkers.size;
  }

  return 0;
}

function createlocaleinstance(var_0, var_1, var_2) {
  var_3 = createquestinstance(var_0, var_2, "invalid", undefined, self.squadindex);
  var_3.subscriber_type = var_1;
  getquestdata(var_1).locale_type = var_0;
  var_3.subscribedinstances = [];
  return var_3;
}

function registercreatequestlocale(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "create_locale");
}

function ref_12b2b(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "move_locale");
}

function registercheckiflocaleisavailable(var_0, var_1) {
  _registerquestfunc(var_0, var_1, "check_available");
}

function adrenaline_crate_player_at_max_ammo(var_0) {
  switch (var_0.ref_12fa3) {
    case "GetEntitylessScriptableArray":
      return getentitylessscriptablearrayinradius(var_0.vehicle_collision_registerevent, "classname", var_0.ref_12f9f, var_0.ref_12fa6);
    case "getUnusedLootCacheArray":
      var_1 = getlootspawnpoint(var_0.ref_12f9f, var_0.ref_12fa6, 0, 1);
      return var_1;
    case "questPointsArray":
      return disablelootspawnpoint(var_1.ref_1297f, var_1.ref_12f9f, var_1.ref_12fa6, 0, 1);
    case "questPointsArrayWZTrain":
      var_2 = play_thrust_fx(var_1);

      if(isDefined(var_2)) {
        return var_2;
      }

      var_1.ref_1407e = undefined;
      return disablelootspawnpoint(var_1.ref_1297f, var_1.ref_12f9f, var_1.ref_12fa6, 0, 1);
    case "getKiosks":
      var_3 = scripts\mp\gametypes\br_armory_kiosk::registeraccesscardlocs();
      var_4 = [];

      foreach(var_6 in level.br_armory_kiosk.scriptables) {
        if(!istrue(var_6.disabled)) {
          var_4 = var_6;
        }
      }

      return var_4;
    case "getInactiveHelipads":
      if(isDefined(level.br_plunder_sites)) {
        var_8 = scripts\mp\gametypes\br_plunder::retrieve_data_objective();
        var_9 = [];

        foreach(var_11 in var_8) {
          if(istrue(var_11 getscriptablepartstate(var_11.type) == "hidden")) {
            var_9 = var_11;
          }
        }

        if(var_9.size == 0) {
          return var_8;
        }

        return var_9;
      }
    default:
      break;
  }
}

function play_thrust_fx(var_0) {
  var_1 = undefined;

  if(isDefined(level.ref_145f1) && isDefined(level.ref_145f1.ref_13c8d)) {
    if([[level.ref_145f1.funcs.c130airdrop_createpath]]()) {
      return undefined;
    }

    if([[level.ref_145f1.funcs.c130airdrop_deleteatlifetime]](100, 20)) {
      return undefined;
    }

    var_2 = [];

    foreach(var_4 in level.ref_145f1.ref_13c8d) {
      if(isDefined(var_4.maphint_keypadscriptableused) && level.ref_145f1.hotfootlastposition >= var_4.mapnamefilter) {
        var_2 = var_4;
      }
    }

    var_6 = 0;
    var_7 = undefined;

    foreach(var_4 in var_2) {
      if(isDefined(var_4.maphitloctoburningpart) && var_6 < var_4.maphitloctoburningpart) {
        var_6 = var_4.maphitloctoburningpart;
        var_7 = var_4;
      }
    }

    if(var_2.size > 1) {
      if(isDefined(var_7)) {
        var_2 = scripts\engine\utility::array_remove(var_2, var_7);
      }
    }

    var_4 = scripts\engine\utility::random(var_2);
    var_4.maphitloctoburningpart = gettime();
    level.ref_145f1.hostvictimskipburndownmedium = var_4;
    var_10 = spawnStruct();
    var_10.origin = var_4.origin;
    var_10.angles = var_4.angles;
    var_10.spawnflags = 4;
    var_10.traincar = var_4;
    var_10.offset = var_4.maphint_keypadscriptableused;
    var_1 = [];
    var_1 = var_10;
  }

  return var_1;
}

function ai_molotov_swapp(var_0, var_1) {
  var_0 = scripts\engine\utility::array_randomize(var_0);

  if(!isDefined(var_1.mintime)) {
    var_1.mintime = 0;
  }

  if(!isDefined(var_1.ref_13d09)) {
    var_1.ref_13d09 = 190;
  }

  var_2 = isDefined(var_1.ref_12fa4) && isDefined(var_1.ref_12fa5);

  if(istrue(var_1.ref_12fa1)) {
    var_3 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(var_1.ref_12f9f);
  } else {
    var_3 = 0;
  }

  var_4 = spawnStruct();
  var_5 = undefined;
  var_6 = var_2.ref_12fa6;

  foreach(var_8 in var_1) {
    var_9 = distance2d(var_8.origin, var_2.ref_12f9f);

    if(var_9 < var_2.ref_12fa7) {
      continue;
    }

    if(!level.br_circle_disabled) {
      var_10 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(var_8.origin);

      if(var_10 <= var_3) {
        continue;
      }

      if(var_2.ref_13d09 > 0) {
        var_11 = var_9 / var_2.ref_13d09;
        var_10 -= var_11;
      }

      if(var_10 < var_2.mintime) {
        continue;
      }
    }

    if(var_3) {
      if(var_9 < var_2.ref_12fa4) {
        if(var_9 >= var_2.ref_12fa5) {
          var_12 = 0;
        } else {
          var_12 = var_3.ref_12fa5 - var_10;
        }
      } else {
        var_12 = var_13 - var_3.ref_12fa4;
      }

      if(var_12 < var_8) {
        var_8 = var_12;
        var_7 = var_12;

        if(var_12 <= 0) {
          break;
        }
      }

      continue;
    }

    var_6 = var_12;
  }

  var_8 = undefined;
  var_14 = undefined;

  if(isDefined(var_6)) {
    var_14 = var_2[var_6];
  }

  return var_14;
}

function _runcreatequestlocale(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = self[[level.questinfo.quests[var_0].funcs["create_locale"]]](var_1);
  } else {
    var_2 = self[[level.questinfo.quests[var_1].funcs["create_locale"]]]();
  }

  return var_2;
}

function ammo_boxes(var_0, var_1) {
  if(isDefined(var_1)) {
    self[[level.questinfo.quests[var_0].funcs["move_locale"]]](var_1);
    return;
  }

  self[[level.questinfo.quests[var_0].funcs["move_locale"]]]();
}

function _runcheckiflocaleisavailable(var_0) {
  return self[[level.questinfo.quests[var_0].funcs["check_available"]]]();
}

function _findexisitingquestlocale(var_0, var_1) {
  var_2 = getquestdata(var_0);

  if(!isDefined(var_2) || !isDefined(var_2.instances)) {
    return undefined;
  }

  foreach(var_4 in var_2.instances) {
    var_5 = distance2d(var_1.ref_12f9f, var_4.curorigin);

    if(var_5 > var_1.ref_12fa6) {
      continue;
    }

    if(!_runcheckiflocaleisavailable(var_4, var_0)) {
      continue;
    }

    return var_4;
  }

  return undefined;
}

function play_train_speaker_vo(var_0, var_1) {
  jumpiffalse(isDefined(var_1.ref_12c4a)) LOC_0000001d;
  var_2 = var_1.ref_12c4a;
  goto LOC_00000047;
}

function requestquestlocale(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_2) || !var_2) {
    var_3 = _findexisitingquestlocale(var_0, var_1);
  }

  if(!isDefined(var_3)) {
    var_4 = play_train_speaker_vo(var_0, var_1);
    var_3 = _runcreatequestlocale(var_0, var_4);
  }

  ref_1393c(var_3);
  return var_3;
}

function ref_1393c(var_0) {
  self.ref_1393b = var_0;
  var_0.subscribedinstances = scripts\engine\utility::array_add(var_0.subscribedinstances, self);
}

function ref_11daf(var_0, var_1) {
  var_2 = play_train_speaker_vo(var_0, var_1);
  var_2.ref_11c4e = var_1.ref_11c4e;
  ammo_boxes(var_0, var_2);
}

function leavequestlocale() {
  var_0 = getquestdata(self.questcategory).locale_type;
  var_1 = self.ref_1393b;
  var_1.subscribedinstances = scripts\engine\utility::array_remove(var_1.subscribedinstances, self);

  if(var_1.subscribedinstances.size <= 0) {
    removequestinstance(var_1);
    return;
  }
}

function getquestdata(var_0) {
  return level.questinfo.quests[var_0];
}

function getquestinstancedata(var_0, var_1) {
  return level.questinfo.quests[var_0].instances[var_1];
}

function reviveteam(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests[var_0])) {
    var_2 = level.questinfo.quests[var_0].instances[var_1];
  }

  return var_2;
}

function checkforinstance(var_0, var_1) {
  if(isDefined(level.questinfo.quests[var_0].instances[var_1])) {
    return true;
  }

  return false;
}

function _validateplayerfilter(var_0) {
  if(isDefined(var_0)) {
    if(isint(var_0)) {
      return level.questinfo.quests[self.questcategory].filters[var_0];
    }

    if(isarray(var_0)) {
      return var_0;
    }

    return;
  }

  if(isDefined(level.questinfo.quests[self.questcategory].filters)) {
    return level.questinfo.quests[self.questcategory].filters[0];
  }

  return level.questinfo.defaultfilter;
}

function _validateplayer(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(![[var_3]](var_0)) {
      return false;
    }
  }

  return true;
}

function isplayervalid(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  return _validateplayer(var_0, var_2);
}

function isteamvalid(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);

  foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
    if(_validateplayer(var_4, var_2)) {
      return true;
    }
  }

  return false;
}

function isentireteamvalid(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);

  foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
    if(!_validateplayer(var_4, var_2)) {
      return false;
    }
  }

  return true;
}

function getvalidplayersinteam(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  var_3 = [];

  foreach(var_5 in level.teamdata[var_0]["players"]) {
    if(_validateplayer(var_5, var_2)) {
      var_3 = var_5;
    }
  }

  return var_3;
}

function run_trap_room_combat(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = self.squadindex;
  }

  var_3 = _validateplayerfilter(var_1);
  var_4 = [];

  foreach(var_6 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_2)) {
    if(_validateplayer(var_6, var_3)) {
      var_4 = var_6;
    }
  }

  return var_4;
}

function getvalidplayersinarray(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  var_3 = [];

  foreach(var_5 in var_0) {
    if(_validateplayer(var_5, var_2)) {
      var_3 = var_5;
    }
  }

  return var_3;
}

function sortvalidplayersinarray(var_0, var_1) {
  var_2 = _validateplayerfilter(var_1);
  var_3 = [];
  GscBinSkip0(0x2e, "valid", []);
}

function rotations(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = run_trap_room_combat(var_0, var_1, var_2);

  if(var_4.size <= 0) {
    return var_3;
  }

  foreach(var_6 in var_4) {
    var_3 += var_6.origin;
  }

  var_3 /= var_4.size;
  return var_3;
}

function getteamcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = getvalidplayersinteam(var_0, var_1);

  if(var_3.size <= 0) {
    return var_2;
  }

  foreach(var_5 in var_3) {
    var_2 += var_5.origin;
  }

  var_2 /= var_3.size;
  return var_2;
}

function filtercondition_isdead(var_0) {
  if(!isalive(var_0)) {
    return false;
  }

  return true;
}

function filtercondition_isdowned(var_0) {
  if(istrue(var_0.inlaststand)) {
    return false;
  }

  return true;
}

function filtercondition_ingulag(var_0) {
  if(var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return false;
  }

  return true;
}

function filtercondition_hasbeeningulag(var_0) {
  if(isDefined(var_0.gulag)) {
    return false;
  }

  return true;
}

function play_landlord_infil_vo(var_0) {
  if(istrue(var_0 scripts\mp\gametypes\br_public::ref_125f3())) {
    return false;
  }

  return true;
}

function play_intro_hacking_vo(var_0) {
  if(istrue(var_0 scripts\mp\gametypes\br_public::ref_125ec())) {
    return false;
  }

  return true;
}

function ref_121b9(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = var_4;
  var_5 = var_5 << 5 | var_3;
  var_5 = var_5 << 6 | var_2;
  var_5 = var_5 << 5 | var_1;
  var_5 = var_5 << 5 | var_0;
  return var_5;
}

function displayteamsplash(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = self.squadindex;
  }

  var_4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_3);
  longwaitradarsweep(var_4, var_1, var_2);
}

function longwaitradarsweep(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_4 in var_0) {
    if(var_4 scripts\mp\gametypes\br_public::isplayeringulag()) {
      continue;
    }

    if(isbot(var_4) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    if(isDefined(var_2)) {
      if(isDefined(var_2.excludedplayers)) {
        if(scripts\engine\utility::array_contains(var_2.excludedplayers, var_4)) {
          continue;
        }
      }
    }

    displayplayersplash(var_4, var_1, var_2);
  }
}

function displayplayersplash(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(var_2.ref_121b5)) {
    var_0 thread scripts\mp\hud_message::showsplash(var_1, var_2.ref_121b5);
    return;
  }

  if(isDefined(var_2) && isDefined(var_2.intvar)) {
    var_0 thread scripts\mp\hud_message::showsplash(var_1, var_2.intvar);
    return;
  }

  var_0 thread scripts\mp\hud_message::showsplash(var_1);
}

function look_at_heli(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2 * var_2;
  var_6 = [];

  foreach(var_8 in level.players) {
    var_9 = distancesquared(var_1, var_8.origin);

    if(var_9 > var_5) {
      continue;
    }

    if(isDefined(var_4) && isDefined(var_4.ogangles) && scripts\engine\utility::array_contains(var_4.ogangles, var_8.team)) {
      continue;
    }

    if(isDefined(var_4) && isDefined(var_4.excludedplayers) && scripts\engine\utility::array_contains(var_4.excludedplayers, var_8)) {
      continue;
    }

    if(isDefined(var_3) && !isplayervalid(var_8, var_3)) {
      continue;
    }

    var_6 = var_8;
  }

  if(var_6.size > 0) {
    foreach(var_8 in var_6) {
      displayplayersplash(var_8, var_0, var_4);
    }

    return;
  }
}

function look_for_more_leads_vo(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = 0;
  var_4 = var_2 << 12 | var_3 << 4 | var_1;
  self setclientomnvar("ui_br_expanded_obit_message", var_4);
}

function lookforvehicles(var_0, var_1, var_2, var_3) {
  foreach(var_5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1.squadindex)) {
    look_for_more_leads_vo(var_5, var_1, var_2, var_3);
  }
}

function scriptmover_utils(var_0, var_1) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints(var_1);
}

function searchfunc(var_0, var_1) {
  foreach(var_3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
    var_3 thread scripts\mp\utility\points::giveunifiedpoints(var_1);
  }
}

function fronttruck(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_rewards::relic_punchbullets_fire_fists(0, 0, 1, 0, 0);
  var_0 scripts\mp\gametypes\br_rewards::ref_1363a(var_2);
  level thread scripts\mp\gametypes\br_rewards::ref_11aaa();
}

function giveteamplunderflat(var_0, var_1, var_2) {
  var_3 = getdvarfloat("scr_br_plunder_while_spectating", 0.4);
  var_4 = 0;
  var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_2);

  foreach(var_7 in var_5) {
    if(isbot(var_7) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var_8 = var_1;

    if(!scripts\mp\utility\player::isreallyalive(var_7)) {
      var_8 = int(var_1 * var_3);
    }

    var_7 scripts\mp\gametypes\br_plunder::ref_12627(var_8);
    level.br_plunder.ref_12784 += var_8;
  }
}

function giveteamplunderdistributive(var_0, var_1) {
  var_2 = int(var_1 / var_0.size);

  foreach(var_4 in var_0) {
    if(isbot(var_4) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var_4 scripts\mp\gametypes\br_plunder::ref_12627(var_2);
    level.br_plunder.ref_12784 += var_2;
    scripts\mp\gametypes\br_analytics::ref_13c44(var_4, "mission", var_2);
  }
}

function dropplunder(var_0, var_1, var_2, var_3) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var_4 = 0;
  var_5 = 1;
  var_6 = 2;
  GscBinSkip1(0x45, 0, ["brloot_plunder_cash_uncommon_3", level.br_plunder.quantityepic, getdvarfloat("scr_br_quest_reward_epic", 0.2)]);
}

function getquestindex(var_0) {
  return level.questinfo.ref_139ec[var_0].index;
}

function getquesttableindex(var_0) {
  var_1 = int(tablelookup("mp/brmissions.csv", 1, var_0, 0));
  return var_1;
}

function relic_mythic_modifyplayerdamage() {
  return scripts\engine\utility::ter_op(isDefined(level.br_circle), level.br_circle.circleindex, 0);
}

function obj_room_fire_01(var_0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex)) {
    return 1;
  }

  var_1 = revivingteammate(var_0.ref_139eb);

  if(relic_mythic_modifyplayerdamage() < var_1) {
    return 0;
  }

  var_2 = reviveweapon(var_0.ref_139eb);

  if(relic_mythic_modifyplayerdamage() > var_2) {
    return -1;
  }

  return 1;
}

function rewards(var_0) {
  var_1 = tablelookup("mp/brmissions.csv", 11, var_0, 1);
  return var_1;
}

function revivingteammate(var_0) {
  if(!isDefined(level.br_circle)) {
    return 0;
  }

  var_1 = tablelookup("mp/brmissions.csv", 1, var_0, 18);

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = 0;
  }

  return int(var_1);
}

function reviveweapon(var_0) {
  if(!isDefined(level.br_circle)) {
    return 65535;
  }

  var_1 = tablelookup("mp/brmissions.csv", 1, var_0, 19);

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = level.br_level.default_class_chosen.size + 1;
  }

  return int(var_1);
}

function uiobjectiveshow(var_0) {
  var_1 = getquestindex(var_0);
  ref_131ae(var_1);
}

function uiobjectiveshowtoteam(var_0, var_1) {
  foreach(var_3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, self.squadindex)) {
    uiobjectiveshow(var_3, var_0);
  }
}

function uiobjectivehide() {
  ref_131ae(0);
}

function uiobjectivehidefromteam(var_0) {
  foreach(var_2 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
    uiobjectivehide(var_2);
  }
}

function uiobjectivesetparameter(var_0) {
  self setclientomnvar("ui_br_objective_param", var_0);
}

function ref_13efd(var_0) {
  self setclientomnvar("ui_br_objective_loot_id", var_0);
}

function init_tactical_boxes(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self.mapcircle = getmaxobjectivecount(var_3[0], var_3[1], var_3[2]);
    self.guard_spawners = var_3;
  } else {
    self.mapcircle = getmaxobjectivecount(0, 0, 0);
    self.guard_spawners = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self.mapcircle setmapcirclecolorindex(var_0);
  self.mapcircle setmapcircleiconindex(var_1);
  self.mapcircle setmapcirclestyleindex(var_2);
  self.mapcircle hide();
}

function ref_11dae(var_0) {
  self.mapcircle.origin = var_0;
  self.guard_spawners = var_0;
}

function ref_13369() {
  self.mapcircle show();
}

function spawn_double_cargo() {
  self.mapcircle hide();
}

function ref_1336a(var_0) {
  self.mapcircle showtoplayer(var_0);
}

function spawn_dogtags(var_0) {
  self.mapcircle hidefromplayer(var_0);
}

function lastdirtyscore() {
  self.mapcircle delete();
}

function ref_1316f(var_0) {
  self.mapcircle.origin = (self.mapcircle.origin[0], self.mapcircle.origin[1], var_0);
}

function init_tape_machine_animations(var_0, var_1, var_2) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, var_1, (0, 0, 0), var_0);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(var_2)) {
      ref_11db0(var_2);
      return;
    }

    return;
  }
}

function ref_11db0(var_0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var_0);
}

function ref_1336c(var_0) {
  objective_addclienttomask(self.objectiveiconid, var_0);
}

function ref_1336b(var_0) {
  objective_addalltomask(var_0);
}

function spawn_downed_friendly(var_0) {
  objective_removeclientfrommask(self.objectiveiconid, var_0);
}

function gethelispawns() {
  return isDefined(self.objectiveiconid);
}

function lastdropedtime() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

function ref_140b1(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0);
  var_4 = scripts\engine\trace::ray_trace(var_0 + (0, 0, 4000), var_0, undefined, var_3, undefined, 1)["position"];
  var_5 = spawn("script_model", var_4);

  if(!isDefined(var_5)) {
    return;
  }

  var_5.angles = vectortoangles((0, 0, 1));
  var_5 setModel("equip_flare_br");
  wait 0.5;
  var_5 setscriptablepartstate("launch", "start", 0);
  var_6 = "start";

  if(var_1 == "revive") {
    var_6 = "start_revive";
  }

  var_5 setscriptablepartstate("travel", var_6, 0);
  thread apc_rus_driverturretreload(var_5, var_1);
}

function apc_rus_driverturretreload(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = 3.125;
  self moveTo(self.origin + (0, 0, 2500), var_2);
  wait var_2;
  apc_rus_adjustdriverturretammo(var_0, var_1);
}

function apc_rus_adjustdriverturretammo(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "<undefined>";
  }

  self setscriptablepartstate("travel", "off", 0);

  if(!apc_rus_damagecancriticalhit(var_0)) {
    return;
  }

  var_2 = "start_" + var_0;
  self setscriptablepartstate("explode", var_2, 0);
  thread ref_1328f(var_1);
}

function apc_rus_damagecancriticalhit(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "doomstation":
      case "revive":
      case "dom":
        var_1 = 1;
        break;
      case "attack":
        var_1 = 1;
        break;
      case "exfil":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

function ref_1328f(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = 12;

  if(isDefined(var_0) && var_0 > 1) {
    var_1 = var_0;
  }

  self setscriptablepartstate("phosphorus", "start", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "start", 0);
  wait var_1;
  self setscriptablepartstate("phosphorus", "end", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "off", 0);
  wait 5;
  self delete();
}

function ref_12971(var_0) {
  var_1 = 0;

  if(var_0.spawnflags & 4) {
    var_1 = 256;
  } else if(var_0.spawnflags & 2) {
    var_1 = 128;
  } else if(var_0.spawnflags & 1) {
    var_1 = 168;
  } else if(var_0.spawnflags & 16) {
    var_1 = 256;
  }

  return var_1;
}

function ref_1297c(var_0, var_1) {
  var_2 = getquestdata(var_0);
  var_2.ref_1408f = getdvarint("scr_br_" + var_0 + "_enableQuestTime", var_1);
}

function ref_1297d(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = var_0 + var_1;
  var_3 = getquestdata(self.category);

  if(!var_3.ref_1408f) {
    return;
  }

  self.ref_11c51 = gettime() + var_2 * 1000;
  ref_1297e();
}

function ref_1297b(var_0) {
  var_1 = getquestdata(self.category);

  if(!var_1.ref_1408f) {
    return;
  }

  self.ref_11c51 += var_0 * 1000;
  ref_1297e();
}

function questtimersubtract(var_0) {
  var_1 = getquestdata(self.category);

  if(!var_1.ref_1408f) {
    return;
  }

  if(self.ref_11c51 - gettime() - var_0 * 1000 <= 0) {
    self.ref_11c51 = gettime() + 1000;
  } else {
    self.ref_11c51 -= var_0 * 1000;
  }

  ref_1297e();
}

function ref_1297e() {
  var_0 = undefined;

  if(istrue(level.questinfo.ref_132e8) && isDefined(self.team)) {
    var_0 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
  } else {
    var_0 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.id, self.squadindex);
  }

  foreach(var_2 in var_0) {
    var_2 setclientomnvar("ui_br_objective_countdown_timer", self.ref_11c51);
  }

  var_4 = getquestdata(self.category);
  var_5 = var_4.funcs["onTimerUpdate"];

  if(isDefined(var_5)) {
    [[var_5]]();
  }

  thread ally_damage_thread();
}

function ally_damage_thread() {
  self notify("updateQuestTimer");
  level endon("game_ended");
  self endon("updateQuestTimer");
  self endon("questEnded");
  var_0 = (self.ref_11c51 - gettime()) / 1000;
  wait var_0;
  var_1 = getquestdata(self.category);
  var_2 = var_1.funcs["onTimerExpired"];

  if(isDefined(var_2)) {
    [[var_2]]();
  }

  self.result = "timeout";
  thread removequestinstance();
}

function ref_12b15(var_0) {
  if(!isDefined(self.house_enter_animate_and_kill_player)) {
    self.house_enter_animate_and_kill_player = [];
  }

  if(!scripts\engine\utility::array_contains(self.house_enter_animate_and_kill_player, var_0)) {
    self.house_enter_animate_and_kill_player[self.house_enter_animate_and_kill_player.size] = var_0;
    return;
  }
}

function search_speed(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex);
  }

  foreach(var_7 in var_4) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(!isDefined(var_7.ref_11c4f)) {
      var_7.ref_11c4f = 1;
    } else {
      var_7.ref_11c4f++;
    }

    var_7 scripts\mp\gametypes\br_gametype_dmz::ref_121b6();

    if(getdvarint("OMSQPMNQLS", 0) && var_7 scripts\mp\utility\game::onlinestatsenabled()) {
      var_7 setplayerdata("mp", "use_quest_complete_history", 0, 1);
    }
  }

  return search_nodes(self.questcategory, self.ref_12d2d, self.modifier, var_0, var_1, var_2, var_3, var_4, var_5);
}

function search_nodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = rewardtotype(var_0, var_1, var_2);
  return search_activate_battle_station(var_9, var_3, var_4, var_5, var_6, var_7, var_8);
}

function search_activate_battle_station(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  level.intel_active = 0;
  level.playerlocationselectinterrupt = 0;
  var_8 = rider_models(var_0);

  foreach(var_10 in var_8) {
    var_11 = search_maneuver_think(var_14, var_10, var_1, var_2, var_3, var_4, var_5, var_6);
    var_12 = var_11[0];
    var_13 = var_11[1];
    var_11 = undefined;

    if(isDefined(var_7[var_12])) {
      if(isstring(var_7[var_12])) {
        var_7 = var_7[var_12] + "," + var_13;
      } else {
        var_7 = var_7[var_12] + var_13;
      }

      continue;
    }

    var_7 = var_13;
  }

  level.intel_active = undefined;
  level.playerlocationselectinterrupt = undefined;
  return var_7;
}

function search_maneuver_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = ringing(var_2);
  var_9 = right_side_spawn_adjuster(var_0);
  var_10 = ring(var_0);

  if(!isstring(var_10)) {
    var_11 = rings(var_1, var_8);

    if(var_11 != 1) {
      var_10 *= var_11;
      var_10 = get_vehicle_getin_anim(var_9, var_10);
    }
  }

  var_10 = search_acceleration(var_9, var_10, var_2, var_3, var_4, var_5, var_6, var_7);
  return [var_9, var_10];
}

function search_acceleration(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = self.squadindex;

  if(isDefined(var_7)) {
    var_8 = var_7;
  }

  switch (var_0) {
    case "plunder":
      if(istrue(level.br_plunder_enabled)) {
        var_9 = isDefined(var_5) && istrue(var_5.ref_121e3);

        if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "gold_war" && !var_9) {
          giveteamplunderflat(var_2, var_1, var_8);
        } else if(var_6.size > 0) {
          giveteamplunderdistributive(var_6, var_1);
        } else {
          var_1 = 0;
        }
      } else {
        var_1 = 0;
      }

      break;
    case "xp":
      if(isDefined(var_5) && istrue(var_5.ref_121e5)) {
        var_10 = var_6;
      } else {
        var_10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_3, var_10);
      }

      foreach(var_12 in var_10) {
        var_12 thread scripts\mp\events::killeventtextpopup("br_missionComplete", 0);
        var_12 scripts\mp\rank::giverankxp("br_missionComplete", var_2);
        var_12.defaultclassindex = scripts\mp\gametypes\br::get_int_or_0(var_12.defaultclassindex) + var_2;
      }

      break;
    case "weapon_xp":
      if(isDefined(var_6) && istrue(var_6.ref_121e4)) {
        var_10 = var_7;
      } else {
        var_10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_4, var_10);
      }

      foreach(var_12 in var_10) {
        var_15 = var_12.lastnormalweaponobj;
        var_12 scripts\mp\gametypes\br::scriptableusestate("", var_3, var_15, 0, 0);
      }

      break;
    case "loot_table":
      if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "gold_war") {
        var_17 = pickscriptablelootitem(var_7, var_3);
        ref_12973(var_4, var_17, var_5, var_6, istrue(level.playerlocationselectinterrupt), var_10);
      }

      break;
    case "loot_cache":
      var_17 = pickscriptablelootitem(var_7, var_3);
      ref_12973(var_4, var_17, var_5, var_6, 1, var_10);
      level.playerlocationselectinterrupt = 1;
      break;
    case "loot_items":
      var_17 = strtok(var_3, " ");
      ref_12973(var_4, var_17, var_5, var_6, istrue(level.playerlocationselectinterrupt), var_10);
      break;
    case "loot_items_drop":
      var_17 = strtok(var_3, " ");
      var_18 = undefined;

      if(isDefined(var_7)) {
        var_18 = var_7.stadium_three_death_func;
      }

      ref_12973(var_4, var_17, var_5, var_6, 1, var_10, 0, var_18);
      break;
    case "drop_bag":
      var_19 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_4, var_10)[0];
      fronttruck(var_19, var_5);
      break;
    case "circle_peek":
      ref_12972(var_4, var_10);
      break;
    case "reward_tier":
      thread battletracksmusicstatestandingonvehicle(var_4, var_3, var_10);
      break;
    case "blueprint_chance":
      var_20 = getdvarint("scr_br_alt_mode_bblitz", 0) == 0;
      var_21 = scripts\mp\gametypes\br_extract_quest::usb_keys();

      if(var_20 && var_21) {
        var_22 = scripts\mp\gametypes\br_blueprint_extract_spawn::convoy4_actively_hacking(var_5, var_7.type);

        if(isDefined(var_22)) {
          scripts\mp\gametypes\br_blueprint_extract_spawn::control_station_interact(var_4, self.tablet);
          var_17 = [var_22];
          ref_12973(var_4, var_17, var_5, var_6, istrue(level.playerlocationselectinterrupt));
          displayteamsplash(var_4, "br_blueprint_extract_quest_spawned", undefined, var_10);
        }
      }

      break;
    case "uav":
      var_23 = relic_count(var_4, var_8, var_5, var_10);

      if(isDefined(var_23)) {
        thread ref_12977(var_23);
      }

      break;
    case "juggernaut":
      var_24 = spawnStruct();
      var_24.origin = var_5;
      var_24.modify_blast_shield_damage = 300;
      var_24.ref_11eab = 1;
      level thread scripts\mp\gametypes\br_jugg_common::mlgiconfullflag(var_24, "quest_reward");
      break;
    case "killstreak":
      var_25 = relic_count(var_4, var_8, var_5, var_10);

      if(isDefined(var_25)) {
        thread ref_12975(var_25);
      }

      break;
    case "quest":
      var_12 = relic_count(var_4, var_8, var_5, var_10);

      if(isDefined(var_12)) {
        thread ref_12976(var_12);
      }

      break;
    case "none":
      break;
    default:
      break;
  }

  return var_3;
}

function relic_count(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1.size > 0) {
    var_4 = var_1;
  } else {
    var_4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, var_4);
  }

  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_4) {
    if(!isDefined(var_8)) {
      continue;
    }

    var_9 = distance2d(var_8.origin, var_3);

    if(!isDefined(var_6) || var_9 < var_6) {
      var_6 = var_9;
      var_5 = var_8;
    }
  }

  return var_5;
}

function ref_13234() {
  if(istrue(level.br_circle_disabled)) {
    return;
  }

  level.gulag_tutorial_vo = [];
  level.ref_13aca = [];

  for(var_0 = 1; var_0 < level.br_level.br_circleradii.size; var_0++) {
    var_1 = level.br_level.br_circleradii[var_0];
    var_2 = level.br_level.default_class_chosen[var_0];
    level.gulag_tutorial_vo[var_0] = getmaxobjectivecount(var_2[0], var_2[1], var_1);
    level.gulag_tutorial_vo[var_0] setmapcirclecolorindex(4);
    level.gulag_tutorial_vo[var_0] setmapcirclestyleindex(1);
    level.gulag_tutorial_vo[var_0] hide();
  }

  thread gulag_think();
}

function gulag_think() {
  level endon("game_ended");
  level endon("CirclePeekCleanup");

  for(;;) {
    level waittill("br_circle_set");
    level.gulag_tutorial_vo[level.br_circle.circleindex + 1] delete();

    foreach(var_1 in getarraykeys(level.ref_13aca)) {
      level.ref_13aca[var_1]--;

      if(level.ref_13aca[var_1] < 0) {
        level.ref_13aca[var_1] = 0;
      }
    }
  }
}

function ref_12972(var_0, var_1) {
  if(istrue(level.br_circle_disabled)) {
    return;
  }

  if(!isDefined(level.ref_13aca[var_0])) {
    level.ref_13aca[var_0] = 0;
  }

  level.ref_13aca[var_0]++;
  var_2 = level.ref_13aca[var_0] + level.br_circle.circleindex + 1;

  if(!isDefined(level.gulag_tutorial_vo[var_2])) {
    foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_1)) {
      var_4 scripts\mp\utility\lower_message::ref_1316e("circle_peek_limit", undefined, 5);
    }

    return;
  }

  foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_3, var_4)) {
    level.gulag_tutorial_vo[var_5] showtoplayer(var_4);
  }
}

function riotshield_checkshield(var_0) {
  var_1 = level.questinfo.ref_12d2f.get_vehicle_idle_anim[var_0];

  if(!isDefined(var_1)) {
    var_1 = tablelookup("mp/brmissions.csv", 1, var_0, 7);
    level.questinfo.ref_12d2f.get_vehicle_idle_anim[var_0] = var_1;
  }

  return var_1;
}

function rider_models(var_0) {
  var_1 = right_control();
  var_2 = level.questinfo.ref_12d2f.set_look_at_ent[var_0];

  if(!isDefined(var_2)) {
    var_2 = [];
    var_3 = 2;
    var_4 = 3;

    for(;;) {
      var_5 = tablelookup(var_1, 0, var_0, var_3);

      if(var_5 == "") {
        break;
      }

      var_6 = tablelookup(var_1, 0, var_0, var_4);
      var_2 = var_6;
      var_3 += 2;
      var_4 += 2;
    }

    if(isDefined(level.elevator_lights_toggle)) {
      var_2 = [[level.elevator_lights_toggle]](var_2);
    }

    level.questinfo.ref_12d2f.set_look_at_ent[var_0] = var_2;
  }

  return var_2;
}

function right_side_spawn_adjuster(var_0) {
  var_1 = "mp/brmission_rewards.csv";
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "dmz" || var_2 == "rat_race" || var_2 == "risk" || var_2 == "gold_war") {
    var_1 = "mp/brmission_rewards_dmz.csv";
  } else if(level.ref_14060 == 1) {
    var_1 = "mp/brmission_rewards_" + var_2 + ".csv";
  }

  var_3 = level.questinfo.ref_12d2f.ref_12d31[var_0];

  if(!isDefined(var_3)) {
    var_3 = tablelookup(var_1, 0, var_0, 1);
    level.questinfo.ref_12d2f.ref_12d31[var_0] = var_3;
  }

  return var_3;
}

function ring(var_0) {
  var_1 = "mp/brmission_rewards.csv";
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "dmz" || var_2 == "rat_race" || var_2 == "risk") {
    var_1 = "mp/brmission_rewards_dmz.csv";
  }

  if(var_2 == "gold_war") {
    var_1 = "mp/brmission_rewards_gold_war.csv";
  } else if(level.ref_14060 == 1) {
    var_1 = "mp/brmission_rewards_" + var_2 + ".csv";
  }

  var_3 = level.questinfo.ref_12d2f.ref_12d32[var_0];

  if(!isDefined(var_3)) {
    var_4 = rewardscriptable(var_0);

    if(isDefined(var_4)) {
      var_3 = var_4;
    } else {
      var_5 = ringcodephoneconstantly();
      var_3 = tablelookup(var_1, 0, var_0, var_5);
    }

    var_6 = right_side_spawn_adjuster(var_0);
    var_3 = get_vehicle_getin_anim(var_6, var_3);
    level.questinfo.ref_12d2f.ref_12d32[var_0] = var_3;
  }

  if(istrue(level.convoy_handle_stuck_compromise) && !isstring(var_3)) {
    var_3 = int(var_3 * level.ref_12192);
  }

  return var_3;
}

function ringcodephoneconstantly() {
  var_0 = level.maxteamsize;

  if(scripts\mp\gametypes\br_public::validtousesticker()) {
    var_0 = 1;
  }

  switch (var_0) {
    case 4:
      return 10;
    case 3:
      return 9;
    case 2:
      return 8;
    case 1:
      return 7;
    default:
      return 9;
  }
}

function rewardscriptable(var_0) {
  var_1 = getdvarint("scr_questReward_" + var_0, -1);

  if(var_1 > -1) {
    return var_1;
  }

  return undefined;
}

function rifle_lights(var_0) {
  var_1 = level.questinfo.ref_12d2f.ref_12ec4[var_0];

  if(!isDefined(var_1)) {
    var_1 = [];
    var_2 = 1;
    var_3 = 2;

    for(;;) {
      var_4 = tablelookup("mp/brmission_reward_scalers.csv", 0, var_0, var_2);

      if(var_4 == "") {
        break;
      }

      var_4 = int(var_4);
      var_5 = float(tablelookup("mp/brmission_reward_scalers.csv", 0, var_0, var_3));
      var_1 = var_5;
      var_2 += 2;
      var_3 += 2;
    }

    level.questinfo.ref_12d2f.ref_12ec4[var_0] = var_1;
  }

  return var_1;
}

function rewardorigin(var_0) {
  return rewardmodifier(self.questcategory, var_0, self.modifier, self.ref_12d2d);
}

function riotshieldmodeltag(var_0) {
  return riotshieldiscurrentprimary(self.questcategory, var_0, self.modifier, self.ref_12d2d);
}

function riotshieldclearvars(var_0) {
  return riotshield_return(self.questcategory, var_0, self.modifier, self.ref_12d2d);
}

function rewardmodifier(var_0, var_1, var_2, var_3) {
  if(!level.br_plunder_enabled) {
    return 0;
  }

  return ringphoneoccasionally(var_0, var_1, "plunder", var_2, var_3);
}

function riotshieldiscurrentprimary(var_0, var_1, var_2, var_3) {
  return ringphoneoccasionally(var_0, var_1, "xp", var_2, var_3);
}

function riotshield_return(var_0, var_1, var_2, var_3) {
  return ringphoneoccasionally(var_0, var_1, "weapon_xp", var_2, var_3);
}

function ringphoneoccasionally(var_0, var_1, var_2, var_3, var_4) {
  var_5 = rewardtotype(var_0, var_4, var_3);
  var_6 = rider_models(var_5);
  var_7 = 0;

  foreach(var_9 in var_6) {
    var_10 = right_side_spawn_adjuster(var_13);

    if(var_10 == var_2) {
      var_11 = ring(var_13);
      var_12 = rings(var_9, var_1);
      var_7 += var_11 * var_12;
    }
  }

  var_7 = get_vehicle_getin_anim(var_2, var_7);
  return var_7;
}

function rings(var_0, var_1) {
  var_2 = 1;
  var_3 = rifle_lights(var_0);
  var_4 = 0;

  for(var_5 = 1; var_5 <= var_1; var_5++) {
    if(isDefined(var_3[var_5])) {
      var_4 = var_3[var_5];
    }

    var_2 += var_4;
  }

  if(level.maxteamsize > 4) {
    var_2 = 1 + (var_2 - 1) * 4 / level.maxteamsize;
  }

  return var_2;
}

function rewardangles(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;

  foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
    if(istrue(var_4.should_drop_scavenger_bag)) {
      var_2++;
    }
  }

  if(!var_1 && isDefined(level.questinfo.ref_11b69) && isDefined(level.questinfo.ref_11b69[var_0])) {
    var_2 = int(min(var_2, level.questinfo.ref_11b69[var_0]));
  }

  return var_2;
}

function ref_12973(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    return;
  }

  var_8 = spawnStruct();
  var_8.origin = var_2;
  var_8.angles = var_3;
  var_8.itemsdropped = 0;

  if(isDefined(level.intel_active)) {
    var_8.itemsdropped = level.intel_active;
  }

  var_9 = var_8 scripts\mp\gametypes\br_lootcache::ref_11a42(var_1, var_4, var_6, var_7, 1);

  foreach(var_11 in var_9) {
    var_11.team = var_0;
    var_11.squadindex = var_5;
  }

  if(isDefined(level.intel_active)) {
    level.intel_active = var_8.itemsdropped;
    return;
  }
}

function ref_12977(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  var_1.ref_133ce = 1;
  var_1.ref_133cc = 1;
  scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct(var_1);
}

function ref_12975(var_0) {
  var_1 = isDefined(self.streakdata.streaks[1]);
  scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var_0, var_1, 0);
  thread scripts\mp\hud_message::showsplash("br_killstreak_purchased");
}

function ref_12976(var_0) {
  var_1 = ref_135df(var_0, self.origin, 1);
  ref_13a38(var_1);
}

function ref_135df(var_0, var_1, var_2) {
  var_3 = easepower(removepatchablecollision_delayed(var_0), var_1);
  tabletinit(var_3, var_0);
  var_3.keepinmap = 1;
  thread handleprop();

  if(istrue(var_2)) {
    var_3 setscriptablepartstate(var_3.type, "hidden");
  }

  return var_3;
}

function handleprop() {
  self endon("death");
  self waittill("questEnded");
  self freescriptable();
}

function rewardtotype(var_0, var_1, var_2) {
  var_3 = riotshield_checkshield(var_0);
  var_4 = var_3;

  if(isDefined(var_2)) {
    var_4 += var_2;
  }

  if(isDefined(var_1)) {
    var_4 += var_1;
  }

  if(ref_12974(var_4)) {
    return var_4;
  }

  var_4 = var_3;

  if(isDefined(var_1)) {
    var_4 += var_1;
  }

  if(ref_12974(var_4)) {
    return var_4;
  }

  return var_3;
}

function ref_12974(var_0) {
  var_1 = right_control();
  var_2 = tablelookup(var_1, 0, var_0, 0);
  return var_2 != "";
}

function rocket_death_fx(var_0) {
  switch (var_0) {
    case "blueprint_chance":
    case "drop_bag":
    case "loot_table":
    case "reward_tier":
    case "loot_cache":
    case "circle_peek":
    case "weapon_xp":
    case "plunder":
    case "xp":
    case "juggernaut":
    case "none":
      return "int";
    case "loot_items_drop":
    case "loot_items":
    case "quest":
    case "uav":
    case "killstreak":
      return "string";
    default:
      break;
  }
}

function get_vehicle_getin_anim(var_0, var_1) {
  var_2 = rocket_death_fx(var_0);

  switch (var_2) {
    case "int":
      var_1 = int(var_1);
      break;
    case "float":
      var_1 = float(var_1);
      break;
    case "string":
      var_1 = "" + var_1;
      break;
    default:
      break;
  }

  return var_1;
}

function right_control() {
  var_0 = getDvar("br_mission_reward_groups_filename", "mp/brmission_reward_groups.csv");

  if(var_0 == "") {
    var_0 = "mp/brmission_reward_groups.csv";
  }

  return var_0;
}

function rewardtovalue(var_0) {
  var_1 = right_control();
  return int(tablelookup(var_1, 0, var_0, 1));
}

function ringing(var_0) {
  var_1 = level.questinfo.ref_13b62[var_0];

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  return var_1;
}

function ref_131b0(var_0, var_1, var_2) {
  level.questinfo.ref_13b62[var_0] = var_1;
  ref_131b2(var_0, var_1, var_2);
}

function battletracksmusicstate(var_0, var_1, var_2) {
  ref_131b0(var_0, ringing(var_0) + var_1, var_2);
}

function battletracksmusicstatestandingonvehicle(var_0, var_1, var_2, var_3) {
  waittillframeend();
  ref_131b0(var_0, ringing(var_0) + var_1, var_2);
}

function ref_131af(var_0, var_1) {
  foreach(var_3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, self.squadindex)) {
    ref_131ae(var_3, var_1);
  }
}

function ref_131ae(var_0) {
  self setclientomnvar("ui_br_objective_index", var_0);
}

function ref_131b2(var_0, var_1, var_2) {
  foreach(var_4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0, var_2)) {
    ref_131b1(var_4, var_1);
  }
}

function ref_131b1(var_0) {
  self setclientomnvar("ui_br_objective_reward_tier", var_0);
}

function generate_solution() {
  foreach(var_1 in level.questinfo.quests) {
    foreach(var_3 in var_1.instances) {
      var_3.result = "cancel";
      removequestinstance(var_3);
    }
  }
}

function register_vehicle_spawners(var_0) {
  var_1 = [];

  foreach(var_3 in level.questinfo.quests) {
    foreach(var_5 in var_3.instances) {
      if(var_7 != var_0) {
        continue;
      }

      if(upper_door_coll(var_5)) {
        continue;
      }

      var_6 = spawnStruct();
      var_6.tracknonoobplayerlocation = var_5;

      switch (var_5.category) {
        case "assassination":
          if(isDefined(var_5.targetplayer)) {
            var_6.origin = var_5.targetplayer.origin;
          }

          break;
        case "domination":
          if(isDefined(var_5.ref_1393b) && isDefined(var_5.ref_1393b.domflag) && isDefined(var_5.ref_1393b.domflag.curorigin)) {
            var_6.origin = var_5.ref_1393b.domflag.curorigin + (0, 0, 60);
          }

          break;
        case "lep":
        case "scavenger":
          if(isDefined(var_5.ref_1393b.force_spawn_all_dead_players.origin) && isDefined(var_5.ref_1393b.force_spawn_all_dead_players)) {
            var_6.origin = var_5.ref_1393b.force_spawn_all_dead_players.origin + (0, 0, 50);
          }

          break;
        case "timedrun":
          break;
        case "launch_code":
        case "geigerstash":
        case "secretstash":
          if(isDefined(var_5.force_spawn_all_dead_players) && isDefined(var_5.force_spawn_all_dead_players.origin)) {
            var_6.origin = var_5.force_spawn_all_dead_players.origin + (0, 0, 50);
          }

          break;
        case "collection":
        case "x2_amb_signal":
        case "x2_stash":
        case "x2_map":
        case "x2_signal":
        case "x2_amb1":
        case "x2_bomb":
        case "x1fin":
        case "history":
        case "x1stash":
        case "smokinggun":
        case "blueprintextract":
        case "vip":
          break;
        case "capshoot":
          if(isDefined(var_5.ref_1393b) && isDefined(var_5.ref_1393b.get_closest_living_player_not_in_laststand) && isDefined(var_5.ref_1393b.get_closest_living_player_not_in_laststand.curorigin)) {
            var_6.origin = var_5.ref_1393b.get_closest_living_player_not_in_laststand.curorigin + (0, 0, 60);
          }

          break;
        default:
          break;
      }

      var_1 = var_6;
    }
  }

  return var_1;
}

function riotshield_init_cp(var_0) {
  var_1 = level.questinfo.ref_13f19[scripts\engine\utility::string(var_0)];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1.ref_13f18;
}

function risk_flagspawndebugobjicons(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = 0;

  foreach(var_3 in level.questinfo.ref_13f19) {
    var_1 += var_3.ref_13f17[var_0];
  }

  var_5 = randomfloatrange(0, var_1);
  var_6 = 0;

  foreach(var_3 in level.questinfo.ref_13f19) {
    var_8 = var_3.ref_13f17[var_0];

    if(var_8 <= 0) {
      continue;
    }

    var_6 += var_8;

    if(var_5 <= var_6) {
      return var_3.ref_11a23;
    }
  }

  return level.questinfo.ref_13f19[0].ref_11a23;
}

function ref_12c08() {
  if(level.mapname == "mp_don4") {
    var_0 = (-31160, 57824, 4536);
    var_1 = 1000;
    var_2 = getlootspawnpoint(var_0, var_1, 0, 1);

    foreach(var_4 in var_2) {
      getlootspawnpointcount(var_4.index);
    }

    return;
  }
}
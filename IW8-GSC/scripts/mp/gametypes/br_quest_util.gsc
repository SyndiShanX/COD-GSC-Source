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

  if(isDefined(level.ƒó« Ç2J‹ ÿ0Û;¥ 6‹ ü·)) {
    [[level.ƒó« Ç2J‹ ÿ0Û;¥6‹ ü·]]();
  }

  if(isDefined(level.½3‘–¹ ÆÊ± Þ½ G3] æl– Þ¹ ä² ÖX£ Æ† È·› Y)) {
  thread disablelootfunctionprematchdone(level.½3‘–¹ ÆÊ± Þ½ G3] æl– Þ¹ ä² ÖX£ Æ† È·› Y);
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
  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/brmission_unlockables.csv", var0, 0);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = spawnStruct();
    var2.ref_13f18 = int(var1);
    var2.ref_11a23 = int(tablelookup("mp/brmission_unlockables.csv", 0, var1, 1));
    var2.ref_13f17 = [];

    for(var3 = 0;; var3++) {
      var4 = tablelookup("mp/brmission_unlockables.csv", 0, var1, 3 + var3);

      if(!isDefined(var4) || var4 == "") {
        break;
      }

      var2.ref_13f17[var3] = int(var4);
    }

    level.questinfo.ref_13f19[scripts\engine\utility::string(var2.ref_11a23)] = var2;
  }
}

function disablelootfunctionprematchdone(var0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  [[var0]]();
}

function little_bird_mg_playercontrolmg(var0, var1, var2, var3) {
  var4 = 175;
  var5 = 100;

  if(!isDefined(var1)) {
    var1 = var4;
  }

  if(!isDefined(var2)) {
    var2 = var5;
  }

  var6 = getlootspawnpoint(var0, var1, 0, 1);

  foreach(var8 in var6) {
    if(tv_station_marker_player_connect_monitor(var0[2], var8.origin[2], var2)) {
      getlootspawnpointcount(var8.index);
    }
  }
}

function disabletabletsaroundorigin(var0, var1, var2) {
  foreach(var4 in level.questinfo.tabletinfo) {
    var5 = canceljoins(removepatchablecollision_delayed(var9), undefined, var0, var1);

    foreach(var7 in var5) {
      if(tv_station_marker_player_connect_monitor(var0[2], var7.origin[2], var2)) {
        var7.Ž¹ Ì uŠÌˆˆ + Pƒ½ ã) OÖG = 1;
      scripts\mp\gametypes\br_pickups::ref_11a21(var7);
    }
  }
}
}

function tv_station_marker_player_connect_monitor(var0, var1, var2) {
  return abs(var0 - var1) <= var2;
}

function debugdrawlootdisableradius(var0, var1, var2) {
  level endon("game_ended");
  var3 = (0, 0, var1);
  var4 = var0 - var3;
  var5 = var0 + var3;

  for(;;) {
    wait 1;
  }
}

function inittablets() {
  level.questinfo.activetablets = [];
  var3 = getdvarfloat("scr_br_quest_tablet_hide_percent", 0.667);
  var4 = [];

  foreach(var2, var1 in level.questinfo.tabletinfo) {
    var6 = removepatchablecollision_delayed(var2);
    var7 = getlootscriptablearrayinradius(var6);

    if(!var1.enabled) {
      continue;
    }

    if(var7.size > 0) {
      var8 = getdvarfloat("scr_br_quest_tablet_kiosk_dist", 1200);

      if(var8 > 0) {
        var9 = 0;

        foreach(var11 in level.br_armory_kiosk.scriptables) {
          var12 = canceljoins(var6, undefined, var11.origin, var8);

          foreach(var14 in var12) {
            if(istrue(var14.ref_13840)) {
              continue;
            }

            var14.ref_13840 = 1;
            var9++;
          }
        }

        for(var17 = var7.size - 1; var17 >= 0 && var9; var17--) {
          if(istrue(var7[var17].ref_13840)) {
            var7 = var7[var7.size - 1];
            var7[var7.size - 1] = undefined;
            var9--;
          }
        }
      }
    }

    if(istrue(level.ref_11a5e) && scripts\mp\gametypes\br::ref_11a5c()) {
      var18 = getdvarfloat("scr_br_quest_tablet_lowpop_percent", 0.8);
      var19 = int(min(var7.size, var7.size * (1 - var18) + 0.5));

      for(var17 = 0; var17 < var19; var17++) {
        var20 = randomintrange(0, var7.size);
        var7[var20].ref_13840 = 1;
        var7 = var7[var7.size - 1];
        var7[var7.size - 1] = undefined;
      }
    }

    for(var17 = var7.size - 1; var17 >= 0; var17--) {
      var21 = var7[var17];
      tabletinit(var21, var2);

      if(!var21.init) {
        var7[var17].ref_13840 = 1;
        var7 = var7[var7.size - 1];
        var7[var7.size - 1] = undefined;
      }
    }

    if(var7.size) {
      ref_13180(var2);
    }

    var22 = revivingteammate(rewards(var6));

    if(isDefined(level.br_circle) && isDefined(var22) && var22 > 0) {
      var23 = var7.size;
    } else {
      var24 = var7.size * var3;
      var23 = int(var24);
      var25 = var24 - var23;

      if(randomfloat(1) < var25) {
        var23++;
      }
    }

    for(var17 = 0; var17 < var23; var17++) {
      var20 = randomintrange(0, var7.size);
      var21 = var7[var20];
      var7[var20].ref_13840 = 1;
      var4 = var7[var20];
      var7 = var7[var7.size - 1];
      var7[var7.size - 1] = undefined;
    }
  }

  var26 = getarraykeys(level.calloutglobals.ref_11e29);
  var27 = [];
  var28 = getdvarint("scr_br_quest_tablet_location_min", 1);

  if(var28 > 0) {
    foreach(var30 in var26) {
      var27 = var28;
    }
  }

  var32 = 0;

  foreach(var2, var1 in level.questinfo.tabletinfo) {
    var7 = getlootscriptablearrayinradius(removepatchablecollision_delayed(var2));
    var32 += var7.size;

    if(var1.enabled) {
      foreach(var21 in var7) {
        if(istrue(var21.ref_13840)) {
          tablethide(var21);
          continue;
        }

        tabletshow(var21);

        if(var27.size > 0) {
          var35 = scripts\mp\gametypes\br_callouts::removeminigunrestrictions(var21.origin);

          if(isDefined(var27[var35])) {
            var27--;

            if(!var27[var35]) {
              var27[var35] = undefined;
            }
          }
        }
      }

      continue;
    }

    foreach(var21 in var7) {
      tablethide(var21);
    }
  }

  if(var27.size) {
    var4 = scripts\engine\utility::array_randomize(var4);
    var17 = 0;

    while(var17 < var4.size) {
      var21 = var4[var17];
      var22 = revivingteammate(var21.ref_139eb);

      if(isDefined(level.br_circle) && isDefined(var22) && var22 > 0) {
        var17++;
      } else {
        var35 = scripts\mp\gametypes\br_callouts::removeminigunrestrictions(var21.origin);

        if(isDefined(var27[var35])) {
          tabletshow(var21);
          var27--;

          if(!var27[var35]) {
            var27[var35] = undefined;

            if(!var27.size) {
              break;
            }
          }
        }
      }

      var7++;
    }
  }

  var40 = level.questinfo.activetablets.size;
  var41 = var3.size;
  scripts\mp\gametypes\br_analytics::destroypropspecatehud(var28, var40, var41, < error > );

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("tabletReplace")) {
    thread ref_139e9(var3);
    return;
  }

  thread ks_airdropcratearmor(var3);
}

function ref_13180(var0) {
  if(issubstr(var0, "_redacted")) {
    if(!isDefined(level.ref_12aac)) {
      level.ref_12aac = "";
    }

    if(level.ref_12aac == "") {
      var1 = getquestindex(var0);
      setomnvarbit("ui_br_objective_types", var1, 1);
      level.ref_12aac = var0;
      return;
    }

    return;
  }

  var1 = getquestindex(var1);
  setomnvarbit("ui_br_objective_types", var1, 1);
}

function ref_139e9(var0) {
  if(!isDefined(level.br_level)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = 0;
  var2 = level.ref_139ea;
  var3 = 0;
  var4 = var0.size;

  foreach(var6 in var0) {
    if(!isDefined(var6.circleindex)) {
      var6.circleindex = scripts\mp\gametypes\br_circle::relic_amped_reset_deathshield_on_revived(var6.origin);
    }
  }

  while(var3 < var4) {
    var8 = var0[var3];

    if(istrue(var8.Ž¹ Ì uŠÌˆˆ + Pƒ½ ã) OÖG)) {
    var3++;
    continue;
  }

  level waittill("quest_started");
  var9 = obj_room_fire_01(var8);

  if(var9 < 1) {
    var10 = 0;

    while(var3 < var4) {
      if(var9 == 1 && var8.circleindex >= relic_mythic_modifyplayerdamage()) {
        break;
      }

      if(var9 == 0 && var8.circleindex >= relic_mythic_modifyplayerdamage()) {
        var0 = var8;
      }

      var3++;
      var8 = var0[var3];
      var9 = obj_room_fire_01(var8);
    }
  }

  if(var3 == var4) {
    var4 = var0.size;
    continue;
  }

  if(isDefined(level.ref_139ea) && level.ref_139ea != -1) {
    var1++;

    if(var1 >= var2) {
      tabletshow(var8);
      var2 += level.ref_139ea;
      var3++;
      var4 = var0.size;
    }

    continue;
  }

  tabletshow(var8);
  var3++;
  var4 = var0.size;
}
}

function ks_airdropcratearmor(var0) {
  if(!isDefined(level.br_level)) {
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("delayedShowTablets")) {
    level thread scripts\mp\gametypes\br_gametypes::ref_12e05("delayedShowTablets", var0);
    return;
  }

  var1 = getdvarfloat("scr_br_quest_tablet_show_percent", 0.3);
  var2 = getdvarint("scr_br_quest_tablet_show_circle_disable_override", 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  var3 = level.br_level.br_circledelaytimes.size - 1 - getdvarint("scr_br_quest_tablet_show_circle_disable", 4);

  if(getdvarint("scr_br_resurgence_respawn_enable", 0) == 1) {
    var3 = scripts\mp\gametypes\br_gametype_rebirth::rocket_attack_min_cooldown();
  } else if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("gulag")) {
    var3 = scripts\mp\gametypes\br_gulag::remove_engineer_class();
  }

  if(var2 > 0) {
    var3 = var2;
  }

  var4 = [];

  for(var5 = 0; var5 < var0.size; var5++) {
    var6 = var0[var5];
    var6.circleindex = scripts\mp\gametypes\br_circle::relic_amped_reset_deathshield_on_revived(var6.origin);

    if(var6.circleindex >= 0) {
      var4 = var6;
    }
  }

  var0 = scripts\engine\utility::array_randomize(var4);

  for(;;) {
    level waittill("br_circle_set");

    if(!level.br_circle.circleindex) {
      scripts\mp\gametypes\br_analytics::destorder(0, var1, var4.size, 0);
      continue;
    }

    var4 = [];
    var7 = [];

    for(var5 = 0; var5 < var0.size; var5++) {
      var6 = var0[var5];

      if(var6.circleindex >= relic_mythic_modifyplayerdamage()) {
        if(obj_room_fire_01(var6) == 1) {
          var4 = var6;
          continue;
        }

        if(obj_room_fire_01(var6) == 0) {
          var7 = var6;
        }
      }
    }

    var8 = int(ceil(var4.size * var1));
    var9 = int(max(0, getdvarint("scr_br_quest_tablet_show_max", 100) - level.questinfo.activetablets.size));
    var8 = int(min(var8, var9));

    for(var5 = 0; var5 < var8; var5++) {
      var6 = var4[var5];
      tabletshow(var6);
    }

    var0 = [];

    for(var5 = 0; var5 < var7.size; var5++) {
      var0 = var7[var5];
    }

    for(var5 = var8; var5 < var4.size; var5++) {
      var0 = var4[var5];
    }

    scripts\mp\gametypes\br_analytics::destorder(level.br_circle.circleindex, var1, var4.size, var8);

    if(level.br_circle.circleindex >= var3) {
      break;
    }
  }
}

function little_bird_mg_mp_enterendinternal() {
  foreach(var1 in level.questinfo.tabletinfo) {
    var2 = getlootscriptablearrayinradius(removepatchablecollision_delayed(var6));

    if(var1.enabled) {
      foreach(var4 in var2) {
        tablethide(var4);
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
  var0 = self.type;
  self setscriptablepartstate(var0, "visible");
  level.questinfo.activetablets["" + self.index] = self;
  scripts\mp\gametypes\br_analytics::dialog_hurry(self);
}

function tabletinit(var0) {
  if(isDefined(self.init)) {
    return;
  }

  self.init = 1;
  self.ref_139eb = var0;
  var1 = level.questinfo.quests[var0].funcs["tabletInit"];

  if(isDefined(var1)) {
    self.init = self[[var1]]();

    if(!self.init) {
      scripts\mp\gametypes\br_analytics::destroyscoreevent(self);
      return;
    }

    return;
  }
}

function ref_1207a(var0) {
  if(isDefined(level.questinfo.activetablets["" + var0.index])) {
    level.questinfo.activetablets["" + var0.index] = undefined;
    return;
  }
}

function removepatchablecollision_delayed(var0) {
  var1 = undefined;

  if(isDefined(level.questinfo.tabletinfo[var0])) {
    var1 = level.questinfo.tabletinfo[var0].ref_11a3c;
  }

  if(!isDefined(var1)) {
    var1 = "brloot_" + var0 + "_tablet";
  }

  return var1;
}

function registerteamonquest(var0, var1) {
  scripts\mp\gametypes\br_analytics::determinetrackingcirclesize(self, var1);

  if(istrue(level.questinfo.ref_132e8)) {
    var2 = var0 + var1.squadindex;
    level.questinfo.ref_13745 = scripts\engine\utility::array_add(level.questinfo.ref_13745, var2);
  } else {
    level.questinfo.teamsonquests = scripts\engine\utility::array_add(level.questinfo.teamsonquests, var0);
  }

  if(!isDefined(level.questinfo.ref_11b69)) {
    level.questinfo.ref_11b69 = [];
  }

  level.questinfo.ref_11b69[var0] = rewardangles(var0, 1);
  level notify("quest_started", var0, var1.squadindex);
}

function releaseteamonquest(var0) {
  if(scripts\mp\menus::ref_13733()) {}

  if(isDefined(level.questinfo.ref_11b69)) {
    level.questinfo.ref_11b69[var0] = undefined;
    scripts\mp\perks\perkfunctions::ref_14022(var0);
  }

  if(istrue(level.questinfo.ref_132e8)) {
    var1 = var0 + self.squadindex;
    level.questinfo.ref_13745 = scripts\engine\utility::array_remove(level.questinfo.ref_13745, var1);
  } else {
    level.questinfo.teamsonquests = scripts\engine\utility::array_remove(level.questinfo.teamsonquests, var0);
  }

  var2 = ringing(var0);
  var3 = [];

  if(isDefined(self.result) && self.result == "success") {
    foreach(var5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
      if(isbot(var5) && scripts\mp\gametypes\br_public::validtousesticker()) {
        continue;
      }

      var5.egress_landlord_vo = scripts\mp\gametypes\br::get_int_or_0(var5.egress_landlord_vo) + 1;
      var5 scripts\mp\gametypes\br_public::updatebrscoreboardstat("missionsCompleted", var5.egress_landlord_vo);
      var5 scripts\mp\utility\stats::incpersstat("contracts", 1);

      if(!isDefined(var5.ejectplayerfromturret)) {
        var5.ejectplayerfromturret = [];
      }

      var5.ejectplayerfromturret[self.questcategory] = scripts\mp\gametypes\br::get_int_or_0(var5.ejectplayerfromturret[self.questcategory]) + 1;
      var5 scripts\mp\gametypes\br_challenges::getallspawninstances("br_mastery_fiveContracts");
    }

    if(!isDefined(self.ref_11eba) || self.ref_11eba == 0) {
      if(isDefined(self.ref_12d2e) && isDefined(self.ref_12d2b) && isDefined(self.ref_12d30)) {
        var3 = search_speed(var0, self.ref_12d2e, self.ref_12d2b, self.ref_12d30, self.house_enter_animate_and_kill_player);
      }
    }
  }

  if(isDefined(self.result)) {
    var7 = scripts\engine\utility::ter_op(self.result == "success", 1, 2);
    var8 = self.category;

    foreach(var5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
      if(isbot(var5) && scripts\mp\gametypes\br_public::validtousesticker()) {
        continue;
      }

      var5 scripts\cp\vehicles\vehicle_compass_cp::ref_12009(self.category, var7, 1);
      var5 scripts\mp\gametypes\br_gametypes::ref_12e05("onContractEnd", var7);
      var5 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    if(isDefined(self.targetteam)) {
      var11 = scripts\engine\utility::ter_op(self.result == "success", 2, 1);

      foreach(var5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
        if(isbot(var5) && scripts\mp\gametypes\br_public::validtousesticker()) {
          continue;
        }

        var5 scripts\cp\vehicles\vehicle_compass_cp::ref_12009(self.category, var11, 2);
      }
    }
  }

  var14 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex);
  var15 = var14.size;
  scripts\mp\gametypes\br_analytics::determinetrackingcircleoffset(self, var2, var3, var15);
  self notify("questEnded");

  if(isDefined(self.ref_12d30)) {
    self.ref_12d30 notify("questEnded");
    return;
  }
}

function ref_13879(var0, var1, var2) {
  foreach(var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var2, self.squadindex)) {
    if(isbot(var4) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var4 scripts\cp\vehicles\vehicle_compass_cp::ref_1200a(var0, var1);
  }
}

function ref_13a38(var0) {
  switch (var0.type) {
    case "brloot_redacted_assassination_tablet":
    case "brloot_assassination_tablet":
      scripts\mp\gametypes\br_assassination_quest::takequestitem(var0);
      break;
    case "brloot_redacted_domination_tablet":
    case "brloot_domination_tablet":
      if(scripts\mp\utility\game::round_vehicle_logic() == "payload") {
        scripts\mp\gametypes\br_capshoot_quest::takequestitem(var0);
      } else {
        scripts\mp\gametypes\br_dom_quest::takequestitem(var0);
      }

      break;
    case "brloot_redacted_scavenger_tablet":
    case "brloot_scavenger_tablet":
      scripts\mp\gametypes\br_scavenger_quest::takequestitem(var0);
      break;
    case "brloot_redacted_vip_tablet":
    case "brloot_vip_tablet":
      scripts\mp\gametypes\br_vip_quest::takequestitem(var0);
      break;
    case "brloot_redacted_timedrun_tablet":
    case "brloot_timedrun_tablet":
      scripts\mp\gametypes\br_timedrun_quest::takequestitem(var0);
      break;
    case "brloot_geigerstash_tablet":
      scripts\mp\gametypes\br_geigerstash_quest::takequestitem(var0);
      break;
    case "brloot_blueprintextract_tablet":
      scripts\mp\gametypes\br_extract_quest::takequestitem(var0);
      break;
    case "brloot_scavenger_tablet_adler":
      scripts\mp\gametypes\br_scavenger_quest_adler::takequestitem(var0);
      break;
    case "brloot_scavenger_tablet_soa_tower":
      scripts\mp\gametypes\br_scavenger_quest_soa_tower::takequestitem(var0);
      break;
    case "brloot_lep_tablet":
      scripts\mp\gametypes\br_lep_quest::dropoff_sound_hvt_handler(var0);
      break;
    case "brloot_supply_tablet":
      scripts\mp\gametypes\br_supply_quest::takequestitem(var0);
      break;
    case "brloot_masterassassination_tablet":
      scripts\mp\gametypes\br_masterassassination_quest::takequestitem(var0);
      break;
    case "brloot_redacted_sabotage_tablet":
    case "brloot_sabotage_tablet":
      scripts\mp\gametypes\br_sabotage_quest::takequestitem(var0);
      break;
    case "brloot_black_market_tablet":
      scripts\mp\gametypes\br_black_market_quest::takequestitem(var0);
      break;
  }

  scripts\mp\gametypes\br_plunder::ref_11c91("brloot_mission_tablet", -1);
}

function dangercircletick(var0, var1, var2) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var4 in level.questinfo.activetablets) {
    if(distance2dsquared(var0, var4.origin) > var1 * var1) {
      scripts\mp\gametypes\br_pickups::ref_11a21(var4);
      scripts\mp\gametypes\br_plunder::ref_11c91("brloot_mission_tablet", -1);
    }
  }

  foreach(var7 in level.questinfo.quests) {
    if(isDefined(var7.funcs["circleTick"])) {
      foreach(var9 in var7.instances) {
        var9[[var7.funcs["circleTick"]]](var0, var2);
      }
    }
  }
}

function createquestinstance(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.questcategory = var0;
  var5.enabled = 1;
  var5.category = var0;
  var5.id = var1;
  var5.ref_11c4e = "" + var2;
  var5.ref_12d30 = var3;
  _assignthinkoffset(var5);
  var5.squadindex = var4;
  return var5;
}

function addquestinstance(var0, var1) {
  if(!istrue(level.questinfo.ismanagerthreadthinking)) {
    _initmanagerquestthread();
    thread _questmanagerthread();
  }

  if(!_isquestthreaded(var0) && isDefined(level.questinfo.quests[var0].numthinkfuncs)) {
    if(_checkforregister(var0, "initQuestVars")) {
      _runinitquestvars(level.questinfo.quests[var0], var0);
    }

    _runaddquestinstance(var0, var1);
    _runaddquestthread(var0);
    return;
  }

  _runaddquestinstance(var0, var1);
}

function removequestinstance() {
  if(istrue(self.removed)) {
    return;
  }

  self.removed = 1;
  self notify("marked_to_remove");
  var0 = self.questcategory;
  _runremovequestinstance(var0);

  if(isDefined(self.ref_1393b)) {
    leavequestlocale();
  }

  if(_questinstancesactive(var0) <= 0) {
    if(_checkforregister(var0, "clearQuestVars")) {
      _runclearquestvars(level.questinfo.quests[var0], var0);
    }

    if(_questthreadsactive() <= 0) {
      _removemanagerquestthread();
      return;
    }

    return;
  }
}

function upper_door_coll(var0) {
  return isDefined(var0.subscribedinstances);
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

    foreach(var1 in level.questinfo.thinkers) {
      if(!level.questinfo.quests[var1].enabled) {
        continue;
      }

      foreach(var3 in level.questinfo.quests[var1].instances) {
        if(var3.enabled) {
          _runquestthinkfunctions(var3, var1);
        }
      }
    }
  }
}

function _runquestthinkfunctions(var0) {
  for(var1 = 0; var1 < level.questinfo.quests[var0].numthinkfuncs; var1++) {
    if((level.questinfo.thinkindex - self.thinkoffset + self.firstthink) % level.questinfo.quests[var0].thinkrates[var1] == 0) {
      var2 = "questThink" + var1;
      [[level.questinfo.quests[var0].funcs[var2]]]();
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

function _registerquestfunc(var0, var1, var2) {
  level.questinfo.quests[var0].funcs[var2] = var1;
}

function _checkforregister(var0, var1) {
  return isDefined(level.questinfo.quests[var0].funcs[var1]);
}

function registerquestcategory(var0, var1) {
  var2 = upload_station_players_manager(var0, var1);
  var3 = spawnStruct();
  var3.enabled = var2;
  level.questinfo.tabletinfo[var0] = var3;

  if(!var2) {
    return false;
  }

  _registerquestcategory(var0);
  return true;
}

function upload_station_players_manager(var0, var1) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("missions")) {
    return false;
  }

  return getdvarint("scr_br_" + var0 + "_quest", var1) == 1;
}

function registerquestlocale(var0) {
  _registerquestcategory(var0);
}

function _registerquestcategory(var0) {
  if(!isDefined(level.questinfo.quests[var0])) {
    level.questinfo.quests[var0] = spawnStruct();
    level.questinfo.quests[var0].initflag = 0;
    level.questinfo.quests[var0].hasinitfunc = 0;
    level.questinfo.quests[var0].funcs = [];
    level.questinfo.quests[var0].instances = [];
    level.questinfo.quests[var0].enabled = 1;
    ref_12b38(var0);
    return;
  }
}

function ref_12b38(var0) {
  level.questinfo.ref_139ec[var0] = spawnStruct();
  level.questinfo.ref_139ec[var0].index = getquesttableindex(var0);
}

function registerinitquestvars(var0, var1) {
  _registerquestfunc(var0, var1, "initQuestVars");
  level.questinfo.quests[var0].hasinitfunc = 1;
}

function registerquestthink(var0, var1, var2) {
  if(!isDefined(level.questinfo.quests[var0].numthinkfuncs)) {
    level.questinfo.quests[var0].numthinkfuncs = 0;
  }

  var3 = int(var2 * 20);
  level.questinfo.quests[var0].thinkrates[level.questinfo.quests[var0].numthinkfuncs] = var3;
  var4 = "questThink" + level.questinfo.quests[var0].numthinkfuncs;
  _registerquestfunc(var0, var1, var4);
  level.questinfo.quests[var0].numthinkfuncs += 1;
}

function registerquestcircletick(var0, var1) {
  _registerquestfunc(var0, var1, "circleTick");
}

function registerremovequestinstance(var0, var1) {
  _registerquestfunc(var0, var1, "removeInstance");
}

function registerclearquestvars(var0, var1) {
  _registerquestfunc(var0, var1, "clearQuestVars");
}

function registerplayerfilter(var0, var1, var2) {
  if(!isDefined(level.questinfo.quests[var0].filters)) {
    level.questinfo.quests[var0].filters = [];
  }

  if(isDefined(var2)) {
    level.questinfo.quests[var0].filters[var2] = var1;
    return;
  }

  var3 = level.questinfo.quests[var0].filters.size;
  level.questinfo.quests[var0].filters[var3] = var1;
}

function registeronplayerkilled(var0, var1) {
  _registerquestfunc(var0, var1, "onPlayerKilled");
}

function ref_12b2e(var0, var1) {
  _registerquestfunc(var0, var1, "onPlayerDisconnect");
}

function ref_12b2d(var0, var1) {
  _registerquestfunc(var0, var1, "onEnterGulag");
}

function ref_12b30(var0, var1) {
  _registerquestfunc(var0, var1, "onRespawn");
}

function ref_12b32(var0, var1) {
  _registerquestfunc(var0, var1, "onTimerUpdate");
}

function ref_12b31(var0, var1) {
  _registerquestfunc(var0, var1, "onTimerExpired");
}

function ref_12b3d(var0, var1) {
  _registerquestfunc(var0, var1, "tabletInit");
}

function ref_12b2a(var0, var1) {
  level.questinfo.tabletinfo[var0].ref_11a3c = var1;
}

function _clearregisters(var0) {
  var1 = [];
}

function onplayerkilled(var0, var1) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var3 in level.questinfo.quests) {
    if(isDefined(var3.funcs["onPlayerKilled"])) {
      foreach(var5 in var3.instances) {
        var5[[var3.funcs["onPlayerKilled"]]](var0, var1);
      }
    }
  }
}

function onplayerconnect(var0) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  if(!isDefined(var0.team)) {
    return;
  }

  ref_131b0(var0.team, ringing(var0.team), var0.squadindex);
}

function onplayerdisconnect(var0) {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var2 in level.questinfo.quests) {
    if(isDefined(var2.funcs["onPlayerDisconnect"])) {
      foreach(var4 in var2.instances) {
        var4[[var2.funcs["onPlayerDisconnect"]]](var0);
      }
    }
  }
}

function ref_1206c() {
  if(!isDefined(level.questinfo)) {
    return;
  }

  foreach(var1 in level.questinfo.quests) {
    if(isDefined(var1.funcs["onEnterGulag"])) {
      foreach(var3 in var1.instances) {
        var3[[var1.funcs["onEnterGulag"]]](self);
      }
    }
  }
}

function ref_12072() {
  if(!isDefined(level.questinfo)) {
    return;
  }

  self setclientomnvar("ui_player_spawned_notify", gettime());

  foreach(var1 in level.questinfo.quests) {
    if(isDefined(var1.funcs["onRespawn"])) {
      foreach(var3 in var1.instances) {
        var3[[var1.funcs["onRespawn"]]](self);
      }
    }
  }
}

function _runinitquestvars(var0) {
  [[level.questinfo.quests[var0].funcs["initQuestVars"]]]();
}

function _runaddquestthread(var0) {
  if(!_isquestthreaded(var0)) {
    var2 = level.questinfo.thinkers.size;
    level.questinfo.thinkers[var2] = var0;
    level.questinfo.quests[var0].enabled = 1;
    return;
  }
}

function _runaddquestinstance(var0, var1) {
  level.questinfo.quests[var0].instances[var1.id] = var1;
}

function _runremovequestinstance(var0) {
  self[[level.questinfo.quests[var0].funcs["removeInstance"]]]();
  self notify("removed");
  level.questinfo.quests[var0].instances[self.id] = undefined;
}

function _runclearquestvars(var0) {
  [[level.questinfo.quests[var0].funcs["clearQuestVars"]]]();
  level.questinfo.thinkers = scripts\engine\utility::array_remove(level.questinfo.thinkers, var0);
  level.questinfo.quests[var0].enabled = 0;
}

function _isquestthreaded(var0) {
  if(scripts\engine\utility::array_contains(level.questinfo.thinkers, var0)) {
    return true;
  }

  return false;
}

function _questinstancesactive(var0) {
  if(isDefined(level.questinfo.quests[var0].instances)) {
    return level.questinfo.quests[var0].instances.size;
  }

  return 0;
}

function _questthreadsactive() {
  if(isDefined(level.questinfo.thinkers)) {
    return level.questinfo.thinkers.size;
  }

  return 0;
}

function createlocaleinstance(var0, var1, var2) {
  var3 = createquestinstance(var0, var2, "invalid", undefined, self.squadindex);
  var3.subscriber_type = var1;
  getquestdata(var1).locale_type = var0;
  var3.subscribedinstances = [];
  return var3;
}

function registercreatequestlocale(var0, var1) {
  _registerquestfunc(var0, var1, "create_locale");
}

function ref_12b2b(var0, var1) {
  _registerquestfunc(var0, var1, "move_locale");
}

function registercheckiflocaleisavailable(var0, var1) {
  _registerquestfunc(var0, var1, "check_available");
}

function adrenaline_crate_player_at_max_ammo(var0) {
  switch (var0.ref_12fa3) {
    case "GetEntitylessScriptableArray":
      return getentitylessscriptablearrayinradius(var0.vehicle_collision_registerevent, "classname", var0.ref_12f9f, var0.ref_12fa6);
    case "getUnusedLootCacheArray":
      var1 = getlootspawnpoint(var0.ref_12f9f, var0.ref_12fa6, 0, 1);
      return var1;
    case "questPointsArray":
      return disablelootspawnpoint(var1.ref_1297f, var1.ref_12f9f, var1.ref_12fa6, 0, 1);
    case "questPointsArrayWZTrain":
      var2 = play_thrust_fx(var1);

      if(isDefined(var2)) {
        return var2;
      }

      var1.ref_1407e = undefined;
      return disablelootspawnpoint(var1.ref_1297f, var1.ref_12f9f, var1.ref_12fa6, 0, 1);
    case "getKiosks":
      var3 = scripts\mp\gametypes\br_armory_kiosk::registeraccesscardlocs();
      var4 = [];

      foreach(var6 in level.br_armory_kiosk.scriptables) {
        if(!istrue(var6.disabled)) {
          var4 = var6;
        }
      }

      return var4;
    case "getInactiveHelipads":
      if(isDefined(level.br_plunder_sites)) {
        var8 = scripts\mp\gametypes\br_plunder::retrieve_data_objective();
        var9 = [];

        foreach(var11 in var8) {
          if(istrue(var11 getscriptablepartstate(var11.type) == "hidden")) {
            var9 = var11;
          }
        }

        if(var9.size == 0) {
          return var8;
        }

        return var9;
      }
    default:
      break;
  }
}

function play_thrust_fx(var0) {
  var1 = undefined;

  if(isDefined(level.ref_145f1) && isDefined(level.ref_145f1.ref_13c8d)) {
    if([[level.ref_145f1.funcs.c130airdrop_createpath]]()) {
      return undefined;
    }

    if([[level.ref_145f1.funcs.c130airdrop_deleteatlifetime]](100, 20)) {
      return undefined;
    }

    var2 = [];

    foreach(var4 in level.ref_145f1.ref_13c8d) {
      if(isDefined(var4.maphint_keypadscriptableused) && level.ref_145f1.hotfootlastposition >= var4.mapnamefilter) {
        var2 = var4;
      }
    }

    var6 = 0;
    var7 = undefined;

    foreach(var4 in var2) {
      if(isDefined(var4.maphitloctoburningpart) && var6 < var4.maphitloctoburningpart) {
        var6 = var4.maphitloctoburningpart;
        var7 = var4;
      }
    }

    if(var2.size > 1) {
      if(isDefined(var7)) {
        var2 = scripts\engine\utility::array_remove(var2, var7);
      }
    }

    var4 = scripts\engine\utility::random(var2);
    var4.maphitloctoburningpart = gettime();
    level.ref_145f1.hostvictimskipburndownmedium = var4;
    var10 = spawnStruct();
    var10.origin = var4.origin;
    var10.angles = var4.angles;
    var10.spawnflags = 4;
    var10.traincar = var4;
    var10.offset = var4.maphint_keypadscriptableused;
    var1 = [];
    var1 = var10;
  }

  return var1;
}

function ai_molotov_swapp(var0, var1) {
  var0 = scripts\engine\utility::array_randomize(var0);

  if(!isDefined(var1.mintime)) {
    var1.mintime = 0;
  }

  if(!isDefined(var1.ref_13d09)) {
    var1.ref_13d09 = 190;
  }

  var2 = isDefined(var1.ref_12fa4) && isDefined(var1.ref_12fa5);

  if(istrue(var1.ref_12fa1)) {
    var3 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(var1.ref_12f9f);
  } else {
    var3 = 0;
  }

  var4 = spawnStruct();
  var5 = undefined;
  var6 = var2.ref_12fa6;

  foreach(var8 in var1) {
    var9 = distance2d(var8.origin, var2.ref_12f9f);

    if(var9 < var2.ref_12fa7) {
      continue;
    }

    if(!level.br_circle_disabled) {
      var10 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(var8.origin);

      if(var10 <= var3) {
        continue;
      }

      if(var2.ref_13d09 > 0) {
        var11 = var9 / var2.ref_13d09;
        var10 -= var11;
      }

      if(var10 < var2.mintime) {
        continue;
      }
    }

    if(var3) {
      if(var9 < var2.ref_12fa4) {
        if(var9 >= var2.ref_12fa5) {
          var12 = 0;
        } else {
          var12 = var3.ref_12fa5 - var10;
        }
      } else {
        var12 = var13 - var3.ref_12fa4;
      }

      if(var12 < var8) {
        var8 = var12;
        var7 = var12;

        if(var12 <= 0) {
          break;
        }
      }

      continue;
    }

    var6 = var12;
  }

  var8 = undefined;
  var14 = undefined;

  if(isDefined(var6)) {
    var14 = var2[var6];
  }

  return var14;
}

function _runcreatequestlocale(var0, var1) {
  if(isDefined(var1)) {
    var2 = self[[level.questinfo.quests[var0].funcs["create_locale"]]](var1);
  } else {
    var2 = self[[level.questinfo.quests[var1].funcs["create_locale"]]]();
  }

  return var2;
}

function ammo_boxes(var0, var1) {
  if(isDefined(var1)) {
    self[[level.questinfo.quests[var0].funcs["move_locale"]]](var1);
    return;
  }

  self[[level.questinfo.quests[var0].funcs["move_locale"]]]();
}

function _runcheckiflocaleisavailable(var0) {
  return self[[level.questinfo.quests[var0].funcs["check_available"]]]();
}

function _findexisitingquestlocale(var0, var1) {
  var2 = getquestdata(var0);

  if(!isDefined(var2) || !isDefined(var2.instances)) {
    return undefined;
  }

  foreach(var4 in var2.instances) {
    var5 = distance2d(var1.ref_12f9f, var4.curorigin);

    if(var5 > var1.ref_12fa6) {
      continue;
    }

    if(!_runcheckiflocaleisavailable(var4, var0)) {
      continue;
    }

    return var4;
  }

  return undefined;
}

function play_train_speaker_vo(var0, var1) {
  jumpiffalse(isDefined(var1.ref_12c4a)) LOC_0000001d;
  var2 = var1.ref_12c4a;
  goto LOC_00000047;
}

function requestquestlocale(var0, var1, var2) {
  var3 = undefined;

  if(!isDefined(var2) || !var2) {
    var3 = _findexisitingquestlocale(var0, var1);
  }

  if(!isDefined(var3)) {
    var4 = play_train_speaker_vo(var0, var1);
    var3 = _runcreatequestlocale(var0, var4);
  }

  ref_1393c(var3);
  return var3;
}

function ref_1393c(var0) {
  self.ref_1393b = var0;
  var0.subscribedinstances = scripts\engine\utility::array_add(var0.subscribedinstances, self);
}

function ref_11daf(var0, var1) {
  var2 = play_train_speaker_vo(var0, var1);
  var2.ref_11c4e = var1.ref_11c4e;
  ammo_boxes(var0, var2);
}

function leavequestlocale() {
  var0 = getquestdata(self.questcategory).locale_type;
  var1 = self.ref_1393b;
  var1.subscribedinstances = scripts\engine\utility::array_remove(var1.subscribedinstances, self);

  if(var1.subscribedinstances.size <= 0) {
    removequestinstance(var1);
    return;
  }
}

function getquestdata(var0) {
  return level.questinfo.quests[var0];
}

function getquestinstancedata(var0, var1) {
  return level.questinfo.quests[var0].instances[var1];
}

function reviveteam(var0, var1) {
  var2 = undefined;

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests[var0])) {
    var2 = level.questinfo.quests[var0].instances[var1];
  }

  return var2;
}

function checkforinstance(var0, var1) {
  if(isDefined(level.questinfo.quests[var0].instances[var1])) {
    return true;
  }

  return false;
}

function _validateplayerfilter(var0) {
  if(isDefined(var0)) {
    if(isint(var0)) {
      return level.questinfo.quests[self.questcategory].filters[var0];
    }

    if(isarray(var0)) {
      return var0;
    }

    return;
  }

  if(isDefined(level.questinfo.quests[self.questcategory].filters)) {
    return level.questinfo.quests[self.questcategory].filters[0];
  }

  return level.questinfo.defaultfilter;
}

function _validateplayer(var0, var1) {
  foreach(var3 in var1) {
    if(![[var3]](var0)) {
      return false;
    }
  }

  return true;
}

function isplayervalid(var0, var1) {
  var2 = _validateplayerfilter(var1);
  return _validateplayer(var0, var2);
}

function isteamvalid(var0, var1) {
  var2 = _validateplayerfilter(var1);

  foreach(var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
    if(_validateplayer(var4, var2)) {
      return true;
    }
  }

  return false;
}

function isentireteamvalid(var0, var1) {
  var2 = _validateplayerfilter(var1);

  foreach(var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
    if(!_validateplayer(var4, var2)) {
      return false;
    }
  }

  return true;
}

function getvalidplayersinteam(var0, var1) {
  var2 = _validateplayerfilter(var1);
  var3 = [];

  foreach(var5 in level.teamdata[var0]["players"]) {
    if(_validateplayer(var5, var2)) {
      var3 = var5;
    }
  }

  return var3;
}

function run_trap_room_combat(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = self.squadindex;
  }

  var3 = _validateplayerfilter(var1);
  var4 = [];

  foreach(var6 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var2)) {
    if(_validateplayer(var6, var3)) {
      var4 = var6;
    }
  }

  return var4;
}

function getvalidplayersinarray(var0, var1) {
  var2 = _validateplayerfilter(var1);
  var3 = [];

  foreach(var5 in var0) {
    if(_validateplayer(var5, var2)) {
      var3 = var5;
    }
  }

  return var3;
}

function sortvalidplayersinarray(var0, var1) {
  var2 = _validateplayerfilter(var1);
  var3 = [];
  GscBinSkip0(0x2e, "valid", []);
}

function rotations(var0, var1, var2) {
  var3 = (0, 0, 0);
  var4 = run_trap_room_combat(var0, var1, var2);

  if(var4.size <= 0) {
    return var3;
  }

  foreach(var6 in var4) {
    var3 += var6.origin;
  }

  var3 /= var4.size;
  return var3;
}

function getteamcenter(var0, var1) {
  var2 = (0, 0, 0);
  var3 = getvalidplayersinteam(var0, var1);

  if(var3.size <= 0) {
    return var2;
  }

  foreach(var5 in var3) {
    var2 += var5.origin;
  }

  var2 /= var3.size;
  return var2;
}

function filtercondition_isdead(var0) {
  if(!isalive(var0)) {
    return false;
  }

  return true;
}

function filtercondition_isdowned(var0) {
  if(istrue(var0.inlaststand)) {
    return false;
  }

  return true;
}

function filtercondition_ingulag(var0) {
  if(var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return false;
  }

  return true;
}

function filtercondition_hasbeeningulag(var0) {
  if(isDefined(var0.gulag)) {
    return false;
  }

  return true;
}

function play_landlord_infil_vo(var0) {
  if(istrue(var0 scripts\mp\gametypes\br_public::ref_125f3())) {
    return false;
  }

  return true;
}

function play_intro_hacking_vo(var0) {
  if(istrue(var0 scripts\mp\gametypes\br_public::ref_125ec())) {
    return false;
  }

  return true;
}

function ref_121b9(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var5 = var4;
  var5 = var5 << 5 | var3;
  var5 = var5 << 6 | var2;
  var5 = var5 << 5 | var1;
  var5 = var5 << 5 | var0;
  return var5;
}

function displayteamsplash(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = self.squadindex;
  }

  var4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var3);
  longwaitradarsweep(var4, var1, var2);
}

function longwaitradarsweep(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  foreach(var4 in var0) {
    if(var4 scripts\mp\gametypes\br_public::isplayeringulag()) {
      continue;
    }

    if(isbot(var4) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    if(isDefined(var2)) {
      if(isDefined(var2.excludedplayers)) {
        if(scripts\engine\utility::array_contains(var2.excludedplayers, var4)) {
          continue;
        }
      }
    }

    displayplayersplash(var4, var1, var2);
  }
}

function displayplayersplash(var0, var1, var2) {
  if(isDefined(var2) && isDefined(var2.ref_121b5)) {
    var0 thread scripts\mp\hud_message::showsplash(var1, var2.ref_121b5);
    return;
  }

  if(isDefined(var2) && isDefined(var2.intvar)) {
    var0 thread scripts\mp\hud_message::showsplash(var1, var2.intvar);
    return;
  }

  var0 thread scripts\mp\hud_message::showsplash(var1);
}

function look_at_heli(var0, var1, var2, var3, var4) {
  var5 = var2 * var2;
  var6 = [];

  foreach(var8 in level.players) {
    var9 = distancesquared(var1, var8.origin);

    if(var9 > var5) {
      continue;
    }

    if(isDefined(var4) && isDefined(var4.ogangles) && scripts\engine\utility::array_contains(var4.ogangles, var8.team)) {
      continue;
    }

    if(isDefined(var4) && isDefined(var4.excludedplayers) && scripts\engine\utility::array_contains(var4.excludedplayers, var8)) {
      continue;
    }

    if(isDefined(var3) && !isplayervalid(var8, var3)) {
      continue;
    }

    var6 = var8;
  }

  if(var6.size > 0) {
    foreach(var8 in var6) {
      displayplayersplash(var8, var0, var4);
    }

    return;
  }
}

function look_for_more_leads_vo(var0, var1, var2) {
  var3 = var0 getentitynumber();

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var4 = 0;
  var4 = var2 << 12 | var3 << 4 | var1;
  self setclientomnvar("ui_br_expanded_obit_message", var4);
}

function lookforvehicles(var0, var1, var2, var3) {
  foreach(var5 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var1.squadindex)) {
    look_for_more_leads_vo(var5, var1, var2, var3);
  }
}

function scriptmover_utils(var0, var1) {
  var0 thread scripts\mp\utility\points::giveunifiedpoints(var1);
}

function searchfunc(var0, var1) {
  foreach(var3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
    var3 thread scripts\mp\utility\points::giveunifiedpoints(var1);
  }
}

function fronttruck(var0, var1) {
  var2 = scripts\mp\gametypes\br_rewards::relic_punchbullets_fire_fists(0, 0, 1, 0, 0);
  var0 scripts\mp\gametypes\br_rewards::ref_1363a(var2);
  level thread scripts\mp\gametypes\br_rewards::ref_11aaa();
}

function giveteamplunderflat(var0, var1, var2) {
  var3 = getdvarfloat("scr_br_plunder_while_spectating", 0.4);
  var4 = 0;
  var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var2);

  foreach(var7 in var5) {
    if(isbot(var7) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var8 = var1;

    if(!scripts\mp\utility\player::isreallyalive(var7)) {
      var8 = int(var1 * var3);
    }

    var7 scripts\mp\gametypes\br_plunder::ref_12627(var8);
    level.br_plunder.ref_12784 += var8;
  }
}

function giveteamplunderdistributive(var0, var1) {
  var2 = int(var1 / var0.size);

  foreach(var4 in var0) {
    if(isbot(var4) && scripts\mp\gametypes\br_public::validtousesticker()) {
      continue;
    }

    var4 scripts\mp\gametypes\br_plunder::ref_12627(var2);
    level.br_plunder.ref_12784 += var2;
    scripts\mp\gametypes\br_analytics::ref_13c44(var4, "mission", var2);
  }
}

function dropplunder(var0, var1, var2, var3) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var4 = 0;
  var5 = 1;
  var6 = 2;
  GscBinSkip1(0x45, 0, ["brloot_plunder_cash_uncommon_3", level.br_plunder.quantityepic, getdvarfloat("scr_br_quest_reward_epic", 0.2)]);
}

function getquestindex(var0) {
  return level.questinfo.ref_139ec[var0].index;
}

function getquesttableindex(var0) {
  var1 = int(tablelookup("mp/brmissions.csv", 1, var0, 0));
  return var1;
}

function relic_mythic_modifyplayerdamage() {
  return scripts\engine\utility::ter_op(isDefined(level.br_circle), level.br_circle.circleindex, 0);
}

function obj_room_fire_01(var0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex)) {
    return 1;
  }

  var1 = revivingteammate(var0.ref_139eb);

  if(relic_mythic_modifyplayerdamage() < var1) {
    return 0;
  }

  var2 = reviveweapon(var0.ref_139eb);

  if(relic_mythic_modifyplayerdamage() > var2) {
    return -1;
  }

  return 1;
}

function rewards(var0) {
  var1 = tablelookup("mp/brmissions.csv", 11, var0, 1);
  return var1;
}

function revivingteammate(var0) {
  if(!isDefined(level.br_circle)) {
    return 0;
  }

  var1 = tablelookup("mp/brmissions.csv", 1, var0, 18);

  if(!isDefined(var1) || var1 == "") {
    var1 = 0;
  }

  return int(var1);
}

function reviveweapon(var0) {
  if(!isDefined(level.br_circle)) {
    return 65535;
  }

  var1 = tablelookup("mp/brmissions.csv", 1, var0, 19);

  if(!isDefined(var1) || var1 == "") {
    var1 = level.br_level.default_class_chosen.size + 1;
  }

  return int(var1);
}

function uiobjectiveshow(var0) {
  var1 = getquestindex(var0);
  ref_131ae(var1);
}

function uiobjectiveshowtoteam(var0, var1) {
  foreach(var3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, self.squadindex)) {
    uiobjectiveshow(var3, var0);
  }
}

function uiobjectivehide() {
  ref_131ae(0);
}

function uiobjectivehidefromteam(var0) {
  foreach(var2 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
    uiobjectivehide(var2);
  }
}

function uiobjectivesetparameter(var0) {
  self setclientomnvar("ui_br_objective_param", var0);
}

function ref_13efd(var0) {
  self setclientomnvar("ui_br_objective_loot_id", var0);
}

function init_tactical_boxes(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    self.mapcircle = getmaxobjectivecount(var3[0], var3[1], var3[2]);
    self.guard_spawners = var3;
  } else {
    self.mapcircle = getmaxobjectivecount(0, 0, 0);
    self.guard_spawners = (0, 0, 0);
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  self.mapcircle setmapcirclecolorindex(var0);
  self.mapcircle setmapcircleiconindex(var1);
  self.mapcircle setmapcirclestyleindex(var2);
  self.mapcircle hide();
}

function ref_11dae(var0) {
  self.mapcircle.origin = var0;
  self.guard_spawners = var0;
}

function ref_13369() {
  self.mapcircle show();
}

function spawn_double_cargo() {
  self.mapcircle hide();
}

function ref_1336a(var0) {
  self.mapcircle showtoplayer(var0);
}

function spawn_dogtags(var0) {
  self.mapcircle hidefromplayer(var0);
}

function lastdirtyscore() {
  self.mapcircle delete();
}

function ref_1316f(var0) {
  self.mapcircle.origin = (self.mapcircle.origin[0], self.mapcircle.origin[1], var0);
}

function init_tape_machine_animations(var0, var1, var2) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, var1, (0, 0, 0), var0);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(var2)) {
      ref_11db0(var2);
      return;
    }

    return;
  }
}

function ref_11db0(var0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var0);
}

function ref_1336c(var0) {
  objective_addclienttomask(self.objectiveiconid, var0);
}

function ref_1336b(var0) {
  objective_addalltomask(var0);
}

function spawn_downed_friendly(var0) {
  objective_removeclientfrommask(self.objectiveiconid, var0);
}

function gethelispawns() {
  return isDefined(self.objectiveiconid);
}

function lastdropedtime() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

function ref_140b1(var0, var1, var2) {
  level endon("game_ended");
  var3 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0);
  var4 = scripts\engine\trace::ray_trace(var0 + (0, 0, 4000), var0, undefined, var3, undefined, 1)["position"];
  var5 = spawn("script_model", var4);

  if(!isDefined(var5)) {
    return;
  }

  var5.angles = vectortoangles((0, 0, 1));
  var5 setModel("equip_flare_br");
  wait 0.5;
  var5 setscriptablepartstate("launch", "start", 0);
  var6 = "start";

  if(var1 == "revive") {
    var6 = "start_revive";
  }

  var5 setscriptablepartstate("travel", var6, 0);
  thread apc_rus_driverturretreload(var5, var1);
}

function apc_rus_driverturretreload(var0, var1) {
  self endon("death");
  level endon("game_ended");
  var2 = 3.125;
  self moveTo(self.origin + (0, 0, 2500), var2);
  wait var2;
  apc_rus_adjustdriverturretammo(var0, var1);
}

function apc_rus_adjustdriverturretammo(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "<undefined>";
  }

  self setscriptablepartstate("travel", "off", 0);

  if(!apc_rus_damagecancriticalhit(var0)) {
    return;
  }

  var2 = "start_" + var0;
  self setscriptablepartstate("explode", var2, 0);
  thread ref_1328f(var1);
}

function apc_rus_damagecancriticalhit(var0) {
  var1 = 0;

  if(isDefined(var0)) {
    switch (var0) {
      case "doomstation":
      case "revive":
      case "dom":
        var1 = 1;
        break;
      case "attack":
        var1 = 1;
        break;
      case "exfil":
        var1 = 1;
        break;
    }
  }

  return var1;
}

function ref_1328f(var0) {
  self endon("death");
  level endon("game_ended");
  var1 = 12;

  if(isDefined(var0) && var0 > 1) {
    var1 = var0;
  }

  self setscriptablepartstate("phosphorus", "start", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "start", 0);
  wait var1;
  self setscriptablepartstate("phosphorus", "end", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "off", 0);
  wait 5;
  self delete();
}

function ref_12971(var0) {
  var1 = 0;

  if(var0.spawnflags & 4) {
    var1 = 256;
  } else if(var0.spawnflags & 2) {
    var1 = 128;
  } else if(var0.spawnflags & 1) {
    var1 = 168;
  } else if(var0.spawnflags & 16) {
    var1 = 256;
  }

  return var1;
}

function ref_1297c(var0, var1) {
  var2 = getquestdata(var0);
  var2.ref_1408f = getdvarint("scr_br_" + var0 + "_enableQuestTime", var1);
}

function ref_1297d(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = var0 + var1;
  var3 = getquestdata(self.category);

  if(!var3.ref_1408f) {
    return;
  }

  self.ref_11c51 = gettime() + var2 * 1000;
  ref_1297e();
}

function ref_1297b(var0) {
  var1 = getquestdata(self.category);

  if(!var1.ref_1408f) {
    return;
  }

  self.ref_11c51 += var0 * 1000;
  ref_1297e();
}

function questtimersubtract(var0) {
  var1 = getquestdata(self.category);

  if(!var1.ref_1408f) {
    return;
  }

  if(self.ref_11c51 - gettime() - var0 * 1000 <= 0) {
    self.ref_11c51 = gettime() + 1000;
  } else {
    self.ref_11c51 -= var0 * 1000;
  }

  ref_1297e();
}

function ref_1297e() {
  var0 = undefined;

  if(istrue(level.questinfo.ref_132e8) && isDefined(self.team)) {
    var0 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
  } else {
    var0 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.id, self.squadindex);
  }

  foreach(var2 in var0) {
    var2 setclientomnvar("ui_br_objective_countdown_timer", self.ref_11c51);
  }

  var4 = getquestdata(self.category);
  var5 = var4.funcs["onTimerUpdate"];

  if(isDefined(var5)) {
    [[var5]]();
  }

  thread ally_damage_thread();
}

function ally_damage_thread() {
  self notify("updateQuestTimer");
  level endon("game_ended");
  self endon("updateQuestTimer");
  self endon("questEnded");
  var0 = (self.ref_11c51 - gettime()) / 1000;
  wait var0;
  var1 = getquestdata(self.category);
  var2 = var1.funcs["onTimerExpired"];

  if(isDefined(var2)) {
    [[var2]]();
  }

  self.result = "timeout";
  thread removequestinstance();
}

function ref_12b15(var0) {
  if(!isDefined(self.house_enter_animate_and_kill_player)) {
    self.house_enter_animate_and_kill_player = [];
  }

  if(!scripts\engine\utility::array_contains(self.house_enter_animate_and_kill_player, var0)) {
    self.house_enter_animate_and_kill_player[self.house_enter_animate_and_kill_player.size] = var0;
    return;
  }
}

function search_speed(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var4)) {
    var4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex);
  }

  foreach(var7 in var4) {
    if(!isDefined(var7)) {
      continue;
    }

    if(!isDefined(var7.ref_11c4f)) {
      var7.ref_11c4f = 1;
    } else {
      var7.ref_11c4f++;
    }

    var7 scripts\mp\gametypes\br_gametype_dmz::ref_121b6();

    if(getdvarint("OMSQPMNQLS", 0) && var7 scripts\mp\utility\game::onlinestatsenabled()) {
      var7 setplayerdata("mp", "use_quest_complete_history", 0, 1);
    }
  }

  return search_nodes(self.questcategory, self.ref_12d2d, self.modifier, var0, var1, var2, var3, var4, var5);
}

function search_nodes(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = rewardtotype(var0, var1, var2);
  return search_activate_battle_station(var9, var3, var4, var5, var6, var7, var8);
}

function search_activate_battle_station(var0, var1, var2, var3, var4, var5, var6) {
  var7 = [];
  level.intel_active = 0;
  level.playerlocationselectinterrupt = 0;
  var8 = rider_models(var0);

  foreach(var10 in var8) {
    var11 = search_maneuver_think(var14, var10, var1, var2, var3, var4, var5, var6);
    var12 = var11[0];
    var13 = var11[1];
    var11 = undefined;

    if(isDefined(var7[var12])) {
      if(isstring(var7[var12])) {
        var7 = var7[var12] + "," + var13;
      } else {
        var7 = var7[var12] + var13;
      }

      continue;
    }

    var7 = var13;
  }

  level.intel_active = undefined;
  level.playerlocationselectinterrupt = undefined;
  return var7;
}

function search_maneuver_think(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = ringing(var2);
  var9 = right_side_spawn_adjuster(var0);
  var10 = ring(var0);

  if(!isstring(var10)) {
    var11 = rings(var1, var8);

    if(var11 != 1) {
      var10 *= var11;
      var10 = get_vehicle_getin_anim(var9, var10);
    }
  }

  var10 = search_acceleration(var9, var10, var2, var3, var4, var5, var6, var7);
  return [var9, var10];
}

function search_acceleration(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = self.squadindex;

  if(isDefined(var7)) {
    var8 = var7;
  }

  switch (var0) {
    case "plunder":
      if(istrue(level.br_plunder_enabled)) {
        var9 = isDefined(var5) && istrue(var5.ref_121e3);

        if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "gold_war" && !var9) {
          giveteamplunderflat(var2, var1, var8);
        } else if(var6.size > 0) {
          giveteamplunderdistributive(var6, var1);
        } else {
          var1 = 0;
        }
      } else {
        var1 = 0;
      }

      break;
    case "xp":
      if(isDefined(var5) && istrue(var5.ref_121e5)) {
        var10 = var6;
      } else {
        var10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var3, var10);
      }

      foreach(var12 in var10) {
        var12 thread scripts\mp\events::killeventtextpopup("br_missionComplete", 0);
        var12 scripts\mp\rank::giverankxp("br_missionComplete", var2);
        var12.defaultclassindex = scripts\mp\gametypes\br::get_int_or_0(var12.defaultclassindex) + var2;
      }

      break;
    case "weapon_xp":
      if(isDefined(var6) && istrue(var6.ref_121e4)) {
        var10 = var7;
      } else {
        var10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var4, var10);
      }

      foreach(var12 in var10) {
        var15 = var12.lastnormalweaponobj;
        var12 scripts\mp\gametypes\br::scriptableusestate("", var3, var15, 0, 0);
      }

      break;
    case "loot_table":
      if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "gold_war") {
        var17 = pickscriptablelootitem(var7, var3);
        ref_12973(var4, var17, var5, var6, istrue(level.playerlocationselectinterrupt), var10);
      }

      break;
    case "loot_cache":
      var17 = pickscriptablelootitem(var7, var3);
      ref_12973(var4, var17, var5, var6, 1, var10);
      level.playerlocationselectinterrupt = 1;
      break;
    case "loot_items":
      var17 = strtok(var3, " ");
      ref_12973(var4, var17, var5, var6, istrue(level.playerlocationselectinterrupt), var10);
      break;
    case "loot_items_drop":
      var17 = strtok(var3, " ");
      var18 = undefined;

      if(isDefined(var7)) {
        var18 = var7.stadium_three_death_func;
      }

      ref_12973(var4, var17, var5, var6, 1, var10, 0, var18);
      break;
    case "drop_bag":
      var19 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var4, var10)[0];
      fronttruck(var19, var5);
      break;
    case "circle_peek":
      ref_12972(var4, var10);
      break;
    case "reward_tier":
      thread battletracksmusicstatestandingonvehicle(var4, var3, var10);
      break;
    case "blueprint_chance":
      var20 = getdvarint("scr_br_alt_mode_bblitz", 0) == 0;
      var21 = scripts\mp\gametypes\br_extract_quest::usb_keys();

      if(var20 && var21) {
        var22 = scripts\mp\gametypes\br_blueprint_extract_spawn::convoy4_actively_hacking(var5, var7.type);

        if(isDefined(var22)) {
          scripts\mp\gametypes\br_blueprint_extract_spawn::control_station_interact(var4, self.tablet);
          var17 = [var22];
          ref_12973(var4, var17, var5, var6, istrue(level.playerlocationselectinterrupt));
          displayteamsplash(var4, "br_blueprint_extract_quest_spawned", undefined, var10);
        }
      }

      break;
    case "uav":
      var23 = relic_count(var4, var8, var5, var10);

      if(isDefined(var23)) {
        thread ref_12977(var23);
      }

      break;
    case "juggernaut":
      var24 = spawnStruct();
      var24.origin = var5;
      var24.modify_blast_shield_damage = 300;
      var24.ref_11eab = 1;
      level thread scripts\mp\gametypes\br_jugg_common::mlgiconfullflag(var24, "quest_reward");
      break;
    case "killstreak":
      var25 = relic_count(var4, var8, var5, var10);

      if(isDefined(var25)) {
        thread ref_12975(var25);
      }

      break;
    case "quest":
      var12 = relic_count(var4, var8, var5, var10);

      if(isDefined(var12)) {
        thread ref_12976(var12);
      }

      break;
    case "none":
      break;
    default:
      break;
  }

  return var3;
}

function relic_count(var0, var1, var2, var3) {
  if(isDefined(var1) && var1.size > 0) {
    var4 = var1;
  } else {
    var4 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, var4);
  }

  var5 = undefined;
  var6 = undefined;

  foreach(var8 in var4) {
    if(!isDefined(var8)) {
      continue;
    }

    var9 = distance2d(var8.origin, var3);

    if(!isDefined(var6) || var9 < var6) {
      var6 = var9;
      var5 = var8;
    }
  }

  return var5;
}

function ref_13234() {
  if(istrue(level.br_circle_disabled)) {
    return;
  }

  level.gulag_tutorial_vo = [];
  level.ref_13aca = [];

  for(var0 = 1; var0 < level.br_level.br_circleradii.size; var0++) {
    var1 = level.br_level.br_circleradii[var0];
    var2 = level.br_level.default_class_chosen[var0];
    level.gulag_tutorial_vo[var0] = getmaxobjectivecount(var2[0], var2[1], var1);
    level.gulag_tutorial_vo[var0] setmapcirclecolorindex(4);
    level.gulag_tutorial_vo[var0] setmapcirclestyleindex(1);
    level.gulag_tutorial_vo[var0] hide();
  }

  thread gulag_think();
}

function gulag_think() {
  level endon("game_ended");
  level endon("CirclePeekCleanup");

  for(;;) {
    level waittill("br_circle_set");
    level.gulag_tutorial_vo[level.br_circle.circleindex + 1] delete();

    foreach(var1 in getarraykeys(level.ref_13aca)) {
      level.ref_13aca[var1]--;

      if(level.ref_13aca[var1] < 0) {
        level.ref_13aca[var1] = 0;
      }
    }
  }
}

function ref_12972(var0, var1) {
  if(istrue(level.br_circle_disabled)) {
    return;
  }

  if(!isDefined(level.ref_13aca[var0])) {
    level.ref_13aca[var0] = 0;
  }

  level.ref_13aca[var0]++;
  var2 = level.ref_13aca[var0] + level.br_circle.circleindex + 1;

  if(!isDefined(level.gulag_tutorial_vo[var2])) {
    foreach(var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var1)) {
      var4 scripts\mp\utility\lower_message::ref_1316e("circle_peek_limit", undefined, 5);
    }

    return;
  }

  foreach(var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var3, var4)) {
    level.gulag_tutorial_vo[var5] showtoplayer(var4);
  }
}

function riotshield_checkshield(var0) {
  var1 = level.questinfo.ref_12d2f.get_vehicle_idle_anim[var0];

  if(!isDefined(var1)) {
    var1 = tablelookup("mp/brmissions.csv", 1, var0, 7);
    level.questinfo.ref_12d2f.get_vehicle_idle_anim[var0] = var1;
  }

  return var1;
}

function rider_models(var0) {
  var1 = right_control();
  var2 = level.questinfo.ref_12d2f.set_look_at_ent[var0];

  if(!isDefined(var2)) {
    var2 = [];
    var3 = 2;
    var4 = 3;

    for(;;) {
      var5 = tablelookup(var1, 0, var0, var3);

      if(var5 == "") {
        break;
      }

      var6 = tablelookup(var1, 0, var0, var4);
      var2 = var6;
      var3 += 2;
      var4 += 2;
    }

    if(isDefined(level.elevator_lights_toggle)) {
      var2 = [[level.elevator_lights_toggle]](var2);
    }

    level.questinfo.ref_12d2f.set_look_at_ent[var0] = var2;
  }

  return var2;
}

function right_side_spawn_adjuster(var0) {
  var1 = "mp/brmission_rewards.csv";
  var2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var2 == "dmz" || var2 == "rat_race" || var2 == "risk" || var2 == "gold_war") {
    var1 = "mp/brmission_rewards_dmz.csv";
  } else if(level.ref_14060 == 1) {
    var1 = "mp/brmission_rewards_" + var2 + ".csv";
  }

  var3 = level.questinfo.ref_12d2f.ref_12d31[var0];

  if(!isDefined(var3)) {
    var3 = tablelookup(var1, 0, var0, 1);
    level.questinfo.ref_12d2f.ref_12d31[var0] = var3;
  }

  return var3;
}

function ring(var0) {
  var1 = "mp/brmission_rewards.csv";
  var2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var2 == "dmz" || var2 == "rat_race" || var2 == "risk") {
    var1 = "mp/brmission_rewards_dmz.csv";
  }

  if(var2 == "gold_war") {
    var1 = "mp/brmission_rewards_gold_war.csv";
  } else if(level.ref_14060 == 1) {
    var1 = "mp/brmission_rewards_" + var2 + ".csv";
  }

  var3 = level.questinfo.ref_12d2f.ref_12d32[var0];

  if(!isDefined(var3)) {
    var4 = rewardscriptable(var0);

    if(isDefined(var4)) {
      var3 = var4;
    } else {
      var5 = ringcodephoneconstantly();
      var3 = tablelookup(var1, 0, var0, var5);
    }

    var6 = right_side_spawn_adjuster(var0);
    var3 = get_vehicle_getin_anim(var6, var3);
    level.questinfo.ref_12d2f.ref_12d32[var0] = var3;
  }

  if(istrue(level.convoy_handle_stuck_compromise) && !isstring(var3)) {
    var3 = int(var3 * level.ref_12192);
  }

  return var3;
}

function ringcodephoneconstantly() {
  var0 = level.maxteamsize;

  if(scripts\mp\gametypes\br_public::validtousesticker()) {
    var0 = 1;
  }

  switch (var0) {
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

function rewardscriptable(var0) {
  var1 = getdvarint("scr_questReward_" + var0, -1);

  if(var1 > -1) {
    return var1;
  }

  return undefined;
}

function rifle_lights(var0) {
  var1 = level.questinfo.ref_12d2f.ref_12ec4[var0];

  if(!isDefined(var1)) {
    var1 = [];
    var2 = 1;
    var3 = 2;

    for(;;) {
      var4 = tablelookup("mp/brmission_reward_scalers.csv", 0, var0, var2);

      if(var4 == "") {
        break;
      }

      var4 = int(var4);
      var5 = float(tablelookup("mp/brmission_reward_scalers.csv", 0, var0, var3));
      var1 = var5;
      var2 += 2;
      var3 += 2;
    }

    level.questinfo.ref_12d2f.ref_12ec4[var0] = var1;
  }

  return var1;
}

function rewardorigin(var0) {
  return rewardmodifier(self.questcategory, var0, self.modifier, self.ref_12d2d);
}

function riotshieldmodeltag(var0) {
  return riotshieldiscurrentprimary(self.questcategory, var0, self.modifier, self.ref_12d2d);
}

function riotshieldclearvars(var0) {
  return riotshield_return(self.questcategory, var0, self.modifier, self.ref_12d2d);
}

function rewardmodifier(var0, var1, var2, var3) {
  if(!level.br_plunder_enabled) {
    return 0;
  }

  return ringphoneoccasionally(var0, var1, "plunder", var2, var3);
}

function riotshieldiscurrentprimary(var0, var1, var2, var3) {
  return ringphoneoccasionally(var0, var1, "xp", var2, var3);
}

function riotshield_return(var0, var1, var2, var3) {
  return ringphoneoccasionally(var0, var1, "weapon_xp", var2, var3);
}

function ringphoneoccasionally(var0, var1, var2, var3, var4) {
  var5 = rewardtotype(var0, var4, var3);
  var6 = rider_models(var5);
  var7 = 0;

  foreach(var9 in var6) {
    var10 = right_side_spawn_adjuster(var13);

    if(var10 == var2) {
      var11 = ring(var13);
      var12 = rings(var9, var1);
      var7 += var11 * var12;
    }
  }

  var7 = get_vehicle_getin_anim(var2, var7);
  return var7;
}

function rings(var0, var1) {
  var2 = 1;
  var3 = rifle_lights(var0);
  var4 = 0;

  for(var5 = 1; var5 <= var1; var5++) {
    if(isDefined(var3[var5])) {
      var4 = var3[var5];
    }

    var2 += var4;
  }

  if(level.maxteamsize > 4) {
    var2 = 1 + (var2 - 1) * 4 / level.maxteamsize;
  }

  return var2;
}

function rewardangles(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = 0;

  foreach(var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
    if(istrue(var4.should_drop_scavenger_bag)) {
      var2++;
    }
  }

  if(!var1 && isDefined(level.questinfo.ref_11b69) && isDefined(level.questinfo.ref_11b69[var0])) {
    var2 = int(min(var2, level.questinfo.ref_11b69[var0]));
  }

  return var2;
}

function ref_12973(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var1)) {
    return;
  }

  var8 = spawnStruct();
  var8.origin = var2;
  var8.angles = var3;
  var8.itemsdropped = 0;

  if(isDefined(level.intel_active)) {
    var8.itemsdropped = level.intel_active;
  }

  var9 = var8 scripts\mp\gametypes\br_lootcache::ref_11a42(var1, var4, var6, var7, 1);

  foreach(var11 in var9) {
    var11.team = var0;
    var11.squadindex = var5;
  }

  if(isDefined(level.intel_active)) {
    level.intel_active = var8.itemsdropped;
    return;
  }
}

function ref_12977(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var0, self);
  var1.ref_133ce = 1;
  var1.ref_133cc = 1;
  scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct(var1);
}

function ref_12975(var0) {
  var1 = isDefined(self.streakdata.streaks[1]);
  scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var0, var1, 0);
  thread scripts\mp\hud_message::showsplash("br_killstreak_purchased");
}

function ref_12976(var0) {
  var1 = ref_135df(var0, self.origin, 1);
  ref_13a38(var1);
}

function ref_135df(var0, var1, var2) {
  var3 = easepower(removepatchablecollision_delayed(var0), var1);
  tabletinit(var3, var0);
  var3.keepinmap = 1;
  thread handleprop();

  if(istrue(var2)) {
    var3 setscriptablepartstate(var3.type, "hidden");
  }

  return var3;
}

function handleprop() {
  self endon("death");
  self waittill("questEnded");
  self freescriptable();
}

function rewardtotype(var0, var1, var2) {
  var3 = riotshield_checkshield(var0);
  var4 = var3;

  if(isDefined(var2)) {
    var4 += var2;
  }

  if(isDefined(var1)) {
    var4 += var1;
  }

  if(ref_12974(var4)) {
    return var4;
  }

  var4 = var3;

  if(isDefined(var1)) {
    var4 += var1;
  }

  if(ref_12974(var4)) {
    return var4;
  }

  return var3;
}

function ref_12974(var0) {
  var1 = right_control();
  var2 = tablelookup(var1, 0, var0, 0);
  return var2 != "";
}

function rocket_death_fx(var0) {
  switch (var0) {
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

function get_vehicle_getin_anim(var0, var1) {
  var2 = rocket_death_fx(var0);

  switch (var2) {
    case "int":
      var1 = int(var1);
      break;
    case "float":
      var1 = float(var1);
      break;
    case "string":
      var1 = "" + var1;
      break;
    default:
      break;
  }

  return var1;
}

function right_control() {
  var0 = getDvar("br_mission_reward_groups_filename", "mp/brmission_reward_groups.csv");

  if(var0 == "") {
    var0 = "mp/brmission_reward_groups.csv";
  }

  return var0;
}

function rewardtovalue(var0) {
  var1 = right_control();
  return int(tablelookup(var1, 0, var0, 1));
}

function ringing(var0) {
  var1 = level.questinfo.ref_13b62[var0];

  if(!isDefined(var1)) {
    var1 = 1;
  }

  return var1;
}

function ref_131b0(var0, var1, var2) {
  level.questinfo.ref_13b62[var0] = var1;
  ref_131b2(var0, var1, var2);
}

function battletracksmusicstate(var0, var1, var2) {
  ref_131b0(var0, ringing(var0) + var1, var2);
}

function battletracksmusicstatestandingonvehicle(var0, var1, var2, var3) {
  waittillframeend();
  ref_131b0(var0, ringing(var0) + var1, var2);
}

function ref_131af(var0, var1) {
  foreach(var3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, self.squadindex)) {
    ref_131ae(var3, var1);
  }
}

function ref_131ae(var0) {
  self setclientomnvar("ui_br_objective_index", var0);
}

function ref_131b2(var0, var1, var2) {
  foreach(var4 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0, var2)) {
    ref_131b1(var4, var1);
  }
}

function ref_131b1(var0) {
  self setclientomnvar("ui_br_objective_reward_tier", var0);
}

function generate_solution() {
  foreach(var1 in level.questinfo.quests) {
    foreach(var3 in var1.instances) {
      var3.result = "cancel";
      removequestinstance(var3);
    }
  }
}

function register_vehicle_spawners(var0) {
  var1 = [];

  foreach(var3 in level.questinfo.quests) {
    foreach(var5 in var3.instances) {
      if(var7 != var0) {
        continue;
      }

      if(upper_door_coll(var5)) {
        continue;
      }

      var6 = spawnStruct();
      var6.tracknonoobplayerlocation = var5;

      switch (var5.category) {
        case "assassination":
          if(isDefined(var5.targetplayer)) {
            var6.origin = var5.targetplayer.origin;
          }

          break;
        case "domination":
          if(isDefined(var5.ref_1393b) && isDefined(var5.ref_1393b.domflag) && isDefined(var5.ref_1393b.domflag.curorigin)) {
            var6.origin = var5.ref_1393b.domflag.curorigin + (0, 0, 60);
          }

          break;
        case "lep":
        case "scavenger":
          if(isDefined(var5.ref_1393b.force_spawn_all_dead_players.origin) && isDefined(var5.ref_1393b.force_spawn_all_dead_players)) {
            var6.origin = var5.ref_1393b.force_spawn_all_dead_players.origin + (0, 0, 50);
          }

          break;
        case "timedrun":
          break;
        case "launch_code":
        case "geigerstash":
        case "secretstash":
          if(isDefined(var5.force_spawn_all_dead_players) && isDefined(var5.force_spawn_all_dead_players.origin)) {
            var6.origin = var5.force_spawn_all_dead_players.origin + (0, 0, 50);
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
          if(isDefined(var5.ref_1393b) && isDefined(var5.ref_1393b.get_closest_living_player_not_in_laststand) && isDefined(var5.ref_1393b.get_closest_living_player_not_in_laststand.curorigin)) {
            var6.origin = var5.ref_1393b.get_closest_living_player_not_in_laststand.curorigin + (0, 0, 60);
          }

          break;
        default:
          break;
      }

      var1 = var6;
    }
  }

  return var1;
}

function riotshield_init_cp(var0) {
  var1 = level.questinfo.ref_13f19[scripts\engine\utility::string(var0)];

  if(!isDefined(var1)) {
    return 0;
  }

  return var1.ref_13f18;
}

function risk_flagspawndebugobjicons(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = 0;

  foreach(var3 in level.questinfo.ref_13f19) {
    var1 += var3.ref_13f17[var0];
  }

  var5 = randomfloatrange(0, var1);
  var6 = 0;

  foreach(var3 in level.questinfo.ref_13f19) {
    var8 = var3.ref_13f17[var0];

    if(var8 <= 0) {
      continue;
    }

    var6 += var8;

    if(var5 <= var6) {
      return var3.ref_11a23;
    }
  }

  return level.questinfo.ref_13f19[0].ref_11a23;
}

function ref_12c08() {
  if(level.mapname == "mp_don4") {
    var0 = (-31160, 57824, 4536);
    var1 = 1000;
    var2 = getlootspawnpoint(var0, var1, 0, 1);

    foreach(var4 in var2) {
      getlootspawnpointcount(var4.index);
    }

    return;
  }
}
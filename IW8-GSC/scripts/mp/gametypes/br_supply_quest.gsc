/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_supply_quest.gsc
****************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("supply", 1);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("supply", &ref_139A2);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("supply", &ref_1399F);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("supply", &ref_139A0);
  scripts\mp\gametypes\br_quest_util::ref_12B2D("supply", &ref_1399C);
  scripts\mp\gametypes\br_quest_util::ref_12B30("supply", &ref_1399D);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("supply", &ref_1398F);
  game["dialog"]["mission_sup_accept"] = "mission_mission_gen_accept";
  game["dialog"]["mission_sup_dropnotify"] = "mission_mission_scav_accept";
  game["dialog"]["mission_sup_success"] = "contract_misc_success";
  game["dialog"]["mission_sup_fail"] = "mission_mission_gen_fail";
  scripts\mp\gametypes\br_quest_util::ref_1297C("supply", 1);
  scripts\mp\gametypes\br_quest_util::ref_12B31("supply", &ref_1399E);
  totaltrainlootcrates();
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("supply", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var_1.semtex_stuckplayer = self;
  var_1.team = self.team;
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  ref_13999(var_1);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297D(getdvarint("scr_br_supply_questTimeBase", 180), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("supply", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("supply", self, self.team);
  var_2 = spawnStruct();
  var_2.excludedplayers = [];
  var_2.excludedplayers[0] = var_1.semtex_stuckplayer;
  var_2.ogangles = [];
  var_2.ogangles[0] = var_1.team;
  var_2.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("supply", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_1.team, "br_supply_quest_start_team", var_2);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(var_1.semtex_stuckplayer, "br_supply_quest_start_tablet_finder", var_2);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_sup_accept", var_1.team, var_1.semtex_stuckplayer, 1, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_sup_accept", var_1.semtex_stuckplayer, 1, 0.5);
  var_3 = ref_13995(var_1.semtex_stuckplayer);
  thread ref_13993(var_1);
}

function ref_13999() {
  var_0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(scripts\mp\utility\teams::getteamdata(self.team, "players"));

  foreach(var_2 in var_0["valid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("supply");
  }

  foreach(var_2 in var_0["invalid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  }
}

function ref_1399F(var_0, var_1) {
  ref_139A1(var_1, var_0);
}

function ref_139A0(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("supply", self.team).playerlist = var_1;

    if(isDefined(self.crate) && var_1.size) {
      self.crate setotherent(var_1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
    }
  }

  ref_139A1(var_0);
}

function ref_1399C(var_0) {
  ref_13998(var_0);
}

function ref_1399D(var_0) {
  if(var_0.team == self.team) {
    ref_1399A(var_0);
    return;
  }
}

function ref_139A1(var_0, var_1) {}

function ref_1399E() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_sup_fail", self.team, 1, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_supply_quest_timer_expired");
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_139A2() {
  ref_13997();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_1399A(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("supply");
}

function ref_13998(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function ref_13997() {
  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    ref_13998(var_1);
  }
}

function ref_13990() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::getquestindex("supply");
  var_3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("supply"));
  var_4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.semtex_stuckplayer);
  var_0.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_2, var_1, var_3, undefined, var_4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_supply_quest_complete", var_0);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_sup_success", self.team, self.semtex_stuckplayer, 1, 0, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_sup_success", self.semtex_stuckplayer, 1, 0, 0.5);
  self.ref_12D2D = undefined;
  self.ref_12D2E = self.semtex_stuckplayer.origin;
  self.ref_12D2B = self.semtex_stuckplayer.angles;
  self.result = "success";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_1398E() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_sup_fail", self.team, 1, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_supply_quest_circle_failure");
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_13994() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_sup_fail", self.team, 1, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_supply_quest_failure");
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_1398F(var_0, var_1) {
  if(scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
    var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

    if(!isDefined(self.lastcircletick)) {
      self.lastcircletick = -1;
    }

    var_3 = gettime();

    if(self.lastcircletick == var_3) {
      return;
    }

    self.lastcircletick = var_3;

    if(isDefined(self.crate)) {
      var_4 = distance2d(self.crate.origin, var_0);

      if(var_4 > var_2) {
        ref_1398E();
        self.crate setscriptablepartstate("objective_map", "inactive", 0);
        return;
      }

      return;
    }

    return;
  }
}

function ref_13993(var_0) {
  wait getdvarint("scr_br_supply_questTimeDelay", 3);
  var_1 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_0 + (0, 0, 5000), var_0, (0, 0, 0), "supply_c130_loot", "supplydrop_world", 0);
  var_1 setotherent(self.semtex_stuckplayer);
  self.crate = var_1;
  self.crate.trackriotshield_monitorshieldattach = self.id;
  self.crate.cratetype = "supply_c130_loot";
  var_2 = spawnStruct();
  var_2.excludedplayers = [];
  var_2.excludedplayers[0] = self.semtex_stuckplayer;
  var_2.ogangles = [];
  var_2.ogangles[0] = self.team;
  scripts\mp\gametypes\br_quest_util::look_at_heli("br_supply_quest_crate_drop", var_0, getdvarint("scr_br_supply_crate_notify_dist", 10000), level.questinfo.defaultfilter, var_2);
  var_3 = scripts\mp\utility\player::getplayersinradius(var_0, getdvarint("scr_br_supply_crate_notify_dist", 10000));

  foreach(var_5 in var_3) {
    if(var_5 scripts\mp\gametypes\br_public::isplayeringulag()) {
      continue;
    }

    if(var_5.team == self.team) {
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_sup_dropnotify", var_5, 1, 0, 0.5);
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_sup_dropnotify", self.team, 1, 1);
}

function totaltrainlootcrates() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("supply_c130_loot");
  var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var_0.dummymodel = "military_carepackage_02_br";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = getdvarint("scr_br_supply_questTimeBase", 180) + 5 - getdvarint("scr_br_supply_questTimeDelay", 3);
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 2;
  var_0.otherusetime = 2;
  var_0.activatecallback = &scripts\cp_mp\killstreaks\airdrop::dialog_wait_think;
  var_0.capturecallback = &ref_13992;
  var_0.destroycallback = &scripts\cp_mp\killstreaks\airdrop::dialogqueue;
  var_0.ingame = &scripts\cp_mp\killstreaks\airdrop::dialogueindex;
  var_0.destroyoncapture = 1;
}

function ref_13992(var_0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  ref_1399B(var_0);

  if(isDefined(scripts\mp\gametypes\br_quest_util::reviveteam("supply", self.trackriotshield_monitorshieldattach))) {
    var_1 = scripts\mp\gametypes\br_quest_util::reviveteam("supply", self.trackriotshield_monitorshieldattach);

    if(var_0.team == var_1.semtex_stuckplayer.team) {
      ref_13990(var_1);
      return;
    }

    ref_13994(var_1);
    return;
  }
}

function ref_1399B(var_0) {
  self.itemsdropped = 0;

  if(!isDefined(level.deletesmokinggunhud)) {
    level.deletesmokinggunhud = 0;
  } else {
    level.deletesmokinggunhud = (level.deletesmokinggunhud + 1) % 10;
  }

  var_1 = verifybunkercode("contract_supply_crate", level.deletesmokinggunhud);

  if(isDefined(var_1)) {
    var_1 = scripts\mp\gametypes\br_lootcache::ref_11A1A(var_1, var_0);
  }

  if(isDefined(var_1) && var_0 scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
    var_1 = scripts\mp\gametypes\br_lootcache::ref_11A1D(var_1, var_0);
  }

  if(isDefined(var_1)) {
    var_2 = scripts\mp\gametypes\br_lootcache::ref_11A42(var_1, 0);
  }

  if(!isDefined(var_0.ref_11A01)) {
    var_0.ref_11A01 = 1;
  } else {
    var_0.ref_11A01++;
  }

  var_0 scripts\mp\utility\stats::setextrascore1(var_0.ref_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_loot_chopper_box_open");
}

function ref_13996(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_2 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_1, var_2, 0.2, 0.8, 1, 1);
  var_4 = scripts\mp\utility\teams::getenemyplayers(var_0.team, 1);
  var_5 = sortbydistance(var_4, var_0.origin);

  if(var_5.size > 0 && scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
    foreach(var_7 in var_5) {
      var_8 = var_7 scripts\mp\gametypes\br_public::isplayeringulag();
      var_9 = distance2d(var_0.origin, var_7.origin);

      if(isDefined(var_7) && !var_8 && var_9 < getdvarint("scr_br_supply_crate_search_dist_clamp", 23650)) {
        if(distance2d(var_7.origin, var_1) < var_2 && scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
          var_3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_7.origin, clamp(var_2 - distance2d(var_7.origin, var_1), 100, getdvarint("scr_br_supply_crate_clamp_dist", 12000)), 0.1, 0.9, 1, 1);
          return var_3;
        }

        if(scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
          continue;
        }

        var_3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_7.origin, 4000, 0.1, 0.9, 1, 1);
        return var_3;
      }
    }

    if(getdvarint("scr_br_supply_crate_search_dist_clamp", 23650) < var_2 && distance2d(var_0.origin, var_1) > var_2) {
      var_11 = vectortoangles((var_0.origin[0], var_0.origin[1], 0) - (var_1[0], var_1[1], 0));
      var_12 = var_2 - getdvarint("scr_br_supply_crate_clamp_dist", 12000);
      var_13 = scripts\engine\math::vector_project_endpoint(var_1, var_11, var_12);
      var_3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_13, getdvarint("scr_br_supply_crate_clamp_dist", 12000), 0.1, 0.7, 1, 1);
    } else {
      var_11 = vectortoangles((var_3.origin[0], var_3.origin[1], 0) - (var_4[0], var_4[1], 0));
      var_12 = distance2d(var_4, var_3.origin);
      var_13 = scripts\engine\math::vector_project_endpoint(var_4, var_11, var_12 / 2);
      var_6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_13, clamp(var_12 / 2, 100, getdvarint("scr_br_supply_crate_clamp_dist", 12000)), 0.1, 0.8, 1, 1);
    }
  } else if(scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
    var_6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_4, clamp(var_5, 100, getdvarint("scr_br_supply_crate_clamp_dist", 12000)), 0.1, 0.9, 1, 1);
  } else {
    var_6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_3.origin, getdvarint("scr_br_supply_crate_clamp_dist", 12000), 0.1, 0.9, 1, 1);
  }

  return var_6;
}

function ref_13995(var_0) {
  var_1 = ref_13996(var_0);

  if(isDefined(var_1) && istrue(level.ref_14089) && isscriptabledefined()) {
    var_1 = getclosestpointonnavmesh(var_1);
  }

  return var_1;
}
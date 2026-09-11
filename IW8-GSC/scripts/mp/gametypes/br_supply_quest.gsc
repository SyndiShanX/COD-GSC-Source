/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_supply_quest.gsc
****************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("supply", 1);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("supply", &ref_139a2);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("supply", &ref_1399f);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("supply", &ref_139a0);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("supply", &ref_1399c);
  scripts\mp\gametypes\br_quest_util::ref_12b30("supply", &ref_1399d);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("supply", &ref_1398f);
  game["dialog"]["mission_sup_accept"] = "mission_mission_gen_accept";
  game["dialog"]["mission_sup_dropnotify"] = "mission_mission_scav_accept";
  game["dialog"]["mission_sup_success"] = "contract_misc_success";
  game["dialog"]["mission_sup_fail"] = "mission_mission_gen_fail";
  scripts\mp\gametypes\br_quest_util::ref_1297c("supply", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("supply", &ref_1399e);
  totaltrainlootcrates();
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("supply", self.team, var0.index, var0);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var1.semtex_stuckplayer = self;
  var1.team = self.team;
  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  ref_13999(var1);
  var1 scripts\mp\gametypes\br_quest_util::ref_1297d(getdvarint("scr_br_supply_questTimeBase", 180), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("supply", var1);
  scripts\mp\gametypes\br_quest_util::ref_13879("supply", self, self.team);
  var2 = spawnStruct();
  var2.excludedplayers = [];
  var2.excludedplayers[0] = var1.semtex_stuckplayer;
  var2.ogangles = [];
  var2.ogangles[0] = var1.team;
  var2.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("supply", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var1.team, "br_supply_quest_start_team", var2);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(var1.semtex_stuckplayer, "br_supply_quest_start_tablet_finder", var2);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_sup_accept", var1.team, var1.semtex_stuckplayer, 1, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_sup_accept", var1.semtex_stuckplayer, 1, 0.5);
  var3 = ref_13995(var1.semtex_stuckplayer);
  thread ref_13993(var1);
}

function ref_13999() {
  var0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(scripts\mp\utility\teams::getteamdata(self.team, "players"));

  foreach(var2 in var0["valid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("supply");
  }

  foreach(var2 in var0["invalid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  }
}

function ref_1399f(var0, var1) {
  ref_139a1(var1, var0);
}

function ref_139a0(var0) {
  if(var0.team == self.team) {
    var1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("supply", self.team).playerlist = var1;

    if(isDefined(self.crate) && var1.size) {
      self.crate setotherent(var1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
    }
  }

  ref_139a1(var0);
}

function ref_1399c(var0) {
  ref_13998(var0);
}

function ref_1399d(var0) {
  if(var0.team == self.team) {
    ref_1399a(var0);
    return;
  }
}

function ref_139a1(var0, var1) {}

function ref_1399e() {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_sup_fail", self.team, 1, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_supply_quest_timer_expired");
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_139a2() {
  ref_13997();
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_1399a(var0) {
  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("supply");
}

function ref_13998(var0) {
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function ref_13997() {
  foreach(var1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    ref_13998(var1);
  }
}

function ref_13990() {
  var0 = spawnStruct();
  var1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var2 = scripts\mp\gametypes\br_quest_util::getquestindex("supply");
  var3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("supply"));
  var4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.semtex_stuckplayer);
  var0.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var2, var1, var3, undefined, var4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_supply_quest_complete", var0);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_sup_success", self.team, self.semtex_stuckplayer, 1, 0, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_sup_success", self.semtex_stuckplayer, 1, 0, 0.5);
  self.ref_12d2d = undefined;
  self.ref_12d2e = self.semtex_stuckplayer.origin;
  self.ref_12d2b = self.semtex_stuckplayer.angles;
  self.result = "success";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_1398e() {
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

function ref_1398f(var0, var1) {
  if(scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
    var2 = scripts\mp\gametypes\br_circle::getdangercircleradius();

    if(!isDefined(self.lastcircletick)) {
      self.lastcircletick = -1;
    }

    var3 = gettime();

    if(self.lastcircletick == var3) {
      return;
    }

    self.lastcircletick = var3;

    if(isDefined(self.crate)) {
      var4 = distance2d(self.crate.origin, var0);

      if(var4 > var2) {
        ref_1398e();
        self.crate setscriptablepartstate("objective_map", "inactive", 0);
        return;
      }

      return;
    }

    return;
  }
}

function ref_13993(var0) {
  wait getdvarint("scr_br_supply_questTimeDelay", 3);
  var1 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var0 + (0, 0, 5000), var0, (0, 0, 0), "supply_c130_loot", "supplydrop_world", 0);
  var1 setotherent(self.semtex_stuckplayer);
  self.crate = var1;
  self.crate.trackriotshield_monitorshieldattach = self.id;
  self.crate.cratetype = "supply_c130_loot";
  var2 = spawnStruct();
  var2.excludedplayers = [];
  var2.excludedplayers[0] = self.semtex_stuckplayer;
  var2.ogangles = [];
  var2.ogangles[0] = self.team;
  scripts\mp\gametypes\br_quest_util::look_at_heli("br_supply_quest_crate_drop", var0, getdvarint("scr_br_supply_crate_notify_dist", 10000), level.questinfo.defaultfilter, var2);
  var3 = scripts\mp\utility\player::getplayersinradius(var0, getdvarint("scr_br_supply_crate_notify_dist", 10000));

  foreach(var5 in var3) {
    if(var5 scripts\mp\gametypes\br_public::isplayeringulag()) {
      continue;
    }

    if(var5.team == self.team) {
      continue;
    }

    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_sup_dropnotify", var5, 1, 0, 0.5);
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_sup_dropnotify", self.team, 1, 1);
}

function totaltrainlootcrates() {
  var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("supply_c130_loot");
  var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  var0.dummymodel = "military_carepackage_02_br";
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = getdvarint("scr_br_supply_questTimeBase", 180) + 5 - getdvarint("scr_br_supply_questTimeDelay", 3);
  var0.friendlyuseonly = 1;
  var0.ownerusetime = 2;
  var0.otherusetime = 2;
  var0.activatecallback = &scripts\cp_mp\killstreaks\airdrop::dialog_wait_think;
  var0.capturecallback = &ref_13992;
  var0.destroycallback = &scripts\cp_mp\killstreaks\airdrop::dialogqueue;
  var0.ingame = &scripts\cp_mp\killstreaks\airdrop::dialogueindex;
  var0.destroyoncapture = 1;
}

function ref_13992(var0) {
  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  ref_1399b(var0);

  if(isDefined(scripts\mp\gametypes\br_quest_util::reviveteam("supply", self.trackriotshield_monitorshieldattach))) {
    var1 = scripts\mp\gametypes\br_quest_util::reviveteam("supply", self.trackriotshield_monitorshieldattach);

    if(var0.team == var1.semtex_stuckplayer.team) {
      ref_13990(var1);
      return;
    }

    ref_13994(var1);
    return;
  }
}

function ref_1399b(var0) {
  self.itemsdropped = 0;

  if(!isDefined(level.deletesmokinggunhud)) {
    level.deletesmokinggunhud = 0;
  } else {
    level.deletesmokinggunhud = (level.deletesmokinggunhud + 1) % 10;
  }

  var1 = verifybunkercode("contract_supply_crate", level.deletesmokinggunhud);

  if(isDefined(var1)) {
    var1 = scripts\mp\gametypes\br_lootcache::ref_11a1a(var1, var0);
  }

  if(isDefined(var1) && var0 scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
    var1 = scripts\mp\gametypes\br_lootcache::ref_11a1d(var1, var0);
  }

  if(isDefined(var1)) {
    var2 = scripts\mp\gametypes\br_lootcache::ref_11a42(var1, 0);
  }

  if(!isDefined(var0.ref_11a01)) {
    var0.ref_11a01 = 1;
  } else {
    var0.ref_11a01++;
  }

  var0 scripts\mp\utility\stats::setextrascore1(var0.ref_11a01);
  var0 thread scripts\mp\utility\points::giveunifiedpoints("br_loot_chopper_box_open");
}

function ref_13996(var0) {
  var1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var2 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var1, var2, 0.2, 0.8, 1, 1);
  var4 = scripts\mp\utility\teams::getenemyplayers(var0.team, 1);
  var5 = sortbydistance(var4, var0.origin);

  if(var5.size > 0 && scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
    foreach(var7 in var5) {
      var8 = var7 scripts\mp\gametypes\br_public::isplayeringulag();
      var9 = distance2d(var0.origin, var7.origin);

      if(isDefined(var7) && !var8 && var9 < getdvarint("scr_br_supply_crate_search_dist_clamp", 23650)) {
        if(distance2d(var7.origin, var1) < var2 && scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
          var3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var7.origin, clamp(var2 - distance2d(var7.origin, var1), 100, getdvarint("scr_br_supply_crate_clamp_dist", 12000)), 0.1, 0.9, 1, 1);
          return var3;
        }

        if(scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
          continue;
        }

        var3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var7.origin, 4000, 0.1, 0.9, 1, 1);
        return var3;
      }
    }

    if(getdvarint("scr_br_supply_crate_search_dist_clamp", 23650) < var2 && distance2d(var0.origin, var1) > var2) {
      var11 = vectortoangles((var0.origin[0], var0.origin[1], 0) - (var1[0], var1[1], 0));
      var12 = var2 - getdvarint("scr_br_supply_crate_clamp_dist", 12000);
      var13 = scripts\engine\math::vector_project_endpoint(var1, var11, var12);
      var3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var13, getdvarint("scr_br_supply_crate_clamp_dist", 12000), 0.1, 0.7, 1, 1);
    } else {
      var11 = vectortoangles((var3.origin[0], var3.origin[1], 0) - (var4[0], var4[1], 0));
      var12 = distance2d(var4, var3.origin);
      var13 = scripts\engine\math::vector_project_endpoint(var4, var11, var12 / 2);
      var6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var13, clamp(var12 / 2, 100, getdvarint("scr_br_supply_crate_clamp_dist", 12000)), 0.1, 0.8, 1, 1);
    }
  } else if(scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
    var6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var4, clamp(var5, 100, getdvarint("scr_br_supply_crate_clamp_dist", 12000)), 0.1, 0.9, 1, 1);
  } else {
    var6 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var3.origin, getdvarint("scr_br_supply_crate_clamp_dist", 12000), 0.1, 0.9, 1, 1);
  }

  return var6;
}

function ref_13995(var0) {
  var1 = ref_13996(var0);

  if(isDefined(var1) && istrue(level.ref_14089) && isscriptabledefined()) {
    var1 = getclosestpointonnavmesh(var1);
  }

  return var1;
}
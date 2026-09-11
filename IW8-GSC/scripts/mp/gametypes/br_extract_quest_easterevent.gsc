/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_quest_easterevent.gsc
*****************************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("blueprintextract_easterevent", 1);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12b3d("blueprintextract_easterevent", &overtimebuiltintomatchtimer);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("blueprintextract_easterevent", &overridefieldupgrade1);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("blueprintextract_easterevent_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("blueprintextract_easterevent_locale", &outofboundstimebr);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("blueprintextract_easterevent_locale", &outline_ents);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("blueprintextract_easterevent_locale", &outputfunc);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("blueprintextract_easterevent_locale", &outline_grenade_box);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("blueprintextract_easterevent_locale", &outofboundstriggersspawned);
  scripts\mp\gametypes\br_quest_util::ref_12b30("blueprintextract_easterevent_locale", &outofboundswatcher);
  scripts\mp\gametypes\br_quest_util::getquestdata("blueprintextract_easterevent_locale").nextid = 0;
  scripts\mp\gametypes\br_quest_util::ref_1297c("blueprintextract_easterevent", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("blueprintextract_easterevent", &optional_params);

  if(!istrue(level.br_plunder_enabled)) {
    scripts\mp\gametypes\br_plunder::thermite_linktostuck();
    scripts\mp\gametypes\br_plunder::thermite_watchglstuck();
    level._effect["vfx_extract_smoke"] = loadfx("vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker");
    scripts\mp\gametypes\br_plunder::ref_1278e();
    scripts\mp\gametypes\br_plunder::thermite_watchstucktoterrain();
  }

  if(!scripts\mp\gametypes\br_plunder::updateplayerspawninputtype()) {
    scripts\engine\scriptable::scriptable_addusedcallback(&scripts\mp\gametypes\br_plunder::plundersiteused);
  }

  var1 = getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk";
  level.outro_enemy_spawning = scripts\engine\utility::ter_op(var1, "brloot_quest_extract_site_plunder", "brloot_quest_extract_site_br");
  level.outro_dialogue_logic = scripts\engine\utility::ter_op(var1, "brloot_quest_extract_site_model_plunder", "brloot_quest_extract_site_model_br");

  if(!isDefined(level.ref_127c7.data["extractHelipadPlunder"].ref_1287b)) {
    level.ref_127c7.data["extractHelipadPlunder"].ref_1287b = level.ref_127c7.data["extractHelipadPlunder"].ref_14068;
    level.ref_127c7.data["extractHelipadPlunder"].ref_14068 = &originalloc;
  }

  if(!isDefined(level.ref_127c7.data["extractHelipadBR"].ref_1287b)) {
    level.ref_127c7.data["extractHelipadBR"].ref_1287b = level.ref_127c7.data["extractHelipadBR"].ref_14068;
    level.ref_127c7.data["extractHelipadBR"].ref_14068 = &originalloc;
  }

  game["dialog"]["mission_extract_accept"] = "bm_exfil_arrived";
  game["dialog"]["mission_extract_success"] = "contract_misc_success";
}

function originalloc(var0, var1, var2) {
  var1.warningbits = var0.index;
  var1 notify("heliDeposit");

  if(var2 > 0 && istrue(level.br_plunder_enabled) && (getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk")) {
    [[level.ref_127c7.data["extractHelipadPlunder"].ref_1287b]](var0, var1, var2);
    return;
  }
}

function overridefieldupgrade1() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
  scripts\mp\gametypes\br_quest_util::uiobjectivehidefromteam(self.team);
  overwatch_tank_backup(0, undefined);

  if(isDefined(self.get_track_controller_struct)) {
    ref_13f71(self.get_track_controller_struct);
  }

  thread ow_current_scrambler_count();
}

function outputfunc() {
  foreach(var1 in self.subscribedinstances) {
    var1 thread scripts\mp\gametypes\br_quest_util::removequestinstance();
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
  thread ref_12c02();
}

function overtimebuiltintomatchtimer() {
  var0 = rocket_missile(self);
  var1 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("blueprintextract_easterevent", var0);

  if(!isDefined(var1)) {
    return false;
  }

  self.ref_12c4a = var1;
  return true;
}

function outofboundstimebr(var0) {
  scripts\mp\gametypes\br_quest_util::getquestdata("blueprintextract_easterevent_locale").nextid++;
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("blueprintextract_easterevent_locale", "blueprintextract_easterevent", "ExtractPoint:" + scripts\mp\gametypes\br_quest_util::getquestdata("blueprintextract_easterevent_locale").nextid);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var2 = "activeCurrent";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_kstenod" || scripts\cp_mp\utility\game_utility::turretlightsonstate()) {
    var2 = "activeCurrentNight";
  }

  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.soldier_agent_lwfn1 = spawn("script_model", var0.origin);
  var1.soldier_agent_lwfn1 setModel(level.outro_dialogue_logic);
  var3 = var1.playerlist[0];
  var1.soldier_agent_lwfn1 setotherent(var3);
  var1.soldier_agent_lwfn1 setscriptablepartstate(level.outro_enemy_spawning, var2);
  var1.soldier_agent_lwfn1.playermaxheath = 1;
  var1.soldier_agent_lwfn8 = var1.soldier_agent_lwfn1 getlinkedscriptableinstance();
  var1.soldier_agent_lwfn8.audio_shf_kill_hangar_lights = "active";
  var1.soldier_agent_lwfn8.audio_jugg_spawn = "activeCurrent";
  var1.soldier_agent_lwfn8.load_relics_from_playlistdvars = "hidden";
  var1.soldier_agent_lwfn8.little_bird_onexitheavydamagestate = "hidden";
  var1.soldier_agent_lwfn8.ref_1296d = 0;
  var1.soldier_agent_lwfn8.playerplunderbankdepositcallback = 1;
  var1.ref_11985 = var0;
  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_extraction_objective", "current", var0.origin);
  var1.lastcircletick = -1;
  var1.curorigin = var0.origin;
  scripts\mp\gametypes\br_quest_util::addquestinstance("blueprintextract_easterevent_locale", var1);
  return var1;
}

function outofboundstriggersplanetrace(var0) {
  var1 = spawnStruct();
  var1.origin = var0;
  var2 = scripts\mp\gametypes\br_extract_quest::rocket_missile(var1);
  var3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("blueprintextract_easterevent", var2);
  return isDefined(var3);
}

function ref_12c02() {
  if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk") {
    self setscriptablepartstate(level.outro_enemy_spawning, "hidden");
  }

  if(isDefined(self.heli)) {
    self waittill("heli_left");
  }

  self getscriptablelinkedentity() delete();
}

function outline_ents(var0) {}

function outline_grenade_box(var0, var1) {
  if(!isDefined(self.soldier_agent_lwfn1)) {
    return;
  }

  var2 = gettime();

  if(self.lastcircletick == var2) {
    return;
  }

  self.lastcircletick = var2;
  var3 = distance2d(self.curorigin, var0);

  if(var3 > var1) {
    foreach(var5 in self.subscribedinstances) {
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var5.team, "br_blueprint_extract_quest_circle_failure_easterevent");
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", var5.team, 1);
      var5.result = "circle";
    }

    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }
}

function outofboundstriggersspawned(var0) {
  originalsubtype(var0);
}

function outofboundswatcher(var0) {
  if(var0.team == self.subscribedinstances[0].team) {
    overridepointsneeded(var0);
    return;
  }
}

function overwatchent() {
  objective_showtoplayersinmask(self.objectiveiconid);
  objective_removeallfrommask(self.objectiveiconid);

  foreach(var1 in self.subscribedinstances) {
    foreach(var3 in scripts\mp\utility\teams::getteamdata(var1.team, "players")) {
      if(!var3 scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(self.objectiveiconid, var3);
      }
    }
  }
}

function originalsubtype(var0) {
  objective_removeclientfrommask(self.objectiveiconid, var0);
}

function overridepointsneeded(var0) {
  objective_addclienttomask(self.objectiveiconid, var0);
}

function ow_current_scrambler_count() {
  self endon("removed");
  waittillframeend();
  overwatchent();
}

function overwatch_tank_backup(var0, var1) {
  var2 = 0;
  var3 = -1;

  if(var0) {
    var2 = var1 getentitynumber();
    var3 = self.overwatch_soldiers_05_bombers;
  }

  foreach(var5 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var5 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(var2);
    var5 scripts\mp\gametypes\br_quest_util::ref_13efd(var3);
    var6 = isDefined(var1) && var5 == var1;
    var7 = var0 && var6;
    var5 setclientomnvar("ui_br_has_extract_bag", var7);
  }
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::register_vehicle_spawners(self.team);

  if(isDefined(var1) && var1.size > 0) {
    foreach(var3 in var1) {
      var3.tracknonoobplayerlocation scripts\mp\gametypes\br_quest_util::removequestinstance();
    }
  }

  var5 = scripts\mp\gametypes\br_quest_util::createquestinstance("blueprintextract_easterevent", self.team, var0.index, var0);
  var5 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var5.team = self.team;
  var5.tablet = var0;
  var5.overwatch_soldiers_05_bombers = var0.overwatch_soldiers_05_bombers;
  var6 = getdvarint("scr_br_blueprintextract_easterevent_questTime", 240);
  var5 scripts\mp\gametypes\br_quest_util::ref_1297d(var6, 4);
  var7 = rocket_missile(var0);
  var8 = var5 scripts\mp\gametypes\br_quest_util::requestquestlocale("blueprintextract_easterevent_locale", var7, 1);

  if(!var8.enabled) {
    var5.result = "no_locale";
    var5 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    return;
  }

  overwatchent(var8);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("blueprintextract_easterevent", self.team);
  scripts\mp\gametypes\br_quest_util::addquestinstance("blueprintextract_easterevent", var5);
  scripts\mp\gametypes\br_quest_util::ref_13879("blueprintextract_easterevent", self, self.team);

  if(!level.br_plunder_enabled) {
    foreach(var10 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      var10.plundercount = 0;
    }
  }

  var12 = spawnStruct();
  var12.excludedplayers = [];
  var12.excludedplayers[0] = self;
  var12.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("blueprintextract_easterevent", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_blueprint_extract_quest_start_team_easterevent", var12);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_blueprint_extract_quest_start_tablet_finder_easterevent", var12);
  scripts\mp\gametypes\br_quest_util::lookforvehicles(var5.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("blueprintextract_easterevent"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_extract_accept", var5.team, 1);
  ref_1328b(var8, var0.overwatch_soldiers_05_bombers);
  var5.get_track_controller_struct = self;

  foreach(var10 in level.players) {
    if(var10 != self) {
      var8.soldier_agent_lwfn8 disablescriptablepartplayeruse(level.outro_enemy_spawning, var10);
    }
  }

  overwatch_tank_backup(var5, 1, self);
  thread ref_14507(var5);
  thread ref_144b6(var5);
}

function ref_1328b(var0, var1) {
  self.overheatreductiontime = 1;
  self.override_minimap_hide = var0.soldier_agent_lwfn8.index;
  self.override_supply_drop_vfx = "brloot_blueprintextract_tablet";
  self.overridefieldupgrade2 = var1;
}

function ref_13f71() {
  self.overheatreductiontime = undefined;
  self.override_minimap_hide = undefined;
  self.override_supply_drop_vfx = undefined;
  self.overridefieldupgrade2 = undefined;
}

function order_path_data(var0) {
  if(self hasweapon(var0.weapon)) {
    var1 = getcompleteweaponname("iw8_fists_mp");
    var2 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var0.weapon);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0.weapon);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);

    if(var2) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var1);
      return;
    }

    return;
  }
}

function operatorsfxalias(var0) {
  if(!isDefined(self.overridecountdownmusic)) {
    return false;
  }

  return self.overridecountdownmusic == var0;
}

function ref_14508(var0) {
  self endon("removed");

  for(;;) {
    var0 waittill("weapon_change");

    if(isDefined(var0) && !var0 hasweapon(self.weapon)) {
      var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
      var2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, var0.origin, var0.angles, var0);
      var3 = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_blueprintextract_tablet", var2);
      var3.ref_12c4a = self.ref_1393b.ref_11985;
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("br_blueprint_extract_quest_failure", var0.team, 1, 1);
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var0.team, "br_blueprint_extract_quest_failure_easterevent");
      ref_13f71(var0);
      self.result = "fail";
      thread scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }
  }
}

function ref_14507(var0) {
  self endon("removed");
  var1 = var0.team;
  var0 waittill("death_or_disconnect");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("br_blueprint_extract_quest_failure", var1, 1, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var1, "br_blueprint_extract_quest_failure_easterevent");

  if(isDefined(var0)) {
    ref_13f71(var0);
  }

  self.result = "fail";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_144b6(var0) {
  self endon("removed");

  for(;;) {
    var0 waittill("heliDeposit");

    if(var0.warningbits == self.ref_1393b.soldier_agent_lwfn8.index) {
      var1 = "blueprint_unlock_" + self.overwatch_soldiers_05_bombers;
      var2 = scripts\mp\gametypes\br_quest_util::riotshield_init_cp(self.overwatch_soldiers_05_bombers);

      foreach(var4 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
        var4 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4(var1);

        if(var2 > 0) {
          var4 thread scripts\mp\hud_message::showsplash("br_unlockable_weapon_splash", var2);
        }
      }

      self.ref_1393b.soldier_agent_lwfn8.ref_1296d = 1;
      logtrophysuccesful(var0);
      var6 = scripts\mp\gametypes\br_quest_util::getquestindex("blueprintextract_easterevent");
      scripts\mp\gametypes\br_quest_util::lookforvehicles(self.team, var0, 8, var6);
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_extract_success", self.team, 1, 1);
      self.ref_12d2e = self.ref_1393b.soldier_agent_lwfn1.origin;
      self.ref_12d2b = self.ref_1393b.soldier_agent_lwfn1.angles;
      self.result = "success";
      thread scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }
  }
}

function logtrophysuccesful(var0) {
  level endon("game_ended");
  var1 = self.team;
  var2 = spawnStruct();
  var3 = scripts\mp\gametypes\br_quest_util::ringing(var0.team);
  var4 = scripts\mp\gametypes\br_quest_util::getquestindex("blueprintextract_easterevent");
  var5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("blueprintextract_easterevent"));
  var6 = scripts\mp\gametypes\br_quest_util::riotshield_init_cp(self.overwatch_soldiers_05_bombers);
  var2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var4, var3, var5, var6);
  waitframe();
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var1, "br_blueprint_extract_quest_complete_easterevent", var2);
}

function rocket_missile(var0) {
  var1 = spawnStruct();
  var1.ref_12fa3 = "getInactiveHelipads";
  var1.ref_12f9f = (var0.origin[0], var0.origin[1], 0);
  var1.ref_12fa6 = 30000;
  var1.ref_12fa7 = 0;
  var1.ref_12fa4 = getdvarint("scr_br_blueprintextract_idealMaxRange", 20000);
  var1.ref_12fa5 = getdvarint("scr_br_blueprintextract_idealMinRange", 15000);
  var1.ref_12fa1 = 1;
  var1.ref_12c4a = var0.ref_12c4a;
  return var1;
}

function optional_params() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_blueprint_extract_quest_timer_expired_easterevent");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}
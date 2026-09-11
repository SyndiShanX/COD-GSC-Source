/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_quest.gsc
*****************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("blueprintextract", 1);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12b3d("blueprintextract", &overtimebuiltintomatchtimer);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("blueprintextract", &overridefieldupgrade1);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("blueprintextract_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("blueprintextract_locale", &outofboundstimebr);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("blueprintextract_locale", &outline_ents);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("blueprintextract_locale", &outputfunc);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("blueprintextract_locale", &outline_grenade_box);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("blueprintextract_locale", &outofboundstriggersspawned);
  scripts\mp\gametypes\br_quest_util::ref_12b30("blueprintextract_locale", &outofboundswatcher);
  scripts\mp\gametypes\br_quest_util::getquestdata("blueprintextract_locale").nextid = 0;
  scripts\mp\gametypes\br_quest_util::ref_1297c("blueprintextract", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("blueprintextract", &optional_params);

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

  var_1 = getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war";
  level.outro_enemy_spawning = scripts\engine\utility::ter_op(var_1, "brloot_quest_extract_site_plunder", "brloot_quest_extract_site_br");
  level.outro_dialogue_logic = scripts\engine\utility::ter_op(var_1, "brloot_quest_extract_site_model_plunder", "brloot_quest_extract_site_model_br");
  level.ref_127c7.data["extractHelipadPlunder"].ref_1287b = level.ref_127c7.data["extractHelipadPlunder"].ref_14068;
  level.ref_127c7.data["extractHelipadPlunder"].ref_14068 = &originalloc;
  level.ref_127c7.data["extractHelipadBR"].ref_1287b = level.ref_127c7.data["extractHelipadBR"].ref_14068;
  level.ref_127c7.data["extractHelipadBR"].ref_14068 = &originalloc;
  level.overrideviewkickscalek98 = getdvarint("scr_br_extract_max_search_radius", 30000);
  game["dialog"]["mission_extract_accept"] = "bm_exfil_arrived";
  game["dialog"]["mission_extract_success"] = "contract_misc_success";
}

function usb_keys() {
  return scripts\mp\gametypes\br_quest_util::upload_station_players_manager("blueprintextract", 1);
}

function originalloc(var_0, var_1, var_2) {
  var_1.warningbits = var_0.index;
  var_1 notify("heliDeposit");

  if(var_2 > 0 && istrue(level.br_plunder_enabled) && (getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war")) {
    [[level.ref_127c7.data["extractHelipadPlunder"].ref_1287b]](var_0, var_1, var_2);
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
  foreach(var_1 in self.subscribedinstances) {
    var_1 thread scripts\mp\gametypes\br_quest_util::removequestinstance();
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
  thread ref_12c02();
}

function overtimebuiltintomatchtimer() {
  var_0 = rocket_missile(self);
  var_1 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("blueprintextract", var_0);

  if(!isDefined(var_1)) {
    return false;
  }

  self.ref_12c4a = var_1;
  return true;
}

function outofboundstimebr(var_0) {
  scripts\mp\gametypes\br_quest_util::getquestdata("blueprintextract_locale").nextid++;
  var_1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("blueprintextract_locale", "blueprintextract", "ExtractPoint:" + scripts\mp\gametypes\br_quest_util::getquestdata("blueprintextract_locale").nextid);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_2 = "activeCurrent";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_kstenod" || scripts\cp_mp\utility\game_utility::turretlightsonstate()) {
    var_2 = "activeCurrentNight";
  }

  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1.soldier_agent_lwfn1 = spawn("script_model", var_0.origin);
  var_1.soldier_agent_lwfn1 setModel(level.outro_dialogue_logic);
  var_3 = var_1.playerlist[0];
  var_1.soldier_agent_lwfn1 setotherent(var_3);
  var_1.soldier_agent_lwfn1 setscriptablepartstate(level.outro_enemy_spawning, var_2);
  var_1.soldier_agent_lwfn1.playermaxheath = 1;
  var_1.soldier_agent_lwfn8 = var_1.soldier_agent_lwfn1 getlinkedscriptableinstance();
  var_1.soldier_agent_lwfn8.audio_shf_kill_hangar_lights = "active";
  var_1.soldier_agent_lwfn8.audio_jugg_spawn = "activeCurrent";
  var_1.soldier_agent_lwfn8.load_relics_from_playlistdvars = "hidden";
  var_1.soldier_agent_lwfn8.little_bird_onexitheavydamagestate = "hidden";
  var_1.soldier_agent_lwfn8.ref_1296d = 0;
  var_1.soldier_agent_lwfn8.playerplunderbankdepositcallback = 1;
  var_1.ref_11985 = var_0;
  var_1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_extraction_objective", "current", var_0.origin);
  var_1.lastcircletick = -1;
  var_1.curorigin = var_0.origin;
  scripts\mp\gametypes\br_quest_util::addquestinstance("blueprintextract_locale", var_1);
  return var_1;
}

function outofboundstriggersplanetrace(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_2 = rocket_missile(var_1);
  var_3 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("blueprintextract", var_2);
  return isDefined(var_3);
}

function ref_12c02() {
  if(getDvar("scr_br_gametype", "") != "dmz" && getDvar("scr_br_gametype", "") != "rat_race" && getDvar("scr_br_gametype", "") != "risk" && getDvar("scr_br_gametype", "") != "gold_war") {
    self setscriptablepartstate(level.outro_enemy_spawning, "hidden");
  }

  if(isDefined(self.heli)) {
    self waittill("heli_left");
  }

  self getscriptablelinkedentity() delete();
}

function outline_ents(var_0) {}

function outline_grenade_box(var_0, var_1) {
  if(!isDefined(self.soldier_agent_lwfn1)) {
    return;
  }

  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }

  self.lastcircletick = var_2;
  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var_5.team, "br_blueprint_extract_quest_circle_failure");
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", var_5.team, 1);
      var_5.result = "circle";
    }

    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }
}

function outofboundstriggersspawned(var_0) {
  originalsubtype(var_0);
}

function outofboundswatcher(var_0) {
  if(var_0.team == self.subscribedinstances[0].team) {
    overridepointsneeded(var_0);
    return;
  }
}

function overwatchent() {
  objective_showtoplayersinmask(self.objectiveiconid);
  objective_removeallfrommask(self.objectiveiconid);

  foreach(var_1 in self.subscribedinstances) {
    foreach(var_3 in scripts\mp\utility\teams::getteamdata(var_1.team, "players")) {
      if(!var_3 scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(self.objectiveiconid, var_3);
      }
    }
  }
}

function originalsubtype(var_0) {
  objective_removeclientfrommask(self.objectiveiconid, var_0);
}

function overridepointsneeded(var_0) {
  objective_addclienttomask(self.objectiveiconid, var_0);
}

function ow_current_scrambler_count() {
  self endon("removed");
  waittillframeend();
  overwatchent();
}

function overwatch_tank_backup(var_0, var_1) {
  var_2 = 0;
  var_3 = -1;

  if(var_0) {
    var_2 = var_1 getentitynumber();
    var_3 = self.overwatch_soldiers_05_bombers;
  }

  foreach(var_5 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var_5 scripts\mp\gametypes\br_quest_util::uiobjectivesetparameter(var_2);
    var_5 scripts\mp\gametypes\br_quest_util::ref_13efd(var_3);
    var_6 = isDefined(var_1) && var_5 == var_1;
    var_7 = var_0 && var_6;
    var_5 setclientomnvar("ui_br_has_extract_bag", var_7);
  }
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::register_vehicle_spawners(self.team);

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1) {
      var_3.tracknonoobplayerlocation scripts\mp\gametypes\br_quest_util::removequestinstance();
    }
  }

  var_5 = scripts\mp\gametypes\br_quest_util::createquestinstance("blueprintextract", self.team, var_0.index, var_0);
  var_5.team = self.team;
  var_5.tablet = var_0;
  var_5.overwatch_soldiers_05_bombers = var_0.overwatch_soldiers_05_bombers;
  var_5 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_6 = getdvarint("scr_br_blueprintextract_questTime", 240);
  var_5 scripts\mp\gametypes\br_quest_util::ref_1297d(var_6, 4);
  var_7 = rocket_missile(var_0);
  var_8 = var_5 scripts\mp\gametypes\br_quest_util::requestquestlocale("blueprintextract_locale", var_7, 1);

  if(!var_8.enabled) {
    var_5.result = "no_locale";
    var_5 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    return;
  }

  overwatchent(var_8);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("blueprintextract", self.team);
  scripts\mp\gametypes\br_quest_util::addquestinstance("blueprintextract", var_5);
  scripts\mp\gametypes\br_quest_util::ref_13879("blueprintextract", self, self.team);

  if(!level.br_plunder_enabled) {
    foreach(var_10 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      var_10.plundercount = 0;
    }
  }

  var_12 = spawnStruct();
  var_12.excludedplayers = [];
  var_12.excludedplayers[0] = self;
  var_12.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("blueprintextract", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_blueprint_extract_quest_start_team", var_12);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_blueprint_extract_quest_start_tablet_finder", var_12);
  scripts\mp\gametypes\br_quest_util::lookforvehicles(var_5.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("blueprintextract"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_extract_accept", var_5.team, 1);
  ref_1328b(var_8, var_0.overwatch_soldiers_05_bombers);
  var_5.get_track_controller_struct = self;

  foreach(var_10 in level.players) {
    if(var_10 != self) {
      var_8.soldier_agent_lwfn8 disablescriptablepartplayeruse(level.outro_enemy_spawning, var_10);
    }
  }

  overwatch_tank_backup(var_5, 1, self);
  thread ref_14507(var_5);
  thread ref_144b6(var_5);
}

function ref_1328b(var_0, var_1) {
  self.overheatreductiontime = 1;
  self.override_minimap_hide = var_0.soldier_agent_lwfn8.index;
  self.override_supply_drop_vfx = "brloot_blueprintextract_tablet";
  self.overridefieldupgrade2 = var_1;
}

function ref_13f71() {
  self.overheatreductiontime = undefined;
  self.override_minimap_hide = undefined;
  self.override_supply_drop_vfx = undefined;
  self.overridefieldupgrade2 = undefined;
}

function order_path_data(var_0) {
  if(self hasweapon(var_0.weapon)) {
    var_1 = getcompleteweaponname("iw8_fists_mp");
    var_2 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0.weapon);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0.weapon);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);

    if(var_2) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1);
      return;
    }

    return;
  }
}

function operatorsfxalias(var_0) {
  if(!isDefined(self.overridecountdownmusic)) {
    return false;
  }

  return self.overridecountdownmusic == var_0;
}

function ref_14508(var_0) {
  self endon("removed");

  for(;;) {
    var_0 waittill("weapon_change");

    if(isDefined(var_0) && !var_0 hasweapon(self.weapon)) {
      var_1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
      var_2 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, var_0.origin, var_0.angles, var_0);
      var_3 = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_blueprintextract_tablet", var_2);
      var_3.ref_12c4a = self.ref_1393b.ref_11985;
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("br_blueprint_extract_quest_failure", var_0.team, 1, 1);
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var_0.team, "br_blueprint_extract_quest_failure");
      ref_13f71(var_0);
      self.result = "fail";
      thread scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }
  }
}

function ref_14507(var_0) {
  self endon("removed");
  var_1 = var_0.team;
  var_0 waittill("death_or_disconnect");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("br_blueprint_extract_quest_failure", var_1, 1, 1);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_1, "br_blueprint_extract_quest_failure");

  if(isDefined(var_0)) {
    ref_13f71(var_0);
  }

  self.result = "fail";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_144b6(var_0) {
  self endon("removed");

  for(;;) {
    var_0 waittill("heliDeposit");

    if(var_0.warningbits == self.ref_1393b.soldier_agent_lwfn8.index) {
      var_1 = "blueprint_unlock_" + self.overwatch_soldiers_05_bombers;
      var_2 = scripts\mp\gametypes\br_quest_util::riotshield_init_cp(self.overwatch_soldiers_05_bombers);

      foreach(var_4 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
        var_4 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4(var_1);

        if(var_2 > 0) {
          var_4 thread scripts\mp\hud_message::showsplash("br_unlockable_weapon_splash", var_2);
        }
      }

      self.ref_1393b.soldier_agent_lwfn8.ref_1296d = 1;
      logtrophysuccesful(var_0);
      var_6 = scripts\mp\gametypes\br_quest_util::getquestindex("blueprintextract");
      scripts\mp\gametypes\br_quest_util::lookforvehicles(self.team, var_0, 8, var_6);
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_extract_success", self.team, 1, 1);
      self.ref_12d2e = self.ref_1393b.soldier_agent_lwfn1.origin;
      self.ref_12d2b = self.ref_1393b.soldier_agent_lwfn1.angles;
      self.result = "success";
      thread scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }
  }
}

function logtrophysuccesful(var_0) {
  level endon("game_ended");
  var_1 = self.team;
  var_2 = spawnStruct();
  var_3 = scripts\mp\gametypes\br_quest_util::ringing(var_0.team);
  var_4 = scripts\mp\gametypes\br_quest_util::getquestindex("blueprintextract");
  var_5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("blueprintextract"));
  var_6 = scripts\mp\gametypes\br_quest_util::riotshield_init_cp(self.overwatch_soldiers_05_bombers);
  var_2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var_4, var_3, var_5, var_6);
  waitframe();
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_1, "br_blueprint_extract_quest_complete", var_2);
}

function rocket_missile(var_0) {
  var_1 = spawnStruct();
  var_1.ref_12fa3 = "getInactiveHelipads";
  var_1.ref_12f9f = (var_0.origin[0], var_0.origin[1], 0);
  var_1.ref_12fa6 = level.overrideviewkickscalek98;
  var_1.ref_12fa7 = 0;
  var_1.ref_12fa4 = getdvarint("scr_br_blueprintextract_idealMaxRange", 20000);
  var_1.ref_12fa5 = getdvarint("scr_br_blueprintextract_idealMinRange", 15000);
  var_1.ref_12fa1 = 1;

  if(getdvarint("scr_br_alt_mode_bblitz", 0)) {
    var_1.ref_12fa1 = 0;
    var_1.ref_12fa6 = 200000;
    var_1.ref_13d09 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_and_give_killstreak_loadout_support();
    var_1.mintime = scripts\mp\gametypes\br_alt_mode_bblitz::clear_and_give_killstreak_loadout_recon();
  }

  var_1.ref_12c4a = var_0.ref_12c4a;
  return var_1;
}

function optional_params() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_blueprint_extract_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}
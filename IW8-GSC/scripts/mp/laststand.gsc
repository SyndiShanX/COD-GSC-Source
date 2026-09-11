/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\laststand.gsc
***********************************************/

function init() {
  scripts\mp\playeractions::registeractionset("laststand", ["usability", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_primary_weapons", "offhand_secondary_weapons", "offhand_weapons"]);
  scripts\mp\playeractions::registeractionset("laststand_killstreak", ["usability", "weapon_switch", "gesture", "killstreaks", "supers", "fire", "melee", "offhand_primary_weapons", "offhand_secondary_weapons"]);
  scripts\mp\playeractions::registeractionset("laststand_revive", ["allow_movement", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee"]);
  level.laststandreviveents = [];

  if(isusingmatchrulesdata()) {} else {
    scripts\mp\utility\game::registerlaststandhealthdvar(50);
    scripts\mp\utility\game::registerlaststandrevivehealthdvar(30);
    scripts\mp\utility\game::registerlaststandtimerdvar(10);
    scripts\mp\utility\game::registerlaststandinvulntimerdvar(1);
    scripts\mp\utility\game::registerlaststandsuicidetimerdvar(5);
    scripts\mp\utility\game::registerlaststandrevivetimerdvar(10);
    scripts\mp\utility\game::registerlaststandweapondvar("iw8_fists_mp_ls");
    scripts\mp\utility\game::registerlaststandrevivedecayscaledvar(0);
    scripts\mp\utility\game::registerlaststandweapondelaydvar(0);
  }

  level.laststandhealth = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandHealth", "scr_player_lastStandHealth");
  level.laststandrevivehealth = scripts\mp\utility\dvars::respawn_players_into_plane("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandReviveHealth", "scr_player_lastStandReviveHealth");

  if(level.laststandhealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth")) {
    level.laststandhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  }

  if(level.laststandrevivehealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth")) {
    level.laststandrevivehealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  }

  level.laststandinvulntime = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandInvulnTime", "scr_player_lastStandInvulnTime");
  level.watch_for_next_sniper = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandReviveDecayScale", "scr_player_lastStandReviveDecayScale");
  level.laststandrevivetimer = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandReviveTimer", "scr_player_lastStandReviveTimer");
  level.laststandsuicidetimer = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandSuicideTimer", "scr_player_lastStandSuicideTimer");
  level.laststandtimer = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandTimer", "scr_player_lastStandTimer");
  level.watch_for_payload_approach_cache_1 = scripts\mp\utility\dvars::respawn_index("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandWeapon", "scr_player_lastStandWeapon");
  level.watch_for_player_death = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_lastStandWeaponDelay", "scr_player_lastStandWeaponDelay");
  setdvarifuninitialized("scr_player_lastStandAllyDragEnable", 0);
  setdvarifuninitialized("scr_player_lastStandAllyDragMoveSpeed", 0.3);
  thread laststandmonitor();
}

function laststandthink() {
  level endon("game_ended");
  onenter();
  var_0 = scripts\engine\utility::ref_143b8("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death", "disconnect", "last_stand_self_revive");

  switch (var_0) {
    case "last_stand_revived":
      onrevive();
      break;
    case "last_stand_self_revive":
      onrevive(1);
      break;
    case "last_stand_bleedout":
      onbleedout();
      break;
    case "last_stand_heal_success":
      onrevive(0, 1);
      break;
    case "death":
      if(!((scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::getgametype() == "br") && scripts\mp\flags::gameflag("prematch_done"))) {
        ondeath();
      }

      break;
    case "disconnect":
      ondeath();
      break;
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_is_laststand", 0);
    return;
  }
}

function onenter() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("last_stand_finished");
  self notify("last_stand_start");
  self setclientomnvar("ui_is_laststand", 1);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_last_stand", undefined, 0.25);
  var_0 = level.laststandhealth;

  if(level.gametype == "br") {
    thread waittill_near_goal();
  }

  self.health = var_0;
  thread makelaststandinvuln();
  scripts\mp\utility\perk::giveperk("specialty_block_health_regen");
  scripts\mp\utility\perk::giveperk("specialty_blindeye");
  self.inlaststand = 1;
  self.ref_125b9 = undefined;
  self.hasshownlaststandicon = 0;

  if(isDefined(level.playerdatafield) && [[level.playerdatafield]]()) {
    if(isDefined(level.playercleanupinfilondisconnect)) {
      self[[level.playercleanupinfilondisconnect]](1);
    }
  }

  if(level.gametype == "br" && !istrue(self.shouldgetnewspawnpoint)) {
    if(isDefined(level.getinfectedairdropposition)) {
      [[level.getinfectedairdropposition]]();
    }
  }

  self.laststandoldweaponobj = scripts\mp\utility\inventory::getlastweapon();

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\common\utility::allow_weapon_switch_clip(0);

    if(!istrue(self.gulag)) {
      self.watch_for_driver_death = gettime();
      self.get_tv_station_infil_rider_start_targetname = undefined;
      scripts\mp\gametypes\br_public::runbrgametypefuncwrapper("onLastStandEnter");

      if(!istrue(level.ref_133d8)) {
        var_1 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(self.team, self.squadindex);

        foreach(var_3 in var_1) {
          if(!isDefined(var_3)) {
            continue;
          }

          if(var_3 != self) {
            var_3 thread scripts\mp\hud_message::showsplash("br_teammate_down", undefined, self);
          }
        }
      }
    }
  }

  var_5 = self getheldoffhand();

  if(!nullweapon(var_5)) {
    var_6 = scripts\mp\equipment::getequipmentreffromweapon(var_5);

    if(isDefined(var_6) && scripts\mp\equipment::hasequipment(var_6)) {
      var_7 = scripts\mp\equipment::findequipmentslot(var_6);

      if(var_7 == "primary" || var_7 == "secondary") {
        thread scripts\mp\equipment\gas_grenade::gas_takeheldoffhand();
      }
    }
  }

  var_8 = level.watch_for_payload_approach_cache_1;

  if(isDefined(level.laststandweaponcallback) && getdvarint("scr_player_enableSecondWindAndPistol", 0)) {
    var_8 = self[[level.laststandweaponcallback]]();
  }

  if(!issameweapon(var_8)) {
    var_8 = getcompleteweaponname(var_8);
  }

  if(!istrue(self.usingascender)) {
    self stopanimscriptsceneevent();
  }

  if(self isviewmodelanimplaying()) {
    self stopviewmodelanim();
  }

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func)) {
    self[[level.killstreak_laststand_func]]();
    return;
  }

  if(isDefined(level.modeonlaststandfunc)) {
    self[[level.modeonlaststandfunc]]();
  }

  if(isDefined(level.weaponfixup)) {
    self thread[[level.weaponfixup]]();
  }

  if(isDefined(level.customlaststandactionset)) {
    self.laststandactionset = level.customlaststandactionset;
  } else {
    self.laststandactionset = "laststand";
  }

  if(isDefined(self.vehicle)) {
    self waittill("vehicle_exit");
  }

  scripts\mp\playeractions::allowactionset(self.laststandactionset, 0);
  thread setup_volumes(var_8);

  if(isDefined(level.battle_tracks_stopbattletrackstoalloccupants)) {
    self[[level.battle_tracks_stopbattletrackstoalloccupants]]();
  } else {
    addoverheadicon();
  }

  var_9 = level.laststandsuicidetimer;
  scripts\cp_mp\utility\shellshock_utility::_shellshock("last_stand_mp", "damage", var_9, 0);
  thread revivesetup(self);
  self.fastcrouchspeedmod = getdvarfloat("scr_player_lastStandSpeedAddition", 0);
  scripts\cp\vehicles\vehicle_compass_cp::ref_138d5("alive_not_downed");

  if(isDefined(self.watch_for_attack) && self.watch_for_attack scripts\mp\utility\perk::_hasperk("specialty_reduce_regen_delay_on_kill")) {
    self.watch_for_attack scripts\mp\perks\perkfunctions::regendelayreduce_onkill();
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    GscBinSkip4(0x35, var_9);
  }

  if(isDefined(self.pers["squadMemberIndex"])) {
    var_10 = "outline_nodepth_brplayer" + self.pers["squadMemberIndex"];
    self.watch_for_molotov_ambush_and_spawners = scripts\mp\utility\outline::outlineenableforteam(self, self.team, var_10, "laststand");
  }

  GscBinSkip4(0x35);
}

function waittill_near_goal() {
  if(!istrue(self.islaststandbleedoutdmg) && !istrue(self.littlebirdsmg)) {
    self.islaststandbleedoutdmg = 1;
    self stoplocalsound("deaths_door_out");
    self playlocalsound("deaths_door_in");
    self setsoundsubmix("deaths_door_mp", 0.2, 1);
    self enableplayerbreathsystem(0);
    thread scripts\mp\healthoverlay::playerbreathingpainsound();
    return;
  }
}

function setup_volumes(var_0) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && (self.currentweapon.basename == "armor_plate_deploy_mp" || self.currentweapon.basename == rpggetclosetoapc())) {
    waitframe();
  }

  waitframe();
  var_1 = getcompleteweaponname("iw8_gunless_last_stand_enter");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 0);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  wait 1.7;
  self notify("last_stand_transition_done");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);

  if(!issameweapon(var_0) && (var_0 == "none" || var_0 == "iw8_fists_mp_ls")) {
    givedefaultlaststandweapon();
    return;
  }

  var_2 = level.watch_for_player_death;

  if(var_2 > 0) {
    thread handlelaststandweapongivedelay(var_2, var_0);
    return;
  }

  givelaststandweapon(var_0);
}

function ref_13a34() {
  var_0 = self;
  var_1 = getcompleteweaponname("iw8_gunless_last_stand_enter");

  if(var_0 hasweapon(var_1)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    return;
  }
}

function handlelaststandweapongivedelay(var_0, var_1) {
  self endon("death");
  self endon("last_stand_revived");
  level endon("game_ended");
  var_2 = givedefaultlaststandweapon();

  if(isnullweapon(var_2, var_1)) {
    return;
  }

  wait var_0;
  self notify("end_switchToFists");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
  givelaststandweapon(var_1);
}

function givedefaultlaststandweapon() {
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("lastStandWeapon");

  if(!isDefined(var_0)) {
    var_0 = "iw8_fists_mp_ls";
  }

  var_1 = getcompleteweaponname(var_0);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  return var_1;
}

function givelaststandweapon(var_0) {
  if(!issameweapon(var_0)) {
    var_0 = scripts\mp\class::buildweapon(var_0);
  }

  var_1 = createheadicon(var_0);

  if(!self hasweapon(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  }

  thread scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
}

function disableweaponsovertime(var_0) {
  level endon("game_ended");
  scripts\common\utility::allow_weapon(0);
  scripts\engine\utility::ref_143b9(var_0, "death_or_disconnect");
  scripts\common\utility::allow_weapon(1);
}

function switchtofists(var_0) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1) == 0) {
    waitframe();
  }
}

function dodamagewhiledown() {
  self endon("laststand_revived");
  self endon("disconnect");
  self endon("squad_wipe_death");
  var_0 = level.laststandhealth;
  var_1 = level.laststandtimer;

  if(var_1 <= 0) {
    onbleedout();
    return;
  }

  var_2 = float(var_0) / float(var_1);

  if(getdvarfloat("scr_player_lastStandHealthScalar", 0) > 0) {
    var_2 *= getdvarfloat("scr_player_lastStandHealthScalar", 0);
  }

  wait 1;
  var_3 = getcompleteweaponname("iw8_gunless");

  if(!istrue(level.watch_for_objective_failed)) {
    thread suicidesetup();
  }

  var_4 = 0;

  while(self.health > 0) {
    if(self isinexecutionvictim()) {
      wait 1;
      continue;
    }

    if(!istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      var_5 = int(var_4 + var_2) - int(var_4);
      var_4 += var_2;
      self.update_bomb_interaction_ent = 1;
      self dodamage(var_5, self.origin, self, undefined, "MOD_TRIGGER_HURT", var_3, "none");
      self.update_bomb_interaction_ent = undefined;
    }

    if(self.health <= 0) {
      onbleedout();
    }

    wait 1;
  }
}

function stucktime(var_0) {
  self.stuckinlaststand = 1;
  wait var_0;
  self.stuckinlaststand = 0;

  if(scripts\mp\utility\perk::_hasperk("specialty_survivor") && getdvarint("scr_player_lastStand") != 1) {
    var_1 = level.laststandtimer;
  } else {
    var_1 = level.laststandtimer;
  }

  if(!isDefined(var_1)) {
    var_1 = level.laststandtimer;
  }

  if(scripts\mp\utility\game::getgametype() == "br") {}

  if(scripts\mp\utility\game::getgametype() != "br") {
    var_1 = max(var_1 - level.laststandsuicidetimer, 1);
  }

  self.timeuntilbleedout = var_1;
  thread bleedoutthink();
  thread suicidesetup();
}

function ref_13012(var_0) {
  if(var_0 usinggamepad()) {
    return var_0 allowspectateallteams();
  }

  return var_0 setmainstreamloaddist();
}

function ref_13014() {
  var_0 = self;
  var_1 = var_0.owner;
  level endon("game_ended");
  var_0 endon("death");
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_revived");
  var_2 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;

  if(scripts\mp\utility\game::getgametype() == "br" && var_1 scripts\mp\utility\perk::_hasperk("specialty_br_faster_revive")) {
    var_2 *= 0.75;
  }

  var_0.usetime = var_2;

  if(!isDefined(self.curprogress)) {
    self.curprogress = 0;
  }

  for(;;) {
    if(ref_13012(var_1) && !istrue(var_1.usedprops) && var_1 isonground()) {
      var_0 notify("self_revive_start");
      var_1 setlaststandenabled(1);
      thread ref_13013();
    }

    waitframe();
  }
}

function ref_13013() {
  var_0 = self.owner;
  var_1 = self;
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_finished");
  var_1.ref_1438a = 0;
  thread ref_13011();

  while(scripts\mp\utility\player::isreallyalive(var_0) && ref_13012(var_0) && var_1.curprogress < var_1.usetime) {
    while(!var_0 isonground() && ref_13012(var_0) && !istrue(var_0.usedprops)) {
      waitframe();
    }

    if(var_0 isinexecutionvictim()) {
      break;
    }

    if(!istrue(var_0.usedprops)) {
      var_0 thread scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_self_revive", 10);

      if(!istrue(var_0.ref_138ad)) {
        var_0 attach("wm_equip_gen_stim_motau_ch3", "tag_accessory_left");
        var_0.ref_138ad = 1;
      }

      var_0.usedprops = 1;
      var_0 allowmovement(0);
    }

    if(!isDefined(var_1.userate)) {
      var_1.userate = 0;
    }

    if(istrue(var_0.beingrevived)) {
      var_0 setclientomnvar("ui_securing", 6);
      break;
    }

    if(!var_0 isonground()) {
      break;
    }

    var_1.curprogress += level.frameduration * var_1.userate;
    var_1.userate = 1;
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1);

    if(var_1.curprogress >= var_1.usetime) {
      var_0 stopgestureviewmodel("ges_equip_stim_self_revive");
      wait 0.5;

      if(scripts\mp\utility\game::getgametype() == "br") {
        scripts\mp\gametypes\br_analytics::dialog_grenade_missed(var_0);
      }

      playanim_aibegindismountturret(var_0, "self_revive_success", var_0);

      if(isDefined(level.ref_12c1f)) {
        var_0[[level.ref_12c1f]]();
      }

      return;
    }

    waitframe();
  }

  LOC_000001a3:
    if(!istrue(var_0.beingrevived)) {
      scripts\mp\gametypes\br::ref_1401f(var_0, var_0, var_1.curprogress, 1);
      thread decayreviveprogress();
    }

  var_0 notify("stopped_self_revive");
}

function ref_13011() {
  var_0 = self.owner;
  var_1 = self;
  level endon("game_ended");
  var_0 notify("self_revive_cleanup_start");
  var_0 endon("self_revive_cleanup_start");
  var_0 scripts\engine\utility::ref_143b5("last_stand_finished", "stopped_self_revive", "death_or_disconnect");

  if(!istrue(var_0.beingrevived)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  }

  var_0 allowmovement(1);

  if(istrue(var_0.ref_138ad)) {
    var_0 detach("wm_equip_gen_stim_motau_ch3", "tag_accessory_left");
    var_0.ref_138ad = 0;
  }

  var_0 stopgestureviewmodel("ges_equip_stim_self_revive");
  var_0 setlaststandenabled(0);
  var_0.usedprops = 0;
}

function onexitcommon(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self.laststandactionset = undefined;
  thread clearlaststandinvuln();
  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(scripts\mp\utility\perk::_hasperk("specialty_block_health_regen")) {
    scripts\mp\utility\perk::removeperk("specialty_block_health_regen");
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
    scripts\mp\utility\perk::removeperk("specialty_blindeye");
  }

  if(isDefined(level.playerdatafield) && [[level.playerdatafield]]()) {
    if(isDefined(level.playercleanupinfilondisconnect)) {
      self[[level.playercleanupinfilondisconnect]](0);
    }

    if(isDefined(level.playercleargulagomnvars)) {
      self[[level.playercleargulagomnvars]](0);
    }
  }

  var_1 = level.watch_for_payload_approach_cache_1;
  var_1 = getcompleteweaponname(var_1);

  if(self getcurrentprimaryweapon() != var_1) {
    self notify("end_switchToFists");
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
  }

  self notify("last_stand_finished");
  self.laststandoldweapon = undefined;

  if(istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
    scripts\mp\utility\player::ref_1312b(0);
  }

  if(level.gametype == "br") {
    scripts\mp\gametypes\br::ref_1401f(self, self, 0, 1);
    scripts\mp\gametypes\br_public::ref_1319c(0);
    self.disable_hotjoining_after_time = undefined;
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(isDefined(level.ref_11c79)) {
    self[[level.ref_11c79]](var_0);
  }

  waittillframeend();
  self.inlaststand = 0;
}

function onrevive(var_0, var_1) {
  var_2 = self.laststandoldweaponobj;
  scripts\common\utility::allow_vehicle_use(1);
  scripts\common\utility::allow_crate_use(1);
  scripts\common\utility::brjugg_droponplayerdeath(1);

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    scripts\mp\gametypes\br_plunder::ref_12781(self, 1, 1);
  }

  if(isDefined(self.laststandactionset)) {
    scripts\mp\playeractions::allowactionset(self.laststandactionset, 1);
  }

  onexitcommon(1);
  self laststandrevive();
  self notify("laststand_revived");
  var_3 = level.watch_for_payload_approach_cache_1;

  if(var_3 != "none") {
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 1);
  }

  if(!istrue(var_1)) {
    var_4 = level.laststandrevivehealth;

    if(!getdvarint("scr_player_lastStandReviveRetainHealth") || self.health < level.laststandrevivehealth) {
      self.health = level.laststandrevivehealth;
    }
  } else {
    self.health = self.maxhealth;
  }

  if(game["state"] == "postgame") {
    scripts\mp\gamelogic::freezeplayerforroundend();
  }

  scripts\mp\utility\player::ref_1312b(0);

  if(scripts\mp\utility\game::getgametype() == "br" && !istrue(self.gulag)) {
    scripts\common\utility::allow_weapon_switch_clip(1);

    if(!istrue(level.ref_133d8)) {
      var_5 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(self.team, self.squadindex);

      foreach(var_7 in var_5) {
        if(!isDefined(var_7)) {
          continue;
        }

        if(var_7 != self) {
          var_7 thread scripts\mp\hud_message::showsplash("br_teammate_revived", undefined, self);
        }
      }
    }
  }

  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();

  if(istrue(var_0) && istrue(level.allowselfrevive)) {
    allowselfrevive(0);
  }

  self.watch_for_attack = undefined;
  self.watch_for_level_weapons_free = undefined;
  self.watch_for_player_enter_puddle_trigger = undefined;
  self.watch_for_driver_spawned = undefined;
  self.watch_for_damage = undefined;
  self.watch_for_damage_on_trap = undefined;
  self.watch_for_damage_on_turret = undefined;
}

function onbleedout() {
  if(!isDefined(self)) {
    return;
  }

  thread onexitcommon();
  dropcarryobject();

  if(isDefined(self.watch_for_attack)) {
    self.watch_for_attack thread scripts\mp\rank::scoreeventpopup("kill_confirmed");
  }

  if(level.gametype == "br") {
    if(!istrue(level.gameended)) {
      self.islaststandbleedoutdmg = 0;
      self clearsoundsubmix("deaths_door_mp");
      self playlocalsound("deaths_door_death");
      self enableplayerbreathsystem(1);
    }
  }

  scripts\mp\utility\damage::_suicide();
}

function ondeath(var_0) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_0) && isDefined(self.watch_for_attack) && istrue(self.watch_for_attack.inlaststand)) {
    thread ref_1204f(self.watch_for_attack, var_0, self.watch_for_level_weapons_free);
  }

  if(istrue(self.usedprops)) {
    self notify("stopped_self_revive");
  }

  if(level.gametype == "br") {
    if(!istrue(level.gameended)) {
      self.islaststandbleedoutdmg = 0;
      self clearsoundsubmix("deaths_door_mp");
      self playlocalsound("deaths_door_death");
      self enableplayerbreathsystem(1);
    }
  }

  if(isDefined(level.getinfilplayers)) {
    [[level.getinfilplayers]](self, 1);
  }

  thread onexitcommon();
  dropcarryobject();
}

function dropcarryobject() {
  if(isDefined(self.carryobject)) {
    self.carryobject thread scripts\mp\gameobjects::setdropped();
    return;
  }
}

function revivesetup(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  var_0 waittill("last_stand_transition_done");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1 setCursorHint("HINT_NOICON");
  var_1 setusehideprogressbar(1);
  var_1 setuseholdduration("duration_none");
  var_1 setHintString(&"MP/LASTSTAND_REVIVE_USE");
  var_1 setusepriority(-2);
  var_2 = var_0.team;
  var_1 linkTo(var_0, "tag_origin", (0, 0, 6), (0, 0, 0));
  var_1.owner = var_0;
  var_1.inuse = 0;
  var_1.id = "laststand_reviver";
  var_1.trigger = spawnStruct();
  var_1.trigger.owner = var_0;
  var_1.trigger.id = "laststand_reviver";
  var_1.trigger.targetname = "revive_trigger";
  var_1 makeusable();
  thread trackteamchanges(var_1);
  thread revivetriggerthink(var_1);
  thread endreviveonownerdeathordisconnect();

  if(getdvarint("scr_player_lastStandEnableSecondWind", 0) && getdvarint("scr_player_enableSecondWindAndPistol", 0)) {
    thread ref_12fb4();
  }

  var_0.laststandreviveent = var_1;
  level.laststandreviveents[var_1 getentitynumber()] = var_1;
  thread removereviveentfromlevelarrayondeath();
  thread ref_144d0();

  if(var_0 scripts\mp\gametypes\br_public::shouldgetnewspawnpoint()) {
    ref_13014(var_0.laststandreviveent);
    return;
  }
}

function ref_12fb4() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_finished");
  level endon("game_ended");
  var_1 = gettime();
  var_0 waittill("killed_enemy_in_last_stand", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  for(;;) {
    if(var_9) {
      var_0 waittill("killed_enemy_in_last_stand", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
      continue;
    }

    break;
  }

  var_11 = var_2.watch_for_attack;

  if(!isDefined(var_11)) {
    var_11 = var_2;
  }

  var_12 = isDefined(var_11) && var_11 != var_0;
  var_13 = var_9;
  var_14 = var_10 || isDefined(var_3) && var_3 getentitynumber() == worldentnumber();
  var_15 = gettime() - var_1;
  var_16 = float(var_15 / 1000);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::diablecachesaroundorigin(var_0, var_11, var_2, var_5, var_6, var_7, var_8, var_12, var_13, var_14, var_16);
  }

  playanim_aibegindismountturret(var_0, "self_revive_on_kill_success", var_0);
  var_0 thread scripts\mp\hud_message::showsplash("br_second_wind");
  var_17 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_19 in var_17) {
    if(var_19 != var_0 && isalive(var_19)) {
      var_19 thread scripts\mp\hud_message::showsplash("br_teammate_second_wind", undefined, var_0);
    }
  }
}

function ref_1204f(var_0, var_1, var_2) {
  var_3 = var_0.victim;
  var_4 = var_0.inflictor;
  var_5 = var_0.objweapon;
  var_6 = var_0.meansofdeath;
  var_7 = var_0.weaponfullstring;
  var_8 = var_0.attacker != self;
  var_9 = istrue(var_0.assistedsuicide);
  var_10 = undefined;

  if(isDefined(var_2)) {
    var_10 = createheadicon(var_2);
  }

  self notify("killed_enemy_in_last_stand", var_3, var_4, var_5, var_6, var_7, var_1, var_10, var_8, var_9);
}

function endreviveonownerdeathordisconnect() {
  self endon("death");
  self.owner scripts\engine\utility::ref_143a6("death_or_disconnect", "last_stand_finished", "last_stand_heal_active");
  self delete();
}

function removereviveentfromlevelarrayondeath() {
  level endon("game_ended");
  var_0 = self getentitynumber();
  self waittill("death");
  level.laststandreviveents[var_0] = undefined;
}

function updateusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2.team && var_2 != self.owner && !istrue(var_2 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
      self enableplayeruse(var_2);
    } else {
      self disableplayeruse(var_2);
    }

    if(istrue(var_2 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
      var_2.hiddenreviveents[self getentitynumber()] = self;
    }
  }
}

function trackteamchanges(var_0) {
  self endon("death");
  self.owner endon("last_stand_finished");

  for(;;) {
    updateusablebyteam(var_0);
    level waittill("joined_team");
  }
}

function revivetriggerthink(var_0) {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(istrue(var_1.iszombie)) {
      continue;
    }

    if(var_1 scripts\mp\gametypes\br_public::ref_125ec()) {
      continue;
    }

    while(!var_1 isonground() && var_1 useButtonPressed()) {
      waitframe();
    }

    if(istrue(var_1.tracking_max_health)) {
      var_1 notify("br_try_armor_cancel");

      while(istrue(var_1.tracking_max_health) && var_1 useButtonPressed()) {
        waitframe();
      }
    }

    if(!var_1 useButtonPressed()) {
      continue;
    }

    self.owner scripts\mp\utility\player::ref_1312b(1);
    var_2 = 0;
    self.owner notify("handle_revive_message");
    self makeunusable();
    self.owner allowmovement(0);
    var_1 isholdingbreath(1);
    var_1.ref_12d1e = 1;
    self.reviver = var_1;
    thread useholdthink(var_1);
    thread ref_139d5(var_1);

    if(level.gametype == "br") {
      self.owner scripts\mp\gametypes\br_public::ref_1319c(1);
    }

    var_3 = scripts\engine\utility::ref_143b5("use_hold_revive_success", "use_hold_revive_fail", "death_or_disconnect");

    if(var_3 == "use_hold_revive_success") {
      var_2 = 1;
    }

    var_1 notify("finish_buddy_reviving");
    self.owner scripts\mp\utility\player::ref_1312b(0);
    var_2 = playanim_aibegindismountturret(self.owner, var_3, var_1);

    if(var_2) {
      return;
    }

    thread decayreviveprogress();
    self makeusable();
    updateusablebyteam(var_0);
    waittillframeend();
    self.reviver = undefined;
  }
}

function rpggetclosetoapc() {
  if(scripts\cp_mp\utility\game_utility::ref_140aa()) {
    return "teammate_revive_stim_mp_ch3";
  }

  return "teammate_revive_stim_mp";
}

function ref_139d5(var_0) {
  var_1 = self;
  var_1 endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(var_1.ref_1438b)) {
    return;
  }

  var_2 = getcompleteweaponname(rpggetclosetoapc());
  var_3 = var_1 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", var_1);
  var_3.ref_12d1d = var_2;
  var_4 = 0;

  while(!var_4 || istrue(var_1.consecutive_kills)) {
    var_4 = var_1 scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var_2, var_3, &ref_13ab4, undefined, &ref_1209f, undefined, &ref_120a0, 0);
    waitframe();
    var_1.ref_1438b = 1;
  }

  var_1.consecutive_kills = 1;
  var_1.ref_1438b = 0;
  thread ref_144b4();
  thread ref_144d5(var_1);
  thread ref_144d6(var_1);
}

function ref_1209f(var_0, var_1) {
  var_2 = self;
  var_2 disableweaponswitch();
}

function ref_120a0(var_0, var_1) {
  var_2 = self;
  var_2 enableweaponswitch();
  var_2 notify("revive_stim_finished");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == rpggetclosetoapc()) {
    waitframe();
  }

  waitframe();
  var_2.consecutive_kills = 0;
}

function ref_13ab4(var_0) {
  var_1 = self;
  level endon("game_ended");

  if(!istrue(var_1.ref_12d1e)) {
    return;
  }

  var_1 scripts\engine\utility::ref_143b5("death_or_disconnect", "finish_buddy_reviving", "last_stand_start");
}

function ref_144b4() {
  var_0 = self;
  var_0 endon("finish_buddy_reviving");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 waittill("death");
  var_0 enableweaponswitch();
}

function ref_144d5(var_0) {
  var_1 = self;
  var_1 endon("finish_buddy_reviving");
  var_1 endon("death_or_disconnect");
  level endon("game_ended");

  if(isalive(var_0)) {
    var_0 waittill("death_or_disconnect");
  }

  var_1 notify("finish_buddy_reviving");
}

function ref_144d6(var_0) {
  var_1 = self;
  var_1 endon("finish_buddy_reviving");
  var_1 endon("death_or_disconnect");
  level endon("game_ended");
  var_0 waittill("last_stand_revived");
  var_1 notify("finish_buddy_reviving");
}

function ref_144d0() {
  var_0 = self;

  if(!isPlayer(var_0)) {
    return;
  }

  if(!scripts\mp\utility\game::unset_relic_grounded()) {
    return;
  }

  var_1 = getdvarint("scr_br_laststand_allows_prone_transition", 0) == 1;

  if(!var_1) {
    return;
  }

  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_revived");
  jumpiftrue(isai(var_0)) LOC_000000d2;
  var_0 notifyonplayercommand("stanceChangePressed", "+stancedown");
  var_0 notifyonplayercommand("stanceChangePressed", "+movedown");
  var_0 notifyonplayercommand("stanceChangePressed", "+prone");
  var_0 notifyonplayercommand("stanceChangePressed", "+stance");
  var_0 notifyonplayercommand("stanceChangePressed", "+togglecrouch");
  var_0 notifyonplayercommand("stanceChangeReleased", "-stancedown");
  var_0 notifyonplayercommand("stanceChangeReleased", "-movedown");
  var_0 notifyonplayercommand("stanceChangeReleased", "-prone");
  var_0 notifyonplayercommand("stanceChangeReleased", "-stance");
  var_0 notifyonplayercommand("stanceChangeReleased", "-togglecrouch");

  for(;;) {
    var_0 waittill("stanceChangePressed");
    var_2 = gettime();
    var_0 waittill("stanceChangeReleased");
    var_3 = gettime() - var_2;
    var_4 = 350;

    if(var_3 < var_4) {
      ref_13bc9(var_0);
    }
  }
}

function ref_13bc9(var_0) {
  var_0.changesleft = !istrue(var_0.changesleft);
  var_1 = istrue(var_0.changesleft);
  var_2 = scripts\engine\utility::ter_op(var_1, "MP_BR_INGAME/WILL_REVIVE_INTO_PRONE", "MP_BR_INGAME/WILL_REVIVE_INTO_CROUCH");
  var_0 scripts\mp\hud_message::showerrormessage(var_2);
}

function playanim_aibegindismountturret(var_0, var_1) {
  var_2 = self;
  var_3 = 0;

  if(!isDefined(var_2) || !isalive(var_2)) {
    return 0;
  }

  if(var_0 == "use_hold_revive_success" || var_0 == "self_revive_on_kill_success" || var_0 == "self_revive_success") {
    var_3 = 1;
  }

  var_2.beingrevived = 0;
  var_2.usedprops = 0;

  if(var_0 == "self_revive_success") {
    var_2 setlaststandreviving();
  }

  if(level.gametype == "br") {
    self.watch_for_driver_death = undefined;
    var_2 scripts\mp\gametypes\br_public::ref_1319c(0);
    var_2 scripts\mp\gametypes\br_public::ref_131a6(0);
  }

  var_2 allowmovement(1);

  if(var_3) {
    var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
    var_2 notify("last_stand_revived");
    self.fastcrouchspeedmod = 0;
    scripts\mp\weapons::updatemovespeedscale();

    if(level.gametype == "br") {
      if(!istrue(level.gameended)) {
        var_2 scripts\mp\gametypes\br_public::ref_1319e(0);
        scripts\mp\events::revivedplayer(var_1, var_2);
        scripts\cp\vehicles\vehicle_compass_cp::ref_12050(var_1, var_2);
        var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_1383b("alive_not_downed");

        if(var_1 != var_2) {
          var_1 scripts\mp\utility\stats::incpersstat("rescues", 1);
        }

        var_2 scripts\mp\gametypes\br_public::runbrgametypefuncwrapper("onLastStandRevive", var_1);
        var_2.islaststandbleedoutdmg = 0;
        var_2 stoplocalsound("deaths_door_in");

        if(!istrue(var_2.deletequestcircle)) {
          var_2 playlocalsound("deaths_door_out");
          var_2 clearsoundsubmix("deaths_door_mp");
          var_2 playlocalsound(scripts\engine\utility::ter_op(scripts\mp\utility\player::isfemale(), "Fem_breathing_better", "breathing_better"));
          var_2 enableplayerbreathsystem(1);
        }
      }

      if(!scripts\mp\gametypes\br_public::validtousesticker() && !istrue(var_2.deletequestcircle)) {
        playsoundatpos(var_2.origin, "br_player_revived");
      }

      if(isDefined(self.watch_for_molotov_ambush_and_spawners)) {
        scripts\mp\utility\outline::outlinedisable(self.watch_for_molotov_ambush_and_spawners, self);
        self.watch_for_molotov_ambush_and_spawners = undefined;
      }
    }

    var_4 = "crouch";

    if(scripts\mp\utility\game::unset_relic_grounded()) {
      if(istrue(self.changesleft)) {
        var_4 = "prone";
      }

      self.changesleft = undefined;
    }

    var_5 = var_2 setstance(var_4);

    if(!var_5) {
      var_6 = var_4 == "crouch";
      var_5 = var_2 setstance(scripts\engine\utility::ter_op(var_6, "prone", "crouch"));
    }
  }

  ref_13a34(var_2);
  thread has_filled_amped_bar();
  return var_3;
}

function has_filled_amped_bar() {
  self endon("death_or_disconnect");

  if(level.gametype != "br") {
    return;
  }

  scripts\common\utility::allow_offhand_secondary_weapons(0, "laststand_throwback");

  while(self isthrowingbackgrenade()) {
    self.ref_13b4f = 1;
    self giveandfireoffhand("rock_mp");
    wait 1;
  }

  scripts\common\utility::allow_offhand_secondary_weapons(1, "laststand_throwback");
}

function decayreviveprogress() {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  self endon("use_hold_revive_start");
  self endon("self_revive_start");
  self endon("death");
  level endon("game_ended");
  var_0 = level.watch_for_next_sniper;

  if(var_0 <= 0) {
    return;
  }

  for(;;) {
    self.curprogress -= level.frameduration * var_0;

    if(self.curprogress <= 0) {
      self.curprogress = 0;
      return;
    }

    waitframe();
  }
}

function useholdthink(var_0, var_1) {
  self.owner endon("last_stand_finished");
  var_0 endon("death");
  level endon("game_ended");
  var_2 = self.owner;
  var_3 = getdvarint("scr_player_lastStandAllyDragEnable");
  var_4 = spawn("script_origin", self.origin);
  var_4 hide();

  if(!var_3) {
    var_0 scripts\mp\playeractions::allowactionset("laststand_revive", 0);
  }

  self notify("use_hold_revive_start");
  thread ref_13298();

  if(var_3) {
    dragallyprototype(var_0, var_2);
  }

  if(!isDefined(self.curprogress)) {
    self.curprogress = 0;
  }

  self.inuse = 1;
  self.userate = 0;
  var_5 = 0;

  if(isDefined(var_1)) {
    self.usetime = var_1;
  } else if(var_0 scripts\mp\utility\perk::_hasperk("specialty_medic")) {
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat("perk_medicReviveSpeedRatio");
  } else {
    self.usetime = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer") * 1000;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && var_0 scripts\mp\utility\perk::_hasperk("specialty_br_faster_revive")) {
    self.usetime *= 0.75;
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, "reviving");
  thread useholdthinkcleanup(var_0, var_4);
  thread useholdthinkloop(var_0);
}

function dragallyprototype(var_0, var_1) {
  var_2 = self;
  var_1 playerlinkTo(var_0);
  var_1 playerlinkedoffsetenable();
  var_1 allowmovement(0);
  var_0 setmovespeedscale(getdvarfloat("scr_player_lastStandAllyDragMoveSpeed"));
}

function cleanupdragallyprototype(var_0, var_1) {
  var_1 unlink();
  var_1 allowmovement(1);
  var_0 setmovespeedscale(1);
}

function useholdthinkcleanup(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_2 = getdvarint("scr_player_lastStandAllyDragEnable");
  var_3 = self.owner;
  var_4 = var_3 scripts\engine\utility::ref_143b6("death_or_disconnect", "use_hold_think_success", "use_hold_think_fail", "last_stand_finished");
  self.inuse = 0;
  var_1 delete();
  var_0 setlaststandselfreviving();
  var_0 isholdingbreath(0);
  var_0.ref_12d1e = 0;

  if(isDefined(var_0)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  if(isDefined(var_3)) {
    var_3 scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    if(var_2) {
      cleanupdragallyprototype(var_0, var_3);
    } else {
      var_0 scripts\mp\playeractions::allowactionset("laststand_revive", 1);
    }
  }

  var_0 notify("sfx_revive_done");

  if(var_4 == "use_hold_think_success") {
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("reviver");

    if(istrue(level.allowselfrevive)) {
      allowselfrevive(var_0, 1);
    }

    var_3 thread scripts\mp\rank::scoreeventpopup("revived");
    var_3 thread scripts\mp\hud_message::showsplash("revived", undefined, var_0);
    var_3.inlaststand = 0;
    self notify("use_hold_revive_success");
    return;
  } else if(var_4 == "use_hold_think_fail") {
    var_3 notify("handle_revive_message");
  }

  self notify("use_hold_revive_fail");
}

function ref_13298() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkTo(self);
  var_0 playLoopSound("br_reviver_use_lp");
  self waittill("sfx_revive_done");
  playsoundatpos(self.origin, "br_reviver_use_end");
  var_0 delete();
}

function useholdthinkloop(var_0) {
  var_1 = self.owner;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_finished");

  while(scripts\mp\utility\player::isreallyalive(var_0) && var_0 useButtonPressed() && !var_0 isinexecutionvictim() && self.curprogress < self.usetime && (!isDefined(var_0.inlaststand) || !var_0.inlaststand) && distancesquared(var_0.origin, self.origin) <= 65536) {
    if(istrue(var_0.tacopsmedicrole)) {
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    self.curprogress += level.frameduration * self.userate;
    self.userate = 1;
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      var_1 notify("use_hold_think_success");
      return;
    }

    waitframe();
  }

  var_1 notify("use_hold_think_fail");
}

function suicidesetup() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");
  thread showsuicidehintstring();

  if(!isbot(self)) {
    thread ref_13969();
  }

  for(var_0 = 0;; var_0 = 0) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0 && !scripts\mp\utility\player::registerpuzzleinteractions()) {
      var_0 += level.framedurationseconds;

      if(var_0 >= 0.5) {
        break;
      }

      continue;
    }
  }

  ref_1396a();
}

function ref_13969() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notifyonplayercommand("stance_pressed_down", "+movedown");
  self notifyonplayercommand("stance_pressed_up", "-movedown");
  self notifyonplayercommand("stance_pressed_down", "+stancedown");
  self notifyonplayercommand("stance_pressed_up", "-stancedown");
  var_0 = gettime();
  var_1 = 0;
  var_2 = 0;
  var_3 = 500;
  var_4 = 0;

  while(!var_4 && !var_1) {
    var_1 = 0;

    if(!var_2) {
      var_0 = gettime();
    }

    var_5 = scripts\engine\utility::ref_143bd(0.5, "stance_pressed_down", "stance_pressed_up", "last_stand_finished", "last_stand_self_revive", "last_stand_bleedout");

    switch (var_5) {
      case "stance_pressed_down":
        var_0 = gettime();
        var_2 = 1;
        break;
      case "stance_pressed_up":
      case "timeout":
        if(var_2 && gettime() - var_0 >= var_3) {
          var_1 = 1;
        }

        var_2 = 0;
        break;
      default:
        var_4 = 1;
        break;
    }

    waitframe();
  }

  if(var_1) {
    ref_1396a();
  }

  self notifyonplayercommandremove("stance_pressed_down", "+movedown");
  self notifyonplayercommandremove("stance_pressed_up", "-movedown");
  self notifyonplayercommandremove("stance_pressed_down", "+stancedown");
  self notifyonplayercommandremove("stance_pressed_up", "-stancedown");
}

function ref_1396a() {
  if(istrue(self.allowselfrevive)) {
    self notify("last_stand_self_revive");
    return;
  }

  self notify("last_stand_bleedout");
}

function showsuicidehintstring() {
  if(istrue(self.allowselfrevive)) {
    self forceusehinton(&"MP/HEROES_RETURN");
  } else if(level.gametype != "br") {
    thread handlerevivemessage();
  }

  scripts\engine\utility::waittill_any_ents(self, "death_or_disconnect", self, "last_stand_finished", level, "game_ended");

  if(!isDefined(self)) {
    return;
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self forceusehintoff();
}

function handlerevivemessage() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");

  for(;;) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
    var_0 = 0;
    var_1 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(var_1) && var_1 == "super_laststand_heal" && scripts\mp\supers::issuperready()) {
      var_0 = 1;
    }

    if(istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(22);
    } else if(istrue(self.laststandhealisactive)) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(23);
    } else if(isDefined(self.timeuntilbleedout)) {
      if(var_0) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(19, int(gettime() + self.timeuntilbleedout * 1000));
      } else if(scripts\mp\utility\game::getgametype() != "dm") {
        if(self.pers["lives"] == 0 && scripts\mp\utility\game::isteamreviveenabled()) {
          scripts\mp\utility\lower_message::setlowermessageomnvar(5, int(gettime() + self.timeuntilbleedout * 1000));
        } else {
          scripts\mp\utility\lower_message::setlowermessageomnvar(20, int(gettime() + self.timeuntilbleedout * 1000));
        }
      } else {
        scripts\mp\utility\lower_message::setlowermessageomnvar(21, int(gettime() + self.timeuntilbleedout * 1000));
      }
    } else if(var_0) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(19);
    } else if(self.pers["lives"] == 0 && scripts\mp\utility\game::isteamreviveenabled()) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(5);
    } else {
      scripts\mp\utility\lower_message::setlowermessageomnvar(20);
    }

    for(;;) {
      var_2 = scripts\engine\utility::ref_143b4("super_ready", "handle_revive_message");

      if(var_2 == "super_ready" && scripts\mp\supers::getcurrentsuperref() != "super_laststand_heal") {
        continue;
      }

      break;
    }
  }
}

function bleedoutthink() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");
  var_0 = self.timeuntilbleedout;

  if(var_0 != 0) {
    for(;;) {
      waitframe();

      if(self isinexecutionvictim()) {
        continue;
      }

      if(!istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
        var_0 -= level.framedurationseconds;
      }

      if(var_0 <= level.framedurationseconds) {
        self notify("last_stand_bleedout");
        break;
      }

      self.timeuntilbleedout = var_0;
    }

    return;
  }
}

function addoverheadicon() {
  var_0 = self.origin;
  var_1 = newteamhudelem(self.team);
  var_1.x = var_0[0];
  var_1.y = var_0[1];
  var_1.z = var_0[2] + 32;
  var_1.alpha = 1;
  var_1.archived = 0;
  var_1.showinkillcam = 0;

  if(level.splitscreen) {
    var_1 setshader("hud_realism_head_revive", 10, 10);
  } else {
    var_1 setshader("hud_realism_head_revive", 5, 5);
  }

  var_1 setwaypoint(0);
  var_1 settargetEnt(self);
  thread cleanupoverheadicon(var_1);
}

function cleanupoverheadicon(var_0) {
  self waittill("last_stand_finished");
  var_0 destroy();
}

function showwaverespawnmessage() {
  var_0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

  if(!var_0) {
    return;
  }

  self endon("last_stand_finished");

  for(;;) {
    self.respawntimerstarttime = gettime();
    var_0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

    if(var_0) {
      var_1 = scripts\mp\playerlogic::timeuntilwavespawn(0);
      scripts\mp\utility\lower_message::setlowermessageomnvar(10, int(gettime() + var_1 * 1000));
      wait var_1;
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
    }

    wait 2;
  }
}

function allowselfrevive(var_0) {
  self.allowselfrevive = var_0;
  self setclientomnvar("ui_self_revive", var_0);
}

function laststandmonitor() {
  level endon("game_ended");

  if(istrue(level.watch_for_icbm_spawners)) {
    return;
  }

  for(;;) {
    waitframe();

    if(scripts\mp\utility\game::getgametypenumlives() == 0 && !istrue(level.disablespawning)) {
      continue;
    }

    thread laststandkillteamifdown();
  }
}

function laststandkillteamifdown() {
  foreach(var_1 in level.teamnamelist) {
    var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_1, 1);
    var_3 = [];

    foreach(var_5 in var_2) {
      if(istrue(var_5.inlaststand)) {
        var_3 = var_5;
      }
    }

    if(var_3.size > 0 && var_2.size <= var_3.size) {
      level.laststandrequiresmelee = 0;

      foreach(var_5 in var_3) {
        if(!isDefined(var_5)) {
          continue;
        }

        var_5 notify("last_stand_bleedout");
      }
    }
  }
}

function getclassiclaststandpistol() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    var_3 = weaponclass(var_2);

    if(weaponclass(var_2) == "pistol") {
      return var_2;
    }
  }

  var_2 = scripts\mp\class::buildweapon(scripts\mp\utility\weapon::getweaponrootname("iw8_pi_golf21_mp"), [], "none", "none", -1);
  return var_2;
}

function makelaststandinvuln() {
  var_0 = level.laststandinvulntime;
  clearlaststandinvuln();
  self endon("disconnect");
  self endon("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_invuln", 0, 0, &laststandinvulnignorefunc);
  scripts\engine\utility::waittill_notify_or_timeout("death", var_0);
  thread clearlaststandinvuln();
}

function clearlaststandinvuln() {
  self notify("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_invuln", 0);
}

function laststandinvulnignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 == "MOD_TRIGGER_HURT") {
    return true;
  }

  return false;
}

function getdefaultlaststandtimervalue() {
  return 10;
}

function getdefaultlaststandrevivetimervalue() {
  return 10;
}

function getshellshockinterruptdelayms(var_0) {
  return var_0 * 1000;
}
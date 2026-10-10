/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1845b8a2edf19262.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_208955cb4d2c8fb3;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_4fdefae8b7bcdf73;
#using script_6617e2f2bb62b52b;
#using script_7956d56c4922bd1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_733126084ca779c5;

function function_77a37b3f4896fc9b() {
  if(!istrue(level.var_adf7379f14500889)) {
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", &function_37918fa831854a31);
    function_965a91ee1fe1a428();
    game["dialog"]["safecrack_safe_is_near"] = "dx_br_dmzo_cost_ovld_actualtoultra1target";
    game["dialog"]["safecrack_safe_bringing_heat"] = "dx_br_dmzo_cost_ovld_ultra1beadvisedthats";
    game["dialog"]["safecrack_enemies_incoming"] = "dx_br_dmzo_cost_ovld_ultra1yougothostiles";
    game["dialog"]["safecrack_enemies_alerted"] = "dx_br_dmzo_cost_ovld_headsupultra1thatsaf";
    game["dialog"]["safecrack_safe_is_open0"] = "dx_br_dmzo_cost_ovld_ultra1thesafeisopens";
    game["dialog"]["safecrack_safe_is_open1"] = "dx_br_dmzo_cost_ovld_ultra1safeisopensecu";
    game["dialog"]["safecrack_safe_is_open2"] = "dx_br_dmzo_cost_ovld_ultra1safeisopensecu_01";
    game["dialog"]["safecrack_enemies_at_safe"] = "dx_br_dmzo_cost_ovld_ultra1enemyoperators";
    game["dialog"]["safecrack_enemies_near_safe"] = "dx_br_dmzo_cost_ovld_actualtoultra1enemie";
    game["dialog"]["safecrack_enemies_opening_safe"] = "dx_br_dmzo_cost_ovld_ultra1hostilesareatt";
    level.var_adf7379f14500889 = 1;
  }
}

function function_12920ead9cafd0e1(origin, angles) {
  safe = spawnscriptable("safecrack_safe", origin, angles);
  safe setscriptablepartstate("body", "usable_not_open");
  safe.activity = self;
  safe.poi = self.poi;
  safe.var_55bb3585d29af1be = &function_76ab1a108d9b14ef;
  safe.curorigin = safe.origin;
  safe.offset3d = (0, 0, 15);
  safe scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(safe.objidnum, "ui_map_icon_safe");
  scripts\mp\objidpoolmanager::update_objective_setbackground(safe.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(safe.objidnum, 15);
  scripts\mp\objidpoolmanager::update_objective_position(safe.objidnum, safe.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_pin_global(safe.objidnum, 1);
  scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(safe.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(safe.objidnum, 0);

  if(level.safecrack.hideicons) {
    scripts\mp\objidpoolmanager::function_9cad42ac02eff950(safe.objidnum);
  } else {
    scripts\mp\objidpoolmanager::function_a28e8535e00d34f3(safe.objidnum);
  }

  scripts\mp\objidpoolmanager::function_6ae37618bb04ea60(safe.objidnum);
  safe.trigger = spawn("trigger_radius", safe.origin, 0, self.capture_radius, self.capture_radius);
  safe.trigger trigger_off();
  safe thread function_e210529ea288eb50();
  return safe;
}

function private function_76ab1a108d9b14ef(instance, player) {}

function private function_37918fa831854a31(safe, part, state, player, var_a5b2c541413aa895, usestring) {
  if(isDefined(player) && istrue(player.var_859654e0445a36d9)) {
    player scripts\mp\hud_message::showerrormessage("MP/DENY_USE_CARRY");
    return;
  }

  if(state == "usable_not_open") {
    thread function_70ff902643fc02d(safe, part, state, player);
    return;
  }

  if(state == "open_usable") {
    if(safe getscriptableparthasstate(part, "fully_opening_unusable")) {
      safe setscriptablepartstate(part, "fully_opening_unusable");
    }

    if(!isDefined(safe.contents)) {
      safe notify("safe_looted");
      safe.containertype = 4;
      safe.var_6a4915c949e9e77e = 1;
      items = scripts\cp_mp\loot\common_item::function_bc2f4857c90f5344(safe.activity.var_48c4ba670a4f33fc, safe.activity.var_614385c59920cb82);

      foreach(item in items) {
        var_770523006511b66b = item;

        if(function_35aa0ab850bda2a(var_770523006511b66b)) {
          newitem = safe.key;

          if(isDefined(newitem)) {
            var_770523006511b66b = newitem;
          } else {
            var_54d38f1df370976a = namespace_ad1f398af6f48cb1::function_621b23491ba1db4d();

            if(isDefined(var_54d38f1df370976a)) {
              var_770523006511b66b = var_54d38f1df370976a.keyitemid;
            } else {
              var_770523006511b66b = undefined;
            }
          }
        }

        if(isDefined(var_770523006511b66b)) {
          scripts\cp_mp\loot\common_cache::function_ff5a53c1d3232e2f(safe, 1, var_770523006511b66b);
        }
      }
    }

    scripts\cp_mp\loot\common_cache::function_30f5ea60517f9e06(safe, player);
    return;
  }

  if(isDefined(safe.contents) && state == "partially_open_usable") {
    if(safe getscriptableparthasstate(part, "fully_opening_unusable")) {
      safe setscriptablepartstate(part, "fully_opening_unusable");
    }

    scripts\cp_mp\loot\common_cache::function_30f5ea60517f9e06(safe, player);
  }
}

function private function_35aa0ab850bda2a(item) {
  return issubstr(item, "human_fortress");
}

function private function_70ff902643fc02d(safe, part, state, player) {
  safe setscriptablepartstate(part, "unusable");
  safe.successfuluse = 0;
  safe thread function_4322c5f15901c02a(player);
  safe function_7c9992633ba2713f(player);

  if(istrue(safe.successfuluse)) {
    safe.teams = [player.team];
    safe.trigger trigger_on();
    function_bbdcd857d0c2a65e(safe.activity, player, "PlayerJoinedInteract");

    if(isDefined(safe.activity) && isDefined(safe.activity.var_f6bc8fb4bf53a955)) {
      safe[[safe.activity.var_f6bc8fb4bf53a955]]();
    }

    if(issharedfuncdefined("safe", "onStartUnlocking")) {
      function_f3bb4f4911a1beb2("safe", "onStartUnlocking", safe, part, state, player);
    }

    safe notify("safe_unlocking");
    safe.var_208c5333afcd7102 = 1;
    scripts\mp\objidpoolmanager::update_objective_state(safe.objidnum, "current");
    scripts\mp\objidpoolmanager::objective_show_progress(safe.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(safe.objidnum, player.team);
    safe thread function_b54d1f4a457190bd();
    return;
  }

  safe setscriptablepartstate(part, "usable_not_open");
}

function private function_b54d1f4a457190bd() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.progress = 0;
  var_306804c6c85c36b0 = undefined;
  intervalindex = 0;
  shownplayers = [];
  capturetime = getdvarint(@ "hash_f123359584819a3a", self.activity.capture_time);

  while(true) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(!isDefined(var_306804c6c85c36b0)) {
        var_306804c6c85c36b0 = [0, capturetime / 4, capturetime / 2, capturetime / 100 * 75];
      }

      if(self.nearbyplayers.size > 0) {
        progressbefore = self.progress;
        self.progress = min(capturetime, self.progress + level.framedurationseconds);
        scripts\mp\objidpoolmanager::objective_pin_global(self.objidnum, 1);
      } else if(self.activity.lose_progress) {
        progressbefore = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 0.5);
        scripts\mp\objidpoolmanager::objective_pin_global(self.objidnum, 0);
      }

      progress = self.progress / capturetime;
      shownplayers = function_f64c5b47c182d6f2(self.nearbyplayers, shownplayers, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

      if(self.progress >= capturetime) {
        thread safe_opensafe();
      } else if(self.nearbyplayers.size > 0 && isDefined(var_306804c6c85c36b0[intervalindex]) && self.progress >= var_306804c6c85c36b0[intervalindex]) {
        intervalindex++;

        if(isDefined(self.activity) && isDefined(self.activity.var_999c4a8370c90a74)) {
          self[[self.activity.var_999c4a8370c90a74]]();
        }

        if(!istrue(self.reinforcementscalled) && intervalindex == 2) {
          self.shouldreinforce = 1;
        }
      } else if(self.nearbyplayers.size == 0 && intervalindex > 0) {
        intervalindex = 0;
      }
    }

    waitframe();
  }
}

function private function_f64c5b47c182d6f2(nearbyplayers, shownplayers, progress) {
  allplayers = array_combine(nearbyplayers, shownplayers);
  var_f6fd7b0e73c3270c = shownplayers;

  foreach(player in allplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!array_contains(shownplayers, player) && array_contains(nearbyplayers, player)) {
      if(scripts\mp\objidpoolmanager::function_ce702e5925e31fc9(self.objidnum, player, 1, 2, &"MP_DMZ_MISSIONS/OPENING_SAFE")) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
        var_f6fd7b0e73c3270c = array_add(var_f6fd7b0e73c3270c, player);
      }

      continue;
    }

    if(array_contains(shownplayers, player) && !array_contains(nearbyplayers, player)) {
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.objidnum, player);
      var_f6fd7b0e73c3270c = array_remove(var_f6fd7b0e73c3270c, player);
    }
  }

  return var_f6fd7b0e73c3270c;
}

function private safe_opensafe() {
  if(!istrue(self.unlocked)) {
    self.unlocked = 1;
  }

  foreach(team in self.teams) {
    foreach(player in getteamdata(team, "players")) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.objidnum, player);

      if(!isDefined(player.var_6b41d67653e80c4b)) {
        player.var_6b41d67653e80c4b = 0;
      }

      player.var_6b41d67653e80c4b++;

      if(isDefined(player.var_d1e277c70c37ea5a)) {
        self.var_10505f0fb3d81db4 = 1;
      }
    }

    params = spawnStruct();
    params.safe = self;
    self.activity callback::callback("safe_opened", params);

    if(isDefined(self.var_10505f0fb3d81db4)) {
      self.var_208c5333afcd7102 = undefined;
      continue;
    }

    self.activity function_1281c7fff9456e18("safecrack_unlocked", getteamdata(team, "players"));
  }

  self setscriptablepartstate("body", "opening");

  if(isDefined(self.activity) && isDefined(self.activity.safeunlocked)) {
    self[[self.activity.safeunlocked]]();
  }

  self.trigger delete();
  scripts\mp\gameobjects::releaseid();
  self notify("safe_unlocked");
  sparams = spawnStruct();
  sparams.safe = self;

  foreach(player in self.nearbyplayers) {
    player callback::callback("safe_opened_nearby", sparams);
  }
}

function private function_e210529ea288eb50() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.nearbyplayers = [];

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isPlayer(player) || array_contains(self.nearbyplayers, player)) {
      continue;
    }

    if(!array_contains(self.teams, player.team)) {
      self.teams[self.teams.size] = player.team;
    }

    self.nearbyplayers = array_add(self.nearbyplayers, player);
    childthread function_19aa45f456e9a8c5(player);
  }
}

function private function_19aa45f456e9a8c5(player) {
  while(isDefined(self.trigger) && isDefined(player) && isalive(player) && distancesquared(self.trigger.origin, player.origin) < 1.1 * self.activity.var_82fe1c44f0e59dd5) {
    wait 0.2;
  }

  self.nearbyplayers = array_remove(self.nearbyplayers, player);
}

#using_animtree("script_model");

function private function_965a91ee1fe1a428() {
  level.scr_animtree["safe_drill_player"] = #animtree;
  level.scr_anim["safe_drill_player"]["safedrill_enter"] = % iw9_dmz_safedrill_enter_sdr;
  level.scr_eventanim["safe_drill_player"]["safedrill_enter"] = % "safedrill_enter";
  level.scr_viewmodelanim["safe_drill_player"]["safedrill_enter"] = "iw9_dmz_safedrill_enter_sdr";
  level.scr_anim["safe_drill_player"]["safedrill_exit"] = % iw9_dmz_safedrill_exit_sdr;
  level.scr_eventanim["safe_drill_player"]["safedrill_exit"] = % "safedrill_exit";
  level.scr_viewmodelanim["safe_drill_player"]["safedrill_exit"] = "iw9_dmz_safedrill_exit_sdr";
}

function private function_7c9992633ba2713f(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  player function_e8369984e9eef428(0);
  playerviewangles = player getplayerangles();
  player.linktoent = player spawn_tag_origin(player.origin, player.playerviewangles);
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1);
  goalpos = self.origin + rotatevector((50.586, -6.262, 0), self.angles);
  forward = (0, 0, 0) - anglesToForward(self.angles);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  goalangles = axistoangles(forward, right, up);
  movetotime = 0.5;
  player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
  player.linktoent rotateTo(goalangles, movetotime, 0.1, 0.1);
  player setstance("stand");
  var_cd9982adb17761a8 = gettime();
  player thread function_8735e24dceeb7187();
  player scripts\cp_mp\utility\inventory_utility::function_fc6a5b145563be33();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = movetotime - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000;
  waittime = max(0, var_218f64cb035d54be);
  wait waittime;
  player setOrigin(goalpos);
  player setplayerangles(goalangles);
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("safe_drill_player", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);
  self setscriptablepartstate("body", "unusable_intro_drilling");
  scripts\mp\anim::anim_player_solo(player, player.player_rig, "safedrill_enter");

  if(isreallyalive(player)) {
    scripts\mp\anim::anim_player_solo(player, player.player_rig, "safedrill_exit");
  }

  if(isDefined(player) && isreallyalive(player)) {
    player notify("interact_finished");
  }

  waitframe();

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(player)) {
    player notify("remove_rig");

    if(isreallyalive(player)) {
      player function_e8369984e9eef428(1);
    }
  }

  self.successfuluse = 1;
}

function private function_8735e24dceeb7187() {
  level endon("game_ended");
  self endon("drillingAnimComplete");
  self endon("death_or_disconnect");
  self endon("interact_finished");
  waittill_any_2("last_stand_start", "interact_interrupt");
  scripts\cp_mp\utility\inventory_utility::function_9897d143c3feee05();
}

function private function_e8369984e9eef428(isallowed) {
  if(!isallowed) {
    val::set("drilling", "allow_jump", 0);
    val::set("drilling", "gesture", 0);
    val::set("drilling", "melee", 0);
    val::set("drilling", "mantle", 0);
    val::set("drilling", "offhand_weapons", 0);
    val::set("drilling", "allow_movement", 0);
    val::set("drilling", "sprint", 0);
    val::set("drilling", "fire", 0);
    val::set("drilling", "reload", 0);
    val::set("drilling", "weapon_pickup", 0);
    val::set("drilling", "weapon_switch", 0);
    val::set("drilling", "offhand_weapons", 0);
    val::set("drilling", "execution_victim", 0);
    val::set("drilling", "vehicle_use", 0);
    self function_35501b42058d4de9();
    return;
  }

  val::reset_all("drilling");
  self function_bb04491d50d9e43e();
}

function private function_4322c5f15901c02a(player) {
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player function_e8369984e9eef428(1);
}
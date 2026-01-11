/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_fireteam_commander.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots_util;

init() {
  if(bot_is_fireteam_mode()) {
    level.tactic_notifies = [];

    level.tactic_notifies[0] = "tactics_exit";
    level.tactic_notifies[1] = "tactic_none";
    if(level.gametype == "dom") {
      level.tactic_notifies[2] = "tactic_dom_holdA";
      level.tactic_notifies[3] = "tactic_dom_holdB";
      level.tactic_notifies[4] = "tactic_dom_holdC";
      level.tactic_notifies[5] = "tactic_dom_holdAB";
      level.tactic_notifies[6] = "tactic_dom_holdAC";
      level.tactic_notifies[7] = "tactic_dom_holdBC";
      level.tactic_notifies[8] = "tactic_dom_holdABC";
    } else if(level.gametype == "war") {
      level.tactic_notifies[2] = "tactic_war_hyg";
      level.tactic_notifies[3] = "tactic_war_buddy";
      level.tactic_notifies[4] = "tactic_war_hp";

      level.tactic_notifies[5] = "tactic_war_pincer";
      level.tactic_notifies[6] = "tactic_war_ctc";
      level.tactic_notifies[7] = "tactic_war_rg";
    } else {
      Assert(0 && "Fireteam mode does not currently support gametype " + level.gametype);
      return;
    }

    level.fireteam_commander = [];
    level.fireteam_commander["axis"] = undefined;
    level.fireteam_commander["allies"] = undefined;

    level.fireteam_hunt_leader = [];
    level.fireteam_hunt_leader["axis"] = undefined;
    level.fireteam_hunt_leader["allies"] = undefined;

    level.fireteam_hunt_target_zone = [];
    level.fireteam_hunt_target_zone["axis"] = undefined;
    level.fireteam_hunt_target_zone["allies"] = undefined;

    level thread commander_wait_connect();
    level thread commander_aggregate_score_on_game_end();
  }
}

commander_aggregate_score_on_game_end() {
  level waittill("game_ended");

  if(isDefined(level.fireteam_commander["axis"])) {
    aggScore = 0;
    foreach(player in level.players) {
      if(IsBot(player) && player.team == "axis") {
        aggScore += player.pers["score"];
      }
    }
    level.fireteam_commander["axis"].pers["score"] = aggScore;
    level.fireteam_commander["axis"].score = aggScore;
    level.fireteam_commander["axis"] maps\mp\gametypes\_persistence::statAdd("score", aggScore);
    level.fireteam_commander["axis"] maps\mp\gametypes\_persistence::statSetChild("round", "score", aggScore);
  }

  if(isDefined(level.fireteam_commander["allies"])) {
    aggScore = 0;
    foreach(player in level.players) {
      if(IsBot(player) && player.team == "allies") {
        aggScore += player.pers["score"];
      }
    }
    level.fireteam_commander["allies"].pers["score"] = aggScore;
    level.fireteam_commander["allies"].score = aggScore;
    level.fireteam_commander["allies"] maps\mp\gametypes\_persistence::statAdd("score", aggScore);
    level.fireteam_commander["allies"] maps\mp\gametypes\_persistence::statSetChild("round", "score", aggScore);
  }
}

commander_create_dom_obj(domPointLetter) {
  Assert(level.gameType == "dom");
  if(!isDefined(self.fireteam_dom_point_obj[domPointLetter])) {
    self.fireteam_dom_point_obj[domPointLetter] = maps\mp\gametypes\_gameobjects::getNextObjID();

    pos = (0, 0, 0);
    foreach(domFlag in level.domFlags) {
      if(domFlag.label == "_" + domPointLetter) {
        pos = domFlag.curOrigin;
        break;
      }
    }

    objective_add(self.fireteam_dom_point_obj[domPointLetter], "invisible", pos, "compass_obj_fireteam");
    Objective_PlayerTeam(self.fireteam_dom_point_obj[domPointLetter], self GetEntityNumber());
  }
}

commander_initialize_gametype() {
  if(isDefined(self.commander_gametype_initialized)) {
    return;
  }
  self.commander_gametype_initialized = true;

  self.commander_last_tactic_applied = "tactic_none";
  self.commander_last_tactic_selected = "tactic_none";

  switch (level.gameType) {
    case "war":

      break;
    case "dom":

      self.fireteam_dom_point_obj = [];
      commander_create_dom_obj("a");
      commander_create_dom_obj("b");
      commander_create_dom_obj("c");
      break;
  }
}

commander_monitor_tactics() {
  self endon("disconnect");
  level endon("game_ended");

  while(1) {
    self waittill("luinotifyserver", channel, index);

    if(channel != "tactic_select") {
      if(channel == "bot_select") {
        if(index > 0) {
          commander_handle_notify_quick("bot_next");
        } else if(index < 0) {
          commander_handle_notify_quick("bot_prev");
        }
      } else if(channel == "tactics_menu") {
        if(index > 0) {
          commander_handle_notify_quick("tactics_menu");
        } else if(index <= 0) {
          commander_handle_notify_quick("tactics_close");
        }
      }
      continue;
    }

    if(index >= level.tactic_notifies.size) {
      assertex(index < level.tactic_notifies.size, "Fireteam Tactical Menu choice index (" + index + ") out of range (" + level.tactic_notifies.size + ")");
      continue;
    }
    response = level.tactic_notifies[index];

    commander_handle_notify_quick(response);
  }
}

commander_handle_notify_quick(response, sendToBotAI) {
  if(!isDefined(response)) {
    return;
  }
  switch (response) {
    case "bot_prev":
      commander_spectate_next_bot(true);
      break;
    case "bot_next":
      commander_spectate_next_bot(false);
      break;
    case "tactics_menu":
      self notify("commander_mode");
      if(isDefined(self.forcespectatorent)) {
        self.forcespectatorent notify("commander_mode");
      }
      break;
    case "tactics_close":
      self.commander_closed_menu_time = GetTime();
      self notify("takeover_bot");
      break;
    case "tactic_none":
      if(level.gameType == "dom") {
        Objective_State(self.fireteam_dom_point_obj["a"], "invisible");
        Objective_State(self.fireteam_dom_point_obj["b"], "invisible");
        Objective_State(self.fireteam_dom_point_obj["c"], "invisible");
      }
      break;

    case "tactic_dom_holdA":
      Objective_State(self.fireteam_dom_point_obj["a"], "active");
      Objective_State(self.fireteam_dom_point_obj["b"], "invisible");
      Objective_State(self.fireteam_dom_point_obj["c"], "invisible");
      break;
    case "tactic_dom_holdB":
      Objective_State(self.fireteam_dom_point_obj["a"], "invisible");
      Objective_State(self.fireteam_dom_point_obj["b"], "active");
      Objective_State(self.fireteam_dom_point_obj["c"], "invisible");
      break;
    case "tactic_dom_holdC":
      Objective_State(self.fireteam_dom_point_obj["a"], "invisible");
      Objective_State(self.fireteam_dom_point_obj["b"], "invisible");
      Objective_State(self.fireteam_dom_point_obj["c"], "active");
      break;
    case "tactic_dom_holdAB":
      Objective_State(self.fireteam_dom_point_obj["a"], "active");
      Objective_State(self.fireteam_dom_point_obj["b"], "active");
      Objective_State(self.fireteam_dom_point_obj["c"], "invisible");
      break;
    case "tactic_dom_holdAC":
      Objective_State(self.fireteam_dom_point_obj["a"], "active");
      Objective_State(self.fireteam_dom_point_obj["b"], "invisible");
      Objective_State(self.fireteam_dom_point_obj["c"], "active");
      break;
    case "tactic_dom_holdBC":
      Objective_State(self.fireteam_dom_point_obj["a"], "invisible");
      Objective_State(self.fireteam_dom_point_obj["b"], "active");
      Objective_State(self.fireteam_dom_point_obj["c"], "active");
      break;
    case "tactic_dom_holdABC":
      Objective_State(self.fireteam_dom_point_obj["a"], "active");
      Objective_State(self.fireteam_dom_point_obj["b"], "active");
      Objective_State(self.fireteam_dom_point_obj["c"], "active");
      break;

    case "tactic_war_rg":
      break;
    case "tactic_war_ctc":
      break;
    case "tactic_war_hp":
      break;
    case "tactic_war_buddy":
      break;
    case "tactic_war_pincer":
      break;
    case "tactic_war_hyg":
      break;

  }

  if(string_starts_with(response, "tactic_")) {
    self PlayLocalSound("earn_superbonus");
    if(self.commander_last_tactic_applied != response) {
      self.commander_last_tactic_applied = response;
      self thread commander_order_ack();
      if(isDefined(level.bot_funcs["commander_gametype_tactics"])) {
        self[[level.bot_funcs["commander_gametype_tactics"]]](response);
      }
    }
  }
}

commander_order_ack() {
  self notify("commander_order_ack");
  self endon("commander_order_ack");

  self endon("disconnect");

  maxDistSq = (600 * 600);
  bestDistSq = maxDistSq;
  closestBotAlly = undefined;
  while(1) {
    wait(0.5);

    bestDistSq = maxDistSq;
    closestBotAlly = undefined;

    org = self.origin;
    spectatedBot = self GetSpectatingPlayer();
    if(isDefined(spectatedBot)) {
      org = spectatedBot.origin;
    }

    foreach(player in level.players) {
      if(isDefined(player) && IsAlive(player) && IsBot(player) && isDefined(player.team) && player.team == self.team) {
        distSq = DistanceSquared(org, player.origin);
        if(distSq < bestDistSq) {
          closestBotAlly = player;
        }
      }
    }
    if(isDefined(closestBotAlly)) {
      prefix = closestBotAlly.pers["voicePrefix"];
      newAlias = prefix + level.bcSounds["callout_response_generic"];
      closestBotAlly thread maps\mp\gametypes\_battlechatter_mp::doSound(newAlias, true, true);
      return;
    }
  }
}

commander_hint_fade(time) {
  if(!isDefined(self)) {
    return;
  }
  self notify("commander_hint_fade_out");
  if(isDefined(self.commanderHintElem)) {
    hud = self.commanderHintElem;
    if(time > 0) {
      hud ChangeFontScaleOvertime(time);
      hud.fontScale = hud.fontScale * 1.5;
      hud.glowColor = (0.3, 0.6, 0.3);
      hud.glowAlpha = 1;
      hud FadeOverTime(time);
      hud.color = (0, 0, 0);
      hud.alpha = 0;
      wait(time);
    }
    hud maps\mp\gametypes\_hud_util::destroyElem();
  }
}

commander_hint() {
  self endon("disconnect");
  self endon("commander_mode");

  self.commander_gave_hint = true;

  wait(1);
  if(!isDefined(self)) {
    return;
  }
  self.commanderHintElem = self maps\mp\gametypes\_hud_util::createFontString("default", 3);
  self.commanderHintElem.color = (1, 1, 1);
  self.commanderHintElem setText(&"MPUI_COMMANDER_HINT");
  self.commanderHintElem.x = 0;
  self.commanderHintElem.y = 20;
  self.commanderHintElem.alignX = "center";
  self.commanderHintElem.alignY = "middle";
  self.commanderHintElem.horzAlign = "center";
  self.commanderHintElem.vertAlign = "middle";
  self.commanderHintElem.foreground = true;
  self.commanderHintElem.alpha = 1;
  self.commanderHintElem.hidewhendead = true;
  self.commanderHintElem.sort = -1;
  self.commanderHintElem endon("death");

  self thread commander_hint_delete_on_commander_menu();

  wait(4.0);
  thread commander_hint_fade(0.5);
}

commander_hint_delete_on_commander_menu() {
  self endon("disconnect");
  self endon("commander_hint_fade_out");

  self waittill("commander_mode");
  thread commander_hint_fade(0);
}

hud_monitorPlayerOwnership() {
  self endon("disconnect");

  self.ownerShipString = [];
  for(s = 0; s < 16; s++) {
    self.ownerShipString[s] = self maps\mp\gametypes\_hud_util::createFontString("default", 1);
    self.ownerShipString[s].color = (1, 1, 1);
    self.ownerShipString[s].x = 0;
    self.ownerShipString[s].y = 30 + s * 12;
    self.ownerShipString[s].alignX = "center";
    self.ownerShipString[s].alignY = "top";
    self.ownerShipString[s].horzAlign = "center";
    self.ownerShipString[s].vertAlign = "top";
    self.ownerShipString[s].foreground = true;
    self.ownerShipString[s].alpha = 1;
    self.ownerShipString[s].sort = -1;
    self.ownerShipString[s].archived = false;
  }

  while(1) {
    i = 0;
    linked_players = [];
    foreach(hudelem in self.ownerShipString) {
      hudelem SetDevText("");
    }

    foreach(player in level.players) {
      no_line = false;
      if(isDefined(player) && player.team == self.team) {
        if(isDefined(player.owner)) {
          if(array_contains(linked_players, player)) {
            self.ownerShipString[i] SetDevText(player.name + " already linked, but is owned by: " + player.owner.name);
            self.ownerShipString[i].color = (1, 0, 0);
          } else {
            linked_players = array_add(linked_players, player);
          }
          if(player != player.owner && array_contains(linked_players, player.owner)) {
            self.ownerShipString[i] SetDevText(player.name + " owned by already linked: " + player.owner.name);
            self.ownerShipString[i].color = (1, 0, 0);
          } else {
            linked_players = array_add(linked_players, player.owner);
          }

          if(player == self) {
            self.ownerShipString[i] SetDevText(player.name + " is the commander, but is owned by: " + player.owner.name);
            self.ownerShipString[i].color = (1, 0, 0);
          } else if(player.owner == player) {
            self.ownerShipString[i] SetDevText(player.name + " owned by self!");
            self.ownerShipString[i].color = (1, 0, 0);
          } else if(player.owner == self) {
            self.ownerShipString[i] SetDevText(player.name + " owned by commander: " + player.owner.name);
            self.ownerShipString[i].color = (0, 1, 0);
          } else {
            self.ownerShipString[i] SetDevText(player.name + " owned by " + player.owner.name);
            self.ownerShipString[i].color = (1, 1, 1);
          }
        } else {
          if(isDefined(player.bot_fireteam_follower)) {
            no_line = true;
          } else {
            self.ownerShipString[i] SetDevText(player.name + " unowned!");
            self.ownerShipString[i].color = (1, 1, 0);
          }
        }
      } else {
        no_line = true;
      }
      if(!no_line) {
        i++;
      }
    }
    wait(0.1);
  }
}

commander_wait_connect() {
  while(1) {
    foreach(player in level.players) {
      if(!IsAI(player) && !isDefined(player.fireteam_connected)) {
        player.fireteam_connected = true;
        player SetClientOmnvar("ui_options_menu", 0);

        player.classCallback = ::commander_loadout_class_callback;

        teamChoice = "allies";
        if(!isDefined(player.team)) {
          if(level.teamcount["axis"] < level.teamcount["allies"]) {
            teamChoice = "axis";
          } else if(level.teamcount["allies"] < level.teamcount["axis"]) {
            teamChoice = "allies";
          }
        }
        player maps\mp\gametypes\_menus::addToTeam(teamChoice);
        level.fireteam_commander[player.team] = player;

        player maps\mp\gametypes\_menus::bypassClassChoice();
        player.class_num = 0;
        player.waitingToSelectClass = false;

        player thread onFirstSpawnedPlayer();
        player thread commander_monitor_tactics();

      }
    }
    wait(0.05);
  }
}

onFirstSpawnedPlayer() {
  self endon("disconnect");

  for(;;) {
    if(self.team != "spectator" && self.sessionstate == "spectator") {
      self thread commander_initialize_gametype();

      self thread wait_commander_takeover_bot();
      self thread commander_spectate_first_available_bot();

      return;
    }
    wait(0.05);
  }
}

commander_spectate_first_available_bot() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("spectating_cycle");

  while(1) {
    foreach(player in level.players) {
      if(isbot(player) && player.team == self.team) {
        self thread commander_spectate_bot(player);
        player thread commander_hint();
        return;
      }
    }
    wait(0.1);
  }
}

monitor_enter_commander_mode() {
  self endon("disconnect");
  self endon("joined_spectators");

  while(1) {
    self waittill("commander_mode");

    bUsingKillstreak = self maps\mp\killstreaks\_killstreaks::is_using_killstreak();
    bUsingDeployableBox = self maps\mp\killstreaks\_deployablebox::isHoldingDeployableBox();

    if(!IsAlive(self) || bUsingKillstreak || bUsingDeployableBox) {
      continue;
    }
    break;
  }

  if(self.team == "spectator") {
    assertex(0, "Fireteam: Player tried to go into commander mode when already a spectator!");
    return;
  }

  self thread wait_commander_takeover_bot();

  self PlayLocalSound("mp_card_slide");

  foundBotReplacement = false;
  foreach(otherPlayer in level.players) {
    if(isDefined(otherPlayer) && otherPlayer != self && IsBot(otherPlayer) && isDefined(otherPlayer.team) && otherPlayer.team == self.team && isDefined(otherPlayer.sidelinedByCommander) && otherPlayer.sidelinedByCommander == true) {
      otherPlayer thread spectator_takeover_other(self);
      foundBotReplacement = true;
      break;
    }
  }
  if(!foundBotReplacement) {
    assertex(0, "Fireteam: Player could not find a bot to take over for him in spectator mode!");
    self thread maps\mp\gametypes\_playerlogic::spawnSpectator();
  }
}

commander_can_takeover_bot(bot) {
  if(!isDefined(bot)) {
    return false;
  }

  if(!IsBot(bot)) {
    return false;
  }

  if(!IsAlive(bot)) {
    return false;
  }

  if(!bot.connected) {
    return false;
  }

  if(bot.team != self.team) {
    return false;
  }

  botUsingKillstreak = bot maps\mp\killstreaks\_killstreaks::is_using_killstreak();
  if(botUsingKillstreak) {
    return false;
  }

  botUsingDeployableBox = self maps\mp\killstreaks\_deployablebox::isHoldingDeployableBox();
  if(botUsingDeployableBox) {
    return false;
  }

  return true;
}

player_get_player_index() {
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] == self) {
      return i;
    }
  }
  return -1;
}

commander_spectate_next_bot(searchBackwards) {
  currentBot = self GetSpectatingPlayer();
  newBot = undefined;
  start = 0;
  search_direction = 1;

  if(isDefined(searchBackwards) && searchBackwards == true) {
    search_direction = -1;
  }

  if(isDefined(currentBot)) {
    start = currentBot player_get_player_index();
  }

  num_checked = 1;
  for(i = start + search_direction; num_checked < level.players.size; i += search_direction) {
    num_checked++;
    if(i < 0) {
      i = level.players.size - 1;
    } else if(i >= level.players.size) {
      i = 0;
    }

    if(!isDefined(level.players[i])) {
      continue;
    }
    if(isDefined(currentBot) && level.players[i] == currentBot) {
      break;
    }

    canCommandeerBot = self commander_can_takeover_bot(level.players[i]);
    if(canCommandeerBot) {
      newBot = level.players[i];
      break;
    }
  }

  if(isDefined(newBot) && (!isDefined(currentBot) || newBot != currentBot)) {
    self thread commander_spectate_bot(newBot);
    self PlayLocalSound("oldschool_return");
    newBot thread takeover_flash();

    if(isDefined(currentBot)) {
      currentBot bot_free_to_move();
    }
  } else {
    self PlayLocalSound("counter_uav_deactivate");
  }
}

commander_spectate_bot(bot) {
  self notify("commander_spectate_bot");

  self endon("commander_spectate_bot");
  self endon("commander_spectate_stop");
  self endon("disconnect");

  while(isDefined(bot)) {
    if(!self.spectatekillcam && bot.sessionstate == "playing") {
      botNum = bot GetEntityNumber();
      if(self.forcespectatorclient != botNum) {
        self allowSpectateTeam("none", false);
        self allowSpectateTeam("freelook", false);
        self.forcespectatorclient = botNum;
        self.forcespectatorent = bot;

        self maps\mp\killstreaks\_killstreaks::copy_killstreak_status(bot, true);
      } else if(!isDefined(self.adrenaline) || (isDefined(bot.adrenaline) && self.adrenaline != bot.adrenaline)) {
        self maps\mp\killstreaks\_killstreaks::copy_adrenaline(bot);
      }
    }
    wait(0.05);
  }
}

get_spectated_player() {
  spectatedPlayer = undefined;
  if(isDefined(self.forcespectatorent)) {
    spectatedPlayer = self.forcespectatorent;
  } else {
    spectatedPlayer = self GetSpectatingPlayer();
  }
  return spectatedPlayer;
}

commander_takeover_first_available_bot() {
  self endon("disconnect");
  self endon("joined_team");
  self endon("spectating_cycle");

  while(1) {
    foreach(player in level.players) {
      if(isbot(player) && player.team == self.team) {
        self spectator_takeover_other(player);
        return;
      }
    }
    wait(0.1);
  }
}

spectator_takeover_other(other) {
  self.forceSpawnOrigin = other.origin;
  viewAngles = other GetPlayerAngles();
  viewAngles = (viewAngles[0], viewAngles[1], 0.0);
  self.forceSpawnAngles = (0, other.angles[1], 0);

  self SetStance(other GetStance());

  self.botLastLoadout = other.botLastLoadout;
  self.bot_class = other.bot_class;
  self commander_or_bot_change_class(self.bot_class);

  self.health = other.health;

  self.velocity = other.velocity;

  self store_weapons_status(other);
  other maps\mp\gametypes\_weapons::transfer_grenade_ownership(self);

  other thread maps\mp\gametypes\_playerlogic::spawnSpectator();
  if(IsBot(other)) {
    other.sidelinedByCommander = true;

    other bot_free_to_move();
    self PlayerCommandBot(other);
    self notify("commander_spectate_stop");
    other notify("commander_took_over");
  } else {}

  self thread maps\mp\gametypes\_playerlogic::spawnClient();
  self SetPlayerAngles(viewAngles);

  self apply_weapons_status();
  self maps\mp\killstreaks\_killstreaks::copy_killstreak_status(other);

  BotSentientSwap(self, other);

  if(IsBot(self)) {
    other thread commander_spectate_bot(self);
    other PlayerCommandBot(undefined);

    self.sidelinedByCommander = false;
    other PlayLocalSound("counter_uav_activate");
    self thread takeover_flash();
    other.commanding_bot = undefined;

    other.last_commanded_bot = self;

    self bot_wait_here();
  } else {
    self thread monitor_enter_commander_mode();
    self playSound("copycat_steal_class");
    self thread takeover_flash();
    self.commanding_bot = other;

    self.last_commanded_bot = undefined;
    if(!isDefined(self.commander_gave_hint)) {
      self thread commander_hint();
    }
  }
}

takeover_flash() {
  if(!isDefined(self.takeoverFlashOverlay)) {
    self.takeoverFlashOverlay = newClientHudElem(self);
    self.takeoverFlashOverlay.x = 0;
    self.takeoverFlashOverlay.y = 0;
    self.takeoverFlashOverlay.alignX = "left";
    self.takeoverFlashOverlay.alignY = "top";
    self.takeoverFlashOverlay.horzAlign = "fullscreen";
    self.takeoverFlashOverlay.vertAlign = "fullscreen";
    self.takeoverFlashOverlay setshader("combathigh_overlay", 640, 480);
    self.takeoverFlashOverlay.sort = -10;
    self.takeoverFlashOverlay.archived = true;
  }

  self.takeoverFlashOverlay.alpha = 0.0;
  self.takeoverFlashOverlay fadeOverTime(0.25);
  self.takeoverFlashOverlay.alpha = 1.0;

  wait(0.75);

  self.takeoverFlashOverlay fadeOverTime(0.5);
  self.takeoverFlashOverlay.alpha = 0.0;
}

wait_commander_takeover_bot() {
  self endon("disconnect");
  self endon("joined_team");

  self notify("takeover_wait_start");
  self endon("takeover_wait_start");

  while(1) {
    self waittill("takeover_bot");

    spectatedPlayer = get_spectated_player();

    canCommandeerBot = self commander_can_takeover_bot(spectatedPlayer);
    if(!canCommandeerBot) {
      self commander_spectate_next_bot(false);
      spectatedPlayer = get_spectated_player();
      canCommandeerBot = self commander_can_takeover_bot(spectatedPlayer);
    }

    if(canCommandeerBot) {
      self thread spectator_takeover_other(spectatedPlayer);
      break;
    }
    self PlayLocalSound("counter_uav_deactivate");
  }
}

bot_wait_here() {
  if(!isDefined(self) || !IsPlayer(self) || !IsBot(self)) {
    return;
  }
  self notify("wait_here");

  self BotSetFlag("disable_movement", true);

  self.badplacename = "bot_waiting_" + self.team + "_" + self.name;
  BadPlace_Cylinder(self.badplacename, 5, self.origin, 32, 72, self.team);

  self thread bot_delete_badplace_on_death();
  self thread bot_wait_free_to_move();
}

bot_delete_badplace_on_death(bot) {
  self endon("freed_to_move");
  self endon("disconnect");

  self waittill("death");

  self bot_free_to_move();
}

bot_wait_free_to_move() {
  self endon("wait_here");

  wait(5);

  self thread bot_free_to_move();
}

bot_free_to_move() {
  if(!isDefined(self) || !IsPlayer(self) || !IsBot(self)) {
    return;
  }
  self BotSetFlag("disable_movement", false);

  if(isDefined(self.badplacename)) {
    BadPlace_Delete(self.badplacename);
  }

  self notify("freed_to_move");
}

commander_loadout_class_callback(bot) {
  return self.botLastLoadout;
}

commander_or_bot_change_class(newClass) {
  self.pers["class"] = newClass;
  self.class = newClass;

  self maps\mp\gametypes\_class::setClass(newClass);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
}

store_weapons_status(from) {
  self.copy_fullweaponlist = from GetWeaponsListAll();
  self.copy_weapon_current = from GetCurrentWeapon();

  foreach(weapon in self.copy_fullweaponlist) {
    self.copy_weapon_ammo_clip[weapon] = from GetWeaponAmmoClip(weapon);
    self.copy_weapon_ammo_stock[weapon] = from GetWeaponAmmoStock(weapon);
  }
}

apply_weapons_status() {
  foreach(weapon in self.copy_fullweaponlist) {
    if(!(self HasWeapon(weapon))) {
      self GiveWeapon(weapon);
    }
  }

  myWeapons = self GetWeaponsListAll();
  foreach(weapon in myWeapons) {
    if(!array_contains(self.copy_fullweaponlist, weapon)) {
      self TakeWeapon(weapon);
    }
  }

  foreach(weapon in self.copy_fullweaponlist) {
    if(self HasWeapon(weapon)) {
      self SetWeaponAmmoClip(weapon, self.copy_weapon_ammo_clip[weapon]);
      self SetWeaponAmmoStock(weapon, self.copy_weapon_ammo_stock[weapon]);
    } else {
      Assert(0 && "tried to set copy ammo on a weapon we didn't copy: " + weapon + "!");
    }
  }

  if(self GetCurrentWeapon() != self.copy_weapon_current) {
    self SwitchToWeapon(self.copy_weapon_current);
  }
}
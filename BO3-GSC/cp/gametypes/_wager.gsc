/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_wager.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\cp\gametypes\_loadout;
#using scripts\cp\teams\_teams;
#using scripts\shared\callbacks_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;
#namespace wager;

function autoexec __init__sytem__() {
  system::register("wager", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & init);
}

function init() {
  if(gamemodeismode(3)) {
    level.wagermatch = 1;
    if(!isDefined(game["wager_pot"])) {
      game["wager_pot"] = 0;
      game["wager_initial_pot"] = 0;
    }
    game["dialog"]["wm_u2_online"] = "boost_gen_02";
    game["dialog"]["wm_in_the_money"] = "boost_gen_06";
    game["dialog"]["wm_oot_money"] = "boost_gen_07";
    level.poweruplist = [];
    callback::on_disconnect( & on_disconnect);
    callback::on_spawned( & init_player);
    level thread help_game_end();
  } else {
    level.wagermatch = 0;
  }
  level.takelivesondeath = 1;
}

function init_player() {
  self endon("disconnect");
  if(!isDefined(self.pers["wager"])) {
    self.pers["wager"] = 1;
    self.pers["wager_sideBetWinnings"] = 0;
    self.pers["wager_sideBetLosses"] = 0;
  }
  if(isDefined(level.inthemoneyonradar) && level.inthemoneyonradar || (isDefined(level.firstplaceonradar) && level.firstplaceonradar)) {
    self.pers["hasRadar"] = 1;
    self.hasspyplane = 1;
  } else {
    self.pers["hasRadar"] = 0;
    self.hasspyplane = 0;
  }
  self thread deduct_player_ante();
}

function on_disconnect() {
  level endon("game_ended");
  self endon("player_eliminated");
  level notify("player_eliminated");
}

function deduct_player_ante() {
  if(isDefined(self.pers["hasPaidWagerAnte"])) {
    return;
  }
  waittillframeend();
  codpoints = self rank::getcodpointsstat();
  wagerbet = getdvarint("scr_wagerBet");
  if(wagerbet > codpoints) {
    wagerbet = codpoints;
  }
  codpoints = codpoints - wagerbet;
  self rank::setcodpointsstat(codpoints);
  if(!self islocaltohost()) {
    self increment_escrow_for_player(wagerbet);
  }
  game["wager_pot"] = game["wager_pot"] + wagerbet;
  game["wager_initial_pot"] = game["wager_initial_pot"] + wagerbet;
  self.pers["hasPaidWagerAnte"] = 1;
  self addplayerstat("LIFETIME_BUYIN", wagerbet);
  self add_recent_earnings_to_stat(0 - wagerbet);
  if(isDefined(level.onwagerplayerante)) {
    [[level.onwagerplayerante]](self, wagerbet);
  }
  self thread persistence::upload_stats_soon();
}

function increment_escrow_for_player(amount) {
  if(!isDefined(self) || !isplayer(self)) {
    return;
  }
  if(!isDefined(game["escrows"])) {
    game["escrows"] = [];
  }
  playerxuid = self getxuid();
  if(!isDefined(playerxuid)) {
    return;
  }
  escrowstruct = spawnStruct();
  escrowstruct.xuid = playerxuid;
  escrowstruct.amount = amount;
  game["escrows"][game["escrows"].size] = escrowstruct;
}

function clear_escrows() {
  if(!isDefined(game["escrows"])) {
    return;
  }
  escrows = game["escrows"];
  numescrows = escrows.size;
  for(i = 0; i < numescrows; i++) {
    escrowstruct = escrows[i];
  }
  game["escrows"] = [];
}

function add_recent_earnings_to_stat(recentearnings) {
  currearnings = self persistence::get_recent_stat(1, 0, "score");
  self persistence::set_recent_stat(1, 0, "score", currearnings + recentearnings);
}

function prematch_period() {
  if(!level.wagermatch) {
    return;
  }
}

function finalize_round() {
  if(level.wagermatch == 0) {
    return;
  }
  determine_winnings();
  if(isDefined(level.onwagerfinalizeround)) {
    [[level.onwagerfinalizeround]]();
  }
}

function determine_winnings() {
  shouldcalculatewinnings = !isDefined(level.dontcalcwagerwinnings) || !level.dontcalcwagerwinnings;
  if(!shouldcalculatewinnings) {
    return;
  }
  if(!level.teambased) {
    calculate_free_for_all_payouts();
  } else {
    calculate_team_payouts();
  }
}

function calculate_free_for_all_payouts() {
  playerrankings = level.placement["all"];
  payoutpercentages = array(0.5, 0.3, 0.2);
  if(playerrankings.size == 2) {
    payoutpercentages = array(0.7, 0.3);
  } else if(playerrankings.size == 1) {
    payoutpercentages = array(1);
  }
  set_winnings_on_players(level.players, 0);
  if(isDefined(level.hostforcedend) && level.hostforcedend) {
    wagerbet = getdvarint("scr_wagerBet");
    for(i = 0; i < playerrankings.size; i++) {
      if(!playerrankings[i] islocaltohost()) {
        playerrankings[i].wagerwinnings = wagerbet;
      }
    }
  } else {
    if(level.players.size == 1) {
      game["escrows"] = undefined;
      return;
    }
    currentpayoutpercentage = 0;
    cumulativepayoutpercentage = payoutpercentages[0];
    playergroup = [];
    playergroup[playergroup.size] = playerrankings[0];
    for(i = 1; i < playerrankings.size; i++) {
      if(playerrankings[i].pers["score"] < playergroup[0].pers["score"]) {
        set_winnings_on_players(playergroup, int((game["wager_pot"] * cumulativepayoutpercentage) / playergroup.size));
        playergroup = [];
        cumulativepayoutpercentage = 0;
      }
      playergroup[playergroup.size] = playerrankings[i];
      currentpayoutpercentage++;
      if(isDefined(payoutpercentages[currentpayoutpercentage])) {
        cumulativepayoutpercentage = cumulativepayoutpercentage + payoutpercentages[currentpayoutpercentage];
      }
    }
    set_winnings_on_players(playergroup, int((game["wager_pot"] * cumulativepayoutpercentage) / playergroup.size));
  }
}

function calculate_places_based_on_score() {
  level.playerplaces = array([], [], []);
  playerrankings = level.placement["all"];
  placementscores = array(playerrankings[0].pers["score"], -1, -1);
  currentplace = 0;
  for(index = 0; index < playerrankings.size && currentplace < placementscores.size; index++) {
    player = playerrankings[index];
    if(player.pers["score"] < placementscores[currentplace]) {
      currentplace++;
      if(currentplace >= level.playerplaces.size) {
        break;
      }
      placementscores[currentplace] = player.pers["score"];
    }
    level.playerplaces[currentplace][level.playerplaces[currentplace].size] = player;
  }
}

function calculate_team_payouts() {
  winner = globallogic::determineteamwinnerbygamestat("teamScores");
  if(winner == "tie") {
    calculate_free_for_all_payouts();
    return;
  }
  playersonwinningteam = [];
  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];
    player.wagerwinnings = 0;
    if(player.pers["team"] == winner) {
      playersonwinningteam[playersonwinningteam.size] = player;
    }
  }
  if(playersonwinningteam.size == 0) {
    set_winnings_on_players(level.players, getdvarint("scr_wagerBet"));
    return;
  }
  winningssplit = int(game["wager_pot"] / playersonwinningteam.size);
  set_winnings_on_players(playersonwinningteam, winningssplit);
}

function set_winnings_on_players(players, amount) {
  for(index = 0; index < players.size; index++) {
    players[index].wagerwinnings = amount;
  }
}

function finalize_game() {
  level.wagergamefinalized = 1;
  if(level.wagermatch == 0) {
    return;
  }
  determine_winnings();
  determine_top_earners();
  players = level.players;
  wait(0.5);
  playerrankings = level.wagertopearners;
  for(index = 0; index < players.size; index++) {
    player = players[index];
    if(isDefined(player.pers["wager_sideBetWinnings"])) {
      pay_out_winnings(player, player.wagerwinnings + player.pers["wager_sideBetWinnings"]);
    } else {
      pay_out_winnings(player, player.wagerwinnings);
    }
    if(player.wagerwinnings > 0) {
      globallogic_score::updatewinstats(player);
    }
  }
  clear_escrows();
}

function pay_out_winnings(player, winnings) {
  if(winnings == 0) {
    return;
  }
  codpoints = player rank::getcodpointsstat();
  player rank::setcodpointsstat(codpoints + winnings);
  player addplayerstat("LIFETIME_EARNINGS", winnings);
  player add_recent_earnings_to_stat(winnings);
}

function determine_top_earners() {
  topwinnings = array(-1, -1, -1);
  level.wagertopearners = [];
  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];
    if(!isDefined(player.wagerwinnings)) {
      player.wagerwinnings = 0;
    }
    if(player.wagerwinnings > topwinnings[0]) {
      topwinnings[2] = topwinnings[1];
      topwinnings[1] = topwinnings[0];
      topwinnings[0] = player.wagerwinnings;
      level.wagertopearners[2] = level.wagertopearners[1];
      level.wagertopearners[1] = level.wagertopearners[0];
      level.wagertopearners[0] = player;
      continue;
    }
    if(player.wagerwinnings > topwinnings[1]) {
      topwinnings[2] = topwinnings[1];
      topwinnings[1] = player.wagerwinnings;
      level.wagertopearners[2] = level.wagertopearners[1];
      level.wagertopearners[1] = player;
      continue;
    }
    if(player.wagerwinnings > topwinnings[2]) {
      topwinnings[2] = player.wagerwinnings;
      level.wagertopearners[2] = player;
    }
  }
}

function post_round_side_bet() {
  if(isDefined(level.sidebet) && level.sidebet) {
    level notify("side_bet_begin");
    level waittill("side_bet_end");
  }
}

function side_bet_timer() {
  level endon("side_bet_end");
  secondstowait = (level.sidebetendtime - gettime()) / 1000;
  if(secondstowait < 0) {
    secondstowait = 0;
  }
  wait(secondstowait);
  level notify("side_bet_end");
}

function side_bet_all_bets_placed() {
  secondsleft = (level.sidebetendtime - gettime()) / 1000;
  if(secondsleft <= 3) {
    return;
  }
  level.sidebetendtime = gettime() + 3000;
  wait(3);
  level notify("side_bet_end");
}

function setup_blank_random_player(takeweapons, chooserandombody, weapon) {
  if(!isDefined(chooserandombody) || chooserandombody) {
    if(!isDefined(self.pers["wagerBodyAssigned"])) {
      self assign_random_body();
      self.pers["wagerBodyAssigned"] = 1;
    }
    self teams::set_player_model(self.team, weapon);
  }
  self clearperks();
  self.killstreak = [];
  self.pers["killstreaks"] = [];
  self.pers["killstreak_has_been_used"] = [];
  self.pers["killstreak_unique_id"] = [];
  if(!isDefined(takeweapons) || takeweapons) {
    self takeallweapons();
  }
  if(isDefined(self.pers["hasRadar"]) && self.pers["hasRadar"]) {
    self.hasspyplane = 1;
  }
  if(isDefined(self.powerups) && isDefined(self.powerups.size)) {
    for(i = 0; i < self.powerups.size; i++) {
      self apply_powerup(self.powerups[i]);
    }
  }
  self set_radar_visibility();
}

function assign_random_body() {}

function queue_popup(message, points, submessage, announcement) {
  self endon("disconnect");
  size = self.wagernotifyqueue.size;
  self.wagernotifyqueue[size] = spawnStruct();
  self.wagernotifyqueue[size].message = message;
  self.wagernotifyqueue[size].points = points;
  self.wagernotifyqueue[size].submessage = submessage;
  self.wagernotifyqueue[size].announcement = announcement;
  self notify("hash_2528173");
}

function help_game_end() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_eliminated");
    if(!isDefined(level.numlives) || !level.numlives) {
      continue;
    }
    wait(0.05);
    players = level.players;
    playersleft = 0;
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].pers["lives"]) && players[i].pers["lives"] > 0) {
        playersleft++;
      }
    }
    if(playersleft == 2) {
      for(i = 0; i < players.size; i++) {
        players[i] queue_popup(&"MP_HEADS_UP", 0, & "MP_U2_ONLINE", "wm_u2_online");
        players[i].pers["hasRadar"] = 1;
        players[i].hasspyplane = 1;
        level.activeuavs[players[i] getentitynumber()]++;
      }
    }
  }
}

function set_radar_visibility() {
  prevscoreplace = self.prevscoreplace;
  if(!isDefined(prevscoreplace)) {
    prevscoreplace = 1;
  }
  if(isDefined(level.inthemoneyonradar) && level.inthemoneyonradar) {
    if(prevscoreplace <= 3 && isDefined(self.score) && self.score > 0) {
      self unsetperk("specialty_gpsjammer");
    } else {
      self setperk("specialty_gpsjammer");
    }
  } else if(isDefined(level.firstplaceonradar) && level.firstplaceonradar) {
    if(prevscoreplace == 1 && isDefined(self.score) && self.score > 0) {
      self unsetperk("specialty_gpsjammer");
    } else {
      self setperk("specialty_gpsjammer");
    }
  }
}

function player_scored() {
  self notify("wager_player_scored");
  self endon("wager_player_scored");
  wait(0.05);
  globallogic::updateplacement();
  for(i = 0; i < level.placement["all"].size; i++) {
    prevscoreplace = level.placement["all"][i].prevscoreplace;
    if(!isDefined(prevscoreplace)) {
      prevscoreplace = 1;
    }
    currentscoreplace = i + 1;
    for(j = i - 1; j >= 0; j--) {
      if(level.placement["all"][i].score == level.placement["all"][j].score) {
        currentscoreplace--;
      }
    }
    wasinthemoney = prevscoreplace <= 3;
    isinthemoney = currentscoreplace <= 3;
    if(!wasinthemoney && isinthemoney) {
      level.placement["all"][i] announcer("wm_in_the_money");
    } else if(wasinthemoney && !isinthemoney) {
      level.placement["all"][i] announcer("wm_oot_money");
    }
    level.placement["all"][i].prevscoreplace = currentscoreplace;
    level.placement["all"][i] set_radar_visibility();
  }
}

function announcer(dialog, group) {}

function create_powerup(name, type, displayname, iconmaterial) {
  powerup = spawnStruct();
  powerup.name = [];
  powerup.name[0] = name;
  powerup.type = type;
  powerup.displayname = displayname;
  powerup.iconmaterial = iconmaterial;
  return powerup;
}

function add_powerup(name, type, displayname, iconmaterial) {
  if(!isDefined(level.poweruplist)) {
    level.poweruplist = [];
  }
  for(i = 0; i < level.poweruplist.size; i++) {
    if(level.poweruplist[i].displayname == displayname) {
      level.poweruplist[i].name[level.poweruplist[i].name.size] = name;
      return;
    }
  }
  powerup = create_powerup(name, type, displayname, iconmaterial);
  level.poweruplist[level.poweruplist.size] = powerup;
}

function copy_powerup(powerup) {
  return create_powerup(powerup.name[0], powerup.type, powerup.displayname, powerup.iconmaterial);
}

function apply_powerup(powerup) {
  weapon = level.weaponnone;
  switch (powerup.type) {
    case "equipment":
    case "primary":
    case "primary_grenade":
    case "secondary":
    case "secondary_grenade": {
      weapon = getweapon(powerup.name[0]);
      break;
    }
  }
  switch (powerup.type) {
    case "primary": {
      self giveweapon(weapon);
      self switchtoweapon(weapon);
      break;
    }
    case "secondary": {
      self giveweapon(weapon);
      break;
    }
    case "equipment": {
      self giveweapon(weapon);
      self loadout::setweaponammooverall(weapon, 1);
      self setactionslot(1, "weapon", weapon);
      break;
    }
    case "primary_grenade": {
      self setoffhandprimaryclass(weapon);
      self giveweapon(weapon);
      self setweaponammoclip(weapon, 2);
      break;
    }
    case "secondary_grenade": {
      self setoffhandsecondaryclass(weapon);
      self giveweapon(weapon);
      self setweaponammoclip(weapon, 2);
      break;
    }
    case "perk": {
      for(i = 0; i < powerup.name.size; i++) {
        self setperk(powerup.name[i]);
      }
      break;
    }
    case "score_multiplier": {
      self.scoremultiplier = powerup.name[0];
      break;
    }
  }
}

function give_powerup(powerup, doanimation) {
  if(!isDefined(self.powerups)) {
    self.powerups = [];
  }
  powerupindex = self.powerups.size;
  self.powerups[powerupindex] = copy_powerup(powerup);
  for(i = 0; i < powerup.name.size; i++) {
    self.powerups[powerupindex].name[self.powerups[powerupindex].name.size] = powerup.name[i];
  }
  self apply_powerup(self.powerups[powerupindex]);
  self thread show_powerup_message(powerupindex, doanimation);
}

function pulse_powerup_icon(powerupindex) {
  if(!isDefined(self) || !isDefined(self.powerups) || !isDefined(self.powerups[powerupindex]) || !isDefined(self.powerups[powerupindex].hud_elem_icon)) {
    return;
  }
  self endon("disconnect");
  self endon("delete");
  self endon("clearing_powerups");
  pulsepercent = 1.5;
  pulsetime = 0.5;
  hud_elem = self.powerups[powerupindex].hud_elem_icon;
  if(isDefined(hud_elem.animating) && hud_elem.animating) {
    return;
  }
  origx = hud_elem.x;
  origy = hud_elem.y;
  origwidth = hud_elem.width;
  origheight = hud_elem.height;
  bigwidth = origwidth * pulsepercent;
  bigheight = origheight * pulsepercent;
  xoffset = (bigwidth - origwidth) / 2;
  yoffset = (bigheight - origheight) / 2;
  hud_elem scaleovertime(0.05, int(bigwidth), int(bigheight));
  hud_elem moveovertime(0.05);
  hud_elem.x = origx - xoffset;
  hud_elem.y = origy - yoffset;
  wait(0.05);
  hud_elem scaleovertime(pulsetime, origwidth, origheight);
  hud_elem moveovertime(pulsetime);
  hud_elem.x = origx;
  hud_elem.y = origy;
}

function show_powerup_message(powerupindex, doanimation) {
  self endon("disconnect");
  self endon("delete");
  self endon("clearing_powerups");
  if(!isDefined(doanimation)) {
    doanimation = 1;
  }
  wasinprematch = level.inprematchperiod;
  powerupstarty = 320;
  powerupspacing = 40;
  if(self issplitscreen()) {
    powerupstarty = 120;
    powerupspacing = 35;
  }
  if(isDefined(self.powerups[powerupindex].hud_elem)) {
    self.powerups[powerupindex].hud_elem destroy();
  }
  self.powerups[powerupindex].hud_elem = newclienthudelem(self);
  self.powerups[powerupindex].hud_elem.fontscale = 1.5;
  self.powerups[powerupindex].hud_elem.x = -125;
  self.powerups[powerupindex].hud_elem.y = powerupstarty - (powerupspacing * powerupindex);
  self.powerups[powerupindex].hud_elem.alignx = "left";
  self.powerups[powerupindex].hud_elem.aligny = "middle";
  self.powerups[powerupindex].hud_elem.horzalign = "user_right";
  self.powerups[powerupindex].hud_elem.vertalign = "user_top";
  self.powerups[powerupindex].hud_elem.color = (1, 1, 1);
  self.powerups[powerupindex].hud_elem.foreground = 1;
  self.powerups[powerupindex].hud_elem.hidewhendead = 0;
  self.powerups[powerupindex].hud_elem.hidewheninmenu = 1;
  self.powerups[powerupindex].hud_elem.archived = 0;
  self.powerups[powerupindex].hud_elem.alpha = 0;
  self.powerups[powerupindex].hud_elem settext(self.powerups[powerupindex].displayname);
  bigiconsize = 40;
  iconsize = 32;
  if(isDefined(self.powerups[powerupindex].hud_elem_icon)) {
    self.powerups[powerupindex].hud_elem_icon destroy();
  }
  if(doanimation) {
    self.powerups[powerupindex].hud_elem_icon = self hud::createicon(self.powerups[powerupindex].iconmaterial, bigiconsize, bigiconsize);
    self.powerups[powerupindex].hud_elem_icon.animating = 1;
  } else {
    self.powerups[powerupindex].hud_elem_icon = self hud::createicon(self.powerups[powerupindex].iconmaterial, iconsize, iconsize);
  }
  self.powerups[powerupindex].hud_elem_icon.x = (self.powerups[powerupindex].hud_elem.x - 5) - (iconsize / 2) - (bigiconsize / 2);
  self.powerups[powerupindex].hud_elem_icon.y = (powerupstarty - (powerupspacing * powerupindex)) - (bigiconsize / 2);
  self.powerups[powerupindex].hud_elem_icon.horzalign = "user_right";
  self.powerups[powerupindex].hud_elem_icon.vertalign = "user_top";
  self.powerups[powerupindex].hud_elem_icon.color = (1, 1, 1);
  self.powerups[powerupindex].hud_elem_icon.foreground = 1;
  self.powerups[powerupindex].hud_elem_icon.hidewhendead = 0;
  self.powerups[powerupindex].hud_elem_icon.hidewheninmenu = 1;
  self.powerups[powerupindex].hud_elem_icon.archived = 0;
  self.powerups[powerupindex].hud_elem_icon.alpha = 1;
  if(!wasinprematch && doanimation) {
    self thread queue_popup(self.powerups[powerupindex].displayname, 0, & "MP_BONUS_ACQUIRED");
  }
  pulsetime = 0.5;
  if(doanimation) {
    self.powerups[powerupindex].hud_elem fadeovertime(pulsetime);
    self.powerups[powerupindex].hud_elem_icon scaleovertime(pulsetime, iconsize, iconsize);
    self.powerups[powerupindex].hud_elem_icon.width = iconsize;
    self.powerups[powerupindex].hud_elem_icon.height = iconsize;
    self.powerups[powerupindex].hud_elem_icon moveovertime(pulsetime);
  }
  self.powerups[powerupindex].hud_elem.alpha = 1;
  self.powerups[powerupindex].hud_elem_icon.x = (self.powerups[powerupindex].hud_elem.x - 5) - iconsize;
  self.powerups[powerupindex].hud_elem_icon.y = (powerupstarty - (powerupspacing * powerupindex)) - (iconsize / 2);
  if(doanimation) {
    wait(pulsetime);
  }
  if(level.inprematchperiod) {
    level waittill("prematch_over");
  } else if(doanimation) {
    wait(pulsetime);
  }
  if(wasinprematch && doanimation) {
    self thread queue_popup(self.powerups[powerupindex].displayname, 0, & "MP_BONUS_ACQUIRED");
  }
  wait(1.5);
  for(i = 0; i <= powerupindex; i++) {
    self.powerups[i].hud_elem fadeovertime(0.25);
    self.powerups[i].hud_elem.alpha = 0;
  }
  wait(0.25);
  for(i = 0; i <= powerupindex; i++) {
    self.powerups[i].hud_elem_icon moveovertime(0.25);
    self.powerups[i].hud_elem_icon.x = 0 - iconsize;
    self.powerups[i].hud_elem_icon.horzalign = "user_right";
  }
  self.powerups[powerupindex].hud_elem_icon.animating = 0;
}

function clear_powerups() {
  self notify("clearing_powerups");
  if(isDefined(self.powerups) && isDefined(self.powerups.size)) {
    for(i = 0; i < self.powerups.size; i++) {
      if(isDefined(self.powerups[i].hud_elem)) {
        self.powerups[i].hud_elem destroy();
      }
      if(isDefined(self.powerups[i].hud_elem_icon)) {
        self.powerups[i].hud_elem_icon destroy();
      }
    }
  }
  self.powerups = [];
}

function track_weapon_usage(name, incvalue, statname) {
  if(!isDefined(self.wagerweaponusage)) {
    self.wagerweaponusage = [];
  }
  if(!isDefined(self.wagerweaponusage[name])) {
    self.wagerweaponusage[name] = [];
  }
  if(!isDefined(self.wagerweaponusage[name][statname])) {
    self.wagerweaponusage[name][statname] = 0;
  }
  self.wagerweaponusage[name][statname] = self.wagerweaponusage[name][statname] + incvalue;
}

function get_highest_weapon_usage(statname) {
  if(!isDefined(self.wagerweaponusage)) {
    return undefined;
  }
  bestweapon = undefined;
  highestvalue = 0;
  wagerweaponsused = getarraykeys(self.wagerweaponusage);
  for(i = 0; i < wagerweaponsused.size; i++) {
    weaponstats = self.wagerweaponusage[wagerweaponsused[i]];
    if(!isDefined(weaponstats[statname]) || !getbaseweaponitemindex(wagerweaponsused[i])) {
      continue;
      continue;
    }
    if(!isDefined(bestweapon) || weaponstats[statname] > highestvalue) {
      bestweapon = wagerweaponsused[i];
      highestvalue = weaponstats[statname];
    }
  }
  return bestweapon;
}

function set_after_action_report_stats() {
  topweapon = self get_highest_weapon_usage("kills");
  topkills = 0;
  if(isDefined(topweapon)) {
    topkills = self.wagerweaponusage[topweapon]["kills"];
  } else {
    topweapon = self get_highest_weapon_usage("timeUsed");
  }
  if(!isDefined(topweapon)) {
    topweapon = "";
  }
  self persistence::set_after_action_report_stat("topWeaponItemIndex", getbaseweaponitemindex(topweapon));
  self persistence::set_after_action_report_stat("topWeaponKills", topkills);
  if(isDefined(level.onwagerawards)) {
    self[[level.onwagerawards]]();
  } else {
    for(i = 0; i < 3; i++) {
      self persistence::set_after_action_report_stat("wagerAwards", 0, i);
    }
  }
}
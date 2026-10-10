/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bounty.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\points;
#namespace bounty;

function init() {
  level.bounty_index = [];
  level._effect["vfx_mo_money_cash_exp"] = loadfx("vfx/iw7/_requests/mp/vfx_mo_money_cash_exp.vfx");

  if(true) {
    thread onplayerconnect();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onplayerjoinedteam);
  }
}

function onplayerconnect() {
  while(true) {
    level waittill("connected", player);
    player bountyinit();
  }
}

function bountyinit() {
  if(!isDefined(self.bountypoints)) {
    playerregisterbountyindex();
    playerresetbountypoints();
    playerresetbountystreak();
  }
}

function onplayerdisconnect(player) {
  if(isDefined(player.bounty_index)) {
    level.bounty_index[player.bounty_index] = undefined;
  }
}

function onplayerjoinedspectators(player) {
  if(true) {
    if(isDefined(player.bounty_index)) {
      player playerresetbountypoints();
      player playerresetbountystreak();
    }
  }
}

function onplayerjoinedteam(player) {
  if(true) {
    if(isDefined(player.bounty_index)) {
      player playerresetbountypoints();
      player playerresetbountystreak();
    }
  }
}

function playerregisterbountyindex() {
  for(index = 0; isDefined(level.bounty_index[index]); index++) {}

  level.bounty_index[index] = self;
  self.bounty_index = index;
}

function playergetbountypoints() {
  assertex(isDefined(self.bountypoints), "<dev string:x1c>");
  return self.bountypoints;
}

function playersetbountypoints(bountypoints) {
  assertex(isDefined(self.bounty_index), "<dev string:x1c>");
  self.bountypoints = bountypoints;
  level.bounty_index[self.bounty_index] setbountycount(self.bountypoints);
}

function playerresetbountypoints(wait_time) {
  if(false) {
    return;
  }

  if(isDefined(wait_time)) {
    wait wait_time;
  }

  if(isDefined(self)) {
    playersetbountypoints(0);
  }
}

function playerresetbountystreak(wait_time) {
  if(false) {
    return;
  }

  if(isDefined(wait_time)) {
    wait wait_time;
  }

  if(isDefined(self)) {
    self.bountystreak = 0;
  }
}

function bountyincreasestreak(amount) {
  if(false) {
    return;
  }

  if(!isDefined(amount)) {
    amount = 1;
  }

  self.bountystreak += amount;
  bountyconvert();
}

function bountyconvert() {
  if(false) {
    return;
  }

  old_bounty = playergetbountypoints();
  new_bounty = int(floor(self.bountystreak / 3));

  if(new_bounty > old_bounty && new_bounty <= 5) {
    playersetbountypoints(new_bounty);
  }
}

function bountycollect(victim_bounty, victim_pos) {
  if(false) {
    return;
  }

  if(_hasperk("specialty_bounty")) {
    if(victim_bounty > 0) {
      for(i = 0; i < victim_bounty; i++) {
        thread doscoreevent(#"bounty");
        bountyincreasestreak();
        playFX(getfx("vfx_mo_money_cash_exp"), victim_pos + (0, 0, 45));
      }

      thread teamplayercardsplash("callout_bounty_collected", self);
    }
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bounty.gsc
***********************************************/

function init() {
  level.bounty_index = [];
  level._effect["vfx_mo_money_cash_exp"] = loadfx("vfx/iw7/_requests/mp/vfx_mo_money_cash_exp.vfx");

  if(true) {
    thread onplayerconnect();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onplayerjoinedteam);
    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    bountyinit(var_0);
  }
}

function bountyinit() {
  if(!isDefined(self.bountypoints)) {
    playerregisterbountyindex();
    playerresetbountypoints();
    playerresetbountystreak();
    return;
  }
}

function onplayerdisconnect(var_0) {
  if(isDefined(var_0.bounty_index)) {
    level.bounty_index[var_0.bounty_index] = undefined;
    return;
  }
}

function onplayerjoinedspectators(var_0) {
  if(true) {
    if(isDefined(var_0.bounty_index)) {
      playerresetbountypoints(var_0);
      playerresetbountystreak(var_0);
      return;
    }

    return;
  }
}

function onplayerjoinedteam(var_0) {
  if(true) {
    if(isDefined(var_0.bounty_index)) {
      playerresetbountypoints(var_0);
      playerresetbountystreak(var_0);
      return;
    }

    return;
  }
}

function playerregisterbountyindex() {
  for(var_0 = 0; isDefined(level.bounty_index[var_0]); var_0++) {}

  level.bounty_index[var_0] = self;
  self.bounty_index = var_0;
}

function playergetbountypoints() {
  return self.bountypoints;
}

function playersetbountypoints(var_0) {
  self.bountypoints = var_0;
  level.bounty_index[self.bounty_index] setbountycount(self.bountypoints);
}

function playerresetbountypoints(var_0) {
  if(!1) {
    return;
  }

  if(isDefined(var_0)) {
    wait var_0;
  }

  if(isDefined(self)) {
    playersetbountypoints(0);
    return;
  }
}

function playerresetbountystreak(var_0) {
  if(!1) {
    return;
  }

  if(isDefined(var_0)) {
    wait var_0;
  }

  if(isDefined(self)) {
    self.bountystreak = 0;
    return;
  }
}

function bountyincreasestreak(var_0) {
  if(!1) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.bountystreak += var_0;
  bountyconvert();
}

function bountyconvert() {
  if(!1) {
    return;
  }

  var_0 = playergetbountypoints();
  var_1 = int(floor(self.bountystreak / 3));

  if(var_1 > var_0 && var_1 <= 5) {
    playersetbountypoints(var_1);
    return;
  }
}

function bountycollect(var_0, var_1) {
  if(!1) {
    return;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_bounty")) {
    if(var_0 > 0) {
      for(var_2 = 0; var_2 < var_0; var_2++) {
        thread scripts\mp\utility\points::giveunifiedpoints("bounty");
        bountyincreasestreak();
        playFX(scripts\engine\utility::getfx("vfx_mo_money_cash_exp"), var_1 + (0, 0, 45));
      }

      thread scripts\mp\hud_util::teamplayercardsplash("callout_bounty_collected", self);
      return;
    }

    return;
  }
}
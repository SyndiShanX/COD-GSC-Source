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
    level waittill("connected", var0);
    bountyinit(var0);
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

function onplayerdisconnect(var0) {
  if(isDefined(var0.bounty_index)) {
    level.bounty_index[var0.bounty_index] = undefined;
    return;
  }
}

function onplayerjoinedspectators(var0) {
  if(true) {
    if(isDefined(var0.bounty_index)) {
      playerresetbountypoints(var0);
      playerresetbountystreak(var0);
      return;
    }

    return;
  }
}

function onplayerjoinedteam(var0) {
  if(true) {
    if(isDefined(var0.bounty_index)) {
      playerresetbountypoints(var0);
      playerresetbountystreak(var0);
      return;
    }

    return;
  }
}

function playerregisterbountyindex() {
  for(var0 = 0; isDefined(level.bounty_index[var0]); var0++) {}

  level.bounty_index[var0] = self;
  self.bounty_index = var0;
}

function playergetbountypoints() {
  return self.bountypoints;
}

function playersetbountypoints(var0) {
  self.bountypoints = var0;
  level.bounty_index[self.bounty_index] setbountycount(self.bountypoints);
}

function playerresetbountypoints(var0) {
  if(!1) {
    return;
  }

  if(isDefined(var0)) {
    wait var0;
  }

  if(isDefined(self)) {
    playersetbountypoints(0);
    return;
  }
}

function playerresetbountystreak(var0) {
  if(!1) {
    return;
  }

  if(isDefined(var0)) {
    wait var0;
  }

  if(isDefined(self)) {
    self.bountystreak = 0;
    return;
  }
}

function bountyincreasestreak(var0) {
  if(!1) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = 1;
  }

  self.bountystreak += var0;
  bountyconvert();
}

function bountyconvert() {
  if(!1) {
    return;
  }

  var0 = playergetbountypoints();
  var1 = int(floor(self.bountystreak / 3));

  if(var1 > var0 && var1 <= 5) {
    playersetbountypoints(var1);
    return;
  }
}

function bountycollect(var0, var1) {
  if(!1) {
    return;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_bounty")) {
    if(var0 > 0) {
      for(var2 = 0; var2 < var0; var2++) {
        thread scripts\mp\utility\points::giveunifiedpoints("bounty");
        bountyincreasestreak();
        playFX(scripts\engine\utility::getfx("vfx_mo_money_cash_exp"), var1 + (0, 0, 45));
      }

      thread scripts\mp\hud_util::teamplayercardsplash("callout_bounty_collected", self);
      return;
    }

    return;
  }
}
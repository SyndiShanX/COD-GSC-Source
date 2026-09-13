/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bounty.gsc
***********************************************/

init() {
  level.bounty_index = [];
  level._effect["vfx_mo_money_cash_exp"] = loadfx("vfx/iw7/_requests/mp/vfx_mo_money_cash_exp.vfx");

  if(1) {
    thread onplayerconnect();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onplayerjoinedteam);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player bountyinit();
  }
}

bountyinit() {
  if(!isDefined(self.bountypoints)) {
    playerregisterbountyindex();
    playerresetbountypoints();
    playerresetbountystreak();
  }
}

onplayerdisconnect(player) {
  if(isDefined(player.bounty_index))
    level.bounty_index[player.bounty_index] = undefined;
}

onplayerjoinedspectators(player) {
  if(1) {
    if(isDefined(player.bounty_index)) {
      player playerresetbountypoints();
      player playerresetbountystreak();
    }
  }
}

onplayerjoinedteam(player) {
  if(1) {
    if(isDefined(player.bounty_index)) {
      player playerresetbountypoints();
      player playerresetbountystreak();
    }
  }
}

playerregisterbountyindex() {
  for(index = 0; isDefined(level.bounty_index[index]); index++) {}

  level.bounty_index[index] = self;
  self.bounty_index = index;
}

playergetbountypoints() {
  return self.bountypoints;
}

playersetbountypoints(bountypoints) {
  self.bountypoints = bountypoints;
  level.bounty_index[self.bounty_index] setbountycount(self.bountypoints);
}

playerresetbountypoints(wait_time) {
  if(!1) {
    return;
  }
  if(isDefined(wait_time))
    wait(wait_time);

  if(isDefined(self))
    playersetbountypoints(0);
}

playerresetbountystreak(wait_time) {
  if(!1) {
    return;
  }
  if(isDefined(wait_time))
    wait(wait_time);

  if(isDefined(self))
    self.bountystreak = 0;
}

bountyincreasestreak(amount) {
  if(!1) {
    return;
  }
  if(!isDefined(amount))
    amount = 1;

  self.bountystreak = self.bountystreak + amount;
  bountyconvert();
}

bountyconvert() {
  if(!1) {
    return;
  }
  _id_00350B780C8443D4 = playergetbountypoints();
  _id_FDDC6D6D48703985 = int(floor(self.bountystreak / 3));

  if(_id_FDDC6D6D48703985 > _id_00350B780C8443D4 && _id_FDDC6D6D48703985 <= 5)
    playersetbountypoints(_id_FDDC6D6D48703985);
}

bountycollect(_id_D55DC1EE4D799341, _id_11FBC6946AF7E858) {
  if(!1) {
    return;
  }
  if(scripts\mp\utility\perk::_hasperk("specialty_bounty")) {
    if(_id_D55DC1EE4D799341 > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D55DC1EE4D799341; _id_AC0E594AC96AA3A8++) {
        thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_532C064CAF1E3CA6");
        bountyincreasestreak();
        playFX(scripts\engine\utility::getfx("vfx_mo_money_cash_exp"), _id_11FBC6946AF7E858 + (0, 0, 45));
      }

      thread scripts\mp\hud_util::teamplayercardsplash("callout_bounty_collected", self);
    }
  }
}
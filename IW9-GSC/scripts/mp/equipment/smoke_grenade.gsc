/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\smoke_grenade.gsc
**************************************************/

smokegrenadeused(_id_E012E0B70D7D54FA) {
  thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  thread _id_E4F6E856495DBAFB();

  if(istrue(_id_E012E0B70D7D54FA)) {
    self waittill("missile_stuck", position, stuckto, _id_1D9FB21B4F3023F3, surfacetype, velocity, normal);
    thread smokeglvfx(position);

    if(getdvarint("dvar_ABE45E35EF030A56") == 0)
      thread scripts\mp\bots\bots::create_smoke_occluder(position);
  } else
    self waittill("explode", position);

  thread smokegrenadeexplode(position, self.owner);
  thread sfx_smoke_grenade_smoke(position);

  if(isDefined(self) && isDefined(self.owner))
    self.owner thread monitorsmokeactive();

  scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_smoke", self.owner, undefined, 0);
}

sfx_smoke_grenade_smoke(position) {
  wait 0.2;
  _id_4CF58793CC4F1AD6 = spawn("script_origin", position);
  _id_4CF58793CC4F1AD6 playLoopSound("smoke_grenade_smoke_lp");
  _id_4CF58793CC4F1AD6 scripts\cp_mp\ent_manager::registerspawncount(1);
  wait 5.25;
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_smoke_tail", position);
  wait 0.3;

  if(isDefined(_id_4CF58793CC4F1AD6))
    _id_4CF58793CC4F1AD6 stoploopsound();

  _id_4CF58793CC4F1AD6 scripts\cp_mp\ent_manager::deregisterspawn();
  _id_4CF58793CC4F1AD6 delete();
}

_id_E4F6E856495DBAFB() {
  self endon("explode");
  self endon("death");
  self waittill("missile_water_impact", _id_7842E9E94384087B);
  self notify("end_explode");
  thread _id_9E58BAA59719D027();
}

_id_9E58BAA59719D027() {
  self endon("explode");
  self endon("death");
  self waittill("missile_stuck", _id_A681B7890CD017C7);
  position = self.origin;
  thread smokegrenadeexplode(position);
  thread sfx_smoke_grenade_smoke(position);

  if(isDefined(self) && isDefined(self.owner))
    self.owner thread monitorsmokeactive();
}

smokegrenadeexplode(position, owner) {
  level endon("game_ended");
  wait 1;
  thread smokegrenadegiveblindeye(position, owner);

  if(getdvarint("dvar_ABE45E35EF030A56") == 1) {
    if(getdvarint("mgl", 0))
      thread scripts\common\ai::_id_F8903387EA945165(position, 1);
    else
      scripts\common\ai::_id_8A09C0E5FA78A48C(position);
  }

  id = scripts\mp\utility\outline::addoutlineoccluder(position, 330);
  wait 8.25;
  scripts\mp\utility\outline::removeoutlineoccluder(id);
}

smokeglvfx(position, normal) {
  playFX(scripts\engine\utility::getfx("glsmoke"), position, anglestoup((0, 90, 0)));
}

smokegrenadegiveblindeye(position, owner) {
  level endon("game_ended");
  struct = spawnStruct();
  struct.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(struct, position, owner);

  foreach(_id_7217865F0CC39B1C in struct.blindeyerecipients) {
    if(isDefined(_id_7217865F0CC39B1C) && scripts\mp\utility\player::isreallyalive(_id_7217865F0CC39B1C) && _id_7217865F0CC39B1C scripts\mp\utility\perk::_hasperk("specialty_blindeye"))
      _id_7217865F0CC39B1C scripts\mp\utility\perk::removeperk("specialty_blindeye");
  }
}

smokegrenademonitorblindeyerecipients(struct, position, owner) {
  level endon("game_ended");
  endtime = gettime() + 8250.0;
  _id_033DDA3FB8403E62 = 0;
  players = [];

  while(gettime() < endtime) {
    players = scripts\mp\utility\player::getplayersinradius(position, 330);

    if(!_id_033DDA3FB8403E62) {
      if(isDefined(players) && players.size > 0) {
        if(isDefined(owner) && !scripts\engine\utility::array_contains(players, owner)) {
          owner _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "smokeGrenadeBlinded");
          _id_033DDA3FB8403E62 = 1;
        }
      }
    }

    foreach(_id_6758A6F2FD1B6491, _id_7217865F0CC39B1C in struct.blindeyerecipients) {
      if(!isDefined(_id_7217865F0CC39B1C)) {
        struct.blindeyerecipients[_id_6758A6F2FD1B6491] = undefined;
        continue;
      }

      _id_44676E4D2A7FF788 = scripts\engine\utility::array_find(players, _id_7217865F0CC39B1C);

      if((!isDefined(_id_44676E4D2A7FF788) || !scripts\mp\utility\player::isreallyalive(_id_7217865F0CC39B1C)) && _id_7217865F0CC39B1C scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
        _id_7217865F0CC39B1C scripts\mp\utility\perk::removeperk("specialty_blindeye");
        struct.blindeyerecipients[_id_6758A6F2FD1B6491] = undefined;
      }

      if(isDefined(_id_44676E4D2A7FF788))
        players[_id_44676E4D2A7FF788] = undefined;
    }

    foreach(player in players) {
      if(!isDefined(player) || !isPlayer(player)) {
        continue;
      }
      player.lastinsmoketime = gettime();

      if(isDefined(struct.blindeyerecipients[player getentitynumber()])) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(player)) {
        continue;
      }
      player scripts\mp\utility\perk::giveperk("specialty_blindeye");
      struct.blindeyerecipients[player getentitynumber()] = player;
    }

    waitframe();
  }
}

monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\mp\utility\print::printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  result = scripts\engine\utility::waittill_any_timeout_1(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\mp\utility\print::printgameaction("smoke grenade deactivated", self);
}
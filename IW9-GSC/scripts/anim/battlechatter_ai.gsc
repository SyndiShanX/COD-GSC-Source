/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_ai.gsc
***********************************************/

addtosystem() {
  if(!isDefined(level.battlechatter)) {
    return;
  }
  self endon("death");

  if(!isDefined(self.battlechatterallowed))
    self.battlechatterallowed = 1;

  self.battlechatter.friendlyfire_force = 1;

  if(isPlayer(self)) {
    self.battlechatterallowed = 0;
    self.type = "human";
    return;
  }

  if(self.unittype == "dog" || self.unittype == "juggernaut" || self.unittype == "zombie" || self.team == "neutral" || istrue(self._id_71795A38C9A86A0F)) {
    self.battlechatterallowed = 0;
    return;
  }

  self.headknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "head"));
  self.scriptedtalkingknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "scripted_talking"));
  self.defaulttalk = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "default_talking"));
  _id_F9E1B676055CF38B();
  thread _id_D00620AA77CD59DD();
  self.chatinitialized = 1;
}

_id_763F1E33A5D6BB68() {
  if(isDefined(self.battlechatter.npcid) && isDefined(self.voice)) {
    foreach(_id_CF9DFCA32AF33B39 in anim.usedids[self.voice]) {
      if(_id_CF9DFCA32AF33B39.npcid == self.battlechatter.npcid) {
        _id_CF9DFCA32AF33B39.count--;
        break;
      }
    }
  }

  self.battlechatter.npcid = undefined;
}

_id_F9E1B676055CF38B(voice) {
  if(isDefined(voice))
    self.voice = voice;

  if(!isDefined(self.voice)) {
    return;
  }
  self.battlechatter.countryid = anim.countryids[self.voice];

  if(!isDefined(self.battlechatter.countryid)) {
    return;
  }
  _id_00433D8F78F7E5FB::assign_npcid();
}

_id_DA324CD732971E8C() {
  _id_763F1E33A5D6BB68();
  _id_00433D8F78F7E5FB::assign_npcid();
}

removefromsystem(squad) {
  if(!isDefined(level.battlechatter) || !isDefined(self)) {
    return;
  }
  if(!isalive(self) && isDefined(self.attacker) && !scripts\engine\utility::is_equal(squad.team, self.attacker.team) && squad.team != "neutral") {
    self.attacker thread _id_50EEB9595C6D6E1B::_id_453B3867C6EC0CEB(self, self.attacker.team);
    thread _id_50EEB9595C6D6E1B::_id_F649C4EF3ACDEC1D(squad.team);
  }

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid) && isDefined(self.voice)) {
    _id_763F1E33A5D6BB68();

    if(isDefined(level.stealth) && isDefined(level._id_621AF16EF0684A11))
      thread _id_BD6944098E09347F(squad.team, self.battlechatter.countryid, self.battlechatter.npcid, self.battlechatter.name);
  } else if(isDefined(self._id_4413114D1D17278B)) {
    self._id_4413114D1D17278B notify("death");
    self._id_4413114D1D17278B delete();
  }

  self notify("removed from battleChatter");
}

_id_BD6944098E09347F(team, countryid, npcid, name) {
  if(istrue(level._id_ECAFB96516684C19)) {
    return;
  }
  origin = self.origin;
  voice = self.voice;

  if(!scripts\common\utility::issp()) {
    _id_3E6D99E336341602();
    return;
  }

  entnum = self getentitynumber();
  corpse = undefined;

  while(!isDefined(corpse)) {
    array = [[level._id_621AF16EF0684A11]](level._id_798AA343368F724E);

    foreach(_id_969F28BBB67E845E in array) {
      if(_id_969F28BBB67E845E getentitynumber() == entnum)
        corpse = _id_969F28BBB67E845E;
    }

    waitframe();
  }

  corpse.team = team;
  corpse.voice = voice;
  corpse.battlechatter = spawnStruct();
  corpse.battlechatter.countryid = countryid;
  corpse.battlechatter.npcid = npcid;
  corpse.battlechatter.name = name;
  corpse.battlechatterallowed = 1;

  if(isDefined(level.stealth))
    corpse thread _id_BD0F092DBCDEA227();

  corpse waittill("entitydeleted");
  corpse notify("stop_corpse_loop");
}

_id_3E6D99E336341602() {}

_id_BD0F092DBCDEA227() {
  self endon("stop_corpse_loop");
  level endon("stop_corpse_loops");

  while(!istrue(self._id_6EF5F7AC4D441CBB)) {
    wait(randomintrange(8, 15));

    if(!isDefined(self.origin) || istrue(self._id_6EF5F7AC4D441CBB)) {
      return;
    }
    players = _id_35DE402EFC5ACFB3::_id_2AA175082BDB56F5(self.origin, 600);

    if(players.size > 0) {
      if(!_id_35DE402EFC5ACFB3::_id_EAD4BED232D015ED("corpse_status_report", players)) {
        continue;
      }
      _id_35DE402EFC5ACFB3::_id_E23B0906B02CD179("status_report", 50, players);
      _id_50EEB9595C6D6E1B::_id_E196D9B15E858B0F(players);
      level notify("stop_corpse_loops");
    }
  }
}

setnpcid() {
  usedids = anim.usedids[self.voice];
  _id_0CB9C74D28D191F3 = usedids.size;
  _id_2F55781AF96F22F9 = randomint(_id_0CB9C74D28D191F3);
  _id_59DC09A0FEA10022 = _id_2F55781AF96F22F9;

  for(index = 0; index <= _id_0CB9C74D28D191F3; index++) {
    if(usedids[(_id_2F55781AF96F22F9 + index) % _id_0CB9C74D28D191F3].count < usedids[_id_59DC09A0FEA10022].count)
      _id_59DC09A0FEA10022 = (_id_2F55781AF96F22F9 + index) % _id_0CB9C74D28D191F3;
  }

  anim.usedids[self.voice][_id_59DC09A0FEA10022].count++;
  self.battlechatter.npcid = usedids[_id_59DC09A0FEA10022].npcid;
}

evaluateattackevent(weapon) {
  _id_50EEB9595C6D6E1B::_id_656C8BA582163660(weapon);
}

_id_D00620AA77CD59DD() {
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiThreadWaiter");
  self endon("aiThreadWaiter");
  childthread waittill_missile_fire();
  childthread waittill_grenade_danger();
  childthread _id_AD344A5A58977B39();
  childthread _id_55345680B30657A1();
}

waittill_missile_fire() {
  for(;;) {
    self waittill("missile_fire", missile, objweapon);
    _id_50EEB9595C6D6E1B::_id_656C8BA582163660("rpg");
  }
}

waittill_grenade_danger() {
  for(;;) {
    self waittill("grenade danger", grenade, objweapon);

    if(isDefined(grenade) && _id_00433D8F78F7E5FB::bcisgrenade(grenade.model))
      _id_50EEB9595C6D6E1B::_id_A7A911968F655267("grenade");
  }
}

_id_AD344A5A58977B39() {
  for(;;) {
    self waittill("weapon_fired");
    _id_50EEB9595C6D6E1B::_id_A3B5180187A17623();
  }
}

_id_55345680B30657A1() {
  for(;;) {
    self waittill("goal_changed");

    if(distance2dsquared(self.origin, self.goalpos) > 10000)
      _id_50EEB9595C6D6E1B::_id_42C77C7F13A1BEB8();
  }
}

aivehiclekillwaiter() {}

custom_battlechatter_internal(_id_69857F6E03B5E3DC, _id_927B3199642B75FC, priority, timeout, cooldown, _id_BA7E8AD2868EF874) {
  _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45(_id_69857F6E03B5E3DC, _id_69857F6E03B5E3DC, priority, timeout, cooldown, _id_BA7E8AD2868EF874);
}
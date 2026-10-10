/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_bank.gsc
***********************************************/

#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\trigger;
#namespace br_bank;

function init() {
  level.br_bank_alarm_enabled = getdvarint(@ "hash_bbb179520c2c4a14", 0);

  if(!istrue(level.br_bank_alarm_enabled)) {
    return;
  }

  level._effect["poi_light_bank"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_light_bank.vfx");
  level.bankalltriggers = getEntArray("bank_entry_detector", "targetname");

  foreach(trigger in level.bankalltriggers) {
    if(!isDefined(trigger)) {
      continue;
    }

    trigger.playersinsidebank = 0;
    trigger.alarmstillplaying = 0;
    trigger.banklights = getStructArray(trigger.target, "targetname");
    trigger thread scripts\mp\utility\trigger::makeenterexittrigger(trigger, &bankplayerentering, &bankplayerexiting);
  }
}

function bankplayerentering(player, banktrigger) {
  if(!isDefined(banktrigger)) {
    return;
  }

  banktrigger.playersinsidebank += 1;

  if(banktrigger.playersinsidebank != 1) {
    return;
  }

  banktrigger thread bankturnonalarm();
}

function bankplayerexiting(player, banktrigger) {
  if(!isDefined(banktrigger)) {
    return;
  }

  assertex(banktrigger.playersinsidebank > 0, "<dev string:x1c>");
  banktrigger.playersinsidebank = max(banktrigger.playersinsidebank - 1, 0);

  if(banktrigger.playersinsidebank == 0) {
    banktrigger thread bankturnoffalarm();
  }
}

function bankplunderdeposited() {
  if(!istrue(level.br_bank_alarm_enabled)) {
    return;
  }

  player = self;
  player notify("bankPlunderDeposited");
  player endon("bankPlunderDeposited");
  var_8e204c4acdb20d51 = getclosest(player.origin, level.bankalltriggers, 90000);

  if(!isDefined(var_8e204c4acdb20d51)) {
    return;
  }

  var_8e204c4acdb20d51 bankturnoffalarm();
  var_b4a32387dba557b9 = getdvarint(@ "hash_32eab55ff865c3c", 15);
  wait var_b4a32387dba557b9;

  if(var_8e204c4acdb20d51.playersinsidebank > 0) {
    var_8e204c4acdb20d51 bankturnonalarm();
  }
}

function bankturnonalarm() {
  self notify("bank_alarm_triggered");
  banktrigger = self;
  banktrigger.alarmstillplaying = 1;
  banktrigger playLoopSound("bank_alarm_lp");

  foreach(banklight in banktrigger.banklights) {
    forwardvect = anglesToForward(banklight.angles);
    upvect = anglestoup(banklight.angles);
    banklight.fx = spawnfx(level._effect["poi_light_bank"], banklight.origin + forwardvect * 5, forwardvect, upvect);
    triggerfx(banklight.fx);
  }

  var_50b6c105426b8e48 = getdvarint(@ "hash_5b11f68d6b008181", 5);
  wait var_50b6c105426b8e48;
  banktrigger.alarmstillplaying = 0;

  if(banktrigger.playersinsidebank == 0) {
    banktrigger bankturnoffalarm();
  }
}

function bankturnoffalarm() {
  self endon("bank_alarm_triggered");
  banktrigger = self;

  if(banktrigger.alarmstillplaying) {
    return;
  }

  wait 3;
  banktrigger stoploopsound();

  foreach(banklight in banktrigger.banklights) {
    if(isDefined(banklight.fx)) {
      banklight.fx delete();
    }
  }
}
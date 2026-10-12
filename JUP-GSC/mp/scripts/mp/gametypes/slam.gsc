/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\slam.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace slam;

function autoexec main() {
  registersharedfunc("slam", "init", &slam_init);
  registersharedfunc("slam", "setLastStandMessage", &function_c88bd46173b8ea14);
  registersharedfunc("slam", "onNormalDeath", &function_14712550e86f996f);
  registersharedfunc("slam", "onSpawnPlayer", &slam_onspawnplayer);
  registersharedfunc("slam", "onPlayerConnect", &slam_onplayerconnect);
  registersharedfunc("slam", "initializeMatchRules", &function_b818eedef86c1a7b);
  registersharedfunc("slam", "isSlamAnnouncerLine", &function_5febe066472a9de5);
  registersharedfunc("slam", "getSoundName", &function_6abe4ad568596595);
}

function slam_init() {
  level.var_b57e01a4f8558a6b = &function_5f480f5e6055cc0b;
  level.var_a0fbb4b3fcdcc138 = &function_2ecd88252e67c89a;
  level.var_c53947782c7460f6 = 1;
  level.var_74fe55f9c2b0222 = 1;
  level.var_7607dacdbd5ba02 = 1;
  level.var_425a393024ec491f = 1;
  level.var_9af86da599e041f = 1;
  level.addlaststandoverheadiconcallback = &function_7bb83dadb9e6cd29;
  level.modifyplayerdamage = &function_67022d6a7b9cc0b7;
  level callback::add("player_laststand", &function_a5957986356a54cf);
  level callback::add("player_revived", &function_4d4c9064d5060fa4);
  level.var_7b95bf8778b8724e = ["jup_mp_execution_caramel_01_slam", "jup_mp_execution_mochi_01_slam", "jup_mp_execution_gelato_01_slam", "jup_mp_execution_chair_01_slam", "jup_mp_execution_pbomb_01_slam"];
  function_d1706ac032d53d89();
  function_d0b0c15fe651dd0f();
  function_144059b85d0a7fcc();

  level thread scripts\cp_mp\utility\debug_utility::waitfordvar(@ "hash_ca17e0de7b7a9fa3", "<dev string:x1c>", &function_10d71f04bcc13032);
}

function function_b818eedef86c1a7b() {
  setdynamicdvar(@ "hash_683d3e309194e766", 0);
}

function slam_onplayerconnect() {
  if(function_e7667a0205b50f63()) {
    self.var_1107969beb8b88b9 = 0;
  }

  thread function_86fe7027eb5a831e();
  thread function_440ab83a1d4f23b();
  thread function_c99f94326ccb590a();
}

function slam_onspawnplayer(revivespawn) {
  if(istrue(revivespawn)) {
    return;
  }

  function_f5aadb4bfe643f37();
}

function function_5f480f5e6055cc0b() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");
  thread scripts\mp\laststand::showsuicidehintstring();
  thread function_e2d256c7e33d7114();

  var_df4c6bb1b20539e5 = getdvarfloat(@ "hash_d4e8b8098347a7a4", -1);

  if(isbot(self) && var_df4c6bb1b20539e5 >= 0) {
    thread function_8ae8cd21b1d4af25(var_df4c6bb1b20539e5);
  }

  var_797160dfebc76fdf = 0;
  var_f2cde91d9d9ba436 = 0;

  while(self.timeuntilbleedout > level.framedurationseconds) {
    waitframe();

    if(!function_f88619eaafbd0adb()) {
      var_797160dfebc76fdf += level.framedurationseconds;

      if(var_797160dfebc76fdf >= 0.75) {
        self notify("last_stand_bleedout");
        return;
      }
    }

    if(self isinexecutionvictim() || istrue(self.beingrevived)) {
      var_f2cde91d9d9ba436 = 1;
      continue;
    }

    if(var_f2cde91d9d9ba436) {
      function_c88bd46173b8ea14();
      var_f2cde91d9d9ba436 = 0;
    }

    self.timeuntilbleedout -= level.framedurationseconds;
  }

  if(function_afc2fae8e95d004e()) {
    self notify("last_stand_self_revive");
    return;
  }

  self notify("last_stand_bleedout");
}

function function_f88619eaafbd0adb() {
  if(self getstanceblocked("stand") || self isswimming() || self isswimunderwater()) {
    return false;
  }

  return true;
}

function function_c88bd46173b8ea14() {
  if(istrue(getbeingrevivedinternal())) {
    setlowermessageomnvar("being_revived");
    return;
  }

  if(isDefined(self.timeuntilbleedout)) {
    time = int(gettime() + self.timeuntilbleedout * 1000);

    if(function_e7667a0205b50f63()) {
      setlowermessageomnvar("slam_mash_back_up", time);
    } else if(function_afc2fae8e95d004e()) {
      setlowermessageomnvar("slam_get_up", time);
    } else {
      setlowermessageomnvar("slam_bleedout", time);
    }

    return;
  }

  assertmsg("<dev string:x25>");
}

function function_a5957986356a54cf(params) {
  attacker = self.laststandattacker;

  if(isDefined(attacker)) {
    attacker scripts\mp\utility\stats::incpersstat("downs", 1);
    attacker setextrascore0(attacker.pers["downs"]);
    attacker thread scripts\mp\utility\points::doscoreevent(#"slam_down");
  }
}

function function_4d4c9064d5060fa4(params) {
  reviver = params.reviver;

  if(isDefined(reviver)) {
    reviver scripts\mp\utility\stats::incpersstat("rescues", 1);
    reviver setextrascore1(reviver.pers["rescues"]);
  }
}

function function_7bb83dadb9e6cd29() {
  offset = 25;
  drawthroughgeo = 1;
  maxdrawdist = 1280;
  naturaldist = 250;
  delaytime = undefined;
  var_fa4cf28a58192889 = undefined;
  var_b3ea37733a1577e5 = 0;
  overrideorigin = undefined;
  showonminimap = 0;
  selfteam = self.team;
  var_460a6f9561179887 = "hud_realism_head_revive";
  enemyteam = scripts\mp\utility\teams::getenemyteams(selfteam)[0];
  var_a03e6a46d16f28e3 = "icon_obit_execution_slam";
  var_2b6cf74ebb0a149 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(selfteam, var_460a6f9561179887, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, var_b3ea37733a1577e5, overrideorigin, showonminimap);
  var_3d4e7bbef551ad7b = scripts\cp_mp\entityheadicons::setheadicon_singleimage(enemyteam, var_a03e6a46d16f28e3, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_fa4cf28a58192889, var_b3ea37733a1577e5, overrideorigin, showonminimap);
  thread function_832c04af9af32c16([var_2b6cf74ebb0a149, var_3d4e7bbef551ad7b]);
}

function function_832c04af9af32c16(images) {
  level endon("game_ended");
  waittill_any_3("death_or_disconnect", "last_stand_finished", "execution_begin_victim");

  foreach(image in images) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(image);
  }
}

function function_e2d256c7e33d7114() {
  level endon("game_ended");
  self endon("disconnect");
  self.var_d85e979ebce411d6 = [];
  teammates = callsharedfunc("game", "getTeamData", self.team, "players");

  foreach(teammate in teammates) {
    if(teammate != self && isDefined(teammate.laststandreviveent)) {
      teammate.laststandreviveent disableplayeruse(self);
      self.var_d85e979ebce411d6 = array_add(self.var_d85e979ebce411d6, teammate.laststandreviveent);
    }
  }

  childthread function_5ed40d7b6f878dfa();
  waittill_any_2("death", "last_stand_finished");

  foreach(reviveent in self.var_d85e979ebce411d6) {
    if(isDefined(reviveent)) {
      reviveent enableplayeruse(self);
    }
  }
}

function function_5ed40d7b6f878dfa() {
  self endon("last_stand_finished");
  self endon("death");

  while(true) {
    level waittill("last_stand_revive_enter", reviveent);

    if(reviveent.owner != self && reviveent.owner.team == self.team) {
      reviveent disableplayeruse(self);
      self.var_d85e979ebce411d6 = array_add(self.var_d85e979ebce411d6, reviveent);
    }
  }
}

function function_afc2fae8e95d004e() {
  return getdvarint(@ "hash_c9aee891770c0b8d", 0) == 1;
}

function function_144059b85d0a7fcc() {
  if(!function_e7667a0205b50f63()) {
    return;
  }

  var_c260f8d98055957b = getDvar(@ "hash_c80cdc547780cf7c", "1.0,1.35,1.9,3.5");
  var_9fd3daaa1c692630 = strtok(var_c260f8d98055957b, ",");
  level.var_e57d6b3e99f2690 = [];

  for(i = 0; i < var_9fd3daaa1c692630.size; i++) {
    var_2475f61044f7442 = float(var_9fd3daaa1c692630[i]);
    level.var_e57d6b3e99f2690[i] = (var_2475f61044f7442 - 1) / var_2475f61044f7442;
  }
}

function function_2ecd88252e67c89a() {
  level notify("last_stand_revive_enter", self);

  if(!function_e7667a0205b50f63()) {
    return;
  }

  if(getdvarint(@ "hash_ff48103f36710ebf", 0) == 1) {
    function_144059b85d0a7fcc();
  }

  triggerent = self;
  downedplayer = triggerent.owner;
  level endon("game_ended");
  triggerent endon("death");
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_revived");
  downedplayer thread scripts\mp\utility\dialog::leaderdialogonplayer("slam_selfRevive");
  triggerent.usetime = getdvarfloat(@ "hash_885ea9873e03f006", 4) * 1000;
  downedplayer childthread function_59a3ed040fd89cce(triggerent);
  downedplayer childthread function_4bb9fe8f98ebfde6(triggerent);

  if(!isDefined(self.curprogress)) {
    self.curprogress = 0;
  }

  decayrate = isDefined(downedplayer.var_1107969beb8b88b9) && isDefined(level.var_e57d6b3e99f2690) ? level.var_e57d6b3e99f2690[downedplayer.var_1107969beb8b88b9] : 0;
  downedplayer function_2b7aebb1af67de9d();

  while(true) {
    if(!istrue(downedplayer.isselfreviving) && downedplayer function_7aaa8047acd70a4f(triggerent)) {
      triggerent notify("self_revive_start");
      downedplayer setlaststandselfreviving(1, 0);
      triggerent thread function_abcabdf4cfdbfaad(decayrate);
    }

    waitframe();
  }
}

function function_abcabdf4cfdbfaad(decayrate) {
  downedplayer = self.owner;
  triggerent = self;
  level endon("game_ended");
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_finished");
  triggerent.waitingforteammaterevive = 0;
  triggerent thread scripts\mp\laststand::selfrevivebuttonpresscleanup();

  if(!istrue(downedplayer.isselfreviving)) {
    downedplayer val::group_reset(downedplayer.laststandactionset);
    downedplayer val::group_set("laststand_revive", 0);
    downedplayer.isselfreviving = 1;
  }

  downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);

  while(downedplayer function_7aaa8047acd70a4f(triggerent) && triggerent.curprogress < triggerent.usetime) {
    triggerent.inuse = 1;
    oldprogress = triggerent.curprogress;

    if(decayrate > 0) {
      triggerent.curprogress -= decayrate * level.frameduration;
    }

    if(triggerent.isholding) {
      triggerent.curprogress += level.frameduration;
    } else if(triggerent.var_f044256ff0d621f2) {
      var_315edb94134021b1 = getdvarfloat(@ "hash_b773851f2626c29", 0.04);
      triggerent.curprogress += var_315edb94134021b1 * triggerent.usetime;
      triggerent.var_f044256ff0d621f2 = 0;
    }

    triggerent.curprogress = clamp(triggerent.curprogress, 0, triggerent.usetime);

    if(triggerent.curprogress != oldprogress) {
      downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);

      if(triggerent.curprogress >= triggerent.usetime) {
        downedplayer val::group_reset("laststand_revive");
        downedplayer scripts\mp\laststand::finishreviveplayer("self_revive_success", downedplayer);

        if(isbot(downedplayer) && istrue(downedplayer.var_77958c90d8cffeb1)) {
          downedplayer.var_77958c90d8cffeb1 = 0;
        }

        return;
      }
    }

    waitframe();
  }

  downedplayer val::group_reset("laststand_revive");
  downedplayer val::group_set(downedplayer.laststandactionset, 0);

  if(istrue(downedplayer.beingrevived)) {
    downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);
  } else {
    triggerent thread scripts\mp\laststand::decayreviveprogress(decayrate);
  }

  downedplayer notify("stopped_self_revive");
}

function function_7aaa8047acd70a4f(triggerent) {
  if(!isreallyalive(self) || !function_f1853bfc82db2449(triggerent) || self isinexecutionvictim() || istrue(self.ishaywire) || istrue(self.beingrevived) || !(self isonground() || self isswimming())) {
    return false;
  }

  return true;
}

function function_f1853bfc82db2449(triggerent) {
  return triggerent.isholding || triggerent.var_b9f8728be52ed0f4;
}

function function_59a3ed040fd89cce(triggerent) {
  triggerent.isholding = 0;
  holdtimer = 0;

  while(true) {
    buttonpressed = function_a574593a33de24fc();

    if(buttonpressed && !triggerent.isholding) {
      if(holdtimer > 0.5) {
        triggerent.isholding = 1;
      }

      holdtimer += level.framedurationseconds;
    } else if(!buttonpressed && holdtimer > 0) {
      holdtimer = 0;
      triggerent.isholding = 0;
    }

    waitframe();
  }
}

function function_4bb9fe8f98ebfde6(triggerent) {
  var_5fa2750c58029d0f = 500;
  var_e3832c2eb6ac986f = 100;
  var_e622dabf426fe14 = 0;
  triggerent.var_b9f8728be52ed0f4 = 0;
  triggerent.var_f044256ff0d621f2 = 0;
  var_77e7923a9367562a = 0;

  while(true) {
    buttonpressed = function_a574593a33de24fc();

    if(buttonpressed) {
      var_77e7923a9367562a = 1;
    } else {
      if(var_77e7923a9367562a && !triggerent.isholding) {
        var_a99de052781ec047 = gettime() - var_e622dabf426fe14;

        if(var_a99de052781ec047 > var_e3832c2eb6ac986f) {
          var_e622dabf426fe14 = gettime();
          triggerent.var_b9f8728be52ed0f4 = 1;
          triggerent.var_f044256ff0d621f2 = 1;
          self playsoundtoplayer("mp_jup_slam_self_revive_beep", self);
        }
      }

      var_77e7923a9367562a = 0;
    }

    if(var_e622dabf426fe14 > 0) {
      var_a99de052781ec047 = gettime() - var_e622dabf426fe14;

      if(var_a99de052781ec047 >= var_5fa2750c58029d0f) {
        triggerent.var_b9f8728be52ed0f4 = 0;
        var_e622dabf426fe14 = 0;
      }
    }

    waitframe();
  }
}

function function_a574593a33de24fc() {
  if(isbot(self) && istrue(self.var_77958c90d8cffeb1)) {
    return 1;
  }

  if(self usinggamepad()) {
    return self weaponswitchbuttonPressed();
  }

  return self activatekeypressed();
}

function function_bed4b73d1e21039() {
  if(!function_e7667a0205b50f63()) {
    return;
  }

  if(!isDefined(self.var_1107969beb8b88b9)) {
    self.var_1107969beb8b88b9 = 0;
  }

  var_7d2e0ea9107a4c02 = getdvarint(@ "hash_8c1b921deac82a9c", 100);
  self.var_1107969beb8b88b9 = int(clamp(self.var_1107969beb8b88b9 - var_7d2e0ea9107a4c02, 0, level.var_e57d6b3e99f2690.size - 1));
}

function function_2b7aebb1af67de9d() {
  if(!function_e7667a0205b50f63()) {
    return;
  }

  if(!isDefined(self.var_1107969beb8b88b9)) {
    self.var_1107969beb8b88b9 = 0;
  }

  self.var_1107969beb8b88b9 = int(clamp(self.var_1107969beb8b88b9 + 1, 0, level.var_e57d6b3e99f2690.size - 1));
}

function function_f5aadb4bfe643f37() {
  if(!function_e7667a0205b50f63()) {
    return;
  }

  self.var_1107969beb8b88b9 = 0;
}

function function_e7667a0205b50f63() {
  return getdvarint(@ "hash_334ecdb5ff00736e", 1) == 1;
}

function function_440ab83a1d4f23b() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("execution_begin", victiment);

    if(self isjumping()) {
      continue;
    }

    self playSound("mp_jup_slam_deathmatch_takedown_crowd");
    childthread function_c2a3a2e3045a1cb2();
    victiment childthread function_aeacf0b2d606a94c();

    var_9a14eaf3faa577e9 = getdvarfloat(@ "hash_4477b986fee2437", 0);

    if(var_9a14eaf3faa577e9 > 0) {
      thread function_8405385af988a5ca(var_9a14eaf3faa577e9);
    }
  }
}

function function_c2a3a2e3045a1cb2() {
  self notify("kill_slam_aura");
  self endon("kill_slam_aura");
  currentstate = self getscriptablepartstate("slam_aura", 1);

  if(!isDefined(self.var_fc71f1119a8ec847)) {
    enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];
    outlineasset = getDvar(@ "hash_ede65e6befd755cd", "outline_nodepth_slam_aura");
    self.var_fc71f1119a8ec847 = outlineenableforteam(self, enemyteam, outlineasset, "lowest");
  }

  if(!isDefined(currentstate) || currentstate != "on") {
    self setscriptablepartstate("slam_aura", "fade_in", 0);
    wait getdvarfloat(@ "hash_64865e773fd023c0", 0.3);
  }

  self setscriptablepartstate("slam_aura", "on", 0);
  val::set("slam_aura", "execution_victim", 0);

  while(self isinexecutionattack()) {
    waitframe();
  }

  wait getdvarfloat(@ "hash_1057326b2b3c848f", 2);
  self setscriptablepartstate("slam_aura", "fade_out", 0);
  wait getdvarfloat(@ "hash_ac65b5019b915e24", 0.5);
  self setscriptablepartstate("slam_aura", "off", 0);
  outlinedisable(self.var_fc71f1119a8ec847, self);
  self.var_fc71f1119a8ec847 = undefined;
  val::reset_all("slam_aura");
}

function function_aeacf0b2d606a94c() {
  self endon("death_or_disconnect");

  if(!isDefined(self.laststandreviveent)) {
    return;
  }

  self.laststandreviveent disableplayeruseforallplayers();

  while(self isinexecutionvictim()) {
    waitframe();
  }

  teammates = callsharedfunc("game", "getTeamData", self.team, "players");

  foreach(teammate in teammates) {
    if(!isinlaststand(teammate)) {
      self.laststandreviveent enableplayeruse(teammate);
    }
  }
}

function function_67022d6a7b9cc0b7(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1) {
  var_bda16165c7ad56e4 = victim getscriptablepartstate("slam_aura", 1);

  if(!isDefined(var_bda16165c7ad56e4)) {
    return idamage;
  }

  var_d56e77df51048a93 = getdvarint(@ "hash_2455cde97d8db2d0", 1) == 1;
  var_9a8aa3a71bce962 = isDefined(eattacker) && istrue(eattacker.var_f90321da34fafbe5);
  var_8d5389838b26e3bb = var_d56e77df51048a93 && var_9a8aa3a71bce962;

  if(var_8d5389838b26e3bb) {
    victim thread function_78cce736b3f7cd37(eattacker);
  }

  if(var_bda16165c7ad56e4 == "on") {
    if(var_8d5389838b26e3bb) {
      eattacker damagefeedback::updatedamagefeedback("standard");
    } else {
      eattacker scripts\cp_mp\damagefeedback::updatedamagefeedback("hitnobulletdamage");

      if(isPlayer(eattacker) || isagent(eattacker)) {
        eattacker playlocalsound("hit_marker_dud");
      }
    }

    return 0;
  }

  if(var_bda16165c7ad56e4 == "fade_out") {
    return (idamage * getdvarfloat(@ "hash_447a7caf6eb11aa", 1));
  }

  return idamage;
}

function function_86fe7027eb5a831e() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("giveLoadout");
    function_794f0ecfdb065aab(1);
  }
}

function function_14712550e86f996f(victim, attacker, meansofdeath) {
  if(isDefined(attacker)) {
    attackerteam = attacker.pers["team"];

    if(meansofdeath == "MOD_EXECUTION") {
      attacker function_bed4b73d1e21039();

      if(isDefined(victim.laststandattacker) && victim.laststandattacker != attacker) {
        victim.laststandattacker thread scripts\mp\utility\points::doscoreevent(#"hash_182b223f67e39ef6");
      }

      attacker function_2d23fda08e64a18a();
      attacker function_794f0ecfdb065aab(0);
      attacker incpersstat("slams", 1);
      attacker setextrascore2(attacker.pers["slams"]);
      var_45ab8896b9f3b36e = getdvarint(@ "hash_734eb77424a9cbad", 3);
    } else {
      var_45ab8896b9f3b36e = getdvarint(@ "hash_734eb77424a9cbad", 1);
    }

    scripts\mp\gamescore::giveteamscoreforobjective(attackerteam, var_45ab8896b9f3b36e, 0);
  }
}

function function_794f0ecfdb065aab(var_81b876a9a88f82b5) {
  var_a46e27b9cddbcc3e = -1;

  var_a46e27b9cddbcc3e = getdvarint(@ "hash_d6b402f91d329f0c", -1);

  if(var_81b876a9a88f82b5 && isDefined(self.var_5684c475e6051dd5) && isDefined(self.var_b817fbd95c75c732) && self.lifeid == self.var_5684c475e6051dd5) {
    var_c53d598f47a74ec8 = self.var_b817fbd95c75c732;
  } else if(var_a46e27b9cddbcc3e > -1) {
    if(var_a46e27b9cddbcc3e >= level.var_7b95bf8778b8724e.size) {
      iprintlnbold("<dev string:x4d>" + level.var_7b95bf8778b8724e.size - 1 + "<dev string:x9f>");

      return;
    }

    var_c53d598f47a74ec8 = level.var_7b95bf8778b8724e[var_a46e27b9cddbcc3e];
  } else {
    if(isDefined(self.var_b817fbd95c75c732) && level.var_7b95bf8778b8724e.size > 1) {
      var_fb4a6a4e2bbaa66 = array_difference(level.var_7b95bf8778b8724e, [self.var_b817fbd95c75c732]);
    } else {
      var_fb4a6a4e2bbaa66 = level.var_7b95bf8778b8724e;
    }

    var_c53d598f47a74ec8 = array_random(var_fb4a6a4e2bbaa66);
  }

  _giveexecution(var_c53d598f47a74ec8, 0);
  self.var_b817fbd95c75c732 = var_c53d598f47a74ec8;
  self.var_5684c475e6051dd5 = self.lifeid;
}

function function_2d23fda08e64a18a() {
  if(isDefined(self.executionref)) {
    switch (self.executionref) {
      case #"hash_35045a42d684bc52":
        thread scripts\mp\utility\points::doscoreevent(#"hash_1678ecd83348b794");
        thread function_4e219021780ba52e("slam_splash_gelato");
        break;
      case #"hash_982264d83dbf6f8d":
        thread scripts\mp\utility\points::doscoreevent(#"hash_b6fa59f40f21b237");
        thread function_4e219021780ba52e("slam_splash_caramel");
        break;
      case #"hash_17f631e350a58072":
        thread scripts\mp\utility\points::doscoreevent(#"hash_7c22a7db9e8d45b4");
        thread function_4e219021780ba52e("slam_splash_mochi");
        break;
      case #"hash_84b68933c178cd09":
        thread scripts\mp\utility\points::doscoreevent(#"hash_a96f715246b2ce8b");
        thread function_4e219021780ba52e("slam_splash_chair");
        break;
      case #"hash_f4ad44ebf245e754":
        thread scripts\mp\utility\points::doscoreevent(#"hash_f7b146f7f6eef81b");
        thread function_4e219021780ba52e("slam_splash_pbomb");
        break;
    }
  }
}

function function_4e219021780ba52e(splash) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(self isinexecutionattack()) {
    wait 0.1;
  }

  scripts\mp\hud_message::showsplash(splash);
}

function function_d1706ac032d53d89() {
  level._effect["slam_phd_explode_sm"] = loadfx("vfx/jup/modes/vfx_powerup_dive.vfx");
  level._effect["slam_phd_explode_md"] = loadfx("vfx/jup/modes/vfx_powerup_dive_med.vfx");
  level._effect["slam_phd_explode_lg"] = loadfx("vfx/jup/modes/vfx_powerup_dive_lrg.vfx");
}

function function_c99f94326ccb590a() {
  self endon("disconnect");
  level endon("game_ended");
  var_4376bdd48580556a = 0;
  var_53280e126ee4cdf5 = undefined;

  while(true) {
    if(isreallyalive(self) && !isinlaststand(self)) {
      var_e57af20a66773aa7 = undefined;

      if(self function_c36cfe1c6acaef46()) {
        if(!var_4376bdd48580556a) {
          var_4376bdd48580556a = 1;
          var_53280e126ee4cdf5 = self.origin[2];
        }

        if(self isonground() && var_4376bdd48580556a) {
          var_e57af20a66773aa7 = var_53280e126ee4cdf5 - self.origin[2];
          level childthread function_61b2d4babb5a23c0(self, var_e57af20a66773aa7);
          var_53280e126ee4cdf5 = undefined;
          var_4376bdd48580556a = 0;

          while(self function_c36cfe1c6acaef46()) {
            wait 0.1;
          }
        }
      } else if(self isparachuting() || self isinfreefall()) {
        var_53280e126ee4cdf5 = undefined;
        var_4376bdd48580556a = 0;
      } else if(var_4376bdd48580556a) {
        var_e57af20a66773aa7 = var_53280e126ee4cdf5 - self.origin[2];
        level childthread function_61b2d4babb5a23c0(self, var_e57af20a66773aa7);
        var_53280e126ee4cdf5 = undefined;
        var_4376bdd48580556a = 0;
      }
    }

    waitframe();
  }
}

function function_61b2d4babb5a23c0(attacker, height) {
  var_e2421ad69dcbdfcb = getdvarint(@ "hash_6ab626df6cd7618c", 0);
  var_acb2d21bae49cb2b = getdvarint(@ "hash_ce4d0284ee95f1b6", 125);
  var_1e8299f8103a63d3 = getdvarint(@ "hash_d68ff3aa72a4f354", 300);
  var_6a8e583f0b3abbc3 = getdvarint(@ "hash_e2e678fe79ef290b", 75);
  damagemedium = getdvarint(@ "hash_84b12d022fd0456b", 150);
  var_8aee446bebe070b = getdvarint(@ "hash_1abff81fe7855113", 150);
  var_c0dcd0122430509e = getdvarint(@ "hash_84fc25281456f868", 100);
  var_6e1e771ffcf07060 = getdvarint(@ "hash_e4ea5b789d3542ea", 175);
  var_32c29e69ff9a79aa = getdvarint(@ "hash_42e45479cc85b240", 400);
  var_5ac1568ba1c913a9 = "none";

  if((height >= var_e2421ad69dcbdfcb || var_e2421ad69dcbdfcb <= 0) && height < var_acb2d21bae49cb2b) {
    fx = getfx("slam_phd_explode_sm");
    radius = var_c0dcd0122430509e;
    damage = var_6a8e583f0b3abbc3;
    var_5ac1568ba1c913a9 = "Small";
  } else if(height >= var_acb2d21bae49cb2b && height < var_1e8299f8103a63d3) {
    fx = getfx("slam_phd_explode_md");
    radius = var_6e1e771ffcf07060;
    damage = damagemedium;
    var_5ac1568ba1c913a9 = "Medium";
  } else if(height >= var_1e8299f8103a63d3) {
    fx = getfx("slam_phd_explode_lg");
    radius = var_32c29e69ff9a79aa;
    damage = var_8aee446bebe070b;
    var_5ac1568ba1c913a9 = "Large";
  } else {
    return;
  }

  thread function_db9bef6bd4a145cf(var_5ac1568ba1c913a9, height);

  playerforward = anglesToForward(attacker.angles);
  vfxoffset = (playerforward[0], playerforward[1], 0) * getdvarfloat(@ "hash_91bca76427b5f040", 50);
  playFX(fx, attacker.origin + vfxoffset);
  attacker.var_f90321da34fafbe5 = 1;
  attacker radiusdamage(attacker.origin, radius, damage, damage, attacker, "MOD_CRUSH");
  waitframe();
  attacker.var_f90321da34fafbe5 = 0;
}

function function_78cce736b3f7cd37(attacker) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_bda16165c7ad56e4 = self getscriptablepartstate("slam_aura", 1);

  if(!isDefined(var_bda16165c7ad56e4) || var_bda16165c7ad56e4 == "off") {
    return;
  }

  if(self isinexecutionattack()) {
    childthread function_bf3ceb7f135c7288();
    attacker thread function_f593513dda8ffbe(self);
    wait getdvarfloat(@ "hash_764b5b9c32a8a3d5", 0.5);
  }

  val::reset_all("slam_aura");
  self setscriptablepartstate("slam_aura", "off", 0);

  if(isDefined(self.var_fc71f1119a8ec847)) {
    outlinedisable(self.var_fc71f1119a8ec847, self);
    self.var_fc71f1119a8ec847 = undefined;
  }

  self notify("kill_slam_aura");
}

function function_bf3ceb7f135c7288() {
  self disableexecutionattack();
  waitframe();
  self enableexecutionattack();
}

function function_f593513dda8ffbe(victim) {
  level endon("game_ended");
  payload = [#"teamselect", victim getentitynumber()];
  indicator = spawnscriptable("mp_slam_interrupt_danger_indicator", (0, 0, 0), (0, 0, 0), self, payload);
  indicator setscriptablepartstate("main", "on");
  victim thread scripts\mp\hud_message::showsplash("slam_interrupted");
  waittill_any_timeout_1(1.5, "death_or_disconnect");
  indicator freescriptable();
}

function function_d0b0c15fe651dd0f() {
  game["dialog"]["gametype"] = "dx_mp_mpct_mode_ctrd_name";
  game["dialog"]["offense_obj"] = "dx_mp_mpct_mode_ctrd_bost";
  game["dialog"]["defense_obj"] = "dx_mp_mpct_mode_ctrd_bost";
  game["dialog"]["slam_selfRevive"] = "dx_mp_mpct_mode_ctrd_gsrv";
  level.var_97a53e173c277570 = 2;
}

function function_5febe066472a9de5(dialog) {
  if(issubstr(dialog, "gmst_anno") || dialog == "dx_mp_mpct_mode_ctrd_name" || dialog == "dx_mp_mpct_mode_ctrd_bost" || dialog == "dx_mp_mpct_mode_ctrd_gsrv") {
    return 1;
  }
}

function function_6abe4ad568596595(dialog) {
  if(issubstr(dialog, "gmst_anno")) {
    prefix = "dx_mp_mpct_mode_ctrd_";
    var_9ae55bedba1d14d6 = strtok(dialog, "_");
    return (prefix + var_9ae55bedba1d14d6[5]);
  }

  return dialog;
}

function function_10d71f04bcc13032(newvalue) {
  level.laststandtimer = newvalue;
}

function function_db9bef6bd4a145cf(var_5ac1568ba1c913a9, height) {
  if(getdvarint(@ "hash_620591c9220c726d", 0) == 1) {
    wait 0.5;
    iprintlnbold("<dev string:xa4>" + var_5ac1568ba1c913a9 + "<dev string:xae>" + height + "<dev string:x9f>");
  }
}

function function_8405385af988a5ca(waitduration) {
  self endon("<dev string:xc0>");
  level endon("<dev string:xce>");
  wait waitduration;
  enemyteam = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  teammates = callsharedfunc("<dev string:xdc>", "<dev string:xe4>", enemyteam, "<dev string:xf3>");
  var_e2dba606375aabe8 = undefined;

  foreach(teammate in teammates) {
    if(!teammate isinexecutionvictim() && isbot(teammate)) {
      var_e2dba606375aabe8 = teammate;
      break;
    }
  }

  if(isDefined(var_e2dba606375aabe8)) {
    var_f7ef71d15e0afd17 = self.origin + anglesToForward(self.angles) * -50;
    var_e2dba606375aabe8 setOrigin(var_f7ef71d15e0afd17);
    waitframe();
    function_61b2d4babb5a23c0(var_e2dba606375aabe8, 1);
  }
}

function function_8ae8cd21b1d4af25(waittime) {
  self endon("<dev string:xc0>");
  level endon("<dev string:xce>");
  wait waittime;
  self.var_77958c90d8cffeb1 = 1;
}

# /
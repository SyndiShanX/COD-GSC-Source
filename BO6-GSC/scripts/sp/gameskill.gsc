/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\gameskill.gsc
**************************************/

#using scripts\common\gameskill;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\mgturret;
#using scripts\sp\player;
#namespace gameskill;

function init_gameskill() {
  if(!utility::add_init_script("\x0fh\xd5\f\x13\x04T?\xaf", &init_gameskill)) {
    return;
  }

  auto_adjust_init();
  player_sp::init();
  level.player.gameskill = level.player function_8ea629c3942d04cc();
  setgameskill(level.player.gameskill);
  set_early_level();
  setskill();
}

function function_5a3ab86548f68517(difficulty, key, val, var_f42f5d2664dd066 = 0) {
  if(var_f42f5d2664dd066 && difficulty == "2\x9fR\xb1") {
    assert(isDefined(level.difficultysettings[key][level.difficultytype[0]]), "<dev string:x24>" + key + "<dev string:x3f>");
  }

  if(!isDefined(val)) {
    return;
  }

  level.difficultysettings[key][difficulty] = val;
}

function setskill(reset) {
  if(!istrue(reset)) {
    if(isDefined(level.gameskill)) {
      return;
    }

    level.difficultytype[0] = "\x89\xcb\x96\x99}sL\xa2\x82";
    level.difficultytype[1] = "2\x9fR\xb1";
    level.difficultytype[2] = "+0a<s,";
    level.difficultytype[3] = "\x9dO\x86 \xb6\x1aV\x10";
    level.difficultytype[4] = "\xa7\x0f\xe8\xd2\x8d\xe3/";
    level.difficultytype[5] = "\x1e\x91\x8c\x10\x0e\x9d\x86";
    level.difficultystring["2\x9fR\xb1"] = &"gameskill_easy";
    level.difficultystring["+0a<s,"] = &"gameskill_normal";
    level.difficultystring["\x9dO\x86 \xb6\x1aV\x10"] = &"gameskill_hardened";
    level.difficultystring["\xa7\x0f\xe8\xd2\x8d\xe3/"] = &"gameskill_veteran";
    level.difficultystring["\x1e\x91\x8c\x10\x0e\x9d\x86"] = &"gameskill_realism";
    thread gameskill_change_monitor();
  }

  bundle = getscriptbundle("t}a\xc7\x95\xf8\x04,t\rY<uP" + level.gamemodebundle.gameskilldata);

  foreach(i, difficultydata in bundle.difficulties) {
    diff = level.difficultytype[i];
    function_5a3ab86548f68517(diff, "^=b+\x1d\xaa\xda\x8c\xa3\x02\x834\xb7\xa4\xfa\xfa\xb5\xdc\xb6", difficultydata.ai.base_enemy_accuracy);
    function_5a3ab86548f68517(diff, "]\xf7WR\xba\xa6\xc0(\xb74\xb7X\xb6@S\xfaa", difficultydata.ai.accuracydistscale);
    function_5a3ab86548f68517(diff, "'\xcf\xa3\x06a\x03\x11\xea\x8f\x82\xfe\x1b[\xcf\x96\xa1", difficultydata.ai.misstimeconstant, 1);
    function_5a3ab86548f68517(diff, "\xcb16\\\xecA\xc7\xd2O\xba\xf7N\x97R\xd4\xf7\x84\xef\xba\x1bz\xe4", difficultydata.ai.misstimedistancefactor, 1);
    function_5a3ab86548f68517(diff, "&\xb2^\xd0e\xc84\x05\xe3\x8d\xce^re\x860&\xd6 \xf1OH\f}\xc7t", difficultydata.ai.misstimefrombehindoverride);
    function_5a3ab86548f68517(diff, "EW\x87\xfa\xfa\xb8\x90\xe9\xffX\xa1\x9a\xfabA\xf9[\x97\x9ac\xe7:\xb8\x03\x9bv\x8d", difficultydata.ai.min_sniper_burst_delay_time);
    function_5a3ab86548f68517(diff, "\xd3\x1b\xbf\xb6\xd2\xf3\xe2\x97\xfa\xd2\x19\xae\x92>3\xd1\x9b>\xb2\xb2R\xf3\xee\a\xfd\x97\xfa", difficultydata.ai.max_sniper_burst_delay_time);
    function_5a3ab86548f68517(diff, "c`==u\xfa\x98kmLg5T\xfd\xd4s\xb1\xa8?", difficultydata.ai.sniperaccudiffscale);
    function_5a3ab86548f68517(diff, "x\xce|(Au_;`\xc5u>\x93\x87F\xe0\v\x10\xf2\xc1\x82", difficultydata.ai.sniper_converge_scale);
    function_5a3ab86548f68517(diff, "yCvz\xdc\x92Ui\x10\x94.\xb1\xf9p\x94Lqu\xe1\x19\x94", difficultydata.ai.playergrenadebasetime);
    function_5a3ab86548f68517(diff, "p\xd8\v/+\xc9GN\xac\xdc\v\x91\xac%\x85s\xce\x95*\xa5\xadY", difficultydata.ai.playergrenaderangetime);
    function_5a3ab86548f68517(diff, "NG3\xe2\xeagI\x0er\x02\x82\xfcq\xe6s\x84\x11\xe4\x15HS\x0f\x93", difficultydata.ai.double_grenades_allowed);
    function_5a3ab86548f68517(diff, "\xd7o\xda\a<\xedn\xf8\x90H\f\xdc\x94+\xa5(\x10\xa6\xfaL\x1e\x16W", difficultydata.ai.playerdoublegrenadetime);
    function_5a3ab86548f68517(diff, "O\xd6\x14\n\xf6\xf5RE\xc0$?\x8c\xf6\xd7$P=6\x94\xc7\xe6N6D\xc0\x1ev", difficultydata.ai.player_diedrecentlycooldown);
  }

  foreach(difficultydata in bundle.difficulties) {
    diff = level.difficultytype[i];
    function_5a3ab86548f68517(diff, "\xa6\x0f\xa5\xfa|\x0ee\xc7\xf0\x9e{RP", difficultydata.player.player_health, 1);
    function_5a3ab86548f68517(diff, "oRf.\xe0\xe0\x1e\x17-\xe8\xdaa^\xc2B\xf9\x18iJ\xddN0\xce", difficultydata.player.player_healthregendelay, 1);
    function_5a3ab86548f68517(diff, "\xc6\xcb/\xb0\xf7\xe43r\x9ce\x04A\xa5\xb9\xcf\xbd\xf1\xea{y\x92!", difficultydata.player.player_healthregenrate, 1);
    function_5a3ab86548f68517(diff, "\x02\r\x1b\x99\x01\xcf\x0e\xf3q\x8b\x1e\xb3\x8e\xb7\xb8t\xf3\x8a", difficultydata.player.invultime_ondamage, 1);
    function_5a3ab86548f68517(diff, "\xfd\xe4i+\nc\x19G\xf0\f \x10|\x87\x99\x0e\xc2\xd9\xa0t\xc6Eon\x97\xe6\x0fl\"", difficultydata.player.invultime_deathshieldduration, 1);
    function_5a3ab86548f68517(diff, "\xe0\x8d\xc2\x97\xac\x9c\xaf\x8ce\xc2t\x1a\x9b\x11\xdb\xf6N\x11\xba'\x85:-\xbd\xb9", difficultydata.player.player_deathsdoorduration, 1);
    function_5a3ab86548f68517(diff, "\xd1\rr\x95\x16\xd1\xc4i,s", difficultydata.player.threatbias);
    function_5a3ab86548f68517(diff, "\x96\r\xe52}\x1d\xad\x9eM\x95\xc5q\x15\xe7\x8d\xb4\x88\x91\x84sTM\x17\xe4\x9fw\xe5\x93", difficultydata.player.player_meleedamagemultiplier);
    function_5a3ab86548f68517(diff, "%\xa0\xe7\xeeuD\x97ej7\f\xa3\xf5;p\xa2\xf6\x80e\xd9+DO\xbe!", difficultydata.player.explosivedamagemultiplier, 1);
    function_5a3ab86548f68517(diff, "\xd8t\xdb\x8fHnLt\x95\xf2}\x84\x0eU\xf55S\xbf\xf86%\xc5\xf2", difficultydata.player.player_maxflashbangtime);

    if(utility::playerarmorenabled()) {
      function_5a3ab86548f68517(diff, "m\x04\xd5\xe0\xef&|\x13\xd1\x98\xc6\xc7", difficultydata.player.player_armor);
      function_5a3ab86548f68517(diff, "\x80\xc84F\x1f\xe5\\\xcb\x11/\xa1b\vY\x1f\xbe\x83T\xfd \xcd\x7fON\xb0}y\xd5\xf6\x88&\x87\x14D(\x1a\xc1", difficultydata.player.player_armorratiohealthregenthreshold);
      function_5a3ab86548f68517(diff, "\x0ec\x85\xbce9}\x859\xb6\xed\x9cD,m\xc2v\xb2T{\te\xc2\xd8\xa3CRaG-{\xd4Z\xb9", difficultydata.player.player_armordamagetohealthratiomin);
      function_5a3ab86548f68517(diff, "\xb5\xcf\x13\xb7\xcf\xe9\x80\xf2:\x06,\n\xfb\x03n\xb1\xb3,^5\xa4\xad\x15\xb5\xa7I\xe1.\xf6!\x8e\xfa\xf2\xcb", difficultydata.player.player_armordamagetohealthratiomax);
    }

    function_5a3ab86548f68517(diff, "l\xa2%\xb2\x0f+\xb39\xdc\x15\x10\x83H", difficultydata.player.player_flinch);
    function_5a3ab86548f68517(diff, "C\x15m\x81e\x99\xf5_\xa5\x8b\xe5\xca\xee>$\x03\xc0\x0efnD", difficultydata.player.player_swimbreathtime);
    function_5a3ab86548f68517(diff, "?(~I\xcdJ\xb1x\x87\x8bB\x15\xa8L\xc0\x86\x1aW\x06\x96*\x95e\x0eb\x04M", difficultydata.player.player_swimsprintbreathtime);
    function_5a3ab86548f68517(diff, "\xc1\xd8,\xcb+\xe4\xaf\xe6\xbbKk\x12\x93\xac\xb0\x8eh\x8a\xb4[\xb2\x86'\xd2\xa3", difficultydata.player.player_swimbreathtimecrit);
    function_5a3ab86548f68517(diff, "5\xa1\xf0\xb8{/!\x9f\xf8j\x04\xb2\x82\xd4\x96\xa5[\xdcjy\xb6\xa7\xfa \x1c\a\xab:C{|", difficultydata.player.player_swimbreathtimecritsprint);
    function_5a3ab86548f68517(diff, "z9\x7fnm\x12X\xa2\xcc\x19\x16\x92>\x82\xd6-\x95\xaf\xa7R\v1\xc1\xb4\x7f", difficultydata.player.player_swimbreathfilltime);
    function_5a3ab86548f68517(diff, "\x97\xaa_>\x18e\xf2\xbc-Z2\x99pW\xcefOP\xcf\x18\x19", difficultydata.player.player_fireengulfrate, 1);
    function_5a3ab86548f68517(diff, "W/\xca\x05\xdc\xeai\xd4\xe8T\x9f\xf7\xc0{u\xa0[\xe7\xaa\x80>\x87E", difficultydata.player.player_fireinvulseconds, 1);
  }

  updategameskill();
  updatealldifficulty();
}

function setdifficultysetting(skillvaluename, difficulty, value) {
  if(!isDefined(difficulty)) {
    foreach(difficulty in level.difficultytype) {
      level.difficultysettings[skillvaluename][difficulty] = value;
    }

    return;
  }

  level.difficultysettings[skillvaluename][difficulty] = value;
}

function updatealldifficulty() {
  setglobaldifficulty();

  foreach(player in level.players) {
    player setdifficulty();
  }
}

function setdifficulty() {
  assert(isPlayer(self));
  assert(isDefined(self.gameskill));
  auto_adjust_data_reset();
  set_difficulty_from_locked_settings();
}

function setglobaldifficulty() {
  anim.pain_test = get_difficultysetting_global("\x9e\xd2\xa7u\xb8\xf0Z\x1dm");
  level.explosiveplanttime = get_difficultysetting_global("De\xb4\x1d>\x99MT\xa6\r\xaa\xd1\xbb\xf3Z\xf4\"\xdd");
  function_2ef63abbe2ba6385(get_difficultysetting_global("EW\x87\xfa\xfa\xb8\x90\xe9\xffX\xa1\x9a\xfabA\xf9[\x97\x9ac\xe7:\xb8\x03\x9bv\x8d"));
  function_d832ed5127ddce8f(get_difficultysetting_global("\xd3\x1b\xbf\xb6\xd2\xf3\xe2\x97\xfa\xd2\x19\xae\x92>3\xd1\x9b>\xb2\xb2R\xf3\xee\a\xfd\x97\xfa"));
  setsaveddvar(@ "ai_accuracydistscale", get_difficultysetting_global("]\xf7WR\xba\xa6\xc0(\xb74\xb7X\xb6@S\xfaa"));
  level.playermeleedamagemultiplier_dvar = get_difficultysetting_global("\x96\r\xe52}\x1d\xad\x9eM\x95\xc5q\x15\xe7\x8d\xb4\x88\x91\x84sTM\x17\xe4\x9fw\xe5\x93");
  setsaveddvar(@ "player_meleedamagemultiplier", level.playermeleedamagemultiplier_dvar);
  mgturret::setdifficulty();

  if(utility_sp::in_realism_mode()) {
    setomnvar("\x99@#\x86\x91\xdf\x81\xfb\xe1n\xc4\xaaU0", 1);
    setsaveddvar(@ "g_friendlynamedist", 0);
    setsaveddvar(@ "hash_8a0793d909d5cbd", 0);
    setsaveddvar(@ "hash_5792c3460a6734d4", 0);
    return;
  }

  setomnvar("\x99@#\x86\x91\xdf\x81\xfb\xe1n\xc4\xaaU0", 0);
  setsaveddvar(@ "g_friendlynamedist", 15000);
  setsaveddvar(@ "hash_8a0793d909d5cbd", 1);
  setsaveddvar(@ "hash_5792c3460a6734d4", 1);
}

function updategameskill() {
  foreach(player in level.players) {
    player.gameskill = player utility_sp::get_player_gameskill();
  }

  level.gameskill = level.player.gameskill;

  if(isDefined(level.forcedgameskill)) {
    level.gameskill = level.forcedgameskill;
  }

  assert(level.gameskill >= 0 && level.gameskill <= 4);
  return level.gameskill;
}

function gameskill_change_monitor() {
  current_gameskill = level.gameskill;

  while(true) {
    if(!isDefined(current_gameskill)) {
      wait 1;
      current_gameskill = level.gameskill;
      continue;
    }

    if(!isDefined(level.lowestgameskill)) {
      level.lowestgameskill = level.gameskill;
    }

    if(current_gameskill != updategameskill()) {
      current_gameskill = level.gameskill;
      level.lowestgameskill = current_gameskill < level.lowestgameskill ? current_gameskill : level.lowestgameskill;
      level.player setplayerprogression("\x02v\xe8\x97\x84\x17\xc2\xfeq\xb4{aU\xb7\xc2\x87", current_gameskill + 1);
      updatealldifficulty();
    }

    wait 1;
  }
}

function function_8ea629c3942d04cc() {
  val = self getplayerprogression("\x02v\xe8\x97\x84\x17\xc2\xfeq\xb4{aU\xb7\xc2\x87");

  if(val == 0) {
    val = 2;
  }

  return val - 1;
}

function apply_difficulty_settings(current_frac) {
  assert(isPlayer(self));
  function_7967c042463a68e1(get_difficultysetting_frac("O\xd6\x14\n\xf6\xf5RE\xc0$?\x8c\xf6\xd7$P=6\x94\xc7\xe6N6D\xc0\x1ev", current_frac));
  self.gs.maxflashbangtime = get_difficultysetting_frac("\xd8t\xdb\x8fHnLt\x95\xf2}\x84\x0eU\xf55S\xbf\xf86%\xc5\xf2", current_frac);
  self.gs.invultime_ondamage = get_difficultysetting_frac("\x02\r\x1b\x99\x01\xcf\x0e\xf3q\x8b\x1e\xb3\x8e\xb7\xb8t\xf3\x8a", current_frac);
  self.gs.invultime_deathshieldduration = get_difficultysetting_frac("\xfd\xe4i+\nc\x19G\xf0\f \x10|\x87\x99\x0e\xc2\xd9\xa0t\xc6Eon\x97\xe6\x0fl\"", current_frac);
  self.gs.deathsdoorduration = get_difficultysetting_frac("\xe0\x8d\xc2\x97\xac\x9c\xaf\x8ce\xc2t\x1a\x9b\x11\xdb\xf6N\x11\xba'\x85:-\xbd\xb9", current_frac);
  self.gs.healthregendelay = get_difficultysetting_frac("oRf.\xe0\xe0\x1e\x17-\xe8\xdaa^\xc2B\xf9\x18iJ\xddN0\xce", current_frac);
  self.gs.healthregenrate = get_difficultysetting_frac("\xc6\xcb/\xb0\xf7\xe43r\x9ce\x04A\xa5\xb9\xcf\xbd\xf1\xea{y\x92!", current_frac);
  self.gs.healthfireinvulseconds = get_difficultysetting_frac("W/\xca\x05\xdc\xeai\xd4\xe8T\x9f\xf7\xc0{u\xa0[\xe7\xaa\x80>\x87E", current_frac);
  self.gs.healthfireengulfrate = get_difficultysetting_frac("\x97\xaa_>\x18e\xf2\xbc-Z2\x99pW\xcefOP\xcf\x18\x19", current_frac);
  self.gs.swimbreathtime = get_difficultysetting_frac("C\x15m\x81e\x99\xf5_\xa5\x8b\xe5\xca\xee>$\x03\xc0\x0efnD", current_frac);
  self.gs.swimbreathtimecrit = get_difficultysetting_frac("\xc1\xd8,\xcb+\xe4\xaf\xe6\xbbKk\x12\x93\xac\xb0\x8eh\x8a\xb4[\xb2\x86'\xd2\xa3", current_frac);
  self.gs.swimbreathtimecritsprint = get_difficultysetting_frac("5\xa1\xf0\xb8{/!\x9f\xf8j\x04\xb2\x82\xd4\x96\xa5[\xdcjy\xb6\xa7\xfa \x1c\a\xab:C{|", current_frac);
  self.gs.swimsprintbreathtime = get_difficultysetting_frac("?(~I\xcdJ\xb1x\x87\x8bB\x15\xa8L\xc0\x86\x1aW\x06\x96*\x95e\x0eb\x04M", current_frac);
  self.gs.swimbreathfilltime = get_difficultysetting_frac("z9\x7fnm\x12X\xa2\xcc\x19\x16\x92>\x82\xd6-\x95\xaf\xa7R\v1\xc1\xb4\x7f", current_frac);
  self.gs.player_attacker_accuracy = get_difficultysetting_frac("^=b+\x1d\xaa\xda\x8c\xa3\x02\x834\xb7\xa4\xfa\xfa\xb5\xdc\xb6", current_frac);
  update_player_attacker_accuracy();
  self.gs.playergrenadebasetime = int(get_difficultysetting_frac("yCvz\xdc\x92Ui\x10\x94.\xb1\xf9p\x94Lqu\xe1\x19\x94", current_frac));
  self.gs.playergrenaderangetime = int(get_difficultysetting_frac("p\xd8\v/+\xc9GN\xac\xdc\v\x91\xac%\x85s\xce\x95*\xa5\xadY", current_frac));
  self.gs.playerdoublegrenadetime = int(get_difficultysetting_frac("\xd7o\xda\a<\xedn\xf8\x90H\f\xdc\x94+\xa5(\x10\xa6\xfaL\x1e\x16W", current_frac));
  function_ff65b722d597019e(get_difficultysetting_frac("EW\x87\xfa\xfa\xb8\x90\xe9\xffX\xa1\x9a\xfabA\xf9[\x97\x9ac\xe7:\xb8\x03\x9bv\x8d", current_frac));
  function_5daaf0da2a48a118(get_difficultysetting_frac("\xd3\x1b\xbf\xb6\xd2\xf3\xe2\x97\xfa\xd2\x19\xae\x92>3\xd1\x9b>\xb2\xb2R\xf3\xee\a\xfd\x97\xfa", current_frac));
  var_94ffec2159bb7560 = 1;

  if(level.gameskill == 0) {
    var_94ffec2159bb7560 = 2;
  }

  function_d5075be355b3577f(get_difficultysetting_frac("c`==u\xfa\x98kmLg5T\xfd\xd4s\xb1\xa8?", current_frac), var_94ffec2159bb7560, 1);
  self.gs.flinchmultiplier = get_difficultysetting_frac("l\xa2%\xb2\x0f+\xb39\xdc\x15\x10\x83H", current_frac);
  self.gs.damagemultiplierhealth = self.maxhealth / get_difficultysetting_frac("\xa6\x0f\xa5\xfa|\x0ee\xc7\xf0\x9e{RP", current_frac);
  self.gs.damagemultiplierexplosive = get_difficultysetting_frac("%\xa0\xe7\xeeuD\x97ej7\f\xa3\xf5;p\xa2\xf6\x80e\xd9+DO\xbe!", current_frac);

  if(utility::playerarmorenabled()) {
    self.gs.armorratiohealthregenthreshold = get_difficultysetting_frac("\x80\xc84F\x1f\xe5\\\xcb\x11/\xa1b\vY\x1f\xbe\x83T\xfd \xcd\x7fON\xb0}y\xd5\xf6\x88&\x87\x14D(\x1a\xc1", current_frac);
    self.gs.armordamagetohealthratiomin = get_difficultysetting_frac("\x0ec\x85\xbce9}\x859\xb6\xed\x9cD,m\xc2v\xb2T{\te\xc2\xd8\xa3CRaG-{\xd4Z\xb9", current_frac);
    self.gs.armordamagetohealthratiomax = get_difficultysetting_frac("\xb5\xcf\x13\xb7\xcf\xe9\x80\xf2:\x06,\n\xfb\x03n\xb1\xb3,^5\xa4\xad\x15\xb5\xa7I\xe1.\xf6!\x8e\xfa\xf2\xcb", current_frac);
    self.gs.damagemultiplierarmor = 100 / get_difficultysetting_frac("m\x04\xd5\xe0\xef&|\x13\xd1\x98\xc6\xc7", current_frac);
  }

  self.threatbias = int(get_difficultysetting_frac("\xd1\rr\x95\x16\xd1\xc4i,s", current_frac));
  level.gameskillmisstimefrombehindoverride = get_difficultysetting("&\xb2^\xd0e\xc84\x05\xe3\x8d\xce^re\x860&\xd6 \xf1OH\f}\xc7t");
  enemy_ai = getaiarray("?\xb1\xc0\x9a");
  utility_sp::post_load_precache(&function_bbf7086992f86b3a);

  foreach(ai in enemy_ai) {
    ai function_b1ed83267e662a1();
  }

  updateplayersettings();
}

function function_bbf7086992f86b3a() {
  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &function_b1ed83267e662a1);
}

function function_b1ed83267e662a1() {
  if(isDefined(level.gameskillmisstimefrombehindoverride)) {
    self.gameskillmisstimefrombehindoverride = level.gameskillmisstimefrombehindoverride;
  }
}

function set_difficulty_from_locked_settings() {
  apply_difficulty_settings(1);
  apply_difficulty_settings_shared(1);
}

function resetskill() {
  waittillframeend();
  setskill(1);
}

function update_player_attacker_accuracy() {
  if(utility::ent_flag("UGz\xa4\xbb\xd1R@\x11.\xa4\xf3\"\xfa\x82r\x02<\xf7\x9c\xac\x1c\x91\xa32\x1eH\x0f\x1e")) {
    return;
  }

  if(!isDefined(self.scriptedignorerandombulletdamage)) {
    self.scriptedignorerandombulletdamage = 0;
  }

  if(!isDefined(self.scriptedattackeraccuracy)) {
    self.scriptedattackeraccuracy = 1;
  }

  self.ignorerandombulletdamage = self.scriptedignorerandombulletdamage;
  self.attackeraccuracy = self.gs.player_attacker_accuracy * self.scriptedattackeraccuracy;
}

function auto_adjust_init() {
  setdvarifuninitialized(@ "hash_ea3e0064074fd39b", 1);

  if(getprojectname() == "_\xde_") {
    setdvarifuninitialized(@ "hash_84003ec62f06a169", 0);
  } else {
    setdvarifuninitialized(@ "hash_84003ec62f06a169", 1);
  }

  level.auto_adjust = spawnStruct();
  level.auto_adjust.data = [];
  level.auto_adjust.playerdead = 0;

  if(!getdvarint(@ "hash_ea3e0064074fd39b")) {
    return;
  }

  level thread auto_adjust_thread();
}

function auto_adjust_data_reset() {
  level.auto_adjust.currenttier = 0;
  level.auto_adjust.currentfrac = 0;
  level.auto_adjust.nextsave_buffer = 60000;
  auto_adjust_data_set("\xdfTs\xfc\xb2c\xc9U\xf0\xcc\x10\xe3J", -1);
  auto_adjust_data_set("tW%^\xb6\xb75$\x1d\xf1\x1f\xc6\xff{", 0);
  auto_adjust_data_set("v\x18I\x0f\xcc(\x96\xb0su#m\xecI\xb8\x9e\x04", 0);
  auto_adjust_data_set("\xda\x9c{!\xbb\xa8\xcf\xd4\x91\xf2X\x82[", gettime() + level.auto_adjust.nextsave_buffer);
  auto_adjust_set_table();
}

function auto_adjust_set_table() {
  level.auto_adjust.table = [];

  if(level.gameskill == 2) {
    level.auto_adjust.table[0] = 0;
    level.auto_adjust.table[5] = 0.3;
    level.auto_adjust.table[7] = 0.5;
    level.auto_adjust.table[9] = 0.6;
    return;
  }

  level.auto_adjust.table[0] = 0;
  level.auto_adjust.table[3] = 0.3;
  level.auto_adjust.table[4] = 0.5;
  level.auto_adjust.table[5] = 0.7;
  level.auto_adjust.table[6] = 0.9;
}

function auto_adjust_thread() {
  waitframe();
  version = getbuildversion();

  while(true) {
    if(level.gameskill > 2) {
      if(version != "gy\x8b\xd7") {
        if(getdvarint(@ "hash_84003ec62f06a169") == 1) {
          auto_adjust_debuglite();
        } else if(getdvarint(@ "hash_84003ec62f06a169") > 1) {
          auto_adjust_debug();
        }
      }

      wait 1;
      continue;
    }

    if(!level.auto_adjust.playerdead) {
      deathcount = auto_adjust_data_get("v\x18I\x0f\xcc(\x96\xb0su#m\xecI\xb8\x9e\x04");
      tabledeathcount = deathcount;

      foreach(index, _ in level.auto_adjust.table) {
        if(deathcount >= index) {
          tabledeathcount = index;
        }
      }

      level.player auto_adjust_difficulty(tabledeathcount);
    }

    if(version != "gy\x8b\xd7") {
      if(getdvarint(@ "hash_84003ec62f06a169") == 1) {
        auto_adjust_debuglite();
      } else if(getdvarint(@ "hash_84003ec62f06a169") > 1) {
        auto_adjust_debug();
      }
    }

    waitframe();
  }
}

function can_auto_adjust(deathcount) {
  if(!isDefined(level.auto_adjust.table[deathcount])) {
    return false;
  }

  if(level.auto_adjust.table[deathcount] == level.auto_adjust.currentfrac) {
    return false;
  }

  return true;
}

function auto_adjust_difficulty(deathcount) {
  if(!can_auto_adjust(deathcount)) {
    return;
  }

  level.auto_adjust.currentfrac = level.auto_adjust.table[deathcount];
  self.gs.invultime_ondamage = auto_adjust_lerp_setting("\x02\r\x1b\x99\x01\xcf\x0e\xf3q\x8b\x1e\xb3\x8e\xb7\xb8t\xf3\x8a");
  self.gs.invultime_deathshieldduration = auto_adjust_lerp_setting("\xfd\xe4i+\nc\x19G\xf0\f \x10|\x87\x99\x0e\xc2\xd9\xa0t\xc6Eon\x97\xe6\x0fl\"");
  self.gs.deathsdoorduration = auto_adjust_lerp_setting("\xe0\x8d\xc2\x97\xac\x9c\xaf\x8ce\xc2t\x1a\x9b\x11\xdb\xf6N\x11\xba'\x85:-\xbd\xb9");
  self.gs.healthregendelay = auto_adjust_lerp_setting("oRf.\xe0\xe0\x1e\x17-\xe8\xdaa^\xc2B\xf9\x18iJ\xddN0\xce");
  self.gs.healthregenrate = auto_adjust_lerp_setting("\xc6\xcb/\xb0\xf7\xe43r\x9ce\x04A\xa5\xb9\xcf\xbd\xf1\xea{y\x92!");
  self.gs.healthfireinvulseconds = auto_adjust_lerp_setting("W/\xca\x05\xdc\xeai\xd4\xe8T\x9f\xf7\xc0{u\xa0[\xe7\xaa\x80>\x87E");
  self.gs.healthfireengulfrate = auto_adjust_lerp_setting("\x97\xaa_>\x18e\xf2\xbc-Z2\x99pW\xcefOP\xcf\x18\x19");
  self.gs.flinchmultiplier = auto_adjust_lerp_setting("l\xa2%\xb2\x0f+\xb39\xdc\x15\x10\x83H");
  self.gs.damagemultiplierhealth = self.maxhealth / auto_adjust_lerp_setting("\xa6\x0f\xa5\xfa|\x0ee\xc7\xf0\x9e{RP");
  self.gs.damagemultiplierexplosive = auto_adjust_lerp_setting("%\xa0\xe7\xeeuD\x97ej7\f\xa3\xf5;p\xa2\xf6\x80e\xd9+DO\xbe!");
  self.gameskillmisstimeconstant = auto_adjust_lerp_setting("'\xcf\xa3\x06a\x03\x11\xea\x8f\x82\xfe\x1b[\xcf\x96\xa1");
  self.gameskillmisstimedistancefactor = auto_adjust_lerp_setting("\xcb16\\\xecA\xc7\xd2O\xba\xf7N\x97R\xd4\xf7\x84\xef\xba\x1bz\xe4");
  updateplayersettings();
}

function updateplayersettings() {
  player_sp::updateviewkickscale();
  player_sp::updatedamagemultiplier();
  swim_common::clearbreathcritical();
}

function auto_adjust_lerp_setting(setting) {
  easier_gameskill = self.gameskill - 1;
  var_ec655af4a293a818 = get_difficultysetting(setting, easier_gameskill);
  var_a33f63d043c0553a = get_difficultysetting(setting);
  return math::lerp(var_a33f63d043c0553a, var_ec655af4a293a818, level.auto_adjust.currentfrac);
}

function auto_adjust_data_add(name, add) {
  val = getdvarint(hashcat(@ "hash_82f854ba4d98181e", name)) + add;
  auto_adjust_data_set(name, val);
}

function auto_adjust_data_set(name, val) {
  setDvar(hashcat(@ "hash_82f854ba4d98181e", name), val);
}

function auto_adjust_data_get(name) {
  return getdvarint(hashcat(@ "hash_82f854ba4d98181e", name));
}

function auto_adjust_playerdied() {
  if(!isDefined(level.auto_adjust)) {
    return;
  }

  level.auto_adjust.playerdead = 1;
  count = auto_adjust_data_get("v\x18I\x0f\xcc(\x96\xb0su#m\xecI\xb8\x9e\x04");

  if(count == 7) {
    return;
  }

  auto_adjust_data_add("v\x18I\x0f\xcc(\x96\xb0su#m\xecI\xb8\x9e\x04", 1);
}

function auto_adjust_save_committed() {
  if(!isDefined(level.auto_adjust)) {
    return;
  }

  count = auto_adjust_data_get("v\x18I\x0f\xcc(\x96\xb0su#m\xecI\xb8\x9e\x04");

  if(count == 0) {
    return;
  }

  nextsave_time = auto_adjust_data_get("\xda\x9c{!\xbb\xa8\xcf\xd4\x91\xf2X\x82[");

  if(gettime() > nextsave_time) {
    auto_adjust_data_set("\xda\x9c{!\xbb\xa8\xcf\xd4\x91\xf2X\x82[", gettime() + level.auto_adjust.nextsave_buffer);
  } else {
    return;
  }

  auto_adjust_data_add("v\x18I\x0f\xcc(\x96\xb0su#m\xecI\xb8\x9e\x04", -1);
}

function auto_adjust_difficult_get() {
  return level.gameskill - level.auto_adjust.currentfrac;
}

function auto_adjust_debug() {
  if(isDefined(level.auto_adjust.debuglitehud)) {
    level.auto_adjust.debuglitehud destroy();
  }

  level.auto_adjust.debugprintline = 0;

  if(level.gameskill == 3) {
    auto_adjust_debug_update("<dev string:x67>", -1);
  } else {
    auto_adjust_debug_update("<dev string:x67>", auto_adjust_data_get("<dev string:x82>"));
  }

  auto_adjust_debug_update("<dev string:x97>", level.gameskill);
  auto_adjust_debug_update("<dev string:xb2>", auto_adjust_difficult_get());
  level.auto_adjust.debugprintline++;
  auto_adjust_debug_update("<dev string:xcd>", level.player.gs.healthregendelay, level.player get_difficultysetting("<dev string:xe8>"));
  auto_adjust_debug_update("<dev string:x103>", level.player.gs.healthregenrate, level.player get_difficultysetting("<dev string:x11e>"));
  auto_adjust_debug_update("<dev string:x138>", level.player.gs.healthfireinvulseconds, level.player get_difficultysetting("<dev string:x153>"));
  auto_adjust_debug_update("<dev string:x16e>", level.player.gs.healthfireengulfrate, level.player get_difficultysetting("<dev string:x189>"));
  auto_adjust_debug_update("<dev string:x1a2>", level.player.gs.swimbreathtime, level.player get_difficultysetting("<dev string:x1bf>"));
  auto_adjust_debug_update("<dev string:x1d8>", level.player.gs.swimbreathtimecrit, level.player get_difficultysetting("<dev string:x1f7>"));
  auto_adjust_debug_update("<dev string:x214>", level.player.gs.swimbreathfilltime, level.player get_difficultysetting("<dev string:x232>"));
  auto_adjust_debug_update("<dev string:x24f>", level.player.gs.invultime_ondamage, level.player get_difficultysetting("<dev string:x26a>"));
  auto_adjust_debug_update("<dev string:x280>", level.player.gs.invultime_deathshieldduration, level.player get_difficultysetting("<dev string:x29b>"));
  auto_adjust_debug_update("<dev string:x2bc>", level.player.gs.deathsdoorduration, level.player get_difficultysetting("<dev string:x2d7>"));
  auto_adjust_debug_update("<dev string:x2f4>", level.player.gs.damagemultiplierhealth, level.player.maxhealth / level.player get_difficultysetting("<dev string:x30f>"));
  auto_adjust_debug_update("<dev string:x320>", level.player.gs.damagemultiplierexplosive, level.player get_difficultysetting("<dev string:x33b>"));
  auto_adjust_debug_update("<dev string:x358>", level.player.gameskillmisstimeconstant, level.player get_difficultysetting("<dev string:x373>"));
  auto_adjust_debug_update("<dev string:x387>", level.player.gameskillmisstimedistancefactor, level.player get_difficultysetting("<dev string:x3a2>"));
}

function auto_adjust_debug_update(msg, val, val2) {
  if(!isDefined(level.auto_adjust.debughud)) {
    level.auto_adjust.debughud = [];
  }

  if(!isDefined(level.auto_adjust.debughud[msg])) {
    hud = newhudelem();
    hud.x = 10;
    hud.y = 50 + 10 * level.auto_adjust.debugprintline;
    hud.fontscale = 0.6;
    hud.label = msg;
    hud.font = "}\nK(OP\x17C\xfe\xfc";
    hud.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    hud.value = -999;
    hud.sort = 20;

    if(isDefined(val2)) {
      hud.val2 = newhudelem();
      hud.val2.x = hud.x + 120;
      hud.val2.y = hud.y;
      hud.val2.fontscale = 0.6;
      hud.val2.font = "}\nK(OP\x17C\xfe\xfc";
      hud.val2.label = "\x1f";
      hud.val2.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
      hud.val2.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
      hud.val2.value = -999;
      hud.val2.sort = 20;
    }

    level.auto_adjust.debughud[msg] = hud;
  } else {
    hud = level.auto_adjust.debughud[msg];
  }

  if(hud.value != val) {
    hud setvalue(val);
    hud.value = val;
  }

  if(isDefined(val2)) {
    if(hud.val2.value != val2) {
      hud.val2 setvalue(val2);
      hud.val2.value = val2;
    }
  }

  level.auto_adjust.debugprintline++;
}

function auto_adjust_debuglite() {
  if(isDefined(level.auto_adjust.debughud)) {
    foreach(hud in level.auto_adjust.debughud) {
      if(isDefined(hud.val2)) {
        hud.val2 destroy();
      }

      hud destroy();
    }

    level.auto_adjust.debughud = undefined;
  }

  if(!isDefined(level.auto_adjust.debuglitehud)) {
    hud = newhudelem();
    hud.alignx = "o0\xee\xc1\x8c";
    hud.x = 128;
    hud.y = 5;
    hud.fontscale = 0.7;
    hud.font = "\x91\xca\xcc\v\xab\xd8:";
    hud.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    hud.sort = 20;
    level.auto_adjust.debuglitehud = hud;
  }

  if(isDefined(level.gameskill) && isDefined(level.auto_adjust.currentfrac)) {
    str = "\x06G" + auto_adjust_data_get("v\x18I\x0f\xcc(\x96\xb0su#m\xecI\xb8\x9e\x04") + "\xb6" + level.gameskill - level.auto_adjust.currentfrac;
  }

  if(isDefined(str)) {
    level.auto_adjust.debuglitehud settext(str);
  }
}
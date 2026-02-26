/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\gun.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_7a8059ca02b7b09e;
#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#namespace gun;

function autoexec ignore_systems() {
  if(util::get_game_type() === # "gun_rambo") {
    system::ignore(#"killstreaks");
  }
}

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  player::function_cf3aa03d(&onplayerkilled);
  level.onendgame = &onendgame;
  level.var_a962eeb6 = &function_486a8395;
  callback::on_connect(&onconnect);
  level.givecustomloadout = &givecustomloadout;
  level.setbacksperdemotion = getgametypesetting(#"setbacks");
  level.inactivitykick = 120;
  level.var_f46d16f0 = 1;
  level.var_48ca10f7 = 1;
  level.var_ce802423 = 1;
  level.var_34842a14 = 1;
  level.var_be0e9c3e = "taco_music";

  if(level.gametype === # "gun_rambo") {
    game.musicset = "_rgg";
    level.var_be0e9c3e += game.musicset;
  }

  setDvar(#"hash_137c8b2b96ac6c72", 0.2);
  setDvar(#"compassradarpingfadetime", 0.75);
  spawning::addsupportedspawnpointtype("ffa");
  level.gunprogression = [];
  gunlist = getgametypesetting(#"gunselection");
  function_9ffa772e(gunlist);

  level thread init_devgui();
}

function onconnect() {
  self function_cf465ad9(0);
}

function onstartgametype() {
  level.gungamekillscore = rank::getscoreinfovalue("kill_gun");
  util::registerscorelimit(level.gunprogression.size * level.gungamekillscore, level.gunprogression.size * level.gungamekillscore);
  level.displayroundendtext = 0;
}

function inactivitykick() {
  self endon(#"disconnect", #"death");

  if(sessionmodeisprivate()) {
    return;
  }

  if(level.inactivitykick == 0) {
    return;
  }

  while(level.inactivitykick > self.timeplayed[#"total"]) {
    wait 1;
  }

  if(self.pers[#"participation"] == 0 && self.time_played_moving < 1) {
    globallogic::gamehistoryplayerkicked();
    kick(self getentitynumber(), "GAME/DROPPEDFORINACTIVITY");
  }

  if(self.pers[#"participation"] == 0 && self.timeplayed[#"total"] > 60) {
    globallogic::gamehistoryplayerkicked();
    kick(self getentitynumber(), "GAME/DROPPEDFORINACTIVITY");
  }
}

function onspawnplayer(predictedspawn) {
  if(!level.inprematchperiod) {
    spawning::function_7a87efaa();
  }

  spawning::onspawnplayer(predictedspawn);
  self thread infiniteammo();
  self thread inactivitykick();
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  spawning::function_7a87efaa();

  if(psoffsettime == "MOD_SUICIDE" || psoffsettime == "MOD_TRIGGER_HURT") {
    self thread demoteplayer();
    return;
  }

  if(isDefined(shitloc) && isPlayer(shitloc)) {
    if(shitloc == self) {
      self thread demoteplayer(shitloc);
      return;
    }

    if(isDefined(shitloc.lastpromotiontime) && shitloc.lastpromotiontime + 3000 > gettime()) {
      scoreevents::processscoreevent(#"kill_in_3_seconds_gun", shitloc, self, deathanimduration);
    }

    if(weapons::ismeleemod(psoffsettime) || psoffsettime === "MOD_EXECUTION") {
      scoreevents::processscoreevent(#"humiliation_gun", shitloc, self, deathanimduration);

      if(globallogic_score::gethighestscoringplayer() === self) {
        scoreevents::processscoreevent(#"melee_leader_gun", shitloc, self, deathanimduration);
      }

      self thread demoteplayer(shitloc);
    }

    attackerweapon = shitloc getcurrentweapon();

    if(psoffsettime != "MOD_MELEE_WEAPON_BUTT" && (psoffsettime != "MOD_EXECUTION" || attackerweapon.type === "melee")) {
      shitloc thread promoteplayer(deathanimduration);
    }
  }
}

function onendgame(var_c1e98979) {
  player = round::function_b5f4c9d8();
  match::set_winner(player);
}

function function_9ffa772e(var_ad9f582e = 0) {
  loadouts = getscriptbundle(#"hash_64fc10899d9faf46");

  if(level.gametype === # "gun_rambo") {
    loadouts = getscriptbundle(#"hash_2deaed5c3e4b941");
  }

  if(!isDefined(loadouts)) {
    assertmsg("<dev string:x38>");
    return;
  }

  var_4509f8e = isDefined(loadouts.var_4509f8e) ? loadouts.var_4509f8e : [];

  if(var_4509f8e.size == 0) {
    assertmsg("<dev string:x57>");
    return;
  }

  if(var_ad9f582e < 7) {
    weaponslist = var_4509f8e[var_ad9f582e];
  } else {
    var_ad9f582e = randomint(var_4509f8e.size);
    weaponslist = var_4509f8e[var_ad9f582e];
  }

  if(!isDefined(weaponslist)) {
    assertmsg("<dev string:x72>" + var_ad9f582e + "<dev string:x9c>");
    return;
  }

  tiers = isDefined(weaponslist.tiers) ? weaponslist.tiers : [];

  foreach(i, tier in tiers) {
    if(!isDefined(tier.options)) {
      arrayremoveindex(tiers, i);
    }
  }

  if(tiers.size == 0) {
    assertmsg("<dev string:xa1>" + var_ad9f582e + "<dev string:x9c>");
    return;
  }

  foreach(tier in tiers) {
    options = isDefined(tier.options) ? tier.options : [];

    foreach(i, option in options) {
      if(!isDefined(option.weapon)) {
        arrayremoveindex(options, i);
      }
    }

    if(options.size == 0) {
      continue;
    }

    option = options[randomint(options.size)];

    if(!isDefined(option)) {
      continue;
    }

    weapon = option.weapon;

    if(!isDefined(weapon)) {
      continue;
    }

    attachments = isDefined(option.attachments) ? option.attachments : "";
    blueprintindex = option.var_b704d026 === 1 ? option.blueprintindex : -1;
    camoindex = option.var_b704d026 !== 1 ? option.camoindex : 0;
    addguntoprogression(weapon.name, attachments, blueprintindex, camoindex);
  }

  assert(level.gunprogression.size > 0, "<dev string:xd0>" + var_ad9f582e + "<dev string:x9c>");
}

function addguntoprogression(weaponname, var_45f60e0f, blueprintindex = 0, camoindex) {
  if(isDefined(blueprintindex) && blueprintindex > -1) {
    blueprintindex++;
    var_c4af33 = function_f62a996b(weaponname, blueprintindex);
    weapon = var_c4af33.weapon;
    var_e91aba42 = var_c4af33.var_fd90b0bb;
  } else {
    attachments = strtok(var_45f60e0f, " ");
    weapon = getweapon(weaponname, attachments);

    if(isDefined(camoindex) && camoindex > 0) {
      renderoptions = isDefined(function_ea647602("camo", weapon)) ? function_ea647602("camo", weapon) : [];
      camooption = renderoptions[camoindex].item_index;
    }
  }

  weaponstruct = {};
  weaponstruct.weapon = weapon;
  weaponstruct.var_f879230e = var_e91aba42;
  weaponstruct.camooption = camooption;
  level.gunprogression[level.gunprogression.size] = weaponstruct;
}

function takeoldweapon(oldweapon) {
  self endon(#"death", #"disconnect");
  wait 1;
  self takeweapon(oldweapon);
}

function givecustomloadout(takeoldweapon = 0) {
  self loadout::init_player(!takeoldweapon);
  self cleartalents();
  self clearperks();

  if(level.gametype === # "gun_rambo") {
    self addtalent(#"talent_gungho" + level.game_mode_suffix);
  }

  perks = self getloadoutperks(0);

  foreach(perk in perks) {
    self setperk(perk);
  }

  if(takeoldweapon) {
    oldweapon = self getcurrentweapon();
    weapons = self getweaponslist();

    foreach(weapon in weapons) {
      if(weapon != oldweapon) {
        self takeweapon(weapon);
      }
    }

    self thread takeoldweapon(oldweapon);
  }

  if(!isDefined(self.gunprogress)) {
    self.gunprogress = 0;
  }

  currentweapon = level.gunprogression[self.gunprogress].weapon;
  var_40aa936b = level.gunprogression[self.gunprogress].var_f879230e;
  var_575718af = level.gunprogression[self.gunprogress].camooption;

  if(isDefined(var_575718af)) {
    var_5d2a9d35 = self function_6eff28b5(var_575718af, 0, 0);
  }

  self giveweapon(currentweapon, var_5d2a9d35, var_40aa936b);
  self shoulddoinitialweaponraise(currentweapon, 0);
  self switchtoweapon(currentweapon);
  self disableweaponcycling();

  if(self.firstspawn !== 0) {
    self setspawnweapon(currentweapon);
  }

  primaryoffhand = level.var_34d27b26;
  primaryoffhandcount = 0;
  self giveweapon(primaryoffhand);
  self setweaponammostock(primaryoffhand, primaryoffhandcount);
  self switchtooffhand(primaryoffhand);
  e_whippings = isDefined(getgametypesetting(#"hash_4ca06c610b5d53bd")) ? getgametypesetting(#"hash_4ca06c610b5d53bd") : 0;

  if(!e_whippings) {
    secondaryoffhand = getweapon(#"eq_stimshot");

    if(!isDefined(secondaryoffhand) || secondaryoffhand === level.weaponnone) {
      return;
    }

    self giveweapon(secondaryoffhand);
    self setweaponammoclip(secondaryoffhand, 1);
    self loadout::function_442539("secondarygrenade", secondaryoffhand);
    self ability_util::gadget_power_full(secondaryoffhand);
  }

  actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
  self setactionslot(3, actionslot3);
  self loadout::function_6573eeeb();
}

function private function_cf465ad9(weaponindex) {
  if(!isPlayer(self) || !isDefined(weaponindex)) {
    return;
  }

  weapon = level.gunprogression[weaponindex].weapon;

  if(!isDefined(weapon) || self hasweapon(weapon)) {
    return;
  }

  var_f879230e = level.gunprogression[weaponindex].var_f879230e;
  camooption = level.gunprogression[weaponindex].camooption;

  if(isDefined(camooption)) {
    weaponoptions = self function_6eff28b5(camooption, 0, 0);
  }

  self giveweapon(weapon, weaponoptions, var_f879230e);
  self takeweapon(weapon);
}

function promoteplayer(weaponused) {
  self endon(#"disconnect", #"cancel_promotion");
  level endon(#"game_ended");
  waitframe(1);
  weapon = level.gunprogression[self.gunprogress].weapon;

  if(weaponused.rootweapon == weapon.rootweapon || isDefined(weapon.dualwieldweapon) && weapon.dualwieldweapon.rootweapon == weaponused.rootweapon) {
    if(self.gunprogress < level.gunprogression.size - 1) {
      self.gunprogress++;

      if(isalive(self)) {
        self thread givecustomloadout(1);
        self thread function_5c23e4f5();
        self function_cf465ad9(self.gunprogress + 1);
      }
    }

    pointstowin = self.pers[#"pointstowin"];

    if(pointstowin < level.scorelimit) {
      scoreevents::processscoreevent(#"kill_gun", self, undefined, weaponused);
      self globallogic_score::givepointstowin(level.gungamekillscore);
    }

    self.lastpromotiontime = gettime();
  }
}

function demoteplayer(attacker) {
  self endon(#"disconnect");
  self notify(#"cancel_promotion");
  currentgunprogress = self.gunprogress;

  for(i = 0; i < level.setbacksperdemotion; i++) {
    if(self.gunprogress <= 0) {
      break;
    }

    self globallogic_score::givepointstowin(level.gungamekillscore * -1);
    globallogic_score::_setplayerscore(self, self.score - level.gungamekillscore);
    self.gunprogress--;
    self thread function_5c23e4f5();
  }

  if(currentgunprogress != self.gunprogress && isalive(self)) {
    self thread givecustomloadout(1);
  }

  if(isDefined(attacker)) {
    self stats::function_bb7eedf0(#"humiliate_attacker", 1);
    attacker recordgameevent("capture");
    level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
      #player: attacker, #eventtype: # "capture"});
  }

  self stats::function_bb7eedf0(#"humiliate_victim", 1);
  self.pers[#"humiliated"]++;
  self.humiliated = self.pers[#"humiliated"];
  self recordgameevent("return");
  level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
    #player: self, #eventtype: # "return"});
  self playlocalsound(#"mpl_wager_humiliate");
  self globallogic_audio::leader_dialog_on_player("humiliated");
}

function infiniteammo() {
  self endon(#"death", #"disconnect");

  while(true) {
    wait 0.1;
    weapon = self getcurrentweapon();
    self givemaxammo(weapon);
  }
}

function function_486a8395() {
  ruleweaponsleft = 3;

  minweaponsleft = level.gunprogression.size;

  foreach(player in function_a1ef346b()) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.gunprogress)) {
      continue;
    }

    weaponsleft = level.gunprogression.size - player.gunprogress;

    if(minweaponsleft > weaponsleft) {
      minweaponsleft = weaponsleft;
    }

    if(ruleweaponsleft >= minweaponsleft) {
      return false;
    }
  }

  return true;
}

function function_5c23e4f5() {
  if(is_true(level.var_2179a6bf)) {
    return;
  }

  var_5a4bc4d6 = 18;
  var_ee737733 = 15;

  if(level.gametype === # "gun_rambo") {
    var_5a4bc4d6 = 19;
    var_ee737733 = 17;
  }

  if(self.gunprogress >= var_5a4bc4d6) {
    level thread globallogic_audio::set_music_global("timeout_loop");
    level.var_2179a6bf = 1;
    return;
  }

  if(self.gunprogress >= var_ee737733) {
    self function_130d4cfc();
    return;
  }

  self function_cfef3f4c();
}

function function_130d4cfc() {
  if(!isDefined(self.var_227573ea)) {
    self.var_227573ea = 0;
  }

  if(!is_true(self.var_227573ea)) {
    self thread globallogic_audio::function_c246758e(level.var_be0e9c3e);
    self.var_227573ea = 1;
  }
}

function function_cfef3f4c() {
  if(!isDefined(self.var_227573ea)) {
    self.var_227573ea = 0;
  }

  if(is_true(self.var_227573ea)) {
    self thread globallogic_audio::function_c246758e("none");
    self.var_227573ea = 0;
  }
}

function private init_devgui() {
  util::init_dvar(#"hash_30c63c4ab5be356f", 0, &function_9209a6f8);
  util::init_dvar(#"hash_62d3e4c605defe30", 0, &function_98c43bf8);
  util::waittill_can_add_debug_command();
  adddebugcommand("<dev string:xfc>");
  adddebugcommand("<dev string:x165>");
}

function private function_9209a6f8(params) {
  level notify(#"hash_a1e5a52aeb09e3c");

  if(params.value) {
    thread function_7b2c84d4();
  }
}

function private function_7b2c84d4() {
  player = getplayers()[0];

  if(!isDefined(player)) {
    return;
  }

  player endon(#"disconnect");
  level endon(#"game_ended");

  foreach(i, weaponstruct in level.gunprogression) {
    if(!isalive(player)) {
      break;
    }

    weapon = weaponstruct.weapon;
    var_f879230e = weaponstruct.var_f879230e;
    camooption = weaponstruct.camooption;

    if(isDefined(camooption)) {
      weaponoptions = player function_6eff28b5(camooption, 0, 0);
    }

    player takeweapon(player getcurrentweapon());
    player giveweapon(weapon, weaponoptions, var_f879230e);
    player switchtoweapon(weapon);
    player iprintlnbold("<dev string:x1cc>" + i + 1 + "<dev string:x1d0>" + level.gunprogression.size + "<dev string:x1d5>" + getweaponname(weapon));
    result = level waittilltimeout(3, #"hash_a1e5a52aeb09e3c");

    if(result._notify == "<dev string:x1db>") {
      break;
    }
  }

  fakeweapon = player getcurrentweapon();
  var_b348ce28 = level.gunprogression[player.gunprogress].weapon;
  player thread givecustomloadout(fakeweapon !== var_b348ce28);
  setDvar(#"hash_30c63c4ab5be356f", 0);
}

function private function_98c43bf8(params) {
  level notify(#"hash_1cab686e68228dff");

  if(params.value) {
    thread function_c13efc2d();
  }
}

function private function_c13efc2d() {
  level endon(#"game_ended", #"hash_1cab686e68228dff");
  baseorigin = (350, 70, 0);
  var_e97558ce = (0, 25, 0);

  while(true) {
    debug2dtext(baseorigin, "<dev string:x1fe>", (0, 1, 1), 1, (0, 0, 0), 0.8);

    foreach(i, weaponstruct in level.gunprogression) {
      origin = baseorigin + (i + 1) * var_e97558ce;
      string = "<dev string:x1cc>" + i + 1 + "<dev string:x1d5>" + getweaponname(weaponstruct.weapon);
      debug2dtext(origin, string, (1, 1, 1), 1, (0, 0, 0), 0.8);
    }

    waitframe(1);
  }
}
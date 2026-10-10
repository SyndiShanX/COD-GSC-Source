/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\reinforcement_flare.gsc
***********************************************************/

#using script_5bab271917698dc4;
#using script_64acb6ce534155b7;
#using scripts\common\ae_utility;
#using scripts\common\devgui;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\supers;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace reinforcement_flare;

function autoexec main() {
  level thread init_when_ready();
}

function init_when_ready() {
  level endon("game_ended");
  level waittill("init_supers");
  init();
}

function init() {
  scripts\mp\supers::function_53110a12409d01da("super_reinforcement_flare", undefined, &function_90c4a88974378104, &function_abefbdbd41128e07, undefined, undefined, &function_454bc6bf585af432);
  scripts\engine\utility::registersharedfunc("reinforcement_flare", "grenadeUsed", &function_304d5fa1128c5a76);
  level.var_eed57e4583118823 = spawnStruct();
  level.var_eed57e4583118823.type = getdvarint(@ "hash_fe6d7336b7f92218", 3);
  level.var_eed57e4583118823.delay = getdvarint(@ "hash_9791c5e947b42f3f", 1);
  level.var_eed57e4583118823.var_52c848ed985b69bf = getdvarint(@ "hash_b6d7a4020f569c04", 5000);
  level.var_eed57e4583118823.var_14c8c6253fa5e1ee = getdvarint(@ "hash_578ea151ae11d179", 1);
  level.var_eed57e4583118823.var_a1d415ab15d07845 = getdvarint(@ "hash_3c8c43e7f91baee4", 1);
  level.var_eed57e4583118823.var_60a077e73164fa34 = getdvarint(@ "hash_58392bda66da5795", 1);
  level.var_eed57e4583118823.var_d7397c466ee881e3 = 0;
  level.var_eed57e4583118823.superid = scripts\mp\supers::getsuperid("super_reinforcement_flare");
  init_anim();
  init_dev_gui();
}

#using_animtree("script_model");

function init_anim() {
  notes = getnotetracktimes(%misc_vm_flare_gun_fire, "reinforcement_flare_fired");
  total = getanimlength(%misc_vm_flare_gun_fire);

  if(notes.size > 0) {
    level.var_eed57e4583118823.var_d7397c466ee881e3 = total * notes[0];
  }
}

function init_dev_gui() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  add_devgui_command("<dev string:x36>", "<dev string:x4d>");
  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:x85>");
  add_devgui_command("<dev string:x36>", "<dev string:xa0>");
  function_fe953f000498048f();
}

function function_454bc6bf585af432() {
  function_a69a3c97f0e5fb45(1);
}

function function_90c4a88974378104() {
  function_a69a3c97f0e5fb45(0);
}

function function_a69a3c97f0e5fb45(on) {
  if(!level.var_eed57e4583118823.var_60a077e73164fa34) {
    return;
  }

  superid = on ? level.var_eed57e4583118823.superid : 0;
  scripts\mp\supers::function_7203e7aa96ff0ba9(superid);
}

function function_abefbdbd41128e07() {
  if(getdvarint(@ "hash_138efa1711913cad", 0)) {
    thread function_917bdaef968dc5b4();
    wait level.var_eed57e4583118823.var_d7397c466ee881e3;
    thread function_81973eac6cda5de8();
    wait level.var_eed57e4583118823.delay;
    thread scripts\mp\hud_message::showsplash("<dev string:xe5>");
    scripts\mp\utility\points::doscoreevent(#"hash_6ce458a0c07fd247");
    return false;
  }

  respawnlist = function_59dd9b163e569a63();

  if(!function_be3f53a872e6984(respawnlist, 1)) {
    return false;
  }

  self.super.isactive = 1;
  self disableoffhandspecialweapons();
  thread function_1d40065a3c6120da();
  return true;
}

function function_1d40065a3c6120da() {
  thread function_917bdaef968dc5b4();
  wait level.var_eed57e4583118823.var_d7397c466ee881e3;
  self enableoffhandspecialweapons();
  respawnlist = function_59dd9b163e569a63();

  if(!function_be3f53a872e6984(respawnlist, istrue(level.var_eed57e4583118823.var_a1d415ab15d07845))) {
    scripts\mp\supers::refundsuper();
    return 0;
  }

  function_a69a3c97f0e5fb45(0);
  thread function_81973eac6cda5de8();
  function_bd86834dafc95671(respawnlist);
  wait level.var_eed57e4583118823.delay;
  thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
  scripts\mp\utility\points::doscoreevent(#"hash_6ce458a0c07fd247");
  scripts\mp\gametypes\br_analytics::function_885c6daf0ece2cf6(1, 0);
  scripts\cp_mp\challenges::function_d997435895422ecc("super_reinforcement_flare", ae_utility::function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
}

function function_be3f53a872e6984(respawnlist, var_1604d9f4d5cc32d7) {
  if(!scripts\mp\utility\player::isaliveandnotinlaststand(self)) {
    return 0;
  }

  if(istrue(var_1604d9f4d5cc32d7)) {
    if(self isswimunderwater()) {
      return function_22f07d1048d1a37("reinforcement_flare_underwater", 1);
    }

    if(function_7511c0cbd6c3f1cf()) {
      return function_22f07d1048d1a37("reinforcement_flare_not_enough_space", 2);
    }
  }

  if(respawnlist.size < 1) {
    return function_22f07d1048d1a37("reinforcement_flare_nobody_to_respawn", 3);
  }

  return 1;
}

function function_917bdaef968dc5b4() {
  weapon = makeweapon("reinforcement_flare_mp_br");
  scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(weapon);
}

function function_7511c0cbd6c3f1cf() {
  startpos = self getorigin();
  endpos = startpos + (0, 0, level.var_eed57e4583118823.var_52c848ed985b69bf);
  var_5ed27d399605829 = scripts\engine\trace::create_contents(0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0);
  var_1ac16b7e89c07b85 = scripts\engine\trace::ray_trace_passed(startpos, endpos, self, var_5ed27d399605829);

  if(getdvarint(@ "hash_b57b0de95df4c797", 0)) {
    line(startpos, endpos, ter_op(var_1ac16b7e89c07b85, (0, 1, 0), (1, 0, 0)), 1, 0, 1800);
  }

  return !var_1ac16b7e89c07b85;
}

function function_22f07d1048d1a37(hint, reason) {
  self playlocalsound("br_pickup_deny");
  setlowermessageomnvar(hint, undefined, 5);
  scripts\mp\gametypes\br_analytics::function_885c6daf0ece2cf6(0, reason);
  return false;
}

function function_59dd9b163e569a63() {
  list = [];
  squad = getteamdata(self.team, "players");

  foreach(squadmate in squad) {
    if(!isDefined(squadmate) || squadmate == self) {
      continue;
    }

    if(squadmate function_a36dfafc12f9a469()) {
      list[list.size] = squadmate;
    }
  }

  return list;
}

function function_a36dfafc12f9a469() {
  return scripts\mp\gametypes\br_public::iseligibleforteamrevive() || scripts\mp\gametypes\br_public::function_8f0e6614368f64c2();
}

function function_81973eac6cda5de8() {
  location = self.origin;

  if(self tagexists("tag_weapon_right")) {
    location = self gettagorigin("tag_weapon_right");
  }

  flareoverride = getDvar(@ "hash_58d8dfa7b8338078", "");

  if(flareoverride != "") {
    level namespace_1eb3c4e0e28fac71::utilflare_shootflare(location, flareoverride);
  } else {
    level namespace_1eb3c4e0e28fac71::utilflare_shootflare(location, "reinforcement_flare");
  }

  thread function_e02eb68b52ee2576();
}

function function_e02eb68b52ee2576() {
  player = self;
  player endon("death_or_disconnect");
  player setscriptablepartstate("ReinforcementFlare", "on", 0);
  wait level.var_eed57e4583118823.var_14c8c6253fa5e1ee;
  player setscriptablepartstate("ReinforcementFlare", "off", 0);
}

function function_bd86834dafc95671(respawnlist) {
  switch (level.var_eed57e4583118823.type) {
    case 3:
      respawnlist = array_randomize_objects(respawnlist);
      break;
    case 2:
      respawnlist = scripts\mp\utility\script::quicksort(respawnlist, &function_ae1f6e9c36dbaf8d);
      break;
    case 4:
      respawnlist = scripts\mp\utility\script::quicksort(respawnlist, &function_6061807fd4bf9173);
      break;
    default:
      break;
  }

  if(level.var_eed57e4583118823.type == 1) {
    foreach(squadmate in respawnlist) {
      namespace_8bfdb6eb5a3df67a::br_kioskrevive(squadmate, self, 0, undefined, undefined, undefined, undefined, "reinforcement_flare");
    }

    return;
  }

  var_a4a43a5fca0097ef = respawnlist[0];

  if(istrue(var_a4a43a5fca0097ef.var_632bad3edb4e449e)) {
    foreach(squadmate in respawnlist) {
      if(!istrue(squadmate.var_632bad3edb4e449e)) {
        var_a4a43a5fca0097ef = squadmate;
        break;
      }
    }
  }

  namespace_8bfdb6eb5a3df67a::br_kioskrevive(var_a4a43a5fca0097ef, self, 0, undefined, undefined, undefined, undefined, "reinforcement_flare");
}

function function_ae1f6e9c36dbaf8d(player1, player2) {
  var_22e05fceeb58392a = default_to(player1.var_14110ad8d5069e7, -1);
  var_7ba3baf60b4a6d7 = default_to(player2.var_14110ad8d5069e7, -1);
  return var_22e05fceeb58392a <= var_7ba3baf60b4a6d7;
}

function function_6061807fd4bf9173(player1, player2) {
  var_c86a63410b3461a6 = default_to(player1.plundercount, 0);
  var_55551d86b36ece5f = default_to(player2.plundercount, 0);
  return var_c86a63410b3461a6 >= var_55551d86b36ece5f;
}

function function_304d5fa1128c5a76(grenade) {
  if(isDefined(grenade)) {
    grenade delete();
  }
}
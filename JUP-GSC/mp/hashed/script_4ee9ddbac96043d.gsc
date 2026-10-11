/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4ee9ddbac96043d.gsc
************************************************/

#using script_100adcc1cc11d2fa;
#using script_3390b73ac3318fe;
#using script_3559130ee2bb3a29;
#using script_485622d93fa7e4cf;
#using script_6f65366f542f6627;
#using script_7f9409b703dad400;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pmc_missions;
#namespace namespace_7765eded20782405;

function function_f4c2323079c53ba9() {
  if(istrue(level.var_38fb6b3d12228747)) {
    return;
  }

  riftgate = create_portal();
  level flag_wait("ob_infil_completed");
  activate_portal(riftgate);
}

function create_portal() {
  var_4e87f0484feb2758 = getStruct("s1_mission_rift", "targetname");
  riftgate = utility::spawn_model("jup_zm_rift_portal_small", var_4e87f0484feb2758.origin, var_4e87f0484feb2758.angles);
  waitframe();
  riftgate setscriptablepartstate("aether_exit_body", "rift_mission_infil");
  var_885095f29666fd07 = scripts\cp_mp\interaction::register_interact(riftgate, 140, &function_dd50de34ad9f5b2f);
  var_885095f29666fd07 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_816b580f6517f4fa);
  riftgate hide();
  return riftgate;
}

function function_816b580f6517f4fa(interact, player) {
  if(isDefined(player.team) && isDefined(player.sessionsquadid)) {
    votinginprogress = namespace_af93597583d94051::function_755c94f4a8509b03(player.team, player.sessionsquadid);
  }

  if(istrue(votinginprogress)) {
    return {
      #string: &"JUP_OB_S1/RIFT_TOKEN_VOTE_IN_PROGRESS", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_S1/MISSION_RIFT_ENTRY_HINT", #type: "HINT_BUTTON"};
}

function activate_portal(riftgate) {
  foreach(player in level.players) {
    if(function_c7d3c1cb4a3958cf(player, 27131) || player namespace_9571f642f38c8169::function_3bb8b73991355a1(0) || getdvarint(@ "hash_3b2a312a55f42bcd", 0) == 1) {
      riftgate showtoplayer(player);
      player thread function_771cbd84a236e2ba(riftgate.origin);

      if(function_c7d3c1cb4a3958cf(player, 27131) || getdvarint(@ "hash_3b2a312a55f42bcd", 0) == 1) {
        player thread function_8b67e03b991ac60f();
      }
    }
  }
}

function function_8b67e03b991ac60f() {
  wait 10;
  level thread scripts\cp_mp\overlord::playconversation("quest_s1_rift_intro_conv", [self]);
}

function function_771cbd84a236e2ba(portalloc) {
  while(isDefined(self)) {
    if(distance2dsquared(portalloc, self.origin) < squared(900)) {
      level thread scripts\cp_mp\overlord::playevent("quest_s1_infil_approach", [self]);
      return;
    }

    wait 0.2;
  }
}

function function_eedd40fa46e83c7(player) {
  if(isDefined(player.team) && isDefined(player.sessionsquadid)) {
    votinginprogress = namespace_af93597583d94051::function_755c94f4a8509b03(player.team, player.sessionsquadid);
  }

  if(istrue(votinginprogress)) {
    return;
  }

  level thread scripts\cp_mp\overlord::playevent("quest_s1_infil_interact", player getsquadmembers(undefined, 0));
  player_squad = player getsquadmembers(undefined, 0);

  foreach(var_3329887886bd6a4b in player_squad) {
    self disableplayeruse(var_3329887886bd6a4b);
  }

  namespace_af93597583d94051::function_fd5211de155982af(player.team, player.sessionsquadid, 1);
  namespace_6c57c664b4288f88::function_93c8f90c3bd798c6(player, 30, &function_d7cf952e6f352615);
  namespace_af93597583d94051::function_fd5211de155982af(player.team, player.sessionsquadid, 0);

  foreach(var_3329887886bd6a4b in player_squad) {
    self enableplayeruse(var_3329887886bd6a4b);
  }
}

function function_dd50de34ad9f5b2f(player) {
  thread function_eedd40fa46e83c7(player);
}

function function_d7cf952e6f352615(player) {
  a_squad = player getsquadmembers(undefined, 1);
  n_time_limit = 10;
  timer = namespace_26c5a699d7cb84a2::function_3eec8a169e8a0936(n_time_limit);
  waitframe();

  while(timer.progresscomplete != 1) {
    n_time_remaining = int(timer.currentprogressvalue);

    foreach(squaddie in a_squad) {
      squaddie setclientomnvar("ui_is_exfil_countdown", 1);
      squaddie setclientomnvar("ui_match_start_countdown", n_time_remaining);
    }

    wait 0.5;
  }

  var_de86fccc00b662d7 = [];

  foreach(player in a_squad) {
    if(isalive(player) && player.sessionstate == "playing") {
      var_de86fccc00b662d7[var_de86fccc00b662d7.size] = player;
    }
  }

  a_squad = var_de86fccc00b662d7;

  foreach(player in a_squad) {
    player scripts\common\values::set("rift_gate_teleport", "ignoreme", 1);
    player scripts\common\values::set("rift_gate_teleport", "damage", 0);
    player scripts\common\values::set("rift_gate_teleport", "fire", 0);
    player playerhide();
    player thread namespace_cc781f142d33c074::function_2241b80779e319a0();
  }

  wait 5;
  namespace_cddd3ad399b210ff::function_e229d89e0c38206d(a_squad, 1004);
}
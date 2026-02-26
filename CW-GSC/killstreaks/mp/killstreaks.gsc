/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\killstreaks.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreak_dialog;
#using scripts\killstreaks\mp\killstreak_weapons;
#using scripts\killstreaks\mp\killstreakrules;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\player\player_utils;
#namespace killstreaks;

function private autoexec __init__system__() {
  system::register(#"killstreaks", &preinit, undefined, undefined, #"weapons");
}

function private preinit() {
  init_shared();
  killstreakrules::init();
  killstreak_detect::init_shared();
  callback::on_start_gametype(&init);
  callback::add_callback(#"menu_response", &on_menu_response);
  player::function_cf3aa03d(&killstreak_weapons::onplayerkilled);
  level.var_1492d026 = &killstreak_dialog::play_killstreak_start_dialog;
}

function init() {
  level.killstreak_init_start_time = getmillisecondsraw();
  thread debug_ricochet_protection();

  function_447e6858();
  level.var_b0dc03c7 = &function_395f82d0;
  level.var_19a15e42 = &function_daabc818;
  killstreak_dialog::init();
  callback::callback(#"hash_45f35669076bc317");
  function_f1707039();
  level thread function_d3106952();
  function_1f7e617a();

  level.killstreak_init_end_time = getmillisecondsraw();
  elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
  println("<dev string:x38>" + elapsed_time + "<dev string:x59>");
  level thread killstreak_debug_think();
}

function private function_f1707039() {
  level.var_4b42d599 = [];

  for(i = 0; i < 4; i++) {
    level.var_4b42d599[i] = "killstreaks.killstreak" + i + ".inUse";
    clientfield::register_clientuimodel(level.var_4b42d599[i], 1, 1, "int");
  }

  level.var_46b33f90 = [];
  level.var_ce69c3cb = [];
  level.var_a0d81b28 = max(8, 4);

  for(i = 0; i < level.var_a0d81b28; i++) {
    level.var_46b33f90[i] = "killstreaks.killstreak" + i + ".spaceFull";
    clientfield::register_clientuimodel(level.var_46b33f90[i], 1, 1, "int");
    level.var_ce69c3cb[i] = "killstreaks.killstreak" + i + ".noTargets";
    clientfield::register_clientuimodel(level.var_ce69c3cb[i], 1, 1, "int");
  }
}

function private function_1f7e617a() {
  level.var_b84cb28e = [];
  level.var_b84cb28e[0] = 2;
  level.var_b84cb28e[3] = 0;
  level.var_b84cb28e[1] = 1;
  level.var_b84cb28e[-1] = 3;
}

function private on_menu_response(eventstruct) {
  if(self function_8cc6b278()) {
    return;
  }

  if(self laststand::player_is_in_laststand()) {
    return;
  }

  if(eventstruct.response === "scorestreak_pool_purchase" && level.var_5b544215 === 1) {
    killstreakslot = level.var_b84cb28e[eventstruct.intpayload];

    if(isDefined(killstreakslot)) {
      if(killstreakslot == 3) {
        if(isDefined(self.pers[#"killstreaks"])) {
          var_2a5574a6 = self.pers[#"killstreaks"].size - 1;

          if(var_2a5574a6 >= 0) {
            killstreakweapon = get_killstreak_weapon(self.pers[#"killstreaks"][var_2a5574a6]);
            self switchtoweapon(killstreakweapon);
          }
        }
      } else {
        purchased = globallogic_score::function_13123cee(self, killstreakslot);

        if(purchased) {
          killstreaktype = get_by_menu_name(self.killstreak[killstreakslot]);
          killstreakweapon = get_killstreak_weapon(killstreaktype);
          self switchtoweapon(killstreakweapon);
        }
      }
    }

    return;
  }

  if(eventstruct.response === "scorestreak_pool_purchase_and_use" && level.var_5b544215 === 1) {
    eventstruct = eventstruct;
    var_180d3406 = getscriptbundlelist(level.var_d1455682.var_a45c9c63);
    var_b133a8aa = getscriptbundle(var_180d3406[eventstruct.intpayload]);
    killstreakbundle = getscriptbundle(var_b133a8aa.killstreakbundle);

    if(isDefined(killstreakbundle)) {
      unlockableindex = getitemindexfromref(var_b133a8aa.unlockableitem);
      iteminfo = getunlockableiteminfofromindex(unlockableindex, 0);
      purchased = globallogic_score::function_8b375624(self, killstreakbundle.kstype, iteminfo.momentum);

      if(purchased) {
        self give(killstreakbundle.kstype);
        self switchtoweapon(killstreakbundle.ksweapon);
      }
    }

    return;
  }

  if(eventstruct.response === "scorestreak_use_failed") {
    if(eventstruct.intpayload === 0) {
      if((isDefined(self.var_8700840) ? self.var_8700840 : 0) < gettime()) {
        self killstreak_dialog::play_taacom_dialog("airspaceFull");
        self.var_8700840 = gettime() + int(battlechatter::mpdialog_value("airspaceFullCooldown", 7) * 1000);
      }
    }
  }
}

function function_3b4959c6() {
  return isDefined(level.var_d1455682.var_a45c9c63);
}

function private function_395f82d0(killstreaktype) {
  globallogic_score::_setplayermomentum(self, self.momentum - self function_dceb5542(level.killstreaks[killstreaktype].itemindex));
}

function private function_daabc818(event, player, victim, weapon) {
  scoreevents::processscoreevent(event, player, victim, weapon);
}

function private function_d3106952() {
  self notify("6296e36619695141");
  self endon("6296e36619695141");

  if(function_3b4959c6()) {
    return;
  }

  wait 5;
  var_7d46072 = 1;
  var_e9414fa = 0;

  while(!level.gameended) {
    players = getplayers();

    if(players.size == 0) {
      wait 1;
      continue;
    }

    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!isDefined(player.killstreak)) {
        continue;
      }

      var_6370491b = getarraykeys(player.killstreak);

      foreach(key in var_6370491b) {
        if(!isDefined(key)) {
          continue;
        }

        hardpointtype = player.killstreak[key];

        if(!isDefined(hardpointtype)) {
          continue;
        }

        if(isDefined(level.var_dcc3befb[hardpointtype])) {
          if(!player[[level.var_dcc3befb[hardpointtype]]](key)) {
            player clientfield::set_player_uimodel(level.var_46b33f90[key], 0);
            continue;
          }
        }

        var_63fd3e67 = player killstreakrules::iskillstreakallowed(hardpointtype, player.team, 1, 1);
        player clientfield::set_player_uimodel(level.var_46b33f90[key], !var_63fd3e67);
      }

      if(isDefined(player.pers[#"killstreaks"]) && player.pers[#"killstreaks"].size > 0) {
        player clientfield::set_player_uimodel(level.var_ce69c3cb[3], 0);
        var_8c992ad8 = player.pers[#"killstreaks"][player.pers[#"killstreaks"].size - 1];
        var_e4276bf9 = 1;

        if(isDefined(level.var_dcc3befb[var_8c992ad8])) {
          if(!player[[level.var_dcc3befb[var_8c992ad8]]](3)) {
            player clientfield::set_player_uimodel(level.var_46b33f90[3], 0);
            var_e4276bf9 = 0;
          }
        }

        if(var_e4276bf9) {
          var_63fd3e67 = player killstreakrules::iskillstreakallowed(var_8c992ad8, player.team, 1, 1);
          player clientfield::set_player_uimodel(level.var_46b33f90[3], !var_63fd3e67);
        }
      }

      var_e9414fa++;

      if(var_e9414fa >= var_7d46072) {
        waitframe(1);
        var_e9414fa = 0;
      }
    }
  }
}
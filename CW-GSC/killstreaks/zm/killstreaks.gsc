/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\killstreaks.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\zm\killstreakrules;
#namespace killstreaks;

function private autoexec __init__system__() {
  system::register(#"killstreaks", &preinit, undefined, undefined, #"zm");
}

function private preinit() {
  init_shared();
  killstreak_detect::init_shared();
  killstreakrules::init();
  level.var_fee7acb5 = [];
  level.var_1f616ecc = [];
  level.var_4cc7833a = [];
  callback::on_start_gametype(&init);
  callback::add_callback(#"menu_response", &on_menu_response);
}

function init() {
  level.killstreak_init_start_time = getmillisecondsraw();
  thread debug_ricochet_protection();

  function_447e6858();
  level.var_b0dc03c7 = &function_395f82d0;
  level.var_19a15e42 = &function_daabc818;
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

  level.var_46b33f90[i] = [];
  level.var_173b8ed7 = max(8, 4);

  for(i = 0; i < level.var_173b8ed7; i++) {
    level.var_46b33f90[i] = "killstreaks.killstreak" + i + ".spaceFull";
    clientfield::register_clientuimodel(level.var_46b33f90[i], 1, 1, "int");
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
      } else if(true) {
        killstreaktype = get_by_menu_name(self.killstreak[killstreakslot]);
        killstreakweapon = get_killstreak_weapon(killstreaktype);
        self switchtoweapon(killstreakweapon);
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

      if(true) {
        self give(killstreakbundle.kstype);
        self switchtoweapon(killstreakbundle.ksweapon);
      }
    }
  }
}

function function_3b4959c6() {
  return isDefined(level.var_d1455682.var_a45c9c63);
}

function function_7b6102ed(killstreaktype) {
  level.var_fee7acb5[killstreaktype] = 1;
}

function function_353a9ccd(killstreaktype, func) {
  level.var_1f616ecc[killstreaktype] = func;
}

function function_39c0c22a(killstreaktype, func) {
  level.var_4cc7833a[killstreaktype] = func;
}

function private function_395f82d0(killstreaktype) {}

function private function_daabc818(event, player, victim, weapon) {}

function private function_d3106952() {
  self notify("606d9cc1a6278cc5");
  self endon("606d9cc1a6278cc5");

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

      if(is_true(player.var_6696e200)) {
        continue;
      }

      var_6370491b = getarraykeys(player.killstreak);

      foreach(key in var_6370491b) {
        if(!isDefined(key)) {
          continue;
        }

        var_63fd3e67 = player killstreakrules::iskillstreakallowed(player.killstreak[key], player.team, 1);
        player clientfield::set_player_uimodel(level.var_46b33f90[key], !var_63fd3e67);
      }

      if(isDefined(player.pers[#"killstreaks"]) && player.pers[#"killstreaks"].size > 0) {
        var_8c992ad8 = player.pers[#"killstreaks"][player.pers[#"killstreaks"].size - 1];

        if(is_true(level.var_fee7acb5[var_8c992ad8])) {
          if(!player killstreakrules::function_71e94a3b(var_8c992ad8)) {
            player clientfield::set_player_uimodel(level.var_46b33f90[3], 1);
          } else {
            var_63fd3e67 = player killstreakrules::iskillstreakallowed(var_8c992ad8, player.team, 1);
            player clientfield::set_player_uimodel(level.var_46b33f90[3], !var_63fd3e67);
          }
        } else {
          var_63fd3e67 = player killstreakrules::iskillstreakallowed(var_8c992ad8, player.team, 1);
          player clientfield::set_player_uimodel(level.var_46b33f90[3], !var_63fd3e67);
        }
      }

      var_e9414fa++;

      if(var_e9414fa >= var_7d46072) {
        waitframe(1);
        var_e9414fa = 0;
      }
    }

    waitframe(1);
  }
}
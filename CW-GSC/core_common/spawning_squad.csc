/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spawning_squad.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace squad_spawn;

function private autoexec __init__system__() {
  system::register(#"squad_spawning", &init, undefined, undefined, undefined);
}

function init() {
  level.var_d0252074 = (isDefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0) && !util::is_frontend_map();

  if(!level.var_d0252074) {
    return;
  }

  setupclientfields();
  level callback::on_end_game(&on_game_ended);
}

function setupclientfields() {
  clientfield::register_clientuimodel("hudItems.squadSpawnOnStatus", #"hud_items", #"squadspawnonstatus", 1, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.squadSpawnActive", #"hud_items", #"squadspawnactive", 1, 1, "int", &function_cc03b772, 0, 0);
  clientfield::register_clientuimodel("hudItems.squadSpawnRespawnStatus", #"hud_items", #"squadspawnrespawnstatus", 1, 2, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.squadSpawnViewType", #"hud_items", #"squadspawnviewtype", 1, 1, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.squadAutoSpawnPromptActive", #"hud_items", #"squadautospawnpromptactive", 1, 1, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.squadSpawnSquadWipe", #"hud_items", #"squadspawnsquadwipe", 1, 1, "int", &function_a58f32b0, 0, 0);
}

function function_21b773d5(localclientnum) {
  if(!is_true(level.var_d0252074)) {
    return false;
  }

  player = function_27673a7(localclientnum);

  if(!isDefined(player)) {
    return false;
  }

  return player clientfield::get_player_uimodel("hudItems.squadSpawnActive") == 1;
}

function function_cc03b772(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    level thread function_58710bd2(fieldname);
    level thread function_cbcbd56d(fieldname);
    setsoundcontext("spawn_select_screen", "true");
    function_5ea2c6e3("uin_overhead_map", 0.1, 1);
    soundloopemitter(#"hash_5ef60d86d79dc9a1", (0, 0, 0));

    if(isDefined(level.squadspawnactive)) {
      [[level.squadspawnactive]](fieldname);
    }

    return;
  }

  level thread function_c97b609d(fieldname);
  level thread function_48811bf4(fieldname);
  setsoundcontext("spawn_select_screen", "");
  function_ed62c9c2("uin_overhead_map", 2);
  soundstoploopemitter(#"hash_5ef60d86d79dc9a1", (0, 0, 0));

  if(isDefined(level.var_6ed4a19b)) {
    [[level.var_6ed4a19b]](fieldname);
  }
}

function function_cbcbd56d(localclientnum) {
  if(game.state != # "playing") {
    return;
  }

  if(!is_true(level.var_acf54eb7)) {
    soundsetmusicstate("squad_spawn");
  }
}

function function_48811bf4(localclientnum) {
  if(game.state != # "playing") {
    return;
  }

  if(!is_true(level.var_acf54eb7)) {
    soundsetmusicstate("squad_spawn_exit");
  }
}

function function_a58f32b0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playSound(fieldname, #"hash_5d2e54389286b7f8");
  }
}

function function_429c452(localclientnum, should_play) {
  if(!should_play) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return should_play;
  }

  localplayer = function_5c10bd79(localclientnum);

  if(isDefined(localplayer) && !localplayer util::isenemyteam(self.team)) {
    return 0;
  }

  if(!function_266be0d4(localclientnum)) {
    return 0;
  }

  if(self hasperk(localclientnum, #"specialty_immunenvthermal")) {
    return 0;
  }

  return 1;
}

function private on_game_ended(localclientnum) {
  setsoundcontext("spawn_select_screen", "");
  function_ed62c9c2("uin_overhead_map", 0.5);
  soundstoploopemitter(#"hash_5ef60d86d79dc9a1", (0, 0, 0));
  function_c97b609d(localclientnum);
}

function private function_ac750979(localclientnum, array) {
  if(isarray(array)) {
    for(index = 0; index < array.size; index++) {
      arrayitem = array[index];

      if(!isDefined(arrayitem)) {
        continue;
      }

      arrayitem renderoverridebundle::function_f4eab437(localclientnum, 1, #"hash_c37f4f4d19191cb", undefined);

      if((index + 1) % 3 == 0) {
        waitframe(1);
      }
    }
  }
}

function private function_bebd8395(localclientnum, array) {
  if(isarray(array)) {
    for(index = 0; index < array.size; index++) {
      arrayitem = array[index];

      if(!isDefined(arrayitem)) {
        continue;
      }

      arrayitem renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", undefined);
    }
  }
}

function private function_58710bd2(localclientnum) {
  self endon(#"game_ended", #"disconnect", #"hash_6843c6f6d0e53fd");

  while(true) {
    players = getplayers(localclientnum);

    for(index = 0; index < players.size; index++) {
      player = players[index];

      if(!isDefined(player)) {
        continue;
      }

      player renderoverridebundle::function_f4eab437(localclientnum, 1, #"hash_c37f4f4d19191cb", &function_429c452);
      corpse = player getplayercorpse();

      if(!isDefined(corpse) || corpse == player) {
        continue;
      }

      corpse renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", &function_429c452);

      if((index + 1) % 3 == 0) {
        waitframe(1);
      }
    }

    if(isarray(level.allvehicles[localclientnum])) {
      for(index = 0; index < level.allvehicles[localclientnum].size; index++) {
        vehicle = level.allvehicles[localclientnum][index];

        if(!isDefined(vehicle)) {
          continue;
        }

        occupants = vehicle getvehoccupants(localclientnum);
        var_c5dfdae0 = occupants.size > 0 || is_false(vehicle.isplayervehicle);
        vehicle renderoverridebundle::function_f4eab437(localclientnum, var_c5dfdae0, #"hash_c37f4f4d19191cb", &function_429c452);

        if((index + 1) % 3 == 0) {
          waitframe(1);
        }
      }
    }

    function_ac750979(localclientnum, level.var_ac260ded);
    function_ac750979(localclientnum, level.counteruavs);
    function_ac750979(localclientnum, level.var_a25fd5e1);
    waitframe(1);
  }
}

function private function_c97b609d(localclientnum) {
  level notify(#"hash_6843c6f6d0e53fd");
  players = getplayers(localclientnum);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", undefined);
    corpse = player getplayercorpse();

    if(!isDefined(corpse) || corpse == player) {
      continue;
    }

    corpse renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", undefined);
  }

  if(isarray(level.allvehicles[localclientnum])) {
    for(index = 0; index < level.allvehicles[localclientnum].size; index++) {
      vehicle = level.allvehicles[localclientnum][index];

      if(!isDefined(vehicle)) {
        continue;
      }

      vehicle renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_c37f4f4d19191cb", undefined);
    }
  }

  function_bebd8395(localclientnum, level.var_ac260ded);
  function_bebd8395(localclientnum, level.counteruavs);
  function_bebd8395(localclientnum, level.var_a25fd5e1);
}
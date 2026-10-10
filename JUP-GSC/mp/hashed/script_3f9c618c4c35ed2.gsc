/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3f9c618c4c35ed2.gsc
************************************************/

#using script_100adcc1cc11d2fa;
#using script_2d9d24f7c63ac143;
#using script_3f9c618c4c35ed2;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\gasmask;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_pickups;
#namespace namespace_9bd27c58b8d3f098;

function private autoexec main() {
  level thread function_1ad29958b0c16235();
}

function function_ecd079f7925cc275() {
  level endon("game_ended");

  if(getdvarint(@ "hash_3338cbc3351d82ad", 0) == 1) {
    return;
  }

  level flag::flag_wait("ob_infil_completed");
  wait 0;

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    var_47b39651bfda8f03 = getdvarint(@ "hash_473a6287a64d7efd", 900);
  } else {
    var_47b39651bfda8f03 = getdvarint(@ "hash_de86f3a650cc13fd", 1800);
  }

  n_start_time = gettime();
  setomnvar("ui_hardpoint_timer", n_start_time + int(var_47b39651bfda8f03 * 1000));
  setomnvar("ui_br_circle_state", 5);
  v_average = function_19cc82eefa6754b5();
  function_46ddeeb7b7770fbc(v_average);
  var_925a0f95e92d6d2e = 10000 / var_47b39651bfda8f03 * 1;
  var_6a56e037cca388ab = 10000;
  b_alerted = 0;

  while(true) {
    if(b_alerted == 0 && 1000 * (var_47b39651bfda8f03 - 600) < gettime() - n_start_time) {
      setomnvar("ui_br_circle_state", 9);
      b_alerted = 1;
    }

    var_6a56e037cca388ab -= var_925a0f95e92d6d2e;

    if(var_6a56e037cca388ab < 0) {
      function_5fb0cca95a3c07a0(0);
      setomnvar("ui_br_circle_state", 4);
      function_cc88915ea8c3bc44();
      thread function_b6c284a8a98ae76f();
      return;
    }

    while(getdvarint(@ "hash_9cc01cb6054a9fd1", 0) == 1) {
      wait 1;
    }

    function_5fb0cca95a3c07a0(var_6a56e037cca388ab);
    wait 1;
  }
}

function function_46ddeeb7b7770fbc(v_origin) {
  level.ob_circle = spawnbrcircle(v_origin[0], v_origin[1], 10000);
  level.ob_circle show();
  level.var_eb1e1026f86571fd = 9;
  level.ob_circle thread circledamagetick();
}

function function_5fb0cca95a3c07a0(var_1cee67764fdc54de) {
  v_average = function_19cc82eefa6754b5();
  level.ob_circle brcirclemoveTo(v_average[0], v_average[1], var_1cee67764fdc54de, 1);
}

function function_19cc82eefa6754b5() {
  v_average = (0, 0, 0);
  a_players = [];

  foreach(player in level.players) {
    if(isalive(player) && !player function_e69d7896fa6e5d23()) {
      v_average += player.origin;
      a_players[a_players.size] = player;
    }
  }

  if(a_players.size > 0) {
    v_average /= a_players.size;
  } else if(isDefined(level.ob_circle)) {
    v_average = level.ob_circle.origin;
  }

  return v_average;
}

function function_b6c284a8a98ae76f() {
  level endon("game_ended");
  level endon("tower_boss_time_added");
  wait 600;
  level thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["time_limit_reached"]);
}

function circledamagetick() {
  level endon("game_ended");
  level endon("endCircleDamageTick");
  var_a058dc250ace641d = scripts\mp\gametypes\br_circle::function_ce6456364079cce7();

  while(true) {
    if(isDefined(level.ob_circle)) {
      damagetick = level.var_eb1e1026f86571fd;

      if(isDefined(level.circledamagemultiplier)) {
        damagetick = int(damagetick * level.circledamagemultiplier);
      }

      if(damagetick > 0) {
        dangercircleorigin = level.ob_circle.origin;
        dangercircleradius = level.ob_circle.origin[2];

        foreach(player in level.players) {
          if(!isDefined(player) || !isDefined(player.origin)) {
            continue;
          }

          var_acfa1a113ba7d7c7 = 0;

          if(distance2dsquared(dangercircleorigin, player.origin) >= dangercircleradius * dangercircleradius) {
            if(isalive(player)) {
              var_acfa1a113ba7d7c7 = 1;

              if(!isDefined(player.var_8d272c0341202e9d)) {
                player.var_8d272c0341202e9d = gettime();
              }

              modifieddamagetick = player scripts\mp\gametypes\br_circle::function_1e0f84e555b3de7d(var_a058dc250ace641d, damagetick);

              if(scripts\cp_mp\gasmask::hasgasmask(player)) {
                if(scripts\mp\gametypes\br_pickups::function_f213f06eba604bbd(player)) {
                  if(!istrue(player.gasmaskequipped)) {
                    player scripts\mp\gametypes\br_circle::function_81652bad17cd28bd(modifieddamagetick);
                  }

                  player scripts\cp_mp\gasmask::processdamage(modifieddamagetick);
                } else if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
                  player playsoundtoplayer("br_gas_mask_crack_plr", player);
                  player scripts\mp\gametypes\br_pickups::function_4d16b9c52efa3b8();
                  player scripts\mp\gametypes\br_pickups::function_8e9b00a1d2b23d72();
                } else {
                  if(isDefined(level.var_f26b4e7eb9af8155)) {
                    player[[level.var_f26b4e7eb9af8155]]("dark_aether_circle");
                  }

                  player scripts\cp_mp\gasmask::processdamage(modifieddamagetick);
                }
              } else {
                player scripts\mp\gametypes\br_circle::function_81652bad17cd28bd(modifieddamagetick);
              }

              if(namespace_aead94004cf4c147::isbackpackinventoryenabled()) {
                player namespace_aead94004cf4c147::function_5323bef1ad6244b9(damagetick);
              }
            } else {
              player.var_8d272c0341202e9d = undefined;
            }

            continue;
          }

          player.var_8d272c0341202e9d = undefined;

          if(scripts\cp_mp\gasmask::hasgasmask(player)) {
            if(scripts\mp\gametypes\br_pickups::function_f213f06eba604bbd(player)) {
              continue;
            }

            if(isDefined(player.gasmaskhealth) && player.gasmaskhealth <= 0) {
              if(isDefined(level.var_f929c426097f1647)) {
                self[[level.var_f929c426097f1647]]();
              } else {
                player playsoundtoplayer("br_gas_mask_crack_plr", player);
                player scripts\mp\gametypes\br_pickups::function_4d16b9c52efa3b8();
              }

              continue;
            }

            if(isDefined(level.var_c57ee1e174e42601)) {
              player[[level.var_c57ee1e174e42601]]("dark_aether_circle");
            }
          }
        }
      }
    }

    wait 1;
  }
}

function function_cc88915ea8c3bc44() {
  var_161560127d85d1d = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "military_ammo_restock");

  foreach(cache in var_161560127d85d1d) {
    cache setscriptablepartstate("military_ammo_restock", "useable_off", 1);
  }
}

function private function_1ad29958b0c16235() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x40>", "<dev string:x55>", &function_a16af0929c3d19a8);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_a16af0929c3d19a8() {
  thread namespace_88d9f8b28d831818::function_ecd079f7925cc275();
  namespace_b000de497fab9bf4::function_a13799ae222a8b48("<dev string:x6a>");
}

# /
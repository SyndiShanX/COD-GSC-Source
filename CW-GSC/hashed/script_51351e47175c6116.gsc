/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_51351e47175c6116.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_14f8bd8f;

function function_32160152(player, modelname, origin, angles, scale = 1) {
  model = namespace_ec06fe4a::spawnmodel(origin, modelname, angles);

  if(isDefined(model)) {
    model setscale(scale);
    scenedef = # "hash_30c46dd666dd7707";
    var_2468c36a = "fireworks";
    model namespace_83eb6304::function_3ecfde67("glow_white");
    model namespace_e32bb68::function_3a59ec34("evt_doa_pickup_giftbox_activated");
    model scene::play(scenedef, model);
    model waittill(#"scenes_done");
    model namespace_e32bb68::function_3a59ec34("evt_doa_pickup_giftbox_explode");
    model namespace_ec06fe4a::function_8c808737();
    model thread namespace_ec06fe4a::function_52afe5df(1);
    model namespace_83eb6304::turnofffx("glow_yellow");
    model namespace_83eb6304::turnofffx("player_trail_yellow");
    waitframe(1);
    roll = randomint(100);

    if(roll < 60) {
      spawnorigin = model.origin;
      players = getplayers();

      foreach(player in players) {
        if(!isDefined(player.doa.vehicle)) {
          continue;
        }

        distsq = distancesquared(player.doa.vehicle.origin, spawnorigin);

        if(distsq < sqr(64)) {
          namespace_dfc652ee::function_ad7ac41b(spawnorigin, 1, 32, 27, 1);
          return;
        }
      }

      doa_enemy::function_a6b807ea(doa_enemy::function_d7c5adee("spider"), randomint(4) + 1, model.origin);
      return;
    }

    model namespace_83eb6304::function_3ecfde67("fireworks");
    model namespace_e32bb68::function_3a59ec34("evt_doa_pickup_giftbox_fireworks");

    if(roll == 99) {
      namespace_dfc652ee::function_ad7ac41b(origin, 1, 32, 14, 1);
      return;
    }

    if(roll > 92) {
      namespace_dfc652ee::function_ad7ac41b(origin, 1, 32, 16, 1);
      return;
    }

    if(roll > 85) {
      namespace_dfc652ee::function_ad7ac41b(origin, 1, 32, 46, 1);
      return;
    }

    if(roll > 80) {
      namespace_dfc652ee::function_ad7ac41b(origin, 1, 32, 8, 1);
      return;
    }

    if(roll > 65) {
      namespace_dfc652ee::function_ad7ac41b(origin, 1, 32, 9, 1);
      return;
    }

    namespace_dfc652ee::function_ad7ac41b(origin, 1, 32, 32, 1);
  }
}
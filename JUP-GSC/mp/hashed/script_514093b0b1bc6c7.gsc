/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_514093b0b1bc6c7.gsc
************************************************/

#using script_5d813d45c6b1b1be;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_6dc1999f395c1510;

function init(var_5179c48492d1d2c2) {
  function_efabc5ae0422de9e(var_5179c48492d1d2c2, 1, undefined, "sitting");
  thread function_58381d6b9dd9c2a0(var_5179c48492d1d2c2);
}

function private function_58381d6b9dd9c2a0(var_5179c48492d1d2c2, scriptable) {
  var_5179c48492d1d2c2.watcher_array = [];
  var_5179c48492d1d2c2.model_array = [];

  while(true) {
    foreach(player in level.players) {
      ent_num = player getentitynumber();

      if(player playerads() == 1) {
        zoom = player playergetzoomfov();

        if(zoom > 25) {
          function_c92c4f30fa8e4969(var_5179c48492d1d2c2, ent_num);
          continue;
        }

        if(!player isonground()) {
          function_c92c4f30fa8e4969(var_5179c48492d1d2c2, ent_num);
          continue;
        }

        aim_vector = anglesToForward(player getplayerangles());
        var_8ba00f8d0fda6308 = vectorNormalize(var_5179c48492d1d2c2.origin - (0, 0, 53) - player.origin);
        dot = vectordot(aim_vector, var_8ba00f8d0fda6308);

        if(dot < 0.99) {
          function_c92c4f30fa8e4969(var_5179c48492d1d2c2, ent_num);
          continue;
        }

        dist_sq = distancesquared(var_5179c48492d1d2c2.origin, player.origin);

        if(dist_sq > 100000000 || dist_sq < 160000) {
          iprintlnbold("<dev string:x1c>");

          function_c92c4f30fa8e4969(var_5179c48492d1d2c2, ent_num);
          continue;
        }

        trace = player trace::player_viewangles();

        if(isDefined(trace["entity"]) && trace["entity"] == var_5179c48492d1d2c2.models[0]) {
          if(!isDefined(var_5179c48492d1d2c2.model_array[ent_num])) {
            var_5179c48492d1d2c2.model_array[ent_num] = spawn_model("ob_mrp", player.origin - (0, 0, 100));

            foreach(other_player in level.players) {
              if(other_player != player) {
                var_5179c48492d1d2c2.model_array[ent_num] hidefromplayer(other_player);
              }
            }
          } else {
            var_5179c48492d1d2c2.model_array[ent_num].origin = player.origin - (0, 0, 100);
          }

          if(isDefined(var_5179c48492d1d2c2.watcher_array[ent_num])) {
            if(gettime() - var_5179c48492d1d2c2.watcher_array[ent_num] > 2000) {
              iprintlnbold("<dev string:x2d>");

              thread function_4593a32e87f51fe4(var_5179c48492d1d2c2, player, var_5179c48492d1d2c2.model_array[ent_num]);
              return;
            }
          } else {
            var_5179c48492d1d2c2.watcher_array[ent_num] = gettime();
          }

          continue;
        }

        iprintlnbold("<dev string:x42>");

        function_c92c4f30fa8e4969(var_5179c48492d1d2c2, ent_num);
        var_5179c48492d1d2c2.watcher_array[ent_num] = undefined;
      }
    }

    wait 0.1;
  }
}

function private function_c92c4f30fa8e4969(var_5179c48492d1d2c2, ent_num) {
  if(isDefined(var_5179c48492d1d2c2.model_array[ent_num])) {
    var_5179c48492d1d2c2.model_array[ent_num] delete();
  }

  var_5179c48492d1d2c2.watcher_array[ent_num] = undefined;
  var_5179c48492d1d2c2.model_array[ent_num] = undefined;
}

function private function_4593a32e87f51fe4(var_5179c48492d1d2c2, player, scare_model) {
  var_302e67a0664597b8 = var_5179c48492d1d2c2.models[0];
  offset = anglesToForward(player getplayerangles()) * 45;
  down = anglestoup(player getplayerangles()) * -10;
  angle = vectortoangles(player getEye() - var_302e67a0664597b8.origin);
  position = player getEye() + offset + down;
  scare_model.origin = position;
  scare_model.angles = angle;
  player playsoundtoplayer("evt_ob_mrpeeks_stinger_jump_scare", player, player);
  lengthms = lookupsoundlength("evt_ob_mrpeeks_stinger_jump_scare");
  f_wait = float(lengthms);
  f_wait /= 1000;
  wait 1.5;
  s_vanish = spawnscriptable("ob_mrp_vanish", var_302e67a0664597b8.origin, var_302e67a0664597b8.angles);
  var_7af7f827219d603a = spawnscriptable("ob_mrp_vanish", scare_model.origin, scare_model.angles);
  reward_struct = spawnStruct();
  reward_struct.angles = scare_model.angles;
  reward_struct.origin = getgroundposition(scare_model.origin, 64);
  var_302e67a0664597b8 delete();
  scare_model delete();
  wait f_wait * 0.3;
  namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652(player, reward_struct, "ob_jup_items_activity_mrp_crane");
  s_vanish freescriptable();
  var_7af7f827219d603a freescriptable();
}
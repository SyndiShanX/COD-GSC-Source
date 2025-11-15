/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\infection.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\infection;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace infection;

autoexec __init__system__() {
  system::register(#"wz_infection", &__init__, undefined, #"infection");
}

private __init__() {
  if(!function_74650d7()) {
    return;
  }

  clientfield::register("toplayer", "infected", 21000, 1, "int", &_infected, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
  level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
}

on_localclient_connect(localclientnum) {
  if(util::get_game_type() == "warzone_pandemic_quad") {
    level thread function_667d34b7(localclientnum);
  }
}

private function_667d34b7(localclientnum) {
  var_d5823792 = 0;

  while(true) {
    local_player = function_5c10bd79(localclientnum);

    if(isDefined(local_player)) {
      infected = local_player clientfield::get_to_player("infected");

      if(infected === 1 && !var_d5823792) {
        var_d5823792 = 1;
        function_a837926b(localclientnum, #"hash_29b452119475ca86");
      } else if(infected === 0 && var_d5823792) {
        var_d5823792 = 0;
        function_24cd4cfb(localclientnum, #"hash_29b452119475ca86");
      }
    }

    waitframe(1);
  }
}

private _infected(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_325e85a2(localclientnum);
    playSound(0, #"zmb_zombie_spawn", self.origin);
    burst_fx = level._effect[#"rise_burst"];
    billow_fx = level._effect[#"rise_billow"];
    self thread rise_dust_fx(localclientnum, billow_fx, burst_fx);
    return;
  }

  self notify(#"hash_4f90e54d76985430");
  self thread function_e5f3924e(localclientnum);
}

private function_e5f3924e(localclientnum) {
  players = getplayers(localclientnum);

  foreach(player in players) {
    player stoprenderoverridebundle("rob_wz_zombievision");
  }
}

private function_325e85a2(localclientnum) {
  self endon(#"hash_4f90e54d76985430");

  while(true) {
    players = getplayers(localclientnum);

    foreach(player in players) {
      corpse = player getplayercorpse();

      if(isDefined(corpse) && iscorpse(corpse) && corpse function_d2503806("rob_wz_zombievision")) {
        corpse stoprenderoverridebundle("rob_wz_zombievision");
      }

      if(!isalive(player) || player function_83973173()) {
        if(player function_d2503806("rob_wz_zombievision")) {
          player stoprenderoverridebundle("rob_wz_zombievision");
        }

        continue;
      }

      player playrenderoverridebundle("rob_wz_zombievision");
    }

    wait 0.25;
  }
}

rise_dust_fx(clientnum, billow_fx, burst_fx) {
  self endon(#"death");
  dust_tag = "J_SpineUpper";

  if(isDefined(burst_fx)) {
    playFX(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
  }

  wait 0.25;

  if(isDefined(billow_fx)) {
    playFX(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
  }
}
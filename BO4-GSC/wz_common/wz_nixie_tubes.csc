/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_nixie_tubes.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_nixie_tubes;

autoexec __init__system__() {
  system::register(#"wz_nixie_tubes", &__init__, undefined, undefined);
}

__init__() {
  level.var_f64d56a1 = (isDefined(getgametypesetting(#"hash_11b79ec2ffb886c8")) ? getgametypesetting(#"hash_11b79ec2ffb886c8") : 0) || (isDefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);

  if(isDefined(level.var_f64d56a1) && level.var_f64d56a1) {
    callback::on_localclient_connect(&on_local_client_connect);
    callback::on_localplayer_spawned(&function_8be09fdd);
  }
}

function_fb0bd6b9(localclientnum) {
  nixie_tube_cage = getdynent("nixie_tube_cage");

  if(!isDefined(nixie_tube_cage)) {
    println("<dev string:x38>");
    return;
  }

  nixie_tube_cage.canuse = 0;
  var_679f0ee5 = struct::get_array("nixie_tubes", "script_noteworthy");

  foreach(s_tube in var_679f0ee5) {
    var_790990d7 = util::spawn_model(localclientnum, #"p8_zm_esc_nixie_tubes", s_tube.origin, s_tube.angles);
    var_8f21b4af = util::spawn_model(localclientnum, #"p8_zm_esc_nixie_tubes_on", s_tube.origin, s_tube.angles);
    var_8f21b4af hide();
    var_790990d7.script_string = "mdl_nixie_tubes";
    var_8f21b4af.script_string = "mdl_nixie_tubes_on";
    var_8f21b4af.targetname = s_tube.targetname + "_on";
    var_790990d7.targetname = s_tube.targetname + "_off";
    s_tube.var_790990d7 = var_790990d7;
    s_tube.var_8f21b4af = var_8f21b4af;
  }
}

on_local_client_connect(localclientnum) {
  level endon(#"game_ended");
  nixie_cage = getdynent("nixie_tube_cage");

  if(!(isDefined(level.var_f64d56a1) && level.var_f64d56a1)) {
    if(isDefined(nixie_cage)) {
      setdynentenabled(nixie_cage, 0);
    }

    return;
  }

  level function_fb0bd6b9(localclientnum);

  if(isDefined(nixie_cage)) {
    nixie_sound_manager = spawn(localclientnum, nixie_cage.origin, "script_origin");
    nixie_sound_manager.targetname = "nixie_sound_manager";
    nixie_sound_manager.loop_sound = nixie_sound_manager playLoopSound(#"hash_589f33024097b46");
  } else {
    return;
  }

  level flagsys::wait_till(#"item_world_reset");
  level thread function_f98a4376(localclientnum);
}

function_8be09fdd(localclientnum) {
  local_player = function_5c10bd79(localclientnum);

  if(!isDefined(local_player.tube1)) {
    local_player.tube1 = 0;
  }

  if(!isDefined(local_player.tube2)) {
    local_player.tube2 = 0;
  }

  if(!isDefined(local_player.tube3)) {
    local_player.tube3 = 0;
  }
}

function_97f8efcd(localclientnum) {
  nixie_cage = getdynent("nixie_tube_cage");

  if(isDefined(nixie_cage)) {
    nixie_cage.canuse = 1;
  }

  var_243a1bdb = getent(localclientnum, "nixie_tube_1_on", "targetname");
  var_4974664f = getent(localclientnum, "nixie_tube_2_on", "targetname");
  var_37adc2c2 = getent(localclientnum, "nixie_tube_3_on", "targetname");
  var_529f2403 = getent(localclientnum, "nixie_tube_1_off", "targetname");
  var_66984bf5 = getent(localclientnum, "nixie_tube_2_off", "targetname");
  var_3f227d0a = getent(localclientnum, "nixie_tube_3_off", "targetname");
  var_243a1bdb show();
  var_4974664f show();
  var_37adc2c2 show();
  var_529f2403 hide();
  var_66984bf5 hide();
  var_3f227d0a hide();
}

function_f451b137() {
  if(isDefined(self) && isplayer(self)) {
    self.tube1 = 0;
    self.tube2 = 0;
    self.tube3 = 0;
  }
}

function_d169c443(localclientnum) {
  ents = getEntArray(localclientnum, self.targetname, "targetname");

  foreach(tube in ents) {
    if(tube hasdobj(localclientnum)) {
      return tube;
    }
  }

  return undefined;
}

function_f98a4376(localclientnum) {
  level thread function_97f8efcd(localclientnum);
  waitframe(1);
  var_4f5b63ea = struct::get("nixie_tube_1");
  var_83aecc80 = struct::get("nixie_tube_2");
  var_31a8a875 = struct::get("nixie_tube_3");

  while(true) {
    local_player = function_5c10bd79(localclientnum);

    if(isDefined(local_player)) {
      var_cd92754b = var_4f5b63ea.var_8f21b4af;
      var_59578baf = var_83aecc80.var_8f21b4af;
      var_ca95ee2a = var_31a8a875.var_8f21b4af;
      var_e28cb83c = var_4f5b63ea.var_790990d7;
      var_5a5a2785 = var_83aecc80.var_790990d7;
      var_479e820e = var_31a8a875.var_790990d7;

      if(function_65b9eb0f(localclientnum)) {
        var_da258db4 = var_cd92754b.localclientnum;
        var_cd92754b = var_cd92754b function_d169c443(var_da258db4);

        if(!isDefined(var_cd92754b)) {
          return;
        }

        var_da258db4 = var_59578baf.localclientnum;
        var_59578baf = var_59578baf function_d169c443(var_da258db4);

        if(!isDefined(var_59578baf)) {
          return;
        }

        var_da258db4 = var_ca95ee2a.localclientnum;
        var_ca95ee2a = var_ca95ee2a function_d169c443(var_da258db4);

        if(!isDefined(var_ca95ee2a)) {
          return;
        }

        var_da258db4 = var_e28cb83c.localclientnum;
        var_e28cb83c = var_e28cb83c function_d169c443(var_da258db4);

        if(!isDefined(var_e28cb83c)) {
          return;
        }

        var_da258db4 = var_5a5a2785.localclientnum;
        var_5a5a2785 = var_5a5a2785 function_d169c443(var_da258db4);

        if(!isDefined(var_5a5a2785)) {
          return;
        }

        var_da258db4 = var_479e820e.localclientnum;
        var_479e820e = var_479e820e function_d169c443(var_da258db4);

        if(!isDefined(var_479e820e)) {
          return;
        }
      }

      if(isDefined(local_player.tube1)) {
        if(local_player.tube1 >= 0) {
          if(isDefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && isDefined(var_cd92754b haspart(localclientnum, "tag_nixie_off")) && var_cd92754b haspart(localclientnum, "tag_nixie_off")) {
            var_cd92754b hidepart(localclientnum, "tag_nixie_off");
          }

          if(isDefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && isDefined(var_59578baf haspart(localclientnum, "tag_nixie_off")) && var_59578baf haspart(localclientnum, "tag_nixie_off")) {
            var_59578baf hidepart(localclientnum, "tag_nixie_off");
          }

          if(isDefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && isDefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_off")) && var_ca95ee2a haspart(localclientnum, "tag_nixie_off")) {
            var_ca95ee2a hidepart(localclientnum, "tag_nixie_off");
          }

          for(i = 0; i < 10; i++) {
            if(local_player.tube1 != i) {
              if(isDefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && isDefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + i)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + i)) {
                var_cd92754b hidepart(localclientnum, "tag_nixie_" + i);
              }
            }

            if(local_player.tube2 != i) {
              if(isDefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && isDefined(var_59578baf haspart(localclientnum, "tag_nixie_" + i)) && var_59578baf haspart(localclientnum, "tag_nixie_" + i)) {
                var_59578baf hidepart(localclientnum, "tag_nixie_" + i);
              }
            }

            if(local_player.tube3 != i) {
              if(isDefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && isDefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)) {
                var_ca95ee2a hidepart(localclientnum, "tag_nixie_" + i);
              }
            }
          }

          if(isDefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && isDefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.tube1)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.tube1)) {
            var_cd92754b showpart(localclientnum, "tag_nixie_" + local_player.tube1);
          }

          if(isDefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && isDefined(var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.tube2)) && var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.tube2)) {
            var_59578baf showpart(localclientnum, "tag_nixie_" + local_player.tube2);
          }

          if(isDefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && isDefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.tube3)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.tube3)) {
            var_ca95ee2a showpart(localclientnum, "tag_nixie_" + local_player.tube3);
          }
        } else {
          for(i = 0; i < 10; i++) {
            if(isDefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && isDefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + i)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + i)) {
              var_cd92754b hidepart(localclientnum, "tag_nixie_" + i);
            }

            if(isDefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && isDefined(var_59578baf haspart(localclientnum, "tag_nixie_" + i)) && var_59578baf haspart(localclientnum, "tag_nixie_" + i)) {
              var_59578baf hidepart(localclientnum, "tag_nixie_" + i);
            }

            if(isDefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && isDefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + i)) {
              var_ca95ee2a hidepart(localclientnum, "tag_nixie_" + i);
            }
          }

          if(isDefined(var_cd92754b hasdobj(localclientnum)) && var_cd92754b hasdobj(localclientnum) && isDefined(var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.tube1)) && var_cd92754b haspart(localclientnum, "tag_nixie_" + local_player.tube1)) {
            var_cd92754b showpart(localclientnum, "tag_nixie_off");
          }

          if(isDefined(var_59578baf hasdobj(localclientnum)) && var_59578baf hasdobj(localclientnum) && isDefined(var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.tube1)) && var_59578baf haspart(localclientnum, "tag_nixie_" + local_player.tube1)) {
            var_59578baf showpart(localclientnum, "tag_nixie_off");
          }

          if(isDefined(var_ca95ee2a hasdobj(localclientnum)) && var_ca95ee2a hasdobj(localclientnum) && isDefined(var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.tube1)) && var_ca95ee2a haspart(localclientnum, "tag_nixie_" + local_player.tube1)) {
            var_ca95ee2a showpart(localclientnum, "tag_nixie_off");
          }

          var_e28cb83c show();
          var_5a5a2785 show();
          var_479e820e show();
          var_cd92754b hide();
          var_59578baf hide();
          var_ca95ee2a hide();
          break;
        }
      }
    }

    waitframe(1);
  }
}

event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  if(!(isDefined(level.var_f64d56a1) && level.var_f64d56a1)) {
    if(eventstruct.ent.targetname === "nixie_tube_cage") {
      setdynentenabled(eventstruct.ent, 0);
    }

    return;
  }

  if(eventstruct.ent.targetname === "nixie_tube_cage" && isDefined(eventstruct.localclientnum)) {
    if(!(isDefined(eventstruct.ent.canuse) && eventstruct.ent.canuse)) {
      return;
    }

    players = getlocalplayers();

    if(players.size > 0) {
      closest_player = arraygetclosest(eventstruct.ent.origin, players, 128);

      if(isDefined(closest_player)) {
        a_s_tubes = struct::get_array("nixie_tubes", "script_noteworthy");

        if(a_s_tubes.size > 0) {
          var_a776da4f = distance2d(closest_player.origin, a_s_tubes[0].var_8f21b4af.origin);
          var_4da8e55e = a_s_tubes[0];

          foreach(s_tube in a_s_tubes) {
            var_c3cbab72 = distance2d(closest_player.origin, s_tube.var_8f21b4af.origin);

            if(var_c3cbab72 < var_a776da4f) {
              var_4da8e55e = s_tube;
              var_a776da4f = distance2d(closest_player.origin, s_tube.var_8f21b4af.origin);
            }
          }

          foreach(player in players) {
            if(isDefined(var_4da8e55e.targetname)) {
              switch (var_4da8e55e.targetname) {
                case #"nixie_tube_1":
                  player.tube1 = (player.tube1 + 1) % 10;
                  break;
                case #"nixie_tube_2":
                  player.tube2 = (player.tube2 + 1) % 10;
                  break;
                case #"nixie_tube_3":
                  player.tube3 = (player.tube3 + 1) % 10;
                  break;
              }
            }

            player thread function_bbca669b(player, eventstruct.ent);
          }
        }
      }
    }
  }
}

function_bbca669b(e_activator, dynent) {
  if(isDefined(e_activator) && isDefined(dynent)) {
    e_activator notify(#"hash_2f586f8df1e6596d");
    e_activator endon(#"hash_2f586f8df1e6596d", #"hash_59db65b924f851e4", #"hash_f787bd652d7a4b", #"disconnect");
    wait 5;
    e_activator thread function_c1cc29be(e_activator, dynent);
  }
}

function_c1cc29be(e_activator, dynent) {
  if(isDefined(e_activator) && isDefined(dynent)) {
    e_activator endon(#"hash_59db65b924f851e4", #"disconnect");
    e_activator notify(#"hash_f787bd652d7a4b");
    localclientnum = e_activator.localclientnum;
    var_8171dd3a = e_activator.tube1;
    var_8dfff656 = e_activator.tube2;
    var_44e1e41b = e_activator.tube3;
    var_954ac27a = 0;

    if(var_8171dd3a == 1 && var_8dfff656 == 1 && var_44e1e41b == 5) {
      var_954ac27a = 1;
    }

    if(var_8171dd3a == 8 && var_8dfff656 == 7 && var_44e1e41b == 2) {
      var_954ac27a = 1;
    }

    if(var_8171dd3a == 4 && var_8dfff656 == 2 && var_44e1e41b == 0) {
      var_954ac27a = 1;
    }

    if(var_954ac27a) {
      dynent.canuse = 0;
      wait 1.5 + 0.25;
      var_62002857 = 0;
      e_activator thread function_f451b137();
      wait 2;
      e_activator function_172e72fa();

      if(var_954ac27a) {
        str_code = "" + var_8171dd3a + var_8dfff656 + var_44e1e41b;
        e_activator thread function_a5d20d9b(str_code);

        if(str_code == "115") {
          var_62002857 = 6;
        }
      }

      return;
    }

    a_mdl_tubes = getEntArray(localclientnum, "mdl_nixie_tubes", "script_string");

    foreach(var_790990d7 in a_mdl_tubes) {
      var_790990d7 thread function_b4231440(localclientnum);
    }

    playSound(localclientnum, #"hash_6c0f63cd38c393e7", dynent.origin);
    dynent.canuse = 0;
    e_activator thread function_f451b137();
    dynent.canuse = 1;
  }
}

function_a5d20d9b(str_code) {
  self notify(#"hash_1ba800da972b0558", {
    #str_code: str_code
  });

  switch (str_code) {
    case #"115":
      self thread music_ee();
      break;
    case #"872":
      self thread fireworks_ee();
      break;
    case #"420":
      self thread function_1451e44e();
    default:
      break;
  }
}

music_ee() {
  self notify("43e9d9fe0bc4c9a6");
  self endon("43e9d9fe0bc4c9a6");
  players = getlocalplayers();

  foreach(player in players) {
    a_mdl_tubes = getEntArray(player.localclientnum, "mdl_nixie_tubes", "script_string");

    if(a_mdl_tubes.size > 0) {
      a_mdl_tubes[0] playSound(player.localclientnum, #"hash_5ecaf6acf6be0b1f", a_mdl_tubes[0].origin);
    }
  }
}

fireworks_ee() {
  exploder::exploder("fx_exploder_fireworks_ee");
  level thread function_a746f03f();
}

function_a746f03f() {
  level endon(#"game_ended");
  wait 60;
  exploder::kill_exploder("fx_exploder_fireworks_ee");
}

function_1451e44e() {
  self notify("61ff44b5486a5e5a");
  self endon("61ff44b5486a5e5a");
  players = getlocalplayers();

  foreach(player in players) {
    a_mdl_tubes = getEntArray(player.localclientnum, "mdl_nixie_tubes", "script_string");

    if(a_mdl_tubes.size >= 1) {
      if(isDefined(player.var_1ad66d1)) {
        stopfx(player.localclientnum, player.var_1ad66d1);
      }

      player.var_1ad66d1 = function_239993de(player.localclientnum, "smoke/fx8_column_md_green", a_mdl_tubes[1], "tag_origin");
      player thread function_e0df40bf(player.localclientnum);
    }
  }
}

function_172e72fa() {
  if(isplayer(self)) {
    nixie_tube_cage = getdynent("nixie_tube_cage");

    if(isDefined(nixie_tube_cage)) {
      nixie_tube_cage.canuse = 0;
    }

    self.tube1 = -1;
    self.tube2 = -1;
    self.tube3 = -1;
  }
}

function_b4231440(localclientnum) {
  self.var_3c43a180 = util::playFXOnTag(localclientnum, #"hash_1a61f16f38e7e93d", self, "tag_animate");
  wait 1;
  stopfx(localclientnum, self.var_3c43a180);
}

function_e0df40bf(localclientnum) {
  self endon(#"death");
  level endon(#"game_ended");
  wait 60;

  if(isDefined(self.var_1ad66d1)) {
    stopfx(self.localclientnum, self.var_1ad66d1);
  }
}
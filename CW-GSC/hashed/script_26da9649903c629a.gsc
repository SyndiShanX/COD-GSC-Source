/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_26da9649903c629a.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\weapons\heatseekingmissile;
#namespace namespace_f180c0d7;

function function_c44464c8() {
  clientfield::register("toplayer", "pstfx_script_vignette", 1, 2, "int");
}

function function_b26dad22(level_notify) {
  thread function_b0e490c1();
  level.var_7466d419 callback::function_d8abfc3d(#"on_vehicle_damage", &function_d39d4a5b);
  level.var_7466d419 endon(#"death");
  level endon(level_notify);

  level endon(#"hash_1cf48096c380b7cd");

  bottom_distance = 1300;
  middle_distance = 1000;
  top_distance = 100;
  var_168492dd = undefined;
  level.player = getplayers()[0];
  function_5ac4dc99("bottom_distance", -1);
  function_5ac4dc99("middle_distance", -1);
  function_5ac4dc99("top_distance", -1);
  setDvar(#"bottom_distance", bottom_distance);
  setDvar(#"middle_distance", 1200);
  setDvar(#"top_distance", top_distance);
  var_270e748f = 0;
  var_9ddd4d57 = undefined;
  level.var_7466d419.var_2939dba = # "hash_5cad1a1b9fdc43ee";

  while(true) {
    trace_result = physicstrace(level.var_7466d419.origin + (0, 0, 50), level.var_7466d419.origin + (0, 0, 5000), (0, 0, 0), (0, 0, 0), level.var_7466d419, 16);

    if(isDefined(trace_result) && isDefined(trace_result[# "position"])) {
      var_b4d6bef6 = distance(level.var_7466d419.origin, trace_result[# "position"]);

      if(trace_result[# "fraction"] < 1) {
        setDvar(#"current_distance", var_b4d6bef6);
      }

      if(isDefined(var_168492dd)) {
        if(var_b4d6bef6 < top_distance && var_168492dd >= top_distance) {
          level notify(#"stop");
          thread function_ad449a1b("stop");
          thread function_4b0f12f6("stop");
          thread function_f4567c7c(var_b4d6bef6, "stop");
          level.player clientfield::set_to_player("pstfx_script_vignette", 3);
        } else if(var_b4d6bef6 > top_distance && var_168492dd <= top_distance) {
          level notify(#"stop");
          thread function_4b0f12f6("stop");
          thread function_d262b525("stop", 3);
          thread function_f4567c7c(var_b4d6bef6, "stop");
          level.player clientfield::set_to_player("pstfx_script_vignette", 2);
        } else if(var_b4d6bef6 < middle_distance && var_168492dd >= middle_distance) {
          level notify(#"stop");
          thread function_4b0f12f6("stop");
          thread function_d262b525("stop", 3);
          thread function_f4567c7c(var_b4d6bef6, "stop");
          level.player clientfield::set_to_player("pstfx_script_vignette", 2);
        } else if(var_b4d6bef6 > middle_distance && var_168492dd <= middle_distance) {
          level notify(#"stop");
          thread function_f4567c7c(var_b4d6bef6, "stop");
          level.player clientfield::set_to_player("pstfx_script_vignette", 1);
        } else if(var_b4d6bef6 < bottom_distance && var_168492dd >= bottom_distance) {
          level notify(#"stop");
          thread function_f4567c7c(var_b4d6bef6, "stop");
          iprintlnbold("You're flying too high get down!");
          level.player clientfield::set_to_player("pstfx_script_vignette", 1);

          if(var_270e748f == 0) {
            thread function_36cc1830();
            var_9ddd4d57 = spawn("script_model", level.var_7466d419.origin);
            var_9ddd4d57 setModel(#"tag_origin");
            var_9ddd4d57 linkto(level.var_7466d419, "tag_attach", (0, 0, 0), (0, 0, 0));
            playFXOnTag(level.var_7466d419.var_2939dba, var_9ddd4d57, "tag_origin");
            var_270e748f = 1;
          }
        } else if(var_b4d6bef6 > bottom_distance && var_168492dd <= bottom_distance) {
          level notify(#"stop");
          level notify(#"out_of_zone");
          level.player clientfield::set_to_player("pstfx_script_vignette", 0);

          if(var_270e748f == 1) {
            var_9ddd4d57 delete();
            var_9ddd4d57 = undefined;
            var_270e748f = 0;
          }
        }
      }
    }

    var_168492dd = var_b4d6bef6;
    waitframe(1);
  }
}

function function_4b0f12f6(level_notify) {
  level.var_7466d419 endon(#"death");
  level endon(level_notify);
  weapon = getweapon(#"ar_damage_t9");
  player_damage = 20;

  while(true) {
    chopper_speed = level.var_7466d419 getspeedmph();
    shot_count = randomintrange(10, 12);
    random_y = 0;
    random_x = randomintrange(1000, 1500);
    random_z = randomintrange(400, 600);

    if(math::cointoss()) {
      random_y = randomintrange(1250, 1500);
    } else {
      random_y = randomintrange(-1500, -1250);
    }

    tag = ["tag_door_rear_left_null", "tag_door_mid_right_null", "tag_door_rear_right_null", "tag_rotor_attach"];
    var_44960a56 = array::random(tag);
    var_9d5321a = level.var_7466d419 gettagorigin(var_44960a56);
    var_5a3aa491 = (random_x, random_y, random_z);
    var_f4d3e08a = rotatepoint(var_5a3aa491, level.var_7466d419.angles) + level.var_7466d419.origin;
    thread function_f4567c7c("stop");

    while(shot_count > 0) {
      if(chopper_speed > 20) {
        offset = (1200, 0, 0);
        var_6d32c483 = rotatepoint(offset, level.var_7466d419.angles) + var_9d5321a;
        magicbullet(weapon, var_f4d3e08a, var_6d32c483);
      } else if(chopper_speed <= 20) {
        magicbullet(weapon, var_f4d3e08a, var_9d5321a);
      }

      shot_count--;
      wait 0.075;
      bullet_impacts = snd::play("tmp_impacts_metal", level.players[0]);
    }

    wait 1;
  }
}

function function_ad449a1b(level_notify) {
  level.var_7466d419 endon(#"death");
  level endon(level_notify);
  weapon = getweapon(#"hash_513c26c6a751d20e");
  num_shots = 1;

  while(num_shots > 0) {
    canshoot = 1;
    chopper_speed = level.var_7466d419 getspeedmph();
    random_y = 0;
    random_x = randomintrange(3000, 3500);
    random_z = randomintrange(400, 600);

    if(math::cointoss()) {
      random_y = randomintrange(1250, 1500);
    } else {
      random_y = randomintrange(-1500, -1250);
    }

    var_5a3aa491 = (random_x, random_y, random_z);
    var_f4d3e08a = rotatepoint(var_5a3aa491, level.var_7466d419.angles) + level.var_7466d419.origin;

    if(canshoot) {
      if(chopper_speed > 10) {
        offset = (4000, 0, 0);
        var_6d32c483 = rotatepoint(offset, level.var_7466d419.angles) + level.var_7466d419.origin;
        missle = magicbullet(weapon, var_f4d3e08a, var_6d32c483);
        level.var_c95e0d20 = missle;

        if(num_shots <= 1) {
          missle.var_30dc969d = 1;
          missle.team = # "axis";
          missle setteam(#"axis");
          level.var_7466d419 thread heatseekingmissile::missiletarget_proximitydetonate(missle, missle, weapon, "death");
          attractor = missile_createattractorent(level.var_7466d419, 25000, 150, 1);
        }
      } else if(chopper_speed <= 10) {
        missle = magicbullet(weapon, var_f4d3e08a, level.var_7466d419.origin);
        level.var_c95e0d20 = missle;

        if(num_shots <= 1) {
          missle.var_30dc969d = 1;
          missle.team = # "axis";
          missle setteam(#"axis");
          level.var_7466d419 thread heatseekingmissile::missiletarget_proximitydetonate(missle, missle, weapon, "death");
          attractor = missile_createattractorent(level.var_7466d419, 25000, 150, 1);
        }
      }

      num_shots--;
    }

    wait 2;
  }
}

function function_d262b525(level_notify, var_7366cb1a) {
  level.var_7466d419 endon(#"death");
  level endon(level_notify);
  weapon = getweapon(#"hash_513c26c6a751d20e");

  while(true) {
    canshoot = 1;
    chopper_speed = level.var_7466d419 getspeedmph();
    random_y = 0;
    random_x = randomintrange(3000, 3500);
    random_z = randomintrange(400, 600);

    if(math::cointoss()) {
      random_y = randomintrange(1250, 1500);
    } else {
      random_y = randomintrange(-1500, -1250);
    }

    var_5a3aa491 = (random_x, random_y, random_z);
    var_f4d3e08a = rotatepoint(var_5a3aa491, level.var_7466d419.angles) + level.var_7466d419.origin;

    if(canshoot) {
      if(chopper_speed > 10) {
        offset = (4000, 0, 0);
        var_6d32c483 = rotatepoint(offset, level.var_7466d419.angles) + level.var_7466d419.origin;
        missle = magicbullet(weapon, var_f4d3e08a, var_6d32c483);
      } else if(chopper_speed <= 10) {
        offset = (1000, 0, 0);
        var_6d32c483 = rotatepoint(offset, level.var_7466d419.angles) + level.var_7466d419.origin;
        missle = magicbullet(weapon, var_f4d3e08a, var_6d32c483);
      }
    }

    wait var_7366cb1a;
  }
}

function function_f4567c7c(distance, level_notify) {
  level.var_7466d419 endon(#"death");
  level endon(level_notify);
  source = level.players[0].origin;
  pitch = [0.25, 0.5];
  yaw = [0.1, 0.5];
  roll = [0.25, 0.5];
  duration = [0.7, 0.3];
  freqpitch = 4;
  freqyaw = 4;
  freqroll = 4;

  if(distance < 1000) {
    level.players[0] playrumbleonentity("damage_heavy");
    screenshake(source, pitch[1], yaw[1], roll[1], duration[1], 0, 0, 0, freqpitch, freqyaw);
    return;
  }

  if(distance < 1500) {
    level.players[0] playrumbleonentity("damage_light");
    screenshake(source, pitch[0], yaw[0], roll[0], duration[0], 0, 0, 0, freqpitch, freqyaw);
  }
}

function function_b2abc199(level_notify, stop_notify) {
  level notify(level_notify);
  level notify(stop_notify);
  level.player clientfield::set_to_player("pstfx_script_vignette", 0);
  level.var_7466d419 callback::function_52ac9652(#"on_vehicle_damage", &function_d39d4a5b);
}

function function_36cc1830() {
  level.var_7466d419 endon(#"death");
  siren = snd::function_9ae4fc6f("tmp_veh_helicopter_alarm_lp", level.var_7466d419);
  snd::function_2e9b6265(siren, "out_of_zone");
}

function function_b0e490c1() {
  while(isalive(level.var_7466d419)) {
    waitframe(1);
  }

  waitframe(1);
  level.player clientfield::set_to_player("pstfx_script_vignette", 0);
}

function function_d39d4a5b(params) {
  einflictor = params.einflictor;
  idamage = params.idamage;
  smeansofdeath = params.smeansofdeath;

  if(smeansofdeath === "MOD_RIFLE_BULLET") {
    return;
  }

  if(isDefined(einflictor) && isDefined(level.var_c95e0d20) && einflictor === level.var_c95e0d20) {
    level.var_7466d419 dodamage(50000, level.var_7466d419.origin);
  }
}
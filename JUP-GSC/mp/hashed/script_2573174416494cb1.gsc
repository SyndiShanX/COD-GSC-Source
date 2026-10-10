/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2573174416494cb1.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_dev;
#namespace namespace_6f311b9f78e8e82;

function autoexec main() {
  scripts\mp\gametypes\br_dev::registerhandlecommand(&function_c96d7535862e245c);

  flag_wait("wztrain_array_set");

  if(getdvarint(@ "hash_c15b52558ebc810a", 1)) {
    foreach(train in level.wztrain_info.trains) {
      locomotive = train[0];

      if(locomotive.linked_model isvehicle()) {
        locomotive thread function_5f65af64b995ff82();
      }
    }
  }
}

function function_eb14f1e1637f1482(vehicle_ref, spawndata) {
  var_808591e7e173f240 = "v000";
  var_84d08597070fa23c = getDvar(@ "hash_fbbc1781e1b34506", var_808591e7e173f240);

  if(var_84d08597070fa23c != var_808591e7e173f240) {
    spawndata.mtx = getDvar(@ "hash_fbbc1781e1b34506", var_84d08597070fa23c);
  }

  vehicle = vehicle_spawn(vehicle_ref, spawndata);
  vehicle_compass::vehicle_compass_hide(vehicle);
  vehicle vehicleshowonminimap(0);
  vehicle vehicle_damage::vehicle_damage_setCanDamage(0);
  vehicle_tracking_deregisterinstance(vehicle);
  return vehicle;
}

function private function_5f65af64b995ff82() {
  traincar = self;
  traincar endon("train_mtx_applied");

  while(true) {
    traincar waittill("train_control_used", part, user_player, success);

    if(success) {
      function_cc178534ef642e6f(user_player, traincar.linked_model);
    }
  }
}

function private function_1210b86df14de182(vehicle) {
  return scripts\mp\flags::gameflag("prematch_fade_done") && !isDefined(vehicle.mtx);
}

function private function_cc178534ef642e6f(player, vehicle) {
  if(!function_1210b86df14de182(vehicle)) {
    return;
  }

  if(isDefined(player.vehiclecustomization)) {
    vehicleref = vehicle function_d93ec4635290febd();

    if(!isDefined(vehicle.mtx) && !istrue(vehicle.var_7ee6203c5532a9e6)) {
      mtx = function_471cde1983a05f66(player, vehicleref);
      function_4201160d49c885a7(vehicle, mtx);

      if(isDefined(vehicle.mtx)) {
        vehicle.linked_brush notify("train_mtx_applied");
      }
    }
  }
}

function private function_c96d7535862e245c(command, args) {
  var_967cb1a144269ab6 = "cargo_train";
  firstplayer = level.players[0];

  if(!isDefined(firstplayer)) {
    return;
  }

  switch (command) {
    case #"hash_2899e5a679a1e049":
      if(!isDefined(args[0])) {
        break;
      }

      switch (args[0]) {
        case #"hash_2871e46c1eee9774":
          if(!isDefined(args[1])) {
            break;
          }

          switch (args[1]) {
            case #"hash_b9c0ff6cd406fe0f":
              announcement(string(scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1("veh_jup_nuclear_locomotive")));
              break;
            case #"hash_334c896e25dc8345":
              var_a46d9cfec2e2ca35 = function_86f6f784630b11fb("veh_jup_nuclear_locomotive");
              dummy = 0;
              break;
            case #"hash_6ad13f0635bc091b":
              vehicle = level.wztrain_info.trains[var_967cb1a144269ab6][0].linked_model;
              function_cc178534ef642e6f(firstplayer, vehicle);
              break;
            case #"hash_819aac6f5ae2fb78":
              vehicle_ref = args[2];

              if(!isDefined(vehicle_ref)) {
                break;
              }

              traincar = level.wztrain_info.trains[var_967cb1a144269ab6][0];
              spawndata = spawnStruct();
              spawndata.origin = traincar.origin + (0, 200, 0);
              vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(vehicle_ref, spawndata);
              vehicle linkTo(traincar);
              break;
          }

          break;
      }

      break;
  }
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5a498c5fd8511723.gsc
*************************************************/

#using script_24f248b33b79e48d;
#using script_6617e2f2bb62b52b;
#using script_6d3eb7a3bb982cc6;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#namespace namespace_3de30dc9c2f4b908;

function function_b128dd1bd8150fb3(players, var_8c3a7a19c10ecf05, broadcast_command, var_7bf6ef44012436e7) {
  namespace_62c11776e6b6ad74::function_516fd8a6749c3726(players, var_8c3a7a19c10ecf05, broadcast_command);
}

function function_c235ffb8f79c155a(players, broadcast_instance, var_8c3a7a19c10ecf05, broadcast_command) {
  splash_reference = function_f26baa739c00a3c7(var_8c3a7a19c10ecf05);
  var_daf9aec8006b0c35 = function_dbb11dc6ea65794e(var_8c3a7a19c10ecf05);

  if(broadcast_command == 0 || broadcast_command == 1) {
    if(!isarray(players)) {
      players = [players];
    }

    var_6d205bc49d8616d5 = undefined;
    var_949db43ec6f96c1e = function_684411bce1d1c8bc(broadcast_instance, var_8c3a7a19c10ecf05, 0);

    if(isDefined(var_949db43ec6f96c1e) && var_949db43ec6f96c1e.type == "Integer") {
      var_6d205bc49d8616d5 = var_949db43ec6f96c1e.value;
    }

    foreach(player in players) {
      player thread scripts\mp\hud_message::showsplash(splash_reference, var_6d205bc49d8616d5, undefined, undefined, 1, var_daf9aec8006b0c35);
    }
  }
}

function function_a40cc36677592f02(players, var_8c3a7a19c10ecf05, broadcast_command) {
  music = function_79dc6a4dd519d5cd(var_8c3a7a19c10ecf05);
  music = default_to(music, "");
  delay = function_8cc6c17907ab41bf(var_8c3a7a19c10ecf05);
  delay = default_to(delay, 0);

  if(!isarray(players)) {
    players = [players];
  }

  if(broadcast_command == 0 || broadcast_command == 1) {
    music_state = scripts\cp_mp\utility\audio_utility::function_17ee301cf0b5ba85(music);

    if(music_state == "" && music != "") {
      music_state = music;
    }

    level delaythread(delay, &scripts\cp_mp\utility\audio_utility::function_fe75a89529dd0fd0, players, music_state);
    return;
  }

  if(broadcast_command == 2) {
    level scripts\cp_mp\utility\audio_utility::function_fe75a89529dd0fd0(players, "");
  }
}

function function_28b732afbadec198(players, var_8c3a7a19c10ecf05, broadcast_command) {
  var_af517be3a4fc936d = function_84ac089886facee5(var_8c3a7a19c10ecf05);
  var_68065a8cd9f9f25f = function_ffbb8d6b4076cfa7(var_8c3a7a19c10ecf05);
  var_68065a8cd9f9f25f = default_to(var_68065a8cd9f9f25f, 0);
  var_384817145e09d4c6 = function_5be1a4fd3bd9c0a7(var_8c3a7a19c10ecf05);
  var_9a3d6fbdec2364cf = function_63b7c6f0e6f2a9f7(var_8c3a7a19c10ecf05);

  if(broadcast_command == 0 || broadcast_command == 1) {
    if(!isarray(players)) {
      players = [players];
    }

    if(var_384817145e09d4c6) {
      thread scripts\cp_mp\overlord::playconversation(var_af517be3a4fc936d, players, var_68065a8cd9f9f25f, var_9a3d6fbdec2364cf);
      return;
    }

    thread scripts\cp_mp\overlord::playevent(var_af517be3a4fc936d, players, var_68065a8cd9f9f25f);
  }
}

function function_ade09b145f54d395(players, broadcast_instance, var_8c3a7a19c10ecf05, broadcast_command) {
  omnvar_name = function_61d68ed67d014ce9(var_8c3a7a19c10ecf05);
  omnvar_type = function_35f7a3c169395432(var_8c3a7a19c10ecf05);
  var_ca55cf4e0ae3bd64 = function_2e71b566ccbca32a(var_8c3a7a19c10ecf05);

  if(broadcast_command == 0 || broadcast_command == 1) {
    omnvar_value = undefined;

    if(omnvar_type == "dynamic") {
      var_949db43ec6f96c1e = function_684411bce1d1c8bc(broadcast_instance, var_8c3a7a19c10ecf05, 0);

      if(isDefined(var_949db43ec6f96c1e)) {
        if(var_949db43ec6f96c1e.type == "ProgressTracker") {
          var_5414a0c8b564c288 = var_949db43ec6f96c1e.value;
          progress_data = function_298a9e5ee57b3737(var_949db43ec6f96c1e.format, var_5414a0c8b564c288.startingprogressvalue, var_5414a0c8b564c288.currentprogressvalue, var_5414a0c8b564c288.finalprogressvalue);
          omnvar_value = [0];
        } else {
          omnvar_value = var_949db43ec6f96c1e.value;
        }
      }
    } else {
      omnvar_value = function_5a2dda4763cf5dcb(var_8c3a7a19c10ecf05);
    }

    if(istrue(var_ca55cf4e0ae3bd64)) {
      if(!isarray(players)) {
        players = [players];
      }

      foreach(player in players) {
        player setclientomnvar(omnvar_name, omnvar_value);
      }

      return;
    }

    setomnvar(omnvar_name, omnvar_value);
  }
}

function function_cae24eff8bdddc4(players, broadcast_instance, broadcast_command) {
  assert(broadcast_instance getbroadcasttype() == "<dev string:x1c>");
  data_objects = broadcast_instance function_7437a8d48556e45e();

  if(data_objects.size == 0) {
    return;
  }

  for(var_e544eba5148ba75e = 0; var_e544eba5148ba75e < data_objects.size; var_e544eba5148ba75e++) {
    data_object = data_objects[var_e544eba5148ba75e];

    if(function_feb90d1dee0c97d1(data_object) == "Types_Activity_SplashReferenceData") {
      function_c235ffb8f79c155a(players, broadcast_instance, data_object, broadcast_command);
      continue;
    }

    assertmsg("<dev string:x2b>" + data_object.type);
  }
}

function function_ef5f9ace0e2bad4e(players, broadcast, broadcast_command) {
  assert(broadcast getbroadcasttype() == "<dev string:x87>");
  data_objects = broadcast function_7437a8d48556e45e();

  if(data_objects.size == 0) {
    return;
  }

  for(var_e544eba5148ba75e = 0; var_e544eba5148ba75e < data_objects.size; var_e544eba5148ba75e++) {
    data_object = data_objects[var_e544eba5148ba75e];
    function_a40cc36677592f02(players, data_object, broadcast_command);
  }
}

function function_7a518dd08fe0d34e(players, broadcast, broadcast_command) {
  assert(broadcast getbroadcasttype() == "<dev string:x90>");
  data_objects = broadcast function_7437a8d48556e45e();

  if(data_objects.size == 0) {
    return;
  }

  for(var_e544eba5148ba75e = 0; var_e544eba5148ba75e < data_objects.size; var_e544eba5148ba75e++) {
    data_object = data_objects[var_e544eba5148ba75e];
    function_28b732afbadec198(players, data_object, broadcast_command);
  }
}

function function_174054d9a5f63554(players, broadcast_instance, broadcast_command) {
  assert(broadcast_instance getbroadcasttype() == "<dev string:x9c>");
  data_objects = broadcast_instance function_7437a8d48556e45e();

  if(data_objects.size == 0) {
    return;
  }

  for(var_e544eba5148ba75e = 0; var_e544eba5148ba75e < data_objects.size; var_e544eba5148ba75e++) {
    data_object = data_objects[var_e544eba5148ba75e];
    function_ade09b145f54d395(players, broadcast_instance, data_object, broadcast_command);
  }
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1218a28391689c06.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#namespace namespace_2d986308;

function event_handler[gametype_start] main(eventstruct) {
  callback::on_gameplay_started(&on_gameplay_started);
  util::waitforclient(0);
}

function on_gameplay_started(localclientnum) {
  level thread nuked_population_sign_think(localclientnum);
}

function nuked_population_sign_think(localclientnum) {
  if(getdvarint(#"hash_9e6fbcc64352e9e", 0)) {
    return;
  }

  tens_model = getent(localclientnum, "counter_tens", "targetname");
  ones_model = getent(localclientnum, "counter_ones", "targetname");
  time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");

  level thread function_102a701c(tens_model, ones_model);

  step = 36;
  ones = 1;
  tens = 1;

  if(!isDefined(tens_model) || !isDefined(ones_model)) {
    return;
  }

  tens_model rotateroll(step, 0.05);
  ones_model rotateroll(step, 0.05);

  for(;;) {
    wait 1;
    dosign = 0;
    players = getlocalplayers();

    foreach(localplayer in players) {
      if(!isDefined(localplayer)) {
        continue;
      }

      if(true) {
        dosign = 1;
        break;
      }
    }

    if(!dosign) {
      continue;
    }

    players = [];

    foreach(player in getplayers(localclientnum)) {
      if(isDefined(player)) {
        if(!isDefined(players)) {
          players = [];
        } else if(!isarray(players)) {
          players = array(players);
        }

        players[players.size] = player;
      }
    }

    for(dial = ones + tens * 10; players.size < dial; dial = ones + tens * 10) {
      ones--;

      if(ones < 0) {
        ones = 9;

        if(isDefined(tens_model)) {
          tens_model rotateroll(0 - step, time);
        }

        tens--;
      }

      if(isDefined(ones_model)) {
        ones_model rotateroll(0 - step, time);
        ones_model waittill(#"rotatedone");
      }
    }

    while(players.size > dial) {
      ones++;

      if(ones > 9) {
        ones = 0;

        if(isDefined(tens_model)) {
          tens_model rotateroll(step, time);
        }

        tens++;
      }

      if(isDefined(ones_model)) {
        ones_model rotateroll(step, time);
        ones_model waittill(#"rotatedone");
      }

      dial = ones + tens * 10;
    }
  }
}

function set_dvar_float_if_unset(dvar, value) {
  if(getdvarstring(dvar) == "") {
    setDvar(dvar, value);
  }

  return getdvarfloat(dvar, 0);
}

function function_102a701c(tens, ones) {
  while(!isDefined(tens) || !isDefined(ones)) {
    iprintlnbold("<dev string:x38>");
    wait 2;
  }
}
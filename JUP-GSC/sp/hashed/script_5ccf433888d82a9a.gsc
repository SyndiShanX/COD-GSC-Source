/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5ccf433888d82a9a.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace namespace_4256b08ee38a2255;

function function_ed68c9be9d1ddd23() {
  function_7f6ae2b525a3e12a();
}

function splash_monitor() {
  level.splash_active = 0;

  while(true) {
    level waittill("new_splash");
    level.splash_active = 1;
    wait 4;
    level.splash_active = 0;
  }
}

function function_7f6ae2b525a3e12a() {
  function_dc6d1b40589ca236();
  thread splash_monitor();
  scripts\engine\scriptable::scriptable_addusedcallback(&function_de1149fa62dbfe47);
}

function function_dc6d1b40589ca236() {
  switch (level.mapname) {
    case #"hash_5c03122b70ff4094":
      level.var_f4a36f82e38789b5 = 0;
      break;
    case #"hash_c3c819184bc33817":
      level.var_f4a36f82e38789b5 = 1;
      break;
    case #"hash_619829c7b3c4c3e3":
      level.var_f4a36f82e38789b5 = 2;
      break;
    case #"hash_3705bde815a332ea":
      level.var_f4a36f82e38789b5 = 3;
      break;
    case #"hash_6b2477606925177a":
      level.var_f4a36f82e38789b5 = 4;
      break;
    case #"hash_8e2389607af0427b":
      level.var_f4a36f82e38789b5 = 5;
      break;
    default:
      break;
  }
}

function function_c607ddea71489857() {
  total = 0;

  for(i = 0; i <= 5; i++) {
    total += level.player function_7d97fa985af1c8a5(i);
  }

  return total;
}

function function_f0010a76794e4fa7() {
  for(i = 0; i <= 5; i++) {
    level.player function_5e2bfc80545dc98e(i);
  }
}

function function_de1149fa62dbfe47(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(level.var_f4a36f82e38789b5)) {
    return;
  }

  if(getdvarint(@ "hash_a0f041fa705e80e6", 0)) {
    function_f0010a76794e4fa7();
  }

  var_5ed46ecac4c54ddd = player function_7d97fa985af1c8a5(level.var_f4a36f82e38789b5);
  var_5ed46ecac4c54ddd = default_to(var_5ed46ecac4c54ddd, 0);

  if(var_5ed46ecac4c54ddd < 3) {
    if(issubstr(part, "brloot_super")) {
      var_aa14ab078fd0313d = function_c607ddea71489857();

      if(var_aa14ab078fd0313d < 5) {
        while(level.splash_active) {
          wait 0.1;
        }

        tutorial_state = player getclientomnvar("ui_tutorial_message_state");

        if(tutorial_state == 1) {
          wait 4;
          tutorial_state = player getclientomnvar("ui_tutorial_message_state");

          if(tutorial_state == 1) {
            return;
          }
        }

        if(player usinggamepad()) {
          player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/FIELDUPGRADE", 6);
        } else {
          player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/FIELDUPGRADE_KBM", 6);
        }

        player function_f12562902f6f598b(level.var_f4a36f82e38789b5, var_5ed46ecac4c54ddd + 1);
      }
    }
  }
}
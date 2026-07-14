/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_6852b85528e74b9b.gsc
*****************************************************/

#using script_1aae2eb1ef28b239;
#using script_4a2005cdcbf64b88;
#using script_f01501ac138f999;
#using scripts\engine\utility;
#namespace namespace_4d9bab4515d9688d;

function function_163f8d985c0396a2(activityinstance, activitymoment) {
  if(istrue(activityinstance.var_5c5a5daba1ab602f.var_30acbef8a0a778f3)) {
    type = namespace_7b5dc905a7ea3e0f::function_a03971aca814705(activityinstance);
    spawnmoment = namespace_7b5dc905a7ea3e0f::function_d8fec2f7c41a0122(activityinstance);
    destroymoment = namespace_7b5dc905a7ea3e0f::function_62a8f782b04a867f(activityinstance);

    if(spawnmoment == activitymoment) {
      if(type == "Y\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95") {
        function_705681cbe547f9a(activityinstance);
      } else {
        utility::callsharedfunc(#"hash_61266e374b6a4978", #"hash_cfba68776eb6b6d1", activityinstance);
      }

      return;
    }

    if(destroymoment == activitymoment) {
      if(type == "yw\xf9\x973\xc6@t\xee") {
        utility::callsharedfunc(#"hash_61266e374b6a4978", #"hash_82d433365dffce54", activityinstance);
      }
    }
  }
}

function function_cea899190a93e8a5(activityinstance) {
  return activityinstance.var_bdf6bca21b27c614;
}

function function_d822b6858092f218(var_4f4e3a88928c255c, var_826f188d8279dac7) {
  var_bdf6bca21b27c614 = spawnStruct();
  var_bdf6bca21b27c614.objectivemarkertype = var_4f4e3a88928c255c;

  if(var_4f4e3a88928c255c == "Y\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95") {
    var_bdf6bca21b27c614.scriptable = var_826f188d8279dac7;
  } else {
    var_bdf6bca21b27c614.objectivemarkerid = var_826f188d8279dac7;
  }

  return var_bdf6bca21b27c614;
}

function function_395ba731c6c50f92(player) {
  utility::callsharedfunc(#"hash_61266e374b6a4978", #"hash_2c771489de24ca63", player);
}

function function_7d26df810be11dc7(player) {
  utility::callsharedfunc(#"hash_61266e374b6a4978", #"hash_a9dac899f49dbbe", player);
}

function function_57dc2c730e5f773() {
  utility::callsharedfunc(#"hash_61266e374b6a4978", #"hash_32b413eabeba80ce");
}

function private function_705681cbe547f9a(activityinstance) {
  var_eaf1c64a0de7fe83 = namespace_7b5dc905a7ea3e0f::function_ee52ff2d6c0218a1(activityinstance);
  origin = namespace_59dbf6a1bb28a43f::function_c1c44508d7539941(activityinstance);
  destroymoment = namespace_7b5dc905a7ea3e0f::function_62a8f782b04a867f(activityinstance);
  scriptable = activity_scriptables::function_a58ff6224d7732ee(activityinstance, var_eaf1c64a0de7fe83, origin, destroymoment);
  var_bdf6bca21b27c614 = function_d822b6858092f218("Y\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95", scriptable);
  activityinstance.var_bdf6bca21b27c614 = var_bdf6bca21b27c614;
}
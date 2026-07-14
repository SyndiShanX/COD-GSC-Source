/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_cf99d60d77d12eb.gsc
****************************************************/

#using script_4e1f1a7ef824ddd5;
#using script_7df192c4714a34bb;
#using scripts\common\player_broadcasting;
#using scripts\engine\utility;
#namespace namespace_654eea393c3f72dd;

function function_fd284f84c92b6e40(players, broadcast_instance, var_762b41e1623d58fc, broadcast_command) {
  omnvar_name = namespace_59b081b19a436abb::function_2124359cf367f46c(var_762b41e1623d58fc);
  omnvar_type = namespace_59b081b19a436abb::function_f3513d05156ba5b3(var_762b41e1623d58fc);
  var_d614bc481c3b8659 = namespace_59b081b19a436abb::function_425b532a28ba8c53(var_762b41e1623d58fc);

  if(broadcast_command == 0 || broadcast_command == 1) {
    omnvar_value = undefined;

    if(omnvar_type == "\x18$\xe5\xec\fjx") {
      var_4aec629fced68273 = namespace_59b081b19a436abb::function_9dcfbc1e2bb032c5(broadcast_instance, var_762b41e1623d58fc, 0);

      if(isDefined(var_4aec629fced68273)) {
        if(var_4aec629fced68273.type == "gvA@\xe7\xf3\tO\x9e\x82\x94gjD3") {
          var_f327c42642ddc581 = var_4aec629fced68273.value;
          progress_data = namespace_59b081b19a436abb::function_a7a2f1c10488d00e(var_4aec629fced68273.format, var_f327c42642ddc581.startingprogressvalue, var_f327c42642ddc581.currentprogressvalue, var_f327c42642ddc581.finalprogressvalue);
          omnvar_value = [0];
        } else {
          omnvar_value = var_4aec629fced68273.value;
        }
      }
    } else {
      omnvar_value = namespace_59b081b19a436abb::function_97089bccb5200ae6(var_762b41e1623d58fc);
    }

    if(istrue(var_d614bc481c3b8659)) {
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

function function_e036cc81bda82998(players, broadcast_instance, broadcast_command) {
  assert(broadcast_instance player_broadcasting::getbroadcasttype() == "<dev string:x24>");
  data_objects = broadcast_instance player_broadcasting::function_242ee4b760cb7bf();

  if(data_objects.size == 0 || broadcast_command == 2) {
    return;
  }

  for(var_2015179b3cbab5af = 0; var_2015179b3cbab5af < data_objects.size; var_2015179b3cbab5af++) {
    data_object = data_objects[var_2015179b3cbab5af];
    text = data_object.variant_object.stringtext;
    style = data_object.variant_object.stringtextstyle;

    if(isstring(text) && isstring(style)) {
      text = function_c01ec61c0e37f1c2(text, broadcast_instance, data_object);

      if(style == "<dev string:x32>") {
        iprintlnbold(text);
      } else {
        iprintln(text);
      }

      continue;
    }

    assertmsg("<dev string:x48>");
  }
}

function function_8940a3f1045a83fd(players, broadcast_instance, broadcast_command) {
  assert(broadcast_instance player_broadcasting::getbroadcasttype() == "<dev string:xa1>");
  data_objects = broadcast_instance player_broadcasting::function_242ee4b760cb7bf();

  if(data_objects.size == 0) {
    return;
  }

  for(var_2015179b3cbab5af = 0; var_2015179b3cbab5af < data_objects.size; var_2015179b3cbab5af++) {
    data_object = data_objects[var_2015179b3cbab5af];
    function_fd284f84c92b6e40(players, broadcast_instance, data_object, broadcast_command);
  }
}

function function_a7ff66580a7a774d(players, broadcast, broadcast_command) {
  namespace_c16c7425341147cd::function_e3bfdf803348071b(players, broadcast, broadcast_command);
}

function private function_c01ec61c0e37f1c2(var_35b3e80edd4b886, broadcast_instance, data_object) {
  var_8edadbcadf4e537d = namespace_59b081b19a436abb::function_590fadcee423aa2f(data_object);
  var_175a5c933f8dc9b4 = var_8edadbcadf4e537d.size;

  for(var_e0bf98efa2e5226 = 0; var_e0bf98efa2e5226 < var_175a5c933f8dc9b4; var_e0bf98efa2e5226++) {
    var_4aec629fced68273 = namespace_59b081b19a436abb::function_9dcfbc1e2bb032c5(broadcast_instance, data_object, var_e0bf98efa2e5226);

    if(isDefined(var_4aec629fced68273) && isDefined(var_4aec629fced68273.value)) {
      var_1f0247921323ed34 = var_4aec629fced68273.value;

      if(var_4aec629fced68273.type != "\x03\xa8}\x1d\xdb/") {
        var_1f0247921323ed34 = utility::string(var_1f0247921323ed34);
      }

      replacement_substring = "\xb9\r" + utility::string(var_e0bf98efa2e5226);
      string_array = strtok(var_35b3e80edd4b886, "\xda");
      var_f9e8fdb647a0bb1c = [];

      for(string_index = 0; string_index < string_array.size; string_index++) {
        substr = string_array[string_index];
        var_f9e8fdb647a0bb1c[string_index] = substr == replacement_substring ? var_1f0247921323ed34 : substr;
      }

      var_35b3e80edd4b886 = function_43734668ca51504("\xda", var_f9e8fdb647a0bb1c);
    }
  }

  return var_35b3e80edd4b886;
}
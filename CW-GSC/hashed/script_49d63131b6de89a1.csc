/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_49d63131b6de89a1.csc
***********************************************/

#using scripts\core_common\exploder_shared;
#namespace namespace_cf4aa5f0;

function function_6dbaba52(name, var_36286198, var_2f7c44e9, stop_exploders, var_50c0eadc, var_82e50bac = undefined) {
  if(!isDefined(level.rule)) {
    level.rule = [];
  }

  if(isDefined(level.rule[name])) {
    var_65e2dd7c = level.rule[name];
  } else {
    var_65e2dd7c = {
      #var_74a7721: var_82e50bac, #play: [], #var_e4474fe9: [], #stop: [], #kill: []
    };
  }

  profilestart();
  function_6e561a85(var_65e2dd7c.play, var_36286198);
  function_6e561a85(var_65e2dd7c.var_e4474fe9, var_2f7c44e9);
  function_6e561a85(var_65e2dd7c.stop, stop_exploders);
  function_6e561a85(var_65e2dd7c.kill, var_50c0eadc);
  profilestop();
  level.rule[name] = var_65e2dd7c;
}

function private function_6e561a85(&var_c4d527a6, exploders) {
  if(!isDefined(exploders)) {
    return;
  }

  if(isarray(exploders)) {
    foreach(exploder in exploders) {
      if(isstring(exploder) || ishash(exploder)) {
        if(!isDefined(var_c4d527a6)) {
          var_c4d527a6 = [];
        } else if(!isarray(var_c4d527a6)) {
          var_c4d527a6 = array(var_c4d527a6);
        }

        if(!isinarray(var_c4d527a6, exploder)) {
          var_c4d527a6[var_c4d527a6.size] = exploder;
        }
      }
    }

    return;
  }

  if(isstring(exploders) || ishash(exploders)) {
    if(!isDefined(var_c4d527a6)) {
      var_c4d527a6 = [];
    } else if(!isarray(var_c4d527a6)) {
      var_c4d527a6 = array(var_c4d527a6);
    }

    if(!isinarray(var_c4d527a6, exploders)) {
      var_c4d527a6[var_c4d527a6.size] = exploders;
    }
  }
}

function private function_fcfe0dbe(name) {
  level endon(#"end_game");
  var_65e2dd7c = level.rule[name];
  assert(isDefined(var_65e2dd7c));

  if(isDefined(level.rule[name].var_74a7721)) {
    [[level.rule[name].var_74a7721]]();
  }

  profilestart();
  function_3c540c33(var_65e2dd7c.kill, &exploder::kill_exploder);
  function_3c540c33(var_65e2dd7c.stop, &exploder::stop_exploder);
  function_3c540c33(var_65e2dd7c.play, &exploder::exploder);
  function_3c540c33(var_65e2dd7c.var_e4474fe9, &exploder::function_993369d6);
  profilestop();
}

function function_470d684a(name) {
  level thread function_fcfe0dbe(name);
}

function private function_169b8acc(name) {
  level endon(#"end_game");

  while(true) {
    function_fcfe0dbe(name);
    waitframe(1);
  }
}

function function_25002e3(name) {
  level thread function_169b8acc(name);
}

function private function_3c540c33(var_c4d527a6, var_d9470764) {
  if(!isDefined(var_c4d527a6)) {
    return;
  }

  foreach(exploder in var_c4d527a6) {
    [[var_d9470764]](exploder);
  }
}
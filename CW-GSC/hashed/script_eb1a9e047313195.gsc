/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_eb1a9e047313195.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#namespace namespace_ae270045;

function function_cfcd9b92(var_5b36f17f, var_efccf092, var_b04adac9, var_8ab7d27b = 1, var_c1c8f1d, var_ef1623ea = 20) {
  if(!namespace_61e6d095::exists(#"scripted_timer")) {
    namespace_61e6d095::create(#"scripted_timer", #"hash_16d65500e6bdc837");
    namespace_61e6d095::set_text(#"scripted_timer", var_efccf092);

    if(isDefined(var_b04adac9)) {
      namespace_61e6d095::function_309bf7c2(#"scripted_timer", var_b04adac9);
    }

    function_e782b221(var_5b36f17f, var_8ab7d27b, var_c1c8f1d, var_ef1623ea);
  }
}

function function_9c8d2a44(var_1723b73d) {
  if(namespace_61e6d095::exists(#"scripted_timer")) {
    namespace_61e6d095::set_text(#"scripted_timer", var_1723b73d);
  }
}

function private function_e782b221(start_time, var_8ab7d27b, var_c1c8f1d, var_ef1623ea) {
  level endon(#"hash_267bd9980f77d5f4", #"level_restarting", #"death");
  run_time = int(start_time * 1000);
  namespace_61e6d095::set_time(#"scripted_timer", run_time);
  start_time = run_time;
  var_da7e097b = -1;
  var_469ff952 = 0;

  while(run_time >= 0) {
    run_time = max(run_time - function_60d95f53(), 0);
    namespace_61e6d095::set_time(#"scripted_timer", run_time);

    if(var_8ab7d27b) {
      perc = run_time / start_time * 100;
      quarter = int(min(floor(perc / 25), 3));

      if(!var_469ff952 && perc <= var_ef1623ea && isDefined(var_c1c8f1d)) {
        var_469ff952 = 1;
        namespace_61e6d095::set_text(#"scripted_timer", var_c1c8f1d);
      }

      if(var_da7e097b != quarter) {
        var_da7e097b = quarter;

        if(quarter > 0 || perc <= 10) {
          namespace_61e6d095::set_state(#"scripted_timer", quarter);
        } else {
          namespace_61e6d095::set_state(#"scripted_timer", 0);
        }
      }
    }

    if(run_time <= 0) {
      level thread function_94505a0b();
      break;
    }

    waitframe(1);
  }
}

function private function_94505a0b() {
  level notify(#"hash_56a61cb4fe8b8e79");
  function_5e3101b2();
}

function function_5e3101b2() {
  level notify(#"hash_267bd9980f77d5f4");

  if(namespace_61e6d095::exists(#"scripted_timer")) {
    namespace_61e6d095::remove(#"scripted_timer");
  }
}
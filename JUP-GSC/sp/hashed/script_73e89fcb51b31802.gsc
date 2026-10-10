/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_73e89fcb51b31802.gsc
*************************************************/

#namespace namespace_c4a35109adf81593;

function main() {
  level.var_e5e4f305f88c0782 = undefined;
}

function function_4b119908bdf12329(var_f5713abc5f165cfa, fade_out_time, fade_in_time) {
  if(isDefined(level.var_e5e4f305f88c0782)) {
    if(isDefined(var_f5713abc5f165cfa)) {
      if(var_f5713abc5f165cfa == level.var_e5e4f305f88c0782) {
        return;
      }
    }

    level.player clearsoundsubmix(level.var_e5e4f305f88c0782, fade_out_time);
  }

  level.var_e5e4f305f88c0782 = var_f5713abc5f165cfa;

  if(isDefined(var_f5713abc5f165cfa)) {
    level.player setsoundsubmix(var_f5713abc5f165cfa, fade_in_time);
  }
}

function function_fcdf5a0628a1911a(var_a4fa05d4abb688b6, fade_out_time, fade_in_time) {
  if(isDefined(level.var_e5e4f305f88c0782)) {
    level.player clearsoundsubmix(level.var_e5e4f305f88c0782, fade_out_time);
  }

  if(function_9b578c5917366e94(var_a4fa05d4abb688b6)) {
    level.player setsoundsubmix(var_a4fa05d4abb688b6, fade_in_time);
  }
}

function function_c7c5c2ca61454c41(var_a4fa05d4abb688b6, fade_out_time, fade_in_time) {
  if(function_9b578c5917366e94(var_a4fa05d4abb688b6)) {
    level.player clearsoundsubmix(var_a4fa05d4abb688b6, fade_out_time);
  }

  if(isDefined(level.var_e5e4f305f88c0782)) {
    level.player setsoundsubmix(level.var_e5e4f305f88c0782, fade_in_time);
  }
}

function function_7dff40c0e5cc9dbe() {
  var_f13cf7e07e066520 = (1970, 3704, -408);
  level.alarment = spawn("script_model", var_f13cf7e07e066520);
  level.alarment playLoopSound("scn_jup_lower_base_security_alarm");
  wait 23;
  level.alarment stoploopsound("scn_jup_lower_base_security_alarm", 1);
  level.alarment playSound("scn_jup_lower_base_security_alarm_tail");
  wait 2;
  level.alarment delete();
}
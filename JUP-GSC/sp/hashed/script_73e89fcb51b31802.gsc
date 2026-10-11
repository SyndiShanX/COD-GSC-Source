/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_73e89fcb51b31802.gsc
*************************************************/

#namespace namespace_c4a35109adf81593;

function main() {
  level.var_e5e4f305f88c0782 = undefined;
}

function function_4b119908bdf12329(new_submix, fade_out_time, fade_in_time) {
  if(isDefined(level.var_e5e4f305f88c0782)) {
    if(isDefined(new_submix)) {
      if(new_submix == level.var_e5e4f305f88c0782) {
        return;
      }
    }

    level.player clearsoundsubmix(level.var_e5e4f305f88c0782, fade_out_time);
  }

  level.var_e5e4f305f88c0782 = new_submix;

  if(isDefined(new_submix)) {
    level.player setsoundsubmix(new_submix, fade_in_time);
  }
}

function function_fcdf5a0628a1911a(transient_submix, fade_out_time, fade_in_time) {
  if(isDefined(level.var_e5e4f305f88c0782)) {
    level.player clearsoundsubmix(level.var_e5e4f305f88c0782, fade_out_time);
  }

  if(function_9b578c5917366e94(transient_submix)) {
    level.player setsoundsubmix(transient_submix, fade_in_time);
  }
}

function function_c7c5c2ca61454c41(transient_submix, fade_out_time, fade_in_time) {
  if(function_9b578c5917366e94(transient_submix)) {
    level.player clearsoundsubmix(transient_submix, fade_out_time);
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
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7921358c02f87a25.gsc
*************************************************/

#using script_72ef6b9f0cf1f55a;
#namespace namespace_cee9ba48af751d44;

function init_countdown(timeout, var_61f0278fde0a9f65, cancel_notify) {
  if(!isDefined(var_61f0278fde0a9f65)) {
    var_61f0278fde0a9f65 = "progressBar";
  }

  var_675b56b3f2d87528 = function_6cd0a8e23ff14e13("scripted_widget_countdown");
  function_90de31b2cbef19f9("coundown_display", var_675b56b3f2d87528);
  function_d28fa5295a04d555("coundown_display", var_61f0278fde0a9f65);

  if(isDefined(cancel_notify)) {
    thread function_6c96b4865151ccc7(cancel_notify);
  }

  thread start_countdown_timer(timeout);
}

function private function_6c96b4865151ccc7(cancel_notify) {
  self endon("countdown_end");
  self waittill(cancel_notify);
  function_6a07800c221ecb09();
}

function private start_countdown_timer(time) {
  self endon("countdown_end");
  self endon("death");
  function_ddc9d8c3b0ef6b87("coundown_display", 1, 0, time);
  wait time;
  function_6a07800c221ecb09();
}

function function_6a07800c221ecb09() {
  scripted_widget_destroy("coundown_display");
  self notify("countdown_end");
}
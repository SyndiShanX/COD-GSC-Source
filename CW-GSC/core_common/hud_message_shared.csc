/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\hud_message_shared.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace hud_message;

function private autoexec __init__system__() {
  system::register(#"hud_message", &preinit, undefined, undefined, undefined);
}

function private preinit() {}

function function_65299180(localclientnum, var_e69b15f0, arglist) {
  scriptnotifymodel = function_1df4c3b0(localclientnum, #"script_notify");

  for(i = 0; i < arglist.size; i++) {
    setuimodelvalue(getuimodel(scriptnotifymodel, #"arg" + i + 1), arglist[i]);
  }

  setuimodelvalue(getuimodel(scriptnotifymodel, #"numargs"), arglist.size);

  if(!setuimodelvalue(scriptnotifymodel, var_e69b15f0)) {
    forcenotifyuimodel(scriptnotifymodel);
  }
}

function setlowermessage(localclientnum, text, time) {
  if(isDefined(time) && time > 0) {
    function_65299180(localclientnum, #"hash_424b9c54c8bf7a82", [text, int(time)]);
    return;
  }

  function_65299180(localclientnum, #"hash_424b9c54c8bf7a82", [text]);
}

function clearlowermessage(localclientnum) {
  function_65299180(localclientnum, #"hash_6b9a1c6794314120", []);
}
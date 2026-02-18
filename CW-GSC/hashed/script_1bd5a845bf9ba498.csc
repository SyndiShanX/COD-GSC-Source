/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1bd5a845bf9ba498.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace namespace_14c21b91;

function private autoexec __init__system__() {
  system::register(#"hash_e77f876300a38be", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_end_game(&on_end_game);
}

function event_handler[gametype_start] codecallback_startgametype(eventstruct) {
  if(sessionmodeismultiplayergame() && function_8f29c880()) {
    function_3ae87223();
  }
}

function on_end_game(localclientnum) {
  if(sessionmodeismultiplayergame() && function_8f29c880()) {
    function_8871747f();
  }
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\radiation.csc
***********************************************/

#using script_2d142c6d365a90a3;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\radiation_ui;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\system_shared;
#namespace radiation;

function private autoexec __init__system__() {
  system::register(#"radiation", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  clientfield::register("toplayer", "ftdb_inZone", 1, 1, "int", &function_c76638c, 0, 1);
  level.var_96929d7f = [];
  level.var_2200e558 = [];
  level.var_e7fd1b8f = [];
  level.var_d91da973 = 1;
  callback::on_localclient_connect(&function_f45ee99d);
  callback::on_end_game(&on_end_game);
}

function function_f45ee99d(localclientnum) {
  level.var_96929d7f[localclientnum] = spawnStruct();
  level.var_96929d7f[localclientnum].var_32adf91d = 0;
  level.var_96929d7f[localclientnum].sickness = [];
}

function on_end_game(localclientnum) {
  forceambientroom("");
}

function private function_c76638c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.var_2200e558[fieldname] = bwastimejump;
  ambientroom = "";

  foreach(val in level.var_2200e558) {
    if(val > 0) {
      ambientroom = "wz_radiation";
      break;
    }
  }

  if(function_52a9d718() !== ambientroom) {
    forceambientroom(ambientroom);
  }

  if(bwastimejump) {
    while(isDefined(self) && !self hasdobj(fieldname)) {
      waitframe(1);
    }

    if(!isDefined(self)) {
      return;
    }

    if(squad_spawn::function_21b773d5(fieldname)) {
      return;
    }

    if(!isarray(level.var_e7fd1b8f[fieldname])) {
      level.var_e7fd1b8f[fieldname] = playtagfxset(fieldname, "tagfx9_camfx_gametype_dirtybomb_ash", self);
    }

    return;
  }

  if(isarray(level.var_e7fd1b8f[fieldname])) {
    foreach(fx in level.var_e7fd1b8f[fieldname]) {
      stopfx(fieldname, fx);
    }

    level.var_e7fd1b8f[fieldname] = undefined;
  }
}
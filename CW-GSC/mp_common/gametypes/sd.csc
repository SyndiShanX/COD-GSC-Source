/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\sd.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace sd;

function event_handler[gametype_init] main(eventstruct) {
  if(getgametypesetting(#"silentplant") != 0) {
    setsoundcontext("bomb_plant", "silent");
  }

  level.var_e4935474 = [];
  clientfield::function_5b7d846d("hudItems.war.attackingTeam", #"war_data", #"attackingteam", 1, 2, "int", undefined, 0, 1);
  clientfield::register("scriptmover", "entityModelsNum", 1, 10, "int", &function_e116df6c, 0, 0);
}

function function_e116df6c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_e4935474)) {
    level.var_e4935474 = [];
  }

  if(bwastimejump != fieldname) {
    entitynumber = self getentitynumber();

    if(bwastimejump != -1) {
      level.var_e4935474[entitynumber] = {};
      level.var_e4935474[entitynumber].var_eec7f99d = bwastimejump;
      level.var_e4935474[entitynumber].var_7c69bb09 = self.team;
    }

    codcaster::function_12acfa84();
  }
}
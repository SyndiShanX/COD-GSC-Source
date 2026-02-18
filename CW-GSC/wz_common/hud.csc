/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\hud.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace hud;

function function_9b9cecdf() {
  clientfield::function_5b7d846d("hudItems.warzone.reinsertionPassengerCount", #"warzone_global", #"reinsertionpassengercount", 1, 7, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.alivePlayerCount", #"hud_items", #"aliveplayercount", 1, 7, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.aliveTeammateCount", #"hud_items", #"aliveteammatecount", 1, 7, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.spectatorsCount", #"hud_items", #"spectatorscount", 1, 7, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.playerKills", #"hud_items", #"playerkills", 1, 7, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.playerCleanUps", #"hud_items", #"playercleanups", 1, 7, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("presence.modeparam", #"hash_3645501c8ba141af", #"modeparam", 1, 7, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.armorType", #"hud_items", #"armortype", 1, 2, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.streamerLoadFraction", #"hud_items", #"streamerloadfraction", 1, 5, "float", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.wzLoadFinished", #"hud_items", #"wzloadfinished", 1, 1, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.showReinsertionPassengerCount", #"hud_items", #"showreinsertionpassengercount", 1, 1, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.playerLivesRemaining", #"hud_items", #"playerlivesremaining", 7000, 4, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.playerLivesRemainingPredicted", #"hud_items", #"playerlivesremainingpredicted", 7000, 4, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.playerCanRedeploy", #"hud_items", #"playercanredeploy", 7000, 1, "int", &function_6d8efb27, 0, 0);
  clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int", &function_a1b40aa4, 0, 0);
  clientfield::function_5b7d846d("hudItems.warzone.collapse", #"warzone_global", #"collapse", 7000, 21, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("hudItems.warzone.waveRespawnTimer", #"warzone_global", #"waverespawntimer", 7000, 21, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("hudItems.warzone.collapseIndex", #"warzone_global", #"collapseindex", 1, 3, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("hudItems.warzone.collapseCount", #"warzone_global", #"collapsecount", 1, 3, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("hudItems.warzone.reinsertionIndex", #"warzone_global", #"reinsertionindex", 1, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.skydiveAltimeterVisible", #"hud_items", #"skydivealtimetervisible", 1, 1, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("hudItems.skydiveAltimeterHeight", #"hash_410fe12a68d6e801", #"skydivealtimeterheight", 1, 16, "int", undefined, 0, 0);
  clientfield::function_5b7d846d("hudItems.skydiveAltimeterSeaHeight", #"hash_410fe12a68d6e801", #"skydivealtimeterseaheight", 1, 16, "int", undefined, 0, 0);
}

function function_a1b40aa4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = function_27673a7(binitialsnap);

  if(player != self) {
    return;
  }

  if(bwastimejump) {
    return;
  }

  if(!isPlayer(player) || !isalive(player)) {
    function_3f258626(binitialsnap);
    return;
  }

  if(fieldname == 1) {
    function_9e9a0604(binitialsnap);
    return;
  }

  function_3f258626(binitialsnap);
}

function function_6d8efb27(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playSound(fieldname, #"hash_52dfa8799787630e", (0, 0, 0));
    return;
  }

  playSound(fieldname, #"hash_34d90ac30af77a9b", (0, 0, 0));
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3d3a4f9a13038759.gsc
*************************************************/

#using script_35ee5e2cef30eea2;
#using script_5693b37bfb748170;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#namespace namespace_ffc66489af4e13ac;

function function_d5724a0f0cd63d12() {
  function_a3db364a0ccc4fd8();
  function_a44b57cf475cf6c1(1);
  level.var_80c1e8e18146024f = &function_bc9bc92f91fb076d;
}

function function_422c480d1e41bff2() {
  assertex(isDefined(level.endgame), "<dev string:x1c>");
  level.forcedend = 1;
  level thread[[level.endgame]]();
}

function function_bc9bc92f91fb076d(var_7b6d5db8cb3c5782) {
  pausecircle(1);
  level.br_circle.safecircleent = spawn("script_model", (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], level.br_level.br_circleradii[1]));
  level.br_circle.safecircleent.hidden = 0;
  level.br_circle.safecircleui = spawn("script_model", level.br_circle.safecircleent.origin);
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.dangercircleent = spawnbrcircle(level.br_level.br_circlecenters[0][0], level.br_level.br_circlecenters[0][1], level.br_level.br_circleradii[0]);
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.dangercircleent thread dangercircleenthidefromplayers();
  level.br_circle.dangercircleui = spawn("script_model", level.br_circle.dangercircleent.origin);
  level.br_circle.dangercircleui.hidden = 0;
  function_2f4fb0777ebb4cc0();
  waitframe();
  hidedangercircle();
  setpreviewuicircle(level.br_circle.safecircleent);

  if(istrue(level.usegulag)) {
    scripts\mp\gametypes\br_gulag::setupgulagtimer();
  }

  showdangercircle();
  level.br_circle thread circledamagetick();
  level thread stopcirclesatgameend();
  level.br_circle.circleinittime = gettime();

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(i = 0; i < level.br_level.br_circledelaytimes.size; i++) {
      circletimer(i);
    }
  }

  scripts\mp\gametypes\br_armory_kiosk::disableallarmorykiosks();
}

function private function_a3db364a0ccc4fd8() {
  level.isbrpracticemode = 1;
  level.disableannouncer = 1;
  level.br_infils_disabled = 0;
  setDvar(@ "hash_47d8674c992e098", 1);
  setDvar(@ "hash_192990fc79b06600", 1);
  setDvar(@ "hash_90a3dfd557408611", 0);
  setDvar(@ "hash_18afe7a288a4b1e4", 1);
  setDvar(@ "hash_eb038ca43332e718", 1);
  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("teamSpectate");
  scripts\mp\gametypes\br_gametypes::disablefeature("drogBagLoadout");
  clearmusicstate();
}
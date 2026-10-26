/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_lighting.gsc
*********************************************************/

main() {
  _id_84F8();

  if(level._id_01D4 && getDvar("ps3Game") != "true") {
    xbox_optimizations();
  }

  if(level._id_0149 && getDvar("ps4Game") != "true") {
    neo_optimizations();
  }

  level thread maps\mp\_utility::_id_6F74(::onplayerspawned);
}

onplayerspawned() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 0.5;
  var_0 digitaldistortsetparams(0.25, 1.7, 1.2, 1.2, 0);
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 0);
  setDvar("4230", 500);
  setDvar("2387", 1);
  setDvar("1578", 3);
  setDvar("r_gtaoQualityLevel", 1);
  setDvar("sm_spotShadowMapSize", 1);
  setDvar("r_frustumLightProxyExpand", 2);
}

neo_optimizations() {
  setDvar("1578", 2);
}

xbox_optimizations() {
  setDvar("1578", 0);
  setDvar("r_gtaoQualityLevel", 0);
}

main_off() {
  var_0 = spawnStruct();
  var_0.transitiontime = 2;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.687426, 0.828278, 1);
  var_0.atmosfoghazecolor = (0.826306, 0.773848, 0.422946);
  var_0.atmosfoghazestrength = 0.173616;
  var_0.atmosfoghazespread = 0.118084;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfogextinctiondesaturation = 0.472503;
  var_0.atmosfoginscatterstrength = 19.5715;
  var_0.atmosfoghalfplanedistance = 67391.6;
  var_0.atmosfogstartdistance = -1000;
  var_0.atmosfogdistancescale = 2.45955;
  var_0.atmosfogskydistance = 45612;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 16.5631;
  var_0.atmosfogskyfalloffanglerange = 219.708;
  var_0.atmosfogsundirection = (0.629852, -0.752156, 0.193774);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 554.428;
  var_0.atmosfogheightfoghalfplanedistance = 140.001;
  var_0.atmosfogheightfogmaximumoffset = 596.118;
  var_0.atmosfogheightfogstrengthofdepthfog = 0.646403;
  var_0.atmosfogentityscale = 1;
  var_0.atmosfogairlightcapacity = 0;
  var_0.atmosfogairlightdensityscalar = 1;
  var_0.atmosfogairlightvertexinnermutedradius = 0;
  var_0.atmosfogsplineenabled = 1;
  var_0.atmosfogsplinecustomdistance1 = 3564.58;
  var_0.atmosfogsplinecustomdistance2 = 12745.2;
  var_0.atmosfogsplinecustomdistance3 = 69106.2;
  var_0.atmosfogsplinemaxdistance = 69106.2;
  var_0.atmosfogsplinecustomvisibility1 = 0.00404669;
  var_0.atmosfogsplinecustomvisibility2 = 0.119998;
  var_0.atmosfogsplinecustomvisibility3 = 0.753736;
  var_0.atmosfogsplinemaxdistancevisibility = 0.9411;
  var_0.atmosfogsplineusemaxdistancevisibilityoverride = 0;
  var_0.atmosfogsplinemaxdistancevisibilityoverride = (0, 0, 0);
  var_0.atmosfogsplinecustomtangentsenabled = 0;
  var_0.atmosfogsplinestartingtangentangle = 0;
  var_0.atmosfogsplinecustomtangentangle1 = 0;
  var_0.atmosfogsplinecustomtangentangle2 = 0;
  var_0.atmosfogsplinecustomtangentangle3 = 0;
  var_0.atmosfogsplinemaxdistancetangentangle = 0;
  level.island_fog_off = var_0;
}

main_on() {
  var_0 = spawnStruct();
  var_0.transitiontime = 2;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.859647, 0.926756, 1);
  var_0.atmosfoghazecolor = (0.754224, 0.754224, 0.754224);
  var_0.atmosfoghazestrength = 0.3258;
  var_0.atmosfoghazespread = 0.592218;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfogextinctiondesaturation = 0.472503;
  var_0.atmosfoginscatterstrength = 18.363;
  var_0.atmosfoghalfplanedistance = 127780;
  var_0.atmosfogstartdistance = 176.675;
  var_0.atmosfogdistancescale = 2.45955;
  var_0.atmosfogskydistance = 70760;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 40.7579;
  var_0.atmosfogskyfalloffanglerange = 425.773;
  var_0.atmosfogsundirection = (0.629852, -0.752156, 0.193774);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 5413.97;
  var_0.atmosfogheightfoghalfplanedistance = 416.519;
  var_0.atmosfogheightfogmaximumoffset = 1860.54;
  var_0.atmosfogheightfogstrengthofdepthfog = 0.307481;
  var_0.atmosfogentityscale = 1;
  var_0.atmosfogairlightcapacity = 0;
  var_0.atmosfogairlightdensityscalar = 1;
  var_0.atmosfogairlightvertexinnermutedradius = 0;
  var_0.atmosfogsplineenabled = 1;
  var_0.atmosfogsplinecustomdistance1 = 2049.48;
  var_0.atmosfogsplinecustomdistance2 = 12167.7;
  var_0.atmosfogsplinecustomdistance3 = 30606.5;
  var_0.atmosfogsplinemaxdistance = 0;
  var_0.atmosfogsplinecustomvisibility1 = 0.0992995;
  var_0.atmosfogsplinecustomvisibility2 = 0.707615;
  var_0.atmosfogsplinecustomvisibility3 = 1;
  var_0.atmosfogsplinemaxdistancevisibility = 1;
  var_0.atmosfogsplineusemaxdistancevisibilityoverride = 0;
  var_0.atmosfogsplinemaxdistancevisibilityoverride = (0, 0, 0);
  var_0.atmosfogsplinecustomtangentsenabled = 0;
  var_0.atmosfogsplinestartingtangentangle = 0;
  var_0.atmosfogsplinecustomtangentangle1 = 0;
  var_0.atmosfogsplinecustomtangentangle2 = 0;
  var_0.atmosfogsplinecustomtangentangle3 = 0;
  var_0.atmosfogsplinemaxdistancetangentangle = 0;
  level.island_fog_on = var_0;
}
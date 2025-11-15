/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_shipment_fog_hdr.gsc
**************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_shipment");
  var_0.startdist = 2048;
  var_0.halfwaydist = 6145;
  var_0.red = 0.742358;
  var_0.green = 0.671204;
  var_0.blue = 0.594049;
  var_0.hdrcolorintensity = 14.4306;
  var_0.maxopacity = 1;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 1;
  var_0.sungreen = 0;
  var_0.sunblue = 0;
  var_0.hdrsuncolorintensity = 1;
  var_0.sundir = (1, 0, 0);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 180;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 0.529689;
  var_0.skyfogminangle = 46.4867;
  var_0.skyfogmaxangle = 78;
  var_0.heightfogenabled = 1;
  var_0.heightfogbaseheight = 14.2465;
  var_0.heightfoghalfplanedistance = 389.981;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.824791, 0.89917, 0.992188);
  var_0.atmosfoghazecolor = (1, 0.948626, 0.900759);
  var_0.atmosfoghazestrength = 0.0078125;
  var_0.atmosfoghazespread = 0.0017878;
  var_0.atmosfogextinctionstrength = 0.485227;
  var_0.atmosfoginscatterstrength = 16.1001;
  var_0.atmosfoghalfplanedistance = 4924.79;
  var_0.atmosfogstartdistance = 1238.67;
  var_0.atmosfogdistancescale = 1.5;
  var_0.atmosfogskydistance = 102876;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = -90;
  var_0.atmosfogskyfalloffanglerange = 118.266;
  var_0.atmosfogsundirection = (0.499181, 0.682027, 0.534469);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = -57.0603;
  var_0.atmosfogheightfoghalfplanedistance = 154.245;
}
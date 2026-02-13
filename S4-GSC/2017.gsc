/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2017.gsc
*************************************************/

init() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level._id_7B25["allies"] = spawnStruct();
  level._id_7B25["axis"] = spawnStruct();
  level._id_BCDC = -61;
  level._id_BCDB = 0;
  level._id_BCD7 = 9;
  level._id_BCDA = 120;
  level._id_BCD9 = -75;
  level._id_BCD8 = 0;
  level._id_BCD6 = 1.2;
  level._id_EF99 = 32;
  level._id_EF96 = 14;
  level._id_EF98 = 192;
  level._id_EF97 = 8;
  level._id_EF95 = 1.65;
  level._id_98CA = "BOTTOM";
  level._id_98C9 = -155;
  level._id_98C8 = 1.6;
}

_id_5E31(var_0) {
  self._id_22B8 = self.fontscale;

  if(isDefined(var_0)) {
    self._id_9C72 = min(var_0, 6.3);
  } else {
    self._id_9C72 = min(self.fontscale * 2, 6.3);
  }

  self._id_7EAA = 2;
  self._id_ACAE = 4;
}

_id_5E30(var_0) {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  self changefontscaleovertime(self._id_7EAA * 0.05);
  self.fontscale = self._id_9C72;
  wait(self._id_7EAA * 0.05);
  self changefontscaleovertime(self._id_ACAE * 0.05);
  self.fontscale = self._id_22B8;
}
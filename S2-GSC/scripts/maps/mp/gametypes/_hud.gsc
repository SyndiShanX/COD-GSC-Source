/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_hud.gsc
**********************************************/

init() {
  level._id_A012 = spawnStruct();
  level._id_A012._id_00C6 = "left";
  level._id_A012._id_01CA = "top";
  level._id_A012.alignx = "left";
  level._id_A012.aligny = "top";
  level._id_A012.x = 0;
  level._id_A012.y = 0;
  level._id_A012._id_01D2 = 0;
  level._id_A012._id_00BD = 0;
  level._id_A012._id_21F6 = [];
  level._id_3DD8 = 12;
  level._id_4F52["allies"] = spawnStruct();
  level._id_4F52["axis"] = spawnStruct();
  level._id_76FF = -61;
  level._id_76FE = 0;
  level._id_76FA = 9;
  level._id_76FD = 120;
  level._id_76FC = -75;
  level._id_76FB = 0;
  level._id_76F9 = 0.6;
  level._id_9868 = 32;
  level._id_9865 = 14;
  level._id_9867 = 192;
  level._id_9866 = 8;
  level._id_9864 = 1.65;
  level.lowetextyalign = "BOTTOM";
  level._id_5F2E = -90;
  level.lowertextfontsize = 1.6;
}

_id_3DDA(var_0) {
  self._id_15FC = self.fontscale;

  if(isDefined(var_0)) {
    self._id_6085 = _min(var_0, 6.3);
  } else {
    self._id_6085 = _min(self.fontscale * 2, 6.3);
  }

  self._id_5136 = 2;
  self._id_6C71 = 4;
}

_id_3DD9(var_0) {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  self changefontscaleovertime(self._id_5136 * 0.05);
  self.fontscale = self._id_6085;
  wait(self._id_5136 * 0.05);
  self changefontscaleovertime(self._id_6C71 * 0.05);
  self.fontscale = self._id_15FC;
}